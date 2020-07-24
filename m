Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2994C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 18:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95BD0206F0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 18:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYYcnuMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BD0206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56A446E9EC;
	Fri, 24 Jul 2020 18:32:01 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB4B6E9EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 18:32:00 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id y3so9143372wrl.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 11:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fh5pFAUqjsLNQkZn93KMsmY0Mt9xwR6GDgkLuQK46bg=;
 b=aYYcnuMtmPIJ2UQKwS1oE/C0P70G1m0m0b/D4R8+vhbZCiDVgk+IpX9036OK9HKlfM
 bKT+8gA6sqXZ9AO33HGMSVeIU+5ywzLk6cmztF+r3Pj4/6boocqSVxwoSWOwXSfqr2DT
 86yB9iIjaFE8TumCIKbLbfdkOgvZmOu1xsjFBluOQj7DTAMivE4BFwqy7suwc9I2KhCc
 oPlya5h++jQ/HOAdYrkeIvjqDCnfqAbIlnxGN9TQUZPv3CuT8exRljlQwGnBU6lbuJUR
 GO4vULH9vjVq6368LV7BmuCPeKtCO8X2Ad2/jbXgxr2h/gvIqZ6qDGq+eUKe1bVk84Jk
 P2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fh5pFAUqjsLNQkZn93KMsmY0Mt9xwR6GDgkLuQK46bg=;
 b=Qgyh27JgQQgeIw5To0K987RGhokAi6GJ2epse3wYDcGA9NiYF95SusEqB0L9xhdeZB
 Cf/HLInPSMDOB3Gkn00XgXwZQ8ED0hFz7oIBhhwE/MNVHaJX84RAQCISY+LulEIBf1rB
 Kc7/SabaWXJHZRM3suFx2AgmFn6d1VLC6V7IYZdygZ+HfuhdxXDlqBBsuVNmIboQOil8
 p0puXu+RRHcIJKgx+FDMH46zO7IT4nCYd6zx+kG8ft+JsMgZqzl0joD0y+0AGIAJR6TS
 m8Krqbhs4tPz1QwFouvZ0jFrv8c1sEXGPT/RcXqXJbXZTRgpD+D8fLLasRz5EtwVv8Up
 aTjw==
X-Gm-Message-State: AOAM530q82CUvV37WoE7z23OHLyG8jrlFp5Scy5SRDIH33zmRvZpClqn
 C1kc+3ugvr+mLXIlXJmX0iJLILFYZlBBhaSnLWc=
X-Google-Smtp-Source: ABdhPJwfKdceEb5xYoCkCnPHNG9np4cBwHOQaP2S8DnlbNbhGjJX/PUEIPUJZvU/mIXnf2eIaMVIfQBPq5PWckG1khI=
X-Received: by 2002:a5d:618e:: with SMTP id j14mr10113503wru.374.1595615518875; 
 Fri, 24 Jul 2020 11:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200716212251.1539094-1-issor.oruam@gmail.com>
 <9139d78a-a242-f973-31ac-a07ce6436396@gmail.com>
 <CAEQFVGY_UL+U7o_1snmQeV0scEMrD4-d8tNKw5CN7s0sZ+CX=A@mail.gmail.com>
 <CADnq5_OyiBsmUmdkA7gnz_ke-kncsSB_J-kS0WJuyePNA=0AcQ@mail.gmail.com>
 <CAEQFVGYAwr_89DNi3UN4PnUg9bceK_str1HiFW6cL81Ptn83bg@mail.gmail.com>
