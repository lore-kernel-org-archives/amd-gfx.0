Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710D9C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 15:24:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C1860FE6
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 15:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 29C1860FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 511366E12D;
	Mon, 13 Sep 2021 15:24:43 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2048.outbound.protection.outlook.com [40.107.101.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DA166E12D
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 15:24:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfqISHu84cPZJr98R0AECQMgQ3BhN4M2PPcsh2Td/XOTCb7hx4jtEe/FWC8K73WYj/xb6Hq2pRHiNNq3RJewCVJZpxtWiuo3FDKcxGK3MriZrRzf5Whwoxa7NAEVCJAvamShEeAdaHFW+KxlK15HrrWlwKKroUZXW/jZD2vznApY9dHB/SrUWoBjKBBKrHEImsaaPnBHaRZo32r7VDlNn4tD79MYDUkXDMZOauN3eh65QTuupOh0LURadW8tjdtKt6Go45M0Aa5YePpqq9ykcJRX7nno0rxGlFGvCh9sKVC9ZVU+XmBLPYfr8lvKkVHk/qMwyqDar+90tUkp7YQFjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=k9dQ0OT9Xlzop7dNZk0ehXmvrgLITZ9uc0Rc2en6Yr8=;
 b=JijRim/AjqAucLOsyae8PaGATKj0dmGZUPMTQjduz0QCOqUZ8QMFsqsLCsiqFQoKYlUdgz+qbO7wB8RTVTCl2oLQYj9hh1rZ5mTsN3SVj0yGxBhro6LpzmgOxQQLlsbW/Pzx9pPweq3swG/JwuZVW+HXu8/hU6Nht6yXEC6kuhKX9+R6vUlmxaqRKY0dlJdqAmh4EQfAvy6h0tUcaY9R4kfHR0Q3etIOWhed1+CUvx8Z5FdB1k8Sdkt/lKt6PCoSbnY6Dez3lctRjtUacqB8C0XXOMDIKjKVScARnalGsLOZv/WuiK93rIKGXynP+S1oPOiZ0UpLyih0VU0/m99Bkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9dQ0OT9Xlzop7dNZk0ehXmvrgLITZ9uc0Rc2en6Yr8=;
 b=Q+Qxco4QlcM2p+yIdebkrIpVLxux/q1DX2EjhxciaHP0evjqBN2G6Dn9Qpo0yQeFkTU8V6i3UXXUonVEMu43LJK4FPFPHQ5MSm4zaKDfuMQrNaopPUiqxHXNAVDl+Fw5PE33ynDNu06xDUHNSoQMy05YN91s9sofqSwmsgVvwcM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5474.namprd12.prod.outlook.com (2603:10b6:303:139::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Mon, 13 Sep
 2021 15:24:40 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%9]) with mapi id 15.20.4500.019; Mon, 13 Sep 2021
 15:24:40 +0000
Subject: Re: [PATCH] amd/display: enable panel orientation quirks
To: Simon Ser <contact@emersion.fr>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
References: <20210910153728.250947-1-contact@emersion.fr>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <1a2aad48-7ecb-c6c3-9964-0ad1f8a7c36a@amd.com>
Date: Mon, 13 Sep 2021 11:24:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210910153728.250947-1-contact@emersion.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::17) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.3] (198.200.67.104) by
 YQBPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.15 via Frontend Transport; Mon, 13 Sep 2021 15:24:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6109611-eea4-404d-5245-08d976ca9ac2
