Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFC9C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 13:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9915A1128EC;
	Thu,  2 Jun 2022 13:38:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF3191128EC
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 13:38:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dm7Ua/o4CC1KQMgZ/FgifCPxSvI3sBhfx1cNnoqxIWVfqCOS4AS9XnoUWoAxANWwl8YTy827+hFDhpwIQ6cT+Sw2NedHjLhr+zMTCVAzvyRx5HAfvyGsk7LsP0X3QMAKaibTA/Uvgr3pYKf4d6JyV1pu5yHLK9vO46KsMeaYx9dlEvrSFCJiFM3vbDRk82gPydsDtjoq0wGPEhmSAhCyqRFWOZBGGDkwnYWmFntIdQ0Jh7aC9jvVHEdv1fWsCAAYCHUsbohXfJ+8LFMy4iojyqsn3Pze0f3+TaRK82riR47RYj0rCxak2nPmvZEt3B1Tb7TI3UKYQbFkKXLdUNKg7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DPGVNHGjYnHppkRM0+7yzb2XoFDLBsGcGf04G2Mdlk=;
 b=fCvKDcmeiq4oCo7nFPkrTjrw9QTtWkY76IFWKA89NMxcH9aW8nzfHQvRTPIvY30Y+vRkeBCRzZJ6T0pZe67qBM3LhBtWoA4CbdKq4Ifu9MSw/w4L8td0qJTZVMyOSBU1WPi9h46CXGX1xhprb3jku4CO3TtRSUIThbn63qoQZag23VQ8hl45kWi8QgJfgwNd5ChzuyX8oMlwHSyxv7Tcj8XRZZfEeCUMx0Q7chx5o8pu2UAaWF7FwEXLGr66ETA5VJPPODIVgmNoO0nBFgm0HPYvqejwpb2QJ2Y64ukSPzNKGgGZEyGFLAr0qTEWZeAWB2li7yykj0dBQY5t/H+kgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DPGVNHGjYnHppkRM0+7yzb2XoFDLBsGcGf04G2Mdlk=;
 b=Se/VvvEWO/YmH+NKoxcwRa2beWdL9zPyR7dqiR0bU4zM2ENm9T9GSjYQFRq3wNwN4mW1ghzKweh3Z35CsJLJkj074cDWg1pLTkuk8RJu6EpDrx1A3zgcsmYmXYNaSDRyXpP9pzajL61wwAAapHl83LOUHVamNMS8k5A9N8tzBog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CY5PR12MB6370.namprd12.prod.outlook.com (2603:10b6:930:20::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Thu, 2 Jun
 2022 13:37:56 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%6]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 13:37:56 +0000
