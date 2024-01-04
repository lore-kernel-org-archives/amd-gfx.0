Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AD1C47074
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 09:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2355C10E469;
	Thu,  4 Jan 2024 09:35:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C870F10E469
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 09:35:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8YoDVhdhD3af0g/ADN6iT3fjmdg75ZjwvSn63nIwgscYXtySvFo6/2lE6INjxZz00rlfDnRA89GCK7vHj5LOKtKmme6bMwK2EmPPahd5QPvNCQCTmnmyXB8Otmwoj4ycGAxhT0bqlBjqcbMYpEJNtaYLXn4iT8DFZW47k9S5Z3hc5fkdgi2Mte3gWTDL/Fy1mG5+bHuGvA35lOJPcLl4Fc4LlRcAg0S1LzZI0TkHP6zTskAoZ1cVF+ynM0ZBvCdtAfSBcu/jzGE/NNsAcbG65ddO3DmHXZXUbrOpfK1Ocgc54C9TFl9/ZE2pGiGkRGUCkLVoRhdWR2yPR9FV86tDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8f9UpNfsoRpSkBdf1RgIXNMVFOqEeQONiJuGz2sf1bM=;
 b=cNDOklA5Xe4YkLjNSZuUcZLL+QK5xhLPKtpl3ZGEMaMyhyKLe6xoaXFA/DafKirAztWPrO/8aVWISPLkdkQw9ROx6XmsdcZkrnBdh2GdAsJEqrRy2EjdhVu3SjCmAUoM1WxZYNk6I9h+S3FB1VcfLIvX9240Nwc/wlR9AIsdz3QxO+96GLuG2jecIsdYW16qaemBU9TJWOi/af4+wDw+xzWaLQOPNu3PeoZ0iLiwxd7EyrIqqrsGRwtOHcmXc4gb2wZ3LLF5GwhffdZjYGqInrZTzIn5ONTYk0aSoM9AEpn4QEvdVZbCASHKDFvi044EXgV0cGxSA/GGLh5UyfqeNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8f9UpNfsoRpSkBdf1RgIXNMVFOqEeQONiJuGz2sf1bM=;
 b=AZNba8JNHJapp8lUgodGov32wi71mGuh58hxnUvSGEndeKAYs1JpvyjvUcxf+BdhTYixNCMd54D/7lcxquRHY+scysWB7666BeInb0xpehGsXdRcCMZ7BPRBSRM711E86GiWxa+7TKh5kmkqaP31KZVo8QKgtl0M9eZjyUTk1OI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 09:35:40 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 09:35:40 +0000
