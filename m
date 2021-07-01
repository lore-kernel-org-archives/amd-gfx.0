Return-Path: <SRS0=TGuI=LZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38B1C11F64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 18:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF95613FB
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 18:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF95613FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EFF56EB7A;
	Thu,  1 Jul 2021 18:05:19 +0000 (UTC)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78DF06E113
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jul 2021 11:11:27 +0000 (UTC)
Received: by mail-pj1-x1043.google.com with SMTP id
 67-20020a17090a0fc9b02901725ed49016so797048pjz.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Jul 2021 04:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=ZDTsqHPR9u2APCHI3GN4BDQIsbynj8y7NFDA85PVfcg=;
 b=mauRG67GoSlHwqWdBBWaYN/EerCTotVwgFoUABj9a+Xl6j4TPDpDOq9b4sK5cpAv2C
 Thc6RmyaUwTHCLlWrz0RRnWQgRjBTmR1xSf4uwQsqZWdAudZNpGd3rvTsMl9TmxWaNf9
 eezK+eaEDoIN+9rabHJWDC/0VWo87Xu0PPg5LfMqE2pi2YP2HyPOmjraWCHLlGZxo5Cp
 ZrMZacYR5l9UFA5vUZ3XpvEwrcZBohIwU+vmhTBPZY2aoQx3GVaeE+9/LbHed9OnxC76
 3Nny1KJJmDoi8e3NBiN+L4K+j0bPLDuRfRf++pQYbdrOpA7WTovRORCDts1RZ0qBsP0C
 QL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ZDTsqHPR9u2APCHI3GN4BDQIsbynj8y7NFDA85PVfcg=;
 b=KOZHdlxSwGMjx/xvixArECP1ieybJb7penyBjpy+66hloacpdwFAJe2rA+xRoUaa39
 IvnKBzLuIE54Imb/MUc6ivIeWG9nRnld5AZ3ffafGSUgs45dcUMeKb/d4mKKpjlhQiWF
 2iU7RJ3+x1qDUwrsKxHLLAYCg0QPffMX8LyqNCwYtW7yingmXIE+1boU81CFkG179kOq
 GEIRpO2WqhglurvfcZ5U7UBIVhqRwsDH1Ar+8f7+QNB7jagcGnLl+LGudU64viw9jj4k
 dIlsCRon9Qi/u+ZFVgTOhgW6o0lsOGwIW/iig0Rb29zfgKSt+5UgdjCFQQuu4/EkgtQn
 CIFw==
X-Gm-Message-State: AOAM533Nsx7LgVFALWDSRNCQD0l8mnvaap8byvJoZ/SWSK6DREyMGccp
 NOh8XoXzaKIOvBg4kChBZ7tW+Kl4rdvCcZ5RSPxPJHi3
X-Google-Smtp-Source: ABdhPJzxHdozJHsYRUiwGnO0lWbC+aqNJcV5wEEWRViXG8UY7NszoHFwjVooDWkkITI1VbPu5foEIbMioyJYhaeUUeE=
X-Received: by 2002:a17:903:18c:b029:125:b183:798f with SMTP id
 z12-20020a170903018cb0290125b183798fmr36553337plg.24.1625137886708; Thu, 01
 Jul 2021 04:11:26 -0700 (PDT)
MIME-Version: 1.0
From: Ketsui <esgwpl@gmail.com>
Date: Thu, 1 Jul 2021 18:11:15 +0700
Message-ID: <CAB3xKZ35s_wMSSgdH+pjpFJrj=aJLPE92HDjj3z2eLHEwaDFhw@mail.gmail.com>
Subject: Re: AMDGPU error: "[drm:amdgpu_dm_atomic_commit_tail [amdgpu]]
 *ERROR* Waiting for fences timed out!"
To: amd-gfx@lists.freedesktop.org
X-Mailman-Approved-At: Thu, 01 Jul 2021 18:05:18 +0000
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
Content-Type: multipart/mixed; boundary="===============1850510940=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1850510940==
Content-Type: multipart/alternative; boundary="00000000000072c78905c60de6c1"

--00000000000072c78905c60de6c1
Content-Type: text/plain; charset="UTF-8"

I cp'd raven* and picasso* firmware files from upstream version 21.20
and replaced the ones from my distro and I just got another one of these
errors.

[Jul 1 17:08] amdgpu 0000:08:00.0: amdgpu: [gfxhub0] retry page fault
(src_id:0 ring:0 vmid:1 pasid:32778, for process mpv pid 7400 thread
mpv:cs0 pid 7432)
[  +0.000014] amdgpu 0000:08:00.0: amdgpu:   in page starting at address
0x80010008d000 from client 27
[  +0.000010] amdgpu 0000:08:00.0: amdgpu:
VM_L2_PROTECTION_FAULT_STATUS:0x00140C51
[  +0.000002] amdgpu 0000:08:00.0: amdgpu:       Faulty UTCL2 client ID:
CPG (0x6)
[  +0.000005] amdgpu 0000:08:00.0: amdgpu:       MORE_FAULTS: 0x1
[  +0.000001] amdgpu 0000:08:00.0: amdgpu:       WALKER_ERROR: 0x0
[  +0.000002] amdgpu 0000:08:00.0: amdgpu:       PERMISSION_FAULTS: 0x5
[  +0.000001] amdgpu 0000:08:00.0: amdgpu:       MAPPING_ERROR: 0x0
[  +0.000001] amdgpu 0000:08:00.0: amdgpu:       RW: 0x1

--00000000000072c78905c60de6c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I cp&#39;d raven* and picasso* firmware files from up=
stream version 21.20</div><div>and replaced the ones from my distro and I j=
ust got another one of these errors.</div><div><br></div><div>[Jul 1 17:08]=
 amdgpu 0000:08:00.0: amdgpu: [gfxhub0] retry page fault (src_id:0 ring:0 v=
mid:1 pasid:32778, for process mpv pid 7400 thread mpv:cs0 pid 7432)<br>[=
=C2=A0 +0.000014] amdgpu 0000:08:00.0: amdgpu:=C2=A0=C2=A0 in page starting=
 at address 0x80010008d000 from client 27<br>[=C2=A0 +0.000010] amdgpu 0000=
:08:00.0: amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00140C51<br>[=C2=A0 +0.00=
0002] amdgpu 0000:08:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Faul=
ty UTCL2 client ID: CPG (0x6)<br>[=C2=A0 +0.000005] amdgpu 0000:08:00.0: am=
dgpu:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MORE_FAULTS: 0x1<br>[=C2=A0 +0.00=
0001] amdgpu 0000:08:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WALK=
ER_ERROR: 0x0<br>[=C2=A0 +0.000002] amdgpu 0000:08:00.0: amdgpu:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 PERMISSION_FAULTS: 0x5<br>[=C2=A0 +0.000001] am=
dgpu 0000:08:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAPPING_ERRO=
R: 0x0<br>[=C2=A0 +0.000001] amdgpu 0000:08:00.0: amdgpu:=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 RW: 0x1<br></div></div>

--00000000000072c78905c60de6c1--

--===============1850510940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1850510940==--
