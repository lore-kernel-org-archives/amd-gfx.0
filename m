Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9CAC3DA49
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 17:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FE7810E2DB;
	Fri, 26 Jul 2024 17:16:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jigal3Ek";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11D5F10E2DB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 17:16:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T74B5+xRAu7hONRT8FayOcoTZ2QS3jSvom5aRZF0mrpMEiGy0xjHsJQO1JuUjOnlCKz2wRXnWCaB8AKvkZMHdPoGRad+SrGf850M5AAsBASc21mAua7xfa82f4ZWoY4XdtpwaLelLg2XiqgcLHIlMVLulyLmEX+aX/WkFHjrK9ZjLweFKFtNq56G6ZssCC5QupLkk+vyc+BojO6D0yw9dsQnqXWOpPvbvez5w4Nol48b15T+hAuhpzKTtNcaPAVjV2Wm1yzE8GUVLyIBXeTFFhxOfJ7yimp6kIGJa/B/+e5bMX6FRSpfEMiaFWc4rVyHD6LAAij1cklQ5V3X4t4Fwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBWS4ddniRe6sTB7agZ3n/guW7Jz/Sc93mI0YvzTb94=;
 b=dxw6LDs9rD7uNiMRW6/bz8THkf9b6iw2MOmdpQSods+cszcMEziysloOy8E/+tqDWZtUjPRfLNLFtyeTjhp7cARkbj3xQoyAP52PDrp7QXx1CKsUJfKrrgcUU/Sw0CZ6GscRu7X0KvDci8/EzuXmJf/sggH4k0bv7zyz8NC37WNeqxA5mc90pw5AWspgSFTzf6fd2lkaELsGpYsZWyraveSkk9smHC1tJaXBBfDQ/A9dLoZg83ud3bzjIfigjnnbF1VU7LRudok4Fa2s7ayQuysn6jF5PAzZ+omTSCnXZ9mtv08FXu9tjZt2TxyZMaPL3O858iPZF2j7xR3SDlVDXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBWS4ddniRe6sTB7agZ3n/guW7Jz/Sc93mI0YvzTb94=;
 b=Jigal3EkSXrMIVcKpUahr5dk5p9U4hsAHRThZEtlPS90LHTG4jq5bUk3sh0v2z0F+IYCfpofCmQ4UYx2fpRin8/OJdrAdyEAonw/oFRE1Ea5n8LDtdKtGGF+XESElRSVNbTawosLZ5kyv/+bZR3gnaGVJ1uAbUQDq+kelDFh8b4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by SA3PR12MB8022.namprd12.prod.outlook.com (2603:10b6:806:307::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Fri, 26 Jul
 2024 17:16:08 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%7]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 17:16:08 +0000
