Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CD6C02193
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 15:42:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B34C10E69D;
	Tue,  4 Feb 2025 15:42:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QUHdXWbu";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 201E710E69D
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 15:40:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+7KGa7WkEd80CQ7gBQIEMinBDAPpJ1r5OBA03DqvTUA3VepKKKPhtkvUI51V97ZEZ90/Xz8stgf6zo9gaFVn60v7u9Qtj000e5sGWeq1PWobP0EDV9dq/fbpFb2i7b7jRFggj+aPjbcTomOOqD4suN0oG0GSjCQHr0ym9JMP+TdmZLN568svmtOXeQkJtueWpEzO8W0V/saDaMTjxb2/eFfXM4ECS+TivosKU5MgQO1ymleuZZjnhD01gPZHYzdhytnzLkFSw/mfSqJoLv8MXTHkRanoBsBIRuM4VEmkboi7vnzqq/+m603cWDi2xUyPhsD74CNTHVLVR3xzAdpeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sc/cTMByqtSXmbtwkmtOmXtevoGcRoDv9cJxSfis3DM=;
 b=jscIq9VO1Q6gs0PbrGQNCEPmlLUeiFOrqZM4fQPKvILWp6N15oVkEv5W7Lhfhtv3v2hFmz8vwunwQEH2mY36F2MtJxPldpvygv1rqAhBQYs6hAKofV/So5Gxc7tr/Vm8VOFaa7ebbV8wH5y1CcYrRipKoRhXZR0AlAiuVTRIKqCLMnV7lvDpz5+XroH53/U8ak4Zy6CFaYOoM7C4d5kV4Au1wZn8puUoKSEo6BvUflwnGbD8KwnqyBZiqe+oEXDeb9IcTQJIDGmyF0eP2NUQQOWE1j3HdKK77CeWVOW8YOUT2pLbvEIZgiBJmkl2/mt7ELq9AaQ+4+8IiHDHvveTLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sc/cTMByqtSXmbtwkmtOmXtevoGcRoDv9cJxSfis3DM=;
 b=QUHdXWbuRe61nJr52whRQ9wKZZxvzfaRkyqgt23V85AUhRuOBieyXpgP/9wIfNYrUxv8fsp1rXgK9xjaMLSpJ70C+26wE9/SAPdKmoDRXXi669kAJha3DkEMcT3MN5h/LAOOXYvaeSJ7CpxGlJFQTJTCu2P8iLvenXm8zmC1gD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by IA1PR12MB8585.namprd12.prod.outlook.com (2603:10b6:208:451::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 15:40:07 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 15:40:07 +0000
Content-Type: multipart/alternative;
 boundary="------------gkmZzW8pRTQFqX7CJy9Hq9PB"
Message-ID: <50d1102b-8c02-4b15-a004-d2f8c34fafe6@amd.com>
Date: Tue, 4 Feb 2025 10:40:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/44] drm/amdgpu/vcn3.0: split code along instances
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-3-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-3-alexander.deucher@amd.com>
X-ClientProxiedBy: YQZPR01CA0145.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::11) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|IA1PR12MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: a3dd336d-2e16-49d4-0df0-08dd45323363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDZrK0ZxZC9yckZTOFA5Y2tNSWs1RkJ1c25LZGYrTkdjejF0RmJkR28wRHE1?=
 =?utf-8?B?Q2RwTkdRaXFRbU1oUEszUmQ2dmEvZmc3NHVlWGx2Z2dKZWJ0Nlo3V2Q2TWxW?=
 =?utf-8?B?bWVHUjh3eFgwbVNTcVZ1RkxXdnpSS0RVU2lJa09UZVg4QVhUSjNQQlU5aUhs?=
 =?utf-8?B?Q1kzOXpYeTRpUlRjbmFCVC9OV0xNSUtzNEdrVldpOG9UQ2dFSWhNdEU5WWVR?=
 =?utf-8?B?ZXYzdjFHSGZDMWtreUpxbzFxVnptV2xJRHVoakh2eTJNQkl2S0tkQ2JTK3E3?=
 =?utf-8?B?YTExME1tdmZMQWtxbXdGK0YzMW43aURCdFdpTU00MXVWZHlINXRoRTlEV3Q5?=
 =?utf-8?B?akFuYnJEY0gwRUxpN3NZem9kd0w5eFdFMTlSR2hVaWY4aUd2dytKeVNKcVcy?=
 =?utf-8?B?U01oU1VDcTBOZDhYYmhLL2ZYSmo0eUI4NDdBMWphNlZWKzJKQnA2S0hKZ09x?=
 =?utf-8?B?SUhXbTNVczVGSnNMU0U2SXlHR3hDazg5d3VVOGYvazhBNUhXWS9HSFlaMnQ4?=
 =?utf-8?B?MEcwSEVoM1BKZW9jRWlhNWNMcjFXN1RhZDl0cEFuaGhqeHg0UnRtNG01WWEy?=
 =?utf-8?B?YVE2bHcvTXJpSXF2bVY3N0F5ZndLM2ZXbEZFNUxjdlA0a3R6ZkFVcUVpMGs4?=
 =?utf-8?B?K1RhR2dxVTN4Z2tUb3gxTkg3OE5GN1cxYXU1Mm9HQjh2bEpXM3pub2JGdjNL?=
 =?utf-8?B?Mk0yeC84MWMvczdLdjIwVHRhTDN0RCtrS1F2TEFldmNRa2VzY2VwV1JwZFVj?=
 =?utf-8?B?OUlqMzRCbUx4aUNyTFhKTGM3b3ZPc1pyaldzYmxzRHBMRThJemFaUGhKM3Uw?=
 =?utf-8?B?Tk1BeXZOQm5CL0N1b0hHcmt4VzFEOWxSWWxlSmRROUJqTkFVNldTYVhQZTFW?=
 =?utf-8?B?ZEdYVGVyQ1BnNlgzb1JPSHNnUjVjL3Z3WHIrSGYyaTZoT1lKNi9WRm9mNnY0?=
 =?utf-8?B?aUk5UUM3VCtxZGNwcUlhaTRYdExqaEZYRDRMYmNWKy81cnl5N0xoSzd1aVQz?=
 =?utf-8?B?eFZwNDBQT2R6R1FEOTZ4Qzl2bnhsRWk2aDBwNmVmRktacDBFUjhwejNwNWV0?=
 =?utf-8?B?Ym9CUDRIcXQxVFhoVzdDRFphUWF6aUFWRm53L0tMaFJoNFpjRUtzVmpkaWpZ?=
 =?utf-8?B?T0VvZnpDY0o0VkVHdjljSGxHbFZZVldocUZzTlIyWTUyMmxqZTBkaWlEaXZm?=
 =?utf-8?B?UmZHTGNpUlhBQzVtTHVFR0d2M0Y1b1FVZm03Vk9EcDMvTy80YmVNdjVDcG10?=
 =?utf-8?B?TE1NbU5xMXdlWkhyaXRQVTNkdlB5QkM2NlRCOEovZFJWVzExL2tSZGJlZTJI?=
 =?utf-8?B?cmNXYnI1bGtGK09mcEtUM0V2U0d5MCtpbW1rVkM3N3ROSUZRbExGTVhoa0Iy?=
 =?utf-8?B?c0t1eG0vdHBsdFBTYXVSNHlianhXem01L0NTbGZBVUpsd0F2UXFFU2tpaFBt?=
 =?utf-8?B?clFWeUVab3E1eno1OFFPTzdTVWVrS1BxNldXMHBOVUNqTzZuK0dVT0RQbDBo?=
 =?utf-8?B?d01RRXhPUmdXMjJldUVMWnhMM1dZT0wzNStaMGF5K2lCWWE0KzlpLzB2YzZs?=
 =?utf-8?B?Q3FYNG9iUkVKK3hjYldCZVE3MUdoTVFDdW9NZnVSTnhDR0NmSmx4bThWeHl2?=
 =?utf-8?B?SUthZlhBM3hVRThtMS9zeDExY2xubEtyaHExQWxkWW5LRmpmTDNMeW03QWpN?=
 =?utf-8?B?VEVYU0p6TVFYcDZHOWxPS0JDd2xoZzZwcURqdmw2SHI4NGNrOFRjaWg3SXJn?=
 =?utf-8?B?MG9UVCtyN09MU2NvcFIxbktzZVcvbG1KZm9IcCtheGZCZmMyTVRjYXpkTDRk?=
 =?utf-8?B?UGJrR3BpeUdWU25MeHRsbTFGM3IyWjVKVTFJdk9SdWdEQk5nNnljeHRlK01I?=
 =?utf-8?Q?0xaM//H9s7tfB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjdzWTJLY0Q0ckY5bUJUV0p1VkVkNWpSUG8xM1NkSXZhakV1YlUvVzA1aFVi?=
 =?utf-8?B?ZitwdUhuN2VSZGs3MHFLdEJHb2VzanpTTVNhd3hoOGROcE5ISzlQeWdIVXU4?=
 =?utf-8?B?NkhXYWZBV3ZmUVlqZTBOZUlUanoxT1ZJWFRyZk4rQmVqWW4rZGZHd2Q1eURx?=
 =?utf-8?B?a1FGVmp0dnBLTUFuTVZpN1pvdTRqRGxNWnJtNjJBNCtTRFozZE4wYlFJOSsr?=
 =?utf-8?B?cW0xYkp2Y2lsMW8yQ2VqQkorWHJMWUdjSm5qdnZKWWVObDNnbWEyUHhxcTVY?=
 =?utf-8?B?L1RoWTJiU1N1NTk0OHNjLytURndkWWxlKyttQXNzdTdCVjl3NTlKU0hEaE1I?=
 =?utf-8?B?VTkwalk5bmxZeXoxZVZZZWZsODkwWHRqTnJzbEhrL2xBd1dyTFFWYjlLZXJS?=
 =?utf-8?B?dm9Cc3JGWXN3akN1bEpFa2dWZUxZbkRKSzNCbGQ0OHJCWXZHZnV2TG9XNzkv?=
 =?utf-8?B?a2JEcEp0T0p5bUtZL3lrbkh6LzAyTzR6Q0tQd0Uybkg2QzcwU0YxbXhHSnNs?=
 =?utf-8?B?MWJvOExpYmFVUng3TnJ2MzVLTy9pcEpPbnZMZDlrcVJ1aVpBbFJkSGNRNU80?=
 =?utf-8?B?ZnFBdktKeTdkQUkzeWxIMFg3RkFXZ0NEMTYwTlEzQTZWaDBGTHVrWW8wNDB6?=
 =?utf-8?B?cVlvRktvSi9IZGVpQzhJRUJTcWpVL0p2RDFqYmJFcis5aTJ2bG0rWHNQTmtQ?=
 =?utf-8?B?WFQrTkw3STdIRDh5RGJ2SkF5aFBXdU40ZmR5Q1N5WksrR204WTBMdnMrN0U5?=
 =?utf-8?B?bkVlLzNGMEtwaFh3bm9xT3BWemx3MGswNVdYbE9keHR4cEZhNllobXc3SEpo?=
 =?utf-8?B?RFpZRVpWcktydkxFUU4vRzZGaWkvaTVZd3BBWkFqY0ZFMDlhcTNGTUdMbWVw?=
 =?utf-8?B?VmFRT0o2dDVYTXd5QVZnRWJqVEJTaDB6VXVJZUtmUnRiM1lUd2dadFFzZmFm?=
 =?utf-8?B?MjNRTDlUSWhhbVFERjU5Y0RjSG9NVUtjWmV1MHd0N2U5VGlIR3h0by8wTFln?=
 =?utf-8?B?VUlDV0xKVnpSQVBLaUcvVit1aXZnYzdXZ1pDbmxkTS85ZmhaWlNGTFVJTkto?=
 =?utf-8?B?RmxVNStUSXBQbXQ3Z3VacDd0T1hPbVFFNW4zV1FhQXFibTFUS2FiVDZSd0JF?=
 =?utf-8?B?VWxZNEFGTnFiTytxV3pHaGNnSFRuQy91bkdROTRWQWdXRGRXbS8zb1NjQWZj?=
 =?utf-8?B?UmEwUTBKSTRlUmhZeGZKS1k1MEpjWmNjVUtKT3BsTWJsT28xOGZzOHVMb3RF?=
 =?utf-8?B?WHJESlkvZ0V0NSthV2pRMEx0cnhQNUs4NURWUWVRYkswd0tZQ0pPUnhaMUxI?=
 =?utf-8?B?RE41ZkVTVUl2dTRteVNNRmRWSG0yTFVJSk9yVzdTRHRCcS9xTGhYbGg2eDdE?=
 =?utf-8?B?dWROcEZOb21kb3VzL09sTHlDN0VpNllyZElnOU04OG1yRWovc2N1dDUxaURi?=
 =?utf-8?B?dWpaVzJBb1FGNG5iN3FoY3krb3htRW9tbGIwUFZVenJUUlAyLzJQWXllWFo4?=
 =?utf-8?B?Q09DRDFhTzJvTUFkd2M3KzF0VWJvK2syYTQ1Z3o2cVEyTzREMjFoc2U5dHho?=
 =?utf-8?B?cHhGS1VBNEllS1FOQjdDTHcwcmpUYkxPcjA0aE1qYlhibUJqdXh3L3FJRi9K?=
 =?utf-8?B?MThHcHlvc0lVUXp4V0FqbHBwcEZzZDk2RCtpRGZVSHJpNzJaSjhGTndNUEtB?=
 =?utf-8?B?UUw3KzZWYWd0N0JEcmNvdFhBT3dtRUwxV1I0VmZISXNtc1JqZXBmcmIyQkd0?=
 =?utf-8?B?M1RReGl2bTk1VHVlQ1JsamZ5dDhreXBlNXRsa0c2OUFsK2ZsR1hrelNJcitj?=
 =?utf-8?B?NXRLUHdwZmI5MTFobjVEdkhycjREc0J1YldZQjN2UUNONkZJSThibVNPU21p?=
 =?utf-8?B?bTI5RWxKWFpOSUJFaXo2TkR6TVVibEQvUnhGNXZPRVpIbHU3c3dJOFlyMXFN?=
 =?utf-8?B?T3NSRGNHWlBncXY0OWl4T094elRudW9rU0wxTW9aNUlWMmE1T2Qrc3BBSWMz?=
 =?utf-8?B?V0NGcG9DODgyS0ozMlIxQm9nZEtRVkcyNXNtK1NWQ0JyeG9uWHRlY1FYQ2tH?=
 =?utf-8?B?b1VrWEpyL2FDZitQenZDemhSb1FkSWowVzAwOTFua3paaFY2clYzODExZHAw?=
 =?utf-8?Q?FHz3I2dZ9qvWtdCrjmZheHSaf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3dd336d-2e16-49d4-0df0-08dd45323363
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 15:40:07.2026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9lQUP7NfYMsl2RoyruB/qxJeHOCkzp5F/JpJ6SNMvy/ej7XfJQ+AQT9wGN35Vtgs+BdTpKNvpxV6O/S/wv2sAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8585
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

