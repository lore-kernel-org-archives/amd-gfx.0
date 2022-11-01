Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2E5C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 19:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52FC010E0E2;
	Tue,  1 Nov 2022 19:27:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2AF610E0E2
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 19:26:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUGjPI94mQV8UFP/RbgeKwWN9WnE4eKUvWe1l6n1U8032vn3GIL3kD8lfOHGso/Dc5OpEggJY8IW4TLp3xDwalxozE2n0oSzKYcpwjhWsojF4eoLo3NaNc5xuvkVcmjK8zfksQs7Djzwr5TorahduYIBpB2yd1O+kz2cXpoIJQyGw0fwfQa1KprD1Cpk72l0uRL//ZbvHwqHEw/lLucI4Hbj1Y/1l/LhhNhWQ7wFch/h+S46XGbQADyq1/6mbivdNjKS1Y8klw99Ls++2UIsAmVZUJXmfSdYa5RbSgUcU+5TBZoNuk3wZlGu9v+yFdiIV1F+2th/bWAfWzOmlVXoLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3sfq42By3gBCsQx7+o5hLFtrH2xv2JAw2SX/cIFSKg=;
 b=oAO69Cxs8GjnWh+ZQ7XiLDduAkidRJiOJ3N/N1Q2iKrF+PXBqofc8XvdCjkakzHS8Ly4sDmxutwK8maZ6pAoTlSvJRblZrMqtb6twHhhkda7I57JXfIcmu7N0hyk2oNLdveVDBvM+XySbqSv74Sg40vN1gGNk59uJzBMnvHYeO/icqMB9hP1hA7tYhVWFd1KqmM13Lwdoe1MPGDwVf3TM7IEzzGNEgWVj39ifIeiHxysYg9Aw5O6CHTbq0H8jgw5q4ySwnZqcjATdTSKWi1m98wQTm7L+mjMwOrLD3GIzSeF5zQCmhJtqwqk+UuNSrBBOWu/1s0IQmaLznXvMML8Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3sfq42By3gBCsQx7+o5hLFtrH2xv2JAw2SX/cIFSKg=;
 b=GF9JUbhandvoSmPZKs9hP2kEDJaw9u7kSmUSM0wOkjtMe2vuoNKUYXjl04RghSSfItLEBXbzeykp26cjcUscpmu9lL0Cv4lIoMVZ1YMl1ymyT1yf1zW323lw+yKqqorGfUDgoE8bHZSttmmNOV69fAXwYIWosrVdbKxGaw44s4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 19:26:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c%3]) with mapi id 15.20.5769.016; Tue, 1 Nov 2022
 19:26:56 +0000
Message-ID: <291a5ef1-d20b-43b2-9baa-9f1a5e75cc5b@amd.com>
Date: Tue, 1 Nov 2022 14:26:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [23/33] drm/amd/display: cursor update command incomplete
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx@lists.freedesktop.org, Alexander Deucher
 <Alexander.Deucher@amd.com>, timur.kristof@gmail.com
