Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5000C87FD3
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 06:13:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ABF110E2BA;
	Mon,  4 Aug 2025 06:13:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Itr8NQ18";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85C8810E2BA
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 06:13:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwsM/U6eIJWoejcoRVGWtVXXo5V6454FzYSeHl0ri+juB0ePy1Sn0C8dThM7JNjG5bGM895c3P02WuP2YuRFxjmkSqyM9GOi/lpdGEHX3XHLsdcYgdQxX5J2XkXWARY5glEEnO/9DaPo07PcNEN7QaawAJifZ9w/LyJ951exG/nGWSyHhKtV4gCjO2u64nBAd5EYo5OXIwPHk2F9k/YfOnP+lhyxA4g8+PfLNQk7DmPTmwT/OntXmdA3D3MHomuEwhvRXOoh1dHjqTfjshCwIrtl4HTv1IxvMHH5edZJByZknW9bJsFc8hlprY1WH2ySBhLZNnh+/gB8/s75IyMbug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41DX7jwhpBauoS4d0aNS0JifOo9nJBVVgiMSACr4Jq4=;
 b=yp8u+46hIV6cDqhaimCPVDmqihcY6FQ92JrmZ/e4/aUJFqk+zxkyXJgg71+IAHhp9wsqeY87qxbgAfp8q6I7xhpwTfpX4Z0FgPKxIusIePsym7xv71yvoavgGW7iJuXnw3xfekiQi+ju6f7nunAesAVJG5iIsA1u2K6/pcG33P0IdczMcN3HgZib/EX0py8XRq954I6OqAa6sevRxYSlNqcdsaV4zGArlnVTu6q2oQhsAWk3ylkPv9jeDuzonXPV/deurnS+IiDN3FoO+siJPJNvohbNd40nKSYf6XS1/OfOJkQmTi/PGxubM9fZd0uHMMvd5hVS6mZKY06MEHJEqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41DX7jwhpBauoS4d0aNS0JifOo9nJBVVgiMSACr4Jq4=;
 b=Itr8NQ18iBXvFbXV2Kfp3/eFnpOD+UWCOY1RyMaG0aFu06pfFC758O7B9UGTmTOoCyLpzl33MTaxcqwWEO/MwRvNX8UhEnGHugQFcMbWAOstfINR0Qw2JaT7ksNJCuUUA0UthoPePS5ZjgyfOciWxBD9c0BfADdrqLrCYB+eX4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by CY8PR12MB7539.namprd12.prod.outlook.com (2603:10b6:930:96::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 06:13:19 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%7]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 06:13:18 +0000
Content-Type: multipart/alternative;
 boundary="------------GqpicaxQOerNKYNoaew80d5T"
Message-ID: <46c4791f-987a-4343-8fe7-2fa30c08322f@amd.com>
Date: Mon, 4 Aug 2025 14:13:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 08/10] amdkfd: identify a secondary kfd process by its
 id
To: Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250801085556.8504-1-lingshan.zhu@amd.com>
 <20250801085556.8504-9-lingshan.zhu@amd.com>
 <5324e3ed-514c-443e-835e-3741d102fae6@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <5324e3ed-514c-443e-835e-3741d102fae6@amd.com>
