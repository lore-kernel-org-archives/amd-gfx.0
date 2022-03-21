Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D9BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Mar 2022 14:19:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D916110E29E;
	Mon, 21 Mar 2022 14:19:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BFBD10E29E
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Mar 2022 14:19:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNyOcXh4UdgPP9HhHXhtWxkJlpuyvfsiIlVmBuc6TlbQq30EoEugScTRWsnyPg2xJzU8eZvhqKVWFSBTjTRj4lOJ1lErtAlfuVS0rIVoqPaLYBejnRVZkJLTUhMOMECRYk/cAyv0MYA3iuoFlzMiZexyNnwhZu21oKFN4X/XvrEOyRGQ67m1fHxObvbQ9GJDfAlZkLGqBBUgdNEIcgifMPoF4SRNF37J8ELIPbGNzNa2TC0di2A15WaoO5225n7lOKTbKGgFB+EAwfvlfaJxDraOsTzTFWm7NQzRrFJnRC8ynmjkkHyOHWq+Q5Cu5K1GMWlpm2wsCAz5wZYeOyfxfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqPntOi9xpD4kLMgygHpVhj4f3XSfugGNgzObzQ7RqM=;
 b=LcNllrpBLk+5ogSvTP8/2jfrnSOVztHzEjao1xXLfIxqq4VQiy75u7KHmubDpzJYD2CKz/DlquxgIKSj2DcqZt8aLznb3pL35+20acU95EY9bSaStCBZDBpjedBwcuhCBA4u2Y1Q1/HD/Vj53zGghGrNtp3w+RMTrb+lUDbi3IvL16In4/WuyLrhgJhxljYt0ExsWEIweYxwGFQMINymmP3GYRR0rqIs3FHIhttPK+f2wL4Q3lAepnQSW/F27FxVAh+V4s3Qth9KDUcHSlQzZ44srZJydSfu/zxJI2yPR1AksHwPwTm+Gef1HHayTOT6N3JcUUnmrMKVLu9uX5UYkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqPntOi9xpD4kLMgygHpVhj4f3XSfugGNgzObzQ7RqM=;
 b=Ykw6Ht/Kct/egYQObryk6mNR/rC+adRc+OSwWLhu1MDu2G873dmqrnigUcC3+QdwNtdinqryT9pMF+BfdY4uDj7avvxakOc1T8nDpZspxJlrBbcLyQNkvg9HZToFvC9cR3G4FQlPm6h3Oo+U7yyakUt2fhIzu6uBmObVaQKm+hc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BYAPR12MB3400.namprd12.prod.outlook.com (2603:10b6:a03:da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Mon, 21 Mar
 2022 14:19:15 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::192:5346:4ece:7ca3]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::192:5346:4ece:7ca3%4]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 14:19:15 +0000
