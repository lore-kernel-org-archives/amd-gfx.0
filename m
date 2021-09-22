Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A1BC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 07:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C434610A1
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 07:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C434610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D8316EABC;
	Wed, 22 Sep 2021 07:37:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEEF16EABC
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 07:37:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ld+k6OcqsfDpfcPyZROTS+f00Lkly+Vy0azmry/oV8yMLZMwG71gOinf/iG9LR26o23ReWMSgvw4AGdDiLXzwHmiYaZG5Ub4Zv+BTPiXqPZpHEjuGJq3SmRa3sgJGikCXRQLDBGUu9KyYHZDTa9PnXlG3fNI/t4m2Gk4Y86SnasbQqK88fJcxXnQSQM7YC4dFnWuvbL4URmvUPy1kwPzKBZPp8N1hn84hPhXZbzs0fGD44Wa2LsFM3TIjJttq6UERDbBg5gaXA5pEpOcSU9dkgXR8NO/rhtgEY8/6FgvMpDjP78cyrYPNWziPCVmzzFuV6vSOoBCwvsWUUb0TypZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=eYTsZhFmiC6bjOya6QKah0jHZXR3/aFCOxefwQBYH+w=;
 b=FxpKsDSNUZFCoBCVPxg3Q534X1GWVKvk0ohiZWRalgSUrIjsTaTZAa8SG+WZIozx6b1ytRYG5q14UIQe5354qurpgzOQV62EXhJkJnrbuNTm1UueoLs7mn+qknWPgs+Drz7M6q+VVl/ab/a8643OYSzJD0De9Vfj+sJpbHrSmQxWf67lNeYKG0Txe7x02ufTy3Cm5+VQ8fQoFTcEEvlHhJmgjdBKYLHeKDJbMIIP5owhCHDPPzlkrFXv2C7f/StUiRUKqHeJfbfppsSlO7gxt7q84kJ5+WBXq6c7fdZBdEiXj6mu8eVL6X6WgO2kAWbmVgT78VehclMpN88kzMy5bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYTsZhFmiC6bjOya6QKah0jHZXR3/aFCOxefwQBYH+w=;
 b=WN480ccicXaG5OwWZ5zLVi/7Ehv0gmSukwatE6JJMQHt2vBNhwHjiapxgSp99Q/uxUK2YjhmIcddK50Rotqhg6bX9YJiTB/GJ+KpJpZs3byMIO2M/CHaJLqaIXLqEAAdInjUDRzkw3hD+rY6URODz3IQS51bYHdHEdCvdSBrCwA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 07:37:15 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57%7]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 07:37:15 +0000
