Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7F7D339A3
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 07:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 358A410E5C4;
	Tue, 29 Oct 2024 07:51:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xnxW0Wuh";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E8FF10E5C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 07:51:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ny1caV/cvu/K9N8jLMDVsWf6IMYLSLYFER1sqwg6c4PdPw8DQcRWuYfk+ANl3e+Xs9VWh16NyBhnwSLKW4Qbnopj+oNNNKL+t6TlUVnNnKsice9ePoektBPGj8y/XwQLxctZtXRyHgYpWoIZW6Bs5ymv5BX1K8D+eWcd/lUGB/a8dDgdiSGvq3BTtiPR9xgW4DwqDOH3FxSqJFVd+i7WVulZnSDe1nAa67tiZguqluRL4sEmhP2KgAiE6iD70EIOFaF5blwcnbUrEvzIkFv/Kzeqv3qgbFeqV7dO4stPO221cS4z5e0gJ/7SZkEZ6/psrIMDbX9XQhqsdv1noyQ8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piGYkxFVA4DQ5AH5PQ8iqMjBFfdDEtzHedswI9MUGs4=;
 b=palHOE77LJUgKKUkbjxQ9UIYCoxLRYcWkXh0dOn46reRCfRFLqLch6bZvzvgrc1NtO2CE6ciesRhjhcm+G69QZ2CewJmRsimyVvUw4Wjxz0uscBlMCkHd9Ojbifoy7dVzSXUDE/XSR5K2s2JzESgstcnWokJs8wuInpduIEXLi5GHEXd/MnMdmXu6dvn2SVO5fF0T6F5E6nRBhSa2ix/vVFZNNPsV0z6WGTiTxDz/ih8EjGvioxLaIeh90N0BmIyqqyFu7fP6ogTr1Lg2AgB5ABGDf3Lmg6q20UX5BRaiQUyX1RCMnWWMUXC70ZAelKZu/E+WOTmdkZrCPJ9puqL/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piGYkxFVA4DQ5AH5PQ8iqMjBFfdDEtzHedswI9MUGs4=;
 b=xnxW0Wuh2/3GPPOnycPLC+InUlBj05e2PhAXgUD5tiG+NSqTZj1KCBuKqNeQAuXvduQ0jZCbGu2FlaeJcTCVhYLi/gDKrhDdGm9iifFdeja+y44ecRf/8sTXJtIoR7E2zWvxogKz5d+uAg/GKw/kFUNEiBE43oGMVdT36FWTXho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 07:51:36 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8093.023; Tue, 29 Oct 2024
 07:51:36 +0000
Message-ID: <ca37c9cf-917b-475f-a508-b5e938b46beb@amd.com>
Date: Tue, 29 Oct 2024 13:21:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Group gfx sysfs functions
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Christian.Koenig@amd.com
References: <20241029052700.3164571-1-lijo.lazar@amd.com>
 <93ad9f9b-9803-4ba3-b29a-06b5c53b5ccd@amd.com>
 <c401ea1c-0b2f-4591-abe9-6a911c55b3a0@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <c401ea1c-0b2f-4591-abe9-6a911c55b3a0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PEPF000001AF.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::b) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|LV3PR12MB9167:EE_
X-MS-Office365-Filtering-Correlation-Id: 141d3513-bed3-4031-4077-08dcf7ee83b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHY4anBsQnRrUXB3YjRsV0ZCNzdwNnJyamZPcGFzMHZnMC94N00zNU04czYv?=
 =?utf-8?B?dkNnRlIrdG10MVNDN2RvVDRmU3I5K0pjSk9WeGVkOHVnVGU0YWd5bVJGTnBN?=
 =?utf-8?B?WkoyNnM2cFMwcnRlY0x0dDZXc1U5Wis4cm0rZnJnbm5FQlRmNWlyc3dFQ0Jz?=
 =?utf-8?B?SHp6ZTJoK09wS3NCWmRCYm1IOUljaWV1VVFEek1iaEsxMHQzYzJmeVE5Zzlh?=
 =?utf-8?B?TS95NkRWSlFhZUNuT05TaHREa28yTXpVd3FocnF3L3lxVy9YSTVzeXFhOXBE?=
 =?utf-8?B?RUh2dDA5ZVVHeUp4QVFiOXh5d012ZmNOcVFHQXhDZmJjNjZNN2Q4ckF6YitB?=
 =?utf-8?B?NElyNjJ5VUladnZDSHozUFJIQ3lMZTAxUjkwam5iNW9xUWtTaG9OZVVpdHo1?=
 =?utf-8?B?QXRNN3ExY3lqR010c3BpR1k1bnk0Q0hWenB2OVZ4bXBnWW1DZDd4OFcySTVk?=
 =?utf-8?B?VVd6dzJrN2krN3JxSytiWjQ3b29KWkltTFVIS1pDNXpEZWU1WFRsNXA3a3dB?=
 =?utf-8?B?dkRQQjgwWitnZWxEZSsvdWlJbVF5ckp6SVZ6am44MnhJYzZmd0MwNlFiWXJF?=
 =?utf-8?B?OVpVSFRVbUcvdHZPLzJpR2FsUHpaS0dxbnBhUE1zN292ODZiaUJRUzZBRkxp?=
 =?utf-8?B?YWJHTzZudFIwVnIxVjlCKys1bmJ1eTRrODFZRXpzMUg5VGxtTEJhNm00UzhY?=
 =?utf-8?B?MS9uZk1PYWJ3MWE2YmNiRUN2blE0QVpzUWsvaW8zMnd2bFZnaVo3cjlnMDUx?=
 =?utf-8?B?YzJFcDN5N3M2bVlKNFNMN2NUTk5HNUtmYnh1MTBRZ1J3MGovazlndmVUQjVR?=
 =?utf-8?B?Sy80VnJIa3p3VjdEeEFvWGI1VG1XRE93WVpVVk9GWnFlb1RNb2trcUV4ZXEx?=
 =?utf-8?B?NndVdjhxZitKNGNFQnoxZlRwV2Ewc05ONkZibDEyMTJpcExxcXVpNkhtbWxw?=
 =?utf-8?B?a0J0eGdwWFpUb1V2TUlad0xkL3dPVGFENm1XaURpb0FqM1pnUXpLWDh0MndF?=
 =?utf-8?B?UjJkOEc2TXJBUmZ4OCtCTjhJd3d1RVVRVzRtMnN1dE94V0tjOHBVSTVhL0xu?=
 =?utf-8?B?MUxUdVJRTllWNGV1TEtMSUk4MDdUdnJhZGNkUlVmVDhkMHU5VTBvMTQ5NXZw?=
 =?utf-8?B?dUcrOWxzeUE4dXNONmVsUGJwaThybjNlb0ExSXJ0NFhSVlB1NjBFenJuUDZ2?=
 =?utf-8?B?ZVBsZ2ZrV204N01VVFZZd0wwUkg0dGRUK3dUclNXWW9zci9iOTRNeXpMS1pM?=
 =?utf-8?B?OVlqQUpzWWVpOUtjaHBPTVAxVW16cHF5QVk2Tm9QanU1U2xzMVNUS2Z0Z3FN?=
 =?utf-8?B?QnFxZWxvSnp2MVlLaHQweFVhZktqaDhZUGpKMHNKTmxNNVpYVzJldmpVT0s5?=
 =?utf-8?B?N3VBSi9ITGkybUl0Q3pQZ3BaQmhDdFVWcWlSRzZITU95MVBvbXEwZzhzVFpK?=
 =?utf-8?B?eE1IckVEd0xEM0JNSDZObk4vOG92eTFsY1JVSUxlMDFNd2pTSERkQk1udkFj?=
 =?utf-8?B?bUxhRVZuK3Z5QVQzZFpSS3QreTd5VVFjWGNOd2FzY2RUV2RhMjFoV0F6YjRk?=
 =?utf-8?B?TnlQSS9Ia2tyZkhkQjM5M0tXU3doZlQ5d2xDVUxVVk5LNG9MU0JyNVFQSy9Z?=
 =?utf-8?B?c25BdW1ZenJHb0JyWjAwdDl3cVU1MU9KOS9JOHkwUzdDNGphM3k2bVBRbWJo?=
 =?utf-8?Q?M4iRZx7IjD0CLjtPMZfi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUxub2wxeGJNdnh0YUd0bHpJYkdXVlhkUGptV3dZaEZ3OWZ1cjFzUi9ZUmxS?=
 =?utf-8?B?alF2cmFNeXllY2VhUDBSSW9hQVFtWUpzUjFtalJkZXkybFFkalZZZjR0RlI1?=
 =?utf-8?B?dE1PK2p5Snp6bUlRcU5HV1U1NEFKbW9WckhNOEFNcTU1TXhWZmtvemZIYkNB?=
 =?utf-8?B?Z3FkYkZNTnB3a0tTdjZkRUQ2Wk1TanpqWUFjSWtpSmhFNVlJVzFISUxzRWZE?=
 =?utf-8?B?cWZnQTJIYVlDTG0zQjlmNmN0TGszdDZSK1VMSU1aUFV4eWR1KzJYT1hqUita?=
 =?utf-8?B?RDRXbnJIWjdsd05GOUJOVkRzZ21iZXdaWDBVbTFPSGttS2owNDVVMUhZME9G?=
 =?utf-8?B?MTJUMlREZnZNWngwRFo3dHB0a0xXQW0vUlJtdmNBQ1pCSGJKVk0zTzB2TXN6?=
 =?utf-8?B?NE03bDlPTkZtQTYzalBzUmoxY1BtaHkvc283TUFianQrbktOREpDLzRpNGMx?=
 =?utf-8?B?YWp1ZGwvUTdZUkJkbW1kNWQwR3MzUENWbVB1N25mbFhNZjJaZUFEbjF4NHBa?=
 =?utf-8?B?Z0c3VVZSUEU2d1BWM3ZGL1lkdDcreUFpRGpsZVNYZEFoTGJ1d2lleDA0bFhZ?=
 =?utf-8?B?QUMrcnJBSE9MZ2d0NDM5eEYvMGVEUlJJczR3eXhIY1loUGJFL3NxV1Axckpx?=
 =?utf-8?B?VlJxZ1FZRmx0d3ZJUFRqYU1nb24yK0RjNjU2LzNlUm5mZmhUSkZLeVY3VmNE?=
 =?utf-8?B?ZjAraWpOQWlPMmlDQTU2S05yMk82b2M4MEl5VFRDL292WWwwTmFLU0gyRDRk?=
 =?utf-8?B?MThka0lKeEdhVVVvNFY3dWNsVThpTE5DSEVZUGlBRDAxMjJGRENPSUplYUMz?=
 =?utf-8?B?RjkwdDVIK2FXTFF4S3NVMXIzNFJ5K1hDdXpFSUtYMEJxNTFsOUhCcGtybEtO?=
 =?utf-8?B?WW82eDZWb2pDaHIwTVNmZXZLczArRTAranBIekVPSFRPZXBiRjNpUnNLektN?=
 =?utf-8?B?U21kMzBVUGl5ak1uMFJSenZhYlNGSkRmenZTTUIyT3JpRThOWXZPWmhsWHdp?=
 =?utf-8?B?Nmd1V0tIcnprQlBjNGxENkNXMnQybU9XYkd6UXRPZ3BoT1U1V3cySW9xYXEy?=
 =?utf-8?B?dXlMZUJjWnVaeVJsN1NzZWk4OXZTZm4ydDd1Q1E1WXl6cExsOHVCeFR1Uncr?=
 =?utf-8?B?RzZrU1NwTkdlWHNORHluQm5NREJ6bGh1Yi9FUTZQUXVuZDVTOURTK1VVYnVj?=
 =?utf-8?B?SG1pNzYwVWo3S2JibStTWjhxUG5QSTVTK3dIV1JFbTRoRHBXczJhZ0NFMVcw?=
 =?utf-8?B?NVhNSGpIYnBVYVBWNFBVNHV5OEx4NUdOanFJUlNsUmtIZU9TaHdvV1huTytl?=
 =?utf-8?B?UExuK2lBV2VjWDBEekNXamZwNUdpcndqYTY1clEzMUhwVjdwY25TTG5YaGs1?=
 =?utf-8?B?STRhc01tT2pKNzR6cDJIVWsrdVhwQ3ZhQzRRRHIwM083ODhhM3hlUFp2ZWFT?=
 =?utf-8?B?Y2VYa05MOE51NGdjMWVwbDdsNGd6TlJjR2l4ZFNvM1hpVEI5SStMd0Yybjhp?=
 =?utf-8?B?S2ZuODBwRGhKaGtySVE0Q2NHNGFqQWxEMk9XUGtnUHNQdnU5WVhDMDVaaVpa?=
 =?utf-8?B?NTVZWGxTQ1hvK0JWSkFMdjV4RXpsN2JxS3VCYStIaWluNHZKL1ZoQUFMcWZS?=
 =?utf-8?B?SWlOaERBK21UOHV4dG9oTW0vMml5TzUvVE9acFU4SnF1aTU1RnB4R2NJd3lM?=
 =?utf-8?B?K1IxYm1QL1NoVmlqTkVkL1pBN2NRR3pDSFRQVWJqWW9HMXNEOXZvSkVvVk5M?=
 =?utf-8?B?Ri9wSmd0RmQwc0ZicDFtcldaUWhFSG15Wm5jbFI4TjRkcUdoM1lJNVhMQU9C?=
 =?utf-8?B?cDlnRmM5NU45V1RJOE1mbjFIazlTSFI2dUhVbnA0ejQ3cDVTcktYUEdQYnow?=
 =?utf-8?B?R1prQ2xYYTV0U3ZPUVpjZVYzUVlmNjgwV09iRWMzU1FScjNBanhjanFWcmRy?=
 =?utf-8?B?VnZQQ0FNeENyaDg2ZDdBSFg5MHJCSG8rT3Bra1h2QnAzbXRyem94SGNsTGxG?=
 =?utf-8?B?K01MVTVaeGRORlZoVjB2Q2IyNGRtdThmYTlhbzl2QmN6U3RNU1BTTVd4SVFx?=
 =?utf-8?B?L0pqOU54bUlETUdPUEE5cWN2bU1wR0hNOHI2dDNqekZOTDI1emxuNnJTTFNB?=
 =?utf-8?Q?PhThpVNk6HCVy3v55h1rQimwO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 141d3513-bed3-4031-4077-08dcf7ee83b6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 07:51:36.8159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLciimddJD5oSlRffCVJBPqgn+/yPuhXN57YcO7thLGjZWSJ12H5ipowRA/hUnQ4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167
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



