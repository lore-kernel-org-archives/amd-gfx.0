Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FEBC0218A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 07:38:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C806C10E8F8;
	Thu, 30 Jan 2025 07:38:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kDGKC6GB";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A917F10E8F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 07:38:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nW9jnzeaZm2GZnZdAYdj3QDFOQUwr9BCiHxwEejXYDc819Tv2GinBp3dAXbx4azB5TyBYJqg41JGeR2j+u7eqH8Z8MYU+pbyyXjlA5P/nOjqHGoWH/F+1w9O6QIu+ZXCdZILAkIKxO7bg2RBHIMl4+9B6rCwAq8Q3CyJxdGXu1cXx7MG/8DrjBct+PEpcBoqVbpVwCY5Ekft84YxIwVTFGqNGIiVMALhZFeAPoJbBUikQtQD44wngItoX3ONdF9UIRd2niPdxBp+/iwJWuo9rv9SkDipJFUhGEuRaFuOWmNaqfp0Otq//YY6BFinOMjbz4tAVd+fgPllYT4scA+oVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToFNTmBwooQHqcg5TDDaVSbdZBXBjbUXiEXtfhrbgh8=;
 b=YKj/chcLueiBdAEZcDxztwc+Uu3UeEfc1/IrMQa3qFvSsaiDHdb5A+E5AiIXzFu58Mr1txxCpNt8yVc+tD674cKEstUAtOM+6BuFoqyEaVIxRkdBgU5iM+WLjVosbEuCkyzuBMTmq9ixAEQsRIMa46T5trxnH1EzxLRlswHoLgoQzPydhAhrH8z/vNmfmcYEz+L4BL1eeOR6b8/ISPylmH0CKwGVp4dsqLy4MhdKaNZqZz8u5i1hv+PvRwhrEKxHhmjNgj1AJ29IjnCjBsVIxWFFDbs+NcYKpNJd7yckKYuDe62gZ6VSbm/ZljTFu2OOdOEqXpZKFNHYMbaeBy7smQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToFNTmBwooQHqcg5TDDaVSbdZBXBjbUXiEXtfhrbgh8=;
 b=kDGKC6GB4j4pqeDaE4gJxtfULCWN0hkH3IiwK51KDwfAwS9+5bhesufQVFUrMmAZwU8M+1+i0lpOjJFO/baLXFHsQXxRLy/CUZFtwo4Cll7FzaNDJrkkBTmJ54IBF6oESzvBQ6HXwKTtHFsjzQExomsbJaOD8WAYRck2oMcFBko=
