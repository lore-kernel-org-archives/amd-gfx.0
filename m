Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8FFE77188
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 10:35:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F31BC10E159;
	Fri, 20 Dec 2024 10:35:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mK1tZJip";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FC0D10E159
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 10:35:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdaV2FKtR90ctYdGX8Lkjun4i5XvNoIJ7dQ9YyqvXGTvzmsHhWYbV4w+CYnNHVROMD966kPk+jRvmPJBRFADKA/YUAKce+x2Dv+jZMPUdjB0cyM+EgZVTSgQ0bxWXrtC3en038rD0kOcGHqIHHOboZopa9+4KyofKO/dwG0V2R2QxC7LWamZ6B7QYyH+kLhvcMZd8Vhh0FzzkwtTqKf5JwwGixKChaxsUidG+7rF5nQphQoa2aUHbZVjvoSSGcPHscxOisdqcL4XOUdXvCP1f0C/KULVPR8SvUIwC79uBdKHjWNlLTRK8JE2U+ktpahc5k/ozT4xTE4ZscjIsbK6HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+BU9LICIEAJ7HV7TQNW2SNz3u+2v/Y2vaaTXBtTPo8=;
 b=ZxPSMAv55rGy7B6pn585tknU4PkfDL/wtTbW3ZVBuZqEOZ8CAr8OUBAXFvttfKXZGHg02JA0+fn9P5IZDF4E0AwFaySJc+lFaHCfVq+NkBTHyzE90wDzh582O30fMyLgiT2z4qQHmWXIAOMd4ygvqfkenj1ZqxWdUQ3me98xHOxHpF25FlDxzpUHIIEw9mmg82DTLmMtt+0KWUdqfzqFlMlhmv1RbSmhtLv+0Q+P8FqxaaQI17CCImdaWvVUcEEc1AM1JRf+6vSz9JAUSa9H3biiVBjQPLyat19r8Jb+vEJnXwrkpu67GJ860DcdN/EvfmG4MHW/EQXiGCz1F7d/3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+BU9LICIEAJ7HV7TQNW2SNz3u+2v/Y2vaaTXBtTPo8=;
 b=mK1tZJipPe90bb8oAEotlWR/04vLUcm4vUioK070RkT2WnhAiopBOZv/oMShu+0WCS1vTiIUgELWbTZpU5Za5qeUIdEjb+ZpjHNeY3egus6u4BRx3n9o+UDi/Xe+cVpXUQbyDJTyLu2NNHAW2C8diyK2Oy2elU9goT0dvtBfD/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by CH3PR12MB9124.namprd12.prod.outlook.com (2603:10b6:610:1a7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 10:35:05 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%7]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 10:35:05 +0000
