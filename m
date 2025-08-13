Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFEFC87FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 18:24:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14CEB10E05D;
	Wed, 13 Aug 2025 18:24:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oY4Z+J8B";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B304310E05D
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 18:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tf4EVhT6Oshv2l3o3OXzGUTklNtvNvgqvuZSsf65ruzfvhnN4lmuwi5XoTwep3axSIldmnp5YL2tDCSfPPWz3rhUCBD6dk3JlQwwhmDoCVXWcXHRt17JnZxaXUOMVS7eoigvLEhZn65vqgmf9kZuUDygwjwftXRiF+ocVvM12Dao4yoxEGMB+eofdV/cQmP0QU2RP/naeul5DBpF85kT5JBrMXAGZhNBRQYDds30ECU36lvvtciqc4eiJzHELZWxojtblQEewDoqoh+7fLY4yLpbXgnkpP0ZD4aQ7pJAMVcPuqjxIyXlQo+8XBnhesAUhUyRchXquRNPajve4j67Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0t40TjoHQeCcVq9w7LmBelhX0QS909xRpQI5jxkhVEk=;
 b=U1u1EEGkKRYQfBpbCSRn3GZ49tML8mfpAl26M9vrDd6IfPRo3pmx6DLV5bsbUS5ftMGhwwe9Te+2LS1MJFhowz4hDabzRgXKc7cGXkAIWHPguZC1F/WLlIZsFuwr0t+8qOovm+z87X4SIJrFQy9VZo3YOCB30cl7IMfL0fUP0IUSN8ffCCkTJ8EkF91Zz3Pa1Kf8XhXQbjNgGZTIuVGC7BW76Cen8VtADpNNAAhxyeqUtnopKKRAV6PrPA/NC3+DKJ8dpdydo4Bzsv9NyJa0JlFPpjvhMg+uec22/M8rY5BKISroitBaNvdAu7PjpxvFc84oBCFSe+/FQDGS5ecE8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0t40TjoHQeCcVq9w7LmBelhX0QS909xRpQI5jxkhVEk=;
 b=oY4Z+J8BeU0QmUFxo0TIFtm6tigqN0wUSb1bpMNCwfuKIQguM/Gnt4WlPa4dXpf/ub4mZ5XE3Eb1Mzthd/8oeF7bAY4VlcaZG8NafTshRCcBcnZ7m965nFu2M1FUjBi8ZitsZ2VZOuuJXRgWfS4e6OcBqUaPpSNVd1mPBkGOnvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by SA1PR12MB8842.namprd12.prod.outlook.com (2603:10b6:806:378::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Wed, 13 Aug
 2025 18:23:55 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%4]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 18:23:55 +0000
Message-ID: <dc8beb3b-789c-03c1-1c37-50c998b7e44a@amd.com>
Date: Wed, 13 Aug 2025 23:53:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
Content-Language: en-US
To: "Wu, David" <davidwu2@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250813134504.2037516-1-alexander.deucher@amd.com>
 <ae769200-c37e-426b-b73a-ac9473cf66eb@amd.com>
 <CADnq5_MbT-4Q4HfQ15AWMNGu6hct2=Yu5K5+F6qMGWDC6H_ojg@mail.gmail.com>
 <faee7074-f3bd-4791-b3f0-fe409049de06@amd.com>
From: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
In-Reply-To: <faee7074-f3bd-4791-b3f0-fe409049de06@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0091.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:268::8) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|SA1PR12MB8842:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a4e7f3a-6e91-49cb-8452-08ddda96900e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1gyR3o2SWE5RHcrMkwvOFFMQ25MdnFZQjNGamR0L1c3ZDg0dFUvRlNGSkpN?=
 =?utf-8?B?czMyVUxqcUt3VTRHZHVPWnZQWmxXN200SU10T2djRlJ1Y0htd3hQOXR0UVZu?=
 =?utf-8?B?bWhoZFp4bHYwTS9rWjU1emdadlhDcDJiMGk4YWcwWTFnTmYwTE1SSi81T3M3?=
 =?utf-8?B?THA5K3JYQ1JmRjRCOVRCK2xCazZhMXRNQ01yakRWNGhzVldhUkpKdjdyUTE3?=
 =?utf-8?B?UkR2bDFCaUs1R2ZVTmllRy9NamtyY2lmUXg5ZC9IVmEzTDlqK3FnV0t3aG03?=
 =?utf-8?B?aGc4dHQ3ZkV2OGNzT0FVdVRRdEhla1llblFNWVNYblR2NWdIbWxIRzVMclNB?=
 =?utf-8?B?bVQwelByK2ZzTHkyRHdieVBBZ24vZ25mL1dRcTVtQ2lSeUJKYjE0L1BMQ3N5?=
 =?utf-8?B?Q3FqNVlnMEpRSlIwakdMdDNrUFE0VTQyenQ0ZEE3eWNZNkkxNWdja0hYbm5O?=
 =?utf-8?B?WUJxNUpLa1MzWjRnQkFJVGR3YmJLYUx0S1cra01wWDA1ZmZSVXpTbW9ORmZ4?=
 =?utf-8?B?TGFjVEY1YVgwU09ZTEhhbW9Jb2t2L1MzNWRHUzBWZVpUMkJTNmQzWGlHTFZI?=
 =?utf-8?B?ZURLaTVHRy9Zc1Z0K1U1Vk5UWjlTSkJWZlcyV05McnVNelJVWXZvdUpBQUVW?=
 =?utf-8?B?cnFXdXp1dkpPczc0Nzk5d2MwKzA5Q0daemQrdzRDTkQ0RnF0bkJLV0lDbjhD?=
 =?utf-8?B?WmxMbUVrV21IdXVJSGt5MG5FV0RHeEFmdTBNRVR0WlN6dmpXSlM4Q0VncjMx?=
 =?utf-8?B?NHRJN2Zqa2hhY3k5Q0VMclNGZjFiLzJJZ3g0dXZiK2l4aFN3enRLVUgySjF0?=
 =?utf-8?B?VktuZ3hwOEY3L0dYVFdScXZMTUp1a2dDL2tmaVFPNHlXUzZwa2VxY1JOZWl5?=
 =?utf-8?B?cmJzbFFDVU9RQnduRGhNWXlBaXdTcSthK3BtamZtLzgzaHhqMW1uMmtkNU4v?=
 =?utf-8?B?czdWZElUVWJ0bDYvYUo0WENnOU9icFBwWWJQNkV3ZDFSWStEYUgyMXlRdE5q?=
 =?utf-8?B?VHhhRk5ld1U3UjU3UHBUNk1XRFhNRG41V09GejdmaHlTZGVncmRsV0F3Z2Uv?=
 =?utf-8?B?b0MzY2c4MWZETy9LS1czaU5WY2RISFNPZXNIbzJuN1o3Ni9oZzJtSDRzYXJt?=
 =?utf-8?B?TXFxa0JRQjk1STNBbnpDS2dpWFUwbWk3OHNIdW9jem5rRm93NEEwaXJibXQr?=
 =?utf-8?B?dmlMMGNaaUNaamhaNGVXMU5FRWc5dCt3ejFvK3hnSlpBYW81cS80YXV5WWxJ?=
 =?utf-8?B?dDBPcW1tb0hNRnRkL2E4UERlbkhyRWxBYlRyRklJVGs0MVBBNnoxdVpvQUlu?=
 =?utf-8?B?SGRRUHpLM2dLV2xrc05aWnlRVFdGSFdKcFdKOFQ3YjQwOE5FenczdnY0b0J1?=
 =?utf-8?B?OFJHd1VzTGw0TkN5ZTdVcnZYOHB2aDRPUGdldlVpaEdFQUhORjNSeU1URm5a?=
 =?utf-8?B?dm5zMXdKeWt2RXpjV3I2aVFndGhOOFBITTVVU0hBSjBjNEdmV0ordWhIUDdv?=
 =?utf-8?B?REh3a3lDQ20vUWtYeENFTU5zb3lsR2lxWTRaa0g4SDNBd1JwN0N1Y3JUZmxs?=
 =?utf-8?B?d0VyaW1tNW1sNFZ3MVZEMUc4VDRoYjBQUThJK3hkZk4zVFdNYndMWXpId2RL?=
 =?utf-8?B?bUkvV3YwM0hZcjZMWnRYbW9aNDVZS21zTERTR0ovWXBGbXprbldaVExqWTNi?=
 =?utf-8?B?eDJXYVg4ejBSdEY3UTRoRmhPeGxFV05kZFByZGN5SnFGK2ZuNy9pelB2TnZP?=
 =?utf-8?B?d2laQmNGempyVnBsR1VDRzVmN1JYVHpNZkR1bmovVmdxbHUrVlVWVTFTcjNC?=
 =?utf-8?B?dWNsQ24xaWFrY3hKS2VwRWdWQlh6SkRDWEZlcHB1RkFMekVNTlliTDBuZjMz?=
 =?utf-8?B?Rm1MSzFpU3lXeFQ0UTRPb3QwMmdCS0Z1L0x3ZzJ4RHJ6YTh5dDNPRUVOd0Ry?=
 =?utf-8?Q?M99VYLduAIA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGp6VzFCZDhMRjVQaXVnZ2M3WXA0UHA3SStKY2hIUTFJbU1neDByOW5Pb044?=
 =?utf-8?B?bnc1OThXN3lyTHVrT3RUVWNXaElUN3NXa3o5UWJ2NHFPMk0xMDhBdk44azMy?=
 =?utf-8?B?QVFiUGdJTEtzbTR0VTNwcXBlakJVdVVtNENrSmtmTjFpT1BUajZLQ09PekFV?=
 =?utf-8?B?TUdNRjdXRUFWQldIbzJyR3hxcW9MQUpZZXcrdmNJTFB5RG5qY3NwZ3dPNllG?=
 =?utf-8?B?TTZyb1V0WHcxV2F5T3lvS1RDZ2diMEMrZFZPekJQZkRXemJiTUlqUFc5T1d1?=
 =?utf-8?B?RU5qT2ttN0txVUZUdFd3dDRwY1ZlUERCS09KZm1MTmR3UzNrYzhIdW1TNkhU?=
 =?utf-8?B?bHRPa1RwcUxnTFpLcHViNjFDSUd6SEc0bHJtT0cwcGIrZENsN054SGpFbURo?=
 =?utf-8?B?MWNDTzJ2Z2I2bGJRVk5qSk5LS2lWZERtOURESEk3b2tiZVcyRVI5bjNYWHh0?=
 =?utf-8?B?SHdLME5NODRwSTRTY0Ftak1ycGhENDdzRVlBQzh4aXBscHZkRnhtRnhxbmx5?=
 =?utf-8?B?NFIwdUo4cDZDaEt1VHFlWStBb1k0aUFWN29LUXZ1djczcW1ZQVUrbDNBUVJr?=
 =?utf-8?B?SDNURHZEY0NsWktxZVNQdHNlanNPLzJjTk4xaitybjFYeTIzSHVvWGUwSDFL?=
 =?utf-8?B?N2wxc0NBbkwvOExUUDdFMmc2N21OeGxpNU96K1loSCttbi9JNWdGelRwd3pu?=
 =?utf-8?B?bmlZSHJiNlFPWHFOdmEvUTc5N1NCemtTOEUrWHZGcUphTGlTTXcwMjNTWnpP?=
 =?utf-8?B?eTNrUXA4N1J1MWNMcmlQdUx3LzQra1BLcmdqZ3d1ajJoL0xzcFgxM3VMdU9O?=
 =?utf-8?B?bm1oWnA4bDJJeTNGblB4cG1YQlNsWnhzUHBuRzdVeENWSjFMVmtJZnRSNjhK?=
 =?utf-8?B?R0NSd0pkOVJVbzd4VW9qOXBBYkRyZzZIL2RBR1JRN0JaWVRIMW1XZ1VNMVFC?=
 =?utf-8?B?V1ZVN0pSb3V2ZkhJdFltTEdPYUtjVGNmcExZcTRzdlUyNkRPUy8vVnFwR29I?=
 =?utf-8?B?SVpjWVMrNHF0STJRSTIxY0ROYStrYWpTUWhLMEZrVUZlS1JjVFgrc0JtcjNs?=
 =?utf-8?B?WVpoMDFHWVVNNStFUWtnM3VMZ2hmbmhicDlkc3A0d3FJeElYUFRKN0Y3UFZi?=
 =?utf-8?B?ZXhuUGd1ZUhXcUtOdTc0MlVhcHFIWkZ5emJ3VktQTzgxUG1JWUdNclpVS0Nq?=
 =?utf-8?B?dTA3WTQxUm5oeWpHcU9pSzVHTkUzTmhqWTdBaXpiWmlweWw1V0FMWjQvelJ4?=
 =?utf-8?B?TmxHMFo3VlVNSDB0Tll4SzZjN1RWMEp6UXhtZjN5aXZQNVJCNjZZb2tHeEI0?=
 =?utf-8?B?ODF2OHhONzJJUHZnQVhrTFR3MUZtN1cva0RXSWtpaWxZcy9QeGoxMlFrdDRs?=
 =?utf-8?B?bkN1UVJ3V25QZWNNQWIvSVpURkIvMFhpNFVnLzZkYmpwN09GMTNQdnBrZCtq?=
 =?utf-8?B?ZCtPNXBZaVI4RXZzSDRvbFQvUUV6Qk41ZGdNU2hPeW9lSkRldzFYMkVLOTRk?=
 =?utf-8?B?TkpobCtJQzFadXd2VUJldlVDRGwxOW5mTVlIcGNqZmZ2ZTVUOGtmVzJLWjFp?=
 =?utf-8?B?WWJudXJOdkZ3bXpUbS9yUkhGQVJXZVQ4K1VQVTB6TTRjdTN3NVRDSUUwUjNY?=
 =?utf-8?B?NGJhNFNKM3Z4RlZnQ3UyUXJtdHp4ZjdUbkx6MWNQMkxMK2tWVzR3MkRpK0hH?=
 =?utf-8?B?WVllN01hL2hjT1Z3Zmg1TFRnZXY1ZCt5b0JiWXlNaStaa2VrakQ2SWZ0dW15?=
 =?utf-8?B?TTNuaHc5cWlFa09ZUkc5VTFrRE80MjA5SVNINU5Kb2NkL05OYmxSc1FoQng3?=
 =?utf-8?B?WHFhUXc3WHhpTVMyRW85cUtxZUoxUUhtTDNHS2h3dHZucW9FL2p5NDRjaXlV?=
 =?utf-8?B?MmFTQjhnSk8xbysyR1R3UStKdnJKQjYrbUhCeHJNWklKK3ZEVkNxNzZkKzRV?=
 =?utf-8?B?ZWNVZUpvaXA2VXA4cGZqQThlMzZiVytBS0FyQjEvbGprV2w1UEF1U3JFK1ZT?=
 =?utf-8?B?OHFNSWRsY25haWUwc2NYSGpnVmxOMHlEbmpnR2llcy8wTGlIaElMT1B1T2xq?=
 =?utf-8?B?MXpJUTB5ZWNUQmFJREVPRm1tL1pNZ3BlNVRvTEg5MTExNVZMYTNhNERFUGhl?=
 =?utf-8?Q?TnxFI2cp3ve2GNJ+Lx4ukN5A5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4e7f3a-6e91-49cb-8452-08ddda96900e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 18:23:55.6612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjXsawvNTbTAApismmknamVLr74R7FaOoF0jnmgxFI4xjovMpOT3qK0FFBMC2KlQL5SOIHu0z9iXsMuyAauSAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8842
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

