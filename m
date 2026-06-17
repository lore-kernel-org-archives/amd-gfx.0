Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283A0CD98ED
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 21:10:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A777910EB4A;
	Wed, 17 Jun 2026 21:10:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0GKVDJxC";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013030.outbound.protection.outlook.com
 [40.93.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6579110EB4A
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 21:10:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=II5uedOQb4Lhm7kswPilwAbhYss768xtuoKPTvCTxrnz1okpbr0PJOw4ZcQA/T9JIC4fRWS8h36/Po8yru63H759r88cKCT6CPHKV7X2It0RQoL4wHqChDbV0v8LLpdhnEh6Wh72E4geny79op3AibgdW/bhjQYlEBNR8++wX+hkItgbE5+oLhZxpprJHBleBjAYME7QDoDzyZwXXG9kNwZpuUGAAatSPNuY7CeOBSIgWeHV3rxx/MV8HstCxzlTDg3CpQXp+2SrXQUfFl74lORufcezh6U0FBdN/SSCbGEp5y3/sUZAXLI0gn8Fa3JOc5ZRAKQHFO44CTKCLYgkbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oGX7hz/oGduFtRyLLmMiipdf7Lmz+uL3xu4ltF/k94=;
 b=xKR+59cNz0Ny/aUsottCDuJaAUC27FOBwgjW8JNgUZ7Gpf/kvaxY2BgRuoThUSPrf2lfKekimxj09Af2+xYUq51gqmd7uKkFQZg7zHzOX094Fk1BDzNf/2GhKW3C/nd3BHooSRIQYTVbEubJ9dl3VnrsbJxRZC4UmCk+1djjwohGedK/whyOzlmB9yKt5v4cXHFDs3uX6b0ocqRT1FxXD2jUKW1jNYzrkTVEnYSP5W0BlBqYM5zzlhZv3YM1IvhF+PdycNOBB5i9EJSLH6z7rXgV4WWxnujehpsqsE86H8dg2whRLP9/KHTz4bGSqBihjEaSijEZ+ILbiuJz02LAow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oGX7hz/oGduFtRyLLmMiipdf7Lmz+uL3xu4ltF/k94=;
 b=0GKVDJxC4NAV14XSdmu04eaX760tSxOa3+I9QVXbLdTYiCl3mtzE+yo3lCJ79Gltq6V2bu4Fa1pyS7q66JAgmODmzHQmpnO9BCzeNqaniV9zFrJNlTjiHdkUCYmAItDRTx1nvt2RK2vN/iDQ5pMnmco5iiy+MaeMR8xSc6SN4Bg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 21:10:13 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81%6]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 21:10:12 +0000
Content-Type: multipart/alternative;
 boundary="------------9xK0DsDnXG7nyubfXuc0eB0J"
