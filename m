Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F63BC83F07
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1E9110E636;
	Tue,  1 Jul 2025 18:45:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lzMg3AsQ";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F374410E635
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JK1CV5ucrzNu4YjjMfFr8A3MpRZf+wg3PAv1PS7ea/ZbfMqhWhmxNX9Q3Zm8/FF3qgplS0so25hGeD1Z0v9AWCneh4SOXukCSe5sNiQPFj80g4p7+mEqRDTmlxaSeCla9k6L7DKO82RGRrYSlEqvO3skjLEQj1FVItF2MKIo5l6SvpbOl/omqEH7zmQWUBvOqnLN/Lix8IcRc3jYJKTAXXBzL0jEaMKhKImui5AmPT4il8+skmOcug0gzm0PyDi5hnLMVmo2ZVQamL6i/e7q/OPQmIwQ8QchiehNhh0cPLaMmi36Dp94FpT98XJzeY3WMgZf2k4oJ4oB0/4XZEcdKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46E8nH9sWDvXFo/ZSzwpwdIYcye14AJ8ItNoitZ42MI=;
 b=OArPhYMSjcyiVs6ogfqrjzMDanL9SmwH9W2B8YKsYTnrUePO/qn4E8luNAbP53n2R13zoDniCl0NBharLyADuTroV1foMMLwmkmKupVcllCUsGDIIRFfbYH3r3XOdBPVZcqqSDzO9cEU58JC8/Dwb56R0vhBTLn00+6TRdYbTRfuNJqRxocY0yj03RAkpp+BJfkn4gPdiDsF15suao/uvXd072L+44hBuKDEuU4kvSNRfACXUUWv50K55NgvBkbj1MotDKwuCZVIpZUh376+nzVqMD4cVpvLqJrGZbN2NjdqjjKmKNQnXaZyq8hCkYnep5Qnt2LgjocAiAHw35sDhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46E8nH9sWDvXFo/ZSzwpwdIYcye14AJ8ItNoitZ42MI=;
 b=lzMg3AsQoJxQFoyTqLrT9/H46iU9A97+ys9m71o1dLror55EPynw6avuGL0yPsDBOBR9kUlsEXuKFCssFXcOaorud8ajCUIi21FN1tX/Qo6byBm+2DXDB8O8qqURpSEDztaRGyw05lS/oUmDvvFO6XrFppUyZrQRsoL2xnb0WLE=
Received: from SJ0PR03CA0144.namprd03.prod.outlook.com (2603:10b6:a03:33c::29)
 by SJ5PPF01781787B.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::986) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 1 Jul
 2025 18:45:19 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::81) by SJ0PR03CA0144.outlook.office365.com
 (2603:10b6:a03:33c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.32 via Frontend Transport; Tue,
 1 Jul 2025 18:45:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 22/28] drm/amdgpu/vcn4.0.3: re-emit unprocessed state on ring
 reset
