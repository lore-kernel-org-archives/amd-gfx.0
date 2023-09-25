Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697CBCE7A89
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 09:33:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E29CD10E220;
	Mon, 25 Sep 2023 09:33:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9908110E220
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 09:33:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpAwxPB9nG6a9sYMJDFPOlZuijVzblQQ6l9L6bT45jcdYFasas/iome5sgEleOLEcV+qiKcA1SIUeCClFxGdxAux7oguj+CuwiOTt4EdFW4xB9X7xeavi7F8j9m1Sdlfq8NDOQ/aLGFcmMYu/yDWlM5T813/j0i0tcH2gbYTrP9CoNvp4cnKEto5Lyb+b6EYoGILydC6LTFCIaI1vaVvTU7tphgjuN6YiTK+hL6HHIBZXKh0MY08dRFgXsw5GM2Q6cwQDyvc1W4OraThAbu7+2mQyxE5emLoJzTFcjbhxFAx0ipN0b8Meh7Xg0nYE6TGonBJ7d2ZFIyZdunTrf5apQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rAtMuRtWsjOA0LHXdBHPzYSqXGfeMEjhg3utryXhBk=;
 b=ljXAK6KBsGrBJdGGldk79xtTSeIPu1bp9aIL8I8fXYrj0PAdMJmTiQmdloELesI3FKJkbXNsoaLrnU7n7SLqR5f9PdH1y94QP3Z8f2y0PEhh+7NFwoA53o1t8Dfe2seoNtiUEyq/3UdGQedb0XrOandTdn9eR2Mg2dum+ojoJS++yC8qH7/x/S33HoPSIa8aVYn1TQrxeLvSxqP+Ed3Uxu0MaYDq0DS82GqXo/ZHXoqsF4pX2w452KOOmAfUhjsaE645HgB/MwIVM6wC0CGBAdZB3ugDUfRwLwexWjW0grDTEfjMuSa6xP2r3wjcg3j2AuFESlOcU4TMsgFw3y3Q4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rAtMuRtWsjOA0LHXdBHPzYSqXGfeMEjhg3utryXhBk=;
 b=Ry8wZGog99B2Mq0bVgaPDVlYRXaQwP0LPDr/TBu/m+L6Hp51l+UDEWUka04MwkBApIRKjOe061x3+u0ZPQZUhxmIdldZKiMuxz+y1aoijI2jt+8lG1pNd21pUJ6x6glp43ggsdm3PDBCrKvchstpVcyqNKNqGR9uH415BMubCOU=
