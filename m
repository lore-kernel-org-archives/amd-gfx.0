Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB65C83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 20:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42FF610E0ED;
	Fri, 11 Jul 2025 20:50:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1fP0B5xI";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADD6E10E0ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 20:50:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXj4lTeB4QWvN/zNDyn+JhJa2nrqLFiweSlU5nxDAXXkOzTnXqtqZhGmWmqhW6S42KB6p7Hlsw9gxR/cWOSsBUAXxf5wbg8N+t8o9AqP06jpJCoEXjDAKzHpB4jUtv6fAGAsuAsvHEjnI507rNOqB2dOAuBBVKjhftYrLKbC+o4hdbMTp3iKWQYZ+TVpBM3djJVwAck2iLCHQnFlTBFz3gFsF4oT6HRHYqXc7Cr9jg60Mu1ArOU6xOkO7UbM3YkiabMs9EOw4OhuNiTAx3YxyDYnGqcE0brjFTHEsmueIKQODx9DZ1WByoAhMAAvlxSyi3EVV285ihBW0jkqV9XmIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoT6t8J/hKso+x2c7lx6O9Z2KABcrnXvdT/dt2YcOBk=;
 b=frxvCeSobUgzIu/NGY2MPbpckrhf6rVaHaxNHsfqsS8lrmdj1ubXKLThzBGRcMvDDF6Tbz7/1NK5C8mMmozj2eNV3MXkJ95DFPFSh+rQowdUw2J45FL8j8KZ6ZBzO+4IQCN0hsT9D3fF6Vz3755ixHsCiGMSQmBWB89F45Rq+pwXe+Jqg+UfRILDnf8mlkufBHICaEPD3sNYfLojU2xB0Manr2hOhw/4A0RAh4xqTXnXIgktv3E86mmRZcwf7cM3t1qtcAjXhbUfsgiPid6KvmBx13mWgna4nmvAvTKE69VQvAnq64jpKg/PAdyD7M68/xq1aOZYtpoeRoOVmLvQkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoT6t8J/hKso+x2c7lx6O9Z2KABcrnXvdT/dt2YcOBk=;
 b=1fP0B5xIQua2n6VYT6X1x4GxucJTBm/CQkzf+Ouvhqz/BXhIte4aNjfIJnjxEAnAanEsmoMj0NqkIdx04kcSCjgNkx4DNL9sR4jiCNZFG6PU1JqgUhWMmVR354M0OtwR2RVBZw1FxQNooqTWmPlhRGCCNwwPZUwTkZOY2gFU6jg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 20:50:14 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%3]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 20:50:14 +0000
Message-ID: <9e7df914-a9a4-4496-8d2f-a562cdfaa9e9@amd.com>
Date: Fri, 11 Jul 2025 15:50:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/18] drm/amd/display: limit clear_update_flags to dcn32
 and above
To: IVAN.LIPSKI@amd.com, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>,
 Charlene Liu <Charlene.Liu@amd.com>, Syed Hassan <syed.hassan@amd.com>
