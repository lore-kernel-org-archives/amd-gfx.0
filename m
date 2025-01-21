Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8E6C02182
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 15:45:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ADA710E5EC;
	Tue, 21 Jan 2025 15:45:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I7xA2hXb";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::61e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3C2A10E5EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 15:45:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pG7GSTOv21gROy1wR6tCrBsshliFI3eIxCpyj3xHNzEn1RjfQquUU4kMhqf1XMFJZKcN43DiQs1088L4aOQEmpT6O1vUDse/4Jbidd7QeQzpivMKK1d2x47SlyFigUVvqp/xtuQsoJWM31xuDGg1R5kH7TtdKhfXIJ5STFYnUcFrrLKatR4FS+TJrwAL44GWVhxqdNZwTP66GtU9zIgEpkHLN6mo5jhvLFwyhtTqPfOIGmTlo1EV2s0TrvWIjMTLAGnq5CWnDWlqF4fTGtFua3V/1HKEtBbypz3A+VAk0xNZYY4ctjhixu+WE1aScSoIcaYFi595XFO2kzzC5MeT/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MGeQSB+fxbbOmewWokvzTEToNM5aTFGDsN2FXqhm0g=;
 b=YRDcjomeWFKCV9AbcDd/DUQNIwFEGq1juT7vn1vkD/jdgor6mNmwtA0w1C5cjlQnQqVagxt6lfCCqk2BQTIOnDsD748IebCv2FErKsbXTh+4EbPRUAdkJ/S0ZQgfR2qLZesyftB33fO90Ctmq+n5xtoIcI3vxd10fIZp9FrEnk04D+F5ouWkf8R1uha5q4QebjlxFfaS1afHBnPIbaplIhouVl4DiDRbWaIOPjKqLAgd9iHsf729Ci27CAhQhN3YKBSg+6KEnXh25OBjBR2lWDw7eEUemv01nqDntiUiMDgaDpYI55gcQzA0ijUFvcTiL5uYpgfjUR6IFONI7HUD5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MGeQSB+fxbbOmewWokvzTEToNM5aTFGDsN2FXqhm0g=;
 b=I7xA2hXbqvQzQgR2RnYT+6UePweisHZGPYn3uNGmnowKhghY/fqA/YQLjN9e94MV7g2+p+3kZfZ3OX992ROeWL1YhhG5MMG+Bp5CyiuKQLMXNMSPDKa2YQqqccyA/2O0RP8ILHkFkAr4dB3vDPQ1XxGvyS0IVa82ZurXJU0KDbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 15:45:20 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 15:45:20 +0000
Message-ID: <f70c0997-2ce7-487d-a32a-392fc707b587@amd.com>
Date: Tue, 21 Jan 2025 10:45:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amd/display: Refactor mark_seamless_boot_stream()
To: Mario Limonciello <superm1@kernel.org>,
 "amd-gfx @ lists . freedesktop . org" <amd-gfx@lists.freedesktop.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>
