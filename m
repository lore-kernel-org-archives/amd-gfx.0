Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A8CC021B8
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 16:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AB9D10E63B;
	Tue,  4 Mar 2025 16:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lArmAQAK";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DD2F10E63B
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 16:19:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDuyAOMspcc+IWKq1wvAGOpupd+5lrCJKZQkQocd345MqUGs+Ln7xuMYBDP79FHG2WYTiaNtNH1bHf0UcBoHNHccEEfXnyjn2pXWYcEyDo/7D/pzRDjqT/XDWVaWKQo/HDjAFYtaU7W0n4qLMuyH0BVLbLohnpP7A+NVyumz5n97eIrhTkJNgf+FwET6Yk2tUZ9qUV8f2rp0yXHazm3+7o6KUWaB4ilG3+srY+JDcsu2TPXV6EeEH1Ka5t/yIJ33Emi54Ep36/ClX32w04JSiVdRPQTLgu6kFZAq7nvVxhoG1Y6CXLLPM6jls0WxSesUfv5xd5GUa3421wFnysS4+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzdTTyMw3zW5nBokClfRTseW5oKhd0WTrjKKDxGwSSQ=;
 b=bdidAoM0XUXgxFMu/RQ0ei+uaV0Kg0rfQ7YPwuk/pWbpXLsF7KOPTBQM4awfA5CGmUJiqQHVgmERdZtT9DaHFfcDLxzkQzI51f9IsxtX7buxDr4rWHtvUcaoo/U2qzcTiAIuDwaHKk28YvlawiC31St8BrExlZQk+skceEhHWLUsvr6LB+nJWBxDs34st00FdocXFiG1mFgDYrpQSgYR9Nvz1nruQhJ/HjW43I3dnPabjlGL/ub0JDroFpB+qrJVH0CQQJlyloZERpNooyXm8BYGdYga6IbCsACKSxpTtOeqQSINn43e9ouygTnt9atSr0BFDvFtbl/o6C4S1deNWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzdTTyMw3zW5nBokClfRTseW5oKhd0WTrjKKDxGwSSQ=;
 b=lArmAQAKptM/8WSrwwkq0Gdv3vv84SGzNs0fi40egelKzrY9U0af4JE1tfwJIL6L2J8yv/3TsP1KWVV66Q4n7uX3Fqp1gZpqtFaMQ4x0s6RojF0jTYziKlCa+JT+qhQjXu4DWzbMSiO7noyYnF8RmQhrrswQeaw2YDebKyTct9I=
