Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6054FC4829A
	for <amd-gfx@archiver.kernel.org>; Sun, 11 Feb 2024 04:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A751210E350;
	Sun, 11 Feb 2024 04:53:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lKgz08KB";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AB5E10E2CE
 for <amd-gfx@lists.freedesktop.org>; Sun, 11 Feb 2024 04:52:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChAYTaVl404Qh0c7cHcnVOsoyQi4vI+xV0nva8ESBHfO/dVjSQi0W0h8A6ZZ1idX3PkNw7MkMGiZin/uGV0zwwCnbqwO0c+F85o/sGcqICPfRcxA55z7YE542O157uzd15lxcDg91f5yM1Iyg0Z3OvkzIK+5b7ZFstkvvfjkQEfk8zfO5/3sloNDKuM4adLC3VAJhShGrpGieB/fneuLGxAgrg9bd76NDmnr7nI8gGQfqc0T2iUv7e/N98EDgd+zxIVHGfHdvp5xklw8oaNpDWcRPnYUzXtvWCysx1Su5knHpgsgF3/i6CLwIyXr++RhUaGAWwImt7sO8GjZ5RR9xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYGx7BgQY2Pc1IRxRLm4zFiEvrT8597PNlLiUfOwYdc=;
 b=Fg3qJLKBond+vbpR6vbYXXD7XDRJXnKXOtrl18ZAqcoVomdrQc5c4QD1shvbu05xCII+XXrf1cnu3LhXobHnHSrMD2M4pCsUueCPoEdpEKftMfWYj+FzwcXReAAH27Q2ElByQ+AlrOFZ4LQ5aG864HsFzFu4F0KAPWgQ8faPC2GxfLlZL455DI76Oz97YA5SWAk86/f/M0EWV7DxAYmtRMwr7vAHwfGN2590ZfDViIecq6utNzxXsf/1D/U/lmBsQMXlZjclMkG1hGHyKzw66IwHnV7R/OyvOOuhboA0O3lR+ZMlEiqyNK0MO8AW9z50/Gpo6HPIWCPhF+s4FgPJyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYGx7BgQY2Pc1IRxRLm4zFiEvrT8597PNlLiUfOwYdc=;
 b=lKgz08KBrSlkPGdADyZvq1XTVNriioQMbBfE4CCOOOwLpZbfDzQVuXOwGaUkuePEUBZPo2TA3bmmDo84NGC2YhyygsG5TIxATLFzy+EEVPeirlSxtITraOLwxHLmm+0yNVFdDmIRnXl/9nRIopDgpwZEC39j1jD8gM0oe8NDpuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB5814.namprd12.prod.outlook.com (2603:10b6:8:76::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.16; Sun, 11 Feb 2024 04:52:47 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dd00:9ab5:4d11:2d1a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dd00:9ab5:4d11:2d1a%7]) with mapi id 15.20.7292.019; Sun, 11 Feb 2024
 04:52:47 +0000
Message-ID: <054248fd-dc3b-476b-863a-6d1361f1f365@amd.com>
Date: Sat, 10 Feb 2024 22:52:46 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: respect the abmlevel module parameter value
 if it is set
Content-Language: en-US
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Alex Hung <alex.hung@amd.com>
References: <20240209214631.23219-1-hamza.mahfooz@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240209214631.23219-1-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0016.prod.exchangelabs.com (2603:10b6:805:b6::29)
 To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB5814:EE_
