Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0AAE77180
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 20:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BB9510E035;
	Tue, 10 Dec 2024 20:22:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="neoOcPf6";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03C3010E035
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 20:22:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXthkNva3R6ADwg4Nl5XehZl5tIR38U5kJ/CQ8KG+FZH/IJFcgeZU3Ymwm5Po3fPQ6SBmNWAzvhO8w0cc7KDgJpWkHp5OjirAW1DBpzDToH2MOHCNlv2MCvpuAKLaD7bl+hVfIKG7C58henNpAzwiulCD8a6w0JZ9xHOakObrKLfy95eN273waXaXXQHjdwHkUJfigmt8t3Pz5xDxgiER7adKmZlAwPdeBEKGj28heb3PslUyuIvHlljbNbGAUr//3yIjtqKOnP+QcAEZsrRzgVizEhbM8PuafjUJLrXdy3KQh4jz2lYi0GHqdTvdzlME3KOFH0+WG7MMSP7nxvIDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+tcT92W2BT1oI9AYpbZ/3gYWpTMyY45w5LdT9iiZWk=;
 b=Nq4NVsT2zIFozsf6pRogA0PDkIPt1rjT+fp5dtLrr9iRnriAWZSGKAP8TJOuI5Kvwq4O4M1ykD6qhqIs9cYnVgit3hhnRiMJvkuyV3xbbUHlXJ/sYYRvIIahWWqkDuM4CvSBITeoDCBOJdnMccUSmc+Ty7MydS3wIO9g+Wfzt2AsXIkAzKqGmfMQFXJzobGamIGm+YLUgN43LppaVeq8M7SFJvGNW4yyEpO5r6oJcoa4SxUynWtDehGyRx0dHnTj1gDsLXxL4bn6Y5rRmTjms7YHiBziTcov1lWk3dbNQChiA+MlPo4NIvpWzhb3XIA6dtL4S2/YObl7QA68TLPUWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+tcT92W2BT1oI9AYpbZ/3gYWpTMyY45w5LdT9iiZWk=;
 b=neoOcPf6r3HCIHlqgccysZnMdISj7ReW8G/a+lkoPWreN+OE3dVSnAQaqW2sbtpf7ZR+irUugWzQt7dNJeON72MGP6C9Womnc0Io5xEy35fRKC0Tet0hjL9vbzL2ECugNbPH0PjC5elEa6yhTFkLWQdIfzchVu+KQt6KHv9DF8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by MW4PR12MB7358.namprd12.prod.outlook.com (2603:10b6:303:22b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Tue, 10 Dec
 2024 20:22:52 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%7]) with mapi id 15.20.8207.010; Tue, 10 Dec 2024
 20:22:51 +0000
Content-Type: multipart/alternative;
 boundary="------------mmn4K3qZSEvGD6ga8yQXBGY8"
Message-ID: <fc027d47-b216-47b2-94bf-435acb973be2@amd.com>
Date: Tue, 10 Dec 2024 15:22:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: add sysfs reset mask for vcn 5.0.1
To: amd-gfx@lists.freedesktop.org
References: <20241210200352.3465587-1-alexander.deucher@amd.com>
 <20241210200352.3465587-2-alexander.deucher@amd.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <20241210200352.3465587-2-alexander.deucher@amd.com>
