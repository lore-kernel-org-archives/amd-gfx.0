Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C67DC3ABD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 17:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F31AC10E6B5;
	Wed, 14 May 2025 17:23:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DQZRC2VY";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2946A10E2CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 17:23:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzGfcVxGHd2m9iqEZ8h4IHruLokLWswd3jwixcmmEh1G0WVj9jYIcNqTjS0GKkee+8cWLra09XDzjWMm/ssKNZpqyxbhoCSl5Z2dsXNY55M/tgevpczkHpbpxvkhWz4N8upwvx1XD305uxEnqdNQeco5Lev595Hw2pjmKU1lbtKNGPz8Dew81qU3Yov/haxMHccj4oy3gX6X2DKHMtZ0C6k75Pa3PCN2Y1DLTutkcbBtqoESusN5KDvZ3dV9Lj2RND7KDX/xNQZIAnJQrEzUGQa8njP64w5Lii1iL1HvxaJS5KMLgGozV4BvaHUxHi0Sxk7fbrqSDFjerQjrq8rcIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjY9vlePQU9phepBWeUoWC1y5Ya9Qwr3UHV4yVtxGJs=;
 b=vfzrVVZQfLxW/JiRgIoQXPT7l/69TLoRo8L9vMXNLeDOLl2Gr0KZ+ZIRBW5c046rPk6WUedfYNVkWLHBaifMIM4Z3Ijbx+4ToetsUJj3+OorZezwZkc2/7EAlIUzY4Oa2QLimaReD731fpsE/5QAzXhqhiaAQcdTzZXGYSYrJNQ3bbyPrPW3CRFRJPBsYgZ7LHrS6bkF1CZbs4aYCUG+b2hv8KrDRqzF+KrvXjWhmL+494C6wOrQQRWErQcJa+1s6RcagJWpnohJohD3Et2507e7qwaMbnEDGIBUezr5cNIPRiWeohlx2vexHUW46mhXixclij2zP/qaSNb/weuC6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjY9vlePQU9phepBWeUoWC1y5Ya9Qwr3UHV4yVtxGJs=;
 b=DQZRC2VYivWtlPzMdBk6t+McU2+nQlxzYwZE5l5DVjqEYxRXaDbS/Zfu171T/RaiRvk0itazqDhPYtbdkq55du3FbomSEL+qZUHgpZh+IRYbSm665nSsanhBAOqxd85nHpYeZIbVS0TEYXzPuUaZRBtBaDoClnGiTVaHOF1zgAk=
Received: from SJ0PR03CA0281.namprd03.prod.outlook.com (2603:10b6:a03:39e::16)
 by MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 14 May
 2025 17:23:04 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::4e) by SJ0PR03CA0281.outlook.office365.com
 (2603:10b6:a03:39e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.24 via Frontend Transport; Wed,
 14 May 2025 17:23:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 17:23:03 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 May 2025 12:23:03 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Christian.Koenig@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v1 0/8] drm/amdgpu: read back register after written
