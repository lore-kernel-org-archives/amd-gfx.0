Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1890D105F78C
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 12:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70FAB10E10C;
	Fri, 13 Mar 2026 12:21:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vxFz6SiP";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010069.outbound.protection.outlook.com [52.101.56.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39FBC10E10C
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 12:21:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxFZA68v42l9BvefMCI4YGTbtVvkcH14jH5bgb43PKUGjJYj/DsxOkExEfSgAaVFdCaR/k0OJgI7wEyWn+TanHsN+CQsbJFlp4nU3uaC/vcvhdyWv2PxRYHUBS1hEJr1qL6zLb4IPUcuwf/56JrE5oee82snuFhyvEBwoS0p4Uf7W4Gtdvvaj1T34uuWYkIZNY0sNWqdyYQ6GM7+hi3yExTN67/R2j/orpl2rGPLU3wjWmXBSQ2XTgACSOVHZ0Oh24YhD7PcfqDxZkTq1eZv4z14ZytcR5NuoZ00Y0pW5Erqhpt8dMJY8PhD+zJp0BFZQYy2yjk2NRlvEabHQfrnAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdXsG1L/HfcDnggTyUrw6fkBswIvTdrZyTJEqRUK83E=;
 b=aW5eXETNT3eBSbiW8H6k7fj+m4jAVkI0fFhtVHlmt1swBoydUkWVaTppHi+5fGEZr5X60KUDQBHgqnQSsClkIEUZkgznEqkignJLwgSFrU98tM5otDwftf33euSP6RTbkpl9guS6ANdKrP/2OY4Df6P+rmZli61VzPC1+6cQAlR0o8ynq/m25O6L74OFiVDMrmwB5GE7tT+4G7kb3QiKniGm+ibeScU7R3l9DSjBZ18JZsd1AEXQkU385KWv44UX1la2eXHRcP0jC8WCGKN8x4h5raxnG/6H/uDR8sOkWOo8opv3MWsHIjEF5+EQ9sY9rytLFzMFpiK2KEgU6RZjwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdXsG1L/HfcDnggTyUrw6fkBswIvTdrZyTJEqRUK83E=;
 b=vxFz6SiPRbNpzyob3fWDPZC8XEeurcpXqTAYxlZAV9rLWI5Sus+prN6x7j70S00V1E6y6dmtGeGr3vk9734T8VkIntVF+oDUy5Fym3y1KnYn9VkY6ht+OLqGMEEW3a1aLtmSggKhd/6dAnNt/i2rSLgdlo632tuvZZdcpojDhGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB6804.namprd12.prod.outlook.com (2603:10b6:303:20d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 12:21:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.004; Fri, 13 Mar 2026
 12:21:05 +0000
Message-ID: <ce11aea6-5191-443f-aa44-499b6d5dc6d7@amd.com>
Date: Fri, 13 Mar 2026 13:21:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu/userq: unlock cancel_delayed_work_sync for
 hang_detect_work
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260312091655.1948356-1-sunil.khatri@amd.com>
 <a55dc4d8-d137-466f-8cc8-de79e02a28ef@amd.com>
 <4f194096-ad01-4b5b-a5cc-3cefd59f31a9@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <4f194096-ad01-4b5b-a5cc-3cefd59f31a9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0331.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 05dcb184-c869-4ec5-302e-08de80faffea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 7Yv2XLfYpFTTViwGxyKh17hyZhY53kHVtGFMnXkEs+DrNxKZjjZtC2Cuq2NDB4xW112Ojew43FD1ljO0TA73dMCMzpYhWcXcp9JQ53qOkjoloMJnYiEVKdwH2X2P4bsVONSNF4eUACy2QDzzGMZ3OuMYiIJWs1Z9rybrJgHcqqVjtoSmoZUrBYnjHK9jyP7M/cxPeWmIFRchB5ROohGWSuBlY27RQMMDH0K6M6H/4dl6k8zW1bwceK7CCMmCt2I9AiXTqBw1K7klNr8PFTCh+e/mxcaXQdFMLrBT6id9+ZJF1tBVcx5jPLJP/BWGCVqrnDd5l8dK6PO5lx0xJwkihtjvVvlwFw7A6C2odzveLSGLGcHsgWfj+XJmzbPagy/mAc9xHrGUC3AVnLfPoPgWK4YgybpB6bO1MFWZrloiXafI3vKX/o62F0OAImBWs93NBF06LnmDpGMwOiOIFxaJpANf0Ya/vCjecqc6RNkFyKHI8CQyieAa+EPsqDOps8z01CuxMZ/uktJJVVri0nv/38+n4nRzFrwggnHx33l7wg2gduwDSogbHiSgrUWIxe2iFgU8zOXFqUq4DA8Ci1k5bZnxw7kVQpI+JqfHlPXKQsotU41DiiWd44k9B0KMDmw+Bw01GGZbTont2Pa4SCQ4ChpmBle2VU8rAnvy/vS8kFB3QGqjFaMduXhfSj687IcahuzN8QaoP/K1TmQXrBMdD67UlHg6VYXjgH/NB7qAm8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejRXNlhIYmQweGd3ZUlVZ05oY1ZUZ2t2REF3enlDeVJLL25VbXRQNmxPeTNQ?=
 =?utf-8?B?NXVsMytCMEFtdXlXb1FTejlLNUk0UkhQMHpuNzhHRkRqRmh0OW5xSi9NWklS?=
 =?utf-8?B?V1o2TDRZdEIzU0xiSjZrOVlqWjN4K3RpSW95b3FTd1UvdHJ6Y1RCOHU3bkxh?=
 =?utf-8?B?VVNuMmN3MFpLdHF3eGxBdzBKWmtrS21uTTNLdW1rak9LTHJxTlBYRzZrL256?=
 =?utf-8?B?KzhOU3dhb1Z3b1hCYXUxYzB1OEN0eWsrMXA3YjNqTW1uVi93VHgzYlczZ0hK?=
 =?utf-8?B?YWFUZmNIOXI3RGI3eGpycmtsMnAyYVoyWUhjQTgvc3NPd3ZiaWt2RytTVXRR?=
 =?utf-8?B?Y3Z3bSt1cTY3ZlEwQmFUUm5LaUFWNzVWZmpFU3F4bTlEaHAyK3FTK01MR2p5?=
 =?utf-8?B?OU5rT2hSK0Z0VG9qR3N6YjEvU2NsK2xLR1BqdG1reGgwMEJrbHRmQkZwZjBr?=
 =?utf-8?B?UDh2NE5EN1BlZStVVUhxcWEvRTRQUFYxYUVGQkpCd1p5bE9LcDRpM0dKZCtv?=
 =?utf-8?B?eDh4MGQyY0pYSDdsaUZDNzdlZHU5MXBla3lIM0l4bk5TUGhSclo3WWlwTGZN?=
 =?utf-8?B?RFh1SlZVM251UXMwWjAyQVMwWkoyRWs4SEx0ZFhUOFM5bEtYMXJXdjE2RlIr?=
 =?utf-8?B?NFZpSHBUeUFRU2p5VVFXSGJMRjZKaXF2NDIyNnk4ZVhlOS9jeTJnTmtCSDdU?=
 =?utf-8?B?Q2dtMTRudW14bWw0dGMvQWxVdmwyR2NYbUlOSXI2M0lBYk51RU9lVG0xYkh1?=
 =?utf-8?B?eVdnOTBkeWRNK2x6a0hVR21PTS9oREdZcVZhck5OUmp0cDRKc0MyRFpwK1pu?=
 =?utf-8?B?dmpseCtrSjJaUDgzbi9yY2FpQnFYQ29LU2xGdktMRDFXM2V3bWlIVXM1SVBx?=
 =?utf-8?B?UjBlOHJ4eTMrYzFPc1BzSmpOUjkwbFlQWThOb0p5b2RDTFFzNkZZUWRFT3N0?=
 =?utf-8?B?bTFuR0FwQXJndm5OMm9rU3psUCthWHpadW0rN0orMTNIT29oKzBMckplTkpk?=
 =?utf-8?B?TVNsMjRCaGJDMm9FaW01K0F4a2Z1SDJzOXB2anUyZXFSY29nWUdORVNDWlov?=
 =?utf-8?B?SUQ2VjBLalFnSHdjcG1USHVrQ0hXbkU1RTh6WTdHMUR0RSsxTlFUL3ZGTE1j?=
 =?utf-8?B?TldyNGdKMHRrc3poTGdOYk5Ca0twZG9mQ0d5c0E1Z3lnQUpVMUZtSFdxTFpa?=
 =?utf-8?B?dmdkRnVyR0QyNTNWMWlqNWJjbGxKUXUrRzBpZGdmN1Y0SkF3SkRPbzBYeGpp?=
 =?utf-8?B?c0xlMHRGTi9RNHY2b0lPdlpvdnJyb09QMU1vYWNTUWdQMzY1Rjh0NnlSRXlp?=
 =?utf-8?B?ZzNwY3dhdXYvVjFta1FRVmlndVIwcFBmTzBMZTZKOWlKdFc5MFFzY2hXRnFX?=
 =?utf-8?B?aWE0N0xiWjFWNzVMS1hCa25rSXFhRWpUK3NuU0hxd2p0bCtWalBNdDZkdGJz?=
 =?utf-8?B?K1E5VkhEenVaMGtlS2FuMzJhbE0reFgxVTlEbFdOSkt0dGF5TDhONWh3WmV3?=
 =?utf-8?B?WS9OQmlsY2ZOME5oQU9VUXRYUGRiZW5nV21UN2VPZUREeDROTkJnRWxQSGpU?=
 =?utf-8?B?Mm5zZmU2QlRSaGdKeFFucU9yajF2dDZsSGQ2ZVFOdE51SHRVdW5hSWdQT1hi?=
 =?utf-8?B?cUdaRTMxSXhyTVpnMjhnSDFpaktjUHZPVjNabUxnNi9GeXFDY3FwYXRRUUNH?=
 =?utf-8?B?a1VQbE56N0NCVHA1TmNhaTB1TTJxVEUzNUhMWkc2Y29MdTlzaDl1M0dTbzNH?=
 =?utf-8?B?QW1FWGc1K3RwSk9kRmwydGNKMncyNnU5UmgvWlE5SWs3MUsxcHFMbUdBM3Yr?=
 =?utf-8?B?Nkw0elNaZ1o3b3hYWDBQZVZpdHd6bVpsamY5L2ZwNk1uYitGSVRVQTJrcDNU?=
 =?utf-8?B?UlJkNDlTWU9rV081dmpkbFZabjBoeGhxODZvejE0bmV2dlJDcG01NmpIcklu?=
 =?utf-8?B?aEl1MlhUeHJWYnM0Qm5mRm5qUlZJQWNMK292dkpidWdFeVBKK2RrRnJRclNT?=
 =?utf-8?B?aC93bWNja1M0TndRYUFXTkJ0U0Z0bUlnclZhQWZTNldwTy82WUVHNnBqTnJJ?=
 =?utf-8?B?eXBzUFRWeVFYdUphZlZESjFKaWlZSC9UaURWazd3Qjh2QlJ5V2pMUXRCenR1?=
 =?utf-8?B?QVJST0EvQWtGZy9IdWIrVGlIR1RuenAzV3I1aHdWNFcvT3Z5blNweElsUXoz?=
 =?utf-8?B?ZWdoNzk5dC9HUEd1emtRK1VGclRkT0VhV1dRK3Q3YVlCU3pwbnpoSGRBakkw?=
 =?utf-8?B?cUZJb3BDZU1kTDJwbjVxMjBCNWoxcENzU3FBbUNMOFoyRzZBT2I5SlM5Yk9D?=
 =?utf-8?Q?AKmkhI1fey7WSkWcnZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05dcb184-c869-4ec5-302e-08de80faffea
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 12:21:05.8661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AypihXZHUJp7H+oEOkYKUwFdgLp/9RwHEClCOBLXa25MrJV4xq0yCkAkGidgteIY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6804
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

On 3/12/26 12:32, Khatri, Sunil wrote:
> 
> On 12-03-2026 02:50 pm, Christian König wrote:
>> On 3/12/26 10:16, Sunil Khatri wrote:
>>> cancel_delayed_work_sync for work hand_detect_work should not be
>>> locked since the amdgpu_userq_hang_detect_work also need the same
>>> mutex and when they run together it could be a deadlock.
>>>
>>> we do not need to hold the mutex for
>>> cancel_delayed_work_sync(&queue->hang_detect_work). With this in place
>>> if cancel and worker thread run at same time they will not deadlock.
>>>
>>> Due to any failures if there is a hand detect and reset that there a
>>> deadlock scenarios between cancel and running the main thread.
>>>
>>> [ 243.118276] task:kworker/9:0 state:D stack:0 pid:73 tgid:73 ppid:2 task_flags:0x4208060 flags:0x00080000
>>> [ 243.118283] Workqueue: events amdgpu_userq_hang_detect_work [amdgpu]
>>> [ 243.118636] Call Trace:
>>> [ 243.118639] <TASK>
>>> [ 243.118644] __schedule+0x581/0x1810
>>> [ 243.118649] ? srso_return_thunk+0x5/0x5f
>>> [ 243.118656] ? srso_return_thunk+0x5/0x5f
>>> [ 243.118659] ? wake_up_process+0x15/0x20
>>> [ 243.118665] schedule+0x64/0xe0
>>> [ 243.118668] schedule_preempt_disabled+0x15/0x30
>>> [ 243.118671] __mutex_lock+0x346/0x950
>>> [ 243.118677] __mutex_lock_slowpath+0x13/0x20
>>> [ 243.118681] mutex_lock+0x2c/0x40
>>> [ 243.118684] amdgpu_userq_hang_detect_work+0x63/0x90 [amdgpu]
>>> [ 243.118888] process_scheduled_works+0x1f0/0x450
>>> [ 243.118894] worker_thread+0x27f/0x370
>>> [ 243.118899] kthread+0x1ed/0x210
>>> [ 243.118903] ? __pfx_worker_thread+0x10/0x10
>>> [ 243.118906] ? srso_return_thunk+0x5/0x5f
>>> [ 243.118909] ? __pfx_kthread+0x10/0x10
>>> [ 243.118913] ret_from_fork+0x10f/0x1b0
>>> [ 243.118916] ? __pfx_kthread+0x10/0x10
>>> [ 243.118920] ret_from_fork_asm+0x1a/0x30
>> Good catch, but userq destruction is completely broken in quite a number of ways.
>>
>> Have you taken a look at my patch "drm/amdgpu: fix eviction fence and userq manager shutdown"? How does this here interacts with that?
> Yeah even after that patch the below is still open, and a deadlock with amdgpu_userq_hang_detect_work is still possible. So i guess we need this fix still, irrespective of your fixes in drm/amdgpu: fix eviction fence and userq manager shutdown

Make sense, just one minor comment below.

>         if(queue->hang_detect_fence) {
>                 cancel_delayed_work_sync(&queue->hang_detect_work);
>                 queue->hang_detect_fence=NULL;
>         }
> 
> 
> Regards
> Sunil Khatri
> 
>> Thanks,
>> Christian.
>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 32541f1bde6d..c5875e175918 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -621,15 +621,22 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>>>  {
>>>  	struct amdgpu_device *adev = uq_mgr->adev;
>>>  	int r = 0;
>>> +	bool hang_detect_fence = false;
>>>  
>>>  	cancel_delayed_work_sync(&uq_mgr->resume_work);
>>>  	mutex_lock(&uq_mgr->userq_mutex);
>>>  	amdgpu_userq_wait_for_last_fence(queue);
>>>  	/* Cancel any pending hang detection work and cleanup */
>>>  	if (queue->hang_detect_fence) {
>>> -		cancel_delayed_work_sync(&queue->hang_detect_work);
>>> +		hang_detect_fence = true;
>>>  		queue->hang_detect_fence = NULL;
>>>  	}
>>> +	mutex_unlock(&uq_mgr->userq_mutex);
>>> +
>>> +	if (hang_detect_fence)
>>> +		cancel_delayed_work_sync(&queue->hang_detect_work);

I think you can drop the hang_detect_fence check and just always call cancel_delayed_work_sync(&queue->hang_detect_work) before taking the lock unconditionally.

Tacking, droping and re-taking the lock is ok here but usually points to some questionable handling.

Regards,
Christian.

>>> +
>>> +	mutex_lock(&uq_mgr->userq_mutex);
>>>  	r = amdgpu_bo_reserve(queue->db_obj.obj, true);
>>>  	if (!r) {
>>>  		amdgpu_bo_unpin(queue->db_obj.obj);

