Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59988D3E793
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 05:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5D6110E70D;
	Thu, 11 Dec 2025 05:45:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xvNu8Zfx";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 518A710E70D
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 05:45:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e83W8DB7QAuwxhuwOxUsXeoydZGhjU/oBd9JfV4wlntUK37VbxPgk2MndzrceA/7+tCe5M3jom6h7DzcF7TstTOi5jwK84Hm6CAs8o2B/QYxuDoZUlG+xGHgdWJxGq6xbg3+I1aWJ9M4xiThplvPQeWsRLHTtH2j/BKZzz9HHNAh+xniRpNIdXN1jCTeHgi2ZiPKsDmNCHxnh10AK9RGn9MFu4prxo+GCCtFahcoSjfjilAe+gH/yMsIDT9y7r9zLLiOsNNM8J+gMIWkFQILGoyD5zYd7PIEVKt2DrA2/zlY7dFeTQHYj/TkQvo9qTGvmMpteu0Mpzm1WkaKym5a7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gb9xFHN3ve3ErO9noifQwQHs3KrL631z84m9peMhQPs=;
 b=B8TgQnegHMVIIOgHFPd0M/0IwHkIph0XSYSkFjTYykRF6zoQq9o6rx4clHNgH+YLUV7fwi23XI5rSaXUjl9EsTXMweLXGr6//+V0EMHBor3DtrO5x/00fh+rL9wJqCzmLEWQnMVusOQxbT7Oe0LzTa0mWSFLFCqcjTpZxM/3VM/86gIJBGqgMUlD8/T3tQ3Hesn7Sw7Ps8YsN4SWZc06BdBgJcbEAjoAWZx0FJRq8iKwlK39I635DW5SyUGLPBJojhsqLyQFCf6tUNTFWRnvW9xh2uCXze+nyvulDq+surXw/n6QEyrxQ3bZEFSkdEZspfqMfyrglBZP5q46eXrqHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gb9xFHN3ve3ErO9noifQwQHs3KrL631z84m9peMhQPs=;
 b=xvNu8ZfxC3GUwd2yzT6ylzYoNvyJN30jxxQKLiUWwXcosxfZ3CXM09PFxtMsh2jUIk//4I9kXwbr3TSvTmWIJORw67Xv/o+1z4SKygNvGv9HSFkTw03dxJQJuX0r0nfBCINEdXKQNZMaW0qE87AsMfzhaQDvlySr+BbeeyCetDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ0PR12MB6807.namprd12.prod.outlook.com (2603:10b6:a03:479::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Thu, 11 Dec
 2025 05:45:01 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 05:45:01 +0000
