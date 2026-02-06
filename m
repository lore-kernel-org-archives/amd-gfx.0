Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08680EB28F1
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 08:54:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DD6310E5C0;
	Fri,  6 Feb 2026 08:54:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OlJB9Vob";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3123310E5C0
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 08:54:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9Zy17xanwDot76VFVn7dCQD7rmnUH0vL7eKu3qh65DvpfjaQlePGs8FZOYO5vsXB+xnn5IoQJvMk40DrzSF1p6fSmLTdYzquAOp7+jTiFBA8sTwNMYBTvgLgvRdRCfFMTpZ6UuhPXcKevzyL9pkwbkGiwjq2+zp7wPNKD1k6kKf5nysZPJpFt/4jKQr8/52kP8eV0HoU/8ErjUE4bV6kRvfZ+nomc7kUWyfrA3jhOMrz+X1O9KGiG0/Y+7iX2pKPHDshbmwexlp2Io7uD+e3P3czZX4cI/a7r/yC7cssS1S9rQHDhUiM3WIWrEcLQUxsw2gFWix/ffW3Iz/FxgTOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytmesIlyWsnhOTmEdSM6VZetYmBETecFgkCZgBSwmxk=;
 b=sElUqRebSZixb+mksxtLrbOHcFcgcb9QW30POrubBHwTKqXTjtYcEmiCUyGlHgKuioNKbG4hyjiQ/Ww5dz5AETJJBi9KbvM3jiGhXCWqZR+lZIWLxkmagUvAn+waQFMChLKe63DdE2od4rckHPa+z7Lqu08Nck8KT57lhIy1iqKbaNHOZddeWUKFwENTYmXrcom9kD77jPnjQVyg6a/4p78A/TWrlV0FhXwvDe8M+JmJLjCmAOCTYNYqz+gsmun+sxfvRXZVy0wAkKOwQ9mC39RUb9YZc4xcPj1guejLpQDHyQpeytBFMrhawiYazvP3mhHlKwINsOgD6DRSqPwKpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytmesIlyWsnhOTmEdSM6VZetYmBETecFgkCZgBSwmxk=;
 b=OlJB9Vob++oZXQUbhXf6LYiuWL8uNKCwp7YeS4nxXvkuniz7bDm3hwsscRNMAMHJ2uE+lHoVU5ZxEyb20DdBEs/iXpb6r1KQNkyX1B0xJEDd6UMFRkX0CQO6Yy9XPlpginACRqUTD9yBCxap9PRkJApfEUwthatynVdA0kiKv2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 08:54:12 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 08:54:12 +0000
