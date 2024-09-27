Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC9ECEBF76
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 03:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B810110E1CE;
	Fri, 27 Sep 2024 03:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GefZfx7v";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A009C10E1CE
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 03:57:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOkGJGfOU6aZnh9A1klZv2pFFXZ/NJnLGPfPDwpd3fdLfLXTz61VTt3mdVMQc88XOE8lk2EDIlOcpV+qzry7n1eYbcqOAqwY3vxanMnrhgOdguat5vtyRMbPVbSzDRYspI6THancn2cK+m5+acDHXIX7dTazJ8N8iEnJ9MR3rBruvOux/Sw4S/93u4AMZVK/EKb/TJaHsVF55/fVNgdN2vAOj8jEWRjKPXJ7nBgx2OW0q1HPV8hFh3ZGnkkf0fYbD5Z+2KB56eeSmULEMpKViIxTSvFa0aUScUwnMJCQuVUiogtxa3GzxG/Nl27JEzPGuiMmA3CVGVlXn5UYuDThiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qn7C4teZqi1E+1T0U07z1IfGYd7EaqHs0zxR8kS1+UY=;
 b=CPUfhZktM1i01ds9IFRSNczUUMlOO+XzTLiKL+IfyC8Kza7+rULq04fLvmZBd3H+uGhOwM1PShpNcFSo9fc6XTygqlZ7x/fzX+6SbTiGxQjp+g28+Ddy9Va0pK/DudUcLF367vw3OU2FgqNCUExshhNByhFJJwsPOqGUy2uxwW9A5cCpLsSzyQq7TA54Eq1t9FdeYucEQ38JqlqhGbvQtzyK0KULg4NGD1YWXv4RYlcDrv5xMxcGfSe1KRLr3fUVnQ9Ba2K/lV4IBMuiUZpc144EUDjeYreFsIQLTjAmX1deUsMQEUPd0TSoBKq9IwmA+IUIJx+smwmtdzvdxaUkDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qn7C4teZqi1E+1T0U07z1IfGYd7EaqHs0zxR8kS1+UY=;
 b=GefZfx7vdnT9oHqtl5cIyZTkvaHcfe6xrS/+xfn8MsdttjXtvyH7Mk6UOJZ4wdLzH1mlXIal73gtNaAaIjIcJY92EFhCqEwZtRIFUWRvuicvPj5B14g7wpY0FvN5AERtQLjnXNtusersd/GCjBUoHIUSuevHllaWr+3cxHWMlXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 03:57:09 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8c7e:a1a7:74ac:29a8%6]) with mapi id 15.20.7982.018; Fri, 27 Sep 2024
 03:57:09 +0000
Content-Type: multipart/alternative;
 boundary="------------0C2I5AM3rCAP0zSDLp8Sp6Uk"
Message-ID: <641b8541-1277-1092-25da-26d1f33561c2@amd.com>
Date: Fri, 27 Sep 2024 11:56:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6/7] drm/amdgpu: Check gmc requirement for reset on init
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>,
 "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
References: <20240924055652.2678433-1-lijo.lazar@amd.com>
 <20240924055652.2678433-7-lijo.lazar@amd.com>
 <CH2PR12MB4152398EF93FAEDC322ADBEEFE6A2@CH2PR12MB4152.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Xu, Feifei" <feifxu@amd.com>