References: <20221020154702.503934-24-Rodrigo.Siqueira@amd.com>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221020154702.503934-24-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:806:f2::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f5db12-6154-41ab-81ff-08dabc3f09b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /fqDw/LSVwzejDO3Ku5+wxXBZaca5r+E4LBMYNiS6Hsu+VgbLTM3GDYmkhlQdS6ndwLUpkVW0iIufN473O6AUszXcPZhdi7coUjkzTXvADohxr7LikLiIWiBvDUY7yoF7ydfivpyHR9dcNwDJY33Go130bNdmon7a8jPgom3KqHOk7XK5bNu9TWShUNo/QIYimwWIBA8v31Pg9Fa+OorjxLQbJiv7firtuPJY+VzQzHldncS3BEuECObfnkLlBtC4ZFwMdIM1GMRwFWArNVk+uKWNpsG1RBPLrmzQbJo48xNfXm7r2MObLudM+aaj5fyJC55szMxhTx9nLFtOyq1/FNLV85Sd9TvLqXM0UgWBKsBdhU1VW4T59Ms7uvQhGdbwZKMEAWIyZNiTM9dl4/yDme85XKjFg3xcv4fZyj+jtNYio/+XUs7Inx0COpX98yLU0WgEbbPkT1q4ZfOweG6+uYKSH2OR5LkQ88tncot28ye5MiXTqeHI+g6iIjw2cLdvQFd0WkQdvqMeXYO9Rsylt4j/5PHFvz+VRzxznqsIMVoKLm5UPDJOCeuRGgKQ2fnvstW+NgqroiJHNMYZJcCi7U/FPz6x5TWNnC0CEWWd2xMXGUjHX8/Nz+jjSugWqzt1rYWnj/Py2jlZqa9gAERESoE7+rXhJGc0lSFMWiaH4gq+9NPS3OMJ/sA2mTLHVXRFcOCNPKCjjf18jukruarv126tkjdA0Wz3DGSIPkBzKy7ltW62pL/detpwtsWgVOz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199015)(86362001)(31696002)(38100700002)(31686004)(36756003)(6506007)(6512007)(54906003)(478600001)(6486002)(110136005)(966005)(316002)(5660300002)(66556008)(2616005)(41300700001)(8936002)(4326008)(2906002)(186003)(66946007)(26005)(6666004)(8676002)(66476007)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emZoZHhSaksxRWRwdnZHZkJsWWo3RHRDTUsyN1dCMmExcVY2RURvcXRmZXRX?=
 =?utf-8?B?NXkvYk9WWHljRVB2NWNWam1hOWJnMnhrSE9CT1FzRTIrR1lpYWc2UGRoM0tx?=
 =?utf-8?B?OGFxRlBFbEhtSEJaRmRzU2VGdUZ0cndod3I1ZWUyaVBXd01NQnEreXNKUXJV?=
 =?utf-8?B?YVlUbTMyc2VyZ1dsRWszVFVwTlIzZ1FBUUxKcXBIRzZYTUN3N1pESHo1TVRo?=
 =?utf-8?B?bUE0TURuU1F3N0pYWXB0dVBjcGZNNVgxOU9qV0pQQnR2VGZud1VZTzZOQ05k?=
 =?utf-8?B?QlJNeHdYWGFqR09mZ1hJcDd0MXFySHFDREd1VlNuSlBnZVRsOEhDdkxxa0pa?=
 =?utf-8?B?R1ZrckNYYUNaUFRtRHNEcVRxRE55bFFmRmo1b2JNOWxEZVF4WDZXNUs0TjdR?=
 =?utf-8?B?KzVBeU43ZUR1eGtTZjMwRTJybDhHSU5MQ2hGc1hQbUNoZVVONkRYUFBhRVRO?=
 =?utf-8?B?ajFocXpnTm9nYXBpekkyRmhwbTRqRmRNMjhNRm9UVkhnekV5NTRwUFNpL3Jj?=
 =?utf-8?B?bGJ1RnVSYURGOFJVQmp5dDUxQ2FNOFRXVUdvbGU3QlZZYkZyTk5MOTUzeUxN?=
 =?utf-8?B?c25TUlN5bVN4WWVvN1dkSzlmTFQ4RTluNjJGU3N3VzFlTjBvUERuOHB1SzRK?=
 =?utf-8?B?QlpUNVZFMEIzYnV6TnV3dlFGSWZQMjdlNkdnKzd4SnZ2NXR2OW1FSUdUaHpH?=
 =?utf-8?B?V2YzdjVIMm1iY2ZWRUVySlJWMDZjU3I4WkY4QWxlSWZFbGRWZVJiRWNRa3FK?=
 =?utf-8?B?WlJkaGIrV01pNVpHNXA1bTFMWTNGMGVEdVQzU1hqSS9YSVBKTHZ3cWdxNHZF?=
 =?utf-8?B?SGhsaHErWDNwVlA2cnpUdkRkTVR4dkppYjJUUjE3YXRCdmJzWUNRTnBzMzhB?=
 =?utf-8?B?WWl6ZllwVUdXVXcrVkthVnFqYTdkYml3MGJzUnJZNnVScXBhR0JKN3lxMDZU?=
 =?utf-8?B?V3VZTkRRSjR6aFp3bjc3N05EeWtYbE8rUlhGSnBlVTVtajBaLzVZUWl1NnF5?=
 =?utf-8?B?WXh1dkZWTk5vUDlQQ3A4M1VVSFFLc282Y25kTXljZzZOcm52dEFlTkdvNHBC?=
 =?utf-8?B?VEE4VHQxVmFEMHJ4am1YUUg2enoydGFIa21Ka1BpaGZnZ1Q1YmFTRi9ZV3cz?=
 =?utf-8?B?Q0YyaUxnTWZSdXR4V1hkR2dWaE5jcHpKb3p3MWJtUDBlY1JGaEJNSVZ3d0lN?=
 =?utf-8?B?UWpVdWQwN3BpVk1SY0doWEV3Yit4dkV5VkppOGd4ZlRENXhKZ2R6VnZ0dTJj?=
 =?utf-8?B?K0tnb1h0TUp6Y1BnU29GeitNcURCS0dQK2JxUTNKcTREWkdFYmE4YW5IS3I4?=
 =?utf-8?B?ckt6enJHWFc1NktYeXZJMy9TV3FuYi90UTdTUWdLRk94a1grYXJSVG9sbUtr?=
 =?utf-8?B?cmtUMkZ1NHZHMG4vTjNMWncybGhFNm1iaStkckZRRzlnUkxYMmExUjFFSVRU?=
 =?utf-8?B?L1BGN0k1eTE3aFROak4xVm5MYWovMkh2cGszU3orUlRDUUUvN0Z3VDZuTS81?=
 =?utf-8?B?YXlJSExtVE11Q0E3UnljR25mSHEwTlF0a21HcVg4NnVHKzVaQzVPZHUxVTRX?=
 =?utf-8?B?SkxZdmp5VlB0STNNM2psZGk2Y29ITXJteis4a2NtWDExRWpOMnRUZG9iZXMy?=
 =?utf-8?B?V2pUSVNweDFlcWFEb1dnQnlERktybGVHN2EzUjQ1UDRLZS9FclhsWXdFckd2?=
 =?utf-8?B?TzFxN2puTURCcmg4azg1eC8rdktncXdQR09EU3phM21xcnJka1BiZkpSVkJ2?=
 =?utf-8?B?eW03NEd3d2k3eE1YdGVpeVFndmpLM3RqT0pSc0tnNGVtOGZSUm5Neml3SFAx?=
 =?utf-8?B?RnFVTFZLTG9xbEV3b2d0K0ovUUNCWktGMll0WEZDVHYrTU5ST2JvQUNoUThh?=
 =?utf-8?B?ZGxzaVFZaHArWCtXT2E2cG9BQjRLM29OM2xKQ2ZZYkxYUEJ3VThHVWtaa0dv?=
 =?utf-8?B?OW93RVpyZmh5UVNjQUpsZ3lSbXF4WXNZWEhGalhmaGQzb0hUd21JdHV3OENJ?=
 =?utf-8?B?YVhsc2g1SHVwYy96N3h2UU8rZlp6bnBzVHZEQjBRZC8rVk4xc2lpR0EvTUt4?=
 =?utf-8?B?K3RKTkdybXNFOGNUeVliM0dOeE55MUp3UmI4bklqZzNkVHM0WTZPdWwwOURM?=
 =?utf-8?Q?2tzsEFKPw5Sx/D4R2D6CBBhKs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f5db12-6154-41ab-81ff-08dabc3f09b3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 19:26:56.0722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoIYaOzkKb/3pMdr4TBnAm/yD3nUU0wqrqWwCLlcJhfocJBCW9Tx6ovENdXIBxACbO5C0sStThaaF2qbV472KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090
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
Cc: stylon.wang@amd.com, Leo Li <Sunpeng.Li@amd.com>, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, roman.li@amd.com, Max Tseng <max.tseng@amd.com>,
 Bhawanpreet.Lakha@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Anthony Koo <Anthony.Koo@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/20/2022 10:46, Rodrigo Siqueira wrote:
