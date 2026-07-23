Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AC9C53219
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2026 07:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B86F10F302;
	Fri, 24 Jul 2026 07:30:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m4YRSg/c";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 066F210F08E
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 10:55:32 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47640541585so295855f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 03:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784804130; x=1785408930; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Qulu7xaEZm5in98pb3j2S+1mh+F5hfFMoEBjvFStRow=;
 b=m4YRSg/cEqPqlabvEL32nA035seN3wnPJfFlTrZ6OLKFc3JjTqRHy+0HCuBtTehQvw
 jxUK7GNNY7pbk84+4BVGRjVWaynLB84EV0QUyGGxW8Gc4w8ie6lKu0K8c/mXtDLJMCqc
 mRfJCgGWTU8ByJzPdfUfuNo/dMaul933LECzE/qfqLzpzAydOv3jzFRhvn11nMjsrIPh
 Ouw6h+F/kv5pOH9cKDjSAsxeDKzO2DRvoUMeeElXu45luFwnonzE2XskJzWkqqjmlQCB
 YOYZpaaO/2FWPTt2VtcItr6okSdsnOW/grNKlbiJhAKICxDutwHQue/e/aYzW78MFEKu
 HALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784804130; x=1785408930;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Qulu7xaEZm5in98pb3j2S+1mh+F5hfFMoEBjvFStRow=;
 b=ZV+gqM3DIrUb1sfRvbCDBhuKcFkuXJKFABZZzlb1V3PpYvmcopuuSlM4PGePdUR6GG
 Jn/2NrFViSiPMlykpcG99XmoJmXqgtOiK39ZSjaO11nLhA2cwHJsWWJHgQMHu1N5wHa/
 nyoJ4LpgpkQXBWAEawD9W73eWvHotSs7u+ngdTIxIOa51U38chzezf4Zsde2aNyTveU+
 23QjZT1466e7F45Sh8LxdE/NT2tVL8zXt/eGF7L2s5KOHcZZ462mZUe3Cs1t0inOQ9IM
 AO//BaenwmcrXd3EUBk/SpX+fY6DV8YWLgeqiUVmJPCWZZGjXtDsboV+1qu934fFlnmT
 OhOA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMU1tI8cnr9Ruf/B8UE6lPuKxCh8yP9zA50NdpKn4rWyN6pAWPyeCb/3NT8FlawuG1sKFG0mdc@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwbRVT8bwrIsTi6gtigoy7QcxxIEZfliYSLEQwgxlwChgTfsbW4
 CRyhekGV3+u+joua8r3sDYb+G2FmUmY0VO3oMNLHxLh14YJNhDWGYufp
X-Gm-Gg: AR+sD10UXd/O6+Asu9HQGOvhSf7xReXgy57ST3ltH/pQAhFBHa+Pyd1FJyI3+E3aYXB
 9RUBOOF0HnLou+PfXm1iMFr5JG7uO+NB4XUnIFrpyxPL09n9ASj7dRuxYk1Q/w/+jPAOfDwDzbQ
 XVnrGo9NKy+IRuWF+vVE0CmTZCR9d64HRhkPUdkG5mP8BSU93ZmwV/LtqvoZkldsXBW5sqwotM7
 TMfzWchtL6uJCIpb0+MdoLY7e/m71KeLJ/k+fF1B9xpHE2Ez7eR7o07sBL5zhHDAGNljrSvplgW
 CL+LvEehVmzmxXiXeLMtL1YElkPzHXZQLN4dNP48+j+fdEbrtcsuTCk3dHBX5l0WR1F/8Jm7xLy
 TYIqxZ2YAZ5rFN7FHsJW5nf+LRLs6c5lxZ8B1bqQ8TvJxIztcT9+FLGSuUqPbQkx6PZjqe8jN1A
 ==
X-Received: by 2002:a05:6000:983:b0:472:3090:d878 with SMTP id
 ffacd0b85a97d-47f8d76dd6dmr3589927f8f.4.1784804130300; 
 Thu, 23 Jul 2026 03:55:30 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c531afsm13939992f8f.24.2026.07.23.03.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 03:55:29 -0700 (PDT)
Date: Thu, 23 Jul 2026 13:55:25 +0300
From: Dan Carpenter <error27@gmail.com>
To: Benjamin Cheng <benjamin.cheng@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "David (Ming Qiang) Wu" <David.Wu3@amd.com>,
 amd-gfx@lists.freedesktop.org, Leo Liu <leo.liu@amd.com>,
 Ruijing Dong <ruijing.dong@amd.com>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH v4 2/5] drm/amdgpu/vce: Prevent partial address patches
Message-ID: <amHzHa_2Cjcu5_7G@stanley.mountain>
References: <20260330195757.901509-1-benjamin.cheng@amd.com>
 <20260330195757.901509-2-benjamin.cheng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330195757.901509-2-benjamin.cheng@amd.com>
X-Mailman-Approved-At: Fri, 24 Jul 2026 07:30:26 +0000
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

On Mon, Mar 30, 2026 at 03:57:54PM -0400, Benjamin Cheng wrote:
> In the case that only one of lo/hi is valid, the patching could result
> in a bad address written to in FW.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index eb4a15db2ef2..efdebd9c0a1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -680,6 +680,9 @@ static int amdgpu_vce_cs_reloc(struct amdgpu_cs_parser *p, struct amdgpu_ib *ib,
>  	uint64_t addr;
>  	int r;
>  
> +	if (lo >= ib->length_dw || hi >= ib->length_dw)
> +		return -EINVAL;
> +

I feel like the better fix would be to change the amdgpu_ib_get_value()
function to return negative for invalid indexes instead of returning 0.

drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
   562  static inline u32 amdgpu_ib_get_value(struct amdgpu_ib *ib, uint32_t idx)
   563  {
   564          if (idx < ib->length_dw)
   565                  return ib->ptr[idx];
   566          return 0;

s/return 0/return -EINVAL/

   567  }

amdgpu_vce_validate_bo() has the same issue where invalid lo hi are
treated as success.

regards,
dan carpenter

