Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38433D5B863
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 18:16:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF6B510E4EF;
	Mon, 15 Dec 2025 18:16:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cd3XOkzs";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010055.outbound.protection.outlook.com
 [52.101.193.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37BDA10E4E2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 18:16:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9Fe0da6UxHJsKtTu5OuQIPz2VtH8Jxs9+fElZRuuu2LvKjjUMNSFKOQTEL4kokoRG75nKxWn7ycfX/N21qotAUJaBrp3lOl0jlwvzifFBY3oLBUyW/5xeupybdPw7g8+D4kaIXTuv68ZmiVX5Kc67SRbqWJ9URXlu7GAo6M5X/ySrbccCaceOgqjXBlvGS2jLYTMPrEwep3sDVYaChxobJC1hgsgTBSLOFdehWbxX6pJIxBPGNd2Q6Da9yoAtT2Ota/diE2lwHTk7Kq9pIP7KI4wB61cn1w/cDiwRfBQdAYCOG4wyq2jbaVqsfZdwEW4l+U+13p5UG9TZ2nwQqNVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4Be4iflKaeetwmmxEKlBwVUmagyU70U8Wa+4p8RDOc=;
 b=npREMnMGB6WTIc1YRL4DR8qrBndM8A2t+qKSlvztt5cf+nLnLkEkbPSMzAykGHpwnSYHGLsta6o42hst/os3zQcbiOCvgbKE2VE+oFvq9MrQGFVJCBhMHtESULABht8tseox2dbEbI4XGe2cSS5WVbx2psZyncrJG5SHLmHCVSCvkerKi97+3W2Oz91mlBJpatF6m/8q/Vu5Z6/lgwyO3tLsLhAAB7c8traI5KwkYR9834hjkQ7ZihnKh+0HMIa7YYXCuAMaDG93B51Axk4SX6BeAlZOWZLKgFoUd97EwqhM1jC3l6IhjYOel5gG5CdTwdZG0UdVWvcQ5u+Vb1R65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4Be4iflKaeetwmmxEKlBwVUmagyU70U8Wa+4p8RDOc=;
 b=Cd3XOkzsEAja8ZuIHomXxiYapkCmENhCpeMll6JMhBmaKOJr7Wk4b/8ewpE1qxxeoYfN33FGoEXsYISqmks7NsYufWX0NW/sWhRaJdXIjGzQGVDtuul4mqGMYMtJarZKJgrvFYBsm4y95CIPd77NC/QQCCA1/6NI7PyIxRJXZXI=
Received: from BL1PR13CA0222.namprd13.prod.outlook.com (2603:10b6:208:2bf::17)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 18:16:37 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::cf) by BL1PR13CA0222.outlook.office365.com
 (2603:10b6:208:2bf::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 18:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 18:16:36 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 12:16:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Switch to gfx_v12_1_get_xccs_per_xcp
Date: Mon, 15 Dec 2025 13:16:05 -0500
Message-ID: <20251215181607.29132-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215181607.29132-1-alexander.deucher@amd.com>
References: <20251215181607.29132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|BY5PR12MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df5198b-be88-4cb0-5840-08de3c0615e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yvm+bYYwdkAURmX4bppT8VY/V0txIRC9XkqEIvixIpPsSUR1oeIN60VpOC0B?=
 =?us-ascii?Q?1zfG9R4Eb6dHkPzzezoYBE6KfmCZWGTcZd0LeKhrmBuZtoFFCS6IIx8DOfff?=
 =?us-ascii?Q?FL4Fo9dqEILmYSY/kAqWYKONSqaM3raLjN30hoWi8qugq2Kvw91LAaZA49+2?=
 =?us-ascii?Q?ObDfEktwc3tQ8ap1t/hz9AIVzPZbYM094Ghy8D+mY/3jw1xxlnIOg4y/W71d?=
 =?us-ascii?Q?JZoxhzVv8QTckZe7b4MBXOYkeP+TUg7+7mxHoc7eJ4+gYQqihiQAEbndgx0V?=
 =?us-ascii?Q?1n81s8xb1kXfmLlcJbc6DpLQJx3gUlLHMApCu6Zuru22e2Al8ftIzLKIKFZD?=
 =?us-ascii?Q?stJJuKUBryUvsPlK1nJ0H9i8zo5Ns/ET5NU0IMc/l6BfVtglu+vdR1ZpTnOZ?=
 =?us-ascii?Q?eZSVx6PGR7SSu6mItyyQHCSlcBZJsLJVPhfgtF1qVZI8PgbdhTPUdI5PxMWp?=
 =?us-ascii?Q?0p9KRp0/yZ1I6mCA9LHe2y8n47fNNPy7T/9Yp+blXIk9tms645Z/frNHnVsh?=
 =?us-ascii?Q?WiOBz2YYdGgkYg+a2+KaRjwsxOD93xQzaDNsKHceuc8JMPcEeCweT81TUWCc?=
 =?us-ascii?Q?Cbo0EZrYekhk+3/fBivAVnH9WyzjTcJcyqRsaPx9r2DKHUc1qowGDb+ZCLBq?=
 =?us-ascii?Q?mRcYrMW37KZ/d1w8j6qooh3jrVZcu60grZq3LO1ZYo2NvpsSWjpQs286xN7o?=
 =?us-ascii?Q?oiGBkS5WtdVQ1sS9VZD9vmpJV/zgzTlqXpfDQ+dbm9aTkVBpzDCuOPh9ih6x?=
 =?us-ascii?Q?UiEwtdDP4LeMT9VPMoih3+HAMZJ8a47KCgYBdKSYi1dc3UC7wOUWamG4z/6Z?=
 =?us-ascii?Q?/4vCglA4NXyTg7EnuV2sqOFA6281wQWTMCFU0RG24Cz81fze95l+efID9UxM?=
 =?us-ascii?Q?Rbaz6dGy6br1iDiSqviuvj/tTJes6WGrHmvroWoWGL8Nqyno2qkO2VJENrPV?=
 =?us-ascii?Q?gh4CaN96VaUJqSAna/6tDZFRK6tDyp//0llo0AYsIz2lsKGqaiOjFUpKqzFf?=
 =?us-ascii?Q?V4qIZ+EVOVUyxxlpaFlcP1SxQLmPOSlbRHxOOmbQ4AxLSp+WlkFtEgNSYVoG?=
 =?us-ascii?Q?mXvXPQ7j7xdiZrdMXRRce1wEzMFraNvfW6OnisFp5FRJhWRq64WzHaU+kgcX?=
 =?us-ascii?Q?5jRr61vXYUkNWrodx/M0JzVwY1sYqT4x+nuR3/AOsxND9uml1z6ykd5R98d4?=
 =?us-ascii?Q?LimkFUIIWGFTlbgfCjV4+P9I/yxbwqt/VYhX07ZM7UKa85rrVnfRnnmS+lS5?=
 =?us-ascii?Q?fj9Xp7FXt7Zy9hG0wPrqK5yo3IConfgEiA2IhRvLUOxjElQ03PrEK6/pAq+h?=
 =?us-ascii?Q?UGL1ly52DUu/FKX5KWgHsgEqETA3KGIL8Q2TciH7GS70dcwLCD7Y1wpOtfZT?=
 =?us-ascii?Q?mJHdfI5gUe/1aqfbdxTdiZqOHMfvtLWq2xmKVlg0QK+31EGtl8ixNCEoK9Oz?=
 =?us-ascii?Q?G+Gvo9cjTQDZEkjp1xB6JuiVyFNJJg/XNew2H9+MevQgka7GrtK+S1lGroj2?=
 =?us-ascii?Q?wlcA8cvCM9MyeNRx6x2e7d9nLVE9zorJTDsaIHNJUTsuOsHAe10d54/Qvo1e?=
 =?us-ascii?Q?qLQET7VPjTTmF0hm+YA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 18:16:36.7371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df5198b-be88-4cb0-5840-08de3c0615e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Use gfx v12_1 callback to query the numbers of xccs
per xcp

v2: add todo (Alex)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 277db5ef9ca74..ae65d70c3d10c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -718,6 +718,12 @@ static int gfx_v12_1_ih_to_xcc_inst(struct amdgpu_device *adev, int ih_node)
 	return -EINVAL;
 }
 
+static int gfx_v12_1_get_xccs_per_xcp(struct amdgpu_device *adev)
+{
+	/* Fill this in when the interface is ready */
+	return 1;
+}
+
 static const struct amdgpu_gfx_funcs gfx_v12_1_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v12_1_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v12_1_xcc_select_se_sh,
@@ -728,6 +734,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_1_gfx_funcs = {
 	.update_perfmon_mgcg = &gfx_v12_1_update_perf_clk,
 	.get_xccs_per_xcp = &gfx_v12_1_get_xccs_per_xcp,
 	.ih_node_to_logical_xcc = &gfx_v12_1_ih_to_xcc_inst,
+	.get_xccs_per_xcp = &gfx_v12_1_get_xccs_per_xcp,
 };
 
 static int gfx_v12_1_gpu_early_init(struct amdgpu_device *adev)
-- 
2.52.0

