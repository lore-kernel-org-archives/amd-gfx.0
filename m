Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B0EC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 05:54:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8329110FC4E;
	Mon, 22 Apr 2024 05:54:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J9QVK+sx";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8ECE10FC4E
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 05:54:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqfbBVRa6kp1Mw5GHOo3zBZ4YbzDdAM4puNsUg+/ytStLIWdm2xONd4BcgxXAtdVgWXOFRXCl9rq5KnJiTJ8UTGJqJSFRXEiKUmoLxzT/HkcakbKxteEEb0AUAeVdn9FQo/uQw/4756AvkTbxI1BBczjyXodSRKV814NcuZ5lVaPPnrlY+wKfh4Bx1bojoTiKjhSRSxMNI4EFiQw/oc6YbxBFA9pSF7iJvdcLS04NXIicrLiin07m+k9k0NPQAFlPx6rBdqnZmGX0Ga1k8t/ELDa7Ba3KnWWh244MlGff2PlkC6kgqLhWOcHKkPRnnrPH/sjjADm+Aepc6+/sEsoog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATZhjv715T8tLaDsqy7nYpYQCENBJwdxrB/8m7tiiaE=;
 b=h2IfEVXbB0cKvP4zQiK6WyZNDF5R6ua9+yV8vdfuuYQiwEYBhIWSl+Okvy8AhgJTyciW/TrhgTponStCUCxjrRhLl5Xb9SwnZY0/hB/uG7Lu9GttIuhh8uMm9M/uHiS8VL8xMNlP+WUG5I4MP7G24cHgsgsjxZiZA1LtSag7hXUFfBXgfvChaAgz6k0xka9SvLa1fER7Grxxvm80RpCW68RAhpRlTK470v9Sd8gsEXRr1UDgQ0dflfrx96TvN6Csi1PXosBhqT10l6TXfE7RP/dxnFLM5WIjxvNSYW1sF6jGM37Xa3eeJ5GBQNime5quMR1XOd+07EtwDDJEfCMRrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATZhjv715T8tLaDsqy7nYpYQCENBJwdxrB/8m7tiiaE=;
 b=J9QVK+sxG7neLaVonaSvuBDtkNX3MmJGNBVGJRHexMUHaE0PHXWmoN+TgEteJWhmW034pVVRI+zsgV5s3BAXwhqPauMQYmzp2r1lv8SAQHkyEv2nBsdf7iYbJ3IS/BIZuvSit05TmTaifMUofZe+oTK8IOrVRrnCgQH2kIhkD4Q=
