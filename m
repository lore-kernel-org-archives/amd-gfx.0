Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628C9C83F07
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 07:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8BE310E421;
	Mon,  7 Jul 2025 07:08:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fLUvsWie";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE35710E421
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 07:08:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTCoVqhuvE/P3cCcSj7zyn8YfZI6p0gLo9OK0bxjFgGhl8GqqXmciPlF2G4Rdt8pWs95jKubbK1og1aYEvs/VlNM8v+d75x3bt8hmRhCBwhio6Rf2ezxTf5E2323ysPY6rP/Jy7pJtJ0fxFRAHqOFr7/30R41VhgVanLxxZFkiq0Fm72Z4Ar9D5e7vdzwbb4euZyAzqSfWuFrLYX4mr6gCpZXQLgbwZdG4XB4Z5X6FvIfClsbZGCwA3hqgxCbBXv1b1eqahY9eOaza24zmSsyb5cbbNNF8gnXjsUMVoVcmoycQW+kcuCbHixFMJTbCKfIe8k3yhZtxnKugb8L3mWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B88EecwdOMuxu+RiPDxYiB/Y0leLTI45UNCZLNlJHVw=;
 b=aJgNIOWJ9meoyzBGEjBqqG4Ek788ucRvK/9uxUssXPo36RssLKY1qBgUes8jxxdXDmkSKOa4OXeoA+gGavTcxUojt7yS8ndd+t7+4vipzfAmxfAY6mFeJzwPOhqexM6Woo0VvLQLHW/Tv3grtJY3RfkkHznKd1Brm8634XBdfgscZbTZ12qpujVWyRR73BzMi6Xz8bnjx8QHwSrk5+xDZ9Q2yzzy6kx7W7b5akjPhZ1RwxDUWdAN6tAVpZxP+fc2e8y13m2i/qvluTsFSTFhKm7sOeaJjz5D82LV/Squ/xKCo6fAzAxrM69va/k0RBuMdgu5qNBP0ARiZ7Pp3DZWuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B88EecwdOMuxu+RiPDxYiB/Y0leLTI45UNCZLNlJHVw=;
 b=fLUvsWieWWmy5jn3bKXxeApuFAqrTldFo8Dbil+tQEpzP5fLnlNbBCIcXVPKy/KY6SoMJUTNGK+jNpOO+0XnqchMl7OBmS/EoVTuKUtlYEWOUDvSuZ8KOYiAc6yhG5hpzsNLZXllLLcfY/JMDRDQ2K33xOdPGPbZXBfIqIQaF/Y=