X-MS-TrafficTypeDiagnostic: CO6PR12MB5474:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5474E3C7D63F0FB384F73F398CD99@CO6PR12MB5474.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nu5avDCciE2WqG6l8SdFOm/DjLMTJNL/4HBCQH3v36L4gEuKE6N5RlHfuBJWAQUG4hMJCJmu+h3IxRQHavuLvgtHzHx9IylcoXAd4qZYys7w3Pfs2qwTXZ+IrAfHNiQrWs6SNKSu2WC5B7F1C12vvazbBBFw5IBdcQ5YbtvnQhb5bceGgLP4aiWHboU4rNDZJ39XJlerz29dBtBcxcKM8oWgS1LSPuw0iXPqxem0a8cuHQRPXy7ZecTlAfLUF7p841aUBBt/ZCP+ElrH+caeYrVEjeGbxyZcE7tuFEI6L13NhVo1EACJ7tpn/2n0dHpfy4GOo49oEDnXYe66H0RnoxGcUVFBgfDmIcSEULXAajBwpg7cGwPBecTp1B8Ls+LXBt5UTzvgo0tH30c04/IBbSr8QbJBBczTDB9KX0YLMefIsd6wG6cqlV47R0zBawvWqwDHQZw1U/Bts2J0GwMWK/S2+Vfnx/JXszWgizrzinfe49tZCukpTvpyNxsWdQVXlqbksdXPXLdfBx7XyIhhjcUermh9Dnu3b73b5lhYALecq5BrOTf/Y0j82FROQQmGZn6kZoir0qpwEVABYiNHZkK8rCZ3ttal1G1tqPUHcpX/zwUK3LNUaRN30jZ7R897+pTC3u2NN6luSHnv080feAibUcY+npSPAM/PC6QFU5lNWY3npzn1vuEaHICT1mjwwFzqY6QW+ght+aPCmonVFjn9fD+PoGAEp2tQ4U8aYSM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(31686004)(478600001)(956004)(26005)(8936002)(53546011)(4326008)(2906002)(8676002)(186003)(66946007)(2616005)(5660300002)(66476007)(66556008)(54906003)(6486002)(316002)(31696002)(38100700002)(86362001)(83380400001)(36756003)(16576012)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzlldmtXMC9zMmx3bld6Q1FlY2NPZG12TjFOMkhJZE0xcHhIZ2ZuN1dTZ09U?=
 =?utf-8?B?RmdHRVF1N0NDS1Ereit6NEtNRnFUd1VOMHBubVNzQjJUUDgwN3JqRGZvdktH?=
 =?utf-8?B?dEhlRlV3M0R2aU5icWRSMVNudGw0SFhPaTFoWTFWZENRbUZMUEl5cnBQYmpJ?=
 =?utf-8?B?TFlVc0VyK05kVHBaa0FiWGJpQkphbUZyR0RmcGZYSnZxMEJhSVpXYTl3TXhq?=
 =?utf-8?B?UW0xUzFtUHdiMk1jeTIvWStTK2RaUGJ2dDVheHQvSHBlY3hURmVOV2UwRVNO?=
 =?utf-8?B?eGh5RWFud1hHOC9Nc0pPTGV2cHdWdzI2VUZYWHFoU0FJME42bG0rckRyRjRG?=
 =?utf-8?B?bEJUZldGRWl6UkY3QWFtZFNTWk5YRnFOaGhZdGVwRjhVeW03Q1ljUGhJTk04?=
 =?utf-8?B?V2szUFN1RFQxR0xJVzNZUHVOMVJhSS9EQ0w3am9sTWdKOFRIYWRROG9DNlBE?=
 =?utf-8?B?Q1NBTE96Umg4OEhwOTg1cXlZandiMHZQY1NtNG8xMDBrcTZDT2t2ZnlzbXJM?=
 =?utf-8?B?ZlZqYUJBUEh1NGlKOEpseGdzcEt1a0VzUjMzWUFFek1WYkJMZFFJQkNvL0RY?=
 =?utf-8?B?bkVlZEFUWUtGS2JRK0F0c2pzbGFUQlZ0N2NVQW1ZT0ZBczNQUzVnK2x6cU5P?=
 =?utf-8?B?VlFXZ1ZaK0lqdGhPNWRCTFY1S2ljQW9SQ1pieWp2M0hyTzdnMkdveTFTYjBZ?=
 =?utf-8?B?c3oxREV1K0toa2R3SXk1MXhXdk9wTnlwSGM1dEZZR1dXR0l5cVRjVmo4QThY?=
 =?utf-8?B?N1VtdEVHb1BjdndWNnhyRUQyOGdXNEpUNGtaM1Fuck1TcUVnWHpaOC9uWXE1?=
 =?utf-8?B?UThDMkU0SDc2bHdsb1dHVlpNd2NWb1I2c3U1TlpKYTdJaVZlWjVkT3BxWGs2?=
 =?utf-8?B?UVg0VFpVemFVZmhFYU1yeStnWW1UTjhiRW9HZG9CVUdlaS8vSkFrQWV2MEdi?=
 =?utf-8?B?TGN4UmpNQlFqcGFBbFNuTVJNWGUrV09MOWVvNG9mbkhtNUluRkoxSEcvLzJ4?=
 =?utf-8?B?RTcreXc0TFBxYlBrdXhJdXJweUFiVG1CTlRMaUZPZEZpeHRpNVBwbUE2Mm1u?=
 =?utf-8?B?NG4zc0FsNDJQcnZSK0dvdTB4eXhqczI4Q2c2aFNDUnhSeWdZZVozMVljVWJr?=
 =?utf-8?B?djE3UDNPaE44WklQcHlOUy9lWHN3cDJjQXFXbXdkSWc3d3hmS1BOK2E4VmN2?=
 =?utf-8?B?OUtYclMwRFVLYW1HVXBiR0ZOeTZIb2NjaW9mTTdlVGFsNUxxNEJ1c1Q4U05I?=
 =?utf-8?B?anhPaTVZeHVMWmtleHYyNTlIMTdaUWxqdlZNT3M3elpZc3EyajBWL0JYRGhj?=
 =?utf-8?B?eDg0SE9KYktXZ0grZ2lKNUlUZjhtdHVYbE9qcmMwNWZpUzRHRDNnbDZTaUc2?=
 =?utf-8?B?RmFVd0RhOHoyOVI1QVhPRlN3SG8vMkZkNStmRk8rTCtwNFg5dFYyT0dGdWF5?=
 =?utf-8?B?ZnovRFUyRmE3Z2srZlNBdzdyUXlNV3ltbEpxM2dxR3VKZUV6dGlUdmcrSzFq?=
 =?utf-8?B?WHE4ampRd1BBUWhvc3pOZEpFVkJ4SXU5cERKSzFncVJsN1RGTWxUNlF1d2lY?=
 =?utf-8?B?a0MzbVI2dkxMNlhkamFMcEYxZjV6b0xWbDkrQW83N25rOSszWnZXQ2NxQjk3?=
 =?utf-8?B?NUtzU1FyUjlEQXluT1p6UDdRRjBaNmlwWmVwUWZoQmluY1QveHF0UmZlVXl4?=
 =?utf-8?B?V0JPdVNOaG5nbndDaVoyWDRBd3V3L05HVndTMUs5TTZucC9DL0xGNmI0VXZX?=
 =?utf-8?Q?gEVV8s+K7oyMNeJVcqLrWxrgKjp78rlpKBcWqeE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6109611-eea4-404d-5245-08d976ca9ac2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 15:24:40.3564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYhr7spJoCSyZQjkhJbb7iQsqRP9OSMP84B4p/zEoF7eVM23Q/IinXNDJ8qxvOYIhBI6X7at+OVQ27ROqbqUIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5474
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

