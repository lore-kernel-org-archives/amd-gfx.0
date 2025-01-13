Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC7BC02180
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 22:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E344F10E2C6;
	Mon, 13 Jan 2025 22:28:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yz5qPnZ6";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 981F610E438
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 22:28:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkaetrEJgWgaOxkYUtJk/4oQl58m3JBm8Va5tHigttsJEGF50Mx1QrdBDspHp0TEBUNM+AjvvIRvXfTVf9htJ+cwo+NPtnVOejX3qQFWHHlXqQ/I6MIU1WitbNmcfCZt5+SCTOP3A37DOrgfnUuP4p3Mlt9LSzFLQ/nRO/qydmdeLGjA8NDkHMBvO1D1ipYShkYSJx+p2KOKkcdt3KFIsNNl2S9LP9Haij39ESpCufhRomu2368kXN9A5KtQGhXhP77sqnwrwXrctRTEqnP6OxivHPwllqhN3URal1N8HdSk/Dhm9YRN1D3d6Q56S5I7MhgAcqA7YYZsZNbRm+Fcaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6715TE3QpHYUlB0gL5bAxXu6+xUPe10uFlDtfYUGTLI=;
 b=wwmaEJU33MqQxM7c/RgU9sXyoAriSv8LboaukSkfPPLST2G+sipbv8TGRgKkQVglaebgSqmAEngDOj9zZPK5i0L1+IVdVQp2yHrWH+kAIDVSDwJxN9rCAFUGMpXy0yZQzrr5dqHTER+QAYMER/6iIbeZgsjGr1s/cyjDHOzIhQD5CpG4ZJXXFByCQJuvubNufoWSRAZZ0lOlo02Nl+K/x1kH2TXlFRFJevJEsq1a19G7rJLaxoJ73zPsizXdABBCrHNvuilFW2saiwrDbEFTR48b+2y0+buhzH1Nblmt9aPTrIY9kG7Bwhdf9hg8VWPmnKzE/YzJvSjFkVhFuMQDgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6715TE3QpHYUlB0gL5bAxXu6+xUPe10uFlDtfYUGTLI=;
 b=Yz5qPnZ6JTkOTAf5H5J5xBFYKwbCIyfmMnsgSbZ4LTfBPaDWumpxGCxz8iVmOdRtsr+dKvjadNpvC0U6DMP3C1Aj6Z1mTPNBqn8eupAgXE23MTSkfafAQZR+Jm4F0aeYzcV0QSi7ByRqZOPzn35Jltj3VJcY5cNtBxEvKhKllbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5897.namprd12.prod.outlook.com (2603:10b6:208:395::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 22:28:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 22:28:01 +0000
Message-ID: <69691ba3-454b-4185-b789-00655829aaa4@amd.com>
Date: Mon, 13 Jan 2025 16:27:58 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 10/15] drm/admgpu: make device state machine work in
 stack like way
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736732062.git.gerry@linux.alibaba.com>
 <f9816814dd71316bf371c01c5f4d71ca85954ade.1736732062.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <f9816814dd71316bf371c01c5f4d71ca85954ade.1736732062.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b03d7db-5951-4bd1-51ba-08dd342189e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDRZY1RUWi9mZHV4UUJTVUZ6MWk1d0hlb0hTbnphNGxwcGdwUkhQVUNRbVV4?=
 =?utf-8?B?YmZzZXNaelFYNlZlT1IvWlZOOHd0ck5OV0FIUi9qblJkOU1Dd0hhS3lVWXg1?=
 =?utf-8?B?Z2JzY2J4V20xdWQxUDNMUlBEbnUvamFsOXM5dEZFRW8reHJBNC9TTytSNFhY?=
 =?utf-8?B?NVc3SHJsTGVCNU15cHNQaWF5MWlnK3czallRNzdkbFhQTWNEMHBxaytoSkZR?=
 =?utf-8?B?Ly9ZMmh5dmtDN1JzdGpRVktTOVNUWEJUcnVickcvMll2dmZsSzZWYWwvak1E?=
 =?utf-8?B?dDIrMXluVlY4c0t4ZTNzTU8xUFREQThoOHRva3BCNjl5U09YWFRwYXZZVEVX?=
 =?utf-8?B?SWluWHdwRnhIdEFYK01vcmhsaXFHdHU2Zjl3NWc1YkVoRmViRkFjSVBjaS9S?=
 =?utf-8?B?K3QzZmgva3ZlcGx5RnRSL0FvNU52U0VDSkxlWTBzamlxeitML3FlRVFEYXVw?=
 =?utf-8?B?Z0tPQlBOQ1ZkVzVDR3pVeUtDc2xleWtNUTdrVmx6ZWRScEh0WXRpMW16ZXM5?=
 =?utf-8?B?MUlrSGVldTMzRGZzQklCd2dWZ25BV2YwQ3lTWTkweURYRnhCTzdqaFhPUExi?=
 =?utf-8?B?bkxyeDE1TmpUS25ISnczZlE3Z05hcmFzVEpqV1VwOG1oeC9qc0R6RnNPWG1w?=
 =?utf-8?B?b2p1SC9jK0RrNmNaN2N2QmVwVUU3TGVUSjEybEFOaVJOeHZLUi9ybFhtcXJk?=
 =?utf-8?B?VjNFdFhPWC85WE5kam9wYXZIdW9JamY5dElueHFvbERTdzlyU2RoeFBOZThD?=
 =?utf-8?B?RmVVT2xJUStvaDdaSXpHZVR4RFdHUGlyRjJiRjhvQ1A4V2IwMXVOUi9LSS9r?=
 =?utf-8?B?a1k3UHkydFRROXQ4WW5nSU5xTjByNDFrK1lJWkFGbzdJNnlVL2ZyVXRmS1I1?=
 =?utf-8?B?bnk2ZW1Hd2gzL0FEYkZGRU9Wald0TG1TQ3YvRmRydm04MERDMnZWZW1TVE5i?=
 =?utf-8?B?Si8ydlhucEg0Z0piY2Jzay93NW4zR1BaVWVGMVphcXhmY3Z3MjRVeFRuT0FJ?=
 =?utf-8?B?bitoN0NlQlVpc092NVRpK2dCNktuVTZJZXA4VXFzbENmYXVFbEVJUU0zREZj?=
 =?utf-8?B?bFNScEphaGFDR2RkMTI4TGFVYWxnMjhyRXh5UFY4Ylp5RllGeU1FK2pIc09n?=
 =?utf-8?B?R3RoSzY1RGVkbEgxVkk2U1R2alZZNlVIRldHbGx0V1lDT05FaWlqUDJLa0tO?=
 =?utf-8?B?cEhxR1VRc28yVkROWmRWbVRRSG05eXBwS016bCtWWHM1Mm1XaGRJcC83enk3?=
 =?utf-8?B?NncvZnB0OVJwSm9xZDk3VFJqU2ZNaGRMM3I4K1BnMUJ2QXpjY2J4WUg4Q0pG?=
 =?utf-8?B?NjR0ZTlUYW9wZlZudFVOekpPRmpuSzdzbkdEVUlqZy9OMmNtS0QzcFBSQzli?=
 =?utf-8?B?cnpkQ1NIR1NiMmk0OXQ4c25zMExRQThTcVJLazZOR3liMVFHdDgvQ1ZhL3Zo?=
 =?utf-8?B?OS9hQzI0UitHRFhLT2N4RTEzaWppdU5wVG5lbGw3WGZHTGFuU21BR0YvMXpm?=
 =?utf-8?B?M2pxSytpNnV3Yy9qN2RUbUcwczI2S2FidWFTVjlnVGFmRzkzS1dsR1ZkVm1h?=
 =?utf-8?B?T0MwcTJ6VWd0MGxHV0V3Zi81N0JidENMRVdleEtUMUZQcURhbml4MDdQT1JW?=
 =?utf-8?B?YjVYTFlrQ0MxVDk4VTM1ZHo3U3hlcFJwejhOV3pod3pJY0tESnFaVG56UUVw?=
 =?utf-8?B?WXRhcEtYMHZ6cmxUYUltYkh2Ui9rRUJ2VDdFaGRrVFFDamQ4MW5kZVhPN3cy?=
 =?utf-8?B?dWl1aURkYTR4ZFBmeTUwTkxzaSs0di9kR2VNc1E0Q0cxZWRCeHBmU3ErQUt2?=
 =?utf-8?B?RDNqK0NqOUV3TVBFRjBVc1BjaVZmbGk1TlAwVWcrTE1tcEc2ck1rWStNb2p2?=
 =?utf-8?B?Wmp6ZHdGTU5RT2QydXhVdytUQlY1WmFEYkc5Q0pDSXdLSFdaeXFsWStidy8r?=
 =?utf-8?Q?NGKa907gQXo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(921020); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGlSSHlob09rSWNXa2s3eWtCRk1XVTgyZVJkamp4SHBiSGZWekFqejdhV3ll?=
 =?utf-8?B?amxGc0MzdG5Kbzc2MEFjYU1HNmpMaTVFWmNmZm1kTjNPeWUrRVRlUHAwYm5W?=
 =?utf-8?B?dTNPWW5EVkI1UEdtVjI1NlBHR1VIam5aTUdzMkg4MXpiOUVzY1U4aFFlbTJQ?=
 =?utf-8?B?VytGRXFvSlFka1dwc1lRaTUwbWJMWlY2ejJkTUtvOStjQVM3RFAvR3Z6eDFm?=
 =?utf-8?B?SXgrTjJVSmxiN0YrYjAwZ3g1VlYrVVVjQSsrSkhLZWZ5dUJ5OThGdDl5OHZI?=
 =?utf-8?B?WjhxRXBGb3BDL2JJb25RTmZsM2UzS0luTUl0KzNoSjBDYzgzVW1NemtOZWFQ?=
 =?utf-8?B?d01hOEVKbzRNdlpUaW5qZWJQOHVNTGJKc281UkFJaFdubTFJa0FPQ2lmUHda?=
 =?utf-8?B?ckYxWUd0Um9xWFVneitXVVZkNS9kU1JLRHhEcmxyMUQ2Q2lxOHArTmFQSnZh?=
 =?utf-8?B?T1h1c29sc3ZsTG1ySXFPNTJvVVJ5OXdBUVh3NzJFN1BPcDBReWJCM0NoYlhM?=
 =?utf-8?B?UTFJc2xlOVV3ZnVyVjVlYlhqY2tOUHNHdkE1UDI5cFNCUmFaU1h4MXpLSE5T?=
 =?utf-8?B?UWZyMHQvSmV1c09tb2hUOU9lMEFyQmJvcEtjOEkrSDgxaGtzZElEMUV6UkhH?=
 =?utf-8?B?amxxdU1iT0RJTXRTTlRFNXlmOC92U1lXZTZVWEFXRHNtRzhhNDNCNE9KSGhK?=
 =?utf-8?B?MU1hdDJVTnhhMk5MMzFxVURUQnB5WGtIL3Fscmt2SHcxVkJzRGpnVWo4TVRq?=
 =?utf-8?B?NGZIYWttV0VvYk5YTnFkeTBxL2YvQUQrZldtTjRyWkcwNXZaNHh6bHJFUjRk?=
 =?utf-8?B?VFVTSkJNbVlTYVpGMkhJbGZVMWUyRU1XK2JaR0NYWlRjaWpjZlNVQmJ5NTNP?=
 =?utf-8?B?U2dNd2tnUTJqNzM1ekxPQm1lcWt0NHlFZ01QVCs2MWhzMmpCNHZZQ0VZSVpy?=
 =?utf-8?B?ODdUaUs4dnhQa2tFRWJTc3VDWVoyZktzM2N0cTdxTGRCSThtTUwwYWZOVldS?=
 =?utf-8?B?VElGUjRtMTRrdS9BWkUyUitSZ0x5eHBSSjYyMWEvNElpV1BkRTlqelUxRTg0?=
 =?utf-8?B?d2orbCsxNXc3eVV5Q21Ebll6NitlZHl6bnJHZUpybXAwa0xhTmE5Y3V0R3ow?=
 =?utf-8?B?TUhvb2V1UWlRWnJtYXNLT2Fubm45cjVpRlozR2w4RDRsN0Nxak4wQk1mckxG?=
 =?utf-8?B?S0Jpb1lHQjZkZGx6aWhNNTFDTCtER0htayt6aEhlSFRMa0JQenk0MjBldnpJ?=
 =?utf-8?B?bE82K1dFZ0xBQUtRemdsR2xVVU5JSU01UDdlYndYU0VsbU01TFdLVWk3Sk5W?=
 =?utf-8?B?SC8zRmZ4bGZURXFHSUdNNVFUU3kyOU1LYkZXUVkrQU1jSFpnQk42dno3eXRx?=
 =?utf-8?B?VmFEUW1hWWhhUmw5RUxaNlZ6bksycmlaa3l6Y25HNkVzN3FuT3RaMGJPUTRu?=
 =?utf-8?B?a2VqbWRpTlRXcHFJdGZ1S1NBVHF2d1VUZzFRL1NITjRwdUszUHl5L3AyNjZa?=
 =?utf-8?B?R0E0S2U0amNnZVZoVlI1eFdONnBmZ09CdUoxZHUvZ3huZnFkM2pCTis1MkdE?=
 =?utf-8?B?YmtFNzEzS0ZvcGZwNnprR3ZzN0M1VjhmaDJYZzMwWWd0TUtUUnB5blh6VmtO?=
 =?utf-8?B?bHlxRFhQUFRWeEE4dmpMMjVvOElJNWdYMDcyRGFIL1liYklUeHpsSmRxMzFX?=
 =?utf-8?B?aUdycDlJazZVWjQySElPQVpIbnBDaEZsUm5tTW5hcndrV1Q1YVZoVU5kaXFz?=
 =?utf-8?B?K2RTVWFJWmpOZGVMTHJpYVNvYy9RaWJiYmNTcTBHM3lvU20xWjM4T3QxMTVm?=
 =?utf-8?B?RDQyUlRGUnRCSlIwcWlDYm5aTVp1SFpCZFpOdnQ2Z3ByS1NmcjhNbGkxbkE3?=
 =?utf-8?B?cHUwN2JYeUN3Z2JIU0FBM1lnT2wwVXd4Yk80QXVFR2Y1ZjJ5M2N6WFQ3VTBo?=
 =?utf-8?B?SFh3Y1BDeFViVWpnUWVQdDUwUmR6Rnc3NzU0KzMzQy94WDlhbkRIeWh5TGpH?=
 =?utf-8?B?MWpOUkt3aWJDTUhNZGdKQUk2UjhWTGpMTjN0MmI4cDRjOTlpOHJmNnVUaTdt?=
 =?utf-8?B?WHZ4RnA3d1JUdCtrSFZrc0R4WWZQNnVEOVlpVG1pMHB6N1VpeDZId0UvYzJS?=
 =?utf-8?Q?5NEoUjTcrK51CVtdlpJvEvBkv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b03d7db-5951-4bd1-51ba-08dd342189e1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 22:28:00.9319 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6t999LKzEZOvxzGQ6oiag4Pky7j1/NzyzNKiZm0kpCDzwms2O6ARs2m9IZa/cYsnJ4DSpDxbiuCGVQiXZeceA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897
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

