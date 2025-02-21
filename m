Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB3DC021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:02:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98F3810EAE9;
	Fri, 21 Feb 2025 16:02:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EhCxl4EW";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8746110EAE9
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:02:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MzK+wzT1YZZX9hnytEcFymADHqjjmRP9dyTPDOogFWa1GABh+UrqRjlX1P6cuoD/tJojqWQioH8HGxSX/L6CFEaijgcnvDG62KXEC+XrzF1GnoLtZCS8VJrDZGosIU5i4wXRsiW/b2AnkeXT9tuvixEE0Ks9Em3RK7nBbXijxF/ZE4WCOZso8qS91SrNI3bEUpR09hZ8Useki77AjPL/or+TV/Yp4SOcuoEnJdJ5rkuptoRM+gsYFEZuHgXzBHvoxe/MK9t7A3TCPcvCJpi45OZLsjF8JJ/UU3GRujL802075CGppW/XxYtvINIkO1gm5xnDObhJ6nqqbu/nksLbEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNww3H8gQg9huoGTt2sXgFrcz4MGQ7QYuLGdA2H3yxs=;
 b=cBEu0eL93ePa4THlOIGCX94B7key9rSoANjRO/ToQ4XpQtO7F7AKn6xv31nBCAa+JoEZ7iMIoVrEZu4W531jBoUfa95kUyxU1+bjCpCzgZkfwQ0nQkTtWS1OYrws3qdylHzy0CYu+mLBqNcIsc30jUURSdibQ5ubJVerHV9BewVbU744mI+1pDHqx9Nqq2b6LIHBjq9fRVrvl0AIvqSri1HQdy4gKRS08BohHV1eCnCMVntVOq4yZN8yB1ktMphDC2CVQAeUUJyPk8W74wbrWvvmqzm53CMyWEzGcbErguYFnvDHtqCjyDskWMR27HbCNc9vE9+YAgSHJ8mCV08IPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNww3H8gQg9huoGTt2sXgFrcz4MGQ7QYuLGdA2H3yxs=;
 b=EhCxl4EWHfD0zGM9MMrgghc9I2NHSTnEcaqhnuPBfQYseBxUWgosvg9jLhwE56Ger0jYgrS22pV1JOy0nZNc2lOfbyqcLoPXZhFEHBg4t377t24DFEWjYxkBhiBKwtsqYuLLE5EW3V7P4ZnG3de9kL/rKailPTCPf+lSp/8qnjU=
Received: from PH7PR17CA0060.namprd17.prod.outlook.com (2603:10b6:510:325::24)
 by SA3PR12MB8437.namprd12.prod.outlook.com (2603:10b6:806:2f5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 21 Feb
 2025 16:02:30 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::e8) by PH7PR17CA0060.outlook.office365.com
 (2603:10b6:510:325::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 16:02:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 16:02:30 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 10:02:20 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 15/24] drm/amd/display: Temporarily disable hostvm on DCN31
