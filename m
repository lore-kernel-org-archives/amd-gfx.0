Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D91FD41143
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jan 2026 09:08:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F029C10E70A;
	Thu, 15 Jan 2026 09:08:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p4VVd+54";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E21010E70A
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jan 2026 09:08:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Edbzi/wjXm5DL4LPdITqmgY0lS/+43/8srZI+AZ2gW+cAhyF6G/zlfP+uve7mG+2s4oU9MdORq/987a+j30me7BWk2usX7qCZKkdvW4HMm+RbPWmw40Z2qPaSPnRKqfDX2/djRl4L1x835oOb9Lay06L7I6pb25lA5F8LVBsBGWt4T0IiwJYxpEdhRvsL2p1BsyltYUQwPqiZJ+lB/oKZ8EiQ1NPriCedBWRIT6wcEVX75nbkTEFRTvZURoDnLNpOnmdLfTR6pP8K+IwwbvwRTgWAVh3zErr4HC8x8AOXlRWXvAldxxkXTO1VzC+qX9FkOSsmKkJzWSpsq/ias6CIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLbmjcviGAEGK1wDW+3O5ysboK1rovADIatFhDEklSA=;
 b=bntOJjpPj6eF2hV+VT9oUqN+RweRyzfT37dd14ZDHgX9w2sWL3QIzVGvMUrGpiCyaxWiAQhCw89f1pBOBfuXUzo32lrZ/mRjko77dKRz02OcHsw4ZxxBc4WsanRD3flD4hLo6wseMNdygRGczro/746Pr3/PBycPcBJ8oYfww+NswkTko2ahHjgccPabksafyQbeMI0ls/rcHSeFzhnXktQ7md9ltbc0/ZRznGF2PpqAO9unL2C7jxH7kVJtqun1/TbMDht85D+sEDkmJIH2E0AWvGuyrBYqWw42ukLSYOsHp65K4pvQ06Sc9n1c2mml/oV2pFylB7+B0N98kyx60g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLbmjcviGAEGK1wDW+3O5ysboK1rovADIatFhDEklSA=;
 b=p4VVd+54BpAZjHddyVbSWm+5nJNrK7BzS7PVtx3xXuwiK88CW5Lh+tRL5eSZ3Y+M6yHYFPSkJDjL0KT8wEg/MBT4wl2o5c2QJ6Z//XTGgmFqy9HgLvFrX/N56YjvlcCXM2U0JTvmmL1mo44E23E+MMZT0i3AEy2cNZtLcMxCXDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB7085.namprd12.prod.outlook.com (2603:10b6:303:238::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 09:08:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 09:08:02 +0000
