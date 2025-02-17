Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8B7C021A9
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2025 16:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CF7510E537;
	Mon, 17 Feb 2025 16:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G4kJCL/W";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FB9A10E53B
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2025 16:00:14 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2fbfa7100b0so1101150a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2025 08:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739808014; x=1740412814; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ueTj5ZO31uXjyv/62G6E104VecareS4hLbaJX3FHHb0=;
 b=G4kJCL/W+D9x/wlx9hyj8WfLUm5sJJ9jE01Sj0ibHJlLLgKpHH/6RR9EPm5aXgLdtT
 9EFBHpj6Tq3e2AvUwRbWn5MTf8ar77MaOcNJoJup4TmcRaBCpQ8bbQdphJ1OacU4Bt5m
 xvrkRUjzIWUtk6pIVGvaCCU4vTqaqpqGvO6hidP7nHgrGFlrMfdF28U0hG+JAONYkkOx
 E11zNF9yuhWt5W6wQ6rZbNZtT527TsY5Uu8Y4ZuHipfk/HP3KLZ/r2vnb1JdoHIgm9el
 7tMgzmAKBe00L+yfHYEFACFsHgxTFJiEVsk+Sb5M7QayvLfYgv5b8JlkTA0j3BKFMY0Q
 E/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739808014; x=1740412814;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ueTj5ZO31uXjyv/62G6E104VecareS4hLbaJX3FHHb0=;
 b=IokEEBpWtwQ7sqvBgZefAP87gnSUw13piHwjNEBBynmURW+eXTp91r7tKeI+4Wudp+
 Z+gB91OIwrZYaVIW6EJQdhqwSsEP3JJxnDO8WhSAeruNGe6ReF99VcVT8jMzyclcJJhu
 4WdKEMhiEHeEwjUeZVVfn1j3AOhS0nP3ovSKTLI7eeosroiRC+zM8RoHLwYrBg5DBUUi
 I+R0RD03fOCr6PkJs15LnYeJ1X98DCu5YtwWAfw8/WjOuI6BVjfOWZ4ywVxp7ubtONj8
 xsDGW/sPI/9vZBCNt8enZm2+2htEfTM5YiPSHIoClX14r3s6ZiDlhyRSg7qbOLHYCkCR
 o7NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi1ToPt64Y0mALeG97waB8hSANm2FgVF4Q4+WN2wMygt195UqFua1CIHYNS0067l4czNAQkJPM@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVI7VFRwhH88L0VBLSk5hZgUDEPIR2BgAkt5Qa06APtf8XlRwB
 OVByyMl7eUPzdn9HKniA9SQibcLirSY2+/IT0aAKlKhpcm+N40lIOallRr94zClseCTKFUxtqQ2
 zUl9dKR7gfVDBM4NsnKdvnf62iPs=
X-Gm-Gg: ASbGnctDWIhQSLOUmzYgeFm+5IXJjeGQGWiRuwz2kXOCfyXjApfMk5BUX8ztmZr0UJ7
 Wl8Js1paCDL3M4UVYWWczixN2uxR8kbUOaGo4kQZCuJw8hB2VbpZMNdQQzsGVgbWUKa5TMy1W
X-Google-Smtp-Source: AGHT+IHO9/ak88DCQz1bcYSUoj5Y5QgAVWei+EhPjy+Pwmflvp2i1lowLTD/lmvhwbzrTOmOncULAnttHlaPdegO07I=
X-Received: by 2002:a17:90b:4c46:b0:2ee:f59a:94d3 with SMTP id
 98e67ed59e1d1-2fc40792d5bmr6279923a91.0.1739808012618; Mon, 17 Feb 2025
 08:00:12 -0800 (PST)
MIME-Version: 1.0
References: <20250217151053.420882-1-alexander.deucher@amd.com>
 <1654fb6c-e0e8-4dde-8554-7058cf73503d@amd.com>
 <CADnq5_NUEuMFsd__w1eGBWALxcQwtX7sa2Sn53vDjaxrqNuhPQ@mail.gmail.com>
In-Reply-To: <CADnq5_NUEuMFsd__w1eGBWALxcQwtX7sa2Sn53vDjaxrqNuhPQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Feb 2025 11:00:00 -0500
X-Gm-Features: AWEUYZmGoN9BY0F6L8OwbUtyHoHkrVjfUrEeojzRF-byVv_RMIaipxzCHHwLogY
Message-ID: <CADnq5_NEhv-E9ZxHvxhBtFb_cBkPqMfu-nsQfEknO30tNBjA2Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: fix Sapphire PCI rebar quirk
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, bhelgaas@google.com, 
 linux-pci@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 Mario.Limonciello@amd.com, Nirmoy Das <nirmoy.aiemd@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000091e707062e589e83"
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

--00000000000091e707062e589e83
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 10:45=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Mon, Feb 17, 2025 at 10:38=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > Am 17.02.25 um 16:10 schrieb Alex Deucher:
> > > There was a quirk added to add a workaround for a Sapphire
> > > RX 5600 XT Pulse.  However, the quirk only checks the vendor
> > > ids and not the subsystem ids.  The quirk really should
> > > have checked the subsystem vendor and device ids as now
> > > this quirk gets applied to all RX 5600 and it seems to
> > > cause problems on some Dell laptops.  Add a subsystem vendor
> > > id check to limit the quirk to Sapphire boards.
> >
> > That's not correct. The issue is present on all RX 5600 boards, not jus=
t the Sapphire ones.
>
> I suppose the alternative would be to disable resizing on the
> problematic DELL systems only.