Date: Fri, 21 Feb 2025 11:01:36 -0500
Message-ID: <20250221160145.1730752-16-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
References: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SA3PR12MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: e9eab627-c832-4761-6c3c-08dd5291254a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ecO2aTIfHsx8krzd8ecPy/f7nN4Gq+e1ZQMIHZIfHOtzTf/7BZcF9kATMGxb?=
 =?us-ascii?Q?qYCwD7kk36A2IQRgYOXF8lZw6o1VYPmlUGEONB9B8oXLHMjoMSmOrXDfTy0p?=
 =?us-ascii?Q?km4qB5koE8nf+JWwqAKUmzkxdEB7lWW3SDt+u225qVVcCCQFpuAc//qhI3eb?=
 =?us-ascii?Q?z53aRiPZgGOw3OA7Rzv/zO3+BS0bw9PXW8mHK21cCsQelsa3B5GFvynGKiSH?=
 =?us-ascii?Q?ng4/aaRWSqBWnld39Z98PasXpnygWQmi+WtKWvfBbLKpqBUlWwIs/4h2Nhv1?=
 =?us-ascii?Q?kQ1tF93L18OOMJeLJRbec9Dmn8CKALkNLo84kPbbcR9WfTj4kExqOhzEJNxR?=
 =?us-ascii?Q?zxmg7jRzGVGT1Lbl4KOLB6Wm4ggi9hZxcLu9nk29rTNU87/myObHCzRQmGKm?=
 =?us-ascii?Q?wd7P3LLdizg4vcueLsJu12WcGFThgIBHIhvUgOuEqet2CzMpIFfNThJ1NhiS?=
 =?us-ascii?Q?R77D01nVp3PW3x+FVqiqh9cE0b4pO5u37qEdL4HEtSvLeQ4q99uMbx+5xsnk?=
 =?us-ascii?Q?A2rboSLcQfnVKRWL/S5Vc+cwmr4lgThNiQEqp6feXr0DUrXtd0uVEoJT38c5?=
 =?us-ascii?Q?1IOsc4F+f8OJLAM6qGBENsx0YXR/6aVh2MxALWCyEW07nDJY0w4X0s5OVK4/?=
 =?us-ascii?Q?Fokk9sKQRS/mZBJslbyhxhf3YyJkXgMzCRfXF00+uMBMak1TzInBdNRdAFrQ?=
 =?us-ascii?Q?MHIvG9zGqm9rUIrE70KiTdf4hIKgfcG+mMri+Hb6vQWavyar0FP5L3CNUZUn?=
 =?us-ascii?Q?OowvJgFfO9cHA5psXcjiIS1h/UoRKiK/FptMikL0R06mZYqfOIZEHyOpJ4/k?=
 =?us-ascii?Q?Ge2NUdirn+YBnz7OtNNi6j/hY30htbAO1WHcbbX0ydtQxV4CfDwE7WNRK4wB?=
 =?us-ascii?Q?wJYRTYgQDTI1/DvkIzzAHO7tuWZsRcWBQyxi6O5abXpELXqe1ixrOXGyunnq?=
 =?us-ascii?Q?xyrb/D3jV5N209TkEEyHModF7jZra3IBTAVw3xTCkMeO3yAc6y3m2dxnPner?=
 =?us-ascii?Q?wM52kf3tDJP5IAfkhOESADeCJH5Lr7q6xV/idFSJyVMqpKEWGNmAHMZuCO/p?=
 =?us-ascii?Q?lLT3Zjsuis3UfYxSq1FZgp8pgL6HooeTWJTjGpQ+Rj2v1fScQEJCm+J98MFD?=
 =?us-ascii?Q?+GbiQ8U4h+CD2O8rgu3LNCq29gsdn6KidmPvDtfwhbIB/g0npRpOpx9CfKi+?=
 =?us-ascii?Q?hsqdXLJnNlRK+ohLVVIcl6XjmtzCMs0YiCRMgCGmNibtx+6fVTI/QTed9GLV?=
 =?us-ascii?Q?mJ+NYXxYNKwwkxR93Kskjku2r7+U3kU5xlqhLX3VWNQIeccaF74AKBHxbUU8?=
 =?us-ascii?Q?RCUg6s2O5AUK4Ipf+eVC7ZBcAsSAyj2i26yNIAIDzomN+OE9igPyHuG0jHp+?=
 =?us-ascii?Q?Q+6YSWkqY8Vrju7DbGus447qWrAXwG/hjLQFgNOreNdjNawvQFs1OIKPekni?=
 =?us-ascii?Q?YPe63L20QkOs06CJGEwBhP2r2mN4JfoBCGyV8c3ACNRCN4IzmTTgnzejVJUf?=
 =?us-ascii?Q?EWOZIb1LDHq+yVg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:02:30.4285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9eab627-c832-4761-6c3c-08dd5291254a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8437
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

With HostVM enabled, DCN31 fails to pass validation for 3x4k60. Some Linux
userspace does not downgrade one of the monitors to 4k30, and the result
is that the monitor does not light up. Disable it until the bandwidth
calculation failure is resolved.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 911bd60d4fbc..3c42ba8566cf 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -890,7 +890,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = true,
 	.enable_legacy_fast_update = true,
 	.enable_z9_disable_interface = true, /* Allow support for the PMFW interface for disable Z9*/
-	.dml_hostvm_override = DML_HOSTVM_NO_OVERRIDE,
+	.dml_hostvm_override = DML_HOSTVM_OVERRIDE_FALSE,
 	.using_dml2 = false,
 };
 
-- 
2.34.1

