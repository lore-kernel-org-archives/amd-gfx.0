Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C3FCD1284
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Apr 2024 06:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9864F112C88;
	Thu,  4 Apr 2024 06:56:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QX+9OaZ8";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2115.outbound.protection.outlook.com [40.107.223.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6212B112CCF
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Apr 2024 06:55:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IStiW/mnY4KzZzluVSE1xDSmEmO1paOSk8arhD3ObnjcQMYbdM1oSvhUvrajCUiXo5hxDKSuqDi9ntB1V1XFnQXgBFeIDFugdlvTMUYH+qLaTb1CzQwugJcc4R7ynqMWYeqX5fZj9+2/rMGnWTf9kJGZnPfFmWscR4lABlal/MQq1w/yKsN35E0b9v/wtz/K0qsok2diTCNc35eMtVDko8FIXjgGt+uOVzTI//whbw5coceYVklWCJE79DCw7cqsiIKfff2yaQl+KwqxrXWH/U3fs54GODO8RAjeEt8AmizwIeriPGwy7mEFhMlFU93iyziyS9qHaloepAX98wNCdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgYxc3eqGceaK+TwurpTiIZoJXFCFsQ+plkehXx7k/4=;
 b=E2cIuwO7+RoSWT/QcAmFB9aEB7X34Zet7+XS27g9KntYHxrkUI1THDKBIv9zz1E8qOFzAl8Ykuo/weAbKPDfIRd9/YByvA+fHq8FTGLbmcEhMOjQfU+0Oh38PFB/18E3UNApheZJuItUgobzlO4EAcjFf8rHuG5xjbcausBjW4uj6ZoQYs9Q47IbVAZFjJQoi+SpvDC0Fq4k/st6DTSl3Xv5NnSgVDkw2LpBB/kJBSFFzzAbrYJngYVEnqYr51WAxZaEeLGqqXoZ545WNJEifz4ndASYQhm1MEAwn6FLaHlgbcYnywXBqaYhxckdzvyPLz2L2+s0XSXSOYmchoOOZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgYxc3eqGceaK+TwurpTiIZoJXFCFsQ+plkehXx7k/4=;
 b=QX+9OaZ8DDs6aQgO8HBUL8wxPcquf3udooj6/QDu+0nZ2J7Xk2531+00SyXAlD6DmjRJVbA/zXo84GMTkgRekArjw+1zRamG0S5zXsDPGJBdBjgph0Z9AkJOzvu+/ewee75HvtmdIQqhVhL3uPtfeLt5G0Nx2u48MyQTFzuCqxw=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 06:55:40 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 06:55:39 +0000
Message-ID: <fbcdee2a-2f20-4a02-a05e-ee58745740a1@amd.com>
Date: Thu, 4 Apr 2024 12:25:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] amd/amdgpu: improve VF recover time
To: Zhigang Luo <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Sashank.Saye@amd.com, Jeffrey.Chan@amd.com,
 philip.yang@amd.com, felix.kuehling@amd.com
