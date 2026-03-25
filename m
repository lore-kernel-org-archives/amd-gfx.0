Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A16109C04D
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 17:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1672F10E7F5;
	Wed, 25 Mar 2026 17:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pG6wjiCd";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4170310E7E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 17:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrOMFMcrNdVigpuSioruIsDnv1iRZNMEC2uaMm4w4WHo0s1/93hASwxf/u0y5B6oHhhVvhWW3gN0qYH95eAyGdXM0yG4LFGEmSRZSWPEu3HgxRXKSXHmqUySam0/KgHzZThBFwEcVGk/oMF2fS2tm+6CIN30R1kZDqicGTcWE/bj7nOcnu0vAceBvmrEpBEwI2uLQKVWCZ1Zau8094SOPVK+forUugBG76RHgcsjOqLllfu2v4TdyC9ztLHwdlThtXS0ZSkLLwGz7BFnjJwyq2VRR3ZGa9+GgirgmPQ9TOrFBR7uxE+LavBSJx8Rcp3OXILqj67y9Bq+YRo1Sfcd/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gk14lcFNbCOKE/cKn5mp34/bROXSB2c/bIJjeOegKK0=;
 b=YxympS2Gxx9dRrc6jGuuPH/X7AJuw4cID3ZNx9y/ih1ufl/NgDhc3v6LOdib8rd8jl1AWnVmto6yUMzvZ3RdBytX1Sihw9uE2j8vDhkJIE+4ph1BFamjCh+2N3jYj7+aoxSd32FWZjd7MZD6ZRjvZJ5xPe2+f4eVV9P2UeUP4xragxqUzj2+SbwUlUsBw5H32BdmgmkXiw//zZcOlR84cWrmWqutYmP0QyAf7GDyJszZ+z6QJmWo34KMe98NEadZ1EoVVvsnr5J2TkoUiaRbDSAR9vUWg9PCVl8uNOi5tiOEYHWHOzcrVUnrA1jV1IjMfMNSD/I0rzcMcp6Z1egkFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gk14lcFNbCOKE/cKn5mp34/bROXSB2c/bIJjeOegKK0=;
 b=pG6wjiCdGhEkiSQI9W8AmZhrcvXjwaGoEp9NGoiXvTnCz4X5asOcrcwyEceAV/LQK3SnwL/pZw6bxeySy9yYKI/Ox36yN314j8bu9yCtDpF5Dq7gI3gDjqST7C8jeIlphM7oQkulUkK9MhmGCzDn67UquhwXjB6Ywe9TA3+hC3g=
