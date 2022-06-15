Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A889CCA47B
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jun 2022 08:35:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FD8610F1AD;
	Wed, 15 Jun 2022 08:35:41 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43B2B10E94F
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 08:35:40 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4LNJXm5Bqtz9sZP;
 Wed, 15 Jun 2022 10:35:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1655282136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xm4fgaRru4dzEvjhwxr8MimpEawTkmo1P615vrl4qys=;
 b=fEZWCxZbz6IjIkNJu1NH7KR/01mZ5pN43SRIAopD8Jpq7i2iU+/bdnT3LaF4VmtQzErDX8
 FKvfVedcbVGFHgAVUfd6jC7TjxKp/5ixLblpy0DHZkyQJcwJ0hnzSJ86nRBgJOzSmMAPJe
 GeIm1L5ZfKyJiGr/RscDHzFZIMTh/gdV9PswP/nFO214dhzc9+IJv4L5tGN2zTeezVsFPb
 ratujNwZflUShfra6yZDH7ndVhP36VFFa1Cm20VJWsj+tBlrKXKL3g1SHZXdgJpiZC69hv
 Fxsjfi8P3DDEslClMNJYyfdgK7Fhz4xBDviD2vVR6GHPAEsRkNJ1BzE2ki/VtA==
Message-ID: <c861e442-e09b-fe20-609c-05bdcb867663@mailbox.org>
Date: Wed, 15 Jun 2022 10:35:35 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/radeon: Add build directory to include path
Content-Language: en-CA
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
To: Masahiro Yamada <masahiroy@kernel.org>
References: <20220413161450.1854370-1-michel@daenzer.net>
 <f425b789-5081-fa70-555f-7553d7cc5bd5@gmail.com>
 <ca5ca8ab-9c48-8d81-2dd6-fbdfface6519@mailbox.org>
 <abd87438-3ff4-6b62-81b4-6162d167348a@gmail.com>
 <CADnq5_Npy02mWVMOs-TMQ9t6OLV8XFaSQFZ5iB=Y2q3OQgiQvw@mail.gmail.com>
 <fe499d20-2667-5953-831a-d7668c5a3d18@mailbox.org>
 <CAK7LNATdTaY6+FD4TuFgmb00=Qbx=7mmCi9onHv0zi=pdZysBQ@mail.gmail.com>
 <8beac4f5-f7e8-31ab-bbf3-36a917979bfc@mailbox.org>
In-Reply-To: <8beac4f5-f7e8-31ab-bbf3-36a917979bfc@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a3467709dafe0001700
X-MBO-RS-META: o8y3bn756pjdf71b8nzpptrcgezm3n8f
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-04-14 18:57, Michel Dänzer wrote:
> On 2022-04-14 17:04, Masahiro Yamada wrote:
>> On Thu, Apr 14, 2022 at 10:50 PM Michel Dänzer
>> <michel.daenzer@mailbox.org> wrote:
>>> On 2022-04-14 15:34, Alex Deucher wrote:
>>>> On Thu, Apr 14, 2022 at 4:44 AM Christian König
>>>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>>>> Am 14.04.22 um 09:37 schrieb Michel Dänzer:
>>>>>>
>>>>>>   make -C build-amd64 M=drivers/gpu/drm
>>
>>
>> Maybe
>>
>>         make  O=build-arm64   drivers/gpu/drm/
>>
>> is the way you were searching for.
>>
>> It builds only drivers/gpu/drm/
>> in the separate directory.
> 
> Indeed, that works.

I've come to realize that this doesn't produce the actual *.ko modules though. Is there a trick for building the modules, but only under drivers/gpu/drm/ ?


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer
