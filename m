Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD4FC7EE25
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 14:59:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5DD410E064;
	Thu, 18 May 2023 14:59:13 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E00FA10E064
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 14:59:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNoRWA4D3ftokfWk3k2oY4DKQGk/8d+QAXjGMoJds0JFXrvkEYnviFB/R+SFka60Q7I+osF6iDE/et9Ha5WfbFKRJ4Xs6Jbj9OYit8h6kxOJbhGvs3ebjGBkvAG8K7lLVp3IcYp4gOvyBIfPDbJvw6bf/7PW2ReGMuwPI2bNt5ucu7AI2MEsa+dIESa9yRHTtPb76L+EM5Vc5YITdyVm78b1fBqyKSOibYjZ6gzhVwFWU0S1bVi4GJ7RjE7MUo+6I+yoYEQr2sgqVGYY+WMEh8GaRnd05F3eQ6F3GkDpp/ZbRaejlYh7xWEZHDIEpXnqIQrjcC6sOTL52KIqRP7vUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PfZxx6J35w8rUIm+kABh6YNr6iGOWhOh8/ppre5sEc=;
 b=TGRwhhbC4rwtb205/orcuNWnAKR5u+z3ZdN1u4hVEFJabrkLmBpjIqMhNDuSdJVM7bRhHO+kl659EfaJohz8KDALjeG6wuv9UKKFshNcCLoW4sZ8yDjnxTbkwTrnl9OcYOFzzjWf5kNlckrto0l2HPNmOopmbXH3m+ZAPqn90+5RZXHEWtN786mdyduZtb+nl7rXLvuS3UmeN3ip07L7Pp7uBDZPc6LoF81hKbOm8dZZ1ieVp4hDlDmdM/4QepFwazncAa7yOTK1zaTo0oIXoDUYnz1oF3gWfI++pXgxu2EMq62zllx8cvsQQkqwaIDgNV/lZeqGOwm6mMXjqwXpOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PfZxx6J35w8rUIm+kABh6YNr6iGOWhOh8/ppre5sEc=;
 b=lrO2i1wdBL0ZamUnvNp6/w/zVsi3YJqZO9BEWkgEUHOwfxeVHc16gZuSRCmT0MyFV1KQgFni06txq3Xn2Sz6tRWRpXdC3enA3zIOr2Lb0HSJ4NaM+s14oblWBXMyqhTfLXou01rsdGGI4uL3mqC1tl2+gbFJsOaTbzduqENyElE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 14:59:09 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::3d88:4b4e:e0aa:3c36]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::3d88:4b4e:e0aa:3c36%4]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:59:09 +0000
Message-ID: <dd62455b-add1-bb50-6ad0-f2d35b4656e8@amd.com>
Date: Thu, 18 May 2023 08:59:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amd/display: Fix artifacting on eDP panels when
 engaging freesync video mode
