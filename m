Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D70DC43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 15:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A9EA11A92B;
	Mon,  6 Jun 2022 15:54:19 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CF3211A92A
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 15:54:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrGkbJVYL+H1LsM997bDKuCMjVn1jlFvVSuhXlCEYL8+TcKbI4TzIS6HGwHAEJ4iVEznRZ8I/ChE2zpKuGwpvQr6KeizRIaFoVsyF/k1uRYUIiIfSSSXnyf6jWc0/uDJ3WvhER6Ej8vigupNz2V5bK3FM9Xk2p8XrfJBj1Yu1sQPG//Aq7ONQGSmWRe2uBcQLaPBY0O8qvds7sgfv85vwmtTtvWMd6uEW2Yu9/sOU4AeoBPdMVSAGBwSh5Jwvjm2uxxTzhcVNDpvcM4uicSgaqfD0RsbUSzzXry7+wfyDyvZbjFoxIVr82IskwE3XZEC0KcHaJxzAQWjAAaSOYbGRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kj0bAqEvizJS22hE7HafJ7AKX7fanxD5QYZr2VxwWCQ=;
 b=g/fFQ5iYnaW4xTNet1w7TSrdMV/MzkDIavBTmeVKD204Ck0SSgoNn1VvAwcefgsxbipTsXENIl3F4CNv0XxlCCU/TBHQ8AxoxE4cAE0NNKVqUHYwatJMed8vQhMAo6b+KTrYHeoGJL0Rf9UoRqv9aT5xiCfHp3CyKPOr7Ws52f8RW1CV7dEbdw8ZncImKiZPQ6+UWjjgSYzcrx5wDwjxDXjC+oYPF5f3H5G6nc9MrlnUEtjD/OVy5kz2qkmxQsFy9dembF8TQNFt4MQvXgBUwBcQY9L+9IHot0vFau9KsBfPATAo2yuHCdRGfo+kKNRsKDcETN2O9Up/Fpd5bOgjXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kj0bAqEvizJS22hE7HafJ7AKX7fanxD5QYZr2VxwWCQ=;
 b=c0/2WF+ekwxRFBmlhHbbgxUZ8cA2M3+z8f7haDxGn/RJrBvboGJzqTnxMw3oXf4TrMzZdEGg7a9+W9+j559O1gTRLlcy91qpb4wDE2IVxSLKtKgrvaZyGlNvSHd/h2SsNHhmxMuJeaD94gvzZxMxqBZdWgwGKaEcUGiuL+Kj/iQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MW2PR12MB2506.namprd12.prod.outlook.com (2603:10b6:907:7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Mon, 6 Jun
 2022 15:54:16 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%6]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 15:54:16 +0000
Message-ID: <8eed1f30-3703-fd64-626e-ab088bbde57c@amd.com>
Date: Mon, 6 Jun 2022 11:53:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] drm/amdgpu/display: fix DCN3.2 Makefiles for non-x86
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220606154228.839904-1-alexander.deucher@amd.com>
 <20220606154228.839904-2-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220606154228.839904-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0065.namprd19.prod.outlook.com
 (2603:10b6:208:19b::42) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1493f16-7fd3-4b0e-55c7-08da47d4cf52