Message-ID: <e8920ae7-371b-47b1-b24d-af24e076fa9d@amd.com>
Date: Fri, 6 Feb 2026 14:24:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Use U64 for accumulation counter
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kevinyang.wang@amd.com
References: <20260206083506.4134755-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260206083506.4134755-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: a528f253-898c-41d2-9bdd-08de655d4c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXhwRTYxNzVIcTNmZHVKeUlTNjZDcytmL2d3T2JVWUFxWkE5SmRLWW54enBT?=
 =?utf-8?B?bWZQUVRUU216a0RSU0V5UTh0cjJXZk8xbUF4bDUxQnJieXdXclB5eWJ2Tmto?=
 =?utf-8?B?YVI1Y1laYUsxTGI0bm02NzdLUUV5UDRacHFhdTFxY2ZQSmpYdE40TVE0MHEv?=
 =?utf-8?B?akcxU05ObmJiNElFNERQb1dWZ0FodENaekRPZStxejZHZTdaYnpBOUNTQTFv?=
 =?utf-8?B?LzZqbnUyeWlqVFlMQncrUmNrb3lqbVdLWGE3VCs2Rng1KzhmZUtQRWlVUElF?=
 =?utf-8?B?ZXZIWXFZY2VoOXBlck1Hdy9jZkt2OHQ1YWNyRUtiR21GR3VMVkx3UHU3b1lE?=
 =?utf-8?B?UlRjNTVCaU9mRC9TaXptVjg0Z1BLRWJWb1Jvb3BTMzJLMjNPRzlaenJMbW5y?=
 =?utf-8?B?Mzl2cHVrRUFlcjhWUEFzcjIzSGxRekg3Z3ZDQU1LY0wzRzV2YWNENkVoWXU1?=
 =?utf-8?B?YUwvSCtMdk80MDkwVytRQzk0VVRXTnNTemhPTVQwd3pmQmdaMnd6eGRUMDVK?=
 =?utf-8?B?ZnhvZGZzL0xFa0NEZ0FlU21haUprd1pSTG5abFQyN3NTSjc4TDNEVEp6MnJu?=
 =?utf-8?B?NmRRMFBDUGIybTZmQldDem03eGZFdmlRbHZnM21qWWhuYzBNSTVIRHV2L21X?=
 =?utf-8?B?SlgvKzF2bWRSN2llYUE1RTM0R2tPN2hiT1kxczJyaG5NWHJEdHdHZ1VhdE55?=
 =?utf-8?B?cDNMdkkwbzdIV0pNWWZzMjB6WnZPVUJCWWRGU25lR003QmUwSHMvY09hQkFF?=
 =?utf-8?B?TVpYdVZBL3dXVGg0YWdnMU05RkRweldpS2xZeEpha1ExYUJLazNPbytRUHB5?=
 =?utf-8?B?dENlaEdORGljbmh2MUZ3QVdLcVRZcGNHcnJkOE8yQm9Sc1kwSWxNT0xZY1Mw?=
 =?utf-8?B?YjVwZmFIVGhOTjJ0VEU5U1psWCtIWHZicnNtazAvckRKL2gwQmtwaE1NYXFU?=
 =?utf-8?B?M1FpWktnR3FxSTVKYWNzV3JEU2NaRnQ0S09qR2gzWFFSR2FNZmNya3RsOExu?=
 =?utf-8?B?TklZRnJ0OWFnNEFTMElDNGNsc2hiRGZSUzNJR2srNXd5VEpNWlh0U2VmbWVn?=
 =?utf-8?B?YnhraFVrb1g3QXoxTWF2WWFoZ25KL0ZDdWN4UzZvblo5U0dkWWY2QmVTRG5O?=
 =?utf-8?B?T0t2dDRwOVlZNmJvTVZKcUJ5a2EyWXFYMFJGRUFNMEFxTzhPeGx5aUZ2UkdS?=
 =?utf-8?B?Z3BXaStacjE5akVzRm4xQ1lkTU9ZMC9KZERVakVsaURmNmNMT0RsNjUwb0Ur?=
 =?utf-8?B?SWp1YWtrQU5YT29CWWVOQWdBeWp3K0k2WW5oRnFPR0g3QjZUWHpsT081ajZB?=
 =?utf-8?B?bURTQzFLbk1vdDdlMEhpbDdHdm96ZmdNV0pqNHBFRjdYd0Vzd1R1RWRVTHNt?=
 =?utf-8?B?WkozVElZVkVyVnUzMDU1am9kT1RvZWV3cVlkTjdSa0RTMXFKTkxvQU8vZEdy?=
 =?utf-8?B?QU5Cc3ZSbkw1TUFtRTBIc21DeVJMTGc0dXdzNFB0UEdrTEtranNWTVp3RW82?=
 =?utf-8?B?UzZPUEo3L2RXKzc1eFdyaVdJa2FTd3IyY25sMTg4VnFYanA1dGRwZXFYdVM5?=
 =?utf-8?B?V2NtanZud1FrRndEWmtHVlFJRXYxWGNqeHlNQUp5VStUVVExYzdhQXNYQ2xD?=
 =?utf-8?B?cUYyRDdxcGlKYmllVGN5UjZWdHdVWEprQTJ4WUYyR1BQSnNHOGdNeXc4SGhj?=
 =?utf-8?B?Y1RianEvbUp5emNmOWJySEI1bjRkb3MvaFcxVTBjUm1Ja2hFQXlBSzNWS3lt?=
 =?utf-8?B?cDVQNThYYjFSR1BaVWlvN2dTMkl3UndxSzVHejhxckdCUlF5NmxIVHhqaG9s?=
 =?utf-8?B?RzE2NklMVTh2L3JZQmVqUE5hTVRFanZ4cjhOSUp1Y05DaGc4WW5uRnhiemhl?=
 =?utf-8?B?Vy9IWFlVMjBvbU9nUDNwZisrMmR1ODFKRDQzL2xwaGc2TWpTWW1TVW0rcWJC?=
 =?utf-8?B?WS8vNjBtaUpCYlVqem5ydjZydjZWVDltdWt1a0YrbHFtTXRidFJNaGJBaCtu?=
 =?utf-8?B?bEw0VU1kZTBRS3NTVW8yQW45NUdaUTV1NG51NEFXRS9ZSGtvd3JkWENIRXpw?=
 =?utf-8?B?UFZyQkpnTzIxVkNHTS9vUzRVaEVBQ0hjU0Rxa1VRa2V2eXQxbVk2b0NaWFpa?=
 =?utf-8?Q?SoyY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlhMVUFaVmlzMUFldSs4V1hJeTlCSkhzMnJheDdmM0NvRlRKaFVmdGUzNW4r?=
 =?utf-8?B?ODdsa2pibHRmYm5GRGplRVNmaHIxS0xWMklMRGZXMkxwKzZSNjB5NVFGLzBW?=
 =?utf-8?B?b2ovZFBjYk5LTDZBekhGaFBFcXhnUGRUZkF0d1o3QjdXL3RKVGFRNnM4amwr?=
 =?utf-8?B?TWNETzgyUGNLSFFrZWhTYlV6MkMzbVJiRDlhRDlWeHhqdHlGajVweEg5Vno2?=
 =?utf-8?B?SmNia05tazJveDc5Ukw1S0EwTEIxZXdyc3k0N1JodkRzekhHRjhaZHk3RURL?=
 =?utf-8?B?b3VnSVlhSnhtQkw5OW1pamp3YVN3bkVHeXRLQklRcCsreEZ0MDJidE5kbEkv?=
 =?utf-8?B?bEhyRnErZUFXYkVXSDRqUFZ6ckovODc0VTUrQjlqNHIrU1kzV0JFbUV3SVdF?=
 =?utf-8?B?TlJIbUZBQkcxMmZvVkEyL2VJbWwrTGFXVzR4d01JUDAxK2NYbjN3SE5MTWNx?=
 =?utf-8?B?Ykp3SzFDREl6SE5nVktNYmFKRFJrbUFlZTJOTloydmcyVlFYWTRhSm1WL3Rk?=
 =?utf-8?B?UzNNTkdndmdZdjZiMUw0UjVLTHBmL1ZOaGFYNDlaV1ZCVFlFalNGZ0ZDeVMr?=
 =?utf-8?B?U2dnNnRKZCsydTlYRE54MllzMW9xc2xpS0l1dlBlVmhGVFBOSlNSUElkVVBs?=
 =?utf-8?B?d3BGdmVia3grWVlyWVNYMmdXaTFOSms3V05FQ0VIekNMZVZhSnEyNmVmZzdD?=
 =?utf-8?B?VWQxVmRPK2ZOU3B5MkdtS0NldGRRZUhydEZXeDRJUzhTRlJZT0gyRUtCZFl6?=
 =?utf-8?B?VzFOOXlIVkN1ZlFKQy9SNytLWlU0ZUVKZFBXaXp6R1RCTzByenZ3R1liRUpn?=
 =?utf-8?B?VndmZXVUOFN3bm5oamViT21iU2pRa3dRUGNQRTZvWFpkd2pGR2VCRS9WWGJx?=
 =?utf-8?B?NDVNdzlKd1RKK1FGbjlWV2NuWExPQ2ZiYmkwQzZ5WTlHaFhkY01keVZPZDkw?=
 =?utf-8?B?OStEaGNvaDNyeml3c2VaUFdnbENqeHNDK2w0UUg4cWI1WkZ5cElJQUtjc3pH?=
 =?utf-8?B?cnd4eTVaRVhmTVI4Zzh1cGphUERNd0xJTlB3WThrcFhablBsRG13d1dsVTRY?=
 =?utf-8?B?c1pUTWZFNXB3ai8wdWl6ZG90Z1BJdi9oMXNmUHl6RnM3a09sNEg1OHlSa25n?=
 =?utf-8?B?Yitxc0txanlyWjZPQ0ptZmJzMFVrR0lWdndkRDNkaHRFanlaWFg2Ymo2cWp6?=
 =?utf-8?B?eGpvRldYQ3N0eGprSFBoOVZDeWo0bS8rczA1S1U1SWNVbjRGcVpNSjZEUkRM?=
 =?utf-8?B?N0VQNnlWTzVVMUloMlg0OGhEWTRwamxHZXF0Wm1PcGhyazlKWEhhenFpd0dH?=
 =?utf-8?B?YnppOG9Cd0tESUpkcmZtYXViN3V1UGxrdEx3Sng0SFEyVXV4TEVYdTY5dGZG?=
 =?utf-8?B?YWZGY2lMZjVJdVFGMkl3NDE0ZlRlK0VxTzFVWndNVGVEUVpJYTQrc0xGa0Zl?=
 =?utf-8?B?bUo2L2dNanVMcStFd05JNFFSakl2ZGppRXhKUVJqTWlDekdIc2NYOW8rak9p?=
 =?utf-8?B?YVhScXI1cVBhTDhBNzA3ckxrRFhqOEM0RlFFUFM3MHJtdnZnK0J0eEtCTm9E?=
 =?utf-8?B?c0ZaM08wZGJlVEFWdjQzeE1KYWZ1ditFVFB4RHQ2TVdRNlNVeGFqcVR2bUsz?=
 =?utf-8?B?R3Y0eU5tdTd4THdiYU4wbllsbjNDbVRuaDZCTzE2VXl2amxHWG1JenZCN2lq?=
 =?utf-8?B?T1FETVdBZnFhL2pmemhkaWJSeElIdytLdy9WSmRHSU85NExVQU9Vd1lyaGhz?=
 =?utf-8?B?bWx2endHZlc0eEhrVnpVdU9wd1RjQlBNOXViajFMaDlhcVRNa0lFeDRDZDRE?=
 =?utf-8?B?UGxzeHVuUHlUUVdwbzZiaktrTG54V2dKMzZRaGRaWlN3NTg4S0xveVExbnp2?=
 =?utf-8?B?b08zMU5KTm5RTEY5NlZFUnVjVDUvbTFOZytrMkgzZFdhZ0NDbm8wR3FtbFFI?=
 =?utf-8?B?L2NQU2xPNE5yeFFGL0xKUi9wSlRqOHpnSHpFMFB1YVluQzA5bjM4bVFhTUtv?=
 =?utf-8?B?ejRrTjA3UStFbkwzcERDblRjMXRjSmluS3NqM3cxdFRsYlhHcGhSZ1B6THBh?=
 =?utf-8?B?ajNiV2FnY1hmY0JaTWtsR0pUb2R6MkY4bFNUOU5TczJ0Q3lGUHRYME1LRE5G?=
 =?utf-8?B?QXVCYjQxSk9LVm9Zc2R3eitoNE9ZbUtQcUZScHo4K0lvZXdxc3F0clE5Nmpu?=
 =?utf-8?B?YXFRVlRmaDAvWk5KaytTRHlUc21WTnRXbFJtSzFwOXdQTk1XbndWdm4xazlN?=
 =?utf-8?B?TWlHYlVyK0ZDVTBaL2ltQ3BUV1dYS0JHZWpLM01pRnJ0MmFyb0JETHhFU056?=
 =?utf-8?B?UXZnRWJ3M25uYlNNdS9Wa1gyZzQzbzhSK0toUTBBdmJtekttcVFBUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a528f253-898c-41d2-9bdd-08de655d4c17
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 08:54:11.9594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mm8pSD7X/OledXqWRwD2azYYgucWQzcGMRDZdrqB5cpPT++iRrD/3DAKWK6XkBr5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699
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



On 06-Feb-26 2:05 PM, Asad Kamal wrote:
> Use U64 for accumulation counter in gpu metrics for smu_v13_0_6 and
> smu_v13_0_12
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> index 07d4cb6562b0..ffb06564f830 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> @@ -140,7 +140,7 @@ extern const struct ras_smu_drv smu_v13_0_12_ras_smu_drv;
>   	SMU_SCALAR(SMU_MATTR(SYSTEM_CLOCK_COUNTER), SMU_MUNIT(TIME_1),         \
>   		   SMU_MTYPE(U64), system_clock_counter);                      \
>   	SMU_SCALAR(SMU_MATTR(ACCUMULATION_COUNTER), SMU_MUNIT(NONE),           \
> -		   SMU_MTYPE(U32), accumulation_counter);                      \
> +		   SMU_MTYPE(U64), accumulation_counter);                      \
>   	SMU_SCALAR(SMU_MATTR(PROCHOT_RESIDENCY_ACC), SMU_MUNIT(NONE),          \
>   		   SMU_MTYPE(U32), prochot_residency_acc);                     \
>   	SMU_SCALAR(SMU_MATTR(PPT_RESIDENCY_ACC), SMU_MUNIT(NONE),              \

