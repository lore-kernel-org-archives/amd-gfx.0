Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC747CCF9E7
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 19:21:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48DEA10E010;
	Wed, 25 Sep 2024 19:21:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vJXNg4tS";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A443D10E010
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 19:21:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7Lliu4Jk5a2Xma8x5QC1/arzxMB2bDqHmR37cQxtzGPNN05UJGKVqNQrBUdBM8iGCh2UvEWV6q0zDzJagXPPobqm5+BqhToUhGXBrqcIrkfI3BXnfBHFahm4maeQ62pJSgeigwJVK9u00Dxe0jblNH9bSFQipwlLu+VwW65GwfiAFddbniTHK4Tuur/3P8oHqbQpUYJwlHSiYUgz0fR3/CWqTS+aE59DGUE78S3ctC2F9q8CTHtc75VKuAdwKSk7LChI1bkLIX3FlyDQRWda937rmMtIxRhTmQJQCVZyN8zs3oW3uYgKxXKqkDWETO+GPTvdJymhm793iV5ivxFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J80dtpEDQ7nUNwWrdN+QgLbSMogsV6IEvghsPmQ3G98=;
 b=nFiJsWYj6sQHsEoIOTlsVPzB5ul1SmVSzSj6sijHF4ig/uULDnhS14Nam+PUk/p9uRkk6TFHJ8i1TLYKbxayp/GHIoT8UlWxh5leyfXn1gClyx9heO5G/egGOi6dnkTTKKQYTUinA5AA2HMyA0bZW9oPDrigFuJzfMmVwqREbV6OjdWsaRtdZkVR3W+lizd6Ft83ynD6NHQ+m8Phy0cwwRVTCgi+Vz9bs4dPXrp1gtC6C0nf5K+b3wmyh2d3ky/Zd5Y2QQZM+0h3jWVXjYoZPO4bK8WfqfIPrLGFa3+YCRGnMUljXbQgwGFuj02RmAC6alhUDOtja2RQdyrUW/hGtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J80dtpEDQ7nUNwWrdN+QgLbSMogsV6IEvghsPmQ3G98=;
 b=vJXNg4tSvnnbijHtfJA4F1kTc7kw8wIlQPSvUsqitWqbasvi8vvV5vLVZrZ5QzE6QLAjcyindTzyQw8H2uPGSkLdspOrIUoleq87yzO2q4sgfnopABetH5T3t6djaXaJ21+h8paaiCmTI1qC075ueAkCDAzxKSD0eM9yCj3gRwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Wed, 25 Sep
 2024 19:20:56 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 19:20:56 +0000
Message-ID: <e5cf5dfa-80fe-4d4c-bab0-0117e7a1b47b@amd.com>
Date: Wed, 25 Sep 2024 15:20:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix vm-pasid lookup for multiple partitions
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philip Yang <yangp@amd.com>, "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 "Kim, Jonathan" <Jonathan.Kim@amd.com>, "Yang, Philip"
 <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Joshi, Mukul" <Mukul.Joshi@amd.com>
