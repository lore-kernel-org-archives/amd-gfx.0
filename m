Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A74DC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 07:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B92360F6F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 07:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B92360F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE3DB6E0C4;
	Thu, 29 Jul 2021 07:55:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C3536E0C4
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 07:55:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzBFYdlKdWPba+LGu8qofGmAr6Gxj1afAaE8AZIycQn1CvpytsuI/nowPk0+tWibd7p7U9r9dPYdwcalu5k+uLrP7WqciWy3ekAdTW1njrR10quaNTMem9bD47pdfLWUQZcg7Y79f9omhxx4yc3PuliTk0rYv2+3kAjeEizIqNun9B99A9/hZVSIB3ixxbPjWX1M3mNSSz/8xmB8FOGrrvD+v01UnwivE0f5x9+YxXBn+55fJNxA/GPTo9h9P2wYy8QRbkth/+rCz1yQ765YBYyO3/csjHokMj23jimEODPxbdaDR9XEqziO47bT260NN9eq6B1McxF9hQc3FG5Suw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mgu8IJ6iTv6zNIpcR+mPgcQxqIPbLkzcoOvLc1dQ2s=;
 b=RAhulr/y0/14/QYI7/Aogq+YVfUeiLEiNR+aBiIAgxBptLdj4uFiN7yxQV3IGpqjE/UqE8Zh+OL6JQlOef9jxjmezTrNnheqmnCqOUyyI0DE8CGbGvA11WONQffnhjKn4/mYPhm8vikimK9LMjIUnDeknnatBwgDxziEPtmVDbt1e7stE5UKNTX8k4XapIBIgUDhP9v2LyLP1vz9DdEAtM5Qx1daxJwxlfVP1214I/BmOQTYwtmMu13jCSahY26ZsA7hpWDSahK+VhcnOVhVsJbSZaSt1l1PBCnLFqOHEmr3m2Ff1Jnp+ZSHQRlV1oLSUFkELuAs7wHAdpz2r+LhNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mgu8IJ6iTv6zNIpcR+mPgcQxqIPbLkzcoOvLc1dQ2s=;
 b=jzvQ5oT/5t+suxFZz6dJZN8LjtbrFzxcOsw30iFDES3JVrnVrLcfTmhdVgLhoJlxmM3KZ2coyQpvUJaGs2v1SeiFO9bkJbM8Qw0kBmtwkkvjeOjVbdAdkoIRVYouiX0xeCBZiL5+ggrk62TFZC5JDhOque0NjHfooE7QSE9SsQI=
Received: from DM3PR08CA0001.namprd08.prod.outlook.com (2603:10b6:0:52::11) by
 BL0PR12MB2372.namprd12.prod.outlook.com (2603:10b6:207:4d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Thu, 29 Jul 2021 07:55:28 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::ac) by DM3PR08CA0001.outlook.office365.com
 (2603:10b6:0:52::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Thu, 29 Jul 2021 07:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 07:55:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 02:55:27 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 02:55:27 -0500
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Thu, 29 Jul 2021 02:55:26 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: fix the doorbell missing when in CGPG issue
 for renoir.
Date: Thu, 29 Jul 2021 15:55:23 +0800
Message-ID: <20210729075523.2557382-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed5fd31a-c0d5-4f90-dc7b-08d952663b30
X-MS-TrafficTypeDiagnostic: BL0PR12MB2372:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2372014B8F87C3CD919E4730C1EB9@BL0PR12MB2372.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZKern/ts2DPTw2r0VKWUBsPdZj9kdFIBga7yNiHXLm+FMLbZrvtmN0E0jyr1cr5RKeY4dOCn903L2bXff98FTqGayDwOlF1pv66azrsMtU1wu2cwZKy3hyLzDz0F19OpI/i2vOqgLCJrEneBUY5tidlF5npg722J1E4qivKzQDFCYb9P/VexXXTVKJsG+BiYJ+R2a1C9ZdiZgWEM1Cb0iSiueBUE9ywA2nZOPON44kWnwQU3w98Mwn4aCMqZGsYzuPsLFlqhdAVfF5br2nTi60yiY5CmYORqytyrrBJnpTfe71ffk4ZpqVERlLa4gei57c47JwA2q6xzQ8ylkHIIxz6W4r1nSs8zzoPPqlLPMdg5Kp4QrGri6YM7RwmnuFaik0ivTz8RsmU2H4fwphDNDESLLjlDGVegcXO4jp0CMERvutcGBMvPIm/tr7boEdu2/55J/rntxoUyw+/fS5TMGyAF6T7qugLken9fxGPUlJxr8mpJIqxr8D9t+6nTheVs1UuwioN8AcUYNOIbYWBA9BSR6ka9+YhbR1E9lWwycWGcQQQecae4jlguzG8a1sNtbQSV6ZVNOPGMz1gORoV0Mw+57ILsa9O6N7/NSsUJWEfW9wWgTumWDCfgKYAZ19qC95CC7eUxJ8CxmABrK5R2sSOCMlKJsBa/ooEgSAwCMIP7zu9ltT/zg6kOyPJUpIstOu7w9O2KayQNR89Bwr9+HaRHuYvqaxhRSCa8lmRY8/o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966006)(36840700001)(83380400001)(8936002)(336012)(478600001)(6916009)(26005)(356005)(316002)(36860700001)(8676002)(81166007)(70206006)(47076005)(82740400003)(186003)(70586007)(2906002)(6666004)(82310400003)(2616005)(1076003)(7696005)(36756003)(4326008)(426003)(86362001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 07:55:28.1916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5fd31a-c0d5-4f90-dc7b-08d952663b30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2372
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Yifan Zhang <yifan1.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If GC has entered CGPG, ringing doorbell > first page doesn't wakeup GC.
Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround this issue.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 03acc777adf7..a35f1d041a85 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3675,7 +3675,18 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
 	if (ring->use_doorbell) {
 		WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
 					(adev->doorbell_index.kiq * 2) << 2);
-		WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
+		/* In renoir, if GC has entered CGPG, ringing doorbell > first page
+		 * doesn't wakeup GC. Enlarge CP_MEC_DOORBELL_RANGE_UPPER to
+		 * workaround this issue. And this change has to align with firmware
+		 * update.
+		 */
+		if ((adev->asic_type == CHIP_RENOIR) &&
+		    (adev->gfx.me_fw_version >= 0x000000a5) &&
+		    (adev->gfx.me_feature_version >= 52))
+			WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
+					(adev->doorbell.size - 4));
+		else
+			WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
 					(adev->doorbell_index.userqueue_end * 2) << 2);
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
