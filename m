Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76ED0C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Oct 2022 16:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE0E010E975;
	Fri,  7 Oct 2022 16:28:03 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3747810E966
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Oct 2022 16:28:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwfU/94Wdrlc4/C7p4ZE17dk5ZTCauK0LJFKZHOqTf0IQNr3rKlWYIbdaySKidQ5ZU/u08HpxGiLNprgQr2yi+ukbrOB1SB9KOAVjleoo/HRASMQIFDFNtshJWvPRTvfAxirD7KRoWbddjiAp8mlwSUvtC68TZ1nSGzjxTHMeKpLUXXNNjrAvft1KDMuVmgENLXVGVenVU4hhEwPD7z3IwaYw7MoIQ3ZkqdhrjUI020Rls4hCAzWKyXg5tqJ+H5QyvswV0vRmDB9xb/jmmeO3ACP7cnBIz7o4gAdOLLqUIH57fctnAjgBq5p/2+NmB2oE7nRLbRMsNo7tHGp3udS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDYbbiqxf0gPzKnyInKyq4Mw12aJZDM8Wc4tZ+byTiM=;
 b=S928Hht3ApbmCNa2tDUuh+W8mbD6rnqudV6IKRnlait6KZINI97+07O35NGNgLVdkQ2kTTmOSh499sMyz1JYOJ/Z683W0ojO0FP82IZoB1Tt6VR19+1BjMlYSobDiSIRG+yhFxGebOEWayNDY856AXzpd6s5xRBEuN/UFB/Md+r+ECg1FZRxtW5z5i6gNzph4SBEgOkOzrsy28VHG1aT+nt5IxlJBKrCC8h+lvwSW4BbAEf9A1QAjZQXG1ReCL96EJUOo4bRlH+NvorRWwkvMW7Gnf4IYijioHZMNh4JnxKVW+DqJNVMkrTTSODmqGUvJEr+y8Cxv+rqRIPX+Ws1ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDYbbiqxf0gPzKnyInKyq4Mw12aJZDM8Wc4tZ+byTiM=;
 b=iyIMD3z7HXC3FQ6G0zDx1mdIB85db7XhfH0WD0U0qN2Ydik3mcKJ1nVepEPwk4VkkJE6ESIXpPsee7BH3mQ64d2Ws9UZI/2YJlDtP/0MI2sycnZ1Bfur5MY09oEJcFFEy9W4ysQh1QLs+T30/SFDwEsI6ccvqIkXQrYVwXg9YrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB4857.namprd12.prod.outlook.com (2603:10b6:610:64::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 16:27:57 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3%9]) with mapi id 15.20.5676.030; Fri, 7 Oct 2022
 16:27:57 +0000