X-MS-TrafficTypeDiagnostic: MW2PR12MB2506:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2506A17D7C1EA09752269DBC8CA29@MW2PR12MB2506.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0zlsE95vl1SoIRUynH+HtjAAaAMwnyI9V6UABJE3KwRsjW9a8rs3oknj6dmym5jqC4ZSoGjvty3k+VqEdQ/peza1vK+S1JjlPX1uy8q1OL1OQrGuk1t0/05PXGdBCvPo+9fxM2IajDec7DunBUgjD1nHwSwS2qSxyWoBdqIOkmSb27Ot+Lq1BANKoQYtxuBupYnjsbzKg3/cgERvy3n84/AZzbc81vKhsaxbq+UGh0nXUPMztrlYjaoZF8K/B8Xrx5CAIDhEtTnyueMwoIINBeJ808mtKVuK/4F8MId7p8S7mYUJGovYXO/bmWzDtgxTplMteETypgzoZ2SBHBKdp2A8KfQnozc3J/jrBQR3U3wQKmfWIPNdsWqjnF9keKsbUIa1mArnDUn1s1JvpdfNTysVzf7q17Bf30Q67T23AKU0RxbTQacVl+9sBLe6piXY3aqkRtAWJMM1vozc7xXRdx6IE/gR2TQ0bxA7OLXLvejJTuWFFzgNMC7JEacht2Xaj63VMhNaIa8eDlROyOEM7hLgs04av4yxabxbcGx0wEiHpMBh2QzRpT5BjfLg+OM3Jw0eSAJ9xaTQ24Zul38mm11wpS8cavk2kTx8Fkm13KqkCYU0xhKnaHKa2P5yynxEv1mDcjGHEsztBxbRukKGGtoyRcktri7IF/4zfdIBNFoazQVumq+rQXChmIfa4Ag7kaDQfOmoerf/9dsJofLTSHyQ5CsxSozVq4YSxSRVG1PFk5fa7lLcdkIEuyO4YNE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(44832011)(8936002)(66556008)(66476007)(5660300002)(2906002)(316002)(31696002)(86362001)(8676002)(508600001)(4326008)(66946007)(186003)(6486002)(2616005)(6666004)(36756003)(31686004)(53546011)(6506007)(6512007)(26005)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0x4U2hPcDhOWDk1aUVaczdYSXFFSm5qbU1Bek5mOVNoT3dhb1pEamRSU3lk?=
 =?utf-8?B?RXE1Q1IvVGtqWXZYdTFLSkpvNkE4MFQ3M3UxNE54ZjBtbUVxK3hiR21mOEMz?=
 =?utf-8?B?S1ExNmNibVE5S0FTaTJOUXJIcjlhaHl5NC82Ums4K1VDT0kyOGhrU2hXbGM3?=
 =?utf-8?B?cDBzZGJSWitCeEttMStqTk9JTUMydnZFeUIxMEl2ZnlSbFVuMjcxenBhN2Fp?=
 =?utf-8?B?L0szK3lVL2pxeW1vSWkvMTcvUkh0VXBnOXgrdXhQcERSdUROQ25hOWpsRnBL?=
 =?utf-8?B?bTdyUHBBYkhzaUhUNjJhd1lQNXlLWExtMDhxcjJ3RUZrNHpISWRwVTB5Z1NM?=
 =?utf-8?B?R21BSWt6ME1CNHc3ZUFkVzlPM1p2dzBMOTNRaDNLT2FzRjk1V2swQU1Wdmd6?=
 =?utf-8?B?WmZrM3NSczExWU1SVEpkVEJIMUt2TVdBY1NsRERRQmdvUUtQemFMdytiNUoy?=
 =?utf-8?B?VFNCcWcvUWo5ZWh1VlNJOTlSWUlUTlZvVldkeVpOQ2hrcVVudDEraEZyTzZl?=
 =?utf-8?B?QkJPY0lZR3d0T3RBY3N2dzUwMTU5dkliR21kUmcwNTlKVG9uaVg0TWNVdWNn?=
 =?utf-8?B?WmcxNGU1bDVvcG5KMU1LWDBLc25nQXU4K0hKdCt3UitEdkxjT2hNSVhXTU1K?=
 =?utf-8?B?aElSSW9RZG5CbVBIcDFHeDczK3FvMGNyeGZPK2lFYUZBU28wbzY5bHpIYnpN?=
 =?utf-8?B?RHdCL3BFb0lRMFNuSmF2Y0lxVFppa2JYL3FPbDFkVGViNEJ1Q3pHVlhLS2lk?=
 =?utf-8?B?NWEzNEdaOEZWS0RxakRRTnUxYjlKWWlOSlkwNG5KSWloOXdtUmJZMnFKU2J0?=
 =?utf-8?B?QldhUEFNQXZGQlJBdXZUK2orQnBpcWhqQmFRVHBYa1pwcWdkejZnUWo1RW1B?=
 =?utf-8?B?b0pBZkt4Q0VJSS85cGEvWXgxNlBrYVlEZ3Y0Z2xwOGUvOFZHYW5BL2p6anhH?=
 =?utf-8?B?ZFZqeHZLVEkwN21CdXhENXRXOXJMVTI1MEszRGRyR0ZiQ2VPbC9RN1hjOCsv?=
 =?utf-8?B?N0ZFd2U5UGJEeno5amthakd1ckRUTmxOUHRIQmlRaDVLYXVDWTFkSHZqTEU0?=
 =?utf-8?B?QUFzWHdlNE1uNHJobkdPWTdzSnZuVEdPZGFBaWIxdGlhc1psQlZ5ZUZ6UWo2?=
 =?utf-8?B?ZXZOTE1ORTJEcS8vb0FzS0FUM0QzQUlpa2d1bE9naTB4WDdTRVNTRjRaNnlC?=
 =?utf-8?B?dmlGWkl2ZktoMEhJTlBoOU55dWZnT1haL1A4V0xwNFUvNW5WWW1pSzYrT2tK?=
 =?utf-8?B?YVFWS3loQUhJZ3U1Tlh5T0ZxZmEzSVhEU0kyaU11aDRzT1RyMzFkdTNFSUpZ?=
 =?utf-8?B?RGlqZmZaOGZwWk50RTkwNy9paHpRNURJVWFwT2ZlMzVpSGxyV0I1TnZkSGxn?=
 =?utf-8?B?N3Q4T3VRRTRuRHJlZEZZZHhUUTB3RHFnK0dqWDdSMEJqQWc2UVRyd2kvVTNk?=
 =?utf-8?B?VXBpOVZLQ2ZNUXYxbFJEdDhlYkovaFB4QjlVMlpFNXBTZVB2UnBYV05BWXhH?=
 =?utf-8?B?aHExclZJR0w0UXBOWjBzWGptVjBYbHBaK1V0clVxSUVtZXY3NWNIUTVmRTZl?=
 =?utf-8?B?SmxhU2NZWmR4TEdlcXhBelBLZUM3VWprWWVVeWFiRUdDZklhcmh4dDVlNjha?=
 =?utf-8?B?ZWh3ZERnQzVFMnFLeWNkQVlnQlNqQ1ArTDFVV00yK3ExRTluVitOdjQrb3FO?=
 =?utf-8?B?aWJjRzZWQmhuRUVCY3JyMlFYK20vc2VVWFRvejl5VGQ0TlB1bGltSUJVOUdk?=
 =?utf-8?B?VERRQnRGa0tMR0JublVMVzV2Vjc4TklmWUEyWDlqeEZxeVBKRm43ZGdpT0Rq?=
 =?utf-8?B?QVZlbDBMd3VBaXpvZFE5ZFlmbTFMd25kNnF1aXgvaysrSDVhZkxEM3hrYkdi?=
 =?utf-8?B?MkhDSmFzbk84U3lsWElRMEtCZDZSK0FIVDFHT1JkRkZYN0hvaXU3cGlnbE8v?=
 =?utf-8?B?UWUvM09NbVZvUW80K3ZUQ2xiYzNnZEIxbnk0cTUveFBpSVg5Tkx5c0xKekNm?=
 =?utf-8?B?UllSdytLTWhGTlk4eVNMa3pSR0VjalZEcFdoM00vVEw1SnRnTXNENkVkWHZZ?=
 =?utf-8?B?Nm51RDBOZ0J1bDV5dGEwbytad0xUdVJKRFNaZU5CT2xFQzRKbzBadGFuaXBq?=
 =?utf-8?B?ci9SV2lZdHVqVU9OUTlUWDdrL1djQzlwcUVsMXNSeC9uN3ZCVm5tTDByTlJs?=
 =?utf-8?B?YVBCaXZtTXBOcmRMekhlSm9DK0hmWFhLeDdNKzloeUlsUnFvbkVOSTNQK000?=
 =?utf-8?B?K3dvTElBbG1OREdHMHRFalJHRUxkVE44ME5heFRXVmRuVUp3bDRub0pnV1FO?=
 =?utf-8?B?aHRHaFBWU29Ya1VUZ0lrejJ6RDdUcXdERTBmV1VBblpYZnFST3hMZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1493f16-7fd3-4b0e-55c7-08da47d4cf52
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 15:54:16.4670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5EGgwPonwoLgHpnfZ6UvP/dSBi2DYwUV8rauFmPVUPfnpytMQm/HQL3VmiKTPTM/2t7tbsbp0y8VLa983ZKHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2506
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

