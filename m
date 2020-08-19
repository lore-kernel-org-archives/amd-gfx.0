Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAB4C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 09:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7369120658
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 09:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="21pXeuZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7369120658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E755189105;
	Wed, 19 Aug 2020 09:58:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F29E89105
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 09:58:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnUuYuz9u6oiiyP2SM7yR8ePTfFI47eCznouxQLSurCYtuGTjqWeUjVg54HtuaYNgIBt2emFM/Be8KOeikrxl8cZUHBetFG2/0bVUjKkH9zb5RjaP5J9mdVMz24ImKPNyuNUCdaGWTbV9B3A8glTn9pmMRncMZ/AYljhf7xtbQW9RysTm4YSZnyeut7J/tJ5Hk4KYZlAly66suqRyEDGWxYsDFnYRbypLRneXC8os88OpD6LLSu+3C3qIPkAs/X9z5mB1hE3G/m/fPuArjaDFosJDoK7DEtWBhuJXq04MtNw7jRDARrc8FzgV2hrQ4KEKQydwgUKCMlmeJqZTAj8SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJN7nt3BBeNcLtBlOM2mOuWA/lPgqhQcIBEav9SL8kM=;
 b=eDUgllx3LopNKnEJRygNHnWWxftH+EhxNCNyYscJEBd/09mwVOnFRy64KpJ1GuzBiaffRI7CmtPhu4AcV7ZDUMaDUMcxZBYf8j7RJplrh3Ba2lAhMzZaTI+hozR6W0NbstwruqYds6fh1Y5ReBepGbG2cL+cqDqP/gdn4wZ5pILbjqk9RSLA5LAjq02VEx45+JbZQBVy+EiHI5jGczT2R4YZZ9D8StEMT+iT30a5YQ8MujPtowMqRheQfJcTGAj2y8zCFtrs0iyCH9RCe6FOfgT3MzmPFuKfCake8P85GwIUDOdKTPwbWJYgdUaYcLgrZp8ivYh5rjWFHsDylZRycw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJN7nt3BBeNcLtBlOM2mOuWA/lPgqhQcIBEav9SL8kM=;
 b=21pXeuZ4wpB/5nC1AmMD0NmA5R3AJ8sNM/CxIZeUNmZtFRINBS9eQisze5uz4iY1EbmKwk9+/k0B+knjSq88V96n1dlqfbriISpWAUbtL7h67XeBRFQevp/BFWJQrDegYnlT8dBXTXSGPjZAxSlkSZlD6lvPgPJ0dWh8QInwx4g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0218.namprd12.prod.outlook.com (2603:10b6:4:4d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.24; Wed, 19 Aug 2020 09:58:51 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.026; Wed, 19 Aug 2020
 09:58:51 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amd/pm: correct gfx and pcie settings on umd pstate
 switching
Date: Wed, 19 Aug 2020 17:58:30 +0800
Message-Id: <20200819095833.11420-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HKAPR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:203:c8::14) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR03CA0009.apcprd03.prod.outlook.com (2603:1096:203:c8::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.10 via Frontend Transport; Wed, 19 Aug 2020 09:58:49 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 927b6e1f-9c75-477d-d467-08d844267945
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0218:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB021836FE1538B87BB295541AE45D0@DM5PR1201MB0218.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u1qjVYD/cUVqE9A5Xv09Xo98T2biH3H7F+tZhOHI629k4Ygfgxi52mvSj7q8b56eI6zwyukpIRytFPbf7/9uki0Ivwdyzk7U6erK8XCwDo1zgwqZA2g7342EXq60OVAOPH0ADuxexVfKeNivJWEG2OPT8pUsRSzRx3pbxvocvP+2TdTAQNpHD15ydnq4+D+79r3kVH6ziaAdYHwW0qMKIJ8JJ8RKdevh2E+2/NUOP1zJZO1ex90Uiu/d8RaQut40FUU54CwEA2yzJGbHFa5ONAytpQFZ+bUWV8NOzEFgAhTt/0rCtMb0z6pGuJ1QdP7b
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(2616005)(8936002)(8676002)(1076003)(956004)(66556008)(2906002)(66946007)(66476007)(5660300002)(6666004)(44832011)(83380400001)(4326008)(186003)(36756003)(6486002)(6916009)(86362001)(316002)(7696005)(26005)(52116002)(16526019)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: u0nNnUeJuOy9i1IHGUIKaJrdlYDdVRL5rvpazaT6EgbChkLRhMHXWR7R1Mm26fR4Fgtme3LKtKvIqaZgXOdjXKQrQByAWa26V5lQu1/YmTdDZw0qflKIeTitPw95GWC4j5UqEwQGuJPU4jRrLiigaCUcHO6yxIqDuGwq9p6igfzDRGgxald6Nhe3vfRE5SjVpWm5M3zVDzqIPC+xZf1Rs76H1u6WFVw7PjY1+UaF8PEtXFznZYaYos2YExkwCZMGX3gUtbE8S18f0DSxFDiotmJzigc6hskB7LxUxGHzX461qLlHOX2n3YbKG0pYJGVMK2pzpzDjXGIflbisogn7KfKQh8UBRtmcVjtlvMj0YXNX/Cb+86CG5yPQLb7gdcmKobsZPgHqkaEHs5ODq9A8YTKv7dAZwIkq6lQeNnoKB+hQ98jz2nq6mqsWWuovdPnzRa4cKZqLg6xrvaZi4npFvVWUBC/RlndsS3MSftRdl6HiPe5I6M8qRymMe8TRZYm9g1oeo9dskV+adL9oje3e4MxX38odC4jxB2xHm8zT9oiXNvFTrfQmXoupIMxpR+w0E+rOehmEQ8nMsGUfTpuGa4FAolho0dKq67XZb/f6ZLrU9QxNWgBoMBabO1JNlPfEp5ZoLg2IBaK4QzFRGnX+Eg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927b6e1f-9c75-477d-d467-08d844267945
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 09:58:51.0448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPjUI8xxxiA+M2K+qfzhViLsUoHF6OHKz4pYo9th6Fzff/o3oEGrvgX3OQ91Ar2y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0218
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

For entering UMD stable Pstate, the operations to enter rlc_safe
mode, disable mgcg_perfmon and disable PCIE aspm are needed. And
the opposite operations should be performed on UMD stable Pstate
exiting.

Change-Id: Iff4aa465fd16f55a4f4de8ee0503997b204f8f9d
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       | 3 +++
 drivers/gpu/drm/amd/amdgpu/nv.c           | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/soc15.c        | 7 +++++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 ++
 4 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8ba389780001..6ff4ddb09d1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -617,6 +617,8 @@ struct amdgpu_asic_funcs {
 	uint64_t (*get_pcie_replay_count)(struct amdgpu_device *adev);
 	/* device supports BACO */
 	bool (*supports_baco)(struct amdgpu_device *adev);
+	/* enter/exit umd stable pstate */
+	int (*update_umd_stable_pstate)(struct amdgpu_device *adev, bool enter);
 };
 
 /*
@@ -1132,6 +1134,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define amdgpu_asic_need_reset_on_init(adev) (adev)->asic_funcs->need_reset_on_init((adev))
 #define amdgpu_asic_get_pcie_replay_count(adev) ((adev)->asic_funcs->get_pcie_replay_count((adev)))
 #define amdgpu_asic_supports_baco(adev) (adev)->asic_funcs->supports_baco((adev))
+#define amdgpu_asic_update_umd_stable_pstate(adev, enter) (adev)->asic_funcs->update_umd_stable_pstate((adev), (enter))
 
 #define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 54e941e0db60..d07c84a7543d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -691,6 +691,12 @@ static void nv_init_doorbell_index(struct amdgpu_device *adev)
 	adev->doorbell_index.sdma_doorbell_range = 20;
 }
 
+static int nv_update_umd_stable_pstate(struct amdgpu_device *adev,
+				       bool enter)
+{
+	return 0;
+}
+
 static const struct amdgpu_asic_funcs nv_asic_funcs =
 {
 	.read_disabled_bios = &nv_read_disabled_bios,
@@ -710,6 +716,7 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =
 	.need_reset_on_init = &nv_need_reset_on_init,
 	.get_pcie_replay_count = &nv_get_pcie_replay_count,
 	.supports_baco = &nv_asic_supports_baco,
+	.update_umd_stable_pstate = &nv_update_umd_stable_pstate,
 };
 
 static int nv_common_early_init(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 3cd98c144bc6..d9671db3b98d 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1029,6 +1029,12 @@ static uint64_t soc15_get_pcie_replay_count(struct amdgpu_device *adev)
 	return (nak_r + nak_g);
 }
 
+static int soc15_update_umd_stable_pstate(struct amdgpu_device *adev,
+					  bool enter)
+{
+	return 0;
+}
+
 static const struct amdgpu_asic_funcs soc15_asic_funcs =
 {
 	.read_disabled_bios = &soc15_read_disabled_bios,
@@ -1049,6 +1055,7 @@ static const struct amdgpu_asic_funcs soc15_asic_funcs =
 	.need_reset_on_init = &soc15_need_reset_on_init,
 	.get_pcie_replay_count = &soc15_get_pcie_replay_count,
 	.supports_baco = &soc15_supports_baco,
+	.update_umd_stable_pstate = &soc15_update_umd_stable_pstate,
 };
 
 static const struct amdgpu_asic_funcs vega20_asic_funcs =
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8eb5b92903cd..db0f1718087d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1442,6 +1442,7 @@ static int smu_enable_umd_pstate(void *handle,
 							       AMD_CG_STATE_UNGATE);
 			smu_gfx_ulv_control(smu, false);
 			smu_deep_sleep_control(smu, false);
+			amdgpu_asic_update_umd_stable_pstate(smu->adev, true);
 		}
 	} else {
 		/* exit umd pstate, restore level, enable gfx cg*/
@@ -1449,6 +1450,7 @@ static int smu_enable_umd_pstate(void *handle,
 			if (*level == AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)
 				*level = smu_dpm_ctx->saved_dpm_level;
 			smu_dpm_ctx->enable_umd_pstate = false;
+			amdgpu_asic_update_umd_stable_pstate(smu->adev, false);
 			smu_deep_sleep_control(smu, true);
 			smu_gfx_ulv_control(smu, true);
 			amdgpu_device_ip_set_clockgating_state(smu->adev,
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
