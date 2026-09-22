Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35242C982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 07:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8AED10E430;
	Tue, 22 Sep 2026 07:56:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2AXtrI7g";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010055.outbound.protection.outlook.com [52.101.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0E7E10E422
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 07:56:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BU0fGr7L7lv6F+wYT1LzViPTz7LwnNkdTc30geTmdTJQg/E3GbO+XT64P8Is5TL2XzyX/nTZqFdCr+AmxmCQZjHwkt1lKk06fewQmHzySbCL3kmjYt3N+iQ6oH9jIJ2WpIm61JYVOiVcMmfUlYWbM3Q1xz2NCHy5Wau1gru51l1TE9rBuEXSBHG7VyDedgQjwS3j9Eh4rygq5TsWx+wSkxkKso0MQ0uFrm5+UAL35nklMR6g2I2nuFCwlwV3P3ZPn5yJ+4MN2JGrgQWZmayb+psaFK1nCIbRuzU0euKuQyjOvF4TJrzZR0ZCfIOKygEzcSWIX+qDp8ga8Z+IsHSJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtjIKLAh6gHk6M+38sbDtK/wPy8wxS2hJI2WmE9F7LY=;
 b=q0GSt2TJiPRcUHe4xpeiOzA70uoLalZrshqjfb3u/oZKdR8Ajj5wtOqfnN9r6HJNCGalnWM7MnLi+PVzjfY3yej8pSMJ4+ybveUDcYp7N3Ku+BWZ+BFgoNaZw2t9XiCo55EXyp+UfCsDFLTbY0YbP23CSX/84BpK1PqsiSqwXonP40hZIFf1QvfBU+PyduvDA8egX4sR9473huNmliPdfLKcOMdIOyLG0JeGfnzECdINkkm/h3Duv7xhAzcoi8KKbtaXPnEkAoDHsa+Kd7NtmM6joCOjWZBq28V/tMBMAiBFeB7FKuQSqwRHZeKFHy8V9ZI/inBNrbW2gmylBJqP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtjIKLAh6gHk6M+38sbDtK/wPy8wxS2hJI2WmE9F7LY=;
 b=2AXtrI7grb5YDge2xwGomi/+dFaPwDLHsLcRQxhpTPBaq4xQacmwagQd2vqbmBIglTknnJlC/hNfBYJ1mzXHuLUtlvIOvGkDV4lrWF5j49wOfup8YPnRENge03wQX3EqrQ6V5kzZy8yH1R9MW5WV3L6fzAjlHiWau0fQwSuwzrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA5PPF37951B1C9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c6) by DSAPR12MB820198.namprd12.prod.outlook.com
 (2603:10b6:8:51d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 07:56:07 +0000
Received: from SA5PPF37951B1C9.namprd12.prod.outlook.com
 ([fe80::2ebe:b9c2:13f5:89fb]) by SA5PPF37951B1C9.namprd12.prod.outlook.com
 ([fe80::2ebe:b9c2:13f5:89fb%8]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 07:56:07 +0000
Date: Tue, 22 Sep 2026 15:55:48 +0800
From: Huang Rui <ray.huang@amd.com>
To: Christian KKKnig <christian.koenig@amd.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@amd.com>, Alexander.Deucher@amd.com,
 felix.kuehling@amd.com, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 01/10] drm/amdgpu: introduce
 amdgpu_lookup_queue_by_doorbell
Message-ID: <arI0hEYQbrsWVlV1@amd.com>
References: <20260828095349.9797-1-lingshan.zhu@amd.com>
 <20260828095349.9797-2-lingshan.zhu@amd.com>
 <bd072438-32ee-42bc-bc06-ae29775cc2a5@amd.com>
 <2687ad99-61da-457f-9705-766bf48b2d04@amd.com>
 <a46a12b8-d9df-4995-beaf-6d41150196bc@amd.com>
 <a34a1541-7f3a-4e0f-a225-f58b1292d6d2@amd.com>
 <5f576123-9f57-4da0-a6d5-fd0390e39f1b@amd.com>
 <f0d163a6-49cb-47d2-a042-d0e37bb7cdce@amd.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0d163a6-49cb-47d2-a042-d0e37bb7cdce@amd.com>
X-ClientProxiedBy: TP0P295CA0055.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::11) To SA5PPF37951B1C9.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA5PPF37951B1C9:EE_|DSAPR12MB820198:EE_
X-MS-Office365-Filtering-Correlation-Id: a4519e14-8584-464d-b06c-08df187ef57f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PU85ixQnj6okhPG9oqZdlM8W67ZWCOKTwRlF0FIxmxkoOQ2Sfy6DQl9dOxF2lqGsKb9AN5JyahWIqbkichG9C0olTSUSzmST0SZ0NgxyJnMIR+WXte9H3Tjkt/uN+4bkIWQb4pJ9ezXOuJdH2Irj0v26m9FTNeL/ZLqzbCJJ6GMT6tc0ioScPf/N0wfd/InjOVth60BYB5DdcGfNdo3/5dLX7YZMNxeqFZ1vy7a4+4b4MzgY7bV/IKgmq5mFj9s3Tj2zYRHPQ/SbUHSI1rMNVBqDL2/bEc1VJ2etK0x20rsAnfzZXGVMp0qLQSSZHJp3i+XtsZX0d2y7ObLcON8RCfc1lqynCtvUG3Su/061utMrS0Z3otb1Wq2c8vfKCis1IHejpHZpNOu4+x71kGal0j5PJQkY7Bjn0yr5DU8A7bCH2jSzBBvSEiGV8sZtIZ6cAb2FDI0ldr67x+H8dwNe+7UyeWZSohALGEgMfVQR4wrkNUySHMGZtW2bFmsf1OwtfasR1j4L9Coc5jkl38FbzAx6v9fKeqRj5qW5Ucly8Dch5qbNfcVzuPFItsggcS5jx3QcRcT59lD3LIkB3B6n7mzx7lb/PNe/bhaxoTQCyUeJAuz3R8muFJwwFD1/sgYli+jdVlH13Nz91NJRzBNePtg6WJuH0EvD+WZp7Qon1F4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA5PPF37951B1C9.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?eQ7P1DGYVJQq2l9ouOoRnd0IlDYJXOnfB1GCHPKJAMrgcxj+p97e1fWcUZ?=
 =?iso-8859-1?Q?OFAlMWdyhVR9lHkhlhKhIq8/m3waFkVbY36FRlGqEqswf6n9rZEvSmX4tQ?=
 =?iso-8859-1?Q?71ZN5QVYJJVaLKTMowW+aV6agTe8QWpu+TXPsqVAmqlkc2nMDkBxvrlGdZ?=
 =?iso-8859-1?Q?d5cll3OXVbfjgyfZJQxEEdLokJ4yw+kLZbEeHJzA/xdicn7iFUlvMnh0NG?=
 =?iso-8859-1?Q?Qa6Wnljv0S/RIgIAEowRMpuWgG4N8n2tox2BOGHN2ZMeImM2suetK9qv5n?=
 =?iso-8859-1?Q?oc47zfq1zma/9Likc+8FFJ49Dtm+zqb8umj4ZfxhU1rnhihgiDgS1DA/NM?=
 =?iso-8859-1?Q?Ipt3hvWtwTRCBylxWRUk213Ij6ruatcmheAgIMGmuhMgb7pcy3BpVdrr9f?=
 =?iso-8859-1?Q?SY2NS5jhIjUggxo5vHMnXmN0v3zUFXHFtVQzdcO2rdyVO/CcMpfmjWRWU4?=
 =?iso-8859-1?Q?RccRSGOEwetZCvPD2+dQyPXbiGAjfM+owWGUxvrIn3jwaKk8etoyf5W/f6?=
 =?iso-8859-1?Q?9UBkH0nDdfU/FNOF9ezP1sGqNCIGPKWl149YY/OA/aO+iL7Wy8Jgqegs4v?=
 =?iso-8859-1?Q?JEKzvmoMdkRR+ie7Sicz+GbOXmtyDjjLKVvCF1aaTGg09sFfcNZa0tWHr+?=
 =?iso-8859-1?Q?WLL1jWeGtLLPgEzCQhHC1zv3aYjimMXA4rfzEQf3rfmkMsFTtcC2CjNrOd?=
 =?iso-8859-1?Q?74M0O6oItnjyDNusB7WNG5CxqD7AyObCAvEIxmNhl9cPSvI562C920tTxd?=
 =?iso-8859-1?Q?mK8N457jEfwTtLtCOalto6Se+lOr3d6P1Wodve/rP2M4IMDD2IiL0dOfg3?=
 =?iso-8859-1?Q?/AxdOm3JxSf2qgoAGk4F2Rw5aRG95pi7WHPNo9bXN4HpwzmaU11CAZrDP/?=
 =?iso-8859-1?Q?m8nXLllJmKvu4rghQ1iIC3BqwLei4bPeaeeR90m0mbV5EsBFlIEYHOFmvK?=
 =?iso-8859-1?Q?K5u6c7teq/Hb6gNzp+WLoxPsX8hFZfltBc0nawYN+6c3qYcyZ/XBq/4KTX?=
 =?iso-8859-1?Q?oDVB04VnRJ3aWm6AKWadQwGOnZatQiFuvTmzMik03hiuc0zX4KWPc9oMyr?=
 =?iso-8859-1?Q?b+AM6h0Tm8LT9rtHkw6JP9wbuksL/Bait9WAlUb2oj8lXJ/ATRGyRF0qyq?=
 =?iso-8859-1?Q?atYvRUPmweqVtJTcsafAp3NFy1NpBrZ6I0ABeTqrXJth0niKoOZB1J3+wa?=
 =?iso-8859-1?Q?8MlW8R9UgK3Zu8sJsgcsnaRPYRSRWPIe/lsvhDXJyrzMD6eoYvCHs5yscs?=
 =?iso-8859-1?Q?eZnAQj/MmNtiNwzIdv/GdAXorALigBVbvmRaQvDYF1XCK/1OJps997+n8v?=
 =?iso-8859-1?Q?qRAZgUCytnKzB4rZP0qxeMtoKQTzjL/JodxaG5VyIpIgSOuCQxXOTKGO7s?=
 =?iso-8859-1?Q?1G43ZEAyYW3gWHyG/QPz6fC5w3N1lwuTYMOcjjKvME4LTEilJjE0y2C/Ld?=
 =?iso-8859-1?Q?Ia07u36x6zH9s6yAjOAAtrFrX23+vz946ffG/ZljCWbqU6GsBLfW0ZfYhE?=
 =?iso-8859-1?Q?W9AhYgRynuQCcEERDb/AUQCHeUYLVnW6aUAs0epXHI4uI5H0HsYV5niruh?=
 =?iso-8859-1?Q?mv7ybwoiwFeYaUvaBHldGTT68s5p1RMpdk7Zvmqifb/fuMy7tOiT5OCEq6?=
 =?iso-8859-1?Q?B6oxarjWMOsa7lJMIpUarR6jHLbYpWyQyF7x+vopgyMunccn4qFeVoGF3f?=
 =?iso-8859-1?Q?miozRSpKYXjIygX9I+fS2VroxJOUxaSuOmOM4doJMVa3Lkvbaetlx3/2yA?=
 =?iso-8859-1?Q?6oNbzUPWjTDDieXiPdimjno9vQL1Z9tR33HEGj31xus83mkttz2eL8a3EG?=
 =?iso-8859-1?Q?dtWf2tSQSA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4519e14-8584-464d-b06c-08df187ef57f
