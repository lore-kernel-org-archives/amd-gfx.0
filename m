Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DB0C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 11:32:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A6A510F2D1;
	Tue, 25 Jan 2022 11:32:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E59210F2D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 11:32:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxeXSM2RCJeInhCiZweVwWsAe5QMH6X3Lcfh6m4GdDiDJFVrlukQsLDfeHThPb5IIg5FHGV5FTHuAU/Dmi0aaLlX+CoqBizcexYT4ndowhVPrHyB/omsm9mN8DM8Z7DLgNJ805PwbfZ+OfIOxI+ATakOIeWyU7ZPNbuHDi0S/aAeihrcvwS66KDeQ9nXLBjc91BsFLxBqNu7zQQX/qClbLOyGjq/Pyu9KZiNif3phhrxct9TpnE5GRUGztSZXblwXQ99H0vTWQ70ZccEOJuGG1iFyZgbkMaIVe5wgN9kIk1nade/HUca0nMlSJpwDChFlevEC+KOI/ZZV13RGiMeIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6AKt9sfi+4bvnU69vBiE7PtnM8O7AJBdZ3UUnxi/Co=;
 b=jlYiEyjEVPjg7Z2G/Cb+fI5x8WVGq4KBM/XScWG1kXm2pkWoVvYDvNIidFXF2jRWY05yia/32FA/pO+wgzywHg0AHQfS7S0pbBmqnr1osfv9XYg+7Zs+HSkYzpBGEGXuspCxhasZZZAZNtgbAnJXLdqhKJiQrsZRuVr1HC9h4M3oLdWuGQ1smICLUNeEJVhGTTaUHBLeHy82gKZQBWsn/o0X1Budfl1345DWcJ9gWtnGoWiPXMhVry1JVdMVJycUmI3z1C7jH+zMOv7FIs++Nd7AzC1CkUycNeBR8ZZ9HQoPlCROkAvFAHT2vxnuKbz1w6B0XR/AVCyy1rWoah5gHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6AKt9sfi+4bvnU69vBiE7PtnM8O7AJBdZ3UUnxi/Co=;
 b=TMNsYTMG4gnX6TSxQw9Z3tlvFzsH5hxNpFUR+UlTGuDzxGP4636R+VRkdMGjpZN1EJAnN4SH1u4w55ztIoeRPCUcpsXm20Vv7IV8ggmCPxNj18WazQ+v47UkVEwV2EDouH/RDC8naB3027bcHvLDFetl81kJfedBC0TPauvxumU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CY4PR1201MB0167.namprd12.prod.outlook.com (2603:10b6:910:22::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Tue, 25 Jan
 2022 11:32:39 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b%4]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 11:32:39 +0000
