Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB79C27C75
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:53:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F8BA10E6EC;
	Tue, 11 Jun 2024 16:53:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wnefapjx";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3158610E6D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZycNp2ADcdchoF/xfdR9fnaHP2uFRH1tGvb06q0PB/iX4lypTDu99EyyrJvVp5LKuIp5oZL99pToZOr6tm9wXImIVdBydrjSX6EAfrkS6OCOvSZxZCK/3FEGtJxjgidFO6ojAP40u49LOtwJA/e9tBFv2vYjJe+HfMzFOMN6ne9+cJstJF961i7q1cuutflrfHZdViX/lpcqDriuTFZevsHc0uocI9Z6NJAsm859NHlk1DzzzpPzD0JNhqLIGtFtXQv2Q42eA9oAh43T12kLXEjzChr60L23es0X1J8jH8Oczy8uiemPfCUw+Ydph+jUzda35U5Bo+7YK4kUX1/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnh95v3r+t3xLYrm631U7y3gORxOn2QZi/lS3hALaio=;
 b=e2sqlRlmUc7Ya3KzV66A4gn0KCeeI7n03JDLbB2jbb4OSStBxyX7VfNa6ofJosWHfZu/QYfo5B9C/7btrCibE7ID6UBZhWKCvB2FXt52Dpbd6QesaAedrJ19lHpcVcgdEUfNgD1IZtqfuzRdc6ZzKVu1IWlaER9/nIPqHQ1djiAZCmWurBsWkAEQ4adAMF8kFFz7yaMmBqfOnAIsIFEIuYZrjVvnKKfdqnNMGfGZj8zqttccOBW9bRsfXciepdV2Y/+PFc28pF1P/mZTrO+ysag//DamS6fyMmMfT004RKRloBnCVq5vh/WjK30BdTd+qHqLHwuzq42XJLpZS83ugw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnh95v3r+t3xLYrm631U7y3gORxOn2QZi/lS3hALaio=;
 b=WnefapjxxAJD+NfK+eE38rbFyS7W3vkYsDMyVWiv5ULSB3+hCM9oC8/3rYakotyXnt9M0tqIrq7f6rwA2RqgX4ZSSr6UUe3OhQA+Qzrzzgb2hsuQ3WBJCAvyWABMCoBgX/hVwNX4yvCsA777qRa2CbNvx5JzTsjzdidqa+1ORIY=
