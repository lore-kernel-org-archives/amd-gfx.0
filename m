Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37981C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 20:17:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1459619C5
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 20:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1459619C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56AC66E0A5;
	Tue, 30 Mar 2021 20:17:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16E086E0A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 20:17:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPQOcccNQC5+j385HlaCnN5NXRLou0r9txksh7P8OeU6lcmL55a1Q4+RPDVrarmFCs41KOeYBsQwaybE9p9dmrNAqF0xXJhf73ewTC3aTTM5JgHn4zv/cMMARdXymRl/M7UdIDN3HW37DqHuYC/nYQlG9P57W/1QZEI2mNXJkDAHYNasnHrzeehamt9TPKibA4XaPR7sHSonS8UfRRQbIgT2da4mmBHbz21nWW21pKbIQ61OaXukqJN3LNSU4jx1c5DEOY0/r7f5gAUgxtUgGESi3tviQqC9SWDKBZRAAev1HtsEzl/pUi/p1XpeEY7gVZLRb79FkHgf15fkjsjwhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3jqWVnBTn0nBDUYsD4ADIL6FLUhRx2F2mP7fBpsAw0=;
 b=LXsRdON3jDmAMToFAIKVOGYd69ptYpj3n7kdjr5Puk+DrONY38U2gF4boWogHhyV8PLl0qzSa184gD3YqtcMvmgkPsG3o7MaHOOFMvv8eKWxnYZUpXRUXipKCTiKW0ZIyjnLdJsSQZWOhaLMPo1h0kAgMDh7aJbdxERiblEpBsmPxxgevfM7pReMqDS35dFo5/VStadRYEcf7cyEcvZr/lt1gl6b+sUDGDIVl6l1ZUatppk46OE2uAyqCHOAVW0eo76eKAd65ss9yArfQshZaIhRwtoUY3F4KsfNix/oAQSsyJ/HCP2/f9qEHLVJSFOUEoB7lT74glrDWLtzYe0YYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3jqWVnBTn0nBDUYsD4ADIL6FLUhRx2F2mP7fBpsAw0=;
 b=ifHUjrrYzRCOxWBhz6cppQgu1AAiEIG+4dx59JrF/BZ6z7qV6Hj1ZQYkMLEiqQyRhilmUIVgv01L9ksiBJTUfwm9rwYukM2doM39eHA2H5SoCBKyipBIh6uvMgq4QjEiBybb5Y04m4zUfk5FXyjaW25HohT9me2MJ5DDwKKLn4E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR1201MB0143.namprd12.prod.outlook.com (2603:10b6:301:54::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 20:17:50 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8%7]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 20:17:49 +0000
Subject: Re: [PATCH] drm/amd/display: Use pr_debug in DM to prevent dmesg
 flooding