Received: from PH7P221CA0085.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::19)
 by MW6PR12MB8960.namprd12.prod.outlook.com (2603:10b6:303:23e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.24; Thu, 30 Jan
 2025 07:38:29 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:328:cafe::d9) by PH7P221CA0085.outlook.office365.com
 (2603:10b6:510:328::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Thu,
 30 Jan 2025 07:38:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 07:38:28 +0000
Received: from amd-mlse-mangesh.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 01:38:25 -0600
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Hawking.Zhang@amd.com>
CC: <Mangesh.Gadre@amd.com>, Shiwu Zhang <shiwu.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: enable the attributes for vb flashing
Date: Thu, 30 Jan 2025 15:37:59 +0800
Message-ID: <20250130073759.2219240-1-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|MW6PR12MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: c8489829-7730-4d91-3e95-08dd41011661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b/A+cvkpSecNlmFQgFg3ydBIjy/yrCtGDWU3HguV/6FOK0qBWiNCwgI6vlq7?=
 =?us-ascii?Q?7LP2Y6/qJpFf5j7bpsGJaYSN1Q1tFSGiDhDkWKo5cLy9N8Tqv1r5oz/aXRX8?=
 =?us-ascii?Q?8OFkO6/6nxTABwEi9ASqsF8whwXDxsutREUWQ0rAnp5oxCYEJJsXqXnjMrst?=
 =?us-ascii?Q?TYj5vRm+b0E7Mt0+PGANNS4/GVFyNedHHUfIs9cyKDyu1SnRixLywTRKuK24?=
 =?us-ascii?Q?ghiyru5y61U13MwtoAKNBk53nW2D4gkdh07IBzYpxJTdZ7D2wgdsMISYaItZ?=
 =?us-ascii?Q?clNcfCaIfOJkAAKLDQJ//Sino+OEQYpASpgbt5HgqFJHKulGZxZG5ddsXhRK?=
 =?us-ascii?Q?FX9JOtVmt8LdElNAHuIJec4OWtSXYSyKsZKBUY+qgIKXgpG9+PPut5Xc84QG?=
 =?us-ascii?Q?EjoT8WSSt0eHrGNHsj1vLLgJ68g4t4eFlXTYywMNi6+Ak363kGo1UZZsvc6S?=
 =?us-ascii?Q?0PzhukwvZCdgWRK8Jyl69E02EOH1pNdEdR2/s5vjFkxC8ouwXfAaoVV7kb/9?=
 =?us-ascii?Q?ImrzBNkrzzgWOUzJk941Zdl2wBEqN6yt2R10pCqDye9WSfeuWSG2r3mMr5nu?=
 =?us-ascii?Q?KU+LtnHUjIhi2tiJCPN94hFcdNJikoiy9aR6hzV2TRGI0rFETV2ZtAm16Ghv?=
 =?us-ascii?Q?BFaQOiH8KrO/56Ua0Go60+mzrMtH6MbsvGKNXarroTY7UVTb272+/6YIM7gd?=
 =?us-ascii?Q?qv+iKHyUHc0IqjFmjs1IPDDPsGgaMICFQ5xjcurYFlkECpnYG51A1bf8rZn/?=
 =?us-ascii?Q?KOIR1ULstfYEpCKPP15tlJISMgcNOqXiwPXvsT7rlqv4+NreGjqvzhtufXmF?=
 =?us-ascii?Q?knd6g3lS3z9tpCfISyVhzGt7KdP/WqnKeXUJjbvX4zpXbSJOfTigdB4tsx1A?=
 =?us-ascii?Q?BFSEdMbjjAfdRkBMxtQ11VpT8mCLusKhSPXBMQjPXAh3+0HBOeXvAPOw5Tln?=
 =?us-ascii?Q?qK1ogf/Ck0llvdCqIVX1fWtI/rcQd+wWGZjcNTT/gEELIK1oLVChe/AJh0xr?=
 =?us-ascii?Q?8zlPkO/vrp5jS8+I9j8DR0vvVciDZ6wQWDUoiKEr3Wu48A9sHhMi2O9gFytL?=
 =?us-ascii?Q?wWPMh48XhjWUaCFmAi35/7qlm0PBQCe1g59DR2gZdxWqKHSg3x6zUjG6PV2/?=
 =?us-ascii?Q?ZRkXTpShBOXhdbxEkDt17q6zsj+TlIBl2vpeOh7Sgwj+kw8SVgkjTZL10m5K?=
 =?us-ascii?Q?8VSusOxezxC8rLmRw2jwtgX/wcXihK1rJ07PUNuBiB6DNCDVcBRgBrpgzz5v?=
 =?us-ascii?Q?ijo2f93v+cwZdBEwTIadZwZH8sR6uZjMbEOcWtgRdMdvslNMQmvn6f+XP+B0?=
 =?us-ascii?Q?E+dbxvZlFl8LHgBEu+Z6D45qh7+8poWqlgGEyoPkDPDfAd8uMWgRJycUOD+T?=
 =?us-ascii?Q?W3DDTFX4hBONHZBVUgfkGLarUGU/PVQrUNGvG65f8skv7IpPNAKn/xNcbVe9?=
 =?us-ascii?Q?HXxjF33Shmb2kc9QXZZ+qhqBmDJ5w88RVhpxGAW4C9+lCI+/trYjRFzUyfxd?=
 =?us-ascii?Q?UYSizBv6IESOHzo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 07:38:28.1160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8489829-7730-4d91-3e95-08dd41011661
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8960
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

From: Shiwu Zhang <shiwu.zhang@amd.com>

Make psp_vbflash_status and psp_vbflash available in sysfs

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 4c794e8ca7bd..b531adfb4f57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -208,11 +208,15 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
 		psp->boot_time_tmr = false;
 		fallthrough;
 	case IP_VERSION(13, 0, 6):
-	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(13, 0, 14):
 		psp_v13_0_set_psp_funcs(psp);
 		psp->autoload_supported = false;
 		break;
+	case IP_VERSION(13, 0, 12):
+		psp_v13_0_set_psp_funcs(psp);
+		psp->autoload_supported = false;
+		adev->psp.sup_ifwi_up = !amdgpu_sriov_vf(adev);
+		break;
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
 	case IP_VERSION(13, 0, 5):
-- 
2.34.1

