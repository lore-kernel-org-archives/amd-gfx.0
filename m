Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E24FC3ABDD
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 07:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1996E10E215;
	Wed, 14 May 2025 07:23:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LLRoBBHI";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 747C710E215
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 07:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyVDwOpPznoZknn0CyaPxMWjjtEMxaeCzmhhaWjwwiUqDok8FV4498pC08M41iIWbQ3aZL4pU5ZQeSOVhH+bmuub7T+OCdo6fAHpkwnb7kawVrEYBFirs0XabPJmqgcKMKMtmG2UUEpaalyMSF1RU8Pql7HTNJtbUGoJkKQk/ddnH4JVxOTTt5rLt6D3l1UQGzLbmVpNN8hKNC5aeI1IpLA2vfGes5odUJ6s3dajvmWLjCeYwo7yPA4WBwANJ3ypqFWsihmSYsFUeKq0fLDe2jcYxi1MoHc/8i1iYiE32AapLFZZ2xr/v4LuqTl7kCSgvO8w4Hpov33XT78UZF1hmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKX4ak4qPOBqtDTt7UrWurWLfkUSflJUA/qg74jB5wc=;
 b=mP/9g/tfjNFZ72BBRN1nZXp3pSxARymiOGvV1EymENN5lBzOXGa0lAtzpP+lT7kh+yO4lWu+BHQR9NLsd4uWZfUJEGAZmhYNa30/ORlmTl4oEiVdNehv70I8MlWAOL0oW3X9uyclgS4wXAk5xPjuyYcWCwiMHca+EPnN1wsTozTJxNPKl7c7d2tWpxO4qSpXDD+gdQQ7HrjXXUe2Z2SjAQmT/MGgvOTpVjwHZpbBPqN8KRW1aMKsldg+Nta4PymB5Cw8xBx2IcGYqHzDgMttF5dUUD61TcuGEA7nZExM5RW/MH7gPYzP3nQBJThuJemdp9pQakib/iQGPVQMAzEJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKX4ak4qPOBqtDTt7UrWurWLfkUSflJUA/qg74jB5wc=;
 b=LLRoBBHIcTF4907bya88f1GmeMFWa4h4vcx05WWeeDLIKBD7PnC8NjwalAY4kkXvrGGz02UGFbK9tW5zCvamVFzLYmxN0Fi+/QOfdO09GvME4toTlbkjhPPuGIkfa0UyTJubL3eP6VXA6BH4ZCB5mCY7LDmI3H7bRcnsM0nQFUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.28; Wed, 14 May 2025 07:23:11 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 07:23:11 +0000
Message-ID: <e0bc2b98-99b2-4f66-ab74-ca085f4b3847@amd.com>
Date: Wed, 14 May 2025 12:53:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: add debugfs for spirom IFWI dump
To: Shiwu Zhang <shiwu.zhang@amd.com>, Hawking.Zhang@amd.com,
 Likun.Gao@amd.com, amd-gfx@lists.freedesktop.org
