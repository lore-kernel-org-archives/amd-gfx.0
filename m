Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792E2C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 17:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E5FA10E043;
	Wed, 17 May 2023 17:28:03 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D0C310E043
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 17:28:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZrV8SmD95lzZx0gXM1FBBj4EtdJ+Vd4lKXyWTj6cLY4Bo27C2XmQc7zVo1n1ChdwtSS35KC/tJklREE2gKx6fTzCKGsLqE01WTi23d7wZCzR32l6ZVp4P6d/xIRDPVhb455rVsbH77dFmzy3MYYBPvg9zMbE/Ua3Dk6lEn0e5TFDykv1cqtpnZqKYyFebd9SXZo6fWqWpiH+DrxDK3idcoZ83cmqXmQ3zX+JR5/+YfKLD+G3c6CFz8YhGxv6jIupFE75HHnZz1U6n8prxzBTCYMMbWGO9QOGRMUl6CXdB8dDxb2dE9Clh0sjKUVTPChSAOvd6McGUeKbJRJQlAcbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4zP69JtkDCxNCBxLtgoETBcevW3+YYDEQOuw06XpC4=;
 b=H08g9H5antVVoNxKvLIQ4cAJSY7e5Itn03CWB6CqRh5ZKYHrfQOAwv73s9sgdWxIAG2rN04gDhN73sacqTPls/ZW68XE6ppxNBDwQn+471RGXwcSk/77oTYV9eGqj6wU/5DXyH7JosABUpnpqXwWNUXKis5Cm/YHdyv/oCxcGsfYhGvi1A1UEAS2cDYgtTsEbZMbSOA+kbdmyJvYSSNEY8eP+nikIidI8GFf3SNUKN51gXb31od2EagpUcKWM7EYHxXOgSLK/hCuubxyqubkprHUw/WuvvlS6hlrAArGuX3UYWJnKtuYo4DkQPySHKSV/OA6gCSMX2oqbxhAnQhXRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4zP69JtkDCxNCBxLtgoETBcevW3+YYDEQOuw06XpC4=;
 b=vRen9+WnZpYo62+zeRQ3HBSufwwCuPyHWPIDQ/j8spJxi+hsBzugSF0l1h0zZO5nAu8eTpIAvYVsev7jBRoMts/ZmI3xdmWqV6YI2WsZN2dSwtsdylEw25+Y4R6yHGS2dlXYMH1NsPGO1kEjHny7L5yZoQElSNTdOepbseao7vs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 IA1PR12MB6386.namprd12.prod.outlook.com (2603:10b6:208:38a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 17:27:57 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b59e:105c:f546:4310]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b59e:105c:f546:4310%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 17:27:57 +0000
