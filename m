Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14598C4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 14:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9581C23A33
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 14:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9581C23A33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB1D96E952;
	Tue,  8 Dec 2020 14:23:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DBB66E952
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 14:23:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoFGI6tImlCwytvS2t0VqEygr4QnZ3NOMoGZzbTVcY1a//1BohBSMmpiglb0mvs6sUWopWGcxXDKVM3v5hJJ40tNszQU8dqx/9P8bS4Hb1liQp8Ns3qzP3UFU0GSQh309QL6z6wO0Pf5P7RpFxXbpCgS8CY6ipbCyAI2hY49AwNrKaU+ZL9nkBkBeuHAE8TteQGrEc8B3EomjtnO9aGEohhaYompx41qz9ovWv5fD/q0LrMkGjD/J8ulrm7QpQA3r3LfBfpv5WiNZHjBbtmvEiNbDw5ezfsai4TyZVCNTfOIq6itmtZTVCABnP/PHod6cdHIhYCxPBi6jVdxjz6kvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNQRls5vnUxV6p6nuOF+hHoi/8ACrX/bQcBm6Msqgtg=;
 b=bQ4ymgMdNl9EmuiDyiHGiKGV739UEfYC2aovtIBflKveofEH5bfQcx+OnCm/wSLtSwQ/2g+HKgIVUgzV9Rb3DuhaGdlBIgtlo1rJmzBQ4mcEenJenH4ZYB/arSvtqAVzfYDak9vXNz046gTVKh+PupqrWB99ucJmCch8Ws9ylMXBNI3t6nzJMQHjOeCZA1o1RKMnud+TihrQDq9UVY70faN/d9DYcSR1Bj1ph0BH25fKzFY+sFa2HSMWRMF0D/Npvc4rHuBShO/5wnl1WhKydOJfwWD/hyp1lE6rNOoMOG3waWelWmZCt8DGS7mr8cFWDfc4jPLfsjMTen1ii0q6kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNQRls5vnUxV6p6nuOF+hHoi/8ACrX/bQcBm6Msqgtg=;
 b=Yha+8tRs7OMTWI4v676s1rCZ7Vcwi18CocayRzHOoQW1qs4Q5ltPEcNzec3tyIivpOQG97aMBq9E3VB3N1qRRAw+W9DiYsWMewnEgrj7PB1YuiO3gItNxbnpT5jluoA1w5x4GDMNuhja7DmVnLczfHXCT8ujJA0xQGlWmRbY6A4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR1201MB0009.namprd12.prod.outlook.com (2603:10b6:3:de::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 14:23:39 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e%7]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 14:23:39 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC drm-misc-next PATCH 1/1] drm/amdgpu: clean up bo in vce and vcn
 test
