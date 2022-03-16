Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7635C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 15:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D65D10E239;
	Wed, 16 Mar 2022 15:59:39 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050::465:201])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47F6010E239
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 15:59:38 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4KJZj42mDRz9sZj;
 Wed, 16 Mar 2022 16:59:36 +0100 (CET)
Message-ID: <9586a6e1-2696-ad54-9737-d70ad19e03f8@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1647446374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rC9TSsU5s8FWHDnjtXufH/qfSiFduTClZOKkGCduZy4=;
 b=TxpKFiKzbhTpNP47IfjfiMsSTfuthTpHuE4M6UqCVyhEwl8jUxdIKCMKQIhgfeVB0vaWJN
 LQ7vzLooUi8mWutPY6ITdlo5Vubr+lKAkN/GEM5HfAZmu+9vxtpfqOoxj5NyHSNM0xFpv3
 5psXlQFTCfPFOv4pa6UEhOqVI4mIsZZyayjGBW9TGahuYAXulLcYP90eY0EV7aanwjix0a
 kHxNTZjwyy7DZ5VilgsbSebnyrWCLInzlRwBoxqO64J7nAaFTyes/kVnVMP8nS5Q5+ZggD
 3Cr7jjqcc172P379Wtr7/UCLMq+y1KkmidGw7NBoHPMRg0xY0tjWaj+diJunoQ==
Date: Wed, 16 Mar 2022 16:59:31 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdgpu/gmc: use PCI BARs for APUs in passthrough
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220315181300.2808453-1-alexander.deucher@amd.com>
 <c7e4568e-5bee-ab1c-cc4f-5985200f0fa8@gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <c7e4568e-5bee-ab1c-cc4f-5985200f0fa8@gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-03-16 08:18, Christian König wrote:
> Am 15.03.22 um 19:13 schrieb Alex Deucher:
>> If the GPU is passed through to a guest VM, use the PCI
>> BAR for CPU FB access rather than the physical address of
>> carve out.  The physical address is not valid in a guest.
>>
>> v2: Fix HDP handing as suggested by Michel
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> 
> Might be a good idea to have a function or macro to figure out if we should use the BAR or not on APUs.
> 
> Anyway patch is Reviewed-by: Christian König <christian.koenig@amd.com>.

And

Reviewed-by: Michel Dänzer <mdaenzer@redhat.com>


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer
