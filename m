Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC70BC369A2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 17:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3EAC10E02F;
	Mon, 14 Apr 2025 17:33:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IXNNoIHJ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36F5A10E02F
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 17:33:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9FgMEb2x+u6x4Nyq7lXhUl4jhvM3P1sz2aepkCchDW3maZaYgtba4JlVW9QDHYUomm2bHVbV5QCfTgHTKLeW72ntylXqQxRNekBlJveU52z9b8NXItod512OUu2g+7A+D/D+K6Hwku/USgkDlDOHpcuKml8hoyufueQjgG/strUMskKw30UxlBRsMc/e6+UnjwICd065vIitMXG/j7M6kYF22V0tn3t1wUBFULT7xEc5RA2PDRWHUSvRzi7bWDY0JDs1f+G2Mw6CLpUlE81ExeTfoFTBbC/dYJZWzLBk+F7W7Ga/bGjbALdSas/NHG8IpV6VZcdAsiOrhR1s99oiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xa88nILA/Xjq0S1Ugwm9fTbiTQCgfDw6AQx1wZ6mXOs=;
 b=WhRsewWxpGnlN7GtHO/rav4LVdgCUT7fUDYprbMuo/V3//xzVGBEpIX3NKAmKsSQn7thabaFUoN35vEEXwlcxBrFFMPCa1cjYBVJ3I1pqM5dpooZV9U61R8W3fjF7v6dhdGiA3l8vZAwEdbUBzmQG7qDtxp92uSfcAuLq5t1+GF+IfN9bFOdwNvWVBGx3SMKII/QSAGm1Yl0s6PkGC4JBwi1J9gIg/T8l5p+X5qjYmcz0h9WGVB5xBtlE09p6X9IZU3eo+LsiJd94ZY1pDXbrl/D4h192iZEjRlboHV0kldligTLzFq/GrSij6itFhY1B1LOY6OAZCk/SCeOH/r3wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xa88nILA/Xjq0S1Ugwm9fTbiTQCgfDw6AQx1wZ6mXOs=;
 b=IXNNoIHJX1M/o/MqnZLdhHCbfFT71sWXEZy49I5/YRqfjT5icqimrHIrohN/EOxxKJ45x476iI8gkMruqJm/SZPbOmSsqLkDmvMXnzLcViP6fBTKQOmjT3Fcs1zovwBTuu6iONhbnds1ujeAcxd2qJhEEVet/EVXEi9930R3RWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Mon, 14 Apr
 2025 17:33:25 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 17:33:25 +0000
Content-Type: multipart/alternative;
 boundary="------------LBAgiDaTSLghm592LOlb0JZT"
Message-ID: <eee0e3c6-62ac-4973-837a-4050013123ed@amd.com>
Date: Mon, 14 Apr 2025 23:03:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu/gfx11: properly reference EOP interrupts
 for userqs
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250413160608.2198429-1-alexander.deucher@amd.com>
 <4d804b27-c89c-4503-8d36-2e9a35a483e1@amd.com>
 <CADnq5_N3f1PvDMXsEq9M3ZG1Zwahb6PKCUd3-mk455=w97wKzg@mail.gmail.com>
 <7138346b-3063-4b06-8e5a-ec7e42bf21ad@amd.com>
 <CADnq5_P7KKGW5etkuhB0Gy4rB9rHEj=+pTxZ8_-6+zUeVKgayg@mail.gmail.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_P7KKGW5etkuhB0Gy4rB9rHEj=+pTxZ8_-6+zUeVKgayg@mail.gmail.com>