Message-ID: <2a87bc01-d120-4af4-b70e-f51971b41c36@amd.com>
Date: Wed, 17 Jun 2026 17:10:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: add overflow check in svm_range_is_valid
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20260617184558.249687-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20260617184558.249687-1-jinhuieric.huang@amd.com>
X-ClientProxiedBy: YT4PR01CA0357.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::13) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2581e4-c87e-4799-9d7e-08deccb4d23d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006|8096899003;
X-Microsoft-Antispam-Message-Info: U2bFhLtnZ5kRBvuXWy7yBSXBos24bQsE0QF6GMQsVYPgp6U+ldGA1R9PfaxCx691JiiYbRTYWcMhOWxOVwDy5Fl+6bxBrALtiRZ0JFTN/3Qa+VlTnjMBOTmr/0jvi4wAed5yJBa/fsQdKEtu4gtZw/cQKB9LUk1dzEsmMAH4rN8lR9KMliscemCdxV1YUqeHCsjER8GX/MSU6Ma8R2U9k/Gk/fvZqygcnOB3VMuPaC8wJZxBg2ph/PK8tmd3m160hsmSsSg3qXXota2T1E5pj+YUrTtcm6PLYIpJCYQJfKo29juXaquBE8clJC7mHic+h//lWxHmype9lZSEJ1d23xCxbVSbiJSR121iI9JDtYKXFqgAl8KC59w1wEfZefWI/DBz8weWtrohoFDcpedC9nt11h3WKVuG/QowmbP77sofATlR37DKxrFnxsbj/3OvLPRdaMsfBpXbMhdZ8LK6QPDoz4xbpINch64+s/arHSUqgjALYFVrP9axbJbQzyy8IG5e2VlqCYAcm4s2sFWVlktsjn0HIyM0YzkuMOhvb5dorYXwcZZ5dJeaCzqRGrSYKoAUXhliMWQH4ojZndost/uligNdoc4Zcd5R7kJH4Ue+Ve+c2AQR46bWXqsse1EWj6utMaTmRkiWazXEUjhkBiNyh4RwVl5lndHFOqVsBXNURERWCo6LdXvAmE+pxtXI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bS9UUmxoWUtJOXV0VnlLVHo5NGNLRDhkNmNMaUJNTXYvRlZ5M1hiTnc2M0pz?=
 =?utf-8?B?YUQ0UGpjMFFaSmpLNEs0L3hjYjFVejBDc1B1OTRLeHFmQTQrc0w5azlWVG0x?=
 =?utf-8?B?WW52RnkxZEpXR3FlK1M5MkZGb3phRzUwcUxrTy8yaUF4dFVtY1IxWGZ4T0Vp?=
 =?utf-8?B?YzJTOHpCejFuUytTb2ZmMUpnTkJ5cm1lZ3g3RCs5VmJEV3RZOHZGM3FmREtD?=
 =?utf-8?B?TlRNbG9zNXlVYTJYbllKeEd5Vnh6UENzbnh6ZGVFanozZFgzMUNwb3ozV0FC?=
 =?utf-8?B?ekFyMmx1dzdEU1BxalcrM2J4Sm9aT1pBZzMxL2JFckdFOWJPb21uR1VOVUZz?=
 =?utf-8?B?dExKTFk2eGxZNUJJKzFKVnk2Z3kyV3h3TFRVczZSZC9JRk4rNGpBUWtKcjlV?=
 =?utf-8?B?QWh6cHFvUXZzVzliRXVqZlFDcXc4OEFDY3JRQzgrOXZ1SkZPZ0hHdWE0cFkz?=
 =?utf-8?B?U2JlSkR5L3YxVXo4d3hxVjQwUzRIK2VMUFRPTUIwK2lKREJ3cXlYUTFvZVFF?=
 =?utf-8?B?RnV0Ky9DRXZLU0NVRks5OGxLVXlocEQvaFc0NUc5NW4xRzUvQVdFajlzWUNK?=
 =?utf-8?B?YTZEd2hYb1JvN0NMemh1Lys3cW0xdGpEVUxLWURjZUpWZnRtZ05ZUGExS2p3?=
 =?utf-8?B?Nzl5Vmo4NmRsZjhNYk1HMTNpS3lraFJ5RTZaZmRhR2g1UHdqUTRybkxPTjdV?=
 =?utf-8?B?Ykw3NFZCN0YwcVdYYktGazhiNFYrdU9QWXF5R2VoY3VvcUhlUUU2aU56VEQ3?=
 =?utf-8?B?RUpDamZtekNVVTFuUi9ocmtoeXZocHlPMllIcUhDV0xCd3ltMHNSYmdDODVw?=
 =?utf-8?B?T3czQlVhY1pWcDJVMzI3blJlbUxHVUtxQ0pmVDFveXhtZi82bW42em1XRllO?=
 =?utf-8?B?SlM5WWREQlJFeWlVblVjV3B0aGwyNzQxamIzL3FNVFdQaTl6YmJPM2FHcG1q?=
 =?utf-8?B?Smo3OTVFbml4TDVrdCt0QzRpcDZzVDVLc1NwbTZxejZnd3M3bVdoMTJXWVVq?=
 =?utf-8?B?ZmFxMU4vK0pxOStUazV0dW5MR0EvZ0RCSzAzUGY4NUM4T2NuZXRVdnpyb2Iv?=
 =?utf-8?B?ZkhvQTlIRVVvK08yM29HLzY3cUdJYmtBKytLZ3orNTM1NFVWYmJDZ002R1NK?=
 =?utf-8?B?TUUxSXkwL3JKNnc3a2hFUVg3b2FOaWVoMXBQMWIzMGZtaVhUWHJrMXMwODN5?=
 =?utf-8?B?SUU2N2lWZy9qckxoaXFNNVh1clZNcHU3T0ozSGxOakFRa1NPeXNNbzNJSnVw?=
 =?utf-8?B?UXlSKzJFVUFrcktwb3RDSkxkQjdiL2k1MU02TWEyaTA4cEhoaTRCNHJkMGF2?=
 =?utf-8?B?SHMxL0MyZGQ0TXkraUZNaG5xZWwzNzgxNGVoMjV6KzJqdWRlVHkxWmpqVVBH?=
 =?utf-8?B?NW5KUktHRCtJckxENWFWMGU2M1c0WlBDRXUwV3pPMithQ295MC80REovb0dw?=
 =?utf-8?B?UlZmdUJpdTdKUGlHazljVzBFTFhaaDFwTmg0dVBOTlhQVkJwd0dZQ20wYTJ6?=
 =?utf-8?B?S1pYMC9meldGU0hFK2hoS0dzTTVyajRyR2hmMk5vOE5WbU9OdGkxUUx6MVJu?=
 =?utf-8?B?V0Nvb1FlYXhqMmNHeFQ5bnF5UzMwcWhCWm9qVlhjUU9oSEhCL3h3N1RTYklB?=
 =?utf-8?B?UlU1ekdpSGtyTHQxb2FVcTNMeUlLd2dTM29ua0dxVERJb2pGbTRYK2l4OHh2?=
 =?utf-8?B?WWNXVVRCMkw0N0xUNndUeGJOMHFxWkhqZVBaQkdHa3ArYjJ3cFVWZ1VvL2pV?=
 =?utf-8?B?NElOcnU1RkJxdXdvZ0VOdythbmZWYmFNczYvMWs2L3hUZ205a1M5dVVibEU0?=
 =?utf-8?B?R1lMKzRxaVpRd3pTb2tGRndCbU4zWDZKL2dtVzkzRTNDdlU1bkxOVlRwNllv?=
 =?utf-8?B?Qk9STXk5OVR3R25iRjJtWk4zQlFoQXpDWXk1ZlpPdnJVWncvajdXY25BNXdx?=
 =?utf-8?B?TWJGSm1TRW9nQzZIY2QvWEJCbEYrdnJIb2NIcUNxRGRLY3BiZ0tqbHJOcGFt?=
 =?utf-8?B?TkV3bHczOC9ZTkZwK3dnRW81c2RsbUkvRTF5V29XRWdVZUhkUWZoQU9MY2pt?=
 =?utf-8?B?aHJ1TUk4TFpmTTNPYXkrRm53OWR4Ukl6dWQySzZZOEVDN09uTmJSR0QwMmhO?=
 =?utf-8?B?WWZKT0tVNzlTTnpHdlFnU201dmdxU1hwRmhYZmJJRStad3pNYTBDaXJFT0Qy?=
 =?utf-8?B?aGJmQ0RESFBQMmpFWFlVZ3lwY09Pb1Y2Q3VKY1J3dTR4SDJLcUtXUzVzbjJi?=
 =?utf-8?B?Z2J4QXBZOU4wVXhHbmFKQi9mazdHdHM5WHRvbXR6NlUwOENrdk1JUmd2NWR0?=
 =?utf-8?Q?DUCxBtrhKThXsXiiuY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2581e4-c87e-4799-9d7e-08deccb4d23d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 21:10:12.8274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWQLFAm3mInkMpxyXmys4J0YiW2j5G1UKsgRhSI8Ev/0Frilf2zC6W7aEH54T13b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874
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

