Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC74DC982C1
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 07:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE84E10E9AD;
	Thu, 17 Sep 2026 07:07:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="TikYO09N";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 240BD10E166
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 14:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789570571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RbEbk6n+TDXHy4GmQzvV4SsWC54eLSugxcTsbo8xF5w=;
 b=TikYO09NuOlebK9Gy8AXdd0h96X+/DaPIPKtNPB+si2vb/SSNmfi2Di01SfmX1Q+YXCQ/S
 h/b20n7sMwNJEVjgmUtYsx9IlMIRanqz8ZHIAhWbG9iLPo4N/YUq0a6D7gyK5Pn/ais6MS
 EGFwISyfZmdQtPsPGwBWiHPBCVx9hlk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-esnJmfuSP-SAVmQrS-cgjg-1; Wed, 16 Sep 2026 10:56:09 -0400
X-MC-Unique: esnJmfuSP-SAVmQrS-cgjg-1
X-Mimecast-MFC-AGG-ID: esnJmfuSP-SAVmQrS-cgjg_1789570569
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49d0ae342b9so42057945e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 07:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789570568; x=1790175368;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RbEbk6n+TDXHy4GmQzvV4SsWC54eLSugxcTsbo8xF5w=;
 b=2VQpFzIcuBg+xxoxJ43tbNsQq851buT4z1q1Dbme4BRUaphjnnhK+/cInRv4CjAtX8
 lV0O4cDh6dTLaO22CwfGB5woAnervs6MFqKuAe97ZrY8JNOL4EQepVo/5khQELa+/UpS
 sZ6QJok6+iZWhc/p5GRq3GnYqqr0JBlDzzMeqE4kQM6AZb4f89ESlIucHzvhdPQkbOuZ
 WFKpUwMACtz1PbLOgJjEiTklHmDAYtmSS3eoFguUiJEG0550ZjiGsOi8AdY8Q8FZz1Vh
 yF87S25lTZETdZLRdFAaaXTbx3AvioRfegPlha1W8dsmhWxPsdnsCF9g9/3AvPgRNR8R
 bCCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSh+NctQKhhdv/fTRmwvZ8JkbuS2TWThXXERr/HA55B6OYIDLZLIdF8k25XormjKGISWs1qNd0@lists.freedesktop.org
X-Gm-Message-State: AFuF++mIwS8NTAPmO9fhAIDPKKXVtEujRSuMDmPX5ITSZlpwyvkZfGZH
 CrxQ5yjLKrFrW9MkRrW1boTrx6+BQpftWMOvfc+YiUMLU1GwLR6R9Z0vmifNHZ/9l3O4MHUJx0s
 0biGc0coxdAZad7/8I61RFyLC5vE1k0+WRQCOEPcTsm77TbbZhYXHnt8l5VsHETv/AVA=
X-Gm-Gg: AYBFou09r2UiVVs1FsUuKAsRwtoTLYpatwittzxyVsfp0QWWQ0sq/zR3G6/YRYiFzih
 20c7ClpJYvEQ1wIrT7wYWRSdczliaF1ZlZ5EKFefGeggUePMNkjHnxPoOLXUcc1l3opc6Q3/vSv
 BwmFvnzqF33tUvz57oVev0iyT6A2nyATkDwHSolSl3+rECUEuGRsIr+u2uvIo0AffqszaK/woJf
 XhEOD5uRE+LwQhITVDD9ZhKXJL5eo20/PjKyxeG0mukpstr+rzpkac4mQL7p5B6peOg53RuX8uZ
 mVU7iqvbDRd6K8/UJ+0kX8JeewzjBbddB1r1ghrMb7NopBLNSD5VZZl+0VOfeOuBAutmmZFoUz7
 v0MQyb6jz8Y60qXZ8Cr+DLljlqlfp
X-Received: by 2002:a05:600c:46cb:b0:49e:84bf:6110 with SMTP id
 5b1f17b1804b1-49eac463727mr32795485e9.6.1789570568541; 
 Wed, 16 Sep 2026 07:56:08 -0700 (PDT)
X-Received: by 2002:a05:600c:46cb:b0:49e:84bf:6110 with SMTP id
 5b1f17b1804b1-49eac463727mr32795075e9.6.1789570567979; 
 Wed, 16 Sep 2026 07:56:07 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-41-176-3.web.vodafone.de. [109.41.176.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83aead50sm95252875e9.7.2026.09.16.07.56.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 07:56:07 -0700 (PDT)
Message-ID: <ec4d7cff-d23a-46d1-b245-921f442b9a7b@redhat.com>
Date: Wed, 16 Sep 2026 16:56:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 36/49] drm/amd/display: adjust floating point format for
 gamut remap when needed
To: Fangzhi Zuo <jerry.zuo@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 James Lin <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>,
 Clay King <clayking@amd.com>, Dillon Varone <dillon.varone@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260723201908.373300-1-jerry.zuo@amd.com>
 <20260723201908.373300-37-jerry.zuo@amd.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260723201908.373300-37-jerry.zuo@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o3zIf5Do_NE_rpdpwDlzGruvXDIzOopwd4E5AjSgVCs_1789570569
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 07:07:03 +0000
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

On 23/07/2026 22.13, Fangzhi Zuo wrote:
> From: Clay King <clayking@amd.com>
> 
> [Why]
> The MPCCs different gamut remap matrices allow for S2D13 and S3D12 floating
> point formats, but only S2D13 is used. There may be cases where more
> integer bits are required.
> 
> [How]
> Switch to S3D12 if any entries in the remap matrix cannot fit in S2D13.
> Otherwise, prefer the extra precision of S2D13. Communicate the max value
> that hw can support to dm via dc color caps.
> 
> Reviewed-by: Dillon Varone <dillon.varone@amd.com>
> Signed-off-by: Clay King <clayking@amd.com>
> Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
> Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
> ---
...
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index 75c06a1752b5..07ebd98f0d3b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -315,6 +315,7 @@ struct mpc_color_caps {
>   	struct lut3d_caps mcm_3d_lut_caps;
>   	struct lut3d_caps rmcm_3d_lut_caps;
>   	bool preblend;
> +	struct fixed31_32 max_gamut_remap_coeff;
>   };
  Hi!

FYI, this change is causing a warning during "make htmldocs" now:

WARNING: ..../drivers/gpu/drm/amd/display/dc/dc.h:327 struct member 
'max_gamut_remap_coeff' not described in 'mpc_color_caps'

Could you maybe sent a patch to document it in the kerneldoc comment when 
you've got some spare time?

  Thanks,
   Thomas

