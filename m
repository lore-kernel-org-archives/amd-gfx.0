Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96981C30653
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 20:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BAAF10E07E;
	Wed, 26 Jun 2024 20:20:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TVh6IMC5";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5831210E07E
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 20:20:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNG9CXLFXAUnvb/aGOZ1KgFwP0Cr9WDO0MzxvpIyu9wEGaJM3RrBJRjaQRLLChMd/yiSCPw0H8HEntNw17NuhX1wCHFdraFXTXJt6UepbjXGj+pgcH3JgjAbzNP9HGZth58zTfLJ61dNuI6tcgR+OIU2Hnc1km3QvMdNeMfn3FmDybOzaLzWnKciccnjch/PpXeJGKJixUPAty7JjG23p1a+vzBr4s66XqKhrccWCbP8F7iTyEYFJajOO4u+y83Yv7IFSR0aLb5D5BMIHBP5mycSn+f4nAv9Yf7cHNJ2CW3kanM2kEiI8SCTWSCPoMMA21vrcYYxazaNJThN/+9L5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmkN1AWRBZQWechO6K/STWPiXZ5cNzBG8s9KZsxQH+8=;
 b=R9XjQUgWUQM/vl2oy4GyOT0XJ3HP3HRlg8dzhVMC5sK8u2XrS4fX+4em3xitoKtI/Z0EvpvdWDZDfEXeKlmUjvYOEtbKBVsAroyZVcd/jonD934UkCqRPm6fwpfvw0aekN/za+I91tIslxBtczocPlarC6a/l9QxiG5p6uvgwqJAaKOz+Ffr+Su2PrOILSBX0UEjCGtCFfRT5JGSE4bJrIVfCP6PkcCmzqzC4a1I5WJIAtw+Lx4T+0FkWdaCI8RXusIz69j+b/TxWl0jQTTa9hYj5lRh04cLfXvS/+57hN0Gqh+YsYgXBciRS5UiB1ench8SgdHNzjfHWaD8LgWNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmkN1AWRBZQWechO6K/STWPiXZ5cNzBG8s9KZsxQH+8=;
 b=TVh6IMC5SCtIW0WdsuFu0TMx4NfH+5+lK9H+FVnS2zrE8JtAAfaxXglsONb/E8VNUraQA/K+6Di6Ga2VkbE0STjeibk4hgQ8E+zY1YNdDYUluHtp8BMmrhbRRamH5W4IQRVigajYAbtOGGA/EjkwiVh60jsmu1JglzYUo83xhGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 20:20:06 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%5]) with mapi id 15.20.7698.032; Wed, 26 Jun 2024
 20:20:06 +0000
