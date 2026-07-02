Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F26CC43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 10:35:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3068410E47F;
	Thu,  2 Jul 2026 10:35:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FWfFvrh/";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011048.outbound.protection.outlook.com [52.101.52.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C900B10E47D
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 10:35:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IyuUYZ4xa8U6sMV2wIC0gi/KOXf7aS+2lHB0Ypox3RDV8IHbmM2GkS5iP6wsftZ8Od0uj2TNV4UrxutXWuxYj/QQLPsAhGDWlNfi/4VtcUz5E3yn1kqnOPl1x/zvutp1lBZPQairIw7tHQnOtMceVCCqWRzmYSvZ6bNOftk1FK+adcVNN/suczb2NaOMWzMt04dv+QHHHWA/m5V7fspra2LRqJHNCHV1CZiFwUz0eD1GgdmmyY4CShZKn2omtFe6++4tSYjAVX7kmO+x5xI0HBEKp+N92v9embfjOY1gzBBJvLzy+j+/zJU4x8GLMCawRBC1N3jayVAXuc6aP9eFWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjZGT9yhzdDKV+7drwG34ZntV1wwfu//tOBuYm9sRFg=;
 b=EtFos6+6jDIcr3WQ75PEjcAFMUyRekaMQluuyVmL0Q7cvo1C5NUw9uiIXQLafvGliEbDKxKfqvMRF8Swj7cAanwwWje6nrPQl2iXNbsCDKrXJCjvQRG0sahynyhLVsnJxZqRx00OcMbFug7VrGxI5Ug3P7eUemGPyw/mXkUMEV0IdAEeTCxtoTOAKalC2gZ66bHNevK+3/uVlBfh5ZoH54OMcubsP1Gwsk12xuAMvNKuaLBdTMlgI2riLAuRKhM32FE4yta53V7H27+mwwqw12BQ9Pl8ju4wjNw+v8X/YEe3fkiOcJMtBVxSd4zEZw46fjt5aN49j8zIP7gjcRKdCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjZGT9yhzdDKV+7drwG34ZntV1wwfu//tOBuYm9sRFg=;
 b=FWfFvrh/Fv8E65pA98BQameow5PhJ1RotsUJZ2Imd00KCbgfJIGsSG+yLNNQfJALe1Qq2hkjuFogXP8OKS0w1ye42y5I0K0a7luEZ9Q27iowoiYigqIgUEWZn7hmSa2eNaj4j89HiefXrw+VKBGh0dvasoRVg5S3ozZElsUqVuM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 10:35:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 10:35:31 +0000
