Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45912CA0EF5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 10:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0A2910E580;
	Tue, 19 Aug 2025 10:00:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M/DsDa6K";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FDC810E580
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 10:00:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzGlRzaD0/7u//L2asQNaXME+kPQIxRbVr/E8BdR7eRXnAGotc/d70edATnDRqXEgWIH7C6t0l8yO/Hb1S1rZQ65ZcyDkDbVunUOQ2DGTZLYG/wJAh0IoiYI7UC/eOKESRwpYaNWZaH9TzfZJMYjD1uADPkcxy4ym+9CixO34PJegH+CFBLmNIIOLKIsNluGZCKkaspspK4YYt7k5kfrnPymE8JNFVXCKDe+wCkF0Lxttkl4Hg8+ZLnRx2m036QyyKvXcU9l6B2db62lpMGg6k0mGpZ1WfQbA0Ydz8wfzjPF/J/GZsj/nbFzHEs6WjLk/5nFOGpRKExfv3SyTxyQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7pyFJFbtmb2tkQpJAie6EuUi5SmSi4Be1kc69scizg=;
 b=CFFl9fe/cCgCfpGK7oZUgV7gTqaj3wIKQurGcpAcy6gKCtTWJtdRrcxo69HmcFT+a7VS7QRZSp/ONHB7ZSzfKPxxxj7zd5iD1/nZliGWRXQ+FJtAjpXg4lUgm7qaoA8KXcbLfuP1iUdD0QRXm1sMR83hyNLoGrySpx226trCEy2WUiun3nDTacDcIRGm9iDZs5Fsyj1swuOnbutzmaGGrgS3LlAqQ5tN3kc7blc/adzkddvVAtHZwM6JDsqaH7vbiiGEk9dZVxMzYpWUPGmDfEsGlmDuTSvCrNtrhNzJWIWnsx0t+NVjh5/fhd8nvLAhmmmMX5eQ9RGcaF8YgiENVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7pyFJFbtmb2tkQpJAie6EuUi5SmSi4Be1kc69scizg=;
 b=M/DsDa6KH37yNhNt0EizY6dC8BBZLF4F7HdQHffoLPg5JkJ+uYUSWiC6ncyVMcULfFVDK6C8dTStbgDuUoKToU/ntRgGDjk1NhHCpTaSg8kznO/MuRgmx4QqlcRYw0iYvp8msjICE6q9n0RasunQLJd3f9qSSHrI4ohFmAkUCT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 19 Aug 2025 10:00:07 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.9031.018; Tue, 19 Aug 2025
 10:00:06 +0000
