Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6B4C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 21:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3960164E57
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 21:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3960164E57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB9FD6E027;
	Fri, 12 Mar 2021 21:03:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE5D16E027
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 21:03:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwGgF5VYUS1wgIOtFzizdvlUHBBGWHoKpPvT+ZD+czH9Ic9QckZ4Xdlbd7djj0lh9m0mdyL2/dHSTPvtfcB8QvUd0dNs9s0OBagVUQXJHzB8D5g63eS8psW+cI0yk8rX/JtX957wBh8FAYfttWAk+H/FM1OnCOHgbS/wArGQ1RQGPCow9WG1ySwLIYg5uMQEPYgWiFIBcj8yiZ6PSqthTrolbBRmEFzDBUMv6wdZFMFJNGO+jWeE84nVAIWUUYuAco8Ql88mE5icKiFdBHRnHcOTUK+Aa8EbB7L29IYuhqyAEeyi2e0NH4yfRpb1ZBV61y2gUye3ZSTTzBwuujuaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EObI5pAbJAcjhdNRnBAodY/aPe5Rpa7NORNGGAZEXEc=;
 b=RkbeVexR424OGRQpvLmUtZW1zP4hkhrzTluTiMN68gIiJU4WTRmfF1S4xPhTaVdzewSFb4meD/La0UR2n/1mbFFCqrGxR96nV1gxzCTv0y+FyCl4V3xpIHlNK3MeQWvFzgqzLKnmghmKCZmmnt1RuelP4ZQTRsMn6fR7I3SfM+3Z6lS7lF5GO3QbWYRAZBSIG0uTDhfp3LjIHX0AoANzR4VvU65wiC50JJ+6dkDFZddLaPOfkVcSdE0MWUOQO6YS/UTw1Tam2qJT0WMYKxaAbvBRXsxrZvT+yneSvugL9/0bR4RzdzepA1flP1Vb2D8PL3dtT7Lzm+HWuc7Rl9Ubhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EObI5pAbJAcjhdNRnBAodY/aPe5Rpa7NORNGGAZEXEc=;
 b=SZHj8OukhcO4XVuvK2/Gl0CHAyAwKbwlAZgcLfEQHWeXDF/fEU/rkYoKFIcBAe6DR/XngoOG/Ja4eJeR2q96vVG+ZbnPb25ZINC4PGFlCvNbBvRYOpImG7Mx1lymVdN/IxhTzhw+PMQjYMRdeoOj2q7hYFE74WpRPF/MKOHQxPM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22)
 by DM6PR12MB4713.namprd12.prod.outlook.com (2603:10b6:5:7d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 12 Mar
 2021 21:03:49 +0000
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::70d3:105f:f05e:66b8]) by DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::70d3:105f:f05e:66b8%9]) with mapi id 15.20.3912.030; Fri, 12 Mar 2021
 21:03:49 +0000
