Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60993C34022
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 02:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2008120801
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 02:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uo3PKIKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2008120801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8AD2899D6;
	Tue, 18 Feb 2020 02:54:22 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700052.outbound.protection.outlook.com [40.107.70.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 159A1899D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 02:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMu0y3eRBr1hxGtkLCB9G8MYNMSKVUP7Dxtz1JV1oQM8uanceKCjBdWvjPPxO33WO+vKbDUVoAE//Qta+oeyxevAa4HkcPlBSJPtt8T/VWklIufarALBI0SP4awwwU++amfSEOCaZEXBuXAIvsBc46uJ2NNanaEJO2/r8Oo/p9kzsFpkPAtckHUbPJ0P1WE5ahaO/Zlrs3zY7bmsULWtsZtcy6A/iqFvn3o75W6vSedrPQ+cxpwLbPJBySlgfUa+ZmyM93LgMUU++c2ImNLJlbhsxx3pYskvcVLltcGmHmp7KyD67Nv1WorYcAI7WZvm0+kcLxpysDM2ZjtoulyT4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ai4SJJR2pCNBjzbeANzMADMGfvRmQVnFnQNaV1NgWG8=;
 b=aGSba6J0myxTeqSKFWQxVc4CyUGXWu6Wn/yKO7W/LBW4Jxcq00dWXcxc2oMoFuEMKlRmqAIpXFS6ME+h4GdmlS3097m8WdN1gX1Zm22/Wor+EPGB5W0htYyzT6XRJra6SGB1oYxiRhn6rk0A/yi+/zE2CuTrmK0P0O5Fj9AmEpBY2y9p0RG/iDSmXopa3u4sUir0OtRjpmJJs8WiqB2+c3Bvtp4jqPJXixCwP/HAxXqiN+uSF873bDDZQt6fxtJ9DTmQ3wmXhgXCLZzej0Aos5vejuXEAqeQPZ9oTtm6cM4r6sr2xy4M/vsjYPCfNq81gJXHx2LfLL1/r6hj6//faA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ai4SJJR2pCNBjzbeANzMADMGfvRmQVnFnQNaV1NgWG8=;
 b=uo3PKIKt9OpDApgNZoSrJJlv55P4RCwjfbScdgt3XpncFx2XyDwhue70x8G9bP8hKnu/v/SOh+IEuPnjagx10YYACjWIq9+41kQv0DRTOmplnaI3s5SQ0wW7F/oVbQPcR/8iod3cFXGUqJM7+Q0mXz6Qp9OTkunn35DS9tsyiKY=
Received: from MWHPR12CA0035.namprd12.prod.outlook.com (2603:10b6:301:2::21)
 by MN2PR12MB3327.namprd12.prod.outlook.com (2603:10b6:208:cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Tue, 18 Feb
 2020 02:54:19 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::206) by MWHPR12CA0035.outlook.office365.com
 (2603:10b6:301:2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend
 Transport; Tue, 18 Feb 2020 02:54:19 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2729.22 via Frontend Transport; Tue, 18 Feb 2020 02:54:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 17 Feb
 2020 20:54:18 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 17 Feb
 2020 20:54:18 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 17 Feb 2020 20:54:17 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: cleanup some incorrect reg access for SRIOV
Date: Tue, 18 Feb 2020 10:54:11 +0800
Message-ID: <1581994453-5498-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(346002)(39860400002)(428003)(199004)(189003)(8676002)(8936002)(70206006)(356004)(4326008)(2616005)(81156014)(186003)(6666004)(26005)(426003)(5660300002)(70586007)(336012)(316002)(81166006)(36756003)(7696005)(2906002)(478600001)(86362001)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3327; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e8db0f2-35d3-4811-5872-08d7b41dd952
X-MS-TrafficTypeDiagnostic: MN2PR12MB3327:
X-Microsoft-Antispam-PRVS: <MN2PR12MB33274A94D3CCD45AC85E167184110@MN2PR12MB3327.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 031763BCAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z9hkWAuuSELNcPRY4IYMopKhk4cul5GB34qedmHtThQYRCkAjoWjobAMmEx10U6EsNsn+rGULs0PveMJh/fMcEG0XcrDLyxr1PG1KseySa0lkELyat8ruVsOfc9pwSXhe5C3WwFxsPDEDWqh+J/gOPmH1CnQk2OjJjDRAKw4tjZvFIMkM/qqjPcddc/s+ZbIzomFJxOy01SJ0n2oGCTf0U5v8Wft5cnilYxMMZuKxsACblaCZtvx8cxqwK2m4pC/wkSycOlxbd7KjdTXpEuxMRcDGMNuUZLhtZUjN3r8Wwy4vgptIjCsiQvcjQlJd6SAzKyu+W+/KkVbtcbaUuH8gOmvQK1u0T3xupvUbzKW0+4gdUUhFJYv/Js3Z8l7TZNmXZeJq/uGHUzkNTDS/AUBattNk7oz/Pl2W+AoDfT9A1RCvj7j5zwifwLFLmHsMLmu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 02:54:18.8683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8db0f2-35d3-4811-5872-08d7b41dd952
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3327
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SWDEV-220810 - some register access from VF is wrong

1)
we shouldn't load PSP kdb and sys/sos for VF, they are
supposed to be handled by hypervisor

2)
ih reroute doesn't work on VF thus we should avoid calling
it, besides VF should not use those PSP register sets for PF

3)
shouldn't load SMU ucode under SRIOV, otherwise PSP would report
error

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a16c810..3494966 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1081,7 +1081,7 @@ static int psp_hw_start(struct psp_context *psp)
 	struct amdgpu_device *adev = psp->adev;
 	int ret;
 
-	if (!amdgpu_sriov_vf(adev) || !adev->in_gpu_reset) {
+	if (!amdgpu_sriov_vf(adev) && !adev->in_gpu_reset) {
 		if (psp->kdb_bin_size &&
 		    (psp->funcs->bootloader_load_kdb != NULL)) {
 			ret = psp_bootloader_load_kdb(psp);
@@ -1318,7 +1318,7 @@ static int psp_np_fw_load(struct psp_context *psp)
 
 	if (psp->autoload_supported) {
 		ucode = &adev->firmware.ucode[AMDGPU_UCODE_ID_SMC];
-		if (!ucode->fw)
+		if (!ucode->fw || amdgpu_sriov_vf(adev))
 			goto out;
 
 		ret = psp_execute_np_fw_load(psp, ucode);
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 0829188..8ab3bf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -420,7 +420,8 @@ static int psp_v11_0_ring_init(struct psp_context *psp,
 	struct psp_ring *ring;
 	struct amdgpu_device *adev = psp->adev;
 
-	psp_v11_0_reroute_ih(psp);
+	if (!amdgpu_sriov_vf(adev))
+		psp_v11_0_reroute_ih(psp);
 
 	ring = &psp->km_ring;
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
