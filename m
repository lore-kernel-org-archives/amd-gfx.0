Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C71BC5DF81
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2026 19:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6BD510EE9B;
	Wed, 19 Aug 2026 19:07:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q4tyuapM";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011042.outbound.protection.outlook.com
 [40.93.194.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27D5910EE99
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2026 19:07:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGr4YU7G7ug92fJGe3jY1s4h50bWRL0kK+2eMUZzhQqoucketkx7jU/TikkFg6z+763CVc3eoZ28fANG8EJciUZTI2fkXNhFOw2mfxhLDHsY2Q9UH+QCFP1PgN0Qvc+3PLQA2OJu+ggghiw53b1fgKbgFO9VuNvPcsem2DgPmlDHBs4xDQWylSy9Scv941ns4+SaBOIOgK+Dcwj9Ip0YnHZlyfwLFHO+1vVLgeQKyYn6SpxClf5AfyBKWvjPXFnkgOU5mehqnWddSSmkzo0dsnEYJ6IfOZQtHAlefmG+2BX6Zft4QpPZDhg/Yyk/HQF2KD85M4F5sxWSuffwjduTPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLtDvq0dCk5kSW4RJbB/hjFFm4wWSppjglgvHwZmZO4=;
 b=ZiS3hNtAvuiUSZqlrh2XLkr7y8jI2pdMwzggV40ZoNE3xzHYoIqKkoWIfH3ciZxR06mzY3BYj7Px3dXxDLKFS9ZeZl8wWVO36wEJnUha7Rutdw0KrgDfVMk0H1uDOh/tBa68uRaR1kmM2wzIIL9Reo//CngCxhqZs47INkK2eAQHbGOOLK3i3djosUOeh8uNvDAqtxVQ/LfKmaO3kWVkDPi2otDevkcHpeGJmLhB4ynYnORXFvGaOaFyHqRQW6Nj1z05lYgVar3wWUbi2Dd/QeubwsqsMxc2dvslZLc1iscZ0Dpti3JMPiMCKtScyDDiX9aEN61NUcyWPszdz+9kFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLtDvq0dCk5kSW4RJbB/hjFFm4wWSppjglgvHwZmZO4=;
 b=q4tyuapMf96UAKIyYfH3Bkz614xnZtGZ1d4QlB8BAuIo3UnuuHlQmKmC9CGatJYoBaZDgMBMBWWKG7mfLZ2NuTjBTnG2cYQHGAqMfIE/o6Sy/G/DdZuOYb8oAhcJjxIqXaKXLZ/gfTqc56AXrB0Jbr5qdtYVPvzO1AMDVkhyad4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by IA1PR12MB8287.namprd12.prod.outlook.com (2603:10b6:208:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 19:07:20 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 19:07:20 +0000
Message-ID: <e77850ac-1471-46cb-ba6f-4cc16d703515@amd.com>
Date: Wed, 19 Aug 2026 13:07:18 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm/amd/display: follow-up fixes for LUT segmentation
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, harry.wentland@amd.com,
 simona@ffwll.ch, siqueira@igalia.com, sunpeng.li@amd.com
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 "'Dr . David Alan Gilbert'" <linux@treblig.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>, pekka.paalanen@collabora.com,
 robert.mader@posteo.de, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
 "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
References: <20260819161106.27702-1-mwen@igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260819161106.27702-1-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:303:b7::35) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|IA1PR12MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: 957c0838-9e6a-4758-70d0-08defe251811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|56012099006|10067099003|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lACseaYGLeikLKFyc9Rb7IPw2PHlUH5hIt+hpBAozD765tqlpuxjro9SdLInv+dVfo/xHH9iBbD3zdnOpBViZ6aTMhduLGxh1uXXPldIkYnkq97fMse3LLvolQezGpAXeeU/NUskvDJhr2vcKtf37cW+S/eA8QP+Zmto1OGeCTMycdyHJaozWwVqd3TKmh1UFmn1JmtnP6GNbxNmFh5lwL7Q425W/A/3T42KBKv5bVUPUbkKiHQ7ZDe98FdEoA7BC0pH79iovkAUBAv82lghue9iqcrLDG63KzMy8SiyJAqj7d52cBD8+aRHppPHflZ3hx/ixCXbaPgJsBfY/JXqRS0wsDlBI5rE19WJSeuwLcnB37Lu/TFB7JiOZJTkBi/Glmz4PL7muDZoGkqrHWc36/m/wWyp9G/xQbtjDIyDtf7pwRduAspNEqdSbLgd1evZDaLgcc+H5Ld76qLC87cLbSFip/ilutsZVdJiGIH/UHC2n2AkLUPdFjTOQ6GtpFaYi+Eex6+WRoocHlBwjihGoIB6iLX40KHUs60g/gmrx0gasJ+XVDjyRqQz74vusk7brfwvQ9VQaLWn7f5t0cNfkwtc0lC3ikZI9UZAwAjJ6P5NMDOl7UM+ub6siTm3YPZfkW371MjT/w6kS9yJzTV2/+2zbkuYWwgyVLQutm0Smq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(5023799004)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVU5WWVFcUczR093WmxLbjRJdE9VQVk2a2lYTy9DWVdGZHhwQlM1VmxpZ0hC?=
 =?utf-8?B?Y3hIMS9SYnZOVko5NTkrSVdYWHZOZWNZOVZvUHlwVWw0eEcvSVhYeUM3YWhv?=
 =?utf-8?B?UEVnMnA1R0xxeTRrOWVJMWtJb2hpdHRiOFdxcVY2ZGQwMU5wa01HeGFlbHJR?=
 =?utf-8?B?cm1Bc01YNVg3ZE5TRk1LSkVJd1JTVkR5NVl4TVJXNjZ3SVBuMTR3SjZqQW5L?=
 =?utf-8?B?WjdReXlyVXkzTWRTWmk1c2VjejAxWlp2eUJ2RWRCcG9Sd1FSdDhNVzEvZjVK?=
 =?utf-8?B?eXZuWHpSRm5BU1VUZlM3NjE3VDFTNFRsakJta0VuMFVud1JlM05NTTJjbkFa?=
 =?utf-8?B?ZGg2dCtsbFhWZlVIREtEU20xVjJlS25LOGZIaVdpVlJQNnFtQ1kyc2NVTHRN?=
 =?utf-8?B?T1RJUHIvb0k3NERCbDlDZ3NCMTNPUWNPSHNIcWJyUm16ZWVUNTJ3NWQ3dlpP?=
 =?utf-8?B?ZTJxay93bnIzTUluZU0vcHUycmZsSmVPWVdjNE5CODhiNnIyOG5mOGtoamZ4?=
 =?utf-8?B?RlQwcjcvNzgyR0pJV0tiZmc0OU90cEhicndubHg5MFdPMmhXUDBhZzcwOTVR?=
 =?utf-8?B?Y3lDaERqOVhaU2paZG16VHJpYThHMjZ5L1JHeGdkK3g1QXRYNnpESzU5ODh1?=
 =?utf-8?B?WGo0bTJraVFtYkRXRWFabXZYNFdQS0NVSjlHLzV6YVpJRFFHZ09mVWRJUDZI?=
 =?utf-8?B?djVHM3BNaHJocWtGc0l6eWxXcmdUVU5iVll2c1Q4SW9KUmt5QWFrSUFEY1ZJ?=
 =?utf-8?B?bU1kVUdoa1lrQXFHaUV3RE5PNzF3ekZjWTBHMWF6cTI0WG91M3ZwSyt0cHVz?=
 =?utf-8?B?NlhkaHpUWi9QV2JRM2JYSW81Rm9Ta3BEUjVtS2c3OHlVWmJtRzUzWWVkVDVQ?=
 =?utf-8?B?UjhnZzJVRFVqTmVTTmlXUzRqd2FkdG9VZFZlb1kwc2lkdjZGeFVES20xa1lp?=
 =?utf-8?B?ekpzMGhVY09pYlNYd2lDYmwxaCtGWmdicHR5WmFvRjRYK2RnSDNWSWdSVnNT?=
 =?utf-8?B?ekV0WllON3o4dy8yZ3Z1MlRpUmFHYVNwSXQ2UW5jYkRsSFJkRlBjZGM4R0My?=
 =?utf-8?B?WHVkc2F2c2REYTlSV2hDaEZuU1I0d1BtaXFlcGRkOTgvWEh3em1rNDRYRlNM?=
 =?utf-8?B?MUp2RUhTZVBpWkFYMzFiNm5TQjE1bWZZOU1EUjAzdlNDeHpNeklYOEVSalNP?=
 =?utf-8?B?VHF4aUp0U0RIcGExZGpJMHpXdnFqaENHb2M1Uy9CQlIzNDJzQjdGRWZmcXRS?=
 =?utf-8?B?RHN3RVlxMXBpaFo5VGF5NXBwRTF6M1laQVFLT1VQZFhlS3BHMUlsUVJsMzQr?=
 =?utf-8?B?aXdSMXd2eXlDTVVWMGNtdFg0QUtFSW9GMjAzeXE5Zi9tR2w2d0tIRlRBZjNU?=
 =?utf-8?B?UGNkdTFES0dQa2ZoUEhCYngrSVVhSTdnejlyMEJSTEFKNVdQOWNiaWNHR2lx?=
 =?utf-8?B?OGM2a0x5dSt5MWpibWFHUmF1WG5hQUl0enl2dUErUzBEd1lIR3dnOXljVlRG?=
 =?utf-8?B?aHNXUzJ3dUcyUVBnQ0JjTW5PV1hpNi9oZ2lIbEhVYnorYTViY1h0TWMyZ3ht?=
 =?utf-8?B?aGtuUXFkT2pnZ093ZWYzSjNlMTczSkJWMmNuUE4rR05TME9uRW9KdGo1R3gr?=
 =?utf-8?B?SUN4eVBoL1p1TGVTM2ZzVFRRZkllRkc0eHdnMW14NVA5VE96NVJWNVV3aStO?=
 =?utf-8?B?RmZ0SGFmZDlMamFUYnhvUFU0UkRSUWpVZFNFYzJTTU5jRkhLN2JHMnBTTTQr?=
 =?utf-8?B?TmpIQ2lPZjg1Vk84YUN5U2VTSUlFZzVMN1l5V1RHSHRKaDZUcXNJQWxoZlNV?=
 =?utf-8?B?K0h2SXNEY2JiSTFrcTgxSFh2M2RwZitCeTJ5ZnZ4R3cyNXFhdllsYldnUUhE?=
 =?utf-8?B?SWcyMjBTWUxMVjVPYW5pRHNXTWg4dlg0TGhnR0U3bHdlZldUOUQ1WDBWeFlD?=
 =?utf-8?B?R1NKWEdzQUlRVnJSa2FrSDZYQWxwMEthaHdLZk1JOGJ1V0txNmhYMXl2OFYr?=
 =?utf-8?B?RURhMkYvUlJMb1NMakZHK2w4NVM4ZnN4MzhHZlNhQXVRaHpxeG5wUHIzTUMy?=
 =?utf-8?B?cmQwNnU0L1IxdkRRaHI2dytDY3p4TjRnRTkwUnNrYkNsT0ZSMHdtSmRJNGZ1?=
 =?utf-8?B?R1RmRStwYURrakxvQ2JCODhkbXl4RjdLU0dSa3A4ZVhxQjh2RkpycXdTMG1z?=
 =?utf-8?B?bGxzU3hHWVFMbjA2Q2V2NGdZOGhUV0UrNlA3WWhyME5mNUlaTmpiMXZwMVZR?=
 =?utf-8?B?UU16aGIvNUJjQ2V3RlgyaEZRRGtYUFd1WUpKeWQ5TXlNaHRSNm5qVFcwTlpn?=
 =?utf-8?B?Wnp5TEhPbisrSmkzQXprWHY0YVlrRWJjVHdjVnZ3d3MwUGpWOTVYdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 957c0838-9e6a-4758-70d0-08defe251811
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 19:07:20.6615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCNeZ0h5nGSxhx/TCMexsZ8AgR9xb2xWvUp5cUy99FNJ7s5g7Qec/cC9x+LKliR5UgO0NoqbgMlBIK21i5qKAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8287
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

Thanks Melissa.

I tested kms_colorop on DCN3.5 DCN3.14 without any problems. There are 
some comments regarding to commit messages which I replied to each patch.

I will send this patchset to next week's promotion test.

On 8/19/26 10:00, Melissa Wen wrote:
> Extend halving distribution for all curves/custom-LUT in a
> encode-to-linear operation, not only PQ/SRGB. This fixes failures in IGT
> kms_colorop test after [1]. Also use the CM3 degamma helper that
> translates curves to hw points for DCN30-based family, not only DCN32,
> since the banding issue is present on both.
> 
> [1] https://lore.kernel.org/amd-gfx/20260623160112.1636801-1-mwen@igalia.com/
> 
> Melissa
> 
> Melissa Wen (2):
>    drm/amd/display: use halving distribution for all encode-to-linear
>      curves
>    drm/amd/display: use translate_curve_to_degamma_hw_format on DCN30
> 
>   .../amd/display/dc/dcn30/dcn30_cm_common.c    | 34 ++++++-------------
>   .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   | 10 +++---
>   2 files changed, 14 insertions(+), 30 deletions(-)
> 

