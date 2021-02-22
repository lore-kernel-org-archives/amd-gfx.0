Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C78AC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 04:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA91960230
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 04:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA91960230
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DB3F6E4AF;
	Mon, 22 Feb 2021 04:04:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3034F6E4AF
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Feb 2021 04:03:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5JhEJETIND9ZayxDctMH2Qoprj9fWxf+Acf9zQM4uNqtlCcvxqCNzcrdEpBuasS6IACMeg4YjWLI/yI9e1O6oyZ5IISSwao06SCY8kRedyeehEWOY5k1bMkADvRUyzYXNPrkv48XPIYzDUl3l1oRWOM7KRi0m8KsH8MYH722SBuZPwSNLeztnfkDiyZS2Q+NO/GVyN2Afl/+l6uC/j1pdDJL6RwPEzefwqjx4L9AQWKBlu9Wpe7dvUMzJA7n/IDSrgaCUjDKNWjEKT9SGsNsVLFv2c6hZj7I+QSrLOrAAYlNxIEHZjrOJb+IuDdm2OvKgcUQKQWwuf99w9ZAW7kbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SElXYvMPAdbnfPzt38E1YJ9raqNTreT42lbpRASCs0g=;
 b=MSTvRMyrcHWr4yfBROvtDXy5kjnobz/efesankEA90n4ul0BayVFFqCyZwDgFKkkNx8pcZ0zDl2VDV9apVI6+MhVGQp7a25Xv2CVWXmcp2BtN7mIB+w5xs75zhX41gW82291e+MYNPFRmSkNZJ63lt/bZD4mDVhkYMVlUF45Vozj/mbYOgOv2vWBtHWLtGSuX+7mgAqdES6rECcQ9khHuBK+TNfYUw2QhBArkXNZEqsVaxamNi89KAngVEAPSYCRuBQeaPwiyVfB4mq4obMxIAe29k5mzlem76AFC6Rx+JhiWK1xbCRlf0Xyd+3M2Co2JwK77nD8DQoUMnAaq0ORoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SElXYvMPAdbnfPzt38E1YJ9raqNTreT42lbpRASCs0g=;
 b=Wen7Kaw2LnZlOHFz69hK7fGbaRYJjclDNolw9afYVsCj6m1Ydl4bV1DabvbsnxCGqknPI7Nv7laMli4vuITGzgTzyYqyGaLnYtpVz+F0zNwHsbhDszLOch4koFaAw/uvMjPyElqV79IGZ9XB+CXPmZG4iM8NgX8+BtsLRzs6VPg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27; Mon, 22 Feb 2021 04:03:56 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3868.032; Mon, 22 Feb 2021
 04:03:56 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: optimize the link width/speed retrieving
