Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DCFC27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 18:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F14AC10E9A7;
	Wed, 26 Jun 2024 18:56:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BjT7kYeR";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73AD310E9A7
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 18:56:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkXHF4db9wsI13zU0pkTwlqbsxU07VQBfU21C38txbBvkPxzLr9nZ1PvtazF4QeurMSXcde7YYOrSfj7CTdeSf15y1B1lcJf0itdDDHXeIM/H/6sqUWqfJiAY17P+cI7Jef9dWh5zdv0Yv/8/YXsOMokSaqZQkUhg1Yuif/TrLq8l81qP3wXTjW/55etQkytxJ0lx/wjdNICjfZH3k4DkIEDawHgMnMatF3EheksI3vzqm7+B4rztwFvv01eNwktMBoeNHSXe9t++T6ZRHRAt8TpegO3WnM456R7AKWT1ez5M6AxHrHdpq2OoAVbVyaa+Zksu//nALrwttyAB1fvoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdqIqw+fgeCDxh/J4+RuQy0YXffHNRbcJDoCMmfL3QM=;
 b=Mo/iFxFsLR3fqZBU9ONb+XtLPLX4+7La+lqwt7vLhv3sv1CIxdIinCpkrhQS3+bJXSDtUxFMdDwDF29+IBPcxjTMdMu56wBSD+5o3g01ORgFOQ8/gZdyjSeHQXH3zcwWis0y/N6naJduk+kmuG+g6aVLXuWpkWnHIMpoAcl/RxouiobQWDyPuN09zDxlFEsC8tmETJqhLD3mmaht26cLvjbbGlZd82fRkce3o3FAKOLNw7RBVqBQqzYLesiW0ULVwbTLKG9KbqKFtGTkaH9zlhZWyGftI3ccL+8rQXt2odVSHh5fr2GlbuTwqlhmQwNoWWUHnVtDZlJIJuQbB0oz/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdqIqw+fgeCDxh/J4+RuQy0YXffHNRbcJDoCMmfL3QM=;
 b=BjT7kYeRDdnhbWl35PI+Jo2Z+QQLEvj+rofzl5m8+qhWqFl0zQfbQVHNmOr148aRtRWRG4sMZibPCHrOtFI9PJ7tGt7PiHbmenz+NjGKGbFLG2Z/ZnGNaoHxM0epYs7imO6F6udnUmYdgxEnzjISMvQUIaKVU/kJda7bVTblnh0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8)
 by CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 26 Jun
 2024 18:56:18 +0000
Received: from MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::71a6:a9da:c464:fa2e]) by MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::71a6:a9da:c464:fa2e%3]) with mapi id 15.20.7698.024; Wed, 26 Jun 2024
 18:56:18 +0000