X-ClientProxiedBy: YQBPR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::40)
 To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|MW4PR12MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a764e0-9320-4ba3-e584-08dd19586bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUZWMG0xa051TmpuSW1BYWVwMVV4ZENMeXo4OHdEMmdHWVNEb2RnUU9CczA0?=
 =?utf-8?B?dVc5WVU3WGUvRGdoMjZTbGpHTWxUajhveFY0WG1ONjNIaW1pK05iZkU4TS9N?=
 =?utf-8?B?R0kxcEpVTFRPWkk5eG9OZ2dHa2dUMjBPektGVWh0QlMzeGhoVnN5US9VU0Fy?=
 =?utf-8?B?NFI1NTNmSGU5TkIwODRiTXAvQkFCZHVNUU8vUHpud2p3aDVwYlcvUkFXcEt3?=
 =?utf-8?B?dWJWY21lN0NXYkhQM1lpR0p5a3pNU1dESWtiWFd4NW9qYVQ4clpzSmM1eG1J?=
 =?utf-8?B?TkFHSU9qM1lCdHFmY01yVWQvUEhYdGpORjBkZGI1VUgvUnRBNzJ4ajl5eU1W?=
 =?utf-8?B?a2JtSFpTMWJWanAwNFBMRHo4QTduaXp4RThrMWt3anJHVDJNZmttd1JIUzQ3?=
 =?utf-8?B?WlNHdlppbEh2ZVAzVzcyQ3d0YmkwaGd3UFdWQXVjOGVYVXdEZlU2cDFmLzZP?=
 =?utf-8?B?TDYrM0JxWGVUL3lTQzlEKytXY0p6Q3FYQUdMVzRhNFovejBpSnhlWDRBQ2dv?=
 =?utf-8?B?Y2ptcGxDSUVhMlJ3RkxjOVhQMWUyNnByb1RPVzBhU1cwaWlwY1RVVTRhUzlZ?=
 =?utf-8?B?NHdyOWhFK09lUUdGdkw0Y1poQ3dKd2Rza2YwK2RVNGt0MExzZGE2dWorQ1E5?=
 =?utf-8?B?d1c1ZCtEWWNxVWp3djJRMHBlVzFneXF2b1NWSFNWL2gzZlFKZnR6SC9ha1NN?=
 =?utf-8?B?dHkzWFI3UnpYaHhVL2JLcXMrMlZWdWRjMEZ4aEF0cTQ5ZGk3T2xZRzBRT01B?=
 =?utf-8?B?M1pEZUs4SkV2anE3U3RraEI0Z1FITFEzWndicVo2YStENVZWbGV0QjNuRHlq?=
 =?utf-8?B?V1NvRDZzUnJ0MTE0T0JaSjFXNTVMRHpwNUM5b1NqaXBPcE1zbXNEQ1pRV1Nu?=
 =?utf-8?B?b0ErZXlMOTZ2c1J0WmhmYkQ5ZkZjWWZxdGpYUnpCMnZqekFsdnQwKzM5TnZx?=
 =?utf-8?B?NVhkMUxYKzJkRUprRDY2eHVWeE9iSTM2OGVmdUpKUEFtbFBGdTgrRDZ1RFZa?=
 =?utf-8?B?RWhCUlh1RnJvbEhJV1YwdjhUbVpXVE9Yak1VRTVOQjZSb1ArcmRjMnVucThH?=
 =?utf-8?B?eXRKVUZpZG5Zam1hcWNvRzk0RW9Yc3lzQ0IwSDY4Q0UyVDdnUGZ2ZDBwQnhT?=
 =?utf-8?B?WlBka2syWmNkSjlyQzZwZnpvNC8wQnQ1L3VxbFRMcld6a29UNlpnM2JKVGpC?=
 =?utf-8?B?RDc5YVk4WUpwNCtQUUVxUXAvS2FvU2g2Q2MxaVVmNnVUN0V5OUliak5mUEh4?=
 =?utf-8?B?OG1QcDRCaHJISUM5M3BYZVJST2VFd1VMMHp2OHFJVEMrc3MzQ1F1SUdSTCs2?=
 =?utf-8?B?cXJJWUNUVFd5NC9NbGhxNjFucW54OS9YVjZUNmthc3BTVFZjYlBLRUJacHB1?=
 =?utf-8?B?bVhuZDJaL3RQS3VmTHVwZjN6UDhEelBlcTVLQmZlZ2lnWnhmMGlza0RsOE9n?=
 =?utf-8?B?WFJzU0Zneko5NHNVTk5ZR21FVWZzQ2NCV2pBTGVNTk8wUkd2YzFhRWVPMGY2?=
 =?utf-8?B?UnFENDJINlVOYkY3aUJTNzRydFUzVTJ2OUk3N2F3Z2FzcnBqczdMVElMK2Fz?=
 =?utf-8?B?RlEydndmQWJ2MXhuZFozTmFzYUphL0dBK1V0S1FkNHRoM3Jkc3JxNUdZOHlY?=
 =?utf-8?B?WDUyTHhDQkJ4bHFiNm9TS0VqNHc5YXNra2ptUTVDY1FVajhHTDN5Rm15dG90?=
 =?utf-8?B?ZWZVa1ZsRmMva1BpYktxTWpyS0hMb1hUUXBaRmxNSUxNbHpyMFpIRjlkTlY2?=
 =?utf-8?B?dm9CV2xUUU43NW5yZGtYVFNtMlBYdkJtSFJoQ3lWM0JYVnFLOUJWcnN4aTVR?=
 =?utf-8?B?NkNFZjR3T1FYM3RPeHAwZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHQ2aXBVcm9USGJZOXdKUyt5NEZ3UzlBeXZvRmxZeldHUXJsMWQxZ3R2KzRw?=
 =?utf-8?B?ZDdYQ2ZXa2ZpdzZqNFo1eFdITGRLNGVaZHZtWTZGT1BUa3JZNkpqQ28rT3A2?=
 =?utf-8?B?TXB5QlBQYkZRYlZCV2NGdC9BQ1Q1UWU3aW5sa1hCS0NvM1dnRDFIOE1xWm1u?=
 =?utf-8?B?bG5iUkNBMVNMN3BSMzRpNmhlZGpPWldoT0lFNWpGREVOK3hsM0dnL3VHNVdW?=
 =?utf-8?B?bko0dERHbS9uMlBWM1JwSDRFNnc2NVQwZW45UUFjNmNIanRjaU1hSWtvVVRo?=
 =?utf-8?B?TEQrL2VwQ256cHBhN2ZQWGlycDBFbXd5NUp4ckJrNEMwNEkxZzFhV0d4cnYv?=
 =?utf-8?B?Wk1vK1BKY21NbU1jdW05bGx5bk9HR2l5TjFpamxGR2hlazYyVk1HRnhnZWpl?=
 =?utf-8?B?VjMzSWt5aHNTQ000Q1FDNVN3elF6aThkSHMrYUdBd2kzb3lpZ2RKNHZNbEVq?=
 =?utf-8?B?cVA5MDc2TThzcUppNVFMcGR2Z3lTM3VLTXlZZWxXOGt0WGZiTHFhQTd4MTNl?=
 =?utf-8?B?QVc3VTZZYTBsY01oMkdZZHFnaWVwL1RZVWVqTlVJZDBWRXoxUlA4SEFxVzRs?=
 =?utf-8?B?WTlLbHk4WE5qUTBsUVp4N2dRVDFGajdzQkh6aEFBREpQTFZDc1lINGRJc25j?=
 =?utf-8?B?dmp5ek1nME9DcVU3Mnc2SU56ZFowL0lubjBPT2FnWHQraitFZ0NNVDFjUkM0?=
 =?utf-8?B?cHhHRkJiREl3TE0wREgyeU5jU2hwcC9KNVZLTUlranIvZTUzY3B5V3d1K3Jx?=
 =?utf-8?B?OUVFQXBrZ3dERjk0dlNEdWdscDBzSlhLdHllYmFRdnVub0o0dXl0VHJ6SitV?=
 =?utf-8?B?bDY5SnlSZXFBVFZVcTBham9jakc4cDRxNk0yQk43ZFdZNlZMUkRWT1NlK1ZC?=
 =?utf-8?B?cW8yQ3RSUDVLQUExYzRzQnJaR09yeGd6YVoveTZxemRRdXhQNVNLQ2hPeEUw?=
 =?utf-8?B?My9Mdm55MzB0VmdzNW5peDFieTNQSEduUVg1Nm05L2d3a1BBYytxU3hMVG5U?=
 =?utf-8?B?SlpZcUpsQitJdXQwOHBUK0o1RzkzMW5uZWREQUc3QVVsWlNmS0oyRzBsNnNt?=
 =?utf-8?B?THdILy9rekVLRTZYd0txV1Z2VnJoSnhKSGNkeGdKdjZBaGc5ZlJtOHhMRGdY?=
 =?utf-8?B?ejExVlRUZmVhcURTU2ovOTlIOVdHZS9TQlAwTnd1SVUvZXgyUmltajJoTURh?=
 =?utf-8?B?cklWaUlsd2RiUjRhQ2dLLzBHLzBRcGRXQkplZVhhL3hRU1NSNm43RERGVmxq?=
 =?utf-8?B?RkpLZzRGVEkwaGZnMkFKa3RPUHhGVlU2U3lnQnl4SXl5NThlRE9EL2JNTE9K?=
 =?utf-8?B?QW8rTEN6SnQxRVlqdUkyVDVkRDRLazA2MXhXSnZpZkdVUDJYQ3FwYzNsMXRH?=
 =?utf-8?B?bFIxZG1CTWxBK0hRN3lIbzdqcy9Db1UvU1o5ZlEzSzJIMzlOMWk1K1JKejZI?=
 =?utf-8?B?enlST2dJZWdweDVBeWgvQU01VGhBK3RPeEpLK2k0bGk4dEdBSC8vMXFwbXRO?=
 =?utf-8?B?MUN3QjF5Q3RIandyR0RaZHdtRmFDeCszcWF2b0F2U1QycGNhUlBycEpqKzYv?=
 =?utf-8?B?enNDSVZWSG5OSU1LWU1OUVcyalBJYkdWRWgxSUJYTWFjUVJ1M3J3LzBzTkFz?=
 =?utf-8?B?YzdJb2l6cE50SnplWkZkUG1IWjA2L01aMzBkckVVNDFMQXZadkNjNFZmcG9n?=
 =?utf-8?B?dldNRlI5MVRhQVk4dFlhVFhicFpqbnNDekovd3YxcHBpUlBCTDhBUnpqcFdi?=
 =?utf-8?B?WFJYdWpJTzJrRFpub1JxU0RKNmw0dmZqYmFPSFJHYTUrL0xxWWliejcxeThj?=
 =?utf-8?B?OVgwL0tNRzlEVHJNVFlrV3VZRllab1hZSlJuTmRUcXY4UFIzeENMS3JCWU5m?=
 =?utf-8?B?QWhZZ0lOWHNqRThaK29RWGVPSDJNTENhL3RUaXl3R2g4UzRSMmlsYzVDY3pP?=
 =?utf-8?B?N3lnNSt5eVFjOWxuaTJNbDRjcytIZkRJeTlzdnh4M1JhelRNV2Z1dVMvYVpj?=
 =?utf-8?B?dXdidkR3YmVLWnpzeW0xbjNUSStqM21nUEJCa25KMklodW5neDBRVlY2eU5G?=
 =?utf-8?B?dEdsdGM2ZUZpa1ZCRzFrTEtaeC81bVc5UVFmc3ljWTY4RUdtMWtEWTh0dFFV?=
 =?utf-8?Q?gQVJ9yaid86A0OYN6CuXlGjRm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a764e0-9320-4ba3-e584-08dd19586bf3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 20:22:51.7729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FAmNXjzhjmHF7gppve58Rd3giGYXccy//ffhnDmh56MycTJQWrFlX35GypKregyjlkqYzMqWOC1bFPIBL9/Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7358
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

