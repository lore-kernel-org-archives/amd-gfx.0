Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494E6E7717D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2024 07:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2A1910E31F;
	Wed, 11 Dec 2024 07:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U+8VUMVT";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F281C10E1EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 07:10:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUG7DTl/2cJZniNtC78FJd53Pcs4Bk06AaOyBGWQ5MbEGIU1SXVjQNh5qAaCo2i3rq5ahSQcAV7hcpeec1/3mgGNFB44zf143HENW1c1dvjQ/a6hOmQDTl61TccM0YslV02odpg/OWAxywON2a5o452HpQ/c6w64dCuf8TaSzP+driZUjqU9g7qVNLitLJCSKxtA7LtHlS+X81+ZavI9uemFKrmqE1Kzy9wN97lcfG+ZVvT6Nf3yOaIU+J/gAxTeWoCU4W0T1jEegCE6GTIRVa+V4zXC/XlCjzdcpr+IW+Dg54Z2qbHCwSOXXGvBk5W8w59+Y9FTxRGU/K/Y9UNBkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJw26s6dgLSO3kQ0x9us9aIeBiM477rveP+PoDnKS+s=;
 b=guNeQ4pTiFi5ASultfEDgtf9cSdN+JmxgMaSzu6Eg99HYK7eY+p/Yt0fIX+M8bhZ1gUvY5fg9U6wx1MGFH7Bz5cN6pZbGa0ycpurxLckIur6RVpfVP3oamDVhq876MNhtjFMI9Xko6Ctfn4hBV/a4WIiY7z8+CShf0kuXA7cS+9ccQz8dD6LmCKgj7wbrK97TBiPfFgdAQzVp7kSjxAAJ/eTKFazcuZSviGSvUT+gwtS5gUoY5clmi8puF6Y2xLOX/G+SKRDzOyS5IkhcrVHXiHo+oGYwDKtnMU5tcH5QxMDsKhKxCzqcH1ISOM8qQ07SyHb3DfwKP1TCXvCsuUt1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJw26s6dgLSO3kQ0x9us9aIeBiM477rveP+PoDnKS+s=;
 b=U+8VUMVTXp5teAdYoj1c4pry1QmmoRg3E7KQ6vRL99ukSRLAIbT/tpS2N2jx8ia6vy0SzsqAJh3Y1COxiP3KBTIn2V3jwlIkavwMBb8Qs6tGfHmLhZHyvk2rmcvvXId9+Bps3sPQwIl1rxSM4bGlEAI6pwI2W8pp4voADB6Jjt4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Wed, 11 Dec 2024 07:10:48 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 07:10:47 +0000
