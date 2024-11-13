Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD760D41C00
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 04:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BF9910E67C;
	Wed, 13 Nov 2024 04:47:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JPb9Hsdv";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BE6610E24F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 04:47:07 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2e9ecb67701so103794a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 20:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731473227; x=1732078027; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1kGkpHtpTy8Fj+ECUpJx90q98mjrx/JCrFCpHQX7Pv4=;
 b=JPb9HsdvlEPcaEXYnoRVm1WF3JB8qDhN8Yl4i8DsSSqhetGH1segpSz12d6eMfxo6G
 BpZibL5XzI9sXJZ1JlE8sovV0Sl44c7Lllynwhwatle0wWN9aDNM+WII/kxV8lcSN9WZ
 p8lUAoYqdWySbYJ0vKgRSnG34qFRG9y6wSTOgD8nVNnZpEI9FMh+e1QztUTPWW6a9jCE
 G443iJFhAF+Z0jLJYsicGJQ7oDj491ET6G1A5RlGRmCd82Rhjgz+dsirelavwu1+f61C
 wtOy6QBizKGeQXYh+BABeQIz1qrx0IWJ16OT4PEIUrCfw/5vKs49kewnqwnZtiXYsBxw
 robw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731473227; x=1732078027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1kGkpHtpTy8Fj+ECUpJx90q98mjrx/JCrFCpHQX7Pv4=;
 b=joRT8J0fYyQUz8MnMqKCkRXzb1Pv5WBlSq7UM/OMdhU9oP+gmGZNNlHQPI29K6IfDz
 ami5568AJcPjZyX/ljX3npEncN+4QMV2E9eeho6jJSsMYhgsg+2YN6h+syeu/u2yuQWV
 nxop0xevIMiczQUFyNhKt23Bi+yFEPLyXjsb2mRj+n/sdPT6oHljMkW19ORgXueHu+Q4
 zkbqpZSCyrhagTBNkEvIqbCFDGn1rbYlQkFUbTlYa2IjOfcEQZKfjiKJvcTekiWYrpkC
 P/XwOIVDxJ6RD7nSCmrxOT1sGRWAFy18eZ22nunU66LhaCZWlM3DkIuK4Wg77iqwt3SG
 aLVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXqoQVec+1vPKEiCPHA9jJZdRcGxShbTyWQktZ3DuEZLT4U9ObwDln0f7IPMr3VRGyJ+dxtfUd@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5mKIQCyDEu/rGYOqN/9DE1XWR9u25nNVsh3KGkr35wizW9Xd7
 LmRCn+ynQ56F/nP6/HAjR6bD3y5kqjeop61iHdir/6HLf6e2Yij4AtTp2mZGn9b2ESWk2ErnXFL
 LPK1oa8G/89SlWnGN2BsyAxGo4cc9eA==
X-Google-Smtp-Source: AGHT+IGB8E7W+0KGc+l+swZuFq0jOKBCmDa0r24pv9ipF77aOJpCtxVZVU9VDfcGcIuBJwiMIi4L5epHcLmrFGcyXgc=
X-Received: by 2002:a17:90b:38c4:b0:2e1:682b:361e with SMTP id
 98e67ed59e1d1-2e9b165272amr10535332a91.4.1731473226873; Tue, 12 Nov 2024
 20:47:06 -0800 (PST)
MIME-Version: 1.0
References: <20241112143050.1931822-1-jesse.zhang@amd.com>
 <20241112143050.1931822-2-jesse.zhang@amd.com>
 <910caa3a-802a-41d6-ae07-c39292081d4d@amd.com>
 <DM4PR12MB51524E90E5A98A03BF7FDD8CE35A2@DM4PR12MB5152.namprd12.prod.outlook.com>
 <63fcdfc5-af2a-4065-ab5a-81ca5dca6db9@amd.com>
In-Reply-To: <63fcdfc5-af2a-4065-ab5a-81ca5dca6db9@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Nov 2024 23:46:54 -0500
Message-ID: <CADnq5_Pix7r90tHzXF85vNMrqk+KZSOGSgHRuCvHH1LSG6JVgQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix vcn sw init failed
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>
Content-Type: multipart/mixed; boundary="000000000000a0ce4f0626c406a8"
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

--000000000000a0ce4f0626c406a8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 10:24=E2=80=AFPM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 11/13/2024 7:58 AM, Zhang, Jesse(Jie) wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > Hi, Lijo,
> >
> > -----Original Message-----
> > From: Lazar, Lijo <Lijo.Lazar@amd.com>
> > Sent: Tuesday, November 12, 2024 10:54 PM
> > To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.=
org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <=
Christian.Koenig@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Huang,=
 Tim <Tim.Huang@amd.com>
