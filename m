Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A33C0219D
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 15:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA9F510E3F1;
	Thu, 13 Feb 2025 15:45:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RZXVwhw3";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 579AF10E3F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 15:45:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quA5L/JPDKb1Koz6dPlTdzY0ZPatPPe7/FqDjMyLfZYklKuApb0cYWX+Untur6y5feOGHJYKxiDp0Pw+VytC9MvJRpZ2xDjqbbSCqc02js/i2tq5SOMVL3CLv2fsAu9t0wRYZCl5gdsZqoMsaodgz49y8UxeF3MgslsZxSkFCctAGemAINLZa+a2ru0nuqfLvvcGp1aj+ATF7tJViFTEv2ON9aAKaYiM3509ACbgvlLnNikZFpXsutefv+Wj+ai4eBSUTO08MFA0a0joDf6gWridQBj8deemuOsQZdwP0PgeaHvMNB2WE6S3ebzJb7zvZw5de+9e/LvURoZGb8Ld3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAM5IRhgCMfyRd9AOF35E1lfL3bCQKyAtXyTOHCQd9Y=;
 b=gsbdywzIqvMRRW099ROtbqeKZP5vIxSHEXGZfVkL3c80r51bFMIuJznzHO1M79NhJV3R8Q6ntEp10I/BQoA9heezM8fLGNdO1N4WDjQ5wLGFsFaq5S5uH7SXrIbK3dk8WuFXLSdvuSHMRrEPTas60ZyhMQoad3TBLmpbcDX+t7ovDBG0zoltyOmgkuJGeMGLlIkG9mxFggjsLCUIvsK9J0yjqcK6bs+QreOsouW5CJ0d6QIL3FbnycvLCy7J/TL79Fa6f+QXLX7MrEGrNwtuiw5rSDeu8vqnEe/gdNbbOUENMci8Sc4Ck8cDjt3MzrSc8O9oyIwScL2pPIyeHyJZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAM5IRhgCMfyRd9AOF35E1lfL3bCQKyAtXyTOHCQd9Y=;
 b=RZXVwhw3qjoCpvArjWIxIHUXuuXN6JEhc7hIOj1CaZbfnLDyCAymFacmvunG51nsaEUiZuWfCSFbL8Es/5e1qJEr+tmiOUkkBNaCsC0W36/aNuG2fvm7ADNLzTTq8eb17EJmb9gOMZNSDiYDyvp+FeYJAJWrqxwZ94r6sgQMthw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY5PR12MB6384.namprd12.prod.outlook.com (2603:10b6:930:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 13 Feb
 2025 15:45:32 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%6]) with mapi id 15.20.8445.015; Thu, 13 Feb 2025
 15:45:32 +0000
Content-Type: multipart/alternative;
 boundary="------------f00qx9fFWf0D9ObzLdwn0zs2"
