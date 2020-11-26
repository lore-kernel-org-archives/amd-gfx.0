Return-Path: <SRS0=2cAG=FA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB0FC63777
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 22:00:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A856620BED
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 22:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vUx91oG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A856620BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F4936EACE;
	Thu, 26 Nov 2020 22:00:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1985A6EACE
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 22:00:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dbixewop5ay0bw+HEBu3D1A3jP6Xl2BGI9ekK89MH2XFq5FjJuZBpOsxbpAUau4YnvbwT6/jI187p9ljroi6TmJz/tlcdr0+HSVlAN/l2O9dxFyn2uNJMb+3N/zyF/IboHfoipK0vkitYJS8sbRnNaOMTs26UmH8hyCBU+pqPs+pzGyCexWHS4UsYKbGqdCte8pgteg4d0tf+s5HLvQOyXtqnV+asPD/A+DHLvwIvihAE78x4DCJQfbzPskR04hxnFY3I1Vz11aSXVdD77+mcNVDP1Ho4+HqHQnHwxO6Sa+EMZO5FsTqMBdG1EQNAJBzIO8ilW9Vm1fTPs+sL2QATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ze7q6iFGGCagTVoxm7wAzIQHX4105l7gv/tVzcgM564=;
 b=fMnWsyzIVT8mDVo/+CUT3Z+vpI2OXXri6tCVmmj6kQDgLOdbJF6l0HdZXIBtGuxS+fpyqjxpwcb/NaBDXpefvJG0AP1/2yTWGeJxu+IjMoc6VLxo7CRrp650ddhbA63EacPLcCLoy7cxJE16uXedSw5gxFKTKeemSOZvTSBdsYw78godfhUHO+zPv8jP+H3xkXwhVnzWWy5QtzMTm7bOR2Ajhw69gCigkSLh7nj8dLGWDn7ES9Up+CuBws2K5nbMS+CteyocvZGGqP8EvNaA3sBSBYNcJwrpsp4j0lApSy8M1Qn3FLjL3IaRjaXcQCLnJO+UyaAezB7IdlxFFxRY3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ze7q6iFGGCagTVoxm7wAzIQHX4105l7gv/tVzcgM564=;
 b=vUx91oG5xxCB/X6GAtaCBENnb/p+pFZD1fPT7xntocfN0BhD5YVET2e4jqkCRMNKWTajZnCh+6493RdIAWLqnXLZ+mSXEwD63cG3gkvxRM2ajS1swtzACkrKm9hjV6axvXPRV5B6TY/zgTQgcc7inbzNjyU65KqTDsReZO2zuCo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB2981.namprd12.prod.outlook.com (2603:10b6:a03:de::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.28; Thu, 26 Nov
 2020 22:00:25 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::805a:3c9e:fefa:a95e]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::805a:3c9e:fefa:a95e%7]) with mapi id 15.20.3589.028; Thu, 26 Nov 2020
 22:00:25 +0000
