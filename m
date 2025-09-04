Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19EDCA1012
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Sep 2025 10:09:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2672F10E162;
	Thu,  4 Sep 2025 10:09:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QUkBnQFf";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AD0410E162
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Sep 2025 10:09:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccfMD1FVCNgnJLl3EpXr7WZImRZJij7e6qYfCuqyb+UIbwloo5YolmAf1ftQW/RTEmUMba4dO1sVxGVP/NcAjIDULRqrCR/jAniklQNDG+k9Xqcmd3UVoB/7hPqPSyVbxMHXJCTDAx/qYEIJwGPeLtG+Nd6WU7bAmvNnl8mz6cuTiPLSs72c/io6xxQ/yRIeHfu9apzrIyVY1U7JehP2GexpcFBYWD5hqVLiv+Ml2KMO5aUlA9+5eDXE2wvB07lhIdm1qibLRN1asUHbuIbzjGdN2yHGexV8Ld4Ow3sH2+/h+qypeEARqk4WCjPgYGnFQRiQ2C97p8GGlC6LN6bjTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwnsluX44vV9EnA3tUvxstSJkGgCLAZ9YiieRSPGO8Q=;
 b=qgbOkETEMUxp/oQzdigBdosF1C5M9CdoE19ke1ARJPsimuKgrjq0eoQCufs8Y7HAXXAkfajPrsvJR6fdS74BdotocdhlDn09efk8rRRSdHwAcCmPkiIzBMAsZ3HnJtLwjjaGZ58a2xYztNWuQ5dkd6h4P8yZXV0nEldMRk74Rce9OYqnJIxm7FdQTsyzqZ8TPkLo+eep4wJHc69zkDklegyHs1Oa2j4pRMghUL/NgxcXB4/vWZdDROOMs5WAlcU0y2HQ1GCqD7HtVy+PSojgyVZBYRTQu7tDS57r5Tc8ugXjwjknuPwDY3IGiiH80fNCZFPbqEkoxNWO2q4TZ9397g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwnsluX44vV9EnA3tUvxstSJkGgCLAZ9YiieRSPGO8Q=;
 b=QUkBnQFfU5ZK5Kw5aDmmtj+BVMzIue2aN9EgWmqsz1MUt0S6hNumMBwbEjOdbxOsWrygo0M+u8izL0CHEpWvUTPLDMIH60fC+JPxAuy+lilqC4QEydEqxos3rjRiIZSqWnCKo3xzLn5Tj4qGWKrXwO4kLNgjYKIrJ7V6Z/FyLhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH1PPF711010B62.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::614) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 10:09:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 10:09:17 +0000
Message-ID: <e82e1ff3-155c-4136-ba71-5790557d87e2@amd.com>
Date: Thu, 4 Sep 2025 12:09:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: fix userq VM validation v3
To: "Liang, Prike" <Prike.Liang@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250828150200.4035-1-christian.koenig@amd.com>
 <DS7PR12MB6005E805200C4DF8F35C26BFFB01A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB6005E805200C4DF8F35C26BFFB01A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH1PPF711010B62:EE_