Message-ID: <23d1ef60-5756-4c4f-9fb8-04ff0dc31821@amd.com>
Date: Fri, 26 Jul 2024 22:46:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: trigger ip dump before suspend of IP's
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>, 
 Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Liu Leo <Leo.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240726124751.3121312-1-sunil.khatri@amd.com>
 <20240726124751.3121312-2-sunil.khatri@amd.com>
 <CADnq5_NdYiwGGvyVvg3_0aUuH9YLL_kUgNUpjEad8z8E1xWfMQ@mail.gmail.com>
 <57660e1e-1aad-4ba6-be90-abda2b377e3f@amd.com>
 <f967ce91-dd88-4542-8340-1e61813eb780@amd.com>
 <d49c682a-57ea-4061-8b42-59764f603164@amd.com>
 <77bb2c37-d906-4c76-b87d-effbbe6064e4@amd.com>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <77bb2c37-d906-4c76-b87d-effbbe6064e4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::12) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|SA3PR12MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d48a197-6569-4eb0-dbda-08dcad96a3b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vi9sK1lKc3FkUDFsOXRIb3dIVno1eGFWM1lNZS9FaDRGVVB4Z0pBS0dtalI1?=
 =?utf-8?B?Ri9MK2Z4S1Y2aGhVR2gybWdjQzhmcUNzeUtmRjZ1OS90c0tTZHFTbnBqV3Ji?=
 =?utf-8?B?cktOS2d6bExXUE1xYm5PSHQzazVDNjhPV0szK0pBcXpwSFdML1h5a21YNWV1?=
 =?utf-8?B?SGlJdGFhSkhzVExJdmZJTzU2My9mME9LNlJVSlVFdXFpN1BIZngrcEJhZjU4?=
 =?utf-8?B?cm5jcGRvQk8wMFBaMWxUQ3k3b0thdVlpekU3RFlBYnRkdmhzdmlpWkJHaStK?=
 =?utf-8?B?ZGVMdXkrSmNUczMwYmxISjEzNFh0UGw3RXEwWnZQYi9TL1IzVkZFQ0d6ME8x?=
 =?utf-8?B?TWNabmc4VTJkc3AxU00rcFpZbG83TlJlMVdCQStuZlNRNmgvSzY3WlV0NzVM?=
 =?utf-8?B?bzNYMnpKejZHOXdUMzI3ajVhVFBQVDFMMUMvOXYrUzN0MjRIdkk5T1pZNGhr?=
 =?utf-8?B?cDI3TGh5dThhQWpseVVRU21HMXZVeUhOSjdRTk0xWnp0Zm1wVXF6NXFqNGFN?=
 =?utf-8?B?SzQ2Sk9ubVUrNm5Mc28yOHVQbGFHRXJEOStldDhieURFV09TdXd5WEtYQktL?=
 =?utf-8?B?RjQvSDBENDFCOVkyZFFuQmRkN29wbGN3ZWpJTHlQYytTd1FpZjlCN1EvNkNO?=
 =?utf-8?B?ZHRpQmdOUGw0aEhYN1UrMkE3clVVa0UzaklxV1pPSmwyVjdINkowT29sWDdO?=
 =?utf-8?B?S3c5WlpVUS9UblZKbVdBL1RVY2dkTEN6cE9mUUhLT0JIblFGOU5qbXBrek5G?=
 =?utf-8?B?WExDRnJ5bmxHQ3BKbDU2bjQvNFVQSWxwUUw5Y1VEK0c3ZktXcGx3NVBUUVFB?=
 =?utf-8?B?bkVEb3FaVlJHakRvSjV0SkxIeU1vVFRlRnluZWNCS2NmTStXaG8yRi81a2lo?=
 =?utf-8?B?YjRJUnNmbGtITHZ2TFJaSW55NEhJZ2c4UmFERHlhUXJQMnNtU0orYkRtWjRU?=
 =?utf-8?B?dnVKQU8ySEN2eGtyUjVpUy9rckowWXAyWk83V1RHK1g0VjVINTV0c3h0eGo4?=
 =?utf-8?B?QjU5by93Njk1NXRnaGZjSE5TYzg2QTNJSGlQRU1PZERiMnJ5SkRQUXJJODdK?=
 =?utf-8?B?eTJhTDRLWEVGdzJ1T2c3d1dnYTZOTUl1L0w3THlabjZCOFFOb2RGb0JiTHhK?=
 =?utf-8?B?cFNQVHZXVGNJU0ZjbG15YU5rdlpHdUJIaEwxcDN6U1A3K0JGY0JQTnRGaVRC?=
 =?utf-8?B?Zm9xVVFHRDlnME9oaFFrV0RldVp6Z1gzT1lWZFlGd2s3ZEFEeU9JZ1dIbjcv?=
 =?utf-8?B?ZUxqTFl6Mjl0dHJtTkJDT3JEWmF0NzJIZk5JMk0vMk5VaWs5QzliUlQrUTUz?=
 =?utf-8?B?cTJ6RWhPYURmdFhLT0xhNHN0OVo2cnlrUHoxZlV6aDh4S0p5OWlsWS9jS1BG?=
 =?utf-8?B?UHcyVHNGd0pkb25ZdUhsSVdxZ1FpYk5NWFZERjVNM2FKb0lPY2dBckxISzdT?=
 =?utf-8?B?UnBna2lHVm84THJkREZtdnlmbTJCUkdnbFFNTjhWNEdob1V6M3c3MHR0eHRL?=
 =?utf-8?B?MVQwQ3FNT3YrRHBZSHZvLytrc2xTT1gwRVdYMkhDVFJKNDRicWhJTnlJVVhC?=
 =?utf-8?B?KzBuQ2VTVWtsZnBPQXR2Q3oxaXZ1Vi85WjFIUTJUZUhXTnR3TFVhSFpzejJ4?=
 =?utf-8?B?dmxKcHpSeWVvbmhNYkZoMmRES3BRdDFLRVpsa0o3UGpNdmZvRWg0VVVoOTVI?=
 =?utf-8?B?MmtlMVJrYnpLUFVWVStWOVdLYktIQldFY3BoZkEzVC9FMWJEZmcyK0xvY1h0?=
 =?utf-8?B?SHJOMkhkNUFUYWFMMjFBMjQrcmJkSDg1NGFOOC8yRWc0SitmMHA2c1NNaVJI?=
 =?utf-8?B?Umt0dFYyOFRMK1Q0cFA1Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uys5a2M2dXNxRjhRRUJMRitscUxNU0hzS21hM1h4RGcrbzBDNGVrNStaL1hY?=
 =?utf-8?B?RVVUZkZBaTFaaHBZa3l5Ums5NERETVoyRTJqRnl1R1Zmc2NzcFgvc2VQOHhF?=
 =?utf-8?B?SmpMTmQyWVFVSUdIYkpjclhUR2U5bnZybnp0RTBvaUlUUjR5YXNaM2d4MEs1?=
 =?utf-8?B?TWlzY3BTOVZYZm5Rem93eTlkdDMxamZ3bkpHaVNUTHZTZFUwWHBQLzdYUFBx?=
 =?utf-8?B?M2NQUCtxaEd2VWc3LzFqMG9VVnI4K244V21hNHdEVVAvekhyRCtEYnEyY1Ju?=
 =?utf-8?B?MG1lQjFxYitxLysyTG5DRXVndmV1SDNRbTYyMkt6emQ2cVRReFY1WWU3eC9p?=
 =?utf-8?B?STREK0t3azMzZTJ2L2RXdVY0MjFweHJUQWY2MjlnVTdRbUl4Q0RueHJ5YlpN?=
 =?utf-8?B?NDJMcTdHVFcvZEg0Z3ZpQ2tZV1VESEVoZTZMdkY5N3MwejhVejVVK0dJb20x?=
 =?utf-8?B?Y29vZjk1TWo0ZEtmMUhJbldraWUyYU05azdtU0ZOTTNYUFAxSDlCZ29GZUJo?=
 =?utf-8?B?c2ZMQnBTSlBOOFNFY0lMaVZCYXNubDE3TUc2QzVpamJVVlFXQXpSSlNmRm5j?=
 =?utf-8?B?dC9YUUMwdk5NYXlmaUd1dzBzcCtKL3ZWUGtSTSs0M3JRWExnY2tTUFg0bkFI?=
 =?utf-8?B?cTZnVjdqM2dQVnNNZzNJL3EvL29pQ3d4OHVVYVJvRThUTEZyeEZQL3d2Q2M4?=
 =?utf-8?B?a0Y5RFdnQVdaL0d0NytuREVWRWkrUGFJR1podVRWZEtGYkZsRTd4dlVrb0lj?=
 =?utf-8?B?bHIyQmx1Ym9kd1B5aXAvUHdpa0wzRDBaaDI1Vk1QdTJMNUxhaStzVGt6MWJG?=
 =?utf-8?B?ajBBZTd1YW5NMXhJeTArMEYyZXhGbVJjUkE1RDc0NWt3OFYvTDBWTEdlc3Ft?=
 =?utf-8?B?N3RSaVVuOTdnTnd0U1FzU1hSN3A4dmJRMzRBbFY2QjNJYSt6ZW9Qelk0d0Vs?=
 =?utf-8?B?UnBmamxxd290U0Z4K0xBUkVIRUNjdnNRTGZsT1N2SXQ2d1VDb25JSkIzc0lt?=
 =?utf-8?B?WlBqQVlZSFh3MU1WK2JGK1FidmhlYmY4bVVOVkhiOFEreUtOLzFOTDdoUlFL?=
 =?utf-8?B?ZE40VkxEZzlnTUh3RHNkSWdFekRESjZBQVVCWUIzSzYrSy9FM2o5QWZJc2c1?=
 =?utf-8?B?eS94VEI2RmUwWXJJVkw1RW5KR1MreUsyUGZPV3dqWk1GTUJ6dU9tZkluV2My?=
 =?utf-8?B?c3hiQnlkTjE1cTJvVjNmWFpwOXJoUEY2Wlpsd2YxNFRCbEpsV2pIM1lIWnFE?=
 =?utf-8?B?MkVMUW81ajJROTd3SmdsU01RSTR4aDd5eDdmZmJtWVpFK09lQ0s5am9Qa0Zj?=
 =?utf-8?B?dS8zL3llZHZHcGZ1TVNBbGZNS1YxWE9FMWplWDBBcURqN2hPQnQ5cTFKOVpr?=
 =?utf-8?B?WnhXeEN1Q1NQazBZZnZZNzRHbVlEZitWNVp5cUxqYW84Zzc2bEIvcGJzUW5U?=
 =?utf-8?B?MHZzMzg5dlFVN2RoWVZkZllEN0IvQys0aGMzb2dUZkFGQ2x2aDRUcUxITitR?=
 =?utf-8?B?ZG0rMk43UDdrbWo2V3o1MEZnNWtCa0I5ZWNGUXQvSjN3cllNTDVBbE9pRStp?=
 =?utf-8?B?b1FIUFkzcjJaa0tzMnZjUUdicWlMVXVYek16YzJJcnFON1FkVmhQMlpncGNz?=
 =?utf-8?B?TnkrZ2dqMitzYkpEbXU2MU5rVzBoQ1IxdUgveC9zVzRrRWlQNkR3MklBb3hq?=
 =?utf-8?B?TmJDaHFMVWFuTXpvU1RzRVVmSkc4NTQ2S0tkOTZoVFhLRnlOTVpoQi9Qa1pV?=
 =?utf-8?B?clVzMGlYa05lY09ZeHltOTNsMWErOHhDeGNTOFZmZ1htMDdNcHR1TXJYT0Nn?=
 =?utf-8?B?VzRNYlBkeENIMitXQ0NiTkFhdUFFcHh6Um9FU2ZYekI0Rm5VSDBTM0FLOTVV?=
 =?utf-8?B?enFpaEVXdis3VGFsVjJ3S294cDV2T1JFS0lyVUJVZzB2MWVKbHJQcjZsRHAr?=
 =?utf-8?B?MVJSN1hUOENIU3EzRXVVOS9sSEw0UXBQUEFCKzA2TmtwYjM0b2hxTzNHZWZ6?=
 =?utf-8?B?WEw0OWFHVjF2NU50NElCSXFFcWtCNTdhZGNUMWtacjIwNjFXV29UWWdhbzZh?=
 =?utf-8?B?RnhqWjF4bXlhMFcxa201akNOU0tSUmZZUC84Rk1QaVJveGNiZlhEa2lYQ0c0?=
 =?utf-8?Q?ad6py5tMtq0cDpsnGYx7Z9h3F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d48a197-6569-4eb0-dbda-08dcad96a3b9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 17:16:08.6350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wag1Bw/HWGqPKdabvHsT1yY2Jb8pmGtvexFa3gzXcemkgMUyoQieU9uq/ritEu2Metdm+Xv6VNjmkW7iGx+TyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8022
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


