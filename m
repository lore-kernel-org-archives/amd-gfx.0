Return-Path: <SRS0=YeOH=4B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1B9C2BA83
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2020 14:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC2B20873
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2020 14:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CfCEA2e0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC2B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE916E313;
	Thu, 13 Feb 2020 14:31:04 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C19736E313
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2020 14:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581604261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=02bpFdPoP5M+VDil9RSarb1UQjl5Yl/Rjp97s0/g/8g=;
 b=CfCEA2e0iws5uTCtq1EKQLo7tKtKKlteYT/lsKu0TvgXtZQXOfSRE/ZfD0lXO7NtU9YGem
 NdLgzl/uHA2ASyp9lwEM87fsjcxiSv9omL2Sq1TWMzZP0+MfCfpuMbyDCPO7XF/H2feMn0
 nypdNO8y2ZEJQN5euL05VT+iC6DvONQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-FYbNohFFOX6sqiVvaI9cyQ-1; Thu, 13 Feb 2020 09:30:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D209800D48;
 Thu, 13 Feb 2020 14:30:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com
 [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77CAB5C1C3;
 Thu, 13 Feb 2020 14:30:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6B6BB939B; Thu, 13 Feb 2020 15:30:53 +0100 (CET)
Date: Thu, 13 Feb 2020 15:30:53 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Nirmoy Das <nirmoy.aiemd@gmail.com>
Subject: Re: [RFC PATCH 5/6] drm/qxl: don't use ttm bo->offset
Message-ID: <20200213143053.tkbfd6wr5rbspzty@sirius.home.kraxel.org>
References: <20200213120203.29368-1-nirmoy.das@amd.com>
 <20200213120203.29368-6-nirmoy.das@amd.com>
MIME-Version: 1.0
In-Reply-To: <20200213120203.29368-6-nirmoy.das@amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: FYbNohFFOX6sqiVvaI9cyQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Cc: David1.Zhou@amd.com, thellstrom@vmware.com, amd-gfx@lists.freedesktop.org,
 airlied@linux.ie, kenny.ho@amd.com, brian.welty@intel.com,
 maarten.lankhorst@linux.intel.com, dri-devel@lists.freedesktop.org,
 nirmoy.das@amd.com, linux-graphics-maintainer@vmware.com, bskeggs@redhat.com,
 daniel@ffwll.ch, alexander.deucher@amd.com, sean@poorly.run,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

> @@ -311,10 +311,8 @@ qxl_bo_physical_address(struct qxl_device *qdev, struct qxl_bo *bo,
>  		(bo->tbo.mem.mem_type == TTM_PL_VRAM)
>  		? &qdev->main_slot : &qdev->surfaces_slot;
>  
> -	WARN_ON_ONCE((bo->tbo.offset & slot->gpu_offset) != slot->gpu_offset);
> -
> -	/* TODO - need to hold one of the locks to read tbo.offset */
> -	return slot->high_bits | (bo->tbo.offset - slot->gpu_offset + offset);
> +	return slot->high_bits | ((bo->tbo.mem.start << PAGE_SHIFT) +
> +				  slot->gpu_offset + offset);
>  }

--verbose please.

I don't get the logic behind this change.

The other chunks look sane, calculating slot->gpu_offset
in setup_slot() certainly makes sense.

cheers,
  Gerd

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
