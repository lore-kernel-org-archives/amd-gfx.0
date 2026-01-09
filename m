Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603A5D232EE
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 08:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0758310E814;
	Fri,  9 Jan 2026 08:25:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D8lLNb3g";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D68BD10E81D
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 08:25:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxigbQ19sFG8qbx53ut3j8WiWRl80q1bwlphOOgygKvcZ2yZsTCEXkBlLCISY7Q/k9j5MNVyIxMkm/6UqJ2W16aGvD+FavEQtDzIdjKPeXRL6BsF83YCzs+oRMbGx1NJEaP604ZORjbDIqGYkx7F0i68Q8M3awy/GBQ8blwyZiabb7ld3Gm1sfXMvLTERBqKtBAL+eD8WWvpoHXySz6E69kB3VsiBwB53g4vM9uPg1V/Q6jz2bGzKN9Si4Kbtiar7M+E8Qi66A9HqwPBrf37ZwFgogq61XGG1n331it7aD3+aFO23+ZdZ70MgaU+VUJvd14AoJLaHTCQ12u1areEoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duiFytRdiXjwMOSnanPI15N5wXX8U9c2pG53cXkK6aI=;
 b=jXTlBBA6yeVxSjbru9EvZjnDbr+n3bfopF8BgTNG8+VlQudpnQVqMEHg0BYC2T9EAg2G0WfZ4KtmMhM3eUv/ZrkUiBux3VhEWWpzN6bXo6+QoJcdP4pAbOuTvTPuUG1mfoJxlH57C/EQtH0uqWpadoeywjFNsLcmGL9EXQFUnC90Lrh2tCeRXUuP9UmEd9/AOKFtbBcG1TtXXw3NJeHUPgHrTBzSoUURoo2UkjH1+PQcDD2fgEYbVldRJP7dnkAbyNeV2pbcuj21UfF7h96Tw+0DH74popNhulbxa/n+0DKM2yQDdQBv3zUYQJq6USt3q+sqQOJqLHdN35HGlQxwIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duiFytRdiXjwMOSnanPI15N5wXX8U9c2pG53cXkK6aI=;
 b=D8lLNb3gA89y7TRx4mY9H/fCUc7w5hGo9R9mmsgESkbMGPm4786XFewcbIuC9vYN9F5zIXfZtDZTh1/L3+13IL6kSunjqZICNqUXbTR2/pwaW9bIRbI4Cc8exYjcpNYJfYLHFDbDbgvou0O6aut2OxuikNSQo15f5QgZc8j+fLw=
Received: from BN9P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::33)
 by CH1PPF711010B62.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::614) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Fri, 9 Jan
 2026 08:25:36 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:10b:cafe::37) by BN9P223CA0028.outlook.office365.com
 (2603:10b6:408:10b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Fri, 9
 Jan 2026 08:25:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 08:25:36 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 02:25:34 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, <phil@jpmr.org>, 
 Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 1/2] Revert "drm/amdgpu: don't attach the tlb fence for SI"
