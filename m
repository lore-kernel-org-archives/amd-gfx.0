Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF00C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 14:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6D9710E586;
	Tue, 11 Oct 2022 14:30:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22E5710E586
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 14:30:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMKnLSeKUg3Y0EA5B3d4j7iF97be3y5e8KMkuUwCh6nVIeF1/mW5nKJkXSxgQEGAt1ntPhtOwXugasVE2oiw1GnoGUPb19Sj3LBFAxK1L+DahnArowAp9tuSxXvwsoVOCOSeoeVP7N/FTQqaD8eF6aGqkcUxHx3+6+9PjtIZtfOSYY4JwFzY/pgAqfVBqij2WPDAzzW2Lm0f40Hu1S5U07NLcQ0j9UWj8WhkUk/AFB65X4c3HXWqHI2kHhhiuKjptlEd7GBDfBTaldJHCqIEzBt7lT/7XyNoQi7IlWoarRmOEM8EtFB/WVesWdumOe4SPZaVFOq6eQwNfT/PBeMNyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xha5JgMD7nsTyuV9pkRG+ChvlWTdTDpTCdInkbxUeA=;
 b=mF/Q7wGeeymo2H8TPs0fW3xnjNsngnwU6box5+apC4v6x3pFgC7uJCJVjYc60O6gk35mv1gWXaDVXWbwIW6g8w+v193jvuZi2bzhREvCnYeixbEGR2npF2vj1LwGXyenj4Iy0UXRpApw9TWj8aXpA5khXiIn1rZIQoHH9kctx56XZDVsp1j3zaGGCw/uYUxJJOZ4hRNrVY1UEjMXAarHwvHZPjZDVBeSRf3aFBPqLbTVKTXY7BIiVUZHrkCWHjXO21TpKK9GI122gQTAPkz6+oJMmuyy31xguPRlIC0tK5ehsZFUQmeCbH9qSKaFp4osv5wFQhgNhtdQcotFc1p55Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xha5JgMD7nsTyuV9pkRG+ChvlWTdTDpTCdInkbxUeA=;
 b=lYX967AoXtMFYlI3e05CIp+U91a9w714N0aAlieppQbQpm9V0s3tMBaV9mA08eUN2pG2K1uNyEBRZoV9Bs7QG9dYf5VcPYWeAxXyjv4Uf16LnDMHYKTryOTuKX4+0ZkznTTAyuA9bBLLSi98dAHuoqZs4UaTjqbmtpz5cuA+xAo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MW4PR12MB5643.namprd12.prod.outlook.com (2603:10b6:303:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Tue, 11 Oct
 2022 14:30:48 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aef3:6aae:b904:e395]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aef3:6aae:b904:e395%6]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 14:30:48 +0000
