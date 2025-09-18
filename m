Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F01CCAC59A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 09:13:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F26110E3AD;
	Thu, 18 Sep 2025 09:13:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EH14wNV9";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012045.outbound.protection.outlook.com
 [40.93.195.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9561010E685
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 09:13:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INTUBKnUQPAwBsIn+2qwGqlV3E+vY/VEV9JTWV7V3g+TdjcH5xWA2RXGi55IKRmjw5Neo+iwz6QyPdSRYzG4KYZpPU32/5H2MVkGQwoSHLeT/81EmLQAiaQu5+u5VJY9LHBeEFZbAH57crRMznEmiwW/aCPy9+wpMgqXlUsU7h1GoA+M5PNgTbK6UGs67mt+4dvcO3EcDkDznmDNtkS54163Jz+NV8agbhgAPUa0BjIKBtjNnjdwq3jxbSsLCCp5XbORsIA87hPqVkRXqt/K9Gqg0VBX6KVIzFlPzjjBbpboSWea/x258FQPRzHP7i1demU2YN1SI9w/3oxCmwS/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXF5ezcyySyJLftBL4cACbmBBcyQjHHKBEOsXg5fxBs=;
 b=fzNVgs53Wjp9nN/2LUiNpdcDin1frIjJU8pnDAcqQZU+40jIawkZ14dKtDhMHDPzs3Mut4xtPCAwgOV/bM7hzC1X7gXlRJprfvSh/ferl69cKn+NQiLDdRvTOypI1KPTtLE+5eoL9aHsWsGCYh8Eh1z79JeUCUnul/m3JAb6ZA7sfvlm0lE3xEE8YpBbj//m22YM1stkpvwIb++S+Pi7RZzQHtjw9rUaLCwp9pMv9Zu1TBkJh7TNfiAsUm5lcG8KVB8COX3jScWJfeMjlMqWYveSlJhEiUaE8dsgxfrxTVusTgQTAiye4OJ1ej/72OAfbKx19I1PQOnYpZsip50gJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXF5ezcyySyJLftBL4cACbmBBcyQjHHKBEOsXg5fxBs=;
 b=EH14wNV95+5ytU9+YrM9GVzYZJzL0KnJ0dhzbg4LOaAiB743lQ6rpPj8f4vIwbUn+Xd6Ozb+XrGu0Blb0CTQF2fIL2ob0HAS3346DgiSKe/p5yLuzORPQLvTufnyOs23uNxUxClhRLgdODBoAoh0CGB5DTcJ+SmhkdpAtrt99Jg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 09:13:20 +0000
Received: from PH8PR12MB6770.namprd12.prod.outlook.com
 ([fe80::5da3:7c42:3309:eb4c]) by PH8PR12MB6770.namprd12.prod.outlook.com
 ([fe80::5da3:7c42:3309:eb4c%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 09:13:20 +0000
Message-ID: <a950349d-69e1-4a7e-bd99-d9d6a1528533@amd.com>
Date: Thu, 18 Sep 2025 11:13:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix pipelining jobs with timeline syncobj
 dependencies
To: Tvrtko Ursulin <tursulin@ursulin.net>, amd-gfx@lists.freedesktop.org
References: <20250917095939.41615-2-david.rosca@amd.com>
 <c1f6d69f-7f71-4d6d-b475-fe22f5316ca3@ursulin.net>
 <74ed415e-2938-4b3c-ab68-4b074d35e4ba@amd.com>
 <31124176-c73b-426d-bb35-793161b44a68@ursulin.net>
Content-Language: en-US
From: David Rosca <david.rosca@amd.com>
In-Reply-To: <31124176-c73b-426d-bb35-793161b44a68@ursulin.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0274.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::33) To PH8PR12MB6770.namprd12.prod.outlook.com
 (2603:10b6:510:1c5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6770:EE_|DS0PR12MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a40941-fe8b-46f5-b560-08ddf6939c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ako3QVAxNmk3TEs2bS9JcnN2VTVUWGFnZ1RoTkl6YkdURkdQVnMwbk8xalZY?=
 =?utf-8?B?RE10UW4zK2tiekh0MWw2MmlNVWFCNVVoVlFkV01vTnBlWE1WR1NkQUxkUlZp?=
 =?utf-8?B?VjFrejNqMXg4TkYrQUdjdm5ZS1pYcUpoY041c1BIV1FSNlR4bFNkZ1g0TlVq?=
 =?utf-8?B?OG9yMWNDa0pHMC9QZDN6N3dPTjZ1b2JtVy9vVHk2TzFZUDBISjFkOG5ST2dQ?=
 =?utf-8?B?L1kxU3g3NG9OQ3lKMGlqM2hHVEVhS3Y3Z2tucm5zQ2EzMnY1T1dJa3hsMWlz?=
 =?utf-8?B?anZlWUFwRXp6VGVRSUdsQlFaU0NPWm1Pcm9EOU81eDk1OHRIdUc0bnNMeW5P?=
 =?utf-8?B?THgyUW5RcDhxNjFQSGs3SWdTM3Z6UVBGQjBmaUdnVFNDSHdEbS9GOU42ODRi?=
 =?utf-8?B?TFBGdmFKWE9nSkF3eTFqcFJIKzNDR3oyOEhmcDFHUVJCMjVsdlQ1L042QnQ1?=
 =?utf-8?B?UnNiVXZCT0FlRTltWHlzSWU5WmJtVE1UbzdaZTZFWGd2elZ4bHFMclVSTjU5?=
 =?utf-8?B?OVc0eFNFZzNCNDh5dU0xcysxUGFIdFByRkVDcUFOQnFWTHZKYkNVclBCSkIr?=
 =?utf-8?B?UzNDRnZaQ1U5cjdXblZGRWw3UmpJSzdodDFlcXlLeDloMUt6eVp6OXY0cWxG?=
 =?utf-8?B?VW1CcStNRU9DbVZ1RU9rSmtqM0kyby9VRGlVYmVxaDFvSU5LOEhRWXJyRGJW?=
 =?utf-8?B?SHpya3RHbEd4ditmOU9UZUNxZEJEWitSRXBQaEJnbGplR1VJOFBEK1JpZGtN?=
 =?utf-8?B?Y0E1RGRNRHVzT3RDRU9jeE5GOWVZbThHSnp2WU0rRUxqU3hjQjFoWTJFcE1q?=
 =?utf-8?B?eEQyRnhJRjdTb3pySWw0SFVWS3hQMzhXall6dmZlcStYWXZMN2RZYnNpZjRu?=
 =?utf-8?B?RnREcTFRNHlGalVNTHNoK0p4V25jOHY0K1krVGFBNEN6akJoTjBrSm1JQW9Z?=
 =?utf-8?B?RHRVVDJxeW44Q1FHS0ROOXZ2YlpuT0IrU0JySzR1dUZLeEJwN05sL3I1Z2s5?=
 =?utf-8?B?Vkl5L3FDYUpOVkVtM1liNlZxN1NRV2YvNGNvQk9MMUtUNlgvSVd0aHRkRFdH?=
 =?utf-8?B?YXZxbFNCTGI3dE85a2lheUNFRHppVGNFU2sxWVc4cTVXT2VLOE5XWWZUZHBj?=
 =?utf-8?B?b2ZOV3hRcUVIQjU1UWNQck5UcUFDdk5kMUdKZDlhK2dRd1M5cG9NaFRIM1ov?=
 =?utf-8?B?Y21ZV1V5aHE4MG1mbzJtOWJOc05uSVoxNFlRV0o1QS90bENFT2FETG15QzY5?=
 =?utf-8?B?ZzdDS2Z5dC93Snd5aytXeGtuNVYyOUZwTGdNc3c0aUNhWFJUajVGeU1sV3Uv?=
 =?utf-8?B?c1J6UXhFQUt2WUsxNTcyMXFuallGeXduczh5SHhSdU5kZG5PdU1hTDR0TG13?=
 =?utf-8?B?YUJqcjMrRXU2bDJSTGMzcnp6ZVh6MlVucjRPSGxjdElKV25xaU9QUm5GWDc2?=
 =?utf-8?B?TG41TS9kSzZ1cTdraWNYelFXdmFRdnVTb0lEY2hUcStqME1zcm00QzFwd0w0?=
 =?utf-8?B?YVplc2kzMkNhaGx6VnlxdytESUgzZWxSNDBJb3ZVVEU4UjhCbnpPNTlIUEVl?=
 =?utf-8?B?bWE2dGlWczVuUmc3UEQvVkIxSjllMFNXcHlKSkNCMlc0SmVOTmdoUTAzeHhE?=
 =?utf-8?B?bjlLSE4wa3Y3ZENtYzZLR0oyN3Y0Qnc5aDB1WlQ1c0t6UHROanBkY0FEaVNV?=
 =?utf-8?B?dW0vUzhndUhISS82RjFxN3krVi9VWVFYZ1UrN0dyL0ZIbEIvZGI2QkhjclNT?=
 =?utf-8?B?aG9jVGVWa0dJSCtLYjVCYStUWWtNMHNDQTlXY3RGZEFRV2w1ZWNXaDJsRkk4?=
 =?utf-8?B?VTEyQ0ZEL1JjbU41NkJNQzJHSzgwVjFXS2ZoR1BSOWtBNDdrQ0VrSjE3aWQw?=
 =?utf-8?B?MmQzYnhtbnZxWlcwdEVhYU5MWWppcWppMWd1Z1MrMFd2NHN4OGZmNzFIRWJY?=
 =?utf-8?Q?SrwhriQv0UQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGlZNTFHdVdPREdXOG9nWjRMNkFuQ0UvSmU0QVlGeFhZMjFENDdNREJ5VjlW?=
 =?utf-8?B?dEllYzArZXR2OWo3Vi9Vdmw1aEVzSGsxbVlZaWFnc0tXeVk4SmozZVlkbFVn?=
 =?utf-8?B?L2pEZm1ZWkQ5MWhpVXR5aktrWXg5Z2owRGxkN1VNTllsU1FKTkYzU0ZtV3JN?=
 =?utf-8?B?QlVuQUFxbnVKczcxb0VUZnQ5ak5PbU8zVlN3REtodllCMmF1QlBSa3VRSnY2?=
 =?utf-8?B?a2lqczhTT2tlU2V5TGRteGRYbGp2MzdyNG5oTHJVa2g4YUJXOVdVZElKVS9n?=
 =?utf-8?B?UWJNMXhpN3ZiNFl2bnVHaXpBWmFZbFU2TzlCTWljRTJhOVJHU2QxVk9ac1pL?=
 =?utf-8?B?SzhpQXZ6NlpTT2o5amozYWNXaDA0R0g0cm5FU0pwZkdpY054K3VuZWcwcisr?=
 =?utf-8?B?QU5PVitERlJTVnhZSXhpMG9zdlJVMnpmY0JoTnlwSVJGcjhGUHdtMUZlSkg5?=
 =?utf-8?B?NWxsODVpeUdwTGVUK3E0amhhQU0rWjhxUzZRRjdaSS9oaVFvM1Z6VmlOWmE3?=
 =?utf-8?B?UTA0ZGpDdXpNOG1MZ2thWjVZVGM2ZXBHUDNOOUxVMGxTY0JaZzFhZklXUFFv?=
 =?utf-8?B?dGo5aGVabXBRWGI3ZVpwSDd2OG1acDZvTkFCL1FKS1NVRDlYbzhXaExiOWxr?=
 =?utf-8?B?OE9YU1RVUExVN25laTJQRlphQ3JQWmVjWmZDaWxrNWpLTzhsdGxrMngxYXBR?=
 =?utf-8?B?aVJYTmxaYWhGSk9YMkkwTG5hYmRDUVBBYjBKdFB2OGNMTEUyNjNhL2Y5UVVN?=
 =?utf-8?B?VThMM1dpSTJJMFk5UUoxSnpFY1lxWU52REVWaHF1Y3UxVndpVC9JSkUzQWUw?=
 =?utf-8?B?TGkvWjE2ekF4YVIzUVBQMzV6ZWpyMWFUTHNzaitrdEdRSHZHMjdUc3NERmdV?=
 =?utf-8?B?RFdOaGxFR3FxV0VGSHd0TkNaUnJ1N0FaUkVwMVJXUDBVMzhtL1lOK2NWU0dB?=
 =?utf-8?B?TDUzN09ZTVZ4NzRQQnZaTVMrVmtBUGhsdk1iOVlocEk4bTRabjIxdElXNnJK?=
 =?utf-8?B?dUh4YTN6cTAzM0lPMWw3Nm0rMGxPSXU1QkVESWJKWGRLWHZ1aHN5NGRkVTlK?=
 =?utf-8?B?dysraFBuTG1sNXFFS0lzL3ZrNy9Vamx5Uno1MjRpaHZEYWhyNGhqNmt3Si8z?=
 =?utf-8?B?OEZxUnZFUkxIb0JHL3ZsSEZ1UzFIMDdrcEJxa2E3NmRKV2p0cDJLOUMzNnpt?=
 =?utf-8?B?TG1GR3VaLzcxdnBxWm5Cc1pZWlhZS3NmMy80UDE3aTJBNkVHcXQyaStVWTNr?=
 =?utf-8?B?SHhaN3o3QkVsNDZUZ3JoYllWU1RpSmhCZWxHc3F0dzkrcTVRTDNCTC91TEdJ?=
 =?utf-8?B?Nkd5SUI1b3Y0eWEyRkxCVVBzVDdvaUIxVG5vclVaemhpc05TQTJWRHRUYmRw?=
 =?utf-8?B?NmFMeFRvK0RhSGMrM3hyMENQQ1dpWHVEbEl4Mys4TXlmTlZKUlF6RFpySnRM?=
 =?utf-8?B?U1Y4NDRuNHgxcXlOd3JNWU9Ca0c4RS9UM0hsUFRoLzVudFJBTlF6OHVBMXpa?=
 =?utf-8?B?ZnBCTXl3TXJVVDR1NmhIU1htZVVlTjZpd3FNSFNVbEJDd1NFNUU0YjdpcWxF?=
 =?utf-8?B?VTgzQWtUSU00WUJyUGRvcU9wdTlzNUtSNXcreDF4aGdUckxOZ2xKa0NUa215?=
 =?utf-8?B?bmNzYjhpUUpEcjJaSVFJbC9HYzU1VUJJWDB5cFo0dThPZFdXVXpUSHNzWGFZ?=
 =?utf-8?B?ZmVneGdHWkNoSjhLVUo1Y3gvb0VTVmxWemxObmtSVDVnTm5kenl0OFhVVmVN?=
 =?utf-8?B?MnBWaWtGQS9SVHJjY1lHWUVrc0p0NmM4RkFTcmNaN2N5QjFJdmMydStYSnpZ?=
 =?utf-8?B?dTZYRFV6RmpucTM2eXN6Kzc1UlhnTWdGSkhCR3NFVjV0SmlPZlNaL3UrV1JN?=
 =?utf-8?B?eml0ckJySVIvaEhlQVpJaDgzZVhXcWJzOHFoaS9hSDNvRnRNd2ZjaVBLQ3Vy?=
 =?utf-8?B?eHU1SnlzcVMrK1ZxSUZzMmpYc0Q2QUV2Z3lDOGN6MEN0emMrRXZKbVVBd2tO?=
 =?utf-8?B?b3VoWFh3cngwTDNVNmJwdkwzRGxLS1d0OUc5bHpYS0dGRjVMbGxkUjNWWmlJ?=
 =?utf-8?B?WHNRMXlPdmRiU2ZaQzhXQ3RIT2FrdjdzSHcybUZ5bGxRaWZNNGNRZ2tYWnF2?=
 =?utf-8?Q?mv8Dp0JSlL6wYVQeqfxZGSvSh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a40941-fe8b-46f5-b560-08ddf6939c78
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:13:20.4425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdqUkxTIRE512f6lB4i42dJ8bJmCmkNT0pu0K1m0DVv3JVI/YuF7kxq2BiXKyIyItdqNfKPaZS7L1rSqVv9glQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415
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


On 18. 09. 25 9:47, Tvrtko Ursulin wrote:
>
> On 17/09/2025 11:54, David Rosca wrote:
>> Hi,
>>
>> On 17. 09. 25 12:15, Tvrtko Ursulin wrote:
>>>
>>> Hi,
>>>
>>> On 17/09/2025 10:59, David Rosca wrote:
>>>> drm_syncobj_find_fence returns fence chain for timeline syncobjs.
>>>> Scheduler expects normal fences as job dependencies to be able to
>>>> determine whether the fences come from the same entity or sched
>>>> and skip waiting on them.
>>>> With fence chain as job dependency, the fence will always be
>>>> waited on forcing CPU round-trip before starting the job.
>>>
>>> Interesting! I was sending patches to fix this differently last year 
>>> or so, by making the scheduler use dma_fence_array for tracking 
>>> dependencies and relying on dma_fence_unwrap_merge to unwrap, 
>>> coalesce contexts and only keep the latest fence for each. But I did 
>>> not have a good story to show for which use cases it helped. So I am 
>>> curious if you could share which scenario you found gets an 
>>> improvement from your patch?
>>
>> The scenario I am trying to fix is very simple to reproduce with 
>> Vulkan when using timeline semaphore to sync submissions on the same 
>> queue (eg. each submit waiting on value signaled by previous submit). 
>> I have noticed this issue with FFmpeg Vulkan video code, but it will 
>> happen with any Vulkan app using this pattern.
>
> Still out of curiosity, is the performance loss from the CPU 
> round-trip something you are able to measure?

Yes, I'm seeing measurable improvement with this patch applied. I have 
tested three cases (decoding three different videos) now and the result 
was +2%, +4% and +6%.

Regards,
David

>
> Btw your patch is I think fine, so:
>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> But you will probably need Christian to ack it.
>
> Regards,
>
> Tvrtko
>
>>>> Signed-off-by: David Rosca <david.rosca@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 10 ++++++++--
>>>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/ 
>>>> drm/amd/amdgpu/amdgpu_cs.c
>>>> index 2e93d570153c..779c11227a53 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>> @@ -29,6 +29,7 @@
>>>>   #include <linux/pagemap.h>
>>>>   #include <linux/sync_file.h>
>>>>   #include <linux/dma-buf.h>
>>>> +#include <linux/dma-fence-unwrap.h>
>>>>     #include <drm/amdgpu_drm.h>
>>>>   #include <drm/drm_syncobj.h>
>>>> @@ -450,7 +451,8 @@ static int amdgpu_syncobj_lookup_and_add(struct 
>>>> amdgpu_cs_parser *p,
>>>>                        uint32_t handle, u64 point,
>>>>                        u64 flags)
>>>>   {
>>>> -    struct dma_fence *fence;
>>>> +    struct dma_fence *fence, *f;
>>>> +    struct dma_fence_unwrap iter;
>>>>       int r;
>>>>         r = drm_syncobj_find_fence(p->filp, handle, point, flags, 
>>>> &fence);
>>>> @@ -460,7 +462,11 @@ static int 
>>>> amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
>>>>           return r;
>>>>       }
>>>>   -    r = amdgpu_sync_fence(&p->sync, fence, GFP_KERNEL);
>>>> +    dma_fence_unwrap_for_each(f, &iter, fence) {
>>>> +        if (!r)
>>>> +            r = amdgpu_sync_fence(&p->sync, f, GFP_KERNEL);
>>>> +    }
>>>> +
>>>>       dma_fence_put(fence);
>>>>       return r;
>>>>   }
>>>
>