Message-ID: <a53c33c7-5cb6-4b9e-875d-289c0b01e7e5@amd.com>
Date: Thu, 2 Jul 2026 12:35:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] drm/amdgpu/ih6.0: Enable retry CAM on Navi 3 dGPUs
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-14-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260701161721.85681-14-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 0316bca3-cbaf-4bd9-c310-08ded825a44a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|921020|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: tcXTpPcX9h0tYs/Ra2mFpMN7RR9TqtF8K1y9jsfFZrtfBtn6tX4YiDbJreWKKS9W3yKPa8mH1F9Dc850B0Mqac6G0jbH2T2+jtoTJkzCky45FeUAcXU2LB6+wLeb3jkab0fhahW5sITYtLNn8jpNaav7Uot9h1o0pC7MSiXxaGI98PIDsQc5IUY2E2G84BYL96Gc4K31l6IXdOf/Bh5sKUvseM1kEUaym1dsvYHc3HtLhzHPJcMNr805AscNYcPcr5b0Ktq5jiDIPEUWvO5Ot7Eh26Vt6quxK/XC8E4pew0syxtpgPV1XxSZfKTJUQfUg+QKA6rC9OUfAcNbCoxp9XMhLeXxOmKCX/kuqcEKDgqCV2QVxYYZNIkYoL1U6ZZJDGugC6i0BTWkd07o3exulYpdUpEoSDZFZCNFqV9B0g3bmVVkQHnQg2zKcLvnzp9XMwZqhGXxnMBiYwPYFiiiYXhlHJf9wVdiDgEjzW1+y/SzXGIZG4PqrTdA7AeMJw+0wQcg6DFc8yoz1OC4FoM2SiPlLcUg9qByIgzZEwswdD4OIn9xM0PnmltGJj0HMBHMizmRxNBqIB5PRnbf9xXGQVpm/u6nyEx+SWKvhis8NmHVMJkxukkhKK57Xbtbaq0whCBt7kcO2J3HXuGcK29MLFwlKa2m8jyBG3ldhwOIWkrmjKZHQkyHxRUddwpsVP59o8Vej2ZG7JCJoMMbTwoqQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(921020)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXpOdWlSSEo1ajhwS2RhSmh3elByREFOWjdvM0tSUEIvdXppQmRNZmFOWVJX?=
 =?utf-8?B?VlNGWnpGU3JuYjNyb2hwalNpQXNrc29wUjk3SG55eE9Rb0pZT0Ryb0lTRGFs?=
 =?utf-8?B?bVg5eFNkZHFXTHAzaDZWZGlXNlllVlcwL1hJRGtMUG1jY2wvbzdiK1NuQ2g3?=
 =?utf-8?B?TExuMzF4Y09Wd0kvU1pjWTAyaVpkYkE2RnhNVkkxc3pERTEvNFpjcTNOVm4v?=
 =?utf-8?B?N3VSUUx0VC9vTW1EcGZrS0ZLVmU2bjZkZ0hiTlFOc2VFUWQrZWtEYVpJdm1S?=
 =?utf-8?B?aTBLenBBSVFodUZPNHdTNDIzblZxaDM1V0NWNmVuNDZPOFdXSUJEdkI5OW9a?=
 =?utf-8?B?RUFHS2trN2JBU3piMTYxS3dnYkYvcEtDKzFOcjNPR3lKaDkrQTRIQ2NTWnRH?=
 =?utf-8?B?eFdncHduYU5ORk9YaWpPd1l4VDJ0WXluNXR6SXpZUlRSdE5ML0RMb2NoOWsx?=
 =?utf-8?B?M0pkM05nVEZrRzlJUXAyMW5FL2xxRStaSW1SYmJ1L1ZJMXJOaEZjcFJkb2ZB?=
 =?utf-8?B?RHJFSWZJV0ZGMURWb084MDk2Z3p0cDVMcjR1YWlxanpVdnEwYjlYQkJRWkdJ?=
 =?utf-8?B?dW5MSlJFdnBCenN6VFVJcVVIVUlwVTV3V01SdDhVTHRUVXRFSlNGM2h3RXV6?=
 =?utf-8?B?RTBSb2VIME9iLzg0a2VTakg2SFQ3dE5LdUpobmYwdlJpVzFRMnNtZFRvTUcw?=
 =?utf-8?B?UGwvc3FDd0g1M0E3MkY3dEJxMXMrR25hOUlCcnoyR29mVlJ0NWdJSkRPbXR0?=
 =?utf-8?B?VDQyQ1BaWGk1SnFrMlpoNzJiRS9CRjF5clVjcXRhQnIvdTZ6R245ZjJuWUhs?=
 =?utf-8?B?Qng4aUtzeDlSczE0VmRRa0huRUx0Szh5b2NLWUdZRk15VkREemFWWFNFZU9R?=
 =?utf-8?B?QXFzaHl6bis2Z0xrbmZ0Z050UGdNSU0zaHFXTVczdHpZOUNINlQvb3NSbGNa?=
 =?utf-8?B?MWx3Z24xQVZnM1R6b0FRY2phbzEvOFVDQXZDQWUzczZ6MmFiTWxWaVM1blNN?=
 =?utf-8?B?SUhOUjMxQXl1QVhVbmZoZ1ExQTl1azM0Q2VJZFJaL1FqQnJWL1JGaEF0OGw4?=
 =?utf-8?B?ZHdmb1ZlRGVRWU9UM01vdVZocVlobWc5UDlTN0pKeFBHTy93T1FQUkVoZGF0?=
 =?utf-8?B?Z0hlL25MWXhXTHNwVUdRa3RzaUFUeGVGamJHN216WWlLK2JoeGcyRFI5SWVi?=
 =?utf-8?B?R3dMVlZ5NmkxTzdQaTdzMFl4UE54ZHFZRFVjVnlha3hFNTkwSi8rTmU5RlpJ?=
 =?utf-8?B?REVpVUxIYS9QQTJ1SDhseWh0TFJvZzRFdVZxRkZvWXJpWGZBR0ovS3NtVUZx?=
 =?utf-8?B?V2s4VkNzcG1CcHZvUGx6c3lIZlpjK1pQZER4aVhjSDk1WjJjOFJoOXlvRmJ1?=
 =?utf-8?B?M3REa1hCRThRNGVpd3dyc3hYSU45SCtoWDExWDN0aXZVTlUvVzNpYUsrck1Z?=
 =?utf-8?B?NTNlMXdlWXlrNWVRWTJPL3FmNXRkTS9ERlhtVmxoSldWbzAxcnNyY2c5L3Bs?=
 =?utf-8?B?N3ZDWDU1NTBPbllqMm45TzlKSXREOUZ6N1RPU3lsTXgzRmNLTHVvUUFCbmxM?=
 =?utf-8?B?V1pXdFlQNyt1Zy9YbWY3d1R2cWx0cUFCc3pEeUVKaVAyN1dQei9GcjNCSVlR?=
 =?utf-8?B?bXJhRU5NQXRreEZqRHRIUldDeHR4OEs5TFN0bm9yWGlEZ0FSYlpneUNPL09q?=
 =?utf-8?B?ajBoTFMxNDlhQlRpWWZTUXVyTkJsUEE5RXQ5b0NlSkt2bEpvd3hhQmZzNUE4?=
 =?utf-8?B?aCszeGo3dmdOem1DMkNLUjRiWmUzeXVEWEd5cGVtKzlLZjFTcmJOL1hRRW5j?=
 =?utf-8?B?WWU4WTl6NXliTzZLRlZtUm8zaERQUjZXbHNndHdxVG5LUUlGdTVoMFRnb1dZ?=
 =?utf-8?B?NEIxZ1BIM3pNUDRtQVN3c29oYVUzMUpFSVJZNzhpQ2lySXVEMkVtZk84RjZx?=
 =?utf-8?B?L1hvU3lsc29jeFFSTGRLZEZrQVV2U3Y3dlJYY1h5SHNMMkpDVHZSdmxBZnpR?=
 =?utf-8?B?YUJHU0JqZ2RqVURzUnAvNXdCNDAwcC9vVWJYcDBDbGdGY3RSOXNRcVBtMk50?=
 =?utf-8?B?VVRnQ0l4YTRBcW5SdXFUWDNVUThkNjY5cUpkcTJUQ1B2UGttUkw1ZjBiS1pF?=
 =?utf-8?B?VnRyNmZkSHB6S1JvWVhGUU16Q2JLMERyMXhSVHQ5b2FoSlA2M2NnREtXRGlp?=
 =?utf-8?B?SU53WmlXdVF3a1JTeVRDQWdTN0xRNlFRZkhVNG5ZbmltZkFPaU9leG96blNp?=
 =?utf-8?B?MGhSU3dIcmFtbitObXFWa29Nc2s3eVRPLzJNeGlBdTlYWElGNDdZYVRjRU1F?=
 =?utf-8?Q?oNWE7kMircP8KKpnz8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0316bca3-cbaf-4bd9-c310-08ded825a44a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:35:31.7057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4KcGsk/KSv7+DexjLvAIPIcCcJ0SIqPJprVPKh+we7L0UOWZJ5v+JzoUEg+0RL1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
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

