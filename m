Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD71CCF9E9
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 08:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A9D810EB1B;
	Thu, 26 Sep 2024 08:55:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pK6YSNVQ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BA4810EB1B
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 08:55:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5nNdVlPRpI27yq1sVukagbAvDkyxZW6h+zPLUGmXQsxTK/GjeQbB5wvOHPPyt5xP1z44lgl8oyryAIbY7FaeZBOCxSH7NN37fjNPQjdSKa/4B2PunAXpeboieyv1ouD05aJXBLAqJguNvloVI+7DDWw5ZdIURQEoiiAio0QHBj3I2ZIvmwa13S0li3GGh4PYBbWrdeQIUB89hUsX+wpVBAbE3V+9soZQ8oGARvpOElG6nOLi4edX5qbToS5OLs24DDkJu0xCtXDWJD/NFaX3SNfmTKhflQIAedNtgXzRhxCYKC71XBAX8oQViBlUjn31uHD8FJkcaP3HfyPNfQZAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/y3tpDoZJaGt/KnNNTCjepHIW+0klaS4BTo5hJShkR4=;
 b=pmtlgf6HB5rVTryYNMl1A1i+fVtHsGV5+Wu1w8dkAqToqHPkQAPiBbERpL5nCexfx1i/zg3Gu7krq/oR9/s9c6vvD4nr0ceu5EKWgSEPr1xW33No3mX+JXSL2h4eCDAnWmKA0Ilp5Q2ASK5zVv+xkBDfWBkvbbwdPw9GNN8f7No7Ymig7YJw1cthZguFR3ybRRFe/TRjkYY/VUfa71C6amSd+ZnHfJP2rgDhStBqvgWvdS6vakbAn2Ruo5uTUHHT0qN+NH2IGL0LY+IVqUsnllbi0zkmjVJfMud+zdaa/Xvkdc4kFfMohoICSmtLvqckJFXyZx9LoMtuDsAlZjNQ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/y3tpDoZJaGt/KnNNTCjepHIW+0klaS4BTo5hJShkR4=;
 b=pK6YSNVQ4ywyXCcIVn8dTcak4OCvsODMSpbIPPSOc25JcYA3/2+5CUM9Yc7y1xWQvGrtnwns6mm2ykogyzmPBNp4Y9cn8/RZuWFCrykcj9UpoUu2Wgn8vwv+pqXgJxPGteztD74i1LBxmtAE11aEZEjOO0zZQgVLzDpiGwkeey0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Thu, 26 Sep
 2024 08:55:28 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 08:55:28 +0000
