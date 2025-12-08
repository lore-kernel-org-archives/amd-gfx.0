Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9FAD3B7EA
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 17:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0A8710E4A5;
	Mon,  8 Dec 2025 17:17:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OvrC4B8O";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1915010E499
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 17:17:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snqeLg1Al5XMEDdtgOammfPix1EkUr1+xWLDeS19OSrZspZuPokfRD2gpp/ZupwX7fvF0XCQQ/52PDP9A89eWLMjvvDgpiX68wgZCGpQdqPyd25072xhrfy6Gk+r38XvWowDLfNDoYySVF9gLD4KcQcRpGSEynWcg5i8jTlAnf6gX7pHB02uw1gUi9DkkVF02xMjCs1AJUHoBVtOjri69+Aajsnqy8pAz2x9bXOBJO+Mxv3nPIgz4srdDwFZTpm0E1WewXdsGozrZkZCjg1hVLNKp47WKbTOjpdU9VxooPs51gva1BMfNwDhNsY9ATFUTDuBwAAMqlY4W6MpTm4XIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBK0CkKbtSzEvYxrFoZgFfCDQ+Fnx2Q7UtQC7XGvO2s=;
 b=aoCJoyko4B9Enky23eG8R+hjcEhrcFXK1QeDtLaQAgDg1jki3WhFdB+6ZVaHY+Ln8Y7CuvTbNZTbBxb5pkYzOuWoCNALlhhkiXPV9olYuciAkkQOTkUDZYlYEF9apC63GRUN2gMntqVly7fjNgZjnaeFTMM6vEHibGxbIxLq9KEHXm8JX+0lMBdiNZb9Kf4AQp9ZBTw8jvgV+KBkDhLHV2+igt59AXVYPe+0kX45OlsiJei4SNiDm7vzCEs0g+EyeLR+V3jm8I288VZfqDNU6WcxH+6a8jIoYt1jPg84FfSxLGSb4Cf8Mr859zuiqp55vgINSqpXnz34VMrmnwsx8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBK0CkKbtSzEvYxrFoZgFfCDQ+Fnx2Q7UtQC7XGvO2s=;
 b=OvrC4B8OJONHqumL7IEw4gPFet4WxmqrqbKeAi3UUm/hpuEsiE0KcHVN/dD/woArucmrwMG5NhbExyAXSjSCmBiAAdOVSA+Ez6kNZt0My0vu34wfl6mY4zfuUAHJGyZQhyEi4cJ3oWMGQOFbpPlyxvlhRHsRbKJ+EmeDHdLHL6I=
