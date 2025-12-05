Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1AED374A6
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 21:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E870610EBCE;
	Fri,  5 Dec 2025 21:50:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nT2Pgca/";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3CA610EBCE
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 21:50:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdvIi3h+3nHmkzxeNGymVzZjsKi89Qne/GCiJB09B4ZtsKlYi1QnJvifBrlwymO4XsTRZxxlq56SJuui4fpYJId+iCd5iard0Jz3WHLpiA/tsP8VHAQKZzH0xLVExjwP0OVVgCuH2d+LkVpNzSu9NHSuCk+OuNWp+eyi3FI6PH5klXljrEHAf3XLWOeLA8xoixUoFb1aqqhZc+W8NR57jjY3VsIpgmfIN6KwRcjpogc2TRM5o1W0lE8ByekrJ0BwG+mfzAGAlMOHRyjOaHqOewWp1du9XF1L9srEv4gMeo1QNU3G103ylxlLc0ZVarYOTnnqZeUog+LWj0v3MnNUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfMPyg73kCRMwLVktMIdhjMf/ZRQcXH0PwBPmZYSmy0=;
 b=H0UbSUdZeeevmzGP5xdAr73uwsIxh2YK1oMuvtGDLFElv+HGDkK3rD/FmVeU+Z5W8ze2z8/XNu5b3H8t3IlDIwwQoinfoElpSOsVD6GJFG/YgYF4ryCQ0pRMW6kxAVJrlsM+xD3ZqpE8I5Rn6dylW2WPVu9EGi84AguXTCDn/4/Xa7GaiZzoa6ZF01eScpk6ZGrxYYQAoLYRRblMQl1BGE8DStBjEBkZ5oMhkHJWe1rwYrAtT5UzfxTd9HR5UyUZ+USUo/e4szvEsns+89534qe3Xvzsr7in23uzW9P3pHFs+hLYbi5nBZCg26tG6kpdxn+gdfQnQa/KgbHBkeun1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfMPyg73kCRMwLVktMIdhjMf/ZRQcXH0PwBPmZYSmy0=;
 b=nT2Pgca/xNfJTHnTy4hHbiarq73K6zDnDtg2F5G43Rmgv913e81PBeVV/thUpGztY3O7H8R0C4YVE4Gu9L20o3h98PSbCLU8MBogL0jqn2n6F2Ci5ylI2qrjidJhQ3S29zSwsVb4cjJ0mx5xXgrpEb1gCRtGdUjx/fazuEVYcFU=
Received: from DM6PR11CA0022.namprd11.prod.outlook.com (2603:10b6:5:190::35)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 21:50:08 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::34) by DM6PR11CA0022.outlook.office365.com
 (2603:10b6:5:190::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 21:50:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 21:50:08 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 15:50:06 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 2/5] drm/amdkfd: Bind MQD in GART with mtype RW
