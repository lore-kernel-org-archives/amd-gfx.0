Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0924FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 06:56:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FB518BBD8;
	Tue, 12 Jul 2022 06:56:50 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2077.outbound.protection.outlook.com [40.107.212.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EE1E8BD3C
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 06:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWPp00KkoggkZtgm0oIZvdD1HLhjUdDtLdV13kH1FBEqjslX5IqBFXRLDCg+sTmNPHACX9vr0lyyI41lupkb5GbLF6wukDrgXOcTOI7EPsd2hSCP6wrOnZ27VJGxWawk701VeFcNvFwFwIiR0yDiA29VngtCHZZlGkpTqsjbDtO/EPOYGjVOhFCT5MNQFwAyaQUYWQ9Pf3PnSqdyZ5OVPxIv2TUYoDyd8Z+yskOOn8Snu44ZtvVyrrIVf8MjDjQewzvMQIIxUNMFRh+gIvgJ1CIus8+iz5snGDmvQF515cbaV3zDzAGZQeMT/UaNxxEefimmoZpD08tHUR67HB58xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnGKwWQGXCrzYv4CLnDXEBr2pgQXxnOW79/VheaNso4=;
 b=AjLsQSQng3BWIBlxj8cWWMLcPZR66l++JIRM7Wix/7UXNvEEkHwWE5yMjFC16wpTtDOVozxqGspnCXPkDCZAQvxDoWx7J1+l1pKCSd7sW6CeVtPSxQ+DQxml8uPthoULzVbRc4GgbotgX+H0g15PC1uzO98zlSCYsPlUGjGAG0TSXoGr7fM57f85F1yCsUjTavImg/mHm3jr4TasQu7k2V+W+MGsK5mFK9m1yQrDtxVF0B+zssLV1hIBf+6ltJmGrM58Umn9d78WL299hZjzEM6Zp523lxj0oq0dTY9rqunNcWxs2P5qvzsLONDlfibN2uGYLNH+LjmvQs9yb9B94Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnGKwWQGXCrzYv4CLnDXEBr2pgQXxnOW79/VheaNso4=;
 b=33K4feFL6yIG29LymWCTDc4K542fTLyhqZoirU6VcXyY7zfr58oGEurhs8JdDVxNNtp+jdUF9oEaJUwpjnJ8Y//tOygW+OW44wN/Iq47sS5oZxNrHs4ldpTH1Jz35hpIOaRTbQcBLecx0BTn4yvkQ3GIvV71ZKVeu8qqYomvCFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 06:56:45 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::41b6:a196:4f46:c9b0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::41b6:a196:4f46:c9b0%5]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 06:56:41 +0000
Message-ID: <29f2d302-8891-944c-49fd-f468c81c8d4c@amd.com>
Date: Tue, 12 Jul 2022 12:26:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] drm/amdgpu: use cached baco flag as the check in
 runpm (v2)
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, hawking.zhang@amd.com, evan.quan@amd.com,
 kenneth.feng@amd.com
