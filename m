Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E496BC83F17
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 06:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8882710E50E;
	Tue, 15 Jul 2025 06:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OeF0WdL6";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C51910E515
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 06:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GubmK7Lt+0SeqVzFWNHCn7Pf/T9gZbHgzo74R6ZehdPqzOwWdlO6BiQ6f1QdicG3szTSplVbetMsbiOkVwOIIlXS1/nVL6/3tejDmT6St++wRnYMxRL9rEzdGUyw8jTBnvWwXVsfIUC9Ks9QxfICTOYRIx08dP8kHlppLGOAMKJTCxTsLXYYxIX5F8gecs/sZKANlJE5Q0wmIqNRasFAtsaHwRhu0xJl78fyk6yPKhTurkyP1S8ZrHvMj5nBK7089uLJxasXUEBUmvh4Usi1G5z//Bp/n6ppO0k0y7Zlmi4pv0Z15Te7BuwXJBoaN+F1vBHP9tmrkA2zHR1TWvQ/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0v5/esMqBAWlVJOcK8zdF3bsVZvGjZ9YfaRQUoYEZ0=;
 b=sZS45TYKvL5SFU1DTfYeCiUQUsenFQTt5jnUVg8ypSJJ74P/v2ky/OvT97pp3OmV+qdvQoa45kdMq2xB8Yj+Gm6UX5whD/1YKqv3qxXy75stdHhIjm9vpswi6UI5JDtPhRnZZg9USYeBkx1M3wSKcJ9hNJX+E5W2/XJizjxrscZFGcEkTXIXNYys0p4cVfMy/k47x+x4V7DkdZY8xbkupLyLddl6gn98z6QWQIAu5SBS0JXpQPnr6lWnC3e8p4J++SD7CILHTApOKHDGnN61SPmmZGQsQSEZk6C1wPIHpFC+Fgs6z4gs71TIU/G1BGolGr4Jl+MurTDZCUBTaoEB3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0v5/esMqBAWlVJOcK8zdF3bsVZvGjZ9YfaRQUoYEZ0=;
 b=OeF0WdL6Fb0geq97wV81ssI7OmF5lZM1QbETTEKY+mNfksdYH7RFVHE4jH0qCP1+Q4iFwj8b55NS8FRRt8cKKIV0V4ZQauk4Gc4NUgAv1SfbC7Q5+7x20dlDyIX9K3fRdSMYpxuznYtMlA8z0OaHMFstWcqGNAOT3wFm7c4+9Hg=
