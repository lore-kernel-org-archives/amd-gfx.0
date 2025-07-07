Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E04DC83F07
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 10:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2428510E432;
	Mon,  7 Jul 2025 10:21:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v4Gp6czx";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDEA810E432
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 10:21:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0FnkiiQEZs7wCvhJ2QoCOImoJEG/7DD/AJY7EJ1AGW2ZxSUMAX4svonuusWwRwG24Ena/x5keLMRQGoqicUZPXzxc/1m6Q+VK1AgZ9DMRAtCUvDKcpLOInstyNFIOEpEer5BJw8WvbiYIXR2F+EdBH0+DoEHO/sSbRJ4IraSsU98O2vxddE2j/i82quux9KO+2x8lVu8JfOH25/lz6P8FGnsBUMaPxblrIdZ7cj7lrtG0lnonWIB4rjXPxvKjUOd0EHrHbxvzbPZObaO9UIXkkq62ulssgqIraYicH2KHUyaSftmN7P5aZcx6NNA9f5Z3N0eek5Q3TfLJsIws4zjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQqLBHLFWcBTnUUC81hLGazE+Nafy2gu8wLUJ1y/qXA=;
 b=bed0+UB8u0wlPWzXszjwlQtBFlQhkXrsZL2GsYraXDEUYpXZ6IuR/l7j+EkGESFKQN/+u48ESc9L5tTMw5CDeQ2eutV6efbI+LxyuYlKNOKxv+hGkwL2rCblbDSC7RVr985Wj4BMrVDpdEP5AHaXd77d8EnJRCqMwvTX5HTBTddrZ4V0m0FWJ2hlIvBqG5ZxMGfarAmhA2tWFGJLUnzTgQXDoi9BbBgHrnCZnQy1M/8FH9H6a2/FPpF+v7jm4A9DkO/WSl1Q1CUZK0NxVniocJc9Yuilxj8p9Se6iyH3YVYrrHGUzf2L514tJ6oflK2a3IFy0rEhL/fCKazPB4frvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQqLBHLFWcBTnUUC81hLGazE+Nafy2gu8wLUJ1y/qXA=;
 b=v4Gp6czxC0Gt7F1p095jhhUT0sKaeUFmTvXEYfXSqWCFlD8K2P4M0DPungABSr5HU5/TDITCw+ijTIAWWo2GtsMBuiK1pdUxNWypfLOa9b3+A5PQ0SNu3FUKo/xwgLuoeckveNnw9wolEpdUMIdDBRt+QbgmBUQljRSaX0mxDOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN0PR12MB6078.namprd12.prod.outlook.com (2603:10b6:208:3ca::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.23; Mon, 7 Jul 2025 10:21:08 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8880.023; Mon, 7 Jul 2025
 10:21:08 +0000
Message-ID: <08270c9a-c3cc-480c-88a0-d9f557e5e56b@amd.com>
Date: Mon, 7 Jul 2025 15:51:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: refine eeprom data check
To: "Xie, Patrick" <Gangliang.Xie@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>
References: <20250707070939.6852-1-ganglxie@amd.com>
 <a3323f38-1cea-4880-b048-a9a3f926fe5f@amd.com>
 <MW5PR12MB5684F3A682D867FA094ED40BE54FA@MW5PR12MB5684.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <MW5PR12MB5684F3A682D867FA094ED40BE54FA@MW5PR12MB5684.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0128.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN0PR12MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a6231d-91ac-49b2-6476-08ddbd3ffcb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nkd0cEtIVWZjOTFrdThITVpIWDhOcTVmVTBuWWdXanZwc21uYWRVWnVaZDBx?=
 =?utf-8?B?OTF2RElFM0NOa1lPMUZrdzdSb2JkTmY2WG1BRy8veVEzamxMaFJqak9mZHho?=
 =?utf-8?B?N3o2bTJkM3F5aExPemVKTkYvaERxdk1nRGdMOEJOMjhYcElGSDZTMno2dlB3?=
 =?utf-8?B?dXAvczA0UXdZWGFXVUtOMHgxVE9ReGU3c09wenUwSzA0SGJCb014bTliSjVI?=
 =?utf-8?B?ajlBcEYxT2VaRDRoZ3IxRFFROEtMMXltT3h6U0N0WW14b094YW5Ici9KU2hh?=
 =?utf-8?B?WThHK0hmY0p4blcwY3FJT2tiLzVUVVBJckN1dEUrNUZVWTljSCt3bWRJTnpp?=
 =?utf-8?B?ZTZzR3BONE93NmtvK1dKVXp3amhLU0dPSE1kTzNlM20yemFNRkt0Mm9XZjlh?=
 =?utf-8?B?NlJUSzBKZGxjMmo0TlkrV2cwT2cxQzZ4THRDVFlsQWtmWEhSdWJIa0RCYmxW?=
 =?utf-8?B?aGEzSDI2ZVgyUzVrK0tzRTltSEoxa2VNQmhMa3I1QzRoNVhtLzZwU0kxR09W?=
 =?utf-8?B?TW1wVFlEM3lkOVlhZWlhVStpRG52ZXRmZWpwbW9VcTZ5bnBDdXUrd2RLKzlQ?=
 =?utf-8?B?dWlBclBPa3pjZFdzOW9NSWJLa2s5cXZpUlVvNldjbFp5Nlg1cXErVWEzcDJ4?=
 =?utf-8?B?K1lYclNtMzJPV05wcG9oUU9WTUxiQktsTmZyb0JQajltMWVDdHdrQmdhQmd3?=
 =?utf-8?B?Q2NMb3FUcnR5bXo4akJRQmxpc1FQSE9aNThBZkNVV0doZW02ZXJSVk5nWmFI?=
 =?utf-8?B?VE5pM0RIbWxmOHF6ZG5OM3lONUlZbHpRc0VITE1YTzhEQkxPV05Ib2pzeXFR?=
 =?utf-8?B?VnNubFRGZFRnV0lCWWlneXdnQUl4TExrNkNDUDZTRy8rTmJKNTlVVnBpZ2NJ?=
 =?utf-8?B?SVhqRHBNb3NiZGdwVFlZTE83SWEwdHdZU3NJVGd6MG50WU5xVU1ZNzZRNHpa?=
 =?utf-8?B?bFcwUzNIa0N6THpBbVJ1QjlsUERrOWRwZE9YNk8ybHBXWCtheEFiZXZGTEh6?=
 =?utf-8?B?N2huT2RkLzhud0NFeFVXZFpacjkxMGtIM1ZPUTJvWklzb2ZGaTQ5TmVLTjlC?=
 =?utf-8?B?RmU2S1RPbklPUTRweWJJNm9uOW9NUmI5WHhmRTA3cUYxUDFxM0dKOGJXVXhk?=
 =?utf-8?B?bm5jRzVyVTZEK3c3SUIxallHQU95aDQ0MjBXQjVSMk02WWlVL3FJUnI1YlZM?=
 =?utf-8?B?WE1JaEtTb24zVGpzaHRucFNmdGVWWFVVNmxCRWlmaHVQemR3cmpVZ1RXOGJt?=
 =?utf-8?B?V2EwdkxFNTd1LzhscmwxQmx3K3dHM3A2bzNQc2tvbEtEVmJXVjM3bjFycXor?=
 =?utf-8?B?bGxMT3llaUg2RkhxZWFtYUpMREo1ei9hRGZuSWZFaW9COGkrVGlvT0xWTWla?=
 =?utf-8?B?ZXIzUEp3eFoxK3B3MjltalB4OUs0ODhuMktobk1ReTlrYzRzdzNxdnRHdERT?=
 =?utf-8?B?ZkVRUGxYLzFveDhEeitsaC9yeTVUN1FuOGlXeWRvcjkzWVF6cm04OXdNR0w0?=
 =?utf-8?B?QW9QQmZlR3dPbXUzSVloUlcxWmdvY0ZJcGlYbWtqVWlCeWNYRUEwMzRyaFdM?=
 =?utf-8?B?SEdjTmh5T2VXZmhtY3h2WGFNSmRqUUwxSEJMREJpeVJ2NHVRSU1jUCtiSGFz?=
 =?utf-8?B?akVUT1d0UEcxZVRreVQ5a2tnWXdmSWg3N3JlVEdmVVh1ME4vVjBsYzJQTWVB?=
 =?utf-8?B?ajY0WEZaYmhEeGwwVnpqdVdpN0VoRHJqbDRaNGxaMTU2WE5KRU1Jdk5sUWZx?=
 =?utf-8?B?dmwyUWpWSW9rOTNTRVFaRnJGZ1NqelpUeGFDMWMvT1ZTMno4L1IrTUlOd21Q?=
 =?utf-8?B?SEpORWNySE44NXZVTkhmWUUwUlRtd0xCNU15alpHVVFrWVU0OVBpU05uQnRK?=
 =?utf-8?B?STN3TkhDZXkyRXZrdTBJTVQ3Y2lrazB5RFFSRXpQb0VlNnJyYTRHd2pYQ1Bz?=
 =?utf-8?Q?SnfcV/WRjBo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzdPTGRVY1Rrc2VJMHVlZXdnSEtvSzdSQTN1TTd5aUJkU2huSEJqUWduNUIr?=
 =?utf-8?B?eXpVN0N0dG9naUZxdlIrUldhWmRGV0VoL2NGejdzcCtsdUViL2l6UHZDRk53?=
 =?utf-8?B?QXkwUU1LTW1obUN6cXdYY3ZSMm1aaXFoSUxvbVZScTd2bWFIVks0Nm5TR05u?=
 =?utf-8?B?dE5rQytrTlRSbFdSOVJaamc3bWtGMGUzSG1kZ0t2UjRHVUlGSkxiYi8rMUJY?=
 =?utf-8?B?eHZUU1pjVFF5aUpLY3BQSFU3U2krMC9aWnRIMk8xOVJnM21Mck5XNE5LY1lm?=
 =?utf-8?B?aVJHWDBNdmRWbWNnVEsrTEY4T3FwOHNwcDVXSmpjQ3JQbjJuejdPYVhvdjBD?=
 =?utf-8?B?OUo3MlFJNG5HZFNTbG5tVEo1a0JwZERaR0RRWjFrVkxKeEZPOTJDSjZKaTZt?=
 =?utf-8?B?ZUtwU0xzR05QOFpNUndWZVZpbUlWSVRVb0pwSGs2T0E4am9iTHU1c1dsd3p1?=
 =?utf-8?B?NmkzN1VFNHRJRmQ4WDlCT1llWEJPSXZ4djdMQmMrMkZjSjVlNU1NQTBVVlRx?=
 =?utf-8?B?RzZYcTlqaDhNb0wyUW9ZeHZKRXFXZEp1UzJQMFpVKzBzM2N5UHM5eDZWZjda?=
 =?utf-8?B?cDl4YTFBajhqN0RidGhqbGRhamI5RFJON3MyeUx2WUNtajZUTElFeFJLaDQv?=
 =?utf-8?B?aDFaZTlDRS9wRy9CbWVXeXU3bmd3dEVidEVzOHRJVGtQclI5YnZNVis5a01v?=
 =?utf-8?B?M3BIN3IxbnZ5VVR4M3lsWWNEQXhzRm9sM2ZTWDVCOFBGUlR0WjNJdE9YdjlW?=
 =?utf-8?B?QmJJc0V1Q3RncW5UTFF1SVJiQzVUVEJzK3J6VCtMNlRUQi9VYWg0NXpjMC9P?=
 =?utf-8?B?dEozckpIWmE0OXhRSG1KNENuNjRUSk1jNGNXMUNiT0l3cjloZmh4Q1lmTjN2?=
 =?utf-8?B?aWpQTnY0NU5zVTFuNjRXaUF6SW9HTzBDckhHT203bjhEOENoYWZhL1dBRTNO?=
 =?utf-8?B?ZFZ6eWFXS1gwNExFY0NWV0pRUlBtdjNGUk9IT3c0RDZHZFhUeTBBYUI2ZEt5?=
 =?utf-8?B?QmdGMHgwcDhhcm5TV1pvWmNvNnpxZFp4djRMdFBFZzlxUWZYbC8xTHN0c3Bz?=
 =?utf-8?B?Tjhyb1plTm85bVU3ZFF1RGozbkJiVXY5aTBQbm5VdU5uekVzT0VYQitHQ2dk?=
 =?utf-8?B?d25LMzQ3T3dmb05oSkNoNUFIRjBnR3JweVBiQ2tZY1lnZG5xOUFlVkgrQ1ow?=
 =?utf-8?B?cjZsNGVoM1lSUkdrbTMrUENvd1pTYjZFQklFUkJoSnZWMVJsYWpYZDlQTGs2?=
 =?utf-8?B?a3FwS2N4RlZXcCswTHd1QUMvQk9iZGZBMDJ4WDRjZnFxU1ZPM0dNMlRxNjhk?=
 =?utf-8?B?WG5IUWs5TVZMM0tBbWRudXA4SXdhM09Ec1NEbDdyTUNoU2ZRL3psL2hVMkIv?=
 =?utf-8?B?UTY4RnV1M0dmSE1XbGp0M3pVNEkxTVNTaEhVWk5PQ1VFY1UvcUU4SzB5cHZR?=
 =?utf-8?B?SngwV1hDQ291Mk43ZkxEUFVwSktpTFFGY3BLTVdldndLTDdQUklHY1BGcHA2?=
 =?utf-8?B?ZkpFUFdGMDNOakV0dElVdVVvblgySW1SSFg1MlI1RTdrcGFmaHpJRlJhaUJp?=
 =?utf-8?B?cWVrL3BJYmtFcndLWHBBdDNoYjdDUUgyRXVrdUxVRi9tT1VBTVBYYjMwZlZv?=
 =?utf-8?B?aG1aNWxTMGN3d1E1U0JXeXlVSzlRVDJVYkt5TGlRV0RTVHpTWXZqbXMxbGxH?=
 =?utf-8?B?dzFUbUhsNTdEOTcrYjFFVkNBWkVvTXFDeEJXaEx6QTZFeFllLy95K0x1RnA2?=
 =?utf-8?B?MUx1MnlWUnF5ZnNzVVBrQ1hTNnN6MnNMZk5IWkZvTUVkMUZIQzlrOUF1YjhE?=
 =?utf-8?B?V2MvQXlKL3hQQUdING0xM3dHODdyajREd0NHOTAwQkZMUUdMMTY4YmowUzhh?=
 =?utf-8?B?c3pLNVM3L3N5OFNoYnlFM0lraS9FU0VvN1VvLzhTRW9USlFWcFd5Sy9YWnRV?=
 =?utf-8?B?VzFCMVN5aHNMSGtKZUNIRnJpZEFHWTQ3QTFpNXRXZStKN29NRWhzdVFqRDFE?=
 =?utf-8?B?TDVZU2Z1Q2lFM3c4d2NqV3BWTzNQbGZBUVVwaWgwM3lIYjZZUGJFL1hOMUxN?=
 =?utf-8?B?Rlh2R3pjb1ExRUtzVTNsU0JwMDN4aUcrNzQzbFR6R2lLd2VlZ1FsYUNmOW1q?=
 =?utf-8?Q?l45tFNzZtBenwUgYJdedTngGj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a6231d-91ac-49b2-6476-08ddbd3ffcb8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 10:21:08.0857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYN/Wen1eEoIrX+ncmWpWXAYeSQGiRu5LTzFM3yjPEiOtWbXXzXt56wV35B08R6S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6078
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



On 7/7/2025 2:49 PM, Xie, Patrick wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi, @Lazar, Lijo, this is a way to ensure no data corruption happens in EEPROM after an EEPROM writing, the return value of amdgpu_ras_save_bad_pages does not indicate anything about this, and we have had a discussion about this, a slight loss in efficiency is acceptable.

I don't it is acceptable during RAS error recovery. A recovery needs to
be initiated at the earliest. The current implementation also has many
handshakes with FW for EEPROM read/writes. If required, the cross-check
may be done after reset which is added with this patch.

Thanks,
Lijo

> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Monday, July 7, 2025 4:29 PM
> To: Xie, Patrick <Gangliang.Xie@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: Re: [PATCH 1/2] drm/amdgpu: refine eeprom data check
> 
> 
> 
> On 7/7/2025 12:39 PM, ganglxie wrote:
>> add eeprom data checksum check after data writing, before gpu reset,
>> and before driver unload reset eeprom and save correct data to eeprom
>> when check failed
>>
>> Signed-off-by: ganglxie <ganglxie@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  7 +++++-
>>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 25 +++++++++++++++++++
>>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 ++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  2 ++
>>  6 files changed, 37 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 84fcaf84fead..ecdebca7f3f5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -6506,6 +6506,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>       if (!r)
>>               drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
>>
>> +     amdgpu_ras_eeprom_check_and_recover(adev);
>>       return r;
>>  }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 571b70da4562..1009b60f6ae4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2560,6 +2560,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>>       struct drm_device *dev = pci_get_drvdata(pdev);
>>       struct amdgpu_device *adev = drm_to_adev(dev);
>>
>> +     amdgpu_ras_eeprom_check_and_recover(adev);
>>       amdgpu_xcp_dev_unplug(adev);
>>       amdgpu_gmc_prepare_nps_mode_change(adev);
>>       drm_dev_unplug(dev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> index f8a8c8502013..e03550be45b4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> @@ -196,6 +196,7 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
>>               amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
>>                                        err_data.err_addr_cnt, false);
>>               amdgpu_ras_save_bad_pages(adev, NULL);
>> +             amdgpu_ras_eeprom_check_and_recover(adev);
>>       }
>>
>>       amdgpu_ras_error_data_fini(&err_data);
>> @@ -3539,9 +3540,13 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
>>               /* The format action is only applied to new ASICs */
>>               if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) >= 12 &&
>>                   control->tbl_hdr.version < RAS_TABLE_VER_V3)
>> -                     if (!amdgpu_ras_eeprom_reset_table(control))
>> +                     if (!amdgpu_ras_eeprom_reset_table(control)) {
>>                               if (amdgpu_ras_save_bad_pages(adev, NULL))
>>                                       dev_warn(adev->dev, "Failed to format RAS EEPROM data in V3
>> version!\n");
>> +                             else
>> +                                     amdgpu_ras_eeprom_check_and_recover(adev);
>> +                     }
>> +
>>       }
>>
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> index 2af14c369bb9..2458c67526c9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> @@ -1522,3 +1522,28 @@ int amdgpu_ras_eeprom_check(struct
>> amdgpu_ras_eeprom_control *control)
>>
>>       return res < 0 ? res : 0;
>>  }
>> +
>> +void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev)
>> +{
>> +     struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>> +     struct amdgpu_ras_eeprom_control *control = &ras->eeprom_control;
>> +     int res = 0;
>> +
>> +     if (!control->is_eeprom_valid)
>> +             return;
>> +     res = __verify_ras_table_checksum(control);
>> +     if (res) {
>> +             dev_warn(adev->dev,
>> +                     "RAS table incorrect checksum or error:%d, try to recover\n",
>> +                     res);
>> +             if (!amdgpu_ras_eeprom_reset_table(control))
>> +                     if (!amdgpu_ras_save_bad_pages(adev, NULL))
>> +                             if (!__verify_ras_table_checksum(control)) {
>> +                                     dev_info(adev->dev, "RAS table recovery succeed\n");
>> +                                     return;
>> +                             }
>> +             dev_err(adev->dev, "RAS table recovery failed\n");
>> +             control->is_eeprom_valid = false;
>> +     }
>> +     return;
>> +}
>> \ No newline at end of file
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
>> index 35c69ac3dbeb..ebfca4cb5688 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
>> @@ -161,6 +161,8 @@ void amdgpu_ras_debugfs_set_ret_size(struct
>> amdgpu_ras_eeprom_control *control);
>>
>>  int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control
>> *control);
>>
>> +void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev);
>> +
>>  extern const struct file_operations
>> amdgpu_ras_debugfs_eeprom_size_ops;
>>  extern const struct file_operations
>> amdgpu_ras_debugfs_eeprom_table_ops;
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
>> index bfc86f1e84e5..f36fe46541ed 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
>> @@ -80,6 +80,7 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
>>               amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
>>                                               err_data.err_addr_cnt, false);
>>               amdgpu_ras_save_bad_pages(adev, NULL);
>> +             amdgpu_ras_eeprom_check_and_recover(adev);
>>       }
>>
>>  out_free_err_addr:
>> @@ -168,6 +169,7 @@ void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
>>                       amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
>>                                               err_data->err_addr_cnt, false);
>>                       amdgpu_ras_save_bad_pages(adev, &err_count);
>> +                     amdgpu_ras_eeprom_check_and_recover(adev);
> 
> This doesn't look optimal. Reading the entire EEPROM each time before going for RAS recovery is not ideal. At minimum it should have a check whether the save failed, and then consider saving them later after the reset.
> 
> Thanks,
> Lijo
>>
>>                       amdgpu_dpm_send_hbm_bad_pages_num(adev,
>>                                       con->eeprom_control.ras_num_bad_pages);
> 

