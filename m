Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D821C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Jun 2022 13:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F82010E177;
	Sat, 18 Jun 2022 13:54:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6959111A6C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 07:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655451899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=coda/CWfS7jjnpuHvtDQX0ASaEE3SWk0zKx/CPt1NF8=;
 b=HLU+a6r1MRguaOicGfzuEDvPweZiccIFg/GjZ+oEJmzu+q/wKo4D7jXU8GMum46GudquWQ
 3d9/ej3ApjCS5E6DLmKoKyGLHKmxPxZPiU1C9JudRMG5BU1RARcgAxBn8EEq4TgWW/hRI0
 7lB9ClROUb0ZEbXysX3QpKWBDwldfyA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-doV00jtLN86pI0PJcsTngg-1; Fri, 17 Jun 2022 03:44:50 -0400
X-MC-Unique: doV00jtLN86pI0PJcsTngg-1
Received: by mail-wm1-f69.google.com with SMTP id
 p22-20020a05600c359600b0039c7b23a1c7so2366601wmq.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 00:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=coda/CWfS7jjnpuHvtDQX0ASaEE3SWk0zKx/CPt1NF8=;
 b=IF+MAl1llymbXc++wnG16ikKH3r6oLFmJTfQ3uT4IWjyzk3NXZrxG073GqifxNMT3j
 QiUimX/hYQ7QGLPrZrm7nGV3m9B2GESG03/oLMvD4NDJvmkMWdzkExdXIfnKLVayznGB
 rwLo9GIoacAYnDtlwdG0j86/NPe8F7IYte9scOU4/0FoUec1fgGV5mP+5kSfHMtxcLem
 nJFGzntDpBX/9eoInPUYRR+WKnO+Ojg013ng1CN4FafCG+iijlg6B8jTZYMI5EfB2APj
 vWJxrQt2vaKGhiVVRY0cY/dExhMaKrrV725K48RCkYoOrP/tNPKaHCaeweXWuTih9FTW
 B79A==
X-Gm-Message-State: AJIora8IHiVtY91CGKTG9q9ucFIjocoJ/KOvA/IktYyDOkPUSqqs75J/
 TqnJGVh3w6cpKN/T5d3HDmmFlsxiVe5tOvgcFFDhE/t4zXnVKLWvo+RAf38cdN5f+SC5PGi7keB
 saLYm7uuIkIwkukhmlT96lF69kA==
X-Received: by 2002:a5d:5272:0:b0:210:33b8:ac4a with SMTP id
 l18-20020a5d5272000000b0021033b8ac4amr7953182wrc.483.1655451889291; 
 Fri, 17 Jun 2022 00:44:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sotrEWyKnX0mzmXO2tbcDqW4so5zlYrKlmkTzzX5Yo7fZTIXTe3SZOKyKoq4h2kvU8N2TdcQ==
X-Received: by 2002:a5d:5272:0:b0:210:33b8:ac4a with SMTP id
 l18-20020a5d5272000000b0021033b8ac4amr7953151wrc.483.1655451889025; 
 Fri, 17 Jun 2022 00:44:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:7e00:bb5b:b526:5b76:5824?
 (p200300cbc70a7e00bb5bb5265b765824.dip0.t-ipconnect.de.
 [2003:cb:c70a:7e00:bb5b:b526:5b76:5824])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a5d474b000000b002185631adf0sm3851245wrs.23.2022.06.17.00.44.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jun 2022 00:44:48 -0700 (PDT)
Message-ID: <bd8b3eeb-4951-e3e9-8ee5-94f573ec815f@redhat.com>
Date: Fri, 17 Jun 2022 09:44:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 00/13] Add MEMORY_DEVICE_COHERENT for coherent device
 memory mapping
To: Andrew Morton <akpm@linux-foundation.org>,
 Alex Sierra <alex.sierra@amd.com>
References: <20220531200041.24904-1-alex.sierra@amd.com>
 <20220616191927.b4500e2f73500b9241009788@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220616191927.b4500e2f73500b9241009788@linux-foundation.org>
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
 jgg@nvidia.com, linux-ext4@vger.kernel.org, hch@lst.de
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 17.06.22 04:19, Andrew Morton wrote:
> On Tue, 31 May 2022 15:00:28 -0500 Alex Sierra <alex.sierra@amd.com> wrote:
> 
>> This is our MEMORY_DEVICE_COHERENT patch series rebased and updated
>> for current 5.18.0
> 
> I plan to move this series into the non-rebasing mm-stable branch in a
> few days.  Unless sternly told not to do so!
> 

I want to double-check some things regarding PageAnonExclusive
interaction. I'm busy, but I'll try prioritizing it.

-- 
Thanks,

David / dhildenb