To: Victor Lu <victorchengchi.lu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210330172232.986998-1-victorchengchi.lu@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <240a634a-760c-7336-e6ba-d08f7d156639@amd.com>
Date: Tue, 30 Mar 2021 16:17:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210330172232.986998-1-victorchengchi.lu@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YT1PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::21) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YT1PR01CA0142.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.32 via Frontend Transport; Tue, 30 Mar 2021 20:17:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7aeafe71-c9ff-4d7b-a96b-08d8f3b8e3dc
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0143:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB014343E43C51A6627BB7F8E38C7D9@MWHPR1201MB0143.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7KASj903/N1/l0nns20x0uQMMoipPRM721kbk+u+jtEBsDy6USmacUabIn9u7CGj6neeEMBWtRBYO4MVrBgR4+nNIdx8pQd3DkQ4JLkMl7IYXHT2GE2SbrTncxRDHR7fu6Um0iawWJQZ6BZslpUTSG0vLG4bZdEwU8w0Li/LwQtWn/NDQLT4QJM/SUuGMGqT3oaYJCwldadjQHShIxtENLvEOWmnSh0pBkAj9bgl55wV6gXfDn4k//5YW4SKGXCmeeWbcAbghaa6iGVRvVD4AT270LMBCqVkWDoifuakCS4dzx8jB33iDD3M/iD3mRWiZ3tb11Vsi4MPs4MUXZ29fxzXiz6p1xjPEDbGhA35DO1D1EF4YSNEk69w1FL5xqDFfyCpCb3bOkoRSECglxcEMqNEHej4VcyWFGg28/cGciNbTmnK4e5KbKxMQ0+hTqEJJbTb8Aed1QVKkciDWuqgAl+xt6xzBIAlKuoUg9bPa8jNiQ2mCHFHLUToETQ4ozM15s017K8VxIks3OzZs/WY/p9EtSXi8vTE4jHHbrckHYCsnM3ogxJAS5eBJWJujGbZyA+G590uMFL0NZoax7V2jfjuLBywAtmwtxINNqXsxUcg1FF7XSSlUuYAlTFP0HaCXf0hIfcL4rhH664AZ1HhRWdfKg8OItMnPpOBHZ3NC14KGbF65mB+WtTZutHjLLPnHrwKEBxyHruGuxim2jcZqX/ksxlyt4eIr1GPjBob/0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(6486002)(26005)(53546011)(16526019)(2616005)(956004)(8676002)(44832011)(83380400001)(86362001)(8936002)(478600001)(66556008)(66476007)(31686004)(5660300002)(38100700001)(16576012)(2906002)(316002)(36756003)(31696002)(66946007)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TFVUajlrV0hZK2FDZkNzV3F1bmltbFF0dnlydTVwQ3JaR3NCYkhpNkdscjBG?=
 =?utf-8?B?SWpMM0FqcE56NHNCZ0t3THN3c0U3dFdvdW5BQ2MyZzc1UElYbjdDOWhhSC8r?=
 =?utf-8?B?bFBXYSsvZFBsbjdHZXNFVktxNzl2VDh4VzQ2QnFIYXdTSE1CK0dsSWQ1Si9I?=
 =?utf-8?B?UytxS3pROVVObk5HZmJEdFdmell6WFV4dVMzamVEUkpjZkE0UDh0a0FQUi85?=
 =?utf-8?B?QmlCWk02ckFzT2QzVkRPUVNoZDY5OXg3QUdaRWkwUEx4UFc4akkwK0gvTjRu?=
 =?utf-8?B?WEVEeDZqMm92VTJKLy9XdXE1eEM4MmEvaVBFTlZpdGRWTUdIcjR2c2ZkU3Ja?=
 =?utf-8?B?TTBzM2tacFVmbEdOajFuMlRsZ0xZenpBd1ZPTjNZeFF1Zk01aHNCNTkyRktl?=
 =?utf-8?B?Yk9TL1RLRnFsRmZ5aXF6WHEvNmtwWWQyUFN3R1VlWTJXZTdsbEN6dVI5U1dy?=
 =?utf-8?B?SXZCM1FuWVRsSlJMQUNvSXZwMTJDaGxacitwZzVnem96N2p4bmNnRFpLKzZN?=
 =?utf-8?B?ZGw2NXFIMVM0ZHVVRm4rSzdDbXJ4STVXaTcyTXJyRjQ4bHF3THc2Z1U4SzBU?=
 =?utf-8?B?ZCsvZEVicW1EbFIrc3B2WW1qTG5XWURCb3p6dldVaFU5Ry8wcE5QQVk0TWda?=
 =?utf-8?B?VUUwNlBmR3ZiUk5yeW5BSUFOUjdLWkkxQ3ZUQUdocE1PRmpiU0ZpVlF4dW9a?=
 =?utf-8?B?bEZHeUNtT0hlTEYxVUJWb1ZNbUtHeFQzN2hOb2RHZWpJM2QzTFRTQUlobnlo?=
 =?utf-8?B?OElqY3g4R0hTQjVLZE02UXo2UXNiNk5UbXd2eXdoSUFyaFJ5L20reGVzcjA4?=
 =?utf-8?B?Y2xkWWlYQVZNUVlKUnh1OWpmN0dvQU9hUWZ1Wk5QcWl3cVgxb2M2N09HNWxw?=
 =?utf-8?B?djdxZGxOelJ2V2wzNHZmdDU4SDNGaGhVMk16R2lSUTIrTDBBeG4zdVgzS05n?=
 =?utf-8?B?YzEzKytkQm82aTFJQ2ZMRUU1NmJjUnZzazBwMk9URVo0eXlyT3lvcmxheXVh?=
 =?utf-8?B?bTVWazgvMGRMbEdMa0hOWHpMaUd6S29IajdtUjBCTXp0Yk5rR0U4akIvdkdT?=
 =?utf-8?B?TUtCZHR0aFNINkFaY3dRUEpNM2xzSlRqTXN5UGExYUtQMmhKb0FhT2RGd0dQ?=
 =?utf-8?B?S2R0ZjlaT1dMWms1cEhSbFhUVmxPN0xuamMvbkM3aXJaRFg5bzdwd3lhUTlG?=
 =?utf-8?B?eXVwZlc1Ykl6allqc2RZakFNdVpBVWxWN2lOMXlqNU14amgzNmxGYmdYeU5u?=
 =?utf-8?B?VnQ1SXJ5Sys1OVVaNllJdEE2Yko5aVJKc25jMlltbU53WFdUS29taGYyVzBI?=
 =?utf-8?B?L2VFZHU1cjM1S3hiRzNuMlpVYi8wUjlXd1Y5VW9jWlZaNzkwQ1RjQ0s5VTJ4?=
 =?utf-8?B?Y3IxMzZEWG1WVUI2enZZM0NpUkd3QVVjY1N6eVdFVXRKR0ZSVitZeGNvb3dU?=
 =?utf-8?B?VUxZdmtZcTJTS1NWL0xZRWtQWG9DdGtCMjhtOTRqbzEwTDZGaUwwbks0RnpE?=
 =?utf-8?B?MlQyazNvbzYwbmxDZEZvYjdxZi9lU1VLNWdkcCtYMmw4S0xHcDNlZTNHMlAv?=
 =?utf-8?B?R0JnNTVvcVZ0QzdMWVhOUzhkVTFFak81Q2FKQkJLa1NRc3k0STNvUjdRdjhZ?=
 =?utf-8?B?OCtMWFAyeTRKTlpFTUZpMVA5YzYvZDFNSFlMZkNPU1lReS9GazFvYVVmMTFS?=
 =?utf-8?B?a3QvekZzMm1SUjhYSEZQRXVwdmRXeEUyRHBRNDE2TThiODNqVm1odzRUclNl?=
 =?utf-8?Q?u+SZXWb7wmTDBPcupYTBmYXg5hiwkoL6UrWCx3n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aeafe71-c9ff-4d7b-a96b-08d8f3b8e3dc
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 20:17:49.7785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MK2aOChm7hCZrGuiG0/5biJjD4w8J1H9c3NyQTS/5FsdVRE5E+rX8U5ytLCw1wUMMXEMEElO+BsjexkPPx4vRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0143
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-03-30 1:22 p.m., Victor Lu wrote:
> [why]
> Enabling drm.debug=0x4 can flood the dmesg due to prints on every cursor
> update or page flip.
> 