References: <20220712063827.28300-1-guchun.chen@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220712063827.28300-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0187.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::10) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 217306ec-04c8-4c29-413a-08da63d3ac97
X-MS-TrafficTypeDiagnostic: BL3PR12MB6571:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3tLAzYuKkI1nYqr9PYitnfMvBZRNwLtLOciOe1yyjtKFQr4RTOKwfNJeI3Na62nqbf2R3LR4uNPhZC9yFl6k/jCWA/eBFDHx+AQy7XHg/amaL/D/OMCoxIs/4mMKRYLz0JAm9eLsj07P18lSzmkQ7CRuwFmBGrNxyoY1Boc8ZMBnOQ2+1+pP/BNxW6o96OJFHScx3eqDexfYRAHCKQl1PvNm+lw/2VNFS0ZQE/kEBQGi7bXNpzD21JTlrAACjLo0k9QIhl7Iyco+k7RT7XQ/6G3tXYoO27QZmmYJVj8dzODCPJiSeEbGeMprvuUG7T2rSkbTR+8RNB1bsKbOernrqOJS6qrMMXEgIYL+Cewh04xIz+nORswTOyL2UajNXYqqUoGYtttzkK9g073x8ua8x0iLNmt8gA/zsB882F5hstTo3oAEapNk6U75vUjMOnTr7qoINsNc/NSWlaWS0eJQ3+cQWbYBRPRXbFIDhI7dDrjlw+/nzUdREJqTak+GzenLO4n3V4CGubVYYvG/JToX0CYOtZXWZk8E1SFfnQJLTg6lTSghKXBvmfN3FOOp42wb+b1JRWJx5AJNovY2JI5EFDy1ncTz2grkwg7F7AH2YS8W4KFf8lnoM8HLlF2dVXgEU3Ki6FMWfsc+8GOxRvyAGtTRpadX5e0SfI4J+fHs31IQAovhDWJFNbrc0g//IW9cj7J/xQ5vZLx05jij+vPNeXRe5ZoFDPuNP3sJAfzz35YPzZnUb/4YUxoquXCHiwY+ttdQxdceoXNDAHGNZIqlnS3LfPQg1TFQ984j86x9rgJX2LocdWZr/EhJ6cq00Lr00Hytx1UrqCklmtgKtmK2gyU1ZpSD2LZivZ1MqtR+qRVaVWFCJg5FurcTqrAvAjmk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(6486002)(6636002)(966005)(31696002)(86362001)(478600001)(41300700001)(36756003)(26005)(6666004)(2616005)(38100700002)(53546011)(66946007)(66476007)(8676002)(66556008)(316002)(186003)(31686004)(6506007)(5660300002)(8936002)(2906002)(83380400001)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1Uyc1NNY2VDc2hqYkNLdEd4ZXBjV0tLV2hNR0RyeDV3USs0ZVBGaHdnd1Fx?=
 =?utf-8?B?dEJ4bzJoSTRHT3RGRlJ2UWt6M08wZytSWS82ekdJUzZVeFlIY2FmME4zL25h?=
 =?utf-8?B?NUwxTmdiNGxCTVNadTZmLzFNNWd6UnRJTjhIR1NkWnlSMU5DN0hQU3NNSWYr?=
 =?utf-8?B?OG10cVpTanM0ZHh4ZXpORzNzZHBsUHNsUGtYUFlPVmJmQmk4aW40K2xRN0pJ?=
 =?utf-8?B?TVU5T3V1bmJpdlVmVytXNkdqT2lVbnFteG5hYWtjRU05eW5wdkNuSWVkREto?=
 =?utf-8?B?SFhqNlJ2VDNINXhJSS9hWkp6K0NTS1lKUktXRmxxS3R6UU5LSkg0eFJKd1d1?=
 =?utf-8?B?cjArV2EyYWkxUkxsRHRYUUxaVzVEeXhtUGFQWTh4WVlSamZmNkVGUWhIRU11?=
 =?utf-8?B?WXhwWSt6cEJhSncva1lPcWlzRmNodmpSRVNUV0NjZUFHZkQ5bUNTOW13QVp4?=
 =?utf-8?B?VGNPbm43QjlnT2FMN0xVZFRUUmNieW95eUxJanFTcnUrUWg3WlNVNE04YXdE?=
 =?utf-8?B?L3BXRVI3Tk92Z2M4QzdMVW9HZnBEK0lKUXhybzRRUElTVXM0WEdzN0dseEUx?=
 =?utf-8?B?bHV6OHFHdDdhZS9qOEdOclJVNG5GdEpXTjV0MGVISE1pU0JscFVFQVZhdjFD?=
 =?utf-8?B?T1BnbDdRQ2lmRkwzWXVvKzFkMHplc0t1UXdnbjFGcWZzRkVXSjFHdDF2U01X?=
 =?utf-8?B?eEIyTDNjbGVJK2NhNWd0VUxtQjVHc3kxMHVMckdJYWFyTkRWM1RyWGx2NkNp?=
 =?utf-8?B?S0hFb2FaR2VsS3ZpNlhaU3NDM3hiemVXd3FaSnNCMU92WUdxWVFCakNXcFRC?=
 =?utf-8?B?ZXFiQ0VXUDB2WmRCYnB2Sm0wWnkrR0dvWTFuSkwxd2xrcS9YcFBXcFA5OVdQ?=
 =?utf-8?B?RS92aUxhSWtHOEcrZzVybmR4UUhVa0pWVkJqRmc2WjFsSUxmTUR4ZVhESmFM?=
 =?utf-8?B?Q3h3Vk5wTDBCWVMzTytyVmpYTkFSSlU4eXpRc1BiQzlIM3VUMWxnR0dFWEth?=
 =?utf-8?B?eXBDSnRxZkdHcFVLRWNNcFdMbU9WUTUrR3dvWjBOR0lFenZuTHFrUzVIZnNi?=
 =?utf-8?B?M21Senk4SVNMNGdTclpsdFo2VDBscks2N0VnTUg0WGVIQjU5TldqZGdzZ1pp?=
 =?utf-8?B?TGhSRG1XZHcvNmlVN3BOWTVGQXZxVEJ3aVd2U1h5MExkblRjM2Z1aW9vREhB?=
 =?utf-8?B?aDZSQXdJbGN3RE01MDFpYnBML2liSUtvWjRYZitaRFBFM3JzZlNwcXRYNDlJ?=
 =?utf-8?B?Q3dOWWpZbThuZkprRUlvWU94QnB4VTRZZVVoM3VLQUM0ZWhCZEYyUlY0R1Zm?=
 =?utf-8?B?Qi9Ya1IzYkdoN3dCeGYzSEdjMUhYM1RPMEhydXJTSXlTVERHNUhteEtqRjRN?=
 =?utf-8?B?d0tjRTNyRXdhQkVJWVRFVFNtWi9EMWVwWE8rMGhNRXJqRlp4VUZaRm9zV3RK?=
 =?utf-8?B?L3FiNWRORDRnZkJsYkVaMDhIc292VHZIWnNjY2NoUG8vSXpSVCtCM2JpN0RC?=
 =?utf-8?B?SVNsZm83SzBQaXNvZHcrbkd3N0owSmRwazg3UUJXL2tBSGxFVzdnSXpza0RE?=
 =?utf-8?B?S05TT2lyeEhRVWlYejlGWEM3YTJWUnhENTRsZDdGWnRnQldsRXZYWnNKbTZn?=
 =?utf-8?B?OVhHeTVmWWlvK201MmdxZUlVME9VNGoxY0J4QjBKRldWaHNqK29sSG8zRmtH?=
 =?utf-8?B?YXB2TlhKSS9KMUg0cFd0RC9ub1hwV3lqMUdVd3RYSVFETkNiM3VmaVZrWXNI?=
 =?utf-8?B?Z1JMTHcvZGw5NWg2N3dhY0ZiT0NTeVZvcXF4SU1RV3ovNVA0amxrS1hWYmN5?=
 =?utf-8?B?Zk1TNkJrZll2UEFkYysvNUFpcjVBSmhqaTV1NjFERVpnZTFJTC9CY3gzUHRk?=
 =?utf-8?B?V3pjR2VsUnE5c3JzbCtqdVg1OGowanNYb2w2SlVmMzVLeXdXa1oyS3hnQXpz?=
 =?utf-8?B?eHNtRmtRdW1UbllLNWtOMGRMRk9mbVY1eGpEUE9UNWtJTndUckMzMlkvREtR?=
 =?utf-8?B?RTJYMWFwMitub1gvWmZIL1RDVkNTZHlwRjN2cTRrMGQ1dVZnT2hZQ3lZSVZL?=
 =?utf-8?B?V2lmZ0tGQklEelBMMitpUjMwTXVFZklrb29aVmNXdERPZHBQR0s4QVNQU3gr?=
 =?utf-8?Q?AmbBZyAFpCaPp86HIVb8lBc2S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217306ec-04c8-4c29-413a-08da63d3ac97
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 06:56:41.5095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByNrPnTA1Bpmu9KUpig8b9TuqjZewO76GE6TVw85um5VAzrqXCOP7SOVvbjjdCty
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6571
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

