Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7DDC07E97
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Nov 2023 10:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F25E10E1A3;
	Wed, 29 Nov 2023 10:59:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8850B10E19F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 10:59:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OA8Gg6phsU0+o71ew8lLQ2ocoy1U/LvCb1ymQqeLQ2kwweKD3rfP4FCzjEteAtJ+frQXRFXbmj8xX34FH+jXkKbE7Y6fEptLvx8T9msyNCjIMhaMYu0ryFaMJOBnKH+olVCzN0/KCk6dj2IRaijABIq/46sYKOJ+LL5Y8JM+a82BIBVGYst99rZMf4oeoinyTz61z+3MOtjy7amF9GHdec81wFMr5tDaRvUVGC8+UvRdQZMsMdY1V6h4VFv7KvHlhWhsw5SzdpdOuXbSw7cgTXJ/WduUjIePbgMDILuWiUbCe1aWfxV+x2GSUSQbSa4LQLiLwKa6WPofPgk8gYY3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHm4Gt1qDxBjOX12xPoZeFQAJ6RrTS3JPt+9EJFrfIE=;
 b=EjS9ZDG0GWzQUxHlRZH556bdyUZ7dnrHekLrJyA8qOo2wZs8XQ1DOeeN2H/zTsoEe8tPnLt7GtPRTYZtGpKtlgQJ1c+7tc29SBocCS1r6xCU8K5AIDNYHHjCGrPjIx+dzZ1ZOv2D/VfrIWYiAMSkyRv7N8kGANDJFCcwtBR+FL5szBT/RpTb1rKAHBZAV/moLUiUSEUw4JjXbHtVbHzULMU+JbnPAzhB7Xt3Xr2bre95MeIvX+oLLCt4PeYO5j4HvBJqgV9F2QRFSq+Z5jTAwaE06EZvP1I77hEuZbztGCyhp0w9KWKaXhZsHQpNFtn54Vjv7HNmeuocLjQDxnAaJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHm4Gt1qDxBjOX12xPoZeFQAJ6RrTS3JPt+9EJFrfIE=;
 b=Vdjbh1UzAwiZENUCR7nT6/JMq55wpfCgAH1/jDMqUO4NgTbd6/iffrBYgawH3NMaFWFOsnzVlYyHAen/3ULV9BNzxCqV2/PVfyrT5dMjLhf/O1w1beYqroXPAlG3uivBij28gZ5do41Qg8t3jeShr5HhI8JSjbBM3fG2QfKtt9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 10:59:27 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::2ae2:fc53:6bad:72f0%3]) with mapi id 15.20.7046.023; Wed, 29 Nov 2023
 10:59:26 +0000
