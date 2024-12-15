Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C18E7716A
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Dec 2024 23:37:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFC2710E0BC;
	Sun, 15 Dec 2024 23:37:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=froggi.es header.i=joshua@froggi.es header.b="pBJr88jB";
	dkim-atps=neutral
X-Greylist: delayed 903 seconds by postgrey-1.36 at gabe;
 Sun, 15 Dec 2024 23:37:12 UTC
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com
 [136.143.188.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E22210E0BC
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Dec 2024 23:37:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1734304928; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lqKDMJM3HczVHt3W3JLuY2TBIHvNCKEAHT/lWRiExs2oRrkzsKyjsJZ4YtGHteRbeEcPLq7zSWcRkGBWHj5cjR6fR8QvOCI4qtTk0WtEDz79zwRcFDw+c5jxPMnb2HzYV88vpUOPIvmwkp8Qhz6E+KiYVcIWXDPoM8e3811l7ME=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1734304928;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=qoORXBcvEE0DmdymcphfTBiBXl2V6NMOLo0LqmFURd8=; 
 b=m5XDfvL8ZEuRVG5ci1rxuW92jRQ64IhZjv3Iw5o9KDeULyqRARgKLlB3V5xFUwwvDDp9E7+0aH3FMuD8LNl+fP3Y1BPfn9iwGwjYEsxstPCCZdBW+h0q11rREYhYdiH55HGQSuKl+rSH+JUKQB86ma7cjNzCfhkYc5xT3e4sJIc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=froggi.es;
 spf=pass  smtp.mailfrom=joshua@froggi.es;
 dmarc=pass header.from=<joshua@froggi.es>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734304928; 
 s=mail; d=froggi.es; i=joshua@froggi.es;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=qoORXBcvEE0DmdymcphfTBiBXl2V6NMOLo0LqmFURd8=;
 b=pBJr88jBH+PG49pk8kpw1MusYzZ0BfthdpxB47DwWj1AXtrU3kHUqX7DDKU15D7m
 /tP8pKaePLbPifV5xt3SrTbvYZSKk3IawHKjVreB/jL2R7hhLYlbqRLcswLzgXiXIcL
 Ln/2OoDblwGhV3c33AOvwS3HbnXTOqrseUprGxfQ=
Received: by mx.zohomail.com with SMTPS id 1734304925464175.30877196570975;
 Sun, 15 Dec 2024 15:22:05 -0800 (PST)
Message-ID: <972c14f7-bf6f-450f-92c5-3f2b8390eac8@froggi.es>
Date: Sun, 15 Dec 2024 23:22:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/fourcc: add LINEAR modifiers with an exact pitch
 alignment
To: amd-gfx@lists.freedesktop.org
References: <CAAxE2A5BkF13bFt8_UnuiqPM8W-ZESgmKEjqqGfv=DGzSfJ7aQ@mail.gmail.com>
 <CAAxE2A77j94VNp33VhO97n3db_fZz1zUpM_VUPfkt96_Dzu9Bg@mail.gmail.com>
Content-Language: en-US
From: Joshua Ashton <joshua@froggi.es>
In-Reply-To: <CAAxE2A77j94VNp33VhO97n3db_fZz1zUpM_VUPfkt96_Dzu9Bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

You should just re-send the whole patch, probably.

On 12/15/24 8:54 PM, Marek Olšák wrote:
> Missed 2 lines from the diff:
> 
> +#define DRM_FORMAT_MOD_LINEAR_PITCH_ALIGN_128B fourcc_mod_code(NONE, 2)
> +#define DRM_FORMAT_MOD_LINEAR_PITCH_ALIGN_256B fourcc_mod_code(NONE, 3)
> 
> Marek
> 
> On Sun, Dec 15, 2024 at 3:53 PM Marek Olšák <maraeo@gmail.com 
> <mailto:maraeo@gmail.com>> wrote:
> 
>     The comment explains the problem with DRM_FORMAT_MOD_LINEAR.
> 
>     Signed-off-by: Marek Olšák <marek.olsak@amd.com
>     <mailto:marek.olsak@amd.com>>
> 
>     diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/
>     drm_fourcc.h
>     index 78abd819fd62e..8ec4163429014 100644
>     --- a/include/uapi/drm/drm_fourcc.h
>     +++ b/include/uapi/drm/drm_fourcc.h
>     @@ -484,9 +484,27 @@ extern "C" {
>        * modifier (e.g. not setting DRM_MODE_FB_MODIFIERS in the
>     DRM_ADDFB2 ioctl),
>        * which tells the driver to also take driver-internal information
>     into account
>        * and so might actually result in a tiled framebuffer.
>     + *
>     + * WARNING:
>     + * There are drivers out there that expose DRM_FORMAT_MOD_LINEAR,
>     but only
>     + * support a certain pitch alignment and can't import images with
>     this modifier
>     + * if the pitch alignment isn't exactly the one supported. They can
>     however
>     + * allocate images with this modifier and other drivers can import
>     them only
>     + * if they support the same pitch alignment. Thus,
>     DRM_FORMAT_MOD_LINEAR is
>     + * fundamentically incompatible across devices and is the only
>     modifier that
>     + * has a chance of not working. The PITCH_ALIGN modifiers should be
>     used
>     + * instead.
>        */
>       #define DRM_FORMAT_MOD_LINEAR  fourcc_mod_code(NONE, 0)
> 
>     +/* Linear layout modifiers with an explicit pitch alignment in bytes.
>     + * Exposing this modifier requires that the pitch alignment is exactly
>     + * the number in the definition.
>     + */
>     +#define DRM_FORMAT_MOD_LINEAR_PITCH_ALIGN_64B fourcc_mod_code(NONE, 1)
> 

- Joshie 🐸✨

