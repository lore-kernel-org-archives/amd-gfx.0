Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646C7C9832A
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Sep 2026 02:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E90FE10E09E;
	Sat, 26 Sep 2026 02:29:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kBUfMIBp";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4904210E09E
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Sep 2026 02:29:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BM6wVGd8bavSAzW/7dG6NwbmGm2ipjCwxCyL8aMKNcDD92yUa+J1oXM4cI1C5GLSXz+wefy0GHOUqcHYba3LOMY7NYh2UeAcNI5FBI5doT3j1SCqlhp8Nzqt9QYMeM+B1w/Q9dDX5B3f9pPj2U5q0mAuhQIapkF2u/MCzTXbLzU0JnQlcXpldgHvwIUMEJ4+5sArud9XKcjFMAZunXmFwf04RGG7fNDXrzz4IwLHIvvieH2hYmFQs/1pFlCAqze2P/MBoi8btSwRtDC7N/kgt4Kpdo0Dn5KIRAI3YvenvBXyTjGbVhnuubBRX8ZsepoacopNUSajnsQFucWXyKZzww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GT2FVuVbFVLYWjT+yOjmabrnGu8HEetn0jATJuKTyvE=;
 b=B33sp5Fqrpcz8dKol4JQl2hUkxYGv5tqWsMCJWJ7FQ8JA5rfjnrzOWAexnadjg0v85oifplyJqut33hHeuvyOYDRARoGKhasDVz5DSugSaaKBsHeBzYZ81BdaYTVtHjQZn75+SrfSU74+w06RgoU+oI1RfHtx15NZEKhiF2qz/JJ/uAmacateItrubpwtBqzKcibnuKbB3Z1KcEgXw8F+nwk5OAkLyomK05yWhoNCA5/Vs+5GGvAt3vmttm732XfjscwwYSgnwnDAhSduwtWJF/ngUp7qbopDSe0kzobyrNXddM6aZdmxWS3Jv4n9SOXIE0quZoZ48WDgqgnRw6lVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GT2FVuVbFVLYWjT+yOjmabrnGu8HEetn0jATJuKTyvE=;
 b=kBUfMIBpUCvrsokLQTe3E6mvrswdsryxBUxibESxslkRjp0EJljO8rY+btEKM7QJdlC9diiJ74Gfffo/8zmNzUTCK7Nt4OksHo5TLGBWEe7UZFzw2VXBpw+ZnCBrr2xlrvDuvZ2tdk6loH19gTX9vsksWj9Fyl9PMHsGSV9mTp4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by CH3PR12MB7570.namprd12.prod.outlook.com
 (2603:10b6:610:149::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sat, 26 Sep
 2026 02:29:02 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%6]) with mapi id 15.21.0451.014; Sat, 26 Sep 2026
 02:29:01 +0000
Content-Type: multipart/alternative;
 boundary="------------dUVaVQdxXSGQZa5Q8xUsEqSg"
Message-ID: <1d04e2b6-5596-4676-a532-0c89de46b525@amd.com>
Date: Fri, 25 Sep 2026 22:28:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gmc12.1: properly pass flush_type to
 gmc_v12_1_flush_vm_hub()
