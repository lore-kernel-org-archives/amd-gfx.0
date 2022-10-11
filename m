Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF3AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 15:16:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 306E810E258;
	Tue, 11 Oct 2022 15:16:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC00810E258
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 15:16:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glY2Hj/sjf9jLhtXTzKuxLiE69ih25CkP5KgdkmCcGOJhSShlbslAgaa9zpegZOdGkqmDYAKoWF/YtjNjqqT/drN+WCLwMUJe94oTI99CUvGowYQen6bBL2+7Nz34FsxL/e7h88Q0WWhTnItPIFgbjpyQ6SZa7lBZXhnO2w1+Dh7CsJTnm4GX4DLhoGVDN8k8QRpk/FnMbUwTAlH+01g4DWJ1JxAt9lWGoizOkbswY4mZf9hLFukOOOB42tnaKs7dVX+7/6VMwUDFaQvo5MbB9QYQGCw3ZTLddKpNfDV1us9fxbst7mhLJBgNWa6qgO4hepRr3O893mpxZ7OpJiRvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxtgL3fvvAOwyJ4DipLXEiFTKKlUCHrHBQDYcZyWIW0=;
 b=WR1R/9dfe+cJji5exNPJs/ISCFeJQghfmBHUDEZPloU8/uakEU0mDz6+6ew/SOYsPf5qMS6XwKp4sX8kgXafDnvfLVt7OyzPZ8NX6RvFw0Flklg+Fji5TVCK0QNo9DcDDmOuzRGKam4Uzn9QNpXw+ynF9E6p/vH/V+fYkUHZ7Qfbbn8VY/TtdgFETNyhBh89iy4qYKZo16acNTovZ9vFPTROTGm5NcJdu4ge4E+4HXypFXNPcKVOPjOP4ElpKkT+cj02Eo2LZcuVhNp/spXXg9XFM0QRczSz5Z8Ov+zsl324YvQEHjigk52epUnhmsuQVWssF6bFV+2tIF/teAUu+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxtgL3fvvAOwyJ4DipLXEiFTKKlUCHrHBQDYcZyWIW0=;
 b=FRPr/RS0Mw6G4DlRRDRVIheUZH8byOx4kJlcPrPpEkkxT3trQQDKxlj+AAAX8Ce+gFmoB/C0nHCky0uqj34q3tPnEvFVK+NG2Svo/Tqwqu86jaIGYtDuN69PjRUL25PjSmcw12tuQKMebBQEK0HZTbO158b44ZTcb+f240fYEPo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Tue, 11 Oct
 2022 15:16:53 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aef3:6aae:b904:e395]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aef3:6aae:b904:e395%6]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 15:16:53 +0000