In-Reply-To: <CAEQFVGYAwr_89DNi3UN4PnUg9bceK_str1HiFW6cL81Ptn83bg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 Jul 2020 14:31:47 -0400
Message-ID: <CADnq5_MGcptRH7vYMGhuoXN8SjdYvp7JQu2-WsiXy6VgpbucKQ@mail.gmail.com>
Subject: Re:
To: Mauro Rossi <issor.oruam@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000034238005ab343097"
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--00000000000034238005ab343097
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2020 at 3:57 AM Mauro Rossi <issor.oruam@gmail.com> wrote:
>
> Hello,
> re-sending and copying full DL
>
> On Wed, Jul 22, 2020 at 4:51 AM Alex Deucher <alexdeucher@gmail.com> wrot=
e:
>>
>> On Mon, Jul 20, 2020 at 6:00 AM Mauro Rossi <issor.oruam@gmail.com> wrot=
e:
>> >
>> > Hi Christian,
>> >
>> > On Mon, Jul 20, 2020 at 11:00 AM Christian K=C3=B6nig
>> > <ckoenig.leichtzumerken@gmail.com> wrote:
>> > >
>> > > Hi Mauro,
>> > >
>> > > I'm not deep into the whole DC design, so just some general high lev=
el
>> > > comments on the cover letter:
>> > >
>> > > 1. Please add a subject line to the cover letter, my spam filter thi=
nks
>> > > that this is suspicious otherwise.
>> >
>> > My mistake in the editing of covert letter with git send-email,
>> > I may have forgot to keep the Subject at the top
>> >
>> > >
>> > > 2. Then you should probably note how well (badly?) is that tested. S=
ince
>> > > you noted proof of concept it might not even work.
>> >
>> > The Changelog is to be read as:
>> >
>> > [RFC] was the initial Proof of concept was the RFC and [PATCH v2] was
>> > just a rebase onto amd-staging-drm-next
>> >
>> > this series [PATCH v3] has all the known changes required for DCE6 spe=
cificity
>> > and based on a long offline thread with Alexander Deutcher and past
>> > dri-devel chats with Harry Wentland.
>> >
>> > It was tested for my possibilities of testing with HD7750 and HD7950,
>> > with checks in dmesg output for not getting "missing registers/masks"
>> > kernel WARNING
>> > and with kernel build on Ubuntu 20.04 and with android-x86
>> >
>> > The proposal I made to Alex is that AMD testing systems will be used
>> > for further regression testing,
>> > as part of review and validation for eligibility to amd-staging-drm-ne=
xt
>> >
>>
>> We will certainly test it once it lands, but presumably this is
>> working on the SI cards you have access to?
>
>
> Yes, most of my testing was done with android-x86  Android CTS (EGL, GLES=
2, GLES3, VK)
>
> I am also in contact with a person with Firepro W5130M who is running a p=
iglit session
>
> I had bought an HD7850 to test with Pitcairn, but it arrived as defective=
 so I could not test with Pitcair
>
>
>>
>> > >
>> > > 3. How feature complete (HDMI audio?, Freesync?) is it?
>> >
>> > All the changes in DC impacting DCE8 (dc/dce80 path) were ported to
>> > DCE6 (dc/dce60 path) in the last two years from initial submission
>> >
>> > >
>> > > Apart from that it looks like a rather impressive piece of work :)
>> > >
>> > > Cheers,
>> > > Christian.
>> >
>> > Thanks,
>> > please consider that most of the latest DCE6 specific parts were
>> > possible due to recent Alex support in getting the correct DCE6
>> > headers,
>> > his suggestions and continuous feedback.
>> >
>> > I would suggest that Alex comments on the proposed next steps to follo=
w.
>>
>> The code looks pretty good to me.  I'd like to get some feedback from
>> the display team to see if they have any concerns, but beyond that I
>> think we can pull it into the tree and continue improving it there.
>> Do you have a link to a git tree I can pull directly that contains
>> these patches?  Is this the right branch?
>> https://github.com/maurossi/linux/commits/kernel-5.8rc4_si_next
>>
>> Thanks!
>>
>> Alex
>
>
> The following branch was pushed with the series on top of amd-staging-drm=
-next
>
> https://github.com/maurossi/linux/commits/kernel-5.6_si_drm-next

I gave this a quick test on all of the SI asics and the various
monitors I had available and it looks good.  A few minor patches I
noticed are attached.  If they look good to you, I'll squash them into
the series when I commit it.  I've pushed it to my fdo tree as well:
https://cgit.freedesktop.org/~agd5f/linux/log/?h=3Dsi_dc_support

Thanks!

Alex

>
>>
>>
>> >
>> > Mauro
>> >
>> > >
>> > > Am 16.07.20 um 23:22 schrieb Mauro Rossi:
>> > > > The series adds SI support to AMD DC
>> > > >
>> > > > Changelog:
>> > > >
>> > > > [RFC]
>> > > > Preliminar Proof Of Concept, with DCE8 headers still used in dce60=
_resources.c
>> > > >
>> > > > [PATCH v2]
>> > > > Rebase on amd-staging-drm-next dated 17-Oct-2018
>> > > >
>> > > > [PATCH v3]
>> > > > Add support for DCE6 specific headers,
>> > > > ad hoc DCE6 macros, funtions and fixes,
>> > > > rebase on current amd-staging-drm-next
>> > > >
>> > > >
>> > > > Commits [01/27]..[08/27] SI support added in various DC components
>> > > >
>> > > > [PATCH v3 01/27] drm/amdgpu: add some required DCE6 registers (v6)
>> > > > [PATCH v3 02/27] drm/amd/display: add asics info for SI parts
>> > > > [PATCH v3 03/27] drm/amd/display: dc/dce: add initial DCE6 support=
 (v9b)