On 10/29/2024 12:18 PM, SRINIVASAN SHANMUGAM wrote:
> 
> On 10/29/2024 12:07 PM, SRINIVASAN SHANMUGAM wrote:
>>
>>
>> On 10/29/2024 10:57 AM, Lijo Lazar wrote:
>>> Make amdgpu_gfx_sysfs_init/fini functions as common entry points for all
>>> gfx related sysfs nodes.
>>>
>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 37 ++++++++++++++++++++++---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 --
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  5 ++--
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  4 +--
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |  4 +--
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  4 +--
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  5 ----
>>>  7 files changed, 42 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> index e96984c53e72..86a6fd3015c2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> @@ -1602,7 +1602,7 @@ static DEVICE_ATTR(current_compute_partition, 0644,
>>>  static DEVICE_ATTR(available_compute_partition, 0444,
>>>  		   amdgpu_gfx_get_available_compute_partition, NULL);
>>>  
>>> -int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
>>> +static int amdgpu_gfx_sysfs_xcp_init(struct amdgpu_device *adev)
>>>  {
>>>  	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
>>>  	bool xcp_switch_supported;
>>> @@ -1629,7 +1629,7 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
>>>  	return r;
>>>  }
>>>  
>>> -void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
>>> +static void amdgpu_gfx_sysfs_xcp_fini(struct amdgpu_device *adev)
>>>  {
>>>  	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
>>>  	bool xcp_switch_supported;
>>> @@ -1646,10 +1646,13 @@ void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
>>>  				   &dev_attr_available_compute_partition);
>>>  }
>>>  
>>> -int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
>>> +static int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
>>>  {
>>>  	int r;
>>>  
>>> +	if (!adev->gfx.enable_cleaner_shader)
>>> +		return 0;
>>> +
>>
>> This check seems to be incorrect here, because enforce_isolation and
>> cleaner shader are two different entities, with this check
>> enforce_isolation node won't be created for some of the ASIC's where
>> we don't load cleaner shader explictly.
>>
> Correction, this check "
> 
> !adev->gfx.enable_cleaner_shader" handles for ASIC's where we don't load cleaner shader explictly, but
> having it here I'm not certain cz I think we expect enforce_isolation
> node to be created independent of run_cleaner_shader, would request
> Alex/Christian, to comment onto it further. -Srini

My understanding is that isolation will work only if cleaner shader can
be run. If that's true, it doesn't make sense to provide a sysfs
interface when cleaner shader runs are not supported.

> 
>> And moreover this grouping, its better to be done for all sysfs
>> entires in amdgpu ie., not only gfx, for other modules like even pm
>> etc., so that we can have one common sysfs amdgpu framework, improving
>> code consistency and maintainability

We still want pm/individual IP modules to decide which sysfs files need
to be created. Centralizing is not good.

Thanks,
Lijo

>>
>> I had initiated this https://patchwork.freedesktop.org/patch/595215/
>> <https://patchwork.freedesktop.org/patch/595215/> , but I couldn't
>> finish it because of other work commitments.
>>
>>>  	r = device_create_file(adev->dev, &dev_attr_enforce_isolation);
>>>  	if (r)
>>>  		return r;
>>> @@ -1661,12 +1664,38 @@ int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev)
>>>  	return 0;
>>>  }
>>>  
>>> -void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
>>> +static void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev)
>>>  {
>>> +	if (!adev->gfx.enable_cleaner_shader)
>>> +		return;
>>> +
>>
>> Same here
>>
>> -Srini
>>
>>>  	device_remove_file(adev->dev, &dev_attr_enforce_isolation);
>>>  	device_remove_file(adev->dev, &dev_attr_run_cleaner_shader);
>>>  }
>>>  
>>> +int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
>>> +{
>>> +	int r;
>>> +
>>> +	r = amdgpu_gfx_sysfs_xcp_init(adev);
>>> +	if (r) {
>>> +		dev_err(adev->dev, "failed to create xcp sysfs files");
>>> +		return r;
>>> +	}
>>> +
>>> +	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
>>> +	if (r)
>>> +		dev_err(adev->dev, "failed to create isolation sysfs files");
>>> +
>>> +	return r;
>>> +}
>>> +
>>> +void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
>>> +{
>>> +	amdgpu_gfx_sysfs_xcp_fini(adev);
>>> +	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>>> +}
>>> +
>>>  int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
>>>  				      unsigned int cleaner_shader_size)
>>>  {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> index f710178a21bc..b8a2f60688dc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> @@ -577,8 +577,6 @@ void amdgpu_gfx_cleaner_shader_sw_fini(struct amdgpu_device *adev);
>>>  void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
>>>  				    unsigned int cleaner_shader_size,
>>>  				    const void *cleaner_shader_ptr);
>>> -int amdgpu_gfx_sysfs_isolation_shader_init(struct amdgpu_device *adev);
>>> -void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev);
>>>  void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
>>>  void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
>>>  void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> index 9da95b25e158..d1a18ca584dd 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> @@ -4853,9 +4853,10 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>>>  
>>>  	gfx_v10_0_alloc_ip_dump(adev);
>>>  
>>> -	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
>>> +	r = amdgpu_gfx_sysfs_init(adev);
>>>  	if (r)
>>>  		return r;
>>> +
>>>  	return 0;
>>>  }
>>>  
>>> @@ -4907,7 +4908,7 @@ static int gfx_v10_0_sw_fini(struct amdgpu_ip_block *ip_block)
>>>  		gfx_v10_0_rlc_backdoor_autoload_buffer_fini(adev);
>>>  
>>>  	gfx_v10_0_free_microcode(adev);
>>> -	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>>> +	amdgpu_gfx_sysfs_fini(adev);
>>>  
>>>  	kfree(adev->gfx.ip_dump_core);
>>>  	kfree(adev->gfx.ip_dump_compute_queues);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> index 5aff8f72de9c..22811b624532 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> @@ -1717,7 +1717,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>>>  
>>>  	gfx_v11_0_alloc_ip_dump(adev);
>>>  
>>> -	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
>>> +	r = amdgpu_gfx_sysfs_init(adev);
>>>  	if (r)
>>>  		return r;
>>>  
>>> @@ -1782,7 +1782,7 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
>>>  
>>>  	gfx_v11_0_free_microcode(adev);
>>>  
>>> -	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>>> +	amdgpu_gfx_sysfs_fini(adev);
>>>  
>>>  	kfree(adev->gfx.ip_dump_core);
>>>  	kfree(adev->gfx.ip_dump_compute_queues);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> index 9fec28d8a5fc..1b99f90cd193 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> @@ -1466,7 +1466,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>>>  
>>>  	gfx_v12_0_alloc_ip_dump(adev);
>>>  
>>> -	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
>>> +	r = amdgpu_gfx_sysfs_init(adev);
>>>  	if (r)
>>>  		return r;
>>>  
>>> @@ -1529,7 +1529,7 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
>>>  
>>>  	gfx_v12_0_free_microcode(adev);
>>>  
>>> -	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>>> +	amdgpu_gfx_sysfs_fini(adev);
>>>  
>>>  	kfree(adev->gfx.ip_dump_core);
>>>  	kfree(adev->gfx.ip_dump_compute_queues);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> index 66947850d7e4..987e52c47635 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> @@ -2402,7 +2402,7 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>>>  
>>>  	gfx_v9_0_alloc_ip_dump(adev);
>>>  
>>> -	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
>>> +	r = amdgpu_gfx_sysfs_init(adev);
>>>  	if (r)
>>>  		return r;
>>>  
>>> @@ -2443,7 +2443,7 @@ static int gfx_v9_0_sw_fini(struct amdgpu_ip_block *ip_block)
>>>  	}
>>>  	gfx_v9_0_free_microcode(adev);
>>>  
>>> -	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>>> +	amdgpu_gfx_sysfs_fini(adev);
>>>  
>>>  	kfree(adev->gfx.ip_dump_core);
>>>  	kfree(adev->gfx.ip_dump_compute_queues);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> index 016290f00592..983088805c3a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> @@ -1171,10 +1171,6 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
>>>  
>>>  	gfx_v9_4_3_alloc_ip_dump(adev);
>>>  
>>> -	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
>>> -	if (r)
>>> -		return r;
>>> -
>>>  	return 0;
>>>  }
>>>  
>>> @@ -1199,7 +1195,6 @@ static int gfx_v9_4_3_sw_fini(struct amdgpu_ip_block *ip_block)
>>>  	amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
>>>  	gfx_v9_4_3_free_microcode(adev);
>>>  	amdgpu_gfx_sysfs_fini(adev);
>>> -	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>>>  
>>>  	kfree(adev->gfx.ip_dump_core);
>>>  	kfree(adev->gfx.ip_dump_compute_queues);
