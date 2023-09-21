Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659D4E706F8
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Sep 2023 09:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00D7E10E597;
	Thu, 21 Sep 2023 09:14:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46D8410E597
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Sep 2023 09:14:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKo4BE9iP4aMOiBZZWxhDzMh3uWbB+5fdEBPccwZSXlcTbLo9dDYzd/YMc/yxm4E33zy2Qm+TAtaVcstF53odKbZW5b6/WMG0K8Zoyx1pvwM+20zo1a/xdypyBkr4+Yew2DN2U8ZG/69zEqySCAoESCzO4TytbILIIsRFkaUSZDihfoCDi0M+UTxPq7LQYTaFo7aIKDYCHCc1rUjzI/4ijLawxUe0FCogHntEQEHwV7reEM6IwrbzAlOXvZiwNqFHUCvvjxCBRiCTmlzUf8aUmy4bqgNKBGs+qWrC8kN/xzilCBzeiJKChUhwseD0ida4HniKqnqCFsfPC1/c2e7Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLUsQRo/Q7A5CpzxeGWWqBrajkkaOorXt+yKmcj4c9o=;
 b=YEenYr3p/hPmpwM1u+mEE2sgTTw3PPa0GNpOhfYFmodHKWy2PfxPir3TXvOZyD90ZvXGYhBZG4A+gmEE+ZVurOEnr+yrM1s1BSM0pUER3DKNzVsGhblDReUccu5MvTEjvw5DHmyoOv0zfNpiigNfaOJEXWV9NADdlVXaOqeT11xrAD3GX+uD/aThs+HS+06nWY7Are/EnAkv9AvBFXWMQCj6xb/6F5hmzUszBGp0k0JqyK7duPQWZLwxWQZsGVAhuIyqF0DKFxxQFBaCkWSuMzb3V8ITJHNIOwRjUasW8NE/1UjxYPqSPtIGS9N9fJpIY2oSjm+Vns2FFgMqGx82+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLUsQRo/Q7A5CpzxeGWWqBrajkkaOorXt+yKmcj4c9o=;
 b=rWb2DP4nzcb4+8lkLNkSUq9YXoEOIeklim1inlBUzWTUc81Nm6cjX1q7+IU9UJ2LQpOKCpxxXaKz0gOgZGTkVFmQ+IcbbX/N5dx6hcQVDRsmndDbmskc2ep+FrojK+9RbllvM4pq+Xr4usDUcKu9nWvEc0bWKV/CEJqCrmCw0mw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 09:14:29 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab%7]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 09:14:29 +0000
Message-ID: <0a924f0b-1892-c8b0-6985-7bc259c65c0e@amd.com>
Date: Thu, 21 Sep 2023 14:44:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu:Expose physical id of device in XGMI hive
Content-Language: en-US
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "Gadre, Mangesh"
 <Mangesh.Gadre@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>
