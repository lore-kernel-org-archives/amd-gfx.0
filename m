Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669A9C4321E
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 22:26:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2980C61AA7
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 22:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2980C61AA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EA196E2E1;
	Thu, 18 Nov 2021 22:26:33 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE5A6E2E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 22:26:31 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 u18-20020a9d7212000000b00560cb1dc10bso13498656otj.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 14:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MKkfugnKYJgOQHvUiTzw95EHQzlc93ggqdj8W2VXZ9I=;
 b=XHk+f49laKPYyjv1WF/sprBXjiad8mBhePV3yinSZju1OxbG0KBJWlIH6TXWMYUiiS
 xDCM0aZlv+JxY7jXnHPQWMWX+WTRnvuVwnbZ9KlvxJWy8wKu3KLdi4lzEj1WP2h0K8At
 K3OHVH18CxhE56oIVHsnr9XP9WHMQWO649vWzzLo24u0bRbeReccix/LuheSSF/SISYM
 CTDgPNjA7eYSEgpjHnvGlIifefZbC1Mh0/dogsOfRCU1M7PJkK0pFh5pOA+ei6q4FG9w
 xn22NAgJcFCS1L5NVrphKN8csQV0Hq0IzrpHCymYbJdL1G/yWdQkz8eVXqk0uHQRrpc+
 8NPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MKkfugnKYJgOQHvUiTzw95EHQzlc93ggqdj8W2VXZ9I=;
 b=Kogd73s2oDQMa8EhL94Zapa7kQz6zn4j18y7Ymt+znovb5JXyRtbK6HHX3SLOCcCEq
 wx/32BsNpcZXaCJxEYj8bMsD74voXyZTnUPbPq6YCK5OhDg56UyhUhg2F7x+6fAs/a0v
 6al7aJPExN62bKVPbZ+DWhx5CBc5FbzOV+Gb+7PMlNC250cyDrONQ1TklE3Y3mXs9Im5
 CdOiIQzmKUQFwiPfNionn8YZHtRMtqRkSKRI9NkmfxFRnrg07OxWUptSdBAR4C0w/krn
 OKGwmwc03rpbBpPTB+4mxiTUrnCa/vQGTQs1ecbNASztT8ivS9Qeq30MBYmlMyUDtKmi
 0WIQ==
X-Gm-Message-State: AOAM531KEjC9SFYXF6wyZuTcnWbUqddKrnKsS5pWHUnL868hUx0UmYRA
 Vk4WMWhRwlUZI4GWqffWVSPTxMx9T/iD2WMikWI=
X-Google-Smtp-Source: ABdhPJwO7IHQXMwRlNgEH6UGpHknHvqvXs3iiRIxt8MpZU26ksTbAUz7PK3bi35MAh2iltz47RE8kwgzerrzE/Rrf5Y=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr556871otn.299.1637274391200;
 Thu, 18 Nov 2021 14:26:31 -0800 (PST)
MIME-Version: 1.0
References: <CA+nuEB-4gWhk65vKx7hJdkXpk0mPxvuy_PkbA6a94nwZcseONg@mail.gmail.com>
In-Reply-To: <CA+nuEB-4gWhk65vKx7hJdkXpk0mPxvuy_PkbA6a94nwZcseONg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Nov 2021 17:26:20 -0500
Message-ID: <CADnq5_PyQ1n9fJtmPaEduT5TJmc2Sr1aKhquqsX4xTuzH0BkMg@mail.gmail.com>
Subject: Re: [radeon] connector_info_from_object_table
To: Amol <suratiamol@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 18, 2021 at 11:37 AM Amol <suratiamol@gmail.com> wrote:
>
> Hello,
>
> The function radeon_get_atom_connector_info_from_object_table,
> at location [1], ends up parsing ATOM_COMMON_TABLE_HEADER
> as ATOM_COMMON_RECORD_HEADER if
> enc_obj->asObjects[k].usRecordOffset is zero. It is found to be zero
> in the BIOS found at [2].
>
> Thankfully, the loop that follows exits immediately since ucRecordSize
> is 0 because
> (ATOM_COMMON_TABLE_HEADER.usStructureSize & 0xff00) is zero.
> But, with suitable values in the usStructureSize, the loop can be made to
> run and parse garbage.
>
> A similar loop exists when parsing the conn objects.

Can you send a patch to make it more robust?

Thanks,

Alex

>
> -Amol
>
> [1] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/radeon/radeon_atombios.c#L652
> [2] https://www.techpowerup.com/vgabios/211981/211981
