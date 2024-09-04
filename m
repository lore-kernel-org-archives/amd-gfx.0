Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F15CCD4847
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 03:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F227710E152;
	Wed,  4 Sep 2024 03:23:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1LNoA/Xz";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4209910E152
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 03:23:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTC3wpRBZ60JKZUVNsy/cxO/FSIf4K62gwSw8vkSJS0cOdrSWvCSJjhV886ZBFJIXxAZls2coG7wf46IWycHr9RC2nPGjGJL0eSjyh/oh9zsSxxEPRpfbVjJOcOj+i9X/xy2XADKYyBYugK+nkOAV4u7CnV/rfI1NIageVh/AfrQxd5O2/ZDWgVgdm0FGo4cA9LTqu7x3GVfQhV8KCSIMec8nhsnMY2KVQqgMMVfROFoTghMsv2kWMxi2guXcqU93na16059pEkxY3835NMife/j4BSU7k/5cgy1alUJUv0pEek0HbwbFFYzKpy9QGyiZsI19aL0dBI5BUuwgRGeaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldzK/Y9EShQ1Q9sC50eq+H7P5/Z47Zq6s3U2HMJPTQA=;
 b=PE54o+q3kENEmPx8vzq3mq+TrAZ0aRnYNKxEyjSaOSn0V3Mn4BYmSVCFYkx/JqP5S/T3O7onE8fhcmPKS2nWpn7W1FbrHEYYAMPU5Qi3lgsuvbPkWcY8d/8xV1AZ9hS3Ej94Bp0yqYKOGnegZtg6FKHixtJUoXk/ew0ROGQ8tA6HOm3Xky3Ydv0DFMJBgdLS+TDpA5xVgpIXPdVNay75OLHlsbzllnPinr1RowWsYzxgOtl75ISfDJoLdBARjtOA5/tN5PpGKrgl2rZAu84caDoqQhjzHgk6kDX1FDEtFhXhX1CpJMxyWtqJTEpUX0rudGeH6QMCnFrzry6FJuiQDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldzK/Y9EShQ1Q9sC50eq+H7P5/Z47Zq6s3U2HMJPTQA=;
 b=1LNoA/XzBAOpkFNCZIfkhkDQvLTzN8Y4XrHnqwIahsFPz/aQliyqQUD9jVi4PKpwwmRKw6gqhjzg9F2sxPrQkEwMSKCT01b+hnHrwOXfFiAPLq+ICYR2REexF4722xfwU2prZMOopDp+nHbq96vHsYdjqHqoqkWtRxcuDZJEDVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Wed, 4 Sep 2024 03:23:54 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 03:23:54 +0000
