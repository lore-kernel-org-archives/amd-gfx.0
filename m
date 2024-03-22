Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812C8C47DD9
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Mar 2024 08:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B1510F0B9;
	Fri, 22 Mar 2024 08:05:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rKsKP34z";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B30D10F075
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Mar 2024 08:05:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0IXkYzl2go9mbL8NdSPRIS6jmdPFZh46wxJ6UwufYcMo2XwgaIx67Xw14sTEvi3ZZlDVelvu3wkoWQYwZ2ffReNt0e8BRFmyQ85Nw5DHnUWhQqgT+I44UDEMeFAdN1OGnZdSN9Lx0w3mEKwXgqHPuSl103wbwHXp6w4A5ykLLGZxvjgaDr4cjSbGZxpOrd1Wb4NjXKDvaHx6wxOjzMThqWRJVDhVwfxixj+WrmV9BWfhuBVcj8sIcuzZRsyEQQlCX9YPkIBPRLAYwnjxTOn65oGgNg1r708sMakxPYS8/RP8dGtMmvn1nPjR4OcxSo6E6GoU0C2pa20xYeBD3mzjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHQL90CEyhbaA/jzcfm1z9gDVC8rTJ7rH3Q0+4OhBKw=;
 b=Lf874EQMT1vJPldPAuvPOGYORNBJfL4pqfe+/NFH2M4sB/pXC/joyTzJo9N6xQwf20KkfFZjChvxo0vMZT4YC8AmBCMPNQ5Kzgy1i/x5e7rHd1soe/rbQMqzoHZ219ye+jNFGj+xQjMVKqxZ8PeNUI/bQjYqimA39pUHu5fpvXhK8lbSB94GCkpECIDrxd6hkALy+oRoHPZ9R1i5Z0kPdlqBUDWE1wiBS6b/O6rX43SVGnCGAHVth+ncTsblPddGjee0i6j5lUYnWUzWZw9JzWgV+jG3tfQ5WsQiZbDqPiO+ZzjwtcIAuJDNDN8PEa5moq/4edl3fDstbLff1/RR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHQL90CEyhbaA/jzcfm1z9gDVC8rTJ7rH3Q0+4OhBKw=;
 b=rKsKP34zLk7Qhp9kSc5qNLW0k7qMMFY46upiS/wRRCpMKwlk4kSqUZ1jlwpWOjBOOkzX6nlWyNWXIlw+HAnrT/vA9i0qRTXx3wGLqEx7GgRYC+mrT4sZc7D7MB8GoVfTDxrklnu1hjq06/iJClLk50fQ37DmFrqnLTiKN41l4G4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB9021.namprd12.prod.outlook.com (2603:10b6:610:173::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.34; Fri, 22 Mar 2024 08:05:39 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7386.025; Fri, 22 Mar 2024
 08:05:39 +0000
Message-ID: <01a3e317-d18b-4032-a9f6-275f88b4d078@amd.com>
Date: Fri, 22 Mar 2024 13:35:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix truncation in smu_v11_0_init_microcode
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240322070351.8102-1-srinivasan.shanmugam@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240322070351.8102-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::18) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: 1647d443-b91e-4288-b340-08dc4a46dc6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HyFaIae4JDMTrUJsWswH1lHjyKqNsVDnl8xzyGkWRDn/JVb1U5+58m6EIp+qZ+wU/7WEx8rjw5CmfgQwJYKXEkIT+eDLELsLqvEff+X60Nt0CR0eOGIcMceGNg0ebtIjg8IOEjz4pZAuYQ7RrP7WrzNL4cLSnXWV5vSxPe5H5EaYT7R/hd2CyGAgdeweYvG2eW53UEfWjxL8lZB1YqyUWgu8QXAI0DibzpLxP9NISPF0XR6hWWaBkAk0On5h6F973EAEiro0cwi4pM4miOIZnnDOvavrJcacmD8gtbOgekpj+/NvITDTNNv1izmzhBkLBuEcerbXIEohfCnfZrh/utgpS/TbOkoOD108lSHXnQbBzS8u8YmW2JoKPsW5TmVxo5sWaX3kpUVvNXvtG993DaWfJSelSHPPmZ1kaOvwU1mtR+ZFdNYOPV/h+YxfxTZK/Om3u9r5OcBUWZoIqOyh5sR9WMfv0hEiAPU4qPfUY35XbwDSPMAXwnND77pfnySBmhptfBQt+ju4aHe/0GSORVp3rYQb/3hQ4oViLMH8Kv6mfvC48xWrwqJ+6/iHv+uiZ964DvNs2B8jCID3a+1aVoF/b+Hfbxr/Olo/KVWp+QKGC/PVaYEkBfxmObc28rs0cKjdhFx+zDsHxiS+RIuNYb+rhD31LwyVaQjTDgr8/EE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXNsclJXSGhIZ0g5MEd0M1BMdzVDaktzZmZ4TDQyY1RHQ0I3UTJ2YkRVd3dy?=
 =?utf-8?B?cEFUdEp1eEhPdWE1eUJqaUY4dHAwWEQyWmd3cXpaZnRiY0pZNGhYdGV1SGdQ?=
 =?utf-8?B?MHh0WUpMN0NqZE1IL1dNZW04NVMrVHdqRGduZnhaY0RkZ1hyZ3ptMWNMWi82?=
 =?utf-8?B?cThEeXp0QTRBS3FwM1R0Witoa0I5SnQ5M05HVHpkc0xmMUxtZFQrZnlPVDVa?=
 =?utf-8?B?cUZ0SjJONEdDcmNEWDNuQUIyNDZJQXZsdm5Zai90OTIwOFVpOWF3VVZ1K3VN?=
 =?utf-8?B?T3NoM2dLV21CSmtuTWdCUGlLaEZMV052QUYwaEQrZzFZSVkzWEs4ZERmb2VW?=
 =?utf-8?B?UU0wczVVcUNsZTJMQnY2cXRHbVMzRTdiQ0J0TlJKeUo4bndXUi8veVRwSDhj?=
 =?utf-8?B?TjBOY1lXV1BhVFdiNlV1UnlYRDEvc1dXYjhtQjhSQkRTcVhYallobldua3o4?=
 =?utf-8?B?bEdvb0hnQUJFVDZTVXNWT0N0OGNSbndpeGRuRnFTN0dsK2xnNW9tQm9VVFdr?=
 =?utf-8?B?Vm1QVVNTQVdKekhiOGkxRnVpVG5QY242eURRNVM1emw2K2Y5aTZXM3NteHZj?=
 =?utf-8?B?L3h5ZXlDenkya05hT0hKaWtLY285YUhYNWpPZ2JnUVVBUk5rdkdpeVhWSkRo?=
 =?utf-8?B?dEsvZUNPRWJZRVJrUUp4Z2F1SjFQdHNsdjdpQjJWZVZ3OEtrOFdrUzRvOElx?=
 =?utf-8?B?NVppem9kQ3pPOW42SWtFMENiRUhWSklFZDRKbGRvY1dEM0dYY1ZjQS9lbjdn?=
 =?utf-8?B?NWM1TlUzUGYvNjFWZVlIakpyV09wRTVoblpHKzdsM2NPR3RnaG9FTjRuQkxw?=
 =?utf-8?B?TFZFVHVPRmtFREhYVXl4dmMvL3BoeFpGWUFBUUxDS3lzQzhmd3lNY2lDWHNQ?=
 =?utf-8?B?SGFZMThIeit4eVhDb213cUN0enpVYm9vQzdHS2ppWitGNjZCbGhhTXJZSDRG?=
 =?utf-8?B?MXVoTDhwdmtmbHllRjhxQVBYeW5vb0xwbWZReEgyQlhNZGpuYUNhYUxSMjg0?=
 =?utf-8?B?K0pFL2ZLUGlHWkUxbU15djlIdUR1Sy9hVERTN1MrQkdSWjhGRUF5L1ZXeGdG?=
 =?utf-8?B?ZzNoQnRaWmw4MDQ5V3ltUE9jZ0JrMDdKeCtRcWNTVEgrT05nRmFuaFYzSDIx?=
 =?utf-8?B?WW5kKzJvNlJYZnBROFJhUUxhYUZmQkhLRVBXUExOK2JtVGlzejdpYWFlSEtZ?=
 =?utf-8?B?SW85MFRHM2xCUVZ0ZW1RckhYZWE0NjZ2ekVOMDRoL0dUMXJXY2theTR4a3Ev?=
 =?utf-8?B?MXFqK3ZDYTVkTjVoeFl6dDcrSSt1Q2Q0aWtzdU1jQ2U0cGtzUVprNytFZ2Z3?=
 =?utf-8?B?dWZxeXA1OGV1b0JObElSVTJUSzF0UEdQcDZpQ0tWNTIveTdiYXR3NitUVjht?=
 =?utf-8?B?V0tNTkRiQlU2UGtqVTdyVFZESmp3UlA2YTJpZms2MnZnTVdMaDgvMUMvVmhH?=
 =?utf-8?B?cDVoU0doQXJDYk8rTlB6anRUK3gxNWhzZ0V6ek55ZmlxUThZWEJDbnZhUVJV?=
 =?utf-8?B?UTBiOGk2K3BGdGYycUxCVDlhTXQ0VmY4VnF2QVhWbWhhdlVDR1Rmc2xwQTVD?=
 =?utf-8?B?NzhTUG5YZ0NNYlpTZ3k5U2tKWmU5WWtncjBVOXhQZlMzRkNpNkpNcVR1bmVN?=
 =?utf-8?B?bkRyVzhRdHVJOHpyTGVlaC9pamdLdXhJSCtQMkhQYlFMU2J6VC9ST1pYeWpk?=
 =?utf-8?B?bjBlb2xhWHU5UCtta1czYjNITmxXRnNWQkZ3N1BUeDRJeXgwREh5VGVRc0Rn?=
 =?utf-8?B?K1drWE5CWlUwWjI1STJ4Z0Rpb2xSSnNHaWtCZjQ4Zk5WNFEvOXZDL2lwV3Jh?=
 =?utf-8?B?QndYRldsNFRoc3o2SW9YV1JNb1dmVTFaVHpaOGluR2hpWi93YnRFTVByL1ZC?=
 =?utf-8?B?VXNrZjRac2ZRd21OdDQ3QnNIVFE2L256VmFjbldMZDkveGJaNDlFQTRrWlJP?=
 =?utf-8?B?R2s3aURBS0hhOGZ0TldnYXJlT29lU1lOM3NraVhsSFBVQ2FhcHM5MmlsUGdB?=
 =?utf-8?B?WnVFSDhpbndlRy9ISnJlcHdkd3J4c1ZTZGhNK1NzY2JTRG4vb2gwQ1Jpc3E1?=
 =?utf-8?B?YU1FeEU4aFh5Y2tiaXFXcG9sWk5NNjVmK1NhcDJoY2g0RXZZamUvRHc3eGll?=
 =?utf-8?Q?jgpFIHqtnXMcagMJVZdFrATvB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1647d443-b91e-4288-b340-08dc4a46dc6f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 08:05:38.9987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fmUyrMMPnpFO4DuBwqqlLy9KgZELw8d1SUEpHGR+X2ThM6L/fKwAm/gOLAdBs46
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9021
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



On 3/22/2024 12:33 PM, Srinivasan Shanmugam wrote:
> Reducing the size of ucode_prefix to 25 in the smu_v11_0_init_microcode
> function. we ensure that fw_name can accommodate the maximum possible
> string size
> 
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/smu_v11_0.c: In function ‘smu_v11_0_init_microcode’:
> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/smu_v11_0.c:110:54: warning: ‘.bin’ directive output may be truncated writing 4 bytes into a region of size between 0 and 29 [-Wformat-truncation=]
>   110 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
>       |                                                      ^~~~
> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/smu_v11_0.c:110:9: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 36
>   110 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index f6545093bfc1..5e5da9b16718 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -93,7 +93,7 @@ static void smu_v11_0_poll_baco_exit(struct smu_context *smu)
>  int smu_v11_0_init_microcode(struct smu_context *smu)
>  {
>  	struct amdgpu_device *adev = smu->adev;
> -	char ucode_prefix[30];
> +	char ucode_prefix[25];
>  	char fw_name[SMU_FW_NAME_LEN];
>  	int err = 0;
>  	const struct smc_firmware_header_v1_0 *hdr;
