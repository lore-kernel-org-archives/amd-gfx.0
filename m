Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A883C021A0
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 09:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D1A910E2AD;
	Thu, 13 Feb 2025 09:15:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KmjgyD9C";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9632110EA36
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 09:15:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+rJJNG0dKsX+EYtSxD818xzwjGGziJ/QNIZGk/Z5S0l5s/Iy+Hp2m6uB10uTdDaYLFym8Zq6BkuZftCfGXl619QqgIpYJBPX63bvOp9qzBmf+f314V5mh+tTCIyjtDybEgC57GeZqwbuvE947I5mlmmOMbZVjj4H3k1qRzvgoNvmbeCBN0EteomDhwxdjiKh/yY0Hj7AYV25wIDcbEdE3bBHhfbOvvbAVtXywFgK6UjovciYv5e6fOjWPbcwOGvEMkn6fGUBxDM0xchAmDLd3sxf27kNZJAdynn0vcyPSLrTL/zl6mgJEAjaQC3Mb4SBK4a5UU6vgKrBx/s9iFMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdRZVSUPJHZrq1mp+Rzi51OQ9GSfDz4ZTm00T85DiPI=;
 b=jiORK0/XkxEaq5TPovDDkwpCc2SLPkHRRbmh22wQQL5pYgWLlxc6+swse9m8A97RYI4Y/HEO1MZcJ8N0WuNy63m/zYT03v8P1r0rOiSEXScbpCgADTXEbdLSLOCA2lSBJrJJnIJjtEmIfWL5ux7oG8iSExJk8u6x4QE1Z1dQWcYi6JqARBZdOtw4pJQJDaM6xpDReULoJlpvcN0HeQqNYYakViqRJE2bqJx50wGfyGzSqBQxRx8PvNvbytCpmz9fG+Mdoc7DVwOJ3Z0P83MBn+v4jmcPlOnSSREcR7EnMUuZCZA2ep1QKhLMcsm6J4Xm7Dm7Qv/hvC8y3hWbfV6VJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdRZVSUPJHZrq1mp+Rzi51OQ9GSfDz4ZTm00T85DiPI=;
 b=KmjgyD9CV8fg0jqO3xeIvKABD51RHV8DGYDa2PXRe0lvqYfzmTJRvTJpJSyOod2SxAcH6Pgr3m507YcnfGTun9JszllmUOa6yXrGhDHjhdJxQ6JGStiDZdkyicmA3IFebpMJ4IwIBoQsO5eqhTDNEkSGtFe3l7f9m1QM8cqztJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 09:15:46 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%3]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 09:15:46 +0000
