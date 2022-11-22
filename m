Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB44C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 04:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46CFF10E032;
	Tue, 22 Nov 2022 04:28:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D29010E032
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 04:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vr/+vl7BTrrJ84bPcL0iGhT6DED830fAZhTLSvH0+vBXR33Z5a9X0f9QITgM/Zf0T4nm7x2TmR9G+xOcl6U1hgf+KRSQgXhCFEN6K3Aoqcd99t4y8GqCCj2CqOCdGQWAiBAgPYCqLyI8TKKre6StFHdU8uQIpfKj0u/5UdGcJoZ42WiEi4ImdJVTizwyPmK2i1WC75og+OAX07araSM7ixL+DaUjcInNnlohLHJS5P6A5v4MIe6zRfkVTX2c/PAMththwVgClonVkY1CaQ8Ei0aKxY1uGrtmQfbTGisqLE/9e5Uu1jRXf2MDdBbdIZHhybfcvl9ZuiCI/uzpKNA0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zni77+sK2jQYtB2hczfhFSNemQsaP87bGOdmh9q6BM8=;
 b=iBI7QHCnxnUs/qqu2vmUhiMRqYieEhRMicINm0THN02oUL4GCjSmn177AycXyuAUPNnp7gDGM+/Stp6YCgTdnWAm9pripwxxApDCW3TP7igRBvJpjEUWgV2NWGSAhCrghw2pnj6jl9CsCRFxiCi+MG4KW/YsHuTb1WjiEZxyE+7Yyb3cB8ytXg8vU921BFnzh3ETFXr/1y+kj7VgF+g+NGjL1xI0me41WiJ3Snc4dk02VL9B72+p3UG6l7/taaEp9DD7xjQ4K/HeVgOR8T5GQ6Axgx4QR2yctnPQpZEaxlJimBa/Loap/UywZ0cNz7mVOvdaM6nckVQVhvHCdPuyCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zni77+sK2jQYtB2hczfhFSNemQsaP87bGOdmh9q6BM8=;
 b=nrKV7KJNkcFlHaoYCaFvv+Tue/hXs0Lcyd7PvwTiQDV5/h3zDHcCUHNOH75H25WnL8tHOzfHUp5dSK3TTs6WoN2zQxMjzNpjKtSur/gyf+EM2iQxISVJ9RPKSFWmyGdvnsnaZODV1mQwUInj3peL4hDXoRUT/gWzPwJo1EDk4nA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 04:28:17 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5834.009; Tue, 22 Nov 2022
 04:28:17 +0000
