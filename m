Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F032FC54FB3
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Aug 2024 13:37:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D0CE10E528;
	Wed, 28 Aug 2024 13:37:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CZPmAe+Q";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C9C210E523
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Aug 2024 13:37:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eR+3blF6O59Gx/m71KYSwYrhxvbl5Ij1M3P/MjSwPolnODd7FL12AnectYIFvqu5tpPVvKFrtYSeYh85aD1Q/U7CnNiZEllPJgiRTqT0EHycJWP43r7kcl4bZkmEuI9kkpxpB0Wkozxwo3s7nyioovU2HlnPWHLlhrv1xa8wf7bB5dBVfqTM5gpi6OMkQbkZH9n6AoCDDdu5XQyRmlW/y+Odwm+qavshcqO5vRs6pRNLKtxF9aIhIV9gNvo6RtZVPj4uQiF2SpKH7A83et8rvB6jmhQ9eUt9ayLKD8fMF0RZfIC/Ev0T47KwtTMBqSSPNOUlatyFHrZ8kfnvYFu1hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsIyBzmyqSotGk8TC8I/k+8FOGPTLhIJ4f1CEjBWIrc=;
 b=ulk3s4wBKij3RYIdrlQILnTLyoAbHT0f/9hnO9TGend1+oBzQsvtIn8t96tmeM3EUeEmkNjtST3HIxtxrkzVoHPnzsMrJbcO1KGEgIhlCt9rxVW0ukYXqYZtm2CaOazDUXmYrTDU8MPXwGT/PalX0BU3nvo+c2WsmtTgJf9yZp/tMXGCaPiBJgP2/OjzFMkH5Kw2wONiJIy/uhc6uLzdYJmwRnRamIAnPPk9VGewPLAmhyavnNupFsF0OsGBTyTySZovXwD4iUR4oD1hlxilocIm8QiUmdcz1OznA+KmQyq9ZF1rZ7sK2+DSffyyx/LqFRBgL1je0jkplz0d8QMlYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsIyBzmyqSotGk8TC8I/k+8FOGPTLhIJ4f1CEjBWIrc=;
 b=CZPmAe+QzwV8sbavJ1KM7qCWm7qM2mUyvfDl4VqX8dt91Zyttp527wS9hM+mvY1mz62ICjtSvsxG1E9roe/cbJRFH3/PcMrRm1h+mpogim+MBHbmKyLY1utqwzBjml+CbgY+ZqjdvJOUXSLaTsmM5qos+OWW3f4MScuDNUBWJWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 13:37:12 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%3]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 13:37:12 +0000
Message-ID: <6c60f44d-dc8f-4c70-a4ff-1d0d0517fc24@amd.com>
Date: Wed, 28 Aug 2024 19:07:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Normalize reg offsets on JPEG v4.0.3
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, leo.liu@amd.com,
 jane.jian@amd.com, sathishkumar.sundararaju@amd.com
