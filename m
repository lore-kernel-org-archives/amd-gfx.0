Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E236C282C5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 22:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D354510ED5A;
	Fri, 28 Feb 2025 22:04:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pFwldGFo";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B5BE10ED5A
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 22:04:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9E8zhOALHolzYFdDCa0SnuQLgiOjUXgVX+A4InaiajqTdIBY73J/nv5RVtOpNa8ldWSDeN4GmXWlcAx62wb8bcUI1WtrmlXa1ee9eBwLRAI2axKS37XWb6KqKjmPPFZ5aiJdZNHVyXb+to85qSMOOuyTAGZQhppI/amQ8s03vR2xgIE6SFFOkI3GEB336GcHBJOdvV80oOpwaEj66gQPLMJytryR1Q0xoX+OCArhGNwDesFfpxhUgujh7J0QtchzKMl83tJAW8I2EZ/orm3JpF4XbuUxLW8pQK7Vj/Ac4lWNp5+4Fz9qWEaGQJVYf8NMp5gC+LmAX9VYBFo1hp+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UatPeWjHCke2fqU+R3fC5QhNNjTLa7xpUiB5K1bFsb8=;
 b=ZRBHDx13VBctacJzWTSpfFjKnEs62DU+5ePgZ3R6YHzX6FHDNN5wp5hdfwY8xpixH4F3uYZL6otqQNCZ+Ll2wVGcVrY2Atn8ou7nEXKOdXDouix7RdfYzk7cvNGaMR/ihCI2muLDYml8KczNELbDmPXyWXTPuT1PTi3HM9rdWAPhX2f+X9/Zinif1Gn08P4nWp5Tl0tHhSJRJf5fhXFVQLySpWJ/xkJvInWJ/7kocQ8fz4AQD7rEu8ecMlfGfPO0gG9gDQwr/c+/TLqVdPoGwqDbL+sZtyyNy/YjeqpyQJSEygiSZ6gS6K+T0BN+3lEyfHR4xiReXD3lkg9NmRqa6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UatPeWjHCke2fqU+R3fC5QhNNjTLa7xpUiB5K1bFsb8=;
 b=pFwldGForX89HSVB5hlOAJ89XpOG7xrt9FZ5uvZx+R/0O7/4ArGSgHSOEC6cQyYAZ2G8tj7fNuTPmX6dPuJpizSqBhO+sonuW3GO89vIycZk4Dx+DhRkK2eNF7my/N9Zp0ePhybVOXj1HDX3o7O77132+vj/3mAP1xAfvzh3In4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 22:04:27 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 22:04:27 +0000
