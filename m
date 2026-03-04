Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A19EFCE4C
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 22:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C470510EACB;
	Wed,  4 Mar 2026 22:27:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nk/mqS62";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012050.outbound.protection.outlook.com
 [40.93.195.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E03BC10EACB
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 22:27:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8CpaX+68j1i4Y/f6WGUuFWkn2fSOyK2zOwY9JUswWr9Udw5/FmSWBVcZXlS9C9ZC8T1GfhcrUaQbmkH8du1kb+wa0MZf8cdKH7wrY4wV8dvCp3pnfbuAmw3uwZiRBKGhT6LdfjbtAS1l3hXNbRvLpjhrXRS9NhL7A7uEIu26jghLEfq8SHo4DquvjWeWg+vcHMhXUzgSTDDoWeKF6RDrlYzcmURgnv3nz/uNRWQI1pMLQLov3xzXdKs5SRcMZoC7FJ319mTvTNh/Cp/J3QG3oR9CKzottNex1Qag/d4JnRwad88E8XTyemQQVRQVcKUFM3dufdJhfUtTmRob7ReHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l42/xfQpV7ExoS3WHVZMCrhIjmuS0q1O/+8XzNoG2+I=;
 b=NoqVyCpzWCZfm6mBsH747wlD6hvaTIOetjtjsJ8LmWL/8aLRorUUFggVaIeTdnt7efvIRPwUI61kDdXCxmC4YtoEFYSMxzTSJLCV5J0xODX5UMvTUSBrRSdszMgZ8zy8cVSTjrVEpjumdKr+GmD3BYSA7bN4ih6gLDjfqbLPP74Bem4a0Xt6DqDAc4QuW4SuSxofZWRJ84x/yaIK5wP4hARdZsltPPKprf0mnc7E0Fwt6IOC6pGYgywnzGqdkB/p01tN02xRAWxJiuq4M6bNWFC+Lo/Lgq2igzGDGkk0QRvAFNlQLtojh+Xz7uDe55+Ngr9mssFyQ04JPogWavA5Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l42/xfQpV7ExoS3WHVZMCrhIjmuS0q1O/+8XzNoG2+I=;
 b=Nk/mqS62clbzf0/qE2SpY465S2E12WRJ3k6gdOFhcaFaJiMob2gc3CmdO0geb22Fogu8p/Ylc7Qq0uYLroFjIMfprIulQOSJ4DrULlRN99CLR9P4CDgoxW1Pn7nP9tlOwZ/7NPspTUVMADjtvMKGtodaZc232ZW31AT7DG2su+E=
Received: from CH0PR03CA0341.namprd03.prod.outlook.com (2603:10b6:610:11a::18)
 by BL3PR12MB6548.namprd12.prod.outlook.com (2603:10b6:208:38f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 22:27:46 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::2e) by CH0PR03CA0341.outlook.office365.com
 (2603:10b6:610:11a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Wed,
 4 Mar 2026 22:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 22:27:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 4 Mar
 2026 16:27:45 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Mar
 2026 16:27:45 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 4 Mar 2026 16:27:45 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/7] drm/amdgpu/mmhub4.1.0: add bounds checking for cid
Date: Wed, 4 Mar 2026 17:27:31 -0500
Message-ID: <20260304222732.2403409-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304222732.2403409-1-alexander.deucher@amd.com>
References: <20260304222732.2403409-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|BL3PR12MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 03846cf7-84b9-4138-9cc4-08de7a3d42bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026; 
X-Microsoft-Antispam-Message-Info: TwNEsw6kmWJEZPUMU2oC1NDRQ9XE3bhNMwYW1SPQidKT5gienpsnG0PKP18urgUmzhcM9Xr3Owq9rR8PYuhGB+/rmguX8GgfmcJsKakpiKUqe0UF+fwym2npYGaX8fGNP0qk+CHHtTjV/NkchAANPYTqt3btTXnzJe5IUBvwLS1W/+dZRvVlwZojsqswPZcLjQu+5Ng0RTFrJwP9Ow9gHtfDFvI9A4VBZmPTz/cxFxgZgKNt7EnBOTcuP1llaHFbmxtYYB6b039qxdw3P0LSiQ9+aRD1lknm4pSRNssZftQ6phRicHyqvzXU81q/qahCkkQSnWNVWWjn+/ir5s5YdGp1an8ECadogh9VozgrbpCzrsxxe0sM80JSR0N+Tow7klBXlDH3wm/S33NFLlTEE189c2uA0R+dN0sOzYy16+O4qkS1YWyaXWaFKLx5yWLoJXMLALbp6wmDFLmPJGd3u0NHSUWMdVAXw3os6B+eP8JHFVfJ6/JB2QDvXnvGO3Otdc5wDM7bdyh1Trdxt2f7ZRD9SLnpqtEH4UjwLPQzB+G1wL9trCEkHMRVgyQbzRcxasPeY1uECXjMJn1hYZqBLbHwHQ3VB8LecobRhrwflIPyuGQeWZL7IZZk/e8DxlDS4mJVvoUitOSHk0CMLk59Dt6Ldxv6ajHEzdp7GdcOy5quXBry3qgSvPYR5C0nraa5SAVxzDhvzPZDEPht+UDtC2Wm7mvlJhxPZuy91/zBu9ti0Y4Uijf4ARkkR9DnnBardJoBOp2fSmD/3QZwgG0L1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MJus7oXse8Xgr2fci0rgC04JqjqsZCGe9pfYxE6z8wRS6FrcQ433UoXnFXdSWQ1q7I6BZMuyqZ6Vf/RhYxjehmudFcMrP6wFhYG8rCEMi5dfNkS9Qc1a8ZPiqWL5CKov0tnSGjXj+YG3qmmw2cH9UcOoPJyUfX6OlWtF9v9ZGe4xAkN8XnPrt2wxVjQpFi4UTAyRrYTs6e2oeCrY3EfjFatPDbcRQRu1/UyJSBm+4boYAXSblzr6gdHTgQ/IyM/U8wLa2jtSINrMD7fPCzVcJX8idsleGsEFsZ//i8oAhUFzOEM840dndJzHdRMqOudE+vsCwjHHSwEFajQif8atoGf3lGBDKL261fY3YVD3NRiCknWLD/qDhROltCjJFmYLT9Dzj1ZjMezCYgHDOWeAOswpqgFb93fwDAHoD5kkYRA8M92Br2qA3LcX4B3Zn28d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 22:27:46.3963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03846cf7-84b9-4138-9cc4-08de7a3d42bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6548
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

The value should never exceed the array size as those
are the only values the hardware is expected to return,
but add checks anyway.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
index 951998454b257..88bfe321f83aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
@@ -102,7 +102,8 @@ mmhub_v4_1_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 		status);
 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
 	case IP_VERSION(4, 1, 0):
-		mmhub_cid = mmhub_client_ids_v4_1_0[cid][rw];
+		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_v4_1_0) ?
+			mmhub_client_ids_v4_1_0[cid][rw] : NULL;
 		break;
 	default:
 		mmhub_cid = NULL;
-- 
2.53.0

