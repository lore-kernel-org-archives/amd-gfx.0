Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6FACD6E5D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 19:46:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF40510F550;
	Tue,  2 Jun 2026 19:46:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YQZr/QHI";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DD2B10F550
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 19:46:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UU+MVkbGoTkhf7cFp6GXyEtH/dsyWU4s3VeZv287ZyvyTo81TGfIO+roQpodzTl7O7kVpJuaoG0wBbWlFIkrtE5T/gPSSc7g1cl4ZH0bK6rKaKTZLcsTlevNO0apptvtn5MxztTP8BcOMn1qtyYOZ8RJCdWPbs8GKwXHRpJqINMaYZIq8NTJYgNdiD6mBB4Lhll7VKE+wWXfNgph4T86xzTWrT57yRYApnWEGULfZn7aV6LBU/hu8PYQlAzpzAQh+d8iyTAYjz3GDDsruyn6ss5UcXzqg5oGaV4TenzVSgr1EmF9xOJQTubseZ42NZc7LHKHpT5DGyN1dNxKe/vDtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKg2+1Tonp3rhPHPp/GIEebkULH+2JoFoPUcaYzNTG4=;
 b=MM0KgUcyDY4UBn/m7z/a4gI+1ZGMoJSZ1709FisqQqGpJnhGW6LkPA42kS+I0E+ysEQvhtH7rk9XYO+nPrSPkll65Folz6uxGTmBXfzc3H2517hYnvBhe9yFNhi5EL8cECqWUUEN9rq6X43nHIX2U57eZzMVr1IIgIVKA60jEbyIjbDaT8paiteS9dvT1/xLC8Ut5/QF5SAOiuRX+pa1zYbJO2AH3thom2a3ZaWvTDfu/Tio7XDyQt/CNKDEDA7j+B+bjNdhlKRa9G9E4MHwyoRrBjZ59TFKJFMMmtbJzwhG1mVo5KLr3/RI8HisDLoATgNW+uGJ1ZvOzHN3ZTRjrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKg2+1Tonp3rhPHPp/GIEebkULH+2JoFoPUcaYzNTG4=;
 b=YQZr/QHID3NA4UwsttAYlGhrT10UOs8Peq1zFL/fHy79V3qdu23K0RMBAL+D4ObQFNbiAHNYLneStU+cWCmhhzp+HC+SCi4Y7pF3KzrKw8gQYJUwKzv0cjlGvvv/UPLaqt7+GcY/LBMxrFcM4L5dpOJsENL3+LTvX6+hMhMCUC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Tue, 2 Jun 2026
 19:46:12 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 19:46:12 +0000