Message-ID: <b4acfc3c-5d91-4b94-8d7f-e653cebc5bbe@amd.com>
Date: Fri, 20 Dec 2024 16:04:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drm/amdgpu: Fix out-of-bounds issue in user fence
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241219103824.630689-1-Arunpravin.PaneerSelvam@amd.com>
 <22a8d1c2-712c-4c16-a296-81fe342bdfde@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <22a8d1c2-712c-4c16-a296-81fe342bdfde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::12) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|CH3PR12MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: 6218ee73-4238-45ca-ef48-08dd20e1f785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REZESmFXdFNNbVRGQzdSa3orS2Zpa0xLamNaRUJWdlpGODFKTjgwLzYwb0gw?=
 =?utf-8?B?TEJNdXVTWVpLSjlpWHJxQjFoU2xvbFd0ZDR6bnl5V0V4T0o0Y1hvMnZSdGFh?=
 =?utf-8?B?bUJKNWg4MllLdHE4VU1SMmxjbHNCWk1zbnFkYzRaNjcyYlhoMjd6SjBlVENj?=
 =?utf-8?B?cDdEYzhxbjZpOGVZalZnK1ZGdFBaOFdiMHNoazl3T1Irby9NTVhwMnVTcXFo?=
 =?utf-8?B?UXBKb25ITk1TZFJPN2ZiVUFPaDdnYXphUFpZWlJCNzFaZnlVZmE1MnZlRFFM?=
 =?utf-8?B?WmVFbXdTV0xoMXNDTk5aVVAxVExPZ2NyZjB6THhMa3pKa0d3Sk14cktoOXFr?=
 =?utf-8?B?TzhleitVMklkOWZpblB3UTEzS3pLVDRlejBsYXY5eUdpWFZtUU1sbThhMlN2?=
 =?utf-8?B?SUEzMkx2N1BZck9lbXdXMVR5WTlvNlErUW1BSHIvOGx3dnh2QnFuREk1NWJK?=
 =?utf-8?B?Znh5SFAyMlJQSWxPNHZ5QjVUNm02VGJhWGZac2RxRngrQ2w4TmhKK0J2cmsz?=
 =?utf-8?B?U2J1eTRqUEEvRSt1MGV4akNPck94VzZlV3huUE5TWkRpVjZCTkVlQUxvL2Z5?=
 =?utf-8?B?VTQ5WTd5bU4vWFZUWmRuSjFnNFZOWm1qVUxDaEZLaWV0L2hzc2FWSnhpS1Mw?=
 =?utf-8?B?MVNsYkhqZ2k0bWROVUdLb2UzRzZuMXJkRldCbXRlL0d6NEVUSkZCazlsMkJv?=
 =?utf-8?B?TXNQNU1mRWdVa2xKUHdwQTRTMk0reEozRFdSbGs0Tit5K29PbjVwUFBOeXJa?=
 =?utf-8?B?Zm5wZE40WXFIS3Y5OVNOQnZhOWlJUmZIQ01OaUozb28vMjdpblgrbjVadmpV?=
 =?utf-8?B?ZXJEbk10MzAvTDVSTWppOVUwdUdXdTBDOWhZRUl0UFV6d05wcXlNTlFLMEE3?=
 =?utf-8?B?LzZDbVAxeTNxQ0hoZS9Jc0FGU3FueElHOUlTZDNCTE1DNkVXRUtlQ21oMmZj?=
 =?utf-8?B?aFNnRnhhckJFNVU0ekEzaWFVOHEzQjRBejBWV2IyRDZ4KzE0czI2eUhTWmZK?=
 =?utf-8?B?UnVCWU1XbDJDRE9vR1UwdU82bHR0R3BDVm5vVUZmTDhHRldwRkNydGhpOVpO?=
 =?utf-8?B?cDdZZnpTclQxVjh4Nkp1N2o4V1VuaHMxSkNtcEFFNU1CRnlmR1ZvUnpWVUdh?=
 =?utf-8?B?eHBFQzhqNlRENytwRUtvcFRCYXFUajNWMHJLd3lrNmRnUk1STWZGSWgwZVI2?=
 =?utf-8?B?QzBFaFBWM1pWd29rTFZYeTB1d0p1Q3c0NzZNbkF5ZFpEMTNkVDJDNzcwRTVa?=
 =?utf-8?B?dmVKbVdmd3lNVEZudXlrSS9tTmV0Mk9wd01ncEtwbnhKWUZERS9scHNuaHJz?=
 =?utf-8?B?c0RybDNFM3JZTUY2Z0JBSmtvNWlMdXNFM2hXYlVpZG9IYXBWYjgzNVlGV2dr?=
 =?utf-8?B?OEM2MkRsTFViaElzVzZhZEpLZCt4S0U2UVBNTDNmbm1LWWg0d3MxRDQ5eFNa?=
 =?utf-8?B?ZmZIWnVDdlJVT3dNbXl5MHFtWkE3Mlp6a3hKNWpkYS9TYzhJbFNQMUJXM0Uv?=
 =?utf-8?B?VmJ5SkJmbDdLSEpUSVpNQ25IdWZ5eENWL3RPUlc2Ykl3S1VOSlI1aExqTkZS?=
 =?utf-8?B?NXZtci9sVUNVc2RoeUwwNDRvNWhLVTFKS3dKREtHdlBIc0lEMTlJaE41ai9Q?=
 =?utf-8?B?dlViU0gyZGtCRXFsWXRqbFVxZzFHWjZzN1prWFpCNzMzbGV1dG4wcEkrMStV?=
 =?utf-8?B?OFJ1TnFxdEoxcmE3Rll1UVZkZXVtc2hkc09ZakZWTUY3NTVjNzhUVlkvOTcy?=
 =?utf-8?B?NS9EUTduRzhQbFZ5OGJ2eUtTTHF5VW9Zc0l3dVliaHQrVFp0QnRwQTJnNGtI?=
 =?utf-8?B?VzRXNVdpRVNlMmR5bVhvNmd1am9EV1MyT1pxWWRERjdhQ1NXZXhGeDZka0V6?=
 =?utf-8?Q?Jltofj4hNADMq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0xkNlY5cVVIaTdaTFVxTytBM1pYd0VmWHYvY1RkUE9EbHdMUVg1N0MrNlFx?=
 =?utf-8?B?bC84cUNEdy81cUQvdHRvK2Z5cytyMGhtd3RybFhhQ3QyaU5qb0ljT3IyRTBP?=
 =?utf-8?B?K3EwMHV0aHpLaDBzbHVjcHViSkQvSXVET0haVzBsNFI2SEdBU2xwOUhMUEN5?=
 =?utf-8?B?cEM3MnpVdFpYQkVDalZrTUMwTmVnQVZpYm43eUJ5QWJVMCtCamJ0QzdxbVEv?=
 =?utf-8?B?enRBZzBtZXVWVzVkbEhWNlFTNE9pZTVEb0tBVlZ6S01HbGJyVmlVQ3NRRE9m?=
 =?utf-8?B?RUU4ZWRNdVk3T0RZd3ZSMVJuRDYyRWZEemo3L0N1SGI0L3NveDE2SmZJUU1u?=
 =?utf-8?B?MGY0c0lSQnIyNjlYUkdqR3ZzeWljVGVJMG8rUGVzUDJvb2ZtOXJvZFBhZTgx?=
 =?utf-8?B?aXlIZEhTUGJFOUs4dWowNE9TdHhNSCtGRUVFU2FpcnhSbXNGVGFkQjViUFA3?=
 =?utf-8?B?SGl4cmRmSXFIcmxmeWFSeG9WU0tLVVNLbXBEL1h1V3pMbnhHdyt3RzJxbmVV?=
 =?utf-8?B?TzBrMGROeXdSR053OWtrSC9pSll4UU45TWw2SE8xaWQzL1Y1aUxzTFZobUtp?=
 =?utf-8?B?NHhrK2dHODZBQ3ZRV2Q4cWQ1cGsyYjBMSzExcklRSjhvditMSUlzYkI3NG4x?=
 =?utf-8?B?bjZaeUVBZ3NNQ3hYOHR0MUIzY09nUy8zeDVUbVdXRVM0MjMxeGdxWks3VUlr?=
 =?utf-8?B?Y0plWmR5cDNrY1Y2d014bHhmUHIraktPVVdVbktDZjNIWVpVcFlkSXBucEJ3?=
 =?utf-8?B?b0hJZ09CSGVxYlVrMGxDNVpKU1pZZUxWNkFOK1J3VStnMGZhYWM3L3daY2hV?=
 =?utf-8?B?ZXlyQ1lWS2VHWjdjcXdrcGh3MzZmMkU4elhRejlIc0VnM1VRRlcza085bzRS?=
 =?utf-8?B?c0M4eXJuU21QUEtsV1RYU3g2cDArS041WTd6bDl1NXlXOTJnQzh4akhkcHVF?=
 =?utf-8?B?bHRtNWdTOE9xRFZodTQ5RXZ3ekZXRk1oa3hISHl3NlJDNS83cTNENVhITEdW?=
 =?utf-8?B?MmlEeWR5Z2ppcGtjR05zdFk3ekVndU94MkFWVVhjc0UvSE5tOEgwWVhpTTk1?=
 =?utf-8?B?OWVVZWVkS2o0ZTRXVU53YjhNU3EraS9IVEJmeUJqOW5vZFc3bUt2cHZGenYw?=
 =?utf-8?B?SnQrZ1hYTWppUEZjRWg4OHFpZURnZHRRaHRjOEZzRXhqQitxUkxzTVI1U0o1?=
 =?utf-8?B?ZDlXTWZ2V3YwSThEVjZ5SGFrUjBkajY4c2VQdGZrQStnMVlFRHEveENCRlJa?=
 =?utf-8?B?SVFwNE9SL0kza1dUdkZwWGdOQk1kbk9Ic2ZYUE9XY1ZHRDVXYUJaZVhPMi9Q?=
 =?utf-8?B?d0pXbHJZbDNyMW03NHdJTnhSRSs5eWRTUXBDSE5WVzU0aWVkamg2Y01LVDdK?=
 =?utf-8?B?MEc2TnZ1eUVyaUdRQTBWSzAyQjQvbGo0UCtIdjZsajdwcEdhUmZOWHYxVjFR?=
 =?utf-8?B?U1pzREF1N0tXV216dGpKVWNiL2JhelI2WjlWaTB2ZjVaTnlQaVo0VVBtWWVD?=
 =?utf-8?B?TC8yYm11SXZSNnYzN0Jvdy9mQ2pWd2V4emZzdzIrMEM1ZHFWajB2SERLS3JD?=
 =?utf-8?B?eWxzNlpVc3FvZ1R1YXhlQUxVRkx2SVUzbG9pQlVtSFhSUTFTQzNZM2NJUHVH?=
 =?utf-8?B?dDR2eVZsUUVEV09KZ044THhTTlBBUUk5YVBGMUFUQ1JGWHNzS1lUZ2NjZmVt?=
 =?utf-8?B?L2NCTVgxMXpycXVLakZoTWc0MDQzdExlTG8vRzFzcmVYQVdOdVd1R1BuQVo4?=
 =?utf-8?B?OVhuZmRaQ2JtYU5pOFM1anIwTy91eGpqbW0vNDdTMnVsWEM5ZkdBaER4MEdl?=
 =?utf-8?B?djd6Z2lIcDVDNHg2bmMzdXlHR1NHTGw5NEVmbXl5WWFoanZCOGZJV1dGSGE2?=
 =?utf-8?B?eUZaNmZVSXdrRFd6c0ZmRGlqeWxyREU1TE1mQnl1TmhNa0FONmhTOVZXU3Bm?=
 =?utf-8?B?T3R0dlFVU3ZNNTNSUElyWkJUcHJoZW5ETEFDSzZvSWlHd09JTkYrZWdsc0lV?=
 =?utf-8?B?TEluTC9nZWZIVEtkNXhINHUrZEx5QlpNTGJlaUt0aDI1T3RKZm5lNnkxUjRK?=
 =?utf-8?B?SGxpQmhhVklBSUo0ZDQxVU9MMThTVlkxWEV6YW4yV3RIZkxQWmR4QzQwcVJm?=
 =?utf-8?Q?egYgnbOZKBwpyykRhH+f3ZGyj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6218ee73-4238-45ca-ef48-08dd20e1f785
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 10:35:05.2250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqYVcsA+q5dEMJG5eJcfIymzhYVp3TPBF98aJC6+jrRPmNAGSq+4JTcn7M3b4ALhu36xChPStgTFi8ZM4HNKoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9124
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

