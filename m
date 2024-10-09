Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA56CED635
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 09:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 770B910E05E;
	Wed,  9 Oct 2024 09:13:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aa+jgtaw";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0120910E05E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 09:13:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVmaTlpf385X8z4Oilin1GOIXwMCsTTCYG1S+3XQ6ebSEcZ+KsNYoxzY++aGbmfDsr2qjzEx44rT2xdEbJNxjH+53cySQqrRJHrIWAZpEgUVWLAIYS8BSUrgtT6YKeOxTw9VZm4yroh1tjnID/Wz2fFyH5/7zbzK/2hHi0GwBCDwDqRqk8yutHCPJbrNsDiQQsnarq98bl75MwZm1c3KbviYYfBdP/1kHvplo2j6BAVHOvoErswSTjKnf70DyJTidfnaSa9txkXG7jsqSlBCSdfVJFMV2b+R0CCyJRgs6nmjSdCpcatnex+bSUV4zaHToxJMJADIFWkxTU1sPKniqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fv7IJJWZLOsPnlA98svunfoS+k1YypLoJ58ORwaQEo0=;
 b=aA953XWrjimpyhAzQwYTrcqzq+Z/hU3uAfzP/5IHMcUgG3VuwxzJF+ZN/ZN3aJFawKvz5apmJ/ZsGKbD4mUbXqDqxtKNMMXhKV66EYjYWhJXfLOIBO4H9Z+3hPtds/P8VQEKiEKCz4+IU/mX9Am4hfV0DEu4RVG1fQ1vdPnuhWKH2QUnJlDBkuaSnkl+HarBEbIJLt5SbRb+qT3hH/pqnn/eBpPsYM7VDF/GUF45xir4u/tDgLViKoAiSD7432H3nq5X3oSbOg1mrD63CUjX7BuCfQWTX2rIc1EaAN9G9JnFmF00F9DqKjrLBV4cfk65Wa0dABYRbMro1jf3Be2gsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fv7IJJWZLOsPnlA98svunfoS+k1YypLoJ58ORwaQEo0=;
 b=aa+jgtawRTIjDG/vlNhKSR604civQ+f5LDRZx1k1AP4GDShXA1fUrTuhG4v0GXyFcH4nWW8jKiMWL4LPpK5a1SnFnOG68ufq3J5w8vFfiOEyqIz4O6ka8amWpfT7/XkSlZI283wsf8YYqRyztAXGjFwrzbQWZQbuo/aP5KgdoOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 09:13:19 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 09:13:18 +0000
