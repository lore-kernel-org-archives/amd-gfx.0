Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5CBC27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 20:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95B2E10E071;
	Wed, 26 Jun 2024 20:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="duf4a+Ao";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E9E110E071
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 20:19:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2ti2KFWVlR3rALQC1rUbMdwLrETtcgcRJH9ogHKiPAbsF1c4p+teX05aCLMYBtsq9NspU6OC4b14jIy/+tObMU7UnHa8fSEghncN1uM8BtFJwtbZ5atEfWPHJAGbz/TZZM6vpTktUvWPwmECuch4KyUD4e2Y6dA9IXdgRBQQdtJ9yuZjQETyqbk7+pTiyf5DPu7zzMsZ2wJwQ2n4Ul7GGo2RfOakUeO8NtGWUcUoPTm4nH02EKfFdmVrNV3twQNmXIvBfoMCHtftwvO69CSswt640xP5YiDTeLAImHimFh6LssWLTSZKQ8pQlclNptRdIYr38i60xLFYxYfZjSrxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdFY60m8+7kUP9IisiM0rgp6dQ1iPRu4hilIkhI6auw=;
 b=bjLbwd237l9SorP3yLxd427q19PA3UDFZo4Te0x5VvMS85b6aPfWy8NPshhgk/Yiw64flt7NSIpUQUpgl3VNurfSoYLbw79oTxT590FgZ8OC8ueW5S60B3KpBmxjV+q4f/VGMlKNbqFYBbjeKpTyrEtnC4e/tnG7cfuODH6Ss7C8BcRzu5cgi/mI4xQLjT2RnylBm3MwZtdlLm/heGz3d8yg6J+t/4KB5vSFKOM9lOcS7RvgzM1CKDlfLr0SNPSX01YWON8UZQixcbFu2pZ5V0U842Begpc217T11pfqVAcZbNtme7gyK7LgY2qhx72uqKV6Sf8E7C/22TGhuLNXIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdFY60m8+7kUP9IisiM0rgp6dQ1iPRu4hilIkhI6auw=;
 b=duf4a+AoDHc9LtWagf3p6QxWyR9nncFkoMw+Iqqv8hIS2vcUau5nrLjRKUDw7FyqpadE4XzAGKFXQ0ZrB7WmrYfPZ/aLhXluXnSxnYvltl/SdOQ9vAOBv6snVzvpeXeLQIJDftIaz5JZtBlLFP8B11ycB5VfDWu56foyTTOl9uw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 20:19:53 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%5]) with mapi id 15.20.7698.032; Wed, 26 Jun 2024
 20:19:53 +0000
