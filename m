Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0780DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Mar 2022 23:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 682BB10E54F;
	Wed,  9 Mar 2022 23:12:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F291F10E54F
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Mar 2022 23:12:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJCfK34QLuTi0iPbjOa8GbRtlHiZpYf3B5cnOOP+Bffc1qOYiMTMLmSiz9LUeDl355Kr4Cw930fLerFE5MMkiEV6zOIp7dDaWyPL0rgFdf85n0NVNTC5ecJAK8QBQkyrKMMiXL+obREbu8hZ5gemFZK7eoJZO1EjenTTV1DtnEeWl8ymXD8PdrfcCjRpKH1elqefmH2kCAOstXEo/2IOl4d+I6Qg8POeYlovx/sh2k87C8o9o0FIE/J8Lb/Bpd5i6JGjqIcq8HHyBc1E2LFHFB7Z4JoAwiEG35mzX4NyhLGIvKGdCG20m31db9Zcjb0e6atpVg69s2Gn9ov5TyCc7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n01QlZFBVGEePo9Ydl1qpwiZEzyjFxEjxpPIzPVUGZs=;
 b=Y/4OzAUwnCVIeSgv+TNBVzejWMs3ACW6X94817TEqRf9+cypOZDYGkg/2LR7y2EUHkzEm0o3n1BPC/G5mlf3MNvfB43jExXyuqg+/2kQCnSW9v+f99SSj5TxNcqt3By9GFBiOICkS2hqS4TvTJ0rQpc2mWeVj2efLqW0Rx0du1YDfwGdBsbtxv8twnzkD8VGVFfXL0Xu9iePN474T/9XWyoccvPiiZn8GXGp2Bni2TYwDrepxzPUJ8LlRryOC7B2cCkg1iJDFs2c6UkmVRj0MqjDsu9Wqky6gnn39H0eS6+5VwTq6tdhfzWB2pOvYnSQX1/K8b5B8rql+2Rc5NNBAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n01QlZFBVGEePo9Ydl1qpwiZEzyjFxEjxpPIzPVUGZs=;
 b=X6RTY8Zm8+yUCI5OWq61AKacrPgpXT+0bud8AIq7GmizRDWGybl5uIApWukmk4EfpsiOvQfuD5Oci4lhurwp58LEye0NRBuanbSSXt76sVDMxC8ixqv8M9jmhCGSt6YzQJPlvXHNDsu+bNbHEwPnG1nbNNgjkXqS0N00t59NwAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB3195.namprd12.prod.outlook.com (2603:10b6:5:183::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Wed, 9 Mar
 2022 23:12:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b030:b1ba:4eb2:7fb7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b030:b1ba:4eb2:7fb7%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 23:12:02 +0000
Message-ID: <99d17bed-06e1-45c2-7a70-449f1ae47eb0@amd.com>
Date: Wed, 9 Mar 2022 18:12:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: fix aldebaran xgmi topology for vf
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220309221645.468184-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220309221645.468184-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR15CA0030.namprd15.prod.outlook.com
 (2603:10b6:610:51::40) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2876e25e-a408-441b-bb9a-08da0222387b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3195:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB31951FA5F58B404680358676920A9@DM6PR12MB3195.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: anKSrRJIzkA6POL6elcm1NqMhlk5D5rGBUGStzM1DGigVQ/LfZzG6IW0ddVLHC9WT91DcLWlp0Z3xMz490rYJAPGc6bo+LNHk41EGjVuUSVBuutwgG7Z42f534olIpIkMFiv26PFUBcbgwi0o2P/gac8mBANFK9zDF9cURjotnw7gk9J7XFR7s7WGhgA4iSZzVCK/t51hX2bLPjGManVqTx0KcYBpSdIIlBNRc+TjrTt0mkFG1WEpWgnNsh/j6JCrIkwUxdVIUPr0VY9QfHJmvZeq++mHU6liT1qTn4FTTcm4zhAiNzv6VbpLGPrX/CW5ZDhFNtUeqcTEZ4khHyoXCxoDynDgkESDdiaVR1J6RDFj0SNjU4pQwdwedHGA39xddIHFi5LTv7+lkhprQgDwsP1B7rYZqrs/uzbP12YZW1kE/gq4xQun9wkH/fL7+ZARIPu6E2Mbu6CABU0s7n6QTShbir6j+FPJ8o1rLgRpVV2YOsE/qSIsKBGAzYA6CYmUc5xS4yh687VYBcx56kq3HqPW5otbn/ARWJKtcjLcTQzCbygSlE3d5HWaY1Vci9EGTR8Jx8eZG87YK1XxGEPkZx72++G52SH0i8fjF8ISDu+o2uoJw3zRzzuOxL+daTfooUIesezNUV8hNuEnkzrpMTSWttVB700TM8YEdAvltHZWem2WHkSULXq+qt1N6YjiWIw4uwNkmkbX6+7hnMmMycpspHF4g4NBYFwrynmMGs5t5HnDfQe0u3c6f52fqNZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(31686004)(36756003)(4326008)(316002)(86362001)(31696002)(186003)(2616005)(5660300002)(53546011)(6506007)(36916002)(83380400001)(66946007)(6486002)(26005)(38100700002)(6512007)(508600001)(8936002)(66476007)(66556008)(2906002)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGRZNzhEU2lEZEk0Y3YxNjZEQWVCTWNaa1AyWmFpYlYvQ3k0QU9jSy9jTCsr?=
 =?utf-8?B?RFpHcDNLMEZIQzZoWFNJVk1UR0V0amM2M3RkOWJCQnZhWXVQakdXTGFGeGN0?=
 =?utf-8?B?dUpNMkVTemZlRTJubDIzVzVYV2FhR3UxeHpWakx3UU1xUmg3NzdJdWV5aU8z?=
 =?utf-8?B?dXdiREphV0dCaFRGWUVtMllBM0pMTk1vdXphN3hVcnFzcmdvLzE1ZDNLVG1z?=
 =?utf-8?B?NlRMRzRjNHVxQUN4aHBNVTdUYzVLbVpaei9IVXBDdWxuKzFLeW9uUm1NRVp1?=
 =?utf-8?B?b0F0TE1ka0hjSUU0TXNZMEtHVjN0THBpQ3NJZll4T0Nzc3UrRW52TDZrU1FD?=
 =?utf-8?B?L08yS0RrY1JGVHJDVnk1aGhGcFJmS2lNN29SRXNmL2d4dU1BUkNDdEs1bFI4?=
 =?utf-8?B?a3dqNHNjRnpmZGFlYUhoazZRVUNkaXBSSkVCeUJHbGFoM1dtUktkME5SMkxq?=
 =?utf-8?B?QTBrcmtRWktBL1BlOGIwYUVZZkJNNzVKQUpWdk9hT3huQk4wWVc4dmc3Mldv?=
 =?utf-8?B?UUVPOTZvSGdYWnFKOEpNZXA5SktrTytmVWlDRkpuS2NoeVdvQjhVUVZnTncy?=
 =?utf-8?B?S0FOWjZIRkd4V3luV295WXRrTFhBNWJGMnJwazY5eW9KSVdaN1VOaXpZM2FG?=
 =?utf-8?B?RFdDcGdXNnhMcTRNeFNySHdwNHFBQXArMU1MRUIrQVZIVUw4M2xUME9EU3Bm?=
 =?utf-8?B?bE9HRU1SeDlTS0xPdmpTWXA0Tk9sZ0g2UjBBUTBENXBHNlR6REVTUlNNbVNt?=
 =?utf-8?B?a1FBYTRkOVVTeWhadUI2aThPWkV6UXRoSmtUcFFGZ0FiczNUT0xlbGxDN2NX?=
 =?utf-8?B?c0I5VHZMbmE4bmRCMVU0d2NpWGNHNHpmL095cmg0RTJVcVIvK0VhZHdOdmpY?=
 =?utf-8?B?ZEtSaDR3eEhpWk5CelRPVTk4NHAyUlN3Mm03M29tRXk4dCtydVFRSzM0bml6?=
 =?utf-8?B?RnY1WGlob0lmcldXRmJBYkRldHNpbUVQMFFvTFhxWVNFcFNNa0NzTDRwM01S?=
 =?utf-8?B?R2ZwMlVNc1FzbzVIdTZYN1VYZWQ4SFhRbnN3Wmt6NVlhSFpaeThBZzdsazBS?=
 =?utf-8?B?alBPRHJSNXF6WEFKQURSYzRnRUVYdXFZKzQ4T2VhUjJLa0ppeHZ6Ti9FR01Z?=
 =?utf-8?B?VXZLRXFpK0t1T0cwTjZEREltU2JiMHhzSFdOR0FxcUk5Rk80UlJIL3pjT2dD?=
 =?utf-8?B?bE5FUXRXd3BZSXl1TGtqZ2d2SXdBU0t4bGhpSnNwMXVkL2lpRnlMTlR6OVVS?=
 =?utf-8?B?Z3RDVUx4S3JOZ05BTEdDV0k4ZGhPR1VNRzY5d3NUdmpvcHBYa1pYUVFlOE5v?=
 =?utf-8?B?RVFnM0tVWlBoVWpZZSt6MzdiaWNwZzRSc09ORmcrU2tHenlWem9zYW4weGNF?=
 =?utf-8?B?dUR0RnZNTkRCMHBnanFtYklLQkw1dWxrYXVMZzhXWjJRZVgzMXgwQnFSbGY2?=
 =?utf-8?B?T2VQWjhKZ1VidkZ3dE94YWJWNDhzd2ZubFRJTDRBd1VQSkJ1TDBteUJsNGZR?=
 =?utf-8?B?em5aQUQ4VHZLNEx4NGVwNXc4ZnVpaTFzeWczZzZoeG5rRzkvVGtSQlYvZVAv?=
 =?utf-8?B?SkRZQnV5cnp6NDN2MmxsNExjanhwU1VPeDdUak1SQlcrS1oxUjVyYW5jR1lY?=
 =?utf-8?B?S21qOGd5Um9KV0ZCNG1nazRqSzYwYnpjNUtZZzFiV284ODRmSkhlVGYzQ2Nm?=
 =?utf-8?B?M05qTDQrQ2N2RHJyb2Q2MDFzWGhiano0V2lidFdzSHpUS1pmdUM3RE00V2lM?=
 =?utf-8?B?Y2RrRG9QMkFmZUlRTC9IekFiM2dwQ0ppOVp1QTZYMmYvQ09oU1N5N0haSXdW?=
 =?utf-8?B?R3p6VDVJd3dqZm5HRlVBTlltRTRFczYrV0FsbmNtTVFZR2hMeklJQ0dJYllJ?=
 =?utf-8?B?eHFoTEE3MVR4Ym1jaHJCa0JRWDk2WUZ4K3N5aENCTXhYYStjcGp3NFEyUUpt?=
 =?utf-8?B?UkV4bThMT25LOXVuKy9UOUlGaERoazhZeDZsWEVwN0M5eFRnRysrYytvVm04?=
 =?utf-8?B?Uk04b3U4NGQreW8zOU5nYjZnQ3NYOTF4djVPamhDa3A2MW9mbDByVDI1YnNm?=
 =?utf-8?B?bHYvd1Z1NVlmOXVnSE9kU2ZPam5TWEdEb0JKRXhReVV4R3pDUUtVbXNKNzk2?=
 =?utf-8?B?bzN4MUpPM3BzaEtLQkgvVkV3eTBkUGJwaWJ4M2xWY2JGV0J3Y2Nxb2dXUnFO?=
 =?utf-8?Q?a4tEclKESjpSbBM/jklhrhI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2876e25e-a408-441b-bb9a-08da0222387b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 23:12:02.7060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7lOP/gbTk3CpAkuiZV6Ykya7dcQq+QoIn9FiXZ94d+KaKCfWX8mZTtlKN3pIRge1HiQ5LZZCJbfhBe9lE/7Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3195
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
Cc: Shaoyun.Liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-03-09 17:16, Jonathan Kim wrote:
> VFs must also distinguish whether or not the TA supports full duplex or
> half duplex link records in order to report the correct xGMI topology.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
I think I'm missing something here. Your condition for setting 
supports_extended_data is exactly the same, but you're initializing it 
in a different function. Can you explain how that change relates to SRIOV?

Thanks,
   Felix


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 3ce1d38a7822..a6acec1a6155 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -310,6 +310,10 @@ static int psp_sw_init(void *handle)
>   		return ret;
>   	}
>   
> +	adev->psp.xgmi_context.supports_extended_data =
> +		!adev->gmc.xgmi.connected_to_cpu &&
> +			adev->ip_versions[MP0_HWIP][0] == IP_VERSION(13, 0, 2);
> +
>   	memset(&boot_cfg_entry, 0, sizeof(boot_cfg_entry));
>   	if (psp_get_runtime_db_entry(adev,
>   				PSP_RUNTIME_ENTRY_TYPE_BOOT_CONFIG,
> @@ -3008,7 +3012,6 @@ static int psp_init_sos_base_fw(struct amdgpu_device *adev)
>   		adev->psp.sos.size_bytes = le32_to_cpu(sos_hdr->sos.size_bytes);
>   		adev->psp.sos.start_addr = ucode_array_start_addr +
>   				le32_to_cpu(sos_hdr->sos.offset_bytes);
> -		adev->psp.xgmi_context.supports_extended_data = false;
>   	} else {
>   		/* Load alternate PSP SOS FW */
>   		sos_hdr_v1_3 = (const struct psp_firmware_header_v1_3 *)adev->psp.sos_fw->data;
> @@ -3023,7 +3026,6 @@ static int psp_init_sos_base_fw(struct amdgpu_device *adev)
>   		adev->psp.sos.size_bytes = le32_to_cpu(sos_hdr_v1_3->sos_aux.size_bytes);
>   		adev->psp.sos.start_addr = ucode_array_start_addr +
>   			le32_to_cpu(sos_hdr_v1_3->sos_aux.offset_bytes);
> -		adev->psp.xgmi_context.supports_extended_data = true;
>   	}
>   
>   	if ((adev->psp.sys.size_bytes == 0) || (adev->psp.sos.size_bytes == 0)) {
