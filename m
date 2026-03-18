Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8FAFCD0A5
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 04:03:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C21EE10E725;
	Wed, 18 Mar 2026 04:03:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SxVJtm7D";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 248B710E725
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 04:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zw9B6+8jpnneMQ2k86Re+Of87CcA2tfjDQpv7zKUYojzlm5lRSTsSn6SHJ6OoL1+icKIpu31uTaVXth95Nh7MzHAA0Xl2lf7bdO6GMgv2Qmjh/r//MakhiL/5HgXXzFrXvm5zKwW/htBB0x1x09ax1uO5cRAwKqEX1k+BiuHcMuOy5nE+R3Q1b2VIIhPPKbzIoo6JeKWO8WjzhBFUF672UWi4Pj+vhIrKMr1a0+LiYBbCWVSytOP7fHOB52r35d1syv+U+BXJJGSzyC0gARNB0BSCwv5D5+3HvqN9l45rsoMNRxB8aKm4RoOJGzS6T8hD8COff0ELPeIjBtaUxn0/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8pNNQSoNcg6io2DKVozndqBzjfztjrYGmCqb0Qkp9A=;
 b=aG8TvlFv4LNU25h2t8FHQ9BYX+8VPS/WxZhPax5d0Y068dSEmRMdvTZc6QfVLVOvn7ZFdnwPesWAdLYtmlOkNYZkUzqBb5JAXAX0peONN6H0ThdpIPTtAqokZySyVAPkTgKC6TuTwrAuzpnGZgMmt2+c65eQ0xh2C3oRIo/oqlL9de+vudIQ37SybamLwzT0iuSy1bpoDvqE+oDmbOM6BMjxfmeH2hFgxakKyFX9GpVeZtm4fTN6eEBGFr4D3C9gT8Xd+vNTPVIPnpNjWfCjSpfNIz6XylEkqVNipNERBUo9vUJSYuA9/B4A9QnaGePDDXrdvCbL5nlDlen4948hVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8pNNQSoNcg6io2DKVozndqBzjfztjrYGmCqb0Qkp9A=;
 b=SxVJtm7D3Ror2aovHXqMISn+O8cesQWxOStlLaNw4YBp3YsjlYJnBxRIbYwLvMjCTofVdjLwlpMkIiqQQ+eiVWMIpgGhHKBAcG168NYlLByzWLEHmHzsyD1xf133gzkyNJl3HVy5XGPGxUKBZ89C7KNpu95SdL++Iv+XpXVgZbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17)
 by IA0PR12MB8976.namprd12.prod.outlook.com (2603:10b6:208:485::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Wed, 18 Mar
 2026 04:03:21 +0000
Received: from DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96]) by DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96%4]) with mapi id 15.20.9723.014; Wed, 18 Mar 2026
 04:03:21 +0000
Message-ID: <6d411b13-880e-4f7d-ad23-1c94073bb0a3@amd.com>
Date: Wed, 18 Mar 2026 00:03:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: Fix ISP regression issue in kernel v7.0
To: "Du, Bin" <bin.du@amd.com>, "Nirujogi, Pratap" <Pratap.Nirujogi@amd.com>, 
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
 "Chan, Benjamin (Koon Pan)" <Benjamin.Chan@amd.com>,
 "Li, King" <King.Li@amd.com>
References: <20260309215052.1417114-1-pratap.nirujogi@amd.com>
 <9e175890-0927-4626-9613-7ea9e3f54b21@amd.com>
 <653ccfa8-8b92-4c47-ae45-5bfa91302f50@amd.com>
 <0fb83ff2-33ef-443d-a4a1-1608d52d34cc@amd.com>
 <46fa7959-ff84-4ea8-a17b-3825876b64eb@amd.com>
 <8a9ffdb8-d76a-43e7-ad3a-3b0f45d04b1b@amd.com>
