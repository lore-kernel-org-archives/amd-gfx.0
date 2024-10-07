Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F56CFB43F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Oct 2024 13:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C1210E066;
	Mon,  7 Oct 2024 13:46:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EpWY5dxw";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ACE210E1CC
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Oct 2024 13:46:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IavkEBBVuKlzmdtpyg6e6+XpHe6+U9V0hqPaSSy3t8YRxhaRfWmBuCvMumwzXbjdygQMyPHSKvMQey/lrGKnJp8m2oWcIrtLPI5x0Lm3/RlWsWPmwGNL6frXiXCbfRleShE91RmXAhXNdaDyKqRkKogbticecu3s5Kjl0Ss1EHAC4dahmRborMyJ4ct0fD1pef3wMBlNAzpuuUmgbkQe7Gxa0pkxUem4DQ590b4/B5bA14AG6qoDhc6dcORTZaZwrSYG67I8eI8lYbSy4m0zrPttxZiAPNh25KdC/nu6vXom7tnNVmT19nL9vdrFPAnqWyd7w0EBJudfuG04mh5VsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWg5jruwnWbbC7jWE16KexT/ZSkOw1h2ASLfSvzZrwM=;
 b=FGJhXBNNq794Xffz4/oCn57Mu+/PIGZERtgrL4odvtPczUK4f/fT7safx8IzOpBb2CQm6215Ap4qtOxL0YnPbfNxCMoBeeI+LBKBAwrY55gAbQ22oYil2V9lFpvD37vd/JvCMrf6N1gBbo154xVBFfCus47x98LpBJWJIc3NeY3YJ8ykFl7DElbTb4IlWQdSi8Yj/aQQum8wnl+tVmXY8T2KbzS3jokOuQV+QTk3fmV+4wZedCnF6r+/VKUGzxB/GyvNEpr5u+spWXAnyYK4JtgTysppaBZMA2H887geCCrR8OGvxYnxpzistzNRfQRCRBofoEUBg7PulSmsccRang==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWg5jruwnWbbC7jWE16KexT/ZSkOw1h2ASLfSvzZrwM=;
 b=EpWY5dxw8o9x9beQZT5IDTih2iCewf7Ja0uNT/fJxA467FozSVhCicm1ce+/fINCvqraLg3wyix9oYfO83Mf2F83ldbUGpufmYzp8oWpNHc+shZ02U5mGpy8NmotrO0nxDnD390qH+t39eRi8YTYpONvvRJQM31zPgIGUXWN34U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8905.namprd12.prod.outlook.com (2603:10b6:208:484::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 13:46:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 13:46:16 +0000
Message-ID: <94a06c82-d702-40f5-83a5-8115db908838@amd.com>
Date: Mon, 7 Oct 2024 15:46:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: move error log from ring write to commit
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <marek.olsak@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241003081306.235253-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241003081306.235253-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0360.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a96ba5-5347-4c48-fd6d-08dce6d66a7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDJWZlQwMEFJMFFFdUM1UVlQejBHT21Dc09FMURpMjFrbDNnYzZpMGVpYUNK?=
 =?utf-8?B?KzZHelArSDdXSHRCcFB3dFlMM0twTEtiR3FYKzJBYmp5WWxseXFCNiswUXYw?=
 =?utf-8?B?aDYyN1M4M0xIT1ZQRy9XY093b2Q3MmZHNzM5ZUFtN2NaR1ZTckl6ODBMODdr?=
 =?utf-8?B?QTVaMVRaWGxCeEpWN0tmM1lncnpiai9FdlZIdFdudHU4K3pXOVcwcjlIUHVv?=
 =?utf-8?B?RnIxWTRzY2EyYkRzVXdlTHdPNWRqWXFHSUQ5MWw5MHM1dDc4SGRlSmdUNDFS?=
 =?utf-8?B?TEt3VFlTaGRrMXlkTHVCeXNzZGhyZDEyckZiRjRCd3laYnlKRDg2WlowendU?=
 =?utf-8?B?dXlzWTBVM0hIVzVJVnFON25VZ1MvRUNwdnZXV1ZWMC9GazBqRVc2cjdOYjZY?=
 =?utf-8?B?dEVrd0ljTnM4TDRteEJtemx2UUtTSmY1dnp3NXdoalBScmdLUEtlczBrL25I?=
 =?utf-8?B?RW40UXRRaGlmbFpYV1RSbkxhVlpiVW5hdlUxV0JUVGdBQkFwcXNIYzIxbThY?=
 =?utf-8?B?dCtQSTdCY1ZoajFMTVdIVjV2VWRvc2pXcGNzM21RYzMrNjRnWU5GUkoyQ28y?=
 =?utf-8?B?eVNWWHE3MEZlRVA5UmxYVU1aVzNzd3BiVk9FU0RCZ1hsME4vMFZNZjIyR2k0?=
 =?utf-8?B?M2xFdG9MQWM1czd2M0JZOG4yZkNFbmw2ME1QNTZ4WUlLajdJUjR3dVg5UDdy?=
 =?utf-8?B?RHNoek8rbitYajdvRGl6YmNCcXBYQTAreWlPOVBjMlBEaWNvSjI5bXlDR3Fp?=
 =?utf-8?B?ZWtBemkvV0cwY0VKRXdndmVMWnJqMCtVa1FxOWE4Wk03K0d0WFdNNThXOUFN?=
 =?utf-8?B?UkhRdC85RXgrRmdoa0FQTEdMbTNLUVJZVVMvNjJlU0lpK1hJZmtlcDFncGoy?=
 =?utf-8?B?QWtKWVJtMGNYcUFCV28zS3MvQmZaRGpKeCsyYlFqNW1KZGVvU3phZGMzVk51?=
 =?utf-8?B?U2JTdmh5VjlCTjg2RFByV044SWszbTE2UUhzLzR6STFRTU5OWE1yeWtQeHU3?=
 =?utf-8?B?VXNmSlRGWHhqQ3B1SWRRdkVKNThmTndoTWZGakt0aDFHTWlqZWZRYkZ0L2pQ?=
 =?utf-8?B?UDlGRU9TellCWVdWbjZnTGZkbEI1V3JINGtKUlNpQjZoWmFzOTMvWVpOcmk5?=
 =?utf-8?B?dVNhWUpscVhnY0ZJblBZOXlaMUlFQ2tuM0RzVU9hT05vc0tmRUE3NmJFMDBv?=
 =?utf-8?B?WEM4cUsvVUVJUkJpTEFtVnNsaHY1Qldtalp1YXFrYnhPVjVzMjg2MWFaTEhE?=
 =?utf-8?B?d2RieHV4eVdQekNNTEZPUVlXemhjNE5LZzd2MVJrc1pUSFRmUGVPdTJOTUJo?=
 =?utf-8?B?dkloK0dZWmJjMnd1SnVVR0lCQkZyejYzK2VIdmhjTEs0L0RHc0ZDcVBxb3Yz?=
 =?utf-8?B?T2pPM2FkdlRuM1hCYkQ3VzlPdXlrWGFFVUNmMDdabW5MOWI2SzFlNW9sdTUy?=
 =?utf-8?B?bnhPckR2cFR3S2paaU14a2ROWWtReWtlL0ZraTVVS0xkQ3JNOFZtL09WTllC?=
 =?utf-8?B?Q1BZSlczVTR3Nmk4dXJ5TTVuOUtOMEN1eU9jL2xPM1pENU9IZ21jeWRuMXlQ?=
 =?utf-8?B?UkpRRWdJSmxmSjNoS3hCRmllYU85RFFjcitFZkVyd2VlM3I4Ym1wMkd5em9E?=
 =?utf-8?B?T1BhYW1GNG9sdkdzNmk5OGVIUWFtU2dpQkpvSHg1QzdGandUTWNWemJvRUVu?=
 =?utf-8?B?ZFYybzhhbnVYcEpvSlMyZHltT0g5YVRyQ3duVTZyVFZFT1JhMCtFbkZ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um9ma2hnUEV3SmdDZnRIUDViREJ2Z0tRVVFFOVBnaCtZZFlZZ3hxVThJM0xJ?=
 =?utf-8?B?dnR3SEp2ZkhqMmhUWWFpTkpQRElqbElzaHFoZDYydWVvdk40S1lQWEVteHpF?=
 =?utf-8?B?L2NJc0JiRFhJVTZuRjhnU1BOQk9OV2F2K0FIcXJKMk9JODZ5Q0JtUEtqdlZK?=
 =?utf-8?B?WEl2UzZ6bmFpcytjM0Vuakg5R0RHNlJzb0NENTVrUk1CcFlQRE9WK05ONmh6?=
 =?utf-8?B?SGMxT2pLOWpBSXQxaCs5N1RRTjMrOW5Nb0FyRmF3RFVQajJpRTNHaUJ0Tlhm?=
 =?utf-8?B?bGtZdmpsZlduWHZ1cXZrM0c3MEc2NGNSRW5ONTNqUEpGWm5ZemJUZVMvTThI?=
 =?utf-8?B?TGhFaVVPbElyU01raDZycjlLa1NObHkwOWw0RjZ3ZGhkc2paRDRFMWkxNnlC?=
 =?utf-8?B?dFFPbXBkSVZmMGV6RzdZUlcxNXBKN2p4emMxeU5kMTUxdlNWaWk3Wm4veWEv?=
 =?utf-8?B?SXdzTlFBRlptWE83YmJwNmNucEw2S2c4YlNaWTNVNHdOaVVVaVF0M0k0emlG?=
 =?utf-8?B?c2tKaEMvOHlrK1ZwZVk5M0F3cEt4TWJ3cGF2L29JUzJNdG1tc1lJb05GR3dp?=
 =?utf-8?B?YkI4VXg2S0swWG9FN1hkWDZCMmVldm1ZQXozTnRlQS96ZlhKRWRXazJHcXNr?=
 =?utf-8?B?L0NxaDc2V0taNlAvajZpRzFuWC9QcEdSRU5hbnU0clZZYUtaVTNzakhvaFlj?=
 =?utf-8?B?U1dGSmU3Vi9KZ05pSDNMLy9mL3hzbEtQUmprN1pFLytYd0tHWFlDZ3NTd3cv?=
 =?utf-8?B?aTlabmVvMmNNWTVsa045NWJWK0JsV0NJUlY2MERXc3FMT0R2SGpRVkN4dW1r?=
 =?utf-8?B?SnZNSU5zNlRZdlVOc1d0dno0L2xyODJLVW9KcU44SS84ZnFLZHJvb2Yxd3dC?=
 =?utf-8?B?amROWXZudGdqbWNjTG01U0pmV09RdkJ0SW1QQzN5TFBaRW1BcU94Tjh4elNS?=
 =?utf-8?B?MXFXQVhXTEczZUpseDhsMFp1c1QxT1dMOHNNZnZFZVNuVXJEZVBsK09RY051?=
 =?utf-8?B?UTErZ0dYeTdWRnZaTjVJUFJFb3QweVZtMTBLRjVKVXVjeGhVaGdLak00ck9J?=
 =?utf-8?B?OUVEdXpKNklPb0orUWRHNmIrMGIwVFpNYzRGaHU1N3diNGhHYVhLYTJyK1Vt?=
 =?utf-8?B?aWJnQ2R4R1ZiY3pYSjhWK0gzbGg3M0RZeEtTd09XcFJMS1g4N0VUZG5vQmd1?=
 =?utf-8?B?TjBZMStXVDZncHBOVTNQZW5jdnBoeDhKUEcvZjVBK2NhbCtTZlBhcWVPcjJG?=
 =?utf-8?B?RU5UbHZDTndhRmhKVS85dEFwOTBLaENWS09SOVdrZmJCclVKd3RERnRWWlEx?=
 =?utf-8?B?RFZub09SbTk3dlNvRG1zSlZSUzQzQUUxYXZCa0lyOVk1d2JXeGI1UFVTL3lQ?=
 =?utf-8?B?cGdGRmtmWk5HdmJoVTc3TEdmdHFmN21MN0g3bnRTY2phRS9RbFhhSDcwSTU2?=
 =?utf-8?B?T2ZVb09zOWljSWFQSEFNazBaNHRrNkVMd2Z2WElFVm5MQXRmZzV3TUcyUTNs?=
 =?utf-8?B?alF2MTdaTHF4eGV2Sjl2YUw5cE9GR2lITHkzamtLT3B2OTErSzBJU25OMGN4?=
 =?utf-8?B?MW9qZk5GOHlJZU5GelNBNGdxSVFYUytHQ3pyNlBsankrK2VQd3Q3M0dJSk5L?=
 =?utf-8?B?UzJNaC9BdGpZMGRPUGNGb3IvaHV4UHlhSEM4dGloZFhoc2w5b0VoRE9Za3ZI?=
 =?utf-8?B?aW4yaTJQcUlwVld6U1dxaUZBM3lwOWdSN3dremJIbkRQWkV0SlBsSDV2Y1Fk?=
 =?utf-8?B?UjJzRlVRVGIzbThqTDZiUEFYNGhEcno5NGN0bEladVVvaTdVaXhjdFVBK0xs?=
 =?utf-8?B?WXNzT2lIVDY0V280Yk05b2hnOUN2U2psOU5EaXFPU1ArMlFsekdxd2RQWlMr?=
 =?utf-8?B?T05KMm9hOWZnQXVNRzNDVDBRQ2UwRGhnaDVuM1lSZWwxc0RibFA3elRFUUxw?=
 =?utf-8?B?b0ZZeWdoNHhPWFo2aVJxVitSeTYzTTM4U2ptR0hFQm5xT2JFaSt1N1RNRzVs?=
 =?utf-8?B?amQ4ckEvcjdlcFZvR0pEc2hGbEZNeExaRGgySlFqd0tGOUoraG5JR1huL3B6?=
 =?utf-8?B?cnJVaHRNY1ZNZUV3SWNHc0JTOW9tSVZzOGxPaThrL1g3TDV5Tnp3VGYzVnJi?=
 =?utf-8?Q?o8awc6nFYJQRNmG0iJefisnLe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a96ba5-5347-4c48-fd6d-08dce6d66a7d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 13:46:16.7827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiUKgZbRHBJKXYWdApPBD//WOKmWa3np/ENPFYtCIVtCvsJm7Hz09aY1gBYt3jH1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8905
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

Am 03.10.24 um 10:13 schrieb Sunil Khatri:
> Move the error message from ring write as an optimization
> to avoid printing that message on every write instead
> print once during commit if it exceeds write the allocated
> size i.e ring->count_dw.
>
> Also we do not want to log the error message in between a
> ring write and complete the write as its mostly not harmful
> as it will overwrite stale data only as GPU read from ring
> is faster than CPU write to ring.
>
> This also remove the size of amdgpu.ko module by around
> 600Kb as write is very often used function.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 3 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 --
>   2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 690976665cf6..05b3480ecec7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -141,6 +141,9 @@ void amdgpu_ring_commit(struct amdgpu_ring *ring)
>   {
>   	uint32_t count;
>   
> +	if (ring->count_dw <= 0)
> +		DRM_ERROR("amdgpu: writing more dwords to the ring than expected!\n");
> +
>   	/* We pad to match fetch size */
>   	count = ring->funcs->align_mask + 1 -
>   		(ring->wptr & ring->funcs->align_mask);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index f93f51002201..af8824e8da49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -377,8 +377,6 @@ static inline void amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
>   
>   static inline void amdgpu_ring_write(struct amdgpu_ring *ring, uint32_t v)
>   {
> -	if (ring->count_dw <= 0)
> -		DRM_ERROR("amdgpu: writing more dwords to the ring than expected!\n");
>   	ring->ring[ring->wptr++ & ring->buf_mask] = v;
>   	ring->wptr &= ring->ptr_mask;
>   	ring->count_dw--;

