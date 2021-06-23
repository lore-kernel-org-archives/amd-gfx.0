Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60378C4743C
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 11:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E17736102A
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 11:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17736102A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxedocomputers.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E9A889FC5;
	Wed, 23 Jun 2021 11:19:44 +0000 (UTC)
Received: from srv6.fidu.org (srv6.fidu.org [IPv6:2a01:4f8:231:de0::2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA4D989FC5;
 Wed, 23 Jun 2021 11:19:43 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by srv6.fidu.org (Postfix) with ESMTP id B2A3DC800A7;
 Wed, 23 Jun 2021 13:19:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
 by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id VnxvvrRkcqOg; Wed, 23 Jun 2021 13:19:41 +0200 (CEST)
Received: from [IPv6:2003:e3:7f39:4900:3156:839d:aed8:6ea6]
 (p200300e37f3949003156839daED86Ea6.dip0.t-ipconnect.de
 [IPv6:2003:e3:7f39:4900:3156:839d:aed8:6ea6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: wse@tuxedocomputers.com)
 by srv6.fidu.org (Postfix) with ESMTPSA id 3B189C8009D;
 Wed, 23 Jun 2021 13:19:41 +0200 (CEST)
Subject: Re: [PATCH v4 09/17] drm/uAPI: Add "active color range" drm property
 as feedback for userspace
To: Pekka Paalanen <ppaalanen@gmail.com>
References: <20210618091116.14428-1-wse@tuxedocomputers.com>
 <20210618091116.14428-10-wse@tuxedocomputers.com>
 <20210622100042.4041624a@eldfell>
 <56d079d4-841a-0ca5-b8a6-d2c10f91d211@tuxedocomputers.com>
 <k_QeCRpur3SNNIspBiTHOTT6Oj1pSteEO3MzyQFUG0lSXmEqJUI2tMXJ6wR9chzUHGahdQApJZrUxdJvIv6s8aXr2DBdoHg-2PsGH4kEMyA=@emersion.fr>
 <20210623103256.01d680ba@eldfell>
 <5947f768-dd87-6b39-ecfc-b7c4aaa88aca@tuxedocomputers.com>
 <20210623141423.3f6c3e9f@eldfell>
From: Werner Sembach <wse@tuxedocomputers.com>
Message-ID: <fe83dcd2-889d-f9de-fc4e-b25b1887cb80@tuxedocomputers.com>
Date: Wed, 23 Jun 2021 13:19:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623141423.3f6c3e9f@eldfell>
Content-Language: en-US
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
Cc: sunpeng.li@amd.com, intel-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, airlied@linux.ie,
 dri-devel@lists.freedesktop.org, tzimmermann@suse.de, rodrigo.vivi@intel.com,
 alexander.deucher@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 23.06.21 um 13:14 schrieb Pekka Paalanen:
> On Wed, 23 Jun 2021 12:17:40 +0200
> Werner Sembach <wse@tuxedocomputers.com> wrote:
>
>> Am 23.06.21 um 09:32 schrieb Pekka Paalanen:
>>> On Tue, 22 Jun 2021 11:48:52 +0000
>>> Simon Ser <contact@emersion.fr> wrote:
>>>  
>>>> On Tuesday, June 22nd, 2021 at 11:50, Werner Sembach <wse@tuxedocomputers.com> wrote:
>>>>  
>>>>> Unknown is when no monitor is connected or is when the
>>>>> connector/monitor is disabled.    
>>>> I think the other connector props (link-status, non-desktop, etc) don't
>>>> have a special "unset" value, and instead the value is set to a random
>>>> enum entry. User-space should ignore the prop on these disconnected
>>>> connectors anyways.  
>>> That sounds fine to me.  
>> Currently the only case for "not applicable" is when the monitor is
>> disconnected, but sicne the properties are so interdependent, there
>> might be a case in the future where e.g. a color format that has no
>> differentiation between full and limited arises. When there is no
>> special unset/not applicable option, the userspace has to know
>> exactly when an option is valid or not, possible requiring additional
>> logic.
>>
>> Setting a "not applicable" value allows userspace to be more dumb,
>> without much hassle on the kernelspace side.
> That's a good point too. So "not applicable" would be a value, but
> "unknown" would not be.
Ok, I have already renamed the "unknown" option to "not applicable" in my next revision (not yet posted to the mailing
list).
>
>
> Thanks,
> pq
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
