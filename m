Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50637D3B7E2
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 18:51:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C451310E44E;
	Mon,  8 Dec 2025 18:51:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="peIbQKi+";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B8A610E44E
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 18:51:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtsTr1/JEwXnrrWwCrVUsc20B9Wujal3yjEL+nIxwymqub23w5F6wiCN2ULHFbWk2ZsRz6zrR883ktUl39UZyqsqtQ6qwxa5qdzG9qdviyIqfdR3LZQOnRmc5BComzka2P8dXYWR9OfyPwQcTFCmGbuvuiTO8eYJkSZPsf9JeaMXIHSoBeAWfKLwPQgNRe3W4k5Z05hWTUpjuAiZhFnZEjvT0duv+gcyg/rojCmvYDm4n7ejvDLYNKFa57n1nMPKnOR9tkoxLwk/8ZywkAGrBpQrWsqqR0i23fNNwVJT7TTVSroD/aMOj1/qkxIxNTQZykwOfm73WFj9cbRKpiriiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqnyS2c5ocJRjN0pTXXy+FGamsTJQz19t4mKhHvH6iM=;
 b=pBHvHNtSUK+FjUfCmuIKay35dhCHqTZ2lnm9pqoA5LMbcfF31WPdPl60KIZMDN4TX9u056CFk0xKu3fORKw92YfBVyF2acSxMuUAxE3kxcu1h02VyCgmEyGoY5LgMFTQdjFpVKXUvCrSYJKnb/VKmCxDvQP011Ydom1Fmf1RBWFB0+m+7ReTNKhWL7fMPdBxffUdAg/wy3zBAJx8RHJO/yINxz1nFWKNg7GZFHq+iXmRbCroEhd969OjJariXod0V89M95/KVIGm4KIRjsh7nCXk0xJrGdQBtajlun6/YVGpc0IuRQwSuoYZUIpt5s9SAk56twuiV2ec2qHeJFDTsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqnyS2c5ocJRjN0pTXXy+FGamsTJQz19t4mKhHvH6iM=;
 b=peIbQKi+D+XUDHrEnObwC6R6tedW1i6q6xOUCCHuhS97E0GVakP7U17hAMkqoAzVCobqMWST6YZB63D/WdL0pQ/aoSTbfX6Qv/MtgDY4sGn9d+V5yn+UBYi3NwP/mUWOqfJd8i/wZ9Nf3v4fY8d3N/bXnsdki2pLrRG6MZPESMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB9108.namprd12.prod.outlook.com (2603:10b6:806:37d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 18:51:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 18:51:47 +0000
Message-ID: <cf3fa804-ffc5-4a4e-b936-5c55142c07a6@amd.com>
Date: Mon, 8 Dec 2025 19:51:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Reduce stack usage in
 amdgpu_userq_wait_ioctl()
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20251205121414.408466-1-srinivasan.shanmugam@amd.com>
 <245cd9a1-6a67-4970-a71f-ffc37563ac20@amd.com>
 <IA0PR12MB8208664A9332F0AB67C5A1CD90A2A@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <IA0PR12MB8208664A9332F0AB67C5A1CD90A2A@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c12bfbb-6991-4e71-0d63-08de368ad6ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkRpVStUOCtnV2dJR0U5bENpdjNPaWEyYVArOUNUT1A3NGw2MU1McG1maWU3?=
 =?utf-8?B?Z29ydjcyL0JhOUUvMEhyVWRnL1E3bkw2QlNSbGVFVUlyR211ekNQclVNQU44?=
 =?utf-8?B?bUs0NHBuUXRzV3M4dDVxT1ZOYWM3M3NWQk44NTcxQ0xkY0VWdHN5N2t1SVhE?=
 =?utf-8?B?alFiYWpLUGZ4bzRmWDNLdUYzYjRYR01ZRkQwQ0FuVUxVUVRCTytPUk1YSGRB?=
 =?utf-8?B?ZkJGMndLbzBKSVBPblRJYnU1SDZLSmJkeFNwRFduK3FDOUx4UkNaSkhDVnA5?=
 =?utf-8?B?R21QNnNMc2t0S0Fha0FReXdUVDIvNVloMEtDYmVVUHFRTlRRNmU4ZTRNRk9D?=
 =?utf-8?B?S1l0NlkxTm9kR3doK01LTkxtOFJOaWU4b2JMQkY4eHRCQ2V2V2VVYTJRNEpl?=
 =?utf-8?B?N1NqTFBGY25SVWhQLzZiZVZaSTBibUl5M3FnTlpRMDdPeEFMZG9NV2Q4OGxm?=
 =?utf-8?B?WFBycm02Q08rOVZFN3NTKzdteUtteUlxWkZKWkF0bmQ4UmRVQTRtUWx6MitR?=
 =?utf-8?B?MUhZTEFEdjFGTjdkc1EwZENta3BTQ0I5clRTa3JpY0V4VlNUZHZGTTVLL1hT?=
 =?utf-8?B?VS9haS9Ka1R3NnIyNjVDbVZhdk4yWWRYN3NyZlZMcTloL2xxaURNQWZvSTR0?=
 =?utf-8?B?ZXFMdVlIYnJKc0ppZWREY2ptT3Iwb2Q5VFQvK0dsbmUxdjNySWZ2NVN3QXpJ?=
 =?utf-8?B?eUFxMHdXSnM0SXNaMFl5OFVGYkMvL29Lc21uVEx0RUpEdzFyVlo5ZzcvTWpn?=
 =?utf-8?B?bEwvSkgxaStpc1pTdDVDbU1GYlNvRWJrT0dQZEFUZDcydkJNWUh6Skc3dklh?=
 =?utf-8?B?NEZNSmp6QTgvNkQ5TEpLdU5pV2p4c3B0dDQxeW0rTkRkdGhrZ2kxOGVvdktk?=
 =?utf-8?B?NG0zdlNxSGFQdE5pb3VVL1o4WHJUVHlYcEFvaFlQczdPQU9heW1mcHZCUGFl?=
 =?utf-8?B?R0pSblI0QlIvS2RjdFA1TjcyMC9POTdIdCtBb0NCZVJiZDZ1cDZhUjBMY1Nz?=
 =?utf-8?B?aVNCQlk3djFTZ0lRYTd0WkxsSW5nc2x1UXBsaFBIaFpURGUyVGVOR09kbXAy?=
 =?utf-8?B?aEgzQ3c3MlVDRnNNY2pzNDl1QzFNdDNGR1J5d3hUN0VyOUlvR1VyOWV4cnNK?=
 =?utf-8?B?TVMySWZqNW5jZ3VOSGhXTngvQTlJdUdtYzB6ZnV6N1lYVXV2VmRTQjdBWU9N?=
 =?utf-8?B?OGdJRTY2OHhIU1BpS3dvVS94YWI5TnVyTXRNOEZpN2lMcDV4cHZjanMydjBC?=
 =?utf-8?B?OTl1dm5vak1MeFJ4dzlrZGkwTXNqd0ZyYkdKVENPN0JPS2VsaWIybHh3RGp2?=
 =?utf-8?B?YjFDRDZkMXBFbWZoMU9aRXdjZERFSUVLZVhMWDFLOE1KR2hzWGFXVFlRTVJk?=
 =?utf-8?B?a2RDeUlqeTgxVXh0d2dBMllKWERwaVZMVER2N2Ezc0xwbDA2K0pPYW9sTjVN?=
 =?utf-8?B?Vy9Pamp3T1VQZmpwZkE4aUllOHlGaldHWmwxbk8wY1NwVzF1aDNFdDNsM0Jy?=
 =?utf-8?B?RUhWVS9ENEgyb05TQUFISU5BVzJ0Zm1pUFpYZ2JCcVV6eXB3elAvS0k1ZFRK?=
 =?utf-8?B?NmZBL3BGVWFxaEtESVcvNEJuS2tEWm42MkZtb3VoMzBjTlJnc3lSSGhXeUY5?=
 =?utf-8?B?NzROSzJsRXg3NTlULzNFSzVUUmhRVHpXdW0zTXlCYmhaeG9LN3RDRzdFSG0w?=
 =?utf-8?B?cGxwVjY3NkRsbjJUNmxsbjV1Nm00Y0owcytGeWZoaTNobDF2TVl1cEVwMEo0?=
 =?utf-8?B?anp5L1RFRWJaS1c0RVJFUjh3RXBnMmpHc05ZS1VOTDBtdngxdmszTTNXTUoy?=
 =?utf-8?B?TzlLc3BmK3dzWm95MEROUWl0YS9vMkM2UU16RERxVS9wSkwvdU5DaDFyWUdr?=
 =?utf-8?B?aHJlcER6dy9ESi9JOXhhNHg4MjgxMGdqVndpdHg1VTRvYTNGdWhXL2FyOTRT?=
 =?utf-8?Q?kKY6PhqcdGScdZ8cy+XdLzrub5FuBYuJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0dnK1hKbkM3QW02MFBxMWd4NjU1dUNOTGhwZEhwN3cwNzFkL0ZLZ2twMXN1?=
 =?utf-8?B?VE5JWFFQOGMwY1gxcCt1Sk02ZHlaZkYrWC9IN3FVUVNETU5KVExPNjVPdnU2?=
 =?utf-8?B?alpoWVF4WmdyT2lnbXpwaHhyOENLazJDYXR6U0tWc2tFSUNLSGFFNzlDS3Yy?=
 =?utf-8?B?RjYzZWRSQ08rZ2xYRVBwbVRQTE00OS9wOFpyU3VlNVVadmdBM21VVWRWSGZp?=
 =?utf-8?B?MFpTdkJROWwxcVRJS3VDY1ZaM1c4MEdPKzlRaTR0RVRqMHJJcDhyRlN4MDdO?=
 =?utf-8?B?Uk1pajZ5dVFEWUpVVkQvQklaazVWZlhld2ttdGtBZVcreld6Nmo3Q0dMY3hU?=
 =?utf-8?B?MHREQzhqajcySlBLdUR3NUxwN3lSQlhXRWVKNDc1cklZU1VBZ0ZSRXRZY0FI?=
 =?utf-8?B?Q1o1bjJXYldzY3RiY1BqajUxSzdYcXduQXNyaENRanc0d1dobHl2S1NBUld2?=
 =?utf-8?B?MlFjVm9LcVBOR21mKzVHSFBpbzdySU1hMVJVOXgvem5TVzhXZ0svK0hlTFpQ?=
 =?utf-8?B?WjJwZkljTGNpcGlLbFNKdTcyR3FjR0FWV0hMcWpQMkw1ajB3U2VlYnFac2VI?=
 =?utf-8?B?K3h1WS9DTFRiMC9vemFEQzM0KzE1U0R5bUZWZnFvRjVjaHlQK3Zha1ZyTE00?=
 =?utf-8?B?UmpwRnpsVnowNUUzcXlkVWpVZmY0N1gzSDJBT2hJQTVQa29pQWNmZDVzdyt0?=
 =?utf-8?B?QWY5TDhGV0RGWndzSHJUbVY2eHQycFlTL0JWL045YWJ0Ukt5OGUrVktBZWVU?=
 =?utf-8?B?bjlHWFRYeUFMaEQ3QS9tZFcwRHk2ekRHSUhpTXZma3JRZXUzYVR1Z2dNUGJO?=
 =?utf-8?B?czRmdGU3MnBOVkF3Q2ljaDRkbXNYZ3h6TXQvdUhDY0kybzF2b2laQmYvU21C?=
 =?utf-8?B?L1JnREpwbWJuYVI5T0R5UVhFcmFxc1hzbW1KbEk0WDhmNFZMWUNUT245M21y?=
 =?utf-8?B?UkhGUzFKaFE2MTJwMmtrVzFNWHpoRHl0aG54Ui94RmRlODdNV3RLWHBuV3Vv?=
 =?utf-8?B?Rkh6MldIVjd5SkVLc1BtOHd1YXZTNlhqaWZkUEN1S056Z1FqT3YvTWJud2ZS?=
 =?utf-8?B?ZVlGZzg1aDgzS3lMUzV2S0dSWUpwem54aVUvUEVqY1BGYmlScTF5ZXl5RUZD?=
 =?utf-8?B?ZWxtVHlUQis1TWVzQi9LWU5vcjU2OUJZUGR3VXNzeStXc2hmaE5aSHBNc1BL?=
 =?utf-8?B?Z0NHWnVaeUJLSHhMY2F6bWVNVklpRlVCd3RFbVQyQ3ViVjNxUUVMTFRmN2s0?=
 =?utf-8?B?Y3kxQWFJdjcySGRER1BsWWdVUlJlaXZOQjBmSzV5VmZiTExqbWg3MFVNejFZ?=
 =?utf-8?B?WTBxTUt6RGlNa2l0UWR0ZzJzVkd1NVFJMDJpTzNJN1g0VnNVaXkwMk1EUUZN?=
 =?utf-8?B?bDBxZVhVeW4xcE8zQnJKZTM1NHVMT254dDh6R1JMNnlmdm9ETGZtK2RJWVRz?=
 =?utf-8?B?VDIwbTZJWEhMOG10K1J3OStJNlVPbjY3b1FKZFFERUx3UkszRDhpMEMzYXRO?=
 =?utf-8?B?ekVldmgrTS9WK0s3bWE3S29SZURVV0Q3ZUVmTEFwNDkvdC8wM3lsVG9XR0Rx?=
 =?utf-8?B?TlhnWlRzQ3NKSU40VVQ5eHMxSGhwZlRXaW4rR3h2Q3d6VnJGZ1B3aUR0cUNE?=
 =?utf-8?B?TFBGSjZYb21nck9mY3FaV0pXVjR6dkdkZkZRa25Cd1YwMFlMRXFRM2tmUWRD?=
 =?utf-8?B?bVZzODB4Q3ArRzBFT1I2dksxL0RhZ3A2ckMybUZ3b250OGRmMzBCQUR1clZw?=
 =?utf-8?B?Ymo0K0h5TW9DK1dHbXdPY2wxYU0xYm44cjlYUmpFdDdhak0yU1I4ckxwQlJj?=
 =?utf-8?B?eHpOV2s3UG4zTVVIankrTkRmRzJzYUFoUUloKzhaZDhUcXljR0Z0Q1VBQXR1?=
 =?utf-8?B?aHNadjEzbW84cGdDRWE4WGNQTFE5YVlrRGR5ci8vL3FsOGN3d2FhNjM1MXR2?=
 =?utf-8?B?Mks2VjdmYSs1dm5pOS9ZWEwyejhORFJsSWNiMlRSazdhWlZhZXBTMWNDT1px?=
 =?utf-8?B?ZFhDSGI1UEtrQTRkd0l4VVB5anNEVXluT3F0Z1hsZnlKbUNjRnhqbnowSVRj?=
 =?utf-8?B?RmJ0c3lZVTg2bnlsalRFZ09qeGJjOHFZckx6VXQvY3RUMU1MRFBNaTlkWERZ?=
 =?utf-8?Q?DYxmESfg1pkHKDViu4+xjV5p7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c12bfbb-6991-4e71-0d63-08de368ad6ff
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 18:51:47.5052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trpDv/gxAk/Yn+yh5J7349F/Bcx97Xbzauu6e8BgBBadqT+9U44mW6v8iIutn4Ed
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9108
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

On 12/8/25 14:33, SHANMUGAM, SRINIVASAN wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Friday, December 5, 2025 6:30 PM
>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdgpu: Reduce stack usage in
>> amdgpu_userq_wait_ioctl()
>>
>> On 12/5/25 13:14, Srinivasan Shanmugam wrote:
>>> Checked all the local variables in the function. Most of them are
>>> small numbers or pointers and use very little stack space. The only
>>> large item stored on the stack is struct drm_exec, and this is what
>>> pushes the stack size over the limit.
>>>
>>> To fix this, struct drm_exec is now allocated with kmalloc() instead
>>> of being placed on the stack. All call sites were updated to use a
>>> pointer, and all cleanup paths now call drm_exec_fini() and kfree() to
>>> release the memory safely.
>>>
>>> This reduces stack usage, fixes the below:
>>> drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c:642:5: warning: stack
>>> frame size (1176) exceeds limit (1024) in 'amdgpu_userq_wait_ioctl'
>>> [-Wframe-larger-than]
>>
>> Mhm, I'm really wondering how that happens? The drm_exec object is intentionally
>> so small that it can be allocated on the stack.
>>
>> What's going on here?
> 
> Hi Christian,
> 
> It looks like it only grows that large with sanitizers enabled — KASAN/UBSAN inflate the frame, not drm_exec itself.

As long as that is not showing up with KASAN disabled I don't think there is a reason to fix this.

Regards,
Christian.

> 
> Thanks!
> Srini

