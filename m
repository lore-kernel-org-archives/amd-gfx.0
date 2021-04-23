Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9386C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 00:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54521613E6
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 00:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54521613E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 163566EB17;
	Fri, 23 Apr 2021 00:51:30 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750051.outbound.protection.outlook.com [40.107.75.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F406E04A
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 00:51:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXpXZTIkEFSQ8BUc/j+EHsx77b5N4f/qsyYYT7lz1t0bFQXZ3JU2qxAoJUzGhujWRJlpJQM+uExQ6mXCAFAPwP4yzpHOqcpZQKX3dmUZbaTkxg7qv8y8ANAnVMp9/LR0ySHEYZ5z3cIekVU/f1w51JjCC9/JulZkDme5lIzV3iDahsPX91VKDAlqpQurR5ghuK2JU0Mcr8mq0VFsEXLfN8DzYwPbPoceDVdMkUAO3XnsmBMC/1qpqxlEOwMsQp5cCO3Jsq8ShyQro3kuyIy854OludL2oldpLmKHEvXCnatpPwt9SqyJqp0+29WGk4YDkO3GxKCuuQZSgjBy0919fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfgnWaRqB2E0mvZ7lBsdQh/eWX+rh33R2yANVgHccp0=;
 b=hOO2MnElk9CGTZzGO3C99+yVWcl3VvuW+z1lebBy+WyD1pZOZ4Ni9ly4n5tI5WraIcR0Rg7UefutziYbJNzzuET/xHG9YW+dC6qhoyCRRGBUVdf32p7RXAYLIyeZIIVImqiL9LWXzrJwgD29VU+2a+0RDIMHJwV+LoIy7T+hP6iiSTn5dDlKqlAzANcf7wOwWScxIJ9LwhZtR6Z0O4/sXCkgyGYyGhsFY6oga2s0/kjuPj5Z4Diwu454qIJ6Blzistjzw5WqEyPxEu9HwHZVpk4aQN2DwRoObO3YBEDrrlL7iqG0kQsH4cknbYqzPX47SEjwqQOBYVBrCAn/c0cHSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfgnWaRqB2E0mvZ7lBsdQh/eWX+rh33R2yANVgHccp0=;
 b=qXhT5uiOgNl0ppcYI061GRQTfF3L657EXZA7yHaEZBFh5kzMIWAd42jNy1LlbcYnPd0sUrZSmF6oCzwSiJR8cJe7RFj08sGXbdw9iwlpK9TJMhkZ+8xHzbOcOsUhXDy/Rj38ysfE1pS4+KNi5Li+ebJ7YYJX6AWBhrkA820FZNg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM4PR12MB5056.namprd12.prod.outlook.com (2603:10b6:5:38b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Fri, 23 Apr
 2021 00:51:24 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::98d7:4d47:2cae:38dd]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::98d7:4d47:2cae:38dd%5]) with mapi id 15.20.4065.022; Fri, 23 Apr 2021
 00:51:24 +0000
