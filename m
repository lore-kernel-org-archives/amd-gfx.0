Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBF6C3ABAC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 09:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E887610E630;
	Tue,  6 May 2025 09:13:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dt+QBr3c";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 706D110E639
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 09:13:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uch7ZRcX/stSaZ5GRA4NYPjMbZrry5ee9e8rX4UIeVmyqIzQTg2CpCfiXVVwyrhprSNDbYdWK4DGGZ579HXpoREH8cdClf1pwRucJfEw3mPR8YqHUx/NSksdrsEnjFXiuJTZhGVAAsJOdjLljZDf6PXoPDmKJQHk0MDSNMcBISU5HvQhRcObibcAPVJxa0ELv9G+ZqguDFfMW32lvVnIUWGb2sZyRu1kXiKeiQqWwuboo+QbUtv/NQ5Zi9V0tpaJKZcfjN9IELRkLxmkAgJCVY9ohm2VKpO53hXEvNfPQTlQ4ZiR5Fs6IgTvEwMaQZHvyYTfPy6EQ3c3R7KWhf0bfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLpP7tySj9G/9YMk+inZr0Rjg5rzoa7NBhKaU4ociQg=;
 b=ox39OnwT/jDkqv9r4UaQf6kAXqL7nZLxnUWamaIovm9nWxEzqu2La8gM3NgsV1Pv4ifDJUjloootZHy1YMCAmOgE1y/bTXUrS3gZCnmIrPAKqCZ6Ssf69uHdoO5gZhG6wpk8ZiRKxS0mFrToYV59R6cXx3YaNrV/fzTvDzIsPUJdB5PF3IP/K3iVY1MPBlkhljfLeMjH37TtCv/ZOocBQlo9jGXUBRmHayNd/TrCVFjC5lncFdyjzpEUcn+WV3P+d6p5i648j7sktMl/MVNowHTDRqgEbBG6YvvLP8wmFTc7omWVYmiZdjRo3glR9Pf29zWwQvyVa7PAWN2zPVDs8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLpP7tySj9G/9YMk+inZr0Rjg5rzoa7NBhKaU4ociQg=;
 b=Dt+QBr3c21MKGw39HbsduGMUaB/6TzuiCOmn2E2Ls0NjbqNzMJQ5VMpryLgI3P6KQg5T+Tb1/fybTNzVYGV6YOjpnqtN9iVB0cfD1Je60cUEzQda1OlL5fZhDSV4sw5LlG5XfgnsVRMSWPB1QJuOq2pDZjpQyj9cSNL8qbzDRMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYXPR12MB9278.namprd12.prod.outlook.com (2603:10b6:930:e5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Tue, 6 May
 2025 09:13:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Tue, 6 May 2025
 09:13:12 +0000
Message-ID: <1e32e3d4-d32d-48bd-9f1c-96a530b84639@amd.com>
Date: Tue, 6 May 2025 11:13:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] drm/amdgpu/userq: add callback for reset
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20250430154809.2665473-1-alexander.deucher@amd.com>
 <20250430154809.2665473-2-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250430154809.2665473-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0346.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYXPR12MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c6bcf1f-01a8-4391-d7ad-08dd8c7e39f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFQ4U0FaRlFCdmZEL3gySVFSTUx1ZEZ4aEIra3k5alF5b0FoaUFpdnpZWThX?=
 =?utf-8?B?d21DOW12NzYvRURPWU0zWE5YT0FYYTJOU29YeHZUc2dlOU5EZzlFL2xzTDRt?=
 =?utf-8?B?ZjdLRzR4L1pYdGFKVFhySUsxQ1hXTzJCQzg5Wm5GUk5sVUN4NDZ6L042OEVm?=
 =?utf-8?B?bklPMTJUUEl3VTRxa2h6NG9vWCt0elV4cTc0TkxKSFhhd3RnS2EycXFxS0dv?=
 =?utf-8?B?Y1pHazBqTEpTRWxXM1JvV1FQcG5UdjRCYVFYby9zb29hMmpDbXEyRGZQQ2pD?=
 =?utf-8?B?N3dCa3JjblBiclA2cnI0aVF5YjNsb0U0OW9mYzI2ck9GaVpudnBuellKTExM?=
 =?utf-8?B?TzdoTldRM01OMEUyTDU0akhoU29sVWd0NlA0ZkNBMGlBYU12Qk5sMUU1Y1FZ?=
 =?utf-8?B?bHNBa3lNMGh6TlFoVGMzSG8wdEk0OGxYc092U0NOVVBHRDdONHdFSDB5ell4?=
 =?utf-8?B?YUVUQ1VKN3owRGV5bEh0TVVPaFVhMC9TUTh3YkV4Z0oxWHVoY2JxNHVSbFFP?=
 =?utf-8?B?ZWRURWdORDBRdngvNHZVdVV2VHArclRHU084VEQxaG9LMXduSkFSbFhnN0hV?=
 =?utf-8?B?alp2bk1wTTEwa0F2amViSGl3M2pVbjdQUFJnOTlROVZLaEh3cktURWZpVHg1?=
 =?utf-8?B?QzJnNVFWL1lJN2o3Q1kzMWIzV0JrNjVlRWk5ZWRaMGN5ZGZiNEhCK0ljMTlN?=
 =?utf-8?B?aS8vZzBHK2FndmZWUzlCRVJVY0pCc2ErMzk5Sjg1aUt6SldTVE4yYVlaL0FT?=
 =?utf-8?B?dXFSNTh1T3JtZjJQUzVNZTdHYTBOM3VuNjVSQm41VVEvRkxLZVBTZDYxdmM2?=
 =?utf-8?B?N3FIWVJSbTlLQUl1NGI4QUdwMTE0eG1EWEIva0dNT2NWcytYMU1GQ0c4cWF6?=
 =?utf-8?B?Zi9TWm9YRm5yNW5IR1JMVGRDVThRcXRXNEMwQlQxMy9VZWtveVF1ZXN1dDF3?=
 =?utf-8?B?OFdIYytzOUhKV0N5Mmlya3o3d3lIWnN0VVU4b0JzcE5NbWd1cnNZZU9JS2wz?=
 =?utf-8?B?YmRWV3J0dCtCSDk0ZGtyeUtRMGM0R0gyUmZpVHB1T1JjRTd6TUs2KzJYMk1m?=
 =?utf-8?B?MGVyQ2VXMnlhRUNNd0hhYng0Q1RINXlic29rZFZxT2ZVTHUwaWhIQkpyUnhB?=
 =?utf-8?B?RHdEZnpROHlVb0hubWhnR1hCaW4xcWJlYWpsbGY3RzAzZ3RIV2RlTXFrc0Vm?=
 =?utf-8?B?S3IvMk5YU0xGaWFtY1RTYWk0cGJBSThJMWZ6cm5KWFFpR1lBd3RQU3I0YXJJ?=
 =?utf-8?B?WUt0MWYwK1ZBSXh0VW12WVpJNlIvaDNaZVdCcEZuVTdxa0cza0RtV1hOSTV4?=
 =?utf-8?B?TGw2eWVObEpDTHdEM3BXMGlwclVOd1kvNHdWUi9mMHJNeEtLUThCWFZZVHd6?=
 =?utf-8?B?dWc3RUU5VlphQjVLb2hSdDhNN0grblpHY2hFd1c1dnFuV01xSFQ1YnVjeGkv?=
 =?utf-8?B?L0lOVVlDd0xObFZWZ1hweElSY1VaSVE5WERvMjh1VWpGZTl2QkhEZHdsbDky?=
 =?utf-8?B?bWJpQ2plZ05RZUxXQldQUFYwcVZnckx5R0o3M210dmhhV1pBUkhqajNkOGNv?=
 =?utf-8?B?UjNlTm9qSHJGSllJUVlacjRSQmJnL1A4OUxSMlBNNDlzU29OM0hzc3U1eS9J?=
 =?utf-8?B?MS9uR0Uvc0V5dkprNGlEOE81cy84dlRWRlpnYlNGcDZpN1p3ZFVySnAzbE5i?=
 =?utf-8?B?VExpTnVtV3ZDY2cvMGdVR2JNSFFHM0dJaWFEYVpuYTJJMm1yMllFWS9uWGg1?=
 =?utf-8?B?azM0SHVXSGl4UXpaVkVuZThGbWxvcjFobkRhQ2xSQ3kvaTZnZy93N0dPSUxv?=
 =?utf-8?B?cTQ3dklDSDIxSFFSbmNXaTVObHlrY1BCdEkwanJoMFowMFY2OFRaSjE1S01U?=
 =?utf-8?B?K2N4ZnZ2ZDZNSzFFSVU3SDVUeEV4aGdBY3lJaUdYRmRBbXVlVUthWGlTcE8x?=
 =?utf-8?Q?ikopYZjQihw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlE2SjFFYmd1dWVQOVZhRmxjc1hEVm9BaUZqelQ1UUxUK2ozTVdUU05iU0Nx?=
 =?utf-8?B?VXlHbjV0L1VvdWRLdkhGQXIyY1hKdWg3a1RTZk1KZzg5alVJSlI2ZWhXaGZD?=
 =?utf-8?B?Y3dFUWhDbHg4d1lOQ241eXN3UGpzQk1zUEZIQlBtcld6bWJMd1Q0SFZTSnhG?=
 =?utf-8?B?OStKYUtORElBY2ZPaTltdTBtQmZDRHJsakJWQlEycW5IN2FJaFB0TUVoUC9M?=
 =?utf-8?B?aTdhQVZSMXNYa3hYb24wR1kxL0JDT3dhRUQ2RDFyUTVOb0VIUHV0WEo3bU9V?=
 =?utf-8?B?bVRNdzMvb2FSSmR5b3ZNK2JxRW1zaWNYK29OdmRmZGhOY2pLOGNvemFRUW9j?=
 =?utf-8?B?WXhtYW4wd3Z4bGU2aWVUaTY4OGtzNDh1bDZJUm5lZzJzQ1ZGOHdlTVZzeHQv?=
 =?utf-8?B?WUZPT01zME9xR1FVbmplUEZaYnZuOVc0ZG9XRWxGcmNmMHBsV3FtRnBCQk1o?=
 =?utf-8?B?cU9oYWRpUzUyanZhcGpzZWZMd0tRbTZiemNrSmRQZHBBUW5sNGtFaTAvY0w3?=
 =?utf-8?B?SXVyTVRjY2Z3Z2JYY1JOTXd2SnJuSi96ZkJTQXVEbXR2ODNUNE5XYzVwYW1u?=
 =?utf-8?B?ZWx2ZDErMElFMmE1Nm11MFNDWW1hR2ZKZlZpWnc1Ym9GSzJwSUwzRVRWMnhV?=
 =?utf-8?B?N1o3dVZZaTg0SkREQll5UTB1WEdDbFpRR1dlUU9iOU1DV296OHdNdDFxOHpw?=
 =?utf-8?B?dGZld3BjWHVwYlM2eUlHOU84ZTBOUUxNaTZVL1NiREQ0eXRMcWFRWDIzVi9T?=
 =?utf-8?B?UVlHQTlrNGlOL0V6eHJxclZlaWdFTnJkUWY5emZ5YTc4U1pTbTVaVXZrYUFT?=
 =?utf-8?B?T1k3d2ZxVE5FQnB3a3l2STFadWdxZ2lQcWVRNzVCMGFKYm16blBMQkhZMnZQ?=
 =?utf-8?B?djl2UWpzSjVRLzROT2hNS2NCbUVYK3B3ZTZkWERqNjhRVTZlVVpmVTBzSXlu?=
 =?utf-8?B?djd1WnRmaWNvN3NBS0RzRy9iOXM4OHdkd2xocEhpa3NHSGoxaDJUV2VVNmEw?=
 =?utf-8?B?MDFlMVRyTjg1cFkwbHRFQlVBQW10cURXT1lXL0g0RE4rSnVlbi84aUpaak93?=
 =?utf-8?B?ZXdhS1hrNkVQN0dsK2pZSitacUp1bW5CQXFLN2xQWCtxRTJjQVdJMG96cW9p?=
 =?utf-8?B?bVRhbWx2Um1ENE11QmE3MS9xWWEzemQ0ZitScmhSV295RUx1NmdXWndueEdB?=
 =?utf-8?B?ek5wTXE1djRhMzBIZHRKZUtOaHA0K08wZHRUTVRJZFRXOGh1U2g1WHV6cWFN?=
 =?utf-8?B?YVdlVXkvcGlLb3dBRDlvSmgrVys1bHFDMWZaVGtUNEViQ1Z3bXBOOVd0MWhq?=
 =?utf-8?B?QktsM0pqUis0ZHJER3dwem5TZll5OTR5ZGtSTEU1VVVHMTRCaFBoNm1tRWFJ?=
 =?utf-8?B?T2hBQmpEVDdJYklZRWFleVRIOUg5emFBZWtCaE1yUURzYUgzdDg3bDBTTDVS?=
 =?utf-8?B?Q3NUM2pZK2NJdTQrTEMxdk1vRTdrdThGRGZqTFdpeUp3RmFEZ1FLeXcramR4?=
 =?utf-8?B?Z3JTRWlIZmVHUTdpT0FnQUtrODE1R0VhRTYxVVEzSlhiL1BqM0lnbVV0eEs1?=
 =?utf-8?B?Q2hTMHBLOVVNamNYcXFOaVRBYlFBTXU0U01aS0poMXNrcGp0bGJVMlBQMkps?=
 =?utf-8?B?dUM4VGs5L1U3UzdaSnhUb2JpbDFxUkk3ZVdENFVFeHF6aFQ5Z3NkYkZ3aDMv?=
 =?utf-8?B?Yk5zY2FrS1VHZXFNZEtsUjdMQzNSV3NDcTBvb3JYNzIwTi83QW83R05aa1Bl?=
 =?utf-8?B?ZXI5blVrOXZyT3BjM05xNTRXWDFwREdBKy84Rll4WTVDb1BJNHorVVdyZlpk?=
 =?utf-8?B?cHNSeDRRNnhoMERpSGs2alk3SWI2aVh6UXdEV3l2bGpZOTBycXV0TVEvdW5N?=
 =?utf-8?B?U1hCalBFbFpheUVnWlFrNDRpVjRiNVBUa1JZVkRHaUJZcjFGZjhQcWhLZm4z?=
 =?utf-8?B?YXFtWjVXTVFLc2l6TEJTckY4bnZmY0h0Vitxb0N5RGVac3J0Sml3eWNHa1hX?=
 =?utf-8?B?MUVWcEE0V0I5M2FlalIzMnRrOTQyaGF4dldMMUs1VHk2MjJhaFlTYzZ4OGVt?=
 =?utf-8?B?M0h6WFNsVmNlbU1qNldJNWNWRUovQm9OZXlRMVZLRitwVUZFMjZkdWtTQzNw?=
 =?utf-8?Q?TH1mwJI8w7ltNQ/tLM3fHbOk+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6bcf1f-01a8-4391-d7ad-08dd8c7e39f1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:13:12.5207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WY4Xsn9T7msuOHd8ldwpLUnQmOF2/HkFMHbwGhhnYZlnoUL4OP7CUg2bNlEHUk2z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9278
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

On 4/30/25 17:48, Alex Deucher wrote:
> This is used to reset a queue.
> 
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 4d3eb651acf1a..24d201cdc9887 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -77,6 +77,8 @@ struct amdgpu_userq_funcs {
>  		     struct amdgpu_usermode_queue *queue);
>  	int (*map)(struct amdgpu_userq_mgr *uq_mgr,
>  		   struct amdgpu_usermode_queue *queue);
> +	int (*reset)(struct amdgpu_userq_mgr *uq_mgr,
> +		     struct amdgpu_usermode_queue *queue);
>  };
>  
>  /* Usermode queues for gfx */

