Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCB0EDB7D0
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2026 22:07:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0002D10E0C3;
	Tue,  7 Apr 2026 22:07:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k5HhKcnQ";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013034.outbound.protection.outlook.com
 [40.107.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A867510E0C3
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2026 22:07:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnkA/otAvmgr4Ke1dYfjTT5PFkBGbBI10kBncNnFnjF1/pXB+5/tG1nSCBZMzzLDU7A7U0/YkUJb/JRm8ScpPSZE0BeMFriYZgLh03jepLswGBHuWs5Jtii0Ej7fc8HlkVfxIEvElxCjxfdDntfqQolM2wa+ZIbl1Vb0OwcX/QAq5X7iywttERdlFShu13ypgHsVm4aS6pUAFENiLVroEzrOLhIHkTvUSf+pyNK0aLowStuPVbawmId1TiXLlSnDZ3bzI6cuBgWaywpHYJ4yumQIRaeYzREbGoc0hHtJxOxGvY7XFRhmet05zkGCUThVUbO/+CpF3sDAkF19QVYIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zN4qsIxvfPExLKig7G9TK0Gq60mmPY6OJPu4B83je+Q=;
 b=kbZvYw6ZUiXQXv16LLW6CgYGP0Dr76jPEgtCcE4tbD3QFcjAgrbgqptPIxVhL6rAsLhFMyXB/4bCjFX6fVqVYr57pxDiYduDSBIKnaLkda6+PiYqzHsVhmQnqxcYKzPhLqE7WOAElVFFP5cT7DbjzDpGZMaomoo8SL8nwDjls2qfHAIVoPI/t5Yc6lW03DfSwcJ18TFjQ6y4wwu1HVhbwLBf/ysLp+W3EEVatAXcAH6jDeLBBCnknDdNJJfEZJ6uz+bpOgQB/KeugkGsvjFjlqS18NNYo3F0Ofz43U2e6uyjfqXWg7ijhXyf/oUHEw4bcvWAK6xFiYp3D/fBzFftjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zN4qsIxvfPExLKig7G9TK0Gq60mmPY6OJPu4B83je+Q=;
 b=k5HhKcnQKzPPF8QiY2DxfZ9KwIAa0Wi104jM8w+BGk/0Vay7plULVD9aiowZmF4jDkcut2bS34xMPAnxTYTvGxlBn2u2y9FEFVRXP1YuGdGmzg9ZZR0e8O+EoI+nvOK2oy8OwIxdH23rPzUKWKOggpq+TO4p49O2iq0aKiRZFq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH7PR12MB6658.namprd12.prod.outlook.com (2603:10b6:510:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Tue, 7 Apr
 2026 22:07:01 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81%6]) with mapi id 15.20.9769.020; Tue, 7 Apr 2026
 22:07:01 +0000
Content-Type: multipart/alternative;
 boundary="------------40E5Fj65k00YeP31jMTF4Pkv"
