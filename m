Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0E2C3ABB6
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 09:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59D9610E398;
	Mon,  5 May 2025 09:12:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2BotxcvP";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD14710E398
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 09:12:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ft/pV8hmjTJBLRpyGXU6XmFFt0scmyoP3Ps8l638UqcQSnKoSnbjuCD2eWRtamg5vhttwHWtESLqRLzHfQcfBRxJ79lWiDpJeKUbyE/ZWi2/pFnKE5GJ2grsTQhw1325AtBrfqxHrHVfq++4UBsO7Qzn1wMd3bwngqCvrXdEohPy0UrFaFuGnadlUV8Z1EmXDhVPXDWmewGD4YEvBflXqC0q3Wau1EDHNIzsujBr7l/H8+40N0U99XtmFe6vuGI0mssMX643CkOf2cIkbYboThME6vNmWJXhTSJECfQ+ms8BeASLzNKa/MGPVmq1Uss2hzUtZ/p+HCE+Y6Rk3vJGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClYeCOwgDGb41ki7pk/8OBMqWOSX035j09Vg3ofwLjg=;
 b=kR1I2KUv2JQh7tuSP55/9Ajshze9efMokvX/SUVXJsCTYJ4KnywBwuFtY2Bbp0IiF+gvZTIn/LoT8NbTjbtcCy4mPNkpj+6R+ED/6aYbFpqJzXtMR+O35SOSgf1L0f+mf1CaoIfwNqqlRxyp0AfuGvptRwgyuEAE0xAVViy0MwODhyQuapA2Y/WRormkrVjnk0F586S+XPRzMYBq4Gy7F/QxmC3w9mCEbRPI1O4QehjEz0Fg40bSqkimGfgTT0vDNNOBzA435ezXZ4iPRn1g9A2G7npkwffKkdGGLGgQT03Fd/CXzR0Akh2TSCE0fIsUsMk6vuYSMBcg9KxMn3Fxqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClYeCOwgDGb41ki7pk/8OBMqWOSX035j09Vg3ofwLjg=;
 b=2BotxcvP1wLhJ4FFNuC4rMX05AA00BuZ3DR8bWczJzecHvLbHQmP5eKLmsbSqJB65Ca4qKIeoYjyk5cxaNNQZJFelLZQEXCPRul3A0B0MjVMasHse8RNwv6v4USKfpFUw/xCC2tAyqB2djiN9dWa+RD9T21RhAEvUJigy8DkCL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 09:12:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Mon, 5 May 2025
 09:12:07 +0000
Message-ID: <b1c2d811-132a-47e5-a13f-086125b849b5@amd.com>
Date: Mon, 5 May 2025 11:12:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/amd/amdgpu: Add a helper to copy the CSB buffer
 into the ring buffer
