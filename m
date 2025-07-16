Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB0AC83F1B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 11:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D61E10E797;
	Wed, 16 Jul 2025 11:00:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tw5Y+czs";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2F9810E797
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 11:00:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6p22YGzlgbnutqc9WyKcxqKF79LNZABTyjoAXfknDH1T4dDcDORtSubEvulH1Lu3v6mwj07g4qhFtScZZEGp8VrLsNYNXCtxh/f2sp2yR0CdEXbI3zjkdbMk+NaAyCSyZNQhSXaqXfu/i1jb1iRBwxPZn/qQHQh1sj5odCL9p9MDm3vPuHXzcV0RKlD6tVwuKEf3FO/kA8sq+KOp5IiM0ZRWL7xZZhMd5RkMTe4aGQLVWRxtjcu/yI4QVGySTkGxWN4uEG9FaQoYeBYHtnxRQsU+nv30kFHttPHwbNmErDxIQFyckupZpPfr79g0W7E3HwncSwpX3h+TAISHl1ZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kD94QBksOzwD4RDtvcfSnbwggobIud1yR6FNCvx8cSM=;
 b=A/KplJVDQKmVaejAq8ITQtaG1OGjHPgqkl2WbFcRNuuXYW0OeQxwCxipuGVp/BR+ztFMcLAVqjBDKYV4yA3mDs+OnOPqed5uiGiRgJ1cIYtgG9DlDovyIHz42H7BFBWBPx5DeaIDnlMKrqz9FnIeXA4MZJWNVQ/Kte8q1joYKLBwPrJxP1J2rVeuErRm/zr0QtZ19dnDaXP7l4Xe89eE2u09DHRH9zGl9zVHw9aLM9G9zn43PoElnfbWx/OaA0QiEo0S1u+7owhQi1DRYG+fYpAqNu0LR3bxVTPH3rJtFqgedPL1bM4TeeyIPJ7QpcnG9oWG2idfX/JqOS8YHENbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kD94QBksOzwD4RDtvcfSnbwggobIud1yR6FNCvx8cSM=;
 b=tw5Y+czsoF8VjxNMS5mdt8tWDT+BdcWfqmgOSGEoi7lk0rrGUziaQkVXXNY0K8IJ0lDn+NQz2cGsQKyjqpNCCocwpUrnE9PBqwivDgI8NxTgz/JRH0G0ekBO3wlALBtGztcqklGcJkOGYDafvUgY3bRwW7c+JFaNAD41nEIpf3M=
