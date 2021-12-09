Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF02AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 17:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46E0810E154;
	Thu,  9 Dec 2021 17:04:13 +0000 (UTC)
X-Greylist: delayed 426 seconds by postgrey-1.36 at gabe;
 Thu, 09 Dec 2021 06:48:01 UTC
Received: from mx6.ucr.edu (mx.ucr.edu [138.23.62.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D018C89226
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 06:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
 t=1639032486; x=1670568486;
 h=mime-version:from:date:message-id:subject:to;
 bh=PLtxLRbtG7A4GNXTBJJWn+LmhB2lQF+WbvK+FdtW/M4=;
 b=XcFreqVV32HZCQHeybDQdCHDJKDiflvn+IEhK5s3n+K2Ao7CD87Qk0V6
 BDkK365ZKCt5KitI5x9P+XJs58NdfqC1jTpEGOdBLNPECyLw9BxbeCu38
 2UztBdSV+BcUOvB/sT9U5uz6mNEPYQ9IVExaSks4o10m8wwkIdYMqz4Bk
 V8OyF695qZRF8oFgwVGcxiXWS0Zc7RZ0oy/HNdGoItLF/gjhPxShnTbBV
 xB/05QhdH7HBeGlB0Ckb++5wM7BsY0E9cNhHnvWjMjyqAeZcr2qBbFrkt
 jxbgdVe2Iz08zaH5YnnhLvD2gpPojDiIoT8LAPPSpni+FfspXCST2xBu0 w==;
IronPort-SDR: 3ciGfg/on2997wm3emTbxyBBD5UwswuSjc7231t4br074zQM2kcnZcZL2fKk86ymHgGtV5qmYL
 at0BhHzJP0z9blDts0MjyZayRUKdiwCQSaDOyOe3bwu59EGJERsj8soAmE0Nc9dxOHnchrjLJC
 nVtSPyElORfzozUgYS+xXyNho4nTvP+i+uLoWnXTn9F345Hy++Uh73FUOUke0gr0LfOY64CpHF
 FkCT1IbQAPoexovTfSDCR8jEW6F9Hs9H+4KZyutX+fVREzGHEvLvEn9B1CKBdMKr4tdQgP9XKJ
 ODtGOGzuwq23k8xHJ0M5ckcy
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; 
 d="scan'208,217";a="265380147"
Received: from mail-yb1-f197.google.com ([209.85.219.197])
 by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 08 Dec 2021 22:40:55 -0800
Received: by mail-yb1-f197.google.com with SMTP id
 y17-20020a2586d1000000b005f6596e8760so8815365ybm.17
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Dec 2021 22:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucr.edu; s=rmail;
 h=mime-version:from:date:message-id:subject:to;
 bh=s0o4sTGOBE7bP7GZEjPZHpdt1VBOUdd6uyrnR77d+EY=;
 b=v5cjBofIN0w17uRT8vmLtt5L9LTTL2AZEDBNEcwcAmkbhx8dL9A596vcVxfa7dW8U2
 38HTPdDKSciz9J7nEwquKD51Xn/KBKUQd+UCasJReInPi/9OIMxnuyoQGHclHav7fM6z
 5ZS+paLkQe1LTZMGPbzR5DL+aJKQXzpLZ/m+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=s0o4sTGOBE7bP7GZEjPZHpdt1VBOUdd6uyrnR77d+EY=;
 b=SY9Q9cquUTdQL2fkSHMdCz5MCu5H5qrjCHS5d7frLeiU806P+3w1Iz3KpE8CN97Uhg
 TmIuddUsR43UVUeWoewWVn3a0AsD5eHGZGXD8xgrD1Ez60pCKNiQ1aBttq+Cx4sJDKM1
 EMAO9pZMa4UqkDTMSz3Bw1fTTDRmy2RW75ZpZchlY7pg7r+V/Ao4guJYex0u86byWfqv
 NcL6xWgamfEON450mr0I4jgcV/UuqyA05xBET8LkfZml99fxCTAXV9oG+AGnUen0hYnG
 QkQLyd5c5JBpxMDmzJZNMTLyUMLyBiUJsMBlQYYrKucPKZal8NtCOyRrbuPFu8h0lMb+
 5gOQ==
X-Gm-Message-State: AOAM531Cl9OfdMvJ4MIY6cAiv/7OvYpbVueDVHWdsETkMUEG7oLXNbFg
 6asvTPX0t6JNFxz53OOo4lq5pGHdwTMxtgfiqG1zlbcaa8do+lQq6v/rOK9GL+CNfv4/4NnXkBh
 s6/zIt5Qq86KSgkQPad+EUNHkswObpOOK4whUQtGSb1k=
X-Received: by 2002:a25:516:: with SMTP id 22mr4305252ybf.294.1639032051935;
 Wed, 08 Dec 2021 22:40:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybju9fJBpj5JXp7EQcFTm/UZyp9V77drW+toFmu2m+Mzn1TSvi5X/UFyqz1UJhapoU2tunkcwH/Vy/ER67gUU=
X-Received: by 2002:a25:516:: with SMTP id 22mr4305236ybf.294.1639032051735;
 Wed, 08 Dec 2021 22:40:51 -0800 (PST)
MIME-Version: 1.0
From: Yizhuo Zhai <yzhai003@ucr.edu>
Date: Wed, 8 Dec 2021 22:40:41 -0800
Message-ID: <CABvMjLRJjzeCiCcLg_cxVfcxr5UkAwmou-OZ3i0EVVhAxJF9JQ@mail.gmail.com>
Subject: A Potential Bug in drm/amd/display/dc_link.c
To: harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, 
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/alternative; boundary="0000000000003835d005d2b0e374"
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

--0000000000003835d005d2b0e374
Content-Type: text/plain; charset="UTF-8"

Hi All:
I just found a bug in the cramfs using the static analysis tool, but not
sure if this could happen in reality, could you please advisehere? Thanks
for your attention : )

In function enable_stream_features(), the variable "old_downspread.raw
<https://elixir.bootlin.com/linux/v4.18-rc1/source/drivers/gpu/drm/amd/display/dc/core/v4.18-rc1/C/ident/raw>"
could be uninitialized if core_link_read_dpcd fails(), however, it is used
in the later if statement, and further, core_link_write_dpcd() may write random
value, which is potentially unsafe. But this function does not return the
error code to the up caller and I got stuck in drafting the patch, could
you please advise me here?

The related code:

static void enable_stream_features(struct pipe_ctx *pipe_ctx)
{
	union down_spread_ctrl old_downspread;
	core_link_read_dpcd(link, DP_DOWNSPREAD_CTRL,
		&old_downspread.raw, sizeof(old_downspread);


        //old_downspread.raw
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
			link,
			address, data, size))
			return DC_ERROR_UNEXPECTED;

	return DC_OK;
}