X-MS-Office365-Filtering-Correlation-Id: a5586990-e6f6-4779-d668-08dc2abd4b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eu7Xrq6ZoO4XNTVbORXWGhJ1vekwu4NzYHvT4eddYMkV+VIOBSDjHgI+wdWR0J3G+orCadJyNnKsMe82VsB0wnDsYGh/VtH/yzhrghsN6sK/2334xw2pYa5ccKlz8Acu5PHMWbKCWn/CAKaRjfLn7DnEk1e8Z6kQuL+8hfnRwIr16qnTF8KcoZiMpZHXeqcslRQeCcjIjiMmSPLAMly2ioWggbPLn6gROAVQJf2159gN4Zt1/GvzWLEOq4ePmJT70zcHIXhEvOFVBztGq8pE5AvIDZQjYCT+Md6EZ1puv4sDHHu40Gh88b9JXu2+Ll2O4t1i4idsGkv4F+pBE3TA3IvM357mUBobcjGiE/jcmeH52C1X5rnKvl87zC8GsrXerFE8AhPBN1b/BcAgAlJ8QHivULc012JF2joMNXOXcJJjXHPfLV/Qf+o8MUydBK1v/wHJFimfq9qt2iAAUec5VXl1QL7GqRzoSIfhPG3e+2SZj3zGRKo69HOwVkcnDx4nTehgZ0Rt23rl421NfqQK11QaxBTqMpGseW/etNKrIWAcMDHY7VU+GoK5N/Ap7dVF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66476007)(31686004)(44832011)(41300700001)(66556008)(2906002)(66946007)(38100700002)(5660300002)(31696002)(54906003)(8676002)(83380400001)(4326008)(8936002)(26005)(86362001)(6512007)(2616005)(53546011)(36756003)(6506007)(6486002)(316002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEYvcDRhWUFPaGs4U2hlckJHTW9RZlM3N2RTVjhMYW51bGZIZU9RcG15QkJp?=
 =?utf-8?B?VEhVTHQ4eC9BUzl0NEh3NE5WamNsZVJUcWFVL3VCejBNa1JBTjArQ3NVbG1n?=
 =?utf-8?B?Wk5hd0tCV01KMi9PWjBJbWVSa01HYTR5aXF3akJsYVNCOTV6RU1UdTJ4WU15?=
 =?utf-8?B?WFlPK3RJaXBYQWFybkh4RTdMUWV4bEJRR0RHc2htQ0ZGTjl2TkZ6OE55L240?=
 =?utf-8?B?Z3VQN2h0ZVJIVEdCSjc0Y1hWRmo2UTV6TUZ0L2FjaFBQVmNVK0puaUp2VktQ?=
 =?utf-8?B?R0U2K3E2U05NQWFGOHpyUGlvbmQ3enhyeFozSHMzdzI0THVnRHRvSVhvZ3hx?=
 =?utf-8?B?RHFrdjBZbzFjVG5oSVpTY1VhSTR4aFdmU0RPbWR3ci9MbU9lMUlzNWxSOUZ6?=
 =?utf-8?B?MjlXUWVkMFFWdUw0T0hSZ1M3dHl3dmhXM2hOYUlQeTZGay8ycm8rWHBiTVJ3?=
 =?utf-8?B?eEtqVkJvdmdZSXkvSVRzMmJxQS9tWGx2U1R4bGlSMTdWYncwdXdOckVpN3p5?=
 =?utf-8?B?MjBQcW9uZ3ZoU0JGaTk4aVZzMUFPdzR5cmI3VTBIUEJadzB0QTYxc3QwaENv?=
 =?utf-8?B?eCtpNmVCWDBoS2FMYjVYQ0JBL3AvT1k0K0IzeFJjQkpWeFdGMVZCd2hZcXBh?=
 =?utf-8?B?N2QvSGtYaXhWSzZYVXh0QTBvSFk5NURhalNtTFhXYXlyS1RrMFByd0JjSnFQ?=
 =?utf-8?B?bndGT08xVUxMSDBQL1hqRFpadjh3c0RjVzBpbVFFb3lWbXgyWms4ZTdlT2hG?=
 =?utf-8?B?UzJBRTUwaTh1aE53NDBBK3F6TnlpVzl5ZFJGTnRTNmllNlNRMVg2R2N6Q1lx?=
 =?utf-8?B?VXE1dDdVUmVicXFzZnlWaEF1MHo4M3BnSGJ3SXRLRVlLdk0rbVNNN3M5YWQ5?=
 =?utf-8?B?MkUrOE9WVnpVbEtta0RvZzg1VGd3VWtaak5FZmlWRVRZaTFCOXZOR2piM1pU?=
 =?utf-8?B?NFRUcWRablAvMnc2STNnQ0N1ZjhSWjRVUzZNa3ZqVWJ5bktObGlXaHliOGhJ?=
 =?utf-8?B?SVFTQndIbHdvZFBuMERMTjkxVXFHL1ZleGtlZzN3Y2JKUEFRTUQxdElwYm5p?=
 =?utf-8?B?QlNGcUtNemIrdFM3SkJscnNMMzE0ZHB5aXN6aVZMd25oRXQxcnZBbGIxc1JO?=
 =?utf-8?B?b0x3cUFRUWt2c3NhYlVKMStKdEJIRVhPejNzVUQzZ1hNVmJzZnliL3MyeFo5?=
 =?utf-8?B?cHQ0NHB4ZFhnUTkwKytnTWdKbUZIT2txRjdlMm9vVklIODAxc1RKMDh6VWNO?=
 =?utf-8?B?WDJHS2hFM3JBQU5sUnlaa3dUSFZkSTlrUkNYOW11cEwxZnhGNzl3MEdMUUln?=
 =?utf-8?B?VDcrcklidGVtYnkrclhmQ0dHclNnRjdaamN3TnlLMXdEeWpvTFBSK2FIVjEw?=
 =?utf-8?B?THNlRmJKR2tnenRTTHZCOExQRk80M01WLzQ1K1hQbitTcjhmM1VDSFBCZXp3?=
 =?utf-8?B?S2RUUzJEWXI0OGY5SnRKbVEzdUZqUjUwZGl0RXdIL2h6Q0VleE9QMUlFMnlL?=
 =?utf-8?B?c2t2d3N6MVY2dVhEUWRTNjh2UVppTGp2TzdqeHA1Y3NXZnY5WnVCWVRjYkZR?=
 =?utf-8?B?VERNaGE4Z3dHQVQ4Skkrd204V2VQMHdOUjF1NWJDcHFXOXBHNWNIMUU1ZGlH?=
 =?utf-8?B?cWVrWW9jRFlvS2UvZ2cxUXZQL2hZVDg5Q0d4R3psdnNrMllJZnlmTURNZWw2?=
 =?utf-8?B?NGRSczhGNDVIZWsxTzVOdS92R1Q0T0sxLzd1d3dGaTRJc1AreHJRa0FtVG5U?=
 =?utf-8?B?TXpqU0dCbkpwcVFlMmRWQzk0bC91RjhwL0lCcFNIaW9QQkJOa0FoenBsRngy?=
 =?utf-8?B?UmV5eFhXN0oxV2ZpTHNRcjJBV0MxcEMvL1o5NDVBVXZ1TFNGbUp2Yk5VZVZE?=
 =?utf-8?B?a0dZbkdSUmlSbGk2V2FYMGpqRDIyazdzOHVJeTFrSll4NHNKZ0JMaW1qcmYy?=
 =?utf-8?B?MWZ2TFIrdGN3MXF3c2U4QjUwdnVvVFJ4Q2lzcmFjU0dKS1RSRXQ4KzZjVlBR?=
 =?utf-8?B?SlBLYzN1VHNWS2lHRXZrYWtMaXFyYllsdjVFc091d3dla0lPMzZ5SWRZdjU0?=
 =?utf-8?B?eFNmOFhmSzN5bzgxekxLc2V3U1JPd0lmS2Z0QzRTbTZCSndQN1JXUERFU1NR?=
 =?utf-8?Q?d5cjW/nYlydROIafCngTm7HpW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5586990-e6f6-4779-d668-08dc2abd4b0e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2024 04:52:47.7316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27xnocqe5BJll9/R9ndphRSW54IZr2tE4f3dFZ7u9oZJY/e064wxF8au86n35OuXkRQtwZrjChaT46tMD66yNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5814
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

On 2/9/2024 15:46, Hamza Mahfooz wrote:
> Currently, if the abmlevel module parameter is set, it is possible for
> user space to override the ABM level at some point after boot. However,
> that is undesirable because it means that we aren't respecting the
> user's wishes with regard to the level that they want to use. So,
> prevent user space from changing the ABM level if the module parameter
> is set to a non-auto value.
> 
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h               |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           | 11 ++++++-----
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++++++++-----
>   3 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 1291b8eb9dff..f5c8187e0d58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -196,7 +196,7 @@ extern int amdgpu_smu_pptable_id;
>   extern uint amdgpu_dc_feature_mask;
>   extern uint amdgpu_dc_debug_mask;
>   extern uint amdgpu_dc_visual_confirm;
> -extern uint amdgpu_dm_abm_level;
> +extern int amdgpu_dm_abm_level;
>   extern int amdgpu_backlight;
>   extern int amdgpu_damage_clips;
>   extern struct amdgpu_mgpu_info mgpu_info;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 6ef7f22c1152..af7fae7907d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -849,12 +849,13 @@ module_param_named(visualconfirm, amdgpu_dc_visual_confirm, uint, 0444);
>    * the ABM algorithm, with 1 being the least reduction and 4 being the most
>    * reduction.
>    *
> - * Defaults to 0, or disabled. Userspace can still override this level later
> - * after boot.
> + * Defaults to -1, or disabled. Userspace can only override this level after
> + * boot if it's set to auto.
>    */
> -uint amdgpu_dm_abm_level;
> -MODULE_PARM_DESC(abmlevel, "ABM level (0 = off (default), 1-4 = backlight reduction level) ");
> -module_param_named(abmlevel, amdgpu_dm_abm_level, uint, 0444);
> +int amdgpu_dm_abm_level = -1;
> +MODULE_PARM_DESC(abmlevel,
> +		 "ABM level (0 = off, 1-4 = backlight reduction level, -1 auto (default))");
> +module_param_named(abmlevel, amdgpu_dm_abm_level, int, 0444);
>   
>   int amdgpu_backlight = -1;
>   MODULE_PARM_DESC(backlight, "Backlight control (0 = pwm, 1 = aux, -1 auto (default))");
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index fbe2aa40c21a..a5b3330879f3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6513,7 +6513,8 @@ static void amdgpu_dm_connector_unregister(struct drm_connector *connector)
>   {
>   	struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
>   
> -	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP)
> +	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
> +	    amdgpu_dm_abm_level < 0)
>   		sysfs_remove_group(&connector->kdev->kobj, &amdgpu_group);
>   
>   	drm_dp_aux_unregister(&amdgpu_dm_connector->dm_dp_aux.aux);
> @@ -6577,9 +6578,12 @@ void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
>   		state->vcpi_slots = 0;
>   		state->pbn = 0;
>   
> -		if (connector->connector_type == DRM_MODE_CONNECTOR_eDP)
> -			state->abm_level = amdgpu_dm_abm_level ?:
> -				ABM_LEVEL_IMMEDIATE_DISABLE;
> +		if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
> +			if (amdgpu_dm_abm_level <= 0)
> +				state->abm_level = ABM_LEVEL_IMMEDIATE_DISABLE;
> +			else
> +				state->abm_level = amdgpu_dm_abm_level;
> +		}
>   
>   		__drm_atomic_helper_connector_reset(connector, &state->base);
>   	}
> @@ -6617,7 +6621,8 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
>   		to_amdgpu_dm_connector(connector);
>   	int r;
>   
> -	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
> +	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
> +	    amdgpu_dm_abm_level < 0) {
>   		r = sysfs_create_group(&connector->kdev->kobj,
>   				       &amdgpu_group);
>   		if (r)

