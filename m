Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B133EBFD10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 08:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDCA510E36B;
	Mon, 13 Apr 2026 08:09:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u83CR/6I";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011040.outbound.protection.outlook.com
 [40.93.194.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2523410E0CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 08:09:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zqy54FxmrcLpiPNyGpOlIkC+CYUcOXu4r0YnCX3wUgW+NBh5LRBMbVqpGHQVneEoMU7npAufdF9I/XwrMFddxjjKvI8TzQiDmqgk8QVCklrmBYuHlqaFRtn/h7041uywujyd8zkoIPAWoNTy2ziW8UCzGVlHx+ezrkDfNKiUIVM6524wnca8w0SV42ua7hu5eoYrskUj/+G+pvx9A2nUR+SkBEkM3zJ9ZFoWcVLQSDMNtT6QeQ/9Zb8vSuRtDHLHZJO2IoHy6/2qOqz0FOF4YEIEVjNm6d7ilDs+kYjYuvtcPSpVNwlxzyOhtwB1F5noEaaNYNvRjBuNpxR2ZJVlBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xwdo1ZQrr5SSiSLp3EdqAYUrXal3H7PGaRdzIMS6tZ0=;
 b=Zv8mhaloL3pRmKZtFda/u2ApyayIEFnYIGM+vakCyT8W/LYchUzqHKrrjeNlra+ODvHsbcGXAuLaWnok0R3aE8VE4NqlSeJ1lf8Ja6zmHGdwqXg5klXeIINojWpErkuEHgMQ5YS2Y6WZjAsPHreXbVOPZjZJmGZpVUtScVNF3lJSo5c0XEKMafev0F197umoeJbhX7uM5AyaWrlhisp2hnMQ9yreZ6UsIRBeXPbd17JfH0gtTybYv58u3NQgdTc6Opbgx6JDVXWLig5CoHmyYjsQT1NOLs3L3SQZlB88j67VfOFsseKqm04GdQNtu/DiV/HqmbL2qfz2MH8MkuylCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xwdo1ZQrr5SSiSLp3EdqAYUrXal3H7PGaRdzIMS6tZ0=;
 b=u83CR/6IKI3KE6RTIiSzPwHx6rpKqQhzYj8cvXCLrouhxSR6CNQFrZWPJF9uM6sAB+dCfGQe3zbwUvpGlEnOxMJBz30PJmU7zGU1X0Vv7chyPWg9aQSg0jLj4zy0lkljINLzx5OpgN3xibo2uoq2YNyiET64Zy7WgG8obUQ919E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Mon, 13 Apr
 2026 08:08:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 08:08:57 +0000
Message-ID: <eddfc400-5b5c-4320-964f-c7b57b749bb1@amd.com>
Date: Mon, 13 Apr 2026 10:08:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] drm/amdgpu/userq: unmap_helper dont return the
 queue state
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260413062153.4050981-1-sunil.khatri@amd.com>
 <20260413062153.4050981-7-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260413062153.4050981-7-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0011.namprd14.prod.outlook.com
 (2603:10b6:208:23e::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: e41142ec-1fc3-4f8b-c029-08de9933e983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 7wUqbY7pBhTzbH0UXmwk9NVdPzGsuYSVRP13RsYHFOLOGJilVwXUlJT02xoNgf3qTDD2Pst6aCYnS2hMPEMXR3SUh2m/1ruAZCPMRZBf7qTF2CpU5h3m/fBAKAQsdTXuqU2egVYlP5nZ1bH/+kDVrjTh4uPCyiB5Kgcy6qaD8PKBcCprIK4WqcqLxvMwJMno+LAvqUJyafo1eKXgS3p1mYG81rDECelHxiCbUFVmMtC3xp0lNKVyNFDydLWUMWaQiyJclY9Y1t0BF4aJJULfYyknDBEZokozZybZ1JCBzpE5ucEMpheCsnVTTQl+s5wSCrwOUTobtIij+u4NC+AbSCU4Ng5/hIz8wKE4nHUdmWWsDedF2Frse1vex5eqb7+ujFEbYUiIIGY/9/RwQLDnAnZGU5eHgVk5cFiJ+4WJ/dujtmZfzD8QtWkbH2aR/Kdx9P4Cp51B1pLuSUAGiZYsPOGCX9D35sM+A/seMEqV3BchMva6pLB9jGO7MBjzxj1RMEvVp4XZ/uRCsxDeXaWSJLyQ/NtFMgRrW456D55Ntg/FgwN0aJzzFu+3brpiuCg+HXhSI7rMRiKaaOtNWo/ofdmuoSqUJxmS0lzFdT1muIoN5eKoXRAHdXaFcbk+EyA7r63OzJDO1/bmNBo6c5NuKojXsHrGq2LYr3jusKZg+3UXdK055hpo4tiTSxF8ORH31nVtWwRlUxVRUYRZMgv1viY0MGUP57QL8LNvE7tMReI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmxMc04xWlpCYVBnT3gwaVVua3lNWnRaZDNpUlhLUmhzbVh1dm9GZUVkenla?=
 =?utf-8?B?VktTRUlmTDdTbHliNWpSamhaT1JYR0R3R2plbUMrUnhqR25KZjF0eGJTOUVi?=
 =?utf-8?B?azlSUWdaNUFDNXJUeXpVSHhjNWlaaXZ3MzRSbHIwNDlSOGZmZkZvcld1Z2xF?=
 =?utf-8?B?emhWZXZ4c0Z4ekw3MnMxMGhKS3BLVng0VW45b09oQWRtWXZyakMrd1JncWl3?=
 =?utf-8?B?QmNwRm41M1lqb3pDK1NvN1E3ejA5dlJuVDlxSzErTkNwOXFwMk14bHJnZnF0?=
 =?utf-8?B?ajlnVUUwNEN6K3RXU1MzeStyMkZLaW5SMHBQRmlTRTc4c0pVcDl4RSs3QWQ3?=
 =?utf-8?B?eHdaSTBmcjFNeS9waHpzaGp4c0FTc0hLM1NVaUNIbElWYXBUeXQyWkcxTS94?=
 =?utf-8?B?M2UrVXYvdVpwTHZpOWgyY3Qzb1h1dWorTFgrQkdUdURBMVp3SnpnVGIwWjJF?=
 =?utf-8?B?WEJOUWI3M05aRjZMM0ViSnpPbllUQU5zalFSeHhmcEM2T0YxU2lQdXU0MTRy?=
 =?utf-8?B?c2wydGh3OGJNQVptS3BTTGxFaFlsTmVtYkdIWUVrYmxkTnVIVHVJMUZZSE1F?=
 =?utf-8?B?WGNSaWg3N202UkZ5d2EvRDZ2QTdYcGZleW5RT2ZiOFNBY0lhSWYrdE92bnFR?=
 =?utf-8?B?eEVqcUlUSVRwbkFzNTQrS3JvZTA1Mk92ais1M0wzWE5raUtCZUVzM1ZDbUJw?=
 =?utf-8?B?YkMxZmY0dEZITytEZDloeUlsSlRrTWtndjB3aDhmbENrZWtDc3A3U2MxRGRp?=
 =?utf-8?B?blVyTlpIZGE0TjVLeWRxdFl6UVlrZEVwMG9uM0RTTFB0cXo5dVVwZHlRVlpZ?=
 =?utf-8?B?TjlKMVhoYkhFa3NqTHFGajZFOG16Y3g5aDFmUTZkN3lsZ0g1LzUrUnEzM3VD?=
 =?utf-8?B?SXg4ME5oZnd0OGxUMW1vaFhEWGZaZDl3SVZuSFFQVEFlTjlqMGFCMGtZY21H?=
 =?utf-8?B?a2JKYzJQb29sdmpiT3JKRkdINVdpN2xXUkJCeDhueHFjUnRkSWdjMytNQUZV?=
 =?utf-8?B?OFlVdGtyd2Nvb05lOXAvRXBUb3hSMmhwY0ozTUo1R09rTktidkRyMmppL0VO?=
 =?utf-8?B?ZjcycGxSdEQzV2tSOHBhMlpUWXNxNG9UbTZJVEhHaUtuclIwS3BCNWlsWXQ5?=
 =?utf-8?B?SG8wT04rNUFOUENJM051UnNUeEtFN0dHNFdWWnRrV1JINU92UTkxdm1kYm5X?=
 =?utf-8?B?U0xBS1BVS3hURVlTY3k4WDJ2bWZGZEFGcFRUS0dTZ1FUUVpLbFAwSWdQSFc5?=
 =?utf-8?B?SVQvNC9PVFgrSmx6Y1dMRkFEZGNQSFcvaFlDc001T0JiQXROc2VEMzZ3Umdw?=
 =?utf-8?B?VVYycTZFVmxBQ0lGUGNFTm1MVmcwUCtGOURLZDBjUlk0SXU0TndhTzdGSWtB?=
 =?utf-8?B?U3VWMlY4NC9JQkRhYTNMaXBBOE0rbTVPSm40ZWR5Vkk2Um5GRldraytaSHNs?=
 =?utf-8?B?K0V4OUdaRjFRcXQ1UXdhSkhkbjdhU2t2MDhqUEtZR0FUY1FkK2RJZXp4aFBJ?=
 =?utf-8?B?eTVyTktaaVpWTG9BUWN1UXBLcFlQVlk4d21PSElNZzR4SGNBaHExM3RlS01n?=
 =?utf-8?B?M3BzbDRJY1pGYzRoOXpadTRZQ1NiZU8zWEtwR3Y2bHFjSFFuYSt5WmQrdDRv?=
 =?utf-8?B?S2MvajdTYlUyVDBxdzJKeEhnVklaM3ZkZllFY0xUS1dBS3R2VHpxUVE4d0Qr?=
 =?utf-8?B?ZVVJUWhSS1pqNWtidStIMHJaQndjTDlGYmQySTBiVDFFZnhtdExWeUdERUVY?=
 =?utf-8?B?dVJCMy9CRkdGRFI3ZW5kL0lrUmNuTnl2SWZncDMweVdISjBoK3Z0VVlTYlg2?=
 =?utf-8?B?WmRKS2w5WUI2Rk4zRWJ3WU93R2V1aUIrbEwvMldldTliKzdiaGtVc29zMU1v?=
 =?utf-8?B?MTVGZkRhRFpibEQ1TXg3NmptMllQdTBNTW13WWJWMWI4b0kxVTlNMjNkTVpT?=
 =?utf-8?B?K3o1cnM4T29NYXRDaVJmK1Q2azlwSXN0QlA1bEtQdUJ6SUFLeHhuUjVrbHZX?=
 =?utf-8?B?ajFaYzcyWThFY3pBY21uL1p0YU1zdE9mYm1uRnN4REswQ1RYZStSUHFyaGJL?=
 =?utf-8?B?YzZmaG9QWDZHTzJuVXNDQTVZdVpFUi9ESVN4RXN0QUQ2MzU5NWNISmxoSk5m?=
 =?utf-8?B?eUZ3dk4vQStEUWszZE44RkpsVXNia1lKVmI3TVJIaTEyNU9yandTWXB6Tkdt?=
 =?utf-8?B?aUJld0ZTdjV2ZHBsK3VTS2d1c0xXVURkMkZWSmUvaEd6NnZ6SkhjRHIzTXk0?=
 =?utf-8?B?YkVScHZxM1RaTkVCanZIVkZ1Vkp2NTYyUmJ5VmQxSHh6clQzVi82a3grSjNB?=
 =?utf-8?Q?bTEXKEmmZaSU6HyZl3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41142ec-1fc3-4f8b-c029-08de9933e983
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 08:08:57.4946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgMujJEERtZzlLKYTOqH5BCaOaCR2oIyHmrBy725JSs2AiZVFF55q+mwM1rw4Uc0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991
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



On 4/13/26 08:21, Sunil Khatri wrote:
> We check for return value of amdgpu_userq_unmap_helper and
> compare it against the queue->state which is logically
> wrong and we should just check for failure and do the needfull.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 86e7a93e93a4..e6d1811172b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -641,7 +641,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  	amdgpu_userq_detect_and_reset_queues(uq_mgr);
>  	r = amdgpu_userq_unmap_helper(queue);
>  	/*TODO: It requires a reset for userq hw unmap error*/
> -	if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
> +	if (unlikely(r != 0)) {

Usually either just if (r) or explicitly checking for if (r < 0).

And unlikely is only justified if it is a performance critical code path which that here clearly isn't.

Regards,
Christian.

>  		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
>  		queue->state = AMDGPU_USERQ_STATE_HUNG;
>  	}

