Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7E0C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 09:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BDC461B31
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 09:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5BDC461B31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17DFC6EC39;
	Fri, 19 Nov 2021 09:51:20 +0000 (UTC)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E56606EC39
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 09:51:18 +0000 (UTC)
Received: by mail-yb1-xb2d.google.com with SMTP id u60so26760559ybi.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 01:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=AbOHWOvKIq/eca8Q4KWaOSSKfY2o9uP+jHdnaKy7YUM=;
 b=YjAFXraBiQKbrYhjDJ7cPFQ13OhRHeEPPCHpNLNsUgiciIHCw57DPkYN0BZYvAtLrq
 /zckFJwndX8YvYwoeLtmGUGwm+QfozIVXrzRXnAZsxuE3Cs8kBpvGRI0+rnA6YX31mr6
 yuwdO7qYsCxAKUkY7UhDu7z8Dr1o4JNfZsUgS08i0lnpDAZHMI/qAHfrCPCJzywv8kdw
 5y5MmC19W7jriwqfHl0ov4h5cNWNzzCXI7Qy0eSGSndicjL5qBImCda1nhlktpai/Fmc
 R3ul7v3pW5UEQxqtVkBMEaifwVIDSxEO6VUlRI1rt6iT2zk5I30ekmrONCnSYfQ/SJD+
 LC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=AbOHWOvKIq/eca8Q4KWaOSSKfY2o9uP+jHdnaKy7YUM=;
 b=fqglrWoWgcU6/70s5FsTdnHAbVVrVExnlqkGpH0dQ325J+UNlgzY/bh+U23icj5Vkb
 PFXoV98B3X7hzTqVSWCbRhzgJHfd6J0ULLKOMEWAOcg0QjThKegbljT+sNFn2RxAbx7m
 zGS50YT/CORqjuojIBlQtW/Ueec0bfh9vA15aU1zS75BhDTNr5XjjOtjuLNGwLo1IkHu
 Xq4m+7aIueXaWix8q0trNDab0QnMaAyNn/jJr4SPMO0x5EikQ8kQpvzMVtrWEcdFXZ3b
 qlzOcKeutlVi43OkQjULuvSiwYrf+pxHHGjIDOSSBkQ3ONimx4mPVTw2rAi7bv4jtGAK
 ClTQ==
X-Gm-Message-State: AOAM533DCAWaqaWP1JRNCxnpw5irx0PwGRJaxXw58qgFhl6D8/Peyrh2
 lRFDEb/uVKDONc1lDg9XR44JQCPKenopBg4gGeKEAZa0r94=
X-Google-Smtp-Source: ABdhPJyPdrCUepr6wdGYO5zZbEQxgxAgEby8LpD2Ju5GWrsS++hbiZ1ox1nayCebFyodAYYoU98zUdjZDpmycA4DrbQ=
X-Received: by 2002:a05:6902:1543:: with SMTP id
 r3mr38865627ybu.166.1637315478085; 
 Fri, 19 Nov 2021 01:51:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:1e0e:0:0:0:0 with HTTP; Fri, 19 Nov 2021 01:51:17
 -0800 (PST)
In-Reply-To: <CADnq5_PyQ1n9fJtmPaEduT5TJmc2Sr1aKhquqsX4xTuzH0BkMg@mail.gmail.com>
References: <CA+nuEB-4gWhk65vKx7hJdkXpk0mPxvuy_PkbA6a94nwZcseONg@mail.gmail.com>
 <CADnq5_PyQ1n9fJtmPaEduT5TJmc2Sr1aKhquqsX4xTuzH0BkMg@mail.gmail.com>
From: Amol <suratiamol@gmail.com>
Date: Fri, 19 Nov 2021 15:21:17 +0530
Message-ID: <CA+nuEB_KQnDBLKhb=nNjFh5Y9tigXgaLBC2dbChAyC9MUp3BYA@mail.gmail.com>
Subject: Re: [radeon] connector_info_from_object_table
To: Alex Deucher <alexdeucher@gmail.com>
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

On 19/11/2021, Alex Deucher <alexdeucher@gmail.com> wrote:
> On Thu, Nov 18, 2021 at 11:37 AM Amol <suratiamol@gmail.com> wrote:
>>
>> Hello,
>>
>> The function radeon_get_atom_connector_info_from_object_table,
>> at location [1], ends up parsing ATOM_COMMON_TABLE_HEADER
>> as ATOM_COMMON_RECORD_HEADER if
>> enc_obj->asObjects[k].usRecordOffset is zero. It is found to be zero
>> in the BIOS found at [2].
>>
>> Thankfully, the loop that follows exits immediately since ucRecordSize
>> is 0 because
>> (ATOM_COMMON_TABLE_HEADER.usStructureSize & 0xff00) is zero.
>> But, with suitable values in the usStructureSize, the loop can be made to
>> run and parse garbage.
>>
>> A similar loop exists when parsing the conn objects.
>
> Can you send a patch to make it more robust?

Sent on a separate email.

Thanks,
Amol

>
> Thanks,
>
> Alex
>
>>
>> -Amol
>>
>> [1]
>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/radeon/radeon_atombios.c#L652
>> [2] https://www.techpowerup.com/vgabios/211981/211981
>
