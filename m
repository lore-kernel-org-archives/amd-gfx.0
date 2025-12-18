Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39D1D711CC
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 22:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BA5F10EBCD;
	Thu, 18 Dec 2025 22:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WNfFMHdu";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011022.outbound.protection.outlook.com
 [40.93.194.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DCAB10EBC0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 22:42:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sna7eVWLeOqt7wJSza8Xu0jXmWOXoAsfGbXJqUuALjFHG2p5THeza/3f4SM5Hj6J7muJY3TbtJF3pX4ilKsjEoyYcj1H9XWDzhOb/qfLVjJB/JCSQYjsj5KyUKvzIm5XW6hAlaQxOl2k713SAzQF660+qvaycDbpdsxu+M5XEEtKs39nhNk2p9z3iicPSuQ4tujGHt8lGpCqcgFtYck4OOuOYOW8/ShR2t9PGzo0bFtAJ9T+OThd+HBwHICwPx5tP9PdBX0PQyiLADuc7CdTgI5uxZGQbc8+7JB+C5shl4gGHypTrsJAuqCK2ho7EjsnGMG9omcw045I68XMh3ursQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3J7lq4md2CaPLyGOcBIt6YiXmlctRLrE98g0jnM0Poo=;
 b=Lp5hhFDGMOjImTjPVFbeJwPjGYG20CaTJ6jDG5+bY+KO+YQB4oof16xiUZRaHHfE85iPiYpY+xLiChPyN0UCmcnUH/ZylTeyF77MYPaU5PgZkyF/0bodciRq0PeBsKZY1b3zLzVhvMBJQoaXw1vEbNyaXP5k0uoTuC36mdSLzWiMMo07bLQ9AqBoXE29sncKFgkEm9VqJk9wCGK/wNenqUMSu8juFY7rmV02s6omnkOIoVKvrHNF4Ovy/zQjWiZA84N2DKR++DGurI09ibfhHPbyw9S3oQngWwY4DAB2eSHI6xOf0nDJ+eVNAvgd9QPjnD39Sx1wVu7bJmC406n0Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3J7lq4md2CaPLyGOcBIt6YiXmlctRLrE98g0jnM0Poo=;
 b=WNfFMHdufBj8BQm0IJ6JYEtIXAKZwrVwFjUGO+BGPZFO3llCE8KSYRLM/d6cHzWgFyp8TZ+WY2vDbXLoMKtp9SNmpmdgkkhS/QcYOhD6l02lZm33XUcfeSN2emYGFkowBNAYchH8E5+JO8f615E0BHFNHpZx+QkcNeSApVr8QhI=
Received: from MW4PR04CA0108.namprd04.prod.outlook.com (2603:10b6:303:83::23)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 22:41:57 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::71) by MW4PR04CA0108.outlook.office365.com
 (2603:10b6:303:83::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Thu,
 18 Dec 2025 22:41:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Thu, 18 Dec 2025 22:41:57 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 16:41:54 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>
Subject: [PATCH 4/7] drm/amdgpu: avoid a warning in timedout job handler
Date: Thu, 18 Dec 2025 17:41:38 -0500
Message-ID: <20251218224141.5841-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218224141.5841-1-alexander.deucher@amd.com>
References: <20251218224141.5841-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c4fddd-0475-46e3-8ae8-08de3e86a685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N09OdVk3dDNIbDlnTWpGVk1tcEVrOVNCUlFkSXl2blJzRkJCNndvUUU0Tzg5?=
 =?utf-8?B?QzhsTVUvcXAvbUpCMXlKMzg0azhkcXZTdXYwTUVIY0JraFNpOS90aGl0TUx0?=
 =?utf-8?B?d2QzVmU0dGkvdGxZdHhmL1B0eFMzVUZ0ZWFIcnAwN0xaKzlGaFpleDlzNTli?=
 =?utf-8?B?S1VMMk1SUFBpemx5YXRBc0tMSTVYVnpaTU1iMlc0RU5YUVJmcXc1aUhWQVF1?=
 =?utf-8?B?R0xyVGxTckt1cy9jdU5YNU84ZFRJWkwwa2U2ZmxEOWxNbmY3OGJSUEd0Ny9K?=
 =?utf-8?B?VWhHNnFXeWoySzBmV2dDUUcxSFZDN1VteEx3QTJaSzMzSDFZZWRaWXBlelBl?=
 =?utf-8?B?YmhuYWkxZVVxYlFFNE9CUDl5VFhnSVJrMVQra1pTSWoraHZvdEZlTU5Pc0p1?=
 =?utf-8?B?TVBLeWpuYllBQnlGTXdiSkl5S1luakJWWWV0c3ZDcGgzS09jMGxZT2c2cHl4?=
 =?utf-8?B?bklWODR3Mi9KZ2lTbm1paG9CUUx1ekVzZG9OaVZoRUhEYmk1NUNhZG4zMS9M?=
 =?utf-8?B?MFZ0S0RreHNUcWx1MjZ5R005Qk5XM09IczEzdlVYYktWemJYVFhYV3p1cURo?=
 =?utf-8?B?Qm1YSUQ5S1M0djNCNCtKYXd2SnpKcG03S2crc3l1aFpjZnMvMzZya2tmb3Bq?=
 =?utf-8?B?RUswT2tkOVl5MUx6bTZYOUc0Q2hOd25RNThzeDlZdVl6OXIzSnB4YkltTUta?=
 =?utf-8?B?SllWcWtabWh6L0RnaWxQb05FVDlodTVVc3VvandTWCtmUmtlRjJydzdaUUhi?=
 =?utf-8?B?V0k2NXJadHVDZ0FWWnBmNzJxcVhyb1kxVGYwWVFEcXU2QU9hdW5QMXdINmZZ?=
 =?utf-8?B?aTU4aFNJbDNxbHJjSlhhUHRXTkp2ZlI4UW8reHJnN0pSR1p0VE1pcVdrL0l2?=
 =?utf-8?B?RU1VNDVzdTE3S2RCc2FoVEpyNEpIRTlGR0I1K3RIemJMYWw0TFlYcDR6ak0x?=
 =?utf-8?B?Y09paFZrU2NzdWc5SmV3TElKTHJpeHJBUTJUaHlBRXVQVlBYem5LeVlkdHRG?=
 =?utf-8?B?MnhIOXoxalNHUHdNSXVIQnFZNWhPdTFqUkpKVk5RU2VmU29wQkdnN00xOHkz?=
 =?utf-8?B?M2VQcjlzaVJ2eXFWMmFvWi8zVzh0MXBPbitENXdnWW1tM3lXYnpRN2k1Nm5N?=
 =?utf-8?B?S1U2RHlnazdPK1VtZTN1bWtWZ01aM0l5QnVzWHllVWJKTkZZQU5GczFxdlFr?=
 =?utf-8?B?RjZFY3JCNW9mWXl6bzlrZ0J0WGo0U0QyaHZramFjM2FxR2NzZFdGTlhhWXRH?=
 =?utf-8?B?anpucFlEdVVYa21ZMFUrUy8wQTFBNHJLMy81ZVNhM3prZjdxNnl2WndIWUVZ?=
 =?utf-8?B?Umk1WkpMKzVXRW8rbWZneTZNNlpYNWN5RXllZTlvZmJLaEF3RCtveXlzOVV4?=
 =?utf-8?B?SlF4b3pUbXdDYU1JRldHaFl6YWRCRitrcW9hRnNYM0krelVlbEF1VGltQVNF?=
 =?utf-8?B?SkEyaC92RnBZeDRYZHVlQ3pLZVNDZVNYR3hub1B5N1B5aUR2UEp3N0I0aDl0?=
 =?utf-8?B?YWRFWXF6NzlyclVhbkhUdUd0SmV2aHFGSnVWU0FGYmtNOGQ1RW1xU0VHVE9h?=
 =?utf-8?B?QWxLTlRhZFVDWHF5aWxKRTBqVCtkQnJtalE0VkhuNU1UVCt6QXhUa2R1WC8y?=
 =?utf-8?B?V3pvSEFiNTVPT1UwR05ZMTBCaXVsZDJ2Q3ZYN2hJNVZzSzZPZkxsOTF3UkM5?=
 =?utf-8?B?SHZmdlJZbFNiN01yb29XbStSK3Izb1JKd3BoZys0bUxIWTB1RFk0SFRtMDBJ?=
 =?utf-8?B?N2hNK0pWSDM2ZFBMYkxzUEE5aG9VcXJCbENncU9MSmhVY3QzZ3h3eVZBa2tH?=
 =?utf-8?B?enZQZlcxQnp2S2VneFF2S0pQdDRsb0xyYWxHNTJnMklzNjA4TEVsNmFWTUl0?=
 =?utf-8?B?UmNFVzBsS29WWVZnRkNSWm9iTDB4SFNxUTdhQWZOT0UrSkk1NjNOWTZVaStT?=
 =?utf-8?B?WkppK2FucmZMbUgzVWlvWmZQVVJXbDN1U2NvSWhXTHU0R2RQK3ExUHh4Q1B1?=
 =?utf-8?B?enhqMkl0OTJzQXhkaTQzc3BWTWRKWEs3M2ZUT0dXVmFSdWtVZDNDZC9TMzh1?=
 =?utf-8?B?bzZJazdkdmxKVEFhM1ZqNGhNL1Ixa3ZGWmdTWDkyY1ErZE53SytpL1NpcXVo?=
 =?utf-8?Q?jwWk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 22:41:57.2163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c4fddd-0475-46e3-8ae8-08de3e86a685
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098
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

Only set an error on the fence if the fence is not
signalled.  We can end up with a warning if the
per queue reset path signals the fence and sets an error
as part of the reset, but fails to recover.

Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 67fde99724bad..7f5d01164897f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -147,7 +147,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
 	}
 
-	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
+	if (dma_fence_get_status(&s_job->s_fence->finished) == 0)
+		dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
 	amdgpu_vm_put_task_info(ti);
 
-- 
2.52.0

