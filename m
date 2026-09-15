Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8684DC88E72
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 03:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA92F10E44C;
	Tue, 15 Sep 2026 03:04:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZRCwcWz6";
	dkim-atps=neutral
Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com
 [74.125.231.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0092E10E44C
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 03:04:42 +0000 (UTC)
Received: by mail-oa2-f12.google.com with SMTP id
 586e51a60fabf-46fa9979050so159936fac.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 20:04:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789441482; cv=none;
 d=google.com; s=arc-20260327;
 b=byT/c4kmlBR1xkkQVYZ7Is/gz035K8zAVc3XT7DoB4SgigO48/v1tsVPe876jFcrSV
 b2OzSHKnrNgZ8zPFeU4vRD5jv+/RpM104Sk+YqgPEHbMi/RmQ0J+fAerwyVTaxVwJBtb
 qJnFrkkKb3mZVWgbSR7g6OaXCsSp+ay+IhIy0EeUbpOIPS8cb8lMQZuMJ9SZLiNTICqe
 +W/t9XWoXSuWP71Ze9kxveEMftPsH43fdQePrT27OtZTs56z4wKm5XY6nxmY9BSHrglw
 ZTELl0m4aifAbT3PcMnPCsUy7XwtcbWKjy+qSMIxv/J0qmsLtvK1SKqTezxdcosJbpBU
 QWBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Zt2KvDzQuAH9dhLbrS0JsC0Dg+2fn0P8MDH2H7Q/XkY=;
 fh=G7lN9QnbbwqdBVsn//AvpLIgOP7XLJ62dQ50UVjYOB8=;
 b=AItXGxGKj1FhI4gL9VKYyOLYFhsqn4S2Zj2gPOMuDuepnF5eTbf+bgrRtjCHgTWqZU
 cM+JpZxiOQNSMAePLiWsPZ678WcNwc+G4sJE07NrcPKBQlHnCtL2DYfQ/bPHGsQIpteK
 KPLmeuKR83sOwUrsQlqOPEL2cOrbV/6NXUG8vvc8hOSOyiHzjmhoBg2CPWKqcnwpBwSe
 vBga0BpWFfx4KtV8tBEQ8wincokj22m/U6P4Ylfd8iBKSoIKOfioGMI1uVb8CPmTfCuh
 OuvPawl08ZLEHgvMK/yjQw9s/GGndc54ZnVPr2XMmg747wZpnpp1K+78btZCkw7bsdrC
 Pb8Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789441482; x=1790046282; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Zt2KvDzQuAH9dhLbrS0JsC0Dg+2fn0P8MDH2H7Q/XkY=;
 b=ZRCwcWz6G2SboVtygrSEw3JiCwxxvapvX8C7HddTGQ5lsN3BE48CTQEy7kS0FK1tFp
 PZpyek4y8zxAo00kMfzJRns1pmIJAu2ExSTOchJf5TD9nSQsop4Gsj36Y4MnbcMeGO4H
 NvvOxt26aY9GN3b5qyHFyRrtwZooS9D3vobRu3LnmMab40/V0sbVwvW+DdF3ew+3r5Vr
 2PRoSeDqQfOnkQtp1FU410DJzMpHvCHPrd6T2Eyg6PZDaBepFG45SA+07u40KR5d3PCp
 z3EzX4x6Bw0jIrKlte+vc+350iJQUtSutZigiMFd9NFfBIt6Fkc/qdneCX8D1dgWlir+
 cHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789441482; x=1790046282;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zt2KvDzQuAH9dhLbrS0JsC0Dg+2fn0P8MDH2H7Q/XkY=;
 b=zL2HhKv6hyoHjCeWmZttAwu9WS9vIQNKO92DM8BiRlSoUuixvNOyJBBw1VkeG19AGD
 NGbFHnYsxvrP5R2xVt2WF/xaZDelXgJr28VN20LSsnDQij6wIEvRMkzklt2HxAe+PwYv
 lvqO3TEptWnJvkQjmZjoSWhL2zG5j4G5kydO63e5dVJCMqNqeWn0GHIa4nlYHS/MaIzU
 heD50Ld1ASFIcmuwymx01SoQ/tqGPMjcD2EHK5msobNuoxK1Wrhf4WRY+veMlE0/wAfs
 7Tcp4JRaP2ZsZcg/Zjpxd0df5MW47bXy4Y6wZWlphKxICTcc2O3JY7spZOoSLakPu5om
 6NgA==
X-Gm-Message-State: AFuF++k0rzT9J+R972ypx+bK96ClmJuG47/FxT9NkXR78ai3jquZRU6r
 K5xq8HfHZ8ECslfOauYH1Mo9Wqn7avJ5fKYyuTHBGgNWX+LT/cuFmkIcbzh9oOyWjMSW1o17CUM
 RQ04exckrNlCJD7IaW/iwbxpQAaOVXR4=
X-Gm-Gg: AYBFou2pF7dziKVFDgigj1FmspWliXCQHh6Ow6MTQwlghy7cC/9GdeKUBR5Dvx/t4Oi
 CokUM5xuQI7/q/7K1oEPJhQmy2pIjNAO5ceWaLY9spcUzfWwfNfKKOedIFkwUtng+X+/XPsJAuI
 3MYuy88xYKllZ4pYQWwCSSwrvKJ2Bc0crRK1R6FhNXsa5+ygEqMtJwgXscO4hTwqYzOJpNT6P2/
 n8vdGL+YOQoxY9T6Cd/cmwFhHLoiPhfkvGFuX2ZOUHe5dKOx9SiBcNS+qHYy/Q9EIuRRm9InvAH
 5lMirIPVw3nLtxQHhwe23kjpSt9APMQ/hgpA3cmkX4GW0H0xmgnpfeNoMQ==
X-Received: by 2002:a05:6808:15aa:b0:4c4:d241:d230 with SMTP id
 5614622812f47-4c7b3bca6b8mr3542293b6e.2.1789441481903; Mon, 14 Sep 2026
 20:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260520154618.809699-1-mario.limonciello@amd.com>
 <20260520154618.809699-2-mario.limonciello@amd.com>
In-Reply-To: <20260520154618.809699-2-mario.limonciello@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 14 Sep 2026 23:04:05 -0400
X-Gm-Features: AcwNN1VMoYP0nIMEjTV_1M2nni4XzMsDzoGSuloo0GlWcfYcexjLJDWxjFjHo5U
Message-ID: <CAAxE2A4VhsAzzO1QjBjUg+NgnbD04ZzMyN6xsUJxjKJHH6hxiw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd: Add dedicated helper for
 amdgpu_device_find_parent()
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Samuel Pitoiset <samuel.pitoiset@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Mario,

(re-sending to the list)

Note that this breaks PCIe info reported to userspace via
drm_amdgpu_info_device. Previously it reported the PCIe info
corresponding to what the GPU uses such that the maximum available
PCIe bandwidth could be calculated. Now it reports the PCIe info
supported by the host PCIe. E.g. on a card with gen 4 and 8 lanes, it
reports gen 5 and 16 lanes.

Userspace depends on correct numbers to make performance decisions.

Marek

On Wed, May 20, 2026 at 11:54=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> There are a few cases that code walks up the topology to find the
> link partner of the integrated switch in a dGPU.  Split this out
> to a helper and call in all places.
>
> This does have a functional change that amdgpu_device_gpu_bandwidth()
> doesn't cache the internal link but only the parent.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 44 +++++++++++-----------
>  1 file changed, 23 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 073f632f295a3..b6a24faaf78dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1913,6 +1913,19 @@ static void amdgpu_uid_fini(struct amdgpu_device *=
adev)
>         adev->uid_info =3D NULL;
>  }
>
> +static struct pci_dev *amdgpu_device_find_parent(struct amdgpu_device *a=
dev)
> +{
> +       struct pci_dev *parent =3D adev->pdev;
> +
> +       /* skip upstream/downstream switches internal to dGPU */
> +       while ((parent =3D pci_upstream_bridge(parent))) {
> +               if (parent->vendor =3D=3D PCI_VENDOR_ID_ATI)
> +                       continue;
> +       }
> +
> +       return parent;
> +}
> +
>  /**
>   * amdgpu_device_ip_early_init - run early init for hardware IPs
>   *
> @@ -5913,8 +5926,6 @@ static void amdgpu_device_partner_bandwidth(struct =
amdgpu_device *adev,
>                                             enum pci_bus_speed *speed,
>                                             enum pcie_link_width *width)
>  {
> -       struct pci_dev *parent =3D adev->pdev;
> -
>         if (!speed || !width)
>                 return;
>
> @@ -5922,13 +5933,11 @@ static void amdgpu_device_partner_bandwidth(struc=
t amdgpu_device *adev,
>         *width =3D PCIE_LNK_WIDTH_UNKNOWN;
>
>         if (amdgpu_device_pcie_dynamic_switching_supported(adev)) {
> -               while ((parent =3D pci_upstream_bridge(parent))) {
> -                       /* skip upstream/downstream switches internal to =
dGPU*/
> -                       if (parent->vendor =3D=3D PCI_VENDOR_ID_ATI)
> -                               continue;
> +               struct pci_dev *parent =3D amdgpu_device_find_parent(adev=
);
> +
> +               if (parent) {
>                         *speed =3D pcie_get_speed_cap(parent);
>                         *width =3D pcie_get_width_cap(parent);
> -                       break;
>                 }
>         } else {
>                 /* use the current speeds rather than max if switching is=
 not supported */
> @@ -5955,22 +5964,15 @@ static void amdgpu_device_gpu_bandwidth(struct am=
dgpu_device *adev,
>         if (!speed || !width)
>                 return;
>
> -       parent =3D pci_upstream_bridge(parent);
> -       if (parent && parent->vendor =3D=3D PCI_VENDOR_ID_ATI) {
> -               /* use the upstream/downstream switches internal to dGPU =
*/
> +       /* use the device itself */
> +       *speed =3D pcie_get_speed_cap(adev->pdev);
> +       *width =3D pcie_get_width_cap(adev->pdev);
> +
> +       /* use the link outside the device */
> +       parent =3D amdgpu_device_find_parent(adev);
> +       if (parent) {
>                 *speed =3D pcie_get_speed_cap(parent);
>                 *width =3D pcie_get_width_cap(parent);
> -               while ((parent =3D pci_upstream_bridge(parent))) {
> -                       if (parent->vendor =3D=3D PCI_VENDOR_ID_ATI) {
> -                               /* use the upstream/downstream switches i=
nternal to dGPU */
> -                               *speed =3D pcie_get_speed_cap(parent);
> -                               *width =3D pcie_get_width_cap(parent);
> -                       }
> -               }
> -       } else {
> -               /* use the device itself */
> -               *speed =3D pcie_get_speed_cap(adev->pdev);
> -               *width =3D pcie_get_width_cap(adev->pdev);
>         }
>  }
>
> --
> 2.43.0
>