X-ClientProxiedBy: PN3PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::6) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: a44aa2d3-5819-4413-482e-08dd7b7a7600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anNQb1BWd2hrbk90bjJWUitwNHpTTjY3VXJMUFVtMDhhc3k1RGdaYjlaeDNw?=
 =?utf-8?B?ZVF6R0R2SmNWQWZHVk8xWHZKa0MxUkhpVGVnTlc3MEM1d0cvWDluM0pJTElP?=
 =?utf-8?B?VDJYb01oRkZIc08rYmpuNkZBUEpLZitpa1Uvb2xTTi9sUi9ROU5pb3FnT3BZ?=
 =?utf-8?B?MHlhTWhPdkQxSGpKbU1BakNVWFB0allpWW9UVnFvZ2kzQWxsdlBUdzJSWk4w?=
 =?utf-8?B?Rk9STVVHTjBuMnZjZTVtenUyWnhUamhyNDBZV1lacUNtMUJaY2RiQjFGWWQv?=
 =?utf-8?B?ZDg1S25jVFNibGo4eFJaNVhPOXJiOXFQZjRVd3h1aGJUcVZZNm1yUXhxbUFz?=
 =?utf-8?B?UXRlZ3ZvS0s1TWxUakNZalQxVG1GdzNmWDJtemhhUWtabDJPL2Jydzl4RGFp?=
 =?utf-8?B?V2czUVIzazZQRmpJeHllVzB1ZDRHeUdZUDBTMTNSdGlZT0tZclkzUXRrd3Ft?=
 =?utf-8?B?SkVRNnRrOVd2ZWIwenNlZjZSNTRtS1VPV09wZXUyZXZTbGgyRHZKU1BiNGJi?=
 =?utf-8?B?OGFUOEZnekRRZWNITEVucjBGSjloUnl2VEp4R3c0TmIwU0g0VEl2V2szdU1S?=
 =?utf-8?B?NjBpaGhHd01NZkgvazFFVGxiS3ovVlBUWFBiZDc0MXExS0haaklUSjVOcFRh?=
 =?utf-8?B?NWM1eEFhV2Q5OTFWejU1eEYxQUNYVGdWZC9yMlJpSkRKVEVva24xUGxEK1A2?=
 =?utf-8?B?QkxXVDF6cDlYcEFsL3BybnRBY001UVNFMmtkSVRNaHlXelgyMTlxTVdCY1Y3?=
 =?utf-8?B?YjFTMjNQdDhmT1gra3Y3WDhYN3NuQjY5SGFGRVQvUU00SjJnc2JVNHVmd013?=
 =?utf-8?B?VFRlV0YxMGFvZlAxeDBzMCtOT1VHVXRvd1FCYXhVT3FaVDhwUFpweE13OWlQ?=
 =?utf-8?B?TU1JZDFVRzcxWVROR21hZUZ5OXN2ZWRua1EwMHlQZUVGSHI0UWhqcnY1SzFk?=
 =?utf-8?B?akVVUlVkUGJFT0dkZlRmVHlnenk3YitmQ0NOdTdCeTdXTmNraWZNa1FOdnBv?=
 =?utf-8?B?ejYycjk4Si8xdlFxc2VyUVV1azRIY0UyMU1heVF1eVAyVWM0VjNBbnd2eGQ1?=
 =?utf-8?B?RG9iSEVWcUFJVTFzZEFhMFVWT3VCd0tYdHZPOTRoeGlRTmdOeTVocnY5azU2?=
 =?utf-8?B?aVpyclJnNWtRVEFDNkZVQm9na2VWVkEyRFYxZEVBWTY0ZVZUejVjL2J2b3Rp?=
 =?utf-8?B?ODlYNkxCQWRRTWtsNXIxNmhXL3c5b2psb1U2a05yUDArV0VPSXgxV0hldjdt?=
 =?utf-8?B?T3ZndTN2QjNIcUJGaUd0VVdOYUFuM1lkbmY0Z2owT1JKR2FaMFF6Y0UyT05W?=
 =?utf-8?B?bmFjNm8wRkRBYkhWVmxCMU9FV0k0dWhSdU5NUE9UQnd5S0YzYVV6RXJXY3RK?=
 =?utf-8?B?NFBjdGdrejRLZk5ZbTBWQW5XWVdyM3ZMMGxRbzhwYmIvcElZZXhvblA5bXhG?=
 =?utf-8?B?Z29lNHFSQmpFcW9UKytjNlNCUVdFMXF0bDRRTWI5ZkZjRTVpd242MEh3QnBh?=
 =?utf-8?B?SENORkxvMlRmNThGQ3ljUXl2VnVnbVpBdGppWDJUa1dMSGtIbU8rbXorWG1N?=
 =?utf-8?B?Zk12MHZhd2tQRXBVUlFuTVRVclBXV1ErVVRSUCt1UXBwK211aXg1aFJQQXZa?=
 =?utf-8?B?QXhENDRwS0p3M05VRGJrYzc4bWYzRGtsdzFuekhIZm5jbW9na2ROSDJSci83?=
 =?utf-8?B?d2JuWXFNQjFFSHI4UDVIREp5aHZWbmljWUlmN25xRUowbmJhcHBrS2hTYmh1?=
 =?utf-8?B?eVlrUzFXR2NRMG55cXltdHNBQWt5Qy9aSkEwL2hxS0dGTnBraTk3RkszbElu?=
 =?utf-8?B?b2NtVm9JSURDTUV1NjI0bk5ONmlCK1JEbUcwYytVdjFzUk9kY2VQRlBwNElO?=
 =?utf-8?B?OG1aK3c3YnZacDJEZTZqZlUrOGpLd3kwcGE5UXZuQkZnbUVHeVpjWFpIL1M0?=
 =?utf-8?Q?4r6UsNOia64=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU5lcXp4MVVRczh5MjVvNHU2a2x0elFnbDBHcElQT2MxQXllOXllMUpiaVVH?=
 =?utf-8?B?aTZYRStwUkcrTndVTGV4ck9vMzZxYUV3aW5lZ1BQcFArODdHcUE1TjZjOTdp?=
 =?utf-8?B?UmtFcHJQY09Pall3WldyOWtYUVZWWVYzUVVYNmhKcjZmZldoaEx4RytIWWtx?=
 =?utf-8?B?anh3T0VHOFpRbjEyRS9pcTRCUWJ2STNOOFlkcDg3SC9NTTdEL2pUNUZWMXNv?=
 =?utf-8?B?R2NxUm9WNzRqcUNjVEY4ekRlVnQ1UjZCZDMvY2JUbTl4ODF6NlptMjZBeHRG?=
 =?utf-8?B?Z2g3cndPUTVBL1NFMWZCRUs5cjVjUVBpVGhITnltdHROZUVWREpOSThIT2I5?=
 =?utf-8?B?QytNYWF4MXM5U3VIS0lOMjdUT1o1VHhXVUJFVzJLUXVWeGNNQ3ZTYlpQcUJD?=
 =?utf-8?B?YWVjKzhmcmFXekxkOFlPUm5sZlgyZHBqM3c0TGdNMmNiWmsrVVJXNVBPS05R?=
 =?utf-8?B?bXJ0MFVSY2dWc0xIcUpSMlYvN1FSZjFrdkFkNitNYWppcXoxWXovemFVT3VI?=
 =?utf-8?B?NHVLYkpMVEt5bVl6Wjdocy92c2UxTUowN25nWVdNM0xNTHV1elZjM0tEYlo0?=
 =?utf-8?B?TGhlSTdVdTFGb1Nvdlg0MDF1a2NlK0JVNnZEd3V0Tm9ka0tTeTFlY2hiS2Qv?=
 =?utf-8?B?eG5YMkNobWlLM2Mza3EwMUlqZFBndTRacW0vVEoyU2x0d2JTTnVxS3g3THp1?=
 =?utf-8?B?SnI0Y1ZQbHprSTF5MFcwK2FYRy9FcXZFTk5Kajh2Uk1ZSklwMHQ2RlJIUDFh?=
 =?utf-8?B?dWNibndPb01lRVZtNENWSjVKVU0yUU9kZmlPWUtNWksxOTlnRFBqd2svS2J1?=
 =?utf-8?B?aEM4c2s1eHJ5eklRbUNGMlJHdW1pSlNvdTlwN3pabGVIL1plcENyTU9qcndn?=
 =?utf-8?B?dS9BWmFIdGtqWUJZV1NhOTZWVGNXMmxHYm1PYVo5UVB4aTB2RnJQZ3QwSGpR?=
 =?utf-8?B?QllBVDYwUkNyQWQrajFicHZOUmZBNkIzUGFxUFE5bXlkNWNxWUNiZC85TWl2?=
 =?utf-8?B?QkF5V2hZRGxQL0ErUDY0dXJnOHpSMXZxa1hHSWZWZ1FXeDQwcFJkUk5sNG1H?=
 =?utf-8?B?ZitTSFEwRXFjR2pWSUNYVzBkRUUwMFdtclprSStmOUkrMEFCTDNNTTVLSktt?=
 =?utf-8?B?eERXT294ek5jQnh2U2J5ZU1kY2orM0ZJTHRjYjJnQU5LNUNGMk1lakJVVzNX?=
 =?utf-8?B?QTNFY2FrZllKZXNWZTVZaHg1ejQyWFpNQ1doY1NzVEZ1NU03OUMzcHcrbElj?=
 =?utf-8?B?UkRmY0JpQU5aYUNEM1hOeUxCbjdhNlB1L0NDS0ZDcGtESTRRYTlPUTdhY3B6?=
 =?utf-8?B?VCtpMktaZ2hOY1hCUUtyMkpOTXdHbzhnT056cWc1bzdKc1dyQ2ZZOExzWk1T?=
 =?utf-8?B?ZVpHQ3pvczdBSmhUR25QSzZYYndKbmo1RkxEcnVsNTBRU3NoK3hzT0NydUZ5?=
 =?utf-8?B?anRFelZkb2dPRmpJY2RDUHI4Uld3NXNyeUZLZkVVMVlWUU9JREdQTkRveG5F?=
 =?utf-8?B?ZmduaHI2ZXJFcnpuYmxMOTY4aUJmUkxwTm5jMlM2RjZjZEU2WWxTd2xERnJt?=
 =?utf-8?B?dHBtY1hOYVNJaDlLRENQVmc2N2Q4NktKbHFGRFFlVnBrdmRvT1JQTHpWVVJx?=
 =?utf-8?B?VUFscTRjSFhmVHFsS01tNllOc1FGaVN0MjV0SlVTVVViRXRCYTFlbnlUcGlH?=
 =?utf-8?B?RXdWcEhnd04wZHNRbnF2VmtpNzg0YWkxWkpyUFBraXlhRm84Y3RiYXFZU29x?=
 =?utf-8?B?WmRpRmFFVHNWZllGMTU5endPNkczckdHcXpYVFZzRlpmOGZmb2JiTnUzWW5h?=
 =?utf-8?B?RTRneWZGcjRZblR5YjlRanpvaStXeENvQUowVm9lbjVzM3dVUjg0b0V2Wmo0?=
 =?utf-8?B?c2xoVkZENjNaUTJGVFpVL3FxVjdmSEdodFNSNllNRzJPekFXVVhWQ2dMQmxU?=
 =?utf-8?B?SlI5NUNPMnRVM3V2TmhkOXBUdlJqSFM0UlZ5TENOVDg2bWpFY3g5ODQyUWtn?=
 =?utf-8?B?WjgrQ0FUZ2tMQlIzVjRoYUlLNEZuVDM0Y3VaeFAyODg3YzlMTmJIcFVEVjB6?=
 =?utf-8?B?MlJJYitwa0h5UjNWN0lPRDk4NXNYOWVJSlNKN1ZJYzdnOXo3T3RZRWdXbnNR?=
 =?utf-8?Q?PRc+c9Q8qm59oRn4E70VXaFUm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a44aa2d3-5819-4413-482e-08dd7b7a7600
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 17:33:25.5370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNtH97XvL2706weX/i4ge3nsO+1dCzlY3KVwWAERX9FCqvZwiuKDzCEOkIRTZ4QqNKCHu7MBjR2z1z2g9T359g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768
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