Subject: Re: [PATCH 29/66] drm/amdgpu/display/dm: convert to IP version
 checking
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-30-alexander.deucher@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <56f852d7-c2e6-5bf1-7516-d07bd4cbb84e@amd.com>
Date: Wed, 22 Sep 2021 13:07:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210921180725.1985552-30-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::31) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN1PR0101CA0045.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Wed, 22 Sep 2021 07:37:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 678aec9e-9cc4-4740-2b3f-08d97d9bcca9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18829CF0622CFBC7D9AE6AC597A29@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ghVCF/FjBOVvoUgydkgCxkO1bh0PkoubE6Pzgk/2j5Y+Pvpf9ijTKdr0gGM0dGdfm2yTKFdOb4sIkdzBiDcLbPp79+GR7H1Ayu4IjHuyLyl6C3PnazYQEJ6vf8Jx1mN4dOfsHSJ26gysOu550A6h4oxGBFo1Y3MYmrDNUF7sq4/s2ybSZRH2OvVx8/xqukGAZMg+BfPj28L+ht4pJj3szi7pcIOt8aIie0JVoPZeznVBSdBj6Y5BDVKarEanSGuCV/8emEFJXQvdzmL0TJgyEIUPHC1Gm7KzjqNMoTnVpzvm/OFvuZF8n32ia356tj64r+wDvo/royllfLCbRn0YZvkJyTu61sDPWAKivB9redgNZ6+5/9hXqmE5LbXMlSK1RCljIWdTOoFWOCIVYZGD3cvwSwjFrOW8/d5Z9bOCzfMYFInVUXimKcrms8/hCPLhQ57AUftp8RkcL7TMhXXgiIh6LT7/TlyMZYrSpQ2cTlpk+Yv7o/7mgbAwtvkUQjrz9YUiQNFYcchFbv5VRh05uTY6bQ+b3Qk47ByvBoAUA7aDL8gSOtPRMltqnl5SihlvuH2ML2BhrEGAoFVpDkH0Gl9pvHK0D64fSkNYqzdPw69xE7auifzqKAVIqdTLkLmCddyJY4m+fr5EyrVC2yfmLdU/ErXo5Z4aykinizu1GnjIjznoidBqqkzXFBIsUpcsZUBa82kc6Xn4mgfvgxe+LJLPeEn09F/54np1xBr/xVU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(30864003)(316002)(8676002)(16576012)(66476007)(53546011)(6666004)(38100700002)(66556008)(8936002)(186003)(2906002)(86362001)(36756003)(31686004)(6486002)(26005)(956004)(508600001)(31696002)(2616005)(66946007)(5660300002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OThnd3ZPTXA3VHllYm5rQjV0YnBkNG9Jc0NCQ2lwZmJnc2E5WHc0NGdydlc3?=
 =?utf-8?B?SnZsanhwRC9BNTBsVFdYNWVUL1RoU0gxMDlTRUFpZWQ5VFlBTmFkYXd1cHN0?=
 =?utf-8?B?WllRRzdjVVhzK3BRcUk5aFRrdjlnb2dsa1RHbE5NRUw4NDRJOE0ranBPWTFT?=
 =?utf-8?B?U0M4czFJblBONysvNVhmRUFhb01JV0ZXQ1NjS20ycTlzeHJYV1Z1UWNrMW9B?=
 =?utf-8?B?RDlIYkVtTEZlZTJ1M2xUNUFYcXRmc1pyRjljSUVsSnFCUG1HaDZFNWN4a1Nn?=
 =?utf-8?B?TXFlZmROb1hiQThaaFdGVmlYM0FDQjJSazBveHMxVE9xSWFqTkM4R05CU2lK?=
 =?utf-8?B?cEFXUjVIWnhpd1ZpM0JKbTh2Rm9HRXIraWgvcGlCY0tCRjlGU3VXRkZ2RUZa?=
 =?utf-8?B?RzI4MlNicFAyK3BsUGVseWNWU0M1YklGdjl2bEhiNjFjV29lR1BxUEczeE4z?=
 =?utf-8?B?cytqRDYvMS9GSTcreEdnV1M0cTQzZEl5V09HenRuSUJGWi9kR1ZYUysydFhx?=
 =?utf-8?B?MTNvbmNCc1NVR0xXaXhHTnVoaTNCTm0wc0pBNFgycHh3M25RQm1oSE13VGVa?=
 =?utf-8?B?d2RCSyttbnMyaGp5N1lRSGdXVFphNTJSTms3WFkxbXdya3J3YXFJRHprL2lZ?=
 =?utf-8?B?MWxhVUwzaG1BMVpNS25YUDZ3Yy9heEdtR3VBQ2o5TmxzS0N4TzduQ2YveHB0?=
 =?utf-8?B?TlhmaGpGblFCVWljYmdtYUhCV0xkVDZENitMRmJKUnoxK21WaU9GRmhzN3hO?=
 =?utf-8?B?dGJmNXZqbWNpdXk3cFUxWnk0ekdZN0RiS3VKekZBSGVGNkU0bG56Tm1TZzNB?=
 =?utf-8?B?eW5aYXMrMVhmR01majdtOWxZVjJyTG1xNXFyWUN5TXcrM2xicEc3MzR1WHZS?=
 =?utf-8?B?eUF6SXZ3TmtzRjE1UThnWjhBNUsvT2h1WTJsOUowRTdxL1ZrSldYMDdhZWtu?=
 =?utf-8?B?WGg0UllFWklaY0ZvdVdZQXFWcHlTV2ZCNTl6eW9IbXU3ZGk2ejhmb1Zxa0c5?=
 =?utf-8?B?c0RIRWhqTmYxOGo0TVdySGJUTlRHYUUvbVdJdnE5cVBvQUJpRWh2SndMcndo?=
 =?utf-8?B?TEZEdHNaY1Z5K0Z6L095dnVwTnBmYm90OW96eG16ZG9PdEovQmtVZkVLSWpB?=
 =?utf-8?B?UzR0cGpRam93MG1PeUMwcGNCZVVNZHhZeThVOHhVQTllSVh4NzFrVGUwZW5s?=
 =?utf-8?B?NUcyNVhUQnNHck5zdlJNc1lrcW5leGcySlB5TndQZDJMVnhaTDc3cnRFTFBm?=
 =?utf-8?B?Z0pibGlRWUJkcmhTQlphSFNKZ1p0c1hiWDRMWDhvWnQ5Smp1bEdSU05CU2Nx?=
 =?utf-8?B?ZEI0QXZXa0I2bmI5VHhSNFMxOVNFSmh6S2lzWFhEOTJnbE44T3VPQVdNajhz?=
 =?utf-8?B?cHpFbS9RYmlYa3dHQjNNUExoRVRhRC93VzhkcXhlK0dHZkJnWXlvT2xjdHVy?=
 =?utf-8?B?Qkt1L2cxWXNzNW1CUHhvbWNKM2ZNbnZyd2RiYnYyWUNkWjY0TXE0ajg0bWxD?=
 =?utf-8?B?RFlGa0RZVlp1QmIvTjF0YUE3MHdHSlJtSVJ1YjQvUkk2TnZpdk9CRm0wTk9Q?=
 =?utf-8?B?eUZmdEhIaEx1bjRzSEhuL3pMNUwraWFEc2xZMjg3RXZvVDJwVzA3UVBsZlAx?=
 =?utf-8?B?Z3NKNTRkRllBL3RsNGxGM0s1RWdqRUdCQnl2dHlaWUQ1Y2Z0UGRGckdodlFN?=
 =?utf-8?B?N3hQSEo4a1dkTmVpbUNtd3AvMCtkYXF2ZUVCNHdmQ1BxK2NkZ3R5S3VLNzYx?=
 =?utf-8?Q?uBKdGyhpTTNmF8FIc8s0wM7IRlQhiGT8hxY1AKz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678aec9e-9cc4-4740-2b3f-08d97d9bcca9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 07:37:15.7686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bB1aG2hkZWHxhfbdPuxIwfwd+kR4tOAVP2Btoq1AbTrTZNK25hf62kqQe2LBQPJA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
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



On 9/21/2021 11:36 PM, Alex Deucher wrote:
> Use IP versions rather than asic_type to differentiate
> IP version specific features.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 194 ++++++++++--------
>   1 file changed, 109 insertions(+), 85 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 07adac1a8c42..e189d72f08e9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1342,16 +1342,23 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   	case CHIP_CARRIZO:
>   	case CHIP_STONEY:
>   	case CHIP_RAVEN:
> -	case CHIP_RENOIR:
> -		init_data.flags.gpu_vm_support = true;
> -		if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
> -			init_data.flags.disable_dmcu = true;
> -		break;
> -	case CHIP_VANGOGH:
> -	case CHIP_YELLOW_CARP:
>   		init_data.flags.gpu_vm_support = true;
>   		break;
>   	default:
> +		switch (adev->ip_versions[DCE_HWIP]) {
> +		case IP_VERSION(2, 1, 0):
> +			init_data.flags.gpu_vm_support = true;
> +			if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
> +				init_data.flags.disable_dmcu = true;
> +			break;
> +		case IP_VERSION(3, 0, 1):
> +		case IP_VERSION(3, 1, 2):
> +		case IP_VERSION(3, 1, 3):
> +			init_data.flags.gpu_vm_support = true;
> +			break;
> +		default:
> +			break;
> +		}
>   		break;
>   	}
>   
> @@ -1442,7 +1449,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   #endif
>   
>   #ifdef CONFIG_DRM_AMD_DC_HDCP
> -	if (adev->dm.dc->caps.max_links > 0 && adev->asic_type >= CHIP_RAVEN) {
> +	if (adev->dm.dc->caps.max_links > 0 && adev->family >= AMDGPU_FAMILY_RV) {
>   		adev->dm.hdcp_workqueue = hdcp_create_workqueue(adev, &init_params.cp_psp, adev->dm.dc);
>   
>   		if (!adev->dm.hdcp_workqueue)
> @@ -1637,15 +1644,6 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
>   	case CHIP_VEGA10:
>   	case CHIP_VEGA12:
>   	case CHIP_VEGA20:
> -	case CHIP_NAVI10:
> -	case CHIP_NAVI14:
> -	case CHIP_RENOIR:
> -	case CHIP_SIENNA_CICHLID:
> -	case CHIP_NAVY_FLOUNDER:
> -	case CHIP_DIMGREY_CAVEFISH:
> -	case CHIP_BEIGE_GOBY:
> -	case CHIP_VANGOGH:
> -	case CHIP_YELLOW_CARP:
>   		return 0;
>   	case CHIP_NAVI12:
>   		fw_name_dmcu = FIRMWARE_NAVI12_DMCU;
> @@ -1659,6 +1657,20 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
>   			return 0;
>   		break;
>   	default:
> +		switch (adev->ip_versions[DCE_HWIP]) {
> +		case IP_VERSION(2, 0, 2):
> +		case IP_VERSION(2, 0, 0):
> +		case IP_VERSION(2, 1, 0):
> +		case IP_VERSION(3, 0, 0):
> +		case IP_VERSION(3, 0, 2):
> +		case IP_VERSION(3, 0, 3):
> +		case IP_VERSION(3, 0, 1):
> +		case IP_VERSION(3, 1, 2):
> +		case IP_VERSION(3, 1, 3):
> +			return 0;
> +		default:
> +			break;
> +		}
>   		DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
>   		return -EINVAL;
>   	}
> @@ -1737,34 +1749,36 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
>   	enum dmub_status status;
>   	int r;
>   
> -	switch (adev->asic_type) {
> -	case CHIP_RENOIR:
> +	switch (adev->ip_versions[DCE_HWIP]) {
> +	case IP_VERSION(2, 1, 0):
>   		dmub_asic = DMUB_ASIC_DCN21;
>   		fw_name_dmub = FIRMWARE_RENOIR_DMUB;
>   		if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
>   			fw_name_dmub = FIRMWARE_GREEN_SARDINE_DMUB;
>   		break;
> -	case CHIP_SIENNA_CICHLID:
> -		dmub_asic = DMUB_ASIC_DCN30;
> -		fw_name_dmub = FIRMWARE_SIENNA_CICHLID_DMUB;
> -		break;
> -	case CHIP_NAVY_FLOUNDER:
> -		dmub_asic = DMUB_ASIC_DCN30;
> -		fw_name_dmub = FIRMWARE_NAVY_FLOUNDER_DMUB;
> +	case IP_VERSION(3, 0, 0):
> +		if (adev->ip_versions[GC_HWIP] == IP_VERSION(10, 3, 0)) {
> +			dmub_asic = DMUB_ASIC_DCN30;
> +			fw_name_dmub = FIRMWARE_SIENNA_CICHLID_DMUB;
> +		} else {
> +			dmub_asic = DMUB_ASIC_DCN30;
> +			fw_name_dmub = FIRMWARE_NAVY_FLOUNDER_DMUB;
> +		}
>   		break;
> -	case CHIP_VANGOGH:
> +	case IP_VERSION(3, 0, 1):
>   		dmub_asic = DMUB_ASIC_DCN301;
>   		fw_name_dmub = FIRMWARE_VANGOGH_DMUB;
>   		break;
> -	case CHIP_DIMGREY_CAVEFISH:
> +	case IP_VERSION(3, 0, 2):
>   		dmub_asic = DMUB_ASIC_DCN302;
>   		fw_name_dmub = FIRMWARE_DIMGREY_CAVEFISH_DMUB;
>   		break;
> -	case CHIP_BEIGE_GOBY:
> +	case IP_VERSION(3, 0, 3):
>   		dmub_asic = DMUB_ASIC_DCN303;
>   		fw_name_dmub = FIRMWARE_BEIGE_GOBY_DMUB;
>   		break;
> -	case CHIP_YELLOW_CARP:
> +	case IP_VERSION(3, 1, 2):
> +	case IP_VERSION(3, 1, 3):
>   		dmub_asic = DMUB_ASIC_DCN31;
>   		fw_name_dmub = FIRMWARE_YELLOW_CARP_DMUB;
>   		break;
> @@ -2063,10 +2077,9 @@ static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
>   	 * therefore, this function apply to navi10/12/14 but not Renoir
>   	 * *
>   	 */
> -	switch(adev->asic_type) {
> -	case CHIP_NAVI10:
> -	case CHIP_NAVI14:
> -	case CHIP_NAVI12:
> +	switch (adev->ip_versions[DCE_HWIP]) {
> +	case IP_VERSION(2, 0, 2):
> +	case IP_VERSION(2, 0, 0):
>   		break;
>   	default:
>   		return 0;
> @@ -3287,7 +3300,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
>   	int i;
>   	unsigned client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
>   
> -	if (adev->asic_type >= CHIP_VEGA10)
> +	if (adev->family >= AMDGPU_FAMILY_AI)
>   		client_id = SOC15_IH_CLIENTID_DCE;
>   
>   	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
> @@ -4072,18 +4085,19 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   
>   #if defined(CONFIG_DRM_AMD_DC_DCN)
>   	/* Use Outbox interrupt */
> -	switch (adev->asic_type) {
> -	case CHIP_SIENNA_CICHLID:
> -	case CHIP_NAVY_FLOUNDER:
> -	case CHIP_YELLOW_CARP:
> -	case CHIP_RENOIR:
> +	switch (adev->ip_versions[DCE_HWIP]) {
> +	case IP_VERSION(3, 0, 0):
> +	case IP_VERSION(3, 1, 2):
> +	case IP_VERSION(3, 1, 3):
> +	case IP_VERSION(2, 1, 0):
>   		if (register_outbox_irq_handlers(dm->adev)) {
>   			DRM_ERROR("DM: Failed to initialize IRQ\n");
>   			goto fail;
>   		}
>   		break;
>   	default:
> -		DRM_DEBUG_KMS("Unsupported ASIC type for outbox: 0x%X\n", adev->asic_type);
> +		DRM_DEBUG_KMS("Unsupported DCN IP version for outbox: 0x%X\n",
> +			      adev->ip_versions[DCE_HWIP]);
>   	}
>   #endif
>   
> @@ -4171,16 +4185,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   		break;
>   #if defined(CONFIG_DRM_AMD_DC_DCN)
>   	case CHIP_RAVEN:
> -	case CHIP_NAVI12:
> -	case CHIP_NAVI10:
> -	case CHIP_NAVI14:
> -	case CHIP_RENOIR:
> -	case CHIP_SIENNA_CICHLID:
> -	case CHIP_NAVY_FLOUNDER:
> -	case CHIP_DIMGREY_CAVEFISH:
> -	case CHIP_BEIGE_GOBY:
> -	case CHIP_VANGOGH:
> -	case CHIP_YELLOW_CARP:
>   		if (dcn10_register_irq_handlers(dm->adev)) {
>   			DRM_ERROR("DM: Failed to initialize IRQ\n");
>   			goto fail;
> @@ -4188,6 +4192,26 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   		break;
>   #endif
>   	default:
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +		switch (adev->ip_versions[DCE_HWIP]) {
> +		case IP_VERSION(2, 0, 2):
> +		case IP_VERSION(2, 0, 0):
> +		case IP_VERSION(2, 1, 0):
> +		case IP_VERSION(3, 0, 0):
> +		case IP_VERSION(3, 0, 2):
> +		case IP_VERSION(3, 0, 3):
> +		case IP_VERSION(3, 0, 1):
> +		case IP_VERSION(3, 1, 2):
> +		case IP_VERSION(3, 1, 3):
> +			if (dcn10_register_irq_handlers(dm->adev)) {
> +				DRM_ERROR("DM: Failed to initialize IRQ\n");
> +				goto fail;
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +#endif
>   		DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
>   		goto fail;
>   	}
> @@ -4338,38 +4362,43 @@ static int dm_early_init(void *handle)
>   		break;
>   #if defined(CONFIG_DRM_AMD_DC_DCN)
>   	case CHIP_RAVEN:
> -	case CHIP_RENOIR:
> -	case CHIP_VANGOGH:
> -		adev->mode_info.num_crtc = 4;
> -		adev->mode_info.num_hpd = 4;
> -		adev->mode_info.num_dig = 4;
> -		break;
> -	case CHIP_NAVI10:
> -	case CHIP_NAVI12:
> -	case CHIP_SIENNA_CICHLID:
> -	case CHIP_NAVY_FLOUNDER:
> -		adev->mode_info.num_crtc = 6;
> -		adev->mode_info.num_hpd = 6;
> -		adev->mode_info.num_dig = 6;
> -		break;
> -	case CHIP_YELLOW_CARP:
>   		adev->mode_info.num_crtc = 4;
>   		adev->mode_info.num_hpd = 4;
>   		adev->mode_info.num_dig = 4;
>   		break;
> -	case CHIP_NAVI14:
> -	case CHIP_DIMGREY_CAVEFISH:
> -		adev->mode_info.num_crtc = 5;
> -		adev->mode_info.num_hpd = 5;
> -		adev->mode_info.num_dig = 5;
> -		break;
> -	case CHIP_BEIGE_GOBY:
> -		adev->mode_info.num_crtc = 2;
> -		adev->mode_info.num_hpd = 2;
> -		adev->mode_info.num_dig = 2;
> -		break;
>   #endif
>   	default:
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +		switch (adev->ip_versions[DCE_HWIP]) {
> +		case IP_VERSION(2, 0, 2):
> +		case IP_VERSION(3, 0, 0):
> +			adev->mode_info.num_crtc = 6;
> +			adev->mode_info.num_hpd = 6;
> +			adev->mode_info.num_dig = 6;
> +			break;
> +		case IP_VERSION(2, 0, 0):
> +		case IP_VERSION(3, 0, 2):
> +			adev->mode_info.num_crtc = 5;
> +			adev->mode_info.num_hpd = 5;
> +			adev->mode_info.num_dig = 5;
> +			break;
> +		case IP_VERSION(3, 0, 3):
> +			adev->mode_info.num_crtc = 2;
> +			adev->mode_info.num_hpd = 2;
> +			adev->mode_info.num_dig = 2;
> +			break;
> +		case IP_VERSION(3, 0, 1):
> +		case IP_VERSION(2, 1, 0):
> +		case IP_VERSION(3, 1, 2):
> +		case IP_VERSION(3, 1, 3):
> +			adev->mode_info.num_crtc = 4;
> +			adev->mode_info.num_hpd = 4;
> +			adev->mode_info.num_dig = 4;
> +			break;
> +		default:
> +			break;
> +		}
> +#endif
>   		DRM_ERROR("Unsupported ASIC type: 0x%X\n", adev->asic_type);
>   		return -EINVAL;
>   	}
> @@ -4590,12 +4619,7 @@ fill_gfx9_tiling_info_from_device(const struct amdgpu_device *adev,
>   	tiling_info->gfx9.num_rb_per_se =
>   		adev->gfx.config.gb_addr_config_fields.num_rb_per_se;
>   	tiling_info->gfx9.shaderEnable = 1;
> -	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
> -	    adev->asic_type == CHIP_NAVY_FLOUNDER ||
> -	    adev->asic_type == CHIP_DIMGREY_CAVEFISH ||
> -	    adev->asic_type == CHIP_BEIGE_GOBY ||
> -	    adev->asic_type == CHIP_YELLOW_CARP ||
> -	    adev->asic_type == CHIP_VANGOGH)
> +	if (adev->ip_versions[GC_HWIP] >= IP_VERSION(10, 3, 0))
>   		tiling_info->gfx9.num_pkrs = adev->gfx.config.gb_addr_config_fields.num_pkrs;
>   }
>   
> @@ -5036,7 +5060,7 @@ get_plane_modifiers(const struct amdgpu_device *adev, unsigned int plane_type, u
>   	case AMDGPU_FAMILY_NV:
>   	case AMDGPU_FAMILY_VGH:
>   	case AMDGPU_FAMILY_YC:
> -		if (adev->asic_type >= CHIP_SIENNA_CICHLID)
> +		if (adev->ip_versions[GC_HWIP] >= IP_VERSION(10, 3, 0))
>   			add_gfx10_3_modifiers(adev, mods, &size, &capacity);
>   		else
>   			add_gfx10_1_modifiers(adev, mods, &size, &capacity);
> @@ -7647,7 +7671,7 @@ static int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>   		DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 |
>   		DRM_MODE_ROTATE_180 | DRM_MODE_ROTATE_270;
>   
> -	if (dm->adev->asic_type >= CHIP_BONAIRE &&
> +	if (dm->adev->family >= AMDGPU_FAMILY_CI &&

This doesn't look related.

Thanks,
Lijo

>   	    plane->type != DRM_PLANE_TYPE_CURSOR)
>   		drm_plane_create_rotation_property(plane, DRM_MODE_ROTATE_0,
>   						   supported_rotations);
> 