X-ClientProxiedBy: JH0PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:990:56::13) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|CY8PR12MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: 13448f71-8928-4d7f-2dd3-08ddd31e0196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmpDd1o3YTZsdFE5V2l3T3lucGljRnlVVXB1VndtdVBhQlE3Y29mUHJNTVBt?=
 =?utf-8?B?V1pZMStIR0tCOHN0aXRIRlRiekJQU2JIY25YZW9GR254blFBcnhEYW4zK1Zx?=
 =?utf-8?B?RFoydFoxUEJzRThxL0gzR2FVTXFrRmpGc3pVa1J5YmtDdURXTWJLNTY0Tk1T?=
 =?utf-8?B?ampFTlBJTnFIZVR3WUJDTVFDR2ZqNFVqNDhHcjVkNzdkNkVxeVFQUFNTUFpl?=
 =?utf-8?B?OEgrTEZ3dnI2RzdQNkxnZ1BuT01mV3JPUGhoeTJLb2JIRWVraXF2UDVFUSsx?=
 =?utf-8?B?MUJJZVdzVFFhOVNhZkFOc2xmUjgwTW1BWStNUVZhVGpVUnVKL1hwd3FrWVBv?=
 =?utf-8?B?eW5mQ05ZdFd2bHlEOStneEJsU25CeW5kQmwvSGJEYlNEWU5zaVROSlFGai9M?=
 =?utf-8?B?RU9VZEEzNVdaN2w5OExNY0Y3VnF1YmFSQ241QnUyamhXWTc2LzNMTVhZUW05?=
 =?utf-8?B?Nk1qR1BNeEZ4YzhNZGE1VXc0dVR4b0dYemdwSW9jNHAwdVFGU3Z0Ujk2clpI?=
 =?utf-8?B?QXJxOUJ0RkNiVjF0TkxhVmVobjBpN1dzMkptZmxyWDQ1M25RRkVsdHZaeUxN?=
 =?utf-8?B?WUYwUjZ1cGFnRTlGdGdhSkFITDd1dlNtNmx4bFlQMWxvbW1ZWjcvTnN4OWtu?=
 =?utf-8?B?SHRrbHJVY1NPQ05rOFZKWEx3ek9NU3A0ZENOUHNTVEhzeXF3RTNYa01LWmE5?=
 =?utf-8?B?UGdSOURSb2l6UU94NzYrU2hYakc3N28yZHZvL2JzeWNJQ2tmYjNoQ2V1MC9K?=
 =?utf-8?B?NFp2dFZtZlZQWU1YUzlXNmNKbUxTeEZFOGphNllQTmMxS1dENmo2QTlCdFQ1?=
 =?utf-8?B?dmpOa2MrY296TmZQNzZlc21TbERBYTQrT2pyNlhhSWk4SFh6Mlk1bGNsNW9X?=
 =?utf-8?B?dmhucHgrUlh6eU5YYTdlc1FXNGtQMEpUL3UydFV0d2hpNE9hYmFVb3kycE10?=
 =?utf-8?B?ZC9IUUtrWkZuVkZFd3ExekQvblFBNjBHTERhV0U3N0xsYTZONzB3Umg3c0Jh?=
 =?utf-8?B?N3JiWVZFbTJWc1gxSkFFNGg0aEJMT2xOSnNzOXhoVldJa2RVUjZnQ1hsMCtJ?=
 =?utf-8?B?ZmtkMDA0S0psVkFWcmx4T24yQVRYcFcwNzJnZVl4R1BwZnFrS1BxeEpwWjRh?=
 =?utf-8?B?U0dwM0V3dEppUlhBMGdoYVNkbjdyT0RyUmZGVStDQVhQcWl1bzUvdGFNWWJj?=
 =?utf-8?B?bVdOTkEwQ2k1MlpWdUJLQ2V5bU1Xb0pRdkxJbGxyRGlJVXk0amE2d3JYbFdS?=
 =?utf-8?B?VHRjT1AxM2h1enJGS2lrR01MYzBjQTRiTzQyeW1uVTlpazZzNXZQM0x2NVI3?=
 =?utf-8?B?NWRwWFRPZ2crWDQ0MUN6ditHWnBvcDZBTEJQQURwalRaeXNwUWlpbEExcnZt?=
 =?utf-8?B?Qmk1aU9YbCs4eWtQWVJ2R1ZlTHdYeDk1UzFPQURNS0x5MW9aK1MzdjIwVEZp?=
 =?utf-8?B?VGNqVzI1NEpmNFd2NUpOa1JWalFLWW5Lb0Y5WVFLaXFrSysrYk13c1dlcDIz?=
 =?utf-8?B?amtoWjJkclVKVjdHa3dIVUNOM1p2RFczNkdoNE8zSVp0NEd0MVdFczRyWW0y?=
 =?utf-8?B?eks3MEs4NGFPNWZNL29ScEIzOXphT01TT0REcVl0cURnM2YvQkx5QUJudXFS?=
 =?utf-8?B?dzBtdlkzMkE0QzExZ0ZaUzI3bmh0cGw1Wno1OXJCaVJieWdLVk1ndDBhcGpM?=
 =?utf-8?B?ek5WcWo5bnBnRWNFK2poYkl0V0U2dEh1RWZhNDBtNUN4b2lFazZCdkxrTnVR?=
 =?utf-8?B?dWI1UXdXd1pNbDBOTjNOL000SHM5V2lpVzhIdWlxd1VyKzRId1pPUDVQb3pm?=
 =?utf-8?B?aHVkT3d0UWRsdmJTa04zTGtPc1hoTWxlTEdjYU1aTmVVMDd3QXUvbnc3OUty?=
 =?utf-8?B?Sk5KV3lIVHVIbTh4R3AwYzFCSkp5MTdkTXhsWVNycHVYWmlDT25TOEkvQWUy?=
 =?utf-8?Q?Ni2nfV0fm4o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2dySHlkUmJaWFozUFpQL2VmNlFjNVVFOHY5YW9uM29zNm9YYUVYczl6RElJ?=
 =?utf-8?B?VVEyNlhCS3B6d01GTVVqYW9HOTlIcHRoSkx0MHFxMkxCZlBycjdkTi9IMHg5?=
 =?utf-8?B?MUFrNWk4aFZpcEI4SGIwMllIZ01yaWl1QVlxbFNJQS9OenREWnlLYnBjWFRD?=
 =?utf-8?B?ZCtQWGowU1FJdy8yK1dIZDdOa3Z5eTdPRXVMR200S25wWTh6cE5sMWQ4L0kr?=
 =?utf-8?B?d0hTcXdqa29Mb0piUjd3bmRDb2VFeDRpTU5pY1JBbGtvLzFWYmwySkpBNmJR?=
 =?utf-8?B?SXk1Rk9MOEVkdFpWL3dtMDFpWDFoK1BYMFR1MzlVS3psRHNjdjdUL0JCakh3?=
 =?utf-8?B?TnVKZ0JqRUdEajhTbDdORnhDczBUQUpvNnQ2U2l6QjIydW5yN1hsOHY2eVM0?=
 =?utf-8?B?bGlQWGJPcVFnRXdUa1FHeEJuTlc3aEk4cURHczBPUzN6eXZOdURmMUE5ckJG?=
 =?utf-8?B?ZmZTOUhBS0hlY2VmT2N1Q0NhMWcxVmFudHYrTks3S2ZBN1NyVURlSDhLK3Vm?=
 =?utf-8?B?YzdpQ3oxQmRDbXhwd0dzRFNIRVFoeFkrNGl5K2NUdEZTeHJlbGY0NWgxRHA5?=
 =?utf-8?B?RlZXTmNubFRLd3lsbFhybEExMXJyR09keVptQ3VqcXRYd0hycE96ak9RczZS?=
 =?utf-8?B?ZEZid0lQdEJWSFVxWjhkNVl6N3FTVHJoZkVXNWJJQXlkbkhCUFoxMDk2NnJP?=
 =?utf-8?B?OE13TGhRUU5JWTdrNnh4Umg3TXVERVljK245Um03SDRBak9Cbk5mZkttalFP?=
 =?utf-8?B?K2dISER3OURGY2FsZUg5aWpXZVdiaE9RTGtrdEtjUms4SnV4NklhZEQ5c09s?=
 =?utf-8?B?U0JNczVNUFByTXpxNUc1NjZ6YkJmUUUvNXhyamxkMEJTQ2JrdFBGbE53THpG?=
 =?utf-8?B?NEgyQkZ0NUlRcGFFSTZwTnFiVkVwbmNwcm9Ud1VMa3R3SFpkR0hJU3c5eGVK?=
 =?utf-8?B?YUxPZlRlaWlsWllkUUo3TXJabFRFNHo1RVJHZVdnWnlnWEh6c2hMVjVEeHdv?=
 =?utf-8?B?SUV1MFI3N21ORWxubHMwKzJrRzYwTkZDOExJUGpiSmJnSFN5OEJrN01tUUFX?=
 =?utf-8?B?L2dva0Z4TVlPbGtINnBwVTVSaEFLWVJzd1RueXM0TkJXeUV5MGxiMnp4UUNy?=
 =?utf-8?B?ejBYdkNJNi9ZcmF5aWRacTN2MFl1am04cnhkTUZOMzFkR0lBSVpMN09PNkpj?=
 =?utf-8?B?QmtRbS96SDl4ZzdwNFU0ZHNkcWtGUXRNcGcyM1ZzY3MvemVTbEdBWTNsbVBV?=
 =?utf-8?B?M2lPRmVDL2FGYWM3QVNOZEt0dGVaS3cvOHcrdjhrT3lsY3BvM0RnL25ta2xR?=
 =?utf-8?B?bEc4QmZLSER1Rkd3Q2JlWllCd2hSNHVhTDNaQWVqMHhQbU1IUkptbjVJdDZm?=
 =?utf-8?B?RFBsWUQ3cU5EWFd1c05lS200Qk94T2NsbDlPTHN3RUV2TjVwT24vVEM2TVMz?=
 =?utf-8?B?eit2UFRDNllwYXBreUZVaEJIMytrUkhZOW5hdWtLTkZ3bHNQdVpZTnd1SkFV?=
 =?utf-8?B?dHNQUUcycXBEendkL1hpTFpSbWwrYUprajJKeDZpcnpnNnNIL0pGVUdsZ2Zs?=
 =?utf-8?B?aSsyNjFseE12WFpOT0xkd2lzWnhITlQ2RitiWnBuY09jYkttcFk5Q2c1dm1l?=
 =?utf-8?B?SURxU2ZGR0JocGhkUTQvRGlWS3NnMUJlcS9leUc3UFNXTXVyeHFBbUtYaC9n?=
 =?utf-8?B?UzhlTWdOTGxLaW9tS2lmZ1R5UUlJVk44WS9CMjU4eWc2b2VCRHRpSjVLR2kw?=
 =?utf-8?B?RVFLSk5tcHVJcCtKNytuaW5OazAzczdWdHJNL2pJZnVXaGdOUUR4blhoekdw?=
 =?utf-8?B?bzBZQTIvZThoUFIrQlFiRjRZWUE2TkFnbVRVdGJ0cXQ1Tk5sSllyd0dkVnp5?=
 =?utf-8?B?dGJkczVlYkV2RjFmQVhlbFJ2QnNCV01xbThDZDZNK2xRTTFIVnpRN3BmNDlP?=
 =?utf-8?B?M0VWNHdsMlBVdVVoWDJmSzJjOExMTG0vK1M3LzZ2dmNMdXhseU42VFl2Q1dZ?=
 =?utf-8?B?OTJ5MllEQ3lzc3UzUmxOOUhmVXl3R3RnSHp2MTNaczAyVzZPa3h6REE0NzhU?=
 =?utf-8?B?TndYUnFJRnQwYkRUQkhwbDJNZWFYL1kvUDBMcGFyMThTMWZaMUVUczhDbkZj?=
 =?utf-8?Q?q8/74bwcEik1KZbbGrYEmQmq6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13448f71-8928-4d7f-2dd3-08ddd31e0196
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 06:13:18.8836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGJJBq9puWrJiWKG1I3gZwnbcvheyfs8nrD1H4Lyv7zCPBlbpLnaYdi98wCk4Ws6VYdrK1XtJxKa17oKlvWw5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7539
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

