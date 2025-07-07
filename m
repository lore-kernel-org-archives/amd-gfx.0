Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5805C83F12
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EF1110E529;
	Mon,  7 Jul 2025 19:04:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rD8Rps9O";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8043110E528
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bifMgD1ancyMMqasIMaSKaMAtQVU/4bbt61VcdwFBLv2PDcPZpI2WViCeU0WRmk0pSwXm7gJvTUFcCr8uRIiqvsmY8vCHNzRw6zxFVpXp+mSs5IgsaRp9/J5CWvPnLZv0Yitg+pyFNiTkdA2EPJWfjMThkwZmK8+sWSGaZpXfW3ozDGBOIH/T/I5X58SDJ8sA2r1gI+dDdcgYLwvfMP5ZCPk7gyn2zZNkI8uMMlwLakxeovYUBs/enHELnxkF513rgcMIcg9r6479YXx4urenvS4af1u60zY/5g1Vi3wsO4NYarh7r2iptFXURQC6k83Wt/5dHptwRRA5ZS/0Y14SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHFXO6wZuVU90QEY6vDeWKNZHfrJNhMGYagO72kQNoo=;
 b=HAncZDxqv+RLWacX6odTJfzSJBj/Gk6Q0VHPKVuy2bxTFTiBV2v3YNaDcQeI86olV9pbGbqOV4w7HhPuId3aaBCRQpcIM57hY35YVDC8mwrLDkhRGTSfQPRSJpd3PRJgpbFhUcIWhw+ZxI725yoFT+w7IaDrCeNywDkVpdmH25Xa+pFoqK/FKmeUSoX2nFABvS9R6AlZPw6jY3V8ssn3y/zH/uqesb/V26E2KLARXdzS18sKHOPZtW0TNqCuXV/oOSYCrKvUQUJ3BXB572km/XgnGh4Sfu5tu+YbHDrXP71n56i1XI+rxPqJJS9nzrNEG9lCXVfLtQmRP7zC4W8VdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHFXO6wZuVU90QEY6vDeWKNZHfrJNhMGYagO72kQNoo=;
 b=rD8Rps9OwsWH5OpD64+vDBHnSZhROPrJ23NkhIMVrApCSiNMtpgWiJriLF083zT9wr5iAEbui2qt4WtLW3MMm67pDvHubiLGFKzH7jZRZ9kxgaln9A6IxfYL2mU2EBkKuwCOcBqhZeNfrupsz9f7K706hzzY+taE5MdCdX45dSs=
Received: from PH8PR07CA0044.namprd07.prod.outlook.com (2603:10b6:510:2cf::12)
 by BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Mon, 7 Jul
 2025 19:04:18 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::65) by PH8PR07CA0044.outlook.office365.com
 (2603:10b6:510:2cf::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 10/36] drm/amdgpu/vcn5: add additional ring reset error
 checking