--------------9xK0DsDnXG7nyubfXuc0eB0J
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026-06-17 14:45, Eric Huang wrote:
> to prevent svm range to be overflow.
>
> Signed-off-by: Eric Huang<jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index ffecd818e611..ad4325d25e7c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -3473,7 +3473,9 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
>   	unsigned long start_unchg = start;
>   
>   	start <<= PAGE_SHIFT;
> -	end = start + (size << PAGE_SHIFT);
> +	if (check_add_overflow(start, size << PAGE_SHIFT, &end))
This looks good to me, as you are here, add another check for size==0 
case, since this will have underflow
last = start + size - 1;

Regards,
Philip
> +		return -EOVERFLOW;
> +
>   	do {
>   		vma = vma_lookup(p->mm, start);
>   		if (!vma || (vma->vm_flags & device_vma))

--------------9xK0DsDnXG7nyubfXuc0eB0J
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-06-17 14:45, Eric Huang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260617184558.249687-1-jinhuieric.huang@amd.com">
      <pre wrap="" class="moz-quote-pre">to prevent svm range to be overflow.

Signed-off-by: Eric Huang <a class="moz-txt-link-rfc2396E" href="mailto:jinhuieric.huang@amd.com">&lt;jinhuieric.huang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ffecd818e611..ad4325d25e7c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3473,7 +3473,9 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
 	unsigned long start_unchg = start;
 
 	start &lt;&lt;= PAGE_SHIFT;
-	end = start + (size &lt;&lt; PAGE_SHIFT);
+	if (check_add_overflow(start, size &lt;&lt; PAGE_SHIFT, &amp;end))</pre>
    </blockquote>
    This looks good to me, as you are here, add another check for
    size==0 case, since this will have underflow<br>
    last = start + size - 1;<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:20260617184558.249687-1-jinhuieric.huang@amd.com">
      <pre wrap="" class="moz-quote-pre">
+		return -EOVERFLOW;
+
 	do {
 		vma = vma_lookup(p-&gt;mm, start);
 		if (!vma || (vma-&gt;vm_flags &amp; device_vma))
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------9xK0DsDnXG7nyubfXuc0eB0J--