Message-ID: <e0bc073b-7ee6-4e0e-b65e-efb75697a084@amd.com>
Date: Tue, 19 Aug 2025 15:29:50 +0530
User-Agent: Mozilla Thunderbird
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Subject: Re: [v2 1/5] drm/amdgpu: Refactor VCN v5.0.1 HW init into separate
 instance function
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 leo.liu@amd.com, sonny.jiang@amd.com, Ruili Ji <ruiliji2@amd.com>
References: <20250819091802.445099-1-Jesse.Zhang@amd.com>
Content-Language: en-US
In-Reply-To: <20250819091802.445099-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ebef817-1bcc-49b2-4399-08dddf072ce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDR3UHZwRXBFKzFpbTh0RVhYQmRQMEFCdkgwcnRCTDdqNnpNYTJWQnpDV0U4?=
 =?utf-8?B?YURYb1dpTStCWU1XYzI2aTlTYzlIM09HYVBPWmMvdEFEcHFkOERUOE5yRXp5?=
 =?utf-8?B?RmZqcm12R3pkSU53eUErYmNwRzhpMVBvNENvRHJGQWVKd2l1NTZHZkd5Yy9T?=
 =?utf-8?B?TzAwd01oeUZMblNJTUdVK0lVQXZyU2U3clIyaTFnU0ZSYmhPdnNWZHpWMEdq?=
 =?utf-8?B?WUwxS01LS21wL1pYeGZUZ3k3MWhKUjdRUklVMEs4cjdhWkF2UVRldDJuajhT?=
 =?utf-8?B?VTFIWjMwdEUzdGRJZjZWL2tqYmkvdVpieFd0RkxLTHhsM05CRTJhcXp6QVhV?=
 =?utf-8?B?dUpTbExpdTA1Y2dEV2ttNC9xSG04VG10N2xmWUlKZzB0K1FCNWFFTTk1YWls?=
 =?utf-8?B?VWVQZ2U4eENWSXZBZ1Y5U3hiM0pGeFBRdGZZcVRYN1BwR21tK0lhTUJ3Z0hr?=
 =?utf-8?B?YU9IWW0yWW9uZlJSTjA4VnlnOGczM05nYlB6MWkrRHNrWDNDZ1VDVUZ2a2NC?=
 =?utf-8?B?MExvcUV1QmZjbGROc0VRNndodE9SZk1hUmt3Q1dHZ05SRjdpZlN5eEdTSXow?=
 =?utf-8?B?azFvUlBIZTMxd2FHQlRsSUxwdG0rL0hBL0UwOFltTmo1bG5uLy82azFMdUlV?=
 =?utf-8?B?T3FDTUNiTjdGY2lIdEkzQkJSTEgrMEJCKzVJVnlzN0kyWStQU2xycC95cFpx?=
 =?utf-8?B?VXRJZnpLMytzaEcwMS9pQ2tMa1lQLytHZ1RZeXRHMWNpOG0wZXZTS3l4a1VC?=
 =?utf-8?B?czdBVlBxQWlTMFkvdDdyZ3ptRG9tMlY5NElhTFNjN3IrV05NWStHc1dRZDFq?=
 =?utf-8?B?T3hBZkZoakRCSDhEQjIxOEpwREZiU01IMWpNV25EZFJ4R3hSUng2YWhSOGZR?=
 =?utf-8?B?bXRyeTdsZzNzc29YRlFqcUd3L0lIdzVaK0ora280cnZnUVZ5eE1SR2Vub3Yy?=
 =?utf-8?B?TndIN1BzaTNDUmVUL3haSlRFbHZ1N2dBSVl1Ymo3YmdQNW5wK1UrQWgrOFJK?=
 =?utf-8?B?S092SWhCdVhFYWRTbStFUU5ac1FrMDNNVEtuQ05SbCt3TzdjajhpVnlaS2g5?=
 =?utf-8?B?VFZxM3BIRldvWnVaNUIzYlRtVFJ4cjhZMWVFTFpGaDFWYjRURW5aaHBQWXFh?=
 =?utf-8?B?a1ZpaWRSY3ZhNkFVd0hKZnJXcUwvUDNDWFppQjZwMmJCN2VYSWRveTdJcXF1?=
 =?utf-8?B?WVdrQ2ZhOFRHdzRuSmdtYmZ5S0JaZHRONjlOVUM5RnhKa0tSUXZlMmNQT3Z2?=
 =?utf-8?B?dHM2SmQvdi85THBHSWRzQkpnZXVLS2FzSTlDdHNzMHR4Y1YvSlhBVUh5NXJj?=
 =?utf-8?B?ZE9JRkczeTBGcXJaK3lzcWhLVU01dmxlUlBBM0RzYWg0eTFXcHlmcDR5NS9o?=
 =?utf-8?B?UjZoVVBlcGZZQjhUejNlTkVseEU3MUt6UDR0dGV5T1ZWUHNLOTBEWE80eFJL?=
 =?utf-8?B?ZWsrQjlvTlhzckNHY2pGK1N6V3E5QTZKZ0VMUXJ5ZUJYbytQNkZVOW5YVzhR?=
 =?utf-8?B?VkFMTHczRzRENFVWcVBpQTA2cmFkM2F2akhMbi9SMHhLRkhKWUVRS015RnBN?=
 =?utf-8?B?U09LdFhCK004MTJoa2FPUXYyTStDeHdHN1hpdTFlbnIzUlZFdFpwT0pxMXFx?=
 =?utf-8?B?NFFvbnl0ckhwL0t0VEkwNlJmbW14YjJ4UGVNb1c3KzhGWENQbkpvTForbEdw?=
 =?utf-8?B?eGR5NXluRUJrVGdGTTkvc2VGTkxhREdQdHMzVlQ0U3lVZjhpQjQwa2VSTWVX?=
 =?utf-8?B?bnJvNC81ekVreFdvZ2RobzczMGpKeDlrQWpVNkROYTBXSTB0NXBxeWVtRDht?=
 =?utf-8?B?a3k3Rkw2RWtwclhBZXFWRlJES1RXVDhTNlVhNUxnbmM4dUJIUXhSR3QxUHNG?=
 =?utf-8?B?dkoyYUJtNVFMQS9KWFdOdzNMcUZRcjhRUGc0Y1JHKzhwZjM3RVBhaFVBakZk?=
 =?utf-8?Q?79cNal6Qikg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTd2VUI4WVhWQzl0QnRlSFBYZFN3VVIvNjZ3cXk1RnBEcUg1VDhvUVM0V1p2?=
 =?utf-8?B?ZW9zS1NiRDlENXorM2NDVDRyNjBRSFN4MXgrVk4vdGlqcFR0M1gvWmF4T1Uy?=
 =?utf-8?B?cGI1VE44bjlwZHNGQThTTTZScGtsNHUrR0RrT1lscURxSDRtL0dBWFJiZ09O?=
 =?utf-8?B?eHEzV3pNTElLbHcyeDltTGhHNlp3Y2tMYU5LeHZkQ0ZiUmVqOTd1UGcrdmNs?=
 =?utf-8?B?K0VrK2kxT0FHeTBUTDFBQ00waGJEeXArZzhKZG9nZlY5bnlxV0NjeEtpdEw1?=
 =?utf-8?B?Q0tkaXpjdUNIV1p1MHF1Q3BWc1pJbHdINUdPWTN6OFdJWG5iSEx0czNhdndY?=
 =?utf-8?B?V2pwRGRHZ2ZjVHM2Wm5UYXRyUURQZmFTTlR6UnpoZ1RIUVcvaXU1L0N5MHU4?=
 =?utf-8?B?QlBmNmpOVGNJTWY2WEVjYmpjOWtMcnlQeVZjcElnRTVYc1oyK0QvSW80Nmto?=
 =?utf-8?B?TVZuSENTdnpTazFNeGV5MCtMbnJCajA2b0dmUmluL2ZuYmZoNFRCMjBIdmRq?=
 =?utf-8?B?dUhJMFRibWJFSS9mUEN6UWtGRnh5UFI0MlpYREw1c1JXaVdYcUNYRUFvNTgr?=
 =?utf-8?B?aUMzMWhKNlhjbUVCUVkrR0VEbnVWSTgycE9ZZFBBaVoxMmJlOFBhTk9zTlJQ?=
 =?utf-8?B?bUQ4T3J2eG04U1JWellZTTkwNEQwbmZ3UHRCazR4TGMzZGNISklramdqY0la?=
 =?utf-8?B?U0VFclBlSmY0YTRQUFpxd2RRZnVyRU54bDBjZC9NYlU5U3VtTmVQNlVnT0tq?=
 =?utf-8?B?RWpTa0pLQkJPY0xRcENlWjZoSVI3QXoyZjVjdXN6Zk5taHJjSytucnUvU0t3?=
 =?utf-8?B?VjNmeTN5WW9FL1NWSWMxcGlwTlE3ZjA3bU9TaVl0VklTVWQwY0pCVStINXZx?=
 =?utf-8?B?MDBNcjRPWWRHSHFaKzRBb2tJWWtJUFdocVNJczAyTVdUTG5tUVZkVnhvZkNl?=
 =?utf-8?B?VzlBRTB6RTdnQzJyZWRlaUw3R2tuVU1SOHlXU29MUGdudTJqYnFIMlhEY3l1?=
 =?utf-8?B?Tmt4OXpMdXJhUkZFejk0RnhUY0RhT04wNnVIUU8zeU84STcvY3dJdk9mNVJo?=
 =?utf-8?B?cVhRaTF3OU9PazRyTXJLZHFmaWswT0EvTklaWjRkbjJXTVUycU5zdWthaVEz?=
 =?utf-8?B?YklZOGxvUlBGOXdWL3YwaEt4c3VWVXFueHRYYkZ0dkl1ZVlLRTVRSVc4WW90?=
 =?utf-8?B?WGwvV0szS2ZhVWQxRUFHS3pqcGJvSEJYMGFGcjhEQmFLbTJRUDZ4a3E3bE9s?=
 =?utf-8?B?cVBicVQ2NTVVdEwrQ1I1RkFheW13WGxpamJrSUtqQkt6ZjU2UjNUbXNyOGZY?=
 =?utf-8?B?VC96RjdLRjBFQTRkUWFwa09wblhuMUtPaW8yU2htTU1yMXlvd2x0ZW5Hc2ph?=
 =?utf-8?B?QXhnemdmcnVZYStUQjJ5QWI1ZzJwT2RtS25udXhqQnRnSWRKd3pabS80Ty85?=
 =?utf-8?B?OUVlNjBrc0tBZXlhaWttQno1ejVoUWxnVUNld1VhUWtJcWVUM2piVGV4RTRT?=
 =?utf-8?B?VE5JckJWcVdya1RZNENxVEJheGVwY2JmOHlCSXRHeTV4Qm9QU2ZOTVloVC82?=
 =?utf-8?B?OHA2L1RReHlxTmo5N3laSWZnbGc2REhzeWZra0t6OHB6b2pCKy9MVm9iVXpC?=
 =?utf-8?B?eXF5eTRSYmpMeFVLdW5KeERxVm9EZ2p4b3YrWUNRSnpEVk1rYmtveEJQS0x1?=
 =?utf-8?B?cndnTmtxR253anlocWplRGNTVERpOUd2NEd3bGtlSEhwRXIxUWRSb2Vva0xJ?=
 =?utf-8?B?TnhIVU8vM3FaWktQTmtzYTZETWVBODA2ZmR2eDdhSmVCOGllRlIyZEkyWDdE?=
 =?utf-8?B?YWRNQ1Z2U05HQm1aN2lZYnNlekxFMWR5V2JXQmY1VzcrcVprOE1ndG5VQ3dH?=
 =?utf-8?B?MTFiKzRnazNoL3RDQU1SM3huQS9lblY1eUhFbHJUd0JKWHBPWFc4Qk41VmR0?=
 =?utf-8?B?K3Y2ZHZXODZwTlcxUG0rWWFXS09iTkhQWUQ1blk1R3E1Mlg5M0dFM3dOVVda?=
 =?utf-8?B?QVlSd0VhQTZrcmFsdi90MkN3Rkk4TVR4SVZLMnArczlPZklUZFNpd1JwVWJ5?=
 =?utf-8?B?QTBkY2wvRTVsWXBPM1VPQ0ZPS2pmZGpvd0w0SmdiRXFkNEQzYXk2N1BLdkVW?=
 =?utf-8?Q?ZrRbBfMhoJhl1T6tF0xErQjz8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebef817-1bcc-49b2-4399-08dddf072ce0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 10:00:06.8653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1fFwkjspixggNzUR0XNIxIzsINzpDcfnmmus8RAVh33yM0EwTflTexvU8PNTHwv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7195
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



