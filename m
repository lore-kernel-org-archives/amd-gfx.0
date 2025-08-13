Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B53EC87FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 13:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24F3410E724;
	Wed, 13 Aug 2025 13:55:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gRJ/UnF4";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9E5E10E724
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 13:55:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyiflOHGHLvzTERCKbfSQ+mn8a1odPZLSqaI4CA+trEP1JqFERv35zjXSkiTLl/sPIvxLhuswqrbPIjfJoCo5NJpqhl7zkUAjygEYh/YcB49JpmhYKv4/FiCpfvhDKteedjJLZDGW15yDqgwsapw5HV2UTZmqQod5uD4HZ1DQnkmIhcwhWbwF7TpxoyHftucUnYUUpamVtIow/1KF/6qn0erkIC7+1RvlJkde30K3E+ifieFzsaqz6R7r291ftiaBEUYawcVwfFzqcZGAV7hTrPHJeV+pghHBV+qggd9dCUdD0ZVYit1YzL72mpo7Y1gc4nwTIbq1WPEkjY02f15Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hw0XjfPisB3xISdlDEV6EaYChezvQGt/QWuc6Z+ZV2U=;
 b=cp6TlPYSIL5JUhmUyKm7Ak7GfGXBXokdLIjuqY2ud2KFJ7Atv7RTTZNwEPdOTtNEvo72ziFUF85dNYDuBF5a6msvf3cJObbRgKz30GbdKo3K53u45gIWRlc7f47lq4mtzjYUi5hwFsFdyIveJp5HEkLDdXCE9YZ8aI4Lc3i9y9TmIDveUqaUM3aebFL0kWT4czb5+NFnupiAZLHPj9djiWiiKUKcEGlQUhl02JPy7hscxD1DHUwYZ3IJ3TPlhTwVweQlILTN2IOiOd8AJdk1lzo1vxMTYlx1zNgYCwwFl0Y3z1djZUcU5SQ2FoC5BQ4GfpOPwquYHhL78FPN9u9PSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hw0XjfPisB3xISdlDEV6EaYChezvQGt/QWuc6Z+ZV2U=;
 b=gRJ/UnF4hBJK7zUCSdgiAbEoYU/ppBtlcJMsK+sfmkI+tLBED/JjHSQPrO2ob9dfkPPNvN2vsqhv8XkXHkQgBFgWyIv7WHvr2/pq3olvV4P/F9+o14o+1S95tvI3kkuVWCKn1CEMx9NoL9dsRkJJxahGETMDZrBnwVeZVZEyHm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 13:55:28 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%4]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 13:55:28 +0000
Message-ID: <bb315859-fd69-40a6-7efb-e9647261ea41@amd.com>
Date: Wed, 13 Aug 2025 19:25:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v2)
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, David Wu <davidwu2@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250812205816.1773798-1-alexander.deucher@amd.com>
 <c01c5980-70f5-474d-8173-c6be93b1c21c@amd.com>
 <CADnq5_NSvatcrG8qJL_be1e2XRqKiCZd0PdcWdDbxYxK6qMNug@mail.gmail.com>