Message-ID: <07a793ad-c932-d27b-a84a-08a693ec895c@amd.com>
Date: Tue, 11 Oct 2022 10:30:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] drm/amd/display: make dcn32_split_stream_for_mpc_or_odm
 static
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221011134148.982341-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20221011134148.982341-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0270.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::7) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|MW4PR12MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c23dc7-7e89-42c6-fc73-08daab953099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bgtDcgYrIZzfTxNvJ7R9HNRPJC/OR33wifGCgpZqtIf2Y7dFVzJV67javF58xBIF1c4abgCqcIuVbICUETCiZXeEXlg1kETggazRHQXnS/qliNJJFl5HAiJSvGY6maiTcXeAMVmuUbrWy2sVXX3UAZZjU6aAXhSVewCJjWKwVOsxyEYCef3OTXgYVFgdTbSBdFLSomAT0YiRnpOmcg0pQD9aMpkPnIuBsSejShA6j8chth8miuK9gecHtk28Dr1JinzLsckL+cfjXNXzG/jtgcaDoKk6m0l6lBFwIleweRImXdaxeZ95gZKnsCYBf5nMIZf+w0pUVDFDCNzAta5Ezvo/EHRtHaoFS18GDR55LHTdHyt/GeKbeWrMcFa40KaKKU2nsWE5NCWlLLg7PDi3aFx7jfQrISwTLxLygmmteYZ/yNqc0RPEcSVI9kphRdOmNw7NigFl3r6sENpeLQzUJHrHBRiECG+IvSH2LxikO4l7xUWGgckQWmy92hONUqRVyvDHm1R4tpC07QI5RA72OTM5ERhJKwzXfu5e/es3cEDJGcoCkhMVCuwpMTvr4KmdctwjjGd/fw279hW7fIwVamzGIG5Q3cF66pidZNYIZuYPmGjqWsORzLQQzXZuf7ogQS+co/e8RUW9lMR7mj/Czd4d8fY4N3eTxRfDiGIJRQHusOAwHWjOfWkzXQopoxM7bwWREiTS8A8eW3oXJUmax3/u8op94IU+RpdvcJjLRpaHIcVQrTn1qxysFNxHDhuS8RmMle4O915i77qVphPxsQVW1Ya3GU//YmrPw81jhQM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199015)(6512007)(5660300002)(26005)(8936002)(36756003)(2616005)(4001150100001)(6506007)(44832011)(53546011)(6666004)(66946007)(66476007)(66556008)(4326008)(8676002)(41300700001)(86362001)(31696002)(38100700002)(2906002)(186003)(83380400001)(31686004)(316002)(478600001)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFdIeXNOUC9NR0ZtYzRxK3VrVHlqdldtMkNkN2JXbnVGa1hVeUYvaFl4STUw?=
 =?utf-8?B?NDIrdk5ESW9HS280b1VLOUVWUmxWT3d3UkdKT2gvUEtiQWhkV3N5d0pxWVJ0?=
 =?utf-8?B?ekt2akRSUTk5Sys3b0ZpbWRGbFBUeTd6NEJVVGptUzJ2ZmMya3JmNDFaMWp0?=
 =?utf-8?B?YmxLSkVFenRiYmxQS3F6RGJDVFRNV0VYUlZmbnlBZlhWcVlsdWdIWkxUUXhw?=
 =?utf-8?B?WFluWmZsODBhK2N2cjc0TkhWb0FrNElMZ2dMeFlIVzNVMFNQYTFteEM5N2Zu?=
 =?utf-8?B?dlVKZk12NFRBMU92a1phanJaWXhKMHlPZ2xXbklkRWQrbXFnUVFQa2JMdnBi?=
 =?utf-8?B?NklmQzVxSWlkZTdoZ0FzNCtVNm93QmU3c1BVWnBkdmlDc09pYmw0NmcxT1ZB?=
 =?utf-8?B?RWd0WXJ3dkdKSjZIUGt6czVSNWtkUTJSYXpoRjdLVVZMUmo3Y3M2cjVDc2Yy?=
 =?utf-8?B?UDIyYmxVL3RpV1ZlMDRKOVNPZXFmTE5WSTFEWGNaZ1NGRHMrQnBkc0ZycExF?=
 =?utf-8?B?YlN3Q0c3V1o4bnZWdm9vanhlMld5QUNVZXdVZ3hyV2dWcCtmODJFdFcvVlVj?=
 =?utf-8?B?VlpuMzB5SlRBb3JuamlMN0RQSUljekhXSE4rN0h6Wmt6RzlUZFlPZm96MWs4?=
 =?utf-8?B?OWl6L3VpUFZYZ3RoTjZPZUNxck1BTjU3RzlmaWx1SVo4dHdNSHlGNEhta1V0?=
 =?utf-8?B?R0NJYkpQNjhnekl4VUVLS202NzNyMi8wVXpxRFVuZDJrdW40aWcwMGF4cDMr?=
 =?utf-8?B?T1hmcG80RDF5WlJQdjlSTWRoM0NTUjNubzRIN00zc21WNk1yZEJ3SFBRRDJW?=
 =?utf-8?B?M0R2NzVlQzd4dWFxbStteGVyOXNWRkdMV1EzRkx2RGpFR3dBdEhlOE90K3ho?=
 =?utf-8?B?ZFByWDBaZktjaXU5cmlFV0tnL0VISXpkYStvUjc3eDdiQ1ppVFFMdVBueERW?=
 =?utf-8?B?UjJ0ZmxsOTlyalQxVzFTZFozMmw3bGFSTmtzSUlYQTM3RnpyOXVSYXZUOGVM?=
 =?utf-8?B?cFBCVE1DY01zRzhNQ29MNlRVN05WTXdaUWZNWENZYkk1aU1BU2R0bHVjeTdX?=
 =?utf-8?B?Z1g3TlU2b3N6ckJQNCtMdlFNbEhkNHlmc2FGQmFMSGtKSVNYc0FkNHo1M3Zj?=
 =?utf-8?B?SDhrZ3hUa1p3Qm4vVTJEVTNOK0EzUGFMRzNSbG1FTy9MTVJEVHI1d1I2SDJ6?=
 =?utf-8?B?RUExUGJkcEFRdG5vbWxQdE5TejdXZ1UyNy9HNWJrNVlyalB3bWJpYm9JYVhR?=
 =?utf-8?B?UEVVa2FqUEFWZGs4cXpRSUJZNmlQWlBRU3hzeXc1S2ZLKytUZXhrdDVJdXFz?=
 =?utf-8?B?SllwVFJ2SjBCUTN2Vm56Q0xpa3Qxc0ZBRUlVbTNXcndDYTlDV2QyREF5Z3Zl?=
 =?utf-8?B?Rk1lNDdoNzZ4OU1CbEtXTVRWby9hSm5XNDFuODJBU1owTWgyR0IvZ2R0ZE4x?=
 =?utf-8?B?QlVCOFhzZ2tKSi9FZmgvNXRXZHNRWHFvTndnSCtaNHFVelNibk9LVjZ1NlNm?=
 =?utf-8?B?MjVpUkR1SCt3TVRHd0RxeUl5VGFGb1JyUmtlbkx2Q1FLa3Zqc1RyZG1pSGs3?=
 =?utf-8?B?elMxbjN4aDVPakZEeUZNeWRONXdtTnk1cGNEYllaT29mZFhpZE1XcEtSblF2?=
 =?utf-8?B?ejE2VHhETGlNd0hKaEEzL2tlVStydTNaM0NUOGxBdm12VFY5UHNwd3RGME41?=
 =?utf-8?B?VCsyenNxVi9URDZHYnd4S0tFcllia29IQjBlN2Y5QmN0V0hzWGVWMlNpS0Yx?=
 =?utf-8?B?cExZaTlnRjNiVjMzUDFQRHNVTk9wT0t2YjFJNk13dDdsbWtuOVdYWU80a1VG?=
 =?utf-8?B?aEtRaEF0MDR3L1ZWTWhURG9RZFZHUVVjT0xnaFZmWC9FQmdWaHVyTXVRVi9I?=
 =?utf-8?B?dndSTWVhR2xpWjJEK0t2NU4rcTVLWEgycFZVSlFPUmFJa1BHQmhKRVZyMGJt?=
 =?utf-8?B?UFp3V1NCV0pvU1ljTExUZzdxaWRhVGpyR3A0VUR6clE3WExXZHk1MTFQaHM2?=
 =?utf-8?B?ODhoSGtFK3h2NUxEUmtudXdHbnBxN1JDOVlySkdsNzRNeEhSYngvZEw0U2l2?=
 =?utf-8?B?bkZCckUrd1BLZVQ5bnZtL0UrV0N2MUhidGozMDNVeXA2Q1JDcVo1Q3RMZWFV?=
 =?utf-8?Q?NJrIC6cLxOnkb/u7Z3C2OTnzA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c23dc7-7e89-42c6-fc73-08daab953099
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 14:30:48.2252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYZ6s3b4Or/Lrni1Sx39fnM7x73uC++07fO+qof/7hWKTnOnNxlu6AVcr8xUEYTRLd9GHR5C99jbFoS/a1UxyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5643
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
Cc: kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-10-11 09:41, Alex Deucher wrote:
> It's not used outside of dcn32_fpu.c.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 20dad3813b3c15 ("drm/amd/display: Add a helper to map ODM/MPC/Multi-Plane resources")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> index 2a3f5a485b2b..819de0f11012 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> @@ -1372,7 +1372,7 @@ static struct pipe_ctx *dcn32_find_split_pipe(
>  	return pipe;
>  }
>  
> -bool dcn32_split_stream_for_mpc_or_odm(
> +static bool dcn32_split_stream_for_mpc_or_odm(
>  		const struct dc *dc,
>  		struct resource_context *res_ctx,
>  		struct pipe_ctx *pri_pipe,