Received: from SJ0PR13CA0230.namprd13.prod.outlook.com (2603:10b6:a03:2c1::25)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 17:17:49 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::7c) by SJ0PR13CA0230.outlook.office365.com
 (2603:10b6:a03:2c1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Mon, 8
 Dec 2025 17:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 8 Dec 2025 17:17:48 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 11:17:44 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Initialize memory partition callbacks for gmc
 v12_1
Date: Mon, 8 Dec 2025 12:17:09 -0500
Message-ID: <20251208171720.153355-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208171720.153355-1-alexander.deucher@amd.com>
References: <20251208171720.153355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|MN2PR12MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f981df-c4f8-4f7d-c5da-08de367db613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2RIvsN+qzn8fFtIqFt5EnMGJQplUvd5ICOMZIyxJsDP8+2dVvebPYNevktWi?=
 =?us-ascii?Q?8gDcThRhLd9/HQU7HR5OxMt88O50/AfbG4n/AXfnzhxLp40tzcroV9yCs96F?=
 =?us-ascii?Q?nqUia34PdFKFJj5IDScZU8BNP5MPuEHRdeUg0WK+YWbtwDET2cDKIPm5e591?=
 =?us-ascii?Q?PxdoW7QXyNOiifFIoy1FuJC/+3CUodxyCvEzHBVaHGJwMic/4iKd9YmBKVQW?=
 =?us-ascii?Q?isJq6v6NfM4V0/1Wy0nv/fI0LyoeavpWd/gBLYpdae5QmbxDdR2QRmmp/Lpb?=
 =?us-ascii?Q?yFkE0w84oXVBPZCrssg467Yo3crr/UWaenOglsxEp7pZg08Q8psOWAIrYtbV?=
 =?us-ascii?Q?T8NP+ELTwIsYcidtcINUNIt4uhCOg6vBFRWcF7UXg6xGXixKAaUpk8jw2G6h?=
 =?us-ascii?Q?I6cOuAL/Fh6/n8PnAxwqkJF0hRY09sJfrNA+FzXx9En3DgQAlcwa33mgWVSz?=
 =?us-ascii?Q?F3I2esaeLO7HHcevEjPLOM+IKmXzwVzFX0fjwiAA3hp2oBeOtuoSoQOY63pW?=
 =?us-ascii?Q?ZdqJIf1hAviYeSU6Qq8NXIVCUgum2el/u8YnQ5rSFjWlhNHFd65HsB06YBsc?=
 =?us-ascii?Q?maOgJJaGyxWyOiDaZ/U9gDMkDIHbYsfGIQgTgcH7u27lEufb0oVAIn1gB8Kt?=
 =?us-ascii?Q?13oaLPP3OU0CO34YcWduxpv4x4Qr0RW4WIc8SAV78fohM75KFtHpLv6PSrBD?=
 =?us-ascii?Q?s5jGDJiOeuTpZxy+otxEL0lMjI17Anrw+KUc1mPTPEGElyw3n7s3kjGy8xPP?=
 =?us-ascii?Q?XtOavhsSvvKn02Pq6mX0NGFHcpr4/r7IAyiU2N6kIumUEtWBTdkwCbZzOoc8?=
 =?us-ascii?Q?pyEvl8rej0J+xCe9jESyRXZVMQnxEAGV1S/gffXEbOTFajD60wyh+XUGeEU6?=
 =?us-ascii?Q?cDoYg0XK+4Z4F/0vED62y1f3bJ7GVVNefHiMje0KFYmtZQek4+sZ1NVj9/2n?=
 =?us-ascii?Q?EATQAIB+E9vUzTrJ5NCRUXhM56IGdzuGomdj+UQl+HXY4iKSdueaDfHueaUo?=
 =?us-ascii?Q?Y4nDY6CAS38OKsi2g9nDz3m58GJ+7y7UlemEV1ZS8s6ck3SLIwtmWLh4MmpV?=
 =?us-ascii?Q?vo96S07JP2amRt4c6MYydn4BGldo9vwAbakUbRKtyKhp1X21tlb4Dt52KO70?=
 =?us-ascii?Q?PdRV6SjjsDLOA/aLeArTGHGVKNBIk2Pts42O87HxaTmsq2iCKsdp9T+wpYuP?=
 =?us-ascii?Q?LU2Fe9IgoVap3HoQDpCO80ueBWi/AJvdo4PGc/gANmv3nuD2MGYmVBWXXFjm?=
 =?us-ascii?Q?fbJcspOZKWtoZlKZsBEiMJn383ss4x3QtOFfH44Pz7H6QdAln2FFjPYqz302?=
 =?us-ascii?Q?MJlf6bCM/a7G1f3pteuKZRL5mIwXXtLwcLFsKhGslCLyybm/slUCbYHRtDVp?=
 =?us-ascii?Q?/XiCd2yYMSWPiIWModaqEjtqY0VbDhVEI6O/qX73iGwwPsFCwc7/cV/HoCFY?=
 =?us-ascii?Q?c5Oo/pkMlyIuGhPQJw+58I7YcFWvG6Oz/r1ckTrq6LNsNAOtvE7ynTM94fkY?=
 =?us-ascii?Q?dmrmAZ7L9VjjjzfDvnB6QX2kfeKR4oJgCZhWQGzgMr5F/RdCAnnXRJiplqpX?=
 =?us-ascii?Q?0x8ZCs1+hlu1flzPzsA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 17:17:48.5416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f981df-c4f8-4f7d-c5da-08de367db613
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Initialize memory partition callbacks for gmv v12_1

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 55f77520df2f9..50208a3456a15 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -578,6 +578,8 @@ static const struct amdgpu_gmc_funcs gmc_v12_1_gmc_funcs = {
 	.emit_pasid_mapping = gmc_v12_1_emit_pasid_mapping,
 	.get_vm_pde = gmc_v12_1_get_vm_pde,
 	.get_vm_pte = gmc_v12_1_get_vm_pte,
+	.query_mem_partition_mode = &amdgpu_gmc_query_memory_partition,
+	.request_mem_partition_mode = &amdgpu_gmc_request_memory_partition,
 };
 
 void gmc_v12_1_set_gmc_funcs(struct amdgpu_device *adev)
-- 
2.51.1

