Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212D9CE8350
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Sep 2024 14:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5F2210E0F8;
	Mon, 30 Sep 2024 14:46:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QEuAxhrz";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3B3C10E0F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 14:46:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kv67s8k9UZMfggzA1gjZn13M43z7c34ztEoTemDqwHhvP9aCIW4WAhcPBLBVh3HVkzHtWNEV0zyYE1h2xRcHAKemZ/hbV72v+rUodyVVpE9H74DzpuQGMsQj1wekF3COIFfupA/j2bsAwDlnoKDcjQl/Nb4iUZKWg0U8oc2eTQnG+uuU81HxTa5VJCZkPZH3LyDC7Hxp3CqT4qsgFvE2NZsrHIm2IPJWGSkZZU9+wvBJL9OCK4/wbOUJhQtakiClgXc8A0gwA+J43N3KoAiE7Ednss7ZbMjrFnduwW3uMl2JeIk+8oF22akhkNrxdkM8PQuY5K/JMCKcsmzXi+Wa5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhPMKx4N8uHG+YeW1nOzDZ0MOhXwFnSUBQ43draRVM0=;
 b=PUPmGh/B/h881jqppRnzvmVTWch8ak6bBYAZ9ct18y3sqMUF8Wu2LmfbS4nx6itWiVngp6urpU05rXM1p4y37iL9vnKSHzUvylOq/q17MwvjQ/p/148nUdMhNTtpp1rjvOcLs/juuU8WadHATR/9ZOq0S+KafG3GEGzlR3F/skbDQNVOGKaUv8+tEBzTGyur95vlI57/rdeSFRIMRUMeHGCY5pM4q1K0sMi4TjtHJIGRN0tTDqn+IlDAdX4IPcgyDLZh/DX1caG0IhMJHdufeWToEtDtPFsBtjnGMVfPkOq5gl89tvqyBxlLt3s27ND+vUlPUIxuO369+UXlS19VaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhPMKx4N8uHG+YeW1nOzDZ0MOhXwFnSUBQ43draRVM0=;
 b=QEuAxhrzmHHUfEkDSXjy9Q5V0WBx83PCecIgVDNrt+Ox9K0/+t+LA7qFw635DlO8wbA0FxliQChY9bTbtJgcH+m3Ls967uW+j8Y14dHwhB5uVMRtxPYMaROM/MqYVAcJ39pIkvdMia1QfzERSqI7dxRnRqemEuea4zNqiThMU7A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7117.namprd12.prod.outlook.com (2603:10b6:303:221::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 14:46:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 14:46:03 +0000
Message-ID: <624798f6-5504-4c6a-816b-9b8acfa8f743@amd.com>
Date: Mon, 30 Sep 2024 16:45:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] update the handle ptr for reset of the functions
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Boyuan Zhang <boyuan.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240930143019.2682202-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240930143019.2682202-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: 69880b42-5d70-4a8d-73f5-08dce15e9b8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cERlM3pNYXIwcVNmcjdPYXhKVlhPKzM5UzI2bi9GNGhVMEk1d2NNejFyVXNp?=
 =?utf-8?B?M3JhUmdHZStjUlJ5OU9UbUpTYnQrOXQ1RlIyOTRZN2dubUF0a1pvNW9UdWg2?=
 =?utf-8?B?dWVIenNoSFdsd0Q0TE9wc3VncSsyK2JjNkRWV051MnF6WDFWNitWQUFVbmZH?=
 =?utf-8?B?Sjg4M3YvZy83TWdVZEtUcVk0TmZKcndKbG4za0syZ0lMM1h2dms5cEd2TVYv?=
 =?utf-8?B?RVRYMTRNT0Uwa3JtZGFzc2kwL0RDWU05WjZMbWtRbFd2Tzk0SkM3d2lqRnlx?=
 =?utf-8?B?cnh1N0VHWkJZMGV3SFFRSUdldzNSdVFodmE4ODJoR3lYWndFUEZoeEJWZ3ZW?=
 =?utf-8?B?VkQyZGNxUDFpaVR1RFdlSHVSSmVlM0hvcHpLaGF3YWx5cUN4VWppR0twS1Vi?=
 =?utf-8?B?MER5SEhIZmNGT0E4Uy9GWnNuUFRQeUpUMWdyMDVWbmErSEx0RWthRlQvaTIw?=
 =?utf-8?B?TjdLSkx3MXNiRy9zTXNZODhNakF1UkxJTThWSXVxbzFHbmtRMDdJSGZMQkZl?=
 =?utf-8?B?VzQvUnBiN09rQzM1KysvTHpXMVhUdXhPNDRKaVV4QWY4V3NwbEYvTC8yRS9p?=
 =?utf-8?B?MGk1ZmV4Y1R5djN3dUZUY2pTQ055anFFYWR0V04vOUlDL2tEZmpCZkZLTity?=
 =?utf-8?B?S1ZRR1hkTUlrZ1FxWUdkLzlSTHBRVVdYOEdjN2lvcjd3QmdmKzQwZElDN0VT?=
 =?utf-8?B?T3ZkaDFOcmg0UFp0ZkxWM0dvUVpXTHpCajVPS3p2Vm1lam1PRCt1OVJuRS9x?=
 =?utf-8?B?OSs5VEx4Y0p3Q1E5aVkzWXhEdVdrbzhLYmVocm5GNWpOSjRnZC9CQlVmNHZu?=
 =?utf-8?B?TFZPSXFzOXFLanpON3N2L0tCQkdFTUhGWFV6aS9BazgvM0Rqb1RGNlErZmtO?=
 =?utf-8?B?c0xSdTlFLy9PQUkwQ1Zka0JLV2xGNVpwUmtNMnhBREY2dWtHaTlXcnA1ejZz?=
 =?utf-8?B?NUR2enlFWVp4QXZkLy9VSEE1MFYyN05ZQm9PdE8vNkFjSU1qUmZwd1ZMVVVm?=
 =?utf-8?B?OVlNY0gyN0tmT3VIWUwxLzVnT3dybEJTaWt0MVh0SlFTTU0vR1F4YjNvZERs?=
 =?utf-8?B?empHVnVaOGhCQmxBd0lMZ1lkVloxcW9YbWJzbEJSN3JOYWZhS0F5ck1ENThM?=
 =?utf-8?B?aEZkdWQ5TzVwTTdaZEEvVFk5cG41cytrNEVzdmY3L2JnRnkzenUwR0hzQnVR?=
 =?utf-8?B?WHJrTVBDMmROcWFWNG5vMmJhQmswaFF0ZERwYUJLRTYrc2x1WEF1NE1SWXl6?=
 =?utf-8?B?bHUrV0dpTE9BV092RnVJcEdYaWRTOUdOTnlPNU1GRHlLZUtENElBbGVucXE0?=
 =?utf-8?B?SndSU2FUanZTTzQyaXAvbUJicXJBYzM0eUFDaTVnRFdCTFBVRnZQVEJna0t6?=
 =?utf-8?B?NUhyN2t2NWtkZHhQR1hSaGZRcWRaVUxoazFlcjlnemFUWld0ZVRndHZPMFp1?=
 =?utf-8?B?aS8xL2pKeWpOcjVZOW5zQ01wbjJ4WmV3b296T0JHMU9Nd3kxNDlBb3BnSGQz?=
 =?utf-8?B?SmcxL0VGQ3RUVnRKRDNNNms4K1h0UWgwL1NDUVBpVFc0RVFrWVg1bWtHTW14?=
 =?utf-8?B?OENWZkxzK2hodDFudXR3bEhqRWp0cWorbm5IS0h1c1kvM2JQN0tNWTBCNFds?=
 =?utf-8?B?a1hzZmlpN2RzMUFTY3B6N1F1aENvaFlHTzF3WElDZFVRNGZuRjFHak1HUzlT?=
 =?utf-8?B?MFRnMkkrbzhUcGdqSUVaQ2FsOWtCbmY2Ym1BT25xMTBCTlFUZ0RGSEVSNTlT?=
 =?utf-8?B?S0E5R1pyQTNnTlorWFUybityckFCajVQUW9ra3ZHYklvb2IveWpzTnVKdUhh?=
 =?utf-8?B?VmpzZ1EwNFhWcWRoR05jdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVVvUEtPK0YvRElrS1pwaGJUdnFsdlVLN29GOTZPc2RZR202L0YxdEEyS2JM?=
 =?utf-8?B?T2hCRStwM2owZTBhU2JVaUVYQ1RrMUdpelk5VG4vTWxuVTNPNExtSzdSblhF?=
 =?utf-8?B?VGdYWU1TdEkxeHc2R3hsTWhtTUZ2MHUzUkRiZURoUUFBcVFvMGY0Q2h5NlIw?=
 =?utf-8?B?WlE5ekx3dUJ5dWljMXMreHN2dFJ5TUZsNWpSRjhzVWlMMGI1Q3l1Rkp3dVhM?=
 =?utf-8?B?N0JoNkRiKzVhOXF6bThoREtic0JtMkNiczRVWnB6MFZOMFNQUUdLVWxOaml0?=
 =?utf-8?B?RFhsbXJpemVRN1UyaVN5NElZSjhmaFkwejdMNy9zNlNqMlNpN05aeHM1TU13?=
 =?utf-8?B?bngrM01zMkdpWWRUSnJVSVJsWmg0Q3dzTTJSNkRKZGVndENJSE9INFJMbFph?=
 =?utf-8?B?VTJBa0ttcTR6UkNMUGJ2bUR3c0NWNUVXLzlORjF6TWZNRmJhRXFrdEZGd1Qz?=
 =?utf-8?B?VTNDWXJzbExreGovZGttQUdVbFFieEVnOU8rTHdyS1IvVUpVRDR4c0xudlFT?=
 =?utf-8?B?UGo3SUROUUpESk0rcW5ZWXYrUTVwblZLMWFnVktiTWRpY1FITmxsZ1Z0R2Ju?=
 =?utf-8?B?SkpEN1dLUnM3Y2t4S2VSMkFFdzdOQStjTmVFMEtIMEdoWmd5cE9XSzdLcFJR?=
 =?utf-8?B?NUwza0dZQUk5am8vM1EvRXhENXRzZkk0N1dFbUdPZVpKbnVIb2pXZjhpMitu?=
 =?utf-8?B?L241SXhyTFNpLzlaV053NGo2TGZ6VCt3Mm9ycDMxNDZCdFFxMHpkZGRRdUlm?=
 =?utf-8?B?T3N4N3Y1Mk5sdnZ5ZDIzeVA4ZzFJS0RqZzlXNzZGbzQ2R2kzNWwyMGJ0R1J6?=
 =?utf-8?B?YWZPaGJHRTFidG14RWFpdkgrb1NaTEdCUk04c2t0Q2htSTVJZVlaQ0ErQlJ1?=
 =?utf-8?B?QjhuVldnM3l2VHNUM0twbjQ2Q3UwNVF4TUtWdnkvUjZ6ZTN4dXVPeVNyamli?=
 =?utf-8?B?RWVrcm9SWmMxaG5vYXhBUWJQRzZldWwvbXdsNUYrM1l1TTFJbnp0SkVEK0p5?=
 =?utf-8?B?UFVmbGFUNlJKbDFkZk1lUEtpR1FnZ3NnREpJL0NvNDFYblUzQ2drRUtjbFBu?=
 =?utf-8?B?aXJGRTlxK3pJdlZZYjdkUVlYWEdzWXdqeUx2QnR3bUttVHFKUUhqNFRsaTg0?=
 =?utf-8?B?T3Y0YWsxcllUQlNqL3NFSHowTDNPc1lnOTNCN0cyaDVYdllIbmdicDVSTkFT?=
 =?utf-8?B?b1VKdFR0dnV5dFRCYUVxd01KOFJuL2tVamIybjhtOTF6SG5lM3d3QktrSDZ3?=
 =?utf-8?B?bCs3MU1yRlYvRm9Nb0tuTDFxZGwrTjd5WFRMTzJwYkhaTHVUeThSRlBOQW54?=
 =?utf-8?B?S09lVFBWYXhYTlZPK2VKYW83KzZKNG8rVnh2em1sVlR2TEFvMDJjVUl6MEE4?=
 =?utf-8?B?MGpHdzRrV1VNUkE0Znc0UlZCb3ZoSHFCOXRucXI4RStUYzU2OVBGVjN3WUx4?=
 =?utf-8?B?VHdKc1VQSkczcCtvNjl3WnczWTUzenUrR1BsNmdJclV6VUQwRG15SVhra1gy?=
 =?utf-8?B?V1ZPd1g0NFFXZC9Fc1dkOEk5Z0xpQXZBaVZoZlZQVjQyM0pBdWtBTDUzYzlG?=
 =?utf-8?B?ajlKeTFTSnBERmN6Q2s4am5EUmNyOTl4OFB5aFBGaFU1OW16VGdLK2JFZFdi?=
 =?utf-8?B?Z1hiZzI5dEtRVEh6anlJR0JoMnBZTDg1TkVxVDJZK1ByV2x4ZThGdVJRelI1?=
 =?utf-8?B?KzJURWxXNnQyQURsakFCTEcxMVp6K1R6SzAzS0JIUXphK3NVc2FGNG1Sc2VC?=
 =?utf-8?B?NWhYWmlBb21uY3NIT3V3ZnNVaVhvZ005em1idXgwcHRWZm53N0JnczhCKzVR?=
 =?utf-8?B?R0t3cm9RdEIzeXN4Sm0wemRmcG5aOFNtYU5DRWp5VlRsWDkyUklwVTM1Q1N0?=
 =?utf-8?B?YXBjQjJ1ZnZNT0M0RndHR0lyMnV6Y0tvMkJlTTJoVHJJTlY3a0dsVktsRlBR?=
 =?utf-8?B?VS9jRmpleTlGa1JCMmNaeUdNQWVGU0JZRWVKY2NUM3V6QzR2Qm9GK05LL1Z1?=
 =?utf-8?B?aG9nZTBoWEx6aHY4UjNiUGh6clZhYXlVcDg3VzFXelFMREo0RG1EWGs5YUxW?=
 =?utf-8?B?RW14TXV2Smk3MmUzdk93dnZzMWZ4M3Rvc1NLRkpmZ1JXTmNJUjdNSmZmTURH?=
 =?utf-8?Q?BCOqKAUDRv6XK4RX2GLdsks78?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69880b42-5d70-4a8d-73f5-08dce15e9b8b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 14:46:03.6844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TL+aORvBhb/STfPPzeY/5of0UjxJFaGXVQMS92UjgB7HTrJwFbzbcpzQ/m/gcoZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7117
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