Received: from CH0PR04CA0089.namprd04.prod.outlook.com (2603:10b6:610:74::34)
 by DS2PR12MB9776.namprd12.prod.outlook.com (2603:10b6:8:2bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Wed, 25 Mar
 2026 17:52:18 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::53) by CH0PR04CA0089.outlook.office365.com
 (2603:10b6:610:74::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 17:52:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 17:52:18 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 12:52:17 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 10:52:16 -0700
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 25 Mar 2026 12:52:16 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>, "David
 (Ming Qiang) Wu" <David.Wu3@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/vcn4: Prevent OOB reads when parsing IB
Date: Wed, 25 Mar 2026 13:51:35 -0400
Message-ID: <20260325175135.3326685-4-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325175135.3326685-1-benjamin.cheng@amd.com>
References: <20260325175135.3326685-1-benjamin.cheng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|DS2PR12MB9776:EE_
X-MS-Office365-Filtering-Correlation-Id: d3af825d-58ce-4114-cd18-08de8a9741fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: EhaQUo960YS/AqI+BeavUSqnGVP/fEreEkuf2sdyDVHYLkYfK0lItz87Zl+oLFH7A3A1Ayfzfcu7vfoBZCS/g778qrGAVoxZU5a/GJHU4JRhr44BAk8V4MjxBjc9Foan8zd4RK24eguRrVZOV8jCm4IwRGvUyXlWUzytG64j/5t2gbu4sKKiN++sVMS4aMbSOb/hQS8EhX8+CqDurxRWv4p6mxBAN9f7TmGuM82XO6O5WxkEtgGMh3iWnqkg1YLHatV//GWlJ8H54gU8jZNuFRYPO8fD8xnslLRYLS7/qB1sfrxw2BuXN2fCJDDryrFiSU2cU42VvFEhWYx0eyclel746koEP+rBzilvxl6m6emtQFwQezEpRr7bb9VvJooC5qmcknW5yeY6o2AIt7zmq2ywHc0L7Dw4py9vYAkxoDeW63TR878PhwCr8d+XZdOK1/H2t2vD5A/vyrmcAZw3QOEIm5kxvNcCRq+CEhQTv9yfVGA0q7rkoSt8XcA5mkrOuXDsE7QEXk6oCqlKrwnRrFYS2JAa9nFlXags/0sWQ/JjaxRPemlCtkZru8G0O+1Sa24HYBDIc7rHENsLQ0lmrrv831H7cA5R2hBPlV9T/qhfHGk8c8R3dLBpGODxDS7+n+0jlt73eEmDZ4Z7Gr/Aw4dxh9gYmYjDnNK/wJ+dbilH0zsTw+qVH+uC+ceNHK26m9aMqqUMUiApP7SbgFTcP4XghShZRzDYYuaS4nwKqCOemoqlVrhggZz28JJQzrju39EzH7NJgNizJYYmLiSaSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F/g0XpoAkOk3yeTc4ZdwrBRIZiia7qNG6kXDcVhBUuaNribKvcuX330GwsS34JrA3VLY+wODEILacAVbajXPucNrAUZpK9fbbyeZzVZdRhUmm3eMC1Z6sPNJwEw8V6YcSn1QdV9AYNagOOtCozI5T5Yi+2S9yEOgPKRQakj4oZj74J3kP71zkJe+GiF4NpFDYn0D/8fQa1uUQrVXf4sVEK+jPL6w6AD6vT4kRXV6gPEZtgbknuCUmRKcQ3XPvBSbCk7Rj9GYNPvAsJx0pgwCx0RKC5avMyxbFqix6fGpyBJbU3FXhjJW881EctxhI7PIKq//Iw6uLt3mnmlCkzR1tj60Q9jR0moXnQjgqCPCZcS3v0HMSVGM9reBD1jb9MNU7QBnT64F4HH+RE7Hv/+IbDBj2rQrY4vrwAqa/rZ4S8XCqCCeAhk6jymwXTlo7ts3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 17:52:18.4768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3af825d-58ce-4114-cd18-08de8a9741fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9776
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

The code accesses the IB without using amdgpu_ib_get_value() so we need
some additional bounds checks.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index f0f492777b09..1485d92800be 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1928,7 +1928,7 @@ static int vcn_v4_0_enc_find_ib_param(struct amdgpu_ib *ib, uint32_t id, int sta
 {
 	int i;
 
-	for (i = start; i < ib->length_dw && ib->ptr[i] >= 8; i += ib->ptr[i] / 4) {
+	for (i = start; i + 1 < ib->length_dw && ib->ptr[i] >= 8; i += ib->ptr[i] / 4) {
 		if (ib->ptr[i + 1] == id)
 			return i;
 	}
@@ -1952,6 +1952,9 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 	while ((idx = vcn_v4_0_enc_find_ib_param(ib, RADEON_VCN_ENGINE_INFO, idx)) >= 0) {
 		val = amdgpu_ib_get_value(ib, idx + 2); /* RADEON_VCN_ENGINE_TYPE */
 		if (val == RADEON_VCN_ENGINE_TYPE_DECODE) {
+			if (idx + 6 + sizeof(struct amdgpu_vcn_decode_buffer) / 4 > ib->length_dw)
+				return -EINVAL;
+
 			decode_buffer = (struct amdgpu_vcn_decode_buffer *)&ib->ptr[idx + 6];
 
 			if (!(decode_buffer->valid_buf_flag & 0x1))
@@ -1962,6 +1965,9 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 			return vcn_v4_0_dec_msg(p, job, addr);
 		} else if (val == RADEON_VCN_ENGINE_TYPE_ENCODE) {
 			sidx = vcn_v4_0_enc_find_ib_param(ib, RENCODE_IB_PARAM_SESSION_INIT, idx);
+			if (sidx >= 0 && sidx + 2 >= ib->length_dw)
+				return -EINVAL;
+
 			if (sidx >= 0 && ib->ptr[sidx + 2] == RENCODE_ENCODE_STANDARD_AV1)
 				return vcn_v4_0_limit_sched(p, job);
 		}
-- 
2.53.0

