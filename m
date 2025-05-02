Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C88CC3ABA9
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 08:05:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F15DD10E170;
	Fri,  2 May 2025 08:05:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mupwRnXE";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00DB910E170
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 08:05:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIEl5csExNsHpNnHZmFGYuvCt9HmdyXAfRY/qYK0HvTgpAPGCXf2dt/j31MfDQ5AY+PQQ4bbeSOPPEe/BKzzrnXlH5HvEkKLu9AaPokeevHu6VVzNuqtR3DTL53zwfgAxkpK2wIWgFmUaKyn6QPo/LJS8TEC3uq+YnWLxevCd3bIZovLrhpvsCwOv2069pxGB2xx9Ehy2yDGaQ1DChpq7GQna7c8/bP0Q4Sh1QPoNWKzPbGFsq88xiQ9DdfK5NJB39Ibu5IGdrKRlXi9gs4Ga5OvOcw3VuFg/xYkEaCD1elE8depf2shMsJj+SbAsnmQtEOrk1NTN6hN1p2oSONpSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jf9opEL9Z/1hkfEP1ORTHj8U+VT8C+EHTVSIOrAYlDs=;
 b=hNY8oygTdKT/VMuPtJH5uwtGz+jyXp/36J0r90dkVej+LuWMbGLZB0F22M/IjG78+8znYzgnV0b/NNwiuIl1HDs7qDE0w+F72D8zZCe1YsVpKWQmrSd6daJUNwt52dshWg4M/zheWk71Lp1tMcIGpIOlQlqJ1GF0B9FDdOP9Oc3TQ1ldjJmCPUuK+PzDzIgiiaIwuT81kx/cEMUKi9PrqdcAUC0uuFk3OQe48EBaGS3UoJ3N0Px/kJ7LW4/8SUiNpVu0fhL6skMpY0qKipfOOrC+A9SwrG93+KJemDxgwMTFDXUuZc+x88vjwhfEjGKKmX8wSqgGCs8soMc7nnenQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jf9opEL9Z/1hkfEP1ORTHj8U+VT8C+EHTVSIOrAYlDs=;
 b=mupwRnXEEiTIRI+qIQ8crN2R5kM6Ai5t/79DB7Q8AiVqvNddCJbbCZ1nQqmapiKf1sDhd4C4XUVYXKWMWagvmwhFwcwAY9CggFXbzWEYmOfY834TNE1/oXeH6A6aL2GG5vQ/l88MHNoIBgLSKJYoipS/yzXS1NnbMvIHT4CtHGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH0PR12MB8551.namprd12.prod.outlook.com (2603:10b6:610:186::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 08:05:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Fri, 2 May 2025
 08:05:32 +0000
Message-ID: <d3d4aa68-109a-476e-b0aa-c7fc28b25bd3@amd.com>
Date: Fri, 2 May 2025 10:05:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm/amdgpu: only keep most recent fence for each
 context
To: Arvind Yadav <Arvind.Yadav@amd.com>, alexander.deucher@amd.com,
 sunil.khatri@amd.com, Arunpravin.PaneerSelvam@amd.com
Cc: amd-gfx@lists.freedesktop.org
References: <20250430160521.35670-1-Arvind.Yadav@amd.com>
 <20250430160521.35670-2-Arvind.Yadav@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250430160521.35670-2-Arvind.Yadav@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0334.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH0PR12MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d392db-1376-45ed-bf2e-08dd89501c4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHF0bmhpNlRHSXF0d3FZM1NOb2lWbzVKTjFRM1IreHVhVU5RNHMvOFQvZGo3?=
 =?utf-8?B?aFRrYURyK082ajBkWnpXQUFIR1Q4SmhYMVBmVlg4L2orNGQzaTNjQzZGWWpo?=
 =?utf-8?B?TWdscjRZc0doYU1LaHF0ditSYTIyaGUyOG9ITUJ2MllFVGNSeVA4VlkvdHpw?=
 =?utf-8?B?R0k2U0JXN2FIY0ZyYVI2VGFMS2EvV0M0OEh2YVltM0k0SXpQL3I1Y2N0YVpX?=
 =?utf-8?B?eXkyYkZYNE9KU3VRMWNQOHN6KzFpWk1CRlJmcHhIUGlEdVM3ZFVYejE1TElY?=
 =?utf-8?B?c2x5WGRCU0hBMkZxWStVa0x0VEFYS1h6dEo4Tm51TmpsdC84L3VYSTdaQ01X?=
 =?utf-8?B?a09FaXUxV0hxODMzUGoyRUgvTHUzK1ZTZHNQb2hGTzloa3FtMWV3SENaZmxU?=
 =?utf-8?B?WXRqV3hBZzB0ZnAvQUZFNk85Q3cwWjFQcU9seW8zeDh2QXN3TnVDaTZzSVEw?=
 =?utf-8?B?dlJlQzgzWEJ6RURKV3Z6QUxNS2V2ellSbk1takdBbm80Zm5oYUxJU0dUL25i?=
 =?utf-8?B?cGdEdEE4OTdoTFVMblBMWll5bHBhWS9vNE5KVnNnckhjZnRYcjM4enJDOTFH?=
 =?utf-8?B?OEhTRTRKb1p1dnRsL3d2aDl0b1dvUTM3WU9NODdrOTBMMFB4aTVlWkJ1bm1l?=
 =?utf-8?B?bFRLblBFNU1ybkxqV1F3RFQ2RkozVllJanQwUXNTUTFKU2VtVFMvOHFCaEk4?=
 =?utf-8?B?NEdHbHNCWmNHMnlOamY5S01jejJ1NEExTGRLQ3ZodDliU1JDSVlySHhaWEtF?=
 =?utf-8?B?ZWdIeVRMTzJiaE92Um9JQUxlb0FkVXZUT0c1UFZOazByeDF6Z1pFVUo4c01m?=
 =?utf-8?B?emk4WkU1U0hqekl0MSt3L1k5OVdQbHIrVXFuemh1MHhtTjFRN0lCQ2dUd09m?=
 =?utf-8?B?cFdvdlpUbWRYWmhEZTQ5cHdnbkNDeDZvdVQrUXJwU3JodDYwZHVkTko1RmpN?=
 =?utf-8?B?dlk5dmlvN3NRVkMrTFRoNi9wVXhHbEtibjEweEJIRm9BazBTUmY1YUI5WVAz?=
 =?utf-8?B?c1RjNHdFNk5KdkJkN0dMVGZHMTcyaVZ2VlFWK1lzMjdCYW9zNCtTSDRVWHBn?=
 =?utf-8?B?Z1UvT0RsV28zNzExM0VMbzF1TnNjb1ZYTHZmcHdXNEVpQzBFbGRDblZDTWdw?=
 =?utf-8?B?dHpCYkFMWTRiSzhJQkRjWERsMzFKbWppblY0RnhSSHFnOGFEUncyaFZybWs0?=
 =?utf-8?B?WEE5M0FtZTlFLy9FT2JtZWgyQkJDR0lvdUJ1Vkg3Qm11RXRIMERSRC9XRC8z?=
 =?utf-8?B?Y2piSVc1d1REVHZINUxZNjJWbEN2SVhuSlBvVzltTWE2UUJnVWhVMjRmcEsy?=
 =?utf-8?B?aS82bnZTdUNBZXJrRjNpR0RCc0JxWWhmcTgzamhJQVFzbkhPMmI3aXVVaEFv?=
 =?utf-8?B?RkdOM1Q1dG10NENIYWZhN3kwbSt5RGFwbE5TdW11YU5UTERXZ1AxMzluYUI1?=
 =?utf-8?B?cGlsSitkc3V5QXdhNjlYejZNUTNMbmxKaHNHNTVqUDlQcS9ubEJnNXZralZO?=
 =?utf-8?B?UXhSQXFGQnQzUk1CSkZSQ2NHNnN3YUU0Smx1Zk4wcU1rc01XN2V3MGlrYWtJ?=
 =?utf-8?B?djd4c0xGV2dkeSt6VFFybHJWcVRISzFVc0dnNVFucmVvZ0o1NUFldjhmZU13?=
 =?utf-8?B?cFlScnhsUnEwUFhJSXZPOWF5UEVPeFZxNkZJd0l3RGRaVGl3OC9kVFJ2bll3?=
 =?utf-8?B?c29oVW5tR3ZGYUtBeWU1a2xkZjIzN3I3RldlQWVvVjZRK2Q1VTZIT0JFSjVi?=
 =?utf-8?B?VUNyMmFkWGQ2SWhOYThqU1VsSHg4UktMMnBIVlUxWTJLZnFMaEdjcG13Z01S?=
 =?utf-8?B?dnRHOGx3WEVsN0xCaFZreFRPYTNVdEgyTW9TQlFvTU41NUdLaGRKUnQrcm00?=
 =?utf-8?B?UUIrMnNTM0xWRGcwQmRzTUZEcWYwSzM1amRpaTVJejdlUEdEQnE1LzMwaFVu?=
 =?utf-8?Q?CXMPxi93XmI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QktKQmlZWDFGclFianp4dWxOdTFpd0lyQUcxMG1XNExlYUpRWFViaWNJd2VS?=
 =?utf-8?B?SXo2MCsxYVNXczJaaXlSSnhOYXRadjVjeU5QVkNOeVdtOXUwT3EzaVJpZG1Q?=
 =?utf-8?B?Wm1aOE9mYUhDby93TWtLTnM4U3RGdU5odTRhYjYzMGt4ajlyc0hrYitBa0pi?=
 =?utf-8?B?SmpEeWpYT3ArMmNZVjJ6ZnozblppblJ5MVpWczNmek5MdDlMNFRreGl4Nkpp?=
 =?utf-8?B?anJvdEVNVmdhM2t1TTludHhhcHNuMDNwRjZURlJGWVQwR0NRRHJLbEZJYXlh?=
 =?utf-8?B?VTliZ2lDUEsvUzl0TnZFR0lrclB0TkgwVnprSll4UnU1UXpCWHIzeUFBNGtH?=
 =?utf-8?B?SVFDYmtmZG0zVTFNK2NjRk5DRnZBRDN2ZUhLV2s0MnFVWWNVcVpIWHJXL2Qz?=
 =?utf-8?B?THptMityTnh2M3BaTmp6OXhqMnlNM1RRbG1mQkpRUEZyQ0RlRUhmc1drejl1?=
 =?utf-8?B?QitqTTFNUUw1eSt3U0cvMXlNNEwxSjdndHhoelJRNTNoVEhialVqSU05Smtq?=
 =?utf-8?B?cEhYb3Q3UkZ0MHpxV1h6aWMySlVPWDg4eEZ6SW5kMmhmNkNwL09XWjZaVFBP?=
 =?utf-8?B?STFHS1V6bDNKMXpvUXdoam9taXp0bmkwNlorWGI1MlRJNFVlc1VGL2Ivc0o5?=
 =?utf-8?B?Y21jN0wyalFIbDhhYmp0OE1kaE9vbEY4ZWlwRitDVGdOcnNOZFBlZHhucVVX?=
 =?utf-8?B?NnMycmp2TUZCSFdNclBWMlYwRk5HOVFxUFhobXBRN2oxZHpUUXc0cmkxcmxE?=
 =?utf-8?B?Rm1HdUtFSWE2c2tHWjlKVjlaNm90akx1akFEd3NZUFlGZ2FhVEhod2tNUlJz?=
 =?utf-8?B?a0h0KzBZekVZeVI5SkkvTGNCVGYycC83TkxPN3FJRFArNTFGRS9UVml2OU5N?=
 =?utf-8?B?R29JS2dJZTl6aGxkU0F6Z244bUY3bmg0NitueE5NZDRHTUhDUS9ONy8yTlhp?=
 =?utf-8?B?RXpYSHo2V05zbW1qdmRoYjhTcnJBWWFZTXNoenByeXdDVXgzTW5nUitJT3ZW?=
 =?utf-8?B?dm1qZitxNmlaaFZHZ3VFL0dRMHlGSGRLa3o2QTRzZGs1K2ZSRzFuWWVNQ1ds?=
 =?utf-8?B?MUdGYTIzcGNTbUtwOUxWQy9LbThGRlA1bU9rbFlLZ1Q4Nk01cVhTbDdNRFRP?=
 =?utf-8?B?YXZIUDdIem9kTXhDdTRSUGFjTERxajNNN2Z3RXRDSXRremZQekx6eHN5ZXk2?=
 =?utf-8?B?Q2ZiL1BMc0FpT2ZTMjNFL1JuOHh0anlKZlNmcnZLaTBOWVJKdDdZdGRpVVNv?=
 =?utf-8?B?S09wUXhNZCtFYlJrNjhvdGh3aG8xMCs3VWpFSHZWN0RneE4rN2RXZ1FkMm1X?=
 =?utf-8?B?d0s0WXBIVWVsQldJT0tWcTRNSEJ6SWJLNmZITnB3Z0hIb1dBaFRVVlFyaklX?=
 =?utf-8?B?Ylo1dEtPMUpYaWFsOE1Pc21wK3dONUxCQ2c3dkpsWDl3dnUzcDl2emlhUzE0?=
 =?utf-8?B?ZEVXdXB4U0tEWE14dWJ5cnBQL2tiY3YraHdHV3VhL1JQV2xjWFhKYVlMMXdP?=
 =?utf-8?B?ZU1hRm1MNmVKbFYwOFBEMUdqYk9BR21jUlhmcEloYk1ZNU9sRlRNMkppNUNI?=
 =?utf-8?B?WEdwb2VLbWZoZXFkb2Q4TGIzMGpreGlLUHlvb1hJQm1lRGs4Q24rZWZLQVRT?=
 =?utf-8?B?QVdleE0vdllzV3QwMzh6RkNFcElYaVU4RnJOeE51bEg4U3crRmVncjkxR1ds?=
 =?utf-8?B?dVJROENuWTNQend6b09sL21tVnFsNEh2cjVrY1F1VlpsUVdLN3JwYWdUSkx6?=
 =?utf-8?B?bzRJZmxQMmZuZ3QrbmlwWHVoQnl4Mzl6WDQ4NTR6dTZUS25wN1lZRnVVNzNz?=
 =?utf-8?B?emVQdXhGNmxFa0pCV1gxbW9vVmt3U0h0ckxUY1AzaVgrWE1ON0tQOHdsc3dV?=
 =?utf-8?B?S1ZTNGdnWEk0RUlTZHRGM0NPQVpuNURtRmxMZ0pRRFNndlVzMjlZTW5lNUN2?=
 =?utf-8?B?L25aNkdKc3ZFdFJnY3BCVXlNbFZPazdQMUNTWnh2Vk1wVWtrbmV4VDlaOExX?=
 =?utf-8?B?SkVyeW1YRFdSdGliUXRDVGsxVVBiVnJTRkw0MVFHT1ljNDRJTC9JdjZ5WXhi?=
 =?utf-8?B?aUFsdmRIcnJhOU9JR2VocHgvSHo4ZE1jQmhLV0pxamFZSWhXSnlYTmlSOFBB?=
 =?utf-8?Q?QrR9VS2v++wPhdidxoN02gXpa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d392db-1376-45ed-bf2e-08dd89501c4e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 08:05:32.2930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SSnizc/EE8Sp66TdNetnVnYRaZJ9yqLjFcociBfa530L2GDp/2E2VmB0VwOR5Cu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8551
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

On 4/30/25 18:05, Arvind Yadav wrote:
> Mesa passes shared bo, fence syncobj to userq_ioctl.
> There can be duplicates here or some fences that are old.
> This patch is remove duplicates fence and only keep the most
> recent fence for each context.
> 
> v2: - Export this code from dma-fence-unwrap.c(by Christian).
> v3: - To split this in a dma_buf patch and amd userq patch(by Sunil).
>     - No need to add a new function just re-use existing(by Christian).
> v4: Export dma_fence_dedub_array function and used it(by Christian).
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 3288c2ff692e..e3e4aeee1356 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -851,6 +851,12 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  			fences[num_fences++] = fence;
>  		}
>  
> +		/*
> +		 * Remove duplicates fence and only keep the most recent fence for
> +		 * each context.
> +		 */


Drop or at least change the comment. You should never document what the code does, that should be obvious by reading the code.

Only document why the code does something, e.g. in this case here something like "Keep only the latest fences to reduce the number of values given back to userspace" would be appropriate.

With that done the patch is Reviewed-by: Christian König <christian.koenig@amd.com>.

Regards,
Christian.



> +		num_fences = dma_fence_dedup_array(fences, num_fences);
> +
>  		waitq = idr_find(&userq_mgr->userq_idr, wait_info->waitq_id);
>  		if (!waitq)
>  			goto free_fences;

