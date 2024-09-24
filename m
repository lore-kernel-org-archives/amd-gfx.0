Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405D2CF9C69
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 17:48:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC00110E8D9;
	Tue, 24 Sep 2024 17:48:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1hDIF9Hs";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E31210E8D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 17:48:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UwLDRR3Z2xOOVcyW5T4k/JNUHum5oAoaNlx3rD3nf+Fw4YkBlZ4Uuhhe90qHBNZm33jCAie2+zM+wKI4TE5afU9rogC18Kt7Ou08CDc1FumTLfHC1dQRdRNBl2CGJNryVPX26q61UkRRlGvnL/YMhkNjy0Y/A5GUw4aiq5ISIVHXmulsQ2ZtD/CGRVPUSOI9fN0ARxDl5GEe3ACQKwjLKqoZQJs3yDgkvjnnqNrUGZciz4JzXlCY3+77Bd6OEIB5J6rAfttXlTsD/qNqotCDCDJy9EYINOBiYBOBxvmzyV7eB7YolOqO+OSG7A6RRMCCvSzur8K+kq3x5Fgi0AKsMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAY+mWfNIA98vLisLPDqi/P8FH2oLwrXUyr4kT2V3gE=;
 b=nH7cxbMz8d4JoDZMhf1fjm8mPdpWYi9Hz5Ymsptrr03mI7lA+umLRYqSOlG3H/YJPqglfL5ln3b8AaKntQGVC+H7RPuj4OhxXW1HnuvWmUhhwJf9JRfJ5tV9/iqqtuVgJgB2pA6/RpXs90SZSdN+mc7zz1vMasZ9zvcbjIofoLDwc+TT9VOvh/VCFf32WCZX9H40l7m6VLsifmIcHQEZhQXc0AnGu/nmUycTB9R/tm6KnhHUH4bkSTkUu2gmMroBsVA9xwHjUxKSZQ5zzS18TVVgO0kJOgosw1ctrSGdgVDi2v+RB8pY9p8C8w13J5guNU9mc9YMyeZNX0g5pURgiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAY+mWfNIA98vLisLPDqi/P8FH2oLwrXUyr4kT2V3gE=;
 b=1hDIF9HspcfqCleK9pFSjeAVOrkF/nuw6etVGE4qVk2Lj4BdJ0c2sLXikJ8BdGgzx5tzfkdY4DPbim+bJgdVSTC+RTTzxy2zYySvVI2RwRgIb/rqp3fNdOhFt9O7yPppbr9qebYRhjB/3iCso+st91DjCvigLR5uzzhX5RQEiWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) by
 MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.26; Tue, 24 Sep 2024 17:48:26 +0000