Message-ID: <64a793d5-1694-4449-bdb6-0bbfa7815598@amd.com>
Date: Thu, 13 Feb 2025 14:45:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] drm/amdgpu: Per-instance init func for JPEG4_0_3
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>, Koenig Christian <Christian.Koenig@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>
References: <20250213025408.2402828-1-sathishkumar.sundararaju@amd.com>
 <20250213025408.2402828-2-sathishkumar.sundararaju@amd.com>
 <a7f7fcda-ae6a-4506-a7a2-4e3eea5316e4@amd.com>
 <4c2483df-ae3a-4380-a01a-de11edb36e09@amd.com>
 <f1856ade-76e8-4bf2-9dd0-0a98bce21859@amd.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <f1856ade-76e8-4bf2-9dd0-0a98bce21859@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::31) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|BL3PR12MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb9fdf6-5dbb-4aac-94c3-08dd4c0eff9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTQxU3dYUk01YitVSzlRNlhleUhxYkNaUGljZCs5OXBpeTgxdW54cWNRQ3pZ?=
 =?utf-8?B?TlpQTEROWi9YelMzc2ZIMHVlQnZzVGRpaGFSeHoxZzZMZG5kOTFoQkIrN0dL?=
 =?utf-8?B?WjVKOFBnVG5kVk40WFBhUHc4dGc3TkF4cXh5VFZUUVpBTVk0OVlUYUY1N0N0?=
 =?utf-8?B?YnB1bjVFMTJFL0JYV0l3b1hYQnlyeGNncXY3ZTNMaWtOS3ZCWS9FSnVTckY0?=
 =?utf-8?B?Y1VFYUgwV1BBN3NrSXNPaWVSK2NJSnRvUGlEMmIwT0NkRE1TRWVsbTgvUmVE?=
 =?utf-8?B?NTgvWGhlRy9Cd1ZSV041bTJOYm1VdE9tM05VbkwrMk1teFkrU0Q5eGVDL2Qy?=
 =?utf-8?B?Mk1iS0krRFh0SzZqcXNDSGVUM2dTSTRsa1BQSzlqZ2NtbUpTQXFnL0QxYU1w?=
 =?utf-8?B?dFNheXhJcWNvenQzb3RCejNrcGJGbzMvNUFQVkUvMmo3dzl6eFozZjhvZHNr?=
 =?utf-8?B?YWZ2YTc5TFVaUFhneTdxNStVMmNrWUtHTWhaSVhGOXRncVJleVF0V3ZIVlRK?=
 =?utf-8?B?NEpub2l1bWlBak52eWxPU2xMMGpsdjBQcW15Rjg5b1lVa2tHdVM3cCtRNlht?=
 =?utf-8?B?Z0FFYXh6TEUzcXZGVzFuSEZHdWxiYmRFQXc0WCtxL0ZQVFN3dDFtcVVyR01n?=
 =?utf-8?B?UjRMWjNqTzFYWjZQTTE4UWg3SEt3NnlIRnVqdGdVVzNJelNzZjl6SktKOG53?=
 =?utf-8?B?ZGMrTVJBWjc2SEVrdUo1SkN5S2FudXZKK0N6U2owYmFkQUl1dy9OMTgwRU9O?=
 =?utf-8?B?MzBxVWhBd3FzYTY0eURxaitUMXNoaDd5eGFuSlNHMURncGRJaWJjbzdDUjM0?=
 =?utf-8?B?eW52S0hDNENrUWcrL2tTV1M2M3lnUVRUamRZZHhMSmdMd1krTTh5SEVFTmJj?=
 =?utf-8?B?MCtDWGVIMEloY2pDMlU0ejFMNjlyc056dzdLVzdoSFk0dndHK0ZCYmRhMzNr?=
 =?utf-8?B?MGJmQkZOTUNpYmNlUjhZNFJqamtsQzluaEU1N0dHbFE3SEhJUzltZVhveVZF?=
 =?utf-8?B?amVudFEyd1pnb0ZxMERCSDRuRS85WDc5aDJ0UGlzQ0JIMUdNZ1pKRFdqaDJZ?=
 =?utf-8?B?RlJYb3A5SVE5QzYvdkdaQUkxUmkzYmVzdlIrMEVOYkxMemZrYnE3NW9HYXN1?=
 =?utf-8?B?emJaK1ZFaGI4M0RlU2w4REo3aWc5VzJRcXVMTXZ0T0VKN2xVcDNSYnBGS3BL?=
 =?utf-8?B?c1BoelRSbEdMVVd2bkZQOWN6WDBUdXQ4Z0diUGtJRU5sNmQ3ZkVOL3NEeURk?=
 =?utf-8?B?WVhMWTd5Q0Jrb3lTUEd2eTVLdTdNVHVRRXYrdkhHZlo3UGNkQkNFQnc0OXhY?=
 =?utf-8?B?RVZhQXd0S1BzNXhtdzNoelFUMXdJN3N0Tk5xWUhWWEpTM0x2c0JpZ1JMdE9L?=
 =?utf-8?B?VHR4K3dBcG53ck15STV5RTlXNDBySGNPL0ZSQzc0ZHJNUS93ZUEwY0pMcVNT?=
 =?utf-8?B?bitqdUg5eEFybFBqK2hSQ0JyOTVGcVcxYmxwdnpNcWZwRHdOZnRDM1lOWXps?=
 =?utf-8?B?Um5DYy84aW9DWWEzazV3WUR2U0RwTkQ3Qk4yR3BOWUFENjY1WlU0bU93a1FJ?=
 =?utf-8?B?NUY5bHFXYVF5R0JmSHA4L0YwSHpVK25IT3Axb1N2cjdPYk1sdkpsL3BzTThU?=
 =?utf-8?B?TCtFSlZ4MkJaTU5pbFBIWmxSdkVDbWtNZEY4UVlITUFNZ2VUaFM2TndoUzBP?=
 =?utf-8?B?UzJtM1RMbTlmMWNIclcxUGpUMTBQWDcxSjhMUmxnSTNSeWdjRmJPN2ZpWGNP?=
 =?utf-8?B?THRaRUEzYWg3TzI3WnU2THJOMFlrRGh6Tit6QkNrQVk3REd1VWdTNnpIV3lD?=
 =?utf-8?B?V2d1TjNVVVBRUjF1YnhiRTRFUWVuZkhLVGQ2bzVhQjRQdmt1Sy9CV0E2UTA3?=
 =?utf-8?Q?vu5R1zqNCzGoY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1M0ZFl1eHJLTTNheUQvMjBabEtnNGNJQ3Z0NmJ0MkZiZlUzMkRzcnpCZVlX?=
 =?utf-8?B?cEZBamg3RWRYWlR6UnNESDZUdWR1VkhHNkV0QTlBbmhZSzFka2NGRlZkVUFm?=
 =?utf-8?B?K1hVZTdwQnY5ZjFoZEZTcCtvbDlZQ3ZZNWhib05NZmR4QkNKcDNyK3NwODdw?=
 =?utf-8?B?WGN4aHdhSFdKZkx3NTllZVRzc1REeDRIcWFrVE0ydTRablA3Nk1DRFZtL1B1?=
 =?utf-8?B?L04wNlVPaFBVcFYxQXRoMndnV1lGdlRDVjlQNS9jZFFrMVQrTXVqeHV6c2tW?=
 =?utf-8?B?Q2JtekdBUWRMa1FSbXhOR3ZpTitDMStPU2g3Rm1VbDU4aDVGZUhXaUFjSEpy?=
 =?utf-8?B?VmQyUFU0U3hLNCtubmtnSmEwRGNqbDlSM1VXSCtLVnA2MmQyMC9Qb1crZWcx?=
 =?utf-8?B?eWNTbmRPQzI3SjFrUlVTM2Y2UmIwV0F2Y3hJSXlEanNGT3NrNGJ1R1JUVHRk?=
 =?utf-8?B?dnlYSGxOVUpFcU53M29KOGJhbmtCVUZJZ1VpK1dSSTZ1MG9sbmt4Y0JEQWdT?=
 =?utf-8?B?Zzc5ZloyQUYyT3lVYUhCeU5tQjROcHh3R1NESGdaVGRlUXI4VUtwcERUNFls?=
 =?utf-8?B?NGZ4Q2tWWnJtUzh4dWVvZnJtU2FKZ0dTc25FTUk4TUQrVUJMVmN6cEo3elFM?=
 =?utf-8?B?bXhrc1JDeG9mV1QwMXF6YWExSmhNb3dRck5zMnp4eHgwUy9zdE1td05odmc0?=
 =?utf-8?B?REQ1VGo0TXZOQW5FUis4K1I0bDdmcmhFazJJaE82Tjd3Tkc0ZjRtY0hadFlF?=
 =?utf-8?B?ckRhMENJZ25QZmF4UmdBMU0yWW40aFA5cnBJa2U2RE1jZ2c3bXZJRCszQzEr?=
 =?utf-8?B?d0RTeU04czdKS0EyK2JPd2VMV2VINlp2R0J1S1E4Rko4SUdQdGNqV1l6VE5y?=
 =?utf-8?B?RFZjaU93cTVIcjF3ZUJuazg1NkpZZUtHRDJINWF6Z201WGR2anMvdzBPV0da?=
 =?utf-8?B?bGRQTkV3MnZIVVpjajRWOStHU0xBeEZBRitON205eWtTaURLMlRvMzdsS1Fh?=
 =?utf-8?B?N3lGUnVVbFVTQUxTNXJ1c1BPK3BIaENMWTV1TzZPNTNKcno4K1VZOUZOR1pU?=
 =?utf-8?B?c1E2Nzg1aHQ0MTd6cVgrUVBEdVNPbXRqK0tZSzh2ZVZaVTlxQzNhVTNnTGJG?=
 =?utf-8?B?VUtKK1NNVjlHVXpWdVdIcTA4TkQ2ZGNXSUxwMTdUUlB3UEFBd3lpcXBTdTJO?=
 =?utf-8?B?WVpOKzZIaUpFQlJyb0RtTm9wdVl6SXo5STI1NFlha1hzTmtlOVIydUN2c3ht?=
 =?utf-8?B?VG9UQmUxa2hWdEdrbzVMcUpYRmdLM3M1eHRBRGdnZTU5VWtqc3dPL0hGRUVq?=
 =?utf-8?B?cDNYZjNGQUNWQ0VBOENCUnkzUWFZM2JSYlVwaGkxS1dKd2VScG5YUnNudjV6?=
 =?utf-8?B?b3JHR0xQQThqWXZWRUFRQmVQMGlSWWxISlNZYVhuUGFNYm1uYyszcFZKY3BN?=
 =?utf-8?B?RVIyOGx6RVErNDhxRlJwWmZ5SkVxMm5EK256NitqOSt1RDgzbnlhb29ZMzNv?=
 =?utf-8?B?dG1YQjFCZzkrMGRGN2FTalFjc3RTWmJDbXdra3pEMnE1aUNMSTFvY2JGVW15?=
 =?utf-8?B?a3ExYkp3YU5MUkR4SEZpek5ZYjcxNWM3MkNBWFNnMFgyN3MxL1JKbEdrclVL?=
 =?utf-8?B?Q1F1em5hYlJNTlBwY0JESFNIcEx1UEYyT3B0ODNKYmlWa1hDTDgwaDRjRUwr?=
 =?utf-8?B?MnlNL0FCYzc0SXdab0dJWTE0eHYxNkVscTk1cE1qcDNGUlMwNjRnVjdHbE5k?=
 =?utf-8?B?amNWWlhkQXdvNVdOYTlMdHRGWC9vNXcvb3U2ZUc5emROVE9id0lkekpudmZu?=
 =?utf-8?B?aGJoZE9USTBGSkFmNTduRktqTGtucE9pSFhxRk1Lc3BYSUtmS2pGWGdRQ1ZJ?=
 =?utf-8?B?TjRtUjViYWNsQmQrRVFTc1k2ME5ySXFMMmdvNWdEWkxaTkc1OW9SWEVuNits?=
 =?utf-8?B?bXFsVmVGVmIrcDRYcXlBV3dxM3VMNVF5bmZrWVg1ME1aWlNRemw0c1hEUEVZ?=
 =?utf-8?B?L215a05wcmw3ZWdpMi9DZ2NpWEhvSy9GMzRoTk5GQWpBd2JpQWVWWHk3MzBi?=
 =?utf-8?B?U04vaEZZdzBOV1lKVG5qNW8wanBPRTA2SUM4eWhaZzZONVlCb2RPN0IzcFZZ?=
 =?utf-8?Q?asD48IufwWLOUDJ38s/fAoFwS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb9fdf6-5dbb-4aac-94c3-08dd4c0eff9f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 09:15:45.9519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: koMa0PFFWP0nWu6IxLrx3+0uIBR0DJKq4p6oPoUjOU7iNEcJWcOPg2pNdEmz+qQEVrgSXn+w7gchd6Uyetkjog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547
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