Message-ID: <2031cc6f-7e86-42a6-87af-c7eab67186a4@amd.com>
Date: Wed, 26 Jun 2024 16:20:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] drm/amdgpu/display: add all gfx12 modifiers
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>
References: <20240626183135.8606-1-marek.olsak@amd.com>
 <20240626183135.8606-12-marek.olsak@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20240626183135.8606-12-marek.olsak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::25) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|DM4PR12MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a70bc50-d9e8-45c8-0a69-08dc961d5e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|1800799022|376012;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3VhdThYeElVSjVRM05PbG11Y25RQUV4T0Y4U1YyNFhwS2E5NzE0dEpkYzFL?=
 =?utf-8?B?eXF5QnFjQXhibmVDNG1sUkNZenRRQ21qRlphbERJL20rS3pJRkZITGlKNmt0?=
 =?utf-8?B?UmhENnZVQVVFb3pIMnVYNUE0a1JURGFiSng5a3haaDZlVVR6OVMwa3R4a3RZ?=
 =?utf-8?B?S1luTTZ4Y1VYb2JIREVnME80M2FIZ1lsMURDbEI1K0lzY0RWbHpuVTZCWWFK?=
 =?utf-8?B?cW5odHl4WEUzeklZcHpkWXRQMEcrNGhyaHlnSWJUMktnMThvMUlzK0cwTDVD?=
 =?utf-8?B?aDdoU2d2c3p0dmROYUs2d2g0Zkc0U1FjbVVab2dhY25WYUlPM1F5TXNORmNW?=
 =?utf-8?B?SWpJdEs3N1QwNHVzWVBJRzdubXNWdGdud2E2TnM2TlcwVHVMMlZYb3VTbkg1?=
 =?utf-8?B?TkZlSGRCTlRGNFVFTXJlTklXeTNNSWlEMllmUlladDlpVmp6UkhjTU5QMjhh?=
 =?utf-8?B?Y2NzVjBUVEJFZ2lqeUVwa0dPRE1wSTdjTy9OaDlzRUF4MENBa0lQcFZIQzhI?=
 =?utf-8?B?N0RHYm1hQVQ1QmZQek1nTFdYNG81ZVZyemxpMXc4cmRYZUFXWHd6cE05WVhK?=
 =?utf-8?B?QW1ENE9oMFVwOXhNNTVQdVgvbUxCWVNDZC8vRDlXamFLN216cmIzOGpFOGxE?=
 =?utf-8?B?dWtjVDg1UEI5U3FaZG1CZ0I0VGF0OVpMQUdFUVB1cDA4Y1JGOGdmem8xYXVP?=
 =?utf-8?B?MEUyamQweUdLYWl3bytESHBacmVMVmZyeEZGcE8vMnlraXhkcmpHd3ZPUlFK?=
 =?utf-8?B?N0N4SFdLNUY2eXNHSGxudVBiNUpFQnEzVmhWOEd5VDlaVXhIbnQ5clIvbURq?=
 =?utf-8?B?NS9YOUFHaGhGY2hwSnpaV0JBSXpDUjZmNERIc3JNeXZUVjFPS1ppTDV2SVBk?=
 =?utf-8?B?YUdFL1h1Z1AzU1RGMDdPZGpvOGo0YThoYkdpNk94R1VpT09FOWlJYjN5ZkRD?=
 =?utf-8?B?WWErT2cyeEh0SnFKaytMNVBLdmVnZmJJNnRPQVE2M3Z0RlByV2xuV1d4SHIv?=
 =?utf-8?B?aFdGSlRsWlpQeDlZYzFBeDBmSzZGcXhyR3lwVGJMMlIvNEdYYUFnV2M2Yi8y?=
 =?utf-8?B?TEw2OTVXN1lqQjR0V3ZpT0VJS001b1FoRHJxRDlVTTNocGVSV1EvR21BTldT?=
 =?utf-8?B?SWIvamdUbVdXb1Bpand2c2ZDSytoK04rNnNaTEh2b1c0TnY1cmtIeDlEL2NK?=
 =?utf-8?B?Sy9CcFlsb0sybk9lakJ0VTRuQ0w3M1FIZ0pFOFU4R1RxRVd5U0MwYzVyd01D?=
 =?utf-8?B?UnV6Vlp3bXNWd0dSSFdXZUErZzkzbEhxUWc1ZkFvLy9CYzBMbWVyMkk1SFpQ?=
 =?utf-8?B?S2VCODlMV09PdTJ3UFl1MzZ0NC9hTHRmc1ZLYXN6SVo2TmZVS0JUcG82WU5G?=
 =?utf-8?B?QmVFVm5pL0c0bkxsRStWcVpVNmE0bWtoZ3BnL2R0NzFtVXJPZnVRdUFoM2x5?=
 =?utf-8?B?OTJ1UmNpdlJERFZ5b1IwOXVlZFgxdGFwanhqMjB5UTl1a3lFOWMxVTh4M0FH?=
 =?utf-8?B?b25pRFpKYmdDTk5lRTNEbVQ2V0wxb3phMWYrekRieHZOYmtCMU5aNW1iSEwx?=
 =?utf-8?B?bnIxSm1sV2hEZzVNQmxSL2NyeFFCY2kwYjFIUzRrR3N5OTJNM0FRb3NlOUI3?=
 =?utf-8?B?MjYyUjN0ZkNxVmVRTVp2S3JUKzdNUEZ5OEtVN0VGbE9TM0szY0VIUTdXeko1?=
 =?utf-8?B?RTF4RWpWcllmd0VnbjlkTkh5WGpSaEU2Rk1qU1RZT2tnbHdJd3FwR3hyR0ZB?=
 =?utf-8?B?VkU1QitHTFE4U1VUSE5UNjFEMi82UWR5ejFzVCt1bTRjZGRyZ3hsYWVBVWNy?=
 =?utf-8?B?WVBHdHhHbFpBbTJGb0Ztdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230038)(366014)(1800799022)(376012); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGI4OTZqU0dHYXpDcGlsdFNpcnU5N3RJRmZTbVEzQ1RKdHZCcExkdEs0VDk5?=
 =?utf-8?B?R0x3bVZhRXdKTUlNRFZhU2FMMW5hMmMvU0VISVNlT0UzYy9pSTdrQ0ZvYUxh?=
 =?utf-8?B?dHk2REppeUZhNVZpaTI3K01hemRBeGtlSFBWWkd4aDd1N1U0c3NhVHJkNXlz?=
 =?utf-8?B?Rm5hRkpaZ2xTNzEvS3VGUThiWUgyd3hMOTNUTnp5SDM2N1J4R3RCNEpodDlO?=
 =?utf-8?B?Wk1aa010bktKUFpoUTNOeEVtMVliSy9Vc3Z4dVQyQ2kzS3h5V2tzd29Pb1Qz?=
 =?utf-8?B?WW9vK1lsQ2ZheHJDR1BOSHRxK0dBWnZrSGVIMHFIaUhpWXBYRzJrZWxRb1A2?=
 =?utf-8?B?LzNYQzNDMExUTmhkUkxFQ2VJN3VILzJzaWxVZkNNWnNsYW1Fb2hSRjdXSmpu?=
 =?utf-8?B?bEZRZHVqa2U3Ni9IOC9wVmxLblpPSFI0UkVkV2MvMkJ1clV6UDhZVXo4eE12?=
 =?utf-8?B?cTFMa251WkVWQmFBeWtTR1ZJWVhiMGFxTTNZQk13all0Rk45Y2RVblNBQlJR?=
 =?utf-8?B?UXpDZ0V2c1ZzakxsdXdyQ002bjNaZlFWNWk4QVhySzFtUGZIUjV2YW5OZkY3?=
 =?utf-8?B?MUFtOFRtR3p3T0VWaUpFZzA3Rmw5c1ZZSlRrano2c2I2ZkRPSnJoQzNIbFNG?=
 =?utf-8?B?RkNFcEF1U0RWV2gzaVBiaVdmWUZBSlp5a0JJK2paVDNaendLNEtLM1JSeDdx?=
 =?utf-8?B?d1IvL1ExK0twZnNxZGR4eW9ERmViS1l5QkQwakc5ZTZPSU5wNlQyQTlwMDEr?=
 =?utf-8?B?S1JTTzE5MXJPYVY2S21GZTJMT2NlWEpDWk5YYW5uUERiVXpxUWZTNFNQRGhq?=
 =?utf-8?B?YUtOSDd3WnJyZy9jSklocnB0S1ZURkZtMEgyYWlpL1ZVTGFvZU1maHFsU1BF?=
 =?utf-8?B?TVZhcEZFVHFMVlVuNERZcHRLaHJTSVBscERyaSt4TGJoamhQYXdzbUN2cGFR?=
 =?utf-8?B?MS9hTDc4OFFtUGpNRHdvTUtyYTJEMnl1UmNlVmFRcnZjS0NuZE1Va3ZKWXd2?=
 =?utf-8?B?NEplQ2JUQmliK0IwUTQxVmV1bStMV2tVZDFBNkZveG50RzVEVWNJL3pNU1FC?=
 =?utf-8?B?UDJxUGp6VlFIV1ZvV3VpOVVPaTk1bFJNRFBZdmdvekgxeW9TSlE0UW9oVm9n?=
 =?utf-8?B?NVBxZWE3QjZPd0hIZ01BankxQWRhbVRicWoyNW5GUFRSNzV3NWhHRkcyQkhu?=
 =?utf-8?B?NFhKUGxCT2dxdDJSQXhtc3A3dG82OG5pWGZtNjR0UG1DTE1mYkVYVzlIa1hL?=
 =?utf-8?B?N25iaUNBZmdTbkt0SWQ1emJ4MXdvbzF4WVRxQkpiN1lscHE0M1plakVJQysz?=
 =?utf-8?B?cFVhZTZOMGd5OVdGRTdVM1QzZVR0VFR2OHY5d21oZ3JqVHlSbUNEOFowZU5s?=
 =?utf-8?B?dHMwTEZNVVBIUUpxN2NuWVJXN0dGbGpLRTlKUCt1RmlGWlUxZGl2QlVJc2NR?=
 =?utf-8?B?aDBSa0NFdHgxV0NwdEhtaW5paVhEYlNvTk9FZXlvMmsxVGErVGhJQjkzTEdI?=
 =?utf-8?B?TUxUM2hPeDFsaGpXMFRlQnpBeVlkY0dhelZUVXQzd0NUWjR6bVU5UVNpemhn?=
 =?utf-8?B?ZnpUaTVBWCtVQk9kRHZ0aWwvc3B3NklsNisxcjRjMjlDeFhHak9sZVoydWtV?=
 =?utf-8?B?c1hzTVFrWUZiWTVGdm9pajJSaGkrU2o5WTV1UjBhV0NRTjk3c3BxenVHWDlC?=
 =?utf-8?B?bjZNV3NMT0V2Sk9JM0dmR2xlNXRFZ2tDdWdDOUpjRDNYNUx1WGF2RDdjSC9j?=
 =?utf-8?B?QXJCTjNJaDJsYXA2SlpxeEJHVVA0S3BhdjRmc1ExcFpCeHgzb0toMEUyUFUw?=
 =?utf-8?B?dDRTS3lNSnYxbHQweFNkenpGcjZ1ZUZBMWZ1dXh3MTJydHZLemNOV2JiUHpa?=
 =?utf-8?B?TnFwVnREdWhPUTNaV2xodHVOUndBb2J1U2xJZVNxRDZqM0x0dHlFdnlQVXNH?=
 =?utf-8?B?TDFvSHF6eFBVOENXNmdOK0xBNWdnWVhHeFloR21RQnliY3pMYU9CVy9jV0dz?=
 =?utf-8?B?OEIySXQ5dGtFbjVzZVBld0lwbmVOeUJtRk9ZaHNUendEUEljMmR5Z3d3NXJL?=
 =?utf-8?B?VE5IYzZneXBkc2h2TjRCRzhOTklHbWUwY1d0WjdSTFdNdWIwc3NabGUrekpI?=
 =?utf-8?Q?lOIzRunacoTcbOkW4oA156n8t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a70bc50-d9e8-45c8-0a69-08dc961d5e55
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:20:06.1821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4B5u3DA6i5VQ3xBI1moo63ucnPC15Z/lobg5/RRkMwbYBMUEoR4ai1k6ZB6nLKsChEkRhaYzw/VO3iZ1KpWcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937
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


Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

