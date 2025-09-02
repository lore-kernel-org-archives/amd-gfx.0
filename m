Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F34CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 11:10:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D56F10E1D1;
	Tue,  2 Sep 2025 11:10:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E+A530Fo";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60E1410E1D1
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 11:10:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8I68uDyK7wwoWRagEB3+c9a9DU2kQCVXLAUMW5RWw8Md7WAnQvIWMlLdG70LvjCM7VXwmMCgYj+8AftDtAIUnIhM72TsrC2RFX4UmND9TsPUAQI1Ii/GWEUZop375U2vwspcxLmsVv5h4CMFVsu2Yhpj50DWtUQp29nadYtUGYXgHjTpQvDevg8GG+7MCfDBv38tZYGaKvcgOLLm+l6bCxcPS66HWnhMYCnL+akvavY6FL71W+p9eMwah8QZemLmimN2+9xWasjPUrPqu599tpBMOWoAZQ9iusrsGU8ONMLkKXpjfIRQFps1gyimwc8fs/WVeJREOB9dpwobXyD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFyMuxVswhebPE3yDq5U5VNFNFoPyaCOQVkr2tI4lGA=;
 b=qWZcdDEIQBYYY+9WznEtLJi3VpEvk1urvft6mr1dTX1qOEO3ThbtKAi2eQUhGtiB7XxV3x8gJp1/ofU5tslxRCBUFphT3l8hF9e7brL6rCX2ZtybmGTc5HNhHCI9O8+y2sSuS8sTcvmUr7ADKn70go7O5CyR9otUReOP1ShKd4SV/qg4+R5pILd31230f13gC2b0CySN71LwuuRmmG3NQ2rnHezgjjmg0hFezbLjFs7yWQV/jax/oKJEdD/2B92Be4F59HQaUWe05HlPhMoP6TtOplJdey91n2h8aedHj9u8+XEMLKGd7amp92FPO1I+Zd96R9EtGx6E3veMVzGO0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFyMuxVswhebPE3yDq5U5VNFNFoPyaCOQVkr2tI4lGA=;
 b=E+A530Fo8mlsue9nCodek09xtY4wVhmpIYV7z8VeClECQYjx4CApyz683nz11RqaC9CLWARiTYF7pF4nwzpM5OiXQN1Ku3vVtSup2cGDOtK/Yo79il01U2p598/rloeoI7gYoMlI645VxSi7OFRKfIVUSaFTVs9HYDBit9z3KHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7413.namprd12.prod.outlook.com (2603:10b6:930:5f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 11:10:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 11:10:13 +0000
Message-ID: <1e04ba11-424a-444d-9bf6-42b78c79c8df@amd.com>
Date: Tue, 2 Sep 2025 13:10:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amdgpu: Clarify that BO size is in bytes in
 comments
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20250901100012.439155-1-timur.kristof@gmail.com>
 <20250901100012.439155-2-timur.kristof@gmail.com>
 <b9c170d0-cbab-434c-a781-e0f5d379be83@amd.com>
 <a88429569645421c3659182a256ac38f3181f08b.camel@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <a88429569645421c3659182a256ac38f3181f08b.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: 05494656-9c0e-428c-d0c9-08ddea114a01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVRuTkNEV0tiaGVNN2t2MkxIdnljMkh6THdTd0w3eWdWZFhrWWxBTjIwUWVY?=
 =?utf-8?B?dHFWaVVPZ2JNVFNTZVY5L2tHdGZoR05Ud2tBTHN0eXJPa085eFhWTDRXcWNy?=
 =?utf-8?B?dHhySDBubGMzdW54Q1NicDNUU3ZPR29YSTlqYS91c0hWUjVxdlBDK2Faa252?=
 =?utf-8?B?ekNjc2FzYnhqZmRjQ25KWEpJczVYWHdyRVhpODh4anR6R3NkVDRVOEF1Zmgz?=
 =?utf-8?B?NXRSR1d3dE5qckhhRTQyV2U5REZmZVRyNU9iMTJyOHVFeXBmdm5jdjBXRE95?=
 =?utf-8?B?NGE3VnR6OU9YeHVwdGJIcDVNR3JBeS9QS0l5OXAxMW1ZRk9WclJVa1RNbzh0?=
 =?utf-8?B?Z2xiNUM5UEtRSE5sUllVMnZMQlg1MUtkODJ4UkhzcXIyQW9SR2tVYmtjKzBS?=
 =?utf-8?B?dWdNQlZWSm1HT1FKQXJWelRMbkxHdFV5bGJ3M0hIb0lVZXNETWl1YUtlbGJC?=
 =?utf-8?B?dGVPSmZlN3VYUGZGVkRrUE5zc05CaW84eTgxMzZocDBlZ1dGL3FNOEtmSlMr?=
 =?utf-8?B?a2RmNjZvekVBdk83NGlRZGVGUERCa2lkMktVZm9abklSa0s0ODd5U2pLdHpj?=
 =?utf-8?B?VDY1T09md204aEh2djd2cndNcXZjUW84dUZpUGI2SGJMT2IvNEFzaUJaYVBK?=
 =?utf-8?B?cFl5MWExeFk5ZVgvYlVSVmR6Z0tHb1FIY2NIWjRMZnl3enVPVWYwNmFSU0p5?=
 =?utf-8?B?TjZmcjRDNUNjVzhYd0NLM295U1NyVUZ2YWkrYzBXZ1lkQnk4RjF6d25DM0NR?=
 =?utf-8?B?aFVVTGtFeUhFYmo4TTFiWmNhak5KNzJkY25mLzV3NW9XdzFsK1MvRjFqbFha?=
 =?utf-8?B?d2tUeXJhVVRBanZROEx3M0JsbGJYdzlxcG1rRWQ4VG1hQ0l3WHVNOGVhem0r?=
 =?utf-8?B?RzNhU1BMTGRzcU9xemZJMXVIR1pCalJrTWVFcEhEY1hvN1d2SHpDWHd0djRo?=
 =?utf-8?B?Nmw2TElxT2RqTWlQOTJ0bjRSREh4YUpDUnBRQnpzbHlnSnBydSsyT1RKZUtq?=
 =?utf-8?B?WFBkR2M5NERGNDlyVmQ4eG5FMHhpT25PSlppcjBJSmNoaFZTQTFtR3puR25y?=
 =?utf-8?B?WTQwcVZJYnNRTEtqK2d1eUFyZ0dvMnd1blRuL2ZHS1dHZXZ3L0RXUDhrQ09a?=
 =?utf-8?B?TmNkcGFxVks0TWgwTjFXNStLbDFKNVNUY3dYenpOZTlOaWZ5WXE4Q0ZwTjdV?=
 =?utf-8?B?SzljYW14MWgxUmFWZTN2aWFnR0tESWxvNkpxTWhWS2NaQXZzcHhCa2x3akVP?=
 =?utf-8?B?YzlPdGtxQk8vRFJSK0c5WCtOK3ZnR2s3T0Y0Zk11NWZ6QmYxNTk1R0JLSmhE?=
 =?utf-8?B?YWw5OE9ob0VKVUw1RmVBYWRDaTdJS0VUeXp1YXgyVVU1TzVqVys1MWc4SnNU?=
 =?utf-8?B?QU52YWlrNjVweDdVNTNBWlcxVURuVVNlUHlRK0gyQUh3cWlhcDlPRjUrdysv?=
 =?utf-8?B?M2FpZUJ6NlhmOGdRUkllcitKSDlKNDFEZWtuODY1bDVyYWlucjNjbzhKVE12?=
 =?utf-8?B?ZS9VeER3LzBZY2piUmNJZTB4cXp3c1d3cXVES2xiM09kWUVGQzZUZWszVkpq?=
 =?utf-8?B?R1M1VjNaL1pUQ1ZuLzdYd2V5OVEvbG1xQTB2Q0k1dTFpOFZ0ZE50MUVucUZs?=
 =?utf-8?B?UENLcHdUQjJyaDV6bVJaTmwvcFV3NjlzQkpuQ2VjQlQxcy9HOThsYjJXTGNn?=
 =?utf-8?B?YTBFc2Z2QzVRS0k1bE03aDlDeHFCazdnYTRBaEFsMmR2dGZjMEIrc3I4L2lB?=
 =?utf-8?B?cEpYTjJ0elZTQ1dwNmhJcVlmdjZBb0hLWFg0WVJnZ2YxTm5FYkdUMUczakZB?=
 =?utf-8?B?NVpPbVdwVkNVT3FXNGUvVStiRTNBcmZVSHR0WXF4elViUDlhMHRYVGZVcVl2?=
 =?utf-8?B?L3dwZFlya2pMTDQ2U0xaOW9xTlE1am0rNFJwWFVET3FoTHYxay9vc0RCSkFH?=
 =?utf-8?Q?gqCSQvgPONw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzY4VzB1azF5dWdFU2NPM1FJY1BlS1l6eDg1cTNZMUJXT3FjVlhHc050WnJP?=
 =?utf-8?B?bnpJUk1NbytvZ3ZHeW9pVHdxTS9GSGUremJIdGNKNHlseHJrc1ErY0RrTGtU?=
 =?utf-8?B?aXhVNEJqdkNvSndVMW11cENuQms5eWdBUmNIZU1JN2JCNzVXeFRReHF6M1Fi?=
 =?utf-8?B?bUszc21nNmNtdmtHL05NZHNmQWNiem5NRDVIWlpiSE9hU0JyZlRSQkJDQ2VS?=
 =?utf-8?B?SzgwendKK0VkVUgyTndOSDA3QXhKTjVORXJ1NS9kbnJ4dUV1WWJ4WWI0VTRi?=
 =?utf-8?B?cllKWmpPR2RkNnZxV3NtQitodHIvQm1oNGsvcDNMdWFRZGFoUmorOWVLR1pO?=
 =?utf-8?B?WklYWHlkQWxRQUoySkprQWl3bGZXN2NTeFFyRmN1MlAxRWVabEpldHhKa1p6?=
 =?utf-8?B?UnNwcEx3SElBOGdXVElZSTZVekFOejdsbzhmRnFpejM4OStZVVcyNnFIWno0?=
 =?utf-8?B?RXl6T2tKRmw0KzdUeGh1Q1IxajlYQ1ltWGt3YUp5ZWtPczhvaHVmcEJKY0pm?=
 =?utf-8?B?TzRKZktObkx2VUl5YTdLbURRNyt4Tm1WZWt2M0hUV2hCSnZNME02L0s1Q1ph?=
 =?utf-8?B?akYrTFh2UVFnMUl2SFNGb3EwbmFONHBhblZLV2F3YnhCZHFXZDdFVitNY1pn?=
 =?utf-8?B?S0gvb2FHcExNWlBMckRyakNMTDBuUGQwYldZUzBZNFVXL2tjUmVYa2p2dEh4?=
 =?utf-8?B?TkE0TktPdHdlN1RXZXlCclBsZFVramNDYmZyQnZsQ0diV0RxVURiWC82OUlO?=
 =?utf-8?B?TkxSMmZMWEZXRDVTTisyL2NvRnU4cEJNL2VFRmg3UUFBVEVad3BoZGpBUTJu?=
 =?utf-8?B?NFNzenFRbnNWQjNyK2dPbVF4WnNqU2Z0d0xsNFVGamtjemREUzE3bXMzQUFC?=
 =?utf-8?B?YUMvNlBtQTdwdFFxWVJlTXlCNDIrTXpNV2hsT21LWmxkb1pHbThZeUF5aUNt?=
 =?utf-8?B?YWZNWWRnMGlXVk14QUN2bzRTeHRRbnVDQTh4bFlmQlVobUEweThwZzhwYWdD?=
 =?utf-8?B?U09ucXNldzE3WDkzdEJma1E0ZFZQeFIvbk00MS9BZGZRenNJYnZCbWNYaWRu?=
 =?utf-8?B?TnJZem1oSU1tVFNtM29ZaVpSUkl3ZTgwRmpjajRvSEpQVmIwUW1TdStibTEw?=
 =?utf-8?B?dlJmU1lLcStwYWMxTmZ5Vm1VcG5VRStqZ0s1MG5jR1FFcVpWd1hOY1h2MTJV?=
 =?utf-8?B?NHoyZ3ExQ0hGZSt6Y3BPT3RaV09ISGU4bGJoS0ZzTWg5WGNhdUhXa0pINVZN?=
 =?utf-8?B?NGk5UHREZlVTbHJZUStxbE1hbkorejcwK01iNFVERUF5SFJnWXJrSFJCMVg0?=
 =?utf-8?B?c2JTVGFMOXNKVXFhMHZzbG5tM1JOWk1XMEx4SW13Rzd5cXRzcnJ6cDlJMTFS?=
 =?utf-8?B?MkRUTVc1RUVxL0JvLytXaDVPcGVVOG1vbHczYVZCenJJaXUzQk9CSk5LaEcx?=
 =?utf-8?B?K1JwVkNLdk9lU3g3TnRKMk5CT1V3WEp5c3R3M2NIZjh2YXdKN0lkRXNkU1B6?=
 =?utf-8?B?cmhLWFpyRExtRzF1cEFnaUtQU1ptVFIxdkRXdFY0TTlxYnhpUDcvbDVUemkw?=
 =?utf-8?B?RllsaEQ3bkdpQ01ZV3lPUFlWMFFjRmQ5K1E2TG4xSDJVZm9GYStIRUFpbzZp?=
 =?utf-8?B?QTlmQVdjaXBmRFlkUkJDdmc3N3I4RUV2ZFE3R0F6OThMYSttTXFVYUxleURj?=
 =?utf-8?B?NlpSZ1B1OCtOOEloejY5TVV3STFVdWx5MkNDRWVrRVZYbis5Wm92di9jWDYz?=
 =?utf-8?B?UXpyMmV3eVdRTXZSRFExQkN4c1JhcTVJdUVSYS9XYzBNclkxQXlLREpGa1ZN?=
 =?utf-8?B?THpmMTZQNW1jZTRUMlVnWlM3N3duNEhhUU93U0JjNXRqRlBuQ0puOU45Q0dE?=
 =?utf-8?B?THNvZ040V3JJUzlsNVBaVldZSVphQjNLa1YxN3VVcmRQZnZRcnJvd0ZvblpR?=
 =?utf-8?B?WG5qdTZhcUhuM09BeXJqTEoxdnV5dG93cnB6NGx3djZTaGlMSGRUWXpVYmVp?=
 =?utf-8?B?d1QrRW1SSThtWW1PTER5RTA0Q3lZbUhyUThQdmllTDFBZ0h2MWx5MFo4VU43?=
 =?utf-8?B?cjdhcTVOYWl5blRmNlJBZHZ2NmdIWHdNWEhLSDA4bXQ3YjVUOFR3SFR0dVJK?=
 =?utf-8?Q?BA7qbG8ZKz8clsYUn9qfL5h3J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05494656-9c0e-428c-d0c9-08ddea114a01
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 11:10:13.6125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tw1/vKDy6B+inyhBvC0dhMEL4gjyoU98xvrDl3Y8ZrQT0d2ClJMQjKql20hKPH44
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7413
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

On 02.09.25 10:08, Timur Kristóf wrote:
> On Tue, 2025-09-02 at 08:43 +0200, Christian König wrote:
>> On 01.09.25 12:00, Timur Kristóf wrote:
>>> To avoid confusion with dwords.
>>>
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index 122a88294883..9ffadc029ef8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -220,7 +220,7 @@ void amdgpu_bo_placement_from_domain(struct
>>> amdgpu_bo *abo, u32 domain)
>>>   * amdgpu_bo_create_reserved - create reserved BO for kernel use
>>>   *
>>>   * @adev: amdgpu device object
>>> - * @size: size for the new BO
>>> + * @size: size for the new BO in bytes
>>
>> That is actually incorrect. The size is in arbitrary units.
>>
>> For OA and GWS it is the number of HW engines they represent, for GDS
>> it is in bytes and for VRAM and GTT it is in bytes but rounded up to
>> a page size.
>>
> 
> Can you point me to the part of the code where this is actually
> determined?

See amdgpu_bo_create():

        /* Note that GDS/GWS/OA allocates 1 page per byte/resource. */
        if (bp->domain & (AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
                /* GWS and OA don't need any alignment. */
                page_align = bp->byte_align;
                size <<= PAGE_SHIFT;

        } else if (bp->domain & AMDGPU_GEM_DOMAIN_GDS) {
                /* Both size and alignment must be a multiple of 4. */
                page_align = ALIGN(bp->byte_align, 4);
                size = ALIGN(size, 4) << PAGE_SHIFT;
        } else {
                /* Memory should be aligned at least to a page size. */
                page_align = ALIGN(bp->byte_align, PAGE_SIZE) >> PAGE_SHIFT;
                size = ALIGN(size, PAGE_SIZE);
        }

The GDS/GWS/OA handling here is actually a hack I'm trying to remove for years. It's just that GEM/TTM assumes that all BOs are PAGE_SIZE based objects and so we have to do this tricky workaround.

> If it's that complicated, then I think the function could definitely
> benefit from more documentation. All I could find was that both
> ttm_resource::size and drm_gem_object::size are documented to be in
> bytes.

IIRC we have actually documented that quite extensively. I'm just not sure of hand where, @Alex?

Maybe the UAPI? Probably best to add a reference to that to the functions creating a kernel BO.

Regards,
Christian.

> 
> 
>>
>>>   * @align: alignment for the new BO
>>>   * @domain: where to place it
>>>   * @bo_ptr: used to initialize BOs in structures
>>> @@ -317,7 +317,7 @@ int amdgpu_bo_create_reserved(struct
>>> amdgpu_device *adev,
>>>   * amdgpu_bo_create_kernel - create BO for kernel use
>>>   *
>>>   * @adev: amdgpu device object
>>> - * @size: size for the new BO
>>> + * @size: size for the new BO in bytes
>>>   * @align: alignment for the new BO
>>>   * @domain: where to place it
>>>   * @bo_ptr:  used to initialize BOs in structures