Message-ID: <754c08a4-6e0f-4633-aff0-572175108d5a@amd.com>
Date: Wed, 9 Oct 2024 14:43:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/amdgpu/sdma4.4.2: implement ring reset
 callback for sdma4.4.2
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241009072249.546857-1-jiadong.zhu@amd.com>
 <20241009072249.546857-3-jiadong.zhu@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241009072249.546857-3-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::30) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: b5dfe23a-4c78-453f-565c-08dce8429d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTZhV1RDbWlLdEd2V3duM012UEVnQnBKeXJ5ZjBtKy9abkdaWHBaZ1FabFVK?=
 =?utf-8?B?K2hSUExwQkRQbis3SFduSVp5K0VKY2R3YnV2WVZDVVRQZ2hKbVZtQXZaOU45?=
 =?utf-8?B?ek1KaGNFRjc3VUVIZmlxVWIvbkw3T1hDclB5NUxHazRwak1IcXorT2dYVi9U?=
 =?utf-8?B?eEwva04xTGczRTBQYzJ4T3JJdGpPVWExWjFScVRSdWpCcWVjUlBkWXcrZVJx?=
 =?utf-8?B?VlRROUFoWjFvdUIvbVdBRWkyaUo2VlZHdWdxYS9HZ1I2VWhydCt6MWRiNEVs?=
 =?utf-8?B?TlBZcUIxMjZ5bW5rTnVkWUQ1QWRnUXkrVmFKYkxTT3U2bmhyRUVkZC92ZUp2?=
 =?utf-8?B?Nzl0OHBnTVA5bFQ4MWxVOFJUOHRwWmJNbU1hSXlhQ0lEbjRrNXQ4c3NSRlZQ?=
 =?utf-8?B?MGh1Q2JNR3ZPeFU3cUFSc2FaV21xekN5VjE3djc1eTYrOXhhdzhjSldLRzlO?=
 =?utf-8?B?RWI1WWt0RGlTQjk3WVIwYXNuL2ZCZElXbTVpMDEzam5yOXhxWVE4SGxBVklq?=
 =?utf-8?B?dXd2MTFoYXBwdkhHT29yem5EcmV6S1Y4cS9uTzF3ekl1akpsMjhYQ20rc2V1?=
 =?utf-8?B?cHBMZlB4SXc2dVBueDN2djN3T2tvSEtaUkxMMUpaRmxWZ2xiSTg0UWtWK01B?=
 =?utf-8?B?cmJKZG5CR1VFY2oycTNzQXhzVFJncDNLOGVtUG9YVzFDOGZKOFdNVmxOTk1i?=
 =?utf-8?B?MTlKYml5MVFsOHp3WHZGSTFVanQrVVRlZGhET2dVcFVuSmFYL21zbWhqYWpH?=
 =?utf-8?B?Y1NlNWNDaTJ1eUU2SmZMZ0NROSsveE00dXdBSW5WdDBnbmRTLzVqbUorY2xp?=
 =?utf-8?B?Rk1jTklFWTlWc2VhRmhMckFsdmt4Z04rOEFEZzdOWGQxNVR2WGQxZFhDaU1n?=
 =?utf-8?B?UGN5MDUvT0MvVXVzNE1NTjBucVVFQ1pTckUyVk4rMDMveVltTG81dnp1akNB?=
 =?utf-8?B?QTNRRmpuN1dIQ0xiemVWYnJJU1BjcnF3UTEvcG93aU42blBOQUJaMHh0NEhi?=
 =?utf-8?B?MTNncHU1LzdOYkUrVVdIelE4VmZQcUJmWmJ0UlRiamw2Y3pVVmtYRW9wMGJw?=
 =?utf-8?B?Y0UyaWRpNUJpUmxWRzd1MTFCM1BrWmwzSGJtdUJqbVU3aWtOdjhSK2hSWVlT?=
 =?utf-8?B?dk5kTHpjRk1HTTRhbmh3UTUyb2FIUGx5ekpwMS9UbUJQQXVaelhyT3RxYlA4?=
 =?utf-8?B?VXRRVHBaNFZoRjdZN21MZUpKb1E3V2pzRnlNWWR1ZVNsY3EzcDB0NHUwSTRY?=
 =?utf-8?B?SW1yQWxQd2RXMVhCY29FdUwrWFIrQk5TSmNOZ0NVOHJuK2JCckV1cGlsVzVr?=
 =?utf-8?B?eEt1YzRuZkRiR3hOUDFPSmdpczY0bExrbCsveEthYjh3bGNkdUFlclQrMlV1?=
 =?utf-8?B?R0R6NFBSbkRFNFlUQ3dVNnBEdDNHc0ZCMlFETnBBK0Y0R1hnQVV0UjZUYS9N?=
 =?utf-8?B?VVlJOGlvTks3SEVtK2I5UzJ3ZTlLalZob0c5MGxNeXBDRFZkT0I5K1FXeDhG?=
 =?utf-8?B?YzJNMnloSkVzbDVjK1NPbklTNGg0YTlnb1RyT3JRTUdnR2JndDJuVGMxcDNF?=
 =?utf-8?B?eVBKcXFNNCtXRllDUnlRUkt5V01tUmV2TWxQYUNaaTBxNXhvbk5mUlczd0lN?=
 =?utf-8?B?dUFYK3BEc0k4SU8xL0h5RWtoWTV6RTZHeXd1WkhSVkxGbzlEQS84bDhhWjZB?=
 =?utf-8?B?b0JmTWVVV29FRFhic3pyNmIwT3ZZbGFEWnZIRVMwNVFJYkV3T3hGWHd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGZuMkhqOE5VNE9GVEZWZy9SQWlEODB1QWo5ZUpQblBOM0VTU3FxdklmS1M5?=
 =?utf-8?B?dmpZRmlRS29yNFZkR1BNWVBCWUhwS2lsS3FlZzcvT2FDb2V6Y29lay8vbXlv?=
 =?utf-8?B?ZlFuNG9aOHhOaXUrcG40Z0FZQVpOYU5nMEtPQTNaSkVjWEoxdngzVTlxdDB6?=
 =?utf-8?B?c2ZRM2dBemc0NDJzdVcwTGprRUdjUDd3cCtDbkcrZFhFSjhycE9nMzdKRDdz?=
 =?utf-8?B?RDRUQzVkVjBSc2xoS1puZjMySkp4dE93MklyVmV2OU1xRkY0ejgrUWF4cXZq?=
 =?utf-8?B?WnR0Z09VT2NXMDN4dTkvWGpJaDNDdVc3L0RrcGxRd0NBREhZODlCQ0k4bDd1?=
 =?utf-8?B?QlVTV2k2ZFkva2tQLytkK085bkVhTmJnSXRPWjRxMkM1WXhsbW1YRTdoWnpI?=
 =?utf-8?B?STRVb3FKU3dPU2NsQXcvWThIaWtYT3pmZWxkVzJrMjlLU0hoNG9oZVhrdG5M?=
 =?utf-8?B?aTZWY3FGd285aUZDazZlbzRxemZYK0RSQXhGemxTNnBZSmlFRnVDWmJiRlN4?=
 =?utf-8?B?NFd3T0k2Tm9Lb0NQWlB3a2NCNFhLdjBrdS9tNU83cVpkZXVmNmNBeTc3bmgy?=
 =?utf-8?B?cFhYQ255cFJGcmhxRkp4dG1Sc01KbytycVRZUE9GaFRuZmRBWUVVanhpK043?=
 =?utf-8?B?M3dtbEZqV3MxRjNsTXlFeGphUWx0Njdxc1BwTVlkYS9xS2tTYlRWUFFQc01K?=
 =?utf-8?B?WkNPTWc1TVBjZmIzTDdMSkJHaExJNG1Bb20yVVJZd2pINVBmTTA5N1N3NVpV?=
 =?utf-8?B?NFltbmhJUFRVZEZydXNZNVRoNkUzWnkwY1BXWGd5NkpmNmd3a2JoVWswMVkx?=
 =?utf-8?B?M2xpc2s3ck5XNUQ0clgrOXpPd3RpaEVYQkFXS2ExaUtVT1E4QXN5MVdBYUsv?=
 =?utf-8?B?bEdDaE93UXF6OUc4ODRpVEtjdmgvZDl3dkI1T081cTdJTlJHemtnQkVOOFZF?=
 =?utf-8?B?QlFweTM5azE3WkM5ajdjK01kVUxTYXJiQ1JsQ1ZkSXdrSWtBMHYyNE1HT0lV?=
 =?utf-8?B?ditDdFFnVnFjeTBhSzlCcy9vZTBmM2Z6T3M3Qlk3QkMxd1FkSEFFRE9zVHYz?=
 =?utf-8?B?RkZlek1DczVsYjVvbDI5Uys2eHFNM0l5d1hkcHppSHdhR1l1dW1qYWo0TDNY?=
 =?utf-8?B?bUxlV3pIVHh4UXhWWmRRWVdYeS90V1VMTGdSTi9lZFVMUDBUSmxuTmExMWx1?=
 =?utf-8?B?Vkg0SHJ4aU03RUMxWUQxWjRVakg1c0lNVUQyS3hHSTRrK3dQUVhoVDRaRnhF?=
 =?utf-8?B?T0VBYjc5MDh2TVN5TUxwYXIzV0ttZHJ4T1JnelhibVYraTBRbXd1Rlozd0du?=
 =?utf-8?B?K3V5U1FhdlVrbjI3ek1pdXYxL0RaeWpJSUFtdCtPRk5hV0tFZmN3MFZIYzVm?=
 =?utf-8?B?Z2dZNWh4T3hKOWNGVUpTR2tUeWFTQXdESCtYOHkxbkFZaEZSQUJnRVg2NGNF?=
 =?utf-8?B?WWlRQkM4UDFFbldqVHk2YytTeHlEOWNtdjVtYmxQYU5PQmVhcGs2UjlMazNP?=
 =?utf-8?B?VlZKN3BJUThaZE9iR0tKb1NMNUZaVUIra3ZNdHpIN3ljTFZCeGxvWThRcTlm?=
 =?utf-8?B?UUI3cUZDeFcyNy8yVXk4RWRxbFk3RmtQNHk1enZTMU5GanJ4S3JtWlF3QXpT?=
 =?utf-8?B?VG00VVh6bi9uUmRzL2kwR2lKOFBIRTNYSlI4bzA1d0pQK1d3Y2wyZUkrcHpl?=
 =?utf-8?B?QXJ2WUxYYUtDUXF1WVI0UXdsb1EzVU1FYndyWElLTnozUi9JZWNITERpTUlW?=
 =?utf-8?B?ZDRxSVdXb3RJK1lVNzl6b0lrWmgyVGJ3S0tnMjhFamViQ05KM0xTVjJubWMx?=
 =?utf-8?B?eTJNTXZ4dERBQmJZMUZjY2JyenNtVlVUZ282YTcrekJvbU1MeDFiaWs2a2Yy?=
 =?utf-8?B?bTQ4QjV2V3IyZFhBQkRWZldXRjEvd1FlV1ZsRHZQMWF6TEp6RkVVeFdSM0Jv?=
 =?utf-8?B?TnNIaFlEdEZTL2p1TStSRXFIMWJ2ZXFkRzBqRlNMdGJEdGpzeGJnam9YOGN1?=
 =?utf-8?B?SFNmZGxNMjEwdHhOd3B6NXFDam9nK0NZd2dCYURyc1RVV3FzWXRBdzVEZTlB?=
 =?utf-8?B?eUV0aWxzdWV6ZC9sbi9ZRVpybUJUeGxYblYzaFJtMml3R3hSaEl6Z25FSm4r?=
 =?utf-8?Q?8sVN/Dc11p39N87xI9OnUV3VD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5dfe23a-4c78-453f-565c-08dce8429d67
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 09:13:18.9344 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08EgcgV6MqUI2HAI9enpwqCo9VSMKmnDiLrwioYkq+/rf82R6mZcvj3yfXd4QhJM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127
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