Content-Language: en-US
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20230517211006.311990-1-aurabindo.pillai@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230517211006.311990-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0260.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::25) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d86c78-03a6-43ef-0ebb-08db57b06f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smZ3MQsMfrnGdlO+qs8WMi+BhyZ3bhAqymOKafasc1Vwjnjcmc0oKPEVVKWrq4CRWs3QH5NiU6yeCc9UGepg3WfZlgJBN2ZeoLoR6WohKFZ153SGeaGUXDOMATD+tPSIEUcTzom+IYMtr0W4zYf4kxYpzNtCHzncOSDYYKGp12UAPG4muLW9DIAGbfFnIbkgB5C8aDfzOA4Cj1sGRq5rb8Kw97OMef3Saa8SdZPfN+qfvtethKfhS7SL25ashDULGjZykgwSpuMfdXSOBlHEp9RZA/tVLVDB5uOiKt+SrmxuOIFgb/xkXosksBkzPxQWNYxmYg1304Bl32aEHyL9do5Jv7pIHyuv2RsZgDWx9QzpxL9WmhXqbqVpk+QT6ENHjptvRSaUXPHfs4uM4mhfpP4mWpN6byeXpKvp5ry8FUIGHZsq6A4l38vFDJT8uc030p+tnxqlkit1OaYqETKSj/pJ6627siBqrM3xhnQQCk271Za1Try01f2CLkch3YLh4hQxus8+fOcMpdPTzz4YPRXI9luWWPnaZf9Yol57uOUpooEjTXtreK5HcZUFv5VMamlodwmNjtbqvsWu6PKsyU+rOMl97ud7QQbbPSsFwtM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199021)(316002)(2906002)(478600001)(41300700001)(8936002)(8676002)(6636002)(6862004)(4326008)(31686004)(37006003)(6486002)(6666004)(66476007)(66946007)(66556008)(5660300002)(966005)(6512007)(6506007)(53546011)(38100700002)(186003)(83380400001)(2616005)(36756003)(86362001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm1RaWlXMmdnckdEd0MraFA5bE9wWCtaZEFoVDkyRWlqdHZYMGw3dHFTOEtD?=
 =?utf-8?B?Z25MczAwK01PS1c3SVp5ZzBvZGhwREc5ZUx3ZEtwM1k5N3pPK3pSdUh2eEhx?=
 =?utf-8?B?ckwvUGFLdnNnZVNKZTNwbDVBcXdlV2FxZ1FDdEVKWnp2QmJ6d0sxZjU3Wld6?=
 =?utf-8?B?K1J2cXAxbHd5SDNGdkNwZitYVTdDREFMVmNrcStscWhXemlpeC91WFI3T09B?=
 =?utf-8?B?NmZxekVEbEE4WFVvTGE0eW5mTDh6d3ArZXYrdHhQeUFSdkpFMlo5M0l5Szls?=
 =?utf-8?B?eDZWbHZ3aE1RS0xKRDNRVU9oc25tRFdWMW1BbmNpcEZka2FQZWZYeXN2bFVO?=
 =?utf-8?B?ZmpXYWZLSFRkS1dMd01qKzd1MFBLQTdWYnprYTJ0cHhIWkxNcktpWHVxMTJZ?=
 =?utf-8?B?ZFVRZ3l5aTBOTEpUUTFqOU5vd081NFE1ZGhYMHlFSW5sNVJnL2Z6Qlkxai9X?=
 =?utf-8?B?cW8wYWFuZTVNYS9icVhUQ0RCbnlwd2FXSm1EeXJzejU4NWx0VThoL0g0ZFBx?=
 =?utf-8?B?enVnMHlYalpEZmI0WE1QUFBwcHFpM0U0QVYvdXgzeit2TmV4SG5GdDlqSUx4?=
 =?utf-8?B?aU9HejBnV3UwK2NwbkFnbFdvRjd2TnJsYXlZSGNzNkF1dUpLcEVhTFpaUEhN?=
 =?utf-8?B?L2w3SERmVzNQZEF5K0pFdWltTUVmUmlveWJtQkpTRkVkRk9Od3NhNmlDemZ2?=
 =?utf-8?B?WXFFUmlScVo5MUxkcDljVnk2eGU1SzhnWG42eUkwOFhXR1h0SmRBaVZNMnRU?=
 =?utf-8?B?ejR3Tm1xZnVXK21DOGRMemVzYjFBVzRHVXU3dUhQVmI5aU8zYy9hZmpPcFRk?=
 =?utf-8?B?Z3ZlUG1kUFczaTcvcThIL0N3Z25DUVhpem52bzg3MFpKdzlaRHI4QUFReFdm?=
 =?utf-8?B?WU9ONEhNay9EVjZvN3R1Y1VjclYxRmwxaEVxTGdJL0h1dFY0cXRIN3BJV08y?=
 =?utf-8?B?V0NGN2VEYi9Rd0pOanpISmdiTHdoRmlUZ2pGcU5SbEZLY2t0Nmc5TWJkcEt4?=
 =?utf-8?B?N3BFRFIxZ0xrcDBxYXhnUXcrem5XWDYwV2V0QUV5dVB3ZWJnSFprZmlqT3J6?=
 =?utf-8?B?UkJKTmN6dkRueEZIYTVoYU5tRGxZYktMVEdrZU00a01XL0Z2SllwVGxUMFBC?=
 =?utf-8?B?VStId2ZHU1FZNFE5bzlkNjFjemdMQ2c5NEY3eUtUWWxTRi84MkV3TkpIbFFZ?=
 =?utf-8?B?a1V2YkhBcktiK3ZVOFlHVW5iaHNheGY4M3huRXBDNlVUZWdjNU9aNk9wKzZ6?=
 =?utf-8?B?YzU1RTVpa04xRU9EZEt5QWJjSlhNWkZ1WUdma3huaFBJNE1LV2p0bzdRcHF0?=
 =?utf-8?B?WlBmMUVTMVhNdVd0WmVVV3lWWVEwbkpJV0pMTW1CYXFEcTE3S0Z4K0NtM0NE?=
 =?utf-8?B?WE1FRXhxcm80QjV4SURwTFIwcU8vOFFEQVVmbWEyb1hsckg2S1FocXhpUHE2?=
 =?utf-8?B?Q2NhVWV6TFFQODFaeE56cmhrSi95UXVYQ2gzWHMrNUJNZVNzeTIwNEVVOTdK?=
 =?utf-8?B?ajZMOXd5M00rUWdSd0ppQm1kVVRtTlRHQzhxM053a1ozcDJqdm9NN3RtSjAx?=
 =?utf-8?B?dGxZMmJCYVFKL0JqREFJSUFjNGdmMlZMYlU3RUJPc1JrQnpucHdvb1o0Z1Fx?=
 =?utf-8?B?cGVUQ1Bxem9hL01ZVjF5QTJoaXJNa1lvY1BGMG1kbG9WY3MrY2RqdHFsTDVN?=
 =?utf-8?B?eUhjUHdrSTBlTjFKTTByZHFLZWNzTjNPVDk3NmViNzBaUDNPd0hxb2RUMDBp?=
 =?utf-8?B?TUpQVlBhNHlMeHFoQzNhOUJWVUFZcXNqa0ptOHNzRlo2c2xuaHFmNmJRekFy?=
 =?utf-8?B?TE5Iak4yTjR3K1lTN3JvTVRoWjlucisvRS8yL2Q0MEIxSUplbWtyMHA2dEdS?=
 =?utf-8?B?OUYvd3Y0YmVaWC91R3FyZFU3Uis2OHVqNEFXUmwrY1JhYURxYURzYUhraGVQ?=
 =?utf-8?B?YlR4VXJwN2ZON0U2Um11U1lPUHBrcDlBek4zd2ZWeG1UV1lSb3FZUE5ELzFI?=
 =?utf-8?B?WVR1QXZzemhrWC9NeVplQ3VlbENvVW9OZFd1cFpFYkJRbmQ2QTViK3ROK1JJ?=
 =?utf-8?B?QWVqNzVuOXNlSE9lb0RjM3p6ajA3bm8vWGpjSG8zNW50VFEzeHZwQS9nSTV0?=
 =?utf-8?B?QkMyY1BLRlFEeGo3dWYvcGFWU1ViTG85aU5wVWFGWWlGcE1TNlFlNm5uME1G?=
 =?utf-8?Q?/LSp4xQaCVNZ1k936uZDspeCA1suQLlj19EjlxmzTWK/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d86c78-03a6-43ef-0ebb-08db57b06f0b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:59:09.3640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZleuyTVmp2JQKjoZNYe/AMYFtREIPthpllD93GtoU4785/p4E/Rq7xYOeiKSw8EbYtQBNJeKT5JBD/VQodN6MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656
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
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/17/23 15:10, Aurabindo Pillai wrote:
> Additional checks are necessary related to stream and scaling changes
> before setting freesync video mode when an eDP panel is in use,
> otherwise it can create artifacts on the panel.

Hi Jay,

Could you expand the commit message to elaborate more about the bug 
(when it happens and how it looks like) and describe why the extra DC 
check is necessary?

Thanks
Siqueira

> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2162
> Fixes: 541d54055b75 ("drm/amd/display: Fix hang when skipping modeset")
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 14b296e1d0f6..7f322b18eda6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9285,6 +9285,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   
>   		/* Now check if we should set freesync video mode */
>   		if (amdgpu_freesync_vid_mode && dm_new_crtc_state->stream &&
> +		    dc_is_stream_unchanged(new_stream, dm_old_crtc_state->stream) &&
> +		    dc_is_stream_scaling_unchanged(new_stream, dm_old_crtc_state->stream) &&
>   		    is_timing_unchanged_for_freesync(new_crtc_state,
>   						     old_crtc_state)) {
>   			new_crtc_state->mode_changed = false;

