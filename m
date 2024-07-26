Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45F3C3DA49
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 13:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63E0010E322;
	Fri, 26 Jul 2024 13:13:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pi38mOul";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4177C10E322
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 13:13:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUxlBk961T7AkfsqayF361smXkA/+M+I6UFa/BvH3A8hP8i+s4Uf67YrgppmyauTQFp+0w3u6nfx4Xvem/8zEUXhFS/h1EazX+Uog9RqaPZaAThAxNno9lcbjGlU39cz97UDEllvQ/ggqI/MHdPNuCfYI/GuOxJXUlD9N3AAbyyImu9G/4qlfyVXnJ5Dm3z3uGQ5RyZGZN/IiNKP4J9tyylIpspjQfq35EdaE02yUZzUlKq2F1urkiq/F8tiXTdXdSrA8Wad34pjSQVakclWzoe4d+6vJ7hPFKGjF1+8bXMAF2XpMJoLF9j+VGpty6/OeK9l+AarhdqifXHQ20ofIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbhKsiBxz6nZWxb8VdAmDi3vfLn7LrCn8OAlHa+P0IE=;
 b=g0mlA9qvu3jntRMl8OtCHAXDYTBRbA7LY0OtkGrtEQIRLWBxnlbuTdQomDyLZ+i5wT+qABDuP5TAm4qrlw9XZ4gwv9/uq+4okD9fFxX2ZntmrEfg6o09ZfoVL5wGYuLaGz+uhsL1++VZUB4IHWHRjkc4QoYLIwU9ws3nE9VSiHcZFInzphFCYhz2jf1kfYatf4bEaQBfX/zynC/HYYN/gCDmoNQUUQ+9ePU1siMYfcPrHUeZLalKAkyJysP1EOfRGIWC4hFxwCIeBvZqVl6Kzti6U9NFsOMtqDIQY1yet4V3sVXEUSPOzF9TmE6cZbVgj5MCtPhhhPVVuSe7V6RWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbhKsiBxz6nZWxb8VdAmDi3vfLn7LrCn8OAlHa+P0IE=;
 b=pi38mOulAdIg0+isr3aFozecpQneeNGoH9i4FnVWogmeH0lXV2BtksSBZd2zLcSDR6Gs7SdH1Z2pABAyhkEsjnZXryZkixmYDCU7p4v9yeAEFKYn2JA/L7D6pukmK9eYEubXwun7ZwvrRH3AVSOd0vM8xWqa39jx3NDPiWp9WsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 13:13:14 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 13:13:14 +0000
