Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1418C77B7A
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 15:00:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95E1310E36C;
	Tue,  6 Jun 2023 15:00:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E50A810E36C
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 15:00:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFkb4tJ5DihjVxr4JD2oc8sJAmvy9zyrx7h5aUE822pdXgjGzX4Qdf8HQPhuNdclYM3Hq+MnxI8ZIaRHvVm54PgTXedVFGC56mRcEgpJLM3wl4BpQKIj0pGUF8JXZq7p5TV+JPe/1kK9zpmrjgORth8HLZkJsxPZ6HZutRkrTw7xbhNoezzxHQnGsOE+zxn8gJ0MceJ+YqekiExZ85xcS+JuVHVWdgZoC82MDv65zT/dLNEVEXtLTTOVxdQlLXnnHe9I02Po8dazhaa1ZYhG/w2cay+zYPUs2fKgN4J9maLxu045CG+S1mOoeReYvwF8p1LyfMigaKjAiSCpTytC7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vuqsnbsB6DB/MwqOjYOzyLLDlg00IJ1hUlTf0hUdow=;
 b=a704cj/a7u5tEPVf/CoEopwo7fqhh6SKU0aC01QMlSWfzWEcrh5t5xZD8UlQ/GpyuE48nOPRXRFlCarOX7cEK01Eh+IiQGjut6RBuJNrLLlkT0euaK5baeAnDVmBZIIdel2CFaKwpIZIZCxhdCEMLDyM1+ANGnLCVQ08CBd/maPmMXlZ3mZ6I4gP8LixqaEtCRbiEN4bLFmOgSB8qbLlXH4UBU7hzNEdUW1RPOrFCzA+lOIkO1I38HHMSh/aXOe2WcMnixZtu4I6uZT8hr5/z37FVvXX7+5qmPaVaS58cI6qguvRDwJnfzDjV5CoJlnNpJXRN1t7EGdHUUsthPYpUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vuqsnbsB6DB/MwqOjYOzyLLDlg00IJ1hUlTf0hUdow=;
 b=G7tcUDxciVUmTBOK9V1G9zuFAZfFM2S4Tr/Pu0f6s/qjIHWgy6jBJS/kqNqNQ8ilwZB1zznZXNV4Yi7gaTJxzq2Qcbx1RqMi/AghH3QiGlqjUVc+ceJ9MOLD29TMTwzwQX92sJIaTk4X0Ezs3ElrEWfXoItip6vmwkRGx8R+n6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 BN9PR12MB5116.namprd12.prod.outlook.com (2603:10b6:408:119::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 15:00:07 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1%7]) with mapi id 15.20.6433.024; Tue, 6 Jun 2023
 15:00:07 +0000
Message-ID: <74ab4d77-9bcd-603d-67bf-5920611c3b35@amd.com>
Date: Tue, 6 Jun 2023 11:00:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd/display: Fix guarding of 'if
 (dc->debug.visual_confirm)'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Stylon Wang <stylon.wang@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Jun Lei <jun.lei@amd.com>