From: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
In-Reply-To: <CADnq5_NSvatcrG8qJL_be1e2XRqKiCZd0PdcWdDbxYxK6qMNug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::24) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|SA3PR12MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a8a371-8ec7-4d35-fa21-08ddda710f1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjNWV3NiRi91UVZ2QTZ6RjNFanBBbXVyeGJ3aE1OeXFxaDRBaVUrWnJCOHNM?=
 =?utf-8?B?Ykt6L252cTE2UDhVdjQ1ZER1K0NEVnVhOFpRdlY3aitmWlFHOFNsSkg4UHBD?=
 =?utf-8?B?amhHNEU5L09RTmdSZjNOcFBNQVlDQndEdG1tWU5JSUZaNCs1Nkd4MU9ZRmJx?=
 =?utf-8?B?K0Fsd2IzcWhPK3JRem5kVXJRU3I0dzdmTGJhVzI3MENMMlp4OFFZdU1OclJw?=
 =?utf-8?B?eTEzeXljam13SU45K2QydklwZG50UHNVaGRtczg3emgzTWQwclMzbVBVOUlV?=
 =?utf-8?B?WTY0VFprN01zZDFYQjEwYlZ5TWlVZnBNTTdXZ0g3NmI4RjBQL3lxSkhURlFK?=
 =?utf-8?B?eWpNam12L3FOT0pmNXc1am9UQkVsbmRsbHhzSHFLc1FtVnB6U3pFK3lNbFJR?=
 =?utf-8?B?Z2oyblBIRlMzbG52UHJvZ2tNZVRsbHBtSlNLV01qLzIvaXdlMHFwTnFDeVlM?=
 =?utf-8?B?ZDdHK0N3TFh1bWpLRVFiZk5aSTZ0TlFMbTJQb0VUT2hqYndvRzBKOFFzTXhZ?=
 =?utf-8?B?NjBKejlJVTJjekxORzByRGxTRVAwMWtjS0lGOUhPOS96YWFLa1VVU2NSY3Yv?=
 =?utf-8?B?RHo3S1R6bEt4VE5SRnJ4cDN3UWRYZW5ZZVl4YjdhK0txZVBIVFdocHpjS3FE?=
 =?utf-8?B?NmZFMUpGWit5c2x2U3JWcHpvR3locCtRdllpdmQrajhqWVNqQmY2c2RPOVhV?=
 =?utf-8?B?eHBKR3VqMnA5cXRBOGQzNG5QU3VkYnJJMHlQUjh3UzRiMlhRNktVQVlrRmxR?=
 =?utf-8?B?biszL0VZSnczUkdTMlZBb2UxTmRpa2d2ZDlkQ0FmNHBtOXQwWHIrNFUxUW12?=
 =?utf-8?B?Z0xpSzh6eFl5ejJkTSs5em1xUFNrNnQ0TzAxekp3N0dSbTM1cEU4cFNtQmNh?=
 =?utf-8?B?UlhTNVFyWEsrRVFVTTdyZHNNbVlzSDg3V3hTMmpLbnJsUk05VHlBcVZqRi9v?=
 =?utf-8?B?ZEZvMkRXMCtSU1BiaHl1T1hpRWh1a2hoaWVxR0pWSU1HRktHTkVUOUxJUWg4?=
 =?utf-8?B?enhId1l4MUpMZEplUzV0MndodlRRcmlSNmExb2o2VnhiOXp1dkcxdzhqcTdp?=
 =?utf-8?B?NUxoYjJTZXlhd1RUeVhJTkEwUFRLZnFGano2dUhROGNUaXhmY2NIcGJoQWZI?=
 =?utf-8?B?eGJLRFpVK0hZcGswZGVpbjB1WHdWVHlBMWwzai9TNlhtc1J4dkJHZkJSak5o?=
 =?utf-8?B?SjdkSmtGeG85aldGeW1uM2M3VWNtc3U1b2htTHJoRlFhcnhpNDAvUk8veDQx?=
 =?utf-8?B?VUdlbm9lbWl3d3BHWitGdmRQMlRkNTBBdldnNDBiazFFTFozeUN6U0JrdXNQ?=
 =?utf-8?B?U2JFNHBBMU8zN0NKelpFcXBMSUlDYnV1QmorR3VzN0hVbWRmWVRiaE9UajFo?=
 =?utf-8?B?dWs2QmM3bnZQSzVEMFZ5elBtenZMZmtySnZYVGRabjEwWHhxeC9xMnRoS09H?=
 =?utf-8?B?NE9wdnBtVVAyalV0b3NXNkVZdjlJSE55bzdqSmx1YmR5NlBRa3VoaWZmc20w?=
 =?utf-8?B?STBOWFM3WWh4K25RdEY2YTV3R0ZLaEp4Uy9Cb2tKUDBYUVREUlpkdXVFQTQ3?=
 =?utf-8?B?ZmVBVVZIWXQwNzBoMUJXYndLR1VyMkN0VHJyNU9EZFk5anpRYVVLcnNHcE5h?=
 =?utf-8?B?L0xjSzNYK2VjRTRyeWcwZFhWTHIrbEZvVjZYYTUxWVNDT2cyb3B0ejBOWUg3?=
 =?utf-8?B?Mndrd3BBUTB3OVpvOTlVL0ZCL2pqSnFvS1hyNTRpNmdXOE4rcmpmZ2pTZEt1?=
 =?utf-8?B?dUJIZlN4S00wMTFlWkloc254bkk0azUzY1JOSkE0TGRIcCs3SWdGaDJnbXRD?=
 =?utf-8?B?Z0RXLzd5YjdYVFZoMUpkeGpDRk1EN3o1bkxDdXY5TkRTaTJoVmhKU2c4U2pG?=
 =?utf-8?B?OGgzM2hjWkt0blFCV3NUZU96YjlMZkVzQ2R2ZDk4RnduSU1PTkpQazVZNnk1?=
 =?utf-8?Q?s0fymMGKpcQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU1vcTdjbmdaYnR3cFF0OE1vZktXeUZxendqRWFQK2pXMXFsd0l6c2VYaDlD?=
 =?utf-8?B?dUdJc0daQUpZMU1hSG9TdnJtazdZVUZjakRXWWczUnZTMGZEaWdjQnluUWpS?=
 =?utf-8?B?aGVKek1hdjRPY21QdHF4UDNKUC9HbW44WlYrRjFsZjFMaFFHQTI4alkvMlpW?=
 =?utf-8?B?ZllCa29JdmZtcVBFNjkrWmJBSFRiQVpnZDB4NnZtSTZNRDc2NklqeVNLQWpX?=
 =?utf-8?B?cGdWLzdaaFVIblc1dlVYOHpIaEliQk1mc1NVc1E0NXkzcndsaTJMT29WYWRM?=
 =?utf-8?B?aTVoVlQ1MS9TaEwyNnRsZVNBdTJkQ3RVZXhienhmZVArUHNJWXMwWFJUTEgv?=
 =?utf-8?B?OWdlQ0hIN3kxUlN1SUIxdUJoR1BNOTIzN0FON2h6WTE1eGoxb2ZNTGVQV1pB?=
 =?utf-8?B?Nk9TbjZ5NWppSGRjcnZaZFQ0YXNRUlc1Snd1c05SOHc0RTBFMnQ4L0Qwam5h?=
 =?utf-8?B?a2ZvaFhlb05TSWlCZi9Kckx2UCt3Ymg3ZXkyRXNWVDAwdk5HUWsrelhOMEJy?=
 =?utf-8?B?eEdyN2ZsY0NQSjBmczkvNzlLdStwb1FlamdaMUdqK0g5UXNpY2Q4alpCaEcw?=
 =?utf-8?B?WFBZbytNTU83dXhtVGdaWFRPcEFzMCtvSk56K1dJc2tVY1hXdVFrQmJhUmNi?=
 =?utf-8?B?YjZZMkQxaklkZlY1LzZuR2N0NFprVkkvM0l1MnhLbDl3R3RUamNuZnBKS1Iy?=
 =?utf-8?B?cG1GODRFeEpvTG51SFdnZlUwZWx3aVlOclE4d3dWaXNsbHFxa0hjeVQ5WHc1?=
 =?utf-8?B?dWZYellKZGJiMnEzeitkZjRIRnNEbXRPdGUxU3JKMWNBNDFWYUJTc05GTVR5?=
 =?utf-8?B?SFE5NzFJRXk5dy9sYkFySXA1eXF6REowd3RWVzdHSzVNK3lCT1MvRmpCbHFB?=
 =?utf-8?B?WXAxUDB4QkFYamk2TW5IdUIwcURRVUZKci9WQmFPVGpSa1hJaDVVTUhtb1Uv?=
 =?utf-8?B?OTR2ZjNSWnYxMzhCNWVkOVNvZXFlT3ZhTGFWWVk0Ty9xK04wOGZIZENuTWRP?=
 =?utf-8?B?Q0pGdHdrVWdwWU94M1ZpeEwvRXlOd2JZeER5VzYzZFluWGp0cGJMWXdDVnRG?=
 =?utf-8?B?cENzbHZnMTR4Ti9RRkJoeXoxNitPSVIvUmdncHFlRy9Pa2lIV2tZUUcyU3hS?=
 =?utf-8?B?VkN5K3I5ZHRtMGxVclIxekNXekJlVGtyVld0Z1FPZlBZdFBvQ3NQRmpSWnhw?=
 =?utf-8?B?cTU1cVpYUXF3dVE0L0M3eHJvU2JuSWRRM2UzdlJJTXV2WFR4Q1MwQUNYU2Zr?=
 =?utf-8?B?bThLUVVCRXFVT3EwSEx0MUpJbXNvMGdZblIzWDNVN3ExdWV3dlJHSDZjWXIx?=
 =?utf-8?B?Vlp1cGpXRVRGYW1Dc2E4N0xyNVRzTFZkcmtBdjlENGVMQ1JGYjhhS1AzSjFY?=
 =?utf-8?B?K3plZWh3cEY1V0kyd0NObWVHYzVKeUUxZVFhbW42LzM3b2lFNzZmaHpTTVNh?=
 =?utf-8?B?WWplWUd2SkR3SkU1eTBTdU1DZ2xqV1BoZGNUc1hZdVBVVDE4VEszZDBHZnEy?=
 =?utf-8?B?TGppalBHOE0wdHFjVThRemFvYlhFTXBELzhyRTNpK3VCWVV3TUJyL0dSaDRS?=
 =?utf-8?B?ckExYmE4NnlINVhhR1I3cjM5UDJRU2NFQjVOWmlXMkxZNDY1cXRhN0hNcVJB?=
 =?utf-8?B?bjRDSU8xZHRmM2NGa2Q5eEZzMFluYVROMzZmM0RneHVPb2NucjYvUkl0cVVZ?=
 =?utf-8?B?aVVoWUx4cUl2cnVldmJ3UTVlSHBQNVFWd09UWXY1TFVjRVNHMWVyQXlTdXFE?=
 =?utf-8?B?R3pWejlIeXppdHlSSHFTdjNpSHg0NHdmRzBGaUllcWROL0lhQVlxalRUVEVW?=
 =?utf-8?B?WWk4NU1vYk9TUnp6N0kwTVdEMmd0NEsrUVBPTWxvUVZxU2hEVTI2c0QvaDVI?=
 =?utf-8?B?VzRKZkZlZ3R6R2FiNGRVN2NWbSs1eE5BWk9UWnY1QnVmYk1Pd0N4cmEvUEZw?=
 =?utf-8?B?MllET0NIVXJGTnRrbzB0MURjcjIvRGZ5YTBWZVVSUk4vU3U5L1lmOU5IRVY2?=
 =?utf-8?B?RjR1YTFoczlyMS8wMnpoNU1uYXRMLzVwUnhER3B5MVhFRVNTeTB4UmliYkM2?=
 =?utf-8?B?UjVKenA3U0xCd1MyeDRLb1BPR0pUUHhqczZybmFBcktyVFNwQU5QWmFzVzJs?=
 =?utf-8?Q?sjo1Pwn3siqAKPjm3yoROAKI0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a8a371-8ec7-4d35-fa21-08ddda710f1e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 13:55:27.9619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cYjyfayG0BRcNcRuAzF5hpCv+gtB4JNXd+Opj+l4d3lYeClIQMOQEKGHEa4gmX/IWmbPcwfXjlRBPwY9k1xAnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973
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


