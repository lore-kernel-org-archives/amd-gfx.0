Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D244C982DC
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 12:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B34A10F2F8;
	Fri, 18 Sep 2026 12:05:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="axI4FhmD";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 041C910F300
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 12:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=eeAaGBxYsPjCofXvwY3kT/LPcWH02ceoXIsp8Q+D0MI=; b=axI4FhmDr/hAqE19uDAwv40rBY
 /meZIt3xxN6t4Zo3Dr/NGbifKkO/sg6HtyID2yr5GfBkls3t47OTIzVlb8Eu4/SOwXjYWDIMlcwEw
 C+F4CzJ8TDoxoIMsj0wl9jMSy4ChCh9IE0AouURCChqrtJfo3ZzesIKQH8tJWb2yHgrmPbt84Se45
 m9+c41oSTAEytE22SfKV3PPUyGfdj5wfdK76utgjdkDMr7XzNojwfRVqCzE4Dk0knP211MKV69q4+
 E3QAK+BsaSNLS7YE04A2wAucCO9LtH93MzuE8DlhXvbeVHOeVKnF82L5FFNbyClLZrolFATAUamvF
 xNpsy2mw==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x7XLJ-003vMb-62; Fri, 18 Sep 2026 14:05:25 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 00/18] More compact IB emission
Date: Fri, 18 Sep 2026 13:05:00 +0100
Message-ID: <20260918120518.96922-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Alex might remember this one. Good news is that I think I fixed VCN which was
the reason we had to back it out last time round. Bad news is that I added
GFX8 and GFX9 to the series so maybe I broke something new.

In short, the essence of the series is to replace a pattern of:

       ib->ptr[ib->length_dw++] = bytes - 1;
       ib->ptr[ib->length_dw++] = 0; /* src/dst endian swap */
       ib->ptr[ib->length_dw++] = lower_32_bits(src);
       ib->ptr[ib->length_dw++] = upper_32_bits(src);
       ib->ptr[ib->length_dw++] = lower_32_bits(pe);
       ib->ptr[ib->length_dw++] = upper_32_bits(pe);

With:

       *ptr++ = bytes - 1;
       *ptr++ = 0; /* src/dst endian swap */
       *ptr++ = lower_32_bits(src);
       *ptr++ = upper_32_bits(src);
       *ptr++ = lower_32_bits(pe);
       *ptr++ = upper_32_bits(pe);
 
       ib->length_dw = ptr - ib->ptr;

As bloat-o-meter below shows, it is a nice compaction win for PTE updates and
buffer migrations. Maybe it's not huge but then again a cacheline or two less
code to execute, and cache to store it in here and there is not bad. Also
important is that I find the source code pattern easier to read but for that I
guess it could be a matter of taste.

add/remove: 0/1 grow/shrink: 3/74 up/down: 47/-9705 (-9658)
Function                                     old     new   delta
cik_sdma_ring_pad_ib                         120     151     +31
si_dma_ring_pad_ib                            36      44      +8
sdma_v7_1_ring_pad_ib                        118     126      +8
sdma_v7_0_ring_pad_ib                        118     117      -1
sdma_v6_0_ring_pad_ib                        118     117      -1
sdma_v5_2_ring_pad_ib                        118     117      -1
sdma_v5_0_ring_pad_ib                        118     117      -1
sdma_v4_4_2_ring_pad_ib                      118     117      -1
sdma_v4_0_ring_pad_ib                        118     117      -1
sdma_v2_4_ring_pad_ib                        118     117      -1
sdma_v3_0_ring_pad_ib                        118     115      -3
si_dma_emit_fill_buffer                      108      71     -37
amdgpu_vcn_dec_sw_send_msg                   816     777     -39
si_dma_vm_write_pte                          158     115     -43
si_dma_vm_copy_pte                           137      87     -50
si_dma_emit_copy_buffer                      134      84     -50
sgpr_init_compute_shader                     224     168     -56
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
amdgpu_vcn_dec_send_msg                      596     513     -83
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
amdgpu_vce_get_destroy_msg                   785     497    -288
gfx_v9_4_2_run_shader.constprop              885     519    -366
amdgpu_vcn_enc_ring_test_ib                 2044    1520    -524
uvd_v6_0_enc_ring_test_ib                   1466     928    -538
amdgpu_vce_ring_test_ib                     1363     822    -541
uvd_v7_0_enc_ring_test_ib                   1466     904    -562
gfx_v8_0_late_init                          2295    1533    -762
gfx_v9_0_late_init                          3443    2612    -831
Total: Before=10682414, After=10672756, chg -0.09%

Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>

Tvrtko Ursulin (18):
  drm/amdgpu: More compact VCN IB emission
  drm/amdgpu: More compact VCE IB emission
  drm/amdgpu: More compact UVD 6 IB emission
  drm/amdgpu: More compact UVD 7 IB emission
  drm/amdgpu: More compact SI SDMA emission
  drm/amdgpu: More compact CIK SDMA IB emission
  drm/amdgpu: More compact GFX8 IB emission
  drm/amdgpu: More compact GFX 9.4.2 IB emission
  drm/amdgpu: More compact GFX9 IB emission
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
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 106 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 115 +++++++++----------
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
 18 files changed, 1038 insertions(+), 777 deletions(-)

-- 
2.55.0

