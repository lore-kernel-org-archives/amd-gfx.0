Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EEDC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 30 May 2022 07:56:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35B0D10E2E7;
	Mon, 30 May 2022 07:56:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B26EC10E2E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 07:56:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IN9nvf1e3avI10R/qJWfXVkrapqQsPjrt2JQLUlLw6nJsQgNApy6NXtq8r1U23jNCP2E2eUe3jDDVftv9fbOm/mhwcZgRpbch8cSl/7zGlLXDD3mGdZK/c3+Ux0ocjdtjKFPmypKIPQLkLVe7sLnDQpJacrnmnr6Mzu7TGKTSu+LytJFVz73jVRiIvZHQDfq5ovqCHRLO4rBdVjN0vm4lnxg1om3eaYDZm5WulWb91Y2QI8JRNv2IR/klNJIKsMB984ZG7pwkg1ENZv8S0tui2c2qhI4ZuZWj/xGNqRuLfS7GGafi8wASFP2naCLfqM7nnEgY/bi8C+zkn/cXy0uEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0EBW75IgPpeXSEjzhLcwens7TER12JKPOaCak+JmX4=;
 b=QXTVXJU1Q/7/tDT+n8gAzcj478PDT77HbzYlCIJyAUgRizrZ3iH/fNShTMT+d87gEQA1wmBnAFJF5I9Wm0gT99+SnBW22yNs+xZcnz5cZy12whgxKglwRUQaNMXc64pSc3me9G2JkqzfToTqhKSlsfHi1EdP3ltH2TLOj4jTTl0a0IfO9qc8jYb6QF6dx9Rgr6W+qVoU2hOPeDGfpGPvCt0BrcR/f39Pzh4NYQ0ol1wK9MdwfIUfY1zcCSoxACLYVpddKLSVDYv8kOHzCOhzpXlii4p4K7M2LL4e2IUgh3ECDYepWN0ENIxij0HU0x219eGxigfSzUv31e9QqI+/sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0EBW75IgPpeXSEjzhLcwens7TER12JKPOaCak+JmX4=;
 b=gtDjJ+lx1Sk6QXrXj6DqGqkzzRUDyfAHNr7r+zwn+veV2VhvMGLODqZWX60y5lGkGXFAzt/MXgRsgDNZCua1zN6IY90eL/3RQWtCG9g8MVW4SkR25jf0huOKgjElZ5L8ZKkeJXUhxYl6XLkamzoCf6ZorL82os4LfKiiChLo6yc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 07:56:13 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 07:56:13 +0000
Message-ID: <39589053-f82f-1213-d850-7928d9426de3@amd.com>
Date: Mon, 30 May 2022 09:56:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 7/7] drm/amdgpu: Stop any pending reset if another in
 progress.
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
 <20220525190447.239867-8-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220525190447.239867-8-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0242.eurprd06.prod.outlook.com
 (2603:10a6:20b:45f::10) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91b11807-f230-4cfa-e53a-08da4211ddd9
