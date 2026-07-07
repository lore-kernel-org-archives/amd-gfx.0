Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D39C43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 18:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C32F710E516;
	Tue,  7 Jul 2026 18:11:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uZHiRiRJ";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010044.outbound.protection.outlook.com
 [40.93.198.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45FB810E516
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 18:11:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQ9KF0ABNJ2H/1A3UwOexuDYdo8Owj0koxALT+OnRyUA+OYvelU/dVzTmXjGVycirrHVOco7GxaXpsapXO85WaDzajZZ46uisjnvrTRD6PkMTiwwpjGZuSXW/XFsMT7gzZD3qatNn8ZUFkd4ICg2NSgQP3vjSMm9Gluo3ItTFdAlwwF1Ilyla/pETliVXLLmpYom45Cd8ciMtaD0FYD4qaccnqkNfF62A0ke2KGu1S8mjEp258IzH30Ue74DEWLEZxYQjL3Fhdj+4m0278iXaipJE8wx/nHyg4HKY2vKAAnOZQTxqD/Mrd1QpoZ1X0KgjnCZDLkasOZH3ahmFHlZNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuS6FNIX2uq7Xs6npffFBElIL2gG+uTZgK6nqbcXvfg=;
 b=CM0a13cAhpXWVzEkxYMnlhnq4w5sd+g6VfBNRvb8bxB2UGogRpnp2I4U9KETcMmaEPBLDmn6+Fj//dInXp7bbHX2+dSsDxe4U+m5j8PH6xc5mEvcmeVu95jX2kpp0h3YnaZoP+J/ig6xv9O+lI0OLWsw6uOzbG92Wz0ThLJ3bBCtLLUQx0LK6i1qQEOrbssM+qE1K9/XcaZh6iYTW2q7YyuerjA48aMf1tHqn1SWdYVTxFBS3SDvPHVcFf0UWbYP3wMxSsR1AzjkgVdt6SzNX8wqfKG/rQfZKLyTdSQ+OuIUkIH+UP2ARTwmpQzO3TMU8WvCNp4bZg2wjDdxrbV3pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuS6FNIX2uq7Xs6npffFBElIL2gG+uTZgK6nqbcXvfg=;
 b=uZHiRiRJWmQWp8fbufL+rQZ9p2vfOOA69rQdO6gi9VBuZGY24wfsGgY+rXS22mjAcitzrjHlHROc89Dvn3iDQEzWuxxwHPNo34JpuW39Z6MVz3puygtwpGsb9xG3lPr4K9reXQgoxhis9pLCpswqP0HOQMe74RUW8FjzmJ1Tlj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by SN7PR12MB7156.namprd12.prod.outlook.com (2603:10b6:806:2a7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 18:11:44 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74%3]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 18:11:44 +0000
Content-Type: multipart/alternative;
 boundary="------------93zObU3RXKAWCPbEpYrMyzR4"
Message-ID: <e7c99ba0-261c-49a3-8f03-3a374e3f6fb5@amd.com>
Date: Tue, 7 Jul 2026 14:11:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/amdgpu/gfx9: fix IP dump alloc ordering
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260707180021.2642432-1-alexander.deucher@amd.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <20260707180021.2642432-1-alexander.deucher@amd.com>
X-ClientProxiedBy: YT3PR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::35) To BL3PR12MB6425.namprd12.prod.outlook.com
 (2603:10b6:208:3b4::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6425:EE_|SN7PR12MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a34333-4b65-47b5-a854-08dedc5333a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|6133799003|8096899003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: zD+RcejWoGmZh59Tzzsm+Iyseovn+rghd/zjHZgFa+rvvIETXMlNGBvNr5d2vvzsHni/RgT//MypF1zdsEdLLvSWS21J9gPqxlF9MwaxG5pkYM/uNBje7M53VygYwolE/lgLoLI+sle+gMronGRsiK7PtKo0QWAh7fZyICAWIXZfTPfqd7gZdosxq0r9WSkxFd1I7NX2+vn4Jxui34ckZOX49w26WNfZkts5aSJh2XtY/W1whD5JLBxmv5oXXZkmfQuBwtbWC0g9BRxO3pbLjxt16SYGIfYsCk4AYRDBhjSlLx6s5dl9XgWfq1f5THrfdpL0kLVPc3vCG0J7IlkgXpUh05/FYlNltM9jAJMyGsBAbMGivTknUFLny5+WBVbyEyfhiKSjqM5WTGzcQbXck4vyGNZNrQMiEp/Qe8gFZgSyBQ8xoY5rAQGQ7DpGhgivIYsXxsoa73zeVv9+dAK4cD6QribU76Jm0h3AGxtvidXmYALc5tyxs9QCJRs75vmDpBLrYlyA9iFVRWjtL1z+r5FD180VbRJca9XNLu1ZcsjtflBNhDnaw+ST8iCPT6otGu/jHYrt8omgVk/BEt4WxfA9sayEpnAdGTboV1OL08zs5bSaNw700EQki0wtso4w0yI7cCtf4WcKSlmE2El9aIYtP8LokEWSZtjFoNOlrIs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(6133799003)(8096899003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU4zZ296OTAzVFFBOU9BYUs2d2xjVngxejI5eEsyTWwvVWIvdjM1OUFzWEFu?=
 =?utf-8?B?NEdMRnJob0ZCSzZjZkpxMmhHU29WNDNTWGcvVFZwWmI1YVNYSG5mOXNFdWNR?=
 =?utf-8?B?eWhaUjRPQ05yc3V6elVqbmpiRnQrWHBPUEhlc1NNdDVhS0cyekU2T1NFN0lD?=
 =?utf-8?B?aEdMR3hhOHpwK1JxUGZCUkFzenBRM05lZk1rWDlOa0N4OXZZMW1iL09wKzFQ?=
 =?utf-8?B?aGtHd0dVbXJMMTBWM3c1RW9PeFgwRkNVVWM1RlQ3dFhBK2NmdGxkQzJ4SWpm?=
 =?utf-8?B?eHlSYTBqclhyNDJoWUFpL3YwWVc2bUdjNmZub09NSklRUDlDcGJDUjJsSmRt?=
 =?utf-8?B?aFlHUUxnbzNmbGFFcDVUVGJhTzNESjBEcE1DK0g4QlZqU0pLSi8waEV4VDBQ?=
 =?utf-8?B?dWVKNjhnWGVHd3RNMWZ5MzZlQkRlcjI4TmFxTXBkeElqOXBlaG1WMDhYSWNn?=
 =?utf-8?B?L2JONmsrWm5lM2ZqU25WVlFYWHZmclJ2SFBLVlp1K0pNL3FFZU00SzE4dnl5?=
 =?utf-8?B?NU0rVklBRE1DL09WN3B1eE1PM3VVdExOKzdxY1ZiYjczY0N1aVVSV3h3YzlY?=
 =?utf-8?B?TWdUTVF4VDkwcDFoSi9HcXdiamxhUE0zbUcwekgrR2FEOW96RHE1b2dXRGZU?=
 =?utf-8?B?Tnd2Rmd3L1lCd01laTRpOUhFUGlOWWp2WnpuWkxxZzNhcXpwYkJtZEJlRm4z?=
 =?utf-8?B?dVc3NVFsRGR4Wnd5V1hMV015TVlHQ0loRUpuQUI4aVhPeHlrbkhab3UxZFNC?=
 =?utf-8?B?VE5ITWN4NVRvRUFXZTYwR0h0bXFEQzUzZUloQ0xZT2tyWjNJa25TM2Zhem9K?=
 =?utf-8?B?bGQ0VTJKdHk2TWVFb0lVajJqQWRzSXdTTTF4eG9ZTEs1OG1nL0xNUXZOUDdC?=
 =?utf-8?B?cThsYkFUaUlxVEpqeFRaaHlRZEZET3U3TktBclJWelRmZkxMbm9UdW1Wbm5V?=
 =?utf-8?B?OWV0bitLK3Jia3pMdGlsTTF5Q0R1eGJJMHhBUnlyMytwam94ZTRIbWpaRk9z?=
 =?utf-8?B?MTN3UTA0Q09uVll2ZXdWaFFSc1dsN3hnR2N6ME1yRityRlVYc2FhOG5tclBI?=
 =?utf-8?B?NTZ2anpIenE2ZEZmUFFoWFNWNGxTcGpXN2xUZlEzMGNweFFCN2g1OUhnazQ4?=
 =?utf-8?B?QncxS2RPcWxjU0pLU0ExUUxCRm1xeGNOZmdmUmFGTWRlZm1kZXJxc1pRNUxB?=
 =?utf-8?B?bzFqdjErWVgyUGNxdXl5ZGExWmF3VTVCVGdXWGI0OUR6Z2pJL1lZRWd1NUNo?=
 =?utf-8?B?NVRWMys5a1VvUmhGQkJ5Zy9KTTJocFRNaG50bjlPcDR6aHNscTVJZWFpcFBC?=
 =?utf-8?B?Zlp0SG9qbUtRMlp2c3lnZFYxdkNDbWtqRi9mUFdBdWVaL1lzRjB2YTVMMllW?=
 =?utf-8?B?SnpMenN5cW1nWUpFRmtmWkRCZFhaa0FyMldXZnordzR6VmhFbm9nSEd3ak9j?=
 =?utf-8?B?MTlReWtXc2hqN1UwMEEwZkVJZ05tVS9HRjBOSTg3cVVXa3kwQmZ5TFExdDlF?=
 =?utf-8?B?K3N3bHdRYnpTeENpcHZydldXdUxrQ1MyQnNlbnl0a2FHWEpyL0VhTGQvWG82?=
 =?utf-8?B?S3FWT3l0Z3oyWXo4TEp6T2J1enNSOWZUdzB1anhnV2FJaUZhdHI5SWs4S3FU?=
 =?utf-8?B?azMyMTdqS21HSk0zNTlYTjY1N3BYN1NxYXF4bkhoVHBrVlpoQnR5WThQMktK?=
 =?utf-8?B?U2xkbzFjVnlRYzF6TXRwK2RycUVDOGF0VXBPS0dpRUJud0doL0xlK25VSnlq?=
 =?utf-8?B?M2xZQjVvMzF0RXcxQmhKZitieE9CK2RYN3ptSGZDVHFGSzYwWUtsdE0wdWdX?=
 =?utf-8?B?Y0xrVCtTRGFuUSt2Qy9nemVVR25neGhVVWRENzVsc2xYV2JOTnlxQ1ZTVG0x?=
 =?utf-8?B?NVo0UThVOFAxY3dPZ0RXVDlyc3pDRi9oQzhvQk5zbWpHTE1EYThWZURyV1Rx?=
 =?utf-8?B?c2hjbVVwWWtjRVRpTjBpa3J5SldKRnJuRGoyZ3NsREtmeTAvYjhOdXc4RzVk?=
 =?utf-8?B?Y0M1b3I1VEdYKy96VnpPMXo0ZU9CTHBoZERTbU94ZDBnNFJPWDhheVl1V0x6?=
 =?utf-8?B?blRGZ0wzaXMzbmwyRisraE5ieGJ1K2hoSFY5VStZRmlVcFhuWk5uTXQrWmdF?=
 =?utf-8?B?WU80dDAxbm9IMlRCQldJL2NuVFptS092SXM3YlhpOUk0MWxRdU94VGxYNng5?=
 =?utf-8?B?S0lESFVYTi81UWVEc05VMDNXNFM1K3plUDErbnp4WEc5dlAyNEpNWXFHd3Na?=
 =?utf-8?B?THF6Z2xqUnY0c2ZBQktVOHhNMDI4YUovN25oUllJNWp2OFZsVW1PNVJHTVJj?=
 =?utf-8?B?TG1wdjFOMWR0Z0FKT0w1NW1GdENRWjhLQUx5bGVmRzJOOWpaWElhdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a34333-4b65-47b5-a854-08dedc5333a1
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 18:11:44.1219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u40Mg5PTLDke6memof6XkHZksdQrNaVbyS+47UD18IE27uMAymrii4orpihL7d3/DKI2Xr8pRqslQ5W6ICh6jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7156
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

--------------93zObU3RXKAWCPbEpYrMyzR4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/7/2026 2:00 PM, Alex Deucher wrote:
> If gfx sysfs init fails, we may leak the ip dump
> allocations.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>

Series is:

Reviewed-by:: Mukul Joshi <mukul.joshi@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 7e13023c324b9..2202eed327ea1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2441,12 +2441,12 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		return -EINVAL;
>   	}
>   
> -	gfx_v9_0_alloc_ip_dump(adev);
> -
>   	r = amdgpu_gfx_sysfs_init(adev);
>   	if (r)
>   		return r;
>   
> +	gfx_v9_0_alloc_ip_dump(adev);
> +
>   	return 0;
>   }
>   
--------------93zObU3RXKAWCPbEpYrMyzR4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 7/7/2026 2:00 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260707180021.2642432-1-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">If gfx sysfs init fails, we may leak the ip dump
allocations.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><font face="monospace">Series is:</font></p>
    <p><font face="monospace">Reviewed-by:: Mukul Joshi
        <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a></font></p>
    <blockquote type="cite" cite="mid:20260707180021.2642432-1-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7e13023c324b9..2202eed327ea1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2441,12 +2441,12 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return -EINVAL;
 	}
 
-	gfx_v9_0_alloc_ip_dump(adev);
-
 	r = amdgpu_gfx_sysfs_init(adev);
 	if (r)
 		return r;
 
+	gfx_v9_0_alloc_ip_dump(adev);
+
 	return 0;
 }
 
</pre>
    </blockquote>
  </body>
</html>

--------------93zObU3RXKAWCPbEpYrMyzR4--