Message-ID: <fa5af4fe-cd23-5e6d-7e32-04bb0155f6c5@amd.com>
Date: Fri, 26 Jul 2024 09:13:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix missing error code in
 kfd_queue_acquire_buffers
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Philip Yang <Philip.Yang@amd.com>
References: <20240726064712.2167971-1-srinivasan.shanmugam@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20240726064712.2167971-1-srinivasan.shanmugam@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::29) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|IA1PR12MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 352e8b47-275b-44b3-42f2-08dcad74b497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmpPcmJQUDZkTDRZcVJFT2hFQlYreVVrRjZob0ViVk9HNFNBRERncHQ5dE9r?=
 =?utf-8?B?MVgxTVlFNlhhM0p0bEVjNEdWZExHREQ0eDZZMjdHS0U2MGhKcXh3R01haVBP?=
 =?utf-8?B?RUpkcitub1Y0alJtbGhtaitVSzI1dGw4enVJaGFQMzRZOFc5aXNCM0FEK1hK?=
 =?utf-8?B?UXZHVlVFYnkvM3lvOWFDRVRNNjk3eGlIaEhvQnZDTEg0bGFQT1Q0Mnc1bVhH?=
 =?utf-8?B?NTBXcmRxMElkcVpaTTFtYzRFUHNmL3NIRlAyQ0NOWTRJamI4TmsyMEdXV3h3?=
 =?utf-8?B?MGNnN1NYRjVWelN5MUhXTG9lenRMNkUyL1FxWE1GRDd0Zm0xSjhxd2NNQ0Iv?=
 =?utf-8?B?UnJmNWlkMUdCNTB4T3VCcmttZzRnbzFVSEQ2QzAwdFJ5U1hxc2FQVndsVXhC?=
 =?utf-8?B?OExNKzBraHpYNWVqTTRObXBRTzk0R0JCRWs2K29veTNXSzloS0txZ01adnY0?=
 =?utf-8?B?VzIxNHVDRUlOVHZLR3RRMkNERzlYVzQrZDBFaDZUdCthWXZMbjM3VE81b1VG?=
 =?utf-8?B?TjZSSWdHNWluTDRLL0p1S0h2bnlvOWJHRUY2ckZKbkIrczN5TVZnSWV0QVhC?=
 =?utf-8?B?Ly9JYUhwcDJKSk84QldvVkdBcjFZZW95a2xYNGtpUnFIQU5TeVlrdUQvK3lQ?=
 =?utf-8?B?c3ErL1ZmbTNHTFUxS2hBSThxOENyelBweUpyYnM1dUxFbU8yTGJEQnpZK3Fy?=
 =?utf-8?B?SGlwNmttRTl3WlY4RXBtK2VFVlhBSnFpVms1K044OTFKUXVqb2hlNzV1Rjdi?=
 =?utf-8?B?NnBFVFJ6WXV5MUFlNCtWZkhwTW9NVXZIckJVeklOVGtJeFdEL3J1TkhOOE5Z?=
 =?utf-8?B?bkFPYnRuVTRwd2kzbUJuZHByZHoyVzhmQk8vYlVSa1NRK2N6M3kyWk0zUEk3?=
 =?utf-8?B?Y2hwNFpMWi94N2w4TE9EMHp5dWhlNGdPQzRWY3doazExR04yckcvQmlJdCsy?=
 =?utf-8?B?aUdFYU1iVnVsK3p6SS9WSEhkc1d0WEpkWkZrVFJ2aTZoRWFiUEVpeGlPVnhO?=
 =?utf-8?B?aUZIMXhLbFlXaERGZGZ2SHM4NWJWSWc2Qkw0YXZjSWFNU0FhSkpmSEswb1Yy?=
 =?utf-8?B?ZXB6TU5HMGh3WWhJQTBSeklIb2JqcENPamxnbVJvSXdOQmNUWjBraEVVWlZU?=
 =?utf-8?B?TTIybHErWExRdVFudWtna09WWlYxbWJWaFd5VjVITXE5Z2xNVlJRUzN6WEZZ?=
 =?utf-8?B?QW5BM3Q2OVNCWGJESFpXUkRHellsbmdCWG5abXV6cUo1K2ZPUzBiSDhyV0p5?=
 =?utf-8?B?YzkzTFdvaDUxblpXZkxZTHF0aUJneUFDMkMwS1QveWJiZjg5NjIydVFuOTBS?=
 =?utf-8?B?eTYvaDhtT1Bmb1lGdHJCQmI2QzR3Y3MveWNzajJac3gvTlErVitWOXIyUVdH?=
 =?utf-8?B?WXBqUmxiNE1FWVhTZE95alhvZDdmYllCZWVLRWhRZjdYMUpxWGs0ZUdPTUUw?=
 =?utf-8?B?K2lmSzBxNzlOZ1I0cTRicDROSkg1MSszN25TeUdSbERjSUZ1L201VHA3cUFx?=
 =?utf-8?B?b1hjaFVzQkR0bHpRL1JvdEFXbk5UREFTeWY1RHRPUHBGdlpmbkxzM1lQTkZ4?=
 =?utf-8?B?QUx5RHh4Z0lGL0JDQTN3QmJjZUVIZ2lydDBXZG5EdUpQNG1TQUxpZHdTWm9D?=
 =?utf-8?B?SUo1N3hKT0IrTGRoVmcvdjZST25EbXJvWkxOL2F3UHAvV1VJczFYNGw3ckJV?=
 =?utf-8?B?ektjRmhkK080MzNtaVBSY1BpU2FEWXhNTEI2Qm9kNStJT1JzUnQ3OUNXc1VZ?=
 =?utf-8?B?bVJCd2p2Y1ZBM0oyU3FDc3RQVXZIUG50OHJSUEh2RDQ5UTI2a0txbjRkNVBp?=
 =?utf-8?B?aTVBUlFuR2NZNkM2Vk93QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3ZuN2hIbno4WGhqbWFuT0NjbVlXZnN0S2QzNjJCZk5LL2o1MSs3cC85U29T?=
 =?utf-8?B?THV4LzA2L3BJM29ob3Ftb0xkbWMyTVUrcGhBdVYweU5JM1k0NUtLQSthNm96?=
 =?utf-8?B?MjUrdHBXSVlTc0s4UHRvNEZKa2pYZFlhcXVCYVhXSEV3cXY4RFdpYkhha01T?=
 =?utf-8?B?dHNRVTIzUzN3aGdMd0xNWGhKbko2Q3B4SUlMcks1SkNzRzhCdEd2QURMQzVo?=
 =?utf-8?B?VENLWC9PdmU0ZitFREZyVE5kOFg5dkIzTWxhR3JTdkJGcS81bWxjSEdiaXZE?=
 =?utf-8?B?RDBWQyt6YXdnazNMVWlPSzRqUnpJZE1Wb3B1NUg1Tlh1blp0ck8xN1cvUGh1?=
 =?utf-8?B?enVNSU93Ums3WmlXeWpsYnJDbWxDTXVaaS9zRVpIN3F2YzQyQjJkNVNmekpz?=
 =?utf-8?B?eE9rSUxnYzBwY0xZMXlPUERRd0FjMmVKL05ONzRzTE5yajlMLy9VZytVQmor?=
 =?utf-8?B?WU1OaGZ4dkdPV3NYUjVwWkZnRXY2YVNZL2E1Qmp0eVNpanF3dlNmVTdHRXZv?=
 =?utf-8?B?REh0bXFLamI2b2xCdk90MENxYWcxRXE4TzFDUjNGU1JEbGY2QXRNNzV4aFha?=
 =?utf-8?B?cE9zWkxiUE1XUFBWa2h5UU5mU21WdGlIZitPUVRNa1dYeUZRSnUrOUJVbEFw?=
 =?utf-8?B?UXlxaExyWklyOHhpRkdveEZwK1EraEN5aUFGNGtkNDZqbWx3TTZOWWRtL3Jt?=
 =?utf-8?B?eDBtNnNLQlgzcTkvU3BIZlBkWjVkYUJkemcyOGNvY3A2R0w1RkVtTWZ2L0VV?=
 =?utf-8?B?NnVYSUVRNFNNSk5wdUorb0EzQWEyakQ3SVo1ODI1Y2YxT1pEcXY1UnRrZHBH?=
 =?utf-8?B?NytjWkRaYTRyYjhmd3M0UkJJVmYyNUw2OGpkQ204S1l2VUdUbVE0dnNyK3Mr?=
 =?utf-8?B?OCtrMTJyUzZiU1ErM2V0TmdwUkNZUFhhQ05QT05lcFI2ZUlJb1lUbERYdlhp?=
 =?utf-8?B?NVdzblkvM1VkVEFhRkg3UnVoZ3o5WTVMYjZpZ0xlTnJab1VkWVpJOFJYdVl3?=
 =?utf-8?B?ZVh5d2ZkWlFLc2pGcFl3b2pucWFJdXZHSkRwK2dUcm10NDdEdStjTHVPc0lk?=
 =?utf-8?B?b01mM0FlSm4yYWczVmYxdkhQVm96VUdvdEZxU0t3bExIYmNGWU92T1ZRTUly?=
 =?utf-8?B?VHFjaWtuTXplZk81NEZRNURtZzhKVzEzdytBeUlCR0RxeEZyd0hBaVNSc2Fv?=
 =?utf-8?B?SmFaR2svMWZNTlAvbkI3alRRdzFRNzVvVHR4MUsvSzBzZ0JPeHNKNndSdCsx?=
 =?utf-8?B?OXNTTUNqdGRNaEhHa2lyTnJMdG4xWlBaeERvTTl2MTZPSzkxQmdKZm5sMGhD?=
 =?utf-8?B?Y3hGb2R0dUNyNWJjbTRxdmc4RXNFMlhDMC8rTFF6dVFydzhTQUN0ZFRGZXBY?=
 =?utf-8?B?YTNWVTVtWjhGL2ord0xCeWtsU3BYV0lqeEZNZ1dqSCtmNUllNWJudlIxWFc2?=
 =?utf-8?B?WUluRXJSRkMyQXExOXFRcC85SGcwWHYzTldid3Nic0hWZWFEWUwrMUdmV3FS?=
 =?utf-8?B?SXNLNFVoeFRralNOdUFNcDFFeVU3TEJjS01qT3FFaCt1bmVyTkVuUUl3S2t5?=
 =?utf-8?B?elppdXVmWnlDWFU5MzBXMkgxNzdKa1Byck9sY2ZTaVA2SmFtbHU2Q0ZiV0t6?=
 =?utf-8?B?bDNobitMeGo3MXVuZlpEVHZReDNTSHJEaHA5Y3NpdmFxWXJRclJJSzVlSUFq?=
 =?utf-8?B?cUVDOW41YzVnOEJUOVB2cCtWTWpTeGl3YXludnlJZ0cwTEtRVlMzclVYZnZE?=
 =?utf-8?B?a0dGTm04YlpHVDY0RjdGaHNMTGJMcXBBZE53cTg1T3ppUGVYSmpTdGtlVG4y?=
 =?utf-8?B?SVF4dFFTdjlTa2xObkVCWmt5RTZ0VklpK3N3WnVUckIrZnhWbjhieko0WXNT?=
 =?utf-8?B?YUoxdlh3VlR0YkMyU3pjTTdjc1UzZHpUWGVFK2RXaFIxcWo0VkhGaWZkQnBV?=
 =?utf-8?B?bThPSnd3NHc1cDlhWHhsK0VESnBGOWxmaXR6TmF1dFc5cVVoVzVXOStoZXVE?=
 =?utf-8?B?TTc2cFV4VjQ1NFBQNCtIa3ZYamtabWFkZlA4bThiMXR1WnluZGhXTmQ0dzRV?=
 =?utf-8?B?Yk5KaEFjZW43dXY5L3VYUHdQcy91RnNiOVFDYVBGU1pIYVFJV1ZqSWhkYSsy?=
 =?utf-8?Q?b7B4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352e8b47-275b-44b3-42f2-08dcad74b497
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 13:13:13.9113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t08GNTqFWGntWXlIRCXvAmNghapI8rwrcCXrF7LGlyM6brdNZ6aCqiNPapZ+T6QS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>The kfdtest user queue validation cases don't cover those error
      condition path, thanks for catching it.</p>
    <p>This patch is<br>
    </p>
    <p>Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    </p>
    <div class="moz-cite-prefix">On 2024-07-26 02:47, Srinivasan
      Shanmugam wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240726064712.2167971-1-srinivasan.shanmugam@amd.com">
      <pre class="moz-quote-pre" wrap="">The fix involves setting 'err' to '-EINVAL' before each 'goto
