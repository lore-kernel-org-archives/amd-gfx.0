Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF9EC54E71
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 15:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72ED210E87C;
	Wed, 21 May 2025 15:29:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dFSNDW7b";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C404710E6F9
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 15:29:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dp1XDBUYFFsq7Z/QUPBwPDCEmHyNn2UW7FnkcPJXBQn0vWflaZGa9rY2/YFbX/DGWHu1bmcg3r/0ciA+MyCAH3bpBRaluerKjcbeFYFJSuyVh80A+GpTKKw9X1ai8FJUCtbHrhFsWX23ug2kGoNBeM60fuhwfe1uV6VwzfBBe3i9lRNk8Z68I9tliBu4FdHdZvl/GU8iB93UvSZ1jhgOHA0abBMVwPv0MiL+dtwon/Rw6y06ba9luxhufQAgR9VlfULu9NnATPlhRO1AYnZbkQasiYZsc00zeCXv12jIqzDnZSNT1S/MDztRzODejCU32YSOdsxCWdAIXnullYVVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8oaM0mFXm8kS2tPRDFNhJiJGjQ2ZT5RK98zUzpsbOU=;
 b=eUIqkS/nX0gOm/0vH5BdxiFygxkxa3n0g1eZ4j0DbvGyb8vBFiZ6ZVaDz5hFEKsk8RkQXbnwSopkrn+uxN0qOFNEjVJDGZN7Qala7siteHcgbG7pmQxniqdlg5edR9BLzR51AmHbabkpR3Dg2pDHCLo/jbQ5if48rom6ymlbbD4eRfPF4RrYUC8+OgkHsVAej+GCLehG2okguI1j3B6GgXiBB7T7zJWgINcQeEOj3PXbqPZjvU5Wnfrcmi5pTW7XtJHXA27RQv/HiEAxRMMqbtmQFcKLHNTqu9n3leV5Twy5YFy3glAD12mJQPVQzNUh2UUejX3VRduWwCN6sSbNlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8oaM0mFXm8kS2tPRDFNhJiJGjQ2ZT5RK98zUzpsbOU=;
 b=dFSNDW7bmhyVqp8ugfF2sJUI3VUF84N01NwGYmJLwMwvPg2+LUDQjULfB8KvSYV7ExfcZobAxMhUzy6Ylsq320L/jhkuwJ//adhorKDk+DNigAf1rUXK7cy4XTpqckCi7kIzBDm51ch6zzdZ6iPsbZp/kdJuo0H+uyJTnRzeBB8=
Received: from PH8PR21CA0005.namprd21.prod.outlook.com (2603:10b6:510:2ce::21)
 by PH7PR12MB8827.namprd12.prod.outlook.com (2603:10b6:510:26b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Wed, 21 May
 2025 15:29:39 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::de) by PH8PR21CA0005.outlook.office365.com
 (2603:10b6:510:2ce::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.9 via Frontend Transport; Wed,
 21 May 2025 15:29:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 15:29:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 10:29:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 01/10] Revert "drm/amd/amdgpu: add pipe1 hardware support"
