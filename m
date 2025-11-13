Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39385CD4F28
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 06:32:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD22B10E282;
	Thu, 13 Nov 2025 06:32:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="veoaUIKe";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E74410E282
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 06:32:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msSRFAToN5j2Z1k87XjKewnnmLYjs6rsUAJD8nSrKp7kWNud++lgvrZqbcma45NgJXoiBtz9VSwPgxfM56/E8rlZ/CvUBWDPPumu5/zQJKrxjSqQfc0GmkEXtLew0xLqF08ZOG+Vf7mHp46HFPe4ntTOUNIdEx3vpXzw+7zgcH8iQKOw9mksngQmM0hTB8qJaOWVJ+C+l9VajX+97eWhfFxXlvfw4YD8Lt8xPb20IRyU0ujwSh3iTOPI8QjbbgNNqyBUVaXZthkIGn9NA5UnwsgOvcY3hL1n/C2+b7AG8tP+1gC/y+85VjVO04Ce+Gk1+TSyLe69ieQBXXSw44XC7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ccNM6ThBsS+ntvugCGYQvyLGkmMoMLAL9K42t/YlqQ=;
 b=EXxFGAxTBxu8V8MxMB8EwadiL9MHXhoxP5VnsHjLkPlQBnJ6gHRCmVyO8TNDhn+26Bs8ecCX+S1kCCIXEIPD1N1OgXuHmj3Zj/o3mPQ3SwrR4ZaSPToGnkaJLqsfgjYgfr0pqDND6/f/IUtR4TOYFQaVMiUXngpAk9X44xh6X3F2RLeWO0CLFJub6LkYpdSoUQsCiZQju2HJEMRRe69V52b/qGKD+uCUPBAf0px23RpMRG84+Di2+TstQecc9CIBZ6/xnI+mQqp3RQjR3uo8exvv1OMbb9I1ulx1eAgDpaaMb6/7Hgn8ba1u+2hUJV2u8sKpub2exinQiWHGn3bYTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ccNM6ThBsS+ntvugCGYQvyLGkmMoMLAL9K42t/YlqQ=;
 b=veoaUIKedzckvlsWFtuiK++Dfu2b3OIqnQwq45XHHsvTW58RVu6t0FEKRVZl70H7W5jlXVaraKOOy6BIC0B62Yv0nLUL+RPcQyv2YgB1Mmst7kE8lCU756BywXrVOJsEeQiulgU0+BES2j64vcMS/IQdUCW9f9w7bA/fEB9qn4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 06:32:11 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 06:32:11 +0000
