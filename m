Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61315606A329
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BZms5xsb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0544B10E46C;
	Fri,  6 Nov 2026 20:45:24 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92C0D10E46C
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 20:45:17 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2eb14c60a7cso1009735ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Nov 2026 12:45:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793997917; cv=none;
 d=google.com; s=arc-20260327;
 b=d0a41lDhRXym6V+A2kBjNHcmhUmIwNU5V1NOKPQqi0QRHNDkuR4NyaP8Y25GwQypmr
 /L1UAOLHxlSR9ZLQTAc+4QGmv1uf9HFKclbLUmmXrdTRRT/jlxgloRA+nyipMJLbtYvK
 JMg5URavnaZacxVO2EXfEj1kqsvpaHL4nqoaJA++OwCcluKDxtLZg4NO9tCdC1HfNhBb
 9H24Xa8ZqxU+FTU601LRG9wGv2yWR3gvmLWO6ohlz8vvxTYSKlCRPo0NvDboD0OcCeSE
 Ty9/VbAqgdU0/xptJK70Ke18lJQmQwa3VPe2Xh+D7mdOimMz5VAd+a6WgZmsVlbb+zgx
 EUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0uu9/IUh7NsWXEW2HZUwucBqcwvbs/ijE8SczhrKGfw=;
 fh=bUnXyLqzrSByW8MJmF6hGI9Ia4K0VbLSZUf8BFq+ECc=;
 b=rN5K9HWFJCXnAMRrUbRF8F+W0KgXWfKncPvF1h9kNLj3JEs2ed8B0mS2fgP4Mp3whN
 rwdxmHpLBRalKJpgoPE8WvZwwUhIMjgR+FSkuURvpYJRudvBP0rld5wYF8W53DEoH3Ex
 z08/yW10RO7Iz3nGSIxI+EfTr9nwHfuo18SFuV1xJanQr403cBpHKs2Gy/Ab9BSKRfAl
 vpyDlJ7f3/+4Yw2RLooUuiT963VDMcZB4xPOUrH3wSTMKQXVzvBUIoEWhB2kIYgS08N1
 mTMaGBcVpqCYqQ2mpsLPInRgH5YeSt2PjRZJHFVIywW9UWD2GH2aWX2tOna/gnCwiizw
 gNkw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793997917; x=1794602717; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0uu9/IUh7NsWXEW2HZUwucBqcwvbs/ijE8SczhrKGfw=;
 b=BZms5xsbho3YZ6F1wBTt+o4fb5eywILfSdYJvzmFpzJdpoYC/u3k2kefCPmEVAIw7z
 jiEG/IiRJqjROyw28zYz+jkJ6Ip2lAL1W4UoaqdeNObbYzVJiLjJHU/GuRSbMffbdVkN
 Zgj3mF/HtrhnBJM5bf4zeVvdNFsd3YlJiNHODAdv0gAuv2dAmuTwmiOrM8RMqMyViKh0
 PbUWWx82GMFdXv9v5OnluJ9bQEJRJu9rpZb3vOHSi6wGW8y6RgmguKi9W4qMskoQ45em
 u0H8f9UJz78z82eT3fDwJIMgnVaBM+4+XJnpBmuFBDjyPS0s5Vg2gK5KG313jFWix5vB
 61wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793997917; x=1794602717;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0uu9/IUh7NsWXEW2HZUwucBqcwvbs/ijE8SczhrKGfw=;
 b=vh7T7SdDUlYIm77x8byPZazKC5EvjOj1DKAzzTjBmCvgUQXhWzSOMaYKGLYGtM7nbG
 CXwp3vazcIebN/edfcP4EnRI+FANyEB18O5zLSdcsbuamNchNpUfi8SonKQbJBSV150l
 Gu5JDuayPGmWwbsAI2Lh16RhAYWYxJOINP5PD5FAeSGSNNsSzhFeftvhZVSaCZADhTX1
 b7eJ8+2GlEFOuySXtxLrrTyh9bKGh4Wtg+bhaY5yYbg8cZniq8XO8yJUfjVK1IsHlIjO
 U8ZhmAaRpbbcFM+kTUpLit6C6gyhKYEtD1UXWl7xBPO+hukou7qih5cGAzclfY/XZS6F
 tnow==