Message-ID: <0c45dc31-bea6-fda3-aa53-7a0554a210e1@amd.com>
Date: Mon, 21 Mar 2022 10:19:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amd/display: Fix p-state allow debug index on dcn31
Content-Language: en-US
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220318190015.111877-1-nicholas.kazlauskas@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220318190015.111877-1-nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::26) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 119e514b-afe5-4704-da6d-08da0b45c73b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3400:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3400D272ACB35D60F9CD10B18C169@BYAPR12MB3400.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GhOP7bNBeMkGsm8miR9ANUV/9DHVZBTBXtZDEQOakC2Rzl7+Kh/es/LUD83I1BvgQH/BzRapFQAqP0wYsLDiVG8jwXItgIDW50t/WCliatuwkxwWuT2g9v+3F1Y7luDaUFu99VifbLuTwSldomEmw6mJkLGLKqmML8Z1gS8xxiJH/hxAfhCW1EU2JpCCyDGhH3W52Ij6PtkpIoVhoMrX3aP+EEEX6ezdXYXMe8+TSFFqwvVzsXK1y5mmU78bDx6wbqNJDPAWaWo02z9m78etf6S/HDfQmdpulPsOswtpLd87czXxNnpZjvZzp3wXOhVdpIXOFe+KbROgmzFgY/B76HrwJFtsc40H+6vZ1IQhKk13205EgAoK1ZIrlNoaQuZaUnvr8yKzJsqCMmLAxldLtlgb5RBOmUfWFohYNeqgUeAvtKKUxT4QlPf1g+XWmsmBdUjxobUHchtIPDKL57zl8vPyhG4m+n5HSojV15z78MYQ93IQU7R9eRPEvKMl+QIKxi8G35WR1a7uDyEfU1oCVjYx8e2k9wP02Uu4WqRTGS9MKkZExzSbKZa+2/SxRGygO1gcNcexenPQruVjSKSXUkurmLxWSPyAhPaW23xjccF/MJPlgek0ehYTPD/T8YpiVktpNpEFM3FhLdTABfrvj1Sv9t86ncY4AHqIl2Dh6Zwx+m5Xc05PAXyQot9fTM5x2IbPuBFyOD2Utab/njUkaLZ5ecBnLY5lfN5mXUXCzFwPdMwvQuUhKXQP+IArbwaf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(44832011)(53546011)(5660300002)(8936002)(186003)(31686004)(36756003)(6666004)(26005)(6506007)(83380400001)(2906002)(508600001)(6486002)(86362001)(66476007)(66556008)(66946007)(6512007)(38100700002)(2616005)(4326008)(316002)(8676002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?My9LN2c2Q0kvV1Z2TFVZUTBTMVNqaFBvQ3U1Ukl6U1RxWVY3TC9lMWhhRnhO?=
 =?utf-8?B?R3k3UUh5VTAvOUNYK2IwM1piOHltaklRckx4MnhTYkVSdXhWdERKSjlCZTRn?=
 =?utf-8?B?bFJnRjZkN1c5bnZkcmYrMVZ6TDczZXRsdEM5TlcvYU1ZWWhpSkNSQjdEQ05E?=
 =?utf-8?B?cEJuSFp3NXlPKzUvUTZ3dEpJUW9PaWJsdG5YeHAzemhGMGtlaXo1eE95bmcx?=
 =?utf-8?B?em9Bc1ZxNmw3TmJRb0lNRGdlaGJ1QXBmQm9rVS8rSWJ0MEdxVlp6T09vNkRl?=
 =?utf-8?B?cklWMFp2RzRweW9RanJHaEYrZXFPRnZCNjhFRHhxS2dtY1FvYkxrQjVTUTJv?=
 =?utf-8?B?SDZWd2FuZ2RyaDFocDN0eDB6S3hseUsxaUxlUCtqV2ZScE13bE5zTDNPVGFS?=
 =?utf-8?B?bVB4RmRqTE5vZEdBTDFldWNDY2dUdmRzYm0wTmZsWjY2anBSaTB0UTBEMVl3?=
 =?utf-8?B?RG4xWTk1NE5vMFFsZTMzekcrMld3T01BUTJ5dGN2WXFQREtFeFFBM1Rvdmlh?=
 =?utf-8?B?RWZjYzRnUEtlT25RUWpsdEdFZ21HY1hUT0FEWUpLU2wwS0Q5ejdrVUJ1SkV1?=
 =?utf-8?B?ZGRTYWpsU2xsTUpUMDNZVTk0cTFRMlFJeTBncENGL0VGMnlZY0t5ZFZiMC9B?=
 =?utf-8?B?Q21mTjVqdWNKdUYvRW15cDBCdkVVYjk2VEgwV1VhYWtiaWQ2NGkwTlkrV1Jt?=
 =?utf-8?B?R1lCb1dvempySTBzVkZ4UlRkRVVyK21XU3BSTGp0ZE1HQlR6TkZTdFBVMDlU?=
 =?utf-8?B?bmFseHN1RDcrVzVsYmxXOHdMaFM5WjlzMDhDZVNYWjF3dHJPSkw2QVRzaDBV?=
 =?utf-8?B?REVURDB3Y2JldEgwK0hSL1UxL3VJNEo3UHlEZkdIb1ZGaDd4Z2NmM1B5MGI0?=
 =?utf-8?B?ZUtPbkM0d2diZVo0anVoUFFNYVFzdlV2cFRqOC9RVHIxdzEyTHRCdkVuUnVV?=
 =?utf-8?B?WmtGRFNISEJWRklqc0pPK3V6RmRaeTJTRmk3NUQ0RVdxbmdsKyttMHNlYTdh?=
 =?utf-8?B?c0J2Zi91a2R3NEhPNC9ZTjZmNmV0VmNPcUJJZFpXUVZYUW9odmhQcFRSbnBH?=
 =?utf-8?B?eThoT2ZIdzloempLT1pvKzlnQU1zdGZ0M0FNekE1dGVMWDVtT3BmSUxiV2RS?=
 =?utf-8?B?V0tEVUVWdHJWODdUK1BXTHVlcDdYcGE2eFg4TzU2aTVwclpWOVJPNGtMZDVj?=
 =?utf-8?B?ZjlwZnZOVGRESmhzWnp2ODZENkw3UERpN2pFUG9GeUo2L3ZyaUFRaTN4dWFt?=
 =?utf-8?B?Mks1d3hwMHZ1UTN1eEhSaG5CeFNzVlZoL2lNWkY1dUpSUEc1dTR3eS91MEFo?=
 =?utf-8?B?bEZrM3RISzlONCtVbGh0Mzh4Zk5vNDMrT09WbTBHanQ2LzRaY3E2V3Q1WGw4?=
 =?utf-8?B?U1NjanZRL0FHdEJxMlluNmJPUDhoaUcxREtaQkV2OW5hSFpPNmIvc0pVcjZC?=
 =?utf-8?B?YnFUUWFEa3l4VU9IbE10eG1VM0d3MUN6aXd3SkZVcmp5Y1REN1JKMUs5RVpu?=
 =?utf-8?B?UnNLckFBcnRHTTdRd3BOb2tIbkZKVXVPeFpRN1ArTnl6ZVNYVWlIT1NiYnJP?=
 =?utf-8?B?UFJvWW42YXJ5ZUg2YWo5NndhVWcyVFM5RVJheUtJaGxFMllBMXVmZ1JHN1Nq?=
 =?utf-8?B?WDhta0Mza0VNZlltWXppOXFHNGxPK2xsNUd4WlkxRUpZNkRuTUgzODdSRWtw?=
 =?utf-8?B?SERrS3pSczBlbkxUUWR4aWo0WEhCWmVEVmVEOStQeGFIK1Z3QXpvbm5yZWli?=
 =?utf-8?B?MTRqK2tiV2VvRGRTTmJVMURESEdydUdScXgzS1loS01NWGlhdndEWWNLY0tK?=
 =?utf-8?B?MFp4Z0ZydzNYWUtWRmVmQ1BZUGk0eU9mWE1wSXBOUks0RnpUSVNaakJuUHR1?=
 =?utf-8?B?dEU2Q1hrVWNKbjFONFBSR09sQUpPYm05WDByNytrcDZlOTlKcHFNZHY5U0Zq?=
 =?utf-8?Q?mr1z0rki+I8eZ3A6EuMT5mJGC6mC3p+L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 119e514b-afe5-4704-da6d-08da0b45c73b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 14:19:15.1472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zX966S+DgUjad0OlH0GGOItT55fmA/DaPhxtdKPXcLaxBcw07GtD2GZGvAQtKUL1gkmfrOuwK90etnOD7HzdaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3400
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
Cc: Eric Yang <Eric.Yang2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-03-18 15:00, Nicholas Kazlauskas wrote:
> [Why]
> It changed since dcn30 but the hubbub31 constructor hasn't been
> modified to reflect this.
> 
> [How]
> Update the value in the constructor to 0x6 so we're checking the right
> bits for p-state allow.
> 
> It worked before by accident, but can falsely assert 0 depending on HW
> state transitions. The most frequent of which appears to be when
> all pipes turn off during IGT tests.
> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Fixes: d158560fc0e1 ("drm/amd/display: Add pstate verification and recovery for DCN31")
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Reviewed-by: Eric Yang <Eric.Yang2@amd.com>

Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
> index 3e6d6ebd199e..51c5f3685470 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
> @@ -1042,5 +1042,7 @@ void hubbub31_construct(struct dcn20_hubbub *hubbub31,
>  	hubbub31->detile_buf_size = det_size_kb * 1024;
>  	hubbub31->pixel_chunk_size = pixel_chunk_size_kb * 1024;
>  	hubbub31->crb_size_segs = config_return_buffer_size_kb / DCN31_CRB_SEGMENT_SIZE_KB;
> +
> +	hubbub31->debug_test_index_pstate = 0x6;
>  }
>  

