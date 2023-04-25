Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE698C77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 11:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80A9E10E230;
	Tue, 25 Apr 2023 11:24:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF65610E27D
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 11:24:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbaZWpwKiGXowxQ3a3uFEmPl9YZw/OWdJndOuIAgnPPh3nvlhP/QgxFQKja+rBhJ+16t04ByMwC7WjX0pXXdu4bGE5iMMHuRR6xr5GIiGjyHXkex5CdeuFmmes6pcnaobvZ/JxKxKnasQhEqEiBRSDOldtIcPr8Ydweqo5LCPIn9OUXPWtOaFhiAFkkLiFn273I8Zp22q/NhEssBy/uNjLj4Oyq16F5fCwsLdYUr3plBnNOL3BV9K0+GadurdWprQAUErtjpA4mSNoL7Ql4eeFa0d4D3b2jCG/JX6E+lt/QCP+vP4gu0oAp4/jEZz9kWW5XdFq2cdWq+MuIG9qGugg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLb55ChEYYQ15tuStffZY91gODrHbELNKgrJL2i2Sz0=;
 b=IKKFZ8xrt7jnQ9HvzxlfEApDyCeP3kuO2cpci59P4gnLjTZNh1FrEzdv02Rz6lMRzn1D+NTnnBJNWbZ43evG3YXI4LhEUYd9RlkOmWsmSrI7uhkJ4G7+Uh+jIRaXChhoC/RUm1YoS7wPp2MYSELUSGMmXx5nzo/5YqkdNmdEV8TtO6NdKOPty41zIXedUn1bxZNwlt458tIMzwHXKlAEBG+6fVRtwJil2d9kmV5IzaLP15ma/ZWSMq8KQi3nwgROWmIWb7SkPe/+C37AP2bKB6OcNhHb8vi1zQgIcl5h1U7LaSipIOzUPa9MIs4goDn0xVqRPd+Qv2+fKw0ZMp/ZLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLb55ChEYYQ15tuStffZY91gODrHbELNKgrJL2i2Sz0=;
 b=11udgpSEe9yDUjW7Huc3jea4fgdQetfFgmvI0vv5+hk5/r09b3lZZov6zo/s6Pk87g3l6T5gv6w8z2k+3sIZHodyUJ5mEWM9qqzOBQjV4n0dyjN/wOVhRLa/h9XLMrCiakjZEv37sfbNgZViOWnU+RRLlBaPk9wweiKtOzFldDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN6PR12MB8566.namprd12.prod.outlook.com (2603:10b6:208:47c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 11:24:09 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 11:24:09 +0000
Message-ID: <8bc39831-79ee-36b4-0951-d665a93428b9@amd.com>
Date: Tue, 25 Apr 2023 13:24:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: Enable doorbell selfring after resize FB BAR
Content-Language: en-US
To: Shane Xiao <shane.xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, felix.kuehling@amd.com, hawking.zhang@amd.com
References: <20230425101613.1277792-1-shane.xiao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230425101613.1277792-1-shane.xiao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN6PR12MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 1332e736-4202-42dd-1046-08db457f965c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spD2tStUEsTs7wy6zJtxP9JESOK9AWDBrEgTeJ6TqSx+4dqn49RZ87l41Ni20ThsooAtBYQ5qy8H3cwhj/43RpOInxnEhmzeGwhf0ahBqMlGlgkGv5kIrr44v8kE6Ek9H72E3Xr90RzT9Eo1ltGiKAP6iHNiNcP/sOXchzHAre0+eqpZS96Jv48i0ZdgLGaz6dVyAOavC+hgagKQCxqSl+nRpVIJ/J03ZKoITEZMRJWdl487bgeCEi2aAVBIlKbz1o0WKjlvUfk+rsp8BnQEAK0RopltWrag0PIrpvO/9mjx1xR16Aaf4Nuo3wOcAsQPckXaKRA8GUyJDEE6ah8/TlHLB+chihkhdvTYaIVoxGyWzf2kOqOKJOnKQtmbM8cspyqXhWmrYA+rOARxSTMwHDRjJsZ9NOgVLBTWh0zeqrB142MRN8r6zbrrH8/U4WA+Pj7XCmdsMhiTPLfpN0H426QB5IWL+P7BrGiz3m7/Vna5pwCnWYTpnrnniBO9+SluUpgDlctzUfUc4tp03NN/IKqRKbobIaURAe6v04aB9TMUOgPMNz4OZLtni9zAY6siA2IcZFwu/mDcXNozl9slJnjMy4ci32UOHLk6kOXbiVjKx5CTgM+5U9qMGfiOWu9O5qvsoUiup55rKLA43UiJCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199021)(36756003)(8676002)(8936002)(54906003)(478600001)(66476007)(66556008)(6636002)(66946007)(4326008)(316002)(41300700001)(2906002)(38100700002)(5660300002)(2616005)(86362001)(186003)(31686004)(6506007)(6512007)(31696002)(6486002)(6666004)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmlNYkpqY1ZMcHZIK1ZjeCt1d2c1L0xZdEx5Z25HZDNIWld3OVFwMFgrakUr?=
 =?utf-8?B?RXZ6WGwwNDRYa3RqQWxvaEZ0bUlIZVU5eGt1enJiR1VyVTdIdlV6dFhVVEdK?=
 =?utf-8?B?RFpJWjB5dndsOE1ZZkxDSGU4em9Uc2xFUDBwSlgxNkxEYXUyaTcvVi9IbmdR?=
 =?utf-8?B?ZzUrR2lNajBBV1ovOThOTTVKSE9sMUtSMVVScmJsWklHVzJCUHBERExvQ3Ur?=
 =?utf-8?B?UXNodjUyR3o5VUxTZnRHUGpaYmtqNHJFQit5VUw5bm9kanNLclhFcjVHbnVB?=
 =?utf-8?B?WXpZUCtjY1hac2RnRnllUmlzSmFxZ0xUWXlJYzgxTGsyQVo1WGtBeHdxZUdp?=
 =?utf-8?B?NThZaVdKUVdIeDFDNzFoNk9MSG9qS0ZnTzUzWGMyNTNwMzRpb3g1L3pMRVBW?=
 =?utf-8?B?YWtGYVNOSnVvK2JmTkUyckpaZm51LzlJZzRXaG1VQTVJeW9KR3lTN3Jwcmx5?=
 =?utf-8?B?NWtEOEdiMHBYT01La0JQd2xDY3N6d2dka0tZc0xBZjhwRDdpSm9IQ3N6Qkxv?=
 =?utf-8?B?K2pkZmQ1Mis4d0M4Y1FGajZ1aHU3Ukt4LzF2My9CTVZ0WCtpNU1VNFUxWFNM?=
 =?utf-8?B?UGFOZFRIQkx5QUlDYUVKZGF6WTRHdUR5bzJLQnAySis0V1lKbUcrbi9QMmpj?=
 =?utf-8?B?K1VORVRKQ0tsbmQ5d2Y1OHp6amNMbFBxMlV2djFKZDkrcUNtYTBGN3RRUmJI?=
 =?utf-8?B?T1ErbFRrMk5zR0tmcHFhUlNvZWdxT2t4cE5KejZWbDhab2EyMEJWUnlvTmJn?=
 =?utf-8?B?ZzEzbWtTSWFGTVFYL2U4S1NYalVtcEUwZ2Q2OTBBNnNFT0NFdThQUHovLzdy?=
 =?utf-8?B?WmIzNVNPT0RNS3BtM3I4MjdsT2lOalFab05vY01CakdseXFydm4weko4MjA4?=
 =?utf-8?B?TkVYdnpKV2w0cE1BeDJDQml2eFlBcTk3ZjlZWktlTDdoMHhZc3VVVjZvb1ZS?=
 =?utf-8?B?ME1UVXVzYy9IZWFPQjBPcVh6VkhjbmNwRk93ZkNkTmwwUDRsbnZReUtEMTNO?=
 =?utf-8?B?NzBBLy9UVVE2LzI1RGZNbTJxaDRyMHpjR2d5emROOGF1OHkzTnYwRHdzQ0Vy?=
 =?utf-8?B?b1EyTVVvSmJOVVBqY3FwLzN5Q3NtaU5MUDdEbzRTL3JRWGFETklMaVlRYjNM?=
 =?utf-8?B?OHZwWjMrZjRRSjBHdGhsK2MzQlRWb09YODUwUXZDaU02dlpxdWFKSjN4STU4?=
 =?utf-8?B?R0lzUFlWMGxMazhjRGQ1NEFEc2s0aXAxZzN1ZzF0aWQwdDBoTHBBMVdIamtX?=
 =?utf-8?B?Tlg5d2JOTG50bFJMd0xOQzBwOWZEOExYUVhrVkczTU82OEZPQmpPNUppMVhW?=
 =?utf-8?B?V1B4Wmg3ck5DZnZ1ZlQwWGVSakM4Y0d5cXhXei9wMG5sUDJsRjhWd3hMQURk?=
 =?utf-8?B?L1FzckpKendKSUlCZGoyK3ByTllwZzBwdml6NCtHT1VBT1MyWUIxVUNXTXQx?=
 =?utf-8?B?VThRTTlMYWhoUEJNVzM0bGRKUEk3TGxpL0dzMml3clcxRmRyaGxDY1ZwQWhp?=
 =?utf-8?B?emN6Lzk3QmlZMGlhR0c4M0c4QTZVeWpZRVlZUXhNRFdZdTlReFVLMnJ2S2Zy?=
 =?utf-8?B?dEsvclhrMlBsU0VHUDBabEcxQ3NmaGpyV3VLVWVIVzMrNjVnZHRSbExwakdm?=
 =?utf-8?B?dE5zbXAzOVkrR0lvaDJldDRzbU0wUmRTUTdPbExobVR3R1J0ZkdHTlN6eUg5?=
 =?utf-8?B?dU5VWDlhT1JWR0YxcldWWnM3aGYzVWZIeWNnWmxWUWpXUDhrL1Yvd0czMkh0?=
 =?utf-8?B?b2hYZ25LOWt3ZVlId2ViTWtoS2g5dFA3b2t0OVdwbmZHa0RvdFR0L2g2Uk1i?=
 =?utf-8?B?U0poOGpYSzgya1M0d2lRazVSangrdEZVNXppNHdMNmlGeWVVNTJvNGxrQmxu?=
 =?utf-8?B?VW1OdTBoaThQbzNZRFcyanNoN241MTMyc0JsOEYrcmo5SDlsMStmOFpVVlFr?=
 =?utf-8?B?Z2V0UzBzblNnVjJGaUJ2S2l4OS9Zd3VxV0ZyRy94V3kzT3B4Z2tCK1h2NFJP?=
 =?utf-8?B?Mm1DRzJSaVdraXpBeHNlZ1lUOGd6UzZoUnJhZzc3dFhFTlhERW5vaFNDRFls?=
 =?utf-8?B?dDhTZkZwanQwazZyajZqOVhMTnc4UnprczcwSlVkRlJCTUxoMmlwdGVBTGJ5?=
 =?utf-8?B?dW5obzZwZHoxQUVIWUEwQzF3bkhVamU3bGV3dzcxaHBuQW5xdWhGUkptYzZL?=
 =?utf-8?Q?C7eMZJgvXX2EB69GOQOk0z41oPWsI/YbfSFpUMga3Fcj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1332e736-4202-42dd-1046-08db457f965c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 11:24:09.0051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLbI6OYvepiR/heZcTtBNkhq93+1JSq5QOT88uCvjfYEusZBgOAx6M672QGYk1Z+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8566
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
Cc: Xiaomeng Hou <Xiaomeng.Hou@amd.com>, Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.04.23 um 12:16 schrieb Shane Xiao:
> [Why]
> The selfring doorbell aperture will change when resize FB
> BAR successfully during gmc sw init, we should reorder
> the sequence of enabling doorbell selfring aperture.
>
> [How]
> Move enable_doorbell_selfring_aperture from *_common_hw_init
> to *_common_late_init.
>
> This fixes the potential issue that GPU ring its own
> doorbell when this device is in translated mode when
> iommu is on.
>
> v2:
>    1. Remove *_enable_doorbell_aperture functions
>
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>
> Tested-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/nv.c    | 17 +++++++----------
>   drivers/gpu/drm/amd/amdgpu/soc15.c | 19 +++++++++----------
>   drivers/gpu/drm/amd/amdgpu/soc21.c | 17 +++++++----------
>   3 files changed, 23 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index dabeeab2f2ad..cb39d556c23d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -531,13 +531,6 @@ static void nv_program_aspm(struct amdgpu_device *adev)
>   
>   }
>   
> -static void nv_enable_doorbell_aperture(struct amdgpu_device *adev,
> -					bool enable)
> -{
> -	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
> -	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
> -}
> -
>   const struct amdgpu_ip_block_version nv_common_ip_block =
>   {
>   	.type = AMD_IP_BLOCK_TYPE_COMMON,
> @@ -999,6 +992,9 @@ static int nv_common_late_init(void *handle)
>   		}
>   	}
>   
> +	/* enable selfring doorbell aperture */

