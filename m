Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B89C7EE23
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jun 2023 08:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D4610E1A5;
	Mon,  5 Jun 2023 08:57:51 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 250D010E1A5
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jun 2023 08:57:48 +0000 (UTC)
Received: from [192.168.1.137] ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202306051057438085; Mon, 05 Jun 2023 10:57:43 +0200
Message-ID: <85ae153f-357b-53b9-e987-c6aafa425299@daenzer.net>
Date: Mon, 5 Jun 2023 10:57:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] Revert "drm/amdgpu: change the reference clock for
 raven/raven2"
Content-Language: en-CA
To: Alex Deucher <alexander.deucher@amd.com>
References: <20230602184312.752618-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
In-Reply-To: <20230602184312.752618-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F1E.647DA387.001E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
 Spam="Unknown"; VOD="Unknown"
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
Cc: Jesse.Zhang@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 6/2/23 20:43, Alex Deucher wrote:
> This reverts commit fbc24293ca16b3b9ef891fe32ccd04735a6f8dc1.
> 
> This results in inconsistent timing reported via asynchronous
> GPU queries.
> 
> Link: https://lists.freedesktop.org/archives/amd-gfx/2023-May/093731.html
> Cc: Jesse.Zhang@amd.com
> Cc: michel@daenzer.net
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

The series is

Reviewed-by: Michel Dänzer <mdaenzer@redhat.com>

Thanks!


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

