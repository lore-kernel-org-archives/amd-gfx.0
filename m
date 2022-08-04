Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65478C19F2A
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Aug 2022 18:54:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 068D911A63E;
	Thu,  4 Aug 2022 18:54:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B4FD1125DC
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Aug 2022 18:54:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaIo74rzfrD3wgzUFWOdauNTugB0fvnW+sez2J+xAWzpevk2xGSuQR94+qX2dro+2+gYX4k/JoqTnAyMr3GQYlUu/E0jE3kk5U5H79rlPfSGMApFXHTLhO8ios3kirRZt2wU8wppGoyua6DPDIVlyFXTxxESL0KlylOc+QlD+sycvAK0CTbpbYq6gQOM3l3bgSeYC/GJW8aBr4jDylvsFHD0jJlwcDMyv74YVXYPo3yP4/ecKeFe6a/7Qi8Q6Ci2SP3n/IJXCHKUB2wSg6eBcwgXpgatf436xmxb0jLbK8oX560mfT0uIqXYVfP2id73PesVGDqkmHqGpqo5g7Nwig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAOz6A//8iV4BjwqmSjs2cqrulpKvO52zgYVumGdPyQ=;
 b=lUDfi4KKIPxO5tViUDl49ixxBOaxBo4FKu33xWr+cFfzm4hlrZ0uVKo1PU17ESXUAmEkX7Pzq3q0T91RnghWNWCD1cw614Zk3y0t1UWTa1d+9afJ/rBh8IJZrKmlsuKRCLwR1UpzB0wEfYYeq/t2XdsDLs8ii6WdRZCvAXBviz71pnHDoxQxWGZnhlFUrArC7uoKQROLj3mPHmHFyJPVSvMibf73EdTXWJn1rPEAiDC5KoIA6BSf0OvMJwoxfxTiWlAPA1CAbkOYiLZiNOzyrlM/eq4ItEjnQGmJglJVJpC+Cfd1g9vWGmQQ8cce1j1ruZPopmZ4U/yj0UMpJz3nEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAOz6A//8iV4BjwqmSjs2cqrulpKvO52zgYVumGdPyQ=;
 b=meM7LJWqnZuzALk03FKJFAmuU6a6KE/JFc6nnxgcQaTas1Eu0+7d1nRWkbDwEC+FoEjgXHOYjehzLdgzUyNcNTP9Lp0FolgtAqpkrQC1auRHSqYUUsUTcuG2DWjXyX9XE/XbXm38a18p2L8rJAUQopWx8OcNT7sKZvO7gwVskeI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BYAPR12MB2600.namprd12.prod.outlook.com (2603:10b6:a03:69::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Thu, 4 Aug
 2022 18:54:19 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5504.015; Thu, 4 Aug 2022
 18:54:19 +0000
Message-ID: <7390b455-bd16-c1df-25fa-a1b1e3554a0b@amd.com>
Date: Thu, 4 Aug 2022 14:54:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Enable translate_further to extend UTCL2 reach
Content-Language: en-US
To: Joseph Greathouse <Joseph.Greathouse@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220804160158.937021-1-Joseph.Greathouse@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220804160158.937021-1-Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0024.namprd18.prod.outlook.com
 (2603:10b6:610:4f::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 101d5990-7631-4aa3-ee07-08da764abccb
X-MS-TrafficTypeDiagnostic: BYAPR12MB2600:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/c7TPwmWEkMvBPYermo7z1sxBqNqFSByXf+OA9W+Xseh0Ps7BGsJ2JmhnhT84/IcNs/wizvQVPy6tuwb2DtBdcWVGguBuXJQ4yysJ7EE3tcAuN8rdCT5WlpT4pcV+80wMptmBNKAZ4JT9usIWJVRaEBwWnJ7JwVhmfMp4VCS9XMvmcfqmRWM0WOguPuViPaXe/kvtuVZhs/MmzvlpI9V82GHu+n0nEeTgRRc32BRuUequUAA2yhIgAJWqgxzsiYcz8g8C6SdVB8PfVpHNpAwNAkC2d33FY3pEreOq4lg4AGX+hKKE0X558hRt7lhvK8L1rRAY/GFs+Or4TPswMY4oUOW0hPnFPrO4TFmf1OS7Qp4FrHydFAV3EL6lpbC7b6Ymy4zSwFWspHCn/XD9Ibc3jjff2CogvEpMptFNYz5/KlLnkUcZeIc9q2r30ET3+lZUQXya0fvAFo97uGtHAXzvtfyK/3fGGp50eoXLCSP28o4GxbkAGmz9P8OUBmr6LGDFUlZ15yqwE12HIXGWwU56n/uYfx/DkxpaiTAjiNPh9lNLHSvUICvBIqOVJTHAhv/znQ5GjRuqzoVN92ghAHBRBq9X5aSgE743KaKy+MyclwMR5kD83y5sksl2BT+aJB9VHfo/USFbcW7OVX1LQRax7jaLIwdN2NFVzhLiNht9dCvYp5xdjOdkBLbKVCWAmrl92KLKKN4UR0wlbMD8yDogacBEbJsbDn5OvrcLpYmJpyBb8HejabgMyPUrW2IfmIhPaxms9mxVtVrY4RHsi7hoKfP4bVoDaZysEmRK34pa5AnlTilYoSPhaDk0UQ+JopgFDA5vsp79oDSPmV1E6IvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(6506007)(5660300002)(26005)(6512007)(41300700001)(36916002)(53546011)(38100700002)(36756003)(31696002)(186003)(6486002)(31686004)(44832011)(316002)(478600001)(83380400001)(66946007)(4326008)(8676002)(2616005)(66476007)(66556008)(86362001)(8936002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aERXR3NjSG1yVXlKOVNkakJNSkM3VndUY1k5NW8zUzROY0xsNlZDQlBrMnps?=
 =?utf-8?B?T2ExNVNFcWtnaDQyc1A0ZllUME5CcFNrSGhzeTZBU0wvM2pWREN3cGk2MC9N?=
 =?utf-8?B?L2RYempPQXgyK1JpTHlHMVBuN0xNSGZ2dmp2YlhCNGkvRC9heXM2dkdxWTlt?=
 =?utf-8?B?V3cyOHRMcjlDSmtGM1lXNUx6d2ZTN2p5VElDdWVYYStQRTQ3cGx2bU0vemxq?=
 =?utf-8?B?Q2cvaUJRN3k3eVZhWDAxZVRLTVpCaEwwZFM5STlWbW9zeTd5MUVTQ1RYZzBL?=
 =?utf-8?B?UGU2UzZOSWxtdEViRE9rcTFWUk5kSDIwQTlJVGVXdjhUS0RQSUpjWEdvdCt3?=
 =?utf-8?B?Nktwbk02cFB4NHN3VUt2Y3pUNjZ5VXpJYUtIMXhib3htWlBPa25nenFyMmRU?=
 =?utf-8?B?NllMcHd0TDVZbkNVZHd5dDlxajBtaHVGSjVNdW1SQlNYSStGRSsvbVJUYTVF?=
 =?utf-8?B?U1Y5WUx3cy9HMUJRMXpUc3c5dU1qNzlncGExdUxNa1N3eWFtOXZXRDJLNkI3?=
 =?utf-8?B?ZW5EakpxL1lGamtEMUFxajkzbnQ4ZEhGOUdscGVOSFNUQUFvTjFEQmJuMXd3?=
 =?utf-8?B?aFVIMmNDUW5aYjdiOHMxVmxsaVBGTzFpM1QrRUhRdXp4d0w5MXhXR1piRHVS?=
 =?utf-8?B?ZFNabFU5R2VaY24yWEU4NWFxV0t4WlNZdThsandXUnF3V3ZzeVJKSlVvaGZn?=
 =?utf-8?B?U1doaWJrTU1vcW1jbnVHREFzL2tMM2VwZjlWTHpPbHROdnJDeDcwSVd0azRs?=
 =?utf-8?B?cm5oVkpkNGttYWVidUVTRU1GQ2hwUXFITHNsMHJTd05vamtpcjIrQmx0VjM2?=
 =?utf-8?B?RUYwYXZzMysrRmZ2QUp6QmE4WmwvL2VmbG9MRUt5TlRvRjBHQ1ZMbzlaQy9v?=
 =?utf-8?B?Z1pUaGxZNFZSSFVuNHVVMmtHTkZ4cmNsRmZzbi9aTVlTSUl3dmZvaStibElH?=
 =?utf-8?B?NEhhR1kxT1V6cGRwbkpQT09rdDAzTm5IM2wwTmFnbTU1K0pyQUVXSUNWS29C?=
 =?utf-8?B?b2VOUFBLaW80Vnh3cTRQUEhEY1BzaGhGdDZ4TDdVYjY5bGpOamlKbDE4ZDFi?=
 =?utf-8?B?QWtJUVBPUDdJcmJSb3VUeUozSjRQUUxpRy9SMitaWVBGeGo1YThqeGVOQ2pt?=
 =?utf-8?B?RHh1SFRNMUZHWkpJUHg4NGpVWlFGWGpPdmtOSXp3cnF3MXR1Q3gyb1dIMjFB?=
 =?utf-8?B?dkJEVmZTK0gzNkZJUWV4R0YzNUI1eUVhLzRmSENWdlRkaVYyMUx6ckhRejlB?=
 =?utf-8?B?eVYxNEdQUCtLRGJaL3Bta05NYmFHMVdhS3hhcHBKbjhPdTlOdVM5cU52L1F0?=
 =?utf-8?B?Z2x0MFRTQ1VxbEhxWkU2VXROZi9TNnptNCs0OElINk4rZmxhMmVJdEZSZGQ3?=
 =?utf-8?B?OVZKYm9nNnBaL3E2U2tvYUlqY1NwRFVta2xHZ1RiTXVFeWNMNUxDRFJ0NU5D?=
 =?utf-8?B?aXUwMHJINENVLzJUWUxyb0wvc08xQUNqNjRLSks4cE03ZiswemxUZk13ZmR0?=
 =?utf-8?B?NGlmdnp3a0c4MmhZVlpaQTlCa21CQ3pEUm90TEFuTitkSVBvSmJscVQxL2sw?=
 =?utf-8?B?Z0dNNk03ZTVtYS85NXBYcnU0M0VoOXNVMGZrcjVrVUYrZkgrZ3V2aFRvOXNu?=
 =?utf-8?B?Q1VNSXBESWprNU9JZ1J1ZTIwWUptaHkwVlp4Ti96WnFrK0RCdmJBbjB3Qnkr?=
 =?utf-8?B?dnNhWkxhdFBJa0FqNWNEYkZHenNKQXJMRGFqMmdidExLekQyTGEwWUhnTWVk?=
 =?utf-8?B?dlZaWDkyZTFvaVhoTGh2RHE2Vm1iRmhJcGoxeng3S21zbzlsU0xvUXRUMkt2?=
 =?utf-8?B?d0tKV21UVm0rRDA3aWk2ei9sZWhoNk9ra2VLcEVQQTlNc2M2anFyMjBlellE?=
 =?utf-8?B?U082UTlXYUJDYUlHWXUzWFZhQTdjZ0FFME9VRWk3WGVRYVZpa0Z4cW1xUFhE?=
 =?utf-8?B?c21MS1JYY0VKUzk4TjVYY2JwTEJ0N0ZGRDI5U1dPT2NhVklib0ZjMzEyekpk?=
 =?utf-8?B?QzN1anRHeks4TDdMT3hCMWhiUXBseEduQXNmcjJmalJtRkdLQm04RDJlKy9X?=
 =?utf-8?B?ekgzTThEa2k5ZUZRenM1SnBhN05LOTR5RHRqZ2VNbUVEam84UlJUQ2h2T1A4?=
 =?utf-8?Q?Z2ie4foH92nuHa9R5huu+n31o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 101d5990-7631-4aa3-ee07-08da764abccb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 18:54:19.4747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yq8K5vm2k9ZzBXX79YsmbGXQAIX6lwsg+kZ2sKxLGT5duYhpkCwkHrGtFWRvbanB9OuTkyr5gI8h0WUa6BTjmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2600
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
Cc: Kent.Russell@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-08-04 12:01, Joseph Greathouse wrote:
> Enable translate_further on Arcturus and Aldebaran server chips
> in order to increase the UTCL2 reach from 8 GiB to 64 GiB,
> which is more in line with the amount of framebuffer DRAM in
> the devices.
>
> Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 22761a3bb818..ab89d91975ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1624,12 +1624,15 @@ static int gmc_v9_0_sw_init(void *handle)
>   			amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 47);
>   		else
>   			amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
> +		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
> +			adev->gmc.translate_further = adev->vm_manager.num_level > 1;
>   		break;
>   	case IP_VERSION(9, 4, 1):
>   		adev->num_vmhubs = 3;
>   
>   		/* Keep the vm size same with Vega20 */
>   		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
> +		adev->gmc.translate_further = adev->vm_manager.num_level > 1;
>   		break;
>   	default:
>   		break;
