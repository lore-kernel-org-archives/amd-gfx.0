Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CFDC636CC
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 21:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CF8A10EC37;
	Wed, 15 Feb 2023 21:28:50 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E87A410E304
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 21:28:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOmjyKUmarZVnkRxkte/Bej4WlOEAEuSnVG8onPr1WC8j4fLLwYSk53O+4oniA1Ld4lginHO6pVuNX8aNtrekH1UmpT23R0BLLwfuCz3L9XSsxDuS2QLmrFThy+wAeWZ2Y97c7Gg8aJJj8rSKGVBf1Cj7Say3Fvm2RjVRtNC9F7BJ2LLXb3chqbfaH9Ws1lj3gIwOuWh4Fhw89pBsHsTYRk78vf183HqlorLfFIIfKXMGiEAPTgghF3PiLwCYl0nqbu7e+viXccFDkomiWe5zXY9a+J+B1VWEe0xonuDZtmk1wbHdxycyuBVDCLgxUeJzKhb+BhGJJmweFwG2w7doQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3ODnyIiv4DFkE/Z5zFwZ4MniAEDQACZiQ/UlTAxrCQ=;
 b=Uenhbxqy2/dwPdLEfN9I853gzhfUfNonN0bqIGUfJQcQPVW41qP5ZA5e1WoYSmI7OMPkv7qgk1QYllRO3QK/2EAvFSikgh2ERM9x7RWO/9J17d0/7hoLUNltsib6KMujHechPoD+8e5YAlcSpmDpAe4N/4UUqvVS8942AqjzRj8FvWaSe47V5fW7vaCL6MpCgV/LUqU45wU5NQx/CUecnxhzHCkyV3SNlVCljFd6Qdq8g3FqN6ZVdn8RquTrtbO3COHMBFgNGzB2H3/7OEHSCimv5kNZfOmfLQdr17T8xkhNQmRznKn1vssWBzg5oHrq39ffR1l0IyNNWWnCxNKbMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3ODnyIiv4DFkE/Z5zFwZ4MniAEDQACZiQ/UlTAxrCQ=;
 b=XCV5jeaD19Y4nFslXjmQv3+hOOjoAAwwA/bTWJDU+JDCtJnKDAQh1W4fwmzPgDd7Cy6n3gZih6Ds9O1hOmTspNjbG2be2Pm3K6Dq8CGP9MwVXWXDwFY/UdMryvh75GgrR96FwAdjY00kv3ZxCPjA4hgg9PvG9uRBvclYKoqSTD0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2934.namprd12.prod.outlook.com (2603:10b6:a03:13b::25)
 by PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 21:28:39 +0000