Message-ID: <5296e288-fc56-f800-3813-b473871481f3@amd.com>
Date: Thu, 13 Feb 2025 10:45:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix the deadlock in svm_range_restore_work
Content-Language: en-US
To: "Deng, Emily" <Emily.Deng@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>, 
 "Chen, Xiaogang" <Xiaogang.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250207102823.1565467-1-Emily.Deng@amd.com>
 <PH0PR12MB541778A52306F3BF717609018FF02@PH0PR12MB5417.namprd12.prod.outlook.com>
 <841a21b8-b0b6-48a9-af2d-62b51d5d6a1b@amd.com>
 <PH0PR12MB54174DCAA0C2AF44C320C1098FF22@PH0PR12MB5417.namprd12.prod.outlook.com>
 <6c888bc6-a942-b608-3302-4c37374f76f8@amd.com>
 <CO6PR12MB54117113A866F8DC26466CAE8FFD2@CO6PR12MB5411.namprd12.prod.outlook.com>
 <PH0PR12MB541766DE7BC6B2960F79ED908FFD2@PH0PR12MB5417.namprd12.prod.outlook.com>
 <PH0PR12MB54172210D0A892CC1A8FB5BD8FFC2@PH0PR12MB5417.namprd12.prod.outlook.com>
 <3ca698e1-dda5-4e82-65af-68d8b15dcd54@amd.com>
 <PH0PR12MB5417FC100504361B99925E338FFF2@PH0PR12MB5417.namprd12.prod.outlook.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <PH0PR12MB5417FC100504361B99925E338FFF2@PH0PR12MB5417.namprd12.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0180.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::26) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CY5PR12MB6384:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a4f86e-dd07-4687-6d4c-08dd4c45724c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yk1jSXdUVlBPVEZBN243clRFZG5EZ2tMa01VQVpwdjljYVJPRnBhSzBvNG1R?=
 =?utf-8?B?RHdXQWNEREFrdGNSRnhuSTAzNUNjZDVpRVRyQythUi9yS1ZaMXNVWkRHd1lT?=
 =?utf-8?B?emlEbEErWFNQWVNxenp5em1kUmZSVlpIVEhYYlNEcFJVbUJSUkx0RldqQmps?=
 =?utf-8?B?VExic0ZlOFRZOFpUd3FGTTYwZHdGWlQ3ckFncmdDS1hENnNQdnpTeTZSTTVo?=
 =?utf-8?B?Nnpab1ExWDg2TTNYL0tqVDlhd2E5TkZ0Wk5IRDZEcUQra2VzeU13UlpPYUR4?=
 =?utf-8?B?blUwd3Y4NG5Renp6Qk5HSjUxZ2RYQlhHRXlKSENFM0c3VytnQzJnamE1TnZk?=
 =?utf-8?B?czF4bGJOa1AvNGE3NEdXV3hxOHhNL2xzaXdLc3czSzBwY0dLWVFYVk1KVGMx?=
 =?utf-8?B?Rm82Q1lKQ3R3SmxDR0c0Ny9ZYTZzbUhFNzlYN0p2SGptWDBrK2dGWnNLbFlo?=
 =?utf-8?B?bUtUVXR5N09RTjFoeVlxVHpOR0NqTGhxcjVXVjJLQjlwaVc4WTdzelRzNUhM?=
 =?utf-8?B?WndwS3VSUEd3dVN0WElLVmczK0ZoV1JreUVPb05LNnpkSi9udnl6OXdIV1VF?=
 =?utf-8?B?Mm0xV3E3Rzludys2MU9DK0ZuZG5rTktISWptK1lCSEllV0k1NUo2SFIzVzJr?=
 =?utf-8?B?SElKQ3VENW5oWTlOZG11UFJHU3BLU0JkMCttblNlNFJIUm5FRXlDZ3dDcDdN?=
 =?utf-8?B?MjExbGFDOEp6T3lHY2lnWDdTT25ORm55SzJHQ0hDbXF1amUraWJLeFJpZnln?=
 =?utf-8?B?M3VnNklOQ2RmQWlhUzVjYnoyRi82ZC9wUFhHVUttc3BnOW5kQkF5a0RSbXdk?=
 =?utf-8?B?Q3N1NUNNZklyVGVPTDUvUUY3UmIwbnV3WWM5REJuOHNERCtTMGdDRTdTaTBn?=
 =?utf-8?B?bVpveDMxbHlHVm5pVVNaZlpUeTU2VUNWZ25SVXBMWTJiRkNsQm1WK2ZGWVAy?=
 =?utf-8?B?L0R1YkszakYxTS9sY3poUE90TDJ3YWJ5cEtNbnlEaVAvZmg3alVhdkNvRHZJ?=
 =?utf-8?B?VGIzTUc1bFlTdGFFamJhYUVQRXorMWg0azJQc2FMREl0ckNMSXZTRFNQTVpz?=
 =?utf-8?B?Q1lwUjcrMDc4M2tGU3gySVNZRktRVk1MY0tqWW9Iai9nM0F2SW1xSlJsNzV4?=
 =?utf-8?B?QTc3MVE0MUVmQ0U2R2krNm0rOHVoK3NaeEIrRHNGNUxLZU14d1JxRFB3RDVl?=
 =?utf-8?B?UXlKVW4xMFFqZEp5MTZaSUVQSUVpOFZFVTdHNktGR1Q2RmhPcjltSTJYZmlQ?=
 =?utf-8?B?YW42cGR6ZGtqbUVzL0NOMjNuUCtLS3IwSmp1SStHT0p6ejJvRHAvY2xvUzFN?=
 =?utf-8?B?ZjBUQ05uekJ3cW53ZXpQS2RUWFlKcnNqWmRPbStkK05FQXNkSGxTNS9sblhM?=
 =?utf-8?B?VDQ4VHkwSzJvNVNJWVkxOGVHSW1WTTdsS3JUUVNBYjI0V3pjVUd6K0RMcjFh?=
 =?utf-8?B?b0VVTWRyMHhFZkNoQUswQm9qRnptOXp4dDNGZkpqUVlTUldYc3ZEKyszand6?=
 =?utf-8?B?QWRxOE5PUWtKSDVZcmk2blZ4YlFOQnYwQkF3eUZXSUFUVG9UVDdBWnRWSlg2?=
 =?utf-8?B?MTR2cHg3NkZuVnN1OHQ1V0JkcUw0SEFpSmErUmxsNUtGUjFkZEN6aHBBWUxx?=
 =?utf-8?B?N3crZzdTQWhNMWsxVm9kd25rcVJDc3NKR2ZkSUF0MkVBczg1UlNSRTlTRzVF?=
 =?utf-8?B?V3M4MFpabHloaVMzWHpjNzlTUkQ5M09Xd0ZtU2pRTVNic0psRnhNY1RjazBq?=
 =?utf-8?B?NHRYOG1yNXh0ZW9MZHRBT2RSdzYwM1VabGNrbnhBYWFvS2pocGhRSnhzV1p5?=
 =?utf-8?B?R2N1ek4wV0lXWGp3dmU1K0d1YjRPV2ROK2xwQjJkZmZkWGhtbG1mbnpFQnVN?=
 =?utf-8?Q?BF3xRgPBYKHti?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODI5dXFQNE01S09KcGliNWQwd2ltRjhRTXJCZlVOQUd0d1RtRE4zNEN1cytS?=
 =?utf-8?B?ZURRL1dVUWcrbDlhVk1LY2RZM2c1akxXenc4bXdVQy9sUjNzZnRMUCttL3V1?=
 =?utf-8?B?empnNUxidDRDaXo1cnkzL0NZdnppSHBkSWpTN0pRL3kveTRNMXZHYnY4S2w0?=
 =?utf-8?B?cHMrUkFXbjJlYkM2MzZFSDVWbFc3SEpaOEFZWUloZUJKaDdUMGc5a0pmNTl1?=
 =?utf-8?B?YWIvcjh5RmJ0ck5xRzJUYmNkOE9STGkzSkhvZUlUaFFrL25lelRDYmxKZFlO?=
 =?utf-8?B?UVB4RFRwNWU2cVphL1U5T1VoTzZVUktoNG9ZWkNWZ3RIN3ZPY2pablpia1gw?=
 =?utf-8?B?SnpTdTI1YkZlQUFqSU54OTc1SlBSaHZiYi9sQWY4MWhHSVhrWkRZUHM1V3VC?=
 =?utf-8?B?Wkg4SmVsa1pwRnJmMVZES1RGSTJkWG0rREtkKzd1aEJuQXh6K1V0Zk9kWUU4?=
 =?utf-8?B?YWRUQnA3UUU0bUE2YVFYRGkra3lRYUc5V2xVY0ltUjVyeWdIWm11NFNoOWJo?=
 =?utf-8?B?MUFXMWhYT29SOXVPZjYrZkppcTNXVXFCeW5nWFVJcFlqd2ptM2M0TnJVSjcx?=
 =?utf-8?B?Y1Y5ZjVUSUZEYnFZekZiblZHZXppZ281Vkh5b3UyL1BpRjNOOUE3R0VjUXhJ?=
 =?utf-8?B?dVBnUElWRTEySWM4VFlUZnkydVdQaENubmNMVDJBNTNPTm5UOFcybUUva0Ns?=
 =?utf-8?B?bkZaV2tqbEF3VDlycDhzaXJHbG95UWtOL0hHWUx1R0JWQldac3piZXI5dDZZ?=
 =?utf-8?B?STJGSjRpQTdBMHRkWUNTc1F5QlpjeHNVdzVka0IrbzdpY2Q0anNVaG5JMExj?=
 =?utf-8?B?cm04SEdTY253WEhwTTVrY3JWT2x1eHVwTDRwdjdaZndRSkpSYWZhR0hpZU4w?=
 =?utf-8?B?T3FjN0g1ayswb1k5aUtXaUpLcHRpU1VrY3AyMHY5TGhPNGt0eG91eVRtTERt?=
 =?utf-8?B?Z05IVlM0S1gvRVlFTnJnVnM5OUYyU1pRQUN0QXhCTGFYMUN6RW5tVmJHVHpo?=
 =?utf-8?B?aUtVbTdPQURHSFd0b2xJbTMxNU9Dbmp1YTRtSlN0UERhS2txQkREUVE0RzNZ?=
 =?utf-8?B?NHV3S0luOVVaV0xrK0tONlVNN0NIcnhRU2lMTzR3T2hQbytMc2EwaTZzc3cw?=
 =?utf-8?B?TnZxYlVJZGtZb0hBVk40RWROUkhoaTNlMkpmUDQvNGFmYm5zT2dhdUdyVUsy?=
 =?utf-8?B?YmVDT2swQUdLeWNlVXVINk54Q0hhMjFXeUhqT2ZGNGljZzEwU0pyVDY2eG5h?=
 =?utf-8?B?bUk1NFRROXR3YzU2RmhnM1gzMFI2eWcyQ2Y5MkJ2LzBEWUN0MHVQU2kyUFY1?=
 =?utf-8?B?QU5aaFdQdjhLOCtVMUU2ZjZrSjFaZERkRXlPeUQrcU9LYVBHVTJQemltYU1C?=
 =?utf-8?B?YktYOGMwbnpMTFp0WktxQkM1NmJyalZYdzBtKzBCa21JdXNtZUp1bldNcm1l?=
 =?utf-8?B?cFBaSXpXVGc1Y1BFcEhzWll2Yjc3UkpGQmQvUENLdEVHK1FIV0l1a2FCRVVU?=
 =?utf-8?B?Nm9EakIrQUJQWmZTb0ZGRW5qN2JJS212REtYaFdsamE0UXAvbUl1YmFOTm9u?=
 =?utf-8?B?RTVxc0F4dzRTNkJWN2xYYWsyeldpN2dLWXF2N3ZFaWZWNnAwS0x4NlBPbjds?=
 =?utf-8?B?MjRwWWpnUjRGOW54QVpoTFNpVUFpTlk0V3k5dzV2Z2toQTlNWW03bEJaT2pE?=
 =?utf-8?B?TCtDR29wUHFMT1ZaM0RVSWFDRndQdlNXaHBPUSs5dDRJZEoyL0l4V1kyd3lE?=
 =?utf-8?B?dnBHRGhUeDBpOVlOWjFadEFJWml6c3VJLzNJZnlIVlJaQlQ0U0ovVmc2dXlI?=
 =?utf-8?B?NnA1L3FMTytuVmxkZVJmY0R1aTgwcjlsb0xpM2VHWFloL3hIczVZVnYxOWh2?=
 =?utf-8?B?VklrM2ZjWTlnWWszZ0xNN01Nd1g5L1d1VzFxUmN5dFVTanppUHNlY1lnNDd0?=
 =?utf-8?B?Y3BMNko0MFdBNkY1Q216U0RmYmxVN01aWWlZZVhoeUxPM2RWeE9OMlowYnAv?=
 =?utf-8?B?b0p6MDNYUFhvNmVlUTl5M1ptL2hqYmE3d1JjYmFBeGdxV0tTaXN0WkFYL0xB?=
 =?utf-8?B?NzBvbG1NTXdqb3JUbmtXVGZSTjB3SHNuWm5iZVd3WVBCS1FSK2VqMzhYOEZZ?=
 =?utf-8?Q?/DK8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a4f86e-dd07-4687-6d4c-08dd4c45724c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 15:45:32.3760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYpqpFY1IzZcrNKQnblPkQd3QfEmyDaj80oGVvyQdZNmWVFGTUOu5VjRN9y+tR1I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6384
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

