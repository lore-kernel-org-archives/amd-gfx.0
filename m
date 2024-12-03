Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF0DE74ADD
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 21:41:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8B7410EB71;
	Tue,  3 Dec 2024 21:41:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pNz93Y3p";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6526210EB6F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 21:41:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5nW7qKsDMm+bIVIM5xYuPZl0seciVZkjEOPz0GCrcaTsfwgoWskAKnhDSp2IfGMUPR8afZqIWJ9uaFSnrbjUQvkR2+pDMmDh8xeJ3MyMyl0WyVvxg6KX3lUTh2vtyN/LN4JBV9KaizmKb0yH7rqIIa5fRjrfn2KEZfCTi8GO974ev9UXG55Wmab+lPSlnOp7k9DzGlrnoGEp0wOt4Di1pq6S2Yj6eeJK1+giqHR6duvu+0XwJ9LMRPPoqzd4vmP8V+5xRbMQRqcQyk7R0pxGUt8ExvvC/hVyVUVnztqIEWlra5/bBems0j8I+bbLo14CYvezBCQK2Kn0Rc4M+PuXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C26jVnWN41P4+20AY1CyZQSrwNQw9Tj8zssac8yJsaE=;
 b=nW8sl2e9K9Qlqdz8K6NGg4I9dM8JO0zhTijnZu7iucwE379l199a/llcrjnUoJUeK8rVJxm4IRHOoMLrugwGkj4oY5gjF8pllGD65gVPzR+kjK+ZI+gRyhOXEZ4mx70LVMVdryESLNFDlz4kn3r2UaFTV6V2yAGhgBscDeD8gQpYJxwPpd+Pd1acJD+qDV9fxBGNQq3rVq7LvE+sefmdlAKwErJAYm9ovruGSQYhIynAeuWnpH73x08WoIT9ZmYlHjIns+1SXFUaCnDzQEHyvMD3/wVhKiFyqBHBt0oVmcXV7GU27ddGAfeRiaSotk7o5tx0M6T+I/Pjyrzzm2GVuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C26jVnWN41P4+20AY1CyZQSrwNQw9Tj8zssac8yJsaE=;
 b=pNz93Y3pH4zJmpQnuP/6YSbRVMzEK0fPNnJ328VOiFMCdF+O4S8G/tmFAJ0HHX2G0ieZ8aFMllYazk4miqhyCyuiNFCntB4nWFA1S+CQHcyH0V7YnX1h+ND/diHnz8zfxLHUvKFgdRxoIagLacMYs0y57zbJqHPzXk28ca/l4SI=
Received: from BN9PR03CA0347.namprd03.prod.outlook.com (2603:10b6:408:f6::22)
 by MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 21:41:44 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::a6) by BN9PR03CA0347.outlook.office365.com
 (2603:10b6:408:f6::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Tue,
 3 Dec 2024 21:41:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 21:41:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 15:41:42 -0600
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 3 Dec 2024 15:41:42 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 09/19] drm/amd/display: Make DMCUB tracebuffer debugfs
 chronological