Message-ID: <1fe8a50c-9030-47c5-ab60-12ef5e8f240e@amd.com>
Date: Fri, 28 Feb 2025 15:04:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] drm/amd/display: Avoid operating on copies of
 backlight caps
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250228185145.186319-1-mario.limonciello@amd.com>
 <20250228185145.186319-4-mario.limonciello@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250228185145.186319-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0189.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::12) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DM6PR12MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b109f7-cd91-4529-bf7b-08dd5843de85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ais4ay9EVG1XcjNjMTZPaEF4S29wS1RWOGg3cTA4Ylo5VmRoUlNXUENkaTlz?=
 =?utf-8?B?VHUyenR2TXpsdFFud3ZweWcyWjZ3YWplUEVhenM0c3pmUjBqdVdKbVJ1SEtW?=
 =?utf-8?B?UGVKVHdSaE9nb2Y1bUs0cW40aUZhUkljVkpaRXJCRmxYeHNWSDQ4WkM1a0pO?=
 =?utf-8?B?KzJTL0R4aGN5Z3ZRbGxkZlJjdjNWeW8rUDZLd2w5SURKM2ZNUnR0U1pERUZx?=
 =?utf-8?B?cHRyTUF5MWZZRkp6ZENFYjFUV2xzblhaYTdoN2N6eVg0MDlNY3B3TExnV3cz?=
 =?utf-8?B?U2p1L0hVNHhHNGJvTGJ3WVNRdldOQlNMYU55RG1jaHJiWitpc1J2N0JZZExX?=
 =?utf-8?B?YUo3U25xVHRtcDJnTXROcndJS09BRmtPdFcxUVNOcktzNzQvZWtvNW1QT2NU?=
 =?utf-8?B?TWFZNU43cmlER2lCUWJ0Wkd0NlQ1a3pJZGh5VlRvTG5DWm9RZC9WL2wweHV2?=
 =?utf-8?B?NGxSckt0WUNrUW1qbUdtcWlDSTlhM1ZqOEl6MUlCNU1mNGtNcVNGNHJEUkcw?=
 =?utf-8?B?em54bFJ5SU1vL0lnQkJBNG1DakZNWnY0aWptbGtkNXI1djVhYUJ6UUM4aE96?=
 =?utf-8?B?S3pON0grN2dmempIbnkwbjQ2dTJzMktBVGk5TEZkYkMyeFB4MmVXaVNkTVlY?=
 =?utf-8?B?RFNEcS95RXdadlpVZFd2ajFpY09ZeXRRVTZIL3VvMDIzS1N2ZFVoSHJEQnBK?=
 =?utf-8?B?UWhZWmpTNnBMY3ByWjZVUno0bXZTb2pmTnFNZ2tQYXIyYTJGeVRGNWgzenho?=
 =?utf-8?B?MkNWSWx1dmtxQWZnaXZ2SlpuQnNpL1FkSnI4NzZ0ZTVYQlR4dUpON2NEYXFp?=
 =?utf-8?B?QmNXbW5nelpDMlp5SWpUR3JSVVNvSUp1d05QMXd6YjV3NFRKTkRxOVdwS01x?=
 =?utf-8?B?S0ovSWtnaUNobjF1eXNHRmpobTZPaEQ0QkF2aWQrQThuM0g3clhkT1o3a002?=
 =?utf-8?B?dkNjMlFZVGduYks3UDNlUG1maUV0ZUUyallXSCswQytHNU9NSG1Cb2hBcWFv?=
 =?utf-8?B?TW01d3FXdjdteFhmQkF5LzR4THpqeGFEWXRzb1VGdTI0cGlRTnBSSWpYV29s?=
 =?utf-8?B?Qk5sV0tjV0xlR2xsSGRsWVZFSUpLeFdRVFJIbVJMT0d1cEMyNDFvellNOUUy?=
 =?utf-8?B?QXdiTjdTbHdkcnFIeGZ3bGMzUm5LK3kvWThVcVVvakVmbmVhSjdJaFVuUi9u?=
 =?utf-8?B?WDNYRkNNaVdWbDJicTAxeDFLT1o1dXpYTHA3MHNTZ1dkVTRFSVdsakd3NWY1?=
 =?utf-8?B?NmpLYVplTGFua2Y1RGQwWXhSMTd6TjdZc2hKTWp4N3FvaE0xYjJLSnBrb0Ra?=
 =?utf-8?B?YVVqeW5FQ0RDR2FmUnlteTNxVkJvbU9YN0VBOWtaRVB6YUZjOTJPdklvTUJV?=
 =?utf-8?B?ZnBxcVQyK25ocGo0V2wwditlRi9ld3lsanMzRmdFZjBMQ20wUlY1VnFSTnRF?=
 =?utf-8?B?TW56emJReHlieU9nRTAvKzhoQXRsMlFVUW81SFlMMWc3cHVVS2RtejE1K2Ev?=
 =?utf-8?B?aTFvQm5pVTArOEh3WUZKNm0vbDZGZXl2a3p1dDhiUWtIUENNUlp1cWYvTkNo?=
 =?utf-8?B?RmpwejNjck1QWGFadzBUQ3NhcU5ZMDh0Y011N3RrV0NJWUM4MFhZREg1SUJs?=
 =?utf-8?B?ZUZOeWtkQjhvRHkrQXZIRmUrTnRFODZ4SGJyV3UyWEE3TWxEL0oybjA2WGF4?=
 =?utf-8?B?NktPRGREVjlUQlJaTXNkbGlVWXFoY2o5S0dFeGZPQzcydlIzRmhUbmFQSHhk?=
 =?utf-8?B?SHZUWWJsd1pjTEZVVTBIMDUvUE1QSkJzK0E0d1NhUTVRWEFycWFkbHZaSkVI?=
 =?utf-8?B?YVExQUZOQkgvVXNRSmtYdjFTWHhKa0JwU3dWakR0L1d4R2hKMjByd3U4OGo3?=
 =?utf-8?Q?tR7xzTaos2WV1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjhlSmxwNVBzYng0bEhTQXB4eVZoWGhuUFZhdisxZkVsdXduVzFNWDhUVnA0?=
 =?utf-8?B?SWdBSHpNTFI1L1JCcXp0dW9SejlRQjBtUGE0REpINXJWa09kS0lRallzeU9F?=
 =?utf-8?B?bndqcGNVYnVVT0FGR3BWWnpxU3pUeXFFa1paTE9wQnl0aWFrWW16c2tiei9I?=
 =?utf-8?B?NmdQZjNMSjZSaWpYejJGTndISlNRS2tpdE5wUXQ5bVU4OEVVNWUrOFZMeXVU?=
 =?utf-8?B?TkRBSUhTRHpYZzM0SGtJdGxQdFRNYllnaDUva2xULytXeWJUR243UVlYamZ1?=
 =?utf-8?B?YUhRbE8rWHJTUlhqOXFLSWh3ZmVsS3UxSTVRMWdMQ1llUlVFa3l6ektNeEha?=
 =?utf-8?B?bDVxd3lqUkNOeHVhcThTVHlvQzJkdkhONkwzUTlmMlRZUEVYNGJLWmZhQUt2?=
 =?utf-8?B?a3J2bVhETmVuVnlKcXByYlJLYjlEQ0xmaCtab2JLa0pIcUNpQnlZVTFSamZX?=
 =?utf-8?B?SzB6UmhJUjF0OXRjNHJxWlY2MVBlQU0xQ3E1NTNlWU9Mc1JnOFpwaVk1Sm8z?=
 =?utf-8?B?TXIyQ2NjOFNUT1lySitTUHlvY2FMcmsrOEJBNW5hei9DVVpJSWR4U1RReVJQ?=
 =?utf-8?B?WWwvbERsMFQ0N3ZHdHhqQnlMU0JDY0FPTG8xTXh4d0xOS1gvd29FUG5mY00y?=
 =?utf-8?B?MVIxQUQrWFJMRDg2UDdjbmxnUWIxSHNzTUhIL09qdDFBYkhSQXFtdUZ6ODJK?=
 =?utf-8?B?Nk1vc0VCNnBiN2JlNTJlNGZpZGxhZXJNd2JrWFlHNlRmQlorMm84c2xwdTY0?=
 =?utf-8?B?ZDBqU0g3U3Q0NWdsV2ZvcGJKMlpKMHB4eEZ2SE5RdFVid1JjUjhzdTY3VFl3?=
 =?utf-8?B?MkwwY0YrVHRTcEtkSDU3MVZVNGZlc25SeFRnRGxJWmxuV3lmYmxDUFc5YXFm?=
 =?utf-8?B?M1RqL0Z1NHoySTZPdDFDa25iQW1mSEtscVltalJ3YkRaRHBBMVNDV0UwOFp6?=
 =?utf-8?B?YnlQZi9nRG4yVXUvMyt2Q3FMWUx5cnFCbW5KMC9lTXpORXhJbjhaWUNqdWl6?=
 =?utf-8?B?Nkk2ZnNLNnBZeUxFcUJrbWxVMzhDS1Z0U1FzbTFwaUZsd3ZCbWJtSzJZQ21p?=
 =?utf-8?B?NWorbDhBNThHdjFxTm9ZV2NHWllVQUNkV0dpTmZ2R1ZMWS80Nm55RTRhZnJi?=
 =?utf-8?B?dC9qRlpRNGlSZUUzN3VpVUVZL2YxZTdhSzQxU0FBdm8vUXRYN2hWaE1zdVNi?=
 =?utf-8?B?MmE1VWdUcUw2ZXJlbTVacks2NzIvaGpiR24vRGFGVy9tU2tDQy81S1h6S243?=
 =?utf-8?B?bit4a0ZxL21XSlJKZmlieDRhS294TnRBME1UdEt6RVF2b0FFYnRjdjF6eUw4?=
 =?utf-8?B?TklMSElCRzZYcGU1ay8vMmxXQmlhVWNDVkFOUHJMTGROb3FBdXAvbTFpT1NK?=
 =?utf-8?B?azBXS1lBbzNuZUdvTnMxM1ZYMS9tNGErazhabEJrbnA2cDJWaE1nbENGTUUv?=
 =?utf-8?B?MkpSRlY3UlFRRDBCM3FVR0h6eHFHMzdrc29xZ2hFTG91UFJiNVYvZFVNeWxl?=
 =?utf-8?B?WjlTNjRjSEpJT0J1N3ZPSE5XQ0FZSGhxemo5eW5WanhkVDkrQTMzRUVBK2hE?=
 =?utf-8?B?b2M0Y2NxcFFSa3VIanlSNHNwd3RjM1ByQXkveVYzWHQ0WXNIUTZadWhYZitq?=
 =?utf-8?B?WHRYSVZNbjRtMjRaYVFpN1k4TmFqT0V2M3UrZXZKMnZGalpESEo3OFJiMmEy?=
 =?utf-8?B?TTQwVm00MXFBUjhsait1cVJQZ2lMMVZTOEVEdm5SS0NwTXRNMDBHdWQrRTRW?=
 =?utf-8?B?VmlGVnJXTlhHMVRVNzcrK0hjYkFrdlZZQ3VrV1lqN2NyOWNpU2ZDZFVXQ21H?=
 =?utf-8?B?QXFhdHN3cWVpblZUbnQxYjc1ZkNYYmZHcmo5enhTcXBjS2MwQ2VKUUJsaENX?=
 =?utf-8?B?SVI0Ukt2dGxFK2pidFZIS0djWWhqRUNPQ0pyRkg0WVdNblpET2Zvd3dmWk9S?=
 =?utf-8?B?dUNiZzJjOGluaGtYSS9pNjE5RFhnQUZNbTd4T3prQkFvTk05SmRncWp0Z2pM?=
 =?utf-8?B?TjJ3TkwvMEg0a1E5SjRkOFlDNU05MnFBNlBxSEQvbkJMb3h1b05xU1dqYUdy?=
 =?utf-8?B?RnVXaXoxcnd6UURWRmRvT29WeWN0YTVHY2g2NFVnSE5WWFVEbjdsaWdtQUUy?=
 =?utf-8?Q?4uoahZR/O41fysijwvYDTJFD4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b109f7-cd91-4529-bf7b-08dd5843de85
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 22:04:27.7069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgzK8v5Rz4TYmKg4cUhvT7P/ulN6sBx3YzPqRBjJ6HV0I/iWpkPdeJjSKt6Sb0CMPcQ3Bdvpv5784JnFTLp5BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 2/28/25 11:51, Mario Limonciello wrote:
> Making a copy of the backlight caps structure between uses is unnecessary.
> Refer to pointers to the same structure when using it.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>   * Add fix for !CONFIG_ACPI
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 52 ++++++++-----------
>   1 file changed, 22 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index badd8fa2099c..61d626914590 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4700,48 +4700,40 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
>   static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
>   					    int bl_idx)
>   {
> -#if defined(CONFIG_ACPI)
> -	struct amdgpu_dm_backlight_caps caps;
> +	struct amdgpu_dm_backlight_caps *caps = &dm->backlight_caps[bl_idx];
>   
> -	memset(&caps, 0, sizeof(caps));
> -
> -	if (dm->backlight_caps[bl_idx].caps_valid)
> +	if (caps->caps_valid)
>   		return;
>   
> -	amdgpu_acpi_get_backlight_caps(&caps);
> +#if defined(CONFIG_ACPI)
> +	amdgpu_acpi_get_backlight_caps(caps);
>   
>   	/* validate the firmware value is sane */
> -	if (caps.caps_valid) {
> -		int spread = caps.max_input_signal - caps.min_input_signal;
> +	if (caps->caps_valid) {
> +		int spread = caps->max_input_signal - caps->min_input_signal;
>   
> -		if (caps.max_input_signal > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
> -		    caps.min_input_signal < 0 ||
> +		if (caps->max_input_signal > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
> +		    caps->min_input_signal < 0 ||
>   		    spread > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
>   		    spread < AMDGPU_DM_MIN_SPREAD) {
>   			DRM_DEBUG_KMS("DM: Invalid backlight caps: min=%d, max=%d\n",
> -				      caps.min_input_signal, caps.max_input_signal);
> -			caps.caps_valid = false;
> +				      caps->min_input_signal, caps->max_input_signal);
> +			caps->caps_valid = false;
>   		}
>   	}
>   
> -	if (caps.caps_valid) {
> -		dm->backlight_caps[bl_idx].caps_valid = true;
> -		if (caps.aux_support)
> -			return;
> -		dm->backlight_caps[bl_idx].min_input_signal = caps.min_input_signal;
> -		dm->backlight_caps[bl_idx].max_input_signal = caps.max_input_signal;
> -	} else {
> -		dm->backlight_caps[bl_idx].min_input_signal =
> -				AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
> -		dm->backlight_caps[bl_idx].max_input_signal =
> -				AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
> +	if (!caps->caps_valid) {
> +		caps->min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
> +		caps->max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
> +		caps->caps_valid = true;
>   	}
>   #else
> -	if (dm->backlight_caps[bl_idx].aux_support)
> +	if (caps->aux_support)
>   		return;
>   
> -	dm->backlight_caps[bl_idx].min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
> -	dm->backlight_caps[bl_idx].max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
> +	caps->min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
> +	caps->max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
> +	caps->caps_valid = true;
>   #endif
>   }
>   
> @@ -4795,19 +4787,19 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
>   					 int bl_idx,
>   					 u32 user_brightness)
>   {
> -	struct amdgpu_dm_backlight_caps caps;
> +	struct amdgpu_dm_backlight_caps *caps;
>   	struct dc_link *link;
>   	u32 brightness;
>   	bool rc, reallow_idle = false;
>   
>   	amdgpu_dm_update_backlight_caps(dm, bl_idx);
> -	caps = dm->backlight_caps[bl_idx];
> +	caps = &dm->backlight_caps[bl_idx];
>   
>   	dm->brightness[bl_idx] = user_brightness;
>   	/* update scratch register */
>   	if (bl_idx == 0)
>   		amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, dm->brightness[bl_idx]);
> -	brightness = convert_brightness_from_user(&caps, dm->brightness[bl_idx]);
> +	brightness = convert_brightness_from_user(caps, dm->brightness[bl_idx]);
>   	link = (struct dc_link *)dm->backlight_link[bl_idx];
>   
>   	/* Change brightness based on AUX property */
> @@ -4817,7 +4809,7 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
>   		reallow_idle = true;
>   	}
>   
> -	if (caps.aux_support) {
> +	if (caps->aux_support) {
>   		rc = dc_link_set_backlight_level_nits(link, true, brightness,
>   						      AUX_BL_DEFAULT_TRANSITION_TIME_MS);
>   		if (!rc)

