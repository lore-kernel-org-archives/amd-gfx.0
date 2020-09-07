Return-Path: <SRS0=05a7=CQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1B9C43461
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 05:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A764120757
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 05:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpY0QPDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A764120757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4220289DED;
	Mon,  7 Sep 2020 05:00:56 +0000 (UTC)
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E298789330
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2020 05:00:54 +0000 (UTC)
Received: by mail-il1-x141.google.com with SMTP id b17so11433451ilh.4
 for <amd-gfx@lists.freedesktop.org>; Sun, 06 Sep 2020 22:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to;
 bh=7ngmlmsLfcB1vHyFNfdCgIFa8iwrLF1JeHRGBF+AtZA=;
 b=NpY0QPDdQTn27UbNDeykr1hBXTohTN7ypCzD2IhYrO/EAq+VGb63N0nwyPZ1FTczs1
 d3PamJwNVmlq6F49S8Db8rVq1HzUdwMig5pzH6NGyP+X5DWuapC0jI2MklVEh6udkHes
 PYbbU4lceD3oR1AO/MB4svcQEniQpWThu1xMWApnmB8ZcPV3hRdKc6bPg4TtEaG6PMBE
 XWqN14qNgtPBvc3G7Y6e1MpeDGdKHTLo5YwSZaP4Jp99sEVroftxaU1xh67lla5SDqgf
 qG+UI6ZLJNnQl64q4wfrhz4xwiyd11vc0x5BEFQ9fGMrL6Opo44ZKH8u2hSyLQ8RyB1C
 hR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=7ngmlmsLfcB1vHyFNfdCgIFa8iwrLF1JeHRGBF+AtZA=;
 b=bOCYsEds0dEi8XP2SwkdSJLnxFkyOTw7mp1JOD06S/0DgPvwtqGsegtWjGDiTuUNaV
 UobDL+K8JmbR8nonxh7sUShHfPlfKzoXF4hC/BqgN9mm4whMcZN6/dxpe492kWFVYofv
 +QIh/lPNjuK48146QqzQ7lcj2swjbi9SUm0sQQABjllCA4Lrul/Aj+DdNh1Q92hE5bVc
 FMm9uflez5HU5jSYhJTvqDKSYn2vYrKrdglGEphkSE6/Y3R/TcUNF3KBLmkZY4bT/BGm
 nNYv/4Qi4HCaJ42u200PoseQ+gOMFhwbCpCKB8jQ0blfj0uE7I7bYagdQDn3SVOSMOex
 s4OA==
X-Gm-Message-State: AOAM5332Oi/bGu06P453865jVhlt/jRJ8VQVS0GOy3DxwNXrxfCuSOgX
 M7govcickDb3lcoHNLoTR3twYeG5isY=
X-Google-Smtp-Source: ABdhPJygwK+Ey4VqEMGCTMOVj6ly+0J1TPOon5abQLRmtyMRmlqgdaP8nR1sJ3CCzi9X652CPZrdzA==
X-Received: by 2002:a92:99cb:: with SMTP id t72mr17220386ilk.172.1599454854010; 
 Sun, 06 Sep 2020 22:00:54 -0700 (PDT)
Received: from ?IPv6:2602:4b:a6ae:c000:aa5e:45ff:fed0:7395?
 ([2602:4b:a6ae:c000:aa5e:45ff:fed0:7395])
 by smtp.gmail.com with ESMTPSA id o15sm6979429ilc.41.2020.09.06.22.00.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Sep 2020 22:00:52 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: enable ih1 ih2 for Arcturus only
To: christian.koenig@amd.com, Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Alex Sierra <alex.sierra@amd.com>
References: <20200902170118.30751-1-alex.sierra@amd.com>
 <CADnq5_NRFr5vYfuwgMHQ5Y+19_UqXPoJYomBkwGMoWkvjpA_Fw@mail.gmail.com>
 <CADnq5_MFC=r=NxhzZ2OmO7EaodZXtGDQxgqw2146DGQoioShwA@mail.gmail.com>
 <2ea7e8e2-8a96-8006-a5ee-41ebfecbf6f1@amd.com>
 <edce428d-eb18-23d3-418a-be720c5b227c@gmail.com>
