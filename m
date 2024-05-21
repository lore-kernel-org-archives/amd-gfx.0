Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C6EC25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 07:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 127DF10E257;
	Tue, 21 May 2024 07:48:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e06FrBem";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6091210E2A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 07:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkFRl8p3C4z0CsbsgkTePBgK/LsWRz9RI80GHTOwlZyhd0kkg5DzFZYUFB+7JiHaUw3Q3wpQqxxzrl+r0u4VJK2CoozWcZTCEZYeYVhVfMkWw3yDv4F8NaHdBMSPQCp+Gn/OEnhr1t79gJjfCUz/WC19MR4r1GTv/AEU+rSR0XXzWx+0WTmPF70AfD0VLP3sUSERDpXySQFm58T+sfC1YUWJX62IHU19JP56T0rU+pIc7NmMbPxjLLCfi5uayBAGcc2gjRl8YovzVzI7pLwJuMrqGomGZRozEh88wG/keqlt5t5Def7cFceVk0nw24OVqikBiejdh4+TxDMUJAl1iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLSWOz6DmactJuLt61Gy7g45ZTm3kpTEZRIIsZGW/xA=;
 b=P2wu4pCRYl4dVTM6nuRiNidaYKN970yKRUUJRQjDbXxNNct/dONez/D+UerMvK4ZopY3liuWe274aHJxPWWAkyVVUEwZ0oem2xeu9Xv8p9GTNJpgy1Cwxl+Ge5hgPIiN47Rro4kli8DlXH2Z7OlS/oqqSZ+Kuqfq1w96dVmCIv55+B1c794bRmG3zNspGkfGI5i4mJMVxWQ4/GyTlUetGWZiSgw26JLpeQlumBOR1ZZ7zrSE/9Hw9bx9LNk1pX82Zj4rCgYwtxTNYoRdGK8wwfiV23jVMACI6WjeZgEp3nNVe/8gHcbHeIlelclg34+ctkhMrRHLD3JkTlp2KqGYaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLSWOz6DmactJuLt61Gy7g45ZTm3kpTEZRIIsZGW/xA=;
 b=e06FrBemSHx61F3Q9MfIL7u4NyKqdDbT71ggPi6PkCE0oWSzs4Cxbq8WzrT5T4jaQFuV9KoyArKdy0MG0zCv4qU7XbphOBEF2uayNrOixO+RO7iBGIg4Xw2zAq9UqDreTyNd8KfjTM0KZXejxlwb2VJ8Ze5g9bQhqZQvul0qVVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 07:48:15 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 07:48:15 +0000