Hi Alex, Hi David,

I see David's concern but his suggestion yet wont solve the problem, 
neither the current form , reason :-

The emitted fence count and total submission count are fast transients 
which frequently become 0 in between video decodes (between jobs) even 
with the atomics and locks there can be a switch of video power profile, 
in the current form of patch that window is minimized, but still can 
happen if stress tested. But power state of any instance becoming zero 
can be a sure shot indication of break in a video decode, the mistake in 
my patch was using per instance mutex, I should have used a common 
global mutex, then that covers the situation David is trying to bring out.

Using one global vcn.pg_lock for idle and begin_use and using flags to 
track power state could help us totally avoid this situation.

Regards,

Sathish

On 8/13/2025 11:46 PM, Wu, David wrote:
> On 8/13/2025 12:51 PM, Alex Deucher wrote:
>> On Wed, Aug 13, 2025 at 12:39 PM Wu, David <davidwu2@amd.com> wrote:
>>> Hi Alex,
>>>
>>> The addition of  total_submission_cnt should work - in that
>>> it is unlikely to have a context switch right after the begin_use().
>>> The suggestion of moving it inside the lock (which I prefer in case 
>>> someone
>>> adds more before the lock and not reviewed thoroughly)
>>>    - up to you to decide.
>>>
>>> Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>>>
>>> Thanks,
>>> David
>>> On 8/13/2025 9:45 AM, Alex Deucher wrote:
>>>> If there are multiple instances of the VCN running,
>>>> we may end up switching the video profile while another
>>>> instance is active because we only take into account
>>>> the current instance's submissions.  Look at all
>>>> outstanding fences for the video profile.
>>>>
>>>> v2: drop early exit in begin_use()
>>>> v3: handle possible race between begin_use() work handler
>>>>
>>>> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile 
>>>> handling")
>>>> Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com> (v1)
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40 
>>>> ++++++++++++-------------
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
>>>>    2 files changed, 21 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>> index 9a76e11d1c184..593c1ddf8819b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>> @@ -415,19 +415,25 @@ static void 
>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>>        struct amdgpu_vcn_inst *vcn_inst =
>>>>                container_of(work, struct amdgpu_vcn_inst, 
>>>> idle_work.work);
>>>>        struct amdgpu_device *adev = vcn_inst->adev;
>>>> -     unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>> -     unsigned int i = vcn_inst->inst, j;
>>>> +     unsigned int total_fences = 0, 
>>>> fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>> +     unsigned int i, j;
>>>>        int r = 0;
>>>>
>>>> -     if (adev->vcn.harvest_config & (1 << i))
>>>> +     if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
>>>>                return;
>>>>
>>>> -     for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>>>> -             fence[i] += 
>>>> amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>>>> +     for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>> +             struct amdgpu_vcn_inst *v = &adev->vcn.inst[i];
>>>> +
>>>> +             for (j = 0; j < v->num_enc_rings; ++j)
>>>> +                     fence[i] += 
>>>> amdgpu_fence_count_emitted(&v->ring_enc[j]);
>>>> +             fence[i] += amdgpu_fence_count_emitted(&v->ring_dec);
>>>> +             total_fences += fence[i];
>>>> +     }
>>>>
>>>>        /* Only set DPG pause for VCN3 or below, VCN4 and above will 
>>>> be handled by FW */
>>>>        if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
>>>> -         !adev->vcn.inst[i].using_unified_queue) {
>>>> +         !vcn_inst->using_unified_queue) {
>>>>                struct dpg_pause_state new_state;
>>>>
>>>>                if (fence[i] ||
>>>> @@ -436,18 +442,18 @@ static void 
>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>>                else
>>>>                        new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>>>>
>>>> -             adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
>>>> +             vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
>>>>        }
>>>>
>>>> -     fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
>>>> -     fences += fence[i];
>>>> -
>>>> -     if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>> +     if (!fence[vcn_inst->inst] && 
>>>> !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>> +             /* This is specific to this instance */
>>>>                mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>                vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>>>>                mutex_unlock(&vcn_inst->vcn_pg_lock);
>>>> mutex_lock(&adev->vcn.workload_profile_mutex);
>>>> -             if (adev->vcn.workload_profile_active) {
>>>> +             /* This is global and depends on all VCN instances */
>>>> +             if (adev->vcn.workload_profile_active && 
>>>> !total_fences &&
>>>> + !atomic_read(&adev->vcn.total_submission_cnt)) {
>>>>                        r = amdgpu_dpm_switch_power_profile(adev, 
>>>> PP_SMC_POWER_PROFILE_VIDEO,
>>>> false);
>>>>                        if (r)
>>>> @@ -467,16 +473,10 @@ void amdgpu_vcn_ring_begin_use(struct 
>>>> amdgpu_ring *ring)
>>>>        int r = 0;
>>>>
>>>>        atomic_inc(&vcn_inst->total_submission_cnt);
>>>> +     atomic_inc(&adev->vcn.total_submission_cnt);
>>> move this addition down inside the mutex lock
>>>> cancel_delayed_work_sync(&vcn_inst->idle_work);
>>>>
>>>> -     /* We can safely return early here because we've cancelled the
>>>> -      * the delayed work so there is no one else to set it to false
>>>> -      * and we don't care if someone else sets it to true.
>>>> -      */
>>>> -     if (adev->vcn.workload_profile_active)
>>>> -             goto pg_lock;
>>>> -
>>>>        mutex_lock(&adev->vcn.workload_profile_mutex);
>>> move to here:
>>> atomic_inc(&adev->vcn.total_submission_cnt);
>>> I think this should work for multiple instances.
>> Why does this need to be protected by the mutex?
> hmm.. OK - no need and it is actually better before the mutex.
> David
>> Alex
>>
>>> David
>>>>        if (!adev->vcn.workload_profile_active) {
>>>>                r = amdgpu_dpm_switch_power_profile(adev, 
>>>> PP_SMC_POWER_PROFILE_VIDEO,
>>>> @@ -487,7 +487,6 @@ void amdgpu_vcn_ring_begin_use(struct 
>>>> amdgpu_ring *ring)
>>>>        }
>>>> mutex_unlock(&adev->vcn.workload_profile_mutex);
>>>>
>>>> -pg_lock:
>>>>        mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>        vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>>>>
>>>> @@ -528,6 +527,7 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring 
>>>> *ring)
>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
>>>>
>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cnt);
>>>> + atomic_dec(&ring->adev->vcn.total_submission_cnt);
>>>>
>>>> schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
>>>>                              VCN_IDLE_TIMEOUT);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>> index b3fb1d0e43fc9..febc3ce8641ff 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>> @@ -352,6 +352,7 @@ struct amdgpu_vcn {
>>>>
>>>>        uint16_t inst_mask;
>>>>        uint8_t num_inst_per_aid;
>>>> +     atomic_t                total_submission_cnt;
>>>>
>>>>        /* IP reg dump */
>>>>        uint32_t                *ip_dump;
>