Date: Tue, 3 Dec 2024 16:39:47 -0500
Message-ID: <20241203214120.1161810-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
References: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|MN0PR12MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: c69edd97-cd9a-41e8-ba6d-08dd13e347d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+ioeUZM5w4/OyZ5Io0VokDvskgymU0A0/QZtpHX7uxJzqTfgthOJzOz20ehz?=
 =?us-ascii?Q?Q0H39YyRQBtvr6ikz7rtLA7cQY+IcvTpDRa5R3dNW6m1OqVzhgd1nQVrWilQ?=
 =?us-ascii?Q?Y8DzRD+IY4U8oI6Nls0PGXFgHmHZmKkOKXzb7Dy0s4nW930N0RNB0FvKkLZj?=
 =?us-ascii?Q?/3ClsWQxxr6pEToJFSptMw/J9Rg2PjevWA+88rZl4SFIHUe25lPA0wBdBebn?=
 =?us-ascii?Q?oJKfCy9TiUX2+pWAdLKaRsTS6/o453h5hJqAkQ5abJGk2jwx7wYhBPmWt/F8?=
 =?us-ascii?Q?mBvK4Fqqz9Bk8m38ryQJF6wLTBbXsr7rwCFIGS83JcWmU7SlhUZ8ZF1l5Ea2?=
 =?us-ascii?Q?PNbJq2R1tOn/wFUu3TzeGz9jjybojHAFnxxq0KYz3EQCbwCJkn+YhD+cZ1CH?=
 =?us-ascii?Q?DZ7Dw6QSng92lKD22a04idcYC9lzkgc8gbZGUTkLjfMnjZFXnVaU4FErfe7v?=
 =?us-ascii?Q?0X5jQ9vJ/xcHB0vgRLwts6EQv6zkpHQvaH6DGoEh84Kva3FcynULLmRMmYvn?=
 =?us-ascii?Q?Kbd3CH/1NrhIETHq5pTwOQFuWQbnbJn4CY358eTfBL8H6Jaws3h1p5PE7cYX?=
 =?us-ascii?Q?u4sIQOYxNwxud4beoqrn5Z1r9WXzTK7Efcj1XNAL6gONerdLL7pkSoUiAlOU?=
 =?us-ascii?Q?Xk0qefl/xOvJxpoFkexDh4OL/pP+wjnOSnzWe+Ec5fx3dVuM39l5KDxIyx1R?=
 =?us-ascii?Q?4JZnL3MHXvE5evag7WF75C2PXkZKfJvsOD5pRJmdv2X9sqnTVAZnhI8oMLO6?=
 =?us-ascii?Q?PG+GmiWZcdTnhFuHK21aDcSac+8nz3zFrR46wKfnrW2Lb7nhm8Fr5kiT8bnQ?=
 =?us-ascii?Q?ebe7kMtn12AAkUH8eQh2tIemaeSW0TZkph/mS8eDY/eHZkMD5eY9yDzQ0h/J?=
 =?us-ascii?Q?6FXgvcMH1Ktn0dLkFzsT2P/IQ5RxIZlLWdNf11quEBKZ/laSxyno4xxwmagB?=
 =?us-ascii?Q?8K2Y+lPj9sUORIHaAmFDWFmEY3nv/8Qs+u5DEv0taCCJnA1BHyXBNlmOQcs0?=
 =?us-ascii?Q?6bMz+PmQ4FvMt0Gx8w2E9jvQ+XIzVvQfEx8fvXgk07utEbzoWEpHqFhhrTuQ?=
 =?us-ascii?Q?RduPuMCEvC2cvr6BEqpRR9Bmohqh356jNfxRKzSbsWjDzNACcJff3IkbKf9c?=
 =?us-ascii?Q?+Xwv7C1B6d0JCYHp9hckDDU/8KtvKWOJUkTGgsi6e8l1Ro9IV4ZZzN4rkwOG?=
 =?us-ascii?Q?Ss0pWTLb3+wwCyy7bcEy+ee5xc1w211zMgp7qoI/PwOEYBZ0W3DI0Ohu34MW?=
 =?us-ascii?Q?c18kyAnM9s8Zetsee9QpLXYHxCiKrd+Ole+KUg4qNpMiq1VTKKO/7k4C+5lc?=
 =?us-ascii?Q?5c2xdRdOK9CXBWYFYUzOSPHOTAL/g12xQZxlQAXJ0NTncJAm7Tv3midrz36o?=
 =?us-ascii?Q?QsTxhjGwbrvLQfaFaEX7CugbSkEV55l/Ta1DPDQJrHSvSiHhDKbMJsUkXIdo?=
 =?us-ascii?Q?jeQetOXm6e2bDBnmKJQWJX0Z9ZuJ6jTD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 21:41:43.9677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c69edd97-cd9a-41e8-ba6d-08dd13e347d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272
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

From: Leo Li <sunpeng.li@amd.com>

[Why]

Previously, the debugfs did a simple dump of the tracebuffer region.
Because the tracebuffer is a ring, it meant that the entries printed may
not be in chronological order if the ring rolled over. This makes
parsing the tracelog cumbersome.

