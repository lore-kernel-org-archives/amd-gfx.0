Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE5FC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF17207DA
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="r6RlcePQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF17207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB72C6E081;
	Fri,  3 Jul 2020 08:58:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 930816E081
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 08:58:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyIJPudMA2L3RbtC5MgqKQWLVEmmC6hyX5nmCGbWnhd74x/x2UYVtpEomchjkePXCRtwytPGVvGZi3p8GCxvcG8VfMD/P/Ha4ZKtG/P41ruiVu/e1d425H+Z70EU1X7CA9ycrilBJBD0ADD/FwXCUjwTCJ071MkMuoiMxKnlxFsdtG+ROaNXWgP13WEVXZmTd+FLCAGiiuIisFmlBrcdS6QwaPAjPt5VAb1GjWYx+hdS4Sc8QQSq14KgfFtt2b09gdKzs9SItaNsTWM/WfUPZiujqvpnGEwHqpEGzvRyiSNw0fWBrScH9jultcsZrZxP3Fz5XDVbXUwqQgYf8Ff0jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tH81CEMayicF12c/7suUU2IRHu55Kq5JpiLD+8sTPcM=;
 b=Pj7kx4F8P3WAFQY240OYtanG9ZK3xaQOw8ame39VGuw9ic3WJOvUjZxmEvpWvngr8nis4kvj4eUBFaDLZ/NFeq63TQqwifLSruR0nVBX9HBl3nOBhcROgzcGZnhAbA31zOHd50IFEh2xEyuYddUU9q08O6QNgDQm+v0kQz5sss/TrE8Y99xRoGWPvnyOzlnXBplbuikAyssQio2lbEqpPaJVUTp1K64XtdeqlL9KShIfpQjXL6ymRxgnNnka1lKLYn/q7nbyKDhKe+4dXLd05m3WT/vK6WG1Q0SCMAjAZjRwK2oEyt3jG057JkQ247wz9UzGRdrbTJ9l3SZJkjinLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tH81CEMayicF12c/7suUU2IRHu55Kq5JpiLD+8sTPcM=;
 b=r6RlcePQ6ujpjv63V0DlMga840oh9dTQdlCEc5DPcwsR2R2j9ByofFi9oJYVLz08Ax+8rRYVKiLXc+Mb89GYTMrpOU12TCkfz+nE7k+5kUEsqJe3oykGY7SFNN0oOfszf7BhC6VvvoiXd5nADcZGG0EhTUYddAZrYLG4JTqrP+c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20; Fri, 3 Jul 2020 08:58:39 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 08:58:39 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/6] drm/amd/powerplay: correct Navi1X temperature limit
 settings
Date: Fri,  3 Jul 2020 16:58:13 +0800
Message-Id: <20200703085818.7800-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::33) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.1 via Frontend Transport; Fri, 3 Jul 2020 08:58:38 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c72f293b-5a19-455e-0df8-08d81f2f4735
X-MS-TrafficTypeDiagnostic: DM6PR12MB4353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4353DC5261D354B633D1E38BE46A0@DM6PR12MB4353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kKOd8V9J+rGcsc5YYrJAb6tPSXrtSyCVQqhkXVFZVcFJVYtPoe2gIrg0lJrIpPLeIp5XPnBnP6cMEd1NrkHb7c27NV0hi2fQzjfl8TVrF8Ty2hVlHgJgth4/pH+lSarAT1Gzkiv4T1PAhY0zWNqGtvALaln2mJNIc4q7qAIlvoOB8gZ/wuDQl7Sc34AxpneCgN4Q4wgSlfip+ViSdBrIZ5Zl4QmY6uxlyKJIui6XDdGkudq/qgRAyERIqRqjhLUHP3ByCTLs6+4F0tBIIYcJ4ZGokMTvtg29KJyPEYNuyjdctlqWC1n575WyJRLvNb73L6Du0eV5yXW+3U5UN+Qczs00G8BN0DPGbIlbTmt7CiAYwIpMfic+ProEXvIYvX4X
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(956004)(478600001)(86362001)(4326008)(6486002)(8676002)(2906002)(8936002)(5660300002)(36756003)(83380400001)(6666004)(2616005)(6916009)(186003)(316002)(44832011)(66476007)(52116002)(1076003)(26005)(66946007)(66556008)(16526019)(7696005)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 6XhUfRkjBoGgdv2mo+5I3pm+++ilqr0q3H2/JdfxQLz47JNLX6F6wKKw1+7XCwSjg3lUAYPQPXS/EgPwoJvpAR96yXYeAJSg8hSz55P32xKvLL2Mpvlf7RbmXikjfe/9yGkxTHoJsk+h0zczXqqRPqn7CsBKVBsF/Sm1fsrlm8O95H9pHvlFzNYYJEBs3yAEERF8VDnMEwW1I7qFmEgyi8eDfVvX2zYRDkI1ndAQD55WtMDnQIwByQPotQUkG52DEKcDP4JiRnvlHEUefJHf/8TGnYkgsJUdmHDVYkSdFHMq0zuDlBKhKEgaSoaBuuk/orXZ8CEo/CoW0cnvF3zvWom33fPN8XkgJ1FXVkADAdwj7WqfwOppxGND4e+UkC4RHHSSgLT0ruP1/21+7hDXtg4jzXJ4hFei+WWPozr1cebzSBSsobFvuKjxG2MWPf0bRDDHGpHbsx5cWwMhO88JKJH2TNQP8ObLwJ8cz51tOzgE2xvnHc+t2lpA04HKYNj2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c72f293b-5a19-455e-0df8-08d81f2f4735
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:58:39.3617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDjmrNAkJK0Y1UXJbpz3janlzYoxUKhk5YbmKp4UN3QOj7QynJGjxYduRGcR24tZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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

