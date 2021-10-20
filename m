Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91755C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 13:56:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57F606128E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 13:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 57F606128E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFED06E2DF;
	Wed, 20 Oct 2021 13:56:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B1896E2DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 13:56:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfhG19kyXcwOaeXbM3bfVA+cUpzKFBp+5QA3ZofVrGWBcGlCRfu6IQMgRRoPc1bBQT6vu7gnr23ycKv4bE19yIy3m06kNEYs3oTMGhPoTl1d7WcCVRqFGhovSWDxKGteif3kZZKtESMig699xgZCbimE50opsWVZvDz+hvHhve0uyJcZSMBAonaj1hHxMIsjl1s3l9o5NLTS5C9KeUHA9GuQTR9f2qlN2pF8aFqYRwfYspJpxxFtBcN3ZrDjLEcaa21UE47Hxgycvs99IbJRLfjaURgoAas3W2y5ZSC0vWBva1KhxoCnM+9C1hnvrDNhFkIgh23nwvNdLAbMbY7LkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XABH6OtELNLm4pR27JhyS2JtuzErT0U/OJdG/wkGLlk=;
 b=UQvqqTajDG56oIE41IR0LnrKsGVgKSDUxZvzNvIbiRekTZagHspi9ZdedKCeo5YV478X0g5+aSOWmQF6Q1TP7aIOs/W4hE6ToxGWjkTi3vyoehlY9PTNF7yrc8rSwoj07qsc3VQm0Mj7MamKBdQ0yXHn96o2edxo1oesdAdMc3bI5xTEZ+Ypo0pXhXWSPVncdPtBMLSMSPvnG7LZDlnIz9SO2ELX/IzarNuCP/eZctU+VMFYMZdl24K2JvhtlFsTWSKa/FZR02oDiZ+3lb4TDupLYD0TdTw63nzohdCsRR6Jaea/sJh71rwAGrqueaWxk6eJErPaP9mDn9+866gGfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XABH6OtELNLm4pR27JhyS2JtuzErT0U/OJdG/wkGLlk=;
 b=z7ve5iyHhE4SD1IaJxheaobb70epNtsK0zcEStgEXEt7oae0M3lRt6zfM9tKTDI1P90GDbVLHfrrOL4pwtl2JTT7TIL6snptQDDoUbeo3XhbR1M7zXx9lzY/RayshAASIxrpVkqybvWgskJ5T6vexs9G6GWAgrx8DvXawZfk/IA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Wed, 20 Oct
 2021 13:56:43 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%9]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 13:56:43 +0000
Message-ID: <eb36e998-1b60-e97f-aa2c-a7fc5c6f6b90@amd.com>
Date: Wed, 20 Oct 2021 09:56:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] drm/amdgpu/display: remove unused variable in
 dcn31_init_hw()
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211019205112.682009-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211019205112.682009-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::17) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQBPR0101CA0144.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18 via Frontend
 Transport; Wed, 20 Oct 2021 13:56:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8a7211c-e793-4513-34b8-08d993d1725d