Received: from SJ2PR07CA0002.namprd07.prod.outlook.com (2603:10b6:a03:505::25)
 by BN5PR12MB9464.namprd12.prod.outlook.com (2603:10b6:408:2ab::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 16:19:46 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::1f) by SJ2PR07CA0002.outlook.office365.com
 (2603:10b6:a03:505::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Tue,
 4 Mar 2025 16:19:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 16:19:46 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 10:19:44 -0600
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <horace.chen@amd.com>, Victor Lu <victorchengchi.lu@amd.com>
Subject: [PATCH v2 3/3] drm/amdgpu: Do not set power brake sequence for
 Aldebaran SRIOV
Date: Tue, 4 Mar 2025 11:19:30 -0500
Message-ID: <20250304161930.6268-3-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304161930.6268-1-victorchengchi.lu@amd.com>
References: <20250304161930.6268-1-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|BN5PR12MB9464:EE_
X-MS-Office365-Filtering-Correlation-Id: b82a0189-091b-44e0-7d1d-08dd5b386129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oNCXv4KPrtUjF3S2J4VSEvAXbPSbfb3uNjwhAnFxz+Ep60NUVBVtK0pEZHSy?=
 =?us-ascii?Q?CRIeQrAw4zJA+dzCKDUvvT5VoJDEo8CRX4cZ8EMrjdE8RHuK9EcLkALANp66?=
 =?us-ascii?Q?mhXoPvZcZXfzPhl7Ghk+9sJnd8wHHFF8JXg1tI7gn8Y8VefXWRKsQzzEdIhZ?=
 =?us-ascii?Q?Hn6d2Bezc7EONET3XgrmlpIwhOfUEUcvxM5WRVMnZMuvbVGpmMUbxKRU1hHH?=
 =?us-ascii?Q?+mbPM0d9ueXTpVgOVqJl72zZCEqNthdPFd0Dj0Q7ht8Xr5qgmNdRJlDsKlOa?=
 =?us-ascii?Q?qFsRafsgQVGHLR14IfmL6Vba6BM71b76CaJKomAfCPwj/Uv0TqFSxBSgTpX6?=
 =?us-ascii?Q?FH4EOOF0wBGg3tKJL5eQOQryNaMdxUAwae6WAiUz92T99odEYmGC2N3pPo0I?=
 =?us-ascii?Q?FyuraQ74J91u4EpkxPTODKOkc/lcQfoM1MNYUoMzQCcOaF6LfI5olg+Do17A?=
 =?us-ascii?Q?6XaMgRxF0rMWss/BIgyONOTAH9KKfT2ma7+NgKyqayrJ16a2xuxx7nFGlFdz?=
 =?us-ascii?Q?L0WkTZU3dMI8HufwIjRK/6zaxmyw6fZ//r8rlN1Kzv47i9Nu22MyIROlQdVV?=
 =?us-ascii?Q?wWlkQi2uWwnpGJ6cbMtsof7HkPxxOwPCDnNIqCUhT3eoDpolf8NFbOMzl8w+?=
 =?us-ascii?Q?EcMoo5Z18lDecEySNPwQgfnFIKVtVYH1xzsANP51ZuMRBVtbFPGxmlKRn3u4?=
 =?us-ascii?Q?xGDALaGsBUcswTJWQQUt+gd5LVMOxgvDAq+Qnazm50R4J3X+aGQhrjDa42Lt?=
 =?us-ascii?Q?w4BnuetemsH2MwsTY9d0mlArmeY9XxtMiiqKdCq4VzpcMca6yeBK4EU/TsBS?=
 =?us-ascii?Q?DqgQzX5dslqsbeEfmwD26gHV3xDWJwmL4qxHEYnPAy6OrwiJl1Ys/tTaiAp0?=
 =?us-ascii?Q?HEUlPC0GEU5yfg9AuKRcmlSG5YoRYK5dklcgI+BRBpK25l+7Tds3FGuVFstj?=
 =?us-ascii?Q?lQkkLZ+gNVnZnb14oR+z4kO8o074NgQltKwQuR1bPeBwX35WwOY4+Tfa6j+f?=
 =?us-ascii?Q?6mgIVfLol9ggrI9Qpb1L+TG+iYusRmECZW841uoxQAcDa5QRs0UL8kaqWbRX?=
 =?us-ascii?Q?A4ifPTlJXNnH3i4K/DDx2SqRImZ5Swr3ndZ23oDtpPUb3U8QnkLTqNPuuWL8?=
 =?us-ascii?Q?f8M0vX1t360r1atZsg3EfWovisdtMocKUIWQRqNI2/W2zJW85pnoiVJA/RCv?=
 =?us-ascii?Q?I74NCMSzR5jbJkLP74EMkOOy5qKxXEOteXJJsRmwEag0oH73jQ2Ws5ChFiG8?=
 =?us-ascii?Q?12YpkYPZEgKOrtBQrCJqICyxdjHZI3ppjO79RuVXdfAcqh8zZpf/FiEjz6SD?=
 =?us-ascii?Q?nhCwXylZXsd/ZklXK3gpbmCBiFMztcmvtwdCTPtr67ewJvtX/qjRUpCSQApo?=
 =?us-ascii?Q?W4NbQAnP2nC/ytkHTfdctHH0sJbEZHq6gNaW+3ouYWvtWUISVfR64YSt/Tu0?=
 =?us-ascii?Q?M9K3q3mV2S8cqyh3Dib0NAH1b9tii7TkplrhKza+hSs4vplVM3go1kJzuejy?=
 =?us-ascii?Q?3skPDvv2NHWlV2k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:19:46.1321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b82a0189-091b-44e0-7d1d-08dd5b386129
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9464
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

Aldebaran SRIOV VF cannot access the power brake feature regs.
The accesses can be skipped to avoid a dmesg warning.

v2: Remove redundant asic type check

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 1f0f03108a82..d345285ea885 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4045,7 +4045,8 @@ static int gfx_v9_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2))
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 2) &&
+	    !amdgpu_sriov_vf(adev))
 		gfx_v9_4_2_set_power_brake_sequence(adev);
 
 	return r;
-- 
2.34.1

