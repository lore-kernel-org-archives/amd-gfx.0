Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8C2EFCE4F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 22:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2900710EACE;
	Wed,  4 Mar 2026 22:27:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kMfUwGFB";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010068.outbound.protection.outlook.com
 [40.93.198.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A668E10EACB
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 22:27:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zHTQzOyxfMx3e5lma496VmJIZskCLPmXW8ZXJaI9FusBdx4PelN3e8qeVP2VUqFZs9PE2QphphvXobB4210PbSd5udZsADSRPU6/MS5DtHgWwOxmisRslqRR1ZKbHF3eEbGiEOs47sncKSeVPL0FGKGWt0tOfJzXW3B/W6AeBrixNdb8ydyNjF1fBoc2+3gX0oqdA8r+KTCDJBCHu9hRyNhkZLKDmEWnc3kTxcoGnjc99UeugBttjkwoNhegEKel9KLpEryHG8UY3eT9aoW0N4TQgixMMijMl1lMyYZrx3TMcRZz8V7awzzanP6MAhLkhtZxz+gr2gau/kpi9OCATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nz1xnuTll5FvviSIW9UdKmGbwgBD4wGqqox1/Y/Xec=;
 b=Ihc86d+xYx4p/YDlHjnuLY+qzoTAIr7eiRbQrZxUQ3YA2W4gOImaDRIlEwMLnAKLZ+2dclbhMq/4No4LNG5KtIKqfQ3vXGZ8OQn7wr18M/NLjc+0SAHq7trsjbu1ONBGZgsWO2A7T0EWgLwp0lHYY/t9gcx2umQftX9/o43lpURoVUo2roNyuYWw7xfY9gPD3x9vTLECK4vz4gekopoFV3oH8hn4AAnpFFa8p16osQ2p7YGlsBO3jHtVW8kELRkOXsj5orlJVEKSutGg5Mh9XSPoem/5PII99c/3gKuYyRAPN+6fpHrmbAZAaxK4GL4osiVh1MJ61gVbE5EVZDudHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nz1xnuTll5FvviSIW9UdKmGbwgBD4wGqqox1/Y/Xec=;
 b=kMfUwGFBkMlbS4OUPIKo0wsd4cjG5qvrUnvVi1T365YEldFgGItBpbqab/uvIy9VGCp78jGVHQc6fCgk95jS+hYPu+Upjn/Ukvxb7EwBe96QbdX4Hxhs+USo0E4ZxvcL3zJsaVg7rP65GGr2We94CcRXtkZ9s+r0W6BoaooU9eE=
Received: from MN0P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::13)
 by PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 22:27:46 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::47) by MN0P221CA0030.outlook.office365.com
 (2603:10b6:208:52a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Wed,
 4 Mar 2026 22:27:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 22:27:46 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 16:27:46 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 14:27:45 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 4 Mar 2026 16:27:45 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7/7] drm/amdgpu/mmhub4.2.0: add bounds checking for cid
Date: Wed, 4 Mar 2026 17:27:32 -0500
Message-ID: <20260304222732.2403409-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304222732.2403409-1-alexander.deucher@amd.com>
References: <20260304222732.2403409-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|PH7PR12MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 96dda08e-2578-432d-48c6-08de7a3d42c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026; 
X-Microsoft-Antispam-Message-Info: EguNJZRWHEByEF+1wfELzOB1wonGQiJ+xb22GATVB+GNZ0HagKXZF8Sapw18SHUPG/KuQhT1T3F6ffxcEXpPIOktb/uT2NqTYbpN3xllka0VN+2BNm/KJzJfMwYVJHUk4GxpHTflSzAG0DtSBI47+TlOJFoMr0qqzC4z1tysC26GqkOg3J1u9ZsLGq1fAtKdoZOkkplsKVcuHRuvfoU8p/Xsz0xkYltLreMUR4nWbwuiYPySLgNHNqoV4mSgHi/Ze27OE8T/L9LO5CFZAat1tS9L2vIwGLvDEVTfV43nFiU2qLBT4SUPLPx3+v1Q3xxtE0aC13y5480bMFtiIBxqbtoeMPEtX92LkBkuhkedVks8uki3rLAihmOzuKY4fBp70at5rHcLEfH6LGf2EPVs7K2n6nbi1DwaPfSwsOB5Zhz41cQTF0IaG4Lkvcb2itU3HYSfxxrkxInLFsNbnkml0JAiWX1MI/4xdC6CM32CdQsZIdo1mX2D3k7ZNMk1k+aX3N0BoznIrHSNwNyze1/eVOepGWL/LN8C6QSK0NDYT/5Ppmqr/ue0+U5KS1a0tOhK881Wvlu6IzTnIZiE/xFPWMXEkxKal+hKij+AsBNOoIWQlSohHhucaThA0p0qWldvGwWJPbNAnWFwP0pToGJwpiGHAZSbC48Qt4kF3khNQvIfpKVFQiNJ/xvkMwXunWfwAs8qAFT18yOkLrRPIG67CrJWjT1PICMn5YOd5oymM+3VHcrJ6Hce+3prrcYtWVX95me7eMoEBXBba1/z6rwvcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oX19N3n2ewoiG8jP0EiXEfYZTQnxBuyP3YtdqV2ZoL7tKnaqZxSu9KJ96+wkHWLNHvWfZftts2tnLX9AyMHBv+u/y0LFGIfBg1VTftZUnKUjYqKTxz+UFxHwCLzpHay4DVBJlX05pwL6z6saoTuefOMqzgoCukGpDqm55CY2hvGgea/Or67qW0wa0pXe0VEjgM8rLgadX7Rl6K2d4y7htibTv4lxxv1wDE0yBmLDEGTHpAUOs4evI8uVC6zUKKDdrjEhP9dA4dyIlh787D++mWmtJOLUtszP5i/YSRDhA9reFz4lp2wDohANI4B4fna+Q+u6r/C3OdM4eJo+yZYhjgNRIrqdfSNNVgLjtDO4LfhDIDykWuJ7LyjPVxz2DihVrIhEygrO4Aits64k7wfho3KlFETuI0kotA29h6Owf6mjWdJmyEqFRovbWw7EZn17
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 22:27:46.4375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96dda08e-2578-432d-48c6-08de7a3d42c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356
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

The value should never exceed the array size as those
are the only values the hardware is expected to return,
but add checks anyway.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
index a72770e3d0e99..2532ca80f7356 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -688,7 +688,8 @@ mmhub_v4_2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 		status);
 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
 	case IP_VERSION(4, 2, 0):
-		mmhub_cid = mmhub_client_ids_v4_2_0[cid][rw];
+		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_v4_2_0) ?
+			mmhub_client_ids_v4_2_0[cid][rw] : NULL;
 		break;
 	default:
 		mmhub_cid = NULL;
-- 
2.53.0

