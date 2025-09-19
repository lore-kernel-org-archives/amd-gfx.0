Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC15CAC59A
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 08:11:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E3C010E965;
	Fri, 19 Sep 2025 08:11:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="151bfBPO";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A0FC10E966
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 08:11:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4rI3V2dQMju6uR9QrOTzBpAv/k92k6Wv55IFMIed1Fc6Xj7Q9MQuhi7H1HMGpp4hbCN6t9DglfAgA/ID9U4Nlx+kXtHJ7rQsv6fcHNJbfj07DWWx8mtLLSkpUO+lkHTiu6IHZEIVIKpmsG2Svu68loX+mgdWa9jQL9YLoeo63E70G3Of5vpzXBBCab7APGqGHb4AnN/aGRkaWXCrnFY1YYMJvXYnvW9RfxlrrOKoJ4Fih/3T4RRzn9PD/QLPMdGivVXvmgchHp6pdQ1Qrq9LaV0n9n0xAFQb5ayw0VoeCm8IKLYlmm0NTQvR2olEX3Jlfcpp7Qwt3xOywF8MEuUBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42YJ5qRIbjboPgr9JRRxkdp6WASJV8q1ovo55/Nn5uw=;
 b=OAIYh0oxviSXpm3uvydfZhVqHTJ9mAGYcAcGYd+wV5d2oJlnVmqDyM01/ZbjbLU3WpG6QEvE61NduAOorKZgqiJpqVq/i1oABMhP8AgF/jNwHCBSIXU8G7kkaI3OaKkyYMQGmGB+qdflRguCUgBvtS2CjNHZL2TQQj3HmmzQa3HC4vwr/xBQZeUpgpB6s0CELI6loSEDOxTGuEqI6P9cFPvbw+T8Wu/DQu98aAUtYKNgK6ZLIQMpDU0F+sTQ0cqabRc2MwL/MWe0xfvq30iVkkxKGlEknKmYHweHxlAi1enoLPEzZI97d3Lmncq4h7aE5LMynlCzSBqoqIIwbYMuiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42YJ5qRIbjboPgr9JRRxkdp6WASJV8q1ovo55/Nn5uw=;
 b=151bfBPOw6GttdMEcPMbdTzaPtmOBkEO2Yllhzaxk4/hilY8NAsZlt6aT8hGUboLQ0+rL8/J9zn7DJ0Azl+BlVzjHRtOR/5fkFVkBqXFeW3j/pDWTejMu4aSwIQ+IiBCeoLbxc+TitSdOIroH9o9xgohc08YtvrYwFpgSBulitw=
Received: from SA0PR11CA0066.namprd11.prod.outlook.com (2603:10b6:806:d2::11)
 by PH7PR12MB7843.namprd12.prod.outlook.com (2603:10b6:510:27e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 08:11:35 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:d2:cafe::cc) by SA0PR11CA0066.outlook.office365.com
 (2603:10b6:806:d2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Fri,
 19 Sep 2025 08:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 08:11:35 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Sep
 2025 01:11:33 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v4 07/10] drm/amdgpu: add UAPI for user queue query status
