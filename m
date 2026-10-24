Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611A1606A31B
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KT/HoBKh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 627DB10ECB8;
	Mon, 26 Oct 2026 08:43:56 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A403910E423
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Oct 2026 20:50:59 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-8ab38a051aaso17040037b3.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Oct 2026 13:50:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792875058; cv=none;
 d=google.com; s=arc-20260327;
 b=KdaYiao7yBRGh9d+AKvvPoWDO8aiczq1waSAEPks9wiETh0V0J1kZXiqLK4Ii2J3qR
 vvlul6etwYAs6cXkrzig2KodaTFmfgtfFb+McEO0DPZ2XHcOhjvVgADq5RaO2y0uJBBi
 XBhbbwhqQY0QA9Duvg4TUvGe141QiJS44V/x1auHEeSNk7cfmPvhbQCdJ1qY2qmFDQsA
 0TGgjtO4+9oeYGQhc/zvGiyMK+1hXRuWTDfuWBckGFIB0/n6H92pOujJxCwpXcfLwzd6
 sb31JBoQR8WlTxmOyGKO9k6s05yCsvvZMDnxyeAn+wUurDROgaH+pk5nYeg7Ojb7FIdW
 HFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=THEh2bYqn6+ElVcsARETUL5wY3+9JX2zf4qY49wZ0/k=;
 fh=go4659PGm8XvFN+ZSNxQYRyMGgEUsl/Aipy5dFN4OXY=;
 b=Ng+rLuipE/4O6BHYSZtm42tdsucMNt0CCHb+l/6Lob33a8b9pY2S0vTsduWpFi3Lpp
 /C2CvKPr2UVwmdq48Rls/g+EvlhDMwgepKj4AYszB2Cu/Jor209C79Ks4C/Hl7NeLEIO
 oRGAivfCignLI/UyYnbaFokBW3ediR+d/rc3p1oYX8lqEGCUiu72+DCO5MEPx+Bl1M7L
 yylwHkj48fB282saj2tNNulLyQNIlppQTUQXXVwdl6WiNRKnyH7XXHXvjpYaYF4IEAmf
 +128qr3crRJcf5VV6N8f/WIEOpr56aXDIqvJEIs8PU2HkHptf/NMOA0wKBWhypCOxEo+
 rOyw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792875058; x=1793479858; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=THEh2bYqn6+ElVcsARETUL5wY3+9JX2zf4qY49wZ0/k=;
 b=KT/HoBKhubdaUSu2lRSo+DIUmbWxe6AXpMubwx6C+zwPjunSQD2lsqHr2TC8/VFDKn
 GWhhRq6aoJP1WOaQcrat/Q6kM1/pEtAkxAkTBNAAqJQnbzZMkyjtKe0C81pKRJMFX2Ze
 w/qYU47wMIj/cptFdK1qJWjZpobPxIlraqMqFIENd5Yp/AbOJ4RqPs33HygFnRCDGtQg
 A+m1hy3Wxp06+n5HuXPQ8BcBT4/v5SlTCwQDx3yr9VnvS61Pg9b2E1/QZPR3qdCJ4jiB
 Hgq/vvf8dy0ITV5TDtqsDk9BVan7iMqOVheqbw3WCvnB35fZkax1lOvI4uGo62K9YKMo
 1EMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792875058; x=1793479858;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=THEh2bYqn6+ElVcsARETUL5wY3+9JX2zf4qY49wZ0/k=;
 b=uWloGlWbR5oSxp2h+VHYCJxnpi2NLGdEuBHuz/Zu482pjqo9/GVZIdOSmDbFxc5Thl
 fza8a4gbeZ9tZ1QfGzkWrxq3zK7K4KwYSMFF/I+dZbBx3WpJ4VJTL0xQ4g292Sxn2Ahe
 zSvf05x/G+LKbx8XaRGMHwKtBAFER7FtT72iGqxbu63TbtTnvd43+SdM9rQTrQjw5q8P
 eHx0h0v4zq51jUze406nosCVnC/KSgxAAPAike2HrqN5lQTidM8ytpSXt1Pd9X2DmaV9
 3USuhX0GMLZw8M4UnLponH9qUhhiuE0XkBRbyI4cBdV3IN9Z1imOuQsYUd4vvsU7SuCp
 ZF9w==