--------------f00qx9fFWf0D9ObzLdwn0zs2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2025-02-12 23:33, Deng, Emily wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> *From:*Yang, Philip <Philip.Yang@amd.com>
> *Sent:* Wednesday, February 12, 2025 10:31 PM
> *To:* Deng, Emily <Emily.Deng@amd.com>; Yang, Philip 
> <Philip.Yang@amd.com>; Chen, Xiaogang <Xiaogang.Chen@amd.com>; 
> amd-gfx@lists.freedesktop.org
> *Subject:* Re: [PATCH] drm/amdkfd: Fix the deadlock in 
> svm_range_restore_work
>
> On 2025-02-12 03:54, Deng, Emily wrote:
>
>     [AMD Official Use Only - AMD Internal Distribution Only]
>
>     Ping……
>
>     Emily Deng
>
>     Best Wishes
>
>     *From:*Deng, Emily <Emily.Deng@amd.com> <mailto:Emily.Deng@amd.com>
>     *Sent:* Tuesday, February 11, 2025 8:21 PM
>     *To:* Deng, Emily <Emily.Deng@amd.com>
>     <mailto:Emily.Deng@amd.com>; Yang, Philip <Philip.Yang@amd.com>
>     <mailto:Philip.Yang@amd.com>; Chen, Xiaogang
>     <Xiaogang.Chen@amd.com> <mailto:Xiaogang.Chen@amd.com>;
>     amd-gfx@lists.freedesktop.org
>     *Subject:* RE: [PATCH] drm/amdkfd: Fix the deadlock in
>     svm_range_restore_work
>
>     [AMD Official Use Only - AMD Internal Distribution Only]
>
>     Hi Philip,
>
>     Upon further consideration,
>     removing amdgpu_amdkfd_unreserve_mem_limit is challenging because
>     it is paired
>     with amdgpu_amdkfd_reserve_mem_limit in svm_migrate_ram_to_vram.
>     However, this pairing does introduce issues, as it
>     prevents amdgpu_amdkfd_reserve_mem_limit from accurately detecting
>     out-of-memory conditions.
>     Ideally, amdgpu_amdkfd_unreserve_mem_limit should be tied to the
>     actual freeing of memory. Furthermore,
>     since ttm_bo_delayed_delete delays the call
>     to amdgpu_vram_mgr_del, there remains a possibility
>     that amdgpu_amdkfd_reserve_mem_limit reports sufficient memory,
>     while a subsequent call to amdgpu_vram_mgr_new fails. For these
>     reasons, I believe this patch is still necessary.
>
>     Emily Deng
>
>     Best Wishes
>
>     *From:*amd-gfx <amd-gfx-bounces@lists.freedesktop.org> *On Behalf
>     Of *Deng, Emily
>     *Sent:* Tuesday, February 11, 2025 6:56 PM
>     *To:* Yang, Philip <Philip.Yang@amd.com>; Chen, Xiaogang
>     <Xiaogang.Chen@amd.com>; amd-gfx@lists.freedesktop.org
>     *Subject:* RE: [PATCH] drm/amdkfd: Fix the deadlock in
>     svm_range_restore_work
>
>     [AMD Official Use Only - AMD Internal Distribution Only]
>
>     [AMD Official Use Only - AMD Internal Distribution Only]
>
>     *From:*Yang, Philip <Philip.Yang@amd.com>
>     *Sent:* Tuesday, February 11, 2025 6:54 AM
>     *To:* Deng, Emily <Emily.Deng@amd.com>; Chen, Xiaogang
>     <Xiaogang.Chen@amd.com>; amd-gfx@lists.freedesktop.org
>     *Subject:* Re: [PATCH] drm/amdkfd: Fix the deadlock in
>     svm_range_restore_work
>
>     On 2025-02-10 02:51, Deng, Emily wrote:
>
>         [AMD Official Use Only - AMD Internal Distribution Only]
>
>         [AMD Official Use Only - AMD Internal Distribution Only]
>
>         *From:*Chen, Xiaogang <Xiaogang.Chen@amd.com>
>         <mailto:Xiaogang.Chen@amd.com>
>         *Sent:* Monday, February 10, 2025 10:18 AM
>         *To:* Deng, Emily <Emily.Deng@amd.com>
>         <mailto:Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>         *Subject:* Re: [PATCH] drm/amdkfd: Fix the deadlock in
>         svm_range_restore_work
>
>         On 2/7/2025 9:02 PM, Deng, Emily wrote:
>
>             [AMD Official Use Only - AMD Internal Distribution Only]
>
>               
>
>             [AMD Official Use Only - AMD Internal Distribution Only]
>
>               
>
>             Ping.......
>
>               
>
>             Emily Deng
>
>             Best Wishes
>
>               
>
>               
>
>               
>
>                 -----Original Message-----
>
>                 From: Emily Deng<Emily.Deng@amd.com>  <mailto:Emily.Deng@amd.com>
>
>                 Sent: Friday, February 7, 2025 6:28 PM
>
>                 To:amd-gfx@lists.freedesktop.org
>
>                 Cc: Deng, Emily<Emily.Deng@amd.com>  <mailto:Emily.Deng@amd.com>
>
>                 Subject: [PATCH] drm/amdkfd: Fix the deadlock in svm_range_restore_work
>
>                   
>
>                 It will hit deadlock in svm_range_restore_work ramdonly.
>
>                 Detail as below:
>
>                 1.svm_range_restore_work
>
>                        ->svm_range_list_lock_and_flush_work
>
>                        ->mmap_write_lock
>
>                 2.svm_range_restore_work
>
>                        ->svm_range_validate_and_map
>
>                        ->amdgpu_vm_update_range
>
>                        ->amdgpu_vm_ptes_update
>
>                        ->amdgpu_vm_pt_alloc
>
>                        ->svm_range_evict_svm_bo_worker
>
>         svm_range_evict_svm_bo_worker is a function running by a
>         kernel task from default system_wq. It is not the task that
>         runs svm_range_restore_work which is from system_freezable_wq.
>         The second task may need wait the first task to release
>         mmap_write_lock, but there is no cycle lock dependency.
>
>         Can you explain more how deadlock happened? If a deadlock
>         exists between two tasks there are should be at least two
>         locks used by both tasks.
>
>         Regards
>
>         Xiaogang
>
>         In Step 2, during the amdgpu_vm_pt_alloc process, the system
>         encounters insufficient memory and triggers an eviction. This
>         initiates the svm_range_evict_svm_bo_worker task, and waits
>         for the eviction_fence to be signaled. However,
>         the svm_range_evict_svm_bo_worker cannot acquire
>         the mmap_read_lock(mm), preventing it from signaling
>         the eviction_fence. As a result, amdgpu_vm_pt_alloc remains
>         incomplete and cannot release the mmap_write_lock(mm).
>
>         Which means the svm_range_restore_work task holds
>         the mmap_write_lock(mm) and is stuck waiting for
>         the eviction_fence to be signaled
>         by svm_range_evict_svm_bo_worker.
>         However, svm_range_evict_svm_bo_worker is itself blocked,
>         unable to acquire the mmap_read_lock(mm). This creates a deadlock.
>
>     The deadlock situation should not happen as svm_range_restore_work
>     is only used for xnack off case, there is no VRAM over commitment
>     with KFD amdgpu_amdkfd_reserve_mem_limit. We reserved VRAM
>     ESTIMATE_PT_SIZE for page table allocation to prevent this situation.
>
>     Regards,
>
>     Philip
>
>     Hi Philip,
>
>     You're correct. Upon further investigation, the issue arises from
>     the additional call
>     to amdgpu_amdkfd_unreserve_mem_limit in svm_migrate_ram_to_vram,
>     which prevents amdgpu_amdkfd_reserve_mem_limit from detecting the
>     out-of-memory condition. I will submit another patch to remove
>     the amdgpu_amdkfd_unreserve_mem_limit call in svm_migrate_ram_to_vram.
>
> We check all SVM memory must fit in system memory, don't account svm 
> VRAM usage. For xnack off, application should check available VRAM 
> size and avoid VRAM over commitment.
>
> svm_range_restore_worker ensure all SVM ranges are mapped to GPUs then 
> resume queues, this is done by taking mmap write lock and flush 
> deferred_range_list. downgrade to mmap read lock cannot prevent unmap 
> from CPU as mmu notifier callback can add range to deferred_range_list 
> again and unmap from GPUs, so this patch can not work.
>
> Maybe I understand wrong. but downgrading to a read lock could also 
> prevent svm_range_deferred_list_work from acquiring a write lock. As a 
> result, it could potentially block unmapping operations from GPUs.
>
no, svm_range_cpu_invalidate_pagetables takes prange lock to split 
prange, and add to deferred_list if needed, then unmap from GPU and return.