Message-ID: <14ea9e1c-0deb-4d2b-8bea-ef95300b753c@amd.com>
Date: Thu, 11 Dec 2025 11:14:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] drm/amdgpu: fix a job->pasid access race in gpu
 recovery
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 Matthew Brost <matthew.brost@intel.com>
References: <20251210202347.63243-1-alexander.deucher@amd.com>
 <adf41aa5-3172-4e9e-9bfc-c8b853b7c0c0@amd.com>
 <IA0PR12MB820858B3F15710B5E2C6255B90A1A@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <IA0PR12MB820858B3F15710B5E2C6255B90A1A@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0097.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:278::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ0PR12MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e69c5f-c91d-4dcc-5867-08de38786cf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVVsQ2RldkliSmtJU3M2ZkU0ZXFhc0hTWWREVGhqVFlwQkV1akp6clp5bmxU?=
 =?utf-8?B?eU1IbVNFaXRiM3IyY0dZVzZCREw2RUxBU3VrOTBRKzRTTUlPMi9uU3g2RjNa?=
 =?utf-8?B?ZE5iSE4yWmwvUWQrbURxK0FXL3M2MWFTLzlwNDZYN0RXZUdVekVUa0pidG9T?=
 =?utf-8?B?QnVDVUdmRWc3dktjVHM2OUt1djlVL0xKYXZoeVNtTU1sSmdvajNjRkM0ZmV6?=
 =?utf-8?B?SHc1bUZJS2RqSkFRaXdPbEh2N1Nnd2NTTG1YbVUrWERiUnNjQ0p3VW40dTVx?=
 =?utf-8?B?OGxLWXVlaXNFQUw2WG9pNlNsMk13WW1KYUh2eGZJSHdJanR1TmZLbzgzVE1Y?=
 =?utf-8?B?Ylp0TzZBdXVOWk16ZElweHphU201cGVPSGIxbW9Sd08wY1JwNFNTSS8vVEZz?=
 =?utf-8?B?ZnFrQkVneDlRYkJJTjhsU2RWV2ZSYzQzRmNPQUJDM05abzg3a0tDRTRBZjBO?=
 =?utf-8?B?Q3V2NXdPQlNSc2NpTEVKK1FZeDMwdk51WUQ4UStxaE9tVEpWOTJ5MVZWNVRL?=
 =?utf-8?B?TDcyZGUzQ0J3ZmpMUHphbms0U3dISTN1ZS95S0VSTHBQSGs5ZzN3bWpTQXdm?=
 =?utf-8?B?OGwrdGtoUklDYXRsdEN6VWlvWTJKSGl4ZXpScDBlRjBjRGl5bFdGTEtNV092?=
 =?utf-8?B?V01yajF1UW9CZVE0VDF1WmdqRjQwU2pNSncrNTVrTzg5NCtWYUV6QWVEV0ND?=
 =?utf-8?B?N0lZdGJ0Q25LK0Z2dVlWVnpjRlZKNndnVUg0aXMvRzRUcFZwWlRxWUJySCtj?=
 =?utf-8?B?MmtDNVRXRXZVMThHOFlMWlpvVENxK1RjenVQSXJYeTNMTzN1dGZ3SjM0U2xt?=
 =?utf-8?B?U0dmekVTNDBJaitHZjJabnd0OHRhZHdsU1BSeS9pN3hnZ2JNdHNXdCs1eDAr?=
 =?utf-8?B?dklyN0lFbysrRHRtNk96VnBQMnJmV2duNWRJc2d4ams1NURRZ0lFVDhlNTlm?=
 =?utf-8?B?S0J0di9rakRxWTBtd2pYeGt4bEIxVXhaVHdWRVdtYm9MdUR5c3ZoYWJkSkpT?=
 =?utf-8?B?WFl3Nk9VNC9PRDEveENtWWJMY3Z2Vi9scHV1MDRzRGlyL1FiMEZJVWpYd1BM?=
 =?utf-8?B?cmlNWXI5NW01bWplbmpFSy84TiswUlRncFVBRmZvejRjbWd3YjVFWTk0YStV?=
 =?utf-8?B?UjZrcncycDJlZmlhVUs1M2FEaTZxWkZ4YWJYajF6eGxqNFpid0lJZUhKbEdl?=
 =?utf-8?B?YytnSlE4a2FSTGhnY0VkNUhycUhhZjU2dXdtNURWWC9ONU5xbmpOL3FqRnQ2?=
 =?utf-8?B?RFRmMUUwNVBFSHBkcG5FKytiQzNOUGZJMTNPeDhneDUrMzhTT1lkRnlQOW1S?=
 =?utf-8?B?Mzd3UG4vWjBtVFVERy9OTzJkN1k3VkFxN3ExRmROSjVaNUxDQlRmTE5FT1Jz?=
 =?utf-8?B?ejVrNXl6dmh5ZGdHb0g5ZWJZQ2Z3aEpOV3ZMalo4ZE9tNm15ZGxETEpHMG0w?=
 =?utf-8?B?OTdpMEl2WWZlN1JCTEJsOXNySmNaZUtrQkVoTjdySHRkS0JkV1dVUWpSRElN?=
 =?utf-8?B?Yi9DR1hzc2thbkJ1TThhMDRCeUJ2cHNzdWxxNzJwL21HNzRwbEJpRktLNHVq?=
 =?utf-8?B?MVB2bjRLdFBNQXpTUGEzdXZ1MVQxY3BFUU56OUV4cVF0R2Y2WUVwNlhvOFA4?=
 =?utf-8?B?U0FOMm10NXgvZkwySEh3Sm53NTRvVWVEbVhyalRsR0hYcE1xaXErWDMyM2t3?=
 =?utf-8?B?cGNBWTdKSDhqWG9ieEJLYXVqbmhPdWVtOW9SQk5SQ05xOWF4TWQ4YWNQVzVx?=
 =?utf-8?B?TWJzbEpQSVY5YnBzLzZVMXdzVkgxVjlVM3RERUNZcHQ5dDVzcTdEcUw2NUMr?=
 =?utf-8?B?UnBZZml1MVhnRnVJMldZS2FrOElHUk9CQlRDRUdXSm5Db0dtUThKZSsvTGtH?=
 =?utf-8?B?UGtRYnRVVXVhdXgzM0pPRGhzKytHSExlRTF6NjF6VlF0MFlmWEFVa1llN2Zv?=
 =?utf-8?B?eEp6WHp5NzBoRnFuR3NjNXM4djNHSlZrcWhzUVVoa3JpTWorTkp1bjZmZVh3?=
 =?utf-8?B?bjYzUC9WT213PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVV5L2xoOUZaNWwwNnNKQlVxL3hmWkg2cndBNGRpWXdHeWFaNFJWRGdCOW9K?=
 =?utf-8?B?VFRpSStrdmRvbDd6VXBralV0SW41YnRIN1c1MWRpQ200Vi9zS1MvYjFIK0Z1?=
 =?utf-8?B?Q1VXaXZKVEFjTVJGcXhtQzZBUGdVc3VsaHF3bFgzY1pGYUxYQkMxZ0laeWhS?=
 =?utf-8?B?QXVnMmhnK0owWXhnUjBVZCtSZENhc210cWVjTUIybks3SjVmbWdnd0hhMG0w?=
 =?utf-8?B?bnhmb0UvNC8xb1FkYzBxQ09ZK0wvOGIzUEpwcSs1Q1FndEVpMWZCczd3TWxD?=
 =?utf-8?B?TSt4cTN0eWVqczdiL0Juc09jbjRlSXZZVFRFQTQ3WENFdm1WeDkybk0za0NQ?=
 =?utf-8?B?YWU4Unhtd2dMYW1WT2Q3bTJsdnF6UkJzUThZdUFpN2FHMWJPNUNFaEJtQ1p3?=
 =?utf-8?B?bldQMXlzdURqYThCSXZxbE9nMVErbXNuZFFnQjRDNTVGNTcvU0FaeDRhOHZK?=
 =?utf-8?B?dkp5c3haLzNGY3pKcHRIbWZxcFdqdEN5Z0ZvV25QczErUDB1aFF6OGV0MG52?=
 =?utf-8?B?R3kxUVI5U1J6clhsUTllSEQxdmVvYktyaEcrSUl4enFYYURRK21HTnNZSDla?=
 =?utf-8?B?aDd6UG0yZEZDa0xzSUVHbE4vQjJCM2JwNEZvMmtjRmFLajB5dmNGZnRiK1Yy?=
 =?utf-8?B?TnZ3YjNVK0VVVDdOcGMyQ1VWRURPcCs5K0ltYnBzdkJOZXZjY0ozVFo5dnFn?=
 =?utf-8?B?cE91ZWszRWZweGtHVHd1N056QWF0R1N5MmpESElpcGEyK2V6MlFGaDRiMFZx?=
 =?utf-8?B?bnFreDlFdkpiZ1hhRmI5d00xbi82TFBHS2RHWlcyVGZQaDRMWVdIVG5Ed3pZ?=
 =?utf-8?B?WGwyNU9ZRmNYVUNzRmJKSEFiUmpWeFdZQVZaRTlWVGJ3dkV4UFJpUk80VlQv?=
 =?utf-8?B?Q0EybUV1YlR0WlZjREYyUDVvbmNGVml0NXFIcXpiM3kvS0ZIY3hnWEtvTGJp?=
 =?utf-8?B?M0lYM0l0R3lGeTg5a1FpSXc2ZHdTRGNyb1RQMTVlY0kyZDRKaGtsMnQ1Zlds?=
 =?utf-8?B?bUdvVFZvZWFucCtPL3IyY2dLdHRML2QrejFtZ0FFeFdLSU5oRlJtTXJPRGVV?=
 =?utf-8?B?bzNPNE9GNXgrU1hQM3QxK0p3blJndlVZUzQ1ckhla25SOHZXV3RYSmR4MzVs?=
 =?utf-8?B?ektJRUxDTks0VmtCaCtjekgwMXZJeENlK0QycUNqeFZzWFdRblVjaDRNcll0?=
 =?utf-8?B?RGZCb3A1UXc0RkZwVGhMZlp2c1JGcnUwRkJabVhiUmVHK0xyMXE0Q2dmSTUx?=
 =?utf-8?B?OHplUlRuS3FBVk1laTYvRlpWcWdqb3o5UlFPakF4OUJnaWNIWjBxSzUwc3N0?=
 =?utf-8?B?K3RZWmoya1FSZytjWm1VQ2lvbjk4VUlFeWlqdEtkRFNITmIxcUZucUdQZUFk?=
 =?utf-8?B?Nk8xSUNXUU9vVzhZNjhsTlhFTmgwMGNsMGh6SWV0bmNqUWhFNGdlVjE2Qjdw?=
 =?utf-8?B?TVBmdlJzSG14eSt0QWpJL2pRWng4L25mQmxFRzNmZzRQZVlSc2lJdkJsVGxJ?=
 =?utf-8?B?OVRVcFZGOHYyRW56dWgzM05VdVNvMWpQOWlaVE02NTFHK0wxODM1QXhWZmRC?=
 =?utf-8?B?cUphOEVPbWM4Vmh6bTZteGg0RFVJd0tMOENFbE5IVFMxY3NkelpVZHp3MHBk?=
 =?utf-8?B?TmVLdHhGN2JUTjRIaHpmRTRqR2J2TithOHY4bzBsVDVJbU9QeW1tZDAycHFD?=
 =?utf-8?B?QlEvb3A2Y1dpR1dRNEJibytoZ2F5dGwxZDk1OVZEdm4xelVoRFhzQlM3ZHFR?=
 =?utf-8?B?ZFVCSVUra2NwbFpxNjlWMmFzUzFYcXo5RWZBSW5SNy9UMHMwamIxMXN2aVpt?=
 =?utf-8?B?WkdCdVBYaDM3T3hJck8yak0vMjFtSk5mOEg5YWJ0dC9nRjlRU0I2VkVYbnBV?=
 =?utf-8?B?blhFUk9RSFYyQy91NjI2Y2FMRHFpY0pHNzJZTjVOZUxnaksrZVNLNU4zaXQx?=
 =?utf-8?B?WkdlVXhXSEpXOWd3OUZleXd5Z3J6Rlp4Zm1sK3VNZ29INW1BZ1k5YmJ0MGRp?=
 =?utf-8?B?ekVrNG96Z0JqeUJ3djRFRjhWWEV5enZvc2VpRjlLRVN3bkU0YlI3U2RGMmF0?=
 =?utf-8?B?OXp3c3gwMldTd0tOQlU5SG95OUdTckhFUkNJM281OCsyeU1qRzFXMmxreUMv?=
 =?utf-8?Q?lqkDEmz0tqL24ySO/M6FLOvpK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e69c5f-c91d-4dcc-5867-08de38786cf8
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 05:45:01.3931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbU5XHO4mDw2tBC0RykyyjJfRQIkxH/Oo5nf7sjCBNRbYPZlE9pTd3SMPfZN+BzR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6807
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



