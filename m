Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D58EC021A4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 07:37:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D02D710E3A4;
	Thu, 13 Feb 2025 07:37:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NFt/Tea5";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 366D810E3A4
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 07:37:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWtATLIHq8ZzYqqDpjzXRdF3jwF9I0ZY0DWrsNHeZfvEk8y1sipC3/1PSNzRYBpoK3MITpbCfX1j8MSb4XJJyWrGU8UHpMiAf7QYuJwYzkK2ajw0Q8/bJVfLIif1aG/E51dJMvQhkd+gIkdZ3H8IBDj6QyKA6L1ef3AukK/FuogJK+rCzTtvVJ+xVo4EVJWveJiqbnFWE8sT3BjKc9XD4x1TANBk1+diR9KkWPC5j3///ggFsa3MBFLK+1cEDX3AYLxscyF8qxCrTHdXD5BiLtWjTw0d61M+9rid+xFiCuJRVQPbvBjL3amFNLWBcHz1mnAdtSGOeslEuwafg1uRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IhpH28wPWUY3ox3lYLBIO6kkq7iJJJ/922kYHvqIyM=;
 b=IMUkKinPBXdH+oOfBvGIeiULrhbKDdQy6TMaKA1ZN4/ISNX0QcAK/looRWekyXqMarf50BN4OGuGe+bLMZ45qnU2XEt8ZsN4atWowndu9lfplOik2auR0XWxSvcLNfBX9Js61c0mernA+ZCl+2rjWqeeK5l7cyB96Kq76M+KKZJHpUux8vZJtKwAqdj/exRmyaArzpLrrU9KgVfW8oC7mK95MyTZ41FAZoHsGxnIkuJQNKrVtY9FHZ/LBmswy0uMRH/QccTwSvFbtLMplt+f0lfCVVRcwUQsQu6JvXpMGojIhuCKxksT/qgEAZ09QEnqEYZGk6tVUD391HoGW7S4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IhpH28wPWUY3ox3lYLBIO6kkq7iJJJ/922kYHvqIyM=;
 b=NFt/Tea5YjsR56G6hM9YN+lzfgUN/XDGKjCbrIAx4yEL6Pz0ItWRU3IVzijFW8tVLGkOkInDgfdF8tAd9FBdWJqIbzkHpi2vM178BeLATkCwzGMW4F9tsFRxMHN5HtJt+2s7+MfGKtJw13VY5clp+BW9n3dvkzv24wxuG7Jrja0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by SA1PR12MB6725.namprd12.prod.outlook.com (2603:10b6:806:254::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 07:37:35 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%3]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 07:37:35 +0000
