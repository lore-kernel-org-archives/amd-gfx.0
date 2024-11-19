Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BB8D591CC
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 06:36:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDB3610E5D8;
	Tue, 19 Nov 2024 06:36:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sv/k3A+N";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 722E010E5D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 06:36:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idqKDjqNvl62qo50dr6/N1GfT11FBnoFKRoPYPKrEJciEbma0ErGAXrmHZ12SGd7HoIYfDko/va8pa7lwrToMlItPUpu5YGpAkWxh4/C7te8VP+jrqTr5xtt6SbjTK5Axs5pYluOPzLwuXMNBrXWjgiIdzk1nGAzPdBflDv79REwimjV5VPKCwBRAPj6xfys12uwQhWDa/TRoZW2NE9Q9lTUDMx2Wt3XavRsA7g3iMY1SFbpU0N2ot5XiOf3iSnFVtwp791ddNjAGxTAQWAyOvtDJDNjpIMnKd0bRyGaIY5Vvi8J1pzAS68KdWQ5EsY+30tKz3lNv+IQro3I6glfgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iq3Q8/LqozW5V8K19Sj3af8ghHzTqigBe9XEfwVaLCs=;
 b=OsaKeYbR50zoj1KoYHsIFiG7VPrOwwZa0XnoTzClFiELgtgaj83NjLQmjB2V97txYXJEVUUtRt0DSm5cMRWj5cxcQaHVL71YcaTFyiJXSsBFUjRLMwzelW4FL7VNqT12w7F88yz1zKUfdK8nJHObRDISpPNjzeykH6G4FJAIG5i4D+LgGNXi2ThH9099zCnqd3jLIWNxvhA2OBrjd/n+6llOS9i82vd5s3EGviHl0e0l19BveWdFjquAhGt9MJhm13HgkqJ0pQfjmUOC/puoLHwMrFDJNV8kd2Wm6lWljzrgNLk5QSBlLwipMbGtncip35L9CNqr4/F5sPW+dvOGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iq3Q8/LqozW5V8K19Sj3af8ghHzTqigBe9XEfwVaLCs=;
 b=Sv/k3A+NP7lhwBC9ZZNo/NcdFXTYfJHUPpOgG/TLNfDx6e6YW+elYgqoXXgNYdd+9b9jnRaIaCcDax3IbzqRpW63/K/vb0t0AY1DQMY1D1VzKaEuDwE6Ph7b56cIhzIP6QW4+c/tvyGilCmOexbI1d9xRtvqsNueBaD7zMYn5ww=
Received: from MW4PR03CA0048.namprd03.prod.outlook.com (2603:10b6:303:8e::23)
 by IA0PR12MB8424.namprd12.prod.outlook.com (2603:10b6:208:40c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Tue, 19 Nov
 2024 06:36:44 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::f) by MW4PR03CA0048.outlook.office365.com
 (2603:10b6:303:8e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 06:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 06:36:44 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:36:42 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 17/21] drm/amdgpu: add ras_mca2pa to convert UMC address in
 legacy way