Hi Christian,


On 12/19/2024 4:11 PM, Christian König wrote:
>
>
> Am 19.12.24 um 11:38 schrieb Arunpravin Paneer Selvam:
>> Fix out-of-bounds issue in userq fence create when
>> accessing the userq xa structure. Added a lock to
>> protect the race condition.
>>
>> v2:(Christian)
>>    - Acquire xa lock only for the xa_for_each blocks and
>>      not for the kvmalloc_array() memory allocation part.
>>
>> v3:
>>    - Replacing the kvmalloc_array() storage with xa_alloc()
>>      solves the problem.
>>
>> BUG: KASAN: slab-out-of-bounds in 
>> amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>> [  +0.000006] Call Trace:
>> [  +0.000005]  <TASK>
>> [  +0.000005]  dump_stack_lvl+0x6c/0x90
>> [  +0.000011]  print_report+0xc4/0x5e0
>> [  +0.000009]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000008]  ? kasan_complete_mode_report_info+0x26/0x1d0
>> [  +0.000007]  ? amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>> [  +0.000405]  kasan_report+0xdf/0x120
>> [  +0.000009]  ? amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>> [  +0.000405]  __asan_report_store8_noabort+0x17/0x20
>> [  +0.000007]  amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
>> [  +0.000406]  ? __pfx_amdgpu_userq_fence_create+0x10/0x10 [amdgpu]
>> [  +0.000408]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000008]  ? ttm_resource_move_to_lru_tail+0x235/0x4f0 [ttm]
>> [  +0.000013]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000008]  amdgpu_userq_signal_ioctl+0xd29/0x1c70 [amdgpu]
>> [  +0.000412]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>> [  +0.000404]  ? try_to_wake_up+0x165/0x1840
>> [  +0.000010]  ? __pfx_futex_wake_mark+0x10/0x10
>> [  +0.000011]  drm_ioctl_kernel+0x178/0x2f0 [drm]
>> [  +0.000050]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>> [  +0.000404]  ? __pfx_drm_ioctl_kernel+0x10/0x10 [drm]
>> [  +0.000043]  ? __kasan_check_read+0x11/0x20
>> [  +0.000007]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000007]  ? __kasan_check_write+0x14/0x20
>> [  +0.000008]  drm_ioctl+0x513/0xd20 [drm]
>> [  +0.000040]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>> [  +0.000407]  ? __pfx_drm_ioctl+0x10/0x10 [drm]
>> [  +0.000044]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000007]  ? _raw_spin_lock_irqsave+0x99/0x100
>> [  +0.000007]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
>> [  +0.000006]  ? __rseq_handle_notify_resume+0x188/0xc30
>> [  +0.000008]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000008]  ? srso_return_thunk+0x5/0x5f
>> [  +0.000006]  ? _raw_spin_unlock_irqrestore+0x27/0x50
>> [  +0.000010]  amdgpu_drm_ioctl+0xcd/0x1d0 [amdgpu]
>> [  +0.000388]  __x64_sys_ioctl+0x135/0x1b0
>> [  +0.000009]  x64_sys_call+0x1205/0x20d0
>> [  +0.000007]  do_syscall_64+0x4d/0x120
>> [  +0.000008]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [  +0.000007] RIP: 0033:0x7f7c3d31a94f
>>
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 43 +++++++------------
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  3 +-
>>   2 files changed, 17 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 2e7271362ace..4289bed6c1f7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -122,10 +122,11 @@ int amdgpu_userq_fence_driver_alloc(struct 
>> amdgpu_device *adev,
>>     void amdgpu_userq_fence_driver_process(struct 
>> amdgpu_userq_fence_driver *fence_drv)
>>   {
>> +    struct amdgpu_userq_fence_driver *stored_fence_drv;
>>       struct amdgpu_userq_fence *userq_fence, *tmp;
>>       struct dma_fence *fence;
>> +    unsigned long index;
>>       u64 rptr;
>> -    int i;
>>         if (!fence_drv)
>>           return;
>> @@ -141,8 +142,8 @@ void amdgpu_userq_fence_driver_process(struct 
>> amdgpu_userq_fence_driver *fence_d
>>             dma_fence_signal(fence);
>>   -        for (i = 0; i < userq_fence->fence_drv_array_count; i++)
>> - amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
>> +        xa_for_each(&userq_fence->fence_drv_xa, index, 
>> stored_fence_drv)
>> +            amdgpu_userq_fence_driver_put(stored_fence_drv);
>>             list_del(&userq_fence->link);
>>           dma_fence_put(fence);
>> @@ -221,34 +222,24 @@ int amdgpu_userq_fence_create(struct 
>> amdgpu_usermode_queue *userq,
>>       dma_fence_init(fence, &amdgpu_userq_fence_ops, &userq_fence->lock,
>>                  fence_drv->context, seq);
>>   +    xa_init_flags(&userq_fence->fence_drv_xa, XA_FLAGS_ALLOC);
>> +
>>       amdgpu_userq_fence_driver_get(fence_drv);
>>       dma_fence_get(fence);
>>         if (!xa_empty(&userq->fence_drv_xa)) {
>>           struct amdgpu_userq_fence_driver *stored_fence_drv;
>> -        unsigned long index, count = 0;
>> -        int i = 0;
>> -
>> -        xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv)
>> -            count++;
>> -
>> -        userq_fence->fence_drv_array =
>> -            kvmalloc_array(count,
>> -                       sizeof(struct amdgpu_userq_fence_driver *),
>> -                       GFP_KERNEL);
>> -
>> -        if (userq_fence->fence_drv_array) {
>> -            xa_for_each(&userq->fence_drv_xa, index, 
>> stored_fence_drv) {
>> -                userq_fence->fence_drv_array[i] = stored_fence_drv;
>> -                xa_erase(&userq->fence_drv_xa, index);
>> -                i++;
>> -            }
>> +        unsigned long index_uq;
>> +        u32 index_uf;
>> +        int err;
>> +
>> +        xa_for_each(&userq->fence_drv_xa, index_uq, stored_fence_drv) {
>> +            err = xa_alloc_irq(&userq_fence->fence_drv_xa, &index_uf,
>> +                       stored_fence_drv, xa_limit_32b, GFP_KERNEL);
>
> That is even worse than what was discussed before. Now you have two 
> XAs and the second is incorrectly using GFP_KERNEL.

I think the problem here is, the WAIT IOCTL updates the 
userq->fence_drv_xa entries between the 2 xa_for_each blocks
exactly at kvmalloc_array memory allocation. Though, we are locking the 
first and second xa_for_each blocks and having the
GFP_ATOMIC in place didnt help to resolve the problem.

For example,
kvmalloc_array() is allocating the memory for the count value(say 5) and 
before we acquire the second
xa_for_each block lock, the count modified to (say 7) by the WAIT IOCTL 
xa_alloc() function (by acquiring the same lock),
and we would be iterating for the new count. But the memory allocated 
would be for 5 entries.

xa_lock()
first xa_for_each block to count the entries
xa_unlock()

kvmalloc_array allocates for count 5

xa_lock()
second xa_for_each block to move the entries to allocated memory
here the count increased to 7
xa_unlock

Thanks,
Arun.
>
> Regards,
> Christian.
>
>> +            if (err)
>> +                return err;
>>           }
>> -
>> -        userq_fence->fence_drv_array_count = i;
>> -    } else {
>> -        userq_fence->fence_drv_array = NULL;
>> -        userq_fence->fence_drv_array_count = 0;
>> +        xa_destroy(&userq->fence_drv_xa);
>>       }
>>         /* Check if hardware has already processed the job */
>> @@ -300,8 +291,6 @@ static void amdgpu_userq_fence_free(struct 
>> rcu_head *rcu)
>>         /* Release the fence driver reference */
>>       amdgpu_userq_fence_driver_put(fence_drv);
>> -
>> -    kvfree(userq_fence->fence_drv_array);
>>       kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>> index f1a90840ac1f..3283e5573d10 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>> @@ -37,9 +37,8 @@ struct amdgpu_userq_fence {
>>        */
>>       spinlock_t lock;
>>       struct list_head link;
>> -    unsigned long fence_drv_array_count;
>> +    struct xarray fence_drv_xa;
>>       struct amdgpu_userq_fence_driver *fence_drv;
>> -    struct amdgpu_userq_fence_driver **fence_drv_array;
>>   };
>>     struct amdgpu_userq_fence_driver {
>

