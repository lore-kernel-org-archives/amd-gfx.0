Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47172C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 15:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F36CA611CA
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 15:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F36CA611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C4856E42A;
	Tue,  5 Oct 2021 15:50:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30F676E42A
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 15:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgQ3Y06uNEtRvONkyKJt9TpkAW6krJ7uFoBpCoOZQkqiLmPiBLyfNti4KeYnbCkyaBzgSH2MlQbbUst7mjtA9mOEeCxcvklDqtmQQyDYsUtkgwmZTb/FvMRXBm647Eq/MveNGCOjTDQ/RBc4VS6baLS9S38jhbxEjeCPEguFZcpzjMbVSolZsaAeeU/YYDZYdmRYS3o59tXGUDZFkbo/DfiN4vtd+U6F90iJNf4dUQa5zpiCxmemD1srCBB7gP9GCqFfZMHdFGV+NU2hS2LgkwA/E2H5Qlz2lzIoU6DeYHX5ux6Z2R/pY3d99zyqVRJ8Dz2nDMCraeB4z3lca3pJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STp/Q2ux7jEr2jniajHODSTcnwh0F27vZRmw2nhdrhk=;
 b=Od14bc6GaY9uzgyMN1KmT7wDcFhHEGNNt0e1IPN/iK0/n8tqFyCsID5odm4HyvCq2jO61AsF0kxB3uFc76G990Scso3cRvb0H+Pm8ZRiOiiZlyFjsbIDoAejslIfI3DzwqoRyymkqJk30rMqCdR4ubwz+VUydxqL4z0cRiqyc1vJ74wugBHxfk4Yhfy96N14itnZig3mjcKuN9QGJNYoTo5AJywOKdNVKslNA6bZBiQExMOFalb6KDJd+3lgliFV0bJF4r1eCEJg5gYXEnEVEat8UkNIxWInBUskXoZfYhle9SfOdQQ7QvxrUvile/p2Cvl9iyQ6Xe0w88HktgkBSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STp/Q2ux7jEr2jniajHODSTcnwh0F27vZRmw2nhdrhk=;
 b=5qPIpI6aK1hRNXHjkgBdrvQSLYQOzUXTnwsri7lckxGety/OEGYfcLvBEXKPoawvnq6Dv1ZPkD84W6QV6ALUEDvOouFW3o8/ZIPPMty5C7tRIBaX6JtOCISmlqIY2RgbAnttzPEYgt+N1zLhIytjYNkggZndMeCEevP1y4J3ftc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5443.namprd12.prod.outlook.com (2603:10b6:303:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 15:50:23 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%8]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 15:50:23 +0000
Message-ID: <ea0779cb-16bf-1ed5-7d68-820924e1e492@amd.com>
Date: Tue, 5 Oct 2021 11:50:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 05/23] drm/amd/display: Support USB4 for display
 endpoint control path.