Message-ID: <7ad57f30-d79a-46f1-beed-bb494c9e7d08@amd.com>
Date: Wed, 26 Jun 2024 12:56:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix null pointer deref in
 dcn20_resource.c
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com
References: <20240626171648.660826-1-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20240626171648.660826-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0311.namprd03.prod.outlook.com
 (2603:10b6:408:112::16) To MW6PR12MB8733.namprd12.prod.outlook.com
 (2603:10b6:303:24c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8733:EE_|CH2PR12MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb77345-6a75-4029-46b7-08dc9611a943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHJPU3hZRmlsTUcwMHNjYkFNRUZVZG1PZ25NSG00Q2FXY2JZSGVtOGtZQXNN?=
 =?utf-8?B?d0N3bnFqVENHYkx0dzhjdzV2QXc1Q0I1UE8yNG9tWDI3Z2dBL2c3K1ZIaThF?=
 =?utf-8?B?d2E1L0JUM3ZNdGs4SjVGalNWcUdsYVRPZGxkcE5JUjdHZUNqUHpNZjdGL2tV?=
 =?utf-8?B?SFRETWFGejFOdVBFQmpET3dFKzRyVG40M1hKellTaXhyR0RYYUhqWFpXSHRO?=
 =?utf-8?B?Ri9vNlY3THNocVduYkl3QjY0MEl2dkZNenpxUS9EbVI1QmpyMTlLMUkveXFP?=
 =?utf-8?B?KzJ0Y3lhbmhvS0NMc1p3STVMOG83Znpna1ZHd2tLN0Vxck5nYzFLWUJSbXBa?=
 =?utf-8?B?MUxtWTREckNESktvSm96bWxLWXFDcjdDUTc2SlBxZFhvSjdQblBKMHVxMkl6?=
 =?utf-8?B?Z1dBdWRRdUlrK0NLa0lnN1g1cUV5VENLZkFNWkFXclJFSE0rdlp2alJEbHhS?=
 =?utf-8?B?Ky8wcENaRFZUTGhvRXE2dmFHQXFmWTh1WEE4VEJnNWMzZ2xkL0s1Q2JtcENN?=
 =?utf-8?B?TGo3OFE4ZDUrbDQ4UWxoMHdPQ2ZGWXI0ZFdJVkdiRThCeGMvYStlYlRrWExp?=
 =?utf-8?B?YzVOTjZFL1pmWDFSM3hzd3Q0WlRLcGE2Q1M5bVBSYTU0Y2NwZk4vbFFjWFRS?=
 =?utf-8?B?UkhENFV6c0ZlQlJweDBwaWNlM1IzSzVxdDNhVXNvc29hMWc4MHBPeUlReTEy?=
 =?utf-8?B?blVOS0Z3Slg2NVY0VVJQTk1xWHRRbTl6Y2o2TExNZXNySEFyRWc2Vzg2YTNj?=
 =?utf-8?B?cGZtcWJLNGUrUVNzb3R5SnJ4aENzWTVjbHZhM3R1L0N5cTZrTGpCT29GelNM?=
 =?utf-8?B?SzROd1lLY1U0aHBGbVR0OG9SSlpkRTZpVDJ0NGZaK0ZOY29vZ3B5NEE3bHNQ?=
 =?utf-8?B?cFYvMFJFdDVNMEpDZEpPY09HU0RscXh2eTNuT1AvL0JhVS83b2lDSlRyOXp0?=
 =?utf-8?B?dXNlSVo5SFhlME0rMW8zOTRwT0lRS2NId0cvSWx0eHFPSVhaMTI0ZlBLUXAw?=
 =?utf-8?B?bXVXZCtML0YzUGJiSlR0bG5HT0F4ZjVTTWh5UGNUbE1hb2dlbFlsa2JPR2di?=
 =?utf-8?B?SjVlbGlwcEJkaERhd1BoMk1jakZnQllyenNqU1Z6U2MvVU5rOWk4TEJWRDdt?=
 =?utf-8?B?elZyN2tCa0g2NnRDdDYrQjgyVCtpTlhlbENEVVM5SFczTHZ4UEdxcUlaWE1K?=
 =?utf-8?B?T0JxTGVHYVRhS1dmSjJBS0YzSmNoZWlFa2NkMWwrVUVKMVJpNXJjR3VYR0Ry?=
 =?utf-8?B?SWJJV1ptRWVHQURjTjFNam1xTHRoWVpSQ0VydU1sTEk3Q1ZiWlFER0V4cm9a?=
 =?utf-8?B?MUdQaFdUNDdMUDl5OUNxbzdZQ2FqWThJUVpQMzhReENHQmRNVG5iS1ExM2t4?=
 =?utf-8?B?Z04rUXhvc0x0MjdPd1BKQi9lb1VNU3RXS0JCd2FMM1h2dUdsdFAyMkxoTUpP?=
 =?utf-8?B?dTIzNnJIUzZxQ1BaUU1FV3BpTXNzUUl0ci96SWVyZW9GcytTVUJaaEgzQllO?=
 =?utf-8?B?YTVBTFprclJKc0dNc0xXMjBUQnpqMUlpY2thUkVpUjhieUQ2SDFFSmV5VHdO?=
 =?utf-8?B?bVhLLzhvZ1pyT3FZdVJudjBqTXZySVgvVlRGbEI0RUEySnE3QkJPUTVEQXlB?=
 =?utf-8?B?TmtCNzFxS2xQdzJjbndtU3crWkpCQnZXMnB6OHk5STNxTWZ5Nm1DZVROaU1X?=
 =?utf-8?B?ZXpaVDhPKzByYUxTT1NsS0tVbjJJSFc2bU04ZFVHSFFtZlByT21JYWJhaXVE?=
 =?utf-8?B?ZzY1NGgyZTVuRm1sNFVIcGwyc00vREplWGhqU1M0cFgwR0FGTitTcVhlc05v?=
 =?utf-8?B?K2Nud0p3cURRaWJCVUlUQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8733.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230038)(1800799022)(366014)(376012); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K242UXRHTFI2R1VSN0JVdkZwb3dLTE9CZk9GZURwZXVhM1J6a1FmR3N3ME1Q?=
 =?utf-8?B?dzdoRUQ0Rm5DR0k2bjBoUXBIYmpqeTFlejFOOUx6OHdZakpPVXl6bGk5OFQz?=
 =?utf-8?B?MVF1dUY2dEtJM283RHJlbi9DcmtSWGUwaUJ3R2pDamJtR1FYUGRuWEVVS0R5?=
 =?utf-8?B?VVkyazd1UjlUZ01oWHltNStTRWhHSGNUY0prQUl1ODdPSXFBamt1c0pnK2lM?=
 =?utf-8?B?MGQ4eG1iTkQzdmM0eldkVDFESzZsOEJjZ1N3WDFwaERReC90NnpBTWhzam5z?=
 =?utf-8?B?MGtGaXF2NC9JVzkrcDM4Q01DdEgvT1hBK1p1NzQ0QjRLRHphbVhoRXZIek1G?=
 =?utf-8?B?UzBnWkxzUEZjMDR1a1ZuSk9QTFV5ME0yc0E5emlnc2VkL0FtY2lUdUdpUUwy?=
 =?utf-8?B?TGtQN2N6RFBxZCs2UkV2RmpFY1BtaVFscmtHKzV3aUg5L3doZnJkbG5iSGc4?=
 =?utf-8?B?c2cwL0NxZXhaSUxMNVFlNUdaNU9pL1UvN2EvQi9NOGRhRFI1OHFhQ1RaM2FM?=
 =?utf-8?B?ZzV3bE5BNXphMDZVQ3BaQ0M3bWZuckM3RjFYNHpncHIrN2FQUlM4N3BLelpk?=
 =?utf-8?B?YWhiczBrSlNBZHcvdHZpYjA4M1lkakxTVUpVWVI1Y3JQaHRJNTEveXBUdDB2?=
 =?utf-8?B?WU1jYlBHWmxvblB2Q0V4OC8ydkkyclpHcnZ0YVVHRWZBM2RHTXhFNkhOUHhy?=
 =?utf-8?B?SFJYblZZRllHbEJFdFd6WUtTcElkSGtTekJVNy9CbStUZitOSks1aUZma1Z0?=
 =?utf-8?B?VzlRcENnb1lOUmFaUHpjd29zUVJpazllTmltRzg3TzRDaXhWQjJYQVdURUZE?=
 =?utf-8?B?Q1JCNG1TV1hneXlPcWFta3l0OWJoVzEycUVjdUZ5UDJ3T2dVSzhiSGxZVk5E?=
 =?utf-8?B?dUVscGhSZWJKZkpzbXJqMS9BMXd5cUlkQllLakF2aGFsTVl4dVhMa1NHdksy?=
 =?utf-8?B?QTZTOUowUjFiaklaekpQT1BHUjFwWklERVZnZTQzY0x6dEh0bnpkLzdSL1dM?=
 =?utf-8?B?bllnOCt5ajFoa1N5WkJYc2YxNjNQdm43VVBwV3RQMUpDTVV5VGpsMEMwNmlw?=
 =?utf-8?B?ZGVXaG9JOVhCd21EUTlZTStMT2lpa1hiSmlJTzVaWXExcERzVC9FWk5nMXFM?=
 =?utf-8?B?T3ZxU1NPNHoxejJkZVBURW41TERyVUlHOVlVWDlybm1NR1lGNldQS0M2eTBH?=
 =?utf-8?B?aEtib2RZYnY5S3lQQmhnSXVOaXdwWlkvU1IwakJKTVB3YjVHU1VtZDQyelBQ?=
 =?utf-8?B?ZUJVempveEsyWHU3RFhMVmJHOVAvNGhadkllQkxDbmFwNFZVNUV5bFFPcWZq?=
 =?utf-8?B?TnFvM2RYMjZjdGp4Tmg4Lzg5b2pxU0pxRDMvSWdOQ1dlTmNaNjRHa1hMNFo3?=
 =?utf-8?B?QWNuTG5lcEp0bldJRE9zY1VmcE1wMm5rNVVSOTFYdUh4WE9FaHBDQitXR3Ns?=
 =?utf-8?B?bzVETW15bDFTaFM2eU0vdXNadjMvbEVDdVdwQ3FFZ0lGT0JEOUtkZVB2SlpB?=
 =?utf-8?B?Wm03QzBZdmk0NnhoUE1STzhqQ2pleEZrZ2pkTVZkSTN0WnBGZlU5dHQ4VjBF?=
 =?utf-8?B?NlFJeHFlakJOTXBvTGlmRnBqeTgrYVpodUZ6WEVLV0o5UFJ0OEtBbDZTVkJw?=
 =?utf-8?B?eFArR1c5aDg2SXZVVkQyUVp5U1pPZ0M2b2dubXVDZ2k3RzY3VUhHY0xPUTFY?=
 =?utf-8?B?NFQ2VVhuS2oySC9kSG12cXo2aU9FUTJTVzZJcUtNVUQ4SW00cE9La2ZvTWR0?=
 =?utf-8?B?c2lISitaeWRJTzFlRUJDWkZOaHBzTy81bkI4Y25FZ2I4WVkrUFhBVjBaWXVN?=
 =?utf-8?B?NkdQMjJaRXRrTFZsbnFTeERROGJCUm1JeDMrLzl4TjhRRGJDMEthUTVpMnds?=
 =?utf-8?B?eGdRWWZlTG0vRVl3SEN2YTk2TmtaU2lCNTJ3ODJpdlRTV3FjRHE0RmtKWkRS?=
 =?utf-8?B?azUzTFJTRFdjR3cvUUc5ek1EUlVJc1NUdkd3azdudk9wMG1laDEzUmUvbHZv?=
 =?utf-8?B?NCs5cmZTT3F4L0s1Y0diMjVsTG50S3ZlTE5ScGpVdVhERUxmUmV0ZlJiSVZv?=
 =?utf-8?B?cmQ0eUM1dlZYbS83QnF4TGRpeUxiY3FmZHYxdTRla1djSlp5dm1ZVEFpWkM5?=
 =?utf-8?Q?NfmKOvhVcK+u2ou3dEJooaJQa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb77345-6a75-4029-46b7-08dc9611a943
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 18:56:18.0078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qqX90gtBW9qVMZQINf+Br0x6ZBwUqX+H8AsVauJ3Xw0ArA8PjYlOP4hRG0Nnaj7xScmz7S907bzTQBmKxfSzTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215
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



