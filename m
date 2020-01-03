Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43335C00523
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 21:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1589C215A4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 21:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aae0+cOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1589C215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFA3B89165;
	Fri,  3 Jan 2020 21:50:28 +0000 (UTC)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1920E8919E
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 21:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578088226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2E9jZbURUijwaE1tA6jFTdg/cQa33pnXiVlz2CG9nkU=;
 b=Aae0+cOGN5Upj0lb2wpxgsgyDJKPR9rziQEkarClfAf3onROxhVzEES0huCmhsmzlLmVVM
 s6L9Xw31Uf0pWG5o2VvygTmvzvxC8e+V4VPOQYRK7227B0hlWXxseWNLzrWOg++PU/GSbl
 nJnRQq9v9nYG67UJJxCH7+agY+XjLD4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-VWm2XzFtMtKFoE_dl2RHkA-1; Fri, 03 Jan 2020 16:50:21 -0500
Received: by mail-qv1-f72.google.com with SMTP id dw11so6957708qvb.16
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Jan 2020 13:50:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:organization:user-agent:mime-version
 :content-transfer-encoding;
 bh=2E9jZbURUijwaE1tA6jFTdg/cQa33pnXiVlz2CG9nkU=;
 b=NQVT2awrJ/ROvheyBBx6cxVppoQT05XkdJHarkgJajzoW122otQhTjrpw2JiLLviTd
 86VDEZ9pqYDjE9Z3G9hIiY7rraCPx6t1mZj6vZ67dYboNUOjsdVV8x5qb5UaNi13o+us
 IZieHVTuNhP+ldMzbojzc8ne40mbYJNMed6n9IjuM3q4LsbY+/qCUdntI+8Be3H8cWY1
 1+ONjx4UGdn1AIyJ41JAcQ5uy6al8EQgAvE9xvdznJp3BLMAuy+JG8aR7iOeLI09pycR
 iKQxLu0zd8e2kGlHed28OwlEAj7EXGes6bJK+Az/w3wI4aekYW3LPsYGDeOT52RABZsA
 TtnA==
X-Gm-Message-State: APjAAAX+r4r89SoSyg4Ep2v42YCp447PSsZIvh38hU1Lr/Z8pe/uxp2O
 z20oqMgi6zpUn8htsYsvPpVJdd6obgt8d8FkRbIqDIH0qy0RiEPbfFw/xGjauMTnRqZrC8j3lqt
 VOpCEsSeEsh1saXV4lhPmrRwQgw==
X-Received: by 2002:ad4:5487:: with SMTP id q7mr71109964qvy.19.1578088221271; 
 Fri, 03 Jan 2020 13:50:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqzzljP0z5w+OcexEMra3Da+CizoTHREMRArrOSpe2REftTWBrwKU6VuGvcxFXejz+7Ac3I1QA==
X-Received: by 2002:ad4:5487:: with SMTP id q7mr71109951qvy.19.1578088221027; 
 Fri, 03 Jan 2020 13:50:21 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
 by smtp.gmail.com with ESMTPSA id 16sm17167452qkj.77.2020.01.03.13.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2020 13:50:20 -0800 (PST)
Message-ID: <c163a9c8e2f8d71f265a624a1915636acce96b30.camel@redhat.com>
Subject: Re: [PATCH v2] drm/dp_mst: correct the shifting in DP_REMOTE_I2C_READ
From: Lyude Paul <lyude@redhat.com>
To: Wayne Lin <Wayne.Lin@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Date: Fri, 03 Jan 2020 16:50:19 -0500
In-Reply-To: <20200103055001.10287-1-Wayne.Lin@amd.com>
References: <20200103055001.10287-1-Wayne.Lin@amd.com>
Organization: Red Hat
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31)
MIME-Version: 1.0
X-MC-Unique: VWm2XzFtMtKFoE_dl2RHkA-1
X-Mimecast-Spam-Score: 0
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
Cc: jerry.zuo@amd.com, harry.wentland@amd.com, Nicholas.Kazlauskas@amd.com,
 stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Lyude Paul <lyude@redhat.com>

Thanks for all of the contributions you've made as of late! I will go ahead
and push this into drm-misc-fixes

On Fri, 2020-01-03 at 13:50 +0800, Wayne Lin wrote:
> [Why]
> According to DP spec, it should shift left 4 digits for NO_STOP_BIT
> in REMOTE_I2C_READ message. Not 5 digits.
> 
> In current code, NO_STOP_BIT is always set to zero which means I2C
> master is always generating a I2C stop at the end of each I2C write
> transaction while handling REMOTE_I2C_READ sideband message. This issue
> might have the generated I2C signal not meeting the requirement. Take
> random read in I2C for instance, I2C master should generate a repeat
> start to start to read data after writing the read address. This issue
> will cause the I2C master to generate a stop-start rather than a
> re-start which is not expected in I2C random read.
> 
> [How]
> Correct the shifting value of NO_STOP_BIT for DP_REMOTE_I2C_READ case in
> drm_dp_encode_sideband_req().
> 
> Changes since v1:(https://patchwork.kernel.org/patch/11312667/)
> * Add more descriptions in commit and cc to stable
> 
> Fixes: ad7f8a1f9ce (drm/helper: add Displayport multi-stream helper (v0.6))
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 1cf5f8b8bbb8..9d24c98bece1 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -393,7 +393,7 @@ drm_dp_encode_sideband_req(const struct
> drm_dp_sideband_msg_req_body *req,
>  			memcpy(&buf[idx], req-
> >u.i2c_read.transactions[i].bytes, req-
> >u.i2c_read.transactions[i].num_bytes);
>  			idx += req->u.i2c_read.transactions[i].num_bytes;
>  
> -			buf[idx] = (req-
> >u.i2c_read.transactions[i].no_stop_bit & 0x1) << 5;
> +			buf[idx] = (req-
> >u.i2c_read.transactions[i].no_stop_bit & 0x1) << 4;
>  			buf[idx] |= (req-
> >u.i2c_read.transactions[i].i2c_transaction_delay & 0xf);
>  			idx++;
>  		}
-- 
Cheers,
	Lyude Paul

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
