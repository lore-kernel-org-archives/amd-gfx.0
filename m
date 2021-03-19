Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7C9C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 06:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85FFF64F62
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 06:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FFF64F62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FA9A6E990;
	Fri, 19 Mar 2021 06:54:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4084D6E990
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 06:54:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9fovAt07h8rcHIK0ojHbe3KRZgQQlkj7YPAm7dC0ZWpREJygCaplHqJA3W7YqinUBI+UmFSzZmcyl5/ZKHmrNBmHNtdJb+PgJMbvUypjoaNVViSj5e+O9tjisPcarF/Se0b5zpjYeI76vXytSkRYbLlGshdghU8D3vMzuMbC3UuRO1R9Mo2HK+EsfuwF/FdR8+egdEEQM5u3GwmN7unHzxIOn0WxyhoHM7hQAFHJKVfMxtSCYwHmI7wkZlgqoKTbYt3HG1rqrsZVhdiuzeStXK3FBwJn5y5mhb7OK88LgcK7DPqqad4lHqx5Ixm83Go/OuUlKNEanzXwaA++MMXkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+/cwrETegmq8b6gIcLSEVQNOWInr3JCD+3O2uUTGS8=;
 b=d3kvsW2VYqlHfd3oMRigbT8DiIQE4cAKozyd5fOWbLZEKSTu3WkIl3CY0cb+BtZLdyFd52QLcUsIl860PtLrEmcQI3yGEWUTSdDB8hYQOna8cmlH2ge72kZIRIGKC0a9TymAJlH+N202Y5+cMXxTx/CFvHElmgl/y/LIwrADqIaaBB+ckE0TvnxBwqMs7zGE77lTJduzjhIh1etWYO6NLpk5NyE1lb+cUS9Cs9p13ynhMF0qUtjkWOhCZWtZJtZWkdxaJO3kz4iUIG8Lz9cJpU907Y6DVIQK0AvZjdN6Y7jM/f8OwFPtq/jJfkDVgzN1GDsgXoGBZj5aHd1uYcb70w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+/cwrETegmq8b6gIcLSEVQNOWInr3JCD+3O2uUTGS8=;
 b=xY6Oi/pkufwrkadBABn3CuGRbLpRLXCnGp9ykp4OiyvI+NAaePu2M7cNIXW8L4zcXdpcc0fnhhJ3BVB+u6KEvsff5K9KEyHyN7wyOSOdExMpuRAwO9NmVrx6ysVhcWnnuV8bVsRkV2uNAzMs0WbBv/KGGRsJWxhXLB7ZW75/vlY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2620.namprd12.prod.outlook.com (2603:10b6:5:42::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Fri, 19 Mar 2021 06:54:41 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3933.032; Fri, 19 Mar 2021
 06:54:41 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: label these APIs used internally as static
Date: Fri, 19 Mar 2021 14:53:44 +0800
Message-Id: <20210319065344.511157-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210319065344.511157-1-evan.quan@amd.com>
References: <20210319065344.511157-1-evan.quan@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0179.apcprd02.prod.outlook.com
 (2603:1096:201:21::15) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR02CA0179.apcprd02.prod.outlook.com (2603:1096:201:21::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 06:54:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a3919e78-553b-4ae6-e93b-08d8eaa3de6d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB26206EB28C1AC47D88DF3FD0E4689@DM6PR12MB2620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vWQm80Ory6I23lwZ9jIcfeDGBxpqi9wySaq4QhOiJvKf8gmHCBHWu556ErF15H8Y8uepiu31eZEUasnooDLqTSzyBLFbldxzOJe1o7IiShunN2mxtQhhcb5yuxJG6vX48b0cuTRD1h/KzfigezcRZRhrzVSaR/mxvJiSQd1syy1xKt1TIFGDfLymAHlK8+DzpPIBXSStRdoDJ2iSLfUz780cLriaUNbWD3vRLvZM9fhfGjjDHc58dhKzk7bG9NUBKY2QGs1+2JDNL3JdcvsysAWucoGeOgMXU6En/Imlfu2x8hhuYLd+SDib+ZBmIjKsK0L0AJK32y5Dwc2RAS7uafkYzofJYqG37EmQlgw9NFc/pvyIDarqrXNc8MwmccgYCDCazufn0kw6CHilhNCaVmpOQfWF4vQC8Dm9MVUsWlaf+OnpJdX1ZUp8R2FREd+3TecpHali05JDeWT9sttaoqhQ/xoByvbbbt6Apql2Mf/3aIufvXXzo7rY9GfrVs6+E1+HD2EwKMPJTvBJAdrrBAzkmuNp0bS3qbz0CQKtGRs6V88TxbGc4YEd3Ceq0b9mk0faotBPNHlaN9eUJwjQXBEp+Eqfq8vQnXddIEDHhN81JLS7TqOQX2iPFW/BCNZxcT8+ESCMNtxc/Ve3Dxg+EQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(83380400001)(44832011)(956004)(38100700001)(66476007)(66556008)(2616005)(8676002)(16526019)(6916009)(30864003)(1076003)(6666004)(7696005)(66946007)(478600001)(5660300002)(6486002)(2906002)(316002)(186003)(4326008)(8936002)(86362001)(52116002)(36756003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?nctnt9XQBUwJDopZEXlvIKo1WTcoRwXAsLJDAOWAiCbKAYslOPBVuZzCjiHL?=
 =?us-ascii?Q?UUwanlP5ReC6dMsAfL/AVhpv1LDCd1y/cldIwayLlPK4yIY/+TZuRoCHne7h?=
 =?us-ascii?Q?7GCxeNN75nA1R/1jNY3/VO4H7QvWY1+y10mYNQ9O4YZYikpVa5WGCv0WQCxG?=
 =?us-ascii?Q?ht0t/LcIRYNX8MjJgKrW2WK9ko8fNsa/qwpG4K/3UrPBVBusA7UuLuObfDsV?=
 =?us-ascii?Q?vUiQITPOKMMmsK2d57xNc4FVo9BWnDwUeogg8/ILcC/2u5G53FzClG+SuctD?=
 =?us-ascii?Q?nWbDiZ7xa0GYI2D2gGosKCaWWFVzoS33tjl37ZsFrFe8agX8SmbuXJNSEFQ4?=
 =?us-ascii?Q?Aq/2CS6SiPYVFwsa3AZ2Ldwj9E333TYTzQf8S8oz9LgUzIC6diqBl+9x0v1G?=
 =?us-ascii?Q?GOA4CeKlUNPXhTutiqUZ4RU4x1PdotK+1PzuHeVwtMf4sJffNSJ36fLtASM+?=
 =?us-ascii?Q?tUW9rP/FRGkF0OVTIVPTkGtXbSlD71zKSHglWc5734bGQxtBVuw/jy2tZFB/?=
 =?us-ascii?Q?adnbaIoHFWtaFuKugF1bsFmvOVTvKcPFlrMU7KcEfVRJUmT7gQ4qwDdgBsVJ?=
 =?us-ascii?Q?WRUA+J6A9Vokk2qmhFYl4cwbW97h7sWFJ4QvhoWy7EE5HqIehiZcI2vmZ9cy?=
 =?us-ascii?Q?aldm+UArmYeugKcMQ44+l/LYm/hzbbL2bNsT7+QyTs8/MtagfgSf7Br4PsLX?=
 =?us-ascii?Q?hMvL5kay1PLWuHUqeObGEJ2ftkpectCpocnw68Wed+ZTn6Vma+dBbErQGSd7?=
 =?us-ascii?Q?phIKHQYyVT/jAtfb6bn3arfiRm+Inz+XiqdWDjDZMI1cYuV20yjpJPkMCMge?=
 =?us-ascii?Q?Tl1SXWPU/r8ZPT9KkMZ4cdU4uKGZl2r2k2z1Kna1von8Ks4ILV5UEvIx69j4?=
 =?us-ascii?Q?hVcEN00sA6ZAwewA/VrYDqKPepZT7iMB+6wk9DyfqXQEdKDPzPFMbOKHqIrn?=
 =?us-ascii?Q?b0HaiEuK4L5djAL3foT9VDOsHbP0SX4oio9kpgaSlpGJEKKFezusOe9Uixam?=
 =?us-ascii?Q?FNqb8WuNuDzMDABRHj8Ec1YMtugz/bGNmrsWAbs6Le0cD4H0O73VH5fW2tqB?=
 =?us-ascii?Q?M4y3UwEYm0mUX9dKkIFz4NB6HAxhZ+pSmOLBLuRoeKZks0wthSXmxrj5B8nX?=
 =?us-ascii?Q?H44iSEik65aw/b5FCtYIUrYqi0VD3wt3+RuDV+kwu6/19VuBX577vo6qGkwA?=
 =?us-ascii?Q?UFxDHLGKErLGCYUvZW8jv/J8X0fMoGkUDb1q1u0Dyqk2PorgRakUl2+WOGI4?=
 =?us-ascii?Q?jWXUG2PcJoh+rnJLZ4vqKGZdyOn285JxSsFLO0fudr6xniswqwprG0ymtzY3?=
 =?us-ascii?Q?/UAOrw4+D6O4YtwWGyTOV36I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3919e78-553b-4ae6-e93b-08d8eaa3de6d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 06:54:40.8837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QsGkqrmCzv99cARfoNQ7+XtZMdK9c5CvGAA6EnaZNdJUXz+Tm86MnjPEZe77qyfa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2620
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

Also drop unnecessary header file and declarations.

Change-Id: I877b48c32c599534798e14e271c3e700b0d6ebf6
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c  |   1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    |   1 -
 drivers/gpu/drm/amd/amdgpu/nv.c           |   1 -
 drivers/gpu/drm/amd/amdgpu/soc15.c        |   1 -
 drivers/gpu/drm/amd/pm/amdgpu_pm.c        |  10 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  61 +--------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 159 +++++++++++++---------
 7 files changed, 98 insertions(+), 136 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 33f748e5bbfc..1429c6897d3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -24,7 +24,6 @@
 #include <linux/list.h>
 #include "amdgpu.h"
 #include "amdgpu_xgmi.h"
-#include "amdgpu_smu.h"
 #include "amdgpu_ras.h"
 #include "soc15.h"
 #include "df/df_3_6_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d780b9c0926f..9a65ff871a58 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -29,7 +29,6 @@
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
 #include "amdgpu_psp.h"
-#include "amdgpu_smu.h"
 #include "nv.h"
 #include "nvd.h"
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index a31ef68ee2ab..e9cc3201054f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -34,7 +34,6 @@
 #include "amdgpu_vce.h"
 #include "amdgpu_ucode.h"
 #include "amdgpu_psp.h"
-#include "amdgpu_smu.h"
 #include "atom.h"
 #include "amd_pcie.h"
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 3808402cd964..c354a11e2fd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -76,7 +76,6 @@
 #include "smuio_v13_0.h"
 #include "dce_virtual.h"
 #include "mxgpu_ai.h"
-#include "amdgpu_smu.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
 #include <uapi/linux/kfd_ioctl.h>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 74fa5fe89970..10c761b11ff7 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -27,7 +27,6 @@
 #include "amdgpu_drv.h"
 #include "amdgpu_pm.h"
 #include "amdgpu_dpm.h"
-#include "amdgpu_smu.h"
 #include "atom.h"
 #include <linux/pci.h>
 #include <linux/hwmon.h>
@@ -930,14 +929,7 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
 		return ret;
 	}
 
-	if (is_support_sw_smu(adev)) {
-		ret = smu_sys_set_pp_feature_mask(&adev->smu, featuremask);
-		if (ret) {
-			pm_runtime_mark_last_busy(ddev->dev);
-			pm_runtime_put_autosuspend(ddev->dev);
-			return -EINVAL;
-		}
-	} else if (adev->powerplay.pp_funcs->set_ppfeature_status) {
+	if (adev->powerplay.pp_funcs->set_ppfeature_status) {
 		ret = amdgpu_dpm_set_ppfeature_status(adev, featuremask);
 		if (ret) {
 			pm_runtime_mark_last_busy(ddev->dev);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index ca5a0a436cad..517f333fbc4b 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1281,50 +1281,22 @@ int smu_load_microcode(struct smu_context *smu);
 
 int smu_check_fw_status(struct smu_context *smu);
 
-int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
-
-int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
-
 int smu_get_power_limit(struct smu_context *smu,
 			uint32_t *limit,
 			enum smu_ppt_limit_level limit_level);
 
-int smu_set_power_limit(void *handle, uint32_t limit);
-int smu_print_ppclk_levels(void *handle, enum pp_clock_type type, char *buf);
-
-int smu_od_edit_dpm_table(void *handle,
-			  enum PP_OD_DPM_TABLE_COMMAND type,
-			  long *input, uint32_t size);
-
-int smu_read_sensor(void *handle, int sensor, void *data, int *size);
-int smu_get_power_profile_mode(void *handle, char *buf);
-int smu_set_power_profile_mode(void *handle, long *param, uint32_t param_size);
-u32 smu_get_fan_control_mode(void *handle);
-int smu_set_fan_control_mode(struct smu_context *smu, int value);
-void smu_pp_set_fan_control_mode(void *handle, u32 value);
-int smu_get_fan_speed_percent(void *handle, u32 *speed);
-int smu_set_fan_speed_percent(void *handle, u32 speed);
-int smu_get_fan_speed_rpm(void *handle, uint32_t *speed);
-
-int smu_set_xgmi_pstate(void *handle,
-			uint32_t pstate);
-
 int smu_set_azalia_d3_pme(struct smu_context *smu);
 
 bool smu_baco_is_support(struct smu_context *smu);
-int smu_get_baco_capability(void *handle, bool *cap);
 
 int smu_baco_get_state(struct smu_context *smu, enum smu_baco_state *state);
 
 int smu_baco_enter(struct smu_context *smu);
 int smu_baco_exit(struct smu_context *smu);
-int smu_baco_set_state(void *handle, int state);
-
 
 bool smu_mode1_reset_is_support(struct smu_context *smu);
 bool smu_mode2_reset_is_support(struct smu_context *smu);
 int smu_mode1_reset(struct smu_context *smu);
-int smu_mode2_reset(void *handle);
 
 extern const struct amd_ip_funcs smu_ip_funcs;
 
@@ -1334,48 +1306,23 @@ extern const struct amdgpu_ip_block_version smu_v13_0_ip_block;
 
 bool is_support_sw_smu(struct amdgpu_device *adev);
 bool is_support_cclk_dpm(struct amdgpu_device *adev);
-int smu_reset(struct smu_context *smu);
-int smu_sys_get_pp_table(void *handle, char **table);
-int smu_sys_set_pp_table(void *handle, const char *buf, size_t size);
-int smu_get_power_num_states(void *handle, struct pp_states_info *state_info);
-enum amd_pm_state_type smu_get_current_power_state(void *handle);
 int smu_write_watermarks_table(struct smu_context *smu);
 
 /* smu to display interface */
 extern int smu_dpm_set_power_gate(void *handle, uint32_t block_type, bool gate);
-extern int smu_handle_task(struct smu_context *smu,
-			   enum amd_dpm_forced_level level,
-			   enum amd_pp_task task_id,
-			   bool lock_needed);
-extern int smu_handle_dpm_task(void *handle,
-			       enum amd_pp_task task_id,
-			       enum amd_pm_state_type *user_state);
-int smu_switch_power_profile(void *handle,
-			     enum PP_SMC_POWER_PROFILE type,
-			     bool en);
+
 int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			   uint32_t *min, uint32_t *max);
-u32 smu_get_mclk(void *handle, bool low);
-u32 smu_get_sclk(void *handle, bool low);
+
 int smu_set_soft_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			    uint32_t min, uint32_t max);
-enum amd_dpm_forced_level smu_get_performance_level(void *handle);
-int smu_force_performance_level(void *handle, enum amd_dpm_forced_level level);
+
 int smu_set_ac_dc(struct smu_context *smu);
-int smu_sys_get_pp_feature_mask(void *handle, char *buf);
-int smu_sys_set_pp_feature_mask(void *handle, uint64_t new_mask);
-int smu_force_ppclk_levels(void *handle, enum pp_clock_type type, uint32_t mask);
-int smu_set_mp1_state(void *handle,
-		      enum pp_mp1_state mp1_state);
-int smu_set_df_cstate(void *handle,
-		      enum pp_df_cstate state);
+
 int smu_allow_xgmi_power_down(struct smu_context *smu, bool en);
 
 int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
 
-ssize_t smu_sys_get_gpu_metrics(void *handle, void **table);
-
-int smu_enable_mgpu_fan_boost(void *handle);
 int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state);
 
 int smu_set_light_sbr(struct smu_context *smu, bool enable);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index db56cb3693a3..35aa1d234535 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -51,8 +51,19 @@ static const struct amd_pm_funcs swsmu_pm_funcs;
 static int smu_force_smuclk_levels(struct smu_context *smu,
 				   enum smu_clk_type clk_type,
 				   uint32_t mask);
-
-int smu_sys_get_pp_feature_mask(void *handle, char *buf)
+static int smu_handle_task(struct smu_context *smu,
+			   enum amd_dpm_forced_level level,
+			   enum amd_pp_task task_id,
+			   bool lock_needed);
+static int smu_reset(struct smu_context *smu);
+static int smu_set_fan_speed_percent(void *handle, u32 speed);
+static int smu_set_fan_control_mode(struct smu_context *smu, int value);
+static int smu_set_power_limit(void *handle, uint32_t limit);
+static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
+static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
+
+static int smu_sys_get_pp_feature_mask(void *handle,
+				       char *buf)
 {
 	struct smu_context *smu = handle;
 	int size = 0;
@@ -69,7 +80,8 @@ int smu_sys_get_pp_feature_mask(void *handle, char *buf)
 	return size;
 }
 
-int smu_sys_set_pp_feature_mask(void *handle, uint64_t new_mask)
+static int smu_sys_set_pp_feature_mask(void *handle,
+				       uint64_t new_mask)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
@@ -142,7 +154,7 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
 	return ret;
 }
 
-u32 smu_get_mclk(void *handle, bool low)
+static u32 smu_get_mclk(void *handle, bool low)
 {
 	struct smu_context *smu = handle;
 	uint32_t clk_freq;
@@ -156,7 +168,7 @@ u32 smu_get_mclk(void *handle, bool low)
 	return clk_freq * 100;
 }
 
-u32 smu_get_sclk(void *handle, bool low)
+static u32 smu_get_sclk(void *handle, bool low)
 {
 	struct smu_context *smu = handle;
 	uint32_t clk_freq;
@@ -256,7 +268,8 @@ static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
  *    Under this case, the smu->mutex lock protection is already enforced on
  *    the parent API smu_force_performance_level of the call path.
  */
-int smu_dpm_set_power_gate(void *handle, uint32_t block_type,
+int smu_dpm_set_power_gate(void *handle,
+			   uint32_t block_type,
 			   bool gate)
 {
 	struct smu_context *smu = handle;
@@ -412,8 +425,8 @@ static void smu_restore_dpm_user_profile(struct smu_context *smu)
 	smu->user_dpm_profile.flags &= ~SMU_DPM_USER_PROFILE_RESTORE;
 }
 
-int smu_get_power_num_states(void *handle,
-			     struct pp_states_info *state_info)
+static int smu_get_power_num_states(void *handle,
+				    struct pp_states_info *state_info)
 {
 	if (!state_info)
 		return -EINVAL;
@@ -448,7 +461,8 @@ bool is_support_cclk_dpm(struct amdgpu_device *adev)
 }
 
 
-int smu_sys_get_pp_table(void *handle, char **table)
+static int smu_sys_get_pp_table(void *handle,
+				char **table)
 {
 	struct smu_context *smu = handle;
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -474,7 +488,9 @@ int smu_sys_get_pp_table(void *handle, char **table)
 	return powerplay_table_size;
 }
 
-int smu_sys_set_pp_table(void *handle, const char *buf, size_t size)
+static int smu_sys_set_pp_table(void *handle,
+				const char *buf,
+				size_t size)
 {
 	struct smu_context *smu = handle;
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -638,6 +654,7 @@ static int smu_set_default_dpm_table(struct smu_context *smu)
 	return ret;
 }
 
+
 static int smu_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1538,8 +1555,8 @@ static int smu_resume(void *handle)
 	return 0;
 }
 
-int smu_display_configuration_change(void *handle,
-				     const struct amd_pp_display_configuration *display_config)
+static int smu_display_configuration_change(void *handle,
+					    const struct amd_pp_display_configuration *display_config)
 {
 	struct smu_context *smu = handle;
 	int index = 0;
@@ -1732,9 +1749,9 @@ int smu_handle_task(struct smu_context *smu,
 	return ret;
 }
 
-int smu_handle_dpm_task(void *handle,
-			enum amd_pp_task task_id,
-			enum amd_pm_state_type *user_state)
+static int smu_handle_dpm_task(void *handle,
+			       enum amd_pp_task task_id,
+			       enum amd_pm_state_type *user_state)
 {
 	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
@@ -1743,10 +1760,9 @@ int smu_handle_dpm_task(void *handle,
 
 }
 
-
-int smu_switch_power_profile(void *handle,
-			     enum PP_SMC_POWER_PROFILE type,
-			     bool en)
+static int smu_switch_power_profile(void *handle,
+				    enum PP_SMC_POWER_PROFILE type,
+				    bool en)
 {
 	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
@@ -1782,7 +1798,7 @@ int smu_switch_power_profile(void *handle,
 	return 0;
 }
 
-enum amd_dpm_forced_level smu_get_performance_level(void *handle)
+static enum amd_dpm_forced_level smu_get_performance_level(void *handle)
 {
 	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
@@ -1801,7 +1817,8 @@ enum amd_dpm_forced_level smu_get_performance_level(void *handle)
 	return level;
 }
 
-int smu_force_performance_level(void *handle, enum amd_dpm_forced_level level)
+static int smu_force_performance_level(void *handle,
+				       enum amd_dpm_forced_level level)
 {
 	struct smu_context *smu = handle;
 	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
@@ -1836,7 +1853,7 @@ int smu_force_performance_level(void *handle, enum amd_dpm_forced_level level)
 	return ret;
 }
 
-int smu_set_display_count(void *handle, uint32_t count)
+static int smu_set_display_count(void *handle, uint32_t count)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
@@ -1881,7 +1898,9 @@ static int smu_force_smuclk_levels(struct smu_context *smu,
 	return ret;
 }
 
-int smu_force_ppclk_levels(void *handle, enum pp_clock_type type, uint32_t mask)
+static int smu_force_ppclk_levels(void *handle,
+				  enum pp_clock_type type,
+				  uint32_t mask)
 {
 	struct smu_context *smu = handle;
 	enum smu_clk_type clk_type;
@@ -1925,8 +1944,8 @@ int smu_force_ppclk_levels(void *handle, enum pp_clock_type type, uint32_t mask)
  * However, the mp1 state setting should still be granted
  * even if the dpm_enabled cleared.
  */
-int smu_set_mp1_state(void *handle,
-		      enum pp_mp1_state mp1_state)
+static int smu_set_mp1_state(void *handle,
+			     enum pp_mp1_state mp1_state)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
@@ -1945,8 +1964,8 @@ int smu_set_mp1_state(void *handle,
 	return ret;
 }
 
-int smu_set_df_cstate(void *handle,
-		      enum pp_df_cstate state)
+static int smu_set_df_cstate(void *handle,
+			     enum pp_df_cstate state)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
@@ -2005,8 +2024,8 @@ int smu_write_watermarks_table(struct smu_context *smu)
 	return ret;
 }
 
-int smu_set_watermarks_for_clock_ranges(void *handle,
-					struct pp_smu_wm_range_sets *clock_ranges)
+static int smu_set_watermarks_for_clock_ranges(void *handle,
+					       struct pp_smu_wm_range_sets *clock_ranges)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
@@ -2143,7 +2162,7 @@ int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled)
 	return ret;
 }
 
-int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
+static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
@@ -2202,7 +2221,7 @@ int smu_get_power_limit(struct smu_context *smu,
 	return ret;
 }
 
-int smu_set_power_limit(void *handle, uint32_t limit)
+static int smu_set_power_limit(void *handle, uint32_t limit)
 {
 	struct smu_context *smu = handle;
 	uint32_t limit_type = limit >> 24;
@@ -2258,7 +2277,9 @@ static int smu_print_smuclk_levels(struct smu_context *smu, enum smu_clk_type cl
 	return ret;
 }
 
-int smu_print_ppclk_levels(void *handle, enum pp_clock_type type, char *buf)
+static int smu_print_ppclk_levels(void *handle,
+				  enum pp_clock_type type,
+				  char *buf)
 {
 	struct smu_context *smu = handle;
 	enum smu_clk_type clk_type;
@@ -2299,9 +2320,9 @@ int smu_print_ppclk_levels(void *handle, enum pp_clock_type type, char *buf)
 	return smu_print_smuclk_levels(smu, clk_type, buf);
 }
 
-int smu_od_edit_dpm_table(void *handle,
-			  enum PP_OD_DPM_TABLE_COMMAND type,
-			  long *input, uint32_t size)
+static int smu_od_edit_dpm_table(void *handle,
+				 enum PP_OD_DPM_TABLE_COMMAND type,
+				 long *input, uint32_t size)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
@@ -2320,7 +2341,10 @@ int smu_od_edit_dpm_table(void *handle,
 	return ret;
 }
 
-int smu_read_sensor(void *handle, int sensor, void *data, int *size_arg)
+static int smu_read_sensor(void *handle,
+			   int sensor,
+			   void *data,
+			   int *size_arg)
 {
 	struct smu_context *smu = handle;
 	struct smu_umd_pstate_table *pstate_table =
@@ -2387,7 +2411,7 @@ int smu_read_sensor(void *handle, int sensor, void *data, int *size_arg)
 	return ret;
 }
 
-int smu_get_power_profile_mode(void *handle, char *buf)
+static int smu_get_power_profile_mode(void *handle, char *buf)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
@@ -2405,7 +2429,9 @@ int smu_get_power_profile_mode(void *handle, char *buf)
 	return ret;
 }
 
-int smu_set_power_profile_mode(void *handle, long *param, uint32_t param_size)
+static int smu_set_power_profile_mode(void *handle,
+				      long *param,
+				      uint32_t param_size)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
@@ -2423,7 +2449,7 @@ int smu_set_power_profile_mode(void *handle, long *param, uint32_t param_size)
 }
 
 
-u32 smu_get_fan_control_mode(void *handle)
+static u32 smu_get_fan_control_mode(void *handle)
 {
 	struct smu_context *smu = handle;
 	u32 ret = 0;
@@ -2469,14 +2495,15 @@ int smu_set_fan_control_mode(struct smu_context *smu, int value)
 	return ret;
 }
 
-void smu_pp_set_fan_control_mode(void *handle, u32 value) {
+static void smu_pp_set_fan_control_mode(void *handle, u32 value)
+{
 	struct smu_context *smu = handle;
 
 	smu_set_fan_control_mode(smu, value);
 }
 
 
-int smu_get_fan_speed_percent(void *handle, u32 *speed)
+static int smu_get_fan_speed_percent(void *handle, u32 *speed)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
@@ -2494,7 +2521,7 @@ int smu_get_fan_speed_percent(void *handle, u32 *speed)
 	return ret;
 }
 
-int smu_set_fan_speed_percent(void *handle, u32 speed)
+static int smu_set_fan_speed_percent(void *handle, u32 speed)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
@@ -2517,7 +2544,7 @@ int smu_set_fan_speed_percent(void *handle, u32 speed)
 	return ret;
 }
 
-int smu_get_fan_speed_rpm(void *handle, uint32_t *speed)
+static int smu_get_fan_speed_rpm(void *handle, uint32_t *speed)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
@@ -2535,7 +2562,7 @@ int smu_get_fan_speed_rpm(void *handle, uint32_t *speed)
 	return ret;
 }
 
