Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8545CAC58F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 08:01:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7065810E2C3;
	Mon, 15 Sep 2025 08:01:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ALReZCNo";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85F4410E2C3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 08:01:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=embTwMCheRLhzpjQB+W9UsCAEwbuM5mTvPCLUiEODKr7AynSAXWm6D0DfAxl/5PvGCG0+JguqUhxfx1gmx9+s/BBcd0G80YrC2JPkJ8Ow3MQBUFdIAnAEVnt8SH5oSeUUPw2DzikG4ZaPP+Lax69peKhF5zNme7tZxdJWAHuPyfHpyREfmKYdm/VtTqgvGOxrmoNUGb+QZU6RMXenZH0SZkasyer3JmQf/F83wd6praHz/s0hZSiS3kezwwmIXWDlxmID+amoaqlCTHw78/CLhqLLcn6ucIoeg3XahgfTIhY/qg+pRR7FwqDkyJNisLheDZSa5csDaxCpYg+GfLHag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLr5OOn6oUVemFUuftGUgK+W4aADpWUxfaOcHpFjJKg=;
 b=H4q8FpnfmZVkmrPubCDE9Eh86KG7fXZHQqtea9eJyNvZK5nWUZjN5WPJOjGJa4IZUm7dg6cwTtQr22gB1QiEXSBnkK8TndW0uu+ZatX++/RNym0fZM5PoBJVybuFXBlmmQcgbnaLk1E5Rk1PhShaL0S8vZLLbG1HmlDkOKiGC47kLysknjz7hE3IPQtu7ZqBOnBKt19jRY8r8tSBk3Jsk2Cok5O1utxMKkPZG/N1Bk6GeVu1vUbF70JA0Qkk9nS7ED0K4pnbBgcsDoGWuzgMiXsiacjhunhf1uYsxgOV1M+Snltt7Ir5dcpjhNWMpWh01ZQ+K11ueoOIk1nkOCFJSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLr5OOn6oUVemFUuftGUgK+W4aADpWUxfaOcHpFjJKg=;
 b=ALReZCNoVso1Tedby6ts0v8fi4FVH+5fYwboc4w6n3KharJF4vR3wekwNzAnr4fQOrlo45parf5Pmakw17gLHXYA/2FXWwPL78qeACI43vo1SyyfBNtJD5Okz54A+lgkO4mnUx3P85CURQ5keJkDSxRS5tYKUJR+8GkEFgee1IY=
Received: from MW3PR05CA0011.namprd05.prod.outlook.com (2603:10b6:303:2b::16)
 by MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Mon, 15 Sep
 2025 08:01:48 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::ad) by MW3PR05CA0011.outlook.office365.com
 (2603:10b6:303:2b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.11 via Frontend Transport; Mon,
 15 Sep 2025 08:01:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 08:01:48 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 01:01:46 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH v4 0/7] Add field encoding to gpu metrics fields
