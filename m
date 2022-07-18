Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF239C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 12:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B061011BCF8;
	Mon, 18 Jul 2022 12:56:34 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80016AFF0B
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 10:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658141437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GELRdaJJQzNGu42HwXNvH14oS2HiNBL5HZCcGuN9ch4=;
 b=HjG6XownoJIGB9yL6tcxVNkAa/mj2slwD0GF7RDg/AuUCHbonqGSa2lOjrE+zjMWPtGF6Q
 Qa29JmKrw2P5FI7C/1MpwoMDYvkhLON6GVhNDSmAV5LnuB5L62GdiN5RQjwcmGNDU5uXH8
 OSJAY1w7tQ2bbxrNdeVKxL0TI7sInQM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-Gecz8EXaOu6i57eVve76kg-1; Mon, 18 Jul 2022 06:50:36 -0400
X-MC-Unique: Gecz8EXaOu6i57eVve76kg-1
Received: by mail-wm1-f71.google.com with SMTP id
 r10-20020a05600c284a00b003a2ff6c9d6aso7332824wmb.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 03:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=GELRdaJJQzNGu42HwXNvH14oS2HiNBL5HZCcGuN9ch4=;
 b=A91plrbkW/SNdcRo4934iYq3olob5kAmxn3OWQgrZUDX8iKIzi83qyX3cm1JSImLOT
 3Pf2PFl09CDX5M5Uf0mqOiC3TURFIN48gTbbYl458QBlBiU3rGBUIWx4BEWNReVWnbDF
 P+uF9v3azYhNIYx1VEdWOzO53AwsDfb72dlxVgbmdZxK4gRcOHuZh9/SOhVlOj+9mRuY
 eQESsx8Bi7ghxVjoNM8A9LHr9E8fVl7t8tzni2YSuULauoygMvhRIUSqLfNCgC/ym8GZ
 leS9EZe7BOVtvFtqAx9eHsjLyihSHg2Xq+kYhL7ew7CGAnXOKoVU0v621lw89Al4ERw8
 e8AA==
X-Gm-Message-State: AJIora+Vt9v38vHP5XY/motbka04ALAha02Ikn4YYoVsdXtg7zgR7p9j
 CCua6n13oYcGg0P7NlbQitBHQ66Q/Xmk9N1/yql/bl49hGpXWMvBhUuG6PcTdg48bqrWSSBsZFg
 VMJgf6oho6ZlKGezFhBuLEj81RQ==
X-Received: by 2002:a05:600c:4f43:b0:3a2:ee79:2dd5 with SMTP id
 m3-20020a05600c4f4300b003a2ee792dd5mr25587646wmq.143.1658141435078; 
 Mon, 18 Jul 2022 03:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t3TjHUzmOv6ybcclnybN9UPY7Bi+An5DlmuQSPxVe4SOYbaL5tYKsRuXtw0aDU3ti4mHhI6A==
X-Received: by 2002:a05:600c:4f43:b0:3a2:ee79:2dd5 with SMTP id
 m3-20020a05600c4f4300b003a2ee792dd5mr25587621wmq.143.1658141434838; 
 Mon, 18 Jul 2022 03:50:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7400:6b3a:a74a:bd53:a018?
 (p200300cbc70574006b3aa74abd53a018.dip0.t-ipconnect.de.
 [2003:cb:c705:7400:6b3a:a74a:bd53:a018])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a5d6445000000b0021bae66362esm10526543wrw.58.2022.07.18.03.50.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Jul 2022 03:50:34 -0700 (PDT)
Message-ID: <12b40848-2e38-df0b-8300-0d338315e9b2@redhat.com>
Date: Mon, 18 Jul 2022 12:50:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9 02/14] mm: move page zone helpers from mm.h to mmzone.h
To: Alex Sierra <alex.sierra@amd.com>, jgg@nvidia.com
References: <20220715150521.18165-1-alex.sierra@amd.com>
 <20220715150521.18165-3-alex.sierra@amd.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220715150521.18165-3-alex.sierra@amd.com>
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
> [WHY]
> It makes more sense to have these helpers in zone specific header
> file, rather than the generic mm.h
> 
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

