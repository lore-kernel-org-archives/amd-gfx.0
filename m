Return-Path: <SRS0=2cAG=FA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF98FC56202
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 14:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A582065E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 14:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XnIKQaq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A582065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83AE58936C;
	Thu, 26 Nov 2020 14:36:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B39B8936C
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 14:35:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAU0oNdzQ+sW0QIIeU4in0utwemdu+yeNO/JSk9EaKfJk8qFeb4Eet0gdbDDddNEgjwyT/AQZOdGCdGyMIgn2Tw/4WsUDoq9ZtT8vMDd4IaW0YGOlicYV7QJ/aw3O3AKOr8tCis1SnhUp3szJfzKkr09qZZ0kOthLcPME/ITF3/XqRGcwgMNc/cWdASAIE+kb/9xg+umGjZ6yaRGJHhKinnzScuYlul3qe89J8ejim4BjbvwVCEQ2jmuXE+HAfbpEMTWAbmaOyNOkK99rUuNkcNFKgdI05RE+AUwBhG1G7dSPh4X8Sadc7dmihDeGpZtch+n982i/cZGUMcTcC73XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5SGWkJY4E1Vz+ZTXn8hagAgT9ZvdT/UjC4a9iJjEj0=;
 b=SuJKBdzqIxYxy8A8i1CfjFlJPYHVx5Ja1yJK2IspKWRBBD0dMZUpnjxeEU6Z/tG7xRVARZv5xxJQ7JWT2RsfOQqS62SR/vdG627RvvZTnTQ4HfYRR6mREOHyGQwFJ22YHPeyszN8C5JggqJHx0plEFBeqJGjZ4NAn6FGB4tB9RcXEIA07I87Cm3ZhBh7fMVawIqqhzjxiMWtlECqB2vMUuSBWg64AlIRAM0TORxljIjRBi2tlTXFoBuCHhivLXkJW3OQIjzDaab5hM3m831syfm+LP+L8L6UMHbphca3RruAP58guKXFyTubc/9nXWdoGOtDBiBiySx8yX5KzNKawQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5SGWkJY4E1Vz+ZTXn8hagAgT9ZvdT/UjC4a9iJjEj0=;
 b=XnIKQaq+X8UZifGOyKSHTmdBbgS/9pTP0ai878k84SOYDSj3/0fkPYeqKoZ1dgHIXDUPSX34fLQp7trm9l3RZMTHIeKlqrmokoouI6tjscrzuatIG0y/pCdGwGA/crYepY9JSNsO9f/owzA+k6gL5C4r3pJ4PpzpRGsRwLnGGrY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3382.namprd12.prod.outlook.com (2603:10b6:a03:a9::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Thu, 26 Nov
 2020 14:35:57 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::805a:3c9e:fefa:a95e]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::805a:3c9e:fefa:a95e%7]) with mapi id 15.20.3589.028; Thu, 26 Nov 2020
 14:35:57 +0000