Date: Mon, 15 Sep 2025 13:26:29 +0530
Message-ID: <20250915080123.3024297-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c1253f-eafb-4810-b8c7-08ddf42e1f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E5IfIVDfMtsHSkO2uQuG/kyE95+U1NZMucoWmyDDA3sHE9vQj1RCBcr0JKai?=
 =?us-ascii?Q?bQwecxKo2nNSQSw2GblXkSX2yqWXTzIyWuCyfs2tQo9eGsfBs5PFN4ObP4Qp?=
 =?us-ascii?Q?BuWCLOTLPLxQ2rdobPFffj161RJIWOlRsw6GZuzj0bohIL6l3zP619KKOTPD?=
 =?us-ascii?Q?6ojq6Htky7p1lOv4tOGV/QEbIzSwKBH/ISk9k/vXXEVpa7CFR8h2vwAS+d7N?=
 =?us-ascii?Q?fDM2D6F4pI0Xr3OBwZLMQyU99o6y/cdtbx54D22I0UlRGBymMi17AGTRNhhP?=
 =?us-ascii?Q?qKo44INNBkCvdBR+TEfBJ9bDNXXuufWDWoBJju1lw9/Ccmc6c9fOtrIkS3t8?=
 =?us-ascii?Q?SMIQqV8/WPdf9ncfHB079XT0OhdMinXQzd1NJWpWLXOr/T9QUY9K2yuTpCB7?=
 =?us-ascii?Q?RMjp7/fc9ve+AZgJ09rT/rxL0xbo5PM6P8HWuWzLAe0tfHjJarYMd/PVBY9w?=
 =?us-ascii?Q?cdvw2g9lav9yNSoGxe+eUXK5xCzMhcebrY2hL8suMYPe3uPvpzAY1lhMAQhM?=
 =?us-ascii?Q?5ECFeniZZul9qJ+xnEbeQxWj4fBMOTf269BivjhFAw8FgHGhRCGB/mcZcChG?=
 =?us-ascii?Q?JUoZY/JjQ5fJK8q+VKr751z9iAVFE16zjOzuNgD7y5BMxjEyiWFidBfFU3sr?=
 =?us-ascii?Q?81lwlwascaQwHdi2rxaN7AgmgZiXdGE5sz8HtS3xTp05bE7CX990mwA8xc54?=
 =?us-ascii?Q?Oknj2lDwN7xQyGnVOoK7DDpnCtiQdhvIaRtQrK8FlQxq3IJ6990GFO5emSHP?=
 =?us-ascii?Q?YjYv6wnyo2pVGPKgPsYZM9K0phm97jjbSS8px6ScmpBVCkBSKFGfxsSywLwA?=
 =?us-ascii?Q?CljLZYiDivmGW/2YTy+iX0clPBzLqj/BCXIPqVTMIdqyiyqCFBiaBLco3cBy?=
 =?us-ascii?Q?7CUBHJ+XCHU6+23pA0o7wqp137onSeB/K1QPKzPkxzuKOUDEL8kK2SM12Pj2?=
 =?us-ascii?Q?p8H/LBCFDJKJ9efw6Apfee2/4cHItKS106EockbMbil1NNC349yxnQgjbMlH?=
 =?us-ascii?Q?LX6Ucq79DDCO+GkC8R4u6dD/pSN8Ka24WNVi4B7naOWk4LXH1GBRzpGXSN9l?=
 =?us-ascii?Q?9THPPpkq7B79ur34XXC1kRwSrY2z15cSIb8rIL4PutTPzY+SltM8jWcVos1X?=
 =?us-ascii?Q?lT42Yeb/aIbs6abkyTtoUwWn7Mnbk5THLVJFI3wA93yjYvz2LTFBKMR1NVCD?=
 =?us-ascii?Q?qpXJ7b+Lw6+cXF1Qe0cIREYQhzhAt/lBV1kWZg7UvSxWGM+6T2mhUulGtKaC?=
 =?us-ascii?Q?C77GSX8mbwTv4s3cQAbFtD7M7AjzuEsOIKYKZY264avx5NUt7LYO6eEDgaVM?=
 =?us-ascii?Q?HYVX28kOWQzRf92UAEEqlplZq6ZUDjpCByhkuhNzUmRZ11Hj1fe60J/aU/qF?=
 =?us-ascii?Q?M2NcRKBqlVD95KBY0+HYDsVI8NMi+5SORvwfs13DEuxigku/GE+JbBS0tUwF?=
 =?us-ascii?Q?Jhq8o+8/m01SGZUIpYsQTCs6mHyFqkf1jfoeG3HTlmWpKimzFtkersa4DYJo?=
 =?us-ascii?Q?ZgYVwTqGKtnGJfk/djteoqDgEFURbR9eAvMP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 08:01:48.1872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c1253f-eafb-4810-b8c7-08ddf42e1f0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650
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

Currently, gpu_metrics is exported a binary blob with the defintion provided by means of a structure
and version. Though providing the version works well for backward compatiblity, it doesn't work the
other way for tools like amd-smi. Installing a driver with a newer definition of gpu_metrics
sometimes could break compatibility with the older version of amd-smi. Even if newer fields are
added towards the end, a change in datatype of existing field or an increase of size in an array
element will break the compatiblity.

To address this, add field encoding before each metrics field. Each field is designated an attribute
id, and along with that the type (only integral ones are used currently), unit and number of
instances are encoded. Thus an older amd-smi tool may skip any unknown attribute field, and move to
the next attribute. This encoding scheme doesn't take care of elements that are not valid always -
say member_field[3] is not valid under certain conditions in an array member member_field[10]. Hence
this still keeps the design of having all invalid elements initialized to 0xFFs.

Lijo Lazar (7):
  drm/amdgpu/pm: Add definition for gpu_metrics v1.9
  drm/amd/pm: Add helper functions for gpu metrics
  drm/amd/pm: Use gpu metrics 1.9 for SMUv13.0.6
  drm/amd/pm: Use gpu metrics 1.9 for SMUv13.0.12
  drm/amd/pm: Add schema v1.1 for parition metrics
  drm/amd/pm: Update SMUv13.0.6 partition metrics
  drm/amd/pm: Update SMUv13.0.12 partition metrics

 .../gpu/drm/amd/include/kgd_pp_interface.h    | 123 ++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c |  94 +++++------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 140 ++++++++--------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  | 156 +++++++++++++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  62 +++++++
 5 files changed, 450 insertions(+), 125 deletions(-)

-- 
2.49.0