This needs app fix, not over commitment, prefetch svm ranges to VRAM if 
xnack is off.

Regards,

Philip

> Emily Deng
>
> Best Wishes
>
> We should not use mmap write lock to sync with mmu notifier, there is 
> a plan to rework svm locks to fix this.
>
> Regards,
>
> Philip
>
>     Emily Deng
>
>     Best Wishes
>
>         Emily Deng
>
>         Best Wishes
>
>                        ->mmap_read_lock(deadlock here, because already get mmap_write_lock)
>
>                   
>
>                 How to fix?
>
>                 Downgrade the write lock to read lock.
>
>                   
>
>                 Signed-off-by: Emily Deng<Emily.Deng@amd.com>  <mailto:Emily.Deng@amd.com>
>
>                 ---
>
>                 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 ++-
>
>                 1 file changed, 2 insertions(+), 1 deletion(-)
>
>                   
>
>                 diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>                 b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>                 index bd3e20d981e0..c907e2de3dde 100644
>
>                 --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>                 +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>                 @@ -1841,6 +1841,7 @@ static void svm_range_restore_work(struct work_struct
>
>                 *work)
>
>                        mutex_lock(&process_info->lock);
>
>                        svm_range_list_lock_and_flush_work(svms, mm);
>
>                        mutex_lock(&svms->lock);
>
>                 +      mmap_write_downgrade(mm);
>
>                   
>
>                        evicted_ranges = atomic_read(&svms->evicted_ranges);
>
>                   
>
>                 @@ -1890,7 +1891,7 @@ static void svm_range_restore_work(struct work_struct
>
>                 *work)
>
>                   
>
>                 out_reschedule:
>
>                        mutex_unlock(&svms->lock);
>
>                 -      mmap_write_unlock(mm);
>
>                 +      mmap_read_unlock(mm);
>
>                        mutex_unlock(&process_info->lock);
>
>                   
>
>                        /* If validation failed, reschedule another attempt */
>
>                 --
>
>                 2.34.1
>
>               
>
--------------f00qx9fFWf0D9ObzLdwn0zs2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-02-12 23:33, Deng, Emily wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:PH0PR12MB5417FC100504361B99925E338FFF2@PH0PR12MB5417.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	font-size:10.0pt;
	font-family:"Courier New";}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <div style="border:none;border-left:solid blue
            1.5pt;padding:0in 0in 0in 4.0pt">
            <div>
              <div style="border:none;border-top:solid #E1E1E1
                1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                    Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
                    <br>
                    <b>Sent:</b> Wednesday, February 12, 2025 10:31 PM<br>
                    <b>To:</b> Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>;
                    Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>; Chen,
                    Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>;
                    <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                    <b>Subject:</b> Re: [PATCH] drm/amdkfd: Fix the
                    deadlock in svm_range_restore_work<o:p></o:p></span></p>
              </div>
            </div>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <p><o:p>&nbsp;</o:p></p>
            <div>
              <p class="MsoNormal">On 2025-02-12 03:54, Deng, Emily
                wrote:<o:p></o:p></p>
            </div>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <p style="margin:5.0pt"><span style="font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:blue">[AMD
                  Official Use Only - AMD Internal Distribution Only]<o:p></o:p></span></p>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              <div>
                <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Ping……</span><o:p></o:p></p>
                <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
                <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Emily
                    Deng</span><o:p></o:p></p>
                <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Best
                    Wishes</span><o:p></o:p></p>
                <div style="border:none;border-left:solid blue
                  1.5pt;padding:0in 0in 0in 4.0pt">
                  <div>
                    <div style="border:none;border-top:solid #E1E1E1
                      1.0pt;padding:3.0pt 0in 0in 0in">
                      <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                          Deng, Emily
                          <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a>
                          <br>
                          <b>Sent:</b> Tuesday, February 11, 2025 8:21
                          PM<br>
                          <b>To:</b> Deng, Emily <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a>;
                          Yang, Philip
                          <a href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">&lt;Philip.Yang@amd.com&gt;</a>;
                          Chen, Xiaogang <a href="mailto:Xiaogang.Chen@amd.com" moz-do-not-send="true">
                            &lt;Xiaogang.Chen@amd.com&gt;</a>; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><br>
                          <b>Subject:</b> RE: [PATCH] drm/amdkfd: Fix
                          the deadlock in svm_range_restore_work</span><o:p></o:p></p>
                    </div>
                  </div>
                  <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                  <p style="margin:5.0pt"><span style="font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:blue">[AMD
                      Official Use Only - AMD Internal Distribution
                      Only]</span><o:p></o:p></p>
                  <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                  <div>
                    <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Hi
                        Philip,</span><o:p></o:p></p>
                    <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;
                        Upon further consideration,
                        removing&nbsp;amdgpu_amdkfd_unreserve_mem_limit&nbsp;is
                        challenging because it is paired
                        with&nbsp;amdgpu_amdkfd_reserve_mem_limit&nbsp;in&nbsp;svm_migrate_ram_to_vram.
                        However, this pairing does introduce issues, as
                        it prevents&nbsp;amdgpu_amdkfd_reserve_mem_limit&nbsp;from
                        accurately detecting out-of-memory conditions.
                        Ideally,&nbsp;amdgpu_amdkfd_unreserve_mem_limit&nbsp;should
                        be tied to the actual freeing of memory.
                        Furthermore, since&nbsp;ttm_bo_delayed_delete&nbsp;delays
                        the call to&nbsp;amdgpu_vram_mgr_del, there remains a
                        possibility
                        that&nbsp;amdgpu_amdkfd_reserve_mem_limit&nbsp;reports
                        sufficient memory, while a subsequent call
                        to&nbsp;amdgpu_vram_mgr_new&nbsp;fails. For these reasons,
                        I believe this patch is still necessary.</span><o:p></o:p></p>
                    <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
                    <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Emily
                        Deng</span><o:p></o:p></p>
                    <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Best
                        Wishes</span><o:p></o:p></p>
                    <div style="border:none;border-left:solid blue
                      1.5pt;padding:0in 0in 0in 4.0pt">
                      <div>
                        <div style="border:none;border-top:solid #E1E1E1
                          1.0pt;padding:3.0pt 0in 0in 0in">
                          <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                              amd-gfx &lt;<a href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
                              <b>On Behalf Of </b>Deng, Emily<br>
                              <b>Sent:</b> Tuesday, February 11, 2025
                              6:56 PM<br>
                              <b>To:</b> Yang, Philip &lt;<a href="mailto:Philip.Yang@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Philip.Yang@amd.com</a>&gt;;
                              Chen, Xiaogang &lt;<a href="mailto:Xiaogang.Chen@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Xiaogang.Chen@amd.com</a>&gt;;
                              <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><br>
                              <b>Subject:</b> RE: [PATCH] drm/amdkfd:
                              Fix the deadlock in svm_range_restore_work</span><o:p></o:p></p>
                        </div>
                      </div>
                      <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                      <p style="margin:5.0pt"><span style="font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:blue">[AMD
                          Official Use Only - AMD Internal Distribution
                          Only]</span><o:p></o:p></p>
                      <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                      <div>
                        <p style="margin:5.0pt"><span style="font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:blue">[AMD
                            Official Use Only - AMD Internal
                            Distribution Only]</span><o:p></o:p></p>
                        <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                        <div>
                          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
                          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
                          <div style="border:none;border-left:solid blue
                            1.5pt;padding:0in 0in 0in 4.0pt">
                            <div>
                              <div style="border:none;border-top:solid
                                #E1E1E1 1.0pt;padding:3.0pt 0in 0in 0in">
                                <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                                    Yang, Philip &lt;<a href="mailto:Philip.Yang@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Philip.Yang@amd.com</a>&gt;
                                    <br>
                                    <b>Sent:</b> Tuesday, February 11,
                                    2025 6:54 AM<br>
                                    <b>To:</b> Deng, Emily &lt;<a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Emily.Deng@amd.com</a>&gt;;
                                    Chen, Xiaogang &lt;<a href="mailto:Xiaogang.Chen@amd.com" moz-do-not-send="true" class="moz-txt-link-freetext">Xiaogang.Chen@amd.com</a>&gt;;
                                    <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><br>
                                    <b>Subject:</b> Re: [PATCH]
                                    drm/amdkfd: Fix the deadlock in
                                    svm_range_restore_work</span><o:p></o:p></p>
                              </div>
                            </div>
                            <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                            <p>&nbsp;<o:p></o:p></p>
                            <div>
                              <p class="MsoNormal">On 2025-02-10 02:51,
                                Deng, Emily wrote:<o:p></o:p></p>
                            </div>
                            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                              <p style="margin:5.0pt"><span style="font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:blue">[AMD
                                  Official Use Only - AMD Internal
                                  Distribution Only]</span><o:p></o:p></p>
                              <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                              <div>
                                <p style="margin:5.0pt"><span style="font-size:10.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:blue">[AMD
                                    Official Use Only - AMD Internal
                                    Distribution Only]</span><o:p></o:p></p>
                                <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                                <div>
                                  <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
                                  <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
                                  <div style="border:none;border-left:solid
                                    blue 1.5pt;padding:0in 0in 0in
                                    4.0pt">
                                    <div>
                                      <div style="border:none;border-top:solid
                                        #E1E1E1 1.0pt;padding:3.0pt 0in
                                        0in 0in">
                                        <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                                            Chen, Xiaogang
                                            <a href="mailto:Xiaogang.Chen@amd.com" moz-do-not-send="true">&lt;Xiaogang.Chen@amd.com&gt;</a>
                                            <br>
                                            <b>Sent:</b> Monday,
                                            February 10, 2025 10:18 AM<br>
                                            <b>To:</b> Deng, Emily <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a>;
                                            <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><br>
                                            <b>Subject:</b> Re: [PATCH]
                                            drm/amdkfd: Fix the deadlock
                                            in svm_range_restore_work</span><o:p></o:p></p>
                                      </div>
                                    </div>
                                    <p class="MsoNormal">&nbsp;<o:p></o:p></p>
                                    <p>&nbsp;<o:p></o:p></p>
                                    <div>
                                      <p class="MsoNormal">On 2/7/2025
                                        9:02 PM, Deng, Emily wrote:<o:p></o:p></p>
                                    </div>
                                    <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                                      <pre>[AMD Official Use Only - AMD Internal Distribution Only]<o:p></o:p></pre>
                                      <pre>&nbsp;<o:p></o:p></pre>
                                      <pre>[AMD Official Use Only - AMD Internal Distribution Only]<o:p></o:p></pre>
                                      <pre>&nbsp;<o:p></o:p></pre>
                                      <pre>Ping.......<o:p></o:p></pre>
                                      <pre>&nbsp;<o:p></o:p></pre>
                                      <pre>Emily Deng<o:p></o:p></pre>
                                      <pre>Best Wishes<o:p></o:p></pre>
                                      <pre>&nbsp;<o:p></o:p></pre>
                                      <pre>&nbsp;<o:p></o:p></pre>
                                      <pre>&nbsp;<o:p></o:p></pre>
                                      <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                                        <pre>-----Original Message-----<o:p></o:p></pre>
                                        <pre>From: Emily Deng <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><o:p></o:p></pre>
                                        <pre>Sent: Friday, February 7, 2025 6:28 PM<o:p></o:p></pre>
                                        <pre>To: <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a><o:p></o:p></pre>
                                        <pre>Cc: Deng, Emily <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><o:p></o:p></pre>
                                        <pre>Subject: [PATCH] drm/amdkfd: Fix the deadlock in svm_range_restore_work<o:p></o:p></pre>
                                        <pre>&nbsp;<o:p></o:p></pre>
                                        <pre>It will hit deadlock in svm_range_restore_work ramdonly.<o:p></o:p></pre>
                                        <pre>Detail as below:<o:p></o:p></pre>
                                        <pre>1.svm_range_restore_work<o:p></o:p></pre>
                                        <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;svm_range_list_lock_and_flush_work<o:p></o:p></pre>
                                        <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;mmap_write_lock<o:p></o:p></pre>
                                        <pre>2.svm_range_restore_work<o:p></o:p></pre>
                                        <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;svm_range_validate_and_map<o:p></o:p></pre>
                                        <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;amdgpu_vm_update_range<o:p></o:p></pre>
                                        <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;amdgpu_vm_ptes_update<o:p></o:p></pre>
                                        <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;amdgpu_vm_pt_alloc<o:p></o:p></pre>
                                        <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;svm_range_evict_svm_bo_worker<o:p></o:p></pre>
                                      </blockquote>
                                    </blockquote>
                                    <p>svm_range_evict_svm_bo_worker is
                                      a function running by a kernel
                                      task from default system_wq. It is
                                      not the task that runs
                                      svm_range_restore_work which is
                                      from system_freezable_wq. The
                                      second task may need wait the
                                      first task to release
                                      mmap_write_lock, but there is no
                                      cycle lock dependency.<o:p></o:p></p>
                                    <p>Can you explain more how deadlock
                                      happened? If a deadlock exists
                                      between two tasks there are should
                                      be at least two locks used by both
                                      tasks.<o:p></o:p></p>
                                    <p>Regards<o:p></o:p></p>
                                    <p style="margin-left:11.0pt">Xiaogang
                                      <o:p></o:p></p>
                                    <p style="margin-left:5.5pt">In Step
                                      2, during
                                      the&nbsp;amdgpu_vm_pt_alloc&nbsp;process,
                                      the system encounters insufficient
                                      memory and triggers an eviction.
                                      This initiates
                                      the&nbsp;svm_range_evict_svm_bo_worker&nbsp;task,
                                      and waits for
                                      the&nbsp;eviction_fence&nbsp;to be signaled.
                                      However,
                                      the&nbsp;svm_range_evict_svm_bo_worker&nbsp;cannot
                                      acquire the&nbsp;mmap_read_lock(mm),
                                      preventing it from signaling
                                      the&nbsp;eviction_fence. As a
                                      result,&nbsp;amdgpu_vm_pt_alloc&nbsp;remains
                                      incomplete and cannot release
                                      the&nbsp;mmap_write_lock(mm).
                                      <o:p></o:p></p>
                                    <p style="margin-left:5.5pt">Which
                                      means
                                      the&nbsp;svm_range_restore_work&nbsp;task
                                      holds the&nbsp;mmap_write_lock(mm)&nbsp;and
                                      is stuck waiting for
                                      the&nbsp;eviction_fence&nbsp;to be signaled
                                      by&nbsp;svm_range_evict_svm_bo_worker.
