Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2B6C6FA83
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 09:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF95710E34D;
	Tue, 27 Sep 2022 09:36:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5968510E34D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 09:36:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zgy+vlWEwYhtn1FdxtmiM3KW2/PNKWXJuBp4hQvAavO+Z2T+3J5W/hzaSiLa9bgOnoGEvshSRuYB7dohAwGNQWIDtC3k+hjczU1WVu2EKq0737Lag+No8PS3srTuBdov76kgZAeVS4ApMhgvqMnQ68jdUAsC8JypbSadIHnxw6zRtzbOHBENYqr3kK69QqBM3ekfdshAwLj+NEmZPR8kP2fpqFNoe24pHl2+hcopSKSVz67JeNIHOn0ilmZVfgUxdX3uM5f9yiYdSt3OGX0JX/pkeBWnDUlifE8P/RXyCJ4oYZqTGOQPBF1u8pT5gCQZPSmA+Ph7JgnLP0kovatrGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKqNvLgeeFtYCBwkd7EUvQb+Ssoxa9f5sQtiDehF4DM=;
 b=IMazpB2ThLad/1AOqL2azu4iqnjoJ7/lz3dfW+tMWJW9IPVtug5XDDgCT6BH+QGv0wZFp/QECqBHngj5yii/sUnVXnKkP79V6iTiDm4WuRTf1RptvnxOFYvrOYF2dTqhIQnZIBPL2OMvchQPwB++00fwbDFu13ZzXSaCOjF8u05HjS6EFSRpuv0TOs65S6e9R6JZsLeGibdLpqbXRIs0MpfebOf7MrRDta7Iwp+W5mfc9UHJ+kpaJeMT2jAOsGZjAW+yu9NOjOvBNiwhmwfktsGHNeohe+Vr4M0hXsZFIv+eH12krZcgY4cYZz2f9vdWqPqkTExNzC8fR5935Q9DsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKqNvLgeeFtYCBwkd7EUvQb+Ssoxa9f5sQtiDehF4DM=;
 b=SPbKaHjuABMZ2EYu4FSA8qlfhY8ZiamG3FamJasz9C+TSWHU6/OTAv7NMFJOp5hRUc9UWRljAxE9kNziBnNv3AJ4fCrI4W0bCEbSyLNppHIqN8wiDGsWmrImwbYg2NUPctdpEy2k+J0qMIs/+6PRCUzLm3G1skDP7GZ72HnDXc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Tue, 27 Sep
 2022 09:36:45 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::1f2e:c1d1:efd4:f918%4]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 09:36:45 +0000
Message-ID: <d35da3ea-7de1-84b6-970a-6d6e795a249b@amd.com>
Date: Tue, 27 Sep 2022 15:06:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu: add VCN poison consumption handler for SRIOV
Content-Language: en-US
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, stanley.yang@amd.com, monk.liu@amd.com,
 Victor.Skvortsov@amd.com, haijun.chang@amd.com, Vignesh.Chander@amd.com