In-Reply-To: <CH2PR12MB4152398EF93FAEDC322ADBEEFE6A2@CH2PR12MB4152.namprd12.prod.outlook.com>
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To CH2PR12MB4152.namprd12.prod.outlook.com
 (2603:10b6:610:a7::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4152:EE_|DM4PR12MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 888874a3-fdc9-4e87-a24c-08dcdea875be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0R4YlhrVnJ3WG1xMUcxTXpVSHo4cE5HZEFxb250dXRFN012U0RlazhDazZ6?=
 =?utf-8?B?VGdXZnQrT1lDTEJ3WnkzdzNWc0MzMW1FWDRYSEYzSmxtUXZzMk1FcUYybHdv?=
 =?utf-8?B?QTFiYzM5dnE5azU3bE1HZVlVVzNnNGFYN0p1YjIrNXVlV3RGa2o1cjk4aDVO?=
 =?utf-8?B?MlkwSFpYUHlTYWxxeitFRlpzNGg0KzJSTzA5OWo3cUxEY2JFUEExbXdwM05L?=
 =?utf-8?B?WDZzS1k4eXR5YXBEckxYTlltblRwVEJqLzZBTE85c1ptOEVpVVF0d2RKK2h3?=
 =?utf-8?B?LzB5TFB0dituRTNkVUo2SEpLZEN2Y3pIZTA4SkhWeVY1dk1hTDNlZkZ0Mmcw?=
 =?utf-8?B?UDM5blIrNHFITUdIVlczSlM4bXlIY3dOYXVrVHZhYld6Q1Vrdm9GWVVPUDJI?=
 =?utf-8?B?T21VV1p0MTYyT2l3RWROR004S1hyR1RGNTFEL3dyK2lBb0dsbWczczRWVGtr?=
 =?utf-8?B?bTB6WThhZE5MMDAyS3ZTcWJ3L09hT3YzdnZNSHFreUZ1YnRnS1Rod21neklm?=
 =?utf-8?B?VjliN1Y1ZmJ6eU9jSS90R1E1aW1hQWsxL1UxU3BGVi91OTFHTk51MWdXK1JU?=
 =?utf-8?B?ZFl0V09WTGlOMnMrempBdldTUCtrWjJmaHhQZ0tHRmk2MlZiK05LVnJmYXA4?=
 =?utf-8?B?M2VpU1dVc2FrT1VlY3pSL2pFdll0OHJMZXBhRkhBMEhERlRNNy9ldW9nWUlo?=
 =?utf-8?B?aGNOSitZSUFtTVpqL3NmRVdSK2Q1ZnBWNkNvaUdvZEtTVnNoNjQ1TFk3N1dS?=
 =?utf-8?B?YnNjRjhTWGI2QmZoUGNxamIvQTBmVVR3Lys4b0d3MWVuNkgxNHZRTGZqNzY4?=
 =?utf-8?B?WGFLRmwxNERuVVVta2N4SitOaWVjeEJCckxGaHM5dG0rMjczb2l4bWwzb0Zn?=
 =?utf-8?B?Rnh6Uk0vVzlnUVh6YmdFQldoc21jc3ZxTi92eG5MSjFHeEhBZzVkdlZNSGY3?=
 =?utf-8?B?SU9DWTVKU2dsRUczNzhtcG83S2pTaXpXdzhhbnYrZEVOT28vbW1ENXRYOHhC?=
 =?utf-8?B?WTNyVTU4S0s3M2dTQjdOaEU5cDdKZDU0L09TNXYrQVU4R3lESkVNZkxMaGZR?=
 =?utf-8?B?WG9zM0IzOVlwaDd4Y3hWMDQ2NVpxWUU0RncxYlVoU3diYlRRUExWZWZIR2xF?=
 =?utf-8?B?RERkcWtWODRsS3VXc2l2Y0ZORTFhQ2ZubTl0c0NSSkp2NFNBdXhHZmxHdlpk?=
 =?utf-8?B?NkhiTmxjcEgwVGZ6U0ZMeW5UZk8rbEVBVkFZQ3IxTWVoenRlMWxBdHdwc29G?=
 =?utf-8?B?ZjRDZDVrRXQrV005TnRWS0Q1N2NLQUxjNk00VW44Mjc5VXlSN0Z5cXF3R0lW?=
 =?utf-8?B?RUhPak1WOEthM2xGc251andBUk5RY2xtN3hYWnpqdUJnVVJJbnM2MTB0SHZI?=
 =?utf-8?B?OXNtQ010RU5nNDJBb045T0lPN05OQVVGUmZOZEJDbFNkRlpQRmU4Yk1WN3Bm?=
 =?utf-8?B?M1dSMWt2LzlLcUdueDVzcW9oSnhzNmNvWm1DR0E0SUxXM0dzTDQ3ZlQ2NlFx?=
 =?utf-8?B?ZWlrQlUvV2VxbFZRR01seG9TbmNOVVIwSHhTM01RN0ZUSDcyaUhrRU1RMXgv?=
 =?utf-8?B?ZnNRQUZNSzhvSWFpOGtiTW00QmllTFYvb0gyN0dTbjUxZWlvb05tandCK3VU?=
 =?utf-8?B?dElNdjlIWk5yQnFLcTNlQ0M5RXl4cTIzMVZaMFM0d0ZBNW54NnhhcXliVkhD?=
 =?utf-8?B?WEV4ZTFUUGFraVc0NjExWHhzcWJ0bVVpTDg5SFN6bGg2N3ZvMmhzdFJrYk1D?=
 =?utf-8?B?aFBSZEdaNWpLZGhObVEwRjM0LzdJanA1SDk2bnVtbFEyc2pGb3N6enhsZUNR?=
 =?utf-8?B?ckhvQkJYUnR2RDI0QTMyZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlJpbEo0STV5WUlkeDRtY0NQZDYvUHhKTUFVQldRU0J2QnpqUkdCRlB0RkRP?=
 =?utf-8?B?dGpRVzRWU3JpK2pzb0RSNUx4eThpck1QQzFNN2ZwcGM1UVNvOTRrN29VbXo0?=
 =?utf-8?B?ME1zK05NRTFBS0M0cyt6MDFwdk80UjRUa2F4UFNCa2FpMUMzRUFWTmtyL3ZY?=
 =?utf-8?B?aXc2SWhXZHdQNGR0aklLYmh0cGZkQTAyMUs5Q0o1MEVTODdWbGdQS1VQWno4?=
 =?utf-8?B?YVI5TkV0SGk5b2U0V0dMM2g4VGdSNjhxa0dVd0MxK2pqKzhPUllKaXp2VmF6?=
 =?utf-8?B?ald4bURjRVpCeTdMY1ZSMUFOREVncFpmd2VxMmNpS2pFK25BQWZPd00zSERa?=
 =?utf-8?B?eldHVGlpaXdERVlLaXZVWmdtLy9SZVNJYnJsM2MxU0Q1SEgyMUtkZUpHMTg0?=
 =?utf-8?B?cmVTdm9mMXBuYnFlbXRiUHJyTURUeTZSTTh5aGJRVVBqd3YvcTUzMFBOTzND?=
 =?utf-8?B?WC9UMmtpM2ZWOVNXa1ZPMXVIaTA3ZlVTZlN5UkhnKytNS0N6K043dkM0aDQ0?=
 =?utf-8?B?SDg0YytKek53K3RwMlNJNkNDY1pTK0tzQyt4Qk40eS9qaUJnYjJzYko3anhG?=
 =?utf-8?B?bndPYkQ0REhOa1QvSythVlF0dVpyd3RQUkl0bW8yV3ZhVUFvZ2xLUXJ0cVZy?=
 =?utf-8?B?aDJBZCtEMVlZTzNHcEhVM2J6aVE1WHdZTHBCempBejlVYmg2c3g1THRjWHNh?=
 =?utf-8?B?KzJPOXY2WlBXM1gwR0JBSk5qb0hFaWFGYStiUnBKdEdrNkdKREFpNTNiNXBq?=
 =?utf-8?B?bkVkc0JxZGNvVmNWVWlKcDhBbUtJVU1ROVdYQ1p6ZDlGVEYzQnRmMG9tMkF6?=
 =?utf-8?B?N0l3VE9JOHIwYlVYNXhrVGFtcHhNWTJpbDRNWmJYSTBRMHZMaUpHd2lVc3F1?=
 =?utf-8?B?TituVHdmL0FzUTNPeDV2Y3hCbWkwelZORUlJTFBmT1lJRjBoNEFlaVBHMTll?=
 =?utf-8?B?VnQ0ZTBKNkt6Y2pPVzI0cGhOTXphdTM4UzZ3QjhVUC9OTkwrN1pPZUJGZVBN?=
 =?utf-8?B?YWh0S1FETHFNeStGUGNqUmpMemxRc0Y4RktoeUhPUlVOMmtFR29hUGN0THh2?=
 =?utf-8?B?SkN4aGp4a0hmdmlLZy8vUDRaM3hwb2hlYXFmR203MERBY0M5K1pqcmRkVlRR?=
 =?utf-8?B?Tm8vTzJOaFRLdTJwbDNRTy9Ka1dUQ1NwNEZtcklYTUNkaDdXTWh6T2dUcDBw?=
 =?utf-8?B?R3ZaL3psWFhCZmZLVDFaRjhiQjMvanNIdW9aZDJDRmFHMlliaTl6aU0vdkdK?=
 =?utf-8?B?a21RUzZ4bzFGOVFDMFpTMytyZXZ3SHBrMlhVZmFWTDV3NmdKY2xKZXYrc3hK?=
 =?utf-8?B?dkZla3VLTzlvWWFwZmlpOGFOdWY0d25hbGNIR1BMa0NhME5RRHUweXlPZGFK?=
 =?utf-8?B?dFFFbzlieVl4bWJRMFRXb255cHhLamNXdmNjVFJvUVpRL05PY2FvS3VpdHp6?=
 =?utf-8?B?WW1NSTdZb1BLbmdiSkhqV3FML2ZGYk9JTzczL20yM1Rna2pBdFZYc0JnelNk?=
 =?utf-8?B?ampRSHNwaXpQQUJvSmZKcisxTk52RVpVdXMwY0cyTlltVUhGanpuODN5ZnRa?=
 =?utf-8?B?MFZKSXpVZG1EMy82REVIRjNGNUxERnVFaXdSK1F5RkNCS3RlZFhBVUlGMlZo?=
 =?utf-8?B?MEd1R1drN2haZUN4UE1JZFlyNERta2Z1SmRnaHY4S3B1NUlWejFNYmx5dlF5?=
 =?utf-8?B?RjNsQ3hZL0Z4LzBDZ3JXUVFSZFR2Nmx3c1A4bktLdm5CYjE4b1M4V0xDZlEy?=
 =?utf-8?B?N29rM25EYXo0ZjFCbExUT04zcC8vNTJPTTBKaTNidEdQUitxN3l0RlArdzdP?=
 =?utf-8?B?ZFFhaDRmZG1GZklOSDhTWFRmQ2UzS1hlT005Z01CeGpmTHdnWFdlOE5tdjV4?=
 =?utf-8?B?RU1JVlpXSTZQbGJ4cWFLYzgzazQ4SVV6ZXlNMWJTQVZhdVJjZmFIbG0weS9T?=
 =?utf-8?B?cnhGT3QvZ1pPOHBTOU5JV25vUVFSNWtpNU9sOCtEZHNlbnFnRVNXQ2QwMkd4?=
 =?utf-8?B?WDVxUGJWL0VUVVVpdDZreHJpSDFrVFhySE5OV2NRNG5UcHg3bjNuTGRLTXRl?=
 =?utf-8?B?TlJwSWFTV2tpcEE1NFpaaW94MkhGb1J0d0c5QXg5dzZHeXhtWlRRUnRFUWlo?=
 =?utf-8?Q?T4O2/v/9ZW5wS2g44/F9s4ZiW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 888874a3-fdc9-4e87-a24c-08dcdea875be
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 03:57:09.5783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J08/dQeTDxT2QyJhZ+6hCPsJd+7tyOFCzUwfIdWdLW41zTOXskwZzgqrl5/rn7Jg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376
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

--------------0C2I5AM3rCAP0zSDLp8Sp6Uk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

 >>I guess you are referring to the below corner case

>>  1) Place NPS request

