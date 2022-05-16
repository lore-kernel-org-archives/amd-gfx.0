Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1EFC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 16 May 2022 18:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D39BD112CF1;
	Mon, 16 May 2022 18:15:36 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D876112CF1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 18:15:35 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id v65so19566591oig.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 11:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=r88rdi2zCXXI0pGuD3UUA9RKBsLxJn5VJd3Vvze8y2I=;
 b=oVFl67epiIwWExN3qy7gcScjnGFxjr8VtEC/W+ryYPPDrnb/ut0H9AQUXBCv4zNzmF
 N07cOZ+IF+owny8LtUUsJDNbg/UZSBZJkxgQX5yeFk9avJRBL6Pk0sg/ETWgwojpyk0v
 XY6v1f7ll7Jq3KhABsRoyKdKhnjUpIte5lZFjLCqUFoD2dLMEpLOb8f8Rlm5wQIO4Os6
 77DoNSWMqufcofW596JIyKvfDR4zMMBjv5zG3Lbnsn279p94XW6MawEmL8kbKmfHgUyQ
 F+Ueu8K7E6edK7frNqBx3kTN7mZzeQn1XPGr9sSOZO64sohRCF4MPnEg+6lnl0C6coh6
 A2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r88rdi2zCXXI0pGuD3UUA9RKBsLxJn5VJd3Vvze8y2I=;
 b=Glvfk3QD2P4EliwxeBQpdX7JH80JhyTB317Dsma7gBxCeJjzaO+0l81nfQkI50dlHT
 1xa8gTHi+7RtFDgidUAJjEASAbYHuPnNN42dO8hYENe2re6pPN/C4OSlmqCY2Gm4ztFh
 k9RxbO1AlDR8UVj9DnvWp0/zi1+B4c7t2W4iyZvwJ7vMJQ9O5wFu+wgKh3NxjNkkam4L
 daCIWddpJZArL3CKUW2NzRyAeVL5dixuOQr5Vfs1qW6Xj42Qnce0S0JCAdIMDoiSUSzX
 aMgvNGqORc+8eDTbQ/2R+XZ2MicBAdl81w4bRC1BWbKOQ6yptWY2CWmwcWF45HFWE21Q
 Pd5A==
X-Gm-Message-State: AOAM531jjJi5sVsCdKp6u1BlILLHtudCQmEnWRu4wiBSGPueCP5j40xX
 GKTg5el0sEODNqz0gEC4AXWoouqWjXp6sltPQLk=
X-Google-Smtp-Source: ABdhPJyn01G8Ml6x/rnAEJigcvjUZBj+UNvTcFGAycwG4fO+ROvHDQW/5gvyxyh2ngiY/YuRamAg18HjCvP5A7b6pX4=
X-Received: by 2002:a05:6808:f8e:b0:328:a601:a425 with SMTP id
 o14-20020a0568080f8e00b00328a601a425mr8931081oiw.253.1652724934543; Mon, 16
 May 2022 11:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=4a=VSEST+6oiPRrMNNd1ByQm0e+pG=vCLb--bTXDZT0LnoQ@mail.gmail.com>
 <CADnq5_Ng2sfX5h0OxOu1VU7qGxXbaAfJemFT59ouYgH6SJsiGA@mail.gmail.com>
 <CAD=4a=UT+P33BnKufwGvqYx50qR9SvzEXsPsVJ7Bf2iegMczbw@mail.gmail.com>
 <28edd55e-2e11-20b9-0ee9-3fd3f3a92409@gmail.com>
In-Reply-To: <28edd55e-2e11-20b9-0ee9-3fd3f3a92409@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 May 2022 14:15:23 -0400
Message-ID: <CADnq5_OZ4Nf24rKP19WL5oourZJuasz9J=2j5ivxF_HrBzGRKg@mail.gmail.com>
Subject: Re: VCN_INFO_TABLE_MAX_NUM_INSTANCES vs AMDGPU_MAX_VCN_INSTANCES
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000a2badf05df250236"
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
Cc: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000a2badf05df250236
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 16, 2022 at 2:10 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 16.05.22 um 19:49 schrieb Ernst Sj=C3=B6strand:
>
> Den m=C3=A5n 16 maj 2022 kl 17:13 skrev Alex Deucher <alexdeucher@gmail.c=
om>:
>>
>> On Sun, May 15, 2022 at 11:46 AM Ernst Sj=C3=B6strand <ernstp@gmail.com>=
 wrote:
>> >
>> > smatch found this problem on amd-staging-drm-next:
>> >
>> > drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1443 amdgpu_discovery_ge=
t_vcn_info() error: buffer overflow 'adev->vcn.vcn_codec_disable_mask' 2 <=
=3D 3
>> >
>> > This is caused by:
>> > #define AMDGPU_MAX_VCN_INSTANCES 2
>> > #define VCN_INFO_TABLE_MAX_NUM_INSTANCES 4
>> >
>> > Can we just drop VCN_INFO_TABLE_MAX_NUM_INSTANCES completely and use A=
MDGPU_MAX_VCN_INSTANCES everywhere instead (and bump it to 4)?
>>
>> We should be able to bump AMDGPU_MAX_VCN_INSTANCES to 4 (although it
>> would waste some memory in the places it is used at this point).
>> VCN_INFO_TABLE_MAX_NUM_INSTANCES is part of a firmware structure so we
>> can't change that without breaking the firmware structure.
>>
>> Alex
>
>
> It would be nice to get rid of this pattern and make sure it doesn't happ=
en again when the VCN info table is raised to 5.
> It's very similar to the HWIP_MAX_INSTANCE issue.
>
>
> No, as Alex explained that distinction is intentional.
>
> The firmware definition is 4 for future extensions, that doesn't mean tha=
t this is currently used.
>
> There is currently simply no need to set AMDGPU_MAX_VCN_INSTANCES to more=
 than 2.

