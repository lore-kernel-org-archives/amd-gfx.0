Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C577CA0FED
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 05:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DCAF10E619;
	Tue,  9 Sep 2025 05:50:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IxsEooVa";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E5C10E619
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 05:50:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMc47mKa2lioXlrre7Ah496UDt8yoi7SJnQMM0EMk2zOzPZXImpp5bjnQ7ZxeCHKv+fUY1cv0we5Gs+msKpJMC3xJg5O4W4DgkEvJh86Ao+n7R/96kH8+9TKlQep9o2tnjWNc801HxULUrGu/NU2N/95n0/B8LCUoPOwijxc30IHcqF/PjkfxwEQGl7IwR+EQBJ3N0FgBMLz3cUGJ9rsZIs05PJavXIJI+0bqKPgDPzcaDhspiLet16hcoti7+dX7OC1fOlPKrD/PAMBKhUXOnX29MzO+NowMBcC5Xlz3fJEP2EFRJSZNB3es7svy/7eZhseSgC8+fjdy40nUf2J6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVX5ZrtkDpbFHXRs3y5KKYMmBSA3p/Dflwu+OAhgDQE=;
 b=ojEfFRtSFh3/y46IqSUk3GlWeYQVdiUeP8/I3Ye+46o5HLNcZ8j6+PMHQlmdI9G10NrPZ9HeP5od2DJHcugmX4rJgMhRTteRIlfYARp8uY639y3XYP5OcLvZt2GpUpzJsijJHriR7XzB6iQxQ+2sgsaYWho+EFZzGmyNqPny+5fuUPRJmGFiYgSIQygMI0xzaNpwcjIyezfi60/Mlo9/Srf4IUNduLSP21MntaEPRJkQmFT//uNG81FBOdbDET9X91W94CvEsApyibxlQSzsOtBgUFweWWibyUy1l9W9B7Acn9tWFkNnGgv20BJiGO/L7Gu8x8fkWwj2WN6hVGLyiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVX5ZrtkDpbFHXRs3y5KKYMmBSA3p/Dflwu+OAhgDQE=;
 b=IxsEooVaf4yuLURQOIHM7ViwGI+uvpc77Rr4+xu0xy3HIimRYHakNzHBsRQgbomGpr/DglNgER3YtUHOmlhm2tvAWr7xGsci0LkMKjgwPV+7G6y4B+KjJhR+eljjFQ2IPXEPR2GomtsbiUYy/lGzvjJJXVA9VbJXVT/elsAr1VM=
Received: from MN2PR19CA0041.namprd19.prod.outlook.com (2603:10b6:208:19b::18)
 by CY5PR12MB6597.namprd12.prod.outlook.com (2603:10b6:930:43::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 05:50:16 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::54) by MN2PR19CA0041.outlook.office365.com
 (2603:10b6:208:19b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Tue,
 9 Sep 2025 05:50:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 05:50:15 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 22:50:09 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH v3 7/7] drm/amd/pm: Update SMUv13.0.12 partition metrics