Message-ID: <36b699d7-b7c4-21cf-93ee-47f4f33190df@amd.com>
Date: Tue, 25 Jan 2022 17:02:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] drm/amdgpu/display: use msleep rather than udelay for
 long delays
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220120180429.616236-1-alexander.deucher@amd.com>
 <20220120180429.616236-2-alexander.deucher@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220120180429.616236-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::30) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67cafde7-564f-45e8-9191-08d9dff664a1
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0167:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01673959FDE3E8BE717432D7975F9@CY4PR1201MB0167.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vhQk94Wwc7kc3QPDdpS769zRnguX23KeqyNgKhdbKgphdlDUz4RH9E19deiGK5hjxQnQZUNUfj40FHt57aHbFkzqBEz1vUWK2nLI4N9tpMYhoIoVZnZjAGZQk1RCEStnBuiOXXsdtsihc500PB28+8GmwcnGtTHfYVHp/49DKNM/KZfBI9fKhfA7mo+i2z6+d9iFkCqr2EjS0kYovuwh/RMgBqhn8yWVwdt/NFU9oNvjIg2RQIERCjbt7cQz7NAsT1vaBQhVkGwyPdwQov7aEpjbklcmzBiQuRGg9oiDREFvkb+kq68HxmBlqVAS+ACayvYAXIR6lc1bl/BUIGFrm73v4yAGzaObGjf7uB+C5rqtyX4lTHllpfXJJbtw/gCGnV+0o1QPqq/uXik/MiWrCs3H0DmubWcZyXlT66Kw3zB+qjcOtcnRVPaYvztOIs5+zc3klm0/adsyFoWCSmZa8KivvD+W3XMls7/Yp03Cc8+LiBwm1dgiTUaTercvSpvgJ83OG6Vw0gITvL6SMu4FEFonFpQzohxQHy9krw0iHLJlKeaEiq5+llBCpk/fzjShPTR+DrTZp2DCK6mkVE9oI/Q02MGR2OH4zAnSHVH6epfSKcX8j3h4yh7lI6s+3jHIW0mzUlgNuZLd835geggBpFTyYn5BlQrTgRK2VLO57ZCyVuJdgIgnfuRftl/XkWb28dQXdCjoB239oy0KAfVsbY2lNVshrIMGCAJTmqB4P0S9F4AQ/YYC9Isoi7f7vGcV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(86362001)(6512007)(186003)(6666004)(31696002)(6506007)(53546011)(31686004)(66476007)(508600001)(316002)(38100700002)(6486002)(66556008)(83380400001)(8936002)(8676002)(36756003)(2906002)(2616005)(26005)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2FHVzBmckFOclBSTEdVc3NrSExpZ3FhdnFOZTR0djg4YXduTVV5MC8wSTRN?=
 =?utf-8?B?cHpFN1pieWRqRHlQSVE3cm0rbEtzTE5VdFdZb2RyV0MxeERPejZJMExDcFgw?=
 =?utf-8?B?UzJsZkM4a3FOS0libGdOUEVKdHZVcjg4c210ZkVnUm9iOTdlNU5qMDZUYVdx?=
 =?utf-8?B?aHRaUXo2bzhhN0RTSEN4OS9CbldPVTZxdDFUOXorcXA2ZUlVTjFwUDZqaCta?=
 =?utf-8?B?V0pvcG8vK1kyZ1hSV2Y1K1pJd3E3L0pnREJneG5Kc0MrQ2JRL2lMRE5hVTNT?=
 =?utf-8?B?czFGMmlLME5jTThpZHZqdjcwZG5xMnJON0pLVEx1YjFHY0dzMXUzYlVlSC9P?=
 =?utf-8?B?UEp3azV1MHF0b1I0UXNROEZtUCtBY3ZnWFczT3dEcXpEMFVLUk0wTFpuZ2t3?=
 =?utf-8?B?Y2o2bngzYjFoanRuSVJkcjdacTkveWhHTmZqSm1ZWlN6Zm9oMzVsakJWa09y?=
 =?utf-8?B?ZVVnbm1KNGZqNjVOQlkvd3A3ckdsQWpPZjZNSW9GYlAwUjZ0STl5UHNqUVZH?=
 =?utf-8?B?NDlwRndZSk81eGlKVzB0RlZRQ2huRlZNVHQzdGVKMnJoQlArazlWNTl3YzNV?=
 =?utf-8?B?SUZSSG5ZVVVUc3VYcis2RS9vN1grb2FrTW9ZT3ZCbytzcDYxTkMreC9obXls?=
 =?utf-8?B?Wm1qOU5pSW8rZXR3NnNPY0djZUQ5S1RQN2VoK1RwZXpYTWUraHpwSE0rRUdQ?=
 =?utf-8?B?OUk3WmlJcUZqWnBiMzEwekFCb1VOdStETU5mRDgwMWFNY1NHdTJGa080MUNN?=
 =?utf-8?B?ZThwSkRqUVhpRElhMEJXUC9mb2JtTTVUOXdDZXZqcE9HdENVWHVDMmJwOXBN?=
 =?utf-8?B?cVpTRVBsMDk4SEtCUytFbzQ5Z21OS0VHUlZKaVl3MENUVkxkRU56QXFjeVQy?=
 =?utf-8?B?REFPZi92MGZQb2VhUFphSGVaWHh4Z2w4MUtOTnhGd1kvazdwcWR5dE5nZ29j?=
 =?utf-8?B?b1BKMmNORnJMVWE5bzJBcUhmMTlIdVp6U3VOS0Zab3BjM2pXOU4ycTlWdUNN?=
 =?utf-8?B?Q0xGbXNkM29SZlVUY1B2dFdRaDZWWmVYVk5oMWllSXJxbkVwcUgwaEF6TlJx?=
 =?utf-8?B?cVlrZlpuZ2JpU2RqY3hHdktDYk5KZUJSSDJQTndncXRJbmp4TC9CVDgxS1FX?=
 =?utf-8?B?SmRzV0VrRXN6SDlVaXlaNXArL0dWKy91MG9qWlE1ZDdrMk9vN2pvMXBHTDI3?=
 =?utf-8?B?SVFnZDFIQTkyc3JiRkdvWjV3bjcyTGhmMnJveVhWc3I2UnpORU11bC81UnFU?=
 =?utf-8?B?a3lPdVNJV0R6aGZldU8yNCtuUG5KZm1iR1FrWjdDUHNUb1lPUDFJRlNYZjlp?=
 =?utf-8?B?YmE2Q3d4K2UxME1yWGh2TGtKdjNzYURUOWo2d1JGY0ZpU000dnAyUWVDQ0dQ?=
 =?utf-8?B?UTFoZU9TNENOTjR3NHlXYzUzVFgrOGIvaThqY3hYVUU1YnF0ZmRzK0IyTDJI?=
 =?utf-8?B?dEgyY3BFUjlOOUNPMnU0QjlmalpOelk3Sm9UVDZLckxIREtlS1VrU2VHbWI3?=
 =?utf-8?B?NVR5THNqODhVNlE5RjZER0xLcGp2ZTVTcmNuZ3dNVEt6YjhYNHdVcVl1UDJY?=
 =?utf-8?B?ZjR0VUpwWGgxa2U4K21EeWpEWGloZGtGRDZNL2xHcG0yaFBZZEhkN0ViWCtY?=
 =?utf-8?B?WnJCa1Q2aFB2QjhsY1NjZFJ3NllSOVhqcFBhTEVxdGxKMUhMNHNxNk5vazFq?=
 =?utf-8?B?V3VGZWtONWVkNnRIMFB1TkplSVVYV0Z2SnhHbDlDMU02OUdaWnVDWXF5eHBJ?=
 =?utf-8?B?YUFkVmhLNXFkUTRWL1E0cU1nRzNUVnFmUFVNQ3VBaElaTW9QOFBtd29rSmp6?=
 =?utf-8?B?SzIyT1pqSStHZ3RxZVR2MWsxZVZ3Mi9QemsxNFYwWnhEUU92TG5IY29wU3px?=
 =?utf-8?B?dU1rYTRYaGN1Q0lIMFFJSHBJRWFsdFYvbUphbHJCZC9YMWVtZDhBVzlYZTlr?=
 =?utf-8?B?TStBenEvZC8zOEVaeDNnVzZaampOOHl5L0srcGNqd0UxMjZkN1IycmU0K1B1?=
 =?utf-8?B?NmpraDlZUXM2aURVbWcxZ0I4OVMwcjUwSVBSWGFOWjZsQk03cDJkTzRKWXE2?=
 =?utf-8?B?Wm5kZ1N2a0FLRG52VlpkVDVLVDJxUUljR29xdHczSUdDL2pCWG1jK016SXc2?=
 =?utf-8?Q?UTaY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67cafde7-564f-45e8-9191-08d9dff664a1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 11:32:39.7269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLBfqzZHi4w7qgNv1CPtf0kQkfXtjKrpkAb+tlsUPIFlviyW/siYQTD25727UO6M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0167
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



On 1/20/2022 11:34 PM, Alex Deucher wrote:
> Some architectures (e.g., ARM) throw an compilation error if the
> udelay is too long.  In general udelays of longer than 2000us are
> not recommended on any architecture.  Switch to msleep in these
> cases.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index aa1c67c3c386..eb4432dca761 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -6941,7 +6941,7 @@ bool dpcd_write_128b_132b_sst_payload_allocation_table(
>   			}
>   		}
>   		retries++;
> -		udelay(5000);
> +		msleep(5);

msleep is not recommended for sleeps < 20ms. The original code (modified 
in patch 1) seems to do such a check. As per kernel doc, if precision 
matters recommendation is to use usleep_range().

Thanks,
Lijo

>   	}
>   
>   	if (!result && retries == max_retries) {
> @@ -6993,7 +6993,7 @@ bool dpcd_poll_for_allocation_change_trigger(struct dc_link *link)
>   			break;
>   		}
>   
> -		udelay(5000);
> +		msleep(5);
>   	}
>   
>   	if (result == ACT_FAILED) {
> 
