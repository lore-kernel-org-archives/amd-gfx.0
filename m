Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E00C48BE5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 16:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C0C61159
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 16:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C0C61159
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 850CD6E04B;
	Wed, 16 Jun 2021 16:11:39 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2064.outbound.protection.outlook.com [40.107.96.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03A426E0DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 16:11:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3Ayqhr205zGNgl4PK2s5yCt7FEJmwkRRroU82Klm7LTy8dkeRE4cvgKHF0LkM2LARvgVg6HWxOzZjn5zhOMKUL8JFE6GOk2e2TrrgRyFKcScsGN/NgzO99k6qASOfQwhbd/yAHashhLv0g3OefqnvJisnXDG3mT0BU3hahKxTu6P6chjvHCfeigcigvL3A2xr+paXFT0YaT+hMy5ztfenN3YRp1VVeJHltcQbhciQDcSCkgkLfWs6LUjE9oRPEibfP6bNLz5H0Gf05cHAmU3dcKuOq9lqWkB3Oo2WpxK8ZAgSMo4VXJK2HO6RDVWcW4BHo/pIlzAMIA0A8mI/XhAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeAx9wJYUZcArwL5t/Rsqu/r7+uSTJ2DS0S8KAiNE74=;
 b=kJweSU7WgyfsVtdPei7MpN6JAz2+2jv2Y5o4fo2GBvEfNBTrc0agT+ZT5UKMyJRPRLExI3bI9gS68S+/YZkAnDCglvi4+opEh3VdNMCcKsDT13Roh41dgLlElOq5t9RivyewLXO/YkxHIFrUwOsulXLVjLj0Ivv6yii7BH0VVcQIKSEHlWVDwwHe6pwLGl/XvgouLde105lIRnJlChEmmLFcR7/rx1QnDeY5OzcIYgIqGnf9xi27bj0f6+IeDavFBGtGH4O+EC3v4T+tkN/VLud5vd0TQQ4tJta9P+khy9YiqoopOeIwssRx5ZdTejEQH4FVeBV3/yhgx75CZSMa0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeAx9wJYUZcArwL5t/Rsqu/r7+uSTJ2DS0S8KAiNE74=;
 b=FsU/xOx/FOKGoxywORxx46bk82i+UAdC6Ox1fBVQwjJi8QMRUw87WRAsvNmRWNrUkTq4Q2FqDP/1as0p4zxc8NBluJ7qGkjpnbBz/8QyJj4Il8MKhTFZLgTSP4wk6gIiS9ppO1+aGQVy3OK4EpKhu9quT6W9P4nR91KPIwoNmEE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CH0PR12MB5331.namprd12.prod.outlook.com (2603:10b6:610:d6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Wed, 16 Jun
 2021 16:11:35 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::d0db:6a71:2ea5:26ad]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::d0db:6a71:2ea5:26ad%4]) with mapi id 15.20.4219.025; Wed, 16 Jun 2021
 16:11:35 +0000