>>  2) Unload Driver

>>  3) Reinstall driver with a different TOS (possible but quite unlikely)

>> 4) Driver reload

>> 5) Driver checks TOS version first and goes for a reset

>> 6) reset_flag of GMC is not set, hence it doesn't refresh the NPS range.

 >>I think changing the order in soc15_need_reset_on_init() to check for 
NPS request before TOS version check will solve this.

Yes, I was thinking of  reset_flag and tOS reloading 
(adev->init_lvl->level set to AMDGPU_INIT_LEVEL_MINIMAL_XGMI) changing 
at the same time. And NPS refresh will be ignored. Though might be 
likely in debugging or regression isolation cases which changing driver 
packaged with different TOS.  And yes making NPS refresh checking before 
TOS version checking will solve this.

And if we do not return ahead when checking NPS request before tOS 
version change in soc15_need_reset_on_init(), we can drop 
(adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) check in below 
refresh checking:

+     refresh = (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
+               (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);

refresh = (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);

Thanks
Feifei

On 9/26/2024 5:01 PM, Xu, Feifei wrote:
>>> +     refresh = (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
>>> +               (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
> Is there a corner case that reloading with a different version tos and refreshing nps change co-exist?
>
> Thanks,
> Feifei
>
> -----Original Message-----
> From: amd-gfx<amd-gfx-bounces@lists.freedesktop.org>  On Behalf Of Lijo Lazar
> Sent: Tuesday, September 24, 2024 1:57 PM
> To:amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking<Hawking.Zhang@amd.com>; Deucher, Alexander<Alexander.Deucher@amd.com>; Koenig, Christian<Christian.Koenig@amd.com>; Bhardwaj, Rajneesh<Rajneesh.Bhardwaj@amd.com>; Errabolu, Ramesh<Ramesh.Errabolu@amd.com>
> Subject: [PATCH 6/7] drm/amdgpu: Check gmc requirement for reset on init
>
> Add a callback to check if there is any condition detected by GMC block for reset on init. One case is if a pending NPS change request is detected. If reset is done because of NPS switch, refresh NPS info from discovery table.
>
> Signed-off-by: Lijo Lazar<lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 13 ++++++++++++-  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  5 +++++
>   drivers/gpu/drm/amd/amdgpu/soc15.c      |  2 ++
>   3 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 21f1e65c9dc9..011fe3a847d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1261,12 +1261,15 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
>          struct amdgpu_gmc_memrange *ranges;
>          int range_cnt, ret, i, j;
>          uint32_t nps_type;
> +       bool refresh;
>
>          if (!mem_ranges)
>                  return -EINVAL;
>
> +       refresh = (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &&
> +                 (adev->gmc.reset_flags & AMDGPU_GMC_INIT_RESET_NPS);
>          ret = amdgpu_discovery_get_nps_info(adev, &nps_type, &ranges,
> -                                           &range_cnt, false);
> +                                           &range_cnt, refresh);
>
>          if (ret)
>                  return ret;
> @@ -1392,3 +1395,11 @@ void amdgpu_gmc_prepare_nps_mode_change(struct amdgpu_device *adev)
>                          adev->dev,
>                          "NPS mode change request done, reload driver to complete the change\n");  }
> +
> +bool amdgpu_gmc_need_reset_on_init(struct amdgpu_device *adev) {
> +       if (adev->gmc.gmc_funcs->need_reset_on_init)
> +               return adev->gmc.gmc_funcs->need_reset_on_init(adev);
> +
> +       return false;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index b13d6adb5efd..d4cd247fe574 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -78,6 +78,8 @@ enum amdgpu_memory_partition {
>           BIT(AMDGPU_NPS3_PARTITION_MODE) | BIT(AMDGPU_NPS4_PARTITION_MODE) | \
>           BIT(AMDGPU_NPS6_PARTITION_MODE) | BIT(AMDGPU_NPS8_PARTITION_MODE))
>
> +#define AMDGPU_GMC_INIT_RESET_NPS  BIT(0)
> +
>   /*
>    * GMC page fault information
>    */
> @@ -169,6 +171,7 @@ struct amdgpu_gmc_funcs {
>          /* Request NPS mode */
>          int (*request_mem_partition_mode)(struct amdgpu_device *adev,
>                                            int nps_mode);
> +       bool (*need_reset_on_init)(struct amdgpu_device *adev);
>   };
>
>   struct amdgpu_xgmi_ras {
> @@ -314,6 +317,7 @@ struct amdgpu_gmc {
>          const struct amdgpu_gmc_funcs   *gmc_funcs;
>          enum amdgpu_memory_partition    requested_nps_mode;
>          uint32_t supported_nps_modes;
> +       uint32_t reset_flags;
>
>          struct amdgpu_xgmi xgmi;
>          struct amdgpu_irq_src   ecc_irq;
> @@ -468,5 +472,6 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,  int amdgpu_gmc_request_memory_partition(struct amdgpu_device *adev,
>                                          int nps_mode);
>   void amdgpu_gmc_prepare_nps_mode_change(struct amdgpu_device *adev);
> +bool amdgpu_gmc_need_reset_on_init(struct amdgpu_device *adev);
>
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 619933f252aa..97ca4931a7ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -833,6 +833,8 @@ static bool soc15_need_reset_on_init(struct amdgpu_device *adev)
>
>          if (amdgpu_psp_tos_reload_needed(adev))
>                  return true;
> +       if (amdgpu_gmc_need_reset_on_init(adev))
> +               return true;
>          /* Just return false for soc15 GPUs.  Reset does not seem to
>           * be necessary.
>           */
> --
> 2.25.1
>
--------------0C2I5AM3rCAP0zSDLp8Sp6Uk
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html data-lt-installed="true"><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body style="padding-bottom: 1px;">
    <p><!--[if gte mso 9]><xml>
 <o:OfficeDocumentSettings>
  <o:AllowPNG/>
 </o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Normal</w:View>
  <w:Zoom>0</w:Zoom>
  <w:TrackMoves/>
  <w:TrackFormatting/>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF/>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>ZH-CN</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
   <w:SplitPgBreakAndParaMark/>
   <w:EnableOpenTypeKerning/>
   <w:DontFlipMirrorIndents/>
   <w:OverrideTableStyleHps/>
   <w:UseFELayout/>
  </w:Compatibility>
  <w:DoNotOptimizeForBrowser/>
  <m:mathPr>
   <m:mathFont m:val="Cambria Math"/>
   <m:brkBin m:val="before"/>
   <m:brkBinSub m:val="&#45;-"/>
   <m:smallFrac m:val="off"/>
   <m:dispDef/>
   <m:lMargin m:val="0"/>
   <m:rMargin m:val="0"/>
   <m:defJc m:val="centerGroup"/>
   <m:wrapIndent m:val="1440"/>
   <m:intLim m:val="subSup"/>
   <m:naryLim m:val="undOvr"/>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" DefUnhideWhenUsed="false"
  DefSemiHidden="false" DefQFormat="false" DefPriority="99"
  LatentStyleCount="376">
  <w:LsdException Locked="false" Priority="0" QFormat="true" Name="Normal"/>
  <w:LsdException Locked="false" Priority="9" QFormat="true" Name="heading 1"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 2"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 3"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 4"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 5"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 6"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 7"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 8"/>
  <w:LsdException Locked="false" Priority="9" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="heading 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index 9"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 1"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 2"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 3"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 4"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 5"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 6"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 7"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 8"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" Name="toc 9"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="header"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footer"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="index heading"/>
  <w:LsdException Locked="false" Priority="35" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="caption"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of figures"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="envelope return"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="footnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="line number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="page number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote reference"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="endnote text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="table of authorities"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="macro"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="toa heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Bullet 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Number 5"/>
  <w:LsdException Locked="false" Priority="10" QFormat="true" Name="Title"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Closing"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Signature"/>
  <w:LsdException Locked="false" Priority="1" SemiHidden="true"
   UnhideWhenUsed="true" Name="Default Paragraph Font"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="List Continue 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Message Header"/>
  <w:LsdException Locked="false" Priority="11" QFormat="true" Name="Subtitle"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Salutation"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Date"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text First Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Note Heading"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Body Text Indent 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Block Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="FollowedHyperlink"/>
  <w:LsdException Locked="false" Priority="22" QFormat="true" Name="Strong"/>
  <w:LsdException Locked="false" Priority="20" QFormat="true" Name="Emphasis"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Document Map"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Plain Text"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="E-mail Signature"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Top of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Bottom of Form"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal (Web)"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Acronym"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Address"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Cite"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Code"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Definition"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Keyboard"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Preformatted"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Sample"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Typewriter"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="HTML Variable"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Normal Table"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="annotation subject"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="No List"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Outline List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Simple 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Classic 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Colorful 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Columns 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Grid 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 4"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 5"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 7"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table List 8"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table 3D effects 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Contemporary"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Elegant"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Professional"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Subtle 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 1"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 2"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Web 3"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Balloon Text"/>
  <w:LsdException Locked="false" Priority="39" Name="Table Grid"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Table Theme"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Placeholder Text"/>
  <w:LsdException Locked="false" Priority="1" QFormat="true" Name="No Spacing"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 1"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 1"/>
  <w:LsdException Locked="false" SemiHidden="true" Name="Revision"/>
  <w:LsdException Locked="false" Priority="34" QFormat="true"
   Name="List Paragraph"/>
  <w:LsdException Locked="false" Priority="29" QFormat="true" Name="Quote"/>
  <w:LsdException Locked="false" Priority="30" QFormat="true"
   Name="Intense Quote"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 1"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 1"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 1"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 1"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 1"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 2"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 2"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 2"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 2"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 2"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 2"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 3"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 3"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 3"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 3"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 3"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 3"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 4"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 4"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 4"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 4"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 4"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 4"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 5"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 5"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 5"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 5"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 5"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 5"/>
  <w:LsdException Locked="false" Priority="60" Name="Light Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="61" Name="Light List Accent 6"/>
  <w:LsdException Locked="false" Priority="62" Name="Light Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="63" Name="Medium Shading 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="64" Name="Medium Shading 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="65" Name="Medium List 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="66" Name="Medium List 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="67" Name="Medium Grid 1 Accent 6"/>
  <w:LsdException Locked="false" Priority="68" Name="Medium Grid 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="69" Name="Medium Grid 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="70" Name="Dark List Accent 6"/>
  <w:LsdException Locked="false" Priority="71" Name="Colorful Shading Accent 6"/>
  <w:LsdException Locked="false" Priority="72" Name="Colorful List Accent 6"/>
  <w:LsdException Locked="false" Priority="73" Name="Colorful Grid Accent 6"/>
  <w:LsdException Locked="false" Priority="19" QFormat="true"
   Name="Subtle Emphasis"/>
  <w:LsdException Locked="false" Priority="21" QFormat="true"
   Name="Intense Emphasis"/>
  <w:LsdException Locked="false" Priority="31" QFormat="true"
   Name="Subtle Reference"/>
  <w:LsdException Locked="false" Priority="32" QFormat="true"
   Name="Intense Reference"/>
  <w:LsdException Locked="false" Priority="33" QFormat="true" Name="Book Title"/>
  <w:LsdException Locked="false" Priority="37" SemiHidden="true"
   UnhideWhenUsed="true" Name="Bibliography"/>
  <w:LsdException Locked="false" Priority="39" SemiHidden="true"
   UnhideWhenUsed="true" QFormat="true" Name="TOC Heading"/>
  <w:LsdException Locked="false" Priority="41" Name="Plain Table 1"/>
  <w:LsdException Locked="false" Priority="42" Name="Plain Table 2"/>
  <w:LsdException Locked="false" Priority="43" Name="Plain Table 3"/>
  <w:LsdException Locked="false" Priority="44" Name="Plain Table 4"/>
  <w:LsdException Locked="false" Priority="45" Name="Plain Table 5"/>
  <w:LsdException Locked="false" Priority="40" Name="Grid Table Light"/>
  <w:LsdException Locked="false" Priority="46" Name="Grid Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="Grid Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="Grid Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="Grid Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="Grid Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="Grid Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="Grid Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="Grid Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="Grid Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="Grid Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="46" Name="List Table 1 Light"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark"/>
  <w:LsdException Locked="false" Priority="51" Name="List Table 6 Colorful"/>
  <w:LsdException Locked="false" Priority="52" Name="List Table 7 Colorful"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 1"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 1"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 1"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 1"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 1"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 1"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 2"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 2"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 2"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 2"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 2"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 2"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 3"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 3"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 3"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 3"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 3"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 3"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 4"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 4"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 4"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 4"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 4"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 4"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 5"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 5"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 5"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 5"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 5"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 5"/>
  <w:LsdException Locked="false" Priority="46"
   Name="List Table 1 Light Accent 6"/>
  <w:LsdException Locked="false" Priority="47" Name="List Table 2 Accent 6"/>
  <w:LsdException Locked="false" Priority="48" Name="List Table 3 Accent 6"/>
  <w:LsdException Locked="false" Priority="49" Name="List Table 4 Accent 6"/>
  <w:LsdException Locked="false" Priority="50" Name="List Table 5 Dark Accent 6"/>
  <w:LsdException Locked="false" Priority="51"
   Name="List Table 6 Colorful Accent 6"/>
  <w:LsdException Locked="false" Priority="52"
   Name="List Table 7 Colorful Accent 6"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Hyperlink"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Hashtag"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Unresolved Mention"/>
  <w:LsdException Locked="false" SemiHidden="true" UnhideWhenUsed="true"
   Name="Smart Link"/>
 </w:LatentStyles>
</xml><![endif]--><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ascii-font-family:Aptos;
	mso-ascii-theme-font:minor-latin;
	mso-hansi-font-family:Aptos;
	mso-hansi-theme-font:minor-latin;
	mso-font-kerning:1.0pt;
	mso-ligatures:standardcontextual;}
</style>
<![endif]-->
      <p class="MsoPlainText">&gt;&gt;I guess you are referring to the
        below corner case</p>
      <p class="MsoPlainText"><span style="mso-tab-count:1">&gt;&gt;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>1) Place
        NPS request</p>
      <p class="MsoPlainText"><span style="mso-tab-count:1">&gt;&gt;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>2)
        Unload Driver</p>
      <p class="MsoPlainText"><span style="mso-tab-count:1">&gt;&gt;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>3)
        Reinstall driver with a different TOS (possible but quite
        unlikely)</p>
      <p class="MsoPlainText"><span style="mso-tab-count:1"><span style="mso-tab-count:1">&gt;&gt; </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>4)
        Driver reload</p>
      <p class="MsoPlainText"><span style="mso-tab-count:1"><span style="mso-tab-count:1">&gt;&gt; </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>5)
        Driver checks TOS version first and goes for a reset</p>
      <p class="MsoPlainText"><span style="mso-tab-count:1"><span style="mso-tab-count:1">&gt;&gt; </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>6)
        reset_flag of GMC is not set, hence it doesn't refresh the NPS
        range.</p>
      <p class="MsoPlainText">&nbsp;</p>
      <p class="MsoPlainText">&nbsp;</p>
      <p class="MsoPlainText">&gt;&gt;I think changing the order in
        soc15_need_reset_on_init()
        to check for NPS request before TOS version check will solve
        this.</p>
      <p class="MsoPlainText">Yes, I was thinking of&nbsp; reset_flag and tOS
        reloading (adev-&gt;init_lvl-&gt;level set to
        AMDGPU_INIT_LEVEL_MINIMAL_XGMI) changing at the same time. And
        NPS refresh will be ignored. Though might be likely in debugging
        or regression isolation cases which changing driver packaged
        with different TOS.&nbsp; And yes making NPS refresh checking before
        TOS version checking will solve this.<br>
      </p>
    </p>
    <p>And if we do not return ahead when checking NPS request before
      tOS version change in soc15_need_reset_on_init(), we can drop&nbsp;
      (adev-&gt;init_lvl-&gt;level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI)
      check in below refresh checking:<br>
    </p>
    <pre class="moz-quote-pre" wrap="">+     refresh = (adev-&gt;init_lvl-&gt;level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &amp;&amp;
+               (adev-&gt;gmc.reset_flags &amp; AMDGPU_GMC_INIT_RESET_NPS);

refresh = (adev-&gt;gmc.reset_flags &amp; AMDGPU_GMC_INIT_RESET_NPS);

Thanks
Feifei
</pre>
    <p></p>
    <div class="moz-cite-prefix">On 9/26/2024 5:01 PM, Xu, Feifei wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CH2PR12MB4152398EF93FAEDC322ADBEEFE6A2@CH2PR12MB4152.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">+     refresh = (adev-&gt;init_lvl-&gt;level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &amp;&amp;
+               (adev-&gt;gmc.reset_flags &amp; AMDGPU_GMC_INIT_RESET_NPS);
</pre>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Is there a corner case that reloading with a different version tos and refreshing nps change co-exist?

Thanks,
Feifei

-----Original Message-----
From: amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> On Behalf Of Lijo Lazar
Sent: Tuesday, September 24, 2024 1:57 PM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
Cc: Zhang, Hawking <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a>; Deucher, Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Bhardwaj, Rajneesh <a class="moz-txt-link-rfc2396E" href="mailto:Rajneesh.Bhardwaj@amd.com">&lt;Rajneesh.Bhardwaj@amd.com&gt;</a>; Errabolu, Ramesh <a class="moz-txt-link-rfc2396E" href="mailto:Ramesh.Errabolu@amd.com">&lt;Ramesh.Errabolu@amd.com&gt;</a>
Subject: [PATCH 6/7] drm/amdgpu: Check gmc requirement for reset on init

Add a callback to check if there is any condition detected by GMC block for reset on init. One case is if a pending NPS change request is detected. If reset is done because of NPS switch, refresh NPS info from discovery table.

Signed-off-by: Lijo Lazar <a class="moz-txt-link-rfc2396E" href="mailto:lijo.lazar@amd.com">&lt;lijo.lazar@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 13 ++++++++++++-  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  5 +++++
 drivers/gpu/drm/amd/amdgpu/soc15.c      |  2 ++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 21f1e65c9dc9..011fe3a847d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1261,12 +1261,15 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
        struct amdgpu_gmc_memrange *ranges;
        int range_cnt, ret, i, j;
        uint32_t nps_type;
+       bool refresh;

        if (!mem_ranges)
                return -EINVAL;

+       refresh = (adev-&gt;init_lvl-&gt;level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) &amp;&amp;
+                 (adev-&gt;gmc.reset_flags &amp; AMDGPU_GMC_INIT_RESET_NPS);
        ret = amdgpu_discovery_get_nps_info(adev, &amp;nps_type, &amp;ranges,
-                                           &amp;range_cnt, false);
+                                           &amp;range_cnt, refresh);

        if (ret)
                return ret;