Received: from DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::6f01:2f45:71e4:653d]) by DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::6f01:2f45:71e4:653d%4]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 17:48:26 +0000
Message-ID: <e6d8e4b3-9348-477e-a5ab-1239ea8a1968@amd.com>
Date: Tue, 24 Sep 2024 13:48:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] drm/amdgpu: Add sysfs interfaces for NPS mode
Content-Language: en-US
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Ramesh.Errabolu@amd.com
References: <20240924055652.2678433-1-lijo.lazar@amd.com>
 <20240924055652.2678433-5-lijo.lazar@amd.com>
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
In-Reply-To: <20240924055652.2678433-5-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0004.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::17) To DS7PR12MB5933.namprd12.prod.outlook.com
 (2603:10b6:8:7c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5933:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc14e17-d034-46c7-74cd-08dcdcc11768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q29jOUpyaEpydHJaR3ZGTCt5dW5rN01kbXA1amtKV09WQ09tTXN4Q2t4QzRP?=
 =?utf-8?B?TlZLck52YUZKdEk1bXlqb3kwNC9Wd2xBczRiRVRBSWh1STVpZVdrOXlaTXBY?=
 =?utf-8?B?MTJqKzZWTmJ4TmF0SWN6RGpVb0tFcW1uQ1hxc2tDNys5U0paZmozR1ZCWlVo?=
 =?utf-8?B?N3BDaC91ZlVSeHdmZWNLOUt6dTJMUDBscnhWcmo4Ylp4ZDgvL0RaSTRZVmxJ?=
 =?utf-8?B?YnFQWllBTG0zU3J5V1lPVkU0aTBVUmlPOVEwQWVXN3gweWhRYzUwMXFxTjBC?=
 =?utf-8?B?N2JRTVl0L2Y3dW9BVGt1WTJlK3VYMWJDNUs4MHJxdEdZYktOY3NTK3N6WWE0?=
 =?utf-8?B?TVI0Q2g1TGRjMTRaSUU0emFQODZIcXU5dFhUTVhiODNCbGR6RnRGektWRG9o?=
 =?utf-8?B?cC9IQ3ZObVExSmJqM0lyQ1BzLzdzQ0F5NkN6eEwrNkx3VVkyVXdyelUxTlNM?=
 =?utf-8?B?RGhLbG5hVThjZ2VBMUxhUU8xUjVhV1FMYUtqQlB3bnBZT0pWclVYTXUvSGJo?=
 =?utf-8?B?VlhBWThuc29jV2gyZ3djK3pNZ0JxYmtDOFo2YjNZQUMwRGlNdzVYNEcycG1Y?=
 =?utf-8?B?bVZibWY2OHd3dlJzYjBGcHArQTVlLytXS1FCZWs5a0Z2N2EwZzVRZGMwc3Yw?=
 =?utf-8?B?L2k3cDhJRzRPUnMxaTZzV2FlcGRoMFAwT2hSckZwdURGQnR6dHE4L1A1dkRV?=
 =?utf-8?B?YTdFSkRreG5CZzVGU3NwQ3BZUmJkYm5XZUo4WGt6RCtoWFNRMHNLRFhZTy82?=
 =?utf-8?B?d0dXVis5VzVMMURsSkljcnFEUTdTbDBNLzR4UXNWYU1hcEdRenJBSHBHUmU4?=
 =?utf-8?B?Mis0Y2RKb3JGY25maEY3aElHRmtBWmdXMDdwVFY5Y3Q1Y0RnK253RzBDUUxj?=
 =?utf-8?B?bTcrczIzVnRDZjJQN2lqdnJCdEI2bFlaTVZYY2c3WThZdkNYeXJMYVZGQk5n?=
 =?utf-8?B?NjAwSFFUb3B5a1E5eGl0dnJoU1RxdUVlOHJqeTVKakoxT2szR1hrRzJmTVZG?=
 =?utf-8?B?TjUyR2xyQmxNMC9INTBLWFIrNFhaam9qUkZ3L2UvZjJkKzFPSUZNaVJ6N3F3?=
 =?utf-8?B?Z2NjYTByaUtEcGJJcmQrWWRTeElleFhFcEVQV2RvUkIwSUhlVHF0WkwxTSt6?=
 =?utf-8?B?c084YUg2dVk2cjNEVWd2K3VvYUJzb2pIM0ZydHo3RHg2OXh5eFIwVFRDbHRj?=
 =?utf-8?B?YnZmMlFjMnNXMmFNNkRZUHAwY3h0b0k5K3pHUjdkcE1PRTl6NExoeWVzMVRi?=
 =?utf-8?B?cVh6aGRhdlhzaTRpWmcvK0VOMTQ4dHRBemR3SFlabkF1ZTVMSzd6YXozOWxz?=
 =?utf-8?B?SmEwK1MweGUxOUxsczZoZE9ZZFF1blVFR3dUNHB3N2lMNzhNS0k0VHAwMWhF?=
 =?utf-8?B?Mzh4NnFZeHA5ajE5N2Z3TGtuUWdhNVlKb3lpc0s0Z2ZoQnlmdE8vdGJUZ3Ru?=
 =?utf-8?B?cGE1NGVZaE1tNUFwN3ZTVGlHMkVGWEI5NE82WFpGQitYUHNqelFlVStQdVgy?=
 =?utf-8?B?bk1ReEhndlVHNGs4TmMvMTZBVzhORm9Xem05cjNSaUhsY3cvYVpQTFdmL1BB?=
 =?utf-8?B?R1J0c1RqdTA4Z2toL1ZLdmtCbGdtSGhCb0tFaXBoTkdReVZjMm5jY1hzdUg2?=
 =?utf-8?B?dVljMnZRSWp4MlpyNmhpMGQ5WmRIcWJlUUJmVVNjb05TU1lOQ1Rjblo2YXV5?=
 =?utf-8?B?M2M3YmUyZXRxdnBoYVJ1WWsyaDNPbnNZTVZyNkV3ZHFVYWFWKzhMc1psRm5P?=
 =?utf-8?B?TDVXODdaVmJqSWVzQkdHbjUybUM1dTJZZEhxYk5RVVdJb01GcUFqand3WDBi?=
 =?utf-8?B?OGZKdzRlRHVZZnQ2RVRWZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5933.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjdZNzRtL1JXU2pOWklkR291cGhVY0h2cEFPRWI1QU5sYlVmZUdEVWdzSGY3?=
 =?utf-8?B?WVc2c2paNHZHZjcyU21uNUNMKzlFOFNhM0ZTaWJBNHV0UnBxL2tiTi8xTzU3?=
 =?utf-8?B?UFA0Zk9DZ0VsUmY1ejViVEtsSjE2emc2LzV4TlVVV1hkTVFmMm15Mk9yU3Uz?=
 =?utf-8?B?L3NSSDRtTW8yekF2MEpkMkdPQWJEbWdyeFdPQ25pN0V1U0Y5WjJCL0FhTUt5?=
 =?utf-8?B?OWZCaElSbkxqenppbkRlL05nMW5FVlFjOE5oUnNNTkFkTE1OVHVCQWdCK3VX?=
 =?utf-8?B?OW9QNUFNL3F6SDRmTHBRaDdMRXV2RTlTTDQxbVIweTJsU2ZvMCsyNXVHMDMx?=
 =?utf-8?B?MHlSb2tocWdvZ29uNksra3FiYU0vSC9FOGdZZWV1VDREZ1NxUTBjd29PdDBG?=
 =?utf-8?B?TURlQ0JhUkpsd29GMXpLSFFudXpMNEp2cHF2Mjd2cG9uWHNtaVBCYWpSbkRG?=
 =?utf-8?B?eXZ5ai8wRDRWeEx5eFdpNUpDMzVDQWZmV0d1ZVhsQm5DQkZlNUpPOWFrSjZ4?=
 =?utf-8?B?bmprN3VSVGg5SEkrOWtLSFFEcG9TZG9QZWFhN3NGZUNlaVJZbjZwZG9TNXVY?=
 =?utf-8?B?c0EyVVV2YkNHdU5GVWtXMEowNWlTcWk3dExTOG81TkpYaXBneEFuT1BoSkV2?=
 =?utf-8?B?V3A1SWJ6T1dlMVgzU2JOclduM1d2ZGgzdVVCTFFkUU9HQ0poR043Nk9yaGRG?=
 =?utf-8?B?VDJvQVROY0FSa0l1NVNoK0xjN28yaWM4TWphWmVvK05lY2dnaTRpSmhGOVpy?=
 =?utf-8?B?cUQ2Mk5oeGlUNHMreFNuNGhTUExsRVBlRlg1UDJxWjRaT1g4Y28zOTdjMklz?=
 =?utf-8?B?Y2JKRk9nbnFwUXoyUFpPNkswWjlSNFl2RFphbG9vRHBaclA3N0dBYS81aDBK?=
 =?utf-8?B?Z3VyZno5TitVeWYrY0xPT2ZKcEhpb29Va2RhUDBUaGcwQVVaQ0ZRd3ZmOVJF?=
 =?utf-8?B?YXZ0MmcySGh6Q3djMFZuNWxWN1l3ODI3c0tGM2R5ajJIajhaSjdVTU8vcUph?=
 =?utf-8?B?ZjNzV0ZzSmM0bFB5VFdteVNsTHVnVUhkbmp2VnFTdXVPWjgzZ1JmdTZ1Wmxt?=
 =?utf-8?B?dmJDamt5Y1hQaXN6cnRnZ05BKzBMOWcraVUvNWlya1pncDQwZ2M2cllSeDRv?=
 =?utf-8?B?NnZBRGVoZ1M4NnhUcVVQME5tUEFtTlBEWnAwbmdQSG9RTnd3UFpVejZhb0No?=
 =?utf-8?B?US9ROVNIQjgyUUVsUGt3d0NoV0hBMFNzbmF2Z0tIcDloVVZpOTZrc0ZMeVVw?=
 =?utf-8?B?QzdQQUlGVHIvQ0hsQ1doSzd0aVNpOTIyejA1MHMxTmNMaHNaalZOWXJ6ZTVz?=
 =?utf-8?B?c01kZkJVUFI4ZXdQQWptRUtvN3hOSklycTVMdFlDbWoyRnQ4RDRPeGNVR3Q1?=
 =?utf-8?B?WS9xODFOVWxVMUFZYlJrS095aGV3bk5VZEU3d2FGUnA3TWcwREZjTml3bk4x?=
 =?utf-8?B?Q0JPbEJZZUpuVG9OMTdFc2RWUmdaMU9hbnB0NXZCQXZvS0hWbXNtekNlRTc0?=
 =?utf-8?B?Kzg4MFZhc21EMU5pTGxMWmJ1UVFhYjkzNmVvVXhPb29uNUFLZmQyOEFDanIy?=
 =?utf-8?B?N2hMaGNUU3EyN1NjK0xkV3BhNkNqL3BtTXBDOHJleGE1Qmw3S1pkcTFsOU5D?=
 =?utf-8?B?cnVWYzVHK2l6QlRBWVVVaXpUM0hvQTh4RzFNUWU1bjJoQXlSUlY4eWtuZ3lI?=
 =?utf-8?B?VHkxZ24vNkNYRUlxMklDZUNtNjZCVHA5d2NWanBmcVh6ekp5Q05ML3RzQkpo?=
 =?utf-8?B?bERIa3lFajBnalJuRnlEL3N6bmIxRkVRQkliajdLSkpKWlVwemFqbFFqaGZW?=
 =?utf-8?B?T044YlQ0djNsUDI4K214VzRwSGJnejNLRTZoVGRTT2tGMGlsODN1bFp4cDI4?=
 =?utf-8?B?bzQ0TmRwaUN6V1R2YjJJWWhQdU1lclJoeGd2MXNOb2p0WlJqQk15MDZYb0FK?=
 =?utf-8?B?V00rblE1V1ZTSzR2OG01TDB0TkwvQ3kwMHFhUzVPRWlNUXptOUN2Z2I4ZDNW?=
 =?utf-8?B?NWJKWXRpaE5wN2NaTjArclpyamkrWG5PUmJXRm1vd0hpekdJblNOcDFGYVE2?=
 =?utf-8?B?RVRPdWFPTzBOTkg0c2U4NncwcVNMZUZTWjE5b2RRdHRkYStpaGRHUGcxZm1S?=
 =?utf-8?Q?5nsP5/cAvmepc+t3xiqL7EbIH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc14e17-d034-46c7-74cd-08dcdcc11768
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5933.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 17:48:26.0474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OW1omt2erwE4bJ1043Zdmm4yHANfSYgo3krqisu1INzKOXaUOtbcpbAPq/LjSHLYn6iLAqUr+3I4fRYgKr3lAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898
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

Reviewed-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

On 9/24/2024 1:56 AM, Lijo Lazar wrote:
> Add a sysfs interface to see available NPS modes to switch to -
>
> 	cat /sys/bus/pci/devices/../available_memory_paritition
>
> Make the current_memory_partition sysfs node read/write for requesting a
> new NPS mode. The request is only cached and at a later point a driver
> unload/reload is required to switch to the new NPS mode.
>
> Ex:
> 	echo NPS1 > /sys/bus/pci/devices/../current_memory_paritition
> 	echo NPS4 > /sys/bus/pci/devices/../current_memory_paritition
>
> The above interfaces will be available only if the SOC supports more than
> one NPS mode.
>
> Also modify the current memory partition sysfs logic to be more
> generic.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 114 ++++++++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   6 ++
>   2 files changed, 104 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 758fda4e628f..24a1f931d9ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1130,6 +1130,79 @@ int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
>   	return ret;
>   }
>   
> +static const char *nps_desc[] = {
> +	[AMDGPU_NPS1_PARTITION_MODE] = "NPS1",
> +	[AMDGPU_NPS2_PARTITION_MODE] = "NPS2",
> +	[AMDGPU_NPS3_PARTITION_MODE] = "NPS3",
> +	[AMDGPU_NPS4_PARTITION_MODE] = "NPS4",
> +	[AMDGPU_NPS6_PARTITION_MODE] = "NPS6",
> +	[AMDGPU_NPS8_PARTITION_MODE] = "NPS8",
> +};
> +
> +static ssize_t available_memory_partition_show(struct device *dev,
> +					       struct device_attribute *addr,
> +					       char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	int size = 0, mode;
> +	char *sep = "";
> +
> +	for_each_inst(mode, adev->gmc.supported_nps_modes) {
> +		size += sysfs_emit_at(buf, size, "%s%s", sep, nps_desc[mode]);
> +		sep = ", ";
> +	}
> +	size += sysfs_emit_at(buf, size, "\n");
> +
> +	return size;
> +}
> +
> +static ssize_t current_memory_partition_store(struct device *dev,
> +					      struct device_attribute *attr,
> +					      const char *buf, size_t count)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	enum amdgpu_memory_partition mode;
> +	struct amdgpu_hive_info *hive;
> +	int i;
> +
> +	mode = UNKNOWN_MEMORY_PARTITION_MODE;
> +	for_each_inst(i, adev->gmc.supported_nps_modes) {
> +		if (!strncasecmp(nps_desc[i], buf, strlen(nps_desc[i]))) {
> +			mode = i;
> +			break;
> +		}
> +	}
> +
> +	if (mode == UNKNOWN_MEMORY_PARTITION_MODE)
> +		return -EINVAL;
> +
> +	if (mode == adev->gmc.gmc_funcs->query_mem_partition_mode(adev)) {
> +		dev_info(
> +			adev->dev,
> +			"requested NPS mode is same as current NPS mode, skipping\n");
> +		return count;
> +	}
> +
> +	/* If device is part of hive, all devices in the hive should request the
> +	 * same mode. Hence store the requested mode in hive.
> +	 */
> +	hive = amdgpu_get_xgmi_hive(adev);
> +	if (hive) {
> +		atomic_set(&hive->requested_nps_mode, mode);
> +		amdgpu_put_xgmi_hive(hive);
> +	} else {
> +		adev->gmc.requested_nps_mode = mode;
> +	}
> +
> +	dev_info(
> +		adev->dev,
> +		"NPS mode change requested, please remove and reload the driver\n");
> +
> +	return count;
> +}
> +
>   static ssize_t current_memory_partition_show(
>   	struct device *dev, struct device_attribute *addr, char *buf)
>   {
> @@ -1138,38 +1211,47 @@ static ssize_t current_memory_partition_show(
>   	enum amdgpu_memory_partition mode;
>   
>   	mode = adev->gmc.gmc_funcs->query_mem_partition_mode(adev);
> -	switch (mode) {
> -	case AMDGPU_NPS1_PARTITION_MODE:
> -		return sysfs_emit(buf, "NPS1\n");
> -	case AMDGPU_NPS2_PARTITION_MODE:
> -		return sysfs_emit(buf, "NPS2\n");
> -	case AMDGPU_NPS3_PARTITION_MODE:
> -		return sysfs_emit(buf, "NPS3\n");
> -	case AMDGPU_NPS4_PARTITION_MODE:
> -		return sysfs_emit(buf, "NPS4\n");
> -	case AMDGPU_NPS6_PARTITION_MODE:
> -		return sysfs_emit(buf, "NPS6\n");
> -	case AMDGPU_NPS8_PARTITION_MODE:
> -		return sysfs_emit(buf, "NPS8\n");
> -	default:
> +	if ((mode > ARRAY_SIZE(nps_desc)) ||
> +	    (BIT(mode) & AMDGPU_ALL_NPS_MASK) != BIT(mode))
>   		return sysfs_emit(buf, "UNKNOWN\n");
> -	}
> +
> +	return sysfs_emit(buf, "%s\n", nps_desc[mode]);
>   }
>   
> -static DEVICE_ATTR_RO(current_memory_partition);
> +static DEVICE_ATTR_RW(current_memory_partition);
> +static DEVICE_ATTR_RO(available_memory_partition);
>   
>   int amdgpu_gmc_sysfs_init(struct amdgpu_device *adev)
>   {
> +	bool nps_switch_support;
> +	int r = 0;
> +
>   	if (!adev->gmc.gmc_funcs->query_mem_partition_mode)
>   		return 0;
>   
> +	nps_switch_support = (hweight32(adev->gmc.supported_nps_modes &
> +					AMDGPU_ALL_NPS_MASK) > 1);
> +	if (!nps_switch_support)
> +		dev_attr_current_memory_partition.attr.mode &=
> +			~(S_IWUSR | S_IWGRP | S_IWOTH);
> +	else
> +		r = device_create_file(adev->dev,
> +				       &dev_attr_available_memory_partition);
> +
> +	if (r)
> +		return r;
> +
>   	return device_create_file(adev->dev,
>   				  &dev_attr_current_memory_partition);
>   }
>   
>   void amdgpu_gmc_sysfs_fini(struct amdgpu_device *adev)
>   {
> +	if (!adev->gmc.gmc_funcs->query_mem_partition_mode)
> +		return;
> +
>   	device_remove_file(adev->dev, &dev_attr_current_memory_partition);
> +	device_remove_file(adev->dev, &dev_attr_available_memory_partition);
>   }
>   
>   int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index f5be5112b742..1a50639a003a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -73,6 +73,11 @@ enum amdgpu_memory_partition {
>   	AMDGPU_NPS8_PARTITION_MODE = 8,
>   };
>   
> +#define AMDGPU_ALL_NPS_MASK                                                  \
> +	(BIT(AMDGPU_NPS1_PARTITION_MODE) | BIT(AMDGPU_NPS2_PARTITION_MODE) | \
> +	 BIT(AMDGPU_NPS3_PARTITION_MODE) | BIT(AMDGPU_NPS4_PARTITION_MODE) | \
> +	 BIT(AMDGPU_NPS6_PARTITION_MODE) | BIT(AMDGPU_NPS8_PARTITION_MODE))
> +
>   /*
>    * GMC page fault information
>    */
> @@ -308,6 +313,7 @@ struct amdgpu_gmc {
>   	uint8_t num_mem_partitions;
>   	const struct amdgpu_gmc_funcs	*gmc_funcs;
>   	enum amdgpu_memory_partition	requested_nps_mode;
> +	uint32_t supported_nps_modes;
>   
>   	struct amdgpu_xgmi xgmi;
>   	struct amdgpu_irq_src	ecc_irq;
