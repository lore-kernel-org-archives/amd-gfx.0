Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F59C07548
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 05:28:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC75C10E4E9;
	Wed, 15 Nov 2023 05:28:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 691CB10E4E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 05:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDPfHC7d06e72ZqFJVNtbPFLeqDKe+L05FMAred4Ix5SGMeZBRacuNKsXKKen+Mnim743+ZBjQ06gtyrLi4fvypYF/1GPxS1OYXB7i4eSlttOslqUFw9yHV58gNGjgCIuHwe3yIgDeI3r3tBPxSKxc5zZ/YT/u5EoMuOjSRh+bjcblnkZlLHT/eoJlCMUu+XLxnXRlwXZ4ISIutAP+jUv2vsBE2g9lY7ft90b9MkLM3b2OygeoVY4aKqX3DCOfT0R8WH9ubHSmfW3Aup0/uRpQf8QX116wq+xI252/p8v5+2KYDeTzsDqxzrKs+qUZ7p+NSyW8pkhueUZDAbH+TU8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfBKDIjZdGlVpCbFkP/HpNcn5ZtTrFZGfiXQJFucCYE=;
 b=GwxOS32iF12LHgvbd/ONe4iu5hfIhIlO0s47pzuOLpe8NaUB5YF/78nLweBbwp2Vb4lnOnjwUq3ZfrOqdSSh4MoNwcOtN9BEz9ZLFkCE6AtwId61c9dUiPEwVl9WsD7dIa8dHcaBNoxdrFT/JYcbLgVZxZS6rzYmW7wfZIESqIrduX6dCxjejXlfAx7YpxlWgPOSS0zOmJ5/wf9shl35tOGK/sgSwFWgIil76PyAQJobxnkUpmXl2D4ScjljZHmOUySg5lEh2KDvAnaFKLhRcAv+mDZU42Kmdtgb8etgY7ZIAtyyA8UgX/sWd24ffxwTacFPQdKHQIYB75JwkIB6BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfBKDIjZdGlVpCbFkP/HpNcn5ZtTrFZGfiXQJFucCYE=;
 b=dM9RfyEg1/T/56mBzmHROwMEJuI7oXjMlxlUfcr5Cz74aPDTwlaU9wait+E9gWuXp+E51yYgHWN4I7FrUH3ZMxyf3cSstia+5VzeBwXKEMnvFW077TWrFS/0OQJfVTX+V4F46olEUPo0rj5GYEnIRe/BSkj3ex2axz635U8szvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SA3PR12MB8809.namprd12.prod.outlook.com (2603:10b6:806:31f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 05:27:56 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c258:1e94:a85b:1510]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c258:1e94:a85b:1510%4]) with mapi id 15.20.6977.032; Wed, 15 Nov 2023
 05:27:56 +0000
