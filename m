Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54FEC43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 12:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50F9D2072B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 12:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DcuoXFzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F9D2072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C804E6E2E4;
	Wed, 18 Dec 2019 12:14:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DE296E2E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 12:14:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkAUjZZ1+o9SFn1IWnArD6/NqDLUXw8mOco2DMb+SXAXRptu6u5nrtM3/AMUmT8X7QuQ0jeAFlCvjUIHXcp4QV2BDaDvJc2PPPL9pZ4WpM0CwJEL7PcSeb7U3fmmmmqXJo7vU1HCEHnLP9DXUfgAePakfwIG9ff9jz2OdJnoS0Ny8NACEDfwLYMjc9gGjYstlXrT4pmYZYVYWUa802SblEYqqzCfFU1XptK1+8XfnkhYJtZZuA9fRAHMAl0Xgyrdf5u1geEpE5BMFCyQSuuxUTIPDOolZQ07WEP1hvkm5Ra7FX7uFQfu61XHCzKnIKmYF/4ZS5JySmtaCXJ+EakB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1tTraljLYvvce26JhC8eu+85LyuepRWpzxaK5LU4bI=;
 b=aJeHmx5dQZEARqfS4DtEEkPzn/RLR2+rQA5YW9IVw2+wjbYB74+3yiHZhBSUIGyUDBiwzaD/Bz99rm/rl/F+/C+b+eiv85xCBUKpQtqmcFa7sRDQHwi5w61nzjRVV2G/hK2jKLN9VRfJOyQ7c8svM/5rY1AD7PfGr3PRwFuJ3G+lrs8ZmmAlZDvcyGwcwwY4vKIUvbmtOqpw3pq63b0WSiJs81ifyF8+LXNeZRXFIBczZTZi3RHV1z1+wAAx3tdEEM45ueWwwsIKifgZT6t/BFrUjk+/7hU8RIAFop0iXXcRGO1qlLe7LuttmmvYSCnkB9CQAk25Ah0pCEKnqy/pxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1tTraljLYvvce26JhC8eu+85LyuepRWpzxaK5LU4bI=;
 b=DcuoXFzs51XUXWEb7GREOYdhwSZqWWA89BQlPB3zsV7AAoYJ/ENmg+t9UhI6jOmJm/Q6nUNO0R8e0HmErjGMSeR5GpZNaxAlvqQBQaygyE1zed6QcxyZuXWVypLO/r1d6QJhPP3DYcjbUhC5MClrxciMeaCoAZWn8zj/W7QfOI0=
Received: from MN2PR12CA0011.namprd12.prod.outlook.com (2603:10b6:208:a8::24)
 by BYAPR12MB3576.namprd12.prod.outlook.com (2603:10b6:a03:d8::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.16; Wed, 18 Dec
 2019 12:14:12 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::202) by MN2PR12CA0011.outlook.office365.com
 (2603:10b6:208:a8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.16 via Frontend
 Transport; Wed, 18 Dec 2019 12:14:11 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2538.14 via Frontend Transport; Wed, 18 Dec 2019 12:14:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 18 Dec
 2019 06:14:09 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 18 Dec
 2019 06:14:09 -0600
Received: from vbox-debug.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 18 Dec 2019 06:14:08 -0600
From: Frank.Min <Frank.Min@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: enable xgmi init for sriov use case
Date: Wed, 18 Dec 2019 20:13:27 +0800
Message-ID: <20191218121328.31759-1-Frank.Min@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(376002)(428003)(189003)(199004)(186003)(8936002)(81156014)(26005)(8676002)(5660300002)(1076003)(316002)(4326008)(81166006)(426003)(70586007)(70206006)(2906002)(478600001)(356004)(2616005)(6916009)(6666004)(336012)(36756003)(7696005)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3576; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69bc4e62-b5b2-4fb3-37ea-08d783b3c9f3
X-MS-TrafficTypeDiagnostic: BYAPR12MB3576:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3576D3F1C92BD4AF823E8849E9530@BYAPR12MB3576.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0255DF69B9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XfNdMQ7/oF5g5cuVyDrDWOOmfvMe5EuRP3gYFDGW19CfHfs5BC1vQT/UGZomPZ06/8LxShYNEMsABSfPvgWMGh2GG7AlyA5oSQ6ZVx0/4igqocVardmqRtX1FuSK4x71KtvKJQN4IfqWnU6kZhs7pnH/X3L3qsOJz2rW8HkKgGvib+C+X71XjalfYt1TAzSsLs/fw7tC1npPp4ICR8cbv4ZMv8cBwifuyohc/LfNApFdYYicV9F9JYVpWD/FByOA6BJMgSqK3BEeo1XWCwoXfz2B6jW93We+fI/ndHjXCKjrDB9iJo1g3eawPMZgUyfX/GZDwsKVBbHShwKNW7/4m3ux2gF1CGWi2Fs7Ew9byIetyWrNZqCAXvKjChOP0Eah6fdfp/rxBhYXQ2rD0YTyj4gmI/D2Pgsauss5AJiLraA6lx32I7Y93aga/VIHFzKg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2019 12:14:10.5928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bc4e62-b5b2-4fb3-37ea-08d783b3c9f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3576
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
Cc: "Frank.Min" <Frank.Min@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. enable xgmi ta initialization for sriov
2. enable xgmi initialization for sriov

Change-Id: I0b333ede6933381debba6b6d61d986c897c32a2b
Signed-off-by: Frank.Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 26 +++++++------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 3e293a3c2fbf..8469834d90ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -466,8 +466,6 @@ static int psp_xgmi_load(struct psp_context *psp)
 	/*
 	 * TODO: bypass the loading in sriov for now
 	 */
-	if (amdgpu_sriov_vf(psp->adev))
-		return 0;
 
 	cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
 	if (!cmd)
@@ -508,8 +506,6 @@ static int psp_xgmi_unload(struct psp_context *psp)
 	/*
 	 * TODO: bypass the unloading in sriov for now
 	 */
-	if (amdgpu_sriov_vf(psp->adev))
-		return 0;
 
 	cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
 	if (!cmd)
@@ -540,11 +536,6 @@ int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 	int ret;
 	struct psp_gfx_cmd_resp *cmd;
 
-	/*
-	 * TODO: bypass the loading in sriov for now
-	*/
-	if (amdgpu_sriov_vf(psp->adev))
-		return 0;
 
 	cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
 	if (!cmd)
@@ -1506,16 +1497,13 @@ static int psp_load_fw(struct amdgpu_device *adev)
 	if (!psp->cmd)
 		return -ENOMEM;
 
-	/* this fw pri bo is not used under SRIOV */
-	if (!amdgpu_sriov_vf(psp->adev)) {
-		ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
-					      AMDGPU_GEM_DOMAIN_GTT,
-					      &psp->fw_pri_bo,
-					      &psp->fw_pri_mc_addr,
-					      &psp->fw_pri_buf);
-		if (ret)
-			goto failed;
-	}
+	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
+					AMDGPU_GEM_DOMAIN_GTT,
+					&psp->fw_pri_bo,
+					&psp->fw_pri_mc_addr,
+					&psp->fw_pri_buf);
+	if (ret)
+		goto failed;
 
 	ret = amdgpu_bo_create_kernel(adev, PSP_FENCE_BUFFER_SIZE, PAGE_SIZE,
 					AMDGPU_GEM_DOMAIN_VRAM,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