References: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
 <20250710212941.630259-7-IVAN.LIPSKI@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250710212941.630259-7-IVAN.LIPSKI@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0547.namprd03.prod.outlook.com
 (2603:10b6:408:138::12) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: e58d35ab-df69-4eda-7c61-08ddc0bc8937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azRaZE1RYmd3aGkyYWhSTW0yTG9BQXI0TjRVRDdBdk9CakZabTRhUFEwM3ZM?=
 =?utf-8?B?dFh4SGJ0eGoxSjQxUHk5VzFMcGZLZDZIWjdWYytTTzF1UGVuV2NVYUxUQ3h1?=
 =?utf-8?B?aldLMW9TcUZlT2ZmVVNzeHlJU2o5c0N5b1lLY2V3MExVaUpYWXdHVCtQNkZ6?=
 =?utf-8?B?V3NGQ3ZIOFk2NDh4NXRzMlhFeWZhVG9QdHMyK1FUeEswclhuc2x6eW5mMHRx?=
 =?utf-8?B?UGw1Yy9SUlFKMEJwQlZSd2JKd0dxYm1ESjk2U1RvN0tRc3pmRlhmWVU1aXhy?=
 =?utf-8?B?MWZuMFhDb2oycGkyZkJjYTJHbGVxSy9HTHMvUE5pL1JnRXYxUFUvbWVOYVM3?=
 =?utf-8?B?SXJIdEU0MmFvM29pSWhwZTZwMHplZDU0MjVtNGt6ZFFxOStLeHR4Y0k5dUJw?=
 =?utf-8?B?b2d5TGpxR2xDS0JFSFlGTkRYeHorSEQ5d3JWS0QxdGRrUWtWbEtHcFI5YlRB?=
 =?utf-8?B?eG9veVpmRjVzYllmRUcwb0VYMW5IWHQ1T2ZHNmlrNVA0TUhib0lxazdDVVlU?=
 =?utf-8?B?dEgyUHFSTzA5aHNWc0RHUi9sb2JtdG9vQzg2aDM4UHQxalQyc2RpVUQycmtX?=
 =?utf-8?B?MUlvMjI5dS9jYUhIbWh3V3hGZ2g4RjNMb1JkOEViK0hTY0w0czdwUWZoQVlP?=
 =?utf-8?B?aTNtOGhycCtsSERBSjRwUkFHSW9mcDBtK1FGd3d1SmtEcEhnUHZobVJPRitQ?=
 =?utf-8?B?ZUxUT2dIS0M4M0tiRUI3cGtJbWd3bG9nN0Q1NXVKU3BrbG8wa3U2MUJEOVZo?=
 =?utf-8?B?b3BDa2h5bnBralMxMmhIQW1VelZzN0VtSlpNL2JLY1BLSDJxYXgyaFByU1JG?=
 =?utf-8?B?MjJwSFVZeGVRRURqcCtuUUFJR2RMa0tjd3VkZHhCUEVwZXpwNmJEdkNRM3Z0?=
 =?utf-8?B?SDBXMm9TUzNHZmJab250d1pMQnpTRXAxdUJuRFY5S0lTZGNFYVY3SnZ2amFH?=
 =?utf-8?B?TU1wYS9rZmoyRzg1ZHIwL1ZBdytjOXZZaStLVmtJUmtFMnQwWm1ueWFqYmZ0?=
 =?utf-8?B?WVRyS1UyODBZYTVrQVhmbHgzcnhBU1RseVY1Z0hHWXF1YU54ZzAwT0VsWUxB?=
 =?utf-8?B?WUUxdmk1eDRwenBueElkakFka0FWZHZxMnhEdk52RkFicE1pL21SUHZKSklz?=
 =?utf-8?B?YkZZME82OS9RZndEenk4eTA0bnl3dFo3ZzY0WE9ENHNlZHZxYk51RG5NZVZz?=
 =?utf-8?B?bllQL3F1enlOZzl4M2h5a2hTbzR6YlpjMW5GYlRQeUNLTTJrakFGMWhaV0JG?=
 =?utf-8?B?U1ZJOGNxeDRaUzFCb3FWRzhyZFcwQ0xVNENlUDlLYkNHQ0I1b1kyNzZ2bCtq?=
 =?utf-8?B?b3lGZmxWY1h2c3oxcVducHY0bEo2QU1xdFJCV1NmQVFKc3VWV3c4ZGlwMFNr?=
 =?utf-8?B?SWJ4ZHpjWDR1T2N1cWw2MW1QR3N6U3ZrZW1maEFyZHlaYi9HQXZ2L0pqVVdl?=
 =?utf-8?B?WGNYei83R0QxU1RVOW0yWnp1a29oY2wrYk1oOHVHYXBRTXg3K1dhRGgyN0I0?=
 =?utf-8?B?Q21YZmdpa2dqN0JRamNoRVFqeVVGamJieXprY2RrUFBNL2x5QXdDeDFkcVVn?=
 =?utf-8?B?clVoZnVQT2hEeXplTXMxM0JuaDNKb3FqbG9CRUVldFE4aWp1c2h0dkRRR3Yr?=
 =?utf-8?B?ZnVSNEhYV0V1bEZiY09iZ2xMNENPbmR5YnNhc1R0ZEJvMis5Q3dnN2s0TS9w?=
 =?utf-8?B?RzAzdXVYaUdNSHdIUXlFME1NbkluS3phUlhkS0hUZ2FUOGNRYzdhUk13ZW9M?=
 =?utf-8?B?S1c0TEwrRWoyRVV0NnFxNjl5YXFZVlkwUHNmM2hnRkU5NEZJa2lZUjYxZlBX?=
 =?utf-8?Q?74qlVEwELiABgs1/M9bw0gYWaB2O0ejDSVcqE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2FVczI2bzhPdmQzTXNsVzkzOFpsZ3E0cE44ako2OTlWdlB4T2MySXNrZ2RJ?=
 =?utf-8?B?emtnTHV6YTQrSitUaVBKb0JrVFRQVFZMc1J3ckFzTDhTbUJwdHJaZ1VIWXB6?=
 =?utf-8?B?S2RrVzNqc2cwSFVBd2hKV2FXMjh4dGVkcnRJZ1YwZ2VvbVgyQitBb2tiZGda?=
 =?utf-8?B?M2w0ejhIUDIwNkJqNGpqVHlsZXJNelVEai9iYXJkTTRHS3laN1FKMWN0U1Yz?=
 =?utf-8?B?Mm8yWkc0Ymh4M2J1alVGUmU0K3BkMHAvWWVYNlpKZ1pqTEt0Z0ZJRGE0NmJJ?=
 =?utf-8?B?bkJFTXh6c2VXN0szNFY5d0FYNEpIbUVDMHR5dzMvdUU1Y0tmUlZxeks4RHBV?=
 =?utf-8?B?WXZJVUdMd0M4UDNMSUFwUi95cVhiWUhlMlZpcDRtbjcxSVU3ejNkY0JDRFdt?=
 =?utf-8?B?MkNISWlsVUtncEY1NHNwR0g2N0tVTGJISm51WGlHVUtmejdpZ29DRm1LSzBx?=
 =?utf-8?B?bHBNeXY4TmJkYWRmTTJLTUNLSnJUNFhxd01CWExEeXVJOVR4QXhYS0ZmZDUv?=
 =?utf-8?B?UHZ4ajM1WklYdnROelRJSWgrYWg1bW9obWxxdXd1bnZPa0VXeEhCb3NyTFh1?=
 =?utf-8?B?YXhOYkJhUmZFcCtkbG1qYWRRVDIzTU9wZ1ZXREJpRG5RN0ZVd2JrN3hVcUFi?=
 =?utf-8?B?ckkyc3lBLzFpVTNLNUt2QWFFZHhVbis5MzZ4ZEZGVkdTTmRYWjFud0Qzc0JB?=
 =?utf-8?B?UThhUUZydXM2UkFNVUQyOUZudUZvR0J6bThqTVhqMEFYRUtMMkJVMnZRZVd4?=
 =?utf-8?B?VzRCTEo1MTQwamkvWERwc0JnbXdiak9uRTFlRU1ReHUzZVhBRkFzWjAzdUlC?=
 =?utf-8?B?a2NBc0tIWC9BL3o5cEVmVnhsd1VwZVBCd3V2QmlSdlJuMmhWSk52L1FZZU1T?=
 =?utf-8?B?aDVReUViM1Q4YkZSeHJoQnhYa3lDdmR3UjRLSlAzYjdRa1oxdzIrc01tVGRX?=
 =?utf-8?B?dWRsUlNkYW05Z1NSZnlEL3NqM3lNWit3MDdIU015WFhvTXFXMVEzUTFCVWdm?=
 =?utf-8?B?ZjAyR3EyL1d1QW9GU1U5eG1LcER5YTQ5TWEvK0w5dFIzMXZZSk9VdlhRWm5l?=
 =?utf-8?B?blVyVi9KTEN1UW1jQnlZQzhyaFdFMVo5Z09Qa1BqeGJmdzVjSmZUM0ROOHpw?=
 =?utf-8?B?dWpkdFlaNXRKT2I1TitrMnVXbFRGbXJOcGZsVU1SQ1d4UGFBZkl3RjB3OUtK?=
 =?utf-8?B?NWloc2xFa3NqVVAzamhWdnVyS1ZwWklpaXJFLzNmSWpZVFpsME5iUEh4RCtZ?=
 =?utf-8?B?cFhFMEVqZkFDSXRJNm1pWXZmS3B5NzZ2V0p3eXlIRHBtcktrNDBKTmduR1lz?=
 =?utf-8?B?VDE3K3I0VjlERTVoVjQ1dDBXVGMxUnRWWEF4TWlYSGlWSXRmdTZ3VUdmNHh3?=
 =?utf-8?B?RGNFcUg4cTVZM1pKSzJvVitvdVNjcWpRVFpMQWVJdUo0NGhwMTNHMFREdFRI?=
 =?utf-8?B?SE9KOTcyQ2Y3K0F2OEdLSE9CSFN5N2VQY3lEblFoQzZDdzdHV2EyNnhzVSs1?=
 =?utf-8?B?UENpTG9TaTRPVEVqMit2YmU5T09zdC9HMDlNclM0TmFLVzJlaHBqangyOWxx?=
 =?utf-8?B?UUdHK1h3emVxUVBRM1pnK1kzSXJHRVlmM2RqRTJFdjJ2WE9YbVNoVDJSaFFT?=
 =?utf-8?B?WmhDMzIrTlY3OGNmM0ZlS1FicnlQUHJUbkNHZDdSZmlMbEtMZWN3ZkFoMlJ5?=
 =?utf-8?B?eDhidVo5ZzQ2Zzk4V1BCa2RzSFZ5blhGdmZOd1JwZko0QzJiY1NsSVViWkF6?=
 =?utf-8?B?VmxxcUFMckhMV0NkVkxMckdyRFVmOVh0a0lCNThVWEZFcUErejNzYmVVdGRq?=
 =?utf-8?B?Y3AzRDZybWx3VmgrNHczdC9rOEJSRktuczI2TXZPUHlUaFJOV0ZyVGNjRDRW?=
 =?utf-8?B?NmtwQkdrNHFFbk5KNElTMEM0RzJBMncrc3N5SUxhUURTSlJ5LzBhUGkrOUN4?=
 =?utf-8?B?OUVMelBhN3VOWWkrV29rN3k4dUVHTExSUkxHVTRuU3ZHMVBTenkrbnUvV2g3?=
 =?utf-8?B?eHR6bW4rc1psb1E2Y0NvTEtMcU5Ubk5ab2NiT05yM0g5eFYwN1V5OE0rZnJ2?=
 =?utf-8?B?UE9xSElFakUxZ3B6Z0wyL2k3K1dpU21CaTFtMmpvR1pXc2JXKzhRRGU1a2pm?=
 =?utf-8?Q?V2mQem4h4W44k+ICRe++5RQqo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58d35ab-df69-4eda-7c61-08ddc0bc8937
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 20:50:14.6976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLRHA3VoWY1kBBcZwzug33ljNMAmdDjKro3Gu+nGpJdWbOzPGXZC2n/OOl687ZnUyb32088hd1rtlbh6AKUnzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276
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

