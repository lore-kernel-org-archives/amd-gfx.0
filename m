Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7197ACA0EE4
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Aug 2025 12:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1306A10E884;
	Thu, 14 Aug 2025 12:11:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tmpxUwf5";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E910110E885
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Aug 2025 12:11:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLY0uJ520lv4oGq1TfAcgUOGIioqqjPKStkRJlC4kR/WUYqrOR5PytXPIcvEupCcs10ryak95dPccSudJZ4wi9wdPEsloutTOt4/YVjZiGJTpWmqvwBRKGqTHfoBohPPIK2kBKRyHbRBrsikRp4qU8XNODwnjXRzEY4yGQwtrKLypXefJU9xIsXyYrF9vniL/a3ObCy4e3NpPmqoX3C8UG1nTnD7LkaDk3HSyLitkhkaHxC8cAGghxsUXG5EzpgovjHRZ9ucIQfY1Hc25SRaDub9C3BV1fw1QSfs2cNhQ27aXWp+iB5iwDeDyp5ThSvF0EpgR3Fjp4gfG4XNiWnrAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGsUGMU1StCM0RxfEqcn9a1X0N4kzWNXiqImLGQvAqs=;
 b=rWYOFkg/sOgPsPLpBAMk0zfZdcNxM2qzNcr/oVXTdT9sHfrVgai3siGSXT+j6nfk/lfPXuQ4qSNaKahFTeNeanEyfCIlesLJ2CbRe7GrbJJ8ivzdwe/ZHH/E7HkKIX2EvrJjXuuaJJiq24uD/Sgi57wjm4mpOgqqrGtg+hPkdhayi7EZfyIyRFG51x4l9LbhtTJajLC9p8i/CXiquqc5+JEEWmG4PkA+Iu4UZVN4ILQA/0DMFkJoDVQK/bf61sNqoRyoN1UZT50NuapVtowpaUt99/ohVwhBLRPTGFSwrzv+go7MqMeeH/XTWVPSn0B41kp7Xj858cogzJI9s9fyDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGsUGMU1StCM0RxfEqcn9a1X0N4kzWNXiqImLGQvAqs=;
 b=tmpxUwf52O+SSVTCPGlir51YmwAnoTvBG47Mxcpeapa9+0pwfv6/OPtDYZulwxacpUwKpsB14JVKQVjFW/v+A9HzJtjwCn6le0Zq+5tt8ugItsmzHRQOOGWdN4ibfwgbVMpI3gt1XK22G3B5w9jq4drS5ul7wp2OJlPgSbfJzEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7334.namprd12.prod.outlook.com (2603:10b6:303:219::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 14 Aug
 2025 12:11:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 12:11:47 +0000
Message-ID: <7da7e262-bd03-4b37-a6a2-a0a8818e9a4e@amd.com>
Date: Thu, 14 Aug 2025 14:11:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/14] drm/amdgpu: validate userq va for GEM unmap
To: "Liang, Prike" <Prike.Liang@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250808062910.1613453-1-Prike.Liang@amd.com>
 <20250808062910.1613453-14-Prike.Liang@amd.com>
 <CADnq5_Mavhnw4r-RZcdYYEtYtdRuh5LEbKHVNZ6gz9vt5_jQ6Q@mail.gmail.com>
 <DS7PR12MB60058D4062634C314622FC69FB35A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB60058D4062634C314622FC69FB35A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: e120b74f-a730-4f66-a38a-08dddb2bbe28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmFCaFVpSmcyMW51aUovb1RhMlcxWUpWZnZZUGdycDRjOFRtczg5bUIreFpM?=
 =?utf-8?B?WEhGcjRQWjhWS1ppL3lkVE1qNEhkSHp0cXZLZ1ZEWVpqbW5HUVJZOWF2NC85?=
 =?utf-8?B?eGJxMzY1d2JWMDhlTWJVOFlLUm5ZYjUvRmM0RC9haVEzckJncUFQN2ZmYXJq?=
 =?utf-8?B?N3pSMGVpVGNaajdXNlFySHdNbzNGTXQ4eTFPbHYxU3c3QWtWYVBPZTBOVDgy?=
 =?utf-8?B?ZmRxcDhRQ0p6a09FV1VidnhiZEhoM25odUI0SlNkYVFEanhlMHc0bTIxbkdN?=
 =?utf-8?B?WmJtNTU4Zk43aTNFcGl0dk12eXNJU0p3UjVUYzR2bGJ2L1JQdVZXSlp4cE80?=
 =?utf-8?B?TXhPNGJqdmxHWjlBUThmeFpZVkxpZGFaRTc1N1BiNUdXOC9OVHFmT2xqbklm?=
 =?utf-8?B?L3RGdE84S0l6NlVXWlJyUnp5Q256UzdjVjd2bjhNTW1hZUYrRGUyQjdtWVp1?=
 =?utf-8?B?dXJ0b251T0YzdG4zNzR0WnJvZzBoOW84QVpkT3Fablp1NXBtU2c2K0RLOUJu?=
 =?utf-8?B?WXJsM283MXp5eTU1U1VqS21tTzJ0YzBPeVhqQzdwOS9wZEVWd21HTEhsNlRB?=
 =?utf-8?B?eFJ4c1VtelJVWDRiQlpWeXZ5Qm8xVWZscGV5ajZpUlp3WHYxVzROV0JoSXlO?=
 =?utf-8?B?czFtT0dwYWwzb1Q1TkFvWnFCci9DMkNiS0pwSEZ2ODlHVjJuT3ZLOW81eWtO?=
 =?utf-8?B?cDJycExqbkZuS1ZML0ZiR1lmTCtsOXBpcmU5Tm9pQTlsdStFRHk5ME4vejdO?=
 =?utf-8?B?Q09nYXZzRUlRaHByeU5wcUFjVkpRaTJ6djkxdkdyV1NiSmhrVWRVNUZWWHpK?=
 =?utf-8?B?d0NXMGlseHZucGtnYXN3V2k4NFNWVHJrVU8zUkgxMnBoSEtERXE3SW9lUFFU?=
 =?utf-8?B?blNXYWxmK1NleGovNzR5VTlYT1hHNXhIMGJzZUVOaVZOK2FoRDRPZmNneHdJ?=
 =?utf-8?B?aGNIRjBSdEpjMVkzOGpEc2lvSzA0ZHJFVGFpZHJzOHVtQ1FUVzlEZDZTTDZY?=
 =?utf-8?B?WWJ2UHNWa2N4bGFiU1RsRVJlMEc1QkpVQnBvZE41R1R3YTk2cVdnbWlKT1RQ?=
 =?utf-8?B?QWpHTTNJUVpRUFJPMXovakhkSnZibU0ycmVOOVIyZERRUGVKall1N0JHTm5J?=
 =?utf-8?B?T2E1TkJNU1JQZEZSOUdMQ1B4bklmNlY5czlSdUdSZzFXalk5am95NVZCamtC?=
 =?utf-8?B?bXlHUVJ5RmhpcnpRUjJCWWw4Z3pEYnRLNVNBUWJhbERMR1pWZXRlZXhoR3N6?=
 =?utf-8?B?Y094S1JNTTkwNmdRM1pycXZ6WURuMFpkczhSK0cxeVVacFRDdG1UMDVpNWhM?=
 =?utf-8?B?NVVDU2RXRU96RE9tdkg4RWpDbGEvT0llQmR5V1FPSk1VcW01Nlk3SDY3bE1r?=
 =?utf-8?B?NWJZRk41S255Zi9Oa0t6UmFBVno5d2svNWdWTm5TN1Q1ZlFjMm5RbDI2MlBj?=
 =?utf-8?B?Y0xoSklsTG5ueTV0bWZTWDhHV0ozZmdoRGVOUG41cWhJTjN2bktvY0hNaDJH?=
 =?utf-8?B?b2dWem9QVW92Z0VXSHk2WnpBeWNiZDQ3WEV2Z0dBL3A3cXFxaEw4RUVLUFU5?=
 =?utf-8?B?ZFhGZGJtVXhZQWNOdzFOQ1M1bXpLR3ZNOVhDOGdzWGx3RU1WaFNaeVRFenIx?=
 =?utf-8?B?WEtTK2FqdWFuY1dEdHhSQVlORk5MZHNpaEUvKzRvSmN6UERRcS9WODBpWk1k?=
 =?utf-8?B?eG9nMktIdXJHNU5ENVpBeitEeFRvM3NvQ3Y1a2kxSnFjS3BPYXFmWlJab2ov?=
 =?utf-8?B?M0FsQzk0YldyOFJJd3JBcnRWbFVPdmpsaEFyVEFjU3BjY1kybk44V1BZbE10?=
 =?utf-8?B?YzFVVWwvbUdPOUNTcWJnc1ZmbG5GUEM2Ry9DWWdOV0ttcW9VYUt4RHJ6RlYx?=
 =?utf-8?B?bVZSS3dsMlh5bTV3UUFjeEFQZjgzVVl5cEpZbnVoeEVySjBDU2RLcEtBV1N0?=
 =?utf-8?Q?Sg5VJShLXEQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVJCMG53Q2FyWlhsbHVrQUk2TTVDV05qNkR0OXJDUmNWRmw5ZENVQXJLdmlN?=
 =?utf-8?B?WlZRUlNtNTE2UUJHNlBoQStJSWtzQmxIRlozRVZERXIyUlpibmRDSlh5TFlC?=
 =?utf-8?B?ZEgyM1VYVXEwVEhDWnB5Y2hVYnl3R3h3b2JCazBoYTRhbnFTOGNZWDl2bGI2?=
 =?utf-8?B?QUxxR1lMaWVGZStnSEJoV1VLU1NrRnhad1lLeWhXZnFySUdVeEpHN0NWZ0hB?=
 =?utf-8?B?SUVkS2cwQWR6SW9UNGw2a3U2ZFRXTzlKQlFmNVc2RHRVRTQ1STJXV3FZQXla?=
 =?utf-8?B?cG10QVRUNDZSK05GRUdjQk82bkh5SVhqRERSaXlqVjlxVTgwSC9QZW1heitL?=
 =?utf-8?B?eHk5SG9WWDhMTEVibjZMdXR6bFp0dHZTTmRmcW5hWmZMUStYZGpBRnlvZk1j?=
 =?utf-8?B?cngrK0pSRFprNW1kRndPQm5mczRCZXMydUI4VXlMRlpXSC9maUF1YzN1ZjV1?=
 =?utf-8?B?NzMyQUkxb2ord01aUHZjWlZwYmZYN0FvWmtOZm85ZEpLOC8yYmdpWUZpWldY?=
 =?utf-8?B?bXpuZzQrMWw4elczQVBnWUM5cU1aWnRYMldkRnh0TXZBK011YSt1Y0R6K2w3?=
 =?utf-8?B?TmR1cnN3c0dWbnZzTkZhSHhOWHZsMkNyVGQ1REpzODcyUHpMT01ramZpZTdI?=
 =?utf-8?B?L1N5QVp0aU5UWnZQZlFRMlREM2JVVGs0SlFSemJTaHUvV0d6bHRTa3BLUjMr?=
 =?utf-8?B?TC9VSldGcmlleXF5WlZXOXprOE9HRmZnbWJHYStvK2RNMk51MnI4V1dFNmdK?=
 =?utf-8?B?bnVCR1ljdjJYbUhQdmRUeHZRYTBPMm0yK2tYREh1ZHRvTGZyd0M2Mlg5VjBD?=
 =?utf-8?B?SDNXNU1VWldFV3RiRTR5WWIyc0c1ZENteDZxZ1lWWDVQSTBRQlNIcExSSlFu?=
 =?utf-8?B?YllLajJmTWVKVUdUTVFmbDJIcjM1RFFJRitOd05ESmxkOUd4VFZNaEg3bUhJ?=
 =?utf-8?B?K2J2ZHU4ZWJOZTEvZ1NQVTFUTXFwNEpuUkNZNm9VVWxsQVdpUTd6Skx6Ujh1?=
 =?utf-8?B?WG1YV0FIdHltQkEyQUlEb1NFd1dyK2YrQUo2cmxVWHRBang2VzVERkhkbDRG?=
 =?utf-8?B?TWlaNW5wcUw2R1VZVytIeGVUejBnK21NNmRqZVlidWVVa25Nall1TFJWN0xS?=
 =?utf-8?B?N2FiOCt1Z0tDaGE4WGZ1VjFrM2ZBUmliZ2RvOWtZTFJ4THg2SWtoZTlxNkVE?=
 =?utf-8?B?Y2d4YzZoK2dFdDN2NmZ3U01uQW1RRytZRHdBWUhsWkJhbFZxK2RaYU8vM2o0?=
 =?utf-8?B?SFZFVGpKUGR0UnJtS3dyL1hOV2V3WHlTUlQvUFA5MUNMNHV4cVhPdnpicGQ1?=
 =?utf-8?B?UVFjamd1Nktpd0JQZW9BNGI3ZlREQ2NtNm9OKzF6dGZGWHBsK1V3Qm9EZ0Q3?=
 =?utf-8?B?aHpuZ1NKRVJIVmhEcHJ5SVM3em5pSGVMWmZkTmE4aXU0VFZ2ejBiamJUWWo1?=
 =?utf-8?B?Rmh1c1hLU05RTCsyUGcvVUNmdjEzTnQ5RDM2cFdsMHdUbXJnVjk2NSs3Zloy?=
 =?utf-8?B?UzJKRzl4ZEFURFpodWttQ2FLL2pJRXNXQ0NmSFdIYjdvVytXVlpKSmsrSjYw?=
 =?utf-8?B?RWpCTGU5ZU9GdktLTVpvbTJqWDJGdWRVUnltaWJ1UWFVZkxjRCtNZmpIVGVL?=
 =?utf-8?B?U0c5S2d4Z0hYT3gyQjY4N3JqM1VnSXh6QnBORUo1Qk5iekdqWElHdEM4ZmhU?=
 =?utf-8?B?NVhXU01uV3RGSkczN2U5aWVGRU5tTlhhSjY1WXpIdzlPblpTMmhjWVc3d2dr?=
 =?utf-8?B?V3pWVlBDVVR1RzlUMnhZb3YvV2I3RWFBbVl0RkVIL1VqbVVNYWNYSCtNRDJw?=
 =?utf-8?B?bDRIVHE1R0xLOVRzOWhkaTl1V0VJdHBkYmIvSHl5cnZYRGhSdXZlRlNJUlll?=
 =?utf-8?B?TlEwaHljZzJwMnphSkxPV2ZuM2tUTXRucmFPUzYwVWRqdEwxbVpLZTdPNUtQ?=
 =?utf-8?B?eXVZRWNRRHF4aHFWcHRDMTB4THAwRHY1QXhTSkhMOHo1clpSeVFoU2FLTzJD?=
 =?utf-8?B?UUFFeWJJVlhNY2VXcDdJbGt4OVA4MkVmYzFzRGJibmdBaTBEVC9Pc1dsY3Zo?=
 =?utf-8?B?cms2MWxEQjIyTFp6VjFEVDNXV0tsMzBOMlFZTmxDbFBPbGRCKzJ4d2l5d2pw?=
 =?utf-8?Q?3h2Q3gFqBOt/wEOYJgYwktvbq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e120b74f-a730-4f66-a38a-08dddb2bbe28
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 12:11:47.8334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1k3P1bvqPymbOlJAxmo9JE2pgX6Qv+WG0P3EOVFsnY0fNCGYWjmPihP3xU2zDSiA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7334
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

