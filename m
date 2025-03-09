Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F106CC28B2F
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Mar 2025 16:32:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5A9910E164;
	Sun,  9 Mar 2025 16:32:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aw//ZxGy";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7154610E277
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Mar 2025 16:32:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8JqNiX53XvUJ6WoA+BP4Mbky9d+tHwjdSB0vNU7t7O4YLZhf0UjP3mfQbVeu3ZgJqkI//PWFfN0Z52NpPTlRCRaa9P6Dquhp7/q+lEa6vaYmt0BtAluJgGunMtTMWyFnqNJPNHUsNiBI/OWPcCjrCYn8rKP/hIhEYnhxD8VjJ83B2UxTYE4t+ffF7ry0AJC2c0h3B4oACT/LUOSPY3NQ9Mya98a5WT+4Fj4w8RiR3YZmJAE5k/wGes4hwobjalpYZGFxrtQUCr9cnyD+DVmX+q4TRLv67G4qgD3x/4WncJIJB1SeobBYEWg0QRxowVSDkjkRXXbRR6EGa32AjgBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jk67m63XJjVK5+b37HvVjh6rn6sjGv43C+JcNBSdydY=;
 b=ytydsjv8WjTnX4oq9/E/aLqvEXVS9ME1jWmX4BE6q+5+/cOVgNZGMXGjU2+vE3To+RQZKTZS1T/G8iT/NPrz2wM6fdFohT80o2T0KUw7Ae62Jz1boyV9ncDXUDlL3f2K+maNcs4BDKZNqwFZIMoZlmEauGIAKJPf66auepEkgNxTq/lh4T7LnM7xrNqWr1pW03ljsaI5m/Al1C2compXXm5JeubWQm5MppKFpo8QOljp/roqDNNKc+6bk/jsInxZJikDjFKtOL1UJdooCmGMn2/IUWtEIhskZJaZJCh1HsCBgUYwUF/xe092FdBqeOe20T1AA2FXhOhSQSmpVwiFPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jk67m63XJjVK5+b37HvVjh6rn6sjGv43C+JcNBSdydY=;
 b=aw//ZxGybPKT0hERmQZp/vtUZNue8K2w3vr3nuJ7cBTuIPF/dVgAPYiLm6czYgkIUqISSlcUZVAgRZXa9I/7r8/3F3A9B8quHUt5d28gKqJg12pCAZyX1Wr3N7KdSCDPYNmEg7kUVnZUxnIYyvc2ec6mu56t1D1vXGLVyzdNgJc=
