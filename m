Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5819FCCA47C
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Jun 2022 13:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5801E10E373;
	Sat, 18 Jun 2022 13:54:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EEC010EEE5
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 09:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655458845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2YIQuKwekY0WiBRZ5F8WSRdemt7ajPawZ+d5zPsp/4=;
 b=eb5++UuRm+9NwmRQkTGCqFWCpYoHP6oxF1IcPadhYpXv1EB6zDp97RD+fa++OYfoYHm6YI
 8hADqeEX0li7SLzzMmLjMmcUUN12PFogx0NtMC+6SqtaVjPqgzTSTQ4S3kkFe6nMjScv+l
 d9LlD4GOcKJQu/fXZRnCBWc3+LEwIes=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-s7PZ6pKoP66s8UmMNFNNng-1; Fri, 17 Jun 2022 05:40:42 -0400
X-MC-Unique: s7PZ6pKoP66s8UmMNFNNng-1
Received: by mail-wm1-f69.google.com with SMTP id
 r83-20020a1c4456000000b0039c8f5804c4so2488599wma.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 02:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=H2YIQuKwekY0WiBRZ5F8WSRdemt7ajPawZ+d5zPsp/4=;
 b=pNeLHZ1HLhucF2fVNwolienr6P2gywCcYPfYNoHOSaqIRPCsaW7X69ejK0gB6sCEQC
 0NUhEtBdjV8BM/Z3LyclEXglX3KvSSPytBRJl2hFt8PFPfCTEg3Xxqo3grdK23z8V2gw
 8Wv6Vcb1ngZdQEXDbuP31uSbKWFIxxaOCkMaMroJg43XRXEbfZwJwmbzebKaq3p9CvQA
 Dvw7RA9BmRzFHYpwJrNUbCYLy5HqRBL/1p+kBuHVLAZMpnN4LulO206/uZ+Irju0Q7Nk
 GSBayfPWsuO/8pxWgCBQQJtGaGI/w/EgtTwlw58JXIRRNtLSDLbAQX5aKOj3l6A8W4VH
 EvoA==
X-Gm-Message-State: AJIora9MjGBO3DwcIcKLgmmIJ1zxJWNOYW4prdpmi7n1vC0wOpcmzyWp
 uBbmwGj8K3Ycpk4xW+c6tjUXipjp7Of20Ue/fQ0l/+a9CgGNPclF73w/+hXl++qgv45DqfEwV3D
 vVaDE7tbIbBDt5PBMSDW6vGCtTA==
X-Received: by 2002:adf:ea90:0:b0:215:a11d:3329 with SMTP id
 s16-20020adfea90000000b00215a11d3329mr8273285wrm.709.1655458841239; 
 Fri, 17 Jun 2022 02:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tcyIDstW1UoHx515Nm3zkT6PwFo4LTcTooQfD0VdaRVMK+nlfneS0G9f2+zYKCej73GtUeFg==
X-Received: by 2002:adf:ea90:0:b0:215:a11d:3329 with SMTP id
 s16-20020adfea90000000b00215a11d3329mr8273248wrm.709.1655458840923; 
 Fri, 17 Jun 2022 02:40:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:7e00:bb5b:b526:5b76:5824?
 (p200300cbc70a7e00bb5bb5265b765824.dip0.t-ipconnect.de.
 [2003:cb:c70a:7e00:bb5b:b526:5b76:5824])
 by smtp.gmail.com with ESMTPSA id
 y14-20020a5d614e000000b0020d09f0b766sm4082674wrt.71.2022.06.17.02.40.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jun 2022 02:40:40 -0700 (PDT)
Message-ID: <3ac89358-2ce0-7d0d-8b9c-8b0e5cc48945@redhat.com>
Date: Fri, 17 Jun 2022 11:40:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
To: Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
References: <20220531200041.24904-1-alex.sierra@amd.com>
 <20220531200041.24904-2-alex.sierra@amd.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 01/13] mm: add zone device coherent type memory support
In-Reply-To: <20220531200041.24904-2-alex.sierra@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 18 Jun 2022 13:54:45 +0000
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

On 31.05.22 22:00, Alex Sierra wrote:
> Device memory that is cache coherent from device and CPU point of view.
> This is used on platforms that have an advanced system bus (like CAPI
> or CXL). Any page of a process can be migrated to such memory. However,
> no one should be allowed to pin such memory so that it can always be
> evicted.
> 
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> [hch: rebased ontop of the refcount changes,
>       removed is_dev_private_or_coherent_page]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/memremap.h | 19 +++++++++++++++++++
>  mm/memcontrol.c          |  7 ++++---
>  mm/memory-failure.c      |  8 ++++++--
>  mm/memremap.c            | 10 ++++++++++
>  mm/migrate_device.c      | 16 +++++++---------
>  mm/rmap.c                |  5 +++--
>  6 files changed, 49 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 8af304f6b504..9f752ebed613 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -41,6 +41,13 @@ struct vmem_altmap {
>   * A more complete discussion of unaddressable memory may be found in
>   * include/linux/hmm.h and Documentation/vm/hmm.rst.
>   *
> + * MEMORY_DEVICE_COHERENT:
> + * Device memory that is cache coherent from device and CPU point of view. This
> + * is used on platforms that have an advanced system bus (like CAPI or CXL). A
> + * driver can hotplug the device memory using ZONE_DEVICE and with that memory
> + * type. Any page of a process can be migrated to such memory. However no one

Any page might not be right, I'm pretty sure. ... just thinking about special pages
like vdso, shared zeropage, ... pinned pages ...

> + * should be allowed to pin such memory so that it can always be evicted.
> + *
>   * MEMORY_DEVICE_FS_DAX:
>   * Host memory that has similar access semantics as System RAM i.e. DMA
>   * coherent and supports page pinning. In support of coordinating page
> @@ -61,6 +68,7 @@ struct vmem_altmap {
>  enum memory_type {
>  	/* 0 is reserved to catch uninitialized type fields */
>  	MEMORY_DEVICE_PRIVATE = 1,
> +	MEMORY_DEVICE_COHERENT,
>  	MEMORY_DEVICE_FS_DAX,
>  	MEMORY_DEVICE_GENERIC,
>  	MEMORY_DEVICE_PCI_P2PDMA,
> @@ -143,6 +151,17 @@ static inline bool folio_is_device_private(const struct folio *folio)

In general, this LGTM, and it should be correct with PageAnonExclusive I think.


However, where exactly is pinning forbidden?

-- 
Thanks,

David / dhildenb

