Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F06CCF9E0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 18:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 364C710E64A;
	Tue, 28 Oct 2025 18:52:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cj5eXJ35";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012043.outbound.protection.outlook.com
 [40.93.195.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64FC910E084
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 18:52:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuXjGE7AMUUJZFnW7ZQ7JNPASpdAr+eDkhawjuGJPtC7bmt8pcU6J07b3eVO4g9RIGhS8w2YAR3sU3q6pDsai9kwptRvPWhZagfZ2xBh2T5nIe3aHdCgiqfC75ppgfDMjfT76MrjWgsrO82d7t8TroKgGApIMSffbj+YYVVjoUN5rAmX+TAuOB70Yu0X/wF924qb+TLB1f1il7YAfetgHEqnCfJx/nArmZCZDCQhP88ptvhSy6oYNZV+WPjSZ75YFvTdJfS/PCRUFLufuRL7pNIos9gCdAcIBqnvmMycRk6FQ4MRl8ibzXScw73Vn2V/WhWySsWDcJiyBylA91m4WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OVE3mlSSmghNoDaQRhPNiaS7PULZ0DVhkYy3Fa81SA=;
 b=mUxoIY3cjhkYvwvL2ZWTuoIS8b6MjcKIwR2hVgMF0P5ijABlI98l9DwLWAbfzIwhH7XY+/4nIGbqOKfoUvK1RLKwVT8+Ik4eBum8//QrXmN979GnhiixfUtYh3UgxybdiJuFf1NnhS69eoUnmhwJnGqYSD465EvOJ0dTj1DPMjuz7moqQJu4Eaf23K3l4mlw+or0vVXPRoGzjkpuvxwV8dEdTnsSlckVKF3g4JQwIiq8NGebAZuVDQ+diq8WuhTZLd1dQD8gSLfxak3E6Kl+Yd1g/EyrkdjQ9jOkNW44pdY1sCvf5zFNY5KJ7W2tA97CzJsaDhG4jScJbHynclPvag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OVE3mlSSmghNoDaQRhPNiaS7PULZ0DVhkYy3Fa81SA=;
 b=cj5eXJ35aXrZnS5447ngNbyFML/uaUXzoq6jqT1ZojiNXmtPK1iM2ZnguxngsOBX5MT0QKDWgVAPVD60czaiQzK1fKRFHWFyAHrzvCGNEmonlUv5L3HKfq/OLN+s1e0WuCrAE5uJb0J++rHNE3C1YtrenN78EzlOI/JkuBwb6Fc=
Received: from DM6PR12CA0012.namprd12.prod.outlook.com (2603:10b6:5:1c0::25)
 by LV2PR12MB5893.namprd12.prod.outlook.com (2603:10b6:408:175::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 18:52:48 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::33) by DM6PR12CA0012.outlook.office365.com
 (2603:10b6:5:1c0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Tue,
 28 Oct 2025 18:52:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 18:52:48 +0000
Received: from sclement-ThinkStation-P8.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 28 Oct 2025 11:52:47 -0700
From: Sunday Clement <Sunday.Clement@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Jonathan.Kim@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <Felix.Kuehling@amd.com>, Sunday Clement <Sunday.Clement@amd.com>
Subject: [PATCH v2] drm/amdkfd: Fix Unchecked Return Values
Date: Tue, 28 Oct 2025 14:52:35 -0400
Message-ID: <20251028185235.3192159-1-Sunday.Clement@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|LV2PR12MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 00425c43-f28f-40af-1c49-08de1653306b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?io73BlvYk2z4RTrJ1PzAjIloZG4NwWF1tS/61bZh1FAwaWBGrfaArsSC6TnH?=
 =?us-ascii?Q?n3ZEoy9l6Pq7YNCIoXRxs0ZR9amU+A9pjin/VSJPW0wf31IfV3OLVu1A9ADO?=
 =?us-ascii?Q?s8nenYRYwsUYW6kU8wKXpLpGhh+0lbP+2HQOwD/a7fH1SygSHjH+D7QTzqga?=
 =?us-ascii?Q?wQqbtO1fYiojOUtiFnMBRwGxO/AcIRz1u7MRIwSAPL5l2mj3o2F4sGuwFgPB?=
 =?us-ascii?Q?+eOPX8BTocAkOcb9PsJUm+exnUmxCBsxl2mxz+gClpscNsW/s6pl3I76GNEb?=
 =?us-ascii?Q?2qr+WyrMNWX47odEMStVN2kvBo5OOU0YPOQzDpYnvPm7FACc79TMbiSfwKdw?=
 =?us-ascii?Q?zAn+QSuMhopuwWh6+DCeOCOXi6tKhVvPrAlxqv9gYDDhyQGQIuQ8d/SA1cYp?=
 =?us-ascii?Q?BiK2BOD+vLeTxEh3YHuBMn+0uB+ylrLgHdX9w0+EH/UGsinYXngw/vCwGNZT?=
 =?us-ascii?Q?94mnefIwss+OvxDHLGqV6tucvUmjcjqFvYcWM5Egn37KGDnImf5rvJ58bqPr?=
 =?us-ascii?Q?yB52kix3pLZAjhXL3l0NhhaGTftaU1He39GbPjSrt1xURy1OxpEcZtW/0Rl+?=
 =?us-ascii?Q?altHwaN/WSHloPdKX5Ofsb5aZWwk54jAcKiiWGQtxl95pbtf2QDMNTwBwMbC?=
 =?us-ascii?Q?Mlb0GtlNfBwXVum0pNdRdRDUPjKrkeQvetHoei6jsHEdFIBtRMouCVnQgDf6?=
 =?us-ascii?Q?DRS35o/j9KMedgF4cdqR27ObcDgZfFKECNP3ezMSXBf0xkBNdlW2K/elpXf0?=
 =?us-ascii?Q?iFEvlT6oM3ZsuQv3Oy64VCO+vhFRsYzigDyEs0Y1vOm4egrVASAnvG2JQ2pt?=
 =?us-ascii?Q?kIV2W+ia7C6CioltAhgJ/LoDreX7Ot690ngKmXDMGN6ATqnpmwd8lvv0S6Jt?=
 =?us-ascii?Q?QR6M2WF2EXVlQNG4IrfetBgzf6t5dET+akaRiTkiqETw93FZcivRqa1rvi8/?=
 =?us-ascii?Q?WZnuL/Wdl9hFRmeQH5E0mBqBtjOdQbV7bM/uekQvYdB+idbC4b0WwLFdUyrn?=
 =?us-ascii?Q?IeVPCL/RalS9ajbmKbCcJKCH1J8zyNdd8rR2MFAm1/IwDoxyVaC0KiVlfA0B?=
 =?us-ascii?Q?8w8Ku0bcCR8l6AGEGBt7czd2SF3xEiQE29U5N9ENc9jUzWfR6pkma8LtOnIO?=
 =?us-ascii?Q?P4By/cASWfSO/yo2fbo9KMS58eVWmVmSu85AE2x9lioURa+fA/2Ckpsm3MPT?=
 =?us-ascii?Q?lyayz5F21LGDd+lWy28QDSWtTXQbzC8V4MgZHN1kN2LP3nwj5KQQGigvVc2J?=
 =?us-ascii?Q?vafR3Yjf2+1riXXftC5Yql3SfWPRvnI3gTutV2B4j5YwGHjq+7UvlDoOQ65J?=
 =?us-ascii?Q?cxhC8QC+Fs9aj+EF1SqyXYblmyazpPya0pXwniR9nfW8BGFXDTWQuolQd2e9?=
 =?us-ascii?Q?c2Qe3LaOqH4DWMAqSQR3dvyhGDoNmgxfXAHnkVECScA1nTQSI5OrIIdC+tCo?=
 =?us-ascii?Q?SicdaPaXTmC38Utv0h9c3ZW1yV7DTqQfXBXonqc0InoepUbobJDchK9+wzZc?=
 =?us-ascii?Q?qxPptdw8sJ+q4ZhIN1QzY4Q/Gr4lqdC+sFSSBWtfgLQEZtB/qYTJBEdJoQJ0?=
 =?us-ascii?Q?gFVedp5X6Ao1dqSgJC8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 18:52:48.2876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00425c43-f28f-40af-1c49-08de1653306b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5893
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

Properly Check for return values from calls to debug functions in
runtime_disable().

v2: storing the last non zero returned value from the loop.

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 0f0719528bcc..22925df6a791 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2826,7 +2826,7 @@ static int runtime_enable(struct kfd_process *p, uint64_t r_debug,
 
 static int runtime_disable(struct kfd_process *p)
 {
-	int i = 0, ret;
+	int i = 0, ret = 0;
 	bool was_enabled = p->runtime_info.runtime_state == DEBUG_RUNTIME_STATE_ENABLED;
 
 	p->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_DISABLED;
@@ -2863,6 +2863,7 @@ static int runtime_disable(struct kfd_process *p)
 	/* disable ttmp setup */
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
+		int last_err = 0;
 
 		if (kfd_dbg_is_per_vmid_supported(pdd->dev)) {
 			pdd->spi_dbg_override =
@@ -2872,14 +2873,17 @@ static int runtime_disable(struct kfd_process *p)
 					pdd->dev->vm_info.last_vmid_kfd);
 
 			if (!pdd->dev->kfd->shared_resources.enable_mes)
-				debug_refresh_runlist(pdd->dev->dqm);
+				last_err = debug_refresh_runlist(pdd->dev->dqm);
 			else
-				kfd_dbg_set_mes_debug_mode(pdd,
+				last_err = kfd_dbg_set_mes_debug_mode(pdd,
 							   !kfd_dbg_has_cwsr_workaround(pdd->dev));
+
+			if (last_err)
+				ret = last_err;
 		}
 	}
 
-	return 0;
+	return ret;
 }
 
 static int kfd_ioctl_runtime_enable(struct file *filep, struct kfd_process *p, void *data)
-- 
2.43.0

