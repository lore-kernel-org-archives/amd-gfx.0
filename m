Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED472CDB466
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 08:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E6E710F19A;
	Thu, 25 Jun 2026 08:21:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Th93HhQ3";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B657310F196
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 08:21:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2s2chwao750ar/zX2l3XL4VrT0cqjbTdnKra8/QDlg4ntO8GMYI5vuDnm3eGZQxgJPGjPyJgLFQuhqSojknSou7f1nvva4DW1cMbtddMEHvwFLYj3oLt9hDOFGW5Ulsc+fuqOfeL16DGM39silpsQFq+lXO/c7uvkvTTT3mI7oMAf1MVxG4YNhRc0vfc/u9UKBTw3asfNMbSoS0G6ZpvZ0wTS+z/4wzdXl2DnJgA/d/5ngQjdVAEYGYC8dIC9iQCf2Gbb772WNRm+cUG1dW2t6jD/BUPpyGhewOOe/dOT8U18bfnyYWS7yUIxXi71VM5/yjhE5jAes/pEYrzXK7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6GPD/4IYbow1VonjwO7dKq9hmdDuZKHI8CDoUneL6U=;
 b=aXb/JvTsoaGLltIU+t1x1RFTw/uuSR4vHhpmlxHt6if9cPo8ydSo6wvommrpk3txTo9vu3DM7xtV5A36cxLebmVmgiz3YglloDWKdfFkgDtR8imVUTJk0cHb7TF28/WiVKwdHmA1Vk/MGwrlsMuQi34tOZyJjC8HN/z6NSX6jt4X9E3CF+xxc6ylWuhKpkueieUpdlVTXrTU+lqGDhQn9EShex+EtzRWfW3aBidiwZNjIYi3dGLMuHjDHHMSg+k60hgvU1CvIV7iWihVY4OHjbx28eZkwHhPgQQ6x6MG7D7nZqBUPJC+Y2xoHIUMMV7rCLQ0xDucaFHpyUwWhDImRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6GPD/4IYbow1VonjwO7dKq9hmdDuZKHI8CDoUneL6U=;
 b=Th93HhQ3rrAx3WR+Qapd9QGErNqYuELX3mTTB3frUfRpH5JDg90CSbKMj2xS5+x3E9NFv7gG++Q/4Ehir0v7etME2O6AtOtGW60OIo/zpCvOt6Gg2Lfr9g5MSMwjs++SzNyh9mZ8Bpln2L1TqYS/2mzm1gMoQJHsY7HQEd0PyM4=
Received: from PH8PR07CA0025.namprd07.prod.outlook.com (2603:10b6:510:2cf::13)
 by DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Thu, 25 Jun
 2026 08:21:15 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::a) by PH8PR07CA0025.outlook.office365.com
 (2603:10b6:510:2cf::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 08:21:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 08:21:15 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 03:21:12 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v3 32/44] drm/amdgpu: retire legacy MCA IPID parse global
 interface
