Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70192EE643D
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Sep 2023 08:16:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0724510E5C8;
	Fri, 15 Sep 2023 08:16:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D6A010E5C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Sep 2023 08:16:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKCjx8KSywuyOi2T5Pru1S3xGgErKTgreBC8ypteTrBDpWX9BfZe5KgLLbcydg+pIj7nA85DtDi2UFyyPS2XQ/GyposRPT5t9f0T7rg5rJTkwBb/NJDHRHZjR0zuGWwYhTQ8p0XWV8JCO1UVpo2E6GHuClJNX6PB61yX1GLczB1wnZUWq3YFiRw/qCER5L3rMTOwRLsj4stCNdRWzDMZHuWtpXUUjAl2UhQoHv1iNQ4D3FBRA6gkgUT4keHv1/tZt2CUCXGGON6dDV/TVYTFWAPlpsJoo+MdWeavLVv8MzLF91CDHXN5wmuKZ2IqkQpJ/3Yeui7Wcc7j7zTMNChAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTpxoTDOWWTzatq7RKx3AMeJwDdy8XFZIVsVd8kKkUg=;
 b=bxzJI4z3dv5HVVhuF8xvX6CNgS2s24tgaljk+ksYItIg/URX7MoaiOepURK5nPRpecXkcMYxypKqv0S5xHa4bCUs+X3CBrWQcvDwI4zww1+flfJhWqD720Mg4HCjgRI3K7euV6MwHz9jYzyWvcANkfdLMu71PHmJeeGF7U9aUs1t5Wd1VnIHCoHQCADypZTe39orvp4VBub8iteZPnPPSf23jpAG5TzAu9q/8+s/FtSQGNjhRdoyTQ/oCLL9b6gDWE/Ez18pdCfkzCDxU13cVgjcCLE492q9a0PFDRrNBD4+V77uivZt7vTwnH6NIimy/FEBh5All2T3YIaw8LmtZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTpxoTDOWWTzatq7RKx3AMeJwDdy8XFZIVsVd8kKkUg=;
 b=4/3SHsrmh81m9vg5H2L2qLdOe8V4ZH+UEDG6ceagyPJTSqR7tIbKOk2qxK2dlc8pZQc2u346oTTijMLa6/g+Fp6vOcIwiVC0uPPupdWCscWPOg2kIzR+Bsxt4TVhSBFIedvP6lO/mdR2Yi+X4+KgYfnX2MOERyVziXlhJy2LA/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB4976.namprd12.prod.outlook.com (2603:10b6:5:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 08:16:16 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab%6]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 08:16:15 +0000