However,&nbsp;svm_range_evict_svm_bo_worker&nbsp;is itself blocked, unable to
                                      acquire the&nbsp;mmap_read_lock(mm).
                                      This creates a deadlock.<o:p></o:p></p>
                                  </div>
                                </div>
                              </div>
                            </blockquote>
                            <p>The deadlock situation should not happen
                              as svm_range_restore_work is only used for
                              xnack off case, there is no VRAM over
                              commitment with KFD
                              amdgpu_amdkfd_reserve_mem_limit. We
                              reserved VRAM ESTIMATE_PT_SIZE for page
                              table allocation to prevent this
                              situation.<o:p></o:p></p>
                            <p>Regards,<o:p></o:p></p>
                            <p>Philip<o:p></o:p></p>
                            <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Hi
                                Philip,</span><o:p></o:p></p>
                            <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;
                                You're correct. Upon further
                                investigation, the issue arises from the
                                additional call
                                to&nbsp;amdgpu_amdkfd_unreserve_mem_limit&nbsp;in&nbsp;svm_migrate_ram_to_vram,
                                which
                                prevents&nbsp;amdgpu_amdkfd_reserve_mem_limit&nbsp;from
                                detecting the out-of-memory condition. I
                                will submit another patch to remove
                                the&nbsp;amdgpu_amdkfd_unreserve_mem_limit&nbsp;call
                                in&nbsp;svm_migrate_ram_to_vram.</span><o:p></o:p></p>
                            <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </blockquote>
            <p>We check all SVM memory must fit in system memory, don't
              account svm VRAM usage. For xnack off, application should
              check available VRAM size and avoid VRAM over commitment.<o:p></o:p></p>
            <p>svm_range_restore_worker ensure all SVM ranges are mapped
              to GPUs then resume queues, this is done by taking mmap
              write lock and flush deferred_range_list. downgrade to
              mmap read lock cannot prevent unmap from CPU as mmu
              notifier callback can add range to deferred_range_list
              again and unmap from GPUs, so this patch can not work.<o:p></o:p></p>
            <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Maybe
                I understand wrong. but downgrading to a read lock could
                also prevent svm_range_deferred_list_work from acquiring
                a write lock. As a result, it could potentially block
                unmapping operations from GPUs.</span></p>
          </div>
        </div>
      </div>
    </blockquote>
    <p>no, svm_range_cpu_invalidate_pagetables takes prange lock to
      split prange, and add to deferred_list if needed, then unmap from
      GPU and return.</p>
    <p>This needs app fix, not over commitment, prefetch svm ranges to
      VRAM if xnack is off.<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:PH0PR12MB5417FC100504361B99925E338FFF2@PH0PR12MB5417.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <div style="border:none;border-left:solid blue
            1.5pt;padding:0in 0in 0in 4.0pt">
            <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
            <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
            <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Emily
                Deng<o:p></o:p></span></p>
            <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Best
                Wishes<o:p></o:p></span></p>
          </div>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
          <p>We should not use mmap write lock to sync with mmu
            notifier, there is a plan to rework svm locks to fix this.<o:p></o:p></p>
          <p>Regards,<o:p></o:p></p>
          <p>Philip<o:p></o:p></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <div>
              <div style="border:none;border-left:solid blue
                1.5pt;padding:0in 0in 0in 4.0pt">
                <div>
                  <div style="border:none;border-left:solid blue
                    1.5pt;padding:0in 0in 0in 4.0pt">
                    <div>
                      <div>
                        <div style="border:none;border-left:solid blue
                          1.5pt;padding:0in 0in 0in 4.0pt">
                          <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Emily
                              Deng</span><o:p></o:p></p>
                          <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Best
                              Wishes</span><o:p></o:p></p>
                        </div>
                        <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
                        <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
                        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                          <div>
                            <div>
                              <div style="border:none;border-left:solid
                                blue 1.5pt;padding:0in 0in 0in 4.0pt">
                                <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
                                <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Emily
                                    Deng</span><o:p></o:p></p>
                                <p class="MsoNormal"><span style="font-size:11.0pt;mso-ligatures:standardcontextual">Best
                                    Wishes</span><o:p></o:p></p>
                              </div>
                              <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
                              <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
                              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                                <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&gt;mmap_read_lock(deadlock here, because already get mmap_write_lock)<o:p></o:p></pre>
                                  <pre>&nbsp;<o:p></o:p></pre>
                                  <pre>How to fix?<o:p></o:p></pre>
                                  <pre>Downgrade the write lock to read lock.<o:p></o:p></pre>
                                  <pre>&nbsp;<o:p></o:p></pre>
                                  <pre>Signed-off-by: Emily Deng <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><o:p></o:p></pre>
                                  <pre>---<o:p></o:p></pre>
                                  <pre>drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 ++-<o:p></o:p></pre>
                                  <pre>1 file changed, 2 insertions(+), 1 deletion(-)<o:p></o:p></pre>
                                  <pre>&nbsp;<o:p></o:p></pre>
                                  <pre>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                                  <pre>b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                                  <pre>index bd3e20d981e0..c907e2de3dde 100644<o:p></o:p></pre>
                                  <pre>--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                                  <pre>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></pre>
                                  <pre>@@ -1841,6 +1841,7 @@ static void svm_range_restore_work(struct work_struct<o:p></o:p></pre>
                                  <pre>*work)<o:p></o:p></pre>
                                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;process_info-&gt;lock);<o:p></o:p></pre>
                                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_list_lock_and_flush_work(svms, mm);<o:p></o:p></pre>
                                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;svms-&gt;lock);<o:p></o:p></pre>
                                  <pre>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;mmap_write_downgrade(mm);<o:p></o:p></pre>
                                  <pre>&nbsp;<o:p></o:p></pre>
                                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evicted_ranges = atomic_read(&amp;svms-&gt;evicted_ranges);<o:p></o:p></pre>
                                  <pre>&nbsp;<o:p></o:p></pre>
                                  <pre>@@ -1890,7 +1891,7 @@ static void svm_range_restore_work(struct work_struct<o:p></o:p></pre>
                                  <pre>*work)<o:p></o:p></pre>
                                  <pre>&nbsp;<o:p></o:p></pre>
                                  <pre>out_reschedule:<o:p></o:p></pre>
                                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;svms-&gt;lock);<o:p></o:p></pre>
                                  <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_write_unlock(mm);<o:p></o:p></pre>
                                  <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_read_unlock(mm);<o:p></o:p></pre>
                                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;process_info-&gt;lock);<o:p></o:p></pre>
                                  <pre>&nbsp;<o:p></o:p></pre>
                                  <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If validation failed, reschedule another attempt */<o:p></o:p></pre>
                                  <pre>--<o:p></o:p></pre>
                                  <pre>2.34.1<o:p></o:p></pre>
                                </blockquote>
                                <pre>&nbsp;<o:p></o:p></pre>
                              </blockquote>
                            </div>
                          </div>
                        </blockquote>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </blockquote>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------f00qx9fFWf0D9ObzLdwn0zs2--