-- 
Kind Regards,

*Yizhuo Zhai*

*Computer Science, Graduate Student*
*University of California, Riverside *

--0000000000003835d005d2b0e374
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All:<div>I just found a bug in the cramfs using the sta=
tic analysis tool, but not sure if this could happen in reality, could you<=
span class=3D"gmail-Apple-converted-space">=C2=A0</span><span class=3D"gmai=
l-il">please</span><span class=3D"gmail-Apple-converted-space">=C2=A0</span=
><span class=3D"gmail-il">advise</span>here? Thanks for your attention : )<=
/div><div><br></div><div><span style=3D"color:rgb(0,0,0);font-family:Arial;=
font-size:13px;white-space:pre-wrap">In function=C2=A0</span><span style=3D=
"color:rgb(0,0,0);font-family:Arial;font-size:13px;white-space:pre-wrap">en=
able_stream_features(), the variable</span><font face=3D"arial, sans-serif"=
><span style=3D"color:rgb(0,0,0);white-space:pre-wrap"> &quot;</span><span =
class=3D"gmail-n" style=3D"color:rgb(0,0,0);box-sizing:inherit">old_downspr=
ead</span><span class=3D"gmail-p" style=3D"box-sizing:inherit;color:rgb(102=
,102,102)">.</span><span class=3D"gmail-n" style=3D"color:rgb(0,0,0);box-si=
zing:inherit"><a href=3D"https://elixir.bootlin.com/linux/v4.18-rc1/source/=
drivers/gpu/drm/amd/display/dc/core/v4.18-rc1/C/ident/raw" style=3D"box-siz=
ing:inherit;text-decoration-skip:objects;color:inherit;text-decoration:none=
;background-image:linear-gradient(rgba(0,0,0,0) 10%,rgb(244,246,255) 10%,rg=
b(244,246,255) 90%,rgba(0,0,0,0) 90%);border-top-left-radius:0.2em;border-t=
op-right-radius:0.2em;border-bottom-right-radius:0.2em;border-bottom-left-r=
adius:0.2em">raw</a></span><span style=3D"color:rgb(0,0,0);white-space:pre-=
wrap">&quot; </span></font><span style=3D"font-size:13px;color:rgb(0,0,0);f=
ont-family:Arial;white-space:pre-wrap">could be uninitialized i</span><span=
 style=3D"font-size:13px;color:rgb(0,0,0);font-family:Arial;white-space:pre=
