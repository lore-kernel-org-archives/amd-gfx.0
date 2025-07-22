Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736A0C83F27
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 07:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2557110E60E;
	Tue, 22 Jul 2025 07:47:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t+utu8PM";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D056710E60E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 07:47:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rA3+J14jXBUWnJLDUXfMvSAHCh3MCqMm+/dwoC1gnkN2VhMaQ8Z1TZTBUG4Itwz1iZS9bucIXB358e09jlzbDDrxGQ9LMBYbrzugioPBf2x7x/VGfVfJrJQfmBVgzpdLeWY2UKg94rdJdLVXcC/RnNpzztQck3RmxDHZWdWmcdVTgAXd5BmUkciTFXw9oFns741gcjksdYorP8nxQPrKzDQddJ1O6Y+WwYAGPrdsjAbo9HJkvHdXXwBzAKiQahNkqrE7vVR2bETIa7BEPxSICwxRAquptQJYcPE/wlUg/qnXyJOFK+hJXs3HhgsgG+zghnOPvt0yrBSxR5GPYAVvVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S01dwU1udeSXd1HBI6T0G8Dfs2MWdyIVle9QPhFze14=;
 b=t51pScr4Sph1nIJLz2g9wJMIONL6WGttPrWzI11V8oSpN9pI44kToE0qU+vZJrid70bXwBBoBUywI5d2rfhDs3NDxziPslUkjkI2icGjy700zrCLxbM0EU+Ue7Bkn74rY5utWra7gnapzKt23s/Ahr4Pqy6aj+aGPcbUm1UO+XBrILAgemf0LEGHShwQgWjpnyQOEBUKak/xhvyCbBDRWV8vLVKUTCqIqUgQwVU23FsorIzpzvdo7oQTmcwSQTfTaUrazeQpdpV+nNHF31SguMKFUSTwYHY1V/3OcscrNFn9IgCAfoXeMFp/oDOiypK5oL5zie1cIGuqODGDbg4LQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S01dwU1udeSXd1HBI6T0G8Dfs2MWdyIVle9QPhFze14=;
 b=t+utu8PM3JAvu61KcyuJyBI49x+EPSPkqCFsN6NajYq2kDwRbTbdfGZTuFzBDqckWI7aXqX0NAs70/UJA0DN+CaxNAGtAYuoz+mde7FSXqTkPaAXilzms/vTc1AD9s2Oc6BEGkEognMeCoMSrzkOJfyVoDyKThvUluoHDCfLdBs=
Received: from MN2PR11CA0025.namprd11.prod.outlook.com (2603:10b6:208:23b::30)
 by LV3PR12MB9185.namprd12.prod.outlook.com (2603:10b6:408:199::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 07:46:58 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:23b:cafe::95) by MN2PR11CA0025.outlook.office365.com
 (2603:10b6:208:23b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 07:46:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 07:46:58 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 02:46:56 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v7 13/14] drm/amdgpu: validate the queue va for resuming the
 queue
Date: Tue, 22 Jul 2025 15:46:22 +0800
Message-ID: <20250722074623.1464666-13-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722074623.1464666-1-Prike.Liang@amd.com>
References: <20250722074623.1464666-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|LV3PR12MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f28a127-a443-429e-82af-08ddc8f3eff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dE5kTStIcGVBQytWSExmRHpsZ2crc1ZlUVZNU3JrYnlvOHFZT3NwSURnVnEw?=
 =?utf-8?B?bFlBbFBlVU54QmF6REMwVTlSN0F1TUxRVmFRQjUxQVJxWmxOUEFSb0ovUjRU?=
 =?utf-8?B?eDRzdTVFVmtkTnRWQVVZb1E3R09mMS9vdjJvZUhXdE1pbmdoblBLS2VmYTZ4?=
 =?utf-8?B?elFKeWpPUTV0VDRmakZ4R1RkTklKZS9CeDQ5NWhsU3E2bjR4OGN0bXovWnNK?=
 =?utf-8?B?ckZycVZXL0tZZEEyZ1h4TnNsUUh4SFRYQkMwb3B4U3RJWEdxTG5LN2ZCcjFa?=
 =?utf-8?B?VGlsYVNpdlAvUjlBajNwSTh6eHdhMVpWVU1kdDJnZ1RSa3JOVUR2RjQrS3gy?=
 =?utf-8?B?M2JObHNMLy9jUWdEcElqTC9DYlBCam5ERUpEWEtTdnRUWkRDcVViQlVyaERr?=
 =?utf-8?B?L056VDdTUS91MDd3QmlrOXIyMDlCdmRaNWd6bCtOVTkwOTIvZXFSemtuQm5w?=
 =?utf-8?B?QjdpTEt4OGRQYjdWa1oydDdMdVpRd2NaejNJZHJaeTFpVW1ibUtrS0RveWNx?=
 =?utf-8?B?a2hBUG5nWDY3di96blpwZTljSXlxd0ZicDYrQXArTjdCYzRoUUg4R3p2R2Q1?=
 =?utf-8?B?OEI5LzNDSDVWVE4wVXVrZ0NHMlNrNlVMRDR4U2dJSlkzVGtmQWViQUZDWTZm?=
 =?utf-8?B?aURpQjVlazNtM2R0Y01USWVVRkttR1Z5QTZSVlM1eWJhWFdTSnhuTkxONUly?=
 =?utf-8?B?aUFiMDdrbWhQZUdmbitkSjIrQks4N3JBT2trbEdndjFMamNNT2xzMmRLRzZQ?=
 =?utf-8?B?RmVwejJnK2ZBN0VtaWpXQmE2MG42ZEVNZnVDYVRrOGZzM1JiQ2o1YUdvVlph?=
 =?utf-8?B?UHA2YURVTk10SytjQVRTeTR5d1ZCekh0YitCakhsVjlJRTlYT24ycVNDUnQz?=
 =?utf-8?B?cVBhSXFQamViaWExWFNSMjJWendXU0pDMTlnUWs4Yy9aaDNQemN0cisxZnkx?=
 =?utf-8?B?OGpWa3E3NXFZaDgxaTBVdlBBVDVwNnNHb0RXTnFlb3p2alNlR3JPa3R6dHYv?=
 =?utf-8?B?YTJHRlRZTFRkbkdTVGZVSzl0NmdUd0E0SEZleTdGc2hUTjdLcjBEVEp2aUdQ?=
 =?utf-8?B?QmlRemhkMzdESEY4ODkyaERhUUI5bnl0NytNc09kRjZhYlROY0l1eHlEMVVS?=
 =?utf-8?B?T0w0TlhRR0xLSjFLRUptRkx0MFZ3S3hXL0EyL2RYVzNaZnFEcHhrLzcraDBW?=
 =?utf-8?B?SFE1cVNoaTkzMlBtNWl6V2ZKU2poZTZSL0drSWdaR0hwTm9jUm9VWm90dXUw?=
 =?utf-8?B?SHhaNktBNkFoSHYxUlFCWFhlSDZSVXFqVzM3SS91dGRaZkplVm1vZ3FJc3Rv?=
 =?utf-8?B?UTdnb3JuanBOeFpxUmI1d3FvNFlSa0FnVmRzb1NkYStKQTJ5c2lsNThEU1BL?=
 =?utf-8?B?Z0t3eTVFcjd0VHRaVjMrWE01MzVyeHhkOWllY2NUVHNnVTltb2xCZUw3c1Jx?=
 =?utf-8?B?bVIzd0xaRmNHaVJuY01uKzJTQW1oWnpUb08rNHAvTDN0MGRhdUlZWWR5N1VK?=
 =?utf-8?B?R2twY2lDZldzZnQ3SzllaDdwbDdwVWRyek9wQXMvRk1KQmo5NURkbGlzdUZo?=
 =?utf-8?B?aW9FVCtTTXgxT3g2UjFQSDFEcVNLdS9JUTlZRUcyVzZ0cHUrZmkxUXBBcEJP?=
 =?utf-8?B?RHh4WUN6SklNakVaYkVZS2NPU2pid21NenEzdjZuMTJWY1VSQnNkeG9tU3JZ?=
 =?utf-8?B?QnRGWE02SFpqQkZFYnBMUnJ0RC82RFNhdHl4Q0ZNTnA4ekVhUmVsUC9ydmND?=
 =?utf-8?B?TWNYeHlJWVJzRFMrN2ZtYlpsaDNvN2tKcGpzTDlBK29DT2V3S2RCcklrMjBE?=
 =?utf-8?B?YWwwM08rdXpaYmhXQnQ1K3hQTUNPTXFxb3ZIblcxUnJwdkx6Y0pReU5RbjM5?=
 =?utf-8?B?eXBZSFlxbzg1T01lTE5kY2h1THVmVXlGTUtyU0pBUTNSOTJkYzZJNVNsUE5u?=
 =?utf-8?B?RU02TmppQTl4THNiWE1IVXUxSFRBRmZsQ004bEcwNWVqSitpbEFaVDBWOElr?=
 =?utf-8?B?TEpyK2xjN2s4dTVpeDRnNDkxWk90T0tZOTBCdHk1WDhidVZneXdkc1Y3eldL?=
 =?utf-8?Q?MrKmTF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 07:46:58.4191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f28a127-a443-429e-82af-08ddc8f3eff1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9185
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

It requires validating the userq VA whether is mapped before
trying to resume the queue.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index a41aaf4aaf4b..77a2f12c8dcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -814,11 +814,18 @@ static int
 amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	int queue_id;
 	int ret = 0, r;
 
 	/* Resume all the queues for this process */
 	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+
+		if (!amdgpu_userq_buffer_vas_mapped(&fpriv->vm, queue)) {
+			drm_file_err(uq_mgr->file, "trying restore queue without va mappping\n");
+			continue;
+		}
+
 		r = amdgpu_userq_map_helper(uq_mgr, queue);
 		if (r)
 			ret = r;
-- 
2.34.1

