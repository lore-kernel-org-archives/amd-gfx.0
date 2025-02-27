Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC6AC19F32
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 15:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30B4810EB26;
	Thu, 27 Feb 2025 15:56:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2jYTXYL2";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB34010E396
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 15:56:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zo43uYwWm1Mtct7UXYezWD6uuR1DYRrBAP5lZFXL++MYrHo1zquZPjClwSvzCDVAtth7sEdHiBulDfUoSdZLTGIoeLKV9kBQ+H4PX7UWtWe7A4ewBiBUHusakevjnO6XSaLrnGtTi6gLCmxtsdk4a2NDuZ8ves6AAO5To658wtL/U79eizZJdA6gLwSOJG88fwEa9ezEVGK9nPuQHSTE1yyK5/Dltc5Tnt8Pw3tROLrMqQqza7D7IrG3nNvaiYJ7dPYAMmS4NaL3Zv20cIJZbDVMcZqag09mXhM3XIYn9gW06aD3z9S8TtC+ZuW6XXI7CmvseFeUQ1PgJv5K+pqKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6MH+ePfthcLfSK7FMlfIOBtnA8e1SfZD+zCWB/qvN8=;
 b=iNaMj7UenAWU8/iO/u1Z3jAUNV61ovx5bD98YqBggR3yQbhXLNZWmV8zhv1OuikjVcCnxgOjcRUY1JSD12kgYNkMXXUmCrvV3G9KAdGCp3ZY8+0lksQLYiUgqioBhglgb645D4DullGEIp2S64ZRf8oVTyJVDK55+zeTDpE70MAvfXScMlHZor6Gp9JfqvvGuX9A5Xb4i7oN4xEwgBAAcMNjvNKtEmmXPwHhWAcvN5gSoTaregK0QlTURI99WOpotV0gcBhw6aFYsMthtgJcKDXKU++ZTaTMthws4YSr0YbkDCIyG22rfK1y8dYqRp1DzPTcncw9C6FzmRmnrUA7AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6MH+ePfthcLfSK7FMlfIOBtnA8e1SfZD+zCWB/qvN8=;
 b=2jYTXYL2rrwY61XpG5vn2IweZhBK6av9NFKBMWO/mBf+TBlOMjseRMilXtCgmr5BV29AGfxZH0aUGYP9iXPaWfMCebCJSXTxncToynP4rPQr8REO31vIzbDfaKfd0Lpoeo6175SG+/C+e57blGR2sMoZrWh0rpfgnjEtgMUJcgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB6804.namprd12.prod.outlook.com (2603:10b6:303:20d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Thu, 27 Feb
 2025 15:56:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 15:56:25 +0000
Message-ID: <88bcde2c-19e0-429e-abea-5ed6e7cf2bdc@amd.com>
Date: Thu, 27 Feb 2025 16:56:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu/sdma_v4_4_2: update VM flush
 implementation for SDMA
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Lijo Lazar <lijo.lazar@amd.com>,
 Jiadong Zhu <Jiadong.Zhu@amd.com>
References: <20250227114755.444535-1-jesse.zhang@amd.com>
 <20250227114755.444535-3-jesse.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250227114755.444535-3-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0323.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef5cef8-5157-4bdc-b92f-08dd574749de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eW1na2pDbG9zWnZVQ2puMjVwais4ck5qcHZTbXFhYjVBWnl1MTF6SVJZVHh0?=
 =?utf-8?B?azlzdGNRSEV4eUwvTFMxbFhoakVDMWRnVHdDWjN6cUF2U25qNW5rVnBqR3d6?=
 =?utf-8?B?VlVIUlFQTW5nRzV5UGFyV2RYbEc3aG5aQkZGNzJnYUFMSGxWUEJHTzZIMUdi?=
 =?utf-8?B?YTVMTFBYcSt4Rzk2T0d6RXl5czlDQ1JraEJrc3NsemFaSXpncWJOclJvcE9R?=
 =?utf-8?B?NTAzb3JROVMvb1RwNTVIUlE5R2tZTFFUdk1KdTcvcnFpVWprUEJxdmdHRE1o?=
 =?utf-8?B?TUFBTTZDVTdkRmtyeDJ2aE5MdTlpTU1iTnNrbGZ6VEc3QWpNUkFGNUpqMzF0?=
 =?utf-8?B?N2todk8welVJNFlvWHN0TnBxRHphMlRtbkE1d0VyQW85VkNpdGsxWnk2dloz?=
 =?utf-8?B?RUpuU1A3eVUyK0JETFNpYnFiY2oyMjdqNlJjNnNYNk1rMWlod3RVRUF4REg2?=
 =?utf-8?B?WmltbStqbnR2Y3NxOWtEc1JwWUswa3A2QzltQjlqK1hlQXowdjBBQU1mZmdi?=
 =?utf-8?B?YzdwQ3ZwL0N5WThreFNBc2JJbkc3SkFOZUdpZm4xU2I5aU55RE0yTUVBU2lj?=
 =?utf-8?B?b2VvQnR5SjNRZFEvMXlNdWdWbWwzZGs4UnF0QkVvaTFYeUQrV1dMd0J3aUxt?=
 =?utf-8?B?T2p6emx1NHUxUVNsdG12NGhtV2VwRkR3eHJYT0hJT0JXd3RqM1lwVHIwVnBG?=
 =?utf-8?B?RkpsdlFSNlZRMjh1dTBKTkpBWVVWSktJY3V6b2VxN3VubC9meVVCa0RPcytl?=
 =?utf-8?B?aVNnUzB1MkhwZUlRSnRWWlVlRWgvT0NSUWVJdFVCcHNLamIvUjd6UkoxYkxi?=
 =?utf-8?B?Z0NvUDBxNlVkdjBmcFh5Tit3LzA0NllBTWVidjFBRldjUXRBVG9UcWR1Y2la?=
 =?utf-8?B?RUlmMW1ieEFod0w1dnV2YzUvV0JGVFJWWVArNU9acEM0RTBhUmpONnRiVGJ5?=
 =?utf-8?B?b0NoRUVKeDNTS2tTODU5M3F6N09jT1crN2dWek1xSndid3JBZ0NTWEtkOWY3?=
 =?utf-8?B?bEVkaFA1blZ6RmZJZE5hSDkvNFpwb0ZhWmVPeTFJaThiSC9FeHRFVFdNWXRh?=
 =?utf-8?B?MTRjMmhQMUZjVWhUaEM5UW5wR2l1U3djYkdja3BLcHEyWEVHRUlvMFIzd3A5?=
 =?utf-8?B?cDBTV2ZzWW5wRG1HRElBV2dMczh2NjIwWWNEVEt4TkpwQi9SMEZtUHRrT1Z4?=
 =?utf-8?B?ekhpRDRxYzhEZzgwVmU3bStxNGdkRTRsdjBpTU9uU1NOaXJMUWx2YmEyZ1cv?=
 =?utf-8?B?bkRVVEU3VUtZeHVuRWNKUTNBSjZQOU1zS0I5TDVRVjNBNGloRGwvZCtQYmdY?=
 =?utf-8?B?elowR1lYbmRJdHR2T3lGY0Fya3pWdkl6ejZGQWZaeFJramN0cGtlRnpRMkxv?=
 =?utf-8?B?TGRMZnZZbkRGcGNUNmJoeXI5dkV6ZnFqWDUrR2xCd3Z0NzZVYXRYN0VMUmZl?=
 =?utf-8?B?Ykgxc05UMDlUV3lhT1lFbTd1OU5wWnd6TGJ2NVljQ290MTRENi9FaDZuRVdQ?=
 =?utf-8?B?bHNVaFd0SENZRk5uL0NmTEdybUwzQlBOT29pNWlDSFpwOENxNkFPYk96bXd5?=
 =?utf-8?B?NGsxdmlhQWJ3WGNJWUxRd2VwU2pVd3YrKytvQkRiQmY0Y3NUVjFIRERRUS9l?=
 =?utf-8?B?SGtYc01hNWk4R3F3TWdnYytDM3hDNkVsb0MrbTEvYmZuS0tOU3pSZUVQN3du?=
 =?utf-8?B?V1V6Tm5VV3lERmFOTlhiQXpPVzhvanF1TjJpZTgvMFIwY0VuZ0ZWWjgzeEpM?=
 =?utf-8?B?NXRablhlTDV2d1d0UGVVeXFJUXdzTWRLN2U1cXJvMDNzRDRHTzFPeWNJNGNn?=
 =?utf-8?B?Q1BZaFhqUk1qOEZ5bmpiaTBzV3orT1VMdFhRZk5FK3NieWJHUDMwaGdLTVN5?=
 =?utf-8?Q?SeT1I6zjeaTjG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aytDNVhEYkpiNUlYV1pGeFVzNC9kRGJoTkR3eTlpRUx6Z2VZTVRGa0JqU0Na?=
 =?utf-8?B?ZHc4ZHhhM3FJWFIrRnRJRXRzRUxEZzNMeUNFbmRVUWs5b2ZUWlZIb0NpTUhM?=
 =?utf-8?B?cE41dVpWT3N0U0hRYVZueGc3cjZjY25lNjFhQ3d4UmFhZTJEU0EvRFR6WkVM?=
 =?utf-8?B?MmFqaml1SXZ2NjRRckRZZlBSVS9oWEZrdHVYSDM2Nk9aZ05FTkJSR0FHVDFV?=
 =?utf-8?B?bWNqdGQ4eFhwTGcybCtJTm1pc2w2UlN4YmFxTzBwZzZwSW9NYjMrYUtrYnlu?=
 =?utf-8?B?NHZhVUZTdHp2Z3huQ1hGWVZsWm1GVHhUSU56eEh4UHEwMzJ2R3pJQ3ZuSThF?=
 =?utf-8?B?a1FGWGpUU0Judk5vd1YyVGo1M2MramF3ajlwaUtSRTM1eFRwOFYxNGhudnIw?=
 =?utf-8?B?bUNhVUEwSmJwK1dyLzZwMWpIN3hndThMY2g3eFJYaWpwaFVqLy9zS3kwZ1VM?=
 =?utf-8?B?Zmpudi9PUVl6TGxFb1ZqdWY1S2plTnMyaVFCM1FqR3RnUzRmejd0RlRMbWN6?=
 =?utf-8?B?cTFEb2ppZTJyaTQrL1gyeG9hSlVaMGxHNE1GaUkxaGdDb25qMm00eERyZ2Iz?=
 =?utf-8?B?L2tUeGk1YTNXdWdxUjVVSW5RN3c0SzlwNTUzY2d6Q01SWEtDdE5pRUwxb0Z5?=
 =?utf-8?B?TGxjbkcya1ViTTFXaCtGL3pacjQ3bDluTU1qT29yN0hxVXBRUHVvTENrNnVX?=
 =?utf-8?B?Ymd3M0FUc055WElXaDl6STdPa0ZyR2ZyOXF5VW0ySmtxNG1VY1lmVjI2ZThu?=
 =?utf-8?B?UHJhVEdmdEtwMFJSd1BCN21LQVRzYlowQ25Lbm51eE5QWjQ5ZDBtNUZhUVpM?=
 =?utf-8?B?UGJGVWhJWFpzS1AvWS9Ua3pmQXVZSTBzS283c1ZBMW50dGY4OEN3OEdlS2hI?=
 =?utf-8?B?di9uOUZXQ1Z0Y0ppVDJNSHNnTGd5Q1pENjJ6SnVOUTRob3J4M1JpNXlEeUhG?=
 =?utf-8?B?OGZNejR5WEh2eVAzWHora1BmOGJ5L0kwd0JUaW00Nkdod0FsNWhzS0ptUHJZ?=
 =?utf-8?B?enFQY1RUd1NVdUJSR0ZHVjZxZmlJZnpQQmt5d0V6dXVNTFVOd3poMHZlcUtO?=
 =?utf-8?B?dFRYSEJUdEpZK2J4ZjVjOHdkNXdvcXRMbkRaVDhWa2lFSkZBUWg3MUdEL0N1?=
 =?utf-8?B?ZHdjVDFiTzVHVDhFc3NiU1VZdCtSa2dJbHU5R0dLUllOay94dmRJRkR3cUpa?=
 =?utf-8?B?djhwa3JGWG45S1RyS3NBcWUzeWdHaWFYVjE3U1R2NGRWU0dPT1hDaVlzQlpt?=
 =?utf-8?B?bi8zbmRjQndoN2dSRHRnZ0NNbFlFOXBCVUpMdHBDYUIwZnNjaWNMdlQvRWFL?=
 =?utf-8?B?QTlvYkpGcmppVFkxN0d6NXhrblcrbUV6MXFZTDkyUXkrUzg3Z0J3K014c3Z3?=
 =?utf-8?B?YzVlVnRUaHQrcS9TVnFiU2NWbVdTSk1zenFLNEVNdGp3aDZPemF1N080V3g0?=
 =?utf-8?B?bkwwZ2RCUy95TVFxQjl6eWdaVUp6R2N1NkVUdmVtSzZWdlk3NDJ3VERGT2pW?=
 =?utf-8?B?R1pMVzBxNlVJUUVDN2ZOY2pLdHROWkVhQ0R5d2JPUjhodkJXQ3pSTWtkbk1V?=
 =?utf-8?B?d0VKektlb2k0cmVjYURuVjNhdm9WUkZ1Uk8yS0FNbUp0UGJYZXdZeUtpMHYz?=
 =?utf-8?B?cGFGaVpEOExqV0gwd3ordVUvZ3cxeis0dkloV0JGVFVwT1dQN0lJUkdhN3kz?=
 =?utf-8?B?UlArU0dwUjV4WEoySytnMnNLNVNWYnVLTWdPTFRyeFJ0cndObkxTTmZjTEZZ?=
 =?utf-8?B?dkN3R0tWb09Vd202RHVmUDZ6NFV1Q0QxWVZ5Q1FsREIxMjYyMTdaYWlLZmZy?=
 =?utf-8?B?cmxONGErNVJ5WVVQenliTjlKSHVDYnhJKzdOSitxcktsMkIrUk1ybWs3bjQ1?=
 =?utf-8?B?cS9pdTJ3SzFIQmVDQ1hTbS9UMGlBbmFaM3gxTTMvQWxKTnduVE9tU1lScmVE?=
 =?utf-8?B?bHlhRmRrZmQvb1ZhbFh4eWcrTkdnWkFJeVNocnhBaFBRVVFweENNbk9PSndm?=
 =?utf-8?B?cldSZFhJbkM2NVFEQkVnWEg4aUl1aVh6eHF0ckd5WlhXZ3ozY3FTeGNrdnBP?=
 =?utf-8?B?Undvb01tQkNZZSsvVGlYOW5NdUlXN2VFc1lFVFRpTU9sOGhlam16bXFrMHB1?=
 =?utf-8?Q?aDLGSWsje4viuR4oplgKFXQlo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef5cef8-5157-4bdc-b92f-08dd574749de
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 15:56:25.2605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/kxvQanQzRNEpPjO/VwI2S4Stf2cr7+oXOfpkLC1WrdlKGxHDlMlpdAvqtMEYcX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6804
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

Am 27.02.25 um 12:47 schrieb Jesse.zhang@amd.com:
> This commit updates the VM flush implementation for the SDMA engine.
>
> - Added a new function `sdma_v4_4_2_get_invalidate_req` to construct the VM_INVALIDATE_ENG0_REQ
>   register value for the specified VMID and flush type. This function ensures that all relevant
>   page table cache levels (L1 PTEs, L2 PTEs, and L2 PDEs) are invalidated.
>
> - Modified the `sdma_v4_4_2_ring_emit_vm_flush` function to use the new `sdma_v4_4_2_get_invalidate_req`
>   function. The updated function emits the necessary register writes and waits to perform a VM flush
>   for the specified VMID. It updates the PTB address registers and issues a VM invalidation request
>   using the specified VM invalidation engine.
>
> - Included the necessary header file `gc/gc_9_0_sh_mask.h` to provide access to the required register
>   definitions.
>
> v2: vm flush by the vm inalidation packet (Lijo)
>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 81 ++++++++++++++++++++----
>  1 file changed, 67 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index ba43c8f46f45..a9e46a4ed7a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -31,6 +31,7 @@
>  #include "amdgpu_ucode.h"
>  #include "amdgpu_trace.h"
>  #include "amdgpu_reset.h"
> +#include "gc/gc_9_0_sh_mask.h"
>  
>  #include "sdma/sdma_4_4_2_offset.h"
>  #include "sdma/sdma_4_4_2_sh_mask.h"
> @@ -1292,21 +1293,75 @@ static void sdma_v4_4_2_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
>  			       seq, 0xffffffff, 4);
>  }
>  
> -
> -/**
> - * sdma_v4_4_2_ring_emit_vm_flush - vm flush using sDMA
> +/*
> + * sdma_v4_4_2_get_invalidate_req - Construct the VM_INVALIDATE_ENG0_REQ register value
> + * @vmid: The VMID to invalidate
> + * @flush_type: The type of flush (0 = legacy, 1 = lightweight, 2 = heavyweight)
>   *
> - * @ring: amdgpu_ring pointer
> - * @vmid: vmid number to use
> - * @pd_addr: address
> + * This function constructs the VM_INVALIDATE_ENG0_REQ register value for the specified VMID
> + * and flush type. It ensures that all relevant page table cache levels (L1 PTEs, L2 PTEs, and
> + * L2 PDEs) are invalidated.
> + */
> +static uint32_t sdma_v4_4_2_get_invalidate_req(unsigned int vmid,
> +					uint32_t flush_type)
> +{
> +	u32 req = 0;
> +
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
> +			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
> +	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
> +			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
> +
> +	return req;
> +}
> +/* The vm validate packet is only available for GC9.4.3/GC9.4.4/GC9.5.0 */
> +#define SDMA_OP_VM_INVALIDATE 0x8
> +#define SDMA_SUBOP_VM_INVALIDATE 0x4

