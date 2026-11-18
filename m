Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445A0606A32A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SylwaPQJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4A9D10FA8D;
	Wed, 18 Nov 2026 10:15:05 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010038.outbound.protection.outlook.com
 [40.93.198.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FA8910FA99
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 10:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qs3KRLnzCKN88fVRWXcRA2Jse0AzdW4uTe4UkLeWUBWM7upYJ96hAi2ObY4XDBSVCOPMfM7VLpyQulxzvpGyN42SclSRQJr5xG4UYqAu/A8TLO32uyKzsJY6o5+BR1JIKpUrX2zT/OL7aG0v5UONqxJYqLY4+sX30i+xJ3kbgrm77/DiuF9d4FdKpgRa3l8soIuLNXe553oDIUIqaxoYG3AOf+9Ow9a2rA+qWPml0wtS7Q1Tb76ZC6ND2JxLAIdzXohRI/Clj7QQ8tkzzQdCecl16PIskcOl3pgOi6IktuC3/SJ0Slilyf2JtCtNmFUrNqWHeqT9bOyreMGqQdydjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sf1FjIsArCwXEVfAX2Em05z1xUfHLN+KCTOKk6yTZHw=;
 b=r/IvZue9TvUWa1AolTQjLnZsW71QEHntwmD2xjYdF/1giT/04uUbY3X10IEb5bpet0ajPZsljX1PWxOKLMsY9Tkz1RX3YpMK/+RJoTVHOoQQBboq+E6TTB7WEH3L0H9mAiYjmYcPqxOntGA8uiooPfhaCnbo7/mTM9riSviiYiSRi/OzqNsuvPAocuOYkTN5nMImJgm8vdaumJBn3WVSqoZvALUP2kVpm4z7GZTraDJ3cbKhSEc/H36P7XezF43/IoLnuLflvmOgIIym04AY1rzMb1MYo89ZNqiu2+ecW3J478mmdifT0+rCPUY4U/A5YzimcCEcO+LJo5N0kw1T4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sf1FjIsArCwXEVfAX2Em05z1xUfHLN+KCTOKk6yTZHw=;
 b=SylwaPQJa1wI4Rb0Vy5hD+wwIKZ5ezYN0i0rbO81SN8KV4RJOERYK3kjCEROWUd5/CIxJIhrxSBjWeifSUc1roUwk3Tfl5oroyjtej7qGtIXX95SVgy8KNsXoE2XEd2bykwK1v98Xpw/rSTPFv614yRNuWO86BrRzfsrJwZmmO8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7718.namprd12.prod.outlook.com (2603:10b6:8:102::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Wed, 18 Nov
 2026 10:14:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 10:14:56 +0000
Message-ID: <1d06a6ef-7a67-409a-bbaf-9ec9c0dd32de@amd.com>
Date: Wed, 18 Nov 2026 11:14:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: drain queued scheduler jobs before suspend
To: "Thothiralingam, Logatharshan" <Logatharshan.Thothiralingam@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20261116-superm1-drain-submissions-v1-1-e3ffee977a28@amd.com>
 <5e22b2e1-2379-4583-968f-78217ce5525f@amd.com>
 <SA1PR12MB715234880D4B3AEDAA1AFF72F87B2@SA1PR12MB7152.namprd12.prod.outlook.com>
 <SA1PR12MB7152CB1DA95F6AC4190C93E6F87B2@SA1PR12MB7152.namprd12.prod.outlook.com>
 <SA1PR12MB71526239725978636452725DF87B2@SA1PR12MB7152.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SA1PR12MB71526239725978636452725DF87B2@SA1PR12MB7152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: 2824f381-8d2f-4e40-3969-08df455ccb97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|4143699003|5023799004|11063799006|56012099006|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261028144727099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: IAY8xzqDA5XfIaSg9kgPMrt46r/v70Kh29I5cvm876T7RrDj+p7beo5Bs1HJVkQcNHiT+twgc5hIO1TFa0yRRxQ/93fDGtgjSYFsc9Q5ggib8BXVUBf+yqf4CP2NAAtcw72a9Caqxmqj3cSvua+YRLg9TZeNZDTOGqvSFMUkgwYxbYlpKwREt/NP346Sqq2/VW834CRuvCa/L0ScrTAqzOWAnlBeGffH/i3xJWOI67hxlnUT64IXI68CTYrnBWDBVysOXlMhVZ/Mt9nUlGUIMDPE8A0v2WPsIFJ6SC+FTKlItXcWi06Ttq7L6IJ/mOyGkDK0CCeaJFM943A+ZGn90df5v1t5SSbynsckK5hbJtmt0hvxUTCNGqsa6FxdWju4AwwBCHQwkZ6hOTmKNWHcB8K+IPEkI5WEXlKaIT19wzJkD1++iSfZeGaywAOE8nyoQsyl1rV4DItTcAM6ri5oBIN2DabuH0lLc8DwpYkwjUviYUtEqGwU1Fv3U7Z/2Uq9r3OeUlYdwWrQJvGfvq1qLN+pFnkYzATVC2UqP8Ui4h8ztdq+n08q+psvF43F1pK1BCULfR2QexjI8CttfjCtjqssn/Nokx2Dowc+87TSWJM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261028144727099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1ZEd09OVlJuY05CbWl3WEZyNWM5RVd1V0tDYldkRENPRTNteWhTL0psajUz?=
 =?utf-8?B?ZzZNdmJMcjRQYmdRclVUK1M5d3NCaGhnSGh3N1VnVDQ0TzhHb0VBc3ppcE1r?=
 =?utf-8?B?eUlCdGFHS25WNWdkZDJGdWdyeDNQSkpGOWdhK0lnZVpaSjZ5RkZLQXJhZlNl?=
 =?utf-8?B?OEhPMHFCZ0YzY0Zxci9ZSmhyb2xTSVNVZGQvT3k2S3RERytFc0h0Z2swZWNS?=
 =?utf-8?B?TElaSTRQcjdpQ0J3UlZ3dlEvVlFJb0VHWGhxczJCRzE0cUl1cnhhVUxtZW9M?=
 =?utf-8?B?VXRxTHJvcXBRcmVkYXNUSWZjTlB4UkFWSFhVNkZJUUFRYU5lTk1OalU5R1VE?=
 =?utf-8?B?Y0pML0YvZnVrUFhxWllCMmNTaU0vZE8zWjY5czFDakFSQ1dQZlNTUXpxOEtr?=
 =?utf-8?B?MVEvbHFCVzNJUkFVWDhsSnE3dk01UEZ5RFlQd0RqQnJidUJDck1wZWhDazdV?=
 =?utf-8?B?S0Z6OEY2VnM5TFJ1RnZtTjRHcjQzZDZ0MG1jNVlvbG14NVlYL2gwRFRGbVMw?=
 =?utf-8?B?WHB3U1BEVEZ2bzNwUVN6OGxveFpiL1RPSm8rdzNTZFp6TndtQVkvMEZuckE3?=
 =?utf-8?B?VjlPcFF5NjZ4OVFKNGZrRG9Zb0krVHRZRGx5cW50bElJcDloQktNMHBPeldQ?=
 =?utf-8?B?YWZteVUrblZmZnpXQTlxTGtNaEJYZ0crbUIraGptdHUwOFk5Q0hUQlpXR2JZ?=
 =?utf-8?B?c0ZtMnNKM0JWZER5YUpsT05xZ3A0L2dkTFFUR1FSQkJRY004Y25PRVE4MTZC?=
 =?utf-8?B?Um8yM3g1cDRZRmFQV2pEZ2JTSVNGMzQyQnhuMG8rWTBCY3dXR1BRbis2YTVw?=
 =?utf-8?B?VWJvbWdKZkZoWW5mcDdMQTZBV0gzdnltakZ4RVBuSk1xZDJEQWdSMFA2ckU4?=
 =?utf-8?B?dEFBdHk4NU9leXhoeS96WFg4czBRQkdJVGRtMmMxU1NhaUpGajY5aXRvYWh5?=
 =?utf-8?B?aEFVVjAvc2cwVDJ6RmZSVERkTEIyOFNGVEh1dVJZR1FmNnlRaW0rQXNobDlX?=
 =?utf-8?B?TVRQS0tVT3ZWMERUYzk0anhJbG1iU2lxSTl6SVFUYk9BS2I2TEdNclY5RVZt?=
 =?utf-8?B?Z083SXloVmhXdVkxckp6cFQxVW1ZUW1LK0t6T2dRSlFNREdlUzQzVjQvb3oz?=
 =?utf-8?B?RmdZdUhocjFCTjlpRHBpRW9mM29raEhRUVl0VUNYS3J4RlE4d1h2TmF3YmZO?=
 =?utf-8?B?ajZyVGEzMkZYMk9CMmgzRzZWandudlA1MjFuL2hGYVorUjdvYW5kT1ltQUxu?=
 =?utf-8?B?VldJL0JBV2tSMmVIWk9aRDFPaU1mTnZPUTdrdHlOd3J5VVRGd2c5RG5qWDA3?=
 =?utf-8?B?ZU1IdXl6RmJsY0w4Mk5lS2dSakZicnpic202bTBJYTkrbmQvaEtEVVFMTWZH?=
 =?utf-8?B?TWd3V2twclJLSXBSNC9UQVNOZmRPS3YxcUxpZGtSVzE3RkFVSVJYcURpZGZM?=
 =?utf-8?B?VVRlOThIS0FZK3NsVjNmZy9melcxVUN4YXlvYnY0Z0ZHdDkxOU1mck5iS1NR?=
 =?utf-8?B?anoydzVVNSs3QzZnTUM3R1ZFZFlVeEZxMHUzdVdBVHpHMFdsM1JKbUhjcmZZ?=
 =?utf-8?B?b1plOWZzRDVhL2xRbU41Vlc2b0d4d1JDRkE1bmpWWjJwczVTWVNXVEFUSXZy?=
 =?utf-8?B?RGZvRVVpY21XQXgvMkhaemFkMW1wUUpaaElkSHhiZ3JHN2x3TFdKR2N2Sysz?=
 =?utf-8?B?MC9TdDZnTDVsdW5IVXdoQ2FMYzRxNXFYODdiYzZiZURucG8rOWVjY2ZZa2ty?=
 =?utf-8?B?aExIVWhKSExBa3RNOTNhNjJ6bk5MRU0zZFVpelY0OUZTZEMwM1Y5Lzdudyt3?=
 =?utf-8?B?a3daOG4rQjdWM0luYmQ4eWVmemtERWp4V092cm1WV3ZzYXhraHUvbm55Y3Nl?=
 =?utf-8?B?bjFqdXEyclRzSE1TLzJjTm9BVGJVTHdrS1FrajdCSmNaejM3R1V1OTVoR01K?=
 =?utf-8?B?R3FjRzJyZlAvMmdvZ3cvSURudUNhZ0hTcEptb0pvL1kybEJWRTdFdWpibEl1?=
 =?utf-8?B?bm9WTnBOU0hLZUkzdDNEak1pQzc4S0pYS1hleFBYcUVYL2xIdFo3SU52QXlW?=
 =?utf-8?B?K3BpZDZXdDJwOU45c2Rncm11bGlTWFNlWXl4dktVUXlRVmpTblpaRW5lYm5v?=
 =?utf-8?B?a2dzaVorR0dWL05Ib3FCRkVTMjF1ckt0U09aajVTNjd1bHF1dDF6SzJFQlY2?=
 =?utf-8?B?QkFnMVlCNzJrUS9QSXl5dWRTK2dJSVBFZkZ3UWdjQ1dmOGh0QUdncC9oWWlV?=
 =?utf-8?B?ellIQWE5M1VFeW5hRlJHQ2RURWZjUUZmWWZmai9pdHhvRStOditCWG01Qkpv?=
 =?utf-8?Q?7FcWP2I4uDWO26lDOv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2824f381-8d2f-4e40-3969-08df455ccb97
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 10:14:56.6665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMeUi81I4oZHoIf2/V53OQyDuE6viWSDBsIa35mYHq5YAsLgVEmQHrKsVPA5TcNP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7718
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tharshan,

oh that is a really good point, using amdgpu_vm_wait_idle() here is not correct either because of the same problems as with the context flush.

> dma_resv_wait_timeout(vm->root.bo->tbo.base.resv, DMA_RESV_USAGE_READ, false,MAX_SCHEDULE_TIMEOUT);

That looks like the right thing to do, yes.

It only might be necessary to replace DMA_RESV_USAGE_READ with DMA_RESV_USAGE_BOOKKEEP, but I'm not sure if KFD/userqueue suspend resume is actually fully implemented and handling this.

Maybe we should stick with DMA_RESV_USAGE_READ for now and I will let my team double check the KFD/userqueu thing later on.

Thanks,
Christian.

On 11/17/26 21:08, Thothiralingam, Logatharshan wrote:
> AMD General
> 
> Hi Christian,
> 
> So adding dma_resv_wait_timeout(vm->root.bo->tbo.base.resv, DMA_RESV_USAGE_READ, false,MAX_SCHEDULE_TIMEOUT); before the amdgpu_vm_wait_idle() fixes that gfx reset. So it seems like amdgpu_vm_wait_idle() alone is not enough.
> 
> Attached the patch again. Please let me know if it's good.
> 
> Thanks,
> Tharshan
> 
> -----Original Message-----
> From: Thothiralingam, Logatharshan
> Sent: Tuesday, November 17, 2026 12:52 PM
> To: Koenig, Christian <Christian.Koenig@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] drm/amdgpu: drain queued scheduler jobs before suspend
> 
> Hi Chistian,
> 
> Just having the amdgpu_vm_wait_idle() doesn't solve the issue. I tested it and I do see the reset. I have attached a patch with the dma_resv_wait_timeout(vm->root.bo->tbo.base.resv, DMA_RESV_USAGE_READ, false,MAX_SCHEDULE_TIMEOUT); I am building it now to test.  Please let me know your thoughts
> 
> Thanks,
> Tharshan
> 
> -----Original Message-----
> From: Thothiralingam, Logatharshan
> Sent: Tuesday, November 17, 2026 8:39 AM
> To: Koenig, Christian <Christian.Koenig@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH] drm/amdgpu: drain queued scheduler jobs before suspend
> 
> Hi Chistian,
> 
> I looked a the amdgpu_vm_wait_idle() function and noticed that starting commit 1f02f20 (https://github.com/eseiker/kernel-asahi/commit/1f02f2044bda1db1fd995bc35961ab075fa7b5a2)  the wait on the VM's root page table fence list is removed. So correct me if I am wrong, this alone won't wait on the gfx jobs right?
> 
> So should I add this before the idle call?
> 
> dma_resv_wait_timeout(vm->root.bo->tbo.base.resv, DMA_RESV_USAGE_READ, false,MAX_SCHEDULE_TIMEOUT);
> 
> 
> Thanks,
> Tharshan
> 
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Tuesday, November 17, 2026 4:37 AM
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Thothiralingam, Logatharshan <Logatharshan.Thothiralingam@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: drain queued scheduler jobs before suspend
> 
> On 11/16/26 21:40, Mario Limonciello wrote:
>> At suspend, amdgpu_fence_driver_hw_fini() only waits for the last
>> fence emitted to each ring. Jobs still queued in a scheduler entity
>> have not reached run_job() yet and so have no hardware fence.
>> Userspace is frozen at this point, but such jobs can become runnable
>> later, for example once a dependency signals, and the scheduler then
>> pushes them into the ring after the hardware wait has finished and
>> before the IP blocks are torn down. On resume the ring write pointer
>> is reset, those jobs never signal and the GFX ring times out and hangs.
>>
>> This was observed as a rare (about 2 in 400 cycles) GFX hang on S3
>> resume on Picasso.
>>
>> Flush the context and VM scheduler entities of every open file before
>> evicting resources, mirroring what amdgpu_flush() does on file close.
>> Like for any other dma_fence there is no timeout, the wait is not
>> bounded.
>>
>> Reported-by: Logatharshan Thothiralingam
>> <Logatharshan.Thothiralingam@amd.com>
>> Closes:
>> https://lore.kernel.org/amd-gfx/SA1SPRMB0073292C113C6B98D9282092F87F2@
>> SA1SPRMB0073.namprd12.prod.outlook.com/
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26
>> ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 19a566187dfb5..d18348116d3f1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4538,6 +4538,30 @@ void amdgpu_device_complete(struct drm_device *dev)
>>       }
>>  }
>>
>> +/**
>> + * amdgpu_device_flush_file_entities - drain scheduler entities of
>> +open files
>> + * @adev: amdgpu device object
>> + *
>> + * Wait for the scheduler entities owned by all open files (the
>> +context
>> + * entities used for command submission and the VM entities used for
>> +page
>> + * table updates) to run out of queued jobs, so that nothing can slip
>> +into
>> + * the rings after the hardware fences were waited on at suspend time.
>> + */
>> +static void amdgpu_device_flush_file_entities(struct amdgpu_device
>> +*adev) {
>> +     struct drm_device *ddev = adev_to_drm(adev);
>> +     struct drm_file *file;
>> +
>> +     guard(mutex)(&ddev->filelist_mutex);
>> +     list_for_each_entry(file, &ddev->filelist, lhead) {
>> +             struct amdgpu_fpriv *fpriv = file->driver_priv;
>> +
>> +             amdgpu_ctx_mgr_entity_flush(&fpriv->ctx_mgr,
>> +                                         MAX_SCHEDULE_TIMEOUT);
> 
> That is actually superfluous and even a little bit dangerous.
> 
> amdgpu_ctx_mgr_entity_flush() is only supposed to be called from the process which has the file descriptor open and is closing it.
> 
> We use that to detect if that process using the file descriptor was killed and we should discard queued up work instead of waiting for it to finish executing.
> 
>> +             amdgpu_vm_wait_idle(&fpriv->vm, MAX_SCHEDULE_TIMEOUT);
> 
> That here should be enough to wait for all work to complete.
> 
> Regards,
> Christian.
> 
>> +     }
>> +}
>> +
>>  /**
>>   * amdgpu_device_suspend - initiate device suspend
>>   *
>> @@ -4587,6 +4611,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>>       if (r)
>>               goto unwind_ip_phase1;
>>
>> +     amdgpu_device_flush_file_entities(adev);
>> +
>>       r = amdgpu_device_evict_resources(adev);
>>       if (r)
>>               goto unwind_userq;
>>
>> ---
>> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
>> change-id: 20261116-superm1-drain-submissions-17d4414ab3b9
>>
>> Best regards,
>> --
>> Mario Limonciello <mario.limonciello@amd.com>
>>
> 

