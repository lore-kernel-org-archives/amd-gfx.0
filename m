Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548CFC6FD1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Mar 2023 19:56:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB0E710E3EB;
	Fri, 17 Mar 2023 19:56:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25C6A10E3EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Mar 2023 19:56:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2pxBxTpHLbAEP6yF6GfP8D3Lg+tVwIFbPaRjXGlW1RahGWIPpidX6P+Btz1yw4F9m7eDYADlKfTRJsBiEyZ7WB1y1gudFPKNjk2FiRHVNPqlkgiBH3cXwa6xgVXzKqKXNPsG3+KHCgjuM25FY5VlyM2aOeo74uF4dUQ0fS6qH0+tQzoiwj4Kn6ZGvJEfA2Z81BRaVxXzrLkTAUW2w1H8lMy3H+KIe8tY9n+AnitIfqZT6Ng/6frQ52KEyJ/my9Kace+WQI3iYQuNgelD77PyfxUcOyB6xgFjTM4eHzQpKtXATmI7wWCWUBFaJWjxpruVkSXqCwNhhKzqqHWRRrBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1U1f1n65tbLj5RFTD8Y/J9SiXME0xsGvmLOUyXNmicA=;
 b=JkQwio0x0ACe2bXBmHqzrRmqi5omJ/RhsUN6t0x8DMDG7udRgUMR3BsI5Tv5DcJHWjkg5vGWXd8FEUzUhqbRjmAPWRhL6CzRYJ0Yw/gZjETKGjWuQyVbNBGMEnr1yFwRRTzqHAImLBbFpjpeSpTWnRPR1W7S2C9tlv2eOIYDXMTMgb9Op5w+irr/gmafyGvUW0uGeM/CawiCvZAwtv37uXNca9Op1obSYlceiQWL+9FY7Jsm1Gx4RiSaEnw+0dzyFt3LGH5sy57TC3lH78NsK0Tl3rOzV4JiVR5B/tDTXTS8rSx13gvYW12MOpPJatYAesGQQFl/UUqLgK42QBkIMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1U1f1n65tbLj5RFTD8Y/J9SiXME0xsGvmLOUyXNmicA=;
 b=rygb4jhV/peudBt3ha5eW3raakp7QQ6URAXc4jazOHaHzEyp3rzap6zpxfTIAuywLEX4jNLuh3Twh5opUgBbMYc8t4r4Xacfmw4LavHGiEcWJR3poVu4Uj28jLW6L2tCv0/SLrICte9rWMXiJbhVKyaIBMmZPR3agzQPY0k+xmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 DM4PR12MB6256.namprd12.prod.outlook.com (2603:10b6:8:a3::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.24; Fri, 17 Mar 2023 19:56:38 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::cdcb:a816:4bc3:a83f]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::cdcb:a816:4bc3:a83f%9]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 19:56:38 +0000
