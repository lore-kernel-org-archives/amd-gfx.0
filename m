Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80287C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Feb 2022 16:43:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1665410E67C;
	Thu,  3 Feb 2022 16:43:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 232AD10E34C
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Feb 2022 16:43:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdgOsu1xY1OjWf1bbsxlXlB23PcIjIGYmm8msJ1+9kkEYEdD2OGwo2ttGfivNIUnSbci+KJ8aGtz1fgCpjZ+7mDXiKxaPZRdCF5cSw2suK69JkG0G/+HGe5oWqyRAp6PWXpIrqHh5GXR549Dx8w8s75VqKwYTcGGBSLs+RkQHGGiHkZ/E1rsLf2asiXx9DqJcdlH57JZ521y7zxp/2axPLvbJL+0ERceXl76OGCmTtgUgrkFEnk528kdFW61gSrjH4N7KLuNb5gIYBA5yZV83nItYe6QSTUpkKkoU2I4ty0Liygyj+EiqeJs3L2zUjfVf6E+biThtFseMSTQtb+Egg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfTNj4QMcMqXKG/1BecHH6rZMrdISs5wZoDs4m7tuZU=;
 b=Tpb0WE9KpRK6On+0ijJOLQQlHefzZT4htVwPQl5hTQpmvJKGDimV/Ci3j0eIo70bHCp30FDmbo2spXS7BbaTls2uU3ohGceMNCsNzmRBhgd66EvFXHGq9GdW1MRyHtUBNFfjg5HsqdnrYWA43wIqDl3OXlhLXmVCFCPkR9MMNq9PVuSHAjBsAo3n21vv83OIEnVDlSENrmhJL8KBUbBW1eYtswQj4rjkJtqcaU+WbOJHKW/lAz935attRNdAx/Ke+UNzvk4gpFCy7barN5Zl7vljz2pAtiQ/kmriVp2y/Z1FDu2IIv4OUPt7YCqsVjWkGuxzADzTMInF9ZPcz8NbSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfTNj4QMcMqXKG/1BecHH6rZMrdISs5wZoDs4m7tuZU=;
 b=fBHI/oCDcXfKjceiSeJYr/Ao1B2bc4mATU4ZPrUbyIeSRAeXBRj+SnoHX0MWE0R1ddeKgvuPGhKxufYMWeE5B1/zZS9kArwp0oxZTz8kGiydtDAFKDjUHEGvhLMgxU7foGIJighE+PJnPiXPCgXYP3Sgs+vG584Le5aleG+daFM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BYAPR12MB3127.namprd12.prod.outlook.com (2603:10b6:a03:d8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 16:43:35 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52%9]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 16:43:34 +0000
Message-ID: <5ad5f687-b676-e9a5-596b-e8873b04e196@amd.com>
Date: Thu, 3 Feb 2022 11:43:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] drm/amd/display: Handle removed connector in
 early_unregister