out_err_unreserve'.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_queue.c:265 kfd_queue_acquire_buffers()
warn: missing error code 'err'

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_queue.c
    226 int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
    227 {
    228         struct kfd_topology_device *topo_dev;
    229         struct amdgpu_vm *vm;
    230         u32 total_cwsr_size;
    231         int err;
    232
    233         topo_dev = kfd_topology_device_by_id(pdd-&gt;dev-&gt;id);
    234         if (!topo_dev)
    235                 return -EINVAL;
    236
    237         vm = drm_priv_to_vm(pdd-&gt;drm_priv);
    238         err = amdgpu_bo_reserve(vm-&gt;root.bo, false);
    239         if (err)
    240                 return err;
    241
    242         err = kfd_queue_buffer_get(vm, properties-&gt;write_ptr, &amp;properties-&gt;wptr_bo, PAGE_SIZE);
    243         if (err)
    244                 goto out_err_unreserve;
    245
    246         err = kfd_queue_buffer_get(vm, properties-&gt;read_ptr, &amp;properties-&gt;rptr_bo, PAGE_SIZE);
    247         if (err)
    248                 goto out_err_unreserve;
    249
    250         err = kfd_queue_buffer_get(vm, (void *)properties-&gt;queue_address,
    251                                    &amp;properties-&gt;ring_bo, properties-&gt;queue_size);
    252         if (err)
    253                 goto out_err_unreserve;
    254
    255         /* only compute queue requires EOP buffer and CWSR area */
    256         if (properties-&gt;type != KFD_QUEUE_TYPE_COMPUTE)
    257                 goto out_unreserve;

This is clearly a success path.

    258
    259         /* EOP buffer is not required for all ASICs */
    260         if (properties-&gt;eop_ring_buffer_address) {
    261                 if (properties-&gt;eop_ring_buffer_size != topo_dev-&gt;node_props.eop_buffer_size) {
    262                         pr_debug(&quot;queue eop bo size 0x%lx not equal to node eop buf size 0x%x\n&quot;,
    263                                 properties-&gt;eop_buf_bo-&gt;tbo.base.size,
    264                                 topo_dev-&gt;node_props.eop_buffer_size);
--&gt; 265                         goto out_err_unreserve;

This has err in the label name.  err = -EINVAL?

    266                 }
    267                 err = kfd_queue_buffer_get(vm, (void *)properties-&gt;eop_ring_buffer_address,
    268                                            &amp;properties-&gt;eop_buf_bo,
    269                                            properties-&gt;eop_ring_buffer_size);
    270                 if (err)
    271                         goto out_err_unreserve;
    272         }
    273
    274         if (properties-&gt;ctl_stack_size != topo_dev-&gt;node_props.ctl_stack_size) {
    275                 pr_debug(&quot;queue ctl stack size 0x%x not equal to node ctl stack size 0x%x\n&quot;,
    276                         properties-&gt;ctl_stack_size,
    277                         topo_dev-&gt;node_props.ctl_stack_size);
    278                 goto out_err_unreserve;

err?

    279         }
    280
    281         if (properties-&gt;ctx_save_restore_area_size != topo_dev-&gt;node_props.cwsr_size) {
    282                 pr_debug(&quot;queue cwsr size 0x%x not equal to node cwsr size 0x%x\n&quot;,
    283                         properties-&gt;ctx_save_restore_area_size,
    284                         topo_dev-&gt;node_props.cwsr_size);
    285                 goto out_err_unreserve;

err?  Not sure.

    286         }
    287
    288         total_cwsr_size = (topo_dev-&gt;node_props.cwsr_size + topo_dev-&gt;node_props.debug_memory_size)
    289                           * NUM_XCC(pdd-&gt;dev-&gt;xcc_mask);
    290         total_cwsr_size = ALIGN(total_cwsr_size, PAGE_SIZE);
    291
    292         err = kfd_queue_buffer_get(vm, (void *)properties-&gt;ctx_save_restore_area_address,
    293                                    &amp;properties-&gt;cwsr_bo, total_cwsr_size);
    294         if (!err)
    295                 goto out_unreserve;
    296
    297         amdgpu_bo_unreserve(vm-&gt;root.bo);
    298
    299         err = kfd_queue_buffer_svm_get(pdd, properties-&gt;ctx_save_restore_area_address,
    300                                        total_cwsr_size);
    301         if (err)
    302                 goto out_err_release;
    303
    304         return 0;
    305
    306 out_unreserve:
    307         amdgpu_bo_unreserve(vm-&gt;root.bo);
    308         return 0;
    309
    310 out_err_unreserve:
    311         amdgpu_bo_unreserve(vm-&gt;root.bo);
    312 out_err_release:
    313         kfd_queue_release_buffers(pdd, properties);
    314         return err;
    315 }