X-MS-TrafficTypeDiagnostic: CO6PR12MB5489:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5489876B9F0E1F553575F2068CBE9@CO6PR12MB5489.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rlH6G8E4zBOIIIBfh3MsnwOCljDkdUUUWWdseLXWINW4TNcN7FJh75RqhAXXTLMiSceJ3u5CeoNEh72Z2P3kDL0L7Vh0g8+YoOps3jM6FgcuqVcRw3P06tbNrGvTtCzES3hu2RE9d/6nbsrRNEH0ngILYnIf+SFyY1ac298Z3ovN4SdzB8OQlaOyjS6LcqKnk1CTkZEKk9+iVJFnEfyuXtNvWlnM1yqbmrOW7oGgioUzTCsJEzmU2SC+E6Qo0HHofjnMZ+GHzSHktEYLToZJ6kNib1Ub5iE8Mh/Qsa4WRxiGvZfBaB6jJWnjjiwKrlyG1W+zRSMoaFaJ+wOTaRH94m3y+VtP6iicsM+mi6Dp9AAF64kzm/D6u+vGDYf70Wlsbnaw8BCofEWAE1iMMA2RTkd12Mawft6r/rPSNAaJx4i0vypez9nVVav/KBu3Jb2wx34vgN2K3H9tEx4c+kjXJNLsMwHeZROvlrv+XCw6VbCOZiFO13WhnWp1xGKDuS3U+T8TI7re3KbL0udI3H6NAajTvtNwW0GlQUYsaVZs51ngm77qEIxfZoxBSy0KiaeVJ/kjS5G6nyKSEelhuDkHLALQyexaSdHaZKP6OtvmOkTom0pK2IIp/y95cZrw3E8qJ5v5ah9YnCwftXaa9XTpvEMwCQbhNoHNpeI10oQKdbLnzZSXb7X9DcQzcQboSKDKLauJ6oTO3Nxg25cDXyktbN50x6SdXnWE/0AdtC0XB6LsyfdLLqO+a625f3YvXcj+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(38100700002)(83380400001)(2906002)(6666004)(316002)(66946007)(4001150100001)(26005)(86362001)(5660300002)(8676002)(6486002)(186003)(53546011)(4744005)(8936002)(66556008)(2616005)(956004)(66476007)(508600001)(44832011)(31686004)(31696002)(16576012)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3lJL3M1VTRoa0xnUTBvRFZWc1pRZC9MQTJkdTJmVFlZNllKRWpTN2o4Rm9t?=
 =?utf-8?B?VEdXblVGUFRHUWRwcG5YZFIyY2tDd2ZZNEE3SW1QUm5GYjNGc3c0djFKcHhP?=
 =?utf-8?B?bW53SVh0N0ZGeklzSTBaOHZMZE1GUEJXSzllTlJYb3VJMmw5d0lXQXBnRWN1?=
 =?utf-8?B?akFWZFdVWnJZNDRLSnNEcUFQd0owVE56cmoxdXpLbk96c0RKSVE2TndCY1ds?=
 =?utf-8?B?Ym5jb2pWWTNpVkV2UjZDRnNPeFdpemY5TmZ4YlhPY0l2Z3B6VEVFZ1pJdmlO?=
 =?utf-8?B?YlYwaW9Idm0rUFpzRzVYRHVIQUtmbko4bXZaV3hHSStVWEMvUzRYQi84bU5Z?=
 =?utf-8?B?YU1xK3RJOFVSL0srT3MzV3V0Z0Z4dXNOK1FHc0U0dTRKS1RiMEpUdCthYXd0?=
 =?utf-8?B?NnFZanExWFRweVpNVXBFUjBQNkpIN0g0MUZ1b3JGWGM2bStaY0VFb0VHUmZC?=
 =?utf-8?B?S1J6RWlERjhaWWRzaVV3R0JXcmhxN0JmRnFrVm9CY2JSUjgreUYxSTdCbHFH?=
 =?utf-8?B?SjRGajFKSWZ3WFEyT3VUc2FnMDRLcXZ1SGRPQzRGeEFybDZwZm8rVDdJRVZx?=
 =?utf-8?B?aFJoUklXY1ZRRlN4Ym9LMEo3OHlEUUNjTDZiQ0t4M3R3bTg0Wjg5ZU93RUdp?=
 =?utf-8?B?MEFBNXBYQ0kwOGgwY3JybUlBN2MyT2JoMm1OOHRJa1VHMll1d2paNkRvazZl?=
 =?utf-8?B?M0NRc1pBaEFFRi9vZEtrcUZ6Z0ZHWE1BcTgrUkJQeUFoUHNmaVg0MVJRdDVE?=
 =?utf-8?B?TUdBZFBObG1xaVJ1MnRoclQ2OWVEMlVSUEhYeCtER3pCUENuZ054OXV6Y1Ar?=
 =?utf-8?B?b0ZDUDZZeW4yNWpVMnVJMlJxZDJSZ3pDQXZmTlo0SGVEM0VyMHd0YWpQZldq?=
 =?utf-8?B?dUs4a3FxckZrTW41b1N3NGZ5d1hJRU1RdGcveitCSVpySk5RMGVSa2VuQnI1?=
 =?utf-8?B?NUV5THpxejJqdGxzRVNCZWYzYXlXVXVQZC9mMnJOOExoU25GeXZWek9tNTJZ?=
 =?utf-8?B?L1ZyTGdacVRoTWdGMkU3NFA0eGFiQnhjNWlzNEhzQ2l0b3dFQzRWbjR4UVJ4?=
 =?utf-8?B?Rm81b1BSRWtZVmo4cThuWVR2SysvczBpOFU1dzdvNnNPUDR4bFdOSVRuTkxr?=
 =?utf-8?B?ZjRLR1k0Q3RVNzkvQlBkcVpoaUZqcnN0akFVUG52TG1nUjkrQVFtbXgweXc4?=
 =?utf-8?B?VUEwVE55cFd4b2Q3ZW1lekJwUWNJZE5SdG00ckR4TzNiUFVFRDJHVE5aUjR4?=
 =?utf-8?B?NVJYcXdSWGdEUWc4MDlUREVyTDVZMTZvM3U1c2JOY1VXZFIwUlVBWTZUWFpI?=
 =?utf-8?B?bkY1N1ZkZkZyeUFmOTBMbGRQM3M5VVpqYmFPTnE3K2w4bmVmNWx5NlBCVkVm?=
 =?utf-8?B?NUltWnRqcml5UGY1QjM4S0tkMzFYd1ZnazBkU0RITXNua0JZTkZ4NGJvRnVM?=
 =?utf-8?B?a2NqOUd2eTZDY3Z2blBWcnFGV204NnZCaG1UdEtqdy9nbzFQUWJ0WTN2clBZ?=
 =?utf-8?B?TUk2UU80VWxDbzdPQTVUbG5vaWZmcTJRd1VpSHFKc1djUkdwazhsYXhlcE5F?=
 =?utf-8?B?UFl3eHl1akpEMGtvbDJBS1dkenArc0hHaWcrYlVYYklvTzBsUVVuL0t2V1dS?=
 =?utf-8?B?VVZqM2ZpR1NTZUJYTGNXd2dFVzZiTElBZzhBL2l6dmlHQmtQaG1MakcrS1RG?=
 =?utf-8?B?T3hPQUpmSlpRTFZnUWJ0UlBJVDQzTkc1dFRrWlF2c0lWYXFOeGNsUEx1OFd6?=
 =?utf-8?B?TDd2SWRDa21JYXBTT3VxSEVGT1VMcmt4YWR1WjUvY0hqeHk2R00zTlRJcmhZ?=
 =?utf-8?B?MXN4aEhRRk5BT21lL1lybC9FZ3EzOFRqSEl5dUZCa05teGNSRlhzbGY1TVJx?=
 =?utf-8?B?Q2NtKzd3UVYwRURYaCt5YkZ5dWt0VE1SMkE0eVQ1SW1CQ01JWUtyMUVnbE1x?=
 =?utf-8?B?cmZFanZpaGU0K3VNVzBjUVdwbzdvY0VIMkFGU0V6VG4zbnBwTVpvc1VkVm5M?=
 =?utf-8?B?YkpEZWJYRko3d0VkN083R0ZLTXhsb2Z5bFExR2JVTDNaZVBiYWZ1OWhuemV2?=
 =?utf-8?B?OVdzQzZuOTl5YlRwNThBOXNIeFBnbjBPY0ttTnAwQmNqa0Irellpcmt5citJ?=
 =?utf-8?B?VEJpdU5TZ25UbnNzbkFTYUhaMnRBTGlWdVVXeUZadlAyc0pmTEdqenFBbGU3?=
 =?utf-8?Q?jdqe+i4kuZVMNvTGrajlruU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a7211c-e793-4513-34b8-08d993d1725d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 13:56:42.7805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JhA3XAOY2pL8daSsbpYQ7PkMY84MzS6TueVmx16aG2jxA7WjASTSGTLzR1rAqAv9M+o/W72Il+mD0entSjot/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5489
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

On 2021-10-19 16:51, Alex Deucher wrote:
> Unused.  Remove it.
> 
> Fixes: d1065882691179 ("Revert "drm/amd/display: Add helper for blanking all dp displays"")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
> index 7308c4c744ba..9a6ad1cebc85 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
> @@ -73,7 +73,6 @@ void dcn31_init_hw(struct dc *dc)
>  	struct resource_pool *res_pool = dc->res_pool;
>  	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
>  	int i, j;
> -	int edp_num;
>  
>  	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
>  		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
> 