X-Gm-Message-State: AFq9FYIR2dR7T1WlBc7VduDuerRVYFfRGyUe5pM6XA1Jmv3peVWd+WjE
 xPaNHXcsmf04g73hVe4CgIsVaS6PSkaHJKATA2o065ff4GzqF7NF7msV6zbjRhpwidHt3R471er
 F9Yo9qYbsQQV+nO0wxpIZkCmC4l5KA1M=
X-Gm-Gg: AYBFou2zUPQt7kiYetfH4ODPZPvr7dLWif/TVoKbbWqnoHz6shgSOIgFNr8IRBsHl6H
 FHsnBZXoZ+FJDRpnJZ3AVQ1387gDAMCAFTLl9HBq25DV5Kg4f+WtTvKXuYOt8Lex3O5hjiTpv/5
 UFEIuJfFCtywH9VmmcKrGn12uaJ3SMwEwm8snBTf8YkM7JRaJVFrIUUXpJOThz7clbwmC2xoC0E
 EKZevGkdtKzXBUkyEjHpxR5h/kxfD+pDsX1YMttH3ZeUl0gDPAstmEfhI3/l+ALhTSUddDxKS1g
 /LKef3pDigGrlLMw+Hw1Kfb18msDLp2S4zWUL36NBAJ38VmfWSbmW8LWaCTIqIX9K0RD3yFC+yw
 QB7qnN/7cpigwGEXtIyyo1oeahfuHeexmBr8=
X-Received: by 2002:a05:690c:82:b0:8b0:c50c:2547 with SMTP id
 00721157ae682-8b166cbd79amr20873667b3.66.1792875058672; Sat, 24 Oct 2026
 13:50:58 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260923162839.1368073-1-qwe.aldo@gmail.com>
 <20261009030328.3062630-1-qwe.aldo@gmail.com>
In-Reply-To: <20261009030328.3062630-1-qwe.aldo@gmail.com>
From: Aldo Ariel <qwe.aldo@gmail.com>
Date: Sat, 24 Oct 2026 17:50:47 -0300
X-Gm-Features: AclHuK9AhTwIlzFskjDteU31wyGjNevtnC9D6_ZiZtWl8UdkpewAefbYOk7fI8c
Message-ID: <CAP48Hfv00AnX2ejk9twed6ZVPaHFoCUONKC96EdvFASQQj=nZw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix ATOM parameter space index bounds check
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000ffb84e065e9c40fc"
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:43:34 +0000
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
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000ffb84e065e9c40fc
Content-Type: text/plain; charset="UTF-8"

Hi Alex, Christian,

Following up on this v2.

Would any additional testing or changes help with the review of
the parameter-space index bounds check? I'm happy to investigate
further or revise the patch if needed.

Thanks,
Aldo



On Fri, 09 Oct 2026 00:03:27 -0300, Aldo Ariel Panzardo <qwe.aldo@gmail.com>
wrote:
> Hi Alex,
>
> Friendly ping on this v2, sent September 23.  It fixes the dword/byte
> mismatch in the ATOM PS index bounds check in atom_get_src_int() and
> atom_put_dst() -- the sibling of the calltable underflow fix you
> already applied.
>
> v2 also corrects the pr_info() messages to print ps_size/4 (dwords)
> instead of ps_size (bytes), per Sashiko review on v1.
>
> Thanks,
> Aldo

--000000000000ffb84e065e9c40fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Alex, Christian,<br>
<br>
Following up on this v2.<br>
<br>
Would any additional testing or changes help with the review of<br>
the parameter-space index bounds check? I&#39;m happy to investigate<br>
further or revise the patch if needed.<br>
<br>
Thanks,<br>
Aldo</div><br>
<br>
<br>
On Fri, 09 Oct 2026 00:03:27 -0300, Aldo Ariel Panzardo &lt;<a href=3D"mail=
to:qwe.aldo@gmail.com" target=3D"_blank" rel=3D"noreferrer">qwe.aldo@gmail.=
com</a>&gt; wrote:<br>
&gt; Hi Alex,<br>
&gt; <br>
&gt; Friendly ping on this v2, sent September 23.=C2=A0 It fixes the dword/=
byte<br>
&gt; mismatch in the ATOM PS index bounds check in atom_get_src_int() and<b=
r>
&gt; atom_put_dst() -- the sibling of the calltable underflow fix you<br>
&gt; already applied.<br>
&gt; <br>
&gt; v2 also corrects the pr_info() messages to print ps_size/4 (dwords)<br=
>
&gt; instead of ps_size (bytes), per Sashiko review on v1.<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Aldo

--000000000000ffb84e065e9c40fc--
