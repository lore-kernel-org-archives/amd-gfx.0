Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEAFC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 07:12:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10A4C611C2
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 07:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A4C611C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E8CB6E02D;
	Mon, 17 May 2021 07:12:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C2626E02D
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 07:12:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JunUUrbwIrslyn0E/O7F/N52fCX8JrdxBD8PniEQWBvLlskW97VNw3Lr5D8fxVdfjx2jBDtV7xYZZYaAzH6JwGHDJBZldzZ8bZFBJTC0BrX2q1oiI2xhPXxqL7knYt+gqrnQLijUexlOBqJuvkK1uIPiVtVbPRnniT+WyHk+t0LUjnO14tfo6Ccuut/KC9jjfXZeDXMoG1ljyxZFEYfSwOppj2UqPzVUQkStjELNy5iFufyiG63EkUVCbwJxbAKEoaHbtUnJ4PUgvtAKmnV5CDyVGJjYrzFIzsjarMkiKsPb7eHoD0YAORaCidcr2XVBqYY49NDcmyA7SyXLIAoWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qj+qOzRb8uUDbmKC9+f80CIkgcZOcymxmwTzuK38iSc=;
 b=b+/pin3X6ZLIhnZt73hkP9tTHCD7YL0Fdr37jA9EhcInulH+kdagEvIoqWNEp5QOFDJD8sYTF+ZCAAPY530Ko84Qzska55kNQ5LoXf41BYyxaCPhbMytSAOroR7Kc/IFz9xF61ssbx9EO7FaJfx6mjUa5QtNy8ykFC63nQFOeFxN/wflRcT8OC724LfqFdS7ERGnnPYVJsU4Kf033btaNHbcHRWz57pwBx7VYuigsTAZDRqqaspGd0vHwwTqjvT83NTzuVWEqYsgx0R6OKoyHE/pmLGEvL6yu94Sx6L6BkNgQqVTzAz4N0Muh0gzrTMv973/oijKluVnhIvnEJgQTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qj+qOzRb8uUDbmKC9+f80CIkgcZOcymxmwTzuK38iSc=;
 b=fV/73GYlDa2xJdYLiQjFKbbSqYOUM1kWMW34yqj+if7AMewmzgEVsxrpR0jQBTunWusu4g+REmArg4CIJz0y0HKGJ8OBXyXJyQJik3X7nxih7G3bcy4Zr8xDEqqt/lTKqFMGu3xbflV3+L1g4tPFDBKSg6I7JnPeMqV1C9/jumw=
