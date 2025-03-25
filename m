Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50376C35FFC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 07:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D424A10E207;
	Tue, 25 Mar 2025 07:36:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xgGk5S0s";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5198410E207
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 07:36:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjFQmDRBKQMgFEU/ptZxCNKoVr5AURewnHu4LgwXlJYKQxDviDp76JSvdd7yJcz3T2aTc4x0Dg+KR9yjBLRjz9dzT4bvKjl1u0L3bP9d6UDD38Y72dQJaqO0XSFhAoDFgtPx3B3xeMVhjYAv3hynSlZwf6HgK/qI0tf29wXJUFwfUoEhEBVadBeIcqa1fLiERJZjau4y+Dnkf7tayNIB0k6ItW5f92VEx9AQjeM4slcIbXcu8PHV2Zn5c0gAbkX7YFZktSTDdhvxU/+tDX3CFa4ovZRJJlN/SbffAyY9NHr45B/re0gcUfTa0DKgZJOjmIxfBvWxp7Ww1jwE+gNP6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpv99CIBwnq4wp8t6CJ4oTO3g/SVruY8tvpK/ytjNPQ=;
 b=RekPJK6kOhFDi3q4EuX8u3yGkauzEWBbusr1GRRhAvW1pqTEdpY5DUuMQrLoPQ1+mMfS0LHICB9uyfGYvEZ5MDfYfEl7YBN40vsFkxwcHAC/Ku0dxSOsU/yU4ql8Glc7pDC0ThVSAbgyX35TuhG5kZjtK+R8GFDcZnlEBeEwXqzz7l10q6BZMmp3MMyKSOT4YWEQMRDH77+VHTxzMCUHwV6Yjtxf7mEY+OEjprSafhR9hx9bFOCYc6nl0IwSSfPs45JUoxF/TyNGBjwB6kmcdcbeEpbz1N9CzXnXVfIHfspt3TbpDwpaJddPY3x8RoLKHt4EIYHbvChEVsVi9QnKuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpv99CIBwnq4wp8t6CJ4oTO3g/SVruY8tvpK/ytjNPQ=;
 b=xgGk5S0sfSWSgEZGAdK1NegaQ3i9yfKmanCuRUpnKHJ2341pB7JtbbEfvdiD7Va+IWvcpRuYk3mLdLh8FxCPr5pFqMmA+KVRyvXL95W4fVCf4n0/T7o6S5IGUL93z/RDONLh0YNRfgZl41jhyAM4sucH3fimutDkRBjW/L0koDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6568.namprd12.prod.outlook.com (2603:10b6:8:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 07:35:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8511.026; Tue, 25 Mar 2025
 07:35:55 +0000
Content-Type: multipart/alternative;
 boundary="------------9iaTX0xlx7QNl702AiALj0Z5"
Message-ID: <938c2cbd-c47f-4925-ba82-94eef54d9ebc@amd.com>
Date: Tue, 25 Mar 2025 08:35:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: commit 7ffb791423c7 breaks steam game
To: Balbir Singh <balbirs@nvidia.com>, Bert Karwatzki <spasswolf@web.de>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
References: <20250322122351.3268-1-spasswolf@web.de>
 <688f2757-e364-45db-ad54-daa6ff1c4f3c@nvidia.com>
 <6e8ad3cd27b570aaefd85395810cc90bb3120734.camel@web.de>
 <7cdbe06c-1586-4112-8d27-defa89c368e9@amd.com>
 <b1d72b95-5b5f-4954-923f-8eebc7909c4d@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <b1d72b95-5b5f-4954-923f-8eebc7909c4d@nvidia.com>
X-ClientProxiedBy: FR3P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d873c93-bc95-4d0c-27fb-08dd6b6fada0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWlVMVk0a3dISFk5YkREaHBPeUpKQ0ZWMTRxbWc2OHNLUzVyek53SXdqYUxJ?=
 =?utf-8?B?cUl0aGtydnYydXlsS1l6TzlWZWFLSWZENmxvcXZtdW5ObnVBTVJLY0ZsWUIw?=
 =?utf-8?B?UnFhZ21UaURnU0lOb2lzT1hSeExmRS9wYVRrcVhrQlpCYk03MXgzZ3EybEVB?=
 =?utf-8?B?MFAwSndSRVlsczRmYm8zNjN4djcyZC9BQi8vZ0RvaHgrSzhBM1piK1FrMHlo?=
 =?utf-8?B?MWRnVkJONWZacmloZ1VXRGJpMjFPRkt1ZUQ0TDMySkFLeXBFR3NWN1lOZm5z?=
 =?utf-8?B?dWJIalRpMk1WRnN5Ylk5c1JadFkraFNkSEpFTGJKSXhUbTA2dWpWMEZzZnJZ?=
 =?utf-8?B?WFhwL1pPV2lWTisxd1JIZ2VGSUJpSHI0ZjZRVlBpbWhubm55WWc3RGlaOHFF?=
 =?utf-8?B?VkdFSjJXa0NEQXcyelMyVFU4T0QxR2pUNS90aENGbjE1QjhtemNMSldXcHRv?=
 =?utf-8?B?elBtbm4ySjl1N0JpZDVBRkVjcWRudEF5TVNNVHh3VVVSK0REUjBDbzVCYlp5?=
 =?utf-8?B?N0FUQjlzYTZGVW45OE1PQmNTUk5OdnRkMCtJamlqTTFWSmcxcGlzWVFsL3lD?=
 =?utf-8?B?VWJPSXR3dTNNNHdsSlMybFpmUWEvbjNZa2FGb0VLZTgwcXJUeUZxblhBaGdE?=
 =?utf-8?B?VnJWM2FmSFJST21xU1VWcmlpanJjZS9GdmlCQXMzOE8vNGd3aHl3MDZra0Z2?=
 =?utf-8?B?c1V1M1RGUFdZNVg2eWRmUFFhNDFGUUg3UGhYbmhXS0prZU1kdWdCdTc5MVBP?=
 =?utf-8?B?VnpWejE2WU9XcHFESjRqWXBOQWFBeUtPUkphazNvcWQ2ZmtHZDBvamNEWHoy?=
 =?utf-8?B?WGZyRm1JSXNzQ3VsUjY0U0xaQlNVQ3VHS3kzVUhZOG5nalZvZVNvZXMzdTF4?=
 =?utf-8?B?OVE2SG84L2FhNUVFMHIzVWdxb3p0UnJTSWtNNHZJaFc4Q09RZlZESnhxSUts?=
 =?utf-8?B?b2RjTE92TnVTQVI5cDdXRGRyNnJDUnJxQ1VMMDBMYy91SDJlNUxocExEeWxk?=
 =?utf-8?B?aVlwVlZhQ2tobDV5NVRINlRMVGhMN2wwK01IVHpSdDVaRWJCbzVOQnBTd2dM?=
 =?utf-8?B?R09ES1RnOW5kMm5jYldHTTMxcGpoQmRuY003Z1dNL21ya0xtWE9MNGVVQXE0?=
 =?utf-8?B?V09naHdTVGdHVENDd0t4QVZWR3Y5V2R3SGdNSGdQdXNSNnR4OFNMcVhlSTNs?=
 =?utf-8?B?WW5qU2tMOVl6a2tGRkFWTE9kSGxCZDUxclpBOXVoNzZKV1EzWUtLcnFGV2U1?=
 =?utf-8?B?TXUxU1E2T0dHTTczWXBVRHdTT2FjN0VMKy9JcXNvR1lrSmFCRWFKUHcvK1M3?=
 =?utf-8?B?U3Y1UnFONnVhdXd4UUtmTEQzc3VHTnpINW1Id3hCVU1Lay85Nzl2eVpMTmxD?=
 =?utf-8?B?TjZPWmFCUzlwRGZIS0p5ak9Kcm5zcVFJazhIRWx6Q014cG9rRTlvNGNtVmJN?=
 =?utf-8?B?WVBZN3dxanltcTB3aTQ2QXdiUXhxTjh0M3dNRHZKY2FzTTMvL1Bwbms2bE50?=
 =?utf-8?B?V1ozcEgybkpCSWRMSExlbTlTVXB6eXZQSUM4VFhvRzlDWXd5QURFMEY0cHdm?=
 =?utf-8?B?Ui84b0VDbGlIdVNsYVFWTXNXZVpkRnNjUVRXcTZPOG1BM2xyMmxhZDZ1RTdp?=
 =?utf-8?B?OGk5RXk2dzUzZHMzK3p4djc0R3FCREw1NUN1dkh5dWNTZDR5cHRrZUQ2YXZy?=
 =?utf-8?B?RzNGTzl0SDM5VEFuRXZmU3ZrNUlnUmk3MnVzak9ocnByRUFFTVd6L2toTzJQ?=
 =?utf-8?B?alFTUnh4YitVV0NzNjhZekNaSHEzVWpRZHVzTzVxdWxXaHN4OXg0bjRSYmcr?=
 =?utf-8?B?Z3lLby9yWVVxWTNWcHpuZDVXa21jVkRGSzZZaUZkakxYbDkzSmh6MHB3R2g1?=
 =?utf-8?Q?7NuQ+eFPLIr9w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1FtRXpNTk1NWUJLT0RKVUF5b05sU0FZNnVlREV4R25qdmlJempXaVowM0Q0?=
 =?utf-8?B?VHNkaXMxU2Y5RmZSM3FjUWRFSHhDUTZBMHoweU1RTDh5ck1yTDlrTmJWc0hw?=
 =?utf-8?B?SHVOeEwzR0h4aEF4dWdOdTVNRHpWRHlCMFBpQmpDV2xMUnZiZnFSd2YzWDUv?=
 =?utf-8?B?NlRxQkl2SGZBWDlTRXFFZ0FxQjB0azdIeDJZTTBURUpKcTh3QjJ6MklhNVhm?=
 =?utf-8?B?bEl3N1BwYTVhM0p1Zk5LSGZ5aG03QnVSUzZQWGdQSUpPcmszNTNuRVBvejRH?=
 =?utf-8?B?UDcrWk9wdzcrWlQzVklXQXFiRjluSEpzZDQ1TFlTQTlLajcyVEp1clZ2Yjc1?=
 =?utf-8?B?OEMvVTJ5NG1BbFFUaVRSUitBczdTeEVjbSs5TnVaV0d5ZUpwZWdXVEtpQVZC?=
 =?utf-8?B?K0YvUExzbHVCNU1yYTZJK3ZhRkNVcXBHRWhlL2d3MTlTSmdDd2xBSnpyOEFP?=
 =?utf-8?B?M3M3emoxVUlNM0ZmSURMZFo1eTU3Uk1jV1VBVGMzWE4rNkJiOVM2eFB0U2pT?=
 =?utf-8?B?c0RUc1JzT3YwSjJWNEtjYkNxV2MzVnRNcm1uZytmdEJjeHNTZ0MzNDZaank0?=
 =?utf-8?B?ZmRvRE9SZWtRb0JuN3RDbEJyQ2dPRDdoUWJ2cHFIaGk3VFdWKys5d1MzZXFM?=
 =?utf-8?B?RE4zdDJ2TVFNNEZFSWs0eTVUS3VEUlRvU25tL3p3dndhb293Qk1TaWw0enBG?=
 =?utf-8?B?WU9yYjh5L2xSNnQydmNCcnU4eWU4RWFUOXlBdFdlSWpIUEpndWJKMkl6a2I3?=
 =?utf-8?B?ejZPejN4ems0WXI4VWkrUHBXUEVmeXgwT1hpTkRJRysrMERPWVZTQ0hzdEtq?=
 =?utf-8?B?YzNVZ0NWbGhXSFJ0OUtzUkl3ZFRpN0FrTld3cElzaGpEY1dPeVpKQlpDVGtL?=
 =?utf-8?B?cGR3Nno2QkNhdEhVeTVkc2plMFRvZWFKRmZzUGoxbTQxVnVEVUhEM0lJenhD?=
 =?utf-8?B?bzRGOVFtckV0U0g3VXgrS1Q3VDBMNHFWY2NpeFIxTXZ4RS9PZ2s0NXg4Tm9S?=
 =?utf-8?B?QWFZMkVKRktkYlY0a1g2dlZDSE1WVjkvMlVpTEx5RWRYd3lnYWVLMVhKd293?=
 =?utf-8?B?VEw0d3JXN3FTK2hwTE53eU94Q1NJdnBua1NRY3ZVdVcycU5CVW93TVRreTd5?=
 =?utf-8?B?SEhUY1J1amxjckxIbExiMHJQbk1NMDAzY3oyN2xJYzJSSGd4OXdIWnlnWkVx?=
 =?utf-8?B?ak1icmt6Y081TmhNQjNiWkE4M0NyL0ZKdUJZS2xNQWhQYzhTOEZhWHFIV2tZ?=
 =?utf-8?B?RlB6QkFZWGEvQkMzUFVGdUQzUndHbkdaL2d4VjdKUDRFa3FBaWMyRXRoeFpp?=
 =?utf-8?B?UFl0d2FycHhmMElyTXFaaFdLOUw1R2k0RytQeWR6K1cwQnFZdmRobUJISHVN?=
 =?utf-8?B?ZjJHTzByODZLZFc2MzROQ2dMbVN3M3ovL3R6ZG03UTF4QVdzak5xTTJYZ2c0?=
 =?utf-8?B?bzIyMktaMmdmOElQc3MyVlFrTGFjYTV1TzJkZDVvSi9OcSsxTHVrQlJYODVH?=
 =?utf-8?B?ODFMaUZiZWJ4SVBJK0NZcFFVV2ErTWV1bjJKRG1EV1daODVHSzd2TE9ITDBM?=
 =?utf-8?B?aHp2TVROSmJBb3pPN0NnSDc5VlNrY204VXRXVFV4Q21yaVlOcmNPeWRCdHhj?=
 =?utf-8?B?bVFsVmUvS0s2cFpmMVZuczdndEhyNXZhM2xTNlJYcEw0WjU4bEhFbFVDZ1BW?=
 =?utf-8?B?QngxYS9CdzBHdFRnQlVsTDczSVlrTEgwZ2JsTkFWdG1mdkdvUGRFT09WUjNj?=
 =?utf-8?B?Z3Zza0dlYld3eXJRcWpDcWlGeTdBN001Y1VsS1NkY2xRMU5DSzBxNVFsRS9m?=
 =?utf-8?B?R0pJMFZ4bXBpZndHbkdEZDhHVjhVNG1zcmsxSkg1NUYxWTIrRkRiTCt1M0N1?=
 =?utf-8?B?ZE5VTGtYNFR4N3ZQQ09FalVkMWhmMENDRTdmUGY3Uzg1Rm40UGZPRjBORHVR?=
 =?utf-8?B?MHhpaVdGZk1OOTVXbGJZOXZmbDdhYitiVGs0cVdXNEl3WTZlWmJNbG13L2gx?=
 =?utf-8?B?bFcyVzc5ODg5cC9CTjlJczl2UkY2dmU4LzB1aTUrZGZlMkhCSXcwd3BUK3FE?=
 =?utf-8?B?UENGYm9tMGRaRjc1U051VGluSkg2QW5CcSthS3VCdXlpMkh5cWFzajF0S1Fv?=
 =?utf-8?Q?QxuQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d873c93-bc95-4d0c-27fb-08dd6b6fada0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 07:35:55.6784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbDOeaK+sAPyu0qQD43ycWdXJBe1HEpjxTaSumVwJkjYBZheWsKNFFVvA1ijfVGH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6568
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

--------------9iaTX0xlx7QNl702AiALj0Z5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 24.03.25 um 23:48 schrieb Balbir Singh:
>>> lspci -v reports 8G of memory at 0xfc00000000 so I assmumed that is the GPU RAM.
>>> 03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 23
>>> [Radeon RX 6600/6600 XT/6600M] (rev c3)
>>> 	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
>>> 	Flags: bus master, fast devsel, latency 0, IRQ 107, IOMMU group 14
>>> 	Memory at fc00000000 (64-bit, prefetchable) [size=8G]
>>> 	Memory at fe00000000 (64-bit, prefetchable) [size=256M]
>>> 	Memory at fca00000 (32-bit, non-prefetchable) [size=1M]
>>> 	Expansion ROM at fcb00000 [disabled] [size=128K]
>> Well when you set nokaslr then that moves the BAR address of the dGPU above the limit the integrated GPU can access on the bus (usually 40 bits).
>>
>> Because of this the integrated GPU starts to fallback to system memory below the 4GB limit to make sure that the stuff is always accessible by everyone.
> Why does it fallback to GPU_DMA32? Is the rest of system memory not usable (upto 40 bits)?

We need to guarantee that we don't run into using bounce buffers since the high level APIs doesn't necessarily inform the kernel about the state transitions for that.

> I did not realize that the iGPU is using the BAR memory of the dGPU.

When the displayed content is rendered by the dGPU but the monitor connected to the iGPU you somehow need to get the image to the iGPU.

The most efficient approach is that the iGPU copies the image from the dGPUs BAR directly into memory it can scanout from.

Alternatively we can allocate some system memory, the dGPU copies the image into that and then iGPU then copies the image into the scanout buffer.

Some newer hardware can also directly scan out from that system memory and so avoiding that extra copy. But this has a bunch of pre-requisites, for example IOMMU needs to be disabled or in pass through mode.

> I guess the issue goes away when amdgpu.gttsize is set to 2GB, because 2GB fits in the DMA32 window

Well I would not say that the issue goes away, it just makes your symptoms go away.

The trick is that the gttsize is what we give to the Steam game as maximum amount of system memory it can allocate. So it most likely stays below that and so the extra system memory buffer for scanout can also fit below 4GB.

>> Since the memory below 4GB is very very limited we are now starting to constantly swap things in and out of that area. Basically completely killing the performance of your Steam game.
>>
>> As far as I can see till that point the handling is completely intentional and working as expected.
>>
>> The only thing which eludes me is why setting nokaslr changes the BAR of the dGPU? Can I get the full dmesg with and with nokasl?
>>
> IIRC, the iGPU does not work correctly, the dGPU does, so it's an iGPU addressing constraint?

The problem is more that the iGPU doesn't have any local memory, but rather just uses (potentially stolen) system memory.

But the questions remains: Why does the BAR move around? That should most likely not happen.

Regards,
Christian.

>
> Balbir
>

--------------9iaTX0xlx7QNl702AiALj0Z5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 24.03.25 um 23:48 schrieb Balbir Singh:<br>
    <blockquote type="cite" cite="mid:b1d72b95-5b5f-4954-923f-8eebc7909c4d@nvidia.com"><span style="white-space: pre-wrap">
</span>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
lspci -v reports 8G of memory at 0xfc00000000 so I assmumed that is the GPU RAM.
03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 23
[Radeon RX 6600/6600 XT/6600M] (rev c3)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 1313
	Flags: bus master, fast devsel, latency 0, IRQ 107, IOMMU group 14
	Memory at fc00000000 (64-bit, prefetchable) [size=8G]
	Memory at fe00000000 (64-bit, prefetchable) [size=256M]
	Memory at fca00000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at fcb00000 [disabled] [size=128K]
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Well when you set nokaslr then that moves the BAR address of the dGPU above the limit the integrated GPU can access on the bus (usually 40 bits).

Because of this the integrated GPU starts to fallback to system memory below the 4GB limit to make sure that the stuff is always accessible by everyone.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Why does it fallback to GPU_DMA32? Is the rest of system memory not usable (upto 40 bits)?</pre>
    </blockquote>
    <br>
    We need to guarantee that we don't run into using bounce buffers
    since the high level APIs doesn't necessarily inform the kernel
    about the state transitions for that.<br>
    <br>
    <blockquote type="cite" cite="mid:b1d72b95-5b5f-4954-923f-8eebc7909c4d@nvidia.com">
      <pre class="moz-quote-pre" wrap="">
I did not realize that the iGPU is using the BAR memory of the dGPU.</pre>
    </blockquote>
    <br>
    When the displayed content is rendered by the dGPU but the monitor
    connected to the iGPU you somehow need to get the image to the iGPU.<br>
    <br>
    The most efficient approach is that the iGPU copies the image from
    the dGPUs BAR directly into memory it can scanout from.<br>
    <br>
    Alternatively we can allocate some system memory, the dGPU copies
    the image into that and then iGPU then copies the image into the
    scanout buffer.<br>
    <br>
    Some newer hardware can also directly scan out from that system
    memory and so avoiding that extra copy. But this has a bunch of
    pre-requisites, for example IOMMU needs to be disabled or in pass
    through mode.<br>
    <br>
    <blockquote type="cite" cite="mid:b1d72b95-5b5f-4954-923f-8eebc7909c4d@nvidia.com">
      <pre class="moz-quote-pre" wrap="">I guess the issue goes away when amdgpu.gttsize is set to 2GB, because 2GB fits in the DMA32 window</pre>
    </blockquote>
    <br>
    Well I would not say that the issue goes away, it just makes your
    symptoms go away.<br>
    <br>
    The trick is that the gttsize is what we give to the Steam game as
    maximum amount of system memory it can allocate. So it most likely
    stays below that and so the extra system memory buffer for scanout
    can also fit below 4GB.<br>
    <br>
    <span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:b1d72b95-5b5f-4954-923f-8eebc7909c4d@nvidia.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Since the memory below 4GB is very very limited we are now starting to constantly swap things in and out of that area. Basically completely killing the performance of your Steam game.

As far as I can see till that point the handling is completely intentional and working as expected.

The only thing which eludes me is why setting nokaslr changes the BAR of the dGPU? Can I get the full dmesg with and with nokasl?

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
IIRC, the iGPU does not work correctly, the dGPU does, so it's an iGPU addressing constraint?</pre>
    </blockquote>
    <br>
    The problem is more that the iGPU doesn't have any local memory, but
    rather just uses (potentially stolen) system memory.<br>
    <br>
    But the questions remains: Why does the BAR move around? That should
    most likely not happen.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:b1d72b95-5b5f-4954-923f-8eebc7909c4d@nvidia.com">
      <pre class="moz-quote-pre" wrap="">

Balbir

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------9iaTX0xlx7QNl702AiALj0Z5--