Message-ID: <e523f30c-6af5-ad1d-ae22-7d0d9c72c563@amd.com>
Date: Wed, 15 Nov 2023 10:57:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amd/pm: Fix the error of dpm_enabled flag
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Kenneth.Feng@amd.com, Alexander.Deucher@amd.com, kevinyang.wang@amd.com
References: <20231115051808.357777-1-Jun.Ma2@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231115051808.357777-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::17) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SA3PR12MB8809:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf0162e-2e79-436c-8c0c-08dbe59b9f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SBsOVBzM9jeNI+JYrm5U+IZB+iFcCcA/+fIlEZ+Z0w9hH2TcYznYiLCDJHt8GulAGIkB7fIbXu8efm9q4pDYwL30jZ02cp50/kfnG/wmjY4FgGDti5Wixqc0wJohq5iCzV8orHrjt+NFQW2qzu+Qs69RhWSYbbsaT/1aayuFLVrRriPNmEFBw45hiAHu8uX7TNUPjRqi04clGuBODDLWbRUc0MkhtfiS/PqURb3Ux4FOL+SwrO+nBU9fjspK8C36UIkML+CYTru/Y6K/vRJnrSft0AbNXHuV1QzK6ECU+0k/mVvQ+X0Gz/VeB/OMaIm5eSCGvnSeJUt1v28oaMHlREK5wHhmEtmirrwMGdJ9/MMMUYTnttNXfxNHRxC9FlcS3AwrhE327fw91Uil+HCQ2xp1+GS0B90uDDUAMemgwu1LtPKSX5agKBhD2m2BLkduH/rTAKBxU2RThITYbtPi8bxEhbEcrB+0domTJtRcCrb7lXMCGX8UrV/34pDQNs6lAEGIoy+BgEI/jDn8ZiMuB7lHMVTZgHTUkJMSNZoEBMENGHDZhJ7v6dCrANPdK8Ovbpn/JNR9jBoDjj5lC62D9YlwgrAPoykpa1xEc1zSwtmsfayoGrQvaEKkdvEXEw2ZWBID8jdotgFPF9qukX4wwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6636002)(5660300002)(6486002)(31696002)(86362001)(6512007)(36756003)(316002)(8936002)(8676002)(66556008)(66476007)(66946007)(41300700001)(31686004)(2906002)(38100700002)(26005)(2616005)(83380400001)(6666004)(6506007)(478600001)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUxvS1VDNVh1bWpNdCt5aVFrSk1HU01YZUFlUWFkb0Fnb2dLQ0RFZFQ3VDNW?=
 =?utf-8?B?bnB5MnVmL1F5MmNqSVkrRm13M3dzTDBDRzFVQ2hTMXdubkxRdnFIaFd1YnEz?=
 =?utf-8?B?czBVQytoWXhLbThzdVBCTUhQc1dkdWNDY0VsUUVPVlhBV1FremUrV0RlVk1r?=
 =?utf-8?B?TXJ6Y1A2RVoraVRNcWM3MHZpUDFIempFSC85Yk12UTVuZ0o5ZWtuR0lBdWVs?=
 =?utf-8?B?b3FOdnBnRUY2UkhvZ0ZFYTJHMDVCSWF3UTVDaHNLRUhWejR5L1lBVFFlaWRu?=
 =?utf-8?B?WDV0cHd2Nk90bk5ZelNtbTFZcXhRL0R6WnVIOUt6TnF3K2huMUdRMnBQYkQ3?=
 =?utf-8?B?ZjdWTFVuWnRhM0VFU1o2cEhvd0tmV0ZjNmpsZTJqVkEzaTU2RzYxZ1F5TGxM?=
 =?utf-8?B?Q0tqS08wMWx2SXZtY0tvZDRaNm5qTkwxdFgvcUcxTUVnY3pqeXMrbnJleis1?=
 =?utf-8?B?Wkt1aUNTRm5Fc1JnaEdiUlJkUURiMjBLYVRLVWNQWDYrdzIwY2tNNXNGblJv?=
 =?utf-8?B?VmZhU2tUOHBCR1pCOERIS09FSWw0MmRyajNna1lqay9qeGxLanVwaGhUKzRV?=
 =?utf-8?B?TWMwVTZ0TjR5L3cvcURrdkxaQlBsZGJuQ3h5RElKenJjYVFQSUJIa3JsaktL?=
 =?utf-8?B?ZHpNM2Z2dmlRNHNsVHNPY0oweGhPM21Kait5MnJyVm1WczhNNDVLZXZPOXFr?=
 =?utf-8?B?RUM5QlJod3RqSXhmaTlyanMzRFRPUXVVWmJFcFZSTENublVoTE1yNHlZdVhR?=
 =?utf-8?B?SFQxUjdjVnh3SjgrTXd4Qy9GeWNFS1MyelRpWDVnSG9CZ1pHZUcvVHdBK1J3?=
 =?utf-8?B?TktYN3Z5ZHZ6YTNvRno1Y0VxWG9jZTFRUmdNdkp1TFRSREhkWVZzZ1BHRjNK?=
 =?utf-8?B?Y2pMa3Mva1NKSUlDT2FOaUc5YlB4dEdTOHlHVUhaKytkZERQK3lmTnlPdmY0?=
 =?utf-8?B?b3RTMGgwNW1EWHlwdmh0bTVPSGdLcHNUcHRtMUZNRUIyMHl0S0k0UkM4WHk3?=
 =?utf-8?B?WktCdUxSRDBiWW90YUhONzMrdDhJKy8wMWxZaWwyUHJpcGo4bDZid3FiQmMw?=
 =?utf-8?B?MHRpdTFJcGtKV2daU1FQL243NGMrT0lNT0JvSFJEMFpkcGZXejBkeTNSTHRN?=
 =?utf-8?B?Mklkek8yMDE1T2E2V0E2SXVXR0Z1bDV1S3YrZGJiSGd0eU04TjJBTHpxV0pG?=
 =?utf-8?B?bUN1RXlNbDJiUzl5SElTSWZGVnprY3RWMkUyd05nVnNBOStyN3lSMklQcXd4?=
 =?utf-8?B?ajVuNXh3aE5pR0t4bENFUkZJdTlUeHU3UCtTbVBkdm5CTGVtWFRxd3UzbXRj?=
 =?utf-8?B?OHFyT056azdHUEhGYWs2TWdpTGZaWUpoc3U1Q3dIWjB0L00xZVhlem14V3Bl?=
 =?utf-8?B?TGpsSkgyd3NYZXVQeVVwTE9XQUFFZUUxVU9uNGJjTElWOW4vb0hQR2dIeCto?=
 =?utf-8?B?V3dWWk4rM2ZUTUlRcE5xY0oraHl4Z1VNSVV4QSt5NDNYOTJlT2RPMGc0WTVM?=
 =?utf-8?B?aGFZSytwa0s0T2JBM1NjTFlIQ2FQTFpnbXBDYTRhNzdxZ1NlbnRHaHkvWmpt?=
 =?utf-8?B?TzFnNjlVMTN6elM5V2VzR0Y3bkRyMlNSZmIvS0NrOWRTNUJvOTFPSDVQK0x6?=
 =?utf-8?B?UDBJQVFwd0RzN1VQMEYwUm1FVGtRL0orQ3o1amgvQ2hwdVlacmJsSVNoV1FU?=
 =?utf-8?B?NnRlR2J2Qy9BdGJESVRkUjUvbXZINTZiSTBwS0swbVdPZDcxcGhHSFVEenl3?=
 =?utf-8?B?NWU4UitEbHBzS2hMZjYxcW9palpVZGFCQ29xWXFEaE9wbThlV2lxMnJMTEZZ?=
 =?utf-8?B?ejBtaXB3OHIzeUlSTjdHU1Nib3lTb0N0OC9VeUhDL0txOUxJeEdzanozRmZK?=
 =?utf-8?B?b0t0MDFzWHZtRjJyRHBibTNGc1hqckh5Y2c5Nm9wYlppVHg1TExHT0RqUFIy?=
 =?utf-8?B?NFcvcTYzd0Y5TnlrdVlRNXRFQjVTbWIwRitqSWlzL1FuTldhNnZ2S29BQUl5?=
 =?utf-8?B?QStuekk4UnY0bUhrQlZIVWc1ck42Z2x2alI5Wm1lQ0VOeUhuMW1MQ2FjMGZN?=
 =?utf-8?B?SmNUanhLYU5tR1JEdTRnZDdPY3JIdk1XWjlzZUhnbkNLT2tvbDZjTUU3WWtz?=
 =?utf-8?Q?rL2f+6qXurkicgVFHIAVZi4RG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf0162e-2e79-436c-8c0c-08dbe59b9f1b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 05:27:55.9236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pbb9Fcs+E8Tu8DjKOxkV4jkXsM4s1cHnWNFqn3pb9SSnjYvoEUpiPWEyoJ258xrr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8809
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



On 11/15/2023 10:48 AM, Ma Jun wrote:
> Set dpm_enabled flag to false only when dpms is
> successfully disabled.
> 

This a software flag and we block many services based on this flag 
status. I think the purpose of setting it early is to block other 
service calls which could come in between. Did you find any real issue 
with this?

Thanks,
Lijo

> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 1b9896001172..4bb86315e8c1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1740,6 +1740,8 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
>   		return ret;
>   	}
>   
> +	adev->pm.dpm_enabled = false;
> +
>   	return 0;
>   }
>   
> @@ -1762,8 +1764,6 @@ static int smu_hw_fini(void *handle)
>   	if (!smu->pm_enabled)
>   		return 0;
>   
> -	adev->pm.dpm_enabled = false;
> -
>   	return smu_smc_hw_cleanup(smu);
>   }
>   
> @@ -1808,8 +1808,6 @@ static int smu_suspend(void *handle)
>   	if (!smu->pm_enabled)
>   		return 0;
>   
> -	adev->pm.dpm_enabled = false;
> -
>   	ret = smu_smc_hw_cleanup(smu);
>   	if (ret)
>   		return ret;
