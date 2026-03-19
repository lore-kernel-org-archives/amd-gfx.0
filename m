Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D96108E1E5
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 10:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B823C10E977;
	Thu, 19 Mar 2026 10:47:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="W5bKvOej";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98BB310E977
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 10:46:59 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fc2Sb52gjz9tWh;
 Thu, 19 Mar 2026 11:46:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773917216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nMjfiTkWtIlmam4KWcCADsNEqWFMi/wxF+2HAHlKb20=;
 b=W5bKvOejce5ICQD3ZxcJajmbDYAO+LVA7BnIzIijqtDK2D8AFJgYw0pGDlg4iePnKF/sqw
 t6s5GdLAF7c6BxK7SffDOVoUkIZIiYY8BEZmTuDHeXk99oZ0OHP2dtAbKztY2Aii1qB/vS
 7MV6Zx1Ft7kkwt3CW7Wu2IPdZKm8VRvgE5R5rRq7uuv1uh2N3/Nqp5k2qBRmwm5CQ0bt29
 sB9A8/B/a6oy7RGSr0dkJTJdLDgNZZmNVjvgIGTEvQM4qJx6lizBUnftLYyc29IJtL8AbO
 /AWq+7oKvXPKhPtPSGa/n42ktDltcV5FAT+4c/EkYQgrVi7o+eF70g4dlERNMQ==
Message-ID: <f6526ba3-91a0-4407-94f6-a34176587b40@mailbox.org>
Date: Thu, 19 Mar 2026 11:46:52 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] Revert "drm/amdgpu: harden SIGNAL/WAIT ioctl argument
 validation"
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Liang, Prike" <Prike.Liang@amd.com>,
 "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Olsak, Marek" <Marek.Olsak@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260318074708.2078535-1-sunil.khatri@amd.com>
 <dfca1bb0-26dd-45bd-ac11-c3756ce808ac@amd.com>
 <48df3b31-724a-4548-a52b-9f034664d422@amd.com>
 <DM4PR12MB5152791EDD4F7021198821E3E34EA@DM4PR12MB5152.namprd12.prod.outlook.com>
 <2e6d0e34-e093-41a9-a4b3-59afe3050dfc@amd.com>
 <PH7PR12MB6000DAD5B8EFDBCB3F3F4663FB4FA@PH7PR12MB6000.namprd12.prod.outlook.com>
 <PH7PR12MB6633BABDE8B0785EF6ADA694FF4FA@PH7PR12MB6633.namprd12.prod.outlook.com>
 <PH7PR12MB6000366C1E6582CD02D90AD6FB4FA@PH7PR12MB6000.namprd12.prod.outlook.com>
 <74e768dc-d4a1-445b-b699-e837a1d20234@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <74e768dc-d4a1-445b-b699-e837a1d20234@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8fd649aa0c3998ff695
X-MBO-RS-META: k5n5h4m941wq7jepw4ods9iymq5abiar
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

On 3/19/26 08:30, Christian König wrote:
> Hi guys,
> 
> well when mesa leaves some fields in the structure uninitialized then that is a pretty bad idea and we should eventually fix that.
> 
> But always setting the pointers to valid arrays and just setting the number of array elements to zero is perfectly valid.
> 
> That doesn't even needs a debug message.

As discussed recently for another patch, the "(How to avoid) Botching up ioctls" page of the kernel documentation says under Basics:

* Check all unused fields and flags and all the padding for whether it’s 0, and reject the ioctl if that’s not the case.

That seems to apply here, i.e. the kernel should have these checks and Mesa should initialize the pointer field to 0 when the corresponding num_* field is.


P.S. I agree it probably doesn't make a practical difference in this specific case. I suspect the rule is aimed at when the ioctl struct is extended, in which case Mesa's current behaviour would be indistinguishable from user-space code which actually doesn't properly initialize the newly-added fields.

It seems safer to stick to the rule even in cases like this where it's not strictly required.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
