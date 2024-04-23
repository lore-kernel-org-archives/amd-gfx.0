Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37823C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 18:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80E231135BC;
	Tue, 23 Apr 2024 18:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dCKSuQWt";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCEBC1135BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 18:57:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMtMlwRKFsvn1aR3i0PGa3jhjqt6BZGxyRF4GHxLNaf1ceX0/l+gbLwu2w9rHh1oFCk/ydM3DUoMuewKBFnbsRcvIrMNFnGlkOaF1D6wOg6oHEfc38zTeElSM2n5cCvA7NiZoyshKsGUIiPZyEFb6eqq5dz/bzFHNi3HnZsrv61zsR0CZqUOdqt2IkKQkBXOGd4IhwZSdoVosT95yKg8DqniSeZWdwMBeZ+e5vCK38HCnzm9g+jKd59H+7Mht3ihTlYofLQXbmtjLqvNNtCOLM6Dy2LUtVpiL2gB/+Qvc3vIdosV/7kalIGUnbi9aghv/mHUwK4GGWhWwLcpmq779g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATk1TuRMoLgKKX+udW827A0/3X0xB4fybRN9NHBKVDk=;
 b=QlhHjjwTOGu7L0I4F8rkPX0gVzK7l+zh3C8nF86fGrh+NkPJ4IyXJ9+Lo16GHuUdJnbPRsXSTIet7zrowradW+duAWoLyD7Mxvdx57+0MMwXHWP88lRryYB+fhbBrgmzkVKim453Q7RtM6GkVlP+thsZwEVPUb7G76utXi0NAI9m4vq55DbkUJR34V6cHC9f+3oEdZ1xAS++67gXFmeDChQoRWaHqLfUoISHkFlZKvfB44OFvRPSc8TRKQIVMgKiTs44Z/r5HqAEIutZuRxFYG0u4mDrhJ4C2fyKqK3pUDg9u7woSiQy1ZewRt0Oukf7YTza3lTfrPK3eLN1ZFiGfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATk1TuRMoLgKKX+udW827A0/3X0xB4fybRN9NHBKVDk=;
 b=dCKSuQWtjUTNcTAUUbziD2WjCRaMej2fvhJS4GZkrcCuRL38jAVh8QwZPdGPLtD1iTZqMuM0+gDi406vg5TKJ5SZAQBa6U4D4svUovsiG6Dn8k1gK6NrIbb2Fh4kxXmMP/1EgE0uNDXZnuoeiD93PU1oSZ0pW0TauqeK24uykuk=
Received: from CH2PR05CA0070.namprd05.prod.outlook.com (2603:10b6:610:38::47)
 by DS0PR12MB6488.namprd12.prod.outlook.com (2603:10b6:8:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.45; Tue, 23 Apr
 2024 18:57:03 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::4c) by CH2PR05CA0070.outlook.office365.com
 (2603:10b6:610:38::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Tue, 23 Apr 2024 18:57:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 18:57:03 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 23 Apr
 2024 13:57:01 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH] drm/amdgpu: Fix VRAM memory accounting