Message-ID: <47105606-f0ea-4358-a7a7-8ff559d6d762@amd.com>
Date: Thu, 15 Jan 2026 10:07:57 +0100
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
 <6bbdb38b-75d0-4867-b4b6-afa5dc0b479e@amd.com>
 <CADnq5_Nm+E3trPt7LLUMBC697Upjnm6y46vdyXwBLxb_PHLxCQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_Nm+E3trPt7LLUMBC697Upjnm6y46vdyXwBLxb_PHLxCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: 956c4287-1eee-44a4-09ce-08de541595fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7142099003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlV5b3o2WXNPMFpvVHYvbWg2eHYzS01oMmhpa0hzT1QzYlkrdkRZRUpja1Y5?=
 =?utf-8?B?N0hKcXZzNDl5QXhKay9qWnNwemhmM1BBRHNLdGtISFMzWkVwVjBkSERNRHBW?=
 =?utf-8?B?d1p4ekZZMkhVb0k4UFB2OEhzQ0dsU1Z3b21aK01iY1RTUGpKbVNKcUFWTFdS?=
 =?utf-8?B?RlBGUGtpMzJQVVM3SkpRTVNKaGhPZitja2FLTFZmNC94RkxoWi8yWVpPTWt1?=
 =?utf-8?B?UFJGZkxOSXkzNkQyV1VLQy82bUdNUmlwVGxUN1RYT0pkK0xRVnV4WndMMmdT?=
 =?utf-8?B?UFRsbkE1TU1UTU5EYmV0d0pmejJNQTR0dWZMdFJyMjhIa2kyNktJNWRvVXcr?=
 =?utf-8?B?N0pZUkpTQWxoa3hJZ3dJMkwwRUhUMnNNdldFQmk4aitKSUNVQVQyeWRGYjdj?=
 =?utf-8?B?eEpvS1JTTXVYUTJHajdGUzdyUjJZeDN5Qm1hSkdxcmlDdEtsRlpGdmdKRnFH?=
 =?utf-8?B?KzNkR1VPV0JLMlhVVll0V3hEeCtiRktPdkNZRkhYWHNzK3RlcGIyRkZKV2F2?=
 =?utf-8?B?MlMzcG10MnU1bDNwZ2pBQ0dHWXpoZDVBNDVJQ1k5Nmk0MHh5Q2lZWWhGNG5M?=
 =?utf-8?B?NWdTOHdrSHg3blI3UlgxL2Npam5va3RTazZjTnZzblFmV0s1OFc0YXFFbUhM?=
 =?utf-8?B?VTJHNm1DSXlodmdzelVqSytzd0h5QXRrcWdtNlQ2R3RqYUhLdkVBOHQ5RFdP?=
 =?utf-8?B?M28zNXVlSW5wb0ZYOWFjOEVoUmlJd1hxVi90d2hkMkpZbXNRdEw0WGJlNnJM?=
 =?utf-8?B?N0Q4MjJqbUxBTGRUSk5ETFJQNlNQVjVJbmNjWDhQS2xiZDRTc0d2V1dUem1Y?=
 =?utf-8?B?dEp0SS9BZHloUy90aXpNem83ZFRGUnI3QVNLVzFNSEN5a0VWMVJDTHkzeVdz?=
 =?utf-8?B?R0RaOW1xMUxUUlMxWHVXaHpQS2t6cCtOSEtRZmdONzJYRjZHWE9IR0dDQXdt?=
 =?utf-8?B?Zzc2TXpJOSt0Z1VuMmlvbmt0QmhiSUtFV1k3dmxYUzhSWFhiMC8wYkFXQnJa?=
 =?utf-8?B?enRKRWZZUWFYckViemxURUdpZ3dMZC9xTm1MVlVScCtYZjFwM1A0cUlnM3A3?=
 =?utf-8?B?bitoWGFSbTkxT0JMRFlnZ2g0L3dOcG9PMUdKSmxBWlh1YWRaeEVsQUpEVGdH?=
 =?utf-8?B?aVN0UDAvaFlSVTdzMUV4bWJ1dXA4dzI2RHkra3lmSG9IUWVwaVRRMUhvbC9X?=
 =?utf-8?B?YXhnNEN2TzhqOTd6dmNBbHJjRnNSWDdycVVPOXliSmR1eEJ5WmYxRGZLak9N?=
 =?utf-8?B?WmljdFZaUkcyY3ZLSWJaRDJCOWsrVFRiTUJHM2EyL1ZnNUNZSDEwZVVRQk9B?=
 =?utf-8?B?eU1RMS9IZXJXR1RnTllIdUh1S0wxRFpWdVZtYndwSHRKTGRsdm5TZUxRbXA5?=
 =?utf-8?B?dEhvUWJZc0NFckNXY3N4N1lIVTBrUGdNazFmMG5CNFBOOWgwWmZDV3JtODVD?=
 =?utf-8?B?MlU1QVNZcVB5ZThudHQ3MEVyQ1FWTW9jN3pjTGFkeGN5eDJNUnBUdkUreXEz?=
 =?utf-8?B?c2FJUitQVjhXOFFvK1p6Y05WRFhWY3VxV2k1cXVLaGtkY0kwUk82bE83d0Vi?=
 =?utf-8?B?WWY4Ylk0amlzdU50Tndja08vOGdBZW5RYjRKeXE1RnBGcWNNeGdPbEwyNFZo?=
 =?utf-8?B?YStKbTB2U2l3S01iOTVnWXcwT05kcTFiekdNeGNpUjlSWTYwUytqOTNROHI4?=
 =?utf-8?B?YVM1ekhqWEhVYjlRallQUlByc3drQ0ZJOXg3NEwyM3AwcW0zZ1hhVWpYbXVm?=
 =?utf-8?B?ZzUrNTR6U2NOMHdUQmcvT09XR1YydVFOMnl6SzhrTi9tbTBFWHJkdEthV1hL?=
 =?utf-8?B?cVhOa1lnbDM4ZytyTzlsUittZ09OZjhqRGZpQy9rTXRxNFQ1WitPdE5paE5h?=
 =?utf-8?B?NXE2Unl3ZStjOHl5L1MvSDF1UWkxUHprWG1yTHk2bGxvRmtQY3hybkJ3b0xi?=
 =?utf-8?B?Zyt6ZzVFelZuZEpqdWVKRE9sVStnankyNTVPYkd5dCtLOG5sZnhnVm1ieGE3?=
 =?utf-8?B?VFJleEp2MmFhRmd4WU84SXF1RkFWc3dsQlp1cUVHQUF0V1pIMUxLcWk3M05s?=
 =?utf-8?B?WTZYcm9CL2RNS2J1cjBNemh6TDY3OTg0WGJ2cEpPRXM1blpiTlJIUW0zUzVL?=
 =?utf-8?Q?AbsE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7142099003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFZLRHVucEFiUm03NVptRGFUMjB2ckFwb3JxSHByQzZobEZzOWhVR3psOTI2?=
 =?utf-8?B?dVZXK1lvMnVOd1QrZ0dOdmwxQi9PTXRZeWVvTi9YNXFYUU9LNUxYYXJsaGQ3?=
 =?utf-8?B?bHFuTGZpZTlkN1lrMXBxVTlHTEtGMkUrVXowOHVDSDJ6aUNvWENmQ0w5Z1pG?=
 =?utf-8?B?MDFQb2JyZXdRVHY0MGxpZ2Y4bEM0YzcyeTRDM3lVL1lCVXVFRXJFTWZyTzl5?=
 =?utf-8?B?M0ZiWFJlOVZqanBudkgzSjR4NklYTWE5R3gyUUpUcDlSN0JhTHlLN1dxbERL?=
 =?utf-8?B?SU1MeVBEZGZoSGxGaHhKZXc5RHN1WStBQm04d3U4QlVNNU8vTzZtdnVwaHdR?=
 =?utf-8?B?ZlpuRTFGVzJrUkhFL2wxdHk2V2lUVjZ3QnVTd2w3eUMrTFpaeTlYbFN2OGwx?=
 =?utf-8?B?ai9KTmpCOXRPU0dGVlZ1a0JwbGJQZHBYNDhhQzRjNE9KZHhSSFczNW15M085?=
 =?utf-8?B?Nmtud0YvOFB6aW9mMXhVL3JDWmMyczg1RGVxT3N1amdSMUhMb2N1b3I2aUNZ?=
 =?utf-8?B?WkJzWWF3OXllemZzT1NVSjQ1Q3RBSFZyclIyRWhkUG1GL0NFU1dML0tGK1hj?=
 =?utf-8?B?U0dyNWNSenRtTm5JRmNrcElFMkRrY3BKWVUyVy8wVFVKbTlhdHV5Rng1NXJB?=
 =?utf-8?B?clByWHp0WXlENUt3UVlXaFlDZFBubUdPNzZPUGhhWUg2Z2FQTTNqTTlqbGxt?=
 =?utf-8?B?ek5sY0hYMDR4b2ZnVmFQajZVQU1xTmN6VFB5WFBhYW5hVE5ld1NaMXF1WEZO?=
 =?utf-8?B?WTZZUkpSMi9pbzlUQVVjZFRKb1QxclluYzdUOWZ6VHUySFF4cFlVbjRMb3ll?=
 =?utf-8?B?VHByZTJNaWlnOVRGN0VHRVNISTNYb25Jb1pIa1VQUDlDUkE4a3RjYWRGZ21V?=
 =?utf-8?B?SFlXTFNvNUdwYUdSYThnMzlaNEhRK3VmSmRJa0h0SzNGU0ZrWm5pQXV6SGZQ?=
 =?utf-8?B?Mm5vMzV4L2dDbXJ5Q3J3cFJVOCtWVTlDWGJ0aUNUZ2Rrb0FaM2xGSVZiRkpY?=
 =?utf-8?B?QlF4QTVJRzc2R2JVVytHOXBqWXVKN3BzbWJZS0hHOXl0WHRFL29uWTdSMFlL?=
 =?utf-8?B?SVgrNEQ0RXZzQ0loNGRvSnQ5dUFxWG9UOVhLZ3FUTTNtZG9uS2gzYUlpQmhz?=
 =?utf-8?B?WnNUTE54UzBacHJGZ2ZnaHpYTkpDc0ZoaG12RzVCRlpoL0tMRGFnMnAxREpJ?=
 =?utf-8?B?T3FjWDZzTzBReUtXWHZ1eXFHVHo0Z0N3QWEvVjJTak4zMWI5K3J4czNKNTd4?=
 =?utf-8?B?SDNOZEVVUjlyd08vdHk0UkYyZDBpdStrRThoMnpZK3BTQitNTTJWekxyYk5K?=
 =?utf-8?B?RmJiV0djNEF4U1B1amlDbTJrSUlSZ3Z0RXNxMUtGMDJERGJvNnBDaVpXQ21Z?=
 =?utf-8?B?aWUyV1EwTC8rN2ZFd2lzUG1YVHRRcE05S0V4dEF4OXlBWlZMcmVWdjl4OWxh?=
 =?utf-8?B?WEIvWDVtRDVJWUhoZkRkOEwwSDZUTzM1Nm40NHRJalZVTVhZeExzZ29rY1hP?=
 =?utf-8?B?WE0zWE5ldTdBcHNET0F5UnYreHRKOHZFdlRhL0hKaTlBUVJQaUpLR1dUSGxt?=
 =?utf-8?B?SWdNcHFpSXF6TDhLdzh3cWhWUDU2L0pobTcvWTA5a3IwKzRmQ0NwdnNleHMr?=
 =?utf-8?B?N0FiRExpbC9BWk5RZEhQeWF1dXZRN3JFVHV2S3lhRTduSTIzdkRER3RrN0tK?=
 =?utf-8?B?U1pidFlHOHRsTkJRbjJDU3d4U1I1OWZvbTRnQlNOdmZKQ2o0NWVXTlBIWC81?=
 =?utf-8?B?RUV2Y1hmaHpRSFQycnBIRytzRTNhaXVWVDFkSkZjTjIwbWxSck82cDB2aEpa?=
 =?utf-8?B?T2tsRG53ZXgyRmpZK29EZ2QyaEovZUJlY2M1QSszU2NNTzJNRDE1czlwQ1Zk?=
 =?utf-8?B?SzJRbW9xOGExWXpYQkZaQnBraWFkUUZ6Zlo2NkhGcHRIT2dpMnFoYTErUlpS?=
 =?utf-8?B?NGtSZkVKREMzTmZEbUowVXphYS9vVUpiVW1yRTVrVVByWTd1aVdmRFJYQlNn?=
 =?utf-8?B?QU1MaXRNOWozRVlGbUcydHFIeW9KeDdJQkpNYVVIVFJZNnpYS2tTTXkrdnNt?=
 =?utf-8?B?QW1vYzZ5bkgwYk1kQ0sxMTd4RWgzMUFacUxLU1VyWmNGTVNKZ244b3NtZzhR?=
 =?utf-8?B?cENoT2xwWlVFRFBoQkEwaTJMN2dFOE9hbVZiTisxam9QM3I1WDlQc2hOUzBF?=
 =?utf-8?B?QXZCQnVScFRvazVnWGpCZll1M1lwcytlbjJWOFJGa0tTOE5GWTQxRXBCajB0?=
 =?utf-8?B?NzJQZkdhRmltdm02K2JFWHlhOGU2Tk53YlgreDBEUFNHK2JvSjlBdnY1YXht?=
 =?utf-8?Q?HvEybQU4wCAdhdbaEw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956c4287-1eee-44a4-09ce-08de541595fe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 09:08:02.3451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8D6vjpka7UrtwtBEQXCG8a3DHBByuhnRvbCBPOSpg/hK1qKhH6WI9OFJGGI8gweJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7085
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