Message-ID: <8c77a0ce-8f02-4ff7-8add-9e33a4caf5fe@amd.com>
Date: Tue, 7 Apr 2026 18:06:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Remove sys file
 compute_partition_mem_alloc_mode at module unload
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260407213032.4087036-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20260407213032.4087036-1-xiaogang.chen@amd.com>
X-ClientProxiedBy: YQBPR0101CA0243.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::24) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH7PR12MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d6c0512-fcfc-45ff-b416-08de94f1fea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|8096899003;
X-Microsoft-Antispam-Message-Info: 8HMXWyDWbrmEbhHXFRTSGeYgMl2/81Pmz8EweBL4MToxsW2hzn5yvX2bgaFx/KUiQOV0oYWgjAT/+QFT3KdtN8JoYNrRGq367Lefs++Srjq678x3XKkqrST4b0GUDCKM4u25BXAF3kHS9VQqrC1/jZZ15WPYwkDm8ryUlXmKHIuzfazDuy+tqTVs7F7MC/sq8H7ZihLK5rYF5w9kTAgYcBP4xfGGIiWfZ20sm6uFFgR80dmk9KNX+J2bMC8kciwUoGo678qKZq3OZmvYry9TYrps1kwytEq99SVXO+Xx9e4aJ6YJrfEJmHAVAGaSo8e+S6qHuEgZY08oRelcrI5kD2xeEoEZT1wuou2Py1ENb4TjoZCIpr79Ri3ZUV8xSTSFuphR8mZpFgXtpC5cLfVuQCf00/Cj0Vw7UmONrHu2CmNg6rsECeg3wTCuzgjTrOqyKAHEXUgCRIxaUjKr+qPxLCWwZlf1alBXH086vWdU2YtKQM+W6ThvkSnmfxL2lh6KqwJ2SxOW9C+Uj8Zo+tCwXJ7t2/2DANtsnRjdT+wVkVZmotyz0oz+ydyGqCar62ze0AYBezNyMv1nCJFOtkEqmz3wxmaIyayaNVCQjLfnExeQuO4WuHe59037cKv1EHRWI5Ckknrx04UeixCHjXARm2SFfLjInJTFK5Cm6n4kEDWYivVZNap28p6nshP9EDq9N7DIEa+8cbpz+IjQ683y9Y05EBr55jzm3VJSPmvzYPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUJydUZiZ1J0SHlEL1hmamNodnFBV1ZiQUd4MmRxaEdxemI4Q2RpNDM4TlV3?=
 =?utf-8?B?YVhFaG83NnNFbCtjTXRFSmVNNlFqZ01ZZUlSYU91NEVHVzJpY0ZTMHorVExu?=
 =?utf-8?B?SVgvenFHTHFMbXRTMkxjTk1Yays1cmsrRDVFY3FXQ05uK1V3ZkZFeGthS2V5?=
 =?utf-8?B?REdkbkRkTU9tSk95RnQzZW9EeklHQklsMWo1QTZoMkxJekgxUTRWcHI4b1RS?=
 =?utf-8?B?SEUvNERTYVFCc2lCTmxmWmNOTkhQeGRoejNpYlJldEt6R3NjeDJ2c1N4Vndx?=
 =?utf-8?B?RkU5N3QvcFhQUWFpUVdXdVY2a3lIaW54VUFTUDREc1R5MnU4QnRicWhsRmNB?=
 =?utf-8?B?d1F5SVlGZytMZ2U1cWgvZk5yVlV6cVNCMnJwYWRBSW5uQXZVUEx0eFlPZm1l?=
 =?utf-8?B?dFkydUpYb3lhZEpSYVdZdVNpOHVnUDIyNUN6dlF4aCt4NkN2T3Z3c2Uvc2lF?=
 =?utf-8?B?VzFmK1k1YXFlNE1jQ0FSdEJUS2YxOWRWZVRKTUs2RXRXZityRk1mL1NkT1ZC?=
 =?utf-8?B?V3lhZ2NGWHBFNTliNlhFWnhGbEhnR1RDM0JVdHYxNEQ3V0lyZkpubmwyRUt5?=
 =?utf-8?B?cHFuSE01WDNxRlVPUTlUKzA2eGdRNlpxeTA5a2tiTmdoeWFNQmpmK0tRM1RN?=
 =?utf-8?B?UHh1L1BSYThaS0ExVFdGS2tHSGI0SnN6U25RU3RKTlBzVHIwYWdNa0hmUjVS?=
 =?utf-8?B?ZjJxd25WZzI2OXNpaVVpVHY1dXJKSnB0YUpQY2xWRGI0YlZpRDRSeVR1UzNp?=
 =?utf-8?B?QlRDOG5oMHRJREdQU0JVQTczOWVKS254akFaUzRsNitrR1Y1ZFY5SytpOW5J?=
 =?utf-8?B?VTZXOCtHcXBvbE01c0JHZ3pYV0l4STl2N2Y5ZU0zY1NPelc0OTBiWFFQOXEr?=
 =?utf-8?B?bVdMRVk0R25kVTdlb2JRMkNwQzM5OUdHYlNaTmpWSmRFQnN0M1pCN05oVVlX?=
 =?utf-8?B?MlM5eW9vbGtrN2NhNmI3KzMzR1dUdndlbnNlU3M3Zm9xK3FTYVVFT0lFQlVV?=
 =?utf-8?B?RFZhSlBjVDZlOUk1dklXYVZmYjAzV2lIcHcyMnFTVFVSajNDVDJRY3dVSnd0?=
 =?utf-8?B?YTJHbDRFYllSYWxOTEt0TVNVYmd2a1J0U1drZkw0U3Z4cEpXM1Q2YWZKM2VB?=
 =?utf-8?B?U09xQmNTejlMZlQ0dHFPRHBtcm9aWnQ0eGN0TklWZjY2THcvbFdlRjRZREQr?=
 =?utf-8?B?bzRNV3Bic3VBSUl2TWltN0N0WGhldVZVRlF5RzdGUFlONytYT0tNS2llMEFi?=
 =?utf-8?B?YUI3WTYzdXUvU01PdjdLdlpIUXZpK3RCeHd6Tnp3a1NRNmM0aUg3OXBLQzlx?=
 =?utf-8?B?UTdPR0dYaVA4ZWczQmhmT2FGNXh3RnBlRStuMWYycHo0UlRWNzV3djQ0aFRT?=
 =?utf-8?B?N0c0a05jVkxDeW5JZ00zbUUvb1gyOFZZd0N3Vklrb1pISk9jcU4wV1RscG5I?=
 =?utf-8?B?SEdGSVhZay9kQVBwaXYvVXpPdC9ULzhCdXVkZFZRNUJEdTlueWNEc2VPclhX?=
 =?utf-8?B?QkttQ2UzSzVGSGhleGc2T3BjQ2toV0JML0tCTjB4S1BPaSsycjRQUU9XSEpm?=
 =?utf-8?B?S3FzM0FtOUN6anNtQVNBcnViWFJIcVJNVFdDY3BTMUhMaHcyNWdVRGRYVktS?=
 =?utf-8?B?dmNvZU0xREUzamtwUnhaWkpUMU9pQmxWZlUwemY5bzloQy9PcDNkYXhFQjly?=
 =?utf-8?B?UDFRVzdZU3FlMTNvUDY2L2VnbitkeVJmZHA2SVVUdDE0ZEFGOExsV1VGakxQ?=
 =?utf-8?B?OVRNOTJobXpRRXV0OEg0dklJNnIxY0NJTHJGbnJrRUJJWk1tSXR5YTBtZjJ2?=
 =?utf-8?B?WGE5SXRXVUFCMnl3MzRueDRxWVhIdnZtZ1dDVnhZaG9BYnRjU1QwL3hueWJv?=
 =?utf-8?B?U0JMNEl5WmNyOHh5MWt1NEhRcEpQY2NCejVCQ2YxZndCaTFXMExmaWtJKy9z?=
 =?utf-8?B?dVN3UzdlRGtIYVhIUUU1cDRLL2dNQ3RlWWRjYi9uRzUvTVNqTWhCWk5TajIx?=
 =?utf-8?B?Q0UwQkc1a3hTR3lGdThYdlEvOGlaL2x3UE5Ic21oZFlWbnZUVE52L2x4R1dF?=
 =?utf-8?B?K2VodzN3RWIxa2FSOEZPRExKd1Z4UGpOK0NkQWdQdjM2bWhRa2xsYm12OHUz?=
 =?utf-8?B?VlpMeHFBZy9PRmUzSDRMY1hvY09HY1pkdncrL3lzTER2Um9lZDVMeXF5aVVa?=
 =?utf-8?B?SjhaemFoc1Azb005Nzd3US9IQVVKUW9aTFpSUjJnaGJCWkM4aytiSCtveUE2?=
 =?utf-8?B?ZTJjMURzbVVtaVRxVFpRVEZOQkFQMDJDTWg3MGF6UERUQkJhOXRIYnhDN01L?=
 =?utf-8?Q?BqDWIlgOrqfkYsKm5C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6c0512-fcfc-45ff-b416-08de94f1fea0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 22:07:01.4553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xk+ktWd/CwKfqIyZL4BqBwpxSS2uTIzjBmJTCPM3fFJbZ8WMKOnYnvADrmMff2D1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6658
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

