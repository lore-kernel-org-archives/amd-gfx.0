Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5F4D10DB3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 07:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3262210E425;
	Mon,  2 Dec 2024 07:46:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R9qPsn1k";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F19010E426
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 07:46:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EliFNaj9dUo9jneaPPflwE8RMjz2RRIcGV28E0GE1S1mDBwqvLizpr8YXOn/khy3jcF30YzhaWPI7zWaq6Sec/OKYCxs9JklwO1FZO/FfGh8ho2/QPgCdRqbuw3rePv6xdO6v7VzcJkVEQdEnkuwyCG35uLuZu2AXMNsaN6PD3J78BVOJh0sI77WXQK5PiyeM71DdVY5M129P3QN623sM9IVJ1fvcXq/PhHEOEdYrtpN+8MchOO8Pk8xTpd+PZSrJgUA/nsCJ1PpZLJB/FLv5uMwhk16f2HeKYaGsB2Iw1R/+VBr0D22Pz4Vsim/dcdgAi4ojgFh4+NH+nn0Ndu4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mglLW2SMxpr8QLmElkb45/ezKn6AcHPPuiVKTcq21DU=;
 b=wtuyXnZbk8zyCN6aVFoAv2zDA/OkqzPNEmPsDiaudauVxBiky+n43eph0tVq6etHtzUUjrL4L8cRI4zYFOM9FJ0JE8l6X5pWxvUdKqyMlJpJokTRVf4tZr1qVSZQLj+7Qhn2poWIoMjChI9binnwduS7OPiShEKp5A9kcZEQiGgJ8cbXjlByJ/NkgvkWqARACkP7/n51qQ9N125qUuqpoBdWMNIhntJHDiyWvdk0QkAjmL0pplxVQChiPFoeipuXFc8L9xh24cWEi8atUgx/OgG+p7xwlNW6m+TRh52mA8RZRdgt4fheVuITP8lg8/qR1A+wGHRwEuYd3aHcTx5EGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mglLW2SMxpr8QLmElkb45/ezKn6AcHPPuiVKTcq21DU=;
 b=R9qPsn1kA1r35CNGnOxzViZNzo+lM6BzTpQJkNZRWS8y+zyOS6M4vq9WqF3j2cPS1DMnNF7rIPIRxoWKSM+pdK04BhOJIVV2A27MfL/0deI/xzr1df3au/OXL9b8LqC6tx925rX2y27TFTTahjdkDnddWUIMV2pC/U4GUGjiiuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB9073.namprd12.prod.outlook.com (2603:10b6:510:2eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 07:46:29 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 07:46:29 +0000
Message-ID: <fe3187a8-666a-4842-9aac-032462de4a1e@amd.com>
Date: Mon, 2 Dec 2024 13:16:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Avoid to release the FW twice in the
 validated error
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com
References: <20241202064615.516559-1-Prike.Liang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241202064615.516559-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0042.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB9073:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b196e0e-bb21-4daf-7f11-08dd12a56e65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVBjZlNqdk1qUDF3RkR0TFNONm8zaDZzZ3BjbXRGUlpLRjE2Ym5SbVVqclN1?=
 =?utf-8?B?Rzl1dFlJSGc3QTZDUU1tZ0lmVVI5OGduQlp4Y3JHaHlXVStScmhHcWgyaFd6?=
 =?utf-8?B?MGhlUitJOWFVaHA5OGV3ZFJkZHRSRGMySERjZmxRZmYyNy9OV28xS2R6dlk2?=
 =?utf-8?B?YUJXWWZtTFdRNkt5cHVucVdhdHhUV1ZLYko4a04weHdoQlEwUmpWSSt4YVc0?=
 =?utf-8?B?TzNsR2FjZm5pVkRiOFN0UzUzeUExRkJsT1pKV0lGSXdSaTVOQk1RdmIvb3hL?=
 =?utf-8?B?NCtac1JuVGsxTmkzNGo4N3U1Y3VidjFzd1dEQW5NakVyZmd6NTM4dnI2bGpV?=
 =?utf-8?B?eXpwMmNWQ3VRZkx3djZpK0NGOUNLYklyRGFLN21NamJiR0RpMG1YK2xHQitY?=
 =?utf-8?B?d29VL2FpSlRURUJhcWdNUVlWMUJNV1g2MUlDWGVqL0xvM2FJeS9RdGlrRkxs?=
 =?utf-8?B?WEhDZER6MjJJUi9wN1NMK0o3MFV1WjZpaXVzQlM1M1owb2RwbnFPaE01NS9s?=
 =?utf-8?B?ZndGVStqN2JUdEtGa2d4eXJWdkdoTC9ZVStmNkdmQng3R2lEU3dBTVVCTzRY?=
 =?utf-8?B?cy9CVnhEMC9tcWZ5UFhvQ3BuVXNlOVJxNUY1Y09hMXVINmtVM2tSWHVicjdO?=
 =?utf-8?B?bGVPNE1sa2xoWElXSXhyUzMwcGdHNm9JZ0hJbEhBbHhZM2VDQ2ZmTWVpeWlr?=
 =?utf-8?B?KzFqR0htYTVMbmVXUjNWaGVySHBOUDVMR1pHbnZwYitKampBellmMlhLNUVC?=
 =?utf-8?B?VmxRTklSY21QNHkzbU85eTRuelBEUVI3YzlRNk5XaUJLbXBka0EwWmpjem1L?=
 =?utf-8?B?eldyRDgzVWgzL2ZnNEFsTUhCNERjNlUvc3JiYWpMNmtSUHFNa0RkT1BoYWdL?=
 =?utf-8?B?MHF6dElUMXZpZnNUN2QyM2FNMEFwNkN3dVZ3TDVoZUtESVVVY0NtTHR5OTd2?=
 =?utf-8?B?RTFFN25nOTd5ZXVwTXp3UnRhMjNjbmtDTWhjR1p2d0JBSGJ4aVBVbVBnMzVW?=
 =?utf-8?B?czNCRGdJbXlVQklkbDNoYzI3OGZmTUs4YmovNDdpY2tPd3Y3N1BtajBCVE5E?=
 =?utf-8?B?dmhuenQ2UFptTnJ2N2RlS1ZBUWRhSTBhbWZ0S2I5dHNiY3RNWlRpN2twMG1Z?=
 =?utf-8?B?YzJDTzFxQUh1VWVmK1VHZ0NaaGJidks0V3BQcDd4RWduNTBXQmw2UzNoZ3J4?=
 =?utf-8?B?M3lmZnByRFovSzlwY211bkhqRVZvN3g0TjJ0L01tOS9aQzRlaFFGMlo1WG5p?=
 =?utf-8?B?RzZockFRblZTK29vR0psWmdycmpESXl1aFlsSmhDeVJGb2M0MVYzZjhoQmxK?=
 =?utf-8?B?ZVV2czVoRlF6MGl4emhRRUZTVUR6NjNUWDVOanhFcEliNmQrcVQrTjhoWE1n?=
 =?utf-8?B?bW1BdGFYelZ1UWhCWUs3L0lRbHJ2V0lIanoyeGVDMzhwOVgxTXcwdXpTL0VT?=
 =?utf-8?B?OHZDVm1OaFI0VW5CNVlObUU3ek9DN1E5R3BTOU4veHdYWXdBTHJPd3dPR2k3?=
 =?utf-8?B?Nms2ZDdtUG1uT3JpbmdWWHhKQkU3bGRrSXZYOFhVcGZ1cmRFQXAvSm9WbWY2?=
 =?utf-8?B?YWZkajRWUTg2QnhUK0xGL2V2MU56bW0yM0pRVkNCaWQ1RUxnaXZ5L2ZnUGh2?=
 =?utf-8?B?bXpqZTdadmZvRGxFZ3MvVXRKZlpNMEdMUkFwVjNQZ0xCRy9GWTNsUVB6c3dC?=
 =?utf-8?B?VnJuZllaQWV2M1RydWMyQmwvZldjSmdZZ0E3UmdSZ1FuL2JrYnhQWUVBdWRN?=
 =?utf-8?B?MkNUeGZaK1RaNlZ6ZThUamhlSEpSNllUNCswNW9wVWMvZDh4Qlh5eTVWZWV6?=
 =?utf-8?B?ZzhFb0pwcTRFanZCSHF4QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2VsMWZVNGVLOExKckNkMjlOZU44Tlp2UkZtYmxOUjEwRENpRnFCV0R1R2Q0?=
 =?utf-8?B?V0VCZHRKY3hBOUsxbS9ETC9zNmROaUNRamQxbnB1Wms5dCtVT3lZUzVWcUFv?=
 =?utf-8?B?NFpSZGY0MlBFNTBMZUVJc25DL3lSNXpXeVIvK0pobkwzdG9Da1o1TXRNOUs3?=
 =?utf-8?B?VmhzdHBSMkxtaUx1T0VjczBVTldJT1VzQ0d6RXZYclg5a01lZ3NZK2xPTFR2?=
 =?utf-8?B?TjFCNTZKQ3FydE9UMlNZeWZ2YVV2SFgreDlCSkM3b01RQlJGSFZpN2pHQ3FK?=
 =?utf-8?B?azhhOHlNMkFDVzNDeTVSRlhMSlNZUXowSGxHYkljRkVBVUJqTDRvY0g0clcy?=
 =?utf-8?B?dThVcWptc0JENWQvWDZhNGRFS2g1VFU0Mmt2UkFQOXN3U3dYVHcxQUZrazJ4?=
 =?utf-8?B?NTZkeVhkcDlZa0NndFZyUERLMDJ2SG5VTkVuNmJCaCtEM2s5K29ZVWZlMWE4?=
 =?utf-8?B?SzFUc09FZ25PQ1V0SmVkRG5xcUphWUlpWmtJQUViczJUNWdocGlUQUNwdGdJ?=
 =?utf-8?B?THpRTVBDRjNTbUc1N2hkNElDYUk5NUJlbjcyR1NOYWhGSDBmbHJlWHZxaWhR?=
 =?utf-8?B?TXU4ZkV6dXdmS05DYzFHQ2d4Um5YLy9EczhCenVDL29kSXFyVHZiQ0l5OWZm?=
 =?utf-8?B?UmZVZmhKR3pGdGFPS1U4c2xzQUk0V0hBNXJ1S0pWNXlyMDVaVDJSNmxIVWtt?=
 =?utf-8?B?UnhlUGpBaVZ2VVVxYVJMcmEyYlE5bEpHaVBhYmk3by9mWkw1emFtVTZhU094?=
 =?utf-8?B?TDFwM2Zid25HUzZwQ0RlZlNZd1ZoOHN5NCtXZGpzUVk0d1hGbGR2RHpSdWxu?=
 =?utf-8?B?aytDSjNhbFgzSVBGTjBvVEJBeTNPSU1YNldmNlY0ak5CNnJZMUVKb3NSZmFB?=
 =?utf-8?B?NXRWQitmRHVHYzRwMkFHby9FMVBSYi9DdWwrZkxpbGZGNi9iVXlPajJGbWV4?=
 =?utf-8?B?V1lLQ0dOd0syK3BOTEJZR2paU1prUFIzdDZoNUowY3V4YjkwbXgyUXQ0MkR5?=
 =?utf-8?B?OWoyaWtCZ0IyT1poNkU4YWZuL1k1NndQNk1XVmdlb2hTQ1hDaWZEaU93dzlK?=
 =?utf-8?B?eXZuaEpwUVg2K3dwMFlqa3p5c3d5RlMyUzlQNEoxR0s0cE1nenlXZmsvaE9S?=
 =?utf-8?B?cEVyQVp6a2JhTDZZVmZzZ1FYSThvRU94YkFkMVhWS0lwYU1kRUpaRW9rU29X?=
 =?utf-8?B?Ylo5TlY3WlYvOFdKNkVjekw3eG9aZHBTbjcyYSt4ZVE3b1RnZER2UnBNOE9k?=
 =?utf-8?B?aENQU1pZTkRmaS93SVJ5b1BLSGpwQndMbS96VW44WE5tT0tRWWM1RUdaMWFG?=
 =?utf-8?B?UXU4VzFXd2ZYWGxieDlZb051QnpxdlMxZFNOUEo3Wjl4RzNxYjhHd2ppWENr?=
 =?utf-8?B?QitDb1I5STdHaFQzN0pUSEVYcG5IdzcvOHpmNzVFNGdPbFRZY0lYZm5hRm13?=
 =?utf-8?B?RVRPNWpsTnBTUGlJUFVpYXU5T1F4eE9uMjU4ZXp5M3hwcUFTSHpIb1hhRVRj?=
 =?utf-8?B?bXNmQ0p5L2JwbmN3d2FLenpCZThWUVlaTjV4R0hzemprU1djYUdVanNnN1NZ?=
 =?utf-8?B?YVI4NkdsQWdKbkV4djE1NG8veWQ0eE1Xc1puNnpqeVRUL1NMbUszQWpPb0Mr?=
 =?utf-8?B?dms3NlYyZ05GWEVRNGt2a3FTM2R5NWZqRTBJa295L1R1Z3d5dlk4eWdNM3Bu?=
 =?utf-8?B?VDJzeGpBUGMzUmREKzZFcWNGS3Y0TWdjZlYrNHV2bW5nSzQraEVGam9LZ0Rl?=
 =?utf-8?B?Zk1ETjdobnovTGtLQ2hyM0lIRll4Tk1yN2Y1aXRCdjJyZkc5c0d1U0VQaEpL?=
 =?utf-8?B?MzQyN2txOUVOclhkNGZBRUJGaVRnOURXRnJRQTk2MzhxTGFlMHJNcVlCSzBL?=
 =?utf-8?B?dWRsQmJ3Qy9zazI0alhDR2tjYm0rK2lYMmhwZ21CUGRud01EZ3FKM3BVWFRN?=
 =?utf-8?B?V3F1OWoyRXgyR0JDc2s2dFc1S3Z0aFhHUXRzNzdsL0R1ZXhST01KeXNvSFJs?=
 =?utf-8?B?M3J4cHRCUGR6aUw1VnJNdnY5bHdUQStpb0F1MEpuNm1zWU1qSXFCYlpob0t2?=
 =?utf-8?B?aXlTUUV4eFRYaFZtem4wOWNoTmx0Q1Z5SnlZNmUrOW1ENVQ3YWRMTW1yWTkv?=
 =?utf-8?Q?XMctgIXzr/5K8mZn3ccTyHhPw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b196e0e-bb21-4daf-7f11-08dd12a56e65
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 07:46:29.1073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Swgget2Xa2/WDyBEtKhdswcg8vKzYR2JmYt4xZa6MkDZj7i9VEmXv5iTPN2EUoGR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9073
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



On 12/2/2024 12:16 PM, Prike Liang wrote:
> There will to release the FW twice when the FW validated error.
> Even if the release_firmware() will further validate the FW whether
> is empty, but that will be redundant and inefficient.

Better to add a remark that amdgpu_ucode_request should be paired with
amdgpu_ucode_release regardless of success/failure. amdgpu_ucode_release
takes care of firmware release, avoiding redundant operation here.

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 4c7b53648a50..e7f50415926c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1461,11 +1461,8 @@ int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
>  		return -ENODEV;
>  
>  	r = amdgpu_ucode_validate(*fw);
> -	if (r) {
> +	if (r)
>  		dev_dbg(adev->dev, "\"%s\" failed to validate\n", fname);
> -		release_firmware(*fw);
> -		*fw = NULL;
> -	}
>  
>  	return r;
>  }