Date: Thu, 25 Jun 2026 16:19:25 +0800
Message-ID: <e72301c3371a82018f6d2b04459a73551fcd8ef5.1782373702.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
References: <b5587fca5f57f8f352245edf2c76606ad3307923.1782373701.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|DS0PR12MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0dc1e8-4b2d-4e95-17c7-08ded292b97a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: o4Ma0vMu1XaRCFUzPznMk00qdlfh/pDwJEoIpclDoGssdsbiM03n5M6islDKT8KoNJNuf/yVmGW3sz1+FUskU+Pha9wH1ou6pbn2Vuw85pagKLn0OdUNOxKeQFvwwdhDpsb4Y2Z7REOStXZ/p5PiGWecehmzfaw9RW+3xmHuGidxgBwsnHBT7xSEyJ7ny/Fq7uCZflV2tGAX3YK0tKUuV7pJNFUkhSHEcrGRFwcb5Ym2mo92vERv6FdiINB6v0RSpwEiU7WP97znvVI5CqP0QQUvj9+K1ofFCGdxY+VLrI8eYbZOt4eYVwSWuzUW8CI4RSzf+abRhKwdNHIye6SvhbEsZHRQkCpcPKTddeRD9iiu9tjfFtGjDttKzOB/f5ew5UbPNRfL/ety7AEUJ0VcK3hkN1HMRwLhFkmz7DBOuteDnHBWNL9vmO8kAaZYX5q6CNU+sAiS6tX2FvRr86oaNOFPKsmjGpjU83qRWSrE0d8TqbpbIM6T+EutbBddYVCehk9Wk8RR1i86h9SqqL5EIgUdwKOosfPgjDuaI59AcShPb3ro3sEG8YkRXLBvM1VQ/KOqNDfSAIeUlp4l9gbC4vpIViiufcz+jDcNudK2KECzL0c2HXqnJmSXwoiR+W80+5EgR0YZpfiGZoV+Eqstp11ook6qwDIo8MK/FKdN5EZJWHWitspEgaSdQfgACmDlX3UEwaYhwQMEZ8RCXpZtOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SZrY0iLNjhEc5rrTh0IHo+tPl2iYZwTaheJO8TD1gFOx9oUf9UQjj7kt44qy7s1Va8kpRCLDscl5Er+yut7vdH92EUpywKk3VTtuuNnor0tPDNsBNjhPs+XFHRNZzHFlRmCjoIjDfAxG7hYoWD0p3eExPTrWsWlMJxzjjRYj6IUmG042RJOjrLqjtwBcsfLw34jKZTm21OzHxHS8hx8MpUQOaMQ1tsam2+sk9fHVCDIveq2DPSUojd0IR5wvUgT59TZZ9nwJibWx/2PZymK/z+HapqYrlh3l92kDXATgh/4hzx0+9lGot8PfsaomfM/ca4Dypk4XAGc2Zl+b36ISlAPum/PLdLLQS/GzZKIalWaflLHu1W3raND0Qox+69qYAflf9TMlcEP7HdfRW39eASs0um823YERPBgWR+mVyzxbzL+vYSGLT/wziajkLE7b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 08:21:15.1163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0dc1e8-4b2d-4e95-17c7-08ded292b97a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788
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

Remove the legacy global MCA IPID parse interface

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  2 --
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 14 --------------
 2 files changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index cdaee4a049c3..cf06d5f856f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -104,8 +104,6 @@ struct amdgpu_umc_ras {
 	bool (*check_ecc_err_status)(struct amdgpu_device *adev,
 			enum amdgpu_mca_error_type type, void *ras_error_status);
 	void (*get_retire_flip_bits)(struct amdgpu_device *adev);
-	void (*mca_ipid_parse)(struct amdgpu_device *adev, uint64_t ipid,
-			uint32_t *did, uint32_t *ch, uint32_t *umc_inst, uint32_t *sid);
 };
 
 struct amdgpu_umc_funcs {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index beb89b0f9f3e..67bdf7303e6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -197,25 +197,11 @@ static bool umc_v12_0_check_ecc_err_status(struct amdgpu_device *adev,
 	return false;
 }
 
-static void umc_v12_0_mca_ipid_parse(struct amdgpu_device *adev, uint64_t ipid,
-		uint32_t *did, uint32_t *ch, uint32_t *umc_inst, uint32_t *sid)
-{
-	if (did)
-		*did = MCA_IPID_2_DIE_ID(ipid);
-	if (ch)
-		*ch = MCA_IPID_2_UMC_CH(ipid);
-	if (umc_inst)
-		*umc_inst = MCA_IPID_2_UMC_INST(ipid);
-	if (sid)
-		*sid = MCA_IPID_2_SOCKET_ID(ipid);
-}
-
 struct amdgpu_umc_ras umc_v12_0_ras = {
 	.ras_block = {
 		.hw_ops = NULL,
 	},
 	.check_ecc_err_status = umc_v12_0_check_ecc_err_status,
 	.get_retire_flip_bits = umc_v12_0_get_retire_flip_bits,
-	.mca_ipid_parse = umc_v12_0_mca_ipid_parse,
 };
 
-- 
2.34.1

