Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0005C36010
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Apr 2025 20:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C87410E163;
	Tue,  1 Apr 2025 20:44:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ipWtEbSb";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D70C10E163
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Apr 2025 20:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQSn8Wt38T4kQHzdOEfZYIGHlu6LIB8gsgZEkobjx8QmWJMWd+wSgt27wbPmfm+4wNak3+AaZ39XVlW3HFmXkUZM7ZmQBJWnKkmgIn9uz/rrfYXMAA+w65Z6ISsBQzN63DzBHx0fISmWe5TT4KnHVyK1Stu6cUEWcGYbHcIRGRdySzY9sPU/gjGVv1btNO/hb4UL8Pq3CekK7utYo+PtcbQ545bc4IWtKickXYz/bcIgbqVWBTkbYsC043p8cfz94phy0PE+0tAf3xaatxgQitRrPd9hquTO1G+IVqNKT5OVVFl2RC+p6aGT+vrcbCbehuZpMuQeXWaqe6zFnQXYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SJzqi5CtF70CQ+dp2cMzZUmQI8aVVdXNhx5QORUHZQ=;
 b=u95v9paN4xU3oRpmGxWOOO3EwlMlgXCiE9m/cuo35Hm6VWmuPNub3YRa66RsBB80ko5MDcxqxLjrb61Fgrnj0khcPeUHXCOI1a3qJ+Ktbz3DKfVXlyFlag6oqVPiNqQGt/3L4gUGZWpfrmgfdfHwj7uUmPkkUvzgRDX6+UP6UfjJYAjZh1V/euIhSaY7DTSAz24ZzHs47/QCwakzpguGVFn938sQmfXGl9UaNfO2jfC2cF64NXPezpg8RPjCQP0HWLU4fWrvMbWtDn9pXG7Ia9dLNDNfUUbAj7nO36dP0O1lDC98nIrNOyedvZxUoJ7w+shGLRLwpxn1T2j0cavFtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SJzqi5CtF70CQ+dp2cMzZUmQI8aVVdXNhx5QORUHZQ=;
 b=ipWtEbSbFXnpxP1zFU2tB3IMfwEyB77Cn1raEh8E6nJGg7y3hLg/1efY7a2/X49C5EqdOhS45WMJkUy+BSHpPtpB2xjX/GxJt9nvlhJpfte+PLaCQVTznH7pmsXXmn3oBk2Sd9Tj35rtN1sSlBHVnT+BGqwnl9+4N0OmTPA2aWk=