[How]

Since dmcub provides the current entry count, use that to determine
the latest tracelog entry and output the log chronologically.

Also, the fb region size is not accurate of the actual tracebuffer size;
it has been padded to alignment requirements. Use the tracebuffer size
reported by the fw meta_info, if available. If not, a fallback to the
hardcoded default is needed. To make this value available to other .c
files, its define was moved to dmub_srv.h.

Also, print a indicator at the start of the log if rollover occurred.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 26 ++++++++++++++++---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  3 +++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  4 ---
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 6a97bb2d9160..11a7ac54f91c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -902,9 +902,10 @@ static int dmub_tracebuffer_show(struct seq_file *m, void *data)
 {
 	struct amdgpu_device *adev = m->private;
 	struct dmub_srv_fb_info *fb_info = adev->dm.dmub_fb_info;
+	struct dmub_fw_meta_info *fw_meta_info = &adev->dm.dmub_srv->meta_info;
 	struct dmub_debugfs_trace_entry *entries;
 	uint8_t *tbuf_base;
-	uint32_t tbuf_size, max_entries, num_entries, i;
+	uint32_t tbuf_size, max_entries, num_entries, first_entry, i;
 
 	if (!fb_info)
 		return 0;
@@ -913,20 +914,39 @@ static int dmub_tracebuffer_show(struct seq_file *m, void *data)
 	if (!tbuf_base)
 		return 0;
 
-	tbuf_size = fb_info->fb[DMUB_WINDOW_5_TRACEBUFF].size;
+	tbuf_size = fw_meta_info ? fw_meta_info->trace_buffer_size :
+				   DMUB_TRACE_BUFFER_SIZE;
 	max_entries = (tbuf_size - sizeof(struct dmub_debugfs_trace_header)) /
 		      sizeof(struct dmub_debugfs_trace_entry);
 
 	num_entries =
 		((struct dmub_debugfs_trace_header *)tbuf_base)->entry_count;
 
+	/* DMCUB tracebuffer is a ring. If it rolled over, print a hint that
+	 * entries are being overwritten.
+	 */
+	if (num_entries > max_entries)
+		seq_printf(m, "...\n");
+
+	first_entry = num_entries % max_entries;
 	num_entries = min(num_entries, max_entries);
 
 	entries = (struct dmub_debugfs_trace_entry
 			   *)(tbuf_base +
 			      sizeof(struct dmub_debugfs_trace_header));
 
-	for (i = 0; i < num_entries; ++i) {
+	/* To print entries chronologically, start from the first entry till the
+	 * top of buffer, then from base of buffer to first entry.
+	 */
+	for (i = first_entry; i < num_entries; ++i) {
+		struct dmub_debugfs_trace_entry *entry = &entries[i];
+
+		seq_printf(m,
+			   "trace_code=%u tick_count=%u param0=%u param1=%u\n",
+			   entry->trace_code, entry->tick_count, entry->param0,
+			   entry->param1);
+	}
+	for (i = 0; i < first_entry; ++i) {
 		struct dmub_debugfs_trace_entry *entry = &entries[i];
 
 		seq_printf(m,
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index b353c4ceb60d..4b3ccbca0da2 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -69,6 +69,9 @@
 
 #define DMUB_PC_SNAPSHOT_COUNT 10
 
+/* Default tracebuffer size if meta is absent. */
+#define DMUB_TRACE_BUFFER_SIZE (64 * 1024)
+
 /* Forward declarations */
 struct dmub_srv;
 struct dmub_srv_common_regs;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index a3f3ff5d49ac..15ea216e903d 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -61,10 +61,6 @@
 /* Default state size if meta is absent. */
 #define DMUB_FW_STATE_SIZE (64 * 1024)
 
-/* Default tracebuffer size if meta is absent. */
-#define DMUB_TRACE_BUFFER_SIZE (64 * 1024)
-
-
 /* Default scratch mem size. */
 #define DMUB_SCRATCH_MEM_SIZE (1024)
 
-- 
2.47.1

