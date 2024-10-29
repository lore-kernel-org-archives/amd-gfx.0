Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFBBD5B172
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 09:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E88110E0DD;
	Tue, 29 Oct 2024 09:02:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=oriole.systems header.i=@oriole.systems header.b="uXTldACC";
	dkim-atps=neutral
Received: from coleridge.oriole.systems (coleridge.oriole.systems
 [89.238.76.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D8C310E0DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 09:02:48 +0000 (UTC)
Date: Tue, 29 Oct 2024 10:02:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oriole.systems;
 s=canary-202303; t=1730192566;
 bh=I5CpmtB2qnXFPQxNl0i3Q4xcPqwsAMkyLqnWSsGKRZ8=;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:In-Reply-To:From:Sender:Reply-To:Subject:Date:
 Message-Id:To:Cc:Mime-Version:Content-Type:
 Content-Transfer-Encoding:In-Reply-To:References;
 b=uXTldACCcNlVUabVOHQOoklI75MTCGb0A3FRGumMrvAkO8RGlyLVGljLEdjKuP7HP
 RSOz6RJCRv6fDyqbHpSKc8wXE/gZOydc/LWskIRGy/iILyBBOx65PY6i4IqlFIecoc
 +a8i7sCSzLw34cKcRYsmiTiKXwORgf7gB4mjnwq/huABWF4YkiI8Za1Edmlqdesm6+
 ojE0oqfmPURDOMjueyCtf4af0TkLf/JSa5VsJkoYGaZ85lGHU6ItFB7AKLw+7pdIUE
 sKrQjofFb1wBxIlJp2SJsByTveJZKV8YQhhLc8Z9K6WtxPumSukbDk9Oyg2OMfMH/R
 aVJ0sA+HT/8Xg==
From: Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [RFC PATCH] drm/amd/pm: add zero RPM OD setting support for SMU13
Message-ID: <3h6ntuiiltyzizfh4ghz73vuer7mps42hpsykfqli2ist6ot46@mcigulkqtd65>
Mail-Followup-To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, 
 Alex Deucher <alexdeucher@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20241019143706.18779-1-wolf@oriole.systems>
 <CADnq5_MvJET2hk0aeTbUTEvUb57-figFbfPfNvfsjsTuSY0ing@mail.gmail.com>
 <BL1PR12MB51587D600285FD9B64734ED78E4B2@BL1PR12MB5158.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BL1PR12MB51587D600285FD9B64734ED78E4B2@BL1PR12MB5158.namprd12.prod.outlook.com>
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

On 2024-10-29 02:52, Feng, Kenneth wrote:
> However, I think it would be better to add the setting of
> OverDriveTable.FanZeroRpmStopTemp for this interface.
> OverDriveTable.FanZeroRpmStopTemp determines if the fan can stop when
> the temperature is below this temperature setting(in the condition
> that zero RPM is enabled).
> It makes this interface more advanced. OverDriveTable.FanZeroRpmEnable
> and OverDriveTable.FanZeroRpmStopTemp are a pair to be arbitered in
> pmfw.

Sure, that sounds good to me. I'll add a second commit implementing
this. With two settings now exposed I also think it'd be better to
rename the knob from fan_zero_rpm to fan_zero_rpm_enable. Makes its
purpose a whole lot clearer and is in line with the name in
OverDriveTable.

I'll send v2 along with these changes sometime today. Thanks for the
feedback!

-- 
Wolf
