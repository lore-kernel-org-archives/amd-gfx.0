Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57D2C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 04:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8197710EAC8;
	Tue, 30 Jun 2026 04:54:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bK/COcEK";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012049.outbound.protection.outlook.com
 [40.107.200.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3209F10EAC8
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 04:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/snkhsig695jJiqTSW6LvAGgtynzhdTd8fEoJ3s1bv67e+oD/bwxZKuOCCW0SeOwLNmmzbi+YzQRQ2XAhK5Tts/K5NqpNj7v0sdwv61Zfp2EclY+rN+rlcX4lzaKRw3WUfo67b+dcdiZdPljFlQ8otBQA8RRVZ8vn6IT7R2u5WZUqInG1LVPHsm/QnNgeCxUEhIkBZG89Ojpg3RVbt1VnT1Tgsx34zShfpvAozamg2l3v8VrMxplsH89ntXXZafwIG6kcadfWWWxGkbP89aiQUT/2T2xZ7lgcwG7O5APRN+7QORnifvlpVheOc7JtYb3J0LGhqwfi+kbBMNoVNQEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doJEYN6DrZXodi9ereECMOxW48fEcHdIhhj4EmnzO2U=;
 b=Nd2eNsQ5eutEtQQJqi9PiRAc6J90biFcDtRi3tz+YoYXi0eEyzjfxZ04qCzMvpECo1FPlEINEGPZgQKuSGS6vD9iSU7cp2GIlbWFl/59IXBqouV2tnTE60TdnkcSp3xNzQQ07v3T4UBmT/4sBqXK+Ikp8TpFzBtLuayot0lgsWapcFCu7T9J7imLatVeQteVpSwxukp9mkx9ViAP7WZYc3266Berw+oWHTshEdpsOcZpXeZXsO5m/CO0VHZ8fMlRr0BPL33reCv+VylJvAt/NRugnGl0Y3Qg0A+TgchcWB79Kb9m/FxLpU8kZHgStlyStErK7edWBPUbq2QrZOykUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doJEYN6DrZXodi9ereECMOxW48fEcHdIhhj4EmnzO2U=;
 b=bK/COcEKD5UXPLRqcQ0Vv1+CGV11zrwa6Thq9Nq0iToj3ctOI/39i2rtQ2GD0XR5zadn8JKth/C7soijEIYyjjRExO2Bpa00MrN1TXy6Mrw7JYsWZ0uhGYYAjkfQiBGQVu7OEWiZ2R1h9E7ipvdd8xF6hFVO/2deNxFRN6ibyUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by IA0PR12MB7774.namprd12.prod.outlook.com (2603:10b6:208:430::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 04:54:18 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 04:54:18 +0000
Message-ID: <bb8a6bc3-741e-4939-99c8-d6044668111a@amd.com>
Date: Mon, 29 Jun 2026 23:54:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] drm/amdgpu: add support for PSP version 15.0.9
Content-Language: en-US
To: Granthali Vinodkumar Dhandar <Granthali.VinodkumarDhandar@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Pratik.Vishwakarma@amd.com, Suresh.Guttula@amd.com
Cc: Kanala.RamalingeswaraReddy@amd.com
References: <20260630043655.1284069-1-Granthali.VinodkumarDhandar@amd.com>
 <20260630043655.1284069-3-Granthali.VinodkumarDhandar@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260630043655.1284069-3-Granthali.VinodkumarDhandar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0217.namprd04.prod.outlook.com
 (2603:10b6:806:127::12) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|IA0PR12MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b42efec-bf33-44f2-38a9-08ded663a42e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: obtXZkadEOUcR1iQa1BwXffjIA4l3qx7chi3UwLrN0BU7MGdS9tlPgWf518A5EYXMQV5+D1vH5pdm/fZv8b5fDJ5rJ19wR0bLn8a2iys+n2rp+TggY07/Jh65c4juSrBlyZgSfAkYwbcDqL12hjKp5m8rEYQvhFBOp8KTMxaxlIj0TBrwRecvVRrrgxhy0/I2mv6XtvJw8lMFdLP7G9geyjCdxwzuku2RBNy23mUciQp/mdKxL+Q1GmGicpMciQWROgBCwBec5eY1W1PePXX213EnmwY8JNhVuaWVYZFznlbBXa/nQFpn8KqW798WcLM2c6nnElAvuJOem0kfc/TugC8L+1uoCMtO9/gLkDzxYbU4E6+LD/JrwBa8Qu4PZ7xamwiWQoyeOQwJyPmUq5evNnfLSlGjFWs5wuB3SrKjOOXhAi7zruV4WwedlD7t6VY8KnTIVsOuvaf0Y/FPfM6lszEBH/RsW0Bf5YJn4RmVgQX8gAKsn7ZgLOGQDIHsAYgWD9NSsCdfV/oTlOfneHPIdtnk9To2yIroxFPJz3SiZBVAjl2yXhp2Xiv7NFS+FwU2OLB902A/izopPF8X+Gg34RJA/DKKPWDysgIx2l5dzTuzrxh3apJzVXg3rGA6qrwDsxzLr1ubi+pk0V4/UN1/d+DeT3+OnC1lx/S4VxLd18=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0YxekQwRksyS213R2ZNaWxJNWsrQVZSRjMvR0Y2RFJiL1N6ZDZkY21nZEs4?=
 =?utf-8?B?TXJuNTY1OTN5WVdEVHlXM1FEelo3SFNEOThCUGJQTnE5U1lnTWNEUXF5Yi93?=
 =?utf-8?B?OVUxZHJhNzdnNE5wNHZObUJ4L3UwbVZiM0pmWE1TODNlMTBER0EvaERweHBX?=
 =?utf-8?B?YStmdU1wS1F3WFJJRGxpUjBxeks3ZUdacWFVYXIwaHVuSTJDWktsVDRqNmVG?=
 =?utf-8?B?dmZ2eUdvSGpjQnhvaW1NZUhQT21QalpIOWg2RlJlczMzdDVwcFc0M3NzbDcr?=
 =?utf-8?B?VG9TdVlUWjNINzBsMmFxUUx5ek9waXE5NktUdzZBSjNjczZsTHR3RVZORVBi?=
 =?utf-8?B?QlVHbDBrN25Uait3NEszTnpYQUt4VnFGaVlLU2ZCb0ZYbGtDdE5rRXUrL0U5?=
 =?utf-8?B?ejJYKzBSbStFYzJ6NkxJblZmRldldzRNRmRGaFpuMjY4K0NpaXVGNEtkWnFr?=
 =?utf-8?B?WWh6WkhISUlTSUNCaUsrNFVPLzBGZlBoVHprdTM0dDhOYk9zQm9yek01cEVD?=
 =?utf-8?B?Y044Zyt5VUUyWFRhdXJqYkp6Q2VjMlRCSnRvTlRHK2t0MGFGdWY0dmxTcjRy?=
 =?utf-8?B?clM5QTFmUTlXSTVXdzdndjZRcGNqUjVVc3EwZXlqWDIySUNFZ2gzSnJWNFNu?=
 =?utf-8?B?Y3UxQ0k0QmZvVGNIeHd6RVd1VXpscWU2ckcwSHZaZHJqbnI0RU1Ea0xXM0lH?=
 =?utf-8?B?c1BwMDI4VVlDZlp4czlpbHRUVjlwL3ZQazdYd3dyNERLVURUbXh6MjRyS05K?=
 =?utf-8?B?d3JOZG1aUlJ5cUJqMm83Y0pQT1U3MjZDdTIvTURBOStWNlQ3NjZtV1FaMjB2?=
 =?utf-8?B?Nkd3eGxLekUvT1MxdlJLQkRoMk9FT092aVRyYmdtaGNYbzBOdTdiVWlJZDJD?=
 =?utf-8?B?V2VJMk84M1lsQXhobkJTNGFCc3o2VURRclpFYjAzL0JIU0IyRjNyRlBNMU9t?=
 =?utf-8?B?bmJkTzFwNkh3NUlpRnlDNFE1SVd2a0k5RmVjK1ZGeEp3VGt1dy83NGZYMExx?=
 =?utf-8?B?cjRjdHNFRVFyd2pGV0hoeWE4aTdZanhjc2dzR05JS05URFVHT0lva1Jna2RS?=
 =?utf-8?B?RnhiMytadFZacUJLZzVlTHFGWUZidmtXS3dKRlNXclROMkp1eUltRTdPaW9y?=
 =?utf-8?B?MUVYbVZFaS91WU9pZXZRalVYSGtsUDlabFV5eUM1TXo3TDljZU5OUHJFUGo3?=
 =?utf-8?B?YUhKTjRKd1lvSlJEcUQ1QW50cTQ3M3RtamIxVnNVbmlMNVkybmF2QnBHRE0r?=
 =?utf-8?B?aDVvZlBIbFhlV3pjZUFERldHS3g0SG5hcHErL25rTVRJajZaSVUyc240RHUw?=
 =?utf-8?B?M1IvUDI1VW5FVXYrVzE2cjE5OWM1dDJaekJod3hWUTBtcFdPUlVyUndnclpu?=
 =?utf-8?B?bGZRdExSV3MvSU1VUnREbGdvWWtZazBhdGJ3bWRjK3JuNkpUUzdlc3pkUFZK?=
 =?utf-8?B?V0xsY3RBMDRCZGhzeEFCcExsNTRNVy9lRzVkU1pEWHNQdjRuSE8zU1dEYlo3?=
 =?utf-8?B?NmxOVzJSa3VxQWRuMThSL3JsaTE1T2V0K2xtVmI3ODM4dGtHSk43czVjOUVC?=
 =?utf-8?B?YnhKNDlNNlZ6blZSRXRoYUh6VTFaRCs5R2ZoYzNwUy83S2RPTjlkSENoVHll?=
 =?utf-8?B?UEYxZzd4aXNBTVhldTJhRHJndXRra1B4WHYyVVh4VjVLc1F3a0xwdDY1aWdy?=
 =?utf-8?B?VHZ0NmFwdHRJL2htSHMxOTUyaFI3REVYUlA3ODV1MVYzT1hsOTZ6RUlOTkZD?=
 =?utf-8?B?cDNodkVwZUNsbkdEUlo3MENuRzhCUlR5bE4xbXh4dUJaUldONUtuRVZJK0pT?=
 =?utf-8?B?YUhjRnJGNHp2RmRUN1NaOEJEeldQZ0Q4RHJ5UVZqZ2Nrd1BxcDNvbUxyVTJq?=
 =?utf-8?B?TDlTYXVDNzREOTF3c0tYVnE5bkRwUTEvTzRCK0Q4SGFVclNTTE5tTi9tUkt6?=
 =?utf-8?B?aTBxNUhYNkZrYitaa3hicXlHTTNSZDZZOW1hbms5RElBalAyRlZ4RlI1a1h2?=
 =?utf-8?B?djk4QVE5SnB2T29NTGkzalpBbTEyTTBwSkIyY1VlVlNpR205eC9yYmxDeG5l?=
 =?utf-8?B?OWEwSlVzT3JKRVVJQ3dkWE5YNXl2SGk1Wjk0d2E4ZmN4ZEdWSmtCem9aNnJy?=
 =?utf-8?B?TlQzSGhoQkZ5cFQ4N3k2bnRQSVpPcm03N2xpUkY3bjdSVjFRWWViTTU1bmlM?=
 =?utf-8?B?a3JJMUNJVC9xcVFuMEp4cGF6ZEdPWUhQaXVON1RZT2tMb3pIcVVaVC9IeGpy?=
 =?utf-8?B?OWZJOU4zT0dNZjBRQ3VNMUw5dU9jamQwaTdQbVlOMTdjQnBIVmFDWmZGajJh?=
 =?utf-8?B?V1YramluaFZTQytidi9VK01hOUNxSVdXVnBuM2N4Tm00WmJqc3JlQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b42efec-bf33-44f2-38a9-08ded663a42e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 04:54:17.9182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejGXWgdIYh6Hi/T3dNP2Heq5e61OjMsWMHrJUxWoQGn6Z1o0W18ImyZnb3lfA83C0JQhbnIYjLC4304OeZALMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7774
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



On 6/29/26 23:36, Granthali Vinodkumar Dhandar wrote:
> From: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
> 
> Initialize PSP Version 15_0_9
> 
> Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
> Signed-off-by: Granthali Vinodkumar Dhandar <granthali.vinodkumardhandar@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 5 ++++-
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index d345bea4f390..16606155a92e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2521,6 +2521,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
>   		amdgpu_device_ip_block_add(adev, &psp_v14_0_ip_block);
>   		break;
>   	case IP_VERSION(15, 0, 0):
> +	case IP_VERSION(15, 0, 9):
>   		amdgpu_device_ip_block_add(adev, &psp_v15_0_ip_block);
>   		break;
>   	case IP_VERSION(15, 0, 8):
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 4b91a22701dc..a36cbfc1f6f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -275,6 +275,7 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
>   		psp->boot_time_tmr = false;
>   		break;
>   	case IP_VERSION(15, 0, 0):
> +	case IP_VERSION(15, 0, 9):
>   		psp_v15_0_0_set_psp_funcs(psp);
>   		psp->boot_time_tmr = false;
>   		break;
> @@ -3475,7 +3476,9 @@ static int psp_load_non_psp_fw(struct psp_context *psp)
>   		     amdgpu_ip_version(adev, MP0_HWIP, 0) ==
>   			     IP_VERSION(15, 0, 0) ||
>   		     amdgpu_ip_version(adev, MP0_HWIP, 0) ==
> -			     IP_VERSION(15, 0, 8)) &&
> +			     IP_VERSION(15, 0, 8) ||
> +		     amdgpu_ip_version(adev, MP0_HWIP, 0) ==
> +			     IP_VERSION(15, 0, 9)) &&
>   		    (ucode->ucode_id == AMDGPU_UCODE_ID_SDMA1 ||
>   		     ucode->ucode_id == AMDGPU_UCODE_ID_SDMA2 ||
>   		     ucode->ucode_id == AMDGPU_UCODE_ID_SDMA3))

