Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36F0EB64D7
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 19:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1178310E247;
	Mon, 26 Jun 2023 19:12:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C8BB10E247
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 19:12:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ays6T+tyfFokskmcuw4SWa1NPPkS++9rIsSsV6mASzpo1dkADF6vkokvPQpIKj4JnJXb2z9XoowDo6xWqNcT4SAxmTwtn9IIOyB9m7t+Rg2Tnh+kXpSISWwAC8KAO6EXHtZTV3zBJ9OZyeQ9ViE3EkHopzQ5MXUOrCUDb8cm5mf0zXYfrmC33Gpn3xdE4QJyU+rVGYutYcRcUm3whIc+vbNno+bEkI86aWWSnu6H1JiLkCbzJ4ewwzjstpWNVlYcJTDgDFo3gIZNCCmNJl9HI3vwixztgtfiQELDbHUN74eWJIBGQrMoizTpACAawGhpmClln/UKKfyJ4T34LFZPzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QySkkBRvOjRV44jwNkmdZQBLf9xuNc+zW3tvGmh8JfA=;
 b=A6Mne2WFJ4r1aFBMPv983lEwHXcJYK3O2I+kKa+uDum09prD+oqGNOFtRcQxUA86wauS57f3jiZJotue3JRx9sheV3IPrWf4nVMcXn3Bx2xYHuQOTn0SxWY0sb/O1lDzOwFswVr79gstzL5wIVb+c90/lCP8m+vD564jO+CnmZKE8j7OGbCVgCFZWMv1q2fTlEysWQY+BzPvHSK6Mw5NbqxFPDCtJgtH6QAo6b5V0HUI/svfuQS+5phawHkEUo33D8KKg7V1+Q8/gP5ZLcJTxSCMAV5bBzoAC7QJHJOgYbMD0dQ5z6uCy7YP44AxaPKLtfr6OOanUnqfS+n9C9bvTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QySkkBRvOjRV44jwNkmdZQBLf9xuNc+zW3tvGmh8JfA=;
 b=gDosdJV4vMfQC3SuBU6/+NcbCevNc7Tk9aaicMdcD/bvNB99ehIbOhvHEx9RW559dR8LaJSXWDYYhjajWTG8U8PKw63cy/ys7HgbiZ3/HAen7dHCtpfvBWsUDYx47dBbwkQjd8UPGH0q+fB/XkYWUMpL4s9wjm82ecbP/T/J3EA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 MN2PR12MB4583.namprd12.prod.outlook.com (2603:10b6:208:26e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.21; Mon, 26 Jun 2023 19:12:36 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::1a81:77c7:9126:e215]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::1a81:77c7:9126:e215%5]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 19:12:36 +0000