Date: Mon, 22 Feb 2021 12:03:29 +0800
Message-Id: <20210222040329.1280956-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210222040329.1280956-1-evan.quan@amd.com>
References: <20210222040329.1280956-1-evan.quan@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:d0::16) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HKAPR04CA0006.apcprd04.prod.outlook.com (2603:1096:203:d0::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27 via Frontend Transport; Mon, 22 Feb 2021 04:03:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 16373489-080c-4901-e802-08d8d6e6e03a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4124:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4124745DF629D85BADE4A258E4819@DM6PR12MB4124.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VvhudJ2jtbQ2hdqzQKPWQ6f4By5cSXb5PWpMWA/eWpeN2uJn5/p7z7uKIDHXailpCiBA/CHVVO30VenpBBtFe/jmD2Bwu5V+yuM3TsZ7ThvtI1Pq3ucJCAGDQ+Ue3c1T+2I/k1PhUHx+WlCvHUvCEdl8NdttERoqn0BLvDhFsTceKrk8K68JLAQATUjny27BpvBiFloOC8Qszb0tzJNikq/cYzFMdX+CahBRjtG76I57zG7/iqE5Bg2URm0IBfP+k68Y/BA0MuyuUltEyW6eOcaj5So9rgv0yzoR+igghSosJglCUOi6Led3VkfxPFLmqhzH4j74MCONaN4PF5A98jlNya9YQX6ZsheNgae2eJ7KGUmE4ybGDpwU32bNTFktgbXZL7tsGf3NMOlBhC7hLhqlttaeipNUPL1EZfx/tm7pLd/gLFDNbMeRLiMhhKf4PIMTWduWxu7t5s/+izDYds2flytE6d47jcg9Yyh2aQNPl8ntmTXMWgJ6dKfSG9FBEZKsk83w/aYKiZ48xRC3RA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(2906002)(8676002)(6666004)(8936002)(5660300002)(478600001)(1076003)(6916009)(66556008)(4326008)(66476007)(6486002)(36756003)(44832011)(316002)(86362001)(956004)(186003)(7696005)(66946007)(26005)(52116002)(16526019)(83380400001)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pNtRz323rcUKktC5CzVkaf/qJEcqn1giTMOWxWCar+FqEF95Ylbu0nAQbkvK?=
 =?us-ascii?Q?qOseTVfjUCvbC1cxPTZiFNUIZWjcEnpB+6KFVJyFs3KitO7JbTSzgCHRIyfd?=
 =?us-ascii?Q?dm96FkUX6/VBxo2rs4LInrw9FBFzMsx/JdNQZM6MOpf14Mc3GLIetxYrlqEO?=
 =?us-ascii?Q?P8QMplIsuuZSTXjL3WiNHpHfVD44lV9MCD+yKIKuo2xEVda1xhiU19uqDTBj?=
 =?us-ascii?Q?GbIP6UbbjnIafh2C+aOsk//BcKIKxDjAILYlwJpi838X2LOtqMrNrPimR5nS?=
 =?us-ascii?Q?XkKYbcGZlri/JYUTmWoQVV3ilchjf7aYyv3egJmOznWuFp7rAA/i6Hr0bN3z?=
 =?us-ascii?Q?C5sQ1Q8dXZxNbKZnUY9vmpiS3g8/AmJaw+6pugJpKe7YjJS5/bY0xKPxdui1?=
 =?us-ascii?Q?HSMdEF92WDb+SiYKrdYewVkqRUxyJ+BEQhvqjE3SfH9kdPTKCKpTabwrIUNh?=
 =?us-ascii?Q?upMJSef6N5vm8ihnYIcP+uSeF5bUOS1owT13ZVFpbaQhWkIc4hXpCXq/bkk4?=
 =?us-ascii?Q?m7p9fzozuhYHc8gX0FCyGto81jfxgcdssN/oW3RUXJpA1dcf3C+jIoKgBA99?=
 =?us-ascii?Q?K7hwhBLDoR6s6FkUJJSyBEQ2hS18sCqOW2FwEYmEkBDs4TuuH9S/vP21GfqI?=
 =?us-ascii?Q?pdJHJo1rf1Wj8NwqYgyoEWBxyoTw6hxLKK4t/DiajKBJud9o8kQkw4KVmWa8?=
 =?us-ascii?Q?zGRsYxCTUjyJgBFIs67xH1qTeIuZmyRD1yqsfuhfCO9wH6PyzWS/6NQP8M8a?=
 =?us-ascii?Q?BWwAR/j9DZ/jk1ldGS3lbtk1Ktr6LisulCtkNF4wZfGX9RlwSf5TmWvqXs3g?=
 =?us-ascii?Q?WKMFG61FGsxlCLVjoyG64EIMmyHV5wBONOornLZOHgC96i5sGbpSAmArEOKc?=
 =?us-ascii?Q?b6KotXHdLl2oYiNhRtQUMUzY9IcYnNoY/K3wUqI5IGm7xIaJMYrFlRyyLHvm?=
 =?us-ascii?Q?mLqdDHnmwaGpmDKDadFrR+uocp3r1Nmtc4+XZjJuC0rezwybNXnvKYM/AInT?=
 =?us-ascii?Q?fyjMwIKZ+lgPZn7GrZWynPSEJPxXH0F0fdLgj49Qd5CvL4jI8M48uWi2Cnhs?=
 =?us-ascii?Q?bRWgYQ3TpIZ9nrQkMujse3yuK7nUqHt4BxXoX5+MJcTGUrSMT21GUKyPDC8l?=
 =?us-ascii?Q?llTSjc/CJ+nKg1j+/dKW/1I+Hv8gFf/p74gyeC8ZzIG9EFOphOD4Kitwrik+?=
 =?us-ascii?Q?WJaNU5FDC5bCETN3nEafrz+NHxJ12FOQxJnspWMba8fSUA/kJp5Y9ACmj7ci?=
 =?us-ascii?Q?JRwRjr9rtk7oxNWsy9EuMj/wlLai9t6lzLtU8bA/fAG230Uibx5MiEqUYLt0?=
 =?us-ascii?Q?zkVV9QVs1Ofev0xnzj06c9Gh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16373489-080c-4901-e802-08d8d6e6e03a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 04:03:56.8162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTcMoS23MU3EvoAw61cj06pjmqiJIkuFoT8IUkKsDtDmqD38oyx4q6Vd7pcaVq3u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

By using the information provided by PMFW when available.

Change-Id: I1afec4cd07ac9608861ee07c449e320e3f36a932
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 17 ++++++++++----
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 22 +++++++++++++++----
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 29e04f33f276..7fe2876c99fe 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -72,6 +72,8 @@
 
 #define SMU_11_0_GFX_BUSY_THRESHOLD 15
 
+static uint16_t link_speed[] = {25, 50, 80, 160};
+
 static struct cmn2asic_msg_mapping navi10_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,			1),
 	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,		1),
