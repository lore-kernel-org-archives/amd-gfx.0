Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE467CCD183
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Oct 2025 17:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 839E410E825;
	Thu,  2 Oct 2025 17:43:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1Ftp7E8n";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012014.outbound.protection.outlook.com
 [40.93.195.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9302A10E825
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Oct 2025 17:43:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgSkwnVEqp1UYl18ZXJKRatCk16pa/llEogHt958hqfzL7mK6WhlHV1iIzM9L6c9RoFKbEd7cYEe7pSI0nVkaQ9sSQ7KCgeYxFJXTJdAxy9CgrjHjS2nRnVu89y9+Y9uj9VO0BT9N7Osy0HpByOqEKCgN65/vYR9iRC8kRxv1bJs1RDvjE7y51Xt2R+vrwNw4+qJIopE+yqx4xQLK1RfeDE8V0tj8fWMVWt5LvNfxDVBqrzKZxQAdRhVJd4jQV/R96adllDbKJSlJD658z1iPs2MGEO85wYeStmBNN4hL8YBryzA29Rxs8mM2aURGShHDjBIQq1aTdinXWxLNUs6RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrPw6z7exRALLB16rxVjSModPXWu2S+UENdc3kQPCEk=;
 b=Vs4ofSG5KyeerdBjzjjV14piQUwGe6XMFBed7pC51dsDCpNd6v11afmYSjd+mrdhPN22OkH4KYNGf93zqfE10u5hFfPOsO3jkBV5Yuj7NxiklHhTmXXYsjazIXazoylX7/L6Z6qmaCf2G53armDYf0xAwfyQ0GA85Am3BS4/YWc+3h44F/4zY/k6a6Obh5MnTvu9NItcHsl+pOvijg5RZhSl61qS8EboY4jhJedFf4eddbSCzWKZQvfJDEBbKUInwmziYN+1jDBSVzBGq0Y4NTZRXn62yvDYzCvzvxz10MVb1o+VIQSogcGhKIlsfIRyNSMK9TJD0nNRjeLj3p3qNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrPw6z7exRALLB16rxVjSModPXWu2S+UENdc3kQPCEk=;
 b=1Ftp7E8nW+bWxa0MaEfc45/m6UMxx4lygoE8jeKy4R38GETUHkBbALyS9WATcNL3O/nSMAgOtMtIjz8mKQsVTtJrvom3ccromnIwr4EXzJW3dQtxTvfF4Qh4r+BnzUcQf6cg1p/WwgU/KBC2AP8KlWt3mokZkjF/m2Buf/YEFKE=
Received: from SJ0PR03CA0223.namprd03.prod.outlook.com (2603:10b6:a03:39f::18)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.19; Thu, 2 Oct
 2025 17:43:50 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::2b) by SJ0PR03CA0223.outlook.office365.com
 (2603:10b6:a03:39f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Thu,
 2 Oct 2025 17:43:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 17:43:49 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 2 Oct 2025 10:43:48 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/7] Improve suspend callback usage