On 2021-09-10 11:37 a.m., Simon Ser wrote:
> This patch allows panel orientation quirks from DRM core to be
> used. They attach a DRM connector property "panel orientation"
> which indicates in which direction the panel has been mounted.
> Some machines have the internal screen mounted with a rotation.
> 
> Since the panel orientation quirks need the native mode from the
> EDID, check for it in amdgpu_dm_connector_ddc_get_modes.
> 
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 53363728dbbd..a420602f1794 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7680,6 +7680,32 @@ static void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
>  	}
>  }
>  
> +static void amdgpu_set_panel_orientation(struct drm_connector *connector)
> +{
> +	struct drm_encoder *encoder;
> +	struct amdgpu_encoder *amdgpu_encoder;
> +	const struct drm_display_mode *native_mode;
> +
> +	if (connector->connector_type != DRM_MODE_CONNECTOR_eDP &&
> +	    connector->connector_type != DRM_MODE_CONNECTOR_LVDS)
> +		return;
> +
> +	encoder = amdgpu_dm_connector_to_encoder(connector);
> +	if (!encoder)
> +		return;
> +
> +	amdgpu_encoder = to_amdgpu_encoder(encoder);
> +
> +	native_mode = &amdgpu_encoder->native_mode;
> +	if (native_mode->hdisplay == 0 || native_mode->vdisplay == 0)
> +		return;
> +
> +	drm_connector_set_panel_orientation_with_quirk(connector,
> +						       DRM_MODE_PANEL_ORIENTATION_UNKNOWN,
> +						       native_mode->hdisplay,
> +						       native_mode->vdisplay);
> +}
> +
>  static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
>  					      struct edid *edid)
>  {
> @@ -7708,6 +7734,8 @@ static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
>  		 * restored here.
>  		 */
>  		amdgpu_dm_update_freesync_caps(connector, edid);
> +
> +		amdgpu_set_panel_orientation(connector);
>  	} else {
>  		amdgpu_dm_connector->num_modes = 0;
>  	}
> 

