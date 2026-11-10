Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84291606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lWsz5DIP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0004710F9EE;
	Wed, 11 Nov 2026 09:13:24 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDCFA10E203
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 17:50:07 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-833e671ee9fso2265838a34.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 09:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794333007; x=1794937807; darn=lists.freedesktop.org;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BMHxxjO7SmiwuH9OUCwU1zX9un2r5kjXJMRK8QfbbXQ=;
 b=lWsz5DIPpbeB5D2JFptxS7lpDee6dq78QZv9UHNPNNQx5aShcZhllL+cOOzfBicvt+
 lpgBMwincZErstGFSle0a0V0L7qzIPGsKPJd1dCD2za8r8YtGi/hNYddfPLoH5Toe3X5
 B+6mqqO5eHN148/MO3bseRYoEO2viPHB7Nla3t3AGYKOqTsh28laBL4WVbuuj4NfULpd
 qjkkuvYT7z2axX5MhtvgM9Aaz6z6rHILdsgypAnGlO3EaxxgRnu2bxSThuYZIg3SwmYL
 WdTHIHB6PVCDDkByiWzu48wOpX4GV6o1ztAfpVTrjS2Dn9qA1pCAa7yzSQVlonTvB1vq
 Q4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794333007; x=1794937807;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BMHxxjO7SmiwuH9OUCwU1zX9un2r5kjXJMRK8QfbbXQ=;
 b=IiJ5UY9PrsaniB+Wo2mFTKMZfDZWj+Nxw5e4dbh/i9zs5cQvoCcdcgLnk7fK6S0YF4
 kvBR4AsApUst9DUzdBJ2n5Hv/Sm9YFp/skkcjXdrnY6B4loxHhH0FUYZ/Aaw+Pj3HGkW
 +37m3HL1O/Y98cCJHdVO4IMtzh42dni1pdz54FlmGoePq5lRT8RaxxUJHdAjZWrofnw1
 Na4bsoiu1tv4Zf3KIWYXw3wfqf/Z4yBSrFP/11iUqe3BMCFGJIsZbD+A2K4kZrBnrphD
 eyXASgfTg9rH8dQCVq8TUs8oWxrQUMURxypvD9EM7Ai2KGkJjrNR2Xz9lBkrMpUrDcKd
 YryA==
X-Forwarded-Encrypted: i=1;
 AL+hErHZ5teZOl9x5vklT3qyS/mlxhcIp3Uyf1oPbIRdwTVOKFtBbbUhV0Ed5cLzvVbQYD5YzUdNuG3e@lists.freedesktop.org
X-Gm-Message-State: APuU4Z91ETlcd3I+WMYszWAwSpyy7MV2d1bmOcippWiM868W53DPX+J6
 Tn08UwGwIURhNl+xwCF7wZuHB5VSAuYOMWQI8Q+pSziNeP5zJCV1NPjW
X-Gm-Gg: AYBFou0rnqywxhMOcj8NLiMoNCfIZH3/FDcuP2eqGepVa2nYnb4O6+R7YriOtGygqa0
 GFIQHuofcKeOmVIZaVGP3hdziP/NOZhmboBOf7EAxiOmQYX3+LNgjZTduMinLiXKj43HlSbhz/Z
 /bzlyFsKxzE6IYmMyWk3jE/g36oY92VZXe8pbzT+k8ffEfi2iuF0A1OeitqtxcR82LStqBGgJ62
 ufBN09Ih4vIXdZKsYnTkoao3jt8jz5gNoITVYETgdqJl0NgadEQD6OXvcHKUm0ee3Gj/sqYm6AE
 zy++RzAWbQq4QuQUW2Z5TK9vGoX9GnxTI3NwkbadTeJBlhIZe1kQw2QM3xDcvST/htgC3Mm9Ghi
 14DZhV/XlLOWvpjiIXQ2smWt2wA5QRMgI5s+9oZx9wBZKoNaMJU5hmnGRdwRpF0wrezQyleUN9H
 BZ3Rl39SdtsoK9CLobVqhg/6HW+0y8NH51H7ruUjGIksl5xdzUNT0VAd7Loy0p17oEPjRg/l/bD
 dQwQFAHCSkSuYER8F9RL3ouqMh2scAlUjKxutTU5QkhJ2PTKAZMwiB6CpPuA8y3YTDSfF4+xQm7
 Hjg8WlUKXJUYXzPF8rafLhmBpFM+2t/nuCqZsg==
