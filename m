Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA8FC2D0C2
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 09:48:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7C321734
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 09:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zQ+i7iHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7C321734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CA346E1B1;
	Fri,  3 Jan 2020 09:48:57 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690042.outbound.protection.outlook.com [40.107.69.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AED1F6E1B1
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 09:48:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDlsoPsyvkX7TPfvmAfF+NR0KvN0QaZC5l3tEU3JcjMXM6YblpQ6VOJ9lImdjz97jFCeTwZ3SZ9FQ0+zSUFDxDf1Wh6BE6BzS93D6QmksV83Tm/AlGY8s5sL6bjRbMnf6NHUheM2GJY7XCERhJPnXXz+0kLuNkBQ/cQ67kIV0Mb0YTOC31OfO+XleGP7kkM6tlfJQ6qadnF6wCVhDNq3I7tFIgirj3VUvKNnlZkxIGbtA2pGgX5E8RnkiAHDAnS8l5k6Dp6h1cEtMyDvJlXjsUShV/EnCYdMP6VGYJYToj2sRyiK3ZxQ7L0W5PZIySrZIbfl/4Li62Kjc6M6JaPeDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DV2uj2Y9g/83OWtTawCr3lPE0cToUEqEG7wlCgXdK1c=;
 b=DQElgWMdVPFSMn4wPDLwUfLO+S3v/1PXv5HE11wRh7nBahLmPWSAp5Zcd0s7M3Gz3ox3+iIMg2NicXxbf7TCDQoNRc8BX0k5ExA8dlIZn1iR/YYKu5KL6h8ijXyQj0f+7hC6yFWqC95Byw05biTbk8lZ1Gpw8B9iT8xtpjTmMmvEbkjWOkdD89GFE3Urzn0I5Li3TypQ7LKknNfbOcZBxMkQIkcnB3idica1LMQbNYPHUQwKjPGOIus+dDJdVknmoBZAUEyMAVIfeLH/dfVFTPWcdNyr3bfmjXbmu9BfJszXfIG8CQ80wZDzNyJV6HL5smtwpA1vG4fltqZGRQIxCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DV2uj2Y9g/83OWtTawCr3lPE0cToUEqEG7wlCgXdK1c=;
 b=zQ+i7iHWMdXbfSM/TaBA5zN0dOHtPnpFZVnsoEx4XeirMqnmoebiIee78f62L66d25wkFnikN1fS5AA2/pnMezGZKefrUO8fdTGoZNcUMGappElXgQE3fizn9ZseyTOQ5s3hSiur1CU6xntcbv5hRhtYjSSYoxXZXuU9+oxWh1M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3182.namprd12.prod.outlook.com (20.179.83.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Fri, 3 Jan 2020 09:48:55 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2602.012; Fri, 3 Jan 2020
 09:48:55 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: refine code to support no-dpm case
Date: Fri,  3 Jan 2020 17:48:36 +0800
Message-Id: <20200103094836.32505-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.1
X-ClientProxiedBy: HK2PR02CA0165.apcprd02.prod.outlook.com
 (2603:1096:201:1f::25) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR02CA0165.apcprd02.prod.outlook.com (2603:1096:201:1f::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12 via Frontend Transport; Fri, 3 Jan 2020 09:48:54 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 82bd09d8-a7c1-48f6-5166-08d7903225b0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3182:|MN2PR12MB3182:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3182355B7083FC7B83A23865E4230@MN2PR12MB3182.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-Forefront-PRVS: 0271483E06
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(199004)(189003)(478600001)(6486002)(956004)(8936002)(36756003)(6916009)(26005)(186003)(16526019)(52116002)(7696005)(2906002)(2616005)(4326008)(5660300002)(44832011)(66946007)(86362001)(1076003)(6666004)(66476007)(66556008)(81156014)(316002)(8676002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3182;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1G2EMqR0Fdj5KMi52N0mW383tqx8+nYDrV4RTX3MVdfPWtiqQnAoDyEi6BhkOwItNREdZXgf/IY4zgqEvha2grLPZ/A6OvddSL35XW/go3YrN5pj33w1a9eq/B/5ImTL0KR5lWOZaI43xgVmDuAhhxMJ7pmQWrYxkRm3ey63f0NZMvlqkvqq97putSXeY6B7nMSDwmgdwmdQbcv28VTFW1VEwic5AZHywmbu4LPB/dRyqI8EEx+bxrJAahY35j+QwLJj1W1umrxWyKAr+VMBI1FvGWXVhJIOfhkYSisdKk5w0EL/3gVkrir8zl9++78hZz1nXkysmHWBxjBbUGi7DwN1faLJTIunkrHdWhFjIGQP82K3r5DQNXbdMFVKta22smFr+vk88jFm1MSeJ3ec8+Za2h/LSRL4AHQ/hb2n4AiCTamgRN2tEUcNdpnn8iip
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82bd09d8-a7c1-48f6-5166-08d7903225b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2020 09:48:55.3799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3K7agdquuILGglo+8kVT74dGKK+1ISxWVahnyBPNyClWlfgyiXSyg2xH0cG99KN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3182
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With "dpm=0", there will be no DPM enabled. The code
needs to be refined to support this.

Change-Id: Ief1561e69a24472135e0499073a27ea5fd8174e2
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c |  5 ++++-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  6 ++++++
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  | 10 ++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
index 7293763d524c..c195575366a3 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -927,9 +927,12 @@ static int pp_dpm_set_mp1_state(void *handle, enum pp_mp1_state mp1_state)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en)
+	if (!hwmgr)
 		return -EINVAL;
 
+	if (!hwmgr->pm_en)
+		return 0;
+
 	if (hwmgr->hwmgr_func->set_mp1_state)
 		return hwmgr->hwmgr_func->set_mp1_state(hwmgr, mp1_state);
 
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 96e3f0ee64d8..a56ebcc4e3c7 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1364,6 +1364,9 @@ static int smu_hw_fini(void *handle)
 		smu_powergate_jpeg(&adev->smu, true);
 	}
 
+	if (!smu->pm_enabled)
+		return 0;
+
 	if (!amdgpu_sriov_vf(adev)){
 		ret = smu_stop_thermal_control(smu);
 		if (ret) {
@@ -1448,6 +1451,9 @@ static int smu_suspend(void *handle)
 	struct smu_context *smu = &adev->smu;
 	bool baco_feature_is_enabled = false;
 
+	if (!smu->pm_enabled)
+		return 0;
+
 	if(!smu->is_apu)
 		baco_feature_is_enabled = smu_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT);
 
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 064b5201a8a7..1c15c6fbe3b9 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2176,8 +2176,12 @@ static const struct i2c_algorithm arcturus_i2c_eeprom_i2c_algo = {
 static int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
 {
 	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct smu_context *smu = &adev->smu;
 	int res;
 
+	if (!smu->pm_enabled)
+		return -EOPNOTSUPP;
+
 	control->owner = THIS_MODULE;
 	control->class = I2C_CLASS_SPD;
 	control->dev.parent = &adev->pdev->dev;
@@ -2193,6 +2197,12 @@ static int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
 
 static void arcturus_i2c_eeprom_control_fini(struct i2c_adapter *control)
 {
+	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct smu_context *smu = &adev->smu;
+
+	if (!smu->pm_enabled)
+		return;
+
 	i2c_del_adapter(control);
 }
 
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
