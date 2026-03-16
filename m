Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BE2F53D85
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 18:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6BDE10E10E;
	Mon, 16 Mar 2026 18:26:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WSYfgxh8";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010059.outbound.protection.outlook.com
 [52.101.193.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00E5D10E10E
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 18:26:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bfwrzcd0f/wCj6MtcSCm0qtAbxSEz14qhZZlTGiOBrXDkIVLHT3xRIg+t5oYvp9YmjOTZgrd8ShYkc6nG6rfBiLilis9vp5bPWOFX9p8wRrqMXRhntYGOAtKTUxJvDAIvMJ8pZ+/U6SPrM6MHvpMljuARd2bTSf2F4U94kw2QTTQiU7sggGlmOJosKSph5pnRCy36vuy3/qTbLaR+O9YIcUS/q2NxiAgCYPl7rowtYh5Sv7+C3h1EQs9w0mO4ZJo84PdC9j804z0zSuF2m713sDh+qJGoPhlsTO3yMcG5TsqyHkELxzsXqVczWuEeVZbxSnACVeHkfspwqnjuClEbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ue8HEkBJd6d4rMME+zUkySsduUjy3qouMh1wgO4+lmw=;
 b=WgRfV+WKoHeAzdtVEnCn9Hq25c7JjInwBLy8QSDMSJiLqCxKuHDu2MWFD0+nGBBzYeRmYDopj9M5FpN+GHQ6R0UerKdmfsJX0gQ7tSfjRr7tnu0oKMAiw2X1MbU11enlCN6MJ7Dgl4y5sbxmT25MjkeBUUzrXRWrgIKlvcl0mbfqdf3W4ENL6sD6/wYk95MTFo4bGIdWXPRr7/x2+jcqL5cB+6+QKDp3oKKARP/+Yn/cQ7f8sFeDG/bQxM8M32hAgw4gbcOIn2Y5yAR84+GmHE+L4fgQc6EgkYhLBQNeAwQ6UgRnRYMbLfrV7ej9WMFQv+fGpb8Er4WdZhH2eIgqjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ue8HEkBJd6d4rMME+zUkySsduUjy3qouMh1wgO4+lmw=;
 b=WSYfgxh8kSKPLCtjN2F2QvNo96bRhfwYnITYUMQwAKZPRXFr1N8aJyCHtivb8O//KZvvy36jW0u9Kzd3U0LpplYzr2aiwGo1XqxupLcD/UMdmrXoP46XBqa4szvEYxjYWIxpbngs2vFH8zAWIszyLwOfzPEF+RoDLMsPgu+O3QM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6224.namprd12.prod.outlook.com (2603:10b6:208:3c0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 18:26:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.013; Mon, 16 Mar 2026
 18:26:18 +0000
Message-ID: <31a902f1-ae05-40ca-b2ba-c08dbb2bf827@amd.com>
Date: Mon, 16 Mar 2026 19:26:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] drm/amdgpu/cs: return -ETIME for guilty contexts
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Jesse Zhang <jesse.zhang@amd.com>
References: <20260316181648.2005897-1-alexander.deucher@amd.com>
 <20260316181648.2005897-6-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260316181648.2005897-6-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0228.namprd03.prod.outlook.com
 (2603:10b6:408:f8::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b304926-81ed-4996-c7c3-08de83898424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: /VMlYW+9VWlvOwuaFP58j/NHT4YvwLPKyzF80xcQyX0Aa9V9ll4vEA6JjR5OjpCvpQIiTbUm5teK5LBwW+C6nQ9uvWGeQz3CA9QugYwYpwFjNT6Ywy779JuMkrMqKv/6+r9jQBXg+IH1bN3kn+naV1DyoE2QN/iZjsdyybOReCsHaayVXBo70JvK0Wk+U75BpZG8FcITHSJ+mTmZQWuzoD4CWaIUt9c0NIL6xM+hD1YoJo2owLBZ9caAHI4Thpe3AQBh4eMm6c9BbaCH+W/hEphWhvpxn/xbEH0HeP1+yhiVclY89ovf2RIZ+4rk3CNEeh0tHfzVb9PPYfi8UX5/CPrbu7mavutx2gWQlzlRyNh+lNVmS6a1W81uUMJ0EJs4JbKmXY9wAQeoUDQjTglSFXBHe5e6y5YqyBSF0qwZFOhOq898XMp0ghwv8krl4XO1Tqc9ZcrFiOzbsLKw1pykTP8C76RRtt1mnVSh17oXTe+ZL0KSEIQChLuPh/jo+THV4jUpGHy9JePImG0TU/3t07PZeWPUGbgcdjIQJ6HTrwjthSjy40+tHzd8Id/I3Kuhh7ChqeUOtpPlJzyuMv8MPXx8E+55uhHcB7ObNG7IXBYy1+9O9pecX2SoAda8SbuzIddiN98ul+C23P/XydMkO+4+GuanIlOuZAepC2ozr0Y0VpgFIdeTVwXWddNeQY1I3KqSskM2LUp4QtLqqAgVj3uE+2HfCIEIzhxA6c5x/Fo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzcvbEU2ckRzU29HcDdDRHNNZ3pnNjBWMUt2YUZiZkZvajBhWU12amF4azZT?=
 =?utf-8?B?U2NCbFR3UXVQZ29xTWtkVmFMYUZ1RGdGTGZtKzM3NlVVT3JqWFdCelNoTVcz?=
 =?utf-8?B?dFl4TE5HN1pSMnAzNXBOaUVFMnNnUzczVUV1aGJWd2lxNmUvTkhRdkRlcElU?=
 =?utf-8?B?c0NramZtcHJZK01IVXNOdDZWTjNGRS9VVStKZkd3ZUEzQ3M5Zm13RTE2Y1BF?=
 =?utf-8?B?Nnl0UFlrQkdaN0RaMlhVcnRxSERNUVFmbGFnN3F0N2o3eitUUDJhNGdMMXBD?=
 =?utf-8?B?K2Y3K0RkaytLajdOQkVHYkxUNTk2Nk0vR2FucVJNUU85Z1VHMjdIVW5pQXd4?=
 =?utf-8?B?OGl6WEcwZmpyZk8yZVZTMUVkaG5JdkVxYkhYSDBOUndEYXY5QUVsV281YXpQ?=
 =?utf-8?B?YTRkQ2pZRWd4WG9EZXNNMHFoc01CZnVhKzBhbHFtcERTWEVQVml0VjFKdXBl?=
 =?utf-8?B?UVoxT2ZpMmptQlhBNUZPU2hhQm1la29laWtnYmJ1Y3A5MkNvWlhYVmp4QkR0?=
 =?utf-8?B?S3A2N2phVnBLMkIyRDNGaEIrVEwrWDZyOW1tancrZ21OSEMrbTE0ckdnTU1j?=
 =?utf-8?B?dms1K2YzVGM0d3hpR2U2TkR0VVRmWkhsRU5CNGF6d1YvYVYrT3RLTGN4ckZk?=
 =?utf-8?B?aGNHK0lHY2dQWjNmMG9SRHp5a3JhekVKUWNjbHFmN1F1TXRuc3ZINjZSUi9M?=
 =?utf-8?B?dmJyYlh2WVdRRmNaZE1ndUx2S2M0OFRxZHI0ZzVJR1JWYk5YcGJ6T2lIV01i?=
 =?utf-8?B?YlFkV25VWEhjWTlNbTZYMXhiY2E5cG9qMXNYdnI3Y2dKNzBMNTlPYjBWWFlQ?=
 =?utf-8?B?SUN5ZVhIMzBDNUhQaE9NMUdDeWJNNWlUTUM4YWVYb1RsVVhXWUNoTW9nbFMy?=
 =?utf-8?B?UGllRURjLzlZYWFuclpINTBTaHhWWThNQkVIK04vcWRuT0Y2ZmRKK2dJME8r?=
 =?utf-8?B?Tm1EZWkyeE5aL2JIQ3dJQUxlb2lIei9NUU85ZmNob3h0cENrT1krV2xBRWts?=
 =?utf-8?B?TWxZWEx0SnlLWVhYejJ5R1FpZFhaR1NpQzhXOXBMT010enNNWXRXRWNheTQv?=
 =?utf-8?B?WEYrUUw5UGhjSmtLd2hNTnIxbkdzUGc5VEhnTHdYaTE5cjE0NjBic0hzZjFD?=
 =?utf-8?B?ZnlJdE9SekpJUGJBTGZLNFpKc1RrWTBlRGVLbmgvVXRPYzhab3NibU81aXc4?=
 =?utf-8?B?c0tMaUVoaDlOVHYrMENCMnFmaCtITVhQYTI4Z3N4d1hraVoyUzE3OGdXTVJp?=
 =?utf-8?B?RFJOL2MzMGVVanZuNjFyVlY5cnFGNGFEZ1k0S3kxWWdDVGppT3Bmc1A1VVZJ?=
 =?utf-8?B?UVlGSmhaM3p5VzVHTUlHbDlPclF5QVhVb1NOVXdmS01FZWVyMTBsdEN5RkJV?=
 =?utf-8?B?cUxWWWNTeGpnL0hQWWRWMVFlNGViejRyMWEyWStZMEc0M0Q3cHNiVGpLekpn?=
 =?utf-8?B?NUZRWEI0UjBPN0FESi9YWmFqMGlic3d6RHRlV0phZXc2SS9mVU5TL3pJcCt6?=
 =?utf-8?B?OTdiNDlJdGM3NlNuNWRYTVRhQTBBRDYvU3J5NUppSFcxZzRIb3NmT0JZTFB3?=
 =?utf-8?B?Qjc3bHpxSXZGRG4venhHZWpVSXcyWkY2aUVlMHJYM281MUJjdURUNm55SGpt?=
 =?utf-8?B?TUNtOEZtYW1hTWx4b2c4TW53dnRWZmhGUzE5WFFSaThPQ1dIMlJ1MkpIZ1ls?=
 =?utf-8?B?RmNhRFRONE9VZEZpcjVsOHppL29jYm5yeXNCYm9KaEQrcERTY2Y4MzRHdkdm?=
 =?utf-8?B?S2dNR3YvMmdyUUV0ZlQ3R1B1WnNGRlJVV3YvT3pWNnpialNDbitoTGV5c3lF?=
 =?utf-8?B?SUZSM1hOTWlyTTlFbm1BSE1IK1U2WHl0RzdoRDBJUm5rWEFoaEM3SjBkWFdJ?=
 =?utf-8?B?eXU1cmJhM0M0NnZ3QnROY3poNDNTR0RJRGgwYlNINloyOFhLb3BSb0RMZWtj?=
 =?utf-8?B?eUFkcXpma2lQTnBnYWsyQkVoYkFoRUNTejgvbW1GVmx1VEd1eVdWem9BcWJt?=
 =?utf-8?B?T2xyUFd0Z1N2UGNxSmpia1lOWlpTd04xaTR2N0JiMFNENW90aTlxYU1zS2xq?=
 =?utf-8?B?TE5YL3pzM2hEckRyUHdPdldYZEUvY1h1Q1EvQzRwV3RWb0xNWXpuOVZCbHMy?=
 =?utf-8?B?NDVrQitZTWNhWThCMmRhWmZkYXZ0eVNIT1JsQ0pseHo3ZEtjOGNaNVc1Y2dH?=
 =?utf-8?B?WGkrNDZlWnZoWE5BMzFHUDc2cmIrajNkMzNLT0N6RkxBV3JMcnJIZ0Nlb1V2?=
 =?utf-8?B?RUNNcVNSOE5LSStGRU9oNmVUenduVDdPMzJEazNjZUI5Qnl1YmppM3VHQVM4?=
 =?utf-8?Q?QB+uvfSyIndpSUaZyb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b304926-81ed-4996-c7c3-08de83898424
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 18:26:18.5532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJwIyYY5/ZC6NcypS/yoFTmead+bPDg0/F+ULVHx+m6fZ2Lf3WlPg5WohgG3D+ae
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6224
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



On 3/16/26 19:16, Alex Deucher wrote:
> Return -ETIME rather than -ECANCELED for guilty contexts.
> Userspace only considers contexts to be guilty if they
> return -ETIME.  Returning -ECANCELED means the context was
> innocent.
> 
> Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 53e2eec734b1a..06dfe01492616 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -62,7 +62,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
>  
>  	if (atomic_read(&p->ctx->guilty)) {
>  		amdgpu_ctx_put(p->ctx);
> -		return -ECANCELED;
> +		return -ETIME;

I think we should rather stop using p->ctx->guilty at all.

This is just completely unnecessary churn. The per entity handling already correctly returns -ECANCELED or -ETIME depending on the fence error.

Regards,
Christian.

>  	}
>  
>  	amdgpu_sync_create(&p->sync);

