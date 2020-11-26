Return-Path: <SRS0=2cAG=FA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8E8C63777
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 20:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3006A20678
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 20:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ORqrFQmm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3006A20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9E796E997;
	Thu, 26 Nov 2020 20:11:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3EF56E997
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 20:11:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yp+Zd68h71nZESI5HFp+sl6cZK3Av3XfNC8wQx1s2RzHwmYu8gi4Jwz7QtCn6SoFIAVoXcyF2GSpyTsP8ixVDg18PrOKBb6Z1XRpFZU9uj/iX6X+KVEdWmuA+/93UY5Yuy9MF2cvFJjwOw6dra6gyrXdrCfvwTILyG2rLBn6fXcuqcGW5y/+hicZX40HJXNbLeG334T4+iNcWnOVEnM4NZblz+/O6z6a71wPREjo1Gjow1r/73lQ+vIsMNqamZ/SfvqUZeUOQYD7MqpgFi2VPIQ+57waZtzoqmaihSxi6TrLRxfisXckTKMEunoyQ2jGkpc84ts22i3qSENvnElbRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1kRl7kUqT6Sx+3xcQvMCjFJrNaaHVfC+SUlr3mpZY4=;
 b=RiAEzIbI5eOLJrCWMEVn6Pxm15ufcYs7lat8nUXZKqH61/gjoYMGLsZ86CtGObFYimIXLrkm9TeaY7cLlkbFZ2FS9R6fmVsdKRAXiWc79yeszWb0grb6ai9f45q9zsP+ouDb6hu7wWrFV6Vg4wfa8kyJmIhUe+6c+1WMbthO8qOBqLI41MfovONKoUkAZ2WmswhePjsEfWN9xK1+tATltdk0yNCmmdLxxtn/45XmyPk+hDQ4p2WWFPp5YqZrZhDNZONQzIYggpZTrt8UXqPsf3e0dPYZNKezKCNCsQNsJgdBqMT0Z1wr8SJzpeU/3K7xAbi3MYuYy4acG0SJurAvFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1kRl7kUqT6Sx+3xcQvMCjFJrNaaHVfC+SUlr3mpZY4=;
 b=ORqrFQmmGVlfmDT4fibuAwwr6h0VxkS06KNkpQStfQQNAWTrjSbYqcMcAo+aIpVj0lubzjv8DRnLHTR38BLZDl29K4jkJsKdkkdZk3ANS5IxDTIgaBuQkLybcM17tHlI7eLxYS9krApShvz7gri79f+x1yw1XsFPCbYVUSeZSoc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Thu, 26 Nov
 2020 20:11:21 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::805a:3c9e:fefa:a95e]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::805a:3c9e:fefa:a95e%7]) with mapi id 15.20.3589.028; Thu, 26 Nov 2020
 20:11:21 +0000