X-MS-TrafficTypeDiagnostic: CH2PR12MB4104:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB41048B38C991CBCC35B6C2FA83DD9@CH2PR12MB4104.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9M0K+KMho0OPGyy3w1tAy+moaebf7snef9Zz/HwrW0+AOclh030YHIkH3br5AFwjb3f25d7Tf4IxOjn0TcGaLWFUAqJeh5CSFXP658H+gsCLWLuKTCKXpDwiMHGlDQmZE32dyejYlpF/VsS7qnXXzBYCUxbPVk3ofI2kkH+Ng2i01VmgRXNTp6V8/iDXc45hvbbX5+nd39pfJ94ylnBS9/XcXq2lrRqQkzQv9xmQn51EPBuIsoWHOTJeIY1ZzyaQQKDf3Bi2ywbLUoqsCn0bdOK2WqwobcCalnYS2MyHiAGZO9FcKCvWeneJUlhsz/fUghTtg24GGPzp6GoQZJ0huRzHqQSby5OWZY6gb9sBpjpTfczq+ZOF3SnSGt0jqx+Kp5ktOY4dbn+IXJiEUGlPkzVxkA//nRQjfz3YcVOqPafkpKTeYwndf3tqYUUjkKClDsmXgbvY/fnljVyPDfy6LvEYJrupbNJFfFZckmLzo3/H9czGDYzrHrT/PQ95Hqlo36NNEZZroZDJxkHsvy/ZRRMtxI+wDMbUiSb1rPy+zqCGl/fBUK1aqvu6lcb/ntuc4PIjrfZZl/AtWJorUx8gN+GA5LMFHtNDOMS5nfYoWlF7IMClQAajOu9qdbwE1tl0fS9Fn4oXTEfHqdjlt+gk/RsIQAdY6cZb91mJI0XKV54UFBZH9nU49ALTb76uRDJQ3LyIWINe6iSI3G72FcIC88OQcb2HN1zphmuZMSfJ5bk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(5660300002)(66556008)(4326008)(8676002)(66476007)(508600001)(83380400001)(186003)(31696002)(6486002)(8936002)(86362001)(26005)(6512007)(38100700002)(2616005)(6506007)(6666004)(2906002)(36756003)(31686004)(66574015)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVRRdEZiWGE3by9FNEVvMXg1K1l1cDF0OUtUQmJ3NzB0VUxFY0U2TjZtdjBH?=
 =?utf-8?B?RU16MmQydVBPOHY4Q0lhaGJ0QkdHbi8vM1dKVlU5MVFRTmdFcERNOXRuSmpO?=
 =?utf-8?B?c3JYdWo5dFl1RVZRYUY2dWxsZlhNaHorZWMvQzliZEc5KzFTelJDYVlLMmtj?=
 =?utf-8?B?QURBYzJvcXdIRy8rcUdlbWU1cTlicjcyQU91STNvVk9wdm4vbjFnMjY3R3Jh?=
 =?utf-8?B?ZmFLQmtMY3ptRUVSMS9iUmJDM1J2T0pLUEFyNi96WkM5Q1ZkOE9CM3FhUjJT?=
 =?utf-8?B?eGtCeGN5SGlXckY0OVllWTNqVUlucjkwVnpQb3ZxOHd0cjRuRUJMaE0rbzVC?=
 =?utf-8?B?TnFSL2NNZjNPZC96cXhiVjVEMGJ1SUtUenpFSFV3N0dDRy91SmlBNUNTSWMr?=
 =?utf-8?B?U0NLTzNZa3YyT1hQc3JWelVtd2hUNzFuTmJUWlZ2Rm51bzVXR2NJM25aTDNS?=
 =?utf-8?B?QmdSZlJnMDdwVUltRU9vY2VKS0ZadFVoaXpIVHJFME5kQWYxaUJuZ2FXak1h?=
 =?utf-8?B?bjJjTUJkTDZ2bHM4bHNUTDBzclVjQlVCTUpUdFR2dU8zMmNaVGlmY2dBeWZm?=
 =?utf-8?B?bThnVU90MVI2VytoTVpZWVRRcjB6M0ZRV0VhTWZNbWNKTllnaFFJdFVFUE44?=
 =?utf-8?B?WENQdmVQRkxrREx3cE1yb2lRL1JITmxmcnBzeVl6d2hyYmRxSlhwMTVobUVD?=
 =?utf-8?B?alNiRjRQRkVFSm0rczlaTXd3UjNTeEtNRmxTWU1mK0pJNG9jaHRsRTAzdDl3?=
 =?utf-8?B?aHZxZllOSy9uZWtmT3pJZ09DT0RVbE5kSStjRHZKWDcrc0JEZm9MSmFxbysr?=
 =?utf-8?B?dDh4ekhGSU1ETmNsWGlneXFROGFzdm1pcENENVNkQTkxNWF4c3ByTkhyQWlQ?=
 =?utf-8?B?SU4xTTR6TzA4cHNZT1BhcUZXZ1J0WWlNdlkvSFY0bk95cjhWdWs0eWN3ODZD?=
 =?utf-8?B?T1Q3enNwVGpNR1dsd3FjVEpaUVBuVmJjRlI4aUhiZG1WWXBJaVlRZ2laQ0tw?=
 =?utf-8?B?MEQ1UGc3NTN5ek9yZEhENVVwWGhmek9FSXRINlZGa0g0YWdOT3l3UWJma2pN?=
 =?utf-8?B?VWNWR2NyY0ttVTVsYXhJK3pCZjdTUjExbHBXRmZVVGJlUlRCeGJsZDh4RUhU?=
 =?utf-8?B?VWlXTE05dG1XL3dtbVZtczhSaWRrc1Nta3lzN01OTk45bWVpS3paTWNDY3FK?=
 =?utf-8?B?N3hDTGpPV1hpOFBYbWRFNnd4VlVQajE4RjF5M29EdW16MU5UeGRpMnptMmJW?=
 =?utf-8?B?ZHhVQnhhQW9UV0VJaVUrYWNnMEJTMDNtQVJnTExNUUZ5d0xJTWRzM0ZBVGRq?=
 =?utf-8?B?WmJTenUweC92U3d0bTlYa1lKRXNQTThSQVFDamtIWVhPbDNzKzRRMEUwNjYz?=
 =?utf-8?B?SnZ2RzRIVmJGRVVYNWE5QWo0RFBmS0dQYWZtM1FqWm15U1NWblZNT1ZrWFE3?=
 =?utf-8?B?Y0w3TkdMU2pxMmhkVjdSZUJwY1o5L2RXVUdxVVpJV1BNazFVVGNnZk15QTNL?=
 =?utf-8?B?WlNEcUxJN3RpM2NTdmRsdkJrTHUzYUFrcm92VjZCWGU4VVdpY2x6dk5LMXVU?=
 =?utf-8?B?OCs2MUtROTAzQzVtTk1xVS9aTW1jV242WE1Udi9ZazZ5Wlpod1JCWGdHYlIr?=
 =?utf-8?B?aXRoZk1VSE1BWXU2NDB3SzFyaDBaQ2lFQ3hPY0k5NlVtUWZCTEpsNitiNnBZ?=
 =?utf-8?B?UVgybGQ5YldJZ1QvTm5pUi9YQXE3TG56d1A1MlErLzBON3lIUXZKVEtuR2pY?=
 =?utf-8?B?dUk4SmtiTzN6UHBxdlpJaWhRdGJEVWdPbUsxMXIzV2dIdVgyT2pFRnhnRHdH?=
 =?utf-8?B?Z2Fta0pGYk9waUpoUDZPdlo1OUpwaFM0V0V1MWxxWGNKUzV1b2NjQUtiSjN0?=
 =?utf-8?B?ckU3Q2Y0VXVjdDFCMHNPZDJTYVNhZ3c3WjFPcm04dElaSlRvemhSaVE3NThJ?=
 =?utf-8?B?MU8rNWhnVjhuc1VKRFo4Z25nbTZWajBXMFlxV1FUTE1LUnE3UjRlVmhTYnd5?=
 =?utf-8?B?a3BSWkxTMlJTc0pIQXR1YWVrQlo0RGhyY3RvSWpDQzdXamM0WWdYZXVWdmxC?=
 =?utf-8?B?NG9zZDJUMnVuM2FBSWhMY01rejNOcS90K0p4RVNpYWtBQ1NuUlNkakNpOXVQ?=
 =?utf-8?B?clRLR0laOEltbU40NGpReStmYnMxdmsvT0Fxd2pzWVErN2FPWnZYK2V1OWh0?=
 =?utf-8?B?NTBrWExhYW96Q1l6UWF2MU5KSVY4Y3NIdTRMb3pMMUhkdFprSUhuWXV6UUJz?=
 =?utf-8?B?b2Vtek92WGRHTjJjYVcySnZTazhVaXdEUmlNK01GYUx1eXZoWVQ1MjBTc2pO?=
 =?utf-8?B?aTZkUTJlREozMGl4T2hMVkprZ0lDVTMvWHN6ZnFrUktNSkdEd2JTZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b11807-f230-4cfa-e53a-08da4211ddd9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 07:56:13.2299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMU9ppQJEjGU+p1t+T6u2eoWNFvkfWSdV0yRBe+DBJLjNYrsmr6t72QIJIMMEpI6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104
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
Cc: Zoy.Bai@amd.com, lijo.lazar@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.05.22 um 21:04 schrieb Andrey Grodzovsky:
> We skip rest requests if another one is already in progress.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 27 ++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 424571e46cf5..e1f7ee604ea4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5054,6 +5054,27 @@ static void amdgpu_device_recheck_guilty_jobs(
>   	}
>   }
>   
> +static inline void amdggpu_device_stop_pedning_resets(struct amdgpu_device* adev)
> +{
> +	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> +
> +#if defined(CONFIG_DEBUG_FS)
> +	if (!amdgpu_sriov_vf(adev))
> +		cancel_work(&adev->reset_work);
> +#endif
> +
> +	if (adev->kfd.dev)
> +		cancel_work(&adev->kfd.reset_work);
> +
> +	if (amdgpu_sriov_vf(adev))
> +		cancel_work(&adev->virt.flr_work);
> +
> +	if (con && adev->ras_enabled)
> +		cancel_work(&con->recovery_work);
> +
> +}
> +
> +
>   /**
>    * amdgpu_device_gpu_recover - reset the asic and recover scheduler
>    *
> @@ -5209,6 +5230,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   				  r, adev_to_drm(tmp_adev)->unique);
>   			tmp_adev->asic_reset_res = r;
>   		}
> +
> +		/*
> +		 * Drop all pending non scheduler resets. Scheduler resets
> +		 * were already dropped during drm_sched_stop
> +		 */
> +		amdggpu_device_stop_pedning_resets(tmp_adev);
>   	}
>   
>   	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));

