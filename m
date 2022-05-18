Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931ACC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 May 2022 07:14:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 924E3113E27;
	Wed, 18 May 2022 07:13:41 +0000 (UTC)
Received: from sonic313-21.consmr.mail.ir2.yahoo.com
 (sonic313-21.consmr.mail.ir2.yahoo.com [77.238.179.188])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B683410E530
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 May 2022 00:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1652833761; bh=HI+VfEe6tOHYE/yKwfP0rXLoiBOX05BUg3O9pFnl7ss=;
 h=Date:From:To:Subject:References:From:Subject:Reply-To;
 b=VKx7v5IDpErPqN/Dp3MbnCmMyx5k2Nv/ux5cBvglIcmkdnsGV9sD0vrO3Y4FDWo6Py8sbhVfc3wK1YyK3oo6MBq/r3YOjmJ99t280uUIcwM3IXhdepu3pVbJliMWuampovbGFuSyic1usnojThDj8HiDePgknpdzzeLG4G+q1bV4tcGtKchI4uR1rgd1W60TBhgl/PE9ll6WeNAHqdVlR8DOT3Vt9P8iZKTKji2qE/nAm8hbHDy3ZLGGuTTXzdCebMqOvWm8C7gau++j+ddYx01Vv8QWvOfQXFIFI78UfwTH2ujsgOUV2kX5EI+wlHEiLB0AbaKnD3NsnqR/UMxnew==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1652833761; bh=4WQ154L3NcgX007R0n6qmzH01bRs5k99vrK5rznVZWd=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=RTyYoCSRh1NPwFuw2CQNB4QTrCRJdQXozUlGVc+jFXZLoKeQPJhYoLpj3KT/WlMZshLd0tMfxOHuRR3twg8rG32DGKwZlbB+kNCI3k9904jkVAlCdiEmmQdUIU93ZM0vKsWNJG+9pNesyUQnoMqBBdr4aOsIYorD2YA+x4Zm3NdqNdsADYcQ3pCCzAiFdSmASQGIC2GnZNuMnbb6czs2JhVPT5Nv0b1aIh1qUIqgJyS0PElHG0m1YUkekpNf2I06T1hVx83/LvDSwH10OcIRW9kmfJAsPeIJo4q6Xrzi1gck1rS62TtvsnPTunKrgu4/An2fgAt4rm20482MYPm95Q==
