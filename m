Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B285AD2AB2C
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2024 08:42:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E24E210E760;
	Wed, 30 Oct 2024 08:42:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="aXimRinc";
	dkim-atps=neutral
X-Greylist: delayed 323 seconds by postgrey-1.36 at gabe;
 Tue, 29 Oct 2024 19:49:22 UTC
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 321ED10E6F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 19:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1730231360; x=1730836160; i=markus.elfring@web.de;
 bh=KVa6sUoEsISVLJqp9YsSnJ2+WbranhY7bY8+FHwY44g=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=aXimRincFyn0PlgowV7FNHByhEhkYIXLOUdGYARKCj90/EwuDo1QfYsfTZK032WL
 DD9LHTe57bjutJdEMBWa6ANusXGrxS7hAO0Mujn9HTOt18Dk3fP+VQszNaGHlXh0R
 7uIrNhJeuOcui2tL1QRFuNhlfJKIffWP8kF+s1+6ZJrd3qN1w9/6ZcTOe0dDSgSYd
 hHRUzbkIdkLrAdqhtUalH9I76QleZj19iMN19fuuiLTtm+kjwkCVpjSQJUiaFVIVA
 kx6ZtRKpSz7O2H2PNMtNqUdhM6C/BTldt2RKWKf8fIaMIeAOB67OSJl09btIOZ/Ia
 l2lJbYmkR+k+uzh9GQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNORC-1tUf2q1qyA-00QntE; Tue, 29
 Oct 2024 20:43:42 +0100
Message-ID: <58a77f5d-74a1-4ea2-942e-a352f30f66bd@web.de>
Date: Tue, 29 Oct 2024 20:43:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Huafei <lihuafei1@huawei.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 David Airlie <airlied@gmail.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: LKML <linux-kernel@vger.kernel.org>, Hawking Zhang
 <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Likun Gao
 <Likun.Gao@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 Pratap Nirujogi <Pratap.Nirujogi@amd.com>, Tim Huang <Tim.Huang@amd.com>,
 Victor Lu <victorchengchi.lu@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>
References: <20241029202758.2764535-1-lihuafei1@huawei.com>
Subject: Re: [PATCH v3] drm/amdgpu: Fix the memory allocation issue in
 amdgpu_discovery_get_nps_info()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241029202758.2764535-1-lihuafei1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1eb1mV/sniekV3cSxKRVEOdxvIGkwE3QOfs5C6TbZLC6LbNAORa
 npSbXL1ta54UfT/tJNlaAU7eceDkl2BOSVQszkTX0QzOpY299Uejg0csBbz9Q9oarjvZILm
 rg/OpEwzNhIyXbR4DJtJcYZ/2Pk+RT06aTl8wbqtFMpq2q+bEN8ic49EbISdHBrrzwB83L0
 1ftm2HB80Bxp2+nVLxT2g==
UI-OutboundReport: notjunk:1;M01:P0:VBWmokV05Og=;7saiEzx3dBT5lo9PdehhJBMSDfo
 KkXuROz4Y80mL5YMSFi4lqorDsZ9W0A+NWYkU5GbQYvD7YzhY1YzonLtAi3p5rAbaTIW9PP14
 pSqwiXSCQmE3lWzxkl5bgqSTU8OUGqyZ/MXTyaQJpnTxaQlW5nqEQB6ZZDN++3Nev++od1AyM
 1FQMD1EAkwETFC71ImMjY7dqYOpP3MQiCLFKttOeXrJX2BUtEwm7h3UFXfKdmUs/Amu5ujOq3
 Q+ETQd8jU9aWwFDl1bFOTQNhw8qF+mU4Sqn0PdmXpctm8M6C/30tyTMcdyTg/4EmPBtwlcbMV
 oRBVpl7ibvf8rSlMYPmNODOXwlYXaTUleDFNlbxLD+mgEm2qCiYWrYFe21uB4hlytHXPBIjLt
 mTipHVnbZNPEeJwMzDcg069378pFWIWADH6D7WanpYHmi1XdRnUg4CyXIAZsxOOya8JW+NyQ8
 D2O/y6iSjWXxG/4tAGCGPLYQdrWgi+jXhhSJWQzCJbEidCf7lsSVYTGDHpNeh/6lf/qgvGJp+
 9FYmgI/mHAeq9LKSgBqbpEKYCOV1KzddZpoQUReBECTMsTYdgcR96RnmOc1++MM2I7SwPyocM
 WbV9z7scmApGDa7JAqC32bSLmOZGaCLUuIdxrq2uShMIPEuXPp4cToqL4UkS9c7Qd10ccJ1YR
 hoosGl/DVvqTwN9m3MUNjJlDzCVvNZAUrmQ1j0vGMBJBivz0+XItZjXJtUK6UFOHR5banmYA2
 VTgbygXqvNnWS4n2wx+/5nAxcHAfSE7DjfQy6bcsKdbiCuJB9al7OqDvev9oop5dwsFdJFG+V
 5EPbJ42idniKqT53xTh7ecSw==
X-Mailman-Approved-At: Wed, 30 Oct 2024 08:42:29 +0000
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
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1757,11 +1757,13 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_=
device *adev,
>
>  	switch (le16_to_cpu(nps_info->v1.header.version_major)) {
>  	case 1:
> +		mem_ranges =3D kvcalloc(nps_info->v1.count,
> +				      sizeof(struct amdgpu_gmc_memrange),
> +				      GFP_KERNEL);
=E2=80=A6

Can the specification =E2=80=9Csizeof(*mem_ranges)=E2=80=9D be more approp=
riate here?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.12-rc5#n941

Regards,
Markus
