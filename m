Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8A0C83F27
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 07:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88B0D10E607;
	Tue, 22 Jul 2025 07:46:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XLo32F34";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E509E10E607
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 07:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUR5uNqqrmyvbrBgVPAk8YQFBgFg7dtrRttpkkcYX8Xwfxs3kx+hwOOzVYhy4mgySLIT3ynbDheyQyLo5RcDEV0C1XoC39+ma3ZAcX+3vUzWRTkj98/+mBeiI06roQjnmSKktwpDxZAymX0kAgsGHYmkFrKwE/jTjAzvAZ6JzajeEd638W+EX4SiznwX/l0vBWk5HG17TRtf/uXO38OY2C7QBW/Le6p5evgaF0J7UolXHnIaC6qRKnZ5BcBy3kPakg5rnsUZSXnmykq56tOE8rmeb+5x4nHIYIXmY7/VfuAOU2ny2ggK5BwzQLv6gn8Tmg4Ly4eNishMKkyCvCwmiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1fk7IvWDpjA4DYQ4bAb8CBPHtlxFvXxgh/8ppQqu/o=;
 b=ouXQBLQFZikyl1NaS/cNpww5zcaBv26IXX35fLctvk/T7FYmagoRI4BGXt1H1PDCe9L2xUN1xpznL5hFn+J27qjJiibBT5buori8RIR0cg8o15lM1jf4BX75raaQIWjVt3XJw0LEQnnBr9jo9FG05nYi82/74lm6uyOgbJVxfX7fSkyv3NWEHRP2qexgMSD9nK4tprPwyDgWCZW9bScReBQImVPKLCVGSl01Xc2UVcRscj7uuMoaCN9YRhcoU764u14sTYrDEmF50DUzLmucZP00vgENCmkIcrPdCXitHSsIgxrPPO/q6qZY/UzvB16mIBwafpDLX+8Z2epz3xBxwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1fk7IvWDpjA4DYQ4bAb8CBPHtlxFvXxgh/8ppQqu/o=;
 b=XLo32F34DTOTP6hjIVnJ5cxF+rrKz6GdrfyCGyKliY/XIR41qmWcQjAanVyceRgOvUuD+JoyPe5Ymoiuh0UqzNJaV+jXwxMGcxcgBm3aN4l1jx2CQh6+hskdVF9RfqPcu7MvVpKuFlgY25BeTc79HNWlUzCdSL1TEx8vUHJZlGU=
Received: from BN9PR03CA0767.namprd03.prod.outlook.com (2603:10b6:408:13a::22)
 by SJ2PR12MB7917.namprd12.prod.outlook.com (2603:10b6:a03:4c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 07:46:42 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:13a:cafe::ec) by BN9PR03CA0767.outlook.office365.com
 (2603:10b6:408:13a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Tue,
 22 Jul 2025 07:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 07:46:41 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 02:46:39 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v7 03/14] drm/amdgpu: add UAPI for user queue query status
