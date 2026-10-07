Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC0ACA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 13:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6237D10E5A7;
	Wed,  7 Oct 2026 13:50:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lxuVfe/V";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012066.outbound.protection.outlook.com
 [40.107.200.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92B3910E5A7
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 13:50:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zvmu8VD+nEzQlwALnpiUK386C/LrkTTHBDX4acZVM1NDZpbAg2SOadBXwm5Ia4E4+jLnAFXlNXTkM1Wflmoxm42I3d5trQuTsyB99eTBS8sfwGZfMYqeuF7xnHzl0zN6HlnjfSFc3ITl3iYxUKTTmzrWD2jeX78UQIP6zPGONRegqBYO4rQMllOoVATusU6bQ7kKooj310muRZVXY2GeT2kdYApBJ+gyOoFEHIyHfA9XrqkAgm3G+5r+aPYJdwabXQPesextyf8QsCEDXv4jfACe7xUVSuYnzdcNM14AX9ixyHQaPxDxmm2vrlO5s+0pjllfdaBEDCkr9JZW39qCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLji0S9+e9+N5hSSAS+yt+ShHJKTsxGOEzDuwc1Owms=;
 b=xX2Q7HlwTKuI31FtHiZujTiQjGdQWdlHLcI9PnO4pV4qhdF1W+56T17HuJ9cIftzwy7A7lvCi/cDvO3SgM4bDj8j+tZhF7jgAvP/rKvIVBfQowlW/kszDoAXjbgg7J2afKj91UJUWaEX2Kd0bFjJbbJ1qz1Lurcui7IOvG8ejI1olglabj4DCv07+riO3Ewf+jEuuDPcsb6AAEUu8PaaWFOGiPBcjLwNEQhs+1l6TJEQWA/1K7Gt5VlAFjOyUpUgZTV3L63j+WI/4gZ+2FSwEESxZTYNp+IKReGtQSf+wzqkJWWStaG9qbRCHcNBb89phfYCqeEUpX06sGVW1eu3tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLji0S9+e9+N5hSSAS+yt+ShHJKTsxGOEzDuwc1Owms=;
 b=lxuVfe/VpG2oIXqVUdwhFKAgKd2e7s93hB+L8GlySBM2r/NhLcMwQfpSh+AXAnVaGOeXstqJxBy7kL1xzIY5HA+hw6D0ZTvvl3XUjcKjv/ovAOyQ90fY7ZUaM6aNn0ZhiVItWcpk8MJGV7SYiKBfAO+fQS/n9Oz6jBkxDXl4Jbw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CY3PR12MB9704.namprd12.prod.outlook.com (2603:10b6:930:102::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Wed, 7 Oct
 2026 13:50:34 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 13:50:32 +0000
Message-ID: <deb0ff06-fcb5-4d0d-9cdd-ade4e5b83f2a@amd.com>
Date: Wed, 7 Oct 2026 08:50:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/uvd3.1: Fix checking whether UVD firmware
 keyselect was already set
Content-Language: en-US
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, David Rosca <david.rosca@amd.com>
References: <20261006211607.75407-1-timur.kristof@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261006211607.75407-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0849.namprd03.prod.outlook.com
 (2603:10b6:408:13d::14) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CY3PR12MB9704:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b80391-d073-4fa6-da05-08df2479f4ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cYbAId52Pj7xELmAqtr426pMtnfAme9Ik/KfQzqsU+RSAeeMN8dOKgHyZr7T2jlzzT9D0VXilENFy8GzLe/rHS6EeNlQmIYrDpZlSYL03Uir7/25J6r7sJg+GnwbZ7DaXXfsJIz55ekgtEztfkM8h1sn5MEhdy/l9QxHH8LGu0Yi54lMSgaWhQJrvI28M5agCglfB6uUqltA2ibtBsGJhkYfo2hsfNoVjcKL3lwTQbT/Eac+5hokBE0yd1AM6AUUWDH3/z270A8EzQ6F9FjuahzQvYRstTkatBnGD/d/UT50o7tRDScZtOez+q5hSMyscc9qYINZ8r3Kx+ljyv/Cpd7Jkdi7hwGZgm/zP2227FyxFvq1MI2D7I3/+j3aoNOA/V0LWh/cw8TNhou5VDBlrbkDVVdaokHGl5mM/aY6h4NRHwBlF4R5KaARNblJ9UBZ+YC1d2fOT1c+RN6orIPXM6RvPozjBFcUqLknfptf2HBZi9bw9kwXlzMY+mR3pkji4cpTjXpFyrsvRnq3VW6S627FIwoyybsNQRK/YwO9Ja3YtHpYyMnXQzDe/65ChhXa6D/AjIcZho4gobZ/bR4bvn4V77YqCZoC+jpB87VpQu4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTBGN3pTSHpzRHF2VnNZK0tuVGpqeWt4NDE5VExxRnF4ZHhMVjhPSTlGZWRQ?=
 =?utf-8?B?K2NjdXJiSnYzNGNQWjYzVzh6eVhwZTdvUzZPN2tiMFN2cXJIMXdYRy9IbzBx?=
 =?utf-8?B?Q3N6aEdVUTVGWis4VU95K2srdkpwQTRHSFVZSjhnNEZWVDBGUnkxQWVGTElo?=
 =?utf-8?B?OWNQRlpVUzZoOHpVRnJvdExnQ1FVSFhvYjBxRThhUk5PMXk5bTZDem5Ia1A0?=
 =?utf-8?B?MlVVdE53M01iaFBua0hxZno3K1FaY0VIZU5XYU5BTTkzdGpYRXJhZjgzTWxo?=
 =?utf-8?B?WXE2Q0sxSG5ZZGtNdkNueVFlbXEyOGJ4UldkZVdMS0VLTEMyNTNIdFpUdGhK?=
 =?utf-8?B?ZVFyUlg5UVd6cm1MWG4xZDhaQnROOHNFdmVxd0Z3OFdIREVvbVlmTHRZb3JO?=
 =?utf-8?B?N3ZIcUdnelc4Q3B3emNuSGdmMkxSaUJldTh4N0N2cUpTWldmTTMyUm0wQ0xi?=
 =?utf-8?B?QUErMVN4bmI0VlZKQ2ZuRWVCcVo0ajIweVVtNU85RkRRSGwwTzArejdSVmhI?=
 =?utf-8?B?M05ZbW1YMVlvaXNlOUtYVzNQQzBSWDBSTEFieFFwZU5la3BSMEk1Uk02R1N6?=
 =?utf-8?B?Z3ZKZllGNzF5RG92cldGRVBqYnVjY2UxL1UwWU5Cd2M0cTRxdkFEdlZERWlz?=
 =?utf-8?B?VnZITjhtQXg5QVBSbk1FcHdOVWhKZlM2T0x2RU5zMXA3bnoydHVJVFZPOTJR?=
 =?utf-8?B?L2RvdlBVVFU2aWVIVUV0YThRWHlMOG5HdlU1VXl4d1orOWFFcTdVaDVoWHhB?=
 =?utf-8?B?NkZNWTJsZFJoZlJlUmdSQTFJZTkxNTZqV01FY3dKb2psbjRDRGpoekpzWGI5?=
 =?utf-8?B?bWdvUDZnWVpmRjNLTUdMaXIxcktJT0VCNE9JcUNKaktLdGY1cnE2dm9Jb2N4?=
 =?utf-8?B?WkNiVVlGVFdMTEFQWmY0SHNSeXZlTmxkWjJmVkl4b1NHQUNZcHYzaWhNQi9P?=
 =?utf-8?B?SVM1cWl0VzFTNUI4bU9ST09EOGg2WnlYRVBVL2ZpVTFwOVIreEJQYUZ1eVJn?=
 =?utf-8?B?dklNczAzSi8vQWFlYjJSRXFDeEszUVcyYTNkVVlzQWNJc3RvVXZMN1cwTVJJ?=
 =?utf-8?B?YWxiVlZLb3llRStmalhJQmhzdXVZZTJzNUtGZ3VmZVlqMmdFRWJNMnozUk5S?=
 =?utf-8?B?aWhRN1ZnYmFPdndjSGUzZXpyWFJQdmI4Lzl6L2o5bWllRGlRdjlZVitBcWVw?=
 =?utf-8?B?emhxbnRBL3orWFhRU3BzQU1Ka0RXTGNLWWtWbmRTdTJYb3JDVjZ3ZS8wRDFG?=
 =?utf-8?B?WnVLb29zOU8xUlBEZE1GNWI2RVZIK1pYWVYzckY1Y1NEY3hBVlRGcjlMelNv?=
 =?utf-8?B?WkVkU3JEaEtYdjUzTUxORHRNRTNrSDZQblBiR25CbFluLzFvTlU3MnpiRFhE?=
 =?utf-8?B?dXZvbWVIVWM3TmlldVQ0OHBIQjJzaEowMk0rQTQrdFF6TzlBZUdDSitrT3BK?=
 =?utf-8?B?Ty8vbXh4MDRRNWEvVnJVQWNDZ2cvRFBwdEVlQ2ZLczZjd2RIdFpDOFo4dDEr?=
 =?utf-8?B?ZGpPNjVNa25PUm4wMitpOU5rNlNUVXV4TkVRSUhCMmRoeTRFdTd5NEQ5WnJx?=
 =?utf-8?B?WFZtNWZCRmVvcTM2Q0lHeFJEOUxTWHlZT1I1WmltWnVDVGN0QStac052cDhj?=
 =?utf-8?B?bXlXS3Q2eU1reDY2Rkd0ZVFEbENueXZyaGxqRlk2cjJKSm5KN2NldWt3Qjg4?=
 =?utf-8?B?OEpYWGlZN1U1dTh3aFcvVTRsZmVlMmVnVGVOeUtSMFNzWjV5U1c1U2thWmYv?=
 =?utf-8?B?ZHR3L0hiQUpMWW9Eck9zaTJRY0ZlZ3NNdFRkRVE0dGxkaTFQVGtnTEcyN2tY?=
 =?utf-8?B?c1VzY3hZajRURXBEcjNESWlHUkdlZk5WeUZ0ZkFwMUl3OTNjMGxWQnFVN2VG?=
 =?utf-8?B?Z0pZNCs5Z3JtYzJ3WnVwNG5YOXhsR3ZvUmdObFJSVFlHOXdJbFllVGFNQWNl?=
 =?utf-8?B?a1UyckRnc2VmV2dyblBiUnh4R0E2WXh4aXZxRjEya0RuQ2pucEpPNWFoV2h4?=
 =?utf-8?B?c011SjdET0ZoYnQ1disvK1FUVS9CV2tLRXRTeUtZWlE3enVkS2d1T1NIdDVP?=
 =?utf-8?B?WTNHQlVKQklCdFRUaVpIdUZ3bHFjVjJ0Zm4wQmRsUzZKTGUzb3B6Wjg1NXp0?=
 =?utf-8?B?aXhZTXNWUnlUa3pORTIzem4xNndzY09WblNtcnREdkJoNUQwRGtWK1luQW51?=
 =?utf-8?B?NGhtNlo2NVJsN0RtVWM1d3NmemhUejNzWmJPeW1aUW01MGZuOWUrZ0VzTi9R?=
 =?utf-8?B?bWZmZ2xRbjBqR1VWZDRKckg5YnU0RWc2eUJQNmlCN01JMWJJdk1JZDQ3dkJR?=
 =?utf-8?B?bCtTL1BNUUcvaURYd1ZjaGFBayt3ZFVIdmovS0pXMWNkSWoxK0hOZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b80391-d073-4fa6-da05-08df2479f4ac
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:50:32.6502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebh9aC0DCiTmCbkuaZm+cSu+HxRw5EcAUpjYYfY3KhaLnNKGc607ERKji/1v1sRrCcquCnsv61meniPYdKm3Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9704
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



On 10/6/26 16:16, Timur Kristóf wrote:
> The PASS_MASK is for a different register not for UVD_FW_START.
> It was a mistake to check this flag. It should be enough to check
> that the register is non-zero.
> 
> Fixes: 13e4cf116dbf ("drm/amdgpu/uvd3.1: Don't validate the firmware when already validated")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> index b72a0c34425a..ff7128a11cad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> @@ -288,7 +288,7 @@ static int uvd_v3_1_fw_validate(struct amdgpu_device *adev)
>   	int i;
>   	uint32_t keysel = adev->uvd.keyselect;
>   
> -	if (RREG32(mmUVD_FW_START) & UVD_FW_STATUS__PASS_MASK) {
> +	if (RREG32(mmUVD_FW_START)) {
>   		dev_dbg(adev->dev, "UVD keyselect already set: 0x%x (on CPU: 0x%x)\n",
>   			RREG32(mmUVD_FW_START), adev->uvd.keyselect);
>   		return 0;

Can you have a look at the Sashiko feedback:

https://sashiko.dev/#/patchset/20261006211607.75407-1-timur.kristof%40gmail.com
