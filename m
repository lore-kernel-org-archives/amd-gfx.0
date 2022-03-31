Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10C5C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Mar 2022 10:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CD2F10E9EF;
	Thu, 31 Mar 2022 10:07:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 321A610E9EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 10:07:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAtPDYHSVG1ATqcZ76vOcokk+5aWelXtLdqQF+3fH6CsYhV7+gI+Xd5jH1fKpoewCXVN1GBjFqAxqB0I6+e96c15lM6u3N+YvgxJvXnAZFpPjNVkcf9L88/NZetsHaSSkcuLSECKfi0TOl8Jv1+dXEUBfC/DUFCmpEVUhUxQ3KOvuwbJf79fIVmadIsXjM+WEAUoNjTK6mZeqFTfs0+5X8dFEEYKemmM9qNn01LA4uxteoncDp0jFIVJq3FxRhqPhB2/3YPt65IF/RJQm3Y0MxIz1ykKnlVAKR2nLJtrmpBdzWlUh6XVD1fpq3TEumnVfTccFzVBhu/BqPpfb7Bi8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1VQK47XHlAW3YDhNPzAp6XGTLW3hTPifkBUN9LFibQ=;
 b=mz5F7wIMaC4p3hvxLBCwTfX4WV5gg+sT7ahOgTxAYL5pH5FC+NJV3OfHoNEhXn7dnI78lZK4HVNNlVBczQmMKL/3WmyU40/s3LJqpZxP9U8r2NsV1ve2mcbXZutnC/oZt/QavsC0qZr5Qgd+rgacQssw1+ZdMcg6fs7f06xDXT7vC3A9GdTJAlS0ABCHcrhWlEwFeZHmCDyVh1RKHHNuzYqJPLAcnEH7/3DzMIic/RRJOBLNKtXF+/7FhRMqBzEejzSslo/SC+W8ywFmYK/+N9esD6REBK0zFqiqOWogfCJxt+6zGgDHqVok2C+ciFXLlWBLAFo5UONdrbh/mdOJtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1VQK47XHlAW3YDhNPzAp6XGTLW3hTPifkBUN9LFibQ=;
 b=LjphcH5beKuzxcbZ4irqdWe3tjYSA2MZIJnB4qrUvACF9zbolx5rGUIBL4oyCLDYACY6qyafngDYh2iW0jRKRcHqzrgmXL20JlaB3/POK4DDHQR3kkswOVdgHLZnwDsXYWqRSFTHIHexdzi/Yt5T7/FeeFs+24UzD7Rrv0SY1Ks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB2937.namprd12.prod.outlook.com (2603:10b6:5:181::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Thu, 31 Mar
 2022 10:07:36 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06%5]) with mapi id 15.20.5102.023; Thu, 31 Mar 2022
 10:07:35 +0000