-int smu_set_deep_sleep_dcefclk(void *handle, uint32_t clk)
+static int smu_set_deep_sleep_dcefclk(void *handle, uint32_t clk)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
@@ -2552,9 +2579,9 @@ int smu_set_deep_sleep_dcefclk(void *handle, uint32_t clk)
 	return ret;
 }
 
-int smu_get_clock_by_type_with_latency(void *handle,
-				       enum amd_pp_clock_type type,
-				       struct pp_clock_levels_with_latency *clocks)
+static int smu_get_clock_by_type_with_latency(void *handle,
+					      enum amd_pp_clock_type type,
+					      struct pp_clock_levels_with_latency *clocks)
 {
 	struct smu_context *smu = handle;
 	enum smu_clk_type clk_type;
@@ -2593,8 +2620,8 @@ int smu_get_clock_by_type_with_latency(void *handle,
 	return ret;
 }
 
-int smu_display_clock_voltage_request(void *handle,
-				      struct pp_display_clock_request *clock_req)
+static int smu_display_clock_voltage_request(void *handle,
+					     struct pp_display_clock_request *clock_req)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
@@ -2613,8 +2640,8 @@ int smu_display_clock_voltage_request(void *handle,
 }
 
 
-int smu_display_disable_memory_clock_switch(void *handle,
-					    bool disable_memory_clock_switch)
+static int smu_display_disable_memory_clock_switch(void *handle,
+						   bool disable_memory_clock_switch)
 {
 	struct smu_context *smu = handle;
 	int ret = -EINVAL;
@@ -2632,8 +2659,8 @@ int smu_display_disable_memory_clock_switch(void *handle,
 	return ret;
 }
 
-int smu_set_xgmi_pstate(void *handle,
-			uint32_t pstate)
+static int smu_set_xgmi_pstate(void *handle,
+			       uint32_t pstate)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
@@ -2696,7 +2723,7 @@ bool smu_baco_is_support(struct smu_context *smu)
 	return ret;
 }
 
-int smu_get_baco_capability(void *handle, bool *cap)
+static int smu_get_baco_capability(void *handle, bool *cap)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
@@ -2769,7 +2796,7 @@ int smu_baco_exit(struct smu_context *smu)
 	return ret;
 }
 
