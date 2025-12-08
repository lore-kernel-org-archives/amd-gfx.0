Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E37D3B7DE
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 11:56:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF11C10E136;
	Mon,  8 Dec 2025 11:56:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PBVHdiUt";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012051.outbound.protection.outlook.com
 [40.107.200.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3E9F10E136
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 11:56:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+7tVtc4wOF+RY2RmpAues+o/ihlSdEH5IjJ929WeNlG6vdhrU8YixhmpNqw8jJabX/hyFzxBKTsp2VUJjhEqmbqqFXAhVnOFS607HI3IM82sWVBnmJhqVDt62q3VQqzeZ8IXED54BrmgcFttS2olC2fB5J0Lv9J3GhrTCiwl5gnOCuUjs5CPN+bRIMHo4vA2GrsCNWM919ORZDCppHUaM3SWch2fhZVv8qAuA3o/hqupRBuY0mMCETASq7HFsiEnhrvTLlli+JMIeFpV1HQaoWua0T5f0Fl96WaKvyNjVGK2jSbIRtGkyGwl8ttz8g+TkDN5qi31TtJrs0qcxZhhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0M2/JR+wvrq8+s4U48bGjyzlbkQZnYe5qaCvC8OIUI=;
 b=iINc7lffj+CJv7XulObDx2Kcj2kGh5VeIi9kioUykPqbvJ3tRJ3bS/NuHy/l5jAa11i/t2HudrWwCI8TF0LseFyOHm7NKm5f931qGANx4uuoH0qu7VyDMVoiEtMfGB/uqsQ1m8T3ZHuaduKPk8GN5pGmpVq0rrvvdxdiAtoObgMLqSS2WSNTQIqUlEeLWpRMaJZV39RHx8It+oUapTFC2gguHH+ZTb10v+FzNw2d4UtZ4lJ3QDvLfH+UEnLHtK3u8JSLyw75g42eEWfI1Axct22kkPDYfLUVzDPfiaSdE1Zv9z3h0y33G2ARGSiLLsE4qYerLfBMZsOaqtoPeEs4iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0M2/JR+wvrq8+s4U48bGjyzlbkQZnYe5qaCvC8OIUI=;
 b=PBVHdiUtEEDpXrlsc+/BLwKNVaDbarDs2vDB12fr80qVrLjxZmgybT83jzJpwOlU3R+PPBYBuI1Q0YeADaXQS+L6QUp+d0LYldmg7wZ6X+Ufy5slQFErYiLk5ovOX5GLmaAEZqhFOriLu+Znz2mO/3God3QUcJdoWQI24EpjkYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA0PR12MB8864.namprd12.prod.outlook.com (2603:10b6:208:485::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Mon, 8 Dec
 2025 11:56:08 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 11:56:08 +0000
Message-ID: <a17f7e36-2e06-4b0e-95f2-d2ca76bd45c1@amd.com>
Date: Mon, 8 Dec 2025 17:26:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: fix mes packet params issue when flush hdp.
To: chong li <chongli2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: emily.deng@amd.com
References: <20251208111655.1396987-1-chongli2@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251208111655.1396987-1-chongli2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0205.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA0PR12MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c3b7f8-e70c-45c8-d89b-08de3650c5c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bG5uK1BESkluN1FhenBsbVRtdlh2amNvWGpZNDJxS0I4Nm85RWF1SzFFYk9l?=
 =?utf-8?B?aGxFdG90azN1VEhKdzFWNEEyV2M4SlZsY0pMM0tMSUZMMDloK3lRTXAzazlD?=
 =?utf-8?B?dEE5emJBMTNsSlN3RzJRUFM0TURncWFYWTBreXZ4RWswOWQ4SU1oSE5nT0pj?=
 =?utf-8?B?T2U0aXpBc3NCUG9VSzRjL0lXM3lrUkx1alNkejNSZXhhVDRRbmRZcjd3K2FT?=
 =?utf-8?B?Z2wwN3kzaXFQNWdwcHlxZTVsSS8xS2s2bnRCandiM0lhMUJ1WHVtaVlLeVAv?=
 =?utf-8?B?b3A5dGJkWjJHSkkxYW84ODhZMkx6a1VscWpVVzVVMmgzN2JyZ0Rsck9OYWlG?=
 =?utf-8?B?MWpjWjlhRDhHRjEwczJseWVCMUhJdktpblQ3QlVoNlZDcHlDWTRxTWo5NG1G?=
 =?utf-8?B?WmxRdUNuelV5TkRiZ3hxdVRiSk9xRXdFNGw1M0NRMTZPV3lUblFrNXZIOTVy?=
 =?utf-8?B?NU12bGFoSDBDTFMxUUtEN1ZWc1VVZm15cVVaR2ovUkg0ZW5nUWZEYzNmMmZo?=
 =?utf-8?B?THQ3VkZWU00ybnZLR0lPS3RVWjJQdk1YTTBFUWgycVVVUHNSejFobktTVm9V?=
 =?utf-8?B?bEtjL3Q1aGIvSWtmM2Naa3BYakdtY0Ryd01YWS9nUXBNUGhRbzZ3TnNISC82?=
 =?utf-8?B?TlZEbXZybnpONmtUZnJCelFTUjJYZzNqRHA2djZyL2w1MlVzclpYV3psU2VG?=
 =?utf-8?B?ZTYrMDR4VWRZMklhREovYnVHTnJvUXkyM3labXlLMTJzNDdYZzV6dVB1RTBu?=
 =?utf-8?B?N0w5SVdpR2lTY2NWRGNIR3BrZTl5MXBSdkVsSDVGMHlGZ21zL3Z3YkpCL2ZN?=
 =?utf-8?B?cWNwbDMxWWgra1ZVdS96aGRsajJ5b3g0eVFTcCtNeE90ajlweU5NaG5nQzYr?=
 =?utf-8?B?NUNPMnIySklMNEtJTVZXcHVYOUplOG5zZmg4c2pPZDBlMWV6Q3RIRXRrQk83?=
 =?utf-8?B?NjRWeTZBa0g2NFBPekRxdEpnWkQ5WE9ad0NCc0tlZ3lFbWVlY041c1BadGdj?=
 =?utf-8?B?U3JndWhOMzJEMURpSUJUYzlvZDBhV1hJOWo2dmJKV3B3OFJzR001SHJGWDlr?=
 =?utf-8?B?RDhFUVpXa1pkM3BjRllrdHFsRkd6VGg5NUZFWkFESFczcFpzaGdlbWJpOWdP?=
 =?utf-8?B?b3lMTkhFdjJHQW44WVJZalIvSDNCYXRsamhEYktZUUQ5RXVpd3NzRVd1U0xv?=
 =?utf-8?B?Ulk3VjhFK3UwVnorQmszS284UmpPellpNlFsQm13cnVWOFRhTlMxUmR1WWhF?=
 =?utf-8?B?SUhUZ3ZORzVTUFI1eVVuL3hzQjF6VXY3cCtSZkszV2J3L2xrYzNFSkordTdI?=
 =?utf-8?B?bndITytlOHB6QWRXZnQyV0tKU0o3UmV4QnhpWXR5QzVNc1NYVkVtTXh6blVy?=
 =?utf-8?B?U0FvVkhxLzZ3MC9YRG9KRnlvS1VLOVJkVHJCalo3TXJKVFBsTXhoaVRuWFA4?=
 =?utf-8?B?ZjhWVHdRUmFBMnFPaGZwNkJLbEhWekhwT1RpZ3VSQjkrU3dxbVhhYm5tRHRR?=
 =?utf-8?B?UmtWeThXaUlJWGpNc2VsSDV0dEF1ZWZyTmhLclZIYytkSVJJcHNDWExoOXZY?=
 =?utf-8?B?elFyZmtkdTlYYlB6bWZwQmdmbDRvcUtEUlpOcytJYkc3T2VjQmhWYWZLQnpN?=
 =?utf-8?B?em5OMWgyRDMxdDNhSUxkSlRDZFpHZUh5MHUrR3NzV0lFcHl0ckZONUs4Nlgv?=
 =?utf-8?B?b2Y2MGMyRHZQUHl0ZmFYQitENlVtVlZLTFZlOTAyV1RZWlpvMlJsbDM4N0xi?=
 =?utf-8?B?WGJCMDhoazRFcnFEYmh2NEl0WThzWE9SdlMwSDFqT0JUb2ZZYzkxa09UMlBP?=
 =?utf-8?B?UStodnl1TTd6ZC9wUk9DeThqQkVzcW8yVzZLb3NuREkwMTRVM1pHOGZoczMv?=
 =?utf-8?B?dGQzSEthYzJWdWZXTmFDcmowUElPTGxyK1ErTlN0OE1hTnlzMTI4ZnFkTC9j?=
 =?utf-8?Q?+Otprb+Dc330nk7eLOCImIqAw2+Uy9P3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkVydW9UK1VSa3lmQnZnLzdLUmtrSFY1eHgyMjZKODBUTWJIay9Td0hlUUU5?=
 =?utf-8?B?YjBDRDkrK09lY0xrOGtvMkxtbVdzRTZwcHVJSXNiVXRlNWtFS3A1anMyWjdY?=
 =?utf-8?B?Nm1LcEFLSGJlZWtqQVNud0F5cm1FOHRxaGt0K2ZvcGlNNE9JaW1oNjg0cTNY?=
 =?utf-8?B?bWM4dm5pQ1R6SEpTcTJwZmswdHdJTCsyUk5HMisrcWpKYWtpbW1tWXhDYlBP?=
 =?utf-8?B?Q1hDa0pMNnNROGV4SGkzdjRKaE4zSDJPbWxML0JsUmZyZWlNMldHWi9QOUUx?=
 =?utf-8?B?a2h0N3hkTGkyd3pYYm1MSHVMTEhMUkNzWS9Fd09Xdjdqc1hiNlZjZnVVaVda?=
 =?utf-8?B?bk42QlpaMVpFZlNDbWRtWlhpTCtQMkt1bTREemRrZkh5VSsyUXFPVUkyd2Mx?=
 =?utf-8?B?dUY5NVFNKzJxTzFyczlzNHdhZU15cVIrS2hmTENld2lpaVg5RVduc1lzd05y?=
 =?utf-8?B?eXNwcGVxYVVQRWExRjBQZHJFRUFBV3JVWldJUzRTSThaSmwrdDE0MXdFalEz?=
 =?utf-8?B?MWlOZW8vcTd2UDUxSHdNUzE0bnBkVE9wM01rN0lLRExrbm1iSVFqRnhwS1JY?=
 =?utf-8?B?cktxYWZneFFTM284QWlpN0lMNDljNUREMGMrTHJwdlVQZjlUVDBRbk1YbnVv?=
 =?utf-8?B?cWFFV1hya3lnRDQ3QlEwaGtiL1Z6eGFrV0s1Umx3ZFdHaFFJT3Vmam5LMFNl?=
 =?utf-8?B?ajhiTGhSU042OFMyeWw5OTVvSlVadTYxS0RESCtIc1BQYVlxU21yZEh2VE82?=
 =?utf-8?B?dktMcGRVdUppK0NEaWk5K1N1RnZVSGZWZnBXZmdpbENBVkdKZFJDaXZPVzQ3?=
 =?utf-8?B?S3gvb0NlYWpiMUc5Vm1tK0RCcHdRbGlFR2kyZk00ZUY2TU9BajdBVEpsVFha?=
 =?utf-8?B?MzhnajJNMUUxb2tvRHZQZXU1L050TTdwQ3ZMUUhmRzVnWHhLZEk3U0NOSlEw?=
 =?utf-8?B?cERsaS81Q3BOVEhUUlE1NW9wYm1kYkhzNkdFcWkydXloWjlraWJFeVliRzZs?=
 =?utf-8?B?dVlpMHB4YzVhV3dweEl6WGRtUjlXSXBDeWFLWlVBUFdFUjJ6SkFkSk1tZVVN?=
 =?utf-8?B?RzY2cVVaU0lCSXcyYW1GQ1Iza2pnMENydzRuNCszY1RpVTlFSTkzUnQrNFg0?=
 =?utf-8?B?OXppNFcxbzZvb0dNdjZROVd3ek1qUmZYREZjMjYzeENIcEpwd1o1eG1hMThn?=
 =?utf-8?B?V3R5eW9ESW5kUHNjOUtXNitFK3diREdZdjFBT2U3TDBuQ29QTW5Dc0xreTBi?=
 =?utf-8?B?NmJOc0FGWEhDV2V0QmhGOWFqWUovV0pIL211THFtTW5YU01JcklHUnZxZDFW?=
 =?utf-8?B?OWdob1phVGpBeFRIRllRd1ZBeDA0RzVneXZpUXU4UlZUUmZYSXhPdnFLWGpC?=
 =?utf-8?B?YkdhWlAwcDJCL1NPeFI1NUdwTlg2VmlhVFkzbGl0OHBKdWE5eXBXNjNsaEZm?=
 =?utf-8?B?di8yUWtSelIzZ0dpQ2Vwa2d5L1o0b3BrdnVkeE5kWjl1WWhvZ0g2ZndmNjB1?=
 =?utf-8?B?d29oaEU4R05OMUpLZVdBeDVEMitYR0tkbWFvcThVWDVMN0hSeTFQRlZlWEZ5?=
 =?utf-8?B?Q0U3dENkY3FsWi9QUTF2TTF1MS9FVEpXL0NIOWswUHlVWGIwZHg3c2NzSldo?=
 =?utf-8?B?UVhjZ3R0dDYxQUlMUGhHZjlrSGlhMXJlY05mK1NwMHVaOEFDaU1lV3AvQkV2?=
 =?utf-8?B?cHA0d2toM2VYd1ZhVlFlK2FLd29nOW5xaXJuWlBJai9kUGlYV2dOUkxxSVpQ?=
 =?utf-8?B?OFdKNHFGdGd1aGZyaUR6RzFLNW1VcklCZzNhN0JOVUE4THMwc3RTREhya2kw?=
 =?utf-8?B?UWlOTVNkcWVtK2tlN0xIR1d4Y3pDTGpJcHBFRzY1N2ZPYk5vMm05cEVrbWRs?=
 =?utf-8?B?OXo4VFV3ZXkzSElOL2Y0R3pGVkttSXUrQ0VMVzBvQ01qNVlFS1ZZN1doRkEx?=
 =?utf-8?B?bTZTUWZBQVErcVA4VGFvZ2tidUNIVjdJVVNqWjVrRTI0MklTTHZKbldVdXdh?=
 =?utf-8?B?alZyU3ZtMno0TVhIS0FSVGUyemxZTWVlRGJ1VTA2aDl1RFJEakUxWlNSWEx1?=
 =?utf-8?B?NWpSR21BY1gwQ29seVUreUhJMmQyazlWYnRERFdoZHNVejlyUm0rMVUveUJ1?=
 =?utf-8?Q?zlT0NBWYO7W25z1nRWLWU0QHx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c3b7f8-e70c-45c8-d89b-08de3650c5c7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 11:56:08.0339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nS3mcLdQ2UHowZtz1sI/K6vSSkQp2c+w/AzDggxtW7j377G5JVG/A8Up8yxDKUo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8864
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



On 12/8/2025 4:46 PM, chong li wrote:
> v2:
> place "get_ref_and_mask" in amdgpu_gfx_funcs instead of amdgpu_ring,
> since this function only assigns the cp entry.
> 
> v1:
> both gfx ring and mes ring use cp0 to flush hdp, cause conflict.
> 
> use function get_ref_and_mask to assign the cp entry.
> reassign mes to use cp8 instead.
> 
> Signed-off-by: chong li <chongli2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 13 +++++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  3 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 58 +++++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 58 +++++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   |  3 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  3 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  3 +-
>   8 files changed, 101 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index efd61a1ccc66..090714127cba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -356,6 +356,8 @@ struct amdgpu_gfx_funcs {
>   				     int num_xccs_per_xcp);
>   	int (*ih_node_to_logical_xcc)(struct amdgpu_device *adev, int ih_node);
>   	int (*get_xccs_per_xcp)(struct amdgpu_device *adev);
> +	void (*get_ref_and_mask)(struct amdgpu_ring *ring,
> +				uint32_t *ref_and_mask, uint32_t *reg_mem_engine);
>   };
>   
>   struct sq_work {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 895b841b9626..5c7724f203d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -556,11 +556,20 @@ int amdgpu_mes_reg_write_reg_wait(struct amdgpu_device *adev,
>   
>   int amdgpu_mes_hdp_flush(struct amdgpu_device *adev)
>   {
> -	uint32_t hdp_flush_req_offset, hdp_flush_done_offset, ref_and_mask;
> +	uint32_t hdp_flush_req_offset, hdp_flush_done_offset;
> +	struct amdgpu_ring *mes_ring;
> +	uint32_t ref_and_mask = 0, reg_mem_engine = 0;
>   
> +	if (!adev->gfx.funcs->get_ref_and_mask) {
> +		dev_err(adev->dev, "amdgpu_mes_hdp_flush not support\n");
> +		return -EINVAL;
> +	}
> +
> +	mes_ring = &adev->mes.ring[0];
>   	hdp_flush_req_offset = adev->nbio.funcs->get_hdp_flush_req_offset(adev);
>   	hdp_flush_done_offset = adev->nbio.funcs->get_hdp_flush_done_offset(adev);
> -	ref_and_mask = adev->nbio.hdp_flush_reg->ref_and_mask_cp0;
> +
> +	adev->gfx.funcs->get_ref_and_mask(mes_ring, &ref_and_mask, &reg_mem_engine);
>   
>   	return amdgpu_mes_reg_write_reg_wait(adev, hdp_flush_req_offset, hdp_flush_done_offset,
>   					     ref_and_mask, ref_and_mask, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index aaed24f7e716..aafd34ddcfcc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -8616,7 +8616,8 @@ static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   	u32 ref_and_mask, reg_mem_engine;
>   	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
>   
> -	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> +	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
> +	    (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
>   		switch (ring->me) {
>   		case 1:
>   			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index f4d4dd5dd07b..c3d8e7588740 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1072,6 +1072,44 @@ static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
>   	}
>   }
>   
> +/**
> + * gfx_v11_0_get_ref_and_mask - get the reference and mask for HDP flush
> + *
> + * @ring: amdgpu_ring structure holding ring information
> + * @ref_and_mask: pointer to store the reference and mask
> + * @reg_mem_engine: pointer to store the register memory engine
> + *
> + * Calculates the reference and mask for HDP flush based on the ring type and me.
> + */
> +static void gfx_v11_0_get_ref_and_mask(struct amdgpu_ring *ring,
> +					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
> +
> +	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
> +	    ring->funcs->type == AMDGPU_RING_TYPE_MES ||
> +		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
> +		switch (ring->me) {
> +		case 1:
> +			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> +			break;
> +		case 2:
> +			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
> +			break;
> +		case 3:
> +			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
> +			break;
> +		default:
> +			return;
> +		}
> +		*reg_mem_engine = 0;
> +	} else {
> +		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
> +		*reg_mem_engine = 1; /* pfp */
> +	}
> +}
> +
>   static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
>   	.get_gpu_clock_counter = &gfx_v11_0_get_gpu_clock_counter,
>   	.select_se_sh = &gfx_v11_0_select_se_sh,
> @@ -1081,6 +1119,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
>   	.select_me_pipe_q = &gfx_v11_0_select_me_pipe_q,
>   	.update_perfmon_mgcg = &gfx_v11_0_update_perf_clk,
>   	.get_gfx_shadow_info = &gfx_v11_0_get_gfx_shadow_info,
> +	.get_ref_and_mask = &gfx_v11_0_get_ref_and_mask,
>   };
>   
>   static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
> @@ -5833,25 +5872,8 @@ static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	u32 ref_and_mask, reg_mem_engine;
> -	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
> -
> -	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> -		switch (ring->me) {
> -		case 1:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> -			break;
> -		case 2:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
> -			break;
> -		default:
> -			return;
> -		}
> -		reg_mem_engine = 0;
> -	} else {
> -		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
> -		reg_mem_engine = 1; /* pfp */
> -	}
>   
> +	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
>   	gfx_v11_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>   			       adev->nbio.funcs->get_hdp_flush_req_offset(adev),
>   			       adev->nbio.funcs->get_hdp_flush_done_offset(adev),
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index f9cae6666697..b805ed4f88aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -929,6 +929,44 @@ static int gfx_v12_0_get_gfx_shadow_info(struct amdgpu_device *adev,
>   	return -EINVAL;
>   }
>   
> +/**
> + * gfx_v12_0_get_ref_and_mask - get the reference and mask for HDP flush
> + *
> + * @ring: amdgpu_ring structure holding ring information
> + * @ref_and_mask: pointer to store the reference and mask
> + * @reg_mem_engine: pointer to store the register memory engine
> + *
> + * Calculates the reference and mask for HDP flush based on the ring type and me.
> + */
> +static void gfx_v12_0_get_ref_and_mask(struct amdgpu_ring *ring,
> +					uint32_t *ref_and_mask, uint32_t *reg_mem_engine)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
> +
> +	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
> +	    ring->funcs->type == AMDGPU_RING_TYPE_MES ||
> +		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
> +		switch (ring->me) {
> +		case 1:
> +			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> +			break;
> +		case 2:
> +			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
> +			break;
> +		case 3:
> +			*ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
> +			break;
> +		default:
> +			return;
> +		}
> +		*reg_mem_engine = 0;
> +	} else {
> +		*ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
> +		*reg_mem_engine = 1; /* pfp */
> +	}
> +}
> +
>   static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
>   	.get_gpu_clock_counter = &gfx_v12_0_get_gpu_clock_counter,
>   	.select_se_sh = &gfx_v12_0_select_se_sh,
> @@ -938,6 +976,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
>   	.select_me_pipe_q = &gfx_v12_0_select_me_pipe_q,
>   	.update_perfmon_mgcg = &gfx_v12_0_update_perf_clk,
>   	.get_gfx_shadow_info = &gfx_v12_0_get_gfx_shadow_info,
> +	.get_ref_and_mask = &gfx_v12_0_get_ref_and_mask,
>   };
>   
>   static int gfx_v12_0_gpu_early_init(struct amdgpu_device *adev)
> @@ -4389,25 +4428,8 @@ static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	u32 ref_and_mask, reg_mem_engine;
> -	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
> -
> -	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> -		switch (ring->me) {
> -		case 1:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> -			break;
> -		case 2:
> -			ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
> -			break;
> -		default:
> -			return;
> -		}
> -		reg_mem_engine = 0;
> -	} else {
> -		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
> -		reg_mem_engine = 1; /* pfp */
> -	}
>   
> +	adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &reg_mem_engine);
>   	gfx_v12_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>   			       adev->nbio.funcs->get_hdp_flush_req_offset(adev),
>   			       adev->nbio.funcs->get_hdp_flush_done_offset(adev),

Though it's about mes, could you also convert the below ones also to 
make it uniform?

Thanks,
Lijo

> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 66a4e4998106..176658846b81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -2070,7 +2070,8 @@ static void gfx_v7_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   	u32 ref_and_mask;
>   	int usepfp = ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ? 0 : 1;
>   
> -	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> +	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
> +		ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>   		switch (ring->me) {
>   		case 1:
>   			ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index e6187be27385..bc1d0870cb2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5382,7 +5382,8 @@ static void gfx_v9_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   	u32 ref_and_mask, reg_mem_engine;
>   	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
>   
> -	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> +	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
> +	    (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
>   		switch (ring->me) {
>   		case 1:
>   			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 89253df5ffc8..418b8daa7097 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2820,7 +2820,8 @@ static void gfx_v9_4_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>   	u32 ref_and_mask, reg_mem_engine;
>   	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
>   
> -	if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
> +	if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
> +	    (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
>   		switch (ring->me) {
>   		case 1:
>   			ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;

