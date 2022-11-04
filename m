Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E947C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Nov 2022 16:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B129210E8C7;
	Fri,  4 Nov 2022 16:04:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F4B210E8C7
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Nov 2022 16:04:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYLKSttEaDlXkjfd/DZVXMZwtBeu4MrMq7T8zgttrRfBMK7hGxBuIngT1QS6QjmZhhe1SdIGZDOx0h71l0Km6V7HxxDRZwkCWmQfdVrMby/ndvipAyj2vvkyfzsC+M3UuO7B7sC1mwH/S0AyUMIidseNMuqVS0BwkOMx3NPdCnMUPhm2GUsLUgNDodZI0jmxBxzDENGs0hXBBuoaJoBTNmNVXQMMUs+NxoXSMvnCFWtta5An8l6BS67PfgSlCZtZd+BUfkb5xfK2BU88SIdFBvA+0zriHxqKoW6DkTH29JrYScWOEfhv5P1g5KFMDLqhLbwq2x5uFAk5vdT2sLE0hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHRws6wahjLvOn+q2tGIVhLFfU1kgBcdFR4rLyOkmSg=;
 b=RmBIhNap8saxe7BwqrdSh4Mp615a0xzXTTBc8YFbj31TXfIoErwHCi4je76ntYuP1rBWtm9jmRcr6Fdd0XM6o6sHtUvU0k2nY1vhh1KAXKlGNprO/ZEDb+vQyw1OiGjlku7mOMAMam/hUFB3ZtFwm0z5EarYARQCUSFbWwUgLJHCGxJurgVJ16ZeVhaN4sIwhbMfc5rXTEQrJ+gz+QWfoAz1HmWVKDDf5aPgjouZueB+EJS93dzsosYxwLuLen+l7pUjy0cO8dSGCvJAFEEXnzbSrVT8oj2xetln/l6rF+oQeYKODMTJA3ASrtXHgJqSeYSP4qql2lRpYK4LmWW9SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHRws6wahjLvOn+q2tGIVhLFfU1kgBcdFR4rLyOkmSg=;
 b=Knj1mGsis7fgeqE5WGiQYKRKsQtQX6HoQEc05+6+9CArutvL6Br5ggW2czJLUlzFkVY6W/oDINfnNPm1Fc0ll6sWPTXr4A5Ryh2bePvpILTAV8vwzyqfMZREk8c6ppvuIOolAfImhdTIQhulyvnR1FDsXo5sdx5NSxMl/UOOhUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 16:04:25 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 16:04:25 +0000