Message-ID: <0dea2b3b-faf9-54a2-2421-d83e7e1e65e4@amd.com>
Date: Fri, 15 Sep 2023 13:46:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: use error code EOPNOTSUPP instead of ENOTSUPPT
Content-Language: en-US
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230915000605.1597561-1-kevinyang.wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230915000605.1597561-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::6) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DM6PR12MB4976:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a9182a8-6871-4957-3657-08dbb5c407ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nqir3Jwf9VbyybpY5Y2KLxGbexshM6Lg8mZdHkWuwmtAoz6buwRYdmbcKlehRsfMI2CzTNWebtAR0FBF6d47ROIUB9jO5hqiBzY3gz1I30xEPtQzUa6kZxdfttqC0nAZ6fMsFWVv4rtcujQTGbPClGUsyQD2PTo7UF/H4z5ClmcY2KsrsUGsnOb+xK9xRKUhOeF7pXn1SIf3pkOSuVr7YFolC3k9hD8LVy4Caqognu5CYL5y/wlQFp3yPDDJw1IkFDQO6Iir8Xk/pakW5GRfbVzrCcukKI5rY/9curchMAQWUe7tYNumVPQnSLBU/5bWMgjUMbURFY4nCunCsdPnG30lrds8gtzahYAHr4UVpcNC1Tj8mWknher786GBsRbqLera7ewp+OfD8uTOzhg1VzXM9VWHtJFUNXrd+/2PuoM1FYTrzZVzwqUlALd9N1SdQjwr/fx4N64ufuyzf8oWBc5ANBH9LVyVi70z4ES7KVwXfoZq19ZSGv+5iXr/qiqxoCfezDli+HKOmcOz/lxw6GtmRI26EzViYlXZMELXz2mRks7gSwiV+uMPtCOw1uUr1amxfSUZ3jv00IOCOCurHoP+9/FbJu1rAv2M7YU/ndsP2Q2+lZgu3scMgjyHL29DcEtNB8/ar40O/i4fL17+hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199024)(1800799009)(186009)(26005)(2616005)(478600001)(6666004)(6512007)(6506007)(6486002)(53546011)(2906002)(30864003)(31696002)(86362001)(5660300002)(8936002)(36756003)(8676002)(41300700001)(66476007)(66556008)(66946007)(316002)(31686004)(83380400001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXltOWxrYktVc01SSGVlZno1emY2dG4yL2JjSGJmandWazZHa21RcGJ3aVZU?=
 =?utf-8?B?NWhVdUNEQUp6TEIvNlBpRHNwdVFJYURLVHdxK1ZsWWJ5dTBnU2tPTXNQalox?=
 =?utf-8?B?bnF3QUVqVTRRcDRHaXo1cVBhS3hnWE9CeTJiTDhhTUZlQ0pYbXpXamNod2xv?=
 =?utf-8?B?elBFbkNXQmhFTzlFODZoYXRzQUI2N3RvckdyYTl6eFovWi9mckNxZEUvVmk0?=
 =?utf-8?B?SEI2N0F2cnRwTE1lVXZaZDhnc2Q4N0ZJWHhxUnA1UCtoZnVZeXVOcTNFSWxL?=
 =?utf-8?B?UGxCTVo2V2J1cDQyYkczdnRobVZnd09ZdXdwbDI4RmROYUR6WkNsZFVDZGdr?=
 =?utf-8?B?N2dTaTQvZGIxQzIwY0hnd0lwdEh6RThPcTVqWDlzVHlHRzladjZJN3JjcE9G?=
 =?utf-8?B?YkkxSmRYSlRJSjg4Z1BoS3lFZ1B6cTJieHo1OGZrWTVjbk5aWE56bUlTL2Yr?=
 =?utf-8?B?NWtsU2lpWTQwUEZBcU4xTGJNNXMvR2E2MStQTlNUR0s2ejduWWVBV1M1T04v?=
 =?utf-8?B?M0tKcXV6WHYrVXR4aWZjOWhpaGFKeERMa29vc1pzRXU3MisvUkxoQ3hFWUZi?=
 =?utf-8?B?cWZiVmdYYlYyKzBRTEZ0aWV2bm9zdnNIekk4LzR4TDZiZDRoUnYyMTFvbnJI?=
 =?utf-8?B?dTkzQ1lqeWM5SXRxMEJLaVpnZVgvQXlhdXpycGFpb2Q4blh6d2FLU3BXWnQ2?=
 =?utf-8?B?NHAyYkZJTkYrSVc1dEZHQ0Z0UnA0L0ZpWjlIME5KdlFQMFJjSjN3ZGJ1Zlh6?=
 =?utf-8?B?ZExjVzJuUEhjTkdTb1RQR0lhcHZvWXlhZnpHbVZKS21OMmdYMElwbFFBK3F6?=
 =?utf-8?B?Qkdsc29nbWlPREhGRjdHTE5LbXRwTDBXTTl1clFhWWlRekJMV08ycEVrdStM?=
 =?utf-8?B?TlNsSHZCUkExc2FULytuR3I4QnJCUGg4Nm5XaXU5WE1ueHM5U0tuaFNzeGQ4?=
 =?utf-8?B?Yzd5YlRKNGR2NjBHTGxtS21vVmtpZWNKRXk0RTJJUW5VRnYvVWpvY0VjVUp2?=
 =?utf-8?B?ZmJSeWpkNytrcklTcWk3WVJyd0x3TFBIQ1FkZW9sUmNkRGNJdXFNaW9LMDNJ?=
 =?utf-8?B?WlliRW1SejlwdVZQaXVkellPOWE5OVJxR3p6QWEyanF2NEtpUUdGWnQya1JM?=
 =?utf-8?B?NTNrR2pYZVJiUVNqMDI2aUdtZkdNUzFvNHpaVVVzUUQ4UXlrRjVYVUhOcWhq?=
 =?utf-8?B?UEc0OHRPSExRV2J6QzBQWkVsNGlrUGpnMCtlb0VZMXRFbDFGa3BMRWhwaDlC?=
 =?utf-8?B?Ymw2eWRBVm92R0d1cytyR2t2Tks5L3B0OVNjTm9UdHBUS1p1N0kzZ3ZseEUv?=
 =?utf-8?B?MUhFUUtvdnRiVTdXNUM1RUlveVU1OHRjVUFQaWx6MHBRVnNNNUwxL0JJZi9v?=
 =?utf-8?B?S2Z2d0gwUVM5emh3eFB3M3RxWjloblhOdk1ZVURMRHVDTUw0RmlQa2paUGNC?=
 =?utf-8?B?Y3JlZnMzUWtWVlJkNkY5WSs5bnkwWnQ4YkpjSDRhbGJkS3diZkxyMlpVbndv?=
 =?utf-8?B?MGFWemJoKzkvZXl6UVR6U1VnK1BvS1NuZm1HaVlQM0lnUitXbUdUS0JVRThu?=
 =?utf-8?B?Szc2S2QxMCtYZE10eUpydXU4WVYycm1MdWNhUkpYWE5jbTV2RTNUell0TXZB?=
 =?utf-8?B?UDZla2xxTUFHUUpvZkNEcTlCSjhvVlN4dUhNWmwyMm1sT0lDNmtYYUJtd0F1?=
 =?utf-8?B?bTdGRjQ4cnBBQURjZ010T24yRXBaUVUvQk9mcFhPVXhiTHV2ZUtvQjV0OVNY?=
 =?utf-8?B?WUZIR2FqZ1ZvYVVFdjJNZ2ZZNlJhWFlQbmtiVk1PRTMvSnNvWUcrS3oxUVBH?=
 =?utf-8?B?TXRLU1BxdHVkUUxKZFhTL1FLZTN2blRkTDJ4TUt6bkJEMW9aSlJxMGR0UEZ6?=
 =?utf-8?B?T20rVXd4ZmhBVFFXRHhOUFphV0EzMkVhUlJCSE9qMlBGYjhnbWNoSFRyNXRq?=
 =?utf-8?B?emlkekttS2dYTkFiS2diaVhnczRZT3FmaWN3bXd3bnNxQmFsMHliQWEzdFBI?=
 =?utf-8?B?dGJtUGZJZmJ5Njg4ZjQzakN2bDBkRFVmMnF0Y1QxTjZCYlZOVzZ0NDBZeDRN?=
 =?utf-8?B?cHJMeHpZREJhRGJ5NlIwcHp0aHkxdWZaQ0p5aXFNa0llVWlKUThQVncwcUYy?=
 =?utf-8?Q?Mw3jwMDmhbVlwQ/A4bH4rWql6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9182a8-6871-4957-3657-08dbb5c407ef
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 08:16:15.7767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/oVgrySM94gGtC3athG0tyw0jtafgVKJchSkOBqt1bkjlmMM1dL020PFr+eiQrS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4976
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



On 9/15/2023 5:36 AM, Yang Wang wrote:
> WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
> 
> $ find drivers/gpu/drm/amd -type f \
>    -exec sed -i 's/\-ENOTSUPP/\-EOPNOTSUPP/g' {} \;
> 
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c         |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c       |  2 +-
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      |  2 +-
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |  6 +++---
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  4 ++--
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   | 18 +++++++++---------
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   | 18 +++++++++---------
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c         |  4 ++--
>   10 files changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e055e06d020c..a7f0b6ccd137 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1268,7 +1268,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   	r = pci_resize_resource(adev->pdev, 0, rbar_size);
>   	if (r == -ENOSPC)
>   		DRM_INFO("Not enough PCI address space for a large BAR.");
> -	else if (r && r != -ENOTSUPP)
> +	else if (r && r != -EOPNOTSUPP)

pci_resize_resource returns -ENOTSUPP.

>   		DRM_ERROR("Problem resizing BAR0 (%d).", r);
>   
>   	pci_assign_unassigned_bus_resources(adev->pdev->bus);
> @@ -5747,7 +5747,7 @@ int amdgpu_device_baco_enter(struct drm_device *dev)
>   	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>   
>   	if (!amdgpu_device_supports_baco(dev))
> -		return -ENOTSUPP;
> +		return -EOPNOTSUPP;
>   
>   	if (ras && adev->ras_enabled &&
>   	    adev->nbio.funcs->enable_doorbell_interrupt)
> @@ -5763,7 +5763,7 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
>   	int ret = 0;
>   
>   	if (!amdgpu_device_supports_baco(dev))
> -		return -ENOTSUPP;
> +		return -EOPNOTSUPP;
>   
>   	ret = amdgpu_dpm_baco_exit(adev);
>   	if (ret)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index e3471293846f..ffd7035603cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2126,7 +2126,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>   	    ((flags & AMD_ASIC_MASK) == CHIP_RAVEN)) {
>   		dev_info(&pdev->dev,
>   			 "SME is not compatible with RAVEN\n");
> -		return -ENOTSUPP;
> +		return -EOPNOTSUPP;

Since pci base considers this as a valid one, I think it's ok to retain 
-ENOTSUPP.

For few external ones like *_od_edit_dpm_table, need to be cautious as 
the user apps may be checking against older error code.

Thanks,
Lijo

>   	}
>   
>   #ifdef CONFIG_DRM_AMDGPU_SI
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 42fc0cc13fdd..e31b7f9fcddc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -867,7 +867,7 @@ static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
>   		return 0;
>   	} else {
>   		memset(shadow_info, 0, sizeof(struct amdgpu_gfx_shadow_info));
> -		return -ENOTSUPP;
> +		return -EOPNOTSUPP;
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 65d2b9ae16bb..120b815a3f27 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -262,7 +262,7 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
>   	else if (args->queue_type == KFD_IOC_QUEUE_TYPE_SDMA_XGMI)
>   		q_properties->type = KFD_QUEUE_TYPE_SDMA_XGMI;
>   	else
> -		return -ENOTSUPP;
> +		return -EOPNOTSUPP;
>   
>   	if (args->queue_type == KFD_IOC_QUEUE_TYPE_COMPUTE_AQL)
>   		q_properties->format = KFD_QUEUE_FORMAT_AQL;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index e6f1620acdd4..2c88dbe2d718 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -147,7 +147,7 @@ int smu_get_dpm_freq_range(struct smu_context *smu,
>   			   uint32_t *min,
>   			   uint32_t *max)
>   {
> -	int ret = -ENOTSUPP;
> +	int ret = -EOPNOTSUPP;
>   
>   	if (!min && !max)
>   		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 650482cedd1f..f48ec6c62307 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2591,7 +2591,7 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
>   	case PP_OD_EDIT_SCLK_VDDC_TABLE:
>   		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_LIMITS)) {
>   			dev_warn(smu->adev->dev, "GFXCLK_LIMITS not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   		if (!table_context->overdrive_table) {
>   			dev_err(smu->adev->dev, "Overdrive is not initialized\n");
> @@ -2637,7 +2637,7 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
>   	case PP_OD_EDIT_MCLK_VDDC_TABLE:
>   		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_UCLK_MAX)) {
>   			dev_warn(smu->adev->dev, "UCLK_MAX not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   		if (size < 2) {
>   			dev_info(smu->adev->dev, "invalid number of parameters: %d\n", size);
> @@ -2680,7 +2680,7 @@ static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABL
>   	case PP_OD_EDIT_VDDC_CURVE:
>   		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_GFXCLK_CURVE)) {
>   			dev_warn(smu->adev->dev, "GFXCLK_CURVE not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   		if (size < 3) {
>   			dev_info(smu->adev->dev, "invalid number of parameters: %d\n", size);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 164c2264027d..828e6676e713 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -2256,7 +2256,7 @@ static int sienna_cichlid_od_edit_dpm_table(struct smu_context *smu,
>   		if (!sienna_cichlid_is_od_feature_supported(od_settings,
>   							    SMU_11_0_7_ODCAP_GFXCLK_LIMITS)) {
>   			dev_warn(smu->adev->dev, "GFXCLK_LIMITS not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		for (i = 0; i < size; i += 2) {
> @@ -2306,7 +2306,7 @@ static int sienna_cichlid_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_MCLK_VDDC_TABLE:
>   		if (!sienna_cichlid_is_od_feature_supported(od_settings, SMU_11_0_7_ODCAP_UCLK_LIMITS)) {
>   			dev_warn(smu->adev->dev, "UCLK_LIMITS not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		for (i = 0; i < size; i += 2) {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index a3cbe15c3123..a928ed20884c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -1529,7 +1529,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_SCLK_VDDC_TABLE:
>   		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT)) {
>   			dev_warn(adev->dev, "GFXCLK_LIMITS setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		for (i = 0; i < size; i += 2) {
> @@ -1590,7 +1590,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_MCLK_VDDC_TABLE:
>   		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT)) {
>   			dev_warn(adev->dev, "UCLK_LIMITS setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		for (i = 0; i < size; i += 2) {
> @@ -1651,7 +1651,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_VDDGFX_OFFSET:
>   		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT)) {
>   			dev_warn(adev->dev, "Gfx offset setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		smu_v13_0_0_get_od_setting_limits(smu,
> @@ -1673,7 +1673,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_FAN_CURVE:
>   		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
>   			dev_warn(adev->dev, "Fan curve setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		if (input[0] >= NUM_OD_FAN_MAX_POINTS - 1 ||
> @@ -1711,7 +1711,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_ACOUSTIC_LIMIT:
>   		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
>   			dev_warn(adev->dev, "Fan curve setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		smu_v13_0_0_get_od_setting_limits(smu,
> @@ -1733,7 +1733,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_ACOUSTIC_TARGET:
>   		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
>   			dev_warn(adev->dev, "Fan curve setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		smu_v13_0_0_get_od_setting_limits(smu,
> @@ -1755,7 +1755,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
>   		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
>   			dev_warn(adev->dev, "Fan curve setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		smu_v13_0_0_get_od_setting_limits(smu,
> @@ -1777,7 +1777,7 @@ static int smu_v13_0_0_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_FAN_MINIMUM_PWM:
>   		if (!smu_v13_0_0_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
>   			dev_warn(adev->dev, "Fan curve setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		smu_v13_0_0_get_od_setting_limits(smu,
> @@ -2356,7 +2356,7 @@ static int smu_v13_0_0_get_power_profile_mode(struct smu_context *smu,
>   		workload_type = smu_cmn_to_asic_specific_index(smu,
>   							       CMN2ASIC_MAPPING_WORKLOAD,
>   							       i);
> -		if (workload_type == -ENOTSUPP)
> +		if (workload_type == -EOPNOTSUPP)
>   			continue;
>   		else if (workload_type < 0)
>   			return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 430ad1b05ba3..f85e0ef60fea 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -1515,7 +1515,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_SCLK_VDDC_TABLE:
>   		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT)) {
>   			dev_warn(adev->dev, "GFXCLK_LIMITS setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		for (i = 0; i < size; i += 2) {
> @@ -1576,7 +1576,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_MCLK_VDDC_TABLE:
>   		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT)) {
>   			dev_warn(adev->dev, "UCLK_LIMITS setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		for (i = 0; i < size; i += 2) {
> @@ -1637,7 +1637,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_VDDGFX_OFFSET:
>   		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_GFX_VF_CURVE_BIT)) {
>   			dev_warn(adev->dev, "Gfx offset setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		smu_v13_0_7_get_od_setting_limits(smu,
> @@ -1659,7 +1659,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_FAN_CURVE:
>   		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
>   			dev_warn(adev->dev, "Fan curve setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		if (input[0] >= NUM_OD_FAN_MAX_POINTS - 1 ||
> @@ -1697,7 +1697,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_ACOUSTIC_LIMIT:
>   		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
>   			dev_warn(adev->dev, "Fan curve setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		smu_v13_0_7_get_od_setting_limits(smu,
> @@ -1719,7 +1719,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_ACOUSTIC_TARGET:
>   		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
>   			dev_warn(adev->dev, "Fan curve setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		smu_v13_0_7_get_od_setting_limits(smu,
> @@ -1741,7 +1741,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_FAN_TARGET_TEMPERATURE:
>   		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
>   			dev_warn(adev->dev, "Fan curve setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		smu_v13_0_7_get_od_setting_limits(smu,
> @@ -1763,7 +1763,7 @@ static int smu_v13_0_7_od_edit_dpm_table(struct smu_context *smu,
>   	case PP_OD_EDIT_FAN_MINIMUM_PWM:
>   		if (!smu_v13_0_7_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
>   			dev_warn(adev->dev, "Fan curve setting not supported!\n");
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   		}
>   
>   		smu_v13_0_7_get_od_setting_limits(smu,
> @@ -2310,7 +2310,7 @@ static int smu_v13_0_7_get_power_profile_mode(struct smu_context *smu, char *buf
>   		workload_type = smu_cmn_to_asic_specific_index(smu,
>   							       CMN2ASIC_MAPPING_WORKLOAD,
>   							       i);
> -		if (workload_type == -ENOTSUPP)
> +		if (workload_type == -EOPNOTSUPP)
>   			continue;
>   		else if (workload_type < 0) {
>   			result = -EINVAL;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index b3682807cec2..f81ffe7ce7bb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -50,7 +50,7 @@ static const char * const __smu_message_names[] = {
>   #define smu_cmn_call_asic_func(intf, smu, args...)                             \
>   	((smu)->ppt_funcs ? ((smu)->ppt_funcs->intf ?                          \
>   				     (smu)->ppt_funcs->intf(smu, ##args) :     \
> -				     -ENOTSUPP) :                              \
> +				     -EOPNOTSUPP) :                              \
>   			    -EINVAL)
>   
>   static const char *smu_get_message_name(struct smu_context *smu,
> @@ -492,7 +492,7 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
>   
>   		mapping = smu->workload_map[index];
>   		if (!mapping.valid_mapping)
> -			return -ENOTSUPP;
> +			return -EOPNOTSUPP;
>   
>   		return mapping.map_to;
>   
