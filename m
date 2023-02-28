Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C59C64EC7
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Feb 2023 08:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F78C10E49A;
	Tue, 28 Feb 2023 08:24:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35D2310E49A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Feb 2023 08:24:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwjqQ0bnwEpTmqXVp961AGxRzknp0Z+klVy1al4WIf9aN6/ANcRCL0CDSQ5eYO8IuTpe8w2Vfx4QXfqHCH0zi4NL/5ciYUqwCdAIKC/YwczasrfifKakaR3Vy14dqm6AuaZnyyPZ+PE9PpRH7648m0pvcuUb7eFW/wDBK/GPu4T3L3OX695NcvRkbzSjDal9iXe8xXABiox1FmdJyjw28f4xilzR26k7f26R8JA59sxlyGNsoJ06nsGJ0gYAMMCKf3GM+6A/stszJ2Xckp+FIx+dE2bQyYHDPhSGoaeTLQkQkhgd9oP3Ss229nxvHMRB2bTH8He762hdAQgq8xdLJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KhAPtrNW0tpoDBBW8p+xo025KUajJIVAz1jmW1d/FY=;
 b=Cjx2gvOJeQwTC4Ad7RdzbD9nKTku86yMb5woqrhZww7IDm4YRqYWuEHOtTEx5NfQUoraOk4LG94ynJrij7yolXWXM86oN9W0HkkTEVNDEA/41BsB1NqjmgPYrJetsL2E42pmmQDEtinI0AYO/QTTkFTZ+0t0Db0ro4GxQrshPEMeLlBDh03KtRaj3dNfRxLPGaJ65rTJ5Wr/wnXQfHTWurvv09gBx/aOJFxXhaRLmf5hwuDJD8usK8ep5drPuvDO1bQL+qYASodnTPWWhIPZpEBLmHuXPwFShoJJsz/KgzSDu0P7go27+nR4khELvAdmEVx/t9VooS27787zZ1+E0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KhAPtrNW0tpoDBBW8p+xo025KUajJIVAz1jmW1d/FY=;
 b=W1JSd7jYQigpBE6M9rkWnfeE+mQQhdbJBZp28Qg1ynnIH9QGR2ZaCB+tuh9d2c+TIS4e7iTt9Aw7MAMZmn3AymMMiTEXaxm3ebGlER1SumvWKRS0B9IGhsOyd7CV5c2u3t8ehvovCdVfEpJb2cSBTIQYzpeCKrEVecp6pLsOZOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH7PR12MB5878.namprd12.prod.outlook.com (2603:10b6:510:1d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 08:24:05 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3e46:4948:b543:8dba]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3e46:4948:b543:8dba%2]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 08:24:05 +0000
Message-ID: <b0fc8660-dbc9-b424-1e4e-2cd18de8b94a@amd.com>
Date: Tue, 28 Feb 2023 13:53:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 3/3] drm/amd: Add special handling for system s0ix
 state w/ dGPUs
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230228044304.27940-1-mario.limonciello@amd.com>
 <20230228044304.27940-4-mario.limonciello@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230228044304.27940-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::9) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|PH7PR12MB5878:EE_
