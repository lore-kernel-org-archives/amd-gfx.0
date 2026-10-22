Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA23B606A31E
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IAiOy2TU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 477981129E7;
	Fri, 23 Oct 2026 07:49:56 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECB5A10E22E
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 17:21:48 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-91b8b456dbeso1256686d6.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 10:21:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792689708; cv=none;
 d=google.com; s=arc-20260327;
 b=O8P7Hudxid8gLDLd16PY4zrCHyNNSRNiGavjxLPlWXyvnKGJFb72oukByHhBfz3XnN
 LXL4loQIw1nAWBEfoJ2qVlNA4ov0uC1/kumgJcZW3Kis3l7DTxakph/QiZhwBbu4g2eB
 TU4UUBPOFSgx8PBu2GAyAZpWM6sfwLs9YgWWjTs819N7wGqOW7dqf8XFIdWvgFi6yJxK
 8Tuj8HDuY/yP0PiOuixiEgdiAbqah0Ed0N7Ngttcj0QlojMrHA07LmT/2Btd/Nw1Dp7F
 XrE2/cGVxbXF7yWXG1fU1unphTJHq0oVk35YJFyI19y+K5d1tCrG19yOOQEHu0rTZS6x
 hydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=W4lXu8bAh6fN/sbMRlzud9o6W45hgLZ7R+czqfgijwg=;
 fh=hs9oynQb3YjZT40omR8IZyt+l0QN8nu4Bye5abBVWug=;
 b=O9JWsDmDAGOAD6aGTuEqteCWAcufQTU7+AloGf7bKU6nMpUUP3hETzHotttFVA1ZYk
 PoALVQPr3HEl4SbV1BANgLURIE0Dk4MAVZNMG2ExsAXIlYswjEtU50av8wIWMIrpaPg3
 lg389WRFXiI6g0sneeQ9Uid7xYGvByhHWd3lCHLMrJ67Csa/PRb4shnY7iSIfXJtm+lC
 SPthqUBKyGZ3D1MVspPAPaMKz4tRRLgnKxhKBVfN/iEUIuFeMcTLTztz46wB2CLQ/Mkn
 huNWu/ukkr9ajjoiisqJsTOWO9oxJysKvdwcX30y386JBzpydapcPXs5xUKI/Epz2Zle
 0/Ow==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792689708; x=1793294508; darn=lists.freedesktop.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=W4lXu8bAh6fN/sbMRlzud9o6W45hgLZ7R+czqfgijwg=;
 b=IAiOy2TUVSxROXy7XNDehi3ibzXaT8Iioe7YU4iAqKZ2o5v5TPB/YDXEgZ7eEKsZzg
 VBWCueSH60Y88BibTAHx57+AYS70helfDz1/FQq79aYlJDyMXDXOnDt6GsKVIbLlBpm5
 g+FAxHqScU7KuZB9tjnzuHV7qrPJ+xAJ6SCeu8XsjP79UTtj7ikFq8ntBA3RRkNnVruK
 BraJWsJWDDecBXpTrwOadSxIjPyOuMUs1Th1Cg7erGvScjBCM3diwwlsCQJeIvMft01g
 nRYCNh33FkIodWQ/DXECgtVQj9S3zzRTQNG9CbXaaAB84FbVEpyRFZJ4rVjQjIAJwweY
 a9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792689708; x=1793294508;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W4lXu8bAh6fN/sbMRlzud9o6W45hgLZ7R+czqfgijwg=;
 b=oxZqVruY/1I7R622T8yPh0eC6D2Z00aqBipf9ODxXUR3gjqrmp9FBkXNczAQxMgA74
 SNfNlJVZJEXGiB+Xcye02kR7j7bq8Q/Ro7VyOy05fHSQ0L4jo7INSxB3VUpYkVUNGsIp
 hCyHIy1BmPe7wqk3oNHyyQMJka1RWRtLnfKo0tjizHaMjzF9bfOz0urNvvkeU9E/7Co8
 FJEVWwnmL3T/2HS3iizfViNtik4eTxa1aSt/jj1elu1O4emOdduFsv961LBCgQigps5F
 ZjJszSJ+M0Ym0sosvNJnrXsYCvK5L0+q+G/mEK2+ciDVdyqZewKhjvbaX8453YA9d6Z8
 zs6w==
