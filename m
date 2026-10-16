Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7ECCC6B38
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 14:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 170F110E039;
	Fri, 16 Oct 2026 14:58:08 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C853010E039
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 14:58:01 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-35e8253292cso239315eec.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 07:58:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792162681; cv=none;
 d=google.com; s=arc-20260327;
 b=rdhEtaltwkDFPB/jVPZrzhudTFc8uOFWOgvviKOic1VqBiDwrOvJOV3lXEZJLwqppg
 RttwsVK0DGguzlEItQThBsSoJ6efgzM+Ilfs4UPNQ1fqx1lKwCkwQhWxtlN92497NR6/
 hU7uYImE18a9vyk1kktcHelgjrK4Jj0hJDTgWAX6GBZJtyM05mL32r3O0+QocW6T/1eQ
 KUJ1nI4nRCs3i8gmzEt8HnbC3Cs8WpwCWzs7NJHSjDJz7MiNETn3f4e8JAs+GPNp3OoS
 FNGXSoBLqFmeefIpr/ihFcW4o3v1OIGWzX0RNWwkxWuVyJAgCxj6zwzslx8tKOe+8m5t
 /ItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=j/iWwLN9t4lTO5krc7NmCFonRPAWDO2N0ndljngv4pk=;
 fh=x61/gd19OJmIC/LYqSHjcApLDhMavCYWM+ZyWS4TK4k=;
 b=ikfeeJt4FnMcfeBTYftx+k3Vu3M33N9aHZnMUFozINQ/wk4BHm8r41oBVnXQ1Ij1it
 /eh4cVZ2XYxWFaR4bl8N2w1EIKQxzQBEhn10m/u7A09l1xFqNDXp/13Rhw2G2VIHcxLS
 teg1hEFlF/gy6+J/6BCgRCxyDjt7xwDexkWg+3wq038BN7TGRRbY6i+ETC71o6PGtmgn
 ejO6jabMHtZmfWxrb3rw0NJbyKQBS+ZKkjOKRUt/DFEfKze80T7UKKofPhEYD/7zsCfQ
 WdfMkrDsi0Daz97xSYITyq+RZ4CIy056aVl621bzlUqGo6KaELoOICBf1vvXpxG8CLUq
 pFTA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792162681; x=1792767481; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j/iWwLN9t4lTO5krc7NmCFonRPAWDO2N0ndljngv4pk=;
 b=Z1g2rdlB3kWF1Vn20LKlja6KARjHCmMrFOTd8y57m7vx2A3mmOzDr5Unw6JPCQZdlv
 JhoyyLc5g+MvZgjM6UriUzSZf06BNQaXP5BBRPPgs1qutbmb9vGerF4coDai/Aw7M7Mk
 9cmegBtsFObvDaKid2khfmPh5Rq32H0IpI+g4Px1rnSR9G5cUQMYMJz3hlnLOWSCyFgq
 ivCUP9UGAE4EfrkrBwpOUCPgaG2yeSLUuhl6+CeiMiFO2f+8isKCBxg7dNzHYYMGaQnA
 YVsVRWQskODXkw17npwplzOW4tq4vXRqnuz+VcrdpSsrk49jpXG0XR0aCXdlto+w5ycU
 WqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792162681; x=1792767481;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j/iWwLN9t4lTO5krc7NmCFonRPAWDO2N0ndljngv4pk=;
 b=d5/zRIR+ZaTEdYMs1/U9fgv2WbINp2p5Tar51vFY571ZxdomFL1h7Qr4hoNkM0fngM
 6qVjVlPLh6/g6ZBHLCQIaHMszjvCmsrtNTpAUwb+UsYxn4iaiUOD/bgazL9i2+ccYlx0
 trPEexJuqcnb+wpKyjg8QfeqIE6GryTxFSjY4L6B0+p1MImZSUlGN0eVDQUORc5SvrQS
 dlKK00ZT2sv1/fXpK06FiQSwUhvf1gtB4xHoD+j0N8D+AHaxlzbVCWcSQftmRNiXN6yf
 mXiyeIfMD5HsuDL7LbH5U5r4BGjshmG3TtsTEXpiWg8CQBigHKWOz697gFofCcKUDktn
 JvXA==
X-Gm-Message-State: AFq9FYLy3t+cIoy0YMoljCKv1+0aDlBJEKamLaoqDYlYicrkyMxILS2B
 onjucDeU1VSVr07/azjKItrH83Qt6LHmW5cr7c8FC9dsvy/wLPTvpQN8R44Zi667cCEZD6MaDEw
 Hpd2IJkkcNXKVRAAyhs1FLATkLyB52c0=
X-Gm-Gg: AYBFou1/5h/BKi0QNOK7a2Oyjo/LdyWUQR5uDfLT8Xw85n+eyawSO5CLca1qBqylJcI
 1Eyda6pnDSg2/JBFN/FHcdwAYJ1+WyXTpw57i9UDelWcVjiU9A79mTezU0XQH1WcQgd6OJd+bga
 v4zoDeIRaL9dDWXYyHjf+/95ZxBk2jzHA9AXbH6q67unI1NH6bqOFiHeLeV9djtZ7uci21GdlPk
 P1FgE65orE+vh+axBRaqidC4e9TNSOQqYx/abTySqVnTlavGE4bCk9toZ812NWkZk7SJ/KErCcw
 CK+s4NvLw8BrpD4RAzzoskbYAFEnT5KX92wVIykkupLKpPFlLGOQXqjy+g094j4ruclHUFreeGg
 3ij8rN4WAcWQ4XfnH8IBmhxkrIrdm5igcwSOKIKBFHg==