Subject: Re: [PATCH v2] drm/amd/display: turn DPMS off on mst connector unplug
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201126214559.170553-1-aurabindo.pillai@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <fb604583-9758-0ba7-27d9-1d06385f85a3@amd.com>
Date: Thu, 26 Nov 2020 17:00:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <20201126214559.170553-1-aurabindo.pillai@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: CH2PR14CA0058.namprd14.prod.outlook.com
 (2603:10b6:610:56::38) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 CH2PR14CA0058.namprd14.prod.outlook.com (2603:10b6:610:56::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20 via Frontend Transport; Thu, 26 Nov 2020 22:00:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 17bdf006-75d4-499b-0d8a-08d89256adb2
X-MS-TrafficTypeDiagnostic: BYAPR12MB2981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2981E6EC04AE10BCC895F67BECF90@BYAPR12MB2981.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWfJKk35qhR06+2RXVgoPI93+Zxq4pMErFIkwRE3kHnM3fIBna3ZuSfRaztIG4UmJQ1Y7snpQy1QiPDkxKgicGqmex+diFNTMQtaIlPA9p9tLiems6DNY/TW9f2isR2tXtRaS7jZ+cpGVn5ysIMEw1iT8lBjTkmzSW+WD/f9pqnWi/XrkESUewongvVyeWUomFWskR+b/atJ2prtW/G+bwQS04J3yO86rAMhfDbHCQWuF5bfxmzp+STPDpKDBtpFH3/QCyohvuyLxdaLFhe72o1l9upWYL2+xoLQ+u+4kZ8fiidudM973SarnRHiXWJKAien5btd51rnewPqHW5yKvP2sFggvxVvAMZqYaIuQ5xvHXw9FdGne+0fyj5TfIqd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(52116002)(53546011)(8676002)(4001150100001)(5660300002)(2906002)(31686004)(26005)(478600001)(8936002)(956004)(6666004)(31696002)(66556008)(2616005)(16526019)(4326008)(36756003)(16576012)(186003)(316002)(6486002)(66476007)(66946007)(86362001)(83380400001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WERmSHhNZmlvYndOR3RsNzRBbklDT0pqT1FzNFdUYXdULy9NWkgxVW1RdzBY?=
 =?utf-8?B?VDMwKzBqa2dhTHRPSVQ5eVd4RVJuRjMzVjRxK2xsVGpaSCtwNTlhNW9rNVUx?=
 =?utf-8?B?U0NCZjJSSTVPQlowT3Y2RnhKYlNROThvd0wyQlRKVENrcUFaZ0tIYmROclc4?=
 =?utf-8?B?WVFWbXRWVlRISldXcnE2RElCR2cxN29JeU0yOWovdk56cHF1TGovLzN0RHFw?=
 =?utf-8?B?TWxrUFJCTUhQclNyQTI4eXduTlVvaWR4L2lDU1FmQkNkcVhHQU91MFBTbGFw?=
 =?utf-8?B?cnM1VWVHRTNrM1N3UG5iWUhOZ3ZzSXA4WTl2N3JJSjF3d0xMSDd6Uk9oRGhB?=
 =?utf-8?B?S1YzNkNTZFJwV28yQTlFN3ZyOVFZakZoSzNpMjd4Vm0zc3pxQXRkdXA4bXVn?=
 =?utf-8?B?alZmRnkzdlNkdFJhSlNGcHM0cU5DMWFYN1h5OVVSd0E5VVByS0M5L2NwMmxs?=
 =?utf-8?B?RWN6cWFqaGtHRFN3VnpjV3JvcU1ia1NQM0lYQmgzZDdQRnpSOEtLSlVHWE9i?=
 =?utf-8?B?eTdIUlM0R01JYjBhUTdMMWdMbTBmVXRxVnlEOHk5anlyNFJoc3YxNmsvbU54?=
 =?utf-8?B?ejN5UE8vRFRrYUJGSHgwSDMwQldpQktBVVZkZng4eHQ0RFJSYk90akQxaGJB?=
 =?utf-8?B?NGI0WlhTUjROSzNGYkwxQzQ4aWhmbXAwRVRQdVBsTGhXWEZXcC91MXphQWMr?=
 =?utf-8?B?dXBLZEhLUFhhcHk2TCtZdU5odndRRTFNclk4U0FqUXZqa0ZDdklTc2JscFJN?=
 =?utf-8?B?cmZ4c0NZL0FCTXFzV3RKditFbWhKQWpsSUQvdXJpMnhwK0FBeUd6VjNrWjhX?=
 =?utf-8?B?eUVLa1FMSzg2M2psNk1LbGIrZGJjL0JzblBNZFY3VDF5SHRMSUtTM3Nlckhk?=
 =?utf-8?B?WUNHQTZqMzFNUkRocGZYQ2tJbmN0dERpSWpacmd2dDlBT0xQKzFiYmNSYmlq?=
 =?utf-8?B?SThCYzNFb2oxNUdCYVl3eVVnRysvSllmWVgvalJVdnE5Y1hpOTFISmRWanox?=
 =?utf-8?B?UmRKREZRbWJ6STVZV0FaWDI0SXVJYmdGUXlxNFJweGhPMXZ6NkpXSGsxd0d0?=
 =?utf-8?B?TVNUMGN6SUdxME1NZFQ2TUFTUGtNM3o3R2l5aUc4VmhraXIyVHNiM2xpcWZM?=
 =?utf-8?B?ZUFsblk4bkFrVllUbkhQREJMVE9aOFBFeG14YW50cytNcnQ0Ym9XbFFmZHpk?=
 =?utf-8?B?TXUzYWkyY01iTG43aEFPb0FvS1FqUFdOd01NbEFVWnBHdDZGL0kxc0FxV1hw?=
 =?utf-8?B?VWVia1pHMXJYdU13SmRCMU0vd2wvbXF6UkVvN3FVYUpIRWtxUktWUjFacFR2?=
 =?utf-8?Q?ififfcWc/q/O9xU4CKcaFay77jYrPKUL/l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17bdf006-75d4-499b-0d8a-08d89256adb2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 22:00:25.6082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2dn3ExlkACv4U0/9oCH8m1zz6nFk3Rccg5B/qPPIKeBba/PiFUvt5tLK5vowvxjz3X+yOnAC9EMLywqoRCe7CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2981
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

On 2020-11-26 4:45 p.m., Aurabindo Pillai wrote:
> [Why&How]
> 
> Set dpms off on the MST connector that was unplugged, for the side effect of
> releasing some references held through deallocation of mst payload.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Eryk Brol <eryk.brol@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 ++++++++++++++++++-
>   drivers/gpu/drm/amd/display/dc/core/dc.c      | 17 ++++++++++
>   drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 +
>   3 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e213246e3f04..6203cbf3ee33 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1984,6 +1984,34 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
>   	return;
>   }
>   
> +static void dm_set_dpms_off(struct dc_link *link)
> +{
> +	struct dc_stream_state *stream_state;
> +	struct amdgpu_dm_connector *aconnector = link->priv;
> +	struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
> +	struct {
> +		struct dc_surface_update surface_updates[MAX_SURFACES];

Let's remove the bundle and drop the surface_updates here. A 
surface_count of 0 should be sufficient to guard against NULL 
surface_updates array.

> +		struct dc_stream_update stream_update;
> +	} bundle = {0};
> +	bool dpms_off = true;
> +
> +	bundle.stream_update.dpms_off = &dpms_off;
> +
> +	mutex_lock(&adev->dm.dc_lock);
> +	stream_state = dc_stream_find_from_link(link);
> +	mutex_unlock(&adev->dm.dc_lock);

This needs to be move under dc_commit_updates_for_stream(). It's not 
safe to call dc_commit_updates_for_stream while unlocked since it 
modifies global state.

> +
> +	if (stream_state == NULL) {
> +		dm_error("Error finding stream state associated with link!\n");
> +		return;
> +	}
> +
> +	bundle.stream_update.stream = stream_state;
> +	dc_commit_updates_for_stream(stream_state->ctx->dc, bundle.surface_updates, 0,
> +				     stream_state, &bundle.stream_update,
> +				     stream_state->ctx->dc->current_state);
> +}
> +
>   static int dm_resume(void *handle)
>   {
>   	struct amdgpu_device *adev = handle;
> @@ -2434,8 +2462,11 @@ static void handle_hpd_irq(void *param)
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
> index 903353389edb..7a2b2802faa2 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -2798,6 +2798,23 @@ struct dc_stream_state *dc_get_stream_at_index(struct dc *dc, uint8_t i)
>   	return NULL;
>   }
>   
> +struct dc_stream_state *dc_stream_find_from_link(const struct dc_link *link)
> +{
> +	uint8_t i;
> +	struct dc_context *ctx = link->ctx;
> +
> +	for (i = 0; i< MAX_PIPES; i++) {
> +		if (ctx->dc->current_state->streams[i] == NULL)
> +			continue;

Drop the NULL check above and change MAX_PIPES to 
dc->current_state->stream_count.

Regards,
Nicholas Kazlauskas

> +
> +		if (ctx->dc->current_state->streams[i]->link == link) {
> +			return ctx->dc->current_state->streams[i];
> +		}
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