Message-ID: <72c141b5-f531-4b70-8776-776a2f9acdd3@amd.com>
Date: Thu, 26 Sep 2024 14:25:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/9] drm/amd/pm: don't update runpm last_usage on
 debugfs getter
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 kenneth.feng@amd.com, mario.limonciello@amd.com
References: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
 <20240925075607.23929-5-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240925075607.23929-5-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA0PR12MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: abd71b9c-37ad-4041-1f55-08dcde08f822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXdaV3pjU3FZTnhPRnY0T0Y1Mm5VZzJyY3VkL25nSGdpZGljU1JoOUthUWJH?=
 =?utf-8?B?WU9tdFR4TEQ5NFdMcnFnM1RZMGM3RkF6ZlFNZGtMQmtjZ1hZV3Ewa3hCQnVa?=
 =?utf-8?B?WUt5dnpuQTdKc05ESDRGcWlZZmwyL2xyL1ZPbXR1eHVZMHJJZ2RDcmZERUk2?=
 =?utf-8?B?Rm51RVRncnpMVVB0WGZhWjJJZWRQZTFjRFIxY0F5d2FxeVpueXRoY3ExSjho?=
 =?utf-8?B?TE9GUnp1QXNzNHRqM3BXSmd6ZmUvZUlzZDBNb1JzeERPTlk4SVRGMVdndzUx?=
 =?utf-8?B?bFJWMHc2bFY1RTBjY0F5WFNjYmMzZkRjRzE5MUlRd1N1d1NpdXUvQ0MweHFu?=
 =?utf-8?B?K2RDZVFTbFIrQXYwWWc0UjVXK3ZEYjdwdU9yNkFuazJJMW8zVno3VHdPaDZ3?=
 =?utf-8?B?VkdYanQ1Skh3N3lzMG1lTGpWL1EyY3QvTGtYbGtsaUFZTmk5aTFodHY0VUlC?=
 =?utf-8?B?NVc5d2gvK0htTXc2SkpRa09VMldhY09PZEhGM3ZzbWdvVVFqZFFhRlVZbVNk?=
 =?utf-8?B?MFlwY1g3S2RWR09TaFM0bnUzSlZINzZySTh6VDJ0bEhoVkNLckFuUkUxTjlh?=
 =?utf-8?B?WWZucng0elVtZkpDOEREOWl2TEx4KytINjFHSTEweVpLeGt6dEdSdmlVVEU5?=
 =?utf-8?B?eGJkMmg1QmNFcmwvb0VlTUppM003YUNPeDI3OCtXbEUxZWVWN0F0TjFGQmQy?=
 =?utf-8?B?NEtrWk42TjlTTjd0RGE4YzBtR1pGRkxRRURGbDhsbVJKdkhLdE5BOGp1WEIv?=
 =?utf-8?B?KzZVdlFZbDh1by9MOTNyWVc3VzVvSEwrbDd6eFhJQ0l1UU5LV2VzMHM4L05U?=
 =?utf-8?B?SXlVSjR5cUNzYWErK1paNkhwbkoycG5vNjczMEp1WmF0WVpPQ0puN0h2T2lr?=
 =?utf-8?B?MnA4L3R4T0dZbXoxV21ZdFdjb2tnME9hQW5lelAwUUlHZjhPYVE3NjZ0eTYr?=
 =?utf-8?B?RlZCRk0rVTRHZ05xZTl6RGhQRGQ5ekNEQnBZQUVGUGh6aDg4MG5tcWF0SmZy?=
 =?utf-8?B?cUxZQ2c1SldyZzVWTDdsMXkzRWtIZ1lQMklTdythSW1pK3FxTm5aRWVMdk0r?=
 =?utf-8?B?cldHMVZnRlF5RDVWbkk3dkxNdHZUbEl4RmQzUzAxVzZDOEIvWVN2d0VyelZi?=
 =?utf-8?B?SkVCTFlJRjgyUkQ2T3owU3dhNWwwRDA2SUQrYzQrcUh0a2tkbGFoREMwKzdB?=
 =?utf-8?B?bHp6cDg5VTNZL1N2QjJPYW4wZVZ5Vm1JLy96elZ0ZUR2VHBSVDhzckdyOFJY?=
 =?utf-8?B?ZVZONVFTem9Kay9LdGdCUC90cjlWRnVGSWlkZndiRTVjbDA0UmMrbU9Zd3l2?=
 =?utf-8?B?TEtVZlJ1ZEJHWnZmNUZ2RnNLcUppbVN6WTYwOHVnYjdCbHJMVFJzMzY5a3cw?=
 =?utf-8?B?VFQ2ZEhoazRJSEpLYWNNSmMzQlpmQWlwNWMyM0pzM3NPTk9jZ1FFV2ZrcTF5?=
 =?utf-8?B?QVpjT0FBdFQrNFZOUmRlMFJLaDZ3M0paeld0RGhmeWZRTTI0RVFXUmQwVGJk?=
 =?utf-8?B?ZE1GcHVtZEQ4SzJqSW1VRitwRDNHK2FwSmpxcW9jM2RDZWx3ekE0OEV5UHJG?=
 =?utf-8?B?NVZQSVFJNVFVZXFtVjVmODJZQ0ttTmdDNERtcWtnbVNUZ1ZBM2xabmhPS2Zj?=
 =?utf-8?B?L3hJWlZUaS9RaTRZQjZvSDZyVW1PakUzTTdvVVhmclo1TGtMUjNJelVMWXRF?=
 =?utf-8?B?RFFaMnI5RDdZZEFReC9FV09WYjdFRVpRSllFQnp6RmRTSHE3aUNmL0M1bmkx?=
 =?utf-8?B?RkJpY3REbjN1TkQxblpqUG9vL1FTZGVqaUJ0U0pSSUdadDZLQ210azdob2l5?=
 =?utf-8?B?V3lYWTFrazJ4NzBWY09vUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTdUZThFeTgxY1hHd3RhWENNczhMWGRwVytCY1BwZXZ1RUN5TzlKMHFLN1da?=
 =?utf-8?B?QjZkenpQK0tjcGlPYlhqdkJxaGZtMDdyYS9yQlExbWVFWC9kbHpDQjJsZDBx?=
 =?utf-8?B?U1kxK3ZURXRqb2p5cnp2SkVBOW0zVmpwV2ZzUkRBbTd0NDZqZ1Y0SG9JenM0?=
 =?utf-8?B?NFNNNzVKWWFoL1RzKy9aN1NzSGplcWpXU0dhbHVBekU0TXZGaGVrOXZqQ3RR?=
 =?utf-8?B?NHlNTEdleHFSdHgyamh3bldDZ1RpRjRQTDdZRmthVmkvWGtuT1kxbG9Yb2N6?=
 =?utf-8?B?Tzg2bzVOTkx4cHFBdHhYZmJxWmVDK2FkeCtGcEhCektvQ3FhYkk0cm12bVBr?=
 =?utf-8?B?c0ZOSFdPQUlSRGtlU0lOUzNSekg2MzZDRGhHbXgzQUhkUzBvTVJVVGdPR2Zl?=
 =?utf-8?B?THRnaXlTQkUyYTg2L1lyRGQ1TkpoRkxKSXVNcEtiUk1iWk5vMHVMU3EyYVdn?=
 =?utf-8?B?L05GZUhQN3c1M2JLcGZaaTlBaU82UzdoTHY3WnE4TDZYcjNGMitSQkxiTmpi?=
 =?utf-8?B?cnVWZXhXbXpJN0FGQnZpbHBoZ1hPV1Q0eHQ3WVNnVnU4MXJIb0Y4eWdBU0g0?=
 =?utf-8?B?UmdCMk9aMEs0U3Bpb1VSeGV5bEJOWFhvdVBMQXFkRG80TzNTdm1rTjZnZHFB?=
 =?utf-8?B?NHVTK1Uxd0hHbUFZMGZOdzMvaFZvdGZLSUc1M0NhMDBOOUM2M1hTUFlYeFBy?=
 =?utf-8?B?NnhPRm9jYmlGVWxPLzBld09kT2xFNFJQS0FCNC9BREM1TWRCenU3dEpMQkxa?=
 =?utf-8?B?aDJFTUVMRzFQMHNybHFCdXVxd2dHT3l1S29NUGFNd2llMklQdkFGd2FJTm04?=
 =?utf-8?B?RnBVVXdGTE1hRnA3eThLR1hwYjlzMXNReWgwamluZzVrd01YcFE3dEp3MnVE?=
 =?utf-8?B?cFA0RThzWXIzdDdSQTVFOThwL0JYSVhNdDN4VUQ4QkJiSEZlczRJUU51UHpB?=
 =?utf-8?B?bW9FUFNnVFR1eUdDVkpLNk00akNtTURSc2tuVjZocmhQWWtLb1JsNW9NYVBm?=
 =?utf-8?B?T3doNlRISnVYcFpCeXhEMjNQbzhqYnRPLzNsU3phSTE4U0cwTUpEM3FUUlNH?=
 =?utf-8?B?QU1DNUdOMWJralFEMGltV1FlN3RueFZLMmpSbEg3T2VEVlVLaG1BTjVWNVFs?=
 =?utf-8?B?MUxGUktMVVFLc2ZIbHlSZXZ0ZjE2azcvV3QxZzlGUmpQOWRUR2xwMXBlSWtu?=
 =?utf-8?B?TjJGTFF4L3R1YXN4MWhtaVFReTZiSERCeGpBbEEvT3hYWXBLK3RCaTZ5bTBH?=
 =?utf-8?B?NGk0N1duSVlLcG9iYlJ1WURjWXYyWWtJeHR1SE5wZXlSbVNTOTBwaWFFcEl2?=
 =?utf-8?B?QkZMMnJjV3Y1TmJmYmJNdkdhK1pNSzVOMFJmWHdzcVI0SHE3TnVIUkZtckFQ?=
 =?utf-8?B?YnVOQ3RHczEvUVJxVUNXcHoyc0U0ZmhPN2Q4NE42SjUxNCthSDBQNFdRN1JL?=
 =?utf-8?B?ZFIwVVNCVkRIVXlub2FoNkVVUS9iTngwL1FGT0xneTJ1cGVCMkh2cWVpM3Ri?=
 =?utf-8?B?YXUyMTVoUWV6MTE4dHRKallhcnluUk9Oek1XS0xWNHJVQU9WZ0dGNjNkVXNa?=
 =?utf-8?B?MXVBRmZQYlVxR3ZHd2JNYTVDc3VRUGtQc0NuT012blpac3RuQUNIbFhBMDJr?=
 =?utf-8?B?UEZwUVhjaWNjUXNsRGlOaXVkNmg5ZDBNQXhaWXZLMjJsZ1hGK29DTGRHK1Zk?=
 =?utf-8?B?dlhIaHMyTDgrc2c3aWw4Rkx5SFJTTEpHTjlaM0lxaUs5Y1EyeWkxa0xMNWpH?=
 =?utf-8?B?bXdvRmhjdWVLQ003a2l2ZzRYVWlHMjB3VHRwWTcvTUduL0Z3R1BVUEk0eDVS?=
 =?utf-8?B?M3diQmNZbExyTFMyYzBLcGRyTCtrZmNpUVViZC9FY3Vjc08wYTB1c3NISFR3?=
 =?utf-8?B?Wm5iNWtDMzZkSnFrSzFTVW5QLzRwOXE1V0hFZDZKb1dLNktYNWdLTVNSOGRW?=
 =?utf-8?B?MTg4OUlvMVBpOThRbU8rMzVrM2J2MmxTRlRMRkdmckN0M2RmWlZxZVdJNkw3?=
 =?utf-8?B?dHRtOVUrZGxwWlYwcVpiSGhvVjRlSzFEcDBBNlBtR2x3MEphRDhsd0hNcEtM?=
 =?utf-8?B?VGxoQnhZTWtiZ21iZmRoaUFMeGJtK2tOcnBMTzZUWDFvQVJDemVLam8xNUVs?=
 =?utf-8?Q?0wtVXn2flk5TYrvLsQmgiOShi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd71b9c-37ad-4041-1f55-08dcde08f822
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 08:55:28.6924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQ53VxiVN+FqeQKZF/uAYv9ZGxwCE6IX51+R9DR7olxPnBdfzxHTAx9y2lgpSi0l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9009
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