Received: from CH0PR03CA0219.namprd03.prod.outlook.com (2603:10b6:610:e7::14)
 by CYYPR12MB8891.namprd12.prod.outlook.com (2603:10b6:930:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 7 Jul
 2025 07:08:28 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::e8) by CH0PR03CA0219.outlook.office365.com
 (2603:10b6:610:e7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 07:08:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 07:08:28 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 02:08:24 -0500
From: Meng Li <li.meng@amd.com>
To: amd-gfx <amd-gfx@lists.freedesktop.org>
CC: Perry Yuan <Perry.Yuan@amd.com>, Shimmer Huang <Shimmer.Huang@amd.com>,
 Koenig Christian <Koenig.Christian@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, 
 Alexander Deucher <Alexander.Deucher@amd.com>, Meng Li <li.meng@amd.com>
Subject: [PATCH V4 0/1] Release xcp drm memory after unplug xcp device
Date: Mon, 7 Jul 2025 15:08:06 +0800
Message-ID: <20250707070807.2034235-1-li.meng@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|CYYPR12MB8891:EE_
X-MS-Office365-Filtering-Correlation-Id: d11852d1-c0c3-4315-aea5-08ddbd2512fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wBttyu115ZJ/JJcxkgPBtVqX8DsuOd4FWA1tQ+FLutOuapO9PfILRpTlwOuD?=
 =?us-ascii?Q?7fmw5ZLdko7dhF0YLzlqr2e5WMBytyzAbdXfxDXtgtX5Xqn8WQy35JDGwxsJ?=
 =?us-ascii?Q?8WOyXbhjDXi351sdHkzoyS4v3ssqqLZAeuLx477Dv4nAo5dOqUyTbyjkG/RC?=
 =?us-ascii?Q?FJzJcZdkGZZcpu5oGGre64x7a24nm/ncQinaqc+JP67xLSPUi9EAph1A+3xV?=
 =?us-ascii?Q?sTukIbH5lGH994JJwXS4DgTvdX6gWzraBBd6GoX3qUbItr+CNyX+E8W2Hdbl?=
 =?us-ascii?Q?EdLch78oMnHYKnxaERXygrCw0rOJOR4RQHW/vAmua0ar6HAipFaUKbM4uczF?=
 =?us-ascii?Q?moLBMf2xFGElD+/5bmKE83fEovVqnC8qd9dnWRQ0cajp0C3sl8s8WBll4wr5?=
 =?us-ascii?Q?eq0iXxaLFCbFXKzYP0hVAQFr5bnw/TJhrC7xath2kwZOJRgtBKleTdpKExKh?=
 =?us-ascii?Q?MSSnrtTo170dWfKNujxE7xcIMwFs55NTh0qXckI2Ha0rnvZr8sHQM5mNq2zZ?=
 =?us-ascii?Q?mXW/b7ti2ePI8x1v/V0o3C3IfMAPK2SJr6EUt2EW8/+TxCwewiBZxcEX8z7e?=
 =?us-ascii?Q?IBschOjeDKYCUrItKI8smr5j9T4++cd1TgEUbe6/Jc1w76Ni+85oHaho/su7?=
 =?us-ascii?Q?vFCvxausDcwoLctvgADEK/p3dYOYO7KL3UFlOn84fpvwgUklWUkqDYCUzOrX?=
 =?us-ascii?Q?uDhy4CwYBgOL37xTDhopC0t79oQjwfS7etvnGEAs5CNbNxSOKGamsmKYUZc5?=
 =?us-ascii?Q?8bu/QdEbAsdXNnT7h+ajfMiC/fpa9DniPMnpv4C5vzOOFHuzzn8r5tpl3tuj?=
 =?us-ascii?Q?dj6DVLGScpN/7L+OIENTiILdwzinOnHhQxQuyTobCBUjUNNqec799vyekRp+?=
 =?us-ascii?Q?kNlr01mRwwKxlphzSUEllPCCZplcT+BO7VX/Nfban5RDusUfDUO82HaQ5+Pk?=
 =?us-ascii?Q?VTO7HWgqbxEsZppzorNZjILIuvAJlFcABGIgHcC5LM00CzIJMwnQ4CaUQgVz?=
 =?us-ascii?Q?6Ut+zRFdxZMruJZWX1gVGvVS4JAhiPUp2kblsH6+h6gwP1G5rwaw8Zq2CKUa?=
 =?us-ascii?Q?dR78e2rwGhh0W3i5lMWctyGGipBIomUtkMW8RebwyAO8U16m5e695WJk09Uf?=
 =?us-ascii?Q?io9/zPf+gv0M4yqrJx1lh5I664LBk7Q+YDd7cIwydpQlPLGlk4s5mZf4Qruc?=
 =?us-ascii?Q?T7R2uGG1VSXs3x5k4trF0RkSLgk6T/xFH+ILQPMlvjUT86VPVCsIAUPyI3de?=
 =?us-ascii?Q?RGx8Xij8GFzE5n88XY6mCHShQG276+FNqSJnpbsSGHpdb+jiC1i6RFIW8TFi?=
 =?us-ascii?Q?zlkN90gYeQKb73GhL9skhbtlqlF4icIidwSGvzeKl/5yYPJju6kMiEok2Trc?=
 =?us-ascii?Q?787XyoDhL2vw1D+DuqI2XW9Dx8kYdH3M52GceTPPtZf9I/cKX79zhpfrnx1k?=
 =?us-ascii?Q?IMq1+JZT3MEN6H809oXFm9hQYq/vrUROf2XRjoI3WST4/qKBOG0iFp2BRfR6?=
 =?us-ascii?Q?WahDY9hj78ctm1Hjk4/0xbSdZ8keJ/brFIb1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 07:08:28.6033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d11852d1-c0c3-4315-aea5-08ddbd2512fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8891
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

Fix xcp drm memory release after executing PCIe remove.
Fix xcp drm memory alloc after executing PCIe insert.

Changes from V3->V4:
- amdgpu:
- - Remove redundant initialization for "i".
- - Simplify checks.

Changes from V2->V3:
- amdgpu:
- - Add Gerry as a Signed-off.
- - Unified commit author.

Changes from V1->V2:
- cover-letter:
- - Revise title version number.
- amdgpu:
- - Remove // comments.
- - Add Gerry as a co-developr.

Meng Li (1):
  drm/amd/amdgpu: Release xcp drm memory after unplug

 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     |  1 +
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 58 +++++++++++++++++----
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
 3 files changed, 51 insertions(+), 9 deletions(-)

-- 
2.43.0

