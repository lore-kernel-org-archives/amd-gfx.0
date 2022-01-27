Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53002C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 03:56:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECCE110EE0F;
	Thu, 27 Jan 2022 03:56:04 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2081.outbound.protection.outlook.com [40.107.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D600D10EE0F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 03:56:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nq+/BAzaCy95pNnMfMwyKM4vxVU7GRvmf9LbzmzLmwJ1Tc7HJ5fRVynN12ZDAbl23r0HY49PDxJWbizdwLyvvDggyOXRlw5S7Z6a+DprcONapSplSjXGtREe2akmAXvj1m4cnb2sKarpAbYMdyxSc1bULesp4LnqdjpsjGM6M89T07dtA2nbki6XYboaJUFNXyBzLyNNozwUKeGaWWCWp7+nmMECLL4HEnsUIP8tDPVO+AK+AjXxKXZVnymi+IvBD2Jc4j0Wkn/Lc1rKR1ZYBBmtjfDAdBiYQM77mnAZWuv/TIL0/L+v3kg07iel1MQ7JGc+0GbZl0oxwRTGQc709Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BP4LtDqvQNVXBo4giuy1aWPsdWZA8rnU699+9B4RUyA=;
 b=HBiiw8iiESDXvLUQHR1D49qcPN6aNxoX552M3/DScysxcAIPteA0oL3Pzi1/PjliBSgZnEAObYjnO8dRT1wETKuhl4VahU6bhmpJ1ngvuBY750exkMg6TOR1HjLdFSOf/4gqIEAUGwv5ReDxqCoda7OkEiA43ytTDFHh1NlNxIH9rI5ajZAIJNk8hyR2ImZgRRT+e3+16FNDnogFXSlRzIGEMwpSSCXVjCf5k38yA6/NPtnyVye01nhoP0VvRggFaAKzEV/2Y7jrfBG7kl8CyRy6mncwZkBBWzXvBfjA57OovfOqlVsXJ40s/q43JSswuaWDOuuuKQmq/B1kjlON/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BP4LtDqvQNVXBo4giuy1aWPsdWZA8rnU699+9B4RUyA=;
 b=3/gc0oRk/0iV1fCEBtNy33gOtww9exOmQthUBSL3PmTg2tpsGl6JRQWUjp5tV8AqB/E/usqmP+IT2+GX1PbkgnbkK/LNEJbcBfWVRhpC+YXAb5KIbFN/sw45rTXCBqDqUck+dpjp6mgxpvU8bVdORhkATQZbPlZ5KOfUuSGzhbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 MWHPR1201MB0255.namprd12.prod.outlook.com (2603:10b6:301:4f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 03:55:57 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::f02e:2cba:7c63:e368%4]) with mapi id 15.20.4909.017; Thu, 27 Jan 2022
 03:55:57 +0000
