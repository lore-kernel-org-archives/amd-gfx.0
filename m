Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2121160A2600
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h7K3D2Dg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97E4210E304;
	Mon,  9 Nov 2026 19:59:43 +0000 (UTC)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A886110E29B
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 19:59:37 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-33c10faf6easo135806eec.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2026 11:59:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794254377; cv=none;
 d=google.com; s=arc-20260327;
 b=jyElNx6YO7MXJFlNXEG9+xo21sTSgPz7L7vijp0zo/9XZ1gGLE4DsQRKRFJeG90p5a
 6+aYMybwSS+EI45dxtP+n/KNivdj/Qek1/7Cy40DsyVXd/t8DiiJkbjZ/tN9y79vm0bw
 lSPlBRhGRuWuBGu1TH3UWoSfdwSISZ41sMNPcsNUl2iVUD0rfFKNVlrfQXYaHnKVSsjT
 Jhc2Hd6BjykXt/ICcqOEiq0zTUQTW5MQS0E65Q/kpsSKPq8+AnGD+PeDtFrbXOKEMqHv
 fnzcC2edKCkEgkZ2ueOFCJsoWxlS8/uaHx84kneAgM14QUbabF5O+vtOqR10Bv0NrRG3
 jTGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=A3d8Z5wEIvDErSrT35kmctdWIj7cgR5OdqtBoCuGlWM=;
 fh=9cZu1i9QLCcBwacJmX3ukY6C60WTVGErv9Dx5NBadzU=;
 b=DIy/mUFGjr6r1ehNGTVwU6weI8pTTB11Dnt6QPboVErcK4dEVUCDnhLCpLA61oVgmu
 t4gZ8G4ghzw0WneHTx8iLlICAlBuKsIlc1KcfaXZn53FCXjLcrPwgjojJ0M7Wjxhd8UQ
 fkDdcACe3UsF+3eI/NS/pDBMrt+Pc/fZ9vDdUl2R93Yiousin/Ufq95VX7O+1ScfjLqY
 RP0pa+rapuYAR7o6WB3jcPiGk/N8lAk3FBAuZPIVTtvd+CQ6rDrIuHSz3EEwBxDoTP7i
 uOcllsgl5oGe8UnGmOiG73s2GrA3UIGnaN5Pm59FecCkUXUV1IuR25ZCmnwDwsS5D39k
 Pm6w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794254377; x=1794859177; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A3d8Z5wEIvDErSrT35kmctdWIj7cgR5OdqtBoCuGlWM=;
 b=h7K3D2DgsJKHYoicN1E31jsIe0cYk/6Fr6PE2NWl86KDwMf9xPyvJlHhtMF78n/uJ5
 MhhG6NcJTggZSPgni67umWuqP2hmm1QSjbjqvnNQAPVQ0eBcf2ASN9R7Pw6RsfnBCuS5
 W8ZNeq8tY/WgFbwFBjv9yadr1senyN6krPTbge0ONIPI+0acExMt/dc4XDkRSRTw2DAF
 vMkGexoCdkwQ2wYfNH9RAy/bPzXyQCZhuTeKkG67yGMQ8NeLA7+s0+hICeDnmqbPmXZQ
 lN/qXzi9Z8F1kXQNYg3vdns0goXtePAPp92K477CMJf59RAYpWx6N5pGyck3NmWA71tf
 hHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794254377; x=1794859177;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A3d8Z5wEIvDErSrT35kmctdWIj7cgR5OdqtBoCuGlWM=;
 b=lENdVPV3ubff6o91lkr5lY2fI9TG3nw8eGqPmfbxD2D9GNGCTgBpULQKqJ51YR5uGQ
 wEz4bDFGnt8Yh5WPVnBgVxexEbcadqYJHa33EE6/Ucu0AWn7ERL7SHmOGw1ZPiQIHGh0
 QRC+5Abfeu5aeiQuvsRr+W+XkrINpl60yaWkq0jwl7IsZuO4+Igpa1PDAtZldIv1ZWt/
 1D1DgCyWQdk/iyCNnrm1qeijsYCQ+hvmNM81SeN1wHbfYxUdRPG/J96Q9NH/iFnamtRD
 Bne9IlSEoZTqZdFBiC3LLsYosrZS7WN5ZqqYukjX/18O4GkXvWeU4Tu8Bd7FtCXm4pJj
 L9UQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEIC9auMTkC0gCMnkmLSdGgv7B1uCgS7R7bOq4R80Wc5fyYmgX5FDQbqMracHwANjNcXwsnk5VG@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8zQpoowVR9BZMXgxNHLOZZN4qkVHx0n3V2Eykfd/v8JaYJC4iW
 YSOZEOVISeFvGn5CL9WFZpjitaWrSdza7BjyQvRqNXRRtbhPdIZtBCBfBH2KQGYbjld3qa9ctnd
 tsJ1rbragEngcxW6lqTRM85BzvZfaS1o=