On 14.08.25 12:35, Liang, Prike wrote:
> [Public]
> 
>> From: Alex Deucher <alexdeucher@gmail.com>
>> Sent: Thursday, August 14, 2025 6:38 AM
>> To: Liang, Prike <Prike.Liang@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>> Subject: Re: [PATCH v8 14/14] drm/amdgpu: validate userq va for GEM unmap
>>
>> The start address may not align with the start address of the vital
>> queue buffers.   Just retain a list of vital virtual address ranges
>> for each userq and then check if the address range the user wants to
>> unmap falls into any of those ranges.   If so, then preempt and unmap
>> the queue and set the status to USER_UNMAPPED or something like that.
> [Prike] Each userq has various virtual addresses, but this unmap IOCTL request can only unmap
> one kind of VA at a time

That is not even remotely correct. The CLEAR and REPLACE operations can unmap many VAs at a time.


>, so do we need to validate the userq whether all the VAs have been unmapped
> before unmapping the userq HW mapping?

No, we need to unmap the userq HW mapping before we unmap the VA addresses.

> 
> Aside from that, do we still need to identify the invalid userq VA unmap case by checking userq fence to
> see whether it is signaled when user is trying to unmap one of its VAs? Without this check, how do we
> identify the userq GEM unmap VA case?