On 1/14/26 17:36, Alex Deucher wrote:
> On Wed, Jan 14, 2026 at 5:45 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 1/13/26 23:36, Alex Deucher wrote:
>>> On Tue, Jan 13, 2026 at 10:34 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>>>
>>>> On Tue, Jan 13, 2026 at 9:48 AM Christian König
>>>> <christian.koenig@amd.com> wrote:
>>>>>
>>>>> On 1/13/26 15:10, Alex Deucher wrote:
>>>>>> On Tue, Jan 13, 2026 at 8:57 AM Christian König
>>>>>> <christian.koenig@amd.com> wrote:
>>>>>>>
>>>>>>> Patches #1-#3: Reviewed-by: Christian König <christian.koenig@amd.com>
>>>>>>>
>>>>>>> Comment on patch #4 which also affects patches #5-#26.
>>>>>>>
>>>>>>> Comment on patch #27 and #28. When #28 comes before #27 then that would potentially solve the issue with #27.
>>>>>>>
>>>>>>> Patches #31: Reviewed-by: Christian König <christian.koenig@amd.com>
>>>>>>>
>>>>>>> Patches #32-#40 that looks extremely questionable to me. I've intentionally removed that state from the job because it isn't job dependent and sometimes has inter-job meaning.
>>>>>>>
>>>>>>> Patch #41: Absolutely clear NAK! We have exercised that nonsense to the max and I'm clearly against doing that over and over again. Saving the ring content clearly seems to be the saver approach.
>>>>>>>
>>>>>>
>>>>>> I disagree.  If the ring emit functions are purely just emitting
>>>>>> packets to the ring, it's a much cleaner approach than trying to save
>>>>>> and restore packet sequences repeatedly.
>>>>>
>>>>> Exactly that's the problem, this is not what they do.
>>>>>
>>>>> See gfx_v11_0_ring_emit_gfx_shadow() for an example:
>>>>>
>>>>> ...
>>>>>         /*
>>>>>          * We start with skipping the prefix SET_Q_MODE and always executing
>>>>>          * the postfix SET_Q_MODE packet. This is changed below with a
>>>>>          * WRITE_DATA command when the postfix executed.
>>>>>          */
>>>>>         amdgpu_ring_write(ring, shadow_va ? 1 : 0);
>>>>>         amdgpu_ring_write(ring, 0);
>>>>>
>>>>>         if (ring->set_q_mode_offs) {
>>>>>                 uint64_t addr;
>>>>>
>>>>>                 addr = amdgpu_bo_gpu_offset(ring->ring_obj);
>>>>>                 addr += ring->set_q_mode_offs << 2;
>>>>>                 end = gfx_v11_0_ring_emit_init_cond_exec(ring, addr);
>>>>>         }
>>>>> ...
>>>>>         if (shadow_va) {
>>>>>                 uint64_t token = shadow_va ^ csa_va ^ gds_va ^ vmid;
>>>>>
>>>>>                 /*
>>>>>                  * If the tokens match try to skip the last postfix SET_Q_MODE
>>>>>                  * packet to avoid saving/restoring the state all the time.
>>>>>                  */
>>>>>                 if (ring->set_q_mode_ptr && ring->set_q_mode_token == token)
>>>>>                         *ring->set_q_mode_ptr = 0;
>>>>>
>>>>>                 ring->set_q_mode_token = token;
>>>>>         } else {
>>>>>                 ring->set_q_mode_ptr = &ring->ring[ring->set_q_mode_offs];
>>>>>         }
>>>>>
>>>>>         ring->set_q_mode_offs = offs;
>>>>> }
>>>>>
>>>>> Executing this multiple times is simply not possible without saving set_q_mode_offs, the token and the CPU pointer (and restoring the CPU pointer content).
>>>>>
>>>>> And that is just the tip of the iceberg, we have tons of state like this.
>>>>
>>>> There is not much more than that.  I looked when I wrote these
>>>> patches.  Even this state should be handled correctly.  In this case,
>>>> the state is saved in the job at the original submission time and is
>>>> explicitly passed to the emit ring functions.  As such the original
>>>> state is reproduced.  In this case, ring->set_q_mode_offs and
>>>> ring->set_q_mode_ptr get reset in gfx_v11_0_ring_emit_vm_flush().
>>>> Then they get set as appropriate based on the saved state in the job
>>>> in gfx_v11_0_ring_emit_gfx_shadow().  It emits the same ring state
>>>> again.
>>>>
>>>
>>> I just fixed up the set_q handling locally.  I added a helper which
>>> saves the state of the ring (any ring->set_q values, etc.) in the job
>>> before we schedule the IB.  Then after the reset I restore the ring
>>> state before re-emitting the IB state.
>>
>> Exactly that doesn't work.
>>
>> See the set_q_mode handling works by looking at the next job in the queue and determining based in PM4 code if executing the packet is necessary or not.
>>
>> When we drop some jobs from execution because they belong to the same context as the one who caused the timeout we write incorrect commands into the PM4 stream when re-emitting.
>>
>> We would need to extend the handling in a way where we can say ok this job is now skipped, but we need to pretend that it isn't so that the set_q_mode handling works and then still not execute the IBs in the job.
>>
> 
> Explicit re-emit is the only way this can easily work correctly.  We
> save the ring state and and job state in the job and then we replay
> the state and re-emit a proper coherent packet stream after the reset.
> When we re-emit, we update the offsets as appropriate so that the
> logic works properly as you replay the job stream.  You can skip the
> IBs for the timedout context, but as long as the rest of the logic is
> there, everything works.  Saving and restoring the opaque ring
> contents is much harder because you need to either save a bunch of
> pointers or try and determine which offsets to patch, etc.

