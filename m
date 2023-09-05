Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C259CA0FF7
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 18:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E1B910E3F4;
	Tue,  5 Sep 2023 18:48:02 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EC7510E3F7
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 18:48:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bse93XJFnzDlV/nzM5J1h9jlyhPdzh51gkFw7iURg9EuFWRgEQTl3fEtg0umAUAtUqU48nZaL0DUYnQsS8PF49unUnxB4PyI0Agl25pZ5xpzGu05dEZhUnsPlO/hBy0GFjExF68MymfnGs5I0IBu+DC7xmZqKeZC3mZ5PtpYszLMrCRKXLDU8ekOwIXhYroksX7We/NrYB1UdMHnzJJryE8crBfzCDHbWMnZsTdQOS1D/9e2rA5Jm4CUDGbLWTHLMxq2sVy0yMa47iatVd/QpuEvpnvta1Lr+3YxjqfRTM5mdVNIn8W6L+dxZYxBmu7w0ZIS0q1W47oL34wGIyGqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mltJSevUOiW43upy33hlIQbOAPsf9OQF8Ih95xz2Zkw=;
 b=G8Ji0b8dXvqPnE+Vt/dk7kg49dZX+sl5kaI3FhupuNAGvrrAQbJgEzZYYhuvtnP06BfuvBgtRRDYGWksrwd0TRjRdS1QmOinzZVgP6fnaKABpsCn5rWMkyD4Xpzrd0aUAgU49c5Pi3mjxcNa6hQAtxl3k1PKjaDB0aYulWq08QabamvwMlUtsa57MmLqsu1sGje6lub9bGAPC8JVL0oJu9tJupj9wveqGLH1CvYfldqYp/E53GcE+cEE43icBjRgOpTpCJSO7SktU3NjBmq97rjy8Xr1Jlk5Led0DTYpozCdHctCOBXbFzxh4LR0rs5Juvxqs8yweG8TEdU1VUEqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mltJSevUOiW43upy33hlIQbOAPsf9OQF8Ih95xz2Zkw=;
 b=u77UIKpXAQoxI4lpxUggFe7AbzI5tVRGHcoGN3w9gifccszGLGmdwWelGGmjnbFQmbgtmyxOiNFqJg0U9ERuVZo+mDqc+F7nTJustoQ5BYYGUAq7hq144+GPiLxHB8fOdbspzi0T5XJ7igZPBR088oIcSs4oKQ2MiPxFR3S5NkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3048.namprd12.prod.outlook.com (2603:10b6:a03:ad::33)
 by CH0PR12MB5108.namprd12.prod.outlook.com (2603:10b6:610:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 18:47:58 +0000
Received: from BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::1dd2:153c:f0bc:b80d]) by BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::1dd2:153c:f0bc:b80d%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 18:47:58 +0000
Message-ID: <71dc30b9-a6b4-40f8-eb16-fd82ec2be51e@amd.com>
Date: Tue, 5 Sep 2023 12:47:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 05/18] drm/amd/display: Return drm_connector from
 find_first_crtc_matching_connector
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20230816212626.987519-1-alex.hung@amd.com>
 <20230816212626.987519-6-alex.hung@amd.com>
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20230816212626.987519-6-alex.hung@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:a03:505::17) To BYAPR12MB3048.namprd12.prod.outlook.com
 (2603:10b6:a03:ad::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3048:EE_|CH0PR12MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: aad356d6-0843-4b23-2343-08dbae409f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5lKX2A+fRltxlkswrpPpMzczrTN03tPQDhE9JEL3NXDgwx4wCwoenZ66HIY7go/QyEMS36NyU3/xAKzzydpqadjdwsFTlnhf0EFLn1SN/0m24MjK63zZKpZshBmklzgdF80n3+K3odC5xHlNYyRZ0SysETZJ36gb5Jzmvj0yjEiVAjTqc1GHFEibHvSOmLBXWWPsSgOfAmzVGHNZszdw+9cxewcbCPLDgNAOAqdtemk0f1vTWMGUb1jxq+CscL36Cq7RljTRw7ZTuMSuCXdYCOe/dnW9KUbFPmH+oznkWYzwvrFH1raTEq8yjwSiYSNFneIFcae+pxxp/wwmM/1aW39CcLRcHcnfoR0OCXyJQUitTw04zUO/LXI1Vx1658iV7JEMJNhkEfu6zyyVlqvfaHrFb53FIZEPtDIqvLmX8oeRtU1GMsV4JXCtoA/yC5Ow7CfRzTjay2fwzC1xrxnNAOVh98YWCfmTerSCI++GpTGOJ4oEAAO5uLVj9KIm3punkO95RIMVpy7wuoEgd32sUaokYamwMkmt6KMKxKvFehkositPfr+21ml3FZpP7JxVkAcXnN2Ka2bVc8sAH6lrv28cmggnXsmrhF0pOzPPLgW0UFGxfP+IXNxYDs5xuOFoyrBCtf66OnqbYcNuOvJQmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(186009)(451199024)(1800799009)(31686004)(36756003)(53546011)(83380400001)(8936002)(31696002)(5660300002)(4326008)(44832011)(8676002)(6506007)(2616005)(6666004)(26005)(86362001)(41300700001)(6512007)(6486002)(66899024)(478600001)(38100700002)(2906002)(316002)(66476007)(6916009)(66556008)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Skc4clA3MXU4U0pEQjZONUVBMElZa0xCTEQ1RlNDb2pyMnVlcTdTN2JxUU9K?=
 =?utf-8?B?ZDRRNFNMY3F6VW1WSmc4QW9mRVYrVFlYY1FBdEpCR0FjRllsSDJ0dWNaODBn?=
 =?utf-8?B?OWdWZTdPZytQQk01WWgwVEJRRDV0MGpTS1BWS1lHSnY0RUdDTFlnSlVNdkZy?=
 =?utf-8?B?bWtyN2JJMGZNZnJ0WmVzcjc4VzJRendLaFFML2dGZWlLaDNFZ1FhWUl5SlJO?=
 =?utf-8?B?aUtnc0NBaTRoT2NsQk9mME82UjVZSDg5T3BZRzVZbkxDYUZ4d3ZGWmUzMDFr?=
 =?utf-8?B?YTJncVBpdEZ5SzVPSWtxQlRMOFZrSmFlN0FqQk5RMkF3RGJNRDlrNzVoRDly?=
 =?utf-8?B?WDhVSXpoK2tIR2t2Q1ZPdHE5RTBWV1B4QjNmTjhacG1ZU0NhZjUrVUtrdXlH?=
 =?utf-8?B?RTNpcFczTTduUm83Wm5jMXQxQitBMmJKYWluaTFnRHNnQUkrSE5xK0I1K0Zw?=
 =?utf-8?B?VHBUUWZpUURyTXNxckZpQzZTN1pIY2tQUVdjN21Za3pxTTlQeVJwY0tXRGFH?=
 =?utf-8?B?cW45RmNpaWJINjMzcE5OaWlZbFlWQ2RjYXIwWmplZEhPVGlUNU5EcVhUUGgx?=
 =?utf-8?B?OXhidjhibFBLdVYzcDBVUDdPNFJwUzQrdTFsenE1NHpQaXdMQnRsTWs3M2Fl?=
 =?utf-8?B?ZDFLSnZIZUdMSVdieUtrYXhncGlZM0xkbDVlSGtSaXNmN3VCNUxJRDdkZ2VC?=
 =?utf-8?B?NWJEYVorQUlqMGVCcllrM3diaWh2VHpXbEU1Q0pJcyt5Rmpac2FDNG1wMVk1?=
 =?utf-8?B?L3RzWlUycVE1a2xuWGtaVEZKakN0dHNySFJkL3hhTXkwMWM2WXFTTlhjRW8w?=
 =?utf-8?B?UENsT0JUb0xnNlU5NUc4Z2ZwNzFDdHdOR3M0WG1VSlJmQTZ1Wk9XZUxiT2Mw?=
 =?utf-8?B?OStpZWVvd29GMDdMeERsUXFnYWx4amJhN284TUJhS3Y0dUZDUEZkaHFnaEov?=
 =?utf-8?B?WXVhK1Zuc1B6Z0FoOVlzdmt2azNvU2k5emxXTzNvZlQzRE9JY2hvdHNlTGxU?=
 =?utf-8?B?eXZuZlMzYitlWlk5V0FIUWlMV2F6M0tOeUU1RnRmRlpmd0U0RDR3c3RZdkxu?=
 =?utf-8?B?Q2ErSzA3UUZucXMvRGhvRVpHTmhHb0g2K2lUR2ttUGRlNGxEdVFvdXhPOGpZ?=
 =?utf-8?B?amVjMGloVDRaQnVSUS9qTStoOGZDWEQ5ZFZRMHVNUUR6ZXU1MHY4VXRTKzNn?=
 =?utf-8?B?b2I3L3Q2V1UxRW9xOEhBMlZMbHJ6K3lHMGJJeWNMWXNiaG1ZTGNBc3VRVXVO?=
 =?utf-8?B?bThacUUxMVlJdWsxNGFsMTNWa0ZzditUKzQySHNhV3NHY0hGb1AvdlYwNzhX?=
 =?utf-8?B?YW9ZcnlnRXg3ZGRMNnEvRGwrcHo1RUQ1aTNkZjlYektvWElzVTNOc1FkQ28r?=
 =?utf-8?B?cG80Tk9HUy9JZE1RSWlHakVYQTRRRHpxd0tiZEV2VHA5QTQxeWltMVRJNVBV?=
 =?utf-8?B?Z2x3MXloZTk2S0JORlI5QWxSVjJONTFRZDJTL2N1N1RWN2xUcGNMQjJCbEZF?=
 =?utf-8?B?Y000VUo0dlRIVW9CTnQ3Sm5kVVNsSi80eUFwS1QvdXF2cmtpT2tNTFJiaFE0?=
 =?utf-8?B?WGhoM1NSSjdaUTJNVDJyS3FrNjliV1hDamNmbXZmbEU0ejlKNnEyTDgvTGxr?=
 =?utf-8?B?UVFGeEhzbWYvbVpKYnpzUFV2Y3RYMm81b3RjZEQyRVJLTTZDZGpTdE9WM2Q0?=
 =?utf-8?B?UXk3Z0g2cGFQRDU0L2lRZ1U3Vi91MjJsMGhlRzVEY3dFbEpIdUE0ZWFQZXlj?=
 =?utf-8?B?WEJsWUhnbnQxY1NGMHByN21rYUV4VU5OYkw4bXZSRWdPc2JSVmFTdW9uUzlT?=
 =?utf-8?B?MHZDQVVOenl5eXpPYkEzZ2tFU00vQzdsZEZUdXJxMjJsUTY4cmpHYmMzQ3gy?=
 =?utf-8?B?K0ZOYldFS1VkUC9aRk9UbEVjTW1GNUZJNFNkKytWYTZFWHJhdldMN29iRE5m?=
 =?utf-8?B?UUNZVmpMTmovaUxOQjhJaUxVTHN4TG5kbUdNRlcxMllaVzJ5WHBhTVZ4V3o5?=
 =?utf-8?B?SXFGUjIxMEVSS2xKNk9wRjZTNDRKd1d5ZEdMTDJ5ZTlwV3R0SVJhbmUvclk2?=
 =?utf-8?B?eWM4VWtaaTN0WkxhWGtqanNMZjQrd2xoUWtUR1NRczBGbGpkRkY1ZlVoMnRM?=
 =?utf-8?Q?JCnR2s7ZwyX2RAo1ErkDLl6M2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad356d6-0843-4b23-2343-08dbae409f7b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 18:47:58.1267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePHwPdVW9nilkbblo8FNenp5fDSJdBjCy4c/33NebHCqAQwgbCygb8PCnPBwJGDH2hL2GJZhKPRCkHhSDz24OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5108
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
Cc: alexander.deucher@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 2023-08-16 15:26, Alex Hung wrote:
> From: Harry Wentland <harry.wentland@amd.com>
> 
> [WHY]
> We will be dealing with two types of connector: amdgpu_dm_connector
> and drm_writeback_connector.
> 
> [HOW]
> We want to find both and then cast to the appriopriate type afterwards.
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c         | 8 +++++---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h         | 2 +-
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c   | 4 +++-
>   3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 363d91d49a3a..7bd3ec84ff2e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2630,7 +2630,7 @@ static int dm_suspend(void *handle)
>   	return 0;
>   }
>   
> -struct amdgpu_dm_connector *
> +struct drm_connector *
>   amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
>   					     struct drm_crtc *crtc)
>   {
> @@ -2643,7 +2643,7 @@ amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
>   		crtc_from_state = new_con_state->crtc;
>   
>   		if (crtc_from_state == crtc)
> -			return to_amdgpu_dm_connector(connector);
> +			return connector;
>   	}
>   
>   	return NULL;
> @@ -9263,6 +9263,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   	 * update changed items
>   	 */
>   	struct amdgpu_crtc *acrtc = NULL;
> +	struct drm_connector *connector = NULL;
>   	struct amdgpu_dm_connector *aconnector = NULL;
>   	struct drm_connector_state *drm_new_conn_state = NULL, *drm_old_conn_state = NULL;
>   	struct dm_connector_state *dm_new_conn_state = NULL, *dm_old_conn_state = NULL;
> @@ -9272,7 +9273,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>   	dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
>   	dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
>   	acrtc = to_amdgpu_crtc(crtc);
> -	aconnector = amdgpu_dm_find_first_crtc_matching_connector(state, crtc);
> +	connector = amdgpu_dm_find_first_crtc_matching_connector(state, crtc);
> +	aconnector = to_amdgpu_dm_connector(connector);
>   
>   	/* TODO This hack should go away */
>   	if (aconnector && enable) {
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index a2d34be82613..5a8d07a27e9b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -836,7 +836,7 @@ struct dc_stream_state *
>   int dm_atomic_get_state(struct drm_atomic_state *state,
>   			struct dm_atomic_state **dm_state);
>   
> -struct amdgpu_dm_connector *
> +struct drm_connector *
>   amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
>   					     struct drm_crtc *crtc);
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 57230661132b..1975b9d96cb8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -1494,14 +1494,16 @@ int pre_validate_dsc(struct drm_atomic_state *state,
>   		int ind = find_crtc_index_in_state_by_stream(state, stream);
>   
>   		if (ind >= 0) {
> +			struct drm_connector *connector;
>   			struct amdgpu_dm_connector *aconnector;
>   			struct drm_connector_state *drm_new_conn_state;
>   			struct dm_connector_state *dm_new_conn_state;
>   			struct dm_crtc_state *dm_old_crtc_state;
>   
> -			aconnector =
> +			connector =
>   				amdgpu_dm_find_first_crtc_matching_connector(state,
>   									     state->crtcs[ind].ptr);
> +			aconnector = to_amdgpu_dm_connector(connector);
>   			drm_new_conn_state =
>   				drm_atomic_get_new_connector_state(state,
>   								   &aconnector->base);
