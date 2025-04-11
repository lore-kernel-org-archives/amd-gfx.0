Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607EFC369A2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 17:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D610510EC46;
	Fri, 11 Apr 2025 17:40:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r5rtHRGh";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BF1210EC5D
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 17:40:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jjy6m/oeT6xA5PqvK1my4N1c2umdNUbQHUi2DqKLunm5BB0Omlk5vdNRASOCRp3mOCOGX76zsb7NTPRs51NMiniQtHn0+wGBDq0mvVw8671ozM1p3ZRLdasTEJCzBktoX7hXug2rkIhSIKq8CYHF5DyC4kY0xYmYoANZ15fVBw1yxkKrQucaQ/1hUYpsJDKjIv81G4G3ZjtgR3JTJxNd8V9vnpig7Ztvck7R+ZjIFpJ1qmoaX4xtK1GnpfxFwZKiTNzU2XhIEti9UUOOKgJH4FuGYfYMp2BtIJJKreZlqpuxYbPw/VuYqkT6QTSMoNILf27mDXN9xCV9ozWGyClFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2oxGvF+4vIDBRQL8D63I0igXq9athberrNMXiULfRM=;
 b=CWXhZylPfqwW/506pGAbICCW4bFWxSNcEXjCc/aq6BWrEZyvTLrSrxefOEhg/DkqAuv7IhBKNCjW1p3ThMujRWNYQtXyibK5JpqLsQZzVp6zPIH+hFzaPM82voOql6WNrBvXYAHo1ekpHSd3PA+JT0ZBIEwtvGSCrYPe8/ZmaHVvYu8ydxaYQIfKSSkcJNumVVOL6IeKixprx110HVdDUPRwmtX4MtD/Y0qrqJxzHQpha7PIJ25RlA39v8dfHii0ogHi2H180OktgwJClSrgn756Qu9hVwNGBHP60Lgdpa09dGv94onforG6RFNQat71zQkdzjph4bttjZpHiyiYMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2oxGvF+4vIDBRQL8D63I0igXq9athberrNMXiULfRM=;
 b=r5rtHRGhJCiA+vCG1aDt22uYbya2JN7dpd+RC9WI7kmU9vBknLVFEnVoFdbzAR23ZDKJpaNManVmwJOJwySnvDxmRiutQILw5I7Qbe9du/HqZeBiKdwNSM5iUW1vKXntNREgVAkEXcsMTFRAaZ/zMLSaNh2nv5VXdX5ZRrTfzqo=
