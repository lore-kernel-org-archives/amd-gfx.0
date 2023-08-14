Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31EAC001B0
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Aug 2023 10:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B3A010E191;
	Mon, 14 Aug 2023 10:11:48 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6625C10E196;
 Mon, 14 Aug 2023 10:11:47 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RPVYW6kb9z9shD;
 Mon, 14 Aug 2023 12:11:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692007903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eRmekkgzYD+ywS0c9zPB8cc4nrdPTbQZm63uTZVZSHY=;
 b=f/y5bHDQs/AO8BpFCZNWo7L/AsZywOE2HEm/AqCzLvcmVXHVMGdlco5KE914O1JLyjeYyF
 NoFl/bJ4tWra/C9n/n1aPlEtl0GH1dybmNgAsRR4TOxlab2robBUY+DPICkg5K/S7w9amB
 WcKYL78aLdy4nJTCmTQzykXyNwBPRYKH4MGHWOYVBhMGSca8ABOYIpyHMHv7jcrnYsZi5i
 pOQPpC1TfXqdEH2BnE/tIym4UtA3tE5yatUp2yrQ+RjSH27vMqm4C+XZMhzTzhbh9MwJBC
 16CHfuyFFUgmWAJhwkdLnsPrRvRKeZX7M5P6l/wuP2yrrOD88Ginp/62eIy7qw==
Message-ID: <8e560379-4bdc-a3f0-591a-435833bfacda@mailbox.org>
Date: Mon, 14 Aug 2023 12:11:35 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v6] drm/doc: Document DRM device reset expectations
Content-Language: de-CH-frami, en-CA
To: =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20230811185508.252194-1-andrealmeid@igalia.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20230811185508.252194-1-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qjyhhe5pbxmotxcc3nc413xfdj3mkqrm
X-MBO-RS-ID: 1b65540c5e13e99182b
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
Cc: pierre-eric.pelloux-prayer@amd.com,
 =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
 =?UTF-8?Q?Timur_Krist=c3=b3f?= <timur.kristof@gmail.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Samuel Pitoiset <samuel.pitoiset@gmail.com>,
 Pekka Paalanen <ppaalanen@gmail.com>, kernel-dev@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 8/11/23 20:55, André Almeida wrote:
> Create a section that specifies how to deal with DRM device resets for
> kernel and userspace drivers.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>

[...]

> +Robustness
> +----------
> +
> +The only way to try to keep an application working after a reset is if it
> +complies with the robustness aspects of the graphical API that it is using.

"The only way to try to keep a graphical API context working after a device reset [...]"

If a graphical API context stops working properly, it doesn't necessarily mean that the application as a whole stops working.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