--------------GqpicaxQOerNKYNoaew80d5T
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/2/2025 12:05 AM, Felix Kuehling wrote:

> On 2025-08-01 4:55, Zhu Lingshan wrote:
>> This commit introduces a new id field for
>> struct kfd process, which helps identify
>> a kfd process among multiple contexts that
>> all belong to a single user space program.
>>
>> The sysfs entry of a secondary kfd process
>> is placed under the sysfs entry folder of
>> its primary kfd process.
>>
>> The naming format of the sysfs entry of a secondary
>> kfd process is "context_%u" where %u is the process id.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  6 ++
>>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 83 +++++++++++++++++++++++-
>>  2 files changed, 86 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index de701d72aa5c..a6e12c705734 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -995,6 +995,9 @@ struct kfd_process {
>>  	/* Tracks debug per-vmid request for debug flags */
>>  	u32 dbg_flags;
>>  
>> +	/* kfd process id */
>> +	u16 id;
>> +
>>  	atomic_t poison;
>>  	/* Queues are in paused stated because we are in the process of doing a CRIU checkpoint */
>>  	bool queues_paused;
>> @@ -1009,6 +1012,9 @@ struct kfd_process {
>>  
>>  	/* indicating whether this is a primary kfd_process */
>>  	bool primary;
>> +
>> +	/* The primary kfd_process allocating IDs for its secondary kfd_process, 0 for primary kfd_process */
>> +	struct ida id_table;
>>  };
>>  
>>  #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 440fde75d1e4..117e524f4fb3 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -54,6 +54,9 @@ DEFINE_MUTEX(kfd_processes_mutex);
>>  
>>  DEFINE_SRCU(kfd_processes_srcu);
>>  
>> +#define KFD_PROCESS_ID_MIN 1
>> +#define KFD_PROCESS_ID_WIDTH 16
>> +
>>  /* For process termination handling */
>>  static struct workqueue_struct *kfd_process_wq;
>>  
>> @@ -827,6 +830,7 @@ static void kfd_process_device_destroy_ib_mem(struct kfd_process_device *pdd)
>>  
>>  int kfd_create_process_sysfs(struct kfd_process *process)
>>  {
>> +	struct kfd_process *primary_process;
>>  	int ret;
>>  
>>  	if (process->kobj) {
>> @@ -839,9 +843,22 @@ int kfd_create_process_sysfs(struct kfd_process *process)
>>  		pr_warn("Creating procfs kobject failed");
>>  		return -ENOMEM;
>>  	}
>> -	ret = kobject_init_and_add(process->kobj, &procfs_type,
>> -				   procfs.kobj, "%d",
>> -				   (int)process->lead_thread->pid);
>> +
>> +	if (process->primary)
>> +		ret = kobject_init_and_add(process->kobj, &procfs_type,
>> +					   procfs.kobj, "%d",
>> +					   (int)process->lead_thread->pid);
>> +	else {
>> +		primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
>> +		if (!primary_process)
>> +			return -ESRCH;
>> +
>> +		ret = kobject_init_and_add(process->kobj, &procfs_type,
>> +					   primary_process->kobj, "context_%u",
>> +					   process->id);
>> +		kfd_unref_process(primary_process);
>> +	}
>> +
>>  	if (ret) {
>>  		pr_warn("Creating procfs pid directory failed");
>>  		kobject_put(process->kobj);
>> @@ -863,6 +880,51 @@ int kfd_create_process_sysfs(struct kfd_process *process)
>>  	return 0;
>>  }
>>  
>> +static int kfd_process_alloc_id(struct kfd_process *process)
>> +{
>> +	u16 ret;
>> +	struct kfd_process *primary_process;
>> +
>> +	if (process->primary) {
>> +		process->id = 0;
>> +
>> +		return 0;
>> +	}
>> +
>> +	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
>> +	if (!primary_process)
>> +		return -ESRCH;
>> +
>> +	ret = ida_alloc_range(&primary_process->id_table, KFD_PROCESS_ID_MIN,
>> +	     (1 << KFD_PROCESS_ID_WIDTH) - 1, GFP_KERNEL);
>> +	if (ret < 0)
> Ret is an unsigned type. It cannot be < 0. ida_alloc_range returns int. I'd recommend making ret an int as well.

Yes, will fix

>
>
>> +		goto out;
>> +
>> +	process->id = ret;
>> +	ret = 0;
>> +
>> +out:
>> +	kfd_unref_process(primary_process);
>> +
>> +	return ret;
>> +}
>> +
>> +static void kfd_process_free_id(struct kfd_process *process)
>> +{
>> +	struct kfd_process *primary_process;
>> +
>> +	if (process->primary)
>> +		return;
>> +
>> +	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
>> +	if (!primary_process)
>> +		return;
>> +
>> +	ida_free(&primary_process->id_table, process->id);
>> +
>> +	kfd_unref_process(primary_process);
>> +}
>> +
>>  struct kfd_process *kfd_create_process(struct task_struct *thread)
>>  {
>>  	struct kfd_process *process;
>> @@ -1193,6 +1255,11 @@ static void kfd_process_wq_release(struct work_struct *work)
>>  	if (ef)
>>  		dma_fence_signal(ef);
>>  
>> +	if (!p->primary)
>> +		kfd_process_free_id(p);
>> +	else
>> +		ida_destroy(&p->id_table);
>> +
>>  	kfd_process_remove_sysfs(p);
>>  	kfd_debugfs_remove_process(p);
>>  
>> @@ -1549,6 +1616,12 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
>>  	process->queues_paused = false;
>>  	process->primary = primary;
>>  
>> +	err = kfd_process_alloc_id(process);
>> +	if (err) {
>> +		pr_err("Creating kfd process: failed to alloc an id\n");
>> +		goto err_alloc_id;
>> +	}
>> +
>>  	INIT_DELAYED_WORK(&process->eviction_work, evict_process_worker);
>>  	INIT_DELAYED_WORK(&process->restore_work, restore_process_worker);
>>  	process->last_restore_timestamp = get_jiffies_64();
>> @@ -1599,6 +1672,8 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
>>  			goto err_register_notifier;
>>  		}
>>  		BUG_ON(mn != &process->mmu_notifier);
>> +
>> +		ida_init(&process->id_table);
> You should only init this for the primary process since you're only calling ida_destroy on the primary process.

The code has been truncated when generating the patch,
we only init the id_table for the primary kfd_process,
the complete piece of code is:  

        if (primary) {
                mn = mmu_notifier_get(&kfd_process_mmu_notifier_ops, process->mm);
                if (IS_ERR(mn)) {
                        err = PTR_ERR(mn);
                        goto err_register_notifier;
                }
                BUG_ON(mn != &process->mmu_notifier);

                ida_init(&process->id_table);
        }
 

Thanks!
Lingshan

>
> Regards,
>   Felix
>
>
>>  	}
>>  
>>  	kfd_unref_process(process);
>> @@ -1619,6 +1694,8 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
>>  err_process_pqm_init:
>>  	kfd_event_free_process(process);
>>  err_event_init:
>> +	kfd_process_free_id(process);
>> +err_alloc_id:
>>  	mutex_destroy(&process->mutex);
>>  	kfree(process);
>>  err_alloc_process:
--------------GqpicaxQOerNKYNoaew80d5T
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 8/2/2025 12:05 AM, Felix Kuehling wrote:</pre>
    <blockquote type="cite" cite="mid:5324e3ed-514c-443e-835e-3741d102fae6@amd.com">
      <pre wrap="" class="moz-quote-pre">
On 2025-08-01 4:55, Zhu Lingshan wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">This commit introduces a new id field for
struct kfd process, which helps identify
a kfd process among multiple contexts that
all belong to a single user space program.

The sysfs entry of a secondary kfd process
is placed under the sysfs entry folder of
its primary kfd process.

The naming format of the sysfs entry of a secondary
kfd process is &quot;context_%u&quot; where %u is the process id.

Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  6 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 83 +++++++++++++++++++++++-
 2 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index de701d72aa5c..a6e12c705734 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -995,6 +995,9 @@ struct kfd_process {
 	/* Tracks debug per-vmid request for debug flags */
 	u32 dbg_flags;
 
+	/* kfd process id */
+	u16 id;
+
 	atomic_t poison;
 	/* Queues are in paused stated because we are in the process of doing a CRIU checkpoint */
 	bool queues_paused;
@@ -1009,6 +1012,9 @@ struct kfd_process {
 
 	/* indicating whether this is a primary kfd_process */
 	bool primary;
+
+	/* The primary kfd_process allocating IDs for its secondary kfd_process, 0 for primary kfd_process */
+	struct ida id_table;
 };
 
 #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 440fde75d1e4..117e524f4fb3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -54,6 +54,9 @@ DEFINE_MUTEX(kfd_processes_mutex);
 
 DEFINE_SRCU(kfd_processes_srcu);
 
+#define KFD_PROCESS_ID_MIN 1
+#define KFD_PROCESS_ID_WIDTH 16
+
 /* For process termination handling */
 static struct workqueue_struct *kfd_process_wq;
 
@@ -827,6 +830,7 @@ static void kfd_process_device_destroy_ib_mem(struct kfd_process_device *pdd)
 
 int kfd_create_process_sysfs(struct kfd_process *process)
 {
+	struct kfd_process *primary_process;
 	int ret;
 
 	if (process-&gt;kobj) {
@@ -839,9 +843,22 @@ int kfd_create_process_sysfs(struct kfd_process *process)
 		pr_warn(&quot;Creating procfs kobject failed&quot;);
 		return -ENOMEM;
 	}
-	ret = kobject_init_and_add(process-&gt;kobj, &amp;procfs_type,
-				   procfs.kobj, &quot;%d&quot;,
-				   (int)process-&gt;lead_thread-&gt;pid);
+
+	if (process-&gt;primary)
+		ret = kobject_init_and_add(process-&gt;kobj, &amp;procfs_type,
+					   procfs.kobj, &quot;%d&quot;,
+					   (int)process-&gt;lead_thread-&gt;pid);
+	else {
+		primary_process = kfd_lookup_process_by_mm(process-&gt;lead_thread-&gt;mm);
+		if (!primary_process)
+			return -ESRCH;
+
+		ret = kobject_init_and_add(process-&gt;kobj, &amp;procfs_type,
+					   primary_process-&gt;kobj, &quot;context_%u&quot;,
+					   process-&gt;id);
+		kfd_unref_process(primary_process);
+	}
+
 	if (ret) {
 		pr_warn(&quot;Creating procfs pid directory failed&quot;);
 		kobject_put(process-&gt;kobj);
@@ -863,6 +880,51 @@ int kfd_create_process_sysfs(struct kfd_process *process)
 	return 0;
 }
 
+static int kfd_process_alloc_id(struct kfd_process *process)
+{
+	u16 ret;
+	struct kfd_process *primary_process;
+
+	if (process-&gt;primary) {
+		process-&gt;id = 0;
+
+		return 0;
+	}
+
+	primary_process = kfd_lookup_process_by_mm(process-&gt;lead_thread-&gt;mm);
+	if (!primary_process)
+		return -ESRCH;
+
+	ret = ida_alloc_range(&amp;primary_process-&gt;id_table, KFD_PROCESS_ID_MIN,
+	     (1 &lt;&lt; KFD_PROCESS_ID_WIDTH) - 1, GFP_KERNEL);
+	if (ret &lt; 0)
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Ret is an unsigned type. It cannot be &lt; 0. ida_alloc_range returns int. I'd recommend making ret an int as well.</pre>
    </blockquote>
    <pre>Yes, will fix</pre>
    <blockquote type="cite" cite="mid:5324e3ed-514c-443e-835e-3741d102fae6@amd.com">
      <pre wrap="" class="moz-quote-pre">


</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+		goto out;
+
+	process-&gt;id = ret;
+	ret = 0;
+
+out:
+	kfd_unref_process(primary_process);
+
+	return ret;
+}
+
+static void kfd_process_free_id(struct kfd_process *process)
+{
+	struct kfd_process *primary_process;
+
+	if (process-&gt;primary)
+		return;
+
+	primary_process = kfd_lookup_process_by_mm(process-&gt;lead_thread-&gt;mm);
+	if (!primary_process)
+		return;
+
+	ida_free(&amp;primary_process-&gt;id_table, process-&gt;id);
+
+	kfd_unref_process(primary_process);
+}
+
 struct kfd_process *kfd_create_process(struct task_struct *thread)
 {
 	struct kfd_process *process;
@@ -1193,6 +1255,11 @@ static void kfd_process_wq_release(struct work_struct *work)
 	if (ef)
 		dma_fence_signal(ef);
 
+	if (!p-&gt;primary)
+		kfd_process_free_id(p);
+	else
+		ida_destroy(&amp;p-&gt;id_table);
+
 	kfd_process_remove_sysfs(p);
 	kfd_debugfs_remove_process(p);
 
@@ -1549,6 +1616,12 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
 	process-&gt;queues_paused = false;
 	process-&gt;primary = primary;
 
+	err = kfd_process_alloc_id(process);
+	if (err) {
+		pr_err(&quot;Creating kfd process: failed to alloc an id\n&quot;);
+		goto err_alloc_id;
+	}
+
 	INIT_DELAYED_WORK(&amp;process-&gt;eviction_work, evict_process_worker);
 	INIT_DELAYED_WORK(&amp;process-&gt;restore_work, restore_process_worker);
 	process-&gt;last_restore_timestamp = get_jiffies_64();
@@ -1599,6 +1672,8 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
 			goto err_register_notifier;
 		}
 		BUG_ON(mn != &amp;process-&gt;mmu_notifier);
+
+		ida_init(&amp;process-&gt;id_table);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
You should only init this for the primary process since you're only calling ida_destroy on the primary process.</pre>
    </blockquote>
    <pre>The code has been truncated when generating the patch,
we only init the id_table for the primary kfd_process,
the complete piece of code is:  

        if (primary) {
                mn = mmu_notifier_get(&amp;kfd_process_mmu_notifier_ops, process-&gt;mm);
                if (IS_ERR(mn)) {
                        err = PTR_ERR(mn);
                        goto err_register_notifier;
                }
                BUG_ON(mn != &amp;process-&gt;mmu_notifier);

                ida_init(&amp;process-&gt;id_table);
        }
 

Thanks!
Lingshan</pre>
    <blockquote type="cite" cite="mid:5324e3ed-514c-443e-835e-3741d102fae6@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 	}
 
 	kfd_unref_process(process);
@@ -1619,6 +1694,8 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
 err_process_pqm_init:
 	kfd_event_free_process(process);
 err_event_init:
+	kfd_process_free_id(process);
+err_alloc_id:
 	mutex_destroy(&amp;process-&gt;mutex);
 	kfree(process);
 err_alloc_process:
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------GqpicaxQOerNKYNoaew80d5T--
