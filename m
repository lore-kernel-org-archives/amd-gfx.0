Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C74C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 07:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 184412076B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 07:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Gtk89fzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184412076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C924F6E1A5;
	Mon,  1 Jun 2020 07:31:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 208DE6E188
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 07:31:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLnRBVkDZQr6a73rqBX4xKBXH/qElPE4s5Msb5jSeGnmtGUCbLCsxcCBsZDU6TpWokyENjqk3l2611qLxy1scmOc9BPZcwdNDmVzH6E+VjaRmfKWT3HKWEzbh0nfM2QDzTXbJGKIhgC4Pxqcxm6FzJ/JOguPZG4YqBzPjA2oChFpKnZT425ksxCAph+CI3qFmvyQb1Ts+7x1Y+Q2NlDTc24D6y1P5Nn7ubeDVHpZUyDMyeqTnWskqzDY0+VjsklkbrzuPVQZ+3gNCgRP0TqFaUiqFtryq4bhfNVxNisnmdYr8U2QV8bJlcKhwCLD1ds7xWURLgQxWcaJplPwdSGnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lc4jpzwjiYWw+17Z5izWtHpEUoLG3Vh0IdkEjYgAwz4=;
 b=AyjrN/14R3HfU/spAmbbUKz1hgmJ7oBCpheEqZStxyw9p1pRhReIQTdLHUqvCqgm0AF4xmYi4hfRHBUp23bvcIza3Jd/Wj1oi1KC6y7efBwkUCiYro2A1dzsHUOat1SRkFcsCiFKjS4hE3XSM6LMg6wjL2HLYW+1ZSmx3EsvmeWveO8drCMZLiyqIO8/fhvBRDfSfK0kJdqv35O4sdLYZrShw1o7BR90jlcPZaiM7RR6fpnrnFcPk7C60/u1nzQng4mXXztvNXFIzrCIPfynSW2ObQiYnyo1T1Oqni6dsZd532GsiAEezUOH/eEmoplyeoLLXp3xVFQsOuwREQg3ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lc4jpzwjiYWw+17Z5izWtHpEUoLG3Vh0IdkEjYgAwz4=;
 b=Gtk89fznFa2wzGfbpEOyn7LNzE8VIeBJHyLb8gGvYkkKF4rYbTjKsjhEfRHdt0iiXhsK3i+S4f72ucrH9c9G2WHIOfcmoFjusigrTmJbpsaYIjL4Xqngy4EfTamLaWVhHbBKpPXEHp5Q3wDEVbYNhOMN6ggHPMtGsNA/8lRLrsg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3803.namprd12.prod.outlook.com (2603:10b6:5:1ce::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Mon, 1 Jun 2020 07:31:09 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 07:31:09 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 9/9] drm/amd/powerplay: add firmware cleanup on sw_fini
Date: Mon,  1 Jun 2020 15:30:03 +0800
Message-Id: <20200601073003.13044-9-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601073003.13044-1-evan.quan@amd.com>
References: <20200601073003.13044-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0020.apcprd03.prod.outlook.com (2603:1096:202::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.7 via Frontend Transport; Mon, 1 Jun 2020 07:31:07 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c664ec34-fdc4-4c8d-4fd0-08d805fdc08d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3803:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3803E817190DC503A5247D34E48A0@DM6PR12MB3803.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:53;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HV0VOfDOTKxjIDViHfWg6YgSxB89aYXVhbiDzjrLmRuubKzmYZigLWva49A+MEZoe47Qvgrc9AYL6y7VyovRjq7/PAPpdzIBya6SgDrCEvJltqio3aAFo79TRSlFIzuKU2bMVfNa7RWM6+FafBvE5hvQ2ZtTcJAtrxuMruqdXaTIhQoL3cQRHXfLMKqF6x4MN8BJGY0e1SlrEWhhVncfyMV4AUFAWvKI81DOIj2GyB/TIffhHXgZ76vImYTfm0ypH5Xw9JyOQNo7n1coqHDRQ/3Q1x9x6UpLo1Owqp7UjQ7GgD/4K1o4kqVzhDC4+GS+jvZjQRbVfocH5Yu3TPhRIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(52116002)(6916009)(1076003)(316002)(7696005)(8936002)(478600001)(16526019)(83380400001)(2906002)(44832011)(6486002)(186003)(26005)(4326008)(86362001)(2616005)(8676002)(956004)(36756003)(5660300002)(66946007)(6666004)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: KiT9cjrtbroMVbvbKr497BM51vgVSlP0fGGiCiwzqqTIkBqxQjFF0JGvwt5biwlDTEyMG86PPhd/A+gfsXsryjH53JTdGcEW18oV2fxNNicQTsVfiEEVbOgmdlR4mpJFkpr5IJfKfsozdrAqcweFwmhgd25B5kfHmcWahVE3SnvphF1aoMjDa20K1yutPoTq6Zle8/pvwRocLb2RwORbETxWdtPGdriN8b6W8f+1FAhT/36+7yB26DpD8D/G5bVvJUt9dCBJ1lw52iBY3o1SB0Yxw17lVQQyGDHrJYQ8JcVZfNcEwXsEAbswLXQaR0vIkkwH1O+UDI65f9Qs9ACVZOLJTXZOiVY3DJw+YXD7z+VknzyoTKwX+MgAgav4aKp0ub0ELBIVsSwWBpTWNIIxXKY8lvGehR+H+gVJP49y+FqDwkGCb1K4euyWiLbWAXvNpKGVByVvojwlfrdXHcYEyD6oR2uqnWBcvMZGYSSNo9PubdqX1J+AQN/JOOzBqgCC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c664ec34-fdc4-4c8d-4fd0-08d805fdc08d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 07:31:09.0824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eo+XY4GJlVDfkvFEh0nGOWlIodTMyp0juJjKE7e20bcS+rZ1bJYdYdZiKYoATLwQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3803
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To avoid possible memory leak.

Change-Id: I4740eac7fc2c6e934ec8f503e5a98057f0902f4a
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 2 ++
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c   | 1 +
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 1 +
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h  | 2 ++
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c     | 1 +
 drivers/gpu/drm/amd/powerplay/smu_internal.h   | 2 ++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c      | 9 +++++++++
 7 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index b353ac1b0f07..197fef6f59a8 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1127,6 +1127,8 @@ static int smu_sw_fini(void *handle)
 		return ret;
 	}
 
+	smu_fini_microcode(smu);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index c5c23126ec2d..db2d86e3953b 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -2435,6 +2435,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.i2c_eeprom_fini = arcturus_i2c_eeprom_control_fini,
 	.init_microcode = smu_v11_0_init_microcode,
 	.load_microcode = smu_v11_0_load_microcode,
+	.fini_microcode = smu_v11_0_fini_microcode,
 	.init_smc_tables = smu_v11_0_init_smc_tables,
 	.fini_smc_tables = smu_v11_0_fini_smc_tables,
 	.init_power = smu_v11_0_init_power,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 7fed2556213f..718aecde88c0 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -495,6 +495,7 @@ struct pptable_funcs {
 	int (*get_dpm_clock_table)(struct smu_context *smu, struct dpm_clocks *clock_table);
 	int (*init_microcode)(struct smu_context *smu);
 	int (*load_microcode)(struct smu_context *smu);
+	void (*fini_microcode)(struct smu_context *smu);
 	int (*init_smc_tables)(struct smu_context *smu);
 	int (*fini_smc_tables)(struct smu_context *smu);
 	int (*init_power)(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 8d317e05f65b..4da5f5e87c81 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -145,6 +145,8 @@ enum smu_v11_0_baco_seq {
 
 int smu_v11_0_init_microcode(struct smu_context *smu);
 
+void smu_v11_0_fini_microcode(struct smu_context *smu);
+
 int smu_v11_0_load_microcode(struct smu_context *smu);
 
 int smu_v11_0_init_smc_tables(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index caa4355b601e..ebbbe38dfb63 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -2311,6 +2311,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.update_pcie_parameters = navi10_update_pcie_parameters,
 	.init_microcode = smu_v11_0_init_microcode,
 	.load_microcode = smu_v11_0_load_microcode,
+	.fini_microcode = smu_v11_0_fini_microcode,
 	.init_smc_tables = smu_v11_0_init_smc_tables,
 	.fini_smc_tables = smu_v11_0_fini_smc_tables,
 	.init_power = smu_v11_0_init_power,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 0c7d5f0b1cd1..dbdb870011d3 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -27,6 +27,8 @@
 
 #define smu_init_microcode(smu) \
 	((smu)->ppt_funcs->init_microcode ? (smu)->ppt_funcs->init_microcode((smu)) : 0)
+#define smu_fini_microcode(smu) \
+	((smu)->ppt_funcs->fini_microcode ? (smu)->ppt_funcs->fini_microcode((smu)) : 0)
 #define smu_init_smc_tables(smu) \
 	((smu)->ppt_funcs->init_smc_tables ? (smu)->ppt_funcs->init_smc_tables((smu)) : 0)
 #define smu_fini_smc_tables(smu) \
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index e2b1c619151f..10ae4575ccb2 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -195,6 +195,15 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
 	return err;
 }
 
+void smu_v11_0_fini_microcode(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	release_firmware(adev->pm.fw);
+	adev->pm.fw = NULL;
+	adev->pm.fw_version = 0;
+}
+
 int smu_v11_0_load_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
