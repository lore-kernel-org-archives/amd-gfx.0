Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4136FC7EE25
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 13:21:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2ADE10E23A;
	Mon, 12 Jun 2023 13:21:05 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB55510E23A
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 13:21:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lc9a/Sm8d9NO87E6ybgEHgucaodof/q+l2mTVDGWuvSJg9yQkAHPaoUa4tsSXLlBlyFfO6vD+DGG98q4ouxjkJlG3FpQwrah8qrIeJhXRYrCP+BotDkeNhVf+jm28VBsUcOei0LCfH8pI9uOKS8FJp2ps1sGkXesI90cerC9InMOS4u7inPiLz5qgh6MsQmFc7w83hER9JmNPVPDnQhm+nAZhui8HImHZrtLOCu0JVym7ss7MjKJOwZ1uDenqowdrGceNmvUUre7w0bS+faCfJ7aj3g0cXewClGB5eoJ0BGSY69OO5DDfUqqdeOLPHpwRt88nOqrJtgV9fmVxfDpRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMkEzXRwvdVpj0iTOJ60RnwxR8Z4qUFj99RwbobrmpA=;
 b=BmgDAM5vD2yW9rYQY9cv9qxkuGUzU5+CavG9COgRwkKhnVJ4cDKhNSzpSswZLjVuMF0hdr/Gwp/UimcX+/XTyk3t4L13fhVqqnsksyiovQURkJ+xnPpjnRR81tf8pDZaGD0uVlRxMubNL6ixmybPZ1DU9kdrIHQ9JyExocgrytHIad7F+y/TbEqu2/I2ZGtz2UWz3ZUK22xbKUimDYYf1zNbPnAixsBdAxYBTgWMVO6ACr0d3SxNWhjmeXZWP3jkUqbkxuuBMOfbuRNiTzSMm8QTzo7GmDya1bzL398M2Dhcot2IJrTgp1QorltzvdIMJL8QIr4A97UA9xktOKjwjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMkEzXRwvdVpj0iTOJ60RnwxR8Z4qUFj99RwbobrmpA=;
 b=Hiq9dW4VG6sR5CIJ1hP/OBeyubF8MEhUP6h/jCwiklSB4UcipXDmUUszYJJomHN757NVBchEQv99gDjBHN4UhVNdGXohbxgYn8uyUQU3jlnUT9nRZdrr9KTXa5fsMk5qjyIhOONzGdfd7N2VTsV84TtHYqK/BE9H0WI9Et6SRsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by CH3PR12MB8902.namprd12.prod.outlook.com (2603:10b6:610:17d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Mon, 12 Jun
 2023 13:21:01 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::8c06:c9e:c6c2:3b16%5]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 13:21:01 +0000
