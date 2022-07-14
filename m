Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F710C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 19:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EAC91132C0;
	Thu, 14 Jul 2022 19:05:04 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 497531132C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 19:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cNkR6XEDFfpaPNq9o0wRHS/X8IzmQvqoBCtGIQHTiTQ=; b=CEnQ651qlIikjfQXm55Yxkox20
 T4IXbOyOg9argMlCQFjGe15yorkHCCcfK4E0OROtw2CmvcKpFpuS5d1T7Erg3GBbWRmRPW9Fxu9VU
 E2t+DSloqGzYXGlcOtBYvRdMvs9+NHqaOGf514X6AIqrUGh6pPUhf6iIrb+UBuh99tuEt0oVEZaKg
 J0DDpiard6KR7P0hDrXrRuQlqC3j8RttWMCwgV6Ij5mCTUXI+H4yRDkMWoOgtjROZ/j6vEM0VeLYz
 LXs1KkCov+y52SGVWIRM7s+8EerGINDReA/s3Q1pkpia4AlJIVQPDAlAGFA0vlbx5q1cfUy6Xq/04
 G5AGi1LQ==;
Received: from [177.139.47.106] (helo=[192.168.15.109])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1oC48r-00GknE-QL; Thu, 14 Jul 2022 21:04:54 +0200
Message-ID: <92eebfd3-4234-b3fa-87cc-c48b3deec33f@igalia.com>
Date: Thu, 14 Jul 2022 16:04:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/12] drm/amdgpu: Write masked value to control register
Content-Language: en-US
To: =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
References: <20220714164507.561751-1-mairacanal@riseup.net>
From: =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20220714164507.561751-1-mairacanal@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: magalilemes00@gmail.com, David Airlie <airlied@linux.ie>,
 tales.aparecida@gmail.com, Xinhui.Pan@amd.com,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, mwen@igalia.com,
 Leo Li <sunpeng.li@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Maíra,

Thank you for your patch,

Às 13:44 de 14/07/22, Maíra Canal escreveu:
> On the dce_v6_0 and dce_v8_0 hpd tear down callback, the tmp variable
> should be written into the control register instead of 0.
> 

Why? I do see that tmp was unused before your patch, but why should we
write it into this register? Did you manage to test this somehow?

> Fixes: b00861b9 ("drm/amd/amdgpu: port of DCE v6 to new headers (v3)")
> Fixes: 2285b91c ("drm/amdgpu/dce8: simplify hpd code")

Checking both commits, I can see that 0 is written at `mmDC_HPD1_CONTROL
+ N` register in _hpd_fini() in them, so if you are trying to fix the
commit that inserted that behavior, I think aren't those ones. For instance:

$ git show 2285b91c

[...]

@@ -479,28 +372,11 @@ static void dce_v8_0_hpd_fini(struct amdgpu_device
*adev)
        list_for_each_entry(connector, &dev->mode_config.connector_list,
head) {
                struct amdgpu_connector *amdgpu_connector =
to_amdgpu_connector(connector);

-               switch (amdgpu_connector->hpd.hpd) {
-               case AMDGPU_HPD_1:
-                       WREG32(mmDC_HPD1_CONTROL, 0);
-                       break;
-               case AMDGPU_HPD_2:
-                       WREG32(mmDC_HPD2_CONTROL, 0);
-                       break;
-               case AMDGPU_HPD_3:
-                       WREG32(mmDC_HPD3_CONTROL, 0);
-                       break;
-               case AMDGPU_HPD_4:
-                       WREG32(mmDC_HPD4_CONTROL, 0);
-                       break;
-               case AMDGPU_HPD_5:
-                       WREG32(mmDC_HPD5_CONTROL, 0);
-                       break;
-               case AMDGPU_HPD_6:
-                       WREG32(mmDC_HPD6_CONTROL, 0);
-                       break;
-               default:
-                       break;
-               }
+               if (amdgpu_connector->hpd.hpd >= adev->mode_info.num_hpd)
+                       continue;
+
+               WREG32(mmDC_HPD1_CONTROL +
hpd_offsets[amdgpu_connector->hpd.hpd], 0);
+

0 was the valued written here before this commit. The commit basically
replaces the switch case with a sum in this snippet.

thanks,
	andré