X-MS-Exchange-CrossTenant-AuthSource: SA5PPF37951B1C9.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 07:56:07.5879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJRdPpVEBIq/fTgc6+q7Eu+6AeGRLMLPePkV7u21Dd88yl6XW4SnWqziY5+grhMjuT08SXy62ncZO63JwkIG5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSAPR12MB820198
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

On Tue, Sep 22, 2026 at 09:35:29AM +0200, Christian KKKnig wrote:
> On 9/22/26 08:08, Zhu, Lingshan wrote:
> > On 9/1/2026 4:50 PM, Zhu, Lingshan wrote:
> > 
> >> On 8/31/2026 4:21 PM, Christian König wrote:
> >>
> >>> On 8/28/26 17:59, Zhu, Lingshan wrote:
> >>>> On 8/28/2026 9:08 PM, Christian König wrote:
> >>>>
> >>>>> On 8/28/26 11:53, Zhu Lingshan wrote:
> >>>>>> This commit introduces a new helper
> >>>>>> amdgpu_lookup_queue_by_doorbell which helps
> >>>>>> look up a user queue with the given doorbell id
> >>>>>> in a xarray.
> >>>>>>
> >>>>>> This function takes a kref of the user space queue.
> >>>> Hello Christian
> >>>>
> >>>> Thanks for your comments.
> >>>>
> >>>>> Well absolutely clear NAK to the whole approach.
> >>>>>
> >>>>> This is the nonsense Sunil and I have worked quite hard to remove and we certainly shouldn't repeat such mistakes.
> >>>>>
> >>>>> When the userq needs to be used from interrupt context we need to hold the xa_lock_irqsave() or otherwise we don't have any guarantee that the userq, userq_mgr or associated fpriv went out of scope.
> >>>> Holding the spin lock by xa_lock_irqsave() can surely avoid racing with the destruction process, however, it does not apply to all scenarios, for example, you can not hold spin lock in mes_userq_reset_queue(),
> >>>> because it calls either amdgpu_mes_reset_queue_mmio or amdgpu_mes_reset_queue_mmio, both of them acquire the MES mutex through amdgpu_mes_lock.
> >>> Yeah which is exactly the reason why mes_userq_reset_queue() should *NOT* be called from non IOCTL context.
> >> I think it is not about whether called from IOCTL, it is a common racing we should fix, and holding a kref is a low haning fruit.
> >>
> >>>> Another thing, out of the topic is, holding xa_lock does not guarantee fpriv/userq_mgr alive, for example, when drm_device->unplugged is true, all amdgpu teardown paths in amdgpu_drm_release are skipped,
> >>>> and the fpriv/userq_mgr is freed, no matter whether holding the xa spin lock.
> >>> That would clearly be a massive bug. Those objects still need to be cleaned up independent of device hot plug.
> >> I agree, when unplugged == true, means can not access any HW registers, so this bug deserve another series to fix.
> >>
> >>>> So IMHO since we have userq->kref, lets use it to maintain the lifecycle of the queues. 
> >>>>
> >>>>> Grabbing references from this side would obviously result in circle dependencies.
> >>>> I am not sure, we should use the lock/unlock and kref_put/get in pairs in sequence, can you name some circle dependencies or AB-BA lockings as examples?
> >>> That is not AB-BA locking, but circle dependencies. E.g. A reference B, B referencing C, C referencing A again.
> >> A kref is an atomic counter, not a lock, that means we can try hold more than one kref in a thread, and a kref not
> >> depend on another. As far as I can see, current amdgpu driver does not have such problems, do you see any occurrences?
> > 
> > Hello Christian,
> > 
> > I have not heard back from you for three weeks, I wonder whether you have any further comments for this series,
> > or shall I make any improvements?
> 
> Well just completely drop that series. As I said this approach is a fundamental no-go from my side.
> 
> As far as I can see we have solved the problems at hand and the rules how to handle the user queues should be pretty clear by now.
> 

