Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C41C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 15:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53E8010E059;
	Mon, 17 Mar 2025 15:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5hAyl5p3";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 320B510E059
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 15:39:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrnBb4VcjONlpTUk5Dj4vuR3gpSpQHVWhNwE58gGfcz0BS/uELBI0SNaLPReOce6j3ZEXJXybil3Xg3+tEZ1Siq4+7oGltxW1R+yPGlMwO+E16RfLSM0qFvno75B4UZg2FTH9yyA+KwJtaSb3ISXGHhySEO8FbKAVveNFJS1COSrqLyNUVdrTLD5+rlnVo50jOJ70aHUmJrGKiiGfggciOXmGnYfYFF5vivr4+Xuh6fwkm9lG/qLFJTfV0Csm5ZjGS6r3t2l//ss0v8x/ZHDEepm4N6xjASkbh5L8uLyOKYZGcVqFGLRoS5gbk2SzgvKS5zlU33JCaAnUdeRYJYl/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=du4AKnj8pOwx92IotL+BAT1hKxbewQNKpdmGcZwdhLY=;
 b=asYT5QjQ2PLs2uGcp/sKlDW5i+srY7ZdgFvY8HiUQC///Mcm8NYML5g1BKK7iu4lkmI664BhvAo0zdz27cSPxZOJWcM1f5c/m5VX+uK3NUI8ofdj4FOSBHbJTYYFeKBPrC7eRWPv8oUFPBIPlrqvuznOS0XElglAdzoJO+pDS2J2YteoyChjkT2W02P9OVVvl0asqc3VVafiAyqUYlXthVKsPt/xXi6SadS3l/d5XBN/sLq06CejAwCACH8n6r9G4OLw8UyqaLPMX7h2EXfdiYKLvKSZWg2YAWeenlXzKiLb32LtyQOfKmxH67YiuCn1fH9ObwiL5RxeqUV5+77acw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=du4AKnj8pOwx92IotL+BAT1hKxbewQNKpdmGcZwdhLY=;
 b=5hAyl5p3ivl0VgmZE4jBC3hCY36gjI7QDHSjq07SfxvB8aOef6tACkI8P14s/qHYo47yevHdvGiKvDTs4MG/kNemv4Wek2EBpu4ZI3RLl+KMjSaQI0B4o+Fx8HMDgFXdmCreFi0r1OGAkw+QelZtVd/mWlD18G+eiKsbIbeo3io=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7454.namprd12.prod.outlook.com (2603:10b6:510:20d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 15:39:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8511.026; Mon, 17 Mar 2025
 15:39:18 +0000
Message-ID: <53f74142-c74f-48d8-a3bc-4f5f0e65ab25@amd.com>
Date: Mon, 17 Mar 2025 16:39:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Wait for pte updates before uq_resume
To: "Sundararaju, Sathishkumar" <sasundar@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250316153635.1181513-1-sathishkumar.sundararaju@amd.com>
 <20250316153635.1181513-2-sathishkumar.sundararaju@amd.com>
 <6face0d4-8adf-488f-84c8-12a012bdde15@amd.com>
 <6fa6d314-3da3-477f-bdbc-31632cb3c774@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <6fa6d314-3da3-477f-bdbc-31632cb3c774@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 2794fddd-bdad-4409-3717-08dd6569e106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1BIZUxsenVTZ0dGMk1VUFZoQU1jT1ZtTnczeG5uR1Uzc0JyaWgvcElmRWVX?=
 =?utf-8?B?RUFLK1RVNlRlOFc3MDV4UFYySVk3QVkxQ1NuZzVUKzFKV09LZGdkQ2h5MFhC?=
 =?utf-8?B?VFdBemYybjVFTGV4RUczcStQR2tya2hhckVxL090QXdrellxM01yKzVjN2d4?=
 =?utf-8?B?eVA5Rk1uRzdMTExya3g1WEpRY1BPZ0lUa2ZGR00yd1BoSW92NkF4WkE3aHF0?=
 =?utf-8?B?T2J5MUZVdjU0WkVrcHZpcEtGZXJBYlI4U0lGUkV0U3R1YjFEU3pZZER1Z0Zw?=
 =?utf-8?B?dFhzRDR1SVFYRlJOUTlHOHAwR1JqT3lSenhXc3BFYXhQSGtoMTYyQUFjNXpO?=
 =?utf-8?B?TmxiWXBwamVNZDV4WFdCSzF0OXRFR1JlK0FGbi9oSHlLcXdUSlVZcXp3WHFO?=
 =?utf-8?B?WEtDVk8zallRUlFERFhUVlY4V08yVEhoM3ZQTUFmZndvV044WnhSQUdDWWhU?=
 =?utf-8?B?V09VcUZkZVVkOE05N2hpVzJybExQZnNneVUzTkhTNHZGOCt0Q1dMRjlDRTNl?=
 =?utf-8?B?UnVWcjZEQ3RRYm9EVldwVmNGUjgyRHRJci9HYjB1c0hEQzRyK21tWU9xN3cv?=
 =?utf-8?B?VVJYUzVEOGRhemRyTTY4OWgrZnluYnN5bWY3b0hzV3RVRmtsSFBYeTBqdys1?=
 =?utf-8?B?VExETzBOVTJEV09Rb2R2VWdFZkZ4Q0RsRzJkZlRubW44cVJMMG1iOUlnTzFa?=
 =?utf-8?B?djRockNqMGtjek1kZlFhWi9JVDJ5VHNwUUNHY2FjNDJReHRwNVRLQVFncWpK?=
 =?utf-8?B?SVZwR3VJNTJUZ25lVy9qNjhpTnNpMVdrVkVNUVNpclFpVk5SVzJFZnYrS1JQ?=
 =?utf-8?B?YW0yNXFJWFpJR2hYSWlFNllYSGVZejh4c3hGbUFVVjNNZ0U2T2RVcjd0RFlR?=
 =?utf-8?B?OGNrV2VxRGljd1pHbStpRUptMWp6UmttclZuTTExUStTWUdlMDMxTEp2M1RS?=
 =?utf-8?B?dUdReHVTb1lyUjBnMFA4RkpCNVhWWURJVGdPaStJZERtdTNJWldnYW01Y3RO?=
 =?utf-8?B?bW1JZFFWUW5BWmpTUFJUR3hWNnJMUDZ6N3NvcGRJQ1hLOHBpL3lsdmdqaWt1?=
 =?utf-8?B?ZzQyWUdYYXNmZHlkSWJiUU1JUThzb3REM2NONzBwWGd1clJYMDZxdGkrNmNN?=
 =?utf-8?B?WjZ5S0pXSCtXMkdKWXZYUmJSUEtFUXo1aTl0VDYzVWV5WG5KZXROWUdHeWQz?=
 =?utf-8?B?N1gyM1dFTCswa1FQdlhsRVhZRjdvUW4rZmdjSFJwakVzNnpMTDQ0SDM2bHR2?=
 =?utf-8?B?am5DVjhBTzBQWnI0YWFJdDRPQzlsY3VxRWloQStOWWdRNldyRzBJOHlaS3A3?=
 =?utf-8?B?VUxtYmJQbmFra0Y1dTQxN21kNzNzZEF4TjRSbHpkVjZrdUEzYlp5L0JvYW12?=
 =?utf-8?B?MDhHNGZFMzZVMnN3aExUSU02aWFQRzc0SklFalBoK09rTGdCdnlSZWNyUFZI?=
 =?utf-8?B?UGtaSDREZ0toK3dRckZzNWJ4V1RuNjNPeUdaV29MVmcxUTBEUWhDQnhmOEIw?=
 =?utf-8?B?SVlsaWgyeHFQUVB0TTQwNW1RVGZsejcwNXhkWkJQZTF2cmd2ZGczTXNMMER2?=
 =?utf-8?B?RkRvc3ZYaHBka1BlUkZJeldQTFcvSHZYVEdQcnNNajRhdGhSOHdNMHQxcElu?=
 =?utf-8?B?a1ZuWjZjY0JnTi8wYzJTUndSbVluSjg4c3dFUDhKTVF2NnpXemU0bWR6NEZZ?=
 =?utf-8?B?eVZOWVROd0duc2RwOVlVZGxDNDZTbFpwMEFEREhKektUNDJLSkZtKzVBYm1s?=
 =?utf-8?B?T25CcjMyWHJyNVk0REEwRi9uK1NYSmlMVkRsSnVOTDgxNDE0YmhNb2ZWbHla?=
 =?utf-8?B?VFp2dDNnWC9Zclk1Z0Fmc1MrK29HUzNkOUszR25udmpXU29KQlFhWE0zV1Z0?=
 =?utf-8?Q?BsYUUlCODEDBI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm1CcHdWckZ4c0NicnZtRHU2UExLREhZL08xMWVOdmNqVTBqczIzWlVvcDdv?=
 =?utf-8?B?RWx1WDI2ZU9nZFFEN0NTaGU1TU95OVE5QkszY3hiS0l4U3NsTGtqb2FuYXRn?=
 =?utf-8?B?V2lacG9jMW9QenZpVGFsR1YzZFA0UWVEeDd1R1UyUzQ5c2Q3Q282Qi9PdTZy?=
 =?utf-8?B?elRPOG50MjJ6aDU2dGRzVzQyV3RuQ3dUY25FNTFtNGhEekZ5QnN3QXBabTJQ?=
 =?utf-8?B?am9iaU5Cb2prK1VJTzZCZG1hQ1h4R2VRTGNFYWVObGMzS2pmT2FPMkNGYjAr?=
 =?utf-8?B?T2N1VzRVWDdSMXNqSmJuVmN2KzZJM3JxNEU0MDBseEtSSHhyeGxZaEg3NFBp?=
 =?utf-8?B?ZStXVE5XVit3NTVhSjJDUEtFUXFXQWRtWS9UdEJqU1VyMEJIc0pCOU1QbXQz?=
 =?utf-8?B?TnZqa2tsOXpzaXExSUE4anc5dGFVUktWd0dQdjRlcUMxbFFiaUNKMmtVUnhP?=
 =?utf-8?B?K2RWa2RGdHpEcnF6OFZJeDcreldGWWt1Z2NadDQ1UC91VmprR3lzT2w4ZFVK?=
 =?utf-8?B?YmxLSVNCL2U5aDFqTU9aclJyK2czN1d4bitMbDM0bkZEOGVVNGtMa2M1a1ZX?=
 =?utf-8?B?U2pXWXJRMzNkK1dXVnZHWTFta1BiU3BIUmUxNjJBSFVxOW13Z3k2bUdQdDNn?=
 =?utf-8?B?cFpYcnpjSnVTb2Fvb0lTbi9lbzlidW9vK2lpV2E5bEt3SGtKOTRUZWZzejlm?=
 =?utf-8?B?ZEExQjZjSjdoaHJCSGNCcmphKzk5RVplRlF4WWdVbUM5VytKVWRtbEQySFkv?=
 =?utf-8?B?dlg4WStyalFoZmlxbDI0aHBUVTJMQzhXdkVvamp6VFNpVWExUzJreGdJeG9j?=
 =?utf-8?B?QysveDZsTURQTzl5dkFxeW5UaU5XcHowQ3hpdEErTVlZQWNtTDcyUDdUb0lw?=
 =?utf-8?B?c0FTV0RGTVE1QURpV3U3Z01Ha0FkUGlzUlI4VDlmUzBCVW9ML0hlVzNVQm8y?=
 =?utf-8?B?M1pFVE56R1dETTdkaXNwWW5ZSHAxMGI3Qm84allqZEQrbmVGbENqZW03YzRz?=
 =?utf-8?B?dnhIWmNDVzlZVlRHTUJNeW9jV1YvcG9lZUZxYU5mcWVrVXM4eGhhdDFGWVkw?=
 =?utf-8?B?a0JWbUZ5L2NENmQ1UVBJcEhXaDRqNTlieTVCeDFtMUcvQW1xUWEwcHU3V25q?=
 =?utf-8?B?alBLbWphSDNhOVVLb29mcnA1L0dKZHFTeVd0RDlCYkhrUTRiRmxqMlpuVTNR?=
 =?utf-8?B?cWdqcHJPcm5IU0FBdWpSRlA2ellRRU5CR09vKytaemtFTk5Qb2VNdHkrT25F?=
 =?utf-8?B?RGc1MnQ0Tm13RFQvd2VTbC9leTg1QTJXNDBWbUZNNW5vOTZxRnh4RUFmUEJS?=
 =?utf-8?B?QUdjc3o0bEppN0ttUnJmOThyeWw4cUlMYlBSS3pXVDFqNUp2cHJtT0wyVGpu?=
 =?utf-8?B?MjJ5Q05oOEVleklnaTk2b0t3SC84K05KM3FnYmQrallaV1UzNjQ0VVIrbk4w?=
 =?utf-8?B?Q0QyQjNLNUlRb2gySTZab2ljUTJIVWFSc2ZnTDVsR1UxZHpHUUhOQVBlQnUv?=
 =?utf-8?B?QTJ2TmNhS2Vrb0l0V3NTcUFnU2VhZEEzYVpBdDduUklwUXhyK1BMZkJqdUNG?=
 =?utf-8?B?MGx0L2lCY3VjcTFaZlptWkVCc1BpeXFXZnZvOWJONmd2ZzV0Y1BWSmY4bHQx?=
 =?utf-8?B?VDhWMTdwc1RaUjZlZkdyeEYzamFCOHd4QzdMV1NTcWFaWXdVWDhWY1B6ems2?=
 =?utf-8?B?SXdua0ZRbSsxd1V3aFJteklBTG40NTJIcFVyaE5TWUx4Y0h4UjhjV1RDYjl1?=
 =?utf-8?B?VmdGZ1dlM3pzQkxseW1qcSs1cWRITVlaOTdGSTNyM0lqQVdSc05kUHJHS1pK?=
 =?utf-8?B?VTY3ZWNERlNIUHdKT05IbkplK2xxczZQdklUOW9xYlQveTFqL0ZxUngxbVJ1?=
 =?utf-8?B?dXU3S24xbytJTE40d2dVNllNSEx5bXc3K3o0YnBkbXVEWW5ReCtZUkF2SDkx?=
 =?utf-8?B?aC9wMGtidWFXbXo5aEVCK3hmU1h4VERzUXVseDMzem5ZdnVlanNoR0pvZVJy?=
 =?utf-8?B?V1BLUnJkakdkZ1QwS01BcERGYjVLTFBmMFNTRTFRUVVGcTl3VHJCS0c4R0hW?=
 =?utf-8?B?M0JhaWVXQUJGWEFLVFI1Lzk1bmZMdkJaUjRYQkFRL1gxRnpPY2o4THYzQThY?=
 =?utf-8?Q?EpvB2hIl/qdBpqmtU7PZ72511?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2794fddd-bdad-4409-3717-08dd6569e106
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 15:39:18.0834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEsSQ+p/411UeWudsb8Q30k7OCKHEFnRdFJguXZ13BlO4zPLWEWJjnTQ7ncr3RRV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7454
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

Hi Sathish,

Am 17.03.25 um 15:40 schrieb Sundararaju, Sathishkumar:
> Hi Christian,
>
> On 3/17/2025 7:33 PM, Christian König wrote:
>> Am 16.03.25 um 16:36 schrieb Sathishkumar S:
>>> Wait for vm page table updates to finish before resuming user queues.
>>> Resume must follow after completion of pte updates to avoid page faults.
>>>
>>> amdgpu: [gfxhub] page fault (src_id:0 ring:40 vmid:10 pasid:32771)
>>> amdgpu:  in process  pid 0 thread  pid 0)
>>> amdgpu:   in page starting at address 0x0000800105405000 from client 10
>>> amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS:0x00A41051
>>> amdgpu:      Faulty UTCL2 client ID: TCP (0x8)
>>> amdgpu:      MORE_FAULTS: 0x1
>>> amdgpu:      WALKER_ERROR: 0x0
>>> amdgpu:      PERMISSION_FAULTS: 0x5
>>> amdgpu:      MAPPING_ERROR: 0x0
>>> amdgpu:      RW: 0x1
>>> amdgpu: [gfxhub] page fault (src_id:0 ring:40 vmid:10 pasid:32771)
>>> amdgpu:  in process  pid 0 thread  pid 0)
>>> amdgpu:   in page starting at address 0x0000800105404000 from client 10
>>>
>>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 13 +++++++++++++
>>>   1 file changed, 13 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> index f1d4e29772a5..4c3edd988a05 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> @@ -541,10 +541,23 @@ amdgpu_userqueue_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
>>>   static void amdgpu_userqueue_resume_worker(struct work_struct *work)
>>>   {
>>>       struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, resume_work.work);
>>> +    struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>>> +    struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
>>> +    struct amdgpu_eviction_fence *ev_fence;
>>>       int ret;
>>>         mutex_lock(&uq_mgr->userq_mutex);
>>>   +    spin_lock(&evf_mgr->ev_fence_lock);
>>> +    ev_fence = evf_mgr->ev_fence;
>>> +    spin_unlock(&evf_mgr->ev_fence_lock);
>>> +    if (ev_fence && dma_fence_is_signaled(&ev_fence->base)) {
>>> +    /* Wait for the prior vm updates to complete before proceeding with resume */
>>> +        dma_resv_wait_timeout(fpriv->vm.root.bo->tbo.base.resv,
>>> +                      DMA_RESV_USAGE_BOOKKEEP,
>>> +                      true,
>>> +                      msecs_to_jiffies(AMDGPU_FENCE_JIFFIES_TIMEOUT));
>>> +    }
>> In general I agree that we need for PTE updates before resuming userqueues, but this here is just nonsense.
>
> Okay, but the reason for adding this is, I was able to verify that corresponding vm sdma job fence is signaled few microseconds after the resume queue call in the timeline in tracing. I verified this by adding resume trace point after amdgpu_userqueue_validate_bos has completed (hoping this should do the waiting part), but observed that resume timestamp is before the sdma job fence signal timestamp.
> Whereas after adding the dma_resv_wait on root.bo, the resume happens after sdma job fence is signalled, and was also able to see that page faults stopped after adding this check. 

Good catch, but you seem to have a bunch of misunderstandings.

See the queues are suspended because some BOs are moved to a location where they shouldn't be (e.g. VRAM into GTT or even SYSTEM and GTT into SYSTEM, etc...).

The function amdgpu_userqueue_validate_bos() moves the BOs back so that they are accessible by the GPU again, updates the PTEs and then waits for the PTE updates to finish.

It is perfectly possible that there is a bug in amdgpu_userqueue_validate_bos() and we don't wait for the PTE updates to finish. You should probably double check that.

Alternatively it is possible that PTE are made while the queues are disabled, but we don't need to wait for those to finish before re-starting the queues since they should be explicitly waited for by userspace.

In the kernel we only need to wait for all implicit PTE updates triggered by kernel BO moves to finish.

Regards,
Christian.

> Regards, Sathish
>>
>>>       ret = amdgpu_userqueue_validate_bos(uq_mgr);
>> This call here is validating the BOs, updating the PTEs *and* making sure that we wait for this update to finish.
>>
>> Waiting before that just doesn't make any sense as far as I can see.
>>
>> Regards,
>> Christian.
>>
>>>       if (ret) {
>>>           DRM_ERROR("Failed to validate BOs to restore\n");
>