On 2/13/2025 1:35 PM, Lazar, Lijo wrote:
>
> On 2/13/2025 1:07 PM, Sundararaju, Sathishkumar wrote:
>> On 2/13/2025 12:16 PM, Lazar, Lijo wrote:
>>> On 2/13/2025 8:24 AM, Sathishkumar S wrote:
>>>> Add helper functions to handle per-instance and per-core
>>>> initialization and deinitialization in JPEG4_0_3.
>>>>
>>>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>>>> Acked-by: Christian König <christian.koenig@amd.com>
>>>> Reviewed-by: Leo Liu <leo.liu@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 190 ++++++++++++-----------
>>>>    1 file changed, 98 insertions(+), 92 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/
>>>> drm/amd/amdgpu/jpeg_v4_0_3.c
>>>> index 2a97302a22d3..e355febd9b82 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>>> @@ -525,6 +525,75 @@ static void
>>>> jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst
>>>>        WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CGC_GATE, data);
>>>>    }
>>>>    +static void jpeg_v4_0_3_start_inst(struct amdgpu_device *adev, int
>>>> inst)
>>>> +{
>>>> +    int jpeg_inst = GET_INST(JPEG, inst);
>>>> +
>>>> +    WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
>>>> +             1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
>>>> +    SOC15_WAIT_ON_RREG(JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
>>>> +               UVD_PGFSM_STATUS__UVDJ_PWR_ON <<
>>>> +               UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
>>>> +               UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
>>>> +
>>>> +    /* disable anti hang mechanism */
>>>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>>>> regUVD_JPEG_POWER_STATUS),
>>>> +         0, ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>>>> +
>>>> +    /* JPEG disable CGC */
>>>> +    jpeg_v4_0_3_disable_clock_gating(adev, inst);
>>>> +
>>>> +    /* MJPEG global tiling registers */
>>>> +    WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX8_ADDR_CONFIG,
>>>> +             adev->gfx.config.gb_addr_config);
>>>> +    WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX10_ADDR_CONFIG,
>>>> +             adev->gfx.config.gb_addr_config);
>>>> +
>>>> +    /* enable JMI channel */
>>>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL), 0,
>>>> +         ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>>>> +}
>>>> +
>>>> +static void jpeg_v4_0_3_start_jrbc(struct amdgpu_ring *ring)
>>>> +{
>>>> +    struct amdgpu_device *adev = ring->adev;
>>>> +    int jpeg_inst = GET_INST(JPEG, ring->me);
>>>> +    int reg_offset = jpeg_v4_0_3_core_reg_offset(ring->pipe);
>>>> +
>>>> +    /* enable System Interrupt for JRBC */
>>>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regJPEG_SYS_INT_EN),
>>>> +         JPEG_SYS_INT_EN__DJRBC0_MASK << ring->pipe,
>>>> +         ~(JPEG_SYS_INT_EN__DJRBC0_MASK << ring->pipe));
>>>> +
>>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>> +                regUVD_JMI0_UVD_LMI_JRBC_RB_VMID,
>>>> +                reg_offset, 0);
>>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>> +                regUVD_JRBC0_UVD_JRBC_RB_CNTL,
>>>> +                reg_offset,
>>>> +                (0x00000001L | 0x00000002L));
>>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>> +                regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
>>>> +                reg_offset, lower_32_bits(ring->gpu_addr));
>>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>> +                regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
>>>> +                reg_offset, upper_32_bits(ring->gpu_addr));
>>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>> +                regUVD_JRBC0_UVD_JRBC_RB_RPTR,
>>>> +                reg_offset, 0);
>>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>> +                regUVD_JRBC0_UVD_JRBC_RB_WPTR,
>>>> +                reg_offset, 0);
>>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>> +                regUVD_JRBC0_UVD_JRBC_RB_CNTL,
>>>> +                reg_offset, 0x00000002L);
>>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>> +                regUVD_JRBC0_UVD_JRBC_RB_SIZE,
>>>> +                reg_offset, ring->ring_size / 4);
>>>> +    ring->wptr = RREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>> regUVD_JRBC0_UVD_JRBC_RB_WPTR,
>>>> +                     reg_offset);
>>>> +}
>>>> +
>>>>    /**
>>>>     * jpeg_v4_0_3_start - start JPEG block
>>>>     *
>>>> @@ -535,84 +604,42 @@ static void
>>>> jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst
>>>>    static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
>>>>    {
>>>>        struct amdgpu_ring *ring;
>>>> -    int i, j, jpeg_inst;
>>>> +    int i, j;
>>>>          for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>>>> -        jpeg_inst = GET_INST(JPEG, i);
>>>> -
>>>> -        WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
>>>> -                 1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
>>>> -        SOC15_WAIT_ON_RREG(
>>>> -            JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
>>>> -            UVD_PGFSM_STATUS__UVDJ_PWR_ON
>>>> -                << UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
>>>> -            UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
>>>> -
>>>> -        /* disable anti hang mechanism */
>>>> -        WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>>>> -                      regUVD_JPEG_POWER_STATUS),
>>>> -             0, ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>>>> -
>>>> -        /* JPEG disable CGC */
>>>> -        jpeg_v4_0_3_disable_clock_gating(adev, i);
>>>> -
>>>> -        /* MJPEG global tiling registers */
>>>> -        WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX8_ADDR_CONFIG,
>>>> -                 adev->gfx.config.gb_addr_config);
>>>> -        WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX10_ADDR_CONFIG,
>>>> -                 adev->gfx.config.gb_addr_config);
>>>> -
>>>> -        /* enable JMI channel */
>>>> -        WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL), 0,
>>>> -             ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>>>> -
>>>> +        jpeg_v4_0_3_start_inst(adev, i);
>>>>            for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>>> It's better to move this inside the instance function. Instance takes
>>> care of all cores within the instance.
>> The separation in the helper functions was done to decouple core
>> specific configs away from instance
>> specific configs to have the degree of freedom to control them
>> independently without meddling with
>> each other, so having them done separately kind of helps to align better
>> with that choice.
>>
> Functionally, is an instance considered started even if its cores are
> not initialized?