On 9/25/2024 1:24 PM, Pierre-Eric Pelloux-Prayer wrote:
> Reading pm values from the GPU shouldn't prevent it to be suspended
> by resetting the last active timestamp (eg: if an background app
> monitors GPU sensors every second, it would prevent the autosuspend
> sequence to trigger).
> 
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 26 --------------------------
>  1 file changed, 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 042a4dd1bd6a..c8f34b1a4d8e 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -151,7 +151,6 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
>  
>  	amdgpu_dpm_get_current_power_state(adev, &pm);
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
>  
>  	return sysfs_emit(buf, "%s\n",
> @@ -275,7 +274,6 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>  
>  	level = amdgpu_dpm_get_performance_level(adev);
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
>  
>  	return sysfs_emit(buf, "%s\n",
> @@ -373,7 +371,6 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
>  	if (amdgpu_dpm_get_pp_num_states(adev, &data))
>  		memset(&data, 0, sizeof(data));
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
>  
>  	buf_len = sysfs_emit(buf, "states: %d\n", data.nums);
> @@ -410,7 +407,6 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
>  
>  	ret = amdgpu_dpm_get_pp_num_states(adev, &data);
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
>  
>  	if (ret)
> @@ -536,7 +532,6 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
>  
>  	size = amdgpu_dpm_get_pp_table(adev, &table);
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
>  
>  	if (size <= 0)
> @@ -866,7 +861,6 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>  	if (size == 0)
>  		size = sysfs_emit(buf, "\n");
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
>  
>  	return size;
> @@ -944,7 +938,6 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
>  	if (size <= 0)
>  		size = sysfs_emit(buf, "\n");
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
>  
>  	return size;
> @@ -1014,7 +1007,6 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
>  	if (size == 0)
>  		size = sysfs_emit(buf, "\n");
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
>  
>  	return size;
> @@ -1259,7 +1251,6 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
>  
>  	value = amdgpu_dpm_get_sclk_od(adev);
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
>  
>  	return sysfs_emit(buf, "%d\n", value);
> @@ -1317,7 +1308,6 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
>  
>  	value = amdgpu_dpm_get_mclk_od(adev);
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
>  
>  	return sysfs_emit(buf, "%d\n", value);
> @@ -1397,7 +1387,6 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
>  	if (size <= 0)
>  		size = sysfs_emit(buf, "\n");
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
>  
>  	return size;
> @@ -1485,7 +1474,6 @@ static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
>  	/* get the sensor value */
>  	r = amdgpu_dpm_read_sensor(adev, sensor, query, &size);
>  
> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  
>  	return r;
> @@ -1601,7 +1589,6 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
>  
>  	amdgpu_asic_get_pcie_usage(adev, &count0, &count1);
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
>  
>  	return sysfs_emit(buf, "%llu %llu %i\n",
> @@ -1734,7 +1721,6 @@ static ssize_t amdgpu_get_apu_thermal_cap(struct device *dev,
>  	else
>  		size = sysfs_emit(buf, "failed to get thermal limit\n");
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
>  
>  	return size;
> @@ -1807,7 +1793,6 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
>  
>  	size = amdgpu_dpm_get_pm_metrics(adev, buf, PAGE_SIZE);
>  
> -	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
>  
>  	return size;
> @@ -1854,7 +1839,6 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
>  	memcpy(buf, gpu_metrics, size);
>  
>  out:
> -	pm_runtime_mark_last_busy(ddev->dev);
>  	pm_runtime_put_autosuspend(ddev->dev);
>  
>  	return size;
> @@ -2722,7 +2706,6 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>  
>  	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>  
> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  
>  	if (ret)
> @@ -2851,7 +2834,6 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
>  
>  	err = amdgpu_dpm_get_fan_speed_pwm(adev, &speed);
>  
> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  
>  	if (err)
> @@ -2879,7 +2861,6 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
>  
>  	err = amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
>  
> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  
>  	if (err)
> @@ -2941,7 +2922,6 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
>  
>  	err = amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
>  
> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  
>  	if (err)
> @@ -3012,7 +2992,6 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
>  
>  	ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>  
> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  
>  	if (ret)
> @@ -3053,7 +3032,6 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
>  
>  	err = amdgpu_dpm_set_fan_control_mode(adev, pwm_mode);
>  
> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);

Monitoring not affecting runtime PM is valid reasoning for get
operations, but not so much for set operations.

Thanks,
Lijo
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  
>  	if (err)
> @@ -3186,7 +3164,6 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
>  	else
>  		size = sysfs_emit(buf, "\n");
>  
> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  
>  	return size;
> @@ -3269,7 +3246,6 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
>  
>  	err = amdgpu_dpm_set_power_limit(adev, value);
>  
> -	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  
>  	if (err)
> @@ -3717,7 +3693,6 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
>  	if (size == 0)
>  		size = sysfs_emit(buf, "\n");
>  
> -	pm_runtime_mark_last_busy(adev->dev);
>  	pm_runtime_put_autosuspend(adev->dev);
>  
>  	return size;
> @@ -4694,7 +4669,6 @@ static int amdgpu_debugfs_pm_info_show(struct seq_file *m, void *unused)
>  	seq_printf(m, "\n");
>  
>  out:
> -	pm_runtime_mark_last_busy(dev->dev);
>  	pm_runtime_put_autosuspend(dev->dev);
>  
>  	return r;
