Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB119CCD185
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 18:25:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4556B10EC70;
	Fri, 10 Oct 2025 18:25:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MnPQ7YvZ";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010030.outbound.protection.outlook.com
 [40.93.198.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46EA210EC6C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 18:24:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WY7WK841cR52GmQKSBb5M3etdNqq7f5tZ7LoX/ZaWz3FsuJMjOaBKZOG3f+i7vRhj/a4AgZp4Mqaos0/VaUJoTj351/3s9D/Y6FWuMtvIJFZcxzTbehHSIbl9zus98gc5Nc2AyzfMoze7XfTbv7b6HiyIQEx7o1HxvN2QwxRC9X0UN3VLCgpt7OTlySv4/slJNHABXIa3Ah9tfUOsTHqzY1R2wZHZoFre505Qo8p6THlgTXimTx1IS6aK2qE4fTdTgy2Zz3Tb+NQhjCkyUeJcEzFZhJN+hp+IGKAaUFyxlXSDFSuka7Pks1wNF0/f+trxa7EfTt9HOKqbGpFrmWawA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oE5ta2lABU9EOf/72SV6g4ALE7jonhGxHdE0xvWMmN4=;
 b=izdN4FNHMbIFFrdQixJkUrckvUOLLUZNWvKxW6TdiK5UHgRrinzrXt3oo4IHPumfOllbUm8tDi3TNfOd8yQBHLF5zZSEOf9Kc6hOw0PJD9dZBarbaJXIUW3/IIjiVrlXmZaxKtBBY+WvMHXsmY4WsR7OcSvDtDAYDrKDIkvp0cJeKXPGSUAmzcRf8LoG03bQljtwLDWOlKx0AkyUcgiCVRGh2pI+0pbhnfwH87WXo7iYGRsDIU7zm2N5CVZnRv4mFgFc6H2PtPIU5bu1niNrjdshToMLjDeD/nrLeuCdjHtFRNXTSMmhHtPiw/dDEY/WuCE8eessLlDV4CK5xjmHeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oE5ta2lABU9EOf/72SV6g4ALE7jonhGxHdE0xvWMmN4=;
 b=MnPQ7YvZOjDByvduzCNp4jcR1Dlik40CL3zlBaP5G8trJTb909cQYoWBAc5l/ECuFMZIFGAPNKur8WZ7+JliMKhRy7wIwTwjG9rH7VrTn9r7k+Cu1ZMvMDT/tnI+yvReRGpLmXBw8l5cyAdPt3unDxAfzE+XQhe9f4757Ajuulk=
Received: from BL1PR13CA0016.namprd13.prod.outlook.com (2603:10b6:208:256::21)
 by DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 18:24:50 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::2d) by BL1PR13CA0016.outlook.office365.com
 (2603:10b6:208:256::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7 via Frontend Transport; Fri,
 10 Oct 2025 18:24:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 18:24:50 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 10 Oct 2025 11:24:48 -0700
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Zhang Jesse <Jesse.Zhang@amd.com>,
 "Sathishkumar S" <sathishkumar.sundararaju@amd.com>
Subject: [PATCH] drm/amdgpu: fix bit shift logic
Date: Fri, 10 Oct 2025 23:54:18 +0530
Message-ID: <20251010182418.648766-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|DM3PR12MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c60074-eda7-4a7f-d7af-08de082a4cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFBTNm1KNzVXZ1ZYcUt0ZnNJYVFuMDJhUkVDai9OdzJyOWtzZHYxdHBTalBl?=
 =?utf-8?B?eVN5aStIYnhDckNseTMxNVF3Z2R5ZjkreUVKVktiV2x2NCt3L0d2aTh3VUFS?=
 =?utf-8?B?cjBSeWNBSWZ4YW40RkdoUklSRlhGUDVscUJTMUk4R3RFR3JTQmxlTHRDYTRC?=
 =?utf-8?B?NDA0dHZWME14Rm1RKzJYc3J1WVhiazhqa1FtWkVod3E0bU1NNjM4S2ozU0ZN?=
 =?utf-8?B?alBPSWlISWpYdlg0K1RFY3luL2liNVZ4OTZURTZDQ3ZuTGZXeERTS1JyNjJ3?=
 =?utf-8?B?WjYzL0NGZ2NYS2E4VC84R1FkUDNxZWdidW9DZXV3VE5rL0NteFRmNFdmdmp2?=
 =?utf-8?B?dmw4MmJnclNRSzdQZzhpSEp1RFVzV1NmSC96SW9WSDlyb3k0TjdleEtpK1Fq?=
 =?utf-8?B?Y04ydVF1NjdWK1kwbHUyV0UrWlRNWFhWUU5IanJvMVFoYkY1V29mTVdMMnk0?=
 =?utf-8?B?MXIwQ0RwUTFGNnJkU05ERW9oY3NjRVBDUDhxYTZ6VDhZbUhFeXZwMndmZEc2?=
 =?utf-8?B?UDNzbEVzazlicXFMMW1lK0sxQmN6VzVhenFPUW94a2tCZllEdlVzbElsZ3lH?=
 =?utf-8?B?ZWtUblRKS0lGSE9UTGZUbkNGVm9EZFA1MndpRjJQcnJCYU9MQU53TkJqK1Rl?=
 =?utf-8?B?VXB0QUk4R3dhcWU5VCttb3cwcXV4YTN4b0xBNEt0akZrcjlCWVFESzZhU01S?=
 =?utf-8?B?SGlyQThuM2xPRGpCa0p6ajNFVTlzMGZCVk9mcUJxK2d0eUZhd3pYbTFKUTN3?=
 =?utf-8?B?VVNEdU91YkJUVTJKbVZ2dHI4eFBpRWVHNkduZXB4V2lhN0ZERXEwRWFkc3J2?=
 =?utf-8?B?b2duYzJHYW8yQTJGd29PM0NQalI5TEdLTXJFc0VJUXhwLzA3eFhDNXV1NTYx?=
 =?utf-8?B?dCtIY1FHMVlkOHZNVDBtKzJsVDJ5d0NxN0F5Z2V5eEVOR0RhSC9iMDJCR1Bw?=
 =?utf-8?B?dW0rOTQ1WFBqcXpaMTdoV24zZGQ5THFiVVZ5V3c2S05HR09oM2dJdUpxb1Nx?=
 =?utf-8?B?WlJvNWp0dzFwZ1lYTDN2clFRRkxjWFBqemxFd1ZlUjNuYlk5TWl2NnBGRlc4?=
 =?utf-8?B?bVdEak0zaUx0QmNwUXVSWnQ5bXI0WGxWWllKV2VDQktXaDJEbHFXLzBNeVVN?=
 =?utf-8?B?NjlwTVdDTkJJUlhTN08zaFNReWEwMlptV2Npekdhdmo5QWluWFdsM00rcFcz?=
 =?utf-8?B?d29YZ2tUTTZ6YzNCWmMzZVdwbzlpZ0RZOGlVQmhSSDE3S1pZVDFwbldoNEph?=
 =?utf-8?B?NXRIcDN3TUNWL211UlQyQnBjdDUxRmV6MVZQQmV0bjIrN0lHcExEQWE3S2FV?=
 =?utf-8?B?bnZReXVieHNmSVhCR2tOcGlNNnJZaGtvTVU3cFF6ZStYa0FmQjh4VjdaV3BS?=
 =?utf-8?B?aHdCN0FzNm5Kby92Q2hRK3FBUWtPVFNxLzJLUTV1K2Z1bGsvWVVqR1pwUWRJ?=
 =?utf-8?B?REZQeEtOSkd6NmY3MEE5dHYyZE1LNUVya0gzR25VQ2Fuc3JJQkU0MkVpalFM?=
 =?utf-8?B?b0k3NGJvWDV5UVA4TFNQYmpaS0ZaNG1LTFcxSUhQMndnby8wNzROTXVHbDRQ?=
 =?utf-8?B?bjR0TS9qVzQ4MUg3YTBWN1RJUHA1REcrL1g4cm5rbXc2VXRkeHhsL2hjOFd0?=
 =?utf-8?B?U2c3bGFRMThCUmpoV053aXJUMkZqSVBLWGF3L2Y3em9IdGE1WVRsamdmMHIr?=
 =?utf-8?B?UTFNR0d3M3JVdFRxalBJNVpUTS8xcjdTV3daRlR0eTJLSnpsc09CRnkzVFdM?=
 =?utf-8?B?dDd4L0d5Ryt6YjFJSVAxREp5K0ZMSHdlOWJCYk15TUk5YWF4SlFWcGZzMG96?=
 =?utf-8?B?U2RCanhQQ1N5Sk03REZNQ1p6TTBXVVc3NklVUzJhOW54Wk05VkpUd2xFSk1P?=
 =?utf-8?B?a3RiMkx3MUNQNU0wczc4K2psVmx5U2RmRVhyNjVhR2xWVFY1emQzcXlzaVVs?=
 =?utf-8?B?cGhSUEU4OVlOQkRrQi84SEEwT2VXUEFvMTNLOFNhb2ZjUmpUWS9XVlhkREJu?=
 =?utf-8?B?Qzg4U216QjhPeVhoUDZHRmxhQklUUmFpQlBxeUFwSFhXZXRwNkYra0NwbnJ3?=
 =?utf-8?B?dm1WaTVoZERtT2NBUFV0dkptdEd5cDJmMi93NTIwK0tNYVVJbXlqUEw4R0wz?=
 =?utf-8?Q?ObtI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 18:24:50.1793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c60074-eda7-4a7f-d7af-08de082a4cbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325
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

BIT_ULL(n) sets nth bit, remove explicit shift and set the position

Fixes: e30383fce4cb ("drm/amdgpu: fix shift-out-of-bounds in amdgpu_debugfs_jpeg_sched_mask_set")
Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index e7b4b768f7d2..91678621f1ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -370,7 +370,7 @@ static int amdgpu_debugfs_jpeg_sched_mask_set(void *data, u64 val)
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
 			ring = &adev->jpeg.inst[i].ring_dec[j];
-			if (val & (BIT_ULL(1) << ((i * adev->jpeg.num_jpeg_rings) + j)))
+			if (val & (BIT_ULL((i * adev->jpeg.num_jpeg_rings) + j)))
 				ring->sched.ready = true;
 			else
 				ring->sched.ready = false;
-- 
2.48.1