References: <20250514062145.82529-1-shiwu.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250514062145.82529-1-shiwu.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0178.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::33) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f241f8-4766-4bb3-34d9-08dd92b82e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MC9nd0swVHZIZkpwK285Ni9TRnE3MnhwRjE0UEJIa2RrbklpQ2NKYTdUZVhY?=
 =?utf-8?B?Tkd0TnF5L0tUUFQ2WE12TFNsQ1Q5Sk9QdldKa3JNcWZQQXM5ajRXZ1VWOG1V?=
 =?utf-8?B?T1FuOTRlMFVHZjZMZGkwSWFrd2hHVS8rTWs4NHBJRmVnQWl3RlJMU2xuZitY?=
 =?utf-8?B?TGF2NnVEWUdXRDdHa2wwdmZ5K0hVaGdmNG9kbEJiRnFLczk5S3BpM1RySDFa?=
 =?utf-8?B?VWY1MVBJaGpRbjVOS2lFRnR4RXlIMG5FRDFqRUNwMFQvRWVtVDg1c0RGelVK?=
 =?utf-8?B?c3BvcFc1Y0VKWWFwYytPNkNoK1pWZEMrUDZBeTM1dFM3QTk2QXUyV2VGSmRo?=
 =?utf-8?B?TThoSHM1MnA3dUE2bndmbmh4bGt3aU1Wb0FXdHpqMmdXaUc1QmgrN3R5WmJJ?=
 =?utf-8?B?REl4Mnk2L0VLZGVsM3FFYlBrSy9RMGl4UDdJL1ZkTzNWdDBBdGJqZ3pNNFUw?=
 =?utf-8?B?cExoajFxRDhNUUc2a1ZmY0VrU1BHRU1BcStjMGM0NHlLSHE1bnp4enZKMkVY?=
 =?utf-8?B?NXgwR3RTN09hYzRUR2x3RFdNWk5OalZtN0d1YWhVZkIreTZMOHZzZkRkMWtU?=
 =?utf-8?B?eW1zYUI4VWVuKzZIV3JyWkptc0pqQW1YSjdaRDlXMGttb2dEWFdDWExnQnls?=
 =?utf-8?B?elowR3NxL3hqN0pzTUtTYTdNOXF5MSsrK1RlYkppdmJYR1c5Y2ZnQkxkSmJH?=
 =?utf-8?B?cFZJc1hBR29oWlVsbUkzanJDYXZKeS9jYmYvSzRScXpLcmxEYWxqV24ybWRX?=
 =?utf-8?B?emZtU3ArUzA4V1BxWjhHaSs3OVF2TXNTdlFlZGlWYkljYkJVTTBoNlk1OUd6?=
 =?utf-8?B?MFY5aDl2YlBqNUVQWFJVV1hsUzJMVytIVnpNNXRMbkVlVFNNZ2dKSmg1Y2NU?=
 =?utf-8?B?aTgrakU3RURSQkdYSGk0WlVJWUIvZGxtckc0VVIvc0dreGxjeVBIZzVDcWlp?=
 =?utf-8?B?elJkMzdSMTRyaDVjTENnYzhpeDkwVTJ3MXR4Y3pHV2xiVTB3UnN2emMvMFN5?=
 =?utf-8?B?OGg2bjBkK292V2xPT2R2Y214VTREd0xOUHNtWWxVd3Q4UHZMc21CUVVVMUsz?=
 =?utf-8?B?SjRpUy9QOER3VUYyQ3ZIWkpGM29WNXNLZ0ROTmZ4YzJDYkhNMm5BL2wybWls?=
 =?utf-8?B?VHY3UFgzVVlOK0x2WEVzU1F5b2J0Qi83aXlJQ1c0dVNzNjhhV3IyL3BnQ2Fv?=
 =?utf-8?B?NjU1OTBtd2pyc1BDN3RIVkxtV0hkaDlCOGZwRkFja2dEcDNpbXNRaHNRbmE4?=
 =?utf-8?B?NUlZUnoyTnhESUpNQlVYTVJCTTFwOXBmQkVHL3JVRjRiVEtHbEpVZTZwWldV?=
 =?utf-8?B?RExEZFBPL2JmZFduMmNoVEh0eTJVdWFHeVVWL2d4dy9JOUFiZDNoL3k3ZWxR?=
 =?utf-8?B?cGFXUk0rVGhhWi9uODRQT3I1ODBKa2xULzZ5Y0xrTmxxQWdqWk9Pb1VwTFdF?=
 =?utf-8?B?QkJPNGlJV3ZOVUdvU1hPMzd1SEUyckNUb1UrcGlPY1dWTll6bkdlVVRuQ2ov?=
 =?utf-8?B?WFZyaURVcG1tTDJrbHNDaWMzSHd6NGdTY0tldy9NMkNsSXp6RzIrYm5TNmRz?=
 =?utf-8?B?L1dqVXpvV0M0c0hER3FJRlJZckxheG1qVlNicm5NZm8xb2dIYWtuZ1h0TGhQ?=
 =?utf-8?B?cTFFelZxWkQwVUFKaVVzUjg1ankvTXozcWhqWUM0cGxRM1U5L296NjRXR2Rv?=
 =?utf-8?B?T1U0RXlGQUpmMjJZQmNKaHJkUkwwZnlMOGVLZEZHekJaaVU5OE8zY214RkhW?=
 =?utf-8?B?QmhuMmVlcnZqb0t2b3ozRjJidmwrSmZzV0lSV3BtTmg4Ly9RZ1pkMHYvc1N6?=
 =?utf-8?B?aFBUb2tBRm1xV2dKeU9mOGxEMmN4MGFNZkVsLzc0MXBEUzk1LzZBZzNJYW1a?=
 =?utf-8?B?UHBlRVJYZmVVdkNQcmV5NXRDNGdYb1dhY0hRKzFSa1VTZjN6ZGllNWRiV3Q3?=
 =?utf-8?Q?s45/tCTZnL4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2ZQdkVHWjhPYUZwOUoxZEo3TVE1cU9Bb3RWaHdCT1hXOFJqdWVEQXJyT2pI?=
 =?utf-8?B?dWhVTjVTRmg0bGpNRi9IYVZENjZwRUs3TWdFVExWa3o1NGYzYTluWHNVVThr?=
 =?utf-8?B?VmpJNHF3N0U1SENpZGtGbW9kU0hIRFRNYloxMmpuR081cFFqelZzelZ0akN3?=
 =?utf-8?B?OVpMQ01OaG12RG55S0MyY0hBSUMxN2FEb1dqKzdzelpVUjRnQ2dFUWlTNDFR?=
 =?utf-8?B?Z0N0QUVyWWFMR0haZGZZZ25TZzl3dU5zTHhSdks0MXRnU3N6QThMVTVtWTU5?=
 =?utf-8?B?YWIvMDk5YUtNbE0xU2JCejNYZisvZjg2OUNwOXVIVHRDRmZ1bmM4UmY3NkNl?=
 =?utf-8?B?WE1QbkRHbFJUdzJhSW1tMlVVRjFyY244ei9oQysxOXV4bWRBZnczbDNOUTZa?=
 =?utf-8?B?NWxnVDBSUk1ESUxzQld6MnNKNkFMR09JZ1NDdnJJMHlnam5lNzF3b1NlVnJw?=
 =?utf-8?B?Sy96MkJnaHJvaTlkU0MvUjZjamlpZ2tEdWJ5OFhacVBkL29SeDFKemhLYUk0?=
 =?utf-8?B?OUVOWUJjQmFiM1lXSVNXWXpBdkFYYmVuZ3NRL2hkbGdMOUVEaTJmUW9XNit0?=
 =?utf-8?B?aEZjVnR1OHJWOHBranlYd2R4M05uZysyZ3RyOXdVZmttb1NVY1ZNTlRTYnkw?=
 =?utf-8?B?Yi9MS3FTL3Jzb05UeE1DS3V4ejlEODZKeDFrRDFGSEJ2RTc1VEx4bG1paXV4?=
 =?utf-8?B?U0cxWENMWkhKb3E4RHkxclBObTI3OHl3TG1sVlFtZGQyTlp5bjgxN214bmRX?=
 =?utf-8?B?UEtCNTlPUVF1SkNBU0JPa3JLVk1wVk5DcHVBZ1JMZW5kZk1Zc3JKcWQ1ODdo?=
 =?utf-8?B?dytPSHUzUHhyYU5qVUdneWs5MTFEWDFBendLeUEvVEpJVHF0WE52ZHJPUjFr?=
 =?utf-8?B?c1pFZitrendpSFZFeTRLbFUralZFcCtrbWdJVkZLeGdWdDJUL1dYNzYrQmRj?=
 =?utf-8?B?MWFHVTJ2cStVWi9INkxlTXpCamJBZ213NmJuMXlxRDFMRVRFay8rd1NNaThP?=
 =?utf-8?B?NkU1TnVLTGZBSkdxa0w1TWFQTFRDcnd6bC9UMUxJRG9rdGxnOENpRVBNSy9w?=
 =?utf-8?B?TkkwMGhJeWZNcGRTQWZVWkpCdXhVVmE4cFlzTE9OQURwZWZBMGV2dmlVS1k0?=
 =?utf-8?B?V0hpcEp2b0d5RjBEa1NscXNiVXl6cDZGSEZmY3BLSzl2bE84NkI2aDdsNFJk?=
 =?utf-8?B?OTRIb0I2MkJ6d2Evb3RzRndTNThQN3FMNHd4RHJ6Qnl5YzRFZ2dwYVZsNjBt?=
 =?utf-8?B?cDFaM0JOcGJ2NE9LbG1xNjJkNjYzaEw4YUpDQlYyOUN1K2xUbTQyQWwwSEd0?=
 =?utf-8?B?TkZhSjJ1Y2EvUHdZcW01VDcxYm9DVVNQY0huK3orRXBKc3l0dG5haTRmQVpP?=
 =?utf-8?B?UWJXTzFvVEF1NFdyVkZ0bmVvelFyTzBjeExVTUZHa1hZK0NyN0RlTHdHd0Vq?=
 =?utf-8?B?Mll3clVmeFlodTlmZjIrUDd5aXgvV3B2MTBFSEQrMksvOHVwdzgvVDVCc0xw?=
 =?utf-8?B?SW9iSjhYVUV6aHRZWEVVZFlwSmdBbEJuVWFaRzV2U3dqVnNQZGtqZzhoZ212?=
 =?utf-8?B?RHcxVzRGMnUwZnZVb1NSZzRvazAvQTNCc255SEorM2c0UUpaeUdXUGVmMnpt?=
 =?utf-8?B?VXlWY0Z3c1N5NU5EVURGQ0JPdFZDK0pRTytraGR4REgzaU1WcVdYUHBOMUZR?=
 =?utf-8?B?V3BkMUovMGZrVEtTUDl1Z2hvRnE2U2dxSkduYWZraTNxcUNMTmNQOFBXN0lo?=
 =?utf-8?B?UUI4TW8yL25sMzVyTHlNYktTZDhXaVNzcE9YSVp5d2NuSzFLVXlhNzdaaWxH?=
 =?utf-8?B?bkwxRFM2TEx2SWZodnZ3VkFRV0ZJWnZGZW1xazFGa2Z3RS9QRmVmS0NOaU85?=
 =?utf-8?B?UUR6M2NQVFkreEFiM1ZMc3RiMmFrWUdqZm1pem45TzRaMHBhVndGSndaVnhH?=
 =?utf-8?B?dTZ3T1lNUkllWSszQ2hTWmFTOHF5RGFOQWplVWpBU1B5M3dBLzJuMVgrNnRr?=
 =?utf-8?B?eCtsZTd3TmhobjBHclhudXlWRHNwczNvYjlXeHFkRGM3eFljOGxkRlBmZm9z?=
 =?utf-8?B?R2FaMFB6cnRMaEphbURTajNHcmVwaXd0SHlRUzhwWURJWlg3RzdmN09oWjYr?=
 =?utf-8?Q?zk4IKSrXgBT3fuRjUpdIpaV0L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f241f8-4766-4bb3-34d9-08dd92b82e2a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 07:23:10.9631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hq20hQn8PK1Qn6HUv/MBsjU8koYmaJrSB1Gb1H8T4dSGFIpWtcW8SAto6WlwhsbY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067
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



