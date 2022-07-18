Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C41C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 12:56:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F1711138E4;
	Mon, 18 Jul 2022 12:56:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A688812B2D9
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 10:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658141795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wznRRcQ1E1EPLsgI7kgVwWWa1K3DaSgJ1EEclGC9ESw=;
 b=haZ3+z2iAGdZ1DYtpdo7y/oEr6PGsT6sGO8nuvS0HlIpLUKLaq3hzDnIwkK6j8i0MuPNZS
 W/7vdPk+h71iz+HAGJtoAq662kW8Rwh/GWr6z0y0KoU7dGXmX1YmnARu1IFDTyCy6LR42k
 Vx4SAPOc/f8cEgJ1Ib4Q2kEb93OXLWE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-f6yjvEmMNtaFowIKYd3k6w-1; Mon, 18 Jul 2022 06:56:32 -0400
X-MC-Unique: f6yjvEmMNtaFowIKYd3k6w-1
Received: by mail-wm1-f70.google.com with SMTP id
 c62-20020a1c3541000000b003a30d86cb2dso5129005wma.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 03:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=wznRRcQ1E1EPLsgI7kgVwWWa1K3DaSgJ1EEclGC9ESw=;
 b=CM4OFXYkFHO+Zc2nPHci5D/RC/eRasGPBJFV48ZWA2EOEOOvbrIPF01t1CBHxbyB8L
 ErK10BIwMTaJiDjI/1NL7wN+tOdLuMfCTDR6iokq6ANAJYa6OVi2TKTzVrz+SWMMCkG5
 hphAanXAHEEBc2v5W3yKiFW4UIbra3FP3szzFKeD0+6dwiTgo8+yz27uQIOhu+Q+tjpj
 ap+8zjOLd7svzpn2jrQICFQHENldJJYPI9A1S3OFMnHcK4k6jMRuXUzT/rDIYsO9iD56
 3Y5noybg3s2/+fBPIjBWh7Vk3RjLEfbyj2V2YY1oQXrAkx8JYAMlk9mHBg60CZNZGtcN
 4rJw==
X-Gm-Message-State: AJIora98XY2YupmdBFXRSiYUL3ht0P2jRkhwrF9b+52CIk6nBERwGuFs
 9UKzKrm8Fv78tXYPQ1EkwWqxg9koFPOG0t/w+0HcvGReNmwTJDInTgEkGqyyowIAKqD6tkXrSbK
 C+8t/5kdIadfxOwXCmN0jmtTKCw==
X-Received: by 2002:a05:600c:3b8d:b0:3a2:ea2b:d0f9 with SMTP id
 n13-20020a05600c3b8d00b003a2ea2bd0f9mr25454660wms.120.1658141791261; 
 Mon, 18 Jul 2022 03:56:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1semjCkDwGjEQMzpCRvMdqQ/nTLWiXGmEKcwwSpdKliRLXOgrdG+Rkplh3ByVOTYHpbct/E2A==
X-Received: by 2002:a05:600c:3b8d:b0:3a2:ea2b:d0f9 with SMTP id
 n13-20020a05600c3b8d00b003a2ea2bd0f9mr25454634wms.120.1658141790977; 
 Mon, 18 Jul 2022 03:56:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7400:6b3a:a74a:bd53:a018?
 (p200300cbc70574006b3aa74abd53a018.dip0.t-ipconnect.de.
 [2003:cb:c705:7400:6b3a:a74a:bd53:a018])
 by smtp.gmail.com with ESMTPSA id
 g1-20020a5d5541000000b0021d728d687asm12298516wrw.36.2022.07.18.03.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Jul 2022 03:56:30 -0700 (PDT)
Message-ID: <225554c2-9174-555e-ddc0-df95c39211bc@redhat.com>
Date: Mon, 18 Jul 2022 12:56:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9 06/14] mm/gup: migrate device coherent pages when
 pinning instead of failing
To: Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
References: <20220715150521.18165-1-alex.sierra@amd.com>
 <20220715150521.18165-7-alex.sierra@amd.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220715150521.18165-7-alex.sierra@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 18 Jul 2022 12:56:34 +0000
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
Cc: rcampbell@nvidia.com, willy@infradead.org, Felix.Kuehling@amd.com,
 apopple@nvidia.com, amd-gfx@lists.freedesktop.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, jglisse@redhat.com, dri-devel@lists.freedesktop.org,
 akpm@linux-foundation.org, linux-ext4@vger.kernel.org, hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 15.07.22 17:05, Alex Sierra wrote:
> From: Alistair Popple <apopple@nvidia.com>
> 
> Currently any attempts to pin a device coherent page will fail. This is
> because device coherent pages need to be managed by a device driver, and
> pinning them would prevent a driver from migrating them off the device.
> 
> However this is no reason to fail pinning of these pages. These are
> coherent and accessible from the CPU so can be migrated just like
> pinning ZONE_MOVABLE pages. So instead of failing all attempts to pin
> them first try migrating them out of ZONE_DEVICE.
> 
> [hch: rebased to the split device memory checks,
>       moved migrate_device_page to migrate_device.c]
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

[...]

>  		/*
>  		 * Try to move out any movable page before pinning the range.
>  		 */
> @@ -1919,7 +1948,8 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
>  				    folio_nr_pages(folio));
>  	}
>  
> -	if (!list_empty(&movable_page_list) || isolation_error_count)
> +	if (!list_empty(&movable_page_list) || isolation_error_count
> +		|| coherent_pages)

The common style is to

a) add the || to the end of the previous line
b) indent such the we have a nice-to-read alignment

if (!list_empty(&movable_page_list) || isolation_error_count ||
    coherent_pages)


Apart from that lgtm.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

