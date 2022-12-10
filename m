Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83803C4332F
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Dec 2022 13:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9082010E0E4;
	Sat, 10 Dec 2022 13:47:16 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4920C10E0E4
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Dec 2022 13:47:11 +0000 (UTC)
Received: from [192.168.1.137] ([188.62.80.205])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202212101447073578; Sat, 10 Dec 2022 14:47:07 +0100
Message-ID: <b8949540-eed7-8272-0dd8-2610de143252@daenzer.net>
Date: Sat, 10 Dec 2022 14:47:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20221129071037.531124-1-jiadong.zhu@amd.com>
Content-Language: de-CH-frami, en-CA
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 1/4] drm/amdgpu: Introduce gfx software ring (v9)
In-Reply-To: <20221129071037.531124-1-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F24.63948DDD.0017,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Huang Rui <ray.huang@amd.com>, Christian Koenig <Christian.Koenig@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11/29/22 08:10, jiadong.zhu@amd.com wrote:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
> 
> The software ring is created to support priority context while there is only
> one hardware queue for gfx.
> 
> Every software ring has its fence driver and could be used as an ordinary ring
> for the GPU scheduler.
> Multiple software rings are bound to a real ring with the ring muxer. The
> packages committed on the software ring are copied to the real ring.
> 
> v2: Use array to store software ring entry.
> v3: Remove unnecessary prints.
> v4: Remove amdgpu_ring_sw_init/fini functions,
> using gtt for sw ring buffer for later dma copy
> optimization.
> v5: Allocate ring entry dynamically in the muxer.
> v6: Update comments for the ring muxer.
> v7: Modify for function naming.
> v8: Combine software ring functions into amdgpu_ring_mux.c
> v9: Use kernel-doc comment on the get_rptr function.

The series is

Tested-by: Michel Dänzer <mdaenzer@redhat.com>


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

