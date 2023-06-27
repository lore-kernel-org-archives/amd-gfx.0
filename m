Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1501EEB64D9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jun 2023 09:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9801D10E2CB;
	Tue, 27 Jun 2023 09:06:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C92AF10E2CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jun 2023 09:06:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjoqE2SxsvIkoja4F1+h8iRXKhUVZtWq41+lL9/DG3K5hOFeAeHsIctT/Ysleexs7GOLFYZC7siH+oIIZmfj83wK8cSwoUEi5RbewGox6D7uh19DpXAGXpI9ct54gU0n2AiL1Rh4iiovTIzCcfrs49TKmzA/qxor1203yQhWvrMT9cAm4yVtyISI5Y6S+JIOAuZbM2Ym3I3ZHlNB1573Yvo2gZB3pUrqTyUf8EfR4EWNU9HKoace3vuz4/YAtxooxyCGqCXvnfUy+vJLSKNhggTJ3KKKJPcKT7lahGdKEc5hiDbONJJt+pNPAhQ5dm1cEhk7iqnsAHnvq+ivWPCvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqPy78E/JcdusQuSTOaIzLQgLQfAqBghtk+ceidmaaM=;
 b=lZP2RHmuGevigGQhPX6ETUsudMCrtFHU2Q9mfucYGIFgY67Zz+2G0n9e2cUuHNpcaqTx8usmE03dqUHAq36zmtAoV10y1S9cu/tFMy0B/jHnffvsXsLgiIHDvna3sapMQCrN7kxRnuwjCLxCD1DwZvt5tuNDOWPiTkQiczB2ULmols+tO/QNgQNwSSD1PxGy7tbTvRFH6xRImpqxXTmypL2yrviz+VTaLzO/k1EQ9TKViL2mZbjWhZASyfjV7ZFXkOCm+GYN2M+W46HKk9Erz7c86BfsaMNiL8UNiPWSFq2rVpNy7FsETEUFqOwesDiGaPb4Wx4xdJq36L1rncF4xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqPy78E/JcdusQuSTOaIzLQgLQfAqBghtk+ceidmaaM=;
 b=CavDb5Dl3eLNTI1B4mpqvoV8EoYlDMUTj3uFFrLd/f/MOxIfRX74K7CniGUddXF25iDtzK/HnftGbf+HqfwL+C96xG0r2BuowQ+D5ExradR52y45FyBe+y1fgdqNx5Gs2gVjBj5TqenAAn5zW5FElN90JqROMYMqWYF/ShF6fsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS0PR12MB7557.namprd12.prod.outlook.com (2603:10b6:8:130::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Tue, 27 Jun
 2023 09:06:41 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 09:06:40 +0000
Message-ID: <b0cc84ee-0adb-70f3-f1c9-30a77fdc289c@amd.com>
Date: Tue, 27 Jun 2023 14:36:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/5] drm/amd: Use attribute groups for PSP flashing
 attributes
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230626150407.1447-1-mario.limonciello@amd.com>
 <20230626150407.1447-2-mario.limonciello@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230626150407.1447-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::17) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DS0PR12MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd5c931-68bd-4fa1-1bef-08db76edd1e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 24Q8FZI85+b6HuEPDjFhbwi1U3B0xx9i/sxtjm1r/Zm4ejvzMQB43oAJfJwUraGqjpN0XV9NyWDlycGe6aZq9MM2OCGQ9qk8Ymk4OFwZOjDiuKKS4MXB+LCPmG9d+zRKjpLyORAoSF/3Bo+knquCmF2wTp3JSvRqjyJeYuLOR2ur+C7Ro8X6T7RP3rosE6Z3JmAsaSalacm49LWTqgZDmJbEmWcxz433+HgSfxdiIu7OY9ckN5X/6QYGYAYntO6JKBYCGRfS9sP/W8luNVYPvNo0bkZ1cypUvqREaEecafsoMz7vCFRaUT7/MGmHSujOKg8HsT36sVz8FKy4+KNAe4EHGfxWfVnL4m64ngBr7htP4v49cSvqGXlAxNb792ySi3tKuSkP69rN6RUpaF9MpSZaMusXKJl+ujD8Med5S7LjH3S1T7va5kSQ911cv2hLsfPmfrj7m6dNRk1lqdPD1uQfSTbNj4JzBMOhWNgSw7rEGWLSUk2dj5zcEje4/owqL+UcpXo5qf2DCCTFSeLbasqWioUMG/oo5648iLJsbJ4IETJPoLXn8rvusitWd2GRI3+XeUZIfcvEStkEf4wkRlEi7BoYUIBoMde/5wj3b3r89WPUclRTA/NQOPYBecJC0rpzKkv4dXv0JhrNl/3AeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199021)(2906002)(186003)(6486002)(38100700002)(2616005)(83380400001)(6666004)(6506007)(6512007)(53546011)(26005)(31696002)(41300700001)(86362001)(316002)(478600001)(36756003)(66556008)(66946007)(66476007)(31686004)(5660300002)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2FOVkRrNFFsZTZwSHFuWTJWU2VSQVdsN0szNHpydGdpaWxXblJMWHVBLzVr?=
 =?utf-8?B?bjV2OFU5alpzQTA0TDVTSTkraW1CdlRTYXhQcmxmOFJJWjBmZC9YcUoyU0ZI?=
 =?utf-8?B?WjUyY2JIODBkZzk1SE1Hc3E5UEU3WXhYMEluS1cvaDNvalZDV2ZTeHhpbThj?=
 =?utf-8?B?MzlFSnozWXIwSHd2SGR1V3IrNU9aMzhlbkVKcE9xak0xajc3WEp0V0IzT29Q?=
 =?utf-8?B?azE2SkJzZE5Lc08yQ21wWkRrZmovMFViVWxrY1pKTzYrTnRvZjFGMzZGOGFt?=
 =?utf-8?B?OVBibXg1dlhnWmVrdGZRSUZxMkg3OVI4V2lCWk5yRGo5ck52NTdDMXlrNVVn?=
 =?utf-8?B?VGw2TmpIUUNPL3NRd1lEUDJxMkFqNlMzcTdoU2c5dkVjRUxhWDR2Wmdzd2Fj?=
 =?utf-8?B?cUxocytoTFk2b3VEa0FzdDZwTVRsWmVQak1zbHZjRlZGMXlOVjhJcURWbHlh?=
 =?utf-8?B?OHAwWm9xd1hMS0NiclJxMDhqZkY2dlJyS29TN0FDWHNkZlJyR3NrL1k5WEY2?=
 =?utf-8?B?aWM3US9MdXpCYUlHMlpTc29senJqM1pja2gyYXU2UEpKZzNWOEdZQTFLa3Np?=
 =?utf-8?B?dk5ZMHBLdUJXUldiRHlONi9hanR3WjFjcWp0M0hRM3RQUVFDNVI3TDdnbjZM?=
 =?utf-8?B?NHowUWpuaXVUU2EwQ2RaeXpHVjJOVTBQSDEyOTcwZGFnZDBmVm5pN3BzMCtO?=
 =?utf-8?B?S2NDc1k2YzhOK0hoNzJvbnFGeEtETlpBRm5ZTTY5L1Z4Z1YyelJpWDNCSUpS?=
 =?utf-8?B?OS9kQjRWZEJ2TTdxK3J1VFVsN0RJTURHZGQxVnZjOTdHNWVhSitGeEtBOHd1?=
 =?utf-8?B?T1gvdngrYWdWejNLY0hEMDVES0p3b3pZUTVlTkNZbmt2VmVwZ2hiK0NMbG1m?=
 =?utf-8?B?dkZoZmc0ZGE4ckxsclJzN0M0L0QrOXdWVEZWVy9lcWY0aVVaSmttVlByWTEx?=
 =?utf-8?B?QytqVVd2T1hFYXBvR3F4cGkxZ3JpQk9YdTlOS21IZW5xUW5SbVFwdEoxUFNJ?=
 =?utf-8?B?Z3pTZWdDM0dNSFkyc0orY3pnTm1KTjlGcWNCb3N6ZWJVdTQrdFRhQURGOHNR?=
 =?utf-8?B?RXdwK2pqZzltaGJaeklYbXZBcVVITHRKSEU5WEJGOVh3ajlZbGxna0ZPYzFX?=
 =?utf-8?B?aVpHV0ZjeEp4L0tiQnFrSzBwdWNnckJ1Nld6dUtmVS9VWU9iYTVqY0NITFZK?=
 =?utf-8?B?eWhsT3kwTzcrVERCS2VreHhLTG92b2NVNVkxWVBGK2U4WUhnVmF0K25ZaXJR?=
 =?utf-8?B?dHd1cEVFL0cxWU4zYmErMHUxQ1R4OVFVTmFjRE9leUdKaGtUcE9NemlVK0Fj?=
 =?utf-8?B?VXd5VGJzTlNLQWxuTkhyekpENGhXd2xMUnZGRk0xV0hvcCtZWWJ3K0VuRk1N?=
 =?utf-8?B?bUVpZk5pK3FGVnh0UENvVzNhZ0U5dXNQay9GU3J3T09BRHM4eGxDY1FIYVhT?=
 =?utf-8?B?T3M4UDc3ZlFQeHpuaVY3VStkRkd2Snl3bHlzREk2NjBJOHhaaUpKZ1gwUlVH?=
 =?utf-8?B?aml6YmFuS1lOTm5yb0V2dURPTUx0V09vZEprcFd5UXpKRzJBaTZhZXVpUHRy?=
 =?utf-8?B?R2FJcjlLd1E2UkNSM1RDTG5JQTd0YllpTkxIUmxuK25uYVBJUnVNdHhJa2Za?=
 =?utf-8?B?b1RBaVhwV3FkZHBoTENmTWxlQVlqWkh1WEdKZ1dxYzRmRitwL2tTWTRNeTQz?=
 =?utf-8?B?YitiWHdoVnp2RHZDbFRMWHFKU3JkYmtZUHJ3WVJvOVlMb0tHUjhKMnowWjgy?=
 =?utf-8?B?UjNIYlNCcC92VFFDUmFieEgzMFVDN09xcysxVGZXQjVGNTdHbDJlR2lXWXlR?=
 =?utf-8?B?eThzcThWKzUwb3h3OGNiUklEbzB3ZzBOL3B4M1hDLzBYQWNWc3B6RnJlUldz?=
 =?utf-8?B?dUFZd0JrbnkwdnJ1UVA5SjVhM3Z6SmxxU0FuQWMvS2VheXVSc0pQTUxIZFdr?=
 =?utf-8?B?cmF3TG0xMnYxc2ZpOGk5SHVQOVRjTTBidzRhc3I3dUM5MFFsN1c3RWlmT01Z?=
 =?utf-8?B?THRERUsrWUJVVTRPNW9vNFluL2s4Q2VmWU14bHVUT0p4Um1Rb0EvOFRhT3Vi?=
 =?utf-8?B?cWFKZkMvSW56VmxGQTVMUkxzeGdMSTFVcjB4SnhHU2tXak1INitIN0FJSmNI?=
 =?utf-8?Q?ynQG+YwhlKwCIMlz0uafHcp9Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd5c931-68bd-4fa1-1bef-08db76edd1e6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 09:06:40.7812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86kORdkIxHPO7S2MlZBH5YtQxbQMAIrYkCUMqpmhggkl1fRZmO4wQv12fUb7xUjC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7557
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