Subject: Re: [PATCH] drm/amd/display: Add Freesync video documentation
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Sean Paul <seanpaul@chromium.org>
References: <20210610124818.216221-1-Rodrigo.Siqueira@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Message-ID: <0bbde9bc-367f-1afc-ec7c-d1f688745fc9@amd.com>
Date: Wed, 16 Jun 2021 12:11:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210610124818.216221-1-Rodrigo.Siqueira@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:404:65::24) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.254.34.187] (165.204.84.11) by
 BN6PR17CA0014.namprd17.prod.outlook.com (2603:10b6:404:65::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Wed, 16 Jun 2021 16:11:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 406d2fb3-12a9-40d6-c276-08d930e169d1
X-MS-TrafficTypeDiagnostic: CH0PR12MB5331:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB53317CFC5E9D7762DB71C30A8B0F9@CH0PR12MB5331.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FSNQbBewJbb+EpMSeB49GFhVv/uxz0eRK3bqYg0LyF+XGmnU0cgPIzdvU3VOIe0iniI72BghjUklEoh8kHYMtNUIr8XhTpVVlPOpEbD1r+WtlqNCw7ZaVABi2/TCx2WmWzFLXFtov4YJ6Ifgl16pPnfUYfrmwJ2VITj3LjKlkq62kTBFI/KsIG5whInHncbc726tHsHKVxNUmyxq9zjGftJwIsvio8CwpsnzclYHBAawHPVM7jDGW3B8cT4OCGEhbOaMkrXLQap+ZTytqeJOQlmK6SJzhj3qm4xJpAflnweW+QEMr8/pLYebVx6SzBzmJrGnICR1PVJGXum42cwKZwE8bBrU8YWVuXbaHpN6MLIJfuUbHZwK29o3RO9OQ79Dsb+fJvynbT7BSWt1UqYb8EkmlqtBhaZPQutyqzVRSYEQM+2zEdmsO0pInZ0gDtHEf0tnpoawXdQbP4TLFwzuvOmZQwKeZ9GDYFVZMl821gGlkqI3FJGSZF/q/Fi1fqA8te8PNArrbP2XKRHAnL6p30oQHM7NFR0lzempO/qCpxzMVvNs2ErhMUOskcNGijL959v1LDKUkLSgZZye33zk17TYY/OKpxKpMNoPT2r8TFyJyb63sWnWQtwFbllcKj2wNrx3xRJew3fG2nR2Wk89L9dd74CiRc2jM+RHCPyjLB9SCfRezawFzw7Yd//A6EPk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(26005)(8936002)(316002)(478600001)(186003)(83380400001)(86362001)(4326008)(31696002)(16576012)(2906002)(31686004)(6486002)(36756003)(16526019)(8676002)(2616005)(38100700002)(53546011)(66476007)(66946007)(66556008)(956004)(110136005)(5660300002)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU9IdEVFUFp2MThNQjUrOE9RcEVMOTRlUVFoV3U3bDkrVjNVNmRzRFlab3Nh?=
 =?utf-8?B?Q2pKSnVuY0MxYUt5WnI2OGtaUkpkOHJCY3kyd1A2MVJ4aVdsbXRUN2dSc05a?=
 =?utf-8?B?SmMrWEwydmgySVdpR3k3anRxZE1iY3FLb1FNWnV4RXJqMEkyL3VSaW40eUsz?=
 =?utf-8?B?WkErSEhYNzRKQ1U0Zi85aXFFQ0tpNFE5UnkzNS9yV1g1cEVMK1Zzc1puMFJO?=
 =?utf-8?B?SVI0QXRTVzVNNDZqSUhNN25XZUdwZllKRGhEYXVOQURyQXFpcy9YTzZGekVJ?=
 =?utf-8?B?WitlMWZzNWp1VUUwQjVoaThlMEtudGFqM2xGbEFIMFora2pwVjR2QktxZ2VY?=
 =?utf-8?B?eENwQ2RCbTR3OHZGS1E1UE1aT0pKMWgwZmFwWmYvZXk5VUxVazNINEI5ZVp4?=
 =?utf-8?B?ZlQzT3VWZ2FwaWladkJkN1ROTkZhTnFiVDhBWlF1UUZ2em5aQUtYZDNEVmdv?=
 =?utf-8?B?Y21xOGpZbVU1L3NOckV5RmxrbFErNElYTlFieEcydVFIUDA1M2RHNG9tTEQ5?=
 =?utf-8?B?ZElhZ1Y2Z2c0ZFNiU1ExcEZ0Ly9yVUkwVlNYbm5tNnVxbDM3TG8vaUxXRkMv?=
 =?utf-8?B?VGpDNTNWVzA3a24rMDRYWDAzdXRsbExycDVWamJwMVorOWpPVDYrMmJEL1Vr?=
 =?utf-8?B?ZFh4M1ZtT2JFUUliYWtOd3kwTUNRTXlWWTdENElDbmxzUmVzV0tQakhMYWd2?=
 =?utf-8?B?QjFCTE9FUm9rY3YxRER2RXA4N2JkTHFVd0dwTEpWb2RJUHRrNVREVm5GM29w?=
 =?utf-8?B?ZHhDVnJpeWwwNmYzZEh0V2VMU1lyeUFqRHMxL2ZxM0YxdWJmNWp5dFowNlpH?=
 =?utf-8?B?QlQvSTNXNW42MjhmM2hRK2h0VXc5K0I5aVN5MmNDTmF6M0NNWWpreG5BVXFi?=
 =?utf-8?B?SU84TlhwYVlITkZrTTU0V2JONW5aWVZxajFRdTJtSHNndUlkMlg4R3VTWDhy?=
 =?utf-8?B?RGhOeWNQYkUvckNlbW1helJZVkh6TnIyQno2MDlTOS9mUnY4d2x1eTdZRUlk?=
 =?utf-8?B?dzNlb0J6WWxwaHlpRTdveXdQOEhxakEyTGVDZnROc0RSUmR0WS9LbEpsYWZZ?=
 =?utf-8?B?cHROMEsrb0FtWFNzbXdFby9RaVk3ZHEwZVdVT21saXRLTE5nUElOT3NyWXd1?=
 =?utf-8?B?Y2ZCRUxyOTl4c0xzVFBvRWZQWFN2Nmtkc1hTamIzNGZTRmM4NVpWWmNzS3lY?=
 =?utf-8?B?QWVBRjdrK0ZNTVh1Z0FjSndOenhWWkQyUjNPWFBBcHpZUloyaVFJNXhBZnMw?=
 =?utf-8?B?YjRnNGY3cUpGckE1OTZKaHE0R3IxUVBLcGRrcFlBTW1IZlNLRFVpZGN2L3d6?=
 =?utf-8?B?L21WOFoxWkJYRnJBb1ZTSVdOZkJoam1WUTdPVm1nYktMbXRDUnZhckZXcGgv?=
 =?utf-8?B?aUVtRkdKSkZrYVZjNEk3T1BDbUxWR2RQdXV6eFN2ZzBxdUM3dE4wdlVIWjF2?=
 =?utf-8?B?Titwb2xzRW5aZjJZNGVrbWFIWVJtdzBXMVk2SkNqTEM4OEhTVE1nVFRYb2tB?=
 =?utf-8?B?dTY3Q21CYzVIN1FYS245T3M1QzhWTzVQNXVoR2JOMlRMMUpDWTlsVkcvRlFu?=
 =?utf-8?B?VUJDb3VpSFI1NkFJS2s4ZUxNV2xPVUVMVFpCYTduQkpzTlhCelcxdEFSNVl5?=
 =?utf-8?B?WDNlZEh0czRvTGhHOVRwY042bUJValdXY3BaeTJtVWtMMGhjSGRWK21ock5N?=
 =?utf-8?B?Sm9xYnNYaStpMENuMFQ4V3pxUU5Td2dJZ0g2c0s1eXdnOEFsT3hMUFlLMUR1?=
 =?utf-8?Q?98tTFO5fA3h+iYK8ZJf6K6GJTrU8DtVckXquUqd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406d2fb3-12a9-40d6-c276-08d930e169d1
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 16:11:35.2358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7pjPjIcvCs4FNTJkwIYR0IwDyqAVgQmNzTuVklw2vKuqVwadNvRCARhlBMhLqB2hF/7T1YREGB8V/bdRUjEhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5331
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
Cc: Harry Wentland <Harry.Wentland@amd.com>, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Siqueira,

Please see inline comments.

On 2021-06-10 8:48 a.m., Rodrigo Siqueira wrote:
> Recently, we added support for an experimental feature named Freesync
> video; for more details on that, refer to:
> 
> commit a372f4abecb1 ("drm/amd/display: Skip modeset for front porch change")
> commit 952bc47fb2ca ("drm/amd/display: Add freesync video modes based on preferred modes")
> commit d03ee581eee6 ("drm/amd/display: Add module parameter for freesync video mode")
> 
> Nevertheless, we did not document it in detail in our driver. This
> commit introduces a kernel-doc and expands the module parameter
> description.
> 
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: Harry Wentland <Harry.Wentland@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>   Documentation/gpu/amdgpu-dc.rst               |  6 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 17 +++++++++--
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 30 +++++++++++++++++++
>   3 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/gpu/amdgpu-dc.rst b/Documentation/gpu/amdgpu-dc.rst
> index cc89b0fc11df..f7ff7e1309de 100644
> --- a/Documentation/gpu/amdgpu-dc.rst
> +++ b/Documentation/gpu/amdgpu-dc.rst
> @@ -66,3 +66,9 @@ Display Core
>   ============
>   
>   **WIP**
> +
> +FreeSync Video
> +--------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +   :doc: FreeSync Video
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 3de1accb060e..561c7ead4a5c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -836,8 +836,21 @@ module_param_named(tmz, amdgpu_tmz, int, 0444);
>   
>   /**
>    * DOC: freesync_video (uint)
> - * Enabled the optimization to adjust front porch timing to achieve seamless mode change experience
> - * when setting a freesync supported mode for which full modeset is not needed.
> + * Enable the optimization to adjust front porch timing to achieve seamless
> + * mode change experience when setting a freesync supported mode for which full
> + * modeset is not needed.
> + *
> + * The Display core will add a set of modes derived from the base FreeSync

Nitpick, s/core/Core

> + * video mode into the corresponding connector's mode list based on commonly
> + * used refresh rates and VRR range of the connected display, when users enable
> + * this feature. From the userspace perspective, they can see a seamless mode
> + * change experience when the change between different refresh rates under the
> + * same resolution. Additionally, userspace applications such as Video playback
> + * can read this modeset list and change the refresh rate based on the video
> + * frame rate.

Maybe add one more line here to indicate that userspace applications can not only read the mode 
list, but also add new modes as necessary, like "They can also derive an appropriate mode for a 
particular refresh rate based on the FreeSync Mode and add it to the connector's mode list".

> + *
> + * Note: This is an experimental feature.
> + *
>    * The default value: 0 (off).
>    */
>   MODULE_PARM_DESC(
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 54dfa245b656..710ee3954062 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5718,6 +5718,36 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
>   }
>   #endif
>   
> +/**
> + * DOC: FreeSync Video
> + *
> + * When a userspace application wants to play a video, the content follows a
> + * standard format definition that usually specifies the FPS for that format.
> + * The below list illustrates some video format and the expected FPS,
> + * respectively:
> + *
> + * - TV/NTSC (23.976 FPS)
> + * - Cinema (24 FPS)
> + * - TV/PAL (25 FPS)
> + * - TV/NTSC (29.97 FPS)
> + * - TV/NTSC (30 FPS)
> + * - Cinema HFR (48 FPS)
> + * - TV/PAL (50 FPS)
> + * - Commonly used (60 FPS)
> + * - Multiples of 24 (48,72,96 FPS)
> + *
> + * The list of standards video format is not huge and can be added to the

s/standards/standard

> + * connector modeset list beforehand. With that, userspace can leverage
> + * FreeSync to extends the front porch in order to attain the target refresh
> + * rate. Such a switch will happen seamlessly, without screen blanking or
> + * reprogramming of the output in any other way. If the userspace requests a
> + * modesetting change compatible with FreeSync modes that only differ in the
> + * refresh rate, DC will skip the full update and avoid blink during the
> + * transition. For example, the video player can change the modesetting from
> + * 60Hz to 30Hz for playing TV/NTSC content when it goes full screen without
> + * causing any display blink. This same concept can be applied to a mode

Nitpick, is blink or blank more appropriate?

> + * setting change.
> + */
>   static struct drm_display_mode *
>   get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
>   			  bool use_probed_modes)
> 

With or without these comments addressed, the patch is:
Reviewed by: Aurabindo Pillai <aurabindo.pillai@amd.com>


--

Thanks & Regards,
Aurabindo
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
