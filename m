Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B77C02193
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 09:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA2EF10E911;
	Thu, 30 Jan 2025 09:29:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0kJruZDk";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72D6410E90E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 09:29:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qj0KZqu/X9kSEu0FPtj8p6tHZBzya5ibRriAICsPQmrIcz9ryf+DMuO9pR6JVOwiYXwHd3sq0U1rligWdOjBSxi20JaXZoE2yy7KZu6MIoXOIsr68SsozpYiIXh9MDTSYIRjgjYCyRpzF6bD+djTX45t3RpXXHlXs4hwwuFXEHDO37Da9gmV2SwOk2ZjtpyyL2HFJH6fnZZQCGFJMtbyBdvWvHER6rdO6RN+Ei56o2n9KKzlp+MGL47uS+u31LsaKIHctiSPxPQoPaVFBNcCTUVKmiYEbX6woN0k9dFmz8RVsHPZGuNs5B0LfNxM/X9OdO4WjmBrmL+vuPg8hT4RFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/tJFJazeZvttkUrEkAdvNzs0/BKq1oHj1d1lZvQbB8=;
 b=StMS+WtND4ho5+/HS/DgLZkFU6Azs2vqb/yAk54az7xeaVzLUdAe4COfpFAESrLr1eYFd1qXcb4M4ixkt+SHQ5vEV2/Ze8vpr1hb4sF3yipeB5ldrq+SN6HehqO84wIrfP1HYtk3IbcOBOXAwQy6PiniG2pGPCpl+uy8DEav9coLrE2PvPJTTEFvi4r11PyziViDdMDB5IHD5GA0IEjsaW8Xn7qBi0rQDjgPta6jWQ9Q+bvl7P+nrq6AQAVs3l2eyVOvaG39UCCF9wNnoCfQvEhBsslrXtyhAqreC+k3pW7AVZZU+g44wqL4vgJZ0G7XMGW5Am+I4ZZ0N+JGBL/Xzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/tJFJazeZvttkUrEkAdvNzs0/BKq1oHj1d1lZvQbB8=;
 b=0kJruZDk+f0SY0OezKRfhm3U4LyULIbbtTWqB/ye3fbQw1RHTtigR5/RRVIYbzK8X4bLyIwx47/JQ3e2Oyl6c/vkemCazL4vIWjTjyc5Qk0wX3cHf2h/lq/1Bdl2Hf9JCoGHuESOXBg3rZje77r8yFgMEVx9IXoEGz+jTh2J8a4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB7869.namprd12.prod.outlook.com (2603:10b6:510:27e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.18; Thu, 30 Jan 2025 09:29:05 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8377.027; Thu, 30 Jan 2025
 09:29:05 +0000
Message-ID: <fdcfc309-3359-4610-9bd6-688a86976cd7@amd.com>
Date: Thu, 30 Jan 2025 14:58:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu: update ip versioning for gmc
To: Mangesh Gadre <Mangesh.Gadre@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Shiwu Zhang <shiwu.zhang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
References: <20250130064429.2215628-1-Mangesh.Gadre@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250130064429.2215628-1-Mangesh.Gadre@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::14) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: 975107c3-5ba9-4dd4-ef2c-08dd41108a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nmt0NGxNM0RvZnpkMDR6UjhtZVJzUU9DdEo5ZFRxUFptVjVrNDMxaVBxYjI3?=
 =?utf-8?B?TGw3VFZjRTNadFREcy9XWmc5S1I3SXlxT3JBVzlUV0tteXRPUHdNeE1kOE9I?=
 =?utf-8?B?dTE5ZHpaa3lUdTQ5dFFGVTFHWFpGM0tMQi9hTXAzd295cDQwWlN1Z1JPWGV5?=
 =?utf-8?B?TkYzZ3dWL1pHbldYMlplNlg2aTY2cHRxTnlQbVMyM0VSMEZpTlBWTG1lOWky?=
 =?utf-8?B?aDNOSnN4dW5rWERrUmNmZGF6SzQ1MXU3L1NhWUw4b1JyZ2dLbEkxMXBXM0o3?=
 =?utf-8?B?RmFYUFVrUHloQm9lZmpsM056Mmttdkdrb2pZS01FbS8xMnJGWDdITmN5dFBG?=
 =?utf-8?B?ZkZZeTJMVEdRUU1mQnZMSjcwc2lEb2NCWGFNb1BuSXZFeVhZKzdiakFmRUts?=
 =?utf-8?B?dnZjWTBadzhOWXlxT2tZc0tJc0I3OENKWVpPQ0d3enh6ZHpJdkdSekVXejF3?=
 =?utf-8?B?VnFIbzQ1QzNxUTBNN3RqK29lejhSMkEzSi93OFNZQ0xKSm5DSGVQQXhiNXFM?=
 =?utf-8?B?ZVY5U21Ob01iR2VtT01QelBod05jbTlqWjlSekpXVWNpNndqZjVFOG5kNWN4?=
 =?utf-8?B?SFhQcEpUU3FWYnlHSGMyM3Vta2VlNXp6eE5raDBXZDMzajlyZlE5bFhLbjJs?=
 =?utf-8?B?RHorNE9xZmlpTzBtY3B0aDhHenB4TUdRdldZblZmZUQ1RnAxTnp5bmFsd0kw?=
 =?utf-8?B?RWw0TE56dlM4d1lDZ1E3NXNLbnZRT3JxQ2dkK0JQME96MGhEZHNDSEJyMHpJ?=
 =?utf-8?B?K3p6NktjYzJFbUNNSWU2dXdZcHJoa3d1OTBaT0h6cFNuNldGU2dWUXQzYmRv?=
 =?utf-8?B?MzRjWjBQemtPdWlkcG1CMTZBOFlsWkFxczAxRDd3ZFVXY2NoTWVlaS9BRklX?=
 =?utf-8?B?b21IcWdrMUhVYTBUcXVsUlh4aTBvNWdESEkxcTlkT2VhRWZBZWRLZHV2bU5o?=
 =?utf-8?B?bVNsNDN3cmlDczd3MmdyemhVMEF3TkNFdWhhazhFUk1wWUlBdzdGT2djYkp4?=
 =?utf-8?B?MjAybHJvMVdJV1k4NjRTdkVCVDBzSzdkMnV0V3E2UlhJYlo1Qkxaakp3Zitr?=
 =?utf-8?B?cXBHcmNRUVhtZWgzZFRGWkpqY0RRRmVyNUpCenQrcUFYbWpBUTAyOHRjdFRq?=
 =?utf-8?B?bVQ4MVgrcjFJWHRiWW1GcEp4WlhER0UvemZEWW8xREdiejgyT0Nadm5VT29a?=
 =?utf-8?B?MVVnSWlLa2c1YjBRV1hVK3VDVU0xNVFWWGhvckpXRzlDeEFtckk4czJpNkIr?=
 =?utf-8?B?UlBDZVRXOGhHR2RqZk91cmhtVjVuTDc2RXFaU3gvV0k3dUpjeVBXcnladlMy?=
 =?utf-8?B?d0p1VC93YmVhZHZyRXNobnhOa21mQUlJRGk5ZitBenpmRzZwenJ2VWxvTytu?=
 =?utf-8?B?M2lPNHRCN0F6UmRJTGwyVy9zOXpCalFRWmdLR0RRdGRIc3hYUHM1U0pxa09V?=
 =?utf-8?B?K2p5VGF6alJIN0w5djVnSEk4K1FOZTN0K0hqRFJGSWVhT3pHcWxnNThSM2NW?=
 =?utf-8?B?K2JxdFl6V1E1b01MS0dTN3hMNzFjb2thZENiY0R5QXgzUmExSG1GaWtmUExP?=
 =?utf-8?B?TGV5Q25ycityejRJM2xXZHhiTlpuY3FTdDVlemJNL2JLRGF5TEh2dGZvczh2?=
 =?utf-8?B?VXVpMWhhWmlhY3llZ3BrOVQzdVhqSjltQTBtYVhYaVJDNjBXZEhKVjZGaFhu?=
 =?utf-8?B?UU1hTzk2VXd4bG1rOVVaN0t5bkwzY2R6a3IrKzBYWkxMamZEUWZwQVdiQlVY?=
 =?utf-8?B?aVFXUTRocHZucDB1WEh1UG5EaXJ2aHFLSjl0OFFReVI3cFVhaW1iY0dpZVhD?=
 =?utf-8?B?dnhPejB5U2hyWGI0SXZRblNRcHVqSjFiV0JiN1JRQlVXVXNPdlFtczUwTjNR?=
 =?utf-8?Q?LHWPBWgQE12Es?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGUxZGh4eE93TklRVGJBRTR5V1V4bS9LRlZ2b081NUFWb0hZSDRVL1JrYjYx?=
 =?utf-8?B?SjZGekFzYWdaQjBUZWVLaHB6M250R29WYnh0TzgvRmkwbnErSzFhK2Y0L2FU?=
 =?utf-8?B?QlZvS3JEM1BBYVltWDhKVXRxZEZndmI0Sis0dThpaUJKZXZDOG41RmQ2QVBP?=
 =?utf-8?B?Q1NXeDZXOSsyVHdkMkg0bTEvbHhuWXpsWW9jbVlaaUpVbmRObnZoclRzTVJJ?=
 =?utf-8?B?R0gxczMveDlkV2Z6eGJrZUY1eVNXSUUrdFpSUndMQWVMMHpuWWhZWXFnMDZR?=
 =?utf-8?B?WWZaVDh4SDZPT1d6bXNtQUNRZ21jalQrWDBFenlwYjBxNm9LOU1oQlZrTnpv?=
 =?utf-8?B?MzQ3Q0Y3TlVPWVBiZG16UzNONndVcW1zZmMzS1VFNktZakZEUDZiQi9xaGti?=
 =?utf-8?B?eHBkUVZtc0tzQ204SHRoc2dPdDZqUysrRExDaTA5VTE5Zzk1ckp2L01pR3hW?=
 =?utf-8?B?SkU0YVQ2OVVJQjVCMEJVdkpjOVpmcVF2OERZZnFxOWhzS0c5VkYyL1ovTm1v?=
 =?utf-8?B?THZodlMwZTBmVzNyUk8xdVF2MnVkNCsrSnprV3BzUStva3l4YXJPNVNlZXBL?=
 =?utf-8?B?VERFaE91YzdOT3VFMEhZZXJPbEQ1UC9TZDBZM3VwVXhoVFd3TVl1YjFRaEI3?=
 =?utf-8?B?bGdpcFc1S1J4cVp4dElIWTEyUGsxUk8vbE5uc1pqWEEwMTZtekZzRkNIU1Nx?=
 =?utf-8?B?elljZG5HbTZWMXpCcFdsdDRMaGViY0NDT1l0U3I4dkgyR2thcitnSlFVaUdC?=
 =?utf-8?B?dmlGek9mZU5JdGFQbVBobmx0TUx6b0duNFpoSCtZNVk1Tjk1OVJMR1FvNTRJ?=
 =?utf-8?B?MmJlOGVYeGpwMWk0eU91ZzlKNmN3c29aUmg3Qnh4UnlxWHQvKzN6VFUrNlky?=
 =?utf-8?B?Y0VaUWl6dDNKUmZ2Q295TUwvZk1OcktJVmtpRldMS1cvSG0xY3BQWTJjV3Ay?=
 =?utf-8?B?RFVrbGRYcU9hOWhDVDhWYXladUtEWEc5WllGNzZWRUJrVTVSbEYrWXYvc2xn?=
 =?utf-8?B?dVZLbzN4TFBFdmg3U2hoZUVMVytKRGF4Rk14b29veEVtT2wwL3U4NmtvMGFB?=
 =?utf-8?B?aUIxSDk5b0FoL0Uyb1hTcFVJM212MFVvU1paYk1MMFh5VGlRankxVE9YMTRl?=
 =?utf-8?B?U2Ryc3Q1TFhPZkZlMXdUTytXUDIyV09neHEzeS9DRkJSdlpKZ0drUUdYMFBX?=
 =?utf-8?B?WUtjRjZkRHRZb0RqdmpaVU5WcG03a1ZyL0ZwY2p1aStLK2htWXZ1TVlqcGJB?=
 =?utf-8?B?Tm1tMzBsY2lMRHA2RFY3VG1yM1dyQXZ5YlhLOFVFZldTV2xRZ2xadEI2NmhW?=
 =?utf-8?B?ZWNoR0ZMT0J1bk15dm9aem1rd2RWamRKN0JxcTgrQlJQemE1S1V5WG5JRzZD?=
 =?utf-8?B?TWl1UFhlZXdyZFR6VVM0L2dPUzdrblNzekdoTG12bEJ5UE1tSXNPYlhQbUtp?=
 =?utf-8?B?SmhtVTR5cXpRNitGZXdGYVl3QWMvallRWjM1cXA4NTBFc0JKZ3VPUC9wYkhO?=
 =?utf-8?B?dVNxOFdUSFRMdGx3czJSSDZDc2VGTjdsQUdTcHZNazN1ekVkcFVMQy9iNjdD?=
 =?utf-8?B?eE9QczFxTTdzSHhoaG00QnRyVTUzZmxOQS9USy8yL3haTXVQVllQeTlaWnhp?=
 =?utf-8?B?M3lRVmhlWnphL0wzMVlSMldDSnVEZVhubGlmZVVuaWU2ajRUMWRLY29NS0dq?=
 =?utf-8?B?ZklYUXBTVmswL3JvYWtCbTV4TXpCM29qdU4zMFBBc3VHWExMWTg4V0FSdFdR?=
 =?utf-8?B?Q3F2eFhFR0RWaG03Y1ZSQUN4N2tlNjd6dWFtQlBMK0V6aHBMMG0vY0Z0dnp3?=
 =?utf-8?B?TnFtVUtzOUMvWENkUVlYMVd0eTN4cEVVMUNDOVN2NFJ6SzcvdFhQQzdXR0Vl?=
 =?utf-8?B?bFc5TW0vTmIxOXhVc1BpVDlaQlcxNjVxYk9mSEt6N2xieFczVzZzRlJVY3Y5?=
 =?utf-8?B?S0ZXZXNEaHZZK3hSYkVBTWhzSWUyc2ZtdisrczJQeWxGNUJnTE9iL2RQWU82?=
 =?utf-8?B?S2UxS1RiY1owWFFXR0dSOXpmbmFNQWtZWVk5MEh2d2p6NnJvaUkwU0tSKzZ6?=
 =?utf-8?B?OTlyUHlZYkQyMFpFa2dCN2xzVUE1R3I1VkQxeW5ISnRDbG5qbk9WVFQ2dHpF?=
 =?utf-8?Q?o52z/2/WYihjhKiZpGJEOOHzA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975107c3-5ba9-4dd4-ef2c-08dd41108a4d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 09:29:05.5591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEEiFJ7yXFVkcngIl1vMafU2DFqsbZNCN3M0+KN4eZ0CPngwauOVpwIDzL7BhuLQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7869
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