Date: Tue, 22 Jul 2025 15:46:12 +0800
Message-ID: <20250722074623.1464666-3-Prike.Liang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|SJ2PR12MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: f2e0efab-c0fc-4477-a57e-08ddc8f3e5d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUJIelBleGNBY01ualB4ZEI1NGtqMkNsM2J4bTcrQmJENFhyMjF2eTZBdTZy?=
 =?utf-8?B?dXF3b3JQTGRIOHVMZmorekx2UTUwbTNrdUZKUnJvL2FKdmFlR280cTc3RlV1?=
 =?utf-8?B?a0sycWRLZ3owOWRaTXpIVXNST0poTiswNkxMaE55TUJ3dE1GcVkwOWgxQ0xr?=
 =?utf-8?B?WHIwRjJiYzBidkl1blRraTBwczJNd1YwU1paQzJReG05UWczZFZrRkVIVFFZ?=
 =?utf-8?B?VUNlUlBoeHVBWm5BQmI5d1JPMUk1cEtleUd2VUVGeVdLTWhLMUh1RFMvWWEv?=
 =?utf-8?B?WXlpZXpVUXBVWE1uc0ZsTzgyRVZxcXRvdWFCYVNkZDFUN3ZkVllXNVJBb05z?=
 =?utf-8?B?N25OZ0dJMjA3djlneStUNGpxa2g0YW1qeHJOeVpWdmFERTNYeU1KdjR5UlZI?=
 =?utf-8?B?YzBZVEcvTjZ4WVZKdGZNSTFwOG1RU1J2WWYrWEcyVzkrT09QQnB2Qmo4ZUFx?=
 =?utf-8?B?SWtwTmpneFB1VU9aVGp6dnZ1WlF3TjBxVzBTWE5uSG02YStTR0FoM1lDckdK?=
 =?utf-8?B?UHd1bXppUkl1eXZBMXJxQTFYMkFseHBCM2VDbFVJQkRtOGZsbVJSSkpQSjM1?=
 =?utf-8?B?aUw3WjkvUjVYRkZzL1JuK3lhQXArU1U2MzhwL1N3MnVjcTNZak5USjU1dkJL?=
 =?utf-8?B?ZjF4cmkxUjllUm13V2tjL0pqWnJjMkdWUU5oWVpqQldPUkx0SW1MSUhZemJ2?=
 =?utf-8?B?YW5YbzY2YzVUM0gwV2FUSHNJQkVhWU1xakExc1dKK08yTzJ5bkVVVUYwbFdj?=
 =?utf-8?B?blNaVDVWc1JScXpSMzkwUFZyYTNUUWdwWFp6b2krWTZmWnRpbUVSVTZKNXFD?=
 =?utf-8?B?ZWRRZDFURGdOcnFQQ0s4TTc3bmdpeFpxN3pzTEIra0x5UUNNSGE4SUNiN1Vk?=
 =?utf-8?B?d0QzVEpKdGkwbHZsQ2hSV2pJOWZ6eXdQZ3R4NUNiblh0MUhDZkgwM0M2dU80?=
 =?utf-8?B?Tm5YVUVhdzZPOWVHNExjOGhicjUyYWJjdFNWb05JalFIa3MzQk1MWEowd3Av?=
 =?utf-8?B?MUhMUmFhMjJyWTM1U0dtSDZZY0hJSEVaalRvbGJyQ0xvVXBOcmFscENFNTA0?=
 =?utf-8?B?cXpUaVdxb2kwYXBORlRtQTZ6NzNEZS9oVFpLTkFZWHBPRFJZN2xGeFcraXJV?=
 =?utf-8?B?cElyK2xzcS84WHFwUXBiK2xVV1JjcjN6cFdtai9PWmpESTNod2orNEN5Z1lP?=
 =?utf-8?B?NVJnMVNUNnBEdW51MTU2ZU5oNHNNUGtZeWZKVTA1UXZJUGtiK1Rzc2dxTEV1?=
 =?utf-8?B?a1JxZ2ptUG8wck1Vbnl6RHNpeldXTU1WS0RzQ0VqZ0VoSllxR2NSZUUwOUFV?=
 =?utf-8?B?Y1UyUDZia1U2dEs1dm9kM3RGaldJdVBKQzBCQkREemlHUWFkYWlhb0l6RjBY?=
 =?utf-8?B?ekxKNmUxMUI5N1FuQno4UGR5aFVtb29VcmFUdnJmKzVCNVEvaTQ2bDZNa2Ji?=
 =?utf-8?B?U0YzWVBDU1ZOdlVnYXNSWGtzYU9yTFNpRU1zYWtGRlVuR3FGZVpSL2UvMFNZ?=
 =?utf-8?B?TjMzTGlQK0FBSnhlUGdCWUNHdEtpWHpsbXJNa2pURFQza1VpZ29vUzFiVXl1?=
 =?utf-8?B?UGxtbndOVnhMSUVmSkdDSzB3YVZ3WU8rbFBWREh3dVQ3QVArZ0hOYytTU25Y?=
 =?utf-8?B?VHk5R041RFFQNlBhd2hoOTZQMU1henZpU1pnN0ZKMDRxQ2hvYkVFZW5SbWxO?=
 =?utf-8?B?UWROUW1DTEdhS1ZCT0VWNHR4V0Y4aHk1TUV1cW9hbTd1Yy9pMjh5eisxQWNP?=
 =?utf-8?B?TXh5R1lkZS9XVTZ5TWJBWHdvMW1sa1NrUGdqSTNBWEV2QkUzRVhiYzRMdVVt?=
 =?utf-8?B?OFp6MklPZlpwc3dzK2FiZ1FkS3V4dWhqVW1zQmlROS85YWF2dkp5OWJweTZm?=
 =?utf-8?B?Q0dXWkI2TnUwL0ZGeGMyS2lyNDdCa0xpZXdUSnpDYlhDRWU1YkIySGk0YnFm?=
 =?utf-8?B?QUZ1VWdWbkxOS09ENDN1VnhoMXlNcDd5Zk1hNUlyU0EvSi9YQ3BjR3MybnJp?=
 =?utf-8?B?ZGM1dlJqTUJLeTVBOWtocS9KNGM2WTRjSFRpc2swMTJ6UXlYcDZSZmUxWnZB?=
 =?utf-8?Q?rG2y9s?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 07:46:41.4454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e0efab-c0fc-4477-a57e-08ddc8f3e5d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7917
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
---
 include/uapi/drm/amdgpu_drm.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 66c4a03ac9f9..efd0d2356077 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -328,6 +328,7 @@ union drm_amdgpu_ctx {
 /* user queue IOCTL operations */
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
+#define AMDGPU_USERQ_OP_QUERY_STATUS	3
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -340,6 +341,12 @@ union drm_amdgpu_ctx {
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
@@ -421,9 +428,16 @@ struct drm_amdgpu_userq_out {
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

