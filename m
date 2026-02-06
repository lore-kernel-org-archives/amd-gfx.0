Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB90AEB28F4
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 08:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 580B110E5D0;
	Fri,  6 Feb 2026 08:53:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HgKhnyeW";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24D2A10E5DE
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 08:53:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZFbsi1Qbm97Vqin2qy2k1B0WLpq+yfiSLWgtG4UAb/+0TGlwGSmVf+W3d1FDa5slJb/8/1preKBV+iB4xmxDgnYC/phuF++DNUoZr+L9pdCZ77IQdFZSQTR6NMFs0Vsyhg1F8EGp1AQiOjHtc4mrrycwW+jokg/iwTbqfdLUAax33RLJ5upTyCUcNf4cLj82xFmburRgCPp/P6L/SGGGUPcMPFm1UfSmQd6J+VSz3BWqJOgos3yS4qY1YwQnqCBL1SMvthLJ/Lnu8TqHQJU7gwzY3ZHBnL9WNQp5vV8jtOsdh9mDkcjNlnBhDoNXksJRxg+RXoxkL80kyzmPTFoAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f32p37pxFwz8ABdBwLRyAiO155lbttZokmR8hNrRr7U=;
 b=muoUkAFGnr1FIk80KGF/jh8te0qFE5AO4/76xjdzmL3E3M+SWeEIRG2G7oZykbfIMAT6iKSDS3WU4DZm9NtN3nkWXAbDiFAwB/b7eYhQcHJbLLwo1hQAAgnI2oNu/u0LGR8aimzySV+vNNKvbTB7+zGnf9HHIMUakes9pztZm7s4Yioe1NNnX3dHUYm2tetMuQfUzSBagc3xHAM1E2AzAC8rEe4Rxgt6yjJi7D7+52Wd9vpgWpnKU/RVBmjcgNSWeNQOSM0oFITgNNzhhUNk1cJAkHDPJ1kYxt2ndKtXs9YtQSePwtkpAjIuhNAeN1wudCb14Is2+85ufDaVs5523A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f32p37pxFwz8ABdBwLRyAiO155lbttZokmR8hNrRr7U=;
 b=HgKhnyeW+p+AY+0aGePVT3+UWHmuyced65wMN2fTs9Q3kLmBkmoOuS3j/OP5dGnjEyGC4gy6RSS5fFFkgRJ+benh27F3/D5crFOB9wy/oZmYaxAjC8qRWJfRs7wbGTUfkPnIhu8WN82RCHbyQiYhrtGqC2HfCJI6WkuuVldzyBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 08:53:45 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 08:53:45 +0000
