Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D42C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 13:30:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A93CB6E444;
	Wed, 24 Nov 2021 13:30:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1E276E444
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 13:30:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmVnTUrdJUD0DRVMo/n/2wuD62A5Y5aMQsIIG6dA+iiy9yAVHKYaospj2chnn83ZmO5InYCXkVHm0N5cwCGP7M7f0M22dYJmHs+tJLzo3AQV7uNdxnpSPx9NAqVhKjwJoGnZ875Tng2TN+XywQ6BCSEjH20nkkrJ5orm7gewjIttdGbv1yz8gRoiDTHYoTDD5tm+o6RHKvTGGBUracQi0aGlDb1GvSnTcfEuyvibSLmb7U0l10I0j5nDRvIPaAB+lOaR5evHAXUUUGS5VwXpmCAND34gjD/JAa8AHOggSn/7BFpwxjEJfMJMwSmSgWWzjsJ6sKM/c0JsFuBtC3UCMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMj8YxnUTxmxDn0wdFREzTx1kY0uEFwaGq/t1y1ROTk=;
 b=AYYcTiy3k5of8I15eHZc+cq+eaTAJ33kVlMNifvDdzHOW6IgEsFe6zZpdtRbStX88jcxbDG3u+9kGd1iJrJ7PTxLLsuyFpcZ5IDy11+mZg0Bw6Tf4jJq5KxG8SjfsWSXgM/mejWW6aSoS3uEHElpDJ0j3ikzlI4navZgT+3OzVcSACsPPPb1J/neUNLs1Ek0pmNdAJDpT2R/d9M3iC5/cv+ygUFil+xSCnxF12cexx1wO3aV7x15juWfDHzMGO6amsLXv1jh2oxsLnNhBQPiA7eWrtDXqv02a552gYz5ud/3pleVNpz+vvy0/cjPFA9+TtOsbix+qzm4gIPCuOQqlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMj8YxnUTxmxDn0wdFREzTx1kY0uEFwaGq/t1y1ROTk=;
 b=S66dB+AlLYylaCpgKv1hUfpqwDfWNLBZT/BCgHU52mjlGCSRodXVEcJaJtCPB79h/iEWZLa2qbDaSTYE3B8Zr9W/sL3xspLU0xq20nahXP/4IueIrhZ5OFsCsP02p6T6h/84ADTHEUkxJFfuL4zrvcxv7mhmUJDu38YEu2tSNm8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1881.namprd12.prod.outlook.com (2603:10b6:3:10f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Wed, 24 Nov
 2021 13:30:42 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4713.027; Wed, 24 Nov 2021
 13:30:42 +0000
Message-ID: <b46176de-3f94-e85d-1a6d-a6966a905c52@amd.com>
Date: Wed, 24 Nov 2021 19:00:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] drm/amdgpu: reset asic after system-wide suspend
 aborted (v2)
