Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7ECCA0EDC
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 15:35:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44D7A10E8A4;
	Thu, 14 Aug 2025 15:35:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e8FLlNzm";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BDF710E8A4
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 15:35:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVYQhd5KvRlCNuJlQS1BQxdFSXZkCHemdM09CtC18JfkOHBesAU7wtvCWd5XaYP3xeQ9AoEVIVSsnj3pKNvAotBu9r2R+QV6VrGXjQNbdhV7H1n9pe7sTd/a6ufxgFudG2aHdZOj6kF5UWxG386QI+Ay84Qt8QmFk4gnWkH8I44aQeAH1+EIoNR/GMpPdcYrw2Uvb2qZO4BZIGKAMb3YA+jjr10biRn/HuWKSVPOxcqlg2Sd2zAFy+L+JKLYFBQkAOFSPsWTeNUWI3QKWPD1oRbDF+L+X79Zd0TKAnCaslyXB+xj89zTYyMAH6ua/xVMhEyJW57WLnPe7ui3OzSb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alazMVFMcxp4EbSnigjvKK8ukK+1+xvwWkAl53m1vF8=;
 b=V/XyJgS3OVTZYqgYu6Vc1C+/5CYYP/frpjkOZ7Iy97h9XPRKs0OUPW7fkipL8JYPwsYJWA5+rH7CxSRPNcBGC09Zm57B1haGUE+DayQnfGeOU2L8Ogq5ry1ybk0rydTGU7tfP++QXC/b0KRQAxtd+QCEE/5edz/GTEbokYj76POL2LtoJLfDIgxzIMYyQPKw9+8UiDQDlpTf2NxCyXOwEDD5VqfOqqB4/T89eGvRbhm16SvKmxExZXkA3fDYySHFvbv4kk2i1HlOQ5sL3VzPazyJcAId6L81MkVZ52qGw9z45CZ0nl/XITzbTAgnk73dzjNHJd27gpKyEjJ13XziSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alazMVFMcxp4EbSnigjvKK8ukK+1+xvwWkAl53m1vF8=;
 b=e8FLlNzm9plTZdodUkTf9YZj31m95TlRGOQCHwVfkqdhDmWMk0v49aVgTcfJEbRE26E/TczUAQVZYBWA6JdgVQF0AF2fffE/OavBt3OdzhGwbV3MeRgURoY5YPQ5Cd0aUsXWMCQ4li/GGaxi8nbrXSc3Bl+poBg+IEoOBu6o+qU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by CY8PR12MB8338.namprd12.prod.outlook.com (2603:10b6:930:7b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 15:35:39 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 15:35:39 +0000
Message-ID: <7a8991f7-1eb7-4307-ac72-1281a50bf4d5@amd.com>
Date: Thu, 14 Aug 2025 11:35:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250813134504.2037516-1-alexander.deucher@amd.com>
 <ae769200-c37e-426b-b73a-ac9473cf66eb@amd.com>
 <CADnq5_MbT-4Q4HfQ15AWMNGu6hct2=Yu5K5+F6qMGWDC6H_ojg@mail.gmail.com>
 <faee7074-f3bd-4791-b3f0-fe409049de06@amd.com>
 <dc8beb3b-789c-03c1-1c37-50c998b7e44a@amd.com>
 <CADnq5_MJouzU1QFsuuMtiXeFAHi96zXfBzuAWFAvfauHssw_eg@mail.gmail.com>
 <1633c024-a1dc-cdc3-6a28-c48b49640297@amd.com>
 <CADnq5_P7OWj6GLi+qzZ_EVZAK5dPiOrjmvV9CRqRG+iFtcq78Q@mail.gmail.com>
 <85af1027-5a09-40ce-987e-9f4ad8fe2b5c@amd.com>
 <CADnq5_O2gnR8GtAaL-937R97Kwtb50QNh+Y3V_TzsLGLbT8CLQ@mail.gmail.com>
 <ad01beb5-e17c-4ace-8707-4cd5f52de2c8@amd.com>
 <CADnq5_Of2gkZoyE9V-3ySEMvc20sVG9S8rz8x5uRLCX=OEnnvw@mail.gmail.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <CADnq5_Of2gkZoyE9V-3ySEMvc20sVG9S8rz8x5uRLCX=OEnnvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::7) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|CY8PR12MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: 1897ad83-54d6-4a31-cabe-08dddb4838c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUYrWGE5ZExCWEhLbXRhRVlLZ2ZGcUtPVWUvWms3NTk4WUxBYS9NWDdOVzht?=
 =?utf-8?B?SFBrZmhLcjRPVDk4TXMyMlNaUDJCREltb0R1YVJicjJ0amFhVzlLNkJuTGNz?=
 =?utf-8?B?ejZ4anBDOFE1UFVWZVhiSTBtY2E5MnZRc0pXVXdBeFppUHFhVGRDb2NvMFlv?=
 =?utf-8?B?bEYyaUpzQkRqazlQMVY1cFRKMDhXY1pzcUloaGZ1aXNUVWZRV2laWTd0RjNP?=
 =?utf-8?B?Mm53QlVlQS9JZVVCdjBTM1ZZLzBmV3hqVjZvazhOYkl1N1N1MUptZWN0a0JW?=
 =?utf-8?B?djFXNVIwRTU2UFB5NElhVVprOWNGdFkvRWN2Q2d4UjNhTHliV01jU0UwRkda?=
 =?utf-8?B?azNzUFZpWThYd2FrN3Q3Vk9tZ3Q0N2RzWXRVUGpxVmRCYWdFRGlxaFBoaDlQ?=
 =?utf-8?B?L0RSL0s0b2RmWDRHV0FQaDUva0hXaGZxNlhiQk5GR0tQMFMrRXc5UmpYN0M3?=
 =?utf-8?B?UWxSaHllOFBTMFBvWVlHb1RxZk5JNTBMdVpsajBEa0NmYUFlcjhuVjJxSC84?=
 =?utf-8?B?YVh2NmsxRE9qOTFHV2Q2U0hiUGpMMDMrSngwRTh2a2YzdGw3SGh2a3lyRnll?=
 =?utf-8?B?dnNOUEIyaW5ieHJJTi9KL0ZRRTEycStKbTM2VS8yQmk4NFlKZ3Rwa0QzbWtI?=
 =?utf-8?B?OWs4bzlXdFZsckVHOHBSaE1LZzFuekhSLzlRWW8ySVQ0VzdpSmVra2F6WVo3?=
 =?utf-8?B?c0dpeUt1NEx6SnhHdVdKME56c005VEpkSTNYMWt0TmNUbmt6MU5VWUIxNm5v?=
 =?utf-8?B?endiYUMxeHVvc1l2bTlqOTlxQkRCV0tuaFFZWUJFcWVyTWJVN1VlVWtzUTlo?=
 =?utf-8?B?QUxRbjdCTmFyRWVIRCttOE5lMThZMkZZNTNsamdEaGFmYUsvTis3MTdGazA1?=
 =?utf-8?B?RmN4VGNlOU9CNktBTVdJVjBLVm9zeDdLdXlxcW5rQmlsUVk2cFpFWHU2MnZQ?=
 =?utf-8?B?ektWaU5hRDNQejNWWUUwaVZMWmpabFhZbWhvUThHTjIvano3ZENzK2NHNDVi?=
 =?utf-8?B?OHk3SjZqWDFrTHA3RmFRdUFJNTdySjRrZ0k2eEF2bWNNRXhuc1hWQy9NZnBq?=
 =?utf-8?B?eHlETzVzQld2RmJINHdaYldKQW9vVXRhUG9iSHNGVUlCbFpFZHBQekM1WHhF?=
 =?utf-8?B?bGZqNkUwUm9UY01Za1c3MFlsenR6RWI0U2hRQVJOUXVGKzhqcEZrQkIyNTFr?=
 =?utf-8?B?NGJreFIwMUpNcXpqWUFwVzlmOHJSVis5dDRETVoxNU1vbmxxa3JDbUltaThO?=
 =?utf-8?B?Q3NValJQaFlyZG92QVR0UXBjSlNwUlhMUFF2THo5bnBHQjVCTmxsWG1ZWFNR?=
 =?utf-8?B?ZCtQc0lCMlBOSFVpRkRZTUpqL09kZysyb3pyQjMrUVczS0lkeXlmV2pFY2NG?=
 =?utf-8?B?QmhoTTluRmdsS2picGIzeVdkVzkvZ3BjYzl2YXhPa1dYQllGTnhlajJuUWFo?=
 =?utf-8?B?WUJ3NG80RHA0ZjNVRmdlamNOOXBvMVErM3htd3pSdTU1eWlTVEZSZkY5WllC?=
 =?utf-8?B?Z0tmWFBJQ3BDY05RbklERnRJWkpoTXV0MGZ2UGhWRXBmclBMeTlMQ05mZkx6?=
 =?utf-8?B?cHpoWElleGF2TFM3c3VXTkdiU1J3Wng3SU5SdWZSeWtqdjBiclVCWEcxeUQy?=
 =?utf-8?B?NHpPTGl1ZW9RZzBEZnR3QXZPcVVlQ1FYSWRXTm5NMENBejl3aVRwYy94cTYv?=
 =?utf-8?B?dmt0OUdSTWNIR1Y1MlVOc082S3FISDd3Mk5pZzdUNU82bkF2Vm8vZ2cwMnV2?=
 =?utf-8?B?Slo0Zm9tdDhubnFRL0RtbEE5bnhXUGlvZXdwMnF0S0s1dmN6SFZjVWFaRUdp?=
 =?utf-8?B?cE1LL0gzYkpPYjBDOTlDcXdLeDdIODRqMWJTUDhPVmJrblBDKzFkV1NraGlz?=
 =?utf-8?B?WVg3RVdlVVFaOXZJeGw2VG0vd2NOMUZtbzNRQTlaZ3ZxTW9wd0JrQTJzb2Rj?=
 =?utf-8?Q?EnAjpLqh/zU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q01TMTBobGNJN0Y1c1RKQm5zOXZWWGlUdkNmTjk5TlNscW82bFRranpVNVpp?=
 =?utf-8?B?b3pjMGtMaTdaemo1SkFWRmFQaExRaWhBR3NYdHhmL0t1QThIOVhIV0pma2dP?=
 =?utf-8?B?Ym1WQ1U1WE9tV0JncmRobjJOZG9CQTIvVXhDdjhEYVBlaGUzSUkxaXhWTms0?=
 =?utf-8?B?enRvbmlEdStkK1FmbGpPYzhaR1NLbUg1ZUo4eTZtZGtPL2xaRThpQ3dhUjB6?=
 =?utf-8?B?bjRFUUd3N1RFYVZqbmRqU0tta2YvM3dxUVBaV2F2WW1WVzdUZTVOWWF3MDBh?=
 =?utf-8?B?QVVsbmxNdGZXL3I2NkdXMXRUUGRWT2swQWlNU3A0dXNEUFgvTWhpZTJaakpB?=
 =?utf-8?B?dHVBTythdytwT0ZuQVlHVUlaaE1lQ2RZUmZ4dmhQK2VoeUFDYVFiazdRVGFJ?=
 =?utf-8?B?eXNMWmtGekR1UVRMZEdaYnFtR1hKNzBmRGZ4NFdSODZsaFNDZDR4VmZjRzkv?=
 =?utf-8?B?WkU4bmFEb2pXWUVDTE9XRHhtS1d5a1Vuek9wck04S1pYdlYycmpsV0grY0xl?=
 =?utf-8?B?LzFRQ1dsQkgyYWlDdUhJU2V5QWhIYXRBcWVmODgrc0tWUDdhRGg3cWpwRVpD?=
 =?utf-8?B?bXg0dy85N3pqS3MxanJYY0lJUllqazdCYUZLTlcrY1J5ejNvYWZXODBjaGRr?=
 =?utf-8?B?ejJ0WkpaZDJwcmFRM0l6WmFWaXk0V0E1dkVhU043T3UxNkVYcmpRNzBSSjFk?=
 =?utf-8?B?VGR4UWd1cXZlSzRlZk9PN21Td0VPb0Y0Ry9PMXQ0WldWc1FZZ3RadmM3ZUxJ?=
 =?utf-8?B?dGRSMzJNZTNJNVE2eDlyd0l6Q2crZUZXZXNWUXNWNUYweTFKcW5IcHpaR2hC?=
 =?utf-8?B?Nmp2ZjlxZmZwMW04UFNJSkEvczVUZUIrcUFVeENFMzRrZStQSmZlaUdjTTNs?=
 =?utf-8?B?dzZZM2hqWk5McUY3WUNZRXRKcVdoSjN5blMxSUJlU0U4eHkvdjlXcmNBNWFp?=
 =?utf-8?B?US93WFh3TE5IT3FDdmJrYmRVSlJ3TEdLNUo1NS8wcldISm0xc3RtSGh3Vkxk?=
 =?utf-8?B?b1c1dklMKzNGalhJT3dJK3pyZkx5RjNmR2lVUHNrWFgrOFo2VnNjRmd5MUlN?=
 =?utf-8?B?VFQzMWIxUXV2MVJuTWlESjNPWFBMSmpsZnlwTDk1cEY5aHljS05QWFZlN3Bi?=
 =?utf-8?B?aXhuWnNyTGN4a3AzcTlhd2xIbm0reHJtQy9LNWtvU2h3Y2J2bno0dWtleEp5?=
 =?utf-8?B?RUt6UGVuZHI4WXNxNTRac0orNEErZnFTazNuVHU5K2dnakVpajhndzRXbnZz?=
 =?utf-8?B?bFhld2tLeTR1aWNndzZ5MGhBRTRKZ2traDN6Zk5Gek5XRjMvZzhsZzNPb2to?=
 =?utf-8?B?OUd1a2FMVTJUSUJRenJlMENRaHlQTzVUb2E5ZlBDaHJXZVAwUktDeElTek96?=
 =?utf-8?B?TVBjWW1CeEJka080ZUprOUVPMURueVdsRXJUZWc5NzJVVGt6dHFuL3Q1SFBr?=
 =?utf-8?B?aHp1OEdjWWxqNTZkd3BqdkVsM3JaK2tSMXVuZnFRRHQyM1N6aXlxdTFtckNH?=
 =?utf-8?B?RStoQmlyaCthN29OelVaYkplMjdYa1RCNUxiaUxvN3ZRVDd6bm50NTdURjQ3?=
 =?utf-8?B?czBTRFlKMW9hS2lxT0EyUDFKNGluY3RJL3JXbWczWitGemNBOWpJN2NKQlVF?=
 =?utf-8?B?NXhHbU1nbWVLQ3JzblVEa0o4N3VLSFNOeWViRlo5S2VwMDhvSnIxbWkvZlFh?=
 =?utf-8?B?emFodXlNN3BZV0JSMFBORHFpTE80MFJEcUJLR3paYXdtVzRNeCtobmRqWWQx?=
 =?utf-8?B?eDhjWkNDZVU1Q2tpaDluVkxUQjhxYmlrZ0ZncXdzNUk1dkJjSjFKZXNHMU03?=
 =?utf-8?B?ZlFBY1pSeXlTSkxqRGdDM3NUa05MSVZ0QldQc01RNUsvRGhwYjZ3R245bzgz?=
 =?utf-8?B?M3hBQlRHb2FqR0tjQjdkZy93V3N0ZkcxenZqQ3pYQ3R6Znp3ampWYVJUazFJ?=
 =?utf-8?B?MnlmMGQ5bm9aVkx1eTIzbmpHWDY2aUE5dUl6Znpac3grRFdueUhuRldqdEMw?=
 =?utf-8?B?dTZObGxhSmdvL2R1bXRQUkNCNk12SGtwMGZYVml6VktBc25pNWtqL0RVSW9x?=
 =?utf-8?B?VGZZQkNkYWwzaDFlcSt2VE15WFNTVGFsdlI2U0ZXWk42ekZUR0Qzckk4T21k?=
 =?utf-8?Q?RhI+4M2nklopLEBXjMfaV+bQA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1897ad83-54d6-4a31-cabe-08dddb4838c7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 15:35:39.4568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4jqv3IqK8xnFaJk0aGIzzEmdgmclLmH4bQI7EMZezaQxELbE4ISkPZ7laclTD5tttxm3LI73tUMO2EF+PMEAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8338
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

On 2025-08-14 08:56, Alex Deucher wrote:
> On Wed, Aug 13, 2025 at 7:06 PM Wu, David <davidwu2@amd.com> wrote:
>> On 8/13/2025 6:11 PM, Alex Deucher wrote:
>>> On Wed, Aug 13, 2025 at 5:47 PM Wu, David <davidwu2@amd.com> wrote:
>>>> On 8/13/2025 5:03 PM, Alex Deucher wrote:
>>>>> On Wed, Aug 13, 2025 at 4:58 PM Sundararaju, Sathishkumar
>>>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>>>> On 8/14/2025 1:35 AM, Alex Deucher wrote:
>>>>>>> On Wed, Aug 13, 2025 at 2:23 PM Sundararaju, Sathishkumar
>>>>>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>>>>>> Hi Alex, Hi David,
>>>>>>>>
>>>>>>>> I see David's concern but his suggestion yet wont solve the problem,
>>>>>>>> neither the current form , reason :-
>>>>>>>>
>>>>>>>> The emitted fence count and total submission count are fast transients
>>>>>>>> which frequently become 0 in between video decodes (between jobs) even
>>>>>>>> with the atomics and locks there can be a switch of video power profile,
>>>>>>>> in the current form of patch that window is minimized, but still can
>>>>>>>> happen if stress tested. But power state of any instance becoming zero
>>>>>>> Can you explain how this can happen?  I'm not seeing it.
>>>>>> Consider this situation, inst0 and inst1 actively decoding, inst0 decode
>>>>>> completes, delayed idle work starts.
>>>>>> inst0 idle handler can read 0 total fences and 0 total submission count,
>>>>>> even if inst1 is actively decoding,
>>>>>> that's between the jobs,
>>>>>>      - as begin_use increaments vcn.total_submission_cnt and end_use
>>>>>> decreaments vcn.total_submission_cnt that can be 0.
>>>>>>      - if outstanding fences are cleared and no new emitted fence, between
>>>>>> jobs , can be 0.
>>>>>>      - both of the above conditions do not mean video decode is complete on
>>>>>> inst1, it is actively decoding.
>>>>> How can there be active decoding without an outstanding fence?  In
>>>>> that case, total_fences (fences from both instances) would be non-0.
>>>> I think it should be non-0.
>>>> I do see a hiccup possible - i.e the power switching from ON to OFF then
>>>> ON in the
>>>> middle of decoding, i.e inst0 idle handler turns it off then inst1 turns
>>>> it on.
>>> How would that happen? As long as there submission cnt is non-0 and
>>> there are outstanding fences on any instance, the video profile will
>>> stay active.
>> there could be no jobs but it doesn't timeout yet and new jobs will come in
>> any ms - note all fences are done at this time. The idle handler sees no
>> fences
>> and no jobs so it turns off the power - but just ms later a new job is
>> submitted
>> from the same decode session which could be mpv player as it does not
>> need to
>> submit jobs without delays. This will turn on the power.
> I'm not following.  Every submission will start with begin_use().
yes - it does - it can power on vcn but this happens in the middle of a
decode session which has 10s timeout to call its own idle handler - in fact
the other instance's idle handler will power off vcn because it does not 
know it needs
to wait until the decoding session times out.
> Alex
>
>> David
>>> Alex
>>>
>>>> We should avoid this glitch. This requires the idle handler sets/clears
>>>> a flag for
>>>> done for this instance as Sathish's original patch. When all instances
>>>> set/clear the
>>>> flag then we can safely power off.
>>>> David
>>>>> Alex
>>>>>
>>>>>> Whereas if instances are powered off we are sure idle time is past and
>>>>>> it is powered off, no possible way of
>>>>>> active video decode, when all instances are off we can safely assume no
>>>>>> active decode and global lock protects
>>>>>> it against new begin_use on any instance. But the only distant concern
>>>>>> is global common locks w.r.t perf, but we
>>>>>> are already having a global workprofile mutex , so there shouldn't be
>>>>>> any drop in perf, with just one single
>>>>>> global lock for all instances.
>>>>>>
>>>>>> Just sending out a patch with this fix, will leave it to you to decide
>>>>>> the right method. If you think outstanding total fences
>>>>>> can never be 0 during decode, then your previous version (v3) itself is
>>>>>> good, there is no real benefit of splitting the handlers as such.
>>>>>>
>>>>>> Regards,
>>>>>> Sathish
>>>>>>> If it is possible, maybe it would be easier to just split the profile
>>>>>>> and powergating into separate handlers.  The profile one would be
>>>>>>> global and the powergating one would be per instance.  See the
>>>>>>> attached patches.
>>>>>>>
>>>>>>> Alex
>>>>>>>
>>>>>>>> can be a sure shot indication of break in a video decode, the mistake in
>>>>>>>> my patch was using per instance mutex, I should have used a common
>>>>>>>> global mutex, then that covers the situation David is trying to bring out.
>>>>>>>>
>>>>>>>> Using one global vcn.pg_lock for idle and begin_use and using flags to
>>>>>>>> track power state could help us totally avoid this situation.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>>
>>>>>>>> Sathish
>>>>>>>>
>>>>>>>> On 8/13/2025 11:46 PM, Wu, David wrote:
>>>>>>>>> On 8/13/2025 12:51 PM, Alex Deucher wrote:
>>>>>>>>>> On Wed, Aug 13, 2025 at 12:39 PM Wu, David <davidwu2@amd.com> wrote:
>>>>>>>>>>> Hi Alex,
>>>>>>>>>>>
>>>>>>>>>>> The addition of  total_submission_cnt should work - in that
>>>>>>>>>>> it is unlikely to have a context switch right after the begin_use().
>>>>>>>>>>> The suggestion of moving it inside the lock (which I prefer in case
>>>>>>>>>>> someone
>>>>>>>>>>> adds more before the lock and not reviewed thoroughly)
>>>>>>>>>>>        - up to you to decide.
>>>>>>>>>>>
>>>>>>>>>>> Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>>>>>>>>>>>
>>>>>>>>>>> Thanks,
>>>>>>>>>>> David
>>>>>>>>>>> On 8/13/2025 9:45 AM, Alex Deucher wrote:
>>>>>>>>>>>> If there are multiple instances of the VCN running,
>>>>>>>>>>>> we may end up switching the video profile while another
>>>>>>>>>>>> instance is active because we only take into account
>>>>>>>>>>>> the current instance's submissions.  Look at all
>>>>>>>>>>>> outstanding fences for the video profile.
>>>>>>>>>>>>
>>>>>>>>>>>> v2: drop early exit in begin_use()
>>>>>>>>>>>> v3: handle possible race between begin_use() work handler
>>>>>>>>>>>>
>>>>>>>>>>>> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile
>>>>>>>>>>>> handling")
>>>>>>>>>>>> Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com> (v1)
>>>>>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>>>> ---
>>>>>>>>>>>>        drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40
>>>>>>>>>>>> ++++++++++++-------------
>>>>>>>>>>>>        drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
>>>>>>>>>>>>        2 files changed, 21 insertions(+), 20 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>>> index 9a76e11d1c184..593c1ddf8819b 100644
>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>>>> @@ -415,19 +415,25 @@ static void
>>>>>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>>>>>>>>>>            struct amdgpu_vcn_inst *vcn_inst =
>>>>>>>>>>>>                    container_of(work, struct amdgpu_vcn_inst,
>>>>>>>>>>>> idle_work.work);
>>>>>>>>>>>>            struct amdgpu_device *adev = vcn_inst->adev;
>>>>>>>>>>>> -     unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>>>>>>>>> -     unsigned int i = vcn_inst->inst, j;
>>>>>>>>>>>> +     unsigned int total_fences = 0,
>>>>>>>>>>>> fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>>>>>>>>> +     unsigned int i, j;
>>>>>>>>>>>>            int r = 0;
>>>>>>>>>>>>
>>>>>>>>>>>> -     if (adev->vcn.harvest_config & (1 << i))
>>>>>>>>>>>> +     if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
>>>>>>>>>>>>                    return;
>>>>>>>>>>>>
>>>>>>>>>>>> -     for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>>>>>>>>>>>> -             fence[i] +=
>>>>>>>>>>>> amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>>>>>>>>>>>> +     for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>>>>>>> +             struct amdgpu_vcn_inst *v = &adev->vcn.inst[i];
>>>>>>>>>>>> +
>>>>>>>>>>>> +             for (j = 0; j < v->num_enc_rings; ++j)
>>>>>>>>>>>> +                     fence[i] +=
>>>>>>>>>>>> amdgpu_fence_count_emitted(&v->ring_enc[j]);
>>>>>>>>>>>> +             fence[i] += amdgpu_fence_count_emitted(&v->ring_dec);
>>>>>>>>>>>> +             total_fences += fence[i];
>>>>>>>>>>>> +     }
>>>>>>>>>>>>
>>>>>>>>>>>>            /* Only set DPG pause for VCN3 or below, VCN4 and above will
>>>>>>>>>>>> be handled by FW */
>>>>>>>>>>>>            if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
>>>>>>>>>>>> -         !adev->vcn.inst[i].using_unified_queue) {
>>>>>>>>>>>> +         !vcn_inst->using_unified_queue) {
>>>>>>>>>>>>                    struct dpg_pause_state new_state;
>>>>>>>>>>>>
>>>>>>>>>>>>                    if (fence[i] ||
>>>>>>>>>>>> @@ -436,18 +442,18 @@ static void
>>>>>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>>>>>>>>>>                    else
>>>>>>>>>>>>                            new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>>>>>>>>>>>>
>>>>>>>>>>>> -             adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
>>>>>>>>>>>> +             vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
>>>>>>>>>>>>            }
>>>>>>>>>>>>
>>>>>>>>>>>> -     fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
>>>>>>>>>>>> -     fences += fence[i];
>>>>>>>>>>>> -
>>>>>>>>>>>> -     if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>>>>>>>>> +     if (!fence[vcn_inst->inst] &&
>>>>>>>>>>>> !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>>>>>>>>> +             /* This is specific to this instance */
>>>>>>>>>>>>                    mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>>>                    vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>>>>>>>>>>>>                    mutex_unlock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>>> mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>>>> -             if (adev->vcn.workload_profile_active) {
>>>>>>>>>>>> +             /* This is global and depends on all VCN instances */
>>>>>>>>>>>> +             if (adev->vcn.workload_profile_active &&
>>>>>>>>>>>> !total_fences &&
>>>>>>>>>>>> + !atomic_read(&adev->vcn.total_submission_cnt)) {
>>>>>>>>>>>>                            r = amdgpu_dpm_switch_power_profile(adev,
>>>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
>>>>>>>>>>>> false);
>>>>>>>>>>>>                            if (r)
>>>>>>>>>>>> @@ -467,16 +473,10 @@ void amdgpu_vcn_ring_begin_use(struct
>>>>>>>>>>>> amdgpu_ring *ring)
>>>>>>>>>>>>            int r = 0;
>>>>>>>>>>>>
>>>>>>>>>>>>            atomic_inc(&vcn_inst->total_submission_cnt);
>>>>>>>>>>>> +     atomic_inc(&adev->vcn.total_submission_cnt);
>>>>>>>>>>> move this addition down inside the mutex lock
>>>>>>>>>>>> cancel_delayed_work_sync(&vcn_inst->idle_work);
>>>>>>>>>>>>
>>>>>>>>>>>> -     /* We can safely return early here because we've cancelled the
>>>>>>>>>>>> -      * the delayed work so there is no one else to set it to false
>>>>>>>>>>>> -      * and we don't care if someone else sets it to true.
>>>>>>>>>>>> -      */
>>>>>>>>>>>> -     if (adev->vcn.workload_profile_active)
>>>>>>>>>>>> -             goto pg_lock;
>>>>>>>>>>>> -
>>>>>>>>>>>>            mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>>> move to here:
>>>>>>>>>>> atomic_inc(&adev->vcn.total_submission_cnt);
>>>>>>>>>>> I think this should work for multiple instances.
>>>>>>>>>> Why does this need to be protected by the mutex?
>>>>>>>>> hmm.. OK - no need and it is actually better before the mutex.
>>>>>>>>> David
>>>>>>>>>> Alex
>>>>>>>>>>
>>>>>>>>>>> David
>>>>>>>>>>>>            if (!adev->vcn.workload_profile_active) {
>>>>>>>>>>>>                    r = amdgpu_dpm_switch_power_profile(adev,
>>>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
>>>>>>>>>>>> @@ -487,7 +487,6 @@ void amdgpu_vcn_ring_begin_use(struct
>>>>>>>>>>>> amdgpu_ring *ring)
>>>>>>>>>>>>            }
>>>>>>>>>>>> mutex_unlock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>>>>
>>>>>>>>>>>> -pg_lock:
>>>>>>>>>>>>            mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>>>            vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>>>>>>>>>>>>
>>>>>>>>>>>> @@ -528,6 +527,7 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring
>>>>>>>>>>>> *ring)
>>>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
>>>>>>>>>>>>
>>>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cnt);
>>>>>>>>>>>> + atomic_dec(&ring->adev->vcn.total_submission_cnt);
>>>>>>>>>>>>
>>>>>>>>>>>> schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
>>>>>>>>>>>>                                  VCN_IDLE_TIMEOUT);
>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>>> index b3fb1d0e43fc9..febc3ce8641ff 100644
>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>>>> @@ -352,6 +352,7 @@ struct amdgpu_vcn {
>>>>>>>>>>>>
>>>>>>>>>>>>            uint16_t inst_mask;
>>>>>>>>>>>>            uint8_t num_inst_per_aid;
>>>>>>>>>>>> +     atomic_t                total_submission_cnt;
>>>>>>>>>>>>
>>>>>>>>>>>>            /* IP reg dump */
>>>>>>>>>>>>            uint32_t                *ip_dump;
