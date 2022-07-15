Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C8FC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jul 2022 01:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0786810E24A;
	Fri, 15 Jul 2022 01:56:39 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0552F10E24A
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 01:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mmLStNRkF6W9seC2izW5SAo9LagXYzdl6jVNyMVhXFs=; b=ek0RSbCy45pDM3TxkSejUNPs/4
 jLvmev/r92eB4fcXsy0EI7Y4gqzX+Bg8S9A1qZrkVKzhpBrBPBkmdR77miLIj+H1OFPpUNJxTODjh
 mjga5gok8197ak/jSXYvawiHwQownqn/NK0j1ZeP3DeJvxVsPOslmlvMY4V11tmJM0kgvubuk+78h
 dKjEnGMgeovRXGQ/3MlEno3uAcyvN7EHxAJ5885zI/5AwdDa/C0NBmesdVLdhNPqmLPRtQvNo9F1P
 ztEEw4qWpcupgO+XZx5faCYUv27fg4eRsPxBTiSX2jBUuJhiAlh1O53B4s07PJyg0hzj1FqwPHFEh
 DyurutLw==;
Received: from [177.139.47.106] (helo=[192.168.15.109])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1oCAZB-00H9j4-N7; Fri, 15 Jul 2022 03:56:29 +0200
Message-ID: <086abf6b-60ab-c0f5-e1e5-c39f0c33484c@igalia.com>
Date: Thu, 14 Jul 2022 22:56:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/12] drm/amdgpu: Write masked value to control register
Content-Language: en-US
To: =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20220714164507.561751-1-mairacanal@riseup.net>
From: =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20220714164507.561751-1-mairacanal@riseup.net>
Content-Type: text/plain; charset=UTF-8
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
Cc: magalilemes00@gmail.com, tales.aparecida@gmail.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, mwen@igalia.com,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Às 13:44 de 14/07/22, Maíra Canal escreveu:
> On the dce_v6_0 and dce_v8_0 hpd tear down callback, the tmp variable
> should be written into the control register instead of 0.
> 
> Fixes: b00861b9 ("drm/amd/amdgpu: port of DCE v6 to new headers (v3)")
> Fixes: 2285b91c ("drm/amdgpu/dce8: simplify hpd code")
> Signed-off-by: Maíra Canal <mairacanal@riseup.net>

Series is Reviewed-by: André Almeida <andrealmeid@igalia.com>
