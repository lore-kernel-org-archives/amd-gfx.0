Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7111EC4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 09:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3785261052
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 09:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3785261052
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC3FD6ED07;
	Thu, 29 Jul 2021 09:46:34 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2082.outbound.protection.outlook.com [40.107.101.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB9986ED07
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 09:46:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdReM97xi1Mzkw5+ajIPBM3N8Av6ndA6nAzfoPVa7Vk+aU8CLON/mQa/oDqKFH6oMG4LYIJeecgNyxptRfDoyALLB/glzm6tF1SSGfxm4jvkXVFzb2lDkaOGn0zyBLuf80WZ5b1BaO9HpeTU4n82GsGLGUESTJaPpLB1CBNwQKx2Gh1T0J144eOEh/2XHBngWoBMCSpnl8hvPY6kLLaYS+0pAKgFqfMASnktOkaCDSZsxtfSF6xDkThbY1gLUPK9fB7gFQ0YCSLusZWPnuFNMr71Mqe5Ywjs3ogifNIipSgrQZOm47QeSWnElZKiKvZX8Q3fnVFu2aiZADbzy4CaWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQKtGxEHenKx268l5kvsT6fUezBTuyio0rXas+cWDuc=;
 b=Pfe7eeXvaKA5tpMI3W0aK3SW00SrTrv5nUHK5DN+VszfJV2PmwwNTWtdQ1cExvERBfTfQfhg02zahPQN9Fl3z+uVS6qbzrfnI2ejrgrGwUskTZdzCDaFydlT4ma8E5ea/ctN+6dYW366UwS/nnW7qvlKeiEPQaXz6Motm0HQL9lN44Tb0mGc4OGSyImH3XFDFwZ7j8kpHdgvvlUkKdHYy1KhcN4LoxvNRSHEZUHbsoGZLb7/o+KeG3ho49+U1vy8y31C0zJ5gzU/hntcVFn3xOmt/y4zvj5yOqbowqDNkg9/FVUJjXLPJz80kdHVbQqWGNao3DmVg+v1+rdV8HGIBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQKtGxEHenKx268l5kvsT6fUezBTuyio0rXas+cWDuc=;
 b=mqMxw+hA7G1L0kaUcKqY25GiXj2zaffDOHfRZdOnFJzp+V3JuuOv3zJXYFn8ROwbkvYGSkNuUrCr6xYyJHRyDRdoB5tQbfr7VqFqLBUhawXFc4YIZN56x/LwvySqn6V/BMzHkgGvBU5f8TYVGuCD7O/j5Z3jtwoQUvVPHgA3P6k=
Received: from DS7PR03CA0088.namprd03.prod.outlook.com (2603:10b6:5:3bb::33)
 by BL0PR12MB4946.namprd12.prod.outlook.com (2603:10b6:208:1c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Thu, 29 Jul
 2021 09:46:30 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::3c) by DS7PR03CA0088.outlook.office365.com
 (2603:10b6:5:3bb::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Thu, 29 Jul 2021 09:46:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 09:46:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 04:46:30 -0500
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Thu, 29 Jul 2021 04:46:29 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4] drm/amdgpu: fix the doorbell missing when in CGPG issue
 for renoir.
Date: Thu, 29 Jul 2021 17:46:27 +0800
Message-ID: <20210729094627.2595196-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2abb54c2-691f-41b0-1af7-08d95275be52
X-MS-TrafficTypeDiagnostic: BL0PR12MB4946:
X-Microsoft-Antispam-PRVS: <BL0PR12MB494684C8B3CE69F55A05C09CC1EB9@BL0PR12MB4946.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fWl0LCNOsy7SoartruXk/9RhMc5DCu4o4tCgdwb8tgLe5iZUpfjS5xFPfI2mXKwkqr5lRnUB9WZI73y3IdHdga25o7iZzj0Xq2SeXTstYEgTpDC5BidBGmtuxhHISN/m4NxEcWxNtMKHayBmvJ/IvnXbUgiAnIAozkkXnSCoEuZEpxiLlz4wHWlqjTvSjSDVNr9sFhlBIkwAIdi1cavkHNaxfVP2k2siTTL/pfuInUwW1FN1CtnftjLzgkOnAT84dzAhnLcHbUfKBBcRxNWgB1NYExElz75wxFDOiHwxVdeC+fqra+ArC2SaAP7sj9nRL0txWyRPhccS2lYaKjwhDjVaUEHyfHNxN7D52J3FH1tkTH06IIxQ7Wd6k1DeLhyTyuovxcmXD2iSiDXu/D04EhM+y4YxiiO52VRfhAadwPf8R1mwBFqIlrO6MtAOrBDKU7iRLvAkXyQp/iW5qs36WDII9lE3rPdGfEj17x+vhiOtweNxe7hy4qwFjUfou4g3gPGySI0axTEKmPkMbJ20NaWl6ml6SACNnCiTks7eIjVhzxTf+uDmPc+Oc3KPRq0cIvNN5eAgkVGYzXKJUFfVuITnDqjB6M2Qag9CKVLhmfE8RAiPfmuIU2rf+uMO8PRyTYOzL3l/wn54GsmOKYamxVkoZvBvQ6JID4lF7fpHpI0cyjI4nuipzSwgfXUu0e1jXMx9Istz7QgAvr7gomGSkwVvu35BosS7Bze6ttK4TwI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(36840700001)(46966006)(82740400003)(36860700001)(47076005)(356005)(8936002)(6916009)(70206006)(4326008)(36756003)(86362001)(336012)(2616005)(5660300002)(426003)(316002)(83380400001)(70586007)(7696005)(478600001)(82310400003)(1076003)(81166007)(26005)(2906002)(8676002)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 09:46:30.6579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abb54c2-691f-41b0-1af7-08d95275be52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4946
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 03acc777adf7..ab79ca770dcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1295,6 +1295,16 @@ static bool is_raven_kicker(struct amdgpu_device *adev)
 		return false;
 }
 
+static bool check_if_enlarge_doorbell_range(struct amdgpu_device *adev)
+{
+	if ((adev->asic_type == CHIP_RENOIR) &&
+	    (adev->gfx.me_fw_version >= 0x000000a5) &&
+	    (adev->gfx.me_feature_version >= 52))
+		return true;
+	else
+		return false;
+}
+
 static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
 {
 	if (gfx_v9_0_should_disable_gfxoff(adev->pdev))
@@ -3675,7 +3685,16 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
 	if (ring->use_doorbell) {
 		WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
 					(adev->doorbell_index.kiq * 2) << 2);
-		WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
+		/* If GC has entered CGPG, ringing doorbell > first page
+		 * doesn't wakeup GC. Enlarge CP_MEC_DOORBELL_RANGE_UPPER to
+		 * workaround this issue. And this change has to align with firmware
+		 * update.
+		 */
+		if (check_if_enlarge_doorbell_range(adev))
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