How about this attached patch instead?

Alex

>
> >
> > The problems with the Dell laptops are most likely the general instabil=
ity of the RX 5600 again which this quirk just make more obvious because of=
 the performance improvement.
> >
> > Do you have a specific bug report for the Dell laptops?
> >
> > Regards,
> > Christian.
> >
> > >
> > > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707
>
> ^^^ this bug report
>
> Alex
>
>
> > > Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 560=
0 XT Pulse")
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Nirmoy Das <nirmoy.aiemd@gmail.com>
> > > ---
> > >  drivers/pci/pci.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 225a6cd2e9ca3..dec917636974e 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -3766,6 +3766,7 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev=
 *pdev, int bar)
> > >
> > >       /* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0=
 */
> > >       if (pdev->vendor =3D=3D PCI_VENDOR_ID_ATI && pdev->device =3D=
=3D 0x731f &&
> > > +         pdev->subsystem_vendor =3D=3D 0x1da2 &&
> >
> >
> >
> >
> > >           bar =3D=3D 0 && cap =3D=3D 0x700)
> > >               return 0x3f00;
> > >
> >

--00000000000091e707062e589e83
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-disable-BAR-resize-on-Dell-G5-SE.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-disable-BAR-resize-on-Dell-G5-SE.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m798rc7j0>
X-Attachment-Id: f_m798rc7j0

RnJvbSAzODQxZGQ5MDQ4NDQ4NjA4NjNjNDg5Nzk2NzEwZDJkOWZlZTA1YmNiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IE1vbiwgMTcgRmViIDIwMjUgMTA6NTU6MDUgLTA1MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1OiBkaXNhYmxlIEJBUiByZXNpemUgb24gRGVsbCBHNSBTRQoKVGhlcmUgd2Fz
IGEgcXVpcmsgYWRkZWQgdG8gYWRkIGEgd29ya2Fyb3VuZCBmb3IgYSBTYXBwaGlyZQpSWCA1NjAw
IFhUIFB1bHNlIHRoYXQgZGlkbid0IGFsbG93IEJBUiByZXNpemluZy4gIEhvd2V2ZXIsCnRoZSBx
dWlyayBjYXN1c2VkIGEgcmVncmVzc2lvbiBvbiBEZWxsIGxhcHRvcHMgdXNpbmcgdGhvc2UKY2hp
cHMsIHJhdGhlciB0aGFuIG5hcnJvd2luZyB0aGUgc2NvcGUgb2YgdGhlIHJlc2l6aW5nCnF1aXJr
LCBhZGQgYSBxdWlyayB0byBwcmV2ZW50IGFtZGdwdSBmcm9tIHJlc2l6aW5nIHRoZSBCQVIKb24g
dGhvc2UgRGVsbCBwbGF0Zm9ybXMuCgpDbG9zZXM6IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9w
Lm9yZy9kcm0vYW1kLy0vaXNzdWVzLzE3MDcKRml4ZXM6IDkwNzgzMGIwZmM5ZSAoIlBDSTogQWRk
IGEgUkVCQVIgc2l6ZSBxdWlyayBmb3IgU2FwcGhpcmUgUlggNTYwMCBYVCBQdWxzZSIpClNpZ25l
ZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA2ICsrKysrKwogMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYwppbmRleCA1MTJlNjQyNDc3YTdlLi41NmZkODc0YTIyZGU4IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC0xNjYyLDYgKzE2
NjIsMTIgQEAgaW50IGFtZGdwdV9kZXZpY2VfcmVzaXplX2ZiX2JhcihzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikKIAlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQogCQlyZXR1cm4gMDsKIAor
CS8qIHNraXAgcmVzaXppbmcgb24gRGVsbCBHNSBTRSBwbGF0Zm9ybXMgKi8KKwlpZiAoYWRldi0+
cGRldi0+dmVuZG9yID09IFBDSV9WRU5ET1JfSURfQVRJICYmCisJICAgIGFkZXYtPnBkZXYtPmRl
dmljZSA9PSAweDczMWYgJiYKKwkgICAgYWRldi0+cGRldi0+c3Vic3lzdGVtX3ZlbmRvciA9PSBQ
Q0lfVkVORE9SX0lEX0RFTEwpCisJCXJldHVybiAwOworCiAJLyogUENJX0VYVF9DQVBfSURfVk5E
UiBleHRlbmRlZCBjYXBhYmlsaXR5IGlzIGxvY2F0ZWQgYXQgMHgxMDAgKi8KIAlpZiAoIXBjaV9m
aW5kX2V4dF9jYXBhYmlsaXR5KGFkZXYtPnBkZXYsIFBDSV9FWFRfQ0FQX0lEX1ZORFIpKQogCQlE
Uk1fV0FSTigiU3lzdGVtIGNhbid0IGFjY2VzcyBleHRlbmRlZCBjb25maWd1cmF0aW9uIHNwYWNl
LCBwbGVhc2UgY2hlY2shIVxuIik7Ci0tIAoyLjQ4LjEKCg==
--00000000000091e707062e589e83--