@@ -1392,3 +1395,11 @@ void amdgpu_gmc_prepare_nps_mode_change(struct amdgpu_device *adev)
                        adev-&gt;dev,
                        &quot;NPS mode change request done, reload driver to complete the change\n&quot;);  }
+
+bool amdgpu_gmc_need_reset_on_init(struct amdgpu_device *adev) {
+       if (adev-&gt;gmc.gmc_funcs-&gt;need_reset_on_init)
+               return adev-&gt;gmc.gmc_funcs-&gt;need_reset_on_init(adev);
+
+       return false;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index b13d6adb5efd..d4cd247fe574 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -78,6 +78,8 @@ enum amdgpu_memory_partition {
         BIT(AMDGPU_NPS3_PARTITION_MODE) | BIT(AMDGPU_NPS4_PARTITION_MODE) | \
         BIT(AMDGPU_NPS6_PARTITION_MODE) | BIT(AMDGPU_NPS8_PARTITION_MODE))

+#define AMDGPU_GMC_INIT_RESET_NPS  BIT(0)
+
 /*
  * GMC page fault information
  */
@@ -169,6 +171,7 @@ struct amdgpu_gmc_funcs {
        /* Request NPS mode */
        int (*request_mem_partition_mode)(struct amdgpu_device *adev,
                                          int nps_mode);
+       bool (*need_reset_on_init)(struct amdgpu_device *adev);
 };

 struct amdgpu_xgmi_ras {
@@ -314,6 +317,7 @@ struct amdgpu_gmc {
        const struct amdgpu_gmc_funcs   *gmc_funcs;
        enum amdgpu_memory_partition    requested_nps_mode;
        uint32_t supported_nps_modes;
+       uint32_t reset_flags;

        struct amdgpu_xgmi xgmi;
        struct amdgpu_irq_src   ecc_irq;
@@ -468,5 +472,6 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,  int amdgpu_gmc_request_memory_partition(struct amdgpu_device *adev,
                                        int nps_mode);
 void amdgpu_gmc_prepare_nps_mode_change(struct amdgpu_device *adev);
+bool amdgpu_gmc_need_reset_on_init(struct amdgpu_device *adev);

 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 619933f252aa..97ca4931a7ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -833,6 +833,8 @@ static bool soc15_need_reset_on_init(struct amdgpu_device *adev)

        if (amdgpu_psp_tos_reload_needed(adev))
                return true;
+       if (amdgpu_gmc_need_reset_on_init(adev))
+               return true;
        /* Just return false for soc15 GPUs.  Reset does not seem to
         * be necessary.
         */
--
2.25.1

</pre>
    </blockquote>
  </body>
  <lt-container></lt-container><lt-card class="lt--thunderbird lt-card" style="display: none;" data-lt-adjust-appearance="true" data-lt-force-appearance="dark" contenteditable="false"></lt-card>
</html>

--------------0C2I5AM3rCAP0zSDLp8Sp6Uk--
