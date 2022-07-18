Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B8AC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 18:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F0B910E385;
	Mon, 18 Jul 2022 18:47:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D76DB10E1D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 18:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658170004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gvtwFmzJQydskGdmMkAzcYmgFVg8zBkka0UIgO8GwDg=;
 b=ZCNGSle3CPSzGwkbDKINbg5guK+VwV8lIfDtwpU0uuChuGnhI09YTVHoYCUEE3stqLZRfB
 M770DFQDLee2OkbyHrlboHPmJG4fPm04ZGYPZtHD3JLalsy1zva6dkxzCZg2NIi9YiV5dB
 dj3qyPK3f2AR1YvIAykybDWfQ2hiKNs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-eDnyIFF1OPySC1eFYDNc-w-1; Mon, 18 Jul 2022 14:46:40 -0400
X-MC-Unique: eDnyIFF1OPySC1eFYDNc-w-1
Received: by mail-wm1-f70.google.com with SMTP id
 k16-20020a7bc310000000b0038e6cf00439so4572766wmj.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 11:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=gvtwFmzJQydskGdmMkAzcYmgFVg8zBkka0UIgO8GwDg=;
 b=BfMw8zjmlYC49ClFHpMDPXRD5fHh+OoZHfOxDK2l5ott9f/qUKhgZDnBIV1/ib9s+w
 PA79AJbrTP8dZX0DCTyb3gg5svfjfl6b1efOkyWi9upW8HAmvKE1t1WOKkHG+z1y80dZ
 tn9vqFJNBBAD8+ijIL5MfIqURxszVxkji5IECjDoNmVa+vnwNjiZNGvzImE1g7OREua7
 /DOv7G+1p4Np9U0SvyyznL9taJBPD7Nw5zUSLoj+k4ufkbswDf0BeQQAoESOsMIlmgho
 GukfBe8moB6q2vteU4M8SB+wkiURwy5EK8LXAUM/VqEIIjky9VJUMWWzhzZZHWtRDfHC
 Ou+g==
X-Gm-Message-State: AJIora9WZOnO/LLPcm9b6ogsvlTMq5d5zlNLp5dkfIOBYsY//qw2G2WV
 itGmyecAqiB8yIvf9yVz6V1IwQr1viHSzx+0uNkAoPaJkC4rg1sl37TScVjJwUO+KjggTKhB7Jf
 xr5w5pd6jWHLPzT37bCrYDvXxEw==
X-Received: by 2002:adf:e949:0:b0:21d:89d4:91b3 with SMTP id
 m9-20020adfe949000000b0021d89d491b3mr23742733wrn.162.1658169999195; 
 Mon, 18 Jul 2022 11:46:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vOmE4vOGnFiuTP5c2pPtTPJoK81mepVV/JGhoKaECLpmofr++mZLUmicLoz+0bKYGOcrodww==
X-Received: by 2002:adf:e949:0:b0:21d:89d4:91b3 with SMTP id
 m9-20020adfe949000000b0021d89d491b3mr23742711wrn.162.1658169998936; 
 Mon, 18 Jul 2022 11:46:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7400:6b3a:a74a:bd53:a018?
 (p200300cbc70574006b3aa74abd53a018.dip0.t-ipconnect.de.
 [2003:cb:c705:7400:6b3a:a74a:bd53:a018])
 by smtp.gmail.com with ESMTPSA id
 m15-20020a7bce0f000000b003a31169a7f4sm10007971wmc.12.2022.07.18.11.46.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Jul 2022 11:46:38 -0700 (PDT)
Message-ID: <0483651e-d3ae-d5b4-722b-26dc088da2be@redhat.com>
Date: Mon, 18 Jul 2022 20:46:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9 02/14] mm: move page zone helpers from mm.h to mmzone.h
To: Felix Kuehling <felix.kuehling@amd.com>, Alex Sierra
 <alex.sierra@amd.com>, jgg@nvidia.com
References: <20220715150521.18165-1-alex.sierra@amd.com>
 <20220715150521.18165-3-alex.sierra@amd.com>
 <12b40848-2e38-df0b-8300-0d338315e9b2@redhat.com>
 <f6834736-3b68-d6e0-ddb2-9d51b8e720b6@amd.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <f6834736-3b68-d6e0-ddb2-9d51b8e720b6@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 18 Jul 2022 18:47:14 +0000
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
Cc: rcampbell@nvidia.com, willy@infradead.org, apopple@nvidia.com,
 dri-devel@lists.freedesktop.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 jglisse@redhat.com, amd-gfx@lists.freedesktop.org, akpm@linux-foundation.org,
 linux-ext4@vger.kernel.org, hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 18.07.22 19:52, Felix Kuehling wrote:
> On 2022-07-18 06:50, David Hildenbrand wrote:
>> On 15.07.22 17:05, Alex Sierra wrote:
>>> [WHY]
>>> It makes more sense to have these helpers in zone specific header
>>> file, rather than the generic mm.h
>>>
>>> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> Thank you! I don't think I have the authority to give this a 
> Reviewed-by. Who does?


Sure you can. Everybody can give Reviewed-by/Tested-by ... tags. :)


-- 
Thanks,

David / dhildenb

