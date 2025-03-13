Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C59AC282DE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 22:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B064910E950;
	Thu, 13 Mar 2025 22:21:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="oP+FNxps";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE87710E950
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 22:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5SyRQNDJuPICgbWNGtk23VQCProjHDbstfGQrq3T6cE=; b=oP+FNxpsjHaaUGwVVOUxBmYsP/
 pGMlbcWqsL5iNPV3mL62ICBJ6llG7Fvqy9TIMg6dnr0khk3cvmVAwcjO5USAl1syuaOovNZpC3+RJ
 Gwnmy2tbl/Ih9vLXe+rC1Xy2Gin6JXp87vvkRWFC/Uocoa7DLZM+ZvVvhM/+qCIBTWkRjRLWw7EXN
 LGyDF0LqddFSSFKtsPqyGq2G3sU9rbXPZ9d0sVEES/lduSQkJMnhmTd5AWuUPgbO6ar5IVZBkXomb
 8ZpOjiC7jlsxIOq64/vUi0rX57P50t9Q1bYqyiIcMoCgRWhB3yegRrorHT5LS0J7lQoHP6nN91PUx
 IbeTrFeg==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tsqvr-008MTI-QV; Thu, 13 Mar 2025 23:21:45 +0100
Date: Thu, 13 Mar 2025 16:21:42 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH V5 00/11] Add disable kernel queue support
Message-ID: <6itqgifq2c2q3mo5uikvciog4n4ubviolciya5hgturekeykhd@rxzxgul5aqz7>
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313144136.1117072-1-alexander.deucher@amd.com>
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

n 03/13, Alex Deucher wrote:
> To better evaluate user queues, add a module parameter
> to disable kernel queues.  With this set kernel queues
> are disabled and only user queues are available.  This
> frees up hardware resources for use in user queues which
> would otherwise be used by kernel queues and provides
> a way to validate user queues without the presence
> of kernel queues.

Hi Alex,

I'm trying to understand how GFX and MES deal with different queues, and
I used this patchset to guide me through that. In this sense, could you
help me with the following points?

FWIU, the GFX has what are called pipes, which in turn have hardware
queues associated with them. For example, a GFX can have 2 pipes, and
each pipe could have 2 hardware queues; or it could have 1 pipe and 8
queue. Is this correct? 

(for this next part, suppose 1 pipe 2 hardware queues)
By default, one of the hardware queues is reserved for the Kernel Queue,
and the user space could use the other. GFX has the MES block "connected"
to all pipe queues, and MES is responsible for scheduling different ring
buffers (in memory) in the pipe's hardware queue (effectively making the
ring active). However, since the kernel queue is always present, MES
only performs scheduling in one of the hardware queues. This scheduling
occurs with the MES mapping and unmapping available Rings in memory to
the hardware queue.

Does the above description sound correct to you?  How about the below
diagram? Does it look correct to you?

(I hope the diagram looks fine in your email client; if not, I can
attach a picture of it.)

+-------------------------------------------------------------------------------------------------------------------------------------------+
|                                                           GFX                                                                             |
|                                                                                                                                           |
|                                                                               +-----------------------------+                             |
|           +---------------------------------------------+ (Hw Queue 0)        | Kernel Queue (No eviction)  +------- No MES Scheduling    |
|           |        (Hardware Queue 0)                   | ------------------->|                             |               |             |
|PIPE 0     |   -------------------------------------     |                     +-----------------------------+               X             |
|           |        (Hardware Queue 1)                   |                                                        +----------+---------+   |
|           |   -------------------------------------     |--+                                                     |                    |   |
|           |                                             |  |                  +----------------------------+     |                    |   |
|           +---------------------------------------------+  | (Hw Queue 1)     |                            |     |   MES Schedules    |   |
|                                                            +----------------> |  User Queue                +-----+                    |   |
|                                                                               |                            |     |                    |   |
|                                                                               +----------------------------+     |                    |   |
|                                                                                                                  +--------------------+   |
|                                                                                                                            |              |
|                                                                                      +-------------------------------------+              |
|                                                                                      |Un/Map Ring                                         |
|                                                                                      |                                                    |
+-------------------------------------------------------------------------------------------------------------------------------------------+
                                                                                       |                                                     
                                                                 +---------------------+--------------------------------------------+        
                                                                 |   MEMORY            v                                            |        
                                                                 |                                                                  |        
                                                                 |                                                                  |        
                                                                 |  +----------+                                                    |        
                                                                 |  |          |  +---------+         +--------+                    |        
                                                                 |  |    Ring 0|  | Ring 1  |  ...    | Ring N |                    |        
                                                                 |  |          |  |         |         |        |                    |        
                                                                 |  +----------+  +---------+         +--------+                    |        
                                                                 |                                                                  |        
                                                                 |                                                                  |        
                                                                 +------------------------------------------------------------------+        

Is the idea in this series to experiment with making the kernel queue
not fully occupy one of the hardware queue? By making the kernel queue
able to be scheduled, this would provide one extra queue to be used for
other things. Is this correct?

I'm unsure if I fully understand this series's idea; please correct me
if I'm wrong.

Also, please elaborate more on the type of tasks that the kernel queue
handles. Tbh, I did not fully understand the idea behind it.

Thanks

> 
> v2: use num_gfx_rings and num_compute_rings per
>     Felix suggestion
> v3: include num_gfx_rings fix in amdgpu_gfx.c
> v4: additional fixes
> v5: MEC EOP interrupt handling fix (Sunil)
> 
> Alex Deucher (11):
>   drm/amdgpu: add parameter to disable kernel queues
>   drm/amdgpu: add ring flag for no user submissions
>   drm/amdgpu/gfx: add generic handling for disable_kq
>   drm/amdgpu/mes: centralize gfx_hqd mask management
>   drm/amdgpu/mes: update hqd masks when disable_kq is set
>   drm/amdgpu/mes: make more vmids available when disable_kq=1
>   drm/amdgpu/gfx11: add support for disable_kq
>   drm/amdgpu/gfx12: add support for disable_kq
>   drm/amdgpu/sdma: add flag for tracking disable_kq
>   drm/amdgpu/sdma6: add support for disable_kq
>   drm/amdgpu/sdma7: add support for disable_kq
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |   4 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |   9 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  |  30 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c  |  26 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |   1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 191 ++++++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 183 +++++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |   2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c   |   2 +-
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   |  16 +-
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   |  15 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |   4 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |   4 +
>  17 files changed, 345 insertions(+), 155 deletions(-)
> 
> -- 
> 2.48.1
> 

-- 
Rodrigo Siqueira