Message-ID: <cf0faf87-a9de-4579-b82f-d694dceeee5e@amd.com>
Date: Tue, 2 Jun 2026 13:46:11 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: widen FRL debug knobs to unsigned int
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, harry.wentland@amd.com,
 sunpeng.li@amd.com, alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260602185904.4165562-1-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260602185904.4165562-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0143.namprd04.prod.outlook.com
 (2603:10b6:303:84::28) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: ab65e68e-7169-412a-df33-08dec0df99e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|11063799006|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: Dmco4hJwbROcPsqQm+Ilx5HdT833IBjogy1c11hKK/JtnNGyd1EluzRkPClAdOEkho5+I+sLF1uoYfOH74iOUavSXg8w/Gq+N/utuaz2jGGB1wkz6BXZcPoXCvbxpGQi1rRM9jbJqpQg80xDHySkpfzz4DHucLoKHelMVZPAidhtEapwtoc4ZoeVkgO4v1GtX3W/p5D4H23jjPqDZ0lRuTBamacD5fPatupdo2DjOg06PCDV9kX6hoaYTT8AE9KDDC8lsqwX2RNotbuKWHoW9ZogPPZ9536lW+8HswePvwbNopJoiSR4BFBt56QSMfl8IiXFp1+V9POoQcM2FXWpTYjAuL9IXLkzbjBiw4LQCLa7Wld9qtN2SsLjqUTx35fPdOsCb80l1uVLI90INR6tL6xLH29tOjOs0q2bj8ldV//wOwkV4mq1hh8oxtF8UoNJYFuZWHC85MRw0QuanhkuTnEIpohl85aIzgc8Clu8xgPhBGfRsXveqxenyrlidJ4xF3XFdBZQnEHNBNWOawWnwo/awR41EsX9udy34Ai/tPo97TFhikxM1nNAntH1ce2oK03x5jQse4Cgmknswqik6VFdoIpMtr0ViUhsuIuGvQc8x0CEpNiiAq531EksUB3sgcVSMA9n7p1GRoklgU//o7L3ddex/Zbmym4Nyb1RLYOLqyYqEX3/dR7/nk35wufa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(11063799006)(6133799003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akZLT3dhTkJ2T0x4aXRhZkdqcnlaMVREVTdJNlZLNHlaNFRpNHlFcWF4U0Uw?=
 =?utf-8?B?eVVqNUNpdG91S1BOQVlXUGpVVTg5bkJjL0Z2MXI2VCtMM0UxZUI1bE9hWTdC?=
 =?utf-8?B?SmFsU1FRTzhSZ1djSkZOWnF5TEFjdEtMSU1laHJseWRtV2Q3dXltQk1yYXlh?=
 =?utf-8?B?ZEFNeGtCNGNXcmkyUC9jY3FRbTYxRWFraWtrS0ZVQkF6TTVkcGtobGh1ZkhL?=
 =?utf-8?B?QUZRaWprTStjQThKakhLZkJtSitiRzg4bnRpS0pUMlAzblVJTjk1NjVSRHY3?=
 =?utf-8?B?akRNbEVIVDBBeExrV25MaVJYVThzUUtTc0VkaGRiczBXVnZETEpZeDJXYjR2?=
 =?utf-8?B?SUUwVnB0djlyRkVkWGoreWpIdWVRTzFwWFRlZUY2U2JkeUhyYVJGMCtSaUNM?=
 =?utf-8?B?RVFQOU1VTU9FM3JaWmY4SzIrRVdwMlpSR21GTEYzb3RhT3BML3k3U2VTWWo1?=
 =?utf-8?B?RUZXVE0yb2pvNHplSnFhekNoNTR6N2c3RjRjeGMrcXNhSUxvRmhzN0NvdEhy?=
 =?utf-8?B?K0dweGw2RzZxWW1qYno5OTlBVHR1eFdPQzBGbG9DalpBRm96Z3R1L2JkWWIv?=
 =?utf-8?B?ZDdCN1BML0pPWU45SURaRDByUDFhNTltNGFZeEtzRWZSRW9RSmhyWmpNeWUy?=
 =?utf-8?B?N0FLbFd1OHlXYjRMdzFiRElOeGJBL3JiMjhyeFhNOHh5WkhtREZMNDd4d29n?=
 =?utf-8?B?eGRGWXhrditWZjBUMS9aWHRHMUZRUVY3ZkRiUTJUcERoRFR6eldnTWJyellm?=
 =?utf-8?B?SEdHd3duMWZlYWxVOFhqMHRFN0gwazhDZGNPMWlJZEhvcnAvOEJXNkZhMWJJ?=
 =?utf-8?B?Tk9TU1dXYm9BdytxMm1WRmVQV1RYZit1eG9SaE9xblpseEoxV2orODhXeHp5?=
 =?utf-8?B?dkNoQ3RmekZyRjFDU1hNTEpsTFpYNnIyaFVPcjQ4amw2VlhrWllIdGZiNVJp?=
 =?utf-8?B?aVB3Q2plNVdZSkdBVTA5dFREVnNHeTRjdkZZenBFaXBIaVB6VFloT29uZ0Zo?=
 =?utf-8?B?WUptVnhCamg3NzNPSmxiSzJtbG4zdXQxd1hoT2lTVjUyYzhhK3FaV05xRkNr?=
 =?utf-8?B?SVl0cWpBNm8vc0VpdTlGeWg0Ymc0bk5ieUxQOW9iS2RpV0RGMEpZRk9tZlRS?=
 =?utf-8?B?WEk2eXl3Wm5mMEVTSWhIWDk5R0dnUnBSZTNJc0EvNTd0TktGRWtrV0hmcVNM?=
 =?utf-8?B?YnNCY2lZSCthQmJZdUwrR0x6RlBzeDczR2VsTUlBMWRIbDI1dlVnT3R2aEpQ?=
 =?utf-8?B?eUU1VUJmblRPLzliQnJDNlFsa1dIaEJmc0tvQmt5dzdWUTN1MlVoQ0hOdDQ5?=
 =?utf-8?B?WVBuc3ZsUC9CZm1pY3cvQlZMTnhNbFNuTlUrVVgrbDdBdkozejNkdlQ2dGg2?=
 =?utf-8?B?YktvVkxsYjd6ZzZ0b1Jua2paWlJkUXpCNm9PbkxBQncvcFA0L2ltR0U3ampY?=
 =?utf-8?B?d0pBbHRKM21vU3B2aFA3czc0bzVhUlNFTWtXNW5WZEN1NDl4SkZTaEhIVHYw?=
 =?utf-8?B?ajhiZDZITUlqUGRxZStZandNdnVRK2FyQXp6SWZmT2s4RHNUNWJzRWlkZXU1?=
 =?utf-8?B?VFF2RnBQTEZlS1ZBeXNFOHVLMThJdWxJbjRCMXdQSG1YZFArblZpc3g5Q2Nv?=
 =?utf-8?B?N2dQV0xqQncvR1pqc2ZqbXIxbWViN2d2Y2o5RlhnSG1sbXpJWmY1UVdPNHlL?=
 =?utf-8?B?elhIY0NGRFdZRkUyMmxjRDFOU2JKc2dHMXI3c0Jodm1UY1VhR0F5RVBPamt4?=
 =?utf-8?B?c1NsdFBDeDVYUlhFdEhRb3BmQVMzMUZwQUhISXZvck43aHN3WmhBM3JlM0o0?=
 =?utf-8?B?RHYxMjF1azFRWm5BNFNLQS8vSGxpeUtBNTBDZmJjUW1uYXR6WEVBZHlZTzZh?=
 =?utf-8?B?TUFsejFIb05iSU1oZllCYm9nVVU0ZWhyM2JPYlppcUdqY0xWcWNndnIxYnR6?=
 =?utf-8?B?NzhuM1p4VzNqTmNiVWhmQ0dLMC9zYVN2dG5xdkRUKzNPc0F1N1Z1b2NlS3pN?=
 =?utf-8?B?emlLcFI4UXFzNlk0dlZ1clhZMElGUnBBVGdZajIyajh4bXRzbE90TVpWYVZY?=
 =?utf-8?B?a3MwUi8zSWdDQnNQZ2xzK3NPNlowWGZlTXJwQ3hhUklpZzRXVXRQS3lHQ0oy?=
 =?utf-8?B?akZsM2hEYjVLRm5STndUaU9EUDlkUUdSc0tacWNybmMxSUIzZUdOTXNmaytE?=
 =?utf-8?B?MkRDeDd1NkVXalB2Ums1ZnhVTndPaUVvOU80T3pjS29IcVNvalJZN3hNWGx4?=
 =?utf-8?B?TlpOcEMra3JKM1BzT2FrWkNUTnBLMWFPYUs2K0wzcWpQZkhseW1CZm5Tbm1i?=
 =?utf-8?Q?AL96MC5LhsVZvc6Aip?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab65e68e-7169-412a-df33-08dec0df99e3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 19:46:12.6505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFf5RdwLa9NUKPgJrZa2h4UJw+Ee4nW1OaTazltZKAyeCiPBDb7AUFyGKsPXlJq3+6DgYZ4fWctf2slt3n7I2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 6/2/26 12:59, Aurabindo Pillai wrote:
> force_frl_rate, select_ffe and limit_ffe in dc_debug_options carry
> non-negative configuration values: an FRL link-rate enum (0..0xF), an
> FFE level selector and an FFE level limit. They are only ever compared
> against 0/0xF, assigned, or cast to uint8_t before being written to
> hardware. No call site relies on signed semantics.
> 
> Make the types unsigned int to match how the values are actually used
> and to silence MISRA-style signedness warnings on internal builds.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dc.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index c6db021a61b0..82d02ebbd829 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -1155,10 +1155,10 @@ struct dc_debug_options {
>   	bool force_vrr;
>   	bool force_fva;
>   	int max_frl_rate;
> -	int  force_frl_rate;
> +	unsigned int  force_frl_rate;
>   	bool ignore_ffe;
> -	int  select_ffe;
> -	int  limit_ffe;
> +	unsigned int  select_ffe;
> +	unsigned int  limit_ffe;
>   	bool force_frl_always;
>   	bool force_frl_dsc;
>   	bool force_frl_max;

