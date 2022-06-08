Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96994C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 15:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11F6E112327;
	Wed,  8 Jun 2022 15:02:14 +0000 (UTC)
X-Greylist: delayed 447 seconds by postgrey-1.36 at gabe;
 Wed, 08 Jun 2022 10:10:02 UTC
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 235ED10E5CA
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 10:10:02 +0000 (UTC)
Received: from [192.168.1.12] (unknown [222.129.35.96])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1EF673FC24; 
 Wed,  8 Jun 2022 10:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1654682554;
 bh=Rx3+/dXAKeASFgukWDsRTBoFAUiRAIRKOKojh2To7oY=;
 h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
 In-Reply-To:Content-Type;
 b=hyeWBYTLJYWf5OPNGvhIVKZfgvt1vjTpIFm8aaiR0rzzBNWQ5mzMwTdCQFqylNz25
 xxi/DCy2T/jyN13eHt0X9WOyjfY4KwhUCtdKNiSrDnrWuTwohqFgynTBsIclqjnGAA
 l4iX0pMfEApfXZ3LJuL8AUCXGz0/03hTG9j0P/cP4rFHvWI7asiA61hXIL8afiiWqs
 Mcy1JB6Tc5VjnpRL/A48u6w99zOvf0CrvpsWkE28pgRyq5Ou4+V3VidkvT1kGLyHTU
 BbdbXmBcIW83mZfVGu3ky2cRQSSW6eUzYJ6BqZnBdOJ0K/7XHqfxmBGGccqyqX2+Ak
 7as4WRtHy4bGQ==
Message-ID: <848cd255-835d-20ee-27fc-744d43fc98c1@canonical.com>
Date: Wed, 8 Jun 2022 18:02:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
To: hamza.mahfooz@amd.com, roman.li@amd.com
References: <20220603201147.121817-8-hamza.mahfooz@amd.com>
Subject: Re: [PATCH 07/16] drm/amd/display: Cap OLED brightness per max
 frame-average luminance
Content-Language: en-US
From: Aaron Ma <aaron.ma@canonical.com>
In-Reply-To: <20220603201147.121817-8-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 08 Jun 2022 15:02:13 +0000
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, amd-gfx@lists.freedesktop.org,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Roman:

Can the panel achieve the max peak luminance
if it is limited in frame-average luminance?

Regards,
Aaron