was that a question ? _start() does it.

The current design aligns better for the initialization and also future 
work planned, like per core reset
and full instance recovery, and this separation is a must for that, I do 
not want them together as it
hinders an axis of freedom in configuration and recovery process with 
validation at every step.

Regards,
Sathish

> Thanks,
> Lijo
>
>> Regards,
>> Sathish
>>> Thanks,
>>> Lijo
>>>
>>>> -            int reg_offset = jpeg_v4_0_3_core_reg_offset(j);
>>>> -
>>>>                ring = &adev->jpeg.inst[i].ring_dec[j];
>>>> -
>>>> -            /* enable System Interrupt for JRBC */
>>>> -            WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>>>> -                          regJPEG_SYS_INT_EN),
>>>> -                 JPEG_SYS_INT_EN__DJRBC0_MASK << j,
>>>> -                 ~(JPEG_SYS_INT_EN__DJRBC0_MASK << j));
>>>> -
>>>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>> -                        regUVD_JMI0_UVD_LMI_JRBC_RB_VMID,
>>>> -                        reg_offset, 0);
>>>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>> -                        regUVD_JRBC0_UVD_JRBC_RB_CNTL,
>>>> -                        reg_offset,
>>>> -                        (0x00000001L | 0x00000002L));
>>>> -            WREG32_SOC15_OFFSET(
>>>> -                JPEG, jpeg_inst,
>>>> -                regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
>>>> -                reg_offset, lower_32_bits(ring->gpu_addr));
>>>> -            WREG32_SOC15_OFFSET(
>>>> -                JPEG, jpeg_inst,
>>>> -                regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
>>>> -                reg_offset, upper_32_bits(ring->gpu_addr));
>>>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>> -                        regUVD_JRBC0_UVD_JRBC_RB_RPTR,
>>>> -                        reg_offset, 0);
>>>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>> -                        regUVD_JRBC0_UVD_JRBC_RB_WPTR,
>>>> -                        reg_offset, 0);
>>>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>> -                        regUVD_JRBC0_UVD_JRBC_RB_CNTL,
>>>> -                        reg_offset, 0x00000002L);
>>>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>>> -                        regUVD_JRBC0_UVD_JRBC_RB_SIZE,
>>>> -                        reg_offset, ring->ring_size / 4);
>>>> -            ring->wptr = RREG32_SOC15_OFFSET(
>>>> -                JPEG, jpeg_inst, regUVD_JRBC0_UVD_JRBC_RB_WPTR,
>>>> -                reg_offset);
>>>> +            jpeg_v4_0_3_start_jrbc(ring);
>>>>            }
>>>>        }
>>>>          return 0;
>>>>    }
>>>>    +static void jpeg_v4_0_3_stop_inst(struct amdgpu_device *adev, int
>>>> inst)
>>>> +{
>>>> +    int jpeg_inst = GET_INST(JPEG, inst);
>>>> +    /* reset JMI */
>>>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL),
>>>> +         UVD_JMI_CNTL__SOFT_RESET_MASK,
>>>> +         ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>>>> +
>>>> +    jpeg_v4_0_3_enable_clock_gating(adev, inst);
>>>> +
>>>> +    /* enable anti hang mechanism */
>>>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>>>> regUVD_JPEG_POWER_STATUS),
>>>> +         UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
>>>> +         ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>>>> +
>>>> +    WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
>>>> +             2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
>>>> +    SOC15_WAIT_ON_RREG
>>>> +        (JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
>>>> +         UVD_PGFSM_STATUS__UVDJ_PWR_OFF <<
>>>> UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
>>>> +         UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
>>>> +}
>>>> +
>>>>    /**
>>>>     * jpeg_v4_0_3_stop - stop JPEG block
>>>>     *
>>>> @@ -622,31 +649,10 @@ static int jpeg_v4_0_3_start(struct
>>>> amdgpu_device *adev)
>>>>     */
>>>>    static int jpeg_v4_0_3_stop(struct amdgpu_device *adev)
>>>>    {
>>>> -    int i, jpeg_inst;
>>>> +    int i;
>>>>    -    for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>>>> -        jpeg_inst = GET_INST(JPEG, i);
>>>> -        /* reset JMI */
>>>> -        WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL),
>>>> -             UVD_JMI_CNTL__SOFT_RESET_MASK,
>>>> -             ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>>>> -
>>>> -        jpeg_v4_0_3_enable_clock_gating(adev, i);
>>>> -
>>>> -        /* enable anti hang mechanism */
>>>> -        WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>>>> -                      regUVD_JPEG_POWER_STATUS),
>>>> -             UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
>>>> -             ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>>>> -
>>>> -        WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
>>>> -                 2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
>>>> -        SOC15_WAIT_ON_RREG(
>>>> -            JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
>>>> -            UVD_PGFSM_STATUS__UVDJ_PWR_OFF
>>>> -                << UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
>>>> -            UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
>>>> -    }
>>>> +    for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i)
>>>> +        jpeg_v4_0_3_stop_inst(adev, i);
>>>>          return 0;
>>>>    }

