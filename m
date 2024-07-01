Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C95EC30653
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 10:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C31010E38B;
	Mon,  1 Jul 2024 10:38:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=friedrich.vock@gmx.de header.b="DFSLygeN";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12F8310E38B
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 10:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1719830286; x=1720435086; i=friedrich.vock@gmx.de;
 bh=erjUd0N9zDV1A2Ni1pGziabj9EmIJmOnNCn7LepWpik=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=DFSLygeNkH3203MFeCV0MX2Cekms0MLzbUe6hg+p2qPm4g6P878aoDTSceGJQMCw
 ln9gwkkwfvzmvs8+ps4sVs+3XXmfjsWolqvvbI0Iqa471I7cRtyaySIu0oozrSYhq
 as551WrWUVsJLkIoWOqqxZmchVx17ynMJvnQtXrubsxBgtkDTQeFwdvEpb6ZLJ0ce
 lAtPKivsWkw9zPzvJb8VPxzqxpXHhKlUmlPw/zlxI4v9JOsNV40uymZCYWJGqPYmQ
 3ORLMCMBOChmjOvfItCzzi6rusxQtsTECfRutjqDdFvomvzmoAUWo81Oogias+W7G
 iWkwBDdmsM3PoJD36A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.88.197] ([134.34.7.55]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNt0C-1smWbV3n2m-00SGXx; Mon, 01
 Jul 2024 12:38:05 +0200
Message-ID: <b9bde2cd-b7c7-4792-ac47-42a9b3fe780a@gmx.de>
Date: Mon, 1 Jul 2024 12:38:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: sysfs node disable query error count during
 gpu reset
To: YiPeng Chai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, Candice.Li@amd.com,
 KevinYang.Wang@amd.com, Stanley.Yang@amd.com
References: <20240701081050.21825-1-YiPeng.Chai@amd.com>
Content-Language: en-US
From: Friedrich Vock <friedrich.vock@gmx.de>
In-Reply-To: <20240701081050.21825-1-YiPeng.Chai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t51WEpMx/eHjTPaotQqlpsu+Cgy6Z9DEkWv3teYBt5hnkFp5hBg
 a5NnL9HM/ya649MI4c6FfDYMQtaXDuIzhSKokT050aE5jGk5dKyRIFSd/9O5C/6HB4qvs/A
 ayNX5R4Iv8Qh7LltK5heS3Vy0ejcsSlUQIu23GkYfZZITCHqEmxhapQhEux8uWDdgaXR3Y7
 Cj1j3zPxvTuDHeTXaVR6Q==
UI-OutboundReport: notjunk:1;M01:P0:TZVmXMJ0TKY=;N7m7Hso/sPeze4tDL0GC/VZcpu2
 GgpKeYTYbvjfrFS+frY+aIf5RqTVTkDkBQL6nt6Kff24TtZhxeON18VIRPPfBA5Fqe2yVCyxE
 u7aqtnbbX7kPD1FFTxTjp/UrR5Kr9Z5wV21JXCkely5bVD7v90AnUkhQDdSJyJTZguakJO2m4
 v2cakU+gbYaWk35J7ju6xfR1XbSBVcSnDG94xo5U8yvi9ELC6uXIRvreoqcpRfFsZQ9dreL8P
 ecuIg5/iMGn6XyiwMIRyCRjPtQUWyU4PMhCMS+t/SHlbrQio11jIeVdeP/ODV9diimlYBAnXC
 DRGO6Qi+/Bm4QBNN0kTSXaq3gTp/D4/A4Qz/Uy7w28DEqIu8v1+7+pu7BtcMwqUi7HqU8PZeB
 poQLfpsXzTB+OCBR3J9jVo+IKSbCrHwkERk5TL8qokBsuuC53Fzuou3cSSYUGhG/hllQDFRqW
 x+tocMhHJs3fSdebTl5+CeqKjKjr5DTaxyFd8vOAz16KLfIO127Oe6Xr3IFwwMpt5Nr88OdWe
 c+T8SyE/Esw5ex5t7+HbqENSEmrg+BtlQM0orMMrX5TenagPPM8L+HW4mllEcvqAGAwuALnAN
 0iWgGqKhFkq+hOO+zx/LXtLLHG530BWE3SPcbgz5jU86qWKHXsJOTQptntsRtzUyUHdnLNtbq
 f3LkptKxRMpZYZhwIUf0SoNgTSef6xIkLbsP/K1GCa+V5q0aJm1WFHPCW2GdvzBMq0VhEDMqq
 rlu95hqo1hz2J0YBdIBlriSdMXUhabyUE7N0ffdR1MVv1vy92qVuQ5y2es+JFkritru4ym3UA
 wyU0MA1KaXkNzpfagN2t+/ctcbs23flABRxMcP91gDELQ=
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

On 01.07.24 10:10, YiPeng Chai wrote:
> Sysfs node disable query error count during gpu reset.

Can you elaborate a bit more? Usually the body shouldn't be a 1:1 copy
of the summary phrase.

>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/aldebaran.c     | 2 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 3 +++
>   3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/am=
d/amdgpu/aldebaran.c
> index d0a8da67dc2a..b0f95a7649bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
> @@ -316,8 +316,6 @@ static int aldebaran_mode2_restore_ip(struct amdgpu_=
device *adev)
>   		adev->ip_blocks[i].status.late_initialized =3D true;
>   	}
>
> -	amdgpu_ras_set_error_query_ready(adev, true);
> -
>   	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
>   	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_device.c
> index e133a9982a77..41689aa24e67 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3157,7 +3157,8 @@ static int amdgpu_device_ip_late_init(struct amdgp=
u_device *adev)
>   		return r;
>   	}
>
> -	amdgpu_ras_set_error_query_ready(adev, true);
> +	if (!amdgpu_in_reset(adev))
> +		amdgpu_ras_set_error_query_ready(adev, true);
>
>   	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
>   	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ras.c
> index ac7ded01dad0..e2abc04112d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1295,6 +1295,9 @@ ssize_t amdgpu_ras_aca_sysfs_read(struct device *d=
ev, struct device_attribute *a
>   		.head =3D obj->head,
>   	};
>
> +	if (!amdgpu_ras_get_error_query_ready(obj->adev))
> +		return sysfs_emit(buf, "Query currently inaccessible\n");

Why not return -EBUSY instead?

Best,
Friedrich

> +
>   	if (amdgpu_ras_query_error_status(obj->adev, &info))
>   		return -EINVAL;
>
