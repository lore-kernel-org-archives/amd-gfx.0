Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF21C2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 15:44:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FC1920B80
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 15:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="A5fGliCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC1920B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5C596EE49;
	Fri, 27 Nov 2020 15:44:54 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0262A6EE43
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2020 15:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvFoVDS0T0TVdX1IxA5oOMczjn2Fw0Uq7Tiok0i6qYoCtDjDBOJW6xQ+iekUvWPPdVwX+de3zRMvgxq81K/GzMfq0/Mql0gqkb1H2U+0uCuUAIgw1ycVRY99vnRXOdw74+3bSZde+TYCkgMZMgyYboAOjS+77uUKfgauU34b1lEmzehtIdmlGS1WXnmLoR4mfF8rh+cYpil7wxlMM+lAdxAFaPxBpnO6k5DAVHgxBT29WIRLpU8ugpBKtMrs7Qv+4cPLmMbn7f1JSkmRPjctNKqXNrkf6g52A8KifQJ3D509wuleaWekiHl3fYdVbaI0x+KyQE9fOMGhn6j/wmr6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4Qtb5wxUUemdT2dryG8YUUzBnUCVCwzcxahMX7uh/M=;
 b=P4rPZN+qcPnHigMmdlY6k/tXajqRO7IfAsYWZymTzWEScMxq2jiHjZPwtxXg74mW4cjGX1r4WXempq9iUgxsWztSvRtCX9HnGtOJjjXG06G7em32po4t/W0zbfU+Cw6r85qgaqlwBw+ZRuSdhApZxOAymPN83ttGVECzXQslE6bLkHCdnX6OMrPljA1m62aIJneHuxiNWKxOhdI6HqxnjdH38WHPdPFzCsuhHNYUfVebSzto2juhEfLVkwax3HEHk1t+bctx8a3Gv05Ub+nXdZsFybzAInwpVsRy2L32X+4e8UTkox/yelWESybN5F21hNKV/2d1HrrcLpdmTpMHkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4Qtb5wxUUemdT2dryG8YUUzBnUCVCwzcxahMX7uh/M=;
 b=A5fGliCKoi2O+0AP8cFPW2wHr7J4kH2P5nUIceacUibor7sGque+qQrYiTV3cBJoUoNjGdVbv3I2pAjGt4oyhDeALRY1Ao3K/sOeGEggITahwiUym3568YP2KFxQlQvh6JM78ZMXrg2mhO/Bqzhf2SbFkZOG+0WR+m5X7vZYGv0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB2919.namprd12.prod.outlook.com (2603:10b6:a03:12c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Fri, 27 Nov
 2020 15:44:51 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::805a:3c9e:fefa:a95e]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::805a:3c9e:fefa:a95e%7]) with mapi id 15.20.3589.028; Fri, 27 Nov 2020
 15:44:51 +0000