From: Matt Coffin <mcoffin13@gmail.com>
Autocrypt: addr=mcoffin13@gmail.com; keydata=
 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
 tuwClJVHcEqY1gkUE/HKR1MQFfXl979G/1Ql1g==
Message-ID: <e6734f67-8b70-26f4-3847-109ed8e61c77@gmail.com>
Date: Sun, 6 Sep 2020 23:00:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <edce428d-eb18-23d3-418a-be720c5b227c@gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1247176499=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1247176499==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NuUq9A3HJlt1gxoeQpUoco8WLAVqaA5hk"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NuUq9A3HJlt1gxoeQpUoco8WLAVqaA5hk
Content-Type: multipart/mixed; boundary="z30AzEi9mb22A5Tk0I5cHxc8DcQheCH36"

--z30AzEi9mb22A5Tk0I5cHxc8DcQheCH36
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello all,



Thought I'd chime in here. While I can't speak to the issue the GitLab
reporter was experiencing, I can say that I get some performance hit
(expected) from this when using multiple monitors with DRI_PRIME. When
the second monitor is active (with something rendering to it with
relative frequency), then I see a decent performance drop in
applications running on my primary monitor compared to before this.



While this is probably expected, and imperceptible to the standard user,
I thought I'd at least mention it in an effort to keep contributing.



Thanks for the continued open source work. You all make my life.



Cheers,

Matt

On 9/3/20 2:05 AM, Christian K=C3=B6nig wrote:
> Am 02.09.20 um 20:28 schrieb Felix Kuehling:
>> Am 2020-09-02 um 2:13 p.m. schrieb Alex Deucher:
>>> On Wed, Sep 2, 2020 at 2:08 PM Alex Deucher <alexdeucher@gmail.com>
> I think we should further investigate this before applying any patches.=



--z30AzEi9mb22A5Tk0I5cHxc8DcQheCH36--

--NuUq9A3HJlt1gxoeQpUoco8WLAVqaA5hk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwz6NkrTNYgbdBT2N4mzKau7FyAcFAl9VvoEACgkQ4mzKau7F
yAddjQ/9EHaZB7sPe5xcEuFdc5BsBm77xJMSK2ZhNZUjyfOfxT68tHNAlVwEFTny
6w25fKkQVcHCce89SGmrHyigME8xNIBwSmyQTCtp3/QpE/3SeKrHL8z4vr3Qgpec
XaXgc1uzyKlqud+MRP29YvIixLz4aWYpj47yVldBGCL4Km4ff5Mss0B2viEC+Q5O
zIZ8C5417AAzw/ZY38qHS9X8KBjPWwmYi6XmROkV6C/aYYmXs2fTvEHi8MpEerSr
dKiV6v0LwbNgH5m0vqX7hdLpgwkYpERz8R88o1D0Ew7gMqYXw3bjjd+MtvGmsAHi
PzvNWGJ4AEm37spE/0NVkJWkBm2UrfB42DPVj2dru3GeiMQmMOkK+KknZLlnOdvP
7X7Vv3DasMYUCI+1axKjh+y3W2BoCO6LUSP5nc6QBt5nRx+NpcrRCFRqDodSmnJ/
mfMV4GA3CVNNjNjUzZKq2M2ntmy0YbwPyQDe5obY/z1V5NC/JVnKbTSLV3CH4I9j
jszo9CR1Dbi4+OBMldYF6IDMYKaKCvJh0bQNzQqXxip1ss5nVi8LNGGpMqSDtYE1
1R3ahgh2BrW6EJ1U+y2Ssoc2Q03DT8GsdcXZXZ+dZCboliix/SjaN5gvmitngJ2J
fVuCj/PSqpdbOUotMRcU8BQQt1va5bWxbkFtvLx/vn0mMeLUEfQ=
=JdIU
-----END PGP SIGNATURE-----

--NuUq9A3HJlt1gxoeQpUoco8WLAVqaA5hk--

--===============1247176499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1247176499==--