Date: Wed, 21 May 2025 11:29:14 -0400
Message-ID: <20250521152923.401945-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521152923.401945-1-alexander.deucher@amd.com>
References: <20250521152923.401945-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|PH7PR12MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: a49311b9-ef2c-4b09-99a5-08dd987c4d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUY4UkJYcXZDeXlreGgyL2NKUUxORFRlN3lwemlRUkRaK2xNeDQ2eHZiWDgx?=
 =?utf-8?B?RWZBU29jZVdzQ2JEL0VsSlJRbU9LTGJzakpPSitSeEtvc29EdENxN3VEWVIz?=
 =?utf-8?B?UTdWQ2t4Y2E3ZjBqM3dNb3pkK1VianA2U09vSE9oUTBndm1TN29yNFBqRTF0?=
 =?utf-8?B?TStpL1Fnc0htNURsMTFwUVVwRUFILzF0UWkyTGZESk5SSDdGSUZjY1Y5d3A4?=
 =?utf-8?B?bEovU1AyWEUrTlhhK0tobEtUYlhDNWVNQ0VMcVBNZ1lRTUpEeEpYdVYwbHNj?=
 =?utf-8?B?bFVSVk44V3AzdHNrdDVyYWZvbFlHbmY0VUpFUGhReUd2Q1RSSm1QdHdrV01L?=
 =?utf-8?B?L2hUYzZvN0M4d3lKRDhTb1pTT1hPL3VRMlFqVER0cVovcEZEejg4ZjZnb1Nl?=
 =?utf-8?B?VWhJM3RTM1hpSDZNQm9OYUxqLzJ5Wklpa2sxN0VDTG0wRHd3SUR2RzROU1Fq?=
 =?utf-8?B?SlJYNHd1UEoyT2pWanNYanVzdEZzd1lNUzJUV3lOeHk4bVY3L1pOYjJxdXU5?=
 =?utf-8?B?b3hoSHl0c2JEM3lzbldOcWxPeEcySWw2dkVWeWd5QTFWajhUdWMwTFBGZXAz?=
 =?utf-8?B?UCs5WnRVSkhXbEpLd2wrWjhDVUxuekdJQ2ppUS85eWJsTWZHaFRwS29nc1Jl?=
 =?utf-8?B?NElwWGloL1pLdEVTSHRnRVV5dW5oazBZMFc5NERnNm9ySC9NNlU3REQyV2lR?=
 =?utf-8?B?c0VBVW5GY1dWcTNsM0VQVTlxb3dJZEdOdzJSUVdTN2E3ajYyekRuQ2RMbDhZ?=
 =?utf-8?B?Rlc1OVorUEZoKzJyRjR1b25wRnkySDZoZWNpbVpkeWpta0hvK3kwMW9RUHg2?=
 =?utf-8?B?N2h0WlNhaXBOZkFsYTltVzZQOGJjY2U5R0xHUFE3Z0x4T25Xc1BhbTVFYzhp?=
 =?utf-8?B?L2trWHRVZVV0OW9rRmQrVkQyRlo4UXBpbkVmSGhxSHp2VjJOS2plSitBZnpr?=
 =?utf-8?B?czY5NXNaYm8zYWpjSFowUEt4UHJKdmlRNEcxc0l1QlgvOTFSdGlMZUYrM1RX?=
 =?utf-8?B?NWpJeGtGSEV5MHY3WlQzdlpmYmtyZXpINExSdFVYam96akc3M1ErVGJlQURQ?=
 =?utf-8?B?TXVoQlFsd1hySUpvSXpndTRZQVZGN2IzNDdHSE0xQW1JQSs2RGVqUlUxdGEy?=
 =?utf-8?B?dHVkcjhWZnJxcnEyT2tMQlVqaGtxOGxnQVJPZXhYeS8vUmh2OEQrQjBkalRT?=
 =?utf-8?B?eUZmbHVJa0xCTU1kZzB5RTNtN1NBclpDbHliTFk1TWZQbFRaNjI1MDBTVWFv?=
 =?utf-8?B?TktDaGRSYzMvbXFUNHNuaEJRRGswNklZSU9IaTFHRFlVcVBBT2NCUlNOOEJ4?=
 =?utf-8?B?V25YOVlGRVJBdnlSN2p2UXJWd1FoZWhXTkR2czBWUFlPV3V3N1RBSEpKMjlW?=
 =?utf-8?B?SVVmUHNCTVd6RzMxakFFRjBQUmtMNkRNOE8xZ0J2K1VxaG5wYXNVczVuVTlj?=
 =?utf-8?B?Z1RjUEVFeEVLK3MrN1lWc2ZlWmlURmxtcTk2ZzVWZEhTSUFKYUxQOFh1bTJw?=
 =?utf-8?B?eXhMNGNGcXJEeFVDcjE4Skc3MGVYbG9qaW9oOU9HNmordlpXZ1pnUUJVQjN0?=
 =?utf-8?B?VTA4bzFIUzlOWmtEa3gyanE4eWUzUUFsZmQ4UDVPZTB1NFY5RTJFTHgzNG1Y?=
 =?utf-8?B?UEZWV0pVTHpOeFNKaGRLS1JhREJSZnRMdFozbC91QW9SRnQ2eFRHRmNxWDlD?=
 =?utf-8?B?N2VvM0Vwa3NiR3BkTjIwbTYrK0lzV280TE1NS1kxUWQwS2tOSzAwaUZVNXhh?=
 =?utf-8?B?cUVOcCs3eEVSTE9QT3pUcTJhZmdHZDMyM2JYanlxVnFDRmFJY0toeDYzRnZv?=
 =?utf-8?B?Vi9WSkU1d1ovNVBuVnZlRzBjL0tMRXY1MXViUFNwV3lZNHZkdnNPNzZ3SnRk?=
 =?utf-8?B?aE9JWVNKTnV6S01JVUc3ZXRRL3NWT1c5UjBxT05rQ1hMMjI2S2xjaWhGM01v?=
 =?utf-8?B?SnYrRWxZYU9xVTU4Z3FiR2FMU3FZcmpFdUlxSXhCSTYycFBXNzhobEh5TUJ4?=
 =?utf-8?B?dmMyNVdiUlpRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 15:29:39.6559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a49311b9-ef2c-4b09-99a5-08dd987c4d59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8827
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

This reverts commit b7a1a0ef12b81957584fef7b61e2d5ec049c7209.

A user reported stuttering under heavy gfx load with this commit.
I suspect it's due to the fact that the gfx contexts are shared
between the pipes so if there is alot of load on one pipe, we could
end up stalling waiting for a context.

On top of that, disabling the second pipe may fix the reliability
of vmid resets.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3519
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 75ea071744eb5..14cbd1f08eb5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4781,7 +4781,7 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 7):
 		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 2;
+		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 2;
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
-- 
2.49.0

