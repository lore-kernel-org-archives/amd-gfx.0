Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D39C07E9D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 16:24:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DA2210E979;
	Tue, 27 Sep 2022 16:24:45 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9416D10E979
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 16:24:40 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4McQ1v60SCz9sTt;
 Tue, 27 Sep 2022 18:24:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1664295875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HOBkfOewK9VSW4ZTFKBTwzKk2v72RxkKpb8lJnI+KGc=;
 b=T5A7DwNJ7OhsjGA6PUhcErb9MvH2PJEjXr7qDe2Sba+X/C9f7domGjpxgaJoI1+zbXHx+v
 rlAu/J5skE6Jg6Y2bEO5EG37F4t3w6qyaIxumeoGox2WjxtrLWrCih51K3c4TtolVi6sGC
 KucDNy/uV+4jpQjHfmLISR5ZFWoCGuAargj9owcyHgwReyI1kUW7LWbSpj6RD2oHEx4DYu
 8JEGNo6IwJN5jiC3IXxJ+4O0GLH3m5/qr+Y+tbNodNtHG2rB/rmptavfdgWKIW3KqfH13f
 NzZfQAMG6oQzNKJ8tYD8sNWHt5jAIkXOhdJRH9+6rKzoPWZgEbIC7fitnqNM6Q==
Message-ID: <1b549873-106d-1e93-7f77-4a3966828b9c@mailbox.org>
Date: Tue, 27 Sep 2022 18:24:34 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/5] GPU workload hints for better performance
Content-Language: en-CA
To: Shashank Sharma <shashank.sharma@amd.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20220926214014.5450-1-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b7639e25cdc0625d2ed
X-MBO-RS-META: 38eggadkti9bfohtkdr1mi6p4gqykw3o
X-Rspamd-Queue-Id: 4McQ1v60SCz9sTt
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com,
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-09-26 23:40, Shashank Sharma wrote:
> AMDGPU SOCs supports dynamic workload based power profiles, which can
> provide fine-tuned performance for a particular type of workload.
> This patch series adds an interface to set/reset these power profiles
> based on the workload type hints. A user can set a hint of workload
> type being submistted to GPU, and the driver can dynamically switch
> the power profiles which is best suited to this kind of workload. 
> 
> Currently supported workload profiles are:
> "None", "3D", "Video", "VR", "Compute"
> 
> V2: This version addresses the review comment from Christian about
> chaning the design to set workload mode in a more dynamic method
> than during the context creation.
> 
> V3: Addressed review comment from Christian, Removed the get_workload()
>     calls from UAPI, keeping only the set_workload() call.
> 
> Shashank Sharma (5):
>   drm/amdgpu: add UAPI for workload hints to ctx ioctl
>   drm/amdgpu: add new functions to set GPU power profile
>   drm/amdgpu: set GPU workload via ctx IOCTL
>   drm/amdgpu: switch GPU workload profile
>   drm/amdgpu: switch workload context to/from compute

Where are the corresponding Mesa changes?


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

