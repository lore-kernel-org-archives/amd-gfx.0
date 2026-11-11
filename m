Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24883606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 23:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=VEZ59UM0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 920B910FC87;
	Wed, 11 Nov 2026 23:52:46 +0000 (UTC)
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F183610EAC0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 23:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1794441158; bh=wpokH0R5I1kr7ZCiAthIXLTFT7D4zlgpKY8Kd6d28uc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From:Subject:Reply-To;
 b=VEZ59UM0Xpjwy6BDWg8u+0t/knfHSsJvqmOlN+vfiHf7wdZHTJMwUydkoTnu+lQZBYbX1neIZ5OdqsTN4uuwnmdIfapFSYnRVBYtAgVzxGx81zd17lQ2CdPMx55g18bxz5BtXhqwcJ8NajpPhacpE6epRa3QO3Q6pYTbtC+gAIifOMsoOW5bv6mdSto7pkyIoX3OOwjM/yh2KaUuNJfyVpN6m1cBypIYG242LNdZdaghEDZOAGOThZaHQtnsPO+cizGto5PSkxEkdBapjpmWbWWuvlfAPgyP53US9O8CYxAQwbXfGeDWccDOcl0iIjFrCa0NbGTDj3JEYaHLNzlsPQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1794441158; bh=Jn70xYX2c5N8oMr8C8NQA69aCI3ziflFch3nTQNLTU4=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=jNDCxtf1u3b11mnAox8st/SRrHmfKcLSisKm9E6yHaXNpMwFaCUHBCZjwtkOpFGeO+fLhZUF/kZwzIGoTuVlsyl2Ry7Oa/N+klI/e3ue3+THCgABGwEBRaLGoysfmcbo7sDdDpC9rPF/kvgIy9dh+Kdpzhosv3zWRhFDlQ+gBbNkiAGaBlL/R7zDp8lUTQltAFrIPvBsoy53Dfi2x46sTsL6rPEEU++i3FlMwd7+8o4VNDxDsYaoudriSXk/EIZWNCegrEvTr7AabFIahKtbW5WRTmwWwqrhNOqiTQVSApWHqRFOSbe8FfS3Uzsc+634l3nqLbWnbACAJzt+7swFdw==
X-YMail-OSG: F3SmCxEVM1lumNlre3RQZHLg2v7UBaCxJXYY_KVTnKAoHGQpEuKwn0W3rPIFf1p
 ACd0AWRcAcjPoC1odZ5vwxssiXHJRgVk9IwIHggCD3jkMvp6hq8ucEQJs0IZdEZfiWETtlzhOk6z
 FYv6Kvj7IINjWyHUUW___mEwtD5UsIN_60iGLNjz80vcUdxIa4SFmpak3YdWQZkRLed_YsjdJsa0
 1UASoAzD75iCZ8jixz2RPHFePg0eyYAp.a9eeoj3OrD.Esiev0mzw92kw2fijycU6buFKZGjkqeg
 N0Yh6aYuMvLewRxB2WyjYvWvpkfhuWK.qHHN3kbfr9I3uJzOr4QchGTL37cVkKfmU1kFbpMGPyU8
 2keRt31Jg1fbSfp228QQ0KWmXsII.LuEd0kJoBTGlRdm6jtI3CxPp8k8LIUyztVjnQz2k_RjjHZo
 D43zhnubt_W_R.EM4KlzXSxlh_0kD3Nj22xr6KmTaCAzvtYO_7wfHQVtNpgZSPpo0XjmPHfPow99
 6nIHiAQF_6uadQxIrJ5YU.PIC_eR7mr1FWyGhYnOPBs8kKchl37BjZsy7jFMCnl_s68DF5h8Eh6E
 kIuaN7Ue478unYlOLKq99tn72dI1Ws2iySvFeFyRQuEJsLUBLs9Xvf6T3nyb2MibQ1_MHHEyIC8X
 EqoN_v.rZ0dAAgBe18SX4l4Dlq7k1XIrNUV9q3ssRhkAs5FVA76KxXkbkg8DRsaGz6jvYH._HKcj
 wBwV3d6Gp5tUPOA5Z.pPH4IoSLYOpDGgkkG4tgi.asXQauFlzoQhCWQDlwwgJY9mHxIiSMPppFe_
 KkOBdTwNUXEWuCtkvNgAU_ABjdD5RE6KYgZfMKlAG.NewitsDuSXk.CRSYUQGg4Fk9cF9_FZoOh_
 Sy8EfnjSajw5OtD9Bq0yB0T3d4MdNrcb7T3deKUjNcj8c1.M.pvQ.9Y1Hv5_9cO6VpXopH3ZLopv
 3jNgcc4t.8JpIYmlMBt0G.v4nKwQ_VxljtZGKpF.DeS_wSm5B614zOeNlpP1NSfptDYzTuy4sBC7
 IU94oNopsITPmit2yCmGwKRrh4ZVU9RfGw1BZCXTdlKBFfPw_sZodlA7hI8ZUCVTqJgqaOnQO3Iw
 hSXF8MevUk30oDMQR86BzDoGRn4W.qRZs64gOCM6WUGVWLIGqM2GJ1pnDC23xivCjJBLPfU9ecxA
 JXUZeQrD1OHZtcEmizhsPNxEMAtD34MhWNuMlMmoJ2l6sVAwbWAak5aHWheSpvssNKn_7wdzcdS0
 7xEGeS87RR4h1flSvgsZTgXd4TdJpZ1Obm8qdN_HoABMFzOQi97SAzxg7V3ZFNU_Th1WOTyf9yjq
 KIf6vvHP5xKWxauIyopc357KopbigrSG0mZWt9eghfNkXASWQDLmwIuNmhw7QPRvw14S9xjkTZ0M
 lI7KS.2kanperSOifhxbODAaSH2cWGr2hPr7az7nNnvZg_nDWBNDw386NKBP9HAV5oq8MSLVWPiB
 xEFAk.kDJE48FTmbwjzzsygHif1k4GNi5FjzB9D5w5dwr1.rI7RYuLafF.QyruqKIVIYf5YOwfmY
 YectyClCbgRobfo.G7qeSYn8tSnvd_I32mnAbAJwyzw1k32rwHqZnxH1cgJC95dyr7g.FV6LeiLr
 w7klmEHlL.zdCcMSmy5gr_j01zpmaadPY8oHjtstVqTvF7dxnergxZnpldTBCMWdiNphURoukg6W
 LM6_.YfwWk8s1gTlHRvPGGAtvcfJ5Kv6J8EvfloJM3KyoupCjw33OqIilo76oFCcI9stSAyYRVqf
 PEAf6c7jYJBDuytObVJ8qojNqpwlnbl6GDPCNFtboZa5.vSAYsijdgdtJlWi98LWDWYinmldZ4_6
 bPx02YhvYcIaDWhzPBlBEQsR.6t6QyhmHqQSLy8tWykIlkHEI8ssvrtz4cC9hVlN46P4UA6SoxkU
 uKPeiLxGktyak26Bs9NezBakChTUYUb9chIo.GjkB5ktr_NTLfRguW_tXMrqMbwJ50_VUwEurQTx
 ZB41y3_fshz8NjNFbcw--
