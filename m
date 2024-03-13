Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA646C54791
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 19:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A1C10EF94;
	Wed, 13 Mar 2024 19:45:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EU6p+YNr";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC34B10EF94
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 19:45:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lI7tnJ1YrTyG0a884fLmsrBTMUWgdb31xgIINR2VRl6AJZGcGVx7MTHX+PYRZax1onvQA9Ka71BafzlXVjaLv1PZ5Hl9Zep5c2xLaMoqYg3RYGSPD+MT0sg6Z+W4fEFHW7TM3bGdyIH2JgslGwb06jQ3pTS/aOVuM3vCyPGfDPsK+ZDmhtX9QhfVMPB2dWNbGxrM8UOit5gc70CXVdRkR77k839tB2uicYcKA3OvdehQn8Hf23+AQ22LmsGJSrHoodKqVqtb9jGQkXIYRbjHvHiMJJ39Cql9RnHquAgD0A0u1rDE2JYYdwji/dB3eBg6TurNm1CVnfQ++34PLalGnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RliLL2zLOmh5hsGaGkGqBRIoalN2oR6HAcruivpIW2Q=;
 b=MFgmxVsUBVMF8AUI9ZoXku6d27nO4RhIluLs/JwJ7z5r38NwTfSYLZoEZz7AmJ3LVGI8qwIuErAdgJwTpGV5sGFKJeB+5fPv+rEQbvw/NMFauuIAlRyS6tTiHCZWF1/c33dofyeyJtoyrSjWZhCVkqsBiwKLOBoBaCyh1At+a5xAxM34jx4nmX3S/j5Xgc7ji1P9LxLXa1bq5tD1oU5DsdZJ485/fn4uUUUU8E+YfFnGzG3kVbT+1Hx+MHYIc+OYHgHQMYpIp41y0UMc6HQITYGt08p6guQMJBdhMgYnVKRxdeSupHiuGQZKxMwR+cQBlkOuOMpEB3QjcrUEAkSLTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RliLL2zLOmh5hsGaGkGqBRIoalN2oR6HAcruivpIW2Q=;
 b=EU6p+YNrZr1V37G9d7Bsh8yiIB+UfX2hSGMxkugMkQh+QPuvPe6RrXDn/O/wTwmGUKL6fobnK/lS82eUd7bvA40IBqmPZ/Bum0r6wWP4IjorZ45MzdGYndjMiW3/WkHYipGJQdeMO8Jzx/dXRNvcxsR0fC+yaSKgQXdYbdT1DJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Wed, 13 Mar
 2024 19:45:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8099:8c89:7b48:beed%7]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 19:45:50 +0000