References: <20220927073522.5102-1-tao.zhou1@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220927073522.5102-1-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::31) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DS7PR12MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: a4eaf0e8-49f7-4e02-cf59-08daa06bcab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 173yfdDDP4U9MI1+LrxYJ1YfWL6TDl24RCEkfyAVsGqFD2tLMiwGyNFLaKHa/BKqC0OtQB3/hMkwY5/YZz2MRv68IThyIC+yAaJoGpveSPQiWofe8XzXVKuDL9zXV7soLywIuDwOWdRkDjpTu2BvJi9wMeIYvOp3z9uvmLAhXUWysVL0oqYDSuzcMBL9GmgQ7X15nE3Mn1WAdIGWueBKQeiV8K0To6dU+j+e3SKidiR/L6+3SFnLKq9bk3fQa9AnxDMEY0MFiRAzukaVoYaMCVZtqnqsSb3Rq9RNVZDqSvpczVeZOzbUWKTezmMUmw1sGwQ1CwlHLzPOZyH63f03NvmzJXE8d7XVrWG7V4SAjAINJTx+/5ov02z9l89RaeDJ/uslxdf8ZJTAdpNrboCGHkkwKlLXnQFh/RYp2TMa/l/ASd9Q17MQVN/onjcRtT/gMG0sTwcOLiQ9Uf/xSFR858Vh7rw++apVrjmLtJc9AV77XyQ22mb6zEu3wLJNbYW9ThyT6/MC5BjddVQmXUYWGavIDPCKw1NnCV+e/A0KuOuiNGhkSUdBP2i+yCEQQHfodOvU9ILt4b1ZgGJL9ROFnQEsZPNk3CoCGgPDaeaAU2Kd7g+y7TdHKIIvu+Qa4hKv8ITaInBJfFldU1G4CRNzkFKxLu0+A7PFElbwUeBOrOhDpWAsC73271caTbyIa4IfgtMAl2P1rwZ+UNGJeUwxt47EjtxOBV4q3ObUcIYNr+Pc1GB1nr9CPtGCOh4uizcUq0GXhaXzKnSv6ZpiTVt61XPxIjcl62dpAniKAH9zTjY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199015)(31686004)(2906002)(8676002)(66476007)(66556008)(38100700002)(41300700001)(478600001)(6636002)(66946007)(316002)(6486002)(8936002)(5660300002)(36756003)(31696002)(86362001)(6506007)(6666004)(53546011)(2616005)(186003)(83380400001)(26005)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkZXRzhrQ3ZmbHdaY0lCZWNsMnhpVmsvSGtUV2cvUEtsT2tyV1NYQUlITnNH?=
 =?utf-8?B?RHAxQmJFaWdzSDl0YWVjYVo5UnIxNDlxdUJ2a1FHamZkNGloaWVGQjJGU01u?=
 =?utf-8?B?dEkwcDNFVW82NGloQlVZc0VVOStBSjhnTW9iRWlER1B5RWJvOWcrMEk0VS9L?=
 =?utf-8?B?RTc2M1kvY2lWWldncmJ0aU5naXhvazRkb1haN1BvK1RNTm5wcVZFaHo0RG1l?=
 =?utf-8?B?aE0vYTB2dldjV0R6NUlhUTMwUjBHUDdhSDZCbkROQXp3UGEvZnk2K0NPelVS?=
 =?utf-8?B?WXdMbWdSMEZicmxLTXFCRktUQzJjWTRzaHFwSm9DNXRFczVZOWhSMmNCS1F4?=
 =?utf-8?B?M1BzSlpyWGk3eWFHdmlRcThqWWU4Zmx3WUlySzJBZGVEUXBwSm9KSkowZ0pr?=
 =?utf-8?B?MHZocHRWd0NjOGJ1K3RuWXJyVFFKWG9ZS3hUZnZBTVlTdUJsd0xXREZyTmpt?=
 =?utf-8?B?OE11Mjh1TFZsVDFOUzBYVzFTbHVjL1RBb2s5cGYrRTB4YjVQT2lxakY0cVdp?=
 =?utf-8?B?UHFLNWtyNWF2bXQyT3pWWElmQzdHei9xOWYxTHdYd2IxRDgxd0RCcCtvUXVo?=
 =?utf-8?B?bTdjWTgvNlpMeWE0VDdBSXJFR0M2OS9WdW5rUFkwU3lFMHRqeksxajgxZ0RD?=
 =?utf-8?B?VG03MURtdUJoTFA0dmxsaXZncnN3ZFFNNDZRa3o5YkE2WnFYWk82RXIxVDZt?=
 =?utf-8?B?WGlRaDQyNGlvcmI3K1V1SGZmSXhLRDF2ekxHbFJKeXo5VGtBVGdPNU5WNW1T?=
 =?utf-8?B?K3ViRGhmN0F4UitMbDRLakN3eDVBUnQ1VXZjUit6YWYreEIvTU5lNXgwMlh1?=
 =?utf-8?B?U1NSaGgxeTdUNmJHY0JUYTB3ZmM1TXVoVFpFSDAzZEpadytBd2NWNStZUmtW?=
 =?utf-8?B?T2o1VFI2WGpKaVJIZjlVaTBYRWQ1TExpQTJvMlJaUWVCSkovWXZod3QzTW8z?=
 =?utf-8?B?bEFqOS9CejN0eThrNWRDcWdXV1NnUW1jd0J1RUxZWktqV3R4MHhxNE5MM01D?=
 =?utf-8?B?RnYyejMrN2JsejlVdWltUmFqMFRCekIybVlJMUtidXhvc1UwMU9rUTM1QzU5?=
 =?utf-8?B?aHpzOGc4RlpYQnJ4SkY0a3Z4NmlxdnF2WXJIVTRVTmk3WnFpUWdzT3JZZ1ZL?=
 =?utf-8?B?K0tvRHFrVWxLaEdRTTdkazE5U3RyL0NHQVlCV05qbGFYczB1VkZHa2orZmFm?=
 =?utf-8?B?Zm1iYUZMcElKZFo3U0l2QTU2RGd5T2crSURJVTRFVloxK1RqZHRaWWZkRVZ3?=
 =?utf-8?B?b3QvWnNFRzVDa1RQNjFVd3ZrNy9HWFEzd3UyaDNpZlZGTnVaWGQrSVE3Vm8z?=
 =?utf-8?B?VlNpbitqYXdtNHJ5SEtPUlA3Y3NZSUhBWHByckxVS0ZVSVhtZC9Gb1BOSisx?=
 =?utf-8?B?VkNEemNOYXlaM0VnYzJKQllUVVFyNmFBeDJhN012UjlyQ0JnZXdaN3dBUjht?=
 =?utf-8?B?U0s3UVBnUnBtc0tvK0g2QUdPOEJqYmNzZHBhTFovc2R1MUdxbUU0UDNnY2Vi?=
 =?utf-8?B?TTlMSTQ1dEJTMjNzVlB2dTArN090Nit4QmZWL1ZGSTV0VE04MmFvbE1HMDRy?=
 =?utf-8?B?S1hRQ3JOWm5CdU1HWDYvZHlNTkQySW9UQkZkQXVUNlhzRk9oU000YUhMK0ZQ?=
 =?utf-8?B?MXJCNFUwM0pqU2xBU25HeTNBQnN4aGp0OVhvbG5ST3V5YmxzblR1T3BrNm1Y?=
 =?utf-8?B?b1JLTThkc2FQK0pFR3loT29oRE5BWFJLbEVLaG1CaDVsRTdtOUdUekQ2VUxH?=
 =?utf-8?B?d3NNOUZFcG05eGtNUWJrYmtFRXpxQ3VoZ2IrbHh6enZxYUV4L2xUWU1SWXdr?=
 =?utf-8?B?QWVQNW44NzdJU2dPaHQ3cXRNb29ROE5IK1NhQXFKbk10VzBrRXBNS3pFYzVZ?=
 =?utf-8?B?MmUybDkvek9mR2tLUGFQdm5CS1VXVTZ0NGNQMW5EelJZeHYvUFkrTlhTTkUz?=
 =?utf-8?B?QnQ2WVErL0tLdzVDbStyRWFhNVF5UlZpTm9JZkVIRGZVdnpWVnpSa0h2NThS?=
 =?utf-8?B?ZDQ4aHJPbXl0NFc5RGpveUE3SzI4VHJ5ckVFc3c1b0FtYkh1TE9vZlV6dkx2?=
 =?utf-8?B?anNYdE95OHJ3WWdBR3l1SnY5eE5DYmpCOXNQdGIxSjVuVEZUV2lZbUpDZVY1?=
 =?utf-8?Q?nlA9jbg3uThI5SFGhz5jVRjzL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4eaf0e8-49f7-4e02-cf59-08daa06bcab5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 09:36:45.4203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRBK+KeIimhj8R9QmxU/9yKNvdVqCgq4uRft8OzTa7qCC34RRtpG3zyw4Z2UfGJs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888
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



On 9/27/2022 1:05 PM, Tao Zhou wrote:
> Inform host and let host handle consumption interrupt.
> 
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index f36e4f08db6d..cb2885999219 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1243,8 +1243,16 @@ int amdgpu_vcn_process_poison_irq(struct amdgpu_device *adev,
>   	if (!ras_if)
>   		return 0;
>   
> -	ih_data.head = *ras_if;
> -	amdgpu_ras_interrupt_dispatch(adev, &ih_data);
> +	if (!amdgpu_sriov_vf(adev)) {
> +		ih_data.head = *ras_if;
> +		amdgpu_ras_interrupt_dispatch(adev, &ih_data);
> +	} else {
> +		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
> +			adev->virt.ops->ras_poison_handler(adev);
> +		else
> +			dev_warn(adev->dev,
> +				"No ras_poison_handler interface in SRIOV for VCN!\n");
> +	}
>   

As guest is not a trusted domain, I guess we need to get more clarity 
about the final flow of events. Need to hold this.

Thanks,
Lijo

>   	return 0;
>   }
> 
