Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268E9C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 16:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C434F10EC33;
	Fri, 11 Apr 2025 16:49:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eJKD0spt";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EABE10EC33
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 16:49:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zla7f+uQukhxv8zFLxwXHc0OrRwYgcczMywSaKQMWrDRQ4flaFaiug85BuWSz8bZGc4K2OmPLALvQfhPrBCRYWzUBWjaugilPOL9+WM+05VgOrrMQUKcsu9xOSuoZy65HEZKYpYABT+ph/OtPfD24652pnxJFsJ8NKltt+bVXbwywcg1mw9gTBf7ljZhIBqV+jVfRpX2gGlkZvTyh6Y3yBUe6XxWTKwB018/nuxtgEFAx6e5cUdfBofibEj+XMB5qDZk5d5/WjnItk/RMiT9N8MPXoTwukBmurC/2zxlGFw45i78s+T1+aL/AQ2xmmM9ARuWOgNDq/WjZLAzHS3uqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juQdKKwfQMMf1jXj6v88NctX4uljXx5ZsxvSh7jeA4I=;
 b=hZv51DFeO/KR06DVPe38d1nzjH3ZVLYHxKG5KX7INZtPbwitA7vcwB9GK71LbFglO8dHD2IzauGGE1vx+JbM7KAD0mb2ABIuEp4Q6nzfQgDOjMuC47IKbpaG0Gsvl0Jz0ARkpHaQiVLSD3SBby8E5Kk8+x0nxZTCIRqeV38iLVn+1+putVS7enDSY3qoOiy/JOnH5/J3sHsqcOq/530sEuSzx/zYM8XhMH8eBkJvu5maEERA+iyk2g8biHSpE7TKbQrf+uWYVB2IXSNRTpGFxdJ1t7iHpiHhBa4F+cKL9nRh6vufm0tKFlIGPSeVpAcmcLMVqp0SoJ1sPF6oB13xTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juQdKKwfQMMf1jXj6v88NctX4uljXx5ZsxvSh7jeA4I=;
 b=eJKD0sptvJY7FGD91cJwx62gRjCFrjeptsgTNl5uiEI6MOBSGz34Y0kAjCA8+gVD1Xn0bl7F8dYQAr+E2mbvkBa87cvcWGUKtuLOJ59kpL232PfdiyL7Tbu4QRz18NNNM2xLwes8SCewsYLuYZqXVeT4lsFwhWatnXkTDG2gCnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 16:49:34 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec%3]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 16:49:34 +0000
