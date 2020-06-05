Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE3CC433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 11:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4BA1207D5
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 11:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eKnk7eWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BA1207D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ED316E8C6;
	Fri,  5 Jun 2020 11:04:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87A496E8C6
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 11:04:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNkJzuXxn9U/c48wfB2zUWtwjgrQ8a/EbNVVTZX74z2zJjB+xcumBqYuAoLOPN7X/Ib2Y6SA2S2YleAUcyvAq+9JB2W8iw9zOvqch09/N1eCaTWO94uKu41/jhGoFziLxgAL4r5uZMni/0fBvqAezImOXNBw1CXC/FSGxBGaTZ2iMkQ2iNXP5M6wOCG8HoiV7NhhbO9JBGWoUHJfJUVbHYcgQ8LbSnPvfwDebBqjgG7cCXBCdtVL43+1uUZeBLzZqgcq+tT/RyD0K2kXH/eOeQvrOGrp1RdmgIoadcMkDzGZzvFBMOsh/RBmov0VJJ/fD3mQP6R49P3pJKFs0RkZQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ed0LTUaWAVMDOEP98FJI8F4uNRzhEL/ZSf5t6I3Z1gQ=;
 b=FYTChpbAU4CBy22EIjWyVHHlauvEb6VRq4J4tXcjxnR4aI54rKB/Y/YdMDa+XdQDDV+VEnJkCQqxhe3PtNPxz76dwMwyVJkurE243ypgMPp////OqPvTe6ZZf+RXJvVnV0vZEt6EcWt4Rw8BtUfWvSumSP3aZq0SLR9YxQw8Hk0Ygu/2zPraXip97npd2M1/9ckmVh76Ye1c0nkWpyV0Y7elM/JmjLyVNuDFG6E/ONUNNXlYpWKfHEBD0jAZ3Cd3Cn/2RyWAMvfcTIdzMk7CQldg5QRqiPWBmz4oJ/gdyBZpd0733pXfIgs/a80MUxFv3ktKopGQ2yF9oDINNWTEZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ed0LTUaWAVMDOEP98FJI8F4uNRzhEL/ZSf5t6I3Z1gQ=;
 b=eKnk7eWrojbfR7E/onJc/MmvggX/1+RIKxKoFNkAcTMrsesxRJVPg+znAHmFddcn4ryQJj3FhPthEawNckS9d99QF9thdoLAhGVHGCdkWfV3s7TLI5UX5An+1s4vkWTVWFReiCfIHnwlCW+WbKMcbnpTtgg1iRCm4XXDJE9B60A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2615.namprd12.prod.outlook.com (2603:10b6:a03:61::29)
 by BYASPR01MB2.namprd12.prod.outlook.com (2603:10b6:a02:ce::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 11:04:29 +0000
Received: from BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::4c16:1697:3e6d:9157]) by BYAPR12MB2615.namprd12.prod.outlook.com
 ([fe80::4c16:1697:3e6d:9157%7]) with mapi id 15.20.3066.019; Fri, 5 Jun 2020
 11:04:29 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amd/powerplay: drop dead vce powergate code