I don't fully understand the question, please clarify.

Regards,
Christian.

> 
>> Then you don't have to worry about queue specific details as to what addresses are
>> vital for that queue type.
>>
>> Alex
>>
>> On Fri, Aug 8, 2025 at 2:29 AM Prike Liang <Prike.Liang@amd.com> wrote:
>>>
>>> This change validates the userq to see whether can be unmapped prior
>>> to the userq VA GEM unmap. The solution is based on the following
>>> idea:
>>> 1) Find out the GEM unmap VA belonds to which userq,
>>> 2) Check the userq fence fence whether is signaled,
>>> 3) If the userq attached fences signal failed, then
>>>    mark it as illegal VA opt and give a warning message
>>>    for this illegal userspace request.
>>>
>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 107 +++++++++++++++++++++-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |   2 +
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  10 ++
>>>  3 files changed, 118 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index 771f57d09060..314d482849c8 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -676,7 +676,6 @@ amdgpu_userq_create(struct drm_file *filp, union
>> drm_amdgpu_userq *args)
>>>                 }
>>>         }
>>>
>>> -
>>>         args->out.queue_id = qid;
>>>
>>>  unlock:
>>> @@ -1214,3 +1213,109 @@ int
>> amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>>>         mutex_unlock(&adev->userq_mutex);
>>>         return ret;
>>>  }
>>> +
>>> +/**
>>> + * amdgpu_userq_gem_va_unmap_queue_retrieve - find out userq by gem
>>> +unmap va
>>> + * @queue: destinated userq for finding out from unmap va
>>> + * @va: the GEM unmap virtual address already aligned in mapping
>>> +range
>>> + * Find out the corresponding userq by comparing
>>> + * the GEM unmap VA with userq VAs.
>>> + */
>>> +static bool amdgpu_userq_gem_va_unmap_queue_retrieve(struct
>> amdgpu_usermode_queue *queue,
>>> +                                                       uint64_t va) {
>>> +       va = va << AMDGPU_GPU_PAGE_SHIFT | AMDGPU_GMC_HOLE_END;
>>> +
>>> +       switch (queue->queue_type) {
>>> +       case AMDGPU_HW_IP_GFX:
>>> +               if (queue->queue_va == va ||
>>> +                   queue->wptr_va  == va ||
>>> +                   queue->rptr_va  == va ||
>>> +                   queue->shadow_va == va ||
>>> +                   queue->csa_va  == va)
>>> +                       return true;
>>> +               break;
>>> +       case AMDGPU_HW_IP_COMPUTE:
>>> +               if (queue->queue_va == va ||
>>> +                   queue->wptr_va == va ||
>>> +                   queue->rptr_va  == va ||
>>> +                   queue->eop_va  == va)
>>> +                       return true;
>>> +               break;
>>> +       case AMDGPU_HW_IP_DMA:
>>> +               if (queue->queue_va == va ||
>>> +                   queue->wptr_va == va ||
>>> +                   queue->rptr_va == va ||
>>> +                   queue->csa_va == va)
>>> +                       return true;
>>> +               break;
>>> +       default:
>>> +               break;
>>> +       }
>>> +
>>> +       return false;
>>> +}
>>> +
>>> +
>>> +int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>>> +                               uint64_t va) {
>>> +       u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
>>> +       struct amdgpu_usermode_queue *queue;
>>> +       struct amdgpu_userq_mgr *uqm, *tmp;
>>> +       int queue_id;
>>> +       int ret;
>>> +
>>> +       if (!ip_mask)
>>> +               return 0;
>>> +
>>> +       /**
>>> +        * validate the unmap va sequence:
>>> +        * 1) Find out the GEM unmap VA belonds to which userq,
>>> +        * 2) Check the userq fence whether is signaled,
>>> +        * 3) If the userq attached fences signal failed, then
>>> +        *    mark as invalid va opt and give a warning message
>>> +        *    for this illegal userspace request.
>>> +        */
>>> +
>>> +       if (mutex_trylock(&adev->userq_mutex)) {
>>> +               list_for_each_entry_safe(uqm, tmp,
>>> + &adev->userq_mgr_list, list) {
>>> +
>>> +                       if (!mutex_trylock(&uqm->userq_mutex))
>>> +                               continue;
>>> +
>>> +                       idr_for_each_entry(&uqm->userq_idr, queue,
>>> + queue_id) {
>>> +
>>> +                               if (!amdgpu_userq_gem_va_unmap_queue_retrieve(queue,
>> va)) {
>>> +                                       dev_dbg(uqm->adev->dev, "va: 0x%llx not belond to
>> queue id: %d\n",
>>> +                                               va, queue_id);
>>> +                                       continue;
>>> +                               }
>>> +
>>> +                               if (queue->last_fence && !dma_fence_is_signaled(queue-
>>> last_fence)) {
>>> +                                       drm_file_err(uqm->file, "an illegal VA unmap for the
>> userq\n");
>>> +                                       queue->state =
>> AMDGPU_USERQ_STATE_INVALID_VA;
>>> +                                       ret = -ETIMEDOUT;
>>> +                                       goto err;
>>> +                               }
>>> +                               /*
>>> +                                * At here still can't suspend the userq since here just one
>> kind of
>>> +                                * VA unmapped, and some other VAs of userq may still be
>> mapped. After
>>> +                                * this point this VA mapping will be deteled and the VA will be
>> unmapped
>>> +                                * so will not resume the userq when its VA unmapped.
>>> +                                */
>>> +                       }
>>> +                       mutex_unlock(&uqm->userq_mutex);
>>> +               }
>>> +       } else {
>>> +                       /* Maybe we need a try lock again before return*/
>>> +                       return -EBUSY;
>>> +       }
>>> +
>>> +       mutex_unlock(&adev->userq_mutex);
>>> +       return 0;
>>> +err:
>>> +       mutex_unlock(&uqm->userq_mutex);
>>> +       mutex_unlock(&adev->userq_mutex);
>>> +       return ret;
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> index cf35b6140a3d..27ab8a6a7be6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>>> @@ -149,4 +149,6 @@ bool amdgpu_userq_buffer_vas_mapped(struct
>>> amdgpu_vm *vm,  int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm,
>>> u64 addr);  int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
>>>                         struct amdgpu_usermode_queue *queue);
>>> +int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>>> +                               uint64_t va);
>>>  #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index f042372d9f2e..533954c0d234 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -1929,6 +1929,7 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device
>> *adev,
>>>         struct amdgpu_bo_va_mapping *mapping;
>>>         struct amdgpu_vm *vm = bo_va->base.vm;
>>>         bool valid = true;
>>> +       int r;
>>>
>>>         saddr /= AMDGPU_GPU_PAGE_SIZE;
>>>
>>> @@ -1949,6 +1950,15 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device
>> *adev,
>>>                         return -ENOENT;
>>>         }
>>>
>>> +       /* It's unlikely to happen that the mapping userq hasn't been idled
>>> +        * during user requests GEM unmap IOCTL except for forcing the unmap
>>> +        * from user space.
>>> +        */
>>> +
>>> +       r = amdgpu_userq_gem_va_unmap_validate(adev, saddr);
>>> +       if (unlikely(r && r != -EBUSY))
>>> +               dev_warn(adev->dev, "Here should be an improper unmap
>>> + request from user space\n");
>>> +
>>>         list_del(&mapping->list);
>>>         amdgpu_vm_it_remove(mapping, &vm->va);
>>>         mapping->bo_va = NULL;
>>> --
>>> 2.34.1
>>>