References: <20230921043551.3903891-1-Mangesh.Gadre@amd.com>
 <CY5PR12MB60813F7A23726EE11AA88DFD8EF8A@CY5PR12MB6081.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CY5PR12MB60813F7A23726EE11AA88DFD8EF8A@CY5PR12MB6081.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::10) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: 084cc316-abdd-4fad-3c1c-08dbba832890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KLXH/ZzGtei8k44pRLyjfBAFOsrdTiXsWVA7xmmNQD1mP3aYhLJ96nJqyF4QJ1JSMEnVup0Lo0v1tZHHayXXZf9S27Bua7rhzFXnAcxYupSIaNIfTAEVo+S7NqGU/6UGdReUEihboZ6yNFZRfvZN0UhF5bmf5UdYWKZPrJR7yMzmgxV6bKwR9pBi0sRlE4u24nzPozCULGibcAeKYA4obhsxEi2SjChAl6t3tJ2nCAJcPYL+0k/yi6ecUcbM2COGPWpRPSBZrfmULIjIVSKTcV3ZW4D0OB6Ot9dkyj+hQfkycA9V6LmsXdQ6kGRg694euF38MEixWo5z2EGCsH5Lv9G79YW93GojWo/H4bFWXjUyugsxhDdSnzJvmSO7TefeJrU00dI+BjqriKWohSYv3cFB3OWSnFx2+E3k0LkMNiPZXiWsHU0SkaaR/YBDV0jp+rCLPNn0LYL4gVWRlrnwCDcy7PFTgL/5+MMoQ/+yqgg7L1UBDf7yVfCY+oU+UlwO217KUm31T2tc+NjUkA92r3VFQ/7bogvkfk1YX2/zTIXfyKAavip+D6FazPG8ePn36TihqNIbJnh0btKg+uran2DGeea/lRLXZOiCBLrlMJb1yhQbLd3n8yssULbVYwGcXsjqYvph5Lb4csrM1aVcnxcnjk/rAfVbpKQRUS5UuOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(346002)(396003)(376002)(136003)(1800799009)(186009)(451199024)(6512007)(53546011)(6486002)(6506007)(6666004)(83380400001)(38100700002)(921005)(31696002)(86362001)(36756003)(2616005)(26005)(110136005)(316002)(6636002)(66556008)(66476007)(41300700001)(66946007)(2906002)(5660300002)(8936002)(8676002)(31686004)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak90V01QTXNoNkhPZVRKTFgxQ3Fxa1l0VkNNUU1SeFpLUXJNeURsVEVBVXU0?=
 =?utf-8?B?bXhXQk1sTWZDNWdFMkV1VUwzbERBZE5mR3lid3l4Z2VZTHYvYzBmcGJnZlFz?=
 =?utf-8?B?TnpBRTNXY29xeWhMZTBsOTNEK3dXT3BNMUp1NkZsZm1FOVlURTJFVk85UW9o?=
 =?utf-8?B?Yi83UjlSZUYxM0ZYdTMwbEJaRXkrWHhEOG1sVXV0ZE1URjJYMmJ1NHdxQXE1?=
 =?utf-8?B?eDhQcWo2dGZnWTNxdnhVMGJQU1NZWXF2VmNWQ2NlYjVaQTRHOU1LRUtueGxM?=
 =?utf-8?B?TTlVNVFjNThsZGRrWW9JcTdqMm9oUXVkWWtIMlRkODAybnhJajljZ3ZQRjVO?=
 =?utf-8?B?Nm5pVUQzdVJZTk56U2FBYkE4VXVpMWE2Ty9FWVhhMDhodjZoTUJEOHN0Q2Iz?=
 =?utf-8?B?Tnd0elJkUUNIMzBZMHRCdUtiTkRRUTRWSFdCWGlnRnVWUkpGVlpialI5dkZq?=
 =?utf-8?B?SDJTK2tuNTMycmdBdXY0YTVpSVpWVGpXazBzSzZ0cmY4N0VOQjQyR2RsaE1a?=
 =?utf-8?B?cWVYMHRPMHBSMzJwNGxpMUtrNXZ1Ny9kTnduc1lnZGN3OC9qeFFIZkUrSHBZ?=
 =?utf-8?B?NDYyczExL3FTSE9ZS0NDaE13YWRUdFFEWFVzUGtsMnlmOVdFcEJvMXhaNHlm?=
 =?utf-8?B?M2UrVmhnQlpGMzRJZjNlM3B1K2w0ZjhHREU2bHNQaTVTV2hTb2k4bkd4L1k3?=
 =?utf-8?B?Y0RMbHJ6eEZ4ZGJGeUt3Z3grdW5DWUdocVJ2Z0RRcHNuYnVTWlRRRHovSzRG?=
 =?utf-8?B?ZU1OUzI5d0MvZjhaZWpySWwzTVpVQU00RmV0TDVvaDR2SG91K1pkK2JFYVhI?=
 =?utf-8?B?RENkbitrMGw2TEpxbVkvQnZXeXdNRU8wN3VnUml6bkZBZ09pYy9IL3k5RVc4?=
 =?utf-8?B?OElVdnplaVlmSHhBeHU5R3FBKzl0L1QzRzdEZUpIckZiVThEQ1A1TUl3ZzN6?=
 =?utf-8?B?eDRXbENKeVc3dkcwUTdZeUpzMUtVak1JNkJMUVZoQnBSQmoxNWZ3dU9vbzQw?=
 =?utf-8?B?NlpFUCtYUEUzN1VmQmdnYzhNY0hJc2kxVVd0WnhIQTJTZ20wQTBhMkZOb0hm?=
 =?utf-8?B?ZkxYTXVJU0NyY3FQOVl6ZmhoUXRqN1ZTbnBwSlgzc0doakZHZFkvcXRZdUZq?=
 =?utf-8?B?U0I5VWEzNmk3V3ozWnlIb2NQaG5UemI2RUtLUTB1NlFrcDNkSDlqZi9FRnRx?=
 =?utf-8?B?VGFVSDdwakNRbzRIRy9idTN1UDY4VnNMSTJjZWtzdlFBZDlOTlZtaDhPbC92?=
 =?utf-8?B?THBNRGk2RVpsR2NFd3BwbjdvZFFya0lFVWxIZU1oMTJXUG5RRjhFYkpwV2Yy?=
 =?utf-8?B?RUoxQWt2UWxwSVBtam9PRFFOSGh6dnBOcGxhYTVpaVZEYzVkajZiTk1CK2ZZ?=
 =?utf-8?B?ejBiSGFjVUlBWWtWcjF2b1BqOFF1Y1Z5Q041ZjJWTHhIVW1mUmN1L3hOUUxR?=
 =?utf-8?B?bm5ya1dkZzFaSGhhdW5rejg1Tkxhb2YxMy9nNkVMdlFZV1gwUjc1QnFxZGtk?=
 =?utf-8?B?elA5TG5obXN2bVkvVVd2QkxnYUk1Y1pBSEhxbFJVN09MQ2ZiNmtNRXo2SWhZ?=
 =?utf-8?B?RFd6VkNiekhha1Jmc2lLcFNIcXVaT3MwclNLOEplNEJzQXVuYmJRUGdsUFF0?=
 =?utf-8?B?RjA4Q0VsMG9zVWthdjJiTFIxc0k3YnY3dFdPcHdSaG5mTUJvUWpxSGhHSUZu?=
 =?utf-8?B?eVZGMzJpMk8xb2g2ODhxTUJlUk5ZVDVQeGJEbEZIaTA2dVJPUE1JbnRDVnJE?=
 =?utf-8?B?UkVjTzNCcTBRdS9YUXRiaCtMRXpyajhESXNHdWtEUjBMekpFQWRtRmp2ZHdL?=
 =?utf-8?B?b0N5MG9iYkNpNUNnLzdzN3RUSkJjbU94NFc4dWRZK0hGYzRTVFE0VVc1YkNB?=
 =?utf-8?B?cFFYWEloVThMUjNESjNucE9zUXpwOG9COUxhNTdMOXIzdW9LdFp5MlVDTG02?=
 =?utf-8?B?V0F1SlR4U1JCMHpuY0VaYTJETmordHRJTktEekkvcGRNVzRzZjhlOS90eXV3?=
 =?utf-8?B?Q2syMGtxU2RRanZxVkp1VmlTbWEwVTJQbFQvM01aR3poQnQ4SDF5NG1DTzZ2?=
 =?utf-8?B?SU0xV2VqTjRzbHlYQXdMVG8wa3ZKbk1Qd1Jqa29KS3NzUnAvbEhZZ3lzNVdQ?=
 =?utf-8?Q?uiIJKwvfdWeefN3A4D6PI3LtO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084cc316-abdd-4fad-3c1c-08dbba832890
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 09:14:29.2036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+Pm4Nr9pjKPorwHEOj7zPR7vtyBmXg6iR9lrtXawX2mERZLoTJ2owFhWqPbNiJV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030
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