X-Gm-Message-State: AFq9FYI4BDdKXcLGCv2jj6hrnDMBY8McgftIXCfHicN6cY75TCG9/oWW
 n4WyWT1Yck6g40hVQkPXXnPJEMZ1g5PnEcvmfzL9T1JNHwrgWXFDaQvpAGL1wkzL5McwCc39YUa
 cXCjIl2oOKzjvbGQY6bj2CTZAWQFPOp63Ew==
X-Gm-Gg: AYBFou3AVqJdNCRYWb3ipWhS/+e0BhGRjWu5JLGQQXs/ckY99fa0h5tyGMpP4nkf8mG
 k8vgJrR0vs0EW3A0OT2QiO6wYHCgx8N7KLgBPTwVwuLMfFqoYu/E+3Sl9Q0EJxOZ9vH42OgJdXT
 NZKSN6Ys5gPJHuLsaJg47EoFURJnZIKlid4fEUiy6DR2Y1yTDSjRhbuf2sEE9oak/+BUWvEEWQi
 55LFaB89HA0pvD9poyGpj3J/bTWu8l3qRl0AnA8JSkzIWxYcE961LMfseOwgR3Dh1bTBs6A0ws2
 HGZuFsHxZEbVx/tuZmrgAjjsczh/l2fGaQGe+fs0rfezWyZu7hjF6R/YcgfpFYnp86xhUXZb0xJ
 4cCR9Wm8v6zzSKL7DH0GVnwuzw+9A42p5v5iDj5eOumae2IXjD1M6xCq/4laKxbtY5ZI=
X-Received: by 2002:a05:6214:dc6:b0:914:521e:7db2 with SMTP id
 6a1803df08f44-91c12e20d76mr103823406d6.8.1792689707631; Thu, 22 Oct 2026
 10:21:47 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 22 Oct 2026 10:21:46 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 22 Oct 2026 10:21:46 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: ego RRR <egorkara@gmail.com>
Date: Thu, 22 Oct 2026 10:21:46 -0700
X-Gm-Features: AclHuK_Dl8qrEI9FgC4vxz3yElUtG2ZOhTlSDC6neuGANfluA1Wi6Vv_PfwpiFc
Message-ID: <CAPbDjBb3_OfVKwPC4H_t=k7SnoTjDV9TEJbtQy+tB2xpA41W8A@mail.gmail.com>
Subject: =?UTF-8?Q?=5BQuestion=5D_Navi_23_PCIe_IP_6=2E5=2E0=3A_LC=5FSTATE0=E2=80=9311_add?=
 =?UTF-8?Q?resses_and_LTSSM_history_lifetime?=
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000374d6c065e71194a"
X-Mailman-Approved-At: Fri, 23 Oct 2026 07:49:55 +0000
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
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000374d6c065e71194a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello AMDGPU developers,

I am investigating a PCIe link-width negotiation issue involving an ASRock
Radeon RX 6600 (Navi 23, device 1002:73ff rev c7, external upstream port
1002:1478). Its external link to an older Gen2 root port (1002:5978) trains
at 5.0 GT/s x2 rather than the mutually supported x8. Early PCI enumeration
already shows x2 before amdgpu binds. I am specifically trying to
understand what read-only evidence the GPU itself can retain about initial
LTSSM training, not asking for a speculative register write or retrain.

On this card, ip_discovery reports PCIE IP 6.5.0 and NBIF 3.3.2. The Linux
amdgpu NBIO 2.3 header defines PCIE_LC_STATE0=E2=80=A611 with LC_CURRENT_ST=
ATE and
LC_PREV_STATE1=E2=80=A647. The available pcie_6_1_0_offset.h gives indices
0x100a5=E2=80=A60x100aa (STATE0=E2=80=A65) and 0x20022=E2=80=A60x20027 (STA=
TE6=E2=80=A611). Eight *other*
register indices in that map agree with absolute SMN constants used by
nbio_v2_3.c and smu_v11_0.c via SMN =3D 0x11100000 + 4*index. This suggests
the following candidate addresses for Navi 23, but I have NOT verified them
on hardware:

STATE0=E2=80=A65: 0x11140294 =E2=80=A6 0x111402a8
STATE6=E2=80=A611: 0x11180088 =E2=80=A6 0x1118009c

