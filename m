Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4A7C64ED6
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Feb 2023 19:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6B2F10E077;
	Tue, 28 Feb 2023 19:11:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6345F10E056
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Feb 2023 19:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677611504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kw3rBiRvARwBpX586ASNbibzu933ritNAVE4xT8Eu1U=;
 b=HrFoH8tyoUoaVY9G4TQ6NBLLCzxZ1BgWAPyTEUlizpE0zCUjiqcYjonrvX5pvZ/pmgL0Ps
 3eONdNXoe7oRsUDsmYX50sd4eI3TDq7XjGkKxM058Q0mxxrr0uKSn80ULlhvZhSsXbQ2fn
 dmUiTW6oTqqBJ7LqhrsTsYMP0Gw5x+k=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-161-akbaG-2KOVOUOM9vQkiRjA-1; Tue, 28 Feb 2023 14:11:42 -0500
X-MC-Unique: akbaG-2KOVOUOM9vQkiRjA-1
Received: by mail-ed1-f69.google.com with SMTP id
 p36-20020a056402502400b004bb926a3d54so184874eda.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Feb 2023 11:11:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kw3rBiRvARwBpX586ASNbibzu933ritNAVE4xT8Eu1U=;
 b=AI+t1fjtI1wzUN5uvh8NANdupQ9nu7B0M60vkrvImsmZAHFzimBZ3Tvha+R25lwdHL
 Akf4ZlVy5co5VjWJZjtjw41YcvUa70g3+rdT8fDLK9MTv1dSTaSdVMwQstf3rtuzhqgQ
 ONdTLGwqTNL6FuCND5BTcrWdooVVgPj9drgvfZSC3id/+1Tr344uXMJ8jEJwiwvKp3p2
 YCbrRbOqyEYba+oC4qwb2k4YvJbJKcbXMWnkiuAYp0PCuzmDwhA62xkqgKfQ0hrW6p0j
 mnczRoHx2Xn7ke3x/Zw8XjQK2c74oViwWCJgvHauGDhcntqpdj0pixQpspYsah95mwT3
 aJdA==
X-Gm-Message-State: AO0yUKVCGCbAa5PjsKyEj95yoTni4hZzRK7Ho1Qm6K8J7dbxe5m6heCh
 FelGA4syh8C1Pg0ZT3AtaVyN2ZgHFPUIiPLEQFikwkSFs8Mb5DScae/pYZgLsDy+pXmTnmCfG0Y
 hu0ZOWLvkkZEejhnGw/SIxZ1Bew==
X-Received: by 2002:aa7:d3cd:0:b0:4ad:7c7c:a70d with SMTP id
 o13-20020aa7d3cd000000b004ad7c7ca70dmr4672353edr.19.1677611501659; 
 Tue, 28 Feb 2023 11:11:41 -0800 (PST)
X-Google-Smtp-Source: AK7set/2s2J8IG7DW6HDV/vn0LK7vpDxbvPNMbEpk1J7E0PWf78W/ZVjRrQIYszfZ+XmFFm7wnj26Q==
X-Received: by 2002:aa7:d3cd:0:b0:4ad:7c7c:a70d with SMTP id
 o13-20020aa7d3cd000000b004ad7c7ca70dmr4672321edr.19.1677611501261; 
 Tue, 28 Feb 2023 11:11:41 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de78:642:1aff:fe31:a15c?
 ([2a02:810d:4b3f:de78:642:1aff:fe31:a15c])
 by smtp.gmail.com with ESMTPSA id
 vs3-20020a170907138300b008c06de45e75sm4832720ejb.107.2023.02.28.11.11.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Feb 2023 11:11:40 -0800 (PST)
Message-ID: <280bfe28-ee00-e765-b00e-0d3294dc6ef3@redhat.com>
Date: Tue, 28 Feb 2023 20:11:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Common DRM execution context v3
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20230228083406.1720795-1-christian.koenig@amd.com>
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20230228083406.1720795-1-christian.koenig@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Christian,

On 2/28/23 09:33, Christian König wrote:
> Hi guys,
> 
> thrid round for those patches. They have been in my queue for nearly a
> year now because I couldn't find much time to push into this.
> 
> Danilo wants to use this for his GPU VAs tracker work and Arun needs it
> for hist secure semaphore work, so we should probably get it reviewed
> now.

Thanks for the follow up on this series - very much appreciated!

- Danilo

> 
> Compared to the last version I've fixed one memory leak found by Danilo
> and removed the support for duplicate tracking. Only radeon really needs
> that and we can trivially handle it differently there.
> 
> Please review and/or comment,
> Christian.
> 
> 

