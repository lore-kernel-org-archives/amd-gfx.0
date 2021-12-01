Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A80DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 20:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 017976E8F5;
	Wed,  1 Dec 2021 20:37:25 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2066.outbound.protection.outlook.com [40.107.100.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F26CA6E8F5
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 20:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ej9TJnPrxfLAbJ7rg7XXPksWP/vLcyMO0VwqW/BsQdO7E7/vd/Nza6U5WiXPOhB+Ka4OfSkAGm/9dfzwWAawRfOOyaEVXk0K680prNzrrnlGgM5qZPLUwwUCOzCZwufqmHHlGRX+XdN+T3cx8qw0AYllHAqhqAo3E3rD58/QEmFVoT2anVo+yZnyevfLsBoeJ6i2h5CZnqDF+0giddxDzddkppW+wh2kyk4LXXPzrV3SBy/ozn+vvK2QSoUfNEqXX9sPXopVG/FE4xMPhTAbW8RUnigiRyMLZGmhJDA9Yx7j2KQvvxEf0S1oqgl5AwBsqthMDTSssHoUzqKLSlVE4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ia0w3pw+LhAaapTzY17vbCmF6LVEByedxDF2w9ZZTdY=;
 b=Ak8p1IiXdZmlVa4Wg8vXFCRC06/dRU1scqXEhZ2oLjGXqIh/b5rxvX9fOVuHF8tT4xqmgBrSNv3QcqWPyYbn0NrP3btwpaLxNCvBfbP3gQ35srExl0a0Ydmtdab2+b2FiX20YLK8C8qtPVvspisrlvUTceJPk1Ol3rp+SYljJDAqXAEmI3wjwCKjubSzgf4Nc8BfajiPPeNE6ipOQdNM+rE6kQ6YKSbCO1xEVZ67OM6YlD0s7mDdI8TI+Ykba5DeA4SZI7CrTGnMGaAC9kqAlL8DNdy1Bn34iHr2R/OzgeWdhYxJaUaeRuIIxD10Ds10BKaK4ua+pcP+Zr7FQDXvGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ia0w3pw+LhAaapTzY17vbCmF6LVEByedxDF2w9ZZTdY=;
 b=uYGlN6yk2R2CnE/NhMoNORFeBmARMBm4Fz+3X87iSlD3lITDmlbxOzex1OJvDIDLgcCRHH0HlVsK+TPRQtFQ+7rUNAVN61Z1UQWOz38ujVkb7pfh2lMOC66KEVocUAKTfh9zoSQ+FQvjB935c/BBa7XCqH9/HNOSlZbnGybOjMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5475.namprd12.prod.outlook.com (2603:10b6:5:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 20:37:22 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46%7]) with mapi id 15.20.4734.023; Wed, 1 Dec 2021
 20:37:22 +0000