--------------gkmZzW8pRTQFqX7CJy9Hq9PB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:56, Alex Deucher wrote:
> Split the code on a per instance basis.  This will allow
> us to use the per instance functions in the future to
> handle more things per instance.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 436 +++++++++++++-------------
>   1 file changed, 213 insertions(+), 223 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 63ddd4cca9109..a3627700ed48d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1134,192 +1134,186 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
>   	return 0;
>   }
>   
> -static int vcn_v3_0_start(struct amdgpu_device *adev)
> +static int vcn_v3_0_start(struct amdgpu_device *adev, int i)
>   {
>   	volatile struct amdgpu_fw_shared *fw_shared;
>   	struct amdgpu_ring *ring;
>   	uint32_t rb_bufsz, tmp;
> -	int i, j, k, r;
> +	int j, k, r;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->pm.dpm_enabled)
> -			amdgpu_dpm_enable_vcn(adev, true, i);
> -	}
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return 0;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> +	if (adev->pm.dpm_enabled)
> +		amdgpu_dpm_enable_vcn(adev, true, i);
>   
> -		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -			r = vcn_v3_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> -			continue;
> -		}
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> +		return vcn_v3_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
>   
> -		/* disable VCN power gating */
> -		vcn_v3_0_disable_static_power_gating(adev, i);
> +	/* disable VCN power gating */
> +	vcn_v3_0_disable_static_power_gating(adev, i);
>   
> -		/* set VCN status busy */
> -		tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> -		WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
> +	/* set VCN status busy */
> +	tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> +	WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
>   
> -		/*SW clock gating */
> -		vcn_v3_0_disable_clock_gating(adev, i);
> +	/* SW clock gating */
> +	vcn_v3_0_disable_clock_gating(adev, i);
>   
> -		/* enable VCPU clock */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> -			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
> -
> -		/* disable master interrupt */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
> -			~UVD_MASTINT_EN__VCPU_EN_MASK);
> -
> -		/* enable LMI MC and UMC channels */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
> -			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> -
> -		tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
> -		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -		tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -		WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
> -
> -		/* setup mmUVD_LMI_CTRL */
> -		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp |
> -			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
> -			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> -			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> -			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> -
> -		/* setup mmUVD_MPC_CNTL */
> -		tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
> -		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> -		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> -		WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
> -
> -		/* setup UVD_MPC_SET_MUXA0 */
> -		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
> -			((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> -			(0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> -			(0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> -			(0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> -
> -		/* setup UVD_MPC_SET_MUXB0 */
> -		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
> -			((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> -			(0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> -			(0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> -			(0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> -
> -		/* setup mmUVD_MPC_SET_MUX */
> -		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
> -			((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> -			(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> -			(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> -
> -		vcn_v3_0_mc_resume(adev, i);
> -
> -		/* VCN global tiling registers */
> -		WREG32_SOC15(VCN, i, mmUVD_GFX10_ADDR_CONFIG,
> -			adev->gfx.config.gb_addr_config);
> -
> -		/* unblock VCPU register access */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
> -			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> -
> -		/* release VCPU reset to boot */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> -			~UVD_VCPU_CNTL__BLK_RST_MASK);
> +	/* enable VCPU clock */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> +		 UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
>   
> -		for (j = 0; j < 10; ++j) {
> -			uint32_t status;
> +	/* disable master interrupt */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
> +		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
>   
> -			for (k = 0; k < 100; ++k) {
> -				status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
> -				if (status & 2)
> -					break;
> -				mdelay(10);
> -			}
> -			r = 0;
> -			if (status & 2)
> -				break;
> +	/* enable LMI MC and UMC channels */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
> +		 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
>   
> -			DRM_ERROR("VCN[%d] decode not responding, trying to reset the VCPU!!!\n", i);
> -			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> -				UVD_VCPU_CNTL__BLK_RST_MASK,
> -				~UVD_VCPU_CNTL__BLK_RST_MASK);
> -			mdelay(10);
> -			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> -				~UVD_VCPU_CNTL__BLK_RST_MASK);
> +	tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
> +	tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +	tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +	WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
> +
> +	/* setup mmUVD_LMI_CTRL */
> +	tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp |
> +		     UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
> +		     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> +		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> +		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> +
> +	/* setup mmUVD_MPC_CNTL */
> +	tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
> +	tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> +	tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> +	WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
> +
> +	/* setup UVD_MPC_SET_MUXA0 */
> +	WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
> +		     ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> +		      (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> +		      (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> +		      (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> +
> +	/* setup UVD_MPC_SET_MUXB0 */
> +	WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
> +		     ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> +		      (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> +		      (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> +		      (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> +
> +	/* setup mmUVD_MPC_SET_MUX */
> +	WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
> +		     ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> +		      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> +		      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> +
> +	vcn_v3_0_mc_resume(adev, i);
> +
> +	/* VCN global tiling registers */
> +	WREG32_SOC15(VCN, i, mmUVD_GFX10_ADDR_CONFIG,
> +		     adev->gfx.config.gb_addr_config);
> +
> +	/* unblock VCPU register access */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
> +		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>   
> +	/* release VCPU reset to boot */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> +		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +
> +	for (j = 0; j < 10; ++j) {
> +		uint32_t status;
> +
> +		for (k = 0; k < 100; ++k) {
> +			status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
> +			if (status & 2)
> +				break;
>   			mdelay(10);
> -			r = -1;
>   		}
> +		r = 0;
> +		if (status & 2)
> +			break;
>   
> -		if (r) {
> -			DRM_ERROR("VCN[%d] decode not responding, giving up!!!\n", i);
> -			return r;
> -		}
> +		DRM_ERROR("VCN[%d] decode not responding, trying to reset the VCPU!!!\n", i);
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> +			 UVD_VCPU_CNTL__BLK_RST_MASK,
> +			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +		mdelay(10);
> +		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> +			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +
> +		mdelay(10);
> +		r = -1;
> +	}
>   
> -		/* enable master interrupt */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
> -			UVD_MASTINT_EN__VCPU_EN_MASK,
> -			~UVD_MASTINT_EN__VCPU_EN_MASK);
> +	if (r) {
> +		DRM_ERROR("VCN[%d] decode not responding, giving up!!!\n", i);
> +		return r;
> +	}
>   
> -		/* clear the busy bit of VCN_STATUS */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
> -			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> +	/* enable master interrupt */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
> +		 UVD_MASTINT_EN__VCPU_EN_MASK,
> +		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
>   
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
> +	/* clear the busy bit of VCN_STATUS */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
> +		 ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>   
> -		ring = &adev->vcn.inst[i].ring_dec;
> -		/* force RBC into idle state */
> -		rb_bufsz = order_base_2(ring->ring_size);
> -		tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
> -		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
> -		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
> -		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
> -		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
> -		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
>   
> -		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> -		fw_shared->multi_queue.decode_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
> +	ring = &adev->vcn.inst[i].ring_dec;
> +	/* force RBC into idle state */
> +	rb_bufsz = order_base_2(ring->ring_size);
> +	tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
> +	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
> +	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
> +	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
> +	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
> +	WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
>   
> -		/* programm the RB_BASE for ring buffer */
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
> -			lower_32_bits(ring->gpu_addr));
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> -			upper_32_bits(ring->gpu_addr));
> +	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +	fw_shared->multi_queue.decode_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
>   
> -		/* Initialize the ring buffer's read and write pointers */
> -		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
> +	/* programm the RB_BASE for ring buffer */
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
> +		     lower_32_bits(ring->gpu_addr));
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> +		     upper_32_bits(ring->gpu_addr));
>   
> -		WREG32_SOC15(VCN, i, mmUVD_SCRATCH2, 0);
> -		ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
> -		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
> -			lower_32_bits(ring->wptr));
> -		fw_shared->rb.wptr = lower_32_bits(ring->wptr);
> -		fw_shared->multi_queue.decode_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
> -
> -		if (amdgpu_ip_version(adev, UVD_HWIP, 0) !=
> -		    IP_VERSION(3, 0, 33)) {
> -			fw_shared->multi_queue.encode_generalpurpose_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
> -			ring = &adev->vcn.inst[i].ring_enc[0];
> -			WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
> -			WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
> -			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
> -			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> -			WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
> -			fw_shared->multi_queue.encode_generalpurpose_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
> -
> -			fw_shared->multi_queue.encode_lowlatency_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
> -			ring = &adev->vcn.inst[i].ring_enc[1];
> -			WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
> -			WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
> -			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
> -			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
> -			WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
> -			fw_shared->multi_queue.encode_lowlatency_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
> -		}
> +	/* Initialize the ring buffer's read and write pointers */
> +	WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
> +
> +	WREG32_SOC15(VCN, i, mmUVD_SCRATCH2, 0);
> +	ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
> +	WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
> +		     lower_32_bits(ring->wptr));
> +	fw_shared->rb.wptr = lower_32_bits(ring->wptr);
> +	fw_shared->multi_queue.decode_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
> +
> +	if (amdgpu_ip_version(adev, UVD_HWIP, 0) !=
> +	    IP_VERSION(3, 0, 33)) {
> +		fw_shared->multi_queue.encode_generalpurpose_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
> +		ring = &adev->vcn.inst[i].ring_enc[0];
> +		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
> +		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
> +		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
> +		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> +		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
> +		fw_shared->multi_queue.encode_generalpurpose_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
> +
> +		fw_shared->multi_queue.encode_lowlatency_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
> +		ring = &adev->vcn.inst[i].ring_enc[1];
> +		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
> +		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
> +		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
> +		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
> +		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
> +		fw_shared->multi_queue.encode_lowlatency_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
>   	}
>   
>   	return 0;
> @@ -1565,79 +1559,73 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>   	return 0;
>   }
>   
> -static int vcn_v3_0_stop(struct amdgpu_device *adev)
> +static int vcn_v3_0_stop(struct amdgpu_device *adev, int i)
>   {
>   	uint32_t tmp;
> -	int i, r = 0;
> +	int r = 0;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return 0;
>   
> -		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -			r = vcn_v3_0_stop_dpg_mode(adev, i);
> -			continue;
> -		}
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> +		return vcn_v3_0_stop_dpg_mode(adev, i);
>   
> -		/* wait for vcn idle */
> -		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> -		if (r)
> -			return r;
> +	/* wait for vcn idle */
> +	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> +	if (r)
> +		return r;
>   
> -		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> -			UVD_LMI_STATUS__READ_CLEAN_MASK |
> -			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> -			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> -		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
> -		if (r)
> -			return r;
> +	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> +		UVD_LMI_STATUS__READ_CLEAN_MASK |
> +		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> +		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> +	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
> +	if (r)
> +		return r;
>   
> -		/* disable LMI UMC channel */
> -		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
> -		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> -		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
> -		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
> -			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> -		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
> -		if (r)
> -			return r;
> +	/* disable LMI UMC channel */
> +	tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
> +	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> +	WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
> +	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
> +		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> +	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
> +	if (r)
> +		return r;
>   
> -		/* block VCPU register access */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
> -			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> -			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +	/* block VCPU register access */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
> +		 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> +		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>   
> -		/* reset VCPU */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> -			UVD_VCPU_CNTL__BLK_RST_MASK,
> -			~UVD_VCPU_CNTL__BLK_RST_MASK);
> +	/* reset VCPU */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> +		 UVD_VCPU_CNTL__BLK_RST_MASK,
> +		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
>   
> -		/* disable VCPU clock */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> -			~(UVD_VCPU_CNTL__CLK_EN_MASK));
> +	/* disable VCPU clock */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> +		 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
>   
> -		/* apply soft reset */
> -		tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
> -		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -		WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
> -		tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
> -		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -		WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
> +	/* apply soft reset */
> +	tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
> +	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +	WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
> +	tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
> +	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +	WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
>   
> -		/* clear status */
> -		WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
> +	/* clear status */
> +	WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
>   
> -		/* apply HW clock gating */
> -		vcn_v3_0_enable_clock_gating(adev, i);
> +	/* apply HW clock gating */
> +	vcn_v3_0_enable_clock_gating(adev, i);
>   
> -		/* enable VCN power gating */
> -		vcn_v3_0_enable_static_power_gating(adev, i);
> -	}
> +	/* enable VCN power gating */
> +	vcn_v3_0_enable_static_power_gating(adev, i);
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->pm.dpm_enabled)
> -			amdgpu_dpm_enable_vcn(adev, false, i);
> -	}
> +	if (adev->pm.dpm_enabled)
> +		amdgpu_dpm_enable_vcn(adev, false, i);
>   
>   	return 0;
>   }
> @@ -2163,7 +2151,7 @@ static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   					  enum amd_powergating_state state)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int ret;
> +	int ret = 0, i;
>   
>   	/* for SRIOV, guest should not control VCN Power-gating
>   	 * MMSCH FW should control Power-gating and clock-gating
> @@ -2177,10 +2165,12 @@ static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	if (state == adev->vcn.cur_state)
>   		return 0;
>   
> -	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v3_0_stop(adev);
> -	else
> -		ret = vcn_v3_0_start(adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (state == AMD_PG_STATE_GATE)
> +			ret |= vcn_v3_0_stop(adev, i);
> +		else
> +			ret |= vcn_v3_0_start(adev, i);
> +	}
>   
>   	if (!ret)
>   		adev->vcn.cur_state = state;
--------------gkmZzW8pRTQFqX7CJy9Hq9PB
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-31 11:56, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250131165741.1798488-3-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Split the code on a per instance basis.  This will allow
us to use the per instance functions in the future to
handle more things per instance.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="mark1tk8wrane" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-3-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 436 +++++++++++++-------------
 1 file changed, 213 insertions(+), 223 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 63ddd4cca9109..a3627700ed48d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1134,192 +1134,186 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	return 0;
 }
 
-static int vcn_v3_0_start(struct amdgpu_device *adev)
+static int vcn_v3_0_start(struct amdgpu_device *adev, int i)
 {
 	volatile struct amdgpu_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
-	int i, j, k, r;
+	int j, k, r;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, true, i);
-	}
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
+		return 0;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
+	if (adev-&gt;pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, true, i);
 
-		if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v3_0_start_dpg_mode(adev, i, adev-&gt;vcn.indirect_sram);
-			continue;
-		}
+	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG)
+		return vcn_v3_0_start_dpg_mode(adev, i, adev-&gt;vcn.indirect_sram);
 
-		/* disable VCN power gating */
-		vcn_v3_0_disable_static_power_gating(adev, i);
+	/* disable VCN power gating */
+	vcn_v3_0_disable_static_power_gating(adev, i);
 
-		/* set VCN status busy */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
-		WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
+	/* set VCN status busy */
+	tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
+	WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
 
-		/*SW clock gating */
-		vcn_v3_0_disable_clock_gating(adev, i);
+	/* SW clock gating */
+	vcn_v3_0_disable_clock_gating(adev, i);
 
-		/* enable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
-
-		/* disable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
-			~UVD_MASTINT_EN__VCPU_EN_MASK);
-
-		/* enable LMI MC and UMC channels */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
-			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
-
-		tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
-		tmp &amp;= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		tmp &amp;= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
-
-		/* setup mmUVD_LMI_CTRL */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
-		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp |
-			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
-			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
-			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
-			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
-
-		/* setup mmUVD_MPC_CNTL */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
-		tmp &amp;= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
-		tmp |= 0x2 &lt;&lt; UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
-		WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
-
-		/* setup UVD_MPC_SET_MUXA0 */
-		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
-			((0x1 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
-			(0x2 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
-			(0x3 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
-			(0x4 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
-
-		/* setup UVD_MPC_SET_MUXB0 */
-		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
-			((0x1 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
-			(0x2 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
-			(0x3 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
-			(0x4 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
-
-		/* setup mmUVD_MPC_SET_MUX */
-		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
-			((0x0 &lt;&lt; UVD_MPC_SET_MUX__SET_0__SHIFT) |
-			(0x1 &lt;&lt; UVD_MPC_SET_MUX__SET_1__SHIFT) |
-			(0x2 &lt;&lt; UVD_MPC_SET_MUX__SET_2__SHIFT)));
-
-		vcn_v3_0_mc_resume(adev, i);
-
-		/* VCN global tiling registers */
-		WREG32_SOC15(VCN, i, mmUVD_GFX10_ADDR_CONFIG,
-			adev-&gt;gfx.config.gb_addr_config);
-
-		/* unblock VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
-
-		/* release VCPU reset to boot */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
+	/* enable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
 
-		for (j = 0; j &lt; 10; ++j) {
-			uint32_t status;
+	/* disable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
 
-			for (k = 0; k &lt; 100; ++k) {
-				status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
-				if (status &amp; 2)
-					break;
-				mdelay(10);
-			}
-			r = 0;
-			if (status &amp; 2)
-				break;
+	/* enable LMI MC and UMC channels */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
+		 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
 
-			DRM_ERROR(&quot;VCN[%d] decode not responding, trying to reset the VCPU!!!\n&quot;, i);
-			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-				UVD_VCPU_CNTL__BLK_RST_MASK,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
-			mdelay(10);
-			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-				~UVD_VCPU_CNTL__BLK_RST_MASK);
+	tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
+	tmp &amp;= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	tmp &amp;= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
+
+	/* setup mmUVD_LMI_CTRL */
+	tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
+	WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp |
+		     UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
+		     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
+
+	/* setup mmUVD_MPC_CNTL */
+	tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
+	tmp &amp;= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
+	tmp |= 0x2 &lt;&lt; UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
+	WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
+
+	/* setup UVD_MPC_SET_MUXA0 */
+	WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
+		     ((0x1 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
+		      (0x2 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
+		      (0x3 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
+		      (0x4 &lt;&lt; UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
+
+	/* setup UVD_MPC_SET_MUXB0 */
+	WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
+		     ((0x1 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
+		      (0x2 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
+		      (0x3 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
+		      (0x4 &lt;&lt; UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
+
+	/* setup mmUVD_MPC_SET_MUX */
+	WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
+		     ((0x0 &lt;&lt; UVD_MPC_SET_MUX__SET_0__SHIFT) |
+		      (0x1 &lt;&lt; UVD_MPC_SET_MUX__SET_1__SHIFT) |
+		      (0x2 &lt;&lt; UVD_MPC_SET_MUX__SET_2__SHIFT)));
+
+	vcn_v3_0_mc_resume(adev, i);
+
+	/* VCN global tiling registers */
+	WREG32_SOC15(VCN, i, mmUVD_GFX10_ADDR_CONFIG,
+		     adev-&gt;gfx.config.gb_addr_config);
+
+	/* unblock VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
 
+	/* release VCPU reset to boot */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	for (j = 0; j &lt; 10; ++j) {
+		uint32_t status;
+
+		for (k = 0; k &lt; 100; ++k) {
+			status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
+			if (status &amp; 2)
+				break;
 			mdelay(10);
-			r = -1;
 		}
+		r = 0;
+		if (status &amp; 2)
+			break;
 
-		if (r) {
-			DRM_ERROR(&quot;VCN[%d] decode not responding, giving up!!!\n&quot;, i);
-			return r;
-		}
+		DRM_ERROR(&quot;VCN[%d] decode not responding, trying to reset the VCPU!!!\n&quot;, i);
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
+			 UVD_VCPU_CNTL__BLK_RST_MASK,
+			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+		mdelay(10);
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
+			 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+		mdelay(10);
+		r = -1;
+	}
 
-		/* enable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
-			UVD_MASTINT_EN__VCPU_EN_MASK,
-			~UVD_MASTINT_EN__VCPU_EN_MASK);
+	if (r) {
+		DRM_ERROR(&quot;VCN[%d] decode not responding, giving up!!!\n&quot;, i);
+		return r;
+	}
 
-		/* clear the busy bit of VCN_STATUS */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
-			~(2 &lt;&lt; UVD_STATUS__VCPU_REPORT__SHIFT));
+	/* enable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
+		 UVD_MASTINT_EN__VCPU_EN_MASK,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
 
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
+	/* clear the busy bit of VCN_STATUS */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
+		 ~(2 &lt;&lt; UVD_STATUS__VCPU_REPORT__SHIFT));
 
-		ring = &amp;adev-&gt;vcn.inst[i].ring_dec;
-		/* force RBC into idle state */
-		rb_bufsz = order_base_2(ring-&gt;ring_size);
-		tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
-		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
+	WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
 
-		fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared-&gt;multi_queue.decode_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
+	ring = &amp;adev-&gt;vcn.inst[i].ring_dec;
+	/* force RBC into idle state */
+	rb_bufsz = order_base_2(ring-&gt;ring_size);
+	tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
+	WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
 
-		/* programm the RB_BASE for ring buffer */
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
-			lower_32_bits(ring-&gt;gpu_addr));
-		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
-			upper_32_bits(ring-&gt;gpu_addr));
+	fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
+	fw_shared-&gt;multi_queue.decode_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
 
-		/* Initialize the ring buffer's read and write pointers */
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
+	/* programm the RB_BASE for ring buffer */
+	WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
+		     lower_32_bits(ring-&gt;gpu_addr));
+	WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
+		     upper_32_bits(ring-&gt;gpu_addr));
 
-		WREG32_SOC15(VCN, i, mmUVD_SCRATCH2, 0);
-		ring-&gt;wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
-		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
-			lower_32_bits(ring-&gt;wptr));
-		fw_shared-&gt;rb.wptr = lower_32_bits(ring-&gt;wptr);
-		fw_shared-&gt;multi_queue.decode_queue_mode &amp;= cpu_to_le32(~FW_QUEUE_RING_RESET);
-
-		if (amdgpu_ip_version(adev, UVD_HWIP, 0) !=
-		    IP_VERSION(3, 0, 33)) {
-			fw_shared-&gt;multi_queue.encode_generalpurpose_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
-			ring = &amp;adev-&gt;vcn.inst[i].ring_enc[0];
-			WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring-&gt;wptr));
-			WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring-&gt;wptr));
-			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring-&gt;gpu_addr);
-			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring-&gt;gpu_addr));
-			WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring-&gt;ring_size / 4);
-			fw_shared-&gt;multi_queue.encode_generalpurpose_queue_mode &amp;= cpu_to_le32(~FW_QUEUE_RING_RESET);
-
-			fw_shared-&gt;multi_queue.encode_lowlatency_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
-			ring = &amp;adev-&gt;vcn.inst[i].ring_enc[1];
-			WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring-&gt;wptr));
-			WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring-&gt;wptr));
-			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring-&gt;gpu_addr);
-			WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring-&gt;gpu_addr));
-			WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring-&gt;ring_size / 4);
-			fw_shared-&gt;multi_queue.encode_lowlatency_queue_mode &amp;= cpu_to_le32(~FW_QUEUE_RING_RESET);
-		}
+	/* Initialize the ring buffer's read and write pointers */
+	WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
+
+	WREG32_SOC15(VCN, i, mmUVD_SCRATCH2, 0);
+	ring-&gt;wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
+	WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
+		     lower_32_bits(ring-&gt;wptr));
+	fw_shared-&gt;rb.wptr = lower_32_bits(ring-&gt;wptr);
+	fw_shared-&gt;multi_queue.decode_queue_mode &amp;= cpu_to_le32(~FW_QUEUE_RING_RESET);
+
+	if (amdgpu_ip_version(adev, UVD_HWIP, 0) !=
+	    IP_VERSION(3, 0, 33)) {
+		fw_shared-&gt;multi_queue.encode_generalpurpose_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
+		ring = &amp;adev-&gt;vcn.inst[i].ring_enc[0];
+		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring-&gt;wptr));
+		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring-&gt;wptr));
+		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring-&gt;gpu_addr);
+		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring-&gt;gpu_addr));
+		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring-&gt;ring_size / 4);
+		fw_shared-&gt;multi_queue.encode_generalpurpose_queue_mode &amp;= cpu_to_le32(~FW_QUEUE_RING_RESET);
+
+		fw_shared-&gt;multi_queue.encode_lowlatency_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
+		ring = &amp;adev-&gt;vcn.inst[i].ring_enc[1];
+		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring-&gt;wptr));
+		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring-&gt;wptr));
+		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring-&gt;gpu_addr);
+		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring-&gt;gpu_addr));
+		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring-&gt;ring_size / 4);
+		fw_shared-&gt;multi_queue.encode_lowlatency_queue_mode &amp;= cpu_to_le32(~FW_QUEUE_RING_RESET);
 	}
 
 	return 0;