Message-ID: <c0c126f3-c379-4a68-bb89-2c4aa505679b@amd.com>
Date: Wed, 13 Mar 2024 15:45:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: Enable IH Retry CAM by register read
Content-Language: en-US
To: Dewan Alam <dewan.alam@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com
References: <20240313174344.2580-1-dewan.alam@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240313174344.2580-1-dewan.alam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0257.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB8697:EE_
X-MS-Office365-Filtering-Correlation-Id: 1710c54a-dd38-4051-01be-08dc43962f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6lLWUGi69vtAgsXiCTxN2YjAoAzJ9KNZMn2hxnd/q+dJPMSby1j/I3uhUjCQHMxupSOoJuj7qNxZNw4kTvE8zgIQymT3Dpe6ETpkwBS1+cfz4ZHvv3Oc2XAZgsxOlsloEZ223nwkSF8GO0KrmlmgoBX/AIWT/1Rs3qD9a2uYoCn0vAzSCIjwmhqDZFr4lr7Aa4nf5vEAdIPZ2pTDVUYYu3W8sK66az2XCuJW2WrMPUKfbyW0nkDfTr+cxnGlaOJwy38FeJRCzpmtyNXtWRsqizz/PyAx+mG+dT7D6r3oP6jiny70RofYg2fSkoUIvw+YHJRVVx4dKxDWGNs6qXnK0wIcNqotmeW9ErHjd49RRwEhG1rMFPk/jNuAKRD2I/gJP9sWC7rq208kP7LL1PhGUJ2CkR63uc/0bHwgNzFq6XqX0SOfG3gwVLImhiLfWjdUMyaALtanoCjLd78PdDqF/UEeF/QtQn9r2IlfeMJae0prbi9mJ2J3A6H2iOpfPwjArjM0ojvoe9nHWCOTB9JA3r4Mw10cOTvdkOk756Z/a47urdFRZtF+aCu2eANWBxB2KVjvobmajXM/2n45oTDe9KpeeSvXUX6vtWXTvkBAJytao91SCG69cD3AkY07CbGNGehBdPWRDzbIDKA7+wpd5tRvfUe7TenoM3IHoLgh56s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXN2WWxIY1dkK09lOCtVYjJQd3BQSEtNWTVnNXkzUW43enJoZW9oMXBNOFU2?=
 =?utf-8?B?cXBxM1Zudms5SzF3TzI3bTZ3RVNKN2xjS2d2NzNEYzdZMTcrWkhobzFtNU15?=
 =?utf-8?B?RVlqbjIvaDlac0E4OUowd0RxVGxhVVp3S2V1aVBxd2J5eFlHNFA1Z1RZRm43?=
 =?utf-8?B?dVVURXFXNzZMY3lpVllSb0Q3ZmN3SDJ6b1lyWDVsaEQxUzdKNUlEdXAwMEhK?=
 =?utf-8?B?QVRyVWtFcFpOcVh0eVRNQ2hzU2hXTjR4T0kyYmJJRnE3djJXY3F4WGhhcTg1?=
 =?utf-8?B?SlpTSE9CNDRYVlZQd25vK3VKaGtoMVMxeGM5UGRUK0FCQllpUDZxK3dSNGJV?=
 =?utf-8?B?T0FIbjZiY3ZQUUYzUW9NcVRZSzVkRlMvTHpjWms1V1BpYTZlY2g2czZuMDlt?=
 =?utf-8?B?QklUQXA1WGU2Wk5sSlZvRXREUU1HTEFNbkJvMFdJSldMb1o0Q24rQzFzcGFZ?=
 =?utf-8?B?RHc0MXRnTFFkVVlMK1loNHRUSXNQRFROQ0dXUk9lZWVPM3NPTlZXdldVaTBJ?=
 =?utf-8?B?UXBleFFvaGwxaEtaK1FCSGVLVWw3VHhxQVd1NW11dlpwSXJheWE4N3pkZlpW?=
 =?utf-8?B?UmY0Qm1NZkJSbjR0ZGhtQ0xXMFViTkdkVEJVMm9rdmZpR1RMdFRhS1hpUzZ0?=
 =?utf-8?B?S2gzREgxNHJXWDA0dlJVQlN5ZXcwSDVpODQ0amVFQzc0dXQ1TFJINy9SL1Uz?=
 =?utf-8?B?MHA3ZWNsamlSenFKN3FuVENIbllzM01lcklybVlNVEE3MHlWZnptaExpdXpx?=
 =?utf-8?B?MzdJUy9rV1BRaGVaRkhQRU9yT3A5dGlzdWVqaEIxV2hlelNRWDBKeHZTZkVD?=
 =?utf-8?B?RTZ4YXhubkRKSzEzTk9yamM1K21XekhJU0NHU05HNGVNM0dtWTdGalN3ZE1W?=
 =?utf-8?B?elV6UG5idEYwbER2dVgxSW1xRkpsbEQxVE9ZNlRrdlFKTG1pZ2lheXUzekhv?=
 =?utf-8?B?NTNna254aEpyNTlJTHJxZWh4R2tRSnZXeFR5NklrMXBRUWROSm96VWZTV1dv?=
 =?utf-8?B?M2lqS0pmSTBmT3dyT2x4d3VQeDBMRDc4NVhXaFVwd0JoMmJ1dlpmMzJIQitO?=
 =?utf-8?B?M254NDFBWXVFWDBFcDhIV2lKelQ1L1hZbG5FTk5YVSsxTkhHdllhdGYzOEVh?=
 =?utf-8?B?alpjQXNXMzI5YkhwQkNPYlEvT0t3NElNQkswM283U2MzMFhGbWlrNTlJTmZB?=
 =?utf-8?B?MFlvSXpRU1o4allCelBmNzRYeTlaNTNJa3dLQnZDU2N0MytlYmhxVCtmaklZ?=
 =?utf-8?B?RFlUNldCcnFGQk5SQzRtYWQ3OFdyU09jeFhoTEFSdUxtQklZVCtLcjhpc1VB?=
 =?utf-8?B?VnhoZ2NHd1k5YTJoNlNna2dtcVdDWDhrd3VKRTVDZy9LOHQzb1h0S0w5eVRP?=
 =?utf-8?B?R2d2d21wSGNEd3h0bTlyRUZWL2l6L1pLWUI5Tlhoem9CaFlIZTZrNjdaTFI1?=
 =?utf-8?B?MmFwT21pMytKTndubnQxRE5VYzBJU05GSkRUa3M4TUFHNXlKOFgvSytaOWhi?=
 =?utf-8?B?U3plOEdwbHZPWjEvOUo2dG1XU1A5UmlHQnVzZjk1RFJtOXMxNlBKUnB4dE5a?=
 =?utf-8?B?SE54dHBpRkRlTTR3OG9YeG5xdlh2ZlQzQWM2MEpaTjlqenoyTGwvNG1COXN5?=
 =?utf-8?B?ZGVJVmU1cE1Dd3RUdzZ1WC9YMmlRT2VBdjFjOVRsT0JQSGQ3Z0NaWi90RmFZ?=
 =?utf-8?B?UFl3Z0RzWkpneTNMY0JzOXpZSUJQSDk2eW9IMDRldXV2TENqY2ZBVTE5QXY2?=
 =?utf-8?B?S3RKSzdxK0lEY3NTdkxIVzlRMmhXbW00ZEQ5ejFQV2FVemlsWm1tUzVUQVBQ?=
 =?utf-8?B?cUZlOU4vRHRGMTEvSVcyYkZRb1dFbjdHbTFzd1Y1dlUxaG1zekdPakhwTnZJ?=
 =?utf-8?B?VDRndW5TeGpPRzhQUXUrV0ZqbEN3SnBacmFIbFJybEZ4cG1jQ3JTTFBBOEx1?=
 =?utf-8?B?QWF6N3J4TG5TRDhXRWpQdWxCa1M5dEtGM1RqZEdhWVVCaTlUSzJHSFZTR1V6?=
 =?utf-8?B?UVllUHFiQ0xydXBNdG5VNTljeTlHZTNUSUoyY2FIZlhIVisyeGFrWE1sa3Rn?=
 =?utf-8?B?Q05jOSsyQm1Fbk9VdkRTKzBEOUZaQ1pKQkMveTlvNksxekNLa3YyYWpuWC9G?=
 =?utf-8?Q?+eQv/fAfe5e7kicb/FYU4CqY9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1710c54a-dd38-4051-01be-08dc43962f7f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 19:45:50.1926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtG/aEiPX4rV7vmLKMY5CAJlZq6TmrMoh3MQNYdyC6t3KT0V4MYj7cRClvac2cr6sYW1b4nWZHVvKHbkssGDvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8697
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

