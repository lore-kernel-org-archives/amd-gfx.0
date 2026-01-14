Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AA6D29FE5
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 10:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6FED10E5EF;
	Wed, 14 Jan 2026 10:45:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EsWFWUkj";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8301B10E5EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 10:45:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SO+6vjiJVNT9VWiW3D8bW9WVM+vTHMtJEJlBHTehhhhlr4h6YaQGoLu8mAVpCuBoZj/zSuoXcWyC6lt9H5e5+FeoOJZLt7qe+H2ugLVsBrvLIp1y0nPyK12o/Q4IaKW3387gXScA1I39RfDLXBxGzyozvDg9QCK/b7k6lUyu24sR8lEPBMPe1DlOYSYdidZhD3bv2c1Bn9l1kGFLT6j/95ixma9U4VwfNPZ23mH+X+71ce3eAXShzQaqjzaHvKv0/UAz3R7OlUtDQCkurUF6EQC0sGywx6tamf9sD16n3u10fvdCEvAZ4suNKhyEfsHNqCwWucPsHGgge35WfatJYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pC+SFQjIZS6CQLlFhPeYBkIVI0HeN6QS5gu3K1LByOI=;
 b=o9PAvM7B7MoriBlTD2owb7nB6HLIEMtUmJI+PCSvUTRhKz4cPay3ZGzifLWEly4voskn23B4UPZTP0dj93kVnJtT1Jp2pwpzdB9unNC+zELHEs1tgx6zySDKoUepgJJqIQT2gaf5QorZL2j/KhSzG60BAGbJrwYjjkQyipX6GJ/1W0+EGWwVE0DmVR/frBuULlpblkvgLnyPzie5KCvS0+YLyubfaNkSxpimy6CYuTFNwhCmCgcPmXCt9EmAkfVsXIlTh176MstRe/jyYecWe/GfZtoBo7t60LeTqpdFLgiBUN/Dwi0QSeqhTcyn9yLZjPS1uJbCvK4CrU/BKOI6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pC+SFQjIZS6CQLlFhPeYBkIVI0HeN6QS5gu3K1LByOI=;
 b=EsWFWUkjENbf2uDN8HQrNvEx5na3/PH9QrkEIUehCK6dPSONvE/27itVNsSbMiFRWomIt8t6+BsW/n6yQ8yxo02dJhTg1Tr1ilKZ+xXDqat8uuDRdjARqPJD8vz6oNL02QctvGfgKOyHyIHG1vy6SI5uq3ae9dqTwdf7L8fbmZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 10:45:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 10:45:42 +0000
