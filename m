Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C9FCD6E55
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 14:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7701113447;
	Mon,  1 Jun 2026 14:54:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ubzYafym";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FA7F113447
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 14:54:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVWM1kgrhyjApMsd5B+kGcpKRsdYnKmtO/PVfcCUUcGvcpz5Lu18QAal7Utow/8gLTTSILaPArThO04xCVw1p56HvpNrFYlJT0pGEz8LwWFSD0iFscYld7YxCSM1DaYG+KbGDDN7d3VhefkqaujOy2KfZc2EP6SzycnJj46xmX9Tz1ommWWbABQQBOwZ2Ce4JqQS1lhTbNw5pFx9WumVBytwUuQbjGs+etDu9yBJeDGAlZDk/RM22292DVUnobZPSxJW6JMH5B1QxLqJuKyfzBQUPnYKnRedk/m33ydISPlWIDzEw2QKyl+8gYGreY83Oi5ayXMTQ70S/1WC0idcww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jmxFW3Gy9ddc2rhCKSMYxldJf7vFCrmg32L4Ch2KDI=;
 b=yOMPtVZ6QyZoUW0QGjjjjMH22i19dGnsmiCq3TTYRgRFg9QxGukl0Adpf4bsGk9wG95wToi3r2EzqT7N5qr5InFEtQD9yoFokgFto++oE3VSzv3QZH4zdZ2uIrkGbvUGCw/WBx9EDsoGLk0fKRwe2LvJ3PrbcQXsNg/Kd1o1CT2wcC3L72LjziKLo0KuG7KUSlCC7rg+JPXpA+lDHGwvAX6HsO+qNgslHhaqrfRSl9bYv2XftDpetjmkZtLHF+ueCE11sXmRUiRPKWNlJq9m/BxNwReN97FiGk4oAL77cux7kNQtqvsRW5QNa7WfReTcgu5igydG48gM497UYfy7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jmxFW3Gy9ddc2rhCKSMYxldJf7vFCrmg32L4Ch2KDI=;
 b=ubzYafymdKQWcK2yKVYR+ajOqe3fCd+Y5ZhgLONqW01ABgk0Z02rct1O0nwg+21F+Nq+2qwUIxUPn3uN1NA/iWzZaSdDvfiAy0rxfRfGH1Wh4ZakMTpHLtw8uG222S1wZwlNkPtwhF/QFKtIIjQXHcE/4ipABtY9JMrY6WKYyvA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9612.namprd12.prod.outlook.com (2603:10b6:8:278::5) by
 SN7PR12MB7227.namprd12.prod.outlook.com (2603:10b6:806:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 14:54:20 +0000
Received: from DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c]) by DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c%5]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 14:54:19 +0000
Content-Type: multipart/alternative;
 boundary="------------h03C8tPZukudtSELMJK00iVS"