To: amd-gfx@lists.freedesktop.org
References: <20260925201225.51853-1-alexander.deucher@amd.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <20260925201225.51853-1-alexander.deucher@amd.com>
X-ClientProxiedBy: YT4PR01CA0213.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::8) To PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PHXPR12MB999256:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 69cf4d82-a679-4702-b8ff-08df1b75ed4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006|8096899003;
X-Microsoft-Antispam-Message-Info: GUyy+CCKm2Pq+9pgYgKd5vEOsmumVCWpIta8p0kjB5szOQy5sJmTrjnOUkOMEXtzbWkbH2MTGXtuenK8Occ3t3nfjTmCNWrJ9gOR5xJ5sUt5mu9HTKcxgWJv2PusKoqYLeghxus0capo4C2Up19WbE4lZjSTp+/OKKj/4OdKxQfOiZLuNgQjRI7VCfPWm1lLA9G8kxoybbqMCYoGDURmSqq1WfpI9+7qD2YgnYyuW00hvQuTe8HWge7oA2ejxHCsWooWBHOuLvTlk1bOnwEwpaGIfFreNAj3P+brzO9FeKWy6mrmcibLUUhO0sHERV7z1Mvrtcak2iZvqvLFrL5zzxfokYZCZcwH2051/bEWTapi7BW0BKjOENlzSXcX47cEG6K5Kf48dbQLey2Ts0SfK8yYlVhwSEV5SFxvVhKrzuHo/hwcnZdl0iobfA80+uGrDQ4/7QXdGnJZ53b711ZpPsPaUyPUrD6hceoKGieed7A+DCBlw2eNVRMKEtZdNqBV7e0lKcERYlQzAMSiTk3mMUqfHdu5VK/v+NdtEqlG8UbbjrUp9XbKXYDBc/7CGW989ALZVvTtlZAE263hwXyOU0avnDkQdHw3cia2mm/Nlai6mRU4Cy1f9m/cnCEtCrdnkNUnj2Crd9pM31pyBxiCF8SJHWMHzjTmVNLVW3/maw4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFVSNjl6LytUa2ZnNEZWTEtZNk9kMzFGaCtZRTg5Qy9PMSsydG43NFVIZ04z?=
 =?utf-8?B?YjdGWnpqMGhMSnBXL2Z1NWkyNmltTUx5R2RuZzBQNXorTHlqck0rVjJBSVFM?=
 =?utf-8?B?NWhpUlFBdkNXQ1BhaWl4ZGVBZDNCU3gybktGcUhRbndlelBET1pxOXpBb0lw?=
 =?utf-8?B?a2R6OFpTSVFWcnlIdXIvcW5ZcDlNT1BtQUhaWGw0c05qNnNlRlJzK1c3NHVt?=
 =?utf-8?B?MTZ1akRlN1BvNmVEWCtYTzZqYzhhV001R2hBRWRIelo3Vlp0V0JkUjc4Zy9h?=
 =?utf-8?B?Rkh3anhTZkxCOHZ6UytzcFRCMWhFZTdRT2xiYWo0bjF1S29pOElMeVdXZ2tT?=
 =?utf-8?B?MEphV1JyU1FSL05EUmY1blQ5RjAybFBDYTVibWN2dlVaOWxTbTZ1a29PSXU2?=
 =?utf-8?B?elpBajBrYnlmbmdVamRUQzZZb2M3NTVvaCtJbE0xcHJ3TW1wRWFkR2V2Nm52?=
 =?utf-8?B?WU5EeWljZ3hndXpwTWdFaC9xYzFFMTJ6R1dkQ2VFUWY4L05meFVlQ2FMNzYw?=
 =?utf-8?B?eElQdE5UelhOYUdsYlRHUU80T2ZIcXFkTG9ZdDFyajBrNW9OTnNxTnR0V2dn?=
 =?utf-8?B?bjVyQ3lzRWFPaDAxQXcxWkxpNXg2Uy9WSGpRbC9hVTdtVGZMYUhMdFA0ZENY?=
 =?utf-8?B?eUI0NEJaYUFTczVqRURaU2lTVUoyeVlmYWhQSWp0c29rTmFyVU9tUFhhZEtW?=
 =?utf-8?B?S3hWcm5GNmNRdFFtdTVWV3lLOUduK1RVT1NweDdBbWRrajFQTkgxRitHYTBs?=
 =?utf-8?B?NjROc2FWam5YRk9ZNjdaMnpIWjdQYWdFaVFSUE9UTmlmSmVxVlFoRmNtZ3Fr?=
 =?utf-8?B?dFhhVCtCWElkS0tKNXpQL2x1czU3dWRWWktyN2RXaEdTZW1OYjdaZ2VqTm5U?=
 =?utf-8?B?RHFLOG8wOW5CK0d6MmtQUDE4SXA5a3hvdnk2ck95ZTM3YVhQZ3o1eW5aWjdw?=
 =?utf-8?B?a1ZPRUt1QXpCckRya1g3TjA2NXdZMElUaHFMYWltK0FLaFV2TU10K1huVmNx?=
 =?utf-8?B?RTZVSnZjMEpUeVNDbnkvVjVNWWRpUnlvVzUyWllSd0lESFh2L1ljQjFZMGRY?=
 =?utf-8?B?U1JRY1g2OVJzbzBLSjZMWGVaKzUvVC9vVHh2c2FXNmtxTzVINkxwR3pFN3N1?=
 =?utf-8?B?SUhQVmViLyttb1lpeHoxY2lucmRsSjh0Skd0VEsyVDJCT1VyR1ljbXJXMmFD?=
 =?utf-8?B?cTdVbGdkK0FxNTh4WnU2QnZMTkN4cFVFbEtORnVOR3R2bVlKRGJ3V0NBSnQ5?=
 =?utf-8?B?SzRoZTVkQ1Z3NVFjOGtZMzhqdXZwQXdZS2NNdGdoTGJIYlZVWXd4YTNLdG5W?=
 =?utf-8?B?cDdFRXVNTW50eTkwTjBEUjdZMEJYQnFpSk0yLzBSSTVKVXR5b1M4SWdDUmhl?=
 =?utf-8?B?RFJFQXZtOWZVbFdscCtOMEdqUzQ3S0tMamJPRFBwV1RVdTlGN2J3Z2tZU3hk?=
 =?utf-8?B?NmdCTHhBNmpPMzAyRUtEYVd4V0p5VHpVK0JGVWQzNDFwZEV1cWZibS9xbnRO?=
 =?utf-8?B?aXhpaDRyZWx2RzRPQjFacnZUOXY5Y2NEcVlQZDRwajVNRjVhTmd1R0prRTVQ?=
 =?utf-8?B?SWpYLzJXWG9XdXAycWZ5TE1BbytJNlk2amt2QTRldFNvOGRjbW0yVzdLSjdx?=
 =?utf-8?B?ZWZDWjVabUdwcnFjK1g4QUZzMnFQcmhXTExlK3RhVHE3Vktndndkc3JHWXZB?=
 =?utf-8?B?WDZ3dFFJcEdjc0ZVK2Z2VmpiY0xWOEF2ZS9UUGg2YmVZMXRyL01uSEFrSC90?=
 =?utf-8?B?YjNGY1FYQkRjMTJQRjN6bGlWa05hTW9UbkoyWTJyZ0VSWW9IdEJsaGxZVS9V?=
 =?utf-8?B?d0hRTitzRU9wc2VaTldNKzZZRnV3OVNiVG9qdEEwQUx2eG04OUNRa2xSTS8r?=
 =?utf-8?B?ZXI1T1MwSEVRdHQvMTdxeFVTbGY3RDEvUUZqbUdqaW1YNzdBbkVFdGlHTC9X?=
 =?utf-8?B?RXNxQ0o0bW5LZ2g2Zk1KV3A2cjJEUFpidG0vbjN3S2tFNWRhMDZIdDgvNVNu?=
 =?utf-8?B?ZmRlallUaFQwSHJSZ2FqNDVVZUF6cHJESVg2TGZvOUJRa01rMVJQR1o5Vnhm?=
 =?utf-8?B?Zzc1enZ2ODJETDBDZy9mN2JmU1kzR1plUEMvZkRNUUk2eVF4dTh1N0p1QmFQ?=
 =?utf-8?B?T3hCZ2NrQkFTOXlBNlI1dEdpejAvYnkwOFh6MmVvSFEwRk9aaEYrY09QQTli?=
 =?utf-8?B?WExIaGdQdytoT29SSmpMSTJkZ1E2TDc4NmE2QVIyOXN5OVJxODRKbVU2VHY0?=
 =?utf-8?B?b25vWFJMOHFFRWlkeTluTmxlOSs5b0F3Q0NDcUNGWFloK1cyTFV2c01CMTl4?=
 =?utf-8?B?dUhuakNVVGNNeStjaWZwV1VFV3dKK1R5dC91bk12Sm5wd0g3R1Y5QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69cf4d82-a679-4702-b8ff-08df1b75ed4d
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 02:29:01.7363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rb0QUeeIySoz4dut90nYcPz3bUtcOiVYOyFxZ1kc6++SsyG8D9VUMSHVDoHSJpunjc8wovKPK2rzKIRP5LmmNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
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

