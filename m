Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91380C2BA4C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 12:50:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 346B610E54E;
	Wed, 26 Jan 2022 12:50:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCA0110E54E
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 12:50:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCDCoPb+nqF6b5BN9bGBrRXUih5+NOalSON9BL3gJvWMRQc2IUA55DsKPs8v/N3ef5v/gxkxDuhPsHbVuMZSviaTLc/xqDtcv9EL8bFx2+zDGy7lIyKK/YVuUA6hnn2gcokNuzWmYX1ZOXd3T3EF6yfQY5AP67m3OxxMtZ67sVPdFGxIArZO58QhhDF6QsQNdtlxn6zJ9zFhYph4DVIdNd9GO9rkA8RNMcvomvVnd14GOLG201xW92oPJhP4nw7dclhbtVv1aykrnY9dN+vhJTPJbTryWTmR49iVFf/sgLGxkUTev+Q7kG6FXOeh5wHwAssSldty+VC5z5KJ8KI10g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+03dx+l8XNCKr0bMrDxtYAg3LCy1PbuexrMhix22Rw=;
 b=CYp0Ket7dstOOvR3ILH3MuKF5FZtI2d2JLNpyA38NoBiseK4T0wnvOGaawSuqYIZSxb1tt1ggKRYtkZOq5FRa6HSrdjCkiDCyYZK2B/ZC86HuTypNkbFzlt6FpBf7a1D3xQpLmME3DgqdpMsI7d9i6m67QvrsGbduGGVVMWAoKugSJQx/gH8nO4TSH8rgscChnVwUK9MMz6uQpnqrk1mG3bjEGF4oq5L1XWTY1gpxN04IxRaIJRV5WA1TIvp94u84Pj+KCI4fnhvYqE1o89MHO0yAsokyIPDASapRfTLZ59nKC6wy9NluPF5ra53UKfMOGetg1gRvmRJk4Zv3lQxMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+03dx+l8XNCKr0bMrDxtYAg3LCy1PbuexrMhix22Rw=;
 b=cL4Cz+e/neVEg5o5YwjVZiuAHTDofqRJlaF0/hhYbW0DGtYSpASs8IpqwiK56iVEyvZttG55Pr/0CE08vpd+avuJYh35gSVXdJJVYW/QNj5bnByrl29aX91DBAFEQawcRbmQ9ZA9KsKHlNx1y4yz81TYt2A9NjhMNapOUVmD3/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 BY5PR12MB4936.namprd12.prod.outlook.com (2603:10b6:a03:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 12:50:48 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::7587:626e:3703:9db8]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::7587:626e:3703:9db8%5]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 12:50:48 +0000
