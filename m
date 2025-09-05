Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BD2CA1015
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 08:39:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5592210E382;
	Fri,  5 Sep 2025 08:39:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QsuPEjTm";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A6B510E382
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 08:39:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dO66bS6tYgejJPgMDV2EBxM0XL2Y01/CLx1u4eGSXOWJaFM7EN+UwVbaOhyuO93KzIlKfZ86iwJxIMlTN5PX6hfLoHL6ZBqMkh/P0/pF9fYSa5OhUip+LpS4wb5yNFn5W5AcLolCeQTsv6GsIvHH5XYqmdiYoLDos0fDt7aRJ0/67S57hdz10Ap5ku+E8pRzmWuQQyQ8Bmruz0rTvemU4PUnm1WYL4Vfe/srzWYnkdtLoDyktyBUO//QFXoYNhQL2ntZV7hxVrs6NY4AQOy3UrgVKELqO9K6Apz8fEW8Nz36reZv31vpZvlRGZkbjm0jkWM1AaZCaDqlCa4puqwHlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjHRjkY5GHV3r1y4K+Th//LtV3Df6fhbTsL2xC2mRmc=;
 b=P1cLeQT7UwFgRIodL6EBVcPIYg60p0oQJ+wvGBFD7chsiKv38k9xPQDHBZqe/OBtlGPDzWTK8Pvr/eTG6Cf4OTctUf+zxKgQXbXWlRs82+fPCVR+PN4NRfoFr4bjbHDbXnAqqhwrxOc/N34avdBiO+MwaeJ+POppzzIJwPknMdEqcy8+Mpiw4sfssly43sr9QxRmklTvRojxTVms464q3P9ThXWeyrHoUSNFO4ryts1lvd/1RIGc/5M3vsNQMkUepU5aV8BmdQR9uXZokEYko1+tj1wBy+SXIZKJwsAc94MFZ+9rhnrvDvPf3MPqtWVrfTBAzRrp8fzAnxgf4jsvYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjHRjkY5GHV3r1y4K+Th//LtV3Df6fhbTsL2xC2mRmc=;
 b=QsuPEjTmOH9Vsg2EWmZLY9mltX1cdvKjCCXp1N5PNlFPrGNJRB46IHyjUQir2X3z0JkSTFyghLY7NMKs55xEROVhSOK4FjO3Pihv8NquR2jFhdzujW+CxVJIbpHXNmcZO3L58SOQdoqU37uSE6wTswHIANl03C1b1DRXc/YrNIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8044.namprd12.prod.outlook.com (2603:10b6:8:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Fri, 5 Sep
 2025 08:39:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9094.017; Fri, 5 Sep 2025
 08:39:06 +0000
Message-ID: <9028e815-5b2c-42c2-bb64-55af37eae5c6@amd.com>
Date: Fri, 5 Sep 2025 10:39:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix a memory leak in fence cleanup when
 unloading
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: "Lin.Cao" <lincao12@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>
References: <20250904164543.97199-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250904164543.97199-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0399.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ae2ce6-2bb8-4838-088a-08ddec57acae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VFMzNzdtR1BXcUJVcXBKUTZGd2UwUVdvT28ycEVWeUhtZGlNaHNrQk9nRDhs?=
 =?utf-8?B?b3hiYkRQSUNteisyZFAwaHZTRVB5cEwzalNhMzgvcmpXSkJoQ3cydGpDYVhS?=
 =?utf-8?B?ZEpVY0ZKK2lncFN4WC9uTVJxNi9qbDhmT2c4alJsWm1qeGp3UmtwUVNhdlRF?=
 =?utf-8?B?Nnk5dHFZSlF2b21NYWtkamZzK0lLTm5GckFRNlBRcTduUnQ1eWdwTndrUVIx?=
 =?utf-8?B?THNhYytBV1dMWjE3QTJoSXgxZ25OZVBjQ1dqeVVBN2JmMi9DV0YwTHFuSmli?=
 =?utf-8?B?dEg2OGl5MzRaS09Kc3FVZnd6Vko4SE1LQmVFL0hCczQvZ2VEWm4wUUpWd21h?=
 =?utf-8?B?Uk1kZjFpdCtCWHI3S09MeS9UNkdNazNCVnJmUkZrN2E2UEhWbVJyZHBOOWda?=
 =?utf-8?B?WlRNN05tbWVwSUJhdXV4RExPWTFOYmU0RmgxK2J0cjhMRjZJQkFRRFhEMkVO?=
 =?utf-8?B?OWhZdmxNdVJiMTkxRXdMMXZldWFsd01HVEpqdW94THBTSTBPNVlrSlkxNnV1?=
 =?utf-8?B?Zjk1OGYvYUp3cGQyVEljcGZ0V1lFa3VuLzZnSTR4bXRTaE0xa0UxY1ZCd2lE?=
 =?utf-8?B?RUt4Y0s1ZGpoeGg4Mk0rSUJzaTZWZnhpaVdFMXdITHNBOUtsMElPVVZFdHhZ?=
 =?utf-8?B?aU9Wc2JqdnNWRjFIRGZqdDl2OHNGZ1lRc0Vnd21VMFc2akV5cFM0SFdNdjc2?=
 =?utf-8?B?QWpnUDlWaGNqWHMxWXdDMWdUUTROckFYTU92Z3hKNnYxanl1ejN4TEhncGtp?=
 =?utf-8?B?bGliTjUwTnV1SzhuSFdHaFJ3b01sN2RJc2V0ZktMa2RYczRZR01UUDMxU3Rk?=
 =?utf-8?B?cE1oTisvRm1SNWwrUWo5bndIQzVtbUJRbGgwVk5JYWZEMTA0M0h0azFPZEhC?=
 =?utf-8?B?Y1c1TnVKM0M2dkZob3F1OERzWnNvVC93RDNRbGs3bHBLWldRR1NpMUxXQnJn?=
 =?utf-8?B?ZkpzMHcrRi9xOTNOLzNPL1NxTCtFREh1T0VuZzBLSmVCbWFUMFRuWGVVN0JR?=
 =?utf-8?B?THo0STVJK0FZbjh3d0o2MlhQUHRtclhrTW5ySVZrV1FsdGhkVFB0VkltMUha?=
 =?utf-8?B?SFZFdGZwcEsyVmZZZFlGN1JlU0FPUlRiU2Zvd00zT3RwUGU2TUdZQ3RxMSts?=
 =?utf-8?B?ZmNEaVFRemZ0RnY3WFJaK1djUWhYb1l2SjQ2RnVheTZRMFZRdHhkdFdGcE1K?=
 =?utf-8?B?YndyQmpZMVB3RFJ2UmVWOHdmMWxxUWU2bHlsaGErRm5CTUlpVXlpOEd1eVZo?=
 =?utf-8?B?V0ZKSXhNbHRTMFkvK1lnZVJwaUVaelVFbk1Qa2JJczYvNWhhM3IzUmpya2dZ?=
 =?utf-8?B?eW5YWk1vR0VPbnJsQnpReWR2bTBRcHU5OUhtZWxuS2JNYjIxSm9iRVpremNx?=
 =?utf-8?B?dWQ3S3hnV3VxUlZmZ21ocnZsL01uQUVxOSthUjFEVUdCVUpjc3pHRU9Pa1Yr?=
 =?utf-8?B?MU56VjRnQW9waHZCMnl4cnV2cjVPMktsZ2c2aXpvT3dDOU54djVMK25DalRP?=
 =?utf-8?B?cHVnaTJQa2txS3VFTU5YSVB5RnIvYjQ1Q2xMby9kNS9UNnJZRWNZN0ZnVjBJ?=
 =?utf-8?B?UjcrMUdpdHBHMVdTZ1dNaXJpTExCUWJNZEVhK3VhWFVrSmNDNldNYVFzRmM0?=
 =?utf-8?B?bmljTUQ0blZvS3EvUTQzbmt0ZkRiSnczSWdEbjRYSk1xYzdrby9Cd3VhbEg4?=
 =?utf-8?B?bTJKNm1kdVdWdlVXWGo4QUw5SnkrcWk0dEV0bU9nZ0pzNGtKdkJjWVRuQXpZ?=
 =?utf-8?B?WXAwM1BKcThXT21yN05URXlqM0JFM2dxdFdCWXRxVGZkMXErN09XdW5iMnM3?=
 =?utf-8?B?UzZOWHp0UmMxRkxMSThQSDFXQzZJNmM1eDN6S3RoYTRpcEYyeUpWY2NaNTc2?=
 =?utf-8?B?eVhrSnRydXZwM1BjYVdudEVtVzV0RkJGZlFQN1RPSHN6enRKLzA3NEczcUdC?=
 =?utf-8?Q?bpvLhj6XEHY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekEvOElsaTBzOEk4ekZXaXR4WmZrRFU2aTJKSllIM2dSeVJQTUdQV2c4ZU1M?=
 =?utf-8?B?M2RHS0VXQ0liSGx0VFJId2UrSkcwbmVaSU1kQmgvN2Q0TDlIVGhHMEpkQnBP?=
 =?utf-8?B?enhGRDdEYStRTGZYMDdEaVduTFpUMGtXRkh3Zm9FblhEa21xQ2xLTjBNamh0?=
 =?utf-8?B?SjhBdnMzYmtIOGFKREtkeUdmNG5ibEd6R1JLbmpJWk1aSFBHTzA5YmxobDBj?=
 =?utf-8?B?K0VreG9IWGozY3dKL3lOTEpmdENmN0M3aFBWTEdtWEVYa1k1MnR2Ym4xaGRV?=
 =?utf-8?B?L2dtNXBUMkhHdTB0QnpZNnpSdVd1UkZRWEZmNTFTNFEwQ0FuUWFVOVJSQkxx?=
 =?utf-8?B?UDd5Z0ZkMC8xL0Jvc2VRd1pMcWpFOVMvV2VtYXd2MHArbW9VdjM3N0RoRlNF?=
 =?utf-8?B?dWNUb2dIVjZudG1pOCtsbmdnc0l1Y093MUdVRUhOR3ZjRVNnek9qeWNGUG53?=
 =?utf-8?B?dFF1OUNNQmVQTzlsd1lDMjBqaDR6ZGNrOCtUU2VlMnVlcGs3Q0hhNVNPdFl4?=
 =?utf-8?B?MGg1cWF2aXJtakpVOFYxYllPbHl4bXB5L1FmQWcrMVNvZUNtMmJjWEFTSiti?=
 =?utf-8?B?Uitmbk9vNmxVWnJPR3RBbW5BNzIvWG5ZaDAvWGZqNnpVWDQvclEwNnJsd1pa?=
 =?utf-8?B?L21TT2RSVVJEOWNReVFHVUx2QzlQOExkUDgwSEg1anYwSDU2bTNURHVzMjlx?=
 =?utf-8?B?QzIrSDhoWXN4dzgvazl0ajd6SU9pUWNTRHIxamZQS3NTUDRZTC92NURLVFpm?=
 =?utf-8?B?VWhud1hxTnJ4MTFxQnJMNFhXbCtjZ0I1N0dqbWJSVjh3SGtLTzdIWU1pY0xH?=
 =?utf-8?B?YVMyZXM0N1pqdDc0aXMyTGJvMDNVQlEzdU9YV0gzejJSR3N4Tk5KMTlOZ3Iy?=
 =?utf-8?B?WHJpM1BpOTBYbXFZaHJXL1MrNjhUVlMvcnM4Tk5KUG9aYkhkU1FCTDBPNGhE?=
 =?utf-8?B?eEFVZDBRRzhOVDg0NFpQSU5naStXeEx3VWpNd21oSmlGaVc1UGMzV21oZlFY?=
 =?utf-8?B?TVQ4WkZ2b29JMUdMa29aTFdHMnZyRzhEUHU3MTEzSXZOTWc2OXlnWXdaK29W?=
 =?utf-8?B?OStoOStRRHQvTnRLQzV1YTZkbWN5eTdXM0g4a0VINVF5cURZdnY1RXMrU3lM?=
 =?utf-8?B?K1NyUUh1TzYxWXpVY3VXTWM1SXByeVJlcWtVZk1rMlBJT0I0S2FjcVZJSVJw?=
 =?utf-8?B?R2Q5SnpLQ0JydzF0V1VuR2FtS053NTMydzJvMjlkdERCR05YaGdpV1MrdlJ4?=
 =?utf-8?B?ODVKZlJ2YjFaUjBvWVE5TTdiY2paUmJTNzYvRTBoVEUrV0hEWWtvcWREUDBQ?=
 =?utf-8?B?ZDN0S0dRVlk1NnlaSFhhTncxVTg4S2s2UUhPVG9FL3QzemRkR1RabWJnQTg0?=
 =?utf-8?B?Q1Y4aUlwRXRaU2xMekVicERPdlQ1dWVRMFF4dVI2V2h5b3cvYUcxRWw3RnYx?=
 =?utf-8?B?UC9qdlB5UGZ6NVptRkwzOXRkYUxpUU9acUVPbnJobWxrT2JTcnA5eDZ6WlFu?=
 =?utf-8?B?TTRyQ0JFZVZpbVJHU3NPWHhxaU1kS2NoRVNYT0N5WW5nbmw5SG9zamhpMVlr?=
 =?utf-8?B?WFB6MjlvbXpHMUlrWEV3YXZHYm4wS2xzSWxOalBSZ2kxMWtyb0JXTC96d0JE?=
 =?utf-8?B?SExBN3ZsNHU3MXYwSVoybm5NTnN4YXhGaXcrVGlOeDFjYW9kTWIrSnNCcVpk?=
 =?utf-8?B?c1NEdGI5aXplVU02ZkdQOEZWOWxXamw2b2dlV1daZkdDTTdwOEkza2I5Qjhu?=
 =?utf-8?B?N2xNK2FGRmNRZTJFN01KOHpDTm83Uzh5bys5UUcvS05VQ3lscEhwR2l3YVA1?=
 =?utf-8?B?ajhJcVVOVFZxWklZaDZlMWE0VTZsZjZDYWdWcmgxdTFIUmw5Vlc4R2tMQndl?=
 =?utf-8?B?UXc3ek9rZUNVUkdyY3UwWjFZS3RqVnR2Zmc5SEI3emVocWlSQ0JJeEJJY1hi?=
 =?utf-8?B?bUhmL0hkc3F3UlZOa0dxdldIVVk0YVA1V2FDWnArRWdaTmRiRXlJNG5NKzJ1?=
 =?utf-8?B?b2FJeG40NlQwK3ZqUHBFYldpMk9FU1RES3NNejB4clZrWC8wSU9UdWVIbXFS?=
 =?utf-8?B?bW1IY2ZRRjFtWm54UHJKZGdaTDRQaUx1QUpTZXA4OHBVOC9ScXo5aFRFK0Zt?=
 =?utf-8?Q?h1s+wVI/uNGdHSA4QY3m/tz/V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ae2ce6-2bb8-4838-088a-08ddec57acae
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 08:39:06.2566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8JtcjYrinBFTh+L2TbzHjfJTOIPprCOD3G92rZZdLT4dhRUNXPm2UMtkRLsNAQx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8044
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

On 04.09.25 18:45, Alex Deucher wrote:
> Commit b61badd20b44 ("drm/amdgpu: fix usage slab after free")
> reordered when amdgpu_fence_driver_sw_fini() was called after
> that patch, amdgpu_fence_driver_sw_fini() effectively became
> a no-op as the sched entities we never freed because the
> ring pointers were already set to NULL.  Remove the NULL
> setting.
> 
> Reported-by: Lin.Cao <lincao12@amd.com>
> Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Fixes: b61badd20b44 ("drm/amdgpu: fix usage slab after free")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 725d6437fe8e3..375f99082b407 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -421,8 +421,6 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
>  	dma_fence_put(ring->vmid_wait);
>  	ring->vmid_wait = NULL;
>  	ring->me = 0;
> -
> -	ring->adev->rings[ring->idx] = NULL;
>  }
>  
>  /**

