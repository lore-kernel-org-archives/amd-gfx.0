Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EB3C02198
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 21:00:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 950DC10E08B;
	Tue,  4 Feb 2025 21:00:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5d7H3deQ";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B81C810E08B
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 21:00:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRuN/kJisAxDjSdm4Z8fklj6W7RJ5e8ZYVgKEF0uT/2v5aw+Fwhq4584uWnvUMRj+uJpcEiV0JanJrYEMPAUHaoknlP1Ui87DJqhrehMZKRneT7vVBa22qAIRehniZQ1lYq8k1fn7drOrEaFod6S63eOyMn3eTyFkV8MBri5YPZMbL8eqUmoaS0e/fsU6QHIXpl/hw7ntZAOVRMpUZq5bA/4S9roQ8HcPmASOzprXG2+iZfEKz5WH1SeKtpYCgu/rWT1MZvmCSzyeT0SBafrGjLp6k32MRuDZn7ifBameQwyFmkcuEN6u6gdWeJjeKg6MGImgfrRkVaXuuvkI3xxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HO10nZ4mrVC7twgeeeVXmsvZM1zKhLlrTG9rul0msNo=;
 b=dC8jeljlx9kGIp+9BFSoTBlEa4cR17I86OLS35eSObdeUgaYQqqZ+EUdweYkOUrgduu02BjBzigPqcVax1Lo3aVWOTC19LUWSPVbjkKBGFdN8Vyrk6zGRKb9Kv0uawn3qJQOVZqu8JYOZlxHJkDMH8iwWvJje61QAnQ2o+wy7IUxbPB0ue66T0f0RNOxjcxm2Uav3aZFBQ+hIsTwSQN9Ow4XDwVVlGRtBJOovTahcQUHEwKBqfGh9+3AsJKnqVUlSoOwT6xi3IZcpg0xG1VXwabdl1DOkQPGulh9SfS7Z8mno79XwIrRjeNYvZNtwuanJQI+1LMlfwuulB8Nwm9m6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO10nZ4mrVC7twgeeeVXmsvZM1zKhLlrTG9rul0msNo=;
 b=5d7H3deQhBpYeaUZUe8W6KtK83Hmy0i9Vxvd4lpAs2V3t18Wh83SW/DP/bntc6v6cX8CdNXlHEXytU8aZHaSjT1mUkudYhMoqF3W9XPSvmaVh+ZMp4+d73qb70jB3rTdNfcI1x3tpKoT5wZsob1nA3QPpBAMmaBfyXhHQ42sjVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Tue, 4 Feb
 2025 21:00:02 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 21:00:01 +0000
Content-Type: multipart/alternative;
 boundary="------------nQmkx8z2LLEBzdZx9Gf4HbiX"