To: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
References: <20250504214801.406245-1-siqueira@igalia.com>
 <20250504214801.406245-2-siqueira@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250504214801.406245-2-siqueira@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c61272e-c635-4354-58d6-08dd8bb4e8c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODc3eEFXdTB2N3lDY1dxUzlZYzNjSGwvQiszWEtkdzdNMnBhenNPcVhhYkZK?=
 =?utf-8?B?L1dmSWZwNVpKVUIzTzdGdkE2S2pscTE3NkQycHZ2dkJ0SFFkYUZneXFWMVha?=
 =?utf-8?B?STNzRmhnVjA0djJNUnZ1Q1orZ3RPeFBheW8waEJENWZodnRhOTdWRXl0VmdN?=
 =?utf-8?B?ZDdWWmNDV1R1V0RnMFllTTNvaGJpa1NYa0dZQzdmNUFIRFpvVVQzUExjU1Js?=
 =?utf-8?B?TzhtSjFNdFdZVnZodmNWOHI0RGpjZFM0Ri9COHJvQWJNbWkyeENmUlRMcWR2?=
 =?utf-8?B?WXJYS0lWTGlQRjlPbnNtQXpmUE9WTnM3b1hNdG5JTEorMzN6WG1hcE5lQmh1?=
 =?utf-8?B?UEk2VzdrVCt1a1Y4R2ZNei93eXF0QXNUNU4yQ2x1bE93b2RlSHF1UlZnRy92?=
 =?utf-8?B?SHdrVS8xRmtma2t6amNxdkxFSHBYVTAyVUJ4VG51QnJOWXp0RG04clBRU3BJ?=
 =?utf-8?B?NVJDZlQvTW8rOGlUakRlek5keUhWNk4zZVdrM3haN3RRZlA2RXozNzlDMjll?=
 =?utf-8?B?Y0JpUngySTJLVTJYWlJscElBSytyQ1RDWFRHUDk5SHJ6OG9hb3pJNzcyT25j?=
 =?utf-8?B?TXJUQ1Jya0s2UGt3MTFWNzZ2eW9MYnlMQmxHbjgyTzFpZ3hhY3BWVlpaa04v?=
 =?utf-8?B?dXZwMU1qbFBLOE9oZjY2ejdsUldSdTNoQlUrc2cvWkY1ZE9HL0hiamFpa091?=
 =?utf-8?B?QjdzZXdMVmFYUHhFR1dtc0dIa2NuNjFYVUkvd2prcFZSMzkwZHY5aU5oVUEx?=
 =?utf-8?B?YW5kL09sNTE2ZU05VlE0YmduTTlUSll2NGpVR21lcnhNWjJuM01LWTRpL3c0?=
 =?utf-8?B?UERxeFBENlJvbEVRdFBJN1VUZEhYUlhOY3BXN2RNTHNERUhHSkxoRWRobGMz?=
 =?utf-8?B?Q2VxVmlwY2FZRjhNWDJyTm9yL3BaRlZxbW1ENFphZTJxdGpXOEIyTzQ3bUx6?=
 =?utf-8?B?QXYzbjkzb1pJWmZDRDZ1WDNDeVh4Skc1TjlWWS9XUW5KdnRWbGg1dk9jUnBC?=
 =?utf-8?B?YlVFUDZTeVUxWVNxMXA4RElhVVd0VFJscGIxa1ZIcEZkWGFsSWZzemM1TURB?=
 =?utf-8?B?MDFhTXRDUTkwM0xBTEExMzZMWnNzOXFKY1VacUphWnFhdjQ5MTZpeFo3UXZ6?=
 =?utf-8?B?K0wwaDRzNklpRlV6VFc0V01XNklrVzViQTF1YVVGN1l5aGJoRkI3ZzVpNitJ?=
 =?utf-8?B?ZE9xQUI1NkU3SVBLR1lZb1d2WXJDRlV0eXJJMXFsbWhCOG11WWhDS1YyR0kr?=
 =?utf-8?B?NmM2Q2xUb2taOUN5SDJiMVJZWEREYXpuaGFTbFRCRnFUdUdwTitPUDNxT292?=
 =?utf-8?B?bDV1TU1TZzk0d1gxcURYcFZNU1ppcXhrLzBabzFWeGRDdTg1aWk5ZDlzWUlS?=
 =?utf-8?B?ejY1dHM0c2pXakNMYkpXS1g1VDQzNHJPUXNRekk1aUZIYWhtZ2xqaTBhaitM?=
 =?utf-8?B?WHlVaThCcGVkUmNxZGhKbTIreDh6L2cybzMvYlM5MUQ2dWtwaGVQK0x2WmhN?=
 =?utf-8?B?ZW5kV2VVMVVWK1Z1VjJKTXFlT1lBUG90aXdvNWp6V29GYXJJNzlPSzNodWF0?=
 =?utf-8?B?RkpOeGVMcElNK2VZS28xOGxSMW95aHJNQktXbW1vRDZxUEk2T0RtUnJEL3c2?=
 =?utf-8?B?ZGNnTXhReUdaUXdFdTlBYlJZM1ZIQ09EMEVKQ3EvVWEzYnhzaUNOWU5QcDFC?=
 =?utf-8?B?V0xlejFDL2F5RnRXYVhVSUJxR2R0d1hQRWJvSVJMN2xtSDBRaXo5RzNNSS83?=
 =?utf-8?B?LzdKR0t5TkNzZzhmUWlZbjZKQkNKS01JZ09wZTlML2lDMWhpZnc5VHRMd1ph?=
 =?utf-8?B?VWFjendQSEpubDVRZHBxZm1BbERFblhDeWlNNUkyYkZZZmNBS2tXMmt3d2Rj?=
 =?utf-8?B?Y0gxaGJVVU9YekZDb0hDMWphbUMrYmZmMExDTVF3VVFVSGRaOXIyOUFtVUJW?=
 =?utf-8?Q?RjsFQgJ1oQE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDBvT1FjbGo3UzRkODl1YS9rV2VFelA4aDRlL09EcVBCdjlQbWFVL0ZIZ3U5?=
 =?utf-8?B?TDdwV1pSQmkvUGtWSWpERSs4QVFwNkd5RWVVRUZSeFR2alFRL1ZZL3grYU5i?=
 =?utf-8?B?cTd0SHM5dFVybS9JcHRKemtqZTJHOHZYT0kwSnV5UmRlYnpDZjVuZUNRcTNC?=
 =?utf-8?B?dGlodk1LUGdubUhpdEVQOHBRRzh4Z080N3VZWmhZZVUzdEJYTXVXMU9NK3V1?=
 =?utf-8?B?YVhLN2ZHMUY2VmFTVXN4a1Z6QzIvUFo2dHp6elRsN1o2aW5OSHM1ZUp2WUMw?=
 =?utf-8?B?ZWJiM3FSWU5YVksrM3ZuSHBLZHlSZlpaOVFlV0FxclVkUjQ3V25tMFdldXBi?=
 =?utf-8?B?SlMzc1o0M2VuUm13cXY1b2NwbEJnRUF5WnNjcWFuZXB0aWZuYmpIbjk1Slhz?=
 =?utf-8?B?ellCa2doeVFaejRsbExsNkR5ZUpGMVlQc2ZQSEhyNTYyU1MzY3VWakUyWnZC?=
 =?utf-8?B?ODVVVEYvTXR1NHU5WUtYUmxMaDNBRi9nSUtqYjJjNk5EZWxoeUExT2p2SU1M?=
 =?utf-8?B?NEpFOXlmSmFFeHYvNHcwVXg2R3U1dUUwNy9ZVnM2bThJY3h5K01NNTltaVUv?=
 =?utf-8?B?U0xVNlJvSCs3cm5DbVh0Ym5kQ1RUQVoxMWlQQXdqdCtQN0M3VHZ0SWVwRlBr?=
 =?utf-8?B?QWJPekxEL2d5UmpsbkVTcDR1bFZQVTBNdFoyMGxxcERNSGkveGp6OVZod01i?=
 =?utf-8?B?VXk0akxrZHF6MHRKWGNCTjhJcjZ0clNDU3pQaEdFYXhoelpOSlExNTlyTjBs?=
 =?utf-8?B?NnFid0ZOUjYzWTQzUHRuRGxUSzAyVFVmNVk1TTY1YUdXeWdCeEF4bDBnN1V1?=
 =?utf-8?B?ZW5YS1JJYkJpdU5QMm9zVnpiV1pNZzRkbmNaSVBxUkNyVkR1L3hyWnYwZ2sw?=
 =?utf-8?B?MkU0L0dNWVNUcitkbGpBMjJDYmV3RHM0Z1NxTGR5NGJqeG5TZmVzL2d1VEl5?=
 =?utf-8?B?Q2F2akI3ZWtGdVluQUtVZFZEeEhwM0JSbEtvcnFqZjVYeGVCNGZQVjNSVnZU?=
 =?utf-8?B?Vnc0VXBydjJLZ212ZW1wUHR4MlpMeitzRkxtVEwyNUZzblZOTGpQRllxeGlM?=
 =?utf-8?B?MGdZL1lTUXR4aWpBTjlEcTA2L0cxTmRzSmFoWDJtNTNNQjJrclBPQWFhSmJU?=
 =?utf-8?B?ZHFvUUdKTTVrTUhiR092d0JjSGlVN3lFNWp2Y2E3WmRWRk8rejdKRnZEVzBx?=
 =?utf-8?B?NGkxdXFjbWdGNjA0dVBIQkxPcE40d2lNeU5ianlvNTMyMlREbHBVNzZsOC9w?=
 =?utf-8?B?a3IyRnlxelB0WlBQZEdLdzVaRFBXTVV0RFVBTG9BTFZIMDl6NHB6eDM0YWZv?=
 =?utf-8?B?R2htemNndUdCdzUzSUt0WllVOFlKbWh0d2ZQZG1QVHREQjRZWVozSFVtanZP?=
 =?utf-8?B?MTkzWVFFK1l0NGNyY21UWXZaZnpXb1dTbndMS084aTdtR2RHTVZrZ2ZpQ2lW?=
 =?utf-8?B?aVJLMFdhSUw5cVB4RFV5anFsb3ZVMEV5WGw5bXhGbkJoZnJDSGc2UjJHOEZR?=
 =?utf-8?B?WXd6QmQrMWRKMVJNSnJuTzBLSERoZlhVMC96NXdKVERKWFhJRk1TWjJGWWNm?=
 =?utf-8?B?S2VuVGtQRDlwREJrYnpjRXJnUGRiZHJRWFhXSWt1TE5JTkhIYXl4SFF6Sndx?=
 =?utf-8?B?RjZETTVCMjExeGorT2FBWUhHVHU0TDVlcFczdU53TnpBVzA0MDY3N1dFMW8w?=
 =?utf-8?B?dktSTUUzUllwcDlzVjFMWGNmbWxXWVh4YndxRHJGUFhmYUk0TXhtczJ6NHQr?=
 =?utf-8?B?SlI0ZDYwZVl1aVNNblZmNkt5Wlpxa242WklPTllwZXdxOVB5aFJ5SldzclNp?=
 =?utf-8?B?SjExRGVDL0xnWTdpS0dvVFFLNi91ZlJVZUd4Zk5id29PaE5uM3YvSVZ3RFox?=
 =?utf-8?B?NXhyVS9FVnlLWlE3azhIQ0JsSi9iMjZySGwxWm1ua3pNYkZYc0QwdlR2NTFl?=
 =?utf-8?B?cGZSOUlLNlExZ1BmSklETkRNUmNvR1dTVGUycWZhdW1qUE01UmE1YkZ3MkQ4?=
 =?utf-8?B?dFcwcTB0aU5zdDRhKzVNQ0N3QXh3VHU3cFVlYjFYWmxzS0h3L21RVDhsTmRU?=
 =?utf-8?B?QUVYTWZ5anI3cncyT3RWQ3dwYjh3aDNHQmJFVHA3dnRKTE5UaXpMdXk1RUl4?=
 =?utf-8?Q?f+4U8/KtWInN6sxfz7vOKZF3k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c61272e-c635-4354-58d6-08dd8bb4e8c2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 09:12:07.4428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXWxHdmNuM/8k4o4+pAXw1BJHXVIdesr1X1/c87uOnvGA3IOyThv/3y6ocYyTOpH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549
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