Content-Language: en-US
To: Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 nicholas.kazlauskas@amd.com, wayne.lin@amd.com
References: <20220202184956.464527-1-Jerry.Zuo@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220202184956.464527-1-Jerry.Zuo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::27) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f9e7494-c27e-4ebe-eb9f-08d9e73451bb
X-MS-TrafficTypeDiagnostic: BYAPR12MB3127:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB312783BCBE00EF9F245645D88C289@BYAPR12MB3127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mmdTMC7RkIZ+YOZ/ZH+3CqGfhJrggcRYb00KcjV932GFIxLYz/5AFMrPmfge0PS4MeGeTXpAeHcHv3hyYVU2whYVvAkU+U9n8COrkOEh89ZnJ+4vm/luU5rkcIFhOF1nUhzYX9On3In/1ifdDZ0Yz2PKKC7IAJUp9belSDwpCJkua0c8jhjUEo3jeR3eTkUjFIN8FGoHShtNtvVHDdKLehGQHdJin2fpNxgVKnGH3CR7gXjk5Z1ocQqe3NVOZ89oZ6MOj5yp9OYiMf011Z6fNbUUT7IoWhh3654jBYC5bojxg3cAjXKnhappCkhIb2ZRmah0Y1xowpCQdoRszjqhFX//jzs9ynyjlGcQaJjsmVtnmPl52otLPlR+rYqqma2HbPJyqic1NEewAfgDz2OrDFel5IiSWahuMz2g+Pj1ykUImVs+GrUjNGr8GbNuW1EltD9fsJxoAa4KgC/bYpQgksAPVCfS+7yzxdLhjka+LQqMg+WcJmh+2LmWevsJI49yckwjvYBOqJQkeFz+u24hxnbJoFuLHOwkHGrc7rjTz3ozI8i1Jya+nmw4CsmcVhfPwng8sox9/1KxFkzeXRkBuh3WUl1xphNlG13hnLWPXY/zs9VpmOxVZEXJSF2bwJVuym2nTyJbUa5FvaSRPSTa9RzkW7zzxQRfps5BJnfp0DAcL3TmlqN8kxSQrQF79RHKmh8Y0jtfxPTq4OOT01/7hQvG8aBm1nMtc0/kceHH814=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(8936002)(66556008)(66476007)(66946007)(26005)(6512007)(6486002)(508600001)(8676002)(83380400001)(6506007)(53546011)(6666004)(186003)(316002)(2906002)(2616005)(6636002)(31686004)(5660300002)(86362001)(44832011)(36756003)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q05ReVJCeWhFMzI2bkJWSFoxS2REVkNiSkxOVitvaUdTcXVDNzE4Z3BVVEw2?=
 =?utf-8?B?V3NWK1VEeWJlVkZQZ1JJY3U0M29FYzg4Zy9SQ0o1dDVLREJmQVFuby9yVytJ?=
 =?utf-8?B?ZDBTdG5pVGJhVzE2VkVEajdYaUt6OGNlNWlYSXVqRUlTT2h2bGFDTlFna2pn?=
 =?utf-8?B?dzV4TmdEWTVXZmZFa25yZzhzMGtaNUpIYUdxdDZJc2VRQlFVRTlwSVpPTDJO?=
 =?utf-8?B?TDZWK0JBczdvZ0xCdzUwVTc1T2dPUEcvbm1uVFpqT1dhUkpYWjVqS0VWYm9x?=
 =?utf-8?B?WVEwSTJmLzhGY0c5a0kyeUFiOTlZSXorbXhEQkxoQ3FNRFE0bEsxelNwTUIz?=
 =?utf-8?B?eGtrRm5JS0EyZGQzclBWVnQ3NXZ5cjF4R3publdwSnUxeVMzMjlpcGsweUJj?=
 =?utf-8?B?Zk9xbENVNi84bTlNVzIxT3YweWIrWGJxS0YzRVlqbVgzV0l6UGFoSGt4OGUz?=
 =?utf-8?B?QlpsUTJLWXlJeUU1RmhRRUNYUCtWRURkeUlVdERSWXBUTlZHTTJ1TDdNdVlu?=
 =?utf-8?B?OERkYjIxS2lPMERmMkZwZ2hyREZTUVBiYmg1TE5aZkZyTWRzQ0owSGNIQ243?=
 =?utf-8?B?QUJZaFlqdDJGd0EyUGhEanBhWGw4OFZYcTNkYmh5UzBWL0lsanNZYmtDdmt6?=
 =?utf-8?B?R0hQNkVPR0dpelZxL1FDMDRhc3ZTZ3k0Y3cwaW0zMVY2Tkp3RjZBWEFoME9F?=
 =?utf-8?B?N2xUV2ZXTDVrVHB4L2t5L0RNc3k5cWVtcHdiK08wRkxEcUxjZHRpeUZsczlw?=
 =?utf-8?B?ajZvbkZuS1RTOFV4WUF0NkZNVnFDbDlZTVhOZndpQXltYnpwVi9uOWJXQ1k3?=
 =?utf-8?B?U1RvMGhvSEVsVXVjR3BqUGZJWkFkazhPTkVKQ1NRL282bGtMZndwTEdmVitH?=
 =?utf-8?B?Z1drNEZDUWV6Y0lYemRieGlsbzhPWkluT2s2V1FIeHpWZTlndUdKQTRKU3lq?=
 =?utf-8?B?Ky9hckdIZHlXQTlQQnpVdVNxUEdHbVNqWUk3aU04UmxGbVNQMWNETndwczAv?=
 =?utf-8?B?UlJPcnM4TlpNc1BFVWYyN0ZBSWpQWWJkVGp5ZnFaZGlDbUM2dmpCL3plQmtp?=
 =?utf-8?B?TVBpRzFrY2k2cG9uRVFjSHBxdklJNXZTT3VtZEZBSnpiZ0RubWlTeC9IMy9E?=
 =?utf-8?B?a1hjMi95d1F6dS93cW5scEN3Znpod3dnaktySlRlNnN6NXhVTWdlT0NCSWRh?=
 =?utf-8?B?VjJKSU1rNzVXNVAzWmV0Mzl4OFN5eWI2U3MrTVE1UFBsTGJQSmJjVzBhSnFQ?=
 =?utf-8?B?ZDZvWHd0RmFzaTkrWUozUWVxRDNON2l4SnQ5c1g4Sit5cEFrNFFYSU5UQ1hF?=
 =?utf-8?B?VENycU9NWDFBK0dYTkgydUpnRXAwQ0JjbmZOalpRU0pxdFRIWnVkRGRWZlkv?=
 =?utf-8?B?VHQxYW1KNHMxUDB4cm9LTTdjVEhrc2RuMXhYcWFrUC9KOGVVMDFXUTRHcmRK?=
 =?utf-8?B?aU85QTk4dC8vdnk3M05kdFFTRGU4VWh0U2h4SllPSXd3REpOd1lIcHFFdXB4?=
 =?utf-8?B?Y1d6R0VlVFJLbEFJMVM4TG41UERrMlZzbXp4cEZNNVZ4a0NVclp6VmpzR3hN?=
 =?utf-8?B?WjFlVThkQkZuWklYdGx4a2dTbE15SmpEM2xkNUowdHpRMVRSMHQvTHdYY25K?=
 =?utf-8?B?QnFpWlErQUppd3Z6bW5TeVJDUXZZNTNXcGVsdUsyK0hYNWtpMktUcTZKc1Vw?=
 =?utf-8?B?endCVko4QTBnRStRajk2WUZWMEIwa0MxN0wwS3JzQ1J5cXNBMFY5bUR5ZHMz?=
 =?utf-8?B?SGdDYVY3YWdyUkZKMm8vU2xOaWdHNFRScFNPdHhqOGNxUUgxeEdxeUNSWDNE?=
 =?utf-8?B?K3Y2VDJoMFFMd3U5ek13WllhTE1ZV0lmTTN5V3g3TkNpMkhwcmhTdWx2aTZR?=
 =?utf-8?B?OGEwREJyL3ByUlp5eGZmOC84Tm9QZmZHaDlJMEpZSjI4dFJtY0k1TjhhbDZF?=
 =?utf-8?B?N1hQa0xiRGlzMzZ6L1pONGl2d3dlRmlEN0VkbklWblhyb2lGT3Ivamt3UzJZ?=
 =?utf-8?B?dWwvUXpKdnU5eWgyT0swTFRhOE1yMXBVcTI2UnZ5VDhSMkY5VmNjMy9pbm92?=
 =?utf-8?B?YlVWTXFqM0haZW1oZSsvRUdpeWgrSDBtWmhHVVlESFcxUFdzazd4UFhFMUhh?=
 =?utf-8?B?WTh1WWlabVlDcFBNRW03b2dRUDhzQ0FRRWZ5WUFrR0FlS3JURGI2azhZcENw?=
 =?utf-8?Q?OGIwtMKDmerA1Q0yEFislR8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9e7494-c27e-4ebe-eb9f-08d9e73451bb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 16:43:34.7877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZflOr6VmV0wr9HzauoEH88/Yn47RgP+bwijxnphhVvtAZP524LnG8S14ygxPySukT13xlkgzqW9c7Zd3llpClw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3127
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



