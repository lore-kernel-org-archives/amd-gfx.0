Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C392EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 13:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DF0410EF21;
	Mon, 11 Apr 2022 13:32:08 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C9AC10EE54;
 Mon, 11 Apr 2022 13:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649683926; x=1681219926;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5E7jxPhpMDzKeO+76OwbEXDMhNGno4DLluxKQbugKtI=;
 b=e5EgsMdiqsBoEGCOBWwb/AkZkFl8uVjSd0OHAkhoNU+EUN89Cy5LsYZM
 9R+wT9p4oDlayYZyMUVcvEqV9pJ22mFG7VJq7w1VZoNeZ7P3OYvutADXw
 4N2drCZL9e8oKqkx/Jsbe/tkn+a4pvJzCnF/sk+vE2OIsM23TlZ6Gk1nU
 2D7JabzsRHmTty8tCMrdqIe23WNCT7At34LfHBuj7Q5pU5sTfUxa+jnKQ
 m+dD6j4ayNcbxobq158y7bXinKrkjqjMnEba+lGNrAu1g4j6MadyyG+VQ
 yCTcQ8JN8lBol2P4P/2NAvinrqEDpi5wa9OXjpn6USHRmyotbhuclHOsd w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="242052718"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; d="scan'208";a="242052718"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2022 06:32:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; d="scan'208";a="644085475"
Received: from dxharrix-mobl.ger.corp.intel.com (HELO [10.252.1.119])
 ([10.252.1.119])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2022 06:32:04 -0700
Message-ID: <5f2a190a-f8ef-9b5f-d6b2-efa30f367612@intel.com>
Date: Mon, 11 Apr 2022 14:32:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] drm: add a check to verify the size alignment
Content-Language: en-GB
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20220411073834.15210-1-Arunpravin.PaneerSelvam@amd.com>
 <9ecac65c-84d9-9965-4fd3-f86ea572bb9d@intel.com>
 <ca280f24-8efe-e972-4a03-700e002cc6f7@gmail.com>
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <ca280f24-8efe-e972-4a03-700e002cc6f7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, daniel@ffwll.ch
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11/04/2022 13:42, Christian König wrote:
> 
> Am 11.04.22 um 11:47 schrieb Matthew Auld:
>> On 11/04/2022 08:38, Arunpravin Paneer Selvam wrote:
>>> Add a simple check to reject any size not aligned to the
>>> min_page_size.
>>>
>>> when size is not aligned to min_page_size, driver module
>>> should handle in their own way either to round_up() the
>>> size value to min_page_size or just to enable WARN_ON().
>>>
>>> If we dont handle the alignment properly, we may hit the
>>> following bug, Unigine Heaven has allocation requests for
>>> example required pages are 257 and alignment request is 256.
>>> To allocate the left over 1 page, continues the iteration to
>>> find the order value which is 0 and when it compares with
>>> min_order = 8, triggers the BUG_ON(order < min_order).
>>>
>>> v2: add more commit description
>>> v3: remove WARN_ON()
>>>
>>> Signed-off-by: Arunpravin Paneer Selvam 
>>> <Arunpravin.PaneerSelvam@amd.com>
>>> Suggested-by: Matthew Auld <matthew.auld@intel.com>
>> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>>
> 
> Question here is who will be pushing that to drm-misc-next? Should I 
> take care of that?

Yes, please do.

> 
> I think it's time that Arun should request push permission for 
> drm-misc-next.
> 
> Thanks,
> Christian.
