Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307B1C197A0
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 21:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF1C710E2C8;
	Thu, 16 Nov 2023 21:36:37 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49CC310E2C8
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 21:36:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4MfBDKUzaCHl3x/VcLZJR9qt6gq8IiRqDQqnhq3n2f5eulEoldJEvegF9++jWRY+IAflXjAThmGlcL50lHAjNFVgv/Ovbx21SF7YuAOV4izDjVF3jf2JF3RfoTnxrhu9iC0RwPG9Kvbrcx+zllUcKCyyCzUN768U6O5heUxWOlvSJAyme81QD/Gyf++Bl16P4j3nBOQc4Ce+eERugGbfRJOXbE5Ye3fZslA5ROjsoMRKHHTTdrReUqqFAlFP4f6sJtGfYut1CdMLuKC6/EL4C2JFvB5M1C8J/hKOotC6HM/lWL2bgCLSW0sd37lx80izrSng0zUkAEyObmLxA1tXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qZL3IXtG0A+tV6raITUW6U4jCcUziLN03vfZ/1XXow=;
 b=BuqB5Zz7SKpuQ5XJdq9BEiHGwBElh4iG86ZkoaVIbxC3BfeozLe3U+pEbEYytTYNOdKriARehw40xRZU12iqA5b43jmWxxgnt4mPoecDZt3hQzW5TF73O9nBhB96E6Ecz0FApGcHSPjn+eW9cUwcQj8NDAPcFezz2FFZhfAAiJO/ZrfpyW8JI3DX82ew2PI+1mnRnaYoNKvP+ITCY5uB3ng6/+LlrN/OJz4cWI+Luo9pNW6olwE8mT1rYtUQpdKME6lIBPcqnkAPzduerN0qlpsz+7GfLnEZwtJxm9nPncqfZmyINhadKBjIduEIdWCGYNVhV3UkLn+eGs+3kvLE/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qZL3IXtG0A+tV6raITUW6U4jCcUziLN03vfZ/1XXow=;
 b=LIqTPXdf9VwI01U2lGE8jdwpzlqVO3L8IDo49Ukj4rXkf+PNw+d7ivdi6N4IWlnRr+FW+2GcEZbgtNumvVayn2moUfov6vB5iaKwh8COXMNms3vAFedbEsca51ljnv3KjwX4511anosnHLn9GgoFFLtYGYqcyVMmDZJ+8Py5t18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.32; Thu, 16 Nov
 2023 21:36:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 21:36:31 +0000