Content-Language: en-GB
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <8a9ffdb8-d76a-43e7-ad3a-3b0f45d04b1b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::29) To DS7PR12MB9501.namprd12.prod.outlook.com
 (2603:10b6:8:250::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9501:EE_|IA0PR12MB8976:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d718ed4-dda7-4d62-30d3-08de84a34b6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: yVESVOMsRUhOBmlRRxe6ZVTsuRvXBCdOlEnx8qxtNMadcapYYR6YtR5yTPOLzxvs04wXXNx7SXJnJIO8qFEFYtIVP+uO/R7BZ8nojKlsuZZYLZzCh1A6+RyaapFBqF2aK/RkbKRdK2j2RYUuJ+Rj9NGag+L1IEl+iyFeEPTQo3xTPgMqx8H9mYKWVkL8GIYBo/MucwxHGOXeHNU1MzNYUshvsmZXZzAumLVEZTzU1d0sneth7QTqU5JLFHoePIviFrN5mPNx1hYXs6d/0imOAZvQMKCYV8UYUHTFFpjZ2Yl6n+urS8R1ahU2jWJg761sEaPrc+OZ+XrmkqhnHWCKDothRPQxKTf/XO+ouKEd4+nfH/6jvT0SGGEJPwlgPfyTwx6PGkRp0rzx8XS92aTJRUl8WbU59uWU6nlNl3hC8SoAx0K8B+FGm1FLJjXvmZXsYOk10L49yKOLKKXkKU4vZeg576y3stU2JhoeN+BW2vACmObiNm8vXwiZNATWWomcZ3foQsQ0xWOrhPgVYh+64tvIJVkeO1Jx04eNgRxX8p4Z2bRJ1Dl+DDoSskXWXla91UijExHwGByFyCVMU3RcfQvclhSKbXDMOfu1vOVWoXsToPZfjmKgQndLwwhK9LM9FdSrQy4UsF1KR47r3ZHZNSwkUp7RpF/vP4ICYCrrMRScjaobE5hzk/z2DKnX11r3y/fWfe3m9y7tGsk3wC9rI6eSJWL5Hke8f4eU7vN1Hsln3P6j7kLIGPF7kh4/h6ShOKhJ2j/EvScMiyjLmMWo4yWLdGWbzo8plmhSa++/CN8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB9501.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(921020)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDVjQUpyaWtaUlp5ZWtCOGFTVVdXc0M0cWgwclBvS1VWNEE4MGNBa0VyYUpo?=
 =?utf-8?B?NDFKVXE3NWdCWnIzTmxBUUZQM25oaWd0QStaUkU5NE9XcWNSK0FobkJqMFJk?=
 =?utf-8?B?WGY4SXpRRElNdGRYQ2pVSVA2OG1NcktjS1FVM1pLNXh6WlVRVzRWMm1kS05m?=
 =?utf-8?B?RXAxT1dkM3V5bzRERVpjUnFURVdkTjMzaEJDVXpXNFUzL3creFo0M0x2NnhI?=
 =?utf-8?B?NjBZbEZoMzRHOStPbVRkeksrZkNFSlJtdXZIM0l1Z2N1RUIyaUIwRWF1TzlP?=
 =?utf-8?B?OFZDTTRBMkdOOHMzOERsQlM1LytaQTlncEhQT0NzN01FTmdvY29tSkZrcUQ0?=
 =?utf-8?B?b2svcm0waDllZnRjTUZJK3ZpU3JsS1JSTDBHQzcxME84RDlkYnhkMHp1Y25m?=
 =?utf-8?B?d1pud3Z0VkNHRnFhVi9rdVUzaTF2S0tLVjJPbzRDMTcvdUFCdDlRVjdKNno5?=
 =?utf-8?B?Z2x4am5DRnliUjRBY2pJNHcxNFlEOW9tVWpNQzRLbnNWTzlTZGZCM296NU1W?=
 =?utf-8?B?TEpxOGtHTEt3YVpXUm8vakliTzdoNWVKd1NoMGFvOG00T2ExbXlXbDNoSnFs?=
 =?utf-8?B?Z0xjOXE1Vml1Tm14TnZRbVNJcWVNaU5CL0ZIb1I2NlQ0TEVBSjZCWU42ZXYw?=
 =?utf-8?B?Ym5OQVhaTWxOVTU0OXN5TzA3OThoNGJ1aElSd0JBRWpYU3B3eW1sL2g0SWpv?=
 =?utf-8?B?UmlMemcxayt6Tk95VmhPL1ZkQzFZclVoTVRUSVJURUVNSTFJR3Niai94Q0ti?=
 =?utf-8?B?TTRuVlQ3RElpRWdyOWF5cXcyeTZQblI2dC9rNjkyVnJkSXc0VFZ3Tk5rc1No?=
 =?utf-8?B?RHlubnRXYlg3ZjBaTUFSTWgyUVBrNjg0aTdUdUJORnpjQVVFUGM3ZWFGSGdD?=
 =?utf-8?B?c0M2VTR2RGgwNmVJRXNSVmRYeEdkbXRKOGlINks0TWp2Tk9pN1A4REMxMXYv?=
 =?utf-8?B?UVJQL1F2bGF2T3U1d3dKZUw0OEVKSVRObHBodUN0K3BMUitCcTVpcDBmN2pH?=
 =?utf-8?B?YVB3OEswMHlmWXVlRW9aSC9XNHcxMnRmbDF3c3JLbjh4QldIbzZNUXR2WHZT?=
 =?utf-8?B?eHlUUXpPRkxrdHI3ellzWTl1WGUyVk9nZ01LN0pBdHlNMFlLbU41eHNEcC91?=
 =?utf-8?B?NGViNUg1RzRrZVY2cmZVTUwwNzJKdXdhTTJHQkJKZnN5d2hEd3hFZURiQTVX?=
 =?utf-8?B?Sjd6RXBOL2ZycmJMTUFXZWpnOUNIa1I3UFppbVcyN0VVYzU5VmN6TDZLV1ZS?=
 =?utf-8?B?S1JJakF0TGJNK3U1Sm5DQmMrYTFqOU4vUjZ1OE9KcE9XS1RPNndNQU1DMlR5?=
 =?utf-8?B?NnlRbmFVMlcyV1pSWVpPWnVveCtiNmtLMVJuNldhc3h3RS9DS3Eyb093Q0VW?=
 =?utf-8?B?SlpObFVKSHN1ZU1GRk8vSmFFNnlLRWNISUlxZFhNMzY0aDFtTEwyRC9TckY3?=
 =?utf-8?B?U1g5cmFrSDI5Y1lON1BaMEovRHdwMUdDY3daY1BHSGY4eTJLZS92MkdVRHpt?=
 =?utf-8?B?ZHBBWG1zcjlyb2ljM0VzQXlITEVlN0ZOMVYrMGhRbmpFWUVBT1Vpb1ZhVEUw?=
 =?utf-8?B?aFAvMHpIRUxLV3E2aEI3clltUEpFR3Q0MTExbHFWUDcvL0hETTd1TzZ4MmYr?=
 =?utf-8?B?U2tBc2VJYmtKdWRmaTJ5ZDByY1RZbEtFUC9UeHJiMTZiMG5wMFBybC9TcHBU?=
 =?utf-8?B?V3JJYzFVL0dBY01pSmdJejRVbncvRXE4aGZqa1hpMkJ1bTNHR2tNcWxQQ1pE?=
 =?utf-8?B?S2xjVmcwMHUvYVRoR3dVUDlwR3o5aUhoQTg5SlVIb0JaQ1B1Q3FBaE0xQ3NS?=
 =?utf-8?B?MzdNZlVVSVRYUmVXc2hhTFJjTkUvRHRLRllyUTBoMjd5ZFVxeWd5ZUVINjZ4?=
 =?utf-8?B?a3psZmQ3ZVJFSXcyQ0M0MnpTNFJpR0ZEaUUxWHFxU1hIc0hZY081dEcxaXAw?=
 =?utf-8?B?Zm9Sc0hDN1Bjc242NUIwYUdYbDBEY2lyYkJzZlRqOEVqWWNJL0VyQ1dyTi9M?=
 =?utf-8?B?ZkN0b1NleDlPbmlMbEF5L1MyUnNsaVJhZERZeFRsVnA5MHNSQmVYdVp1Wkxu?=
 =?utf-8?B?NTFPODlxS1ViQzIxZGNSVFJkaDU1TGxVRXpHa3F4alVWVlcwRnNub0dwTUpH?=
 =?utf-8?B?RHdack82Nnh4dUx5MFgxamo5TWRJY0dPWTRaNlY4REdxbkpqd0VRTjZRVk1t?=
 =?utf-8?B?ZWNMY1lQRmVtT2toT21hZ25PZ0FiZk8wb1RhNVBnM2ZZaU10eXlVVm9OWkho?=
 =?utf-8?B?aUI5L0ROMG9QRnIxK0o5bytnNGlsY1FqbGlMVUVKWjlLdG5JcFc4dFo0NFJp?=
 =?utf-8?B?L281NEUvWUV3MXQ4YUVqMTI1R2lNZVF0bnQyQWhXS3R2T2doeFQwUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d718ed4-dda7-4d62-30d3-08de84a34b6a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9501.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 04:03:21.4908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXLPvbfqNFaqj84b0fZPuBqm4VSztISy+vyaR2Oc9bz1Nq4FVzjboELjteAcYOzRDLc/EfureDaLqlkiXTfcJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8976
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

Hi Bin,

Could you please review the below patch that was submitted to address 
the automatic modprobe issue.

https://lore.kernel.org/all/20260318034842.1216536-1-pratap.nirujogi@amd.com/

Thanks,
Pratap

On 3/13/2026 7:49 AM, Du, Bin wrote:
> Hi Pratap,
> 
> FYI, the following patch may resolve the AMD ISP driver not auto-loading 
> issue (without using MODULE_SOFTDEP). Please double check.
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/ 
> amd/amdgpu/amdgpu_drv.c
> index 920595f0d22c..95d26f086d54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3212,4 +3212,3 @@ module_exit(amdgpu_exit);
>   MODULE_AUTHOR(DRIVER_AUTHOR);
>   MODULE_DESCRIPTION(DRIVER_DESC);
>   MODULE_LICENSE("GPL and additional rights");
> -MODULE_SOFTDEP("post: amd_isp4_capture i2c-designware-amdisp pinctrl- 
> amdisp");
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/ 
> amd/amdgpu/isp_v4_1_1.c
> index 485ecdec9618..409c1ca5a5e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> @@ -118,6 +118,29 @@ static int isp_set_performance_state(struct 
> generic_pm_domain *genpd,
>          return 0;
>   }
> 
> +/*
> + * MFD core sets the parent GPU's ACPI companion (LNXVIDEO) on each
> + * child, giving them modalias "acpi:LNXVIDEO:" instead of
> + * "platform:<name>".  Clear it and retrigger the uevent so udev
> + * sees the correct platform modalias for module autoloading.
> + */
> +static int isp_clear_acpi_fwnode(struct device *dev, void *data)
> +{
> +       struct platform_device *pdev;
> +
> +       if (!dev->type || !dev->type->name ||
> +           strcmp(dev->type->name, "mfd_device"))
> +               return 0;
> +
> +       pdev = to_platform_device(dev);
> +       if (pdev->mfd_cell) {
> +               device_set_node(dev, NULL);
> +               kobject_uevent(&dev->kobj, KOBJ_ADD);
> +       }
> +
> +       return 0;
> +}
> +
>   static int isp_genpd_add_device(struct device *dev, void *data)
>   {
>          struct generic_pm_domain *gpd = data;
> @@ -375,6 +398,13 @@ static int isp_v4_1_1_hw_init(struct amdgpu_isp *isp)
>                  goto failure;
>          }
> 
> +       /*
> +        * MFD core sets the parent GPU's ACPI companion (LNXVIDEO) on
> +        * each child, giving them modalias "acpi:LNXVIDEO:" instead of
> +        * "platform:<name>". Clear it so udev matches by platform alias.
> +        */
> +       device_for_each_child(isp->parent, NULL, isp_clear_acpi_fwnode);
> +
>          return 0;
> 
>   failure:
> 
>> -----Original Message-----
>> From: Nirujogi, Pratap <Pratap.Nirujogi@amd.com>
>> Sent: Wednesday, March 11, 2026 11:29 PM
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Nirujogi, Pratap
>> <Pratap.Nirujogi@amd.com>; amd-gfx@lists.freedesktop.org; Deucher,
>> Alexander <Alexander.Deucher@amd.com>; Limonciello, Mario
>> <Mario.Limonciello@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>
>> Cc: rafael.j.wysocki@intel.com; Chan, Benjamin (Koon Pan)
>> <Benjamin.Chan@amd.com>; Du, Bin <Bin.Du@amd.com>; Li, King
>> <King.Li@amd.com>
>> Subject: Re: [PATCH v1] drm/amdgpu: Fix ISP regression issue in kernel 
>> v7.0
>>
>>
>>
>> On 3/11/2026 1:26 AM, Mario Limonciello wrote:
>>>
>>>
>>> On 3/10/2026 5:52 PM, Nirujogi, Pratap wrote:
>>>>
>>>>
>>>> On 3/9/2026 5:58 PM, Mario Limonciello wrote:
>>>>>
>>>>>
>>>>> On 3/9/2026 4:50 PM, Pratap Nirujogi wrote:
>>>>>> Add NULL pointer checks for dev->type before accessing
>>>>>> dev->type->name in ISP genpd add/remove functions to
>>>>>> prevent kernel crashes. Also add MODULE_SOFTDEP to ensure ISP
>>>>>> driver dependencies are loaded in correct order.
>>>>>>
>>>>>> The regression was introduced in kernel v7.0 where MFD ISP device
>>>>>> enumeration doesn't complete by the time it is added to gendp. The
>>>>>> timing of ISP device enumeration has changed because of the changes
>>>>>> in registering the device sources in the device hierarchy.
>>>>>
>>>>> It's a little bit pedantic; but I /think/ there are two different
>>>>> problems here with two different root causes that both happened in
>>>>> 7.0-rc.
>>>>>
>>>>> As a consequence I think you should have this split out as two
>>>>> separate patches in a series linked to a Fixes tag with the reason
>>>>> for each of them.
>>>>>
>>>> Hi Mario,
>>>>
>>>> Few things to clarify before I split into 2 patches and submit v2.
>>>>
>>>> - Yes, you are correct, the changes in this patch are not directly
>>>> related to the Fixes tag 02c057ddefef mentioned. But since it has the
>>>> dependency on the below patch for automatic modprobe of isp to work,
>>>> I have used the same tag to cover the dependency. My apologies if
>>>> this approach is incorrect and misleading.
>>>>
>>>> https://lore.kernel.org/all/5986516.DvuYhMxLoT@rafael.j.wysocki/
>>>>
>>>> - NULL dereferencing issue with dev->type observed on v7.0 is
>>>> specific to this commit 057edc58aa5926d63840c7f30afe0953d3994fa3. As
>>>> the wakeup sources are registered using physical device instead of
>>>> ACPI device, wakeup source device (wakeup14) is added as the first
>>>> child of AMDGPU device; and since its dev->type is not initialized
>>>> properly it has resulted in segfault.
>>>
>>> Sure this makes sense and is a no brainer to get in.  I would just
>>> send this one right now and we can keep noodling on MODULE_SOFTDEP
>>> (more comments below).
>>>
>> thanks, I’ll go ahead and send this one out now and will submit the
>> MODULE_SOFTDEP change separately after the root cause is identified 
>> ( more
>> details below ).
>>
>>>>
>>>> In 6.19-rc4 or earlier versions, this issue was not observed as the
>>>> wakeup source device was never part of AMDGPU children list.
>>>>
>>>> For the changes in isp_v4_1_1.c, I will use Fixes tag 057edc58aa59 
>>>> in v2.
>>>>
>>>> - MODULE_SOFTDEP change in amdgpu_drv.c is needed for automatic
>>>> modprobe of isp (and other amdgpu mfd child devices) to work in v7.0.
>>>> But couldn't identify the specific commit in v7.0 that is causing the
>>>> issue. I can confirm it is not because of commit 057edc58aa59 as the
>>>> automatic modprobe doesn't work even on reverting this commit. Can I
>>>> submit this as the fix needed for isp probe to work in v7.0 without
>>>> the fixes tag?
>>>>
>>>
>>> MODULE_SOFTDEP is generally for ordering, but I don't think you have
>>> an issue with those modules loading before amdgpu do you?  I'm not
>>> really following why the modaliases stopped working and I'm a bit
>>> worried that it's papering over a more nuanced issue still.
>>>
>> yes, this explicit load‑order dependency was not required earlier. I 
>> agree that
>> the regression point is not clearly identified. I will identify the 
>> bisected commit
>> and submit the patch later.
>>
>>> To identify the root cause, it might be helpful to do a bisect,
>>> although it's a bit complicated.
>>> 1) At any point that has that platform driver conversion you need to
>>> either revert or add the change to auxillary
>>> 2) At any point that has 057edc58aa5926d63840c7f30afe0953d3994fa3 you
>>> need to apply the NULL pointer derf fix
>>> 3) At any point that has the changes in linux-media for API
>>> adjustments in 7.0 you'll need to pick what version of ISP series to 
>>> apply.
>>>
>> I tried #1, #2 and few other combinations, but none of them helped. I 
>> will
>> investigate further to identify the commit causing the issue.
>>>
>>>> Thanks,
>>>> Pratap
>>>>
>>>>>>
>>>>>> Co-developed-by: Bin Du <Bin.Du@amd.com>
>>>>>> Fixes: 02c057ddefef ("ACPI: video: Convert the driver to a platform
>>>>>> one")
>>>>>> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>>>>>>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 4 ++--
>>>>>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/
>>>>>> drm/amd/amdgpu/amdgpu_drv.c index 95d26f086d545..920595f0d22ca
>>>>>> 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> @@ -3212,3 +3212,4 @@ module_exit(amdgpu_exit);
>>>>>>   MODULE_AUTHOR(DRIVER_AUTHOR);
>>>>>>   MODULE_DESCRIPTION(DRIVER_DESC);
>>>>>>   MODULE_LICENSE("GPL and additional rights");
>>>>>> +MODULE_SOFTDEP("post: amd_isp4_capture i2c-designware-amdisp
>>>>>> pinctrl- amdisp");
>>>>>> \ No newline at end of file
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/
>>>>>> drm/amd/amdgpu/isp_v4_1_1.c index b3590b33cab9e..485ecdec96184
>>>>>> 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
>>>>>> @@ -129,7 +129,7 @@ static int isp_genpd_add_device(struct device
>>>>>> *dev, void *data)
>>>>>>       if (!pdev)
>>>>>>           return -EINVAL;
>>>>>> -    if (!dev->type->name) {
>>>>>> +    if (!dev->type || !dev->type->name) {
>>>>>>           drm_dbg(&adev->ddev, "Invalid device type to add\n");
>>>>>>           goto exit;
>>>>>>       }
>>>>>> @@ -165,7 +165,7 @@ static int isp_genpd_remove_device(struct
>>>>>> device *dev, void *data)
>>>>>>       if (!pdev)
>>>>>>           return -EINVAL;
>>>>>> -    if (!dev->type->name) {
>>>>>> +    if (!dev->type || !dev->type->name) {
>>>>>>           drm_dbg(&adev->ddev, "Invalid device type to remove\n");
>>>>>>           goto exit;
>>>>>>       }
>>>>>
>>>>>
>>>>
>>>
> 
> Regards,
> Bin