Message-ID: <6d873cc5-7e44-464f-a8d7-db57f071e885@amd.com>
Date: Wed, 26 Jun 2024 16:19:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] drm/amdgpu/display: set plane attributes for gfx12
 correctly
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>
References: <20240626183135.8606-1-marek.olsak@amd.com>
 <20240626183135.8606-11-marek.olsak@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20240626183135.8606-11-marek.olsak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::28) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|DM4PR12MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be1c945-dfc8-4a83-cade-08dc961d5698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|1800799022|376012;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0w4YzV2a2NFc1hrbXlTR3AycFJIL3lQSzNKeGN2ZmhpNUpsNUhMUHd3SWZU?=
 =?utf-8?B?dzltNzdNcExuSDBaUXArQi9YQThlbWdtN1lzWkFZYVY0QWwxUGVVQTVGeStu?=
 =?utf-8?B?dkpmWm9zS3VmcmM3WVlRQzAzQ0E1VFh3ZmU3Tkg4b3RGSUl5L1VqWU1mbndr?=
 =?utf-8?B?MEJEUndlOTdBSm9xMFhsUHcxMVdRS3BaZTlZV0R0NUlIRjlJRWNJemExcDY0?=
 =?utf-8?B?T1pQcDF3YW5jSkJ1K3F5MmxvWk1Zc3g3MFNnYU41TGxtY281NWFJcDVZUHZQ?=
 =?utf-8?B?WlltZ0dSR1Mza1licTlib3V1UGhsakcyeGkrV25FSWY5Q2daN0ZYKzZpYjJT?=
 =?utf-8?B?U1pmRzVibEtoYWFncHZCbkFZdm1CeGdBM1FCSDltb2dWd2pDYk1uZEFXMWJU?=
 =?utf-8?B?Kzk3NUxwVkZWb3hhYVJ2VGs0ckVWYnBMNEVJSlhodlRuVjRKcGxpRkNBTWZV?=
 =?utf-8?B?UmkwZTdzZEVVTXBRVzY3QjVYOE8xUEZTRnp0OWYyVU9NKzhHV3RhbktzOUVp?=
 =?utf-8?B?dHFwalNqMXAvREx6d2VnRE1nWWJwbXZoVmFxYU1NdmY0bUFQYTdZMkFPNnB0?=
 =?utf-8?B?YjZrSFl6TVpCc3BvSk16MldML0xKYjJWT3BKNWVTNzVCc2g3T1R2blhzOVNB?=
 =?utf-8?B?QUwzc0tvazFaVVh2eVdFb0ZYS2hraFNaK21jNnlBMHJ3bkc0blNFd3MrQURV?=
 =?utf-8?B?ai9JeTNITTdkOGxUam1Ja0lXeUZCbDh6bnF3TGM0S0JsNWVVSHBNNlhVT3Fk?=
 =?utf-8?B?UlNNcy9rdFJ5YUI0bTJuZ2YwU1V6OG4yZEFjZnkvd05FNDZHRVE1VUliUHA0?=
 =?utf-8?B?TFgwdHBMcnhBc0xIOHBGOGZibHAvMnhqVjJHTVFTd0NrNWZGQkFVaVdOL2tF?=
 =?utf-8?B?eTJQYk5PdEgyN2pOVmVnTzdCci96OUt0ZzQzb2YzK3RKSGV4MWdlMjV0czJ6?=
 =?utf-8?B?N1k5aG9qVnhneGlxcks2WG5HSmtzQzRLMVdteUticjdHYUFVMG9DMmhPQUl4?=
 =?utf-8?B?bnVidCtOaHEydnB3WGpiMmNyU21vMUpUWUhpK1BnVVRBUDdmcnpDd2ZYYTRL?=
 =?utf-8?B?WXBzWUhMcDFPSTZEM1FkUVZiWFdzRitRdnFkSHpJR1BCdWZORVhucHpsWHAw?=
 =?utf-8?B?VDBxTmQ1WHJFam55VHBCOXhreGI1RjZoTDNiZnhuR3BsMXBKdmI0TWduVmFZ?=
 =?utf-8?B?UXdIUVFHVFY1RXExdk9ZVTY0WHRUVFRTUnpwdG1xNUNRanVKbWI3TzU5bzdy?=
 =?utf-8?B?bkhiM1U0cUNWT3hjaWl3dlNzSGZsaWRWTk1HeCsvcHdoNEIwRU9qYmptSGpD?=
 =?utf-8?B?SUR4U2dES01UYmR5RlFUSVoxM0dQZlh1c0VXVzJVU2V2aW9MZXgxem04UmFr?=
 =?utf-8?B?WWxwb1pqak9DRjFObWoyMkVHQUttN0JGYTlRTklRYjJvalJRUkdxQjZ1MEVJ?=
 =?utf-8?B?Y2xuZGZPQkZFTnd4MGh6Q25tOVMwTzlHVnF6K0dHMk5OU21UbTdHeEVEOFlL?=
 =?utf-8?B?WDhxcXZjWG9RdGpSWFR0dXFzMlpXMHhLZ2ZDL3VtYlZoeFVBYW13N3h2ZzNa?=
 =?utf-8?B?ZkJDSm16cU1UL01KTE15WlRJT3kvMmRVeTJxbFhMak9UeFp6NFpxcEVURVV1?=
 =?utf-8?B?ZjJaRzliQU54QkMrYjdIRnUvMVZXTzk2dTQxRURlL0hCQ2hxUHVUc20rendY?=
 =?utf-8?B?SFF1WnRpWDVRMXJBalVES0x2azVOSjBJWUZNM2pYVFhZZlhiWWM3V2t3T0h3?=
 =?utf-8?B?MklKcWhGVTJXVzZoN05VK1pETkRWdzJ1UFRIakJsTzhxSkFLZCtpZ0RHM2ha?=
 =?utf-8?B?TlY5TnU2Ymk4MStiQ3RpZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230038)(366014)(1800799022)(376012); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUd3K0U4MmYxRHJwL2VzV21NTDlQMkplZUppWUt0Q3ZNYTIycmcxeUZNNUFE?=
 =?utf-8?B?SU1nRklGNEM1NElIbHpDNlRxc0xUTWpKWGViL1NndGRnL2k1NkdEVldYUU9z?=
 =?utf-8?B?L01WZFJnYjlKaXFTV2JzNmNCNzY4Smd0ZXJ2UHh6cU1ZaG9EYy9GemczaC9l?=
 =?utf-8?B?S0ZHK1FweGRmenUybHgxb0dsbUZTd3VGVFVLYklTTWJBS3A4QjB3VmUyVXpW?=
 =?utf-8?B?bmEvVHpqWUxUT3ByaW1BOVhYTUpjWmtxK0xuN1lqaHpTUHkxUk5xMlJvRWZr?=
 =?utf-8?B?dHJ3RGRjMmNJTFNyK01ieDZoQWlNdzZvMnV5QjFUZFNYcnU3eHRCQ25JNTEz?=
 =?utf-8?B?VExFR3NHVFFhTUgwcitGRktqVUYyMW05ZjdJYXFpeHZhTWtYTm1tUjhOeWJX?=
 =?utf-8?B?SjlEN2pDMHczWGEydGc2d1UyWlhmOUFIcUFTL0tsT0tOaHBmdWZDc1hMSGl2?=
 =?utf-8?B?b21tNjNmUUxHTjhpUTRlOTYzcEo2cmh3TklmVGs3TUVoMTdvZjk3WlVva2dI?=
 =?utf-8?B?YUNDWDQ5NkZaRktPSDhtT0tqT1FtNUlTQ2pIVnFBSlBFbGtyWnJNdUxnRHNW?=
 =?utf-8?B?WVpra2xVQVlzdWdabi90UENGS29laThMbnlBRlhXRGp3aUdoK1k2ek9SMWpW?=
 =?utf-8?B?c2x1eFVXVW5VcEsyWGtocUdhZ3duMjRlcHNtSlRYZUZWODIwUkdoR1phcjBn?=
 =?utf-8?B?dUZxb2JtTjZybUNHakR0MThyZUcrU0xWRnZZMnd1QUR4aHplQitlVGlJbm9z?=
 =?utf-8?B?TVd0ZTh0Rk5waTdIdFdYL1FzYXBwMGhLSTlhTVpUVzBtNkxVYUE4czBGSHFi?=
 =?utf-8?B?dlQ4R3YvVlNhS2Zpa1pqMy9PM1ZIYjFzbzVNWXo5MEVhWVVlbWgvUGFDWTRw?=
 =?utf-8?B?RElTcHgySTdBdFFPUmVjcm1VSjJaTE1YQlZialVROGZWUUZjSmtHbzBLaW5R?=
 =?utf-8?B?dEo2VUZvODlnRmJ4WURkZ0hLYnFKcU5veGVrUWZrU1VCQkpGVStucjhNak1F?=
 =?utf-8?B?U3M2RjNGUUtTbXNlU0wvQ2Z0dnIzdEo1ckJIUlYzWGlRMExpek9YQ2xMNzJX?=
 =?utf-8?B?OUtab08wWmNhWGtuRGM4SVRmeXMydHVwbWVpbzVHRXQwS1owcmEyREoydFNL?=
 =?utf-8?B?eVc1NGZ6dHpTMGY3cmhDWlo4ZU13a0JvQVRnSjhwS0Z0UWtwYTUwTmVqQkE5?=
 =?utf-8?B?ZTdhdUNkd2Z5cFVqV2dKL1dhNHUyY3JRZHVZdkk2dUhtbnlPMFZscHNIL294?=
 =?utf-8?B?SjhDdkZ0bHFVejhuMDVIZUk2a2I3L2c5TWVMczk0cW1Ua1NLSW9XdllSNlVr?=
 =?utf-8?B?VVVhOTVuMm1uRk4vTm5FZ2ZhVHBueWZiZXhKWWZpNjBVTTd6TjZuU0oyU3Q1?=
 =?utf-8?B?aW1hZEpES003cVBnUllYYm9hQjJzVmNwTXNITXd6NGVuWnY2VGMwQTVpRGZj?=
 =?utf-8?B?bEtya01ERUhhRmczWGpqekM3REtCcG8yczRDTTVzanpEdmFjdkU4NG9XTk5M?=
 =?utf-8?B?aGczamwrVDkrc3FFWURWRGZLd0hjNUZhWmV1dElscm1PU2ViUXhZU05rSkw2?=
 =?utf-8?B?QjVVZUY5UEZ6dzZUeW9JMzd0cXdWTU9LczE5VnE0cnVzamNMU3dXRFczc2Ev?=
 =?utf-8?B?SzkzZ25lWTFNd1g3QnB1MWtUSHIvTjYyRGU3N2h1ellEOU8zNU5wbk1iSUo3?=
 =?utf-8?B?QmRiVlRVQUtHclBIM1RxSjRaVkNTNW1zUWYxMWVmZmNHVFhhbGMxNXg5c0dB?=
 =?utf-8?B?MkYwS0RCdHQzTTg0ckp2L1FqZ2RDWm1DdytJOFI1cytFQWcwWWw0VFZLWFRG?=
 =?utf-8?B?OVdaN24zYjFYZitjcVBmRmxzdkFnMjFDQ2F6S05aT3BoVkVzcC92VkFMbExt?=
 =?utf-8?B?NDBQRHJwb3VPakwrQ25kSGwrNnhQeVNtNlZXT0c0N1ZjdUI0Y2x5YlhMaTVG?=
 =?utf-8?B?MURKRlZqOWRlRGZQVTgzMkU5eWNnb3dIYTFLVzZQNE9wRTFBcmFYRmZadXlo?=
 =?utf-8?B?WjYwV25qUkFiVW15c1h2S0JyT0phQXVoTEVZUnFEV1ZuS0crRkppVkpIdm9T?=
 =?utf-8?B?bmZvN0l0d0pqVUtxNjR0NWpKTTNsQXpub2FzNFVob1VGQjRTQmZrS2VUZ1Fl?=
 =?utf-8?Q?x7R7l3CS//0naHI1ATkOggmE5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be1c945-dfc8-4a83-cade-08dc961d5698
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:19:53.2497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoz/FW74mxfOXgseItiVA0OK2mKRKx3iRW+gytzt3v4BMchbC6fsVy2wK0q+SYV0IkjAkpGyBHXGjy6qWk6zsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937
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



