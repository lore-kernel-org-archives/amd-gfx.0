Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C84CA0ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 21:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 338B410E54F;
	Mon, 11 Aug 2025 21:31:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="htwrXUiv";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 063BA10E54F
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 21:31:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J75J3J7/LrBR0lr0D91BXfpPtfWYn/T5+FLyqJfWD9xgCtyFwhBKwfdlAkIezd2VsgTEPPSzZ5+Seb8Ddxmc0uc9x6YFzd7zwuo10uKX+vacHV+IaSwiXr6681XkNzTGAIf+jDvPw8jjeo63p4PIef2XFzCOi4pgDt/6Ct1fC9Y66K/h8U/b26fcHIzcw6fj1lARpRl1aFC5Ip0dK+rHIMiVloMRY3FwVlrd5QNKOGNT4TqiQcTS8Tv5Yfm6kHBlaVb+jX/uYtdk3Im0F+ZwmIzQZI26bwOGwI5+bIwucLaQ+37jAjvOiKhatiz2yirSXsn4+IzdR5koWowqjUhodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJeCZrd0DAql/DoSVFnl2XfW6no7JftY1RlznI5Jm9o=;
 b=mnjJtdkVDtt/TfOwMUSpq6XjDduoZDE7QU1RKTEY1QIP+glkOYQlDQqjl+pPiI4VYcxF1Z1fVM+i6cPDnfxT8tibfp6e/cQZLh+wqZXq/nmGvsFcbFZyEYa2WnwCINpXNGhbnBJHbyd0VAHKMNsFyKRZCeNnTCpNZqfPYxKuy/FEPzAYeJl8s4fZSEbH/1AHdZ0xU7yqUSyRf09hTE/JmAMSMwlvUI5Hsmt0eIYvH9Okr8bN2tax+yBdeoW63LVITqLHzOgB8+1dl1KWWiljUxMvdXtTwo5fJbF+fdjepTKPUzHyqWuHjvgItRWM9hvBkTfCPFSrxYdzmMFf/mDhcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJeCZrd0DAql/DoSVFnl2XfW6no7JftY1RlznI5Jm9o=;
 b=htwrXUivYZLLkIHAdVT0OhnAPw8P2mnuvp5HNf3ncMgxBlCmBKGo9I4FDXhiQ61QAnpQbeNQ7ajzB0NNbS7yoEjHOf7Mx6GqNKNwizbvdl6QX80p9MXasf2jBdG+Ue43ws2faGXDniCIuXQ7W2GMksPSNhrS2ay4PjZhqcJxKuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by CYYPR12MB8991.namprd12.prod.outlook.com (2603:10b6:930:b9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 21:31:24 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.8989.018; Mon, 11 Aug 2025
 21:31:23 +0000
Content-Type: multipart/alternative;
 boundary="------------79y8g0wU16DhTu1Sfi0oFaWV"
Message-ID: <dc49b07d-b82f-4dd5-8797-b5c723a7f824@amd.com>
Date: Mon, 11 Aug 2025 17:31:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 1/2] drm/amd/pm: Add VCN reset support detection for SMU
 v13.0.6
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Ruili Ji <ruiliji2@amd.com>
References: <20250811010437.1895121-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <20250811010437.1895121-1-Jesse.Zhang@amd.com>
X-ClientProxiedBy: YQBPR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::33) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|CYYPR12MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: eddf0f7e-f180-411a-3322-08ddd91e6b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkFnZkxuRENnaEMzT1BiWDhxUjdCeWtZWVVXQWxCMzRQQWs3d0RZZHN3QzVB?=
 =?utf-8?B?REpJbmZFNktlYng3dzlJdm01K2ova3FZY1RhV3A5UnY3QUlreWRvNjUyM3dr?=
 =?utf-8?B?R2M1YjB1Ynd2WTNmTGRyMjhpYVUrSGtzZndMdzY0WTFGakVpaVFqamNCKytn?=
 =?utf-8?B?Q3RsR1Nlb1JEZ0M2cWcrbE9YZTk3R0xoZFBwOFRRRmF2eHJ2S1BrZGtpcXZK?=
 =?utf-8?B?OUZEV0NFb1ROUXpsTndQZmVna3hLYjhkUDI2OEJhQUp3Y0dib1BxODJqOGRn?=
 =?utf-8?B?dGxFb0xBbGJpWTVHZkN1U3Y0cVg4S1JHQTJlbXlPWmtUZ1liQ0RMcHNvOC9r?=
 =?utf-8?B?dk1hUTF1WXJKbEFEaTVWS2lPUUUzbHBpMXBpRVNVWGhuYnVaRkRXTGkzUnQ4?=
 =?utf-8?B?UnN2VTZKc3Q5TS9wdDFQR0FuNWJwNzYvRDdjSFR6OXNGbXhtRkdmYThscnc0?=
 =?utf-8?B?NkFJaDJrQlc5c0h4WkpmUnE5MzYramtPZ29UQ1NCMkpsQmQ0NXZlMDRYN2g1?=
 =?utf-8?B?cU5JdWdMSGlsL09yeUU4MnpFRmluS1BXa0dVcXB5bjN6OXV5MGVwVU9LMkc0?=
 =?utf-8?B?bHZFQkRrS3pXc0RHSDEzRkdLU2pJelZYREl5SmV5VGlNOEdCa0RBNUpDVEUz?=
 =?utf-8?B?QTFCeExUN1BYM3YzMnk2VWgrMWd6dHB2ckRlMCt2RmpmakVkM2Y1clEvMHk4?=
 =?utf-8?B?WVZaSHFQN2R1dTNrcytvSi9Mb1k5dlYrY3NJb2JoeFlQWERLRm5WK0JmYkdF?=
 =?utf-8?B?emNMempvL2F3VzlQbDdXb0lLWkFUUXV1K0tVWDdtbWdoT0JFTG8rVkF6Zlpz?=
 =?utf-8?B?U0ZSblVmLzQ4RW1TZ043d0NUTTBzRExJckg1TEdwS29PdEJjeW5mTHJjQWor?=
 =?utf-8?B?UzI0VUdWZXZvKzdKNkZVQ2xFOFM1NVNaL2t0V2tQOENMandaVFNIZnVEWnAx?=
 =?utf-8?B?c3JOTW5BeGFpQ1JIaEoyM2hnSlpGU0JJRmk4cGVkTkQxQmVOQXBscTZiZ1Nw?=
 =?utf-8?B?UG4wNjlHZjJIQlpELzM1cXZGc1h0aVVZR0lYckVFeWJmUENyKzJUbmE4SGZw?=
 =?utf-8?B?RFhCN0U5YW9peG9qbHF6Uzk3V013Tm9Ca2VLK2JqSHNoNUNYMFloL0Zia1l5?=
 =?utf-8?B?aDVNU0ttWHQyK05lQ0xPVTJpUmlMSXAwKzhqZUYwSVZxSU9IOWh3WW1VNHRD?=
 =?utf-8?B?ZWl1WFVZK0tiZGlLM3V0akdaWWh0RGFvMnhRcWRrcVpBM1prQk5vQ0EyWjRI?=
 =?utf-8?B?WTZ6SitHd3JxbUxObjNYRUVvUWM2UVNjM09oOUtydEJDSHZZdEMrek1Xam9S?=
 =?utf-8?B?aXd1QnVpNmxZRDVQNXFtRFNhUWhRZEVobWxlUlp5RllYTnpQdHM3NDdUbFlI?=
 =?utf-8?B?VmdDb2JsSkZYUlg5UWhybFhwZDdPNjJ1OURMWDNHN3E4UkpjbTJEMk8yaW1D?=
 =?utf-8?B?RHR6M0xFcXBhc2RHTGZnVy90alY4eEI0dVQxZW9DM3pUWFdTeHJLb3pQV3ZE?=
 =?utf-8?B?dk0rS2J2ZDVWU0lTSUxJQ2NKZlh4NGJWMEZiaTNiSFphQ3JJaXhNQVBnbFQ4?=
 =?utf-8?B?bjE3THB5QXRKdnVncGlOeHI4Njd3N0ZHZ25ubzc5bkZCTTl0aFVzUzNzZ25U?=
 =?utf-8?B?MjFJQWZFdlZmMHdhNFgzdGRBaUxHWUxwc1E1ZFJ6a3pCUUFSUjRxd2ozdVJp?=
 =?utf-8?B?NUN2RGdaU2svSXNUQllicDA1TC85aS83ZGJMRTFoQ0QwdThtUk0veDNUVkhl?=
 =?utf-8?B?RHJSV1FLYk9vLzZ3V3lMRW1LK1dPUE1ESm53WUVxQ2JRazhjWkxKU3BFckZZ?=
 =?utf-8?B?bmdFdmJSamNiMmtmSU9rekVaTHovOHk5SDJkbENsT2hDNTJLdnJJbHdRSDgv?=
 =?utf-8?B?NWk0VURMR01IRkc2RzFEb1JESHBoRVpnc09TdjFvZ0ZiVHYzdFl5OU1jcUcz?=
 =?utf-8?Q?7CHmDMDBKxY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlhWZXJ5Q0NISWQ5Si9qMk5sckVNUXNOZkZHRmVsYmM3SVR5VnB2NzArK0tU?=
 =?utf-8?B?WmsxeGVnWmMvS2J4dDJaa0lUWFFwbVdkeG9kcnJsWTRjZDAwUzVQUG9yL2Ro?=
 =?utf-8?B?a05GOVhFTnNySTNQZjBOenk5MVc5bTMrT283RnRiam5YSSt2bU9taDhtRlhs?=
 =?utf-8?B?Rmt0MXRSNWRVZFExaFJDZjYzbktzOVhzdTlrTWxQc25ZbmRaRHBxYW5nRFpy?=
 =?utf-8?B?WWVpMzZXUzlVUzlrRUVua1ZoQjNHSHhEZklmOVRlVHNCVSsweEhIVTM2TWpj?=
 =?utf-8?B?MTh5VGdnRDlhTkE0bEF2cWdXbGZZUmpDT3Z5Y05wbDRadDlGbEZwY2h6MFFk?=
 =?utf-8?B?a1JkMlVSUWVKN0lrOCt1NDYxSlBKK2pCN3Btb2NoenJmOWdpaUVRWGVxanZs?=
 =?utf-8?B?QWVLYmFVWVdsSzNMUXB4dlptQTl0Z3RLTjgvU2x0TzhycmhCTXo1eTZXL1pr?=
 =?utf-8?B?a1cxVFA5emFpNmFOdjJHTTZXM1VpaG1UczNDZ21wT3R0SXpNVSs4NUdPZlMv?=
 =?utf-8?B?L05waDRhcFR6SmZKUGo0ZVZzV1p5QkFvbmRZT29iMmFUS0tKWXhHckwrdHFC?=
 =?utf-8?B?V1VjcFkxcUxHOFh2M3VvUkZwWW1zSVFpSUIxdlNwei9tZ1ZrZmU2N1plKzRj?=
 =?utf-8?B?c3IrSVB6SlUwbmZKUjg4cXNmY0s0QS9McW5NNExJS2Y5MDhSODJxMU9WMm9m?=
 =?utf-8?B?SjJmUTVjV0RUTEtJak9UOUw5Q2xqNElpbVZaWmdLOCtWME54OFJYbVJUMzN3?=
 =?utf-8?B?Z1VnVHNlNUl2N1pJSkpEWUJ6aU1aaXFxNTZFTEFzaVI0bHIxenlwTDFVTjVi?=
 =?utf-8?B?T01PSE8zMXpoLzI1Snh3VG5YKzBaSkdXN3NpK1lTWTJteEJJUDZPa3FWcjRu?=
 =?utf-8?B?WFFENS9MWk1XZ1BBRHRVRUxaNlFKY2RBSWJZc2NWTkpuOXk3WnBUUWwzTklE?=
 =?utf-8?B?U25oSHhsY3JFbUhQbHR5VHJHVGFGT3pjRko0ZXZ2UHozVjc3d2tmU3IvdThh?=
 =?utf-8?B?LzhkZzkvOFdlcXRIZjF3UlJLNDBYNWJucmpjUEl6R2VEVHVjTEQ0TFRXaUNE?=
 =?utf-8?B?b3BZMlpES2QwSk43MWtXT3NwalU5SEk1WEZDakhlZm9VcUs5d2hQaExTaWor?=
 =?utf-8?B?VHAybjAwbndYSzFTVldvRXVZdVFXazQvYTRlM1dNZWoxTDNYdk1UODJpSHFP?=
 =?utf-8?B?bFc4YWRyR0tZYmRPT3J6c3hPQjVDTkxsdHFhRjFUbW5yUWpQUlRnLytvYXBx?=
 =?utf-8?B?Z0FZRnpiSkQwVFJXSDFzSlFZd0NwNGw1YjZZbEFPanNDaGFrK3lldERMSGYz?=
 =?utf-8?B?d1IzRnM5d2pVeFcwbGY1Z0R6em1HMGFUamVreUpISlE1TnhQS2RkSUZPVWd1?=
 =?utf-8?B?ZkdKMVpETmlhQXBsS2tzbmhEZkJ3bTY3aVc4dkp6S1NmcWpIYnI0RGJrd0tE?=
 =?utf-8?B?Wkw0TWhwTnZhN1p4YURWRitnK2I3MXRVSlkwME03ZVllWGk3azZmamdrdXpG?=
 =?utf-8?B?WkZENFRBR3JrV2pvMmNSQnZLVmhDRmZjWXpYUUhvTzE0VnRWSlpMZGpBWWR6?=
 =?utf-8?B?Z041UnU5bk1PQkd3clJ1bWZVeDAzcEd1QzRIcHAyR1B2djNLRllSVGdFcDMr?=
 =?utf-8?B?L3hmRm9qV0RhUE9zV1FlUzZnWUEyajlRV0NrMmovMzlYSW5tQTMwbzdVU1d5?=
 =?utf-8?B?RFplRGN4RUx4d2piMCt3UzVudlh4M2s1Mng4V2dtcDJWbjQvcld2MFFQTnlv?=
 =?utf-8?B?NlFnNWt1bHU5UTRxN2xHVFZpVkRwQjZ1emszM0VxUTNEMXpObTFuUDBHVGNH?=
 =?utf-8?B?aGVya3NFdHFDOTVzS0k3ZFdISmkwMTc3UEVhZ2JZOEpVWDNGdTFrNzZFdVkz?=
 =?utf-8?B?S3QrMnFya08rbGRHaVh2TktyVjU4WDJpelVjZDlvL0x3SGh4dUo5SytUTXF1?=
 =?utf-8?B?ODRnSFBNdWdra3VXQkdSUEFNa0xyY29xWkR3c2owbk9jK0N6VVZ5TGlraERJ?=
 =?utf-8?B?MlNuejFtWDF0RXg5bVFQamp3S2ozK2Y5eXpaRHhybk93RG5OUnRNN0RQdlFL?=
 =?utf-8?B?MXRDZjkreENBTDZFQTNzaytJUExhNHljbWVrbGxYYldERU93YmVmanVPZWU3?=
 =?utf-8?Q?1QSU/7s57z3EgT0lpaFj7Cinn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eddf0f7e-f180-411a-3322-08ddd91e6b97
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 21:31:23.5628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sk1epDqIiBh6iGQFBywDKxZW5OuBvx5H59pHudybFjt9IcU+SKmEcOh4S2ZUbpB+zyfNtxNJxYsEA+ERW5kjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8991
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