X-Received: by 2002:a05:6808:1686:b0:4b5:5bfb:f25d with SMTP id
 5614622812f47-5683cba74d3mr2612506b6e.20.1794333006772; 
 Tue, 10 Nov 2026 09:50:06 -0800 (PST)
Received: from [192.168.29.85] ([2405:201:8026:213e:7392:6aad:f285:27fa])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ae2302d8ffsm2043134fac.13.2026.11.10.09.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 09:50:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] drm/amd/display: fix USR retraining support check
From: mdshahid03@gmail.com
To: mdshahid03@gmail.com
Cc: austin.zheng@amd.com, jun.lei@amd.com, harry.wentland@amd.com, 
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com, 
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261101104727.141852-1-mdshahid03@gmail.com>
References: <20261101104727.141852-1-mdshahid03@gmail.com>
Date: Tue, 10 Nov 2026 23:19:36 +0530
Message-Id: <179433297650.153576.17456786292064820559.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Wed, 11 Nov 2026 09:13:13 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi ,

could you please review this patch and give your feedback ,when time
permits.

Thanks
Shahid.

On 2026-11-01 16:17 +0530, mdshahid03@gmail.com wrote:
> From: Mohammad Shahid <mdshahid03@gmail.com>
> 
> The USR retraining support check tests the address of
> USRRetrainingSupport[j] instead of its Boolean value.
> 
> Since the address of the array element is non-NULL,the
> condition can always true, even when USR retraining is
> required but not supported.
> 
> This issue is reported by script test_addr.cocci.
> 
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
> index a8519f547dce..74cb65687a50 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_util.c
> @@ -412,7 +412,7 @@ void dml_print_mode_support(struct display_mode_lib_st *mode_lib, dml_uint_t j)
>  	dml_print("DML: MODE SUPPORT:     Host VM or Immediate Flip Supported        : %s\n", ((mode_lib->ms.cache_display_cfg.plane.HostVMEnable == false && !mode_lib->scratch.dml_core_mode_support_locals.ImmediateFlipRequiredFinal) || mode_lib->ms.support.ImmediateFlipSupportedForState[j]) ? "Supported" : "NOT Supported");
>  	dml_print("DML: MODE SUPPORT:     dram clock change support                  : %s\n", mode_lib->scratch.dml_core_mode_support_locals.dram_clock_change_support == true ? "Supported" : "NOT Supported");
>  	dml_print("DML: MODE SUPPORT:     f_clock change support                     : %s\n", mode_lib->scratch.dml_core_mode_support_locals.f_clock_change_support == true ? "Supported" : "NOT Supported");
> -	dml_print("DML: MODE SUPPORT:     USR Retraining Support                     : %s\n", (!mode_lib->ms.policy.USRRetrainingRequiredFinal || &mode_lib->ms.support.USRRetrainingSupport[j]) ? "Supported" : "NOT Supported");
> +	dml_print("DML: MODE SUPPORT:     USR Retraining Support                     : %s\n", (!mode_lib->ms.policy.USRRetrainingRequiredFinal || mode_lib->ms.support.USRRetrainingSupport[j]) ? "Supported" : "NOT Supported");
>  	dml_print("DML: MODE SUPPORT: ===============================================\n");
>  }
>  
> -- 
> 2.43.0
> 
> 
> 