Could someone familiar with Navi 23 / PCIe IP 6.5.0 clarify:

   1. Are these twelve SMN addresses actually valid for its external PCIe
   controller? Is a debug-port selector or other precondition required to
   interpret them?
   2. Do LC_PREV_STATE1=E2=80=A647 reflect the most recent LTSSM transition=
s, and
   which events overwrite or clear them (L0/recovery, link retrain, device
   reset, SBR, cold boot)? Can a later OS-stage read meaningfully preserve =
the
   *initial* downtraining sequence?
   3. Is there a supported read-only way to capture the relevant state
   during early initialization on this ASIC, or another reliable GPU-side
   indicator for downtraining? I understand RREG32_PCIE writes an indirect
   address selector, so I have not probed speculative SMN addresses.

I am asking only for public documentation, high-level hardware semantics,
or a pointer to the appropriate maintainer. No changes to PCIe PHY,
firmware, driver settings, or resets have been made for this inquiry.

A prior public summary of the link-width symptoms (separate from the
register-mapping question):
https://github.com/egorKara/gentoo-msi870-rx6600-pcie/issues/1

Thanks for any guidance.

--000000000000374d6c065e71194a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>Hello AMDGPU developers,</p>
<p>I am investigating a PCIe link-width negotiation issue involving an ASRo=
ck Radeon RX 6600 (Navi 23, device 1002:73ff rev c7, external upstream port=
 1002:1478). Its external link to an older Gen2 root port (1002:5978) train=
s at 5.0 GT/s x2 rather than the mutually supported x8. Early PCI enumerati=
on already shows x2 before amdgpu binds. I am specifically trying to unders=
tand what read-only evidence the GPU itself can retain about initial LTSSM =
training, not asking for a speculative register write or retrain.</p>
<p>On this card, ip_discovery reports PCIE IP 6.5.0 and NBIF 3.3.2. The Lin=
ux amdgpu NBIO 2.3 header defines PCIE_LC_STATE0=E2=80=A611 with LC_CURRENT=
_STATE and LC_PREV_STATE1=E2=80=A647. The available pcie_6_1_0_offset.h giv=
es indices 0x100a5=E2=80=A60x100aa (STATE0=E2=80=A65) and 0x20022=E2=80=A60=
x20027 (STATE6=E2=80=A611). Eight <em>other</em> register indices in that m=
ap agree with absolute SMN constants used by nbio_v2_3.c and smu_v11_0.c vi=
a SMN =3D 0x11100000 + 4*index. This suggests the following candidate addre=
sses for Navi 23, but I have NOT verified them on hardware:</p>
<p>STATE0=E2=80=A65:   0x11140294 =E2=80=A6 0x111402a8<br>
STATE6=E2=80=A611:  0x11180088 =E2=80=A6 0x1118009c</p>
<p>Could someone familiar with Navi 23 / PCIe IP 6.5.0 clarify:</p>
<ol>
<li>Are these twelve SMN addresses actually valid for its external PCIe con=
troller? Is a debug-port selector or other precondition required to interpr=
et them?</li>
<li>Do LC_PREV_STATE1=E2=80=A647 reflect the most recent LTSSM transitions,=
 and which events overwrite or clear them (L0/recovery, link retrain, devic=
e reset, SBR, cold boot)? Can a later OS-stage read meaningfully preserve t=
he <em>initial</em> downtraining sequence?</li>
<li>Is there a supported read-only way to capture the relevant state during=
 early initialization on this ASIC, or another reliable GPU-side indicator =
for downtraining? I understand RREG32_PCIE writes an indirect address selec=
tor, so I have not probed speculative SMN addresses.</li>
</ol>
<p>I am asking only for public documentation, high-level hardware semantics=
, or a pointer to the appropriate maintainer. No changes to PCIe PHY, firmw=
are, driver settings, or resets have been made for this inquiry.</p>
<p>A prior public summary of the link-width symptoms (separate from the reg=
ister-mapping question):<br>
<a href=3D"https://github.com/egorKara/gentoo-msi870-rx6600-pcie/issues/1">=
https://github.com/egorKara/gentoo-msi870-rx6600-pcie/issues/1</a></p>
<p>Thanks for any guidance.</p>

--000000000000374d6c065e71194a--