-wrap">f core_link_read_dpcd fails(), however, it is used in the later if s=
tatement, and further, core_link_write_dpcd() may write </span><span style=
=3D"color:rgb(0,0,0);font-family:Arial;font-size:13px;white-space:pre-wrap"=
>random value, which is potentially unsafe. But this function does not retu=
rn the error code to the up caller and I got stuck in drafting the patch, c=
ould you please advise me here?</span></div><div><span style=3D"color:rgb(0=
,0,0);font-family:Arial;font-size:13px;white-space:pre-wrap"><br></span></d=
iv><div><span style=3D"color:rgb(0,0,0);font-family:Arial;font-size:13px;wh=
ite-space:pre-wrap">The related code:</span></div><div><pre style=3D"color:=
rgb(51,51,51);margin-top:0px;margin-bottom:0px;line-height:16.25px">static =
void enable_stream_features(struct pipe_ctx *pipe_ctx)
{
	union down_spread_ctrl old_downspread;
	core_link_read_dpcd(link, DP_DOWNSPREAD_CTRL,
		&amp;old_downspread.raw, sizeof(old_downspread);</pre><pre style=3D"margi=
n-top:0px;margin-bottom:0px;line-height:16.25px"><span style=3D"color:rgb(5=
1,51,51)">
        //<span style=3D"font-family:Arial,Helvetica,sans-serif">old_downsp=
read.raw</span>
	<span style=3D"color:rgb(0,136,0);font-weight:bold">if</span> (new_downspr=
ead.raw !=3D old_downspread.raw) {
		core_link_write_dpcd(link, DP_DOWNSPREAD_CTRL,
		&amp;new_downspread.raw, sizeof(new_downspread));
	}
}
enum dc_status core_link_read_dpcd(
	struct dc_link *link,
	uint32_t address,
	uint8_t *data,
	uint32_t size)
{
        //data could be uninitialized</span><font color=3D"#333333"> if the=
 helpers fails and log some error info</font></pre><pre style=3D"margin-top=
:0px;margin-bottom:0px;line-height:16.25px"><font color=3D"#333333">	</font=
><span style=3D"color:rgb(0,136,0);font-weight:bold">if</span><font color=
=3D"#333333"> (</font><font color=3D"#333333">!dm_helpers_dp_read_dpcd(link=
-&gt;ctx,
			link,
			address, data, size))
			</font><span style=3D"color:rgb(0,136,0);font-weight:bold">return</span>=
<font color=3D"#333333"> DC_ERROR_UNEXPECTED;

	</font><span style=3D"color:rgb(0,136,0);font-weight:bold">return</span><f=
ont color=3D"#333333"> DC_OK;
}</font></pre></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_s=
ignature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><span style=
=3D"font-size:14px">Kind Regards,</span><div style=3D"font-size:14px"><br><=
div><font face=3D"arial, helvetica, sans-serif" size=3D"2"><b>Yizhuo Zhai</=
b></font></div></div><div style=3D"font-size:14px"><br></div><div style=3D"=
font-size:14px"><b>Computer Science, Graduate Student</b></div><div style=
=3D"font-size:14px"><b>University of California, Riverside=C2=A0</b></div><=
/div></div></div>

--0000000000003835d005d2b0e374--
