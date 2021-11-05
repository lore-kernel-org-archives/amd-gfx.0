Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A85C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 02:31:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9236161108
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 02:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9236161108
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ntlworld.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8C306E02E;
	Fri,  5 Nov 2021 02:31:27 +0000 (UTC)
Received: from smtpq2.tb.ukmail.iss.as9143.net
 (smtpq2.tb.ukmail.iss.as9143.net [212.54.57.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D9BB6E02E
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 02:31:26 +0000 (UTC)
Received: from [212.54.57.111] (helo=csmtp7.tb.ukmail.iss.as9143.net)
 by smtpq2.tb.ukmail.iss.as9143.net with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.90_1)
 (envelope-from <zarniwhoop@ntlworld.com>) id 1mip0m-0005v6-AK
 for amd-gfx@lists.freedesktop.org; Fri, 05 Nov 2021 03:31:24 +0100
Received: from llamedos.mydomain ([81.97.236.130]) by cmsmtp with ESMTPA
 id ip0lmIhunufb4ip0mmfALS; Fri, 05 Nov 2021 03:31:24 +0100
X-Originating-IP: [81.97.236.130]
X-Authenticated-Sender: zarniwhoop@ntlworld.com
X-Spam: 0
X-Authority: v=2.4 cv=FOAIesks c=1 sm=1 tr=0 ts=6184977c cx=a_exe
 a=OGiDJHazYrvzwCbh7ZIPzQ==:117 a=OGiDJHazYrvzwCbh7ZIPzQ==:17
 a=IkcTkHD0fZMA:10 a=vIxV3rELxO4A:10 a=sgtdtSgOCt8kQawyEuYA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntlworld.com;
 s=meg.feb2017; t=1636079484;
 bh=XLTjD+wCvqIqhN99IwPuLeQQAmSqT3e+/JAOenf0fDI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nz77VPcCPmKTsDpMiYEntR0sZTnlgKpnaSEZae/MUQyiNYds7dg1iQz4O37PvHu7g
 At198aQputdEOmXw00F4pDeSVaI3KwdB0HEDr9erkJ6BzTG+3m462sydsiM41yoJvA
 SgPP3X861E3vlFhox1VOjZ8LH9JSO/lTk0RPkHuEDQE2DZ0rxU+5KHfrRpsT4vFitF
 0Oh8p2wqw3GEFHt/SnyIr/smTKdfHtgr9L9Xf8Lhv2PkMDa0vHsR7MGVfa+dEo6Ghf
 d0nppt6C1bhEwCsFKsx9Om7+wcAisqbYOndy3YEONmMhyxjzbEnSXzn8nAnouiot6n
 rWg367PVopK1A==
Received: by llamedos.mydomain (Postfix, from userid 1000)
 id 9C18B60C47; Fri,  5 Nov 2021 02:31:23 +0000 (GMT)
Date: Fri, 5 Nov 2021 02:31:23 +0000
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove duplicated kfd_resume_iommu
Message-ID: <YYSXeyMmgOc4FNSm@llamedos.localdomain>
References: <20211103013350.6015-1-James.Zhu@amd.com>
 <CADnq5_OurPZjmq2SbRZzw4MWRO2uFT7H=+F75czmwgG0MgGAiQ@mail.gmail.com>
 <BN6PR12MB1874ED9C570180113DB71F42E48C9@BN6PR12MB1874.namprd12.prod.outlook.com>
 <CADnq5_MScsyQWiiDsFLwObyrT1ViGL5dFP8K5+3U7TuNHo_cYQ@mail.gmail.com>
 <CADnq5_OrBYv80XHMBTTEwyJzEx1eEzBL2=VuzgmK=9Og5v5=1A@mail.gmail.com>
 <BN6PR12MB1874A9156EF80C63D96EBD06E48C9@BN6PR12MB1874.namprd12.prod.outlook.com>
 <CADnq5_NF82=PC-n-c=Bf2gqpECsXvNZBbq=OZs+faFDMMCp1Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_NF82=PC-n-c=Bf2gqpECsXvNZBbq=OZs+faFDMMCp1Ng@mail.gmail.com>
User-Agent: Mutt/2.1.3 (2021-09-10)
X-CMAE-Envelope: MS4xfOOCiDIDQeeGvzAdkqbYTaD5gKpYqRrGOr8HuatJn5qic8RTSC2//E8xC9TwbQyuO27a0y5FksxnLISl4EbfyEOWBuImiURsIdUKqZ9VbWuh8oqAlPj1
 QAoSZWxkeWsEQCrR6GTyfH2uaqfePao0ob9dV/kNvHIIVqVmjJx9JM5E+v0IKK6Jiywwmp3IViu7YtH17KbJkTY6WSeZntExjaELTqKfNm6TfFJh2cYHK+kZ
 IUALO5CnkezWkUR989rN/6VYLwNqxtX5R8Za99VkrBVcDeLLxZYH1ms9fN0FImQoLIt9TiqFrTG0q5ESui4uT5LRpW+YKq3aj2RwVu/+/6DZYdbxO54Mqh6r
 M6b7pY9cuDxWbTUtnNwDbVKALmOGSQ==
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, James Zhu <jzhums@gmail.com>, "Zhu,
 James" <James.Zhu@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 03, 2021 at 11:57:17AM -0400, Alex Deucher wrote:
> I think just applying your patch is fine for drm-next (i'll take care of
> that).  For 5.14.x and 5.15.x, we can just cherry-pick afd1818.
> 
> Alex
> 

I can confirm that both 5.14.17-rc1 and 5.15.1-rc1 work on my
Picasso 3400G.  Thanks for everyone's efforts.

ĸen
-- 
Vetinari smiled. "Can you keep a secret, Mister Lipwig?"
"Oh, yes, sir. I've kept lots."
"Capital. And the point is, so can I. You do not need to know.”
