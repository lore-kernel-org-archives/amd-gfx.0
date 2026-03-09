Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B0AFCC9DE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 08:25:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F8C810E671;
	Tue, 10 Mar 2026 08:25:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=rcpassos.me header.i=@rcpassos.me header.b="FlRg53Ft";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="FDoDkzN7";
	dkim-atps=neutral
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F12B10E578
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 17:39:51 +0000 (UTC)
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256;
 b=FlRg53Ft6ECxGY7/cH9IZFRkLpOho9TNC7qBFQ5Vt9V7onbxGT2XAZJH0i+fPmqWZhtFb6cpbJ8TliTSTdPLct/NHATPUURmbQvov571dpNQ4GN+0ts+iuj442hCMGqxt38JAb2wSM27oi6ooMg8Y4FEqofqOS3Ohh10/D3Dzs/OcNYB1X+LP3vU61tItgqO2U5jqTHlGuK/99IVvWZnTdeC5UD8u8cQ8+NhuiZePQ0EFlPP6BoykbJcKURu+pB/qK79qx90baQexV+GyAkQZXZPPAFmapuxrz+nQea2fFU5AZ9OYEXPtUryysZPQSrUUOXVhOeq7c5HsWQeExjUTQ==;
 s=purelymail1; d=rcpassos.me; v=1;
 bh=Nlt9ZlUnem0nHwCNxypxZITEYOAA+eaDAoiG67rhNPQ=;
 h=Received:Date:Subject:From:To; 
DKIM-Signature: a=rsa-sha256;
 b=FDoDkzN7l/sh/Oyhgzd8ql2IlJaDFMEzV04UcPD3E2WYsXJA6F4Tjikg8LNMkJ1dL+OgdJno2cAyiZYjuDtvd7D4/fkELg7eFChjC0EQ7d8zgoIzfRqAavAuRAuXefajZL0GQ0JsTuJ/AOCd9d936Gk4O8w4PAcbLSZZFP5UhhTxAlfg40DikbiM+zamlMl/gJCcXk26A6JA5J+4BgMd4i6Qbt7C9CsTOWWHTyRHB/OyxNzFexnMqein5afxeDP2V6mvtO92sbYgdZ2igBG9VJchhhNO6TAaeKAszM2yQ+Odhs7gTLwfLobTTE44oFmt/gwDeF2LNb1jBX9TVTGWeQ==;
 s=purelymail1; d=purelymail.com; v=1;
 bh=Nlt9ZlUnem0nHwCNxypxZITEYOAA+eaDAoiG67rhNPQ=;
 h=Feedback-ID:Received:Date:Subject:From:To; 
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: amd-gfx@lists.freedesktop.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 731850662; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 09 Mar 2026 17:39:40 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Mar 2026 14:39:37 -0300
Message-Id: <DGYFOPUHXIGF.2EDRA79D54GF5@rcpassos.me>
Subject: Re: [PATCH] drm/amd/display: fix resuming from S3 sleep for Renoir
 iGPU
From: "Rafael Passos" <rafael@rcpassos.me>
To: "Leo Li" <sunpeng.li@amd.com>, "Rafael Passos" <rafael@rcpassos.me>,
 <alexdeucher@gmail.com>
Cc: <BhuvanaChandra.Pinninti@amd.com>, <Harry.Wentland@amd.com>,
 <Martin.Leung@amd.com>, <alexander.deucher@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <daniel.wheeler@amd.com>,
 <davidbtadokoro@ime.usp.br>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <ray.wu@amd.com>, <rcpassos@ime.usp.br>,
 <siqueira@igalia.com>, "Ivan Lipski" <IVAN.LIPSKI@amd.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <CADnq5_Msmohg3T5KLrqPwvJGbXPOMKeNN-ZcqgTS2pHb+GjuYQ@mail.gmail.com>
 <20260308000515.890688-1-rafael@rcpassos.me>
 <ad3244e8-96a0-4d60-9047-cc20720c6dd2@amd.com>
In-Reply-To: <ad3244e8-96a0-4d60-9047-cc20720c6dd2@amd.com>
X-Mailman-Approved-At: Tue, 10 Mar 2026 08:25:11 +0000
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

On Mon Mar 9, 2026 at 2:02 PM -03, Leo Li wrote:
> Hi Rafael,
>
> Thanks for bisecting and identifying the root cause. A fix has been submi=
tted here:
> https://lore.kernel.org/all/20260306031932.136179-14-alex.hung@amd.com/
>
> Additionally, the offending change missed updating register definitions, =
which was
> fixed here:
> https://lore.kernel.org/all/20260306031932.136179-10-alex.hung@amd.com/
>
> - Leo

Hi Leo,

Thanks for replying.
We missed that patch, since there is no reference to the report.
I understand the implementation ended up differently, and our patch is not
going forward. But at least we came to the same conclusions. :)

If I could ask, at least a
"Reported-by: Rafael Passos <rafael@rcpassos.me>"
tag would be nice, given the effort put into this.

Either way, thank you.

- Rafael Passos