On 8/13/2025 7:15 PM, Alex Deucher wrote:
> On Tue, Aug 12, 2025 at 7:08 PM David Wu <davidwu2@amd.com> wrote:
>> Hi Alex,
>>
>> still have a concern - the fence or submission_cnt could increase in
>> begin_use but idle handler
>> has finished counting it (as 0) so it could also power off vcn.
> Ok, I think that is possible.  Will send an updated patch to handle
> that case as well.

cancel_delayed_work_sync(&vcn_inst->idle_work) at the top of begin_use 
covers this situation.

So there is no idle handler for this instance anymore after this call 
completes, but the additional checks are okay to have.

Regards,

Sathish

>
> Alex
>
>> David
>>
>> On 2025-08-12 16:58, Alex Deucher wrote:
>>> If there are multiple instances of the VCN running,
>>> we may end up switching the video profile while another
>>> instance is active because we only take into account
>>> the current instance's submissions.  Look at all
>>> outstanding fences for the video profile.
>>>
>>> v2: drop early exit in begin_use()
>>>
>>> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile handling")
>>> Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com> (v1)
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 37 ++++++++++++-------------
>>>    1 file changed, 17 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> index 9a76e11d1c184..fd127e9461c89 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>> @@ -415,19 +415,25 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>        struct amdgpu_vcn_inst *vcn_inst =
>>>                container_of(work, struct amdgpu_vcn_inst, idle_work.work);
>>>        struct amdgpu_device *adev = vcn_inst->adev;
>>> -     unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>> -     unsigned int i = vcn_inst->inst, j;
>>> +     unsigned int total_fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>> +     unsigned int i, j;
>>>        int r = 0;
>>>
>>> -     if (adev->vcn.harvest_config & (1 << i))
>>> +     if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
>>>                return;
>>>
>>> -     for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>>> -             fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>>> +     for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>> +             struct amdgpu_vcn_inst *v = &adev->vcn.inst[i];
>>> +
>>> +             for (j = 0; j < v->num_enc_rings; ++j)
>>> +                     fence[i] += amdgpu_fence_count_emitted(&v->ring_enc[j]);
>>> +             fence[i] += amdgpu_fence_count_emitted(&v->ring_dec);
>>> +             total_fences += fence[i];
>>> +     }
>>>
>>>        /* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
>>>        if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
>>> -         !adev->vcn.inst[i].using_unified_queue) {
>>> +         !vcn_inst->using_unified_queue) {
>>>                struct dpg_pause_state new_state;
>>>
>>>                if (fence[i] ||
>>> @@ -436,18 +442,17 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>                else
>>>                        new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>>>
>>> -             adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
>>> +             vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
>>>        }
>>>
>>> -     fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
>>> -     fences += fence[i];
>>> -
>>> -     if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>>> +     if (!fence[vcn_inst->inst] && !atomic_read(&vcn_inst->total_submission_cnt)) {
>>> +             /* This is specific to this instance */
>>>                mutex_lock(&vcn_inst->vcn_pg_lock);
>>>                vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>>>                mutex_unlock(&vcn_inst->vcn_pg_lock);
>>>                mutex_lock(&adev->vcn.workload_profile_mutex);
>>> -             if (adev->vcn.workload_profile_active) {
>>> +             /* This is global and depends on all VCN instances */
>>> +             if (adev->vcn.workload_profile_active && !total_fences) {
>>>                        r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>>>                                                            false);
>>>                        if (r)
>>> @@ -470,13 +475,6 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>>>
>>>        cancel_delayed_work_sync(&vcn_inst->idle_work);
>>>
>>> -     /* We can safely return early here because we've cancelled the
>>> -      * the delayed work so there is no one else to set it to false
>>> -      * and we don't care if someone else sets it to true.
>>> -      */
>>> -     if (adev->vcn.workload_profile_active)
>>> -             goto pg_lock;
>>> -
>>>        mutex_lock(&adev->vcn.workload_profile_mutex);
>>>        if (!adev->vcn.workload_profile_active) {
>>>                r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>>> @@ -487,7 +485,6 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>>>        }
>>>        mutex_unlock(&adev->vcn.workload_profile_mutex);
>>>
>>> -pg_lock:
>>>        mutex_lock(&vcn_inst->vcn_pg_lock);
>>>        vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>>>
