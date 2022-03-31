Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A08DC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Mar 2022 13:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 244ED10F20C;
	Thu, 31 Mar 2022 13:08:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5395210F445
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 08:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648716920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ZeceZ4MowtZcfgVk5LvYuyjG8NKEFJQ6vum/zhYc1I=;
 b=JtY1ML9h1KgjblU9zuK1923XQSZ7ckptHW75CfFVGTYXcjZCdMyZU0k3CWIVMtkuRXLJaj
 IR1IXgfPwYQCGac7hD6GLInk91ig/oVI1vorH/l/m693SRKT8fVSMuj0Ze/p4JiCa2wmYs
 tBKygJDTrzK1Y832hHhtjcIgnUDZac4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-c6BjltevOy2xJ780rekQdg-1; Thu, 31 Mar 2022 04:55:16 -0400
X-MC-Unique: c6BjltevOy2xJ780rekQdg-1
Received: by mail-wm1-f69.google.com with SMTP id
 r82-20020a1c4455000000b0038c15a1ed8cso1129544wma.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 01:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=0ZeceZ4MowtZcfgVk5LvYuyjG8NKEFJQ6vum/zhYc1I=;
 b=7YIDZYceBDznyZ2e4Y/VvXAPDGfyHmCCMEHCA0uK89a99iGwoZhCcCfMaVlU1BrYG7
 sUD/4tavNvQilClm9xY2iRNabndh+oO+ihep3tUNfdBAl7bjhGgCQIddm2mne45nXNiB
 9MCJXRMyChDSrDZMfu4a0HLfOaUlA/j/gx/JvTlB3WhFn89S9E88mVDQq+DIr4jh9vRn
 B2+XvPHhSyLijj+xnTGUJCFOw+dl0du+epd34zspWWqVoQh6dlqwDxWMk/4ijdWvPpzI
 Cg6dea0gGV3oGjXwZEcn7B77o2EsZhIYoo/CyuhZrRqSz2Snh4PgpzbecL4sbW32cxSD
 52iQ==
X-Gm-Message-State: AOAM531AD3QLxGVCsIj9tV44OFdbSZqP6j0r7Z3+RuIhVEuWBLAcMc/4
 tBMRWnd46huHa1/BjiW9pXA5FyrMe/hjqLr9iNImKcOtAqtQI5z544OosUH4OYoEqkV1WflXUIf
 uCFpaX8MDJx1W5gplM9e4hDPIkQ==
X-Received: by 2002:a5d:6dac:0:b0:205:ccac:c676 with SMTP id
 u12-20020a5d6dac000000b00205ccacc676mr3304072wrs.156.1648716915695; 
 Thu, 31 Mar 2022 01:55:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDW0zeqDZxqpReSRP+T3IGc5ZHXjnkjH5M+CBXHuSyrckPORChwL0jc6rBUWSqN1K/5sw+sA==
X-Received: by 2002:a5d:6dac:0:b0:205:ccac:c676 with SMTP id
 u12-20020a5d6dac000000b00205ccacc676mr3304051wrs.156.1648716915512; 
 Thu, 31 Mar 2022 01:55:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:ac00:381c:2e8b:3b48:488e?
 (p200300cbc707ac00381c2e8b3b48488e.dip0.t-ipconnect.de.
 [2003:cb:c707:ac00:381c:2e8b:3b48:488e])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a05600c1d1400b0038cba2f88c0sm9231563wms.26.2022.03.31.01.55.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Mar 2022 01:55:14 -0700 (PDT)
Message-ID: <709b459a-3c71-49b1-7ac1-3144ae0fa89a@redhat.com>
Date: Thu, 31 Mar 2022 10:55:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 1/3] mm: add vm_normal_lru_pages for LRU handled pages
 only
To: Christoph Hellwig <hch@lst.de>, Alex Sierra <alex.sierra@amd.com>
References: <20220330212537.12186-1-alex.sierra@amd.com>
 <20220330212537.12186-2-alex.sierra@amd.com> <20220331085341.GA22102@lst.de>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220331085341.GA22102@lst.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 31 Mar 2022 13:08:40 +0000
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
 jgg@nvidia.com, akpm@linux-foundation.org, linux-ext4@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 31.03.22 10:53, Christoph Hellwig wrote:
>> -	page = vm_normal_page(vma, addr, pte);
>> +	page = vm_normal_lru_page(vma, addr, pte);
> 
> Why can't this deal with ZONE_DEVICE pages?  It certainly has
> nothing do with a LRU I think.  In fact being able to have
> stats that count say the number of device pages here would
> probably be useful at some point.
> 
> In general I find the vm_normal_lru_page vs vm_normal_page
> API highly confusing.  An explicit check for zone device pages
> in the dozen or so spots that care has a much better documentation
> value, especially if accompanied by comments where it isn't entirely
> obvious.

What's your thought on FOLL_LRU?

-- 
Thanks,

David / dhildenb