Message-ID: <be5820fb-2a72-405d-84c2-79d964dda7cb@amd.com>
Date: Tue, 4 Feb 2025 15:59:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/44] drm/amdgpu/vcn: switch work handler to be per
 instance
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-9-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-9-alexander.deucher@amd.com>
X-ClientProxiedBy: YTBP288CA0020.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::33) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|PH0PR12MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: a77babdb-7806-4a5f-3f44-08dd455ee3e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVFnL0ZvOURnWGVHWU5ZRHRYZUR3RHBZdS9tNXBjQnZtWHRseFJDbUpvejZp?=
 =?utf-8?B?RWdzL3kyamZxa3NkRWcvUFAvMmFQc2plUVg1Z0NPdmhkVGtqeHhJTTIzWVdl?=
 =?utf-8?B?UCsvZW1ONXdEaWV5YS9PWG5PZWhuWW9PM0JIZ3UzbnpBakhFOUczZDdEbW82?=
 =?utf-8?B?VjlvdVEwMTV0SERTREk5YllwcmNOMEdSSlliMXBweTFvMWIwUWtUQ055MURl?=
 =?utf-8?B?UVo5dk5jSldlb0FaTlRNSWxWSlY1MEZoZkU5UE9tT29NL3BZSXFUK3NkTGxj?=
 =?utf-8?B?Vis1ZjFlNVZVTnRReDY5eGtFN3NSNlhuUy95Q2QyeUk5MkJKUXd2K2NsVXBu?=
 =?utf-8?B?OHI5dDFqWm9zM2hQV1M1V2hSUTR6UlY4RlNWNE9vcG4rZ29HMUhmRFUxdWYx?=
 =?utf-8?B?T1ZWanc3elZJTDRWcnMzbm9WZG1YK0o2eDVwVTl0dVVueUxFU2hmeC9KY0Jm?=
 =?utf-8?B?YmJacHVYNUVQcXRqYTI5YWJMLzdOTjBYM0RsV053SjFsdE95enA0MTZtQ2RN?=
 =?utf-8?B?VFg4VVVqdWYyRzdOSFNXZmhBWGhBOGh3M0FrWllweTVOWG5BZ0E2akJGdGF5?=
 =?utf-8?B?MUdZV25IRHVSN2ZQN0FqZnYzUjg4WXNZVHMyV3lWd1huamE1b0kxdnRNVzVD?=
 =?utf-8?B?MktQT3Q0SUkrUGZKTDMwdk9Jd28vS1R4a3puUEZEQ2EyMGRmM1NIWWNMdFBh?=
 =?utf-8?B?T2lmQUVoTzF5cTRBNVFReTBlbkVZdTlnOHlaSTN2MGtHM1ZCMno0bDMrVDJU?=
 =?utf-8?B?Z3lkTWJyWVpMVTJ3cXFvNE1YRHdzTXRTMFdUQklWdVNNeGtSR2dBSE04MXEy?=
 =?utf-8?B?cDNJWFk5SlpUL3lZQis3MWRxVXZhQ3dscXgrTjliUGVsQ2w0NHdaeXpkSFdQ?=
 =?utf-8?B?L3cwYkc5dGxVWjZxTXV1VDFGbDRXK3M5R0ZCNTZvNXdrNUd5YXBlVHNNSmN5?=
 =?utf-8?B?RzQzVjYvZ3VDeEZackZFTnZ4Vm9aSWxNL1BaSHJuZHdaNDB1MCtUZlRVRzFx?=
 =?utf-8?B?TEZ5U242SThDU0RNd1RYeTBjeXVHNnVBL0ExczhscWVaalJ0UFA4bExXRnR4?=
 =?utf-8?B?ZUtiVVlxZlJ3WkR2MmUzRVFhczVSQ3Qvd2MxdXQ0cTZ1RG51SGRlMGxLNW1j?=
 =?utf-8?B?S0hWYkNFd1FYR0tGQ3NUWE1MOGlmK3V0UDZNYzd5bXlJYkZuNXFNemVLYklK?=
 =?utf-8?B?NnQ5VzVNcnhVQUVvWlZ1RVBkRGhuRytEdVAzQ2p4aFhWelFjb29DM0pEcWhn?=
 =?utf-8?B?R0JyTlhVUTkyY0p3Nm81SnJqMnZFU3NpYThtTStReGZ4Si9FRFJUdkpHZUxZ?=
 =?utf-8?B?V1ZNTW5uVXJkNTB0K0VVOU1aSFRVSjlRVmU3OVlJamQ5Yzcwb0xLQ2M2bUI5?=
 =?utf-8?B?YkRIYTlsOTl4aXVEN3pCdUhFZW5FQ2ZFeStQZ25ZTHArSWpJdUVMaGp5TFZB?=
 =?utf-8?B?YW1SQzJJUkUvZTR4SUJSUVNNNXIxc0FscFlaU0pVSE01QUpOMUJLTDJSR05S?=
 =?utf-8?B?ZTZlNVhOT1VkZURlSlpJUEhaWWdKMUFKaCtyTkJZV0dId0pXUU1YNklDOHBB?=
 =?utf-8?B?SzNPWmlJcGlEZGdZNnB2MzMzelpzdE9XMmxTY3NJN1A0S2NmKzhYUlNyeWlD?=
 =?utf-8?B?WkU2TmZSYTZhYmlIOWRmTUhBbjZoR1NRVGFjUGhqcno0MXRSU0VaWDRKVFRK?=
 =?utf-8?B?dWo0Z0N1NnI5Q21tZFRISnMzTTExZmc1bVNKSXZySkhyQ2ZFRWVoV0JJUUNa?=
 =?utf-8?B?MTgrRzdGc0RaZXhLYTVNQWFPMVlHa0xlc2xjS1AvRzdzYU11dE9WT1V0ajcy?=
 =?utf-8?B?KzBQYkdESndPdStva2ZRWVJKSWYrT2ErRG1tUGIrcVRjc2ZEUm5ld1Y5cVRJ?=
 =?utf-8?Q?/P2dxWDD6cEOl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFdsN0xZNUhwdVR1dXhHcGdlcTY5MGlNeGlBR2szMXFVdURXR25CbC9FdStV?=
 =?utf-8?B?L0lMdUUweG16ME5IeHVaa1k3Tnpxai9leHFralFmUVptUzlRZVMwMmdJYnNp?=
 =?utf-8?B?d0xsSDJUaGxuZzZNYXZUUm83b09IMXVaYXRsa2tPdGlNS0FRbXhpYS9qMzAv?=
 =?utf-8?B?KzZiNTIwTkc4TDdoVTE3R0l0MmxtRmdFK2ljMXVMU1pnOTlqakYzVU4zcEJt?=
 =?utf-8?B?MHcxRC9VYTcrYmZXamg5VW9YaU0vYTY5TEFYNGZCNExtMkdaenNhYndzWVhL?=
 =?utf-8?B?QndmY2JPUHVSS2tPRVN3Tnp3UHRwbVhNTGVockVLVHRLY2g1VkcvYVNMSG1x?=
 =?utf-8?B?NFRCSW0wRWp6STJtRzkvNUhxc2RGMlRxQy81azJxZ3phMUhoWFliblVCS0RJ?=
 =?utf-8?B?aUdUZkZFZWJuSlhwSDhqUzNuUURxV3YvWmxLSldIZlJ5T2l1R3FTZ3g0QXgr?=
 =?utf-8?B?VEI3ZVZNOWhPWVVOc3Q4MG1Rb1dIM3pTSks1NHdnNmMvS29NUUFhOVpqc0l2?=
 =?utf-8?B?L1FlaVJmcXI3Tm1IZTQ5OGRxK1g0RENNd2JMN0hwY2NQL0xpbG9MUTgxRlpZ?=
 =?utf-8?B?aUZjMGczTElEUDY3VkgwZ2tONGJpREZ4SkFpSyt4QXlJZm90dHJ0YmNKYjdJ?=
 =?utf-8?B?RkpZYml2dElHOHJrTGZ2NFc4T3o3cDJRTEdSeEhmc25KT25JQkRkWnpIaHhE?=
 =?utf-8?B?dEF4VVplcFQrNXNLai9tYVRXekR4VjJhWlVWV1lUYWtSaThuUDYrY1F0SEFI?=
 =?utf-8?B?YU9yQkhHZWxjY3d5SFJ5OU9McXVEMzh5amRRQlYrTzRiOG9aTWlKNzVQREVz?=
 =?utf-8?B?ZVFaK0R4Vk1IeEIvNFUwZFpTU2doaURxOGdVL3FwZW1oZEp4KzhJTTNWeS9v?=
 =?utf-8?B?bk1DbTdib2s2dU55bEpFYjRnUEtrZzA2aUpGenMxYi9XSnBTOWkwMWlqSFlp?=
 =?utf-8?B?OU5sNXhVRkxGMUduV2FTR2xzTWd3YzdSdDdubTJsWEFrQVFtRXJjOExkcTFQ?=
 =?utf-8?B?Rks3YzY0WjRqTlBoYlpvZm5TczJBcXY5NnY1SzFmcW85dE1uT2dwbFkxNy9U?=
 =?utf-8?B?WE5UNEkyamJrTDNFRWxJWDRRdzF3Y0VFemZZZlBaMWtOZFRDZzNjNVZDbVN3?=
 =?utf-8?B?Y2MxaFMrMHRDbUFuUWl2ZUxrTGFMWDkyZG9JNmdTN1k4dGljT2Z1bHdFUmc4?=
 =?utf-8?B?ZXhYbFQ5VktLNU5xbWJ2dGFnU3BKWkp4cDNZY3FCVm1YR2VteXhrdDRNaXE1?=
 =?utf-8?B?SkUxRmRRbUdoQUVhMEd5ekxURWp3cGNXUUdoblEyc1MzbFJwUHgxcW55OTJE?=
 =?utf-8?B?cEhkMmJaK3FYNGNiYUJIVzlZVGhKbDVYTDRScWxWVnk2bDhVTTdLcGs3TFNW?=
 =?utf-8?B?VWdBZ0JoenJURHJ4eXhyQjJTZFhveU9lb3Z1Ukp4c1dwT0hMa0d5dWFnRzgz?=
 =?utf-8?B?eWRWM1BDUm9DWkQ4Yi9mNm9kUzdLaFZ3dDg4N0VnY1gybUswSytiNlFMSVRL?=
 =?utf-8?B?dy9VdUZVcjlrVEJtUXFuYkVUYXEwQzdlM0R0ckJMeEhiZmlhT1Btc0hGKy9a?=
 =?utf-8?B?T2VySGJXeXBudi9QaURSSXM5MURYYjk3emYwMXAxblRUS1Rzc3hoR2Eyano0?=
 =?utf-8?B?S1J5NVg5QkxEQVZqVWU1Smk0U1Q5eWIyZXZvOWx4NWNJQ0hGRUZNVUhXN3hu?=
 =?utf-8?B?UXQwL2VFRzAzS3JCTGdORkE3NDdFWnd4MzZxbEJNMW13S1BiM1VBa1BnT0hD?=
 =?utf-8?B?NHpEM1QrN21UK2lOcHhNRlIvQTh4VVZGMnZSM3JmTXBoMHBaS250TnhuNXdK?=
 =?utf-8?B?Y1A4R3NGdm1qZkViSmVYTW9nT3Q1VTBwbzBGSDRhWGR2d0xHNTFDQmExb2li?=
 =?utf-8?B?SkVUY29rWFZ6cjVja0cvUDA5RlVQVXdKQSt6cENQUzloSzJWR29YTHk1T3pl?=
 =?utf-8?B?ODZwSHVSM1pkSy9sQng0R0RQSkt2ZlU2cGJwWEFwTkNhc2Rid1g5eTVNY2RG?=
 =?utf-8?B?QThicDA4YXJxYjVmVWM5SE5pRFQxWk9SZ3dJUGs1RUdPakJKV01LVnphZGta?=
 =?utf-8?B?dkNYRXBkOCtERUlWWUl0UU05VTFvb3I2QWdYNkltNHhkMVd2QjdlNUZmUVNY?=
 =?utf-8?Q?E+f5+vtJb2PvyJ4SGs9W5PKv3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a77babdb-7806-4a5f-3f44-08dd455ee3e2
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 21:00:01.1536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p904t6HVePoaK3qIhF0YNOBMp5aqGAF91ogIugRS4ztpGMJnkNnJFJjaMVRyL8CAmdK0f/oTftcfMAaObN9xnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7982
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

