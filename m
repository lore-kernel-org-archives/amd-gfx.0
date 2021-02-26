Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE055C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 18:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 710A564EC4
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 18:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710A564EC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2DC06EE34;
	Fri, 26 Feb 2021 18:24:51 +0000 (UTC)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C9F6EE2A
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 17:31:18 +0000 (UTC)
Received: by mail-qk1-x729.google.com with SMTP id q85so9822850qke.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 09:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:cc:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=3tt6kFrXSnh5lCzNVkLj4zbz/33wMH5v2uYQMFNuGro=;
 b=Cv7qvhJUqxzEwM226MTIPasWS/LNixb1jARmtnkiMPgT4CX7ejTFQQMOsRpZVYu0EL
 P7J6mt/8aHiiN/6shyWDFBahsNsGwEJjQvcEiFdAKvZrx6NY8h4YTqV8ayQEyJLeT4PZ
 8MK9dKIFIBD+IOoUfJXFRTVaNBfzNpIgh9jhbR3fqVlGOffCCUz63EPbW7kFBZ3SRLQk
 XPo+nY1otKkOcNGRoGadaV01MZAtDvjW47UMQxHjPTA/pjGxNqfmCNRLHIJQicgDuqpj
 irIE+687yQUU8k8BqdwRtnkrGtGmcO8+0V2vvuU9Iy0A5NHAGLsHHEpRC6Hnv1lhrjbJ
 7Yeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:cc:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=3tt6kFrXSnh5lCzNVkLj4zbz/33wMH5v2uYQMFNuGro=;
 b=uD00guc/37DDCjfYTR7GY0CoLpnQigMGmQs8ZCnwSmSOokRsQCW69/B2qmmRrYdyTv
 WZdi1Ak8zcxAu3yuFzP2HW4alrmDkUPON3y4mOdlXnIaOPIDcHPOZvv+344vVXRZ0rHp
 oYt8GFIvMUDhoxZTLQjJP0XOB4Hv++Zbjp69qSn6bGCrU9FEjhsBFPqjOIhYmbDsbZ/2
 R4C8trlZdQyUXqHN1kD30Zy2Gta3hrd5pzShNdgT8OYrgzhkpbirjaJKqmx9B0mVWmnS
 Dxrx34MXFJxJGbNknZvm5bf7j34lXK+UWv/hL3/iPkglmWv/CmIqJTpfz8q34H5stn5v
 PnNw==
X-Gm-Message-State: AOAM531hYTqBqcj+USv4ELQG3lSPl6VL6CEF6/qd3ZHdL4CiM/gz1YX1
 XxJk19nZhQjHDnEmn03V17k=
X-Google-Smtp-Source: ABdhPJxyzTfqtqskE6APVVqzZQoOTk4j+Vs5f85vHT57gnljDaZDpbEzXZ/72zoUGdDS6JG5Xgd9Jg==
X-Received: by 2002:a05:620a:4094:: with SMTP id
 f20mr3674407qko.26.1614360677765; 
 Fri, 26 Feb 2021 09:31:17 -0800 (PST)
Received: from [192.168.2.122] (pool-108-18-37-54.washdc.fios.verizon.net.
 [108.18.37.54])
 by smtp.gmail.com with ESMTPSA id 18sm5837533qkr.77.2021.02.26.09.31.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Feb 2021 09:31:17 -0800 (PST)
Subject: Re: [bug] tab crash on media playback
To: Nirmoy <nirmodas@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <e281729c-d632-1cc2-a1c7-79b4d1cbdc66@gmail.com>
 <f4b795f8-9f79-a946-49dc-0aea27766bf6@amd.com>
 <b091a944-a002-9f6b-c347-1314a0f64385@gmail.com>
 <59967fb7-cf91-d6c9-f431-9b6a60a85c05@amd.com>
