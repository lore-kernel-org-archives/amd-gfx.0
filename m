Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD73C47082
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 08:17:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ADF1610C8
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 08:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADF1610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33BC46E880;
	Mon, 31 May 2021 08:17:29 +0000 (UTC)
X-Greylist: delayed 304 seconds by postgrey-1.36 at gabe;
 Sat, 29 May 2021 11:46:02 UTC
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CAF66E0A1
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 May 2021 11:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1622288760;
 bh=HD8lzOiWoLaxBfS2FeOUg/QRwax8VTffDBMUY5S1Ro0=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=X5/wuN4IwgXj0kVm7QkJ1cV2QPdWooGply5GVqrO6tta22tWDMql5yZHm+CwUKZef
 7Zx5Vv2j+5wrkh2YFiSpTLE8iY5ppsXrrvKQBGQqeLEgoSi0leXIrFZeVrDQrf8FOq
 enn4B9UkoZkiF7LQVLKMwlPAoRu12ZdAD8JhqiZM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from schienar ([92.105.189.242]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MZDQ4-1m7v1w0GbM-00Kxio for
 <amd-gfx@lists.freedesktop.org>; Sat, 29 May 2021 13:40:56 +0200
Date: Sat, 29 May 2021 13:40:54 +0200
From: Julian Wollrath <jwollrath@web.de>
To: amd-gfx@lists.freedesktop.org
Subject: 5.13-rc3 Renoir (ChipID = 0x1636): error GPU reset, fences timed
 out, failed to initialize parser -125
Message-ID: <20210529134054.099661dc@schienar>
MIME-Version: 1.0
X-Provags-ID: V03:K1:u7jZIuizNEIMCmXduuGBP6GW+oKYyGi/FEqcmBE1D6BrTvUjXSZ
 kIYQzmVo7rpLMy2Zw6XvABml55tPLTeEwLcg5llw9jp+vAgBbZdACdWliPqJyrE5W0sa2vI
 hviq1ParSlR0rvEz2/jtT5W2aCoH7dZn7j5w/s/Ysv3jsOuvC89Jek9fMAsoZ5aLXXxLuNK
 VGHh9aTO8XHHaZES7vKdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I1wKoC++aUo=:JHK/iaOskeRiOugZvc89qu
 qK4sz05BRgr9CMVJyJE8tbJX6BJFtsqps5lsY3lJW9Qv3DCRs5IlMO20RV5Pb/Fe+ZyWkW6Ux
 hr0t3cnGBNnD8+bRy1D67ZD3YMx2gbW7NgZgNgCe4xDrMfp3qGdcvYuVlQlTnNuF1mNa4IcFy
 6FsFgqZHnIZUDMNqULQKJcWAsJcWa12mOE1lLWurJqgvMc41V2w1+TBvt3CWSxZYmWl7aV/ZO
 yxXdd2fsM226lyOwkeIa/S+guw3vvn16tFLnTJZr0QIjrTM15eefpuesm6vYUedRoGpClEVAK
 FlebTqvMknj3rQYq6+jPfLEIn5+g7EkAAhpP5K0uo0z2Ged51pRPAJwCW/yRP1kez1ohtgFyG
 vBIWg4peQlXhKEoQig0XsNYAK8FWEhGMXTH8wp0zDBPoL5DhfiosI3NpDomSamzpiJlNfV+LA
 7VDPTyepkfLxXKFIaqgx4yd94cwxDiFwZZ3WMGVCic1Wg3H28u4Rqxw0XPrHZKwgogmd14c0/
 4rsm9yPojagn8wSg466ghKH+brNrcojooVWTvG9AO2H68I5szzGeaQqmD8fI6YBvOS2NBn8vW
 V2a/WG4PNFpML8ok3HMn3gjrf5t3Ojsf0pQWzc1J+bUwzUtxqn9HvEvo+LEVcrYZ7AluYHP54
 wmgZPX8kPdaKUb42mscqqbMJ5BdMAE8ikHC5DsUG4JnJlvb7f5l/KVOdep1yeKMejQwUnG3cT
 GHncvKN/xpIy+ghPVDMDnkSe3iR0WGhxRy3NofgmOUXd4JiFMp/YOAeW7bLfSOfVnD5JHkVtT
 vGIxlU3k+JCVUaBNO/rghxRImOSlPgTjEkLVRBEED8LDijLuXUgE75+28vccDB3pp8lnXML7A
 ZfPdBDvRBZreGV/9TBiXDJHFkOYsu80/NKxXUVzIO15c7pRyXf8C89yI0W/5j6Za+vLsyy5Cx
 YEIVVjXDCPcsr0P8EN5HZfzsfZBPjeJZw6m2bFKVwHiNpFVx8fiWcFFAQJpZboRepJU1mlaq1
 X5ze/RkjFL94Q+4Dm6qBRrXTlSYL1GQnyIR/OVSuXVOw4990QEzJAxwSjcYiLE6pWADnnKAjQ
 YSnQkwLtmYQKAFD5e87S2ISVcHpvUPVkxV8
X-Mailman-Approved-At: Mon, 31 May 2021 08:17:26 +0000
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello,

on 5.13-rc3 with a 4650U (Renoir, ChipID = 0x1636) I am able to
reliably get the GPU to reset under X11/Xorg with the amdgpu driver
(current from git) and having persistent problems afterwards. I
achieve this in the following way (using ROOT (root.cern.ch) to draw a
histogram):

$ root
# TH1 *t = new TH1I("test", "test", 2, -.5, 1.5)
# t->Fill(1)
# t->Draw()


this opens a window showing the histogram and results in

kernel: [  370.709485] [drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *ERROR* Waiting for fences timed out!
kernel: [  375.820701] [drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *ERROR* Waiting for fences timed out!
kernel: [  375.830689] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout, signaled seq=3783, emitted seq=3785
kernel: [  375.831015] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process information: process Xorg pid 1028 thread Xorg
:cs0 pid 1029
kernel: [  375.831174] amdgpu 0000:03:00.0: amdgpu: GPU reset begin!
kernel: [  375.924610] [drm] free PSP TMR buffer
kernel: [  375.951409] amdgpu 0000:03:00.0: amdgpu: MODE2 reset
kernel: [  375.951531] amdgpu 0000:03:00.0: amdgpu: GPU reset succeeded, trying to resume
kernel: [  375.951712] [drm] PCIE GART of 1024M enabled.
kernel: [  375.951715] [drm] PTB located at 0x000000F400900000
kernel: [  375.951957] [drm] PSP is resuming...
kernel: [  375.971811] [drm] reserve 0x400000 from 0xf41f800000 for PSP TMR
kernel: [  376.277979] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not available
kernel: [  376.288823] amdgpu 0000:03:00.0: amdgpu: RAP: optional rap ta ucode is not available
kernel: [  376.288830] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
kernel: [  376.288836] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
kernel: [  376.290539] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
kernel: [  376.648574] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
kernel: [  376.649562] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
kernel: [  376.721210] [drm] kiq ring mec 2 pipe 1 q 0
kernel: [  376.722457] [drm] DMUB hardware initialized: version=0x01020008
kernel: [  376.936133] [drm] VCN decode and encode initialized successfully(under DPG Mode).
kernel: [  376.936628] [drm] JPEG decode initialized successfully.
kernel: [  376.936635] amdgpu 0000:03:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
kernel: [  376.936639] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
kernel: [  376.936641] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
kernel: [  376.936643] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
kernel: [  376.936645] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
kernel: [  376.936646] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
kernel: [  376.936648] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
kernel: [  376.936649] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
kernel: [  376.936650] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
kernel: [  376.936652] amdgpu 0000:03:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
kernel: [  376.936654] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
kernel: [  376.936656] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 1
kernel: [  376.936657] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 1
kernel: [  376.936659] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 1
kernel: [  376.936660] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
kernel: [  376.945068] amdgpu 0000:03:00.0: amdgpu: recover vram bo from shadow start
kernel: [  376.945075] amdgpu 0000:03:00.0: amdgpu: recover vram bo from shadow done
kernel: [  376.945081] [drm] Skip scheduling IBs!
kernel: [  376.945084] [drm] Skip scheduling IBs!
kernel: [  376.945119] amdgpu 0000:03:00.0: amdgpu: GPU reset(2) succeeded!
kernel: [  376.945161] [drm] Skip scheduling IBs!
kernel: [  376.945169] [drm] Skip scheduling IBs!
kernel: [  376.945172] [drm] Skip scheduling IBs!
kernel: [  376.945235] [drm] Skip scheduling IBs!
kernel: [  376.945243] [drm] Skip scheduling IBs!
kernel: [  376.945246] [drm] Skip scheduling IBs!
kernel: [  376.945248] [drm] Skip scheduling IBs!
kernel: [  376.945251] [drm] Skip scheduling IBs!
kernel: [  376.945253] [drm] Skip scheduling IBs!
kernel: [  376.948659] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
kernel: [  381.640053] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
kernel: [  381.641067] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
kernel: [  381.641510] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
kernel: [  382.795658] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
kernel: [  382.796462] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
kernel: [  383.157991] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
kernel: [  383.224317] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
kernel: [  383.225321] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
kernel: [  383.226164] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
kernel: [  383.226836] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
kernel: [  383.227294] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
kernel: [  383.227573] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
kernel: [  383.228525] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
kernel: [  391.623243] amdgpu_cs_ioctl: 13 callbacks suppressed
kernel: [  391.623250] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
kernel: [  391.623979] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
kernel: [  396.615491] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
kernel: [  396.616130] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
kernel: [  398.242898] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
[...]

I guess, that this might not be detailed enough information but I am
happy to provide more, if you tell me, what exactly is needed.


With best regards,
Julian Wollrath

--
 ()  ascii ribbon campaign - against html e-mail
 /\                        - against proprietary attachments
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