Date: Tue, 1 Jul 2025 14:44:45 -0400
Message-ID: <20250701184451.11868-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701184451.11868-1-alexander.deucher@amd.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|SJ5PPF01781787B:EE_
X-MS-Office365-Filtering-Correlation-Id: 56320a35-cfbc-4b5c-a06f-08ddb8cf6da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nrYd6AoUfZyu4WcQdJ2sUa++h8V75t/2k6W5PEIoVLY0y7rJlSvtvDHuscMP?=
 =?us-ascii?Q?BZVy8WaZjbIJ76My77iX1ArU7CeOMP0qOW8t+6ubLRG7zeV0dAh8ucqrGkEp?=
 =?us-ascii?Q?k34TvTlwLxfP8pyVSnjQDPiITPxAXHewWqjunP8RCxkmA0NnW2YgMFA8w9BX?=
 =?us-ascii?Q?KexGK7BJdxeBfKLXN9Auyh/JazlKjPcn9iv+0zvzsf1HGsQK+XuGxsj7TMK6?=
 =?us-ascii?Q?F1qlLFqUIL52qmq6rd79awhQ9uTB2TdMpP/Jns0dj5GHgvG6AjhLYqRNof2n?=
 =?us-ascii?Q?vmilatxBXa809msAQPfUdX8HcvRjh/hwYE6Ea9itflpPhqhHWvsTeb3fypyd?=
 =?us-ascii?Q?Ot+xu4PTmr4Mu0FnYow27SVIloEKNwqPA39Z2YGq5ElqmcHe2BddNR+r0gXF?=
 =?us-ascii?Q?oLIrXEJQiS8Ra60YFlnQV5qlDVGyH3cdoaAZbzZ03XKhieH/Hbda7dv0Tquy?=
 =?us-ascii?Q?92Zmiqx5s9kEa1gElo7RpUx97xcKRB16G2zGxYmyh0E/qMKc3sAXgcWLt001?=
 =?us-ascii?Q?/GnOZqtlJxHduNHXqaAFHJk5Ay1RRrw2gUtMj98IVI/7AZLjcqUAdMYzVN/g?=
 =?us-ascii?Q?xeIkH2kD7nOFoMY2NigAGPNqR5KfKYaKEyoA4tWkU9WsMqFMjF+9OiiV3SQ/?=
 =?us-ascii?Q?UaNEfg7V2qOjA+KAyYewSNpHAysSrL2WIddz7Fv0pu+2TP2kxTmKKME0LCES?=
 =?us-ascii?Q?1+64qE6PcHMyjmvUBhfiAcxbmUxlzAiEMk1IkDPDd4l4UmsNXFU7ZPwjaDE8?=
 =?us-ascii?Q?2VodoZiMmF4VN3wgWTDMCWDKBEhjtUyXt4C2i33uDk9QZ1Hyj/C8cUq/tDMY?=
 =?us-ascii?Q?q+0DNhuxflbFbx+3hHokmRf7xZMgNyrYcUnJPl0a4BPSB3KItkDeRiNXNj38?=
 =?us-ascii?Q?UOyYXdEN9pjmik0GplMZuzSm3T5gI2MzcxL4oIssHILIOaLxKkcMf0NX1j5r?=
 =?us-ascii?Q?yQ7jd6+q1s4yRnxOzvG8+vDqPHnSZChuJtQi27J4A72lP58+CD2f+StCEXTm?=
 =?us-ascii?Q?nyhQRztp6q4rTib1maTFJK20L1BgEZe7THX6wbiFrD+3ArnftbvO9CXazxHc?=
 =?us-ascii?Q?soEaX3W9hROnIsa7wwvqvS6U06H04ISI3PQjCx9JcR+tO8pqXlTuOd74IYJr?=
 =?us-ascii?Q?1aWmrtsnwQHt1l7wsgYdwdokadIiQOFQQcFskSditVROV9fOcxHPu5MlobFh?=
 =?us-ascii?Q?V98xPFjkTZx7frkT9x2jWPEtVMJzvcD93puqAvXdZN/SKQjhE64xOUgRY13X?=
 =?us-ascii?Q?y66KlAGt5I9rcBLV3qKAZG6ui3XPXPY7KFBDYvwzP61SJnXG2gWmDAYRFBYb?=
 =?us-ascii?Q?HSkIB7tgOecOkA6t6BSMxz+e1yu0xYEUaycM7vz25l7FLXaGirOe91kLRO9e?=
 =?us-ascii?Q?Zjf8z82X1h0zS7uH6eBy3wIiJRAWR/qrHLSk5gP0V/sD9SgJPigB471320am?=
 =?us-ascii?Q?eXgugy54YOJmI8W8Mn3UYNOxz8jgGzUxdbqKJ468Xt/S8kuwFHIb6BuqYGdP?=
 =?us-ascii?Q?K0nB8CcA503MK4OMBRpbieA/L0A6PgVO/C58?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:19.2577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56320a35-cfbc-4b5c-a06f-08ddb8cf6da7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF01781787B
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

Re-emit the unprocessed state after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index d8fd32c1e38ec..3bda19b92cde7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1609,7 +1609,7 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	vcn_inst = GET_INST(VCN, ring->me);
 	r = amdgpu_dpm_reset_vcn(adev, 1 << vcn_inst);
@@ -1624,12 +1624,8 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 		adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
 	vcn_v4_0_3_hw_init_inst(vinst);
 	vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
-- 
2.50.0