References: <20240828061133.1880057-1-lijo.lazar@amd.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <20240828061133.1880057-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::26) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|DM6PR12MB4108:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b165cb9-bda9-4bfd-3bbc-08dcc76685c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnVMZTJ5Mkh3QWZRMUdLbm5zRlNNY281cWsyUkFHTy96TzhPZDNtK0pwSk9k?=
 =?utf-8?B?ZS9rYXZVYkFDdnZFUmRkODh5VlVtWm9XVUFybjlZVjdHb1dXa3BoQXVPQnZ2?=
 =?utf-8?B?dVViblMwVVRYaC9TV1hnNVFhY3AwL2QzL21mMXJSZEJlVjFCaHB2Y0JTUG5o?=
 =?utf-8?B?VU5FZ0JtRHI3WVJhY2xwSmF5OURRQmZtMmIvempoSUZYV0JjakcvRmI2eUlN?=
 =?utf-8?B?TWhiaUhFc3kvaW9Fd0lvTkwyVWVVQjBrOEs3VVdFUGt6L2MrRWcxWTVaSnRK?=
 =?utf-8?B?WUluZEZQRCtzb3NYaDdIU0lhZmlMRFdScnY2OVpLaCtsQU1tV0c0TGN2d241?=
 =?utf-8?B?aVcvUVZ5dmtyd3o2dDlHbEVBN3FpQUtreGVReXlESFZnZE5UYVBJbno2RG9J?=
 =?utf-8?B?ZmQyWFZIUGF4d1BWQjUzVlozMTdWWTY5czFGK01pLzIxNmwvLzByNHlCVVc1?=
 =?utf-8?B?a0xzNDc0U1JYUVhseG1hem5PNkdIYUo4SHNDdmIwK3F4a0lLWGdwbXNXcXlP?=
 =?utf-8?B?cE5iZnViK1dXMWNQbEp1YUJPdlMyQWUrdEMvUE8rdGw3SUo5cTk4OWdZT3oy?=
 =?utf-8?B?WElwRU1kOCtPV2JXN3Y5M2w3cWJ2d0FIRm0vZkQ1eVFoR3JlNHU2ejdtcE11?=
 =?utf-8?B?em0vNEZtbXBFOHpadkI5Uk5XZ3VwZS9PaEtGYjl2c3ZnOTdXeSsrZDBwSEpN?=
 =?utf-8?B?VUZtRGFOdlpWcEVBR3Nja2tlUG1TeVBuU3RjREU2bGQzSUVlWVVWQVJueC9q?=
 =?utf-8?B?MXpJSjF1RVBSWllHbUIxMVlyM01yZ0VITzZ2YjFVZk5oQll5aHdMSWt2NmxT?=
 =?utf-8?B?cDV6R25EcURyOHk0OXovUjdqZUV2UXc3OVIzTmRJZGRPV080bUQ4UFpia3pa?=
 =?utf-8?B?WnhESUNFQzdLOW0wTTE1NXNTVElMMmNIT1dZU2srUlNYeDk1b25TRlhpd0VR?=
 =?utf-8?B?RCs3SDlFMnovSW9yU2JpQkZiK0R2VTdnS0NwdFVtYmVFaXRCMm1BUjgxSnRx?=
 =?utf-8?B?M3ljV3hJQkNDY0FhcEh5bnhVWnpNdUEzMXpCdTBCSGZKWTF5bTBjUHNyZHRs?=
 =?utf-8?B?S0dLNmpybHhkUktLdFNXZlhzSVhpeTJmN1FoODA0emVNQ2dmWExmaTVoYUN0?=
 =?utf-8?B?aDhWTjAxdnZQR3RnS2o2ZHZMcE8vUWRmRmZtenhlNVVoaW5ueU1NWTNsWUJh?=
 =?utf-8?B?cVBhdU5qMWpmWnluUUI4aDBkcWtHRVZkTEtuU1oyUTQ3MXF1TkVCczEyNXpO?=
 =?utf-8?B?QTNLYXdtS1AzNm5LclQ2OS9WM21wVXRrTGtSWWVxa2JiSHBIZXArOE9aR2py?=
 =?utf-8?B?UUJKazRpcDV4R3hDdmFDeGNWR3B1dUlEbitYSVpua3dlRTdtcVZQUjgwbXBP?=
 =?utf-8?B?ZkR3eFg4cCswSUZLR1dPb2JKRE5veFNwdVkzclRyMmZxelI3WWhsYjhsUjdh?=
 =?utf-8?B?WmlDYm53bHhpdVUydFlqYW5XT2VLdU91VkMrZURXb2h2YWxyeHljb2pyVVNC?=
 =?utf-8?B?NFhrQjl2aDViVkhoMW41TWpQMDhQb3Bld01xSWZnbXQyWWJLWFhjR1UzVU5l?=
 =?utf-8?B?Y2gwR0I5TGNYQndySEp0QlhwSFRKUm9OcnpKdE1WZXVVejJnRVJjNDYrYUQz?=
 =?utf-8?B?NDZQRlJBY1FRSzF6RllIUVpkd2pkM210allkMEdydGhOcDJ0c0R4WllUdGp4?=
 =?utf-8?B?amYxZENUNC9Yd2RhRkZDWnVTc0VVL3dBNkVjd2wwY0kxRWZaaE9aY280NTQ3?=
 =?utf-8?B?aVByWnNYUTJuak5WaGJUNVIvOUlld055ck9DNk9ZZklJM3ZlYW9MeU1SK3ln?=
 =?utf-8?B?VElnMm5QMEllZC90MldYZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0NqbFNGN1RqSzd3VzhkRjJaeXNEMjRPUDI0bHN3QmpVMUNkQVBrZk9CSXRh?=
 =?utf-8?B?Y0pqWFYrVkhmQmtLOW9NRUZIWEtyY0QycEh0TXN1ZmRKNTZ1a3gvTkdVMlEy?=
 =?utf-8?B?M3hGYmZ5TndHUGZ6QlRBWXg3MEFpL1pHR0svNlJ5RXRMblpGbG0vcHhVLzUv?=
 =?utf-8?B?cXQyZGExVXAwaXc5cjRmZ0luWjQ5WC9iM0l5TGlHUjhKVE15U0toeVd0VDRu?=
 =?utf-8?B?Q2JxbVoyRGYzUkFMZ0d0cWE1NHRRWGtKNG5IYnJKWGdnOTFvOEVBYitidEda?=
 =?utf-8?B?azBiSWR5a2dMckFwb2dpK3k5NFlPKzNRTVU0aWd2cXEzb3B2aW1PWjd1ck5m?=
 =?utf-8?B?czJiL1p2bGJxZjQvc3BqZU8vaVlidTZIWURuSml0NEt0NEZjQStnSkY5UTJJ?=
 =?utf-8?B?NExyUVNKR3ZJKzh3NXpvcW9wMW5pWnZ4Um5POVBxcGllRlVCb1RkVk5BTjMz?=
 =?utf-8?B?VS9NVndIS1FZZWRLTHZocE1xaWY5RXdRVDZJR1RMREk5WllkSFllRDBzaHRZ?=
 =?utf-8?B?cjB1YUhOWlU2OWx1RnlBaHQyN2ZRcXJkbHNsbGYzeW9kTTdxNWltTk5kYnht?=
 =?utf-8?B?RDRWNUdwL2FvcVo0VUZvMFozTUxoV0JOYjJXRHpQVkY4Rkg2YTNFYURBdzhS?=
 =?utf-8?B?eVJiNzM3TjVjV3Y0QWo1R09mVC9tOG15ejlFMWR4UlBGTUNrMkV3cnA1d0hS?=
 =?utf-8?B?YlBPS0pHZFh0bTFlRS90K0RPSVY4R09tb0RLWFZDblpJTGNqR3JiUmJPaWZF?=
 =?utf-8?B?VFYxelRIY0JEZzhpdTczTkZaWkRVNExtZWtteTFTbEJnaGIyZUh3Q2N6K3I4?=
 =?utf-8?B?blNxbTFhd0U3ZkQzUlRheUhNeENZS3NWS1RDaUFndzhkY1dpRUxmdkM2bXhT?=
 =?utf-8?B?VTBvUnBKN2Jwd3N4TklZMytnRjMybCtKK3A4WUVOa3N2dGxOMStQQ2F6dzJx?=
 =?utf-8?B?TmRpZ21PWVlxdDRFY2QwNFpPWHZxTHNueUpQdkRtd1NZR1RGQU84Y05PdHZq?=
 =?utf-8?B?Z2ZBZ29wUUlVdGVsVGxaYWhMQzI2TW9kcWxmaTB6K1Zzb283dUxES2trOVox?=
 =?utf-8?B?UDZZbnBBWitCSzZIakM0S3hsdnBXR2lTQWc2RGpzSStSbUVFSWVlYy9pR0hO?=
 =?utf-8?B?bWxjMXlFTkJpVndkeTlpeE1hUG0xcGJHUElpQ1JJUjNWMy9qYnhpaDBUQndT?=
 =?utf-8?B?L3VFdHUwTTB3MGlpSzF4eHRaRFZKb3NRNXlMQTZNWi9qVWN5cjgxbU50aUJN?=
 =?utf-8?B?SWhsUlRQSllYVkRLZTQvbW0vdmNxZGozUFR5TlREYlJaYmtRN1dnQzB2K2NQ?=
 =?utf-8?B?YXRtMGhxZGZaWCtCa3pOYlhCTENnUzlHQVk5YzlXOTdQQUt4ZjN4VmF4Z3pn?=
 =?utf-8?B?cm45WjYyeXJIbG9POFh6dDFCZFkyaGM0NnlQREp5eHhNZE44VGFweVY2bDhu?=
 =?utf-8?B?bVZwOEZmOU92djNqY1pIU1BIcW9VcWx5c0FZdmNlRmdmN2Q2WWRnVjV0Qmkv?=
 =?utf-8?B?RG1Sa3NWcmVmUjQrMUpMaGsxMVcvYVVvSi9aUFV5cTNFTjRXanlhdzFJekQ1?=
 =?utf-8?B?dDQ0dWxnNGdTa290Y3RVMWxkS3BVRU04T0dIbEw0U05lb2RyOTJUcGdmc0hv?=
 =?utf-8?B?VjJENEhwWUVtOUVUZUtLVWFUSXVsdGlCL1hoc0pBK0pKckJteGVzbFRIRG04?=
 =?utf-8?B?MWhJcUo0WXV6YXVBelE5Y3Z5Sy9GUERSWjZHNVp1RU1TVXhlQWNqNnFTTXJl?=
 =?utf-8?B?dXI5SE5jQm15dWpianhuTUNXRWFhMTdxcm15MlNFaVlYTUhlcXZ6MkN4M0pZ?=
 =?utf-8?B?ZmhiNzhJZ3UxTnRreDMvSGlUSzBwVHJtT1pzTFo5bVRNUVFqRmRVUHc3Nlg4?=
 =?utf-8?B?NjJYZ3FScTNQVkQvaCttUDAzRk0zbkJqbVhmV3RnL3NoRUhHaEZ0L2J5QTlV?=
 =?utf-8?B?SlJjdklUQi9GSEl5VSt0dC9zd2RWQ0tVN0pLSDRiSjZoOUJJZ0Y3TEhIMGY4?=
 =?utf-8?B?NlNnQ01tMmlkK2FwWFpoWUFBaCtITEJXT2JINkY1NG5DdW9ELy9XR1daclRE?=
 =?utf-8?B?WkVZWUx0YUtGMzlCUzlTZUJpVEZFM0lsSlcweDF1L1YxVVR4UGYzT2F5T2dP?=
 =?utf-8?Q?l2q9sQsSaRlNKU1u5SOZyOua1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b165cb9-bda9-4bfd-3bbc-08dcc76685c1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:37:12.7033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zL6emMpWC/1akofYeX1phQSd21g+ajjwGi0E2159/LhKgxmhW+4w4zTN0hy0D7KpUNUqNOXgsLUszeJXF2WOqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4108
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


