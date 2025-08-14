Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D39FCA0ED1
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 09:34:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C50D010E296;
	Thu, 14 Aug 2025 09:34:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="j10+0Uch";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8F8E10E296
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 09:34:41 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4c2g7L3m33z9sWy;
 Thu, 14 Aug 2025 11:34:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755164078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=okkI2kHTvbnZxLesHnhlY8DgTTpkSdVSOQp1HZ0gOyk=;
 b=j10+0UchSl3FlS1z9XrPMq/NSv2cQHEK3qXCliabHubNc0f8GTlhoDud4O2RUeTJqsrG8i
 DuIoFVoBQnH7a63Nu51F588y23qdVrJ0tuh7VzGZ8t5t4BXXP8ozT/xFjS1G3kNiwTOu92
 3AOacZiWw46kppgnEJbLoJjYW4GiMcRlC7FVXDzEYyB+6NA9/3DDaL9R3qicqcryMigicS
 GW7kuyqAnqDgFc8ni4QwEoZybJie9+vtOJnvhMWQHaONXLAn73+gFfmtDxxLLu1iFJ8PxU
 4ZVz9NSn7iVTZCH+xak6H0I2B8fn14WolBrHHyZVsO3hCZql3/MFkOYv0H6oiQ==
Message-ID: <15b8f966-0d40-44c8-ab30-db34a6fc3400@mailbox.org>
Date: Thu, 14 Aug 2025 11:34:34 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v14 1/4] drm/amdgpu: Allow more flags to be set on gem
 create.
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
Cc: tvrtko.ursulin@igalia.com, Felix.Kuehling@amd.com, David.YatSin@amd.com,
 Chris.Freehill@amd.com, Christian.Koenig@amd.com, dcostantino@meta.com,
 sruffell@meta.com, mripard@kernel.org, tzimmermann@suse.de,
 Alexander.Deucher@amd.com
References: <20250813184953.3666821-1-David.Francis@amd.com>
 <20250813184953.3666821-2-David.Francis@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20250813184953.3666821-2-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tggcb4behfhanqnaytz5jbtw5pinmdn3
X-MBO-RS-ID: 94b8a4c668c95295dc0
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

On 13.08.25 20:49, David Francis wrote:
> AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE is a flag that
> specifies that gem memory contains sensitive information and
> should be cleared to prevent snooping.
> 
> The COHERENT and UNCACHED gem create flags enable memory
> features related to sharing memory across devices.
> 
> These should be settable in GEM_CREATE_IOCTL but weren't.

"Should be" is questionable, surely there were reasons for not allowing user space to use them so far.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
