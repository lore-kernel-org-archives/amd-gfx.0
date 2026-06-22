Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF04CDB46F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 12:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2375010E664;
	Mon, 22 Jun 2026 12:08:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="nYX4L4ti";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EC7E10E664
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 12:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=utYkbrL1bc8niYb8vgZbQmInRcJYrBDclmaTAt1h5F4=; b=nYX4L4tiTo3a+98F0AcF/F4Gf3
 W2kSUNqsoIgM4JpLyBpU8GfmeCR3qb7UVwdFj3DjJGuzDt8hiEQs83ZxbGGngoEy4oUMBNCohTfg7
 yUMezAGEJRabbxznSDU3TIi9JpY/W4iJBEipXPhw/8ibjadrfwSq4Uov8yNhC5uZQmBz7Bq01efT7
 pFz411Zf+BDmLbwBEfeJ/Fe6S2jeyJNIZ3dLsndqqkbySA25d8f6k0Mmp+QSGizyLjZvKH/mLN64v
 92cDeYDSoWPdKXDlG2MNndrXuwXWEDN8SqEeCGoApHnSvZruGIVJU6vXgEgOOokeT8lWgCdKHPHVe
 6GDIlPjQ==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wbdSN-003iyo-CJ; Mon, 22 Jun 2026 14:08:51 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 00/16] IB emission compaction
Date: Mon, 22 Jun 2026 13:08:19 +0100
Message-ID: <20260622120835.52473-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi,

We tried this before but it didn't quite work for some non-obvious reason.
Could we possibly try again? I only added SDMA 7.1 since last time, the rest is
as it was.

Btw the ones which grew in size below AFAICT have been "unrolled" by the
compiler now that the writes and increments are more optimised. So even if those
few are larger, they should be faster.

I am also curious about the sdma_inst->burst_nop and wonder if many modern
files really need to be checking given for SDMA major version > 3 it is set like
this:

  if (sdma_inst->feature_version >= 20)
    sdma_inst->burst_nop = true;

How do firmware major and feature map to SDMA ip versions is the question.

Cc: Alex Deucher <alexander.deucher@amd.com>

add/remove: 0/1 grow/shrink: 11/72 up/down: 294/-8261 (-7967)
Function                                     old     new   delta
sdma_v7_1_ring_pad_ib                         99     133     +34
sdma_v7_0_ring_pad_ib                         99     127     +28
sdma_v6_0_ring_pad_ib                         99     127     +28
sdma_v5_2_ring_pad_ib                         99     127     +28
sdma_v5_0_ring_pad_ib                         99     127     +28
sdma_v4_4_2_ring_pad_ib                       99     127     +28
sdma_v4_0_ring_pad_ib                         99     127     +28
sdma_v3_0_ring_pad_ib                         99     127     +28
sdma_v2_4_ring_pad_ib                         99     127     +28
cik_sdma_ring_pad_ib                          99     127     +28
si_dma_ring_pad_ib                            36      44      +8
vcn_v2_0_dec_ring_insert_nop                 200     198      -2
vcn_v2_0_dec_ring_insert_start               272     257     -15
vcn_v2_0_dec_ring_emit_wreg                  402     373     -29
vcn_v3_0_ring_patch_cs_in_place             1215    1182     -33
vcn_v2_0_dec_ring_test_ring                  457     422     -35
si_dma_emit_fill_buffer                      108      71     -37
amdgpu_vcn_dec_sw_send_msg                   810     773     -37
vcn_v2_0_dec_ring_emit_ib                    571     530     -41
si_dma_vm_write_pte                          158     115     -43
vcn_v2_0_dec_ring_emit_reg_wait              536     492     -44
amdgpu_jpeg_dec_ring_test_ring               382     337     -45
si_dma_vm_copy_pte                           137      87     -50
si_dma_emit_copy_buffer                      134      84     -50
sdma_v3_0_vm_write_pte                       163     102     -61
sdma_v2_4_vm_write_pte                       163     102     -61
cik_sdma_vm_write_pte                        163     102     -61
sdma_v7_1_vm_write_pte                       168     105     -63
sdma_v7_1_emit_fill_buffer                   119      56     -63
sdma_v7_0_vm_write_pte                       168     105     -63
sdma_v7_0_emit_fill_buffer                   119      56     -63
sdma_v6_0_vm_write_pte                       168     105     -63
sdma_v6_0_emit_fill_buffer                   119      56     -63
sdma_v5_2_vm_write_pte                       168     105     -63
sdma_v5_2_emit_fill_buffer                   119      56     -63
sdma_v5_0_vm_write_pte                       168     105     -63
sdma_v5_0_emit_fill_buffer                   119      56     -63
sdma_v4_4_2_vm_write_pte                     168     105     -63
sdma_v4_4_2_emit_fill_buffer                 119      56     -63
sdma_v4_0_vm_write_pte                       168     105     -63
sdma_v4_0_emit_fill_buffer                   119      56     -63
sdma_v3_0_emit_fill_buffer                   116      53     -63
sdma_v2_4_emit_fill_buffer                   116      53     -63
cik_sdma_emit_fill_buffer                    116      53     -63
vcn_v2_0_dec_ring_emit_fence                 938     858     -80
amdgpu_vcn_dec_send_msg                      590     507     -83
sdma_v7_1_emit_copy_buffer                   169      76     -93
sdma_v6_0_emit_copy_buffer                   169      76     -93
sdma_v5_2_emit_copy_buffer                   169      76     -93
sdma_v5_0_emit_copy_buffer                   169      76     -93
sdma_v4_4_2_emit_copy_buffer                 169      76     -93
sdma_v4_0_emit_copy_buffer                   169      76     -93
sdma_v3_0_vm_copy_pte                        158      64     -94
sdma_v3_0_emit_copy_buffer                   155      61     -94
sdma_v2_4_vm_copy_pte                        158      64     -94
sdma_v2_4_emit_copy_buffer                   155      61     -94
cik_sdma_vm_copy_pte                         158      64     -94
cik_sdma_emit_copy_buffer                    155      61     -94
sdma_v7_1_vm_copy_pte                        163      68     -95
sdma_v6_0_vm_copy_pte                        163      68     -95
sdma_v5_2_vm_copy_pte                        163      68     -95
sdma_v5_0_vm_copy_pte                        163      68     -95
sdma_v4_4_2_vm_copy_pte                      163      68     -95
sdma_v4_0_vm_copy_pte                        163      68     -95
sdma_v7_0_vm_copy_pte                        183      75    -108
sdma_v7_0_emit_copy_buffer                   317     202    -115
si_dma_vm_set_pte_pde                        338     214    -124
sdma_v7_1_vm_set_pte_pde                     218      72    -146
sdma_v7_0_vm_set_pte_pde                     218      72    -146
sdma_v6_0_vm_set_pte_pde                     218      72    -146
sdma_v5_2_vm_set_pte_pde                     218      72    -146
sdma_v5_0_vm_set_pte_pde                     218      72    -146
sdma_v4_4_2_vm_set_pte_pde                   218      72    -146
sdma_v4_0_vm_set_pte_pde                     218      72    -146
sdma_v3_0_vm_set_pte_pde                     215      69    -146
sdma_v2_4_vm_set_pte_pde                     215      69    -146
cik_sdma_vm_set_pte_pde                      215      69    -146
amdgpu_vcn_unified_ring_ib_header            172       -    -172
gfx_v9_4_2_run_shader.constprop              739     480    -259
amdgpu_vce_get_destroy_msg                   784     496    -288
amdgpu_vcn_enc_ring_test_ib                 2042    1518    -524
uvd_v6_0_enc_ring_test_ib                   1464     926    -538
amdgpu_vce_ring_test_ib                     1357     816    -541
uvd_v7_0_enc_ring_test_ib                   1464     902    -562
Total: Before=9988607, After=9980640, chg -0.08%

Tvrtko Ursulin (16):
  drm/amdgpu: More compact VCE IB emission
  drm/amdgpu: More compact VCN IB emission
  drm/amdgpu: More compact UVD 6 IB emission
  drm/amdgpu: More compact UVD 7 IB emission
  drm/amdgpu: More compact SI SDMA emission
  drm/amdgpu: More compact CIK SDMA IB emission
  drm/amdgpu: More compact GFX 9.4.2 IB emission
  drm/amdgpu: More compact SDMA 2.4 IB emission
  drm/amdgpu: More compact SDMA 3.0 IB emission
  drm/amdgpu: More compact SDMA 4.0 IB emission
  drm/amdgpu: More compact SDMA 4.4.2 IB emission
  drm/amdgpu: More compact SDMA 5.0 IB emission
  drm/amdgpu: More compact SDMA 5.2 IB emission
  drm/amdgpu: More compact SDMA 6.0 IB emission
  drm/amdgpu: More compact SDMA 7.0 IB emission
  drm/amdgpu: More compact SDMA 7.1 IB emission

 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c  |  96 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 134 +++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 105 +++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c  |  51 ++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 108 ++++++++++--------
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 108 ++++++++++--------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 109 ++++++++++--------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 108 ++++++++++--------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 106 +++++++++++-------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 110 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 110 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 119 +++++++++++---------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c   | 102 ++++++++++-------
 drivers/gpu/drm/amd/amdgpu/si_dma.c      |  84 ++++++++------
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    |  72 ++++++------
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |  72 ++++++------
 16 files changed, 927 insertions(+), 667 deletions(-)

-- 
2.54.0