Date: Thu, 2 Oct 2025 12:42:38 -0500
Message-ID: <20251002174245.1691343-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|MN2PR12MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e8b6c22-ea50-444a-a78e-08de01db3ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LoNNT4ARWpjWwhI7wUkGEeMNlU8xjy2l1+lWqn4U4UMsSxWzht+p7wYJU3ZF?=
 =?us-ascii?Q?Dsd3xUjLwdX4Ix9XhfAy12AgLAQCHOz3wyAusg0cTjSFwjX2C7xkQL2Kf2P/?=
 =?us-ascii?Q?qc3eEs7IN6AF+baPICmHs2IiaJpGtLmVmBAl4Ey6bmRobWdqN69NS5GrQVBR?=
 =?us-ascii?Q?mrwZGbli5ADwQR7uZNqG4OQKXzm9K1silBRiTlvrzupECOO4AqnlFPTkk/iJ?=
 =?us-ascii?Q?8GJpA1ChpSQPCtGssrFMnKG/vQ/pA6FXXR9lyIcpnMjX03LVtl+Jd/FGBDd2?=
 =?us-ascii?Q?V2aXIuiBD8B5jVN9rJMzJaUsYN8jrtu9c2g2TwWT9wWgGRgscQR/nclWVdrv?=
 =?us-ascii?Q?qNdKpUK3Pjcmdmdw3uxqlDKknrrqDC5yvp8p18aU2DUYf/7tnPfM7Y3FnoJU?=
 =?us-ascii?Q?gcpSizuodipnQlIOhtMENX2TwkXVj8+9zf9qSl/AGZcO96FHnxluiMhaqjuz?=
 =?us-ascii?Q?dvi+duP5v48bJ96dEvXbv1IGiE9GraZ6D2BVmGUJxPQnmb+Lsh2tPc1P9/RL?=
 =?us-ascii?Q?tOu/lGj6IFtLBcGusw8IJNA1y4SVRM+qbVk2eofKWbsZpp3+obIeMM+7hvwj?=
 =?us-ascii?Q?Ry+QrVas/9lXP7tAisx0SH41/4CwdthBQH++s7aPXsRd+qLA6jwo1tLtNmOt?=
 =?us-ascii?Q?D2FlN0/DiLpChu7TnmrKURjR99xb5IYB72D1omCjZ3pZ325kFFsHoWTdGEL/?=
 =?us-ascii?Q?BVDEqv9LOrZxT+ipu4spyeygg7Gqvtzc7nsmzhVljtsFDNvvctdKeDFVpR0+?=
 =?us-ascii?Q?OmG6N1Z02WPk7sbBSOQoXrITwLUOYAfuIpDl8s3g1jE62VOfuUNL4UT8rZqc?=
 =?us-ascii?Q?SVuAifD9K29I7T0Tui8O/7OqUz1i98k1HbiZnTenMVH+S7UBMmII2scxA/lI?=
 =?us-ascii?Q?ddw/PZE/1WRAfZ9vmYpuVv5rbJ+3JRWUAA0YPED85i/NZoud9+WHaW5NUFlA?=
 =?us-ascii?Q?H3fv8MWq6v/LnzDbhNe3JXvC5dMu+xs7dZJN519TuNhH813w5qJI4HL+Z8hD?=
 =?us-ascii?Q?3/GgxzMgFUV406RfDiDQDsnihxmb1DVffbGvuGcaTwR2/9gf50bRMRku71hQ?=
 =?us-ascii?Q?jjA62Jiv3j8b/NcXEL2BlyQQTuWx7+Z7yv1xOVYv+pBEej/fw2naH38FJ7Po?=
 =?us-ascii?Q?jd3YVKpKtqiFmy4xlPwykKQCS56vsk81eufX9i8enj96VMAmzRIWcqZC683i?=
 =?us-ascii?Q?HFBgahF4mPSQKZ+8MdmwEOcNYAEPeb8GVZcwucDmtp6tqP2LJcqNCxuXk9aS?=
 =?us-ascii?Q?yXk9DjF7PtIc89MBTfnKrmelyrcxnT15oUXTOMNNjE7G/uGXJLhICGOzxleT?=
 =?us-ascii?Q?UPvWQRV90qStSllaspteP8CDmLh8AXv9wqN8ttdfXcR5hwOUe+TSuuKfk8qt?=
 =?us-ascii?Q?8CSN6qKM9CSMYXfn616s5bXKBlOp+1oaP9RzPPPOEu7yBeiD58OJctF+ecvB?=
 =?us-ascii?Q?1OFCUCFmrBBQx6mxKtaU4RQCBPv/kHe0ktVnzCNKAv6rHy/3nbpLKN/p90Dr?=
 =?us-ascii?Q?gDneTM0esxuUwopnLgaX2JEsv9q7ZcjusOxAH382aAWyK28yCrDa1qat5iAg?=
 =?us-ascii?Q?uVPWCpPKSgk6ZD0iEZM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 17:43:49.2534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8b6c22-ea50-444a-a78e-08de01db3ea8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
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

The shutdown() callback doesn't use the same code as suspend()
callbacks. This series unifies them and then also improves error
handling for all suspend flows.

Mario Limonciello (7):
  drm/amd: Unify shutdown() callback behavior
  drm/amd: Stop exporting amdgpu_device_ip_suspend() outside
    amdgpu_device
  drm/amd: Remove comment about handling errors in
    amdgpu_device_ip_suspend_phase1()
  drm/amd: Don't always set IP block HW status to false
  drm/amd: Pass IP suspend errors up to callers
  drm/amd: Fix error handling with multiple userq IDRs
  drm/amd: Pass userq suspend failures up to caller

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 ++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 25 ++++++++++------------
 4 files changed, 25 insertions(+), 23 deletions(-)

-- 
2.51.0