X-Forwarded-Encrypted: i=1;
 AL+hErGgaaNucUEEgqipVF+Xuzg0o0ES7oss3wxR/mxfKr1JNss2s9sfgAvbSqKKRYPJWJmV+Lu7LoYe@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+baULTYCIgGr0D49b+fnsQ48NDHIcGFo5qxFi5dAWiwoVuvv5E
 3rbM+5LaIGwOXCiqX2+INyN0onrzI35gEYVrqkQM4h4LQHuiotszzNpTbhlyk4McviauS3EHwBs
 2HR7VOn2QhOSl/jZelY/PgYZ7V8QcHs0=
X-Gm-Gg: AYBFou2AMJ+krpL8gJVcpK/zXVEFsl6g2+cho5H9oNrBPi0EtdmoK/kkwy/hkvfGAEx
 ivfoqbc+RgwXgvwOWiZZKBInCmYEvYWoET42jTnOOQ+Plc0DLdpNwm5Zxtpe/liTIkTCg6nIlt/
 lz5Yed+NV6FNkDyxTh67xrZB8UjWwgrvWKtNRjsUEGU5fWbjGa3xDgTljVg9d+UloNUJKj9WnZ0
 2MkEVp0aDuQSGPQqDNvG8ghqMGpMmo9zb2gjIVB8t3oT/yKoNOKvwNKtYom1Czgq8x7Tuc9vJq+
 oYndXydK/TFDXUJnyjX6Wldlt918gPex+pTwD6ReHiZyJMXEetbf7Veofe4XcWLuE5KqBzRHUSW
 up5YFd5uCh3e52H6lxkMs1McBiDo2yg52pfgSkl6B/GYvwdRdxyW9D1jyWIIjjkQUxkT4SDS3GF
 +9YkeuDU3IOpclzT4rALZtbPddmXdc/7jijEdW0xXvTYkz
X-Received: by 2002:a17:90b:224e:b0:3a8:1759:2217 with SMTP id
 98e67ed59e1d1-3b0db62ffb8mr5455317a91.2.1793997917010; Fri, 06 Nov 2026
 12:45:17 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029135050.1820997-1-Kanala.RamalingeswaraReddy@amd.com>
In-Reply-To: <20261029135050.1820997-1-Kanala.RamalingeswaraReddy@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Nov 2026 15:45:04 -0500
X-Gm-Features: AclHuK_gEw-kkeNtFmuXpscsGZOXSVgvND69A0DUzUweYtpg5cNwLJRMpCpo-Bk
Message-ID: <CADnq5_PzY6qQ5ujQ3=S9vF0zWtAN_G75dA_WYutt9Ms-+VD5aA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: use supported SMU clock messages on SMU 15.0.0
To: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org, 
 Pratik.Vishwakarma@amd.com, Veerabadhran.Gopalakrishnan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 10:11=E2=80=AFAM Kanala Ramalingeswara Reddy
<Kanala.RamalingeswaraReddy@amd.com> wrote:
>
> SMU 15.0.0 no longer implements SMU_MSG_SetHardMinGfxClk, or the
> SMU_MSG_SetHardMin and SMU_MSG_SetHardMax messages. Sending them
> makes the clock request fail.
>
> Program the GFX hard-min clock with SMU_MSG_SetSoftMinGfxclk, which
> this SMU firmware still supports.
>
> Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@am=
d.com>

Fixes: c7fc0f372374 ("drm/amd: Enable SMU 15_0_0 support")

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> index 4be864e4f0e6..e7a74b732639 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> @@ -1457,7 +1457,7 @@ int smu_v15_0_od_edit_dpm_table(struct smu_context =
*smu,
>                         return -EINVAL;
>                 }
>
> -               ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetH=
ardMinGfxClk,
> +               ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetS=
oftMinGfxclk,
>                                                       smu->gfx_actual_har=
d_min_freq,
>                                                       NULL);
>                 if (ret) {
> --
> 2.53.0
>
