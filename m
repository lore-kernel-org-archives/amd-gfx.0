Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11234C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 15:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8820210E1E9;
	Mon, 11 Apr 2022 15:28:19 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B34DD10E2E0
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 15:28:17 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-e2a00f2cc8so8157121fac.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 08:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5NwEuUStRZRLOmO1Wluls1vMzP+uI5VjkeUgQSs5KIs=;
 b=oK7Hzf7KI0IKKO441a4iJEmsZ0LSIsuEbriQc2mQUbgRzPDI2vP7CUAA/UKzV6q4xy
 gHK8xIOiV7WMLaDG6lGcsZc+JQenpwMI1qjHsoh4sqL/tICNg6RI+1N00mjfdNkimCzE
 GR+t9Mv3lNC5qqNn2WO+FPscQKqjIhR+MBHcZRNFP53AFIiEkYt3lqpk0upnaxqcvR+r
 dgznPaw4njrbX8ZvHUy0in4mwZutfR6ITWqEIeOwXpeYTrrUGyG9WS1ygWeGVHMl3PjJ
 f1zdPyt1WREdy/9hqTvzSCjI1u+aAS5p+65bcrPyiV7y7eTAux7LHKOXTWqydoOmRoAZ
 dxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5NwEuUStRZRLOmO1Wluls1vMzP+uI5VjkeUgQSs5KIs=;
 b=58oUCatSK53gmDvTNsoPk3/bWDZw+DEP2C9nsk3JPHbQoTDFIXL8EG75fHLGrpD5xI
 yd/iX0wjeDBTOnKs9wl4BXrLobRQt4u3MMAHsB3x+Px+ffHMCggjTnZfg8NOSUoXlSbJ
 6Nl6ncHoVReEQiXLakRz/R40YgSDCXTj9WMZN9aCB76s+oToweb0KGnHRA89AM0Qj/zE
 gatrDhJNT3OnaiY32YiOZw49kOmg1ljun0rhm6lvHdRjFOHflBdyC09o0u7btm88ZHNz
 GbFVDjVLvkMJ8ri9vj/GyvSoeFlMNNYJlXY5mGleSculVuszHlym3HvRFw9JMYuCIqx/
 SJ1g==
X-Gm-Message-State: AOAM532vfZwQJaQkVPYITd84IrlUY+Vhx6o6coFW27d8FwHrcAJTjE1J
 9AvlexlXkSrf3MfwhRs4ezIiM4c9z5MzKm99T+Y=
X-Google-Smtp-Source: ABdhPJwfaVYbC2CEHNBfKyYsYo1OfIzjfcpRfkMF1cetm67V4qScU7Whsx9leXtEEYt88C2SuW5+oR4WgPcFqAEf83o=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr14973874oap.253.1649690896731; Mon, 11
 Apr 2022 08:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <DM4PR12MB51523E7DEF46C4D62472DFF1E3EA9@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51523E7DEF46C4D62472DFF1E3EA9@DM4PR12MB5152.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Apr 2022 11:28:05 -0400
Message-ID: <CADnq5_O8iDe3Me6cqG5Qdo278LuwuDf_OVfjX2hWXUPZKo5gow@mail.gmail.com>
Subject: Re: [PATCH v2 ] drm/amdgpu: fix discovery ip failed
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 11, 2022 at 11:25 AM Zhang, Jesse(Jie) <Jesse.Zhang@amd.com> wrote:
>
> [AMD Official Use Only]
>
>
>
> + Deucher, Alexander
>
>
>
> From: Zhang, Jesse(Jie)
> Sent: Monday, 11 April 2022 11:15 pm
> To: amd-gfx@lists.freedesktop.org
> Cc: Huang, Ray <Ray.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
> Subject: [PATCH ] drm/amdgpu: fix discovery ip failed
>
>
>
> [AMD Official Use Only]
>
>
>
> Fix discovery ip failed, and the log:
>
>    56.129549] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpected number_instance (64) from ip discovery blob
> [   56.130129] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpected hw_id (45056) from ip discovery blob
> [   56.130701] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpected number_instance (66) from ip discovery blob
> [   56.131283] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpected hw_id (45568) from ip discovery blob
> [   56.131855] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpected number_instance (66) from ip discovery blob
> [   56.132436] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpected hw_id (480) from ip discovery blob
> [   56.133053] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpected hw_id (608) from ip discovery blob
> [   56.133626] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpected hw_id (640) from ip discovery blob
> [   56.134207] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpected number_instance (64) from ip discovery blob
> [   56.134780] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpected number_instance (64) from ip discovery blob
> [   56.135360] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpected hw_id (28672) from ip discovery blob
>

Please add a description of what the fix is doing and add your signed-off-by.

Alex


>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>
> index 766006a075ec..a778b0392e9f 100644
>
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>
> @@ -798,7 +798,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
>
>                         res = kobject_add(&ip_hw_instance->kobj, NULL,
>
>                                           "%d", ip_hw_instance->num_instance);
>
> next_ip:
>
> -                       ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
>
> +                       ip_offset += struct_size(ip, base_address, ip->num_base_address);
>
>                 }
>
>         }
>
>
>
> @@ -1063,7 +1063,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>
>                         }
>
>
>
> next_ip:
>
> -                       ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
>
> +                       ip_offset += struct_size(ip, base_address, ip->num_base_address);
>
>                 }
>
>         }
>
>
>
> @@ -1113,7 +1113,7 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int n
>
>                                         *revision = ip->revision;
>
>                                 return 0;
>
>                         }
>
> -                       ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
>
> +                       ip_offset += struct_size(ip, base_address, ip->num_base_address);
>
>                 }
>
>         }