From: Eric Huang <jinhuieric.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: fix incorrect default power limit in powerplay
Date: Fri, 12 Mar 2021 16:03:04 -0500
Message-Id: <20210312210304.23049-2-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210312210304.23049-1-jinhuieric.huang@amd.com>
References: <20210312210304.23049-1-jinhuieric.huang@amd.com>
X-Originating-IP: [2607:9880:2048:122:94cc:f8dc:e7db:eaee]
X-ClientProxiedBy: YT1PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::21)
 To DM5PR1201MB0234.namprd12.prod.outlook.com
 (2603:10b6:4:56::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from eric-HP-EliteBook-745-G4.amd.com
 (2607:9880:2048:122:94cc:f8dc:e7db:eaee) by
 YT1PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26 via Frontend Transport; Fri, 12 Mar 2021 21:03:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 067323ee-a575-4b34-d606-08d8e59a5535
X-MS-TrafficTypeDiagnostic: DM6PR12MB4713:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4713882CD4084722BF9E049C826F9@DM6PR12MB4713.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZRl3c0IsrZt3ZWf3ja768FO6bdhcTzel6FkKqsyBPUY0w6i+1lIWNW2NJPEwkRoZlHXcr+bzL2G9UGU44192cJr2Yl1vTgymbNebvoX2ESRpeurtcygp+ZdPDcInwXz+cmCLatEg3SAfE5nsATZp4W97Dj14eCVAClJiz+32pjbuHFmyEkGFO0O+s2h79+wEfa1DEikXLP3mpsvm/xP9qzxnk8hDUMxvFUm9Gmt9KyHFLGAH6GusIc3roJ0KGyi6VxzoQDf2YVG7Zpr6J8yZ692ROS7enSLdQ1sqEc8sER9/MxqGXMi0j/bp2l+0dLUT+QEq6LU6ymQYlRNuKWqbpRfj9+xekyKhOlco+3YxwY7GpFxPPDv27Bz6PqJ6lJbpCfDL95NyWRpbECJFsAag+SIgds/D62Po9IOflc0W1J3vb/vCN9nlubX21lytAFqASe6bb+udifGgt9+awypNezlM1LbXJKVxYXxiemUIdKsxJ9ev2wvngJmXv3G1eK0qte0t+o8xlTjqXOG7ZZD+dQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0234.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(478600001)(83380400001)(2906002)(66946007)(52116002)(16526019)(4326008)(316002)(8936002)(66476007)(186003)(5660300002)(6486002)(6916009)(7696005)(66556008)(8676002)(6666004)(86362001)(1076003)(36756003)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?iyEH5G9s7TzBcgion9Ish3X4U1Nht58aolu/5/fWjKRbp59GER0gz4Q0ZvGV?=
 =?us-ascii?Q?/EYTxeu45TuvrAelejU9TX3Q1g3TBT6adB2z2+0nYWc0qW28iSt5JBl9pRfS?=
 =?us-ascii?Q?crvQZmWtXRiU1idnzgMGrWsrFGt6ak7zlXYkF/JnKxhhmERnfX5nWSjhPJTU?=
 =?us-ascii?Q?AOkJArLPvcNjw50Y1VLIgkYqr8eneoQyL5Ui0+QvTg9hJ8BsPy03ihJYv4ej?=
 =?us-ascii?Q?9Fat4fMFfCOlM4PBLsp39far569Q7Q6CJoC+bfibLiXBwWVpeWNbnt8+TuI/?=
 =?us-ascii?Q?iCGyU2kgPebL8BC6FnJAYnidY/yZlcY1xPJp1zGJ74x5IrHCdW4fI+ZqGdf5?=
 =?us-ascii?Q?PKGVeLlAcI+9G5PDRRpMT0T78pD0BLCJMdz29+md8QZfsyst/DLLdPAEuN9K?=
 =?us-ascii?Q?pzQxdKMSZHoGQLNYppfTe5V4oROb5OmbRwr+dtH+kAiuD4yS9qCSy53yMMDv?=
 =?us-ascii?Q?fkVsTlHeaP943jHpC+k0NH99EGYl0MQ5EuDbkw5Fw3C8V6HN5GsPrvdVxOgI?=
 =?us-ascii?Q?YAPEZba2hLxOJlPakO+bJw706Z0bJbf5YTaG6yOTQYSGhhQ5IDGmgiDc8C+b?=
 =?us-ascii?Q?tKCDjTOcp3+WDIsNhJdIA4LYMLIAq0PHvPkLnPeak7yzE7oXd5kM6f7h/Abo?=
 =?us-ascii?Q?+VD4OKPIRbnMZCwmgC3bkUpsGOENJnTcGtzsxHOjRYla+5eoelpKLKJN7MlS?=
 =?us-ascii?Q?pXr+ROuPjXsczauk9gler3OrsFwufCeFNaKc/N3wpyicC8kUX2yLDnWwY0vF?=
 =?us-ascii?Q?8haqjkmtenFiu7rxsEPN8GAUQ5wsAkfMbEYdTWMkUY8xbn8oRhlVnVdnrFz3?=
 =?us-ascii?Q?8bkpS5yEeSKU4xPoLKFasbwR62dMyQZ+j19+vuy3U3NG0LffufeGqYUD9GEg?=
 =?us-ascii?Q?7Rzg3OvDse6uSBGu+JcQ06rqPrZktTljpapNGM4hiQvc+bku65qm7Sby3xn9?=
 =?us-ascii?Q?Z0ll2huwxw5Kg4z6n6w10kPwMDtfo23gNIujgsnBo6a75G8PFUnnKTt/d3xp?=
 =?us-ascii?Q?UvTrRx2s0pBn72G9r+qK6APPTv/Lx+VG71+KvMUTKafTqiHK0srdcYM90FPr?=
 =?us-ascii?Q?nklWoOy9cg/+TERS9EfEPTNdAIjUxQwprbVRI58XW0Yc32qP5BswIALEUO3r?=
 =?us-ascii?Q?Ubq2WjVoAdNz/S4ATJnkZBRZv3ZwAIfJonPIqt85fs6qT00Glk2pNx7BQEa9?=
 =?us-ascii?Q?6tnhq57thbClmZ30enURJ2UDJ+R/yMXq0R4XqKJ1NVPniFNbtXJF1tfQOWDN?=
 =?us-ascii?Q?5gd6Vxx7JQNL92anFPOdwWQPaoZkWM+Fxz+i8YhfOnw4LxBbOPqk4kiIg7Qt?=
 =?us-ascii?Q?YMvyO9REGNv32/A/pOd87fbKE8e37/UVX/Kzqgu614MbnLewypnknelcJqVR?=
 =?us-ascii?Q?HQNHrKJiD+cAMLBOiYV+SEsb3ZTz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 067323ee-a575-4b34-d606-08d8e59a5535
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0234.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 21:03:49.2569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEFdSVBLnFL6HODrgX7do2PdS/jcdiVDoCv15Kmd8HEgRDwEYMeDqfEREl6u53pGgzJns+A9A1ZG/73PXuHmSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4713
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Evan.Quan@amd.com,
 Joseph.Greathouse@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is no difference betweeen max and default to get
power limit in powerplay, adding a new parameter in the
funciton fixes it.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h   |  3 ++-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c               | 12 ++++++++----
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 11 ++++++-----
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 79e309a789f3..a0bdb0ac25fa 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -288,7 +288,8 @@ struct amd_pm_funcs {
 				uint32_t block_type, bool gate);
 	int (*set_clockgating_by_smu)(void *handle, uint32_t msg_id);
 	int (*set_power_limit)(void *handle, uint32_t n);
-	int (*get_power_limit)(void *handle, uint32_t *limit, bool default_limit);
+	int (*get_power_limit)(void *handle, uint32_t *limit, uint32_t *limit_max,
+			bool default_limit);
 	int (*get_power_profile_mode)(void *handle, char *buf);
 	int (*set_power_profile_mode)(void *handle, long *input, uint32_t size);
 	int (*set_fine_grain_clk_vol)(void *handle, uint32_t type, long *input, uint32_t size);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 8ab6e7eaf6a1..23b6cc1746c1 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2613,6 +2613,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int limit_type = to_sensor_dev_attr(attr)->index;
 	uint32_t limit = limit_type << 24;
+	uint32_t limit_max = 0;
 	ssize_t size;
 	int r;
 
@@ -2629,8 +2630,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
 		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_MAX);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