X-Sonic-MF: <Capitain_Jack@yahoo.com>
X-Sonic-ID: 78ea69a9-fc2f-41b3-9443-55a4d3236cf4
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-101 with HTTP;
 Wed, 11 Nov 2026 23:52:38 +0000
Received: from dip58.lsn.bf1.yahoo.com ([67.195.177.67])
 by hello (SMTP) with SMTP ID dbbdfc98512955ad00300983fb6d569a;
 Wed, 11 Nov 2026 23:52:36 +0000 (UTC)
From: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian Koenig <christian.koenig@amd.com>, Lijo.Lazar@amd.com,
 timur.kristof@gmail.com, Mario.Novales@amd.com, Manu.Rastogi@amd.com,
 Jiongyu.Zhu@amd.com
Subject: Re: [PATCH v4 02/13] drm/amdgpu/ring: During multi-queue reset, only
 call begin helper if needed
In-Reply-To: <20261105030612.726542-2-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
 <20261105030612.726542-2-Jesse.Zhang@amd.com>
Date: Wed, 11 Nov 2026 20:52:31 -0300
Message-ID: <179444115180.3832992.1301263618733439762@yahoo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailer: WebService/1.1.27008
 mail.core.serving.mcws.prd.acl:role.token.mcws.jsmtp.yahoo
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_YAHOO_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Timur, Jesse,

A test result from gfx6 (Southern Islands), where no ring reset runs
before the IP block soft reset. I found and tested this with the help of
an AI assistant, on my own laptop.

Machine: Radeon R5 M330/M430 (Hainan, 1002:6660) beside a Carrizo iGPU.
Test: a plain Vulkan program with one compute dispatch that runs past the
2 s lockup timeout (a counted ALU loop, no bad memory access), then one
short job to see whether the context was marked lost.

On 7.3.1 as released, one such job puts the ring into this loop until a
reboot, every 3.45 s (a WebGPU page did the same: 1,449 timeouts of one
sequence number):

  amdgpu 0000:03:00.0: ring gfx timeout, signaled seq=30, emitted seq=31
  amdgpu 0000:03:00.0: Starting gfx_v6_0 IP block soft reset
  amdgpu 0000:03:00.0: Successful gfx_v6_0 IP block soft reset
  amdgpu 0000:03:00.0: [drm] device wedged, but no recovery needed

The devcoredumps show why: after the first soft reset the replayed
stream is consumed (Rptr == Wptr) but the fence is not written within
the next 2 s; at the next timeout the backup helper sees the same guilty
fence, clears ring->guilty_fence and backs up nothing, and
amdgpu_multi_ring_reset_helper_end() passes that NULL on, so nothing
ever completes the fence.

With this patch (v4 02/13) on 7.3.1, same program, same machine:
- two 8 s jobs: 2 timeouts each, then nothing more;
- one 60 s job: 3 timeouts, the job ended 10.8 s after it was submitted.
In all three the next submission returned VK_ERROR_DEVICE_LOST, nothing
was left in D state, and the session kept running.

For comparison, v3 02/15 ("complete the guilty fence at the end of a
multi ring reset") on the same 7.3.1: 2 timeouts for each 8 s job, 1 for
the 60 s job (ended after 3.4 s), the same result otherwise.

So on this chip both end the loop. One run of each case; I backported
only this patch's single hunk (01/13 not needed for it to apply).

I can send the test program and the dumps if they are useful.

Thanks,
Daniel

Tested-by: Daniel Campos Ramos <Capitain_Jack@yahoo.com> # gfx6, Hainan
