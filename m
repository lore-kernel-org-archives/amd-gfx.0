Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22BCC27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AEBB10EAF4;
	Thu,  6 Jun 2024 21:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SDAtItqf";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B8E010EAF1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcuM4OkJdu1zdZswFnL9CSgcROgxlLbT5s/ovmoCVE8zzlc/naNjqNIrhRDzqWexgP9P7spyHqj+DHnRDSM14hmio1yWp2Ri/099yPfuWxFK64Qwg/YI4r4siJL9F8Q6nOW455XnzmvSjP9jKb9cA8Ae0Fy4T37p7ciwVUD4JwUWUKIIya5sTJhxZFCbRERwEEwUb4EV8UrR51obz4BgikmP6DGjt06zdj1+rBdf7zCoOhIZoFTyN+3+Kc3UKv7cUIcWlGBL4uPATAJHNScjzZThKZdAkb7+4fW9RAoq/8Bwz5GpysMFykGX4MpgZzrXzsUTVpbC9C2gp1C0M942pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hCkhT3WHCX37j3Zm1xPcP2QIxJ+ytfC6olV5Up8kWs=;
 b=i0sM7ujkVFIsSCvVreIdGWBaV837va4iamgR8F3HfXQYw3mqM9puGTsqz0LfUCoKT55frUuHopF7GEiDvXUgOT+gpjZlHCci8eQtDjJudhCCArNcIUtDoKH1qMQFX7/rMfkjeJfFSsSuLucUTAv0z5t7ASPAqS1vFWRZ1aFhEMKR39CF8WDhW5Mkdvtpqq6ERNVM9JnngJyVCzpsmEGVJ1Vji4KYdKvnLGyrlkoZKy7i9YY5a18pBJmpKZkfJhR/H8Vdl8DIUW/p3fFlo/B3DjUI9thcvgFzrdO9zJuSx0PZFK0Ruqqbg/djkgRg+rmdOQ2epOH+FGjNGeplI/LeyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hCkhT3WHCX37j3Zm1xPcP2QIxJ+ytfC6olV5Up8kWs=;
 b=SDAtItqfs0Py+w2aNauKpxNFv3QDgXq93puhFhx/8ORK9fm/yj72DHC+867w0sL6h9m29Ziqfh5kreathxLTCqonLhOoVE5uYbW4QGaDrLxjUeqCKNPDd1NZ/lrYk5KjL/VjgW35v+c5GthGLcH3ppw3dixA69AlcUilA1lM1PU=
Received: from MN2PR20CA0014.namprd20.prod.outlook.com (2603:10b6:208:e8::27)
 by CYXPR12MB9338.namprd12.prod.outlook.com (2603:10b6:930:e5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:57:57 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::e) by MN2PR20CA0014.outlook.office365.com
 (2603:10b6:208:e8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:57 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:56 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Duncan Ma <duncan.ma@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 42/67] drm/amd/display: Remove register from DCN35 DMCUB
 diagnostic collection