On 1/12/2025 19:42, Jiang Liu wrote:
> Make the device state machine work in stack like way to better support
> suspend/resume by following changes:
> 
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
> 2) set ip_blocks[i].status.late_initialized to false after calling
>     callback `early_fini`. We have auditted all usages of the
>     late_initialized flag and no functional changes found.
> 3) only set ip_blocks[i].status.valid = false after calling the
>     `late_fini` callback.
> 4) call amdgpu_ras_fini() before invoking ip_blocks[i].late_fini.
> 
> There's one more task left to analyze GPU reset related state machine
> transitions.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>

Ideally I think you should swap the order of patch 10 and 11, what do 
you think?

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6b503fb7e366..c2e4057ecd82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3449,6 +3449,8 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>   		adev->ip_blocks[i].status.sw = false;
>   	}
>   
> +	amdgpu_ras_fini(adev);
> +
>   	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
>   		if (!adev->ip_blocks[i].status.valid)
>   			continue;
> @@ -3457,8 +3459,6 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>   		adev->ip_blocks[i].status.valid = false;
>   	}
>   
> -	amdgpu_ras_fini(adev);
> -
>   	return 0;
>   }
>   
> @@ -3516,6 +3516,24 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>   	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
>   		dev_warn(adev->dev, "Failed to disallow df cstate");
>   
> +	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
> +		if (!adev->ip_blocks[i].status.valid)
> +			continue;
> +		if (!adev->ip_blocks[i].status.late_initialized)
> +			continue;
> +
> +		if (adev->ip_blocks[i].version->funcs->early_fini) {
> +			r = adev->ip_blocks[i].version->funcs->early_fini(&adev->ip_blocks[i]);
> +			if (r) {
> +				DRM_ERROR(" of IP block <%s> failed %d\n",
> +					  adev->ip_blocks[i].version->funcs->name, r);
> +				return r;
> +			}
> +		}
> +
> +		adev->ip_blocks[i].status.late_initialized = false;
> +	}
> +
>   	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
>   		if (!adev->ip_blocks[i].status.valid)
>   			continue;