Documenting *what* you do is usually a bad idea since that should be 
obvious. You need to document *why* you do it.

In other words maybe change the comment to /* Enable this late because 
doorbell BAR location can change during hw_init */.

> +	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
> +
>   	return 0;
>   }
>   
> @@ -1038,7 +1034,7 @@ static int nv_common_hw_init(void *handle)
>   	if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
>   		adev->nbio.funcs->remap_hdp_registers(adev);
>   	/* enable the doorbell aperture */
> -	nv_enable_doorbell_aperture(adev, true);
> +	adev->nbio.funcs->enable_doorbell_aperture(adev, true);
>   
>   	return 0;
>   }
> @@ -1047,8 +1043,9 @@ static int nv_common_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	/* disable the doorbell aperture */
> -	nv_enable_doorbell_aperture(adev, false);
> +	/* disable the doorbell aperture and selfring doorbell aperture*/

Same here and all other places as well.

Apart from that looks good to me,
Christian.

> +	adev->nbio.funcs->enable_doorbell_aperture(adev, false);
> +	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 4d1487a9836c..2db021f6e8ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -619,13 +619,6 @@ static void soc15_program_aspm(struct amdgpu_device *adev)
>   		adev->nbio.funcs->program_aspm(adev);
>   }
>   
> -static void soc15_enable_doorbell_aperture(struct amdgpu_device *adev,
> -					   bool enable)
> -{
> -	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
> -	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
> -}
> -
>   const struct amdgpu_ip_block_version vega10_common_ip_block =
>   {
>   	.type = AMD_IP_BLOCK_TYPE_COMMON,
> @@ -1125,6 +1118,9 @@ static int soc15_common_late_init(void *handle)
>   	if (amdgpu_sriov_vf(adev))
>   		xgpu_ai_mailbox_get_irq(adev);
>   
> +	/* enable selfring doorbell aperture */
> +	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
> +
>   	return 0;
>   }
>   
> @@ -1182,7 +1178,8 @@ static int soc15_common_hw_init(void *handle)
>   		adev->nbio.funcs->remap_hdp_registers(adev);
>   
>   	/* enable the doorbell aperture */
> -	soc15_enable_doorbell_aperture(adev, true);
> +	adev->nbio.funcs->enable_doorbell_aperture(adev, true);
> +
>   	/* HW doorbell routing policy: doorbell writing not
>   	 * in SDMA/IH/MM/ACV range will be routed to CP. So
>   	 * we need to init SDMA doorbell range prior
> @@ -1198,8 +1195,10 @@ static int soc15_common_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	/* disable the doorbell aperture */
> -	soc15_enable_doorbell_aperture(adev, false);
> +	/* disable the doorbell aperture and selfring doorbell aperture */
> +	adev->nbio.funcs->enable_doorbell_aperture(adev, false);
> +	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
> +
>   	if (amdgpu_sriov_vf(adev))
>   		xgpu_ai_mailbox_put_irq(adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 7d59303ca2f9..21d11b7c510e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -450,13 +450,6 @@ static void soc21_program_aspm(struct amdgpu_device *adev)
>   		adev->nbio.funcs->program_aspm(adev);
>   }
>   
> -static void soc21_enable_doorbell_aperture(struct amdgpu_device *adev,
> -					bool enable)
> -{
> -	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
> -	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
> -}
> -
>   const struct amdgpu_ip_block_version soc21_common_ip_block =
>   {
>   	.type = AMD_IP_BLOCK_TYPE_COMMON,
> @@ -764,6 +757,9 @@ static int soc21_common_late_init(void *handle)
>   			amdgpu_irq_get(adev, &adev->nbio.ras_err_event_athub_irq, 0);
>   	}
>   
> +	/* enable selfring doorbell aperture */
> +	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
> +
>   	return 0;
>   }
>   
> @@ -797,7 +793,7 @@ static int soc21_common_hw_init(void *handle)
>   	if (adev->nbio.funcs->remap_hdp_registers)
>   		adev->nbio.funcs->remap_hdp_registers(adev);
>   	/* enable the doorbell aperture */
> -	soc21_enable_doorbell_aperture(adev, true);
> +	adev->nbio.funcs->enable_doorbell_aperture(adev, true);
>   
>   	return 0;
>   }
> @@ -806,8 +802,9 @@ static int soc21_common_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	/* disable the doorbell aperture */
> -	soc21_enable_doorbell_aperture(adev, false);
> +	/* disable the doorbell aperture and selfring doorbell aperture */
> +	adev->nbio.funcs->enable_doorbell_aperture(adev, false);
> +	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, false);
>   
>   	if (amdgpu_sriov_vf(adev)) {
>   		xgpu_nv_mailbox_put_irq(adev);