@@ -1565,79 +1559,73 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 	return 0;
 }
 
-static int vcn_v3_0_stop(struct amdgpu_device *adev)
+static int vcn_v3_0_stop(struct amdgpu_device *adev, int i)
 {
 	uint32_t tmp;
-	int i, r = 0;
+	int r = 0;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
+		return 0;
 
-		if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v3_0_stop_dpg_mode(adev, i);
-			continue;
-		}
+	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG)
+		return vcn_v3_0_stop_dpg_mode(adev, i);
 
-		/* wait for vcn idle */
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
-		if (r)
-			return r;
+	/* wait for vcn idle */
+	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7);
+	if (r)
+		return r;
 
-		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__READ_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_MASK |
-			UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__READ_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* disable LMI UMC channel */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
-		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
-		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
-		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
-			UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	/* disable LMI UMC channel */
+	tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
+	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
+	WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
+	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
+		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* block VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
-			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+	/* block VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
+		 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
 
-		/* reset VCPU */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__BLK_RST_MASK,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
+	/* reset VCPU */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__BLK_RST_MASK,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
 
-		/* disable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
-			~(UVD_VCPU_CNTL__CLK_EN_MASK));
+	/* disable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
+		 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
 
-		/* apply soft reset */
-		tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
-		tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
+	/* apply soft reset */
+	tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
 