Or you tell the HW to continue at the place you stopped excuting and before the reset and use the conditional execute all jobs are wrapped up in anyway to determine if they should execute or not or overwrite the commands with NOPs when for engines who don't use the conditional execute.

Re-emitting the command stream would only be necessary if we need to change the commands in anyway, and even if we would need to do that then I would say that we should not emit the commands again at all.

I have patches in the pipeline to remove the job object from the reset path, so that we can free it up directly after submission again and completely solve all the lifetime issues we had with that.

Re-emitting completely breaks that again.

Christian.

> 
> Alex
> 
>> Long story short that is seriously not going to work. So absolutely clear NAK from my side to this approach.
>>
>> What we could do to avoid problems and patching pointers in the command stream is to emit only the fence signaling for skipped jobs and fill everything else with NOPs.
>>
>> Regards,
>> Christian.
>>
>>>  At that point the ring has the
>>> same state it had before the queue was reset and the state gets
>>> updated in the ring as the IBs are reemitted.
>>>
>>> That's it.  The only other state dependent on the ring was the seq
>>> number to wait on for pipeline sync and I fixed that by making it
>>> explicit.
>>>
>>> Alex
>>>
>>>>>
>>>>>> If the relevant state is
>>>>>> stored in the job, you can re-emit it and get the same ring state each
>>>>>> time.
>>>>>
>>>>> No, you can't. Background is that the relevant state is not job dependent, but inter job dependent.
>>>>>
>>>>> In other words it doesn't depend on what job is executing now but rather which one was executed right before that one.
>>>>>
>>>>> Or even worse in the case of the set_q_mode packet on the job dependent after the one you want to execute.
>>>>>
>>>>> I can absolutely not see how stuff like that should work with re-submission.
>>>>
>>>> All you need to do is save the state that was used to emit the packets
>>>> in the original submission.
>>>>
>>>>>
>>>>>> If you end up with multiple queue resets in a row, it gets
>>>>>> really complex to try and save and restore opaque ring contents.  By
>>>>>> the time you fix up the state tracking to handle that, you end up
>>>>>> pretty close to this solution.
>>>>>
>>>>> Not even remotely, you have tons of state we would need to save and restore and a lot of that is outside of the job.
>>>>>
>>>>> Updating a few fence pointers on re-submission is absolutely trivial compared to that.
>>>>
>>>> It's not that easy.  If you want to just emit the fences for bad
>>>> contexts rather than the whole IB stream, you can also potentially
>>>> mess up the ring state.  You'd end up needing a pile of pointers that
>>>> need to be recalculated on every reset to try and remit the
>>>> appropriate state again.  This approach also paves the way for
>>>> re-emitting state for all queues after adapter reset when VRAM is not
>>>> lost.
>>>>
>>>> Alex
>>>>
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> Alex
>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>> On 1/8/26 15:48, Alex Deucher wrote:
>>>>>>>> This set contains a number of bug fixes and cleanups for
>>>>>>>> IB handling that I worked on over the holidays.
>>>>>>>>
>>>>>>>> Patches 1-2:
>>>>>>>> Simple bug fixes.
>>>>>>>>
>>>>>>>> Patches 3-26:
>>>>>>>> Removes the direct submit path for IBs and requires
>>>>>>>> that all IB submissions use a job structure.  This
>>>>>>>> greatly simplifies the IB submission code.
>>>>>>>>
>>>>>>>> Patches 27-42:
>>>>>>>> Split IB state setup and ring emission.  This keeps all
>>>>>>>> of the IB state in the job.  This greatly simplifies
>>>>>>>> re-emission of non-timed-out jobs after a ring reset and
>>>>>>>> allows for re-emission multiple times if multiple resets
>>>>>>>> happen in a row.  It also properly handles the dma fence
>>>>>>>> error handling for timedout jobs with adapter resets.
>>>>>>>>
>>>>>>>> Alex Deucher (42):
>>>>>>>>   drm/amdgpu/jpeg4.0.3: remove redundant sr-iov check
>>>>>>>>   drm/amdgpu: fix error handling in ib_schedule()
>>>>>>>>   drm/amdgpu: add new job ids
>>>>>>>>   drm/amdgpu/vpe: switch to using job for IBs
>>>>>>>>   drm/amdgpu/gfx6: switch to using job for IBs
>>>>>>>>   drm/amdgpu/gfx7: switch to using job for IBs
>>>>>>>>   drm/amdgpu/gfx8: switch to using job for IBs
>>>>>>>>   drm/amdgpu/gfx9: switch to using job for IBs
>>>>>>>>   drm/amdgpu/gfx9.4.2: switch to using job for IBs
>>>>>>>>   drm/amdgpu/gfx9.4.3: switch to using job for IBs
>>>>>>>>   drm/amdgpu/gfx10: switch to using job for IBs
>>>>>>>>   drm/amdgpu/gfx11: switch to using job for IBs
>>>>>>>>   drm/amdgpu/gfx12: switch to using job for IBs
>>>>>>>>   drm/amdgpu/gfx12.1: switch to using job for IBs
>>>>>>>>   drm/amdgpu/si_dma: switch to using job for IBs
>>>>>>>>   drm/amdgpu/cik_sdma: switch to using job for IBs
>>>>>>>>   drm/amdgpu/sdma2.4: switch to using job for IBs
>>>>>>>>   drm/amdgpu/sdma3: switch to using job for IBs
>>>>>>>>   drm/amdgpu/sdma4: switch to using job for IBs
>>>>>>>>   drm/amdgpu/sdma4.4.2: switch to using job for IBs
>>>>>>>>   drm/amdgpu/sdma5: switch to using job for IBs
>>>>>>>>   drm/amdgpu/sdma5.2: switch to using job for IBs
>>>>>>>>   drm/amdgpu/sdma6: switch to using job for IBs
>>>>>>>>   drm/amdgpu/sdma7: switch to using job for IBs
>>>>>>>>   drm/amdgpu/sdma7.1: switch to using job for IBs
>>>>>>>>   drm/amdgpu: require a job to schedule an IB
>>>>>>>>   drm/amdgpu: mark fences with errors before ring reset
>>>>>>>>   drm/amdgpu: rename amdgpu_fence_driver_guilty_force_completion()
>>>>>>>>   drm/amdgpu: don't call drm_sched_stop/start() in asic reset
>>>>>>>>   drm/amdgpu: drop drm_sched_increase_karma()
>>>>>>>>   drm/amdgpu: plumb timedout fence through to force completion
>>>>>>>>   drm/amdgpu: change function signature for emit_pipeline_sync()
>>>>>>>>   drm/amdgpu: drop extra parameter for vm_flush
>>>>>>>>   drm/amdgpu: move need_ctx_switch into amdgpu_job
>>>>>>>>   drm/amdgpu: store vm flush state in amdgpu_job
>>>>>>>>   drm/amdgpu: split fence init and emit logic
>>>>>>>>   drm/amdgpu: split vm flush and vm flush emit logic
>>>>>>>>   drm/amdgpu: split ib schedule and ib emit logic
>>>>>>>>   drm/amdgpu: move drm sched stop/start into amdgpu_job_timedout()
>>>>>>>>   drm/amdgpu: add an all_instance_rings_reset ring flag
>>>>>>>>   drm/amdgpu: rework reset reemit handling
>>>>>>>>   drm/amdgpu: simplify per queue reset code
>>>>>>>>
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |   2 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  13 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 136 +++------
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 289 ++++++++++----------
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  40 ++-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  13 +
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  67 -----
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  37 +--
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   4 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |   2 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  21 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 141 +++++-----
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |   3 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c     |  45 +--
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c       |  36 ++-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  41 ++-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  41 ++-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  41 ++-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c      |  33 ++-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c       |  28 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       |  30 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       | 143 +++++-----
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 149 +++++-----
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c     |  26 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  38 +--
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c      |   3 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c      |   3 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c      |   3 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c      |   3 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c    |   6 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c    |   3 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c    |   3 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c    |   3 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c    |   3 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c      |  43 +--
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c      |  43 +--
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  43 +--
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  45 +--
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  46 ++--
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  45 +--
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      |  45 +--
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      |  45 +--
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c      |  45 +--
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/si_dma.c         |  34 ++-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       |   8 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c       |   4 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c       |   2 +
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c       |   2 +
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c       |   3 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |   4 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c     |   3 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c     |   3 +-
>>>>>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |   4 +-
>>>>>>>>  54 files changed, 952 insertions(+), 966 deletions(-)
>>>>>>>>
>>>>>>>
>>>>>
>>