On 7/26/2024 8:36 PM, Lazar, Lijo wrote:
>
> On 7/26/2024 8:11 PM, Khatri, Sunil wrote:
>> On 7/26/2024 7:53 PM, Khatri, Sunil wrote:
>>> On 7/26/2024 7:18 PM, Lazar, Lijo wrote:
>>>> On 7/26/2024 6:42 PM, Alex Deucher wrote:
>>>>> On Fri, Jul 26, 2024 at 8:48 AM Sunil Khatri <sunil.khatri@amd.com>
>>>>> wrote:
>>>>>> Problem:
>>>>>> IP dump right now is done post suspend of
>>>>>> all IP's which for some IP's could change power
>>>>>> state and software state too which we do not want
>>>>>> to reflect in the dump as it might not be same at
>>>>>> the time of hang.
>>>>>>
>>>>>> Solution:
>>>>>> IP should be dumped as close to the HW state when
>>>>>> the GPU was in hung state without trying to reinitialize
>>>>>> any resource.
>>>>>>
>>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>
>>>>>> ---
>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60
>>>>>> +++++++++++-----------
>>>>>>    1 file changed, 30 insertions(+), 30 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> index 730dae77570c..74f6f15e73b5 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> @@ -5277,11 +5277,29 @@ int amdgpu_device_mode1_reset(struct
>>>>>> amdgpu_device *adev)
>>>>>>           return ret;
>>>>>>    }
>>>>>>
>>>>>> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>>>> +{
>>>>>> +       int i;
>>>>>> +
>>>>>> +       lockdep_assert_held(&adev->reset_domain->sem);
>>>>>> +
>>>>>> +       for (i = 0; i < adev->reset_info.num_regs; i++) {
>>>>>> +               adev->reset_info.reset_dump_reg_value[i] =
>>>>>> +
>>>>>> RREG32(adev->reset_info.reset_dump_reg_list[i]);
>>>> A suspend also involves power/clock ungate. When reg dump is moved
>>>> earlier, I'm not sure if this read works for all. If it's left to
>>>> individual IP call backs, they could just do the same or better to move
>>>> these up before a dump.
>>> Suspend also put the status.hw = false and each IP in their respective
>>> suspend state which i feel does change the state of the HW.
>>> To get the correct snapshot of the GPU register we should not be
>>> fiddling with the HW IP at least till we capture the dump and that is
>>> the intention behind the change.
>>>
>>> Do you think there is a problem in this approach?
>>>>           amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>>>>           amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>>> Adding this does sounds better to enable just before we dump the
>>> registers but i am not very sure if ungating would be clean here or
>>> not. i Could try quickly adding these two calls just before dump.
>>>
>>> All i am worried if it does change some register reflecting the
>>> original state of registers at dump.
>>>
> I was thinking that if it includes some GFX regs and the hang happened
> because of some SDMA/VCN jobs which somehow keeps GFXOFF state intact.

For GFX and SDMA hangs we make sure to disable GFXOFF before so for 
those IP's
I am not worried and also based on my testing on NAVI22 for GPU hang 
their registers
seems to be read cleanly.
Another point that i was thinking is after a GPU hang no where till the 
point of dump
any registers are touched and that is what we need considering we are 
able to read the registers.

For VCN there is dynamic gating which is controlled by the FW if i am 
not wrong which makes the VCN
off and registers cant be read. Only in case of VCN hang i am assuming 
due to a Job pending VCN should be in power ON
state and out intent of reading the registers should work fine. Sadly i 
am unable to validate it as there arent any test readily
available to hang VCN.

>
> BTW, since there is already dump_ip state which could capture IP regs
> separately and handle their power/clock gate situations, do you think
> this generic one is still needed?
>
> For whatever we have implemented till now seems to work fine in case of GPU hang withotu fidling the
> power state explicitly. But Calling suspend of each IP surely seems to change some state in IPs and SW state too.
> So i think until we experience a real problem we should go without the generic UNGATE call for all IP's
>
> But i am not an expert of power, so whatever you suggest would make more sense for the driver.
Regards
Sunil Khatri
>
> Thanks,
> Lijo
>
>>> What u suggest ?
>>> Regards
>>> Sunil
>> I quickly validated on Navi22 by adding below call just before we dump
>> registers
>> if(!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
>>                         
>>      amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>>      amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>>                         
>>      amdgpu_reset_reg_dumps(tmp_adev);
>>      dev_info(tmp_adev->dev, "Dumping IP State\n");
>>      /* Trigger ip dump before we reset the asic */
>>      for(i=0; i<tmp_adev->num_ip_blocks; i++)
>>          if(tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>>              tmp_adev->ip_blocks[i].version->funcs->dump_ip_state(
>>                                      (void*)tmp_adev);
>>      dev_info(tmp_adev->dev, "Dumping IP State Completed\n");
>> }
>> If this sounds fine with you i am update that. Regards Sunil Khatri
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>> +
>>>>>> +
>>>>>> trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[i],
>>>>>> +
>>>>>> adev->reset_info.reset_dump_reg_value[i]);
>>>>>> +       }
>>>>>> +
>>>>>> +       return 0;
>>>>>> +}
>>>>>> +
>>>>>>    int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>>>>>                                    struct amdgpu_reset_context
>>>>>> *reset_context)
>>>>>>    {
>>>>>>           int i, r = 0;
>>>>>>           struct amdgpu_job *job = NULL;
>>>>>> +       struct amdgpu_device *tmp_adev = reset_context->reset_req_dev;
>>>>>>           bool need_full_reset =
>>>>>>                   test_bit(AMDGPU_NEED_FULL_RESET,
>>>>>> &reset_context->flags);
>>>>>>
>>>>>> @@ -5340,6 +5358,18 @@ int amdgpu_device_pre_asic_reset(struct
>>>>>> amdgpu_device *adev,
>>>>>>                           }
>>>>>>                   }
>>>>>>
>>>>>> +               if (!test_bit(AMDGPU_SKIP_COREDUMP,
>>>>>> &reset_context->flags)) {
>>>>>> +                       amdgpu_reset_reg_dumps(tmp_adev);
>>>>>> +
>>>>>> +                       dev_info(tmp_adev->dev, "Dumping IP State\n");
>>>>>> +                       /* Trigger ip dump before we reset the asic */
>>>>>> +                       for (i = 0; i < tmp_adev->num_ip_blocks; i++)
>>>>>> +                               if
>>>>>> (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>>>>>> +
>>>>>> tmp_adev->ip_blocks[i].version->funcs->dump_ip_state(
>>>>>> +                                                       (void
>>>>>> *)tmp_adev);
>>>>>> +                       dev_info(tmp_adev->dev, "Dumping IP State
>>>>>> Completed\n");
>>>>>> +               }
>>>>>> +
>>>>>>                   if (need_full_reset)
>>>>>>                           r = amdgpu_device_ip_suspend(adev);
>>>>>>                   if (need_full_reset)
>>>>>> @@ -5352,47 +5382,17 @@ int amdgpu_device_pre_asic_reset(struct
>>>>>> amdgpu_device *adev,
>>>>>>           return r;
>>>>>>    }
>>>>>>
>>>>>> -static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>>>> -{
>>>>>> -       int i;
>>>>>> -
>>>>>> -       lockdep_assert_held(&adev->reset_domain->sem);
>>>>>> -
>>>>>> -       for (i = 0; i < adev->reset_info.num_regs; i++) {
>>>>>> -               adev->reset_info.reset_dump_reg_value[i] =
>>>>>> -
>>>>>> RREG32(adev->reset_info.reset_dump_reg_list[i]);
>>>>>> -
>>>>>> -
>>>>>> trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[i],
>>>>>> -
>>>>>> adev->reset_info.reset_dump_reg_value[i]);
>>>>>> -       }
>>>>>> -
>>>>>> -       return 0;
>>>>>> -}
>>>>>> -
>>>>>>    int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>>>                            struct amdgpu_reset_context *reset_context)
>>>>>>    {
>>>>>>           struct amdgpu_device *tmp_adev = NULL;
>>>>>>           bool need_full_reset, skip_hw_reset, vram_lost = false;
>>>>>>           int r = 0;
>>>>>> -       uint32_t i;
>>>>>>
>>>>>>           /* Try reset handler method first */
>>>>>>           tmp_adev = list_first_entry(device_list_handle, struct
>>>>>> amdgpu_device,
>>>>>>                                       reset_list);
>>>>>>
>>>>>> -       if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
>>>>>> -               amdgpu_reset_reg_dumps(tmp_adev);
>>>>>> -
>>>>>> -               dev_info(tmp_adev->dev, "Dumping IP State\n");
>>>>>> -               /* Trigger ip dump before we reset the asic */
>>>>>> -               for (i = 0; i < tmp_adev->num_ip_blocks; i++)
>>>>>> -                       if
>>>>>> (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>>>>>> -                               tmp_adev->ip_blocks[i].version->funcs
>>>>>> -                               ->dump_ip_state((void *)tmp_adev);
>>>>>> -               dev_info(tmp_adev->dev, "Dumping IP State
>>>>>> Completed\n");
>>>>>> -       }
>>>>>> -
>>>>>>           reset_context->reset_device_list = device_list_handle;
>>>>>>           r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
>>>>>>           /* If reset handler not implemented, continue; otherwise
>>>>>> return */
>>>>>> -- 
>>>>>> 2.34.1
>>>>>>