-		/* clear status */
-		WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
+	/* clear status */
+	WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
 
-		/* apply HW clock gating */
-		vcn_v3_0_enable_clock_gating(adev, i);
+	/* apply HW clock gating */
+	vcn_v3_0_enable_clock_gating(adev, i);
 
-		/* enable VCN power gating */
-		vcn_v3_0_enable_static_power_gating(adev, i);
-	}
+	/* enable VCN power gating */
+	vcn_v3_0_enable_static_power_gating(adev, i);
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false, i);
-	}
+	if (adev-&gt;pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, false, i);
 
 	return 0;
 }
@@ -2163,7 +2151,7 @@ static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					  enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int ret;
+	int ret = 0, i;
 
 	/* for SRIOV, guest should not control VCN Power-gating
 	 * MMSCH FW should control Power-gating and clock-gating
@@ -2177,10 +2165,12 @@ static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	if (state == adev-&gt;vcn.cur_state)
 		return 0;
 
-	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v3_0_stop(adev);
-	else
-		ret = vcn_v3_0_start(adev);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
+		if (state == AMD_PG_STATE_GATE)
+			ret |= vcn_v3_0_stop(adev, i);
+		else
+			ret |= vcn_v3_0_start(adev, i);
+	}
 
 	if (!ret)
 		adev-&gt;vcn.cur_state = state;
</pre>
    </blockquote>
  </body>
</html>

--------------gkmZzW8pRTQFqX7CJy9Hq9PB--
