Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B72ECCF9E3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 21:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A205D10EA35;
	Thu, 30 Oct 2025 21:19:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aMh4fzmJ";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010015.outbound.protection.outlook.com
 [52.101.193.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BB8F10EA3D
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 21:19:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ai0Nb5celfR1SKMeduOoZUjcIcHUWv0FuknbynJ1CgrMYYuoFoeoLLtFulyKYfS0qkOatk96PzXi8u5rf9xSWElCMqtgvAQ6hq5B26S4hSC/fAk2LFPu+hNu1SRpop5k/67I/8ocZdmoPcfS6pYZEuPdr/H7YwdW0UShGgPJNmcWOamLGolbGh2Wh46XPPiQ7JbU/EyeBQKBVZP5dIs2HQWHoCT7WaOqFXRsbv/2b9OoscFJO0a/3pGZNOQtkOcZr24s5F7iNq4sKUxomgsuZd+EYXrW8m/wwLhFT0vLsHA3HhslM7kUrziXnNbTRykJicVOSC6kM/gesK6fEbORdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pydUHETCU2DH8Jv4QK4VyAJDzAjHF3iugs/ARGC9SG4=;
 b=iMReZuK5WrVk8xI0c+A8sfdigKZN8rYz/P0N0OJytbj7K/cTL/xrtI0RKH4f0CAHpTlIiMIZYbCoujD4Erq/etfwr4BDonbK0o4e3f/OJR3SIsPqWO3VIX85z71+MXRwII3+4lul1Uk74AvJOIEMMili2s7mO3QPOp4sFLOAG9wLiz768nHhaCHt1VzJdpXe8rn5RVmyMLNh8I2RBbSwe1lhzr61pbfboe0PsQZg7Y4Gs63Ne0BdQtuUWCTylbZUfuFavDNBM4ZmaczLtNQ/FzEpvUgv7L1M2WR6v4Xr60h0QhV+kMxn/lV4ybOLXIAkHUkZ0Opy5Z7jLQGqCzJEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pydUHETCU2DH8Jv4QK4VyAJDzAjHF3iugs/ARGC9SG4=;
 b=aMh4fzmJc3PEQ+QkoJbGPOvdFiRhM68SdtgFB9ZaJHa9UozFUCX5m+bPkZXgxWMmuOHcrGfnkh92pi6ydANynK8zLPZkux64NiVj1qdo5DNaMEO1uU52hp47ct8m5AeKRvkGK54w7wJXh8b0bEZ2i4pCpKRh0Ff+qXRAGXrEuF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH8PR12MB6746.namprd12.prod.outlook.com (2603:10b6:510:1c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 21:19:00 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 21:19:00 +0000
Message-ID: <6ec1eb16-aafb-473e-81a6-9a524843c33c@amd.com>
Date: Thu, 30 Oct 2025 17:18:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 17/18] amdkfd: process debug trap ioctl only on a
 primary context
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20251022073043.13009-1-lingshan.zhu@amd.com>
 <20251022073043.13009-18-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20251022073043.13009-18-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0185.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH8PR12MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: 941de72f-2ba4-4a24-4f4d-08de17f9f177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGFjVVp5UTQvMUhTRTNuVUZkeU5lZC9mcG9KaXRzYVNjSUVwQUR1M0tiM2FS?=
 =?utf-8?B?OGZ6c0dXZ0EveHE4L2VkbWx4dURRRFRMbWxHUklLN29jYnRmL05XRVlnb0hH?=
 =?utf-8?B?Rnhkak5zbDc4T2YrMUxFU2pnZjdVN1ZjTjRKMkpBSExvc1ljVDV3d0h5dEFv?=
 =?utf-8?B?SjFqNlJnME1sbWNhdmJSeTc0MG1Hd0Qzbk5ON0hoWmNYSlh4OTRVemgwVHBG?=
 =?utf-8?B?THhnQzcySzlIbHZ4Y3NsWWUrWkw1N2JISDk4RkZDMzZoQkxFVWdFVW9KMHpH?=
 =?utf-8?B?N1RQL1NCeEU4WlV2eDRtMDhyM1dZcG1XclFibjRRVlcrYXUwZW94QmRkV1cw?=
 =?utf-8?B?K2tPT1c2alF0OGxscnZsV2g5ZWZxbWJDRnJHcm4xb3VnWW95QitUenJqYXRz?=
 =?utf-8?B?R2pQMGVwUEI4WlcycnROM2hqRDZIRW12cHFXTk9abmdnZmVMZXMzOWhGZGs4?=
 =?utf-8?B?RlFDTnFkZHV4a25tbDdMR3lWT3RSQ3FsMW9KTmFrTno5MGxwamNZbklzdGh0?=
 =?utf-8?B?OHRmMkNBQW5lcTVST2daSUdJTkx0QmI1WFQ4WWVsZFZVNkdvMHdQYmVSOEhL?=
 =?utf-8?B?MFMyNkhVbGk3aVpyS2pFRFdMdndTdTJQVkhRU2xEWC84V1FjcHJZZk83N3RW?=
 =?utf-8?B?VDV4TWNuQUhpVTZhYkxPOVR1SzZpc0phOEVoNzA4am54cGhycEdEQjQzeEwv?=
 =?utf-8?B?S2tWWnJQaStwZkJqbTA3aDk0K0hGR1B2akZvaHl2UUN5TDZrVFk3NHEvajJR?=
 =?utf-8?B?bGl1Z2ovOWZjU1ROY2t3bTM2UGdiYmhRcjlVNlBpM0E1cXIrWmE1VlRiQzdR?=
 =?utf-8?B?SmdkTDlWN3FnSlUvMmVqMk1lVmRMemR2MXJId3B3a1Q1SnJCcjhyWGN5bUdB?=
 =?utf-8?B?QkhNaTVYVXd5cVNZOHNxT2s5bTB1TENEaFQyemZPNDJEUllMdWlwMVpNbXhp?=
 =?utf-8?B?TkIyNFNtV0paUEFGMFNWUVMwSFlrVDBUWTJXUXJJUTdQa1NqMU9hYndQVWRj?=
 =?utf-8?B?dW95RWxmTE56SU15L3BiNlVJV3hHVWRZRTFtQXE0MGlxZ0txUFBoVVVjb0Jq?=
 =?utf-8?B?RXJtaDdpRjV6aEpFUjZZdmZiZkpiVzlNWjBrdkk0Z0JrazhqOUFoMzFXWFhJ?=
 =?utf-8?B?WHdrRXZpNTEzSXpvM0Z5RzFaLyt2MDFic2k0UFZjOHJKamZNNHJueElTT2lU?=
 =?utf-8?B?bWlMblNYVXBKQzcrazZtWFlpSTU3eFY4aWU1dGMyODVjTVZ3eExIamFwejlK?=
 =?utf-8?B?bGxhZTdNRlgwQkJhZVlUOUZxK3RxSlpTaEt3Q1ltZ1FFSWdmUDZIS3Erb3V6?=
 =?utf-8?B?R1d0OHNZK1lIeWs0ZkpWaFRidjdGNFFWN3VvdTVMV1ROSEJ3bVhDUFcyZk56?=
 =?utf-8?B?Yk45VVJXM3EzYTNFTmExc0xVRzd4cndUMHFYRW14MUlSemk1MklDSTMyRUNY?=
 =?utf-8?B?M280aFVrU2lacWdnMFpxcHc1WTJscTJuVkRRMm1yV1ZvbSs2UFBQeFVXQlYw?=
 =?utf-8?B?Q1c3cS9NU2hCb0FlZTk1YUd6ZzFmeFNxdXFJTWVqb2ttTk5SblczOUdDQWZS?=
 =?utf-8?B?ZDhYZ1p1TDFWSzVOZHJVRjcrcDRTczhEajIrUk1aUHIyZ0hpOXZTZFlKenhP?=
 =?utf-8?B?MGhCWS9ZeFpPYndhVnJsaUxLR1NVQmsySVZNeis4c2Q2ajVoR1BRN2hpbUxr?=
 =?utf-8?B?RjBoQkljQVFYUVM5LzNnWXBTeHQ1Q2pQL1Z6dHFMZFlpVjdaeDljdU9XZXla?=
 =?utf-8?B?MmlJYVI3N2N0VkdRa3AwUFl1ZXFJV1JvV3pjd0tybkZoL09IVmkzZUg3bnE1?=
 =?utf-8?B?MFMyUnJvSHRlb0QwWTZoTElZa1lmZ0NRcnRiNU0yU0VpVm9hYUZtdG11RmpR?=
 =?utf-8?B?ZVU1eGtCL0FIV1VRNktwWXZkemQzSmNUeTYvVVp4cWVDakM2aWU1cTJVdk4w?=
 =?utf-8?Q?3pmr+wrmJRotpLLtZK9lda1PV8WgjytO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWNpNFVnUXladVVmc2FWd1FESzV0VUR3R1lvUzV6V3RsNWY1TVoramhjTnFp?=
 =?utf-8?B?emNQZHB2VVVmTlgxM0FjTEpzNFhKa0FGdloweXlWaHRiOUN3RkFMditCajRM?=
 =?utf-8?B?bFFtRjNVZEZwVGl4dEVjT3pMTEhMODM0MEMwbkRndzdaYnpqdVFCdFRZV0Z5?=
 =?utf-8?B?Vm9QTXJqMDMveU5aS2dNeHNDYlJWRCtwV3pIa1pNd3V3TFRHWUtSL2Y5eWRL?=
 =?utf-8?B?OTE3RTBabnVQWmZOcVVFQ1NQVFB4NEwvelhVS3UrcHZhRjVDa0pvQkxsMUQr?=
 =?utf-8?B?MTB6NG4xbitWVlp3Z21NMS9RaW1CbEFOOE13b0FSTndZUHZPNzhyRHVlQ0lE?=
 =?utf-8?B?bUg1aitzUGVMaEZ0dHdjTnJJREdzR3pMcnlzVExhcjJseWFwNWRpcElnUDhu?=
 =?utf-8?B?NnA0SGtqQlo3dE4xbHR2WUFNSVh3T1hnbDJadmZRN1ZZM1h2TVM3U0FsSmE4?=
 =?utf-8?B?d3BlV0hmZFFVNTJrRER5dU14YytGTExUeWdIU2kxQytaVWFuMU5JTmwrQ3JT?=
 =?utf-8?B?NkdwNWNlckVRQ0g5dG1wYzN3aFVIRDM3NUlhRi84SHcyT2dBNmc1TjN5blJi?=
 =?utf-8?B?SDRXMmZ2dG5haUlJVGdrcEdWVWtyNElKczY0K2hxWmZPUDR1ZlhsSmhYbGsx?=
 =?utf-8?B?QytYVG5EcDVVOXA2c0pSVG5QMi9RL0FnMTQ0K3YyT3R5Z01oV1RRNjFXdld3?=
 =?utf-8?B?NGF4VVVLL3hEVm4rMFV6bzczcnNORzRzeTdUSmRjZ1JaNi92UERuMWc0YjBM?=
 =?utf-8?B?TTNMQlVRMlpwREdnU0RiSEFBaEpRYkNycGF4eHVKUnllaFlQdW84NDExVE9n?=
 =?utf-8?B?T0VlOTB3cE5KMmFpYS8wRlR0bWpWbm5yeUxSRGJxZmRnKzRvOEhScTR4TnFk?=
 =?utf-8?B?a3NueW9ISWwreWtJMFJGWnlMSE5hK09WM04yUXBUbnJraWszeGhnWktXZVQx?=
 =?utf-8?B?aGZxemV5YWxFdFpWTXlHSlhJZDBxd3FnVDRteGxuY0RJaEd5cTVCUEVFYitz?=
 =?utf-8?B?UithQ1B5NlIxcGZZVDdMTkVteCsrUVltMmFZOFIvTHEyOGtWb09IYzlwRWhF?=
 =?utf-8?B?bVR6aXcrZnk2L2o0TFh0VnVOMXh1R3dJYUxCVEFPS0w3M045RzNLQlhHN2lM?=
 =?utf-8?B?UXBDMjliVFlDbklnT3Z5YkdldWp3S2ZqL2tGUGJSYktDTDhQb0lrTkJZY1dH?=
 =?utf-8?B?Qm5KVGFHWlRlbjZ1OWxSaFBFNHVvUGdGNjBmZHlaaW9TR24vaTFNSWtrZnNo?=
 =?utf-8?B?UkNoZ3pmQjFlRkVTbytkdVpUWDJCMmJWNTJOYjgwRW5YbGhPRFh0bFRtb1JY?=
 =?utf-8?B?YTR1eTk1M1h3UFdBeHNrYmhSZklpbElvckl2azRuLzJxRXZRdU5UTUtvYVlh?=
 =?utf-8?B?WFBlUUJ4UjhUV21CTFJLL0tydDNrSmovb3pjMHR4ZEVocGduREFkbjVIRnMx?=
 =?utf-8?B?VmtCYmN3eEw1d3hzYzRZdzltYVdlZ1dKYnFnSStxU0EvYitCeEp2NTg4QjRP?=
 =?utf-8?B?WlRMdUpQbXNaeHdQdXcwUE92Y3BSdm54bVBCbTUybTZ0SExPVTZEUW9ZM2o3?=
 =?utf-8?B?VWN5eWxlUk9PaU02bDVteHFiZXUvNERHNVZUYnAwRkRzbVpFeU9uNzc1QWhV?=
 =?utf-8?B?MnZlcGdzMmVUamIvbmsrbnROdG5uUXkvcXgvcU5Ec2Rwd3RkV0VCTUlmY043?=
 =?utf-8?B?b05EZGZQckljT1JwblZYQ3M4Zzd1OFJycHZYMGttcTFCQ3JRK3d0MndTUVAx?=
 =?utf-8?B?MmpHRWRhTWoxU2c1dTNOeWNXTktPU3pyOUFXNUhra1BpZlVXY2gwTjl5Uzh0?=
 =?utf-8?B?eTRqYVAyVmpqYXJXK0JlM2ZqRE5tMlN4UHNFR3BDaHBPRmlOdEJ2UXdWY2t3?=
 =?utf-8?B?NVI2TmRmVjl5endKL0ZqSFF5eEY0TXY1TURlNHpwUlRWR1YwTkNrSE5KVC9B?=
 =?utf-8?B?aFRqaU9VVlAzdGt0bGc1OWlkV2dwL3A0VjFjVU1LUk0xbkFvdGpKTXROeXJE?=
 =?utf-8?B?QmlseXZMZXRISUMrR0dqaXZqZFllNU1RVDhxOFVLSjNYejh3cEk1V1BKOEpz?=
 =?utf-8?B?WGV1TUp2RVFNTmhPVmFDaEZ0OEdycDk1VDhsUldNSGhlZmpFeEpmOU5UaXlM?=
 =?utf-8?Q?mtfqXfN2h8cUqnGsfHsqRpCLv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941de72f-2ba4-4a24-4f4d-08de17f9f177
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 21:19:00.0964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEDHXEto2j3Y4a52lGPZKsF07/JmjymczO6BS3cGvoKH9lA/BM4kbCrIw+ML5312D5pGzJrtTQJ/UWdyXNxGMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6746
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

On 2025-10-22 03:30, Zhu Lingshan wrote:
> Set_debug_trap ioctl should work on a specific kfd_process
> even when multiple contexts feature is implemented.
>
> For consistency, this commit allow set_debug_trap ioctl only work on the
> primary kfd process of a user space program
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 73de2de8be0f..ad5ca3fd847c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2927,6 +2927,12 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   	struct kfd_process_device *pdd = NULL;
>   	int r = 0;
>   
> +	if (p->context_id != KFD_CONTEXT_ID_PRIMARY) {
> +		pr_debug("Set debug trap ioctl can not be invoked on non-primary kfd process\n");
> +
> +		return -EOPNOTSUPP;
> +	}
> +
>   	if (sched_policy == KFD_SCHED_POLICY_NO_HWS) {
>   		pr_err("Debugging does not support sched_policy %i", sched_policy);
>   		return -EINVAL;
> @@ -2971,6 +2977,12 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   		goto out;
>   	}
>   
> +	if (target->context_id != KFD_CONTEXT_ID_PRIMARY) {
> +		pr_debug("Set debug trap ioctl not supported on non-primary kfd process\n");
> +		r = -EOPNOTSUPP;
> +		goto out;
> +	}
> +
>   	/* Check if target is still PTRACED. */
>   	rcu_read_lock();
>   	if (target != p && args->op != KFD_IOC_DBG_TRAP_DISABLE
