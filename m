Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9C8C71130
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:05:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2992D10E51F;
	Mon,  7 Jul 2025 19:05:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rn4Y8KQJ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5BB010E51F
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:05:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/8Okro/jdnxY0DE0kSAQ4GBhwE4vAYpgC6IumBOwOS7JtAhZuGJ1Hp6vShDPdjg4BMjpOVcer0v/WkR+TR5/RTu2KkkRLS5aMY0iXOyXoHnnoB99l5RaloI/BqFkWKuHW4WkTaDM+NXlSP57U8KXFKHKKGagaN39mP0nCv7PZgDYuomr5tjYJBBKWjgeNTZYzE7lWy2MdESiVOy6l2GgzFNk9Um9ixYSi/l9l8oq/9gyOUtyS5aeUQWt1iULXvEh78DkkXCxiXzMn295ZiM0UH3WZiTiRNYjEZFz3rETgyEwiGSKII2egcKT/P11p7IQ9T4kJj3VFf5m3sw+dEioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmL1Xy9m/XKD0WOga0OET22aGwT6yXF+69cqrUxBNE4=;
 b=TqvFvOwlHcGPw25YEh/H0s9EIrKIG80Sd17CaSIDa9OXNKv6eUM9s9wXI24IrVmKcvivtnOX29TmaIVhjHiYQLwoYVp8ty/ldM4fOjbQbPubDtLxeJkRe9lDOqkm6gznYvwaJDYo4k6bj/JdzbaxSBRElJ3EWJrYs+eCNUdr1jDXEHPFG8fx7GekU8AC6txy34Hz2Ym4B94/bz51hsCvT7ijj+jqhqoz1cvY4k4yKsCUQ7lNkAKC6WdtzHxrxTw6Yr16W8WnCefoKSGr75KmvkiBVRHyQ9DXdK0LRu+M6DIN/c5AbT5oVZ2RzlCgTTD1nBwQ+60pK+XbRM98K7Gshw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmL1Xy9m/XKD0WOga0OET22aGwT6yXF+69cqrUxBNE4=;
 b=rn4Y8KQJJrzncy/6fKqEvdSxRFNDp+D37XJUlLLgK1cPzf4dTlfhTYqWKM4B/jc5K1sUvXgLjO/XgsApEeNLMfoe15J5ApMda4F+20cnC+DXOPoTZPDYvAfsg5fvFK0sV4qUimbkVo+4DPIsfULzPO/3tUYIv9nu3yTNBmUzCZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 19:05:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 19:05:01 +0000
