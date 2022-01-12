Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0CDC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 13:26:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67AB011286E;
	Wed, 12 Jan 2022 13:26:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1DF510E933
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 11:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641986184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rvfHccyQZvOEcbK/VSQsdfq4siS9aIa44pr1d+OE6yo=;
 b=HV2n6834naNCbIZnaNHPIypf2eoTRdIK79SE8YfNmCfh7aR8WTDGMpDKzqQhigMZiW22/R
 f76eXrQOjATiw8DNAqwilw3VwEz/yVLM24JMngFqKxqGgwqnAFr0NZooHUXjlSDSTq6T8I
 QkhgDBqfNNMqblUru8Oewr4NvjKKvZU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-AdCo1OJ8MKaPOEM3JpkUqA-1; Wed, 12 Jan 2022 06:16:15 -0500
X-MC-Unique: AdCo1OJ8MKaPOEM3JpkUqA-1
Received: by mail-ed1-f71.google.com with SMTP id
 b8-20020a056402350800b003f8f42a883dso1953195edd.16
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 03:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=rvfHccyQZvOEcbK/VSQsdfq4siS9aIa44pr1d+OE6yo=;
 b=7M8my1un0VbNWxOQKC9NLtKqyyQuceqTSIyAnPEquWJ0dqrkl9AFyspUJ8gJ5P1GAl
 Uu8eupTS0cKahtkQQppKIky5csvbX95JakSSIPnghg6XLqx7lEI32DtYkyEMv9SsyblV
 b1hUb8FFPaIwcJsuIrlPU9QAo2ZvVnSfdR68scBwNLbM4aUEOC8GHaf3YHYOOmXBQq6j
 8EPQ1Suu3s5bFJIzrOWS9/syUVH/dHFDZ9/GfsiVmW4/2EDZKPTCUbgY1N6a/XU39p3/
 PAe3JL6hPzHN9IAZZMN4A6OZtRXYE4/Po4chv5TdFtBXZ20SumRWmYLLtwTYoJ1ywMSi
 K43w==
X-Gm-Message-State: AOAM531YloG/EdiDpQHxEdvViV36DjIuS26vA+bKtJjHBX/kO3Jkh4OB
 KE7pJKfTw2PbFhXTkSxORmbx9sUKDz6oNOYpTJBi9HnEgb3H7QQGQ8XpKOC16zHSARbec5aqDGQ
 XjDSDPctGrOKYH9GHwZyfxsGGvw==
X-Received: by 2002:a17:906:974a:: with SMTP id
 o10mr7201047ejy.226.1641986174390; 
 Wed, 12 Jan 2022 03:16:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJylcjOYtqv8QO2gzLMiyLf36NeGdQwoe97SOgETUwT3484y0JFJN63XyHPi2xLKoaaQHMvZ5w==
X-Received: by 2002:a17:906:974a:: with SMTP id
 o10mr7201027ejy.226.1641986174194; 
 Wed, 12 Jan 2022 03:16:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:4700:e25f:39eb:3cb8:1dec?
 (p200300cbc7024700e25f39eb3cb81dec.dip0.t-ipconnect.de.
 [2003:cb:c702:4700:e25f:39eb:3cb8:1dec])
 by smtp.gmail.com with ESMTPSA id f18sm6068251edf.95.2022.01.12.03.16.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jan 2022 03:16:13 -0800 (PST)
Message-ID: <8c4df8e4-ef99-c3fd-dcca-759e92739d4c@redhat.com>
Date: Wed, 12 Jan 2022 12:16:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 00/10] Add MEMORY_DEVICE_COHERENT for coherent device
 memory mapping
To: Alex Sierra <alex.sierra@amd.com>, akpm@linux-foundation.org,
 Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20220110223201.31024-1-alex.sierra@amd.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220110223201.31024-1-alex.sierra@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 12 Jan 2022 13:26:25 +0000
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
Cc: willy@infradead.org, apopple@nvidia.com, dri-devel@lists.freedesktop.org,
 jglisse@redhat.com, amd-gfx@lists.freedesktop.org, jgg@nvidia.com, hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10.01.22 23:31, Alex Sierra wrote:
> This patch series introduces MEMORY_DEVICE_COHERENT, a type of memory
> owned by a device that can be mapped into CPU page tables like
> MEMORY_DEVICE_GENERIC and can also be migrated like
> MEMORY_DEVICE_PRIVATE.
> 
> Christoph, the suggestion to incorporate Ralph Campbell’s refcount
> cleanup patch into our hardware page migration patchset originally came
> from you, but it proved impractical to do things in that order because
> the refcount cleanup introduced a bug with wide ranging structural
> implications. Instead, we amended Ralph’s patch so that it could be
> applied after merging the migration work. As we saw from the recent
> discussion, merging the refcount work is going to take some time and
> cooperation between multiple development groups, while the migration
> work is ready now and is needed now. So we propose to merge this
> patchset first and continue to work with Ralph and others to merge the
> refcount cleanup separately, when it is ready.
> 
> This patch series is mostly self-contained except for a few places where
> it needs to update other subsystems to handle the new memory type.
> System stability and performance are not affected according to our
> ongoing testing, including xfstests.
> 
> How it works: The system BIOS advertises the GPU device memory
> (aka VRAM) as SPM (special purpose memory) in the UEFI system address
> map.
> 
> The amdgpu driver registers the memory with devmap as
> MEMORY_DEVICE_COHERENT using devm_memremap_pages. The initial user for
> this hardware page migration capability is the Frontier supercomputer
> project. This functionality is not AMD-specific. We expect other GPU
> vendors to find this functionality useful, and possibly other hardware
> types in the future.
> 
> Our test nodes in the lab are similar to the Frontier configuration,
> with .5 TB of system memory plus 256 GB of device memory split across
> 4 GPUs, all in a single coherent address space. Page migration is
> expected to improve application efficiency significantly. We will
> report empirical results as they become available.

Hi,

might be a dumb question because I'm not too familiar with
MEMORY_DEVICE_COHERENT, but who's in charge of migrating *to* that
memory? Or how does a process ever get a grab on such pages?

And where does migration come into play? I assume migration is only
required to migrate off of that device memory to ordinary system RAM
when required because the device memory has to be freed up, correct?

(a high level description on how this is exploited from users space
would be great)

-- 
Thanks,

David / dhildenb

