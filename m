Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A92C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 15:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33A4710E218;
	Mon, 11 Apr 2022 15:20:42 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44E3E10E2D5
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 15:20:40 +0000 (UTC)
Received: from [192.168.0.7] (ip5f5ae91f.dynamic.kabel-deutschland.de
 [95.90.233.31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id A26B461EA1923;
 Mon, 11 Apr 2022 17:20:38 +0200 (CEST)
Message-ID: <bbd6939b-227c-f197-5d10-ba9194fd2b76@molgen.mpg.de>
Date: Mon, 11 Apr 2022 17:20:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH ] drm/amdgpu: fix discovery ip failed
Content-Language: en-US
To: "Jesse (Jie) Zhang" <Jesse.Zhang@amd.com>
References: <DM4PR12MB51525F878057240AE5C91F14E3EA9@DM4PR12MB5152.namprd12.prod.outlook.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <DM4PR12MB51525F878057240AE5C91F14E3EA9@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Yifan Zhang <Yifan1.Zhang@amd.com>, Ray Huang <Ray.Huang@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Jie,


Thank you for your patch.


Am 11.04.22 um 17:15 schrieb Zhang, Jesse(Jie):

You might want to add a space before the (.

> [AMD Official Use Only]

Please send a patch with `git format-patch` or similar.

> Fix discovery ip failed, and the log:

On what system?

>     56.129549] [drm:amdgpu_discovery_validate_ip [amdgpu]] *ERROR* Unexpected number_instance (64) from ip discovery blob
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

Please describe the reason for the failure, and your fix.

A Signed-off-by line is missing.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 766006a075ec..a778b0392e9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -798,7 +798,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
>                          res = kobject_add(&ip_hw_instance->kobj, NULL,
>                                            "%d", ip_hw_instance->num_instance);
> next_ip:
> -                       ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
> +                       ip_offset += struct_size(ip, base_address, ip->num_base_address);
>                  }
>          }
> 
> @@ -1063,7 +1063,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>                          }
> 
> next_ip:
> -                       ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
> +                       ip_offset += struct_size(ip, base_address, ip->num_base_address);
>                  }
>          }
> 
> @@ -1113,7 +1113,7 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int n
>                                          *revision = ip->revision;
>                                  return 0;
>                          }
> -                       ip_offset += sizeof(*ip) + 4 * (ip->num_base_address - 1);
> +                       ip_offset += struct_size(ip, base_address, ip->num_base_address);
>                  }
>          }
> 

Kind regards,

Paul
