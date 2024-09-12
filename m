Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DF4EEE241
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Sep 2024 19:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43D4610EBE7;
	Thu, 12 Sep 2024 19:45:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JbKqrO1u";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98B4A10EBE7
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Sep 2024 19:45:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+98mEwKQr79a+veyuBmz/4fk1iPSdP3+R3kKaTcYAQA1QuiQPCxtWOLi8sqsvxg9nzEWUQAccpsnshdFv6DmhdlfBxj4d1tFZr1A+fLKwLgWvZ1bzNZQLID1zeTPzOovXNZgg3BhBONoUDA5AGAlS75/G7BZinjhU2fd7hlYr24EHhwTlgRKvndx6dfQ0CV5VFJWFLJUiJFixJ5zlvmd0EUHLGkVfp3nC0a0Rl4rKJoXLnhpDVobVh1obSiCsqAnbxdabmRONCOcsQsdXhIBt++z8rGVsFAJe3bei+q2lHVWnKnGLBF9ERYuCywu0e3Cm1nnT/NG/9CXkOcwMXJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqf8yBNU6VMxI8fDMod8ZTa3Q0J0XxLKXAbzCHL/9Ls=;
 b=VXnx3OQW9Tu3j3Yn7dFfC4eXXMr67MbU7uWu2EJi/qzq4DdMdycqjAn4QwgPxtyG61cS7FaDzDqV2T1XHeF7N/vm1a26o3ibgjCfsinTvFn1sqWWHIITEyEPNRjq1BL4k6ZtUyoeX2d7vj7Yuan6ke5nXxuAFhJCVq6/EldQnUrGezIHqH/FKM7ROaeDFiIlsu6oIPszSk4/to5UiqGr69BHZHVZ843AbtK5JhJLrN4OxwvtwkO2skUV9M/pp4yOK1WRh/9K3ewKckIh6K6xi3SX2RKtoyc9DX1Ap/v4qzYBGvpvA7jOIb23rPEg7dhjf5Q429F+/8oE9/XZzEpKIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqf8yBNU6VMxI8fDMod8ZTa3Q0J0XxLKXAbzCHL/9Ls=;
 b=JbKqrO1ukghyp0AAcXqjWtirBQfoWKuMQteXDl44a170OUR7X3aoGkl+HkoazcDlPJ+SrGpXakMdbJQlmEsinlwSZheUM9MqhBrE9yuvnsMOtarcNc+dJBCI7oKPtOI35DeOcR7I9ah8MzHA6myBNUIw3yTeH2GAjS+JY/QvV3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17)
 by CY5PR12MB6479.namprd12.prod.outlook.com (2603:10b6:930:34::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Thu, 12 Sep
 2024 19:45:05 +0000
Received: from MN6PR12MB8470.namprd12.prod.outlook.com
 ([fe80::9559:954f:41e5:5d32]) by MN6PR12MB8470.namprd12.prod.outlook.com
 ([fe80::9559:954f:41e5:5d32%5]) with mapi id 15.20.7918.024; Thu, 12 Sep 2024
 19:45:04 +0000
Message-ID: <b2ec1897-3253-42a5-aada-bd74d1fa6627@amd.com>
Date: Thu, 12 Sep 2024 15:45:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gfx9.4.3: set additional bits on MEC halt
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240912192408.2382609-1-alexander.deucher@amd.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <20240912192408.2382609-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::15) To MN6PR12MB8470.namprd12.prod.outlook.com
 (2603:10b6:208:46d::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR12MB8470:EE_|CY5PR12MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a0ab08-38a0-4481-0f9c-08dcd36365f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2Vtc2x4WktTcE82TEZBOFlyaDFwN0FNZTFmR01SMXpMeVFMSm80VFdpVkZX?=
 =?utf-8?B?Y3pKbllKYmlSS3pzNDBKRys1WHNYdVpGWUdQQkM0Z2RMRG1mR3k1eGZYZkxX?=
 =?utf-8?B?NTR1N05jYXZaQUhzWjA3U0VIZEFTcmdqTjlSN3JOMHAyZk1xUW9mdllKOHJ0?=
 =?utf-8?B?V2p6Z0ZmUklvdmhURmNYSkR1MVNVeXVFQUpaN01TbEdNZVpkcVRvUmpQTFNF?=
 =?utf-8?B?c1k4d0pjQ09wc0ZvMkIzNTg3b3ZNem5uWVVYR3MzQWNMeVB6ckJ1Uy93Smoy?=
 =?utf-8?B?dkdjRUw5MWdLNjRBcXBnRG81bW9rNjJpUTFsS0ViMFJpV2VUUFVPRG44RS9X?=
 =?utf-8?B?azZleUE0RFZOVWVHUGk5N3lQRS9oZjhROWZCZnoxZVpLblQrdmtZOVNjVW1B?=
 =?utf-8?B?OThOWUtpRWFXK2p3MkhkWFVlWjhBWVJPd2ZXQUp4S1ppTUcxM1ZURlBjaDhV?=
 =?utf-8?B?ZmdxUVJHMlJ4M2F0NmJpdGJCVXZzZnUyUWFURnNvY2dNQjREOFlQNzYxZHNu?=
 =?utf-8?B?LzUwa3ZZRWE2bTYwa2p5clJKYnF1ZUtEUkxHdHlIUUNkQjJKb3paOERxOXNK?=
 =?utf-8?B?NzkyZjFMWDdJSjBrSGRaZk4yN3UvTkVyOVVzZ3hpenl5T1UxVWErUjNseC9v?=
 =?utf-8?B?WFloT0VmVkZITW9UWG83N3A0NE9TQ3U2Z2FUcVQwL2tCZjhQd3czdjRrNkFW?=
 =?utf-8?B?bFFMUXNQZlJpTkhRYy9zRUpBUmd6Yk5jbjh5clZsVTZOdG1lQVpKTjlQMzU0?=
 =?utf-8?B?QzhXRjQ3ajN5ZUNWeDdYemNpVGxiWHYrL2VJMTZCTmN5Vlh6M0hmckgvOFhz?=
 =?utf-8?B?NnZ1MyttcEZJUytFd3lVWVprY24rZkgvSFYvKzBQWFd2MFZhVkE2Ylp1dTdl?=
 =?utf-8?B?L1Y2OTNmRVBmcStMWVBiTGR4dkxmMm5EU0pmb0p3Sk9zRnozTFZpSk9Eb09p?=
 =?utf-8?B?TWVlVENiS3VKWFpqUGcvdUVQN2tSV0plYWhjY2xScS85SWc2ZCttdHBxazF3?=
 =?utf-8?B?QVdiM2VUOFoxdExJTnBLRkhuV1JNdWNaSlozOUpMcnpMSGdleEtJVmx1N2VK?=
 =?utf-8?B?VFhGWFpDa05CcW1xcXVUenUxaXVsUnRvekhIRzcvUTdXdGh4MEVKYXpxamJN?=
 =?utf-8?B?TElvZVFkZWZFaVZQN3JjbjNFV2g5VGlPTS9yTUNoSm5zTHB5eElURFJVMkQx?=
 =?utf-8?B?UHk3SzlWVFlkeEFkb0wzaE12T3RDbGtQOXBTTlVYWGtEZUk3dGJ3TG5OQnpT?=
 =?utf-8?B?RlRiNk9RRW0xcTFkYWZKQkk1Rkk4dDdXRnpLVTFieWRTYzBjd2NDQ0V5dnpQ?=
 =?utf-8?B?dXVZMXlLZzJWTmFYcmxRUW02UW1ZUXJqeXJ1eXNWVmtHc1V6N29VSDU2MkNQ?=
 =?utf-8?B?RXNRSXlRc2FmVTNYbk1TR0ZNTUtKVHhsS2NBREU4VUxqTE5NVEhCNmVSZ0VR?=
 =?utf-8?B?QTlTL0pmRFZTZ0k1TndQUUVBTENzVjcyNjduVEVjUVlCaUZqclFoaUtMUUNz?=
 =?utf-8?B?ZjhZWWsvMzl1ZnpPRDZBOEV4NDRjSVAvTzcydlB3NjNuL3NzRE9yOVVTUWVn?=
 =?utf-8?B?QXVKODd1T0RPWVI0dUZYVDlrMVhwT0ViOHBkQUxyVml0SUFPV1FNay9YejBj?=
 =?utf-8?B?R0dxYjZLQVl4dk9mVjRvVXRiTU9nM1ljZmgwUkFGNmtLYldGOHZpckxuelhp?=
 =?utf-8?B?V1FhUTFyTng3SWRRN3F3MlVHYmFHK2JrMG00QzZJbUpSOTZ3UkU5YWs0bDdo?=
 =?utf-8?B?TFFnbHJ1RTFKV1VLdUZlV2VPZ3RzQTA3dm5vSFhNclRUUXo4SGFEbjlSWlZL?=
 =?utf-8?B?NGkxMXY1dWI4VGE4Y2xFZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR12MB8470.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlpYbjZnWmtBcUZhdzc3cU5YeVl1SURMbkl5clNaQXRadjlxVXVoV211Nm1Y?=
 =?utf-8?B?eTVIdlhZR1dOVDBienhaakh3VGliM25tRzNuTElSajRrWWFJL0h0VlBmemlQ?=
 =?utf-8?B?UHBNZVlVbGdjS050cmNWVlQxNTlNN0Q1RHZ2S3RKb0R2MHpaT3ZybHdnY2tj?=
 =?utf-8?B?c3JGR2llYWFiVTd5QTF2eUNMaUZkaGdWQU5Uc2p5ZG42NmxCanNzNERDSWVX?=
 =?utf-8?B?aVRPdjYveXRSSE9VZk45eHVRU0d4YjdzOXBqTnRjWnFuaEoveFVVdjF5MUVV?=
 =?utf-8?B?TjBKRjJiRnFKZ25RdkZZOEJJS0lsM1l2S0VLeU1kMjFSUGNIREs2NENuck1C?=
 =?utf-8?B?NzV1MUZmSGN2NWRuaTRndkVuL1dNTCs5RlRHaWV3ZG9QdmlnYXZtWlF5VXFs?=
 =?utf-8?B?djlzcjdHaUhCb0wzWEMyT0hsR2QwakNxeVhIMXZ3eGR2WldzYUV6dkpDd3dB?=
 =?utf-8?B?ZDFVUXUyekh4c2czam5zUmdSNGp6UTRnWjNHVzB6aDFTMmozaVVucWpVYk5O?=
 =?utf-8?B?ZVRwSDZiOWJNUmxKQURyeW5BRUhhRUNvOEpvSS9yL2xtMXEvUi92S2o4Y2t1?=
 =?utf-8?B?cHUvTGMyejUra1Q1d2wvb0lxUm9Qcm5RNVZ1ZmlkVGduTXJPZ1J5RHkxQ0hK?=
 =?utf-8?B?WjI0UDJFd1RqOExxRDRJSnhIb2g4TTdGNkRoVWNYREVHcjhaTllBMXBHckVw?=
 =?utf-8?B?VkpVZTI3WUFmdjQ5RUNmZUpJWjduT01mVk9YMk9BbjdGUDQ3SlJaVTdiVVVl?=
 =?utf-8?B?SlAreXdMcTNMOWpvT1FaaFR3eFpwanBqM2lIMzFBam5kWm5jLyt6ekhvQk13?=
 =?utf-8?B?L01Ud3MyTnpnYndJK1RpVFZUM1kzaFNkT2NIMndUY2o3c053ZDZHUzI1ZlBZ?=
 =?utf-8?B?Vmc2UFdXbmp0a1Vqcm42bjN5bWdjeFdPUkhRaTFNQWk4YloyT1REQXNsZldj?=
 =?utf-8?B?RU5TcDdyMTM3NlpHZ3pPM2NRb0xnNkJYRkNSb28zcmFJcHlSR0xna1U1WjFn?=
 =?utf-8?B?Vy9pT2dlanpnalI5b09vbHhUd0wvdFQvNnFVaEI4YTJMRXEvMVZJdkVOSTdy?=
 =?utf-8?B?K2ZReXRlaGhrNE5xcERRY3ZtZVFVWXNYQ1dFVzAxUk51WUUzclFGdTIvc3d0?=
 =?utf-8?B?U3NSV2kzb3poSlJoK1IxS0pZaWRxeDBwaVYvdXlvQ2ZIR1RBTWU0MGVDRTFS?=
 =?utf-8?B?aXpmREY2M0hWeUtoekZxaVd3dVJmVkFJQUVuaXhnMjBaMGJncmNPWlMrdDdP?=
 =?utf-8?B?a2I0ODd5dDJubWVBZHpCcG5HWEhTTWRZK2lBRWdmaFRRQ1I4U25MQzk3aUlU?=
 =?utf-8?B?dTM3MDVEMy9QQ2R3S1RQMi8zMHJDSXlTMHB1YWswaG1kdnkwNFJpTGpxREV1?=
 =?utf-8?B?OUh4QVJYR1B5OWl0ZkxheVRBbFo1RklTQVZaa0IxSlBtOUxnOFc1SUp2aUpu?=
 =?utf-8?B?eXJzeDV3NG82Ukd3MGEzUnBnYmJ2eEtBWU40QWJxSkQ5Q1hiV09zem9qSW1O?=
 =?utf-8?B?eWxCSXZmMzFuczlHSWszS1F6a25pM1pYeFlmWlN2U1hqSXdtb25aOFdVbHB0?=
 =?utf-8?B?N0F6bG9LalNvNVhxQ1hqdk9VUXNpaXkrNHRvdmdERVFRbmJJcUhwanJKTXFX?=
 =?utf-8?B?VUpSKy8wQ0E4b2FDdStHUnQ2R0c2QnJGc0Jpa3V5d1AzckwxWnJXamNsZStZ?=
 =?utf-8?B?UU9LeGZBWHhmaGZjNXhnOUNIc2p6b2N1R0VRV1hjVnM4aXRxTTRvVlEyVjMx?=
 =?utf-8?B?OFgxVjE2L05wNUtTS3Zhb1pYSTg3YVNrT3o1OThQYnFUbmZsWHRwb1JPK2V1?=
 =?utf-8?B?alYydWxsWWhGT3ZsYkgzeERwNlh3U2lMMG55TFBBNC8yZEF6T1FVNlplWEh6?=
 =?utf-8?B?TVZkdGYvcncycXVlUDNhR3AwMS9ZWEJRdkNGa0xWKzY3SXFTSHdoL1A3RWc5?=
 =?utf-8?B?WGExMkhCd2M1UGR6ZjBSZmN6K3d3TjRNSktmeUVBWGR3amxaS1cvYUh1ajZy?=
 =?utf-8?B?dmtWckhndlJhTHJLcTBpZXJlK25hM3pIZ2EzRkVoQzBsdEMzTS9sWm5MNURP?=
 =?utf-8?B?eUdMODhqc3dQQjlLTFNjdzQ5M3Q4dm85ZVpOTk9EVy9IMXNwSlkzYzBIUUhM?=
 =?utf-8?Q?qFqWelAiEBj9tiiHmkBNLCzwn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a0ab08-38a0-4481-0f9c-08dcd36365f7
X-MS-Exchange-CrossTenant-AuthSource: MN6PR12MB8470.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:45:04.7157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXcUefbr8GQc7zikg2GgRI4mL7uzNArabNPpVsg3TJHTtyyAV7Da5HhUhzFVy+Ev
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6479
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

Tested-by: Amber Lin <Amber.Lin@amd.com>
Reviewed-by: Amber Lin <Amber.Lin@amd.com>

Regards,
Amber

On 9/12/24 15:24, Alex Deucher wrote:
> Need to set the pipe reset and cache invalidation bits
> on halt otherwise we can get stale state if the CP firmware
> changes (e.g., on module unload and reload).
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 1cc748aaff3b..b865281b4132 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1703,7 +1703,15 @@ static void gfx_v9_4_3_xcc_cp_compute_enable(struct amdgpu_device *adev,
>   		dev_info(adev->dev, "GRBM_STATUS=0x%08X on unhalt\n", tmp);
>   	} else {
>   		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL,
> -			(CP_MEC_CNTL__MEC_ME1_HALT_MASK | CP_MEC_CNTL__MEC_ME2_HALT_MASK));
> +			(CP_MEC_CNTL__MEC_INVALIDATE_ICACHE_MASK |
> +			 CP_MEC_CNTL__MEC_ME1_PIPE0_RESET_MASK |
> +			 CP_MEC_CNTL__MEC_ME1_PIPE1_RESET_MASK |
> +			 CP_MEC_CNTL__MEC_ME1_PIPE2_RESET_MASK |
> +			 CP_MEC_CNTL__MEC_ME1_PIPE3_RESET_MASK |
> +			 CP_MEC_CNTL__MEC_ME2_PIPE0_RESET_MASK |
> +			 CP_MEC_CNTL__MEC_ME2_PIPE1_RESET_MASK |
> +			 CP_MEC_CNTL__MEC_ME1_HALT_MASK |
> +			 CP_MEC_CNTL__MEC_ME2_HALT_MASK));
>   		adev->gfx.kiq[xcc_id].ring.sched.ready = false;
>   		dev_info(adev->dev, "GRBM_STATUS=0x%08X on halt\n", tmp);
>   	}

