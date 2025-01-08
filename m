Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025DBE77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 16:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 926F210EC0A;
	Wed,  8 Jan 2025 16:33:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G+93Mo5R";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D8EF10EC0A
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 16:33:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CS2DDBPGJp2W4CD/LB3G2WkV9NO1TIk9nVxw565uVlwnXEyOjfZEpVb+OFpfvq8VlzpeIt4cmNj8+NdZGEDwNLGPV83fEnlQ8C+FqvtIiDfgHMi65V3/+tPbFGazOprpbW2ar4pTcu9P1iCDFJL9wKnp4O/3fOAmnYPizqUZ43AlgfZgGqUByZaqMEh/dNKZ8qA0cu4wkZ2gLv5flB7k4sXF1iRT54rrdNi2vhpuVmDQJMFcDUo8BEpBiOJp7KKdJ8ll6f29eXf3QcpWKjHv3LUROvp+zUlnfCZrgesmDJ46BpwFzV+KmTenYANwE93bg3JpkbeDphzXrZxbBgAq/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3r4NQpsNnSvQ9lsHkRE6Ii3FvSy6VMX0n48avq1kUg=;
 b=LYbw4U38Ulb2JlU2JY9Flsyx8m7EM5ciPia+HyaA4g+Wxhtu3MMOXD1hITpxslT6IWRzt5MZuA/0Fyq6+GzZttto0I/OKS5jn7E2KZlpz3myGIitCzo4Pq1YntB2doLv3Y1GfXh44yuItG2knKbSpSXgqY9d9E9h+v3sHJ/GQP5V1IDB+UWh6b5FeM/E7JiczOXFDk2ASuSP1/PEOD6UBvnN18rOXeAzCIqUm89RRnhEULq4UdTGV0o7AACHtv8wt58fOM0VfTIpcG9hT6Lmf3ty9lgNKeOhCGsJKtpupCw1YHXaRVJCdNmmiXHlB738MjelIeUyREJ9+izCEXZJSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3r4NQpsNnSvQ9lsHkRE6Ii3FvSy6VMX0n48avq1kUg=;
 b=G+93Mo5RKs47djCb4FPOFNehS4z2SmCdsVd0Ju+HsuQoJ2WT2faNYd0qyshdIAClI1XkE4bpptEYh032G3yKwcPGtFSa5Sv7vK/MmzfaX0huT37KsRmJ5i38Kigz03SygB0TEhKft8ZdbctVShcaJxTUhzJajJnoLFasvdtYKaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 16:33:42 +0000
Received: from CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754]) by CY5PR12MB6108.namprd12.prod.outlook.com
 ([fe80::46e5:5b51:72c3:3754%6]) with mapi id 15.20.8293.000; Wed, 8 Jan 2025
 16:33:42 +0000