References: <20240819175935.4014241-1-Jonathan.Kim@amd.com>
 <0de27442-9271-44ad-9e99-0c719836bad8@gmail.com>
 <CY8PR12MB7435D74AA7571BCFF433369F85992@CY8PR12MB7435.namprd12.prod.outlook.com>
 <5c26a4aa-d18d-4e36-98a9-b915644cb853@amd.com>
 <ca0aa805-afca-1758-cf6f-718111f87cd6@amd.com>
 <CY8PR12MB743552BE87CE07964CC89558859A2@CY8PR12MB7435.namprd12.prod.outlook.com>
 <be8eb0ef-2368-47c2-b4bb-d24f8cb0165d@amd.com>
 <a0c252aa-e232-4d61-8dad-3782fe864ba5@amd.com>
 <2c6fe61b-d223-40a8-d8ba-974857676512@amd.com>
 <91fb0cc7-e363-409f-9188-0534407f91a4@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <91fb0cc7-e363-409f-9188-0534407f91a4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0164.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dcff27b-7b9e-4262-91b5-08dcdd972e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjZlZVExclgwMHZFYnlBRFQ1d3hjUEVJVkxZU0ZNWktOWGk3RHBmZDk2S3NK?=
 =?utf-8?B?UE1rNEc3d0NLMkYzQmVheGlzOW5paVV2c3Z1bWJQOWlhS0NVR1J5WGdNMlVz?=
 =?utf-8?B?dFpqRHNCWU0xcWQ5ZWNaaUV1THBUVVY1MlZTbUloam9hRzZKL2ZWcHlaZ0ZW?=
 =?utf-8?B?ZEtJMGtkZzNkZVIvQW10Vk8vN2FTOERJSmV0dWdhMzl1ZXhXR3JrNktLY2ZO?=
 =?utf-8?B?bThNTEQ2LzJHSS8vSDlJaEVzVVBJK3NlbzRHb2VtK2h0bXkrOCtENVI5eEw3?=
 =?utf-8?B?Q0VMSTJRcnorOENpNTZnb2gwUGFRaUlva1dQK3dnREo3YnZ0bEhQREsxZGZK?=
 =?utf-8?B?K1NvWFZWR0YxdVVwdXJWOGRoQ0lJeFRKZ3NoTW9oVkUwT2k3MjBzRVpkaGwr?=
 =?utf-8?B?cU9xQlQyTFgyeGR2NjJ4TDN1MTNSN3VDZ2NQQWphSEFISDAyU2ZpYUZCd05m?=
 =?utf-8?B?eHdYNGYyQy82QzEvUHBKdm1kRjZSc1N2ZGsxVE00TWNyc3NrWnFQa0NtWXFJ?=
 =?utf-8?B?aHBvaG8ydTVyOWE4TGlDenR1MVVRMjdJU2cvQUVpaHdhaXM0TnlIcXNZdkxV?=
 =?utf-8?B?N2VvS0JIT1BJYUh4aXNDa1hzUzBUUStRVE9kZFo3SGxQWExNTG5vRXNPb3k2?=
 =?utf-8?B?R3I0Y1F5cWZVMXJxVkg3S0IxUEtiaU1FK1ZsSm44MmxsakxsZiswV1VsVzlH?=
 =?utf-8?B?bHRQVWE3TlMwMHE3MmxJbjFXS1ZLV1dDOG93c3BWZjlKVy9LakE1MlZPc0p1?=
 =?utf-8?B?Z01hS0dIV2VtaFdYYnJaN3BQK2lNc0o3bnFwbWtmb3JTZlMrMEZLaDJYa3lH?=
 =?utf-8?B?bzgvNVRmdnhab3dQcWpRL2dveEJxOVZNcEZDNUxsZ3VXUk5JNWRxR0xxTjJM?=
 =?utf-8?B?d2lCbTNXbFhFUFRyWkNkL3hEc0N0eU1MWlNjdGpxMUFVb2FTeGg0Q21EdmhB?=
 =?utf-8?B?Tk1zdDN2K0Z3L3FYdGVXTnJFVEt2SldPOU5GZHAyUElCQWsydDZuekQ3M29R?=
 =?utf-8?B?dU0rRmp5V2djczJiUkNqWnlvZHRiMkVMQlB4ejNNK2NUdU8yb3Jxcmd6b3RT?=
 =?utf-8?B?cEhranlQVjBQWG9pOE9kZVJ3YzMxZ2M3akNERXc1RzFwMnlrRTE5SmFVMGN2?=
 =?utf-8?B?T0tuUGYzbFliWDJtODdLQ0dnSzdoTE1OdG1kdnZmbG9GU0srL01jMGxTTTVK?=
 =?utf-8?B?MlFVTzhEcWI2SkJ1aXBpYk04Z2ZHRzBrU294SjRORWdONTFCRGUrQW52YU5Y?=
 =?utf-8?B?QjFJb2REdW9FbGkvK3JKZHQxNEc3Nzc1SU9QeGVRcXpoQ3VDanV0VmNNWEJ0?=
 =?utf-8?B?TUZRVElNblJrQjdXVzc4L0ZUUm9Pc01GQXVYNXlBTzI5TktBSzUrMkxDd2ZM?=
 =?utf-8?B?d3RqTkVsd1ptMlVJUTZRS1Zmc2R3NnVKSmxubFp0UTVHOFgvekptNUhGckVN?=
 =?utf-8?B?L1RsYTJWMDFwM1RIbXRiRFBFQnF2YUpZeVAvMkRBdzlROE5IK2RJUU5mTUZY?=
 =?utf-8?B?Qk40NW1RN1RwUlFhWU83TUhPOEV2L3NtWmdPenlMTHl1SHp2TGpnK3J1cDNS?=
 =?utf-8?B?SEJPTTNwZkJsM1hMaTdCekIvbmZPd1FDdTVWblhtQ1ZPYUk1a1VrMjh5ektK?=
 =?utf-8?B?YlpCeXJGZFFKekZaaUZMVVJNMjZSNG9mVDRkNWs4RXBHZnRrUi9RNDB6VHU4?=
 =?utf-8?B?WFVNY2lpVGsxNWtyTFFwbVBRb2p3dkJRZHU4WmFOM1JrSmRGUHNzSXFRUGYw?=
 =?utf-8?B?V0FuM3p5TW1oN1F4YXIvSzdCaHVOU0JLRjB3LzQ2M3hHblFiWlI0d3d1cVhN?=
 =?utf-8?B?c29ORU4rNjFPbXRzak1Ydz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVArMFB4eGhCaXgrZkp1djh0MmUrV1lWb1dhZVFRMlI5bUw0RXJZMnEyMGhr?=
 =?utf-8?B?QWtmdDhReTd2TTVia2RQYWRSMm5HNmJrOXhkZGl6cDFQOG8xZS8ySUErVEM0?=
 =?utf-8?B?ZDU5Z1FxSkJvbkJRZ1kyTlJxaFZCcGk1dmZYTHpmOFoxUHEzVVd2UVM3bEpp?=
 =?utf-8?B?QWlvUjZuZXh5UUhxRFhBSThwR1FycmpTYjBrUnFuNkZ1d2JDWGVGQXZEVmFp?=
 =?utf-8?B?MmNadUVIZE80QjdGaFBxZWk4cHcvNCsvaHFkc2JGZ0xtMlZvaU5wUTVSTTRi?=
 =?utf-8?B?Y3NIQnJMSWxBTHNrcmpkeUJtem0zOUVYenJGYzFGYlZxU3NIbmQvMTZ3OEQr?=
 =?utf-8?B?NzlMU2tURGtwL3RhRHBZeThZVkV3UVZCVnA3dC81c3lVWlhTc1A2MURrSjBD?=
 =?utf-8?B?RDdERnE4WFVDeXhybDFhL3ZYZHpTcm4yZk9UV2l3N3M2TlJYRngxK2RKZjFj?=
 =?utf-8?B?cjVCc281dVJYTXdOaVBFSmhoQWRNK3poTFE5aGY5TlZYQVdLUEFNNGQ5emZJ?=
 =?utf-8?B?MzlBWStCcU5qMzY0TnlXL3l0MVN3eS9kaUJ4K3hzcDE2Qmc0SUh0T3VPMFl2?=
 =?utf-8?B?Mm9mNEFldTFLRUZnK3d1Rnh2TmtKaVlUZnFCMnBwb29nUGlUK0Zmdkx5RFUz?=
 =?utf-8?B?RnZCNGJmT0pzc0UyRUtsMHlqeXpoMXlCUnFRdFFSMklEWXNTblU3cDladnJD?=
 =?utf-8?B?ZlltZUlwQmZ0TStpTC9vUmRSd0pHR0dMSnllMTYxVEVFQnFtT1E4WEF1OVVm?=
 =?utf-8?B?TEVubW14RlEyUlJkSHVXcitVcWFFcVdBeG1Od3FiS0ViMFBLOWxKbkx3aXIr?=
 =?utf-8?B?bGNzUnNFZlFpMDdubGpCNlZScDB2VEJMdHNKMklBN0pyZnI4VHFEcW0zVWhR?=
 =?utf-8?B?M2Z6ektsQnlhRUlpSXV6Tmh2c0hMUnBTK3NJcmtUNENXZnJmeTBzQnRnMWhl?=
 =?utf-8?B?OFdrYzJsRjNHZGZKMmluSFFpOXkvTmJmUm5nVlU1elc5S0VtblhQL2x5QjhJ?=
 =?utf-8?B?N1Q0bTJ0TXZObitBTHhMYjdvU0ZOaWpZNzE0SVdIZDg4aGI0UzF5TWRsMlhD?=
 =?utf-8?B?OXRMUzB5OUUrSlk2eEluWkgwRGZIcDY5b1M3akE0S2lveVEvOXJuSVJ2MFdh?=
 =?utf-8?B?b1NvaHZyVjQrWG1BWXRmdTdkbWV3WFh4ajc3MU4wdXh5L3kxVDByQ3JydzRD?=
 =?utf-8?B?Y2UrL0xjRW5QN1hKM3g4NDhBYjkyRFR1OVJjOXEzQysxS0h0SFI3MEF4blBD?=
 =?utf-8?B?VnZ3aHdZK0ozVFJ3cVBjSlFhUjUyK3RyWHZGZWtMOHM1VXdWbFdPWlRHY2ZP?=
 =?utf-8?B?VEVWaTBJYTYwdVQvaEtoNCszbkJuOFNDL1loWm52Z0M1THplWEV4VTN6WTZP?=
 =?utf-8?B?ckFueGRuWHdlOFUwNWJXeVU0SDc3Y2dBa0FsUG9mRlg0WDdVa1IwV3JWVU5q?=
 =?utf-8?B?YjQ2MVg3dkdDbVA4amE1ZXdmcFQwM3FtMVJUZ1FpSVVpMXhlaWxKUTlzZFI0?=
 =?utf-8?B?d0ZSNkNoSUdlVER5TXNlZzNxUGF4NzI3aVprWHZqbXVWZmh6eHgzQjcxNVZG?=
 =?utf-8?B?UUx6VFg2RlF1NEh4cDNNOEg5YWp3ei9WMC9PWTJRUHRPVENyUU5qWlNZOUVO?=
 =?utf-8?B?eWFnazBQRGJzOXRpZGd0MWs1bTJLdzBlWUVhYzJIZ2V3dUtoQXJFVHMvc2dU?=
 =?utf-8?B?SUVDNmp3NnVlU0xORHNZeG1hRXZpUThKS0VqdUF5MTlFdllLTXpnWHp5bkdC?=
 =?utf-8?B?N2ZsbjRFSlNLUS9ZSWQwOFZnSjF1bTZjWFVLbUw3RFZHaTc2SGROM2VhNE5q?=
 =?utf-8?B?N2tncnk0NDdScmFGT3RKd3Y5RncyVGhobEJPWkZDU1hlSHZqRmdDeTduN01R?=
 =?utf-8?B?QUJtaFNmSEprMDVidGRWM0ZyUXV0ekxzQXl5RVNjL2srOGRwbzFOdnV6VE1Q?=
 =?utf-8?B?T0NuRWFmcXV3QTZJdUdPUy9yMU1nb21QbW5PL0Z2WjVDdGpuQ3NrTGZQNWZN?=
 =?utf-8?B?UEZvS1dwcmh5S3hQTkY2WlZQczZ0N2pQK0U5dGZJbDdzSjZOMkRMS2Y5TWts?=
 =?utf-8?B?UEFYcEVZdmFjdlNLMGRFK3Z1Y0VGaGcwMFZqV2ZYbEVEN01MRXZNOW1XK0Jo?=
 =?utf-8?Q?DsdIIUEdnsj+AU17sQ4SGdg3T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcff27b-7b9e-4262-91b5-08dcdd972e11
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 19:20:56.3884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hj84IXBZTmCSUpMBM+AEj7yX3pXbyVq/m6vyWVhGPUlXCGoQgMXSYAtNG4ZpPJgdfatUOAguBmK1qg1W3iDN7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7852
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

I sort of agree that KFD allocated one PASID per process for historical 
reasons. KFD used one address space per process that was shared by all 
GPUs and the CPU, so it seemed wasteful to allocate multiple PASIDs for 
the same process.

On the other hand, I also don't see why you can't use the same PASID on 
multiple devices, even if they do refer to different address spaces. If 
the PASID is a per-device address space ID, that should be perfectly 
fine. It doesn't need to be globally unique. If it was globally unique, 
the adev->vm_manager.pasids table should actually be global, not in the 
adev.

That said, it should be doable to change KFD to use per-VM PASIDs. 
PASIDs are not exposed in user mode, so user mode APIs wouldn't be 
affected. Some debugfs stuff and dmesg logs would change. And we'd need 
to move kfd_process->pasid to pdd->pasids. This is probably a bigger 
change than what Jon proposed in his patch, though.

Regards,
   Felix