Message-ID: <6bbdb38b-75d0-4867-b4b6-afa5dc0b479e@amd.com>
Date: Wed, 14 Jan 2026 11:45:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/42] Improvements for IB handling
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260108144843.493816-1-alexander.deucher@amd.com>
 <ca9d73f3-60c6-4a51-a62d-d1358940ac3c@amd.com>
 <CADnq5_MJbjn8zD5O-sjL8vNk4eUD04jTXwkmS9Cwq3_WSajGqg@mail.gmail.com>
 <0288bbdf-880e-4149-ae0e-f2d2154cfbe0@amd.com>
 <CADnq5_M8-Qq14yYjoWJXgBRqQ42prGar1O6e8nxcEN5WNROTQw@mail.gmail.com>
 <CADnq5_PoHgp_Pf7EsV_bRwmh0Q7GuWfnEW-3Pp0gscT80VAnLg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_PoHgp_Pf7EsV_bRwmh0Q7GuWfnEW-3Pp0gscT80VAnLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 51df531f-0998-4c1b-3373-08de535a105e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|7142099003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWtkYVlqNjhDam5BYUhMemN0RUJoa1IwNk9aSHZHZVBqcEtuTmsxV1RKcTBk?=
 =?utf-8?B?NWVOSzd2cHFJMTdHWkx2UGVjOHhpcGR5cDdBbS9FZUxtOUlXdGZieU9Dem9V?=
 =?utf-8?B?alk1Q2JTcU41VFJUT2h2ZEtZWE5QbnhSb3QvNVhpQ282cmdhTUhXUmJYd3Zo?=
 =?utf-8?B?RW9YYWh0RGZwblpaamRmam41ZVZhcGFJZ214cks5MWc4YTJMeEJvZUg3TTMw?=
 =?utf-8?B?RFNBdFhKVGQyTkhndkJyQndOK3NEUmRqNEZmNWFvUm9OQnV3Z0Q2c0d4TWVs?=
 =?utf-8?B?cnhQVFZEZmg5cXR5V1hmOGREWEhkK1pRUlA2c0ZhaGZWbG9PZjBFeDk4WGpv?=
 =?utf-8?B?UnZHcnE4RCtOL2VxVVRJZ05SVGJGUnpUM29QQWh5bmErUW5DcGE4NkRYUy9t?=
 =?utf-8?B?bzBMWjJnUHhsbXp3blJ5RkYxMU1FSE5LZDVXdWR6d1dpZkp4V3dYMkF3YUdx?=
 =?utf-8?B?d0JzQ2d3RUQ4bW83YUtFQkU1MHBKa2FpU3FpZ0dkWUNINHA4Wm5McE9raTdq?=
 =?utf-8?B?anN6NklHVXlUSU9HNVpJamVXamQvNW9xN2pUK0piN1FwQVU3dXlDT2IvZkxi?=
 =?utf-8?B?Wm5xa1hJQVp6b2ZEeisxbkR4VmhET0liVTRHVHQ4cTc0cG8rN2FmQWZmVHJ6?=
 =?utf-8?B?NElMVTFCQzdQTjZYMUFEQ3psclJvOWRsUHM0a1dOa2JRbmQ5d1U3WXlFMDJy?=
 =?utf-8?B?bnp0ZWc4RHA5VitSTkJHUXFOQzAvMm5UT2NtYnFjbGJ4VTArbll4YkpITVNr?=
 =?utf-8?B?WUJWem5ETUprejFNd044TGdKS25PTnFyY0Y1Z01pbHROc3NEcXdBdzJzdUV4?=
 =?utf-8?B?T2RxODU5WGRvUUNMMlNPTnhhSWhGRitCRXNEUEdaVm85TXloUG5vSE5XUS81?=
 =?utf-8?B?QnM3b2NZT0JZeG9kdmlTWEkyNzM4RHRQWjdxL21DQ3gxNzRlMU44L016Mk00?=
 =?utf-8?B?ZDFnVklOdE41SnQxY1M3YkVXUG0zdWE0SkdoZjZINnJxUWNLaVg3Z3V5ai9v?=
 =?utf-8?B?SWFyWU9DYmVteWNMMFRtTmw0QUllQ1FuQUpVeUwvRUNNcnBXblJOUUlZaFBz?=
 =?utf-8?B?eFhsRDdpdHhVR2Zrd1dhVXgvSm1JYTNqVlFsYUZOeWZjazhKYWxqUURZWmsv?=
 =?utf-8?B?aFlCZ3dPNzhiUlhLck1kOVNoa1NEQ01GRHhPVkRqRStaQ0EwSkhxbmFmWm9V?=
 =?utf-8?B?SW9HbFBtOXdxVHVmcjFqeUp1MkQ5S1FwVXV2UmtGVzV0ZGhtWHdHM1YvdXh0?=
 =?utf-8?B?bXgveCtGb0RFaWF0clBKSVowdFJrSmhwSlVqM3ZsTjVFTlM0Ri82ME5IZWdk?=
 =?utf-8?B?bmRZRHVMUWU1REd0c0lJL1hjZXlzejI3ZVNMNUdYUkFlRkQrQmVqTWNVY0VO?=
 =?utf-8?B?MnBkYjcxazhjSVlQeFFsUlA4cU1PM0pKdzZSeU1sMkI4dzBNUHJ0c3R4S2dY?=
 =?utf-8?B?YnQ2SWltaDVjYXRqNzRCWnZrcnh3dXRneStWUUwxT1k0c2o0d0dDVkpJaWg0?=
 =?utf-8?B?ZGlCcjIwYjFDemE0V0pQT21XM3F3T0FJd2xzejRiQkRCMFNFRXZMdHhvc1hL?=
 =?utf-8?B?NC9URURKVkxZZWJpUkVSZlRMd0lNUzI2UHBtZmtJTWVsbmJhVTV1MjBPY0Iw?=
 =?utf-8?B?WTZidmZVbnFLZ2tjejFMMkErRXVJcU1VUHVWNVhMdmIweXdxOWVjcnpmeXdp?=
 =?utf-8?B?Ym1aWk5QMU1uUWl4elhxZzJDZy9BMDJWWTN2VUdRdnh0UnFUTXFDZUtXNzdr?=
 =?utf-8?B?eEE0aU9xenMrQytob1MzR0x4RG1qbFFFSW4zaDNJL29hK2poejNnOU9mNURo?=
 =?utf-8?B?RmVtb1RPb1NrK1pkQkdKN2ZBRTBkWXJtdFJTNG5UUVRSMW9tMU5PcFpGRlkv?=
 =?utf-8?B?TE5IM2g5bzkwRnF0T2RWNDlIM01CMW80TzBGbWpDSE5yQXg2MG85WWRhQUZQ?=
 =?utf-8?B?R3FraXNlQ2VQYm5XaTZoMHkzVkk2bWVVQmUxVVJ0SUR6dUVSVE9ISUgzRlVm?=
 =?utf-8?B?Rk9GS1lIQjNvL0hCUFB6a1k4SU9aaHErQjBZZDRmSjNsTHd1ZEU3b3JmVFlE?=
 =?utf-8?B?SHZVY0FaaFVNV1hmbVpETXdPN25UeWxQSGdhUnNUWWRXUFNTaG51UzMyT3VY?=
 =?utf-8?Q?m2RQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(7142099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0lKeGxkeVo5c1NrYnBEWmd0RXdGWjdaa1JHS1phK1N6SW5BejVTVkxqcU1G?=
 =?utf-8?B?SGppbDdqbE40aUdQdGJzSTk2Q05GWnVXK2pPekpaVlFPU2kxRU9kSWlWeEVi?=
 =?utf-8?B?OS85NVZxM1Z0UUdBdXlrQk5HNkk3L0FyTDRXbDZneUl3ckFveHlzb3hycFlu?=
 =?utf-8?B?ZFBMRWZUeFV2d05IUVM5NFdXQXc2SG9PVlNTZUtweHhXcE8rRnhuS2M4WU8y?=
 =?utf-8?B?NC8rZVVnSU0zTFZOY2I3Y0JJa3BOaHczbTRQTWJhcE1ncEZrSDJWUkJqeUoz?=
 =?utf-8?B?RGE0WFdDSFFhNm90VWV3U0hFODl0QmdkbmZhYUFwREpxTTBudTU0cTFRVVhI?=
 =?utf-8?B?SDlVbVQzWXZ5Z2diSTZMV09nbHdxVHg5R0NGellRajFWQ2llbVJjR1hxenlw?=
 =?utf-8?B?RHdsbERCbzhRcjZSZmlubEhhdWwrZGRSK1Z3eDBJYk9GN1Y4UTBTeEM0cGlo?=
 =?utf-8?B?b3RoRVRLMlVqbVhEK3BMa08rV1EyZGdKL012bndqNXhvbGRzM1JnSTlmNldW?=
 =?utf-8?B?SjM3NENjbG9rdGlkbXF2ZVMxNC94VmxjZ0t3QXpVdnVOdGlKWFUxS21sYTRD?=
 =?utf-8?B?MmNiOU50VUh3WHkyZmZOZEQ3TWQ1djBMVW42S0Ztb01mV0Z0YUNHaG5pcVR4?=
 =?utf-8?B?SmNpc3J2cWxSVzRhSC8vQ0NvZy83bTR6UHdwdmVRcGZXWHpyQUlucGJ5cEU0?=
 =?utf-8?B?bmJFTG9neXg3SUpmTVhydFFHOXNNaTdQTWxuakpqVjFZNVZCZ2g4RzhVYzhT?=
 =?utf-8?B?L2IwMnkraWxBVHhLQ0hZRjBmSk02Rndjd3ZkY1dheUUxbmFoeTBXZ01DZ2lW?=
 =?utf-8?B?NTVUZzM1VHBOK2hTaGF0VHZKMjdFTm4wVHQzalp4MjdLZzFEdnhCcVRzb3h2?=
 =?utf-8?B?RmVGdld2OXlOeVpHeGZ3QUdkS1FIZUtCcjhWaUZsSVRLQmdwbUpPSkJXSkxk?=
 =?utf-8?B?Tm9xcU9yY004WE5wSGYrZkVqbTA4Z0VCOHJuVWFVWUlwVDBmSUI5bVpjT2pq?=
 =?utf-8?B?bURRekFvT2NSNFdPNnF4d29VTktidXpQNFlUaEdVZktHN21sU2ZGWFkvVUdT?=
 =?utf-8?B?NHFuQ2tvVFZrZ1EzZ3FONzVIOVE3Qi9ObFJUcGZURG5uRjlwemFKY1FFK3la?=
 =?utf-8?B?c3NsaFZHOWk1SGJCRXhjeUc4UW4yMDhwRHBISGFjSFRSdEFwNlFrR3VHMTV1?=
 =?utf-8?B?bU1ZVVpjWGFJZGZLSC91YjhrVnd2Z2ZsRE9qcU93ZUh3T3ZSbkE0cWxLc3pv?=
 =?utf-8?B?YXBwMURMM1VIMHpQMXdTRVFydndsRDlCcDNCSW8wTnNpUitoUXBxV0R3YnVu?=
 =?utf-8?B?dmYwZ1h2MkxnYnR0QlFPeUQweGRWcHlGbEh4NVpPdEdUNWhBc2xkQWFYdE51?=
 =?utf-8?B?M2h0bmZ0L2RPUXdsbFd0Y3JqZHR3cWMwU0ttM0d0TzUydVZMRzNrKy80UkZq?=
 =?utf-8?B?aE1ZQlZYMWtPd3AwSk9mdDJUNkhyV2xrM2s2QzN6ZHcveHMwNnpvVytGdzda?=
 =?utf-8?B?WXJUc2p4YjdrdVlsS3NNcnhKSHhINkFMeEJLcVJiK0RtYktmVWRkbzhIdlVi?=
 =?utf-8?B?SFNMSUdhaktVQzBBNXpjUmNuREJ5cGhWb2ZDdmlVWXV0cWpwc3d2aTd3bDQ2?=
 =?utf-8?B?dWk1SG92UmIrU056VzBRamdUTWsreVdha0F1ZzFub2lqVmlWVFVGYU9DeGN2?=
 =?utf-8?B?bGg0TWN1dU1UUWx1WmwwcWZVUmNiZVNjRUU1RW96a0J6OHhNTDJteUZ2WXBB?=
 =?utf-8?B?NjRqb21QMkl5NlFBNE94bk9yTkJ6aG52cmUrTmRvSUEzNXlSdkNQa1EwcU5M?=
 =?utf-8?B?T0ZUbkwvZDZXVkJ0Y2JzTnA5S045WHRka2dvQmUzVXZvQzU4RXVDNURVUWZ3?=
 =?utf-8?B?SVFOUHhseDExTzg4bzVTaXU1bU1nL25FallkK0Y0TkZxWVJZWDZJVDBpTnp1?=
 =?utf-8?B?UFBSWHN2YWh2WG5Qd0wrY244Zk1yUmRZaUdsd0wzRlNaekFOS3lXQ0laYUhL?=
 =?utf-8?B?Wm8xck9hbDhpOFp0ZnNZSnZkelpMZmtyaXNJempsYisyVEVCakR0M2tTZFp6?=
 =?utf-8?B?MFBmNW4xTEtSekVXSGgvVUNQMytoM2xETEJtd0g4WllocXdMZWxYZjFWY2cv?=
 =?utf-8?B?eC9FbUlCTXlZQWR4SXcxWDFhbW9QSzhrc0NINS9BMkZrZllEUTJ2bWtvd3Zp?=
 =?utf-8?B?TE1Dcys4bHZSd2x5OHVLYnk5aU5FaGFXcFNNV3RsNm1qaWJneURrYlNESnFF?=
 =?utf-8?B?c1phcVg0R25FWjhzSHhodElqeFJVQ096cWtpYW9oWENQVVNPN3pZQzA2RzlZ?=
 =?utf-8?B?dVVkQVpQQTRZK0xwRk5hTTFTTjJvWCtManh1RjJoUUkrcHd2QmxzQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51df531f-0998-4c1b-3373-08de535a105e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 10:45:42.1145 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqOp6zzwkE6JLFOQo2A27uEYpBPcFir4v2B6Q1TxevmF3sq9WInAMgIXw2wqO5QD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
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

On 1/13/26 23:36, Alex Deucher wrote:
> On Tue, Jan 13, 2026 at 10:34 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> On Tue, Jan 13, 2026 at 9:48 AM Christian König
>> <christian.koenig@amd.com> wrote:
>>>
>>> On 1/13/26 15:10, Alex Deucher wrote:
>>>> On Tue, Jan 13, 2026 at 8:57 AM Christian König
>>>> <christian.koenig@amd.com> wrote:
>>>>>
>>>>> Patches #1-#3: Reviewed-by: Christian König <christian.koenig@amd.com>
>>>>>
>>>>> Comment on patch #4 which also affects patches #5-#26.
>>>>>
>>>>> Comment on patch #27 and #28. When #28 comes before #27 then that would potentially solve the issue with #27.
>>>>>
>>>>> Patches #31: Reviewed-by: Christian König <christian.koenig@amd.com>
>>>>>
>>>>> Patches #32-#40 that looks extremely questionable to me. I've intentionally removed that state from the job because it isn't job dependent and sometimes has inter-job meaning.
>>>>>
>>>>> Patch #41: Absolutely clear NAK! We have exercised that nonsense to the max and I'm clearly against doing that over and over again. Saving the ring content clearly seems to be the saver approach.
>>>>>
>>>>
>>>> I disagree.  If the ring emit functions are purely just emitting
>>>> packets to the ring, it's a much cleaner approach than trying to save
>>>> and restore packet sequences repeatedly.
>>>
>>> Exactly that's the problem, this is not what they do.
>>>
>>> See gfx_v11_0_ring_emit_gfx_shadow() for an example:
>>>
>>> ...
>>>         /*
>>>          * We start with skipping the prefix SET_Q_MODE and always executing
>>>          * the postfix SET_Q_MODE packet. This is changed below with a
>>>          * WRITE_DATA command when the postfix executed.
>>>          */
>>>         amdgpu_ring_write(ring, shadow_va ? 1 : 0);
>>>         amdgpu_ring_write(ring, 0);
>>>
>>>         if (ring->set_q_mode_offs) {
>>>                 uint64_t addr;
>>>
>>>                 addr = amdgpu_bo_gpu_offset(ring->ring_obj);
>>>                 addr += ring->set_q_mode_offs << 2;
>>>                 end = gfx_v11_0_ring_emit_init_cond_exec(ring, addr);
>>>         }
>>> ...
>>>         if (shadow_va) {
>>>                 uint64_t token = shadow_va ^ csa_va ^ gds_va ^ vmid;
>>>
>>>                 /*
>>>                  * If the tokens match try to skip the last postfix SET_Q_MODE
>>>                  * packet to avoid saving/restoring the state all the time.
>>>                  */
>>>                 if (ring->set_q_mode_ptr && ring->set_q_mode_token == token)
>>>                         *ring->set_q_mode_ptr = 0;
>>>
>>>                 ring->set_q_mode_token = token;
>>>         } else {
>>>                 ring->set_q_mode_ptr = &ring->ring[ring->set_q_mode_offs];
>>>         }
>>>
>>>         ring->set_q_mode_offs = offs;
>>> }
>>>
>>> Executing this multiple times is simply not possible without saving set_q_mode_offs, the token and the CPU pointer (and restoring the CPU pointer content).
>>>
>>> And that is just the tip of the iceberg, we have tons of state like this.
>>
>> There is not much more than that.  I looked when I wrote these
>> patches.  Even this state should be handled correctly.  In this case,
>> the state is saved in the job at the original submission time and is
>> explicitly passed to the emit ring functions.  As such the original
>> state is reproduced.  In this case, ring->set_q_mode_offs and
>> ring->set_q_mode_ptr get reset in gfx_v11_0_ring_emit_vm_flush().
>> Then they get set as appropriate based on the saved state in the job
>> in gfx_v11_0_ring_emit_gfx_shadow().  It emits the same ring state
>> again.
>>
> 
> I just fixed up the set_q handling locally.  I added a helper which
> saves the state of the ring (any ring->set_q values, etc.) in the job
> before we schedule the IB.  Then after the reset I restore the ring
> state before re-emitting the IB state.

