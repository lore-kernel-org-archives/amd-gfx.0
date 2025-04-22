Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9582C369C2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 13:26:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 874F010E5A6;
	Tue, 22 Apr 2025 13:26:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3hZJhV0Y";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 448C310E5A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 13:26:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=on8akIjZ5p0w4VTV0CSOCTtGJTXedURWpEsWcBd4ns2vaJK8LDHvB57Zam6xBGTHppXmOw6sP2pjwf46jdVjdr/J3KuANG0iURrWJMBJBpN+qn84FxQ59iXsclT37UDNu3/unLJz8PO+WNstxzHaHu+dlNP1hNVn0UWl7IpdSlfuRRU/GVkJBL8bjpGU5bif6DegO4kO093gjGqV6e8DdWuhIFozeZiBsDr+Q+9vjbIpf1oEUpQfCrTKwRVgO6/4/eQfHaCn3zA0N089mQzdYLAARVUMC2n+M5V33HyEJjhRNim+rMRZ2HEv29bsKcYOaqus5rPlBqKQG0GNOfN3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvU/rYv3gM+m1x/YN09HkYk+XRffBARUkxPir1cAMP0=;
 b=GpFnG+Cy8CobAM9f3BPOptfLDtjCtlyh8i8rBa83xj4Rp7Vq9svJBMHnMP7DhAV/zXK1Npls9asb9aW6eUnBnZefJA6u64rQdewVnSVh8DUCTos8iebjeih16jJ3DmSzIpE2fRAnDmJeIt2YNNUL+ewjoERHzeV47YeaZGCDid8p7Pf3KrS5anKmBOg6/2RiPU68uKnAs5aPJFx3EQNSB48N13FMMZ/gbhO1jL3mVoHLF/yX6im2BCIuJms93fVW82zELaX7ajFxLq+bESDnqFll8zxNc5F/N4+uwsRWJF7/LKShX55XjJtXqhCAzBciT/RNf1um7Xm2V2H2D+khKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvU/rYv3gM+m1x/YN09HkYk+XRffBARUkxPir1cAMP0=;
 b=3hZJhV0Y0Gb8c9g0NZZlhgtom4xIyudoehSd0UNfyIYu9/q5o88/oFpcx45bD4U4YVFASl5NXtpmYQafq4SEtQkghHoUrx7KmHq0obg5fhB7a0Uzd/avZPqd5kN4N32Yt0r0hOU9+4jSqeATOF6y8sTEqTTLawnXSGndohDLKtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Tue, 22 Apr
 2025 13:26:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%6]) with mapi id 15.20.8655.025; Tue, 22 Apr 2025
 13:26:11 +0000
Content-Type: multipart/alternative;
 boundary="------------zfNzX6sH0T0MULTWIkksdOQI"