Right.  The attached patch should protect against the scenario you are
envisioning.

Alex

>
> Regards,
> Christian.
>
>
> //E
>
>

--000000000000a2badf05df250236
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-discovery-validate-VCN-and-SDMA-instances.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-discovery-validate-VCN-and-SDMA-instances.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l391qroe0>
X-Attachment-Id: f_l391qroe0

RnJvbSA2ZmVjZDNjODZmYmI3Yjg5ZDU5ZDE2Y2ZmZWE0MzhlNWIyYTU5MTVjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IE1vbiwgMTYgTWF5IDIwMjIgMTQ6MTI6MzMgLTA0MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1L2Rpc2NvdmVyeTogdmFsaWRhdGUgVkNOIGFuZCBTRE1BIGluc3RhbmNlcwoK
VmFsaWRhdGUgdGhlIFZDTiBhbmQgU0RNQSBpbnN0YW5jZXMgYWdhaW5zdCB0aGUgZHJpdmVyCnN0
cnVjdHVyZSBzaXplcyB0byBtYWtlIHN1cmUgd2UgZG9uJ3QgZ2V0IGludG8gYQpzaXR1YXRpb24g
d2hlcmUgdGhlIGZpcm13YXJlIHJlcG9ydHMgbW9yZSBpbnN0YW5jZXMgdGhhbgp0aGUgZHJpdmVy
IHN1cHBvcnRzLgoKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3Zl
cnkuYyB8IDE3ICsrKysrKysrKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGlzY292ZXJ5LmMKaW5kZXggMWY0ZTA3YTMyNDQ1Li4yYzRmMWFkYjUzNDMgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMKQEAgLTExMzcsMTMg
KzExMzcsMjQgQEAgc3RhdGljIGludCBhbWRncHVfZGlzY292ZXJ5X3JlZ19iYXNlX2luaXQoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCQkJYWRldi0+dmNuLnZjbl9jb25maWdbYWRldi0+
dmNuLm51bV92Y25faW5zdF0gPQogCQkJCQlpcC0+cmV2aXNpb24gJiAweGMwOwogCQkJCWlwLT5y
ZXZpc2lvbiAmPSB+MHhjMDsKLQkJCQlhZGV2LT52Y24ubnVtX3Zjbl9pbnN0Kys7CisJCQkJaWYg
KGFkZXYtPnZjbi5udW1fdmNuX2luc3QgPCBBTURHUFVfTUFYX1ZDTl9JTlNUQU5DRVMpCisJCQkJ
CWFkZXYtPnZjbi5udW1fdmNuX2luc3QrKzsKKwkJCQllbHNlCisJCQkJCWRldl9lcnIoYWRldi0+
ZGV2LCAiVG9vIG1hbnkgVkNOIGluc3RhbmNlczogJWQgdnMgJWRcbiIsCisJCQkJCQlhZGV2LT52
Y24ubnVtX3Zjbl9pbnN0ICsgMSwKKwkJCQkJCUFNREdQVV9NQVhfVkNOX0lOU1RBTkNFUyk7CiAJ
CQl9CiAJCQlpZiAobGUxNl90b19jcHUoaXAtPmh3X2lkKSA9PSBTRE1BMF9IV0lEIHx8CiAJCQkg
ICAgbGUxNl90b19jcHUoaXAtPmh3X2lkKSA9PSBTRE1BMV9IV0lEIHx8CiAJCQkgICAgbGUxNl90
b19jcHUoaXAtPmh3X2lkKSA9PSBTRE1BMl9IV0lEIHx8Ci0JCQkgICAgbGUxNl90b19jcHUoaXAt
Pmh3X2lkKSA9PSBTRE1BM19IV0lEKQotCQkJCWFkZXYtPnNkbWEubnVtX2luc3RhbmNlcysrOwor
CQkJICAgIGxlMTZfdG9fY3B1KGlwLT5od19pZCkgPT0gU0RNQTNfSFdJRCkgeworCQkJCWlmIChh
ZGV2LT5zZG1hLm51bV9pbnN0YW5jZXMgPCBBTURHUFVfTUFYX1NETUFfSU5TVEFOQ0VTKQorCQkJ
CQlhZGV2LT5zZG1hLm51bV9pbnN0YW5jZXMrKzsKKwkJCQllbHNlCisJCQkJCWRldl9lcnIoYWRl
di0+ZGV2LCAiVG9vIG1hbnkgU0RNQSBpbnN0YW5jZXM6ICVkIHZzICVkXG4iLAorCQkJCQkJYWRl
di0+c2RtYS5udW1faW5zdGFuY2VzICsgMSwKKwkJCQkJCUFNREdQVV9NQVhfU0RNQV9JTlNUQU5D
RVMpOworCQkJfQogCiAJCQlpZiAobGUxNl90b19jcHUoaXAtPmh3X2lkKSA9PSBVTUNfSFdJRCkK
IAkJCQlhZGV2LT5nbWMubnVtX3VtYysrOwotLSAKMi4zNS4zCgo=
--000000000000a2badf05df250236--