Received: from MN2PR05CA0001.namprd05.prod.outlook.com (2603:10b6:208:c0::14)
 by SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Tue, 1 Apr
 2025 20:44:40 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:208:c0:cafe::f4) by MN2PR05CA0001.outlook.office365.com
 (2603:10b6:208:c0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.21 via Frontend Transport; Tue,
 1 Apr 2025 20:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 1 Apr 2025 20:44:38 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Apr
 2025 15:44:37 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Zhigang.Luo@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Victor.Zhao@amd.com>, Tony Yi <Tony.Yi@amd.com>, Victor Skvortsov
 <Victor.Skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: Fix CPER error handling on VFs
Date: Tue, 1 Apr 2025 16:44:15 -0400
Message-ID: <20250401204415.417443-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|SJ0PR12MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fbc85f1-c242-4f84-774e-08dd715e052f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Epr/8duaDKICxnIVJdapqtcTmQQdAu0E7wmwzpXkb26zX/D+6qygf9+V5TgW?=
 =?us-ascii?Q?14EwmtcCJF8U35Vy0ar/heSiQ5KZzhf3+JO7+qL5yweIlnMC9TaAL96pB+rg?=
 =?us-ascii?Q?fmKpcSnMeIHPBh4UlN7L5L9Yu0RLxS/Z9Qyh6/StJdrVNjcUK+Au2sHu+Hiy?=
 =?us-ascii?Q?sWWoe+cKkugjNQM6/z1BXmvmie5Wn/KCtzt/1DrueHK6Yz1uQ2gIM2Q6/JLK?=
 =?us-ascii?Q?aN7wHguoOYSxltX0PARSPTbDKXQu7ZiTT6XLymNzoG8xBxPScUMFa6PbQfQu?=
 =?us-ascii?Q?R2ILbNElocpfOGK41Z292kRqf9FbZUeme9AAaTbYytb6wlb0uXKVayFuI+rb?=
 =?us-ascii?Q?QrvOQFk3tcewf22i1NpbBu9ZZsxmBYDFsX1OcGo4C7IiyaNoEBsuiXv+V215?=
 =?us-ascii?Q?1TT3Y0V1DXlAkPAje9Fsr0iqvEaaLgiJjdukibHBbOX+YMJVv++2C1iK+FJs?=
 =?us-ascii?Q?IqKXwX+A3BDnpACWmmOFOSECS3xsxNOfA7Z3EFOoAzqz/ajEZuHJ9y46aSff?=
 =?us-ascii?Q?li2hTas4MZnkTgdvCwAWe6015o5YMuH1yUHaTG8H2iTuV/XlaXeIKNd/OJNc?=
 =?us-ascii?Q?Af02Txr36edU0q0n62Np1DERS5CGixv1ytWHiLgHZdbgMYTIdHepLsaQqDpc?=
 =?us-ascii?Q?knx4GvRnzy/abYp1sDKZ9R9i2qYV9t/VSEtoJFkpAF/f3ZPfIMS9lQQpfMBN?=
 =?us-ascii?Q?WigygbPDtQzIE30iQmTEkNccbkFIWfwT9sdftcL2sQ/FOUW+AOfkhWOV+yM7?=
 =?us-ascii?Q?SXlNf+PTmoAZ7CHLmmvtwFdrVMmyb50J1cWyzTtomZ5iYihV9kBdnYVn1Pde?=
 =?us-ascii?Q?CGUAw8hkATeOWR1PrNVKtJEkpxeWj7lNoovLZ1UVDF/3/Qp6KLHnR/joqh4R?=
 =?us-ascii?Q?ySNp0mHrg+QzYvVuRgJRFL6P3zif8z9IMOZd5CDJMWw1Jr9HWmGGuV5drA27?=
 =?us-ascii?Q?dYb7jvmBD80+B9DtQaj5cfra5nEHXv+itmRLchd8P1LNTIpYeC4TkZAXzwKa?=
 =?us-ascii?Q?T6CdX3f/cavnFRMswGhAflZWd476wgue26d96aHpnz9jFd/DU74ueAybepKP?=
 =?us-ascii?Q?wsrOPsBJigUAPzgi/xWp/MEhWjKYcIr9iTHozCfpph638P8p6idygCFqmTOS?=
 =?us-ascii?Q?7cURW0/b6kJ5HB84hCPK2N/0X1OFyerYifhj1qBofhXSeU/d/sMxwjfH5hKg?=
 =?us-ascii?Q?XLC972WSKxlvSa0vG6yGj2Hkeb+Zr70DVbW2WR5nJaIBW649wUif2BKhOLyR?=
 =?us-ascii?Q?JVCQ4q9EBaTG+1Bt5FSgbwTXJ0tuwdDh+9f7LiC+uDchbvlpQfmgUveCGOeA?=
 =?us-ascii?Q?LDFf1lRJNMCobrg6+hU20PmjRa0YP9Ka8f3BZ7nJ04vUnWQaRvdi1liMrgRK?=
 =?us-ascii?Q?G5FIsc7LgD96Tg54OpHJeLQJsU2kANrFVb1ibbr/wLn7DE7ByNICMuXoA0xN?=
 =?us-ascii?Q?ZK74fVe+D7KYMh8j+aB89dACfvXbTbl9scbxTPkuPZA23nWrGcyBualnVz4t?=
 =?us-ascii?Q?1DnnH/nhNJV65Vo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 20:44:38.3915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbc85f1-c242-4f84-774e-08dd715e052f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6760
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

From: Tony Yi <Tony.Yi@amd.com>

CPER read will loop infinitely if an error is encountered and
the more bit is set. Add error checks to break upon failure.

Suggested-by: Tony Yi <Tony.Yi@amd.com>
Signed-off-by: Victor Skvortsov <Victor.Skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 0bb8cbe0dcc0..8d2da3a27440 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1378,14 +1378,16 @@ amdgpu_virt_write_cpers_to_ring(struct amdgpu_device *adev,
 	used_size = host_telemetry->header.used_size;
 
 	if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
-		return 0;
+		return -EINVAL;
 
 	cper_dump = kmemdup(&host_telemetry->body.cper_dump, used_size, GFP_KERNEL);
 	if (!cper_dump)
 		return -ENOMEM;
 
-	if (checksum != amd_sriov_msg_checksum(cper_dump, used_size, 0, 0))
+	if (checksum != amd_sriov_msg_checksum(cper_dump, used_size, 0, 0)) {
+		ret = -EINVAL;
 		goto out;
+	}
 
 	*more = cper_dump->more;
 
@@ -1434,7 +1436,7 @@ static int amdgpu_virt_req_ras_cper_dump_internal(struct amdgpu_device *adev)
 				adev, virt->fw_reserve.ras_telemetry, &more);
 		else
 			ret = 0;
-	} while (more);
+	} while (more && !ret);
 
 	return ret;
 }
-- 
2.34.1