--------------mmn4K3qZSEvGD6ga8yQXBGY8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Series is:
Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>

one thing I would like to do:
return amdgpu_vcn_sysfs_reset_mask_init(adev);

On 2024-12-10 15:03, Alex Deucher wrote:
> Add the calls to the vcn 5.0.1 code.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index a076ffb3867ac..8a50dcd64e6eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -119,8 +119,16 @@ static int vcn_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
>   			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
>   	}
>   
> +	/* TODO: Add queue reset mask when FW fully supports it */
> +	adev->vcn.supported_reset =
> +		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
> +
>   	vcn_v5_0_0_alloc_ip_dump(adev);
>   
> +	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
> +	if (r)
> +		return r;
> +
>   	return 0;
>   }
>   
> @@ -154,6 +162,8 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
>   
>   	r = amdgpu_vcn_sw_fini(adev);
>   
> +	amdgpu_vcn_sysfs_reset_mask_fini(adev);
> +
>   	kfree(adev->vcn.ip_dump);
>   
>   	return r;
--------------mmn4K3qZSEvGD6ga8yQXBGY8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      Series is:</div>
    <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
      Reviewed-by: David (Ming Qiang) Wu <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a></div>
    <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"><br>
    </div>
    <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">one
      thing I would like to do:<br>
    </div>
    <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">&nbsp;&nbsp;&nbsp;
      return <span style="white-space: pre-wrap">amdgpu_vcn_sysfs_reset_mask_init(adev);</span>
    </div>
    <p></p>
    <div class="moz-cite-prefix">On 2024-12-10 15:03, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241210200352.3465587-2-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Add the calls to the vcn 5.0.1 code.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index a076ffb3867ac..8a50dcd64e6eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -119,8 +119,16 @@ static int vcn_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 			amdgpu_vcn_fwlog_init(&amp;adev-&gt;vcn.inst[i]);
 	}
 
+	/* TODO: Add queue reset mask when FW fully supports it */
+	adev-&gt;vcn.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&amp;adev-&gt;vcn.inst[0].ring_enc[0]);
+
 	vcn_v5_0_0_alloc_ip_dump(adev);
 
+	r = amdgpu_vcn_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -154,6 +162,8 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_vcn_sw_fini(adev);
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
+
 	kfree(adev-&gt;vcn.ip_dump);
 
 	return r;
</pre>
    </blockquote>
  </body>
</html>

--------------mmn4K3qZSEvGD6ga8yQXBGY8--
