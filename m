Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61207C021A7
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 06:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3FA310EA00;
	Thu, 13 Feb 2025 06:46:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aaVYgf4T";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 438A710EA00
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 06:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqYbOJUsSVTLCkEBYM0HE+ObXs1qEGFzUWNl4gcX0+ENrMj74qHQqPH2W6zQ+XfcaC+zEL947hmzqP6ipv8tM6sdMxuLoNCHbeZZRr/ptSZvz9zEDn+RIIboaKa4HlVO6Sj+Kh/UWl68lo9MwNLLJdUmhue5Eyq0+tBVoBviBr8nLc/m9dFpJ89a7yJlBcbx/35DgcCW7en8hVXKAvZiGvTC8T5bdxid/UORu724e6yY0OH552dbwewdHn0KZp4hBDySOXBFfdx1NQC3mL0YIT/XAd7jdf5lSaG75w6IItyFyX4YJP6GkcgFThmaL7jcZSSLMu8KfOyLmvoPq9qpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UdsvcfmtUrJ+/ZaTYuXQquMK/NKB6k/2rtv5VCf1e0=;
 b=bhSCovPE4rsjVIwksnw4RNH+36n8Iai1d2lM0oXbsBfnn13lqoQIGU7Imc/uPIV74zkcu9iDwsw6q5AWzVq4jVX6OM0KWArpSSwdi1/iuGCqoVOqIEg8HJzbdOa83TF1nPKEvp9uY9pEpSXIdha2nV5cO63GzYVKslO+uFkLHBjnzRZFBq0qqfqA4vPgakFNDw1T5lJnka+bLmTdxv/TnmGzL2qaNDkGTEE3aFvxyb1w5kZwAB362j/eyMjIswDziD8kScoDGHCGXZB4V8etJZ5sKJoB/NVqD/vZ86+fSFQGHPVLTpFa4IW7mE8cqu4EQlYxhZChBETMEfXnYtXx9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UdsvcfmtUrJ+/ZaTYuXQquMK/NKB6k/2rtv5VCf1e0=;
 b=aaVYgf4T9YUw4vO4wKu/Mutzb5Qv8YOTzrLqNrYa6k5emLmnURzMWWjGQTzkWBCkjxYIHXHqNIGu27tWwUi46IBtsSqpVkhsilai/dvthgxYXzxq+u27cvOlQ3Eylg78eLxon0qX8mpStLrvrbHjLNtlnLqAnV4CPYSbTG1xqbk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CYYPR12MB8653.namprd12.prod.outlook.com (2603:10b6:930:c5::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Thu, 13 Feb 2025 06:46:34 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 06:46:34 +0000
Message-ID: <a7f7fcda-ae6a-4506-a7a2-4e3eea5316e4@amd.com>
Date: Thu, 13 Feb 2025 12:16:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] drm/amdgpu: Per-instance init func for JPEG4_0_3
To: Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>, Koenig Christian <Christian.Koenig@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>
References: <20250213025408.2402828-1-sathishkumar.sundararaju@amd.com>
 <20250213025408.2402828-2-sathishkumar.sundararaju@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250213025408.2402828-2-sathishkumar.sundararaju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PEPF00000179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::44) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CYYPR12MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: 863cbdc7-b800-4a3e-1260-08dd4bfa27c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2lNNUlxaXNJWlZmR2p6R1NXSnNaK1ZRQmhOWDlZWkRwUFF1V0hNb2JpUU1B?=
 =?utf-8?B?VWZmQlp6anJ2TStlSVZFMHZ5NDJ3d3FoRjVqanFnK1RzS3oxVWc0Y245dWE1?=
 =?utf-8?B?bEdxZGY1MVFMMC9iNkZlY2dDY3NhTXpJOEJET0k4ZHpNT2xYVnV0dzlaMU9y?=
 =?utf-8?B?WW5LaFBwZFIyZ1ZUbi9GaUZ0YjU0NlFVbUVFRUR6a1dzU3pSK2t2c3pTOUhZ?=
 =?utf-8?B?RXkzcXpqT1dHTUpjVjZwRVVKWWVka2tmVkpNeWs2OUdvbGNvT1lFaWM5eHlK?=
 =?utf-8?B?cWJHbHJBQlFjTFBiY3Nzc29JSTNxaHN5cE1lUDVQd3JXSEFuL0NpSmU2Q3pp?=
 =?utf-8?B?dnJNZFkzTk9Kblp5dWt2MjhoUnc2N0NicnpaaG9hU1JGYmVjK2JITmptdGhs?=
 =?utf-8?B?d2s1alZxbmswaXRJMDd5dWNFS1AwSmJhUnZRTFZmanFzT0dVQkVEdlNqdTQ1?=
 =?utf-8?B?NXA0MHZRcnQvN0dlb2NUUnlyNW8rUWl3d0dQdmVxTWc4aXJrR3RVWk9mWGd2?=
 =?utf-8?B?MERIU1lVSlpnc2pGVGxJMFFjZlFaUlRkR1dxcEpJcWs5MUlyYlZpM29hYXpF?=
 =?utf-8?B?SWwxUnpNYTVqdWJ4WWs2QXJ6VDNQcFpVVWRnTFVXV1RYVWdHR094YVgweEJU?=
 =?utf-8?B?OXluc0FpT3o0em9QUXBDaS9tRUo5VzhibmZBQkVIdlpBdS80OE9jeWZzM2tC?=
 =?utf-8?B?L0pSajZSUWp3UkgxRGxRWWpZbWhUUGxGVjNJcXp4NUNhV0o2QmhScW9uN2xa?=
 =?utf-8?B?clY4Rmx5bHk4akVMY1pmR3dWM01CdUVpeG1jWnB0cVBsdG1vN2tBOTd1VU1u?=
 =?utf-8?B?TzFkdkdjRTJqVnF2MUNVVXVzanM0dWVjMGF5U3JuNDlUbmJRbTdRVU50cmxX?=
 =?utf-8?B?UkR0clZpQXJLbDZ1N1BoTzY2T0NQMDRFV2ZWOFlmc1ZVWmxRWHRkOEFlUm9Q?=
 =?utf-8?B?aEVwenRqeEtHV3FIV3JEZ1JOdlZWSU5IcS9RdndpNmFSMGZ4SnUxejNZajk2?=
 =?utf-8?B?U0ZpT1prMGtUNkMweWEyMFVSYnp2aG1saWUzNWpZY2NjL3NjUmJEa1l3MHdB?=
 =?utf-8?B?M2JpcS9YblBjNmh2Qk5YL3JRbllveEVxMCtxMzZQb1lVajM0Q252b1pDVWk0?=
 =?utf-8?B?cEJKMThhbHFHZURxQ0IvYWUyK2h6cEQzVExEZkNaM0NkRzVMcllJbDJReis1?=
 =?utf-8?B?Qy96VVZGeXRTRmRlVEpORjI0YUpxY3VGZml3TTR4VXNLSlNESlVJbFU5ajRZ?=
 =?utf-8?B?VUxYM1FuNmRvMm04dEZqV1I2eWYrZWV4eVVZdTRZUFlweE1ST2I3T2w2cHFT?=
 =?utf-8?B?eTBjOEZER3I0azJvQkYwbkZIWUVqcklUSnAxWlg2UG5RN3RIQXBXNDM4aWZJ?=
 =?utf-8?B?TXRBS3E0M0pyZVE2VkVmMDYxeW93MWlDYnhqWktjZFovQzNVVUxhSGlXV3Jr?=
 =?utf-8?B?emJ5Uk1BQ3Q5SWdTWjBtdENrM29neTY5a1RqQk8vNHlRWHFHbEZvakxlMnht?=
 =?utf-8?B?Q1VHek1Fb1MxTnE0UWJ1VjBjbGVGaWVXRVJxT0FqZW12SEYzSG5Ca2puUFJa?=
 =?utf-8?B?K1NIbW4xZit4cDN5TGZhSm50Ry9Pbi9KQVlqSzRzalJrM2t4RXcvWjlQdUhC?=
 =?utf-8?B?K3piRXRGNU1ZZ0FLdXFRQ3BSSjZ1TnU4cnhZVzU1enNWUWRwRlp3TjFkS002?=
 =?utf-8?B?Z0QrR1JPZi9rSmVRY3BTaXl5ZXBBWHA4Smt6WUY3R3A2cDdNendLMWRaaW5J?=
 =?utf-8?B?KzdEVnhFR09sYVdwaS8zSXVwMXZDR0toRE5kSFBHUG0welJJeHdKU3E5MCtQ?=
 =?utf-8?B?blJBc0lKTjRScEFMY3htbEE0MGdhci9uTWZscks3QlIwOWRZMnlUY2RLYWk2?=
 =?utf-8?Q?Cn/itRfbVboxo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dCtCQ3RtcXBadEg3UWsra3RGMVU0RGp3V2RFVFlGQm8yZWRydUFFZ1lNQUp0?=
 =?utf-8?B?ZUNLUWc1elBJaFhodTdZWXYxWkNSUjRDQ3FuODBrTjBpUUR3TFNKbGpJOWJx?=
 =?utf-8?B?anE5QnQyaVZHMEtQTm1sY3dQcGduL3NVRXNET3FUTjdoU2hXQ1RXTkxxSm9k?=
 =?utf-8?B?NGl2TW1mNG9wbkt5aFRKN2tDYkk2ZnZ6TG9iSGVFS1dodFpPdjZnZGxvcTZK?=
 =?utf-8?B?RHcwVmRROW9LTzNkalFRLzBvQm1TT1ZuNTdiWldwSmJHSkdQZU5yeHhIVm5V?=
 =?utf-8?B?amhmZU1qdFlDckpra0dIY0ExWEt1Q0hyaXdzOURMUU9jUXhvRk5lbEl3cDRB?=
 =?utf-8?B?WEJJWkNTdDA3MGs2VnZWblhuUkNQNzZyTVZud2s5aXI4bEpHN0NxVzM3L0VM?=
 =?utf-8?B?RGVYRENMMmpGSmk0SGdSdjVMTmZBSjFleW1rcm5lV3FYd29OaTdydVJqWHMw?=
 =?utf-8?B?TFpEVkxoRUdibXQ0S2tCd1JaWVVMNndGbkVPRXRWNWsveGhnZ2RiLzRTUFNW?=
 =?utf-8?B?KzlZY2xEd3l1ci8zdHgxNFhFK0ZYY3FEeEkzdE9VMmNiQU00YW9XYVVTYTA5?=
 =?utf-8?B?ZkNOZVljTGkvb3RXU25kaEhsR2VmMFhWWDJ4VWhsTlNSRTR0OXFYQnoxaDFn?=
 =?utf-8?B?TlNGSm9id3N1RHlSNDFtSWNNR3Z2UUExK1l0c05PaEFpUWR3dDNTcTd3QmVy?=
 =?utf-8?B?SE8rampXeG1venphSi9WcDVzdS9YNTFieTFpcDR5ZExKanFpMDNJdG9yOG9U?=
 =?utf-8?B?Nzd6U04rUUlGaEFlRXVEbGM2N3dvZ2xxbkllUHZJeVJBTVBOYThZTmg0czNy?=
 =?utf-8?B?My94UGhnZSt4clZjY2NSaXQrcGJmOEZ3cWh2Uk1MT2NLRmg1Ukwyb1lEWmN4?=
 =?utf-8?B?d1ArNnNpZWtzeTBKTkQyNklmU1NibTlqdXY4ejFuT0Y5SlR4ejZNdjRsZm94?=
 =?utf-8?B?SHQ1UEhiNkVEbVI4cG9OdGZsQzJiZStvV2Nvb3NCTHFhTE5FR25OSmlxOFBo?=
 =?utf-8?B?MVRaMklITW9UVEdVcVYrTWNhekZnY0RwWko2LzRFRllBenR6Ny9wclFHNlYy?=
 =?utf-8?B?SzJnTUt0eTVJY1hyTG43UVVYUlppbERRTktFZWhPUGZxeHlWdEtrUXdRc3dK?=
 =?utf-8?B?L0xQbmMwSHhkQ2paYW9kZmFPcExsamhaam9vdFFhZkVhdEpFWk9rc0FLZThv?=
 =?utf-8?B?dHA3b1NtMkkrS1U1V3NEb3JIOVdWcDl2bDVOWlZNN01FTVdXOS83ZXhMdlNu?=
 =?utf-8?B?VzlyT3VWaUFIYVE3N1NLaGtsYk05UHVyZVF2TDlZVnh2TnVkSW9panpKSTFp?=
 =?utf-8?B?blpRVFBZSStITFg0VjNwaWJvdG94NDV3YTJCM1ZEb1IvSWdRQWd4VTRoVnp1?=
 =?utf-8?B?Rm9HTlRyM2lyTXNzNEVrV3hhME5kdnROa0NiZXVubzUwYlNQUHZ0b09lbFR6?=
 =?utf-8?B?dTZxS3JZY09CZjN1Vnk4NDd3WlQ2bDA1bG41VXoyOEY4Y2I2cUE4VGNnaDEz?=
 =?utf-8?B?WHZBSFJBcTN0MDc0SVFYaUJlRkR1VlpTV0pWODBxSzAyWmdLdHo0ZTR2bytn?=
 =?utf-8?B?TXJzeHczTzh5Q2dqTFMwUi9neUtIK1VNUnFRZzBDMVF3Yit0WlErUFU4Qmhp?=
 =?utf-8?B?YnlDL1gvMkVwczlZeHRYNitLWEduRnFZelNuTG5Ic2FOYU03UmZmaS80Z0hD?=
 =?utf-8?B?amtnQzBOaUtRcjh2bWQvaDljMUEvZ25jc3czbXd6UkRua09hOUdJeFpYaTVs?=
 =?utf-8?B?anF1MzlqTU1Ha3MrTnA4M0VCMGFyeGxCOWc5YlNoVTJsaHJMSTNNQ3htaFVv?=
 =?utf-8?B?dkY4WmR0YnpFTGY2OE1PcjNobEdkRTRFK0grTnhKWkNSVWUxcmxJYXlkeTdt?=
 =?utf-8?B?TU5zWjgrenJNTXY5bzcxTzM4WjM1VVZUaGo3REE4ZGJUalpXbXNuNTFFbit1?=
 =?utf-8?B?TGc1MGRyL0VqZis2WTAzWTlCZ0FwS3hiMGhoUFVlQ1RxWjZXdlhyZ1U3UVBB?=
 =?utf-8?B?SHRJM2hLdmpMZnFlL2s5d05FdlRuOFNmZDZuRStJTjk3WVh5MEZqUzdBREtw?=
 =?utf-8?B?aW5lUlZjUGhXQ0g2R2hTK2ZGOEtPdUFWcStxOTVqYkV1cEFYSEtpaDVOa3FN?=
 =?utf-8?Q?BsaaHZYyOLQmekgsDolhkqVi0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 863cbdc7-b800-4a3e-1260-08dd4bfa27c0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 06:46:34.0688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfCTV+I9CkcWIyFcPsIwj03IQGxsKxqGMfAR0jaFc4qCsJtDM4lVHsrZ55EF2Sgd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8653
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



