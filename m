Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FCCCA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 18:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05A7C10E0A6;
	Wed, 13 Aug 2025 18:50:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yWT35eYI";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06D6710E0A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 18:50:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAX+TJka3NhRhDKwxn+0XQFpBZAYYQRk1Esl91lMQspXLEID6m9Pcowny3OeHdyQkMkXBTEcloEnZr4mgO5az+cAll0eW9PbKTY8bNzi4Rnbo2rTKCia4fsrtxfdnE93062QEqijccKu9E/By5qWW/6oO8icHF5Hlae7B7MhtqeINCPxaYGFrc3o5Dvsg187nL+PR37b4xBVGdaG1fGjC7WFYmv8P3JyUYC8Nf1CNDt3rVjJM7zcifn0HovV0XBJ58UkX5p9i8g8Z4Lhh97SkNhJ88V5/3MR2VA8qd96hOMDx40ytz89jLrSyRn0+ISIL2iG6R56IXMqj4O9woiHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/1ZGHQkSawbmWwzbU7GPi5iA8bEvAnYFTUBFaEnCFc=;
 b=fPBnQIAY911UasgZjAX6BCwbQ2PtLhHi1m8YjcUxyWHjjROLkFTXQ8MLa82kj6gfIPBhlFPG7Qg5cVWX/VWUrjn5r0UXfnLwL/H600Vcq6CWiulkv8gJmD8QbZ+tKWcUMsvVgk2t68rsS9+/4w9lwL7dK9iFdcGlU6zFPnIIYfM78/93Efe0HOElaO+8Z70jgGf506vpqoS2xMnewn1wvgV+homeVd5kQ7Y1Owk5DTqpbt9q+x7hC6F1CAZEIW5QkWm9EEg/+oBiJ9duUaArTQusxX25T35hC67KvR9TuWHKvKXH1IZWuEYdwD9UC77+vu/9fibSg7DldH+zbV0zmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/1ZGHQkSawbmWwzbU7GPi5iA8bEvAnYFTUBFaEnCFc=;
 b=yWT35eYIum8nrvPLC1YwpVK56mMxnwllqK9rm44yUyZMn/k/rzDMu9ivF44IVh1koKu1+wYdRlFXfQmKvtY5vXJ7PxC3gYig5QQ5gjx1+cjZ1623DvmcvhqTbc/+z5Pfgd9FiG0Er/lMlHg6EHd+vpdkDDyVIW0NYuQ0eqyIkyc=