These are needed for temp1/2/3 related hwmon interfaces.

Change-Id: I4fe04dc65ba2153bbb9c507769a9d8ddeac66094
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c  |  6 +-----
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  4 ++++
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 17 +++++++++++++----
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 3687e7620eb8..0b33cde05133 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -56,10 +56,6 @@
 
 #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
-#define CTF_OFFSET_EDGE			5
-#define CTF_OFFSET_HOTSPOT		5
-#define CTF_OFFSET_HBM			5
-
 #define MSG_MAP(msg, index, valid_in_vf) \
 	[SMU_MSG_##msg] = {1, (index), (valid_in_vf)}
 #define ARCTURUS_FEA_MAP(smu_feature, arcturus_feature) \
@@ -1048,7 +1044,7 @@ static int arcturus_get_thermal_temperature_range(struct smu_context *smu,
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	range->mem_crit_max = pptable->TmemLimit *
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-	range->mem_emergency_max = (pptable->TmemLimit + CTF_OFFSET_HBM)*
+	range->mem_emergency_max = (pptable->TmemLimit + CTF_OFFSET_MEM)*
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 311166f1975c..4de3cdcae437 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -66,6 +66,10 @@
 #define WORKLOAD_MAP(profile, workload) \
 	[profile] = {1, (workload)}
 
+#define CTF_OFFSET_EDGE			5
+#define CTF_OFFSET_HOTSPOT		5
+#define CTF_OFFSET_MEM			5
+
 static const struct smu_temperature_range smu11_thermal_policy[] =
 {
 	{-273150,  99000, 99000, -273150, 99000, 99000, -273150, 99000, 99000},
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 97d14539c95e..350b469646bd 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1856,13 +1856,22 @@ static int navi10_get_uclk_dpm_states(struct smu_context *smu, uint32_t *clocks_
 static int navi10_get_thermal_temperature_range(struct smu_context *smu,
 						struct smu_temperature_range *range)
 {
-	struct smu_table_context *table_context = &smu->smu_table;
-	struct smu_11_0_powerplay_table *powerplay_table = table_context->power_play_table;
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
 
-	if (!range || !powerplay_table)
+	if (!range)
 		return -EINVAL;
 
-	range->max = powerplay_table->software_shutdown_temp *
+	range->max = pptable->TedgeLimit *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->edge_emergency_max = (pptable->TedgeLimit + CTF_OFFSET_EDGE) *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->hotspot_crit_max = pptable->ThotspotLimit *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->hotspot_emergency_max = (pptable->ThotspotLimit + CTF_OFFSET_HOTSPOT) *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->mem_crit_max = pptable->TmemLimit *
+		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->mem_emergency_max = (pptable->TmemLimit + CTF_OFFSET_MEM)*
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 
 	return 0;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
