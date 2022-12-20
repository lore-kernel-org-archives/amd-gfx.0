Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56675C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Dec 2022 09:11:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0A0910E343;
	Tue, 20 Dec 2022 09:10:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51CCA10E339
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 09:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671527439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nkva43Ev6FmONs/91WyhlWJwflJzPv43uZcJFYvlalU=;
 b=cCGC89erX8t3sTkQmSt2UHnlC1EUoiigIJWGQ99TxTUFoTxxw5R/Fn4ruTZ+FaTeWEZ2iU
 ZvkqmCIcHst6K733e9dBDIbEeSJ3gkgw/v7P+YCIqhLjvJFU09R75ZO8n+vKJhlktO06+Q
 meJkATtamlYZ1bDrrcjKnOZs0M97t8U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-624-90dqeLkHPyaS7N84tr07-w-1; Tue, 20 Dec 2022 04:10:36 -0500
X-MC-Unique: 90dqeLkHPyaS7N84tr07-w-1
Received: by mail-wr1-f72.google.com with SMTP id
 i25-20020adfaad9000000b002426945fa63so2071804wrc.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Dec 2022 01:10:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nkva43Ev6FmONs/91WyhlWJwflJzPv43uZcJFYvlalU=;
 b=fZvfLgFg+xM4x0lLf/zLqzewTeiGuuVtHVhLnXsYZBwmXNUEm+GxfWS8PjYigDm3Yu
 Mrxg2t5shlbsFMSittIDfE3IWYQ9KyG1cNYEbPKAAvd/GkmfPHIWXwfAGYnuGu51D++r
 m65KO8X2lbKbebRrjYW+87XvX+Zx4z686hPb66jxI+emWVcbYe8yNEm8BZP1cnO/97jb
 hUwL42A1+HreOdXQPdGs7bNuiUrVqu9sOXtrJXYZ5O89qlDwVqFKjvzQ5Xh/V7+IFPcR
 oPwBeE/npZPlenltbrTtB7ZGzb0dZAYnXlrN4JLsexy8Wq17QHJHn6Xfkeord92mHQU7
 l70Q==
X-Gm-Message-State: AFqh2kpe67hILSl7hk1D8/1a3AsSX9mtp/+8bCzDktYLC0JFcViplRfT
 Oh1ejGqv4C+9UgGY64CPrtxefsjvyb8g6NKGeYh8cm6LFgw5ZN8r5S3HL38vUwEQ22wrgLpSDp2
 u6jILIvEOHIHleyv6sABHVcentA==
X-Received: by 2002:a5d:624a:0:b0:242:19b3:67 with SMTP id
 m10-20020a5d624a000000b0024219b30067mr748872wrv.37.1671527435422; 
 Tue, 20 Dec 2022 01:10:35 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvZ4T3pjgbBye4AD0pnUB9As/CnLPdlMjMDQrxm4f9mLfnMBPQihgpuK1r6jSAdZ8wsH7ZV9g==
X-Received: by 2002:a5d:624a:0:b0:242:19b3:67 with SMTP id
 m10-20020a5d624a000000b0024219b30067mr748861wrv.37.1671527435215; 
 Tue, 20 Dec 2022 01:10:35 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 v5-20020a5d59c5000000b00241fea203b6sm12177113wry.87.2022.12.20.01.10.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Dec 2022 01:10:34 -0800 (PST)
Message-ID: <1ba311d8-efe5-c3f0-761e-1b5695dd5ba2@redhat.com>
Date: Tue, 20 Dec 2022 10:10:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 01/18] fbcon: Remove trailing whitespaces
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@gmail.com, deller@gmx.de
References: <20221219160516.23436-1-tzimmermann@suse.de>
 <20221219160516.23436-2-tzimmermann@suse.de>
From: Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221219160516.23436-2-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-fbdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/19/22 17:04, Thomas Zimmermann wrote:
> Fix coding style. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