Received: from BY5PR17CA0036.namprd17.prod.outlook.com (2603:10b6:a03:1b8::49)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 16:32:08 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::e6) by BY5PR17CA0036.outlook.office365.com
 (2603:10b6:a03:1b8::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Sun,
 9 Mar 2025 16:32:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Sun, 9 Mar 2025 16:32:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 9 Mar
 2025 11:32:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu/vce2: fix ip block reference
Date: Sun, 9 Mar 2025 12:31:47 -0400
Message-ID: <20250309163147.2271337-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: def2f0ea-4782-49c2-0354-08dd5f27ee7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ae1dXhhNlJTW5cc9YNNtwJrnBJ8DtdHFCJtsFz2o5gB1DqoJopLCFzUIWyyj?=
 =?us-ascii?Q?bt6pcEw/q4wQ4EKnZqoODCCyxpHARP0/e2ErlTV9xXgCIFBT8ARUmMHUgcWn?=
 =?us-ascii?Q?AwLa7n0FU1nMpGrdRDGHUQvsr0pZtWgB3qmv31ZuoxA2M4KLX8MczD+rPyn8?=
 =?us-ascii?Q?C892h5ZF9N62/RuJI/o79p7rGDh55dntC/DcvpMxRx+jpN2B0I7LNTgFmtkd?=
 =?us-ascii?Q?OY80cYcjlNmrUDQIJyJpbI/Nv3DGN3n6oYMBQOlNUtP7zsH4tyk4d8XytwxH?=
 =?us-ascii?Q?s/wIF1FbATSePu8g8MvzVnMI1EHIXelKiu3IH6+4gwwQelZrqvYPWSbYYInN?=
 =?us-ascii?Q?QXuPzd4jiJzz0d8avvObwy998KGwXK0xoQ1A0UR7F5DyAKCJDemEyDlJMc60?=
 =?us-ascii?Q?VcZTHstIrWObkLEIKZAT38YLJUJGiA0gDECF6z76+v0RAoR+b9BG7vIh3CyE?=
 =?us-ascii?Q?KTrlYJ7hvu4WIJMjBzrp3EL2Vr4pP7S8+5IXrNt+LyIMzmouQO77o+ZXbPSj?=
 =?us-ascii?Q?wsO94+cYZdD8p+soBg1G21RZbFhqNzpbiWkmQGb/lFFg0bC+EAbBt4nymVXI?=
 =?us-ascii?Q?L3LvkDArpDN8vTCF+kXRn6qrnRumqV7xskXXrfWCs5/7TL/BRm3ofBwLBhmh?=
 =?us-ascii?Q?Z73UvCGEIF7CtjPRAQ24dAlkg1GhvXcW2sB/IclbqfuVWXwNt9lNWL3XOpS0?=
 =?us-ascii?Q?UYxYtm6ciRtqKwn6dpIbOey2jj6CKketQKI4MuHeox2WFIaVdckKzt8bJWgl?=
 =?us-ascii?Q?8lbqUYeon81DBxdBqTc6yeTnRBDQmInaHTA6vfne3B4lMCK8p+ddpk8DplLN?=
 =?us-ascii?Q?NlFkWE6Xuyssfl5p8e6ZINBv7ebhGuYJMPlNMgO45fMy3ONbgzYx7r6wcOsH?=
 =?us-ascii?Q?xiKe1Q+D9zUz6sI3ExStiYN6/PJppBIvvATi0c/a2qSRFvqyF0vFtVQRmwCj?=
 =?us-ascii?Q?U+Uwqqw7XYQUV41GnCTvYpu/Q0ppFF8SOk6C/w0szVcszY/NoUwAP4hVvc/N?=
 =?us-ascii?Q?IADp5PRR7ZWmzSbErPRPDauvlNbZdEx19/oMCifT8lZ1V5wPOo0cerI6y/Zz?=
 =?us-ascii?Q?Zg6CSu1hipKg2qfB80dMr3MX2g9R+ap68fMr3wKRf088W8fBPzp0QgQuVsyN?=
 =?us-ascii?Q?Ypc8xwgfg9AIIZFXnAPcMK3GHfoDKVM8IhJ1K5aCPHHUIb6g285RPGUe7EzC?=
 =?us-ascii?Q?LnRlkrYWp5+aFRsCrPgc3iieDx3k1CxaJKkpCHpacGM2WjAUkBDxBuWCu9cA?=
 =?us-ascii?Q?1CKhF1VK+n4Vutwgn+W73s7doU41n0DDs8krR4TnE2+xTObzqyRJSk2/c9h/?=
 =?us-ascii?Q?SmirI1ByMyHMdBQbBOFFeQYmqVKcPsoswZ8xWCD+RBHtkwIx4pNLPtoB8CTG?=
 =?us-ascii?Q?A2nLFNLc5aBBlXVQL9uv2MGNtAJg5VpB/e3xegtKbhLSVGledxuFD2dP+d4m?=
 =?us-ascii?Q?dZHhM7AxAGU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2025 16:32:06.4358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: def2f0ea-4782-49c2-0354-08dd5f27ee7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407
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

Need to use the correct IP block type.  VCE vs VCN.
Fixes mclk issues on Hawaii.

Suggested by selendym.

Fixes: 82ae6619a450a ("drm/amdgpu: update the handle ptr in wait_for_idle")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3997
Cc: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index 8c8c02606d25a..bee3e904a6bc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -284,7 +284,7 @@ static int vce_v2_0_stop(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCN);
+	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCE);
 	if (!ip_block)
 		return -EINVAL;
 
-- 
2.48.1

