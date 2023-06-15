Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F09EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 14:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DCF910E501;
	Thu, 15 Jun 2023 14:26:26 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D006010E501
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 14:26:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgRbuw1AQIXQGgGTt/M5BdPVJBp9pjqgSTpk7/g9HC4qREmccyY+0VA4qKvEh/yXFBK9SPSiAs5uCjt1GCFsoKdqaPgYwYU32ColydrLOF5k6wwNHEOXtPgBX9uW/9bbIdgEgpoj1dcxsInpUBqpEv9wPyeLC9Uo9ss7RR3zACf+KHvPh7sx2/L2GQGnd+RmsApEZqX25D2x+OeGQE402ow4E6YWqPac1mKTKO7whaFQqXLGebUFRgxsecq3B7vgVpdKcEQ5ixnvVHyNWHAc3dYGro0KSRiOl70muQwH5/4bX1DM+Cq+UVYWHfqM8RhQhNVbNdguqAmDply2LxN4fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohUTvmU98RUPRm1UAbDIUZivb939kX7WuObJlLwY7ng=;
 b=ETewDd22MLHawBWRDvDzCW2Ep7HRYJuGWVdJPUtI9j8FwpPK4xHQAWNyrCnd5gIHU1wgYrkKUFp6sD4+A7rkAtOaGOv/F6hkB8Arjh+h0hl/c4TedBPR2yFblRas4fLQ5SyyjC8hsgvDLGteQphJCPh5fVCCIKGykfgFNYbZ/c/sgxSANIaO7zEsTlLKMli1MvJIt3kHEe5uCa5PqtCE3SrMIHiHfuwPtL4BvR35T5cUpzvhMvjpdEu/DbJK/VoB5FTlYJalDDlnkogtXLgpP82cXuoBI6Ns6039VDDm+DmWNmuVFD2IygXu0+tVRI62uYdrHjj+NzhTxtVM7IA8jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohUTvmU98RUPRm1UAbDIUZivb939kX7WuObJlLwY7ng=;
 b=tQRHJ5DiSc/d9B0uSMDyxijn6fsfGG0tuPr7l0gAJaY7BbWWFh4fcj53ysYy+XCOgSypmDUsZN6X8tVULGQqOqdwKhizS9PwHbJgjeeS67wVHTngVh89dVBA7Z/OxjalH4sD7kr/yzddbvDdBPuWPKilbjnluMtkfv0zLno+6mQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DS7PR12MB5957.namprd12.prod.outlook.com (2603:10b6:8:7c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 14:26:20 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::4666:2db3:db1e:810c]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::4666:2db3:db1e:810c%7]) with mapi id 15.20.6500.026; Thu, 15 Jun 2023
 14:26:20 +0000