Date: Thu, 27 Jan 2022 11:55:37 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix unused variable warning
Message-ID: <YfIXuc/Pr3s77qyB@amd.com>
References: <20220127033350.2550086-1-tim.huang@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127033350.2550086-1-tim.huang@amd.com>
X-ClientProxiedBy: HK2PR0302CA0001.apcprd03.prod.outlook.com
 (2603:1096:202::11) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6bb5d90-18ed-4789-52a6-08d9e148eccd
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0255:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB02555C74DC2156A78E980CB4EC219@MWHPR1201MB0255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6XSu/GfMf9RWFtPgue3nU2adOAhP0bmuZcx5i8Q1V91Sj6oygq2bVQA+58gs9LPrR3EYJL874z+zGjkE5Qo0s2u5rRtqvPY0JK3oK7qLW9gxqcDPa9GDoWdWn4FNV4bI+1SRdzsAvbO/SdvquSp3hG8raX2MXZZwZB3C31PCGGFH01DFu6uavbI2z0KQ6bxvwVLikoTnMVgF2w/kyhrvf42dUzfW5sKezaFPHUeL3PLtSmt22/U45kc0aL/N6ZMdn7GLYLQhFDnSedOAueVLYGHSh5+07J15uLGCy7+DyMdh5O3h20EtJGNlD0f+GEoUjN1vmaR1TErV9z8x7PXAUU2YC4UITNKSuqI51gokOIm22+E/1EpU25DYCn9PxHT0Gfa5KTQrq+n/k2j61qOsQwcezI90Fwigfq038KMdOzmBe80w2l2T9NBod278p7taoeBuTJJQ2S+7K4usNnjb19zC2L6oxyI17alHMe/Hd3/j3Wq6uUDWFoGR1uGb71bT2idTQk0u2WNmNNNzdtLYUzpVA6pJ0bcQ4Cgl0YMtcEE5aRCmCIXYW8h6kGmMzCHKRT22bBK7sMlKUf7jBt59GoMB2HXTGjW78qLoamLszzfaaa8L6IPYXcCAobc539G0RGPeFNQuc7zc6xLWsR2+MA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6666004)(6512007)(6506007)(86362001)(2906002)(6862004)(4326008)(8676002)(38100700002)(5660300002)(8936002)(66556008)(37006003)(66476007)(36756003)(508600001)(83380400001)(54906003)(2616005)(66946007)(6486002)(6636002)(316002)(186003)(26005)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kc+AakVg+sODaZ9Vw5uI66MfY5IgEFSi3+OF4l/8yoFXPl+mYRYCCh4Ydbdn?=
 =?us-ascii?Q?qLO0PqNyIlw+IJIsFfgnQNJ/js4FmVtf/3kH159dtEJlL/dd65hP0itcZtMY?=
 =?us-ascii?Q?Sseasy/dlZLeMdjT+/f2zSC+mIDlRG9bPGFcrmpfsmEr+gk3rJJersN1grCT?=
 =?us-ascii?Q?bSzUGyqAAveDs58rlNaP7dI0N8ggcJBHsviiKTBAQieqkl9W30ZwO8Wc/4om?=
 =?us-ascii?Q?f2+40H/3HU5XwP/pqUwa7H+y/CkPlwQZV0dk99NyihmXw6ieLAzPQwPmwCnc?=
 =?us-ascii?Q?RkeCbybha2YupmR/ag9wYJGHD2UkLqMLu6UVeDWiO8H3fXafiuzX1hB51C5/?=
 =?us-ascii?Q?VQVVV0H/ZUb1wQwkOF0MIL7N3oQElJFwou38JI5tFIHPUvSSrbGEDIVj5lv1?=
 =?us-ascii?Q?s9B28OvxnC6qkWZzXhSxZJNYDhpM6tDdB3zB/UjE3Ysrjdk4MqiMI5U0ZJ9B?=
 =?us-ascii?Q?oq9DzyLi6gqFvAihn98o6oBmcQSzi57/HH9dcW+5hLIpPvkWqeja1UDm1IOI?=
 =?us-ascii?Q?UyfjKG7f58q2P25N5UYGqYQKZLcbCEInUYVDNzI+KrXr3YtS2Z/pMujNzyIi?=
 =?us-ascii?Q?Ga2rCOl8TsTuQcl6F17qe1HhXDQSiK8PvRF8kET1vIOHocrbRNyUGWzBwhdV?=
 =?us-ascii?Q?wp0tCsUgQUSFo+gJHyXoghFs9A86GQHflRL+f6af5sC9DDJQDkaeEz6Aekkx?=
 =?us-ascii?Q?gyYKnEtVTZEWIyUuGoaLP+BYpV1n495W5Xm7d7ka/qZo40BPHzFxKGzzAozo?=
 =?us-ascii?Q?U3gT4GPJUOHEzSJ55Ate1K5KqO7lXEnkEyFNxFSNN+uWcrOGj9xpXnQB7x3I?=
 =?us-ascii?Q?cv1gWybbsCJuRCa0ho1xcKBRoHIjdxRuL+PnHSAiGRUolGCa0Nc49YeqVKUM?=
 =?us-ascii?Q?YKrilwvauhNyvIlzs9JphVSK0Os2wOY8625KkyRFofCHNYaBvMGm6Mk37CAN?=
 =?us-ascii?Q?J3PYFo2JIVAMzKOw9Bgk2KIBbRDogFCTvROAT6W8TsBs2SkWQ3kFwUE7L5G/?=
 =?us-ascii?Q?zhFNlZ9USsY8A20bBhV+UxS7cIOJHMnf13laFWdijusVUJNIo/67uAma99ss?=
 =?us-ascii?Q?Pnias945c55Hxz2qOva74e6gG56MwjJspo5NxAZnLG0YmJegHa7Zbl2l6cGd?=
 =?us-ascii?Q?xFZyvKR/TIyoj5loUeWoJrLKWxkZ4tZL44seDdLUPsXWPSqbAq9gsl7R6wRV?=
 =?us-ascii?Q?5+CXXZ+AEp1v9nm7HLkzYxp+WV+qHGkgAPvHCynHXs0jYStYnFArxnSLjA+a?=
 =?us-ascii?Q?S1uViTyVEW+1c5r384NVNfPaYi8du7me/OvAof1wM2FzoAf4X3/3X7aPxUHM?=
 =?us-ascii?Q?Z0xpVVmTpXw70FpKUIbKA1hilDwXpQ92h9wondvrcktPMQkjr9RLN86vWr6i?=
 =?us-ascii?Q?Up2Fqx6aplBpOSGhwo04GnY7YE9v2RbQ77qp/hSTX1RKUsIxD+uX+zCxoCjK?=
 =?us-ascii?Q?5Hpg6l45d3w//i4gjoaDE3KNAQB9EsTdfjhsaBhtDU1FrB9KYjhIDwMMIVeJ?=
 =?us-ascii?Q?yaHrQRoYGHzU7ktH5SwCQPrb+WqD8NIf3RI89U9Vfmua7012ndteq4GBoViX?=
 =?us-ascii?Q?cY8MoVEJ0aoA5n2Dqn3RaSlimn9nc/SPWKHx/zJzFe6YeuAQgFZLJPV1EX1j?=
 =?us-ascii?Q?caqGQ5DBTIrEB34X+7rMAW8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bb5d90-18ed-4789-52a6-08d9e148eccd
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 03:55:57.7190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRJo+kcP63KN02/M5kRrj7bJonn9vpv931Y+kV4hNL3SpbkGc7Ft/EYcY7+IAQ9fZQExdMiL10DWUWu4KCQ07Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0255
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 27, 2022 at 11:33:50AM +0800, Huang, Tim wrote:
> [Why]
> It will build failed with unused variable 'dc' with
> '-Werror=unused-variable'enabled when CONFIG_DRM_AMD_DC_DCN
> is not defined.
> 
> Signed-off-by: Tim Huang <tim.huang@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1057f976bec7..8f53c9f6b267 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1027,7 +1027,6 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
>  	const unsigned char *fw_inst_const, *fw_bss_data;
>  	uint32_t i, fw_inst_const_size, fw_bss_data_size;
>  	bool has_hw_support;
> -	struct dc *dc = adev->dm.dc;
>  
>  	if (!dmub_srv)
>  		/* DMUB isn't supported on the ASIC. */
> @@ -1123,7 +1122,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
>  	case IP_VERSION(3, 1, 3): /* Only for this asic hw internal rev B0 */
>  		hw_params.dpia_supported = true;
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
> -		hw_params.disable_dpia = dc->debug.dpia_debug.bits.disable_dpia;
> +		hw_params.disable_dpia = adev->dm.dc->debug.dpia_debug.bits.disable_dpia;
>  #endif
>  		break;
>  	default:
> -- 
> 2.25.1
> 