On 5/4/25 23:47, Rodrigo Siqueira wrote:
> In the GFX code, there are multiple parsers of the CSB buffer, which can
> be avoided. This data is parsed via get_csb_buffer() in earlier stages,
> and the result can be checked in "adev->gfx.rlc.cs_ptr". To avoid
> re-parser the CSB buffer, this commit introduces a helper that copies
> the CSB buffer into the ring buffer.
> 
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 21 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  4 ++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 8f1a2f7b03c1..dfd48670a0bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2323,6 +2323,27 @@ void amdgpu_gfx_csb_preamble_end(volatile u32 *buffer, u32 count)
>  	buffer[count++] = cpu_to_le32(0);
>  }
>  
> +/**
> + * amdgpu_gfx_write_csb_to_ring - Write the CSB buffer into the ring
> + *
> + * @ring: Ring reference.
> + * @csb_buffer: CSB buffer.
> + * @csb_size: CSB buffer size.
> + *
> + * Usually, the adev->gfx.rlc.cs_ptr field is filled in earlier stages via
> + * get_csb_buffer(). This function just gets the CSB buffer and fills it in the
> + * ring buffer.
> + */
> +void amdgpu_gfx_write_csb_to_ring(struct amdgpu_ring *ring,

We already have the amdgpu_ring_write_multiple() function for exactly that.

> +				  volatile u32 *csb_buffer,

Please drop volatile from all pointers inside the kernel and point me out if you still find some in existing code.

They are nearly always used incorrectly, see here https://docs.kernel.org/process/volatile-considered-harmful.html

Thanks,
Christian.


> +				  u32 csb_size)




> +{
> +	int i;
> +
> +	for (i = 0; i < csb_size; i++)
> +		amdgpu_ring_write(ring, csb_buffer[i]);
> +}
> +
>  /*
>   * debugfs for to enable/disable gfx job submission to specific core.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 08f268dab8f5..ce684c3d3d89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -646,6 +646,10 @@ u32 amdgpu_gfx_csb_preamble_start(volatile u32 *buffer);
>  u32 amdgpu_gfx_csb_data_parser(struct amdgpu_device *adev, volatile u32 *buffer, u32 count);
>  void amdgpu_gfx_csb_preamble_end(volatile u32 *buffer, u32 count);
>  
> +void amdgpu_gfx_write_csb_to_ring(struct amdgpu_ring *ring,
> +				  volatile u32 *csb_buffer,
> +				  u32 csb_size);
> +
>  void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
>  void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
>  

