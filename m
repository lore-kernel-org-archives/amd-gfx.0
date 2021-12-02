Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13149C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 12:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62A266EC30;
	Thu,  2 Dec 2021 12:23:40 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50B786EC30
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 12:23:39 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id k23so54542889lje.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Dec 2021 04:23:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=VWLR83EYq/s7nCM1jW02I4QeoZm7D8Q0iPy8BRLJybk=;
 b=Wt79egDhsZ+vhtx+GI3JuAQEbnQ+UQQXE64TQB1dxcGdhBOusl5+MS7uE3txs5dMa/
 VUq84QxJwkF9t6387RF4qE/LgAA/Lew6rMLBuzSQs6u7lofP8ny9ZEdMwUNiAb4sbMze
 BP8K5+5YP7voMdNaeR+JlTz00PoafqmW/YwGrbP53XInTH1j1lelsz+r+REHHjaIM13U
 Wc3NkSU4hbh09njfgA1/WHo2kr9vgD3GCH6fIXEyd0lTomb/0NMzqygFa2w/LNO/NcVb
 04D0BJQs8n1c899ZcOetPe3O181jr0tgarBWV5C2yHdjJAvsf3AfVzQBfTsFIJKGIlew
 u8mA==
X-Gm-Message-State: AOAM532abexDzYVKnOJLOB25/H05eOz/UobORMx6HHzoHPbyjPBLf2cE
 pNOgIhjpOlALkFxqSEmAKcs=
X-Google-Smtp-Source: ABdhPJxMwxioRReY7xYBS39bixdYsnTVGcRNUyFWpp3G+QpXpi7sTcljRV5Ap5uAe+u3+3B5LAl7QQ==
X-Received: by 2002:a05:651c:b0e:: with SMTP id
 b14mr11499984ljr.495.1638447817701; 
 Thu, 02 Dec 2021 04:23:37 -0800 (PST)
Received: from [192.168.0.131] ([176.122.114.46])
 by smtp.gmail.com with ESMTPSA id w15sm308652ljo.97.2021.12.02.04.23.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Dec 2021 04:23:37 -0800 (PST)
Message-ID: <960ccf6a-3593-538e-1d4f-0b67c72ccccc@kde.org>
Date: Thu, 2 Dec 2021 14:23:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/display: Use orientated source size when checking
 cursor scaling
Content-Language: en-US
To: Simon Ser <contact@emersion.fr>
References: <20211202121650.2265-1-vlad.zahorodnii@kde.org>
 <wokYiPNfrckmjqs2r5_IU-pvNbB8xb6JnNLEVXKj-ACeAd4X6NX_mPpKSiQktbq2DftWMhGAEq89M6qrG-15vM0Z0AhPT2ZCjM6FRy2fhe0=@emersion.fr>
From: Vlad Zahorodnii <vlad.zahorodnii@kde.org>
In-Reply-To: <wokYiPNfrckmjqs2r5_IU-pvNbB8xb6JnNLEVXKj-ACeAd4X6NX_mPpKSiQktbq2DftWMhGAEq89M6qrG-15vM0Z0AhPT2ZCjM6FRy2fhe0=@emersion.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: alexander.deucher@amd.com, Rodrigo.Siqueira@amd.com,
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org, xaver.hugl@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/2/21 14:21, Simon Ser wrote:
> Have you tested this? I have a similar patch, but the cursor position was off
> when I tried it.
> 

Works fine on my machine with RX 5700 XT.

Cheers,
vlad