Received: from PH3PEPF000040A4.namprd05.prod.outlook.com (2603:10b6:518:1::53)
 by DM4PR12MB7741.namprd12.prod.outlook.com (2603:10b6:8:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 05:53:58 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2a01:111:f403:c802::) by PH3PEPF000040A4.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20 via Frontend
 Transport; Mon, 22 Apr 2024 05:53:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 22 Apr 2024 05:53:57 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 00:53:55 -0500
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: init microcode chip name from ip versions
Date: Mon, 22 Apr 2024 13:53:43 +0800
Message-ID: <20240422055343.1894762-1-le.ma@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|DM4PR12MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d16f6e5-d991-42eb-bedd-08dc629099ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nSakVIUQeEgW/d/E45Mk7LF4Nydvs6r8+Zm1R8foM7wbjYSpESXxyPVUYDqu?=
 =?us-ascii?Q?uxr4E5Hp6pMtH7x8lDJ8UqzxVHr1HoI4aCouXDYAuqTIgOKp5jxlqD2gS4+m?=
 =?us-ascii?Q?PjV+7hoM91PKGsRdrTSqMfv2mUg+jD99H+1C7oupsQ0He7S+mI7hVM2Gckka?=
 =?us-ascii?Q?2L4VeZwVym9XlDOk1M8OnQ6UuAqsuGcQ88T8cX3OPP4XcB9DuXm8O/GHdeHR?=
 =?us-ascii?Q?mQQXVQu7SucB2nip7sAkSbPeN/X9ukrO15zvvhZyAKvV9v4k7CXqBRSe1ffz?=
 =?us-ascii?Q?9vAED3/Acxw2I6iZpE31704kcdptQXfdAM5IfvDhu0nP7QtvNv1+FtO03l6W?=
 =?us-ascii?Q?FXOUqo8QapJBZXk0mjMhw/2e5NBTzdDPbOgUWb11AKNPPlCl7a09xLgI9Uvu?=
 =?us-ascii?Q?RCFmLzUzLsSrlmOU7xcRDOHzopgj6YNzzPLjK5L5TNmOEB/xL3ILzhiDkSaO?=
 =?us-ascii?Q?Iei8+X5p89LVj1HQWd2ReJNjWFoUSjLCCPNFFhY6T+oq8TsKsvcerMchnKX4?=
 =?us-ascii?Q?7kLPnm0ia7IehiRVGot5Qq3m8hPpfbeRpA9tADdp8dTvQjrHpXPiNb/blPZG?=
 =?us-ascii?Q?6zzIrFI24LrMtnQS7gvUUNcvUhDE6WJwl7e8HR5sGsY55geF9uyLZRN55p8e?=
 =?us-ascii?Q?smN1RlNADHGTSUwfNs/lmF2U0Uc/WRwdlnkXJFcB3EhmK9EMqa0lx0VP+yaD?=
 =?us-ascii?Q?XndDvk2Cdx2hJZHoaK2OVEJeUbqmozk8UaA+acCqi2wW47JzbrgamqjqEdN0?=
 =?us-ascii?Q?WFLf+m/cpYmk8EOKqM/oKG/0jiWQsaQ2yV8rhxVXdVHFgyNO8HIy8xbf+ftj?=
 =?us-ascii?Q?o/nubxmZI0oFPxoUqMMwMTZmc05NqbIIERqsFC1ztRSfBtbgBi/6wWrCm5oh?=
 =?us-ascii?Q?YImRivaEOvgMyl5MfcPdXBpGEZYXqHyrmxOC09QB+bkKDV2CosDlf7T1uic5?=
 =?us-ascii?Q?71yEUiC9WRFfjTkJhT2ODPJhu7mJTmsovLACcNl8XlLBCrhH0BXc9tPh3wnx?=
 =?us-ascii?Q?pDfc9WPRJ4ai6jqwutjigzo/WCzyEIGRavumhBxUrHCMt3X7f9Pz6bwJvTyh?=
 =?us-ascii?Q?4YM0QtDq0scQZQJdge9FxLw4JIftCW8BypF0ZtVn0QkO5r559g34cNtsaGaj?=
 =?us-ascii?Q?toJ+Yjekk/MSlmBBSBHG9W0j8btne+GavRP8IO02myeloOMga7cwEjqQqMLq?=
 =?us-ascii?Q?zFDgWvd6+0xW8L9wKgzQALnJ45UNEs2jO9EJGz2s+0RcXU0W/0qUkgtzf6fC?=
 =?us-ascii?Q?UlmrIarSHrZLLF19ap0otdxAy8NlyKSrAe7BIDBz/yANZi3lWdomrw7gA9UU?=
 =?us-ascii?Q?hLcwRPlR7Jto8Rhpirj3usFbYQpn0p20x2ltJ9uBsYkxUpKVdfxh4c6mOvW9?=
 =?us-ascii?Q?pWEcucYwCG5RVMQfNmlYUWGYwPEj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 05:53:57.6047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d16f6e5-d991-42eb-bedd-08dc629099ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7741
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

To adapt to different gc versions in gfx_v9_4_3.c file.

Change-Id: Ib4465aade0dcbbcc43318c6dc865f813c5411097
Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 835004187a58..ec4d3fa87e4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -431,16 +431,16 @@ static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
 
 static int gfx_v9_4_3_init_microcode(struct amdgpu_device *adev)
 {
-	const char *chip_name;
+	char ucode_prefix[30];
 	int r;
 
-	chip_name = "gc_9_4_3";
+	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
 
-	r = gfx_v9_4_3_init_rlc_microcode(adev, chip_name);
+	r = gfx_v9_4_3_init_rlc_microcode(adev, ucode_prefix);
 	if (r)
 		return r;
 
-	r = gfx_v9_4_3_init_cp_compute_microcode(adev, chip_name);
+	r = gfx_v9_4_3_init_cp_compute_microcode(adev, ucode_prefix);
 	if (r)
 		return r;
 
-- 
2.43.2

