Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0111BC27C51
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BED1C10E696;
	Fri, 31 May 2024 16:53:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UAJSn9v/";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5762A10E50A
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rbn2GqVNLaXmmkL3LyVsJEGaTmZy9t4DNuquUwk6sDrWRIUtfPEazNV1f44/O2vo8ZUeRyTFsJ/5UWFRyqGCHYhKURAS4isYmkIoF9a0BCSnbM6cSKH9yzT67zV9MqEgwdktb8zyEJh2tsjMEPLQd/VDdiVAReFiOnXRMAcUlhyHMhoDs0zzOLj8j6ctVsNOpIt2FmLsiB3f2A3Ixb0lcKytZtgMCp5h+9UOMl9MQyVsLKIetUopxgtoELDgJOPBk9vDQ+poW9qYgOty7LX/byldWZ/tYBTa9DWryj3RSIEOWeZRN/ej90SPRS0B1sImz8rwbS0k5Dm5rXTzEtYfXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7u8IFB9sI0oLKe5NrUMLJYAnzjyWpkumogTqMALEadM=;
 b=KAEiBx+NKgt74fph5i0IC0RizWHKUDAs3jkMBg5eMTtRgSDfm1ODDxYbp/lQICJMEq2wK6MdlwN2khYWAEFGADX6nt6UfQocnosh7VszZCHvUn94Z35t9dbQnMzXoBtPHVkc7N62k0sAy9pmqdlqRPDYmbnRIHkloFz6Zwnb6D9cxJ4JmaTiBxBPXXH+fqQcqgIpOUoYBkLWxAPYFO8Ir3fHt9CruBP6/YxXpEl+LXFfunG/Yw6RZVFwfwvI3BR2dA9vP5jhy3J7B8HnRXNtTQeINXVfWVy0fv/VmQbTA1zWCpIT2j4J6Mrh9VLo/erAhjHQB3thdgkC70EoALP4vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7u8IFB9sI0oLKe5NrUMLJYAnzjyWpkumogTqMALEadM=;
 b=UAJSn9v/fn4t5wVqfdcKnRD+zBU+6jwMzG8M30Mx0hzeMuINb4G0BRt5ZLZiaIrDZJue64X0Rk8EJ1Vsk5gZbpzlj9eAldu+Ck+qY8p9R6lvQ/ptnSda7mqwLwhxw0zEO7MIi8TToLiGfGmzkVu05pRxPF5G5J04+uPNKsfrjZU=
Received: from PH7PR10CA0012.namprd10.prod.outlook.com (2603:10b6:510:23d::26)
 by CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 16:52:45 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::f3) by PH7PR10CA0012.outlook.office365.com
 (2603:10b6:510:23d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24 via Frontend
 Transport; Fri, 31 May 2024 16:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:45 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:44 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Chiawen Huang <chiawen.huang@amd.com>, Duncan Ma
 <duncan.ma@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 24/32] drm/amd/display: add set ips disable
