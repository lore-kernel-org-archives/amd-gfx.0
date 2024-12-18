Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46019E77187
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2024 18:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC56110E352;
	Wed, 18 Dec 2024 18:09:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jmdwTf2R";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 068F910E352
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2024 18:09:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 604B7A4273F;
 Wed, 18 Dec 2024 18:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D649C4CECD;
 Wed, 18 Dec 2024 18:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1734545340;
 bh=MKn7tx70E7Zta8f49WhpOqa+40htXcaNf6+dSCs6yH0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jmdwTf2RpkGRVnsDOiIEDfmLur/4WprwwADTl2WmEGNVuVKB6uWS/UG6gB4kLRF0y
 dwTD9ntK44qECEyciLVv9ex3hmp01mpEnv8nRjTPPFoQ9U7TgIs2ZSBnRSgNuFmhSp
 hOhuz2N1PwDlKKvKg+RPGOx3PW2H2zeOr3e31BGuMQu3xgCp7+dPbJd2UrdlcWNt28
 hweCI2lbqN0mTlb91Ao0XFEPjUgrTjSnSn0XxdmJMTkTHTFlmH71CM9MqJ+2EDZEGp
 GQVA/DCB7VdraeMNIrmdKwZS9F0s9j/wJnMVtTfWwIkBspOHKmln0m+0dTgISDKNgj
 LfDcRthnvyLiA==
Date: Wed, 18 Dec 2024 08:08:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, Chris Rankin <rankincj@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org
Subject: Re: [WARNING][AMDGPU] WQ_MEM_RECLAIM with Radeon RX 6600
Message-ID: <Z2MPu9oQNdXXhJkc@slm.duckdns.org>
References: <CAK2bqVJXY2CkR4Od2bj8wnYYfzZCpFYhaiPAcwpw0Uk7zXUVkg@mail.gmail.com>
 <CADnq5_OYjnFhVnQmVLQ7ucSYLm4NZ_wmRnLSOfJQzY33VQZ+EA@mail.gmail.com>
 <Z2DG+OcTIDPBGmdK@lstrano-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2DG+OcTIDPBGmdK@lstrano-desk.jf.intel.com>
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

Hello, sorry about the delay.

On Mon, Dec 16, 2024 at 04:34:00PM -0800, Matthew Brost wrote:
> > However, after further discussion, I think the warning is actually a
> > false positive.  See this discussion:
> > https://lists.freedesktop.org/archives/amd-gfx/2024-November/117349.html
> > 
> > From the thread:
> > "Question is - does check_flush_dependency() need to skip the
> > !WQ_MEM_RECLAIM flushing WQ_MEM_RECLAIM warning *if* the work is already
> > running *and* it was called from cancel_delayed_work_sync()?"
> > 
> 
> See my reply just now [1] — I’m going to have to disagree with AMD's
> assessment, but I’m not certain.
> 
> Again, I believe Tejun is the authority here.

I think we can skip the warning if the flushing is coming from
cancel*_work_sync() as flush takes place iff the work item already has a
worker running - ie. it can't be blocked from lack of memory. Tvrtko, can
you write up a patch to exclude the condition from check_flush_dependency()?
I think it can just skip check_flush_dependency() when @from_cancel is set.

Taking a step back, if an actual dependency develops in the future - memory
reclaim actually blocking on gpu work items, one way to handle that would be
adding subsystem-wide workqueues so that the rescuer can be shared across
GPU drivers / devices. As long as they don't depend on each other for making
forward progress, which they most likely wouldn't, sharing a rescuer across
them is completely fine.

Thanks.

-- 
tejun
