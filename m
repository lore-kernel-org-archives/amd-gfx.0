Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64ABC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954D764DDF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954D764DDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5276F89E08;
	Mon, 15 Mar 2021 11:23:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3689789E0C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 11:23:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZVgc0PjEDUwufI6WVWIdaF+RFZAegR7Num9egXl4N8ZFoX4+2D3PobXCNkVCvbIJI2hPpk2Q9AKkCxR1XKd1uYWUIXYNmrNApxLTt833O2NMpWePVH7ZQr6jjOPvvZtyZC7dJPvABe87UsTY9Kdbl2iZDvYsy07cDn6UN5v1fvRNMy+W9aF/Kr31qXRxSNqcudW0xaeZurxO6iijSDHEBlvW8LxEMMl6KvqoPbY8pYlHfvaLXVMav7E96kkSTLQQ9doHcGfvb1q1XBBP0MWcVfd7QYZFRsTsJDH5Fy34TgGjG2ItYvvV4iDOQidBCtfzT8dniEdHjUXNtDcnoDqeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiQYhnB8OCJAr6+xlJ6GHQqNsLKVV0B9qZsPhLT8A30=;
 b=RR332z/SWkrGwzfmel7NI3pQRNRVklAApdAZlLb8DG73xeWmGE0gpDzDnM35TKB1IA4sks9UVVTuag7H+Q40CSC8RPwx048bU+A7pVgY6rqhMlUb5arScnV6AbpSbzqbqtG6mWJ61/oxLQ/17pewoLOWacKXi5r5zdFIGcVq4f15WfhTCi20nyxZOKFarCbdjvplK1fu4cqgXIUSzk3CAviSiSjgqN0yHfzoylwPN3vMRDnLiUQa/B8vc8l5LlYq41oIfW4F5scJe/bam1JxWWEZH6fo8lzcOvWBgHUFkZz8GO56N+YnRGrQyxyVlA5RUBjTDRPYsBQTp9PxfQyV4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiQYhnB8OCJAr6+xlJ6GHQqNsLKVV0B9qZsPhLT8A30=;
 b=FxDx3ewd9kYNF5cRxSsrh8FsyzZmhVu1x0Xm2NR1Z0GnN6GdNcHE+nrZft2/x0958KwPQD1Mu2MYr0eyYXaWu1vphym3+2qo7VbnXW1XTViBHBQMCF+aBadbPDRYZzyfUEEIGbnGkCTDLZ2t7kcizGxUFhO8vEkffeSgX53aY/8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 DM6PR12MB4617.namprd12.prod.outlook.com (2603:10b6:5:35::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 11:23:25 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:23:25 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/23] drm/amd/display: Add debugfs to control DMUB trace
 buffer events
