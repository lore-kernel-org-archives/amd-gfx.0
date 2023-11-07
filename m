Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD30DC4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Nov 2023 14:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34FA910E0C1;
	Tue,  7 Nov 2023 14:43:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 542F610E0C1
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Nov 2023 14:43:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZI9ivjanDOxAdDtAkf074zXEVe1QvsjDJwXet1hreg/SYR1UdYZW2D+fNs/NfOFstDiwh3Nwv6EcbuFOie/2xx8bfkDsSkfWiH0eww+Wo+niU3W1ClbdCuAds1iPLkIN6HBh3CgCSm+zzuJL1IKsbUbsIHHPfP8N5DfJfQ8y9VF6DbKZT5TWnLFE3x4HN0lvyE0Wu+Exje6FyyMEE2WbQUWp0NoMW0eI5mOYhjJjD5up1egITcCDxNZ9kkptDgg37smw2D2xOXsM1nkmBYcuhZXHLwE4X2dfK1kZooA3PpFe4/Fpbz5VrvksGgpa6XnoCoB2qb545Y7X2yW0/Lcm9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMH+lXB3tMPXSHwA3FiMrmk9Bdu50Cm+/Rrizbh3LFU=;
 b=PSiN1OzDLpLXZ22JLMOxxU31pPEJEu6D35KxEaup9WdU24VxK4+wabQfTJ64zDc7fRFUr6Frq9IRXB5GVmapy/5uKUupZbY50APfCyXdagQph5OtldqX7IxJvGrFhGMxdGILRJezXuloVcfKNs8oNpKqKFOYiH5ERqX9WMl5phyN4n6Efx8pp4XYt++9an4BY3M51oKYQjbrW2tlpGEcN1Q8d5NvzCcSdnRn3ZBphPMRbJRKwEtiImlqvSL/NjHPnpDI0MAs9LaUghWwaZQbHVpLPbvNiulSDpOj429F4K+7kY5yB0dZnw40FJnE++drSHpIBF5YNzPW/QE6RL+XSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMH+lXB3tMPXSHwA3FiMrmk9Bdu50Cm+/Rrizbh3LFU=;
 b=3Sqa/1nB3ZvKxDI2b/8iymGCPx4oy/JBzpHDVs7XU2u0D/hPJ7p7UXTkf+Npg5XdEpQIziaipNZ0rrdydCmTEZZGJ9bAdeJMD3Bf5fy6I9qprDp6InFJLYniAeYViF1szlCMq3+CzvE/CwkBE/onWqqHFS+6t3yFPSiyCZUjOZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by MW4PR12MB7312.namprd12.prod.outlook.com (2603:10b6:303:21a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Tue, 7 Nov
 2023 14:43:29 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::33ed:3162:e4ed:3569]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::33ed:3162:e4ed:3569%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 14:43:29 +0000