--------------LBAgiDaTSLghm592LOlb0JZT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/14/2025 10:54 PM, Alex Deucher wrote:
> On Mon, Apr 14, 2025 at 1:17 PM Khatri, Sunil<sukhatri@amd.com> wrote:
>>
>> On 4/14/2025 8:59 PM, Alex Deucher wrote:
>>
>> On Mon, Apr 14, 2025 at 5:44 AM Khatri, Sunil<sukhatri@amd.com> wrote:
>>
>> This is how i see the future of this code and we can do based on it now itself.
>> disable_kq = 0, Use kernel queues.
>> disable_kq = 1, Use User queues.
>>
>> disable_kq = 0 means allow kernel queues and user queues.  disable_kq
>> =1 means disable kernel queues.  I think we'd want to allow both at
>> least on current chips.  I think if we want a general knob for kernel
>> and user queues, we should do something like:
>> userq:
>> -1 auto (whatever we want the default to be per IP)
>> 0 disable user queues (kernel queues only where supported)
>> 1 enable user queues (user queues and kernel queues)
>> 2 enable user queues only (disable kernel queues)
>>
>> In case of kernel queues we should not be even calling gfx_v11_0_set_userq_eop_interrupts at all. Instead its better if we add a this check "if (adev->userq_funcs[AMDGPU_HW_IP_GFX])" before calling the gfx_v11_0_set_userq_eop_interrupts. I am assuming there wont be any mixed use of kernel|user queues together. Let me know if you think otherwise. Regards Sunil Khatri
>>
>> We should only be calling it if user queues are enabled.  I think
>> there will definitely be mixed user and kernel queues on current
>> hardware as we ramp up on user queues.
>>
>> Alex, are you saying we could expect some device where Kernel queues and user queues will be working in parallel ? If that is the case i can see we need eop reference for both the cases and this change then makes perfect sense but,  if its either kernel or user then disable_kq feature check looked better in control.
>>
> That's the case right now for gfx11 and gfx12 dGPUs.  Even if we did
> add an option to disable user queues, everything would still work as
> expected with the way things are coded in these patches.  The presence
> of the userq function pointers determines whether user queues are
> enabled for the IP.  If they are NULL, then we skip the extra
> references so the logic works for any combination of user queues and
> kernel queues.
Fair enough,  we do enable the function pointers based on IP.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> Alex
>
>> Regards
>> Sunil Khatri
>>
>> Alex
>>
>> On 4/13/2025 9:36 PM, Alex Deucher wrote:
>>
>> Regardless of whether we disable kernel queues, we need
>> to take an extra reference to the pipe interrupts for
>> user queues to make sure they stay enabled in case we
>> disable them for kernel queues.
>>
>> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 7274334ecd6fa..40d3c05326c02 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -4836,10 +4836,10 @@ static int gfx_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
>>   static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
>>         bool enable)
>>   {
>> - if (adev->gfx.disable_kq) {
>> - unsigned int irq_type;
>> - int m, p, r;
>> + unsigned int irq_type;
>> + int m, p, r;
>>
>> + if (adev->userq_funcs[AMDGPU_HW_IP_GFX]) {
>>    for (m = 0; m < adev->gfx.me.num_me; m++) {
>>    for (p = 0; p < adev->gfx.me.num_pipe_per_me; p++) {
>>    irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
>> @@ -4853,7 +4853,9 @@ static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
>>    return r;
>>    }
>>    }
>> + }
>>
>> + if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
>>    for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
>>    for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
>>    irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
>> @@ -4870,6 +4872,7 @@ static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
>>    }
>>    }
>>    }
>> +
>>    return 0;
>>   }
>>
--------------LBAgiDaTSLghm592LOlb0JZT
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 4/14/2025 10:54 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_P7KKGW5etkuhB0Gy4rB9rHEj=+pTxZ8_-6+zUeVKgayg@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Mon, Apr 14, 2025 at 1:17 PM Khatri, Sunil <a class="moz-txt-link-rfc2396E" href="mailto:sukhatri@amd.com">&lt;sukhatri@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">

