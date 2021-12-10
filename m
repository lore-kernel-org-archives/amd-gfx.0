Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABAEC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 16:24:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD59F10E31B;
	Fri, 10 Dec 2021 16:24:50 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2044.outbound.protection.outlook.com [40.107.101.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29EF210E31B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 16:24:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHmC5BbxDoOB4HajqowOPRIBfH0LeBzYtWzq/fmasPb402aFZkSuWMHBrS8lupJUcAyy2y+VQvOkHhzEQSfOefasLcg3yFgqOnC0qBSp3+7fqapdD4Y1UqCjQJlWRds6fkUKy8B27Jk1NmK9CG+48MB3aupS4P+yd4lGbvAgfLdR/D+rW/U9ky3kUfVXi5TooZD65KRPFXpcdG9AyY1yEOpJK9PLBP4kL92X0VdFyYwewckfE7XRu9S4cCTSLA5AOw17E48viLNtbAO9+iNlbuF0ScNBqIbZiGVpdWLA7QPi7tknjctB0RQt9/dsBrx0ajkEObVHveXlGw+rJC/0gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBK1D/29flHqJCpCuwY31sMUWeZ9w//fw3ZkN4s9uOs=;
 b=LprOoUvsk34LtMVu5HQ/drUeMqWZohEmV0AShyFRnM6DmHkp8lS9XMlKFwhJf9iDrjo67AdKspYAM1z8q8AtKfiEKsJVUM+fujFlB74LRiRRBaFy3oE/TWvxxQrGJtC6pZ29a8pcNJ56PF4nuSjGRNARGtgEVbnRrT2JqwQbmPOJ7ee1W1SitsAoOpViva4ye0z4/nXDLCbI4LWcEUPHl94R8L6nlpkAGhcb7Vb0EK0kB+6ZgjQSaWh7t6nfaSDRW07TfIrV/+sNRfnwdTrzLMY1IGC6RnmD3H8p/3COeMlNKsgmLjUhFaVgumotxalhd8jElmr1sb7XYx48Q2cG9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBK1D/29flHqJCpCuwY31sMUWeZ9w//fw3ZkN4s9uOs=;
 b=kZnjhmvgQi9FluNAjssFxYWBuVuIYJZBxsdLsL1BcQwQKclgqMf8yx4P+cTIkXSh28RvNOqYrWSd2AlVo1TxJn03VE5ruYPtRCVAiqbBCVdA0CNRWa/pcynfhouLRb3zBREPHALilO1TXeDmndpYlVbt9UMtyiompC5LnXbbNdg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5492.namprd12.prod.outlook.com (2603:10b6:5:35d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 16:24:48 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46%6]) with mapi id 15.20.4755.021; Fri, 10 Dec 2021
 16:24:48 +0000
Message-ID: <d7ccca37-b77e-bec2-d8a8-d9615afce540@amd.com>
Date: Fri, 10 Dec 2021 11:24:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] drm/amd: move variable to local scope
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20211210155415.11867-1-mario.limonciello@amd.com>
 <20211210155415.11867-2-mario.limonciello@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211210155415.11867-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTXPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::27) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.107) by
 YTXPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::27) with
 Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Fri, 10 Dec 2021 16:24:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2184da34-7753-414f-1b1e-08d9bbf995dc