On 6/26/2023 8:34 PM, Mario Limonciello wrote:
> Individually creating attributes can be racy, instead make attributes
> using attribute groups and control their visibility with an is_visible
> callback to only show when using appropriate products.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 -----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 49 +++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |  1 -
>   5 files changed, 27 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 02b827785e399..a7ef43e25c758 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1004,7 +1004,6 @@ struct amdgpu_device {
>   	bool                            has_pr3;
>   
>   	bool                            ucode_sysfs_en;
> -	bool                            psp_sysfs_en;
>   
>   	/* Chip product information */
>   	char				product_number[20];
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5c7d40873ee20..65fe0f3488679 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3907,14 +3907,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	} else
>   		adev->ucode_sysfs_en = true;
>   
> -	r = amdgpu_psp_sysfs_init(adev);
> -	if (r) {
> -		adev->psp_sysfs_en = false;
> -		if (!amdgpu_sriov_vf(adev))
> -			DRM_ERROR("Creating psp sysfs failed\n");
> -	} else
> -		adev->psp_sysfs_en = true;
> -
>   	/*
>   	 * Register gpu instance before amdgpu_device_enable_mgpu_fan_boost.
>   	 * Otherwise the mgpu fan boost feature will be skipped due to the
> @@ -4064,8 +4056,6 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   		amdgpu_pm_sysfs_fini(adev);
>   	if (adev->ucode_sysfs_en)
>   		amdgpu_ucode_sysfs_fini(adev);
> -	if (adev->psp_sysfs_en)
> -		amdgpu_psp_sysfs_fini(adev);
>   	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
>   
>   	/* disable ras feature must before hw fini */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 393b6fb7a71d3..99b8d3113d6af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2827,11 +2827,13 @@ static struct pci_error_handlers amdgpu_pci_err_handler = {
>   extern const struct attribute_group amdgpu_vram_mgr_attr_group;
>   extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
>   extern const struct attribute_group amdgpu_vbios_version_attr_group;
> +extern const struct attribute_group amdgpu_flash_attr_group;
>   
>   static const struct attribute_group *amdgpu_sysfs_groups[] = {
>   	&amdgpu_vram_mgr_attr_group,
>   	&amdgpu_gtt_mgr_attr_group,
>   	&amdgpu_vbios_version_attr_group,
> +	&amdgpu_flash_attr_group,
>   	NULL,
>   };
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index eb687a338a1bd..4286c0b4beb90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -3584,6 +3584,13 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
>   	return 0;
>   }
>   
> +static struct bin_attribute psp_vbflash_bin_attr = {
> +	.attr = {.name = "psp_vbflash", .mode = 0660},
> +	.size = 0,
> +	.write = amdgpu_psp_vbflash_write,
> +	.read = amdgpu_psp_vbflash_read,
> +};
> +
>   static ssize_t amdgpu_psp_vbflash_status(struct device *dev,
>   					 struct device_attribute *attr,
>   					 char *buf)
> @@ -3600,39 +3607,39 @@ static ssize_t amdgpu_psp_vbflash_status(struct device *dev,
>   
>   	return sysfs_emit(buf, "0x%x\n", vbflash_status);
>   }
> +static DEVICE_ATTR(psp_vbflash_status, 0440, amdgpu_psp_vbflash_status, NULL);
>   
> -static const struct bin_attribute psp_vbflash_bin_attr = {
> -	.attr = {.name = "psp_vbflash", .mode = 0660},
> -	.size = 0,
> -	.write = amdgpu_psp_vbflash_write,
> -	.read = amdgpu_psp_vbflash_read,
> +static struct attribute *flash_attrs[] = {
> +	&dev_attr_psp_vbflash_status.attr,
> +	&psp_vbflash_bin_attr.attr,

There is a separate bin_attrs/is_bin_visible in attribute group. Better 
to make use of that instead of mixing bin and regular attributes.

> +	NULL
>   };
>   
> -static DEVICE_ATTR(psp_vbflash_status, 0440, amdgpu_psp_vbflash_status, NULL);
> -
> -int amdgpu_psp_sysfs_init(struct amdgpu_device *adev)
> +static umode_t amdgpu_flash_attr_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
>   {
> -	int ret = 0;
> -	struct psp_context *psp = &adev->psp;
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
>   
>   	if (amdgpu_sriov_vf(adev))
> -		return -EINVAL;
> +		return 0;
>   
>   	switch (adev->ip_versions[MP0_HWIP][0]) {
>   	case IP_VERSION(13, 0, 0):
>   	case IP_VERSION(13, 0, 7):

If we can init some flags during early init of each IP, then this type 
of check can be removed here. Instead check the flags. May need more 
work for such flags when some IPs support only read vs some supporting 
both read/write.

Thanks,
Lijo
> -		ret = sysfs_create_bin_file(&adev->dev->kobj, &psp_vbflash_bin_attr);
> -		if (ret)
> -			dev_err(adev->dev, "Failed to create device file psp_vbflash");
> -		ret = device_create_file(adev->dev, &dev_attr_psp_vbflash_status);
> -		if (ret)
> -			dev_err(adev->dev, "Failed to create device file psp_vbflash_status");
> -		return ret;
> +		if (attr == &psp_vbflash_bin_attr.attr)
> +			return 0660;
> +		return 0440;
>   	default:
>   		return 0;
>   	}
>   }
>   
> +const struct attribute_group amdgpu_flash_attr_group = {
> +	.attrs = flash_attrs,
> +	.is_visible = amdgpu_flash_attr_is_visible,
> +};
> +
>   const struct amd_ip_funcs psp_ip_funcs = {
>   	.name = "psp",
>   	.early_init = psp_early_init,
> @@ -3661,12 +3668,6 @@ static int psp_sysfs_init(struct amdgpu_device *adev)
>   	return ret;
>   }
>   
> -void amdgpu_psp_sysfs_fini(struct amdgpu_device *adev)
> -{
> -	sysfs_remove_bin_file(&adev->dev->kobj, &psp_vbflash_bin_attr);
> -	device_remove_file(adev->dev, &dev_attr_psp_vbflash_status);
> -}
> -
>   static void psp_sysfs_fini(struct amdgpu_device *adev)
>   {
>   	device_remove_file(adev->dev, &dev_attr_usbc_pd_fw);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index cf4f60c661223..b441c07e5a16f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -522,5 +522,4 @@ void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size
>   int is_psp_fw_valid(struct psp_bin_desc bin);
>   
>   int amdgpu_psp_sysfs_init(struct amdgpu_device *adev);
> -void amdgpu_psp_sysfs_fini(struct amdgpu_device *adev);
>   #endif