On 4/14/2025 8:59 PM, Alex Deucher wrote:

On Mon, Apr 14, 2025 at 5:44 AM Khatri, Sunil <a class="moz-txt-link-rfc2396E" href="mailto:sukhatri@amd.com">&lt;sukhatri@amd.com&gt;</a> wrote:

This is how i see the future of this code and we can do based on it now itself.
disable_kq = 0, Use kernel queues.
disable_kq = 1, Use User queues.

disable_kq = 0 means allow kernel queues and user queues.  disable_kq
=1 means disable kernel queues.  I think we'd want to allow both at
least on current chips.  I think if we want a general knob for kernel
and user queues, we should do something like:
userq:
-1 auto (whatever we want the default to be per IP)
0 disable user queues (kernel queues only where supported)
1 enable user queues (user queues and kernel queues)
2 enable user queues only (disable kernel queues)

In case of kernel queues we should not be even calling gfx_v11_0_set_userq_eop_interrupts at all. Instead its better if we add a this check &quot;if (adev-&gt;userq_funcs[AMDGPU_HW_IP_GFX])&quot; before calling the gfx_v11_0_set_userq_eop_interrupts. I am assuming there wont be any mixed use of kernel|user queues together. Let me know if you think otherwise. Regards Sunil Khatri

We should only be calling it if user queues are enabled.  I think
there will definitely be mixed user and kernel queues on current
hardware as we ramp up on user queues.