On 5/14/2025 11:51 AM, Shiwu Zhang wrote:
> Expose the debugfs file node for user space to dump the IFWI image
> on spirom.
> 
> For one transaction between PSP and host, it will read out the
> images on both active and inactive partitions so a buffer with two
> times the size of maximum IFWI image (currently 16MByte) is needed.
> 
> v2: move the vbios gfl macros to the common header and rename the
>     bo triplet struct to spirom_bo for this specfic usage (Hawking)
> 
> v3: return directly the result of last command execution (Lijo)
> 
> Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c     | 104 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h     |  29 ++++++
>  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c      |  44 +++++++--
>  4 files changed, 168 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 4835123c99f3..bfa3b1519d4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2113,6 +2113,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>  	amdgpu_rap_debugfs_init(adev);
>  	amdgpu_securedisplay_debugfs_init(adev);
>  	amdgpu_fw_attestation_debugfs_init(adev);
> +	amdgpu_psp_debugfs_init(adev);
>  
>  	debugfs_create_file("amdgpu_evict_vram", 0400, root, adev,
>  			    &amdgpu_evict_vram_fops);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 6f9bcffda875..3a27ce75f80c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -4185,6 +4185,110 @@ const struct attribute_group amdgpu_flash_attr_group = {
>  	.is_visible = amdgpu_flash_attr_is_visible,
>  };
>  
> +#if defined(CONFIG_DEBUG_FS)
> +static int psp_read_spirom_debugfs_open(struct inode *inode, struct file *filp)
> +{
> +	struct amdgpu_device *adev = filp->f_inode->i_private;
> +	struct spirom_bo *bo_triplet;
> +	int ret;
> +
> +	/* serialize the open() file calling */
> +	if (!mutex_trylock(&adev->psp.mutex))
> +		return -EBUSY;
> +
> +	/*
> +	 * make sure only one userpace process is alive for dumping so that
> +	 * only one memory buffer of AMD_VBIOS_FILE_MAX_SIZE * 2 is consumed.
> +	 * let's say the case where one process try opening the file while
> +	 * another one has proceeded to read or release. In this way, eliminate
> +	 * the use of mutex for read() or release() callback as well.
> +	 */
> +	if (adev->psp.spirom_dump_trip) {
> +		mutex_unlock(&adev->psp.mutex);
> +		return -EBUSY;
> +	}
> +

Didn't notice this before. Once rom buffer is allocated/read, you could
allow multiple reads at the same time. FS backend will handle that.
Release is called only when all references to the file is closed.

For ex: in open, you could do like

	if (file_count(filp) > 1)
		return 0;

If the file is successfully opened by someone else we have a valid rom
buffer available. Rest of the ops like read/seek etc. are handled
properly by FS. Once all users do close(fd), release() is called and
that time we are also releasing the rom buffer.

Thanks,
Lijo

> +	bo_triplet = kzalloc(sizeof(struct spirom_bo), GFP_KERNEL);
> +	if (!bo_triplet) {
> +		mutex_unlock(&adev->psp.mutex);
> +		return -ENOMEM;
> +	}
> +
> +	ret = amdgpu_bo_create_kernel(adev, AMD_VBIOS_FILE_MAX_SIZE_B * 2,
> +					AMDGPU_GPU_PAGE_SIZE,
> +					AMDGPU_GEM_DOMAIN_GTT,
> +					&bo_triplet->bo,
> +					&bo_triplet->mc_addr,
> +					&bo_triplet->cpu_addr);
> +	if (ret)
> +		goto rel_trip;
> +
> +	ret = psp_dump_spirom(&adev->psp, bo_triplet->mc_addr);
> +	if (ret)
> +		goto rel_bo;
> +
> +	adev->psp.spirom_dump_trip = bo_triplet;
> +	mutex_unlock(&adev->psp.mutex);
> +	return 0;
> +rel_bo:
> +	amdgpu_bo_free_kernel(&bo_triplet->bo, &bo_triplet->mc_addr,
> +			      &bo_triplet->cpu_addr);
> +rel_trip:
> +	kfree(bo_triplet);
> +	mutex_unlock(&adev->psp.mutex);
> +	dev_err(adev->dev, "Trying IFWI dump fails, err = %d\n", ret);
> +	return ret;
> +}
> +
> +static ssize_t psp_read_spirom_debugfs_read(struct file *filp, char __user *buf, size_t size,
> +				loff_t *pos)
> +{
> +	struct amdgpu_device *adev = filp->f_inode->i_private;
> +	struct spirom_bo *bo_triplet = adev->psp.spirom_dump_trip;
> +
> +	if (!bo_triplet)
> +		return -EINVAL;
> +
> +	return simple_read_from_buffer(buf,
> +				       size,
> +				       pos, bo_triplet->cpu_addr,
> +				       AMD_VBIOS_FILE_MAX_SIZE_B * 2);
> +}
> +
> +static int psp_read_spirom_debugfs_release(struct inode *inode, struct file *filp)
> +{
> +	struct amdgpu_device *adev = filp->f_inode->i_private;
> +	struct spirom_bo *bo_triplet = adev->psp.spirom_dump_trip;
> +
> +	if (bo_triplet) {
> +		amdgpu_bo_free_kernel(&bo_triplet->bo, &bo_triplet->mc_addr,
> +				      &bo_triplet->cpu_addr);
> +		kfree(bo_triplet);
> +	}
> +
> +	adev->psp.spirom_dump_trip = NULL;
> +	return 0;
> +}
> +
> +static const struct file_operations psp_dump_spirom_debugfs_ops = {
> +	.owner = THIS_MODULE,
> +	.open = psp_read_spirom_debugfs_open,
> +	.read = psp_read_spirom_debugfs_read,
> +	.release = psp_read_spirom_debugfs_release,
> +	.llseek = default_llseek,
> +};
> +#endif
> +
> +void amdgpu_psp_debugfs_init(struct amdgpu_device *adev)
> +{
> +#if defined(CONFIG_DEBUG_FS)
> +	struct drm_minor *minor = adev_to_drm(adev)->primary;
> +
> +	debugfs_create_file_size("psp_spirom_dump", 0444, minor->debugfs_root,
> +				adev, &psp_dump_spirom_debugfs_ops, AMD_VBIOS_FILE_MAX_SIZE_B * 2);
> +#endif
> +}
> +
>  const struct amd_ip_funcs psp_ip_funcs = {
>  	.name = "psp",
>  	.early_init = psp_early_init,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index 3876ac57ce62..089b6ae48329 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -39,6 +39,18 @@
>  #define PSP_TMR_ALIGNMENT	0x100000
>  #define PSP_FW_NAME_LEN		0x24
>  
> +/* VBIOS gfl defines */
> +#define MBOX_READY_MASK 0x80000000
> +#define MBOX_STATUS_MASK 0x0000FFFF
> +#define MBOX_COMMAND_MASK 0x00FF0000
> +#define MBOX_READY_FLAG 0x80000000
> +#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO 0x2
> +#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI 0x3
> +#define C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE 0x4
> +#define C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_LO 0xf
> +#define C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI 0x10
> +#define C2PMSG_CMD_SPI_GET_FLASH_IMAGE 0x11
> +
>  extern const struct attribute_group amdgpu_flash_attr_group;
>  
>  enum psp_shared_mem_size {
> @@ -138,6 +150,7 @@ struct psp_funcs {
>  	int (*load_usbc_pd_fw)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
>  	int (*read_usbc_pd_fw)(struct psp_context *psp, uint32_t *fw_ver);
>  	int (*update_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
> +	int (*dump_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_addr);
>  	int (*vbflash_stat)(struct psp_context *psp);
>  	int (*fatal_error_recovery_quirk)(struct psp_context *psp);
>  	bool (*get_ras_capability)(struct psp_context *psp);
> @@ -322,6 +335,14 @@ struct psp_runtime_scpm_entry {
>  	enum psp_runtime_scpm_authentication scpm_status;
>  };
>  
> +#if defined(CONFIG_DEBUG_FS)
> +struct spirom_bo {
> +	struct amdgpu_bo *bo;
> +	uint64_t mc_addr;
> +	void *cpu_addr;
> +};
> +#endif
> +
>  struct psp_context {
>  	struct amdgpu_device		*adev;
>  	struct psp_ring			km_ring;
> @@ -409,6 +430,9 @@ struct psp_context {
>  	char				*vbflash_tmp_buf;
>  	size_t				vbflash_image_size;
>  	bool				vbflash_done;
> +#if defined(CONFIG_DEBUG_FS)
> +	struct spirom_bo *spirom_dump_trip;
> +#endif
>  };
>  
>  struct amdgpu_psp_funcs {
> @@ -467,6 +491,10 @@ struct amdgpu_psp_funcs {
>  	((psp)->funcs->update_spirom ? \
>  	(psp)->funcs->update_spirom((psp), fw_pri_mc_addr) : -EINVAL)
>  
> +#define psp_dump_spirom(psp, fw_pri_mc_addr) \
> +	((psp)->funcs->dump_spirom ? \
> +	(psp)->funcs->dump_spirom((psp), fw_pri_mc_addr) : -EINVAL)
> +
>  #define psp_vbflash_status(psp) \
>  	((psp)->funcs->vbflash_stat ? \
>  	(psp)->funcs->vbflash_stat((psp)) : -EINVAL)
> @@ -578,6 +606,7 @@ int psp_config_sq_perfmon(struct psp_context *psp, uint32_t xcc_id,
>  bool amdgpu_psp_tos_reload_needed(struct amdgpu_device *adev);
>  int amdgpu_psp_reg_program_no_ring(struct psp_context *psp, uint32_t val,
>  				   enum psp_reg_prog_id id);
> +void amdgpu_psp_debugfs_init(struct amdgpu_device *adev);
>  
>  
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> index 17f1ccd8bd53..ec9462336bcf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> @@ -71,15 +71,6 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_4_ta.bin");
>  /* Retry times for vmbx ready wait */
>  #define PSP_VMBX_POLLING_LIMIT 3000
>  
> -/* VBIOS gfl defines */
> -#define MBOX_READY_MASK 0x80000000
> -#define MBOX_STATUS_MASK 0x0000FFFF
> -#define MBOX_COMMAND_MASK 0x00FF0000
> -#define MBOX_READY_FLAG 0x80000000
> -#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO 0x2
> -#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI 0x3
> -#define C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE 0x4
> -
>  /* memory training timeout define */
>  #define MEM_TRAIN_SEND_MSG_TIMEOUT_US	3000000
>  
> @@ -710,7 +701,8 @@ static int psp_v13_0_exec_spi_cmd(struct psp_context *psp, int cmd)
>  	/* Ring the doorbell */
>  	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_73, 1);
>  
> -	if (cmd == C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE)
> +	if (cmd == C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE ||
> +	    cmd == C2PMSG_CMD_SPI_GET_FLASH_IMAGE)
>  		ret = psp_wait_for_spirom_update(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115),
>  						 MBOX_READY_FLAG, MBOX_READY_MASK, PSP_SPIROM_UPDATE_TIMEOUT);
>  	else
> @@ -766,6 +758,37 @@ static int psp_v13_0_update_spirom(struct psp_context *psp,
>  	return 0;
>  }
>  
> +static int psp_v13_0_dump_spirom(struct psp_context *psp,
> +				   uint64_t fw_pri_mc_addr)
> +{
> +	struct amdgpu_device *adev = psp->adev;
> +	int ret;
> +
> +	/* Confirm PSP is ready to start */
> +	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_115),
> +			   MBOX_READY_FLAG, MBOX_READY_MASK, false);
> +	if (ret) {
> +		dev_err(adev->dev, "PSP Not ready to start processing, ret = %d", ret);
> +		return ret;
> +	}
> +
> +	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_116, lower_32_bits(fw_pri_mc_addr));
> +
> +	ret = psp_v13_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_LO);
> +	if (ret)
> +		return ret;
> +
> +	WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_116, upper_32_bits(fw_pri_mc_addr));
> +
> +	ret = psp_v13_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI);
> +	if (ret)
> +		return ret;
> +
> +	ret = psp_v13_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_GET_FLASH_IMAGE);
> +
> +	return ret;
> +}
> +
>  static int psp_v13_0_vbflash_status(struct psp_context *psp)
>  {
>  	struct amdgpu_device *adev = psp->adev;
> @@ -898,6 +921,7 @@ static const struct psp_funcs psp_v13_0_funcs = {
>  	.load_usbc_pd_fw = psp_v13_0_load_usbc_pd_fw,
>  	.read_usbc_pd_fw = psp_v13_0_read_usbc_pd_fw,
>  	.update_spirom = psp_v13_0_update_spirom,
> +	.dump_spirom = psp_v13_0_dump_spirom,
>  	.vbflash_stat = psp_v13_0_vbflash_status,
>  	.fatal_error_recovery_quirk = psp_v13_0_fatal_error_recovery_quirk,
>  	.get_ras_capability = psp_v13_0_get_ras_capability,

