Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9C1C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 18:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0DE110F317;
	Wed,  1 Jun 2022 18:44:10 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F07810F317
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 18:44:09 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-f2cd424b9cso3867077fac.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jun 2022 11:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hoMiNZYJrAfbuhQrGDapdgZz3vciw9pWtItN8E0slnw=;
 b=od8SH/Ys8gt43a9X8iPqlOmXKL+R0dCjlhw+7x4xGPXOwq1laMrsXksFC1Lpm6raHl
 hjrUwgOu2u+Hi9vpAU57nizmNVmQxC5bqUmEnE40bAbAQgdfYk09bmtPLwkCwtL8aEXu
 Kf9hVdDD4PbpqmbCNRmVbccAOAWKxv/fNNau/Bzv6/zNGHc1g8dBCBTpHBCc+mbl0z8j
 MAu+Ks11lNNkWp9UvJWpv8IPTnPBJ2sDIoDHwFr/ZIet9kPNM/wuRMtLqK1PIS5jzsMr
 PgOjbm19yYAIWXntuaURWePdXVw4oWAiEWBmLjid4em4AmXpN2PwsnaSmpAhJu9LOw5H
 sGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hoMiNZYJrAfbuhQrGDapdgZz3vciw9pWtItN8E0slnw=;
 b=TSVkEiblvKWm6f9cCwMTYwXJgyhIx4AIendSJmSOLwzKzDbINJR9G8cqsfj1rqj7ca
 GzZCh7ucdi0wFFHAtZoZWWQI8ZJNddCitGdMYqZ6o9v/LblUSOrz7MALS1xiQNdsV3ys
 zHZq6tQ8SH7Bkytp1CuozZ9WIJfKukIinONmUJScZiBQ2C9SY2d7mkA8dcsiOpw8+Fk/
 Ev06AsFy8dq+cdj3bvelq8m4oN9MiVByHBjVfwAmk4SWpG+GZGX8xYJDWXkfymR/Zyz0
 2jOcHecimCTjgat1TQ+7Vq8qJSizN4QLwPTypvRKecwHqUkDcia7x7BeICBo6N/2ErCy
 CFEA==
X-Gm-Message-State: AOAM531cDna2ll1L+lz47b23SIRCryvoR1J9HJbyUR1/hB54feVkabxd
 3rKOxQ5ARxpphLs8hc0JD3FMjkLIoiEfka6lnPQ=
X-Google-Smtp-Source: ABdhPJwCz0AR8tTDpwwpJwpn0hIyY9iBlRIBDsDRqY0K1uMvlFffYks4KZRXhOfNGAabRjU1AhahBhnuTolYMzPy+eQ=
X-Received: by 2002:a05:6870:3105:b0:f2:9615:ff8e with SMTP id
 v5-20020a056870310500b000f29615ff8emr16722560oaa.200.1654109048402; Wed, 01
 Jun 2022 11:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <202205271546.oV14N2r8-lkp@intel.com>
In-Reply-To: <202205271546.oV14N2r8-lkp@intel.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Jun 2022 14:43:57 -0400
Message-ID: <CADnq5_NOkqRsoqELkLayNU+xArXd-4RO=_banvJpXHtSW4-YdA@mail.gmail.com>
Subject: Re: [kbuild] drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1433
 amdgpu_discovery_get_vcn_info() error: buffer overflow
 'adev->vcn.vcn_codec_disable_mask' 2 <= 3