Message-ID: <4c2483df-ae3a-4380-a01a-de11edb36e09@amd.com>
Date: Thu, 13 Feb 2025 13:07:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] drm/amdgpu: Per-instance init func for JPEG4_0_3
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>, Koenig Christian <Christian.Koenig@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>
References: <20250213025408.2402828-1-sathishkumar.sundararaju@amd.com>
 <20250213025408.2402828-2-sathishkumar.sundararaju@amd.com>
 <a7f7fcda-ae6a-4506-a7a2-4e3eea5316e4@amd.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <a7f7fcda-ae6a-4506-a7a2-4e3eea5316e4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0169.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::24) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|SA1PR12MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e456a32-63d6-4b62-22a0-08dd4c014840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1d1OTNiQmpRUklxaFpiREhxZmE4OTV6RWY0OUk4WHczRG1Ka2VCZ3dGVnIv?=
 =?utf-8?B?VVBZdHNreG0rdzZoYTVnMUU1clQ1Sjh2dTB0dDZmNW9uMG14NWJHSWVTSjF6?=
 =?utf-8?B?RnpIeWkvVWZpdGozQXUrZCsvemh1aEpvMXN4cDQrVjFsNWoxbEY5aXFWMFVI?=
 =?utf-8?B?K3MxTWMrRkp1Z1BHYkt6dHdLZSs2S2NQZWk1UU1pb1V0YVJCRDBrb280Sk8v?=
 =?utf-8?B?OXZqNmxjL3ZSeldxY0d6aXVrTk5CSm50SElzczhVOHA2cFhmUlUyck5NTVVI?=
 =?utf-8?B?ZEZMczVjRHR3N3hvaHp6MTloS3VxWVhBS3Q0ZDJXVCtqdTl3Tk5lUlAvT3Bw?=
 =?utf-8?B?TlNmVGJUNkpFbHhtT3Fvb3JvVURaVnhZTTRFeWFkQ0VGSklUMDhMOTNQelBR?=
 =?utf-8?B?ZXhsNWhhcTQyZVF0V3BNZ0dPR00vUHNOZzU1em4xZUlLYlBGcjUwVFFrNTg1?=
 =?utf-8?B?WDRrZjlDb3dTdmI3V2FuYWZ3VUwvdlB6Z2VhWkU4akplcm1WTGIrNnZZL1U2?=
 =?utf-8?B?VUdwMkFTcDZjV3JodmNTWGFQUmxYeXE0amVuUzdBZjc5bkN5d2tiNE8zNHM1?=
 =?utf-8?B?WnZPWVZ2WDZSbUFZeUZoNzdySFp6UWNrUVhEb0JtZlB0c0hGWVV6SDBNSjZR?=
 =?utf-8?B?N1hWK3ZMNlpTZWxsakdKVTFoQjdQVWxLaGQ3V2dTbGR6R2ZYa0RrWlZEK29z?=
 =?utf-8?B?S0ZzbkRZNlVrd0VOODk3b1pTMWFyTTRuRGlSVUY3cWpPcEw4NlJTRXhFWFdK?=
 =?utf-8?B?RFpLQ2JrelEyNFZuVkxPRDV0NTNMcStxRk5sclR4V2JTTmFDbVZEN2xFL1FD?=
 =?utf-8?B?aDdOSFpISmNWMGZjdldDQWNDYlJEaXBLVENWQUMzcGZid2lOQ0tjVy9lQ3Bw?=
 =?utf-8?B?Wi8waHE3ZW80R3Q5Y2VRNXI0Yko3c1lJa1JXdnlwTEdwQVpQTkpuTDRvanRC?=
 =?utf-8?B?NkpXd1VCQVNZeW44Ty9IUkNmcExQSkhXM3JGdVRiNU5DNkFJZWVYekU1RVRY?=
 =?utf-8?B?aVE0ejloSWNUaWxSMEQ3c0RwbUZkQUpEZW0wczJRYlVzaUJXL3dYNUZDWkNu?=
 =?utf-8?B?am05RTgrOWtteGE2NFNmcGd5cFQ3N1VkdTlKTk1NWHFwYXY5d0lBOVRldWs0?=
 =?utf-8?B?VEQxNHY2UkFMOXVEYVNnVG9ESDVCMG5HZDdkUUIwbVZPZHBmY1YwRlQ4dWlQ?=
 =?utf-8?B?OWFUQ0x1eHVwcXBGcXlreW01eXBuQVZMdzZrS1VoWkZ1UUN4Y3BZZnRaTFF5?=
 =?utf-8?B?dGx2RFZaREVhUnFIWDBNV21rRmFsV2h4RUlBMnh4a3JmVnFzZmJrck9lK05L?=
 =?utf-8?B?SEgvbjl6bUZzU3N6SEJqZTJjaVlLTWs3N3VXTUVZeWI3L1lZUjNwWGI1TEdS?=
 =?utf-8?B?MTlHM0R1YkxzaWgzRFg2QzBvQ2l6UkRqQUMySEJhYTY3dFdXY1ZDRDN3NUVP?=
 =?utf-8?B?Mm9TbUFlZGMwMG9sUUpSUUk1UVQ4ZFpwblJVOUhXMGUzdmtCN1IraWVpQVB6?=
 =?utf-8?B?R0xiVGhxU0ZFcStldm9aS2pld0FHazhIY0JJL1MybDFMRW9qUWxLZ3Vjd2Nr?=
 =?utf-8?B?RmtzK1pEYlltWmpyNEZIMHpacUcwZmRXR0gvTkpqemtUUis2LzBDSHJtc0xl?=
 =?utf-8?B?NVlSYTNZNk9BcWtuK2Jadk1mSUxwQnZNNnV2Vk9kci8xSGZveWxBNjkvMG5a?=
 =?utf-8?B?ZXkwWjVtNlVtK0d1TlQrUVdMV251WEtvTDVMdFRTMUpyQ2FudE40MGMxSll6?=
 =?utf-8?B?S0VwdkpWdWVRSjFka1VOeTZCRXJLUytnSGdzTGpoaEt0SEVyNFEvVXhJLytm?=
 =?utf-8?B?ZTNBZ3JXN09menArVDhjZ2hWSzNDdDN4L2t3ZUF3VExHdVZKVjh2Y3I2bUZs?=
 =?utf-8?Q?PnMdlh2JoMCyk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d256dVF3OXhmSE5ETmFJeU5wZXB6dmM2YzYvZ3EwMTN2YWxCZGQ1ekJiNG54?=
 =?utf-8?B?dUovdlI1NjZJVndzZXVUVEc1VHEzUkJ2NlY0RlNjdC9JVWJwby9DZjgwQnBv?=
 =?utf-8?B?RU9VYnFxMU5jMWVoMWgxTWVWRDdmdW5pZ0pUQWRnZmNhaFpkSm4vR0MySTJD?=
 =?utf-8?B?ZXV0aDJscEFGUjI5QW4rU2EyZDVnT0NMZ1NCY3c5Y3Arblp2NDFNZzJLL3Y5?=
 =?utf-8?B?b2puZUhNbE5CL3ErWFh4NURuUzlPWExNMW1CUzlORS9qY00ydHczZVhOc01K?=
 =?utf-8?B?TDk2VW4rNnFrc2NnSHhOT1BvNHk0N09BU2g2VU5jN25NSVl1bnB0WERETDB3?=
 =?utf-8?B?amVxaDYvTVcxbEw4L1BQdit5MjkxREZESlhwc1BUa0pjZnJIMjU5OFdvR24w?=
 =?utf-8?B?M2xJSGVVdGhrL3QrejVjYWpERmpkRGZUY1dJSjE2MTJxTml6clpzVkJJaWU4?=
 =?utf-8?B?L0tBbDVFOWRydnFBbjJZSjNtWHhoQ0ZHcC9nWUxFWm5ROEpyVUtUOGVpTTBK?=
 =?utf-8?B?QTZURDNSS1VYcGs3aWVQZUZidkpBaEhER0pBQm11bkF2N25aTkIzTDIvQisy?=
 =?utf-8?B?RHF5am9kbWJFaXRLRlpjNDZiS25VWjdseE4yMG4rc3k0enRXWXhKMUU5Ylgr?=
 =?utf-8?B?c3Q1S3FtN2dYRDJEZE1IUTFMQXR0NlRleGJqcE9kSWlkb0RZS0JzcHd6cFVj?=
 =?utf-8?B?WFJSOG9ub2ZjQ0p5bW43eElaai81anRCQ1dBaGQ5bk1yaFdta3kzRDNRc2JV?=
 =?utf-8?B?aE9CakQ0eGRuQkR6RmlRNEd2eFY5UlF2U2NuUTR6UkN4STZBRVhNZjcrYjh4?=
 =?utf-8?B?aGRGNHRLRVNPdEJlcHZDL2lSNSswcytSVGxGd1QycjFNbXhjY0hDVDBtNyt1?=
 =?utf-8?B?aDgwNzJrVVBrM1UwWFBKVDZXVXgxb1lFeHljUDhTdDRVY3BwQVRocFIydEhX?=
 =?utf-8?B?OFZSbDE4NnA5cHJ2bzUvS2ZuY1lxa0NldXZKQzMySlhjdy80YWNlWW5hQWxY?=
 =?utf-8?B?a0d0eDZWSjZiM2lSYjhrY1MwMlVST2R4Z0JZODZGTzcvcVlpWUJNK3BKZUpH?=
 =?utf-8?B?ZWZ4anRzODcvVmN0c0NPVVo4OVVoU3hsZkN3M2p4eVZmRHhENTNCTFZtNmdK?=
 =?utf-8?B?QnRRb210Qi9hZ2psdk15SFViNG92d3BrM0RQWFN0YzUzUzJFOUE5UHdndXEz?=
 =?utf-8?B?V3hQL3BmZzBDelRXTE1vcGViVi9pdkFqaUlabnlMSDB6RXVvOTR2MlRlRmRy?=
 =?utf-8?B?UzhhZGRjclZvK2hQY2RvRUNyQ2xOWkdPZ0xXNDcxck5MK211Y3hNcVE5aWsy?=
 =?utf-8?B?Y2NxLzIrTzZSVFYxbnZOak5VYzh4ZGhNMU1hWkROc1NhUWpCSG9jdXJiSkRC?=
 =?utf-8?B?NEF3VkhhRVowWHlraHlOSVpVeHNydWkraW9xelNJck1RWDdqazBaY0RqVVQx?=
 =?utf-8?B?Q1RDOTMwM3hVTWlFWnhKZm52eGJOcHJJVUFtTjl0ME45TFpCM1hDSjRtMHFz?=
 =?utf-8?B?S0NGYVVzWXBlTkZlQmhSQ3FzSU0ySVp1bllITmZOQkxQb0c1M0FlY1pOakJS?=
 =?utf-8?B?eXFxaUQ3YjdkbFZ0WlR6VTI1clVueUR1ajZkWjF6azhDQS9iUTNRWCsrR2lD?=
 =?utf-8?B?aGw2Rm1BZWdIZmVQQWVSUnByWlNYVkExTWdlSTljYTJMV2l1RkIyWllBL3ha?=
 =?utf-8?B?dXpWOTFlTXU1bnBkYWJETkFxdDdkZXlpKzBrb1VhREVlQnlFSGhTUjJSOWcr?=
 =?utf-8?B?RDlUZTZHaytYTS8yVGFnRko2RlVVTHVWUitoUGhpci90Nkw1YXFFQm5POTY2?=
 =?utf-8?B?RVNMTGxJeUFNOFVWNUlFNEtRNUF3T283Y2x1aHhJMjRvb24yWjFHMDBHK2Rn?=
 =?utf-8?B?T3FBRUpKNmN1KzkyeUJHdnBMZUllVjc4NkptT3JkREpxS3oralBrSmVsdEUv?=
 =?utf-8?B?M01tU2IvWEFrN29LZTl6dGZBWmIxc1pqdUhmZEk2ZG9Pa08yb0VERXVtNTdJ?=
 =?utf-8?B?MEZFdWI1N0tkaFNmbDhEaEJaRzZsS0txTDJaZ3F1aHZzVjU2cWhNNE5KdmZP?=
 =?utf-8?B?WW5mWlBrOW1ubzZvb0RFWTZoR0Y5NTQyNk9EeG1qeUdHZ3dVUnYxSCtzbEkx?=
 =?utf-8?Q?7RBTyr+osCvjMN5vbM31T0MI+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e456a32-63d6-4b62-22a0-08dd4c014840
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 07:37:35.0860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9LtNez7qte63g0aLAWODA+YTlnIBQJ8r6JziZfJs205m/pCuOvTPlUhNQ0VLmRxr3HEytJfmu3NN2Dtwe/MaiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6725
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