X-Received: by 2002:a05:701b:4212:20b0:12d:c389:ae54 with SMTP id
 a92af1059eb24-18510d6790cmr356931c88.2.1792162680594; Fri, 16 Oct 2026
 07:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20261016-amdgpu-pro560-quirk-v1-1-3e5d3fe5ff29@yandex.ru>
In-Reply-To: <20261016-amdgpu-pro560-quirk-v1-1-3e5d3fe5ff29@yandex.ru>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Oct 2026 10:57:48 -0400
X-Gm-Features: AclHuK9Y9nbFfxvMfpHnk-Fsti6gcaykPCkUDQK4L2Imfe2ZdLE1ZmVNTie-tNU
Message-ID: <CADnq5_Nk2vxNWNPFs33GA2_jssKbPi9+ceOVqKyfjP-ZFx86dg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: reset VI ASIC on MacBookPro14,3 with Radeon
 Pro 560
To: dolph-in@yandex.ru
Cc: amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Francisco_Beltr=C3=A1n_Millal=C3=A9n?= <fbeltranmillalen@gmail.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
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

On Fri, Oct 16, 2026 at 10:46=E2=80=AFAM Sergey Armodin via B4 Relay
<devnull+dolph-in.yandex.ru@kernel.org> wrote:
>
> From: Sergey Armodin <dolph-in@yandex.ru>
>
> The MacBookPro14,3 also ships with a Radeon Pro 560 (Polaris11,
> 1002:67ef, subsystem 106b:0179, revision c0), which has the same problem
> as the Radeon Pro 555 added in commit a22e5e4f2ebb ("drm/amdgpu: reset
> VI ASIC on MacBookPro14,3"): the firmware leaves the framebuffer at MC
> address 0 at boot (MC_VM_FB_LOCATION =3D 0x00ff0000, 4 GiB of VRAM), whil=
e
> a re-POST through the VBIOS ASIC_Init table places it at 0xF4_0000_0000
> (0xf4fff400), so a GPU reset, or the S3 resume described there, moves it
> under the driver.
>
> Add this variant to the VI reset quirk table.
>
> Tested on a MacBookPro14,3 with this Radeon Pro 560 on 7.2.5 with
> commit a5be7ad8f5f0 ("drm/amdgpu: reset VI ASIC on MacBookPro15,1") and
> the 555 commit backported (the kernel also carries distribution patches
> and machine-local workarounds for its BCM43602 Wi-Fi and T1).
>
> Without this entry the framebuffer is at 0x0000000000000000 on every
> boot, and a GPU reset forced through amdgpu_gpu_recover fails: after the
> re-POST MC_VM_FB_LOCATION reads 0xf4fff400 while the driver still puts
> the GART table at 0x0000000001B00000, the IOMMU reports DMA read faults
> from the GPU, and the SMU firmware load fails ("SMU load firmware
> failed", then "GPU reset end with ret =3D -22"), leaving the internal
> panel black.
>
> With it, amdgpu logs a PCI CONFIG reset on load and the framebuffer is
> at 0x000000F400000000 after both cold and warm boot.  The same forced
> GPU reset completes ("GPU reset(1) succeeded!") without SMU errors or
> IOMMU faults, followed by two "ring gfx timeout, but soft recovered"
> messages, and the GPU came back from 14 S3 cycles (4 lid close,
> 3 systemctl suspend, 7 rtcwake) with no amdgpu errors; the internal
> panel was back after each lid-close resume.
>
> Cc: Francisco Beltr=C3=A1n Millal=C3=A9n <fbeltranmillalen@gmail.com>
> Cc: stable@vger.kernel.org # 6.12.x
> Assisted-by: LLM
> Signed-off-by: Sergey Armodin <dolph-in@yandex.ru>

Already fixed with this patch:
https://lists.freedesktop.org/archives/amd-gfx/2026-October/154973.html

Alex

> ---
> The kernel logs of both forced-reset runs (with and without this entry)
> and of the S3 cycles are available if they help.
> ---
>  drivers/gpu/drm/amd/amdgpu/vi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu=
/vi.c
> index a0435fd..ac26641 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -1398,6 +1398,7 @@ static const struct vi_reset_quirk vi_reset_quirks[=
] =3D {
>         { 0x67ef, PCI_VENDOR_ID_APPLE, 0x0190, 0xe3 }, /* Radeon Pro 555X=
 */
>         { 0x67ef, PCI_VENDOR_ID_APPLE, 0x018f, 0xc2 }, /* Radeon Pro 560X=
 */
>         { 0x67ef, PCI_VENDOR_ID_APPLE, 0x017a, 0xc7 }, /* Radeon Pro 555 =
*/
> +       { 0x67ef, PCI_VENDOR_ID_APPLE, 0x0179, 0xc0 }, /* Radeon Pro 560 =
*/
>  };
>
>  static bool vi_need_reset_on_init(struct amdgpu_device *adev)
>
> ---
> base-commit: f307e9d20cc7bd6dd54a3fd8c2af767dd7ef2931
> change-id: 20261016-amdgpu-pro560-quirk-7d51df1c2649
>
> Best regards,
> --
> Sergey Armodin <dolph-in@yandex.ru>
>
>
