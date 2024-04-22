Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEE5C04FF8
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 07:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02F101131EE;
	Tue, 23 Apr 2024 07:43:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="iv8b04yn";
	dkim-atps=neutral
X-Greylist: delayed 323 seconds by postgrey-1.36 at gabe;
 Mon, 22 Apr 2024 15:44:23 UTC
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6EA410F663
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1713800661; x=1714405461; i=markus.elfring@web.de;
 bh=PvxrtFdGZmRXnr/yFq+g2FFB8EV93GFvYY78jv7kXYQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=iv8b04ynPFs0hBG5NgM5IlvKdg3qpPwgXxgy+IbWMeqP9TBLJdWqtkLvV3yDeV4Y
 fzqMflNuVRs31iLh2R6hFWwrqWtiyLsP4Ag28AhxMsncQddl2lcNJUaGQf2gOkw67
 XTypeMbToO1The1wmZ9njNCuBn0RQBmrnftS/BqKEgeHX2xHiogjrZZCZXihlbBaq
 naQvIXS5d3Uxx43sj4geOz0T3js2wm9NVYwR37lvB+nYCqHmq6+9SCEpzwa92Bwua
 pFAtcaD0SDApPOuIfkFTKsp1RNKMzVMOZPcDm1WpjlN4d51c+vkTThknNTiTie5rd
 d3tQKrBcf0DIcxfLTw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MumNL-1spO180rnH-00tQ77; Mon, 22
 Apr 2024 17:38:53 +0200
Message-ID: <964c9987-ea86-4167-899d-3bd3442ebfdb@web.de>
Date: Mon, 22 Apr 2024 17:38:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jose Fernandez <josef@netflix.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 Alan Liu <haoping.liu@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, George Shen <george.shen@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Ilya Bakoulin <ilya.bakoulin@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Leo Ma <hanghong.ma@amd.com>, Nasir Osman <nasir.osman@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240410043433.12854-1-josef@netflix.com>
Subject: Re: [PATCH] drm/amd/display: Fix division by zero in setup_dsc_config
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240410043433.12854-1-josef@netflix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ImWj6NNFf54sdIU5jTB8RmmUgnJSM4ABxpBdpnbmrgQZxjocuvw
 xKz8NFS87E2HoZuS5ACRStYdZEpf3LwT7Ayfbgi511rH7Jqm1wmew0+1L2n6Ryy8tnv3mgh
 9OgnL+aZNfBvVRhTOuVYL4kuPl8JiHNVjHBwfbsO4u2o0NOuns/wGgkqKmxeYhxxjIILqVa
 XIBI1QPzz+XcsrdIu//bw==
UI-OutboundReport: notjunk:1;M01:P0:aIFVfHCB9VA=;j7wZvXuvtWhN95CsBas9t/SCf0c
 zCPYw1TgfYSjxSPuRQnkB7XjMoeP3umhFpqlRKqrcIVxYR6+DKuL5keMMhzEfZtlr5vfCkS7D
 HmmlZ+mBiDWo/DvNqlGlujSSYc2eX7R3vh3zD7b8GhGez1cbstpYjKxZ1qc4KGmWL1J3Ft7iB
 n2qVQ2E0t/6ZVboL/y+PLCwDa87qQX+zL7l2KA+27mn2EO21wDznnFyyv/Jaopd6CQl/lTJnD
 hPc3ilmIgcNKHaBhJibnRVAYGO3OZws3QyMxm3arRiyfcJykx2RE/xfellzgQcZ7iFOoaldLW
 AgDDHcLKAdd63raCBiHlWkORX2gMrR1EZqs6plThGxydfikqFBfjSmMIiv6sTRXQzbjRnXZKz
 dP4D9B1K9g5d05T0naVHvWxyvWQP7/dKSj6nGfPLd48OceCsB+V6FePYgmWSvrAb9H52yx1Gg
 Z2t+NCeprsDwZWGV9cGczT6J4aH3WcB/r0HQfnb969AI/y1As+r5i3jf4NnmnnnDqoHhvMtSO
 DFxXeZEYe9sW63Oqg+MwLy4kto6towr8+tzlRWA3pxwDhyB+rJQK2BTrmmi2D4OIWKxnzRoZX
 laBoo1nFnRqzwMHyTuWOENX71mf1hOA189sE0J+k5AZj0s7ICB1eS/vsPfYe6yWKgkYN8Lq7q
 GaJ308nZOTF288tG+ZZYZJs/7oJT8id3djH0umu9nvv9gAQI+RN0u2KHEIyqAU2+kFbLqC+bk
 4Ap4K85hZjKwgrd/WmfXtmtOBod8ID51Fujc778FMyVZC7FTOx2wzsg5r/7tdKS8y7KmBl9y3
 mxcxTT26nKZjMYDs0JGxHqdd4ejRj9OeCFhMGOkS/+ur4=
X-Mailman-Approved-At: Tue, 23 Apr 2024 07:43:25 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

=E2=80=A6
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> @@ -1055,7 +1055,12 @@ static bool setup_dsc_config(
>  	if (!is_dsc_possible)
>  		goto done;
>
> -	dsc_cfg->num_slices_v =3D pic_height/slice_height;
> +	if (slice_height > 0)
> +		dsc_cfg->num_slices_v =3D pic_height/slice_height;
> +	else {
> +		is_dsc_possible =3D false;
> +		goto done;
> +	}
>
>  	if (target_bandwidth_kbps > 0) {
>  		is_dsc_possible =3D decide_dsc_target_bpp_x16(

I suggest to take another coding style concern into account.
Please use curly brackets for both if branches.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.9-rc5#n213

Regards,
Markus