Subject: Re: [PATCH] drm/amd/display: Reject non-zero src_y and src_x for
 video planes
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, Roman.Li@amd.com, hersenxs.wu@amd.com
References: <20210422232034.1200474-1-harry.wentland@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <5a34749a-727f-0bab-86a0-dc6620182d73@amd.com>
Date: Thu, 22 Apr 2021 20:51:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <20210422232034.1200474-1-harry.wentland@amd.com>
Content-Language: en-US
X-Originating-IP: [198.84.165.113]
X-ClientProxiedBy: YQBPR0101CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::7) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.180] (198.84.165.113) by
 YQBPR0101CA0074.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21 via Frontend Transport; Fri, 23 Apr 2021 00:51:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92a2d9c4-39e0-41a2-2a28-08d905f1eb4a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5056:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5056CEBC23A45C8C02890B95EC459@DM4PR12MB5056.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OAEh0WMWzIQEa+KAMhshjR02N1oOpxrj/4WVLe0Emb4xgVl8gYOw7jJr9qQvDjyX9ZRe6YPxy+IKWWE5IBCANHTdUNK6ID7pQDJwewR0YJx0UNlD/7NY2EzOGEW+nTZWSND3P0yqvkf2stn8PAiDWEBIbDObeH1FVFl9KWnPjxGhaD/IxrjeQQDxUH5L4BBiys8gn/KfdMRWezHnyC/eQ5aGM1K0nxX70FyowwBWutkLKbqgShttrw/Yy/qbiU29kyvEQucT48c3nvPiAMnSXrbl9kHjou4k4SNFCpYuwrSaUyfywaLd3NrWuDMCn42nMWJouZhxnd2fgcMWjjj51D/N/cuUrb2EkY9KiPbVSMfB1USGkGkhQHe007cf3DAXIwIpldLI4NUseCjegHJh7ag6uGTy6/1eYz0KdMqB8Bzu2Z8bxH3nBzAby96/DtaP3SgwD0kRcK9D39JLID/iMuV6ppVLt1DJOw1ThickB8ciKVLn9IVlnoTT5zdLnPLMf39+faK1N2MqOnAzBjrHcy/Sf5FZlxmOMS63htUkDxCWCX7ohEbs2rjM6V+uPp1fhGyfxDHTeESxZv7yvHCsC+yJgNyOLYGWw8eUsLHWDCE9NvOobJ8vspLWtKPMu0KRz44Vft/viiKEYQkMjVBR92iNqYJ6jckQ+ixAAoXz+h74tTP0hOKRV+fZdQRbMzeY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(8676002)(53546011)(6486002)(31696002)(66946007)(16576012)(186003)(66476007)(26005)(66556008)(36756003)(2616005)(16526019)(38100700002)(83380400001)(8936002)(2906002)(478600001)(956004)(31686004)(5660300002)(316002)(6636002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QU94c1c5bWhPWUxnSnMxUWd6aVNtZ1YrckRwdVJnRDZhcTNzVTM2Z3lKczV5?=
 =?utf-8?B?ZUFXbE5lRmVFdUg5L3FEczhUblpwbFpoUk9IeHd5YWRRcElQaCsvUjU3Q1Bq?=
 =?utf-8?B?bEUrZ1RyYUZ2ZVFIcjJydGUwQkttVEkxNWVWNmFIU25DdE5EaTZtSDlubVV3?=
 =?utf-8?B?dnlwaFUyUEwzbGxick4xQVlIdmpTRGo1TkRUUHdtemRpVm5yMmtiMTlEMVFv?=
 =?utf-8?B?bXd2SEFRN3BVOHd1LzVjR3d2a3gvaFpyZllvY056YWk3NTBhYkhtR2VSeVJh?=
 =?utf-8?B?V2xaSmdVNG9CSE1yN0pkbmt4bkVVeFVKNTNSMnJzNVk1MlJqZ1E1SDNPMysw?=
 =?utf-8?B?SEQwVjh5SjJLUFMwZ0VjVi9hQ2NxSGZRcHEwTzZpQUdjYyswT3M4QlAvTHdP?=
 =?utf-8?B?YStHczdTVXorOXFNeTZrWGd3d0Q5bVZCOFYrU01WRFJsdzNZSG5Va1NUR3RN?=
 =?utf-8?B?YXFVdVhLcDFtb29rcHVncmI4VFRoUW15NStiVU16V3NFZHBBOG56RkQyM3Vw?=
 =?utf-8?B?RVR0VlV6UUdlc2kwKzlwazBsbGQ5SENRN3QvQm8xNU4zTy9NMHB0dWtZYlZD?=
 =?utf-8?B?YThPMjB4bnhzNGhNSllLeHpQSjN0WEdsNk16b2F3SnVINWR5L3NFQkEyWFJU?=
 =?utf-8?B?TUp0MEU1WEVUdG01TXZOMFIxU2kwYm90dDZzVEhBMERPYk9mM0JFTEgzYjgv?=
 =?utf-8?B?MEdmbHRXUkNuZW9xZmxxQU8vUVIrQ2ltckZ3bUM1OXFOL1p5OWMwcHRDZGhE?=
 =?utf-8?B?Mjg4bU1IMkxHdHNwVk5kL3c5Qmo3NjlzRG5UVVRPSUFWOGtHREF1TnpzUXFG?=
 =?utf-8?B?WEthUTFRS0d4TjFZMUNNNStHOVhUOEtHak84L1V1dXNUdVJPYVEySEJ3Q0xZ?=
 =?utf-8?B?SnZRSjR1bHkvS1AyeUxvaEFheXpjbzVMM2hNMFF2ZkRYMVRBeXAvZlRuLytN?=
 =?utf-8?B?b3JxZW1OUXRPcEVXU1NnOEI1OGRBYUE5MENXWWNzdUw1Zkd5ZXFaVCtEOXBS?=
 =?utf-8?B?UnZLZTduSGN0eFNjNUtvZUpVOXBKdXA4bTVneUwzeUowWHBadzkzeGpaY0FH?=
 =?utf-8?B?OEJFVS9BZVpvdDRqOEdJck9vWnh1dmNnOVRuSmJreWk1NTR3bVp6ZUxPcCtw?=
 =?utf-8?B?NlE4aWVQekhPWHBkRjAyczlmdFFqT1dGTnQwZWozYUlLVmIraFdDM1BNdVdi?=
 =?utf-8?B?Rmo2YWtVVzhJYkxuc0VQTzlnVVZpbGwwY3p3czgwbERhWGt1ZWgvUkxaNjlw?=
 =?utf-8?B?UWlnTjJITFhhUzVCbkJxVmxQUFl5RWg2cmNRRktERjVGbWtNeExkVXUwVUlv?=
 =?utf-8?B?MGs1enJneTdVN0NGY3RFQUlsVmFJUjd4MTFkczVtMXh5V0V4cFdYZ0daU0tk?=
 =?utf-8?B?bnB5T3VoRS9XK25hY2ZjOEU0UEFGUDZudXRnQ0tZK0pJUldxZDRVMm04V0FC?=
 =?utf-8?B?bjB5QmpuL25oUXV4dXFNOGUxWDBWS2pLQldrZ3JpUlRtTWo5N0Z1emdjdFQ5?=
 =?utf-8?B?RGJueXVOc3c1US92RXN0Q0RoT0tvRUNqZVZSejJuVHpYczNpVlRCK3BRd1lO?=
 =?utf-8?B?Yk5LaFQxUG1XZkdwQUE0VWFOMjhWdFo2QXFjYklmTlFTazMwRnFzcGJCSnFB?=
 =?utf-8?B?ZUtxaGhyR2lHM0JqTENUL0JGQTZRYWFJWXc5MWhQOG13SDkzK3VSbXY2NXFk?=
 =?utf-8?B?Tk9HejFLYmJqeXZaUjA3Vk5CNzByN3FoV3lFbFlibTBocEtCbm05UXpjSURO?=
 =?utf-8?Q?IDuVBZc5j1JJ02TvNidHeGg/AnStUSVR033yjRa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a2d9c4-39e0-41a2-2a28-08d905f1eb4a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 00:51:24.3982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ln3JeN6iY7ID1IsWZj3qTB8WG+WAJTkeXqaEj9bLZz3/s8etFSd5Z3AfJF468pvJ22M/2zN+L+kUWjFJ45kq3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5056
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

On 2021-04-22 7:20 p.m., Harry Wentland wrote:
> [Why]
> This hasn't been well tested and leads to complete system hangs on DCN1
> based systems, possibly others.
> 
> The system hang can be reproduced by gesturing the video on the YouTube
> Android app on ChromeOS into full screen.
> 
> [How]
> Reject atomic commits with non-zero drm_plane_state.src_x or src_y values.
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Change-Id: I5e951f95fc87c86517b9ea6e094d73603184f00b

Drop the Change-ID on submit.

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 4b3b9599aaf7..99fd555ebb91 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2825,6 +2825,13 @@ static int fill_dc_scaling_info(const struct drm_plane_state *state,
>   	scaling_info->src_rect.x = state->src_x >> 16;
>   	scaling_info->src_rect.y = state->src_y >> 16;
>   
> +
> +	if (state->fb &&
> +	    state->fb->format->format == DRM_FORMAT_NV12 &&
> +	    (scaling_info->src_rect.x != 0 ||
> +	     scaling_info->src_rect.y != 0))
> +		return -EINVAL;
> +

Would like to see a comment in the source code similar to what's 
explained in the commit message so if people skim through the code they 
understand some of the background on this.

I'd also like to know if this is generic across all DCN or specific to 
DCN1. For now at least we can disable it generically I think.

With the commit message updated and source commented this patch is:

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

>   	scaling_info->src_rect.width = state->src_w >> 16;
>   	if (scaling_info->src_rect.width == 0)
>   		return -EINVAL;
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