Message-ID: <53502d88-ce83-4e88-82bc-c14336374076@amd.com>
Date: Mon, 1 Jun 2026 10:54:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: amdgpu_device_is_peer_accessible to
 support all BARs
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Yang, Philip" <Philip.Yang@amd.com>, "Joshi, Mukul" <Mukul.Joshi@amd.com>
References: <20260502212857.85677-1-Harish.Kasiviswanathan@amd.com>
 <20260502212857.85677-2-Harish.Kasiviswanathan@amd.com>
 <SJ2PR12MB8650A6133770E8AFA78BDC5E8C392@SJ2PR12MB8650.namprd12.prod.outlook.com>
 <SJ2PR12MB8650FE9E3CF273ABAFCDA7338C152@SJ2PR12MB8650.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <SJ2PR12MB8650FE9E3CF273ABAFCDA7338C152@SJ2PR12MB8650.namprd12.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::7) To DS4PR12MB9612.namprd12.prod.outlook.com
 (2603:10b6:8:278::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9612:EE_|SN7PR12MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f08140-191c-4f0b-7850-08debfeda8e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: xRpvJUwRyPalOUg3XsZJJvEw8la1/I15NLEE19Z8I5KllqVFrH4RkXXwdueGRHUupU3kyHZNEhsQoeVqOkjb77a4IyWetla6vAJlar26jTuAaiZehMNKa7gu+N1fuT9XN62WIH+TpG/cfyXIsv2tvC4TgKkYkEOmrx0gp5LffJNabqx024hT5HJiJpfLRoOIvJMP9Lf6zqbd7muYJQ4ITJ6EEQJd4g7JlEtDJEbTUSSV/WAkSw84ODlQtYi1FrG0ArIvDKDkZqER3cMQrZsK3CTJiQlHJLs6fqqpGVWJ8KlJ/j5AlKILg7bfXo8pS4OuyHx+p4Wm7B85KuyFb8uPDW6Kj71g4w9IctUANCEzLJmCCv2FgThO+yxwqU6oNJHZBlyVEmLYrCYPT9tYWvLr3OZfknRQbM7pLQ6HyZCqUfFkqEHq9jOXA2rNZzBx4nJ+faebKjnlCxah1IWG6QZIX9/vv2+RkMoS4ediGK6hdjtk42+RC3sfNJdjkymBggvPVAWabqrVaIXxyj9MeHPjJYcIq67S05i64n69n0jnfgGnRBQ2wyB/km6frw+P7PnxHhh2TZmtlI4mVtvmSNzBFn9xb8Ugvfw1qrYWLIgJHjWyIRnItPqqC8rXUq9V3p/x/U7ksdxxurNuBVe/UZTHWiBZ3MHTiq2eKZYRpZKI2+YNnS6oPut3yqOa4fjthJXk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR12MB9612.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlByanhLZGR5QUdRb2hWR1FaMER4YTdPYm1nUmcrRWV4ZGVaUE5TU0YzeUxV?=
 =?utf-8?B?S05ib3drSXpWdkl0d3VOQ0hIU29TS1A2akNrTWp2eGltODgraFFiemM1WWdC?=
 =?utf-8?B?VmpodGFmMmxhaTJNNTF4YS94NEZ3QmswREh3cmYyWjlWVWdUTXRrem1yZWk2?=
 =?utf-8?B?eG5BQWJMYWJwVUlsOE9ZNTJ5ZmtrM0VSQWxNQm5aQjY3bktLdkJiejJCNDcv?=
 =?utf-8?B?dFVwNE10bStBNW9DZUFONFl0MGRQamEwT3BCTSs0cnM4LzV5OGs4bS9SVGlz?=
 =?utf-8?B?cFBoVWR3TGFpMEFmNDZGaFdZWi9ON0t6UGpybHN0ZVBLRWRYOERQdlFYeThF?=
 =?utf-8?B?eEFHZmIzVnlHYnpHRmt0aEJCYzRkYXg1ZTgwRWV5RTkyQ240YkpEalJDMzRJ?=
 =?utf-8?B?dWZhenZwWHhHN2R2TVBHVmlOTnNOM0xxWHpaNTVTcThWTVo5K0hpZExORU1s?=
 =?utf-8?B?T0dNVTR0R3RHS3pWbU90MEtNSWlCZ2s2NHZ0TmU2OHZHY0ZIbFlWQ1YrQ0Rm?=
 =?utf-8?B?NXAxeml4UGRRV25BajRaTkpNek5aR1NIM2pZMmJVbkpFL2Jjck5xUjEvWVRl?=
 =?utf-8?B?NjhOSi9aMUFnT0x1VVhISXVvb241a0FULzRoSi9lUGp1QWowWDMzSWhPcEVn?=
 =?utf-8?B?WFNFTHVrcjRYWTdEbVhmRVd1RmVFSXhGMU9XdnZIdU50U0plWnhiZzIvQTVM?=
 =?utf-8?B?ZkFVVGI4SWJOdFp1OWc0VU5MMFdXZVMwelNXblZYaUVBM2JCSnBoclJmSmRO?=
 =?utf-8?B?bUJPcThEcFp6cW9Uck4yS3M4TEVZei9nVVdqY3BFeXB6bzFIWm9RZS9MMEFv?=
 =?utf-8?B?ZXJheDNXcUI0QVcwV21tVWtEUzVVWCszUDZ4NEoxNzM0Yzk3WlhUbTdwcmNE?=
 =?utf-8?B?eGprSTVxM2I3UzdKVmpDb2NjVjhiOEdwYW5hUk1FbjBsZWRNOUZEc3pUOGVS?=
 =?utf-8?B?QlBTYzFlTmNkNDNYMk1aMVRReGQ3RUZKSGMrRUJ0WlpEZHpMbjVYUU5UZlpr?=
 =?utf-8?B?ak1nbUtqWnd0WHhtZmwzV0U5NGF6bmdHYlRDdzV4M1M5N1RRSjFhcnpmUjZq?=
 =?utf-8?B?NHgwTVBPUTk1b3NLN0VUSWVHbm4xNFlZSVBzTjQvbHE1VzE4a2xxNC94cTV6?=
 =?utf-8?B?Q1BtMTJqQnhuNFQ0UDlGSGlMTjFnajNidHZCZ2VmaVdNSG45MEdrR3ZTek9C?=
 =?utf-8?B?clRrRGREQjNJUmNFSXA3Y0ZMbHd0WlkvZ01sTisvZENBV1NvU1IrRG54MjRo?=
 =?utf-8?B?QXdac1MrWnAzK3dSbENwbUNtckt4dFNYSDRRU2IwSkJrYlFnSzdscFRtTFBN?=
 =?utf-8?B?UjJDSHBXVlMxcHZZR3M4c2s5L3g5cm8yTmdCS3N5NEtzRzRJVURoVnVpTzYy?=
 =?utf-8?B?WnFVYytqNXlDVmlDdUs2Tkl6S2FmRjd1VFlHcERQMXJSTGVtcVkveUQ3VERy?=
 =?utf-8?B?SEhjVEN3T3JjRFJUNjhOQWVMa0dZZVREdVM3YzdibkxCMWdmKytKK2laZCty?=
 =?utf-8?B?YnRDMjdBdVYwSXhvc1QzRGdYS3RtUWhhRDIvcmJqbW5MK0o4ZkU0MUpNd2c0?=
 =?utf-8?B?Q0pHT2srblJSaXI1b0RnOUpQMHNZR2RoNEVKc0F2bXpEc09yMjBtUGhaQmgy?=
 =?utf-8?B?TWthTUxnVEN6Sk1mWDVWc3R6Q3VQQ053Uk43bnZRem1jM2VBZVRCYkp3Zjl2?=
 =?utf-8?B?WElhMXBqMGpIelRMUmREUlRWTHZzSXMyUTR6VjRxUDJVZG44N0xJRTE4blNt?=
 =?utf-8?B?dFJQbkp5c3kxQkJodkFGOENKaDBROW9LOW05eDU1d0crS1ZqWUJYUTFOTWl4?=
 =?utf-8?B?cks2eWI5VFhRMC9TaCt0WEc2K2VEenFYUTdtcTdNWFpTMnVwMG9JMDI5c3ND?=
 =?utf-8?B?NGJFR01YRm9nY3p5SEp0RE5Zc0hocDFta0JIZTE0OTkzRDhqN2dvNzY4M0tB?=
 =?utf-8?B?Q0VxRkNmS0Ywb3BnNWpwUW5tMmZlWUtTNXU5dUxuK2xoem9saDdtWmlrb2dH?=
 =?utf-8?B?WlFnNHNLS3VHUWhMQVVxOXE0RjlsMndldG00MFJBakpwa0lQU01Tc2lVTE9k?=
 =?utf-8?B?NUhzNUF5SldObi84K0FIWjIvVHphZHhoUVd0VysrOEdIc1UxQm5md2ZxTVhE?=
 =?utf-8?B?RlVFRFkzMkRUQ2w3NzkwRDBPcW9kdWhnb1lHakw2MmkvUkJYWGFGeXJKR1RI?=
 =?utf-8?B?SVUzMkFIWHFHMlk4YjNMUEw0OHFGUXRua09uSXJuVjVrRVdKckwrUkN3VEFP?=
 =?utf-8?B?OUF3VHZuZ2lNZTFYTGJ0OFlyNFA4TXIyR2JITzdHaVhqeTV4MTVad09GSlYy?=
 =?utf-8?B?MlZleDc1NERCSkNVcmt6Y1FkbkVPbnZYWDZwM3NpTVI5VW0wYkVyUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f08140-191c-4f0b-7850-08debfeda8e2
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9612.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 14:54:19.7103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oS511tBxLYDbUcfkxzYlngt4/fk056saVPIvuIWWSjkxrgGh1sEIYxUJ1KmDFO+VvWUql/h24S9oJh6DOXlxgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7227
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

--------------h03C8tPZukudtSELMJK00iVS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-06-01 10:40, Kasiviswanathan, Harish wrote:
> AMD General
>
> Ping on this once more. Thanks.
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> *Sent:* Tuesday, May 12, 2026 10:50 AM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: [PATCH 2/2] drm/amdgpu: 
> amdgpu_device_is_peer_accessible to support all BARs
> AMD General
>
> Ping on this patch series. Thanks.
> ------------------------------------------------------------------------
> *From:* Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> *Sent:* Saturday, May 2, 2026 5:28 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> *Subject:* [PATCH 2/2] drm/amdgpu: amdgpu_device_is_peer_accessible to 
> support all BARs
> amdgpu_device_is_peer_accessible was initially written to check peer
> VRAM access, however, it is getting called for DOORBELL & MMIO range.
> Add support for these also
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 15 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 77 +++++++++++++++----
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  2 +-
>  4 files changed, 78 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 6b9d103fbff1..b67d42d7f8a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1455,7 +1455,8 @@ enum amdgpu_pcie_bar {
>  };
>
>  bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
> -                                     struct amdgpu_device *peer_adev);
> +                                     struct amdgpu_device *peer_adev,
> +                                     enum amdgpu_pcie_bar pcie_bar);
>  int amdgpu_device_baco_enter(struct amdgpu_device *adev);
>  int amdgpu_device_baco_exit(struct amdgpu_device *adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 7c01492e69dd..a9be242c6bfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -900,8 +900,19 @@ static int kfd_mem_attach(struct amdgpu_device 
> *adev, struct kgd_mem *mem,
>               (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
>                  if (mem->domain == AMDGPU_GEM_DOMAIN_VRAM)
>                          same_hive = amdgpu_xgmi_same_hive(adev, bo_adev);
> -               if (!same_hive && 
> !amdgpu_device_is_peer_accessible(bo_adev, adev))
> -                       return -EINVAL;
> +               if (!same_hive) {
> +                       int bar;
> +
> +                       if (mem->alloc_flags & 
> KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL)
> +                               bar = AMDGPU_PCIE_BAR_DOORBELL;
> +                       else if (mem->alloc_flags & 
> KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)
> +                               bar = AMDGPU_PCIE_BAR_MMIO;
> +                       else
> +                               bar = AMDGPU_PCIE_BAR_VRAM;
> +
> +                       if (!amdgpu_device_is_peer_accessible(bo_adev, 
> adev, bar))
> +                               return -EINVAL;
> +               }
>          }
>
>          for (i = 0; i <= is_aql; i++) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5c14fdbc1847..a5c1160cdd03 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6185,36 +6185,83 @@ static void amdgpu_device_get_pcie_info(struct 
> amdgpu_device *adev)
>   *
>   * @adev: amdgpu_device pointer
>   * @peer_adev: amdgpu_device pointer for peer device trying to access 
> @adev
> + * @pcie_bar: PCIe BAR index to check accessibility for:
> + *            0 = VRAM aperture (BAR 0)
> + *            2 = Doorbell aperture (BAR 2)
> + *            5 = MMIO remap aperture (BAR 5)
> + *
> + * Return true if @peer_adev can access (DMA) @adev through the specified
> + * PCIe BAR. For VRAM (BAR 0), @adev must be "large BAR" and the BAR must
> + * match the DMA mask of @peer_adev. For doorbell and MMIO BARs, only the
> + * DMA addressability and P2P chipset support are checked.
> + *
> + * @note: CONFIG_HSA_AMD_P2P indicates support for P2P DMA mappings. 
> Query
> + * P2PDMA distance only if the kernel has all the prerequisites for 
> P2P DMA
> + * support. Otherwise fall back to the less reliable legacy P2P 
> support to
> + * avoid regressions.

I think this comment was taken from a non-upstream branch. On the 
upstream branch there is no legacy P2P support and this function simply 
returns false. I'd just remove this paragraph.

With that fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>   *
> - * Return true if @peer_adev can access (DMA) @adev through the PCIe
> - * BAR, i.e. @adev is "large BAR" and the BAR matches the DMA mask of
> - * @peer_adev.
>   */
>  bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
> -                                     struct amdgpu_device *peer_adev)
> +                                     struct amdgpu_device *peer_adev,
> +                                     enum amdgpu_pcie_bar pcie_bar)
>  {
>  #ifdef CONFIG_HSA_AMD_P2P
> -       bool p2p_access =
> -               !adev->gmc.xgmi.connected_to_cpu &&
> +       bool p2p_access = true;
> +       bool p2p_addressable = false;
> +       resource_size_t bar_base = 0, bar_size = 0;
> +
> +       /* VRAM requires large BAR (full VRAM visible) for P2P access */
> +       if (pcie_bar == AMDGPU_PCIE_BAR_VRAM) {
> +               if (!adev->gmc.visible_vram_size ||
> +                   adev->gmc.real_vram_size != 
> adev->gmc.visible_vram_size)
> +                       return false;
> +
> +               /* VRAM on CPU-connected xGMI devices is accessed via
> +                * coherent fabric, not PCIe BAR P2P
> +                */
> +               if (adev->gmc.xgmi.connected_to_cpu)
> +                       return false;
> +       }
> +
> +       switch (pcie_bar) {
> +       case AMDGPU_PCIE_BAR_DOORBELL:
> +               bar_base = adev->doorbell.base;
> +               bar_size = adev->doorbell.size;
> +               break;
> +       case AMDGPU_PCIE_BAR_MMIO:
> +               bar_base = adev->rmmio_base;
> +               bar_size = adev->rmmio_size;
> +               break;
> +       case AMDGPU_PCIE_BAR_VRAM:
> +       default:
> +               bar_base = adev->gmc.aper_base;
> +               bar_size = adev->gmc.aper_size;
> +               break;
> +       }
> +
> +       if (!bar_base || !bar_size) {
> +               dev_dbg(adev->dev, "Invalid BAR%d configuration for 
> P2P access\n",
> +                       pcie_bar);
> +               return false;
> +       }
> +
> +       p2p_access =
>                  !(pci_p2pdma_distance(adev->pdev, peer_adev->dev, 
> false) < 0);
>          if (!p2p_access)
>                  dev_info(adev->dev, "PCIe P2P access from peer device 
> %s is not supported by the chipset\n",
>                          pci_name(peer_adev->pdev));
> -
> -       bool is_large_bar = adev->gmc.visible_vram_size &&
> -               adev->gmc.real_vram_size == adev->gmc.visible_vram_size;
> -       bool p2p_addressable = amdgpu_device_check_iommu_remap(peer_adev);
> +       p2p_addressable = amdgpu_device_check_iommu_remap(peer_adev);
>
>          if (!p2p_addressable) {
>                  uint64_t address_mask = peer_adev->dev->dma_mask ?
> ~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
> -               resource_size_t aper_limit =
> -                       adev->gmc.aper_base + adev->gmc.aper_size - 1;
> +               resource_size_t bar_limit = bar_base + bar_size - 1;
>
> -               p2p_addressable = !(adev->gmc.aper_base & address_mask ||
> -                                    aper_limit & address_mask);
> +               p2p_addressable = !(bar_base & address_mask ||
> +                                    bar_limit & address_mask);
>          }
> -       return pcie_p2p && is_large_bar && p2p_access && p2p_addressable;
> +
> +       return p2p_access && p2p_addressable;
>  #else
>          return false;
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 4dc9f9aa3a2e..0b50a35b79a5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1496,7 +1496,7 @@ static int kfd_add_peer_prop(struct 
> kfd_topology_device *kdev,
>
>          if (!amdgpu_device_is_peer_accessible(
>                                  kdev->gpu->adev,
> -                               peer->gpu->adev))
> +                               peer->gpu->adev, AMDGPU_PCIE_BAR_VRAM))
>                  return ret;
>
>          if (list_empty(&kdev->io_link_props))
> -- 
> 2.43.0
>
--------------h03C8tPZukudtSELMJK00iVS
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-06-01 10:40, Kasiviswanathan,
      Harish wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:SJ2PR12MB8650FE9E3CF273ABAFCDA7338C152@SJ2PR12MB8650.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">@scope { P {margin-top:0;margin-bottom:0;} }</style>
      <div>
        <div style="font-family: Calibri; text-align: left; margin-left: 5pt; font-size: 10pt;">
          AMD General</div>
        <br>
      </div>
      <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
        Ping on this once more. Thanks.</div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font face="Calibri, sans-serif" style="font-size:11pt"><b>From:</b> amd-gfx
          <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on behalf of
          Kasiviswanathan, Harish <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a><br>
          <b>Sent:</b> Tuesday, May 12, 2026 10:50 AM<br>
          <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
          <b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu:
          amdgpu_device_is_peer_accessible to support all BARs</font>
        <div>&nbsp;</div>
      </div>
      <style type="text/css" style="display:none">@scope { p
	{margin-top:0;
	margin-bottom:0} }</style>
      <div dir="ltr">
        <div>
          <div style="font-family: Calibri; text-align: left; margin-left: 5pt; font-size: 10pt;">
            AMD General</div>
          <br>
        </div>
        <div class="x_elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt;">
          Ping on this patch series. Thanks.</div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="x_divRplyFwdMsg" dir="ltr"><font face="Calibri, sans-serif" style="font-size:11pt"><b>From:</b>
            Kasiviswanathan, Harish
            <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a><br>
            <b>Sent:</b> Saturday, May 2, 2026 5:28 PM<br>
            <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Kasiviswanathan, Harish
            <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a><br>
            <b>Subject:</b> [PATCH 2/2] drm/amdgpu:
            amdgpu_device_is_peer_accessible to support all BARs</font>
          <div>&nbsp;</div>
        </div>
        <div class="x_BodyFragment"><font size="2"><span style="font-size:11pt">
              <div class="x_PlainText">amdgpu_device_is_peer_accessible
                was initially written to check peer<br>
                VRAM access, however, it is getting called for DOORBELL
                &amp; MMIO range.<br>
                Add support for these also<br>
                <br>
                Signed-off-by: Harish Kasiviswanathan
                <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a><br>
                ---<br>
                &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +-<br>
                &nbsp;.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c&nbsp; | 15 +++-<br>
                &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbsp; | 77
                +++++++++++++++----<br>
                &nbsp;drivers/gpu/drm/amd/amdkfd/kfd_topology.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 +-<br>
                &nbsp;4 files changed, 78 insertions(+), 19 deletions(-)<br>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
                b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                index 6b9d103fbff1..b67d42d7f8a7 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                @@ -1455,7 +1455,8 @@ enum amdgpu_pcie_bar {<br>
                &nbsp;};<br>
                &nbsp;<br>
                &nbsp;bool amdgpu_device_is_peer_accessible(struct
                amdgpu_device *adev,<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
                amdgpu_device *peer_adev);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
                amdgpu_device *peer_adev,<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum
                amdgpu_pcie_bar pcie_bar);<br>
                &nbsp;int amdgpu_device_baco_enter(struct amdgpu_device
                *adev);<br>
                &nbsp;int amdgpu_device_baco_exit(struct amdgpu_device
                *adev);<br>
                &nbsp;<br>
                diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
                index 7c01492e69dd..a9be242c6bfa 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
                @@ -900,8 +900,19 @@ static int kfd_mem_attach(struct
                amdgpu_device *adev, struct kgd_mem *mem,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (mem-&gt;alloc_flags &amp;
                KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mem-&gt;domain ==
                AMDGPU_GEM_DOMAIN_VRAM)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; same_hive =
                amdgpu_xgmi_same_hive(adev, bo_adev);<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!same_hive &amp;&amp;
                !amdgpu_device_is_peer_accessible(bo_adev, adev))<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!same_hive) {<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int bar;<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mem-&gt;alloc_flags &amp;
                KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL)<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bar =
                AMDGPU_PCIE_BAR_DOORBELL;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (mem-&gt;alloc_flags
                &amp; KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bar =
                AMDGPU_PCIE_BAR_MMIO;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bar =
                AMDGPU_PCIE_BAR_VRAM;<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                (!amdgpu_device_is_peer_accessible(bo_adev, adev, bar))<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt;= is_aql; i++) {<br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                index 5c14fdbc1847..a5c1160cdd03 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                @@ -6185,36 +6185,83 @@ static void
                amdgpu_device_get_pcie_info(struct amdgpu_device *adev)<br>
                &nbsp; *<br>
                &nbsp; * @adev: amdgpu_device pointer<br>
                &nbsp; * @peer_adev: amdgpu_device pointer for peer device
                trying to access @adev<br>
                + * @pcie_bar: PCIe BAR index to check accessibility
                for:<br>
                + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 = VRAM aperture (BAR 0)<br>
                + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 = Doorbell aperture (BAR 2)<br>
                + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5 = MMIO remap aperture (BAR 5)<br>
                + *<br>
                + * Return true if @peer_adev can access (DMA) @adev
                through the specified<br>
                + * PCIe BAR. For VRAM (BAR 0), @adev must be &quot;large
                BAR&quot; and the BAR must<br>
                + * match the DMA mask of @peer_adev. For doorbell and
                MMIO BARs, only the<br>
                + * DMA addressability and P2P chipset support are
                checked.<br>
                + *<br>
                + * @note: CONFIG_HSA_AMD_P2P indicates support for P2P
                DMA mappings. Query<br>
                + * P2PDMA distance only if the kernel has all the
                prerequisites for P2P DMA<br>
                + * support. Otherwise fall back to the less reliable
                legacy P2P support to<br>
                + * avoid regressions.<br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <p>I think this comment was taken from a non-upstream branch. On the
      upstream branch there is no legacy P2P support and this function
      simply returns false. I'd just remove this paragraph.</p>
    <p>With that fixed, the patch is</p>
    <p>Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:SJ2PR12MB8650FE9E3CF273ABAFCDA7338C152@SJ2PR12MB8650.namprd12.prod.outlook.com">
      <div dir="ltr">
        <div class="x_BodyFragment"><font size="2"><span style="font-size:11pt">
              <div class="x_PlainText">&nbsp; *<br>
                - * Return true if @peer_adev can access (DMA) @adev
                through the PCIe<br>
                - * BAR, i.e. @adev is &quot;large BAR&quot; and the BAR matches
                the DMA mask of<br>
                - * @peer_adev.<br>
                &nbsp; */<br>
                &nbsp;bool amdgpu_device_is_peer_accessible(struct
                amdgpu_device *adev,<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
                amdgpu_device *peer_adev)<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct
                amdgpu_device *peer_adev,<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum
                amdgpu_pcie_bar pcie_bar)<br>
                &nbsp;{<br>
                &nbsp;#ifdef CONFIG_HSA_AMD_P2P<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool p2p_access =<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&gt;gmc.xgmi.connected_to_cpu
                &amp;&amp;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool p2p_access = true;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool p2p_addressable = false;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resource_size_t bar_base = 0, bar_size = 0;<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VRAM requires large BAR (full VRAM visible)
                for P2P access */<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pcie_bar == AMDGPU_PCIE_BAR_VRAM) {<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gmc.visible_vram_size ||<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.real_vram_size !=
                adev-&gt;gmc.visible_vram_size)<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VRAM on CPU-connected xGMI devices is
                accessed via<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * coherent fabric, not PCIe BAR P2P<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu)<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (pcie_bar) {<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PCIE_BAR_DOORBELL:<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bar_base = adev-&gt;doorbell.base;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bar_size = adev-&gt;doorbell.size;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PCIE_BAR_MMIO:<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bar_base = adev-&gt;rmmio_base;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bar_size = adev-&gt;rmmio_size;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PCIE_BAR_VRAM:<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bar_base = adev-&gt;gmc.aper_base;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bar_size = adev-&gt;gmc.aper_size;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bar_base || !bar_size) {<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;Invalid BAR%d
                configuration for P2P access\n&quot;,<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcie_bar);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p2p_access =<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(pci_p2pdma_distance(adev-&gt;pdev,
                peer_adev-&gt;dev, false) &lt; 0);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p2p_access)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;PCIe P2P access
                from peer device %s is not supported by the chipset\n&quot;,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pci_name(peer_adev-&gt;pdev));<br>
                -<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_large_bar =
                adev-&gt;gmc.visible_vram_size &amp;&amp;<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.real_vram_size ==
                adev-&gt;gmc.visible_vram_size;<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool p2p_addressable =
                amdgpu_device_check_iommu_remap(peer_adev);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p2p_addressable =
                amdgpu_device_check_iommu_remap(peer_adev);<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p2p_addressable) {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t address_mask =
                peer_adev-&gt;dev-&gt;dma_mask ?<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                ~*peer_adev-&gt;dev-&gt;dma_mask : ~((1ULL &lt;&lt; 32)
                - 1);<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resource_size_t aper_limit =<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.aper_base +
                adev-&gt;gmc.aper_size - 1;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resource_size_t bar_limit = bar_base +
                bar_size - 1;<br>
                &nbsp;<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p2p_addressable =
                !(adev-&gt;gmc.aper_base &amp; address_mask ||<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aper_limit &amp;
                address_mask);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p2p_addressable = !(bar_base &amp;
                address_mask ||<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bar_limit &amp;
                address_mask);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return pcie_p2p &amp;&amp; is_large_bar
                &amp;&amp; p2p_access &amp;&amp; p2p_addressable;<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return p2p_access &amp;&amp; p2p_addressable;<br>
                &nbsp;#else<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
                &nbsp;#endif<br>
                diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
                b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
                index 4dc9f9aa3a2e..0b50a35b79a5 100644<br>
                --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
                +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
                @@ -1496,7 +1496,7 @@ static int
                kfd_add_peer_prop(struct kfd_topology_device *kdev,<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_device_is_peer_accessible(<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kdev-&gt;gpu-&gt;adev,<br>
                -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; peer-&gt;gpu-&gt;adev))<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; peer-&gt;gpu-&gt;adev,
                AMDGPU_PCIE_BAR_VRAM))<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;kdev-&gt;io_link_props))<br>
                -- <br>
                2.43.0<br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
  </body>
</html>

--------------h03C8tPZukudtSELMJK00iVS--