References: <20240403181223.25079-1-Zhigang.Luo@amd.com>
 <20240403181223.25079-2-Zhigang.Luo@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240403181223.25079-2-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0193.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::22) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB6723:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: quVDG/qsCsW6UP3/IFLHMIsFghe3TYtJ48TRh0TDCY64w8D5STEB+Pc9TfxeYPZ+GlOe9Z9L1Lgg1hQ9KihdlrP1Q4B1dvRt3sq8y+QEBgfO8vZU4IOw8CpkNRKJ4zHUjq6Ze+wPOKo+FrgGx+opJTyiX6K1yN8vPQazHZKfydIV7FlUfHcn291fmO1/m/nduJqy06R78wBlOYdposwy8WyAdwePBhNS/Vgs2T29I6/lg79udNk97yNlR4AzT00n/ogqVdUxiYA8X41gzaYDjsf3zVxpTUlAW/189fir7kBUwZiZyk7ljiR3IPlk8lTneX4q7EsmaHsXFkMKVw4Ly71CZzEUF02Yac3S/OjhniUQsrNiCYI02M4fa5V6p4HH9B/5metKKhrZt5tNq0bXz3hGTlkPsUFUg5U4PUxPahH7rIOqDubFNkfOG65MKNWzwJi52co2/yg0XSR++GLrGAHnSOC/H6WZcQgE8SZXIL3LIE0eXdZOsmqbDhJLJ8YlVKL78LWqJyXG94qhA9o4Kk7YMXQ1NwbNZ2yN13ritN1hE2F04ah9cfx8ogmpvcpCrdq3Mmh1v6bdZM+CAIEshFsI7wROQ67HTPKod33MbkR1GslQKqyZS3wa4OMJleiKaNHU+hQaJmqJZQr7kwZfsLw17OOT9Hs1RvpR8lSL5oE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFFqK0tTVFpGL3Y5YWIyOC93RHVrRlR3cFhFTmRySFRud3pKOU9xSkluRkJl?=
 =?utf-8?B?M1pWUGV6Vktvdyt1NGVnN3pkVmdGSTdBbkV5ZUhIZGpxTXhsbWxtNi9BT1ZU?=
 =?utf-8?B?allHQncyUDYwbExOV2tTVzNsZE52SldLMHB0dkZJcWYxZmVYNEhyaFdnYnZy?=
 =?utf-8?B?WkptT3RxU0czUGhnc2xNVk5XWFcvQlNqV3FQTFE4bExkRlN1RUNqSll4MkUz?=
 =?utf-8?B?UkZhMDhHL2hubzVWYXNUdElRS1JuODl3cGZwKy9XOFo3N2hxd1JFUHZEbWhy?=
 =?utf-8?B?N2NrTndCWnloWkx4WlZyd3B5VU1GNkF5TENmbldBTGQ2a3dMK3Bxc0pPVnVm?=
 =?utf-8?B?WHZJeHdwbWQ4RlBHVzJzcVNLWGRlR1ZNQTZDcmhET25ZQUR1MStsVllZdG9N?=
 =?utf-8?B?OG9oMHlJT3BXNU9mWVZUeGovQWpWMXI4NkVGTFZrL0syS0hGNU5TUmVkbWZ3?=
 =?utf-8?B?RFB4amMxMHYwazUvaTN2K2tmb0VYSXZkQTA1Ui95UU4yVTA2TEk0NVBZYnN0?=
 =?utf-8?B?ZWVVUHVHc1BRNmlLUG9DZVh1WHFyMW4wQzkzcTZKcjlYOUVXUTAxTEZ5NHNy?=
 =?utf-8?B?UU5VZXRjTEhHaldodzMrOG8xd2lIVjN6MlhrK2dEcFA0Y0I1VkVsb01PMlVq?=
 =?utf-8?B?dEl3MHJKSWIzUWYyazdOSm1wenhUSmJ6WEFEZ0ZIaS8zc291TFlMYlpodlE1?=
 =?utf-8?B?cU9XUWtnR3M2c2VlRWJDTlZaL3cxYTlwYkhVb3lrUG1GNEJ4ZVljMktkYy9j?=
 =?utf-8?B?OTR3RDdqcUMvQktMYTRobm5wVi84TjFRWE85V3p3ak02cVB3NmVTUjVBOGds?=
 =?utf-8?B?TjJ2RnJHcWN1SjVZeVZIRjRzRlcyM0I0cUFrUG5XQVcrTmF0b3ExODdsTDRh?=
 =?utf-8?B?YlYvQ3Nwa3pWUkR0NUgxdHVVZkh3Y2E1N3lKRnN2aWM1YjJRU0FYNzhVU2Nu?=
 =?utf-8?B?OWI5cTkvaUorSy9UYzQzU2Iwa3c4N1NjU1hyK2lvaitWVFlpamtDNkt1RFdq?=
 =?utf-8?B?ajlHNmdUSFliUmxTOXJybCs1dFZjbHdoenRYc1RVclFUcFpyMWdGelNzWkhH?=
 =?utf-8?B?Q3lQM3RHeW9ucWVZZ0NSVkxqNE9EK0ptb3oyVjJnZ3JJM0U2a3dXNVAwcTc2?=
 =?utf-8?B?USs1Z0VVY2h5SlN3S2NSYU5UWEdmS3RLMmtvZ1FkcnA3aWh2K2Z1Y0dKMWRE?=
 =?utf-8?B?SGZOT3JobDFsRHloL2U2WjZLVXk1SVlUWFYyR0F2WXkzQloxRzRHTEIyWnEx?=
 =?utf-8?B?SGJoQkVqVU44TWJVWkIydytKdWtPNHN0VmhTWHYxc1U4UlVFaldodEREZlBM?=
 =?utf-8?B?TndRTkk0TUNHajl6WXZNT1F3TG9WNkNSL3dUY3FCWnNodzFPMVYxSG82aEVh?=
 =?utf-8?B?d2l2aUN4N0FiUEVKTW04dDhxNDFhUkdrZkNGOFlFRVdQUzN0ajJhSURJY2VI?=
 =?utf-8?B?R0FpWkYyanI5WHN5cCtCWWFUWFFEdzB5TXdVcFc1dEZqejh6VVFIR1pXWUwv?=
 =?utf-8?B?bE15VFNHSkkwdG1LRWNkQy85OVVFdnVGWXFyS0VXVGdIY1BRdVRUT3oxYVR0?=
 =?utf-8?B?Zkp4S3FJRFQ4ZzlWdHErWVhyMk5nU0ZEZlM4N3p6ZjJWdmNIVHNUbGg1L0hu?=
 =?utf-8?B?dGpjN1NKOElTdlpXQTAwcVorUGM4RzdVeVdGYm1KQjY1NFoxcG1zUTA4ZHNH?=
 =?utf-8?B?OUIrK3k1YjYxUmRzZWdTUisrS1cyclBRR1NHLzUzSFZpbHpBWmwyaU50OHA4?=
 =?utf-8?B?d0RsY3ovOWxCSk5ESzBvY1NDNmZVTHBvSnphOXNRQmRjZlN4Qm1nY1ltbnkw?=
 =?utf-8?B?cmhhQjFPL1U3RjJaVEl2aWZKR2ZiYlM4WE9KNmkxK0cyekJacjBzYXJ5RWJW?=
 =?utf-8?B?Wnp2OFFVQk5PVm5GeW9tS2pEV25XbDR1UzlVcVAxd3NkcDN6cmlEeVI4Y2lz?=
 =?utf-8?B?NmNoL0tsVFVPWkpob3VRMWJ0QXFQdWdMSXFaS0VIZERZSzNBVElrdmFDWHpt?=
 =?utf-8?B?bU1zMHVYVlpTeGJHSHRiUFVmZG1aaG1odktZUjZML3J2aUVaZDFHZUFaajUy?=
 =?utf-8?B?Zk9zd3pENDdScU81dGlHei9GMkRoNm5Lb0tObm1NbzhQeTUzOXBiS29mRXc4?=
 =?utf-8?Q?a53Kmzhw8Y9dCwhJ0pRqB8tTD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d326f59e-b7c4-4d13-c9f7-08dc54743caa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 06:55:39.4314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dt1JO1oExiQHDlpB5j2QwpUn+XbdIr+QAvAz+VHUsVxCBqMoBWpv4LAoPHqz/Yqo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723
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