On 10/9/2024 12:52 PM, jiadong.zhu@amd.com wrote:
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
> 
> Implement sdma queue reset callback via SMU interface.
> 
> v2: Leverage inst_stop/start functions in reset sequence.
>     Use GET_INST for physical SDMA instance.
>     Disable apu for sdma reset.
> v3: Rephrase error prints.
> 
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 97 +++++++++++++++++++-----
>  1 file changed, 79 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index c77889040760..9a970a3cb908 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -667,11 +667,12 @@ static uint32_t sdma_v4_4_2_rb_cntl(struct amdgpu_ring *ring, uint32_t rb_cntl)
>   *
>   * @adev: amdgpu_device pointer
>   * @i: instance to resume
> + * @restore: used to restore wptr when restart
>   *
>   * Set up the gfx DMA ring buffers and enable them.
>   * Returns 0 for success, error for failure.
>   */
> -static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
> +static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i, bool restore)
>  {
>  	struct amdgpu_ring *ring = &adev->sdma.instance[i].ring;
>  	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
> @@ -698,16 +699,24 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
>  	WREG32_SDMA(i, regSDMA_GFX_RB_BASE, ring->gpu_addr >> 8);
>  	WREG32_SDMA(i, regSDMA_GFX_RB_BASE_HI, ring->gpu_addr >> 40);
>  
> -	ring->wptr = 0;
> +	if (!restore)
> +		ring->wptr = 0;
>  
>  	/* before programing wptr to a less value, need set minor_ptr_update first */
>  	WREG32_SDMA(i, regSDMA_GFX_MINOR_PTR_UPDATE, 1);
>  
>  	/* Initialize the ring buffer's read and write pointers */
> -	WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
> -	WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
> -	WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
> -	WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
> +	if (restore) {
> +		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
> +		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
> +		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
> +		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
> +	} else {
> +		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
> +		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
> +		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, 0);
> +		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, 0);
> +	}
>  
>  	doorbell = RREG32_SDMA(i, regSDMA_GFX_DOORBELL);
>  	doorbell_offset = RREG32_SDMA(i, regSDMA_GFX_DOORBELL_OFFSET);
> @@ -759,7 +768,7 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
>   * Set up the page DMA ring buffers and enable them.
>   * Returns 0 for success, error for failure.
>   */
> -static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i)
> +static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i, bool restore)
>  {
>  	struct amdgpu_ring *ring = &adev->sdma.instance[i].page;
>  	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
> @@ -775,10 +784,17 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i)
>  	WREG32_SDMA(i, regSDMA_PAGE_RB_CNTL, rb_cntl);
>  
>  	/* Initialize the ring buffer's read and write pointers */
> -	WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, 0);
> -	WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, 0);
> -	WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, 0);
> -	WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, 0);
> +	if (restore) {
> +		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->wptr << 2));
> +		WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring->wptr << 2));
> +		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->wptr << 2));
> +		WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring->wptr << 2));
> +	} else {
> +		WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, 0);
> +		WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, 0);
> +		WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, 0);
> +		WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, 0);
> +	}
>  
>  	/* set the wb address whether it's enabled or not */
>  	WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_ADDR_HI,
> @@ -792,7 +808,8 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i)
>  	WREG32_SDMA(i, regSDMA_PAGE_RB_BASE, ring->gpu_addr >> 8);
>  	WREG32_SDMA(i, regSDMA_PAGE_RB_BASE_HI, ring->gpu_addr >> 40);
>  
> -	ring->wptr = 0;
> +	if (!restore)
> +		ring->wptr = 0;
>  
>  	/* before programing wptr to a less value, need set minor_ptr_update first */
>  	WREG32_SDMA(i, regSDMA_PAGE_MINOR_PTR_UPDATE, 1);
> @@ -916,7 +933,7 @@ static int sdma_v4_4_2_inst_load_microcode(struct amdgpu_device *adev,
>   * Returns 0 for success, error for failure.
>   */
>  static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
> -				  uint32_t inst_mask)
> +				  uint32_t inst_mask, bool restore)
>  {
>  	struct amdgpu_ring *ring;
>  	uint32_t tmp_mask;
> @@ -927,7 +944,7 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
>  		sdma_v4_4_2_inst_enable(adev, false, inst_mask);
>  	} else {
>  		/* bypass sdma microcode loading on Gopher */
> -		if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP &&
> +		if (!restore && adev->firmware.load_type != AMDGPU_FW_LOAD_PSP &&
>  		    adev->sdma.instance[0].fw) {
>  			r = sdma_v4_4_2_inst_load_microcode(adev, inst_mask);
>  			if (r)
> @@ -946,9 +963,9 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
>  		uint32_t temp;
>  
>  		WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
> -		sdma_v4_4_2_gfx_resume(adev, i);
> +		sdma_v4_4_2_gfx_resume(adev, i, restore);
>  		if (adev->sdma.has_page_queue)
> -			sdma_v4_4_2_page_resume(adev, i);
> +			sdma_v4_4_2_page_resume(adev, i, restore);
>  
>  		/* set utc l1 enable flag always to 1 */
>  		temp = RREG32_SDMA(i, regSDMA_CNTL);
> @@ -1477,7 +1494,7 @@ static int sdma_v4_4_2_hw_init(void *handle)
>  	if (!amdgpu_sriov_vf(adev))
>  		sdma_v4_4_2_inst_init_golden_registers(adev, inst_mask);
>  
> -	r = sdma_v4_4_2_inst_start(adev, inst_mask);
> +	r = sdma_v4_4_2_inst_start(adev, inst_mask, false);
>  
>  	return r;
>  }
> @@ -1566,6 +1583,49 @@ static int sdma_v4_4_2_soft_reset(void *handle)
>  	return 0;
>  }
>  
> +static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	int i, r;
> +	u32 preempt, inst_mask;
> +
> +	if ((adev->flags & AMD_IS_APU) || amdgpu_sriov_vf(adev))
> +		return -EINVAL;
> +
> +	/* stop queue */
> +	inst_mask = 1 << ring->me;
> +	sdma_v4_4_2_inst_gfx_stop(adev, inst_mask);
> +	if (adev->sdma.has_page_queue)
> +		sdma_v4_4_2_inst_page_stop(adev, inst_mask);
> +
> +	/* soft reset SDMA_GFX_PREEMPT.IB_PREEMPT = 0*/
> +	preempt = RREG32_SDMA(ring->me, regSDMA_GFX_PREEMPT);
> +	preempt = REG_SET_FIELD(preempt, SDMA_GFX_PREEMPT, IB_PREEMPT, 0);
> +	WREG32_SDMA(ring->me, regSDMA_GFX_PREEMPT, preempt);