On 2/13/2025 8:24 AM, Sathishkumar S wrote:
> Add helper functions to handle per-instance and per-core
> initialization and deinitialization in JPEG4_0_3.
> 
> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Leo Liu <leo.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 190 ++++++++++++-----------
>  1 file changed, 98 insertions(+), 92 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 2a97302a22d3..e355febd9b82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -525,6 +525,75 @@ static void jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst
>  	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CGC_GATE, data);
>  }
>  
> +static void jpeg_v4_0_3_start_inst(struct amdgpu_device *adev, int inst)
> +{
> +	int jpeg_inst = GET_INST(JPEG, inst);
> +
> +	WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
> +		     1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
> +	SOC15_WAIT_ON_RREG(JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
> +			   UVD_PGFSM_STATUS__UVDJ_PWR_ON <<
> +			   UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
> +			   UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
> +
> +	/* disable anti hang mechanism */
> +	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JPEG_POWER_STATUS),
> +		 0, ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
> +
> +	/* JPEG disable CGC */
> +	jpeg_v4_0_3_disable_clock_gating(adev, inst);
> +
> +	/* MJPEG global tiling registers */
> +	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX8_ADDR_CONFIG,
> +		     adev->gfx.config.gb_addr_config);
> +	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX10_ADDR_CONFIG,
> +		     adev->gfx.config.gb_addr_config);
> +
> +	/* enable JMI channel */
> +	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL), 0,
> +		 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
> +}
> +
> +static void jpeg_v4_0_3_start_jrbc(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	int jpeg_inst = GET_INST(JPEG, ring->me);
> +	int reg_offset = jpeg_v4_0_3_core_reg_offset(ring->pipe);
> +
> +	/* enable System Interrupt for JRBC */
> +	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regJPEG_SYS_INT_EN),
> +		 JPEG_SYS_INT_EN__DJRBC0_MASK << ring->pipe,
> +		 ~(JPEG_SYS_INT_EN__DJRBC0_MASK << ring->pipe));
> +
> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> +			    regUVD_JMI0_UVD_LMI_JRBC_RB_VMID,
> +			    reg_offset, 0);
> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> +			    regUVD_JRBC0_UVD_JRBC_RB_CNTL,
> +			    reg_offset,
> +			    (0x00000001L | 0x00000002L));
> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> +			    regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
> +			    reg_offset, lower_32_bits(ring->gpu_addr));
> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> +			    regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
> +			    reg_offset, upper_32_bits(ring->gpu_addr));
> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> +			    regUVD_JRBC0_UVD_JRBC_RB_RPTR,
> +			    reg_offset, 0);
> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> +			    regUVD_JRBC0_UVD_JRBC_RB_WPTR,
> +			    reg_offset, 0);
> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> +			    regUVD_JRBC0_UVD_JRBC_RB_CNTL,
> +			    reg_offset, 0x00000002L);
> +	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> +			    regUVD_JRBC0_UVD_JRBC_RB_SIZE,
> +			    reg_offset, ring->ring_size / 4);
> +	ring->wptr = RREG32_SOC15_OFFSET(JPEG, jpeg_inst, regUVD_JRBC0_UVD_JRBC_RB_WPTR,
> +					 reg_offset);
> +}
> +
>  /**
>   * jpeg_v4_0_3_start - start JPEG block
>   *
> @@ -535,84 +604,42 @@ static void jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst
>  static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_ring *ring;
> -	int i, j, jpeg_inst;
> +	int i, j;
>  
>  	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> -		jpeg_inst = GET_INST(JPEG, i);
> -
> -		WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
> -			     1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
> -		SOC15_WAIT_ON_RREG(
> -			JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
> -			UVD_PGFSM_STATUS__UVDJ_PWR_ON
> -				<< UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
> -			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
> -
> -		/* disable anti hang mechanism */
> -		WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
> -					  regUVD_JPEG_POWER_STATUS),
> -			 0, ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
> -
> -		/* JPEG disable CGC */
> -		jpeg_v4_0_3_disable_clock_gating(adev, i);
> -
> -		/* MJPEG global tiling registers */
> -		WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX8_ADDR_CONFIG,
> -			     adev->gfx.config.gb_addr_config);
> -		WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX10_ADDR_CONFIG,
> -			     adev->gfx.config.gb_addr_config);
> -
> -		/* enable JMI channel */
> -		WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL), 0,
> -			 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
> -
> +		jpeg_v4_0_3_start_inst(adev, i);
>  		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {

It's better to move this inside the instance function. Instance takes
care of all cores within the instance.

Thanks,
Lijo

> -			int reg_offset = jpeg_v4_0_3_core_reg_offset(j);
> -
>  			ring = &adev->jpeg.inst[i].ring_dec[j];
> -
> -			/* enable System Interrupt for JRBC */
> -			WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
> -						  regJPEG_SYS_INT_EN),
> -				 JPEG_SYS_INT_EN__DJRBC0_MASK << j,
> -				 ~(JPEG_SYS_INT_EN__DJRBC0_MASK << j));
> -
> -			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> -					    regUVD_JMI0_UVD_LMI_JRBC_RB_VMID,
> -					    reg_offset, 0);
> -			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> -					    regUVD_JRBC0_UVD_JRBC_RB_CNTL,
> -					    reg_offset,
> -					    (0x00000001L | 0x00000002L));
> -			WREG32_SOC15_OFFSET(
> -				JPEG, jpeg_inst,
> -				regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
> -				reg_offset, lower_32_bits(ring->gpu_addr));
> -			WREG32_SOC15_OFFSET(
> -				JPEG, jpeg_inst,
> -				regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
> -				reg_offset, upper_32_bits(ring->gpu_addr));
> -			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> -					    regUVD_JRBC0_UVD_JRBC_RB_RPTR,
> -					    reg_offset, 0);
> -			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> -					    regUVD_JRBC0_UVD_JRBC_RB_WPTR,
> -					    reg_offset, 0);
> -			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> -					    regUVD_JRBC0_UVD_JRBC_RB_CNTL,
> -					    reg_offset, 0x00000002L);
> -			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
> -					    regUVD_JRBC0_UVD_JRBC_RB_SIZE,
> -					    reg_offset, ring->ring_size / 4);
> -			ring->wptr = RREG32_SOC15_OFFSET(
> -				JPEG, jpeg_inst, regUVD_JRBC0_UVD_JRBC_RB_WPTR,
> -				reg_offset);
> +			jpeg_v4_0_3_start_jrbc(ring);
>  		}
>  	}
>  
>  	return 0;
>  }
>  
> +static void jpeg_v4_0_3_stop_inst(struct amdgpu_device *adev, int inst)
> +{
> +	int jpeg_inst = GET_INST(JPEG, inst);
> +	/* reset JMI */
> +	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL),
> +		 UVD_JMI_CNTL__SOFT_RESET_MASK,
> +		 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
> +
> +	jpeg_v4_0_3_enable_clock_gating(adev, inst);
> +
> +	/* enable anti hang mechanism */
> +	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JPEG_POWER_STATUS),
> +		 UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
> +		 ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
> +
> +	WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
> +		     2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
> +	SOC15_WAIT_ON_RREG
> +		(JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
> +		 UVD_PGFSM_STATUS__UVDJ_PWR_OFF << UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
> +		 UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
> +}
> +
>  /**
>   * jpeg_v4_0_3_stop - stop JPEG block
>   *
> @@ -622,31 +649,10 @@ static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
>   */
>  static int jpeg_v4_0_3_stop(struct amdgpu_device *adev)
>  {
> -	int i, jpeg_inst;
> +	int i;
>  
> -	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
> -		jpeg_inst = GET_INST(JPEG, i);
> -		/* reset JMI */
> -		WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL),
> -			 UVD_JMI_CNTL__SOFT_RESET_MASK,
> -			 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
> -
> -		jpeg_v4_0_3_enable_clock_gating(adev, i);
> -
> -		/* enable anti hang mechanism */
> -		WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
> -					  regUVD_JPEG_POWER_STATUS),
> -			 UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
> -			 ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
> -
> -		WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
> -			     2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
> -		SOC15_WAIT_ON_RREG(
> -			JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
> -			UVD_PGFSM_STATUS__UVDJ_PWR_OFF
> -				<< UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
> -			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
> -	}
> +	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i)
> +		jpeg_v4_0_3_stop_inst(adev, i);
>  
>  	return 0;
>  }

