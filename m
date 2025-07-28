Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831E6C83F17
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 09:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D58C410E0AE;
	Mon, 28 Jul 2025 09:28:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="TYrATnnR";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="TW1wHOjf";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C29EA10E004;
 Mon, 28 Jul 2025 09:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1753694891;
 bh=E6rsuWgmcWSsq6MFSzPB/9S
 Iu66iibZvC42qyD8fkoU=; b=TYrATnnRvaYfnIZ6Z5uFq9Yr/5n3v9PPCUlTbTzbHX7j1ghVmq
 vgqLDL2qaZlWyUTx5BlCWSbxVgFKbqPiVcOWlqFmo/ljfmmsRjSnPcGuQClKbVYPGfsRw1aAchS
 HNEXgeLWGEChfTRpB7JFiTv3dgaPjXRIPx9niYh52lI87SbyIrsnLuoYsBoObdX1Bwfds/LWj4U
 XhoH3eyRO6Ufrb/J1bxhO9LBn9uB7JwxaNN9u7I+g0xXo3Tl/9O627WJjI3ifwYE8/gzZ32ntQZ
 iuKiNm7Fixk6ZoSg5gtASgeNXfZTGLF4rbdTQUiM+XTRzfeQIRguEnDs218hgJo8c0w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1753694891; bh=E6rsuWgmcWSsq6MFSzPB/9S
 Iu66iibZvC42qyD8fkoU=; b=TW1wHOjf7j4Yq5lk5qlUiEwbvTzhDJFxj7tyd9exX+g4MLisyJ
 1RPhUpHU/qlyFo5ziqnzdwBB4fT8RamxSoAQ==;
Message-ID: <fe05e8fd-d56f-4b32-a65b-46c9ef6df9c7@damsy.net>
Date: Mon, 28 Jul 2025 11:28:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v7 10/12] drm/sched: Break submission patterns with some
 randomness
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Philipp Stanner
 <phasta@kernel.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20250724141921.75583-1-tvrtko.ursulin@igalia.com>
 <20250724141921.75583-11-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <20250724141921.75583-11-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



Le 24/07/2025 à 16:19, Tvrtko Ursulin a écrit :
> GPUs generally don't implement preemption and DRM scheduler definitely
> does not support it at the front end scheduling level. This means
> execution quanta can be quite long and is controlled by userspace,
> consequence of which is picking the "wrong" entity to run can have a
> larger negative effect than it would have with a virtual runtime based CPU
> scheduler.
> 
> Another important consideration is that rendering clients often have
> shallow submission queues, meaning they will be entering and exiting the
> scheduler's runnable queue often.
> 
> Relevant scenario here is what happens when an entity re-joins the
> runnable queue with other entities already present. One cornerstone of the
> virtual runtime algorithm is to let it re-join at the head and depend on
> the virtual runtime accounting to sort out the order after an execution
> quanta or two.
> 
> However, as explained above, this may not work fully reliably in the GPU
> world. Entity could always get to overtake the existing entities, or not,
> depending on the submission order and rbtree equal key insertion
> behaviour.
> 
> We can break this latching by adding some randomness for this specific
> corner case.
> 
> If an entity is re-joining the runnable queue, was head of the queue the
> last time it got picked, and there is an already queued different entity
> of an equal scheduling priority, we can break the tie by randomly choosing
> the execution order between the two.
> 
> For randomness we implement a simple driver global boolean which selects
> whether new entity will be first or not. Because the boolean is global and
> shared between all the run queues and entities, its actual effect can be
> loosely called random. Under the assumption it will not always be the same
> entity which is re-joining the queue under these circumstances.
> 
> Another way to look at this is that it is adding a little bit of limited
> random round-robin behaviour to the fair scheduling algorithm.
> 
> Net effect is a significant improvemnt to the scheduling unit tests which
> check the scheduling quality for the interactive client running in
> parallel with GPU hogs.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_rq.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/scheduler/sched_rq.c
> index d16ee3ee3653..087a6bdbb824 100644
> --- a/drivers/gpu/drm/scheduler/sched_rq.c
> +++ b/drivers/gpu/drm/scheduler/sched_rq.c
> @@ -147,6 +147,16 @@ drm_sched_entity_restore_vruntime(struct drm_sched_entity *entity,
>   			 * Higher priority can go first.
>   			 */
>   			vruntime = -us_to_ktime(rq_prio - prio);
> +		} else {
> +			static const int shuffle[2] = { -100, 100 };
> +			static bool r = 0;
> +
> +			/*
> +			 * For equal priority apply some randomness to break
> +			 * latching caused by submission patterns.
> +			 */
> +			vruntime = shuffle[r];
> +			r ^= 1;

I don't understand why this is needed at all?

I suppose this is related to how drm_sched_entity_save_vruntime saves a relative vruntime (= entity 
rejoins with a 0 runtime would be impossible otherwise) but I don't understand this either.

Pierre-Eric


>   		}
>   	}
>   