> > Subject: Re: [PATCH 2/2] drm/amdgpu: fix vcn sw init failed
> >
> >
> >
> > On 11/12/2024 8:00 PM, Jesse.zhang@amd.com wrote:
> >> [ 2875.870277] [drm:amdgpu_device_init [amdgpu]] *ERROR* sw_init of IP
> >> block <vcn_v4_0_3> failed -22 [ 2875.880494] amdgpu 0000:01:00.0:
> >> amdgpu: amdgpu_device_ip_init failed [ 2875.887689] amdgpu
> >> 0000:01:00.0: amdgpu: Fatal error during GPU init [ 2875.894791] amdgp=
u 0000:01:00.0: amdgpu: amdgpu: finishing device.
> >>
> >> Add irqs with different IRQ source pointer for vcn0 and vcn1.
> >>
> >> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 19 +++++++++++++------
> >>  1 file changed, 13 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> >> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> >> index ef3dfd44a022..82b90f1e6f33 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> >> @@ -83,6 +83,10 @@ static const struct amdgpu_hwip_reg_entry
> >> vcn_reg_list_4_0_3[] =3D {
> >>
> >>  #define NORMALIZE_VCN_REG_OFFSET(offset) \
> >>               (offset & 0x1FFFF)
> >> +static int amdgpu_ih_clientid_vcns[] =3D {
> >> +     SOC15_IH_CLIENTID_VCN,
> >> +     SOC15_IH_CLIENTID_VCN1
> >
> > This is not valid for 4.0.3. It uses only the same client id, different=
 node_id to distinguish. Also, there are max of 4 instances.
> >
> > I would say that entire IP instance series was done in a haste without =
applying thought and breaks other things including ip block mask.
> >
> > If the same client id is used, it returns -EINVAL (because of the follo=
wing check) and sw init fails at step vcn_v4_0_3_sw_init / amdgpu_irq_add_i=
d.
> >
> > amdgpu_irq_add_id:
> > if (adev->irq.client[client_id].sources[src_id] !=3D NULL)
> >         return -EINVAL;
> >
>
> We had some side discussions on IP block-per-instance approach.
> Personally, I was not in favour of it as I thought allowing IP block to
> handle its own instances is the better approach and that could handle
> dependencies between instances. Turns out that there are more like
> handling common things for all instances as in this example.

We tried that route as well before this one and it was ugly as well.

>
> I would prefer to revert the patch series and consider all angles before
> moving forward on the approach. Will leave this to Alex/Christian/Leo on
> the final decsion.

Do the attached patches fix it?

Alex

>
> Thanks,
> Lijo
>
> > Regards
> > Jesse
> >
> >
> > Thanks,
> > Lijo
> >
> >> +};
> >>
> >>  static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
> >> static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device
> >> *adev, int inst); @@ -150,9 +154,9 @@ static int vcn_v4_0_3_sw_init(st=
ruct amdgpu_ip_block *ip_block)
> >>       if (r)
> >>               return r;
> >>
> >> -     /* VCN DEC TRAP */
> >> -     r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
> >> -             VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst=
->irq);
> >> +     /* VCN UNIFIED TRAP */
> >> +     r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> >> +                     VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE,
> >> +&adev->vcn.inst[inst].irq);
> >>       if (r)
> >>               return r;
> >>
> >> @@ -174,7 +178,7 @@ static int vcn_v4_0_3_sw_init(struct
> >> amdgpu_ip_block *ip_block)
> >>
> >>       ring->vm_hub =3D AMDGPU_MMHUB0(adev->vcn.inst[inst].aid_id);
> >>       sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[inst].aid_i=
d);
> >> -     r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
> >> +     r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].ir=
q, 0,
> >>                                AMDGPU_RING_PRIO_DEFAULT,
> >>                                &adev->vcn.inst[inst].sched_score);
> >>       if (r)
> >> @@ -1734,9 +1738,12 @@ static const struct amdgpu_irq_src_funcs vcn_v4=
_0_3_irq_funcs =3D {
> >>   */
> >>  static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev, int
> >> inst)  {
> >> -     adev->vcn.inst->irq.num_types++;
> >> +     if (adev->vcn.harvest_config & (1 << inst))
> >> +             return;
> >> +
> >> +     adev->vcn.inst[inst].irq.num_types =3D adev->vcn.num_enc_rings +=
 1;
> >>
> >> -     adev->vcn.inst->irq.funcs =3D &vcn_v4_0_3_irq_funcs;
> >> +     adev->vcn.inst[inst].irq.funcs =3D &vcn_v4_0_3_irq_funcs;
> >>  }
> >>
> >>  static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block
> >> *ip_block, struct drm_printer *p)

--000000000000a0ce4f0626c406a8
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-drm-amdgpu-use-a-single-set-of-interrupt-funcs-for-v.patch"
Content-Disposition: attachment; 
	filename="0002-drm-amdgpu-use-a-single-set-of-interrupt-funcs-for-v.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m3fectx30>
X-Attachment-Id: f_m3fectx30

