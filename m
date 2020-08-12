Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF8CC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 04:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F081820768
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 04:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Iddo0bTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F081820768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD6386E8A4;
	Wed, 12 Aug 2020 04:57:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E05AC6E8A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 04:57:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abUVerf+NuFojUMyjptwNXkAubzg/m36D7ox5knCAhq5Bd4txEqbZVkgXgc6GCHEhGp0YpNVIA+0mGWiQq7lyRt3f+omkxmKI8XOJz8v3F7MafCLjEWPgCYUPKSS7y/WmoOVwkNGr3jk4rteJJEVRQBFZV2cumYXkbMCiXqIM9ekieuSLBqhyYH9CXNAdxpKwnomimWam0Yk73K5i1CieIreVTi02VJPkYekQHs4BU0Ylfj2MQ0sr50nsn+FNtL9hWnduIJKb4HY1x6BDCfuPkoVUFFfXoDeUOHfVr8VTt1OvQq7f0ex2nv9DF74wiCWllAC02lng3doKwKENr3sgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iwo1lq8XFzItDLkAxzNyXfqMNF2ngqTcRESmNo+pzRY=;
 b=ZvFtuAOrpG9WLS8h9vBo1fBiUPES8Ma2myrLAiLFiiexW1mdm6iF1BogoVl9X1LVky+BYW5HM4SryAb39YALvpIKehVRoPfzLxjHTwUBNpzySBhAH03R4Uc/OFbldJcat7MgsJDqJ0MTKaDjaoHoL8rGJ6MxW92XcIdCFcw9XqlDZTIShGr0Tc/uaGf2yqH4IpKqIepiiMETpCrY93FsiImO3yEiTVYDCWA9fVRqrf6RRNO2RlfJyv2z7PyYnQoxVuyS/KYiCux/pKh4VCFbcYimtiUwdXxW15Bp3REX+Xq+ui+Gl+U7lh8th4CyUI0Qk0FWl6A1QnRHPKpfTqEIBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iwo1lq8XFzItDLkAxzNyXfqMNF2ngqTcRESmNo+pzRY=;
 b=Iddo0bTGwOLoysP3txqBKug7U1j/qeMuj47cBQhEn1mDwvogwfAOuZvZnSWMIRnYGNOG3aAfvWrgk8nK1eCfI1PtxHrc3FIkHKdBxFoHE77n04jvm0eeYamjvlcaodJC73Rku3CLJm4ditSimA/Ksl6Pl+VyOjUC6iriFF2aAgM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2502.namprd12.prod.outlook.com (2603:10b6:4:af::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.22; Wed, 12 Aug 2020 04:57:24 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.015; Wed, 12 Aug 2020
 04:57:24 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amd/powerplay: enable Navi1X mgpu fan boost feature
Date: Wed, 12 Aug 2020 12:56:46 +0800
Message-Id: <20200812045647.20541-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812045647.20541-1-evan.quan@amd.com>
References: <20200812045647.20541-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::21) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2P15301CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.2 via Frontend Transport; Wed, 12 Aug 2020 04:57:22 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5882bdd5-93fe-4f75-4e7f-08d83e7c33ba
X-MS-TrafficTypeDiagnostic: DM5PR12MB2502:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB25024D7410F7012F8BE71E7BE4420@DM5PR12MB2502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J2av3MUlLWhFeIyWl/qJPtauxOMFsQcbwMij6MjUJiWNAD6I7mlEVSAw0+J2EzO+QOw0xT0xBl4XYgkDhqliQV2CAm8acHlpi9I2U35CRbH3btyesMnucvZdVU/L2tncOw8uKWmlTs3Ig0Ml4O/0YfLjSVvsvpZT3p4fJ9IBCsBQIEsrzSCftgsceYmZ2pkKfTjeBdbTgH9boYvbpZGrB5hHjncEK9IBKLjwScCJMfXFE+MQ+o7Oe4qsJRszCXGkvwegbg16KMOiqq7/BMcpiLgcdoTne0n+ES4AMQnn6qxj/1l4m9wuxlVCr/69UPCiEMcvo49fUS+rtd2dnzISJqEuHfsLi52JOrMcl91xGrmiWWQif17DisI9/gTThscK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(86362001)(66556008)(316002)(4326008)(1076003)(2906002)(66946007)(66476007)(5660300002)(6666004)(6486002)(8936002)(16526019)(478600001)(956004)(2616005)(8676002)(186003)(36756003)(83380400001)(6916009)(44832011)(52116002)(26005)(7696005)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: k9arPYIAMLm6kWeSOqe9WJXQAAlagfKMgbws5Dx0S040Rtk7NKMhmvnZnyFfTVSyzo8c5+UfjjH6xFp0SiKQyLPnXRk0c+JnNgTB0izAoWTuRZczZSSI1rFvMu2O4GZzf8Rz95Y9L+bYeIqGTrfGSXTSN/virKZkPap0zZT/pmX0b8WycgipUR42Bbo1tH3hmOQHcu5O3OUx5q5pY9sq/81gD/JO4J5ijpNNU5OVcGbBk3pMQ2as5qGO6nz3kmxmOquM4w+cA0SmEJFDIVthZId4U3M+fjaNt37rHGf46n/xjbPRW3oKVX4j2fBEvdvuEyR/BeOl80jr/XVyknkTU7osYV9My77/8Pu7SxqRdA9Z1ShpC1JidHVBAaaOVHiHSQ5cvyJcHL7OOopuODFd5/7vt09OCNGPNV3C80fv0LRmy9i+ftjW44LiEEkVhXEy4mm7VaSQyV6QplBJJMFw1fy5vA3pBS9ovELUYPYTDWyk7//UEKdcUAJMsfJL9RFo5H1sT+/mJSwvWs5VVQCFhux94negUHBx3BbicKCzOm/qUmfoRWrw3gbuwBMGpEFEd4DEHPN2+8H0eHVaby93vDAmwbC+w2gtSGeMlhavXt4MG6xhVhTeXPcSDUIyy3z44wGZe5pbWE73+K66J8n8Jw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5882bdd5-93fe-4f75-4e7f-08d83e7c33ba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 04:57:24.1537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N25siO56wr04ucMlqP2cjDJlEV2gEceDr48FGrV2TYyrC5h90w9iTsjuwWEPV1OG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2502
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