@@ -2391,10 +2393,17 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
-	gpu_metrics->pcie_link_width =
-			smu_v11_0_get_current_pcie_link_width(smu);
-	gpu_metrics->pcie_link_speed =
-			smu_v11_0_get_current_pcie_link_speed(smu);
+	if (((adev->asic_type == CHIP_NAVI14) && smu_version > 0x00351F00) ||
+	      ((adev->asic_type == CHIP_NAVI12) && smu_version > 0x00341C00) ||
+	      ((adev->asic_type == CHIP_NAVI10) && smu_version > 0x002A3B00)) {
+		gpu_metrics->pcie_link_width = (uint16_t)metrics.PcieWidth;
+		gpu_metrics->pcie_link_speed = link_speed[metrics.PcieRate];
+	} else {
+		gpu_metrics->pcie_link_width =
+				smu_v11_0_get_current_pcie_link_width(smu);
+		gpu_metrics->pcie_link_speed =
+				smu_v11_0_get_current_pcie_link_speed(smu);
+	}
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index e74299da1739..6fd95764c952 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -73,6 +73,8 @@
 
 #define SMU_11_0_7_GFX_BUSY_THRESHOLD 15
 
+static uint16_t link_speed[] = {25, 50, 80, 160};
+
 static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
 	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,               1),
@@ -3124,6 +3126,8 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	SmuMetricsExternal_t metrics_external;
 	SmuMetrics_t *metrics =
 		&(metrics_external.SmuMetrics);
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t smu_version;
 	int ret = 0;
 
 	ret = smu_cmn_get_metrics_table(smu,
@@ -3170,10 +3174,20 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->current_fan_speed = metrics->CurrFanSpeed;
 
-	gpu_metrics->pcie_link_width =
-			smu_v11_0_get_current_pcie_link_width(smu);
-	gpu_metrics->pcie_link_speed =
-			smu_v11_0_get_current_pcie_link_speed(smu);
+	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (ret)
+		return ret;
+
+	if (((adev->asic_type == CHIP_SIENNA_CICHLID) && smu_version > 0x003A1E00) ||
+	      ((adev->asic_type == CHIP_NAVY_FLOUNDER) && smu_version > 0x00410400)) {
+		gpu_metrics->pcie_link_width = (uint16_t)metrics->PcieWidth;
+		gpu_metrics->pcie_link_speed = link_speed[metrics->PcieRate];
+	} else {
+		gpu_metrics->pcie_link_width =
+				smu_v11_0_get_current_pcie_link_width(smu);
+		gpu_metrics->pcie_link_speed =
+				smu_v11_0_get_current_pcie_link_speed(smu);
+	}
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