Message-ID: <9e61585b-cdc2-0311-b21d-ed4f8ae1b35e@amd.com>
Date: Fri, 7 Oct 2022 11:27:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [01/23] drm/amd/display: Update PMFW z-state interface for DCN314
Content-Language: en-US
To: Qingqing Zhuo <qingqing.zhuo@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221006212650.561923-2-qingqing.zhuo@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221006212650.561923-2-qingqing.zhuo@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:610:32::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH2PR12MB4857:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb7106e-1d58-4611-2bbb-08daa880e4df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ENRzFlBdaV1mdV2gPkzNLGO3hfEFsr7ohqo+N44IiifvYTZDioHq6pHDgS7HqBDGP949g3my5O8PZSfbz2EB112D6DhlUxqAmGUHWrbLrL/IpUmKJfuNhNEXT6s/PcmvBrj+AFKP4tDddGCn2dlIgGGgm0LoATGGIg2dbSgkuScWmF/itJYDbV24FLEtFNP3pR0M6V6NwtB2uqGnReeMSrd4aqqvwadN/zbTmNfhPD7q0K6FE3Y2WpP0a/XibUnTHU9Oqj8abWIILWRRXslbpJVqBsZm+zbm5zLylO4cARGhhavSoLnkuxbTOQN1XmB8wvOSEOiY3TXU0pOYVHD6gWviVU0gI52tmmUGFcYiCXx2TrAIJe2FtZU+HsP5fPpM9QEJ+Z0iPW4yM0+cbLiMNAp++A5ALMlsMrKkJn2VWlJfwkjRlblt9bX44ai7dTqhJuexxdhaYWWcAIPPlLN7UzFnubH84DZxWZfUPOOvurXPrLA8iL14BSrG7DkWdYtrmkMiZULLAns80bnYVgOmzoK6bZqjZHsriNDP+lojY4mMBX8fpvpZbWh+SaGbqzs4UC8lDbqmt1K/i6ojAQCdzLZ1QP8kH6qk4pc6guuNqcKxIir8zs1rJckrmGumZXQg7BW2DIo79Ksz3OtjyRdr42vRvZetwFZeUPA8kbCdRCu/BEDBsyWAyDIKJQzG6Hj3RdOdccVJovffXvxg2Af+9NoDfHKANDOn+9gtBdnLN2BSf4PpjFC8Bxsi6Dipt5/w8Ut2vOGDtpzqurgRkkSBGjsIVMVGig4rT8z8v9cN6BY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199015)(36756003)(31686004)(86362001)(38100700002)(31696002)(83380400001)(186003)(2616005)(26005)(6512007)(6666004)(66476007)(6486002)(8676002)(53546011)(316002)(54906003)(66556008)(4326008)(15650500001)(8936002)(5660300002)(2906002)(478600001)(66946007)(41300700001)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFhNekNFUkl2eUJUUkdrS1pGU2R0NUxrRU5GVysrZURFT1l1K0gxQ2RvSm80?=
 =?utf-8?B?eThQMm1JZlJJQzc0YjY4UkExK3hYNGEyazFwQ3BhTnBRNUFoZEVDcnhZR0pq?=
 =?utf-8?B?eWhhaEphVDZKbzNsSFZicEFwZWUrKzl3M0RUWndsWmRmWVB2L3ZjbCtlNGhF?=
 =?utf-8?B?Y08xVmUyU0lTbzBjcUF1ZzRPdFAxU1Fpc1BHL091YkRIRmU0SldsditvV2lG?=
 =?utf-8?B?Nm5BTmlPTE5kYkZUamx2V1c4ZkV2RXdtMjFOZzFHRGhPS1IyT0VlbVkxSEF2?=
 =?utf-8?B?cUMwd0tURUIwUXVja3BvUCtTa0p5U2RiV25tTVRGNmtkMzlUR0xlcWZiN0JP?=
 =?utf-8?B?eEhtOEFXYW9TU1FORTAwV3EzVGpEMDluWkg5SndQZ1dFVEc2anRnTG5uUFc4?=
 =?utf-8?B?RTQvSjJwcEx0UXB6TVBKYkMzS0lSbEFlZFZiaDQ1Y0RuczlJNHRnWXVtaUpp?=
 =?utf-8?B?T2tObHF2MnZ0WGN6VW1IVFlWNmxBWk5LbmJVSVp1Q3JXZXBWVloySDh3dG5U?=
 =?utf-8?B?Nkt1ODRpdHh1V05yeVg2YitQRTJob0gyWS9TUnR3Q3h2VEVtcEc5MVl2UUlJ?=
 =?utf-8?B?K1FmVGR3c2ZvSjhuOGZPR2RxMnVOZ29VaElIbVcvRXQ0bmw5K0pzc0prOWU1?=
 =?utf-8?B?NHdIS0pGN2RZNWdVNVJIb1Y0SWo2Qmd0Y3M5ckg1MXhoMnRBdFUyZEhUd0xZ?=
 =?utf-8?B?Vkt3d2loOGF1Q1B0dUtMakJZZVVlQTBHcTJrVGFFK092TGxQeTBrUTZRaDhI?=
 =?utf-8?B?KzZMUWdJVCtuQXovbUpSaGdUZnVUaWtBbkFtRndRZDAzdXZvV1NYdzNQUTdv?=
 =?utf-8?B?RWdkQ2pXMVdGNkVPUjY2T2VCR2U3VHRWbmpxc1I2b2lIKzBFRkIzR3FhY1d5?=
 =?utf-8?B?RVpZOVVKZWpXb0tlM05Nc3BlRnhsQWI4Q0FtMEorUVdVRXZFN0FlajZubnEv?=
 =?utf-8?B?czFDUjlEaUNKekdnaEZ6QXY0NHY5QVFoZUxVSFo1alFMcnR5MkRVSHVMSU1w?=
 =?utf-8?B?R3p0UlIvSUpjVzc1cWg2VHNxWGFTa3JFN0RoV0JaS3d3RndoeU4reDFmd1U2?=
 =?utf-8?B?OWRBZERlTktybGVpZTh2eitNbEJpeVZIbUV1MEYxSC84SGZrVEJyMUZBZEo2?=
 =?utf-8?B?bm90SUhIcXQ0UWpPRGlYRTYxV01EUW9OcVpaWjcrYXFyKzIxL1dyTUlBWGRv?=
 =?utf-8?B?SUsvL1lTZk55V2U5NXNubzlwSUNXQlJyZFh4eGhVeDUvUElqRXpPeE5wRzJ5?=
 =?utf-8?B?U1diU1VzSkU2eVpxRENKY1RKRDRlQlpqQlFpNElpeGlPbEN2cVFnOUNCQ2lq?=
 =?utf-8?B?RkgyRXlDK3dEN3FWQmdvUDVLTk02eElyN2pJY0lWZDZETVBQSStoYkFWZExs?=
 =?utf-8?B?SVFra0tRVEZJckpST083azB1U0FvZEZEWkhocTFiTFNoOTVseE11aFMyREZq?=
 =?utf-8?B?MC9Na0VxL0IyejNIdFFjc2krZTlkd3BvRmZSVDN6ei92TzFpSGdVK3lKMzdL?=
 =?utf-8?B?dDdXWlN0NHBRcFlmSG9vYUMwY3ZmZWcwOXYzUnFhdkxUc3l1U3lQYStpYXFY?=
 =?utf-8?B?VTdwcUpNTmV1SWJJYjd1dDBDL0Y2Q3kvck4wZ0hEOWc1OFdxTmVneXBLRzcr?=
 =?utf-8?B?dUd0aWp5aUdINGgrRDRwaWZOV3dRNHRKRzkvNUFtUFptWTJNbVI1ekkxV2tl?=
 =?utf-8?B?Mk1DQzZxSExFYS9OY21nSGR4NHVRbi81MUhUMWdacVhxSitMTGROZGM1VUdv?=
 =?utf-8?B?MDN5Q25lMXVsaUlBajVwckR2bUVBUXFVSlhwWG0ra0xHbjlwZ2c5NDJIQmty?=
 =?utf-8?B?OEFnUE9ZS1AwZ1RkQXY1NVJkaHh4L1YvK0s3ckk1SDJQeFMrcTBTVVNXNk5a?=
 =?utf-8?B?TFlEYjdidkxUZ3Yyay8vSWp5aU1OWFM4bVFDNkNDejkxZnRiVHBOMm1nM3dN?=
 =?utf-8?B?Z3Y2dWc0TGNPMDVZd2VQUWRPUnhtSVlKQTNHekU5b05SSFZPanpzWGkweWRv?=
 =?utf-8?B?bVU0ZG02NGcwdFkyWmlRNE1KelBvWU9pNmlUb0hMYkJ3OWw1SmZFS0JQZXV6?=
 =?utf-8?B?Sm5JZXF2WitkelE3bS9KZDEvakp6ZXZJbXd2UjVvbGRtUzljYzBoZWN3cS9I?=
 =?utf-8?Q?Hy15vkGBh/y+PN9fYJuyakX9j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb7106e-1d58-4611-2bbb-08daa880e4df
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 16:27:57.7176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZXq1mEMXE4wfR+y07N7KdW9d2qlarwQ99kQ8iaL2clMBhVK118ltXqGQxrI/EV42lcxrSkjoDg5RKL/0PRFPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4857
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/6/2022 16:26, Qingqing Zhuo wrote:
> From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> 
> [Why]
> Request from PMFW to change the messaging format to specify whether we
> support z-state via individual bits.
> 
> [How]
> Update the args we pass in the support message.
> 
> Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
> Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