--------------nQmkx8z2LLEBzdZx9Gf4HbiX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:57, Alex Deucher wrote:
> Have a separate work handler for each VCN instance. This
> paves the way for per instance VCN power gating at runtime.
>
> v2: index instances directly on vcn1.0 and 2.0 to make
> it clear that they only support a single instance (Lijo)
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 84 +++++++++++++------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  8 ++-
>   drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 17 ++---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  4 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  4 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  5 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  4 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  5 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  5 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c |  4 +-
>   12 files changed, 80 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 83faf6e6788a2..0c3081a198d9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -100,6 +100,9 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev)
>   
>   	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
>   	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		adev->vcn.inst[i].adev = adev;
> +		adev->vcn.inst[i].inst = i;
> +
>   		if (i == 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
>   			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw,
>   						 AMDGPU_UCODE_REQUIRED,
> @@ -124,12 +127,13 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>   	unsigned int fw_shared_size, log_offset;
>   	int i, r;
>   
> -	INIT_DELAYED_WORK(&adev->vcn.idle_work, amdgpu_vcn_idle_work_handler);
> -	mutex_init(&adev->vcn.vcn_pg_lock);
>   	mutex_init(&adev->vcn.vcn1_jpeg1_workaround);
> -	atomic_set(&adev->vcn.total_submission_cnt, 0);
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +		mutex_init(&adev->vcn.inst[i].vcn_pg_lock);
> +		atomic_set(&adev->vcn.inst[i].total_submission_cnt, 0);
> +		INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
>   		atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
> +	}
>   
>   	if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
>   	    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
> @@ -277,10 +281,10 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
>   			amdgpu_ring_fini(&adev->vcn.inst[j].ring_enc[i]);
>   
>   		amdgpu_ucode_release(&adev->vcn.inst[j].fw);
> +		mutex_destroy(&adev->vcn.inst[j].vcn_pg_lock);
>   	}
>   
>   	mutex_destroy(&adev->vcn.vcn1_jpeg1_workaround);
> -	mutex_destroy(&adev->vcn.vcn_pg_lock);
>   
>   	return 0;
>   }
> @@ -331,8 +335,10 @@ int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev)
>   int amdgpu_vcn_suspend(struct amdgpu_device *adev)
>   {
>   	bool in_ras_intr = amdgpu_ras_intr_triggered();
> +	int i;
>   
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
>   
>   	/* err_event_athub will corrupt VCPU buffer, so we need to
>   	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
> @@ -388,46 +394,45 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
>   
>   static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>   {
> -	struct amdgpu_device *adev =
> -		container_of(work, struct amdgpu_device, vcn.idle_work.work);
> +	struct amdgpu_vcn_inst *vcn_inst =
> +		container_of(work, struct amdgpu_vcn_inst, idle_work.work);
> +	struct amdgpu_device *adev = vcn_inst->adev;
>   	unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
> -	unsigned int i, j;
> +	unsigned int i = vcn_inst->inst, j;
>   	int r = 0;
>   
> -	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
> -		if (adev->vcn.harvest_config & (1 << j))
> -			continue;
> -
> -		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
> -			fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_enc[i]);
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return;
>   
> -		/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
> -		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> -		    !adev->vcn.using_unified_queue) {
> -			struct dpg_pause_state new_state;
> +	for (j = 0; j < adev->vcn.num_enc_rings; ++j)
> +		fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>   
> -			if (fence[j] ||
> -				unlikely(atomic_read(&adev->vcn.inst[j].dpg_enc_submission_cnt)))
> -				new_state.fw_based = VCN_DPG_STATE__PAUSE;
> -			else
> -				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
> +	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> +	    !adev->vcn.using_unified_queue) {
> +		struct dpg_pause_state new_state;
>   
> -			adev->vcn.pause_dpg_mode(adev, j, &new_state);
> -		}
> +		if (fence[i] ||
> +		    unlikely(atomic_read(&vcn_inst->dpg_enc_submission_cnt)))
> +			new_state.fw_based = VCN_DPG_STATE__PAUSE;
> +		else
> +			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>   
> -		fence[j] += amdgpu_fence_count_emitted(&adev->vcn.inst[j].ring_dec);
> -		fences += fence[j];
> +		adev->vcn.pause_dpg_mode(adev, i, &new_state);
>   	}
>   
> -	if (!fences && !atomic_read(&adev->vcn.total_submission_cnt)) {
> +	fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
> +	fences += fence[i];
> +
> +	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>   		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> -		       AMD_PG_STATE_GATE);
> +						       AMD_PG_STATE_GATE);
>   		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
> -				false);
> +						    false);
>   		if (r)
>   			dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
>   	} else {
> -		schedule_delayed_work(&adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
> +		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
>   	}
>   }
>   
> @@ -436,18 +441,18 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   	struct amdgpu_device *adev = ring->adev;
>   	int r = 0;
>   
> -	atomic_inc(&adev->vcn.total_submission_cnt);
> +	atomic_inc(&adev->vcn.inst[ring->me].total_submission_cnt);
>   
> -	if (!cancel_delayed_work_sync(&adev->vcn.idle_work)) {
> +	if (!cancel_delayed_work_sync(&adev->vcn.inst[ring->me].idle_work)) {
>   		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
>   				true);
>   		if (r)
>   			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
>   	}
>   
> -	mutex_lock(&adev->vcn.vcn_pg_lock);
> +	mutex_lock(&adev->vcn.inst[ring->me].vcn_pg_lock);
>   	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
> -	       AMD_PG_STATE_UNGATE);
> +					       AMD_PG_STATE_UNGATE);
>   
>   	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> @@ -472,7 +477,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>   
>   		adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
>   	}
> -	mutex_unlock(&adev->vcn.vcn_pg_lock);
> +	mutex_unlock(&adev->vcn.inst[ring->me].vcn_pg_lock);
>   }
>   
>   void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
> @@ -485,9 +490,10 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
>   	    !adev->vcn.using_unified_queue)
>   		atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
>   
> -	atomic_dec(&ring->adev->vcn.total_submission_cnt);
> +	atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cnt);
>   
> -	schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
> +	schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
> +			      VCN_IDLE_TIMEOUT);
>   }
>   
>   int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index c92f683ee5958..f1685283c2f13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -295,6 +295,8 @@ struct amdgpu_vcn_fw_shared {
>   };
>   
>   struct amdgpu_vcn_inst {
> +	struct amdgpu_device	*adev;
> +	int			inst;
>   	struct amdgpu_bo	*vcpu_bo;
>   	void			*cpu_addr;
>   	uint64_t		gpu_addr;
> @@ -316,6 +318,9 @@ struct amdgpu_vcn_inst {
>   	const struct firmware	*fw; /* VCN firmware */
>   	uint8_t			vcn_config;
>   	uint32_t		vcn_codec_disable_mask;
> +	atomic_t		total_submission_cnt;
> +	struct mutex		vcn_pg_lock;
> +	struct delayed_work	idle_work;
>   };
>   
>   struct amdgpu_vcn_ras {
> @@ -324,7 +329,6 @@ struct amdgpu_vcn_ras {
>   
>   struct amdgpu_vcn {
>   	unsigned		fw_version;
> -	struct delayed_work	idle_work;
>   	unsigned		num_enc_rings;
>   	enum amd_powergating_state cur_state;
>   	bool			indirect_sram;
> @@ -332,9 +336,7 @@ struct amdgpu_vcn {
>   	uint8_t	num_vcn_inst;
>   	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
>   	struct amdgpu_vcn_reg	 internal;
> -	struct mutex		 vcn_pg_lock;
>   	struct mutex		vcn1_jpeg1_workaround;
> -	atomic_t		 total_submission_cnt;
>   
>   	unsigned	harvest_config;
>   	int (*pause_dpg_mode)(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> index 03b8b7cd5229b..8031406e20ff9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> @@ -604,7 +604,7 @@ static void jpeg_v1_0_set_irq_funcs(struct amdgpu_device *adev)
>   static void jpeg_v1_0_ring_begin_use(struct amdgpu_ring *ring)
>   {
>   	struct	amdgpu_device *adev = ring->adev;
> -	bool	set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	bool	set_clocks = !cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>   	int		cnt = 0;
>   
>   	mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 5ea96c9835170..b90d41cd001c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -150,7 +150,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		return r;
>   
>   	/* Override the work func */
> -	adev->vcn.idle_work.work.func = vcn_v1_0_idle_work_handler;
> +	adev->vcn.inst[0].idle_work.work.func = vcn_v1_0_idle_work_handler;
>   
>   	amdgpu_vcn_setup_ucode(adev);
>   
> @@ -277,7 +277,7 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>   
>   	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>   		(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> @@ -301,7 +301,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	bool idle_work_unexecuted;
>   
> -	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>   	if (idle_work_unexecuted) {
>   		if (adev->pm.dpm_enabled)
>   			amdgpu_dpm_enable_vcn(adev, false, 0);
> @@ -1828,8 +1828,9 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   
>   static void vcn_v1_0_idle_work_handler(struct work_struct *work)
>   {
> -	struct amdgpu_device *adev =
> -		container_of(work, struct amdgpu_device, vcn.idle_work.work);
> +	struct amdgpu_vcn_inst *vcn_inst =
> +		container_of(work, struct amdgpu_vcn_inst, idle_work.work);
> +	struct amdgpu_device *adev = vcn_inst->adev;
>   	unsigned int fences = 0, i;
>   
>   	for (i = 0; i < adev->vcn.num_enc_rings; ++i)
> @@ -1862,14 +1863,14 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
>   			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
>   			       AMD_PG_STATE_GATE);
>   	} else {
> -		schedule_delayed_work(&adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
> +		schedule_delayed_work(&adev->vcn.inst[0].idle_work, VCN_IDLE_TIMEOUT);
>   	}
>   }
>   
>   static void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring)
>   {
>   	struct	amdgpu_device *adev = ring->adev;
> -	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	bool set_clocks = !cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>   
>   	mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
>   
> @@ -1921,7 +1922,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
>   
>   void vcn_v1_0_ring_end_use(struct amdgpu_ring *ring)
>   {
> -	schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOUT);
> +	schedule_delayed_work(&ring->adev->vcn.inst[0].idle_work, VCN_IDLE_TIMEOUT);
>   	mutex_unlock(&ring->adev->vcn.vcn1_jpeg1_workaround);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index e42cfc731ad8e..a51691c6d6110 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -313,7 +313,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>   
>   	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>   	    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index b9be304aa294b..6fb08ed093101 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -390,12 +390,12 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int i;
>   
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> -
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
>   
> +		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +
>   		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>   		    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
>   		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index a3627700ed48d..70a1b85a4efae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -422,12 +422,12 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int i;
>   
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> -
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
>   
> +		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +
>   		if (!amdgpu_sriov_vf(adev)) {
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>   				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index c3eb4278bf465..4a846c9a2b039 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -359,11 +359,12 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int i;
>   
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> -
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
> +
> +		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +
>   		if (!amdgpu_sriov_vf(adev)) {
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>   				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 6293d1dc02fec..8343cee899c71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -349,8 +349,10 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
>   static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	int i;
>   
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
>   
>   	if (adev->vcn.cur_state != AMD_PG_STATE_GATE)
>   		vcn_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index bf0da0da12512..e784f1457ee0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -300,11 +300,12 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int i;
>   
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> -
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
> +
> +		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +
>   		if (!amdgpu_sriov_vf(adev)) {
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>   				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 6b777ed01d445..03c7252e28ba9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -280,11 +280,12 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int i;
>   
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> -
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
> +
> +		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +
>   		if (!amdgpu_sriov_vf(adev)) {
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>   				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index 25abb303d6698..5950ec4c7f6db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -206,8 +206,10 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
>   static int vcn_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	int i;
>   
> -	cancel_delayed_work_sync(&adev->vcn.idle_work);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
>   
>   	return 0;
>   }
--------------nQmkx8z2LLEBzdZx9Gf4HbiX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-31 11:57, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250131165741.1798488-9-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Have a separate work handler for each VCN instance. This
paves the way for per instance VCN power gating at runtime.

v2: index instances directly on vcn1.0 and 2.0 to make
it clear that they only support a single instance (Lijo)

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="mark1tk8wrane" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-9-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 84 +++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  8 ++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 17 ++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  5 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c |  4 +-
 12 files changed, 80 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 83faf6e6788a2..0c3081a198d9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -100,6 +100,9 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev)
 
 	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
 	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		adev-&gt;vcn.inst[i].adev = adev;
+		adev-&gt;vcn.inst[i].inst = i;
+
 		if (i == 1 &amp;&amp; amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
 			r = amdgpu_ucode_request(adev, &amp;adev-&gt;vcn.inst[i].fw,
 						 AMDGPU_UCODE_REQUIRED,
@@ -124,12 +127,13 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	unsigned int fw_shared_size, log_offset;
 	int i, r;
 
-	INIT_DELAYED_WORK(&amp;adev-&gt;vcn.idle_work, amdgpu_vcn_idle_work_handler);
-	mutex_init(&amp;adev-&gt;vcn.vcn_pg_lock);
 	mutex_init(&amp;adev-&gt;vcn.vcn1_jpeg1_workaround);
-	atomic_set(&amp;adev-&gt;vcn.total_submission_cnt, 0);
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++)
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+		mutex_init(&amp;adev-&gt;vcn.inst[i].vcn_pg_lock);
+		atomic_set(&amp;adev-&gt;vcn.inst[i].total_submission_cnt, 0);
+		INIT_DELAYED_WORK(&amp;adev-&gt;vcn.inst[i].idle_work, amdgpu_vcn_idle_work_handler);
 		atomic_set(&amp;adev-&gt;vcn.inst[i].dpg_enc_submission_cnt, 0);
+	}
 
 	if ((adev-&gt;firmware.load_type == AMDGPU_FW_LOAD_PSP) &amp;&amp;
 	    (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG))
@@ -277,10 +281,10 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 			amdgpu_ring_fini(&amp;adev-&gt;vcn.inst[j].ring_enc[i]);
 
 		amdgpu_ucode_release(&amp;adev-&gt;vcn.inst[j].fw);
+		mutex_destroy(&amp;adev-&gt;vcn.inst[j].vcn_pg_lock);
 	}
 
 	mutex_destroy(&amp;adev-&gt;vcn.vcn1_jpeg1_workaround);
-	mutex_destroy(&amp;adev-&gt;vcn.vcn_pg_lock);
 
 	return 0;
 }
@@ -331,8 +335,10 @@ int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev)
 int amdgpu_vcn_suspend(struct amdgpu_device *adev)
 {
 	bool in_ras_intr = amdgpu_ras_intr_triggered();
+	int i;
 
-	cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i)
+		cancel_delayed_work_sync(&amp;adev-&gt;vcn.inst[i].idle_work);
 
 	/* err_event_athub will corrupt VCPU buffer, so we need to
 	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
@@ -388,46 +394,45 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
 
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 {
-	struct amdgpu_device *adev =
-		container_of(work, struct amdgpu_device, vcn.idle_work.work);
+	struct amdgpu_vcn_inst *vcn_inst =
+		container_of(work, struct amdgpu_vcn_inst, idle_work.work);
+	struct amdgpu_device *adev = vcn_inst-&gt;adev;
 	unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
-	unsigned int i, j;
+	unsigned int i = vcn_inst-&gt;inst, j;
 	int r = 0;
 
-	for (j = 0; j &lt; adev-&gt;vcn.num_vcn_inst; ++j) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; j))
-			continue;
-
-		for (i = 0; i &lt; adev-&gt;vcn.num_enc_rings; ++i)
-			fence[j] += amdgpu_fence_count_emitted(&amp;adev-&gt;vcn.inst[j].ring_enc[i]);
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
+		return;
 
-		/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
-		if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG &amp;&amp;
-		    !adev-&gt;vcn.using_unified_queue) {
-			struct dpg_pause_state new_state;
+	for (j = 0; j &lt; adev-&gt;vcn.num_enc_rings; ++j)
+		fence[i] += amdgpu_fence_count_emitted(&amp;vcn_inst-&gt;ring_enc[j]);
 
-			if (fence[j] ||
-				unlikely(atomic_read(&amp;adev-&gt;vcn.inst[j].dpg_enc_submission_cnt)))
-				new_state.fw_based = VCN_DPG_STATE__PAUSE;
-			else
-				new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
+	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
+	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG &amp;&amp;
+	    !adev-&gt;vcn.using_unified_queue) {
+		struct dpg_pause_state new_state;
 
-			adev-&gt;vcn.pause_dpg_mode(adev, j, &amp;new_state);
-		}
+		if (fence[i] ||
+		    unlikely(atomic_read(&amp;vcn_inst-&gt;dpg_enc_submission_cnt)))
+			new_state.fw_based = VCN_DPG_STATE__PAUSE;
+		else
+			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 
-		fence[j] += amdgpu_fence_count_emitted(&amp;adev-&gt;vcn.inst[j].ring_dec);
-		fences += fence[j];
+		adev-&gt;vcn.pause_dpg_mode(adev, i, &amp;new_state);
 	}
 
-	if (!fences &amp;&amp; !atomic_read(&amp;adev-&gt;vcn.total_submission_cnt)) {
+	fence[i] += amdgpu_fence_count_emitted(&amp;vcn_inst-&gt;ring_dec);
+	fences += fence[i];
+
+	if (!fences &amp;&amp; !atomic_read(&amp;vcn_inst-&gt;total_submission_cnt)) {
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-		       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE);
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
-				false);
+						    false);
 		if (r)
 			dev_warn(adev-&gt;dev, &quot;(%d) failed to disable video power profile mode\n&quot;, r);
 	} else {
-		schedule_delayed_work(&amp;adev-&gt;vcn.idle_work, VCN_IDLE_TIMEOUT);
+		schedule_delayed_work(&amp;vcn_inst-&gt;idle_work, VCN_IDLE_TIMEOUT);
 	}
 }
 
@@ -436,18 +441,18 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring-&gt;adev;
 	int r = 0;
 
-	atomic_inc(&amp;adev-&gt;vcn.total_submission_cnt);
+	atomic_inc(&amp;adev-&gt;vcn.inst[ring-&gt;me].total_submission_cnt);
 
-	if (!cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work)) {
+	if (!cancel_delayed_work_sync(&amp;adev-&gt;vcn.inst[ring-&gt;me].idle_work)) {
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 				true);
 		if (r)
 			dev_warn(adev-&gt;dev, &quot;(%d) failed to switch to video power profile mode\n&quot;, r);
 	}
 
-	mutex_lock(&amp;adev-&gt;vcn.vcn_pg_lock);
+	mutex_lock(&amp;adev-&gt;vcn.inst[ring-&gt;me].vcn_pg_lock);
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-	       AMD_PG_STATE_UNGATE);
+					       AMD_PG_STATE_UNGATE);
 
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG &amp;&amp;
@@ -472,7 +477,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 
 		adev-&gt;vcn.pause_dpg_mode(adev, ring-&gt;me, &amp;new_state);
 	}
-	mutex_unlock(&amp;adev-&gt;vcn.vcn_pg_lock);
+	mutex_unlock(&amp;adev-&gt;vcn.inst[ring-&gt;me].vcn_pg_lock);
 }
 
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
@@ -485,9 +490,10 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
 	    !adev-&gt;vcn.using_unified_queue)
 		atomic_dec(&amp;ring-&gt;adev-&gt;vcn.inst[ring-&gt;me].dpg_enc_submission_cnt);
 
-	atomic_dec(&amp;ring-&gt;adev-&gt;vcn.total_submission_cnt);
+	atomic_dec(&amp;ring-&gt;adev-&gt;vcn.inst[ring-&gt;me].total_submission_cnt);
 
-	schedule_delayed_work(&amp;ring-&gt;adev-&gt;vcn.idle_work, VCN_IDLE_TIMEOUT);
+	schedule_delayed_work(&amp;ring-&gt;adev-&gt;vcn.inst[ring-&gt;me].idle_work,
+			      VCN_IDLE_TIMEOUT);
 }
 
 int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index c92f683ee5958..f1685283c2f13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -295,6 +295,8 @@ struct amdgpu_vcn_fw_shared {
 };
 
 struct amdgpu_vcn_inst {
+	struct amdgpu_device	*adev;
+	int			inst;
 	struct amdgpu_bo	*vcpu_bo;
 	void			*cpu_addr;
 	uint64_t		gpu_addr;
@@ -316,6 +318,9 @@ struct amdgpu_vcn_inst {
 	const struct firmware	*fw; /* VCN firmware */
 	uint8_t			vcn_config;
 	uint32_t		vcn_codec_disable_mask;
+	atomic_t		total_submission_cnt;
+	struct mutex		vcn_pg_lock;
+	struct delayed_work	idle_work;
 };
 
 struct amdgpu_vcn_ras {
@@ -324,7 +329,6 @@ struct amdgpu_vcn_ras {
 
 struct amdgpu_vcn {
 	unsigned		fw_version;
-	struct delayed_work	idle_work;
 	unsigned		num_enc_rings;
 	enum amd_powergating_state cur_state;
 	bool			indirect_sram;
@@ -332,9 +336,7 @@ struct amdgpu_vcn {
 	uint8_t	num_vcn_inst;
 	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
 	struct amdgpu_vcn_reg	 internal;
-	struct mutex		 vcn_pg_lock;
 	struct mutex		vcn1_jpeg1_workaround;
-	atomic_t		 total_submission_cnt;
 
 	unsigned	harvest_config;
 	int (*pause_dpg_mode)(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index 03b8b7cd5229b..8031406e20ff9 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -604,7 +604,7 @@ static void jpeg_v1_0_set_irq_funcs(struct amdgpu_device *adev)
 static void jpeg_v1_0_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct	amdgpu_device *adev = ring-&gt;adev;
-	bool	set_clocks = !cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);
+	bool	set_clocks = !cancel_delayed_work_sync(&amp;adev-&gt;vcn.inst[0].idle_work);
 	int		cnt = 0;
 
 	mutex_lock(&amp;adev-&gt;vcn.vcn1_jpeg1_workaround);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 5ea96c9835170..b90d41cd001c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -150,7 +150,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	/* Override the work func */
-	adev-&gt;vcn.idle_work.work.func = vcn_v1_0_idle_work_handler;
+	adev-&gt;vcn.inst[0].idle_work.work.func = vcn_v1_0_idle_work_handler;
 
 	amdgpu_vcn_setup_ucode(adev);
 
@@ -277,7 +277,7 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 
-	cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);
+	cancel_delayed_work_sync(&amp;adev-&gt;vcn.inst[0].idle_work);
 
 	if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ||
 		(adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE &amp;&amp;
@@ -301,7 +301,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 	bool idle_work_unexecuted;
 
-	idle_work_unexecuted = cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);
+	idle_work_unexecuted = cancel_delayed_work_sync(&amp;adev-&gt;vcn.inst[0].idle_work);
 	if (idle_work_unexecuted) {
 		if (adev-&gt;pm.dpm_enabled)
 			amdgpu_dpm_enable_vcn(adev, false, 0);
@@ -1828,8 +1828,9 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 
 static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 {
-	struct amdgpu_device *adev =
-		container_of(work, struct amdgpu_device, vcn.idle_work.work);
+	struct amdgpu_vcn_inst *vcn_inst =
+		container_of(work, struct amdgpu_vcn_inst, idle_work.work);
+	struct amdgpu_device *adev = vcn_inst-&gt;adev;
 	unsigned int fences = 0, i;
 
 	for (i = 0; i &lt; adev-&gt;vcn.num_enc_rings; ++i)
@@ -1862,14 +1863,14 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 			       AMD_PG_STATE_GATE);
 	} else {
-		schedule_delayed_work(&amp;adev-&gt;vcn.idle_work, VCN_IDLE_TIMEOUT);
+		schedule_delayed_work(&amp;adev-&gt;vcn.inst[0].idle_work, VCN_IDLE_TIMEOUT);
 	}
 }
 
 static void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring)
 {
 	struct	amdgpu_device *adev = ring-&gt;adev;
-	bool set_clocks = !cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);
+	bool set_clocks = !cancel_delayed_work_sync(&amp;adev-&gt;vcn.inst[0].idle_work);
 
 	mutex_lock(&amp;adev-&gt;vcn.vcn1_jpeg1_workaround);
 
@@ -1921,7 +1922,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
 
 void vcn_v1_0_ring_end_use(struct amdgpu_ring *ring)
 {
-	schedule_delayed_work(&amp;ring-&gt;adev-&gt;vcn.idle_work, VCN_IDLE_TIMEOUT);
+	schedule_delayed_work(&amp;ring-&gt;adev-&gt;vcn.inst[0].idle_work, VCN_IDLE_TIMEOUT);
 	mutex_unlock(&amp;ring-&gt;adev-&gt;vcn.vcn1_jpeg1_workaround);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index e42cfc731ad8e..a51691c6d6110 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -313,7 +313,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 
-	cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);
+	cancel_delayed_work_sync(&amp;adev-&gt;vcn.inst[0].idle_work);
 
 	if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ||
 	    (adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE &amp;&amp;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index b9be304aa294b..6fb08ed093101 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -390,12 +390,12 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int i;
 
-	cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);
-
 	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
 		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
 			continue;
 
+		cancel_delayed_work_sync(&amp;adev-&gt;vcn.inst[i].idle_work);
+
 		if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ||
 		    (adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE &amp;&amp;
 		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index a3627700ed48d..70a1b85a4efae 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -422,12 +422,12 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int i;
 
-	cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);
-
 	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
 		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
 			continue;
 
+		cancel_delayed_work_sync(&amp;adev-&gt;vcn.inst[i].idle_work);
+
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ||
 				(adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE &amp;&amp;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index c3eb4278bf465..4a846c9a2b039 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -359,11 +359,12 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int i;
 
-	cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);
-
 	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
 		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
 			continue;
+
+		cancel_delayed_work_sync(&amp;adev-&gt;vcn.inst[i].idle_work);
+
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ||
 				(adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE &amp;&amp;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 6293d1dc02fec..8343cee899c71 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -349,8 +349,10 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int i;
 
-	cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i)
+		cancel_delayed_work_sync(&amp;adev-&gt;vcn.inst[i].idle_work);
 
 	if (adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE)
 		vcn_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index bf0da0da12512..e784f1457ee0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -300,11 +300,12 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int i;
 
-	cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);
-
 	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
 		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
 			continue;
+
+		cancel_delayed_work_sync(&amp;adev-&gt;vcn.inst[i].idle_work);
+
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ||
 				(adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE &amp;&amp;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 6b777ed01d445..03c7252e28ba9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -280,11 +280,12 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int i;
 
-	cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);
-
 	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
 		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
 			continue;
+
+		cancel_delayed_work_sync(&amp;adev-&gt;vcn.inst[i].idle_work);
+
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ||
 				(adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE &amp;&amp;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 25abb303d6698..5950ec4c7f6db 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -206,8 +206,10 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 static int vcn_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int i;
 
-	cancel_delayed_work_sync(&amp;adev-&gt;vcn.idle_work);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i)
+		cancel_delayed_work_sync(&amp;adev-&gt;vcn.inst[i].idle_work);
 
 	return 0;
 }
</pre>
    </blockquote>
  </body>
</html>

--------------nQmkx8z2LLEBzdZx9Gf4HbiX--
