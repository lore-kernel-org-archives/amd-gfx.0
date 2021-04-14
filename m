Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3087EC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 13:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDA1061132
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 13:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA1061132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41D366E49D;
	Wed, 14 Apr 2021 13:29:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 990366E49D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 13:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQx8IysQHCGic5ccy407975La9nF48hAwpSNbL92cItwjXaHIDzfKHEHCrlCzmiOSVtnJPKLUNN/itVqSiFdEx3mlw5tVrxvbTQ5Cf+97Qkj+BHyLcDMh21Y2zQnzvG3M3ywRH9N+TpIM05QSwQKa8PZropiQiwQ32pnn5449EHwRbBlhEKbV1h8twafdy7vXugZnfzP9hZWq0hHJfkWzUxxJPsMJd/Hv8dpM0CB/bZxNU7rdBDmJi+T2hkNJLMysxf+SD4KIRFufqCpx6jJSk3+hvdrwD1NejFQfILlxgZOjpzrA7HCUj32vpWsgBLhpQhg/eKP6UyM3rmqhoaOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdryRyfQHy0zZ7kBY7J37oyCDjaQyY8gDP9eK2Mzhso=;
 b=AyRzVigIGYah0W4rRi5lal8wq493v327WxiTGRVa5EJpuSsjObAK7YrPaLn817LkPSq8x3VLYkStQvmsmd8fCn5TSVZN7/HzO1032Ty+G1hn97HPPB/EU5czfm5A2Wf9AVyH+RALIohfIrY7szKjKej7v3lP+QxBxY5ZArh/Q1y8Wz38deyN3G34MtXA1gohNPAh2s9CTWflsOi9n0rgVaXkWKVP+VT8lnnMnJQR4mUCzQ8h2cQ8EkoaDusWQqFHV5p6IW8iCwHz7bg6BoMJ+M9jJk/Yj0uRrio+RPobiLhGkB7HPgN2EKjzaRFJS/1oK7x+fBnw/xheSK8QCCxNzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdryRyfQHy0zZ7kBY7J37oyCDjaQyY8gDP9eK2Mzhso=;
 b=BWjFb5gndh26qF6uTFBO25t2XBq4fpapLplCjLUQPZgikfJ0x9vLrAToVK/4zLhQDWhEffX3J1XFUB+sWJW3gn42KSuXwiMYcat7Uj/v4ZCX4Xi9tWjt7InLqJpHK5oVNYUuQm/1KYGXVxKSRUKu7rCRruEdKzHe7YPFitmYd1g=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4441.namprd12.prod.outlook.com (2603:10b6:303:59::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Wed, 14 Apr
 2021 13:29:35 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::c476:9fdf:664e:4f25]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::c476:9fdf:664e:4f25%4]) with mapi id 15.20.4020.023; Wed, 14 Apr 2021
 13:29:35 +0000