Received: from BYAPR12MB2934.namprd12.prod.outlook.com
 ([fe80::8553:7d65:4418:4e6e]) by BYAPR12MB2934.namprd12.prod.outlook.com
 ([fe80::8553:7d65:4418:4e6e%7]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 21:28:39 +0000
Message-ID: <6cdb5e26-b549-b6c3-e26a-f61c75cdc192@amd.com>
Date: Wed, 15 Feb 2023 16:29:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] drm/amdgpu: Select DRM_DISPLAY_HDCP_HELPER in amdgpu
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230215210629.382482-1-harry.wentland@amd.com>
Content-Language: en-US
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230215210629.382482-1-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0338.namprd03.prod.outlook.com
 (2603:10b6:303:dc::13) To BYAPR12MB2934.namprd12.prod.outlook.com
 (2603:10b6:a03:13b::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2934:EE_|PH7PR12MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f1a5a5-f4d0-4500-8f55-08db0f9b9a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +RpKzU5YyGQDlrVRZn5VVbriVb8NvrVEV/bo8Vhjs+q3Gfd9GaBcLsgTfiNgf2p0L3zzDm3te3fzQpWh/8/gSvi0h2TRrSI05jyfgVVQrm16sCOgdRhrmRozBbLpHs2yDd5PJV+CWjHZjfJ9Uw1qZ/Xl/RbYIJ6DLmxhMD5YSFIjoIj4f/SnFLcqlPdxUy9Qzgz+sREgVv3pUT8tt2wssVk0tsfpEI3d7tVQZLOl0n5c8TRbWKLn/gUGK3L1asSskRrmixLwlQV3zsacHUCPxiPOGJrZLHPefN4votrUoKfKQOrk3TF9iCqG2oOh98/FYjU67Qcs2LC/2OxisrDFH2OlS/Uru3wpAF6Dn5eThTOyWgzntMTMbxKtxUeeOdD043UXddsoGu5Z1cw//LCFlGe7vdYR6ddLIxOdZoEUuoqAoga4ZfBX4+G4+el3Qncq/nOZx/olqKR07vaaQVa7a0+Y6oIKt7uKaPqFEE+2PfP+owM19bRZMLcIYw899Q6nRsh7/60R1LEiWoIffwCDgUT2qURNezh4PQqNlC+GK+pXYehgikolVGMXfz0np5+L0lmSYfApDHfBlrYCNCpb+5DCevElgeKuFIKu2POxzWGMXXEHBQkQX4a4b/bs/Hi7rcidu4XYoFuLYcJTwekOslld3p0uMG3O82p14g1yYSpw98m+mXSp/amJM1mByQMPytRUyVnkd1yqmdlJ5rcjQc+U+ybGO+7HW/cRdZt7apI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2934.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199018)(8936002)(36756003)(41300700001)(2906002)(5660300002)(6486002)(66556008)(8676002)(66476007)(66946007)(316002)(478600001)(38100700002)(31686004)(2616005)(6506007)(53546011)(186003)(6512007)(86362001)(31696002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eERPdXpXeW45OFBVU3JRa0Q2amF5UCtsSHF4cUZFUi9tUDB3em9NZ0J5YWs5?=
 =?utf-8?B?cHJER1NQUm5qTHdKeFJQaHAvbys1RHNhKzNPeTQ5TTJDU0FzWWJtREhoV3NK?=
 =?utf-8?B?WFhjT1NUT3NrNWFXMWlleWZGM3UwZERxbUdxWXRUVS80QnlEMFJSTEF0Ti91?=
 =?utf-8?B?RVdsSUlkMEloV1lVM1Q4VEttcmwzVHNXMVljRFJWWk5pdE93THJNeGdVSUdH?=
 =?utf-8?B?SzUrQW9QYmpVODNkbytaT3lKcHpydE9mdkhqd1NLT092d3J6UENIZnlsNDZX?=
 =?utf-8?B?M0ZRQ1E3dUl3Nko2cU9LeHNYM3p3dE53Z2g0a0RGRlV4bkYvUUpVc2xDU0Zn?=
 =?utf-8?B?Q2RmeElDZHFzOHhUNm9Qbk9kblVXOENmYWYwWXoyMi83WjE3R1pONFFTMzNi?=
 =?utf-8?B?S3JNdm5rT1JzcWwvbW9sQ3NJKzJybXpFM3RJMXV2TGJXNTFSUDVyK3Q4KzdM?=
 =?utf-8?B?RjBod1hud2hkYXp5L3FMNUlXK2xmN1lvbVk0SVNnQzhIUENQdkUzdXFEOHRU?=
 =?utf-8?B?MEkzYmlHVnhxYlp0MXkvbjdmN1ZxaFZPZjExaGtBb1JkTVNUVWRWL0J0ckxu?=
 =?utf-8?B?VFB5VGliaDlIMkJPODMrbjNEbTNOMzRlUTlESjRqVGtBNE03WHp5NGJ1K1Ji?=
 =?utf-8?B?NEY0UTlXSUl5VVNvT2h1RjNCSGZJdmYxcFJzOVlPWndlZkw1SFJBSGxWUHJY?=
 =?utf-8?B?WEREVjBsYnJoclZDdVpTUEhPeTU0OE80YTB1OXh5dEIzRExRVkk2L21FZjhv?=
 =?utf-8?B?UGR4bk9uODlSUW44ZXh3YXp3My9ZaDhCTUxHM2tibmFOczAxbTh2ZC9BUjZ0?=
 =?utf-8?B?K1RrdFJhc0dsQ1VjZDRLODQ1Vmh6RWp4V3V4aEpKdFozYUpVaFVQYzZURWZh?=
 =?utf-8?B?VzV1Q3h0MEZZUTAvOVRqMkp6ZXFkY2xLT0QxVTl5cFpPc01lYU5KMGxkdHBB?=
 =?utf-8?B?OEJ0VGhWY2p5OFViSmxDQnEyVEw2Z3FhQ250MllLRTBYSWpuWHZBbUw0TTBz?=
 =?utf-8?B?M1hDUlcydVFQWG5QUlBjcXBBazlvSHFwU2hTdnF4Tk5weVJtVW85SWNJMThL?=
 =?utf-8?B?OWd6eFR6dy9BWnFuby9xa3cwZUxSTjJZY01Tckw1N0R1aVFGRlA3SnYxT1Fk?=
 =?utf-8?B?SUo1S2JUQ0tVQ1pCQjlNeXhtbGVUcG5heEhNclkya3R3NWZuVGRhYTlBQmRa?=
 =?utf-8?B?NUsxLzZ2aEdOU3FFa0FQVFlIQndGSGZndGljMFBEUW4vR1dPTTMwS0pYNy9X?=
 =?utf-8?B?UjVQVDU1bFhkRlh1RTdyYTEzZTQ0VzJ5eFFsV1owQnBTaUVlck1IUWtDeDFG?=
 =?utf-8?B?aVFVelRxZjRhL0FuZTJxWkpURTlJMmYwTXZhcDF2MzRWK21JMWVWK2FxV3VC?=
 =?utf-8?B?dXBEbVFPWDBXN3hXdjdHSk8yRVpvRzV6aERlS0JDeENUNXdVM0ErNW5kS0NX?=
 =?utf-8?B?TGlIRlcwcGk0dnZuWXliTnkyeEsyRDNlbGhRSVZKQzlncHFWenpvUUZsNDJ4?=
 =?utf-8?B?YXMzV2xVZmZ3Y2FqdWtyRmcxYnlpd1hCRGpCbUp2dE9ZbVlxdzQzSlNQL2pV?=
 =?utf-8?B?MG50SVVaMEdnRFpQZXNrWHljWmc0dnNIR1ZRMTFHcVl6N09SUWNNMVp4dHVu?=
 =?utf-8?B?T3BUUElLRm5naFZCWlJjaFUwQXloQ0hpWEpxT1YrU2NrbStEMGFTMkdvUERC?=
 =?utf-8?B?SmNWczBMK3hPeVE0dU5WaTBkYVA4T3U4SldMaDNjMVBaNjZVU29DOExwZkow?=
 =?utf-8?B?Sm1qUnhQME1YaWpEYVVmOXBhdU0vd21icGlzeUhaQUQ5QTh3UDExbGhCOFB1?=
 =?utf-8?B?MjdZdHZCbk9jY3IxRC9wMTlLc3JxbVN0UDJjSzM1bGNoaXBhbnZoR09BUjE2?=
 =?utf-8?B?SUFwV1hXY0YvQUNtVllLcFVvbFZXYnFsM21jdkQwNU1mWktPaE1UY29vVTR1?=
 =?utf-8?B?V3llTTNtVjNoMUNmZXFUZ0drYWNtSmxKWjJJdlQvR3ZGZEw2YUh3TUpvNUJm?=
 =?utf-8?B?VmpNTWI2clpYMVduNkNBejdZMUdsTjFSeElTeFBoM2U1VE5iS3AxSVV5ZG1W?=
 =?utf-8?B?VzZTNmVKVVJsb0d3aGhlR1hKZGw5RDhqZTZYZnV3T1ZycjNscllzaFVMSWtG?=
 =?utf-8?B?cVZiT3orREFtdVdYd3VWYnd5RVdkTXp1cmlFNXdrZ2h0Z0JBSytVVWV5VDFt?=
 =?utf-8?Q?P+Adb4ocxWrNMReJFHEuZw9MwMcWzblUMmMJTNaoOBom?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f1a5a5-f4d0-4500-8f55-08db0f9b9a8e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2934.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 21:28:39.3876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACXSEj5KZKcY/xkgdbAUeQbIk5YrjKuUa+e4O5USyLf6pU9K77uviCyrvUfk/uPLw50iMPoFYQGy7B90S8nrHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967
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



On 2/15/23 16:06, Harry Wentland wrote:
> Keeps this selection with the rest of the DRM HELPER
> selection.
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Kconfig  | 1 +
>   drivers/gpu/drm/amd/display/Kconfig | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
> index 5fcd510f1abb..c9ef04158081 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -6,6 +6,7 @@ config DRM_AMDGPU
>   	select FW_LOADER
>   	select DRM_DISPLAY_DP_HELPER
>   	select DRM_DISPLAY_HDMI_HELPER
> +	select DRM_DISPLAY_HDCP_HELPER
>   	select DRM_DISPLAY_HELPER
>   	select DRM_KMS_HELPER
>   	select DRM_SCHED
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 1cdb379a90d7..195ad3ca5aa9 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -21,7 +21,6 @@ config DRM_AMD_DC_DCN
>   config DRM_AMD_DC_HDCP
>   	bool "Enable HDCP support in DC"
>   	depends on DRM_AMD_DC
> -	select DRM_DISPLAY_HDCP_HELPER
>   	help
>   	  Choose this option if you want to support HDCP authentication.
>   

lgtm,

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