Message-ID: <082f567c-6594-4204-ace8-4951558a4c02@amd.com>
Date: Fri, 6 Feb 2026 14:23:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/pm: Add acc counter & fw timestamp to xcp
 metrics
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kevinyang.wang@amd.com
References: <20260206083128.4134355-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260206083128.4134355-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 6121beb3-fc18-4562-478c-08de655d3c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmZHWjR0c0F1cUdBWVBZSDFhbU9QRTJ1dVkrMERBK2ZmVURzd09LaEZTcTcr?=
 =?utf-8?B?aTFvUGVIejgwb2hyTDkwa3NBbnZrZXF0Q1JxTHhvcUFwalB6REVJUVRUQ3ZP?=
 =?utf-8?B?VHM1eUlITWZ0YjB2ZlNhK09qZ3VXTXhxU2Y4SDJNeGdGRkNzcENWN3p0em1N?=
 =?utf-8?B?L0tYMnVYa2I2SXp4L1UrcWFPV1V5djhObjNIdDlqUlVYZyt4dXVUZFY2cEN3?=
 =?utf-8?B?T1ovNDhWNmFTOGc2clBNR2FTYUVmdHNTQmFZNWlZaTkxcUg3QW16VkEwR0NS?=
 =?utf-8?B?ZGYyanJpejdkV1dLZ0MyL0swK0hTWmVuaUlLdm1hNEpkZkdaTWZRcEFRaWhL?=
 =?utf-8?B?WmVLOUc2ei93N3V2dG1TUlRLKzNKbzNRNW1CTHJURGF0YTVVbzFETmFQV2d4?=
 =?utf-8?B?L2tHOTkyZkl6VnNYSkVGNFFma3Jwam9yNDIyeG01VUUxVUhmaWh3V0dwY3Vi?=
 =?utf-8?B?Q0ZUTmRXV0ZIOWczNFRrdEU3d1ZrQldyVGlwMU81TE91T2FkMGRubjB6NGFN?=
 =?utf-8?B?clpnRlY1ZFBiUldzdWJpYURkK1J5ODFaSHUzRElBbVhJT3hIUDR3UldmUGVj?=
 =?utf-8?B?Mm5YKzZOWGxtNHozTDV3Q2w2OUplN2F2ckN6NnFmR01TMW1HR1gyUXhCTnFG?=
 =?utf-8?B?WTBjdzFhZUw2TDdybTk1TXo5OW1tblp4OWhPZGV3RmloQlBvRW5NZE1XVk9X?=
 =?utf-8?B?ZEF1b2Y0RDB2WnBEVUlkVVAyUnV3N0NVZnFMcjhQV0p1N2p0bFQvZE5kbE53?=
 =?utf-8?B?eFFDTUp5MjFrLzA1bWd6S3VUWWkrOXJjRHhwL1BNT0ppdzVML2VPR0tyaXkr?=
 =?utf-8?B?Y0FVZmNxTzF3VGl3djd1cjJBL2t2clh3d2Nzc3RzUitIaU1adzlpMFM0N1Rl?=
 =?utf-8?B?bG1wbkdtdGNQNEU5MkRvVUFxNE1tcFRHL3RBa1ppU25TSm4xU1ZvSGxlM05l?=
 =?utf-8?B?a1lOdEVJNzZoU3dNS3UwQmNQWGlmQ1UwT0hyOWU3ZzJTcG5yZTlWMWl0cXh4?=
 =?utf-8?B?eU9pYnNRZFh0MTh2a3JhRXk5L2dHdENWdTl2TXFCcEcwMitzcDJnNnZOOUJy?=
 =?utf-8?B?K3gvUmFtTGlGVjNQRkRPLy8xVWkwUUF3K1VZTTk5R0N4QnhTY3lxU3JZSFpy?=
 =?utf-8?B?eVNTUElVUTRKK0k5R3BIQXg2eHBnNTBnaWNyYTdobktNVXc2bFJYRk1qQmxN?=
 =?utf-8?B?YWd6R3ZuL1R4c0ZvSkRCT29LcVAvMWZ4OUM4anFJWlUvWnFMMnk0dDU0ajFS?=
 =?utf-8?B?NStveHkwTTJzRE9nQjFGZER5N0VNTEhiWWo5b3oxdlhFZVVFQUJia3VFMlpY?=
 =?utf-8?B?Y1NiWWpGT1lJdEtXTU4yU2RqU0s2dDgzcS9TeWlvczIyNmR5TTZWYXFNNit5?=
 =?utf-8?B?Z2Qrd3hrK0kyMDdUNnJDWlNHekthelFPTnNwd2N2cFYyeW9TNWJJNzc0UHBX?=
 =?utf-8?B?Szg3eU51TTN0b1BRZHVmOHlkaFlOMGk2R3R4L1QvQkQyaDAySUxtQm1FVGIr?=
 =?utf-8?B?YndXQkd2YVlyY0RkUkZJZEFxR3lMbGV6T3FIelArUk1DZ01ReEJlZlRBTjhU?=
 =?utf-8?B?eHlMTHY2TUFrY2dwcUxDQWZocFVDUUF6M1JhNWh3TEpFZWxUSEFFNWIvdGcy?=
 =?utf-8?B?YzZBWHFWOS9KYnNjVzlFU3JKamVHUHNOUkhsNFoydjZKNnhydS9UcEZOQThw?=
 =?utf-8?B?VHpIbmRseEhtUXFOOU9vaXNNc1NMakxxb2tVdU9ta3djalJBSVhicTAxY1Ir?=
 =?utf-8?B?bDZnVWJyNjM4NHcwNTZIZDc3ek9LWkV0T2F3Skt5dGdWK01KZzVyRk1EZExE?=
 =?utf-8?B?UWxPNlJkbnIxb2pRTGFMQW1Dczc4c25tL2kySE9aTzdTZHRBVVhOTVVIdFhh?=
 =?utf-8?B?dlJrdU5hYzZWOFkwS29WSU50MXluQlA0VmpPUytvSzJNY2czRmJVSGovK2Nl?=
 =?utf-8?B?ZzEwUjN4V0hWTzljZlJGQzZZQnZocms1c1E1MkE4aitmaHJoSVluK3A4Y0dI?=
 =?utf-8?B?YVhxdlFPR25ZeDZ4MW9Xc09IRjRjRG56SVNSTVJQZllmT21WcVBXK1E5SGJS?=
 =?utf-8?B?NkdxOHZrbzZGKzRUdG16YXl1N2xoVnpNNzB3QVdINkY2WU5uWVd2Vi9xU216?=
 =?utf-8?Q?v3Jc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amZmeHJuZjFUcSs4L012bWtTUEkxOHlWdGIzNUxWWU80MHY4VkVUMnFuaVZF?=
 =?utf-8?B?d25DcXVEMzlVUDd5NTJScDcrbGN4VWkvaUM1N2pzbEdreXZTMng0aTJBelhS?=
 =?utf-8?B?NlY4RWxZNm5RVlk5WjVYWDBhdmdDaWdYVjhma3pwNjIvVkFEalU4ZlR3RHEz?=
 =?utf-8?B?L1J6VTBZUStzaEk3d3ZqOG51empIMFlscmhtd1UyQ1FKd3EydVdtZ0RGaUhw?=
 =?utf-8?B?dGVRQVowYXJ2M3ZXY1lkSkRBQStQVkI4bk5LaC8yUWdid1VJaDZsNy9JZkJZ?=
 =?utf-8?B?ZmFwNXI0cmhITjllSEc5VmdvTW9sOFkycmVWS3JCdWxmaHl5aThZOTJzaXda?=
 =?utf-8?B?VGR6R3FKRzgyYnZCdEVaODQ2WlhDajF3K2J6VGl5QnhmM2hYbXZXbWw0Uy96?=
 =?utf-8?B?Vmt4enZWZWVyK0pSWVZ4OThCTXRyT2Y0d0d0bDlOY2FHQlNlNG1mZUwvaFBD?=
 =?utf-8?B?eTFNK0tOaU40dGdGL1FDb1dSUUc1Sy9EQjVKMllFSEFJdnhDS29LdnNaeGVo?=
 =?utf-8?B?N1Vzam0zVlBONjArWDM1QXNzQlVTTlp0WnExeVdIbDE0clhQZExXRzJaQVlv?=
 =?utf-8?B?dndxc1QxVGRISGJ2bTM1MEVHcURIMWtqYTQ4VHB6LzBsQnpHTVYycElNeWMz?=
 =?utf-8?B?L2Z4c1RSRWp1bG1JTG1Oa29Ca2kzM0VFYm5OTlZmVm5WSUVaRW1jNHNSZmto?=
 =?utf-8?B?THBlVG9qODFQR2V1NW5NVWpaejJTdTlMbFJRcmpQV3Uvc2Q4RURRUWp4ck5F?=
 =?utf-8?B?dTlsdm9HVmViUzFPTTI1Z2xTTzhEZkdnUUd0Q1djblhYN2VFTll0NHJPRkNr?=
 =?utf-8?B?T2pKYTg1VUFqbUFyMkcvT3RXTzNSL2cySEtmaXRXem5uc0hhZjBIK0hLa3Va?=
 =?utf-8?B?Q0lmKzNLVERnMUlvckMrNmhhV3UzYXlNTjNxdXBiVDAvdXhFV09oR2xVbEZh?=
 =?utf-8?B?OHZvL3BUMXpybG9sVWJaalBMb05QbnpNYXlPMzllTEZLZXBrUlhNbHkyUmVw?=
 =?utf-8?B?QnNiZ3NvK3FFczR4UlFSUGdjTmhvbTZxeS9OdWtuT1N5clJZTzd5cDNmaGtv?=
 =?utf-8?B?dmpyQ0Qwbm9ZSU8vaW5PdHJNcWJkZzh3UE41bGxVSU1GSDVOU0UyYlR6dE1B?=
 =?utf-8?B?Q3hyaVMzc1BNTk1nUk01amkvcW04RysvSWFvWE94Q2gwejJwTkVvOWJtWjFJ?=
 =?utf-8?B?aDlJVlc4T0R2NXRxbFJodjlpUjVLWnJEaE9VSmU1OW1SM1RwbnkyN0JxVlU0?=
 =?utf-8?B?ZkcyN01udmlUejdHTG5DUG1QbE8vN29jbnY3YVVoSUp2a0ZQb2ZJVjl1VGpS?=
 =?utf-8?B?b0wvQ1ZYRktIS2hEdEJYakI5cGdsaVpkRXp5cUY1WThDcHd1ZG5VU3kwWnN1?=
 =?utf-8?B?bXlLeEMrWllkNjc4azhwUjI3Vzh3SFkxdng1RklyeXBwUDNJaS9sUHVNWGNK?=
 =?utf-8?B?a2NENXdySCtOSEUwOEhGL3BleVBZQXVOZGxrZUQzbndVSis4NTVBa05UU3dT?=
 =?utf-8?B?bU5aYkdVcWFwMlhpOTFJemhiazJvZzhSSUowT25FSno5MFEzR0psRXdtTXZI?=
 =?utf-8?B?NWtDNXc5dWxnazJoRVRtWWU3cXpxUHdJQ2tpZ0gycnA4NHhIRkU0Ty92UVlX?=
 =?utf-8?B?MnExWVVRMlMwaENVWE53b3RPZ1RPOEQ1UEhwa2x5angvVi9aYXNMc2hjbmJ1?=
 =?utf-8?B?VWhtZmxIWXM0dFdhQkZKWFRKZ3NEcVNVLy9ZV2ttTHBjdzQyU2tibVlBZGxQ?=
 =?utf-8?B?WG9jR1o5cFhoTmg3MHc3czVsK2J5OFYrN0MzNjNMRENJTjNVNnBkMUpLczQ4?=
 =?utf-8?B?dnBWdUN4OEZxY0tuV2lRQkxzaG4wRlNUMXB2L3hLcTJxQ0pFcGFCV2tuQ3dO?=
 =?utf-8?B?dDdaSFZoSnhWVGpOYnhCM1pmaGljTkt0S1o0bHZHTUl3NEE4WldjakV1dzkr?=
 =?utf-8?B?dWlSVGozdWFDYXFBRzBTZGpuSXhnekRlTDFJV0cyUkVWTDlQMENzTTVscFcx?=
 =?utf-8?B?N2JQQVV0bVFVbW9jNzhlZFYrc0d2NWdRdjRZS3grS2VEcXRvcDhNN210OUUz?=
 =?utf-8?B?aXpqanlhNHkyTjZtZFExZTVUdkFGS1ZEWGtkbTViSXdTbVdIQU9kUzJmMjJa?=
 =?utf-8?B?NTZwUWdLN3dBb3RDT2t4TERuWEJ4bTJxSmRXME9BQk91QU9kaWNEUDdUa0RN?=
 =?utf-8?B?dUVCYjI0cnRoVlNtZ1hBZUY1dVh4eWt1amowcXV4UUR6S2hwU2NER2VxVjMw?=
 =?utf-8?B?WGNMWjVzUUkwM1Rod2RJdmdGdE5oOVVJQlFROFF4RnhVakdDV1B6WXJBbXFl?=
 =?utf-8?B?WE5kUlVtRW10a3Zyck1ocWxnN0xxSVJIbmMxdTV2VlZ5MFViazFuUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6121beb3-fc18-4562-478c-08de655d3c58
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 08:53:45.5560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: is6Dnirimiwlo9bpxgMUOj/IfLYlp/SpUQFQ58gGegg4gHFORHzqRzjkmN/ylCM6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699
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