On 1/30/2025 12:14 PM, Mangesh Gadre wrote:
> support gmc ip versioning though ip discovery binary
> 

Suggest to rename subject as -
	Add support for umc 12.5.0/mmhub 1.8.1

Same for other patches in the series.

The description may also need a change. Could be in the same lines of
'Add new IP version support'

With those changes, series is -

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo


> Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
> Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 71b8ae7f2194..31c4eb656d98 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1498,6 +1498,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
>  			adev->umc.channel_idx_tbl = &umc_v6_7_channel_idx_tbl_second[0][0];
>  		break;
>  	case IP_VERSION(12, 0, 0):
> +	case IP_VERSION(12, 5, 0):
>  		adev->umc.max_ras_err_cnt_per_query =
>  			UMC_V12_0_TOTAL_CHANNEL_NUM(adev) * UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL;
>  		adev->umc.channel_inst_num = UMC_V12_0_CHANNEL_INSTANCE_NUM;
> @@ -1523,6 +1524,7 @@ static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_device *adev)
>  		adev->mmhub.funcs = &mmhub_v1_7_funcs;
>  		break;
>  	case IP_VERSION(1, 8, 0):
> +	case IP_VERSION(1, 8, 1):
>  		adev->mmhub.funcs = &mmhub_v1_8_funcs;
>  		break;
>  	default:

