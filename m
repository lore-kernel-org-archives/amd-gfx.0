Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDD1C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 17:06:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A4AC10EAC9;
	Fri, 11 Feb 2022 17:06:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2E5910E25C
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 16:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644598152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PP4TELWylzhqvbTRyqntJ6du2uBGE5WicD7gyfPqb1s=;
 b=L8wv4zWoXhN3DvGFAwArd9nmJRWpbc43cPEXwm/TbPogN7hCEsEltiqRtDhD2OaxX/2PJh
 DOQMtZnU6pA+Yx7h49VEMVlnuBkgLZSpVGIWMBPBLkrmqEn9IoqLgb/VQq8m9SaE9FAfBv
 BkAZ5VUoVyjyTM2K7fIuaLdM7km+3tU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-A-Zg5qlCPzK2VaAwO1U3lA-1; Fri, 11 Feb 2022 11:49:11 -0500
X-MC-Unique: A-Zg5qlCPzK2VaAwO1U3lA-1
Received: by mail-wr1-f71.google.com with SMTP id
 p9-20020adf9589000000b001e333885ac1so4059115wrp.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 08:49:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=PP4TELWylzhqvbTRyqntJ6du2uBGE5WicD7gyfPqb1s=;
 b=Fw/LHamypI17/1hggvuxxsgbpboWY72+ew4Wfg9YsjRVK2gvO83nsCIAMF7gxL7Ssr
 toDpiqL2cYCFyI1fJv3zLzaIp/GVxdk0MfFDj2l0sICe0MPxRACEIgEC8nfsPx4yrjyF
 mxHT1cks/lFNFWaDsMslTiPfkduhRtpluycVthPTz28Fkf585jrU3cf83y1BELYwRPX3
 ddrTjdVtvUvAxmgVhwGyiMx6KBofFibzipCtsoiO7c20k7UOOr0sYuWeie9dM65BBRLY
 MCi93TzlFn0EjMN1WzOoRaKT7NyeX/AL5v6ONPG26taL4JbZZdZOO7xuo1DBreqAyn0D
 8oeQ==
X-Gm-Message-State: AOAM530Y0RXB/DWDIvTVqVGDizrDbl83Q7w5lrdFJ8aFfJbp1O9QLmAa
 zan+Gf5/eyFEdhi1IGqv2x2DCEG11Ruts6hEWqV0/DGZHbzwsrCTgXMRQzjA8QY8CRYfhh1/mUP
 6OfawyZo1/H7wNxVUpPVOCnSSjg==
X-Received: by 2002:adf:e94c:: with SMTP id m12mr1981425wrn.383.1644598150267; 
 Fri, 11 Feb 2022 08:49:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7WIrAF58deu+37aUiWlRp/W5UJhe80Crx1E3d+PpeeyE61InCn2g0DPuWCXNpzEMPcQYA7w==
X-Received: by 2002:adf:e94c:: with SMTP id m12mr1981411wrn.383.1644598150072; 
 Fri, 11 Feb 2022 08:49:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c70c:aa00:4cc6:d24a:90ae:8c1f?
 (p200300cbc70caa004cc6d24a90ae8c1f.dip0.t-ipconnect.de.
 [2003:cb:c70c:aa00:4cc6:d24a:90ae:8c1f])
 by smtp.gmail.com with ESMTPSA id f1sm3214049wmb.20.2022.02.11.08.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Feb 2022 08:49:09 -0800 (PST)
Message-ID: <6a8df47e-96d0-ffaf-247a-acc504e2532b@redhat.com>
Date: Fri, 11 Feb 2022 17:49:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v6 01/10] mm: add zone device coherent type memory support
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20220201154901.7921-1-alex.sierra@amd.com>
 <20220201154901.7921-2-alex.sierra@amd.com>
 <beb38138-2266-1ff8-cc82-8fe914bed862@redhat.com>
 <20220211164537.GO4160@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220211164537.GO4160@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 11 Feb 2022 17:06:05 +0000
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
Cc: Alex Sierra <alex.sierra@amd.com>, rcampbell@nvidia.com,
 willy@infradead.org, Felix.Kuehling@amd.com, apopple@nvidia.com,
 amd-gfx@lists.freedesktop.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 jglisse@redhat.com, dri-devel@lists.freedesktop.org, akpm@linux-foundation.org,
 linux-ext4@vger.kernel.org, hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11.02.22 17:45, Jason Gunthorpe wrote:
> On Fri, Feb 11, 2022 at 05:15:25PM +0100, David Hildenbrand wrote:
> 
>> ... I'm pretty sure we cannot FOLL_PIN DEVICE_PRIVATE pages
> 
> Currently the only way to get a DEVICE_PRIVATE page out of the page
> tables is via hmm_range_fault() and that doesn't manipulate any ref
> counts.

Thanks for clarifying Jason! ... and AFAIU, device exclusive entries are
essentially just pointers at ordinary PageAnon() pages. So with DEVICE
COHERENT we'll have the first PageAnon() ZONE_DEVICE pages mapped as
present in the page tables where GUP could FOLL_PIN them.


-- 
Thanks,

David / dhildenb