Date: Wed, 14 May 2025 13:22:43 -0400
Message-ID: <20250514172251.726484-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 083d09e7-13ea-4505-4acb-08dd930bfc3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ec8ogbpysvJpDlRcr/6xye3zNUqweTYLwMRZqlAIrMEfRNM9VH4t/vT7h79Z?=
 =?us-ascii?Q?Rw/UcZ+8/lzlmdoHsFOa169nBqK3KOvverV2J7z7aiuvCFIJD5BSs6E//Dks?=
 =?us-ascii?Q?lF67hSt2yJmEBzLHr3DqYvYXb5JtBx2EFoz4X8UdIQwR4K3SRAA0YJG9jOU/?=
 =?us-ascii?Q?o1rGP9oXO+pwy8+scfui2Hoo6IFq6qTenSkv9tv5QdA0lYQHRWvc+2yqv2Ai?=
 =?us-ascii?Q?cqzhsga3SLq72E6IrcW/3hOwE+Oy6EkXlou6M2obS/Fc1x531tD7qtzrMDwI?=
 =?us-ascii?Q?nwbkoeUMVLXB/ppsLKhNY+D+Kqce8ILbuA6mxLwYgCsucvc3hIuK6RhEAnIc?=
 =?us-ascii?Q?k2mX4qEUyBNQ7e1IIERInxTlrLmzQowBQUg7dEhH+fL+Q9zL7izyY9B5IVgy?=
 =?us-ascii?Q?X7ePTDGTs42j33+1Q03FVM5yOGtbmzdiFV3tYFCVo/6Xu48k+4fwbdbdMUf8?=
 =?us-ascii?Q?oJRHUQNOtitnOjyQF4Qc72oZ8iB41KmyWyt/YyxypnPvxbCn/l2+pqLc0teP?=
 =?us-ascii?Q?QWr2wD0pGIJo6QyMYj9esSaY+s9s+/ij0PVJmr1m1NjQCDzIeviQMvCBEGZY?=
 =?us-ascii?Q?ZB5MMGLhp8iBxYChpMNk1lovYxfkZh7WAncsDxsX8Xj+jFI4gP3kJLvhmr5b?=
 =?us-ascii?Q?hHoMLdusl5wqiuoOKTRh1xT6eUtziJkyVV+F04CqB3SniWU577eThfI+cqF5?=
 =?us-ascii?Q?hHPpNBbBOBEGUN9gT/ZgNQfyLSWy62iPoYkvWD3xNQWRAn1dTU3bX/mh169q?=
 =?us-ascii?Q?+no+cmc4ClGe9FHelWN4eqCuKdnMo1u77nFYwocF50yc1NPpIwrPx1az84Uw?=
 =?us-ascii?Q?48QhCkl60qudyjs4yHcfbDNqxaRaB+agMBDD2u1bVlF+kjDurMWVNs4Pnfls?=
 =?us-ascii?Q?9QsTawoMlPU5EFXsXH2Pnsd9TUOpKP+0JImjeyyMV/Zv121YACUbh8rH292n?=
 =?us-ascii?Q?2P7HX10AmY6cW9NLjxjv53fGPqgdfMvVib2FlQPyQG7sYAtmUE/tfmj9D9ZG?=
 =?us-ascii?Q?LysMre8ZpVeiq41Ii33lwxDzTI80Fz/WXPdJ1B893LAzLFwQ40h9LrjgRxNz?=
 =?us-ascii?Q?bCtUKkW4JmFVsHrQr+BFiDZWg96eYU2seCa3AXdkPLcSMzlcX3SzkTGxb2GE?=
 =?us-ascii?Q?1fzKIA26jM6CqwPnDRCWzJVvPK/jUI/3DSpZ2EWqTKqG5rKNlQ21LmI7/7OD?=
 =?us-ascii?Q?k+p9wI3MPK3bhPqbdHaHAjrnbZ1CWinc9tY4Alzxxhhh5oYBblNq+xzZdVsj?=
 =?us-ascii?Q?NpanclCJQ08DlKeED7ZXvafJlmOX9i7GmgVEGMAEi+yH5PIUaJg3jWX0xoec?=
 =?us-ascii?Q?0LUslZjOMI2yDnA4YHMBr7YLAKoXfXW/dVfHW2l+ZLA1BEY6rWDF0N3PTaDG?=
 =?us-ascii?Q?lOD5eviuzY269eS9dny7VyP5RlEaRrfIXvfsxJ5sCA1Jxt1sQE4CXh9LtFVo?=
 =?us-ascii?Q?nSPLuHv8AdurySe1Weat/XSjMqJQm4phZTDAvhChgiwsq+DQXo4YiMSElgwB?=
 =?us-ascii?Q?2xuFax9y9SLPbEkFrFKD+8GwG9BCfr5vFfvT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 17:23:03.9783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 083d09e7-13ea-4505-4acb-08dd930bfc3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786
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

Similar to the changes made for VCN v4.0.5, the addition of register
read-back support in other VCN versions is intended to prevent potential
race conditions, even though such issues have not been observed yet.
This change ensures consistency across different VCN variants and helps
avoid similar issues. The overhead introduced is negligible.

