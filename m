Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A06C3ABC3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 May 2025 12:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 028E010E120;
	Fri,  9 May 2025 12:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NwT7qf7K";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EED210E120
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 May 2025 12:45:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7gtNGF0a5zAWs8RAoJRzgMQoJZCSb8nSpsQuJD65+/at+dQlqilDzb6SM1/+nj/p4BBP2XG8b8cJ3n8n3KY2ApYAufDpA3xvNMimMVC5zGUWflr97pb9pMJKVhP/jk7ahbmBa2kr1XuN7YfLYK3HALNyZbeMi7eeDU4iKhPfu6+EXZHGFjvyp3D1PlATJ1iNDgpdDZpoy27vjLDadllTn9+oT3KpJ8fp/ok4ntslc0IQpD6SaIyRTYN7D1bbLekFu5Tc2POvT2wnJ5zIlnDnQxy0lOfbCHdXuX6MxQfXMJyjTOFlaqctB89lG41QxkIkpuHENAs7GkiiqQNJhQbAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pG6pmtSjZxihLx+e6aw9QJ1o9v69CL3wgVAL6R9pdNk=;
 b=xNKSG1PikI5aQ8vVNE38PHmUyh4goFOEUGbZrsC2GqzcQtYaEBNPdropKL//o2wEarYU3saalpUIcuTdM2AV+QYFaJuZE2bGYmyVR8NhD8rHwM90uX6xAKYLzsdVSp0X3l2gJRpoAc3GdRnhl1z0Heq2gnG4kCUcDsFqHmbv0YMx9lOqrRlrVI7J6fM351skh8A+6Zod5D1cuDofVP7sUil1hGh5oih/YQx4lQHuVg5Rq21LFkaqpMSIeYyxPhWZmXDj3T7y6M19uNIdRC96kpAp6dcLJkAJzPyhnLOG1LPUmgiy5eiYy3Zmcja7CEvpE8UgPvpXRceeDdwLS+zb7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pG6pmtSjZxihLx+e6aw9QJ1o9v69CL3wgVAL6R9pdNk=;
 b=NwT7qf7KO4lDjcwgDWylUjREE38PHLNASA2KEYRoXED7YtbVLGPsn4W7evhVZfOZsAGnkl7E36Mkq4nG3jcUIi2OwNMxnNW1k+UJCg7Bgz0QghsxxJFYumu4VWdLFHCRqzW1JZlNT6vvDx8kmEflHm2xtCX6zK8s9ZWwgWuhDHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by SN7PR12MB8604.namprd12.prod.outlook.com (2603:10b6:806:273::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Fri, 9 May
 2025 12:45:05 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947%5]) with mapi id 15.20.8699.026; Fri, 9 May 2025
 12:45:04 +0000
Content-Type: multipart/alternative;
 boundary="------------E5fthgvqewGT2bQYJGGFtmxi"
Message-ID: <06caf86d-c29b-4cd9-8105-5624334a79ca@amd.com>
Date: Fri, 9 May 2025 08:45:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: improve performance with XNACK enable
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 philip.yang@amd.com
Cc: Felix.kuehling@amd.com
References: <20250508144651.16745-1-James.Zhu@amd.com>
 <e741c57a-651e-4acf-9ae6-4268c6540e0e@amd.com>
 <6466df95-a64d-4894-b148-c153d299599b@amd.com>
 <7563a7d3-a871-490b-b756-11255d0532d9@amd.com>
 <bb06537d-b04e-4657-9893-923a54b8e5a8@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <bb06537d-b04e-4657-9893-923a54b8e5a8@amd.com>
X-ClientProxiedBy: YQBP288CA0019.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::25) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|SN7PR12MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: f4394a58-9d8c-4e7b-3041-08dd8ef75233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTY3UEJBdXl6d1YwYWVjUUhwMjR1U2pyMGx3MGNPMFpvMmdzZ2lWUTJWZEI4?=
 =?utf-8?B?c2prbC9tUkh5SThNK1FKY1RFaTdZdVZYY2ppWVlicThPOGk2NXVCUE55R0Zv?=
 =?utf-8?B?aGtUOWVweitwU2pKY1JaaDVOQmJyZW5iVHk0aGtkZ0V4Zm00T1JHUml4VmFn?=
 =?utf-8?B?aTFGZzFzc09nS3NnZ25SN3lOc2Rkdmw2MnhtNUNGcmtBQzJiYWZjaHpzVVNV?=
 =?utf-8?B?b2lLdXFKMWo0ZHMrRG9vdUh6anl6WE94STVtM1NtclN0alh2MEFldm9iVTY4?=
 =?utf-8?B?K0lDMGRWQ2ZsaXVxUmZNbXhnckM1Tm1SVWdjcGgwMGhtZ0F2MUpZSldmWEEv?=
 =?utf-8?B?ZWdqaUVRaFRZWVpHUE93eUtmb1NUSEVjZDRUakY3QmVHVDZUbXRHYmZwRGhL?=
 =?utf-8?B?WTBnRXdqUnFaU3BMZytxSzl1NGk0bVAvNnQ4bEdRdlBTUy95K2xablZicnNx?=
 =?utf-8?B?STc0ckJHcjlTMmpTSGRrQjF1aDVLVHgvMllaRHEwUm1JL3VHSmxHN1BxU1hy?=
 =?utf-8?B?Q0hJalA1Y1Buajg0M2trVjkxM0VFQWwvRmxzdVZrZW9ROHZrbDVyVFoyUUY4?=
 =?utf-8?B?UHUycmdEYmF2cXJETk92SEMvRzIyYzRxeVdjQzhsVjZ5NmNKQU9TNXg4dVBZ?=
 =?utf-8?B?RUw1ZUtIRGs4RjNndGdRb0MxTWhKbmorOUs4WDZKaDhPeWY3cThrbitCcFJN?=
 =?utf-8?B?Z0F6SDRMUFZ6bmEzWnpUTCtGN2htSFNCcUVsVWM4NnZ1Y2pFcHNLRnVrSmhy?=
 =?utf-8?B?SUtBSXE3NFdYaGdEdzJmTVhiUlRoS25Td1VySk1rQ1hXRE9BT3V0cFdzNytr?=
 =?utf-8?B?bllwSUphdU9rMWFaUUZ6Zyt4ZW83NklLTWRKN0dzbkFBY3NyV1d5VjVHZHhT?=
 =?utf-8?B?VnUyV3hNSWxjTXFrNmRub1BJQytKY3RUOHNhM3oxbWluQVNDcVFxdUkrTTVk?=
 =?utf-8?B?RXZmWnJmTGExRllrMkJpUm1tbno1SWVBaGk3YkRZSkxKUjhmRGhqVDBmakJa?=
 =?utf-8?B?S2xRMVVCdi83bVdhb0FTYmFtL0NRSE50VnlCeGFvR0dVZ2h2dTVYK3dqckJi?=
 =?utf-8?B?aHcyQ3ZZb3orOWlNVXloM3IvQU4xWTVNcnhXeEhwUnEvTk9ERWJUZlBXUkQw?=
 =?utf-8?B?L2FTT3lzWTRxOGM4czdkcS9HdWxjcHJuaS9KR2I4Ky9hdHpFMU91SGkvMThv?=
 =?utf-8?B?eHFYVkJFZ2VtZ3BsOFZEUG9OUytJcy9Ya1RZTGxyUWlYNU5INGFiNHNUa3R6?=
 =?utf-8?B?MnorMkpidkhDaXlXSStSYk5yL21iamhYYU5QQ0c5R0dNYzZtdFBqWkM2b2xs?=
 =?utf-8?B?cjRUeXhaU2N3WFBGT1JJMUVOWFpNMWo0Z2JmRWxCRG42UUc4cmtqOXBFVWlt?=
 =?utf-8?B?b1M5eHcxN1h2UjNPQkdwa0NySnZRWVEvZUpReG5WVWduRjFIb2hOOFU4MDY5?=
 =?utf-8?B?UXp1Wm5JbVBqL0dkSzBzRlNkVFpmSEZnWVZLUTVvTzduU0h3aE1SZUpkclpn?=
 =?utf-8?B?bHJaT3ZLNXhuTFBBbUFzQnZZamlLb2V1czRWQVVzakpiRm1YeFpqOXpvdWdG?=
 =?utf-8?B?cS9JVkQvdGxhU0tFTHlLVnhTZXBGRXZCMlFFUzhmZXVYUTNGUEdQRXZQZUg3?=
 =?utf-8?B?WWM4ZVBMcDdEOWdESThKWFZUVFJmMG5LMHlIN3NpM2c1c0NNU1ViQmxvSXVt?=
 =?utf-8?B?UngxeVNCa01Pa1IxRkQxOW95bnhldkdPc1M1d0NtTCtXRlF1MGpuOHNsNHgv?=
 =?utf-8?B?em5XUzB2a0c5bE9IRlVPM3FSLzFzZ1NOaFh1NmxDYjlZNVVsZ0JGUWptYjNE?=
 =?utf-8?B?SFFFbmQ2UGhyeThzdENNakhmZE85akpqaWtEcU5mY0xZbkxTcXlBSHZodUU4?=
 =?utf-8?B?Y2srWlNSL2ptWU5pL0tqaFJQZlQ5ODZMZFRnOStCNFRBd3pMeU5NSGZ5Tzhn?=
 =?utf-8?Q?1K1b9ya7XR0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkZaMnJTcFRHQTBqT1l3dXllUmd3QnJoaWxsbWJteDdRYXZ0bU9DY0Ryd2Jm?=
 =?utf-8?B?M1F3eGx0bGdkMTkvL0hJYzZQQkpUKytTTEdUcEoxbm1McnduRHh6UlJxOUxR?=
 =?utf-8?B?dE1tRUpXWEVlSTdyWVF4c2hZU2E1M2poc2wxK1JLY2Q1TUxOenV3NE5iTXVr?=
 =?utf-8?B?Z09GT3BzTmQ5UHlPM1lBT3hGRmpWQk91ck5yZ2NBSVpLWlh0c3VQV2lPTUVa?=
 =?utf-8?B?bWRiNWZteEFkWWZKL0pXUjlEYWZOMXpmQmlVM0x3ek5aNkNnem1CWkZFTlNm?=
 =?utf-8?B?YmFJNUJhc0JvMURjMUh1VE9PUXVKa2hTR0lWK0w1V0FKMUE3bjVqWHBRY3dJ?=
 =?utf-8?B?NlN2UlN1aFhFdmhxaEhxNFN5NzU5eTc3bUNHOGtXeUswRWNUVU5EbFVaRGxR?=
 =?utf-8?B?MzNJWjVrV0Jab2FjOVlDZFpDSFUzN0VKL0VhQ29rL3BuQkp0UXVKMTc4TWZj?=
 =?utf-8?B?aWpMN2Y2U3lxbjNDUExXWjk4aXJRQ2lDWWQzSnFIYVVTNTh4ejJYRHI5aXZC?=
 =?utf-8?B?MVdWa1hLbnJ3TTR4WVJHTUNLZXhPOVBPZ29Pb2hYRWl1TmtaUXkyK3M4WXNs?=
 =?utf-8?B?aWYxMnF0aFlIdEQ1QklHaDlSN0Z4OXR1aXJ6ME4vMmdXdEYxNm5LNktUTXNu?=
 =?utf-8?B?dmlvTHZYc1JEUzlaVDNXS0pvVTJRNHE3VStKMVQxLzRRNWZxeDd0S1p1akw2?=
 =?utf-8?B?YmJVRDA1ZG1tZXZYWUhGemxoMFNFMGZmdGJQNEVjcm5jbVp4aWpEelIyRnFo?=
 =?utf-8?B?djZvSzZsckF1MWJ6azNyMDZrUm1iaE5xY2tpYlZmM05Rc09rQjhpRVR6THYz?=
 =?utf-8?B?T0pKODhjVldBdWRQRm9TRnRMblJhSlY0WW84T3B2UjJKRkNEdVloZFNTWVlY?=
 =?utf-8?B?dHBJN05mbEN3bC9BNnd4REY0ZmpncHh3QTFBRG0wZGRVd3V2ZFloSlpPMEo1?=
 =?utf-8?B?RUxPbkIxN3Z3RmlDc1pyTERvU3N0S1p2elZFaXBpZW9RWmRrNEY5bFVpYWN4?=
 =?utf-8?B?SGtSYmRCNDVFR1FBZ05lYmlDbjUrTW9XOHpNVVBWbXdIbEo0UEVKdGZnY0o4?=
 =?utf-8?B?WXRXMmptQ3diV09tQVdacTkxSUFNQzArRGhjNktUcWpvS2crVmRFQ1A5Ny9x?=
 =?utf-8?B?QWtZSGJ2Y2U4dFQ4T3IrbEdzRVc1ZHo2cHRiMTREMXlWYzAvSTJiZjdDZm9l?=
 =?utf-8?B?WVhFempFblhvU1AxVW1iNEVFSnptR0E4Tm5NVXZXL0czTkZoL2w3VXJQWWpo?=
 =?utf-8?B?UER4UldkVUNBZTEzdytSMzZaMVJSV0p2KzB3SW5DeXd6aUlWbjQ1Z0YvUklZ?=
 =?utf-8?B?K1g2VjJTZEpSeng4LytuNm01Q2NvTy9HYmtmYXpqK2UvdUJTZjRXUWFMU1dk?=
 =?utf-8?B?Y0hGQW1uampIdHREcHRxdXMzbTdqWVhIR3lmZ2J4R1ZOVUJheHNUZkNjaUtn?=
 =?utf-8?B?Z0pPdTEyZ1ZnRlB1REExbkQydmpUK3lPMCtiZ3ZybVRKakJYbisxdHRHSnNC?=
 =?utf-8?B?RTRsMkIwbVNDaHZiUXRwc3VjOU44K1FldUsvMFlMOGVaMXBybzB1RlRHZG1E?=
 =?utf-8?B?VUlXUGs4L2pEaHptWUZKc3lGbzdXRVdydnhZTVRyckJ6UDJBQ0FVQW50U1pI?=
 =?utf-8?B?SW9VZDl6dG9EQlhVUThWZVVWQzJCZXhjVlB1WmlwUHBOR3Nyakd6TTQvVFlq?=
 =?utf-8?B?WFFKbzBHQTZzcElyTUpoME1aTUhDcU54R0xyK2RSam1GclhXc2xOMFVLZ3F0?=
 =?utf-8?B?bXFaUEY1YXBnVUlQU1M0QTRIN1lydHFJM0F6NjIzc2xNUFVOdGdvOWdYeldr?=
 =?utf-8?B?SFdqbnBPdjJEYk02dnZEdklBekF6R0hncnZCc1FUNnJlK2lpQXNJNnZTUjBv?=
 =?utf-8?B?OHVRYUtZazFDM2c2aVBEbjF4S2FIVjM2MU9YZ3FYWUg3Uys4emZlWUJuSkZT?=
 =?utf-8?B?aGNvSUNSRGswWlBWRmpUMXhHNERYU2FUc3hOZjNIUVJqODd1b0xYR2dOay9r?=
 =?utf-8?B?OTcyNEovVXJGTnptM2IzV254RGFBYmRuRXRNbUhEWUd6SUx1NFc2UTdvMTNW?=
 =?utf-8?B?cW9NYVQ0K2xUUTlONjdNcnZvckhnSnNSSUJrWnFNZml1VzJBZXRYSUFaNU5q?=
 =?utf-8?Q?kTCKkanikg3iF23m9v0xw3uBG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4394a58-9d8c-4e7b-3041-08dd8ef75233
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 12:45:04.5963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eefrn1c2pjDIJb7HqW82Vjuj19sorBh5Fn2nm/FJAb+R0kYEnT6bQpVWdsB3bbfP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8604
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

--------------E5fthgvqewGT2bQYJGGFtmxi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025-05-09 02:00, Christian König wrote:
> On 5/8/25 19:25, James Zhu wrote:
>> On 2025-05-08 11:20, James Zhu wrote:
>>> On 2025-05-08 10:50, Christian König wrote:
>>>> On 5/8/25 16:46, James Zhu wrote:
>>>>> When XNACK on, hang or low performance is observed with some test cases.
>>>>> The restoring page process has unexpected stuck during evicting/restoring
>>>>> if some bo's flag has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting:
>>>>> 1. when xnack on, retry pagefault will invoke restoring pages process
>>>>> 2. A. if there is enough VRAM space, simply migrating pages from ram to vram
>>>>>      B. if there is no enough VRAM space left, searching resource LRU list, and
>>>>>         scheduling a new eviction work queue to evict LRU bo from vram to ram
>>>>>         first, then resume restoring pages process, or waiting for eviction
>>>>>         timeout and try to schedule evicting next LRU bo
>>>>> 3. for case 2B, if bo has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting,
>>>>>      queue eviction will be triggered.So restoring work queue will be scheduled.
>>>>> 4. step 1, restoring pages process will hold one mm->mmap_lock's read until
>>>>>      restoring pages is completed
>>>>>      step 2B, evictiion work queue process will hold one mm->mmap_lock's read
>>>>>      until evicting bo is completed
>>>>>      step 3, restoring work queue process is trying to acquire one mm->mmap_lock's
>>>>>      write after the above two mm->mmap_lock's read are released, and in the
>>>>>      meantime which will block all following mm->mmap_lock's read request.
>>>>> 5. in step 2, if the first eviction bo's size is big enough for step 1
>>>>>      restoring pages request, everything is fine. if not, which means that the
>>>>>      mm->mmap_lock's read step 1 won't be release right the way. In step 3, first
>>>>>      eviction bo's restoring work queue will compete for mm->mmap_lock's write,
>>>>>      the second and following LRU bo's evictiion work queue will be blocked by
>>>>>      tring to acquire mm->mmap_lock's read until timeout. All restoring pages
>>>>>      process will be stuck here.
>>>>> Using down_write_trylock to replace mmap_write_lock will help not block the
>>>>> second and following evictiion work queue process.
>>>>>
>>>>> Signed-off-by: James Zhu<James.Zhu@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 +++++-
>>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> index 72be6e152e88..5f6ed70559b7 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> @@ -1794,7 +1794,11 @@ svm_range_list_lock_and_flush_work(struct svm_range_list *svms,
>>>>>    {
>>>>>    retry_flush_work:
>>>>>        flush_work(&svms->deferred_list_work);
>>>>> -    mmap_write_lock(mm);
>>>>> +        while (true) {
>>>>> +                if (down_write_trylock(&(mm->mmap_lock)))
>>>>> +                        break;
>>>>> +                schedule();
>>>>> +        }
>>>> Oh, stuff like that is usually an absolutely clear NAK from upstream.
>>>>
>>>> As far as I know that is not something we can do so easily.
>>>>
>>>> Would it be possible to wait for progress instead of calling schedule() here?
>>> [JZ]  At 1st beginning, I am thinking adding sync with restoring pages done.
>>>
>>> but the original restoring work design philosophy is blindly scheduled after certain delay.
>>>
>>> the changes with sync may take more time and risk. I would like Felix and Philip give comments
>>>
>>> if there is efficient and safe way to fix it. Thanks!
>> [JZ] BTW, in worse case, mmap_write_lock will fall into rwsem_down_write_slowpath(), schedule_preempt_disabled() and schedule();
> Yeah, but drivers are not allowed to re-implement or even bypass that logic.

[JZ] here  can take as a new version mmap_write_lock without blocking 
the following read request and competing for write

lock which means read has higher priority under this case. Logically 
sync is better way to replace it. In practice, under

current scenery, sync will increase other burdens an risk.

>
> Regards,
> Christian.
>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>          if (list_empty(&svms->deferred_range_list))
>>>>>            return;
--------------E5fthgvqewGT2bQYJGGFtmxi
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-05-09 02:00, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:bb06537d-b04e-4657-9893-923a54b8e5a8@amd.com">
      <pre class="moz-quote-pre" wrap="">On 5/8/25 19:25, James Zhu wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
On 2025-05-08 11:20, James Zhu wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
On 2025-05-08 10:50, Christian König wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">On 5/8/25 16:46, James Zhu wrote:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">When XNACK on, hang or low performance is observed with some test cases.
The restoring page process has unexpected stuck during evicting/restoring
if some bo's flag has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting:
1. when xnack on, retry pagefault will invoke restoring pages process
2. A. if there is enough VRAM space, simply migrating pages from ram to vram
&nbsp;&nbsp;&nbsp; B. if there is no enough VRAM space left, searching resource LRU list, and
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scheduling a new eviction work queue to evict LRU bo from vram to ram
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; first, then resume restoring pages process, or waiting for eviction
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout and try to schedule evicting next LRU bo
3. for case 2B, if bo has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting,
&nbsp;&nbsp;&nbsp; queue eviction will be triggered.So restoring work queue will be scheduled.
4. step 1, restoring pages process will hold one mm-&gt;mmap_lock's read until
&nbsp;&nbsp;&nbsp; restoring pages is completed
&nbsp;&nbsp;&nbsp; step 2B, evictiion work queue process will hold one mm-&gt;mmap_lock's read
&nbsp;&nbsp;&nbsp; until evicting bo is completed
&nbsp;&nbsp;&nbsp; step 3, restoring work queue process is trying to acquire one mm-&gt;mmap_lock's
&nbsp;&nbsp;&nbsp; write after the above two mm-&gt;mmap_lock's read are released, and in the
&nbsp;&nbsp;&nbsp; meantime which will block all following mm-&gt;mmap_lock's read request.
5. in step 2, if the first eviction bo's size is big enough for step 1
&nbsp;&nbsp;&nbsp; restoring pages request, everything is fine. if not, which means that the
&nbsp;&nbsp;&nbsp; mm-&gt;mmap_lock's read step 1 won't be release right the way. In step 3, first
&nbsp;&nbsp;&nbsp; eviction bo's restoring work queue will compete for mm-&gt;mmap_lock's write,
&nbsp;&nbsp;&nbsp; the second and following LRU bo's evictiion work queue will be blocked by
&nbsp;&nbsp;&nbsp; tring to acquire mm-&gt;mmap_lock's read until timeout. All restoring pages
&nbsp;&nbsp;&nbsp; process will be stuck here.
Using down_write_trylock to replace mmap_write_lock will help not block the
second and following evictiion work queue process.

Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
---
&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 +++++-
&nbsp; 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 72be6e152e88..5f6ed70559b7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1794,7 +1794,11 @@ svm_range_list_lock_and_flush_work(struct svm_range_list *svms,
&nbsp; {
&nbsp; retry_flush_work:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_work(&amp;svms-&gt;deferred_list_work);
-&nbsp;&nbsp;&nbsp; mmap_write_lock(mm);
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (true) {
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (down_write_trylock(&amp;(mm-&gt;mmap_lock)))
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule();
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap="">Oh, stuff like that is usually an absolutely clear NAK from upstream.

As far as I know that is not something we can do so easily.

Would it be possible to wait for progress instead of calling schedule() here?
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">
[JZ]&nbsp; At 1st beginning, I am thinking adding sync with restoring pages done.

but the original restoring work design philosophy is blindly scheduled after certain delay.

the changes with sync may take more time and risk. I would like Felix and Philip give comments

if there is efficient and safe way to fix it. Thanks!
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">[JZ] BTW, in worse case, mmap_write_lock will fall into rwsem_down_write_slowpath(), schedule_preempt_disabled() and schedule();
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Yeah, but drivers are not allowed to re-implement or even bypass that logic.</pre>
    </blockquote>
    <p>[JZ] here&nbsp; can take as a new version <span style="white-space: pre-wrap">mmap_write_lock without blocking the following read request and competing for write</span></p>
    <p><span style="white-space: pre-wrap">lock which means read has higher priority under this case. Logically sync is better way to replace it. In practice, under </span></p>
    <p><span style="white-space: pre-wrap">current scenery, sync will increase other burdens an risk. 

</span></p>
    <blockquote type="cite" cite="mid:bb06537d-b04e-4657-9893-923a54b8e5a8@amd.com">
      <pre class="moz-quote-pre" wrap="">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">
Regards,
Christian.

</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;svms-&gt;deferred_range_list))
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
</pre>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------E5fthgvqewGT2bQYJGGFtmxi--