On 06-Feb-26 2:01 PM, Asad Kamal wrote:
> Add accumulation counter and firmware timestamp to partition metrics for
> smu_v13_0_6 & smu_v13_0_12
> 
> v2: Use U64 for accumulation counter (Lijo)
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 3 +++
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 2 ++
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  | 6 +++++-
>   3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index 3d60d3c1e585..f2a6ecb64c03 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -823,6 +823,9 @@ ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu, struct amdgpu_xcp
>   		idx++;
>   	}
>   
> +	xcp_metrics->accumulation_counter = metrics->AccumulationCounter;
> +	xcp_metrics->firmware_timestamp = metrics->Timestamp;
> +
>   	return sizeof(*xcp_metrics);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 3a9210083ce3..07592e285cf5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2668,6 +2668,8 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct smu_context *smu, int xcp_id,
>   			idx++;
>   		}
>   	}
> +	xcp_metrics->accumulation_counter = GET_METRIC_FIELD(AccumulationCounter, version);
> +	xcp_metrics->firmware_timestamp = GET_METRIC_FIELD(Timestamp, version);
>   
>   	return sizeof(*xcp_metrics);
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> index 0588a5aa952d..07d4cb6562b0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> @@ -259,7 +259,11 @@ void smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table,
>   		  SMU_13_0_6_MAX_XCC);                                         \
>   	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_TOTAL_ACC), SMU_MUNIT(NONE),  \
>   		  SMU_MTYPE(U64), gfx_below_host_limit_total_acc,              \
> -		  SMU_13_0_6_MAX_XCC);
> +		  SMU_13_0_6_MAX_XCC);					       \
> +	SMU_SCALAR(SMU_MATTR(ACCUMULATION_COUNTER), SMU_MUNIT(NONE),           \
> +		   SMU_MTYPE(U64), accumulation_counter);                      \
> +	SMU_SCALAR(SMU_MATTR(FIRMWARE_TIMESTAMP), SMU_MUNIT(TIME_2),           \
> +		   SMU_MTYPE(U64), firmware_timestamp);
>   
>   DECLARE_SMU_METRICS_CLASS(smu_v13_0_6_partition_metrics,
>   			  SMU_13_0_6_PARTITION_METRICS_FIELDS);