-int smu_baco_set_state(void *handle, int state)
+static int smu_baco_set_state(void *handle, int state)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
@@ -2854,7 +2881,7 @@ int smu_mode1_reset(struct smu_context *smu)
 	return ret;
 }
 
-int smu_mode2_reset(void *handle)
+static int smu_mode2_reset(void *handle)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
@@ -2875,8 +2902,8 @@ int smu_mode2_reset(void *handle)
 	return ret;
 }
 
-int smu_get_max_sustainable_clocks_by_dc(void *handle,
-					 struct pp_smu_nv_clock_table *max_clocks)
+static int smu_get_max_sustainable_clocks_by_dc(void *handle,
+						struct pp_smu_nv_clock_table *max_clocks)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
@@ -2894,9 +2921,9 @@ int smu_get_max_sustainable_clocks_by_dc(void *handle,
 	return ret;
 }
 
-int smu_get_uclk_dpm_states(void *handle,
-			    unsigned int *clock_values_in_khz,
-			    unsigned int *num_states)
+static int smu_get_uclk_dpm_states(void *handle,
+				   unsigned int *clock_values_in_khz,
+				   unsigned int *num_states)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
@@ -2914,7 +2941,7 @@ int smu_get_uclk_dpm_states(void *handle,
 	return ret;
 }
 
-enum amd_pm_state_type smu_get_current_power_state(void *handle)
+static enum amd_pm_state_type smu_get_current_power_state(void *handle)
 {
 	struct smu_context *smu = handle;
 	enum amd_pm_state_type pm_state = POWER_STATE_TYPE_DEFAULT;
@@ -2932,8 +2959,8 @@ enum amd_pm_state_type smu_get_current_power_state(void *handle)
 	return pm_state;
 }
 
-int smu_get_dpm_clock_table(void *handle,
-			    struct dpm_clocks *clock_table)
+static int smu_get_dpm_clock_table(void *handle,
+				   struct dpm_clocks *clock_table)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
@@ -2951,7 +2978,7 @@ int smu_get_dpm_clock_table(void *handle,
 	return ret;
 }
 
-ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)
+static ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)
 {
 	struct smu_context *smu = handle;
 	ssize_t size;
@@ -2971,7 +2998,7 @@ ssize_t smu_sys_get_gpu_metrics(void *handle, void **table)
 	return size;
 }
 
-int smu_enable_mgpu_fan_boost(void *handle)
+static int smu_enable_mgpu_fan_boost(void *handle)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
