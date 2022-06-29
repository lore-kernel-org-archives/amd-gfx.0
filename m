Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF17C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 18:49:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 077CD10E32E;
	Wed, 29 Jun 2022 18:49:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AD6210EA7F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 18:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656528514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ZM4Ql5QJUmiVq6/iTZYAWyD16J7WFBV3CLn4iAwAjY=;
 b=OwgjInHMQC1bTiZERahSKpO+NnWi2eIX8v1cWn/TOd+nIxC69p9Ytwq8MqiHILon0bfjYz
 IgBEQUpo1VEaIX92tXXsa2xZBRouFNvMGWaeMe7jWkEx+4fRPd5PI+TdBoVh+TI1TtBbs4
 eoad9LZlh9nJEY/gDF/3jTaiKcW4SI0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-jZBKM_gJNYitd9wpUHB7FQ-1; Wed, 29 Jun 2022 14:48:33 -0400
X-MC-Unique: jZBKM_gJNYitd9wpUHB7FQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 j35-20020a05600c1c2300b003a167dfa0ecso136848wms.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 11:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=4ZM4Ql5QJUmiVq6/iTZYAWyD16J7WFBV3CLn4iAwAjY=;
 b=RN80RLupvwg2hDJ9IkBd/gJBhnAdV5hojU9G3Odpj5QCNTQ6q+dPNEZsL7CbChz7ro
 qlar4aZwNiZAa4ZxLcXNb0GvL27+AwLMo1gtQynNI/IHB1u3tVS+0OEZaydk/WWgiWUQ
 VL/EN1ysn3PmcxgE9WTT6Lb+uCifpmKd70WyIbS5PRFLx9WXApJpsgsT5kguNHoC74QW
 2CJRSH4D650kH7SS0GLMQ25KiQfrYD8jUC2sl8SHETSULFXuDACSVr/vFJhrmLFNvvHX
 g9VFH8D30RwAKdmE2zJEKn1H6Ww/aB27sOllMl10UvY7jh4bu+cJMIBuc4nj1hEBe6UA
 rFLg==
X-Gm-Message-State: AJIora8uljI7PPQ4fo4+IJPa5PL1uGsicBlAf+9Imn7D1bhg7PMXLS+F
 VTCqTuZXQP02ugj83KcjgQpYy2r2VNxbvSIAP0S3iEfIiOb+IOVIQV96pZh2ULIrXHBArYITpPW
 guC3abX1IG6VpMaJsaXLGVIBJrw==
X-Received: by 2002:a5d:688e:0:b0:21b:9d51:25d2 with SMTP id
 h14-20020a5d688e000000b0021b9d5125d2mr4756603wru.286.1656528511922; 
 Wed, 29 Jun 2022 11:48:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tvKQZkINfbcfHGdv/ByN4E2v7ddXq6JGPQGqaW4FGF/wVw1dJjo/vdI/EF/pOq03d27lnmag==
X-Received: by 2002:a5d:688e:0:b0:21b:9d51:25d2 with SMTP id
 h14-20020a5d688e000000b0021b9d5125d2mr4756580wru.286.1656528511695; 
 Wed, 29 Jun 2022 11:48:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:e600:d4fa:af4b:d7b6:20df?
 (p200300cbc708e600d4faaf4bd7b620df.dip0.t-ipconnect.de.
 [2003:cb:c708:e600:d4fa:af4b:d7b6:20df])
 by smtp.gmail.com with ESMTPSA id
 n35-20020a05600c3ba300b003a039054567sm3206358wms.18.2022.06.29.11.48.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jun 2022 11:48:31 -0700 (PDT)
Message-ID: <2e3e1050-7fa4-106b-9c80-6321afc5ac42@redhat.com>
Date: Wed, 29 Jun 2022 20:48:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 02/14] mm: add zone device coherent type memory support
To: Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
References: <20220629035426.20013-1-alex.sierra@amd.com>
 <20220629035426.20013-3-alex.sierra@amd.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220629035426.20013-3-alex.sierra@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 29 Jun 2022 18:49:36 +0000
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

From what I can tell, this looks good to me

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

