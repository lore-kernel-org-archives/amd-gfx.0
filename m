Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164B4C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 13:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E22F310EABC;
	Thu, 30 Jun 2022 13:14:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E02F10E434
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 10:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656583455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DmU0ygkfQICKkJrotNjuaw4hfz5r1ur5tb6+FXoicmQ=;
 b=S7DdhvTSXScIYVmG+10yxGEIzaU38pDoU6AEU8eqEeM6lYPQRNAmg/9LSRUtlI7YMCpcB2
 rXpIgPX6aUjg9nddnqZoIjjVmzrexj61oGAewgES+rb1acfkWR8cr6gpeLnrjAizH2sjCZ
 NRcNHWuUkj7Qbb+RW/Pm06XuuMs1Tfo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-lwFo_mjbPZufav6trX5wbw-1; Thu, 30 Jun 2022 06:04:11 -0400
X-MC-Unique: lwFo_mjbPZufav6trX5wbw-1
Received: by mail-wr1-f70.google.com with SMTP id
 o21-20020adfa115000000b0021d3f78ebc2so212101wro.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 03:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:organization:subject
 :in-reply-to:content-transfer-encoding;
 bh=DmU0ygkfQICKkJrotNjuaw4hfz5r1ur5tb6+FXoicmQ=;
 b=sfdw/I5Pt031hlKhVCDVk1UHNHYS8UodRu3Yy1c2ts5AdUL/AEj8xFaajw+Df9itgW
 nZJd0cMUzj0o+0pWl9sN11zVHhtl/QA689udW0Q6xblBhS4+lKEcRwt+4AOK40ywwPkw
 wGojvDr/8XSjfhjduLJrUObSFGZxYdSD2GgJBa7yooDPzydgy0X47TsuHpilZ/KZOD9u
 ObUO8hAP87+7qMqm9vEsWw45c9SGXtG6ZoY3CJkqU/N4o4BxgvlvsheA+iQ2eWYmfSlI
 QvetJR1np2s/Oo7V8klfGAf1ig0arqoCjB5A0PrUDQ/NTOQxWxP+87GKymVqq1OUX9xU
 AEIQ==
X-Gm-Message-State: AJIora/p3rtvYMnmLsY4CyTVHnf7lDI5cDgk/qz1KcJu0lTqkz8Lxg7C
 PkY0GP4W2pyKFB8ECJtjEPljs9W6XyZ0tFuKftgyJEvyYTRz66+diuHttaEQ2+U+i1M3UAq3dt4
 ySZigUQdfi/grI+n5D1yRNiiIiA==
X-Received: by 2002:a7b:c152:0:b0:3a0:3e53:aa17 with SMTP id
 z18-20020a7bc152000000b003a03e53aa17mr11394759wmi.78.1656583450235; 
 Thu, 30 Jun 2022 03:04:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vuI1sm5VybPo4wkaCR+sryKNwQzXdsHV339ZfkUZFjdgFAR5z/wUEvUcNLFrEOEmcW1irqSA==
X-Received: by 2002:a7b:c152:0:b0:3a0:3e53:aa17 with SMTP id
 z18-20020a7bc152000000b003a03e53aa17mr11394724wmi.78.1656583449915; 
 Thu, 30 Jun 2022 03:04:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:7f00:214b:cffb:c693:2b71?
 (p200300cbc7087f00214bcffbc6932b71.dip0.t-ipconnect.de.
 [2003:cb:c708:7f00:214b:cffb:c693:2b71])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a05600c1c1600b003a046549a85sm2150594wms.37.2022.06.30.03.04.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jun 2022 03:04:09 -0700 (PDT)
Message-ID: <956b1c51-b8f1-0480-81ca-5d03b45110f7@redhat.com>
Date: Thu, 30 Jun 2022 12:04:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
To: Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
References: <20220629035426.20013-1-alex.sierra@amd.com>
 <20220629035426.20013-5-alex.sierra@amd.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v7 04/14] mm: add device coherent vma selection for memory
 migration
In-Reply-To: <20220629035426.20013-5-alex.sierra@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 30 Jun 2022 13:14:03 +0000
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
> This case is used to migrate pages from device memory, back to system
> memory. Device coherent type memory is cache coherent from device and CPU
> point of view.
> 
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Reviewed-by: Alistair Poppple <apopple@nvidia.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>


I'm not too familiar with this code, please excuse my naive questions:

> @@ -148,15 +148,21 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  			if (is_writable_device_private_entry(entry))
>  				mpfn |= MIGRATE_PFN_WRITE;
>  		} else {
> -			if (!(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM))
> -				goto next;

Why not exclude MIGRATE_VMA_SELECT_DEVICE_PRIVATE here? IIRC that would
have happened before this change.


>  			pfn = pte_pfn(pte);
> -			if (is_zero_pfn(pfn)) {
> +			if (is_zero_pfn(pfn) &&
> +			    (migrate->flags & MIGRATE_VMA_SELECT_SYSTEM)) {
>  				mpfn = MIGRATE_PFN_MIGRATE;
>  				migrate->cpages++;
>  				goto next;
>  			}
>  			page = vm_normal_page(migrate->vma, addr, pte);
> +			if (page && !is_zone_device_page(page) &&

I'm wondering if that check logically belongs into patch #2.

> +			    !(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM))
> +				goto next;
> +			else if (page && is_device_coherent_page(page) &&
> +			    (!(migrate->flags & MIGRATE_VMA_SELECT_DEVICE_COHERENT) ||
> +			     page->pgmap->owner != migrate->pgmap_owner))


In general LGTM

-- 
Thanks,

David / dhildenb