Message-ID: <bde5ab23-bb48-4b67-b8b9-6abf08fa2d29@amd.com>
Date: Tue, 22 Apr 2025 15:26:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdgpu: free the evf when the attached bo release
To: "Liang, Prike" <Prike.Liang@amd.com>, "Yadav, Arvind"
 <Arvind.Yadav@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20250416085029.2278563-1-Prike.Liang@amd.com>
 <20250416085029.2278563-4-Prike.Liang@amd.com>
 <366de5ed-2234-45e6-9c2a-d21e83899b7b@amd.com>
 <DS7PR12MB60059F4F5364FEA720438EB2FBBD2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <1a4990eb-a0cd-43fb-95aa-19dcae93e03c@gmail.com>
 <DS7PR12MB6005329D20C8DE2367BDEC8EFBBB2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <95986ce1-558c-4233-a769-bd08d2478538@amd.com>
 <dc72b56f-64a0-ff58-8d4a-4a8fbc870100@amd.com>
 <DS7PR12MB60054D6296012455E53B72E3FBBB2@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB60054D6296012455E53B72E3FBBB2@DS7PR12MB6005.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR3P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 4917e2fc-a9bf-41b6-5231-08dd81a13fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFRPakxTSTh1QTRnMnFWUlN0aWxBZG1qSUtyWVE5Ym1NK1cxR1U5NUw3OHlT?=
 =?utf-8?B?N0hrWHAyZnNTRndDN3NXMVBvRERVL1VKZ0ZDZ3FzVUFVcG5vSERwdG1SNzVE?=
 =?utf-8?B?TWRldldpcURmTktFMWcxYmRmN2UxcUMxMnJ6VnY2VmIzcGxLdlQza0JkNHZM?=
 =?utf-8?B?L2hoNFYrV1oxZ00wWnU4aXZEZGtiZmlRaWF0ZTFRS0oxNkpaWExmVUpWWHE0?=
 =?utf-8?B?OCtFMTFoNnNydzJHeVpVaVFqWlJ0OUxMN2tUUEhWWVo1akFvRERhcTg2N2Iw?=
 =?utf-8?B?dGF0cXZ5RW9UQkRkM2g0TTE5ZmJaVnREN0RyT1JyVUVtMEpkWHBKdmpjRk9S?=
 =?utf-8?B?ajZnK1hFN09kd2NyMGRyVlBpMXJWUnM0ZnFDQzFwbTI4R2Z3MzR1a3BsSVNw?=
 =?utf-8?B?c01YRFdyVFNtSXB6QkNiN0ZSdktIbDV1TDRST0crUXZqeDJQWDBxbjliQ21S?=
 =?utf-8?B?SFFUNXFPRGFFR0pxcnNMWE1zeXFjeFIrZGhZc0I4NzBYekNQaXRuZEUvcmE1?=
 =?utf-8?B?VDVKZkhSSEJ1N2VoUXRTTVV2cmVWd2VYZDhBMWczMm9DWHZiMkM1algwTnJU?=
 =?utf-8?B?OFBVVURrQThneUFzYUo0UnZzTmM2eDZvK1J1a2ROcXJULzdNdlZtMGR4bVZH?=
 =?utf-8?B?aG5PU0VkRTVrOWFFYTNwRnUyWmtudzFyZXFhZ1ZIZU42ZUppT3p4bzRueW13?=
 =?utf-8?B?dnIvNGFEaXUxZFFsWGpSVldWY0cwMDUrcEpUR1UwazVnSkpmZGhycmI5TVkv?=
 =?utf-8?B?M0txRHcyaVF3a0orZVZDM2ZOWExnUjVmL1pwVTBkbExsTnlOWm9mdnA0eUdi?=
 =?utf-8?B?U1FwU2dOOTNrRFZVbXBoa2JkSkEwclhtVVd3RDBsb2VDalMraDdiU0hXbWdh?=
 =?utf-8?B?QmZyVlQvbittcWh4SDVXa1ovMCtGV2xLZGVSYyszRzJpY0M3QklxaVFqTmNT?=
 =?utf-8?B?YzFFdkxPL2ZQVW1ZeHFLaEoyWEgremtCMjE5akJ4QWhJcjhzL2dXOVZFcFpW?=
 =?utf-8?B?MlJTRSs4Q2pFc1FialljREdaQThQb3FBbmJYa3dxRXo1YjNqVlNDZzVtbXoy?=
 =?utf-8?B?YUxja2Y5U0psSDBKSHJTa3BPSldrNEhleXQ2TjhMUFoxVHhOUEV4UVY5enJt?=
 =?utf-8?B?WXlPblpZTk5jOVl5QmtKK2RQNGxrZXpYYlR2NVVBOS9PeFkrY2xWb2h4ZHIx?=
 =?utf-8?B?Q0wxWHNJZEtiMHpXVG9uM0VhWGY5T2ZFYyttVHY3bkFaUm40VUsrVFY4MWhq?=
 =?utf-8?B?N05YSzRkcU9oWVMwZk9Ya1JoNG5xS3daRm9zVWJUeVVyWVg4eTRqUGJOOURy?=
 =?utf-8?B?d3YvOFhCTS9JbjI3MmtBS245MFBUTHdrd04ySDArOEhIZVRrYjU0bWJpckp2?=
 =?utf-8?B?V3pzbThpMjBRaWdsZmZPUGpQNWdVWG9RQ2FvOXNrVmhGT3lEdDFZN1NtekRz?=
 =?utf-8?B?TEhpSVN3dzQ2Z0xYdDhCNU9CVVE4cXBFNlp1eDhNZTJUK0hhNy95Y252RVZZ?=
 =?utf-8?B?RThFclIwUzVTdStrZG55OGZGMVdWK2Z6MFRFSXRPTnZobFV0VkFrL3hJU2ho?=
 =?utf-8?B?d2I3Wk5sVWtFR1p3RGF5V1JsN1dEQkVWbk9IRmVNaWh0Y0dsQ0J5UTNPVVo3?=
 =?utf-8?B?S0Z2amZDQVcrQktIWnJRUVF6cm5lWEFvZHJwcTJ1N2xzUVkwbTVjcy9mL1lJ?=
 =?utf-8?B?STRvQSs0THExbTdnZnpCV3hZVFZHVWZTQkJYVVFLbmRGYWsrejhMRTVTWkUx?=
 =?utf-8?B?bVhERVNTb2Npc1RjV0QrbjA4RGxXSU1xZXM3UUdNaVZXT1lmcUdPalpsVldq?=
 =?utf-8?B?UWRDdlBUcmdueVZBb3Rna2dUc0UxRklJeUhoc0dVbVZkckNiekV0aTdzZDZu?=
 =?utf-8?B?S1A0Sll1REhmcTN1WnJPeXRvTEtVTlloZmdzUC9USnRPbDJVaEF2MlBOVXRP?=
 =?utf-8?Q?6kzxdbBFO1U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlV6UHZjVXlCcTZJNEJIcXRqSDE4eG54ejBZSHpBWitGaEN6WHFrQ1gycEty?=
 =?utf-8?B?US9RNEVRNllBSlpBcXlJNUFoOEJ4WTVSVC9GMVZFS08wTk1VZzN4cXFxMlls?=
 =?utf-8?B?N2R0aTVMak1yVUNzY0w0R0gyZEVFZXhkVTd3eTUrTlU0WW9jVVZwRWdmWEhD?=
 =?utf-8?B?Qllxb1lWZTh4Q3FpZ0RkOEJpY1dvZkM4S3ZtMXhxVzIyNWRKd05zZGFhRWE5?=
 =?utf-8?B?ZDQ2RUVid3grVWRtT3FwM3FvczZEbjYwZ3phcEFaN1hlU1dSenJDNDdGK1Vj?=
 =?utf-8?B?VWczdlNRK2Ezd2svamVTd1JaSFpkQjBWc0hPZW5nanZiL2h1SFVLSUsxRk12?=
 =?utf-8?B?QkU3YWhJdlMwRkszNGp2UFZHQmJFRHJaT2hQa0xtaWdsaFFGajF1Qk82cWNF?=
 =?utf-8?B?RzFYT1RTUzBQdUcxbThmTFo1SXhRYnB4U1pKMFFYaG44bzZ1M3pVanY4RkpZ?=
 =?utf-8?B?eVRQZG9qcUJkbThqL2pFcjhTdTNDbHdTTGlneWJsNGpPTUtxMmlRM1BGblNG?=
 =?utf-8?B?NTJOYXVyTldQNVZLa0VKRUpMUktyaHhVYXpRZUkrSFBOdThQMVVZQlBkNVRV?=
 =?utf-8?B?ZTJUc0swUitoNXZZNGlGN2tCUHZWK3JYbHF4dFlobEtYV3lSemo1VE5LNE4z?=
 =?utf-8?B?TVE3UUl2TlkwbEhSNXF5RThoYUlJeWdTd1h6Y1Fva2FWVGN0VUlvOG5CYzZ0?=
 =?utf-8?B?UFBOQVYxRjJ2dHNTOEtQUm1ER3hqYzIrRkN5elorY0JBWHR5WGY1RUpiL0Ru?=
 =?utf-8?B?OUdRdjE3YjhHNjFFTGtYLzg4Um8zdGRJRDVJelhyRGwvKzQxRzZqcVUvSUNn?=
 =?utf-8?B?Zm5tNVRMQ094N3pHbmhldnl3LzdiWVBQVEhCQkFOZXNxSTdvN1NyVEFMdmZR?=
 =?utf-8?B?R2Vqc2pnS01NdEFlSzVUdUdWQTUyS2hXazA3enZwdStPTGpITVpnczM1Mklz?=
 =?utf-8?B?UVljVmE4OGtpaXFCKzNUc1ZSd2Z6QVI5N2QyTmlaRWhzcG1yTmc2NDJjVzlr?=
 =?utf-8?B?WnR6dUIybnZ1d1BSUFRVVkdtRWExZnFlYU4xajBsdnJsVDN1a0QzRnhDWFh3?=
 =?utf-8?B?VGo2eDZma1JPQ2c1d2dNVlVnSS8zQnBBb1RVdVk1RDNjMjhKSlRVNkJadkVR?=
 =?utf-8?B?VGdLbHo4NEVZYU1LMllHcmJjMXZUNm1EbWZLeTgrMldTaFcxWHhGNXd0T0t3?=
 =?utf-8?B?bFk3UU9ST2RJeGsyVHRFWTJldi94N2ljenErUnR2L3NuQlNPcHlqRlFEWjJY?=
 =?utf-8?B?R3F0bGpTVm5XZXNQZHYxVHc2eWVwb3ZrN2c5Wi9na0pJL2s3MlhYNWN3WVpI?=
 =?utf-8?B?dUNVMVpkYmJaZ3ZSY2NidmdPaERoOTFleTBDQm5OK2JOZnBSeFlBN2YzYVh3?=
 =?utf-8?B?bG55cmpYcWJvR0Z5TTBpYjkzSU81a1hoYnhqR0p1blhYODVNc0xoMDJiMXZI?=
 =?utf-8?B?TFZ3bzYwNWszVWRHcEJjZkdPazJ0QmxmcEo1dCtUejlvQmJvZytQcXM0K2Fz?=
 =?utf-8?B?UnM1Z2grYTgrdzd6UTk2NnByUUJYaDZyZmtlb2k1eW9tenJXdjZFNnpVMk1t?=
 =?utf-8?B?L1IvMWQvblROQy9OUGQxRzdXcXZyTTQ0Q3psVnFvd296WFhIWHdSWmlYRllr?=
 =?utf-8?B?Y2FpYzRSUjAwbHQzbjQvQkw1NzN1YldzYVRoZFc3S2RNZ25lQzZaRi8rQUVy?=
 =?utf-8?B?UzdiT2J0bVVXMUxHZGNzRG5vMGJhZmYvYXF6WUlzTTBsZExuRUVXSHJCVXhH?=
 =?utf-8?B?QVRTMzNGMjhJaGlad2hlejgzdjlBZE5CWUJqd2Y3NnpKNmNQOHlIcTl1ZHUr?=
 =?utf-8?B?QVM2NUJSMFNFQ1JDdmlZdDhOampkNzNzY0NBUmRtOUdxOWx6aFdMb2JuNlBu?=
 =?utf-8?B?U3pkSkxtak95eGwvMlhaZW1VMEg5MlRmMk0rTUZzQ2w5N05SL0pDVHJ4TUlY?=
 =?utf-8?B?WThaSkNGRU8yQlVGa0hJUUNRNkNvVjAzeUQ2T2txUCtsR0dHM0RBQjV2anlm?=
 =?utf-8?B?Mkx6VEhqTzBiZUlPSGRvUGdOZ3BqYkVsUTNvQUV2RklUbmt4bXBxTklZbGxO?=
 =?utf-8?B?RnlHdVdDM1pOMFQrSkUzTTEreGY3Ykg5cXRHL3NYMGtyWDF6UUoyQVBZNlVD?=
 =?utf-8?Q?dts6rlNRILfRrmIXrEMR7FJ2S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4917e2fc-a9bf-41b6-5231-08dd81a13fb3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 13:26:11.6390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzkwGjZG/a9/t+CuB1HwM4+ZJ2V8LVZgVGvUS02B06NGDH2p8UMAOXG4bFld7BMl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969
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