Message-ID: <fb7cef4b-bb22-f31e-9544-30543fa28abd@amd.com>
Date: Fri, 4 Nov 2022 17:04:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdgpu: Inherit coherence flags on dmabuf import
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221104154027.1019315-1-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221104154027.1019315-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SA0PR12MB4525:EE_
X-MS-Office365-Filtering-Correlation-Id: cefa37d3-d390-4c2c-304a-08dabe7e3e6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PnRQlGc4d7WcBuj8neF3rnIHqwhrcZdVCNnki81J5X+dLia3KY3y8nDY39a8/R4O6SwE53uSYSd4rKsgY5ETGJcligKeLLQawVOpwhoamXRSC6oVbYsLxq7KV1gCgbQOksWVsXIhkOMEHrN+XdeWXu0FaEMPf1dQyGFG/iFx8JYm7XLMTrxTgTtpJ3GvpqXC1184zH1p2T3NhzjAikI8TkJkaEWAfltFORcUVXJ69jsEBRddZ16ubq5pDXy/Iz2MBpzVPiTJyjnRDH9gVoNrSNOesJKCU/cz3Yg3dCGdeIcupSzv8Ty+5GpAvTynpDyiF1r64Jjaqu7vf9VrmpmrIVTeRyqO2UU1iHEHktYZyTtZEDu5vX5+FWcYeaM39lBqQ+FCiPnKcW1K5VIZ6EYFN0Y7xW8+PUIH2M2sHiiTZsOEJ0ZtdlP6pUV6G2E7QWf+q65t2mp+TgkkKwYZw1M73SyVccQniTTxh68V/vEL4cRFo+NRc4/pa3i7cM1tvllek5QCZzEs6ODag4xNXxbkzokPGqetCzAecCi/Mylge7EVhtulQ6SwjyVQKScC/DlK8/zJCHdPWyBK+oPbmFCti3YceQjWkeWHgD9IQ5tx8Wc+fYEPVAssuzrNFhsC5hzW5hPSvHDdNt00W7ZHCty57AxLW2XprO6nkDCsEZOKv/BW1mAfDYqXfGLsXLzcnTPopCMT6A/ZeTlhnpq0xZ4Leutk4wFweozMUsJ22cRWiSTXuKLSe3GmV7M5Y/rlDmzb26Ddsm0J/kvanlfQl9LzdibUzd3f5r+U3k2mhAU/rTQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199015)(66476007)(66556008)(4326008)(8676002)(66946007)(2616005)(316002)(2906002)(6666004)(38100700002)(66574015)(5660300002)(86362001)(6512007)(6506007)(6486002)(83380400001)(478600001)(31696002)(186003)(8936002)(41300700001)(31686004)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amxsdTdrY0VVeFpFSSs1SVh4b2pENnBLT05hRlZYdk9zWmJRTzJ3T0ZRVW02?=
 =?utf-8?B?ZmJ0YkQxcE5FMDU0UkwzNGd0KzNodE1UaEFLc0gvVGlSQVd6cDYwT0M0THdH?=
 =?utf-8?B?UmZjeGJDNnFWYTBPc2FLS20zK1RLemhmU3ZrYXR6bTZ0UDAzOW5nMW5UM1ZV?=
 =?utf-8?B?VU8wbERqaTNsWjFBbzE0M0F2T3hac2haTTlnK0ZSZUNkVTJ6WWNhdGh2VFJQ?=
 =?utf-8?B?cU10L1Foekh4K2poMTkraFpSbnkwdjdGU25SMXB5cUZKNDgxNlE4cDRqcHNu?=
 =?utf-8?B?cHJiZUJCbkpUME8zU0V0R1BZWVlkNHordEN1S3NnOE92SWVIaTAwNzF1QlBO?=
 =?utf-8?B?UGgxN1dhdWNJQ2dnMURzRG84SmVnTEREWmFscyt0VmUrRm51MXBlQ2RwWjhR?=
 =?utf-8?B?YjNjUmxLclJYbjRBdENqcVRNQlFHZEsycWYwUFgvUHVsR1dkOU5wblhLVVZN?=
 =?utf-8?B?OTlFSitMSFZ6dDZ6V3RSZjlkanQ1Zyt1eUppQ2ZPSFg0aWlsQ1V0Vm9yQUgx?=
 =?utf-8?B?dVhuT094TDlKbTlrejVzZHBpL09Qb2FuOEp3Sm8zK21KQnZVL1BMRVdmNEpi?=
 =?utf-8?B?ekEwR0pzUitqcjZzOE9DOE1Temx3cE12MVA2S3pDR2wwVWZiQUlkOXE1TUwr?=
 =?utf-8?B?UDJtbXdHUjZuVVBWbklQTnJ1bWRPMTRoS3lvUFYyT0xGRmNTdGRvSnAzYmw5?=
 =?utf-8?B?QVBMd1pLT2J4QnM4Z3BrOS9hVHZ1Z2ZTMmVDVzhKb1BIQ1FWc0VSVWZ4UERa?=
 =?utf-8?B?RUxvbDRva2NxSks4MDFtOHkxRXAwRVNxbXR4Q1ZucXNiTWhVS2dtb1lxRDdr?=
 =?utf-8?B?ajNsM3llcitLQ1hYam1uQnl6d2VCVEQ3Yk13aU5qeUU0QnNKSFNUeUszdmF4?=
 =?utf-8?B?alJ0aGNDcjVOY1FRSS9xenNtckI3M2VxK0Jtb1NDNTdpWm1FVXJuUDU1Mjhq?=
 =?utf-8?B?RXE3RWpGMmRyd3d2azlWcGFNclB1SDRMYnFHNzNWNmRVQUdNYi9XRkM3S3RY?=
 =?utf-8?B?a09nRkFCSWM5N29SRzJ4bk5PZWtVRUFqUVJBUXNiVUFaMEZqNTNnbGpwVkk3?=
 =?utf-8?B?ZVJjTEhNMVZxcEhWZmFTajJtT09sNStuR3Y5TDBaQ1lWUDVpTDh2SEZnTWF2?=
 =?utf-8?B?TVkrbGFDbGV1LzV3dGpGd3cvNnVDV2VDVjdpYkFLOUpZeURxL2xyTTZKN0Fr?=
 =?utf-8?B?bU56dngyWVZQOTVPd05TL3JYaVV1OS9xUDlYc1FEamdPUmZtTUpOaUs0dk5J?=
 =?utf-8?B?WjNEbUtKTjdZTi9hTzkydXZJMzlmOVQ5S29UbGx6WlpZQURXN053bmV0Vkk1?=
 =?utf-8?B?elVoais5ZExBaUVKUFYzSUtsZXFBRGlEaFhLU2dpaWRNb1JLSFRFQUtrL2pQ?=
 =?utf-8?B?bk5tcTZBbmdTMzdtOGtqcVZzSFJoeWttQWc1azJkcWd4dVJzdEV5Mm1xMFg5?=
 =?utf-8?B?eGZoQ2tzMmNvSTB0TXMyUUlTZ3R0aE5mQWw5K1ZjTCs0RFF6eGh0bTJDMjVG?=
 =?utf-8?B?WEt3UXlTWDg1VERwc3hGamNSV2RpYVJaOStOQ2VvbDJZOHVCT21Tc1czQUNP?=
 =?utf-8?B?YndYUmtLOFR2ejJuMGkyVEhsUHlpTHVtR1MxL09Md2VkZTlLdUk3ZzRnbzlu?=
 =?utf-8?B?c2dUOWF0WHhEK3ZDQ2kxc2pzeWJ2YW1wU3BWcVpsclBMOFNOeWlqTFlnWVpo?=
 =?utf-8?B?YU0zT3VwelZmNjVkOVJsUW9nbFVTdzZGQ2NEVmszU2oxeWJOeXkxTGNaWmRC?=
 =?utf-8?B?eWUvZko4MUZEbFlUV3BXN0hXL0pTUXZsZThsMWtHRDM0MTFZNWxkVlFieUVX?=
 =?utf-8?B?VWNNeGE5MXdSdWN4VGkzL3g3cjI2NmczMEhtVVhxakdibVQwMEpNL2svRG9I?=
 =?utf-8?B?YXYxQjlaeHo2MGRLUVN1U2VMZ0VIUW16MjlSUURvRW9vTVUza2U5eWZWZ3dq?=
 =?utf-8?B?QkhQYkFZQld0NjlIaEdMWU9lYmRzWjY0YXhSM3lBTkxrNlFlamlCd1g3ak81?=
 =?utf-8?B?bG9EQllxS1h5eTU0YnAzMjUyL3hvRkphUC9ybEp3ZzdQQjRaM0pSSTc4UWpx?=
 =?utf-8?B?TUkwR0pKVU0zNGZ2c1ZOOUZzSTI0TFJvNm5DL093MGg0SXp4T3l6TUM5VVQ4?=
 =?utf-8?B?U0JYYnoyMmtFcUNNSFdNdlgyY09wN2ZQQmJGT05EQkx3Smh6RXVQcUo1akZn?=
 =?utf-8?Q?fkhQWfp+wPzwXxDHL2oh2grZnc2OWH6w3qPkk5jcKKaM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefa37d3-d390-4c2c-304a-08dabe7e3e6c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 16:04:25.0968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mYCWsvfVZRby2Vd68ISYLicFGFLBP1qIzKepezR9ZLN/1wbpPqnaxued9A3g8/F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525
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
Cc: Gang Ba <Gang.Ba@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.11.22 um 16:40 schrieb Felix Kuehling:
> When importing dmabufs from other amdgpu devices, inherit the coherence
> flags from the exported BO. This ensures correct MTYPEs in the GPU PTEs
> for multi-GPU mappings of shared BOs.
>
> Fixes: 763fbebb20e1 ("drm/amdgpu: Set MTYPE in PTE based on BO flags")
> Tested-by: Gang Ba <Gang.Ba@amd.com>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 7bd8e33b14be..271e30e34d93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -328,7 +328,9 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
>   	if (dma_buf->ops == &amdgpu_dmabuf_ops) {
>   		struct amdgpu_bo *other = gem_to_amdgpu_bo(dma_buf->priv);
>   
> -		flags |= other->flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC;
> +		flags |= other->flags & (AMDGPU_GEM_CREATE_CPU_GTT_USWC |
> +					 AMDGPU_GEM_CREATE_COHERENT |
> +					 AMDGPU_GEM_CREATE_UNCACHED);
>   	}
>   
>   	ret = amdgpu_gem_object_create(adev, dma_buf->size, PAGE_SIZE,