I'm aware this isn't strictly a fix, but as the firmware interface is 
changing I think we also want this to come back to 6.0.y too as products 
with DCN314 will be enabled with 6.0 and we want to make sure the 
messaging to the PMFW is correct as we enable different power management 
scenarios.

Cc: stable@vger.kernel.org # 6.0
Fixes: d5c6909e7460 ("drm/amd/display: Add DCN314 clock manager")
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   .../drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c    | 11 +++--------
>   .../gpu/drm/amd/display/dc/dcn314/dcn314_resource.c   |  3 ++-
>   2 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> index 897105d1c111..ef0795b14a1f 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> @@ -339,29 +339,24 @@ void dcn314_smu_set_zstate_support(struct clk_mgr_internal *clk_mgr, enum dcn_zs
>   	if (!clk_mgr->smu_present)
>   		return;
>   
> -	if (!clk_mgr->base.ctx->dc->debug.enable_z9_disable_interface &&
> -			(support == DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY))
> -		support = DCN_ZSTATE_SUPPORT_DISALLOW;
> -
> -
>   	// Arg[15:0] = 8/9/0 for Z8/Z9/disallow -> existing bits
>   	// Arg[16] = Disallow Z9 -> new bit
>   	switch (support) {
>   
>   	case DCN_ZSTATE_SUPPORT_ALLOW:
>   		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
> -		param = 9;
> +		param = (1 << 10) | (1 << 9) | (1 << 8);
>   		break;
>   
>   	case DCN_ZSTATE_SUPPORT_DISALLOW:
>   		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
> -		param = 8;
> +		param = 0;
>   		break;
>   
>   
>   	case DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY:
>   		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
> -		param = 0x00010008;
> +		param = (1 << 10);
>   		break;
>   
>   	default: //DCN_ZSTATE_SUPPORT_UNKNOWN
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
> index 70b647b9b4d3..d0ad72caead2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
> @@ -881,7 +881,8 @@ static const struct dc_plane_cap plane_cap = {
>   };
>   
>   static const struct dc_debug_options debug_defaults_drv = {
> -	.disable_z10 = true, /*hw not support it*/
> +	.disable_z10 = false,
> +	.enable_z9_disable_interface = true,
>   	.disable_dmcu = true,
>   	.force_abm_enable = false,
>   	.timing_trace = false,