Message-ID: <893c7427-2d06-477e-8249-b5cf3ad22a11@amd.com>
Date: Wed, 11 Dec 2024 12:40:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 43/48] drm/amdgpu: add a helper to get the number of
 instances
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241210225337.75394-1-alexander.deucher@amd.com>
 <20241210225337.75394-44-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241210225337.75394-44-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f86d9d-0427-4cd2-b998-08dd19b2efd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cC85cjhDRkNveWxCYzFvYUVLWkZWZy90UHRUVGIxdkNnQkpsUFdMMlp2bTdn?=
 =?utf-8?B?YzZyL2JuaXhtemYxTnQrdUhOT05adkxHUFRBT2tKQUpiSWJmbUt2a0tvNUJu?=
 =?utf-8?B?dUVERWZwMTdUMkJsN092YkNaMVpkVEIxVURlWFVvSTJKVzI1em1FbzJURmd3?=
 =?utf-8?B?U2hwQ3k1VGN6UE4vWmdISjBJbjNaSjZla0xEcTNIdEprWEV5Zm1qZFM2K0sw?=
 =?utf-8?B?TytwNU05bUczMkFxaDlERXBFVEQwQXlXTEFGSHNWQXVBL3RKU0FtUGZqbHNp?=
 =?utf-8?B?N2V5WUZYNHZ3K0RNc2Zqd01GakFtay9ybTN5TkFGVlBKMjN0cFlpNmRUcENJ?=
 =?utf-8?B?TllhL2VXSzVaanhVKytmY0F0V09iQUZ5OC90aitPeThwUlp4RUs4MzQyQStX?=
 =?utf-8?B?TlFjQnJFUDJ0UDNBZzBObkpoRFBzVmI1SmZRZ3NYVGtna3lRUnF3QmVUaUlQ?=
 =?utf-8?B?dzJRWWhPaXovSnZTTmxLZXhyMC92dUtpL0tIVTJrU25tdTdUK1AvUml2Tk9G?=
 =?utf-8?B?SnZ4QVhLZXJkcDFiOFU2RXRRbzJPU2V5U2Z2S25LZ2lLa1Y2ZzVaNFNqR0xM?=
 =?utf-8?B?YXVzODZoQXdKMlFya1lFRWh4a0JiWGtncmlBZERIWnVFVmJPenMzQ1FabGdI?=
 =?utf-8?B?WVpwSkRhNStOcEhkU0tTNzZxc05VTTc3NmJYczZ5RTJ2aEh0THo3bTNwVTJR?=
 =?utf-8?B?enlQdXozWUJHbmtmZGNxcTNadSt0bDhHS0thV2xtRGx3TlZHbDZOYTlTSGpD?=
 =?utf-8?B?OHBGeWpWcEp6M3JWM28rVnhKK3VwTjdkdUsyUnBVSG1laHRaZnRQbEVnUHZJ?=
 =?utf-8?B?cENEaVd3bENyTE1QRDRrS1V2R1JBdjRUTXQ2NEI4UVducXp4ckJaTmxObHZJ?=
 =?utf-8?B?TkxyUnY1dy9LcEVDRk1jb1dJakNLWUREVGVEd3RGT0JaQ0RuQlFFZk96TXNU?=
 =?utf-8?B?QWc1andmVnkvRjBKVVlua2s0YW01UFpycXpua0FRbGFndSs2SDNLc082ckI1?=
 =?utf-8?B?ckN2VGFadTcvVkZ1a0FjY2ZNRmlEdkpKK0kyZUgyMlVIWEdaR1BxZ2l5cWI1?=
 =?utf-8?B?NjFqWS9pbUhYOFlxZkdaak5DUmFWNGVKazhnSUlJYVIvVEVMTlB6cGVDbUxh?=
 =?utf-8?B?NEEvMWt5ZEtZRG1WSldBZTdCLzIwbFZnUUFiYWNtUUtaYm15Tmo3WDdlTzRG?=
 =?utf-8?B?d1lpNHM3a3JLYU96V1BXQVdSOE1rVi9mdWRLUlZvMGF1ODFtRlVGN2c5Rmp6?=
 =?utf-8?B?dURZek5TaGx1eS9oaWV6YnhXVTlYMlM2UzhlRTFHclBiVDM2OHJ6b2Q5Sjkz?=
 =?utf-8?B?blhHNjIzTVcxWkJZMTlNZlN1ekFJbm5hMDZ5ZkVVZEZkYk5rVXVIYzBKdmdl?=
 =?utf-8?B?L0orc2xXaWFIb1JvSmlySHRBQ29wRkZBTlkwMFZmalhnbmloRTk0RzV3aHFa?=
 =?utf-8?B?ekluVHAxUnZDVFJONUtqVHhHZUFzMlo0YnZ1WkNhNXZURDVYb3BicXVLVXNx?=
 =?utf-8?B?L3ptbmJCYzhsT3VHb0U2MGNWM2hXYlYrdkFMNzJsMkQxRlNpN2lUczJrNTFz?=
 =?utf-8?B?MGJOYWNyYXBaTmkvci9iVkh6SGw1M04wUUticHIyRTE5RGRxZVdCTHhtbDBm?=
 =?utf-8?B?OHhabTVmVXh2Y2pmVDVtMkhVTk04OXRVQSs4L2hmQW1HMCs3cDBRNE1Vakkr?=
 =?utf-8?B?Q2lpVEtxWHZ3SitDNVF1MytaSnpxTHVxVFhPY3V4STNWVFBvR2pyMCtqS2NY?=
 =?utf-8?B?ZFBHem1WZEQyUGF0Kzk4MXNLOXRsK0puYS9iVnJINUN0NFZuZUFUb05jTHk4?=
 =?utf-8?B?bThwM3BLYW1tVkJCdnVYdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c01Dd2VEMnZnemlXRDBYTWZuT0MwZGlISC9lU0FDL1dka0piYUl5MEpEY2E2?=
 =?utf-8?B?aDZFWDdzWTJkc2lTUkNML3JTS2MwNkMxbmtoR0RITk4zM2hxV2NLaE16T1pO?=
 =?utf-8?B?ZnA5TFdqemV0cDluY2ZyQXNhOVJ2eE51YXkyWkxtbHh6V1NxWWhybVFKK1V2?=
 =?utf-8?B?ams4VUI0MzA5MTlpR3VjZzhGTUpLbkliNFpiL3FVYmhWQ0dyb1hLdWpLL1FS?=
 =?utf-8?B?ZmJpSW96aVVmVExxVVhpSEYwdUNsZHovSHE3a25jSjRjSEdkdFY3ZnAvZC9v?=
 =?utf-8?B?NzduWGRudVNXVGovQmhNR1IvVHpoUEkvNktkRmQwTVV1OXpObGkzYzgyTkpF?=
 =?utf-8?B?ZFoybDMyemsxNjFBVXdqT3kwMCtwMURvNnF6VlU3eGFiaXdrckg3ZTRLS3Bi?=
 =?utf-8?B?bzhZaFBpYTlZaWFuVGF4YmVMcjhZNERiYTh4NjlZTmJPejlEN2FER0VHeUlV?=
 =?utf-8?B?dEpwaGpqUFM4U1U3dmptZzhpZ1hSZ25Zcm5YMkdwVUlwUWhHVkFVZHF2UTNy?=
 =?utf-8?B?VGlsRVVrd1pHMDJyZjFsRDdmZWwxYWhnckdVY01OeGNhY1dOc283ZVdCK2Fv?=
 =?utf-8?B?SUpFOHNNSlZnKzhVd3QwV1REZ0pob2dzc3hIOVBoajRGNGg2RGYyZjZEbE9J?=
 =?utf-8?B?M3ZXc1NISGNOYWRDTEpNbTg1RkluWTRhNkp5MWQ1a2hFbEhWNkozaHdvQ0lM?=
 =?utf-8?B?YU1LNHZEUFpOMVp5em9WTWxuUmszTXRkU01ZTzltTnlMZ1E0cWV6dUErQndk?=
 =?utf-8?B?aGVDTHI1bDdTc2cwSjFHaXJoQUs0b3ZFZ0p1eGlRTVExempiQ2JmVTA4NWNx?=
 =?utf-8?B?ZHlSYjhBMVVKMDJRSEFEQ096ZEpTc0pOVEVrWlkxdExabU5aM3ZhUlJISDJo?=
 =?utf-8?B?aWJHb0hjeS93WElBV0FRbVRXWHlwUmFWRWlmc0hSRmc5U2k3anZvSjJVUFBI?=
 =?utf-8?B?RldMTlRWSTZRL292ekpneWlxTC9FclJmMWZoQ1gzM25IMlNtNGpRTDlUSzl3?=
 =?utf-8?B?aExGWmhHSmRHWXdWbEg4bGZoM0VsRzdKbVBGUzJkRnlXRWFESnV4VzIyMWQ3?=
 =?utf-8?B?aDZRUkhJK3JWK004c1djT0hFUUxlRW5UY0Npd3o5TEFIWUl5VnZqNEp6TVp0?=
 =?utf-8?B?bmxYMVJtU3hibGZCaGwyOEtyRm9lamtvZ25uR2Z6K1dBc3BwazR1OHBoa0xp?=
 =?utf-8?B?QjcvMTVzRXZvbEJmZk5vQitaUnNJbmhHdHFCSXUrcisrcVp5ODJMTUJQdVpZ?=
 =?utf-8?B?QW1OOE9CblRNN1VWWjBVRlE0eFdSakFwcm1WQ3dOamRCY2Q3amVySHBTakEy?=
 =?utf-8?B?aDRWekJHUWFqUzk4T0kxUTFydWxOaE4wUW5wcjJReERzT0w0bEpaZlpkYW03?=
 =?utf-8?B?TVUxZklaNDZzV3o0T29yVjZwczlGMGdJWEVWQ21ha0pQTmFxaVBrbG9XRnFa?=
 =?utf-8?B?RFZ5UCtsT1N1Y2ttN2pMcU1PUXdVVll3TFNOcDl5cVVhZ01JeXJjd0RUb2N0?=
 =?utf-8?B?THdvK1lPS082SXJXUXErS05NV21RYjd2YTd1Tmw5eTVUa3dFeHhuMnFHcWtH?=
 =?utf-8?B?c29naHpFWlRCSVpjdGRhWjdrUkx3eEtuM2R0K21wNHQ2TzR2WVdteDBNdkdl?=
 =?utf-8?B?NklrQlB1RUJjWlpBWWl3dnhraUovQTFRZGRHNXBVZi94R3NMcTZMcldJSEdH?=
 =?utf-8?B?eFJJVzNwb3lnOXhTa1FMekpsMUZwQU43YVNtbUdEeWg4ZDZtR2w3TjN1Si9Y?=
 =?utf-8?B?VW5CZ0pENTY0aEZhUldTTjRmN2d1d2lXb1o1ZktlcmJQOG1CVWVJVWxvSnJ1?=
 =?utf-8?B?dFRSbHIzZkpreGw1ZFVHckE0RS94NVRWcTVKMnYvYldMMm0xOVFnUkdYbWxu?=
 =?utf-8?B?NWFjcXJBNWN3WlpHanh3eDl6eUV4dUFSNmlqTkdQa1JZQVMrMXoxeTUrSGN1?=
 =?utf-8?B?Z0FwemN1NFNaK2h6MWlFOElvelJSd1B1MXNnbTVJbWhBUVUycjVyQVFEY1Q5?=
 =?utf-8?B?VHpjVXZtUjVERDF3OVp1aHM4RVF0TmNrQytDL1lQRWg5VEVnYXQ1VVRlcE1P?=
 =?utf-8?B?dFduUStMcjZIaVVQTEpmYThRVG8rejdnL1QzZUtzU05nY3R2VmM3dnk4RGRT?=
 =?utf-8?Q?K86F3ETnyLDOnMmoSjelPNWNv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f86d9d-0427-4cd2-b998-08dd19b2efd7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 07:10:47.9038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAOS6vlZ1wdjLC5s2VymHq5O4gIvMYsLYsFdvRqp7mlVaFYoO5YbGj60vrrw1K6W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771
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