On 7/10/2025 4:25 PM, IVAN.LIPSKI@amd.com wrote:
> From: Charlene Liu <Charlene.Liu@amd.com>
> 
> [why]
> dc has some code out of sync:
> dc_commit_updates_for_stream handles v1/v2/v3,
> but dc_update_planes_and_stream makes v1 asic to use v2.
> 
> as a reression fix: limit clear_update_flags to dcn32 or newer asic.

regression

> need to follow up that v1 asic using v2 issue.
> 
> Reviewed-by: Syed Hassan <syed.hassan@amd.com>
> Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
> Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>

There is a public issue on this regression, we should add the following 
tags so it closes and backports to fix it.

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4129
Fixes: 7671f62c10f2 ("drm/amd/display: Clear update flags after update 
has been applied")

Thanks!

> ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index f37ed24b2430..cee45fe7cec9 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -5443,8 +5443,7 @@ bool dc_update_planes_and_stream(struct dc *dc,
>   	else
>   		ret = update_planes_and_stream_v2(dc, srf_updates,
>   			surface_count, stream, stream_update);
> -
> -	if (ret)
> +	if (ret && dc->ctx->dce_version >= DCN_VERSION_3_2)
>   		clear_update_flags(srf_updates, surface_count, stream);
>   
>   	return ret;
> @@ -5475,7 +5474,7 @@ void dc_commit_updates_for_stream(struct dc *dc,
>   		ret = update_planes_and_stream_v1(dc, srf_updates, surface_count, stream,
>   				stream_update, state);
>   
> -	if (ret)
> +	if (ret && dc->ctx->dce_version >= DCN_VERSION_3_2)
>   		clear_update_flags(srf_updates, surface_count, stream);
>   }
>   

