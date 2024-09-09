Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9CDECE57E
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 12:55:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAA8410E551;
	Mon,  9 Sep 2024 12:55:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="mGTWZ2lA";
	dkim-atps=neutral
X-Greylist: delayed 338 seconds by postgrey-1.36 at gabe;
 Mon, 09 Sep 2024 09:48:36 UTC
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A09CD10E2DB
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 09:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1725875312; x=1726480112; i=markus.elfring@web.de;
 bh=EBlqzeibcHmLE8jmEMvY/kGvwXFkAdrNBvVf/DUWlqQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=mGTWZ2lAT3Cz97knji184OButhhh8T7EaaVgJBzlnXwP24XF8bSEJ3ACHJ4DrRlI
 wTLNQyeNHd5J9xs1mxnXo1O9d4nVvcIBKQbTUiv1jX6Z7ySWnOEBtLT5jsLva9H9O
 R/4GxnQnZf6bJZ/cdhKZ2C3WkbGNFEBWSscPnKyEVr2+qKFsmOO8wN77XpFsrVpgG
 ai95A3bsYJV3Yo9GgeEBJy/Usn8MBZcnEHZ6AqTrrqY8Pxi1tgzDTl6LbScN2wH3a
 3BK9yOcDbQS0IPg23DmmZnga6KjVHTMKNu4kNMl9qk6nDsEvhj+9HJQFKlkRnqD0O
 y6JcmGnGqGRkGHZ5cw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1aIB-1sl7o90LFL-00EbI9; Mon, 09
 Sep 2024 11:42:26 +0200
Message-ID: <d4136720-e6c8-490b-933a-4a884412b38a@web.de>
Date: Mon, 9 Sep 2024 11:42:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/amdgpu: Move a variable assignment behind a null
 pointer check in amdgpu_ras_interrupt_dispatch()
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alan Liu <HaoPing.Liu@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Bhanuprakash Modem <bhanuprakash.modem@intel.com>,
 Candice Li <candice.li@amd.com>, Charlene Liu <charlene.liu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 David Tadokoro <davidbtadokoro@usp.br>, Eryk Brol <eryk.brol@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, hersen wu <hersenxs.wu@amd.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Jun Lei <jun.lei@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>, Mikita Lipski <mikita.lipski@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Tom Rix <trix@redhat.com>, Victor Zhao <Victor.Zhao@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Zhan Liu <zhan.liu@amd.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <2258ce64-2a14-6778-8319-b342b06a1f33@web.de>
 <0d4b92ab-f7c2-4f18-f3c3-c0f82ba47fc8@web.de>
Content-Language: en-GB
In-Reply-To: <0d4b92ab-f7c2-4f18-f3c3-c0f82ba47fc8@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0FinRSsoYLcUBzW5CselKtDxWi72MFZcC3KilliEKBsQUeKXYei
 FR2I8NrqAgdIr7ze6KALJPaM7wknBcUXSmvlGyO7sm9JokMjRgJonKx2kUM2LDr2R2qlBew
 oHpIeeJnmJltdTUQ2q2AREeQHxSuBS/F94J2yTpY+UIAZtqw2TB5gH2spYfpgruDPCjvV+f
 dPM9jIAK7/z0nl5PCkokg==
UI-OutboundReport: notjunk:1;M01:P0:v081iKJQ5t0=;cm0BhO+4njhDkdSzkpe66/R3MIF
 FAFLs+4vMIubme43IUebzbR/N+6cIwGoff5BEPByZ3+UabH70PsjdoAi8A2+i+vfAz2/KAimM
 KVOYfkyQtFQTWUpfZbbQ9B9vemDG5tGEOy5URS6YRpXnY/VWElvCBnE/cmB/MW1NcMCnXeOqQ
 lJdBABkpaTjYzkVnL8KA5VdgrysXQZeEotIEsfaHin85lCE3+5gkS2qX2/gdHOJxnIhrcadD7
 qc2Tir3gJFu6By9HdHmWVtZ2i16RgmXq876OtLbP7TCVzjQV2HE7CnZlnbzzuWmpr/WzS0Mfj
 3m15s03WXEJ2t5EKc0u5znD2bbFU0I9Jb4nIGt41bAHpOkeI0V81TRzP9TkiNT+cQrvuabzY+
 n9tngkjxTVUXLqviDetXOsUbjOfyYnEjNn8hMJHVXZ5jGFDwEhTv8m14a9fzg6fsVo29q2+7I
 dkfkE5XlCkGcamEPTR9b8ZSr/YHjPAVwgnhtAb+dvWEwFeEpJp54kciMaI9vRTs8g+I6TWoQv
 NnMizh9ROQf3ZnGCTGqXspklUSU6ymkX/lawit+TrSDyCaBNZObP3P6NBCUd5ayVK66mtaksI
 P++QtsZCE4zRrCBNwMhshyorhhJwr8bmccPK0pXIsV0h3UEGK5tb5W6MC8OupvOHBwT6mRNSe
 AdLQQTrRPfjF2TOG328pRt9q3nN+j5l6KMJA3f1jLrLYPcm2VruTql0DJ5xbkxLOnHuY+vSY9
 LDfjzl4hoCkUvqAe/QLmCiBbNj/VIYU3ThclTt+AMTaIVzmQOGRDT//mtUmp/Ajqmynzd9qCH
 FK5N2EVs6WFYWpSI/EjRk3wA==
X-Mailman-Approved-At: Mon, 09 Sep 2024 12:55:48 +0000
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

> Date: Tue, 11 Apr 2023 10:52:48 +0200
>
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the function =E2=80=9Camdgpu_ras_interrupt_dispatch=E2=80=9D.
>
> Thus avoid the risk for undefined behaviour by moving the assignment
> for the variable =E2=80=9Cdata=E2=80=9D behind the null pointer check.
>
> This issue was detected by using the Coccinelle software.
>
> Fixes: c030f2e4166c3f5597c7e7a70bcd9ab383695de4 ("drm/amdgpu: add amdgpu=
_ras.c to support ras (v2)")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ras.c
> index 4069bce9479f..a920c7888d07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1730,11 +1730,12 @@ int amdgpu_ras_interrupt_dispatch(struct amdgpu_=
device *adev,
>  		struct ras_dispatch_if *info)
>  {
>  	struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &info->head);
> -	struct ras_ih_data *data =3D &obj->ih_data;
> +	struct ras_ih_data *data;
>
>  	if (!obj)
>  		return -EINVAL;
>
> +	data =3D &obj->ih_data;
>  	if (data->inuse =3D=3D 0)
>  		return 0;
>

I would like to point out that another software adjustment got the desired
development attention (on 2024-05-11).

See also:
Commit 4c11d30c95576937c6c35e6f29884761f2dddb43 ("drm/amdgpu:
Fix the null pointer dereference to ras_manager")

Regards,
Markus
