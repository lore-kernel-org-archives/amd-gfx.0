Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC40C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 06:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCDAD10E38A;
	Mon, 28 Mar 2022 06:39:29 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C48AF10E38A
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 06:39:28 +0000 (UTC)
Received: from [192.168.0.3] (ip5f5aef5a.dynamic.kabel-deutschland.de
 [95.90.239.90])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3615461EA1928;
 Mon, 28 Mar 2022 08:39:27 +0200 (CEST)
Message-ID: <c79c62f0-ec5f-4b5b-731c-96eb50dc7197@molgen.mpg.de>
Date: Mon, 28 Mar 2022 08:39:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 0/6] VCN and JPEG RAS poison detection
Content-Language: en-US
To: Mohammad Zafar Ziya <Mohammadzafar.ziya@amd.com>
References: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220328062453.4156191-1-Mohammadzafar.ziya@amd.com>
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
Cc: lijo.lazar@amd.com, Tao.Zhou1@amd.com, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Mahommad,


Am 28.03.22 um 08:24 schrieb Mohammad Zafar Ziya:
> VCN and JPEG RAS poison detection

It’d be great if you extended this a little bit. Especially, how it can 
be tested.

> Mohammad Zafar Ziya (6):
>    drm/amdgpu: Add vcn and jpeg ras support flag
>    drm/amdgpu/vcn: Add vcn ras support
>    drm/amdgpu/jpeg: Add jpeg block ras support
>    drm/amdgpu/vcn: vcn and jpeg ver 2.6 ras register definition
>    drm/amdgpu/vcn: VCN ras error query support
>    drm/amdgpu/jpeg: jpeg ras error query support

It’d be great if you made the last three commit message summaries also 
statements (by adding a verb in imperative mood).


Kind regards,

Paul