On 6/26/24 11:16 AM, Aurabindo Pillai wrote:
> Fixes a hang that has the following calltrace:
> 
> [  181.843989] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [  181.843997] #PF: supervisor instruction fetch in kernel mode
> [  181.844003] #PF: error_code(0x0010) - not-present page
> [  181.844009] PGD 0 P4D 0
> [  181.844020] Oops: 0010 [#1] PREEMPT SMP NOPTI
> [  181.844028] CPU: 6 PID: 1892 Comm: gnome-shell Tainted: G        W  OE      6.5.0-41-generic #41~22.04.2-Ubuntu
> [  181.844038] Hardware name: System manufacturer System Product Name/CROSSHAIR VI HERO, BIOS 6302 10/23/2018
> [  181.844044] RIP: 0010:0x0
> [  181.844079] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [  181.844084] RSP: 0018:ffffb593c2b8f7b0 EFLAGS: 00010246
> [  181.844093] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000004
> [  181.844099] RDX: ffffb593c2b8f804 RSI: ffffb593c2b8f7e0 RDI: ffff9e3c8e758400
> [  181.844105] RBP: ffffb593c2b8f7b8 R08: ffffb593c2b8f9c8 R09: ffffb593c2b8f96c
> [  181.844110] R10: 0000000000000000 R11: 0000000000000000 R12: ffffb593c2b8f9c8
> [  181.844115] R13: 0000000000000001 R14: ffff9e3c88000000 R15: 0000000000000005
> [  181.844121] FS:  00007c6e323bb5c0(0000) GS:ffff9e3f85f80000(0000) knlGS:0000000000000000
> [  181.844128] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  181.844134] CR2: ffffffffffffffd6 CR3: 0000000140fbe000 CR4: 00000000003506e0
> [  181.844141] Call Trace:
> [  181.844146]  <TASK>
> [  181.844153]  ? show_regs+0x6d/0x80
> [  181.844167]  ? __die+0x24/0x80
> [  181.844179]  ? page_fault_oops+0x99/0x1b0
> [  181.844192]  ? do_user_addr_fault+0x31d/0x6b0
> [  181.844204]  ? exc_page_fault+0x83/0x1b0
> [  181.844216]  ? asm_exc_page_fault+0x27/0x30
> [  181.844237]  dcn20_get_dcc_compression_cap+0x23/0x30 [amdgpu]
> [  181.845115]  amdgpu_dm_plane_validate_dcc.constprop.0+0xe5/0x180 [amdgpu]
> [  181.845985]  amdgpu_dm_plane_fill_plane_buffer_attributes+0x300/0x580 [amdgpu]
> [  181.846848]  fill_dc_plane_info_and_addr+0x258/0x350 [amdgpu]
> [  181.847734]  fill_dc_plane_attributes+0x162/0x350 [amdgpu]
> [  181.848748]  dm_update_plane_state.constprop.0+0x4e3/0x6b0 [amdgpu]
> [  181.849791]  ? dm_update_plane_state.constprop.0+0x4e3/0x6b0 [amdgpu]
> [  181.850840]  amdgpu_dm_atomic_check+0xdfe/0x1760 [amdgpu]

Hi Jay,

Could you elaborate a little bit more on how to trigger this issue in 
the commit message?

> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   .../drm/amd/display/dc/resource/dcn20/dcn20_resource.c   | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> index e783afbbb397..645927496807 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
> @@ -2200,10 +2200,11 @@ bool dcn20_get_dcc_compression_cap(const struct dc *dc,
>   		const struct dc_dcc_surface_param *input,
>   		struct dc_surface_dcc_cap *output)
>   {
> -	return dc->res_pool->hubbub->funcs->get_dcc_compression_cap(
> -			dc->res_pool->hubbub,
> -			input,
> -			output);
> +	if (dc->res_pool->hubbub->funcs->get_dcc_compression_cap)
> +		return dc->res_pool->hubbub->funcs->get_dcc_compression_cap(
> +			dc->res_pool->hubbub, input, output);

How about drop the 'else' and just return false?

Thanks
Siqueira

> +	else
> +		return false;
>   }
>   
>   static void dcn20_destroy_resource_pool(struct resource_pool **pool)