Content-Language: en-US
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1637757791-3210-1-git-send-email-Prike.Liang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <1637757791-3210-1-git-send-email-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0167.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::22) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN2PR01CA0167.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:26::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.22 via Frontend Transport; Wed, 24 Nov 2021 13:30:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7953b4f0-37a6-4ad6-8c56-08d9af4e9cb0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1881:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1881675F2C6D01BC12D16F8B97619@DM5PR12MB1881.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Glv4WICRPrj02hoY8ehibzOg8YmD4lKmuasLUgDVSeypTOLN9Yv2ewLMh9nrRIE3e7Fa+nrrg3D6s+yFRVX5arBVehmV+QUwA4dKa99CGa3ptQYVHI71J7SUsQ29l1LZ5o5TbFg5Yd5bHg3Qwj9rE01rMAv6AUN3T10UcRihIYThWZgvgsiqezCTO0iSR2VZ/echLIL5Tip2OArV8L0Fa1FK0TIY3bXhaKrYw4VjDeUKQIrpKpnkhgNy3h83sCs0YYcMVEznvUPpEk/Qg7egs4meBwl8ByLELD2dezghQoX1HLKEKVVwKND6yK7se36FMclZBFECEbvp2PuC9S0igOIfNjcyyz5v3tzSuVvNc/Mn32KreBfsPJRpFOYqJgDxqCr5IEFED+C65N3T6XMd7fJMmh/B60MtcZUhpCrvZijHKf1yhdb7iJt2G6T3MTGpxvLoIfGNf4S2enrt5TiVUMizuKj6XPeIWJrUnGgIyHabFgCIYHXqUs5Pf3xrWYC/pmFev4J5nre9fXOFS0oOFVjRvXhJZrWSUn+bNHiTG9DZgqrMzA64xsXn+xT42Mtbvx4d/um1GvVKt/5xDs3zxn3Xjmt5KbLN9KEitcN2+JFbRsSVZFxaQRaF3qoMl4scECwh1O2jj1u/KXCOukZGiAPuo8MydJmuXJhCDUo92wDUwYpP1+4uhzyUAoPqcgkyLZTxPfsLDl+q3wwiyHG+xh+yq4fkn5kflfdJlhiQeEE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(5660300002)(316002)(956004)(16576012)(186003)(31696002)(26005)(6666004)(8936002)(53546011)(8676002)(66946007)(38100700002)(15650500001)(83380400001)(31686004)(2906002)(86362001)(4326008)(66476007)(6486002)(2616005)(36756003)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzRndTFlekdnSUZ2NTNmclpVc1VwVFppc2NieXBKdy8zczd3ZllpbGVwSHdG?=
 =?utf-8?B?b2NSbHZtTnF1T0ZyTHNISGlKbzZwOE10ZzR6bDE2UCtoK0dhaUFrSGpFMldM?=
 =?utf-8?B?SGxlaTN4SUV4THpWZGZiUzZ3UnJmeXlWWEE5QTNxc1cyR04wdmV1T0VpV1Ew?=
 =?utf-8?B?endtUzJ4VktoSnkvRWN1aVVYUkx5R2V1T1JlZllSaVJKMkVqYzl0bTZiK2Zu?=
 =?utf-8?B?Sm8xYjA2RXcxREdyR0VKWU5sMk1zODNuOEt0RHlrWFRSemxpZ21nNW5WUlBl?=
 =?utf-8?B?S0xPcGxVU1R4TG1RcUZPMjVScHBvNmhQVjk1T08rdDIxQ2FHY21VNTEybWNm?=
 =?utf-8?B?VEVJcjVkY0ZrRVRuZmZQOGVRSmhsSXZubUZoNXhJSnhybC9YMzIrbTJmWWdM?=
 =?utf-8?B?VFNFQWk2QlVmR2J2bC9vMHVycVgweG1hVTFHK0dEdmxLcm5PS0pBYWs4a1pT?=
 =?utf-8?B?T1RmV0YyMGdmZzhhMlJKek9obVBGWEZxQm1ueG1jU2xUS2IxbWZrZGNTWEJj?=
 =?utf-8?B?QUd0U0dFZDZHUnltRkNlZmExc2M2RmNSRE1Xc1FrMG5TM2N5SmFYZGFDb2pu?=
 =?utf-8?B?aXNEeUViUVg3WFBUZmJaMEtsMDlmbzBDTndZN0lKbE4rSy9xQVZBc3hsYTMx?=
 =?utf-8?B?N2JYV2w3bk55NG5UNHpaZGFNT1dNeXU5NHRHSmlpNHdNWnpSYllHNmFzTDlS?=
 =?utf-8?B?eXNZeGJvUGNyN3RtWThyUXQwaTNnakNoeFppUnpIc0poYUUvaDRsSmwyeVRs?=
 =?utf-8?B?YjFIL2poNlVmWHRHNDhFVlRyQ3A3dmNpaXdjWWgzeDk2QU9XaFllRFpCRFha?=
 =?utf-8?B?VWdWa24xTy91REt1QVNUSmVGMFBlcFlFN3oyM0NTUlF0eTRaa1UrekpFYXNi?=
 =?utf-8?B?UGxhUHZMS0xKOHZtUTlzYlFUQ2xhTUVDdzNEZlVZWWZ6cWdvYk9YeFNJdjhW?=
 =?utf-8?B?QXVxb1hqeVdxTlVIN2xydTNZZ1I1OWNHVnpaZWhCcEhpRDRXRkV5Z05SK0tu?=
 =?utf-8?B?RVByQzBwL2RCd05hamh6REI3N1hKK1lDdS92SW1GRVB2Q3F3Q1RRQzB3Tm9Q?=
 =?utf-8?B?ZFViVUh6RmF4VVk2TjNLMVpvanBNeGN2amlYTWgzYkVXbDlSMzE1TTEwV2gw?=
 =?utf-8?B?aElOeHRsL1VUTGQyVk41WGp2QkVDK1Nsd1lnRnB5VDgzR09Jd1VSemlRQ3Ro?=
 =?utf-8?B?YXBwNzRMa05iSTZDd21uTFZOSkRuS2pNbStIejhIZmVva1dCMU1Ob3ZVaVZn?=
 =?utf-8?B?ZjVzN21FVEc2MHp5SjNIL0VXS2dqR2pkcWlVMVJQVlc0UkRBYklBUUdKeFVp?=
 =?utf-8?B?bGhybHhCRzBCRko3TjFBYmo0OGV1ODVWVFcrVTQzRnhnLzczaVhoZGhBRUpL?=
 =?utf-8?B?UlVoaFF4TDMrYS9DV1FEdE5Ib0VTR2t0MnhSWWlTUGZuby9XdWpRc05HT1lL?=
 =?utf-8?B?NmE3bG5ENXdMcXZtN0Q2SFZ0OHpHa2FpUUlTekNLWmxPbmZTSFp1RzRZcHVm?=
 =?utf-8?B?OUt6VHR5d2xCM1NwRzN0cHM1dWt6bUhtT3lvY1g4UUhiYURLSEsvbzhjN3F0?=
 =?utf-8?B?Zy8vaS9YNUJGU0RpS0pnSU10dWdtNjNtYXlFbkRha2E1UFJhMmJYQzRZSTRY?=
 =?utf-8?B?QnhoMmdRUC8wWVRXUmZVZGtIOHJWU2ZUeU5HZUlaS25hVnBmaVFGNHZaZlVh?=
 =?utf-8?B?UUVQeXljV3AxY1dQNkQwTXZiSjdZYkJmTDFNem1DS0pKRTdlSCtCT0RZZnpF?=
 =?utf-8?B?bDdOWTVnYUJ2SDlmSFR1VThWV3NaV1ljRE5FOCtkWnZocmw1dk8rQ1hSakw4?=
 =?utf-8?B?YXlFK0RZZU5jd3JDSjBDMHJlQnJGek0wR25iM0x5LzNIeml4WUNsWkkyZmdw?=
 =?utf-8?B?cU1jcGc2M3N3bDNKVGxBS1V4WUhMNTdjeFhNd01pRktaZDhHYlQ5azBlMmo1?=
 =?utf-8?B?RGJVOXNyTXd2QlRqSjFhVWdKZlBiVjFSNjgvWHpDZkVGM2tlOUROcEZEeEFD?=
 =?utf-8?B?U1lld1lJY3ZzOE9pOGpjdDcrSVBud0JWT3ZZTmpWSCt5UjJ2TnYrdUkwK284?=
 =?utf-8?B?R3RDOFZRMlorejdFOFVRd0xDNVV2Z05DQ2JYNjJGdEZNd3d4K3VTN09IZXJF?=
 =?utf-8?Q?dVAo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7953b4f0-37a6-4ad6-8c56-08d9af4e9cb0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 13:30:42.6448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUt656F+tHcciw8DAMIzE43fEN4Jc37ni+zhlvWT0Gc8nBMdHte2VP07zOcrYCQs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1881
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
Cc: Alexander.Deucher@amd.com, ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/24/2021 6:13 PM, Prike Liang wrote:
> Do ASIC reset at the moment Sx suspend aborted behind of amdgpu suspend
> to keep AMDGPU in a clean reset state and that can avoid re-initialize
> device improperly error. Currently,we just always do asic reset in the
> amdgpu resume until sort out the PM abort case.
> 
> v2: Remove incomplete PM abort flag and add GPU hive case check for
> GPU reset.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7d4115d..3fcd90d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3983,6 +3983,14 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>   	if (adev->in_s0ix)
>   		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D0Entry);
>   
> +	/*TODO: In order to not let all-always asic reset affect resume latency
> +	 * need sort out the case which really need asic reset in the resume process.
> +	 * As to the known issue on the system suspend abort behind the AMDGPU suspend,
> +	 * may can sort this case by checking struct suspend_stats which need exported
> +	 * firstly.
> +	 */
> +	if (adev->gmc.xgmi.num_physical_nodes <= 1)
> +		amdgpu_asic_reset(adev);

Newer dGPUs depend on PMFW to do reset and that is not loaded at this 
point. For some, there is a mini FW available which could technically 
handle a reset and some of the older ones depend on PSP. Strongly 
suggest to check all such cases before doing a reset here.

Or, the safest at this point could be to do the reset only for APUs.

Thanks,
Lijo

>   	/* post card */
>   	if (amdgpu_device_need_post(adev)) {
>   		r = amdgpu_device_asic_init(adev);
> 