-		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit, true);
-		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
+		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
+				&limit, &limit_max, true);
+		size = snprintf(buf, PAGE_SIZE, "%u\n", limit_max * 1000000);
 	} else {
 		size = snprintf(buf, PAGE_SIZE, "\n");
 	}
@@ -2665,7 +2667,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
 		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_CURRENT);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
-		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit, false);
+		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
+				&limit, NULL, false);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else {
 		size = snprintf(buf, PAGE_SIZE, "\n");
@@ -2701,7 +2704,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
 		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_DEFAULT);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else if (pp_funcs && pp_funcs->get_power_limit) {
-		pp_funcs->get_power_limit(adev->powerplay.pp_handle, &limit, true);
+		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
+				&limit, NULL, true);
 		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
 	} else {
 		size = snprintf(buf, PAGE_SIZE, "\n");
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index e0d288208220..b60f46b80ccd 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1034,7 +1034,8 @@ static int pp_set_power_limit(void *handle, uint32_t limit)
 	return 0;
 }
 
-static int pp_get_power_limit(void *handle, uint32_t *limit, bool default_limit)
+static int pp_get_power_limit(void *handle, uint32_t *limit,
+		uint32_t *limit_max, bool default_limit)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
@@ -1045,10 +1046,10 @@ static int pp_get_power_limit(void *handle, uint32_t *limit, bool default_limit)
 
 	if (default_limit) {
 		*limit = hwmgr->default_power_limit;
-		if (hwmgr->od_enabled) {
-			*limit *= (100 + hwmgr->platform_descriptor.TDPODLimit);
-			*limit /= 100;
-		}
+		if (limit_max && hwmgr->od_enabled)
+			*limit_max = *limit *
+				(100 + hwmgr->platform_descriptor.TDPODLimit) /
+				100;
 	}
 	else
 		*limit = hwmgr->power_limit;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