Exactly that doesn't work.

See the set_q_mode handling works by looking at the next job in the queue and determining based in PM4 code if executing the packet is necessary or not.

When we drop some jobs from execution because they belong to the same context as the one who caused the timeout we write incorrect commands into the PM4 stream when re-emitting.

We would need to extend the handling in a way where we can say ok this job is now skipped, but we need to pretend that it isn't so that the set_q_mode handling works and then still not execute the IBs in the job.

Long story short that is seriously not going to work. So absolutely clear NAK from my side to this approach.

What we could do to avoid problems and patching pointers in the command stream is to emit only the fence signaling for skipped jobs and fill everything else with NOPs.

Regards,
Christian.

>  At that point the ring has the
> same state it had before the queue was reset and the state gets
> updated in the ring as the IBs are reemitted.
> 
> That's it.  The only other state dependent on the ring was the seq
> number to wait on for pipeline sync and I fixed that by making it
> explicit.
> 
> Alex
> 
>>>
>>>> If the relevant state is
>>>> stored in the job, you can re-emit it and get the same ring state each
>>>> time.
>>>
>>> No, you can't. Background is that the relevant state is not job dependent, but inter job dependent.
>>>
>>> In other words it doesn't depend on what job is executing now but rather which one was executed right before that one.
>>>
>>> Or even worse in the case of the set_q_mode packet on the job dependent after the one you want to execute.
>>>
>>> I can absolutely not see how stuff like that should work with re-submission.
>>
>> All you need to do is save the state that was used to emit the packets
>> in the original submission.
>>
>>>
>>>> If you end up with multiple queue resets in a row, it gets
>>>> really complex to try and save and restore opaque ring contents.  By
>>>> the time you fix up the state tracking to handle that, you end up
>>>> pretty close to this solution.
>>>
>>> Not even remotely, you have tons of state we would need to save and restore and a lot of that is outside of the job.
>>>
>>> Updating a few fence pointers on re-submission is absolutely trivial compared to that.
>>
>> It's not that easy.  If you want to just emit the fences for bad
>> contexts rather than the whole IB stream, you can also potentially
>> mess up the ring state.  You'd end up needing a pile of pointers that
>> need to be recalculated on every reset to try and remit the
>> appropriate state again.  This approach also paves the way for
>> re-emitting state for all queues after adapter reset when VRAM is not
>> lost.
>>
>> Alex
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Alex
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>> On 1/8/26 15:48, Alex Deucher wrote:
>>>>>> This set contains a number of bug fixes and cleanups for
>>>>>> IB handling that I worked on over the holidays.
>>>>>>
>>>>>> Patches 1-2:
>>>>>> Simple bug fixes.
>>>>>>
>>>>>> Patches 3-26:
>>>>>> Removes the direct submit path for IBs and requires
>>>>>> that all IB submissions use a job structure.  This
>>>>>> greatly simplifies the IB submission code.
>>>>>>
>>>>>> Patches 27-42:
>>>>>> Split IB state setup and ring emission.  This keeps all
>>>>>> of the IB state in the job.  This greatly simplifies
>>>>>> re-emission of non-timed-out jobs after a ring reset and
>>>>>> allows for re-emission multiple times if multiple resets
>>>>>> happen in a row.  It also properly handles the dma fence
>>>>>> error handling for timedout jobs with adapter resets.
>>>>>>
>>>>>> Alex Deucher (42):
>>>>>>   drm/amdgpu/jpeg4.0.3: remove redundant sr-iov check
>>>>>>   drm/amdgpu: fix error handling in ib_schedule()
>>>>>>   drm/amdgpu: add new job ids
>>>>>>   drm/amdgpu/vpe: switch to using job for IBs
>>>>>>   drm/amdgpu/gfx6: switch to using job for IBs
>>>>>>   drm/amdgpu/gfx7: switch to using job for IBs
>>>>>>   drm/amdgpu/gfx8: switch to using job for IBs
>>>>>>   drm/amdgpu/gfx9: switch to using job for IBs
>>>>>>   drm/amdgpu/gfx9.4.2: switch to using job for IBs
>>>>>>   drm/amdgpu/gfx9.4.3: switch to using job for IBs
>>>>>>   drm/amdgpu/gfx10: switch to using job for IBs
>>>>>>   drm/amdgpu/gfx11: switch to using job for IBs
>>>>>>   drm/amdgpu/gfx12: switch to using job for IBs
>>>>>>   drm/amdgpu/gfx12.1: switch to using job for IBs
>>>>>>   drm/amdgpu/si_dma: switch to using job for IBs
>>>>>>   drm/amdgpu/cik_sdma: switch to using job for IBs
>>>>>>   drm/amdgpu/sdma2.4: switch to using job for IBs
>>>>>>   drm/amdgpu/sdma3: switch to using job for IBs
>>>>>>   drm/amdgpu/sdma4: switch to using job for IBs
>>>>>>   drm/amdgpu/sdma4.4.2: switch to using job for IBs
>>>>>>   drm/amdgpu/sdma5: switch to using job for IBs
>>>>>>   drm/amdgpu/sdma5.2: switch to using job for IBs
>>>>>>   drm/amdgpu/sdma6: switch to using job for IBs
>>>>>>   drm/amdgpu/sdma7: switch to using job for IBs
>>>>>>   drm/amdgpu/sdma7.1: switch to using job for IBs
>>>>>>   drm/amdgpu: require a job to schedule an IB
>>>>>>   drm/amdgpu: mark fences with errors before ring reset
>>>>>>   drm/amdgpu: rename amdgpu_fence_driver_guilty_force_completion()
>>>>>>   drm/amdgpu: don't call drm_sched_stop/start() in asic reset
>>>>>>   drm/amdgpu: drop drm_sched_increase_karma()
>>>>>>   drm/amdgpu: plumb timedout fence through to force completion
>>>>>>   drm/amdgpu: change function signature for emit_pipeline_sync()
>>>>>>   drm/amdgpu: drop extra parameter for vm_flush
>>>>>>   drm/amdgpu: move need_ctx_switch into amdgpu_job
>>>>>>   drm/amdgpu: store vm flush state in amdgpu_job
>>>>>>   drm/amdgpu: split fence init and emit logic
>>>>>>   drm/amdgpu: split vm flush and vm flush emit logic
>>>>>>   drm/amdgpu: split ib schedule and ib emit logic
>>>>>>   drm/amdgpu: move drm sched stop/start into amdgpu_job_timedout()
>>>>>>   drm/amdgpu: add an all_instance_rings_reset ring flag
>>>>>>   drm/amdgpu: rework reset reemit handling
>>>>>>   drm/amdgpu: simplify per queue reset code
>>>>>>
>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |   2 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  13 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 136 +++------
>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 289 ++++++++++----------
>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  40 ++-
>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  13 +
>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  67 -----
>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  37 +--
>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   4 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |   2 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  21 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 141 +++++-----
>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |   3 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c     |  45 +--
>>>>>>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c       |  36 ++-
>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  41 ++-
>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  41 ++-
>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  41 ++-
>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c      |  33 ++-
>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c       |  28 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       |  30 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       | 143 +++++-----
>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 149 +++++-----
>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c     |  26 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  38 +--
>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c      |   3 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c      |   3 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c      |   3 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c      |   3 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c    |   6 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c    |   3 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c    |   3 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c    |   3 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c    |   3 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c      |  43 +--
>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c      |  43 +--
>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  43 +--
>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  45 +--
>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  46 ++--
>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  45 +--
>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      |  45 +--
>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      |  45 +--
>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c      |  45 +--
>>>>>>  drivers/gpu/drm/amd/amdgpu/si_dma.c         |  34 ++-
>>>>>>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       |   8 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c       |   4 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c       |   2 +
>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c       |   2 +
>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c       |   3 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |   4 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c     |   3 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c     |   3 +-
>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |   4 +-
>>>>>>  54 files changed, 952 insertions(+), 966 deletions(-)
>>>>>>
>>>>>
>>>