Message-ID: <37c31a32-c5fb-4a5b-8aad-448997f94cda@amd.com>
Date: Wed, 8 Jan 2025 10:33:40 -0600
User-Agent: Mozilla Thunderbird
Subject: Re:
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, Jun.Ma2@amd.com, xiaogang.chen@amd.com,
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
References: <cover.1736344725.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <cover.1736344725.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:806:130::23) To CY5PR12MB6108.namprd12.prod.outlook.com
 (2603:10b6:930:27::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6108:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: df8dc1ff-4a2f-4c37-a392-08dd300236a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czh0WHlRU2xFZ3FOaTNUSm8rd0RrbThVRjFEc0c3Y1BqYks1c3FFOVFQNXBD?=
 =?utf-8?B?Q1dISXQyK3ZKTEtSS3VLb2wrM3FKOUxVczRuWnpzMGZKVDRMQlpJTlc0d0c3?=
 =?utf-8?B?T29ITzlGOW5DSHl1dGpSRzVNNzgxWjFtRjdkbnhlVjBHcGdmNW5vUTZSb3dx?=
 =?utf-8?B?R0RrZmdmdHRwVWlJR2NLZTdNd1dDY3RIMjBSaEFJakVKVUkwNTczZzVlejdG?=
 =?utf-8?B?S05icWsyamFRRFdENkt3K0JHc1dhckwvRlRCSG1BYTRDTU5kdDFTOTZQRjJ4?=
 =?utf-8?B?aU10NGxSNWdCSHgxTE9hUGp6b1RKQm8vTmlRY2U5Z1k5V29iS204eFlBN0Rx?=
 =?utf-8?B?c2dlMXF4SUVLVnVub3U4Z1FMRDRFeGQ5NHF6dFYzbHFIcU1sQ3ZuYTFqUk9l?=
 =?utf-8?B?aGZTc0tCc2ZydStKZHdMeXB2U2t0bVBQb1l3VkJkY000bTJQeVlySlBvUmJJ?=
 =?utf-8?B?eko3MDRlN2dGcCtPaHNZdU52NW1DTDJxUCt5c1ZqNndBakdoYXg0aUtCZjZh?=
 =?utf-8?B?dUkrdUp2dyt3Wi85cmFhc3lEYnUvN054WDZWeTdWUW1pbVk3bGl0bXJIeCtO?=
 =?utf-8?B?YmZFTmxWeEJaWGg2Q25UdG1lR0h2ZzY4TzVLRUd2bGRvSEp1amVqOU12WDdQ?=
 =?utf-8?B?NHRhcVo0UXVmUUJFTnh0NHZWK0p2VTB5enBZK2V3dzBCQ2lZYlM1QjJ5YSt1?=
 =?utf-8?B?Vzc2RGZzdHQ2bzdWRnY2bU1jd0Q5TzNROEtWL1NwSEs5eks2dmdFTGVUZW4y?=
 =?utf-8?B?VmF4K3Z4SmgvbXVhSzFpNzdGQUxjZkRzU2szc1FrSjBWaUhJNExISUtJVko5?=
 =?utf-8?B?ZnNZSkJSMHFHZmFNLzNxNjVKZ05QU0V4b0FPL0FDNTJUdnJuQ2FLdzdMRFJN?=
 =?utf-8?B?Y09YcDUxd3h6R1RKdUJGK01tTmhKMHAwRGx5RUUvbytSQ2VHQ2Yya3dGbHgz?=
 =?utf-8?B?ZHpkNE5mVlo2c1huVkYxRDduc0thZi9wcVdoZVgzM1lpY2Q3M1labk83MmhU?=
 =?utf-8?B?b1BkcTF3Q0FFcHo2SlVlakVzNHVyRnBDUWl0UDZEbytQSXFOZG9VMlBpOXBQ?=
 =?utf-8?B?cUU0QVYyeXZybHNRNE9aYWRVdUpLQlpWWG9sNjZPQTZRWXlmK1RkLzRTYjNT?=
 =?utf-8?B?azNhQjRuOEZqUkJqcUVqMVJvNlRLSDZKOVp4bmhTRWtPMUdIMG1DT0pVbm1W?=
 =?utf-8?B?ek1DcG1VTTQrK3g2c3k5d0RNdGJKMW5oZk43OHlyU2lDeDBWb2U4SmRhK3RR?=
 =?utf-8?B?VEd3Q2Fxa1E3U2ZTYmg3OFp5R2Rsd255b3VDUWpXMDhsNHdBWng4UDhGSXda?=
 =?utf-8?B?Z0VzSXlUZWRpUzFaYnpoS3BtWGpINFdzdTlXNEk3VTVnaldqTVVPb3Y1S0Y3?=
 =?utf-8?B?bktKNXJIR0JPZWhvOXRyblFjcyt3RkFpZ1RJalR3S2tOcHpwSVNzTE1jZDl5?=
 =?utf-8?B?VW9PNVhQNGhDQzZTK05MOEVRcXl5UXZGWXJWZUhRQzIrcDJtcUNuajQ5MmFZ?=
 =?utf-8?B?cFlXTDFkUUJ0QVFPNEtvRnBFKzRRSDlZamZnT21pa25YVzJxb3pKdG9vbWJF?=
 =?utf-8?B?T1huYkZ0eCtNUVREd0lreWNjRFJXL2FQaWdtSGdtK0svOWlTbDdVOVlYYStz?=
 =?utf-8?B?VkZLKzRoVTIwSWpFMDB4cUttSkVweGdQT280ZThjb0tEanYxT0NpTlNQYm9l?=
 =?utf-8?B?NzBSbTJZTkhaTXJjb29DOHRVQXJtamdvclhhaXo5Z3pGdUhEdXE4a3VncGcy?=
 =?utf-8?B?MFU0OXZWU05xSitNdzN2ejQvN2k4Snc0b2owSEhHR3hkalAxMWNrNE5kOFY1?=
 =?utf-8?B?ZjhhNFZ1dnhyZG9WYU1SRjVwazl6QS8yd0pxVkZpM25ybVVXTUh0QzFZYjhI?=
 =?utf-8?B?am1FMnJFV05XbFpBakJZY0ZjcmwwMDMyNjFmV245UEdqYWtOV3A3VC94dGU4?=
 =?utf-8?Q?8Ga7yj1cQ0Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6108.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(921020); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnUzUFViMnNGMVNYZUZVWGFiaXFUblZTemR3Q1FOb2ZFaENjbTBhZEIwNHMw?=
 =?utf-8?B?eURodEdaeTB0MzNWZ1FncUtSd0RKUzRiRXdoZjhwNGE2TFplUVVFMFdUclR2?=
 =?utf-8?B?OElkOWUzdlUzSTRGN0o4TXFOdUYwei9CMlVKd1p5VDR1Y2tIVENKdE5jcVlj?=
 =?utf-8?B?c3FZK0VMa1QxSk83OEFwOEkzZ1VPblMwWFRHTVE1WWRUZlh5cHJUQWNqL3E4?=
 =?utf-8?B?Ri9vd2FTTmNjQ2Z2aXVpNDJIMGFTQ3Q4NU53TkxUR2RONkdQZXl3cXZYdWtK?=
 =?utf-8?B?OHFFNzR2akFVT3Nuc1U5b1BWMlJ1cTlBUnlVVVRKZDdsYmRxeEthNXFYWVJt?=
 =?utf-8?B?Y2JNbEg1cm53RTNBSTd2SFBwcXpPdHd1RHlYRlJPZjZhc2wwcjdMUVFGSXJM?=
 =?utf-8?B?UjM4RmVseWV5MDhDeGQ0WXROM1RYVzk4UFhQRDZlUkk0NGFtRlFFYmVzNHkz?=
 =?utf-8?B?cEZPWjR5cE1aMFRVcVJGdHMwaEMxNmV6TmR5YlplWERNUkhZOVJKdmtJZWZi?=
 =?utf-8?B?anduSzFMbHp0NG1lWDFsOUlyTTIxS3FPSUgvaGhNamc3eXhxSnNXaUxHcnM5?=
 =?utf-8?B?TjJzdWdVYVk2bzBzS012bk9tNHNrVlR6dzkyQUR4NVUvVU9YdUlBbEF4cUpV?=
 =?utf-8?B?SXdXYzZKNWVQTVY3SE5TaE5wMG12ZHQxdGo0SlVtUlEvd3E0NExEeWprZzYr?=
 =?utf-8?B?M0p4Ym1WcWFzaHRJYUNGcXNBbTZDV21yMUFjUWYwOFMxMGVHeERGTGptTWRt?=
 =?utf-8?B?MlJDbWVyQ1BWZkxnV05ZcmtITjI5WWVTa3g4YmtIbFlvcDZQd2trUUhneFdB?=
 =?utf-8?B?S05NeE9tOC9yT1prbCttdXQ4aUppMWhjSTF0RkdMeVZ1NTdJL1U5bnhzRkxo?=
 =?utf-8?B?UmVkcFFMT0hVbDBaRmVMTmd6eUoxUXloNUxrT2FzczFZWFNURzZpem5pWk9K?=
 =?utf-8?B?Mk1RaWJDVlFtUGlhcGZYMmtiTk5lSk5oTHpoNEJYSXRXd1VWUmdWZ1NDUFdQ?=
 =?utf-8?B?UFdlZ3FmLys3WDF2WlU4aHkvMDhWQ1Rwdko5ZGNTb2x5bFFvdm50N2s5MHZj?=
 =?utf-8?B?c1gwUCtFVDNMdjd0L3psZDBFMWY2R0VDN2hISXN6RCtDdHFTVGtOWmRxR2RD?=
 =?utf-8?B?NlJiem8xc3JHcjNGN3F3TFZnaUxBdE5oUDlBbkpRdmlHSk9rVHR0dk1ld2sw?=
 =?utf-8?B?d0czNDNnVWhvL0l5c04yQ3VrejRwcVNDanBOdExvZWxaaUk3bzBPZk8zamVo?=
 =?utf-8?B?bVBBSlE0ZUZuUVR4SVhIVm9DTldRU3FLdWJ1d3ZCd0QwUDQ4V1Nnanh4L05s?=
 =?utf-8?B?L01DczdvY01pejBtRy80V0pIRnl5V09LMnltazEvaUQ3UWtRZVlrRG1EdTI1?=
 =?utf-8?B?ZmdFUHdNZDdDR2lrVUUxQ1JnN1JVT1Z1MSt6d241U3VLbE1qVC9xK2VOV3p6?=
 =?utf-8?B?WmtnV3NDcmNzTkhHdzE1ZjhNUEpCSFNyejJEeXZoOWpnZnM2ZDl6M0dVNjQz?=
 =?utf-8?B?WkxqcnFhWHZPVm1LZk1kVGcyOGRNUzFRb2VEOWtJKzFaQkt5WW0yVkYzMXZQ?=
 =?utf-8?B?eWJLYVdOb1Q4RzB5RTMxVFFkd3Y3eVRqNXFiNCs5WVNQczdrU05WTFVlQUts?=
 =?utf-8?B?dG9aV05PV3FxWGJnYW1LREhHLzNZNkVBZkMzTU95L2JvRDlJVjFLM0xyc2x2?=
 =?utf-8?B?YkJiaFZPd3VUZ2V4REpBTzBNbUZIWGRSVUZOL29Pek9VenVlYzJGWnFXOUUw?=
 =?utf-8?B?VGxXZ05hbGxhL2tuYnQvMEJmREJuMHpuN2xjYTR3Q1RoSndqeitJZXVzakZk?=
 =?utf-8?B?SlBlV1B2QWRXNUc2N2hPTmdLQVhkYlVhT0poa3p6aXpRZkMwbDRxL0RZbUNs?=
 =?utf-8?B?Wis2ZGFHUDVVZ1JaRXlWRXlXejJsTFVPRGJkQngrSWJySkNlUWIybjlsUTlP?=
 =?utf-8?B?ekE4OE1lMng4bnJUaVNUbUtOWnpUblZJQWNZYnFOWFVuQ0JuMkdrSVlFYUVM?=
 =?utf-8?B?L3N1cnkrNW5od1g5c0FnNDlDdGszK0gwcnJNc01QSXF3aTFhcEQrb1orOG5q?=
 =?utf-8?B?MldMSUtNMElXL3pMd0RuRmE1N2MyMFBybnUyUnY2bHBQZjFVY3dxSE9nTFY0?=
 =?utf-8?Q?5nTuLMSBNHZEG7qlTu9/wlDRs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8dc1ff-4a2f-4c37-a392-08dd300236a7
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 16:33:42.3263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUkQ3dUPaJLZyd/DjE4SHViPRQWnORdFRC4PeVf4zmNN+4xISe8dIma2CwvKQ4Ou2G/sAx97wFB9SlNbzn7RvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654
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

On 1/8/2025 07:59, Jiang Liu wrote:
> Subject: [RFC PATCH 00/13] Enhance device state machine to better support suspend/resume

I'm not sure how this happened, but your subject didn't end up in the 
subject of the thread on patch 0 so the thread just looks like an 
unsubjected thread.

> 
> Recently we were testing suspend/resume functionality with AMD GPUs,
> we have encountered several resource tracking related bugs, such as
> double buffer free, use after free and unbalanced irq reference count.

Can you share more aobut how you were hitting these issues?  Are they 
specific to S3 or to s2idle flows?  dGPU or APU?
Are they only with SRIOV?

Is there anything to do with the host influencing the failures to 
happen, or are you contriving the failures to find the bugs?

I know we've had some reports about resource tracking warnings on the 
reset flows, but I haven't heard much about suspend/resume.

> 
> We have tried to solve these issues case by case, but found that may
> not be the right way. Especially about the unbalanced irq reference
> count, there will be new issues appear once we fixed the current known
> issues. After analyzing related source code, we found that there may be
> some fundamental implementaion flaws behind these resource tracking

implementation

> issues.
> 
> The amdgpu driver has two major state machines to driver the device
> management flow, one is for ip blocks, the other is for ras blocks.
> The hook points defined in struct amd_ip_funcs for device setup/teardown
> are symmetric, but the implementation is asymmetric, sometime even
> ambiguous. The most obvious two issues we noticed are:
> 1) amdgpu_irq_get() are called from .late_init() but amdgpu_irq_put()
>     are called from .hw_fini() instead of .early_fini().
> 2) the way to reset ip_bloc.status.valid/sw/hw/late_initialized doesn't
>     match the way to set those flags.
> 
> When taking device suspend/resume into account, in addition to device
> probe/remove, things get much more complex. Some issues arise because
> many suspend/resume implementations directly reuse .hw_init/.hw_fini/
> .late_init hook points.
>
> So we try to fix those issues by two enhancements/refinements to current
> device management state machines.
> 
> The first change is to make the ip block state machine and associated
> status flags work in stack-like way as below:
> Callback        Status Flags
> early_init:     valid = true
> sw_init:        sw = true
> hw_init:        hw = true
> late_init:      late_initialized = true
> early_fini:     late_initialized = false
> hw_fini:        hw = false
> sw_fini:        sw = false
> late_fini:      valid = false