Message-ID: <ba5134c9-35e9-4f23-9b2b-62e5216afdef@amd.com>
Date: Fri, 11 Apr 2025 22:19:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] drm/amdgpu: convert userq UAPI _pad to flags
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250410185402.2352109-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0191.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::18) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: b623fd5c-aa08-44c9-1d7b-08dd7918d5c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjMxZFRuWHU4MUY5bnpacEtvNkNUS2FHL1pNaC9DeEVjYldoY0ROQndSdmZz?=
 =?utf-8?B?QUkvcFNhMHVhdVNlM1hQcnVJcUxNRWR4UTJJOUU5WEZjOHdKa3U5Z0h1Q2dE?=
 =?utf-8?B?MERGNHZxUVNsWHZQOWtWNHVzTzhNY1Y0Q25PaUtCaXB6QnlhMVIzbFMrSGVs?=
 =?utf-8?B?bVRRWk5Kdnp5YjB3RVNLR3BycGdXWmczYk9zT3VocUU5TzNnUU1oVmMwR1Ez?=
 =?utf-8?B?OFp6SnpqTWxPVjVwbnVpdzRyamVIN3dFRnFFaVBlbU9uRGx2Q2hqOTY3SjIv?=
 =?utf-8?B?K3lxeGFpSW4zQ2Y2a1NmRFVnQXpjd3dWTCtZNmo1cG15OWNtOHk1L0RhL1N0?=
 =?utf-8?B?R3ZERlhXUlF3dTdOcy9RSlpXVmRkUGxMSGV6dFZENG16NURIRWovWWJBTVJR?=
 =?utf-8?B?N2tLVTFCME93T2l0NzJmSGpwZisrTVB1MHEvM0RDY3pLbTQrM3o1V0s2VHl0?=
 =?utf-8?B?YkN1eG9QblZTMmd3b0ljNEp0a0V2NVlxbVVVMXFkRGFtdFVydkJVYzNwU01i?=
 =?utf-8?B?Z3NwRTgxWEFWdWI1NEQxdkJzNmZWWEtsdHVPVHA1M0ZFNkNFd3RtT0FGU05k?=
 =?utf-8?B?Nk9DVE9QTDJCRlBUTDFhZXErREZZT05nZ2J5cmVZek9uZW1YV0lrTEZiaEEw?=
 =?utf-8?B?R1lvZEo1eUpFZHFqQ3F3NlNZQlAwRXZXWVVBeFpZS3FUZGRZMnI0N2NjekR3?=
 =?utf-8?B?LzBEZUZubWEyT2RNSGJDRURrQVREeTJEWml3OFJ6ek03U2JPL1NOWXl3VnJ2?=
 =?utf-8?B?eTJHTTBqZ1RRemJoakFNUGdZckMwOGk3RDVrV1JoeWdVd29JSWw5U211aWY2?=
 =?utf-8?B?bUhYMDdWQUg2cStvekFwZlh5dFNWSEU1M2pxaTY5N0hSamdTT0F3M01wNkdP?=
 =?utf-8?B?UDdCb1ovQkRjUkhsQjk4WmF6TUF2SEVLK2lnYzNidlliTmZ3d1Vqa3pTNTBS?=
 =?utf-8?B?UStoZ0RxSUsrd3p1ZWlqUzMwWjZNYVVEQUxXUUNtY0lpbGZOZE9GUGJZK3VC?=
 =?utf-8?B?MjhvUmdjVFdlUVJoYzBSTUtNd2hkNGk4MDFQbGJCYWhuQTdvTTRGYXFnQ3lk?=
 =?utf-8?B?QU9ISjhzTlovTmxDOEI0N2lEMk9FQlg5MGhJWmxET2tMS3JIOUdCQmlRa3FK?=
 =?utf-8?B?UllXUVNoYUtSRU5LeU1wVEhUQk9sVWFHQ3VaTzV6QTF3OWV0TG5pWUhpbTNl?=
 =?utf-8?B?OVBuNkNSV1NMMWE0aTBOWFFBUGpLeVY4WHpsRXpsamtnVVNNeUZlZFRIRzlh?=
 =?utf-8?B?VnU0YW1VbzFNdlg4OXh2Ni9TNGI3K3I1cjAzWjlEQ29LMmg3Qytibks5dlBE?=
 =?utf-8?B?TUNadHBiYW9YRm54bmpGRkdmNHAyMk4yME5IbEw3b1lhV1cwdWhySFBhbDFB?=
 =?utf-8?B?Yi82bDdvUWxDdG1jREowOFFXKzBwUUJwcTJuc1JYV2JtWUl3VlQ3ZXk5ZklC?=
 =?utf-8?B?cDFlUmlGcE5KSWwrVStlOVk4dm5SRmYranJvTnZzaURQL2pKY2FvVUtoNjNy?=
 =?utf-8?B?Ulh1dU9aOXI2VTZGN3BIZ0tFZEpFVjZJcXBFUU5RZWo2Y3d2L0ZETTRod0hp?=
 =?utf-8?B?Mk56UFlrWXZMc2JXenp3bWdoRk0xbmZ1SWErL2xwZUlKazZWL00rWGxwbk9v?=
 =?utf-8?B?TUNwa25sVFFqc3JaaTlsVVRzOVp3VE45L0w0S1JOczJTT1EwNmEyQUtMcjZI?=
 =?utf-8?B?RzNJeHlNSDRVYy85cyt5OUVsME1zUnZLQjFDRWJ4bjltMUxiZ0U0dGU3NW5o?=
 =?utf-8?B?TGp1aThyd3gzQk5kNldHd3pkSkpuZTR3YTNhOS85ejJJR1RaRWJFOUZiSHpN?=
 =?utf-8?B?d3RkVnlxWDRYblR3QUJhdzZtS053NDJWby9MNk9QRFhTZ3c4ck9RRDJuYkpO?=
 =?utf-8?B?d1NPQkRNYW5NbWM2UHd4Rll6UnBVcUNBdHpmaHd1M3ljQm5OZmRDMm5oTUgv?=
 =?utf-8?Q?PMS3mTbsTTE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THprbmsrUGdGL0I3My9nRm1HTms1UHpZcXN4dm9OUHFNUjZQOG1UZ0Z4L05y?=
 =?utf-8?B?NS9pT0FFUEs0L2FNdnhUTll1cnBTRDFMN3pRT0tHeFJROE80WHoxODZPMU5Y?=
 =?utf-8?B?cEpqVmxwLzdGS294NzBmMkd6a2dsdTRRZHpQYnZ2QjZ5SGl1UmVCU1JkOGZy?=
 =?utf-8?B?Z3p1eUlUZnAxWXZlWjQ5ME9NTno2SWpXOE5BdTlDeklCN1ZNaFpUWC9raHJy?=
 =?utf-8?B?bXNIenozMSt0alBHNm8raUgwYUxiYWdCWE5obzltOVVKM3FXbkRZNDhLQTgy?=
 =?utf-8?B?REFoL2RIYi9XbU51RVJUSFoveHZZMlliMWJhMW1NYlZpdDlhVGtwUUwxaVZT?=
 =?utf-8?B?MUVkWWJWaFlJREd2Sk5NRnFhZEd5RlFva2RvWkNhNjhvUGxGQk11OUFjeFFw?=
 =?utf-8?B?QlcwRWMzeW1WaVFKRFBHazRDdXRlVzh4b2c4dmVTdklxUW5IM2p1aHhQUXFG?=
 =?utf-8?B?eWVOTVd4Ui9tYk51WHdzTEhlSkxDWHI4L21OZEdqWGprckk4REZpbmkwTWNY?=
 =?utf-8?B?cTYvOFJrRmx3QTJHdXBxOU9HYlh3dFMwUkw2VGFzWFI0WmVNUFVEVFJDWGEv?=
 =?utf-8?B?MGJRYkF6QVJ1WUhmTHdBa3R5TFNrbm84bnpHT3JTRTYrZzM1TmlzSEVWWlcr?=
 =?utf-8?B?QWxKVWlSaGJQUUdhRFU1ZEp2UkJQT21DSU0wYS9Ca1pvbXEvUGQ1Y3ZiWmFz?=
 =?utf-8?B?b3JEakZuZUUveDFhQm01S3EyOXFRdjJjRE5ZYmZ4VVB0bkdmVVQrT1hmNTh6?=
 =?utf-8?B?WFlUbnVMTWJSWnhpS1dOYkt5dWdJOWF2aFhlMGQ4N0djYkRIVmQxMkgyQ1hm?=
 =?utf-8?B?NExXTWduNHFGd2l4U2VwOU9LWmkxWW4yVE9hYkNrcHFHYUZhdUdDT2s0VXI4?=
 =?utf-8?B?N2d0bTFyeHEvQzkrSFJEZUhSNlMyUmJXKzRNMVJRbWVuT1NsSkczZHgwZWo4?=
 =?utf-8?B?TC9ESHBDOHRoMFRYOWpnRWpDWDMzK3BkMTBuZGlPT1IwamZoT3podEZXVWUv?=
 =?utf-8?B?TXN3ZmdlVmtkVmZ4c2JVblloRGJwTGVhTEVhVGlXaDAvWnI1MjZTZFlKMTFI?=
 =?utf-8?B?Vy9hTUx2NURkY2hWMnMwWDg2b3RzSTF3ckJKbVFzSzVEdzZMSUJLRVBWbGJv?=
 =?utf-8?B?T1VkN0k0Nm0zdjFzOWZuKzBjeFFuWUR5cTJTQ3BkWUE4ajExOWNPQkNBQ0pN?=
 =?utf-8?B?TkE0NHowYXZTeTM4ams2ejQwRXl4Y3dIWm9aVkZkNHp0akd2bmlKNWpPbG0z?=
 =?utf-8?B?eG9SaUdsTGI0U041TFFyRFFPTzVTL0xlcFF2d29xbVJ6aUZiemd6QjAweDJv?=
 =?utf-8?B?dkhzNk1tbXBWUXphTm91K3lmQjdHZVQrRDBIMTRLZnVXbTdHbWZhSzFvQSsv?=
 =?utf-8?B?TG0xWjRVaFRjei9HRGNILzd4TjRZNWpnVFJoRWdkRkRWS3BQaUZMVWNjaTlZ?=
 =?utf-8?B?L05uRkowTXoycmR4djhrTXBIcVZQMi9WK2RpOW9xcGVVeXBTSi9lcWV6N2l2?=
 =?utf-8?B?Q3ZjMGdNZnQxK29kSm5WbENXdCsrNVlrQytOREx1Z2NsMmE4dzVya2k0c2h0?=
 =?utf-8?B?akZlQXk4V1FjSHBCajVkeUZseG00R2lFeU5ySXhvQVV0TXNpUCtpcTVaQVZl?=
 =?utf-8?B?Qm1QNHcwdm9CeXNlWlVRdkNoV0drczNHeEFvZTYxRmNHSktTbW0yRXpua0JL?=
 =?utf-8?B?VFhIQndlcTQ2RVJaV21qUHk1c2tiUldtOWhzcHVSTEtCejlDdGFCeGVjVzVw?=
 =?utf-8?B?WVRNbmxiOUo1ZUJRN3lMOWp2MjFVNVpzRmVackN2OC9ta2ZwaDU0Wmp3a2Q3?=
 =?utf-8?B?UEt5Vy90a1Zqa05Ndm5nVEwwcEZDSGRkOTRmbTJESVpVWHhPVERhRXhWK0tn?=
 =?utf-8?B?TXZTK0xib2JLTllVa2tod0hQQVRwOUsyRXc1ckxPaXJJMUgzTGNYQmV2S0xF?=
 =?utf-8?B?SlBzYVlnZzh0MG1RelpDWEhuZU5OOW5yY0ZXczR2OFNDVkY1MHpOV1gzVU5I?=
 =?utf-8?B?MnFIcDVkaE9GZy9LYVhXNjI1UG56cDU2eUp4TnJBRDV5UTZnNURDOTBrUmp5?=
 =?utf-8?B?OHBKYzFDcURjeVdwRW1mTlV5Y3JTeTY0MjNwTG4rcXVnQjIvVVdBbzRtd2FO?=
 =?utf-8?Q?qONzvY81ck6WiQ1+yZs3W1Wcy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b623fd5c-aa08-44c9-1d7b-08dd7918d5c8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:49:33.9151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/UtAcEsrzqH7T33GXUGxVEFxwYuKqVbIdGFNbo1AaOxgxvCXKqbHjoOhKdNS7vp6vWJNyhOcVgSvw+Xj8XYNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/11/2025 12:23 AM, Alex Deucher wrote:
> Reuse the _pad field for flags.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 4 ++--
>   include/uapi/drm/amdgpu_drm.h                 | 5 ++++-
>   2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 50317fbd40e0e..57a4ef64e0b8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -377,7 +377,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>   
>   	switch (args->in.op) {
>   	case AMDGPU_USERQ_OP_CREATE:
> -		if (args->in._pad)
> +		if (args->in.flags)
>   			return -EINVAL;
>   		r = amdgpu_userqueue_create(filp, args);
>   		if (r)
> @@ -388,7 +388,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>   		if (args->in.ip_type ||
>   		    args->in.doorbell_handle ||
>   		    args->in.doorbell_offset ||
> -		    args->in._pad ||
> +		    args->in.flags ||
>   		    args->in.queue_va ||
>   		    args->in.queue_size ||
>   		    args->in.rptr_va ||
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index ef97c0d78b8a0..1a451907184cc 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -355,7 +355,10 @@ struct drm_amdgpu_userq_in {
>   	 * and doorbell_offset in the doorbell bo.
>   	 */
>   	__u32   doorbell_offset;
> -	__u32 _pad;
> +	/**
> +	 * @flags: flags used for queue parameters
> +	 */
> +	__u32 flags;
>   	/**
>   	 * @queue_va: Virtual address of the GPU memory which holds the queue
>   	 * object. The queue holds the workload packets.