Received: from SN6PR01CA0034.prod.exchangelabs.com (2603:10b6:805:b6::47) by
 SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 25 Sep
 2023 09:33:31 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:805:b6:cafe::61) by SN6PR01CA0034.outlook.office365.com
 (2603:10b6:805:b6::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Mon, 25 Sep 2023 09:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 09:33:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 04:33:28 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 04:33:04 -0500
Received: from dev-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 25 Sep 2023 04:32:58 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdkfd: Fix the svm_bo refcount waring
Date: Mon, 25 Sep 2023 17:32:30 +0800
Message-ID: <20230925093230.3891970-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SJ0PR12MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 66beca4f-00a3-458f-d271-08dbbdaa7b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZa48MziVZFtTCh1Gox+oFSHtbrjsw29reNG0ZF5uTA3ELaiHGPy9mW1WiZBaPwFzNkEs+PhFlFgnr6VeFqLZg1XHKM5jSG8ReqmaVcV+KCAg+52m2m5GdSrHt3Q3/bZ2vTdHYiC2mkFMKtchMmcSzJIrOOhONRAsPa70uJ3TcmkYOO3lcHEm6YZ/Pes3nca0tf8c2SxeWNSsbovU1Y1nvMGKFYxdIyTIL7ctzXwK/0yowZAvv0E+ouovzj7qcbIuSbv5Ip7YBKNJJ+0kLIy0dRk5jqThqeVD1xQUk12FU0COEpsmI4Me67V0kkEWho+E2SwCPw3vBZoM1zXGaJ82zG4D9wPM5BUE7tcy+UNnY5gMQqtd4fDmWAmxkCs5cS/0Uh9pe/A/hYTOOaje0awwFL6TOGZoMvr8vecBRvliOH0Id2IMTq8h5PYvXvO3isNq43pcpu2YTWzu1wEOziIcJAjLSOoZ/0HZ4n4LnwGbSnAbaibW13ms1ifRSQKynMmTc8TbZbop7JZO10lJ9TVncMxmoBbpm09d2GpJJsmzA1ZyKgzrGgLVHqFMev3P8tXDqy+GFEwSR9k4sUOmbQWpLTUPKBIsLPlsq10/1R6jPbuNgd4kiMVNYntosnWMmIp10kasZe3BYqdROLUREID6piV249u8RGcSTJES32WO+RFUqNlfXlVm4mIUSucIJKIcX45Y/In438Q14w97eK3AWWBL9h203YJJHCzd1x67CEInEItvWtu/l1L5ek/TMPy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(82740400003)(26005)(356005)(41300700001)(6666004)(83380400001)(70206006)(316002)(70586007)(81166007)(478600001)(4326008)(8676002)(45080400002)(7696005)(8936002)(110136005)(1076003)(44832011)(2616005)(47076005)(426003)(336012)(86362001)(2906002)(5660300002)(36860700001)(36756003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 09:33:31.3678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66beca4f-00a3-458f-d271-08dbbdaa7b54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661
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
Cc: Jesse Zhang <jesse.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the svm_bo refcount warnging by check the refcount before release.

[  462.649530] ------------[ cut here ]------------
[  462.649532] refcount_t: underflow; use-after-free.
[  462.649536] WARNING: CPU: 7 PID: 1936 at lib/refcount.c:28 refcount_warn=
_saturate+0xf8/0x150
[  462.649542] Modules linked in: amdgpu(E) amdxcp drm_buddy gpu_sched drm_=
suballoc_helper drm_ttm_helper ttm(E) drm_display_helper cec rc_core drm_km=
s_helper i2c_algo_bit syscopyarea sysfillrect sysimgblt rpcsec_gss_krb5 aut=
h_rpcgss nfsv4 nfs lockd grace fscache netfs tls r8153_ecm cdc_ether usbnet=
 r8152 mii joydev input_leds snd_hda_codec_realtek snd_hda_codec_generic le=
dtrig_audio snd_hda_codec_hdmi hid_generic intel_rapl_msr snd_hda_intel int=
el_rapl_common snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec edac_mce_a=
md snd_hda_core usbhid snd_hwdep kvm_amd hid kvm snd_pcm sunrpc crct10dif_p=
clmul ghash_clmulni_intel snd_seq_midi sha512_ssse3 snd_seq_midi_event aesn=
i_intel snd_rawmidi crypto_simd cryptd snd_seq rapl snd_seq_device snd_pci_=
acp5x snd_timer snd_rn_pci_acp3x wmi_bmof snd_acp_config snd snd_soc_acpi s=
oundcore ccp snd_pci_acp3x k10temp mac_hid amd_pmc sch_fq_codel binfmt_misc=
 msr parport_pc ppdev lp drm parport efi_pstore ip_tables x_tables autofs4 =
thunderbolt crc32_pclmul nvme i2c_piix4 nvme_core xhci_pci
[  462.649576]  xhci_pci_renesas video wmi
[  462.649577] CPU: 7 PID: 1936 Comm: kworker/7:3 Tainted: G            E  =
    6.3.7+ #25
[  462.649579] Hardware name: AMD Splinter/Splinter-PHX, BIOS WS43906N_857 =
09/04/2023
[  462.649580] Workqueue: events svm_range_deferred_list_work [amdgpu]
[  462.649771] RIP: 0010:refcount_warn_saturate+0xf8/0x150
[  462.649773] Code: eb a1 0f b6 1d 7c 58 c7 01 80 fb 01 0f 87 11 64 83 00 =
83 e3 01 75 8c 48 c7 c7 a0 00 bc b6 c6 05 60 58 c7 01 01 e8 48 1f 9a ff <0f=
> 0b e9 72 ff ff ff 0f b6 1d 4b 58 c7 01 80 fb 01 0f 87 ce 63 83
[  462.649773] RSP: 0018:ffffb6660603bd88 EFLAGS: 00010286
[  462.649774] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00027
[  462.649775] RDX: 0000000000000027 RSI: ffffb6660603bc48 RDI: ffff91f77e7=
e1548
[  462.649776] RBP: ffffb6660603bd90 R08: 0000000000000003 R09: 00000000000=
00001
[  462.649776] R10: 0000000000000001 R11: 0000000000000028 R12: ffff91f453f=
b2000
[  462.649777] R13: 00000007f7cfc4c4 R14: ffff91f451f2f480 R15: 00000007f7c=
fc4c1
[  462.649777] FS:  0000000000000000(0000) GS:ffff91f77e7c0000(0000) knlGS:=
0000000000000000
[  462.649778] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  462.649778] CR2: 00007f7cfc4c9000 CR3: 0000000113c52000 CR4: 00000000007=
50ee0
[  462.649779] PKRU: 55555554
[  462.649779] Call Trace:
[  462.649780]  <TASK>
[  462.649782]  ? show_regs+0x6c/0x80
[  462.649784]  ? refcount_warn_saturate+0xf8/0x150
[  462.649786]  ? __warn+0x93/0x150
[  462.649788]  ? refcount_warn_saturate+0xf8/0x150
[  462.649789]  ? report_bug+0x1c6/0x1e0
[  462.649791]  ? irq_work_queue+0x14/0x50
[  462.649794]  ? handle_bug+0x46/0x80
[  462.649796]  ? exc_invalid_op+0x1d/0x80
[  462.649797]  ? asm_exc_invalid_op+0x1f/0x30
[  462.649799]  ? refcount_warn_saturate+0xf8/0x150
[  462.649800]  ? refcount_warn_saturate+0xf8/0x150
[  462.649801]  svm_range_free+0xeb/0xf0 [amdgpu]
[  462.649907]  svm_range_handle_list_op+0x1ae/0x1e0 [amdgpu]
[  462.650000]  svm_range_deferred_list_work+0x149/0x2c0 [amdgpu]
[  462.650091]  process_one_work+0x21c/0x430
[  462.650094]  worker_thread+0x4e/0x3c0
[  462.650095]  ? __pfx_worker_thread+0x10/0x10
[  462.650096]  kthread+0xf2/0x120
[  462.650098]  ? __pfx_kthread+0x10/0x10
[  462.650099]  ret_from_fork+0x29/0x50
[  462.650101]  </TASK>
[  462.650102] ---[ end trace 0000000000000000 ]---

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index fcdde9f451bb..44c3f22cb4a1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -436,7 +436,7 @@ void svm_range_bo_unref_async(struct svm_range_bo *svm_=
bo)
=20
 static void svm_range_bo_unref(struct svm_range_bo *svm_bo)
 {
-	if (svm_bo)
+	if (svm_bo && kref_read(&svm_bo->kref))
 		kref_put(&svm_bo->kref, svm_range_bo_release);
 }
=20
--=20
2.25.1