On 9/21/2023 12:34 PM, Kamal, Asad wrote:
> [AMD Official Use Only - General]
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mangesh Gadre
> Sent: Thursday, September 21, 2023 10:06 AM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>
> Cc: Gadre, Mangesh <Mangesh.Gadre@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
> Subject: [PATCH] drm/amdgpu:Expose physical id of device in XGMI hive
> 
> This identifies the physical ordering of devices in the hive
> 
> Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 061534e845a7..4cf38164d72c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -325,6 +325,17 @@ static ssize_t amdgpu_xgmi_show_device_id(struct device *dev,
> 
>   }
> 
> +static ssize_t amdgpu_xgmi_show_physical_id(struct device *dev,
> +                                    struct device_attribute *attr,
> +                                    char *buf)
> +{
> +       struct drm_device *ddev = dev_get_drvdata(dev);
> +       struct amdgpu_device *adev = drm_to_adev(ddev);
> +
> +       return sysfs_emit(buf, "%llu\n", adev->gmc.xgmi.physical_node_id);
> +
> +}
> +
>   static ssize_t amdgpu_xgmi_show_num_hops(struct device *dev,
>                                          struct device_attribute *attr,
>                                          char *buf)
> @@ -390,6 +401,7 @@ static ssize_t amdgpu_xgmi_show_error(struct device *dev,
> 
> 
>   static DEVICE_ATTR(xgmi_device_id, S_IRUGO, amdgpu_xgmi_show_device_id, NULL);
> +static DEVICE_ATTR(xgmi_physical_id, 0444,
> +amdgpu_xgmi_show_physical_id, NULL);
> [Kamal, Asad]  Can we use S_IRUGO in place of hard code value 0444?
> 
This is the recommended way by checkpatch. S_IR* will result in 
"Symbolic permissions are not preferred. Consider using octal permissions"

Thanks,
Lijo

> Regards
> Asad
>   static DEVICE_ATTR(xgmi_error, S_IRUGO, amdgpu_xgmi_show_error, NULL);  static DEVICE_ATTR(xgmi_num_hops, S_IRUGO, amdgpu_xgmi_show_num_hops, NULL);  static DEVICE_ATTR(xgmi_num_links, S_IRUGO, amdgpu_xgmi_show_num_links, NULL); @@ -407,6 +419,12 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
>                  return ret;
>          }
> 
> +       ret = device_create_file(adev->dev, &dev_attr_xgmi_physical_id);
> +       if (ret) {
> +               dev_err(adev->dev, "XGMI: Failed to create device file xgmi_physical_id\n");
> +               return ret;
> +       }
> +
>          /* Create xgmi error file */
>          ret = device_create_file(adev->dev, &dev_attr_xgmi_error);
>          if (ret)
> @@ -448,6 +466,7 @@ static int amdgpu_xgmi_sysfs_add_dev_info(struct amdgpu_device *adev,
> 
>   remove_file:
>          device_remove_file(adev->dev, &dev_attr_xgmi_device_id);
> +       device_remove_file(adev->dev, &dev_attr_xgmi_physical_id);
>          device_remove_file(adev->dev, &dev_attr_xgmi_error);
>          device_remove_file(adev->dev, &dev_attr_xgmi_num_hops);
>          device_remove_file(adev->dev, &dev_attr_xgmi_num_links); @@ -463,6 +482,7 @@ static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
>          memset(node, 0, sizeof(node));
> 
>          device_remove_file(adev->dev, &dev_attr_xgmi_device_id);
> +       device_remove_file(adev->dev, &dev_attr_xgmi_physical_id);
>          device_remove_file(adev->dev, &dev_attr_xgmi_error);
>          device_remove_file(adev->dev, &dev_attr_xgmi_num_hops);
>          device_remove_file(adev->dev, &dev_attr_xgmi_num_links);
> --
> 2.34.1
> 