From: Cory Bolar <cory.bolar@gmail.com>
Message-ID: <e6206b9a-8616-f4f0-1cf1-6f01c772f0ef@gmail.com>
Date: Fri, 26 Feb 2021 12:31:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <59967fb7-cf91-d6c9-f431-9b6a60a85c05@amd.com>
Content-Language: en-US
X-Mailman-Approved-At: Fri, 26 Feb 2021 18:24:50 +0000
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
Cc: cory.bolar@gmail.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMi8yNi8yMSAxMToxNSBBTSwgTmlybW95IHdyb3RlOgo+IFBsZWFzZSB0cnkgdGhpc1sxXSBk
ZWJ1ZyBwYXRjaCBhbmQgbGV0IHVzIGtub3cgaWYgeW91IHNlZSBhbnl0aGluZyAKPiBpbnRlcmVz
dGluZyBpbiBkbWVzZy4KPgo+Cj4gWzFdIAo+IGh0dHBzOi8vZ2l0aHViLmNvbS9uaXJtb3kvbGlu
dXgvY29tbWl0LzcyYzdhN2UxNjI4NGIzMDkwNTc1MzI0MWIxZTkwMTEyMTg4ODIyYzkKPgo+Cj4g
UmVnYXJkcywKPgo+IE5pcm1veQoKCkRtZXNnIG91dHB1dCB3aGVuIHRyaWdnZXJpbmcgdGhlIGNy
YXNoOgoKClvCoMKgIDc1Ljg1MTc5Ml0gYW1kZ3B1X3R0bV9mYXVsdDogdHRtX2JvX3ZtX2ZhdWx0
X3Jlc2VydmVkIGZhaWxlZCB3aXRoIDEwMjQKW8KgwqAgNzYuNTE2NjgzXSBhdWRpdDogdHlwZT0x
NzAxIGF1ZGl0KDE2MTQzNjAxNjMuMzQyOjg0KTogYXVpZD0xMDAwIAp1aWQ9MTAwMCBnaWQ9MTAw
MCBzZXM9MSBwaWQ9MjE4NSBjb21tPSJDb21wb3NpdG9yVGlsZVciIApleGU9Ii91c3IvbGliL2No
cm9taXVtL2Nocm9taXVtIiBzaWc9NyByZXM9MQpbwqDCoCA3Ni41MjcwNDBdIGF1ZGl0OiB0eXBl
PTEzMzQgYXVkaXQoMTYxNDM2MDE2My4zNTI6ODUpOiBwcm9nLWlkPTE0IG9wPUxPQUQKW8KgwqAg
NzYuNTI3MTM2XSBhdWRpdDogdHlwZT0xMzM0IGF1ZGl0KDE2MTQzNjAxNjMuMzUyOjg2KTogcHJv
Zy1pZD0xNSBvcD1MT0FEClvCoMKgIDc2LjUyODAwNF0gYXVkaXQ6IHR5cGU9MTEzMCBhdWRpdCgx
NjE0MzYwMTYzLjM1Njo4Nyk6IHBpZD0xIHVpZD0wIAphdWlkPTQyOTQ5NjcyOTUgc2VzPTQyOTQ5
NjcyOTUgbXNnPSd1bml0PXN5c3RlbWQtY29yZWR1bXBAMC0yNzg3LTAgCmNvbW09InN5c3RlbWQi
IGV4ZT0iL3Vzci9saWIvc3lzdGVtZC9zeXN0ZW1kIiBob3N0bmFtZT0/IGFkZHI9PyAKdGVybWlu
YWw9PyByZXM9c3VjY2VzcycKW8KgwqAgNzguMDU0Njk4XSBhdWRpdDogdHlwZT0xMTMxIGF1ZGl0
KDE2MTQzNjAxNjQuODgyOjg4KTogcGlkPTEgdWlkPTAgCmF1aWQ9NDI5NDk2NzI5NSBzZXM9NDI5
NDk2NzI5NSBtc2c9J3VuaXQ9c3lzdGVtZC1jb3JlZHVtcEAwLTI3ODctMCAKY29tbT0ic3lzdGVt
ZCIgZXhlPSIvdXNyL2xpYi9zeXN0ZW1kL3N5c3RlbWQiIGhvc3RuYW1lPT8gYWRkcj0/IAp0ZXJt
aW5hbD0/IHJlcz1zdWNjZXNzJwpbwqDCoCA3OC4wODkxMTBdIGFtZGdwdV90dG1fZmF1bHQ6IHR0
bV9ib192bV9yZXNlcnZlIGZhaWxlZCB3aXRoIDEwMjQKW8KgwqAgNzguMjYwOTA5XSBhdWRpdDog
dHlwZT0xMzM0IGF1ZGl0KDE2MTQzNjAxNjUuMDg5Ojg5KTogcHJvZy1pZD0xNSAKb3A9VU5MT0FE
ClvCoMKgIDc4LjI2MDkxM10gYXVkaXQ6IHR5cGU9MTMzNCBhdWRpdCgxNjE0MzYwMTY1LjA4OTo5
MCk6IHByb2ctaWQ9MTQgCm9wPVVOTE9BRAoKClRoYW5rcywKCkNvcnkKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