Message-ID: <8f1edf54-6c39-00dd-a3cc-ed7db4035976@amd.com>
Date: Mon, 26 Jun 2023 15:12:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/4] drm/amd/display: Set minimum requirement for using
 PSR-SU on Rembrandt
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230623150522.32494-1-mario.limonciello@amd.com>
 <20230623150522.32494-3-mario.limonciello@amd.com>
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20230623150522.32494-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::22) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|MN2PR12MB4583:EE_
X-MS-Office365-Filtering-Correlation-Id: 567e3b15-7eda-486b-02fc-08db76794d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uu1+yh3UM0hzmX1YwqUk3pjY0Sl8u4S8Xyfz/Dwt9I+xIOdmVH5QO6CB1zTlXuP0XwlrKKf0pVHeIAO4BijiXp6OQ0GU1YMZj85vjnunM2T06uSg02NFl+gHPVBrrfrk+YZBi8D9fu/e2l6buBgLFRrZGbob3UzHzk2oqw1o+22zpdF2tYeXe1Itv2/MdZrI8yc1ZFcxxw9k6Da+c/8QakH1YfJmcQBrX9jbZhhuVnA+n0/CcJRznjzIYhEhNfV1jzeRwToz2D0WlSVAXj8tAw+XNbTTxjU6Hn5U8vacT3AqJrdPa8/2plHueWtaIgm+DEAOIHQApmCVeZxEv4BQV5Y4bkFFWud5xMd4rt+70aF9BA4qWdA5n3SH1cOusejQZ7rkee7mriqOsWT6MhA4X8faEwzaKeknHSifeMe6DkNBQoIPoU8iwcKzN4PRwPoTKoPLujwU03hiBTvF/mjoxpmAh1vaz/qfdT3IYOPSozAFecxQsPz4DL9cbP7E8hUlqRwYFW7SF9TdEL6nVLz8NmOR0z25pnMsCOFytccdoOwH+Ho06KH+D1K1KqKmM0+GvAVdndTWeyiqoXi4fUnco8Dg/3PTcJZxqAYNO0snTQ0JjmtoCbgP6KXJnEMgHWucAz8eKL9ZNrAAU/BkXBG2wA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199021)(8676002)(8936002)(66476007)(66556008)(66946007)(316002)(6512007)(4326008)(6506007)(26005)(186003)(53546011)(6486002)(478600001)(54906003)(2616005)(966005)(41300700001)(6666004)(2906002)(5660300002)(38100700002)(36756003)(31696002)(86362001)(31686004)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elQyTG9iRVpDbS9oUmdreEhwVmxpN3loTk84dEM5ckcvWmk5S0I3QTRvMDBY?=
 =?utf-8?B?eDdlL3BvYkgvbXRIQ2FpYXBOdUpMQ3VKa2IyWnEzSWZMSll6aDJGT1gvOERN?=
 =?utf-8?B?clFTQWcrbjFlU0hCNUdKWGk5enY0SS80eHpPZk4rWkxXYm9hQXFEeUttdzJY?=
 =?utf-8?B?cUVZdjFBZ3k3cG43RWt0SW1IKzhkN1YxalNIVlRZYVJSK1FlOVprUHcxekFh?=
 =?utf-8?B?ckozU3prMXpyWDYzd2FnTW5IZjVvRUx2RWx6OGNhZitXRHdiaHF3UVRicTl5?=
 =?utf-8?B?eDhHdGxudUplYk9SWGRiazRzSUpQbk9pRjZLMUxyREc4K05DekR5OU9nU0ZS?=
 =?utf-8?B?dmRxeDBKMXpjUTk3WFRpb1BjaUtMQ2JHM24xaW9XY0Vjc2VOOExxQi9Xb282?=
 =?utf-8?B?TWVFVkZQc2NzSnFkckpHbE9XR09lWVJncXFBRkxPVWs5TURKQkwvYlg3cGxK?=
 =?utf-8?B?dFNSMzBNd2NqVC92Tm4zUTdLdHJCZUgyYmMyWE9KQVhzWlMxZ3ROS0pJZGVX?=
 =?utf-8?B?azZYZ1VPL2U1ZjA5NWZ3TWtsZFVKN1MyaFptSEZESi8zZkM4M0Q1WERzWFk0?=
 =?utf-8?B?ZkMvWWJpWWtFVkFVZmZybFlCdXIyaDdlck1YZisvMnY2ZjhqNGJSQVZBa29D?=
 =?utf-8?B?dms2MTlHeWEvMFBoQ3V0Q1V3cGYrVnEzam13NWFEQXA2RjhhSklnTCtPc215?=
 =?utf-8?B?aXFDN0ZrUkZNK3FDT3NGUWlsbCtNUlVtVktXbVVxakJGVXFEZDRGMVlHLzNE?=
 =?utf-8?B?elJSVndkbEdZODgrQ1Y0Ti9WZnl5OEZsR01BazhSZzhWOGJpeTdwamw1Qng4?=
 =?utf-8?B?MUUwZzBQT2w0VW5Qc0hDUXh5cVpPTGpmcUczLzl0dXdiT1dTdUUvWEhZaVI0?=
 =?utf-8?B?bkx0L3IvNkJNNDNmRk9yanpib1lCbWsxWVFWS2J1MXFDbGRJM1AvQjFvdy9K?=
 =?utf-8?B?Wk1pVHpKVmpSK1pRQ2x6aFBlV0VOaFFTZG03NXVmZXVpZ2ZCUVdQSWZHVnZJ?=
 =?utf-8?B?K0VYaDUzaDhzU2FRSUxIYTlYejczWGlOWU91dTYzOVRQK045ZUZhQm9OeHJP?=
 =?utf-8?B?cStJS3dONGhxTVVnRDVWVlhoOUJaNDJkTjhVMFo0QjcrRmU1YnViaW1TN2VT?=
 =?utf-8?B?SnJQNTlxWnMwUzNxNTRBQ2JlaWhPNFNsMmpEbnE2dWFRclRXQm05d2ZDZDJB?=
 =?utf-8?B?VmR2SFBiclE0aTdMdXdNVFVrVWxhRWZsOHlTUFE2K0gyNHhmUzdRSHRnL01I?=
 =?utf-8?B?ci9Nc01hT1YycllMWXk2eDlGSGwzMFZ6OFNkQWJNK0J5S2JiZUY2a3ZtZ1p5?=
 =?utf-8?B?b1pxeFJYVUdKb0wwSUVtZDZoVkxxMUJyc3lFWFE0R2FGQmhOOGJRQzNTNEdo?=
 =?utf-8?B?bVNMK3ZXcmVRSitsWGt3UVpHSlVqUWk5RVJYVDA1empRZEdpbWM5QnQyRFNB?=
 =?utf-8?B?aVRXbmtMcXhEYjdpdlA0dDIyM1BlODZYS1BNa2o2Tmh4OEVjRk9INW1mVHdS?=
 =?utf-8?B?eHBJMEcvd2ZzbmtEOWxqUVlQQW5SZHVLRk9hWUxmWTZBRFlrZVNuYnpXcnVD?=
 =?utf-8?B?Q0cyRm4yaERqcFFMQUpkVjVwd2M2SjZMS1kveE1NSU5iMFp3WTY2bk83dXlS?=
 =?utf-8?B?VTQ5STJmQXZVN2hMME10UkRtdUZnelduMzB2V21YbVNvWlhTUlZ5cnlwcEk1?=
 =?utf-8?B?NDRZYWd4aVR3cGtpamhSNENBeTNZM1FWNzlLdXQvZTRuUzlXWkdVdnIrVjR6?=
 =?utf-8?B?NmRaTnRPL0lMSFU3SWNZT1cwRUJ2Mk9Id3RhMUd1cVIzbFN2TXIyZDZTdjhJ?=
 =?utf-8?B?VmlrdG1JMmtwak1zTVBMZ2FpUWlMWWFUUmR5eWEyMFA5WWRoMi93VW5KUGJ5?=
 =?utf-8?B?L0JTanNZR000cDlvbFBaWS9GbjF2L2d1WUJSR0VQYnlVdEl4dHRISzk4SFVL?=
 =?utf-8?B?NmgzSGVrZFYrNnhIMWZUempRVFlNT004YmMzaWNMaXJhaFduamNrOVV1SUVU?=
 =?utf-8?B?NE5BRXZTNi9yVVEya2RxWmRleXJTM05nMnVQOHJuUkt5amtQcHc5RDVvTy9m?=
 =?utf-8?B?aEpQRDA0ZW91QlNWRXMxUjltRDQzb01ocVl5ODFmeWh4bDZEbXpLS3lERzNB?=
 =?utf-8?Q?so0MC60jaKm/MMd3iMAKSzmUD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 567e3b15-7eda-486b-02fc-08db76794d4c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 19:12:36.4748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptWTGIn9SRFEbjXAE6nLlyE5/SVzti8E7a52VIhtdSXRt7W2aJY0noVXU1sGYslX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4583
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
Cc: Sean Wang <sean.ns.wang@amd.com>, Marc Rossi <Marc.Rossi@amd.com>,
 Tsung-hua Lin <Tsung-hua.Lin@amd.com>, Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/23/23 11:05, Mario Limonciello wrote:
> A number of parade TCONs are causing system hangs when utilized with
> older DMUB firmware and PSR-SU. Some changes have been introduced into
> DMUB firmware to add resilience against these failures.
> 
> Don't allow running PSR-SU unless on the newer firmware.
> 
> Cc: Sean Wang <sean.ns.wang@amd.com>
> Cc: Marc Rossi <Marc.Rossi@amd.com>
> Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
> Cc: Tsung-hua (Ryan) Lin <Tsung-hua.Lin@amd.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2443
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Leo Li <sunpeng.li@amd.com>

> ---
> v1->v2:
>      * Fix a s/dcn314/dcn31/ mixup
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  3 ++-
>   drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c          |  7 +++++++
>   drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h          |  1 +
>   drivers/gpu/drm/amd/display/dmub/dmub_srv.h           |  2 ++
>   drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c     |  5 +++++
>   drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h     |  2 ++
>   drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c       | 10 ++++++----
>   7 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> index d647f68fd563..4f61d4f257cd 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> @@ -24,6 +24,7 @@
>    */
>   
>   #include "amdgpu_dm_psr.h"
> +#include "dc_dmub_srv.h"
>   #include "dc.h"
>   #include "dm_helpers.h"
>   #include "amdgpu_dm.h"
> @@ -50,7 +51,7 @@ static bool link_supports_psrsu(struct dc_link *link)
>   	    !link->dpcd_caps.psr_info.psr2_su_y_granularity_cap)
>   		return false;
>   
> -	return true;
> +	return dc_dmub_check_min_version(dc->ctx->dmub_srv->dmub);
>   }
>   
>   /*
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> index c52c40b16387..c753c6f30dd7 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> @@ -1011,3 +1011,10 @@ void dc_send_update_cursor_info_to_dmu(
>   		dm_execute_dmub_cmd_list(pCtx->stream->ctx, 2, cmd, DM_DMUB_WAIT_TYPE_WAIT);
>   	}
>   }
> +
> +bool dc_dmub_check_min_version(struct dmub_srv *srv)
> +{
> +	if (!srv->hw_funcs.is_psrsu_supported)
> +		return true;
> +	return srv->hw_funcs.is_psrsu_supported(srv);
> +}
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
> index a5196a9292b3..099f94b6107c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
> @@ -86,4 +86,5 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc, struct dc_state *context, b
>   void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv);
>   
>   void dc_send_update_cursor_info_to_dmu(struct pipe_ctx *pCtx, uint8_t pipe_idx);
> +bool dc_dmub_check_min_version(struct dmub_srv *srv);
>   #endif /* _DMUB_DC_SRV_H_ */
> diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
> index 2a66a305679a..4585e0419da6 100644
> --- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
> +++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
> @@ -367,6 +367,8 @@ struct dmub_srv_hw_funcs {
>   
>   	bool (*is_supported)(struct dmub_srv *dmub);
>   
> +	bool (*is_psrsu_supported)(struct dmub_srv *dmub);
> +
>   	bool (*is_hw_init)(struct dmub_srv *dmub);
>   
>   	void (*enable_dmub_boot_options)(struct dmub_srv *dmub,
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
> index ebf7aeec4029..c8445d474107 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
> @@ -302,6 +302,11 @@ bool dmub_dcn31_is_supported(struct dmub_srv *dmub)
>   	return supported;
>   }
>   
> +bool dmub_dcn31_is_psrsu_supported(struct dmub_srv *dmub)
> +{
> +	return dmub->fw_version >= DMUB_FW_VERSION(4, 0, 58);
> +}
> +
>   void dmub_dcn31_set_gpint(struct dmub_srv *dmub,
>   			  union dmub_gpint_data_register reg)
>   {
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
> index 7d5c10ee539b..89c5a948b67d 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
> @@ -221,6 +221,8 @@ bool dmub_dcn31_is_hw_init(struct dmub_srv *dmub);
>   
>   bool dmub_dcn31_is_supported(struct dmub_srv *dmub);
>   
> +bool dmub_dcn31_is_psrsu_supported(struct dmub_srv *dmub);
> +
>   void dmub_dcn31_set_gpint(struct dmub_srv *dmub,
>   			  union dmub_gpint_data_register reg);
>   
> diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> index 9e9a6a44a7ac..7a31e3e27bab 100644
> --- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
> @@ -226,14 +226,16 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
>   	case DMUB_ASIC_DCN314:
>   	case DMUB_ASIC_DCN315:
>   	case DMUB_ASIC_DCN316:
> -		if (asic == DMUB_ASIC_DCN314)
> +		if (asic == DMUB_ASIC_DCN314) {
>   			dmub->regs_dcn31 = &dmub_srv_dcn314_regs;
> -		else if (asic == DMUB_ASIC_DCN315)
> +		} else if (asic == DMUB_ASIC_DCN315) {
>   			dmub->regs_dcn31 = &dmub_srv_dcn315_regs;
> -		else if (asic == DMUB_ASIC_DCN316)
> +		} else if (asic == DMUB_ASIC_DCN316) {
>   			dmub->regs_dcn31 = &dmub_srv_dcn316_regs;
> -		else
> +		} else {
>   			dmub->regs_dcn31 = &dmub_srv_dcn31_regs;
> +			funcs->is_psrsu_supported = dmub_dcn31_is_psrsu_supported;
> +		}
>   		funcs->reset = dmub_dcn31_reset;
>   		funcs->reset_release = dmub_dcn31_reset_release;
>   		funcs->backdoor_load = dmub_dcn31_backdoor_load;
