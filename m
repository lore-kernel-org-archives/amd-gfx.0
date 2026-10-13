Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50203CC6B08
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 09:28:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B880889F08;
	Tue, 13 Oct 2026 09:28:03 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011010.outbound.protection.outlook.com
 [40.93.194.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5F5089F08
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 09:27:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9kdnk//uvLZHm0/+ZG6lfQdxfIaARHNdD1vMdwuZm3JnIUG+dvmA1zqCDkdu44hHLgyAZgIKERM4GjV/cAprsdnw+B3dgLRqsx4oiZJt/q9uTKKZQdxI9iOOsLym9M6Qusu2PsdHLyaCIc8BqEyxewD8X9V23ujK1MUomDz0Ka+LCei3vvNKnJhTa/A5/5BRbjiJ/NppLL6AxuTFB7aATBTgqnS7yhdVJsNksTcVY45wKeNVNAQA3LxoFxTWzxe3JvhgBK+rxl+Iw+Yi2rbsDWgiByInDsmbrNVnPQty2zGOnMOdOpzxzyKCmRhW7XP34jRNabHFus9MngfkOJO+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXE3JYjIASg2JbiDqo/kag6EhM2Gb4iHinSmf+nPFYE=;
 b=IbFupL+wlDeKjd+rZnPqvVlQgB6ebMm2WRD40p9pSY8ddd83/EOO96ZNHndx99jdSItlNt5kr7dkljKjd93sd7NYgRwL5+C981omfRw2AYldd64Nlz94IgoJKR8HEfwvftA93JX7Qyzmi0r0BxX8sm1HMrKixExvo0rhyceHOXsx2tlSeNpPI00/SsGJiWFvj/B5T9DOOpCak/YPIAf8lWJZJ6hUJn5Mfp2xhddNrEtCBIJGNnudEL5TI8iL0qojwlLtOC5XuRtHcqU8y00d3jUllGiGQS6TK5AeSsOLuqi8vdCLPyQN4m2K5tSoars6F7nJdhQ8SpZsCkTUN8JTgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXE3JYjIASg2JbiDqo/kag6EhM2Gb4iHinSmf+nPFYE=;
 b=eqDQTu/uKreqc02DGoQxmeBMvyDie5CN/TjxSswsjsTCMBVPWOrjP85+vc9EdnI2IhGgUmF2Lzy+vEIajgbvBPdCz8ccqc694/V1Rwg/M4bEKp937cY9/rMCas8wsgR02e4cFFVeD5zF2TPub0HqmH29MuAHm8gsqsYhuwCVl4M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 09:27:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 09:27:54 +0000
Message-ID: <2991b037-fa46-4d33-a6b7-c7783c92b105@amd.com>
Date: Tue, 13 Oct 2026 11:27:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] drm/amdgpu: skip VKMS mode-config helpers during GPU
 reset
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, Vitaly.Prosyak@amd.com
References: <20261013082457.2492273-1-Prike.Liang@amd.com>
 <20261013082457.2492273-2-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261013082457.2492273-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: b7925bf9-0668-4883-3d1b-08df290c429a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fPR54TnfFIoLiodBahlzdY6MAKygoXKwcFrepo7TpHMr9stMFYdtUKV4rS8b8J5dzX/FXFexzU2enlaAf/0Pjuq/lmAGphEfyNfLI7dw5xQwZvPsDR1ZZgp7VF0lu/6nA9ADEszk2dHRl6xay/e0gtmg0msv4cVXgjIVIxUwMvKK/hDW3+eunaZO4RSApsZTAwuno232LcKbWQrL0Hf8i7wRqIpmeQ0rrhXMDP76ZSkW8ef734eeS5BFiLxh/kGTVoUArNw6SfyIpI69NcFIb6UsqMnEhRU6t0TDg3CxQ6WykSpKm2wdmT/48jc+S+RlHjKI4MjOZK3F6aoMM4I0BpSm5GsB/9qXLmikRBfFrOEZc7JkqmrHTVg7HKSioVMRkosNRu2P+DpCSa4xHP8q+kkEEEXPz4OC/KZ1LCQEJZUz1l6/GvdNPNKyGNlXa4OHXaALb3u+ua7rJo73lti2jp6xqRJUPrFTCJVsAyY3W35oo+rRNRLCXZQSlC2GGtq2BDDLXqjJprZ280gMVBlK7t0OCKCTI4zBnuX3SiLVnvWJralIpdwmEyHwM33zm95PwS1XUMCYp3qcApcO7o8bsd5l78119ivAtmyVHXjIeAoy5PYgUaWzF3wBREVFjZCWDqwkRzApl0kXyVA5BztGA3ymmu121jKYi2xbbEs7hbw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U215UklXVVlNZFpJL2c0WlFqdDJxc3RCSVJXckJ4ekQwMHI3dEo1QWZtNnF4?=
 =?utf-8?B?K1M5bks1Tzh6OGJwR2gzRnltZkxJS2o1VkxDOURKNHdCRFBSSXJDM0I0QTU3?=
 =?utf-8?B?am0wTWtPL2Fxdi9pM08rbjRjQnZJTU5PM05sMUlBcnp6TTFaUmE1OGNwbFNa?=
 =?utf-8?B?NGlCZ0I2L0N0TW4wSG0rNXQ0THJ2dWE2ZlZEc1NnQTM4SXA2dUkySFkrVWlJ?=
 =?utf-8?B?QWFMdW1TTnhyZXkxdjdGVHBYcHJhVUgrRXJBYXNPUnh2SUMreVltbCtjK200?=
 =?utf-8?B?Y01aeWR6VWpKWmdkTDRBOG9meDFlN21CRXdEdi9qK1dValR4czhCMmRlWFpx?=
 =?utf-8?B?RkRjSlNaVk1PaThEcGlvbmltNnZkWFBkaE9hRlcvYlRhTS9BNEtmZG13UmEv?=
 =?utf-8?B?OUNPT3RzZVVuNFZ2bHVZSnVGa0xUb0ZVSE5ZdS9TN0Vnd093RUhwVXd4NVlC?=
 =?utf-8?B?dUJBcFNFOFBBaGVVeXRhMlgvb2daVHk4dVgyT1cwNDQraDZ2LzMwOXROeERx?=
 =?utf-8?B?SDJJSUhBZDduSVZkWFlTU2dCcWhiZ01IckNJSHZ3bmhZWVE5RGtoVjFmWHRJ?=
 =?utf-8?B?bm9XQ0pjYUZyTXlMTitoN1Z2QVJQZmE4SjRJWTBweWpwMHpEMFhUZmhZc2VP?=
 =?utf-8?B?RjQ3Q09ZcUxnaExHNzNiSUtiNTBWRnRuc1RsUkp6SFdzRFhOcGdUMjhjaUpH?=
 =?utf-8?B?alQxOUZFQ1NLejB3Rlh0ZC9YRHc5ODdpV0t1VGJ3UHl2UG95ZFo1a3lCTlRI?=
 =?utf-8?B?cjhxQktGaW81L1B2dm1NSEZ6dmtqeVB2MUMva2gzZ3N2VGprMC91R0U1SjBw?=
 =?utf-8?B?VmlXK0poTkFHL3A4UE1tQ0o5RnJtYkphSGNaZDMzRlhkVGF3Y3lIUzVtLzdj?=
 =?utf-8?B?Rk1pcDNtcmhHam02cU9sREQ1OEpxZ2hRR1BIQUx1REVMZUZ1eGY4RDlMQWc4?=
 =?utf-8?B?T0pFYUF0WEQvWDdVZnlrTDRkK1pjb0JpT2p5SmR0ejF5OVd4allPTEx0dTlv?=
 =?utf-8?B?V0szaU9sNlo2SW82cW5PdGNBajNiMi9YSDBRUFFUcmlaaXNpeXN4MTFSYy93?=
 =?utf-8?B?S2taVUg2d0h3eUVpbjdoa2lXeTMvYlNGV21jWTQzNHpmOUlJaU92STRteGdw?=
 =?utf-8?B?S2pCQlFweFpqbFk2MTJUeUs3VFh0cUQ4VjJXUlh6MXVDbllEUDFKTlBqS2ZR?=
 =?utf-8?B?Z3hlc0JacHhJU2JiWUpQcHIzSnBXc3dkVjljeG9XbnkyY2ZLOC93YTdvaFQz?=
 =?utf-8?B?MW03Z3lqeG1kNlVFbjY1UFl2dXpIRXo2Qmk1VmpybzBDQldyQkJ4ZHFHdWRB?=
 =?utf-8?B?SVNrTVRNdkV4M2dhTFB2dXpsUngxcTBnU1FjQkVOWEgwOGt1ZUp4Q2NwN2VK?=
 =?utf-8?B?RkJ6Mm1HV3RCenhIMjFLR0R3c3pUMloxZmRPbkJCTy9GSTRrZzgycHY1ZTZH?=
 =?utf-8?B?aVp1aG5zc3FYajk1SU45dStYTTVENW1XYkNKTnlLeWdSanlWeGFmMXBFUU9p?=
 =?utf-8?B?UXVRSDJIN2pmWlBrSlhDV2lLQmFwbzFQT0R1emRYZllxZ3FqUlFvcDJXckQr?=
 =?utf-8?B?TjBkUDlXbmVVc1BzZ082ekx1NnY2N1ViMDhwdnlVNXh1MnlIVmhWN3kxSWtD?=
 =?utf-8?B?ci94cTRkUGFhZkw1SE1HRFNmZmhHSHhkY1VhNmMxM1NwK01MdWYxRTFIR0cv?=
 =?utf-8?B?eDVWdHc3VGh5c3pEemRKZzhEdlpWTFRPblhlWFdjMjVLcGl6cnl0YmJXRFY0?=
 =?utf-8?B?eXBjcW5SRFBEMXFyYnlZdWlYa1lpM21XOGl4OFB6MDVFWklKWHhMdllYT3p6?=
 =?utf-8?B?L29BYUZQQVhMZDlYaTRWM1NKbDU3OE5zS2MwanB6bzdtWjcya0M3VXZWcmkz?=
 =?utf-8?B?a0Q4eWE0UXF3aHFPZ1JzdFhRVTVYS3phNDR4OFlFeXJkUWtGWEpnblQ2Tkg3?=
 =?utf-8?B?WWhibVFiRnF1YVhQNThTOUcydXZwZWlUc2hvSUV1d3NZdlFLaE5KVzEydHhE?=
 =?utf-8?B?WkoyL1MyQmFOanFnUnJEWXRxQjVNY1JObS9Uc0tNMHNSclN5d0psUzdMSkRz?=
 =?utf-8?B?QXR4d28wVllsTzZlUWIyNkdVUG9lcXQzdE1XaEVvVzJVSGRMTDZWS3NZN29t?=
 =?utf-8?B?RHE1S05HSkVNMGR3aDBvTDBsblliUzJTRGVFWGlxV2NtRHlMUjdnZy84Si9w?=
 =?utf-8?B?cWcyUnRBOC9FZ0dRdHpBYUNDdUR4T1YyTHVSVGZBZkRVYkVHWVFZWjI4cTlk?=
 =?utf-8?B?ZTVSMFduUDBrcUhES1JKYk1NWkpsVzVlaDZGcUErU3RLUFREcTVkVk5jSHdU?=
 =?utf-8?Q?avb2ht9bsbMsskun94?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7925bf9-0668-4883-3d1b-08df290c429a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 09:27:54.4835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCg6wGFjm5EK40YofqzCQrPfjucH851B+ZHISAVaOGmXs+zhNCVJCGLiJzfUxdtJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176
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

On 10/13/26 10:24, Prike Liang wrote:
> GPU recovery already notifies DRM clients. Skip the VKMS mode-config
> suspend/resume helpers during that internal reset to avoid duplicate
> client notification and atomic-state handling under the reset lock.
> Keep ordinary system suspend and resume unchanged.

Clear NAK to that as well.

The amdgpu_in_reset() function can only be called from inside the GPU reset itself!

It is *NOT* allowed to skip any operation outside the reset depending on this.

Regards,
Christian.

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> index d6b51b3f216b..a49c7dda4c4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> @@ -491,6 +491,9 @@ static int amdgpu_vkms_suspend(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int r;
>  
> +	if (amdgpu_in_reset(adev))
> +		return 0;
> +
>  	r = drm_mode_config_helper_suspend(adev_to_drm(adev));
>  	if (r)
>  		return r;
> @@ -505,6 +508,9 @@ static int amdgpu_vkms_resume(struct amdgpu_ip_block *ip_block)
>  	r = amdgpu_vkms_hw_init(ip_block);
>  	if (r)
>  		return r;
> +	if (amdgpu_in_reset(ip_block->adev))
> +		return 0;
> +
>  	return drm_mode_config_helper_resume(adev_to_drm(ip_block->adev));
>  }
>  

