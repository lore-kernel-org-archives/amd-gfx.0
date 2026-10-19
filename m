Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB0ECCF2E5
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 14:25:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AECB10ED82;
	Mon, 19 Oct 2026 14:24:54 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB3E210ED82
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 14:24:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mk7/YSNO8ykoQhGC3sT/xfeGyV1kWwOxMAedDt3ecF4GseLRtZjinSVTPaLsIqMBCILOHbjMBLHmoGN0l1c0yxhD31HzsglbG8Jd8pMmnqA7m927LhWElY/Kd+xLuymQael/drmGw7sUx7KVHMwd84KIG4ZC9lsqGOsbFAY1lSqnvRk0MrHCXLx9R4sN6u8oryrJecqikV9eia8Koc5Y99Eop+NQ9z2BZ22PlfMXyBqo4zKqxfT99b6xnZbI4nElThZl0yHPnOr8SsAK2bJkzGsYO75ryhKXQK+n551BqObsuEP17gub+Inq+bs3tIevLSy8POjv/XelDciKahRy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJ0ZEmVE8nyTmEXJReBGGjWW/5K5PuOPBsQp/cDaq1k=;
 b=KKw76205On5yjQmSF6dFmNGNSe02i26r8YEb+IfAD6JOjujJuKOvA6NHmMYdEqGqhQzZo61q5jR0edBZraWPinD/63p+HZ7j3jBL+KsVIvSlkUvlS/iHirF7O1lzttyKvnMnMPd2NZrJ7GZAFsNgjm3eFwo7WsGx+vX7jxaa49TSu9MgJJXcKgDBPPRmVvrzq5B5jMHkhTE/JrB4M9NER75MxqPyZHtcnxwyZbWppnmVfkW+PZU2NzAv2rleEXmVhQyyuoipNZkP48u97Y3gUbv1cH6CQ6uKEsY3LFypwK7uzGKIkNPHDIBkmbhPT/J574vYGNV4usDyphd3+Lda6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJ0ZEmVE8nyTmEXJReBGGjWW/5K5PuOPBsQp/cDaq1k=;
 b=WSqsRazR3SgmLjYHcO1ERnm3PlqrMU7UUX8J7aa0uo7bvV5jJ/v4lCCmJ4Lb6mi47W2Bd7cpgLYo8gaaZrhq5osWzITMvKiojQ5FUAMMcs6jlZjsBrJSvbjEpluib5QRumErusKKy97TkJiC992JjuNjDKSx4LBsm5yvML4bwAs=
Received: from BN0PR04CA0155.namprd04.prod.outlook.com (2603:10b6:408:eb::10)
 by SN7PR12MB8818.namprd12.prod.outlook.com (2603:10b6:806:34b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 14:24:40 +0000
Received: from BN2PEPF0000A892.namprd04.prod.outlook.com
 (2603:10b6:408:eb:cafe::42) by BN0PR04CA0155.outlook.office365.com
 (2603:10b6:408:eb::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 14:24:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A892.mail.protection.outlook.com (10.167.248.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 14:24:39 +0000
Received: from rocm-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Mon, 19 Oct 2026 09:24:32 -0500
From: Zichuan Guan <zichuan.guan@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
CC: <amd-gfx@lists.freedesktop.org>, Benjamin Cheng <benjamin.cheng@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>,
 Zichuan Guan <zichuan.guan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix TLB invalidation fence handling
Date: Mon, 19 Oct 2026 10:24:03 -0400
Message-ID: <20261019142403.2263837-1-zichuan.guan@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <fc732112-75da-4775-8d70-a995d110ea4c@gmail.com>
References: <fc732112-75da-4775-8d70-a995d110ea4c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A892:EE_|SN7PR12MB8818:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9c894e-1745-42c3-39ab-08df2decb605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4CKAl5RLvWABOSDR/2sXah7SPZYd8eHF8BRZ1g9xcOTXydcNfhgzZrA/Ln4U5nFgoVEN/BTYxtA/Jza32ZyFB9hIJJOYX1oPEJ8h2zPcMsI7HSDh3dvCjOF2ag8rGTuLStAws0speGS68OybfBIXqbM73k53BlRsPE+IWt5ToIbIw6O+xWu25QtnyNIdLkH87Rc3WiMVUj6RmVKSoxrk1gEEAirTr5qmqzQ4wBSYgclI4AYHJVJlbC2WIap/YaoG/cgHsRDhF1L6IHuIQaSU8LAPZF+FznagUxyM/dA1fmtHg49CL3s0kVa8MlGpHJnq8IrhiXzPf5/lhSmbdZDsNh9zb8nzrH9CDODGso+qxxgvbP5Ek85GLOR/KZFMERl/STs0YxZyczGCQD4m0inyEqyok7pVl3l3Iyg0+B8TxNndLTLU0DFZX2MQ5ILA79uszYZexwpW0p0R4aHpgdQLGO73+wZYFJK5KX/u/RlHVkQiT1fBvthkaCzYj5BlbHoIsILn5rjTa8DFlx4AJ+ewFsNgaccz1bGrRjkI6ZySXmuPtPW7slYDA5PnrUcXTIiHDwHAZY/FggYaEKpigihSvEJ0cAdqWGwihqrHb1iyr2dY9CXytl5Hqmlpkkw9XGNgTDfuliJ7gHKZGWLZvdKldSVcpmv4aXt3j4y/MXJ5HbI6OIXnucYQXB7NkgcYGW4M3FrvB8+5SNMoC58AJoWuCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rego8uLRAP4oGoXMuaXOIx6mJS2cOPt9ZEbbuKnop+L+3B1X6jwYzw6uBIaJOvVaYrkzfGS562pAA5nEQLQ4yxt4yLW63b2dw4pD7EDNncFOnlsKpDCH3cNdJQjSqoBIRjq95Ug3qT1fRbXvIiJsfPiHnlfCbZEu9t3KrULU/qNSKCDfRdVi5WpNvIoIrKT661oXHl5l0BNaPPZv2iBEI1qKmaoysMrl54tbYOqw8sQ0W6z24/kEAZREJBHBKIG4K8pYN6udmez+mXgPDbdHIYyKkAoM//p+aGkn55EQDeGTgkKlrwjT91TuBeWLyp0b+yISjUUjJqb9f6vLcZ2KdRUtMRV6tBcN+3t5Xz/DRCTIy6NDflN/9tqoWKl/r577vXAdozpJtnA/4HisgYi1sb0kI48ZRXYLn3sTTXEEOZ76LFx3wszVyOpDsbQrFU4n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 14:24:39.8803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9c894e-1745-42c3-39ab-08df2decb605
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A892.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8818
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

Hi Christian,

On top of Benjamin's note, we found a reference leak while testing this
on gfx1151 (Strix Halo, CPU page table updates for compute VMs),
backported to 6.17 together with Benjamin's "wait for tlb flush before
freeing BO".

amdgpu_vm_tlb_fence_create() now writes into &vm->last_tlb_inv. The
final "*fence = &f->base;" overwrites the previous fence without dropping
its reference, so every TLB flush leaks one fence. With the series
applied, kmalloc-128 grew by about 40 objects per process and never
leveled off. It stopped growing with:

	dma_fence_put(*fence);
	*fence = &f->base;

With this series, the page faults we saw in the rocm-examples hipThreads
examples (Libraries/hipThreads) on gfx1151 are gone. This is important for
APUs running oem kernels without dkms, hope it gets upstreamed smoothly!

Thanks,
Zichuan