Date: Tue, 19 Nov 2024 14:36:00 +0800
Message-ID: <20241119063604.81461-17-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119063604.81461-1-tao.zhou1@amd.com>
References: <20241119063604.81461-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|IA0PR12MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 25818799-88ba-430d-8d66-08dd0864891b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r+o76QliQ5+gXUDPSJQK7DHISdxIFP5OD3y182QcXJVr+nY22qWGqL6kpteF?=
 =?us-ascii?Q?28mF5wylDUrCWOkkID4pU/s5QwDuHuoPI+FSfN6bEZj7TbLlPjqKKsDrjMZj?=
 =?us-ascii?Q?i4zUuITMX0B3TuS7I/oVC+VpM1jdfV/Ww9KXr6E/px8LHmbslGCNW3uPLWHf?=
 =?us-ascii?Q?Y7ur3TPoBH1WNcJYMmHDr34I3YfeG3tGk6NWpPMelVPt6zvHPurHYeIPcIzs?=
 =?us-ascii?Q?EMoA2vrb6rT5z07p04SiZ+91ezNNzQpoWE2OxXSvZKzjm6Voy/XJrANTCUu7?=
 =?us-ascii?Q?xDQukKXQhzlAiWNZRUVa5dd1QzzmZ0VIaUY5K2cnzyCQaPWS8KeMas9jPCLv?=
 =?us-ascii?Q?eHEdrHCiYox6rf/A7w43JLe3gLhusyYjdQhVsjJTCW6g/WwUSx2JhHNzo1Yw?=
 =?us-ascii?Q?Bns54CanNXhBL+1T332P1eWYGowif02gIVfO++ptUQII8hhsaIEzRiyNEL3K?=
 =?us-ascii?Q?pinJWPrz9sMRrOm2mWW3Xdt3DkB3HhL2V5jiwdHRVff8e9nSSHeh4yHtuvGS?=
 =?us-ascii?Q?0KulYX7h4jQG4IEBfqQng9u8g/qOl3zpVEoKXntpPnm6UVS/05ePLbEWsrUy?=
 =?us-ascii?Q?a1WOE8nHq7rgWwoYCpx7jWtFzWlzRpaBjpH+Ob0Yhx6QA8ad1475NEQc2va2?=
 =?us-ascii?Q?/Kt9r9IU85D75Ef+v3FyM/YQ6MfbldgPzR8O40siYHUOXcmzknD93ISThiT6?=
 =?us-ascii?Q?QfLIXQmXfXp2tpWk4gnWsJO4GkGy7rne5fXK9nyO9fBs2djplyBt2n6d/5E+?=
 =?us-ascii?Q?IPaKxrZBaTRD3TVJceylYZeusqElVXwrpaHZYd5hsLaZH1BJ54o01QNcla2w?=
 =?us-ascii?Q?3i0ORvRlueIHKHcCRXn0WPS0QNL0ygzWkavMT7w9GuuAp1n+CMuzxXlBF3/Y?=
 =?us-ascii?Q?CiDcNV+RW7GkuLWQeECIrnUNPpNFXenF3rAcmddSeqpHBqrGvwv0MlXTniV8?=
 =?us-ascii?Q?NChN1nnlyvhknJjZuW9Kh8fRJ8FTIxJtWJ7LV0yWAVPnBtjJy4xXF1thISP1?=
 =?us-ascii?Q?WG3kad2c9DfR6ngQrBmyGktWt2vHGyH/Id+PGZXZ6dCezjNMYEQY5+a1xZsw?=
 =?us-ascii?Q?N0PKXIp0dfpQ1hKgZ1p2bGHcz0jjMw5BFBopCDufRR/yxAUilabX35HIr8K2?=
 =?us-ascii?Q?Ip9u4NXdQmeSXO5B0UL6nS7baylORcFxOaPKgek+mQZAbGQJivFBqZC/Bey8?=
 =?us-ascii?Q?5eYxmZ5lOIGag2K7Tzvu5nQ38oPt7LBqxEoCXAVrfDxdI3WH/i8E0c53iG7f?=
 =?us-ascii?Q?q8sS66goeqeg9oq5GiAGaWkFZgHf0xBjPuGDyDKk2sQn/NHRRdfzdJBE28py?=
 =?us-ascii?Q?LX4X5Ol7rIP8fFXw7xotiTl0eIn3BD3XRYf7PlEmXtpBtNTFiGtSFbC1QC/M?=
 =?us-ascii?Q?392sBUaDAlvWELFC4SyAumUa+IJUqrD1cBhnhE2HLPTdchWGqA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:36:44.4795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25818799-88ba-430d-8d66-08dd0864891b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8424
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

Convert UMC address via node instance, UMC instance and channel
instance. IPID is not sotred on eeprom, so we have to get related
values in new way, can work in any nps mode.

v2: input mca address for get_die_id_from_pa interface.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 41 +++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 681b756f6428..f96cfcf405c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2664,7 +2664,7 @@ static int amdgpu_ras_realloc_eh_data_space(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int amdgpu_ras_mca2pa(struct amdgpu_device *adev,
+static int amdgpu_ras_mca2pa_by_idx(struct amdgpu_device *adev,
 			struct eeprom_table_record *bps,
 			struct ras_err_data *err_data)
 {
@@ -2693,6 +2693,43 @@ static int amdgpu_ras_mca2pa(struct amdgpu_device *adev,
 	return ret;
 }
 
+static int amdgpu_ras_mca2pa(struct amdgpu_device *adev,
+			struct eeprom_table_record *bps,
+			struct ras_err_data *err_data)
+{
+	struct ta_ras_query_address_input addr_in;
+	uint32_t die_id, socket = 0;
+
+	if (adev->smuio.funcs && adev->smuio.funcs->get_socket_id)
+		socket = adev->smuio.funcs->get_socket_id(adev);
+
+	/* although die id is gotten from PA in nps1 mode, the id is
+	 * fitable for any nps mode
+	 */
+	if (adev->umc.ras && adev->umc.ras->get_die_id_from_pa)
+		die_id = adev->umc.ras->get_die_id_from_pa(adev, bps->address,
+					bps->retired_page << AMDGPU_GPU_PAGE_SHIFT);
+	else
+		return -EINVAL;
+
+	/* reinit err_data */
+	err_data->err_addr_cnt = 0;
+	err_data->err_addr_len = adev->umc.retire_unit;
+
+	memset(&addr_in, 0, sizeof(addr_in));
+	addr_in.ma.err_addr = bps->address;
+	addr_in.ma.ch_inst = bps->mem_channel;
+	addr_in.ma.umc_inst = bps->mcumc_id;
+	addr_in.ma.node_inst = die_id;
+	addr_in.ma.socket_id = socket;
+
+	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
+		return adev->umc.ras->convert_ras_err_addr(adev, err_data,
+					&addr_in, NULL, false);
+	else
+		return  -EINVAL;
+}
+
 /* it deal with vram only. */
 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 		struct eeprom_table_record *bps, int pages)
@@ -2744,7 +2781,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 	for (i = 0; i < pages; i++) {
 		if (is_mca_add) {
 			if (!find_pages_per_pa) {
-				if (amdgpu_ras_mca2pa(adev, &bps[i], &err_data)) {
+				if (amdgpu_ras_mca2pa_by_idx(adev, &bps[i], &err_data)) {
 					if (!i && nps == AMDGPU_NPS1_PARTITION_MODE) {
 						/* may use old RAS TA, use PA to find pages in one row */
 						if (amdgpu_umc_pages_in_a_row(adev, &err_data,
-- 
2.34.1

