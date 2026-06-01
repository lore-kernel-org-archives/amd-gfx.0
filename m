Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A344CD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 07:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A58AF10E72F;
	Mon,  1 Jun 2026 07:15:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="TUoyjkhD";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45FFC10E72F
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 07:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1780298128; x=1780557328;
 bh=fGyjTtu+QeXQt2UN0FwMc6WlvG9hMC0QtSu3nBTS5dM=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=TUoyjkhDDD95ThJwZQmr+fWz71fwYsR3WavUAPr9QwcOHS/XoZPnX+OGxN0acMsKF
 GSRmkSXwLNg9ISnijyGHjUdBT3duF+A1Zkt4PQwQDWVjy3xqd4o4ON8R10vzPRBArU
 Jgc2qJDzF66HkNrGB7teFwIELvk426SdRishpZ2WNygNFaw3/V/8+GQvI4ZXrcb1Gz
 NrjbOkYRCKjBEHo4QfFU6mLEfo18mSZqirc3L6cs6YQfndClMdob6BUSnniOVv423q
 swttkNaMQSVwF6vFsFI371M3rQGIz2btPUrW5xp4RMBIq6J/H7xqQ4sUlLOO7l/S4D
 8Jt48t9JN5Otg==
Date: Mon, 01 Jun 2026 07:15:23 +0000
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
From: Geri <geschw@pm.me>
Cc: "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "xiaogang.chen@amd.com" <xiaogang.chen@amd.com>,
 "Philip.Yang@amd.com" <Philip.Yang@amd.com>
Subject: Re: [PATCH] Revert "drm/amdkfd: Use huge page size to check split svm
 range alignment"
Message-ID: <J_TUeAIhprWyHffpU2dmQSjpeGWulDT6cnKvYHPmIR1csAsJbQi4vJQSube53YvV6QRp8A-JZS9qzmTOTBYfYZ43xDQi5FwAk2aJcFu8BOI=@pm.me>
Feedback-ID: 110185885:user:proton
X-Pm-Message-ID: a8db16b659956b22b7ef8a695167d8d4cd43b18d
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha512;
 boundary="------a6b806112772f97d56c34d4c188368be0a508b96b20d1e0ad35244ee50a48111";
 charset=utf-8
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------a6b806112772f97d56c34d4c188368be0a508b96b20d1e0ad35244ee50a48111
Content-Type: multipart/mixed;boundary=---------------------591feae527914febf996a35963e626c6

-----------------------591feae527914febf996a35963e626c6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Replying to Alex's revert patch:
https://lists.freedesktop.org/archives/amd-gfx/2026-February/138824.html

Hi,

The requested small reproducer for drm/amd#4914 is now available:

  https://gitlab.freedesktop.org/drm/amd/-/work_items/4914

It is a small C/HSA reproducer. It does not require PyTorch, ComfyUI,
Docker, model files, or the original workload.

Same binary, same command on both kernels:

  ./kfd_svm_split_hsa_copy --upstream-ab

A/B result on the same RX 7600 XT system:

  bf2084a7 active:
    1/1 run faults with SDMA0 permission fault
    GCVM_L2_PROTECTION_FAULT_STATUS=3D0x00841A51

  bf2084a7 reverted:
    10/10 runs complete
    no ROCr memory access fault
    no new GCVM/SDMA0 permission fault in dmesg

The bad fault page is inside the split tail and inside the SDMA copy range=
:

  critical tail: [0x722429d61..0x722429dff]
  copy pages:    [0x722429b30..0x722429d70]
  fault page:    0x722429d65

A full ftrace/PTE run with the same C reproducer/SVM sequence also shows:

  split_tail ... current_remap=3D0 old_remap=3D1 missed=3D1
  MISSED_REMAP_CANDIDATE split=3Dtail
  no amdgpu_vm_update_ptes covering the fault page after the marker before
  the fault-side GET_ATTR

One important open question for me is:

  What original failure or workload was 448ee453/bf2084a7 intended to fix?