Subject: Re: [PATCH] drm/amd/display: Clear dc remote sinks on MST disconnect
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201126143105.32016-1-aurabindo.pillai@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <ab9f847e-d819-7ff0-f677-c2ee5587b2ae@amd.com>
Date: Thu, 26 Nov 2020 09:35:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <20201126143105.32016-1-aurabindo.pillai@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: CH0PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:610:76::15) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 CH0PR04CA0010.namprd04.prod.outlook.com (2603:10b6:610:76::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20 via Frontend Transport; Thu, 26 Nov 2020 14:35:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8e0d4d0c-bbc8-4704-d6c4-08d892189667
X-MS-TrafficTypeDiagnostic: BYAPR12MB3382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB338210BAA58B097980A85F25ECF90@BYAPR12MB3382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RsMnLp2GHBdefjuNq91i/rU6Hgd/300uYO/uUGEfYqWiGYWhJ69Qcp6I/QrfTDSJwrSgaypaAaG6MALdZRW5zeeGWApbdkl+uY/MTqC/s5BlB7V4vWcG17jEg6b/1JuMinWw8s94/+q0H70n8pUseFVefAsCNuJbqyBYEzq7n4zjKWo+EOFx/dFm98aUTqLpw7mocGtolXt0yMYqf+ZqLmgGO+kTG2Whjc5SRTL3UAwLNAWnBogNAMMZlvFHiNbbP3Nca888IUNWO5WpcIYW9O8J+7R732D53fhXBbr15f1ChsMwx2EMFtML17HvlcJlWV/PtOMgXGO3P1zXSJGiemQalbwq2JmJpXnH7s71xl76vpIKH6m/Rc7MtmVTnWHW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(2616005)(16576012)(8936002)(66556008)(31696002)(8676002)(66946007)(5660300002)(6486002)(2906002)(316002)(4001150100001)(4326008)(66476007)(36756003)(31686004)(478600001)(86362001)(26005)(186003)(53546011)(956004)(52116002)(16526019)(83380400001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4ThVpVXwZY6AyEjNEMqS1R0a29CuHFQwgksPSYL7Bnfd6DsdKu/S21fTwZGlU9pboiEtKdayUeI1H/LOsRxX9nNXXlikvQZGVzuMcwUrGAzn8NK22nsLEuTneBVQ3btBRlPGKxT0Nf7zeFabak+lRJHDMoGNx1ogb0Ey3SLHaJJ7ZUh3xUQNAN9bEsAp5e4Qn8i/dHniL9TR34z3CVeYiUZj81bq4tc7tdp+YJseT55evHHbtCvIhD2nPmJbUAomclmm8EeHq98N3vk+0/RTHFG7t9UJdpEpd3Bxrj4yHOpvNXGPimCJ3BxqTjvkGcDxOdKbj+xbE7eyn7Fe01W6Ux8wKYwK5YHGaADdX6jLtodiGZ15o631G37cdRE9rJS0+yszRPPvK9EGtroMd2AOWABWsKDAkN2BpCpVHVfQoaoJ0u/m4FZKLqkFenbTZecqzso4spVtXHfhNsy4Dbh/92v/sL78pEAtZNSS7H7x0Mk3/Ix+dyP/fEtOOO8Hud6CwJWuvzC7Yz/FqdG16twX9t3WsxnHK9dI6ipaSzbWSIXnqwNyTTOAZGvNzYkUl9w8GmOv490HuMHCEGQBlOlQrl8Q+V9NL+v0pyQNRgC4VVa6Q8g4ATIs+BpTrywmC6V2WMMcnpCLIwxPOnDfIEjcD2irBamOSTFIVt6zdT3wnsm4tMd4Mi803Tyz58k8Bi+/FQ8LQbdzUTHQeh2fXfOy9D34oPDUqcfR7NefA5BOAkd2EMijQ7Ig7bQHqCHuPRa7q/coULEbEYCScSR3s0XZm4/qwI0uWdcLTxIQWDQ/gEbm2QRl1T62mbkpgVyxyA9hAFQnkT6uyImKMnig7dSgiW8sc0o+yMws0MTRLCYhD/0yC2cllYJJO8WibApBi9NpftlBb+EZMBwlVvzeomsskA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0d4d0c-bbc8-4704-d6c4-08d892189667
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 14:35:57.5062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMlzr5ku7EonVV3CkDgwOUTngxjytWiYRDQOu49DfM+pC1d2AIYaD5vBIfcQzR/DtdsyYOUF53zu5WGnRx2MQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3382
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
Cc: aurabindo.pilai@amd.com, Bhawanpreet.Lakha@amd.com, Eryk.Brol@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-11-26 9:31 a.m., Aurabindo Pillai wrote:
> [Why&How]
> Recent changes to upstream mst code remove the callback which
> cleared the internal state for mst. Move the missing functionality
> that was previously called through the destroy call back for mst connector
> destroy
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Eryk Brol <eryk.brol@amd.com>
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 22 +++++++++++++++++--
>   drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  2 +-
>   2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index b7d7ec3ba00d..d8b0f07deaf2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -418,9 +418,10 @@ bool dm_helpers_dp_mst_start_top_mgr(
>   
>   void dm_helpers_dp_mst_stop_top_mgr(
>   		struct dc_context *ctx,
> -		const struct dc_link *link)
> +		struct dc_link *link)
>   {
>   	struct amdgpu_dm_connector *aconnector = link->priv;
> +	uint8_t i;
>   
>   	if (!aconnector) {
>   		DRM_ERROR("Failed to find connector for link!");
> @@ -430,8 +431,25 @@ void dm_helpers_dp_mst_stop_top_mgr(
>   	DRM_INFO("DM_MST: stopping TM on aconnector: %p [id: %d]\n",
>   			aconnector, aconnector->base.base.id);
>   
> -	if (aconnector->mst_mgr.mst_state == true)
> +	if (aconnector->mst_mgr.mst_state == true) {
>   		drm_dp_mst_topology_mgr_set_mst(&aconnector->mst_mgr, false);
> +
> +		for (i = 0; i < MAX_SINKS_PER_LINK; i++) {
> +			if (link->remote_sinks[i] == NULL)
> +				continue;
> +
> +			if (link->remote_sinks[i]->sink_signal ==
> +			    SIGNAL_TYPE_DISPLAY_PORT_MST) {
> +				dc_link_remove_remote_sink(link, link->remote_sinks[i]);

In general I think this patch looks fine, and you can have the:

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

But I think that this loop is redundant - dc_link_remove_remote_sink 
should be removing all the remote sinks. Not sure if remote_sinks can 
start at an index other than 0 though.

Regards,
Nicholas Kazlauskas

> +
> +				if (aconnector->dc_sink) {
> +					dc_sink_release(aconnector->dc_sink);
> +					aconnector->dc_sink = NULL;
> +					aconnector->dc_link->cur_link_settings.lane_count = 0;
> +				}
> +			}
> +		}
> +	} >   }
>   
>   bool dm_helpers_dp_read_dpcd(
> diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
> index b2cd8491c707..07e349b1067b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
> +++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
> @@ -113,7 +113,7 @@ bool dm_helpers_dp_mst_start_top_mgr(
>   
>   void dm_helpers_dp_mst_stop_top_mgr(
>   		struct dc_context *ctx,
> -		const struct dc_link *link);
> +		struct dc_link *link);
>   /**
>    * OS specific aux read callback.
>    */
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