Maybe mention something like this: "Our CI enables drm.debug=0x4 logs 
and is now getting spammed with cursor updates. We probably want to 
avoid spamming the log when DRM_DEBUG_KMS."

The change is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> [how]
> Define and use pr_debug macros instead of a few spammy DRM_DEBUG_*'s.
> 
> Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 +++++++++----------
>   .../drm/amd/display/include/logger_types.h    |  3 +++
>   2 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 92cee957b424..04dbcbc7578d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -372,14 +372,14 @@ static void dm_pflip_high_irq(void *interrupt_params)
>   	/* IRQ could occur when in initial stage */
>   	/* TODO work and BO cleanup */
>   	if (amdgpu_crtc == NULL) {
> -		DRM_DEBUG_DRIVER("CRTC is null, returning.\n");
> +		DC_LOG_PFLIP("CRTC is null, returning.\n");
>   		return;
>   	}
>   
>   	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
>   
>   	if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED){
> -		DRM_DEBUG_DRIVER("amdgpu_crtc->pflip_status = %d !=AMDGPU_FLIP_SUBMITTED(%d) on crtc:%d[%p] \n",
> +		DC_LOG_PFLIP("amdgpu_crtc->pflip_status = %d !=AMDGPU_FLIP_SUBMITTED(%d) on crtc:%d[%p] \n",
>   						 amdgpu_crtc->pflip_status,
>   						 AMDGPU_FLIP_SUBMITTED,
>   						 amdgpu_crtc->crtc_id,
> @@ -450,9 +450,9 @@ static void dm_pflip_high_irq(void *interrupt_params)
>   	amdgpu_crtc->pflip_status = AMDGPU_FLIP_NONE;
>   	spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
>   
> -	DRM_DEBUG_KMS("crtc:%d[%p], pflip_stat:AMDGPU_FLIP_NONE, vrr[%d]-fp %d\n",
> -		      amdgpu_crtc->crtc_id, amdgpu_crtc,
> -		      vrr_active, (int) !e);
> +	DC_LOG_PFLIP("crtc:%d[%p], pflip_stat:AMDGPU_FLIP_NONE, vrr[%d]-fp %d\n",
> +		     amdgpu_crtc->crtc_id, amdgpu_crtc,
> +		     vrr_active, (int) !e);
>   }
>   
>   static void dm_vupdate_high_irq(void *interrupt_params)
> @@ -482,7 +482,7 @@ static void dm_vupdate_high_irq(void *interrupt_params)
>   			atomic64_set(&irq_params->previous_timestamp, vblank->time);
>   		}
>   
> -		DRM_DEBUG_VBL("crtc:%d, vupdate-vrr:%d\n",
> +		DC_LOG_VBLANK("crtc:%d, vupdate-vrr:%d\n",
>   			      acrtc->crtc_id,
>   			      vrr_active);
>   
> @@ -535,7 +535,7 @@ static void dm_crtc_high_irq(void *interrupt_params)
>   
>   	vrr_active = amdgpu_dm_vrr_active_irq(acrtc);
>   
> -	DRM_DEBUG_VBL("crtc:%d, vupdate-vrr:%d, planes:%d\n", acrtc->crtc_id,
> +	DC_LOG_VBLANK("crtc:%d, vupdate-vrr:%d, planes:%d\n", acrtc->crtc_id,
>   		      vrr_active, acrtc->dm_irq_params.active_planes);
>   
>   	/**
> @@ -7991,7 +7991,7 @@ static void handle_cursor_update(struct drm_plane *plane,
>   	if (!plane->state->fb && !old_plane_state->fb)
>   		return;
>   
> -	DRM_DEBUG_KMS("%s: crtc_id=%d with size %d to %d\n",
> +	DC_LOG_CURSOR("%s: crtc_id=%d with size %d to %d\n",
>   		      __func__,
>   		      amdgpu_crtc->crtc_id,
>   		      plane->state->crtc_w,
> @@ -8053,8 +8053,8 @@ static void prepare_flip_isr(struct amdgpu_crtc *acrtc)
>   	/* Mark this event as consumed */
>   	acrtc->base.state->event = NULL;
>   
> -	DRM_DEBUG_KMS("crtc:%d, pflip_stat:AMDGPU_FLIP_SUBMITTED\n",
> -		      acrtc->crtc_id);
> +	DC_LOG_PFLIP("crtc:%d, pflip_stat:AMDGPU_FLIP_SUBMITTED\n",
> +		     acrtc->crtc_id);
>   }
>   
>   static void update_freesync_state_on_stream(
> diff --git a/drivers/gpu/drm/amd/display/include/logger_types.h b/drivers/gpu/drm/amd/display/include/logger_types.h
> index 21bbee17c527..571fcf23cea9 100644
> --- a/drivers/gpu/drm/amd/display/include/logger_types.h
> +++ b/drivers/gpu/drm/amd/display/include/logger_types.h
> @@ -36,6 +36,9 @@
>   #define DC_LOG_DC(...) DRM_DEBUG_KMS(__VA_ARGS__)
>   #define DC_LOG_DTN(...) DRM_DEBUG_KMS(__VA_ARGS__)
>   #define DC_LOG_SURFACE(...) pr_debug("[SURFACE]:"__VA_ARGS__)
> +#define DC_LOG_CURSOR(...) pr_debug("[CURSOR]:"__VA_ARGS__)
> +#define DC_LOG_PFLIP(...) pr_debug("[PFLIP]:"__VA_ARGS__)
> +#define DC_LOG_VBLANK(...) pr_debug("[VBLANK]:"__VA_ARGS__)
>   #define DC_LOG_HW_HOTPLUG(...) DRM_DEBUG_KMS(__VA_ARGS__)
>   #define DC_LOG_HW_LINK_TRAINING(...) pr_debug("[HW_LINK_TRAINING]:"__VA_ARGS__)
>   #define DC_LOG_HW_SET_MODE(...) DRM_DEBUG_KMS(__VA_ARGS__)
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