--------------40E5Fj65k00YeP31jMTF4Pkv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026-04-07 17:30, Xiaogang.Chen wrote:
> From: Xiaogang Chen<xiaogang.chen@amd.com>
>
> Fixes: 147263e551eb("drm/amdgpu: add an option to allow gpu partition allocate
> all available memory")
>
> Module reload would fail when create sys file that was not removed during
> module unload.
>
> Signed-off-by: Xiaogang Chen<xiaogang.chen@amd.com>
The fix tag is eaa1281bfa2c on my upstream branch, with the tag fixed, 
this is
Reviewed-by: Philip Yang <philip.yang@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 2956e45c9254..b8ca876694ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2013,6 +2013,8 @@ static void amdgpu_gfx_sysfs_xcp_fini(struct amdgpu_device *adev)
>   		(xcp_mgr->funcs && xcp_mgr->funcs->switch_partition_mode);
>   	device_remove_file(adev->dev, &dev_attr_current_compute_partition);
>   
> +	device_remove_file(adev->dev, &dev_attr_compute_partition_mem_alloc_mode);
> +
>   	if (xcp_switch_supported)
>   		device_remove_file(adev->dev,
>   				   &dev_attr_available_compute_partition);

--------------40E5Fj65k00YeP31jMTF4Pkv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-04-07 17:30, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260407213032.4087036-1-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

Fixes: 147263e551eb(&quot;drm/amdgpu: add an option to allow gpu partition allocate
all available memory&quot;)

Module reload would fail when create sys file that was not removed during
module unload.

Signed-off-by: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a></pre>
    </blockquote>
    The fix tag is eaa1281bfa2c on my upstream branch, with the tag
    fixed, this is<br>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a><br>
    <br>
    <blockquote type="cite" cite="mid:20260407213032.4087036-1-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2956e45c9254..b8ca876694ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2013,6 +2013,8 @@ static void amdgpu_gfx_sysfs_xcp_fini(struct amdgpu_device *adev)
 		(xcp_mgr-&gt;funcs &amp;&amp; xcp_mgr-&gt;funcs-&gt;switch_partition_mode);
 	device_remove_file(adev-&gt;dev, &amp;dev_attr_current_compute_partition);
 
+	device_remove_file(adev-&gt;dev, &amp;dev_attr_compute_partition_mem_alloc_mode);
+
 	if (xcp_switch_supported)
 		device_remove_file(adev-&gt;dev,
 				   &amp;dev_attr_available_compute_partition);
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------40E5Fj65k00YeP31jMTF4Pkv--
