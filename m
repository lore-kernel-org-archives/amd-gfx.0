Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C811EB64D9
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 07:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F17110E403;
	Wed, 14 Jun 2023 07:21:00 +0000 (UTC)
X-Greylist: delayed 409 seconds by postgrey-1.36 at gabe;
 Wed, 14 Jun 2023 05:36:48 UTC
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 120DF10E0DC;
 Wed, 14 Jun 2023 05:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
 s=default; t=1686720598;
 bh=YMi7ui8mUgZ7xFFkJ5jRHmFFR0KM3n2BdmtqWjBfWoo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Xm3mi4uk+1eGjNtyboS8Ys6bgrLGRlC4yCrd64p73sBzfviEPL79mlXvS+ty1EIZx
 c3NIg3m+762aqr0b0naNw31oAYo+3RNevZfM7fhbw3i9tP92eHySeW105s5t5tmU9O
 fbBaZ439bPjEjOP+ya4F1+TuuDvWqaZXNyh7pJWSTzCzSGUmMRwGgkaBxckMEvGUU4
 V7zKLi8g3qFoV5Gki7QVAmzu8NbH3Ma3NqgWTr5tBs6Qm78U6IF6Y9Y9jstSJuPRXX
 GgOGDN4PqTDANYMBY46TF6pb7Zg/jK2nPK82ZgQXAnKFgyZSQ+pBjaDi9O7HiBPmx1
 QxvYxdXEOphcw==
Received: from [10.20.0.2] (unknown [182.253.126.223])
 by gnuweeb.org (Postfix) with ESMTPSA id ACF79249C00;
 Wed, 14 Jun 2023 12:29:52 +0700 (WIB)
Message-ID: <5844e20e-843d-f65e-107a-8fd4cff48e32@gnuweeb.org>
Date: Wed, 14 Jun 2023 12:29:48 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] amd/display/dc:remove repeating expression
To: Wang Ming <machel@vivo.com>
References: <20230614034936.876-1-machel@vivo.com>
Content-Language: en-US
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <20230614034936.876-1-machel@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 14 Jun 2023 07:20:54 +0000
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, opensource.kernel@vivo.com,
 Leo Li <sunpeng.li@amd.com>, David Airlie <airlied@gmail.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 6/14/23 10:49 AM, Wang Ming wrote:
> Identify issues that arise by using the tests/doubletest.cocci
> semantic patch.Need to remove duplicate expression in if statement.
> 
> Signed-off-by: Wang Ming <machel@vivo.com>

Reviewed-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>

-- 
Ammar Faizi
