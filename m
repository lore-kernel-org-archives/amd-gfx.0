Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B26CCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 14:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1C9010EBD3;
	Fri, 31 Oct 2025 14:53:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TI/zDiyf";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013027.outbound.protection.outlook.com
 [40.93.201.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23AD710EBD5
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 14:53:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9SqckNWTTxjuJg9hpp4unltmQK1NvuF4k80SwfkFDJiHcyH/IjLi5/t6gOSp/p8iXJ8TlqQsN6iq21DkVotnS+zk9sOuUslbrggYp4KzQZ+oCxvJ2dQkCpNEldtOoxN/EoOOal1bJ/+8nUG5GJSKR8R6P8ieiul+9LV6zy8snaA53W7bn78QaMvmq/OSTj91aewLt0fXET4V/mpsU253mbtcN1qb27fw8bPGilvKg+nrKCAu7xbzpcU/ZvRsSxEERfcn1IXQeW1+KMyo+6CMtVfi66x22wi1dRsMCEI+FAFpGg/v3uJ/pKjxPlySUDyuSzHpeG9WfJIFljMd9587w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRMOTiX+E4QJBwe5+eWv6WrC193Tez2yAWo7tmSeiIg=;
 b=uAW17KETt3A4YwKARuCAYRjSAv94rhJhFW0UjLrjkgBHU8WgfiLiQrZrW0N7X7GUbuCGo3KQQ8HExrpSoQqm5hSzs0H+okTYd40n0HIhFbd49rT1wT/9QTzKObcu0nJnhYarfJpzuDN5lciFVSGxcwBSGVW3Y3jC5vnvlHSssNuxwe+BC6QyQpxsTrDUlkm79mgaFzdUAn1mXT6OYcENM7EvEcS/k+r3yLXqgNg7vQFt6a16CGnlAtT9ibkgch+RJDA90zENZQfieJQ+7wuS0cr47wuIwuz6enTpHV2nE5XTOXp5g6VFPlq5FHe5T3RvOjYfvZ136fxty8yWkEHejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRMOTiX+E4QJBwe5+eWv6WrC193Tez2yAWo7tmSeiIg=;
 b=TI/zDiyffBO65vU1xXLFhJcVSarm2MZni0qc8nVgFzD6yxvGiImnxhw++wwWdwVxZQc8+kXG0idogp73qIPz5KOUIHMyvgLg7Rh1FeTyro8kmlr7LMMF/bFmOb0EwyWQQ5+iHhW+3c1oO6xSQtbauW8tvH9BldgbLrM1gTLByKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 MN6PR12MB8515.namprd12.prod.outlook.com (2603:10b6:208:470::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 14:53:42 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 14:53:42 +0000
Message-ID: <79d6bc45-0415-4715-b651-65efec31d6df@amd.com>
Date: Fri, 31 Oct 2025 09:53:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Fix GPU mappings for APU after prefetch
To: Philip Yang <yangp@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Philip Yang <Philip.Yang@amd.com>
References: <20251030010027.2503555-1-Harish.Kasiviswanathan@amd.com>
 <CADnq5_MMZ+mE1=0aRRLE7dbfpndVOXL9UCODB7BeQg9QMyspJw@mail.gmail.com>
 <0c8c8f75-a4ab-d0c3-067f-cb389d7c61f1@amd.com>
 <67f96c31-e0e7-4e1c-9ea7-d77c8e345f8e@amd.com>
 <668f7ed1-8022-c706-875c-126ee2961cd7@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <668f7ed1-8022-c706-875c-126ee2961cd7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:806:f2::8) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|MN6PR12MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: b8abf44c-6f21-4925-000e-08de188d4860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjU4cU8rOTIvb1pkem55bkhqbE1uWFVhSlkrU0JKRlNZSWJVNWpzcktCRGR1?=
 =?utf-8?B?Y1ppdW9hVmNGZ3preGR6SytoQUlPS1FnQlNXOEs0cXJoVW1nVDFNdTZqeUpJ?=
 =?utf-8?B?ZFN1TTczZ2ljQlE3dHY5anRoZUFCdXRwQzY1S1UyejgvMFd3L2s0dDh4RWZZ?=
 =?utf-8?B?blNlVGFRWm04OXkzUjF1YWFjL0Nkd3I2aHZRMThzdlBjUWdEdFI3MkJsbkl3?=
 =?utf-8?B?Rm9uN1l5OW16cWllZDlaOFpJeWwvQ2dzbkZLUW1zSUNSTStuKzZYRExwek9S?=
 =?utf-8?B?VjlJL3d1QnFPWGVJaFd5NHNDbWVIMy9ud3NkQlFrWk9IQ3JDeUpMRWw5UExG?=
 =?utf-8?B?Q0l6OWp0NGxybTJLUGFXWjRRTWU1cXU3STZpK2tFNDNTS2dQQXJlcFNnUjkx?=
 =?utf-8?B?Z0gwOFN5TGFsU3RWZW0zQ0wxWUpYRFYzekpsMkZVaHpOU0VramxtbUtUZDR1?=
 =?utf-8?B?cko0TzM2dEJqNGlzSmpvd2Q0bk84RmZYM01CV3doa004aGJRZEZkUjAzTzJP?=
 =?utf-8?B?VkN1eHFKMlhLKzhVSnNPTEZRZWZOYkVneUtwSjZqMU1hOERDaEpBZHIvb25Z?=
 =?utf-8?B?cDdvRzlFcFdwbWZCR3ovd2tPZXBGRURDTTBaYVpXaHY2cG9NUmppL2QzejVs?=
 =?utf-8?B?MG5ITnJEdVJWd2VFUUpIcEVwN0gxRG91ajY3cXIydlRvaXI4WGJiR2NxMmlF?=
 =?utf-8?B?QVQyZVNmdTZGemlCMmtqekZxa24rUnRocHBQUjhSMG5pR1c4QU5WRk1PK1E5?=
 =?utf-8?B?YUpNNlhlZ0VsQmdEcTdrckVjS2FlMkNSN05ZRUoyNVFLb2RIZ1grU1dBOWlj?=
 =?utf-8?B?bFNrOUIwc0VYcEVERzFXWHZjUDg3eEh1blg4WnNxdVNHMk5CclFLMitpODdS?=
 =?utf-8?B?MTV2ZEdUdytidHFHQWgvc3FmRWRGVnVxbWMvQVozWlJ0cFZsT2VSL0JzTlBw?=
 =?utf-8?B?YWhCNVY0d0Z6ZSt2Z1dLT2svOGRWcmpveVlyckE2aGRxOUNydENCbk5aTk1I?=
 =?utf-8?B?L2VNVVdUdXVUREZmNXhtN2htVEJJMWdaSUdOdU8zN2JRR0Z6Sm5pYnRoMmV0?=
 =?utf-8?B?RXFmTis3SVBwVG10Ky9ScXg2T2VaWlpLdlVrVWUrcmhiQkJJZTRRUnVqVVR2?=
 =?utf-8?B?MDhMSHNqS1Y1U1ZVMjNlSVE5L21INUIzVWhwSHQ5Rk9kMHRySlJMdmxTVm1T?=
 =?utf-8?B?WGYvZ1NtZGRvaXVyUFdWNjZqM0VWTkVDcVVzMXR3UWtHRjdrUFZJR0Q4eUcx?=
 =?utf-8?B?anFJWUlUR0hyU0pLTE04S2FPSUVzTjVpUWptVzU3TG5wT2s5eWxGTnpOdHl2?=
 =?utf-8?B?ajJrWHk1S3Vic01NRFBBUGRDVmlzK2M4UDhucmN1RlhBNGpmZExCaVpjNDRE?=
 =?utf-8?B?YlJVRzZvRmVlcy9mdUE5d2psWWlleVppd0JiVHRkMXc0S3BJVXhCenVRaTlR?=
 =?utf-8?B?bWVXaTkzQjJhWEVMRHRTQm1kank5UDBpSkdJZXUxQUk1cDVVSExkbnVmVGVZ?=
 =?utf-8?B?TTZ0YW83SnkrUEVjdzVYV3AvYmhWLzhmRzdMdkpzSTV2SVpDclhXWHhXOUpn?=
 =?utf-8?B?emw4RGFnNlZ4V0oxalljV2RiSlpkcHFqcyszMnBLUmxJcUJ5Q3ZRVTlRV09k?=
 =?utf-8?B?Z3BwcGFuV2YrZDlzaUZqRXdJMURwbGx4aFBiWUhrdTZEZ3hZL0E5OG9Vcmlp?=
 =?utf-8?B?cU43NFZJRnFzcFJFZU1nZy9YQzlDZW5MUVE5WDBxeW53SFAraFJseXE1NUhj?=
 =?utf-8?B?dXVZNndGYk50WTkyUHIvZWRRYWhNSGxkTnZxZXJwM05oYmNTNUpib2RydStw?=
 =?utf-8?B?MG1XYjJnM2w0RVNPaVpiOENZSlVtMG5aNmFEUWtzdEd0VHdlYVNETFZ4U0xG?=
 =?utf-8?B?bExzWFI0cUZWOTNhWWN5MDBzS0RGVkxPNWdNY0J1YmtESkl1ZkFaTUhvbTNH?=
 =?utf-8?Q?MYEpsSCCXXHsmW3cPtcNdyMbzJWNu/rW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUhwSUxPZW02em5ER1FZTUV0cjhZZ3FvQ1RETmRLMmxuaGlOcWw5eUExK3Jq?=
 =?utf-8?B?V3draFRIRHJMY2JPT0l3VW1NOVJzbTlySlBxK1ROdVZudGpURmdhaHZQMnJV?=
 =?utf-8?B?dm4xYzYyM2VBUkNWVkoyR01wZkpqVFo2WS9jN1d3ZFgyTFh0cGhxczNpS3I2?=
 =?utf-8?B?cHN2YVJnVTRUN2ZQNnJTQWQ3Q0lZUTRHRWlWU1NhUDhBL1lxZS9ycU5SamJ4?=
 =?utf-8?B?ZHpid00xeGoyR0pnSFNnSGJ0MU9FYjNGeVBLeGhMc2F2ZlRSWVUzUjMySEVN?=
 =?utf-8?B?T1dzaStTbDc1R2hnWFFQaGJjdytNczJiSytVL3NTSmdHSHd5NGRzV1ZqS1ow?=
 =?utf-8?B?MjFzcG0vOFBlYjd5RUh4QVloZ1llSmsybFVFbTlkODh4aFgybFdFQWZDMHhC?=
 =?utf-8?B?aFhKcTlORmxXTjhVT3hERDAwemlVbzBESCtxZDZTNnlodGxvVlZNaU90UDVu?=
 =?utf-8?B?RlN3WTJKZHhxaTYvd055clR3OTJsWGRzeDhVOW9KbFdBbFRvcHE2VUxuYkhn?=
 =?utf-8?B?RWdCS1E2cVhaajBjSTA2M1B2a0JRWlBZbFMvNmk5NmJ6dGpXSVR4d1d6VDFl?=
 =?utf-8?B?RWdJMGVXR1UrUzB2SjNrdk5TK0FQT0dEK2l6QXJSeHkzbFlZWjRpSTN5cGJp?=
 =?utf-8?B?RTdOUzBrMVYrQTdNMGluaUpJYkdKdTlGNlJnRDB6OEtWUGc3ZWo1Zk5SU2lP?=
 =?utf-8?B?Rk1WNDVPRUliNFlmeUlMT1ZIaWJrYzhwa09Ca01FVFc2Z0Q1ck9kRDBiOEZp?=
 =?utf-8?B?UXBGekkva3FBTU54SHF3SkFmTzRWSmtaNUxrcE1BOGlwallRdSsvdGltZFM1?=
 =?utf-8?B?LzFveXZEYnluQWt0RGs0dWg2Z2R0cmhlNjZ4MUJ4UmNkVnpJTkU1U0lFMjQ1?=
 =?utf-8?B?cEtIN3BZUE96YXJKUVJ5QVdzbFFndDRITVl4ZDFyYkdrSmdIQ0VENUpmMmpn?=
 =?utf-8?B?TE40VkRDd2Fyci9DOFprRmJ2WlRydmM0WHIrT1pteFUxOEhOQ3JSYXM0Sk90?=
 =?utf-8?B?UEZkRmNrbWFXaHNkSUExelRiSXZ1RlNkMllVZ2lHby81OXFIYlFtNU9HWW5r?=
 =?utf-8?B?WGpkNk5xZjZhU3JPbkVlUElrTDV1N3Z3eWdtS2lUb1ZVcjR0NEhESVd6bGJu?=
 =?utf-8?B?bERYRkloczRxNWRRN1VTMXloNWd6UEZRbVpBT1hwWlBsWU5yQlpwejYzbCtW?=
 =?utf-8?B?RnpmVUlqdFZKN1RGaXovRk1VK08yM1p0Qk1LQlJ0WWVrSXBlRDloSUpiWFVl?=
 =?utf-8?B?Vkp6OW5oUVQyK2lsdTQzU0hOeVdaSE13OUdBcEFwQjkybkFOUUtJbzA4Qjh6?=
 =?utf-8?B?cXROMjE3MGZueEtQak1jUld3NTNkWUprMkVSZzV2dWRkbFd0VklIb0Q0SW1w?=
 =?utf-8?B?b0RYQWNZOHNkdy93Y2dXaExnMk0rWmdpM3V6S0RqeTN3aVNjRlVSeTNwTU5v?=
 =?utf-8?B?TFVoaEhRYnZ5NXE1MGR0eVJoSXNmMTZaZGpQZDBRcmluK0hTQjBVVFRLTWRH?=
 =?utf-8?B?NEdCZ3hHUy9Wa3pmbUYxSVR5N0lHaTJFLzY2cXllcVVvVjhMQ09paVF2b2Fk?=
 =?utf-8?B?Q3FKVG5nQmRWRDVPbzVlbHBETUdpdnFvazJqR0NxZk4zaVVyL3FZSUlLdkt1?=
 =?utf-8?B?TkdqdE1TY3kvN3MwcVBhMHBsUm56ckF5eXVXc1BjRGh6S2VaZmNnZ1ZqTkhh?=
 =?utf-8?B?ME93dmEzQUdvTmNYck42WkhHcjY1ekR2Q1BBYjlEQnB6SUNMUm1QcTBIS0ht?=
 =?utf-8?B?MVh4THRYS0RsN1BZT2tKOTN0TDVoeVZWRjVWb2lZci9yK3BDRURmeSsxQjFW?=
 =?utf-8?B?L1IxZVNKeVN6V09vT0t6aXFOZXBLdDVkSDUwYTU3UGFoWjJqT2JVNXB3ZFQy?=
 =?utf-8?B?azVFRmJ1dnVhRDVhWkhnYnUwaDIwdGxVVE5Pa3J2V3BUL3RGOEFNRjZYUmth?=
 =?utf-8?B?RVN5M0NWNGhORmtCZkxZMlU2Y3habmowd205OWNySzBsd2NtSno5WkJxKzVV?=
 =?utf-8?B?WHJmZzRTVHlpSEtrUlZpUEdiaitPak8zYWgxeGhJTzJXdlVaVGdSZUxHOVNV?=
 =?utf-8?B?SFo5aU5uL1VaTWM0Q2krMEtTcEhGc1ExclZrWHZLbEgzMVQvOUd3TXBtbXVr?=
 =?utf-8?Q?FtXU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8abf44c-6f21-4925-000e-08de188d4860
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 14:53:41.9752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g35vOSljUvgLQURQxxj6DeoXWJZwZTGQgG0/u1b3Ohyoad24b1XKg3+iiwz+t6ZB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8515
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


On 10/31/2025 8:41 AM, Philip Yang wrote:
>
> On 2025-10-30 18:12, Chen, Xiaogang wrote:
>>
>> On 10/30/2025 3:14 PM, Philip Yang wrote:
>>>
>>> On 2025-10-30 10:20, Alex Deucher wrote:
>>>> On Wed, Oct 29, 2025 at 9:36 PM Harish Kasiviswanathan
>>>> <Harish.Kasiviswanathan@amd.com> wrote:
>>>>> Fix the following corner case:-
>>>>>   Consider a 2M huge page SVM allocation, followed by prefetch 
>>>>> call for
>>>>> the first 4K page. The whole range is initially mapped with single 
>>>>> PTE.
>>>>> After the prefetch, this range gets split to first page + rest of the
>>>>> pages. Currently, the first page mapping is not updated on MI300A 
>>>>> (APU)
>>>>> since page hasn't migrated. However, after range split PTE mapping 
>>>>> it not
>>>>> valid.
>>>>>
>>>>> Fix this by forcing page table update for the whole range when 
>>>>> prefetch
>>>>> is called.  Calling prefetch on APU doesn't improve performance. 
>>>>> If all
>>>>> it deteriotes. However, functionality has to be supported.
>>>>>
>>>>> v2: Use apu_prefer_gtt as this issue doesn't apply to APUs with 
>>>>> carveout
>>>>> VRAM
>>>> apu_prefer_gtt is used by small APUs as well.  It depends on how much
>>>> VRAM vs GTT is available on the system.
>>>>
>>>>          if (adev->flags & AMD_IS_APU) {
>>>>                  if (adev->gmc.real_vram_size < gtt_size)
>>>>                          adev->apu_prefer_gtt = true;
>>>>          }
>>>
>>> yes, if apu_perfer_gtt is true, then no page migration because 
>>> best_prefetch_location is always CPU. For small APU, it will have 
>>> same issue if KFD is used, prefetch split range page table not 
>>> updated because no migration. This patch can fix the issue on both 
>>> small APU and APP APU.
>>>
>>> Reviewed-by: Philip Yang<Philip.Yang@amd.com>
>>
>> Is the case like that: the svm range got split; the pages are not 
>> migrated and attributes for the pages are not changed. Then why need 
>> update pte as page physical locations and attributes are not changed? 
>> Basically it used huge page pte, now you split the pte into smaller 
>> ranges. Or I misunderstood the scenario?
>
> yes, the range mapped as huge page, use 2MB PDE entry as PTE, after 
> spliting, the tail range mapping update, not 2MB alignment huge page, 
> alloc pt bo for PDE entry, then tail PTEs updated, the head PTEs is 
> invalid entry.
>
My concern is that since it is APU no page got migrated and access 
attributes are not changes, just svm range got split. Then neither tail 
or head sub-range would get mapping updated: the original 2MB PTE 
mapping can still be used for both sub-ranges that gives better 
performance. This patch spoil 2MB PTE vm mapping that is not necessary 
for APU.

Regards

Xiaogang

> Regards,
>
> Philip
>
>>
>> Regards
>>
>> Xiaogang
>>
>>>
>>>> Alex
>>>>
>>>>> Suggested-by: Philip Yang <Philip.Yang@amd.com>
>>>>> Signed-off-by: Harish Kasiviswanathan 
>>>>> <Harish.Kasiviswanathan@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 +++++++
>>>>>   1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> index c30dfb8ec236..76cab1c8aaa2 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> @@ -766,14 +766,21 @@ svm_range_apply_attrs(struct kfd_process *p, 
>>>>> struct svm_range *prange,
>>>>>   {
>>>>>          uint32_t i;
>>>>>          int gpuidx;
>>>>> +       struct kfd_node *node;
>>>>>
>>>>>          for (i = 0; i < nattr; i++) {
>>>>>                  switch (attrs[i].type) {
>>>>>                  case KFD_IOCTL_SVM_ATTR_PREFERRED_LOC:
>>>>>                          prange->preferred_loc = attrs[i].value;
>>>>> +                       node = svm_range_get_node_by_id(prange, 
>>>>> attrs[i].value);
>>>>> +                       if (node && node->adev->apu_prefer_gtt && 
>>>>> !p->xnack_enabled)
>>>>> +                               *update_mapping = true;
>>>>>                          break;
>>>>>                  case KFD_IOCTL_SVM_ATTR_PREFETCH_LOC:
>>>>>                          prange->prefetch_loc = attrs[i].value;
>>>>> +                       node = svm_range_get_node_by_id(prange, 
>>>>> attrs[i].value);
>>>>> +                       if (node && node->adev->apu_prefer_gtt && 
>>>>> !p->xnack_enabled)
>>>>> +                               *update_mapping = true;
>>>>>                          break;
>>>>>                  case KFD_IOCTL_SVM_ATTR_ACCESS:
>>>>>                  case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
>>>>> -- 
>>>>> 2.34.1
>>>>>