>> > > > [PATCH v3 04/27] drm/amd/display: dc/core: add SI/DCE6 support (v2=
)
>> > > > [PATCH v3 05/27] drm/amd/display: dc/bios: add support for DCE6
>> > > > [PATCH v3 06/27] drm/amd/display: dc/gpio: add support for DCE6 (v=
2)
>> > > > [PATCH v3 07/27] drm/amd/display: dc/irq: add support for DCE6 (v4=
)
>> > > > [PATCH v3 08/27] drm/amd/display: amdgpu_dm: add SI support (v4)
>> > > >
>> > > > Commits [09/27]..[24/27] DCE6 specific code adaptions
>> > > >
>> > > > [PATCH v3 09/27] drm/amd/display: dc/clk_mgr: add support for SI p=
arts (v2)
>> > > > [PATCH v3 10/27] drm/amd/display: dc/dce60: set max_cursor_size to=
 64
>> > > > [PATCH v3 11/27] drm/amd/display: dce_audio: add DCE6 specific mac=
ros,functions
>> > > > [PATCH v3 12/27] drm/amd/display: dce_dmcu: add DCE6 specific macr=
os
>> > > > [PATCH v3 13/27] drm/amd/display: dce_hwseq: add DCE6 specific mac=
ros,functions
>> > > > [PATCH v3 14/27] drm/amd/display: dce_ipp: add DCE6 specific macro=
s,functions
>> > > > [PATCH v3 15/27] drm/amd/display: dce_link_encoder: add DCE6 speci=
fic macros,functions
>> > > > [PATCH v3 16/27] drm/amd/display: dce_mem_input: add DCE6 specific=
 macros,functions
>> > > > [PATCH v3 17/27] drm/amd/display: dce_opp: add DCE6 specific macro=
s,functions
>> > > > [PATCH v3 18/27] drm/amd/display: dce_transform: add DCE6 specific=
 macros,functions
>> > > > [PATCH v3 19/27] drm/amdgpu: add some required DCE6 registers (v7)
>> > > > [PATCH v3 20/27] drm/amd/display: dce_transform: DCE6 Scaling Hori=
zontal Filter Init
>> > > > [PATCH v3 21/27] drm/amd/display: dce60_hw_sequencer: add DCE6 mac=
ros,functions
>> > > > [PATCH v3 22/27] drm/amd/display: dce60_hw_sequencer: add DCE6 spe=
cific .cursor_lock
>> > > > [PATCH v3 23/27] drm/amd/display: dce60_timing_generator: add DCE6=
 specific functions
>> > > > [PATCH v3 24/27] drm/amd/display: dc/dce60: use DCE6 headers (v6)
>> > > >
>> > > >
>> > > > Commits [25/27]..[27/27] SI support final enablements
>> > > >
>> > > > [PATCH v3 25/27] drm/amd/display: create plane rotation property f=
or Bonarie and later
>> > > > [PATCH v3 26/27] drm/amdgpu: enable DC support for SI parts (v2)
>> > > > [PATCH v3 27/27] drm/amd/display: enable SI support in the Kconfig=
 (v2)
>> > > >
>> > > >
>> > > > Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
>> > > >
>> > > > _______________________________________________
>> > > > amd-gfx mailing list
>> > > > amd-gfx@lists.freedesktop.org
>> > > > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>> > >
>> > _______________________________________________
>> > amd-gfx mailing list
>> > amd-gfx@lists.freedesktop.org
>> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--00000000000034238005ab343097
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-drm-amdgpu-display-addming-return-type-for-dce60_pro.patch"
Content-Disposition: attachment; 
	filename="0002-drm-amdgpu-display-addming-return-type-for-dce60_pro.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kd0ixy7u0>
X-Attachment-Id: f_kd0ixy7u0