X-MS-Office365-Filtering-Correlation-Id: be2c7591-f3e4-46ce-7705-08ddeb9b1b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWoydDJRbmIxQjZIbTBrNTNEREk2TUlKOHJaenhYYjBCbk94YU0zVnpBL3Ry?=
 =?utf-8?B?aVhaeTRNckRLcjhiYXowMDNONUNFYWsyZC9zbE1ZYVJQRGprR0hEcTA5L3RR?=
 =?utf-8?B?LytVQmFTVGoxaE9XcCtpUkxaVTJXaDdXS2IwOW5BZit1UlhUYzI3RGx1c0o0?=
 =?utf-8?B?QXovSWtUZWJXU2txanQ4a01hOWFRMVZZUXY5NUpBQUd0ZDlhL0E1Nld1Ulc5?=
 =?utf-8?B?andoVGZLdkhJSWlrZWp4VDhRUUlxV1VqOEpoNjRqMC9mL21RQWRrTlZlSUxq?=
 =?utf-8?B?UVFpblJjT0tMSHZReVJKaDlpN1lUZ2VPeTZ2aVJpYXhOUlF6MmtFWFRYck1L?=
 =?utf-8?B?dnNHSjB0UDlrUys4TkJNUXJ4NGRubGZTSThZME1Ib08xYU52dmxjd1c2K25P?=
 =?utf-8?B?NW9zeGhTZHNyR2ZKeElVWXkzMDU4amVpZHJOdHI5LzRQQzQvbFVySFpMS2xO?=
 =?utf-8?B?SVVzWXBST21lNG5GYXhYVGFRNDVMV2d3ZVZzWXBSQ09QR0JyclA3VUREblRL?=
 =?utf-8?B?RzE5cjBMdFo2SGZuVWlxQ2NwUGpzUjlMQmdjSk9jSmNhbEdJMkpReUNiWU9H?=
 =?utf-8?B?ZnIxM1RHUzBQaGx4UlE0eHVybXBLcUZrYzV1NThJNnp5SDd6cHlIeHA5clUy?=
 =?utf-8?B?TVZPQzlaUlU4cFlZZnU4VE56dXh4MmxFUDlVcWhqTzFoMEJxazluMmRiejFr?=
 =?utf-8?B?MnlRY1IrdnMvc0xkZXVtekY0L081WU9iczZYMUkrMlIrZlp5L1FmKzJoY3Ry?=
 =?utf-8?B?V2d3U2RWV3RkSVNFV3FkVVU0NnZ6MVlVbUpkOTkxVEVnTitzNk84c1ZWSW1x?=
 =?utf-8?B?ZUhOZGJ4QVBuMjRJb1N2a0hzWW10bCthTzJqS1RKT005MnZMSXJ2YSsyT3pW?=
 =?utf-8?B?bmdZc3p1VWozT1VFMGNhdkg0eWxCYi9KblN0elVHR0RDcFprU3VISk92Mnpv?=
 =?utf-8?B?VG9uakFTUFJQNUFQSkcybCt6elk2QjNFeVpMOXdkeUdkR2pMNyt2TG83dzM4?=
 =?utf-8?B?dVR2SXl2S3I0dXpHd01JUENrMEg3M1hndmg0VlVBUnJNaHlwUkdPQitmWFdx?=
 =?utf-8?B?Y2FJMFpqS3pMejJkdE5SMUIrbDdWWmdSdGE1NlFLUCtOZHlPRnhaZHR1d2JS?=
 =?utf-8?B?TnV1TmR5R05PN20xa2xobVBLZDNOTTFZNnpHQmxzK3A0TndnRCtHSUxyN2hE?=
 =?utf-8?B?MEgxT05jWFNYTnhRN00vY3REc0lsQ2grUVFraG5iNzkwVTY4UUoxaCtFNUNq?=
 =?utf-8?B?RFB5V1pIQ2l4WUZyZmRzdy9KSlhCTnMrbm92bHRxOWh1R0JTRnFVZU9TSmR6?=
 =?utf-8?B?OTVFSU9ZczhzWlJiclRXZXphNXpRZjRLV1BEN1dGd01ySUJpU20wem1vU3pV?=
 =?utf-8?B?UHJybTNoVHdRblZ0QlNuWmNuYkFrODNhQ0lHRDJIVlR0R3JjSWd2SGVSWjBt?=
 =?utf-8?B?UlYrSUhaZHBzOEhLNkliclFIMkVQK2ozQ2xtZ1JkQjBWVXUvcVdnam0zWU54?=
 =?utf-8?B?R1Mwd0ZUdFhxT2VrbTk4L3I0MW5DQXROMldFSVJFVTdGdS9aeG5wV3NBSHA4?=
 =?utf-8?B?NVlCT1VYZkZkVUpXTGpDSXc5OE1yZ1ZqMDhuUXJOdWFyZnFzMngvQXpWSzRX?=
 =?utf-8?B?eXFYdWJUblR2cmo3WW9VUHE5b0FSK0RWc29tejQwa1Y3TVk1OXNzWmNENTVU?=
 =?utf-8?B?U2xJZmhKd09YTzkwTFNFYWdyb3AwVitVc1ZaUFQ4WHB6NE1sczlYcDREUkJt?=
 =?utf-8?B?T3oxQ3ZIVlJQVG8wZmtJS3NsTEc4NUwvamNqQWM2bFNGTmlQZWoweXc0TzVN?=
 =?utf-8?B?ZXNxaDVSa0wwR01ZbUZqVmFkRG1BckE1WVFzNEJjQnRjbFdkM3QxREZ2N0tv?=
 =?utf-8?B?TDFVY01TUzFaV0EweVQ3UFQ1NFFkcHNTUUdraCtUcXk5V2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWJqTnBYb2dXZlErM01TdWVwVkRpZVN4YTE0S0V3bHlOd0pFOWZnamQ0MW9v?=
 =?utf-8?B?eVE5RDNsSVpCRHlWN0pORkEyNFZzUStoK2ZMeHlFYXpZSVVGVGY2OE1JT1FO?=
 =?utf-8?B?UjJseU5HNkZuTktZUWZQNmlGUm0yMkp0WG9JYXJVS0VwdTdleGs2K1V0UzNJ?=
 =?utf-8?B?SU82SlQ4ck9nbnoyMm9teWNEOGl4aGIwb3BMNGM1UVFEeW90M2c4VGJIaWlI?=
 =?utf-8?B?anVaaHp5YVVBM0RHaEt0R080UDNManlEbkViMEF4QUdscGUxaDBpMThNSVIv?=
 =?utf-8?B?ai9zdTVRSTcxcW1QZlVWMTlzTVhmSnBaVXNuQmUxaHdwN0E5ajU0c0gyN2Nt?=
 =?utf-8?B?OUVQbGJ0SndXUzdoYzB4ZmdYcEVtR1dpRURNS3FTVnNrbjFjYTVocEs5RGJ0?=
 =?utf-8?B?M1AxSWdhNTBWbVZsTFI5UGJmS2NNVXRYU2NNYXhTOUNyRTQxZlNoVmEvNCtz?=
 =?utf-8?B?MDhXWDNicnVZOEtjeW5admlqZkd2YWltMUpZcm1IZytLcEY3Y0tEQm1qV1o3?=
 =?utf-8?B?SEEwTWVxZXVja3RxL1lSaWd5RDgrSGRSc1V5aFlXSWNET2RNKzU3cStsK0J0?=
 =?utf-8?B?YlFvelFWZDVzN1FqdmpWZUM0Wm80VE9XQkRyWUJVb01pTlB4dnpqSktWeVo2?=
 =?utf-8?B?T25NN05mQmE4ZlV1V25Mai9nOUoxR0pjemxhdkk3aThEWkNTQy9wTVVHa0Jn?=
 =?utf-8?B?eG5KTTZveFd6LzgycDBSbHZOUmJQM1l2ZGVkaXFuYndjWnZCWHgwTDc2U0tY?=
 =?utf-8?B?eE5QdDdsaXA1MHZQNzVzaGgzSWI4QUJUQ3h2U0xXSVF2T2F5NzF4K3hRQ2Va?=
 =?utf-8?B?QmRRMXZpaDR1ZVh6Tlh4MGZMTHF1eWtLTExkbzVmVlFMaGFEYnVlZUVobGR0?=
 =?utf-8?B?SWhwQUdvTUpoSGlDN1o1d0FjeGU2RlljMnN6b21OZDdzZXg1RG5ENU5QdkdR?=
 =?utf-8?B?SHAyRW1aVGlxWnlET29neGJ1a2dRTjJIYWIvSGN2bm13OExFTUREbE5LM1VL?=
 =?utf-8?B?VGNQbEVlYWdBSFQxRnV6bGlVTEdxVWpsZ3Joc2hRd2JaVkMvQlJhZ0F5dHdz?=
 =?utf-8?B?VnVDblptdHZBNDRBUTBDajNBclpaNHJlWmRPS3ZtYUtkZ1lIYmhvaGxXc0VW?=
 =?utf-8?B?UG8zTS90Z0EvSnJVTHpGaG1ReDNuTjVNWjA5R2VmS2kxVmZJVzhkRlVDREFI?=
 =?utf-8?B?ZlJ2ajdBS3V6UkFuQ0IveVpKMjlaRlV4QWs0VVZCK0tuK2N6a0pGUk5uQVJw?=
 =?utf-8?B?cndOTXhwWGtuaE1kNytLSGhwNDNleDc4UWZ1bDk1OExFWE9LWkNTcFlhMDBt?=
 =?utf-8?B?b3doY2FVVXRTb3dlYjluWGVLcmNUbTJBdXI3bWloT25YY0tWTkdHSVZTN0lw?=
 =?utf-8?B?NXVJc1UvUGZYWFdRTFpIbCs1SDhtRVV5S3Q3dmQwWHo0R1JsNlZ1Wi9QdUV5?=
 =?utf-8?B?VkoyNmRSbWx4Z3dJVXNHVW4wVEZCaXN6eS9mY05maHVSTEdpNzVDQ3pENWtB?=
 =?utf-8?B?clBrNDlzSzl5NkJmV1FKOFBaWjd3SGdLVDZnNFFKVk5weXg2bUpQbGF1Ukcw?=
 =?utf-8?B?RkRrTVljejU3S1VOYXBUQUd1SndwU1dlZGNkOWJuSTlNK0U0b2drNWZXc1BP?=
 =?utf-8?B?Q3Nnb2o0YVg1NTV0Z0pqV0J1MStPVVNPRzlBeDZJdnUzbzg1WjlkNXo5VHNx?=
 =?utf-8?B?ZHJLTTZzWWVHSnlmRDhBRllUZzg4UHViQkhkcmpHOCt5THYwMUgrQlk3ZmM4?=
 =?utf-8?B?djZRbUVDcUhDMUFSeUE2NXZXS2diYWJReEJsMnlrRHdHMVlBSFMxWVlYdnBi?=
 =?utf-8?B?TWdqcUtiaXV4cVl4b1V0ODhncGdyK0EveFRGY1I1NHVLc1AzMHVCMHpWamZ3?=
 =?utf-8?B?Vkk3NTZkT0tCQXdNQTREY2lhZkZOQWcxaE00MlJhbjdnSDVzQjNyYjZPMmZy?=
 =?utf-8?B?cVR5VWtHdXZRdW1QZ291UERpWEJwQVVUOGl0K0NiZUsrSW5acUtrYUJySVBv?=
 =?utf-8?B?bnpBZzdvaERHdWdjaTl4WE42dGsrV3kzUVNNL1o5QU9LZVpzR2RVcFZOdWsw?=
 =?utf-8?B?YmJrV0RCc2lwL25hQjl1OWRPNG5EZWxoNzNMM2FieGhyS0pUWGcxM3AxdFdu?=
 =?utf-8?Q?vUouKMqbdrBNru0GGsk7Aa1As?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be2c7591-f3e4-46ce-7705-08ddeb9b1b5b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 10:09:17.0252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbD+da8tpwo+oUuTPRE4kkF47WyfJsPws0itPrBfNJqrW9qm+EBL+B2tJ97bkgf4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF711010B62
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

On 03.09.25 04:52, Liang, Prike wrote:
>> +     ret = amdgpu_vm_update_pdes(adev, vm, false);
>> +     if (ret)
>> +             goto unlock_all;
> 
> Do we need to create a sync point for syncing the VM PD/PT/PET update, and ensure
> all the updates done before attach the eviction fence?

Oh, good point! Yes we need to wait for the page table updates to finish.

Going to fix that.

>> +     /* We can only trust prev->next while holding the lock */
>> +     spin_lock(&vm->status_lock);
>> +     while (!list_is_head(prev->next, &vm->done)) {
> Can here use the list_for_each_entry_safe() for simplifying the done list walk loop?

No, we need to use prev as anchor here since the list element can be moved from the done to the invalidated list while we try to lock them.

Regards,
Christian. 