Date: Fri, 31 May 2024 12:51:37 -0400
Message-ID: <20240531165145.1874966-25-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|CY8PR12MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: c746228e-829b-491d-07c5-08dc81921858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZlY3hSqyhwDwJLXbi4DB+aLGUtgJJAByKzGiDs8Yz/7vqhtboVXMy9RPbh2A?=
 =?us-ascii?Q?e8zs0J1kaACXEha8fIS5tkJok/e6pTDz1G2yzqKm7JyMJdP36L9aBzzvvqQk?=
 =?us-ascii?Q?+5vizwaxW7l6ITCdT2oZX7hqT/Zn607j7tQJtBSSnRiW8xOxmfudzOw0QmzX?=
 =?us-ascii?Q?VyDkVabMzSKfU2X7UVJt3X1bjci25Qfegj8VMimJYdRANC7Lua43pF12h2sk?=
 =?us-ascii?Q?XAhCrsmA45C8hP+FrtJYYaALk9RyKavI0B3Z8Mnec3vlrwIggmX3TdMiw7gA?=
 =?us-ascii?Q?DbzPjYdnNSHsuYJayO5P6lH11i4DqFbpIfSkgZphgt6DL/tfqDz57EZ0T/O5?=
 =?us-ascii?Q?xb0n1ncEXj9lig4JzET7/120rokhWkXMnNJRQUaE1Z6wYrwmhJCyqw8RnqjX?=
 =?us-ascii?Q?uNUI4xXg8Gji6o+Jn9RLqdlUJHUSZwplifbCJOCbjBIVBUPF9EXtMsTBqZvc?=
 =?us-ascii?Q?rPYrYnHrbWQKEUz79wIbY6F1S8cCtc9O4R58YZ+T7OcXJ1Js3oSuMWn6hhKA?=
 =?us-ascii?Q?rXjr0obOjFDPjhkAJ92NRBr8p6zSFBy7PDWu2c/nobP+DoojF6qh53orkMpI?=
 =?us-ascii?Q?66SH5wULc3AeL0H9s1XuyiXGK21Wl5T60d+5N8kyMf1xKR3oXLOyGOgyZ/FJ?=
 =?us-ascii?Q?kWw8J6L4upgx4EzvDptqahCRn2CBQhuCvwbI+D4ITGlRmdl4UxbTYhuZ+fv8?=
 =?us-ascii?Q?jhO1lp7ZhwQ0aIr/ekTTVOKUk1Ftp2Dk80n8Ri0gFbkwsXPuf9eym0QUK2XP?=
 =?us-ascii?Q?1ybtOSOJ1NgWHaczi2aY7Lxiiboo48CZxZVvW6ixgfE2TYdCNQj2NhDzrO34?=
 =?us-ascii?Q?Binf1mf/BOV08JBhVy5Tg2UsANZwpQjMDZO0GlBA6MBfFk80UL4JCLZhcT9M?=
 =?us-ascii?Q?L1fX1X2XT4gMw4TEiVtgI25rJEDlcXECFgNN5KJvG0JBnu9EkVJHHddd9wU8?=
 =?us-ascii?Q?7chK0/ef9/XSCkrHlx/9vjYMAMv48C8lvT3rMM2AZwQU6/j6kyxisqDjtqmL?=
 =?us-ascii?Q?uPMxB/NFSItTp02UBfRIL61WlInMttjYh33ElUbpZVhXWacwQdFrv2tv1OZx?=
 =?us-ascii?Q?Xn4Jxw2PEgm3hrwNFUMc5iaoqLx6X/h6R/OSLkn14HQDpGon/GhiAcxIob9b?=
 =?us-ascii?Q?ceSXIe84+f2M408BR5JVOSLZZ9QpPc1/+tF9UknkTJf1R5svHdQ7XaERlSyn?=
 =?us-ascii?Q?JOTIqgnC5x/Ixg0LVN75DHANG3dCypEJGvWgHgiKpSf4DwCMYCSeXOAiwOpV?=
 =?us-ascii?Q?VdewRWc/w/P0tIvLOpUoKP6nlfEaGQyKHmjYgonDHW+Ite0G1NamhmSzynbk?=
 =?us-ascii?Q?ZcWPmS4BlNhC24WxJ7u4xAzlYv4mhy/VCnIWnDntqa0+B31mSHWJf3FtsNKL?=
 =?us-ascii?Q?VdO52oM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:45.2304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c746228e-829b-491d-07c5-08dc81921858
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561
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

From: Chiawen Huang <chiawen.huang@amd.com>

[How&Why]
Once IPS active, all the DCN resources are
not be allowed to access.
It needs to a function for 3rd party to
on/off IPS.

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Chiawen Huang <chiawen.huang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 10 ++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h      |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0d97611c4817..25a498f65c1c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5332,6 +5332,16 @@ bool dc_set_replay_allow_active(struct dc *dc, bool active)
 	return true;
 }
 
+/* set IPS disable state */
+bool dc_set_ips_disable(struct dc *dc, unsigned int disable_ips)
+{
+	dc_exit_ips_for_hw_access(dc);
+
+	dc->config.disable_ips = disable_ips;
+
+	return true;
+}
+
 void dc_allow_idle_optimizations_internal(struct dc *dc, bool allow, char const *caller_name)
 {
 	if (dc->debug.disable_idle_power_optimizations)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index a06015165a61..4e5c63ddb312 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2467,6 +2467,8 @@ bool dc_set_psr_allow_active(struct dc *dc, bool enable);
 
 bool dc_set_replay_allow_active(struct dc *dc, bool active);
 
+bool dc_set_ips_disable(struct dc *dc, unsigned int disable_ips);
+
 void dc_z10_restore(const struct dc *dc);
 void dc_z10_save_init(struct dc *dc);
 
-- 
2.34.1