Message-ID: <5d93cb4b-0660-3efb-fae3-b1069e4a4db2@amd.com>
Date: Thu, 31 Mar 2022 15:37:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] amdgpu/pm: Enable sysfs nodes for pp_dpm_vclk and dclk
Content-Language: en-US
To: Marko Zekovic <Marko.Zekovic@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220328145425.4848-1-Marko.Zekovic@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220328145425.4848-1-Marko.Zekovic@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0155.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::25) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8776e312-9824-4116-665b-08da12fe4739
X-MS-TrafficTypeDiagnostic: DM6PR12MB2937:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2937CF62E24B0ADD9A702C4B97E19@DM6PR12MB2937.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHCLgKhlgNfRpGymQR2iwtjdoOJt7AwHR50U5iWXWpMhSnPXSCqERe6rEao06x9ciiiLIAnX02KHfHTEjqrnnoVbcD6kx8csA+/D18rlaXo9/10PjNqM6IDRXQ02qmZ1YvXp5MuGiTLe+02pYNG81zzQH9qDZUjmUWsUrXja4eZcJkezoNDu+V23yZmRYE3OWSH9TV6EST7zHJTm2BcnKSz3e/SbNrd9Cid75ApZpvO9U+lKSeM3TOg2ulVK/HWGph8i2vA3o/PMAuSJlbC2P4a/L/JrCg6bv6XDdwNi/jLtkU3kaiwugUA1KYUjxMsbVFzFqfef/iMEcHoXZpf4SLn2mCgdrtugcWHT10wOFR76WaVMQEQyuwsiUBwTxBa3jQpiP9GY3+SkfoRTUPMS89eA5b+iZcQi/shjGQSJ8/huTAkHNbGoSEHAM4Xcr41D5EgYFQmlxx1SrrwBLmUDdGXLzBF6S/gpv7IuazM97k5Qwe1fbWVQ4CpR2YNozMoDcB1R7bn2VK1PWJsTzdfu3i9cKrm2qkencx4UPxZ8GhvI41fwU0u0qaRaEeYELz44Ig4Gf5Oml6HEyMyXtRSWewkGgpqL4HOdPxh+vVrA+MUaCPXTQkLYxh9yZ+cUyhUhdK8puKZH0qyIUo0+RNtEytXJr825IzP+hY4V2oS9ilf/CvEl9LkTYN6AlqWwvilH6EocEJZKvllroqjuZgddqqeT+2nm8x55ZNUzOMRSpDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(316002)(83380400001)(2906002)(26005)(186003)(2616005)(508600001)(36756003)(31696002)(66556008)(6486002)(86362001)(5660300002)(53546011)(66476007)(6666004)(6512007)(6506007)(8936002)(38100700002)(66946007)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0NUWGlPQzBJVzloUTF1NmVJL2IyU01JS1QxNEtyM0hBV0JwdUhkR2JJc1h5?=
 =?utf-8?B?Q20wWU41L1dINmF6RUl5U0tKd3k2K29vb2ljRVczOUlBUWJZVkFRemlQRnhm?=
 =?utf-8?B?Q051MEg0dCtzT0JhekxGbXNFWDVMNXRKeTRRekZIbUNkeEttYmhSQXg0KytB?=
 =?utf-8?B?NXlXbE9MYTJXalBMZkJCbk1LdXN5enhTTVE5S0RIMEdvK1NKY1ZEUi9QWENF?=
 =?utf-8?B?LzdSS2hIWXdUd0hnZ1NxUVJLM1JPZGFJS0xjMFIwNW5LamhtNTR6WTZPYUR3?=
 =?utf-8?B?NEtrWHhCR1YxZGw1QnEzeHM2ZVJtNUt4UmFzWitwSWwzb0s1d3U0cmVCVWtN?=
 =?utf-8?B?VU9IbUI4ejNUSGFaVXFDK1pXVmVMaFpuOG1EbEt6aGVUNkdXQk5ocEliSmVx?=
 =?utf-8?B?UitvYUFXRFpBSk4ySHZPVy90Vjk5SjcvVE4wWkZTZlRUSHVYbGZLWk54ZGhY?=
 =?utf-8?B?YWFkSXZudEE1c0w5S1dBZzVRaWZ1bjZqWWhNY3RZcEc0Mm4rd2c5Sm5WYVdk?=
 =?utf-8?B?WURBRUZXcWhiSVRtcllGeU9zbjFQdXlidzczYlNocURjUTdIMXhJSlRqb3g5?=
 =?utf-8?B?Q3lGcWZuMXYvcjBGNEROaXR3YTl0STJTR1UxYmJWcFVTcmZqVnBNdXZKRzYy?=
 =?utf-8?B?ZnR5dDVzWnJqN1N5UWVxNHlXTWd0MjBNaUlHVWlNelREYUt4WjNGL0plWmVQ?=
 =?utf-8?B?MmJUSm1CVGxaZWpjMFlQb2hDUHkrUG5mR2FvaFVEMjFNNWVyRWgrYXlPUnVa?=
 =?utf-8?B?dE5pRW9pWU1zZkIxdE5xYWdSUXR4V1ZzL21VVVF4NWlRVTBEUDdNbzEyS0pK?=
 =?utf-8?B?UTJDUkJLWWZQRVJrOTVoYjREVGhKMVhQZnF6TXdCSXY5SWd0Y0RyZVJyNGRG?=
 =?utf-8?B?QjRvNXhabUY3TEM4ZHhNYkFRbUFuVlBJb2I0T2o1N0szV3B2QWJVMzd0TEZG?=
 =?utf-8?B?eFdWL0ZEWVdrUXFSaUVlc0RPQkFSelBHQkp2ZGtJWm9BTC91d0c5RjBhdFhG?=
 =?utf-8?B?YXlIVWhSRUtZNHZrWHlZSzVFMzNYMUhMT0lFcXhOYUNva3IyN2ZhVFdubmc4?=
 =?utf-8?B?cnJBN09TNVVxTFJyRHowVmpSMjN1ZlJqbjFNUGtCL1dSUm56RzBtK3dsTUk2?=
 =?utf-8?B?dVpzeHRsZUpjZVQyUjZNdGFFOGdzWk05UmNybG1uelJvaWVvMUlxUmNDbHNV?=
 =?utf-8?B?dTJld0d6K2ZTWnIrdkhlV1Fya1lkeUlYb1FuT1ozQ3I4V2hUQm1ha1pTV1p3?=
 =?utf-8?B?OTRsbjkxQnBtc3F3ODVaZGhlZGRZdnYxOWFVMkJJbm9KQzZrOGZwMHB1emVw?=
 =?utf-8?B?a2c4N0ZYOEtoeG9vZzhTUlVqTm5HeXZKMlVXU2w0bXl3RWZSNE9TazM2Sng0?=
 =?utf-8?B?Zk5LeEU4Vnl6MEZ3ajR0VlJDK3hnMTBxb0hsSXBJV2piZlpsNVdzY0hvZzJ2?=
 =?utf-8?B?dWxhU1llbmxxYWxKWk5iTzZDckVtZzUydFUyZE5zQlliYlFQb2hqZTRLdWIw?=
 =?utf-8?B?Q05ObWpaaW5TTXhnbmZHUGNyaE1sZU9PRFBNS3JkUmdCbGc3OXhqT08vVkto?=
 =?utf-8?B?RU9hcGVISEdGaERtd20zVHlYWG1lSzV4Zi9YeVAyVWpxcXN1ajdqcWFDTUlY?=
 =?utf-8?B?R0ZSTUplSEtwOHNCRXVqVXdoZTdCQ2lQamtrSzhFeVFYNU42TUJLNFd0OXNC?=
 =?utf-8?B?UHR2MWk3Q05aMHlvZ3EwQXVzd1NmajJJdytZdUovODE0d1lPME54R2kzclBI?=
 =?utf-8?B?VkMySzE3dWFYaE12Zks4bTFXZGY0b05QeGJxb2tFZlQwWXEzQ3RpOXpFOUl5?=
 =?utf-8?B?Y29PMzlZbUF5TEN2cXgvdWxEaVVyVzRuS3BMbEN1L0Q0UjRDb3M5THdEa0d0?=
 =?utf-8?B?cmVQd3JpMER2M05ndnVDK3UzUFJuMEZSc1h4K0hIbjc4UlRTRHo2UzNGUk80?=
 =?utf-8?B?S3FQQnRRQVFuYnRaZUN3N3A2ZUVhaXpwOTgyK2JBazlQZ3B4ZE9jbFVmaXc5?=
 =?utf-8?B?RTBtSTdCbFNGTUFaSWowb3BMU0NwYmpmMmliVXJJVXRXNmJadWFqd01Cd1pt?=
 =?utf-8?B?ODNPdzNBcFY0WGpPaXQrVXhRVHBDcFR6SkY2U2lwTHQ1OHpDZ2FkRmpPTHI2?=
 =?utf-8?B?YkhkZ3ZSMldhamhJTmh5T1VYSFBpeDc0eU82bCtxQjJUWk1HbUJwcHpCQkNu?=
 =?utf-8?B?MzBRa08rL0ZCN1lVU0NBSGdjWUF1QTEwb0oxeGl2Tm9iRkduaWVUcTlaMEtz?=
 =?utf-8?B?OWtQTXlHSmhWYlVUYUdZcFZMNHRsZzZSOTZnQmM2Y1NrZFMxcXE3TkcyMVNB?=
 =?utf-8?B?ck9mcnV6aHk4QTRZREhVcWxYbUY4L0c3bTh1U0huZmd4djdrUmdiZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8776e312-9824-4116-665b-08da12fe4739
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 10:07:35.5720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ft9OOFA7/RfhGpXZA/6Dfll/DqpYIsIc+WEiMCekXaB+6QuqmWvdTOQKvWoYKk2H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2937
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