Received: from PH7P220CA0085.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::26)
 by DS7PR12MB6072.namprd12.prod.outlook.com (2603:10b6:8:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 17:40:09 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::66) by PH7P220CA0085.outlook.office365.com
 (2603:10b6:510:32c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.25 via Frontend Transport; Fri,
 11 Apr 2025 17:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 17:40:09 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Apr 2025 12:40:06 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: Enhance Cleaner Shader Handling in GFX
 v9.0 Architecture v2
Date: Fri, 11 Apr 2025 23:09:42 +0530
Message-ID: <20250411173942.3324241-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250411173942.3324241-1-srinivasan.shanmugam@amd.com>
References: <20250411173942.3324241-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|DS7PR12MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 66086724-1403-4143-e364-08dd791fe797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zmh2U290T25wYi8xeFFFRTRxVDVmRkxIWUxnMmhrNkxxTVQwWXl4b1Y5cXlo?=
 =?utf-8?B?cVdiaTMwRGg3ZjU5RzFLcklpWU9MMzNTdG16bTMvbUJCTVBEcUp6SUd6NER6?=
 =?utf-8?B?WVV1RHlRRENic3JPdklhUVRyOGRSQ3RORWIzZkhzbHJFdTB1cWswRXAxS0lJ?=
 =?utf-8?B?T2c5bTJJcmRMeHh1R2FNSEY5cjdKSDh2L3hIU1F0VFRrQStOeFVRRHRxYlda?=
 =?utf-8?B?eFRYUy95aHB4eTFhbUo2NHYrUXFuQk9ocm1kOWZ1K0R0Szk2L0ROanNDZnFl?=
 =?utf-8?B?blkxazdXYVJtVFViNjFzZWhkdGtlUGdwMjNrU2U0bnZybjhxUC9aOHFZb0NG?=
 =?utf-8?B?K0t2cHVldklYc3dXc1pKTkZaMmtiQzlpYUFyS0RYVFhkTTcrOWU5TEhrSW93?=
 =?utf-8?B?QmVzVXhIblVjdUFnSzVXakFMMk9MdnYyRjdpTUl0aU02ZVV5bU9kM2JyRmhZ?=
 =?utf-8?B?VVFyeDR5N0lINytNZG0wenRYTnF4c29CdTJ0ZGI1ejJVMkZUbzJNTTdHSjZ4?=
 =?utf-8?B?Ri8zbno0M0ZPeXhEMTEwQ1ZlRGZROUpZaXpKNVhxYmZ1ZVkwYThSWGV0eEw1?=
 =?utf-8?B?ckxPeFczVEZlQ3pDT1dlcFFRbzlrS3ZCZ2dCVU03U1pKbE40UDhZNXg5M0U3?=
 =?utf-8?B?TGo3NFVTOU9BUER4UnorMmNFUjRlL0pHWEtCeE9DWmRnNHUwVXlkZVVSbXNR?=
 =?utf-8?B?QzJZN1c4K2xmbGcyNDA0Ukd5Y1lZWjRxUk5LMk9HWlE1RzNMZnRiUmZSOE5W?=
 =?utf-8?B?VVdmbEt0UUpMalVrMTNOUmk2aEF0VG8yUUs5RzNIWStneG5TVldRTGlOa0xk?=
 =?utf-8?B?MXl0TWgyako5dWJQcGUrOGd1Q1VldHJTNHNQUW9NT29tUkswclZlVFFWVGtz?=
 =?utf-8?B?WVJhOHRJeXdic3dQd2gzQ3l3enFBdWY5S2tYV1Z5cWh0OXB3d2xkY0RidXdQ?=
 =?utf-8?B?VE5EcFcvVTRVbnFKOVhkdGllUVd5ZW50RVFBeFJVK2lzaXc3WWp6UG5hOE9v?=
 =?utf-8?B?QXJ3aDBoc3cvOEtlKzhHVU9ORjYxSExEenNrZ204c2VhN2hocytIdkpVaUF6?=
 =?utf-8?B?K0dhNThjZUpJRU8yakhySk95UmxaRndBTXIwZkRCYlRLUXA1cU1WclVkT0V6?=
 =?utf-8?B?Ykd4SG9FRnJkSlR1YmNIVi8vWWtISXVEVDNFYTRtYVh6VlBFWWN0aGFhL21o?=
 =?utf-8?B?YVFjbi9zMmlTL0hyZllQSG8yb1dDRzcrYXF2ZlNMNkFvNEY4czlkNTVCZ2kx?=
 =?utf-8?B?SmcvbEx5cDVrQ3cxcFk1eVM4SmpHOWZiKzBVMEhNYzkrcjJRZ2twNlR1Y0hL?=
 =?utf-8?B?b0kvaFdxWGhJWmtIZyttMDJRVlhHYTMyQnZ0TVI1TkFNamN4OE1mUXBxZWly?=
 =?utf-8?B?eStxNXQ5K2tRaW8ybTJtU3IwM05idHZHQ3M3ZGFabnJ2SXcwNmxoVG1ZVXh3?=
 =?utf-8?B?ODBJNjh6enZBWUFWVjZCTmdIVlNHRmZXdjR1ZUtJOWxtWXhxQm5ITE9tZGty?=
 =?utf-8?B?S2JMRHhVY0x4VVhyeklCL2lDemtTSTR0OWZzR2FIVUZnTmd5dW9ocUFIenRT?=
 =?utf-8?B?aDlxc1JoRnY4cklqUExHTGJjZnBYeHM5dTM1OVZ0OW5qcElINnBzbTlySTRB?=
 =?utf-8?B?UHhtcm92bThZVWJlaVdWV2FCYkdjazZWQzVxN2RFUThnY2VaWEI2dEQ5eDZC?=
 =?utf-8?B?V1RKeDQwdjF0eTcvWi9PUDl5RXZhM25WUWZrcXlMQmFaWkhCWXMzbjNob3Fv?=
 =?utf-8?B?SHlqZHJhRjVJbW9STGlsV1BFclpaZFUyc1J6bW5BQUEwbElNMmIwZG01Smlk?=
 =?utf-8?B?ZVVIVWluR05zTnI3SUgvVnlLZjN1VURhbGJkWHB4VmdzdnZkM1c3MThSTWhz?=
 =?utf-8?B?U0MwalZmNmVScm1HbC9uQ05JQlJkTlRXaTgyTW5LQ0ZCY2RzZ0J1VjkzZ2Mw?=
 =?utf-8?B?dk5wVjIrNkYyamZUb2llaEh6N1NMbEQ3WVY4am9LVWlUeVN0K1pBakxFZkJY?=
 =?utf-8?B?L1NuRGl6enJZLzZCTzcrZDdKQmJVRTd2OTRGRWdsOVRnWDhlS3JCMStKbXp4?=
 =?utf-8?Q?iYGcvA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 17:40:09.2291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66086724-1403-4143-e364-08dd791fe797
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6072
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

This commit modifies the gfx_v9_0_ring_emit_cleaner_shader function
to use a switch statement for cleaner shader emission based on the
specific GFX IP version.

The function now distinguishes between different IP versions, using
PACKET3_RUN_CLEANER_SHADER_9_0 for the versions 9.0.1, 9.1.0,
9.2.1, 9.2.2, 9.3.0, and 9.4.0, while retaining
PACKET3_RUN_CLEANER_SHADER for version 9.4.2.

v2: Simplify logic (Alex).

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e62c77b3934a..a63ba6642b18 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7387,8 +7387,14 @@ static void gfx_v9_ip_dump(struct amdgpu_ip_block *ip_block)
 
 static void gfx_v9_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
+
 	/* Emit the cleaner shader */
-	amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADER, 0));
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
+		amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADER, 0));
+	else
+		amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADER_9_0, 0));
+
 	amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zero */
 }
 
-- 
2.34.1