That needs to be in a header.

> +
> +/*
> + * sdma_v4_4_2_ring_emit_vm_flush - Emit VM flush commands for SDMA
> + * @ring: The SDMA ring
> + * @vmid: The VMID to flush
> + * @pd_addr: The page directory address
>   *
> - * Update the page table base and flush the VM TLB
> - * using sDMA.
> + * This function emits the necessary register writes and waits to perform a VM flush for the
> + * specified VMID. It updates the PTB address registers and issues a VM invalidation request
> + * using the specified VM invalidation engine.
>   */
>  static void sdma_v4_4_2_ring_emit_vm_flush(struct amdgpu_ring *ring,
> -					 unsigned vmid, uint64_t pd_addr)
> +					    unsigned int vmid, uint64_t pd_addr)
>  {
> -	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
> +	struct amdgpu_device *adev = ring->adev;
> +	uint32_t req = sdma_v4_4_2_get_invalidate_req(vmid, 0);
> +	unsigned int eng = ring->vm_inv_eng;
> +	struct amdgpu_vmhub *hub = &adev->vmhub[ring->vm_hub];
> +

> +	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
> +                              (hub->ctx_addr_distance * vmid),
> +                              lower_32_bits(pd_addr));
> +
> +        amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
> +                              (hub->ctx_addr_distance * vmid),
> +                              upper_32_bits(pd_addr));

