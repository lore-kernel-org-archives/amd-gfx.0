Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77D0C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 18:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ADCD10E1CD;
	Tue, 11 Jan 2022 18:54:46 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2061.outbound.protection.outlook.com [40.107.100.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4953C10E1CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 18:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDVRQwpiuBk/TjMZdyP8WnJPSeYkdcAJnDpzXIbWOtbzAnbNpsQ1DtJPC0m3tb7cx4o3a7ioYIi6Eok8kfW3+AN7GUKzOmVX1JUOsMFLl0lSHMJH7nJ1fkWXdao2kkjeYSYrJB4JDNYbUchQg7jcfQMY5MvgHz3osP8/Pg+UpkHKtbvAcTnSbxraO8V01oJNY2Zh+d6nyD8o9wkiAwo6pFLLHM/QMyg2VOT0SzL+jwTjCCWgEbxW5MN08k1QkTnQPdZj0k0VE4SwNPMj9iNJ77lyza24FcX6NpKuGOeCnJ6Nv9iTo95QwC07bVNgsCXctHsFWqGCxP94R5SacUZCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBRKfDPUti8YZIQiWy/qdEXtM1RAsKx8xOQRrX9M1LY=;
 b=k74mRYHpPub0xftcgdcy6ilLXPcy0uD8/DkJpLvGYO/iNBBgCJrYCjrQ5X0RVclsdI9f7XabrjnlzaAVTS1aCAdVgVAey5T/gcELKJGQbF1SyMvZz8JI+ZHyWtt3VGG6AwY6W3wN5ECCT9tKnw5ry8AyPuMbUJL78370A5Yf/DHbd3XRmE6PHa274OcXitI8z2LdnOYdWon92VcmaHukdmWzA28fQW0rtT02VTV4LZUjJd8ZSz2KONHfuK2oIW5ovSe0DsmtWS+jeWpWsiSSNgAf2DF94pyftl/tCfHH8EkuFqgVPfX/iSlpozS1Rl0EuUGhyARAYPEy5haD1KUuHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBRKfDPUti8YZIQiWy/qdEXtM1RAsKx8xOQRrX9M1LY=;
 b=JyoaOCfiJXkFyODlRkknk1lvd6KcSd+6Pikm4fH9venuTi4le++ELUvW32/zRXuEX/73Om6vt41owhieqGSxnd3FWYbDyBQ8KEDCJSLPgrMzmPJw2xXsga39hi3kF4QNKf3Fnyg2DRdCa/TPXA2UdG8ZhobXc1CzDZd97xm748E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BY5PR12MB3666.namprd12.prod.outlook.com (2603:10b6:a03:1a4::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 18:54:42 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%5]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 18:54:42 +0000
Message-ID: <a40849f0-aee5-9f8e-aca1-a95a92ef75b2@amd.com>
Date: Wed, 12 Jan 2022 00:24:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd: apply s0ix codepath to more cases
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220111172940.2561-1-mario.limonciello@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220111172940.2561-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::32) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d958a1c-0a4d-4e27-cdde-08d9d533d374
X-MS-TrafficTypeDiagnostic: BY5PR12MB3666:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3666D9E52835561397143A6197519@BY5PR12MB3666.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pGg5209dUYphTP7/k3wlrpFUh9D///2w72YbfdwQ5p5VYVVfxhNrb8p0LwRk+HktrURdR0hSPFMyACNSEFk+X/SlzmRHbG7QlJNg0fMUb2Eudug80SL/n6lwC3I195qyqP4fbH5gE4P9DXulU+Z/ttWnANzYMfUgzBK3ihKm+wjPuc0KykQZ0emiMtQm4/lNqbZC01oBThMERRygl0fUpN5mQ7wikx+NPM+napQQBckzTZVLluwv/0bDYUoMj1aLHBtWtrnGNYDxSbJOzWs2LDsBN1TvRam5uTOD+wmiC212MmQv2KW7FTrJoAUMqTzd6WvE2M/Nnyz77w+1LxAdLyQYY2DWellD5LyVg6MSm6xC+XdqbdbBZkbxwGPR+Er+Vz8fL+KQzrEAPVzn/9WLMCe5Oi8PKXm9Ev3ltu4OGAFhwtUkARV+ixSvJ68vuF7H7Xex53iOqgqAbmVvfXlL4uerygvtpG4Y+32wDYN2cC5xg3CHWjHZpoUjjqCCBL6ArRkt5wVM/LM+Q8oP8TgcPW+G9073jwWp/Lw8oDMYWu70RfnONWs25MCF1FF3+9I5Oa7BPGKiPtvtiD8/Vj+ybxSlDuBuD/qz402YVZHgsyfjoN44+KZTZ9fSW0nzz23gfvQx4/+azHyKoT8mk4TaLAzQ8e7AWD5zD/cpyIllpZ+8FumE7BA3nBiuQBlusI24pEdZuvorHvKWpph79//9RQKIEBRZCLNxtvwZqf/rAnn6KiE1ScJct3Lju8r6KG3mNVnwY57MbGE7yTdq1YsiCxH1ARfGDSQNDnQC86rcaSZmKqH9Gbme7zAcvovhrvrf5MjoYdrywOjUl06OajwAhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(66476007)(508600001)(5660300002)(6486002)(2616005)(66556008)(316002)(36756003)(86362001)(4326008)(8676002)(38100700002)(53546011)(31696002)(6666004)(966005)(8936002)(26005)(66946007)(83380400001)(6512007)(186003)(6506007)(31686004)(32563001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0FYSVZ6R1RTalhheTFXdFpyUlpKN1F5aFlyc3RaL2UyUlh3VU1CZGJTMzFu?=
 =?utf-8?B?QnFqNjJqS2dTQy9KRjZ5ZzhHK3FtK3RSUTZpbXpaS3N1eHN3dWtuRllFL0N1?=
 =?utf-8?B?VUYveHdrdTY3RnRiYnZnL1MwSWU4YnRVZVU3MGgrckRhOWJRVDRvaE83RVFB?=
 =?utf-8?B?VlpqSTdIVWZuSFA5Mi81ZEVqUXNKVTE3dkdzVUtwOHRuYzR0dnJ5UXlqcmhR?=
 =?utf-8?B?c1IreDk3ck5jV2dIN2o2V21icnVTS1IvcUVnNitzWGNuUno0U3U4b3NlUDZI?=
 =?utf-8?B?ZFdEeldUU1R2MGlXdFZaRVdQbkdIUldFZWRSbVBxZVJmVmxxT0MvQUxjVDBP?=
 =?utf-8?B?bkFGZDFoK1FEL3lBQkFFWGtNM3htYnRzcndLRVZ0YkNDazFCaytxbUY0WWhx?=
 =?utf-8?B?RjlXSnJnNmZ3VFZQTEs0Q044Rng2U1FrUng2cFphZmQ2UjlKcjJKM0lYbCs1?=
 =?utf-8?B?MWZ1L1BoNWRWd3FmTmg5WXZqK3R1Zi9XaFdQVkNVSE5BdmJXdmJBVm1hTko0?=
 =?utf-8?B?WEpVVzFZYXR2cnVWaHRJSFk5L1MrYzNMT0hXbGxqLzArWEFoOFF6a2tBU2d0?=
 =?utf-8?B?QW03TWduUUprb0JRUjJ1enFiQXd1Ym4xRkU4QTJyd2NtWE94a2tLaEw1OElr?=
 =?utf-8?B?amhmZzBiMlcwUnh2cCtPZm4rR0R3STlLR3d5YUJ1WTRGODVDaDU5cUtib012?=
 =?utf-8?B?a0cxS25SRFFXaEJCTThHWnpHWGxsMWtaZlBSMUlLdSt2Q0lrQkFRQmRnM2Iy?=
 =?utf-8?B?OGhLeXZKaGoveHg1cVJZUGRkaHFJL0tVV0ZIYmVnWUxCSktCMjJ1ZW1PSUhM?=
 =?utf-8?B?ZmpHYzNuQTRhYnlERkZKR2drR0V1T3R6M3NsUmpLb2dzMnc1NHlTUEM1NnlF?=
 =?utf-8?B?TjJDd241VXFMalFYR0RsSG94L1RKMlNZOUE5K042eDBienN5MTNxT2diUkZD?=
 =?utf-8?B?enlNSDZYaTNjbUE3RmFhZ1ZRQ1ZvOG0xNzZMSFpBSkJxOUxLcGpHKzI1elFO?=
 =?utf-8?B?TzluKytMS0pZYmtXM0JxZ1lWenpZSHdFVjdWSHFlb1hWVEZxVzZLM2tDQnd2?=
 =?utf-8?B?T3BBdVN0RjdsR2huWjNWZEhzSVY5b1BkWEdFUVozejh2SVFJd3RFWGRaZVYw?=
 =?utf-8?B?TURRWlpJOFFXV3E2SkpwUHFWS2JibWtoekF1T1ZoYUpaUnNPUTNKazU2V3ZC?=
 =?utf-8?B?M01UYVVGYkorK29hdnBCeGpQN05HMUc1OFZxT3p0b2tDN2trbFpKZWtmb0FH?=
 =?utf-8?B?QjdjRWluM2E2QTRyejVQTFd4QXVKbnFvQVU2c1dXNmo1TVpSaFhQbnh0TEg1?=
 =?utf-8?B?ekdaY3QyL2NvbVd3dCtJVmZkV1B6N3ZtYVAwZmMyUXZJTTMxTjViSy9qd1ZI?=
 =?utf-8?B?Z09vZUVwMkREQ2FXeWFGdUhzbngyTUtMZFZ0QnA1S2E2U0E2dTRLeWk2aEt2?=
 =?utf-8?B?UUx4TGk3ZjREYTRadUlCbjZ0ZFlhTzZRbzFFczBBdkZmU3BrME11VEZBWjZa?=
 =?utf-8?B?d29iczJIWU16elpiamp5QXJJUW9jZ1docXhRM3ZqK2p1cTR0OUdEbTZxMCsr?=
 =?utf-8?B?Ym1UZitkaUIzcy9HaTl2VTdqanZFVGtGRkswK0NaYldDVXFCQkpHeFhvY1U1?=
 =?utf-8?B?UUROaStzdG9RYTlBUFY1MW9PR3lTTDRhd29tL29qSERlTWxOeVIrRWRSdHBZ?=
 =?utf-8?B?amowdG1GK3N2YnVCR2ZuUmsrd29taDJ5T3N5Q3hxSXJINFRmYnU1ZkdOMmRz?=
 =?utf-8?B?SUdZUmFMd0VENUQ0QnRDUEQ0NWJCcmJUS0h4Z3pvSFNRNThOT0NibURHYU1o?=
 =?utf-8?B?NGR5WWZML3hpb21tQ1d0K0ZjQkJqYmxiRGo2Z0JFNTZLMHRpY09ITXd4RGtq?=
 =?utf-8?B?UE83Y0xEeHZjc1FpNUZuYStOL2d3RHI0MkVPRnFvcW03ZUUydzRzdXVHZXJK?=
 =?utf-8?B?ME1heEt1STJDMXBsbk9yVXBGb1puenArc2VkVkp5VkVhSTEyOTE1NkEvT3d4?=
 =?utf-8?B?SVpvdWhNcEc1WVV1TStiU3JDM2krTTNzZ25EVDFoSkx6V1RVbTREUklIWGQ5?=
 =?utf-8?B?bHZrMk14bHAzY21QRjhEaXc5Um9yeGdUaUpLbGRsUEdZMjBCeWlSZ0lVT1Fm?=
 =?utf-8?Q?iutU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d958a1c-0a4d-4e27-cdde-08d9d533d374
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 18:54:42.2487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HheeRQ5aOYJ1NPAI4UbCtVzAxsFHkVs6ybv2js9tNp3u+tfzi71UQ/jxbcmSV7fh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3666
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
Cc: Bjoren Dasse <bjoern.daase@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/11/2022 10:59 PM, Mario Limonciello wrote:
> On some OEM setups users can configure the BIOS for S3 or S2idle.
> When configured to S3 users can still choose 's2idle' in the kernel
> by using `/sys/power/mem_sleep`.  When configured this way, the system
> will use more power but should still work for suspend and resume.
> 
> As such, remove the checks that put the GPU driver into the S3 codepaths
> when the user has selected s2idle.
> 
> Reported-by: Bjoren Dasse <bjoern.daase@gmail.com>
> BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1824
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215387
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 4811b0faafd9..a46bac8f79af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1040,11 +1040,14 @@ void amdgpu_acpi_detect(void)
>    */
>   bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
>   {
> -#if IS_ENABLED(CONFIG_AMD_PMC) && IS_ENABLED(CONFIG_SUSPEND)
> -	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
> -		if (adev->flags & AMD_IS_APU)
> -			return pm_suspend_target_state == PM_SUSPEND_TO_IDLE;
> -	}
> +	if (!(adev->flags & AMD_IS_APU))
> +		return false;
> +	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
> +		dev_warn_once(adev->dev,
> +			      "BIOS is not configured for suspend-to-idle, power consumption will be higher\n");
> +#if !IS_ENABLED(CONFIG_AMD_PMC)
> +	dev_warn_once(adev->dev,
> +		      "amd-pmc is not enabled in the kernel, power consumption will be higher\n");
>   #endif

It makes sense to emit these warnings only when pm_suspend_target_state 
== PM_SUSPEND_TO_IDLE.

Thanks,
Lijo

> -	return false;
> +	return pm_suspend_target_state == PM_SUSPEND_TO_IDLE;
>   }
> 