On 2022-06-06 11:42, Alex Deucher wrote:
> Add proper handling for PPC64.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn32/Makefile  | 9 ++++++++-
>  drivers/gpu/drm/amd/display/dc/dcn321/Makefile | 9 ++++++++-
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
> index 6e0328060255..3d09db3070f4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
> @@ -15,12 +15,19 @@ DCN32 = dcn32_resource.o dcn32_hubbub.o dcn32_hwseq.o dcn32_init.o \
>  		dcn32_dio_stream_encoder.o dcn32_dio_link_encoder.o dcn32_hpo_dp_link_encoder.o \
>  		dcn32_mpc.o
>  
> -CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := -mhard-float -msse
> +ifdef CONFIG_X86
> +CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := -msse

Should this have an -mhard-float as well? I see that in the other
Makefiles.

The entry below only adds it for gcc, not for clang.

Harry

> +endif
> +
> +ifdef CONFIG_PPC64
> +CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := -mhard-float -maltivec
> +endif
>  
>  ifdef CONFIG_CC_IS_GCC
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> +CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o += -mhard-float
>  endif
>  
>  ifdef IS_OLD_GCC
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
> index 9b61d08700ca..5896ca303e39 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
> @@ -12,12 +12,19 @@
>  
>  DCN321 = dcn321_resource.o dcn321_dio_link_encoder.o
>  
> -CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -mhard-float -msse
> +ifdef CONFIG_X86
> +CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -msse
> +endif
> +
> +ifdef CONFIG_PPC64
> +CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -mhard-float -maltivec
> +endif
>  
>  ifdef CONFIG_CC_IS_GCC
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> +CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o += -mhard-float
>  endif
>  
>  ifdef IS_OLD_GCC