Message-ID: <eedd6f6b-5d22-4e2b-afe8-81879f3b54da@amd.com>
Date: Wed, 29 Nov 2023 16:29:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amd: Drop calls for checking "support" for
 BACO/BOCO/PX
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231128185238.187381-1-mario.limonciello@amd.com>
 <20231128185238.187381-4-mario.limonciello@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231128185238.187381-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::7) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DS0PR12MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 823153e6-9396-46de-de5a-08dbf0ca40dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wQQMbxe42VM9Uq4TE9dEDOPoxk9Tx20MQmTec5aJQNc9R5rjsur459dyM3B7cHO2EQCRF+YQpsJFbus2QyVzlGSdZEecbizKBGZFe44RBfL4i5SeBUdzi1XXkrRQr6BK9t2XHGzWNf64HpWBXYGoqAYDyGhLM7DDYo8tZKOeeGP5MTN9kz332SUSvQTCQyW2Tl+juHgUV26R0WtIz3XeWtUWWFHYifdAPUgOAF0zukzuC40mLUuoz8NiD3s7dLVEXZOC69yDAfq5bCp92ghGN4uEP+/ul2m4ArhOBkRTw1ktrOLL1uaOExfMZ+IGqM+fRqVms+dOCUndDuE4y9VjRmpf7J6Y9aX+OiTk3M/UZD3W6HH6zr6RFMhY+ijxZFxVjUvkNro/LvcqNLLRR21nkBcZjhEQAMpGz/aCoN8BOdnwAGoVwjsjKfkImQU349O5ylVstIcUny6E7ZlkSIQ/n2QDi2Zirl211upxurVgxb904Am4MLJqCtdpiRQkxnjoHWEWlx63pzdw8fz1zvgkeU8pr9/lH/KNopg1dczopoWGvBX7AHhD9glCCz/9/NKM4S/Mk81J9ueRDgbYlC8+5Jb/MIgTJ5CtFDJyijzp1Dt6zmkDSuZbv12eqUPRX/UmUPRCuO8oJBvqF1Y4x11lmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(366004)(376002)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(38100700002)(26005)(86362001)(316002)(66946007)(2616005)(66556008)(66476007)(2906002)(83380400001)(31696002)(53546011)(6506007)(6666004)(6512007)(6486002)(8936002)(478600001)(8676002)(4326008)(41300700001)(31686004)(36756003)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGFIVU0zNnhWaTdsZ05kRW1pbE5TbDhNWk9vdjV0MXdhcnZGbUwxNHVZb25O?=
 =?utf-8?B?SnpJRXhKZ2dSVVNYVnorTXJnWC9iOUJSanBqaDJFQ0lkQzJ1MXlTTDR6aEtk?=
 =?utf-8?B?YXhBa3V3cG43UFZvNDBQWmczbGQ3L0hHdzhKOTMzQW9xVVFPYmlpMFJvb3lG?=
 =?utf-8?B?VGFCS0FMUFNzMmN1YW82RlJjVFgraDJPRkc3N1k0d3ZCR3ZKcnByYmE2M0gy?=
 =?utf-8?B?STRwc0EwZWg1QkJqZlpxY2ZqS056S1d2azJrRisyc0Q5ZkhLbFA3cHpFZDRy?=
 =?utf-8?B?cUhqZWM1VG9sL1BNcG9WT2dNQW8yd0FCV2J2ODhUY1prTVNibTYyTUNvLzZJ?=
 =?utf-8?B?Rm1tT25HMmJYQUdzM2NjSUVSTStONGd1cm1nTXNsak9tekRkcVFwUSthQStF?=
 =?utf-8?B?YmdQSzd3NzFHRFpSY0J3TDc3UWFYMndhVGZHTTVRRS82ZGo4SVJRam1acnpV?=
 =?utf-8?B?aUNSYjJUdzhqTFNDTGF6eUVGV1piYVpsTmIwUktPMW53dkFuUisvL0tMMXFP?=
 =?utf-8?B?K1doNksyQVlQTllSMUt1MDZQUktJellTaU1ZSmF6cHphT1FHL3dQTDZUajlW?=
 =?utf-8?B?Mm5kUUtVa25kdFN2SGV4UkUvYXdUNmhYaHhKdkhUYzNtVURaV2xsVG4xWHl5?=
 =?utf-8?B?TTBFUXJVYnZteXRjY0kzWXdiUEpMVmk4cEI0ZU5IZ3ZFWEZ3WkFWeGtvdlZS?=
 =?utf-8?B?ZFVBcTYwamprWVFLYW9YT0hOYnA0Vk5YVVZoNFhRU2ltVkx5eENCZitNeFV5?=
 =?utf-8?B?a2ZTZlkxajdDSWJzOWN1d2NHSTA0Q09yWjNKcWJPUk5QSk1KUUJ1OGhwL2dO?=
 =?utf-8?B?aUl5Y0dJK1gzNmU1K1VyRTdHK0xWN0JlRVBHUy91TTVHaEIxRFdvWEhRZVNh?=
 =?utf-8?B?SE1FaXJwa1cxMEN1UFlWY1FiVVBQVEZ5d1JKNWRyblg0ZkhUQU9CN3lmblZj?=
 =?utf-8?B?QTZBbzRmY3RzNjRReTA1MEgvTFhLUlVJdTZ3bjMvSHRGcmxKaERsZTJtVC9G?=
 =?utf-8?B?VzhxYUROb0hCU3RIdWZLUEdzZDJzdStFaFdscWxNbDZyUXcrRzhvU01kOGc3?=
 =?utf-8?B?UFQveG1DaFRWOXdjSWZiMmptSGxRS1cyZFVCbVlGMng4WjA0UjVmRkhjczdO?=
 =?utf-8?B?Wlp0YXE2MUpCZUc3V3gxejB6QVBXQkUzbHpxZkRPRHNDbXkwbVhLcWxwWGJ0?=
 =?utf-8?B?WFdaWlkwd1o5ZG5aM2VPMW5PNnF3THFOME5NRFJEMldPdFU3U2RRN1VwUnF1?=
 =?utf-8?B?eUVsOWZ0NkQxTW8xRkFPSTAxV296STJJMk41N1ZoTDZ1VVJyMnUwS1NwaFVC?=
 =?utf-8?B?Nm1LSnVPUXNwb2ZDYUtxb0ZwUk1ROVhmMnNlQUZMeUtlT3hIOFovT0poWTNT?=
 =?utf-8?B?blptUEdjMDRCd0J4SkxBVDNhbmI1YVNlQVdIL1Zpa3BSMjArWnFkbG9LSzlO?=
 =?utf-8?B?VTZNaEFXbUUraUg3TndGRWRNNTk1VzM0MUtaS0tpU2xualhHSE4wRytXWGN1?=
 =?utf-8?B?RlAwdEtUYnlob2lkNXRTQmhJUTlKL3VRZ1hUSFIrWjAxUVhucld3ditvNjg4?=
 =?utf-8?B?RDVPWHVhSWc0RlE3Y0I5YkV0bEhJZTNmdGFsQ3krN2lBbkJMQ3kvR3p3dFFw?=
 =?utf-8?B?bkxVR3R4SnNvZ2NVRWd3TS83VTBVVjErNFU3VHVwUmQvNHZKRGZvcVhGcXVn?=
 =?utf-8?B?VzhBZjVBdzlOTmRDUldIQlJkTHZKaTY4OVZCN2MrWVpOOWdqSkI4TXA1ZVZn?=
 =?utf-8?B?UkxUMnJhcFQ5M2tGS2ZnelhCSTJMQUh5RURFMWVheWk3OHVDQmc2VllHdWtV?=
 =?utf-8?B?b0poL2dNNTBLSkpIdlJ0blQwTHgrT0hkNUQzK0N5YWdnK2JLNEhTRjJrQUF2?=
 =?utf-8?B?WWlPV0ZQRmkxSU5INGZOeFZkRUJpMm5FQk0xRTlML2NJazhSdkZocmNJUTBO?=
 =?utf-8?B?L0tJMm9OdmRsL2RZbU9JTnFpNU9haFRNYmM3ZEVnZm04LzVpWUJnd0dWTWha?=
 =?utf-8?B?WUZ6OFFVM2ZaMmlLcExqZUZ6MmM3ZXRCdWhud0FuTExUeGdITkdZb1ZzcHc1?=
 =?utf-8?B?RGxYbjNPOHp3QnpvcTlPQlo4QnJOSXlZNlVIeDQrTzBONUV1a0VXNDY4SVFm?=
 =?utf-8?Q?9VeTe2I1Ing0JhclDzSbI6X1+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823153e6-9396-46de-de5a-08dbf0ca40dd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 10:59:26.8675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDEWQkERJ6FTIZFrq29Q+8Yc9iysbFC8FNWMvWFD995udnpqkmMvwZDldPpEEz43
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510
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
Cc: Jun.Ma2@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/29/2023 12:22 AM, Mario Limonciello wrote:
> As the module parameter can be used to control behavior, all parts
> of the driver should obey what has been programmed by user or
> detected by auto mode rather than what "can" be supported.
> 