Date: Fri,  5 Jun 2020 19:04:09 +0800
Message-Id: <20200605110411.27302-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HKAPR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:203:d0::27) To BYAPR12MB2615.namprd12.prod.outlook.com
 (2603:10b6:a03:61::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR04CA0017.apcprd04.prod.outlook.com (2603:1096:203:d0::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 11:04:27 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 54286993-e3dd-4541-a2b6-08d80940379e
X-MS-TrafficTypeDiagnostic: BYASPR01MB2:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYASPR01MB232E45ADD18371F588A3BE4860@BYASPR01MB2.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CtY6tBbsd11rOKt2m2GQlGn/T84ftk2MDEl+GEMVkWsbAt5xAShjuzoN9XhjwUHlpsW4s58NRfw70SkrHRu+g9kJ58VR6ASFOH8lIb71K6CWA4V6LblMOlNi2cf0h8cjg3d9ahNKuRqldi7O1i2X6OfE5HBDbo7zuJU8r6gnz0bsnviEFOf3Cy0h0KbvZAgvcoey9FzS7Ybsoh41I9lEYxuIFHoLdaCZv58+hoXxd9FzORKW6bJL1zuTVq48nyxfTt2hfq//X3PozPGXw8OfyeO4ACyNORh7GTilIZEFalSuqKZWwFsoIeZmFlsgi3Wi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2615.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(4326008)(8676002)(83380400001)(2616005)(1076003)(956004)(8936002)(6486002)(186003)(6666004)(6916009)(2906002)(16526019)(478600001)(66556008)(66946007)(26005)(36756003)(66476007)(5660300002)(52116002)(86362001)(316002)(7696005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: XNTW0owCMzUprtYgkNiwBsx7507KdhON6gfECz/wzhzec+gziMLVbuHVNFCIWPI8eLCzVuqw97suii34gyGToBNOjV/ZINJMY2Jj9+0kcVouxaEgjfg8n8p1kdaZb2foWw5MgDyoT5FtqOMn2CeYhOmeNFQ615KzYP6VqWFLq+jC9sZ2UaIMf0wfSn5hI/wqxkO2U2Rn8J6+HBlWPHEd+uFWIhXKVlXo8u4jx9DXlD+R/JVDE1RZhCPl5O6IrASU8sSmPHKaNRVltm/crx0AVQ3P7wf9L9PV9QvJLWUj7BJZOMKClm7nyKXNC1e1LoXS+KjEZZY9URmDLgNxTHGhuADlMYc5JSpKBPmsYtZrSzNiR2/vs79/9M+Y5ebyA0fVI8klGs8K6d19tqGfm//yvUlTH/dMirnwO94mf+tdKIoBMHkwlcRyMLClkMSrBTaSISUcx2kJDWvEDumXvaHr/py+TtuKq9u7w9a/Xt/r9IF/+Y0DSFEjN3iNnKJTa1cC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54286993-e3dd-4541-a2b6-08d80940379e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 11:04:29.0626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y56S2rBXmeLko38ulHb/K8U+t+mbI2H9asC+R/W5bO0iQxFuTvydK8JX1cbAYLDl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYASPR01MB2
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

This was for Vega20. However Vega20 support is
already dropped from current swSMU.

Change-Id: I5400496dff2e338de4622823484b88cda6018ec1
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 6 ++----
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 1 -
 drivers/gpu/drm/amd/powerplay/smu_internal.h   | 2 --
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 11538477da93..00bf24c9ac45 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -461,9 +461,6 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
 			dev_err(smu->adev->dev, "Failed to power %s UVD!\n",
 				gate ? "gate" : "ungate");
 		break;
-	case AMD_IP_BLOCK_TYPE_VCE:
-		ret = smu_dpm_set_vce_enable(smu, !gate);
-		break;
 	case AMD_IP_BLOCK_TYPE_GFX:
 		ret = smu_gfx_off_control(smu, gate);
 		if (ret)
@@ -483,7 +480,8 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
 				gate ? "gate" : "ungate");
 		break;
 	default:
-		break;
+		dev_err(smu->adev->dev, "Unsupported block type!\n");
+		return -EINVAL;
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 79599c0825c3..6f31485245bb 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -454,7 +454,6 @@ struct pptable_funcs {
 	int (*get_power_profile_mode)(struct smu_context *smu, char *buf);
 	int (*set_power_profile_mode)(struct smu_context *smu, long *input, uint32_t size);
 	int (*dpm_set_uvd_enable)(struct smu_context *smu, bool enable);
-	int (*dpm_set_vce_enable)(struct smu_context *smu, bool enable);
 	int (*dpm_set_jpeg_enable)(struct smu_context *smu, bool enable);
 	int (*read_sensor)(struct smu_context *smu, enum amd_pp_sensors sensor,
 			   void *data, uint32_t *size);
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index bde3912e2294..bb4eabd6664a 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -159,8 +159,6 @@ static inline int smu_send_smc_msg(struct smu_context *smu, enum smu_message_typ
 
 #define smu_dpm_set_uvd_enable(smu, enable) \
 	((smu)->ppt_funcs->dpm_set_uvd_enable ? (smu)->ppt_funcs->dpm_set_uvd_enable((smu), (enable)) : 0)
-#define smu_dpm_set_vce_enable(smu, enable) \
-	((smu)->ppt_funcs->dpm_set_vce_enable ? (smu)->ppt_funcs->dpm_set_vce_enable((smu), (enable)) : 0)
 #define smu_dpm_set_jpeg_enable(smu, enable) \
 	((smu)->ppt_funcs->dpm_set_jpeg_enable ? (smu)->ppt_funcs->dpm_set_jpeg_enable((smu), (enable)) : 0)
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