Message-ID: <5ab9d75a-bb19-4d41-aacb-571b1f26708c@amd.com>
Date: Tue, 11 Oct 2022 11:16:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] drm/amd/display: add a license to cursor_reg_cache.h
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221010213608.478280-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20221010213608.478280-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::26) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|BL1PR12MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: ce751deb-0c19-478d-831d-08daab9ba0b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 35CD4W+hv0++lXU636JWs+9O1X6JgAOAWwlUJcAmrL9TqvJa79NKPN7RHiwk7awIWQWnp6fl2bzNy7RlVYYiQo+v8LYsrqsZ/BgZtGR2BWvohMC7cn9N/Q4aEd0EkzZe9WKG2g1IeSjZu3jPsMg7O66IIKoUxb/MXT2ZWQBOrzlCkhY4yEl/4pVcbCU1cab/LRVUecsh+HS+KavWsKcd2Y4lg40jUyyQGD9Ryfg/gH7cdOzF24UjQqhu/mtovdpiVUjvp4Ebm5HkMvcyP7+C26STkKSCBpFmPfjJsI+XVdxtZENCsYktdyN5XlG3YrqGF9ArchR17C08Ox/lZmG473hlqjR5tHGIVKqZ5iDQ6/lC5cFVSzpxOHK5uVCjtKw+fdfPN2r/TidsqIdVIUAoQtgkU/z25zwHX6l+4IhSRp4pI5aonQB9B93GDU42YCG7ak+VyhMgKEm7pajvqMLZxUCEOity7WhNDCEWW4kcg7hgNrUcXdzb6tknv/gBdgydr2ksPYOuXiJa6lsX2zIyfkgMOKigsB3rUFDOfgh4N6pwVUqb8nQCdZg5gQuIuiC6EbeEbNAeqWjIB91Eoonc6RBp3c+2H0tRRrodmzgkzmOfqPhfYeY7LZI6a3fSIMv1Q+f6XsJnGLo6SVFLui8rGA7MRTQSr8XrwPXqR+79WPRE7U7y5agCIwNENWXre//1NZ2MpaXVDV7vzWW4F7378Xh5EmkM/GzqyDdmHMaKUWcXGCz1aqCI+25aqly/1ZKLdKf1ZFOJel2phSZbRtzi0zyNDhnG80kntTC0xKm82IE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(36756003)(4744005)(44832011)(8936002)(5660300002)(2906002)(4001150100001)(41300700001)(6512007)(2616005)(66946007)(38100700002)(66556008)(316002)(26005)(186003)(31696002)(8676002)(31686004)(86362001)(6486002)(53546011)(66476007)(6506007)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHRuSC9YWkNTemJKeTkxQlNYNXVYcnBydHhWQXcxREZaMnczc2g5SFM0NHFS?=
 =?utf-8?B?Sm83ZFVkZW1CUTBUdmlvUkNQazFoWXZubXNaU1U5UjV6OW9QeGRiUGkwbllV?=
 =?utf-8?B?ZFVxMCtaZVhtK1dOczM2VHp4NE8vQTA1L2pmR3BzNDliWk9sTGlOdGhQaStF?=
 =?utf-8?B?allLKzlPcVA5ck1GUGxNVVVkRndLbG9HSy8yNmNxdnBWYjhjUmRleHNPTXVw?=
 =?utf-8?B?cVkxNDdUUkYvakNDQTJmREM0THhQcXhjYys4cVhVV05lTUw4Y3hEYURJMTJG?=
 =?utf-8?B?YmVTaUwyVUVWakE4aWV1VXgzTVNEcDhwUmUwMWU4S1hyczBndFNuYk1HNDJZ?=
 =?utf-8?B?dWh3YkdGc0czVllJTklvOUVFaHh4TFhPbVZUbHd5RCtWQTN4eW1sODVIaGlm?=
 =?utf-8?B?elduRjI5YmdONlpyMEExOFd5RlJOUEh0Q2dEOERtSmI2TXdnQ0s1NFhsc3FR?=
 =?utf-8?B?K0ZFWG11aVg2akdLaU93VkVKais2bE5aV0dsMVM4MUtsdGI2cVhBL0ZPY3N5?=
 =?utf-8?B?a0syR3NlUDhGU2wxbjVDRjhNMmE0ZDhXTjl3eUpEOXp6Z0o3VDhnWXFUN0cz?=
 =?utf-8?B?eGxjQTRpQ3pHNHFKQVNQRnpQNy9adWNNNXFFZnVMZ1hETm84Z2NiWlkrSXl2?=
 =?utf-8?B?QjhuMVhmL3B4NnFEbDg0Qmt4SHdkN1dleEFXZVgySnFmSDF0Q0gycXlCTGpM?=
 =?utf-8?B?RWJhRC9qSXVmRUEzUHBrVUNuczh6RDhvZlFXVUtTdGlLNWxIajl3UDhUL2Fp?=
 =?utf-8?B?M3RGbjljcjhleENTR09BUkRUK1hnV05zYkUzOEsrdnJpMVYvNG12S1RHRVRq?=
 =?utf-8?B?MmJ6SFhKaUxhVVd3M3RMV01KN0tpY3c5cVFFNzI1OWtmS2pmdVhDaWJJTmVB?=
 =?utf-8?B?blN1SmlQcHBRaWNodUZMRnVtRXBhUmp4bjk1SEJQczBTNG8yc0wyeThhSUYy?=
 =?utf-8?B?THFKcVh3WDBJZHJ0azFmMkppRHB5aFVNQWVDTjc0QURHRThucy9GUVdXRklG?=
 =?utf-8?B?b0cwdkhsQ3d0M1JMU3VZTThqVkMwT05ndmlPTnE2WFhSWUtNTnBpWlZqUEFN?=
 =?utf-8?B?QlRNRGV1VklPNmphWFNYaEFTQjZENTR4aE9VS3RsWE9yTEI0eTVnRlVpNmx1?=
 =?utf-8?B?dVc4MXZNZU1lUEgxdUxMUHJFWGFvWDdhL2ZTRjZ6Nlp4NVh1bUZ3akxENmRG?=
 =?utf-8?B?b2ZrNUdMV0FwS1VCdkJKVnJEdHhjemJqcW5rOUxGSlF4Q1dVTnhhd3podC9U?=
 =?utf-8?B?YnFwY1IxejBLeXRqem1MMkhIWUx5OTQ1U0NlbEJMenRESkRJN1RRYVB0ekxs?=
 =?utf-8?B?WlB2aW5QNUlQYTd2YjdTUFQxVWhVMTYvVkxKb1pQcDB2SFRVRGdmOVdMdSs3?=
 =?utf-8?B?NDFxaVNSOXp4dHdJeFQzWWJmQ1NMa1pSTUNDTzNGY0NxaVYyTXIvT1J5V1VX?=
 =?utf-8?B?MlRqcVRuSEhZNnJaYTYyK1VsWDRjQjdJeXpCTnN3MU1UMTUzWUZRbWxTK2ps?=
 =?utf-8?B?ck1hTy90a2c0QW5xTndtL1FzWG05K3pPSXJRU1krWWRzSXkzc0xNQ0VzYVVu?=
 =?utf-8?B?Z3g0MXZ5bGhEQmZKWHNhQzRzdlFyMGVKam14QWlselRqeDloamk0d1habXg4?=
 =?utf-8?B?aFlzemZ4d3gwVDhGdGRWdmhwWmlpQmE3SW9rMTgrRHp6V0NhYUxESDFqSkhR?=
 =?utf-8?B?L3duaHlYTE4zVkdhY2d4ODUzUDJOdmhFaE5MN1k3cEYveWJRNXErY2crTndW?=
 =?utf-8?B?dmJLZ0FVWkNoY3RCSkJhYWUySGRLU0M5blk2cW9uNjhJVitEZis2SWlrcHc2?=
 =?utf-8?B?WnF3UmQrV00rVmo5YU9sUlFuV2UxQWMrY25XVDQ4NHcyY0diYXl5MWl3VWl1?=
 =?utf-8?B?ZkZydVdsdUtvNmJHVkFBeE9yRTcxU1Frbm1DOEU1QVR5N3dCLzNXalk5M3pP?=
 =?utf-8?B?cXAvWDlOYXJ3cGdxSFMraFhaaE1GSEtBd25kN0ZGeXdQUm5naXJyVjhPam1I?=
 =?utf-8?B?dUZ0Q3dCRHhlK3VYajVGclF1ZjBMRjVHTllhRmxXUHRiTFloQ1o2enZwNTYr?=
 =?utf-8?B?SXVXOGx3bDRyWXFwSm4xd0RKR3VvQktadDBHQWdEMkI4M2p4aDNmTHJHUUZK?=
 =?utf-8?Q?FTAk106n1uCCQrXJNkfeTKZ+x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce751deb-0c19-478d-831d-08daab9ba0b1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 15:16:53.4973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ji+zlEWHw8EiEVH11hEDOCd8v3UMXq5JmFOCSzjZNbA2/rOOtG4+rlKbtotsKPHoeJRTs6YRZdwJLI2f7ZdOXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5754
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

On 2022-10-10 17:36, Alex Deucher wrote:
> It's MIT.
> 
> Fixes: b73353f7f3d434 ("drm/amd/display: Use the same cursor info across features")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/inc/hw/cursor_reg_cache.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/cursor_reg_cache.h b/drivers/gpu/drm/amd/display/dc/inc/hw/cursor_reg_cache.h
> index 0e7c5880e867..45645f9fd86c 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/cursor_reg_cache.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/cursor_reg_cache.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: MIT */
>  /* Copyright © 2022 Advanced Micro Devices, Inc. All rights reserved. */
>  
>  #ifndef __DAL_CURSOR_CACHE_H__

