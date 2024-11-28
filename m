Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930ABD70DE4
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 16:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45AC310ECF6;
	Thu, 28 Nov 2024 16:14:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LOOaVdJp";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C5C010ECF6
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 16:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXIecfnviS7zetid3RIVO2sjpqV6WAIfRZLhnYxynC4phKrHOk3v/6UD5NFPGeU+zqYKOtgKC8PE5FbpEcG0m6ced34U1qfskFqSsGwWGYU2CSt819o18tFQndx8Vqwe4f8lQZRYoA7pHXM0gv7blLe2bwNmDCkGEFVyUBtIkzrMKWqUkq3ZsyKE/L1ehsrkbpA0hyekDpatmrKedanvlrpfUATOqWchq729UfVLu6Ah8W/cj7qKYgLcMJlIi7DiNibLjMJCsFURY2A7uRtk4U+0F5q4w6ow3UIfZJRDS6g62ZuARKd+2c8o0kwJEPkII4ES3qwGh75MtT3uQlGqcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCvj+8b48NubS7YVKKRI6PwGZ8/792WDdCTKer6RY/8=;
 b=hP0z5lA/dcldKNyTTPdAoJUrf3XicjcaE9/xLpz+LRN/HGYyo7/KavJq01Gl9zVeabZexgv4pxA+hB87etyKVqpvYh02ssMz8FUUEFOcOHglibNhfLyLPhh9pK1jSFAofvOegLIe15qoDY+vakJBvy8dMhsSWIVuD2n249Ds7Mj2MAC+xCAvZcKURtOV3090plqkz3DU5GG69ZIz8e8W2L9nIWFrbGVbLNJnQu6QRRiu+N5su+XPiBKau/5B9ZcJzAIjZ5JVcpBbBnYXMZ49ThA+74aWQNlEl5d1hdawIUMVCVvCYNOebTXmqG5utR/eny2Wb9xqhd5GAWAFxiadyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCvj+8b48NubS7YVKKRI6PwGZ8/792WDdCTKer6RY/8=;
 b=LOOaVdJpLaY8YQ1bVz/tHz4PtoV2cxU65UZyNoyBLrRd2+oyaTXedKBMdiElHdUqT/DONSeg+/IvxQWBMwMw7jI9f3/3+kFnfbwt4FRUdMWar5S7a4DXa90BO7Z5cVn5gROpArjlUKAi89kaLCYIH+BzZsevaQx/ax2muPz4oj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DS7PR12MB8322.namprd12.prod.outlook.com (2603:10b6:8:ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Thu, 28 Nov
 2024 16:14:25 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 16:14:25 +0000
Message-ID: <af596c51-a253-4d38-9bbc-4bec2a04f003@amd.com>
Date: Thu, 28 Nov 2024 11:14:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix programming backlight on OLED panels
To: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: Kaitlyn.Tse@amd.com, nicholas.kazlauskas@amd.com, zaeem.mohamed@amd.com,
 daniel.wheeler@amd.com, regressions@lists.linux.dev,
 Mario Limonciello <mario.limonciello@amd.com>, Luke Jones <luke@ljones.dev>
References: <20241128032200.2085398-1-superm1@kernel.org>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20241128032200.2085398-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0274.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::27) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DS7PR12MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: f57b0129-7243-4a26-d0d5-08dd0fc7ba0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEdRbWtWYWpLUTdQbzdna1YyYjVaTTU5dFFpWjJpbm9jbnpNbkNNZkVUQXFN?=
 =?utf-8?B?SXlXaUErUjI1emNWd1pTTndLdElyZUZIRTlobHQrR05oOTVoSDh3OElIT2V1?=
 =?utf-8?B?MHFvc1ErSmlBYVdKa1oxcnNvOWJGdzFwdytjb21KTzlQbFFFYVhVeW9UUlB2?=
 =?utf-8?B?aS9XOGVXMGdiYnlwUkM2MkF1V0tTMUc3WS9xMmF5cnVxVzdZcGJVbUE5c2tz?=
 =?utf-8?B?Ny9VOUUvaUp2TmRhQ2t3dk83SFVxTnFpazR5ZHUxSGFDZTFlMDJXYkF5MnN1?=
 =?utf-8?B?M1NQalRtM3lxVENQUXVrbC9oSUtRWm9IKy9MeWROV2phNi9ialhmcHc1RTQ4?=
 =?utf-8?B?VGVINzlNL0JMZDJYNlFyVkVibGx5ck9zT2VnTFFSTFJ6SmZpQ1BjWS9NSWFx?=
 =?utf-8?B?bUc5ZVVNcjd3cWZZanZIbEVWbXZkRW5LTERjNGt2NFlaTlN0cmN4MmsyMXJF?=
 =?utf-8?B?U01tc0xUaUgyT0VoNDZValFGZDVkbTY1OWNjWisvNUh3S3J2NkM3a1UvZy9G?=
 =?utf-8?B?L2ZrTkNkajlxSk01L2hlQ0QyeEpzYUVqWEtCalBkZ2lHMTIrZXYzTnRrdDBl?=
 =?utf-8?B?VjIvNFYrYlpDVWw4MkZuZEdHcjBoTnM1bVdTN0dKcmF3cWVJRENPNjR0ckJ3?=
 =?utf-8?B?ajdjdysxenUvemhLMlNqSEVNeTFIMEhFT1Q1aGZBV0c2OWRmanJZaUlpcmhj?=
 =?utf-8?B?NS9QaENNaXNZelpBaURWRnRYc3RINzBGUnlYQWZSMHNlVGN3M01sSFhJN2g0?=
 =?utf-8?B?SEJISVc3aERvRUxpUUJ5bEV4TG1wRXkwNmowcWhzZU4vajVDai9uODFhYU85?=
 =?utf-8?B?cTFtUVVFRGhscmZReFd5M2Nkb29qTCtBOWlHN2xBSTY3YnNVTEk3WTVQd2g3?=
 =?utf-8?B?TWUwM01RRGRETHI2WDVDUEdoMDQ4WGpqeTE1bW4veTNCM0NJeDRaK1VuZnhw?=
 =?utf-8?B?RUFSSk12TEhnRVRDdmZtaVYxZm5sRnVNWjVrTlVaMTBoR3BuRks2OWhTVmdh?=
 =?utf-8?B?c3Z2VW9pRHdsM3FoV1d5RTB5cCtTSGpHTTl0ZXliTGFtbXYyMVMvYXRSb1lL?=
 =?utf-8?B?eVNrMEw2NVRpTDBpQ1lLYnp1MXB6bWxUSnFIMTkwNUE5MlNEMWV6MDJxK09R?=
 =?utf-8?B?MW5scXUrVXAwYlJVdGJRcVVWN3daZkQ3Z2Y1NWJXK2VuWDg1ZDVDWSt6MThX?=
 =?utf-8?B?YVZPY1l4U21uZjA1K3hOTjN6aXZkYlZwd0xPUDd5UXBiRm1ENlhDSkZIZ3pE?=
 =?utf-8?B?WmpYYlBGL25YM0MrazBNM1ZVNHJYclhVbk1jb0xQVG5sUTR6OFBtNEJpU0R0?=
 =?utf-8?B?bkR3OVZ0NzRXcVVIRWNvWkttb2V3bG9YdkZYTFBFWi9DZjR0V2RlcnFwQXZq?=
 =?utf-8?B?blJ0SDkrR2ZyUXVsam9zeFBCeENPZ2hwOFZtY2xvaXhVdFN6MzhaVEdqTS8z?=
 =?utf-8?B?YTg2c3Mwem9aOTdBUVhOaThkYm9GazVKLzJiL3RLNFF6Y1A0b2VDMXdZaUdk?=
 =?utf-8?B?V3BDeHVnWnZUSmJldmVSRlFsL2U1M01melBDQVpoNUJPOVJNalBaNHpBeHlp?=
 =?utf-8?B?U0lZY1BlZytwMFdYUWp6cDBSbDlYSXNLQm94MEI0Zm54OURHZnd6RnQrRFBx?=
 =?utf-8?B?SDF4cDZ4a3NzUGNZNnluU0V2c1YraGdYajRMQ1N4TCtkcTNHdmtrcmNuN01u?=
 =?utf-8?B?TG5TYm1QVDNkZGNNZUdMUldPaU1OcG84QkpEYlQwNm1abHMzK283Q1ExVzJs?=
 =?utf-8?Q?AIxiKlYbJnTSxzm6w0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3hwcFZrM2dhMkwyandVYmRxL3g3cE9zaFFvRGc0TzBjaVBTaHowTklTVXZm?=
 =?utf-8?B?UHFHN0xzZW1sVFlLemMyRUJMTGFORC9qaEtGd2FHekhCeEFjaHpLMnR5L3cr?=
 =?utf-8?B?bm5sYWt3cmxVV2M3cnlybnBnUnB2eldIWjZ6MHdtOXljSk5rZkNGOUZHaXZr?=
 =?utf-8?B?SHI5ZkFHVFowc2NMWS96T3lYSUFmdGV1bWRnc3J3SkowSW9oUEFnRTVuZ0NE?=
 =?utf-8?B?Y0ZvVStuK05EcUtHMWZkNHJhSUNEZjJRL0Fja1MzeFRsNUpxa3dUWHI3Rmt4?=
 =?utf-8?B?aHhXQUhyLytqNnBOMWM3blNPUmppT0dJMzJzTFU3Nk1KTFpucEhMUDRxbnZJ?=
 =?utf-8?B?MnZzWGdGdi9Ybm1SMHdRc0YyK05vWXBDTjZidGszcStobXZmTGhoMjlUZmRp?=
 =?utf-8?B?cTMzNkhKWHE4c2IvTkdwcEFHRC9JUGZEcHZaK3hXcjBMZmFPbDVNUnRKRnA1?=
 =?utf-8?B?cjhsREZhcEErcDF3cWluU1d5UHMyMTl1STFyb2FkdnhKbUcxdSs3SjYyOHVy?=
 =?utf-8?B?dE5lZVJEM2Ewa0Z0djNFcWZRS245UXU0N25WNHJuR3dqdmwrbHNsOU1NM2FP?=
 =?utf-8?B?eGdrUnJNSGE1WlVNSVRSQnJYRmgzcW92QlBjWlNuN3dzNzVkQ2RJMUphN2pH?=
 =?utf-8?B?bjV1dmppeWttSTdFT3pGMzdRZDlOdWhHdmhtUDg3ZlpZVGQ1bVVNZmx6eUFJ?=
 =?utf-8?B?WU5wdUZ5TWZ6UWprejUzMW0wL05Gd1k3bDJ4ekJXM0lrRGFlNEtLR0pJbUZn?=
 =?utf-8?B?WmJ5T1haUWVkSlpXV0VxVWk1VXFoL0lZTzdsbHk5VHRKY0N5QUI3UHZybkJZ?=
 =?utf-8?B?b0hadU8rc2hlUWpFMUVDV0hYekc0SXJrVU42T3FHaGpxcGhGTm90bzNjemZt?=
 =?utf-8?B?T3J2dXlhTmdXL0Vtbnl4RUMwVmVEVmNVZURmRFNUSm1VeC9odFlWK1JpS1hr?=
 =?utf-8?B?a0J4cnpCdjVac1oxbnFwbm5qYnZUWnlMQ2hCYlRlU2kzMk81bktKcjNHKzUz?=
 =?utf-8?B?dFc4WkloVnNwYWdWZjVpanlHbzJ6TnUrQ3VYWUppdEZVQ0NUaUVCYVd5Q254?=
 =?utf-8?B?UGFYTEVFUmc5d2wxVkZWMVE1M1I3bDhQOENFRHRvNmF5VHgxRCtvMTdnd1Zl?=
 =?utf-8?B?bmpwZGYzTjEyaHpvZWIyLzZtYi9yWjR4RjdKVElxUmZMRWF3OEhDeDg4Q09K?=
 =?utf-8?B?NVRDVXdLazh0OU5XNEZXTXRkcmVFSlFlV3dlbUdTcDhRYWxHcWR6SVp1cXJB?=
 =?utf-8?B?R2tOSUJNRytLSUV3WTRSUEYzMFJCeUZ1b3NNWXdQNXhJalIzNUVOeUlIVnY1?=
 =?utf-8?B?c1FVMVFRblVvbTBrcDVtWE1SWmlYdTJxR01odk1FaFE4a3RoK0dlUDBONGkw?=
 =?utf-8?B?NUZwR1BNVENHOHhsMHdpRW1hNTJMQzQ4ZE1ZbVMvVVN0WGtiWElXL3FWb2Jl?=
 =?utf-8?B?KzlSZUdtaC90RHBPb3g5eGN4SVNReXJzSTRSSGxXOTBlRms1aE1URzlWaXdw?=
 =?utf-8?B?VVhYbzl4cWdFMkZIVzQvTll4dzFETzNFYjJPZW5DQnB1WGt4aGh4L2V0NE1H?=
 =?utf-8?B?ckVOUE56d3ZEWkpCdnc5WXNPTThDY01CMmdQU2psbTUxcVVLWnNRTWdtVEpK?=
 =?utf-8?B?ajFRNHJsaGxSNUhKUEoydnVzelVjZWFQR2tERTNybVFrSmRsMjNiaFU4bWpk?=
 =?utf-8?B?MlY3eHB0SExEdlNXQVNoeTRDNkpnRXV0Q0ZxZFp4TDRWd0ZSZFBnc05udG5B?=
 =?utf-8?B?R2RQazlHZGRTU0xWMmlyNmpJVnVJZjUrMjczdUJVMGU1ZGFBRHY0NFpVOHdz?=
 =?utf-8?B?cng2cmlhejU0OU9ZVkNBWFp5OXkreENONHA3cks3SVc4OUpwMGxGSlAyWnZD?=
 =?utf-8?B?Rk5pUXMyczE0VFlSb2xKeGhWSlBJdDh4NnVlaTlOY3NqKzY5eGx0VXJFUWRI?=
 =?utf-8?B?WTNWTllZOVQ5b01SUGJhZ2luZ1p3NEhLUmhrdnVTYjVNT0dSYU5iSU9BUDls?=
 =?utf-8?B?QzUwdDAvVGJxcVN4Q0FweHNqS2xpRzliUjBiT1ZLNUJRM21BVTVvVXkxd21r?=
 =?utf-8?B?R2FDLzdWUDVTdzFIb3YxUVZsV2FKeFBQZ2Z5dXgwZzJnNHUzOGF1NkZLK0tJ?=
 =?utf-8?Q?NvM5GKhgmfbFiMD9sL9Xg9gAa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57b0129-7243-4a26-d0d5-08dd0fc7ba0d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 16:14:25.3313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0CO9WNXhAM6F3ErCDfZZIjTLdyWfnsIp5RUcSeKSzu+Yahmql2Y2ukd+OaU5+DbMkwQMr+GbbLGGLI27b0xeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322
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



On 2024-11-27 22:22, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> commit 38077562e0594 ("drm/amd/display: Implement new
> backlight_level_params structure") adjusted DC core to require
> the backlight type to be programmed in the dc link when changing
> brightness.  This isn't initialized in amdgpu_dm for OLED panels
> though which broke brightness.
> 
> Explicitly initialize when aux support is enabled.
> 
> Reported-and-tested-by: Luke Jones <luke@ljones.dev>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3792
> Fixes: 38077562e059 ("drm/amd/display: Implement new backlight_level_params structure")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 19a58630e7740..243cee2841312 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3483,6 +3483,8 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
>  		caps->aux_support = false;
>  	else if (amdgpu_backlight == 1)
>  		caps->aux_support = true;
> +	if (caps->aux_support)
> +		aconnector->dc_link->backlight_control_type = BACKLIGHT_CONTROL_AMD_AUX;
>  
>  	luminance_range = &conn_base->display_info.luminance_range;
>  