On 2024-09-11 09:58, Christian König wrote:
> Am 11.09.24 um 15:40 schrieb Philip Yang:
>>
>> On 2024-09-11 02:54, Christian König wrote:
>>
>>> Yeah, I completely agree with Xiaogang.
>>>
>>> The PASID is an identifier of an address space. And the idea of the 
>>> KFD was that we can just use the same address space and with it the 
>>> page tables for multiple execution devices, e.g. CPUs, GPUs etc...
>>>
>>> That idea turned out to be a bad one because it clashes with some 
>>> use cases (e.g. native context virtualization). The better approach 
>>> is to see the CPU and GPU processes as separate things which just 
>>> share the same underlying data.
>>>
>>> Opening the KFD node multiple times currently results in the same 
>>> KFD process being used. We should probably consider changing that.
>>
>> It is one KFD process binding to one app process, with count to 
>> support multiple open/close of for the same process.
>>
>
> Yeah and to repeat myself: That seems to be a bad idea.
>
>> The IOMMU most likely uses Linux process pid, not from kfd 
>> process->pasid. The KFD process->pasid is passed to F/W to map 
>> queues, flush TLB.
>>
>
> Actually no, the IOMMU uses driver assigned PASIDs.
>
>> The reason to replace vm->pasid with KFD process->pasid is to find vm 
>> from fault pasid, then for compute vm, find the kfd process from pasid.
>>
>
> Why aren't we doing it the other way around? In other words start 
> using the VM assigned PASID?
>
> IIRC that the KFD overwrites the PASID inside the VM was only done for 
> the ATC/IOMMU handling, which is now completely gone.
>
> Regards,
> Christian.
>
>> I can see a bug in amdgpu_vm_handle_fault, only for compute vm, to 
>> force update PTE no-retry-fault to the incorrect VM for multiple 
>> partitions. This patch will fix this bug but we can have a simple fix.
>>
>> Regards,
>>
>> Philip
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 11.09.24 um 01:59 schrieb Chen, Xiaogang:
>>>>
>>>>
>>>> You want have 1:1 mapping between vm and pasid so can query vm from 
>>>> pasid.  I think there is a basic existing issue that we cannot have 
>>>> vm and pasid 1:1 correspondence.
>>>>
>>>> PASIDs are global address space identifiers that can be shared 
>>>> between the GPU, an IOMMU and the driver. One app should have one 
>>>> pasid that iommu uses to decide which page table to use when device 
>>>> access system resource. But one app can open render/kfd node 
>>>> multiple times even for one gpu. That said one app could have 
>>>> multiple GPU vms .
>>>>
>>>> I think we did not have this issue because app usually open a rent 
>>>> node or kfd node only once. With one adev has multiple partitions 
>>>> there are multiple vms on one adev, so have this issue.  But the 
>>>> root cause is not from multiple partitions and solution is not to 
>>>> introduce multiple pasids. I think we should have one pasid for one 
>>>> app and use different way to get vm from pasid.
>>>>
>>>>
>>>> Regards
>>>>
>>>> Xiaogang
>>>>
>>>> On 9/10/2024 3:47 PM, Kim, Jonathan wrote:
>>>>>
>>>>> [Public]
>>>>>
>>>>>
>>>>>
>>>>> 	
>>>>> Caution: This message originated from an External Source. Use 
>>>>> proper caution when opening attachments, clicking links, or 
>>>>> responding.
>>>>>
>>>>>
>>>>> [Public]
>>>>>
>>>>>
>>>>> KMS open still set per pasid-vm bindings per adev (socket) so I 
>>>>> don’t see how the per-partition overwrite PASID issue is primarily 
>>>>> a KFD concern.
>>>>>
>>>>> Are you saying the KFD process devices holds a shadow copy of the 
>>>>> correct VM during page restore during fault?
>>>>>
>>>>> Doesn’t it acquire the wrong VM object on process init in the 
>>>>> first place?
>>>>>
>>>>> Even if it were the case the KFD had a separate VM reference, the 
>>>>> underlying IRQ fault handling is still broken.
>>>>>
>>>>> We probably don’t want to bandage over something to fix one symptom.
>>>>>
>>>>> Jon
>>>>>
>>>>> *From:*Yang, Philip <Philip.Yang@amd.com>
>>>>> *Sent:* Tuesday, September 10, 2024 11:24 AM
>>>>> *To:* Koenig, Christian <Christian.Koenig@amd.com>; Kim, Jonathan 
>>>>> <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>>>>> *Cc:* Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander 
>>>>> <Alexander.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
>>>>> *Subject:* Re: [PATCH] drm/amdkfd: fix vm-pasid lookup for 
>>>>> multiple partitions
>>>>>
>>>>> On 2024-09-09 14:46, Christian König wrote:
>>>>>
>>>>>     Am 09.09.24 um 18:02 schrieb Kim, Jonathan:
>>>>>
>>>>>         [Public]
>>>>>
>>>>>
>>>>>             -----Original Message-----
>>>>>             From: Christian König
>>>>>             <ckoenig.leichtzumerken@gmail.com>
>>>>>             <mailto:ckoenig.leichtzumerken@gmail.com>
>>>>>             Sent: Thursday, September 5, 2024 10:24 AM
>>>>>             To: Kim, Jonathan <Jonathan.Kim@amd.com>
>>>>>             <mailto:Jonathan.Kim@amd.com>;
>>>>>             amd-gfx@lists.freedesktop.org
>>>>>             Cc: Kuehling, Felix <Felix.Kuehling@amd.com>
>>>>>             <mailto:Felix.Kuehling@amd.com>; Deucher, Alexander
>>>>>             <Alexander.Deucher@amd.com>
>>>>>             <mailto:Alexander.Deucher@amd.com>; Joshi, Mukul
>>>>>             <Mukul.Joshi@amd.com> <mailto:Mukul.Joshi@amd.com>
>>>>>             Subject: Re: [PATCH] drm/amdkfd: fix vm-pasid lookup
>>>>>             for multiple partitions
>>>>>
>>>>>             Caution: This message originated from an External
>>>>>             Source. Use proper caution
>>>>>             when opening attachments, clicking links, or responding.
>>>>>
>>>>>
>>>>>             Am 19.08.24 um 19:59 schrieb Jonathan Kim:
>>>>>
>>>>>                 Currently multiple partitions will incorrectly
>>>>>                 overwrite the VM lookup
>>>>>                 table since the table is indexed by PASID and
>>>>>                 multiple partitions can
>>>>>                 register different VM objects on the same PASID.
>>>>>
>>>>>             That's a rather bad idea. Why do we have the same
>>>>>             PASID for different VM
>>>>>             objects in the first place?
>>>>>
>>>>>         Alex can probably elaborate on the KGD side, but from what
>>>>>         I can see, the KMS driver open call has always assigned a
>>>>>         new VM object per PASID on an open call.
>>>>>         The KFD acquires and replaces the KGD PASID-VMID
>>>>>         registration on its own compute process open/creation call.
>>>>>         If this is the bad_idea you're referring to, then someone
>>>>>         else will have to chime in.  I don't have much history on
>>>>>         this unfortunately.
>>>>>
>>>>>
>>>>>     Yeah, Felix and I designed that.
>>>>>
>>>>> app opens drm node to create vm for each partition, with different 
>>>>> vm->pasid for each vm, issue is from kfd_ioctl_acquire_vm -> 
>>>>> kfd_process_device_init_vm -> amdgpu_amdkfd_gpuvm_set_vm_pasid, to 
>>>>> replace all vm->pasid with kfd process->pasid, which is from open 
>>>>> kfd node. This ends up to store only one vm to 
>>>>> adev->vm_manager.pasids with KFD process pasid, so we cannot 
>>>>> retrieve correct vm from adev->vm_manager.pasids on mGPUs or 
>>>>> multiple partitions.
>>>>>
>>>>>
>>>>>
>>>>>         That aside, the current problem is, is that all KFD device
>>>>>         structures are logical partitions and register their
>>>>>         PASID-VM binding using this concept of a device.
>>>>>
>>>>>
>>>>>     As far as I can see that is the fundamental problem. This
>>>>>     needs to be fixed instead.
>>>>>
>>>>>
>>>>>         On the KGD side however, the registration table is
>>>>>         maintained in the adev struct, which is a physical socket.
>>>>>         So there's a mismatch in understanding of what a device is
>>>>>         between the KFD & KGD with regard to the look up table
>>>>>         that results in bad bindings.
>>>>>
>>>>>         Adding a per-partition dimension to the existing lookup
>>>>>         table resolves issues where seeing, for example, with
>>>>>         memory violation interception and XNACK i.e bad bindings
>>>>>         result in wrong vm object found to set no-retry flags on
>>>>>         memory violations.
>>>>>
>>>>> svm_range_restore_pages retry fault recover uses fault pasid to 
>>>>> get kfd process, and use the fault node_id to get pdd->vm, maybe 
>>>>> you can use this way to fix the debugger issue.
>>>>>
>>>>> Regards,
>>>>>
>>>>> Philip
>>>>>
>>>>>
>>>>>     Yeah that is pretty much a no-go.
>>>>>
>>>>>     The PASID and how it is used is defined by the PCIe
>>>>>     specifications. If we now start to assign multiple VMs to the
>>>>>     same PASID then we are violating the PCIe specification.
>>>>>
>>>>>     The problems you see are most likely just the tip of the
>>>>>     iceberg here.
>>>>>
>>>>>     Regards,
>>>>>     Christian.
>>>>>
>>>>>
>>>>>
>>>>>         Jon
>>>>>
>>>>>
>>>>>             Regards,
>>>>>             Christian.
>>>>>
>>>>>
>>>>>                 This results in loading the wrong VM object on
>>>>>                 PASID query.
>>>>>
>>>>>                 To correct this, setup the lookup table to be
>>>>>                 per-partition-per-PASID
>>>>>                 instead.
>>>>>
>>>>>                 Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>>>>>                 <mailto:jonathan.kim@amd.com>
>>>>>                 ---
>>>>>                 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 12 ++++
>>>>>                 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
>>>>>                 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c |  4 +-
>>>>>                 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  7 ++-
>>>>>                 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 55
>>>>>                 +++++++++++------
>>>>>
>>>>>             -- 
>>>>>
>>>>>                 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 11 +++-
>>>>>                 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  5 +-
>>>>>                 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c |  5 +-
>>>>>                 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c |  5 +-
>>>>>                 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c |  3 +-
>>>>>                 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c |  5 +-
>>>>>                 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 16 ++----
>>>>>                 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c |  2 +-
>>>>>                 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  4 +-
>>>>>                 drivers/gpu/drm/amd/amdkfd/kfd_events.c |  3 +-
>>>>>                 .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c |  8 +--
>>>>>                 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c |  8 +--
>>>>>                 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  3 +-
>>>>>                    18 files changed, 92 insertions(+), 65
>>>>>                 deletions(-)
>>>>>
>>>>>                 diff --git
>>>>>                 a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>
>>>>>             b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>
>>>>>                 index c272461d70a9..28db789610e1 100644
>>>>>                 --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>                 +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>>>>                 @@ -887,3 +887,15 @@ int
>>>>>                 amdgpu_amdkfd_unmap_hiq(struct
>>>>>
>>>>>             amdgpu_device *adev, u32 doorbell_off,
>>>>>
>>>>>                        return r;
>>>>>                    }
>>>>>                 +
>>>>>                 +int amdgpu_amdkfd_node_id_to_xcc_id(struct
>>>>>                 amdgpu_device *adev,
>>>>>
>>>>>             uint32_t node_id)
>>>>>
>>>>>                 +{
>>>>>                 +     if (adev->gfx.funcs->ih_node_to_logical_xcc) {
>>>>>                 +             int xcc_id =
>>>>>                 adev->gfx.funcs->ih_node_to_logical_xcc(adev,
>>>>>                 node_id);
>>>>>                 +
>>>>>                 +             if (xcc_id >= 0)
>>>>>                 +                     return xcc_id;
>>>>>                 +     }
>>>>>                 +
>>>>>                 +     return 0;
>>>>>                 +}
>>>>>                 diff --git
>>>>>                 a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>
>>>>>             b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>
>>>>>                 index 4ed49265c764..bf8bb45d8ab6 100644
>>>>>                 --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>                 +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>>                 @@ -356,6 +356,7 @@ void
>>>>>                 amdgpu_amdkfd_unreserve_mem_limit(struct
>>>>>
>>>>>             amdgpu_device *adev,
>>>>>
>>>>>                 uint64_t size, u32 alloc_flag, int8_t xcp_id);
>>>>>
>>>>>                    u64 amdgpu_amdkfd_xcp_memory_size(struct
>>>>>                 amdgpu_device *adev, int
>>>>>
>>>>>             xcp_id);
>>>>>
>>>>>                 +int amdgpu_amdkfd_node_id_to_xcc_id(struct
>>>>>                 amdgpu_device *adev,
>>>>>
>>>>>             uint32_t node_id);
>>>>>
>>>>>                    #define KFD_XCP_MEM_ID(adev, xcp_id) \
>>>>>                                ((adev)->xcp_mgr && (xcp_id) >= 0 ?\
>>>>>                 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>>
>>>>>             b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>>
>>>>>                 index c6a1783fc9ef..bf9f8802e18d 100644
>>>>>                 --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>>                 +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>>                 @@ -37,7 +37,7 @@ static enum drm_gpu_sched_stat
>>>>>
>>>>>             amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>>>
>>>>>                        struct amdgpu_job *job = to_amdgpu_job(s_job);
>>>>>                        struct amdgpu_task_info *ti;
>>>>>                        struct amdgpu_device *adev = ring->adev;
>>>>>                 -     int idx;
>>>>>                 +     int idx, xcp_id = !job->vm ? 0 :
>>>>>                 job->vm->xcp_id;
>>>>>                        int r;
>>>>>
>>>>>                        if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
>>>>>                 @@ -62,7 +62,7 @@ static enum drm_gpu_sched_stat
>>>>>
>>>>>             amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>>>
>>>>>                 job->base.sched->name,
>>>>>                 atomic_read(&ring->fence_drv.last_seq),
>>>>>                 ring->fence_drv.sync_seq);
>>>>>
>>>>>                 -     ti =
>>>>>                 amdgpu_vm_get_task_info_pasid(ring->adev,
>>>>>                 job->pasid);
>>>>>                 +     ti =
>>>>>                 amdgpu_vm_get_task_info_pasid(ring->adev,
>>>>>                 job->pasid, xcp_id);
>>>>>                        if (ti) {
>>>>>                                dev_err(adev->dev,
>>>>>                                        "Process information:
>>>>>                 process %s pid %d thread %s pid %d\n",
>>>>>                 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>>
>>>>>             b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>>
>>>>>                 index d9fde38f6ee2..e413bf4a3e84 100644
>>>>>                 --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>>                 +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>>>                 @@ -1275,17 +1275,20 @@ int
>>>>>                 amdgpu_info_ioctl(struct drm_device *dev,
>>>>>
>>>>>             void *data, struct drm_file *filp)
>>>>>
>>>>>                 struct amdgpu_vm *vm = &fpriv->vm;
>>>>>                                struct drm_amdgpu_info_gpuvm_fault
>>>>>                 gpuvm_fault;
>>>>>                                unsigned long flags;
>>>>>                 +             int i;
>>>>>
>>>>>                                if (!vm)
>>>>>                                        return -EINVAL;
>>>>>
>>>>>                 memset(&gpuvm_fault, 0, sizeof(gpuvm_fault));
>>>>>
>>>>>                 - xa_lock_irqsave(&adev->vm_manager.pasids, flags);
>>>>>                 +             for (i = 0; i <
>>>>>                 adev->xcp_mgr->num_xcps; i++)
>>>>>                 + xa_lock_irqsave(&adev->vm_manager.pasids[i],
>>>>>                 flags);
>>>>>                                gpuvm_fault.addr =
>>>>>                 vm->fault_info.addr;
>>>>>                                gpuvm_fault.status =
>>>>>                 vm->fault_info.status;
>>>>>                                gpuvm_fault.vmhub =
>>>>>                 vm->fault_info.vmhub;
>>>>>                 - xa_unlock_irqrestore(&adev->vm_manager.pasids,
>>>>>                 flags);
>>>>>                 +             for (i = 0; i <
>>>>>                 adev->xcp_mgr->num_xcps; i++)
>>>>>                 +
>>>>>                 xa_unlock_irqrestore(&adev->vm_manager.pasids[i],
>>>>>                 flags);
>>>>>
>>>>>                                return copy_to_user(out, &gpuvm_fault,
>>>>>                 min((size_t)size, sizeof(gpuvm_fault))) ? -EFAULT
>>>>>                 : 0;
>>>>>                 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>
>>>>>             b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>
>>>>>                 index bcb729094521..f43e1c15f423 100644
>>>>>                 --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>                 +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>>                 @@ -146,7 +146,7 @@ int amdgpu_vm_set_pasid(struct
>>>>>                 amdgpu_device
>>>>>
>>>>>             *adev, struct amdgpu_vm *vm,
>>>>>
>>>>>                 return 0;
>>>>>
>>>>>                        if (vm->pasid) {
>>>>>                 -             r =
>>>>>                 xa_err(xa_erase_irq(&adev->vm_manager.pasids,
>>>>>                 vm->pasid));
>>>>>                 +             r =
>>>>>                 xa_err(xa_erase_irq(&adev->vm_manager.pasids[vm->xcp_id],
>>>>>
>>>>>
>>>>>             vm->pasid));
>>>>>
>>>>>                                if (r < 0)
>>>>>                                        return r;
>>>>>
>>>>>                 @@ -154,7 +154,7 @@ int amdgpu_vm_set_pasid(struct
>>>>>                 amdgpu_device
>>>>>
>>>>>             *adev, struct amdgpu_vm *vm,
>>>>>
>>>>>                        }
>>>>>
>>>>>                        if (pasid) {
>>>>>                 -             r =
>>>>>                 xa_err(xa_store_irq(&adev->vm_manager.pasids,
>>>>>                 pasid, vm,
>>>>>                 +             r =
>>>>>                 xa_err(xa_store_irq(&adev->vm_manager.pasids[vm->xcp_id],
>>>>>
>>>>>
>>>>>             pasid, vm,
>>>>>
>>>>>                 GFP_KERNEL));
>>>>>                                if (r < 0)
>>>>>                                        return r;
>>>>>                 @@ -2288,14 +2288,14 @@ static void
>>>>>
>>>>>             amdgpu_vm_destroy_task_info(struct kref *kref)
>>>>>
>>>>>                    }
>>>>>
>>>>>                    static inline struct amdgpu_vm *
>>>>>                 -amdgpu_vm_get_vm_from_pasid(struct amdgpu_device
>>>>>                 *adev, u32 pasid)
>>>>>                 +amdgpu_vm_get_vm_from_pasid(struct amdgpu_device
>>>>>                 *adev, u32 pasid,
>>>>>
>>>>>             u32 xcp_id)
>>>>>
>>>>>                    {
>>>>>                        struct amdgpu_vm *vm;
>>>>>                        unsigned long flags;
>>>>>
>>>>>                 - xa_lock_irqsave(&adev->vm_manager.pasids, flags);
>>>>>                 -     vm = xa_load(&adev->vm_manager.pasids, pasid);
>>>>>                 - xa_unlock_irqrestore(&adev->vm_manager.pasids,
>>>>>                 flags);
>>>>>                 +
>>>>>                 xa_lock_irqsave(&adev->vm_manager.pasids[xcp_id],
>>>>>                 flags);
>>>>>                 +     vm =
>>>>>                 xa_load(&adev->vm_manager.pasids[xcp_id], pasid);
>>>>>                 +
>>>>>                 xa_unlock_irqrestore(&adev->vm_manager.pasids[xcp_id],
>>>>>                 flags);
>>>>>
>>>>>                        return vm;
>>>>>                    }
>>>>>                 @@ -2343,10 +2343,10 @@
>>>>>                 amdgpu_vm_get_task_info_vm(struct
>>>>>
>>>>>             amdgpu_vm *vm)
>>>>>
>>>>>                     * referenced down with amdgpu_vm_put_task_info.
>>>>>                     */
>>>>>                    struct amdgpu_task_info *
>>>>>                 -amdgpu_vm_get_task_info_pasid(struct
>>>>>                 amdgpu_device *adev, u32 pasid)
>>>>>                 +amdgpu_vm_get_task_info_pasid(struct
>>>>>                 amdgpu_device *adev, u32 pasid,
>>>>>
>>>>>             u32 xcp_id)
>>>>>
>>>>>                    {
>>>>>                        return amdgpu_vm_get_task_info_vm(
>>>>>                 - amdgpu_vm_get_vm_from_pasid(adev, pasid));
>>>>>                 + amdgpu_vm_get_vm_from_pasid(adev, pasid, xcp_id));
>>>>>                    }
>>>>>
>>>>>                    static int amdgpu_vm_create_task_info(struct
>>>>>                 amdgpu_vm *vm)
>>>>>                 @@ -2481,6 +2481,8 @@ int amdgpu_vm_init(struct
>>>>>                 amdgpu_device
>>>>>
>>>>>             *adev, struct amdgpu_vm *vm,
>>>>>
>>>>>                 amdgpu_bo_unreserve(vm->root.bo);
>>>>>                        amdgpu_bo_unref(&root_bo);
>>>>>
>>>>>                 +     vm->xcp_id = xcp_id < 0 ? 0 : xcp_id;
>>>>>                 +
>>>>>                        return 0;
>>>>>
>>>>>                    error_free_root:
>>>>>                 @@ -2695,8 +2697,8 @@ void
>>>>>                 amdgpu_vm_manager_init(struct
>>>>>
>>>>>             amdgpu_device *adev)
>>>>>
>>>>>                    #else
>>>>>                 adev->vm_manager.vm_update_mode = 0;
>>>>>                    #endif
>>>>>                 -
>>>>>                 - xa_init_flags(&adev->vm_manager.pasids,
>>>>>                 XA_FLAGS_LOCK_IRQ);
>>>>>                 +     for (i = 0; i < MAX_XCP; i++)
>>>>>                 + xa_init_flags(&(adev->vm_manager.pasids[i]),
>>>>>
>>>>>             XA_FLAGS_LOCK_IRQ);
>>>>>
>>>>>                    }
>>>>>
>>>>>                    /**
>>>>>                 @@ -2708,10 +2710,15 @@ void
>>>>>                 amdgpu_vm_manager_init(struct
>>>>>
>>>>>             amdgpu_device *adev)
>>>>>
>>>>>                     */
>>>>>                    void amdgpu_vm_manager_fini(struct
>>>>>                 amdgpu_device *adev)
>>>>>                    {
>>>>>                 - WARN_ON(!xa_empty(&adev->vm_manager.pasids));
>>>>>                 - xa_destroy(&adev->vm_manager.pasids);
>>>>>                 +     int i;
>>>>>                 +
>>>>>                 +     for (i = 0; i < MAX_XCP; i++) {
>>>>>                 + WARN_ON(!xa_empty(&adev->vm_manager.pasids[i]));
>>>>>                 + xa_destroy(&adev->vm_manager.pasids[i]);
>>>>>                 +     }
>>>>>
>>>>>                        amdgpu_vmid_mgr_fini(adev);
>>>>>                 +
>>>>>                    }
>>>>>
>>>>>                    /**
>>>>>                 @@ -2778,17 +2785,18 @@ bool
>>>>>                 amdgpu_vm_handle_fault(struct
>>>>>
>>>>>             amdgpu_device *adev, u32 pasid,
>>>>>
>>>>>                        unsigned long irqflags;
>>>>>                        uint64_t value, flags;
>>>>>                        struct amdgpu_vm *vm;
>>>>>                 -     int r;
>>>>>                 +     int r, xcp_id;
>>>>>
>>>>>                 - xa_lock_irqsave(&adev->vm_manager.pasids,
>>>>>                 irqflags);
>>>>>                 -     vm = xa_load(&adev->vm_manager.pasids, pasid);
>>>>>                 +     xcp_id =
>>>>>                 amdgpu_amdkfd_node_id_to_xcc_id(adev, node_id)/adev-
>>>>>                 gfx.num_xcc_per_xcp;
>>>>>                 +
>>>>>                 xa_lock_irqsave(&adev->vm_manager.pasids[xcp_id],
>>>>>                 irqflags);
>>>>>                 +     vm =
>>>>>                 xa_load(&adev->vm_manager.pasids[xcp_id], pasid);
>>>>>                        if (vm) {
>>>>>                                root = amdgpu_bo_ref(vm->root.bo);
>>>>>                                is_compute_context =
>>>>>                 vm->is_compute_context;
>>>>>                        } else {
>>>>>                                root = NULL;
>>>>>                        }
>>>>>                 - xa_unlock_irqrestore(&adev->vm_manager.pasids,
>>>>>                 irqflags);
>>>>>                 +
>>>>>                 xa_unlock_irqrestore(&adev->vm_manager.pasids[xcp_id],
>>>>>                 irqflags);
>>>>>
>>>>>                        if (!root)
>>>>>                                return false;
>>>>>                 @@ -2806,11 +2814,11 @@ bool
>>>>>                 amdgpu_vm_handle_fault(struct
>>>>>
>>>>>             amdgpu_device *adev, u32 pasid,
>>>>>
>>>>>                                goto error_unref;
>>>>>
>>>>>                        /* Double check that the VM still exists */
>>>>>                 - xa_lock_irqsave(&adev->vm_manager.pasids,
>>>>>                 irqflags);
>>>>>                 -     vm = xa_load(&adev->vm_manager.pasids, pasid);
>>>>>                 +
>>>>>                 xa_lock_irqsave(&adev->vm_manager.pasids[xcp_id],
>>>>>                 irqflags);
>>>>>                 +     vm =
>>>>>                 xa_load(&adev->vm_manager.pasids[xcp_id], pasid);
>>>>>                        if (vm && vm->root.bo != root)
>>>>>                                vm = NULL;
>>>>>                 - xa_unlock_irqrestore(&adev->vm_manager.pasids,
>>>>>                 irqflags);
>>>>>                 +
>>>>>                 xa_unlock_irqrestore(&adev->vm_manager.pasids[xcp_id],
>>>>>                 irqflags);
>>>>>                        if (!vm)
>>>>>                                goto error_unlock;
>>>>>
>>>>>                 @@ -2968,14 +2976,15 @@ void
>>>>>                 amdgpu_vm_update_fault_cache(struct
>>>>>
>>>>>             amdgpu_device *adev,
>>>>>
>>>>>                 unsigned int pasid,
>>>>>                 uint64_t addr,
>>>>>                 uint32_t status,
>>>>>                 - unsigned int vmhub)
>>>>>                 + unsigned int vmhub,
>>>>>                 + uint32_t xcp_id)
>>>>>                    {
>>>>>                        struct amdgpu_vm *vm;
>>>>>                        unsigned long flags;
>>>>>
>>>>>                 - xa_lock_irqsave(&adev->vm_manager.pasids, flags);
>>>>>                 +
>>>>>                 xa_lock_irqsave(&adev->vm_manager.pasids[xcp_id],
>>>>>                 flags);
>>>>>
>>>>>                 -     vm = xa_load(&adev->vm_manager.pasids, pasid);
>>>>>                 +     vm =
>>>>>                 xa_load(&adev->vm_manager.pasids[xcp_id], pasid);
>>>>>                        /* Don't update the fault cache if status
>>>>>                 is 0.  In the multiple
>>>>>                         * fault case, subsequent faults will
>>>>>                 return a 0 status which is
>>>>>                         * useless for userspace and replaces the
>>>>>                 useful fault status, so
>>>>>                 @@ -3008,7 +3017,7 @@ void
>>>>>                 amdgpu_vm_update_fault_cache(struct
>>>>>
>>>>>             amdgpu_device *adev,
>>>>>
>>>>>                 WARN_ONCE(1, "Invalid vmhub %u\n", vmhub);
>>>>>                                }
>>>>>                        }
>>>>>                 - xa_unlock_irqrestore(&adev->vm_manager.pasids,
>>>>>                 flags);
>>>>>                 +
>>>>>                 xa_unlock_irqrestore(&adev->vm_manager.pasids[xcp_id],
>>>>>                 flags);
>>>>>                    }
>>>>>
>>>>>                    /**
>>>>>                 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>
>>>>>             b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>
>>>>>                 index 046949c4b695..1499f5f731e9 100644
>>>>>                 --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>                 +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>                 @@ -35,6 +35,7 @@
>>>>>                    #include "amdgpu_sync.h"
>>>>>                    #include "amdgpu_ring.h"
>>>>>                    #include "amdgpu_ids.h"
>>>>>                 +#include "amdgpu_xcp.h"
>>>>>
>>>>>                    struct drm_exec;
>>>>>
>>>>>                 @@ -418,6 +419,9 @@ struct amdgpu_vm {
>>>>>
>>>>>                        /* cached fault info */
>>>>>                        struct amdgpu_vm_fault_info fault_info;
>>>>>                 +
>>>>>                 +     /* XCP ID */
>>>>>                 +     int xcp_id;
>>>>>                    };
>>>>>
>>>>>                    struct amdgpu_vm_manager {
>>>>>                 @@ -456,7 +460,7 @@ struct amdgpu_vm_manager {
>>>>>                        /* PASID to VM mapping, will be used in
>>>>>                 interrupt context to
>>>>>                         * look up VM of a page fault
>>>>>                         */
>>>>>                 -     struct xarray pasids;
>>>>>                 +     struct xarray pasids[MAX_XCP];
>>>>>                        /* Global registration of recent page fault
>>>>>                 information */
>>>>>                        struct amdgpu_vm_fault_info fault_info;
>>>>>                    };
>>>>>                 @@ -550,7 +554,7 @@ bool
>>>>>                 amdgpu_vm_need_pipeline_sync(struct
>>>>>
>>>>>             amdgpu_ring *ring,
>>>>>
>>>>>                    void amdgpu_vm_check_compute_bug(struct
>>>>>                 amdgpu_device *adev);
>>>>>
>>>>>                    struct amdgpu_task_info *
>>>>>                 -amdgpu_vm_get_task_info_pasid(struct
>>>>>                 amdgpu_device *adev, u32 pasid);
>>>>>                 +amdgpu_vm_get_task_info_pasid(struct
>>>>>                 amdgpu_device *adev, u32 pasid,
>>>>>
>>>>>             u32 xcp_id);
>>>>>
>>>>>                    struct amdgpu_task_info *
>>>>>                    amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
>>>>>                 @@ -649,7 +653,8 @@ void
>>>>>                 amdgpu_vm_update_fault_cache(struct
>>>>>
>>>>>             amdgpu_device *adev,
>>>>>
>>>>>                 unsigned int pasid,
>>>>>                 uint64_t addr,
>>>>>                 uint32_t status,
>>>>>                 - unsigned int vmhub);
>>>>>                 + unsigned int vmhub,
>>>>>                 + uint32_t xcp_id);
>>>>>                    void amdgpu_vm_tlb_fence_create(struct
>>>>>                 amdgpu_device *adev,
>>>>>                                                 struct amdgpu_vm *vm,
>>>>>                                                 struct dma_fence
>>>>>                 **fence);
>>>>>                 diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>
>>>>>             b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>
>>>>>                 index f0ceab3ce5bf..24b042febf5c 100644
>>>>>                 --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>                 +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>>>>                 @@ -151,7 +151,8 @@ static int
>>>>>                 gmc_v10_0_process_interrupt(struct
>>>>>
>>>>>             amdgpu_device *adev,
>>>>>
>>>>>                 WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
>>>>>
>>>>>                 amdgpu_vm_update_fault_cache(adev, entry->pasid,
>>>>>                 addr, status,
>>>>>                 -                                         
>>>>>                 entry->vmid_src ? AMDGPU_MMHUB0(0) :
>>>>>
>>>>>             AMDGPU_GFXHUB(0));
>>>>>
>>>>>                 + entry->vmid_src ? AMDGPU_MMHUB0(0) :
>>>>>
>>>>>             AMDGPU_GFXHUB(0),
>>>>>
>>>>>                 + 0);
>>>>>                        }
>>>>>
>>>>>                        if (!printk_ratelimit())
>>>>>                 @@ -161,7 +162,7 @@ static int
>>>>>                 gmc_v10_0_process_interrupt(struct
>>>>>
>>>>>             amdgpu_device *adev,
>>>>>
>>>>>                 "[%s] page fault (src_id:%u ring:%u vmid:%u
>>>>>                 pasid:%u)\n",
>>>>>                                entry->vmid_src ? "mmhub" : "gfxhub",
>>>>>                                entry->src_id, entry->ring_id,
>>>>>                 entry->vmid, entry->pasid);
>>>>>                 -     task_info =
>>>>>                 amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>>>>>                 +     task_info =
>>>>>                 amdgpu_vm_get_task_info_pasid(adev, entry->pasid, 0);
>>>>>                        if (task_info) {
>>>>>                                dev_err(adev->dev,
>>>>>                                        " in process %s pid %d
>>>>>                 thread %s pid %d\n",
>>>>>                 diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>>
>>>>>             b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>>
>>>>>                 index 2797fd84432b..3507046d33e6 100644
>>>>>                 --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>>                 +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>>>                 @@ -122,7 +122,8 @@ static int
>>>>>                 gmc_v11_0_process_interrupt(struct
>>>>>
>>>>>             amdgpu_device *adev,
>>>>>
>>>>>                 WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
>>>>>
>>>>>                 amdgpu_vm_update_fault_cache(adev, entry->pasid,
>>>>>                 addr, status,
>>>>>                 -                                         
>>>>>                 entry->vmid_src ? AMDGPU_MMHUB0(0) :
>>>>>
>>>>>             AMDGPU_GFXHUB(0));
>>>>>
>>>>>                 + entry->vmid_src ? AMDGPU_MMHUB0(0) :
>>>>>
>>>>>             AMDGPU_GFXHUB(0),
>>>>>
>>>>>                 + 0);
>>>>>                        }
>>>>>
>>>>>                        if (printk_ratelimit()) {
>>>>>                 @@ -132,7 +133,7 @@ static int
>>>>>                 gmc_v11_0_process_interrupt(struct
>>>>>
>>>>>             amdgpu_device *adev,
>>>>>
>>>>>                 "[%s] page fault (src_id:%u ring:%u vmid:%u
>>>>>                 pasid:%u)\n",
>>>>>                 entry->vmid_src ? "mmhub" : "gfxhub",
>>>>>                 entry->src_id, entry->ring_id, entry->vmid,
>>>>>                 entry->pasid);
>>>>>                 -             task_info =
>>>>>                 amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>>>>>                 +             task_info =
>>>>>                 amdgpu_vm_get_task_info_pasid(adev, entry->pasid, 0);
>>>>>                                if (task_info) {
>>>>>                 dev_err(adev->dev,
>>>>>                                                " in process %s pid
>>>>>                 %d thread %s pid %d)\n",
>>>>>                 diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>>>>
>>>>>             b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>>>>
>>>>>                 index 60acf676000b..9844564c6c74 100644
>>>>>                 --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>>>>                 +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>>>>                 @@ -115,7 +115,8 @@ static int
>>>>>                 gmc_v12_0_process_interrupt(struct
>>>>>
>>>>>             amdgpu_device *adev,
>>>>>
>>>>>                 WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
>>>>>
>>>>>                 amdgpu_vm_update_fault_cache(adev, entry->pasid,
>>>>>                 addr, status,
>>>>>                 -                                         
>>>>>                 entry->vmid_src ? AMDGPU_MMHUB0(0) :
>>>>>
>>>>>             AMDGPU_GFXHUB(0));
>>>>>
>>>>>                 + entry->vmid_src ? AMDGPU_MMHUB0(0) :
>>>>>
>>>>>             AMDGPU_GFXHUB(0),
>>>>>
>>>>>                 + 0);
>>>>>                        }
>>>>>
>>>>>                        if (printk_ratelimit()) {
>>>>>                 @@ -125,7 +126,7 @@ static int
>>>>>                 gmc_v12_0_process_interrupt(struct
>>>>>
>>>>>             amdgpu_device *adev,
>>>>>
>>>>>                 "[%s] page fault (src_id:%u ring:%u vmid:%u
>>>>>                 pasid:%u)\n",
>>>>>                 entry->vmid_src ? "mmhub" : "gfxhub",
>>>>>                 entry->src_id, entry->ring_id, entry->vmid,
>>>>>                 entry->pasid);
>>>>>                 -             task_info =
>>>>>                 amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>>>>>                 +             task_info =
>>>>>                 amdgpu_vm_get_task_info_pasid(adev, entry->pasid, 0);
>>>>>                                if (task_info) {
>>>>>                 dev_err(adev->dev,
>>>>>                                                " in process %s pid
>>>>>                 %d thread %s pid %d)\n",
>>>>>                 diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>>
>>>>>             b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>>
>>>>>                 index 994432fb57ea..2cdb0cbb7c4d 100644
>>>>>                 --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>>                 +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>>                 @@ -1268,7 +1268,8 @@ static int
>>>>>                 gmc_v7_0_process_interrupt(struct
>>>>>
>>>>>             amdgpu_device *adev,
>>>>>
>>>>>                 return 0;
>>>>>
>>>>>                 amdgpu_vm_update_fault_cache(adev, entry->pasid,
>>>>>                 - ((u64)addr) << AMDGPU_GPU_PAGE_SHIFT, status,
>>>>>
>>>>>             AMDGPU_GFXHUB(0));
>>>>>
>>>>>                 + ((u64)addr) << AMDGPU_GPU_PAGE_SHIFT, status,
>>>>>                 + AMDGPU_GFXHUB(0), 0);
>>>>>
>>>>>                        if (amdgpu_vm_fault_stop ==
>>>>>                 AMDGPU_VM_FAULT_STOP_FIRST)
>>>>>                 gmc_v7_0_set_fault_enable_default(adev, false);
>>>>>                 diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>>
>>>>>             b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>>
>>>>>                 index 86488c052f82..6855caeb7f74 100644
>>>>>                 --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>>                 +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>>                 @@ -1437,7 +1437,8 @@ static int
>>>>>                 gmc_v8_0_process_interrupt(struct
>>>>>
>>>>>             amdgpu_device *adev,
>>>>>
>>>>>                 return 0;
>>>>>
>>>>>                 amdgpu_vm_update_fault_cache(adev, entry->pasid,
>>>>>                 - ((u64)addr) << AMDGPU_GPU_PAGE_SHIFT, status,
>>>>>
>>>>>             AMDGPU_GFXHUB(0));
>>>>>
>>>>>                 + ((u64)addr) << AMDGPU_GPU_PAGE_SHIFT, status,
>>>>>                 + AMDGPU_GFXHUB(0), 0);
>>>>>
>>>>>                        if (amdgpu_vm_fault_stop ==
>>>>>                 AMDGPU_VM_FAULT_STOP_FIRST)
>>>>>                 gmc_v8_0_set_fault_enable_default(adev, false);
>>>>>                 @@ -1448,7 +1449,7 @@ static int
>>>>>                 gmc_v8_0_process_interrupt(struct
>>>>>
>>>>>             amdgpu_device *adev,
>>>>>
>>>>>                 dev_err(adev->dev, "GPU fault detected: %d 0x%08x\n",
>>>>>                 entry->src_id, entry->src_data[0]);
>>>>>
>>>>>                 -             task_info =
>>>>>                 amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>>>>>                 +             task_info =
>>>>>                 amdgpu_vm_get_task_info_pasid(adev, entry->pasid, 0);
>>>>>                                if (task_info) {
>>>>>                 dev_err(adev->dev, " for process %s pid %d thread
>>>>>                 %s pid %d\n",
>>>>>                 task_info->process_name, task_info->tgid,
>>>>>                 diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>>
>>>>>             b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>>
>>>>>                 index b73136d390cc..e183e08b2c02 100644
>>>>>                 --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>>                 +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>>>>                 @@ -556,10 +556,12 @@ static int
>>>>>                 gmc_v9_0_process_interrupt(struct
>>>>>
>>>>>             amdgpu_device *adev,
>>>>>
>>>>>                        unsigned int vmhub;
>>>>>                        u64 addr;
>>>>>                        uint32_t cam_index = 0;
>>>>>                 -     int ret, xcc_id = 0;
>>>>>                 -     uint32_t node_id;
>>>>>                 +     int ret;
>>>>>                 +     uint32_t node_id, xcc_id, xcp_id;
>>>>>
>>>>>                        node_id = entry->node_id;
>>>>>                 +     xcc_id =
>>>>>                 amdgpu_amdkfd_node_id_to_xcc_id(adev, node_id);
>>>>>                 +     xcp_id = xcc_id/adev->gfx.num_xcc_per_xcp;
>>>>>
>>>>>                        addr = (u64)entry->src_data[0] << 12;
>>>>>                        addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>>>>>                 @@ -572,12 +574,6 @@ static int
>>>>>                 gmc_v9_0_process_interrupt(struct
>>>>>
>>>>>             amdgpu_device *adev,
>>>>>
>>>>>                 vmhub = AMDGPU_MMHUB1(0);
>>>>>                        } else {
>>>>>                                hub_name = "gfxhub0";
>>>>>                 -             if
>>>>>                 (adev->gfx.funcs->ih_node_to_logical_xcc) {
>>>>>                 -                     xcc_id =
>>>>>                 adev->gfx.funcs->ih_node_to_logical_xcc(adev,
>>>>>                 - node_id);
>>>>>                 -                     if (xcc_id < 0)
>>>>>                 -                             xcc_id = 0;
>>>>>                 -             }
>>>>>                                vmhub = xcc_id;
>>>>>                        }
>>>>>                        hub = &adev->vmhub[vmhub];
>>>>>                 @@ -631,7 +627,7 @@ static int
>>>>>                 gmc_v9_0_process_interrupt(struct
>>>>>
>>>>>             amdgpu_device *adev,
>>>>>
>>>>>                 retry_fault ? "retry" : "no-retry",
>>>>>                                entry->src_id, entry->ring_id,
>>>>>                 entry->vmid, entry->pasid);
>>>>>
>>>>>                 -     task_info =
>>>>>                 amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>>>>>                 +     task_info =
>>>>>                 amdgpu_vm_get_task_info_pasid(adev, entry->pasid,
>>>>>
>>>>>             xcp_id);
>>>>>
>>>>>                        if (task_info) {
>>>>>                                dev_err(adev->dev,
>>>>>                                        " for process %s pid %d
>>>>>                 thread %s pid %d)\n",
>>>>>                 @@ -675,7 +671,7 @@ static int
>>>>>                 gmc_v9_0_process_interrupt(struct
>>>>>
>>>>>             amdgpu_device *adev,
>>>>>
>>>>>                        if (!amdgpu_sriov_vf(adev))
>>>>>                 WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
>>>>>
>>>>>                 - amdgpu_vm_update_fault_cache(adev, entry->pasid,
>>>>>                 addr, status,
>>>>>
>>>>>             vmhub);
>>>>>
>>>>>                 + amdgpu_vm_update_fault_cache(adev, entry->pasid,
>>>>>                 addr, status,
>>>>>
>>>>>             vmhub, xcp_id);
>>>>>
>>>>>                 dev_err(adev->dev,
>>>>>                 "VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>>>>>                 diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>>>>
>>>>>             b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>>>>
>>>>>                 index 23ef4eb36b40..1ac4224bbe5b 100644
>>>>>                 --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>>>>                 +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>>>>                 @@ -2182,7 +2182,7 @@ static int
>>>>>                 sdma_v4_0_print_iv_entry(struct
>>>>>
>>>>>             amdgpu_device *adev,
>>>>>
>>>>>                 instance, addr, entry->src_id, entry->ring_id,
>>>>>                 entry->vmid,
>>>>>                 entry->pasid);
>>>>>
>>>>>                 -     task_info =
>>>>>                 amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>>>>>                 +     task_info =
>>>>>                 amdgpu_vm_get_task_info_pasid(adev, entry->pasid, 0);
>>>>>                        if (task_info) {
>>>>>                 dev_dbg_ratelimited(adev->dev,
>>>>>                                                    " for process
>>>>>                 %s pid %d thread %s pid %d\n",
>>>>>                 diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>>>
>>>>>             b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>>>
>>>>>                 index 57f16c09abfc..c8b5c0302ca7 100644
>>>>>                 --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>>>                 +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>>>                 @@ -1683,6 +1683,8 @@ static int
>>>>>                 sdma_v4_4_2_print_iv_entry(struct
>>>>>
>>>>>             amdgpu_device *adev,
>>>>>
>>>>>                        int instance;
>>>>>                        struct amdgpu_task_info *task_info;
>>>>>                        u64 addr;
>>>>>                 +     uint32_t xcc_id =
>>>>>                 amdgpu_amdkfd_node_id_to_xcc_id(adev, entry-
>>>>>                 node_id);
>>>>>                 +     uint32_t xcp_id =
>>>>>                 xcc_id/adev->gfx.num_xcc_per_xcp;
>>>>>
>>>>>                        instance = sdma_v4_4_2_irq_id_to_seq(adev,
>>>>>                 entry->client_id);
>>>>>                        if (instance < 0 || instance >=
>>>>>                 adev->sdma.num_instances) {
>>>>>                 @@ -1698,7 +1700,7 @@ static int
>>>>>                 sdma_v4_4_2_print_iv_entry(struct
>>>>>
>>>>>             amdgpu_device *adev,
>>>>>
>>>>>                 instance, addr, entry->src_id, entry->ring_id,
>>>>>                 entry->vmid,
>>>>>                 entry->pasid);
>>>>>
>>>>>                 -     task_info =
>>>>>                 amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>>>>>                 +     task_info =
>>>>>                 amdgpu_vm_get_task_info_pasid(adev, entry->pasid,
>>>>>
>>>>>             xcp_id);
>>>>>
>>>>>                        if (task_info) {
>>>>>                 dev_dbg_ratelimited(adev->dev, " for process %s
>>>>>                 pid %d thread %s
>>>>>
>>>>>             pid %d\n",
>>>>>
>>>>>                 task_info->process_name, task_info->tgid,
>>>>>                 diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>>>>
>>>>>             b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>>>>
>>>>>                 index ea3792249209..c098fbaf0e1c 100644
>>>>>                 --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>>>>                 +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>>>>                 @@ -1262,8 +1262,9 @@ void
>>>>>                 kfd_signal_reset_event(struct kfd_node
>>>>>
>>>>>             *dev)
>>>>>
>>>>>                                if (dev->dqm->detect_hang_count) {
>>>>>                                        struct amdgpu_task_info *ti;
>>>>>                 +                     uint32_t xcp_id = dev->xcp ?
>>>>>                 dev->xcp->id : 0;
>>>>>
>>>>>                 -                     ti =
>>>>>                 amdgpu_vm_get_task_info_pasid(dev->adev, p->pasid);
>>>>>                 +                     ti =
>>>>>                 amdgpu_vm_get_task_info_pasid(dev->adev, p->pasid,
>>>>>
>>>>>             xcp_id);
>>>>>
>>>>>                 if (ti) {
>>>>>                 dev_err(dev->adev->dev,
>>>>>                 "Queues reset on process %s tid %d thread %s pid
>>>>>                 %d\n",
>>>>>                 diff --git
>>>>>                 a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
>>>>>
>>>>>             b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
>>>>>
>>>>>                 index 8e0d0356e810..d7cbf9525698 100644
>>>>>                 ---
>>>>>                 a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
>>>>>                 +++
>>>>>                 b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
>>>>>                 @@ -377,12 +377,8 @@ static void
>>>>>                 event_interrupt_wq_v10(struct
>>>>>
>>>>>             kfd_node *dev,
>>>>>
>>>>>                 struct kfd_hsa_memory_exception_data exception_data;
>>>>>
>>>>>                                /* gfxhub */
>>>>>                 -             if (!vmid_type &&
>>>>>                 dev->adev->gfx.funcs->ih_node_to_logical_xcc) {
>>>>>                 -                     hub_inst =
>>>>>                 dev->adev->gfx.funcs->ih_node_to_logical_xcc(dev-
>>>>>                 adev,
>>>>>                 - node_id);
>>>>>                 -                     if (hub_inst < 0)
>>>>>                 -                             hub_inst = 0;
>>>>>                 -             }
>>>>>                 +             if (!vmid_type)
>>>>>                 +                     hub_inst =
>>>>>                 amdgpu_amdkfd_node_id_to_xcc_id(dev->adev,
>>>>>
>>>>>             node_id);
>>>>>
>>>>>                                /* mmhub */
>>>>>                                if (vmid_type && client_id ==
>>>>>                 SOC15_IH_CLIENTID_VMC)
>>>>>                 diff --git
>>>>>                 a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
>>>>>
>>>>>             b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
>>>>>
>>>>>                 index a9c3580be8c9..4708b8c811a5 100644
>>>>>                 --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
>>>>>                 +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
>>>>>                 @@ -437,12 +437,8 @@ static void
>>>>>                 event_interrupt_wq_v9(struct
>>>>>
>>>>>             kfd_node *dev,
>>>>>
>>>>>                 struct kfd_hsa_memory_exception_data exception_data;
>>>>>
>>>>>                                /* gfxhub */
>>>>>                 -             if (!vmid_type &&
>>>>>                 dev->adev->gfx.funcs->ih_node_to_logical_xcc) {
>>>>>                 -                     hub_inst =
>>>>>                 dev->adev->gfx.funcs->ih_node_to_logical_xcc(dev-
>>>>>                 adev,
>>>>>                 - node_id);
>>>>>                 -                     if (hub_inst < 0)
>>>>>                 -                             hub_inst = 0;
>>>>>                 -             }
>>>>>                 +             if (!vmid_type)
>>>>>                 +                     hub_inst =
>>>>>                 amdgpu_amdkfd_node_id_to_xcc_id(dev->adev,
>>>>>
>>>>>             node_id);
>>>>>
>>>>>                                /* mmhub */
>>>>>                                if (vmid_type && client_id ==
>>>>>                 SOC15_IH_CLIENTID_VMC)
>>>>>                 diff --git
>>>>>                 a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>>>>>
>>>>>             b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>>>>>
>>>>>                 index ea6a8e43bd5b..b5f2f5b1069c 100644
>>>>>                 --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>>>>>                 +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>>>>>                 @@ -251,8 +251,9 @@ void
>>>>>
>>>>>             kfd_smi_event_update_thermal_throttling(struct
>>>>>             kfd_node *dev,
>>>>>
>>>>>                    void kfd_smi_event_update_vmfault(struct
>>>>>                 kfd_node *dev, uint16_t pasid)
>>>>>                    {
>>>>>                        struct amdgpu_task_info *task_info;
>>>>>                 +     uint32_t xcp_id = dev->xcp ? dev->xcp->id : 0;
>>>>>
>>>>>                 -     task_info =
>>>>>                 amdgpu_vm_get_task_info_pasid(dev->adev, pasid);
>>>>>                 +     task_info =
>>>>>                 amdgpu_vm_get_task_info_pasid(dev->adev, pasid,
>>>>>                 xcp_id);
>>>>>                        if (task_info) {
>>>>>                                /* Report VM faults from user
>>>>>                 applications, not retry from kernel */
>>>>>                                if (task_info->pid)
>>>>>
>>>
>