RnJvbSA3ODJmZWE0Mzg3ZDIyNjg2ODU2Yzg3YjhhYzA0OTFhNDNhNGQ5NDRjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFRodSwgMjMgSnVsIDIwMjAgMjE6MDU6NDEgLTA0MDAKU3ViamVjdDogW1BBVENI
IDIvM10gZHJtL2FtZGdwdS9kaXNwbGF5OiBhZGRtaW5nIHJldHVybiB0eXBlIGZvcgogZGNlNjBf
cHJvZ3JhbV9mcm9udF9lbmRfZm9yX3BpcGUKClByb2JhYmx5IGEgY29weS9wYXN0ZSB0eXBvLgoK
U2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2U2MC9kY2U2MF9od19zZXF1ZW5j
ZXIuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2U2MC9kY2U2
MF9od19zZXF1ZW5jZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2U2MC9k
Y2U2MF9od19zZXF1ZW5jZXIuYwppbmRleCA2NmU1YTFiYTJhNTguLjkyMGM3YWUyOWQ1MyAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTYwL2RjZTYwX2h3X3Nl
cXVlbmNlci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2U2MC9kY2U2
MF9od19zZXF1ZW5jZXIuYwpAQCAtMjY2LDcgKzI2Niw3IEBAIHN0YXRpYyB2b2lkIGRjZTYwX3By
b2dyYW1fc2NhbGVyKGNvbnN0IHN0cnVjdCBkYyAqZGMsCiAJCSZwaXBlX2N0eC0+cGxhbmVfcmVz
LnNjbF9kYXRhKTsKIH0KIAotCitzdGF0aWMgdm9pZAogZGNlNjBfcHJvZ3JhbV9mcm9udF9lbmRf
Zm9yX3BpcGUoCiAJCXN0cnVjdCBkYyAqZGMsIHN0cnVjdCBwaXBlX2N0eCAqcGlwZV9jdHgpCiB7
Ci0tIAoyLjI1LjQKCg==
--00000000000034238005ab343097
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0003-drm-amdgpu-display-Fix-up-PLL-handling-for-DCE6.patch"
Content-Disposition: attachment; 
	filename="0003-drm-amdgpu-display-Fix-up-PLL-handling-for-DCE6.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kd0ixy851>
X-Attachment-Id: f_kd0ixy851

RnJvbSAyYjE4MDk4OTE4NzE3ZDllZTRjNjlhNDdiZTM1MjdkMWNjODEyYjdmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IEZyaSwgMjQgSnVsIDIwMjAgMTE6NDE6MzEgLTA0MDAKU3ViamVjdDogW1BBVENI
IDMvM10gZHJtL2FtZGdwdS9kaXNwbGF5OiBGaXggdXAgUExMIGhhbmRsaW5nIGZvciBEQ0U2CgpE
Q0U2LjAgc3VwcG9ydHMgMiBQTExzLiAgRENFNi4xIHN1cHBvcnRzIDMgUExMcy4KClNpZ25lZC1v
ZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlNjAvZGNlNjBfcmVzb3VyY2UuYyB8IDEwICsr
Ky0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTYwL2RjZTYw
X3Jlc291cmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlNjAvZGNlNjBf
cmVzb3VyY2UuYwppbmRleCAyNjEzMzNhZmM5MzYuLjVhNWE5Y2I3N2FjYiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTYwL2RjZTYwX3Jlc291cmNlLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTYwL2RjZTYwX3Jlc291cmNlLmMK
QEAgLTM3OSw3ICszNzksNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJlc291cmNlX2NhcHMgcmVz
X2NhcF82MSA9IHsKIAkJLm51bV90aW1pbmdfZ2VuZXJhdG9yID0gNCwKIAkJLm51bV9hdWRpbyA9
IDYsCiAJCS5udW1fc3RyZWFtX2VuY29kZXIgPSA2LAotCQkubnVtX3BsbCA9IDIsCisJCS5udW1f
cGxsID0gMywKIAkJLm51bV9kZGMgPSA2LAogfTsKIApAQCAtOTgzLDkgKzk4Myw3IEBAIHN0YXRp
YyBib29sIGRjZTYwX2NvbnN0cnVjdCgKIAkJCQlkY2U2MF9jbG9ja19zb3VyY2VfY3JlYXRlKGN0
eCwgYnAsIENMT0NLX1NPVVJDRV9JRF9QTEwwLCAmY2xrX3NyY19yZWdzWzBdLCBmYWxzZSk7CiAJ
CXBvb2wtPmJhc2UuY2xvY2tfc291cmNlc1sxXSA9CiAJCQkJZGNlNjBfY2xvY2tfc291cmNlX2Ny
ZWF0ZShjdHgsIGJwLCBDTE9DS19TT1VSQ0VfSURfUExMMSwgJmNsa19zcmNfcmVnc1sxXSwgZmFs
c2UpOwotCQlwb29sLT5iYXNlLmNsb2NrX3NvdXJjZXNbMl0gPQotCQkJCWRjZTYwX2Nsb2NrX3Nv
dXJjZV9jcmVhdGUoY3R4LCBicCwgQ0xPQ0tfU09VUkNFX0lEX1BMTDIsICZjbGtfc3JjX3JlZ3Nb
Ml0sIGZhbHNlKTsKLQkJcG9vbC0+YmFzZS5jbGtfc3JjX2NvdW50ID0gMzsKKwkJcG9vbC0+YmFz
ZS5jbGtfc3JjX2NvdW50ID0gMjsKIAogCX0gZWxzZSB7CiAJCXBvb2wtPmJhc2UuZHBfY2xvY2tf
c291cmNlID0KQEAgLTk5Myw5ICs5OTEsNyBAQCBzdGF0aWMgYm9vbCBkY2U2MF9jb25zdHJ1Y3Qo
CiAKIAkJcG9vbC0+YmFzZS5jbG9ja19zb3VyY2VzWzBdID0KIAkJCQlkY2U2MF9jbG9ja19zb3Vy
Y2VfY3JlYXRlKGN0eCwgYnAsIENMT0NLX1NPVVJDRV9JRF9QTEwxLCAmY2xrX3NyY19yZWdzWzFd
LCBmYWxzZSk7Ci0JCXBvb2wtPmJhc2UuY2xvY2tfc291cmNlc1sxXSA9Ci0JCQkJZGNlNjBfY2xv
Y2tfc291cmNlX2NyZWF0ZShjdHgsIGJwLCBDTE9DS19TT1VSQ0VfSURfUExMMiwgJmNsa19zcmNf
cmVnc1syXSwgZmFsc2UpOwotCQlwb29sLT5iYXNlLmNsa19zcmNfY291bnQgPSAyOworCQlwb29s
LT5iYXNlLmNsa19zcmNfY291bnQgPSAxOwogCX0KIAogCWlmIChwb29sLT5iYXNlLmRwX2Nsb2Nr
X3NvdXJjZSA9PSBOVUxMKSB7Ci0tIAoyLjI1LjQKCg==
--00000000000034238005ab343097
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-display-remove-unused-variable-in-dce60_c.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-display-remove-unused-variable-in-dce60_c.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kd0ixy882>
X-Attachment-Id: f_kd0ixy882