Date: Fri, 9 Jan 2026 16:25:22 +0800
Message-ID: <20260109082523.889564-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|CH1PPF711010B62:EE_
X-MS-Office365-Filtering-Correlation-Id: c483b3ae-c716-4eab-8418-08de4f58aa1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2FpdUxuQ2d1NXZJTTJ0K1JkNSsrV3ZKcG9sMEh0bGFoM3ljS0dxQ2lDa3gv?=
 =?utf-8?B?NTkzUmtqQTUwOXBhMG5uTWtuT3JKYmg1d3I5NFd5N2V0ZFdUNC9INzBpNC9l?=
 =?utf-8?B?dFU2SjJHM0xwYTNXdEZYdnVLL2wxQkZyTnZNdVlnTEhnL3RqZFlrditPZ3JZ?=
 =?utf-8?B?VXVjSXgwbTYxUEtxcXJ1TTBNMTcrVG1tYytQRzJmN3V4azVQQlY0SFJHMHBs?=
 =?utf-8?B?SWRBcTdMWU0vdTVXaHpDbjRndjBEd1BKamdTY0hWb1RkRmUvaXRQc1BqQ0Jp?=
 =?utf-8?B?S0hCemliR3ppalJFUzF4M0ZFaUlNMFFOVDZZeGJqM3h3T28zMFhxSmxEYnZE?=
 =?utf-8?B?aWlXL3pUb2RTazhIbVJxekRrSmVYT0pUMGRQR1BremJ3OXd0WmxsUlFWbHln?=
 =?utf-8?B?OXRvbzRrWlV6ejNPRVNHblduYVhmMk5KeW5veS9JYXd3UGdQVmtmVkdmRzU2?=
 =?utf-8?B?WmxNQ0l0SFY3d2tXN0hqNzNPYjByMlNBcGxxNFcyWWQ4Z3g4Mi9PMVZZUDNU?=
 =?utf-8?B?VmFlSTg1ZDNtZHpjbkpvOFBDekh5MkR6K1VnWEZnMXIwckRMU0R4b3dxVlFS?=
 =?utf-8?B?OVdBTERWOUZoQTZ1V2pIUldFSzQwL0tJbk9NdFZXOHNZdWt3TFVqZHBmcEhL?=
 =?utf-8?B?eFV5SzV5bk9UQVRScmVMNzBDOEsyTytORUY1dWJ4S292WWpMRUFKUkhTeGpu?=
 =?utf-8?B?Q1l1RDJBUzJsRmZnMnYrdWU1SmZTNDZIYVZvQWZBYVhuQmJ6dnE3eVhPVlc4?=
 =?utf-8?B?Ulh2WTE2RXdRUkd4UmFMSmUwUTBYelVKSTV3ZjBZRGZYOXlPZ08zMXB4ZVdj?=
 =?utf-8?B?Kyt5NjZkemkvTitOcmNVcnh4VTEzQnFWdVUwSm54VExYUEM5blNXNzhqVkhy?=
 =?utf-8?B?N0RsblhBWCtITGVjcHpscHpURVZic3h2ZFV5QTc4NW1RSmVxcllJc29oaFda?=
 =?utf-8?B?L3JZNFc0VE9icXFLMUhEOWZkYU5wRkd1UG9ZeFZKU2lHUkN4c0c1RU9XdERK?=
 =?utf-8?B?WnArbEtvdXB1YXdCc1dhSHFycVV0YkRPWlE1YVVaOERyNGZmSExKV0RhTnA2?=
 =?utf-8?B?N0pWMy9jaTZLS3lRR25yb051dmlkYXVqbncyYlZ2MzR6VVJteFMrOFdmejFB?=
 =?utf-8?B?azVHRmhyV1FSZHZLanR1dHJMdy9HNEFia3FSVWU0NjRycWZ6blhEeGpkekpK?=
 =?utf-8?B?NW1qYlZ3QjFYem9Qdmw0K3BKeVpPRFV6blB3N01kS0pQZk9PWjZmL2YwcFln?=
 =?utf-8?B?bVlNbzUrY2tweUZTd3Jsa3EwbXVhTVRFQzRGdWIrcDl5VGxXeG5EUi92NzdO?=
 =?utf-8?B?VGhtR3RrYlFUSTFzbkJNS3J6dnphWnhoZmhidnVUK0xaSjJxR09TdHpwZGtC?=
 =?utf-8?B?Z21yK3YzdTlzWGxPM1lQeHdxcFIyZ2VlZlZVRGYzZVhGUG9qMm9ZSFNsV0d4?=
 =?utf-8?B?MXpEN0ExaXlqZ1AweTc3QlUyRzRFM2pGMUU0OUJqU3ZXOVVIUTNTU3lQVlJV?=
 =?utf-8?B?TFdyNDdtS2R3OGlTemdhYzg1TVNKQ1RDMXpFRDRNYmlFUjFTUE01RDJWSDVT?=
 =?utf-8?B?Mm1XYU13UDF3VEMyRGYyam5uQnVVRGZmelNUZlRvaGxMYjBHKzA1TDI0MnNq?=
 =?utf-8?B?ZHVPSVpoYVdyQVNiMDdWaEE4clVNUHFTU3RZQzN2SitTQnA5SnhLN3V3YTlU?=
 =?utf-8?B?dHBybnJsWnYyMVozL2hQL1JuMFAvcXJLMkxrUjZzNUFVem53YW9DTUZSN1Na?=
 =?utf-8?B?NklGYkduZGdOTFoyb2FQcXRmRDNJWnhSYXFvSUc4eUdLQUpMd0loZUFiMTFG?=
 =?utf-8?B?dUltayt3OHBJSnJ1SlVRd2tWTmZGRDhCRlIwTGl5QXZjSnpieWlZWE5GS0VG?=
 =?utf-8?B?NURQd0RtS0djeHp3MFBERmQ5YmRlL1AxY2lKZ3J6NTNCMVNpSDNtNVVQalk3?=
 =?utf-8?B?aFFUeTkvYlBpa2NyUHFqUHJDdGVNcHRsZFloQmFMelhLaDFLb1dhTXh2ZEFT?=
 =?utf-8?B?T1pwSlMyRFREaVgwL2VYdnFvRjRTdVYzL094Z1puUVY3ZUVrMzEvblJReDVo?=
 =?utf-8?B?bDc5MG85d01NYm9JZWtFWW9JMUlxMFFzN2F5NFFwNDA0di9QKzRyaXJVMnhN?=
 =?utf-8?Q?ckf0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 08:25:36.2603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c483b3ae-c716-4eab-8418-08de4f58aa1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF711010B62
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

This reverts commit 47d28900bc2049379b28656cf1e527aa8598925b.

It’s better to validate VM TLB flushes in the flush‑TLB backend
rather than in the generic VM layer.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0eccb31793ca..6a2ea200d90c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1069,9 +1069,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 	}
 
 	/* Prepare a TLB flush fence to be attached to PTs */
-	if (!params->unlocked &&
-	    /* SI doesn't support pasid or KIQ/MES */
-	    params->adev->family > AMDGPU_FAMILY_SI) {
+	if (!params->unlocked) {
 		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
 
 		/* Makes sure no PD/PT is freed before the flush */
-- 
2.34.1