References: <20250120194903.1048811-1-superm1@kernel.org>
 <20250120194903.1048811-4-superm1@kernel.org>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250120194903.1048811-4-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0305.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::12) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DS0PR12MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: 112cca32-3ce6-46cb-e1fe-08dd3a329c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWZUZVZoaEVabWw4aVZScWUvakZlVU5kYS9vWTBudDBqSmlqRGhlVmdvamJy?=
 =?utf-8?B?Z2dGTE1UYU9qamxKQlh6bytJVFRIcWlvRFpZSFgwd0x5S0NCbWpsd2xZT3Na?=
 =?utf-8?B?NWk1Z3RGT1pYWURzamdpbFgxeUJDY0VuRUhock9aQ2Y1RGlSelR1c1pRVWpj?=
 =?utf-8?B?dFZaNUxkYTFZYnpSLzVETkJOLzFnOVZ4OGdSTFl6TXlvb1ZKclVXcjNPMmh2?=
 =?utf-8?B?MHluZXM3Q3NmRUpLQWlqaHl3TkpkUUpYV3l2NHRBSzVBWGl2bkJTWkxQNjlx?=
 =?utf-8?B?MTZzYzFUNEl1eXpjQUJEeXZTNG5ZU0xreTBKVlBOSzNhRllKRnY3aTJTZXZQ?=
 =?utf-8?B?eDBkVEN3eXNMSXVRQk01R1dmU3NlRUtaSXBJbWVvQmVqelUxOGxrbmM5NFVS?=
 =?utf-8?B?RUhTV3NyNzBkTDJFcllMTjlET0JmVjBwNTRDVUorOFRQZ2dxbW9BYUw3V3JP?=
 =?utf-8?B?SzU1dldWT3dTaHdCMnBTUG01U0p5eVZvYmd3UldyTmdtNEhYYnJxMkZhUG9n?=
 =?utf-8?B?VDdzaHM5eFNGSGtaNU1TOHdmYnZMa0liNFZ4bjl2TkF4SDlaaCt5QnZBVTdo?=
 =?utf-8?B?T0lTMzY5QmFnRVlFZGFFZzFuazRsUTdCQVhCa1BWSzJRbjlJYzJHQ3FadWZX?=
 =?utf-8?B?NDJ3V3BFVVRXN0ovQWR3MXRKK1BQaEFPU0I2N2tqQTVQL2VPTDVpYTBQajB2?=
 =?utf-8?B?NU1JMGduV2tCTXVYS2dONytMR1E2ck9GT3dmOTFQbkNLRnFPbHhOVWxYcVQ3?=
 =?utf-8?B?ZmljQmNEblJJZzdSL2l1aVZFd1ZaZGtSTWFGcTlhWFVQSHJzeTl1ekVSWHJB?=
 =?utf-8?B?ZVYzejJBOUhXRG9pMm40WGJDOTJzcUg4MnlzWmN4VkprU28rNWgvVmNBSW4y?=
 =?utf-8?B?OWtidzNwczZOZ2NtVGV2WEl1NnFXenIya3RtWXEwYU9DRTdjQ21XRlA2aVlU?=
 =?utf-8?B?eVR3N3NwTFhsdzMwVTRaQnd1N2UvOUtHYVQ4QXJqeWZMUVFzZ0dDdWVNRTE1?=
 =?utf-8?B?SElRaGw5L2t3Wk5PTzJQT2YyaWx3RWpWaVhKS0YxNDdCbldxNXFYQjA0Nnpw?=
 =?utf-8?B?SndJck92WVNGd1cwaGFsTk9XdzFVSkpzL2dTdGRNNlZHSXBDYXZDZzNrcGY4?=
 =?utf-8?B?a1BSSm5BWVhTNmdFRDBCOG91RmxSbGdsZGRta0MzUm54TG9YQ3hKVFNOOEV1?=
 =?utf-8?B?L1hhRyt1SE11b1lIYUU1V25nOVJMM2U0QnRrSXgzSnlpNDBHSndyTnh6MlpR?=
 =?utf-8?B?MHhvelNIcDJnQlVlT0VvTTJyU1lieDQ0Mk9mY2xyeFFtM3grTzRIWWFNazN2?=
 =?utf-8?B?VlBnM2hZMDRQZmJuL2JxTEFBNk5WRkMyZjNFVW0wSVdJS2NaekVid045MFF0?=
 =?utf-8?B?UmZvOE9oVlI1V1dYejE3SXlWbkhra3lFbDMrTTcyaFp2eDVNOGQ4Ym1NekV6?=
 =?utf-8?B?UGRLOS9mQklTZXROZ0V5VXdQOGJIV2FDOUFyTENyT1ExZjB4cDJsc2pEYW9V?=
 =?utf-8?B?anJ1SHp2a0Z3NHFid25OK2s3Q1dUZm9KYUVBcm1qaExmMUpiTVM4L092RE9E?=
 =?utf-8?B?eTZ5L0xUbkh6K0JGTitFSjNpVVVKY09mcTFOV3pwVlZjdFpGcUYydjBYOFRT?=
 =?utf-8?B?bm1yczQ2YkNvdDI2YUlFN3RyTlAwOXozcGh5Q0NFZDlVbGI3ZklveXBvV2s4?=
 =?utf-8?B?VzdrMURibW10aHRPbHBDL3lSL1BNMlNjNTY4ZUtNUUVvZ0dVYmdvRVkwRnJo?=
 =?utf-8?B?cWZPZERkUXVkUmVnVzhuNjczUU1NVXJhQm9ielpKb2ZHOCttSzNQc0pXMmVQ?=
 =?utf-8?B?SmRMT29obkxkK0d4MHFhVk01bGY4RC9ZMGFsWEYyWWE3NGdiOFN1cmdrUGth?=
 =?utf-8?Q?jWliX0IMRTUFm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWNxdnBXK0dkb0dDYWE0VEdDN2NZQkU3dmt1dVZ5a0pWM2tXVGhYUTRZaWJH?=
 =?utf-8?B?Wjg2ckRvTzg2THoyaXNVUTd4K0R1TGpMRjhhWTlPR0NSM1QwN1ZYdE9PL0pU?=
 =?utf-8?B?VU0wbVByTTIzZzdLd1R1aWU4MTk5Y3lTbmJJNGpFZ3o3Vm5uTFMxQ0ZmTUFZ?=
 =?utf-8?B?UnhJc0Y1UXBWRENwZUpBak41c0JDSFdlZ3NRVDdrQ2hGQW5GOHZPVTRzc21y?=
 =?utf-8?B?YzhrcHhwTTh1SWxXeFNHWW1SMjQrR3hpdUhNYlhJYVJzZm1yWkNDaEpSSGU1?=
 =?utf-8?B?bzJKQjRXb2ZTdm9kZlI0VGN0blBWcDlZZE9HditoZ3EvRVY1VE1ZMGVMeWN4?=
 =?utf-8?B?WlJHaUFqQkpTcS85MjV2TU9qU0pNM2RvaVZQRndmU2NWVXhLYVRiZEptcjlG?=
 =?utf-8?B?Z1pyNzQrZzF1VHBLcTZrL2UwbGVDR3dMWGZSRGRpUExQZWtNSDRId3hOUEtB?=
 =?utf-8?B?WFN0Y2podFpXcUh5cGlmQUY0cFE2YjM2VThoZUNOV1hsd05Kc05qb1g2NVhN?=
 =?utf-8?B?bzNCaWNuQ0wxU0p3RlVOOG9tZFNjdndlenR2ZURTckZUZ3Y0aXZTTGl6TUtq?=
 =?utf-8?B?S3NORUxIeCtQdi80UUJrMmNGRTFyUitPRTV3Y1g0aTFhTE9VR2dGRmc0WnE2?=
 =?utf-8?B?N08vcU91QzBWUTRQVURpM0llYk0vOWJNTE5HazFicko4dEgxNkJmc1ZOQmVy?=
 =?utf-8?B?bUxsVm1nbDdqeHk5YUNaNGZWT20vSW9SeFJIcjhqc2VvUHpuZXg3NDhMbEtX?=
 =?utf-8?B?dENzcTVsN242NGYrNE1POEh5cTk0Y3lCbWNtNFdDb2xqanFyektTbUFDRnYw?=
 =?utf-8?B?YnhicmkyWEdyRXdRL0Jqb1Rlc09HelpkUkFmOGNQRXlocmMvQ1RTNjlwRnVu?=
 =?utf-8?B?aGNkUW5IRDRDUXFWM21zdGFrTnI1TlY5eU1hRXpMTGg4UU1YbkM2N2dnTzNi?=
 =?utf-8?B?YTFnR3I1Sm1IdzN6cTVsU3R2OS9YeXB2TmdTWXRUY29BYlFTQUJmMTZRSVhI?=
 =?utf-8?B?RXppcDZtOURqYnQ3QzhCc2V2TW45dTNBdG5mbW14alFKak4venFQM2x6TWF2?=
 =?utf-8?B?SzFXbkN6K01US2Yvd1JOYlAxc3RmSFZvYldFUXhMMThEdEh3Q1NZWE4xUlh0?=
 =?utf-8?B?dHpJRy9CSXh4R085d25leXZlbCtTbWVMNUpMQmxZbUt5N2p3UHQ3S3JJazlM?=
 =?utf-8?B?NHBwWHJMK2VJRjlXMEZiVFhRMnFDa0tYaDEzQnVtMjMrd0dRRTdKTTlIYjJD?=
 =?utf-8?B?amFSRkxCYmpsN1hYMStJdjBOenVTTWhkYnVTMTZxSVhFNkxpQ0swN3RERTFX?=
 =?utf-8?B?RU1uak1oYTRRN05IQ3V4Z0lJS1hCL3RRcy8vSHlKamRLVHVDaE5iZ2xQWVNu?=
 =?utf-8?B?cTVwSkNtNFIxNVg3cG10ZDNtT005Y3pJUGc5eFI5QlY5RlU4eTRkVUluem9p?=
 =?utf-8?B?SDU1OGpaaTlxcVdZR2RET0JHVk9NSjF6cUlKL0hreURvM2VKM0JuZmM2eHVp?=
 =?utf-8?B?TzFHSFRSRjBqamdkdlJHZzN2RzRETWVaazhDaVZqb0IxVGpoZlhvS3V6d0Jz?=
 =?utf-8?B?a3pTeGJyVWRKWGhsRmJIQ09XMHhyUFJqbGw2bm1zVFZxMHM5alBhenJQMWFF?=
 =?utf-8?B?T2F3VU1TdTd6MWFrVEpUTDVGTVJFMS83TWFXSlg3dSsrRyt0SlkwQ2Zkdmpq?=
 =?utf-8?B?VEtGSjRuNG9UdU1EVGdWU0R2MDB3YkRwUitTYWxEQmFFYW5IaWV6T2pEWGZ4?=
 =?utf-8?B?Nzd6cytEU0xjc05pNmxvbTc5VG9yZUgvdDhZdklKYlU4NWdFZHlyYzhFaGRX?=
 =?utf-8?B?czBhNTJSOHRFODllRnZMR2NFOGZ2enJCaVVKTnlUZ2RuZlJQaGYxNWVPWGFE?=
 =?utf-8?B?dmZaNzVjK2NMOEEyN2MzRjNobVd1QjJUQTZERFBTQ29KOEpMblBQVlhNUGNG?=
 =?utf-8?B?ODd3UEFGb2llUDRwbjRtYUw2VzMrSWQ5SzFsUUxtTXR1c280VkdFd2owVndp?=
 =?utf-8?B?M1hNQWprNTBLRXFlZ1h3T2VMalh4dHFWRmpQbmJCS2tLdXRZelNDSy9QR0pZ?=
 =?utf-8?B?ak5pVnZSMWY5UWJLTmQrNVBZNWhKOHdTTjdjOS9WaUNMaThWU1ZxeTBjK0lS?=
 =?utf-8?Q?TF1GacsjJuQtOuKEht3o4Fs0j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112cca32-3ce6-46cb-e1fe-08dd3a329c6e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 15:45:20.6228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOlRhxbZDxS1MdVLwHZDFLuY2DO8WuxNCOfPC++0qlSJpYrpFfgIQjMxh7bISz20qpWz+U934jXkSHTJR+BGEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8561
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