Instead of doing this way, suggest to cache the run_pm_mode in

struct amdgpu_pm {
}

You could cache the run_pm modes in kms logic - 
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c#L183

Afterwards, you may use the cached value for any check

For ex: adev->pm.run_pm_mode == AMDGPU_RPM_BACO

Thanks,
Lijo

On 7/12/2022 12:08 PM, Guchun Chen wrote:
> SMU will perform dpm disablement when entering BACO,
> and enable them later on, so talking to SMU to get
> enabled features mask in runpm cycle as BACO support
> check is not reliable. Hence, use a cached baco flag
> to fix it.
> 
> v2: cache this flag in load sequence to simplify code (from Evan)
> 
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 +++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
>   4 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 845d6054992a..816f813a5df2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1014,6 +1014,7 @@ struct amdgpu_device {
>   	bool                            runpm;
>   	bool                            in_runpm;
>   	bool                            has_pr3;
> +	bool				is_baco_supported;
>   
>   	bool                            pm_sysfs_en;
>   	bool                            ucode_sysfs_en;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 1cc9260e75de..c3f870c01c47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2513,7 +2513,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>   		drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
>   	} else if (amdgpu_device_supports_boco(drm_dev)) {
>   		/* nothing to do */
> -	} else if (amdgpu_device_supports_baco(drm_dev)) {
> +	} else if (adev->is_baco_supported) {
>   		amdgpu_device_baco_enter(drm_dev);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 4b663866d33a..532406d32fba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -188,8 +188,10 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>   
>   		amdgpu_runtime_pm_quirk(adev);
>   
> -		if (adev->runpm)
> +		if (adev->runpm) {
>   			dev_info(adev->dev, "Using BACO for runtime pm\n");
> +			adev->is_baco_supported = true;
> +		}
>   	}
>   
>   	/* Call ACPI methods: require modeset init
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index de59dc051340..f05d7ac03122 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2353,7 +2353,7 @@ static int psp_load_smu_fw(struct psp_context *psp)
>   	 */
>   	if (adev->in_runpm &&
>   	    !amdgpu_device_supports_boco(adev_to_drm(adev)) &&
> -	    amdgpu_device_supports_baco(adev_to_drm(adev)))
> +	    adev->is_baco_supported)
>   		return 0;
>   
>   	if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
> 
