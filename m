Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F13C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 15:05:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E668410E49D;
	Fri,  8 Jul 2022 15:05:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D686010F482
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 11:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657279584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gysJ5OLsHMu4TIG7j1vcOsFr+CV/gmdUfz5sTZsCQeI=;
 b=SE5srH5aj5YTVoQGeAmURpbj+6vo07Y5XXzaEOa+2+1dOfC/4cBy+oIZTtnNySoqlLte/t
 KFvFgaVhYwK1Gt6PR3UcxDuJhMqdiDoybF02tv7OA5blWWJd6n8s2GHkNTPsOTuevAdSrc
 4pzR0x1rR8ZSdjN6jgbNIifF88Y331s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-NTcAMG9aO7mj2qNPwOZnyw-1; Fri, 08 Jul 2022 07:26:23 -0400
X-MC-Unique: NTcAMG9aO7mj2qNPwOZnyw-1
Received: by mail-wr1-f71.google.com with SMTP id
 g9-20020adfa489000000b0021d6e786099so2477329wrb.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jul 2022 04:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=gysJ5OLsHMu4TIG7j1vcOsFr+CV/gmdUfz5sTZsCQeI=;
 b=Nr0SthyDqcBBkh62zKQwarpnRWd5CcxcC/1y+NRvtNG1Ekf8T/IKDcYQtNM2AlS6gm
 bjhExfr8QuoASHK6tBLDHWflLEq2Gd4FAxpmchD2821uP9b0FtO1/Bin/8jaAc/Hj9Mt
 npp8YQH8ZtxBQLG/2fM6/A8zS9WpDXDG3msFanqkPkerDEGEl4dVdfVQANLgL3eiZOs2
 GJ2IDiTK5nYOKJ//liTdpvOv52JE02glbiDcmg75Bz9ovO074zXZVR/z9HYbEQAx8jWU
 6yZGFCJi2363Pk+5ycy3R4yOz5WCzsLedfoy7uqtjjP9418E7YvZxBF5y0ne4yyvXzXm
 sWCw==
X-Gm-Message-State: AJIora/jdoQlvoYhHX5c05hgzQrIY3wTR+rZFLUrrnjbVX5DJ1+nWpaX
 JfEWiB31Jpas5zK8jfukbU1cX1u7XGnu1hJWM9Hbo3Mg/3oSqA3N/fa8vTExb7zrVyJKTP1Sr33
 7zx2MAGjIUPQjkut0WK4S3/iHyQ==
X-Received: by 2002:a5d:6288:0:b0:21d:6c75:82 with SMTP id
 k8-20020a5d6288000000b0021d6c750082mr2870470wru.218.1657279582259; 
 Fri, 08 Jul 2022 04:26:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tMgQ+oLwIiDj4/5npv648AeUcMBCTGWDC+qeOo4nVAZAd5xF+qI9gwsPYGbFe8dDYrww+5UA==
X-Received: by 2002:a5d:6288:0:b0:21d:6c75:82 with SMTP id
 k8-20020a5d6288000000b0021d6c750082mr2870444wru.218.1657279582045; 
 Fri, 08 Jul 2022 04:26:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:6300:c44f:789a:59b5:91e9?
 (p200300cbc7026300c44f789a59b591e9.dip0.t-ipconnect.de.
 [2003:cb:c702:6300:c44f:789a:59b5:91e9])
 by smtp.gmail.com with ESMTPSA id
 b18-20020a05600c4e1200b003a2d47d3051sm2145967wmq.41.2022.07.08.04.26.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Jul 2022 04:26:21 -0700 (PDT)
Message-ID: <eddef4be-9c7b-78ae-7cb4-6dda7e20195c@redhat.com>
Date: Fri, 8 Jul 2022 13:26:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 01/15] mm: rename is_pinnable_pages to
 is_longterm_pinnable_pages
To: Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
References: <20220707190349.9778-1-alex.sierra@amd.com>
 <20220707190349.9778-2-alex.sierra@amd.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220707190349.9778-2-alex.sierra@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 08 Jul 2022 15:05:26 +0000
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

On 07.07.22 21:03, Alex Sierra wrote:
> is_pinnable_page() and folio_is_pinnable() were renamed to
> is_longterm_pinnable_page() and folio_is_longterm_pinnable()
> respectively. These functions are used in the FOLL_LONGTERM flag
> context.
> 
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>  include/linux/mm.h | 8 ++++----
>  mm/gup.c           | 4 ++--
>  mm/gup_test.c      | 2 +-
>  mm/hugetlb.c       | 2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