--------------dUVaVQdxXSGQZa5Q8xUsEqSg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/25/2026 4:12 PM, Alex Deucher wrote:
> In gmc_v12_1_flush_gpu_tlb(), flush_type was not properly
> passed to gmc_v12_1_flush_vm_hub().  This only affected
> the MMIO path.  In most cases the flush would go through
> MES.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>

Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> index cfc46f912d475..69f45a32234e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> @@ -389,7 +389,7 @@ static void gmc_v12_1_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   		return;
>   	}
>   
> -	gmc_v12_1_flush_vm_hub(adev, vmid, vmhub, 0);
> +	gmc_v12_1_flush_vm_hub(adev, vmid, vmhub, flush_type);
>   	return;
>   }
>   
--------------dUVaVQdxXSGQZa5Q8xUsEqSg
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/25/2026 4:12 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260925201225.51853-1-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">In gmc_v12_1_flush_gpu_tlb(), flush_type was not properly
passed to gmc_v12_1_flush_vm_hub().  This only affected
the MMIO path.  In most cases the flush would go through
MES.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p>Reviewed-by: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260925201225.51853-1-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index cfc46f912d475..69f45a32234e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -389,7 +389,7 @@ static void gmc_v12_1_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		return;
 	}
 
-	gmc_v12_1_flush_vm_hub(adev, vmid, vmhub, 0);
+	gmc_v12_1_flush_vm_hub(adev, vmid, vmhub, flush_type);
 	return;
 }
 
</pre>
    </blockquote>
  </body>
</html>

--------------dUVaVQdxXSGQZa5Q8xUsEqSg--
