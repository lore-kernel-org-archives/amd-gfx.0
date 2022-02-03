Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E4EC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Feb 2022 18:19:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E4C810E6E7;
	Thu,  3 Feb 2022 18:19:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFB1010E6E7
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Feb 2022 18:19:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5PtGUXi/DZb0Xda5D+MD4y00suOLJIJsqfkUyeZmTAphPe3jVMOzkhHmo0PZfg69hWF+DINh1ad8fT4Uu/fmIqnE0Oa5lpFLuoOgfPeowa7cNQTZFw5DYcA8an8HBFG5897tEfNZqrW6BuqiVBTIGaI41oQqDK7xmubnLPm3JhfqYuvVX3y+sEvMoqfeuAB+i9aoPHE0tF+4YZbl2NNf9gpPgED8VkqA4Sv/6O2oIYXfzQwL8ZgQ8/5FkdvVXyIBrK0V7aAUU4SoOdiAgjHgZsA42iEti4AzUBN340wLej871m4INS3v4dhVhVOyXb7JhFyzKApw3Y0HxFZ3ZhuCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAHqA8RfcJCi1m50oTqxQfeq1UDD2VeOAErduSLhyxc=;
 b=MrbikIKxjJePNO4M9Ijvbni5RPhWMnkkFqudUGDD9QC331eKGP69aq6hUQ38L9kQhBUQBhDVARIBcT072nMGbhbBr730tZZejMq7rXFKCZU9/X1iFRcUXHGJZjWnvyZtLMzL5YH55MuK5OPaSzX1l9vMedU7oMS7H3J51Kw9/XBqtNq8+5ZS1vWuT6pnEUOIJQhmN6a14SDiHxSRo8NYMzFU1PKgICgLJDQppB49oekhAZV5UmQYt+13miFz6t1y9tU9PHJtoeCn9fdvLHUqSKqwcr+Sp7r88hIeKI+zZvPQ8Femjt/fbjhBcOL0rqr/fb6/EsKtOABjFLLRRC0y3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAHqA8RfcJCi1m50oTqxQfeq1UDD2VeOAErduSLhyxc=;
 b=CE4Mh/lsMOkZC2PEOZWy1XOGFmUYD3sSBmSghFodw18G3CcnoNc7kM46FVhIjFgXWC2vFtRG4uDVLzhAmtdZHqBIauFdNqzRhvHxK/Jrp7tW/i4Gkcd4ewiijHc3xqeHGvDuQDpithuis9wwdnG7Rezm0IOiCbsG0q+A+swZhSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BN6PR12MB1411.namprd12.prod.outlook.com (2603:10b6:404:1f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 18:19:02 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52%9]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 18:19:02 +0000
Message-ID: <9a20b1b5-7b37-d4ee-0f5e-911e94f0b82d@amd.com>
Date: Thu, 3 Feb 2022 13:18:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2] drm/amd/display: Handle removed connector in
 early_unregister