Message-ID: <375fe7b2-3de5-e95f-e8a1-7f7220dc1671@amd.com>
Date: Tue, 7 Nov 2023 09:43:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Refactor 'amdgpu_connector_dvi_detect' in
 amdgpu_connectors.c
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Pan Xinhui <Xinhui.Pan@amd.com>
References: <20230802021914.3093033-1-srinivasan.shanmugam@amd.com>
Content-Language: en-CA
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20230802021914.3093033-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0152.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::25) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|MW4PR12MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: a7914a91-2435-4ff5-f6c6-08dbdf9fe81c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jXuYaeEOx6WtCxccx18Gngfzrp3kOOIfR8mAc8FrmrEkIBJSEJudhW9MGKF1hb5UBBLx9WHyP1kgWsSQK9Hh49imuZEUrCQVWwI3yVQg1B9s0H4jmg6884qFPERYd6zLJTKYD2GvIqAoYkWSA8tmRbin/1geAl8ebc8dZN9c+7DfAgf/GdCQA7/vXf7Rl8d1+GlZfkDy3iaVmfqr8k2//2fNuXiJ8ANi/Pz8D9uk9DkeamsaCr+sqnvSiWQvfWhK9A5Lx9aPHpln6HVgS2XYSA6GGWLYa5dMVNclQzb2EtF3JmCB0DdRRjo6dCXWNgof5mcPnGI3EcaMk7eq3a+wQRpWTLCcvOvrqXJcVkcYyYpOGBwHB7jA02p/cp+P/OjCViEUNNC0JFaBeOg+Dvcl/wFbu0xkWh7mxQgObyxvuFIG3CGZaOQn76d6fIVXm9Hif1WmoW/UOL5iX2CP9w19zzdTa+DTREv5x2tUECGg0nmZYenN14wHNZVlBbV/S6xZy5thrOcoPm3t3jGJysxCvwmWAgERbt/jkS4NWpagAbqztQlogz6ubR8Aevq1Hmf5fPC57lQw2JCXAX0YkUSjQvl8XkuSo0hfaQvGy7jQjo7vHKfTgncj31fx2gCA0Im7K1UhRswTbB8tgnLbKyFZ+B4g6P6tPxhyqTj14GjaDaUnDptBIZ9wyVpEO0IQbQsv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(230273577357003)(230173577357003)(1800799009)(451199024)(186009)(64100799003)(2616005)(5660300002)(31686004)(26005)(66556008)(316002)(6486002)(6636002)(110136005)(66476007)(6512007)(6506007)(478600001)(6666004)(66946007)(53546011)(8936002)(83380400001)(8676002)(4326008)(36756003)(41300700001)(2906002)(31696002)(86362001)(44832011)(38100700002)(66574015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmlPVkxvQzFrTzFIU1FPYXl2ZVFzZkhaaGoyRmE1andWMy9OaURZOUhTZTdM?=
 =?utf-8?B?QzI2ZDd2a1MyODVNMW5TWHNKRFJTdC9DT0dPZnlDeXhNeFJzbXhTbkNERHdM?=
 =?utf-8?B?S0Q0WjVibkpVandnQ0FFZUNHb3h2ZE5zeUt4MlBFTEI0SlZQWXExaGwxVys1?=
 =?utf-8?B?SzdyYmdLU1FmQi9kZlhyZWZUZ2l3RnlHUVhiTk5SS3JLRWdwejRyMHdpUGs4?=
 =?utf-8?B?UEtWU2c1SlJVYnY1UDQ4NkQxZ1VOY0lXNEZxczR0V2tEVUF4RGdQdXA3cUdE?=
 =?utf-8?B?OFlDd3pabGJlOUpENEZTZFoyc3BYOE1HVk13MjlXcE81TjRuRlFBU3RTVnhL?=
 =?utf-8?B?d29NSUk3MW9Sc1lSZ25ORmlqRWRKUDdha2pDYVp3cE1IZUFyVWhtR1Zycnhr?=
 =?utf-8?B?dGZjKzdyNkxLeVlMN1NoUUZ2MEVWUnFmVkNlckVZenpjRWNVNWlCbmFHdmc1?=
 =?utf-8?B?cktXdExHOU53SklCTWR2Q0wwQUlwNlpYcjgwZTQ0QmNiVHVoVHNPeDE0SDdY?=
 =?utf-8?B?eEZRcUJHWVhCbmNjSkQ1V2VqSHRkbVN5SEJtNW5iS3BncmZuSWVERmtHV3RN?=
 =?utf-8?B?M2ovQ2RtWlFVU1V3QnhyN2FiUFc5R2pNMmRmUkd3ZXVWQXZCeDhoalljVkNi?=
 =?utf-8?B?emNCRXRnTVRWQnUxaVhzMmNnMThJNkZZTUl0RnJ1eml6UjZjRy93QldhYU84?=
 =?utf-8?B?TVBuU3ZoYlg4MXFGRXprWFVlZ3Y4K0VrY1RuTXhnbCtBd0xzNy9tcHNNM2Fj?=
 =?utf-8?B?NlBLS3oweXlyY2tFVElHR0dwSEVDU1BxL1h3bWIrQUg2MzVxYWxYOThoNG9j?=
 =?utf-8?B?TFAyeUc2Vml2MDM0bFNJNmVWRGJud0pNaHl5RkhMQUJXZjg1QkwrZmZXSXJ0?=
 =?utf-8?B?b21LR3FaYkRScFZYa3VyWDVrc2tWVkk4b0VJZlR2U1NJUWtjYlNiRFRFNUZa?=
 =?utf-8?B?RGVwNnZqbi9ZN3hmTDRURjY2bWRISHJSelRsQ0R2SS94QkxRZEdoeGZ5YlY2?=
 =?utf-8?B?aytMMkZGZzQrZnNyL3ZwV2pJcyt1YWs1WFdscDNPUkU1NncvTSt6blA5bmsz?=
 =?utf-8?B?YlEwd0ROeXczT2pKb2k0NnBJT2xPa21RdFo4TGFjNmppUmxtR0pMOWwrNVk3?=
 =?utf-8?B?bk12NlVGRnhTQWhTUEJlZ3JuYktFNEZzUjBERW4wbFJtNXFrQUVzV2dmM2t5?=
 =?utf-8?B?WnFtQUQ0MzA3eFkvTGh2WUhvK2dzbVc4czNMcS9kOVhidlIwQmhHM0FlUnpi?=
 =?utf-8?B?N0ZPaGs2WnUzeW84Wk5kaWYxS3RSSUlXajg5WVcwL2h6MTVmVHZKS1ZyZm1n?=
 =?utf-8?B?VUFXUEpDVFlaYnNmZS82ODVCWVM0bHVzSTRHbjdJU1BzMTZLcmMvUERTUE4y?=
 =?utf-8?B?Yjd4S29LWDJCNHQydjJrcVl4TWFqZ2tQUElQOTZ5d3RkTUswNkpNK01NQzN5?=
 =?utf-8?B?dHY0Rzh6VjQ0SEI4clZyZjFJSE1kck4ycHZ3R1dJUWVEa2hzeWwwQ3hnaXVD?=
 =?utf-8?B?bSsrb2VDK0pHd1pxT05BUVNDVUZGcVFadElSWDdHWWZoMXJSeXNsdDFPSFFV?=
 =?utf-8?B?WHY2Q2RTZHRDWTlzOWZCMG9hMGRRd08zeHcwWHBSdjI5TnV2bm9id2t5c05D?=
 =?utf-8?B?YmorNEhhV0pUNmM0TXNJdjdBUFJtRHYyRVV1TGRHRzN3QTZCSlJBQVlCdDZY?=
 =?utf-8?B?eGE1emdScGk1anlQNkwxV0QyYUJoSklNV2xJMzVWSGVudDRHM085a0lqS01y?=
 =?utf-8?B?Z08xR1pLR00yT0ZJVTljSDNsQWQzY0htOUlZMWlUckt5M1NpWnh5Tkw0Y2tl?=
 =?utf-8?B?M01JT0tCclQ4UnA4QlFyb3hrSzJpQTVTSGZqOWtxT0xFSUVLWnZnYXVIWFM3?=
 =?utf-8?B?S0xqUmhNWk01ZnozOFNUYS84QTR1c01yenBuS0xYSlJyb1BlUFJOZVQzMUZF?=
 =?utf-8?B?b2MybURseTBwYk1MbWJLcjBBT3JqQlJ2RzFEQnJGMlR6UDJJMG1OMTN1UUw2?=
 =?utf-8?B?cGZtejlXd3p0MjhRZ3I1M3dCYVFuOXNBa2JCUjZzenVQRnpqRGNqS2ZsN1Vz?=
 =?utf-8?B?MEdzTmFaWW8xTVRIYTZKa2lvZ3ZBS2M4NkFNZDkzUlFyNkJlOEZ2Z2NWcGpN?=
 =?utf-8?Q?exFL7H/xBw9aXy6fOXltq1Ydr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7914a91-2435-4ff5-f6c6-08dbdf9fe81c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 14:43:29.5400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tp3eG98wi2k+2DXjDVlMcGL3TJS69DfxZH1naIO38Ulo3ioCboGpuozbMlOsTjEkZ7wlMZlZGAMoLaN+qvrtig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7312
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
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/1/2023 10:19 PM, Srinivasan Shanmugam wrote:
> Fixes the below:
> 
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> WARNING: Missing a blank line after declarations
> WARNING: Too many leading tabs - consider code refactoring
> +                                               if (list_connector->connector_type != DRM_MODE_CONNECTOR_VGA) {
> WARNING: Too many leading tabs - consider code refactoring
> +                                                       if (!amdgpu_display_hpd_sense(adev, amdgpu_connector->hpd.hpd)) {
> 
> Cc: Guchun Chen <guchun.chen@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 69 +++++++++++--------
>   1 file changed, 42 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> index d34037b85cf8..173e836b00fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> @@ -103,7 +103,7 @@ int amdgpu_connector_get_monitor_bpc(struct drm_connector *connector)
>   	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
>   	struct amdgpu_connector_atom_dig *dig_connector;
>   	int bpc = 8;
> -	unsigned mode_clock, max_tmds_clock;
> +	unsigned int mode_clock, max_tmds_clock;
>   
>   	switch (connector->connector_type) {
>   	case DRM_MODE_CONNECTOR_DVII:
> @@ -255,6 +255,7 @@ struct edid *amdgpu_connector_edid(struct drm_connector *connector)
>   		return amdgpu_connector->edid;
>   	} else if (edid_blob) {
>   		struct edid *edid = kmemdup(edid_blob->data, edid_blob->length, GFP_KERNEL);
> +
>   		if (edid)
>   			amdgpu_connector->edid = edid;
>   	}
> @@ -588,6 +589,7 @@ static int amdgpu_connector_set_property(struct drm_connector *connector,
>   			amdgpu_encoder = to_amdgpu_encoder(connector->encoder);
>   		} else {
>   			const struct drm_connector_helper_funcs *connector_funcs = connector->helper_private;
> +
>   			amdgpu_encoder = to_amdgpu_encoder(connector_funcs->best_encoder(connector));
>   		}
>   
> @@ -804,6 +806,7 @@ static int amdgpu_connector_set_lcd_property(struct drm_connector *connector,
>   		amdgpu_encoder = to_amdgpu_encoder(connector->encoder);
>   	else {
>   		const struct drm_connector_helper_funcs *connector_funcs = connector->helper_private;
> +
>   		amdgpu_encoder = to_amdgpu_encoder(connector_funcs->best_encoder(connector));
>   	}
>   
> @@ -986,6 +989,41 @@ amdgpu_connector_check_hpd_status_unchanged(struct drm_connector *connector)
>   	return false;
>   }
>   
> +static void amdgpu_connector_shared_ddc(enum drm_connector_status *status,
> +					struct drm_connector *connector,
> +					struct amdgpu_connector *amdgpu_connector)
> +{
> +	struct drm_connector *list_connector;
> +	struct drm_connector_list_iter iter;
> +	struct amdgpu_connector *list_amdgpu_connector;
> +	struct drm_device *dev = connector->dev;
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +
> +	if (amdgpu_connector->shared_ddc && *status == connector_status_connected) {
> +		drm_connector_list_iter_begin(dev, &iter);
> +		drm_for_each_connector_iter(list_connector,
> +					    &iter) {

You could probably bring this part to the previous line, since the 80 
character limit is not enforced anymore.
> +			if (connector == list_connector)
> +				continue > +			list_amdgpu_connector = to_amdgpu_connector(list_connector);
> +			if (list_amdgpu_connector->shared_ddc &&
> +			    list_amdgpu_connector->ddc_bus->rec.i2c_id ==
> +			     amdgpu_connector->ddc_bus->rec.i2c_id) {
> +				/* cases where both connectors are digital */
> +				if (list_connector->connector_type != DRM_MODE_CONNECTOR_VGA) {
> +					/* hpd is our only option in this case */
> +					if (!amdgpu_display_hpd_sense(adev,
> +								      amdgpu_connector->hpd.hpd)) {
> +						amdgpu_connector_free_edid(connector);
> +						*status = connector_status_disconnected;
> +					}
> +				}
> +			}
> +		}
> +		drm_connector_list_iter_end(&iter);
> +	}
> +}
> +
>   /*
>    * DVI is complicated
>    * Do a DDC probe, if DDC probe passes, get the full EDID so
> @@ -1072,32 +1110,7 @@ amdgpu_connector_dvi_detect(struct drm_connector *connector, bool force)
>   			 * DDC line.  The latter is more complex because with DVI<->HDMI adapters
>   			 * you don't really know what's connected to which port as both are digital.
>   			 */
> -			if (amdgpu_connector->shared_ddc && (ret == connector_status_connected)) {
> -				struct drm_connector *list_connector;
> -				struct drm_connector_list_iter iter;
> -				struct amdgpu_connector *list_amdgpu_connector;
> -
> -				drm_connector_list_iter_begin(dev, &iter);
> -				drm_for_each_connector_iter(list_connector,
> -							    &iter) {
> -					if (connector == list_connector)
> -						continue;
> -					list_amdgpu_connector = to_amdgpu_connector(list_connector);
> -					if (list_amdgpu_connector->shared_ddc &&
> -					    (list_amdgpu_connector->ddc_bus->rec.i2c_id ==
> -					     amdgpu_connector->ddc_bus->rec.i2c_id)) {
> -						/* cases where both connectors are digital */
> -						if (list_connector->connector_type != DRM_MODE_CONNECTOR_VGA) {
> -							/* hpd is our only option in this case */
> -							if (!amdgpu_display_hpd_sense(adev, amdgpu_connector->hpd.hpd)) {
> -								amdgpu_connector_free_edid(connector);
> -								ret = connector_status_disconnected;
> -							}
> -						}
> -					}
> -				}
> -				drm_connector_list_iter_end(&iter);
> -			}
> +			 amdgpu_connector_shared_ddc(&ret, connector, amdgpu_connector);
>   		}
>   	}
>   
> @@ -1199,6 +1212,7 @@ amdgpu_connector_dvi_encoder(struct drm_connector *connector)
>   static void amdgpu_connector_dvi_force(struct drm_connector *connector)
>   {
>   	struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
> +
>   	if (connector->force == DRM_FORCE_ON)
>   		amdgpu_connector->use_digital = false;
>   	if (connector->force == DRM_FORCE_ON_DIGITAL)
> @@ -1433,6 +1447,7 @@ amdgpu_connector_dp_detect(struct drm_connector *connector, bool force)
>   				ret = connector_status_connected;
>   			else if (amdgpu_connector->dac_load_detect) { /* try load detection */
>   				const struct drm_encoder_helper_funcs *encoder_funcs = encoder->helper_private;
> +
>   				ret = encoder_funcs->detect(encoder, connector);
>   			}
>   		}

With or without the suggested change, the patch is

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