X-MS-Office365-Filtering-Correlation-Id: e163aa07-785f-47a1-4ddf-08db1965276a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iVXNrCBuQeVEWp9HI7v0OaOnRi3OFcsuBygfuR3tzm/75LImq0GUEo1u1FoVHB/9NU15vW8H5wiPwINmkbiCNPovUciH/p+xwT/mTHUd+VcVL6t5ucbLmmi09Ptq3DbL4k+bkW/1m65Wz+52isA3F45bwujz/JMXdLXM00TsoRIDlRUS+6sxk6P7C9eAUiMbbLK1vV7IxH/fe3QgA6BrWH5Cu8t1BHI5Hng4BJgLe5J8dmKI3vaztwNhKuFhRJ4kTu/whCmFTr+gl2AlRc2WfMDN7D6x71Coxrr0yiMBbI7ca3I4XRoErafW/RbZ6czhgojy6N7A04kSkwnZSd2JKv/rfEfcXrS4n/nhiz2ALcZmDJn9Jfm99mJE09/kYQfnjnIIbMX2p0j+pVcAyK9xw8ANaH1p7901WXDan/4gmiLbfUXUq8UlaNKGMm13ekI1ZFaqVZmlwk4bmmGqs9PbTtt8L3XRGUIpEVznAnLrPRL0omUBGFZ9UMQ0hs0CC05/zgPjjtQMo6hh7UnmF12U1bYChmkyMEGJqOvqV2ws3IXHrvXfLrGUSuktdqLuPsUMPmClyqrmQAJjq5Jx+jFkwJAwSmIdr48nwtUiuX+YRHqkL8YvACPnmeiK3iaCJfaVnZHMVa2+yVbPkFqGDy32OqkNiwaoV4XED0iVjupuGffMOxZ1cJ5AShH5JpKLkyk7XctO/g2amZsgCJX31lr9fyp1beBdsSezN9DS5LdTr5vdJFCIKDmaZ1eZokQVxS0O
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199018)(31686004)(8936002)(5660300002)(31696002)(26005)(186003)(316002)(66556008)(66476007)(8676002)(66946007)(41300700001)(4326008)(86362001)(36756003)(83380400001)(6486002)(478600001)(53546011)(2906002)(6506007)(6512007)(6666004)(2616005)(38100700002)(32563001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHdBQTNpcnhtcUpuTTZnQ3E0Umh4SGdiSjFlc2YybzRDRGEvNnJFaTRVQmN0?=
 =?utf-8?B?TmkzZjZ0dGJ5VGxWaHhkL3Z6KzE2NEQ4M1k3ZGFsTkhlMlN5UitEYmdDOE1z?=
 =?utf-8?B?OEpSNlVmTTZtWGlwVysyT1dRVW9PK3BsT1N0cGx6VVd6WkFuR2hXSVJXTkR6?=
 =?utf-8?B?U2xyNXhJYXhnazFEUTFjenlaYmJhRmhjTnFpMEFkaTZ5OWNaNmZIamZHakxU?=
 =?utf-8?B?dW43U0VCams0VThLU0U0N0ZwbDk4T2t4WTdTalR0SWdpRmIzck80NE9YM2ZQ?=
 =?utf-8?B?eDlQZXdDTjRsT1R2ejhBOXdLc3hiK0I0SHg2OUJUSW52ZUwwZmh1cG9lZHE1?=
 =?utf-8?B?TG1zOU80amlpUHFMTE0rUG4yZWdvWWx0U1VKVTRZK1ZCcVdVSGt5cjNyMVQw?=
 =?utf-8?B?bFRHUzBPajhSTzQydmp5ZTE0bklsWStPeDBnN1lzUklGcjlyQzh4YjgrVmtM?=
 =?utf-8?B?SmNpenYzbVpjSER5dEtES1pYKzVadWpsalNpeklGVzZuT2ttUkVEZ1FKaGwy?=
 =?utf-8?B?anFTa29ITGcrdnVUNWRGRkt5a0FDOGszNTBGR1hXcEpxak9VK0VNRVhEWWp5?=
 =?utf-8?B?YmR0dmxDd1VvWGZPMVpOWG1YaWhaSmp3SmVQMXR5TEhBeWpkcndSQzRwYkRZ?=
 =?utf-8?B?Wlh1VEpFOU9pUjZwcHFEWldhdFhLMms2U29wSHAzcHZybTFLemJqU2M4QTlu?=
 =?utf-8?B?dGJCc1BlcDN0V2J5VUdKSm9WWkt1TUozakpKZm9rcE5Eb085KzhkWXdOWGMx?=
 =?utf-8?B?WTk1YW9CUFhBQVNyMU12YjV0WjVIM1IzLys2aTBrc1RnY01qMDZ6WmJ1MlhB?=
 =?utf-8?B?QU8vRlZBeTh1Y3dBNENIdnZ5WnU2YXhiejR2bmo2c3FmQVN2c0M0THVHbElj?=
 =?utf-8?B?ZjlmcVdGR05zRVkxU2VMU1VxR0ZGc1RSZjczRDhGSk9qczE4dWhrQ3d0N3lw?=
 =?utf-8?B?Z2ZKMkE3VUd4czE4R1lMOTdxNjd5WFVFQUdmTWpYTEtNNkZFYk5pOUpsbUhS?=
 =?utf-8?B?dUxDR2oxblFjS0k4M3BQbWpycEpsQXBXUkMvSm1uejM2NWNQOGk0ZWZxY2cv?=
 =?utf-8?B?NjFndTVnTWJ3Qjh6SEN2UnlQKzA3NHlrZzRhOWJUeHV0TXpMa0NhckVjTmNK?=
 =?utf-8?B?YjI1U2NwZm5NSUk4MlVxSWFjUU9IY0ljUmNSWWE3NXVKL0tCKzRiWGthUldF?=
 =?utf-8?B?cjh1UUdyV0dLZ1FNbXByUEZiV3pZN1hkam8rbTlDMnRMNkw2a1AxdEJna0xU?=
 =?utf-8?B?UW9LYWVkUmVnZ2xtYlM0TU1aeDYxclhyS0NCNEx0VDR4YnNvb0VrbVRXZ2FN?=
 =?utf-8?B?TzJob2Z2U0E5L01RM1REOGpaamhWczBMVEYyR0FPQnBTbG4rRG5idG9lZkxY?=
 =?utf-8?B?TU1yRVhrR1h1d2FFSDliR1lwT1had1VpUnVCbmlNa3JNdmFxc1VUYlh0b21N?=
 =?utf-8?B?Q1ZWZDl2azZNTXRlNUZoSzVrM0VMalJxN1pEVDR1aUtLRUtPZUNDNi9OOHdB?=
 =?utf-8?B?QmJnMXVKMzdmOUlIME9VYXdtQUxHVkpHT2pmSVFPWG9SQWFJQzRTZ3dweG0w?=
 =?utf-8?B?cTBMUTJPdURqMXA5RTFVU3prWitlL3FxOFVoa2huWUJkdCtWbHZuZkd3djFn?=
 =?utf-8?B?VzhBRjd1dDVuektYRVZTWFExZXpGSlpIMDc0WFFVT0RraWVTcTF1Wmh3dDZy?=
 =?utf-8?B?T0loRnR0dkZsdGd3K2o5V0ZTM0JmWUdaelpjbVJVZDhiSHFqT1o2N0ZJK01G?=
 =?utf-8?B?WitSUi9LeUJBemVLc1pzU2UxSVlVcWtwSUNjRzByRkdkTmRBdEZ6aHRtblc1?=
 =?utf-8?B?L0MxMks0YWdObzNwelF5dzhmQXAvVjVEQVg2QjJzblNCeEFPZXlGMWNIdFdH?=
 =?utf-8?B?OXJVVk1QbnR3cVN1OVcwMSs0d1BQQTNPK1pwT1V4dlpRbUdxaXRBSzZFckU5?=
 =?utf-8?B?Z0RNQXdhUENBMUsyKyttZHlUSzVsWXVqNEx1dnQ1V1JVeHVIckxQQ2lhUFZI?=
 =?utf-8?B?OERyZlJhWm9qeGgxQmdkZitrRDdpejk5YkVxZy9iYkxRdE01VlVPZFBDaE94?=
 =?utf-8?B?NnIzZlIra2d0YzRUdlpoeFFWQ1dnYU50YkR5Y0hObTFROVVYeDZ2cXlkN3Rm?=
 =?utf-8?Q?anWcZZGl2bXOIgNRxT1QHXQ52?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e163aa07-785f-47a1-4ddf-08db1965276a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 08:24:05.0320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izvyK2HAKWfdf8A4KmPsMhWQ9HgSwlUe8o+dP/QGoHMZhjHjd/3VVoOKZ9s0epq3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5878
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
Cc: Peter Kopec <pekopec@redhat.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/28/2023 10:13 AM, Mario Limonciello wrote:
> With dGPUs that support BACO or BOCO we want them to go into those
> states when the system goes to s2idle.  Detect that the system will
> be targeting this state and force the call into runtime suspend.
> 
> If the runtime suspend call fails for any reason, then fallback to
> standard suspend flow.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>   * New patch
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c |  3 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 12 +++++++++++-
>   2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 711f2a1bf525..7c3c6380135a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1073,8 +1073,7 @@ bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)
>    */
>   bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
>   {
> -	if (!(adev->flags & AMD_IS_APU) ||
> -	    (pm_suspend_target_state != PM_SUSPEND_TO_IDLE))
> +	if (pm_suspend_target_state != PM_SUSPEND_TO_IDLE)
>   		return false;
>

This will set adev->in_s0ix flag to be true for all dGPUs. There are 
many places through out suspend/resume logic where it is assumed that 
adev->in_s0ix is set only for APUs. For ex: it skips suspend of GFX 
assuming GFXOFF is a pre-condition for s0ix.

Basically this will break suspend/resume of dGPUs in s2idle if the 
device is not already suspended.

Thanks,
Lijo


>   	if (adev->asic_type < CHIP_RAVEN)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 750984517192..acc032c4c250 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2415,8 +2415,18 @@ static int amdgpu_pmops_suspend(struct device *dev)
>   	struct drm_device *drm_dev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(drm_dev);
>   
> -	if (amdgpu_acpi_is_s0ix_active(adev))
> +	if (amdgpu_acpi_is_s0ix_active(adev)) {
> +		/* try to explicitly enter runtime suspend for s2idle on BACO/BOCO */
> +		if (dev_pm_test_driver_flags(drm_dev->dev, DPM_FLAG_SMART_SUSPEND)) {
> +			int ret;
> +
> +			ret = pm_runtime_suspend(dev);
> +			if (!ret)
> +				return 0;
> +			DRM_WARN("failed to enter runtime suspend, running system suspend: %d\n", ret);
> +		}
>   		adev->in_s0ix = true;
> +	}
>   	else if (amdgpu_acpi_is_s3_active(adev))
>   		adev->in_s3 = true;
>   	if (!adev->in_s0ix && !adev->in_s3)
