Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED342C38A2D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 14:29:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3379A10E099;
	Tue, 25 Oct 2022 14:29:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AB4B10E099
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 14:29:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkOd/+qrXgUWfmmypbbiQce2fiFYepvvXhXoVQ4FRgY7xYDf5Yvzdse/gphu9k2IwwSv5LUkdMcTw9vGIv4ChnEN7cn801W3rKmKcD94uc8R07vE7O5xcFbybiPl09C30E3gpZmqZUKPsdyU+eWVVRdrNEKOAhjEA1BDTONRPliKdMp92GWmUcPA0RFDOVPKj4Aqgt0DQ4f2MC1JY7q9sPDbMBubGK5yBld4OG/MeMkKv9EGEOGPrDbabgTzJ/yc1QlvkNkvTZTxba4Yr+/lJK5PW+WpFB+ZYo2SX4UrLZdeizMdD58YoFMMexuDh7uYX+l0Ydjt4CKhyo04aUlgYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ta2Xn4k+jXHjT2CGPDL+LuP4Lo4UZi+lJFxOSLmVtHA=;
 b=CnPAiKNhXdVlS2GLU1ur3D3R9qDILzEx2helpFe6+vNcKU2yJeoZif/gCC4mbGwE/hPz3Cnu/Pc56imlR3IxGG4/pPVWGEwaQKVuKau7O3lLYpgs6trwkErhZbB+hn5qWVNrntSxud7gogpwxEksMs2FDjSo5WTAM7QQ71T+RK9wqDAdXMq9ze9Eb5ttDn+14X+/ng0Flc2ghh4MxhGFu3L3PcEB6zWbMknzBRAWnJRaq5rqajauJt4XJT6Gqnrq0Df4LOdPXVn+afEI3TK+k+b/CrUuF+VgcwvwbxhoZ7JGFjsZzv46w0cy/JC84eVCrdNUOKV82K/s3idW2C9mSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ta2Xn4k+jXHjT2CGPDL+LuP4Lo4UZi+lJFxOSLmVtHA=;
 b=5XGQTR4Rwxxz7igc2qpU+DPjZ1XbDlVnE+riLnIzYrUesrdJ23VGR9E5kT83BY15bod268FNcvYsJp7JuF5CUBp/hvpdcQyv+S/auY6kPeQ9u/DmlRQt+VH5fUhdaYj3sHOXt7eiBd47dK7lGfHnJpmxooFcJN10Hcg7eK7ATRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM4PR12MB5119.namprd12.prod.outlook.com (2603:10b6:5:392::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 14:29:17 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aef3:6aae:b904:e395]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aef3:6aae:b904:e395%7]) with mapi id 15.20.5746.026; Tue, 25 Oct 2022
 14:29:16 +0000