On 2/13/2025 12:16 PM, Lazar, Lijo wrote:
>
> On 2/13/2025 8:24 AM, Sathishkumar S wrote:
>> Add helper functions to handle per-instance and per-core
>> initialization and deinitialization in JPEG4_0_3.
>>
>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>> Acked-by: Christian König <christian.koenig@amd.com>
>> Reviewed-by: Leo Liu <leo.liu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 190 ++++++++++++-----------
>>   1 file changed, 98 insertions(+), 92 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> index 2a97302a22d3..e355febd9b82 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>> @@ -525,6 +525,75 @@ static void jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst
>>   	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CGC_GATE, data);
>>   }
>>   
>> +static void jpeg_v4_0_3_start_inst(struct amdgpu_device *adev, int inst)
>> +{
>> +	int jpeg_inst = GET_INST(JPEG, inst);
>> +
>> +	WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
>> +		     1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
>> +	SOC15_WAIT_ON_RREG(JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
>> +			   UVD_PGFSM_STATUS__UVDJ_PWR_ON <<
>> +			   UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
>> +			   UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
>> +
>> +	/* disable anti hang mechanism */
>> +	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JPEG_POWER_STATUS),
>> +		 0, ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>> +
>> +	/* JPEG disable CGC */
>> +	jpeg_v4_0_3_disable_clock_gating(adev, inst);
>> +
>> +	/* MJPEG global tiling registers */
>> +	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX8_ADDR_CONFIG,
>> +		     adev->gfx.config.gb_addr_config);
>> +	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX10_ADDR_CONFIG,
>> +		     adev->gfx.config.gb_addr_config);
>> +
>> +	/* enable JMI channel */
>> +	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL), 0,
>> +		 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>> +}
>> +
>> +static void jpeg_v4_0_3_start_jrbc(struct amdgpu_ring *ring)
>> +{
>> +	struct amdgpu_device *adev = ring->adev;
>> +	int jpeg_inst = GET_INST(JPEG, ring->me);
>> +	int reg_offset = jpeg_v4_0_3_core_reg_offset(ring->pipe);
>> +
>> +	/* enable System Interrupt for JRBC */
>> +	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regJPEG_SYS_INT_EN),
>> +		 JPEG_SYS_INT_EN__DJRBC0_MASK << ring->pipe,
>> +		 ~(JPEG_SYS_INT_EN__DJRBC0_MASK << ring->pipe));
>> +
>> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> +			    regUVD_JMI0_UVD_LMI_JRBC_RB_VMID,
>> +			    reg_offset, 0);
>> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> +			    regUVD_JRBC0_UVD_JRBC_RB_CNTL,
>> +			    reg_offset,
>> +			    (0x00000001L | 0x00000002L));
>> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> +			    regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
>> +			    reg_offset, lower_32_bits(ring->gpu_addr));
>> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> +			    regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
>> +			    reg_offset, upper_32_bits(ring->gpu_addr));
>> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> +			    regUVD_JRBC0_UVD_JRBC_RB_RPTR,
>> +			    reg_offset, 0);
>> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> +			    regUVD_JRBC0_UVD_JRBC_RB_WPTR,
>> +			    reg_offset, 0);
>> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> +			    regUVD_JRBC0_UVD_JRBC_RB_CNTL,
>> +			    reg_offset, 0x00000002L);
>> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> +			    regUVD_JRBC0_UVD_JRBC_RB_SIZE,
>> +			    reg_offset, ring->ring_size / 4);
>> +	ring->wptr = RREG32_SOC15_OFFSET(JPEG, jpeg_inst, regUVD_JRBC0_UVD_JRBC_RB_WPTR,
>> +					 reg_offset);
>> +}
>> +
>>   /**
>>    * jpeg_v4_0_3_start - start JPEG block
>>    *
>> @@ -535,84 +604,42 @@ static void jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst
>>   static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
>>   {
>>   	struct amdgpu_ring *ring;
>> -	int i, j, jpeg_inst;
>> +	int i, j;
>>   
>>   	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>> -		jpeg_inst = GET_INST(JPEG, i);
>> -
>> -		WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
>> -			     1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
>> -		SOC15_WAIT_ON_RREG(
>> -			JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
>> -			UVD_PGFSM_STATUS__UVDJ_PWR_ON
>> -				<< UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
>> -			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
>> -
>> -		/* disable anti hang mechanism */
>> -		WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>> -					  regUVD_JPEG_POWER_STATUS),
>> -			 0, ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>> -
>> -		/* JPEG disable CGC */
>> -		jpeg_v4_0_3_disable_clock_gating(adev, i);
>> -
>> -		/* MJPEG global tiling registers */
>> -		WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX8_ADDR_CONFIG,
>> -			     adev->gfx.config.gb_addr_config);
>> -		WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX10_ADDR_CONFIG,
>> -			     adev->gfx.config.gb_addr_config);
>> -
>> -		/* enable JMI channel */
>> -		WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL), 0,
>> -			 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>> -
>> +		jpeg_v4_0_3_start_inst(adev, i);
>>   		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
> It's better to move this inside the instance function. Instance takes
> care of all cores within the instance.
The separation in the helper functions was done to decouple core 
specific configs away from instance
specific configs to have the degree of freedom to control them 
independently without meddling with
each other, so having them done separately kind of helps to align better 
with that choice.

