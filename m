Return-Path: <SRS0=8Fgq=FS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10150C4361B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 03:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB1C122252
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 03:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB1C122252
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FA6489EAC;
	Mon, 14 Dec 2020 03:11:31 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700073.outbound.protection.outlook.com [40.107.70.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 409CC89E1B
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 03:11:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9ui41aBZeJ/fdxcGO8bXDrMPblT3DOmir8rljZYo6NWbovqUs8wrPXYPnMqJpQNNUcakY0AqgLp9nrTcN0nSFa+UAKErU0Jsd/iGbA/F6d7kM2kKc7sMy3w5Ny06nJmHL/x72M7SD1Oa35pdwBDZrcoSutIeoEVIadXeOJALJCtdhcoE567SSZc0CCNi8r5QuTGztsSy9zpa+an75/9zmpjBWXyg3pmvGRLR+Y0vRhWGKLcn/SOJF6hLRow/NzXAzlcS1BFQ+t/0J7Wc4lNDNEYHHHGmVqnhzGeL8G8kA/89VLRKtMjZbw7f55vM1j85S4kWq8AYJyfvaMm/LTXRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3K62+lwJG/WvT7MUftlrXSilnfooYD7uezgIjmpxgM=;
 b=kEPQiVc0nNszuDze+1qfyfgfkDN/fxUhtNMagHCZwBR4mu0mZ5s1NxJvAXGksa7UXQkNgRTEfQvh7TWRxxDNC+sVJlJ3RKgwckFgCdue5cvzWyuN+F6o62Ujbar/ZpqtJ1Zdva+8CFiDDJZXIitvRtBttEQxUGbhCas+ZpuF4T/Fpb7QjCz3rs2DC2ZTcz4Hf7XtgEMlRatq3qOR2bRoSaZZmGiuCnoKX4Zi6eXBplJXUlMtGq0uqoKAgALwFIX3y+Ot6oUR0pCljYT8Kcnlmcc/FOyXpeKJtCBbk58swyP51D6NTnnc+NaTAmqqO8W3ABCbyF7yUU+QWkTFzC9LYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3K62+lwJG/WvT7MUftlrXSilnfooYD7uezgIjmpxgM=;
 b=z/EE3Ow4PCzUtNPJaEQLkElqmrogy72LfnFFszNAEJfi7oXQjr0Gj9kdyrHrPWI9pPL4V0CSJD/XT01MQ6GuDuSPxjhX+EOWHX4+aRfyNxJo5pNm42uyV+mP/1/uLyTkmXKKkBjXJuTR4m500HmmdF8KWqHUgnn1knzXSbkaaaI=
Received: from MWHPR1201CA0004.namprd12.prod.outlook.com
 (2603:10b6:301:4a::14) by MW3PR12MB4427.namprd12.prod.outlook.com
 (2603:10b6:303:52::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Mon, 14 Dec
 2020 03:11:26 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::97) by MWHPR1201CA0004.outlook.office365.com
 (2603:10b6:301:4a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Mon, 14 Dec 2020 03:11:26 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.20 via Frontend Transport; Mon, 14 Dec 2020 03:11:25 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 13 Dec
 2020 21:11:24 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Sun, 13 Dec 2020 21:11:23 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: skip load smu and sdma microcode on sriov for
 SIENNA_CICHLID
Date: Mon, 14 Dec 2020 11:11:21 +0800
Message-ID: <20201214031121.17794-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f452ecc6-79c2-404c-a9a4-08d89fddf138
X-MS-TrafficTypeDiagnostic: MW3PR12MB4427:
X-Microsoft-Antispam-PRVS: <MW3PR12MB442724A4C4161D4BC8FFA7639AC70@MW3PR12MB4427.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: owYFQ2X9ozZkoZZImUMtMF5uJ68F93Bk3lyYGF4MLgCXmmomUc8SAFkxP1UUzvi2krTHvSzIMOmGc6kWQYtrUA63GVUMNjJR+8/UfazA2pKuGmj1PebnPyZfAx54hUbAJeHPd0Q+cIy0uko+oVzbF4x4fYj4tmf0l0gmJB2RFYOPVxSdpuMdRCt8ToOsr8v6ZJmfpN/ZN6k8KcRc04RYh8upw2eOSSRjZ8v2mUi3lUzoehaBAQbQ7PD2v0I+kWAB81LRVHpRauJc9tU7+VaVjXXm3097UkTvXu/s2NsFXzaYPJepsFHXSvh/EeEXZdxJi6uQQPgX2wVEwUnihn5RIFqB10CRT8PbZlsGt8iAuiDY7yqfJlhJoJSr2bo2H60jsV0fStTASPK4TatZNiu0OQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(46966005)(2906002)(83380400001)(426003)(36756003)(4326008)(70206006)(82310400003)(8936002)(508600001)(81166007)(186003)(70586007)(2616005)(8676002)(356005)(54906003)(5660300002)(336012)(26005)(7696005)(47076004)(86362001)(6916009)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2020 03:11:25.4877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f452ecc6-79c2-404c-a9a4-08d89fddf138
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>, Jane.Jian@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

skip load smu and sdma fw on sriov due to smc, sos,
ta and asd fw have been skipped for SIENNA_CICHLID.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c    | 3 +++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 39e17aae655f..87566dee048d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -153,6 +153,9 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
 
+	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_SIENNA_CICHLID))
+		return 0;
+
 	DRM_DEBUG("\n");
 
 	switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index cf999b7a2164..31f05d96586c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -847,7 +847,9 @@ static int smu_sw_init(void *handle)
 	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
 	smu->smu_dpm.requested_dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
 
-	if (!amdgpu_sriov_vf(adev) || (adev->asic_type != CHIP_NAVI12)) {
+	if (!amdgpu_sriov_vf(adev) ||
+			((adev->asic_type != CHIP_NAVI12) &&
+			(adev->asic_type != CHIP_SIENNA_CICHLID))) {
 		ret = smu_init_microcode(smu);
 		if (ret) {
 			dev_err(adev->dev, "Failed to load smu firmware!\n");
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