Date: Tue, 23 Apr 2024 14:56:50 -0400
Message-ID: <20240423185650.1496279-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|DS0PR12MB6488:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7b8e85-1f08-4aa4-d396-08dc63c729d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fou+treoekGEr4un8RwFBKYaE9CIF+9NKM3bhTECIHWtPP/pzKXeHXL76N4O?=
 =?us-ascii?Q?mdZ5iKd9YUYc3wJ7CdpPjVGLX+sVWrairOdC3VGZINJ+3i8WteIfHB/7Eo8X?=
 =?us-ascii?Q?Hr2oBscHHw4/NxGdR0FzZ4VlN/5yXTErgpJqnO8B1Z1ZoHFCtB5Ap0miNurD?=
 =?us-ascii?Q?69+BAXCi0ozIUxhfnMqgOkX8k7HNQ8ZyrverEaOuHG9nIOsEPYuDwGm3ZGEh?=
 =?us-ascii?Q?Gmr0Ui6TJtmSkdUeNe7y7sCvZg79LwGt7GzJBx5e9l8yeDnn9qPs/cBJ7JKh?=
 =?us-ascii?Q?OLEUvvMCa4hl+Cj57ohmIwpgHtPJHNO1h9nVkw0ZuQg1/Q45jfuE7F5L+y/c?=
 =?us-ascii?Q?WGHbaKoD4szLnfI/aGAYtc5ktrZ7oDbRSykMz/2u78tO6PHUbVf6F1uMX/Ja?=
 =?us-ascii?Q?KfDmVvqRvu1j70ZnCyYf777UJLctQSVlj+MBAxf9b3AMLwX82x6KkXs5D1AF?=
 =?us-ascii?Q?9OoK6RxMEqjj23bwFsb3M2ODLdCogABgI60TvLswgeo3zlCCimjYiRsqk1df?=
 =?us-ascii?Q?FqEe3azJ1pA8vN91gMmX1ijYi+s8X50hvEsTPq00Dxxu4GRVQi3A7xuhhwA0?=
 =?us-ascii?Q?1kHXwGut/8yioYUuuTtjCFKLWpD73V3FJg7dWsruTa0+ZT3XsruQKrJQpuxs?=
 =?us-ascii?Q?oUPpfFc5+E8tMLWjO/vApRL5XxHH2jspya/ss3RZaBcEIyQXdodvrfF/IJed?=
 =?us-ascii?Q?ep4HJj+9RCALitUVF12wzuO1iEUe72GaSUSrRrz2iIYgeP0LhaFyDYEIsHkN?=
 =?us-ascii?Q?A3JNFsfsyQKwIfoeMTzXlyXeX5ITbH9K1nCBn9iEMZWqEWES+eJXh58SkLC5?=
 =?us-ascii?Q?VbH2BRUm/9sjXbi0bl3bcaUVo3YvgPVCESTc9y230r5b0skH6l4BoFgByjlA?=
 =?us-ascii?Q?M0/6uFE1wzGVuAIi52fF20IfXd5DPctRKaOw4ayaxIYmrz7Wd+/EdMC4z2Wt?=
 =?us-ascii?Q?UYtl7n+JsNv+FdgKhrIUttvuNEC/94ToywWDxrhjZvMd34+VU7ixPnsXvHwc?=
 =?us-ascii?Q?6kDVtuLlwthhIdkwrZWSJ0J270CnLvdl427FI6rnmrMWUuBuU4v+8Jf7To8U?=
 =?us-ascii?Q?GxWUh2FI50C+dChm5A3lpTy7cr7xOH+bVvyI/7ixJQDC3P1irMSCvAWk3I6l?=
 =?us-ascii?Q?6WKoK7E+MjutJY04GWcysvqvIKwL79k/QEeMn50P6AyBH0Iks5cMHnPwKoy7?=
 =?us-ascii?Q?wMXpHleaEykk1wrl7aCHH/JP6UPGYqJr8BJr1ykqkomBtPoT51x611/xnhsT?=
 =?us-ascii?Q?+ZEtsf1LpqrRg+5j8qB0Eb1NSQX9Hc1kG6IKQP6xnNWRFvXler7tznGCkfl5?=
 =?us-ascii?Q?RPZdViuD5zJ19EHuuMA1/kJmUvR5rm8cfH3ibmrHqXfdrCRMgrjJdIRPyD+h?=
 =?us-ascii?Q?tZWsuoFk/pf6D/VeHvnVpJ+1PkJz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 18:57:03.0532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7b8e85-1f08-4aa4-d396-08dc63c729d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6488
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

Subtract the VRAM pinned memory when checking for available memory
in amdgpu_amdkfd_reserve_mem_limit function since that memory is not
available for use.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 101a2836480d..f672205243e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -220,7 +220,7 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
 	     kfd_mem_limit.max_ttm_mem_limit) ||
 	    (adev && xcp_id >= 0 && adev->kfd.vram_used[xcp_id] + vram_needed >
-	     vram_size - reserved_for_pt)) {
+	     vram_size - reserved_for_pt - atomic64_read(&adev->vram_pin_size))) {
 		ret = -ENOMEM;
 		goto release;
 	}
-- 
2.35.1