This is also not correct. You can very well disable runpm mode and the 
rest of the logic will still apply. A substitution like this doesn't 
work when runpm mode is disabled. Only in cases where the support check 
is used for runpm related logic, this replacement can be applied.

Thanks,
Lijo

> Drop calls to all functions that check for BACO/BOCO/PX runpm modes
> and instead use the variable that is programmed when device is probed.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  7 +++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 34 ++++++++++++----------
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  |  3 +-
>   3 files changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1181fe4baf0f..8f7377b37f2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1822,9 +1822,10 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
>   					enum vga_switcheroo_state state)
>   {
>   	struct drm_device *dev = pci_get_drvdata(pdev);
> +	struct amdgpu_device *adev = drm_to_adev(dev);
>   	int r;
>   
> -	if (amdgpu_device_supports_px(dev) && state == VGA_SWITCHEROO_OFF)
> +	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX && state == VGA_SWITCHEROO_OFF)
>   		return;
>   
>   	if (state == VGA_SWITCHEROO_ON) {
> @@ -4244,7 +4245,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
>   		vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
>   
> -	px = amdgpu_device_supports_px(ddev);
> +	px = (adev->pm.rpm_mode == AMDGPU_RUNPM_PX);
>   
>   	if (px || (!dev_is_removable(&adev->pdev->dev) &&
>   				apple_gmux_detect(NULL, NULL)))
> @@ -4392,7 +4393,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>   	kfree(adev->fru_info);
>   	adev->fru_info = NULL;
>   
> -	px = amdgpu_device_supports_px(adev_to_drm(adev));
> +	px = (adev->pm.rpm_mode == AMDGPU_RUNPM_PX);
>   
>   	if (px || (!dev_is_removable(&adev->pdev->dev) &&
>   				apple_gmux_detect(NULL, NULL)))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index e39f3a334c9d..12fb8398fb45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2248,10 +2248,10 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>   
>   	if (adev->pm.rpm_mode != AMDGPU_RUNPM_NONE) {
>   		/* only need to skip on ATPX */
> -		if (amdgpu_device_supports_px(ddev))
> +		if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
>   			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
>   		/* we want direct complete for BOCO */
> -		if (amdgpu_device_supports_boco(ddev))
> +		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
>   			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_SMART_PREPARE |
>   						DPM_FLAG_SMART_SUSPEND |
>   						DPM_FLAG_MAY_SKIP_RESUME);
> @@ -2284,7 +2284,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>   		 * into D0 state. Then there will be a PMFW-aware D-state
>   		 * transition(D0->D3) on runpm suspend.
>   		 */
> -		if (amdgpu_device_supports_baco(ddev) &&
> +		if ((adev->pm.rpm_mode == AMDGPU_RUNPM_BACO ||
> +		     adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) &&
>   		    !(adev->flags & AMD_IS_APU) &&
>   		    (adev->asic_type >= CHIP_NAVI10))
>   			amdgpu_get_secondary_funcs(adev);
> @@ -2466,7 +2467,7 @@ static int amdgpu_pmops_prepare(struct device *dev)
>   	/* Return a positive number here so
>   	 * DPM_FLAG_SMART_SUSPEND works properly
>   	 */
> -	if (amdgpu_device_supports_boco(drm_dev) &&
> +	if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO &&
>   	    pm_runtime_suspended(dev))
>   		return 1;
>   
> @@ -2664,7 +2665,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>   	}
>   
>   	adev->in_runpm = true;
> -	if (amdgpu_device_supports_px(drm_dev))
> +	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
>   		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>   
>   	/*
> @@ -2674,7 +2675,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>   	 * platforms.
>   	 * TODO: this may be also needed for PX capable platform.
>   	 */
> -	if (amdgpu_device_supports_boco(drm_dev))
> +	if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
>   		adev->mp1_state = PP_MP1_STATE_UNLOAD;
>   
>   	ret = amdgpu_device_prepare(drm_dev);
> @@ -2683,15 +2684,15 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>   	ret = amdgpu_device_suspend(drm_dev, false);
>   	if (ret) {
>   		adev->in_runpm = false;
> -		if (amdgpu_device_supports_boco(drm_dev))
> +		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
>   			adev->mp1_state = PP_MP1_STATE_NONE;
>   		return ret;
>   	}
>   
> -	if (amdgpu_device_supports_boco(drm_dev))
> +	if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO)
>   		adev->mp1_state = PP_MP1_STATE_NONE;
>   
> -	if (amdgpu_device_supports_px(drm_dev)) {
> +	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX) {
>   		/* Only need to handle PCI state in the driver for ATPX
>   		 * PCI core handles it for _PR3.
>   		 */
> @@ -2700,9 +2701,10 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>   		pci_ignore_hotplug(pdev);
>   		pci_set_power_state(pdev, PCI_D3cold);
>   		drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
> -	} else if (amdgpu_device_supports_boco(drm_dev)) {
> +	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO) {
>   		/* nothing to do */
> -	} else if (amdgpu_device_supports_baco(drm_dev)) {
> +	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO ||
> +		   adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) {
>   		amdgpu_device_baco_enter(drm_dev);
>   	}
>   
> @@ -2725,7 +2727,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>   	if (!pci_device_is_present(adev->pdev))
>   		adev->no_hw_access = true;
>   
> -	if (amdgpu_device_supports_px(drm_dev)) {
> +	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX) {
>   		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>   
>   		/* Only need to handle PCI state in the driver for ATPX
> @@ -2737,22 +2739,22 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>   		if (ret)
>   			return ret;
>   		pci_set_master(pdev);
> -	} else if (amdgpu_device_supports_boco(drm_dev)) {
> +	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO) {
>   		/* Only need to handle PCI state in the driver for ATPX
>   		 * PCI core handles it for _PR3.
>   		 */
>   		pci_set_master(pdev);
> -	} else if (amdgpu_device_supports_baco(drm_dev)) {
> +	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
>   		amdgpu_device_baco_exit(drm_dev);
>   	}
>   	ret = amdgpu_device_resume(drm_dev, false);
>   	if (ret) {
> -		if (amdgpu_device_supports_px(drm_dev))
> +		if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
>   			pci_disable_device(pdev);
>   		return ret;
>   	}
>   
> -	if (amdgpu_device_supports_px(drm_dev))
> +	if (adev->pm.rpm_mode == AMDGPU_RUNPM_PX)
>   		drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
>   	adev->in_runpm = false;
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index f464610a959f..d7977185f4e2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1618,7 +1618,8 @@ static int smu_disable_dpms(struct smu_context *smu)
>   	bool use_baco = !smu->is_apu &&
>   		((amdgpu_in_reset(adev) &&
>   		  (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
> -		 ((adev->in_runpm || adev->in_s4) && amdgpu_asic_supports_baco(adev)));
> +		 ((adev->in_runpm || adev->in_s4) &&
> +		 (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO || adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO)));
>   
>   	/*
>   	 * For SMU 13.0.0 and 13.0.7, PMFW will handle the DPM features(disablement or others)