Message-ID: <df2df2d8-908d-4f31-bbb7-d69b87ac1f97@amd.com>
Date: Thu, 13 Nov 2025 12:02:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/amd/pm: Enable system power caps for
 smu_v13_0_12
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, KevinYang.Wang@amd.com
References: <20251112152815.203110-1-asad.kamal@amd.com>
 <20251112152815.203110-4-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251112152815.203110-4-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0151.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::21) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d6d7e5-b564-4322-f6e1-08de227e606f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmlHa1M0bXlkU3liRmF6MUNYL1lIc0tJd0lWeVF1ai9ValRpYXhrU1RSOWtZ?=
 =?utf-8?B?ZkJpWFltSmxFSWdpdnZvTWQ4SUluSkRzUElwOHozSHhjRnNVSXBIazJOajdG?=
 =?utf-8?B?dHpabkY2UG5jSU1UelRydDlHWU5VUjdodVNwaWdDR3BkdUNYTDFCalRTWG1G?=
 =?utf-8?B?dDJ0K2RIWmdON3JETmdib2l6WENWVkZwYWR2WmRKYStaR0JrWEROL0EvWmNq?=
 =?utf-8?B?c29pa3lMaCtPMGVSdWY2SWI2ZUVqSlhFN290MWhXSlBpWXNnWFJjNVBMazlJ?=
 =?utf-8?B?RkJvRXdQNSt5VUJDNmpBSnZwdDUzME5hbUZMd1RxRVZpWExnV2gwNXNUQmpS?=
 =?utf-8?B?bDFIakZLUGR3c2ErVmtyUEJjQmdlWlZvMnVjOG10RW95UlE2MS9LNk4xSGNV?=
 =?utf-8?B?NzYrUnRKbUpZNE5FK3VUbTRtYUNvRE5PeWV3TC9FdGZ6T2FGTjBJcHNNckZu?=
 =?utf-8?B?UzhCWXdOY1QxSHV6eVY1UkVyMk1ZaSswZDZMWXdwMXUvem1DenRHK3RldGds?=
 =?utf-8?B?NDkxSDJrYzNBNE9OazVpY2QrRWdWa2htRTRSMEluSDM4VGxrQVgzamFCdVht?=
 =?utf-8?B?VE9yY1F4K3RqZzRSdVBpQXRJU0JvWS9MSmc5QWhrR2cybXZCMnROZExic1FL?=
 =?utf-8?B?VG5QQnVQa1I5TVJTR0VjMFNwcnlhOWhwRWRvTHZ3a042YXRhOFJETzJPMDVp?=
 =?utf-8?B?VkJjQXdxS2d3Y09KZHVkQ3pMY0d1YTFHSzhmd2xDOVZKQjJWVFV5NmxlSW9U?=
 =?utf-8?B?VjRhbWJvZi9ycFhub2x3NUNRTHc4cHYzVmdHSVdyLzNWRlkvU2ZwQ2N5STlG?=
 =?utf-8?B?UStQa0lacXRBQ2gwZjhoY0o3MGRXbUdieSs1RXZ4QWdNUzZNeGE1Zm9PcG4x?=
 =?utf-8?B?NUZub0NZOFd3aEVacGVsbUd6Wm5lQnZNL3gvTXQrQ3g4L0l0VmZadDM5RFFV?=
 =?utf-8?B?dno4YVc3UjE5dlZ2MUJibUl2Tm0zWE9FSnRCTm1YaUhXamlEOEhocm5pcEpF?=
 =?utf-8?B?aHFUOHByOUh1TE9qTWZvdEZXYlRpSGMrS05JSGVDVURXU21xc2d5TGFwMElD?=
 =?utf-8?B?Y0VwdzBDT3VmNFNGUzZES1h3YVVZem45YXlTVENnOUp4WFZPcmZtSWFiR1lR?=
 =?utf-8?B?Uk1vS29UYmNDOG9qY0RDdk5PRllnZVZZditWNDAya0pjQVJLYThFVTRKcndO?=
 =?utf-8?B?dmErLzBVSVRDV013Y2xWUDIxOE1hUXZwM3QvcHZYWkIyOW9UZzRrUVB4bkl2?=
 =?utf-8?B?TXFhbmxGYWdoVFlJWTRWZ0ZKeCt2NmM3SGhOTFJzQThMaEVjWkdtWnJnaHp2?=
 =?utf-8?B?dWhHdm51V1ptaWJUSHpRbDRIL2xLTnR2Y3VVS3BvRVhGbUFsRXVpQnU4MFla?=
 =?utf-8?B?SHloNHA2RFQwcThHUlg5NVo1aXBrZzgyVWFFdXNuQjJMRnpjMTFGV080OWt4?=
 =?utf-8?B?WS83VHcwc3JnR2Y1eHIyUEFVeUhkSSttZ2ZaRmNFby9EWGdJUC80aVU5VndV?=
 =?utf-8?B?dlFkTWkxTTh1dTB2U0tWeEtYZms3OTFYczZTY2V6ZE9yT044MHNucE9SMXVS?=
 =?utf-8?B?ZHI4Qzg1QmVWSXFyUGRDOGdldXM1SHBJT2tEcU0yN2NubnZoS1dYTUpPTC9w?=
 =?utf-8?B?N0FqTHFlaFpwMjdQSGlXMTllanVTYVVYczIvSmRvVzJveHM1bkg0OTBnUEdY?=
 =?utf-8?B?d0F3TytFRExhL05XU2dGTkdHVVIyUlNMVGN1VXlTOUcvT1RMcTR3WnBjdDBZ?=
 =?utf-8?B?aVJwVmcwSm1iOGtycXBOQlFEZlRsTXZjamgvM1pJOGpHTmIvUUoxTW5VSVZM?=
 =?utf-8?B?dFFnZlduWmgrc0x3SzJFRW1hanRrR2loYWNSNzY0Rmc4bmhoQTQ1eVNIdTFi?=
 =?utf-8?B?NUZNQnZEd0w4YXQrd21ObHVxYnA1WmlFRmd5cHBIMFVZMTFOaE56NTlLL3Jn?=
 =?utf-8?Q?qlTR8vWI2RTqv2KRHYU62y+74N09Hq43?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFgvYnJ3OHRWLzB4akRzdnhzdnlwcG1qUkxWSVljRCtNUVZQckxNTEJWNndr?=
 =?utf-8?B?cmM2cnNLdDZLSGQ2enphN1pMa0hqdHFhcVFwci93TThuSHhuVGdLZC9pL0Qz?=
 =?utf-8?B?YnhHdUtKZHBONHpiZzVwOTdjL3h1dTlsSXZIVjhET0szbTJidmkvUm0vazh1?=
 =?utf-8?B?K2RvZy83SjRxV3BrVjVJYVRXK3dITlVkUGUzcHE4Z1RET2tLVjgyQXNhMEhT?=
 =?utf-8?B?cDRoWmN2a1ZFbXh0TmZUcmhMK2h3dTFtTzVzRk5OSmw2KzZaaFN1Zll2OWs1?=
 =?utf-8?B?am5tWk1uNWMwaS9mNm5BVU1jck1za3BTTFVTeEpuYUpGMHBPdDhpNnZtR3JJ?=
 =?utf-8?B?NlJTZHBSNjIyYm52dlBOa3BhREI5b2lEV1N1NGgwM1ZwM0NNOCsybFlKNXZ2?=
 =?utf-8?B?MkVQUElDRndIRENNY3BKanpsOXJUQ2IxRDFmeEFBRmxJdzJRUzF0WGRYNkRK?=
 =?utf-8?B?VWU2QnlVZlQ4UDk0S0JQTE1GT0dIaDBqbDlPdWdhVjhjcU9rL3ZZMHRyaWFh?=
 =?utf-8?B?VzRRZjRjRUZQMklaUzNEUVh5SW1Bb2hXa2FHV0NYY0dwZVJEZ3MrNFNSL25C?=
 =?utf-8?B?emVwaENmbEpTVlN3VHRpMm13S3hrNmdFb2xGQk1wYzFjd1pNTCs4TFhDYjVG?=
 =?utf-8?B?UFlMQVF4VDR0a0JYanEzcm4va045cmVyUGx3SHhJSXZ1RzNFZTJIeTFtN25h?=
 =?utf-8?B?ZzAxUkJMQXpkZkhFOW5rcnhXYlBwWkh0aVdxY1dYK1NJdWNReEJZRTJEcGc2?=
 =?utf-8?B?TGZDanIvSVNkbWJZbHdCQzQxSkxqOVl1VEJMMnFQbVhDY0V1b04wQXp1NjZB?=
 =?utf-8?B?NmxjcDVsTll6THc3ZHh6YjNtK1VWQkRoSWpvQ2Y1MHJKMm5ZTDNKcnlrbUZ0?=
 =?utf-8?B?cE5yRWY4Skthc3pVUloxbkMzZFcxTjJqWEVCb2dXdE42NHZPSDJKS0pDUTBh?=
 =?utf-8?B?TmFmVmw1bEtrdStuY0lBV3pHQXd2Y3g3elhTUG52V0grZWt2UTdxSTQxZmNT?=
 =?utf-8?B?MERhcis0SjRDL1BNUzVuT3RqVTYyQ0xiRm5JNFJhcW8rdk9FeHdTdnBIUFJR?=
 =?utf-8?B?QUJSWTVYY3cycGZtVlB2V1hHcWdDUjlvRG5XakovbG5uS3pySnpHQzlqTXli?=
 =?utf-8?B?VW1vbXdxdCswaldBcTNHcEdXZ2x1b0dPa3dncnFha1ZxZ01iUkpOVmRLd2k2?=
 =?utf-8?B?L3lUYmFkejdieDFNRXVMQlJzRE1HcFdLTnZBUXNpNHZPZ0ZqSGlQdW9Ycjc0?=
 =?utf-8?B?TVJkNzdIc1FaUHlsRWp5SzVoQS9GUjNMT08vSEhjQkVVZDd0YkRkeGtxSkxY?=
 =?utf-8?B?OEU5ckNtaUt4eGl5UHRIZDZMckVHTGtaMlZ3UEJTbFZoRUFVQTQrMGdheldO?=
 =?utf-8?B?VFJST1BFbXBoSWpidHp2QXk5L3htcUJGM2RkNUZESTVuR2pERlRoZnU1V3NO?=
 =?utf-8?B?VGhJdTBlcWQrWXZXMFdlVXNjTWtiZFVOd3FrRnkxRGpPVnNjMmg5WXQwMEpj?=
 =?utf-8?B?bjBZMnllM0FjQmlvMGFKNHovdW4rK3Q2YWxXdTRWZ28yV0VJMW5RTGUvZmln?=
 =?utf-8?B?MW1TSXRsdFJ2b1ZtS2szTXEvVWNNQncyY3JDdlNaT2xETkN2T3VCK05vQmsv?=
 =?utf-8?B?R0NUazUrdmZzMjhIZmV2SHRZRmFRK3RsN2gzZFhNRmVDYnZwNWN6ZlhvZzFv?=
 =?utf-8?B?andCUndwZHlFSTJlVDVhQkhhdE5oTkZoR3J2SzlnMGVNWDZGaEZhckcrcGwx?=
 =?utf-8?B?cXBiUG5MMGM1S01CK2VMMHVkcUM4UHp4U3h3MmVlcTY5bWI0ZWlpRFYrSk9K?=
 =?utf-8?B?azVXMnRJVnVOQ0xQTHR0LzlGYStKK2NiUWpWUHlwdFQ5bWlLelhzeUYrNlRV?=
 =?utf-8?B?NGpQUnJONDJaajhYWkJ1bEhOQ0NGYnBpOTFQczhlRlNUZWlxQS94UW10TlB3?=
 =?utf-8?B?bGZIQ0U0QWtZWnVLbzYzamdsY2ZsSkYrVEJ6NjRHRWplWkdHSy9NbUFERjM4?=
 =?utf-8?B?VlplN2pEZnllcTFwSmtPUE9pVTNaMm0xc2pFOTNSbjU3NGpBVGk3b2NiNlJP?=
 =?utf-8?B?a3NBdTRvdHpQa2J2OGJ1VHVLTDExUGU1a3RZQ3ZsTTUrQTdrQ29VNFh0anRz?=
 =?utf-8?Q?G1Txq52+GluKA28TpdyO+ObzQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d6d7e5-b564-4322-f6e1-08de227e606f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 06:32:11.6230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Nc3n7Evo0uw7EjN+XNx+Ois6/2MdJt8245jfdGZRNw15V9/o65+QqaIAhtkRo5M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7900
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



On 11/12/2025 8:58 PM, Asad Kamal wrote:
> Enable system power caps to fetch system power and threshold for
> smu_v13_0_12
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Please update the unit in documentation before submitting.

With that, series is -

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 2fefd258bc0e..a3ceecbe5d68 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -356,8 +356,11 @@ static void smu_v13_0_12_init_caps(struct smu_context *smu)
>   	if (fw_ver > 0x04560900)
>   		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
>   
> -	if (fw_ver >= 0x04560D00)
> +	if (fw_ver >= 0x04560D00) {
>   		smu_v13_0_6_cap_set(smu, SMU_CAP(FAST_PPT));
> +		if (smu->adev->gmc.xgmi.physical_node_id == 0)
> +			smu_v13_0_6_cap_set(smu, SMU_CAP(SYSTEM_POWER_METRICS));
> +	}
>   
>   	if (fw_ver >= 0x04560700) {
>   		if (fw_ver >= 0x04560900) {

