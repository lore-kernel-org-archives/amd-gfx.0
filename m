Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC67FCCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 13:33:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82B4610EB3A;
	Fri, 31 Oct 2025 13:33:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ddaLJJ9w";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72B9710EB3A
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 13:33:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bj4e2GA66WeEDucHs+uOf36lCi0zT/Gv2TlEvYFHCtPGy1+kpr6YtwfS8HzLSNm8p9qVcIBwVcrmjc8CvNm0go8MWmimu1zflamoBdbRTEVG8+umDV2hBJx4zyp13jvPzRBv+sWDxU9nH7jS+m8AEHEkp+U8x86a5yqTHk+bNT3mJ3P09UFT4DiM0twmSfUFbeWQTAeZSteGW8GIsWZKw81oPjTUkuhzmbRFT+fdal+rl8lMfISZqAjyO+Y78oyIxP8YgrEX7diXdIMszpaDz74GD+wAHE7bb9f0B4u4iUvWaWDcM9vDX9LQILoodd5iwUNMwJif6Lel/V50o4a8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3owVEmQXh5yQHfO49woTulI+AYWFgM+WQBZzQ6ktrTU=;
 b=C0OXBgbUIczo3mjYfcfbdcUJdLxvx0I4EaK0y8melvXDkDwX7FXyszeYq9WbORO8ODRVXMNWchZGVg5z+zorWjRaOQxdnUQMcQNNtrOGvMpL9p/6Auzf1fbPjUeGN8pnyMESLQh4qxYRtLkmT4wpmB6LhXqlbYWwjSBSdKCR2NDlzBuQmQ1BUbQubkMSkRX+eODt/HmFoPBbNPLJmStVJ+wg6LX+KCyaT+nwF6bvDv6mLLyPjjRRQMvJ2G6Mpcs4/+HH6MjH1BVNygU2t98UtRtvc2hL/Y5AVemxjTMC5MQ3/CCgAuHSS0eYQ3xd4dEvQ88K9VkLTtr8zTfTcRe40A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3owVEmQXh5yQHfO49woTulI+AYWFgM+WQBZzQ6ktrTU=;
 b=ddaLJJ9w9+7jO0HBioltn2Yz7SFl6jjZTn3emkHgBVq6/MEVFrTilPgDLE55rTaYkxM9F2MGDyBDmcccg8wSk4Sz1bXSezhj1fYasDwv/lwxmw44Vs0pQQYEnx/GpZ4bB+gesDvTmbUdl17lTFHaNeuz6wTgulJGlbOver+ApM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS0PR12MB8501.namprd12.prod.outlook.com (2603:10b6:8:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 13:33:46 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9253.018; Fri, 31 Oct 2025
 13:33:46 +0000
Message-ID: <6086b253-5a8d-4555-91c6-d9f976e65ee2@amd.com>
Date: Fri, 31 Oct 2025 09:33:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Don't clear PT after process killed
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Gang.Ba@amd.com
References: <20251030190125.15969-1-Philip.Yang@amd.com>
 <a901ee14-81ce-4cfd-bdde-21eeb57fb965@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <a901ee14-81ce-4cfd-bdde-21eeb57fb965@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0160.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::29) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS0PR12MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: d06f422a-ea7c-4810-376c-08de18821df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UU5IVG5Ba2JwMUY3bjJSQlhuNDBaUFpTNzZ1SXFURVpEa3pDMFQ0ZWZ2VlBw?=
 =?utf-8?B?Y0NMTkVBUVlBRllWUlp3RXRQeS8vR3o0Rkg0ZVpsbElGUEJTZFI0UjQ4YTNI?=
 =?utf-8?B?Qk5Yb2NtN2dldExlN3pVbE5WZHdTUkxXOW5PMFZLSDZoMEgzRnBIYlNkdU91?=
 =?utf-8?B?MUdodis4a1NsdHlvUWdIcmNPT0F4QjZjSnpBOE42NHJOMXZJdWJONmw0aFpu?=
 =?utf-8?B?bDR0QkhmK1o1ODdpWWtnK3crbHZTdDZrQ0RRQ0xzQXd1Ym44UlBtNmhuT3Rw?=
 =?utf-8?B?MDZWa25IRjhaVzhmWUtpTS83VFp3am1ZV2V0YUN1M1hJY1Vlcy9VVHFJOW96?=
 =?utf-8?B?a1ZUYkphZHFlbytiMVNkaHU2MEhZMW1HK3RUQys5TmdRS2RZY3RUVUxqUVdC?=
 =?utf-8?B?cTdaL3R6TjErM1R2SktoU2sxdzlBbkRJSUl5UG1WYlVvTkd6M1FLOHVPNVo0?=
 =?utf-8?B?OUY1VTVHdFdERnEydnFjY2hQZjZpRitFZVZ6M1NsdWcyR21QbHViOFZ6cGtj?=
 =?utf-8?B?MkpHcm9DWUVrR0V4OVJ0ZEVveGlKeWZZQ0R0aGhpZ3RpQjZWSTkwZW9rRjNi?=
 =?utf-8?B?L2NJMlN0cHB6cFFHU1Mvd2VLdU4zOGtHTnZaVUN5OWo1M3ZFQUI1MkNjWXdi?=
 =?utf-8?B?ZitEWHhXcis5eWlqeXRFczBKdThPSDF0TnB5UWk5OFJzd2pLSGdQekJmcXZy?=
 =?utf-8?B?RWczQVFMSklBZjFFRmVnWEhBakk3Y24yaHQ4N0R1VTBWaVlNUFdOTDdrK1BR?=
 =?utf-8?B?NytySGN5cGxQeEFWMkxBNCtxbEU3QTFxZWczNW5vMVpJTTN5NDhWMndYUmxL?=
 =?utf-8?B?bkNTMWYyc203eHBIU2p5aXljZHFLQURCT1hFQjJUL3FiMUVaVDBPYXRrckwr?=
 =?utf-8?B?UENsYng1WTcyYXdZYjYwbGliYTZmZ1h1a1ZsdFFSaHBQVCtmQUprbnB6NGFO?=
 =?utf-8?B?OTBHT0Y2QnNhTmxtNXhGUW9sNU9MdE5IQWlNY29Fem5qcW0yK1hEaFNudjJW?=
 =?utf-8?B?bE14bmg3MkdCbXpWdzlaa0FCelBPa3RzcnNDaTI2QUo4OExPWW4rOGN2OXBI?=
 =?utf-8?B?RFUwMVB5NjdnelREUjlscllUMWZzcW9USkZQVFlHeVhjQ3hXU3hJemkxWXBU?=
 =?utf-8?B?TTNNakgyM1VEY0l4aExDMUdNWWZCQzlUNlJFQTlKWXhmaXNvRWhaRTBubVZ1?=
 =?utf-8?B?eTV1M3ArOExSOGFtWnlnZkYxQWUyZTdwZ3kyeUZaak9pUmptRkc0STB6MGRR?=
 =?utf-8?B?ZFl4ejgyV25zTjNtM2hnQy8zcmhsMnNUYVFZeGJRZ3phRUZGdzhqNWdtSUNJ?=
 =?utf-8?B?a2hsQWRhVG9lN3BZNWx2MnpnRncvWHIxTWdpQ0R2SWdpV1RIRUViU3JmaCto?=
 =?utf-8?B?QVdteitCUkFSWTRpNTcrRHZwaE1FYmxPR0s4TzY0ZVIvWGdNUWtodXBYenJT?=
 =?utf-8?B?Y1VBMjJlVCtoWVFrZW9ZWHRTbkdwQVRrdWNNSk0wd0tVUkd2OTVTS2Irek9S?=
 =?utf-8?B?QmV3YjNWcFlTeEUyb0dxbUVDbzdVUWgzZkgvN3Nuemh4Um5BeCtneEpQd0NF?=
 =?utf-8?B?L0s4ZDZaTm96d3BKQk1WZGVzRkZwNi9RVExGODFsTFhMdDBqamNNTzFuQU5y?=
 =?utf-8?B?SUlBUnBhb0ZIajNMb0ZXdDVVNy95dEN2Y3pHWnl6QWtDcWJaZ2Y4WVBnTzJv?=
 =?utf-8?B?MTdVeC90U0tXWE4wclM4MFVBcjgvSTkxdGQ0cXU5UHlCUzErME5RWEplbzhM?=
 =?utf-8?B?QnVaV2czOFZjRnBBa1VodWo1WldJWFJacS9DZXFycUpZU05KTVZWNlpXalI5?=
 =?utf-8?B?QVptb0grZGkxT1NJR3V6OFc5ZTVscnE3ZkFQaDVyY0FMcGtaNzlVbnBWZFA1?=
 =?utf-8?B?Z3NVRXkwVmRYVWxXNERrTmlybThGa1VRQTVUb1ZaQVVLWXVoZGVlRGtKUDVy?=
 =?utf-8?Q?33CnI+teN3EBM0GWnWV+D31TCJx0b78S?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3F1akpaczdFNTZqb2c2ajhnd3pRdnFHdmxwMVdmcmR2OWp4b3JmYlplOXZK?=
 =?utf-8?B?c1Y0eEZDaTlzdEVDeVl4TXp0aWdSeEg4NGFMY3hBVm00ZmpMcTBGaVgvWURN?=
 =?utf-8?B?SWhPNzdYYUl6MjdTTTd2eEVBbStCV2N3L1RUU21NbGtMNktCYVIrZFFkUmRF?=
 =?utf-8?B?K1IwZmt4b0JzWXJWTlplR292ZGF6Vll2NmJMY0NyMTZkZHJ0OGVpcXIyQ2xn?=
 =?utf-8?B?cHY2cVVMdFU4cURncitnRFE4dDZDbHdvVHBMdUhubVJ3M2F5Q0RubGNJSWIv?=
 =?utf-8?B?dGRRc1R0TG5NdVMzMjN6QXMyNEcwNHhoSWNOS2RNV0s4eC9VeVFaZm1BZ0Ru?=
 =?utf-8?B?Zng0azYveHBhSlpUNHcyWmtmRys0T29HNDI1TlhPMmE0VSthVEVkY29ScXpT?=
 =?utf-8?B?anFwV0N3dUtobjV3bTNsNzV3ZmJ4bkxucjRSY3kveHJVTGU3aVQ2eGNwbmpz?=
 =?utf-8?B?d2xJRktwTzZlSHlZeGQ5aTVzbmJSNU9zdENJTDdLWXFNbDhETEVrTVFObGtK?=
 =?utf-8?B?bXcyam4rb3JMQjlQdGxPdG4vdXJhTzVzaVdVcUE0SE1Gci9JZVlxaFY5ZmdF?=
 =?utf-8?B?T3FHNFlGTEdzSzVvcGpTSTJ0a0Y2NmVtTTY3bS9ma3BlNDRLclQ0Z1c3V2Fa?=
 =?utf-8?B?YnZkZ3ZWYW1HWjErc0I5Y251UzdDM1NKRWhZalkrdFJuZ1B3NmJYRGxoSTBW?=
 =?utf-8?B?Z1hhNXRzSGZjSGc1UmN3U3lreURSOEp5R3puUko4YXNuOUszL1FsdE5Eb0lp?=
 =?utf-8?B?dnlJWDhZekpuRXVFc28rM0xXSWk4U3o2MjlERUY5di9mcGU4RUFTZ0tPdzVh?=
 =?utf-8?B?THpmZ3lDcEhuU2Vzbzg4czgrcTVLRG9VY01Ya0VDTEMweG5ZRkMxdjJIRFRR?=
 =?utf-8?B?QlI1YlMxM2daOWZSV2I0ZlhQVGRNZ2V3ZkhNemI5UG51T2ZvcVcyYzBSdk9P?=
 =?utf-8?B?Sm84WTdjbFFzam5kcUV3NEU5ZXV0dlIweFJVTXorU0RENUhoRWY0aXZqRW8z?=
 =?utf-8?B?ajlwc1ViMzVPdTl5cE4wR0diL1BWTkFadXBQQms5YW9EUm1icU9pRUFuS0lQ?=
 =?utf-8?B?Q05lRkVDSkNObm1vb1JEb2hSQkh1dzdubjZLb1JVZjJoTFlTdXlNNmc5RWpi?=
 =?utf-8?B?OGs5dWpPeUY2a0UwWkRIUTJreGl0Y3NicnNqNW9Zb0FSRGJRaSs2ZHJIeVQw?=
 =?utf-8?B?bXNjTTF3TWNZT1RHS2M2NE1sTXovVnBiLy9mS25GVU8zNmpheDdYanVtTW1v?=
 =?utf-8?B?SEw3NmZ3NVZPTmtUaG9zU2syUjRnY21XWWl6U05NRWt6M1gwMW9QRkloMmY5?=
 =?utf-8?B?NkF6SEs3Tkh3VzRhZy92RGdKZ0k0ZExoUDVPWnFwU0lRSy9yTGhSQkVzanQ0?=
 =?utf-8?B?NUI4N3ZvbVNnd2ZQYWhITHR0UjQ0eVk0VmlhMTdyeXc4SkNEd2t4Y1VSOE1P?=
 =?utf-8?B?Kzd4eEQzRUd0WGdNNUkvU1BtSWZMcWZFUm1YcndDSFR4QmZMbDRCbG95N3RD?=
 =?utf-8?B?ZFNleEtGN01UeENBL0VOSWNqNHpSWmwxOHo3WC9vY0FqMDNJZWJWNXcxME5s?=
 =?utf-8?B?cEJIZU9yUVdiaGcyRVZGUWUxQWJDeUJJblVGOFBKejB4cG5xTU40c2c5NDFG?=
 =?utf-8?B?VUs3SEVVWThoWWZLbTJ6aVk1YnZVb1BKOFYza1pJWHNTa2J3MGxVa1VUWU9r?=
 =?utf-8?B?S2I1N2hKMjVobWQ3S2ZOMklwbkNyTUZxUnlOTzVNRVZWNHlSc2dWSG91RHI0?=
 =?utf-8?B?Y3YyVkpzMWluWG9ZTytPdU14UU9uWVdvOWpwRytTOFBFQVRBT2xBa2lTZk9z?=
 =?utf-8?B?SDFiY2kwNGk3TlVaZDZhZjVrdU9sbXo2MWlhdXpXT0tRY3RoTEJlNFBpNXZV?=
 =?utf-8?B?aFBLUkM4NHpTa0ZoeVZ6UUxsQ0haY056SG1SbTdKaG43QW9QdFA4K2NSWllL?=
 =?utf-8?B?amhTMVFSWm01S3dnRmZSeWZuSlFiTUYwNGZ3bll5VlBlSHBaQ0xXUVBma3R4?=
 =?utf-8?B?eUE5ZlJCZ1B2VWh1M0xsYW1ybVVHcjZhVlBUZFpBOStacEowMHA3TFptZnRL?=
 =?utf-8?B?d3FRRnoxem1tTDhqSnExaHZESC82c3BiTXFqd0RhMVNIQjZMQnZMNnplVkVN?=
 =?utf-8?Q?8v6QNqoj9A66GIQOwo9ipwPfh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06f422a-ea7c-4810-376c-08de18821df4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 13:33:46.2032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwtE2fqWYiKk8DT/tADYqU6f50loQ/IBUxEdzzPhjVz/zW7W8vJttr26W5zXJEAM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8501
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