Received: from BL1PR13CA0437.namprd13.prod.outlook.com (2603:10b6:208:2c3::22)
 by SJ0PR12MB7460.namprd12.prod.outlook.com (2603:10b6:a03:48d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:52:55 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::a9) by BL1PR13CA0437.outlook.office365.com
 (2603:10b6:208:2c3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:54 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:53 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Anthony Koo <anthony.koo@amd.com>
Subject: [PATCH 35/36] drm/amd/display: [FW Promotion] Release 0.0.222.0
Date: Tue, 11 Jun 2024 12:51:38 -0400
Message-ID: <20240611165204.195093-36-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SJ0PR12MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf490e3-106f-41e2-2be4-08dc8a36f056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NjO3/WObjWkYDO/hinQ0hNkaecpwMb2m7YvEnhnD0vgbzXsq6LbTwzJkaStM?=
 =?us-ascii?Q?itQtAHPd8B7QhaRWqvrth4ZvrUvi9VD9OFULCf+Y0RsPn+E1sOz7JdhcgYxl?=
 =?us-ascii?Q?rjG9cwwbvWkYjncSE3NUF2ZlzwTRz+u1G7iOBiKQs7pBUuoqw0WkxEiUehFQ?=
 =?us-ascii?Q?icDekQ8F59+OOiPg1Jq+ud4rQ5qqQLzIMonW0gUsEg4fbJ5y74xDW+UeNv8T?=
 =?us-ascii?Q?ppJKX1bAXH98TQBLRYAi41Wg5SpO582WmnaNhS9lGuy40GV7+4uH7dmKeihT?=
 =?us-ascii?Q?B5ZiTCjNAvJco9NvpXFfh5G0g+GxhizgQP5n2/n7V5vMReZnsr8jK2z6se+M?=
 =?us-ascii?Q?FkGqiUqo34E+ACj9DLV+7DitUX/hvZCriYFt6u2Yw3Fb9u6xVV2skxkrtIfG?=
 =?us-ascii?Q?4dQfTDuBk9t9yY9C2Ep2kIsG8dZtvDy2vrXJAuwf7SYix2h1w80nUpvqpugo?=
 =?us-ascii?Q?Fw+qRd8+EojCwjS0QjlAmMWa/2FHhBfzcb1FE77aKUU4zbfItMKpwXfCfsJa?=
 =?us-ascii?Q?eJmqWQ/By7iQLFE/eP5Uz6JqwuhKyHiswIrAn4QAwlfY3wB/NeNyqxNDblgv?=
 =?us-ascii?Q?d/ann4E/2wZ83Pa7Z9rvT/+fWClkf2MLS9bNKCcjFz1CU+a/7F6pI6xh1wBt?=
 =?us-ascii?Q?Xyk9h18CSwSAbLC1/KZtjP+uydd3JnOvXbIlKVOBahAa+Y1dVX/Q86vZJEEb?=
 =?us-ascii?Q?l9z6UuSeElqD7qySNDGA06OS/DrFq47BRL2sXsStOqW7u1H/3yOYRnc/Z8gK?=
 =?us-ascii?Q?UvqIhhssJlhwKNyovUBvZ/Be57aY8F9UnjiGfQ3qj/CEZYTcYe82qwWTdFvK?=
 =?us-ascii?Q?cU9Jzm52RqotWHt2UBS9w/EN4KXN6HbuZp1O/LHJjrmdiG/yXa8gnEdlcetr?=
 =?us-ascii?Q?v0CSHEpGKYnBigLsgZ4QDIAVPjXP3ug/jE+oTiycQAuTaUJlgoeERTJW49Nz?=
 =?us-ascii?Q?NsBHRMkSrQaEIOIg4fnExKWLuOy77GT9OP3xKW5afxcSy433ONj9T6NPFbAv?=
 =?us-ascii?Q?cluVzf3zN6PMicMK/RSSzdc6TgutahkhkYhlGW8Dp0f4Jl/MRk3rRDtz3Thd?=
 =?us-ascii?Q?nk070YRxLbqbo1L1cST1ii3gWvHNdhPAqc4TrGkbIvqfIxRe54gUtTLiEZj2?=
 =?us-ascii?Q?iuZOXxfxW3YuudCsuij8tiGTIdLh1JSs4pmNiVaJY1iOc5Azvty9oQwjCExB?=
 =?us-ascii?Q?rLdsvoHZCrPgvXz7JDv2661xd+Mg6Io6QgH4hls0HZStE38vbsRACo1Y3zB8?=
 =?us-ascii?Q?lWCim5gjacNaTUoivoT7SycWKMtBxTA6HOipUGmvWZ3n7nc6kHQysBD50DL5?=
 =?us-ascii?Q?zBAW88NiCSZwr0VIXp7d74762SyPa2HUFnHa9JhttvjocvQv5/tFQhR5UXam?=
 =?us-ascii?Q?aIrZf1mQTG04fj5LpKdgExsiPLs9n/eWKcOidWoXY2GVi56QMA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:54.4032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf490e3-106f-41e2-2be4-08dc8a36f056
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7460
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <anthony.koo@amd.com>

 - Add new condition for PSR exit due to ESD recovery
 - Add new VB scaling feature for ABM by interpolating between
   existing VB parameters, allowing driver to have fine grain
   scaled VB levels between 0 - 250

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index b75653faf40e..78e8698fe378 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -208,6 +208,11 @@ union abm_flags {
 		 * @abm_new_frame: Indicates if a new frame update needed for ABM to ramp up into steady
 		 */
 		unsigned int abm_new_frame : 1;
+
+		/**
+		 * @vb_scaling_enabled: Indicates variBright Scaling Enable
+		 */
+		unsigned int vb_scaling_enabled : 1;
 	} bitfields;
 
 	unsigned int u32All;
@@ -2796,9 +2801,9 @@ struct dmub_cmd_psr_copy_settings_data {
 	 */
 	uint8_t relock_delay_frame_cnt;
 	/**
-	 * Explicit padding to 4 byte boundary.
+	 * esd recovery indicate.
 	 */
-	uint8_t pad3;
+	uint8_t esd_recovery;
 	/**
 	 * DSC Slice height.
 	 */
-- 
2.45.1