Date: Mon, 7 Jul 2025 15:03:29 -0400
Message-ID: <20250707190355.837891-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|BL1PR12MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: e88d8be1-c550-41b8-a03d-08ddbd89127b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y0RPmnz9/c5Z4qgetpeA6hJ/OWheffsY2+mxpvjeY43UBNw5WQ5s7HzVpB7p?=
 =?us-ascii?Q?dOkhkqWyiFZFAuc0Iz39soBsY+yqXistrSPYUjX+enbZG2PQ3vWu4Lv/W8um?=
 =?us-ascii?Q?nj5/sN1jfUj7RPziG0fvtWMIHmqPCaeIBCAAmLljScBuFN9qKHIPFg2EnLH7?=
 =?us-ascii?Q?5bQAqzpTMgPOJMqfANJOcUYoPP0bRXgOEs4AnYstXP9WsCYsT6NVUjzUvoev?=
 =?us-ascii?Q?J/URf+rMpr2/4njwzpNfzyVcpIOL1qclXgEGlzC25d6485ZafZZXTM4WnFFm?=
 =?us-ascii?Q?39o5hLpoiYqp/fOoLMkZKqICYyYWVit3QR8pOuEI1gqmjMfFgvhTxEMSbLP+?=
 =?us-ascii?Q?1wPBBcfbVL10Qzlv+aBfo33fxvFIQZcjwXVZ9sAbtb9mDn3s+NO+yWEVwbk5?=
 =?us-ascii?Q?vc8ggQuuNCwzft0RUS7tIRcOl8FKy5WDtOo9OztYZPnkiG7d0/i8CeiJ7eTG?=
 =?us-ascii?Q?+idOM4Hb08nzH7nft9jZtFtjY+Qul01+o9xclLxeIuSHLIO/BsMAR4cOKSXw?=
 =?us-ascii?Q?1NR0wHXvxNeQU8cZQ+VRqvNMK0FMRCsMHYBceWaoVzcosydjnG1uhO24+vSu?=
 =?us-ascii?Q?4YxvSlFBuAVTwazjiVSKExl76QVezs1g56Y6ri1BR+jOgkrpDmV8r9C7Epz9?=
 =?us-ascii?Q?TaXIN7uHAchi8GZuLAypB38Kw09WjXzNvpwcvEOJ9YpyhvPsNKwtEkFVNBXj?=
 =?us-ascii?Q?nZ9fJNZh9q41mMO/2zwauWNn2JTBWiJOWxTkX+oZPDSqEQjqjgpIBVSGEyMk?=
 =?us-ascii?Q?tHFLilAa3pS/ttBW4vZXhc3LxJfFC9kG+0ov4dwIuRLlAWgzBPlpFOfj3vIr?=
 =?us-ascii?Q?5f5Ijkib8nDiULRx7cILezmoVIpwF6nxeGz7bgHFBqRsxuUuDXTSQ/DN6xTX?=
 =?us-ascii?Q?MfwRqCGzJU2NOC1hMHxt6S8UjbfYTv1lcw+0XoOTFOJxVoVzwRW446r8XKnm?=
 =?us-ascii?Q?w7UIkJCNE50tu1/iRv/0se2zFv95UmtwnEAARzUqsJpTn01HhACuLTZCn+I2?=
 =?us-ascii?Q?91WhYPPMKwWIVOu5oMgO8i0Op9wVSzm4Pt1PagwezDlhHM0QJP3b9+OuIYjK?=
 =?us-ascii?Q?X0XeMaveuf46+j/RMXyktR4ozJQqL5nffGwT2EBUi568MBE4Reppt0AY3jOP?=
 =?us-ascii?Q?8euRdt4q1yWbkMDeYqWUcxXyEXgZfblTo+7VvUeI/KDjAEyQI52zjXYp+JNj?=
 =?us-ascii?Q?SqidRnjVGUqzhQ716TVYoNDp1eITlDLrD5ZostAr+NPdG9rbovCMOqGS4M9a?=
 =?us-ascii?Q?FnGVcIXxRLJHBB0L4RPiEcRg7/Ml8yXb9apQbBTwFC8MrOrcyWcxez5+s+Gt?=
 =?us-ascii?Q?VjRaD+9SGjuBVAYYqFjGPIfpPQW0BdkICXbk/2xHzEKapQ0KWax1VVQcurcG?=
 =?us-ascii?Q?om1XaBwdTTqA7S74BUt6lZ/gYPao?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:17.3872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e88d8be1-c550-41b8-a03d-08ddbd89127b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971
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

Start and stop can fail, so add checks.

Fixes: b54695dae995 ("drm/amd: Add per-ring reset for vcn v5.0.0 use")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 47c0bcc9e7d80..3d3b4254bd729 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1204,8 +1204,12 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 		return -EOPNOTSUPP;
 
 	drm_sched_wqueue_stop(&ring->sched);
-	vcn_v5_0_0_stop(vinst);
-	vcn_v5_0_0_start(vinst);
+	r = vcn_v5_0_0_stop(vinst);
+	if (r)
+		return r;
+	r = vcn_v5_0_0_start(vinst);
+	if (r)
+		return r;
 
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
-- 
2.50.0