Message-ID: <aef4dae7-c597-4288-a30f-d1bbb0b1efc3@amd.com>
Date: Mon, 7 Jul 2025 15:04:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/36] drm/amdgpu/vcn4: add additional ring reset error
 checking
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, sasundar@amd.com
References: <20250707190355.837891-1-alexander.deucher@amd.com>
 <20250707190355.837891-9-alexander.deucher@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250707190355.837891-9-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: e68c72db-ebe8-4140-7438-08ddbd892c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGNFUklVbU8vMS9zZnFNVVdUeHdadHRqZ2x3UGtYV04vQm8veVBQcWIzSSsr?=
 =?utf-8?B?TGozazlzQW9JVTdiMjlDbGo5ay9mVUhnREllWlgrWW40OWYrQStMSkwvcDFk?=
 =?utf-8?B?MjdxWlFOTEY2ODBLQXRReUFNZ29vdlBQb3E5b2Q1QStXY2g4TkNZYVhpdllk?=
 =?utf-8?B?OFA5Z3NnY2pVaGE5NG9QT0JZYW5aTlZ4TlFyd2xObVh6OXp6cTBTSG1ieVFY?=
 =?utf-8?B?QmtNMDYvT21TRVJIeTcwbWJNQUVra0VZWGhycFRDQjBhNlhnY3JZT05sNWV2?=
 =?utf-8?B?QjVGT1lMSXVUdVJrMlByS3dSMldSTFZNOWdIMVJMSkE5SjFEbUllWlBBeTZF?=
 =?utf-8?B?Uk1HT2dTZC8zc2JIb3JJTC9tb05DZGMwSTdqdytlSWZCVHR6VGcrSzhwcnJW?=
 =?utf-8?B?WE9yR3FBMEJPVVNReHhkQ09UNzlGZW9oQ3BVRzRHYzNNSkFQUytZLzZETDNo?=
 =?utf-8?B?Nk5uNm9sdEV2ZnVDdEtkUk9SbU1PNXZPMjlpUjh3ZUtoN2tXMkNWRGpsWWVv?=
 =?utf-8?B?SG8xb2dBS2tGUDlkNDI4QWpnUXd6VVd3R3lBK3QvZ1BHK0I0SlJGZnF5ZHFw?=
 =?utf-8?B?emFYVTBiTkg1Ly90U1pFQWdLbGVOamhEdVV4NnJmRDlyTnNMdjlOazVmVHY4?=
 =?utf-8?B?R0RWc1lDMm9NY2IvaFE3MGRZeW1SRHcwL3V4SHFkMDJZZStINHJ2VmszYUVy?=
 =?utf-8?B?L0RuZnVvN3VFUnRGVHhRZGtDVWZxdnVYMTBoeGZmS0U3dGNsNTJUTnpaMkdD?=
 =?utf-8?B?UEpDR2V0WnQ1NnprRFNzcEQ3NHplcDlmcnpoUXlaeEozcjd5MlBXK3BIZ09S?=
 =?utf-8?B?YjhPY2RmQi9YejlBVDNjMkpvMkwreEU0RC9LbzNydWU2NVNROXF0ak5TR0NO?=
 =?utf-8?B?RnV0ODR1NGdWa2RCc0FqNlZXRXVhVjIrOFRGM0Zwc1lKNUpTbmd1ejZtb2JK?=
 =?utf-8?B?UEQ2cDkxNCswNllCV0VWbkxFREtHdlF2QzYvR3gvd1lLc3hxZWRzN01EczJ6?=
 =?utf-8?B?cVlVVFhoS3Vkd3BTejhnZ1ZPeXRpaXFydDBaQ0FLZWVuM3FuTTFvNXpBc1dC?=
 =?utf-8?B?czVtZEU3dUxhRkFDWnBESDdlRWpWU3Z5R0c1Z1phTVU0L3ZxSXRrMGZJOU5M?=
 =?utf-8?B?aWRWeGJyUW1oWWVNdVBWM21xMXdnaUxleHpBOXljdDRxc2FXTWZHdkg2T0Rl?=
 =?utf-8?B?cDJPVmpmKys0dGxpdm9nekY0SndwRHJCNjRaNEZmWjdnNVJWK1c1YnpmVjVC?=
 =?utf-8?B?U0c3ZEFmdVgrV0RsdFdkWkhaY0VNN0s2MmZCMnRtMkNvRHluY0pORlFJNldO?=
 =?utf-8?B?OWtseVp3MGFYM0pDN2t2ZXVBa3RVVjNtR1hzWGpVNnlVSEhVZzc4SXdkSWUy?=
 =?utf-8?B?bFp3TFlvbVQxQ3dFTWZxMzdlVjg1aDU4YmVTM0d1ZWxnNXFqQlRHa1lvZGN3?=
 =?utf-8?B?ejc4dUpZanNqQ0h5LzhheXpncUEzODlkbUQycnNJbUhlOU8xa0hkL2pYY3JZ?=
 =?utf-8?B?Y0grcWhzbkxnVjF6c3NCdFJwVTJNMkpqQlM2ZmR2b0dXdmtmTGNQbk00ZEtp?=
 =?utf-8?B?ejB2N1lydlduRjVhaU1IWnh0d2xUa3FWc240UmNldWt2emt3ai9MbGtIeW1N?=
 =?utf-8?B?enBYaEdhL0crV1ZWK2dsUm9XdGVBNEFOR3pDbDFjMjdwSmZ4ZFRObzBhTFU0?=
 =?utf-8?B?MEhqZkd3RlVXN2RabjUwNEZ4S2g0T3BlUzJ2M3ZCQTlFMjVRdlhCa01Idy91?=
 =?utf-8?B?MTRkMTJuWEJVdE5MNlFkR2pWaGVPT09uMG5vZmFCRXBVcGp6VHZqTXB2MlpH?=
 =?utf-8?B?Wjdjci9iMnhNVjB3RU5MVlh2RDgyblM3YU1ObHNZL0ZRc0hwcVpzalVtNW9y?=
 =?utf-8?B?aDY4NE4yTEZrU2JWeDA5alhyaVNtYloxNWxXakNlNGZJSUtpTTdLREprYkNP?=
 =?utf-8?Q?BzOZcefCJEw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXJPejNsVldRRS9SaXV5QnNwekVoUVpjTUtYaUlpVkhMTnc5NDQ1T20zdTh0?=
 =?utf-8?B?Y3B5aHlvN296OEVseHcyckloTkNCeGRtWm83aWlyWXMzVVFSaDk1MnlTN1px?=
 =?utf-8?B?MjA2N1Ewb1JUT3RJMnZiblc5ZzA5UlA2Wmo1Vm4wcmNUbzhCVGZwd1UyTElD?=
 =?utf-8?B?TE52L25IYWtmVWdQWnJEbmt0UGJlaHVpQWNGZjRNM1VSdStjTGhkZGdieUJX?=
 =?utf-8?B?K2VqbE01TkVjeDVNaHk2S2NGYWJTa3U0SXB1cHhmZE8vZnBac0plTnZ5YnhQ?=
 =?utf-8?B?Q3JKUVJxQkhNb0h6Yk1kaGxlaS9nMXRFRm8rSWtBeWhKeGYwbldXL1A0Y0x1?=
 =?utf-8?B?a1Y5ZUtCTjMyZjYyWjNBU09aWHpJODExY3lXNjFOaXNFOVNneDJGNzZSc0E0?=
 =?utf-8?B?bnhiZU82TFZEWXRqa2NNcXQ5bnNrWHYvOXpaT2ovbVo1WitWZFFvU0Erall3?=
 =?utf-8?B?c1EvdUJmN3hQcHpNZFczdy9VSkJ4bnFQWXhkVDFNc1FZUkw3M0ZLVVRBN2F6?=
 =?utf-8?B?SEw4SkxXaG40eHh0RGVWS2sveG5aMjR3KzlBbG5UcHdrRVoyTFdtclVUcGRk?=
 =?utf-8?B?Tk9FZWpvZ2p4N2hid1FSSDZyYldTNEhnckZkNm5ERzBER3UxR1ozYXc2WHow?=
 =?utf-8?B?ZmlwTWk0RGpjaGd5dm5EWFBTVjlMRXh3RC9pcld3aFJ5aTUxcjI0Z3NDeWhu?=
 =?utf-8?B?RVp3UWs3U3NRNTB6TGRTSU1NVGxpYUk2WWMveTY4eFd4K3RRZjlwbGd5VjRs?=
 =?utf-8?B?cWtZMDRncUltaHlld2gvdVg0R1k4ZjlpQmtxMndQVzJUQnhpNzBxNTNJU3FZ?=
 =?utf-8?B?ZTJmL1BQZ1pQR2p5Q0lsUnhLQ2djNXg4czdreTdIWS9yWWdyVkhBNHY0TTlh?=
 =?utf-8?B?eFVIRzVPZmtmZm5ZSDlDN2NCdVpRL1Zsc0duelJrdmtXQ3QwaFYxSDFydm8y?=
 =?utf-8?B?OGI4MEc1Y2J0TW9QN1J5OXVnbllncHAxZndnNXNKSXQ5YTRwMFkyNVpOSzdP?=
 =?utf-8?B?cXNOVXh2cnk4Z1Nsb2FrOEttSHRtelBZYThveExFV3dOZDNMTXA1Q2VsOFNE?=
 =?utf-8?B?T3lub2x3ZVN6RlJJWFhJVDE2K2psMU9WbzVwMUxpMVZpc3dyUnp1K21ZY2lN?=
 =?utf-8?B?ak91aFNkZU5vVUpaSEFkUzc5TTdsQmhQTEZ1cHAvaEdxS0EyZ29WWmp5L2lD?=
 =?utf-8?B?bmI1M1hZcE9KcUJHZ0NFbm53cFh2OWdOMTh2Mm5hTFVwVG1uOWJqR25PVUFJ?=
 =?utf-8?B?YVFPTUxZNTBhSjJUTVhDa2Q5cWtoYkFBcFR0SXVKSVpmTXc2K3Jxbkc0WUxq?=
 =?utf-8?B?N2lRdXZNUVVRSC9UaHpYWFNSVFBkWmZTeC9ESlgwQWVKbmQ0TWNMRTg0ZFFw?=
 =?utf-8?B?ZExTRVpGQlUwQVhLeStTSy96dWcvMzBMQjl2OHBFNnRnb21pUkIwYVRTQmVp?=
 =?utf-8?B?dHFUbnd5ZTUrcTNYSkxxbTAzcEZyN2VaUlhwMGJIMy9pc2dIUHc4SmZGMWhM?=
 =?utf-8?B?RnNRMm8wZ1JxMmxyWlAwQ2RzZTlZdFY4RkNOT3I4d1JwN0FkL0t4U1U4U1h2?=
 =?utf-8?B?WDlLUS81NGVIYzJHTEdRUXRqMFdKRkl4cFVrbCs5a2pEZXBXaUlqNnpkbFM3?=
 =?utf-8?B?ZWErdzJ6THFwS21JbGtDcm9zVTZKcHJaQUJ1V3hqRUlwbHF0T2FlU2h3SXlX?=
 =?utf-8?B?WU5jQUN2bkFjdXVXYUpDRFlrL0trUEJaN3hsZUFvRWxLektqSG5wamw0MERM?=
 =?utf-8?B?dmd2Ny9Ia2l2THpvMzM5ZnFqWWdkTzVMK0xrQlRXMDBZNndpUTRIMk9WTmph?=
 =?utf-8?B?VURZbnZUTDZQRHRIMVRobDIyTWR5cityb3pmUzRVeFJwSS9heVZBV2s1R2gz?=
 =?utf-8?B?WW1IdWpiSkkxTmNFZ2RqYkR3RUpUWVEzVHppNVMrQzFMWmI2VzdSVkZXK0xs?=
 =?utf-8?B?eTNmRFdPbWhleDRjY1IyMkNWenIvNUtmL2NiOHlSblo4a3JEbW9OU0duT2c4?=
 =?utf-8?B?S2YyZXNyUVluOG4xNlJTL0J3NklzdXFETVhoTFRNRUhQM1lRZTJQdmcrVnVl?=
 =?utf-8?B?UmppM0RwaXNZTjB6T2ZHTGd4WFRWSkEwVWlWQlkyYTErVmpyYVhOK3JtL01P?=
 =?utf-8?Q?N9AhRXTu/7QE/MKPg2viYkj6W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e68c72db-ebe8-4140-7438-08ddbd892c56
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:05:00.9897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7I8yp6QoGBaSDQSZDAJmBorPOi6DuZY7FFCjFrft4LrL9P+V19nArKvOj85RTciQj9X2FPGuDNmC9Pt3CYqKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575
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

On 7/7/2025 3:03 PM, Alex Deucher wrote:
> Start and stop can fail, so add checks.
> 
> Fixes: b8b6e6f1654d ("drm/amd: Add per-ring reset for vcn v4.0.0 use")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Mario Limonciello <mari.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index eec9133e1b2c4..5bbce8544fef0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1979,8 +1979,12 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
>   		return -EOPNOTSUPP;
>   
>   	drm_sched_wqueue_stop(&ring->sched);
> -	vcn_v4_0_stop(vinst);
> -	vcn_v4_0_start(vinst);
> +	r = vcn_v4_0_stop(vinst);
> +	if (r)
> +		return r;
> +	r = vcn_v4_0_start(vinst);
> +	if (r)
> +		return r;
>   
>   	r = amdgpu_ring_test_helper(ring);
>   	if (r)