Assuming every kref_get() has a matching kref_put(), and the queue object
itself does not participate in a circular ownership chain, I don't
immediately see how taking a temporary queue reference would cause
correctness issues.

Could you please point us to the historical issue or the corresponding
commits that led to removing this approach previously?

Thanks,
Ray

> Regards,
> Christian.
> 
> > 
> > Thanks
> > Lingshan 
> > 
> >> Thanks
> >> Lingshan
> >>
> >>> Regards,
> >>> Christian.
> >>>
> >>>> Thanks
> >>>> Lingshan
> >>>>
> >>>>> Regards,
> >>>>> Christian.
> >>>>>
> >>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> >>>>>> ---
> >>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 30 +++++++++++++++++++++++
> >>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
> >>>>>>  2 files changed, 32 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> >>>>>> index 0a816b3c5ff9..e0639f844a8e 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> >>>>>> @@ -609,6 +609,36 @@ struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr,
> >>>>>>  	return queue;
> >>>>>>  }
> >>>>>>  
> >>>>>> +/**
> >>>>>> + * amdgpu_lookup_queue_by_doorbell - look up a user queue by doorbell
> >>>>>> + * @xa: user queue XArray indexed by doorbell
> >>>>>> + * @doorbell: doorbell index
> >>>>>> + *
> >>>>>> + * Return: A queue with the doorbell indexed, or NULL if no such a queue found.
> >>>>>> + *
> >>>>>> + * This function increases kref of the queue, the caller
> >>>>>> + * must release the reference with amdgpu_userq_put().
> >>>>>> + */
> >>>>>> +struct amdgpu_usermode_queue *
> >>>>>> +amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell)
> >>>>>> +{
> >>>>>> +	struct amdgpu_usermode_queue *queue;
> >>>>>> +	unsigned long flags;
> >>>>>> +
> >>>>>> +	xa_lock_irqsave(xa, flags);
> >>>>>> +	queue = xa_load(xa, doorbell);
> >>>>>> +	if (!queue)
> >>>>>> +		goto out_unlock;
> >>>>>> +
> >>>>>> +	if (!kref_get_unless_zero(&queue->refcount))
> >>>>>> +		queue = NULL;
> >>>>>> +
> >>>>>> +out_unlock:
> >>>>>> +	xa_unlock_irqrestore(xa, flags);
> >>>>>> +
> >>>>>> +	return queue;
> >>>>>> +}
> >>>>>> +
> >>>>>>  void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
> >>>>>>  {
> >>>>>>  	if (queue)
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> >>>>>> index 6412a7f7b6ef..8fc73862f64e 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> >>>>>> @@ -151,6 +151,8 @@ struct amdgpu_db_info {
> >>>>>>  };
> >>>>>>  
> >>>>>>  struct amdgpu_usermode_queue *amdgpu_userq_get(struct amdgpu_userq_mgr *uq_mgr, u32 qid);
> >>>>>> +struct amdgpu_usermode_queue *
> >>>>>> +amdgpu_lookup_queue_by_doorbell(struct xarray *xa, u32 doorbell);
> >>>>>>  void amdgpu_userq_put(struct amdgpu_usermode_queue *queue);
> >>>>>>  
> >>>>>>  int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
> 