On 3/28/2022 8:24 PM, Marko Zekovic wrote:
> SMI clock measure API is failing on NAVI12, because
> sysfs node for pp_dpm_vclk is not existing. Enable
> sysfs node for pp_dpm_vclk.
> 
> v2: Also enable sysfs node for pp_dpm_dclk.
> 
> Signed-off-by: Marko Zekovic <Marko.Zekovic@amd.com>

If it's meant to be only for reading clock levels, make sure to change 
the attribute mode as well.

With that addressed,

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Change-Id: I240fa055600bfc0d46dfec374339ba61764f9ab2
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 9ce597ded31db..a6747ebf7e569 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2001,11 +2001,13 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>   			*states = ATTR_STATE_UNSUPPORTED;
>   	} else if (DEVICE_ATTR_IS(pp_dpm_vclk)) {
>   		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
> -		      gc_ver == IP_VERSION(10, 3, 0)))
> +		      gc_ver == IP_VERSION(10, 3, 0) ||
> +		      gc_ver == IP_VERSION(10, 1, 2)))
>   			*states = ATTR_STATE_UNSUPPORTED;
>   	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
>   		if (!(gc_ver == IP_VERSION(10, 3, 1) ||
> -		      gc_ver == IP_VERSION(10, 3, 0)))
> +		      gc_ver == IP_VERSION(10, 3, 0) ||
> +		      gc_ver == IP_VERSION(10, 1, 2)))
>   			*states = ATTR_STATE_UNSUPPORTED;
>   	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
>   		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
> 