RnJvbSA5MzlhOTNjODM1YzEzMDcyMGEzNDZkZmI2YmFhZDI5N2YxZjI2ZTI1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFR1ZSwgMTIgTm92IDIwMjQgMjM6MjY6NTIgLTA1MDAKU3ViamVjdDogW1BBVENI
IDIvMl0gZHJtL2FtZGdwdTogdXNlIGEgc2luZ2xlIHNldCBvZiBpbnRlcnJ1cHQgZnVuY3MgZm9y
IHZjbgogNC4wLjMKClRoZXJlIGEgc2luZ2xlIGNsaWVudCBhbmQgc291cmNlIGlkLiAgVGhlIG5v
ZGUgaWQgZnJvbSB0aGUgSVYKcmluZyBpcyB1c2VkIHRvIGRldGVybWluZSB3aGljaCBpbnN0YW5j
ZSB0aGUgaW50ZXJydXB0IGJlbG9uZ3MKdG8uCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvdmNuX3Y0XzBfMy5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3Zjbl92NF8wXzMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92NF8wXzMuYwpp
bmRleCA4OGNiZjFhODhhMDcuLjg1MzRmNTM3MDA5NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdmNuX3Y0XzBfMy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3Zjbl92NF8wXzMuYwpAQCAtMTUzLDcgKzE1Myw3IEBAIHN0YXRpYyBpbnQgdmNuX3Y0XzBf
M19zd19pbml0KHN0cnVjdCBhbWRncHVfaXBfYmxvY2sgKmlwX2Jsb2NrKQogCS8qIFZDTiBERUMg
VFJBUCAqLwogCXIgPSBhbWRncHVfaXJxX2FkZF9pZChhZGV2LCBTT0MxNV9JSF9DTElFTlRJRF9W
Q04sCiAJCVZDTl80XzBfX1NSQ0lEX19VVkRfRU5DX0dFTkVSQUxfUFVSUE9TRSwgJmFkZXYtPnZj
bi5pbnN0LT5pcnEpOwotCWlmIChyKQorCWlmIChyICYmIHIgIT0gLUVFWElTVCkKIAkJcmV0dXJu
IHI7CiAKIAl2b2xhdGlsZSBzdHJ1Y3QgYW1kZ3B1X3ZjbjRfZndfc2hhcmVkICpmd19zaGFyZWQ7
CkBAIC0xNzQxLDcgKzE3NDEsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9pcnFfc3Jj
X2Z1bmNzIHZjbl92NF8wXzNfaXJxX2Z1bmNzID0gewogICovCiBzdGF0aWMgdm9pZCB2Y25fdjRf
MF8zX3NldF9pcnFfZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGludCBpbnN0KQog
ewotCWFkZXYtPnZjbi5pbnN0LT5pcnEubnVtX3R5cGVzKys7CisJYWRldi0+dmNuLmluc3QtPmly
cS5udW1fdHlwZXMgPSAxOwogCiAJYWRldi0+dmNuLmluc3QtPmlycS5mdW5jcyA9ICZ2Y25fdjRf
MF8zX2lycV9mdW5jczsKIH0KLS0gCjIuNDcuMAoK
--000000000000a0ce4f0626c406a8
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-return-EEXIST-if-an-interrupt-handler-exi.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-return-EEXIST-if-an-interrupt-handler-exi.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m3fecty51>
X-Attachment-Id: f_m3fecty51

RnJvbSBjOTgxNGYyYjAzMWE4YTA4YzUzYTY3ZTkxZTI1ZjRlMDZiM2UwYjE5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFR1ZSwgMTIgTm92IDIwMjQgMjI6NTE6MDEgLTA1MDAKU3ViamVjdDogW1BBVENI
IDEvMl0gZHJtL2FtZGdwdTogcmV0dXJuIC1FRVhJU1QgaWYgYW4gaW50ZXJydXB0IGhhbmRsZXIg
ZXhpc3RzCgpTbyB3ZSBjYW4gdGVsbCBpcyBvbmUgaXMgYWxyZWFkeSByZWdpc3RlcmVkLgoKU2ln
bmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pcnEuYyB8IDIgKy0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pcnEuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9pcnEuYwppbmRleCAxOWNlNGRhMjg1ZTguLjJmNjZiOGJiYTNjNyAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pcnEuYwpAQCAtNDA4LDcgKzQwOCw3IEBA
IGludCBhbWRncHVfaXJxX2FkZF9pZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAl9CiAK
IAlpZiAoYWRldi0+aXJxLmNsaWVudFtjbGllbnRfaWRdLnNvdXJjZXNbc3JjX2lkXSAhPSBOVUxM
KQotCQlyZXR1cm4gLUVJTlZBTDsKKwkJcmV0dXJuIC1FRVhJU1Q7CiAKIAlpZiAoc291cmNlLT5u
dW1fdHlwZXMgJiYgIXNvdXJjZS0+ZW5hYmxlZF90eXBlcykgewogCQlhdG9taWNfdCAqdHlwZXM7
Ci0tIAoyLjQ3LjAKCg==
--000000000000a0ce4f0626c406a8--