Message-ID: <43d403c3-fcb6-430a-af3f-659c1108dd54@amd.com>
Date: Wed, 4 Sep 2024 08:53:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] drm/amdgpu: Use init level for pending_reset flag
To: "Xu, Feifei" <Feifei.Xu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20240902073417.2025971-1-lijo.lazar@amd.com>
 <20240902073417.2025971-3-lijo.lazar@amd.com>
 <CH2PR12MB415202E9D7D3317796D93560FE9C2@CH2PR12MB4152.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CH2PR12MB415202E9D7D3317796D93560FE9C2@CH2PR12MB4152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0249.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY5PR12MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: 5486dee5-6c7c-4d66-d3a4-08dccc910128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmNvMzVxY1A2NHlMN3FHU1NxZzVjMkE1d0p1M3NHQ0xpTXVsZTNoSVRoZzJX?=
 =?utf-8?B?QTRWdzJIQzM1a1phejJaSjVTMHl3REFFUktjWDJSeWEvS2FxYldGTitDZHhp?=
 =?utf-8?B?V2RZNWYzZUtyQkFjeXQvZFlhemNyT2wwYis5a3VVVHlWSm9UVHRUbnpYZ01s?=
 =?utf-8?B?TUp6amxBbVo4TmZkSmhGRERiSzVUWXZiTkJKMVJqTmREU2lWbGJrTDhLOFQz?=
 =?utf-8?B?SC9uM1RHQWlObnlXZTFYY0xobXQxc1FjeFgxL05pb3FMczMwSjJsdkd6MHQv?=
 =?utf-8?B?ZFNqTGJ2aWs2aWJVUHNZaTc5VFg5blFxczZEYXVoeU9nVWdaQmQ1bzh1T2Jx?=
 =?utf-8?B?UlNJSTIxMGhJNC9lcWt2Wks5dHIvWjRLckdQN21iQU80bms4N05uVmdxZFNZ?=
 =?utf-8?B?ZWptUmJCZnB3VXV6NVAvdTdMaVRSSi9yUkdTWUF4OFMyODFTVGlwZDJlVW1E?=
 =?utf-8?B?VjRzMnlGMm1nN1o4TFIwVzM5L3o4Y3Q3UnBpbFJPamJMdGNEMjZqZktmUFRN?=
 =?utf-8?B?NWJyUHlhdktoK0p5bmtYd0J0a2ZabWtabjMrQ2Q2VnhuYmJuUi9TZ2tjaWlU?=
 =?utf-8?B?a2pYb3pLbzRWYnpOR0RpaU14KzBiVm5TMVFCOHV2d0phMFVZb0NpOVp5VitO?=
 =?utf-8?B?cDJ3NTBMVVFTbi9aYkxJWE5NY0ZEWWlNT29Ya0NqQWJwMEY3cmNNUkpEajdO?=
 =?utf-8?B?M1RCMGdSa1ZKeEZTb2RVVm1Vc212Rk9pdDBkSzFQTnliY3pGYTRoVDlXVVpK?=
 =?utf-8?B?ckJwYWZML3A1b2dheXdQNDZzaUdrcDZvWWtnbVpJKys0SG94SFZDNCtFRjVE?=
 =?utf-8?B?K2hESC9tVDdKNk1hTTRrRE1tZHB6ZTlhOVVpWEJsbTg2RUdqcFRZNTA3L0tn?=
 =?utf-8?B?ZGNhSmxoOGpoMlM3aU01ZG0yVnpaSWh0MThsNVZHdmlvY1NOMFJvR2dsMXBr?=
 =?utf-8?B?cE55cFhqTktsaWFWQW9ESk12ckRGZjRIcVN1U3ZqaEhuelpWR2lNMVpZOVE4?=
 =?utf-8?B?V3NINTBJQ1VKM0RRZWdSRXVuU1QvcFFPRnR2VWhrVlNLZ0tMTklUNUMveXFy?=
 =?utf-8?B?YnlIYU9uTHVKaDFIYTFSSUM1ZmVtOUxudjV6L1d0SVdkcmdEeWxoZUlsY3BH?=
 =?utf-8?B?cFczNG9yWW5RVXVVQVVpM0M3a2I1NVJSVytCdjBWa1dqVWhadkM1Qk5TdTRp?=
 =?utf-8?B?UkROY01lZHFFMXZJazhsRUlMZVl2WW0zWGxmV3JIcjlpNEhraDljQ2FxVTN1?=
 =?utf-8?B?VEliVThIUlllSkpCQ3ZUdHRrcjM3VlVLNTFHOW93UzhvUEoyR1RYSVFiakJi?=
 =?utf-8?B?b1MyNDR2dFVPMW1vUVRlaUppcGdPMC9PclU3SUZsL3FEeWtBR21zWVFkSnpY?=
 =?utf-8?B?Y2lVWUpjYUczaW8vYytWbElBdUxtcEpCV1czR1QxZ28rWE9QMWkrWXY3aWo2?=
 =?utf-8?B?cGlTUjJuUEhlUitBTlcyTEdWZEh5bjUzRXBOWUV3ZnpCMzFMQ1JmdHJuazJ4?=
 =?utf-8?B?aWFZSmdnUmpwL21STmw4aklRUllNREk3OXc4TE8xQlhtUU5kRElmK2hQTnoz?=
 =?utf-8?B?QzBIc0hnTnJZQThMRWwyZlpMejBCT0xmMFFpM05zei90aU1QWEJheEFQWUtr?=
 =?utf-8?B?b3ZCcURubUY2NUQ1Qy9XS0tiZmEyZ0Y1NVF2cEh4RWJtZWloYnErWnNoTE54?=
 =?utf-8?B?ekVPWTcyU3J0VXJ5dkdONUMyY0N4R09lU0t6WGRUQXRoTUNtVXhzcEJGbTRr?=
 =?utf-8?B?dklqV1NXOFBvS1o2VjNhbXhPbjRwZHg0MDFxeEZNY0dTOHZjS3c0dCt0UGZw?=
 =?utf-8?B?dGU4SXF6d0Fmd0tNcllDUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0lYNkYzRnZoaEx5MkJnVHBCTC9MWHN1aHhYcUNORlg3cGgzOVg0emdzNnNs?=
 =?utf-8?B?dkJ2dWRkT3FJRXJOREg0bnZxY2hGZ2ltL0k5QXp4YmQzb2Q2TExVemxpVUk2?=
 =?utf-8?B?Mm9ZRGtLNjlJYmFWTWRyNU81ZU5aT2FmR0dXUU5ubDZKcTRNRS94NE5YbFB4?=
 =?utf-8?B?aU5WWFZQTUdyM0RIM1g3ZldTaGQ0eUVCQUFnTXhiQ3Z5dDRiQTVmTExKd1Yx?=
 =?utf-8?B?Ni9SNWlRVzJsc2ZpeXFuWGFkdW41L01STm9mS3NaRVp2a3JGNE1CamJ1OGxL?=
 =?utf-8?B?UnFFdHVuS2lKZ1FlQmYzS2FYN2MvM2N1bXRYWkpVb3FXNDBJTW9ZdkZVQ09k?=
 =?utf-8?B?RVdWU3FCYmcvS1VvYVE1WDJVeGFzQ2t5b3BWYW41OXZuUWVRZTZHUGZpT0lL?=
 =?utf-8?B?YTNNK3R4SGFaRGtnZ0VxODJ1eXczWEE1VHloOTlFQjg4TFpWaldaOTFGMFpN?=
 =?utf-8?B?d0JOdU9hdTJ5K2pxMDJPSmo3NGw4MU1wQnlDZ05zYkg1NENMcjBSM0taWG5q?=
 =?utf-8?B?Nmx5bWhNZlRsY05LaU1pVUNCaXlGRFYydTVLUG9pUjNudHIycGp2Y0dOOHJz?=
 =?utf-8?B?SGJWUm92b1dXemN2dnk4OFJ3SUZzV24yNnBoMyttVzVrcHFZMVJpcGdXaVVR?=
 =?utf-8?B?bllqa1l3TlJyVmNBeGl4ZXVYakVtSEI2UEVpSTJKeVdQVVM2bEgwZWVnemNO?=
 =?utf-8?B?OGdoU2UvSkhPeWxRZWk2NkRrYkc1aXVib2xCZHRKNTdsT3RINmZVSStsNmRU?=
 =?utf-8?B?VnY3c2ZmOUk2OGZFS1FHQmtNVXB4SHllbk9WUXhYenNFaXFIZWY1bVNKSWNr?=
 =?utf-8?B?cHNwVTdWQjM0TnR2NUYvVkhRS0RlTkZ4WHFnZVhDSjdVdGQvbHN2VlBwWW5r?=
 =?utf-8?B?cGVYbHExamk3Ty9TZEc0cWViNlBLRk9DbTNpK1lORit4NjNxNjA3cGNVamt5?=
 =?utf-8?B?Z0tYUUI2bURzcUpSWFVJcjhZckZCbUhxVDNRQTh3U3JOLzE5ZWlCZzNSSUZr?=
 =?utf-8?B?QnRIbVRyVGYwcEdOMkJGQzZlQ0ZHVUhPS1E0ckFJdWgzTXdmWlZxZDdDUzJI?=
 =?utf-8?B?OTlZRWxGTFJGanloSmJyanBNZ2lTVWx0dlRzelgvU1FTZFNOU2NFYkZkQlhJ?=
 =?utf-8?B?dTk5ejJPTzRLdUNySVlXM2dHU0MvSUtJTmcraGRkQ0szQ0IwMGVQWVh0bGJY?=
 =?utf-8?B?MER1emdrWGU4OG9wVXdMVW1OT0RsK3dBYTlxOXl3MFEvVlRwb3VMY2w1VFUy?=
 =?utf-8?B?YnFCMGIwQTFPSU1vcDlQdmF5OW5SYXRweWUwdFhEQll3dlg0SHIydEkwbzdI?=
 =?utf-8?B?a00xSjBhZG5vMndDZ1ROMjJLRmZrOVdHRVBrZDRUV244ZEZUczV3SG1OQk5G?=
 =?utf-8?B?U2ZvOHJpRi8zejRzQVNkNVo3YitqRUZCSCsxZ1BNSG9Fb21QYS8waytnTkov?=
 =?utf-8?B?RUEyTmJOQVRwaW1iTzRlQVk3Q2trdEZEalRUeVVublc3RmF1cEdkWUhoRy82?=
 =?utf-8?B?RG9PSG5CV2lLSVd3MG1LQnZXT0RLVWRVZkxpcWh2VVp3L2thWTd4TXQvbFZM?=
 =?utf-8?B?ZTRpVDVReUNUelBtb3BaTTh1V01teExxWWlSYzArM2M0QVlpNkFvMVBiNTRS?=
 =?utf-8?B?Rjd2SVNVN21qWVY3MXBmRkkySW9CeldqczRHVSt2c3lTYUF0Yml1bGFVbW5D?=
 =?utf-8?B?OFFtOUI2dHBzb0duNXNUTFh6d2swNlJUSFdJbng3Vy9wZUtvSVdTMkpNUlhW?=
 =?utf-8?B?SnVOM2VWeDZQK0E1QWkrZ1d5dTRkVVgyZWlrK3ZXc3l0eVgreC93TWpESk5k?=
 =?utf-8?B?eEtEc2pmRWw2WWxkelRVR3JvYmNTcWlPOCsySjlkd1lQcFRIaWRsczlZTXo1?=
 =?utf-8?B?bk0rLzhxdzIwTEFZY3Y5WExjU3lzb1pmM0QrbWgvemNjb3F2aTdpOTRKRHhC?=
 =?utf-8?B?R2dWbUlUclZpbFBZMkRIbnZmQ3hpeG9Lc0tpUTlJU1BIMHRtaXgvZ09zRzdl?=
 =?utf-8?B?dzBiWnBrcGRNWk52dWZibjh6N2l6QjBmZ2p6WlllZWhBSmhNeEVMUG9iYWFC?=
 =?utf-8?B?bVppRUdscjdxMFExQ2xocHR3QXR3ZCtORnR6UFliMHhvSFJGL2ViQWRrdHox?=
 =?utf-8?Q?K7K20wJEBcVy77p47K+pC9xN8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5486dee5-6c7c-4d66-d3a4-08dccc910128
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 03:23:54.5022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTpDtIK/OeTB1JAAcpPIWw3dQoAH3kEl8qIlsDiH11QAJ9rR95My/XP/CXhpe5YQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6455
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