That is unecessary.

> +	/*
> +	 * Construct and emit the VM invalidation packet:
> +	 * DW0: OP, Sub OP, Engine IDs (XCC0, XCC1, MMHUB)
> +	 * DW1: Invalidation request
> +	 * DW2: Lower 32 bits of page directory address
> +	 * DW3: Upper 32 bits of page directory address and INVALIDATEACK

How are upper bits and invalidateack mixed together here?

> +	 */
> +	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_VM_INVALIDATE) |
> +			       SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_VM_INVALIDATE) |
> +				(0x1f << 16) | (0x1f << 21) | (eng << 26));

What does those magic numbers mean?

> +	amdgpu_ring_write(ring, req);
> +	amdgpu_ring_write(ring, 0x0);
> +	amdgpu_ring_write(ring, (0x1 << vmid));

Either drop the () and the 0x or even better use the bit macro.

And it looks like you completely missed the upper and lower bits of the page directory.

Christian.

>  }
>  
>  static void sdma_v4_4_2_ring_emit_wreg(struct amdgpu_ring *ring,
> @@ -2112,8 +2167,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
>  		3 + /* hdp invalidate */
>  		6 + /* sdma_v4_4_2_ring_emit_pipeline_sync */
>  		/* sdma_v4_4_2_ring_emit_vm_flush */
> -		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
> -		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6 +
> +		4 + 2 * 3 +
>  		10 + 10 + 10, /* sdma_v4_4_2_ring_emit_fence x3 for user fence, vm fence */
>  	.emit_ib_size = 7 + 6, /* sdma_v4_4_2_ring_emit_ib */
>  	.emit_ib = sdma_v4_4_2_ring_emit_ib,
> @@ -2145,8 +2199,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs = {
>  		3 + /* hdp invalidate */
>  		6 + /* sdma_v4_4_2_ring_emit_pipeline_sync */
>  		/* sdma_v4_4_2_ring_emit_vm_flush */
> -		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
> -		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6 +
> +		4 + 2 * 3 +
>  		10 + 10 + 10, /* sdma_v4_4_2_ring_emit_fence x3 for user fence, vm fence */
>  	.emit_ib_size = 7 + 6, /* sdma_v4_4_2_ring_emit_ib */
> + 	.emit_ib = sdma_v4_4_2_ring_emit_ib,

