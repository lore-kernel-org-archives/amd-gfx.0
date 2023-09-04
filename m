Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746B3C83F2C
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Sep 2023 04:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4EAA10E28B;
	Mon,  4 Sep 2023 04:23:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42A9F10E28B
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Sep 2023 04:23:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRaMRt6wiWxro7gcs1SgOsuj7J6PBu2T1bZKDWTsnk9OmHuzt/V+yc2Q/3P2cOuBRTzN1EdikrxPt6FSh2Uw0BL/rW5zpVLPhTdQk7NaLyXLnbeFK9ATys73vmhpkx0PlvjSiQHk4iqwuQ2b3/rHsg+uEmQsarXlnkYDv0NPeyaDq0pGIqRchOWiPAB3T+AAKOp38yQwYVa4ov4dZ5zT3pb3R4EFjH5W1XfOs+jj4FwaiA6puCoUOxaz+gEhUlzvQMTz1KDzRQg9MGD5FgUCbrxvqYNmcRFSUchUjhYrqblpEiYaN+oBQTiZWexSCd5xcW7VAFZBNpTsIUNQUAA2PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLYsngXTEhLzxH7OrbHlVWF8zrtijEOrewzcGY8CUwg=;
 b=f7nDmu5d0e5r/gulDVRH/Dy5tu5hSWAzvaSeEeZSW7BkLlW/4u08Z43hEmTv0ugfOfDrL+ABnL2p8ohhfCP0MkThw5MPP8/s6BYdXjsuRLG34myWS19yb4MYnqVUvDw5HJmGX8fY/u/qYstM91fMDToPUgOlLKVh+7DZVoRoVBB6piaJoC/UbTpnSdp3SerNn/T7wJcRANSoxkP5PFyUaq565qV757uxBEIv8r5VWMi8Dn4ZRcxeo7UkYltgKmtf2rigMnWAICwWGhEyRkHKH/rD+H1jkTpoxfJtJUX9wDYs1UuKrDsRJHZyzHEXjuwCnxYq97zPMj2Efq57mvMuRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLYsngXTEhLzxH7OrbHlVWF8zrtijEOrewzcGY8CUwg=;
 b=01JyDzNP8i9cws+gKAF6WXkVPHidoehwuV+cqWGvmxkyhxqRZh0ZdJD0OEFrgEHJIJ1uBpRRPJ51mnqL8BXe5/T87BcMj9ZbYEmDuq0JMktu0N2iBcR/Ebyq/HxZ6Y0FLq8FM+zx2k4ndnaY2z9nXsWNka0I3wqMW8SQAKSFXho=
Received: from CH2PR17CA0024.namprd17.prod.outlook.com (2603:10b6:610:53::34)
 by SA3PR12MB7832.namprd12.prod.outlook.com (2603:10b6:806:31f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 04:23:18 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com (2603:10b6:610:53::4)
 by CH2PR17CA0024.outlook.office365.com (2603:10b6:610:53::34) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.32 via Frontend Transport; Mon, 4 Sep 2023 04:23:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Mon, 4 Sep 2023 04:23:18 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 3 Sep
 2023 23:23:16 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix incompatible types in conditional expression
Date: Mon, 4 Sep 2023 12:22:59 +0800
Message-ID: <20230904042259.3070136-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|SA3PR12MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7434aa-09de-421e-e548-08dbacfeaa43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0dRT+zjzuv4i6zCMv3QWMGdaLoi77n6SeQyWxVuhI2carQgA1/lDFRT9tzqge74jo28LrB03yiMTZT4eJufNgz3RVyvDmn/ZlSJ+bn6FNr97eKNiHcMDYeQ5EaLtavFt/UnQOwPeSVRHA1Fju9r0dQ6Hmz//XbwWvw13zF7BOS7Ece/7tEbp8ZXLTzpN9GV/ryPsvCOP3u6aMBmZCaQ4DWcCeEfPqlMquYfTNxN2/aU04+AdnK3YbO+qsCgULaFZGEJJcBabsyFhgTq3E0FgvLFKwqgsyZuKrgn+3AT8TR5mIoYs6Kh1C8mw+ZaOgdf5vTuZpQrh9Mb9J5QvKBdDQwnYnF0YAXxhKRYxpT8SM2B3/bFbpck/zsW84YxwwwsMtFCuAxQNUBy4C13VKeNMXW2rkHUmKJQjOku9VgITVHLPgixFDUbkL7cuLLYdeXwVNsckiP8YOCsCPEkzUHrKbK06b0IonJC7FsH6+6NaCTBKtEuXpvDIzpDIjbNpqVXj7W6H8OJk4xE3y8yxqy4hfaTHiz24yAXW9WUlUz/3cIEHRc8NzblInXdpHX3cXlWF6lvT8i9DNRplJz53kmgd0wRNKq8QhL7ouNzysm2zqRLQugZR+VUqnDzbAPplNSzgiDPiyRv0ZZn4CMlXjdAL0ooRZcCIuN2lBeLH0uanSIDGJwP8qRFUk5/DgXqqdpYbrLDSNHzVfPUKB5yA9ZDoWE+FE3i9P1qZc7tc6zQs05phiVaL02hJhrS6KIbgmCAr9Oq3IqReYA36wWakPPwMGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199024)(186009)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(316002)(2906002)(54906003)(70586007)(36756003)(86362001)(70206006)(6916009)(40480700001)(5660300002)(8936002)(8676002)(4326008)(41300700001)(40460700003)(1076003)(36860700001)(2616005)(83380400001)(426003)(336012)(16526019)(26005)(47076005)(966005)(478600001)(81166007)(356005)(82740400003)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 04:23:18.0366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7434aa-09de-421e-e548-08dbacfeaa43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7832
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Solomon Chiu <solomon.chiu@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: ab041551f4a7 ("drm/amdgpu: add VPE 6.1.0 support")

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202309020608.FwP8QMht-lkp@intel.com
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h | 2 +-
 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c   | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
index b590205d6a28..29d56f7ae4a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
@@ -31,7 +31,7 @@ struct amdgpu_vpe;
 
 struct vpe_funcs {
 	uint32_t (*get_reg_offset)(struct amdgpu_vpe *vpe, uint32_t inst, uint32_t offset);
-	void (*set_regs)(struct amdgpu_vpe *vpe);
+	int (*set_regs)(struct amdgpu_vpe *vpe);
 	int (*irq_init)(struct amdgpu_vpe *vpe);
 	int (*init_microcode)(struct amdgpu_vpe *vpe);
 	int (*load_microcode)(struct amdgpu_vpe *vpe);
diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
index 1259b150dc96..756f39348dd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
@@ -254,13 +254,15 @@ static int vpe_v6_1_process_trap_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void vpe_v6_1_set_regs(struct amdgpu_vpe *vpe)
+static int vpe_v6_1_set_regs(struct amdgpu_vpe *vpe)
 {
 	vpe->regs.queue0_rb_rptr_lo = regVPEC_QUEUE0_RB_RPTR;
 	vpe->regs.queue0_rb_rptr_hi = regVPEC_QUEUE0_RB_RPTR_HI;
 	vpe->regs.queue0_rb_wptr_lo = regVPEC_QUEUE0_RB_WPTR;
 	vpe->regs.queue0_rb_wptr_hi = regVPEC_QUEUE0_RB_WPTR_HI;
 	vpe->regs.queue0_preempt = regVPEC_QUEUE0_PREEMPT;
+
+	return 0;
 }
 
 static const struct vpe_funcs vpe_v6_1_funcs = {
-- 
2.25.1