Feel free to put my Reviewed-by: Christian König 
<christian.koenig@amd.com> on the full series.

There are a bunch of dummy functions we can probably remove, but that 
can be separate patches as well.

Thanks,
Christian.

Am 30.09.24 um 16:30 schrieb Sunil Khatri:
> *** BLURB HERE ***
>
> Sunil Khatri (12):
>    drm/amdgpu: remove the dummy fn acp_early_init
>    drm/amdgpu: update the handle ptr in late_fini
>    drm/amdgpu: update the handle ptr in prepare_suspend
>    drm/amdgpu: update the handle ptr in check_soft_reset
>    drm/amdgpu: update the handle ptr in pre_soft_reset
>    drm/amdgpu: update the handle ptr in soft_reset
>    drm/amdgpu: update the handle ptr in post_soft_reset
>    drm/amdgpu: update the handle ptr in wait_for_idle
>    drm/amdgpu: update the handle ptr in suspend
>    drm/amdgpu: update the handle ptr in resume
>    drm/amdgpu: update the handle ptr in hw_init
>    drm/amdgpu: update the handle ptr in hw_fini
>
>   drivers/gpu/drm/amd/amdgpu/aldebaran.c        |  6 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c       | 33 ++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 45 ++++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       | 17 +++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 16 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  | 20 +++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      | 23 ++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       | 20 ++++----
>   drivers/gpu/drm/amd/amdgpu/cik.c              | 22 ++++----
>   drivers/gpu/drm/amd/amdgpu/cik_ih.c           | 30 +++++------
>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c         | 32 +++++-------
>   drivers/gpu/drm/amd/amdgpu/cz_ih.c            | 30 +++++------
>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        | 30 +++++------
>   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        | 26 +++++-----
>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         | 24 ++++-----
>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         | 26 +++++-----
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 26 +++++-----
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 33 ++++++------
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        | 20 ++++----
>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         | 28 +++++-----
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         | 28 +++++-----
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         | 40 +++++++--------
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 26 +++++-----
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 26 +++++-----
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        | 25 ++++-----
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        | 25 ++++-----
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        | 25 ++++-----
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         | 41 ++++++++-------
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         | 31 +++++------
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         | 51 +++++++++----------
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 25 ++++-----
>   drivers/gpu/drm/amd/amdgpu/iceland_ih.c       | 30 +++++------
>   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          | 26 ++++------
>   drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          | 26 ++++------
>   drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          | 26 ++++------
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        | 26 +++++-----
>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        | 26 +++++-----
>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        | 26 +++++-----
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        | 26 +++++-----
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      | 26 +++++-----
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      | 26 +++++-----
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      | 26 +++++-----
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 32 ++++++------
>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 30 +++++------
>   drivers/gpu/drm/amd/amdgpu/navi10_ih.c        | 26 ++++------
>   drivers/gpu/drm/amd/amdgpu/nv.c               | 24 ++++-----
>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        | 30 +++++------
>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        | 40 +++++++--------
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        | 26 +++++-----
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      | 26 +++++-----
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        | 26 ++++------
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        | 30 +++++------
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        | 32 +++++-------
>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        | 32 +++++-------
>   drivers/gpu/drm/amd/amdgpu/si.c               | 22 ++++----
>   drivers/gpu/drm/amd/amdgpu/si_dma.c           | 31 +++++------
>   drivers/gpu/drm/amd/amdgpu/si_ih.c            | 32 +++++-------
>   drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c   |  6 +--
>   drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c     |  4 +-
>   drivers/gpu/drm/amd/amdgpu/soc15.c            | 24 ++++-----
>   drivers/gpu/drm/amd/amdgpu/soc21.c            | 24 ++++-----
>   drivers/gpu/drm/amd/amdgpu/soc24.c            | 24 ++++-----
>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c         | 48 ++++++++---------
>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         | 33 ++++++------
>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         | 33 ++++++------
>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         | 33 ++++++------
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         | 47 +++++++++--------
>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         | 45 ++++++++--------
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         | 35 ++++++-------
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         | 51 +++++++++----------
>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         | 40 +++++++--------
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         | 25 +++++----
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         | 26 +++++-----
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 26 +++++-----
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         | 26 +++++-----
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         | 26 +++++-----
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       | 26 +++++-----
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       | 26 +++++-----
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       | 26 +++++-----
>   drivers/gpu/drm/amd/amdgpu/vega10_ih.c        | 28 ++++------
>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c        | 26 ++++------
>   drivers/gpu/drm/amd/amdgpu/vi.c               | 24 ++++-----
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 ++++----
>   drivers/gpu/drm/amd/include/amd_shared.h      | 22 ++++----
>   drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    | 20 ++++----
>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 20 ++++----
>   .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 26 +++++-----
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 24 ++++-----
>   89 files changed, 1115 insertions(+), 1332 deletions(-)
>