X-MS-TrafficTypeDiagnostic: CO6PR12MB5492:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5492F44357DED6DABE4950ED8C719@CO6PR12MB5492.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +x7p25mrSiPAz1ytlJM8iUw9IV+0oREyMgxP5GJ/c/JNMix/KBY1KuXoUqJZF9VJalIcRWtIHru6YkHaFBcwieLvDMEBgofCuSY7InWkeY4YHGI/9ZGPWyrAdTv1yYb7uuPfBd1y9mBYVI8EczjH9/ECI2WRJGUOEXxq4TOKr5BpcDMOkRz1Yxf5ZQmZngX/p5lUSv+xhil9MmwA2l6DWDIVXQinPvK3gqLWorvCIkwbe+y3JN8mby2C/IY69CupWm5e5oqxga+854OXYCkwMqZmPakR1O6JpQv/5mC/stNasEzFrhvq7OzAiZqbQu1JhCUlkEUtuWsoSld4TjhZsErA2+SLs2O/gVzeoDLDB2pl4m98HZhTfizs1w0zlWRVNOzMmfa+IqI300w+gJAQn1FcX4WrBYFhS9rEB7A+2WuH6sXGigzXs3d52txJe1TV4C0zGiwd2byPlF4cIR9gDQu6CRFumd1or/9Ala2BCJc58zLamdN6Vkj4jovpreYMHZIVKBYoO4luKAAdO2kvl/2ObNnzJZuauPHqhj1PMFvQK7FkcltRdHoJWEHc9E2HAHeKfnWluNyWWpr3qN4FLjbWXxxwT4O+frUdjBs3770AHdtS+uJHikug+pOPovL1HHaIVpkwjcLvpv6UhGV7u//qNmNWNwuAgi/lmlWVqzxKik0gQYNd93xNFFG8prQURv8guR5ScEui2qNTutB0jC8I4ZY8V2mbelCUxmpH1WCOFcJUO490nkzcnvTuey2G
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6666004)(66946007)(38100700002)(83380400001)(86362001)(8676002)(6486002)(956004)(508600001)(2906002)(5660300002)(2616005)(44832011)(31686004)(53546011)(8936002)(316002)(36756003)(66476007)(66556008)(186003)(31696002)(4001150100001)(26005)(16576012)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUlqY3BRRDF3TGJZNWMwcm8rSTcrc3UyWnhGNXA4V2cxdWNIeWtHb3lsSXk3?=
 =?utf-8?B?bnNZb2syRFBJNHd6TGhmYzBVR2RYQ0JockppcXpra0NaTjJxZmtWbXJ2RWdy?=
 =?utf-8?B?dW9HendqUVJGZ05yNVlzUzVScVU4Q1VGYkFSSmZmZHZqbGFiV2dYM0J5NWdT?=
 =?utf-8?B?cjlXUW1ycEMzRjRSa2ZLZ1NDNEt2K0lWWDZpNzJlQ08wUG1xTnlkemcxbXM1?=
 =?utf-8?B?emlpUHVjS0kzMlh5UWpUQUMrZ3ZPOE8xc0pZL09OY0RwWENQMkNlTm9WbDZr?=
 =?utf-8?B?eTExa1BrWDJNRERVNElheU84L21rU3YrRUlQM3pVVjV6MWFPVFp2YlFaNmE3?=
 =?utf-8?B?VVJVVW1xeWdMeW5GUXN3YTYzMU9DVXVHWmpGWUI3d3pzRzJJT0ZKV0g5VGpV?=
 =?utf-8?B?cjIrTElLSjhZcEZ4NzlHTmt2NC9wMlIzQmRncUJPMnBoQ0hYK1JxekhEeit0?=
 =?utf-8?B?K01PV3E3cE4xRmtBM2djYmJMWDFZaFF6THViS1A5Qk1Sd0ZlY0MvN0JVWGln?=
 =?utf-8?B?VDZtaU94dzd0TnZuamY2NkFBOTEvSXlROUZwQUJhamVka1hSY0RyeUlWUEFO?=
 =?utf-8?B?ay9GcU5hMHZySkkxUHdmRmJjRFpKVHpweDg2TEZaVUNmVXlQcnI2N1BFRlVl?=
 =?utf-8?B?c2JpYVh3bFZBSlJnbS81YkVJekREM09hRWNjeDRiQ3BRNmJVMzhuWjJMYWZx?=
 =?utf-8?B?aG1ydHBGSmJFcVN4ZWhkTWdremlCODQzdlgyYjRnMDFlMm9tSlV3aXk3NkRn?=
 =?utf-8?B?TDAxZFZJWlpUSnlzVlU3Z3N2RU5EQmdhUEVUM2Q0RmQ0a081aWlmRmV2OEcr?=
 =?utf-8?B?YXNTSE9QL0V4Szl2d0U2S3hFczdxeEk5dG56dWpvaWN5MjF4TXEvWFZmWWtq?=
 =?utf-8?B?T29yU3hSVjVQU2FZZ280NktFbUgza09jSFJ6LzBLeGRzU3BQaVY2MlZabC9j?=
 =?utf-8?B?aUM2QmtWR2lqdFFydHJnY29nc0pTV2d2MUNGaXV4RTg0N3praUtGLzdtM1Ny?=
 =?utf-8?B?dng1eVlZK1NrL2wxa0lDeFo5bHh0T1pEdE9xYnV2bmRDMHAycVVXVVhmdWc1?=
 =?utf-8?B?N1RQaWVpOXJYcHIwS2dPRDEwZE5QNEo3Z0FZNHNTcmhJREZ6QzZGMkp1L01F?=
 =?utf-8?B?dkVDOVFEL21DOVJQbWk5VlFwUE9ZTGc1OG5JUHJYbUlka1FsSmo3WkkrUWxP?=
 =?utf-8?B?TndRMmxoVWFwTGZCTmRUaUhGRmxMNlNNQ3Q2eG54di9LL1FyOHIwU3FuS0th?=
 =?utf-8?B?Rlk2SHRXZTVHS0cvelp0M3hQOXh6aDBYVm5MdHNwNE9CbVhHYVNvdW5RZXha?=
 =?utf-8?B?OGlwZkFUT2twcG41QXYvblo2aC95dEVad1lBSzl3bTNXZGw2YnNXRktVMmVH?=
 =?utf-8?B?Q1NWUGNmWFBlZ0puU1lJSWFxSTlVdjZwMVVHRXNsR3RpeDM0elhSWjNkMlhB?=
 =?utf-8?B?d2d5eGJFQXd1cHdxRXFMcDk3NU9vbmN2bllCZjh0RTRUdGVUcjZkZzFiT05x?=
 =?utf-8?B?NkV4M0ZkelpzZ1V5VDVXY1MxZUt2S0V1TVc1WTd1SDBUUVdac3pEU0FNZGYx?=
 =?utf-8?B?TmozbDlFLzZIeHJOK3AxNGd1VVhYZFhuZ2FRcDFrdGlmMUY2THFib25reXZ4?=
 =?utf-8?B?R3RMRytkMlpkT3lRU05lcVMxUms3TCtpMXlpL3YrdTYxeEl6MzFGd2RGUWpZ?=
 =?utf-8?B?aWJoU3ZvMzhtYXFya1pwaU1YczFpb1lsRUpZVDNyNTFseWVsYzdpeDZibG1G?=
 =?utf-8?B?a0toYlVPdEJURFRsZHFCWUkvT3BlU2t4RVJIYkdwM1NYYXFFOWhCblJGWUFB?=
 =?utf-8?B?SjQzNDVpYUVpWXFuVWFSOWNOMTg4cGhXa05PaGN5VHlONlRNMXRURXdCcW9v?=
 =?utf-8?B?cGpjVkZFZWlNOHM0MGhKa0NlemxyY1FwNHVDUlF1R0hCOG5ZYmtEM25rYVp3?=
 =?utf-8?B?aEZzRjZ2MUZRRUhkZXZoeFdOOVJCNlBKRlJvTTMvem1aR2hmc21tYTlqZnRw?=
 =?utf-8?B?dHBQZjZGRkhBNVpOYkYxK2U2V0JFTUlxTkRwNG50aVk5TGxacWpwUnlVTEFE?=
 =?utf-8?B?ejl0SFF5QzYwcTMrWmdvV3cxNHdEd0FzUlJWOVdIclNHM201d2VUdWYxQjhL?=
 =?utf-8?B?T29xZDNlRkUwOTEyWm9tUFZtalA5QnkyVXpIMDBDK1c2dXB0YnpXSkY1cDIy?=
 =?utf-8?Q?F1aCp04gKLLI3ZW7AVi7vrM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2184da34-7753-414f-1b1e-08d9bbf995dc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 16:24:48.6988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uRlgXOfrrGxhThuiocwNeYhwnbR9H6Jk8rj+C6XXKwfwXWR0X6tS1j5lhECGXQOq11R4Z+BoblRmd1ESscnodg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5492
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

With Christian's comments addressed both patches are
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

On 2021-12-10 10:54, Mario Limonciello wrote:
> `edp_stream` is only used when backend is enabled on eDP, don't
> declare the variable outside that scope.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> index 0d6dc329dddb..fb578b311b98 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> @@ -1798,7 +1798,6 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
>  	struct dc_stream_state *edp_streams[MAX_NUM_EDP];
>  	struct dc_link *edp_link_with_sink = NULL;
>  	struct dc_link *edp_link = NULL;
> -	struct dc_stream_state *edp_stream = NULL;
>  	struct dce_hwseq *hws = dc->hwseq;
>  	int edp_with_sink_num;
>  	int edp_num;
> @@ -1830,7 +1829,7 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
>  			if (edp_link->link_enc->funcs->is_dig_enabled &&
>  			    edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
>  			    edp_link->link_status.link_active) {
> -				edp_stream = edp_streams[0];
> +				struct dc_stream_state *edp_stream = edp_streams[0];
>  				can_apply_edp_fast_boot = !is_edp_ilr_optimization_required(edp_stream->link, &edp_stream->timing);
>  				edp_stream->apply_edp_fast_boot_optimization = can_apply_edp_fast_boot;
>  				if (can_apply_edp_fast_boot)
> 