Date: Thu, 6 Jun 2024 17:56:07 -0400
Message-ID: <20240606215632.4061204-43-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|CYXPR12MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a8a7a7-6214-4d07-e1e5-08dc8673b9a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cT+eMOM9P+TcppOUsWNCJCdTE96eod4lBjkpAjdXw3tz1+cL/Wy1vAN3EQB8?=
 =?us-ascii?Q?NFj1I1G/kc5Pw6dXNmRYUB5WhUZqSVZ8Mk5SAls73upSnQ94wuRvyDxXm2F4?=
 =?us-ascii?Q?MJXHBYPqJpmocLbfZwGH4GzT6WJovU9JWTwOzfcgJmyeRh0xzeFnZW5M8Bb7?=
 =?us-ascii?Q?7TE+hPz6d48d4rx/ORuPC1Log045gsNW6n6N7WYfXOP8UM3a2/ei+XubAOFo?=
 =?us-ascii?Q?yhJXz3N2une07oJPugwCEylKym0JAIaalCjeC4vUVAm4DmTw29k9f62fQVFy?=
 =?us-ascii?Q?3/jnLlUjwm/WeUqSO1IoW7npwyfv/uKys3GZY/YsgbeqD35DZJhY+qOyKa2y?=
 =?us-ascii?Q?+D2d4QERcTYn/EtXjV2oMgc/mJxDdyhBwxrV8UcfmxydmRpSFF94jRAFHVL0?=
 =?us-ascii?Q?O6BrNyOiWt9M17KhIoK4t9kTJkB5TvjbVX5CadIa27iBYYxg3jTP05trj6f7?=
 =?us-ascii?Q?jwKk2gCwQL4ZKWV3Z+IxqAXWPVYeXOzd7RpVOVi8Ra4ji4D5+WpPx9DRpYC3?=
 =?us-ascii?Q?l1fp9QCDpqx1EqjFgUK/wEf044Sz4HKO2gbtXmICNwn16pJ9WJJAmXiudaIg?=
 =?us-ascii?Q?iUJB9f0/m2FqV9heQcZRwEH96Ri+Sj+b2yOjVk7L0hJ+CrkYt7aWF77c99Y7?=
 =?us-ascii?Q?P23YWeD5va0xWFFDdXfHO8f6URDwIXb2QkOO+FJFuL+EO5TpCiAegTy0oHHq?=
 =?us-ascii?Q?20OoN+SHvVa079ylL9LcNz3+I765ox4L+7WqYRfePxjxEnq6rS6YzCNHEOsh?=
 =?us-ascii?Q?JpKWLtHPkVtvtLlg1JkrFlZTf0zMV/RDbyIPlolW6ccj94vN3kOnoTXawXDi?=
 =?us-ascii?Q?Z/u8dJF43re6oLOrTYRLsqtMBzvw2Vqn5NJXHnfALEcfxdmSDPeW+mYSi/zF?=
 =?us-ascii?Q?XaN1O/SL78LU2+RGTRW4LtYXn8kVSKn8AKuDrg7YjxqGDS1jU/VRa8uUuTPB?=
 =?us-ascii?Q?OHKCm+tWV/E5Acx4qHN2Ss6AQxPl7RWmF0nWB34M9trEqvkIncdY06jTpKJ+?=
 =?us-ascii?Q?+CtThRIz3NAP2NGWHz8z9qEcZRsE02Eror0DQqTntEEGcUDxOOeI74zSUZYk?=
 =?us-ascii?Q?S1SXoLeKcPWeThVftwGWhABR4TryhIH3P484JLO+ds/yRb/Vwo6IhUptKuC3?=
 =?us-ascii?Q?kaGFHNbZbCJfOO20UvPwjh56PoKavSQ6eOjNMsqEjmpy5RDTm4aKgQhhGjdi?=
 =?us-ascii?Q?yj5erpUpyMc0+FCfqTHCxwsP6oW2QzOHK7HmIwllZK0OvmNzoagPIMvTN9IZ?=
 =?us-ascii?Q?1JtOG2GrVjgK6xt6dxs6PaoMpH2FbBFuWvq7QCCoQ5twbfatdQC6imdreUN/?=
 =?us-ascii?Q?kcfy/FlaAivVA9+us66GizycQAqPKh5HRI6Czv/UhDREjchkLWa6/DIWLDnW?=
 =?us-ascii?Q?rGkpwbZoVCHdgiMtLsJd2nVsCbENksQ5M/OQ2GEdIt3sl7QhuQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:57.3422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a8a7a7-6214-4d07-e1e5-08dc8673b9a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9338
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
These registers should not be read from driver and triggering the
security violation when DMCUB work times out and diagnostics are
collected blocks Z8 entry.

[How]
Remove the register read from DCN35.

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index 7f53074f4e48..80da117356c0 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -462,7 +462,7 @@ uint32_t dmub_dcn35_get_current_time(struct dmub_srv *dmub)
 void dmub_dcn35_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnostic_data *diag_data)
 {
 	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset;
-	uint32_t is_traceport_enabled, is_cw0_enabled, is_cw6_enabled;
+	uint32_t is_traceport_enabled, is_cw6_enabled;
 
 	if (!dmub || !diag_data)
 		return;
@@ -513,9 +513,6 @@ void dmub_dcn35_get_diagnostic_data(struct dmub_srv *dmub, struct dmub_diagnosti
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
 	diag_data->is_traceport_en  = is_traceport_enabled;
 
-	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
-	diag_data->is_cw0_enabled = is_cw0_enabled;
-
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
 	diag_data->is_cw6_enabled = is_cw6_enabled;
 
-- 
2.34.1