Message-ID: <ef73c891-ceda-599f-6bca-bc05c6c20a63@amd.com>
Date: Mon, 21 Nov 2022 23:28:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] drm/amdgpu: add missing license to some files
Content-Language: en-CA
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221121172058.694436-1-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20221121172058.694436-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::15) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|BL1PR12MB5063:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bf52372-5dc9-43a8-c3ab-08dacc41fa65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UUsO93P07yKMJeCXH7yCzbhuSRCvaqtZLiJ+10EPIdkLJz2aOLFugW0hoI6PGsOyn6rBb2Vyoyp2vPM8wO9+JyBbwaCyknuyr+XlRk4/zIN5fhtU0R3FcK/N8AfjZZdMqux+/xqw2CG9t+VV7RpdkS7f2CQ7tt5e4yzBKsG8GfK/5yFwSTQtMOxbpPUl7Q2LOoHFaP8P+rNmRh5BPGXjsOBLu5a/Gf9vwlp7bcz+JuDWzjbBqLYUrqcH29c2J4Yemab2eCszI1FN0GaadZKp8HZ0xSQZBMkYWi4mbabuDs973AQJQtKs8KE1CvH5Faz6PqoPG+vhLBeo3HRoALeKi/TbBaxIUblRGu3QgfTL+9q51qUJCiubMHVpi8qTW2ZvIz8t0HZL73v6KjYrKTmXLopGcV+u4gvwWcT9sd1V4hslO541sheIiYZYx1iGUJZ3tstHo+eiELSMLW645Q3XyceDH6CdnjUOMCNq9R6c76c1lKuiabTt/7pnl4qySS0a23gGYpQOsJ+yMM+YvjZhjs35JoM/3KzmpTNjNApxYseV9CAAN1IJUKnXTBN5CAyKFIWGcs6wN4OAQfSUsqpmllRxTRhk9gV6j4XioAkq9KzdfIhbrRVCqQCi7rRcg35C6KulOeaq8h4cu5y00FEyhCt6HQhue6O3SxVf1lmg7U4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199015)(31686004)(36756003)(31696002)(86362001)(38100700002)(26005)(2616005)(186003)(44832011)(2906002)(6512007)(4001150100001)(8936002)(5660300002)(6486002)(6506007)(478600001)(966005)(53546011)(41300700001)(66476007)(316002)(66556008)(66946007)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1hpei9LeVZmUGkvMHY2b2VPdmFiYnIzR014Q29BeGNEYzdsMnlMMVlBSXhB?=
 =?utf-8?B?R0REdHlHOG0ra1NLbVVROERnWDlQVjNCa3ltRHBXM1Z6WURjT3MxeU03Um9T?=
 =?utf-8?B?V2ZPMmpRYm1Fd2daNTV6Q1JHQWVyelg5WFlaTVR2ZlhBUS96SWtaK2hEeVlN?=
 =?utf-8?B?ckRoNW1GcFpqUEtTTVNZdHFTUkluck8rN3dMdWtNM2c2VkR2ZzU4UHlsb29V?=
 =?utf-8?B?MER3ZWFhTHE3SVp5Ky9QMytYOVRwcVdVM1JFd2cvUEtQQ1F6UFRZUFYxTW9t?=
 =?utf-8?B?RUJ3QURCRjlBZDdISk4vemZLczJRZ0laNTk0S2MrbUJobklzVzRoVll5TjlH?=
 =?utf-8?B?SmFVcW5lVVorVFh1UEZGVE1KR0gxWWNiV25xZ2dacFNWWFNHWnJGTlg4YVk0?=
 =?utf-8?B?Rk5IaTlvYnNyMmMweUFkbE9FYXl5M3JuK0ZJaFNoRGpXWllqNWVzNmdDaCtB?=
 =?utf-8?B?OTdqdE5TYUVHbTk4Q2Mrd1p3NytPVmgraDQrUW9zY0E0ZVdpT3ZOcnMrVFVB?=
 =?utf-8?B?L242S3Q3bE80MDF2Q1l1WTgvMklJMmRsQVR2QzJxbE56MW9Nd05IOUhzUWRG?=
 =?utf-8?B?WXIvdEZQR0tWMEhadlE1Q1d4ZWNMaHlxMERGdTYyV2lzSGswc3liQVMyeS8v?=
 =?utf-8?B?azRqSzh5U3FlMWFxU2ErczhwTnJhbTZ3Q1Rrbi9BeEN6MFZ5K01BVytlMnMz?=
 =?utf-8?B?N241K1hNOFVYeStlWWgvVCt1b1c2bmdYYnVCSEhwc0g4RlduajZhOTNCQ3Qr?=
 =?utf-8?B?bjcvVDZFdTJLZHJXaS9OdE1HOWd2NmVEQTFjY3FtMU9hYzQ1MDM4ek9YaElz?=
 =?utf-8?B?ZW5oRi9LWGVEWkFobmt2MTRDSTJBTjFzbEdZUVRWZVAxOVYyQVRvaVV2WnJ1?=
 =?utf-8?B?SXp0SGZ4aHNSZ1JjejdYOTAzNHd6bzhIMWJ3SHQwUk93d1JONzJ5NTBNUXU2?=
 =?utf-8?B?b1JMUWpYUGNDdjN6SG5SaS9VKzVWUlFUMFpHRU9XU1V2ZXAwVTZ3aUViVGRl?=
 =?utf-8?B?cS9FS0lRTnFRVGhkY1U2dm9YQ1JWbjRCWXF3SUtkcERxWmNBYlBsc00zRjBN?=
 =?utf-8?B?UHhFOWRkRUd6Mzd4bTRUdzFSdjNjeXdWZHFVY2ZURHFVbHl2bjJJZm1PempS?=
 =?utf-8?B?a3BPSk5HRWJSSUZJTENrOWZiVzZnSzUrTzYyaTlLb010MjJxTC9YQjJJZys2?=
 =?utf-8?B?elpyNXMvTnNFcFBYZE1hOHVBQUZPdTJuTWQ2OHBBckR0UzVlcFZrSUxMM0xw?=
 =?utf-8?B?NmcrQ21VRVNvWmFDSDNSYTNlRDc1OHMzRkNxTU5XWVRoUFVCcklreHF0U3ZW?=
 =?utf-8?B?eTZ5c2ZFSU14dHovdUF2aWhtdVdNV0l4NGlLdjNmelBzUEpZQkppSkVXTlhQ?=
 =?utf-8?B?VVp0R0ZQd3V5RThpZ2VkWjYxN0k1cHhwSml5UWdWdy9yRmJLYWpWcng3My9T?=
 =?utf-8?B?c1ByaG1ROU5aZTNkTjNSeExOQ1VTNFVTQlBxa045R2ZVaG9Mdk9YTndZbXZC?=
 =?utf-8?B?SUdVdmJYZ1RScjRnQlZ5V0pNVFRrSXFRV1hRaG9Bbi9tamxGMkhMOGEya1A1?=
 =?utf-8?B?SC9QVnRLV3hEQWVkNlFsTFkxT0hwV2l6UVV0TTdwa3RCQ3JPeU9nb3Zzcm5G?=
 =?utf-8?B?NXVpQVJ1ZGlsOTVEQTIxYVg4b3BxTnBUaVdjaXZ5NnJObHpHQ0Y3YURwTkpD?=
 =?utf-8?B?QW5oUStNa3kvdGFQZTNKcHNNd2YrdEZ4cHRKUHV2TXUvQUdLT0RJZXFQTkJX?=
 =?utf-8?B?aFJjUnFBK29qZ1IxdEVCdnNKTngvS1lvVTdsWUo0VFFnOG9NV2h3N3Nlci9m?=
 =?utf-8?B?blNyT3E0alN2YXNPbDUzc1hLVTQ5R1d4S09aSFBkc0h6K1V5NjdlUlRWOHVI?=
 =?utf-8?B?ZWF1TU9VeWlTamFoeUpiVWFnL2pQSHQwb3pLMFZ5UVA3MTNkKysyMHBBVkhk?=
 =?utf-8?B?QzFLbTRHMnJRcGNUMnJwcUM4cyticzBoZWlkd2YxQ3lxVWE0TTAxaVpLZVoz?=
 =?utf-8?B?amRjdms2eFJtMU1hS1BOUlRTbDR4N1FlYTF4NGQ5anlvYlpFSC9FYXB3alRD?=
 =?utf-8?B?N1RaV04vQ1ZNOW9mSm5ZNXZXOUV6WVRHUHVaWHRJNS9WQWoycEtkQWRVQ00w?=
 =?utf-8?Q?m9eJSkPY125WfdAh8puPwqllk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf52372-5dc9-43a8-c3ab-08dacc41fa65
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 04:28:17.4291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJEGo0tIhT5qqKW/KF31BdNZV8btfv/y18JxiAdJA98/PiAXmc1I/YPjugFQ71uR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5063
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

