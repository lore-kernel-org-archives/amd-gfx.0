Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA32C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 05:37:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D92B120792
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 05:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TYIAffTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92B120792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77A8A6E17A;
	Tue, 28 Jul 2020 05:37:17 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680072.outbound.protection.outlook.com [40.107.68.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BD636E17A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 05:37:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKu8g+MzZ/3KgE2WSY5U5dWADWe6Kk2raD121K7MAK27aZz6NofNJ2RVmuGTDdzAvQnBeTBLNulLfBIZSkasKcLFVdR+nnio35tfarhLrZBrWcCgBVu9pPwBXLokAFzPvmrFrQIG3xzlKHagCIt93rwUim+x2TPlB+mTrtGn3NTgeZ6EZd1Kib2+8t62HjhLlpil0HQ3qks606YELEBRabj+QcRpmFfyD/xWoIPRehRNl7nUBV4b4Gb4fKphx2WGK0MPNkDIYgopN9zH4M1a8eOV+u+cAzu/hwrxsRJs74XrHKiMphaexlu0MH3adKdeJwdKCdKazOqYx6nyvEK+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lgu4xrIXv6MDgNxaWDzeZV+b2nby3qSc9N1FpesLI/Y=;
 b=TQyXelO4Pchlx3Fs3I47AwrKhxUGuQei3Bc0m7Wirm0BpC6e3vTpzNvlTdneRXKR/vokMe3noxUVt3esc5z5jD66Oa6HaMBkQFVZ0+JpWrhwRQaDbosGOKtmbhqmR7xz4GcvrQtqF1T1tjdPJIXJrAWZEB2yNkiOeiQTmVIlP3KpPA5NqocJwEhO22tkRCX/LQ4B/v8JYLfxSeNECk6/HdN6/1OCcJE0wkAvSgd8maNZRMDJqKTe5CcRFM18voXvGqjqv63unqOT8QDUdAJFwWL3XN5yDvdudEY80vRXmcLmMxAAGqwHHLWB+V1AOvuF963j3rvXJDwb1FeD4qsRJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lgu4xrIXv6MDgNxaWDzeZV+b2nby3qSc9N1FpesLI/Y=;
 b=TYIAffTRiDs8PJJID9qAl9txn3WbL7AWfll0VID4GVp11I1M5g1y0ejzFOxz2GZv9UTxL0wkd7mV9ykpMeX3R70uLEa8Fs0Jfbg9hG0YbZTch0nhXUMkirfdmVIZGaUR+cz2HxPc21WcOgkbEmH62tX8vTzn9RXNj9g9IKUw2z4=
Received: from DM6PR11CA0019.namprd11.prod.outlook.com (2603:10b6:5:190::32)
 by DM5PR12MB1273.namprd12.prod.outlook.com (2603:10b6:3:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 05:37:14 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190::4) by DM6PR11CA0019.outlook.office365.com
 (2603:10b6:5:190::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22 via Frontend
 Transport; Tue, 28 Jul 2020 05:37:14 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Tue, 28 Jul 2020 05:37:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jul
 2020 00:37:12 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jul
 2020 00:37:12 -0500
Received: from chengzhe-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 28 Jul 2020 00:37:09 -0500
From: Liu ChengZhe <ChengZhe.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm amdgpu: Skip tmr load for SRIOV
Date: Tue, 28 Jul 2020 13:36:47 +0800
Message-ID: <20200728053647.415062-1-ChengZhe.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44c9c5ef-f071-4179-ff96-08d832b847e1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1273:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1273183C00D14F19CDB5C70393730@DM5PR12MB1273.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sIATwgIvZs45WJX5bGVAYyuiinUvbohf/KiRGs4Q3CjOOFpuaiP+L76jkco5DZDfUludb5vNiQlI+/rN4rysvO4oLJ1cvU2QO/uBmMugpx01d3AC0q3Yueg7B/ul5makQUAfczwKiS6hHMqSY4hcCmByKm/JxkEbLlVbVPp35H5MH8jVy5h0km6Tf1FU0/65QE88tAWMUPMvPfIFVL+kQQuqVseCgLw9qX9QnMCmIv/+GQW/u7bsjYlE5SlWw6VVP+EhuvsRDxvfFDoVESrrepd/IaR8MFdHbRmnN5B2kTxhhYuvD4LZWqQBT1nAdLeWiTPGT6iklvyuYfxD6YELj8GYfe5kvD9CMGgOsFdYvu7yYyJhUr4Pt0+6AkDaZ0kUSgINAX5M0cKni+aas48UDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966005)(4326008)(47076004)(478600001)(2906002)(26005)(356005)(8676002)(1076003)(8936002)(82310400002)(316002)(2616005)(5660300002)(70586007)(70206006)(36756003)(54906003)(82740400003)(81166007)(6666004)(6916009)(336012)(86362001)(83380400001)(426003)(186003)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 05:37:13.3460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c9c5ef-f071-4179-ff96-08d832b847e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1273
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei
 Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Liu ChengZhe <ChengZhe.Liu@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

    1. For Navi12, CHIP_SIENNA_CICHLID, skip tmr load operation;
    2. Check pointer before release firmware.

    v2: use CHIP_SIENNA_CICHLID instead
    v3: remove local "bool ret"; fix grammer issue
    v4: use my name instead of "root"

Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 35 ++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a053b7af0680..7f18286a0cc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -193,12 +193,18 @@ static int psp_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	psp_memory_training_fini(&adev->psp);
-	release_firmware(adev->psp.sos_fw);
-	adev->psp.sos_fw = NULL;
-	release_firmware(adev->psp.asd_fw);
-	adev->psp.asd_fw = NULL;
-	release_firmware(adev->psp.ta_fw);
-	adev->psp.ta_fw = NULL;
+	if (adev->psp.sos_fw) {
+		release_firmware(adev->psp.sos_fw);
+		adev->psp.sos_fw = NULL;
+	}
+	if (adev->psp.asd_fw) {
+		release_firmware(adev->psp.asd_fw);
+		adev->psp.asd_fw = NULL;
+	}
+	if (adev->psp.ta_fw) {
+		release_firmware(adev->psp.ta_fw);
+		adev->psp.ta_fw = NULL;
+	}
 
 	if (adev->asic_type == CHIP_NAVI10)
 		psp_sysfs_fini(adev);
@@ -409,11 +415,28 @@ static int psp_clear_vf_fw(struct psp_context *psp)
 	return ret;
 }
 
+static bool psp_skip_tmr(struct psp_context *psp)
+{
+	switch (psp->adev->asic_type) {
+	case CHIP_NAVI12:
+	case CHIP_SIENNA_CICHLID:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int psp_tmr_load(struct psp_context *psp)
 {
 	int ret;
 	struct psp_gfx_cmd_resp *cmd;
 
+	/* for Navi12 and CHIP_SIENNA_CICHLID SRIOV, do not set up TMR
+	 * (already setup by host driver)
+	 */
+	if (amdgpu_sriov_vf(psp->adev) && psp_skip_tmr(psp))
+		return 0;
+
 	cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
 	if (!cmd)
 		return -ENOMEM;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