If there is a test case for the original problem, I can check whether a
replacement fix covers both that case and this regression.

Could this revert, or an equivalent fix, be reconsidered?

I can resend the reproducer and summaries directly on-list if preferred.

Thanks,
Gerhard Schwanzer

-----------------------591feae527914febf996a35963e626c6
Content-Type: application/pgp-keys; filename="publickey - geschw@pm.me - 0xE32DB141.asc"; name="publickey - geschw@pm.me - 0xE32DB141.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - geschw@pm.me - 0xE32DB141.asc"; name="publickey - geschw@pm.me - 0xE32DB141.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FYWFZQ0loWUpLd1lCQkFI
YVJ3OEJBUWRBTDhzSFhxTDN5Q21KNUp6d3FEQ0hkWTZoSTJRQTM1TWwKekNPNkpyMTNWakRORzJk
bGMyTm9kMEJ3YlM1dFpTQThaMlZ6WTJoM1FIQnRMbTFsUHNMQUVRUVRGZ29BCmd3V0NhYVlDSWdN
TENRY0pFSGJ4WHM4VnA1eFpSUlFBQUFBQUFCd0FJSE5oYkhSQWJtOTBZWFJwYjI1egpMbTl3Wlc1
d1ozQnFjeTV2Y21mbmRLQmtNZmZLVmQvNWFFclk3VjRWR2g3L3U4Zm45OTQrQUZhemswRGEKd1FN
VkNnZ0VGZ0FDQVFJWkFRS2JBd0llQVJZaEJPTXRzVUVPWXNWaEJITnZ1M2J4WHM4VnA1eFpBQUEr
CmZRRC9kRUl0MmRsNVlFcFRXQUpBRU16MnlDOXNmTHJQN1piRm8vZytYcUlkNDNjQS8yaGlPUTJ1
ZlB1VQp5SW1QTVNsTEVCY1dKQlpMZVQyakR1cnlMSGNadmVJRHpqZ0VhYVlDSWhJS0t3WUJCQUdY
VlFFRkFRRUgKUUNHMi9EV3dmeEdud0t4VFMxejFJbkpFdk5Iam5WTndheE4rc1NjWFNvME1Bd0VJ
QjhLK0JCZ1dDZ0J3CkJZSnBwZ0lpQ1JCMjhWN1BGYWVjV1VVVUFBQUFBQUFjQUNCellXeDBRRzV2
ZEdGMGFXOXVjeTV2Y0dWdQpjR2R3YW5NdWIzSm5FSFAwc2tmTFQwbFllejhyS2FuVW9hN2NYekhF
Smt4TkxoSlhuM2JJOXpZQ213d1cKSVFUakxiRkJEbUxGWVFSemI3dDI4VjdQRmFlY1dRQUFNS2NC
QU0zbTlxYmt1cm9DTFdBMzZXMHhnRXJTCmlQYXUzcEw0eHNvMjhUc3FJQmhOQVA5UDg4T2JuNXZ2
c2JqdVdvVWhOMFlOeEVXQnpuQ1dsZmtPQ1ppOQowTWhRQkE9PQo9YW5jVQotLS0tLUVORCBQR1Ag
UFVCTElDIEtFWSBCTE9DSy0tLS0tCg==
-----------------------591feae527914febf996a35963e626c6--

--------a6b806112772f97d56c34d4c188368be0a508b96b20d1e0ad35244ee50a48111
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmodMX0JEHbxXs8Vp5xZRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmckQjZ06Tp7gRXpKlAV3bxzeJdbD+DVgVphbuGJ
JWW49BYhBOMtsUEOYsVhBHNvu3bxXs8Vp5xZAADJBQEA+0jGXRQtnfb3a65i
M+558P1X7/3BKvrPeTDuLuPNdxcBALOhwzoiZq7Tsj6xQVnPcl6OtMwj/Ul1
yXjIAmZEIwUF
=MkBa
-----END PGP SIGNATURE-----


--------a6b806112772f97d56c34d4c188368be0a508b96b20d1e0ad35244ee50a48111--