On 2022-02-02 13:49, Fangzhi Zuo wrote:
> From: Wayne Lin <Wayne.Lin@amd.com>
> 
> [Why]
> commit "drm/amd/display: turn DPMS off on connector unplug" and
> commit "drm/amd/display: Clear dc remote sinks on MST disconnect"
> were trying to resolve the resource problem when we connectors get
> disconnected under MST scenarios. However, these patches don't
> really clean up all remote sinks. Nor turns DPMS off on all affected
> streams. Also, these can't handle disconnected connectors reported by CSN.
> 
> [How]
> - Revise commit "drm/amd/display: turn DPMS off on connector unplug"
> a bit to handle none mst case only.
> - Revert commit "drm/amd/display: Clear dc remote sinks on MST disconnect"

I don't see this revert as part of this commit.

Generally, if we revert code it should be done in a single revert commit
that is generated via "git revert".

Harry

> - Revise a bit the logic in above patches and change to turn DPMS
> off/clear dc remote sink within amdgpu_dm_mst_connector_early_unregister().
> Since drm will call .early_unregister for all disconnected connectors,
> we can ensure to also handle disconnected connectors reported by CSN.
> 
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  7 ++++
>  .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 41 +++++++++++++++++--
>  .../gpu/drm/amd/display/dc/core/dc_stream.c   | 12 ++++++
>  drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 +
>  4 files changed, 58 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f5941e59e5ad..529b3ddaa10b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3034,6 +3034,7 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
>  	struct drm_connector *connector = &aconnector->base;
>  	struct drm_device *dev = connector->dev;
>  	enum dc_connection_type new_connection_type = dc_connection_none;
> +	enum dc_connection_type old_connection_type = aconnector->dc_link->type;
>  	struct amdgpu_device *adev = drm_to_adev(dev);
>  	struct dm_connector_state *dm_con_state = to_dm_connector_state(connector->state);
>  	struct dm_crtc_state *dm_crtc_state = NULL;
> @@ -3074,7 +3075,13 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
>  			drm_kms_helper_hotplug_event(dev);
>  
>  	} else if (dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD)) {
> +		/**
> +		 * MST cases are handled within .early_unregister where we
> +		 * can handle disconnected conectors reported by long HPD
> +		 * and CSN.
> +		 */
>  		if (new_connection_type == dc_connection_none &&
> +			old_connection_type != dc_connection_mst_branch &&
>  		    aconnector->dc_link->type == dc_connection_none &&
>  		    dm_crtc_state)
>  			dm_set_dpms_off(aconnector->dc_link, dm_crtc_state);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 8e97d21bdf5c..411b55596b00 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -139,11 +139,46 @@ amdgpu_dm_mst_connector_late_register(struct drm_connector *connector)
>  static void
>  amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
>  {
> -	struct amdgpu_dm_connector *amdgpu_dm_connector =
> -		to_amdgpu_dm_connector(connector);
> -	struct drm_dp_mst_port *port = amdgpu_dm_connector->port;
> +	struct amdgpu_dm_connector *aconnector =
> +                to_amdgpu_dm_connector(connector);
> +	struct drm_dp_mst_port *port = aconnector->port;
> +	struct dc_stream_update stream_update;
> +	struct dc_stream_state *stream_state;
> +	struct drm_device *ddev = aconnector->base.dev;
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +	struct dc_link *dc_link = aconnector->dc_link;
> +	struct dc_sink *dc_sink = aconnector->dc_sink;
> +	bool dpms_off = true;
>  
>  	drm_dp_mst_connector_early_unregister(connector, port);
> +
> +	ASSERT(dc_link);
> +
> +	if (dc_sink) {
> +			mutex_lock(&ddev->mode_config.mutex);
> +			mutex_lock(&adev->dm.dc_lock);
> +
> +			memset(&stream_update, 0, sizeof(stream_update));
> +			stream_update.dpms_off = &dpms_off;
> +
> +			/*set stream dpms_off*/
> +			stream_state = dc_stream_get_stream_by_sink(dc_sink);
> +			if (stream_state != NULL) {
> +					stream_update.stream = stream_state;
> +					dc_commit_updates_for_stream(stream_state->ctx->dc, NULL, 0,
> +											stream_state, &stream_update,
> +											stream_state->ctx->dc->current_state);
> +			}
> +
> +			/*clear the remote sink of the link*/
> +			dc_link_remove_remote_sink(dc_link, dc_sink);
> +			dc_sink_release(dc_sink);
> +			aconnector->dc_sink = NULL;
> +
> +			mutex_unlock(&adev->dm.dc_lock);
> +			mutex_unlock(&ddev->mode_config.mutex);
> +	}
> +
>  }
>  
>  static const struct drm_connector_funcs dm_dp_mst_connector_funcs = {
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> index 57cf4cb82370..a77c90c14e85 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -739,3 +739,15 @@ void dc_stream_log(const struct dc *dc, const struct dc_stream_state *stream)
>  			stream->link->link_index);
>  }
>  
> +struct dc_stream_state *dc_stream_get_stream_by_sink(struct dc_sink *sink)
> +{
> +	uint8_t i;
> +	struct dc_context *ctx = sink->ctx;
> +
> +	for (i = 0; i < ctx->dc->current_state->stream_count; i++) {
> +		if (ctx->dc->current_state->streams[i]->sink == sink)
> +			return ctx->dc->current_state->streams[i];
> +	}
> +
> +	return NULL;
> +}
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> index f631b61abedd..89f67c711161 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> @@ -321,6 +321,7 @@ void dc_stream_log(const struct dc *dc, const struct dc_stream_state *stream);
>  uint8_t dc_get_current_stream_count(struct dc *dc);
>  struct dc_stream_state *dc_get_stream_at_index(struct dc *dc, uint8_t i);
>  struct dc_stream_state *dc_stream_find_from_link(const struct dc_link *link);
> +struct dc_stream_state *dc_stream_get_stream_by_sink(struct dc_sink *sink);
>  
>  /*
>   * Return the current frame counter.

