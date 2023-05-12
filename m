Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1484C77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 May 2023 20:09:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ACAB10E2B1;
	Fri, 12 May 2023 20:09:37 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36E5510E2AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 20:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wFeZ0rHluMQ8Pg3tDc3Ktzp8uroR5Oyid2v5eouHh7g=; b=IJ6MBqRB8PX64w/RFLZT/9F8JZ
 Se9Kx5oMY/j7cpiP0uWEv1kvxZK0mfaBXTnXsCMtWKmzL08LiFsrFlifIv/DOYlTKoRx4ajxzoJbk
 7wJfvJl+MF1qy3MQGWdQA2olXrxQzSAWbKAM83aGIfq3bESpN04atVHUSdgMgRo0ZtIYJi8eNntOT
 C0rAKsCpzHe9uOm/VFS3RwpUT7aN6yKOxjU669K94k78YFOqQbCkU1cZSwHZYve6H/7EFIzNj2gCp
 h+XKLBVK5jdKo/6xyaT2PvTxUo5AmWCIs4l9vi3OpR73m/EQRySVFIuhxXbi5l8LRTbiyS4W05n2u
 UbLo6nLg==;
Received: from [179.232.147.2] (helo=[192.168.0.5])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1pxYyX-0082jl-Ht; Fri, 12 May 2023 22:02:49 +0200
Message-ID: <12406c54-7dbe-a918-5695-c32c587e447d@igalia.com>
Date: Fri, 12 May 2023 17:02:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] drm/amdgpu/gfx11: Adjust gfxoff before powergating on
 gfx11 as well
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230509164947.455753-1-bas@basnieuwenhuizen.nl>
 <20230509164947.455753-2-bas@basnieuwenhuizen.nl>
 <0c6d481c-02ba-cf89-3333-4517255b8042@igalia.com>
 <CADnq5_PffhjvYv4yLPQtN2gggJ4pbTcnqy=qPBkPKfjATnFx0A@mail.gmail.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CADnq5_PffhjvYv4yLPQtN2gggJ4pbTcnqy=qPBkPKfjATnFx0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 12 May 2023 20:09:35 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/05/2023 10:29, Alex Deucher wrote:
> [...]
>> BTW, I couldn't test this one since I don't have GFX11 HW, so appreciate
>> if anyone from AMD (or any community member) could give it a try...
> 
> We've tested this on gfx11 and applied the patches.  Thanks!
> 
> Alex
> 

That's great, thanks a lot Alex!