Confirming - should this be RB_PREEMPT?
> +
> +	r = amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0, ring->me));
> +	if (r) {
> +		dev_err(adev->dev, "SDMA%d reset failed\n", ring->me);

My earlier comment was if smu_v13_0_6_reset_sdma() fails, that will
result in this print in addition to the error log in
smu_v13_0_6_reset_sdma(). You may drop one of them.

Apart from that missed to ask one basic question - this looks more like
an SDMA engine reset rather than a SDMA queue reset (ex: only reset one
of the SDMA RLC queues). Is this intended as a queue reset?

Thanks,
Lijo

> +		return r;
> +	}
> +
> +	udelay(50);
> +
> +	for (i = 0; i < adev->usec_timeout; i++) {
> +		if (!REG_GET_FIELD(RREG32_SDMA(ring->me, regSDMA_F32_CNTL), SDMA_F32_CNTL, HALT))
> +			break;
> +		udelay(1);
> +	}
> +
> +	if (i == adev->usec_timeout) {
> +		dev_err(adev->dev, "timed out waiting for SDMA%d unhalt after reset\n",
> +			ring->me);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return sdma_v4_4_2_inst_start(adev, inst_mask, true);
> +}
> +
>  static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
>  					struct amdgpu_irq_src *source,
>  					unsigned type,
> @@ -1948,6 +2008,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
>  	.emit_wreg = sdma_v4_4_2_ring_emit_wreg,
>  	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
>  	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
> +	.reset = sdma_v4_4_2_reset_queue,
>  };
>  
>  static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
> @@ -2160,7 +2221,7 @@ static int sdma_v4_4_2_xcp_resume(void *handle, uint32_t inst_mask)
>  	if (!amdgpu_sriov_vf(adev))
>  		sdma_v4_4_2_inst_init_golden_registers(adev, inst_mask);
>  
> -	r = sdma_v4_4_2_inst_start(adev, inst_mask);
> +	r = sdma_v4_4_2_inst_start(adev, inst_mask, false);
>  
>  	return r;
>  }