Message-ID: <bfd88c4d-db9a-e4ad-6296-2f4fdd8be8c7@amd.com>
Date: Thu, 15 Jun 2023 10:26:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] drm/amd/display: disable RCO for DCN314
Content-Language: en-US
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230614204234.145409-1-hamza.mahfooz@amd.com>
 <20230614204234.145409-2-hamza.mahfooz@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20230614204234.145409-2-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::35) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DS7PR12MB5957:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b9ff3d7-6283-4f87-420d-08db6dac7d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yf/E/clyLaPqtm4Bk8tNdNwanL0DY/Ou5kL+nuOyc+PwohVh/oXkwjvs6XjbMhI46loyg2UiU4yeniB4WGaFRCONXwn/Juu512xGArZrTFElTia8WpmIA6dhtq+Ztplo59Z6Dri6OqozZiJjWB48kbjYJ5M1f/PFsGXj7+vl82Q4L/nYBcH/UtwCxBSUoHJpufmYF2FNIxOXHoOJLlixyC5Q8d2D2vGkN6zIYFIcJaLyamZg/UiH/MtzZBzRxScPAM6m3Q3Dp9PCAjTPtyqPnt0/31UxeI5MjMWryd+Tj4D5gJr0xfqHMc6hhkiJrXFLUi80zJuEsLLO1XwxLjMMQ05u0/QiEeiPH9qxp0Kf9Iq7TwpVQ0WAT6DIlIKkEgtuMl4XY8t8OWqYa33fhv/DuUEhfwm4UZBIqnAjBjlWc0ZhAViaBWCT4MbCIH7kKpQqZjpB4wt1ZAIwqcOyy4aeAotCOaJs5zeC0IA70PPCHbqZfH/0PMmtSuHpOCPKXsakU15w9UVaMizuaQZMBk/Y9ACy+/dS32w2lI5/3OFJ/H3EGrOIJv+8uVFNBauQw8ObjVA7MfxCLlw7w69qYf2bgmTloh2vb1ZD2LKOvn6rIHX8OzsqVXK+Q++eeyNNjvC0PHxoiq0FYyz71WGvF+mQHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199021)(5660300002)(38100700002)(2616005)(53546011)(83380400001)(6506007)(186003)(2906002)(26005)(6512007)(44832011)(478600001)(66556008)(66946007)(66476007)(316002)(6666004)(8936002)(6486002)(8676002)(41300700001)(86362001)(31696002)(36756003)(4326008)(31686004)(54906003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWNieXdzdnV0bDE3Q08wVGw2V1YzTFhmSmVLVU9xTTNTbWwvTkpsU3FIZmhr?=
 =?utf-8?B?dkgzODFHV0hCVWtzZ0lTQ0d6alVpREJhdnJ6NmRWa1NHT3BWNnBva1BubS81?=
 =?utf-8?B?d2p4R2JIWTJZd0hNVEVUcm5Td3k2YXZHcXF0SmZ6UFVlbFByQXFqVGtrOWZX?=
 =?utf-8?B?bkJnSmM4akpMa0tDWVdEUERWMFp1K3U3TWQxOVNtQzZROGRvQ0tjMkZVTjF0?=
 =?utf-8?B?R1c4TUxBZTVCU2JHejdSRFlWemVjZlg0Z280emNLN0d4ckVqWTRpR2Y5a3No?=
 =?utf-8?B?dkxZUlVDTWM5SkFvaTFOdllGQnhOZzk5Y01HRi9RRElnYysrbjhsK3hLYjBr?=
 =?utf-8?B?YU42RTdhR2FyVVR5eW9pZHl0bWJCOHp6Mno5QU5aenBJdUR5eWNEeERZeWFG?=
 =?utf-8?B?enBuTU0xWC80K3E3WFd2ZEZlWHd5aWxxbkk4ZFdPQXk2NG1vekFOcWJRbFht?=
 =?utf-8?B?a25wK1VsTVVVVVBvTXJUOE9tYUhJTCthc1lNaDVQOFBmQUlPL2wyRkJIcU5o?=
 =?utf-8?B?TEJ1dUxzMzVaUGtHMi80T2plUTFtTFZnSGlhaXg0VkthcFk2VE5WaWJXMDRF?=
 =?utf-8?B?MFVFYWJUcEt1RGg5WGhYUmZLa1Bqa21Fc0VtdDllZ1p5N2lvUEZaNGp4Mjl4?=
 =?utf-8?B?WGpUTE1XN2VDYStpdlV5YlVTYWU5ZnVaKzJSVGNMZVJBaFNxdVZxVFF4bzFK?=
 =?utf-8?B?QzJNOExMbkhFeTJCVkg4MG8wVlU0WjBBU24zTHA2a2IzdGhCQzNMTHdsQmtM?=
 =?utf-8?B?dk5SK3NFR01nd1E3MWkrTFRZWHNqUTBTdkpINmFUcmJxMHYvNExFZ3QyTThX?=
 =?utf-8?B?ejVPQUdMc2ZYVUtnYU91MXZkWXVOT3FuWU9oak5RNm9NSWcrejNkbzVEZ0Vo?=
 =?utf-8?B?K0d3Zzc1UWI1Um5CUTdpL1lTcldleUlvOUFZb1ZLUkhHN0o3b0NUYUo3cW1J?=
 =?utf-8?B?U0dDaEw3VzVoQkdFU0Z2c3ZNRG8vb0VmNTdkbzVQbUZlZmVhekNDdUJkSTlE?=
 =?utf-8?B?RG5rTWhPNWdWbVk4SG5sTFBZZjgxS0M5aWdicnJSeXZDNFY5Q3lpV2FxZnRq?=
 =?utf-8?B?ZGVPRk5wMWhYZUh0WXhtczdzTTdtSGJMMGdEOXJOYUFXY0dmMUdHLy9Lc0N5?=
 =?utf-8?B?RTVDQUFnbGpIeGpQT1RyS2J4dGxoYkRlQVFsM1ptYTRxTEtjeGx2VVU0Y0R3?=
 =?utf-8?B?NmRwMDJ1S3IrNmdtbXN1bGg0RlliZ3NyQW9UTU1iNHdQa2JtTEtOVmorTUR2?=
 =?utf-8?B?WFp6RmJGa0I1UUJTb0tDT1pNTXBReDY1WUNaOWhzc3dTcnFMWHQ4MHNLRGRq?=
 =?utf-8?B?YkF0NVA5dXJNVldYL1FZTndZZTVWUVZNTy80MmpPc1JVdFVEWDVnNVd0OHdL?=
 =?utf-8?B?NklSVlMxYTZYcW1rVEFpdUNhM1Rkc1lzL3lXaGtoOXFtVUNvcy9acDRQUDk1?=
 =?utf-8?B?VHFLSTlGMDl2TjE5M3hNK3YwVHZRWDIrM3dqaGpNUzRCeHZJY3hwQ3N4VjZo?=
 =?utf-8?B?a1ZuSSt2Smk0M0NTUGd1bjZORFRNN01BQkRNUzJ5OVlPczAvQ1RUamtCWklW?=
 =?utf-8?B?bkEzUDJIR0JNNzNrZm12cGloMWkwYXRxSFNWbm0yWmUvbVNhL085VEdkTEV4?=
 =?utf-8?B?Z2g3Wmg1cDVvaDFqeFJxblQrYTcvNVNLc3NMSStKUVg0bjRMR3hFUXdsYWhl?=
 =?utf-8?B?ZTZmZzBoODVwNm1nYjNTaVIyL0pwdVprOUdQZysxbDdVdGJPZ3M2V0hvdHk1?=
 =?utf-8?B?aG5lOWNsMFdZR2Z2ZENUQnRVUnVteE0weC9pQm9SSXdFaDE1WnEyRFBZd2Jj?=
 =?utf-8?B?OGlCQmtjR2t2Z0hGcVo3aE9pUFZyemNYRi9URkxyRERDRytQU01lbzNwaWxT?=
 =?utf-8?B?NlZLZFlFRUlJdFN6RUZoTzdzenJmSi9EUTdKMVVnOXQ0aVAvczI1aWMwcHht?=
 =?utf-8?B?bnFjK29zV3dvRlpScFlRS0I1cVJrcGhMajhidzBEaHh4YTNXa2lrZzdTalRP?=
 =?utf-8?B?UFZ3TThlWGdiZUJyd1BmWkhYbis3aUdOdnAvSGJqVXFlS2hDT1FsdWVnWita?=
 =?utf-8?B?bDEzbmVjcWU1djRHWnZlNUtwemxMNGptT2Y3a0hZTW1rZWo2OGh2TEpNSDVa?=
 =?utf-8?Q?q97ofrj+7N3MHJLJRpVKlMsnz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9ff3d7-6283-4f87-420d-08db6dac7d1c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 14:26:20.6782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKN8LW+YypkDVUsKYeXxDfGdxtrNw0ZXmTQnKy4hf1Psu3YVJp02vtB97+iKfnXm618++r1mW0/lnN3uAVoQHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5957
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
Cc: stylon.wang@amd.com, Daniel Miess <daniel.miess@amd.com>,
 Sunpeng.Li@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/14/23 16:42, Hamza Mahfooz wrote:
> From: Daniel Miess <daniel.miess@amd.com>
> 
> [Why]
> RCO is causing error messages on some DCN314 systems
> 
> [How]
> Force disable RCO for DCN314
> 
> Fixes: 0e1961c93839 ("drm/amd/display: Enable dcn314 DPP RCO")
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Daniel Miess <daniel.miess@amd.com>

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c     | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
> index cf23d7bc560a..0746ed31d1d1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
> @@ -332,7 +332,7 @@ static void dccg314_dpp_root_clock_control(
>  {
>  	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
>  
> -	if (dccg->dpp_clock_gated[dpp_inst] == clock_on)
> +	if (dccg->dpp_clock_gated[dpp_inst] != clock_on)
>  		return;
>  
>  	if (clock_on) {
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
> index ef49b4d7742f..6a9024aa3285 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
> @@ -1908,6 +1908,9 @@ static bool dcn314_resource_construct(
>  	dc->debug.disable_dpp_power_gate = true;
>  	dc->debug.disable_hubp_power_gate = true;
>  
> +	/* Disable root clock optimization */
> +	dc->debug.root_clock_optimization.u32All = 0;
> +
>  	// Init the vm_helper
>  	if (dc->vm_helper)
>  		vm_helper_init(dc->vm_helper, 16);