Message-ID: <95878814-7e4a-4331-91a1-fb0e51b9ceee@amd.com>
Date: Tue, 21 May 2024 13:18:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix snprintf usage in
 amdgpu_gfx_kiq_init_ring
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240521044331.3735728-1-srinivasan.shanmugam@amd.com>
 <20240521073707.3863887-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240521073707.3863887-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0220.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::18) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 655f46bc-0ba2-4fa2-98fc-08dc796a5f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnJCZ2dyNlh1eHlVRWh6SkJvWTJVbjUwem0yaFZpMTdlNGVqT0Q1ODlaQzRq?=
 =?utf-8?B?ODJGWVFMaVNTOGJUeW4wVFRjbTVuZnZOU2pxZ0ttOENyNlkxWHFWeUxGV2Vj?=
 =?utf-8?B?MmlyTTJHTkM0WU5lT3RWQnhCYjBRV2tVSlBoamZ1N0lKY0svZzdQK2R3WHZs?=
 =?utf-8?B?OXV4bzFqQTlRc3lrZmMwbmtGOVhlbTBmUHVrZG85eTJIbmdxeWxaWnVQbHlW?=
 =?utf-8?B?UTNZWUlXRXlBLzZtZVdOc2F6QXRHQXlWMUIyRjExdDJPaXZWODJkSEx6T215?=
 =?utf-8?B?M2lVdGlwSGVXUXFUckY2OGxCZEtaN2h0WXVtSWRWTVBvWHhySytzK0Q0T0tN?=
 =?utf-8?B?Tjg5SzZ3S0hJQ20yWkdGN00vNWFRNFNNRW5mekVTdmJudWR4MTIrSkNlNmg0?=
 =?utf-8?B?QTFxekRKdUVweS9Tdy9yYUw1UFlZQXZWOWtDcmZWak1GampPZXhzeVFCM3ZN?=
 =?utf-8?B?NnlSdFBWZmtRTWZlZEFGa2tnMVpDd0RPVDNQekdUSzZkL3ZGMkxGeU90MUF1?=
 =?utf-8?B?TjM3UzNmSVQyYWhhdVlWbHVnbVJmakIrWEFZSkJxSEoreTRwZW9TekQwNDA2?=
 =?utf-8?B?TGJvV2VnVlgrNmNLWGJjRUxRUjN2S1RUbXFRcmVGcmlBZ3lVSU16SFVJNEdT?=
 =?utf-8?B?L2NidFVhRDdBNFYvRStIVytzODJSWEVQbk50RCtyY2pWS2xHbkdTNTNtUmhW?=
 =?utf-8?B?dnRwNXREM0RseVg4elJoK1hIcjkyTkhGMG5ES3RueE5TQnBSamxzbEozSjVI?=
 =?utf-8?B?end0OUZIdEhWUDc3a296ZGFiTEhBNjdTc3RJRmwveWZXT1J1UzlWWTJMTjYz?=
 =?utf-8?B?c2phUDExdWxSMytqeFhkYUIwdm1OUlBSRHNJbFVPeXNJTmJTUUJCMXVzOWhv?=
 =?utf-8?B?M2lTTFZWMC92Rk9sQnV4bVJpVFFvMStscmpZWXhaSUdNK0NXSmZjek9Lb0Zw?=
 =?utf-8?B?ZVV1czVJNzRaZGg0MWFxODd4T255MENRVDVzeWY1UmJ5RndnVXNuU0ZNd05Q?=
 =?utf-8?B?SHhPUDZGeXN1ZWFKRkQwM3NRU0VoQmRpYUthRmQ5MjlJOGx2VzBqb09OMW5y?=
 =?utf-8?B?cHhWRno4SWtlN21UdUJyOG8vTjNMYW50VzZneXRIMlEwWlpPSUNvSCt5aW5t?=
 =?utf-8?B?N0VLSjF6L3d0SlFhVzhyT01GRFNWdXlweDF2aHA1WXg3eUZ1ZC9tdmxGOUdG?=
 =?utf-8?B?a05SMWlWTTRSRGd5Nld4THJsRXQvZ2hqdzBNZEdWM1V2M3IzVnRZckFCL1cw?=
 =?utf-8?B?bEdidGJmTkZQOGtCUTB3VWtLZ0g3UE0vRmJldTFTUXNIdm0yQUVCbVV5ZERt?=
 =?utf-8?B?cWZBMTlPaUsxaHZPS29RMStDRXBWT3JTMVVua1lXYytydHNGbGI4bE5ZVnhB?=
 =?utf-8?B?TXNQMjlORnJKK0c2OFRDZjE3clZLazlFc05iTndjSjdjVmhic0xZMW1nZ0Vl?=
 =?utf-8?B?d1h4NlRMb3QrSU00b213STZjd3pxMllCQ0Nhem9kSnJhelVhLy9YMWJhNlh5?=
 =?utf-8?B?TWphY1Z6WG9TMjR4R0RJY1pySDBNNksydFJ5YlIzakRJM2RjR1Rhd2dGK21K?=
 =?utf-8?B?dnYyRnpHZmcrOGoraUlTYTl4VGM1czZzRmJnVGlIZUhpUkdKNXJkZHBoVTlO?=
 =?utf-8?B?WU13dU5zLytiaUkweVFWZU45ZGd5L0JLWG1sKzBrUmJVY2cvZUwzand3Z0Q0?=
 =?utf-8?B?RWZjQXJYMC9nLzlvSXU4MEtYT0ozTFdia1VyNmV3cHZLYnNYd3RGOVh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjJXSFRVdUNmcjNwRkU0RFlTZ2RjczVacWhGdmZPK1A0MEphN2FoazF1c0E5?=
 =?utf-8?B?NXYwVUF1QitkQVZ6RWtoQ1NCOXhpc3pSbUFneUEvWmg4VWJLR3B3aFZNYWxt?=
 =?utf-8?B?YmlMVEpyemJ2T1kxY1F0R2lqY1BvTUpDM2xVcStFenRDOHgxeGJjT1YzZTh5?=
 =?utf-8?B?NVVlMms1dEl5aWtCdUk2bUxmK0JpaTdQekR0RVRBZ0hHRUVqSGdSbHo0dUgv?=
 =?utf-8?B?RlJSZFFlM2lRZjBBSnFySVV4TTQyRU1XRVNuLzM2cEVMNUNubFg5S01XRXdq?=
 =?utf-8?B?Sm5pYmFsU3VCZVNLYnJmVUU4bnZpNW01QlpPODVDT2ZqRUZSUGhDT0Raak80?=
 =?utf-8?B?RitUSEtLMnRFMDR0VTFrZ1NvaHpSNFhRRzRiZmMxcWZMZW91cTZyY3hlRWFR?=
 =?utf-8?B?NTAwZU54L0g1WmozYVJVYytwcnFTS2FlQkJXZ09TZ0NVV095R3Y4Zm92eUsr?=
 =?utf-8?B?YU0zbkY1TTlXbUVybXpDMU1XdGdLaW9GN3VWdmkxS3ZCbUVKeG5hOHBjVlVx?=
 =?utf-8?B?UzZGN3lVZUhXR3dWcVcwQnNnRXFOeEYrYlFvUVFPQXdxYkhmUm84ZDZRTnRO?=
 =?utf-8?B?OGQrL2owZnorc0VLVVh0UzRrbHF1bVAxNE5INUlSNVJISnEraGNIWkltM2tM?=
 =?utf-8?B?SFVnTEY2YmtQbzljWXN2S0czbVlxYkdrc1VnSkw3RFdCY3pYRGFpaTNJNTQ4?=
 =?utf-8?B?TWNVbXczbUE0aUNnY2MvZmJ1Qm53d2pOcG9lc0o0SGEranV1amZWcENLanA5?=
 =?utf-8?B?bnZ5N1Y1QnI0RFRyL1oyT3ZSWXRUWkk4YVZDSHExRXQzMHBCcUc0TEVjdFZI?=
 =?utf-8?B?U2V3NnpTYlFncGNKQ2J1R2U3L0prMzdzYnZ3MjM2MWJvVXFSSjZPbUFWSWNi?=
 =?utf-8?B?TzEycld3dnhDcHZvbDR0OCt4MmtDUThUV3dPMDllNVdUQlJCM2hOSVZuSWow?=
 =?utf-8?B?RXdOSVFORDVmSWdYaURsQTlwVVo0c3UwNTRmbGNmakc2VXRLWWo3ejRybldB?=
 =?utf-8?B?dkJTYXNyRjNHU24rOWNnY1hhdTMzMmd4Q2hNbmJxWDdnWGhpR1ZpNmpKT2hm?=
 =?utf-8?B?dU4vcWtCZDdFM2d4M2VPZTAxd3IyQkNLQTBkZ1RqcFQ0RnZJbU5Ic2h4bSs5?=
 =?utf-8?B?QmNlbk1mQTNMdE5MeTFWaDhjdlNYVmJXQ1JUYnNRSVpWWGpXQ3ZXc3dvVmZi?=
 =?utf-8?B?SkVyQXljcmFFVWw0eUxxS1ByRHdZUlJ0ZTVHMTE1dVorYjdMZVBDaGMrUzll?=
 =?utf-8?B?aW1ib3NFd2hoYXJZN1Y3NStjaGtCN2UvOVl2YTBRM2g0VVBCWlRVdzJSY0dZ?=
 =?utf-8?B?cnVhWmdSUzRsZ1lSTzZtVDQwb2RIN0FWaGhNcGtGTDJUelBnTWIwcElpMit6?=
 =?utf-8?B?QlFBK0xzT2pocHVBTXpIZ25TMnZHOExOcytZazczWUpma3QrWDdMWEFpK01X?=
 =?utf-8?B?S2w4UmVVb280UUM1NXN2azFuNytaT2FadnNPYkszZm9NNGpJNzVTaHI4bHV0?=
 =?utf-8?B?cVNFbVhkUElJRENNSC9PbjhGSlFkRU1jdSs3SmJlT2p1alIvT0tsVGIxaTBI?=
 =?utf-8?B?MnF4VUMvSzVrS1MwRTBsMlh3dHowdlVZenNFbDFrb0FPZmtJNXhiR1NEYkJO?=
 =?utf-8?B?U2QvY2F5M3V6YjFEV1IvbWhydTdPQS9hamZXeGh3aUIyQ1cwOGdDWWc5RC84?=
 =?utf-8?B?RXkyRGNWcHJQZEpaR3FNanBNY3ZkYzNWU05Ob1NVYkgrbXpXWDhOWnl6QTZL?=
 =?utf-8?B?OXJMaVVNaldvNkZtRWRKUEkwUUdDYi9scnNRK1R1SFhoSVJxTEJjbWttZk9t?=
 =?utf-8?B?MXdKb3I4ZXRTTFhCckcyT1ZjNkJMSEhMVElWSVNvQnB6K2o1c3ZFY2tRWHJi?=
 =?utf-8?B?YWh4R1ZzaS9NalFkNXZZck9yVldaakNhRjFxT28wL0FyY0xZMWJSRjJTdzQy?=
 =?utf-8?B?RHVneXYwdG9rNmtWanAybDdyRVdGUnYrazJtcGcxVWZpc0E3bTQ1WjJrWk5j?=
 =?utf-8?B?UzZFczY1UmQwNC8yRFppejl1R1dKT2FpVitpK1AxL3daNE9OOVFWZ3JNQU8x?=
 =?utf-8?B?SzFTY1ZNeTRFMzhxaFdjci9Ic1NMQ1V2RVZJaSttQkhBWTc2cFdvSlZ0NEpk?=
 =?utf-8?Q?tXjjQ5UdRA7Ic6O9cpqA4axQ8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655f46bc-0ba2-4fa2-98fc-08dc796a5f64
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 07:48:15.7511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4rYSKvKIS/01/ZfR5Ek6+U1BOcq0IGGnIwYbxdgmQFFpzqbuQB8i8xN2zQQ6SZ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991
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