Date: Tue, 9 Sep 2025 11:17:37 +0530
Message-ID: <20250909054933.2911159-8-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250909054933.2911159-1-lijo.lazar@amd.com>
References: <20250909054933.2911159-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|CY5PR12MB6597:EE_
X-MS-Office365-Filtering-Correlation-Id: 14608a01-8d30-42f4-eac1-08ddef64c01a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QK3o6MvX8AIRMwFEbaMpt4uVYI/gEqFmXSflMEzvd9fyZxCVgs/1RqlpJ9zX?=
 =?us-ascii?Q?ueNg6EjE73VSnTMGoefg+e5Ava59lMdeTwIF+mPxU8+D7SHVIserOw39nHzu?=
 =?us-ascii?Q?F0OqxZh9N2QtmXjDnKIaN3PEAPDqSAfU/jeyEv7jlX3tqCQO2wyWMZaY4aNd?=
 =?us-ascii?Q?LfQkdgkvSMALC1X0KqOXTnVU7q7pnF97J35PnT1dyIEUtP4foPl/oIVU2Q+C?=
 =?us-ascii?Q?c0BNzw+F/ZiBGiFvlg6NuPYLUPD6TnCvZo7fkBKXL9uQQ+dYmA9zs9KEnvo/?=
 =?us-ascii?Q?b0N25PIpDjwBbOpcgFb+40nnGhr43fDuA9P3wcxkF8mfsj9PszYk9PxYPiu/?=
 =?us-ascii?Q?vKyLsWD0GSvMA4YE7hjTOBOtEGvIzKVOusHjCa6HXto0xbrMBH+z6HKJ3q9Q?=
 =?us-ascii?Q?hs/y7uoSVKXyl2oh+bMvRsCC9QWt4Wx0d//CvyBODpVBxRTMbhTadUFRv1/R?=
 =?us-ascii?Q?NyUo5ESG6SRStvaxcdH5zQ2jYJqIrDzJ7XOcmC2tF+ObiuF3oVrK4D7T3RoQ?=
 =?us-ascii?Q?hOR+vwGJ7FFX5GO92XISIMEKERhvb3ydBpq/N4rdQ0Xm1rdcOvDRESPl1vSU?=
 =?us-ascii?Q?7V40aIty9MHi75g5XLFNmAs/ZK4smBhWSsb+BXEjKZJQtv3xzxpd6RRtBUVA?=
 =?us-ascii?Q?tOGUvwucYL22bMmYJNXfC9VorB9fKyY4xo7Z7uH80nm6lnfDK7YwR47FG7M3?=
 =?us-ascii?Q?/50MdfzaUKt4VsmNqZVq2Gpv8aLPShOLwd1F4aTiiGxL0u1rLwk20DHy6FhI?=
 =?us-ascii?Q?Ifg2BtA7LTe+gFaY7fB6tgka2GSccNceNUw3Fqq5qS6gEkxJAucq0+nN8b35?=
 =?us-ascii?Q?QtIxYUCpQyBx9/iU45ePDeiQmbV1IHsTHuvnGVlqs4DIgwLcddech4pNUsXO?=
 =?us-ascii?Q?OBObe4D/J/LMu5yBlLjobtEKGWgf9kS9/dkYpMQvV9hhFg1PclnUN0oh6ez5?=
 =?us-ascii?Q?b+R+1iqNYcEGcrws13rQlthjUyic6SD4K9aZv+8I0zG8DwXs4U2Ipk+eLsNg?=
 =?us-ascii?Q?CnOx/y2dJzhz2rSCax/cUzPXMyXhxm5KrLPWVNWTfYprNl+WiQmGh8+aInlh?=
 =?us-ascii?Q?2/g3KfPyDgGHWDktNdNXNfKtgY5kw3g6Cn7G8pXeQsz+WJNr5LnJNId3MTY6?=
 =?us-ascii?Q?HgMmonn32AFdGoD9bRHQqxfMa08Q7eCDPizHSfz9Yb2Ojcwv04dIDXs9MCvL?=
 =?us-ascii?Q?i55UyY7LWzfRNcdwCrnZb8dXzLjw4WqQkMN6qUtHH+qAA5UdSKANE6ZTM21I?=
 =?us-ascii?Q?PGZ53lKOUy50H0Y4hgMULxFlYXahEXQA51JcfKJXDbnKe0lYlcvzYpB/rjtn?=
 =?us-ascii?Q?Gv9Wy/G1B3Jtz+dtpUFIO1SH0jWRxCQa7C4+s3+NcoUtBDUl47YcIkpI4rG5?=
 =?us-ascii?Q?dbZA9QecZ+9JssrHkg6o7twGj/Sn5x8DTIiQ7MoJU9tgVM+hBrkYvl5tUfud?=
 =?us-ascii?Q?pFEHTZ0ddN6aCafcuYkpbZcjIp0YZoTzfY5BLPRN+pzfn7+h9lxDD6WXYmP+?=
 =?us-ascii?Q?tF+lWSfMpB7IBZLTreRM+ghp8RnKnHOxfKRH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 05:50:15.4824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14608a01-8d30-42f4-eac1-08ddef64c01a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6597
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

Update SMUv13.0.12 partition metrics to partition metrics v1.1 schema.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 09f1e4072db6..2cfc221dc3bf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -671,15 +671,14 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
 ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu, struct amdgpu_xcp *xcp, void *table, void *smu_metrics)
 {
 	const u8 num_jpeg_rings = NUM_JPEG_RINGS_FW;
-	struct amdgpu_partition_metrics_v1_0 *xcp_metrics;
+	struct smu_v13_0_6_partition_metrics *xcp_metrics;
 	struct amdgpu_device *adev = smu->adev;
 	MetricsTable_t *metrics;
 	int inst, j, k, idx;
 	u32 inst_mask;
 
 	metrics = (MetricsTable_t *)smu_metrics;
-	xcp_metrics = (struct amdgpu_partition_metrics_v1_0 *) table;
-	smu_cmn_init_partition_metrics(xcp_metrics, 1, 0);
+	xcp_metrics = (struct smu_v13_0_6_partition_metrics *)table;
 	amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
 	idx = 0;
 	for_each_inst(k, inst_mask) {
-- 
2.49.0

