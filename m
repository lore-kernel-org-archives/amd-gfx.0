Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA20C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 09:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C279561166
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 09:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C279561166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72B016E462;
	Wed, 14 Apr 2021 09:04:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A6DA6E462
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 09:04:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTBX01EIK1iLRfLavRj4tVhnL5zhXFi31/gZ1BuVxjhLgmw5Li2+9egh4g3B7eW6GlrnpJRBoVgELfKT+3veE0OFc+vFD74BkrpMMtorg71SSMp6cKnaIaPvQjlMLn3D75NTYQSjsz0dXE96Rj4dTLUeOGamIXbn2+xTs7fZpFWDIE7T7dIN6x/xxPNTXKs8LCCDa/64mj03U8/yA+mqnYrV0nJeOTOYDbIJDPpvwmGP09Jk7oI+p7ecQOdzl8bmsp4PDFZzG+JpFoKAmaC4syQC4BXuSymCLZn6vcAuMwFvbw7mnAtN8yKMnMtC+oDZKwD0FtBdMCqRF1tduGqBYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFeaacvVyRH3AngzjPOyaivOcCd9ELIm6VbyfCyQVOQ=;
 b=kLbQq9y3sd1QJFdRHgqph84wZHFg7tD1KodYzwgLQnMNj/B21qEdxt0ltvDbUXAqsw6yVWTAbFhetLbiEx+uNPSd2EMckCRCneNBgz9GsZpG+c7CdJ4qImEkiYTx0DacwRsPc3GdtBti64Lb6mEZgRJmIbio/iQeA6l3HJYJgLortV5M6aeXoRln8OfmpBMsgl2IA5v+TsSaN4bUuY3o+9/e0t/yeN2lzl5GhmsqFrhPXo8USB5Tkci+4K7mGM4YIjodMVG7I0jP2HT9aO0kB9IFllZoFI595eR7Kg/srBJT2Qm1LcMrfLTvxrAc6hlcbPM5nWnIns/ypeWqVUMH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFeaacvVyRH3AngzjPOyaivOcCd9ELIm6VbyfCyQVOQ=;
 b=ELmCwxZyS2WKdSL41r1/OWqbY3fccYFAHSlmfPvW9bfQEegq4+TnRYncRqGoDmARfgpZ5VKQHUoycsYxruEqgitxzvqcUVEmRUQPK7ZnxVpbSo+UaJ+VtLazqXy3a1wG3+fpbjdRUHcFWRsK2U5BWIC3UMGn3Eyv+kwMzI+vr48=
Received: from BN9PR03CA0294.namprd03.prod.outlook.com (2603:10b6:408:f5::29)
 by MW2PR12MB2491.namprd12.prod.outlook.com (2603:10b6:907:f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Wed, 14 Apr
 2021 09:04:00 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::da) by BN9PR03CA0294.outlook.office365.com
 (2603:10b6:408:f5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Wed, 14 Apr 2021 09:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.16 via Frontend Transport; Wed, 14 Apr 2021 09:03:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 14 Apr
 2021 04:03:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 14 Apr
 2021 04:03:59 -0500
Received: from ubuntuBBNew.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 14 Apr 2021 04:03:57 -0500
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Stanley.Yang@amd.com>,
 <john.clements@amd.com>, <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/sriov no need to config GECC for sriov
Date: Wed, 14 Apr 2021 17:03:55 +0800
Message-ID: <20210414090355.737034-1-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bdebefb-c767-4584-682a-08d8ff243e11
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2491F48EE5039D9E3B34C485BB4E9@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hPWV3PfZI/6q+pmaj/wpe7QeS62gUpQMsMH/VPdWxBui/38WhMi+1FkrWjSDWFVyvkyg3fqVG0txMoNNuHRfqJkSdICQlPAOA+B7uZCACFg6WjmljrZd5cYYeIPM8XchpUFtBL/96bSAUZehTriZj54hbXS+9NrE1yUWfwgJRCDTTwQtWdGNW4iveQAdAL+Wc4KYQzbFko2WsDF0lq4NlGWNyH2VpbZOy690+IU2zJE70z6sDMKr9aQQWnlL9t9BA8QoZHFiJ/Z4+QnIpBYc5x2MeEVDruT1dQ51hTiTht0ip/e/AEJBc6hfPwa3t3LKhav5ASbj9XJ2p117dGK3R/5FIycp1jJ1rXY8S41hbBZXb22CShd9CKo6yowjNqSiZcVjA+4B06U40aKe6wj8lwOeygqwX8hz9F6Knhph6RviVW097sJBaAQ3m0QSmFCAuUV9obJzJClMlyhxUmAC1SsaXRYKYQpgRLQz8DQWu46rpDL/geS7R8GLhQdKrmEehZJu1/tj0Av+EjnpWspeJiDa3+LRju8P1kPlAMHHqlfSzXkWHg4gYzFW7KJqt20Lf6L/ngRpdksS8/O/HQIqdp/dclgTYxhtlxdF+pkO6GUD5srY7KZyH7TkRH+e+UhDlFaHNXITewStNY0r1cB99KFvo6wSVFZEo3D66W+ILQwPM+pgXrGIuWMxUYc+HTNi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(46966006)(36840700001)(81166007)(36860700001)(86362001)(8936002)(2616005)(7696005)(26005)(4744005)(426003)(110136005)(83380400001)(478600001)(70206006)(36756003)(6636002)(82740400003)(5660300002)(70586007)(186003)(4326008)(82310400003)(316002)(1076003)(336012)(8676002)(2906002)(356005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 09:03:59.7609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdebefb-c767-4584-682a-08d8ff243e11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
Cc: Jack Zhang <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No need to config GECC feature here for sriov
Leave the host drvier to do the configuration job.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 123ab3156f5a..7bdf93716fbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -567,7 +567,7 @@ static int psp_boot_config_set(struct amdgpu_device *adev)
 	struct psp_context *psp = &adev->psp;
 	struct psp_gfx_cmd_resp *cmd = psp->cmd;
 
-	if (adev->asic_type != CHIP_SIENNA_CICHLID)
+	if (adev->asic_type != CHIP_SIENNA_CICHLID || amdgpu_sriov_vf(adev))
 		return 0;
 
 	memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp));
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
