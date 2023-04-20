Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C80AC77B72
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 13:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A83C910EC48;
	Thu, 20 Apr 2023 13:24:09 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA73510EC3C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 12:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=axhjz0+6MaGCesce83L143FhN0XhW/HEJLOOSR5/LzA=; b=LkUpH0AVeTFhyulj02sVVF+yb/
 9zO+PM7T+gdlh+/I/cTjawugl2bLxfoIAEiaxkaubYGGYFVGiJ1LF0hiWg3y27vtv5djCKdhzUYB0
 bwqvolS5oIuIfm5c/fFuKCDwjvjTHB3Q43UAXKs+zFmpBos/EWLhhAYRFAsHlIvh0xHEQtXSYysjf
 +qKckYRglS8hSfNaPxZZjkYIoOV4uhB/qrDkBWAggi+VZskPN/Y95TM6KRWaE6sjPVKGHP9sY2Sar
 GSPpQhh6G5qeglhLUCsmdeqM0uWtttphxkHaK/8oBw4RvVpz34ozKtl8FXX7wCrNKFY/gJctZsTDD
 FahM3iYA==;
Received: from 201-92-79-199.dsl.telesp.net.br ([201.92.79.199]
 helo=[192.168.1.60]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1ppTsj-006qty-3I; Thu, 20 Apr 2023 14:59:25 +0200
Message-ID: <94b63d19-4151-c294-50eb-c325ea9c699f@igalia.com>
Date: Thu, 20 Apr 2023 09:59:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 6.1.y] drm/amdgpu/vcn: Disable indirect SRAM on Vangogh
 broken BIOSes
Content-Language: en-US
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <20230418221522.1287942-1-gpiccoli@igalia.com>
 <BL1PR12MB514405B37FC8691CB24F9DADF7629@BL1PR12MB5144.namprd12.prod.outlook.com>
 <be4babae-4791-11f3-1f0f-a46480ce3db2@igalia.com>
 <BL1PR12MB51443694A5FEFA899704B3EBF7629@BL1PR12MB5144.namprd12.prod.outlook.com>
 <9b9a28f5-a71f-bb17-8783-314b1d30c51f@igalia.com>
 <ZEEzNSEq-15PxS8r@kroah.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <ZEEzNSEq-15PxS8r@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 20 Apr 2023 13:24:05 +0000
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
Cc: "sashal@kernel.org" <sashal@kernel.org>,
 "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhu, James" <James.Zhu@amd.com>, "Liu,
 Leo" <Leo.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 20/04/2023 09:42, gregkh@linuxfoundation.org wrote:
> [...]
>> @Greg, can you pick this one? Thanks!
> 
> Which "one" are you referring to here?
> 
> confused,
> 
> greg k-h

This one, sent in this email thread.

The title of the patch is "drm/amdgpu/vcn: Disable indirect SRAM on
Vangogh broken BIOSes", target is 6.1.y and (one of the) upstream
hash(es) is 542a56e8eb44 heh


Cheers,

Guilherme
