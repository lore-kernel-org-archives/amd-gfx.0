Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EFCC43334
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 07:38:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B73810F7D9;
	Wed, 29 Jun 2022 07:38:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32D481120B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 07:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656488013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dA2eoSPtGttWxJYZGlfOcE/QeU9denwWrEKtVHSFEyo=;
 b=RjZzRQXEzUevNSu6VfUPeENuCjiAflugBKE+0cfUCRlXIpBVdVIGS4YDmWkDHcNEnodF8+
 rIjdx3nEI740BDTAgJMA/+0Eq9MxsSwPgJmoxJV2IGg/6onWSsP2XnQQTSrJCucHYUEV26
 2byZZM5eTTqV2w9n0D+DuZ29VIHMCY8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-wDRXUOGuOhmEIfWF44RJ5A-1; Wed, 29 Jun 2022 03:33:31 -0400
X-MC-Unique: wDRXUOGuOhmEIfWF44RJ5A-1
Received: by mail-wr1-f69.google.com with SMTP id
 y18-20020adfdf12000000b0021b94ba4c37so2156584wrl.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 00:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=dA2eoSPtGttWxJYZGlfOcE/QeU9denwWrEKtVHSFEyo=;
 b=RYRfXcVpCHQhPEUm9gkvq3igID7yUd/NeYBjgv9cSbaS83a3lx5aXDVEVytJdK/tLd
 v/Ux9Z+QxTFvsygup7mo9RBvzUvegHlVl7B1mGIJa99ad9y8GpQ1qxk1pKNRU1CmFif4
 ruy8YZZBOMxzRPQ0UoFJRqUEZWmJqLsF0jXFhvF+9t/Y0mpM5qLP9SNqa+fPAZIj7jSb
 C4P+BGg5q3ZQu1xcebP7Ji+9u8rjKPGGuwMFcTXOJ/QWOKI9vRIvwAyHDZT9sATvrJOo
 cKrhCljXgfdSvqT43cszS3yx5e34DdXcSC1PiIExPAhUcm5P0d5F+h/K9/QzKM93B0mS
 JhVg==
X-Gm-Message-State: AJIora9cQp6BvUrerlGanCKAEOCoiQtJzuv4gbjt+o52MNzOQmPiKQJo
 1JRKqUnDGm1+A8QkhbcPA1IG9gNmCiMikCOGk6S/R2LaLcgYFIP6DGJAMiTUBvrcO4Eqxzk9DLr
 qZUz815Mxr7zilf9Hsv9XvYN3dw==
X-Received: by 2002:a05:600c:3591:b0:3a0:563a:49d3 with SMTP id
 p17-20020a05600c359100b003a0563a49d3mr1926447wmq.60.1656488010096; 
 Wed, 29 Jun 2022 00:33:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uum8Hx2eoXPmPEzIAfJI+bxpHTzM8+zWRZ0znb96530kqbhcZ9rF+BBXjqVzGxgQ61VtlDlw==
X-Received: by 2002:a05:600c:3591:b0:3a0:563a:49d3 with SMTP id
 p17-20020a05600c359100b003a0563a49d3mr1926431wmq.60.1656488009851; 
 Wed, 29 Jun 2022 00:33:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:e600:d4fa:af4b:d7b6:20df?
 (p200300cbc708e600d4faaf4bd7b620df.dip0.t-ipconnect.de.
 [2003:cb:c708:e600:d4fa:af4b:d7b6:20df])
 by smtp.gmail.com with ESMTPSA id
 g21-20020a7bc4d5000000b0039c587342d8sm2175038wmk.3.2022.06.29.00.33.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jun 2022 00:33:29 -0700 (PDT)
Message-ID: <f00f9c93-c115-d222-dc8c-11493ccd2567@redhat.com>
Date: Wed, 29 Jun 2022 09:33:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 01/14] mm: rename is_pinnable_pages to
 is_pinnable_longterm_pages
To: Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
References: <20220629035426.20013-1-alex.sierra@amd.com>
 <20220629035426.20013-2-alex.sierra@amd.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220629035426.20013-2-alex.sierra@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 29 Jun 2022 07:38:39 +0000
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

On 29.06.22 05:54, Alex Sierra wrote:
> is_pinnable_page() and folio_is_pinnable() were renamed to
> is_longterm_pinnable_page() and folio_is_longterm_pinnable()
> respectively. These functions are used in the FOLL_LONGTERM flag
> context.

Subject talks about "*_pages"


Can you elaborate why the move from mm.h to memremap.h is justified?

I'd have called it "is_longterm_pinnable_page", but I am not a native
speaker, so no strong opinion :)


-- 
Thanks,

David / dhildenb