Regards,
Sathish
>
> Thanks,
> Lijo
>
>> -			int reg_offset = jpeg_v4_0_3_core_reg_offset(j);
>> -
>>   			ring = &adev->jpeg.inst[i].ring_dec[j];
>> -
>> -			/* enable System Interrupt for JRBC */
>> -			WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>> -						  regJPEG_SYS_INT_EN),
>> -				 JPEG_SYS_INT_EN__DJRBC0_MASK << j,
>> -				 ~(JPEG_SYS_INT_EN__DJRBC0_MASK << j));
>> -
>> -			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> -					    regUVD_JMI0_UVD_LMI_JRBC_RB_VMID,
>> -					    reg_offset, 0);
>> -			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> -					    regUVD_JRBC0_UVD_JRBC_RB_CNTL,
>> -					    reg_offset,
>> -					    (0x00000001L | 0x00000002L));
>> -			WREG32_SOC15_OFFSET(
>> -				JPEG, jpeg_inst,
>> -				regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
>> -				reg_offset, lower_32_bits(ring->gpu_addr));
>> -			WREG32_SOC15_OFFSET(
>> -				JPEG, jpeg_inst,
>> -				regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
>> -				reg_offset, upper_32_bits(ring->gpu_addr));
>> -			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> -					    regUVD_JRBC0_UVD_JRBC_RB_RPTR,
>> -					    reg_offset, 0);
>> -			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> -					    regUVD_JRBC0_UVD_JRBC_RB_WPTR,
>> -					    reg_offset, 0);
>> -			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> -					    regUVD_JRBC0_UVD_JRBC_RB_CNTL,
>> -					    reg_offset, 0x00000002L);
>> -			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>> -					    regUVD_JRBC0_UVD_JRBC_RB_SIZE,
>> -					    reg_offset, ring->ring_size / 4);
>> -			ring->wptr = RREG32_SOC15_OFFSET(
>> -				JPEG, jpeg_inst, regUVD_JRBC0_UVD_JRBC_RB_WPTR,
>> -				reg_offset);
>> +			jpeg_v4_0_3_start_jrbc(ring);
>>   		}
>>   	}
>>   
>>   	return 0;
>>   }
>>   
>> +static void jpeg_v4_0_3_stop_inst(struct amdgpu_device *adev, int inst)
>> +{
>> +	int jpeg_inst = GET_INST(JPEG, inst);
>> +	/* reset JMI */
>> +	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL),
>> +		 UVD_JMI_CNTL__SOFT_RESET_MASK,
>> +		 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>> +
>> +	jpeg_v4_0_3_enable_clock_gating(adev, inst);
>> +
>> +	/* enable anti hang mechanism */
>> +	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JPEG_POWER_STATUS),
>> +		 UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
>> +		 ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>> +
>> +	WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
>> +		     2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
>> +	SOC15_WAIT_ON_RREG
>> +		(JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
>> +		 UVD_PGFSM_STATUS__UVDJ_PWR_OFF << UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
>> +		 UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
>> +}
>> +
>>   /**
>>    * jpeg_v4_0_3_stop - stop JPEG block
>>    *
>> @@ -622,31 +649,10 @@ static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
>>    */
>>   static int jpeg_v4_0_3_stop(struct amdgpu_device *adev)
>>   {
>> -	int i, jpeg_inst;
>> +	int i;
>>   
>> -	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>> -		jpeg_inst = GET_INST(JPEG, i);
>> -		/* reset JMI */
>> -		WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL),
>> -			 UVD_JMI_CNTL__SOFT_RESET_MASK,
>> -			 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>> -
>> -		jpeg_v4_0_3_enable_clock_gating(adev, i);
>> -
>> -		/* enable anti hang mechanism */
>> -		WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>> -					  regUVD_JPEG_POWER_STATUS),
>> -			 UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
>> -			 ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>> -
>> -		WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
>> -			     2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
>> -		SOC15_WAIT_ON_RREG(
>> -			JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
>> -			UVD_PGFSM_STATUS__UVDJ_PWR_OFF
>> -				<< UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
>> -			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
>> -	}
>> +	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i)
>> +		jpeg_v4_0_3_stop_inst(adev, i);
>>   
>>   	return 0;
>>   }