Content-Language: en-US
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, nicholas.kazlauskas@amd.com,
 Rodrigo.Siqueira@amd.com, stylon.wang@amd.com, jude.shih@amd.com,
 jimmy.kizito@amd.com, meenakshikumar.somasundaram@amd.com,
 Jun Lei <Jun.Lei@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
 <20211005075205.3467938-6-Wayne.Lin@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211005075205.3467938-6-Wayne.Lin@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN6PR1701CA0007.namprd17.prod.outlook.com
 (2603:10b6:405:15::17) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [10.254.46.98] (165.204.84.11) by
 BN6PR1701CA0007.namprd17.prod.outlook.com (2603:10b6:405:15::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.20 via Frontend
 Transport; Tue, 5 Oct 2021 15:50:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 765397a1-9483-4932-6046-08d98817d7a7
X-MS-TrafficTypeDiagnostic: CO6PR12MB5443:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB544311FF98A48C8543133C238CAF9@CO6PR12MB5443.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XsTC0B/4PU5nSMq8JSRmvRDMqZeE0JeNTt4Q2B0sLlFfODvAmi4NNaQtWEo9YzAmdIWrJ7V0JWIxWjs3EUZpyG3QUV3F8cMmE5Rk6/GcMR3OcZLNvBELDfv2XfnY3hdtu0GS8UDuWVnVRE/acNpoeXbiOxr8rAmqW7i3NnL5Z7eb3d0kwXNLwlv9qrbyPX9OpOg5sZPjMXwR1ScT4e5HF5OuKLKDzYsM7hM0s9Lj9drp5X5d+Kr2O1VqU5ESmXwko7pgxNa5vGHkscV8WhmF9G/SG6mHuVl97Zep85h7CrLz1L6CuTL5rvxStf4glzkeJh4dVaHJYusRK2MxYEFaTgN4LZs7owJj2iV9FQ2Bwki4+QweVFdDYyQtZFB/hzXyXuxUTvUSdK5NkKGHVV3hRd/MawU6pWJO4TM4UXyJAju5j5c6XZxY4QJU8C7xlzykOte8rM0+Dk3u5u1JCy8YR2NOs0u+WmyYFvFEFdzDsO9F0LY3X8hXwuc/JBmGrjBJsS5CIDYezxKzz5gd4wuptPxNqcRP6lFs8eJ7xpfC8R8/r1jxxXyFFT7umGsjq8Ce0nNp0teyhM5weO7ezdLemCsIMAOCUTtu55Wshp0OOqkKJZKlHZMwvDM+JJ86DIBH9HZQN8KiMGh3R1OPpOrDogOClXqXZEIYITRre8rg0Agd8rehorisBotgJ63k43P4j9NSoI4GJ0E/xERFbhPlmO8FOShPYxeovyoMyHfFiErgre7Hr8egyGiq4TG4S9Ig
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(6486002)(956004)(186003)(6666004)(2616005)(26005)(2906002)(83380400001)(66946007)(5660300002)(44832011)(31696002)(86362001)(38100700002)(4326008)(36756003)(66556008)(8936002)(8676002)(66476007)(30864003)(316002)(16576012)(53546011)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDB0eHVzR2J5dnRYUkxOd0puQTJlSTZTbWhJQ3NjLzhwSFdrMUZ5SHZFTmda?=
 =?utf-8?B?dWRjK1p3U0VXT3IvT3BucTJ0NjhCWjVMNmt5UVlxb3lCVGRjVXkreTVxQ0xi?=
 =?utf-8?B?eGk0b05lUmNuNm1rUmVLcG9TVU9HbUFxb2NzUUxFWXFsaE5leU41VnhwTjBp?=
 =?utf-8?B?VEtEZHFTbnA4SVhuS05ONmtMZzJHWTF4UmJtek9xR3RqTUxPK2tkUE81LzY0?=
 =?utf-8?B?bks2eXRaS21OMzBHK09ydkhpZnpROXNMeVplbHo1dHRLYjl0TW52K0xTTVE0?=
 =?utf-8?B?YVZZUDFGc05ydnlXc3JvRXlYZFJLVGpJZnRpQnNNNk9mYitLeXd3V2hoVFFD?=
 =?utf-8?B?cG14T1J3ekp3T3ZCUzMrcWdxMjZXeUlHdnlZZDM2TDVrNTZxVGtkNXh3Ylh3?=
 =?utf-8?B?ek1yYmJpV1FoOS9oZ3JjK04vUDlWeTY0aDBwVVQ5WXlMUjJaSkc0TzE4Yk1S?=
 =?utf-8?B?clZwOStCMC9SU20yeTBIN1RuVmgyRTBlU1hROGNHeDZHbFFmSFd0MmgzcHJW?=
 =?utf-8?B?NnNLV01YbUg0ZFRjOHYwN1N4TGRmaGpFYUdTc2tOUmg5RzBaY1ZXNVNmRTVZ?=
 =?utf-8?B?dUxobm5ZaHdqTVlHSlgrM05NWHBaRWFLNklySXBDOVBkVHhBZ3BhV2NxNS8y?=
 =?utf-8?B?c2xlNmxEdFF1eGxBalk3ZVY3UWhpZ0d2VHZaZ1BWSVM5ZzJ4djJlSVRUWGNn?=
 =?utf-8?B?cHdpbU44MEhJdk5Cenc5SUsxVVh0WmpjbFlhWWZGdzViWCsxRU5KbU9ISU12?=
 =?utf-8?B?N09TUkpmbzhDbDlkK2xYQU95cHNTVGMwQkVYeUpCcit1QnBZbGZHcjFaOXF1?=
 =?utf-8?B?c3RwWllBeHlOOExPRDVxMWVTWTB0dzdiajVRWmsvamZDbzN5dVJ5NWxXN3NE?=
 =?utf-8?B?eGVwejlPcFBlcURYSmJmbHh1UHZveFlwT0ZaS29MSjNMS0dZbDNmRzNCajV4?=
 =?utf-8?B?TXNQWWlLQ2JscDRUTHVwbzJnZnpDZ1FrdkJ2UC9DUVZYMXdjN3Z3ZTFETEpZ?=
 =?utf-8?B?UlZoL3NkYjZBcldXcXhoak9kY2xaaUtZRDhLV1c5ZEI3OXVrQVhwSjVxTTU0?=
 =?utf-8?B?Y2VHOGVQVjREdnR2WEozaTA0TXJCNXNpT1lwZWltNXhSUFZVMm9VRDV5M2Mw?=
 =?utf-8?B?NEthV3dIQzBHWm1zVjhPR2JVUStIdTZXUEpjYXQ1RmVhRTZwRVZEN0NTbGRq?=
 =?utf-8?B?WkNOTmZFUEdYUnpKV1JZVjVqNjY5dHZaMVAySElxZ3hhY080dDUvY2JCMlRC?=
 =?utf-8?B?cFVDeXJScmJkUURFRkFUTHpvdkJHOWRORGxVdVRVb0ltM2IyUVNyOHMrWFpE?=
 =?utf-8?B?cktpYklGeDZkenNraldNWHpuN1MvS0xvcEo0dFB5blJ3T01wT3h6ZjkwQ1RC?=
 =?utf-8?B?WjQxZjhGVElMZjNBaVQzY25tTXdaUS9rczBUalRTVWhYSno0TTN4TXRJZzlS?=
 =?utf-8?B?R2FNY2FQd2hCZnZPakNIYTNHK0NqOGcrYVZTOVN2K1ZlWW5WTDlRUG8vWDRU?=
 =?utf-8?B?RTFiS0J1Nnk0a0E3RWxBQ3Y4Y05jMUJnQk45bkY1bEt1ZzhHTVgraDBkenNz?=
 =?utf-8?B?ZDhMRFFwQXlVMjNqN09YYmFRZVFwT0NjY0ZNdzY1ZW5jZ2hOMkh5RjNMbEgv?=
 =?utf-8?B?ZDhRb2NuRTZNSWVlZkdDZlNXL1FTUzIxVW9RbnlMd1NPYngrU0VoUTU5c3ht?=
 =?utf-8?B?V3hTeitnWWRRME1mMVBXUXlCaTgvaStuZmd6OVlnbTRGUTczeWVxSnA1Nkg4?=
 =?utf-8?Q?HIR2mSeIQQZbKLkULjSk2l7ttZczn50EdPmsO3r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 765397a1-9483-4932-6046-08d98817d7a7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 15:50:23.6527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YeAIKQHc3+2IniIQ4Y5SDCQWX2+UI6ioeWi0KinS0MYzALmyO8u4yupXNeHDFX99HXuwlQ0r40728/JZ9F5vmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5443
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



On 2021-10-05 03:51, Wayne Lin wrote:
> From: Jimmy Kizito <Jimmy.Kizito@amd.com>
> 
> [why & how]
> Add codes for commit "79ed7354d70f drm/amd/display: Update
> display endpoint control path" to support USB4 DP tunneling
> feature.
> 

Suggested Title: "Stub out DPIA link training call"

Suggested Description:
"Add stub for DPIA link training and define new DPIA DMUB commands
to support it."

> Reviewed-by: Jun Lei <Jun.Lei@amd.com>
> Acked-by: Wayne Lin <Wayne.Lin@amd.com>
> Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
> ---
>  .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  30 ++++-
>  .../display/dc/dcn31/dcn31_dio_link_encoder.c | 118 +++++++++++++++++-
>  .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  41 ++++++
>  3 files changed, 182 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 649a9da338a7..4df71d728319 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -2312,6 +2312,23 @@ enum link_training_result dc_link_dp_perform_link_training(
>  	return status;
>  }
>  
> +/*
> + * Train DP tunneling link for USB4 DPIA display endpoint.
> + *
> + * DPIA equivalent of dc_link_dp_perfrorm_link_training.

/s/dc_link_dp_perfrorm_link_training/dc_link_dp_perform_link_training

Harry

> + */
> +enum link_training_result dc_link_dpia_perform_link_training(struct dc_link *link,
> +	const struct dc_link_settings *link_setting,
> +	bool skip_video_pattern)
> +{
> +	enum link_training_result status;
> +
> +	/** @todo Always fail until USB4 DPIA training implemented. */
> +	status = LINK_TRAINING_CR_FAIL_LANE0;
> +
> +	return status;
> +}
> +
>  bool perform_link_training_with_retries(
>  	const struct dc_link_settings *link_setting,
>  	bool skip_video_pattern,
> @@ -2383,10 +2400,15 @@ bool perform_link_training_with_retries(
>  			dc_link_dp_perform_link_training_skip_aux(link, &current_setting);
>  			return true;
>  		} else {
> -				status = dc_link_dp_perform_link_training(
> -										link,
> -										&current_setting,
> -										skip_video_pattern);
> +			if (link->is_dig_mapping_flexible)
> +				status = dc_link_dpia_perform_link_training(link,
> +									    link_setting,
> +									    skip_video_pattern);
> +			else
> +				status = dc_link_dp_perform_link_training(link,
> +									  &current_setting,
> +									  skip_video_pattern);
> +
>  			if (status == LINK_TRAINING_SUCCESS)
>  				return true;
>  		}
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
> index 616a48d72afa..f86d4446f347 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
> @@ -366,11 +366,44 @@ void dcn31_link_encoder_construct_minimal(
>  		SIGNAL_TYPE_EDP;
>  }
>  
> +/* DPIA equivalent of link_transmitter_control. */
> +static bool link_dpia_control(struct dc_context *dc_ctx,
> +	struct dmub_cmd_dig_dpia_control_data *dpia_control)
> +{
> +	union dmub_rb_cmd cmd;
> +	struct dc_dmub_srv *dmub = dc_ctx->dmub_srv;
> +
> +	memset(&cmd, 0, sizeof(cmd));
> +
> +	cmd.dig1_dpia_control.header.type = DMUB_CMD__DPIA;
> +	cmd.dig1_dpia_control.header.sub_type =
> +			DMUB_CMD__DPIA_DIG1_DPIA_CONTROL;
> +	cmd.dig1_dpia_control.header.payload_bytes =
> +		sizeof(cmd.dig1_dpia_control) -
> +		sizeof(cmd.dig1_dpia_control.header);
> +
> +	cmd.dig1_dpia_control.dpia_control = *dpia_control;
> +
> +	dc_dmub_srv_cmd_queue(dmub, &cmd);
> +	dc_dmub_srv_cmd_execute(dmub);
> +	dc_dmub_srv_wait_idle(dmub);
> +
> +	return false;
> +}
> +
> +static void link_encoder_disable(struct dcn10_link_encoder *enc10)
> +{
> +	/* reset training complete */
> +	REG_UPDATE(DP_LINK_CNTL, DP_LINK_TRAINING_COMPLETE, 0);
> +}
> +
>  void dcn31_link_encoder_enable_dp_output(
>  	struct link_encoder *enc,
>  	const struct dc_link_settings *link_settings,
>  	enum clock_source_id clock_source)
>  {
> +	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
> +
>  	/* Enable transmitter and encoder. */
>  	if (!link_enc_cfg_is_transmitter_mappable(enc->ctx->dc, enc)) {
>  
> @@ -378,7 +411,30 @@ void dcn31_link_encoder_enable_dp_output(
>  
>  	} else {
>  
> -		/** @todo Handle transmitter with programmable mapping to link encoder. */
> +		struct dmub_cmd_dig_dpia_control_data dpia_control = { 0 };
> +		struct dc_link *link;
> +
> +		link = link_enc_cfg_get_link_using_link_enc(enc->ctx->dc, enc->preferred_engine);
> +
> +		enc1_configure_encoder(enc10, link_settings);
> +
> +		dpia_control.action = (uint8_t)TRANSMITTER_CONTROL_ENABLE;
> +		dpia_control.enc_id = enc->preferred_engine;
> +		dpia_control.mode_laneset.digmode = 0; /* 0 for SST; 5 for MST */
> +		dpia_control.lanenum = (uint8_t)link_settings->lane_count;
> +		dpia_control.symclk_10khz = link_settings->link_rate *
> +				LINK_RATE_REF_FREQ_IN_KHZ / 10;
> +		dpia_control.hpdsel = 5; /* Unused by DPIA */
> +
> +		if (link) {
> +			dpia_control.dpia_id = link->ddc_hw_inst;
> +		} else {
> +			DC_LOG_ERROR("%s: Failed to execute DPIA enable DMUB command.\n", __func__);
> +			BREAK_TO_DEBUGGER();
> +			return;
> +		}
> +
> +		link_dpia_control(enc->ctx, &dpia_control);
>  	}
>  }
>  
> @@ -387,6 +443,8 @@ void dcn31_link_encoder_enable_dp_mst_output(
>  	const struct dc_link_settings *link_settings,
>  	enum clock_source_id clock_source)
>  {
> +	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
> +
>  	/* Enable transmitter and encoder. */
>  	if (!link_enc_cfg_is_transmitter_mappable(enc->ctx->dc, enc)) {
>  
> @@ -394,7 +452,30 @@ void dcn31_link_encoder_enable_dp_mst_output(
>  
>  	} else {
>  
> -		/** @todo Handle transmitter with programmable mapping to link encoder. */
> +		struct dmub_cmd_dig_dpia_control_data dpia_control = { 0 };
> +		struct dc_link *link;
> +
> +		link = link_enc_cfg_get_link_using_link_enc(enc->ctx->dc, enc->preferred_engine);
> +
> +		enc1_configure_encoder(enc10, link_settings);
> +
> +		dpia_control.action = (uint8_t)TRANSMITTER_CONTROL_ENABLE;
> +		dpia_control.enc_id = enc->preferred_engine;
> +		dpia_control.mode_laneset.digmode = 5; /* 0 for SST; 5 for MST */
> +		dpia_control.lanenum = (uint8_t)link_settings->lane_count;
> +		dpia_control.symclk_10khz = link_settings->link_rate *
> +				LINK_RATE_REF_FREQ_IN_KHZ / 10;
> +		dpia_control.hpdsel = 5; /* Unused by DPIA */
> +
> +		if (link) {
> +			dpia_control.dpia_id = link->ddc_hw_inst;
> +		} else {
> +			DC_LOG_ERROR("%s: Failed to execute DPIA enable DMUB command.\n", __func__);
> +			BREAK_TO_DEBUGGER();
> +			return;
> +		}
> +
> +		link_dpia_control(enc->ctx, &dpia_control);
>  	}
>  }
>  
> @@ -402,6 +483,8 @@ void dcn31_link_encoder_disable_output(
>  	struct link_encoder *enc,
>  	enum signal_type signal)
>  {
> +	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
> +
>  	/* Disable transmitter and encoder. */
>  	if (!link_enc_cfg_is_transmitter_mappable(enc->ctx->dc, enc)) {
>  
> @@ -409,7 +492,36 @@ void dcn31_link_encoder_disable_output(
>  
>  	} else {
>  
> -		/** @todo Handle transmitter with programmable mapping to link encoder. */
> +		struct dmub_cmd_dig_dpia_control_data dpia_control = { 0 };
> +		struct dc_link *link;
> +
> +		if (!dcn10_is_dig_enabled(enc))
> +			return;
> +
> +		link = link_enc_cfg_get_link_using_link_enc(enc->ctx->dc, enc->preferred_engine);
> +
> +		dpia_control.action = (uint8_t)TRANSMITTER_CONTROL_DISABLE;
> +		dpia_control.enc_id = enc->preferred_engine;
> +		if (signal == SIGNAL_TYPE_DISPLAY_PORT) {
> +			dpia_control.mode_laneset.digmode = 0; /* 0 for SST; 5 for MST */
> +		} else if (signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
> +			dpia_control.mode_laneset.digmode = 5; /* 0 for SST; 5 for MST */
> +		} else {
> +			DC_LOG_ERROR("%s: USB4 DPIA only supports DisplayPort.\n", __func__);
> +			BREAK_TO_DEBUGGER();
> +		}
> +
> +		if (link) {
> +			dpia_control.dpia_id = link->ddc_hw_inst;
> +		} else {
> +			DC_LOG_ERROR("%s: Failed to execute DPIA enable DMUB command.\n", __func__);
> +			BREAK_TO_DEBUGGER();
> +			return;
> +		}
> +
> +		link_dpia_control(enc->ctx, &dpia_control);
> +
> +		link_encoder_disable(enc10);
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> index a693b743f0d4..8461442b03a9 100644
> --- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> +++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> @@ -654,6 +654,10 @@ enum dmub_cmd_type {
>  	 * Command type used for all panel control commands.
>  	 */
>  	DMUB_CMD__PANEL_CNTL = 74,
> +	/**
> +	 * Command type used for interfacing with DPIA.
> +	 */
> +	DMUB_CMD__DPIA = 77,
>  	/**
>  	 * Command type used for EDID CEA parsing
>  	 */
> @@ -682,6 +686,11 @@ enum dmub_out_cmd_type {
>  	DMUB_OUT_CMD__DP_HPD_NOTIFY = 2,
>  };
>  
> +/* DMUB_CMD__DPIA command sub-types. */
> +enum dmub_cmd_dpia_type {
> +	DMUB_CMD__DPIA_DIG1_DPIA_CONTROL = 0,
> +};
> +
>  #pragma pack(push, 1)
>  
>  /**
> @@ -1001,6 +1010,34 @@ struct dmub_rb_cmd_dig1_transmitter_control {
>  	union dmub_cmd_dig1_transmitter_control_data transmitter_control; /**< payload */
>  };
>  
> +/**
> + * DPIA tunnel command parameters.
> + */
> +struct dmub_cmd_dig_dpia_control_data {
> +	uint8_t enc_id;         /** 0 = ENGINE_ID_DIGA, ... */
> +	uint8_t action;         /** ATOM_TRANSMITER_ACTION_DISABLE/ENABLE/SETUP_VSEMPH */
> +	union {
> +		uint8_t digmode;    /** enum atom_encode_mode_def */
> +		uint8_t dplaneset;  /** DP voltage swing and pre-emphasis value */
> +	} mode_laneset;
> +	uint8_t lanenum;        /** Lane number 1, 2, 4, 8 */
> +	uint32_t symclk_10khz;  /** Symbol Clock in 10Khz */
> +	uint8_t hpdsel;         /** =0: HPD is not assigned */
> +	uint8_t digfe_sel;      /** DIG stream( front-end ) selection, bit0 - DIG0 FE */
> +	uint8_t dpia_id;        /** Index of DPIA */
> +	uint8_t fec_rdy : 1;
> +	uint8_t reserved : 7;
> +	uint32_t reserved1;
> +};
> +
> +/**
> + * DMUB command for DPIA tunnel control.
> + */
> +struct dmub_rb_cmd_dig1_dpia_control {
> +	struct dmub_cmd_header header;
> +	struct dmub_cmd_dig_dpia_control_data dpia_control;
> +};
> +
>  /**
>   * struct dmub_rb_cmd_dpphy_init - DPPHY init.
>   */
> @@ -2442,6 +2479,10 @@ union dmub_rb_cmd {
>  	 * Definition of a DMUB_CMD__VBIOS_LVTMA_CONTROL command.
>  	 */
>  	struct dmub_rb_cmd_lvtma_control lvtma_control;
> +	/**
> +	 * Definition of a DMUB_CMD__DPIA_DIG1_CONTROL command.
> +	 */
> +	struct dmub_rb_cmd_dig1_dpia_control dig1_dpia_control;
>  	/**
>  	 * Definition of a DMUB_CMD__EDID_CEA command.
>  	 */
> 

