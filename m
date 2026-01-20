Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3D0D2ED0F
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 14:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AD9F10E614;
	Tue, 20 Jan 2026 14:52:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K6cWv3x7";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32FC410E612
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 14:52:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pglC0sc2c7cU7m4yXxCzF+ZCsdjMOESpDJT1pA63OsVwwiL5ltbpeQKG5kyWGzWeDmTsJV23rZ6x9n3RJoDfU59UazCdXmuj35/IxB0Qwu1SEsn6vs2nDz36x+xCw8aliRPld5gs1RKQPNQNIiUMHtiXAQhsgaFeS/NGGKsLykxUJeLFAS8GgfmffrDqur+U3vdK6n33n4OxJdMwQ+l0IiaxCbtErnEIh50usBJBIkCCNtTQcyJxRHkDGQK9kFypyXc7HaNE8stLlYs7HrYhuqDVmxm22xSseaCt3H7cIDcT6v1IN/w/rYpGoNkTHUKdzQy9+2CGn9UqIJKPTwA5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJFZG1y8I7lvveNsQ56NBjVJ2lIJXdsbWXU3XBT66Q8=;
 b=iEpJpUpnl4aPOeG4EXz3kZWGyM2u9r+8UzjTfy74KLmK+ZcTIJ1wrW+UbkFDy3GiaUI20XN0StTEQuxL9sQ0fbfxE4+RCEAG126uyAbVV5mJFH7t+ANvgck9y74a6L6Ve2cGdfXcTkbELG8x9yczU6AKaMEOUy2ME3GQSqFYPP3V1xRkttAklQYr3z1P0dH64j3gGJVSxQFD77C3/sO7PLqhI10b6gL0tJlGXnKEES05NRQzDB4b6G/toWlYlPnzjwLJGBTMUgfRHHtUocjV8eHMm5SEng5pWb0Ai3jGA2oXsH4AHYndPX8iI/wXEaN/ML0+h/qQ3xJYYb3HMdWBuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJFZG1y8I7lvveNsQ56NBjVJ2lIJXdsbWXU3XBT66Q8=;
 b=K6cWv3x7ooC9ntclAqb9ld0Ubb+vmopjdvdRrynlyd2JmWRntPefCyc3pDPUBwqhKMxf47X9dax8MeLSuF4sXGoLp+JukQD8SBh1k8Yq0apJByxFU9aJ297aK8I3zsPTKrfv18pvGhns1bBJTwFSLJ0s4zBOl72ly/RZ6v14T1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 by DM4PR12MB7695.namprd12.prod.outlook.com (2603:10b6:8:101::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 14:52:18 +0000
Received: from CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::5a7a:2adf:1862:35c3]) by CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::5a7a:2adf:1862:35c3%3]) with mapi id 15.20.9520.010; Tue, 20 Jan 2026
 14:52:13 +0000