On 2024-03-13 13:43, Dewan Alam wrote:
> IH Retry CAM should be enabled by register reads instead of always being set to true.
This explanation sounds odd. Your code is still writing the register 
first. What's the reason for reading back the register? I assume it's 
not needed for enabling the CAM, but to check whether it was enabled 
successfully. What are the configurations where it cannot be enabled 
successfully?

Two more nit-picks inline ...


>
> Signed-off-by: Dewan Alam <dewan.alam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index b9e785846637..c330f5a88a06 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -337,13 +337,20 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
>   
>   	/* Enable IH Retry CAM */
>   	if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 0) ||
> -	    amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 2))
> +	    amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(4, 4, 2)) {
>   		WREG32_FIELD15(OSSSYS, 0, IH_RETRY_INT_CAM_CNTL_ALDEBARAN,
>   			       ENABLE, 1);
> -	else
> +		adev->irq.retry_cam_enabled = REG_GET_FIELD(
> +			RREG32_SOC15(OSSSYS, 0,
> +				mmIH_RETRY_INT_CAM_CNTL_ALDEBARAN),
> +				IH_RETRY_INT_CAM_CNTL_ALDEBARAN, ENABLE);
> +		} else {

Indentation looks wrong here.

>   		WREG32_FIELD15(OSSSYS, 0, IH_RETRY_INT_CAM_CNTL, ENABLE, 1);
> -
> -	adev->irq.retry_cam_enabled = true;
> +		adev->irq.retry_cam_enabled = REG_GET_FIELD(
> +			RREG32_SOC15(OSSSYS, 0,
> +				mmIH_RETRY_INT_CAM_CNTL),
> +				IH_RETRY_INT_CAM_CNTL, ENABLE);
> +		}

Wrong indentation.

Regards,
   Felix

>   
>   	/* enable interrupts */
>   	ret = vega20_ih_toggle_interrupts(adev, true);
