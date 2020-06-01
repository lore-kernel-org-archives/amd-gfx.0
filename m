Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B486C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 14:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C54EA20738
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 14:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3LeXXPHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54EA20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AB9089C16;
	Mon,  1 Jun 2020 14:08:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFD8A89C16
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 14:07:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIx+ZMaCl+YDLxVeMTT7u4UoIR+EeIQIh60Ndl9+fp92ykGWlS8YJBLCxRfImJL84v4EIkZjGTON2NfoomuuhCIgMlaxgJcuo1VfHgrM/gkXfTJI388MKiIIwnv+bVXwcKnTJvDf7J7KRk0JjlBOgwFUZ2rVm6rJwS4hAj6Afq8z+x91cD5g2mibVCYArnm7gBlY8jnnn2iXd2r3+pA6XQMQqnlNO0+Nedujg2RBgey80iZywZQQNXiO+oJkZUxZqevLJq19M0oXAbdzGuWuEZGT2Gw3x+u3GTlii/9o1FqcLP3iWgV6L80cAvCwYgQOKftQXVMwgDkVVoYhdDWaow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVCOJArhqQIvAcKVYfnR8ycO5bzqjVSC0tZ5SuACo8c=;
 b=K623jAir2sgGGnNSYW4G24IAEPpmdNWKSkh2WSi17dYq4mYShuycpT4s0gCMoypWQi7L25MLQ7dbt2GTwFNVL5htncJHDFiLt9P2WiQT4ze0Bp1AN3crvokPUvRn/jOxySQImY9WJwUgSNS9PAeBvMigOoDL4XMqU4Ku47tvXCjw1I8I02GDUwZeLOF9Ele6AWQiBa2XCZITGuZqPeyaliFBjb8nmh4457l/3/9o+6yD1vQ9jA0qy8kx6XVZAxdBv3e8RsV0x4cxMQX3D2gXBbPADiHWo2hN4F24SrUA2yDfj1bTkwoXS/BzurTxIQZZpiyaRevPKXM++Db5EznUkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVCOJArhqQIvAcKVYfnR8ycO5bzqjVSC0tZ5SuACo8c=;
 b=3LeXXPHLTuj7bP6nLr312QdxKcqumylou/5Wjth7ti8GvCOdj6KVb1vj5PnWzYd20LF7Z7xC2omNE9d6NDVDNu9e0Ge8qgVqDdiYUASZ45Qscf6JkTqPWqPdt4qWFtYUaJYNCuINE4kMsAtvmZEZqFodjczCemp6vgYjMrx38rM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB3677.namprd12.prod.outlook.com (2603:10b6:208:15a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 14:07:57 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9ca1:81ba:bd45:53f4]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9ca1:81ba:bd45:53f4%5]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 14:07:57 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: use existed smu_dpm_set* interfaces to
 implement powergate functions
Date: Mon,  1 Jun 2020 22:07:40 +0800
Message-Id: <1591020460-7020-1-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR02CA0163.apcprd02.prod.outlook.com
 (2603:1096:201:1f::23) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-intel.amd.com (58.247.170.245) by
 HK2PR02CA0163.apcprd02.prod.outlook.com (2603:1096:201:1f::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3045.19 via Frontend Transport; Mon, 1 Jun 2020 14:07:55 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 67034b40-344a-4e7e-835a-08d806352f3b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3677:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3677842487785864A74BA112EC8A0@MN2PR12MB3677.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sXWoY5LZU5VjiKzq6/APQtHg//GBqXBQKkq2j1KuaNP1Ykx7LRmkGebUXYq/8+AG1CbloizLImG2JaYTBaL2Iqw5QUT9TVNcKDEr9P8V/l88d0MFVyy9+MlYryalWNg689nlX9lfLm64dDUexTy6WAOBR5Cjel0cPlfBT0jqXn5kGpDy5nWviiI81cFp14sx2cUdMJPCncMlAuERLgaV9kKKMHxRToAXgiGz6dMbV16XB0SijJxV5t9hjdGPQTcXhe3BYvKXbNTiNKKCufCKvscrJBNq4eMD33r15sOaLAv3FHBIuphpZcdisniXVmJTCQHX6Z6hQ/SXd9dSV4jP3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(2616005)(8676002)(956004)(316002)(8936002)(16526019)(7696005)(52116002)(186003)(86362001)(26005)(66476007)(4326008)(478600001)(6916009)(6486002)(83380400001)(36756003)(2906002)(6666004)(5660300002)(66946007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: FtbqwckDGTE9zATHJrAzCYMVTF6alFdn5Ld3yfwdSkw86yc9QFGVLIoB7jnd112nEAkaWFfqLbSXtnuGCCnJybouC2bVRHC11JyCaEKNZhaB69G8383subBeZOG0TSZncnm6cVQRZXXJzT5dMxnCgieviTR8RPK66SSZP+6UoLOrdonuQ7lSx3O07OBTxDd4n9diC9yDfl4MckrrHAHPc4CpC4mktpPyO4yKnepptcmispuUVGNIo/cTBgabtEjHbDkdbS0Xp2JWzyKhw6/lzNKVxL1eare2t6Iv7drwuvY4vU8jSu7PdcD6bFs1h2QYlkCkKfWI/qSU7VEkLgyMQDrna0EsJMlABozGZOIqohzOOHUqsAGsoCvFu/FmSQEZ+h4sFpCQBr3Oydxovbo1LpCegcFZDgDQ2gxal4g9S4OYLo06Qk4AgDxIsz4JFcFmMDWm9N21El+IKPFdyzOtW/S4dB9LQcwHP6324V9uZ63jznTm4QWeaLW3ojfuWX54
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67034b40-344a-4e7e-835a-08d806352f3b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 14:07:57.1356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TI+VN5TlgGx9FX6EjGk3D3wU7UOSHiJsq91/SzWOChbzQYIK0n+heI2v0p4AUlP+z2sbkP5pVNUMkkWO3IC6Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3677
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
Cc: Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Abstract powergate_vcn/jpeg functions, using smu_dpm_set* to implement it.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 16 ++++++++++++++++
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  2 --
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c     |  2 --
 drivers/gpu/drm/amd/powerplay/smu_internal.h   |  7 +++----
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c      | 22 ----------------------
 5 files changed, 19 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 3bb6ab4..846d099 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -2736,3 +2736,19 @@ uint32_t smu_get_pptable_power_limit(struct smu_context *smu)
 
 	return ret;
 }