Received: from MW4PR04CA0287.namprd04.prod.outlook.com (2603:10b6:303:89::22)
 by DM5PR12MB1402.namprd12.prod.outlook.com (2603:10b6:3:73::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 07:12:22 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::db) by MW4PR04CA0287.outlook.office365.com
 (2603:10b6:303:89::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 17 May 2021 07:12:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Mon, 17 May 2021 07:12:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 17 May
 2021 02:12:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 17 May
 2021 02:12:21 -0500
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 17 May 2021 02:12:19 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: destroy pinned gem obj according to refcount
Date: Mon, 17 May 2021 15:11:26 +0800
Message-ID: <20210517071125.1513142-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fae3c5a-01d1-4494-87a7-08d919031dcb
X-MS-TrafficTypeDiagnostic: DM5PR12MB1402:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1402949BBDC117D09CDBF5E5B72D9@DM5PR12MB1402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FlABrcDcLJx1/0ZHaxrFBxkup5AyvBl+aikcHbm8DjEIE0OcAlzz3v7zv2Dqg5zaW6cXSVECVw62YiV4sJDY4Vamu232jWApnMkOWv7ZFeoquKp0lvQIshtQCfMayECssty+lAbP0ntO8OpPAO1AmdZnf48vzuVSDsdjvZL6+IZN5yRDQ3vmXtEWfyMiTr4ooj8L7VCqXwayzt3txEhJ5NQwabxW/8G5AhC+7/XI/7DIojyXEQ1UWGb9dDqV9XQUiLkBsiaC/BmNPU2eFDz161biA2MXLemZ18BrW/j4VI6KWPUep7icdeSc7eHNkb60ltcFcAaPMxGjkUA5lDJCb3tkgR0ganGD5JWLsIGZUYM7CXVACx9BKfY91wupJbIvoOG443bsmwJDMnd4JSg0WnDX58vA7Rsx3dzDwe1I2IbinuKU9zppcHcbSJEz2CpkxyU+SBtwvlUiDk6cfLax5jD5nZ9TyfQKvz+miGXA2muNSBvp62jRJlDCblY58Mk7JsyGlF04ttBXL1ea5/ZlA7YCVzC91VY/YLPC7Pb5F1DObkFIlVIKkRDadJroFZBC888K7Qq/2NhWSnw20Mdq+gI2abkSQakDnPpBUmQuSF7PyIeVpk9tNd+nMedrqi4d4iwICYjDUUm9fBxLdKEQLcZ8W/j2z571Z70z4bDM+2wULvoGigg7NlXp877dW7UW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(46966006)(36840700001)(6916009)(5660300002)(82310400003)(6666004)(47076005)(70206006)(186003)(81166007)(26005)(82740400003)(2906002)(356005)(45080400002)(70586007)(36756003)(36860700001)(83380400001)(86362001)(7696005)(4326008)(336012)(426003)(478600001)(54906003)(1076003)(2616005)(8936002)(316002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 07:12:22.3500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fae3c5a-01d1-4494-87a7-08d919031dcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1402
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
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>, monk.liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
the fb gem object is get for 4 times when amdgpu_display_framebuffer_init,
while this object is put for less than 4 times. This can lead to warning trace
when unloading amdgpu

[How]
put gem object according to refcount in amdgpufb_destroy_pinned_object

Warning trace attached:
[324584.505752] amdgpu 0000:00:07.0: amdgpu: amdgpu: finishing device.
[324584.510737] [drm] clean up the vf2pf work item
[324584.532205] [drm] free PSP TMR buffer
[324584.591206] ------------[ cut here ]------------
[324584.591449] WARNING: CPU: 1 PID: 5800 at /var/lib/dkms/amdgpu/5.11.11.119-1259830/build/include/drm/ttm/ttm_resource.h:196 amdgpu_vram_mgr_fini+0x72/0x150 [amdgpu]
[324584.591450] Modules linked in: amdgpu(OE-) amd_iommu_v2 amdttm(OE) amd_sched(OE) amdkcl(OE) drm_kms_helper drm i2c_algo_bit fb_sys_fops syscopyarea sysfillrect sysimgblt intel_rapl_msr intel_rapl_common kvm irqbypass snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg crct10dif_pclmul snd_hda_codec crc32_pclmul ghash_clmulni_intel snd_hda_core snd_hwdep snd_pcm aesni_intel aes_x86_64 crypto_simd snd_seq_midi cryptd snd_seq_midi_event glue_helper snd_rawmidi snd_seq input_leds snd_seq_device serio_raw snd_timer snd mac_hid soundcore qemu_fw_cfg sch_fq_codel binfmt_misc parport_pc ppdev lp parport ip_tables x_tables autofs4 8139too psmouse floppy 8139cp mii i2c_piix4 pata_acpi [last unloaded: amd_iommu_v2]
[324584.591479] CPU: 1 PID: 5800 Comm: modprobe Tainted: G        W  OE     5.3.0-61-generic #55~18.04.1-Ubuntu
[324584.591480] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
[324584.591538] RIP: 0010:amdgpu_vram_mgr_fini+0x72/0x150 [amdgpu]
[324584.591540] Code: 00 00 41 c6 84 24 40 5d 00 00 00 4c 89 f6 e8 85 9d fa ff 85 c0 74 17 5b 41 5c 41 5d 41 5e 41 5f 5d c3 4c 89 ff e8 51 d3 a9 dc <0f> 0b eb c3 4d 8d b4 24 90 5e 00 00 4d 8d ac 24 98 5e 00 00 4c 89
[324584.591541] RSP: 0018:ffff9ce444e7fce8 EFLAGS: 00010282
[324584.591542] RAX: 0000000000000024 RBX: ffff8e86b02c5d60 RCX: 0000000000000000
[324584.591543] RDX: 0000000000000000 RSI: ffff8e86b7a97448 RDI: ffff8e86b7a97448
[324584.591543] RBP: ffff9ce444e7fd10 R08: 0000000000000405 R09: 0000000000000004
[324584.591544] R10: ffff9ce444e7fcd0 R11: 0000000000000001 R12: ffff8e86b02c0000
[324584.591544] R13: ffff8e86b02c5da0 R14: ffff8e86b02c5d40 R15: ffffffffc0c702a8
[324584.591545] FS:  00007fea6fac0540(0000) GS:ffff8e86b7a80000(0000) knlGS:0000000000000000
[324584.591546] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[324584.591547] CR2: 000055b9092b6048 CR3: 000000022f962004 CR4: 00000000003606e0
[324584.591550] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[324584.591550] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[324584.591551] Call Trace:
[324584.591605]  amdgpu_ttm_fini+0xc7/0x230 [amdgpu]
[324584.591657]  amdgpu_bo_fini+0x12/0x40 [amdgpu]
[324584.591717]  gmc_v10_0_sw_fini+0x32/0x40 [amdgpu]
[324584.591767]  amdgpu_device_fini+0x373/0x560 [amdgpu]
[324584.591831]  amdgpu_driver_unload_kms+0x43/0x70 [amdgpu]
[324584.591879]  amdgpu_pci_remove+0x3b/0x60 [amdgpu]
[324584.591950]  pci_device_remove+0x3e/0xc0
[324584.591981]  device_release_driver_internal+0xe0/0x1b0
[324584.591982]  driver_detach+0x49/0x90
[324584.591984]  bus_remove_driver+0x59/0xd0
[324584.591985]  driver_unregister+0x2c/0x40
[324584.591986]  pci_unregister_driver+0x22/0xa0
[324584.592071]  amdgpu_exit+0x15/0x629 [amdgpu]
[324584.592121]  __x64_sys_delete_module+0x146/0x290
[324584.592148]  do_syscall_64+0x5a/0x130
[324584.592165]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[324584.592183] RIP: 0033:0x7fea6f5e4047
[324584.592185] Code: 73 01 c3 48 8b 0d 41 8e 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 11 8e 2c 00 f7 d8 64 89 01 48
[324584.592186] RSP: 002b:00007ffdfa3d75a8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[324584.592187] RAX: ffffffffffffffda RBX: 000055b9092ae120 RCX: 00007fea6f5e4047
[324584.592187] RDX: 0000000000000000 RSI: 0000000000000800 RDI: 000055b9092ae188
[324584.592188] RBP: 000055b9092ae120 R08: 00007ffdfa3d6551 R09: 0000000000000000
[324584.592188] R10: 00007fea6f660c40 R11: 0000000000000206 R12: 000055b9092ae188
[324584.592189] R13: 0000000000000001 R14: 000055b9092ae188 R15: 00007ffdfa3d8990
[324584.592190] ---[ end trace 4ea03bb6309ad6c3 ]---

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
index 4f10c4529840..afdc2c48c060 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -106,7 +106,7 @@ int amdgpu_align_pitch(struct amdgpu_device *adev, int width, int cpp, bool tile
 static void amdgpufb_destroy_pinned_object(struct drm_gem_object *gobj)
 {
 	struct amdgpu_bo *abo = gem_to_amdgpu_bo(gobj);
-	int ret;
+	int ret, refcount, i;
 
 	ret = amdgpu_bo_reserve(abo, true);
 	if (likely(ret == 0)) {
@@ -114,7 +114,10 @@ static void amdgpufb_destroy_pinned_object(struct drm_gem_object *gobj)
 		amdgpu_bo_unpin(abo);
 		amdgpu_bo_unreserve(abo);
 	}
-	drm_gem_object_put(gobj);
+
+	refcount = kref_read(gobj->refcount);
+	for (i = 0; i < refcount; i++)
+		drm_gem_object_put(gobj);
 }
 
 static int amdgpufb_create_pinned_object(struct amdgpu_fbdev *rfbdev,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