Received: from CH5P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::25)
 by DS0PR12MB7746.namprd12.prod.outlook.com (2603:10b6:8:135::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 15 Jul
 2025 06:53:14 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::7f) by CH5P220CA0018.outlook.office365.com
 (2603:10b6:610:1ef::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 06:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 06:53:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 01:53:11 -0500
Received: from 172.93.31.172.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 15 Jul 2025 01:53:07 -0500
From: waynelin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Robin Chen
 <robin.chen@amd.com>
Subject: [PATCH 04/10] drm/amd/display: fix condition for setting
 timing_adjust_pending
Date: Tue, 15 Jul 2025 14:49:28 +0800
Message-ID: <20250715065233.160043-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715065233.160043-1-Wayne.Lin@amd.com>
References: <20250715065233.160043-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|DS0PR12MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf78624-f2d8-442a-31f1-08ddc36c4478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?po3OLLQhPVIukld1YC2tYN0Blap91DbsWLjJVuercgLd2lXZvlqloNLNezzV?=
 =?us-ascii?Q?VYWxuj3dUTQ6sjELOGz86LSI4FPOL+GZJcMjeBLLdjYLgdVRa4VMLpuHS+A9?=
 =?us-ascii?Q?Cj6ztMrUFh2JAIl5JEk1D6/E/ezZPzIBKGuHw+0RQzGbIbc3X4FwdcaVdArT?=
 =?us-ascii?Q?5sj1miVSUbmkR4tOeZRrrVmXDl1UQs7Wm7nIPHXS5XhVo4WdqQDMU5BvEKJp?=
 =?us-ascii?Q?/Il3SObOg+1lQ2zv3KkEGzh5UWZlQHmu5PYEDP3ooJl8/gm1fiHUmba9sKkU?=
 =?us-ascii?Q?A07j0sqjZ0nsRcLfqEfDi18MMfheBbopaCkxuAlyhG10+zgS1s6oL5mswOGQ?=
 =?us-ascii?Q?GEC9U1f6g3jufC5vuozL5kqmxY7rn+GvPIQOjc+aBl6aCsirI8Sz+2LASUBs?=
 =?us-ascii?Q?FU+hmhZ80uVXM4B4h1RZfz2LTyB104aKKdwpLBYpECL/WLa8zXx5OeKFNOt9?=
 =?us-ascii?Q?BWbak3SSLWzb/ZFa9YvXKzloapiAcvds5i6R3HG/Gzt42qX7KsSPvI8HbD/h?=
 =?us-ascii?Q?nHrxJ6oqZuZyn5mbKAsiwVnsfKcFv8eYidNpd17HBkH+btvstkXzh+CSNsxk?=
 =?us-ascii?Q?nx7ERhOGrrBqUNRv0mmuxFURubF+CRytEQ7xASSMvStUndblmDX2xG/oIBQW?=
 =?us-ascii?Q?uTFtJ/oNmT2tKC3rTSRuJ8LhMVI/2Dj2uuPwe9Z58vewZeMPM5K4kmVTAcTg?=
 =?us-ascii?Q?zrjPGYAnUlEj+6EICT7wQ+rNSGID/AEXAYmwH7D5qTpzuBPMiwsh2U+YepJk?=
 =?us-ascii?Q?VdfBDeTaAh4VY7Oxdm9aDtpFGOb6LJlzYQyQIgLxdbKR1qRb66U2bidiKPCy?=
 =?us-ascii?Q?mAnOqVK5lzke1qkRY5xAfERcpIDiahFRMBeCD3rfoAewIhRH3Lwi+3IfDmPJ?=
 =?us-ascii?Q?0sOvsIjhf7Jcw7MnW2e5V5J7RBe8THiiT0ATuOdkj70MNFBF+lc/FkYZQKH9?=
 =?us-ascii?Q?lA6DPNbx14Sfnn/eOl6JsEv4h7crIFXGgyzHGzzSv7Vn5nHtMWmBbuoGhaca?=
 =?us-ascii?Q?8pgxzSdta3uqoOWhJpd7Ukux0QGRQ/MHGWd2BlY8y8bVaIQW9tHV8tahgF5C?=
 =?us-ascii?Q?s9udYus/VWPxx47idQx017L3DUdRFHfptof0Aw1c0P2gCCLBT/ZW5BnxUEMm?=
 =?us-ascii?Q?YgKnEWVKlTm8rrEldYIGjT3y/zTfrIRO2joolLSr16RIGkYBZ2gUxwi+kLf/?=
 =?us-ascii?Q?2UiBflNI/ygcLWO2tEjvgYWDeeMpkmuxQwB6zKpk3oXFx6ybu8FrbEJbDPlo?=
 =?us-ascii?Q?FDafqlzD6sGUvpN4yS8sHHhyYcbbAcXkqsc/IQuEVdJJldkmuk82Sd+cT8es?=
 =?us-ascii?Q?ljhhbMqfSUcyI1hk1eJ+ci8bP4OeZPkIn1Z5Ah7IKY6qF9MZ/7XC0nphuEi8?=
 =?us-ascii?Q?GBesWsbgZHsAKJlnj8XTQmCVZlPFlX6vfNWgd8eF1Mf4igF6WdvO2kWd2tee?=
 =?us-ascii?Q?QuiRvsFOX/xhzcypXDST038dyUm1HdbW000wlDZ1viXWxN3rzHD7OEv3J8ia?=
 =?us-ascii?Q?T+LRcbMU9N7/UrwlTVEFteI0XPvpAeLrS/8//Irc9sjPO/Zz3pBn34ZvPA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(43062017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:53:12.8438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf78624-f2d8-442a-31f1-08ddc36c4478
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7746
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

timing_adjust_pending is used to defer certain programming sequences
when OTG timing is about to be changed, like with VRR. Insufficient
checking for timing change in this case caused a regression which
reduces PSR Replay residency.

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c31f7f8e409f..61d0940cd41f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -446,7 +446,9 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 	 * avoid conflicting with firmware updates.
 	 */
 	if (dc->ctx->dce_version > DCE_VERSION_MAX) {
-		if (dc->optimized_required || dc->wm_optimized_required) {
+		if ((dc->optimized_required || dc->wm_optimized_required) &&
+			(stream->adjust.v_total_max != adjust->v_total_max ||
+			stream->adjust.v_total_min != adjust->v_total_min)) {
 			stream->adjust.timing_adjust_pending = true;
 			return false;
 		}
-- 
2.43.0