Subject: Re: [PATCH] drm/amd/display: turn DPMS off on mst connector unplug
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201126195036.310979-1-aurabindo.pillai@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <6c21448a-11ee-3b14-b72f-d56f7ac09d2e@amd.com>
Date: Thu, 26 Nov 2020 15:11:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <20201126195036.310979-1-aurabindo.pillai@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: CH2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:610:20::29) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 CH2PR07CA0016.namprd07.prod.outlook.com (2603:10b6:610:20::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20 via Frontend Transport; Thu, 26 Nov 2020 20:11:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb000c26-4e84-4bbb-4156-08d892477103
X-MS-TrafficTypeDiagnostic: BY5PR12MB4885:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB48850A6D183E7AD62CD0C7FCECF90@BY5PR12MB4885.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mlZTIJsaFYN/cGm2ZX8mQgqGX8hnw023bOGJGq6+jV+S+VsxooRbxneil20D/8vVH0JtYHCRAxLnzlHy1K4/OPExTulbe0rCM4oOSVFqk5ZDrbdd6htFoFUZwcL7fno+y/z6RiwAZ39dvMeooe+BLOaM6golOKs5GctKo6coG/AfF0/4J4RAN5Cc92nbf0RhgA/X2moMP9S++LXnAcaiSQpCLCQmsXple4Qx1ADx0RhJzy9vtVwk7Lawo3ITKlVVQ82rXPE8AN7iMRUYZd7TshZbF2TjCLeLxA2aGOMNaLqxWV1xHKnmuQyj5DTclXvXSkMMrWal2ivm1h0LyKKc+XfP917PhQ1By4zQJHRpmNuPHmhdBX71dt8KJQktjyZz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(52116002)(4001150100001)(8676002)(26005)(86362001)(5660300002)(6486002)(2616005)(2906002)(16526019)(31696002)(956004)(66556008)(66476007)(66946007)(36756003)(31686004)(478600001)(8936002)(316002)(16576012)(4326008)(83380400001)(53546011)(186003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VEh5MXR1N3JZV1pUWFBOaDh5WEhNWmpwa0dyL0FPUWt4Y21mUFJqZGNKa1Ru?=
 =?utf-8?B?dEtUVERuUW4wUHZUOEIwNlY1d3lpTEtyYVdQbU1SK1lkaFd1cmVTTFptNzd0?=
 =?utf-8?B?ZTVPRjJXTDh3Vi9LVFRYdEtYOTEvRVBqSjBHZk0zbWxQNXBzTTNsa0hkb25q?=
 =?utf-8?B?SW82dnJCSk5sTFQ4Q2lQbFptR0RPanVVUEl0WGRnem9lc3JjOFlCTVlYZi9n?=
 =?utf-8?B?Ulh1anFxd2kxQzU1T1h4MDQ5alZmcVh5RDArYmtzbFEzSFo2NjBTQ0NkTnVX?=
 =?utf-8?B?WjhxcUs4eUpmekIwUUN3ZndNcVpyWUdCelRuNmNyMXMwbjIyNUw3WEZmV3Rw?=
 =?utf-8?B?OFVleDBFbDhaZmVFamlmdlV6N3d5eTBWazlLT0J5ZUt0VUFYT0YrT1lrVnVk?=
 =?utf-8?B?Qk9Rb25MTnpXRVNrbGgwTkJKWWZLVVlFVkdzK1RyS255alkwRFMzbENiYzlD?=
 =?utf-8?B?MkJldUhXM2x5L0Q0YlVXTDAwRC9qSFQvVEhSV0JpNEs0K2pVMUtndUV6U3hB?=
 =?utf-8?B?QkptSUlaZlN2cHNiOHlLaFVpUUxpOUVrRE5RRzc5SmVBSmdrcFdYMDA2SjRt?=
 =?utf-8?B?a0crZ080ZUV3YUVVSnhQbU5UUFZWZmg2R3ErMENneE4veUFuZmRVdGZ6Wjk5?=
 =?utf-8?B?WndxRHNnK3VnUWh3Q0xGUEpNV0l6OVJGdXdLVyswWWpwVkJ5OCtCUkV3V0Nr?=
 =?utf-8?B?YjlXV1pCalJhWEhnT0o2T3JPeGZ4WFRIYitHRU91Zi9wVytiREdRbHVlQlhZ?=
 =?utf-8?B?aUxLTzlZSm1CNHMwbHpGV3ZWeCt3YllmaW1UVGpLaWZob2VGSWtJYW1jNWF0?=
 =?utf-8?B?VUtKU3ByZTc3Z3VKQUdReGsxNHZaQTRDalprQXNJVEc2ZGd2MVl6dnE0VjND?=
 =?utf-8?B?cm4rQ3JzQTBZOGdDbDVxaEw3WlhWaVM1WElLVXd3Y0VXRmhGSmxHeGpDdDIx?=
 =?utf-8?B?QVU0MmVOb29JRGtOdXArUTduZk95dDY0eThKSkxMY3B5OS9DSzNralI0RnNR?=
 =?utf-8?B?WkpHQUJNbXQ3NDNwVkVHbnZmcEtWZklqS0dsa0ZORENtcmdvekpUcm8xY2da?=
 =?utf-8?B?Qk1XQlR4anRodjRzWm9PN2laR2JzcDRCbERUSFJYTlEyclZ1N1VsdXZ4Qzgv?=
 =?utf-8?B?OEgxNG1JNkxJbzJiUENuSmlaZ1pRV2ZNSGVUdVJvZ1pnSjBOSXl0WUtkUmNZ?=
 =?utf-8?B?RXJtQlFVZVArMzUyQmJKNnI4VUcwVHk0alVWcEtuMjBRU29mSnY0cWxyM2Jw?=
 =?utf-8?B?L1FSOTJNcDN4WUlVMkhGa3FxV0c1bnk3Z3ZrS0NzQlNnMG5CUk5ZNjJYNU9L?=
 =?utf-8?Q?2hx8ZI67pc+dkUkcHdglS8gd4G/2xidh48?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb000c26-4e84-4bbb-4156-08d892477103
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 20:11:21.1206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWH5/nfRdeo1a9h+10l5D94CqFuhJHnHZbOFvaVYWrXzfX8zzeEVnYJ6YloNmqZ7gewZM8t9RiMH150VK/eFmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4885
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

On 2020-11-26 2:50 p.m., Aurabindo Pillai wrote:
> [Why&How]
> 
> Set dpms off on the MST connector that was unplugged, for the side effect of
> releasing some references held through deallocation of mst payload.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Eryk Brol <eryk.brol@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 63 ++++++++++++++++++-
>   1 file changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e213246e3f04..fc984cf6e316 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1984,6 +1984,64 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
>   	return;
>   }
>   
> +static void dm_set_dpms_off(struct dc_link *link)
> +{
> +	struct {
> +		struct dc_surface_update surface_updates[MAX_SURFACES];
> +		struct dc_stream_update stream_update;
> +	} * bundle;
> +	struct dc_stream_state *stream_state;
> +	struct dc_context *dc_ctx = link->ctx;
> +	int i;
> +
> +	bundle = kzalloc(sizeof(*bundle), GFP_KERNEL);
> +
> +	if (!bundle) {
> +		dm_error("Failed to allocate update bundle\n");
> +		return;
> +	}
> +
> +	bundle->stream_update.dpms_off = kzalloc(sizeof(bool), GFP_KERNEL);

You don't need to allocate memory for the bool. You can just use a local 
here, DC doesn't need it after the call ends.

I think the same should apply to the surface updates as well. I'm not 
entirely sure how much stack the bundle takes up for a single stream 
here but it should be small enough that we can leave it on the stack.

> +
> +	if (!bundle->stream_update.dpms_off) {
> +		dm_error("Failed to allocate update bundle\n");
> +		goto cleanup;
> +	}
> +
> +	*bundle->stream_update.dpms_off = true;
> +
> +	for (i = 0; i< MAX_PIPES; i++) {
> +		if (dc_ctx->dc->current_state->streams[i] == NULL)
> +			continue;
> +
> +		if (dc_ctx->dc->current_state->streams[i]->link == link) {
> +			stream_state = dc_ctx->dc->current_state->streams[i];
> +			goto link_found;
> +		}
> +	}

We shouldn't be reading from dc->current_state directly in DM, it's 
essentially private state.

I think we should actually have a new helper here in dc_stream.h that's 
like:

struct dc_stream_state *dc_stream_find_from_link(const struct dc_link 
*link);

to replace this block of code.

Note that any time we touch current_state we also need to be locking - 
it looks like this function is missing the appropriate calls to:

mutex_lock(&adev->dm.dc_lock);
mutex_unlock(&adev->dm.dc_lock);

Regards,
Nicholas Kazlauskas


> +
> +	dm_error("Cannot find link associated with the stream to be disabled\n");
> +	return;
> +
> +link_found:
> +	if (stream_state == NULL) {
> +		dm_error("Stream state associated with the link is NULL\n");
> +		return;
> +	}
> +
> +	bundle->stream_update.stream = stream_state;
> +
> +	dc_commit_updates_for_stream(stream_state->ctx->dc, bundle->surface_updates, 0,
> +				     stream_state, &bundle->stream_update,
> +				     stream_state->ctx->dc->current_state);
> +
> +	kfree(bundle->stream_update.dpms_off);
> +cleanup:
> +	kfree(bundle);
> +
> +	return;
> +}
> +
>   static int dm_resume(void *handle)
>   {
>   	struct amdgpu_device *adev = handle;
> @@ -2434,8 +2492,11 @@ static void handle_hpd_irq(void *param)
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
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