Message-ID: <ce2554e2-ed14-e794-f403-fa247e48906c@amd.com>
Date: Wed, 1 Dec 2021 15:37:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/display: fix mixed declaration and code
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211201203331.844876-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211201203331.844876-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0327.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::7) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQBPR0101CA0327.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:6c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Wed, 1 Dec 2021 20:37:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af35a901-5c5e-4dc9-4652-08d9b50a6010
X-MS-TrafficTypeDiagnostic: CO6PR12MB5475:
X-Microsoft-Antispam-PRVS: <CO6PR12MB547584F1614507A98A6E9F648C689@CO6PR12MB5475.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RP8rYmj+c6KWOB3+aEcO16f16jUePmSJTmY5mau0FGVFtsDa2jPqlk9RlEdGj6PjlI172bd6pNoD+hxCdwKaZfHqXnDX6No3QUSJbYokKHrNHbyhSf4f+xyQhoo84qyGf+y2reVQ6UWHMFkV43JZ0RjKzGG5M3EOyq2Q4y/vu500DmIqiGO+qEMSeNS2aRUnLXBtoFdnRvsC5J2JRAgyqf+UoKX8sDid53Pb0E0tH0ecySlLrsGYA8t7BpmZv3+vNHoIUJ0pqVuOmEXzeQj4tziHXM0nmf10IjGUflaFXPNLDqAlLpNXaq9AG6l6Ir2a1DhLv5MC+7YyFEt6uEw2ISfuMQnAci1AU7jmYOREIDjSOu6gGf1SeCTNHp9g1/GTM+M7wjXILG0D9kHqx5zav6t5r7dkkwEG0Xt3qdpISENu7iYNf30edaVMk9WfQIo+cL7+GKsi/oBVKTfcU9f25zOXnGUwPtfziOm2W+DwfS6rnX1s1v30i+S1ZuNxmuWq2bgMO6OzjjfmCK6IybmDkEC+P4x3rh0xZQmHq11D0MzZxShoPgfKAAzqMTtVr0GmJlcwZm9S7V9WVrc6LOQFVgKcHOXTEvCbxWWqS4PKrVUlb+sI2QPpO/WNYT66vWdfcBu3ZPKuNPbDDP1moPjgR8G54EO9tSe0yDXoEFFsp4N+GjlMnLbbtt9h7cGcxZPyCH4jB0L4vijFo9TIwucmNPMO4NenPh65N/X/RhFi5Hkn3RsVzbx+hlVRQh8ZxS6d
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(66946007)(6666004)(66556008)(186003)(66476007)(8936002)(86362001)(2906002)(508600001)(36756003)(26005)(31686004)(956004)(53546011)(316002)(16576012)(6486002)(44832011)(4326008)(38100700002)(8676002)(2616005)(31696002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnM2N0RueVdGVkVVRUw1djY3MEFDUjJwd0JCcTlhMzdyQjNYdDQvVFJsSU1J?=
 =?utf-8?B?azFOc0kwSWdEeldKaGVMNmNYdVF2T2YvenIxMjBRR2VFWC9NMEw3STlsajBH?=
 =?utf-8?B?TnJnb25DdEwzSWJxWFFzMWdLbHdkSFlkUnMyY3NaUmhqMll6c3ZLWm9vUGJF?=
 =?utf-8?B?T3dDTXY4SVRJZXJyaVJvUS9iSzhZSER0UE5lMHlSaDhtYUhWY1BUSkg2RDlq?=
 =?utf-8?B?VG9kaEJmL3lOUWwvcm9zRDhNMXdnRExqRkE3Zi9XeTZBUlZSSFBTMGV4VmZ6?=
 =?utf-8?B?M083cGlxdjh1aGMzeFY5dzd3Y2hIZEhVRmN0a3MrZ0FianpUc1ZlYU9iUk84?=
 =?utf-8?B?WldNR2NyWFFZQnVvUHpqYWZBTkJEMWsvMThEWE10cVRSVDhQWmJ1VVZuUXk4?=
 =?utf-8?B?UkttY1l4ZGZWQndLM2R6Zmp6bWY4QS9FKzBvRlJobXVrZXhjUFhPRjlHTW56?=
 =?utf-8?B?bW1Fd1M5U05TUDhGbGVoZVJpc0ZVMHp1SDY4QUV3dnk3emZVaEpsZXJyK1Q2?=
 =?utf-8?B?cTFReEZmcnkrd0szS29YOXNCTUUwVE9GZnJCLy85c2tSUEk2T0JZQjFYbUFT?=
 =?utf-8?B?VE41Nks0TnRPSmo1bkJPaFlmVlNnL3F3WUVyN1lkaWNoK0UvQ2IrUTdxQ21W?=
 =?utf-8?B?ZnlwNmhHMngzTkdDNjlTdnpYb0R3bklPV0YwQ2NOOFJMVENBQXZBNTRvVWFV?=
 =?utf-8?B?cEJzcXNSdUlncEdWcmNuQjAvaHlkcVMvMTNKOXlUTzJFQ1dPZEtZVFd0T1Qw?=
 =?utf-8?B?OENpY1lBaWo2cVp0bTFzV3VuMzhmamZJRkNkV0JES0NLOVlIVmNlS3FCMDYy?=
 =?utf-8?B?czZ2bDArK2VSQlQyS3YxekN1cXZISU1JMkt6WW8zSGxjU0hUeGh3QnRLRzFL?=
 =?utf-8?B?a01KTzFac2V2QVFWMWVLME9MSTNQUk9JWnNPSndxb21UaUpEQkdOTkI5OWl3?=
 =?utf-8?B?aVl1SEVqNnFkY3lzNjhZYUU5R3hBTTBhZGN5U1VPL3hpL3BYR1pvUWRkYzd1?=
 =?utf-8?B?YmtIMUN1Q2tzV3cvT3NxSW0yRDFTTGNITlhwbUNEVndnR2Q4Wi95Rk94aDln?=
 =?utf-8?B?b2NIb0NicHZ0K3pwdWtOWUZQc3RvZzJnWk85RXdCVGg5bGFtQ2xJQXh3TUtP?=
 =?utf-8?B?VURkTSsrb2h4a3QwdzRqaXNQU3FZZWJqQktSNTJqSGJ3V3RmcXZVaE1XN2c3?=
 =?utf-8?B?cGVsRGZZNHhIYmpuQlF4bzUrYWRwZzgxN2NHMXJSanNXcytpQUxXejlRZDZD?=
 =?utf-8?B?WEtiSmFJUDFmWnNrTXZxRTlGYjg1TXVZcTFNZmtBWU1FcnlkVmlVblpyRnRz?=
 =?utf-8?B?d1dKSzhzTllHdDZwVktCRjVwUjZQR3VDc1NGOXJLek9NYzdxVHhTeFpzV284?=
 =?utf-8?B?a2JLSzVKSFZUdTdkSXhEdlpLYXZLbExMb09uSWQvNStTOTM4cFAwcERzMlBD?=
 =?utf-8?B?b1JaMTJ6VGw3M0hlMmZ5Vmpvd1haZW1ndW4wTGFRRXZMeGRtR2hzU01MR2ps?=
 =?utf-8?B?Sy9rOVRIUXB0Z1pOZC9WV3MxLzJJSFBHeTJHQWtPeXZVNE10Wk1qckJoam9v?=
 =?utf-8?B?OG1jY2dzNDl6NlMzNXB4L3RUL0FhemQ1Tk8xSEFuTDJWcitUN0tsbHNYZktV?=
 =?utf-8?B?YVlIcUxUeHBnY0M5c09hWWEzN0lyU216eUFncGRTelhhRGJjNGozT0pDcVY3?=
 =?utf-8?B?SDhiQ05QcmdXWCtWbVBFcko2NklBR3NBZzdNY2ZoZTR5YnpPTHBVS2lMSno5?=
 =?utf-8?B?Y2RVTnlwRmdmM2F5QTZUMkh4dmlxSTdsYXdoaTlqZVg3R2UxOHZLNjZxRTNT?=
 =?utf-8?B?ZHBYQVBDYkFkWEZkMjRSSkc2RFptd25OUWtOazZoU2NIbVdud0hpV25ZSklU?=
 =?utf-8?B?RnhKYlJvMVZPazBUaUN1QW5JZGZKa0xuaTE2bTRZU051SFVGdlJyMlE0ZUpP?=
 =?utf-8?B?d2d5MlhzaC9adFVScGZHQTVCU21wOU1QNkhGaHB4YjY3elVLTlFKbS9FNUxO?=
 =?utf-8?B?dk83L3V5OUc3MzR6SDJNNXFyeUJaN3lGa0dBQTdUSW44bWZQVThtWDlaaFli?=
 =?utf-8?B?UjQ0ZEQ0VXFxVWVFRC9vVFpyTVUyUVVVWExHQjFYb3ZENlNEYk9rbkdYVDdk?=
 =?utf-8?B?Ynh5bGc3dTFRaWpJdTViWGVadXVCenBVWS94TUJrVHVSV0RRb0w0OXBOQmgw?=
 =?utf-8?Q?5RXLHxs+ht6WA4G402veJSs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af35a901-5c5e-4dc9-4652-08d9b50a6010
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 20:37:21.8642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JoKARjpAKXEZf88l1ImS5az9OhI+ftnqkzjROvb2+uhqkzqID0FhhdXHKtaNXvG9f5Q8aFpBbWwSUk3vPZq7MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5475
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
Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-12-01 15:33, Alex Deucher wrote:
> Reorder the code to fix the warning.
> 
> Fixes: 8808f3ffb14d79 ("drm/amd/display: Add DP-HDMI FRL PCON Support in DC")
> Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 66dacde7a7cc..62510b643882 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -4684,12 +4684,12 @@ static void get_active_converter_info(
>  
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>  					if (link->dc->caps.hdmi_frl_pcon_support) {
> +						union hdmi_encoded_link_bw hdmi_encoded_link_bw;
> +
>  						link->dpcd_caps.dongle_caps.dp_hdmi_frl_max_link_bw_in_kbps =
>  								dc_link_bw_kbps_from_raw_frl_link_rate_data(
>  										hdmi_color_caps.bits.MAX_ENCODED_LINK_BW_SUPPORT);
>  
> -						union hdmi_encoded_link_bw hdmi_encoded_link_bw;
> -
>  						// Intersect reported max link bw support with the supported link rate post FRL link training
>  						if (core_link_read_dpcd(link, DP_PCON_HDMI_POST_FRL_STATUS,
>  								&hdmi_encoded_link_bw.raw, sizeof(hdmi_encoded_link_bw)) == DC_OK) {
> 