Subject: Re: [PATCH v3] drm/amd/display: turn DPMS off on mst connector unplug
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201127001844.367041-1-aurabindo.pillai@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <a4c1f5b2-5e1e-fcd6-ca1d-a906c38b51e7@amd.com>
Date: Fri, 27 Nov 2020 10:44:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <20201127001844.367041-1-aurabindo.pillai@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: CH2PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:610:58::19) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 CH2PR20CA0009.namprd20.prod.outlook.com (2603:10b6:610:58::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20 via Frontend Transport; Fri, 27 Nov 2020 15:44:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5a72b01c-f6e0-49fd-4d40-08d892eb6071
X-MS-TrafficTypeDiagnostic: BYAPR12MB2919:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB29199AF2F7D5AE34D1696719ECF80@BYAPR12MB2919.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F0esaomgR3+hJw4R3Ls+3AoIKgSKuqFCFAC3CnCR/0GCU5W6zkwbgR232Ye9NoQLENSlz/cZ+gIg1jOPnebGytjbOXMjh1J4n268M1Jaf3ALtJ0bYWtwZvq67AxYCRc1I2awbBJpOzth/L2NxoZvf3X6as/yQIWaiPaWScwtmKye/xQeQlSwXv7ImJ+kyLTTsug487smzUGIh2E3RXAfcTLeHHsHHwgGvo43WuqF7nkVCLmEaBtAOOYjl6GhWcSEioQAW4bDeqjc7+u03BWn/NdHbtT4yfM9RNfsDipUwCiYsuKSFlXiugbuRkax/MPYK4zCBYUkZt6i0WiYsXMeapZGMGe5/MzPVzsBNPTqHwA87QPhX/l5Hi0TRidIZs+I
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(956004)(16576012)(31686004)(8676002)(2616005)(316002)(478600001)(66476007)(6486002)(66946007)(2906002)(83380400001)(66556008)(36756003)(26005)(186003)(5660300002)(86362001)(4001150100001)(4326008)(16526019)(6666004)(8936002)(31696002)(53546011)(52116002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y1pGYWpDYUY3RU95eU5GS2VjU3l5a2JBejV3ZUl1cmVzMitLam5nYzh4eExh?=
 =?utf-8?B?MFRoc1VKZWhPb3NQQm9QczBYN3RTUWdnN0tBY3VrZmNGVDl2SXVINzFtclVI?=
 =?utf-8?B?MG5QRWltcWZpd24yaEV1U1A1amwyRzVWWjNqRFNzSGRIa2Yyb05qM3lPZFlD?=
 =?utf-8?B?S1VDT1djOWFoYjNFUEVCTkdyZ2N4UWNqMUVDVmZWTlhZVmtjVDZIcm1DbDJh?=
 =?utf-8?B?WW91MXdGNlordFY3Rm9vSWR2MnhES1JtOVNEUUdIR3hiQjVLSFlHV0xVekFk?=
 =?utf-8?B?cHZiKzcrem9oZHhITjlFOHRvd1JwUHRLcmk2VGhoMW5iaG1NYmZCNnFHd0Jk?=
 =?utf-8?B?OWdLQ2kwcHdvRUh4endjbytXN2RFRkx0YlpZKy9wRS9XQjNDMFVzZzlBeXE0?=
 =?utf-8?B?UjdtaGRWTzBTbmcwQ2ZOVHlHd0JTRCtvRGwrSWNraVZUWlAxakFoRGZhUklG?=
 =?utf-8?B?aldiMzExNU5QTDE3RFMxUG12b082VTdCb1l4bjBQUkhpUXpRSGthcU9GYVBJ?=
 =?utf-8?B?bEtZNXhiRzRUdlpIdDVHUlNoYmJwTVVMY3hPSHY2WFFsY1FhKzdGRElTd1lk?=
 =?utf-8?B?YWFWZkM0MWcydFBQK1ZyWGhLM1VyU0R3eEJ4V0dIcnRxdHpXTnFCRWhSY3l3?=
 =?utf-8?B?bW8zc0dxQ3Z0Vm5VZmdyUGdEUHY4TWlxaTNCd1NsSmRVck8xUVJVU1B5Q2NJ?=
 =?utf-8?B?Sks0T1JCdDNmM0JncnFiWWJ0ZTZqa0NlNVRNU3hRdW5CNHRibEJzd3NYdUU0?=
 =?utf-8?B?dkZzV2t4akRHZklvSGVVVlh2cEROVkJPREI2Tk5xcjA5eFVnTVBOQno5elYy?=
 =?utf-8?B?Zm9pRGRCZDIvTStvek5NUWllbml6TjY4M1FMdWYyMUs4RnozYkNhMHh3MjFS?=
 =?utf-8?B?WHhKeHZLZStGRVcyOXI5RjZ1MG94MnVNSmtaaDZSTWZsRDVyNnBhN0Z4MzVO?=
 =?utf-8?B?T285UDVRVHNhdnVDY3lWQ3VIdHhmdGsrQ0c3V1Y0aWFJVlNSY2M1UjFSRGhJ?=
 =?utf-8?B?RHF1cGZseXRZZ1A0cFhiS3dwd2dZK29zbllreTBiVnVIS2ZYNWZxSEkvQmZR?=
 =?utf-8?B?dENPZFpNSkZFOUoyVjNxQ3VUeHl4dDBmTFlEVmdwZkdBZHBWWjZacGdQakgv?=
 =?utf-8?B?eTlnbWZKbUp6dWVrWDNQRE5waDdyaTU3b1lMd3VybFRWWWdkejFrS1lKRitl?=
 =?utf-8?B?MHBGWjlxSFB3cUYvUG9yckxxZ2tLdC93d1E4ZzBaM2dmaFhtNHpJclprdWdF?=
 =?utf-8?B?VitBVVkzYXBEYVlXT0p3R0xBSWx5S3ZGUGNLNkdNMFlyUCtlTEp6ejJNR0RW?=
 =?utf-8?Q?yZTJcxhQO2TUg9+Dc75WzctCsYIqmxtQrT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a72b01c-f6e0-49fd-4d40-08d892eb6071
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 15:44:50.9151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSoNJGGHCj6oVBISTZ8uszIiZdBAJNBuUEqIboBDXKGno2LW4qeknQo3GlQWO4vobq/92O9jJZINfrOmhH267A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2919
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
Cc: Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com, Eryk.Brol@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-11-26 7:18 p.m., Aurabindo Pillai wrote:
> [Why&How]
> 
> Set dpms off on the MST connector that was unplugged, for the side effect of
> releasing some references held through deallocation of mst payload.

Applies to non-MST now too, so the description and title should be updated.

> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Eryk Brol <eryk.brol@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 ++++++++++++++++++-
>   drivers/gpu/drm/amd/display/dc/core/dc.c      | 13 ++++++++
>   drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 +
>   3 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e213246e3f04..9966679d29e7 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1984,6 +1984,32 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
>   	return;
>   }
>   
> +static void dm_set_dpms_off(struct dc_link *link)
> +{
> +	struct dc_stream_state *stream_state;
> +	struct amdgpu_dm_connector *aconnector = link->priv;
> +	struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
> +	struct dc_stream_update stream_update = {0};

Please use a memset instead of a zero initializer here. Some compilers 
complain about that.

> +	bool dpms_off = true;
> +
> +	stream_update.dpms_off = &dpms_off;
> +
> +	mutex_lock(&adev->dm.dc_lock);
> +	stream_state = dc_stream_find_from_link(link);
> +
> +	if (stream_state == NULL) {
> +		dm_error("Error finding stream state associated with link!\n");

This shouldn't be using a dm_error print here. a DRM_DEBUG_DRIVER would 
be better suited.

With these three items fixed the v4 of this patch will be:

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> +		mutex_unlock(&adev->dm.dc_lock);
> +		return;
> +	}
> +
> +	stream_update.stream = stream_state;
> +	dc_commit_updates_for_stream(stream_state->ctx->dc, NULL, 0,
> +				     stream_state, &stream_update,
> +				     stream_state->ctx->dc->current_state);
> +	mutex_unlock(&adev->dm.dc_lock);
> +}
> +
>   static int dm_resume(void *handle)
>   {
>   	struct amdgpu_device *adev = handle;
> @@ -2434,8 +2460,11 @@ static void handle_hpd_irq(void *param)
>   			drm_kms_helper_hotplug_event(dev);
>   
>   	} else if (dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD)) {
> -		amdgpu_dm_update_connector_after_detect(aconnector);
> +		if (new_connection_type == dc_connection_none &&
> +		    aconnector->dc_link->type == dc_connection_none)
> +			dm_set_dpms_off(aconnector->dc_link);
>   
> +		amdgpu_dm_update_connector_after_detect(aconnector);
>   
>   		drm_modeset_lock_all(dev);
>   		dm_restore_drm_connector_state(dev, connector);
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 903353389edb..58eb0d69873a 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -2798,6 +2798,19 @@ struct dc_stream_state *dc_get_stream_at_index(struct dc *dc, uint8_t i)
>   	return NULL;
>   }
>   
> +struct dc_stream_state *dc_stream_find_from_link(const struct dc_link *link)
> +{
> +	uint8_t i;
> +	struct dc_context *ctx = link->ctx;
> +
> +	for (i = 0; i < ctx->dc->current_state->stream_count; i++) {
> +		if (ctx->dc->current_state->streams[i]->link == link)
> +			return ctx->dc->current_state->streams[i];
> +	}
> +
> +	return NULL;
> +}
> +
>   enum dc_irq_source dc_interrupt_to_irq_source(
>   		struct dc *dc,
>   		uint32_t src_id,
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> index bf090afc2f70..b7910976b81a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> @@ -292,6 +292,7 @@ void dc_stream_log(const struct dc *dc, const struct dc_stream_state *stream);
>   
>   uint8_t dc_get_current_stream_count(struct dc *dc);
>   struct dc_stream_state *dc_get_stream_at_index(struct dc *dc, uint8_t i);
> +struct dc_stream_state *dc_stream_find_from_link(const struct dc_link *link);
>   
>   /*
>    * Return the current frame counter.
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