Date: Tue,  8 Dec 2020 15:23:13 +0100
Message-Id: <20201208142313.9511-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [217.86.115.138]
X-ClientProxiedBy: AM4PR0501CA0066.eurprd05.prod.outlook.com
 (2603:10a6:200:68::34) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.115.138) by
 AM4PR0501CA0066.eurprd05.prod.outlook.com (2603:10a6:200:68::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Tue, 8 Dec 2020 14:23:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4cd37521-f82c-49e6-3758-08d89b84db5f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0009:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0009F1A73690688B5A60C0418BCD0@DM5PR1201MB0009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1z17uWFzXhbJ6BQoWgEoilcBLmS3lV7dWOVUhGBpnJ2OsBQOTKLeuU4+sb0U6Mc3HZIEiRagkNYLRgGM4EMwOAI/CDegNeLdzbI63jLVAT3kzqgA0pMZY8i+eBtFfW6BqRHNhJGtJ+PYAJtBsQihOlsnLD7Tf/cUZY9gkTyjFs4l4rkqvoXRyBRnff5pWImGVHAaT22wN0Eu6d+F6q/ewcZTC20UBJUuMx/oTkh6Ym7lM8/BK+SiYyLxjKheLNZvpb1+FjlT/gD9q0mSU1QMXVa8h+C0wz11pd+ox8J9tJW3569L0w4zVQfY4fcgrMufv3HX1H3E+n3D0jVBcTPRtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(8936002)(66556008)(44832011)(186003)(6506007)(2616005)(52116002)(956004)(66946007)(6916009)(8676002)(1076003)(45080400002)(5660300002)(6666004)(6486002)(316002)(478600001)(36756003)(66476007)(26005)(86362001)(2906002)(6512007)(83380400001)(16526019)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4RGGan0C2diZ5vkQlGMrWTSSs7k36F9sJ/AukQP6t2Rw5aq+iBpiTAYTi8fn?=
 =?us-ascii?Q?d+BOcRVfB/rMwpDlQl7tH11n6nb7wpYmD+4P97GEQhTkrrIV5T3uJsAt/kWd?=
 =?us-ascii?Q?9+aVk8K3GpxslS9HiwE/x2bq0kHmTReB3NZd5Zm2RDr5400H7+5Jlcny330c?=
 =?us-ascii?Q?fCF/WVuFrymqWvyPButMmFfRTGqhlHTA0VuD+pd/OF5ijWczX9vIQiaCaD/Z?=
 =?us-ascii?Q?1pxaoPo/295Z+b4Zo7OY1TIDUd0Vst1DrKoYL3khARIdm0KTHGCxG93PP08C?=
 =?us-ascii?Q?HWZWJVaT6mGbog/wa8ZJ4bnIx48X/suZkV6DVUVaiCNfuUz6Bu/n0hHgZm9I?=
 =?us-ascii?Q?OvKCiLoMPm/3OHEvHqERyyBLLJjkEaPh5rV01+9eoIQ9bcjyW9WC4AXjcv+Q?=
 =?us-ascii?Q?njXPooQYYBX4YOYfOLiDWcTeJKBSafG6Ip/1ov7Pl8Xx3SJjs5RhEm1H7JfJ?=
 =?us-ascii?Q?HOTWuG2O22s4Dnpth1P99KDM7qhYJ+qiqk64wXCJ0BL+ti+VZjS/yTgQswWU?=
 =?us-ascii?Q?NJ7QqB6rRD7C54ynI1NQPVjslVSySeTj9IRX8z2UdFUP8W9rxrwh1OMJhNra?=
 =?us-ascii?Q?8krcwWZICHB5dmf8WBSweF4viYilv+VR3eVvcdS7/juV7QohCufZrhaNHbsP?=
 =?us-ascii?Q?ZNOlFv5fdR20sulQ2Lg/cT+B3CUw0yRuO2MF/T+6M7lUWAm0h+Sw+0pTXBVM?=
 =?us-ascii?Q?ALYlucdbiSJJTYvxD7j6kP+525+Ez/gW676IWpM7Hvk+ZCDA5a4WiRv/0ZF9?=
 =?us-ascii?Q?MG3uKDUa6KYZl07fhj3LK9DxFNTDaGwCUF62M9HAwYO7lxHLqhNtuAPnztVC?=
 =?us-ascii?Q?4prtHKtEkDJ0HqSEePYudXX8kV6dRyejeSuM+pRRRPVMuzsh+1/rM1sGvFJ+?=
 =?us-ascii?Q?PrcWjlNaVs4qDHyGuUsvvhwHdMKGWSoqW+K7loRNou/Gg0I7MAO+J0Rv/yBQ?=
 =?us-ascii?Q?heItw1wY1hk7/K0lryy5YoExDk4iGJIYsYmtywfkISsfRZknyTDBQs+8nsgQ?=
 =?us-ascii?Q?U/05?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 14:23:39.0064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd37521-f82c-49e6-3758-08d89b84db5f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTilxsy7CDn+ORYdYmKIu8p7M1wbIawreJviTRHeq8H2kZs2QzE+lGQDYr/89hl/8AbeDuKOwU7oSEoWP/N3uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0009
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

BO created with amdgpu_bo_create_reserved wasn't clean
properly before which causes:

[   21.056218] WARNING: CPU: 0 PID: 7 at drivers/gpu/drm/ttm/ttm_bo.c:518 ttm_bo_release+0x2bf/0x310 [ttm]
[   21.056219] Modules linked in: amdgpu(E) iommu_v2(E) gpu_sched(E) drm_ttm_helper(E) ttm(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) fb_sys_fops(E) cec(E) rc_core(E) rfcomm(E) af_packet(E) cmac(E) algif_hash(E) algif_skcipher(E) af_alg(E) xt_CHECKSUM(E) xt_MASQUERADE(E) nf_nat_tftp(E) nf_conntrack_tftp(E) xt_CT(E) bridge(E) stp(E) llc(E) ip6t_REJECT(E) nf_reject_ipv6(E) ip6t_rpfilter(E) xt_tcpudp(E) ipt_REJECT(E) nf_reject_ipv4(E) xt_conntrack(E) ebtable_nat(E) ebtable_broute(E) ip6table_nat(E) ip6table_mangle(E) ip6table_raw(E) ip6table_security(E) iptable_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) iptable_mangle(E) iptable_raw(E) iptable_security(E) ip_set(E) nfnetlink(E) ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E) iptable_filter(E) ip_tables(E) x_tables(E) bpfilter(E) joydev(E) hid_generic(E) usbhid(E) bnep(E) btusb(E) btrtl(E) btbcm(E) btintel(E) bluetooth(E) ecdh_generic(E) ecc(E) rfkill(E) dmi_sysfs(E) msr(E) wm
 i_bmof(E)