At a high level this makes sense to me, but I'd just call 'late' or 
'late_init'.

Another idea if you make it stack like is to do it as a true enum for 
the state machine and store it all in one variable.

> 
> Also do the same thing for ras block state machine, though it's much
> more simpler.
> 
> The second change is fine tune the overall device management work
> flow as below:
> 1. amdgpu_driver_load_kms()
> 	amdgpu_device_init()
> 		amdgpu_device_ip_early_init()
> 			ip_blocks[i].early_init()
> 			ip_blocks[i].status.valid = true
> 		amdgpu_device_ip_init()
> 			amdgpu_ras_init()
> 			ip_blocks[i].sw_init()
> 			ip_blocks[i].status.sw = true
> 			ip_blocks[i].hw_init()
> 			ip_blocks[i].status.hw = true
> 		amdgpu_device_ip_late_init()
> 			ip_blocks[i].late_init()
> 			ip_blocks[i].status.late_initialized = true
> 			amdgpu_ras_late_init()
> 				ras_blocks[i].ras_late_init()
> 					amdgpu_ras_feature_enable_on_boot()
> 
> 2. amdgpu_pmops_suspend()/amdgpu_pmops_freeze()/amdgpu_pmops_poweroff()
> 	amdgpu_device_suspend()
> 		amdgpu_ras_early_fini()
> 			ras_blocks[i].ras_early_fini()
> 				amdgpu_ras_feature_disable()
> 		amdgpu_ras_suspend()
> 			amdgpu_ras_disable_all_features()
> +++		ip_blocks[i].early_fini()
> +++		ip_blocks[i].status.late_initialized = false
> 		ip_blocks[i].suspend()
> 
> 3. amdgpu_pmops_resume()/amdgpu_pmops_thaw()/amdgpu_pmops_restore()
> 	amdgpu_device_resume()
> 		amdgpu_device_ip_resume()
> 			ip_blocks[i].resume()
> 		amdgpu_device_ip_late_init()
> 			ip_blocks[i].late_init()
> 			ip_blocks[i].status.late_initialized = true
> 			amdgpu_ras_late_init()
> 				ras_blocks[i].ras_late_init()
> 					amdgpu_ras_feature_enable_on_boot()
> 		amdgpu_ras_resume()
> 			amdgpu_ras_enable_all_features()
> 
> 4. amdgpu_driver_unload_kms()
> 	amdgpu_device_fini_hw()
> 		amdgpu_ras_early_fini()
> 			ras_blocks[i].ras_early_fini()
> +++		ip_blocks[i].early_fini()
> +++		ip_blocks[i].status.late_initialized = false
> 		ip_blocks[i].hw_fini()
> 		ip_blocks[i].status.hw = false
> 
> 5. amdgpu_driver_release_kms()
> 	amdgpu_device_fini_sw()
> 		amdgpu_device_ip_fini()
> 			ip_blocks[i].sw_fini()
> 			ip_blocks[i].status.sw = false
> ---			ip_blocks[i].status.valid = false
> +++			amdgpu_ras_fini()
> 			ip_blocks[i].late_fini()
> +++			ip_blocks[i].status.valid = false
> ---			ip_blocks[i].status.late_initialized = false
> ---			amdgpu_ras_fini()
> 
> The main changes include:
> 1) invoke ip_blocks[i].early_fini in amdgpu_pmops_suspend().
>     Currently there's only one ip block which provides `early_fini`
>     callback. We have add a check of `in_s3` to keep current behavior in
>     function amdgpu_dm_early_fini(). So there should be no functional
>     changes.
> 2) set ip_blocks[i].status.late_initialized to false after calling
>     callback `early_fini`. We have auditted all usages of the
>     late_initialized flag and no functional changes found.
> 3) only set ip_blocks[i].status.valid = false after calling the
>     `late_fini` callback.
> 4) call amdgpu_ras_fini() before invoking ip_blocks[i].late_fini.
> 
> Then we try to refine each subsystem, such as nbio, asic, gfx, gmc,
> ras etc, to follow the new design. Currently we have only taken the
> nbio and asic as examples to show the proposed changes. Once we have
> confirmed that's the right way to go, we will handle the lefting
> subsystems.
> 
> This is in early stage and requesting for comments, any comments and
> suggestions are welcomed!
> Jiang Liu (13):
>    amdgpu: wrong array index to get ip block for PSP
>    drm/admgpu: add helper functions to track status for ras manager
>    drm/amdgpu: add a flag to track ras debugfs creation status
>    drm/amdgpu: free all resources on error recovery path of
>      amdgpu_ras_init()
>    drm/amdgpu: introduce a flag to track refcount held for features
>    drm/amdgpu: enhance amdgpu_ras_block_late_fini()
>    drm/amdgpu: enhance amdgpu_ras_pre_fini() to better support SR
>    drm/admgpu: rename amdgpu_ras_pre_fini() to amdgpu_ras_early_fini()
>    drm/amdgpu: make IP block state machine works in stack like way
>    drm/admgpu: make device state machine work in stack like way
>    drm/amdgpu/sdma: improve the way to manage irq reference count
>    drm/amdgpu/nbio: improve the way to manage irq reference count
>    drm/amdgpu/asic: make ip block operations symmetric by .early_fini()
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  40 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  37 ++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c      |  16 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h      |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   8 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 144 +++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  16 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |  26 +++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |   2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |   2 +-
>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c       |   2 +-
>   drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c        |   1 +
>   drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c        |   1 +
>   drivers/gpu/drm/amd/amdgpu/nv.c               |  14 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |   8 -
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  23 +--
>   drivers/gpu/drm/amd/amdgpu/soc15.c            |  38 ++---
>   drivers/gpu/drm/amd/amdgpu/soc21.c            |  35 +++--
>   drivers/gpu/drm/amd/amdgpu/soc24.c            |  17 ++-
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   3 +
>   25 files changed, 326 insertions(+), 118 deletions(-)
> 