Message-ID: <71241cfd-309e-a370-e84a-61af3ca23398@amd.com>
Date: Thu, 2 Jun 2022 09:37:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu/display: Protect some functions with
 CONFIG_DRM_AMD_DC_DCN
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220602023136.836224-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220602023136.836224-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::35) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c55c8f00-423a-4f23-5432-08da449d19e2
X-MS-TrafficTypeDiagnostic: CY5PR12MB6370:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB63707D1175D58E8902F76F4B8CDE9@CY5PR12MB6370.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ntrAWmKYkQUjrdSy3FPJPz2E9HbcxHkwgf+TYzQUsubCdUlWgF/Nr6VNGeDNo1wV4rfeKCrzFJJQff5bp/OkcbwfIXyQteMXwFXPKtbKxg9lrCMuUXRscW//nGGGjweBl+LDDz73cHLVq+Ij4yn29yxnnmmNiqMc+3lBhCVP/eIrcez2vT8ZdaA3IE9izdT4NcSajnMCVG6g9vd2M9TlfguT5/u/oQi71w8XebWmpff1/wAhzmAdHWKfgr+/virSKzF/2kemljVK7iATTypN1h0quA7pTqBElwqjhx6wIHJ66ABMiK/ZdAZueNVdYona8QLaFKUXCY95WzhtIgsMOOMRRakCslBuG4rDa9g1sek52RQmbm4D27/QbjHTHgIVSnMTdTJpdBBd+GpQ6uaAzi9AaVRaGNQj0ruLp43yhaDLrDzwlk3owpkpoV/NE23qav5f40mdWhGFiLo7dN66fcDTXtoc5G4xC7FciJP+EEuTIhJrfUiw3zQSTZuqX54SVznXQIfQei2DSMmqL5xSX4/OONXsbeO5sYEOMPH5ZPI/ENt5JNmk2veaiE5rrx7+gEuDgh/qb4R4lrPfq62zGCeZTN0oSBtZAF0Fno0LmACUQv8nDsDx9NvhV6dQdxeBYDXdMMahFigp7u/gpvuVfzM7jVGz9gs2ftS3osKE/t86n37fdiAlJpH1SFf0yFQoCsLVvAQ3cM4j4sqZemZ5TnWwIqvIUzz8MFVVVgL4WL3yuK0GDSYIVoSj+IHEram
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(4326008)(6506007)(86362001)(508600001)(26005)(8676002)(53546011)(6666004)(316002)(66556008)(44832011)(6486002)(5660300002)(54906003)(36756003)(83380400001)(31686004)(66476007)(186003)(2906002)(8936002)(2616005)(38100700002)(66946007)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTNZQzQ5dnR1ZDBGRTJRa2NDOWZkZjV2UUJURHk4ZC90S0pMbWg5S3M5K1BV?=
 =?utf-8?B?MVd1TW9ZZ2JObG1ZN0xDMkpjSmZIaWd6QitXRVhEWHpVOHo1R0hSS0taSzZi?=
 =?utf-8?B?bFBwbWt1ZVdWalN6TGdDTWVZRHFvYkU2OEVqTkFPR1d0NTRIWjUzQTkzcHVT?=
 =?utf-8?B?ZmdMVHZCRTNsRXowbWVXVGR5NUJQNEhMa0R5TnFFb2xYVGRHSndWMjhXZ2g3?=
 =?utf-8?B?eDdPbmRKcWM0Mmk5cVlyQi9CbU5keW14WEhoQjY1aEZLRExrVnZNTVlhUUpD?=
 =?utf-8?B?OWE2U1dVZm1td05ER2grOEdWdksxRTZjSlQxMmpId0hCZWJWQWpZcXNBNS90?=
 =?utf-8?B?a0UxdVhPZFFqWkh0OXhpbldnSktHek9nMnF3NzhoSTZFUWdqMFVZbnVITVF2?=
 =?utf-8?B?emg3TVZjNXlVZUFaYWk4NGhPRFJvTWZ4WEk5VjVUbnRHaTN6SlBhZEVieUxU?=
 =?utf-8?B?L1hxNjVFcWNQNHpqODNZQi8vUzJidTNnRUc3dEZnNC9UaE92aFJLYThXd3Na?=
 =?utf-8?B?Umd6Yy9vM0svSkd4VzRhKzh4Tm1TNW5veVA2NlNlTFI4ajFiTHcrK2FnbVZy?=
 =?utf-8?B?Z0V2eWNGcEs3N1dhaGdrbFpYNll4RDNIV3l0ZElsTDE1NkhObDRLeW5leFRp?=
 =?utf-8?B?UXd4Q3RCN28zQm5wTUw5SUlJNllIQVJRTWlUa2lFZWdBSUh6TEEyMWNVSzdi?=
 =?utf-8?B?UnlsUEkycFArWXRRVWdSdEd3Qm1UNENjOWphVmxFbUpzSkk1SkN4SXZ1d29U?=
 =?utf-8?B?ODIyMEdETVdUQzhRL2wxNmY3cmt3Zlk3M001dVpRRkpZWUVuWnlFZXNsblJL?=
 =?utf-8?B?M0VLaUpVSHJTQVdtTjJPQldBcjlWVFI3NjQyMEt5VGpPczB2MjZHczBtQ212?=
 =?utf-8?B?d2JtcXV4UitiYmtzWXhQNnYwclExZVZpS0tzUVFBRzhTdXUwMmdySUt4WDdC?=
 =?utf-8?B?RFUyVnczdHhKeFBaM0YzZWlRR0x0eUtyVTlrN0RNcHlMcGlweGpwYXJmMlNC?=
 =?utf-8?B?MHRaeXBObWErSktxZnB0dndBRmZOWm1OK2xHTURjYnh0Y3E5M2pyWGtieGtJ?=
 =?utf-8?B?ekVCUUl0ckNCUCt4YlpvNktYQVd3cW91RUxMZmJvZTZYamk2THljeDJvaDd0?=
 =?utf-8?B?SGtudGphdmU5YlFpK3NmSWM2VVgvNjQwVC9yellzQ3V3QTMyR2pkV1hRQ3Fi?=
 =?utf-8?B?YkFybXk2ZVlEcDZQcVBHcDRyMVlydXdxV3Y1MW54blNHQ01MdlpzNDBpUDc2?=
 =?utf-8?B?dG83Uy9zZ1V1RFRlT2dBRzhYaHkxOHRIcTJhY1hKL2J3UmVyOVQvUzRJUms2?=
 =?utf-8?B?enBONE1hWitpMGFzanJHZ0NkY2JxMVd4TXdFVDNRVWFaMVB3dGhjWkR5SmFK?=
 =?utf-8?B?QVAweUw0WHhTQ0ozT0hYOG5BQWxTRDlhT3RZYXdNc2pWZVZOY084aVlQNTh2?=
 =?utf-8?B?ZVljQ1IrYXVEQnJoWWRaZzRBS1VmNnAzMUpQUEtYelcyY1VzT0F3ejZMMFFY?=
 =?utf-8?B?T1dyWU93Y2RXRVdXbXY3V0RBRnBtNEhORlVGakVmN0FyaEhTZTRjZVg1dUZO?=
 =?utf-8?B?TkNGTUduTGhpb1B5M201Z0EvamtIaTUrN3k5RmQ0czUvOXA2OXNBaWd4SXFT?=
 =?utf-8?B?enpCeUgydHBML0ZtREdCZUtkalNUUzNiQkpKZENxWTAvelYwcEVuMkhtNXdT?=
 =?utf-8?B?dmVLbXFFV0gwSmYzY2xZTWYwQjF3ODAzQXM0aVJqeG8ybFBYSloySkRCbnFD?=
 =?utf-8?B?MW1FSUJUQVl5SE9nenlLVEJ1YVhTemZoOUhKb1k4U3hYSUVkY1VmR2xjTzU4?=
 =?utf-8?B?UU9mbGptRjdxakdHWTZUbmUrQ2FTdzhiN1FCN2dNd2VmdGFybklJS1dsaWNt?=
 =?utf-8?B?MzFUMDZSdW90YTFHOERpa3IrSWtoUnhFay9Ld0RWUStnSkJrcFcvNnVBd3pE?=
 =?utf-8?B?dXRSWGNGZHJHbW9tSlBmVmVCSlRVNk54YlB5T0hDMXVyZHVvUTEySmY0RjY1?=
 =?utf-8?B?MUU1c0lJWjVEdW1qRU05dHZZWjNOdERiSVBsOTVwd1ZJVTRKTzZJTXhuUC9Y?=
 =?utf-8?B?R21pcFppN20wckZHcm1oaFBBZGhrV01taVpWaUVxWmFBUit0N09yNlZQUGxD?=
 =?utf-8?B?UWNPbkw0K3Z5OG9jNzRRaVllK1V1SDVSVWQ3QzhpQnQ2MFB1MmlUZkRVVXVC?=
 =?utf-8?B?ZWFJdmdodGlPWHJaUmpWNHVJTTdvNmNyT0pQVEg2VVNEUHBzRDI4K0VDWWNi?=
 =?utf-8?B?YnFFWnVESmRzL1BPb2pZbHlBZ1B2UXhYeXFMdVM0VVR5QUJkbzFSRHh2a0pD?=
 =?utf-8?B?NWFweFNBK2U1dVF6ZWpaMTU4N09ERm1hZXBUNVlodGpRZUp6OFhEQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55c8f00-423a-4f23-5432-08da449d19e2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 13:37:56.3038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpWSGOZ4v5HHJz5ECW+DxZ7EEGms0A0EM5iaHLHvV1iNnbvZ9I6gYHdikKv9pos3bk4C/4V/oj/2ST+msNmJhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6370
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-06-01 22:31, Alex Deucher wrote:
> Protect remove_hpo_dp_link_enc_from_ctx() and release_hpo_dp_link_enc()
> with CONFIG_DRM_AMD_DC_DCN as the functions are only called from code
> that is protected by CONFIG_DRM_AMD_DC_DCN.  Fixes build fail with
> -Werror=unused-function.
> 
> Fixes: 9b0e0d433f74 ("drm/amd/display: Add dependant changes for DCN32/321")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index b087452e4590..a098fd0cb240 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -1801,6 +1801,7 @@ static inline void retain_hpo_dp_link_enc(
>  	res_ctx->hpo_dp_link_enc_ref_cnts[enc_index]++;
>  }
>  
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>  static inline void release_hpo_dp_link_enc(
>  		struct resource_context *res_ctx,
>  		int enc_index)
> @@ -1808,6 +1809,7 @@ static inline void release_hpo_dp_link_enc(
>  	ASSERT(res_ctx->hpo_dp_link_enc_ref_cnts[enc_index] > 0);
>  	res_ctx->hpo_dp_link_enc_ref_cnts[enc_index]--;
>  }
> +#endif
>  
>  static bool add_hpo_dp_link_enc_to_ctx(struct resource_context *res_ctx,
>  		const struct resource_pool *pool,
> @@ -1832,6 +1834,7 @@ static bool add_hpo_dp_link_enc_to_ctx(struct resource_context *res_ctx,
>  	return pipe_ctx->link_res.hpo_dp_link_enc != NULL;
>  }
>  
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>  static void remove_hpo_dp_link_enc_from_ctx(struct resource_context *res_ctx,
>  		struct pipe_ctx *pipe_ctx,
>  		struct dc_stream_state *stream)
> @@ -1845,6 +1848,7 @@ static void remove_hpo_dp_link_enc_from_ctx(struct resource_context *res_ctx,
>  		pipe_ctx->link_res.hpo_dp_link_enc = NULL;
>  	}
>  }
> +#endif
>  
>  /* TODO: release audio object */
>  void update_audio_usage(