RnJvbSAyY2VkOGU1Mjg5MzcwNTFlNGQ4NTM2NzE4YzZkYzc3NmUwYjQ2MzE0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFRodSwgMjMgSnVsIDIwMjAgMjE6MDI6MTQgLTA0MDAKU3ViamVjdDogW1BBVENI
IDEvM10gZHJtL2FtZGdwdS9kaXNwbGF5OiByZW1vdmUgdW51c2VkIHZhcmlhYmxlIGluCiBkY2U2
MF9jb25maWd1cmVfY3JjCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTYw
L2RjZTYwX3RpbWluZ19nZW5lcmF0b3IuYyB8IDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2U2
MC9kY2U2MF90aW1pbmdfZ2VuZXJhdG9yLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGNlNjAvZGNlNjBfdGltaW5nX2dlbmVyYXRvci5jCmluZGV4IDRhNWI3YTA5NDBjNi4uZmMx
YWYwZmYwY2E0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNl
NjAvZGNlNjBfdGltaW5nX2dlbmVyYXRvci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY2U2MC9kY2U2MF90aW1pbmdfZ2VuZXJhdG9yLmMKQEAgLTE5Miw4ICsxOTIsNiBA
QCBzdGF0aWMgYm9vbCBkY2U2MF9pc190Z19lbmFibGVkKHN0cnVjdCB0aW1pbmdfZ2VuZXJhdG9y
ICp0ZykKIGJvb2wgZGNlNjBfY29uZmlndXJlX2NyYyhzdHJ1Y3QgdGltaW5nX2dlbmVyYXRvciAq
dGcsCiAJCQkgIGNvbnN0IHN0cnVjdCBjcmNfcGFyYW1zICpwYXJhbXMpCiB7Ci0Jc3RydWN0IGRj
ZTExMF90aW1pbmdfZ2VuZXJhdG9yICp0ZzExMCA9IERDRTExMFRHX0ZST01fVEcodGcpOwotCiAJ
LyogQ2Fubm90IGNvbmZpZ3VyZSBjcmMgb24gYSBDUlRDIHRoYXQgaXMgZGlzYWJsZWQgKi8KIAlp
ZiAoIWRjZTYwX2lzX3RnX2VuYWJsZWQodGcpKQogCQlyZXR1cm4gZmFsc2U7Ci0tIAoyLjI1LjQK
Cg==
--00000000000034238005ab343097
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--00000000000034238005ab343097--
