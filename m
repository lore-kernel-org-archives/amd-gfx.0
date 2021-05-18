Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB018C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 07:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95FDC6124C
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 07:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95FDC6124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0DA06EAB2;
	Tue, 18 May 2021 07:58:39 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9E8A6E858;
 Tue, 18 May 2021 07:58:38 +0000 (UTC)
Received: by mail-lf1-x12b.google.com with SMTP id v9so11394464lfa.4;
 Tue, 18 May 2021 00:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version; bh=T5xFjLMMQC8iz2GBnpTthfrdDlNldeeWnGdVKeCjtoY=;
 b=GOJaykz+puG6m2aLXsjomJvt/TkbnLZ1UNq+SQk49kfzhWRUUZu7dgqxjxBIiLIcqo
 YMXGTc9Enqrndo5RfHNa98nQnNtBGbEY/P8Q33pbIE3zyUsCX725P9BJtHVlPXMBQBZa
 m1SAZIcIt9HDdt2AKW4a7DYAcTvk5fr430Gb6Wct8BKwSIDH7AEeP6vOv/gCDhahEnnk
 7pr0R/c+5PXOxSuO9B8ugRp6lwU/2aUu45qZK2utnfFnlITU1osxINqRxOl84BfKLI9w
 FBd0uYE65Ui9/K7b86fusxTellYkMTjukUU2b+J2e1Latif/pBj3zG9XWPlpgkUKIUC5
 7rfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version;
 bh=T5xFjLMMQC8iz2GBnpTthfrdDlNldeeWnGdVKeCjtoY=;
 b=tthvJTmC8AdNA4O51DqsEIG8EnqHDE8nOU0SAdcNKm5I5fnS8GcNeDNS7DiNmCp/Go
 26Qn4uocaya2ijOzzFQ+4BI+pEdbIYslV0anOdmdNiII4/5WwFA52XL81t0U76Q05caB
 j6QfMybo2SSwf1XsxvoSwvZBcTv/rAPR50DdN3P91djBkB+WJuTh3THbpweuWo4GnWDB
 8ojSIn3FixcPjN1A0xFoxnsHAKdhPb4SjJ48b4IZgrwkkVO96v8yN7eM2lWfde2XI2oi
 3thp3COXoXJZxrFJuMgOU//ZEQU/6pjDDDQYYlrwqmZfl3s8Byv4zeUpAJEVzrfwJ9g4
 ks4A==
X-Gm-Message-State: AOAM532Fw8dx3xrMrI4H3wxqbhD+rmrYYb414Q7wCKWH7T86EAeGDXSG
 YHuDrvRbDNCxzQD90ClfGd0=
X-Google-Smtp-Source: ABdhPJxucoueBjGtrAHoLZYBgcx8jfJPHtOlXFlAyEbaEMMNrMcWADcY384ln5FyRKVnUpX9OlIxRA==
X-Received: by 2002:a19:6d12:: with SMTP id i18mr3136261lfc.249.1621324716595; 
 Tue, 18 May 2021 00:58:36 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
 by smtp.gmail.com with ESMTPSA id u13sm3229509ljk.133.2021.05.18.00.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 May 2021 00:58:36 -0700 (PDT)
Date: Tue, 18 May 2021 10:58:33 +0300
From: Pekka Paalanen <ppaalanen@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>
Subject: Re: [RFC PATCH v2 0/6] A drm_plane API to support HDR planes
Message-ID: <20210518105833.3b3b0b89@eldfell>
In-Reply-To: <20210514210720.157892-1-harry.wentland@amd.com>
References: <20210514210720.157892-1-harry.wentland@amd.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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
Cc: Deepak.Sharma@amd.com, aric.cyr@amd.com, Krunoslav.Kovac@amd.com,
 mcasas@google.com, Shashank.Sharma@amd.com, dri-devel@lists.freedesktop.org,
 Shirish.S@amd.com, sebastian@sebastianwick.net, hersenxs.wu@amd.com,
 amd-gfx@lists.freedesktop.org, laurentiu.palcu@oss.nxp.com,
 Bhawanpreet.Lakha@amd.com, Nicholas.Kazlauskas@amd.com,
 ville.syrjala@linux.intel.com, Vitaly.Prosyak@amd.com
Content-Type: multipart/mixed; boundary="===============1423855464=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1423855464==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YVT3Sud5RAAyMGLjIohkEur"; protocol="application/pgp-signature"

--Sig_/YVT3Sud5RAAyMGLjIohkEur
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 14 May 2021 17:07:14 -0400
Harry Wentland <harry.wentland@amd.com> wrote:

> We are looking to enable HDR support for a couple of single-plane and
> multi-plane scenarios. To do this effectively we recommend new interfaces
> to drm_plane. The first patch gives a bit of background on HDR and why we
> propose these interfaces.
>=20
> v2:

For everyone's information, the discussion is still on-going in the
first email thread.


Thanks,
pq

--Sig_/YVT3Sud5RAAyMGLjIohkEur
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmCjc6kACgkQI1/ltBGq
qqdghg//elfk40cPilOKXwdskNeHI/KHdr3Hnt0BB3NcBXKNzC3dgMGdPDCS7+3w
j1loofkF045pQ9b0qSb6uYF5kF2pxggMKWxvl7aTTdh7irJxdzO+q3BrJv9x3Ct6
OPPYWi41ilqJwXEQJNXv6t+XUxSbn3Hfqit3tiark7HSxJawqnhV84zpgg9N8LMR
1ANylKI1qNAITnll1kY/TsAkvTDH2WPU7u74DmelJbTNKU5QKaWG+pwglX/OB6NU
O38iBCwyHLnJkoJuTLxCAWBwvcWiv+YSQu7Sv0BPfaIRi0aXThPfqAdfMNl5cpgF
Ln0Fh/V8bip7+Soi2fOiN+k0UQ2stnRbf4NOwI3KGZhHUeeyt3kLB2WtN6HGP6B8
XFjvK2TD5I1OPJxKoWOln7fRZOik6FI6FUhSWe5Un1ddxTxfz1ZIlYyu5to055ov
1q+EuwSd89KRXNTjVbMS0UYMPzsY1Pg0IAlDUvqk+c2I8PGsEPqqHtV3Uk7FErMt
/ufPP6Iay7hDvsuZZ0Ae0h6M4hTisB5DXY0ElSQKX+h+PvTA9jMOLob6z4AqDbHA
TTPGb/g3LiglZFlE0lV3x5ZRDC3opz7/UE8CmEoQttksCr370lD9Wq/xGQZWI/Wb
8nIWXL5Nc4rTCFBz+G1pvgkERkYrg0TJZzpFd79JLdkr2JIwmDc=
=dHbo
-----END PGP SIGNATURE-----

--Sig_/YVT3Sud5RAAyMGLjIohkEur--

--===============1423855464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1423855464==--