References: <20230606123518.2636457-1-srinivasan.shanmugam@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230606123518.2636457-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::27) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|BN9PR12MB5116:EE_
X-MS-Office365-Filtering-Correlation-Id: 497868e8-7b0d-4109-41d9-08db669eb769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eq3D/gIlKac2s4Bwp/Jyr9pPGwhHdYOoTGSSVOBNUs4h5PAt87kLfJA4+hkdM389VVGXnyCr2IdLjJVLp7bjN+JDVZQOMYYYA2Ba29lcw5hYdHM7UvDusoYBOEGkkdugZm2OqFJ5bFByGtarc/HQLID9ujp0O8lg3XQX/+Kq+56MUl+cRN+a2Z/7frbembAe9LaH4Us7kfo8ElkTM4NI3djG9jGmxsUd0V8cSt7hymCzwqvxKnLM2MY15rfadrmn8UQ1+G+dA8Z4QlhS7wOm9gdop6M75e5HoiWh8SPqGxpyDq4mTacj9qvEg8Ue4HxvbCs/FSi+m1NzgoCm0ZPNHC7iifS2al651k1nbGsFxIlpoDGhHJVD+ovFQ4cYKEVu2Iwz3fuJ/RzJKbxUCeObilv+qCtjkx2pQTFp2gMq4BL/7nwAZKtxMzFseq20JfDozNzKzRjqyAQnfXphXytBdPtClcnzdT93EagnIY11xRigIRVnd/etVpeyD6wqcgH0ZX8W0mVD3ayBehbMBT8e0Oqr/1436MVhuDgxs0S0jytZ5TnsntEZvBK+p+cXjzVKt0DQYJQkmQprPnORewmXPTyuRXVb7ZhcTy3AzMoOxZppwIuYTSViwBRtX9gt05xhIgreqj79sm8S5P/ocnOrUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(86362001)(83380400001)(110136005)(6636002)(4326008)(38100700002)(66556008)(66946007)(66476007)(6666004)(6486002)(478600001)(2906002)(186003)(36756003)(2616005)(8936002)(41300700001)(8676002)(316002)(5660300002)(31696002)(44832011)(31686004)(26005)(53546011)(6512007)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjhTTW91Y0xNOWJBMnBrRW1TMHdGTEllQmxNejhyNGtnMVk4UzZvdjkwS1Rn?=
 =?utf-8?B?cDJ0UnlZK29ncjBpWTFxVEpqR3hXYnNGdFBnN0xIcVlhTkUyRUphYUV6YUIr?=
 =?utf-8?B?cE93VjJXQmtnWGN6YTNWaUg0cDBKeCtNTkIwaUFNNUhJWWM1ZEh1L2Y4cjda?=
 =?utf-8?B?eGljL29DWWxBeHJDTCtWOTA5ZGRkVENTS1B5eTQ4T3lxTy92YXJsVnRXb3d6?=
 =?utf-8?B?SWdaVVJYYmVCaHkvQ1FGYS9xQ1ZLYkJGaFlyb1dWRG8yKzI1R3JicnRuNTVW?=
 =?utf-8?B?RGpzY2ZIRE5PbEVNRWROVmlnR0lQM29xb0NTSjh0THJzR0xiVzBEbmNPdGg4?=
 =?utf-8?B?cVh0OVl2czZUckZ5eThFamxONTAra0FxeUwyMmJpL3duQWZtNXkyRlk0SEJO?=
 =?utf-8?B?bkgxUG4xUEFnZTNBeDJBOHFIOGRqSmlZTVUrTUl6eXI5S2xiQzR3ZjdScVU1?=
 =?utf-8?B?WGNpSDFiYXBTQVhyM21IQUNIZkc3d3k2enloVWdNZUhGd2xob0tjMW4zdWxk?=
 =?utf-8?B?dzhSVkhwbFF0SUtEclFXRnQvRlIyNlZxMzYyQUJBZnA2aVVTeitZUjJKb25n?=
 =?utf-8?B?WVVSQzQ5VmZ5RUhLejN2SFc4dFYvdXlyTUZkc3ZFeGlaNk5KSUFpalY4bWQ0?=
 =?utf-8?B?aWtqVlhFK28rb0FLa1F2Z0YxelZvK3V4clRGS1FGVSt1RXNOMnJSdk4xcklo?=
 =?utf-8?B?L3ZLYlBRZXBmVFF5M1NVaW5vU3ZyK0dBQ2lCTlg1TEc1R0UzbkJaTVFMZ0tP?=
 =?utf-8?B?bjdXbnF1bCt3NTJ6OWRDdDFaTW8vOHk0S1dZWWdtTUErSitJenhsRVNPaVFm?=
 =?utf-8?B?eDJ5b3FCa0pWOS81aGZmMm9obWJSOWpycXg4MTNWazJ4bzNLSGFLb1Blc0du?=
 =?utf-8?B?MmJieWpsWGJLZHRtVTgySHFtdG1TTUZPb3BPNGp1VEtVNDdNdkxCWHpVT1Fs?=
 =?utf-8?B?NWxnRHhNQklmTjB6Z2piM2JOd2d1YWE2dU9GdmtUSkJmVHV0Wk0xWUo5RXVB?=
 =?utf-8?B?Vys4QXUzTTJmV2VPbVEya0dwNkx2L2RyMytwS2hZT040LzNuRnJsd2RmdVRQ?=
 =?utf-8?B?WjNIckFDaTNUTzVNRldCWkJJU25BajZBaUtyK3VoTmJCQ1BpVGhWZHBGQ1Bi?=
 =?utf-8?B?bkNkMEJRT1hoRjNWc0h3dU4wWnV5c2ZvZXovUWg5bVprbkZnZTJEL1NtaEtF?=
 =?utf-8?B?NkxnN1h1QTNUS1hldC92cmRmbXl5Umx5TGtGYmxMam51Y216aTJITXl2R1NP?=
 =?utf-8?B?aERQdkV6NmdtMmdMNk1obXRpZXZZeVQ3VVl2NnJid0Jkb0g3UXdQRnhwbmZ0?=
 =?utf-8?B?SEI4VHZJTG1HM256cU9Sb0cyMEdCMTlQMVk3NlVjOWNDSUh4UTFuVkV0dUVk?=
 =?utf-8?B?U0xZaEsyQ2VoTnhhRVA0WEdUeU5Fd2EyWXZvSmFEdzc1S09KY1lCU3pMcUVH?=
 =?utf-8?B?aE5vd2ZCOWlvQTFtVEo3aTgxSStZKzNPK3RCMVA3RE5ud2pWTWkwVUJSNzZW?=
 =?utf-8?B?a2RYclF5TFlqVWhHUmZUSlhQMEZrVVBRL0thM1YrbHBOb0JpVkZ1ekhsN2FW?=
 =?utf-8?B?ZkdEODVsVXU0blplUXZYMzg3L3hYaTJyd28yUkdZQ1NyeElVYTA4VDVUSG5B?=
 =?utf-8?B?V0cya3lJUThJa3lxSVJyU0phOEM4VXVWcnl4bFNuUmVFd2tqbVRuUmtDbW9T?=
 =?utf-8?B?L1NpTCt1K0tUZ3UzZ2VjbG9rV1ZIVFRUdm9Zem4wY2hneWRqZmkzcWNQRWps?=
 =?utf-8?B?bm43a2hFOXQzcjNTeC9JWkh5Y0c5NFpyTDZDR3R1cFJFenE2MC9pbjZXMDFq?=
 =?utf-8?B?V3NhMEZPV3NMKzQyVjVBQzlVMGVGNFl2dE9NY2hGN2VtSUo2bjdDR05UMHNQ?=
 =?utf-8?B?RC95SUozanZQT0JCaXZYVkZXMzJneis1U21GRzdVdnFiU0pXYlMrUmhOdHli?=
 =?utf-8?B?eEdKOGxTaFpWWG5HeEwrSHJVTEFNazhDR3gza0xRR3ZoOFkyR2VMZGIzK1Jn?=
 =?utf-8?B?MUIydTc3UThPbmVHdnUzOW40a2ExN2xqM0kyWW9LeGcvZjBkUnlHZ1JKUjRL?=
 =?utf-8?B?UUNwNE95ZU5uTEwrZmJtUmczYnhUaWx3OWZReEl1SU5WRjlhMnk2NVJ2NUZE?=
 =?utf-8?Q?LumHS6VOQZmbjSfl/eJJytdn3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 497868e8-7b0d-4109-41d9-08db669eb769
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 15:00:07.2258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EoyNMiaVxIKgbkWa4/K7vEJdLEICTchtiHcvPiZdh/e5oJi0AkU/+Kam9ZlQ0ERSqLnV2pShJ9p5P6H1/mMXGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5116
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 6/6/23 08:35, Srinivasan Shanmugam wrote:
> Presumably the author intended to guard both the for loops with
> condition 'dc->res_pool->pipe_count' & 'surface_count' under 'if
> (dc->debug.visual_confirm)' so that's what I'm changing the code to.
> Hopefully to do the right thing.
> 
> Fixes the below compilation error:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3546:3: error: misleading indentation; statement is not part of the previous 'if' [-Werror,-Wmisleading-indentation]
>                  for (i = 0; i < surface_count; i++) {
>                  ^
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3538:2: note: previous statement is here
>          if (dc->debug.visual_confirm)
>          ^
> 
> 'Fixes: 25e1a6115fc2e ("drm/amd/display: Refactor fast update to use new
> HWSS build sequence")'
> Cc: Stylon Wang <stylon.wang@amd.com>
> Cc: Alvin Lee <alvin.lee2@amd.com>
> Cc: Jun Lei <jun.lei@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

NACK, only the for loop towards the top of patch should be contained
within the if statement. The rest of the lines should have their
indentation fixed, see commit d118b28aefcb ("drm/amd/display: Clean FPGA
code in dc") for context.

> ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 5e18fc0c79d6..abab9ae5e07c 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3534,7 +3534,7 @@ static void commit_planes_for_stream_fast(struct dc *dc,
>   		}
>   	}
>   
> -	if (dc->debug.visual_confirm)
> +	if (dc->debug.visual_confirm) {
>   		for (i = 0; i < dc->res_pool->pipe_count; i++) {
>   			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
>   
> @@ -3560,6 +3560,8 @@ static void commit_planes_for_stream_fast(struct dc *dc,
>   				}
>   			}
>   		}
> +	}
> +
>   	build_dmub_cmd_list(dc,
>   			srf_updates,
>   			surface_count,
-- 
Hamza