Date: Fri, 19 Sep 2025 16:11:10 +0800
Message-ID: <20250919081113.2797985-7-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919081113.2797985-1-Prike.Liang@amd.com>
References: <20250919081113.2797985-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|PH7PR12MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0df362-2762-48b2-41d0-08ddf75426ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ty85OEUrZEV6dHV0NzdnOGtwUDcyNW1iMXNKR3dCWVRNMmZEMVZpbXBVVFhL?=
 =?utf-8?B?V1RhdzlGamtoTDVPbXd0U2JOWGYzOU4yMlViRmNVSFR2TlY4ZTdCc1BXSUVs?=
 =?utf-8?B?NmluazJORUVCOWV2M1l3VGdXTTdBQlVwQkpidlY5bk9sYW1xc1h4MHN5TFMz?=
 =?utf-8?B?K0lXQ1pSS0FkcU53MnJCZTZDV0E1V2MzSEphL05STHpqNTIwalJyaEdzdTlw?=
 =?utf-8?B?MTFOdEF0OXdvc0VVWDNtdytMS0lSU3c1cmJoaHpCZGM0c0hjNkxhckd6cVM5?=
 =?utf-8?B?WWJ5bXVYNmM4TjA5SlFRVlhzdGV5RWFvRHZjZmNLMm1ObzVidFI1cithNTAw?=
 =?utf-8?B?THViTjdhbEFncXZlYmlmaDJTYzFyT2hEbkkrVnI1dGd6eW1UTkJUT1FzQTdM?=
 =?utf-8?B?YytrUGI4N2swQTRzb0RmSlVJK2Y1UkRabW05ZmU4RGhRcG91SjhWT0tYR0Q2?=
 =?utf-8?B?VW1yOWpabVBUaXF0WmhUckJLK0VHSElDWDJDb3N3L0ZQRkxtdTJoOGNkangr?=
 =?utf-8?B?RGE5MDBKdnVEaDJXU3JrcUYrNE5sVVdUQXhRVmdKYm5Ja09YWjR3Nmx1aDVY?=
 =?utf-8?B?ZlZtUHR2WnFtdWJiOUhHOUFEN3pHNW5xRnpMY3AwYWt2dGlDamJTWnVRU2Zp?=
 =?utf-8?B?alVURmRGNi9MUzB0UEtpNS9sUi9JRU1EdUUvNmJjbEJLRFBvMGdhemtBbjdJ?=
 =?utf-8?B?S0p2QXFkTm5kRUNQSWFsT0NiR0p0TVpnWExiUW5mTGN2eExoQUcvSHVvRVUw?=
 =?utf-8?B?UzlNS0FqUTZHY2ZWQkRta2loZU1IQzNCNDlDYXdWYVJBUnNKMmo0Z2VMcERp?=
 =?utf-8?B?SDQzOUtrakFSdjA5UXdGL1RoVEVSbmlZVzVldnR1TkhXTmhFaE5YbFZmSDFN?=
 =?utf-8?B?eHpVZEdkbXVtTE4yTis2ZEVXQk1kVEFYem1vNXhwWnlDa2JXbWhPSzl6b2RV?=
 =?utf-8?B?QTlwbW5GR2RnUjFZWXFwWTNwWGprUmdFRmp5L0dKMHF3MDRZTGE2QytuQ3Ir?=
 =?utf-8?B?VGlHQmJaRTl4MU9QYWxFbTJMdDdjaDUzcUNRWWVJL3Y0NCt2eDlWLzhOTHpJ?=
 =?utf-8?B?Mkl2S0MzTkZDZmhPR3h1QVNQclo5NTM4WlVQMUZDRTZXbnB4SDNveThwSmFW?=
 =?utf-8?B?VFFEU1lhTURCS2taSFh2NXRJdDY5UFJ6YUVSZEtLcUJQSkZxZ3h6VUpObTN2?=
 =?utf-8?B?dUFweVdob0lweGlmVjhVUG1oY0JsSHlaWjQzcW0va1dNWU5vcFU1UEZtQ0o1?=
 =?utf-8?B?R2pqSzBOa1Z5bDhsVy84YUY2RG82U0poRVJLMTFIMHpaQ1JMUlBEdnByY1Qw?=
 =?utf-8?B?VGpMa0pDeFFIUHpHeWhrQnB3ZCtVcVczeDZ2R0lSb0dNbzRNQnF2cS9FRmRX?=
 =?utf-8?B?M1pFS1J0U0VHTDd4MVhMM2hZU2s0ZDVFQWNtR0EremFnd3gxaVJWTC9OOGQ1?=
 =?utf-8?B?d2QvazBSbmtscFNTcWRCdWNtWTZ5OVUrc3BIaTJPTG4xa1B2NHkrMWhvMmp5?=
 =?utf-8?B?a2Z6ekVGYi92WDNKMk9pSWIzVmF5ZmNhMHhjb0xCamg0MzVUNVB2Wm4rdFBz?=
 =?utf-8?B?ZzBPdWpaVlFTdGxNeTZJQVQ0TklLRUdvU2hIY1FvMmJCcmMzbStlUVVsREZT?=
 =?utf-8?B?SmlGSWp4b25VTU5MNHRjdjdBcE1Dc01tSExIS0xxUUE5N2RDZjlkWG5UYlNz?=
 =?utf-8?B?U3o5VzRCRWI2aG9ONnZ4ZUpjR0dMdE1yT1hpZ0xIZXlOby96dWVUemJFT1Bw?=
 =?utf-8?B?Vm01ZVpnOThnZUpWb0lYdTdLUVZVL0VaNkhubUpjZWZXSzlVMlEzVkh6UFFw?=
 =?utf-8?B?LytXeHFxckN2aHR1eDJzazFYa2x2YVRqT2JiVkN0VFhidXIwZjltUnQvTFpK?=
 =?utf-8?B?T1c5ZWdFanJVUkRFeDQvb3FCeURydXpBQ2JkcDRUTjB5OEVSWk94d3FWcjV5?=
 =?utf-8?B?ZzZZQitxRmlPMWhYMklOM0FLa0RKUkdHWFJrV3VzOVpKWVVJUkx2dDNiNVRI?=
 =?utf-8?B?T1gzdDlBNVk3WUtBdkV2di9ISm9RUzllZDhpRWkrbDRjNU81MzNJK2ljMm5l?=
 =?utf-8?Q?BowEIs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 08:11:35.4121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0df362-2762-48b2-41d0-08ddf75426ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7843
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

From: Alex Deucher <alexander.deucher@amd.com>

Add an API to query queue status such as whether the
queue is hung or whether vram is lost.

Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Prike Liang <Prike.Liang@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index cd7402e36b6d..871e0f56d61e 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -334,6 +334,7 @@ union drm_amdgpu_ctx {
 /* user queue IOCTL operations */
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
+#define AMDGPU_USERQ_OP_QUERY_STATUS	3
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -346,6 +347,12 @@ union drm_amdgpu_ctx {
 /* for queues that need access to protected content */
 #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
 
+
+/* the queue is hung */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
+/* indicate vram lost since queue was created */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
+
 /*
  * This structure is a container to pass input configuration
  * info for all supported userqueue related operations.
@@ -427,9 +434,16 @@ struct drm_amdgpu_userq_out {
 	__u32 _pad;
 };
 
+/* The structure to carry output of userqueue ops */
+struct drm_amdgpu_userq_out_query_state {
+	__u32 flags;
+	__u32 _pad;
+};
+
 union drm_amdgpu_userq {
 	struct drm_amdgpu_userq_in in;
 	struct drm_amdgpu_userq_out out;
+	struct drm_amdgpu_userq_out_query_state out_qs;
 };
 
 /* GFX V11 IP specific MQD parameters */
-- 
2.34.1