Message-ID: <e6372542-f084-80e4-73de-fad14554b461@amd.com>
Date: Tue, 25 Oct 2022 10:29:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] drm/amd/display: fix documentation warning
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221024171022.2270903-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20221024171022.2270903-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::28) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DM4PR12MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: 14cb9fd8-f23d-4cb7-12cf-08dab6954bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vq6GTHPeeE/qxhMtdfw0srUWSiInI0HoGxLAfESlLDzW26QEnt/0nZ8pjMLX47+41ybnzb6S6NaeuDxwjtYFItKZ2VvHXeRH4+fUkdFZwfXIPhQzFsgYES+s4zoHOuxJoihKqOYaNfQYIoF12IHQyF2nYkGa/OM2U8f7KvEDP4pgZYN9NRUIMSvTsyQqW5duOY4xdTGnhCyP3rkk4KgzMEkSCx3UCmnIdSYOdiej6lOMudvZ10qiKKsPKGMtlaSwx0o8WbsEmvN3UvDGIDFrFIZsbwTjamaWIycMTbsBA1+HkTpz3HzqsDAfA4DEmmk1eV5iz30j+TQ4cP1dzyy9U6eCL2qtopxb5YywJOhXV6i0TadvPP38nqDZtpqlXDtqATIDpoR9p0BFBePYT1eS7BUtPOixXknqRlN7Z5a3El5tcJ0Ogoxhm36i7Xiblnbrz0vUFwFC28M4CP3HunuPPPyiWg25wSblRO24WFoSG62dh7azmFAKF8MCDaFv04xlgApISXYTubIGtlMoySz1f7i1w3Be/LMH0HeMfQdWuWfKpsOhAa57RE6jrEpOjhZFvQo9RYrei/jKeNLn8exmnxggRDlSRCTdMpWd60IXwQqST73HlsZjACy8DBS+pGUe8LY91LR6wXVDHfHPRzA3hSsx14wahu9hPdY27YbVE8MbqVEx3GPBrI6t1P8muDikW/hXT4sAPgCvcOgU2JyyRzYnKqG2DOwmoyM8ALuIBNCd3U0dLmFCxFcJZSPNrOcZyTEmbsBVe9J7hB+VK9h2AGz9f9Um/TeXpdSERkmJDaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199015)(36756003)(53546011)(31686004)(86362001)(186003)(54906003)(44832011)(4001150100001)(2906002)(38100700002)(2616005)(31696002)(83380400001)(4326008)(8676002)(6512007)(6506007)(26005)(6486002)(66476007)(5660300002)(66556008)(66946007)(316002)(41300700001)(6666004)(8936002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmNOUmVrUERNNldKQXdzUkdtVkhmK0FtVVJwZ3pwU3UwQzZDOHo4L1hoaTN0?=
 =?utf-8?B?dUY4WmJNMmNoby9NbWg2RkVCZGJjRmRuM2U0ZWx2dXBwb0taVWF3TGNadkda?=
 =?utf-8?B?M0p6cUhxYkNTb3AxRGJHbDRKcGJlMER1L0V0anpOcm1adHlqUXRsRE16ckdV?=
 =?utf-8?B?QjQrbysrY1ZhZElIZjNOYTl5akg5MG1UbkdVUHN3MFVtRE8yQlZsR0FDc1lF?=
 =?utf-8?B?QkRkOHFCYkd1OVlkSGFWNk9nQTJCNDhCdjFkYlphWFhBa2Y0amNGS3FJNENW?=
 =?utf-8?B?L2taUjJmZlhCUkNIemVtUnpiWjI1SEVIN3ZDRDVUUWt2TGh5Qi92aE95Ykxy?=
 =?utf-8?B?OHZMaExKSFNQdGRrYTNRc2RxNGZONXM1Mkg5S1BjRjVCMFpBMmhtakV0aWxw?=
 =?utf-8?B?SG9VazZlWmRKVjVrMWlEU0N5b1pPaGtVTFNmZTZtMjU3aEJ6VHlNdU5UdFpj?=
 =?utf-8?B?Q2lxMUNaQjFWQ0xpbG4yYUdZZmZXclhSMG1aejdBejU4SlJNNzY3VndDT3pn?=
 =?utf-8?B?eUlvTEZ5dWZUQTV0UDY5MWhMTWN4cVQxeSs3TXRVOW5QY1Q1YmZTOHBpMDZ5?=
 =?utf-8?B?Y2c4ZUpPQnlNV2ZJcDBDajVha3M5aDdLMC85MHVpWFAzMngydlV5bk1IVkk5?=
 =?utf-8?B?TGltS1AyM2hoSkxIQk5RMkJkd0FBOWpCZ1AybG12dTdDdENMdE5Hc0RHcVdI?=
 =?utf-8?B?T3l2cjRDY1F6WGJadXhIY3ZESFJpYTUwdGdTdlY0Q3BVdEdwOTczWm4waXU1?=
 =?utf-8?B?YU9XNFU3bFVRbnQxZXlsY0lOMm9ybmtmdWgyaTNUU2FENkd4emtRSnoxOFRZ?=
 =?utf-8?B?STExSjNHM0tPOGZiRk5iUDZYQ1FSbVZOMi95NUNwRFlNcVg1SnZCL21rdE9T?=
 =?utf-8?B?YjlFT3I3UUhCZ3dYQVU3Z0JRMzJobjNmbk9VRXVaODNTSk1HdUpsbmk2S3hG?=
 =?utf-8?B?VnprYmJpdHhBeXl0RUtKWS9ab09maXp2bHMzWjAzTWkwdnFhVUFhWkQ3cHB3?=
 =?utf-8?B?cXZXV1BQaGRMU0thdXEzclgzeGJJcGR2WjdHZmY4U2ZyT2ZHdWRoYVZPODdy?=
 =?utf-8?B?OER6eWlpZkdFM0R1dDRYQ0NjQ2EvYUpYdE5nTmNZUGVxbVM2UVhLU1VFVlF3?=
 =?utf-8?B?M3Zma0VQTTBCYVFHWFFrT0pGRHJDRVdic2dYbmMzU29zY2dnYzk2d0s4UHEx?=
 =?utf-8?B?cHpaL1pCV0loamxxemFwK3JodVU4Q05pdnBoaDkyM1lKa1JkaGt6MXk3U29v?=
 =?utf-8?B?NU83OTFzVzR4b1E0WjYxSnUrc2FQcXA2andQbFJCaTloOG5URXhGeWRtVExU?=
 =?utf-8?B?UFlNa0ZoVml6T0srdll1S2kzTTM0Y01XWmFsSm5MbE0yR2dLdEEwNy9TbDFo?=
 =?utf-8?B?OHlDalNaN3JER25UZUowWXRkLytWY29YbUU1dDFrTGZsM25QQmIrY29jYVhv?=
 =?utf-8?B?b2pMNGE4SGhXWnBNcTFmOUdUMDlhUDZKVExPVG1VdUhZQnArclZ6ejduVUx4?=
 =?utf-8?B?Q2lwUXVDZ2lVQzhpOGFBYlZvQm91NmtnOXUxNTR4eUpnYmJobVRXZU9idGZV?=
 =?utf-8?B?RFZ0WUNlZGZ2aStsODFqSis1OUZkOG9kNGI5bTVuMmZmY0FYcFc4VmFWWTVr?=
 =?utf-8?B?Y3BTUWpseC9WVGFkU0JhTWFSeGZtRys3UjBTeUhFYVlPbVcyT2NhZlBhKzBv?=
 =?utf-8?B?WUtEMGFIWnBvRWIxdjFUS29DUjl5OURseS85MWE4cUhOU0dQcU5pTU5UMWxV?=
 =?utf-8?B?ME1GY25pN3V0SXJCWFhwbmVHREtSRVNQYkRLd1p2SDg2aW1FN2l4bUJVTStk?=
 =?utf-8?B?WHcwSGlkMENRTEJqVkJURCtyYUVZWjNBWkluR0IxWkY1R2cvRUkwdiszQjVS?=
 =?utf-8?B?MXhsMlZvdFliZ2dBSHArallydjcvUUlMdVNzZzE1aXo0cW1LUExJaEVFV3lr?=
 =?utf-8?B?SHp0YnF2d3dGcmMzNDhuS0xkQnNBWHNYOHZ1WTYwVTdvZ0FuMTFBQVJRZjVD?=
 =?utf-8?B?VWJ2Q01YZ0VWVlhoTUdNWW5HUExRTlFFVGkzZ2hNSmJlY2YwNmRQYWRxZHJW?=
 =?utf-8?B?c1F3SjAxVnpXRzhDN2dTdzZqVTlaRUtLTEhqaHBhTkpUSjFOS1ZjRjdSR3k3?=
 =?utf-8?Q?FLSsrv36JZgUEy2PcAk3/xHDC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14cb9fd8-f23d-4cb7-12cf-08dab6954bf3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 14:29:16.8668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvnH9FOC3O58X+2tb149DIdXpjsgzisWpRHUio2ArOUOc0UsTt64bSxX5OwYCmR7JHBc7yZSVCpwg6FON49weA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5119
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
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-10-24 13:10, Alex Deucher wrote:
> build htmldocs produced this warning:
> drivers/gpu/drm/amd/display/dc/dc.h:1275: warning: cannot understand function prototype: 'struct dc_validation_set '
> The word "struct" was left out of the comment.
> 
> Fixes: f4a59996c408 ("drm/amd/display: Include surface of unaffected streams")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index bd7a896fab49..e4e41f2e5054 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -1269,7 +1269,7 @@ void dc_post_update_surfaces_to_stream(
>  #include "dc_stream.h"
>  
>  /**
> - * dc_validation_set - Struct to store surface/stream associations for validation
> + * struct dc_validation_set - Struct to store surface/stream associations for validation
>   */
>  struct dc_validation_set {
>  	/**

