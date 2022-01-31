Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4062AC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jan 2022 22:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 919D610E3FE;
	Mon, 31 Jan 2022 22:05:19 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2078.outbound.protection.outlook.com [40.107.96.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF34C10E35D
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jan 2022 22:05:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eurwHRoQ+KV/M0rFYh0HPHms0eLBm6/XaciGX1dBzt3wcxyooZld58QtHar7Oih18nKal6jYQeiM3fBtdaw/hnHUrxdE7G0fI/eTyXjr9RdOHfoM9De/9UfuaEXMm1qNDkBTf+Cq+rOivgSlbUj1sklns2tZmr/KJCgEKB/M/YcWRlVTITRCCSclQQyBUnq1LLSudaU65nRhwW23q5otItijpA3PzaAwxv1AdGkcG/IHVc5FopOe1cNED9kimtODF+NQeOjBN8jI2MR3P7ICL9H5ZNixHauEG1mbqbtkPNWCSQVnR3mL13GIskie8zHQTtJEGR5LakVVp51oc2jpHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+47j0kKDLfNR5IzV6NFhfi7d/rR7pSJc8YEl2H2PhLs=;
 b=d0/p08dqb6gDqWtu6xIQ9cuzoaGeFGalY1x/BY11+lSe86Fu573Id+iRqhhuG50ZYoqVRAB5rqq+0ihM/c1HIJRTm7yCCj+R/4B/065w25QBt2RkxrR3Q7WYXMpsfPH+9ln8f9dRQReHM01YAM+mMItpM1VKQY0KkqJiNT31UWosNAXgh9qPOFa0UMJE0vGVYJ24Nfhmqb5Qr8R2qjI5iPaIhfN7eFk7arYXKJ/cVlhOO/AstIaUFW6dO6inoAux6M0K4q5vwACyBMPg7ng5eFe6OrNktWyg+tJyaPtFgfbgvs8BIhqJ1qLfBtXfsZalm0/ZLZdlHVGwnpo9OGawxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+47j0kKDLfNR5IzV6NFhfi7d/rR7pSJc8YEl2H2PhLs=;
 b=YiNG6qs71z8oPwLCb176RjLsDo9XTIWUobtLbjTbfzVHiKYT/qM7Br6piYLPrF3uLJ3KgzdLHk+nDq3hthJj5JIKnaIm+Osjhcn9rTgOuNh3FcKwWfOHUW/qMhJIy9Z1xjkKwpIFdK+5uPNZyvhVKwSNaAuLUnTzNzGOYyDR+II=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BYAPR12MB3302.namprd12.prod.outlook.com (2603:10b6:a03:12f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Mon, 31 Jan
 2022 22:05:16 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52%9]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 22:05:16 +0000
Message-ID: <be68f51d-4050-dacb-85d8-a10125c2a059@amd.com>
Date: Mon, 31 Jan 2022 17:05:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] drm/amdgpu/display: remove statement with no effect
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220131215342.2763153-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220131215342.2763153-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::13) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8bf6eee-46df-4ee7-4a6f-08d9e505c33b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3302:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB33027448C8B8C6699CF3390E8C259@BYAPR12MB3302.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJEM06LrKAhEr/Tg/BS3yKsjX9SlfNf7rpbTfNsDP1B6ZVulPLiH57yEiFl0qTFuAPatBfikH7v+mIv/2eOiaWwgOl7OgAoyl/U/mTi3V/I/Z26nLbctPmuFxSp+yX3M6HpFkd4Ic/4dC4Sh0rt52SACa7WVGDRKM1MxeNTXo60QS75wiJtPQOFDXP/fAi+Tm3/N4XFAIl6ik99niUXY6sjWHc/GMnsXHjSvIZvGH8wRpX4wYWKNryKa9mozbyW2JT1e6ZAcvMXFGYKt1r6rPRWz0GEUEgRshIhtQ8UZSuTwyP0AKsZOMAHpogFiK06WD7K1YG0S9gUgkNpdjyvMSyHRIL8pKP/liwRM3GIytWZAboy/j/oRI1V9qZ4zyZ/2rxKpN6x+QlejRZ2EWOCihKUPLMYl8uFL1WsBEYTFu56OTG047RRAiRh9c/XkiqeWjPZOdUvZ1Du04awgwr23vJyM25oSEtGfoxHbivRHe9fX/XQ3C34ZZwFy6xTkOYtQXJGfjwEmdzzurJ04QXz6LlmZf/O4joJiPr4P6Si+AUA7Al6Wt8tORm6YF3Lyo5FFD2kEgPQhJaRXvl1YQqzb2SvTJeA/q1MsVeco2tjsR3pPy1kZu7bRx3gg+VxFNSJGX0nJ7falDS86/rqc75LsXEKP9r+R83MpAVdmaV6+Ht2pTPCuH0MAz9FSGEKrMewCZdFGZy8OESr/C2QO4nPUuwFu9op8WjMA9QLsVLMCyZcO0WOBSNvV0cGYaBpCptBr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(6512007)(6506007)(36756003)(31686004)(44832011)(26005)(2906002)(83380400001)(316002)(86362001)(186003)(2616005)(66556008)(8936002)(66476007)(8676002)(66946007)(38100700002)(6486002)(53546011)(508600001)(6666004)(5660300002)(43740500002)(45980500001)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkJEcThCLzk1eTBybk9Vd0VNVkViclNGK2lmOGxMRHkvTVNWU1YvVTBTbUZV?=
 =?utf-8?B?Y1BRY3ZKQStNZldtTnlwZXZwbEdsRnNhTEt5d1Z6YldlV1BhWm5vWTJDTTdU?=
 =?utf-8?B?NjZ4NVR1cWhaVWdRTVRjOFFyczFTUS9XSmNtY3Nlc0RoWDlSQ29GZ1lncGh4?=
 =?utf-8?B?S0ltTW9iZVhrbFZvaS9GZDJLeGhUWFUzYTI5Ri9TNzl5TDg5WlhaRVNMOW8v?=
 =?utf-8?B?Uk1XRCt5MGhTZVlUdmVLdTZ4M0hHMFlwdjM4UWphOVlUcTFpUnB3VXlSTnI2?=
 =?utf-8?B?bnFnUVpUQ1NBQXhFdEFNa3pIK1g2VGZGR3J5RmF0UmYvaXZEYVZZSExMS1JV?=
 =?utf-8?B?SVl6OERBS3E2OWlocE5aOEFpeTdiNjVQR0Z2eHQxVjNwWVQyRmlpMENiTXg3?=
 =?utf-8?B?K2ZxeU5FTXNBSU9ta1ZqdmhZbk5DK3ZjeHJ6eHM3emViSjlaRGNuRUptSWhS?=
 =?utf-8?B?cWtxMkhYTnhmcVJzQkxFVWptUWdrN1ZhWVpiSko0MENzbXNla2pNVzVWSmxu?=
 =?utf-8?B?a01DYy9PQWtySWVUQVkrcUJIQmVFVE9TTkJDUUhjOXJiSmJOeDc2UXZYZDZV?=
 =?utf-8?B?T21lelcxNEJkLzlPZ1pKWWRJN1hjZytYTTJGUVArajArcURrTTJBYVRObmww?=
 =?utf-8?B?WWI1ay9pV3BYSkQ3VHNJTU83QUNPQU9mN3psQjdUNUxYR2FOQWZMVUZ5RTUw?=
 =?utf-8?B?Q05uOG5tZnlPRlhSdmM2d2xxK0ZGLzV4NmZnQXY1RFcwd1RzM29XSEU4R0Vo?=
 =?utf-8?B?Y3ZVTGZsUmVwenJpSWRjMTh1VFQ0dVJ3d0lMWlFleG94VDdodzZQWWVxdVcx?=
 =?utf-8?B?VVRnd09EZFpkdjNycHFZZUhUZEZpRmlCc2hiV3ZRcHgvd2x1aW5yQnV4Zy9N?=
 =?utf-8?B?a21WeTdhaldJVHM1Y0MrZUhmYzUyVEFya0h5QkplRlp2V0U4cEU3ZXMzUHU5?=
 =?utf-8?B?MUhpNGdIdk5OejBJeFJQWDlUVmJmVDF0TFVpcHV5UXRGVVc3aWdJSXhYR1RD?=
 =?utf-8?B?OWxORlV6R3BPVisrSzk4RnNMakd5b2Z1NmdXSDRvek5HVW1QOWJocnFMV2tr?=
 =?utf-8?B?V1RCczdUZmZ0TWxLcGpCSnZZWm1YWlgrREhqb0ZUalk4Q1ZQc1lLRXZvWEZz?=
 =?utf-8?B?TUE5MFRwNnpVU0dyVmY3NmVjOWZPVCtJbFIvdXNzWklwSkhVbWFuWm4yMFN6?=
 =?utf-8?B?L2FhMVU1aFlrSU9RQnpFT3lTSmZOSEVoT2ZGVW5wTVZkSHFiK05ZZFhIRG1U?=
 =?utf-8?B?Zi91WG83aWRRU2s0c3BRWkVuTFJtY1E4cnk5dUMzTjNvVnVtVEhIWDB2ajJk?=
 =?utf-8?B?U0FoK0FVbVFURHNCWmRnNisrZmdZdVdodnFrNEJXUUlZTTI2TFgrTWdyOUtm?=
 =?utf-8?B?WS9rM2F0bDhxYytMTU5TY2dDaHNVRFhpbDAxWlhWM1gvV29vWEVLV3lNb3Nn?=
 =?utf-8?B?ZnZaU211Q3pEMFFhYU15THZEUGVXdUtyaW1PaDlIaGRZUlpTVWkxY0IwZGVU?=
 =?utf-8?B?alh0RGl4Y2xZWmdCaXdSK092eFpCRlZ6ODU2MWtoaDVCS2hMODBLem1xWUEv?=
 =?utf-8?B?Q1RKSXI1cjZCNDhDVTJLUVROc2Y2SVB1eHpZUEZkOWFGUHU5TVBXYndZY3Q4?=
 =?utf-8?B?UnFyRmg1T3YyakJrenAxWllyeStQVFR2QVRYRnNHam5FemovRkpBcnJFc1hN?=
 =?utf-8?B?WWk3NVJOczg0MEVuR0pZOE9CZWVDQUdkTGtJL2ptUmROdDNudWYzSmlRRjE0?=
 =?utf-8?B?Y01FU3JIem9nUUxzQzVIcHp3Mm9SMEtramw2K0VCcUFYTHVUMmliYThjUUZz?=
 =?utf-8?B?eGV3d3I4elZ4WTVTbmZidW9oREQwK3RIS2dmWlZrblV0NWpGZEI3YitPdDZo?=
 =?utf-8?B?UmowOWxaK3lNZTczVFFmeldQUDZSMEFqb2NKMUFSdG5WU01XNTJyc3hld0hp?=
 =?utf-8?B?ZHN3dFYybjRRMzRxc0I3VHQ2ZkFHRllsQ3ZxMFR4bGRpZnczVFdRUlZ5UjN0?=
 =?utf-8?B?OVBiVzNDR2lnaGRLS1laRTRTdmU3MktsUnVRdU1ja2lZc2ZmUjlRU09SbDk0?=
 =?utf-8?B?c0dKMmw3WkV1QXd0aDhaYzYrWjNjQ1RRaXJORno3YXM0UFU1L2F1ZXNUWHQ3?=
 =?utf-8?B?YzVLU09wT09RNzZMZ3U4VnpIdTNsZWQrdmJyYmtKRm55ZFo0dXFtSzRNbEpq?=
 =?utf-8?Q?YQu7Oynz5h0et35vX92/6a4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bf6eee-46df-4ee7-4a6f-08d9e505c33b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 22:05:16.4862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djPH4YcxUj56xEPD1ibr9VDt7mLDccnVEJuN6zmsmQ7GXwiqVtDGwyMDEKUXE+tZR1Ka87pl3HHBwnJ//upamQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3302
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

On 2022-01-31 16:53, Alex Deucher wrote:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_link_encoder.c: In function ‘dcn10_link_encoder_dp_set_lane_settings’:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_link_encoder.c:1123:49: warning: statement with no effect [-Wunused-value]
>  1123 |                                                 LINK_RATE_REF_FREQ_IN_KHZ;
>       |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fixes: f2581998d9eb5e ("drm/amd/display: add set dp lane settings to link_hwss")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
> index 779110a2d948..ca39361f71c8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
> @@ -1120,7 +1120,6 @@ void dcn10_link_encoder_dp_set_lane_settings(
>  	cntl.lanes_number = link_settings->lane_count;
>  	cntl.hpd_sel = enc10->base.hpd_source;
>  	cntl.pixel_clock = link_settings->link_rate * LINK_RATE_REF_FREQ_IN_KHZ;
> -						LINK_RATE_REF_FREQ_IN_KHZ;
>  
>  	for (lane = 0; lane < link_settings->lane_count; lane++) {
>  		/* translate lane settings */