+
+int smu_powergate_vcn(struct smu_context *smu, bool gate)
+{
+	if (!smu->is_apu)
+		return 0;
+
+	return smu_dpm_set_uvd_enable(smu, !gate);
+}
+
+int smu_powergate_jpeg(struct smu_context *smu, bool gate)
+{
+	if (!smu->is_apu)
+		return 0;
+
+	return smu_dpm_set_jpeg_enable(smu, !gate);
+}
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index ae2c318..e68d554 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -508,8 +508,6 @@ struct pptable_funcs {
 	int (*populate_smc_tables)(struct smu_context *smu);
 	int (*check_fw_version)(struct smu_context *smu);
 	int (*powergate_sdma)(struct smu_context *smu, bool gate);
-	int (*powergate_vcn)(struct smu_context *smu, bool gate);
-	int (*powergate_jpeg)(struct smu_context *smu, bool gate);
 	int (*set_gfx_cgpg)(struct smu_context *smu, bool enable);
 	int (*write_pptable)(struct smu_context *smu);
 	int (*set_min_dcef_deep_sleep)(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 95eb445..6241d2e 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -930,8 +930,6 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.check_fw_status = smu_v12_0_check_fw_status,
 	.check_fw_version = smu_v12_0_check_fw_version,
 	.powergate_sdma = smu_v12_0_powergate_sdma,
-	.powergate_vcn = smu_v12_0_powergate_vcn,
-	.powergate_jpeg = smu_v12_0_powergate_jpeg,
 	.send_smc_msg_with_param = smu_v12_0_send_msg_with_param,
 	.set_gfx_cgpg = smu_v12_0_set_gfx_cgpg,
 	.gfx_off_control = smu_v12_0_gfx_off_control,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index 40c35bc..2889eb2 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -40,10 +40,6 @@
 	((smu)->ppt_funcs->setup_pptable ? (smu)->ppt_funcs->setup_pptable((smu)) : 0)
 #define smu_powergate_sdma(smu, gate) \
 	((smu)->ppt_funcs->powergate_sdma ? (smu)->ppt_funcs->powergate_sdma((smu), (gate)) : 0)
-#define smu_powergate_vcn(smu, gate) \
-	((smu)->ppt_funcs->powergate_vcn ? (smu)->ppt_funcs->powergate_vcn((smu), (gate)) : 0)
-#define smu_powergate_jpeg(smu, gate) \
-	((smu)->ppt_funcs->powergate_jpeg ? (smu)->ppt_funcs->powergate_jpeg((smu), (gate)) : 0)
 
 #define smu_get_vbios_bootup_values(smu) \
 	((smu)->ppt_funcs->get_vbios_bootup_values ? (smu)->ppt_funcs->get_vbios_bootup_values((smu)) : 0)
@@ -214,4 +210,7 @@ static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_typ
 #define smu_set_power_source(smu, power_src) \
 	((smu)->ppt_funcs->set_power_source ? (smu)->ppt_funcs->set_power_source((smu), (power_src)) : 0)
 
+int smu_powergate_vcn(struct smu_context *smu, bool gate);
+int smu_powergate_jpeg(struct smu_context *smu, bool gate);
+
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index 4fc68d4..7c3da532 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -182,28 +182,6 @@ int smu_v12_0_powergate_sdma(struct smu_context *smu, bool gate)
 		return smu_send_smc_msg(smu, SMU_MSG_PowerUpSdma, NULL);
 }
 
-int smu_v12_0_powergate_vcn(struct smu_context *smu, bool gate)
-{
-	if (!smu->is_apu)
-		return 0;
-
-	if (gate)
-		return smu_send_smc_msg(smu, SMU_MSG_PowerDownVcn, NULL);
-	else
-		return smu_send_smc_msg(smu, SMU_MSG_PowerUpVcn, NULL);
-}
-
-int smu_v12_0_powergate_jpeg(struct smu_context *smu, bool gate)
-{
-	if (!smu->is_apu)
-		return 0;
-
-	if (gate)
-		return smu_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0, NULL);
-	else
-		return smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg, 0, NULL);
-}
-
 int smu_v12_0_set_gfx_cgpg(struct smu_context *smu, bool enable)
 {
 	if (!(smu->adev->pg_flags & AMD_PG_SUPPORT_GFX_PG))
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
