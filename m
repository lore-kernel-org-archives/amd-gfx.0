Return-Path: <SRS0=hzS6=OF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7863AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 10:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4F561242
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 10:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F4F561242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3777589BAC;
	Wed, 15 Sep 2021 10:36:55 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E867D89B7B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 10:36:53 +0000 (UTC)
Received: by mail-qk1-x72a.google.com with SMTP id bk29so2828595qkb.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Sep 2021 03:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/mGcCmjESDIAm3+tF207IbSt9cMpy/yGpDLXhbXJilw=;
 b=jZC6J42lFWe5NjJGxcOV7d5AVFnElkEpr8x+JCTMRSstrsGQB7n1PDUNmHQE+EjSNI
 8a8PFwQYT3/eO9AmTYKozh2AB+ToXko00hIRCPFSCtNyWdCeNudFFHu2G5RnjgevgSPT
 5iY/6u6XgvLeUuGI0IjNvnNWQqUNtyMWw8DqXz6SgkP+6ejr2dKXCtdrKoyA84l0aEmK
 mr41TRJlBSEcavNsm/QFGj7kBko3Odrd/5rvAZ01j/6mxcqdILwtJ0oQ+7p+jt6xRkNB
 sKJfnShOM2tR7QOCzqiT0xb4f9MvVKCkRdu8vV6BQr5a5DZqc7vH6Y3jZLJ2OVxALGNc
 /q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/mGcCmjESDIAm3+tF207IbSt9cMpy/yGpDLXhbXJilw=;
 b=kEPgMKzG2NynjRL0m6A/ClW5qrYztu9wYKle2kkYOA3CijDcQbkVxtMqObQb8450SZ
 quSaUu5R17Mve5RTvLG7Y7UCYfBFo1UONIWfkUGjGGM36iqRLXsADiWLPkqAFL451UBd
 kq5SMOtZyvyNYeIzj3Q0N1+dpvuE1isgBJNC6WmVcrhF+0ddqyTxcLgpnMqAID4UQ1/n
 sQ1ZeVpK0RuDlZmr4VtLWTbC8TMXOGjBY2ZbHeKeaT6n0feGlPbepofVY/Vb7402vCzA
 Z/LzE1G69y9IdoVp7kfL6un334V71FafoJDKVAyDcz56sXv0ePhPmvWKdt+UNk6dUTGJ
 DjsQ==
X-Gm-Message-State: AOAM533s8DWvSHFUSsHLO0LBn7jmMjxFyBVjHG6FglDZY460N0TjJUhm
 u4eWlzIhmqc/DUvCqKJimUgYWRgbkSJEy6ALE7v/H8C+tRI=
X-Google-Smtp-Source: ABdhPJyyeGXQ3+sRzznoBgOxXz9YNLXSOUaweAHcQrmowpOjqhjo5dtOoCXxwX8tTWUygcmhyv3Bpmdep+B6k4C28TY=
X-Received: by 2002:a05:620a:1388:: with SMTP id
 k8mr9066031qki.152.1631702213021; 
 Wed, 15 Sep 2021 03:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsOifMk4+VHi4bnHCL2L_tT+Tm_Rz+KxD3ZQOowx1xms4g@mail.gmail.com>
 <293189a2-3a6b-1e50-7607-33917743b9d8@amd.com>
 <CABXGCsMMUa=0+GAHxfVdOOFO0Lx=tCa4+ongHN8rF4TAR9nVmg@mail.gmail.com>
 <66f5fdcb-d414-603d-bdb8-70579335b4a2@gmail.com>
 <CABXGCsOPLH2DkZ09PDXSxStin6JJb_m5bJuQWmXooBLaSJ2Ezg@mail.gmail.com>
 <dcbb87cc-c95d-ae58-d601-413a6277a7f8@amd.com>
In-Reply-To: <dcbb87cc-c95d-ae58-d601-413a6277a7f8@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 15 Sep 2021 15:36:42 +0500
Message-ID: <CABXGCsOQ8uXY85zrCOOd611gDj3AhtqH4=LcYHD=T9jVEzkuig@mail.gmail.com>
Subject: Re: [BUG] VAAPI encoder cause kernel panic if encoded video in 4K
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Wed, 15 Sept 2021 at 14:55, Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Yes, absolutely. You should see GPU resets and recovery in the system log=
 after that.

Unfortunately, not one DE will survive a GPU reset. All applications
will terminate abnormally in fact this would be equivalent to reboot
(and denial of service). :(

--=20
Best Regards,
Mike Gavrilov.