Message-ID: <e29b6744-d7b5-f933-0db8-c84841e687b8@amd.com>
Date: Mon, 12 Jun 2023 07:20:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd/display: Correct and remove excess function
 parameter names in kdoc
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Stylon Wang <stylon.wang@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
References: <20230612013249.1486591-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230612013249.1486591-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:408:e4::15) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|CH3PR12MB8902:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dd0fd85-dda4-461c-241f-08db6b47ddad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rQOYEUM7mHTowydVGb+mmi4SHfZIfsR72x8dy3AI5nWANvhLMyfnSJwCD2NR8VZZbgz+JwuEK4O/Wzb7ySSMEFJGjdq19qHvou45sem2Xno4tXklghkNAy73y56XePaMabZ6UawHsZP+2T3cNebYrH3WqUW/Y0LFgB/9JF5fjemFO8fHa3TlbW4pG/DvfFWUAdzj4vRIlp18eAlNPLL+wzscRdFBunNWkZS45uNv2kszsTsAPDAa5xXsOoFfvzXxxWVRRQAnPzggnzHlh9Af0vgvqCfRoqfKO8xEbzMB5aV41Hw6egzAJX31AFCwbxA5lNwXJ5wZshd7OaeUfZkXytGm2rpHKLE82U1lmDTFvay2UGe22X25KVwbEwGlEa8y9T4Czwgxx3fgJRaLmGY5WNnvsRg7vZwTINlwl0+2Tt0psDvgCuxK7w4G7x7fdCliLoGcCU2dxEVU928qd7zH0y7YJKw+vFXSP9YlGwt2klcpg/8m0LNdrr2TSbtIqIR0oeDLFgznF3zizM3Lh9/zwR1mGm/5RNaumZYZVtbkRWpxpxtbzfdTLc+317kIFoS38dtjNPUH70/9sKdqQTjQIDXHS8B873Rha3J7dDfiyrEdrBBLtPn3ClRj97f4Uf56EIfT3akFF5yNDbIZ4hChgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(6486002)(6666004)(83380400001)(36756003)(2616005)(38100700002)(31696002)(86362001)(6506007)(6512007)(53546011)(186003)(2906002)(5660300002)(110136005)(8676002)(8936002)(316002)(41300700001)(31686004)(6636002)(4326008)(66946007)(66556008)(66476007)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWozQ0tuVTUvdDhnTDhneVRLVHpxUTVFSlFLN1dwVHBCMzdUOHR3VThxdUhB?=
 =?utf-8?B?U1JmZUQyTFNSdVBnbllsUmx5a1VzUWZES25QdFV4TkN1azBXWFZJTUN0SUF6?=
 =?utf-8?B?U1V6dE5mc1YwZTFTNWdENklmbjF5V3NiSUowWVlWWXMvenRhbW9XTTR4N09X?=
 =?utf-8?B?VlBzOWMzbWlEbHdSVjArdGxHUVBHUGFIdEdzZnZyTUgvdTVvR0pBbWQxcDJF?=
 =?utf-8?B?VVlpQWc2dEtLclF4MWVOUFVrcHN1UmxUR1IxY2VkaXc3QndORktoRWtJTzFQ?=
 =?utf-8?B?blVkbEE3RHR3V2VsNVlrOFIyKzdrWkVMM2ZtRGxCcU1FMFhrRXNsS0JJZVVU?=
 =?utf-8?B?TW5WbDFUemY1Q0dyRithSGZKRFF5MjVDU3hQOWd4K1dEREt1TzdENkp2UFFm?=
 =?utf-8?B?YWxyZDRVTnAxUFkwZGhZK0FCelYvK2ZwZkNTamR5NkFyQitwNnJBTTdMekh3?=
 =?utf-8?B?NFFNVTYyM213YmxleW5rTDBoWDFrNlBWL05xdzhTM0xGZE1lT1plekZnZTJv?=
 =?utf-8?B?enlNTnIxRGdEQWNnUzJFTjFTZGhlSUIwTTFkS05oRk9ITU1Tc2Jhc1pGazQy?=
 =?utf-8?B?TnJTMTZpVEMyNFVmcXA0UTR3YVFoRHU0M0kxc1FDY2JpZVhWbm4zcis1dCtM?=
 =?utf-8?B?NE0yMnRFb0tPRE03ZUZrbzlTdEZPTTdRcUt3ZUZiNjVCUi9FOG51QkkrdEV5?=
 =?utf-8?B?Q2U2eDFrbndPNGMzNUFVTVZGK2tIREFMM0J2cVFuUmF1ZTdjdW5MclNlWGxr?=
 =?utf-8?B?SGhkbW5taTliSmpNaEhJTVlKR3NPWWY3aEZuQTE5dlVSU3h6NHhRcHgwRzZ5?=
 =?utf-8?B?NXdxTGo3RTR1czNwMDY0ODRPVzlwQ2o4em9zU0pLTDdSN2toYSsyNkx1TThR?=
 =?utf-8?B?ZitXR212K3NpWDV2Sko5REROUk5leGJyczk3L0hMV2tkUTVPWWlEeFlUOFNs?=
 =?utf-8?B?WUU3Q0xXTDBwYnJGRlVYY3JGQms4ZFh2MGVIWm1WMmsxWG9zSitqMm5pRDdL?=
 =?utf-8?B?VHJXd1dMTllDSDY4VkxMTmEreFE0MUFIcUpqQkVCcTlEWGI1VENFV0VqbWZI?=
 =?utf-8?B?TkNKVTBSd3dnWXgxYmdGcjJRR0luZVFad3Z5a2RqU3BpOExLS0FoVnZuS2hP?=
 =?utf-8?B?NHdvVEd4OXNySjByOXRSZ1cxZ3hreEw0QzdzRU9NVEplQU5ZV0xNL3J0Sldw?=
 =?utf-8?B?NU5zaW9WeFVhZTlnZmhDSzVZUVdNaVR5V2QzQitRdlBZZUE3djFMWHdCYkdW?=
 =?utf-8?B?aHUrQUNONmJiaERMTC9kS0U4eGo4Q2EyTGRiT0M0bkZOMzZXVHpockFmbGRC?=
 =?utf-8?B?NHRIbkRTRFhRTS9FTkUrdm5aYWZDOHYvVUVjcnptRVBONUtrOHdJL3dCMlVh?=
 =?utf-8?B?aGREc2pmbFgzemdDeFRxRUNEbVJzeEo1MkxqNCs2eFNjMEZDNXdXKzlhQ21F?=
 =?utf-8?B?TDFXYnpZQ0QwcUIzZGNpWEU3TFJELzFzUVh6TWtsWjcwM0g0SjMzSUpvVW1o?=
 =?utf-8?B?aExueEs4SHpzTmg1ZGN6V2E4amV1dzJtNEVSTGduRFBkWHErbGpQSE1ZSzBU?=
 =?utf-8?B?eGh2djFyQWphUmM3OFZzSFhKMDlZNVJFVDAxSEZVWnNEWGY3ZjJtcFE4T2VN?=
 =?utf-8?B?Z1hEUFFvNTdxOFFHV3k0aFpmRkx6emhHSHhxdWFqNW00WVdaSnRNTk9TMzVI?=
 =?utf-8?B?U1RCckJsOXdXd1VNRndCTzBtUmFZWitNMXNLOC9DbjEvSFhPK0h2Z0svL21U?=
 =?utf-8?B?clV4UHN1Z0dwTUVsV3ZabWR4VHNIb3NWWXhuSVRzSUlVMzJ2MWFaYVZ2M1pH?=
 =?utf-8?B?T0hvYkVkQTM5Ky9Ddnc2am9JOVpma2xGWWpnc0NXUW4vc2ZOSERPTUwzOTJL?=
 =?utf-8?B?eVdZMnZPN3pZakkycjRIOFMwN2NoekM2MVByU3V2aWZYc1ZHTGdLRmRnWS9K?=
 =?utf-8?B?VkdqOEpuN2l2SXZRd0crNE15RFRWOStXVm1aMm1SWHB5Y3NPRjVXVCtBT1Nv?=
 =?utf-8?B?Q3JBRGRhcnVqbnMxc1RLR0hGdEV6R2g2dXlHdGxxNkVONnB5dm9QRVFaSXNh?=
 =?utf-8?B?Zi9iOGJUZGZBRWNMUkxOQW12U1VTczVOK2N3WHJOckV2TUdnZHRkY0V3dVJh?=
 =?utf-8?B?V3ZDamIvSXdSSmljZ0NpdXJSTlNjQUVQenllbURSSTN5OUtvOVRvMDRDTHUx?=
 =?utf-8?Q?TXf/HoC47HzspdsKcHhvBGye5f2hASsk8t1BDj6OK/kY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd0fd85-dda4-461c-241f-08db6b47ddad
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 13:21:01.0446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIF+aJ2L35BsejVg6ODLqsCImpnGhrSaLNchZbP0pDicacEDCH3beF/E3WxvTDkm74GqTBD7Su4mGeGNh1adtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8902
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