Content-Language: en-US
To: Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 nicholas.kazlauskas@amd.com, wayne.lin@amd.com
References: <20220203181708.473871-1-Jerry.Zuo@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220203181708.473871-1-Jerry.Zuo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::12) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b6b663d-a72a-4f1b-8eb3-08d9e741a7a1
X-MS-TrafficTypeDiagnostic: BN6PR12MB1411:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB14110A9F704E0754CCE2A9AD8C289@BN6PR12MB1411.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0hBb1YOOdcDpwgFcELjGLotQo5EOrDWJQunEtDWaPVXr8ENziWq2A1u72gEYZIiO4CcjYRIsi/s7h/s4HgLYjC+9U+bUGMAl1E60gYjACMr91wySCg7ZxXa0E/PTxC6rIfmCinFprdc0Eg3U//V7zFi94oh6FyR3m/byN2mjDjCGnSvx0+Mig2Jz0ljt+3zJLEGZBUc2m5bid0hTa8e+qsYCvKKRtKiYnzAEBk8/igcd5RLrpIIxAwuEaBXeXdAZ+e+K1ymOggFmZq8xe/yZTrGTdcAFGwvCQpF8jFsBxxq/EudAgnRWt8iOJxUbJK/yddhEvlUr4rpW9AK/zSIbfwb8s+fkK/YJX0JE/mbU95tIPHMODP/itej6Yj44Eypo19Kvn5L6gxVrJmiRkClSd8PYUvA9DgvPP+CMFgQPP8gvgvvE9DCo+ql/KJzhiqEy/dVlUFuou3NXKHVcDBH8VRuY44UZaSQ/rG/HLk5m8QA5PBQEWFRgqVK6z/UUQJDU5g4ppAeFyRJCaadV72ZVakttFTLN+w7RUdDJTU5FGNY29fbr+k1u5RT4LO4oKxkNlbtDeOZqEHL/yl3yGTAK8NoykSC1QPwJfPUDozvgf1rY1pe39KSFvHTljtAZDtorO+xQtthLNL+HiFuTIHP/18cfDLVl8h37xvZ54iod5i9wK6VVRe0El0nlgU8T1m716jeC68ucg6LsO/sGE7mSTpGuS2pX1h4lngKOOHa4jj7yv2EUg2nqUbWk4EXyZqEQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(2906002)(86362001)(31696002)(38100700002)(44832011)(26005)(186003)(2616005)(83380400001)(6666004)(8936002)(508600001)(53546011)(8676002)(31686004)(6506007)(6486002)(6512007)(66476007)(66556008)(66946007)(6636002)(316002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFNMOU5lU20wUlVGV2k0QkxET1dmZFhvNmt6Rk40ekcwbERLKzlYQ09SdStT?=
 =?utf-8?B?VFVHaDdwM093c2xEelUxc1RxcWZlbVlwVWVTL2dKYWdweFFjVTMxcnBnL3h0?=
 =?utf-8?B?STJEalA4ekVkcmFFRUdqZnhpS0puK05PeURHc1NaK0Z4TWk4d3ZYL255N29G?=
 =?utf-8?B?bWlDVXRlLzdCbFlHUi9LRXVCWWZBODJwQ0pldHgzT3EyUmZnMitMNG9zQWtu?=
 =?utf-8?B?dkw2bWFHMjdSajNjV0JzVHhHR0lLTXJxajU4OWZNR2p5NmFwU0ZLbk13WlNw?=
 =?utf-8?B?QUJnYUVBbUdsZlBiWTJMWWVJZ3pUbm5TRUtIZzVPTnlxRzAyRVVZcmg5ZjJQ?=
 =?utf-8?B?ZTVINm8xc2p3SVZYTHhkYzIyNWFCV0hBbmE0eGNEL3NNMHlBU3gwdlkrdEtT?=
 =?utf-8?B?dEdlaUdMS1RmTUpFdkJoWmlXVzNCRjdpRS9UM3ZTS2hCQTVzdndxWTRjMXdo?=
 =?utf-8?B?NnMwRWtEcjZyaTljMVRwK1VHVGkxWE9sdUlGODdhaG1lVUJLMmlCcnlZVzRQ?=
 =?utf-8?B?MkdaanRJNDNIRmg1QTkwN1FVUEx6SzZBcmFyMXcweWZUK2krTWJZM0NTL0xz?=
 =?utf-8?B?aS9TVWNybURhQlA0Sjk5K0hqZmh6bXdYVDNuNWgzMmdGNFVhVEJsSVBIRVFE?=
 =?utf-8?B?UUJhUmdpZmU5TDNRd2JVUUt0WDhORFRoWE9EcG0zeUtiWWRCcWNXZ2ZoYzlo?=
 =?utf-8?B?cWtwRmg1NEpUMWhLaTduT2VWMXhLTEc2ZCtSS09BdjR5OGJ4WWc3bDExbk1t?=
 =?utf-8?B?dC9HN0M5M2tkREtYN3p0OVN2VHd0R1MrRnNiR0x2SWRIdDlHMk1wYU1UOTVi?=
 =?utf-8?B?TFArU3Ixa0FTTVpyNTMrdTgrdlAzaHZzb0RYOVIwL2hicnVyK28wa2UyZW5F?=
 =?utf-8?B?VnFUNXV1UWg3ZTBuVkVvWUNseFFqckVZYitEMmxUeERBRzAxNTZVOVcveVdr?=
 =?utf-8?B?dGZkZWszNVZpNVNWZS91a05WTWliZzBnbXFya3hiUDBTWDNYb0VERHYyZStt?=
 =?utf-8?B?WnlzZmE2d2RBNWg3Yml2eUNOQWQrbDNmMFdUVTFxeCtzTHJPVlVJTkJva1BU?=
 =?utf-8?B?K2hZaVhVYkVFNXYrM1h6R0MzcDBtVjdjQTdHTmJXYXlPL0FaTTdsMXFXcmg2?=
 =?utf-8?B?Ky9rM3p1RDFHRmJ6ejJLVjlVQmkvbnY1N2p1ajFPK1ByZXEveE5jUkJkVDFE?=
 =?utf-8?B?QUZhMU1oNWFMdXNBbmhZcElDempFSUVwS1lHd2M1NlBIVzlRYWhHWThhSmpI?=
 =?utf-8?B?UlZsMm5CNTFHaUxoODJabGZMT2xSbE1vOVRlS0hHWFJya1BZQVVqTVZadWtG?=
 =?utf-8?B?WndXb24zVTNXaFhhYWE0cDNJSUMvQW84UHBLMzE4NithRlBSZnFYMmJ1SUg0?=
 =?utf-8?B?R3dHRmxNVHQ2QUxFV2YyYmtITHFyczBIWUJoZGdNQm1SNlJoL3RDWm82Sm5E?=
 =?utf-8?B?MzB1cGYxejNQeHAyT3FMM0ZFRmwyZWdmWm9KVlVpVU1VcFQ5RnN0Qi8yZE9W?=
 =?utf-8?B?cy81Y00za29YZGpQOFJsTHQ1dCs3QnNUU09aa3RHMmw0dkI2REZ0UHY1Y2VW?=
 =?utf-8?B?STkvT3N4TWdRQWlRK0NGWEs2dHQzaWx6cDJIN2tBSkV1Y3o0RnFKUU5oa3Qx?=
 =?utf-8?B?Zms5cHFUbCsyUklpY0dGVHFCcGtZRjZkSWo2bHFHY2FyOUNyL1F4V3hYR1Zo?=
 =?utf-8?B?Sjg3YWluSS8ydFB2cG96K29UNk9LMHhZSlZ3WFBCSkFxWEl1UjJ5Qy9sbjFB?=
 =?utf-8?B?eWkwVXlkd054RDh6bnVoempKb0h6N2JTWjIyRUFvMkl0RjJvZUI5N1JhbjV0?=
 =?utf-8?B?dS9tdHJmSGk4QUFlWVF1WWpiN013WmN0NGtyajBkMlBoOEZUN2plMmVTWnp2?=
 =?utf-8?B?Qkc4ZmpRSHVnNTBObk1OSFgrcHZmd2NtaHJKQlJiaGNtRmpGK0IwL0lYZ0hy?=
 =?utf-8?B?Q1NMcTBDcFhKK1dUSmVIV0xKZTNlNmFRSE5Xd1pTbHdDTTYwaTJuZEc0K2xt?=
 =?utf-8?B?cXZocC9MYmVlMlUxMFVKbTJ2eFRQeERxeE16MkEvMzBuRlVHWWNOWVp1Q3Mx?=
 =?utf-8?B?TU5YSndDOW5pYkkzRkFzUTc2SGRGWEFtUFBacmdNMEJ2eTMrck4zK0M5M2Uv?=
 =?utf-8?B?TDI2SlZBaWI3eVVNQ1M1Y0xJTjc1Vk9haUp2S0VEdnBDSEh0bkR0U3o2M2Nn?=
 =?utf-8?Q?zCO/MT5kO1q6nJ+LyyYG9e0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6b663d-a72a-4f1b-8eb3-08d9e741a7a1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 18:19:02.4346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6av/3bCab3ekSUZm8Klg226DKeurwDXR9kwWU6zRnYN+wClk6po4yiDDg1+65x9bw27wUv1Vpe+RiCqSFMN4sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1411
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