[   21.056266]  mxm_wmi(E) snd_hda_codec_realtek(E) snd_hda_codec_generic(E) ledtrig_audio(E) snd_hda_codec_hdmi(E) kvm_amd(E) snd_hda_intel(E) kvm(E) snd_intel_dspcfg(E) snd_hda_codec(E) snd_hwdep(E) snd_hda_core(E) irqbypass(E) snd_pcm(E) snd_timer(E) snd(E) soundcore(E) igb(E) sp5100_tco(E) pcspkr(E) i2c_piix4(E) k10temp(E) i2c_algo_bit(E) dca(E) wmi(E) tiny_power_button(E) gpio_amdpt(E) gpio_generic(E) acpi_cpufreq(E) button(E) drm(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) aesni_intel(E) glue_helper(E) crypto_simd(E) cryptd(E) xhci_pci(E) nvme(E) xhci_pci_renesas(E) nvme_core(E) xhci_hcd(E) ccp(E) usbcore(E) btrfs(E) blake2b_generic(E) libcrc32c(E) crc32c_intel(E) xor(E) raid6_pq(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E)
[   21.056307] CPU: 0 PID: 7 Comm: kworker/0:1 Tainted: G            E     5.10.0-rc3-1-default+ #45
[   21.056309] Hardware name: Gigabyte Technology Co., Ltd. X399 DESIGNARE EX/X399 DESIGNARE EX-CF, BIOS F12i 09/24/2019
[   21.056409] Workqueue: events amdgpu_device_delayed_init_work_handler [amdgpu]
[   21.056415] RIP: 0010:ttm_bo_release+0x2bf/0x310 [ttm]
[   21.056418] Code: e9 a1 fd ff ff e8 b1 00 f0 db e9 d2 fd ff ff 49 8b 7e 88 b9 4c 1d 00 00 31 d2 be 01 00 00 00 e8 87 27 f0 db 49 8b 46 d8 eb 9e <0f> 0b 41 c7 86 9c 00 00 00 00 00 00 00 4c 89 ef e8 9c ef ff ff 49
[   21.056419] RSP: 0018:ffff9cca00107d48 EFLAGS: 00010202
[   21.056421] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 000000001ec00000
[   21.056423] RDX: 0000000000000001 RSI: 0000000000000246 RDI: ffffffffc0e61b28
[   21.056424] RBP: ffff90fa735e55b8 R08: ffff90fa731e8db8 R09: 0000000000000000
[   21.056425] R10: ffff90fa7335e000 R11: ffff90fa7335e000 R12: ffffffffc0e61b28
[   21.056426] R13: ffff90fa465f3c58 R14: ffff90fa465f3dc8 R15: ffff90fa5622d600
[   21.056427] FS:  0000000000000000(0000) GS:ffff91019ec00000(0000) knlGS:0000000000000000
[   21.056428] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   21.056429] CR2: 00007f1150baeff8 CR3: 0000000116c70000 CR4: 00000000003506f0
[   21.056430] Call Trace:
[   21.056525]  amdgpu_bo_unref+0x1a/0x30 [amdgpu]
[   21.056635]  amdgpu_vcn_dec_send_msg+0x1b2/0x270 [amdgpu]
[   21.056740]  amdgpu_vcn_dec_get_create_msg.constprop.0+0xd8/0x100 [amdgpu]
[   21.056843]  amdgpu_vcn_dec_ring_test_ib+0x27/0x180 [amdgpu]
[   21.056936]  amdgpu_ib_ring_tests+0xf1/0x150 [amdgpu]
[   21.057024]  amdgpu_device_delayed_init_work_handler+0x11/0x30 [amdgpu]
[   21.057030]  process_one_work+0x1df/0x370
[   21.057033]  worker_thread+0x46/0x340
[   21.057034]  ? process_one_work+0x370/0x370
[   21.057037]  kthread+0x11b/0x140
[   21.057039]  ? __kthread_bind_mask+0x60/0x60
[   21.057043]  ret_from_fork+0x22/0x30

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---

I had to keep amdgpu_bo_unreserve() before calling amdgpu_bo_free_kernel()
or else amdgpu doesn't respond after loading. Is there any better
solution ?

 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 16 ++++++++++------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index ecaa2d7483b2..78a4dd9bf11f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -1151,6 +1151,6 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 error:
 	dma_fence_put(fence);
 	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
+	amdgpu_bo_free_kernel(&bo, NULL, NULL);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 7e19a6656715..dfcdd38ff9c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -491,8 +491,6 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 		goto err_free;

 	amdgpu_bo_fence(bo, f, false);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);

 	if (fence)
 		*fence = dma_fence_get(f);
@@ -504,8 +502,6 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 	amdgpu_job_free(job);

 err:
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
 	return r;
 }

@@ -540,7 +536,11 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	for (i = 14; i < 1024; ++i)
 		msg[i] = cpu_to_le32(0x0);

-	return amdgpu_vcn_dec_send_msg(ring, bo, fence);
+	r = amdgpu_vcn_dec_send_msg(ring, bo, fence);
+	amdgpu_bo_unreserve(bo);
+	amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
+
+	return r;
 }

 static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
@@ -566,7 +566,11 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	for (i = 6; i < 1024; ++i)
 		msg[i] = cpu_to_le32(0x0);

-	return amdgpu_vcn_dec_send_msg(ring, bo, fence);
+	r = amdgpu_vcn_dec_send_msg(ring, bo, fence);
+	amdgpu_bo_unreserve(bo);
+	amdgpu_bo_free_kernel(&bo, NULL, (void **)&msg);
+
+	return r;
 }

 int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