Message-ID: <b63d2c28-9e31-4a1f-9cd0-67421af60dca@amd.com>
Date: Thu, 16 Nov 2023 15:36:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [1/5] drm/amdgpu/gmc11: fix logic typo in AGP check
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231109205125.513643-1-alexander.deucher@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231109205125.513643-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f69472b-b6ee-42af-1c02-08dbe6ec193f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nNjFFmxuhpPglq5YCf7c1M0sR3gdDGcBA6W7qUrwqZYq9c3R/SYmZBsa3X8mrsF5pN3ub92io0w5QIdjkgleZqgXHOro/qnHyoK5YL/mUeNQ5rWlMELzSKe66Q+2On58zaiwiEld2FA73j/mZ4/EJJWQwNEi0rw6W0j9lyzXx1cUybfQI9Hk+7kEnVt3c3CZfO8vBcaXn9Vly9hI7NuiR8q313wwBbEWcvCsCv/tgqwYREiTYMtA3tqSk2DHb03e5jCPY5EWqF33q4NHJg4RNhCd5yleMtSDlTIDfS+6mYucYCm4/u7cAfosezxw0pa1I99LcLi8SAZSXb0JtU5sGcDEKyu/eiSm/NbYyhENzNtYRxQwksCgzLlUFsdcFUPoLYkgkRC/A7CljQPme6iBEKgK8jgVLHudafWHqZuo0nbLeEWVjv1VM7a2U1R9SWRTgUzlveNGuKummdLR6KTNxTzm/KnZIGN3QpZbJNHMcHs33NCsDk3Hz+YgVqNy0kbRdICTnC+8Dv2TwR1C0pqXHaBS0insg8zbjgTi4h6g/vNIV/AUWL3LEo2S2TTmEXmQGE/Y+h4NXR3F/u1Tm7vtxTpbi0TUe7nLOltm8o6M8o5u48bg6GgqImuoWsD9ryCh9XdT8X+c2xXQDFWasx10JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(39860400002)(136003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(8936002)(8676002)(316002)(66556008)(44832011)(86362001)(31696002)(38100700002)(66476007)(41300700001)(31686004)(36756003)(5660300002)(83380400001)(6486002)(66946007)(2906002)(478600001)(26005)(6506007)(53546011)(6512007)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZURJdTh3MG5ZdkJBK2ppQ0NmVlJMZnpmeDc2UE1jNWNYOGhhL01sMGJRdldt?=
 =?utf-8?B?NmphU0RleC83Rm84MHhkUVZ5eXBXakw2dExSSm9RUzc2SlRNbFlnaTRFSytD?=
 =?utf-8?B?VzZYTHVzVkZ3SHV1SkZub0VMKzNOTnJESXNvQTVoT05KNWFiYlZ4N0ZrbXNj?=
 =?utf-8?B?Q3hqRE83VnlrOXN1Vmxzd1crSGVhL3JPY3F1ei96OXdNUmsyaTZTdzlpL2JN?=
 =?utf-8?B?Z05SUFFabHpMZFZzbVBvUUVOQlN4RWFHcjJyL21HNUlOZDVGUmRjM2Q5R25j?=
 =?utf-8?B?UHdBZ3NzR29TSEprOENsM3BVejJOMlNMcGtJRFV1a3hLR0pWVnNSbXN1NDNh?=
 =?utf-8?B?ZDk2TmdBeGJGSWRXQjBEM2pzMEkxMkp1WFFmN1RkVkM4R0VIbmgxd0F0MFNU?=
 =?utf-8?B?QWhzbU5ZUlVEMUhzTG1Pd2NDRlFvWW5QRGRLMDIzVmpVYXB4a211NE5xbmE5?=
 =?utf-8?B?RmNYTGtjbjBxaHZlcEhjeGlNUENUOWg4TGd6NEp1a0VlREdDTU1CWXJFemZl?=
 =?utf-8?B?QXNuRnc3NzE0ZGN0d3k5VEpCOUs1RWkzT09Xcys1SUZ1UlFiTTFOSGUzeXhn?=
 =?utf-8?B?RGo1OWwzZFI0cGVWWjh0clJiN2J6TVZWdFJ2WFZwa1hUSHB0NENXOG9xZVVk?=
 =?utf-8?B?K1ZVYUpIU2FWYTFPZ2puYW5OKy9XaU9teEdmcUUweHBzajhGUTIzUlVHKzFy?=
 =?utf-8?B?SmtMd1REWjhBYXVucXFNdFU3RjY5MlZCWVQ5N25zeHZwSXgwY0VVK2FUaGVC?=
 =?utf-8?B?TGpvZTdQMG1kR2xBOVVVTVRLSFVONkRBZFJsWFlvdEFGZEgzb0V6Ri9lRlNM?=
 =?utf-8?B?aHNiRTBqTndxMXdMVnl5OTdIWDhxbThTcDZWMklZdkx1elduM0g3d2c1eEgr?=
 =?utf-8?B?d1kxbkxXa3lGb1NJZEhmdHhPNkdqTml4NGFxSkZ1WWRjNG9mM3A2QkRpT09F?=
 =?utf-8?B?VmtMOVcxZmZvUUc3VHBVR3J1SGJEclhZRHNOYlVuVlowT1FKZlFQeHIvMTZx?=
 =?utf-8?B?WUdzVTArbzBubHZxd1BnR2RTc2MvYitBQzczVmxaQ3pBRWlsMzExWHFleE1i?=
 =?utf-8?B?akFTd1RoSnpkbUVFTGlKZDF0czNqTmVhZVMvMUFZUUVmZUhaZ1lxL2FPb0ZB?=
 =?utf-8?B?NEpPcWt0TGZQMjhkTnFDWStBTTE1TUxtaWF5WXBtalZoVmtkcW1zSXo1VEh3?=
 =?utf-8?B?Wi80MmpBY24zNFVIYmxxUzUzUS9UelBvSGFNcmNGZHRxenhiektsUEl1VnRa?=
 =?utf-8?B?aXpBZjMrRlBZU2tOSTNDRFdyNlh3NWNsejN1alN0dSt4YlFGSzFLWlQ2ditV?=
 =?utf-8?B?WjZsMm11c29qYWZ2eXQxa0ZQMDJ0VW9GQjNpOU5BQUZoRlNnem1hZnh6b2tR?=
 =?utf-8?B?R1hrWStZN0ZmQ1dGZWhGZ2UvVjh3amVtMjAzZzhCL1dJUU9UVE9XR3dZbGk4?=
 =?utf-8?B?KzQ1MDB3RjY3LzNNQmIzWmNuVHZWY2NtcnNRNWtKdndYZlI5U3ZCZFdGTjAr?=
 =?utf-8?B?RHdTbnM5ME1heUU0Y1JBenlBSzRkTEUvaC8xVGdrS1RFSUFrU001cWtncW05?=
 =?utf-8?B?M1l5bHRnRE9GUmFLQlpOcVRscVVzN1RIcFJNQll3OGxlUE0vRzM0cE5JUTNQ?=
 =?utf-8?B?blF3NXVlM1owTmgya1VwYnB0azNLdkdSRUtGeWNURmtaa0g4M21ISGlsZldJ?=
 =?utf-8?B?U1NValZHQUxaWUhYS01Oc1h3dE91RFZ3ZzNET1B3YURVWExtR0Jjd1FUck9F?=
 =?utf-8?B?bUN0c3Z6YTBJL1MwNW1YaFpaUEcwem5aeENKeWxTdDNZM2VFOGFqakkreGM0?=
 =?utf-8?B?UjhLTFo4VjZzWU5EeHRwZFVTeGFXN0E2Y1cxelBJWlJYQ0xZWlBPYUw0UERS?=
 =?utf-8?B?RnpyTUp3SFk5R0NWRnRWeTRHYW54RXkxYzV0bmovQ1I3WUlEc3hFSEZKd0Fa?=
 =?utf-8?B?VXdrc2ExM3BmQ1FENGczdzV0QWFuK2xiSjdScy9QQmVYYndnRGNTRkpNcXFv?=
 =?utf-8?B?Mjlwc1o4VzVhbWh5cGhRRG9rd0tscytxVUJHZzE1YUFWVDZld0xWL0F0aHdL?=
 =?utf-8?B?MHRmUFdrWDRnZ3FnL3pZMHpYUy9uM2x2UVFyRERqcWt6SitBMWNaOUxhUHI0?=
 =?utf-8?Q?XpiKSuxr3827OsZlcm8rFicwM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f69472b-b6ee-42af-1c02-08dbe6ec193f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 21:36:31.5358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7GmihKttLv6Nnc97iPAPX2mOvHAmmXYVGXe6uOtwnGMOaBiGojPKGjU91D9jJY3a7PjWUeaZKjG/InJHNdr7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8600
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

On 11/9/2023 14:51, Alex Deucher wrote:
> Should be && rather than ||.
> 
> Fixes: b2e1cbe6281f ("drm/amdgpu/gmc11: disable AGP on GC 11.5")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---

For the series:
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com> # PHX & Navi33

>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 6dce9b29f675..ba4c82f5e617 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -640,7 +640,7 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
>   	amdgpu_gmc_set_agp_default(adev, mc);
>   	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
>   	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_HIGH);
> -	if (!amdgpu_sriov_vf(adev) ||
> +	if (!amdgpu_sriov_vf(adev) &&
>   	    (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(11, 5, 0)))
>   		amdgpu_gmc_agp_location(adev, mc);
>   