Alex, are you saying we could expect some device where Kernel queues and user queues will be working in parallel ? If that is the case i can see we need eop reference for both the cases and this change then makes perfect sense but,  if its either kernel or user then disable_kq feature check looked better in control.

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That's the case right now for gfx11 and gfx12 dGPUs.  Even if we did
add an option to disable user queues, everything would still work as
expected with the way things are coded in these patches.  The presence
of the userq function pointers determines whether user queues are
enabled for the IP.  If they are NULL, then we skip the extra
references so the logic works for any combination of user queues and
kernel queues.
</pre>
    </blockquote>
    Fair enough,&nbsp; we do enable the function pointers based on IP.<br>
    <br>
    Reviewed-by:
    Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a><span style="white-space: pre-wrap"> </span>
    <blockquote type="cite" cite="mid:CADnq5_P7KKGW5etkuhB0Gy4rB9rHEj=+pTxZ8_-6+zUeVKgayg@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">Alex

</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:CADnq5_P7KKGW5etkuhB0Gy4rB9rHEj=+pTxZ8_-6+zUeVKgayg@mail.gmail.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Regards
Sunil Khatri

Alex

On 4/13/2025 9:36 PM, Alex Deucher wrote:

Regardless of whether we disable kernel queues, we need
to take an extra reference to the pipe interrupts for
user queues to make sure they stay enabled in case we
disable them for kernel queues.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 7274334ecd6fa..40d3c05326c02 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4836,10 +4836,10 @@ static int gfx_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
       bool enable)
 {
- if (adev-&gt;gfx.disable_kq) {
- unsigned int irq_type;
- int m, p, r;
+ unsigned int irq_type;
+ int m, p, r;

+ if (adev-&gt;userq_funcs[AMDGPU_HW_IP_GFX]) {
  for (m = 0; m &lt; adev-&gt;gfx.me.num_me; m++) {
  for (p = 0; p &lt; adev-&gt;gfx.me.num_pipe_per_me; p++) {
  irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
@@ -4853,7 +4853,9 @@ static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
  return r;
  }
  }
+ }

+ if (adev-&gt;userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
  for (m = 0; m &lt; adev-&gt;gfx.mec.num_mec; ++m) {
  for (p = 0; p &lt; adev-&gt;gfx.mec.num_pipe_per_mec; p++) {
  irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
@@ -4870,6 +4872,7 @@ static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
  }
  }
  }
+
  return 0;
 }

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------LBAgiDaTSLghm592LOlb0JZT--