On 9/4/2024 7:40 AM, Xu, Feifei wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Comment inline.
> 
> Thanks,
> Feifei
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Lazar
> Sent: Monday, September 2, 2024 3:34 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: [PATCH 02/10] drm/amdgpu: Use init level for pending_reset flag
> 
> Drop pending_reset flag in gmc block. Instead use init level to determine which type of init is preferred - in this case MINIMAL.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 33 ++++---------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |  6 ++--
>  .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  3 +-
>  6 files changed, 13 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4fb09c4fbf22..db5046e8b10d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1691,7 +1691,7 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
>         }
> 
>         /* Don't post if we need to reset whole hive on init */
> -       if (adev->gmc.xgmi.pending_reset)
> +       if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL)
>                 return false;
> 
>         if (adev->has_hw_reset) {
> @@ -2985,7 +2985,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>                 amdgpu_ttm_set_buffer_funcs_status(adev, true);
> 
>         /* Don't init kfd if whole hive need to be reset during init */
> -       if (!adev->gmc.xgmi.pending_reset) {
> +       if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL) {
>                 kgd2kfd_init_zone_device(adev);
>                 amdgpu_amdkfd_device_init(adev);
>         }
> @@ -3499,14 +3499,9 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>                 }
> 
>                 /* skip unnecessary suspend if we do not initialize them yet */
> -               if (adev->gmc.xgmi.pending_reset &&
> -                   !(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
> -                     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC ||
> -                     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
> -                     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH)) {
> -                       adev->ip_blocks[i].status.hw = false;
> +               if (!amdgpu_ip_member_of_hwini(
> +                           adev, adev->ip_blocks[i].version->type))
>                         continue;
> -               }
> 
> [Feifei]:  AMDGPU_INIT_LEVEL_MINIMAL indicate the minimal necessary blocks which need to do hw_init if SMC need to handle the mode1 reset. Though in newer ASICs it is smc doing the reset, in some old one, it is MP0.
>                Is it more readable if we use naming like AMDGPU_INIT_LEVEL_MINIMAL_SMC to avoid confusion ?