On 2025-01-20 14:49, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> mark_seamless_boot_stream() can be called multiple times to run
> the more expensive checks in dc_validate_boot_timing().
> 
> Refactor the function so that if those have already passed once
> the function isn't called again.
> 
> Also add a message the first time that they have passed to let
> the user know the stream will be used for seamless boot.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/dc/core/dc_resource.c  | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index 626f75b6ad003..78bad889ba065 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -3525,16 +3525,20 @@ static int acquire_resource_from_hw_enabled_state(
>  	return -1;
>  }
>  
> -static void mark_seamless_boot_stream(
> -		const struct dc  *dc,
> -		struct dc_stream_state *stream)
> +static void mark_seamless_boot_stream(const struct dc  *dc,
> +				      struct dc_stream_state *stream)
>  {
>  	struct dc_bios *dcb = dc->ctx->dc_bios;
>  
> -	if (dc->config.allow_seamless_boot_optimization &&
> -			!dcb->funcs->is_accelerated_mode(dcb)) {
> -		if (dc_validate_boot_timing(dc, stream->sink, &stream->timing))
> -			stream->apply_seamless_boot_optimization = true;
> +	if (stream->apply_seamless_boot_optimization)
> +		return;
> +	if (!dc->config.allow_seamless_boot_optimization)
> +		return;
> +	if (dcb->funcs->is_accelerated_mode(dcb))
> +		return;
> +	if (dc_validate_boot_timing(dc, stream->sink, &stream->timing)) {
> +		stream->apply_seamless_boot_optimization = true;
> +		DC_LOG_INFO("Marked stream for seamless boot optimization\n");
>  	}
>  }
>  