Support Navi1X mgpu fan boost enablement.

Change-Id: Iafbf07c56462120d2db578b6af45dd7f985a4cc1
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/powerplay/inc/smu_v11_0_ppsmc.h   |  4 +++-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 21 +++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h
index 406bfd187ce8..fa0174dc7e0e 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0_ppsmc.h
@@ -123,7 +123,9 @@
 #define PPSMC_MSG_DALDisableDummyPstateChange    0x49
 #define PPSMC_MSG_DALEnableDummyPstateChange     0x4A
 
-#define PPSMC_Message_Count                      0x4B
+#define PPSMC_MSG_SetMGpuFanBoostLimitRpm        0x4C
+
+#define PPSMC_Message_Count                      0x4D
 
 typedef uint32_t PPSMC_Result;
 typedef uint32_t PPSMC_Msg;
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 61e2971be9f3..a86cd819b44b 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -138,6 +138,7 @@ static struct cmn2asic_msg_mapping navi10_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(DAL_ENABLE_DUMMY_PSTATE_CHANGE,	PPSMC_MSG_DALEnableDummyPstateChange,	0),
 	MSG_MAP(GetVoltageByDpm,		PPSMC_MSG_GetVoltageByDpm,		0),
 	MSG_MAP(GetVoltageByDpmOverdrive,	PPSMC_MSG_GetVoltageByDpmOverdrive,	0),
+	MSG_MAP(SetMGpuFanBoostLimitRpm,	PPSMC_MSG_SetMGpuFanBoostLimitRpm,	0),
 };
 
 static struct cmn2asic_mapping navi10_clk_map[SMU_CLK_COUNT] = {
@@ -2555,6 +2556,25 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 	return sizeof(struct gpu_metrics_v1_0);
 }
 
+static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t param = 0;
+
+	/* Navi12 does not support this */
+	if (adev->asic_type == CHIP_NAVI12)
+		return 0;
+
+	if (adev->pdev->device == 0x7312 &&
+	    adev->external_rev_id == 0)
+		param = 0xD188;
+
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_SetMGpuFanBoostLimitRpm,
+					       param,
+					       NULL);
+}
+
 static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_allowed_feature_mask = navi10_get_allowed_feature_mask,
 	.set_default_dpm_table = navi10_set_default_dpm_table,
@@ -2636,6 +2656,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.get_gpu_metrics = navi10_get_gpu_metrics,
+	.enable_mgpu_fan_boost = navi10_enable_mgpu_fan_boost,
 };
 
 void navi10_set_ppt_funcs(struct smu_context *smu)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