Subject: Re: [PATCH v2] drm/amd/display: Fix two cursor duplication when using
 overlay
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210414000604.3273048-1-Rodrigo.Siqueira@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <1d2f3dff-ad7c-54b5-cf44-fcd72bc5f7f4@amd.com>
Date: Wed, 14 Apr 2021 09:29:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210414000604.3273048-1-Rodrigo.Siqueira@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR1701CA0014.namprd17.prod.outlook.com
 (2603:10b6:405:15::24) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.2.145] (165.204.84.11) by
 BN6PR1701CA0014.namprd17.prod.outlook.com (2603:10b6:405:15::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Wed, 14 Apr 2021 13:29:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c215baaa-44b1-4633-3638-08d8ff495823
X-MS-TrafficTypeDiagnostic: MW3PR12MB4441:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB44417D5E26DDF88106AA18568C4E9@MW3PR12MB4441.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LBilPEJbNJznmQom6AH1A08NEQcxUWIissYfis1WSGwf8LBhmTWjM+745o3mESkyGGze8hLbPYluak1p+H40mukjV1+xddSbZXpHGYqKJIri9amvnTQnuj9cDrMw5TRidk0UEbFGGGreWSaZH9s/6XMpBhvHyfePkYrCo8J/zk6CHniQk1vcEYreqkfDoUIxmPi+yirzkc/qJPxaSmp0fbXxxNUR5iZ/RWxvMYbj0eP/APEHa3gvsFFxmPCSeQ8IjR1KISfHfq0ortWS8/MaXmDOPYP3i88R4aHUmq17DdHopbFoGjljMs4GaNlj0TxMUxhl5jRdUo/KCxMqFgkwao880JFbUiS+ggGwty6eJ1N9EovUICHR+UiOUVKMtfG9Fbhklz0lkJLfZirVjmpcXqRuVdpbOvIKlpuJHULotVsSVNX9pyb3DFLtEU1cmp+PSbDlLivuNIr19Wnnlm1vfJP5Bk/3TpSSNMRdDS6d5WK8l2DDZ+vEIG6OcHFNbnDrfYOfN5AcAK/JU3GEkJp1HnXKlX1SSBtkHeK6v47StSn4TOJoVyqTMQssjOFKN758GWWyl1vCCk9IRbzoTtJlBmBcSkg0NTfX1WZBeJtxMis+qUF3KRF5rXg6TeLVvM+Awf9QRsrIEovFYD9sl9kvXEslYKE9Qth6AalSt8MX7IDA7XMQ4sg5mnRuE2wqSMz2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(6486002)(31696002)(86362001)(478600001)(8676002)(4326008)(8936002)(16576012)(54906003)(31686004)(186003)(16526019)(44832011)(2616005)(316002)(66476007)(66946007)(66556008)(83380400001)(36756003)(53546011)(2906002)(26005)(956004)(38100700002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MUFzeUYwdUtaNUJPTUhJWVRiM3BwSXZLWkNoSURQK2h1Umd0a1VpVlBhOHRy?=
 =?utf-8?B?bkwrSE8wN1RMM1VGKzYyK05MVEtSS1NqandCYXlzSjF3R3FVeVdKa3JTSVdT?=
 =?utf-8?B?TG5SN1BlK2xMQjhUcDlsSFEvWkFuS0lBSHdPTVdkWXQwZmV6QkJ2SDlrS21W?=
 =?utf-8?B?UnFjQy9BQmVMd3lDb2RicHhzR0xNNHFzOU9mOUZ5SW5NbUsxdGpQSTI3c3Bs?=
 =?utf-8?B?NU1ZUVRJZkFvVTlUSXhqaXJUOHZVdEl4ZWZTYlpkN2wwQ2NDTjY5RnV6NlY0?=
 =?utf-8?B?eHBWbnpCeWpGcGFUZWNtRFB4VENRcXRFc05NdWtHaVJyR1drNmFtb0R1enVU?=
 =?utf-8?B?aVJJM3NwYU02QzI2SGFIckJ5RnJDbWRWTG5mMnVvOUhNTjJtMU05Yk1YYWJx?=
 =?utf-8?B?Y0tFOFowY25nc09zbzJpSWx2aW16Z0M0RDF2WGI5NEhTbTNwdHk5a0dYS3FU?=
 =?utf-8?B?VTNQWDFnSm1tT2xBc0h5TDJDZmpBWjZmV24xMUNMMEdIczRYaEtudDUzcEww?=
 =?utf-8?B?dlRqMFp2NUxUYnpKOVpqV3BHMmhrY0QxU1BTUk5KMFpQUXBlVWZjQ25STUF3?=
 =?utf-8?B?S3hyM0EvRSs0Rm5nNEFWcGtVdEpqV210Rm1ycDlMUW5SNnlvREo2Vm9vdmFH?=
 =?utf-8?B?RUZYSWlsVVJxT1JrRzRzNkxyQmJhL1VsM2ptVkN3QzVid0xsbDBYWHRKNFN1?=
 =?utf-8?B?Yk8xU2RjUW16K0JBUnNyQ3JLTFhyKzMveFdad3h5OHRvZzl6dzFzbmdBRVJG?=
 =?utf-8?B?Uy9kSjdOZ3B6WXpGVktrdFJORXpIWFNBdHhYektQVWVyQzJZZXd0TUpxTXlE?=
 =?utf-8?B?bGVjcUo0L1NWQmJhNDRQOXJxTWFRN0V2WWdBZUk1MWxNVTlLUlA2ZUtVZVls?=
 =?utf-8?B?cittYVBlVERBcURhRHlqdHFwZTFheGZoVWpTZ0MvWHJBL0pxRDlqT2duOXNn?=
 =?utf-8?B?VjhtdWZiUzRQcXpSNjhscTZvNFF6QTQ1TVFNdndXQUd0d2RwRVp1N0xLUGNS?=
 =?utf-8?B?dkM0K1NTVW9MZzladC9RaWUwRFZVWnZKdVBCUGdwUEhTVEU1b0g3cG1JdCtU?=
 =?utf-8?B?UmZMaHhRYVl6MUVFWTZHczIrc2NBdzFGVG9SdVArSTRaZ0M1LzNBemNBb053?=
 =?utf-8?B?WTY2ZGRoZzZjVUd6UDFRcTRSYnZVbDZ0dHBMZi82dnZGcHA2SGVNcHBabjRp?=
 =?utf-8?B?aHliL1QweWNsbmdBR2tlUWphZFBCb3VUR2dVTkdRTUxnV0JpNzQrMzdqekNC?=
 =?utf-8?B?V05mOTNxNXdvaXBKcGEzdm9mNDZ5WXZUTFNzOEFoUEYwd3ZaZkpmOWRrNkh5?=
 =?utf-8?B?bUNWaFQzVVAvRVhvV3B0MFF5OHkzbzdtMTZIdVRoVEJOWTNTN2c0WGxJNVFu?=
 =?utf-8?B?QlAxS2JmMC9sK21nOUVPSkppSkd1Kzg0T0tDVWhMRmFnaWhPYWRIYjZuMWsv?=
 =?utf-8?B?aWFMQS9iYk13WXdydGExNlZOZlVSVDc2SEV5R2JGcHZxaXVHUzZXRDBubFNF?=
 =?utf-8?B?MjRHbG9Ud3J5cGdtSDJ3bnV4amlaOE1BTE9HSTVmQzgxOHBESTFhWGtlQk5k?=
 =?utf-8?B?QXo5bFZjL0tTVFNWNUxkRm0yMmlXWHZheTVoZmdwcjROaC9kem9HaTZTQTN2?=
 =?utf-8?B?eUdvVGtJblVoK2tRdm9vamhBdGJ2Wi8yRkl3Sk1QRHRqdkxWQXI3K0RtTVpO?=
 =?utf-8?B?Y1NXNjB4SWdZeFROeDR2SzQ5YkkvZXE4RFY0YkhpT1RTOEJibGV3UHhST01U?=
 =?utf-8?Q?o6f81jNn32gneCSr5ud9zzbt6Hn5dKhZ8tC2Eic?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c215baaa-44b1-4633-3638-08d8ff495823
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 13:29:35.2011 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dERiPBoCsY+RXWZSh+huN8XQ8ZRh62EgsD6LXNVOKQ4O2vEZ35Hd4zSj00rYmgsfglapSMhHa0MYQEWbxcyE5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4441
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
Cc: Sean Paul <seanpaul@chromium.org>, Hersen Wu <hersenxs.wu@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Louis Li <Ching-shih.Li@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-04-13 8:06 p.m., Rodrigo Siqueira wrote:
> Our driver supports overlay planes, and as expected, some userspace
> compositor takes advantage of these features. If the userspace is not
> enabling the cursor, they can use multiple planes as they please.
> Nevertheless, we start to have constraints when userspace tries to
> enable hardware cursor with various planes. Basically, we cannot draw
> the cursor at the same size and position on two separated pipes since it
> uses extra bandwidth and DML only run with one cursor.
> 
> For those reasons, when we enable hardware cursor and multiple planes,
> our driver should accept variations like the ones described below:
> 
>    +-------------+   +--------------+
>    | +---------+ |   |              |
>    | |Primary  | |   | Primary      |
>    | |         | |   | Overlay      |
>    | +---------+ |   |              |
>    |Overlay      |   |              |
>    +-------------+   +--------------+
> 
> In this scenario, we can have the desktop UI in the overlay and some
> other framebuffer attached to the primary plane (e.g., video). However,
> userspace needs to obey some rules and avoid scenarios like the ones
> described below (when enabling hw cursor):
> 
>                                        +--------+
>                                        |Overlay |
>   +-------------+    +-----+-------+ +-|        |--+
>   | +--------+  | +--------+       | | +--------+  |
>   | |Overlay |  | |Overlay |       | |             |
>   | |        |  | |        |       | |             |
>   | +--------+  | +--------+       | |             |
>   | Primary     |    | Primary     | | Primary     |
>   +-------------+    +-------------+ +-------------+
> 
>   +-------------+   +-------------+
>   |     +--------+  |  Primary    |
>   |     |Overlay |  |             |
>   |     |        |  |             |
>   |     +--------+  | +--------+  |
>   | Primary     |   | |Overlay |  |
>   +-------------+   +-|        |--+
>                       +--------+
> 
> If the userspace violates some of the above scenarios, our driver needs
> to reject the commit; otherwise, we can have unexpected behavior. Since
> we don't have a proper driver validation for the above case, we can see
> some problems like a duplicate cursor in applications that use multiple
> planes. This commit fixes the cursor issue and others by adding adequate
> verification for multiple planes.
> 

It might be good to have a brief mention that regardless of whether we 
have a cursor plane we want to reject the problematic plane configs 
since some userspace doesn't handle atomic check/commit rejections well 
when only the cursor enablement changes.

> Change since V1 (Harry and Sean):
> - Remove cursor verification from the equation.
> 
> Cc: Louis Li <Ching-shih.Li@amd.com>
> Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> Cc: Harry Wentland <Harry.Wentland@amd.com>
> Cc: Hersen Wu <hersenxs.wu@amd.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

EIther way, this patch is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 51 +++++++++++++++++++
>   1 file changed, 51 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e29cb2e956db..ac1408d52eff 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9946,6 +9946,53 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
>   }
>   #endif
>   
> +static int validate_overlay(struct drm_atomic_state *state)
> +{
> +	int i;
> +	struct drm_plane *plane;
> +	struct drm_plane_state *old_plane_state, *new_plane_state;
> +	struct drm_plane_state *primary_state, *overlay_state = NULL;
> +
> +	/* Check if primary plane is contained inside overlay */
> +	for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
> +		if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
> +			if (drm_atomic_plane_disabling(plane->state, new_plane_state))
> +				return 0;
> +
> +			overlay_state = new_plane_state;
> +			continue;
> +		}
> +	}
> +
> +	/* check if we're making changes to the overlay plane */
> +	if (!overlay_state)
> +		return 0;
> +
> +	/* check if overlay plane is enabled */
> +	if (!overlay_state->crtc)
> +		return 0;
> +
> +	/* find the primary plane for the CRTC that the overlay is enabled on */
> +	primary_state = drm_atomic_get_plane_state(state, overlay_state->crtc->primary);
> +	if (IS_ERR(primary_state))
> +		return PTR_ERR(primary_state);
> +
> +	/* check if primary plane is enabled */
> +	if (!primary_state->crtc)
> +		return 0;
> +
> +	/* Perform the bounds check to ensure the overlay plane covers the primary */
> +	if (primary_state->crtc_x < overlay_state->crtc_x ||
> +	    primary_state->crtc_y < overlay_state->crtc_y ||
> +	    primary_state->crtc_x + primary_state->crtc_w > overlay_state->crtc_x + overlay_state->crtc_w ||
> +	    primary_state->crtc_y + primary_state->crtc_h > overlay_state->crtc_y + overlay_state->crtc_h) {
> +		DRM_DEBUG_ATOMIC("Overlay plane is enabled with hardware cursor but does not fully cover primary plane\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   /**
>    * amdgpu_dm_atomic_check() - Atomic check implementation for AMDgpu DM.
>    * @dev: The DRM device
> @@ -10120,6 +10167,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   			goto fail;
>   	}
>   
> +	ret = validate_overlay(state);
> +	if (ret)
> +		goto fail;
> +
>   	/* Add new/modified planes */
>   	for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
>   		ret = dm_update_plane_state(dc, state, plane,
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