On 2025-10-31 03:42, Christian König wrote:
> On 10/30/25 20:01, Philip Yang wrote:
>> Move amdgpu_vm_ready check to inside amdgpu_vm_clear_freed, this removes
>> the duplicate code, also removes the error message "*ERROR* Trying to
>> push to a killed entity" when KFD release wq unmap_bo_from_gpuvm to
>> unmap outstanding BOs if using SDMA update page table.
> In general good idea to have that fixed, but the ready check should stay outside of amdgpu_vm_clear_freed().
>
> Background is that there are more operations than only clearling the freed covered by this check.

ok, then I will add amdgpu_vm_ready check inside unmap_bo_from_gpuvm to 
remove the ERROR message, leave the possible cleanup in another patch as 
it is tricky to handle the error path, amdgpu_dma_buf_move_notify also 
calls amdgpu_vm_clear_freed without checking vm ready.

Thanks,

Philip

>
> Regards,
> Christian.
>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 3 ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 9 ++-------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 2 ++
>>   3 files changed, 4 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index ecdfe6cb36cc..6e1a5b922eb1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -1116,9 +1116,6 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>>   		}
>>   	}
>>   
>> -	if (!amdgpu_vm_ready(vm))
>> -		return -EINVAL;
>> -
>>   	r = amdgpu_vm_clear_freed(adev, vm, NULL);
>>   	if (r)
>>   		return r;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index ce073e894584..f6c297d62cfe 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -373,11 +373,9 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>>   
>>   	amdgpu_vm_bo_del(adev, bo_va);
>>   	amdgpu_vm_bo_update_shared(bo);
>> -	if (!amdgpu_vm_ready(vm))
>> -		goto out_unlock;
>>   
>>   	r = amdgpu_vm_clear_freed(adev, vm, &fence);
>> -	if (unlikely(r < 0))
>> +	if (unlikely(r < 0 && r != -EINVAL))
>>   		dev_err(adev->dev, "failed to clear page "
>>   			"tables on GEM object close (%ld)\n", r);
>>   	if (r || !fence)
>> @@ -387,7 +385,7 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
>>   	dma_fence_put(fence);
>>   
>>   out_unlock:
>> -	if (r)
>> +	if (r && r != -EINVAL)
>>   		dev_err(adev->dev, "leaking bo va (%ld)\n", r);
>>   	drm_exec_fini(&exec);
>>   }
>> @@ -766,9 +764,6 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>>   	struct dma_fence *fence = dma_fence_get_stub();
>>   	int r;
>>   
>> -	if (!amdgpu_vm_ready(vm))
>> -		return fence;
>> -
>>   	r = amdgpu_vm_clear_freed(adev, vm, &fence);
>>   	if (r)
>>   		goto error;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index db66b4232de0..febdd1b4286c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1543,6 +1543,8 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>>   	struct amdgpu_sync sync;
>>   	int r;
>>   
>> +	if (!amdgpu_vm_ready(vm))
>> +		return -EINVAL;
>>   
>>   	/*
>>   	 * Implicitly sync to command submissions in the same VM before