Message-ID: <59e17c29-7bf2-32e2-7300-d110454811d8@amd.com>
Date: Wed, 26 Jan 2022 07:50:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 1/2] drm/amdgpu: cleanup amdgpu_xgmi_sysfs_add_dev_info
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Tom.StDenis@amd.com
References: <20220126115917.60308-1-christian.koenig@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220126115917.60308-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::24) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 275bc8b5-a1f8-4d2e-37e1-08d9e0ca79ab
X-MS-TrafficTypeDiagnostic: BY5PR12MB4936:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4936718F968797FBB60A8FF199209@BY5PR12MB4936.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IcNKDgLkcCgBUBkmSgL4668koCdoHNW8yGevzRLMmnqquLkXf8wl9hZZnbR3WJI9VUo9i6Ikd8gCfr3pyvn5pIn6V/0AkfcqwEfvI9zl+hVMoQj6anAqrkV4RU+Tc1oFek1ZTS9fWdKbCia806NM852scNcTkeK7E6WLXXbpsb77ljqXIazVszgW/GzusYoUQIxy8ZphkqXITDea2CV1m4U58xll3y/k/wc5dW+vpvi+0v03h9P17JGWRphyU9Gb/PK7Ryc+Mm4KK5k2qYzMVw55yqhwcTcrT9RiCkTQh65enCZmApERjWriK2cQJYTOd1Gy1wRfvYPmPW+xH9YswgkWd7mCl+LD6wzwI9wYnUg52eucq5OppcNDnVFFVmS+nxvKafSu7O2uykBTCj2nD+XkV8ywggZNap8AfKvw3PBmXqWhTd95Tsa3WxBrJX4kLwtFajS9Kcqv5XPikuEFtiVPdX4coZTq067boIp8uVGSeQBaoHC7dFx7cPfG4LztFC+z2zW53RmDG/veC/N1NEMdsKZnpc0dJz+o4N1M/RhASGroRgVaSXYQdWracxUw6wsXYmsPm4a+ECjKbcxef6zDCypLYuWTDd3HEu0Ajmr5XIuKr9VpP/m+fJhT69j1y38NvbEtTjRnWhaLYEjocRIjh2VErXAvPBvF2AAmZ7Nz0Cnm5/IgmZLZ6hfcisIdbiWxSn3lY44crejh/7hIIh17Z9+23xNmVA9Svly6E/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(4326008)(66476007)(83380400001)(8676002)(8936002)(26005)(6636002)(86362001)(31696002)(38100700002)(186003)(36756003)(44832011)(66946007)(53546011)(2906002)(6512007)(66556008)(31686004)(2616005)(6506007)(508600001)(6666004)(6486002)(5660300002)(43740500002)(45980500001)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXorR0VmaG5TMlZJQkhaaVhLSURxQXNFWFA3Rm9nclRPZDJtRWdsb3JIZUpL?=
 =?utf-8?B?YVhUK0VOdnNsWXBQU0E3VFpDdDdmb2Jicm1Nak5lVU9ZeGNnWGE2Y0hHTThU?=
 =?utf-8?B?ODM0Z1BPNFRma0diZDJjVldROUpnM1VXS3NSdzFXaS9QeUt6TmgyQ1FUN1BG?=
 =?utf-8?B?YWRab3lBcG5vL0w3ek1iVkFIYnVkUTI2d2xpUjc2cWhia0M3dXUwc0dSVkRT?=
 =?utf-8?B?dlFqR3Rhc2V2YU1wbm1NbExTdmRRcTVYZUV2RGZHZVV0Q2c4RUhRNldnYVRx?=
 =?utf-8?B?a09mOFVTeVZCZGgvTDdNaitvM3ltRWtUZFA2ZFd5M2dNaGRROVJjZEU5R0Fs?=
 =?utf-8?B?c0J4aGZUWmk5UVRTTFVVbFhUQ2lDRXBkcUVrTE9KSWlYa1NtQ0dzQkFwNUhL?=
 =?utf-8?B?dzF4VTdJVmlCTjNkMnUvS202RVczUFlUMjBGaUQ0VE5qdGNPb3ZRUWhPeGFD?=
 =?utf-8?B?S20vbFFJQ1FrN3grNjgvaERUZFN5YUJiREhCdVhSTWx4bmtFemlzV3h0NEoy?=
 =?utf-8?B?Y0d2SnJaTWFVSTRObDhobFBqaGhBR1lxY1JFTlJ6cVNSWHMweE04NCs0TTYy?=
 =?utf-8?B?aWVBVnlIbkszQzAzM2ozVWF4dnF2SkJnT0FhK3FNd01qOTFsNjI0ZDRucVR6?=
 =?utf-8?B?TmdYUHJkbzhDaTBTT1JubnZSZnV5dmtkRVE1UzNtR3BwMTBLejl6eDhNSncx?=
 =?utf-8?B?UHJqU0ptRWVmYnBUaWZYbGxTTFRCeEZkcERIUkpFVCtwaUkwSkhZVXNuWlBz?=
 =?utf-8?B?cEFIUXFQSS9jSDF1S0pvUzVRVnNocmlQMlJmb0dFRFlsMG9hZ1BzWVl4dmpk?=
 =?utf-8?B?a2lDaUZ5ZXRLREdmR3VBRmV4TzNMdGhTazJpN1N4aGpLejNGUmhvemtYbklt?=
 =?utf-8?B?UGF1ZXIzNGl2SzBRNzVyWHF0QmJoOFI4SlhxOFB6T0Y2RUgzWGtUWGVIcVN6?=
 =?utf-8?B?aXdDZmdVVDNHRFlTME93S2JXL1R6THQ0SjR3M0xZeit0bXJBc1F2MnZhbDFY?=
 =?utf-8?B?QlpRM2V2UGZkdWpKMHRCU2RtWHV2YmQxVGI1bE1pUkRsc2ZLdmtGUlQ5UCtI?=
 =?utf-8?B?TzFMT2x4bTVNTWJldFYwYm5IdHRmSHp6cVVYNitrWnN1UHp1ZFZXSUtaOUli?=
 =?utf-8?B?SHJpYmZ3c1REb2twZ1NOZ0ZyaG51eXJBTmRUR2U2d0FGTmR0VnZkZExQdC9Y?=
 =?utf-8?B?Z0xJSnlxSlAwMFdmeTRlbndXczB6S1lYU2FXS3dEUUVYMW1EdUw2WWpCbTh2?=
 =?utf-8?B?SjFhVUk0Z3FSY0xmRC9hZ0dtSEZsR20yUFRScG1EM2s3WEY4UUk1MkJ1MU9D?=
 =?utf-8?B?b2gyNHVlUE9paUUxZWJDazI1Q0d6YUpxVUFKM3IxTGRIRHNzSFQxYzVjNjNi?=
 =?utf-8?B?KytTTko1bTk3aWg0L2VCampmcWp2dysvTTUwUGE2MXZXcXk1L2w0OEk2YUs3?=
 =?utf-8?B?WUN4SStRb1RCbTNXL3RvSXFsRHRhckZKeWRhNHNDMUt5d0VVUXMyVERYTVZB?=
 =?utf-8?B?SnZkOFljcnl0a1pqZTVIV2grU01qZjF4S0tMWnp3QXA4MWdQaEdkWkhkY3VM?=
 =?utf-8?B?c0llQ3JhbWdRTHlISkYyc1JQbXhHSmorc3VpQzBpU0hUNDIycHFyNm4rbU1Y?=
 =?utf-8?B?VE1zeW9vL0xsMXB6eDBDMTJOL2w3bHZPU3VqeVMwTjBkMEZRSDNMRFVWYTZM?=
 =?utf-8?B?ekswQkE4K25JU1ZtalAyeE5EL0Z6SjNqVXp4akhaRVFWZDZYN21SWlcwaG1L?=
 =?utf-8?B?MkEyQUY3YzdlQ2xPRlhJWFNEY0x1Y1krVGlSVDJoT1A3MHJsL0U0UDRRL3pT?=
 =?utf-8?B?cmhlV1k0TjhyYWptc3lFMzI4VDQ1cGF1ZEZwSTl3Y29MS0FLUWszQTBVK2J3?=
 =?utf-8?B?WVVpclpublhJYUZtRHptSm95Tm1kWGliZU8vbmRHUGY0b3QzQzNVNVZWU1pw?=
 =?utf-8?B?ZDVGdVV2MmZNQWFoVnYram1Da1psZ1FFOGRUVmRqWFp5cGJxN1dJbkl5UFEv?=
 =?utf-8?B?THhKMmk3RnUvN1VsMFg3NTNkRzFOb2kvQ1ZHUE80cGw5T1VyWmRPS1RUTEtB?=
 =?utf-8?B?dkVQRTIrSUlQUHhTTGNsajJvbVEwU0EyaWo1TVZZQlBReEQxMTA0YmpNWnNQ?=
 =?utf-8?Q?CpXI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275bc8b5-a1f8-4d2e-37e1-08d9e0ca79ab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 12:50:48.0321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icpNVqf6LXskxqP4tNmIjzMd+yl3i7CQOPa2ZByh5P6/fZuiCcxC/953aEhabHXC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4936
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Yeah, that's cleaner.

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2022-01-26 06:59, Christian König wrote:
> Don't initialize variables if it isn't absolutely necessary.
>
> Use amdgpu_xgmi_sysfs_rem_dev_info to cleanup when something goes wrong.
>
> Drop the explicit warnings since the sysfs core warns about things like
> duplicate files itself.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 85 +++++++++---------------
>  1 file changed, 33 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 5929d6f528c9..68509f619ba3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -289,61 +289,10 @@ static ssize_t amdgpu_xgmi_show_error(struct device *dev,
>  static DEVICE_ATTR(xgmi_device_id, S_IRUGO, amdgpu_xgmi_show_device_id, NULL);
>  static DEVICE_ATTR(xgmi_error, S_IRUGO, amdgpu_xgmi_show_error, NULL);
>  
> -static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
> -					 struct amdgpu_hive_info *hive)
> -{
> -	int ret = 0;
> -	char node[10] = { 0 };
> -
> -	/* Create xgmi device id file */
> -	ret = device_create_file(adev->dev, &dev_attr_xgmi_device_id);
> -	if (ret) {
> -		dev_err(adev->dev, "XGMI: Failed to create device file xgmi_device_id\n");
> -		return ret;
> -	}
> -
> -	/* Create xgmi error file */
> -	ret = device_create_file(adev->dev, &dev_attr_xgmi_error);
> -	if (ret)
> -		pr_err("failed to create xgmi_error\n");
> -
> -
> -	/* Create sysfs link to hive info folder on the first device */
> -	if (hive->kobj.parent != (&adev->dev->kobj)) {
> -		ret = sysfs_create_link(&adev->dev->kobj, &hive->kobj,
> -					"xgmi_hive_info");
> -		if (ret) {
> -			dev_err(adev->dev, "XGMI: Failed to create link to hive info");
> -			goto remove_file;
> -		}
> -	}
> -
> -	sprintf(node, "node%d", atomic_read(&hive->number_devices));
> -	/* Create sysfs link form the hive folder to yourself */
> -	ret = sysfs_create_link(&hive->kobj, &adev->dev->kobj, node);
> -	if (ret) {
> -		dev_err(adev->dev, "XGMI: Failed to create link from hive info");
> -		goto remove_link;
> -	}
> -
> -	goto success;
> -
> -
> -remove_link:
> -	sysfs_remove_link(&adev->dev->kobj, adev_to_drm(adev)->unique);
> -
> -remove_file:
> -	device_remove_file(adev->dev, &dev_attr_xgmi_device_id);
> -
> -success:
> -	return ret;
> -}
> -
>  static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
>  					  struct amdgpu_hive_info *hive)
>  {
>  	char node[10];
> -	memset(node, 0, sizeof(node));
>  
>  	device_remove_file(adev->dev, &dev_attr_xgmi_device_id);
>  	device_remove_file(adev->dev, &dev_attr_xgmi_error);
> @@ -353,10 +302,42 @@ static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
>  
>  	sprintf(node, "node%d", atomic_read(&hive->number_devices));
>  	sysfs_remove_link(&hive->kobj, node);
> -
>  }
>  
> +static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
> +					 struct amdgpu_hive_info *hive)
> +{
> +	char node[10];
> +	int r;
> +
> +	r = device_create_file(adev->dev, &dev_attr_xgmi_device_id);
> +	if (r)
> +		return r;
> +
> +	r = device_create_file(adev->dev, &dev_attr_xgmi_error);
> +	if (r)
> +		goto error;
>  
> +	/* Create sysfs link to hive info folder on the first device */
> +	if (hive->kobj.parent != (&adev->dev->kobj)) {
> +		r = sysfs_create_link(&adev->dev->kobj, &hive->kobj,
> +				      "xgmi_hive_info");
> +		if (r)
> +			goto error;
> +	}
> +
> +	/* Create sysfs link form the hive folder to yourself */
> +	sprintf(node, "node%d", atomic_read(&hive->number_devices));
> +	r = sysfs_create_link(&hive->kobj, &adev->dev->kobj, node);
> +	if (r)
> +		goto error;
> +
> +	return 0;
> +
> +error:
> +	amdgpu_xgmi_sysfs_rem_dev_info(adev, hive);
> +	return r;
> +}
>  
>  struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
>  {

Regards,
-- 
Luben