Fixes: 629568d25fea (&quot;drm/amdkfd: Validate queue cwsr area and eop buffer size&quot;)
Reported-by: Dan Carpenter <a class="moz-txt-link-rfc2396E" href="mailto:dan.carpenter@linaro.org">&lt;dan.carpenter@linaro.org&gt;</a>
Cc: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
Cc: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 9807e8adf77d..63795f0cd55a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -262,6 +262,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 			pr_debug(&quot;queue eop bo size 0x%lx not equal to node eop buf size 0x%x\n&quot;,
 				properties-&gt;eop_buf_bo-&gt;tbo.base.size,
 				topo_dev-&gt;node_props.eop_buffer_size);
+			err = -EINVAL;
 			goto out_err_unreserve;
 		}
 		err = kfd_queue_buffer_get(vm, (void *)properties-&gt;eop_ring_buffer_address,
@@ -275,6 +276,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 		pr_debug(&quot;queue ctl stack size 0x%x not equal to node ctl stack size 0x%x\n&quot;,
 			properties-&gt;ctl_stack_size,
 			topo_dev-&gt;node_props.ctl_stack_size);
+		err = -EINVAL;
 		goto out_err_unreserve;
 	}
 
@@ -282,6 +284,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 		pr_debug(&quot;queue cwsr size 0x%x not equal to node cwsr size 0x%x\n&quot;,
 			properties-&gt;ctx_save_restore_area_size,
 			topo_dev-&gt;node_props.cwsr_size);
+		err = -EINVAL;
 		goto out_err_unreserve;
 	}
 
</pre>
    </blockquote>
  </body>
</html>