> From: Max Tseng <max.tseng@amd.com>
> 
> Missing send cursor_rect width & Height into DMUB. PSR-SU would use
> these information. But missing these assignment in last refactor commit
> 
> Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
> Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Max Tseng <max.tseng@amd.com>
> ---

This was reported to help fix a PSR-SU hang found in 6.1-rc1 and later.

Reported-by: Timur Kristóf <timur.kristof@gmail.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2227
Fixes: b73353f7f3d4 ("drm/amd/display: Use the same cursor info across 
features")

Alex,

Can you please queue this for a future fixes PR for 6.1?

Thanks,

>   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
> index 4996d2810edb..938dba5249d4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
> @@ -623,6 +623,10 @@ void hubp2_cursor_set_attributes(
>   	hubp->att.size.bits.width    = attr->width;
>   	hubp->att.size.bits.height   = attr->height;
>   	hubp->att.cur_ctl.bits.mode  = attr->color_format;
> +
> +	hubp->cur_rect.w = attr->width;
> +	hubp->cur_rect.h = attr->height;
> +
>   	hubp->att.cur_ctl.bits.pitch = hw_pitch;
>   	hubp->att.cur_ctl.bits.line_per_chunk = lpc;
>   	hubp->att.cur_ctl.bits.cur_2x_magnify = attr->attribute_flags.bits.ENABLE_MAGNIFICATION;

