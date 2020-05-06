Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C054C28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 06:39:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72EC3206E6
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 06:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="j87JipDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72EC3206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D9BB6E22E;
	Wed,  6 May 2020 06:39:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C7556E22E
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 06:39:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMN/X8hSgfwBZoThwAeZhOuLzNcrfnTU5olAUcee+mLHFiauZVy+eDtTYnoAxSwelYXLd0lEpM6DJe0kcSIkXJE0HnieEpbSN0cBPdDVoZoqbZ1siSEeAlE/OhxvbFgZyEBbJocb3lGBJ1IlHwD8tUtCNf4rP0lMHsUgWmvrtDam4VpwSHhSkitexvNq0dnj+G7zjb3CLQUsrb3ufjzPFI+iJUjkwRVV5puUQ0BWMGeficWplI27TQjCqG4EPMHC3iH//0QbM8Lyo420/R3AR1+qvhqs+xsDXEe8FG1aYketJTlLJYEitAwgeZdql90kmo62bOY1Vpsl59Yzn9Q/9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6qF3W0xNKWrushFKuiqPlct66wKwLjyM7Xr8Y2TB9U=;
 b=CmO8hZd5RRKdNSrbnOBAexHW6VChkTBNu69LKXEwayjUErOJrKun6OGgTqMFusNvJ0dmymcy9Enik3fo/R8Asvphb9X6JFbnCQe9sAGKQe/VEVq4ristXdtXjWktBshbS9+Ho643YIR/rZrO15hBe68EQUenpBANSJJ/Qo1u2RV6nZNzfJUxe31R5ZtWe3t8dsDNelUNSh1SyY+I7uU4iKQe7E/PqRfMNkFrxBxGcZHKcuDgGNiSNorPRhi78izZj+aMOsJXo6/STde/EaxPD9HtsAD58ZAmGlHcblo68F8/++k/r3MUbtqxIJ8pV7iiBdH+znqBsdl2N/MXc+inCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6qF3W0xNKWrushFKuiqPlct66wKwLjyM7Xr8Y2TB9U=;
 b=j87JipDOC7PI3oXHP76/uWZjFR0Ylp4170x7MRNRwsXJ948WyQFNSKUDMQ9LfCLzH7vZy9st5lWc2gjBA2KiKoTvGVK0K1XzZd9IB7Vtay0MRy8eZL0a0nITRoT60RGPh2em9NRnDdaFjrRE8zMo6iIPPSl2sc/5WxFGovrDKv8=