Message-ID: <0509601d-8d7c-26e2-26c9-8f4757a92ca2@amd.com>
Date: Fri, 17 Mar 2023 15:57:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amdgpu: add print for iommu translation mode
Content-Language: en-US
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230317194757.1336098-1-Graham.Sider@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230317194757.1336098-1-Graham.Sider@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::12) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|DM4PR12MB6256:EE_
X-MS-Office365-Filtering-Correlation-Id: e12ea014-0f34-42ce-f06f-08db2721b819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQO2rzC4amdNLLfRpqF3Q7OV0Dq0J1kvVkz//M8xu6rIYZ7Yg34s3r6V7FGz9SNXcpFCphQjCcG7Eq6uNQlZ7PSy1L+dALYzjKw8wvXE5ThPdIS9U0Y9a4Q09l9GGo18nTXBoJ/o3BxEWue4vVEJeeOjeoZFoH47bXFeMsYfFxA+1bgXs7KzqQi1ljPaX5lBZ11+mnWZuDOEKd4AGnTMSCLHD4oFxlpD0iqFkcBgxBhq3M1rYiS7Lo9LBqpCJ7Pu6fzDYGRYmdixpL1hLmMthshP7fP+KWYpwKsH1goxkuLjlH7jwWhXe3Vh0ijTwub2SkcGqrrs7AkX0cpvsdtJXuUZgA0eecUz3C3TSV23xCtt5fuvpkKHsEQDNi0jMl+pTLoUZHbnEK4bkItSh6I/CPGVOBnrR27ZJJtUuYhy2FF5dQnZ9OsUeNkFSOHSRUmtqVsdXLLPWSKcfRwAXGad9ZYonddCrNOZ29E2Q+OC3Mx/oLe12yZ/x6cOqvBaME8vSpr0O7vJq8PtKw2TY73O7/AMs0/GTV4t5VFQlPOI8t/eoqpnVu5NfvrwDM2CO9K8MSCPW1PZNENkHTFvkvzbbtyD0CW2ea0IRsUdZqf/78MIl/qbJf+a5hB4MGmFzc/da6kpSjZwWLL72mN8sdLI8/uFNHcqOhdApCSTVPO6n8F7fv1al0Ouaqz5DChDCAT8jAtqvNVvL4wPq8tFPTvy55AVdDoG2oy450GALQBsiSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199018)(2906002)(8936002)(31686004)(41300700001)(66946007)(66476007)(8676002)(4326008)(44832011)(66556008)(5660300002)(83380400001)(478600001)(316002)(53546011)(6486002)(36756003)(6506007)(6512007)(6666004)(186003)(26005)(2616005)(86362001)(38100700002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk9oN1NaNHhzNjNKYllMRkJlK1ltVjlyNklvbWRiRy91ZmpFM1RDT3dDWVF6?=
 =?utf-8?B?c1htVmlIaGJqNHh6S1dmb1RndUhXRzhuL201VE9RcnRoUHhIRTVHQ3MyOXZ5?=
 =?utf-8?B?V1NWcWtwUGhUaUJoaTRZS0w0OWJmQVRTOVlCclcwZlZKemdDREpIUmdlMy9R?=
 =?utf-8?B?VTl3ZC9uY3ozVDBhdTcrYUpSTXlBL0REOXUxbEhYalZ6SU9qUWpQeUllUmR5?=
 =?utf-8?B?bWJ4b2FJSzQydmZUOW9LTytTdW8rSThoaUYrVmhkZ1dTcmRxMmRsOU1XaDgv?=
 =?utf-8?B?dVpVblZzZGdhbmdVVHA1bFBNS0pYY1BCTlFCVUJpckZ3M1Q3bXFTdUxFZndr?=
 =?utf-8?B?Q3NPbDRTMjBiSDV5SnFxUGdIWlllZERPV01zek1pN0svclhZdTZOTjkrdzBJ?=
 =?utf-8?B?alZBYmFuS0ZVM1lCa05mU244eDVWa3RrQU1XeW5uVTFlSUJmT3VRemx2Q1BN?=
 =?utf-8?B?S25DVC9velU1eXc1NC93NlVMOEZNbkFFM2FUSjdUbGkvRHVvNU4rVFpiQldp?=
 =?utf-8?B?bDRLczBJMjhlS0pjZlo2VjZ6KzNuVGdTRk91cGdlRWtnaDFRRTI0VFJGVzFm?=
 =?utf-8?B?RXNiWk5ESVcyVHBzZUxIMisvN2NUUFFVZUJ5Z05CSEkrMlJMeWdsOEQ0SFBa?=
 =?utf-8?B?VW1hSmo2OXhOZDhtU3djcjBBZmpqM3V4eDV5NFVNRFVYSzFKYlFiUUdBMjFI?=
 =?utf-8?B?dzZ2bnhMRUNJV2U0SlQyNTIrcXBOL2J3ZG1wVFUrRU1IZTlaVkNJNGxTZVRu?=
 =?utf-8?B?RW84cDV5aVFQY3VNZzdIaklHajUybU92NGdIYitHd1cyYVNJRll5dlAwMjZZ?=
 =?utf-8?B?ZWhCcjFEeURQZWNrbk4wUytzb0YvVTVQVEp2cHFJSDgyc2Q5RDlwM041UUVu?=
 =?utf-8?B?WG5wMDBTdVhYOGVZMUh5elNlOTFrWWhjVzVOTXpGYnRzZU1MempvYmRjMStS?=
 =?utf-8?B?d2lFQ3RkeWhWeXpxQSs3T2Y2M2lNamV1ZEhwam9id0RsdkRvQnVJZmpOUmxZ?=
 =?utf-8?B?R0pGUFVmZEVsMGNoY0s3MzZ3TSt0dEk4VnExU0RDUmJoN2xTU0NseG1nMFJ0?=
 =?utf-8?B?cHQ3OVRDbURFblBUang4Z0ZFd3RFMjdvUUJEZ2JJdDljYjZDY1VGbjEwcjM4?=
 =?utf-8?B?MU1qa3hsbFU4UDVXbmJsSlNYMUFneXQxWmMrMTFUSkU2Qzh5MGZpU2RQTU9X?=
 =?utf-8?B?SXNJWEZ2RTlDWm1ENzJlSWUxK2xGM3NFVG1oNFNaUTA0c3VoY2FEY0JaTmVT?=
 =?utf-8?B?U0FFYlBvdm8yNTl3OTlmSzk2bDZjeEl1RlJaZm5ZSFZoVWNHYnhtdnh5Y1gx?=
 =?utf-8?B?cjQ3eTg0Zk5Jb0swRS9rT2JNcDJjdzh0Tzd0VkVERnRKR0ZhbHc4eHNUNExX?=
 =?utf-8?B?SDR5WXI4L2pNdUdQNEthRTZ3Qm5jQkdtbzV3NUhDMzAvYWRIckx2SGZ0dm92?=
 =?utf-8?B?Z1JueHZ1YUhkeU40YTFGQzVHeml0cmZ2dzN6RTM0ZC94bUsva2pIdXNMOC9F?=
 =?utf-8?B?NE5TWHVFanB4eXNHQ0tZWVBYR0R5MENNb0VYNGhMOGgrTlhRdDFTTHBpdm4x?=
 =?utf-8?B?OU4rdWh5RjlVdVhoSWFTQmtJeVVrdzNIeFFXYkZOWHAvRlh3b3d2RzZtMFpk?=
 =?utf-8?B?MnI5V3Zqb3I5bUszTTBnOHVnU2VlRzlmQThKRFlLbWFTY2VQbXh1TG1uNHZw?=
 =?utf-8?B?ZVVsZWhBT1lvdEtvdUpEanRNOHhwZmVrWDJGczU1dTRtcHFCYncyRDUvR1hV?=
 =?utf-8?B?S3FicE9wcGdHMk5kNXNyYVNrMTUwa285U1cxb2dxdHFpc3ZVZ3gzaU9tc0xQ?=
 =?utf-8?B?bThyWTArZ1NZQnpRTVhoS2sydUo3b2V3a2hVZE11STNCQ2M5UEhFcGFyQmhC?=
 =?utf-8?B?VTdkQnlUNjhCS3phOE10cGN2ZHNjSmlESDN1WG1TYWxNNDZETndsZm5iUkxm?=
 =?utf-8?B?ajhFMCtSNit1aTJ2SzdrczhWZVNiZ2dSc0M5YkFmenByWUxnTGZRaDhzeWcz?=
 =?utf-8?B?UWp0Zm9GTEtoeVlTNVE4dXlwY0N3cE9RaHpxOC9vY28vMk9GWElUUmZyL0xN?=
 =?utf-8?B?M3hqVnUxVHZwZW9oN0p6QkpFNDFpNGZvYldDREhCaW84U2ZiZFcrNlk2cXFo?=
 =?utf-8?Q?OPL6P/yqGbbKeRxgl7nmn3Fyw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e12ea014-0f34-42ce-f06f-08db2721b819
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 19:56:38.2276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2J0i7hKLapDm/TgWtZjw6MOAeeHExV2iLFNAmLNq6wFBSs5QZUSIldDROengseqPpfM7zQ/4TUV4zbKIdhiFcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6256
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 3/17/23 15:47, Graham Sider wrote:
> Add log to display whether RAM is direct vs DMA mapped.
> 
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>

If this information is only useful for debugging purposes, please use
drm_dbg() instead of pr_info().

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 8bba5e6872a1..8797a9523244 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3528,8 +3528,12 @@ static void amdgpu_device_check_iommu_direct_map(struct amdgpu_device *adev)
>   	struct iommu_domain *domain;
>   
>   	domain = iommu_get_domain_for_dev(adev->dev);
> -	if (!domain || domain->type == IOMMU_DOMAIN_IDENTITY)
> +	if (!domain || domain->type == IOMMU_DOMAIN_IDENTITY) {
> +		pr_info("RAM is direct mapped to GPU (not traslated by IOMMU)\n");
>   		adev->ram_is_direct_mapped = true;
> +	} else {
> +		pr_info("RAM is DMA mapped to GPU (translated by IOMMU)\n");
> +	}
>   }
>   
>   static const struct attribute *amdgpu_dev_attributes[] = {

-- 
Hamza

