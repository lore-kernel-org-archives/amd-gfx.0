Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CF9C98321
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 17:55:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E286D10FBBF;
	Fri, 25 Sep 2026 17:55:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GnEKpyz8";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013071.outbound.protection.outlook.com
 [40.93.196.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D8F10FBBF
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 17:55:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQvdU3QtDQViTjTcdd2KLmwwuGd1cuaGAvbmDqx9/it+0Xc2AuUnA2NRfEHA2cxWiGd2YSFCzVQH+9UoDzoaUDw2/ijsr+TR2Gv+Iev5J8EHcoC0XegjGoPO+1Fuf4o9yeROZaRSe0fY0FZ76zOa6vPFZiZU530XBt7+Cd+QmEM3wRgd31Swuf3D5VL4LrGzk4QhRrz9hFKIHkWtDgD/JmM+830ll7TndScMpgCrVcJMX34caVdLho41AFzEbPW6+A3HV9brJGjP9o/BIK0+RH8zOqrO2qZUVQVIfhJeD9Ugcj31WThxhBCcM18n8lWS5QCQljPkst/VeaJu+YCD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tluyesXSS+9jIwrxnbGHISOvskvkwPxcj6e2S5UxOw=;
 b=Fz0NxlyydDr5cQEdZXX66lWo1Vjjq7yiBJs1GtmvvXwp/QkZdZ50uUDYIzQv2fprB22WApjntjj6ksEPQFXJS9cWPICJ0pdhvwNgTyvG0XRp33SxKRrmlqGeRePu/4Kc7QzGgUvuJP3U+LU7yMKq6+CoR6yvcU6H9C4fWyvXwCMYupKEg+sKisl46FuH237zFqDZGyNBPsGd4nXhcZZ1cORX/xGKFAna9FcoQAsC7wxRfBwZdnSq/MfNGsSg+S8pXvolAJXLR39RkpknC376k3lruMqFnYRNPK1ZL7GUuGIMf9lyNFNa6ZXRviwUIU3C1X3xtUO2jbsuNKy5nmZrRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tluyesXSS+9jIwrxnbGHISOvskvkwPxcj6e2S5UxOw=;
 b=GnEKpyz8o8tJFV60RJL482R+Mas3CVEA+qyLi8eIN7Pdhv2jqWubsqQ5h4Us1OO1ohZQRE6/7QL1d6WfbR0QfzyycLdAnCHDnLs7y+g6VVFCmoFTlMCtf/f3J5QeOhYhIE6et6px5m83RXntpQnQcdv9QXM+Bt0i1BpTmZNe4UM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by CH8PR12MB9837.namprd12.prod.outlook.com
 (2603:10b6:610:2b4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 25 Sep
 2026 17:55:29 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 17:55:29 +0000
Content-Type: multipart/alternative;
 boundary="------------oA0MJ2iUoGITZmGiCyb3y1RC"
Message-ID: <4d5997d6-a98e-44ad-87ad-78d4f0f79e60@amd.com>
Date: Fri, 25 Sep 2026 13:55:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gmc12: properly pass flush_type to
 gmc_v12_0_flush_vm_hub()
To: amd-gfx@lists.freedesktop.org
References: <20260925174954.2931256-1-alexander.deucher@amd.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <20260925174954.2931256-1-alexander.deucher@amd.com>
X-ClientProxiedBy: YT3PR01CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::31) To PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PHXPR12MB999256:EE_|CH8PR12MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c592f6-793b-4692-842f-08df1b2e2fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|11063799006|56012099006|8096899003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: GgLnFSuRHzxhkOiCeHHXOVl58q6lv8feQeaSjj3c/NuSrWle1r7C7xIuJjZHJnqguWt+wr5fKrIS5NOgHf6yOUNlpdhn+CSKoiUn5Qzl4lu3bahcyS4/AcSO/3YXIC9Uzz8JUlQTJ4QS5YKbQW1FhhbDyZJ9GucCJza1SCWukcAvsqyofyZbeI9OilO+R29TrEm48cgj5NW8Z9skzgp+ovekkkjZgkGQbBIHujir4VB5VPVH/5o5v1Smaq+3aDz6XIAtFjFmOZUkU7zqkWaF5KFfpOD4bZGqf21upn23H2x4FwesxZcBG4UDGEQ5qOt4dU6NwhhD4SDEOCzj/U/Gjr9EOPZjmFJYgVnyg/1e6VFMbjAiMmNm2g7sHN0tVfyxEAd6GAH+YRFiAW/BBbawL8dBD60r5WSPu+n2z7l8POn0kvDzxaYWuE5Qqr4CZopNLB9mnJwRjLo3cMv6wWugM/1JwUeyyGNYiWYmz/j0OJTYaE0EhDFDKhUT7Q9T7xV9xyhv20K9C+SjahCzB+QF4yE2+eJXBC7NYvXjsVAeddZ7NYvTUw7muGTUZx78VcAkvfs3XrMAgKCP0EKhZsIGljEG7EsABQwgbKdEyazkX9L3UeDIxRN4NqOIE2BM2tFTTVSTozDRI8RKjnLc9tMMIa3cVbBFGDcuUH+N6LwtDB0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(8096899003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TCtFc29XMFlvcVRJWW10RzNBc1BLdjlSZVV1b2F0OGlKTGU1Mk1SQTF2VWtN?=
 =?utf-8?B?enRoVjY5RUlrdjd6N0dEdHg1bzIwVzIwN2Zla3dZNEVqY1NNL0w4eGxHMWhm?=
 =?utf-8?B?M1BFRFc4OHJoNFZtTm1pNDVVSjkzUjQ5YTZqdGZQZnd2WDQ0S2FBUTE0VHU1?=
 =?utf-8?B?U0JDb2xsM2c2d3F5ZnQwZ1hHOTJaNEZ1cEFQUW1PcmxWOG9YVm16Q1BUa1U5?=
 =?utf-8?B?MFZYTTlReCtwSFVhYitGUFlhSVJHbXpHYUttN1lHRld0R0hxVFZZMkZwa1Qz?=
 =?utf-8?B?eUwyRTc3RVEyUElwcFBFMHJCb0xjMHp6V21oQ2VZMDdNS1luTWZKWEEyYWZZ?=
 =?utf-8?B?LzlqRGVKNFAxeVI2WjZ0OUhjaHpaL2lvc3ozVm45UlhQRHRsUnY2Qk82WGsz?=
 =?utf-8?B?azlUc0tlMmVsYXdZMDlPUjAxTDRpQnpGaW02MS9EN1h2MjA1WFUyek85ejJB?=
 =?utf-8?B?WkxpTTJxLzRidmNLN0Q0Nm11bEFLUC92Wk9RQWNUTXRWK0ZNVDJCNU5iYXFZ?=
 =?utf-8?B?VERWYWdmdTFJK2M3b1A5eENsOVRueHB5QkZ1RVI4VTVGLzhUQUxtb2dmcFlo?=
 =?utf-8?B?NThHSkhyOUhTMGxVcCtBanViODZxZkxtaUNERk8vU2dIS0hrUGtnbU1PdXN1?=
 =?utf-8?B?TFNQM2VlVWNTWUFaUThndXhHMXMyeDVyc25hNVVkekI5M1pUL1FLeUc2NFoz?=
 =?utf-8?B?WjZiY1RVejVxK3Bud1RGTC81STBLRzhDVHlBa24zaktnTUdVWmlyTVgwOEtE?=
 =?utf-8?B?dzM3QU1ROXVibXlicDV6N2lVUnN6UXcrM2E3OXdqbG4wRWY4ejhyZmxDN1JP?=
 =?utf-8?B?cmtqREdUMlJLUHFsT0JIMHJlRml4dVBVb3hVTjhuOTNGcVNGa3A5ZXVuSWhv?=
 =?utf-8?B?eDc5WlFXTmdGUWV4blR0L3llck5iK2ZRMmQvTysraHpRaWtRbmpIMUxla2cr?=
 =?utf-8?B?U0hZNDVnU3RLQjU4S1JsUElNWWF2T1MrMVBQbDQ1YkFJTjZtZXU0eERCbDJz?=
 =?utf-8?B?Qms0cExzd0FjOXlMQkpTZVQ1cklrRWVudUdUVGk3MElLZTRqY0pMYVFvVU5N?=
 =?utf-8?B?YXB4Sy9iMUNIcTJPMEdNdUsrZW9EcUloQzU2akNPdFVwZGxKMU42Y015N0NH?=
 =?utf-8?B?QVdjeEJyclk4N3VIdEh4VnZEL3MwWjVERy9Qa0xvNjZqMUZTUVRRdzFNOHUw?=
 =?utf-8?B?b1NWTGVITytudysvbUpqNlRWdm1GTGkwSWg4M2lSckZ6SGtLZWFCcGIwbnFv?=
 =?utf-8?B?M1VrQklwV2VKSlFvRFVXMjNUMGVqaFc3VFU1d016eGVPV3JVYW92UVp4R1Y4?=
 =?utf-8?B?WGZTL2VzSEZDcDJtMWx3QnBLTXp6eFFsY1VZRkIzOE4xK2w0ZmFpY3oreG9k?=
 =?utf-8?B?Y0xOVlZFTW1tTkNIZ0hMSncxRFV6Q1JxNlFlVjVTN1BRQUd6ZEMxelNleWVV?=
 =?utf-8?B?UFhtRzVBK05uTi9la1QrdGIzeHRUOU9teEUvSm5VdGh5WTMvNXlmTEZ2VHlu?=
 =?utf-8?B?ZmtNZVE4cWF6cXA5Y2Z2am5BS0IvU3Q0TDQ3aEhoMFQwOERQWFdaV0pwbXBx?=
 =?utf-8?B?NWFRZVVsaDNiMEdLRkpmMjNGRDhHOThqejRtSExCN0VqcEVzeTErVmkraTJZ?=
 =?utf-8?B?MGc2Vk5CSk9oQ0NsUk9XSjRqS1dRejIrNTlEMkliR1BNYjA4TmoyL3BWblBy?=
 =?utf-8?B?bkVFZVR3ZENYWGVIdVlQM0NsRG5BZjN0NTdmbDMyZHJ4L05ZSFFrSnkzSTJV?=
 =?utf-8?B?YjhKQXpYRlV2RVo5SWQrbWQwWWFBYmlrT2Y0R3JSV0RTV1I1emVrWGRmUU96?=
 =?utf-8?B?eUZkYzgzdmxpSjh0MDBhL1pUMUFIZDRIL2FIbVp0d3gyVGJtbGMyc3E5bklw?=
 =?utf-8?B?djB3TkR6UjBINy9xbGhpQ1doKzNNMGpoVVd6Ry9iT2phTFFUVGludlpjQ1JJ?=
 =?utf-8?B?Ymx6T1hzTTlvckkwZmNpMmFRUWtkc3VHTVNpT01MaUJvRmpJZEN5NWpaeFBo?=
 =?utf-8?B?N1hhcXlYNE42UXo0ZTUrcjFnNERCTEsvVUhtRi9ZaUl3M09HWk16ck1vMUkv?=
 =?utf-8?B?VGMrcHZBUEhYMTFvTjk4akN5VFYyaURRT3ZPTlh3SW0vdCt4Um83NlFVTmYr?=
 =?utf-8?B?TXBpT3pHaEg1S2JtcGMvY1lxYUpDZXpGWjVKSXVqV3RJdDBSbTVjem55enho?=
 =?utf-8?B?WDdqaUo1THAzZEZSRzA2QkE2ZVg1cmxROHBNN0d4bnN3cFZyQmZVUlozTWlM?=
 =?utf-8?B?RUZGWmJ3WnVISTBsNU1ka3ZSdjZYNi9pODNlUFVYZExDTXpwenc2ZVgrK2Ju?=
 =?utf-8?B?MDFTTDRxeTI4d0F5MEpqcGdNV1B2Mk4xbUlSUjR4NkRSZjdDMWtBdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c592f6-793b-4692-842f-08df1b2e2fc1
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 17:55:29.4434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkwFKa9GclrWF59bShsgdHHrLeC0zB5qAX+0BmpeHootVTcUJ7DM93tutxIWqBh+In5Q5oPE344HAYKyUdpFJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9837
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

--------------oA0MJ2iUoGITZmGiCyb3y1RC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/25/2026 1:49 PM, Alex Deucher wrote:
> In gmc_v12_0_flush_gpu_tlb(), flush_type was not properly
> passed to gmc_v12_0_flush_vm_hub().  This only affected
> the MMIO path.  In most cases the flush would go through
> MES.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index d7f56bbcfd440..8e3fe16668c9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -331,7 +331,7 @@ static void gmc_v12_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   		return;
>   	}
>   
> -	gmc_v12_0_flush_vm_hub(adev, vmid, vmhub, 0);
> +	gmc_v12_0_flush_vm_hub(adev, vmid, vmhub, flush_type);
>   	return;
>   }
>   
--------------oA0MJ2iUoGITZmGiCyb3y1RC
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/25/2026 1:49 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260925174954.2931256-1-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">In gmc_v12_0_flush_gpu_tlb(), flush_type was not properly
passed to gmc_v12_0_flush_vm_hub().  This only affected
the MMIO path.  In most cases the flush would go through
MES.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    Reviewed-by: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a>
    <blockquote type="cite" cite="mid:20260925174954.2931256-1-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index d7f56bbcfd440..8e3fe16668c9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -331,7 +331,7 @@ static void gmc_v12_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		return;
 	}
 
-	gmc_v12_0_flush_vm_hub(adev, vmid, vmhub, 0);
+	gmc_v12_0_flush_vm_hub(adev, vmid, vmhub, flush_type);
 	return;
 }
 
</pre>
    </blockquote>
  </body>
</html>

--------------oA0MJ2iUoGITZmGiCyb3y1RC--