On 4/3/2024 11:42 PM, Zhigang Luo wrote:
> 1. change AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT from 30 to 5.
> 2. set fatel error detected flag.
> 
> Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   | 2 +-
>  3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 70261eb9b0bb..5e88f6f6a481 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4982,6 +4982,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>  		r = amdgpu_virt_reset_gpu(adev);
>  	if (r)
>  		return r;
> +	amdgpu_ras_set_fed(adev, false);
>  	amdgpu_irq_gpu_reset_resume_helper(adev);
>  
>  	/* some sw clean up VF needs to do before recover */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index aed60aaf1a55..4b6e50cfba08 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -593,6 +593,7 @@ static void amdgpu_virt_update_vf2pf_work_item(struct work_struct *work)
>  		adev->virt.vf2pf_update_retry_cnt++;
>  		if ((adev->virt.vf2pf_update_retry_cnt >= AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT) &&
>  		    amdgpu_sriov_runtime(adev) && !amdgpu_in_reset(adev)) {
> +			amdgpu_ras_set_fed(adev, true);
>  			if (amdgpu_reset_domain_schedule(adev->reset_domain,
>  							  &adev->virt.flr_work))
>  				return;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index a858bc98cad4..0a57b637c4bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -52,7 +52,7 @@
>  /* tonga/fiji use this offset */
>  #define mmBIF_IOV_FUNC_IDENTIFIER 0x1503
>  
> -#define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 30
> +#define AMDGPU_VF2PF_UPDATE_MAX_RETRY_LIMIT 5
>  
>  enum amdgpu_sriov_vf_mode {
>  	SRIOV_VF_MODE_BARE_METAL = 0,
