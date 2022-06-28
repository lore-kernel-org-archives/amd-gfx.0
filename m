Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA88CCA479
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 13:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E17711BD56;
	Tue, 28 Jun 2022 13:03:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A95BD12B66A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 10:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656412970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ONUUHv3MjjvFIJKVWzF/NPSOZ8SZcSjCl83bnjLd8nk=;
 b=Hck/UEpIyYkrOih5cuyld8kC7OwJDMnkfmO96xxNJYnec48cAmDl/jyXZnO0P574KwWGaj
 FfJcQe/qr3aYnHCo2I0t+D6utjyizF/y+yj9Wd6w+N2Ris24KuVeDMQyfqELSI3qDUGuzI
 a/pEk21MwKmw8KTMB6iWxsaIcyETxbI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-viS9QtPjO16mv33-XA_upg-1; Tue, 28 Jun 2022 06:42:49 -0400
X-MC-Unique: viS9QtPjO16mv33-XA_upg-1
Received: by mail-wm1-f69.google.com with SMTP id
 c185-20020a1c35c2000000b0039db3e56c39so8691980wma.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 03:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=ONUUHv3MjjvFIJKVWzF/NPSOZ8SZcSjCl83bnjLd8nk=;
 b=HBadf9aX/rfxBH6hv1Y6qXAavitDDt0VFNAY2QWxA00aDuFlRPCgYKrxQBTxY6Iso/
 J6kqb8ZPoUePnDdtjQSvX5ew23kPhYylE7lb+6KuZ+l9sS9FaaqgHa7NzpokOv2//YLR
 wVg3RCZtE9Wl9RB/JNSpJJEwTkEt+xSRTScHPYIAyhDtHJEA7QvTVxuN3kWh0u7vJqEK
 /Fc1izEP94jzgJg9JNucOe7E0pwBSRZMpn8sJl9wBnENpyFiG13ear3+kBhJupAD0TZD
 VLx4cTW9SkLRecKc0eGQLl9qMVqhTWjKt+t3RjJWkTLLWOcUOmdfEC2jkE7CjFHZZfdw
 1WfQ==
X-Gm-Message-State: AJIora8kjcU1mixbi3qYJ66j9L45+bsLkBL9SDx3UvHbXZRd5rt57jF5
 tFe9DDOMXL7fVDWssEJwIUFTNg4IXTrH092q+5fZ1ZitnkyI2Rdr6SPG33crz38LN8qWr9Wnfqb
 i9qHD1kZH4F73Pz0rup+vkGYEZw==
X-Received: by 2002:a05:600c:1991:b0:39c:88ba:2869 with SMTP id
 t17-20020a05600c199100b0039c88ba2869mr19766109wmq.14.1656412968365; 
 Tue, 28 Jun 2022 03:42:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t89v3kQLLnvmZ+A4VBSjVx4SCynlA5GjVj55ld5GAWdEkQJAn2Ag3b6wuqeEuz7QSmx4Iu0w==
X-Received: by 2002:a05:600c:1991:b0:39c:88ba:2869 with SMTP id
 t17-20020a05600c199100b0039c88ba2869mr19766075wmq.14.1656412968043; 
 Tue, 28 Jun 2022 03:42:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:a00:46df:e778:456a:8d6b?
 (p200300cbc7090a0046dfe778456a8d6b.dip0.t-ipconnect.de.
 [2003:cb:c709:a00:46df:e778:456a:8d6b])
 by smtp.gmail.com with ESMTPSA id
 p2-20020a056000018200b002103cfd2fbasm13329363wrx.65.2022.06.28.03.42.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jun 2022 03:42:47 -0700 (PDT)
Message-ID: <79a7969c-311f-d36b-4d44-dfe2f02c9b99@redhat.com>
Date: Tue, 28 Jun 2022 12:42:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v6 02/14] mm: handling Non-LRU pages returned by
 vm_normal_pages
To: Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
References: <20220628001454.3503-1-alex.sierra@amd.com>
 <20220628001454.3503-3-alex.sierra@amd.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220628001454.3503-3-alex.sierra@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 28 Jun 2022 13:03:28 +0000
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

On 28.06.22 02:14, Alex Sierra wrote:
> With DEVICE_COHERENT, we'll soon have vm_normal_pages() return
> device-managed anonymous pages that are not LRU pages. Although they
> behave like normal pages for purposes of mapping in CPU page, and for
> COW. They do not support LRU lists, NUMA migration or THP.
> 
> We also introduced a FOLL_LRU flag that adds the same behaviour to
> follow_page and related APIs, to allow callers to specify that they
> expect to put pages on an LRU list.
> 
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> ---

I think my review feedback regarding FOLL_LRU has been ignored.


-- 
Thanks,

David / dhildenb

