Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB43DC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 16:03:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C5116199E
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 16:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5116199E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CEBA89CA8;
	Mon, 22 Mar 2021 16:03:19 +0000 (UTC)
X-Greylist: delayed 1462 seconds by postgrey-1.36 at gabe;
 Mon, 22 Mar 2021 14:31:35 UTC
Received: from gateway20.websitewelcome.com (gateway20.websitewelcome.com
 [192.185.67.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 747EB6E4C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 14:31:35 +0000 (UTC)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
 by gateway20.websitewelcome.com (Postfix) with ESMTP id 85EB7400C6E25
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 08:57:40 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id OLD6lHe3Fw11MOLD6lCsBO; Mon, 22 Mar 2021 09:07:12 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cUnSQxPQKJaaBLNa5F4iOd/DRePu6SyoFMhjlo3t0aY=; b=Wdg5z/ykxmBWAAPH5LBsYOWdvx
 RIrc2FuXw3dVtbZlZN4A9qkmNkhbCgiA3ILklNr2NXdL618tZNWK3jvKs5bPZ/bCV+h/LjlhrhJK/
 efaOOvs0P+tafocRNUnC+jmsVDWwgcxgBs2uyLdXgpD6cGDyfS4iwRmhrUEAlBSl2kjYFxLZ97q4z
 0gh8LGx06x8/z2pauN3A1nanrpZn7ts5/9ne0gPn4ybMmO17yhjv+gaxuve6N/vXmFg9XVrYOalQh
 68yIuFtFXnoUQ1kZfjINe+OppzJK0KRNbxSqSyKx3fKBAika7OfMHlrWK/9Q9a2320ebT7BpsRfM9
 BH7llxjg==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:55746
 helo=[192.168.15.8])
 by gator4166.hostgator.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <gustavo@embeddedor.com>)
 id 1lOLD5-000Q4E-Mq; Mon, 22 Mar 2021 09:07:11 -0500
Subject: Re: [PATCH][next] drm/amd/display: Fix sizeof arguments in
 bw_calcs_init()
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Lee Jones <lee.jones@linaro.org>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
References: <20210322125050.GA236782@embeddedor>
 <CY4PR12MB128770E0A2502A3CA0A26650F1659@CY4PR12MB1287.namprd12.prod.outlook.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <408ff15d-81ba-0a0b-113d-96d5cb49a2a6@embeddedor.com>
Date: Mon, 22 Mar 2021 08:07:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CY4PR12MB128770E0A2502A3CA0A26650F1659@CY4PR12MB1287.namprd12.prod.outlook.com>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lOLD5-000Q4E-Mq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8])
 [187.162.31.110]:55746
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-Mailman-Approved-At: Mon, 22 Mar 2021 16:03:17 +0000
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/22/21 09:04, Chen, Guchun wrote:
> [AMD Public Use]
> 
> Thanks for your patch, Silva. The issue has been fixed by " a5c6007e20e1 drm/amd/display: fix modprobe failure on vega series".

Great. :)
Good to know this is already fixed.

Thanks!
--
Gustavo
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
