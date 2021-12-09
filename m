Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FFDC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 17:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80001898C7;
	Thu,  9 Dec 2021 17:04:10 +0000 (UTC)
X-Greylist: delayed 426 seconds by postgrey-1.36 at gabe;
 Thu, 09 Dec 2021 08:09:53 UTC
Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7455E10E116
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 08:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
 t=1639037393; x=1670573393;
 h=mime-version:from:date:message-id:subject:to;
 bh=dwrzKGkrbhqPejgYMu3fnvpsPF6iyB3v31qaNN+PHyY=;
 b=Gf8+5ab4p9/3ojeogJe/D7TQXM41+XQaMoD/mqmc8MuCtUVNFeO/XjKW
 eeoomxosnXVWZs+MZzRTPeTbmXPntUNoUjlCKt+Pb3m9sg6tLqEOzYrYV
 8yKpFxCYXEsOGe00fSplfX3+r3WGBVj1e6JdnVmP/xZJP9K9sYLxwa+Pu
 EoVKSDuCqQLxQdEonB4oCW6DimnRrpJP7ASmlKZOBwqrqsgTe+dQBTSbC
 SlgYKGa2xQREGd68ZvNdANmTiKKyMlHyyWWms1Z7UiUd4f+jNM7wV16IB
 wKH029ygBZr0F4CDlerLjF4C427iuJ/9gcM0bmHlRFRfaBRQy7VctsgNH A==;
IronPort-SDR: /H1kYmmab2Yux1jzb83ZqrVTUGboMR5aGdq/fZfL2X/0nzhpUfxHtqXAYy5QgvYO5y3grfcdnv
 IhNDvcA+lXe1YkJ3GdHNat1PJ6lUi+g3/OvScoSYAOBnHtM3NS4Dh03pg07NrxjAbZ+n1A0hQT
 58E3PhO1a/TkqMGfon1g0Vg/0jTP61j2tuUPJqSRUQpW0QUB/zD/lHq8sLrtgQqCejFOyihZm6
 UZnJs/SlADcCCvudPadgQ+2aoEB2C8ocDe8jYovWdeRJyj1LjnpiEMxqBSqkxpxKO0pI0Fc1Fc
 F/vXhPF1tC/2TUAF8AK/fgVi
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; d="scan'208";a="89681206"
Received: from mail-yb1-f198.google.com ([209.85.219.198])
 by smtp-lax3-1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 09 Dec 2021 00:02:47 -0800
Received: by mail-yb1-f198.google.com with SMTP id
 v20-20020a25fc14000000b005c2109e5ad1so9151582ybd.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Dec 2021 00:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucr.edu; s=rmail;
 h=mime-version:from:date:message-id:subject:to;
 bh=FO/o6XGFp/MRxtI8YH+3dBjf/TITwRdxcsJH3FJWYro=;
 b=t1s2ln+KuTv0vtVTsi6EEL3lVej0+vwpB4bXYl9jV3T86wNpmmJtTG52CTYxRl2HX/
 C/lcRRU7m2gTCaF7HTTFo/7TB6k/6xHGoZF0MDRuMZBsPiKzcllb1pace3tKXOTIsKGF
 0AAzDKL8xUooJT9j0qaIzMnRMQAXSZG1x+96U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=FO/o6XGFp/MRxtI8YH+3dBjf/TITwRdxcsJH3FJWYro=;
 b=2kh9E9gy0CyZBLBZ0ASg5rxPM60emsm3TTP6MJ+oDLzNvNi2AFoscCIqF7GsHX102Q
 26w2g8Iu9Qwk5GAL9HSE+EurF4E4XMkgfo0s92q3c9jCJBssVJMVHbZ2BWn1atiiKPP6
 vYuABkLuwjvsL2RMjaR2A6VJLE8B7R5h6a62w5awhIIW3t+bmvRjVBAY4cCbHZw8zYd8
 gcmiYp1GU2+pSIn8W0egRtF9yVeHudp8WwfxefR72U3w1OJ1VxjQSA0NkPXcuWefHb57
 a7rP9Y2borLxEnMqWy2BXhfUJn96c39ici4fWZjCipW7lRlAJ3IXsdgWmzxMIhKqJDKJ
 1U0A==
X-Gm-Message-State: AOAM532mOhC0X0uYoxw5wmhX4kBVLb/IsO5lW4ZNREoY7zzx8uI7fn43
 EgKN3Q7CoJmn684mRfsGq2F71knWsixxV6jBqwsmsCLmctui4HhEeSTgfvOJcM/Kr0KGlZzcYs8
 /pi4Etfz8syYSSK7EepM9NWGidbDW62o84YJDF0dY9Yg=
X-Received: by 2002:a25:a2c1:: with SMTP id c1mr4713178ybn.473.1639036965954; 
 Thu, 09 Dec 2021 00:02:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyWWRUv7JLzhNaIKlyfA820bGMFiWGdwThJIEjD9Cqct6sVTBRUgx4hBb42/x//CxAoiIHHteaSuBGElRn+grI=
X-Received: by 2002:a25:a2c1:: with SMTP id c1mr4713143ybn.473.1639036965686; 
 Thu, 09 Dec 2021 00:02:45 -0800 (PST)
MIME-Version: 1.0
From: Yizhuo Zhai <yzhai003@ucr.edu>
Date: Thu, 9 Dec 2021 00:02:35 -0800
Message-ID: <CABvMjLSXpg00KKkqXH35C7Op0xC3mPaOAhj_xbAOEXL_4Ys_aw@mail.gmail.com>
Subject: Potential Bug in drm/amd/display/dc_link
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 09 Dec 2021 17:04:03 +0000
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

Hi All:
I just found a bug in the cramfs using the static analysis tool, but
not sure if this could happen in reality, could you please advise me
here? Thanks for your attention : ) And please ignore the last one
with HTML format if you did not filter it out.

In function enable_stream_features(), the variable
"old_downspread.raw" could be uninitialized if core_link_read_dpcd
fails(), however, it is used in the later if statement, and further,
core_link_write_dpcd() may write random value, which is potentially
unsafe. But this function does not return the error code to the up
caller and I got stuck in drafting the patch, could you please advise
me here?

The related code:
static void enable_stream_features(struct pipe_ctx *pipe_ctx)
{
     union down_spread_ctrl old_downspread;
    core_link_read_dpcd(link, DP_DOWNSPREAD_CTRL,
                         &old_downspread.raw, sizeof(old_downspread);

        //old_downspread.raw used here
        if (new_downspread.raw != old_downspread.raw) {
               core_link_write_dpcd(link, DP_DOWNSPREAD_CTRL,
                         &new_downspread.raw, sizeof(new_downspread));
        }
}
enum dc_status core_link_read_dpcd(
    struct dc_link *link,
    uint32_t address,
    uint8_t *data,
    uint32_t size)
{
        //data could be uninitialized if the helpers fails and log
some error info
        if (!dm_helpers_dp_read_dpcd(link->ctx,
               link,address, data, size))
                      return DC_ERROR_UNEXPECTED;
        return DC_OK;
}

The same issue in function wait_for_training_aux_rd_interval() in
drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