Received: from BY5PR17CA0002.namprd17.prod.outlook.com (2603:10b6:a03:1b8::15)
 by LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 11:00:35 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::c2) by BY5PR17CA0002.outlook.office365.com
 (2603:10b6:a03:1b8::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via Frontend Transport; Wed,
 16 Jul 2025 11:00:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 11:00:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 06:00:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 06:00:34 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 06:00:27 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [v4 07/11] drm/amdgpu: add user queue reset source
Date: Wed, 16 Jul 2025 18:59:27 +0800
Message-ID: <20250716110011.1670654-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250716110011.1670654-1-Jesse.Zhang@amd.com>
References: <20250716110011.1670654-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|LV2PR12MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 062ff627-9c43-431b-58cb-08ddc457fdbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDRmNHcvNVZ0SGthS2VLc2IvT0pnV3loR0hOTGQ2Tm56ZDJDelhRaVQ2WS91?=
 =?utf-8?B?YTFReUNvTmVFN1A5eFl5YThqYjFLdmk0TGZEU294OG9tM2IyRGNyYVBlU0hY?=
 =?utf-8?B?VWVHK1ROYjZpQ3RYS2JaaFRIVkV6eGo2YzZ3RjA0VXNGZFRYL0d0SWllRjBa?=
 =?utf-8?B?YlRUNmpUL0ViNkUrYXhpdStkZGxpemJVVktxQTVQSXBKVTFIS0ZjUWlFalVa?=
 =?utf-8?B?MGhCQjZETndTc1VEUjNLeUJCOHZHOFA4OE1tWHRVNEFxMVg2MGZLeXorV3lU?=
 =?utf-8?B?dUNMTXFzSC8ySVI1RGNOcElyZ1FkajZpekVFdGI0eE80VDZBZHpiWXNINXFR?=
 =?utf-8?B?SFVKQ2JmUkZ5bytlV2tIZm45YmpFNk1nK2JpNWx0am0vQm93TkRtUzIrRW9S?=
 =?utf-8?B?ejdLVlNsakpGRTUyNUtPcmJjbkJxWEk5d1RibmI5K21BcHZNUVVaS1FqQlVu?=
 =?utf-8?B?ekFqL1FCUS9lc29JYmFHM1BUWnNCK0JEV1NadFBJSmV2VVVrbVlFNXVUMzQ4?=
 =?utf-8?B?NEw3SVhhUXM1cVVXQU1kV1NpdTAvQ3hHMDFMdEZVVU5ZODJ2djI5T0RyVFNJ?=
 =?utf-8?B?UFRGVXhKSDdlNGEyUWFKWGtqN2ZiZVZpVVZuOTVwWkR5S1ZnTTJneE52TzRE?=
 =?utf-8?B?QXZXaHh5b1lkWmFxOHpYSUpVY3lRTndmY0ErVmVsb3F6Z1Ryc3BXLzhhbXE2?=
 =?utf-8?B?ODN0SHJwVVBTT29OTU5ZZ2dtdTRIbWxOYlAxMGN2dUtFcVp6dTR3c1BzWTNp?=
 =?utf-8?B?ZWhqNkVXbkJqWGd5emk5L1VValYzdkhmU25UL25HeFpKMHBCUnVOdSs3QVJv?=
 =?utf-8?B?Q1ZrMXB6bW41MzV1Y1dUcFAyOHpYS29JMFI0dXdtMi8zcFh1WWxsSWR1NTdh?=
 =?utf-8?B?OSt3S1dGd05XbTQ0SmVXRDI2OHZqLzJ1VUJ0YTkrWmUybEwwT29TbU0vanlp?=
 =?utf-8?B?akp6VHd1RUV6aGlMTjhBMHhGTmY0Vit3Vjh0dWRrQ1pYaWw0bTdUcnQ4cFFD?=
 =?utf-8?B?M0VuaDZvSG45Qm1xZ1E5eUlJU3Mzd28veWk0dGFUQlo4Vm9IZ3VqSUxxcEZY?=
 =?utf-8?B?cjd0YnR3RXRENlo5WVZjVU1kNkd3YkNjYm9XZkgvVTVIZkV2WjdVb0JxVXFy?=
 =?utf-8?B?L1l3b3hYN1NMdm42TUVUOE0xQkRmWFNuaGtyZGdtUTdwaE5YeWkwR1cyTmYv?=
 =?utf-8?B?REFubGtYQzRYTS91UFZqZTN4Nk1SQkpPa2NEVGd6VGg4RWROQXE5cFdwTmFR?=
 =?utf-8?B?TkYzc1J1SjhiV3J1UHZlY1pBaFNyOWpGS1RrYmNac0hxTFhDQmRFSkxVdEN1?=
 =?utf-8?B?T25lZmR1bXFKaXNOakZ4eFNJaFNoMjRzcUJreXVHeUlJU1ZKK0hHaHQvWkNH?=
 =?utf-8?B?ZDhkNWtJYXdRczN6SXRuZGNmRFFsMXJTQ2lrOUptMEpYYThIazJtSzFwb01o?=
 =?utf-8?B?bXVDdU40TE9DK3BvcGFqYVlGdWVIQTVBSERzYnUwMDZwUGhxaFU5aDNRVlNQ?=
 =?utf-8?B?R0R3TEVkMWI4VjM0dHlBZnN5SWY5djhkMGJaWWNvTGhXZFV6VzNaN1hqWUE5?=
 =?utf-8?B?QzhKdjdqdUgzWDJOalVHWGtsQU5CUExQMzhPTzI3a0pBNTNQLzZCa2x4NnNM?=
 =?utf-8?B?S080aHVPU0JIMUh5NEdBanVyUzl4QU9HUzQ1aWk1SWFNSUlPdHVGMDJONGl4?=
 =?utf-8?B?Y09CeDg2SG5kMXJ6NUxiaEliNzh3U3I5SFh5ZmFhYnEvZWo5djlXR0FkZDR3?=
 =?utf-8?B?WWtKY29IR0psejhnRTl3N2Jtc2hyTkdJeUlhV3pHTE8rUVN5QVdleElRTFU4?=
 =?utf-8?B?REFteVFiZlhRZDJRc1dkK0tsOHF1WXBVeUgxZ3BZZUlMUkwzT2R0dVA1U1g1?=
 =?utf-8?B?RXFnazJmZ0FuRThIUHF5bnhyMEdudE9oN2I5V2tNRzNxaWlXc0l3Z2FLOUt5?=
 =?utf-8?B?aFltVm9KWnZQQkk1RytUc3RydnZXV01VeVZpcXEyRnZEbFo1bE9FaFFqZXVC?=
 =?utf-8?B?R0JrUVRnYjBXcUdFT2lHUFFibnBaZ0pLWG51QWlFYU9yTDh0dTlMWmt1WlZT?=
 =?utf-8?Q?xdB4QL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 11:00:35.3936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 062ff627-9c43-431b-58cb-08ddc457fdbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871
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

Track resets from user queues.

Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index dabfbdf6f1ce..28c4ad62f50e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -340,6 +340,9 @@ void amdgpu_reset_get_desc(struct amdgpu_reset_context *rst_ctxt, char *buf,
 	case AMDGPU_RESET_SRC_USER:
 		strscpy(buf, "user trigger", len);
 		break;
+	case AMDGPU_RESET_SRC_USERQ:
+		strscpy(buf, "user queue trigger", len);
+		break;
 	default:
 		strscpy(buf, "unknown", len);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 4d9b9701139b..ebcea44dd743 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -43,6 +43,7 @@ enum AMDGPU_RESET_SRCS {
 	AMDGPU_RESET_SRC_MES,
 	AMDGPU_RESET_SRC_HWS,
 	AMDGPU_RESET_SRC_USER,
+	AMDGPU_RESET_SRC_USERQ,
 };
 
 struct amdgpu_reset_context {
-- 
2.49.0