On 12/11/2024 4:23 AM, Alex Deucher wrote:
> Add a helper to get the number of instances of an IP type.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 0ef598aac05c9..c3be17835f103 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -410,6 +410,9 @@ amdgpu_device_ip_get_ip_block(struct amdgpu_device *adev,
>  int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
>  			       const struct amdgpu_ip_block_version *ip_block_version);
>  
> +int amdgpu_device_ip_get_num_inst(struct amdgpu_device *adev,
> +				  enum amd_ip_block_type block_type);
> +
>  /*
>   * BIOS.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b5208a16d7d41..fcd8a1e8ae351 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2371,6 +2371,43 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> +/**
> + * amdgpu_device_ip_get_num_inst - get number of instances
> + *
> + * @adev: amdgpu_device pointer
> + * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
> + *
> + * Returns the number of instances of the IP block type.
> + */
> +int amdgpu_device_ip_get_num_inst(struct amdgpu_device *adev,
> +				  enum amd_ip_block_type block_type)
> +{
> +	int i;
> +

Patches 43 - 48

Now respective ip blocks know about adev-><ip> and use that in one way
or the other. Instead of a straight forward usage, now iterating over
multiple blocks to find the same information seems a bit too much. If
adev-><ip> is already abstracted, then this makes sense, but that's not
the case now.

Thanks,
Lijo

> +	for (i = 0; i < adev->num_ip_blocks; i++) {
> +		if (!adev->ip_blocks[i].status.valid)
> +			continue;
> +		if (adev->ip_blocks[i].version->type == block_type) {
> +			switch (block_type) {
> +			case AMD_IP_BLOCK_TYPE_UVD:
> +				return adev->uvd.num_uvd_inst;
> +			case AMD_IP_BLOCK_TYPE_VCN:
> +				return adev->vcn.num_vcn_inst;
> +			case AMD_IP_BLOCK_TYPE_SDMA:
> +				return adev->sdma.num_instances;
> +			case AMD_IP_BLOCK_TYPE_JPEG:
> +				return adev->jpeg.num_jpeg_inst;
> +			case AMD_IP_BLOCK_TYPE_VPE:
> +				return adev->vpe.num_instances;
> +			default:
> +				return 1;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * amdgpu_device_enable_virtual_display - enable virtual display feature
>   *