X-Gm-Gg: AYBFou3bdTNhLr5lmgSGCpHm6d0n/geffZ3x8sd3W69GN66R3I6PBbYWLJuDcx1AXou
 UF3f65o/gHg/1+10AusDdx+XLBy5lbZ4DQpimQ+XUJOKwim2fPdk5MB32ofuCvXT1X7DuQWaMEs
 jxlJCtHBRYVInOS9Ei1FNlN+92yNbwJFzEl8XOJ3MJH93DQSlghe0qG5TCXvt8kf178fUtyB/J+
 +SzhVMiGL1vsmx1kipRaCz41Af5xcoePoK1mCsZxs4JbtoULLpLozEHsbF91IkKEcpv10eMpFjz
 9EzM+67kgUa82TJ/zVBKOK/t5TjtufdWKo8/shInOYfSHniL0hFzvlvs5vKRbSKY8GM/9t8mi+r
 V1yxs+7KX9AIyowuI8jjNcdiDfCt2DHRcPMGZ+VCoDsaDVexnMInlYeWFuMPDNwHpjl5fwLRY1n
 Xuxi2ZOHJSYUpijAmM/2+0GyX00i+d3d9KMijZsuaFYx1WjfTiOimsweydBLQ=
X-Received: by 2002:a05:7022:ea86:b0:127:def:dd72 with SMTP id
 a92af1059eb24-1b3b6025be0mr804293c88.2.1794254376807; Mon, 09 Nov 2026
 11:59:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CADnq5_PjiWHEDzS5DJgB1wS72_tHp4Ju5Wwr0R0N5EK-i9fXfQ@mail.gmail.com>
 <20261104200201.8358-1-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20261104200201.8358-1-atharvatiwarilinuxdev@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Nov 2026 14:59:25 -0500
X-Gm-Features: AclHuK_reFfmn-t9QmheX2wZpEISvfvcfsRiQmEay-P-EKxxO4O4ghKC0Fq689Q
Message-ID: <CADnq5_Po302dyx5FA9u3A8os_Q-HsA74nk2qeDadcGe97zodbQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add 5K Support for iMac20,1 and iMac20,2
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: airlied@gmail.com, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 dri-devel@lists.freedesktop.org, harry.wentland@amd.com, 
 linux-kernel@vger.kernel.org, simona@ffwll.ch, siqueira@igalia.com, 
 sunpeng.li@amd.com
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 4, 2026 at 3:02=E2=80=AFPM Atharva Tiwari
<atharvatiwarilinuxdev@gmail.com> wrote:
>
> > What's the reason for this change?
>
> This is the code that fixes the SMU boot issue, that we discussed eariler=
:
>
> https://lore.kernel.org/all/20261103160553.1431-1-atharvatiwarilinuxdev@g=
mail.com/
>
> Its confirmed to be 0x4F1 as OCLP enables it, and with OCLP and no patche=
s it booted fine.
>
> I plan to add 5K support to efi libstub or something in the future, hence=
 the TODO, so we
> get 5K in simpledrm and get rid of this not good looking quirk.

That sounds like a separate logical change from the rest of the patch.
If changing the order of the init sequence fixes the SMU UCLK issue,
that should be a separate patch from the changes to enable the 5K
display.  That said, I'm not really keen on this change.  Can you dig
further and figure out what the actual issue is?  There are now 3
separate slightly different fixes for this for people with various
Macs:
1. Enabling UCLK DPM in late init
2. Using the UCLK states from the UMC DPM table
3. Changing the init order for specific Mac models

Alex