On 6/26/24 2:31 PM, Marek Olšák wrote:
> It used gfx9 flags, which has undefined behavior on gfx12.
> 
> Signed-off-by: Marek Olšák <marek.olsak@amd.com>
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 50 ++++++++++++++++++-
>   1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 5a6a21e28548..e13938e01b70 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -352,6 +352,46 @@ static int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct amdg
>   	return ret;
>   }
>   
> +static int amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(struct amdgpu_device *adev,
> +								      const struct amdgpu_framebuffer *afb,
> +								      const enum surface_pixel_format format,
> +								      const enum dc_rotation_angle rotation,
> +								      const struct plane_size *plane_size,
> +								      union dc_tiling_info *tiling_info,
> +								      struct dc_plane_dcc_param *dcc,
> +								      struct dc_plane_address *address,
> +								      const bool force_disable_dcc)
> +{
> +	const uint64_t modifier = afb->base.modifier;
> +	int ret = 0;
> +
> +	/* TODO: Most of this function shouldn't be needed on GFX12. */
> +	amdgpu_dm_plane_fill_gfx9_tiling_info_from_device(adev, tiling_info);
> +
> +	tiling_info->gfx9.swizzle = amdgpu_dm_plane_modifier_gfx9_swizzle_mode(modifier);
> +
> +	if (amdgpu_dm_plane_modifier_has_dcc(modifier) && !force_disable_dcc) {
> +		int max_compressed_block = AMD_FMT_MOD_GET(DCC_MAX_COMPRESSED_BLOCK, modifier);
> +
> +		dcc->enable = 1;
> +		dcc->independent_64b_blks = max_compressed_block == 0;
> +
> +		if (max_compressed_block == 0)
> +			dcc->dcc_ind_blk = hubp_ind_block_64b;
> +		else if (max_compressed_block == 1)
> +			dcc->dcc_ind_blk = hubp_ind_block_128b;
> +		else
> +			dcc->dcc_ind_blk = hubp_ind_block_unconstrained;
> +	}
> +
> +	/* TODO: This seems wrong because there is no DCC plane on GFX12. */
> +	ret = amdgpu_dm_plane_validate_dcc(adev, format, rotation, tiling_info, dcc, address, plane_size);
> +	if (ret)
> +		drm_dbg_kms(adev_to_drm(adev), "amdgpu_dm_plane_validate_dcc: returned error: %d\n", ret);

This can probably be removed, but lets do so after some more testing.

> +
> +	return ret;
> +}
> +
>   static void amdgpu_dm_plane_add_gfx10_1_modifiers(const struct amdgpu_device *adev,
>   						  uint64_t **mods,
>   						  uint64_t *size,
> @@ -835,7 +875,15 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
>   			upper_32_bits(chroma_addr);
>   	}
>   
> -	if (adev->family >= AMDGPU_FAMILY_AI) {
> +	if (adev->family >= AMDGPU_FAMILY_GC_12_0_0) {
> +		ret = amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(adev, afb, format,
> +										 rotation, plane_size,
> +										 tiling_info, dcc,
> +										 address,
> +										 force_disable_dcc);
> +		if (ret)
> +			return ret;
> +	} else if (adev->family >= AMDGPU_FAMILY_AI) {
>   		ret = amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(adev, afb, format,
>   										rotation, plane_size,
>   										tiling_info, dcc,

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

--

Thanks & Regards,
Aurabindo Pillai
