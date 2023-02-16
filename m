Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06818C61DA4
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Feb 2023 16:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7284710E2C1;
	Thu, 16 Feb 2023 16:40:11 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D58A10EDE3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Feb 2023 16:19:11 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id n20so5013930edy.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Feb 2023 08:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ENVt/q2+5+btKHPgsnQYKmBBGcnghZdVFTo5CEeDNz0=;
 b=HKxk3cByT2tghCXU8v4DorUtURD9HgX/KtBYPDMOntTc79XEzjNLjhds5GAf7290ab
 Tn0oWzvWZgYMO4mpMUUXbucg3jf1tb0ihPoO3UuV8kjehW+IQzKpK2ZJnZOVEIlHXl1x
 ZCdalpjTEtDzstu0v1he0mTTN7r0130sAQ1sUMqmzqyAcvDiRLGmOlo6/0DtU0In56ws
 BUkaCOR//eJgAnWWS+mGhlHzva7szVUCT2dU7yiamM5P8xQSDRgly9MpKCTlUs8yYpUm
 PhFrLTaQxfftD9bOdPatfXSoA2V8Exlw2HcIIVVzntBE/cAT0Lkk5abG1/sSoz3eRmIp
 rHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ENVt/q2+5+btKHPgsnQYKmBBGcnghZdVFTo5CEeDNz0=;
 b=HIlDtFHBmFsbcTuI8uX1o/K2ssaIc4x9AgygIShTV/DSGylmxond9nyFBEoTQlLidD
 etiFffnWvSz+yocqdhkPwSZ9RrR9wNIFCFLOWvvGcCMowcLnG/3d/VHEcXEzhnDOFLJn
 2p4ZGLLjaEHQjj/JLoq8Pnc9XIrgoDbCIMfT7TE84gtAGtxZLoTPL1onrOwqZiDbU9H5
 3NEMJphdP4yqP7Ocv91Xa1O7VKANW4F7yKiwsLzNf+NVyHda4gPjZ+ogwte8XZbk1Ohx
 3lKrUoaW2+Cm+tnkX/2gJJJGDNCqUYGp8wN9OgJKnixK9Xh8hMmT0B0A+YLpDzXYOeRV
 ovcw==
X-Gm-Message-State: AO0yUKU7uOCD0ojIDLooKyx3MXKUNG1msH+G4ad9umoUFaliThnvfPNI
 U3QAA59ETV2GmhAlpFXmObE=
X-Google-Smtp-Source: AK7set81idgMFHq/9teeLm2fM+2PaavS6sOnQcojDOmPw8nmypjr3scKQxbqLUTAUQ8zCjqBI85oQw==
X-Received: by 2002:a50:fc11:0:b0:4aa:c3da:3ac5 with SMTP id
 i17-20020a50fc11000000b004aac3da3ac5mr7346992edr.3.1676564349573; 
 Thu, 16 Feb 2023 08:19:09 -0800 (PST)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 k26-20020a50ce5a000000b004a2470f920esm1080151edj.25.2023.02.16.08.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Feb 2023 08:19:09 -0800 (PST)
Date: Thu, 16 Feb 2023 19:19:04 +0300
From: Dan Carpenter <error27@gmail.com>
To: wenjing.liu@amd.com
Subject: [bug report] drm/amd/display: break down dc_link.c
Message-ID: <Y+5XeANydHcGsFiw@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Thu, 16 Feb 2023 16:40:09 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Wenjing Liu,

This is a semi-automatic email about new static checker warnings.

The patch 54618888d1ea: "drm/amd/display: break down dc_link.c" from 
Jan 18, 2023, leads to the following Smatch complaint:

    drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c:365 dc_link_construct_phy()
    warn: variable dereferenced before check 'link->link_enc' (see line 362)

drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_factory.c
   356  
   357          enc_init_data.transmitter =
   358                  translate_encoder_to_transmitter(enc_init_data.encoder);
   359          link->link_enc =
   360                  link->dc->res_pool->funcs->link_enc_create(dc_ctx, &enc_init_data);
   361  
   362          DC_LOG_DC("BIOS object table - DP_IS_USB_C: %d", link->link_enc->features.flags.bits.DP_IS_USB_C);
                                                                 ^^^^^^^^^^^^^^^^
Dereference

   363          DC_LOG_DC("BIOS object table - IS_DP2_CAPABLE: %d", link->link_enc->features.flags.bits.IS_DP2_CAPABLE);
                                                                    ^^^^^^^^^^^^^^^^

   364  
   365          if (!link->link_enc) {
                     ^^^^^^^^^^^^^^
Checked too late

   366                  DC_ERROR("Failed to create link encoder!\n");
   367                  goto link_enc_create_fail;
   368          }
   369  

regards,
dan carpenter