X-YMail-OSG: KS6rXWYVM1klS01PAHP3tW_ETrBrq4H6gT6Sh1mrKjNKdNQEsXg.Q.13u.TVK0H
 ebMV1qf2pdSV35SSOiVJ8xHGkwUAEv0Us3GJP4cI1H5hwv77tCWNAloIFfmU5I_lpFLVmnoMlEMG
 74gRb7yDS.nYTSfSGfOiQZJKNVM3SM4sQITEiyWKoqLHLb8FitW.6zFy3vbZhUjwmscEo7C7HM1v
 .BsFWx7Jg9QNeqs2H_XDTwGLf0KkosiXOeWXJzvrPNZJLbRgkAmE5aWox3I3XYUk5.PbgaUFL73f
 cKCrXok8M.bOgicyTAvQG.AZC2_NDtE8mFjy5c7uzM200lo_5l8IK5AN19K4Mh996nhHMgYZCIIW
 rK5x0DsdBnIkdruaj8F2zP.d1d7By_Nhzp5qEbTsIf.ILb8Qgeru7k_8PGaAUvHYpxAFB1_fzLUi
 UCgyJoMviT2X0hRWj.76f0whvEaQFRu9wiSXL5igt45HCWYYzKxwIWDesIHqD29RJOv9VyW_iy.c
 CRxuqlOAYI371nEeD1sxOavGGhnVoPGwDndC_dDuAyiGiTMcbCNZs5.L4xIBV6td0x_hI0OgRE9a
 WJckO2wdw6ZJCgRvrQ85hnboUIxFatLFoH9kOf.71NtTX28Z2RGfZAFiqy2T0zTW25J3y2G0gfTd
 Nf2r.GsN9Xby5mjUjda0s_dnF4x8LEdG.auZUhOWtSFcbI6HA.dpF92HKfX_jzyZoWGCjMTMkZt0
 I8BSXvtqVltVT9IYNyZrb2YopW4fCECQzoo9A_FT6WsN02r73T5eZceED8b2TiSFoxuyzhtU4S0k
 bpLyPMRxa0fXcPod6Mr5NVUl77.n9W.shx8D085n2eeN.nxj2mz55.8G_D99VuNNfuQoHPnTZBFK
 _ZWqJCbgfFIDLBc5zGUQ46x_QJKYnN2gPswW.bbiAHt9J43V8g8qBQdBgn7xaa02bM0gw6cwQZdw
 9gSLsrVqNdzWefyDE.qgAQ_L.OWghcm0eXibQR.BOD8wxOHkiKU5y4XpOQY_irlrRaUW14vbhvMo
 fwX4LRVOTYNEejLvDab7wPietQAQxYQ4oKtKuv_RRRAaPQgZttfpKt0bd1i5n3Kj1vt6BmrpmFEG
 PYGco4hdPjsqSvjaCL0c6kuHQb1_ow9VzuzfilA6eMM7GaDZIwVJsN4Ni.ONnO5MUOt4SkZ5o6B6
 wl9VQp5mJ2v6EczuHLacmXR_ip4MV6m0sD96FfHC7.sp_IuxUXpjIDRYRRoKfifva.V.WzCwARCa
 ysudpZNy7bqggcKCCSVAvvuvZ0Mb.A0IapLvfVjRu7l6rgvJJKHmF.RWELgWmChDKBFgG7Kq4tzL
 O1sfgzO9fMFgm64laYWm0FUk_Yhh2Ye3dXaTuLdMhbfCeH_KYfrprChJZzOOpfhljTC_.geDUXg.
 71FMRhA6sw1G3TnKxMKtMitDe86U5KW8MN0gN5wgLEqjYbYkOek2kmGe.Qo1b2AUT4I7q3ioBCVk
 xxk4uDXYm8h.5iT9e0hn.vZGTWpGxdKxL.GXrTn2CWE9PnbT70pAHEYB4o.hOctvaXTkJOEoqpZU
 dI1Zyu1yC3Czqpj3T41KS.Lt3hXWhI.Oq4fbYa1Oa14xSA.07F.c2slleesx1PRdfQqBXtPqsQOj
 mJtZYzwKaNzvDnNXSZmEorXbwBa74E46Ljt.dPsf1Ff75Ld63Iv3QIj1bkcR1Cz_hFogkgFPzWcd
 MhHlsjnIpYb_iXEW7kwy185oVAl0sH6UnfU0Yb0Z_ezlufG0dZlGJZhRRxdlsL8io79ohUfBgg65
 6Hp6DMaVSL8nttHlOeCl5PnDwY4W4JQNDf5.UR8FGUedfqggQpb1AvfKTSJdWVuy7OtOgYiT1AID
 2gfHG.w2MroUrX2IpOT13Z1zY2AhAb.D7bWkQje99McZQf.LgKE6wpDCpNOgT6ZILDX87lp_iFRk
 hSCKWBpwL6nTAmRj8Oznfegk22JLznttAzJlzTobZWPtZqm9Y5Q2rKtaCMgOnhV3iluoZQPYVVvZ
 6PW.KyNcyqBQrdxI5KgYtfP5JRKLkpbhwkGfPhowSiahCu0M4MOIIyZ4dP921ifOnuVf_rLWmLwb
 r4PF7dOlvYkXiIm5Pkt1KN4USxRDv6N6ZgmbGiUv1Lls8sde1CNG18aNGUuafIDR_hjKCotRNJuH
 H_4vZoIkVbiobUoWVxfnIozTkM4txVG08_Jeb56mqsb8OOTFU5cFwq5Lvb.2aau5mEYl6FQ6Q9zm
 z6nIeJM1Id.dwB6FSOuR5NQ--
X-Sonic-MF: <robert.dazi@yahoo.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.ir2.yahoo.com with HTTP; Wed, 18 May 2022 00:29:21 +0000
Date: Wed, 18 May 2022 00:32:25 +0000 (UTC)
From: "robert.dazi@yahoo.com" <robert.dazi@yahoo.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Message-ID: <919822485.7462667.1652833945250@mail.yahoo.com>
Subject: [QUESTION] sh_mem_bases: amdkfd vs amdgpu
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <919822485.7462667.1652833945250.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.20188 YMailNorrin
X-Mailman-Approved-At: Wed, 18 May 2022 07:13:41 +0000
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

There is an interesting feature divergence between amdgpu and amdkfd concerning the shared/private apertures. I restricted my analysis to gfx9, it may differ with other gfx.

In amdgpu, the pair of aperture start addresses is defined the following way (in gmc_v9_0.c):

* shared_aperture_start = 0x2000000000000000ULL
* private_aperture_start = 0x1000000000000000ULL 

In amdkfd, the pair is reversed (cf kfd_flat_memory.c and kfd_device_queue_manager_v9.c):

* lds_base (ie shared_aperture_start) = (0x1UL) << 48
* scratch_base (ie private_aperture_start) = (0x2UL) << 48

Is there any reason why those two definitions diverge ?

Thanks,

RD
