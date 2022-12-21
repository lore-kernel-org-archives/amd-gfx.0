Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACD5C001B2
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Dec 2022 14:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D899010E51E;
	Thu, 22 Dec 2022 14:51:41 +0000 (UTC)
X-Greylist: delayed 462 seconds by postgrey-1.36 at gabe;
 Wed, 21 Dec 2022 21:25:32 UTC
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7DFD10E4CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Dec 2022 21:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1671657931; bh=q2in+e1HLWnE1wGQk4VVgOzOUGY5RAyE7lsE5OxGVE0=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
 b=PntF1jupEOzYzMgFA2yqnnJ4j1xzJkK18xtrePwafbyv+ooX6wDtOmp6Bf/MtT78X
 gwKpxTCcYY5XxpLCa6rIJpRADATeQDWRYvFmBgFjHo1jwQlts3nc7mcRVD1tbft56v
 lREVXJILLCHmUO7WJZprVWqlqkR1r1MwMKI/JuIyUfvCleAEU3d0e/fzpAPFshQJMa
 05+Z8iyjmyWjEPOQjNWodAxBxa1ycsvnvGZFtxtVDs8/dwuYRqs/9yzWXHP6ZkoTZY
 6buDHs/c/ROrnT8bgG5TU9fKKPKm0TsUdpNNXryJwjziasVcKSVByXECWRrggB56r4
 SuhumSoYgrrXg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([176.198.191.160]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPrPV-1pTBls0BwR-00MjjD; Wed, 21
 Dec 2022 22:12:31 +0100
Message-ID: <a2525c9d1dbfe478f0969439febe55da3e150b60.camel@web.de>
Subject: [PATCH 10/13] drm/amdgpu: use scheduler depenencies for CS
From: Bert Karwatzki <spasswolf@web.de>
To: amd-gfx@lists.freedesktop.org
Date: Wed, 21 Dec 2022 22:12:30 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2-1 
MIME-Version: 1.0
X-Provags-ID: V03:K1:q8OBdEt5Lv1RwwPt2GwsOIOZqpfQx1YrkRqPx9ioxohZTA/XghF
 Z7zuYrMKq7VMSbIUSKrCX1908Zjo7fWVPE6qcSxn9NX6IXNPZg4d8lMIHaQRyWf+sXOe2fe
 TfK5z5klQlqehN2axruiFxL8r4YVah70Yt9259XoQIbnd59oeUybSKDqM1dap+aiOMIZNGZ
 xmXqd2IKk7KEOpCoPtujw==
UI-OutboundReport: notjunk:1;M01:P0:7BsTWBJvxSM=;NOt80auQN1S5pUlPMqxaUkM/7Ah
 qzlQxa0C39ksrkBtQm26C6enPK2Mco60ooqsTC7Vb/W5EuHWh3Ml0fwdyQ3syEUQ8YrWcHE68
 J7UoruIkiVM4iFomaBnfXo7HK47vwpOHRfyJiY16M2/uipm/oIR7kbceN1zEw2Ys8qnrQOTll
 PJQ+NSN5SpQUJoRA1db8rkcSCypO+rBfng4Yv/yyBCk5WRJLCINIf0D/cG0sYQtMSRyZ0bmls
 OuUhLufOo8XprolRC4XiYFFU6cqL/f3eqse9wPm3EgChzrLCQc9dZp/hE/fNGwGUDpbVcm1Wq
 5txxpKqTRu/g44I67hI/yCARxROgSJCX0bvPlSgFoqNXdunPbARyQcIoxAPKDHdDJCo3bDsyj
 phcUfKk65KC4ROSqx/AaYy2JWAZ6JuD+OVely1fLwU35CGmHjc0YDIe8ats+FJ0W1HKSy/SsH
 EtnqK5v0kkTxCv2PniV4O+WF6K+L5Bz+eC1frDRO5P04H6IVGLCMJkY8FyXb+TLIQkilaxz3N
 4fAr/0jgxxl1Ttt4Z6fpXF64F9QB/fOKDTPqhn42qzdmitTxyu8VelJXPyE9ynqSBpZUjYa5z
 1R4MLGhWvLv0A9v3oSXZkoF2Z877EgCzsdsKWbeBgNDdvpe1y18qhu/9mdX3Fnb7mwABJ4UTf
 wkUX1i2T8AvrVRJlFrU4S2AODwMCoHfexdn0+hG/Lhcxp9TSWtGG8S5uMkUd4k5rDqCBQZoNs
 d7/tRlx2G9L7gGuH6hzirnI9XsOvaxIiX41W5F4Uibj9PzMQrXsx4OK37QSb3gMa/0zCTAwB3
 po4HCnbmMI5Ai0eDWvkqDeHbrqWsO43eh2Fj/5tBIKPNC04LalWLIVPLKADQ9Vz2vd90EPVWb
 0Vlx98SLNF6HonV1oemAKHiZRm3zfuR+a4MOjjipztmVFfPzaG2CYL5elIs8ryWwc7Y7k4vZf
 EjCVeXbiKhCkVoLBrmhfBTRkOC0=
X-Mailman-Approved-At: Thu, 22 Dec 2022 14:51:39 +0000
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
Cc: Mike Lothian <mike@fireburn.co.uk>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Can you test if this solves the freezes:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 919bbea2e3ac..4e684c2afc70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1506,7 +1509,8 @@ u64 amdgpu_bo_gpu_offset_no_check(struct
amdgpu_bo *bo)
 uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
 					    uint32_t domain)
 {
-	if (domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM |
AMDGPU_GEM_DOMAIN_GTT)) {
+	if ((domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM |
AMDGPU_GEM_DOMAIN_GTT)) &&
+	    ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asic_type =3D=3D
CHIP_STONEY))) {
 		domain =3D AMDGPU_GEM_DOMAIN_VRAM;
 		if (adev->gmc.real_vram_size <=3D AMDGPU_SG_THRESHOLD)
 			domain =3D AMDGPU_GEM_DOMAIN_GTT;
=20

This solves a lot of seemingly unrelated errors:
https://gitlab.freedesktop.org/drm/amd/-/issues/2255
https://gitlab.freedesktop.org/drm/amd/-/issues/2270
https://gitlab.freedesktop.org/drm/amd/-/issues/2281
https://gitlab.freedesktop.org/drm/amd/-/issues/2282
https://gitlab.freedesktop.org/drm/amd/-/issues/2291

Bert Karwatzki