On 2022-02-03 13:17, Fangzhi Zuo wrote:
> From: Wayne Lin <Wayne.Lin@amd.com>
> 
> This patch lived in our internal branch since August
> but somehow missed the merge to upstream.
> 
> Original patch description:
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
> - Revise a bit the logic in above patches and change to turn DPMS
> off/clear dc remote sink within amdgpu_dm_mst_connector_early_unregister().
> Since drm will call .early_unregister for all disconnected connectors,
> we can ensure to also handle disconnected connectors reported by CSN.
> 
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

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
> index 8e97d21bdf5c..7cd1f1f57d6e 100644
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
> +		mutex_lock(&ddev->mode_config.mutex);
> +		mutex_lock(&adev->dm.dc_lock);
> +
> +		memset(&stream_update, 0, sizeof(stream_update));
> +		stream_update.dpms_off = &dpms_off;
> +
> +		/*set stream dpms_off*/
> +		stream_state = dc_stream_get_stream_by_sink(dc_sink);
> +		if (stream_state != NULL) {
> +				stream_update.stream = stream_state;
> +				dc_commit_updates_for_stream(stream_state->ctx->dc, NULL, 0,
> +										stream_state, &stream_update,
> +										stream_state->ctx->dc->current_state);
> +		}
> +
> +		/*clear the remote sink of the link*/
> +		dc_link_remove_remote_sink(dc_link, dc_sink);
> +		dc_sink_release(dc_sink);
> +		aconnector->dc_sink = NULL;
> +
> +		mutex_unlock(&adev->dm.dc_lock);
> +		mutex_unlock(&ddev->mode_config.mutex);
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