On 6/26/24 2:31 PM, Marek Olšák wrote:
> Signed-off-by: Marek Olšák <marek.olsak@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index e13938e01b70..0320200dae94 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -688,12 +688,13 @@ static void amdgpu_dm_plane_add_gfx11_modifiers(struct amdgpu_device *adev,
>   static void amdgpu_dm_plane_add_gfx12_modifiers(struct amdgpu_device *adev,
>   		      uint64_t **mods, uint64_t *size, uint64_t *capacity)
>   {
> -	uint64_t mod_64K_2D = AMD_FMT_MOD |
> -		AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX12) |
> -		AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_64K_2D);
> +	uint64_t ver = AMD_FMT_MOD | AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX12);
>   
> -	/* 64K without DCC */
> -	amdgpu_dm_plane_add_modifier(mods, size, capacity, mod_64K_2D);
> +	/* Without DCC: */
> +	amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_256K_2D));
> +	amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_64K_2D));
> +	amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_4K_2D));
> +	amdgpu_dm_plane_add_modifier(mods, size, capacity, ver | AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX12_256B_2D));
>   	amdgpu_dm_plane_add_modifier(mods, size, capacity, DRM_FORMAT_MOD_LINEAR);
>   }
>   

-- 
--

Thanks & Regards,
Aurabindo Pillai