Message-ID: <7bc2108e-85c5-47d6-ab7f-2122616a4cd6@amd.com>
Date: Thu, 4 Jan 2024 10:35:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix '*fw' from request_firmware() not
 released in 'amdgpu_ucode_request()'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240104092637.2353130-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240104092637.2353130-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8ca0de-b674-43fe-130d-08dc0d088400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SzDKtJTur8Ez5NdVAWhpEECdQJ9lFe1LIaT3vuQ1Sb8DRYhfga2YYmhIzBV02pttI6lf+2YIo86pz2yonPsPIaZgmXuyJxJPe63XpekPeByG1fiC6zGOTjOhR65pvsyeINRLpq2biBxzweKdxeoPI/ycsAzLUOhTTeFsKpS7qkQOnmdksXkf8qKktJRD9dUulJ85xV1zDECrHBAoZXOlUPtTh2Dc5K57ir8/flsmBFSvyYUYP+m+ss/xzVp+izMikaek/wUHY5HzKdqzf0laWs1pwftOXBjRyNKgcB+7qeRgVv5d+PlCglkLNC56IUKOKwx8S09zqSf7G+pVHC26E+EfVV95LNSoZfhWfAjum0uCvGCan08ntDjelKqgMJwmbau2oTySYrSNa5MjMXgOuBPbKz9oH+3Ybs73nmwSXFk8ylQkOJ0aMZZ+R3y/MuxMokSoaEjaQEapxUPawnSbkPQLO8FtAhmpCbSdoN4TW3t5ubOhTH8is8GlcwJt2jOiwbPm4hHe96s9SAfyvG2mXgBsDMUm+tdpDfq7R0MxCPjTt8KIOSb7+V0hzzj4uXQ2CZhEFrIRMfQYgkdxKeWOh1C+lGtTTUrXWZMvS7i/BPhDymQtpkKHyY3k0VZwo41TqiG05EQdWXWDcGCJGjEctQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(66574015)(2616005)(83380400001)(6506007)(6512007)(6666004)(38100700002)(5660300002)(2906002)(8676002)(41300700001)(478600001)(6486002)(8936002)(66476007)(4326008)(66946007)(6636002)(66556008)(316002)(110136005)(54906003)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHlFYnB6cjhlTUdrZS9wT2VHRVoyOHZJUXZzS2FJR3hiZ2NtNG14THRacTl4?=
 =?utf-8?B?K1dLUlp4bklROUNMUlNrYzdWdzZIS1RQK1pYMDZnYW5RL094WWhMSEdrQmFH?=
 =?utf-8?B?RE8yOTc0VlNiSFRrRTQzS0VOQVNMb0k5WWdiWjBvTU42SHdNWFlMcGpqalJw?=
 =?utf-8?B?VkdqZE82L2hucG5xcFpRTTR4dlNuT3pYSEFQajdGaVFzQkV0dkUrQzFVelpi?=
 =?utf-8?B?SHNiZ0NiVGRWTmJFd0ZlbDhZTzJjVHAwTXdjN1gvZUkwWmowSTJUR0VVTEZQ?=
 =?utf-8?B?SWthQmcveWVJa20xNW4wUGhuSXp3ejNnazRxYW1CNFd5eGlYeXI0VnhUTzVV?=
 =?utf-8?B?VFhIMjBudFpHNVFUZyt0bW9TVHkzT3dHcDY4am14eHRzVjZDL3BpYWhzZWgr?=
 =?utf-8?B?NjNtcCtIWkZremFzZkRxOCttSHFmb3QyR0cwdnNQSXl2MWZINnUzemNxM3Q5?=
 =?utf-8?B?VW1TdzNYdmdnTlBxU2dxeTI5ZVpMN0NQaDJsVzlVL2w5Zzg5Y3hHdHFaMjNY?=
 =?utf-8?B?akQ1SGY0b0xYNmJoQXJsRk1MRTNxTDc2M3ZLRlQzU2Z4TFNmbmpXRTBLUEl0?=
 =?utf-8?B?SWxWSC9ybTJVeHIwbUVDQk5OSjRMdEN3ZExjakREVytFSVlFTkpWS0wxQkxL?=
 =?utf-8?B?QnNHdXdrc1ZDcURuNXRkUk50RnpETGJ4alBQWkpnL2RUZDFnZ1NvYkwzaVRJ?=
 =?utf-8?B?dFlSMDNLWDNjMjB0Z3g2OGVyUnNqY2JiTFllcW5PMitDakFNejVncVRVclZq?=
 =?utf-8?B?bE5vekh5OTdXYkZqeGFsS0w2b3hxeVBKeUw2bkdlUTBnUy9WVXZlcXF6WjhB?=
 =?utf-8?B?SVdpZzZOdFl2ekVWd3J5NzdFZnlLaklwSmxWM2FhTUUxZjRzOHJ4ZmJKK29y?=
 =?utf-8?B?MjdKL3pJVGNrU3RNbVVlemdoR0JSQ3ZpTVF2VnFvbitpQ08zYmdFNGFSek92?=
 =?utf-8?B?RCtvajZZMU9jZWk2cjVwQ1BpNGtWZkJON0U5dDlvZE9ydSt5WVA4ZEx6NGpt?=
 =?utf-8?B?QTg0N3YrUTBJSDBkL0lsWk5ZRTNOMU05Tk1tOVIyVmtldDFrSUZ5cUhJOWZR?=
 =?utf-8?B?TVZmRll0UCtBa1Z4dEhlL3NYZkJMSDVuU3R5b2VoY3BRdkx3TEc3MmZ4Z0sr?=
 =?utf-8?B?MElTNFZ0NFpOeFpEa0tnQ21PNW9vRTlWV3JsSjFwK1JRT1QyVkZsQVlnTVRp?=
 =?utf-8?B?U3hBbGp0cmU1bWhIRm44WGlzWGpDaTFMV090MFFlbUdSWDVOR3NoK1p0L0x1?=
 =?utf-8?B?L21ScVc1WUJFblJ5OUtmbVJ3WTZIbGliRTdOK1JGSEZHVjJxdXZWWHFLSUtI?=
 =?utf-8?B?Ykd1UmJWWHBBczZydm5UQnVyU0ZKL3YyYjgydVE1eFVmTW4rd0M5bEZMakdh?=
 =?utf-8?B?SE9qMEZFTmxjNXRLRkpaRUJiV2VOWHB0ZFd1cFJubXpqY2JaYWljeU5zYnN6?=
 =?utf-8?B?SGpPN1M0UCtPL2hRZUFRSmJDVWJ6d012MXpjK0Y2RWIvYU5WdHdTT1ZLSm5R?=
 =?utf-8?B?SnFqeWRDWnpDQWFOZnEvT1QwWlF2UW5IUjMzRm1hdUM2TnFpNlB2THMyM1Ir?=
 =?utf-8?B?OTRQaFE3aFRyMmxSaklsWDk3M0V1Vk1pTFdaRXRvSmdPRFNUZEk2aUNMZHdH?=
 =?utf-8?B?VitmTmpBQkpyakJjR3ZXK2kvYWQ2elJaZGN0SVdpSy9DdUo2bEEzVTBka3RD?=
 =?utf-8?B?RUJwRldSckVXRkZwSGpXWGw2OWdKQTEvNGVZTFJnMXZqY3I3L2VDalV6M1VD?=
 =?utf-8?B?Z1FWTXI2c1h5alVtUGdQMUFFV0E5QWJPWTN4MCs2cmErM2VJRGZ3L1JrbEZM?=
 =?utf-8?B?MEJxV1Zzd29WbG9qbEphMDAxSVBPZWNEenBkLzQ1THd6VnEzaEs2S1QyUGt5?=
 =?utf-8?B?SnVoUGtmR2ZweS9XUzhwNEw0enZPaHRNQWVHNVlwbTRFSllEakF3Mm02Y3Bn?=
 =?utf-8?B?UDNOQSs2MHRBVjZhWUFQYnpzeUN2cG52ODEzaDBSWFVqZzZHcDRtOWdwei9C?=
 =?utf-8?B?MDRBTU5CaHgvbEVVZUJldzVqMkhHUDBYMjBGOFpISkRlZWdhbTh1V1ZLZkZj?=
 =?utf-8?B?OGpjWnNOSm5vT2lVYktYMDUveStSaFhWd3JIaU9uMlVTcnZISVBwejRYaUp0?=
 =?utf-8?Q?lP7mE0CkTmlwLaWVbf01cAn8W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8ca0de-b674-43fe-130d-08dc0d088400
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 09:35:40.8204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrW1RwOh3/xnpDL/M1vh9pp7f4gldadKP+2SeHSflKtgkSpFY3ZMxGYK4N2Yi1DN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209
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
Cc: Lijo Lazar <lijo.lazar@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 04.01.24 um 10:26 schrieb Srinivasan Shanmugam:
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c:1404 amdgpu_ucode_request() warn: '*fw' from request_firmware() not released on lines: 1404.
>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v2:
>     - Fix some indendations.
>     - release the fw only when ucode validate fails.
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 1f67914568f6..d30c39cd8bb8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1395,12 +1395,15 @@ int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
>   			 const char *fw_name)
>   {
>   	int err = request_firmware(fw, fw_name, adev->dev);
> -

Please keep the empty line between declaration and code.

Apart from that feel free to add my rb to the patch.

Regards,
Christian.

>   	if (err)
>   		return -ENODEV;
> +
>   	err = amdgpu_ucode_validate(*fw);
> -	if (err)
> +	if (err) {
>   		dev_dbg(adev->dev, "\"%s\" failed to validate\n", fw_name);
> +		release_firmware(*fw);
> +		*fw = NULL;
> +	}
>   
>   	return err;
>   }