On 8/19/2025 2:47 PM, Jesse.Zhang wrote:
> Split the per-instance initialization code from vcn_v5_0_1_hw_init()
> into a new vcn_v5_0_1_hw_init_inst() function. This improves code
> organization by:
> 
> 1. Separating the instance-specific initialization logic
> 2. Making the main init function more readable
> 3. Following the pattern used in queue reset
> 
> The SR-IOV specific initialization remains in the main function since
> it has different requirements.
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Signed-off-by: Ruili Ji <ruiliji2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 41 ++++++++++++++++---------
>  1 file changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index 7cb21e2b4eb0..21e48df537bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -256,6 +256,31 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
>  	return 0;
>  }
>  
> +static int vcn_v5_0_1_hw_init_inst(struct amdgpu_device *adev, int i)
> +{
> +	struct amdgpu_ring *ring;
> +	int vcn_inst;
> +	int r;
> +
> +	vcn_inst = GET_INST(VCN, i);
> +	ring = &adev->vcn.inst[i].ring_enc[0];
> +
> +	if (ring->use_doorbell)
> +		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> +			((adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> +			11 * vcn_inst),
> +			adev->vcn.inst[i].aid_id);
> +
> +	/* Re-init fw_shared, if required */
> +	vcn_v5_0_1_fw_shared_init(adev, i);
> +
> +	r = amdgpu_ring_test_helper(ring);

Better return directly from here.

Thanks,
Lijo

> +	if (r)
> +		return r;
> +
> +	return 0;
> +}
> +
>  /**
>   * vcn_v5_0_1_hw_init - start and test VCN block
>   *
> @@ -267,7 +292,7 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  	struct amdgpu_ring *ring;
> -	int i, r, vcn_inst;
> +	int i, r;
>  
>  	if (amdgpu_sriov_vf(adev)) {
>  		r = vcn_v5_0_1_start_sriov(adev);
> @@ -285,19 +310,7 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
>  		if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) & 0x100)
>  			adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
>  		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -			vcn_inst = GET_INST(VCN, i);
> -			ring = &adev->vcn.inst[i].ring_enc[0];
> -
> -			if (ring->use_doorbell)
> -				adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
> -					((adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> -					11 * vcn_inst),
> -					adev->vcn.inst[i].aid_id);
> -
> -			/* Re-init fw_shared, if required */
> -			vcn_v5_0_1_fw_shared_init(adev, i);
> -
> -			r = amdgpu_ring_test_helper(ring);
> +			r = vcn_v5_0_1_hw_init_inst(adev, i);
>  			if (r)
>  				return r;
>  		}