Received: from SJ0PR03CA0332.namprd03.prod.outlook.com (2603:10b6:a03:39c::7)
 by IA1PR12MB6555.namprd12.prod.outlook.com (2603:10b6:208:3a1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 18:50:09 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::41) by SJ0PR03CA0332.outlook.office365.com
 (2603:10b6:a03:39c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 18:50:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 18:50:09 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 13:50:05 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tvrtko.ursulin@igalia.com>, <Felix.Kuehling@amd.com>,
 <David.YatSin@amd.com>, <Chris.Freehill@amd.com>, <Christian.Koenig@amd.com>, 
 <dcostantino@meta.com>, <sruffell@meta.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <Alexander.Deucher@amd.com>
Subject: [PATCH v14] Add CRIU support for amdgpu dmabuf
Date: Wed, 13 Aug 2025 14:49:49 -0400
Message-ID: <20250813184953.3666821-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|IA1PR12MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b19dab0-26d2-4ba7-98ff-08ddda9a3a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u+cqlSMU5sWcO9fAEwJ7LXl59LXsapi6CFYHfYVN3EcG3mE19qvyUVt3TS+K?=
 =?us-ascii?Q?Jdz0vwAEHUtfE8ebO9XTfTjPAcTI+ZO/MWxqcuhF4dJwYFxO4GLJRzlKvMLh?=
 =?us-ascii?Q?0WQ9+WiZLGmI09wAv1JrAGbcRfPCIscmSh8NqLX3EX5reNVVmYiZ5XpNrnLD?=
 =?us-ascii?Q?owS/4JLxlBZFq1lEV4FGNWRWZvCr+95QSzdQ4i+ed4Adj3uNQ/ANYHdh+WHU?=
 =?us-ascii?Q?2WLwTxqbmpgNVxa4HnOqcvIevuyRgu9pNrX6PYZWJvwzGHDmUBqVf4wjrunG?=
 =?us-ascii?Q?a9u//tpLlAROoO/TUq+6mQfgy5Gj/UUxW7bzfjIjZz0HC4mkBMng6XxwW47P?=
 =?us-ascii?Q?eVJcjqEcE4xAeUr/jD3P+WlkLq2Lka9JA2osk7bUpeQFLv6E+H121sFdcR9r?=
 =?us-ascii?Q?g/SXE750HUTv2AHrALoDFCLTtm5O2VavrMG8yF0ztYW9rguXV6GTglgQbS5F?=
 =?us-ascii?Q?uDbd9vkDVjS9HxQss+PuAQApEbFcFgSH5qzMpYSJn76lJsh1nJd2NJX+gOyZ?=
 =?us-ascii?Q?qMPTYG8XfVCeMFF2bCEY8Xso3x2d5Z4DEDtdg3/BmdI5GruZ3zXY2M7bDfkX?=
 =?us-ascii?Q?YE0bmpRDdxAy+CKhZLLQwTZDWJZSBxXIvOhq28j4dAW4s7O1LjnDYg4fqgwl?=
 =?us-ascii?Q?KebYMcHHoqwhtT/W8yPw3xbdN8yBLMEEaIYbq6JpoYE1lOXkQXeoHq+zljxh?=
 =?us-ascii?Q?m62PxNquil59EZO5AhlFIH8rbTGRnsXhstgQA7vxL8ALxpiPZlmAporuPbzd?=
 =?us-ascii?Q?DSpFjYbobsqD3EKKmCWDX6UwFIlzc6kcHWhpG/dVPpbu4Rf9P3Y6chW64dTm?=
 =?us-ascii?Q?8OEdc28iXM5HmJDOhkuNAKcePQNDyBC+vMxrnwV4hJHobzrXNuPeVmguUwWc?=
 =?us-ascii?Q?6ZWWv8jC/DAQvDlpXmNMaG+2l4HKdrKL5ZF4KUggkaIloEXT0W5tro1UpyYr?=
 =?us-ascii?Q?dAsI0SARd6O6BGvvL5sOp5D7HYqNLwmiwTdtS7+7To48RVXcJHy792odll2G?=
 =?us-ascii?Q?qrPSQR7Bn+52Vxh0si+TfYggs5rxrfe9QqvC7nxrRNNTHHyVA0f/mX8N/rYO?=
 =?us-ascii?Q?p1wEkW63phBfywgVPCYP1wYuFdHpcyrQnjW0xsosAu+JjBd2mdXLE0m/FFEU?=
 =?us-ascii?Q?JhKGfo7rpbcCBA1jc6fl7wxrA3Jxpak1kr7Dyn7Zbs/aH+g28eV/tUus5DaR?=
 =?us-ascii?Q?8MtNCZckex2vCmJj+VA9dNedXaULMmGwUdMJ3LaKNV/z+QdKzt+nzb0PXt0W?=
 =?us-ascii?Q?MrJfH1kjasVYBP+HXbelYIlWcgWeZKV/mnAx9JnKlPZ8eBRQL6Rn9w2pPz5b?=
 =?us-ascii?Q?F7sYUm3IYei1hkjAjTOInnRwpmTkK0IbrrlZg3XYVxhLbglIClEhRnYveebQ?=
 =?us-ascii?Q?jm7uc0zA6kdzu+eepMzxwDpVQnv8IKDnDRtNk6iNuG8JHEjUGsORdEGMVlb8?=
 =?us-ascii?Q?lJQkTaESjcKehGbGlm5eNxhH1tuzOy5ipKu2vi/iEFophHDSdPmNJF7bPk1h?=
 =?us-ascii?Q?Q2IbSYjkG412VKMrDxZlI2fP47+BVEhcKcH5ThlmN1kNWiW3ZebYyLZzHA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 18:50:09.1579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b19dab0-26d2-4ba7-98ff-08ddda9a3a47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6555
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

This patch series adds support for CRIU checkpointing of processes that
share memory with the amdgpu dmabuf interface.

This v14 adds the coherence and uncached flags to gem create and fixes some
formatting issues in amdgpu_drm.h

Accompanying CRIU changes:
https://github.com/checkpoint-restore/criu/pull/2613