On 12/11/2025 10:52 AM, SHANMUGAM, SRINIVASAN wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, December 11, 2025 10:34 AM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Cc: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Matthew Brost <matthew.brost@intel.com>
>> Subject: Re: [PATCH V2] drm/amdgpu: fix a job->pasid access race in gpu
>> recovery
>>
>>
>>
>> On 12/11/2025 1:53 AM, Alex Deucher wrote:
>>> Avoid a possible UAF in GPU recovery due to a race between the sched
>>> timeout callback and the tdr work queue.
>>>
>>> The gpu recovery function calls drm_sched_stop() and later
>>> drm_sched_start().  drm_sched_start() restarts the tdr queue which
>>> will eventually free the job.  If the tdr queue frees the job before
>>> time out callback completes, the job will be freed and we'll get a UAF
>>> when accessing the pasid.  Cache it early to avoid the UAF.
>>>
>>> Fixes: a72002cb181f ("drm/amdgpu: Make use of drm_wedge_task_info")
>>> Cc: SRINIVASAN.SHANMUGAM@amd.com
>>> Cc: vitaly.prosyak@amd.com
>>> Cc: christian.koenig@amd.com
>>> Suggested-by: Matthew Brost <matthew.brost@intel.com>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>
>>> v2: Check the pasid rather than job (Lijo)
>>>       Add fixes tag (Christian)
>>>
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++--
>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 8a851d7548c00..c6b1dd95c401d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -6634,6 +6634,8 @@ int amdgpu_device_gpu_recover(struct
>> amdgpu_device *adev,
>>>      struct amdgpu_hive_info *hive = NULL;
>>>      int r = 0;
>>>      bool need_emergency_restart = false;
>>> +   /* save the pasid here as the job may be freed before the end of the reset */
>>> +   int pasid = job ? job->pasid : -EINVAL;
>>>
>>>      /*
>>>       * If it reaches here because of hang/timeout and a RAS error is @@
>>> -6734,8 +6736,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device
>> *adev,
>>>      if (!r) {
>>>              struct amdgpu_task_info *ti = NULL;
>>>
>>> -           if (job)
>>> -                   ti = amdgpu_vm_get_task_info_pasid(adev, job->pasid);
>>> +           /*
>>> +            * The job may already be freed at this point via the sched tdr
>> workqueue so
>>> +            * use the cached pasid.
>>> +            */
>>
>> amdgpu_device_gpu_recover() is run in tdr workqueue.
>>
>> Now if this is the case, someone has to explain the logic  -
>>
>> Timeout is triggered here -
>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/scheduler/sched_main
>> .c#L559
>>
>> This calls amdgpu_job_timedout() -> amdgpu_device_gpu_recover()
>>
>> After that, there is this access to the job -
>>
>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/scheduler/sched_main
>> .c#L566
>>
>> At least, in some condition, job is not expected to be freed. Then I'm not sure if this
>> is the right fix.
> 
> What is that "someone", "some condition" you feel like? Its better to bring proper justification, and take up this as separate refactoring task
> 

Basically, if scheduler code itself is not expecting job to be not freed 
after timedout callback, then why callback handler needs to assume the same?

Now if callback handler does something else which in turn frees the job, 
the fix needs to be there instead of having this kind of fix.

Thanks,
Lijo


> Best,
> Srini