On 5/21/2024 1:07 PM, Srinivasan Shanmugam wrote:
> This commit fixes a format truncation issue arosed by the snprintf
> function potentially writing more characters into the ring->name buffer
> than it can hold, in the amdgpu_gfx_kiq_init_ring function 
>   
> The issue occurred because the '%d' format specifier could write between
> 1 and 10 bytes into a region of size between 0 and 8, depending on the
> values of xcc_id, ring->me, ring->pipe, and ring->queue. The snprintf
> function could output between 12 and 41 bytes into a destination of size
> 16, leading to potential truncation.  
>   
> To resolve this, the snprintf line was modified to use the '%hhu' format
> specifier for ring->me, ring->pipe, and ring->queue. The '%hhu'
> specifier is used for unsigned char variables and ensures that these
> values are printed as unsigned decimal integers.
> 
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function ‘amdgpu_gfx_kiq_init_ring’:
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:332:61: warning: ‘%d’ directive output may be truncated writing between 1 and 10 bytes into a region of size between 0 and 8 [-Wformat-truncation=]
>   332 |         snprintf(ring->name, sizeof(ring->name), "kiq_%d.%d.%d.%d",
>       |                                                             ^~
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:332:50: note: directive argument in the range [0, 2147483647]
>   332 |         snprintf(ring->name, sizeof(ring->name), "kiq_%d.%d.%d.%d",
>       |                                                  ^~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:332:9: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 16
>   332 |         snprintf(ring->name, sizeof(ring->name), "kiq_%d.%d.%d.%d",
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   333 |                  xcc_id, ring->me, ring->pipe, ring->queue);
>       |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fixes: 345a36c4f1ba ("drm/amdgpu: prefer snprintf over sprintf")
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v2:
>  - Removed width specifiers %3, %1, typecasting of unsigned char,
>    s/hhd/hhu (Lijo)
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 9b7dc61c331d..0f14d4a11441 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -329,7 +329,7 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev, int xcc_id)
>  
>  	ring->eop_gpu_addr = kiq->eop_gpu_addr;
>  	ring->no_scheduler = true;
> -	snprintf(ring->name, sizeof(ring->name), "kiq_%d.%d.%d.%d",
> +	snprintf(ring->name, sizeof(ring->name), "kiq_%d.%hhu.%hhu.%hhu",
>  		 xcc_id, ring->me, ring->pipe, ring->queue);

Even for xcc_id, the value range expected is < 255. Anyway,

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

>  	r = amdgpu_ring_init(adev, ring, 1024, irq, AMDGPU_CP_KIQ_IRQ_DRIVER0,
>  			     AMDGPU_RING_PRIO_DEFAULT, NULL);
