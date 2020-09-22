Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57890C4727D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 20:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1742065D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 20:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1742065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettle.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ED796E33F;
	Tue, 22 Sep 2020 20:56:35 +0000 (UTC)
X-Greylist: delayed 305 seconds by postgrey-1.36 at gabe;
 Tue, 22 Sep 2020 20:56:32 UTC
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 968EC6E33F
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 20:56:32 +0000 (UTC)
Received: from bender.cb.ettle ([143.159.226.37]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.163]) with ESMTPSA (Nemesis) id
 1Mo6WJ-1knH3x4AqR-00pef0; Tue, 22 Sep 2020 22:51:23 +0200
Subject: Re: [PATCH] drm/amdgpu/dc: Pixel encoding DRM property and module
 parameter
To: Alex Deucher <alexdeucher@gmail.com>
References: <7cc7d590-f713-2060-6bac-37bed0df618a@ettle.org.uk>
 <CADnq5_OEzoEP93+MsGN1tspy0OrxVTkujKUhs+6LryVApvERkw@mail.gmail.com>
From: James Ettle <james@ettle.org.uk>
Autocrypt: addr=james@ettle.org.uk; prefer-encrypt=mutual; keydata=
 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
 EXgPHlt7bQ==
Message-ID: <286845a3-4903-c169-aa36-1eb986492ea3@ettle.org.uk>
Date: Tue, 22 Sep 2020 21:51:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_OEzoEP93+MsGN1tspy0OrxVTkujKUhs+6LryVApvERkw@mail.gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:s9W8QqSj7sbs5dBVNuDVWjDgWsHaw/IX911avYajhU38iWz7XRj
 1OJIuyOjAHeeQ01P0ZMxeeo16YlmIiY+AZJpMs1eBETbgvA60swQI01YGLqsyeliO1ReA8Q
 HuVlVTFlsCitVwWMF9udbWQyHuh4dqsinOWAwbyycf6BF5J8pbBoUnbCR9nzM06SwY7INwE
 WEqKKps0cvT3XwiWdgQ2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rDnqIm3HF44=:/ZRgD+dUsZWs3UYB+oJuKB
 //ZCc4CU7XVKdZckYOqEkjCFRqpAqmci2ueFKddTRjy72oYRAIR4W5HYlg82ox5rloo7SJk69
 iPvNBGfxFig2Inb+Tdn1g0rVS90YAbZDDZyeEmfRzdLnqOtX+gTY8cgiCCz8o5QddLllECbMj
 xXkuRfdKUWvOrg6WjVMzBdH3QRFbmc7urMEqPFhExhqj0eLEICaIKqi4xIoRDHJKStGEE93PQ
 EWXtLAPf4/MwOSB8/mz6QeFlakDt314YZkWaIQMej7dznifLVCwSNGMhwpVQ3xUGaJYxzUyLa
 nfgJzFksS2BRxaLWg7HOuzjVq3a86Q9wxeM+xvZ7vnpJ9g2nX3bBxlzvsiJqmaktbDmOI8tnd
 iSPaERBHie226O0M2SsWxJ6akFLxdj9F0WcUnALsreZKO5R4uIxpNjwgtMegcP0pAo8ppuxm+
 38rx0q+Js2Ymw2+V/NMpLPaxAmcBRCbdGJ8Ai4T7XulEbZlm3/BDz/Npi0MmQ5P+aBE0FtP3i
 +YPBFfB7MuErVREE8LwjhfBL1wgGcsi3Rk1mwHZjvZcsQQy7ht9jwjaMyQiS5sDMbUagDVa6P
 Z2f3EUyfwwlpP55RXihvj9SHg6TEK9ExOK5DZPzO2etWlcdvL+oDnfKQN43sC0o/hBZrg499Q
 0GEISk67PrSpxQFwKaobtXceIKnypQdtp80UWr3o3eMHGsxNj5oz/mIiTiVp5MZ3JJXUDHujB
 MRG9zSMSrEW2BErjRQMJtVIDb/Z/YmVJ/dGFgxGgWwzzKz+1uDnyj3d+ncTwBEkWv6WyzcpG7
 XXfis3yI1eKr5cruv2Vv3d/QSvOutAD6vw4MMG1+jX3eFk/0eun6GhprBzeKxgvi6Go8ckH
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
Cc: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 Harry Wentland <hwentlan@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 22/09/2020 21:33, Alex Deucher wrote:
>> +/**
>> + * DOC: pixel_encoding (string)
>> + * Specify the initial pixel encoding used by a connector.
>> + */
>> +static char amdgpu_pixel_encoding[MAX_INPUT];
>> +MODULE_PARM_DESC(pixel_encoding, "Override pixel encoding");
>> +module_param_string(pixel_encoding, amdgpu_pixel_encoding, sizeof(amdgpu_pixel_encoding), 0444);
> 
> You can drop this part.  We don't need a module parameter if we have a
> kms property.
> 
> Alex

OK, but is there then an alternative means of setting the pixel encoding to be used immediately on boot or when amdgpu loads? Also are there user tools other than xrandr to change a KMS property, for Wayland and console users? 

-James

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