On 7/1/26 18:17, Timur Kristóf wrote:
> The retry CAM can filter interrupts which occur repeatedly,
> such as page fault interrupts when retry faults are enabled.
> This makes processing those interrupts much more efficient,
> because the CPU won't have to deal with processing the same
> interrupt repeatedly.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> index a97c85b0cb99..bbe399f9e233 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> @@ -397,6 +397,16 @@ static int ih_v6_0_irq_init(struct amdgpu_device *adev)
>  
>  	pci_set_master(adev->pdev);
>  
> +	if (!(adev->flags & AMD_IS_APU)) {
> +		/* Enable IH Retry CAM */
> +		tmp = RREG32_SOC15(OSSSYS, 0, regIH_RETRY_INT_CAM_CNTL);
> +		tmp = REG_SET_FIELD(tmp, IH_RETRY_INT_CAM_CNTL, ENABLE, 1);
> +		tmp = REG_SET_FIELD(tmp, IH_RETRY_INT_CAM_CNTL, CAM_SIZE, 0xF);
> +		WREG32_SOC15(OSSSYS, 0, regIH_RETRY_INT_CAM_CNTL, tmp);
> +
> +		adev->irq.retry_cam_enabled = true;
> +	}
> +
>  	/* enable interrupts */
>  	ret = ih_v6_0_toggle_interrupts(adev, true);
>  	if (ret)