--------------79y8g0wU16DhTu1Sfi0oFaWV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-10 21:03, Jesse.Zhang wrote:
> From: Ruili Ji<ruiliji2@amd.com>
>
> This commit introduces support for detecting VCN reset capability through
> the SMU interface. Key changes include:
>
> 1. Added amdgpu_dpm_reset_vcn_is_supported() interface to check VCN reset support
> 2. Implemented SMU backend functions for VCN reset capability detection
> 3. Added SMU_CAP(VCN_RESET) capability flag for SMU v13.0.6
> 4. Updated PPSMC message definitions to accommodate VCN reset functionality
> 5. Added version checks for VCN reset support (fw_ver >= 0x04557100)
>
> The changes maintain backward compatibility while enabling proper detection
> of VCN reset capabilities when supported by the firmware.
>
> Signed-off-by: Ruili Ji<ruiliji2@amd.com>
> Signed-off-by: Jesse Zhang<Jesse.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c            | 15 +++++++++++++++
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h        |  1 +
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 11 +++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h  |  5 +++++
>   .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h   |  4 ++--
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 18 ++++++++++++++++++
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h   |  1 +
>   7 files changed, 53 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 6e0d711820ea..518d07afc7df 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -820,6 +820,21 @@ int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask)
>   	return ret;
>   }
>   
> +bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev)
> +{
> +	struct smu_context *smu = adev->powerplay.pp_handle;
> +	bool ret;
> +
> +	if (!is_support_sw_smu(adev))
> +		return false;
> +
> +	mutex_lock(&adev->pm.mutex);
> +	ret = smu_reset_vcn_is_supported(smu);
> +	mutex_unlock(&adev->pm.mutex);
thinking if it is better if the lock is moved to reset_vcn_is_supported()?
This could avoid calls from different location where it does not hold a 
lock.
> +
> +	return ret;
> +}
> +
>   int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
>   				  enum pp_clock_type type,
>   				  uint32_t *min,
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 09962db988d6..9748744133d9 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -615,6 +615,7 @@ ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev,
>   int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask);
>   bool amdgpu_dpm_reset_sdma_is_supported(struct amdgpu_device *adev);
>   int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask);
> +bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev);
>   bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
>   					  enum smu_temp_metric_type type);
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index dc48a1dd8be4..a03d37bd9e48 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -4106,6 +4106,17 @@ int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
>   	return ret;
>   }
>   
> +bool smu_reset_vcn_is_supported(struct smu_context *smu)
> +{
> +	bool ret = false;
> +
> +	 dev_info(smu->adev->dev, "SMU driver smu %p\n", smu);
> +	if (smu->ppt_funcs && smu->ppt_funcs->reset_vcn_is_supported)
> +		ret = smu->ppt_funcs->reset_vcn_is_supported(smu);
> +
> +	return ret;
> +}
> +
>   int smu_reset_vcn(struct smu_context *smu, uint32_t inst_mask)
>   {
>   	if (smu->ppt_funcs && smu->ppt_funcs->dpm_reset_vcn)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 611b381b9147..7990771151be 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1426,6 +1426,10 @@ struct pptable_funcs {
>   	 * @reset_vcn: message SMU to soft reset vcn instance.
>   	 */
>   	int (*dpm_reset_vcn)(struct smu_context *smu, uint32_t inst_mask);
> +	/**
> +	 * @reset_vcn_is_supported: Check if support resets vcn.
> +	 */
> +	bool (*reset_vcn_is_supported)(struct smu_context *smu);
>   
>   	/**
>   	 * @get_ecc_table:  message SMU to get ECC INFO table.
> @@ -1702,6 +1706,7 @@ int smu_send_rma_reason(struct smu_context *smu);
>   int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask);
>   bool smu_reset_sdma_is_supported(struct smu_context *smu);
>   int smu_reset_vcn(struct smu_context *smu, uint32_t inst_mask);
> +bool smu_reset_vcn_is_supported(struct smu_context *smu);
>   int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
>   		      int level);
>   ssize_t smu_get_pm_policy_info(struct smu_context *smu,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
> index 41f268313613..63a088ef7169 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
> @@ -94,9 +94,9 @@
>   #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
>   #define PPSMC_MSG_SetThrottlingPolicy               0x44
>   #define PPSMC_MSG_ResetSDMA                         0x4D
> -#define PPSMC_MSG_ResetVCN                          0x4E
>   #define PPSMC_MSG_GetStaticMetricsTable             0x59
> -#define PPSMC_Message_Count                         0x5A
> +#define PPSMC_MSG_ResetVCN                          0x5B
> +#define PPSMC_Message_Count                         0x5C
>   
>   //PPSMC Reset Types for driver msg argument
>   #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 90e66c8f2f82..c25dd7427f1d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -434,6 +434,9 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
>   	    ((pgm == 0) && (fw_ver >= 0x00557900)) ||
>   	    ((pgm == 4) && (fw_ver >= 0x4557000)))
>   		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
> +
> +	if ((pgm == 4) && (fw_ver >= 0x04557100))
> +		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
>   }
>   
>   static void smu_v13_0_x_init_caps(struct smu_context *smu)
> @@ -3171,6 +3174,20 @@ static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
>   	return ret;
>   }
>   
> +static bool smu_v13_0_6_reset_vcn_is_supported(struct smu_context *smu)
> +{
> +	bool ret = true;
> +
> +	 dev_info(smu->adev->dev, "SMU driver smu_v13_0_6_reset_vcn_is_supported\n");
> +	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(VCN_RESET))) {
> +		dev_info(smu->adev->dev,
> +			"VCN reset capability is not supported\n");
> +		ret = false;
> +	}
> +
> +	return ret;
> +}
> +
>   static int smu_v13_0_6_reset_vcn(struct smu_context *smu, uint32_t inst_mask)
>   {
>   	int ret = 0;
> @@ -3859,6 +3876,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
>   	.reset_sdma = smu_v13_0_6_reset_sdma,
>   	.reset_sdma_is_supported = smu_v13_0_6_reset_sdma_is_supported,
>   	.dpm_reset_vcn = smu_v13_0_6_reset_vcn,
> +	.reset_vcn_is_supported = smu_v13_0_6_reset_vcn_is_supported,
>   };
>   
>   void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> index ece04ad724fb..7c98f77c429d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> @@ -64,6 +64,7 @@ enum smu_v13_0_6_caps {
>   	SMU_CAP(RMA_MSG),
>   	SMU_CAP(ACA_SYND),
>   	SMU_CAP(SDMA_RESET),
> +	SMU_CAP(VCN_RESET),
>   	SMU_CAP(STATIC_METRICS),
>   	SMU_CAP(HST_LIMIT_METRICS),
>   	SMU_CAP(BOARD_VOLTAGE),
--------------79y8g0wU16DhTu1Sfi0oFaWV
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2025-08-10 21:03, Jesse.Zhang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250811010437.1895121-1-Jesse.Zhang@amd.com">
      <pre wrap="" class="moz-quote-pre">From: Ruili Ji <a class="moz-txt-link-rfc2396E" href="mailto:ruiliji2@amd.com">&lt;ruiliji2@amd.com&gt;</a>

This commit introduces support for detecting VCN reset capability through
the SMU interface. Key changes include:

1. Added amdgpu_dpm_reset_vcn_is_supported() interface to check VCN reset support
2. Implemented SMU backend functions for VCN reset capability detection
3. Added SMU_CAP(VCN_RESET) capability flag for SMU v13.0.6
4. Updated PPSMC message definitions to accommodate VCN reset functionality
5. Added version checks for VCN reset support (fw_ver &gt;= 0x04557100)

The changes maintain backward compatibility while enabling proper detection
of VCN reset capabilities when supported by the firmware.

Signed-off-by: Ruili Ji <a class="moz-txt-link-rfc2396E" href="mailto:ruiliji2@amd.com">&lt;ruiliji2@amd.com&gt;</a>
Signed-off-by: Jesse Zhang <a class="moz-txt-link-rfc2396E" href="mailto:Jesse.Zhang@amd.com">&lt;Jesse.Zhang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c            | 15 +++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h        |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      | 11 +++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h  |  5 +++++
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h   |  4 ++--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 18 ++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h   |  1 +
 7 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 6e0d711820ea..518d07afc7df 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -820,6 +820,21 @@ int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask)
 	return ret;
 }
 
+bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev)
+{
+	struct smu_context *smu = adev-&gt;powerplay.pp_handle;
+	bool ret;
+
+	if (!is_support_sw_smu(adev))
+		return false;
+
+	mutex_lock(&amp;adev-&gt;pm.mutex);
+	ret = smu_reset_vcn_is_supported(smu);
+	mutex_unlock(&amp;adev-&gt;pm.mutex);</pre>
    </blockquote>
    thinking if it is better if the lock is moved to <span style="white-space: pre-wrap">reset_vcn_is_supported()?</span><br>
    <span style="white-space: pre-wrap">This could avoid calls from different location where it does not hold a lock.</span><br>
    <blockquote type="cite" cite="mid:20250811010437.1895121-1-Jesse.Zhang@amd.com">
      <pre wrap="" class="moz-quote-pre">
+
+	return ret;
+}
+
 int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,
 				  enum pp_clock_type type,
 				  uint32_t *min,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 09962db988d6..9748744133d9 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -615,6 +615,7 @@ ssize_t amdgpu_dpm_get_pm_policy_info(struct amdgpu_device *adev,
 int amdgpu_dpm_reset_sdma(struct amdgpu_device *adev, uint32_t inst_mask);
 bool amdgpu_dpm_reset_sdma_is_supported(struct amdgpu_device *adev);
 int amdgpu_dpm_reset_vcn(struct amdgpu_device *adev, uint32_t inst_mask);
+bool amdgpu_dpm_reset_vcn_is_supported(struct amdgpu_device *adev);
 bool amdgpu_dpm_is_temp_metrics_supported(struct amdgpu_device *adev,
 					  enum smu_temp_metric_type type);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index dc48a1dd8be4..a03d37bd9e48 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -4106,6 +4106,17 @@ int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 	return ret;
 }
 
+bool smu_reset_vcn_is_supported(struct smu_context *smu)
+{
+	bool ret = false;
+
+	 dev_info(smu-&gt;adev-&gt;dev, &quot;SMU driver smu %p\n&quot;, smu);
+	if (smu-&gt;ppt_funcs &amp;&amp; smu-&gt;ppt_funcs-&gt;reset_vcn_is_supported)
+		ret = smu-&gt;ppt_funcs-&gt;reset_vcn_is_supported(smu);
+
+	return ret;
+}
+
 int smu_reset_vcn(struct smu_context *smu, uint32_t inst_mask)
 {
 	if (smu-&gt;ppt_funcs &amp;&amp; smu-&gt;ppt_funcs-&gt;dpm_reset_vcn)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 611b381b9147..7990771151be 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1426,6 +1426,10 @@ struct pptable_funcs {
 	 * @reset_vcn: message SMU to soft reset vcn instance.
 	 */
 	int (*dpm_reset_vcn)(struct smu_context *smu, uint32_t inst_mask);
+	/**
+	 * @reset_vcn_is_supported: Check if support resets vcn.
+	 */
+	bool (*reset_vcn_is_supported)(struct smu_context *smu);
 
 	/**
 	 * @get_ecc_table:  message SMU to get ECC INFO table.
@@ -1702,6 +1706,7 @@ int smu_send_rma_reason(struct smu_context *smu);
 int smu_reset_sdma(struct smu_context *smu, uint32_t inst_mask);
 bool smu_reset_sdma_is_supported(struct smu_context *smu);
 int smu_reset_vcn(struct smu_context *smu, uint32_t inst_mask);
+bool smu_reset_vcn_is_supported(struct smu_context *smu);
 int smu_set_pm_policy(struct smu_context *smu, enum pp_pm_policy p_type,
 		      int level);
 ssize_t smu_get_pm_policy_info(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 41f268313613..63a088ef7169 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -94,9 +94,9 @@
 #define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
 #define PPSMC_MSG_SetThrottlingPolicy               0x44
 #define PPSMC_MSG_ResetSDMA                         0x4D
-#define PPSMC_MSG_ResetVCN                          0x4E
 #define PPSMC_MSG_GetStaticMetricsTable             0x59
-#define PPSMC_Message_Count                         0x5A
+#define PPSMC_MSG_ResetVCN                          0x5B
+#define PPSMC_Message_Count                         0x5C
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 90e66c8f2f82..c25dd7427f1d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -434,6 +434,9 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 	    ((pgm == 0) &amp;&amp; (fw_ver &gt;= 0x00557900)) ||
 	    ((pgm == 4) &amp;&amp; (fw_ver &gt;= 0x4557000)))
 		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
+
+	if ((pgm == 4) &amp;&amp; (fw_ver &gt;= 0x04557100))
+		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
 }
 
 static void smu_v13_0_x_init_caps(struct smu_context *smu)
@@ -3171,6 +3174,20 @@ static int smu_v13_0_6_reset_sdma(struct smu_context *smu, uint32_t inst_mask)
 	return ret;
 }
 
+static bool smu_v13_0_6_reset_vcn_is_supported(struct smu_context *smu)
+{
+	bool ret = true;
+
+	 dev_info(smu-&gt;adev-&gt;dev, &quot;SMU driver smu_v13_0_6_reset_vcn_is_supported\n&quot;);
+	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(VCN_RESET))) {
+		dev_info(smu-&gt;adev-&gt;dev,
+			&quot;VCN reset capability is not supported\n&quot;);
+		ret = false;
+	}
+
+	return ret;
+}
+
 static int smu_v13_0_6_reset_vcn(struct smu_context *smu, uint32_t inst_mask)
 {
 	int ret = 0;
@@ -3859,6 +3876,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.reset_sdma = smu_v13_0_6_reset_sdma,
 	.reset_sdma_is_supported = smu_v13_0_6_reset_sdma_is_supported,
 	.dpm_reset_vcn = smu_v13_0_6_reset_vcn,
+	.reset_vcn_is_supported = smu_v13_0_6_reset_vcn_is_supported,
 };
 
 void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index ece04ad724fb..7c98f77c429d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -64,6 +64,7 @@ enum smu_v13_0_6_caps {
 	SMU_CAP(RMA_MSG),
 	SMU_CAP(ACA_SYND),
 	SMU_CAP(SDMA_RESET),
+	SMU_CAP(VCN_RESET),
 	SMU_CAP(STATIC_METRICS),
 	SMU_CAP(HST_LIMIT_METRICS),
 	SMU_CAP(BOARD_VOLTAGE),
</pre>
    </blockquote>
  </body>
</html>

--------------79y8g0wU16DhTu1Sfi0oFaWV--