Original intention for levels is like -

	Define a single 'minimal' level init required for the SOC. Further
levels like suspend, s0i3, emulation/simulation etc. may be introduced
later which defines the level of initialization required for those
scenarios. Basically, the idea was to make it SOC specific with a callback.

It is kept this way now as the immediate purpose is to support 'minimal'
init required for XGMI-reset-on-init scenario for limited SOCs. In that
sense, this could be renamed that way also.

> 
> 
>                 /* skip suspend of gfx/mes and psp for S0ix
>                  * gfx is in gfxoff state, so on resume it will exit gfxoff just @@ -4320,20 +4315,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev)) {
>                 if (adev->gmc.xgmi.num_physical_nodes) {
>                         dev_info(adev->dev, "Pending hive reset.\n");
> -                       adev->gmc.xgmi.pending_reset = true;
> -                       /* Only need to init necessary block for SMU to handle the reset */
> -                       for (i = 0; i < adev->num_ip_blocks; i++) {
> -                               if (!adev->ip_blocks[i].status.valid)
> -                                       continue;
> -                               if (!(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
> -                                     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
> -                                     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
> -                                     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC)) {
> -                                       DRM_DEBUG("IP %s disabled for hw_init.\n",
> -                                               adev->ip_blocks[i].version->funcs->name);
> -                                       adev->ip_blocks[i].status.hw = true;
> -                               }
> -                       }
> +                       amdgpu_set_init_level(adev, AMDGPU_INIT_LEVEL_MINIMAL);
>                 } else if (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 10) &&
>                                    !amdgpu_device_has_display_hardware(adev)) {
>                                         r = psp_gpu_reset(adev);
> @@ -4441,7 +4423,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         /* enable clockgating, etc. after ib tests, etc. since some blocks require
>          * explicit gating rather than handling it automatically.
>          */
> -       if (!adev->gmc.xgmi.pending_reset) {
> +       if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL) {
>                 r = amdgpu_device_ip_late_init(adev);
>                 if (r) {
>                         dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n"); @@ -4518,7 +4500,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         if (px)
>                 vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
> 
> -       if (adev->gmc.xgmi.pending_reset)
> +       if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL)
>                 queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
>                                    msecs_to_jiffies(AMDGPU_RESUME_MS));
> 
> @@ -5490,7 +5472,6 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>                 list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>                         /* For XGMI run all resets in parallel to speed up the process */
>                         if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
> -                               tmp_adev->gmc.xgmi.pending_reset = false;
>                                 if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
>                                         r = -EALREADY;
>                         } else
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 82bde5132dc6..3dece2e69608 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2495,7 +2495,6 @@ static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
>         for (i = 0; i < mgpu_info.num_dgpu; i++) {
>                 adev = mgpu_info.gpu_ins[i].adev;
>                 flush_work(&adev->xgmi_reset_work);
> -               adev->gmc.xgmi.pending_reset = false;
>         }
> 
>         /* reset function will rebuild the xgmi hive info , clear it now */ diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 4d951a1baefa..33b2adffd58b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -182,7 +182,6 @@ struct amdgpu_xgmi {
>         bool supported;
>         struct ras_common_if *ras_if;
>         bool connected_to_cpu;
> -       bool pending_reset;
>         struct amdgpu_xgmi_ras *ras;
>  };
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 61a2f386d9fb..2076f157cb6a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3185,7 +3185,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
>          * when the GPU is pending on XGMI reset during probe time
>          * (Mostly after second bus reset), skip it now
>          */
> -       if (adev->gmc.xgmi.pending_reset)
> +       if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL)
>                 return 0;
>         ret = amdgpu_ras_eeprom_init(&con->eeprom_control);
>         /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 7de449fae1e3..a7a892512cb9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -860,7 +860,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>         if (!adev->gmc.xgmi.supported)
>                 return 0;
> 
> -       if (!adev->gmc.xgmi.pending_reset &&
> +       if ((adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL) &&
>             amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>                 ret = psp_xgmi_initialize(&adev->psp, false, true);
>                 if (ret) {
> @@ -907,7 +907,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
> 
>         task_barrier_add_task(&hive->tb);
> 
> -       if (!adev->gmc.xgmi.pending_reset &&
> +       if ((adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL) &&
>             amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>                 list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
>                         /* update node list for other device in the hive */ @@ -985,7 +985,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>                 }
>         }
> 
> -       if (!ret && !adev->gmc.xgmi.pending_reset)
> +       if (!ret && (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL))
>                 ret = amdgpu_xgmi_sysfs_add_dev_info(adev, hive);
> 
>  exit_unlock:
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 16fcd9dcd202..7225f63c26b4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1616,7 +1616,8 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
>                         break;
>                 default:
>                         if (!ras || !adev->ras_enabled ||
> -                           adev->gmc.xgmi.pending_reset) {
> +                           (adev->init_lvl->level !=
> +                            AMDGPU_INIT_LEVEL_MINIMAL)) {
> 
> 
> [Feifei] Is it a typo? If adev->init_lvl->level taking place of adev->gmc.xgmi.pending_reset, here should be(adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL)

Yes, this is incorrect. Thanks for catching.

Thanks,
Lijo
> 
>                                 if (amdgpu_ip_version(adev, MP1_HWIP, 0) ==
>                                     IP_VERSION(11, 0, 2)) {
>                                         data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL_ARCT);
> --
> 2.25.1
> 