Received: from DM5PR13CA0028.namprd13.prod.outlook.com (2603:10b6:3:7b::14) by
 CY4PR12MB1559.namprd12.prod.outlook.com (2603:10b6:910:c::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.28; Wed, 6 May 2020 06:39:42 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::7f) by DM5PR13CA0028.outlook.office365.com
 (2603:10b6:3:7b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.16 via Frontend
 Transport; Wed, 6 May 2020 06:39:42 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2958.19 via Frontend Transport; Wed, 6 May 2020 06:39:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 6 May 2020
 01:39:41 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 6 May 2020
 01:39:41 -0500
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 6 May 2020 01:39:38 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 John Clements <John.Clements@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Guchun
 Chen" <Guchun.Chen@amd.com>, Dennis Li <Dennis.Li@amd.com>, Tao Zhou
 <Tao.Zhou1@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: drop unused ras ta helper function
Date: Wed, 6 May 2020 14:39:22 +0800
Message-ID: <20200506063923.22772-3-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200506063923.22772-1-Hawking.Zhang@amd.com>
References: <20200506063923.22772-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(46966005)(33430700001)(6666004)(356005)(81166007)(7696005)(33440700001)(82310400002)(316002)(70206006)(336012)(70586007)(26005)(2616005)(110136005)(82740400003)(1076003)(186003)(47076004)(5660300002)(36756003)(478600001)(426003)(8676002)(6636002)(4326008)(86362001)(8936002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fed8d75-eed3-42ec-6c25-08d7f18841f7
X-MS-TrafficTypeDiagnostic: CY4PR12MB1559:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1559576228CE3D9699C4A838FCA40@CY4PR12MB1559.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:101;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I5rfeHwtdKyHciukK0n8Iwh0NKvXuEE/g5thELnKDNGpucz/FzRqKwvCZdu8RSqGhUdJT22YirU/QWGDgjoN9e9WcwdtfD9/bnVyQBRCeTLjW3e9VFDtN21vbWI6h6xjcwpFXZN+YDhq+ySdLKy5o1PvvVi3kPxVTVfCdEYlI46D0l9UyX2v24ehtMBQlmXYATYxa4FlV7hl/OEHwzRXZt7+yIIpc5TbbWdYDCnt0gxAMyy3yATFc7INNeCcDhAkt9Rcb0iSVnYdO7TfBLVEsHlUFt0boQep40N27VmF6IuSP4W6cJskhbHekxh6kYJNK6zOCVam3dfpOrtKHQ1XxjJ7vaE3HP1HH1SZHJbrnAXNl6OOpF5Rb+NHfBiB6FVhBuofActeTHw6hsNk86Cn1z26nGbF+/wz3kACgndU+gvpN7Zf/mAGYlsHsjKjv1nzhrZHd2+dJo8gMmSexAHv9+kBuYlijBm715fQDFhSEmTLf2FCZEyoJ+Y0x3bUH6UCAwvJRAiycpTwfffo57pjepheCbuW7vwunik4GCBaK2Z7XOdonEsgG0qLfrFPwnpS3Lpk/s+PaMApOJGzgKyGtg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 06:39:41.9875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fed8d75-eed3-42ec-6c25-08d7f18841f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1559
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

cure posion command was replaced by ras recovery
solution and was not a formal command supported
by ras ta anymore

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  5 -----
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 27 ---------------------------
 2 files changed, 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 14802b5..46bd85f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -95,7 +95,6 @@ struct psp_funcs
 			    enum psp_ring_type ring_type);
 	bool (*smu_reload_quirk)(struct psp_context *psp);
 	int (*mode1_reset)(struct psp_context *psp);
-	int (*ras_cure_posion)(struct psp_context *psp, uint64_t *mode_ptr);
 	int (*rlc_autoload_start)(struct psp_context *psp);
 	int (*mem_training_init)(struct psp_context *psp);
 	void (*mem_training_fini)(struct psp_context *psp);
@@ -317,10 +316,6 @@ struct amdgpu_psp_funcs {
 #define psp_mem_training(psp, ops) \
 	((psp)->funcs->mem_training ? (psp)->funcs->mem_training((psp), (ops)) : 0)
 
-#define psp_ras_cure_posion(psp, addr) \
-	((psp)->funcs->ras_cure_posion ? \
-	(psp)->funcs->ras_cure_posion(psp, (addr)) : -EINVAL)
-
 #define psp_ring_get_wptr(psp) (psp)->funcs->ring_get_wptr((psp))
 #define psp_ring_set_wptr(psp, value) (psp)->funcs->ring_set_wptr((psp), (value))
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 9e4f582..cfbf30a 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -524,32 +524,6 @@ static int psp_v11_0_mode1_reset(struct psp_context *psp)
 	return 0;
 }
 
-static int psp_v11_0_ras_cure_posion(struct psp_context *psp, uint64_t *mode_ptr)
-{
-#if 0
-	// not support yet.
-	struct ta_ras_shared_memory *ras_cmd;
-	int ret;
-
-	if (!psp->ras.ras_initialized)
-		return -EINVAL;
-
-	ras_cmd = (struct ta_ras_shared_memory *)psp->ras.ras_shared_buf;
-	memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
-
-	ras_cmd->cmd_id = TA_RAS_COMMAND__CURE_POISON;
-	ras_cmd->ras_in_message.cure_poison.mode_ptr = mode_ptr;
-
-	ret = psp_ras_invoke(psp, ras_cmd->cmd_id);
-	if (ret)
-		return -EINVAL;
-
-	return ras_cmd->ras_status;
-#else
-	return -EINVAL;
-#endif
-}
-
 static int psp_v11_0_rlc_autoload_start(struct psp_context *psp)
 {
 	return psp_rlc_autoload_start(psp);
@@ -851,7 +825,6 @@ static const struct psp_funcs psp_v11_0_funcs = {
 	.ring_stop = psp_v11_0_ring_stop,
 	.ring_destroy = psp_v11_0_ring_destroy,
 	.mode1_reset = psp_v11_0_mode1_reset,
-	.ras_cure_posion = psp_v11_0_ras_cure_posion,
 	.rlc_autoload_start = psp_v11_0_rlc_autoload_start,
 	.mem_training_init = psp_v11_0_memory_training_init,
 	.mem_training_fini = psp_v11_0_memory_training_fini,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