Date: Mon, 15 Mar 2021 09:40:03 +0800
Message-Id: <20210315014010.16238-17-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210315014010.16238-1-solomon.chiu@amd.com>
References: <20210315014010.16238-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To DM6PR12MB2604.namprd12.prod.outlook.com
 (2603:10b6:5:4d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 11:23:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e2ff88f2-77a5-4b4a-afab-08d8e7a4bfa4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4617:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4617ED512976B61295A41C63976C9@DM6PR12MB4617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ehs+413QqpFsNcRE3yQHwNTVW+fqQihjFAruiotCh31IBOqZwZX2QuwgG2hMDTnjFibjT11QISVwB+IVepr8VukfRRlZB0stf9ayYLvge9Qt1ywS2+iJlKV+p0xcoPkqyGA35whYzApDcrQlbx/u81yt7GLb61nQ/YMqfhuZsQu28ESNVdGOEO/hh4UOsHW0fs/BuaRnAfWg/UB2ZlcyO9LBpOMEkWaX0OZXTVikrBkcMHO69OKgr/H6MZsnPgpW5buSuExQVM4N2SYDieDGI4ZIREskjfsXYF/LieiDcxaOJtewZ4teiXFWlNr6sobciRd3bdSFOq3mo5o9s+lunTAO+ygLYsBNwvn26ClyQoMiJYJBT1H+2b1WLAMjyPYyf0G9ULUtRBnV7C/o5ttbwzpJGe3MT7nMZFFnuIXM3lmsSKRCGM9EoAfdk4oiN6xFGZQbbbWKGdS7zAczTtw66Qa3LIMC79uBUg627UHUpvInTq19ERsFU2nwogXCVFUbi5eZWeZXnjLu7564X3dgFyBG/5Q7t7MKfX23UX+XsxagtJlBr4iOFGG87XccCGEb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(8676002)(6666004)(54906003)(8936002)(52116002)(4326008)(86362001)(5660300002)(316002)(186003)(16526019)(26005)(2616005)(2906002)(6486002)(6512007)(66946007)(66556008)(36756003)(6916009)(956004)(44832011)(66476007)(6506007)(478600001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VjPzgHVp/5Lah/3eX0mqBxwAEQKSZLVS35oSBBW4ZeMoEGnD4UC+30KGVqRS?=
 =?us-ascii?Q?XoC574t3iA9Sn03t3zM6E+8ASl5cn3XnKZraazC296iCCjbTGt6J4cJRgTGZ?=
 =?us-ascii?Q?rjk18iAB/7nIjPIGHHpaU2MMqABbAZMzJ6ZYjht4OP6eX9XMQ6noXrIu9T6w?=
 =?us-ascii?Q?5qqWdvHR/gim5CyOC4PvnlaD2TllDfCbDbyl+9IdJZ340/ARD6c93/sPXdtl?=
 =?us-ascii?Q?jXNsgQW67tQKxzlDd7CXwPg3vJuRn0eyswV+EEVIr3du2lllWMHiwXuA+vU3?=
 =?us-ascii?Q?ZVftYJYWj6JOObsp59liDihnZXTj7Nr/4V5MnmLY7zOdncSUh7OI42PnFCCm?=
 =?us-ascii?Q?8SarA30bQtW442jj2u51h9UpSpHAVdBiAwiOFu/tgg2w7PlFGoY+TJkP7/eH?=
 =?us-ascii?Q?61AnutMU6NmfgMXvRGryAWgLU01z3V4R2rLWSlzsIc1b99WDUgZ6QNgVGSlV?=
 =?us-ascii?Q?ZuiqyyCP9HEN9EUhiTybsXP7EJbCLpPwe8LQHV4UwfWdx6wh7u4yMbAYoMj+?=
 =?us-ascii?Q?y/oiB74oWfUb5PfQ/K+aYtSJw3wQI38HEXOyX0nb9TOaZvrFUbUrEgxvwNzd?=
 =?us-ascii?Q?MCqHrYNemENMTCvv1l26EqRMREVgmGv1mHjA8LAlmbqdezB23G7nyWgGzqOF?=
 =?us-ascii?Q?63Nn5jbz9LSbg/HEUqkor1AeuFI2nrttunX75Bop1bbzzKguX4m6YEl48LGA?=
 =?us-ascii?Q?B32PutR5ZAMQTS46cu5cqaWCSaCb0ANTazBDwqYAwqTM8g2yyOAL0ItRjJoT?=
 =?us-ascii?Q?tEyV4VUoR05IasHa3dkc8Zpm/RXBAEHQnKU5XL3gFzyW3LW6ZkX4bPoMUOiY?=
 =?us-ascii?Q?ndazQYvIzJkG9iDO1Nud7IDW5pFUO3R/UlQydXP7z6Xf8WzMmKIV3KvkiGe7?=
 =?us-ascii?Q?nog332wJ7vUAnHdrlRPNN9FPkvkWrtgMa+JSD3+FIjTLiS0kQYS4zSCDTDG5?=
 =?us-ascii?Q?xs/JtCUb6FG1WdPY3HmrRG53CL7zH8TBZuzM7u3zcigjKV1BM6nlhfpvLS0I?=
 =?us-ascii?Q?wEOxDjwcsidK2WbcNVERXDi7U1t779VPw2HrbcjUkPOtNpvARDaC0yoblyeN?=
 =?us-ascii?Q?DV5M9Q7F7W1bUS7C3tYipIZDFnqirVKzr23tnlWPToWxK4maekLfbRL/NRNF?=
 =?us-ascii?Q?Z6tb5ERWoXJL9peE7xEhJ/9JFcSkRTuT0kfxiLX7TdSi3cU73g4mV2qFNzTC?=
 =?us-ascii?Q?t5VnHpZUOQMjcz21Ds/WLxShdaypVzRPs9F+hsE78YixrG0DRoTUO03pN0Ei?=
 =?us-ascii?Q?Aym+RP19c2tmYO4U07rlgqDV3RS/c64YNGMxbx23ItXtAXNd32XDlKrcNcKB?=
 =?us-ascii?Q?pKRGHpmNK6wlCMU3ac2EVcg0X6WnKjAeG9cJLfp72wVaGg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ff88f2-77a5-4b4a-afab-08d8e7a4bfa4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:23:25.0767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSK+4+zBHXZljSO6Us7/o+iFNlpintP4uZN+G7XLPX+F8A2Kg/JsfzWo1k9JyRqB+WxfCFi6A1U7BlRj0jEH+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4617
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
Cc: Eryk.Brol@amd.com, Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why]
We want to have a debugfs interface to enable or disable DMCUB
trace buffer events.

[How]
Add debugfs interface to enable or disable trace buffer events.

Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 37 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index be931efc772d..2c9eed78f6df 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -395,6 +395,7 @@ struct amdgpu_display_manager {
 	 */
 	struct amdgpu_encoder mst_encoders[AMDGPU_DM_MAX_CRTC];
 	bool force_timing_sync;
+	bool dmcub_trace_event_en;
 	/**
 	 * @da_list:
 	 *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index b8644f49e0f2..927de7678a4f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -34,6 +34,7 @@
 #include "resource.h"
 #include "dsc.h"
 #include "dc_link_dp.h"
+#include "dc/dc_dmub_srv.h"
 
 struct dmub_debugfs_trace_header {
 	uint32_t entry_count;
@@ -2490,6 +2491,39 @@ static int psr_get(void *data, u64 *val)
 	return 0;
 }
 
+/*
+ * Set dmcub trace event IRQ enable or disable.
+ * Usage to enable dmcub trace event IRQ: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_dmcub_trace_event_en
+ * Usage to disable dmcub trace event IRQ: echo 0 > /sys/kernel/debug/dri/0/amdgpu_dm_dmcub_trace_event_en
+ */
+static int dmcub_trace_event_state_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = data;
+
+	if (val == 1 || val == 0) {
+		dc_dmub_trace_event_control(adev->dm.dc, val);
+		adev->dm.dmcub_trace_event_en = (bool)val;
+	} else
+		return 0;
+
+	return 0;
+}
+
+/*
+ * The interface doesn't need get function, so it will return the
+ * value of zero
+ * Usage: cat /sys/kernel/debug/dri/0/amdgpu_dm_dmcub_trace_event_en
+ */
+static int dmcub_trace_event_state_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = data;
+
+	*val = adev->dm.dmcub_trace_event_en;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(dmcub_trace_event_state_fops, dmcub_trace_event_state_get,
+			 dmcub_trace_event_state_set, "%llu\n");
 
 DEFINE_DEBUGFS_ATTRIBUTE(psr_fops, psr_get, NULL, "%llu\n");
 
@@ -2970,4 +3004,7 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
 
 	debugfs_create_file_unsafe("amdgpu_dm_force_timing_sync", 0644, root,
 				   adev, &force_timing_sync_ops);
+
+	debugfs_create_file_unsafe("amdgpu_dm_dmcub_trace_event_en", 0644, root,
+				   adev, &dmcub_trace_event_state_fops);
 }
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