--------------zfNzX6sH0T0MULTWIkksdOQI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 22.04.25 um 15:09 schrieb Liang, Prike:
>>> Stop, wait a second. That shouldn't happen at the first place. Why is the eviction
>> fence considered a dependency for page table updates?
>>> When it is added only as bookkeep then we should never consider that here.
>> Looks like something in the sync obj is messed up.
>> It is like this. Here, amdgpu_sync_resv is using
>> DMA_RESV_USAGE_BOOKKEEP.
>>
>>          int amdgpu_sync_resv() {
>>
>>                  ..
>>
>>                  /* TODO: Use DMA_RESV_USAGE_READ here */

That here is the core of the problem.

I've added this TODO item 4 years ago to switch over to DMA_RESV_USAGE_READ here when moved all TTM use cases to using drm_sched_job_add_resv_dependencies().

That was done, but this TODO here forgotten.

>>                  dma_resv_for_each_fence(&cursor, resv,
>> DMA_RESV_USAGE_BOOKKEEP, f) {
>>                      dma_fence_chain_for_each(f, f) {
>>
>>                  ..
>>
>> }
>> during PT update amdgpu_vm_bo_update() is using sync to moving
>> fences(Eviction fence) before mapping anything. Because of this Eviction fence will
>> act as dependency.
> Yes, since the amdgpu_sync_resv() uses the bookkeep usage, then all the BOs reservation fences along with the eviction fence will be returned and added to the sync.

Yeah, but that is incorrect.

> And with the attached patch, the eviction fence can be released properly when the kq and uq are enabled.

We need to fix the underlying bug first before we can work on the next step.

Regards,
Christian.

>
> Thanks,
> Prike
>
>> ~arvind
>>
>>> Regards,
>>> Christian.
>>>
>>>> , and then the eviction fence will be added as a dependent fence by
>> propagating with amdgpu_sync_push_to_job(). With removing the eviction fence
>> from the VM sync at amdgpu_sync_resv(), then the eviction fence can be released
>> properly.
>>>> Thanks,
>>>> Prike
>>>>> Thanks,
>>>>> Christian.
>>>>>
>>>>> PS: Please stop calling the eviction fence evf.
>>>>>
>>>>>>>>      return 0;
>>>>>>>>
>>>>>>>>   free_err:
>>>>>>>> @@ -237,6 +234,30 @@ void amdgpu_eviction_fence_detach(struct
>>>>>>> amdgpu_eviction_fence_mgr *evf_mgr,
>>>>>>>>      dma_fence_put(stub);
>>>>>>>>   }
>>>>>>>>
>>>>>>>> +void amdgpu_userq_remove_all_eviction_fences(struct amdgpu_bo
>>>>>>>> +*bo)
>>>>>>> Please name that amdgpu_eviction_fence_remove_all().
>>>>>> Noted.
>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>> +{
>>>>>>>> +   struct dma_resv *resv = &bo->tbo.base._resv;
>>>>>>>> +   struct dma_fence *fence, *stub;
>>>>>>>> +   struct dma_resv_iter cursor;
>>>>>>>> +
>>>>>>>> +   dma_resv_assert_held(resv);
>>>>>>>> +
>>>>>>>> +   stub = dma_fence_get_stub();
>>>>>>>> +   dma_resv_for_each_fence(&cursor, resv,
>>>>>>> DMA_RESV_USAGE_BOOKKEEP, fence) {
>>>>>>>> +           struct amdgpu_eviction_fence *ev_fence;
>>>>>>>> +
>>>>>>>> +           ev_fence = fence_to_evf(fence);
>>>>>>>> +           if (!ev_fence || !dma_fence_is_signaled(&ev_fence->base))
>>>>>>>> +                   continue;
>>>>>>>> +
>>>>>>>> +           dma_resv_replace_fences(resv, fence->context, stub,
>>>>>>>> +                           DMA_RESV_USAGE_BOOKKEEP);
>>>>>>>> +
>>>>>>>> +   }
>>>>>>>> +
>>>>>>>> +   dma_fence_put(stub);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>   int amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr
>>>>>>>> *evf_mgr)  {
>>>>>>>>      /* This needs to be done one time per open */ diff --git
>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>>>>>>> index fcd867b7147d..da99ac322a2e 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>>>>>>> @@ -66,4 +66,5 @@ amdgpu_eviction_fence_signal(struct
>>>>>>>> amdgpu_eviction_fence_mgr *evf_mgr,  int
>>>>>>>> amdgpu_eviction_fence_replace_fence(struct
>>>>>>>> amdgpu_eviction_fence_mgr
>>>>>>> *evf_mgr,
>>>>>>>>                                  struct drm_exec *exec);
>>>>>>>> +void amdgpu_userq_remove_all_eviction_fences(struct amdgpu_bo
>>>>>>>> +*bo);
>>>>>>>>   #endif
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>>>> index 1e73ce30d4d7..f001018a01eb 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>>>> @@ -1392,6 +1392,7 @@ void amdgpu_bo_release_notify(struct
>>>>>>> ttm_buffer_object *bo)
>>>>>>>>      amdgpu_vram_mgr_set_cleared(bo->resource);
>>>>>>>>      dma_resv_add_fence(&bo->base._resv, fence,
>>>>>>> DMA_RESV_USAGE_KERNEL);
>>>>>>>>      dma_fence_put(fence);
>>>>>>>> +   amdgpu_userq_remove_all_eviction_fences(abo);
>>>>>>>>
>>>>>>>>   out:
>>>>>>>>      dma_resv_unlock(&bo->base._resv);

--------------zfNzX6sH0T0MULTWIkksdOQI
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 22.04.25 um 15:09 schrieb Liang, Prike:<br>
    <blockquote type="cite" cite="mid:DS7PR12MB60054D6296012455E53B72E3FBBB2@DS7PR12MB6005.namprd12.prod.outlook.com"><span style="white-space: pre-wrap">
</span>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Stop, wait a second. That shouldn't happen at the first place. Why is the eviction
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">fence considered a dependency for page table updates?
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
When it is added only as bookkeep then we should never consider that here.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Looks like something in the sync obj is messed up.
It is like this. Here, amdgpu_sync_resv is using
DMA_RESV_USAGE_BOOKKEEP.

         int amdgpu_sync_resv() {

                 ..

                 /* TODO: Use DMA_RESV_USAGE_READ here */</pre>
      </blockquote>
    </blockquote>
    <br>
    That here is the core of the problem.<br>
    <br>
    I've added this TODO item 4 years ago to switch over to
    DMA_RESV_USAGE_READ here when moved all TTM use cases to using
    drm_sched_job_add_resv_dependencies().<br>
    <br>
    That was done, but this TODO here forgotten.<br>
    <br>
    <blockquote type="cite" cite="mid:DS7PR12MB60054D6296012455E53B72E3FBBB2@DS7PR12MB6005.namprd12.prod.outlook.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
                 dma_resv_for_each_fence(&amp;cursor, resv,
DMA_RESV_USAGE_BOOKKEEP, f) {
                     dma_fence_chain_for_each(f, f) {

                 ..

}
during PT update amdgpu_vm_bo_update() is using sync to moving
fences(Eviction fence) before mapping anything. Because of this Eviction fence will
act as dependency.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Yes, since the amdgpu_sync_resv() uses the bookkeep usage, then all the BOs reservation fences along with the eviction fence will be returned and added to the sync.</pre>
    </blockquote>
    <br>
    Yeah, but that is incorrect.<br>
    <br>
    <blockquote type="cite" cite="mid:DS7PR12MB60054D6296012455E53B72E3FBBB2@DS7PR12MB6005.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">And with the attached patch, the eviction fence can be released properly when the kq and uq are enabled.</pre>
    </blockquote>
    <br>
    We need to fix the underlying bug first before we can work on the
    next step.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:DS7PR12MB60054D6296012455E53B72E3FBBB2@DS7PR12MB6005.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">

Thanks,
Prike

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">~arvind

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Regards,
Christian.

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">, and then the eviction fence will be added as a dependent fence by
</pre>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">propagating with amdgpu_sync_push_to_job(). With removing the eviction fence
from the VM sync at amdgpu_sync_resv(), then the eviction fence can be released
properly.
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">
Thanks,
Prike
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">Thanks,
Christian.

PS: Please stop calling the eviction fence evf.

</pre>
              <blockquote type="cite">
                <blockquote type="cite">
                  <blockquote type="cite">
                    <pre class="moz-quote-pre" wrap="">     return 0;

  free_err:
@@ -237,6 +234,30 @@ void amdgpu_eviction_fence_detach(struct
</pre>
                  </blockquote>
                  <pre class="moz-quote-pre" wrap="">amdgpu_eviction_fence_mgr *evf_mgr,
</pre>
                  <blockquote type="cite">
                    <pre class="moz-quote-pre" wrap="">     dma_fence_put(stub);
  }

+void amdgpu_userq_remove_all_eviction_fences(struct amdgpu_bo
+*bo)
</pre>
                  </blockquote>
                  <pre class="moz-quote-pre" wrap="">Please name that amdgpu_eviction_fence_remove_all().
</pre>
                </blockquote>
                <pre class="moz-quote-pre" wrap="">Noted.

</pre>
                <blockquote type="cite">
                  <pre class="moz-quote-pre" wrap="">Regards,
Christian.

</pre>
                  <blockquote type="cite">
                    <pre class="moz-quote-pre" wrap="">+{
+   struct dma_resv *resv = &amp;bo-&gt;tbo.base._resv;
+   struct dma_fence *fence, *stub;
+   struct dma_resv_iter cursor;
+
+   dma_resv_assert_held(resv);
+
+   stub = dma_fence_get_stub();
+   dma_resv_for_each_fence(&amp;cursor, resv,
</pre>
                  </blockquote>
                  <pre class="moz-quote-pre" wrap="">DMA_RESV_USAGE_BOOKKEEP, fence) {
</pre>
                  <blockquote type="cite">
                    <pre class="moz-quote-pre" wrap="">+           struct amdgpu_eviction_fence *ev_fence;
+
+           ev_fence = fence_to_evf(fence);
+           if (!ev_fence || !dma_fence_is_signaled(&amp;ev_fence-&gt;base))
+                   continue;
+
+           dma_resv_replace_fences(resv, fence-&gt;context, stub,
+                           DMA_RESV_USAGE_BOOKKEEP);
+
+   }
+
+   dma_fence_put(stub);
+}
+
  int amdgpu_eviction_fence_init(struct amdgpu_eviction_fence_mgr
*evf_mgr)  {
     /* This needs to be done one time per open */ diff --git
a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
index fcd867b7147d..da99ac322a2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
@@ -66,4 +66,5 @@ amdgpu_eviction_fence_signal(struct
amdgpu_eviction_fence_mgr *evf_mgr,  int
amdgpu_eviction_fence_replace_fence(struct
amdgpu_eviction_fence_mgr
</pre>
                  </blockquote>
                  <pre class="moz-quote-pre" wrap="">*evf_mgr,
</pre>
                  <blockquote type="cite">
                    <pre class="moz-quote-pre" wrap="">                                 struct drm_exec *exec);
+void amdgpu_userq_remove_all_eviction_fences(struct amdgpu_bo
+*bo);
  #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 1e73ce30d4d7..f001018a01eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1392,6 +1392,7 @@ void amdgpu_bo_release_notify(struct
</pre>
                  </blockquote>
                  <pre class="moz-quote-pre" wrap="">ttm_buffer_object *bo)
</pre>
                  <blockquote type="cite">
                    <pre class="moz-quote-pre" wrap="">     amdgpu_vram_mgr_set_cleared(bo-&gt;resource);
     dma_resv_add_fence(&amp;bo-&gt;base._resv, fence,
</pre>
                  </blockquote>
                  <pre class="moz-quote-pre" wrap="">DMA_RESV_USAGE_KERNEL);
</pre>
                  <blockquote type="cite">
                    <pre class="moz-quote-pre" wrap="">     dma_fence_put(fence);
+   amdgpu_userq_remove_all_eviction_fences(abo);

  out:
     dma_resv_unlock(&amp;bo-&gt;base._resv);
</pre>
                  </blockquote>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------zfNzX6sH0T0MULTWIkksdOQI--