Date: Fri, 5 Dec 2025 16:49:19 -0500
Message-ID: <20251205214922.1095629-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251205214922.1095629-1-Philip.Yang@amd.com>
References: <20251205214922.1095629-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: bf62818d-0fd0-473b-42ee-08de344841ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QRpMotOlipgt2/JlnQ3PCZgR6HBoAdKIf0Kpv+8FJwaEzjZFb3MQ14x0uo8z?=
 =?us-ascii?Q?IdYln2gDNIZ3sDPrEZCJbecRk1MGVU9+37F/OAqsdXO2/WvzJOhFh5BDt1HI?=
 =?us-ascii?Q?nBbzbrELwSt5ZY4rqHfLf6glnFxmFwennv8cTx4WL3KQt4PNyvhcpvEeb+3N?=
 =?us-ascii?Q?JH8L7RoLI3VfYEhS1gXpU4NRXlzYUTE1cUWNGRn6grdmVopPCu+VDmMqbAJs?=
 =?us-ascii?Q?CwrQoEG8QprHEUN2vzjOrLm/gqXESD3ilq1RZjfgl3ewtYw69Kn4h3MxrZWv?=
 =?us-ascii?Q?CAe+magVLoU5IfIQJtH4osX1Xh6TqlOo57y2BGDshKH5X1fxIMN+LXVSJs9N?=
 =?us-ascii?Q?Ii2fT17s9wTjK+Ep7hADFe4e6QWFkof9YtD6lO3nbbAePTud0M39Y7ysxBR2?=
 =?us-ascii?Q?dcDhH2jVofHdoalAyuTuS6Y4DuQIza6AgeZPohu3xSVO+tJ9C+XQy8LTvSZc?=
 =?us-ascii?Q?z7odUTGesj+5S1vlKkI9B7j4G/o+/V0ecIUDkKZxgVWekspVW8m8dZNO745g?=
 =?us-ascii?Q?CSkqUCM32WhqsZeopYbTDtC6CsDGe/pmDiei03OZ0JTDCls8i6uAEhXB7K5Z?=
 =?us-ascii?Q?Nyj8JgAIn9jQsG2zIA03Tm4asLwCNCUNvnXXd23AW6CcEIUC0AjlZ9ak1dxN?=
 =?us-ascii?Q?sHtRqH+MxxE3I4SnXOMbkAfjviuibg76MWVYV0cR+YdtDBCagwsohibhNKmr?=
 =?us-ascii?Q?krAI5WEDXDcHRWm9sJ5VyEpwvabwJOJssupkfje2a0mkyPTGP4uQswu+HNob?=
 =?us-ascii?Q?CdZaVdYsJrf5AlBexnJg1Suk2nJvwSqNSX07ItNr6gS2qiVL+3yF71BiWQ9D?=
 =?us-ascii?Q?KPhPizJaP192asdUUChVj65x7NjF2wJHo1IShWpUvhshwwqojmYFY9q1g7Nn?=
 =?us-ascii?Q?VkLL5uobvCoLAeZsDrCDHmynlwlcPJnTOMcwkehpBdTKy+8UwQbBZMeRjiST?=
 =?us-ascii?Q?krReBgKyvodjt0n8VrrBQyVdBDI9qVcLUP+0SCZZGGlOdIcRG0c2OwH0UO6H?=
 =?us-ascii?Q?mIO3OrWTXporb310F1Zn34FsOoBafXM2dByvtAaY5N4uYZ6bFhpP2h7BMCOC?=
 =?us-ascii?Q?1iwMf7H0gz43dn7zN1PKUS8JaNECWAKe6/ZL9o/fJ02ZzUTrj3N2LbxFnCBp?=
 =?us-ascii?Q?RVm6KyAy8ExgzwscO24ObHBaDdbQ4Men8d6dEhc+6jPREKKvCamFxWo83A+k?=
 =?us-ascii?Q?k+IRAtKCflsRZT2oMIXIHcfCCYtPCkOVVFR8evlnDRgxsOhVQyt1j5GAgeo7?=
 =?us-ascii?Q?Z9JR/OY/RQVww5oekqMiPX7zZ3rYE2ixnY9+xzBfwwNJNoJRNhN4DDXdZGOc?=
 =?us-ascii?Q?PYtCNOwgzrJhchAfcKFyIMm5NG2UHG9RgXVxi14TsCfNXIfADdc2KPT9wvHD?=
 =?us-ascii?Q?SQx88mZvDrzUElptPHOa4XbymyGi479Ns1PG+1H/yUE0hNq3aEsTce1AEaWx?=
 =?us-ascii?Q?QwwTv2ZRSNjxG3da1e7doV7miE0wTZKv+251CxHa8i2NzdCV+ZLLSoFpN5tF?=
 =?us-ascii?Q?UrFeIFl+4wUf672JsR0mVCCBVn4QEdPKKY+1bYt5jJzggo16ZDXTAuywFVL8?=
 =?us-ascii?Q?oqgCfGbxwm084Y43xro=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:50:08.0858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf62818d-0fd0-473b-42ee-08de344841ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725
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

For gfx version >= 9.4.3, bind MQD in GART with mtype RW to enable
caching, to reduce queue switch latency.

Remove the redundant mtype definition in amdgpu_vm.h.

Call amdgpu_gmc_get_vm_pte with AMDGPU_VM_MTYPE_ to get ASIC specific
mtype.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 3 ---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 0f83d140b6ae..4f8bc7f35cdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -853,7 +853,12 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
 	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
 	uint64_t page_idx, pages_per_xcc;
 	int i;
-	uint64_t ctrl_flags = AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE_NC);
+	uint64_t ctrl_flags = flags;
+
+	amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, &ctrl_flags);
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 3))
+		amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_RW, &flags);
 
 	pages_per_xcc = total_pages;
 	do_div(pages_per_xcc, num_xcc);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 139642eacdd0..e34c8f854b2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -100,9 +100,6 @@ struct amdgpu_bo_vm;
 	(((uint64_t)(flags) & (~AMDGPU_PTE_MTYPE_VG10_MASK)) |	\
 	  AMDGPU_PTE_MTYPE_VG10_SHIFT(mtype))
 
-#define AMDGPU_MTYPE_NC 0
-#define AMDGPU_MTYPE_CC 2
-
 #define AMDGPU_PTE_DEFAULT_ATC  (AMDGPU_PTE_SYSTEM      \
                                 | AMDGPU_PTE_SNOOPED    \
                                 | AMDGPU_PTE_EXECUTABLE \
-- 
2.50.1