On 8/28/2024 11:41 AM, Lijo Lazar wrote:
> On VFs and SOCs with GC 9.4.4, VCN RRMT is disabled.
> Only local register offsets should be used on JPEG v4.0.3 as they cannot
> handle remote access to other AIDs. Since only local offsets are used,
> the special write to MCM_ADDR register is no longer needed.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
please move sign-off below v2 commit description and with that

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>

Thanks,

Sathish

> ---
> v2: Restrict the change to GC 9.4.4 on PFs.
>
>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 36 ++++++++++--------------
>   1 file changed, 15 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 6ae5a784e187..a4ebceaaa09c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -59,6 +59,12 @@ static int amdgpu_ih_srcid_jpeg[] = {
>   	VCN_4_0__SRCID__JPEG7_DECODE
>   };
>   
> +static inline bool jpeg_v4_0_3_normalizn_reqd(struct amdgpu_device *adev)
> +{
> +	return amdgpu_sriov_vf(adev) ||
> +	       (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4));
> +}
> +
>   /**
>    * jpeg_v4_0_3_early_init - set function pointers
>    *
> @@ -734,32 +740,20 @@ void jpeg_v4_0_3_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq
>   		0, PACKETJ_CONDITION_CHECK0, PACKETJ_TYPE4));
>   	amdgpu_ring_write(ring, 0);
>   
> -	if (ring->adev->jpeg.inst[ring->me].aid_id) {
> -		amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_MCM_ADDR_INTERNAL_OFFSET,
> -			0, PACKETJ_CONDITION_CHECK0, PACKETJ_TYPE0));
> -		amdgpu_ring_write(ring, 0x4);
> -	} else {
> -		amdgpu_ring_write(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6));
> -		amdgpu_ring_write(ring, 0);
> -	}
> +	amdgpu_ring_write(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6));
> +	amdgpu_ring_write(ring, 0);
>   
>   	amdgpu_ring_write(ring,	PACKETJ(regUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET,
>   		0, 0, PACKETJ_TYPE0));
>   	amdgpu_ring_write(ring, 0x3fbc);
>   
> -	if (ring->adev->jpeg.inst[ring->me].aid_id) {
> -		amdgpu_ring_write(ring, PACKETJ(regUVD_JRBC_EXTERNAL_MCM_ADDR_INTERNAL_OFFSET,
> -			0, PACKETJ_CONDITION_CHECK0, PACKETJ_TYPE0));
> -		amdgpu_ring_write(ring, 0x0);
> -	} else {
> -		amdgpu_ring_write(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6));
> -		amdgpu_ring_write(ring, 0);
> -	}
> -
>   	amdgpu_ring_write(ring, PACKETJ(JRBC_DEC_EXTERNAL_REG_WRITE_ADDR,
>   		0, 0, PACKETJ_TYPE0));
>   	amdgpu_ring_write(ring, 0x1);
>   
> +	amdgpu_ring_write(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE6));
> +	amdgpu_ring_write(ring, 0);
> +
>   	amdgpu_ring_write(ring, PACKETJ(0, 0, 0, PACKETJ_TYPE7));
>   	amdgpu_ring_write(ring, 0);
>   }
> @@ -834,8 +828,8 @@ void jpeg_v4_0_3_dec_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
>   {
>   	uint32_t reg_offset;
>   
> -	/* For VF, only local offsets should be used */
> -	if (amdgpu_sriov_vf(ring->adev))
> +	/* Use normalized offsets if required */
> +	if (jpeg_v4_0_3_normalizn_reqd(ring->adev))
>   		reg = NORMALIZE_JPEG_REG_OFFSET(reg);
>   
>   	reg_offset = (reg << 2);
> @@ -881,8 +875,8 @@ void jpeg_v4_0_3_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint
>   {
>   	uint32_t reg_offset;
>   
> -	/* For VF, only local offsets should be used */
> -	if (amdgpu_sriov_vf(ring->adev))
> +	/* Use normalized offsets if required */
> +	if (jpeg_v4_0_3_normalizn_reqd(ring->adev))
>   		reg = NORMALIZE_JPEG_REG_OFFSET(reg);
>   
>   	reg_offset = (reg << 2);