To: Dan Carpenter <dan.carpenter@oracle.com>
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
Cc: kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
 kbuild@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 27, 2022 at 3:46 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> [ kbuild bot sent this warning on May 4 but I never heard back and it's
>   May 27 now so sending a duplicate warning is probably for the best. -dan]
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
> head:   7e284070abe53d448517b80493863595af4ab5f0
> commit: 622469c87fc3e6c90a980be3e2287d82bd55c977 drm/amdgpu/discovery: add a function to parse the vcn info table
> config: arc-randconfig-m031-20220524 (https://download.01.org/0day-ci/archive/20220527/202205271546.oV14N2r8-lkp@intel.com/config )
> compiler: arceb-elf-gcc (GCC) 11.3.0
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1433 amdgpu_discovery_get_vcn_info() error: buffer overflow 'adev->vcn.vcn_codec_disable_mask' 2 <= 3
>
> vim +1433 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>
> 622469c87fc3e6 Alex Deucher 2022-03-30  1403  int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
> 622469c87fc3e6 Alex Deucher 2022-03-30  1404  {
> 622469c87fc3e6 Alex Deucher 2022-03-30  1405    struct binary_header *bhdr;
> 622469c87fc3e6 Alex Deucher 2022-03-30  1406    union vcn_info *vcn_info;
> 622469c87fc3e6 Alex Deucher 2022-03-30  1407    u16 offset;
> 622469c87fc3e6 Alex Deucher 2022-03-30  1408    int v;
> 622469c87fc3e6 Alex Deucher 2022-03-30  1409
> 622469c87fc3e6 Alex Deucher 2022-03-30  1410    if (!adev->mman.discovery_bin) {
> 622469c87fc3e6 Alex Deucher 2022-03-30  1411            DRM_ERROR("ip discovery uninitialized\n");
> 622469c87fc3e6 Alex Deucher 2022-03-30  1412            return -EINVAL;
> 622469c87fc3e6 Alex Deucher 2022-03-30  1413    }
> 622469c87fc3e6 Alex Deucher 2022-03-30  1414
> 622469c87fc3e6 Alex Deucher 2022-03-30  1415    if (adev->vcn.num_vcn_inst > VCN_INFO_TABLE_MAX_NUM_INSTANCES) {
>
> Capped to 4
>
> 622469c87fc3e6 Alex Deucher 2022-03-30  1416            dev_err(adev->dev, "invalid vcn instances\n");
> 622469c87fc3e6 Alex Deucher 2022-03-30  1417            return -EINVAL;
> 622469c87fc3e6 Alex Deucher 2022-03-30  1418    }
> 622469c87fc3e6 Alex Deucher 2022-03-30  1419
> 622469c87fc3e6 Alex Deucher 2022-03-30  1420    bhdr = (struct binary_header *)adev->mman.discovery_bin;
> 622469c87fc3e6 Alex Deucher 2022-03-30  1421    offset = le16_to_cpu(bhdr->table_list[VCN_INFO].offset);
> 622469c87fc3e6 Alex Deucher 2022-03-30  1422
> 622469c87fc3e6 Alex Deucher 2022-03-30  1423    if (!offset) {
> 622469c87fc3e6 Alex Deucher 2022-03-30  1424            dev_err(adev->dev, "invalid vcn table offset\n");
> 622469c87fc3e6 Alex Deucher 2022-03-30  1425            return -EINVAL;
> 622469c87fc3e6 Alex Deucher 2022-03-30  1426    }
> 622469c87fc3e6 Alex Deucher 2022-03-30  1427
> 622469c87fc3e6 Alex Deucher 2022-03-30  1428    vcn_info = (union vcn_info *)(adev->mman.discovery_bin + offset);
> 622469c87fc3e6 Alex Deucher 2022-03-30  1429
> 622469c87fc3e6 Alex Deucher 2022-03-30  1430    switch (le16_to_cpu(vcn_info->v1.header.version_major)) {
> 622469c87fc3e6 Alex Deucher 2022-03-30  1431    case 1:
> 622469c87fc3e6 Alex Deucher 2022-03-30  1432            for (v = 0; v < adev->vcn.num_vcn_inst; v++) {
> 622469c87fc3e6 Alex Deucher 2022-03-30 @1433                    adev->vcn.vcn_codec_disable_mask[v] =
>
> But this array doesn't have 4 elements

Correct, but num_vcn_inst can't be larger than
AMDGPU_MAX_VCN_INSTANCES (2) at the moment thanks to:
https://patchwork.freedesktop.org/patch/486289/

Alex

>
> 622469c87fc3e6 Alex Deucher 2022-03-30  1434                            le32_to_cpu(vcn_info->v1.instance_info[v].fuse_data.all_bits);
> 622469c87fc3e6 Alex Deucher 2022-03-30  1435            }
> 622469c87fc3e6 Alex Deucher 2022-03-30  1436            break;
> 622469c87fc3e6 Alex Deucher 2022-03-30  1437    default:
> 622469c87fc3e6 Alex Deucher 2022-03-30  1438            dev_err(adev->dev,
> 622469c87fc3e6 Alex Deucher 2022-03-30  1439                    "Unhandled VCN info table %d.%d\n",
> 622469c87fc3e6 Alex Deucher 2022-03-30  1440                    le16_to_cpu(vcn_info->v1.header.version_major),
> 622469c87fc3e6 Alex Deucher 2022-03-30  1441                    le16_to_cpu(vcn_info->v1.header.version_minor));
> 622469c87fc3e6 Alex Deucher 2022-03-30  1442            return -EINVAL;
> 622469c87fc3e6 Alex Deucher 2022-03-30  1443    }
> 622469c87fc3e6 Alex Deucher 2022-03-30  1444    return 0;
> f39f5bb1c9d68d Xiaojie Yuan 2019-06-20  1445  }
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
> _______________________________________________
> kbuild mailing list -- kbuild@lists.01.org
> To unsubscribe send an email to kbuild-leave@lists.01.org
>