Acked-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2022-11-21 12:20, Alex Deucher wrote:
> The driver is MIT, so add the licenses.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2265
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h | 1 +
>  .../gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h | 1 +
>  drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h      | 1 +
>  drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h     | 1 +
>  drivers/gpu/drm/amd/include/yellow_carp_offset.h                 | 1 +
>  5 files changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h
> index 8ea8ee57b39f..61bb1d86182e 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: MIT
>  // This is a stripped-down version of the smu11_driver_if.h file for the relevant DAL interfaces.
>  
>  #define SMU11_DRIVER_IF_VERSION 0x40
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h
> index d30fbbdd1792..d3d5a8caccf8 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: MIT
>  // This is a stripped-down version of the smu13_driver_if.h file for the relevant DAL interfaces.
>  
>  #define SMU13_DRIVER_IF_VERSION  0x18
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
> index 483769fb1736..537aee0536d3 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: MIT
>  #ifndef _dcn_3_0_0_OFFSET_HEADER
>  #define _dcn_3_0_0_OFFSET_HEADER
>  
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
> index b79be3a25a80..f9d90b098519 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: MIT
>  #ifndef _dcn_3_0_0_SH_MASK_HEADER
>  #define _dcn_3_0_0_SH_MASK_HEADER
>  
> diff --git a/drivers/gpu/drm/amd/include/yellow_carp_offset.h b/drivers/gpu/drm/amd/include/yellow_carp_offset.h
> index 28a56b56bcaf..0fea6a746611 100644
> --- a/drivers/gpu/drm/amd/include/yellow_carp_offset.h
> +++ b/drivers/gpu/drm/amd/include/yellow_carp_offset.h
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: MIT
>  #ifndef YELLOW_CARP_OFFSET_H
>  #define YELLOW_CARP_OFFSET_H
>  