Message-ID: <be87031b-fbcb-4373-983a-18f091e3b0a7@amd.com>
Date: Tue, 20 Jan 2026 14:52:08 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: add mask for debug trap flag setting
To: James Zhu <jamesz@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kim, Jonathan" <Jonathan.Kim@amd.com>
References: <20260119171503.624080-1-James.Zhu@amd.com>
 <CH3PR12MB9079B611647BA43699682D418389A@CH3PR12MB9079.namprd12.prod.outlook.com>
 <3676a7eb-0a81-4165-bd8d-0905cff7dea2@amd.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <3676a7eb-0a81-4165-bd8d-0905cff7dea2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::11) To CH3PR12MB9079.namprd12.prod.outlook.com
 (2603:10b6:610:1a1::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9079:EE_|DM4PR12MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 188ece93-d091-4db7-c179-08de58337eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anFTa1BIaW9wT0ZCWkUrMHhlVTNiZ0hwYnBUMXh6VFl0RUdCSjJrQ25oN2Vj?=
 =?utf-8?B?dlhCdk9FeTlBY1FaaGhrRTh4MVQ0aTBIRVM4VzdocjB1R1IzeHlBTXM0L3Uw?=
 =?utf-8?B?aEYyMzNtOWlkQXJDNmtkR01IU2xIdHJPcEVGRERkenljRjd2SHgwb1M5dTBm?=
 =?utf-8?B?K3FUNWJaaTkyZTYzL2w1anA2dGZocWNJZFNNbFdJRllOUVl6VnYvekpFMk5h?=
 =?utf-8?B?dENoWHZhYnlKNnVsZGlLeGNRU3hxNXRjMGs0aW1SQmdscVI1WER3ekl5R09Z?=
 =?utf-8?B?WURnQm5yL0NFM1FXNnB4U0UrUWlzOGs1K3VHdXNMRXdtT1pZS1ZLSi9VNXIz?=
 =?utf-8?B?aTBHQ052QkdvaXR5WG0rT3l1TUNHckVzVHNuaUZSb2NmODJIV2pOZUlpR2Y3?=
 =?utf-8?B?aUhoVE12V2xFVVY4MmhmcHNmbjNTNUR5dFNjZFVrc21GbzZEeXg5SlN4QVhF?=
 =?utf-8?B?R1BZQmdYdTFJYWVPUmY3Q1NxNWdKVnBaVS9QeHMwOGhzS21sZ3ppalZWdkZ6?=
 =?utf-8?B?akh5bFN5c1d1TUZrVXV0dnBvRkh0YTFkT0ZtcG1abzhJQ2U5ZG9Wd0lwU1ZQ?=
 =?utf-8?B?Uk93eFMyZ2NZNHJ5SmMyY3FQUXRMcUJ2bEYyTmJOM0lpMXJ4QkpEU29CMzhH?=
 =?utf-8?B?NVBXazRYenN6M1Z1WGh5UFYySUJtWVN4K0hXTlAxV0tPK1pkbmpvTURmR1NI?=
 =?utf-8?B?eDVwVWdaa2JDYUJJVFAvRll2emtvRDFTRFhjdkNoQ1NkRUV0Z2NXL1RGUDV5?=
 =?utf-8?B?R0M4NVBYQlRkMzNHViszVkhnb0x4TEJMc1c1NXoxeUZTdkRRSmFuellRNWxF?=
 =?utf-8?B?KzlvUTRGWUdoWm92WTJLMnhQN3hvRmdsbzZZOU1JakNxejJwTDhCRGxKZmdZ?=
 =?utf-8?B?RzdGNm9jV0g2Q1NuUWZ1ZUtrN1pSWi94R0VMbERIWS9vTmF5RTV6MWRzOWNY?=
 =?utf-8?B?RzI5WFR0WVc2MGFZalJsZnpFUS9nQW5wR045K1kvVXNYa2JiUUNZd3J6UlZl?=
 =?utf-8?B?d2V5SVphUzVwMTF4QjVMaUJNZEJMRDQ0ekVWdi9yVzByVGFZRjV4NWYzQ2g2?=
 =?utf-8?B?cnFLTk41eENHVVZMaEh2eWF6UUxvTkZzR2IvcW5UeEZtdlVkM05MMDh0cjNX?=
 =?utf-8?B?Z3k5ZVFtQ1JBdWJadDJJY1FmM3VEVHhCRjQveUZjK0htLzF6clAzL1FFSHpH?=
 =?utf-8?B?ZVZXOExFSGloVmI1Tk5xTW9EZXhsNU1DakJyeEdFUE93RmhHMkQ2clNRUXYz?=
 =?utf-8?B?YVMwbzcrbWFhQUttQ2dCRTY5VHZQSDYwZXRDRGp1M2NTaTFBbEJvUytvVHJ0?=
 =?utf-8?B?YXFLSUxZT0tyRG10RG51Nzk2NllMcDVpNVViQzRYTE1lV28xcTNxa280VGVY?=
 =?utf-8?B?MkNSWml3WEx2cGx0ZDdRQndJL3oyY3JFaDRZZVRnNUlWNGJ5QUV4TFM1ckwx?=
 =?utf-8?B?blUxRzdGK3A4U0JTdUFHVkg3N3E4OUZBWFVINmszS1Y0UVBEQStEQzRPeHAr?=
 =?utf-8?B?dFBjL2l3OWc5STZ0YU5EbWlPZElOckFUeURxWlVqV2llUEZDL21xcWxZY2da?=
 =?utf-8?B?RGpUWkE5bUtaMEFLVmYrTmJwU04yU1ZXOVV4NTYzem1kNjNJS0Z1blVleElK?=
 =?utf-8?B?bGdXRVUzalkrcEhnNE10REJxNEIwb2tBQkV5ZW9vSi9RTytTRFBycDliL0pM?=
 =?utf-8?B?SUU2WXRsWXZCbkFmYU5jaWtqM2ZWZk56TVViTlZoTmZhWkRaU25RZlIvMFFZ?=
 =?utf-8?B?M1RmaXlpOWdlMWIrRVIvbjBxdm1XMGovL0l0S1R2ZHhqVFBlQnh1bHBYemNr?=
 =?utf-8?B?eTljVDhFcFdsNmQ5VDJ1andGRDF2YXhHQmNVaTVvNGdiTG1uMVBURDNCeXNI?=
 =?utf-8?B?TGtJNy9ScTU4c092UHZoMGxMNUtvQjZub3lQaW9aSENtTXR5VUF4azRSZEIw?=
 =?utf-8?B?N3h0YlJkVWE2M2V0QVJZTmlYRCtCWnppc3QrTVlIRXFQbHhHNmUyZVkwY2Rw?=
 =?utf-8?B?STBWaEE2YXB6c0hUVkxnY0VYQVZLdkZIdGRrcEJqVTVtV1U5bjV2YWlHdG5a?=
 =?utf-8?B?L3I2M3JQV1U3eGl0RHh3d1pRZlhYU0N5VTFqYUNOcDc1VTFrWnVoWENiZTRS?=
 =?utf-8?Q?W7B0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9079.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHU5dThaME1hNVFaN2NaaFNWT1QzdytLRm9IeUVxcnNDVUUwOERJeWE3MGVq?=
 =?utf-8?B?bm04d3JPM2x0dFpPb3doMmlYT0FOdjFSSWVacWM5WkgrOEhzSktaWWVGQjJE?=
 =?utf-8?B?RzcyZ3N0QkxLb2lCVWEzUkgxZ0pZYVlRUzVwTkVUUlFtOWEyTXBlZm1JbmxC?=
 =?utf-8?B?ZVBHc0trc01sREw3Y081R2tzeEpPWkFyL3lxOGx5ODU4REJLOXBKMGVacG9G?=
 =?utf-8?B?RFd0S01LaWxTRDVaY0d2cGVhdk5ZeFRpNFh4eVBhdy9DcW02SHlKaTFiM3hX?=
 =?utf-8?B?M1JZQml4NlAzMlc5MzZ2WEVwc3RLOXZaeDZvLzFtS1Y3K05qM1Z3VVl5a3Yy?=
 =?utf-8?B?UGVrTVVkNlU0ajJXeEtWelEzTmljcnpwSVA2c2grZ3dsRXMraDRrcGQwc1hH?=
 =?utf-8?B?NzZ6aDFLZ0pZOE9qQ0ZsMEZMbGNVOXBKR3RnVzRCTmtVVXpQWHU4dUJ2NXhh?=
 =?utf-8?B?YTlUR1RKSWlZVEM1bGNUUEYybktRd1c4WFlvWFJHSmc0NktneE15ckNucjcy?=
 =?utf-8?B?K3hHZCtqRkx2bHRaTHl3ZU9USTVXRkdJM3F5U1NIdW5HRFdXNUF2cVlDU3Na?=
 =?utf-8?B?SjZMQjlVYk14VGEwT1FHdDdiSCtHb0ZCUmxNZlJtOXVXSmJkTHRjT1A0S2pF?=
 =?utf-8?B?VzJqS0dXUml2K1dFWTVDb2ozbG1ucEQ5VG8xNko0Yi95ZmcyeEltaGQ2WjFL?=
 =?utf-8?B?RnBJMmc5THlyRlRWM0p2MEI0ZkQxZ1ViZHBSMFc3S1lhbDdVT2FDbys1UUN2?=
 =?utf-8?B?U1RXV24wLzZBOFhZTHZ0bk94NlUrQ1JLU1FZMUJMd2l1V3VlVDJMM3R2VjFE?=
 =?utf-8?B?aW50NlFlZ2FEMURqZW1YUGFjeGNXMDhhaFR6M1BPQ3l6K3RDdlpsK2tWenNJ?=
 =?utf-8?B?N29OaDFrMGZ2bFRrbjREay93YU9NZnY3WndYRkhlWGYreGRBQzFiaHZVbXRo?=
 =?utf-8?B?QlBPc2F3WUlRQVdjSHNLRWF5aXFrRUFHTkVwYXUvLzVHcVBpeWtPaVFGRHN4?=
 =?utf-8?B?SVVpTmw5YXlzcTBIVEtOankyRXBRYnJwcVdpMDZoRzkvQU9hSFhKaGUyQ0tY?=
 =?utf-8?B?TEVWT1RKN1dCeFk0WXlUM0d1S2VqR3oxZlluVURuaFpYOXNsdkJJaENYSExY?=
 =?utf-8?B?Qm1aUlpHRmZHbC93MDlBNTRGR1IxKysxRjA3cHhWR3FoRkVZd3ZiL1pVaHdI?=
 =?utf-8?B?cGdFa3hyeDVJR3BTNGZLVFFwYUUrWlpXbEt1QmhLYUJ4QzFtcDZRQStJVzcx?=
 =?utf-8?B?dHM3SDN3eWVXbi9jTUZSc2xsZ1VwYy84V0pGcGNJc0kydVN6dk41djdnSnNF?=
 =?utf-8?B?bUo3bjQvaFBnSElqam85OW5wcG1IMjNsbVFMdzdVUjBPMHNYV1FMeGM0dXo4?=
 =?utf-8?B?ZzR5a1QvK2U1d3RVUSsxWE5VSkxvSmNzSWlBUGlRM213ZFhWeXh0a2RpRzV4?=
 =?utf-8?B?MWZZbjU3YktKU1pTOUtScFY1RGJpUklPQ1FXcW5Yck9VQXRtUm9ZNzJsVDRa?=
 =?utf-8?B?SFZFaDZNOG5pbmZFMnUzQmJGUUVwZjFCeVRqdHRzbVp3SDhxN2lsVUVQZVha?=
 =?utf-8?B?SEhvTnloU043aldGR2RqKzBJWEVsZVFYR1doL214RVhHVlBqaGo3QnA2dFhL?=
 =?utf-8?B?cmI5N3dkOFR4VFNuMGlab2FKUkVXbGliVVZJTHVOUHdIZ0FVQ05UZE43R3Fh?=
 =?utf-8?B?RTFVcFBIVkhuKzYrVU5PUFVGOGFidG43c2ovQkIrTjB0RW9tVUtlSUtPcjAv?=
 =?utf-8?B?a2JQU1lOWDA2WU90Y0c4MktEWGtYbTZQbTRIczFKRWRBVVlyMm12M0xzcGxw?=
 =?utf-8?B?S1dUV2N6UnV4M3pXdm5palc0aWtidVlaUHJkZkdZVTMzK2xLZ05mTi9xVVRh?=
 =?utf-8?B?YkRUTytUbWNxQ0szSkhCVFhBdU1NU2xoRFNVdkJYcHp2MzVVUVlNRWZtVzQy?=
 =?utf-8?B?RFJjN2hVL0dsSUtoQ1hNVjlBeUxxVXFBK3QrMG5LQ1gzV2QxcXNFSTZLZDlU?=
 =?utf-8?B?YkZRYzRoZVVIN1cwWmV1VW12RHVOaGpuZXpUUUxVVVgrVGoyU29vZkdnaEJR?=
 =?utf-8?B?VUJRbXNVR0c5NzcyYzVJVkdyenZtbFRSUG5XREdLclNUSzdvTkR2bnFVd3FU?=
 =?utf-8?B?MTNIUTZaUERyQy9PSHBtNzdpMTVCdFNtSHhZbDlRYy80cXM3eDBrMWhnN1ox?=
 =?utf-8?B?MWNxZVVqS05uQTVOak15UUkzR2htdEYwdkpFc1EzNU5CUDhDNG9tMlNaREpM?=
 =?utf-8?B?ZUJ2TDgxSks5UEI0WUxJaHFTUGF1S05hcGhXN21Ha3ZULzhpTWlMODJNd1dh?=
 =?utf-8?Q?rE6NTS6FWkHJGpwR4X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 188ece93-d091-4db7-c179-08de58337eea
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9079.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 14:52:13.0846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wMlgU6504Psfi7eoFfYrmrDuzuEEw7xMjdal5QTehcru6w7GnCGksW7KIJQAcSRK/+af92b3O0JUbEInPMi9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7695
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



On 20/01/2026 14:39, James Zhu wrote:
> 
> On 2026-01-20 05:34, Six, Lancelot wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> Hi,
>>
>>
>>> -----Original Message-----
>>> From: Zhu, James<James.Zhu@amd.com>
>>> Sent: 19 January 2026 17:15
>>> To:amd-gfx@lists.freedesktop.org
>>> Cc: Six, Lancelot<Lancelot.Six@amd.com>; Kim, Jonathan
>>> <Jonathan.Kim@amd.com>; Zhu, James<James.Zhu@amd.com>
>>> Subject: [PATCH] drm/amdkfd: add mask for debug trap flag setting
>>>
>>> to specify which bits are valid setting on flags.
>>>
>>> Signed-off-by: James Zhu<James.Zhu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  2 +-
>>>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 48 ++++++++++++------------
>>>   drivers/gpu/drm/amd/amdkfd/kfd_debug.h   |  3 +-
>>>   include/uapi/linux/kfd_ioctl.h           |  3 +-
>>>   4 files changed, 30 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index 79586abad7fd..fd43ef7c9076 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -3377,7 +3377,7 @@ static int kfd_ioctl_set_debug_trap(struct file *filep,
>>> struct kfd_process *p, v
>>>                                args->clear_node_address_watch.id);
>>>                break;
>>>        case KFD_IOC_DBG_TRAP_SET_FLAGS:
>>> -             r = kfd_dbg_trap_set_flags(target, &args->set_flags.flags);
>>> +             r = kfd_dbg_trap_set_flags(target, &args->set_flags);
>>>                break;
>>>        case KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT:
>>>                r = kfd_dbg_ev_query_debug_event(target,
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>>> index a04875236647..279160ca71a9 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>>> @@ -512,38 +512,42 @@ static void
>>> kfd_dbg_clear_process_address_watch(struct kfd_process *target)
>>>                        kfd_dbg_trap_clear_dev_address_watch(target-
>>>> pdds[i], j);
>>>   }
>>>
>>> -int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
>>> +int kfd_dbg_trap_set_flags(struct kfd_process *target,
>>> +     struct kfd_ioctl_dbg_trap_set_flags_args *set_flags)
>>>   {
>>>        uint32_t prev_flags = target->dbg_flags;
>>>        int i, r = 0, rewind_count = 0;
>>>
>>> +     if (!((set_flags->flags ^ prev_flags) & set_flags->mask))
>>> +             return 0;
>>> +
>>>        for (i = 0; i < target->n_pdds; i++) {
>>>                struct kfd_topology_device *topo_dev =
>>>                                kfd_topology_device_by_id(target->pdds[i]-
>>>> dev->id);
>>>                uint32_t caps = topo_dev->node_props.capability;
>>>                uint32_t caps2 = topo_dev->node_props.capability2;
>>> +             struct amdgpu_device *adev = target->pdds[i]->dev->adev;
>>>
>>> -             if (!(caps &
>>> HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
>>> -                     (*flags & KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) {
>>> -                     *flags = prev_flags;
>>> -                     return -EACCES;
>>> -             }
>>> -
>>> -             if (!(caps &
>>> HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED) &&
>>> -                 (*flags & KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP)) {
>>> -                     *flags = prev_flags;
>>> -                     return -EACCES;
>>> -             }
>>> -
>>> -             if (!(caps2 &
>>> HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED) &&
>>> -                 (*flags &
>>> KFD_DBG_TRAP_FLAG_LDS_OUT_OF_ADDR_RANGE)) {
>>> -                     *flags = prev_flags;
>>> +             if (set_flags->mask == 0xFFFFFFFF && !set_flags->flags)
>>> +                     break;
>>> +             if ((!(caps &
>>> HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
>>> +                     (set_flags->mask &
>>> KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) ||
>>> +                     (!(caps &
>>> HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED) &&
>>> +                 (set_flags->mask & KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP))
>>> ||
>>> +                     (!(caps2 &
>>> HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED) &&
>>> +                 (set_flags->mask &
>>> KFD_DBG_TRAP_FLAG_LDS_OUT_OF_ADDR_RANGE))) {
>>> +                     set_flags->flags = prev_flags;
>>> +                     dev_dbg(adev->dev, "Debug Trap set mask 0x%x caps
>>> 0x%x caps2 0x%x",
>>> +                             set_flags->mask, caps, caps2);
>> The logic here seems odd.  If "set_flags->mask" is the set of flags a caller wants to modify (I don't think it should, see below), a call which asks for PRECISE_MEMORY to be disabled would return EACCESS if PRECISE_MEMORY is not supported.  Before this patch, it would have been perfectly valid set (or confirm) the PRECISE_MEMORY flag to 0.
>> [JZ] the logical here is checking input setting, if caps does not support such feature, mask trys to set this feature bit, then exit with -EACCESS.
>> Also, consider the following scenario where a user wants to set PRECISE_ALU=0 and PRECISE_MEMORY=1:
>>
>>    set_flags->flags = KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP;
>>    set_flags->mask = KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP | KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP;
>>
>> If the platform only supports PRECISE_MEMORY (like gfx11 for example), the call would erroneously fail with EACCESS.  This was possible before this patch.
> 
> [JZ] then mask should not include KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP which 
> tells user want to clear KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP on this
> 
> ASIC, but it actually not been supported. err tells user that the 
> operation clearing PRECISE_ALU is invalid.

See below.

> 
>>>                        return -EACCES;
>>>                }
>>>        }
>>>
>>> -     target->dbg_flags = *flags;
>>> -     *flags = prev_flags;
>>> +     target->dbg_flags ^= (target->dbg_flags ^ set_flags->flags) & set_flags-
>>>> mask;
>>> +     pr_debug("Debug Trap previous flags 0x%x set flags 0x%x set mask
>>> 0x%x target flags 0x%x",
>>> +             prev_flags, set_flags->flags, set_flags->mask, target->dbg_flags);
>>> +
>>> +     set_flags->flags = prev_flags;
>>>        for (i = 0; i < target->n_pdds; i++) {
>>>                struct kfd_process_device *pdd = target->pdds[i];
>>>
>>> @@ -555,10 +559,8 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target,
>>> uint32_t *flags)
>>>                else
>>>                        r = kfd_dbg_set_mes_debug_mode(pdd, true);
>>>
>>> -             if (r) {
>>> -                     target->dbg_flags = prev_flags;
>>> +             if (r)
>>>                        break;
>>> -             }
>>>
>>>                rewind_count++;
>>>        }
>>> @@ -596,7 +598,7 @@ void kfd_dbg_trap_deactivate(struct kfd_process
>>> *target, bool unwind, int unwind
>>>        int i;
>>>
>>>        if (!unwind) {
>>> -             uint32_t flags = 0;
>>> +             struct kfd_ioctl_dbg_trap_set_flags_args set_flags = {0,
>>> 0xFFFFFFFF};
>>>                int resume_count = resume_queues(target, 0, NULL);
>>>
>>>                if (resume_count)
>>> @@ -606,7 +608,7 @@ void kfd_dbg_trap_deactivate(struct kfd_process
>>> *target, bool unwind, int unwind
>>>                kfd_dbg_clear_process_address_watch(target);
>>>                kfd_dbg_trap_set_wave_launch_mode(target, 0);
>>>
>>> -             kfd_dbg_trap_set_flags(target, &flags);
>>> +             kfd_dbg_trap_set_flags(target, &set_flags);
>>>        }
>>>
>>>        for (i = 0; i < target->n_pdds; i++) {
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
>>> index 894753818cba..34d27eb500a5 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
>>> @@ -62,7 +62,8 @@ int kfd_dbg_trap_set_dev_address_watch(struct
>>> kfd_process_device *pdd,
>>>                                        uint32_t watch_address_mask,
>>>                                        uint32_t *watch_id,
>>>                                        uint32_t watch_mode);
>>> -int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags);
>>> +int kfd_dbg_trap_set_flags(struct kfd_process *target,
>>> +             struct kfd_ioctl_dbg_trap_set_flags_args *set_flags);
>>>   int kfd_dbg_trap_query_exception_info(struct kfd_process *target,
>>>                uint32_t source_id,
>>>                uint32_t exception_code,
>>> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
>>> index e9b756ca228c..0522fe7344e4 100644
>>> --- a/include/uapi/linux/kfd_ioctl.h
>>> +++ b/include/uapi/linux/kfd_ioctl.h
>>> @@ -1515,6 +1515,7 @@ struct
>>> kfd_ioctl_dbg_trap_clear_node_address_watch_args {
>>>    *     Sets flags for wave behaviour.
>>>    *
>>>    *     @flags (IN/OUT) - IN = flags to enable, OUT = flags previously enabled
>>> + *     @mask  (IN)     - IN = specified debug trap operation bits on flag
>> I am not sure I fully understand this comment.  Is it meant to say which bits from FLAGS will be set?
>>
>> Also, this seems to break backwards compatibility.  Before this patch, a caller would call this ioctl with "flags" set, and the PAD field would be 0.  The semantics of this call is to set all bits from flags.  The updated semantics of MASK would make it so no flags are set instead of alle.
> [JZ] Jon has pointed out this. I have a new version to fix it.  I will 
> add below code fallback to old version.
>      if (!set_flags->mask)
>          set_flags->mask = set_flags->flags;
> 
>> The updated ioctl must preserve this existing pattern, so instead of mask telling which bits must be changed, it should specify which bits should be preserved (or ignored from FLAGS).
>>
>> To make it clearer, I'd probably call this "preserve_mask"
> [JZ] to use mask to tell which bits in flag will be modified seem more 
> straightforward.

I agree, but I don't think this is relevant.

There are clients today using this ioctl, which 0-initialize the bits 
used to hold MASK.

If you change the meaning of those bits, this breaks backwards 
compatibility, and this is a no-go.

I see 2 options:
- add the MASK field after the existing PAD (effectively extend the struct).
- Re-use PAD's bit to hold the mask, in which case we need to ensure 
that old patterns contiune to work as they do today: setting 0s means to 
replace all flags, and it is valid to ask clear flags which are not 
supported for the current platform.

I don't have a strong opinion either way, just need to make sure old 
clients continue to work once this patch lands.

Best,
Lancelot.

>>          @preserve_mask (IN)     - IN = Specify flags which must not be modified.
>>
>> Best,
>> Lancelot.
>>
>>>    *
>>>    *     Generic errors apply (see kfd_dbg_trap_operations).
>>>    *     Return - 0 on SUCCESS.
>>> @@ -1522,7 +1523,7 @@ struct
>>> kfd_ioctl_dbg_trap_clear_node_address_watch_args {
>>>    */
>>>   struct kfd_ioctl_dbg_trap_set_flags_args {
>>>        __u32 flags;
>>> -     __u32 pad;
>>> +     __u32 mask;
>>>   };
>>>
>>>   /**
>>> --
>>> 2.34.1

