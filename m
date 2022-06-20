Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8512C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jun 2022 17:50:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E05710ED81;
	Mon, 20 Jun 2022 17:50:49 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23E2110E13C;
 Mon, 20 Jun 2022 14:09:02 +0000 (UTC)
Received: from [192.168.2.145] (109-252-136-92.dynamic.spd-mgts.ru
 [109.252.136.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id ED33766016AA;
 Mon, 20 Jun 2022 15:08:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1655734140;
 bh=BXU+ifI6vgvX2l7WRjph+CNUKyZnpbVEdIZ7RrhtSq4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hbKEas/qwTrQOtYjHwF1kAp5bF+lx0c/HWQwXzlCDzigXVc6ThGjLuF3ZUDyYkTwz
 MouYrGpQnILP4PpIymmbBhVM9e1PASUWBFi+LgRwQKHtJaeCJSG55KGkiaLdAooRwx
 r2TI5GDTa0dTQ+8tpeAHv2LUf+jVTzvilnkf5MIXXOtgLhZavAyBeA5Coc+G+31H0n
 LqN5s7FdaPeYgtK9DeQIbTvs9nVBH3Vd5hMCs7Z3/RWoHnCkbvzEtAtefHevXEAM22
 OU+8g1IHrfEqrNowXyflyg+A+jrXLHwPj7JmxC/fo9Iq5iwKq0KsVJdcRE82IB0+gX
 J8VaycDtZEnTQ==
Message-ID: <3bb3dc53-69fc-8cdb-ae37-583b9b2660a3@collabora.com>
Date: Mon, 20 Jun 2022 17:08:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v6 17/22] drm/shmem-helper: Add generic memory shrinker
Content-Language: en-US
To: Rob Clark <robdclark@gmail.com>
References: <20220526235040.678984-1-dmitry.osipenko@collabora.com>
 <20220526235040.678984-18-dmitry.osipenko@collabora.com>
 <CAF6AEGt61t2truYDCxm17hqUPV-UdEdHjLs+6vmj5RPoPuVBYg@mail.gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAF6AEGt61t2truYDCxm17hqUPV-UdEdHjLs+6vmj5RPoPuVBYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 20 Jun 2022 17:50:48 +0000
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
Cc: David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 Thierry Reding <thierry.reding@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring <robh@kernel.org>,
 Daniel Stone <daniel@fooishbar.org>, Steven Price <steven.price@arm.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 virtualization@lists.linux-foundation.org, Chia-I Wu <olvaffe@gmail.com>,
 linux-media@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 intel-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, linaro-mm-sig@lists.linaro.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-tegra@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, amd-gfx@lists.freedesktop.org,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Emil Velikov <emil.l.velikov@gmail.com>, linux-kernel@vger.kernel.org,
 Tomasz Figa <tfiga@chromium.org>, Qiang Yu <yuq825@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>, Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 6/19/22 20:53, Rob Clark wrote:
...
>> +static unsigned long
>> +drm_gem_shmem_shrinker_count_objects(struct shrinker *shrinker,
>> +                                    struct shrink_control *sc)
>> +{
>> +       struct drm_gem_shmem_shrinker *gem_shrinker = to_drm_shrinker(shrinker);
>> +       struct drm_gem_shmem_object *shmem;
>> +       unsigned long count = 0;
>> +
>> +       if (!mutex_trylock(&gem_shrinker->lock))
>> +               return 0;
>> +
>> +       list_for_each_entry(shmem, &gem_shrinker->lru_evictable, madv_list) {
>> +               count += shmem->base.size;
>> +
>> +               if (count >= SHRINK_EMPTY)
>> +                       break;
>> +       }
>> +
>> +       mutex_unlock(&gem_shrinker->lock);
> 
> As I mentioned on other thread, count_objects, being approximate but
> lockless and fast is the important thing.  Otherwise when you start
> hitting the shrinker on many threads, you end up serializing them all,
> even if you have no pages to return to the system at that point.

Daniel's point for dropping the lockless variant was that we're already
in trouble if we're hitting shrinker too often and extra optimizations
won't bring much benefits to us.

Alright, I'll add back the lockless variant (or will use yours
drm_gem_lru) in the next revision. The code difference is very small
after all.

...
>> +               /* prevent racing with the dma-buf importing/exporting */
>> +               if (!mutex_trylock(&gem_shrinker->dev->object_name_lock)) {
>> +                       *lock_contention |= true;
>> +                       goto resv_unlock;
>> +               }
> 
> I'm not sure this is a good idea to serialize on object_name_lock.
> Purgeable buffers should never be shared (imported or exported).  So
> at best you are avoiding evicting and immediately swapping back in, in
> a rare case, at the cost of serializing multiple threads trying to
> reclaim pages in parallel.

The object_name_lock shouldn't cause contention in practice. But objects
are also pinned on attachment, hence maybe this lock is indeed
unnecessary.. I'll re-check it.

-- 
Best regards,
Dmitry