Message-ID: <1dd79cb8-2530-5cf9-c997-9e2e5e3b62cb@amd.com>
Date: Wed, 17 May 2023 13:27:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd/amdgpu: Fix warnings in amdgpu_encoders.c
Content-Language: en-CA, en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230517131132.2282628-1-srinivasan.shanmugam@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20230517131132.2282628-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::34) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|IA1PR12MB6386:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b63df6-1cac-4765-06c1-08db56fc0de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: itqnh75UJ97UbDAWHhvzdfje1+88+b8mUWRBUqMg8pO0RUfcmrhs/9uFcs645OP82G2Aea25RmFZ17lHiLS1tccN9D+/ua0hr7Ukbg1SAQ9hztVfXTi64lVfUDmFIP9U6XNZejKDyx4FsRj0JLTO8wiGU7ubjsjZw/jZWHyrFLtrjGw05oziZP5tE+C2mwSfKnUWphsrSZE9ReRdFlu5oqF9tBzCWd5oYGiJxqIHI72f7Pq0NAePZeNsI/WteEvk/zZ8FNYm2/Jq59YJBQlMaMAqDzvVPwKbo+rp48WqVJs7q7BujuCpBfa9YzXC2M+n/XtDv2rNMdIQNbHfTq19GruzJOFH9Oy+uOIvVW0y4Crn+zJ2YHXqijiFAuEGwyhe4f6STMTn42FAdB5VrY9daT41u0pq7mPKUB6m5esN7e+zbBY9XCGgh0tA3OuezjHiKLuDOjCZfQzPXMlkx3SVYOhSs8mHrxK0mbalJK7QAxBtnof+mLCHAVqoNnMLlfiIwo9qAt/RDXF3DxSYxEJXRehAPmJy84i917k++xOJorG801FQhFdD83PQ5RAVzdIxTMPAnb4XECHG0RF3SctGRDf/lDQi6HHPl4ihiWW8w80CWkxYg0coe5tnpGkhCnqN5PHuPh384ca3Hc8ntLcacA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(36756003)(4326008)(110136005)(316002)(86362001)(6636002)(478600001)(66946007)(66556008)(6486002)(66476007)(2616005)(44832011)(8676002)(2906002)(6666004)(8936002)(41300700001)(38100700002)(31696002)(5660300002)(6512007)(26005)(53546011)(186003)(6506007)(66574015)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGpKZGZiUklVZzB4ODFkUWZlcXhCZy9EdWhBRzZJUXJUVStyQVQrRnlXbW53?=
 =?utf-8?B?cXA5UWZlRENiUXpuMlNkMGxzUyt0WUt4NE1OYUhxdWxjU2hLV216bkR6WDhj?=
 =?utf-8?B?anpzQkJLcXE5ckZtTkRqSlVaUXNLRmhiLzlGN3Y0NXVOWEczYkI5VnNFZTJm?=
 =?utf-8?B?WUpCWkV6ZTkvRnhucCtVRlBtZEF1REVUbUVqVDdJUnVZR2pyRmYvbHRPa1Ni?=
 =?utf-8?B?QVRYcm5FTmhsZ1l6TmFOUTFxbEdtSWtVTjZ5bE5nT0lLZEJITThNSnlXWkc3?=
 =?utf-8?B?MzFZekE1TjBhb2xLVnBmNlpsdTh1bWhkVWtFazF3TG5yTForSmNJWEUrTDUz?=
 =?utf-8?B?RzZuYkx5bkV5ZDlOZVhxd1RuaXBIakZBVkhCNjlDQWNNOU9pQlhJdDI0TGI3?=
 =?utf-8?B?RXBzTU8xVFJxbmIyVmpNbGJDVFdSSzUrVVM5MDRQZGNBczR2QW9Uak5jaWly?=
 =?utf-8?B?akYxVTVycm9zRkc5K3kvYU5DUk9YdkVjSTIrWUQ5U29vRnEwbXR0bUg0ak5W?=
 =?utf-8?B?YXhtV2k2YThZU1dTM0gvZEhuYzREYUdzTXdCa0lvRTcwY3ZNR09raFBhelpF?=
 =?utf-8?B?Q3FPM3JCTkFrdUpQNCtjQ2xUK2JpMnVQRExFNVZmZVIyRUEvWjFiZ2dnbW1T?=
 =?utf-8?B?YnZqOS9UMW9xQVF1dGkxZkhVSDlnN0tzRlF1SUc0MzJOaGFrQlhPR2NuVTB2?=
 =?utf-8?B?bHFZdG9ZSHlOcFY3Tlo3c2RtcE1ENmRtYml0U0ZCVVR6eFc1S1VRZ0N5MDFw?=
 =?utf-8?B?UHBYc0l6d0hKOHNiQ1pSNEhwU0NvdjdZRzRRTzMybnJlZUJINDhDd3RJdjNn?=
 =?utf-8?B?a0lxR1J5OHVYclh5THdxOWwyYThXbHhNUFdrdmNOZ2VJQ3c3bGpDRjU3V0Jw?=
 =?utf-8?B?MGd5aUZTNXBrZDZNK3VqUXlrL2V5QnViOUdkWG44Q1J4MmF5WGdHQUE4UmJz?=
 =?utf-8?B?VjkzdjBodEhmdVFRRFdQYkZsVEtseFJXaEkyYlVzUko2V3Z5ZVgzK0pUQ2FX?=
 =?utf-8?B?YUh6QjZCNTFCQ0tST2VlM210c3FKQ2c5L2tvdVNqZmVJUDVjNml4Wk5ENmxV?=
 =?utf-8?B?U2Vaa1JkZE9aNHhlTm1VYnBhRkl6anh3UDVoR3hINnVIZzJxSTNHSFlzYTFM?=
 =?utf-8?B?c28zSGk3OUhwZ2pOdmZiaVZBOWc5bThMaHZ5L3NqeCszeUJYMHc2SFJFNE1s?=
 =?utf-8?B?VHpKU2VaVjBPMTFVdlJDZ2w2emsySHh4NlpVdlNlVVBpbE40Y0hTemRmaTNT?=
 =?utf-8?B?QTBBUFZXODg2SmthaUpCQWxYb1NuTVZ2ejVaSnNCWVpSd2c5RHNkSEVxSjhv?=
 =?utf-8?B?RE01VGIzL21CWU1tZHlSaHRjdTh6N2UrOVZvZ3RveTJrMmpKcWxEb3lhNGVQ?=
 =?utf-8?B?NGhwYkRyckJReUcybTVFM0pDVGQxaDJZK2s2d0FEZ0hQeGV5YldwYWlTc1JW?=
 =?utf-8?B?eVNscVNSN3ludkNVS21mNUVpUGZKT1pHT09Da2N5Y2xzQldsOFpKQ0U3YUd1?=
 =?utf-8?B?YUZaZkxPaTdhNmhja2g5TzZpR0FsMTBEaTl5OVNmQUxxb1R1TjBFdEY3M3pt?=
 =?utf-8?B?OVAyWTBSYVRLbTdCa1hXb1NlbDhyWXM1elN3OGRYZWx5bDNhU21TMit2cWlh?=
 =?utf-8?B?c2JtbXRDZUZibmozL3FnTTFOaENtUlQ5Z1RrWTQrUnI4T1RLL3NSK2RnVDMx?=
 =?utf-8?B?bzZvV0dMTUwvVkZBWTFOUmxyN2pZQVNhcXpsSTAvMnJWaVZVaVpGdUE2WlZT?=
 =?utf-8?B?bmdYZk9yQjd2WW1WVXlmdSsyZi9kQ2sycGovRkd0SHhEOTNMWDUzdDlkUEpm?=
 =?utf-8?B?WXlXS3o1TkRGVlRzZ0hpSlFyRjBPOStjMmx3L3JPbVpVVHRXYmllWVZlQytO?=
 =?utf-8?B?UWVBYXo3T1pzZlp4YWdxbmFaNmJ6dTNqeXBXZDY5VlJZSEx2NkVGUXY4SmVp?=
 =?utf-8?B?YURyQmN6YkVpMXBSK2hCK3RLSGFOYWxScVlrUytGU0JEZHVjY1luZ29Uckky?=
 =?utf-8?B?Qk02YlZ3cnF4Nkg3TGFKRURaZHFlV1Ywb01sdzk2b0JOTWNzWGxlbUNiSnA2?=
 =?utf-8?B?YUN3SXpYQ1pGeEs2dzFaanBYS1lYeFljanlXQW9YbFVwRHRBMExENms0Y3Ew?=
 =?utf-8?Q?G48s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b63df6-1cac-4765-06c1-08db56fc0de9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 17:27:57.0581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHx2e/YmwRXwiYuA5IZwI5KDuTENFVIf4P6QL4bDMlcb1z9fxR2GCjn1NPuLDbyy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6386
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2023-05-17 09:11, Srinivasan Shanmugam wrote:
> Fix below checkpatch warnings:
> 
> WARNING: Missing a blank line after declarations
> +                       struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
> +                       amdgpu_encoder->active_device = amdgpu_encoder->devices & amdgpu_connector->devices;
> 
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
> index c96e458ed088..93868ff01fb7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
> @@ -71,6 +71,7 @@ void amdgpu_encoder_set_active_device(struct drm_encoder *encoder)
>  	drm_for_each_connector_iter(connector, &iter) {
>  		if (connector->encoder == encoder) {
>  			struct amdgpu_connector *amdgpu_connector = to_amdgpu_connector(connector);
> +
>  			amdgpu_encoder->active_device = amdgpu_encoder->devices & amdgpu_connector->devices;
>  			DRM_DEBUG_KMS("setting active device to %08x from %08x %08x for encoder %d\n",
>  				  amdgpu_encoder->active_device, amdgpu_encoder->devices,
> @@ -166,12 +167,12 @@ void amdgpu_panel_mode_fixup(struct drm_encoder *encoder,
>  {
>  	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
>  	struct drm_display_mode *native_mode = &amdgpu_encoder->native_mode;
> -	unsigned hblank = native_mode->htotal - native_mode->hdisplay;
> -	unsigned vblank = native_mode->vtotal - native_mode->vdisplay;
> -	unsigned hover = native_mode->hsync_start - native_mode->hdisplay;
> -	unsigned vover = native_mode->vsync_start - native_mode->vdisplay;
> -	unsigned hsync_width = native_mode->hsync_end - native_mode->hsync_start;
> -	unsigned vsync_width = native_mode->vsync_end - native_mode->vsync_start;
> +	unsigned int hblank = native_mode->htotal - native_mode->hdisplay;
> +	unsigned int vblank = native_mode->vtotal - native_mode->vdisplay;
> +	unsigned int hover = native_mode->hsync_start - native_mode->hdisplay;
> +	unsigned int vover = native_mode->vsync_start - native_mode->vdisplay;
> +	unsigned int hsync_width = native_mode->hsync_end - native_mode->hsync_start;
> +	unsigned int vsync_width = native_mode->vsync_end - native_mode->vsync_start;
>  
>  	adjusted_mode->clock = native_mode->clock;
>  	adjusted_mode->flags = native_mode->flags;