On 6/11/23 19:32, Srinivasan Shanmugam wrote:
> Fixes the following gcc with W=1:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:872: warning: Excess function parameter 'drr_pipe' description in 'subvp_drr_schedulable'
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:1030: warning: Cannot understand  * ****************************************************
> 
> Cc: Stylon Wang <stylon.wang@amd.com>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> index 166123be4adc..e2bb2b9971f3 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> @@ -854,10 +854,9 @@ static bool subvp_subvp_schedulable(struct dc *dc, struct dc_state *context)
>   }
>   
>   /**
> - * subvp_drr_schedulable - Determine if SubVP + DRR config is schedulable
> + * subvp_drr_schedulable() - Determine if SubVP + DRR config is schedulable
>    * @dc: current dc state
>    * @context: new dc state
> - * @drr_pipe: DRR pipe_ctx for the SubVP + DRR config
>    *
>    * High level algorithm:
>    * 1. Get timing for SubVP pipe, phantom pipe, and DRR pipe
> @@ -1027,19 +1026,16 @@ static bool subvp_vblank_schedulable(struct dc *dc, struct dc_state *context)
>   }
>   
>   /**
> - * ************************************************************************************************
> - * subvp_subvp_admissable: Determine if subvp + subvp config is admissible
> + * subvp_subvp_admissable() - Determine if subvp + subvp config is admissible
>    *
> - * @param [in]: dc: Current DC state
> - * @param [in]: context: New DC state to be programmed
> + * @dc: Current DC state
> + * @context: New DC state to be programmed
>    *
>    * SubVP + SubVP is admissible under the following conditions:
>    * - All SubVP pipes are < 120Hz OR
>    * - All SubVP pipes are >= 120hz
>    *
> - * @return: True if admissible, false otherwise
> - *
> - * ************************************************************************************************
> + * Return: True if admissible, false otherwise
>    */
>   static bool subvp_subvp_admissable(struct dc *dc,
>   				struct dc_state *context)

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
