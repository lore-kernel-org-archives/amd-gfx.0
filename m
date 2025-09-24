Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88243CAC5AE
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 18:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 279A110E7BD;
	Wed, 24 Sep 2025 18:31:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T6i071mc";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5194610E7BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 18:31:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5YYaeo6F4cAswPw/6/dY0yQq/1b+eHm7d6aY4kIDpfJ49c3ZlICMMqQdcFh/txSk+ImWSahWyalpinb8UQBYDfZ1o9EocWMlxKrhKkmtdKyDUdmUJSatFtDkMlFBraAf8RSnU+w4h8D6GhhSJFsA3XwWmHU9LNs2sMuWoB4VqoXLrikRrakuuWweGuKpw+4fW83S+yyY/vKvvHWbLyYxcMmcQIF+LvTUa5m3a2c8nQd3WZy8fiVtWwWISD1HHUpMmhADkC76FpAhC0CaenCYujH3MC2HytKv9G0rGa9poKh6yZYjm5CExyjV71sd9iO9HKZqEAIr5Cs4NnG7/h0kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcMIiE4yK+5JdXyqUznW60v3Z4CH/nT4DrVjfRriUsM=;
 b=gjhiAEjo8bARWSw5Zo655sgNz9qKdHDeuIrlMbdUfMvXr/Pmh0hqt4y5rKQXLwHNPivJD9dQjskM6BcHQj9kkGqLjp5h1uLIjUl1E8fn/BMlYbBPjbqolkPk0dDjLdtJcYZCUQKIDBHI3Q/tLAbyEh8z2haJKHdFJHloRRh7WFA1UCQZx51m7+XUiNUrJxRuJS2f+5/ZExDTaBET4wg3G2MPJXv2hLoUb0KCS3ngn8oGm3v8N5tqV3VbPZXtjxh6otNj1SMjrp2hcqAZRgOrrcf7yv04uj3KDUhcJhEnc6O5noD3YKb6gWubho6ZcFQWdozluJlboZBf5a8uiBtmrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcMIiE4yK+5JdXyqUznW60v3Z4CH/nT4DrVjfRriUsM=;
 b=T6i071mcJzO2KVY5NMDhaXZ2Fa9BHg9uvYDMkspdIZX9U9oryDysVfjLDsOWoOKS/4yaFHVepZYNYfmm1E2OdFUp9zhB5ojKO2IVlRdryYXbBxNtb2enZJacuHcLEEfkdr9pcQi0jUn0SfPegnU6I7+xJsJDM5xIkRsi8pVTAwA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 18:31:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 18:31:39 +0000
Message-ID: <7ce5b82f-08d5-41ef-9d87-4ea4e8266e3b@amd.com>
Date: Wed, 24 Sep 2025 13:31:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Adjustments to common mode behavior
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, "Wentland, Harry" <Harry.Wentland@amd.com>,
 Alex Hung <alex.hung@amd.com>
References: <20250924161624.1975819-1-mario.limonciello@amd.com>
 <29cbab3f-083a-41a8-81a1-b0234f36152f@gmail.com>
 <cc2094c5-3cc2-476e-8d6f-72fc61ebab90@amd.com>
 <bebbe919-0c5d-4399-a211-c7cf744febdc@gmail.com>
 <68bff33a-46ef-4518-8b1e-d9d1b3087f2a@amd.com>
 <9d0509ea-7341-4bc5-88a0-d36a4b4528cc@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <9d0509ea-7341-4bc5-88a0-d36a4b4528cc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0040.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: 82f3f7c4-a306-4da8-e56a-08ddfb9899b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1VYYVJXU1ZiWmpEelRJQ29sdUNidWlaMkFvaWJteWpvV0RRbUs3NDhYd1VL?=
 =?utf-8?B?bVRKZVJRMmlZNEh3YktDaUxROXpCemFFVDlKZ3d2aGViekJHNGQ0cndjbysx?=
 =?utf-8?B?V1NhL0djSHdqQkdRRERXQTNXTmd2ZVdsZ2V4aXNDeUtZdFhkT3NoakU3ME5t?=
 =?utf-8?B?SzFkSFU2eWllT2IvdWIxdjExMGhKbi81R1ZlRm9wVjMvdkVTd0FaS2RKTTBq?=
 =?utf-8?B?ckNlUitBeGp2SW15TmdaSzVnM25wWmoyc0xFS1NObjFIRWp5RTJDd3dkdnpW?=
 =?utf-8?B?eDQ5QlJKZTR0Z1J4bXJjbXZaMzlPY2NWQm02UVZ4VksxeklKenRrTS9QMC9K?=
 =?utf-8?B?UTVHYXRlNE1oQkQvNUFWVWpNazlRQk9qN1FoOGRLQWdXcnFpNTVibW9sYTFB?=
 =?utf-8?B?WVhHL0Y4VDd2R3JJb2FreWZhV2lSYzk5QWFGc0o0TVdwTEt4STE5QzJBbEp1?=
 =?utf-8?B?d1FyOUE2R2dacXcwc3Nsb0pTcG1mSTZCQkRVMWwxUDVSRWNGclYyaWIrenRY?=
 =?utf-8?B?eEJjdW9LbVc3bHRqMzlqRE9UdXBObEZPMGhCUi83M2xDOFVXTGJnMjVwMTN6?=
 =?utf-8?B?cGlJdk85RE1BWnpwQWVWbjEyMmtwazU3bzRLUjhPN3BhUHV1emdhbkZBU01W?=
 =?utf-8?B?UGVETHlhUzJZK0ZtOTNFU0Rib0xIM1RIWEZvbDhXSGozUm45ampVNmhwQzh6?=
 =?utf-8?B?amxtYTVQL1JzZHNZYUN1VUlEVHNaUHlGYVF2UzJ1V2dTMEZCYTNGRHoyN1JW?=
 =?utf-8?B?Q1FsWlZDa1JSZ1MwSUZaRVJ5aEZkUmN1NVgyS2xqRlhPcjZqQ2kzNE5LWVN2?=
 =?utf-8?B?ajZaVXFiK1Qydm93YzBMQy9BUk0xUmRCNTFJc3hxTURoVG5VQUdodDNPUFE5?=
 =?utf-8?B?aTJNNWpUL21XaFJ4TUgzV2p1VGVzdStiK0JZSlMxMk1VZ1plUGtlZ09Yc3di?=
 =?utf-8?B?Rkprb2trcEFzK0pHaXhTMWtIQVFjZXN5c1FSZ2NWSEtOOENhNmxMMTZWSUxi?=
 =?utf-8?B?SHVPRXhqTGlxaldNNkxKQUFTZmxCUEtJNDlHU3lNVEJibW5VMHFvY3ZGVFd4?=
 =?utf-8?B?dmpMWjdHNVl4VHRkbHp3TnV1b25kbTJ6S295cTdybHNaTDBZbzFUS2I3Z2pl?=
 =?utf-8?B?SHB0cmVpQVFiMGJXVVhZcHExNEFxaU1QenN1T0NiZ01veVdxNmRmc0RLcWxR?=
 =?utf-8?B?SXowdWJwWkpxdFFMV0I1R2duQ0FSMHMwQlBmT1dJYjd5SFNBUm1mMUtobXhy?=
 =?utf-8?B?ay9QaDVlNVh6L3BDV2pnS1Z1azRZbVpSV3BzeDgrNXh2K0RYNlUrZkhUcEVh?=
 =?utf-8?B?empreWdBQThWcXpWYi9nZGdMODhRSWlPR3JibFUyWW1LMjZJVFlITzdyZWh4?=
 =?utf-8?B?QVltMVJVRVA0N3BBL1RjcVVZWVhYWmNmbzZlaGhEV3daeVhqSngxUVkzcW9y?=
 =?utf-8?B?RDkrUUJUb1Q3Q2R3cndCSmtLYUpHMWFTanZPNmtYVWJaSkJGS3pLS0I2VHdR?=
 =?utf-8?B?NWVtcVEzOU9SUHg3bWF0Zjdkb2RFY1dtWksrZ1ZESHdnOEFUN0NSSVlWM3ZS?=
 =?utf-8?B?WFo2RldXQWhlendwUnZsem1nN2ZMSTVEMGVPRUpiVUN3YkVsWG5BRTl3M0Jj?=
 =?utf-8?B?K2IvS3JSTEYxZDZJaTRSaDF5Q29pbmV3ZUs0cmtSRUhJUHRLMjRyTURQREZj?=
 =?utf-8?B?QjNIMzNkR2FPOE5NWG1oRXFEWkFXWXJXY1lPdnZpc201K3k2bWhyNlRBN2Qw?=
 =?utf-8?B?VFltOE4vL2J4QTB6WXFmL2RsVXhQSTZSbE4ycUp2dlZTVHNZQkdJNlM1a0tl?=
 =?utf-8?B?T2hIdC9lcnk2WGhJNzFIV0hXQ0ZXZEpodW1qU1ZoZmFaWTFNNWYvR2tFYjNC?=
 =?utf-8?Q?Wilculw9+TJ2j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEpuN2ZzeStYeHp1TUxLdWlNQnI5UFBLUDVQTnBUQk1lbWwwTzJFZk94VWFK?=
 =?utf-8?B?Y25Dd243a2pxM1IrWTJ5My9iVEFtOGRRL1g2QU9rbjNxdDRNWUlHb2Z6ckxj?=
 =?utf-8?B?RGFGTTFQWFVEZHBFMjE0eXM3NFd3VHI2ZmNtR1VjY1Nzd3QyRDNSYkl6RGNm?=
 =?utf-8?B?VllMQWFHaVdaTDlubVF3SkIzbWRpT1VZeGU3OHpvMVRxbkRiUXkxVFVSTjRp?=
 =?utf-8?B?VlVacmxlQ3BWbGIwWnBIV2xHWmthRTQ2eXpKQ2FOaS81T1VHcERDMUY5SzM2?=
 =?utf-8?B?TDA4QWdOekFOQUlKRE5wMFZjRWJ3OTBrNytQaWdoWUw5Yk9VT1hQM2gvdnJE?=
 =?utf-8?B?QWtoaW5MVW9wckhkWFR5cVRhU0FWcmRyaTZGMnBmKzhYcFR3VGxMN2w3N0Zh?=
 =?utf-8?B?UnVoVTFqQzNXcVh1NnY1UkFKQm44RjZKRFZOWGxSK1lBd2FRM1RvT0tmZkhL?=
 =?utf-8?B?eVo3SDlDVUZCRGo2cFo1UERSOElySjRzMElRY25xckM3TlNSMklmamI0MnN5?=
 =?utf-8?B?V0luSTB3dFZZaEdiMHZtUjlBOGQ2ekVUZFJaNUNURXFtSkhBVUt1MHF6TTg0?=
 =?utf-8?B?NmxxTXpFYXhrNVhlMk56U0g0Nk04R210akY2ekhtdUdSUXFxM0NCcGJLa2Jw?=
 =?utf-8?B?V2t2aHNrNUVLUjdFOVB4SW11MTZGa1F1bDZPQTlNTDlwZ1NKT0JmK3g3NTNS?=
 =?utf-8?B?TXZXL3NWVUIwQUtSUGR4RkZGdlhhY25JUUErZmFsYkpDK2FIckdWMEZ5ZU1L?=
 =?utf-8?B?S0tmcVJuYk5aVXNBM3A4cE9oendvM25CT2g1TDRRU2c4d1ZlbHF4RVgzTXdj?=
 =?utf-8?B?dVhobkZpWVozVWlWRElYQUFLdDdLb2E1ZTliYnVJL0NWUWRqNmxjemRHbnZ1?=
 =?utf-8?B?QzN3ZVJQakFGSzBGSEhSV0I4aHg1dHFWRmZySUJPYSt0WHNGSk1od1RYcnlR?=
 =?utf-8?B?T0RXRGF1ZVgxYUhWWFlZZFV4Zld3ZlZzSUhFVFJLVDhUVjR2TC8rTHBleXZ4?=
 =?utf-8?B?Nm8wcVVvdlduRm92NVc2RnRrR3BmaE5FcTh0bmlkQXZSRU9DVzRZMXlRMjV3?=
 =?utf-8?B?Smd1ekpIMGlvakcyekVGSVE1anB3a3p5eHZFL0VDRnJudmVyTnFNUHUxWlBq?=
 =?utf-8?B?SE9FMk5DSU94c0g1WjNCRjU4UHUwK1BpbEhqa0VsZGM4V3Z1ajB3N1dDUDIv?=
 =?utf-8?B?ZlNyN0hwZEU1ak8rMllKUC9lMytqNENodG5oTlFjakdmaHVaTmo1Z3dDMklp?=
 =?utf-8?B?Z250Q3RxczJla1lCSnRMOXZCL3dqQlo1ckJtWlYzSEFkeDd1RXA3cVZlM1NG?=
 =?utf-8?B?Ykl4bmlJQS94N2N5dTNCQ1YrRERuU0loZFJrUzJvWDdaQlhZODhJYWlqU1Ay?=
 =?utf-8?B?Mzl6QldYNE4wcG1JNEQ1dE5xQVJVMUEwNTJMa3dRSGUzVHI1ZzVvZXBLUkI0?=
 =?utf-8?B?MnFhWlhQM1FQMUZMY1M3RTh5UW43L0MyZWM3eUdVdWVnSGxBeVFhbVM1N1JJ?=
 =?utf-8?B?RHR2KzV1eHR3RUVtS1MreUIxYXAxQzVkNkFZNTRDTXlBcFRtdkNHajZVeDll?=
 =?utf-8?B?NEdrNHQzaEJoQWZ6WnlSSmhWd3pQanJTZy8rcGt3RkVXL2JwNUxIblBWdkg3?=
 =?utf-8?B?cS82QUNYOVBqOGV4bmkzRGdJaGV2Tlc1emRZanVUQ1V1amQwajY0OW1MbEM4?=
 =?utf-8?B?emxKaXIrN05QVDdmcEptU0dsUEdpNGdnRDhSeC94Q0hDdkNrMW5JenhHdCtD?=
 =?utf-8?B?RUhIYWR2clBISUFORTZVTXVsM2VncnJMYmtyWnh3dHlyZy9mdWhFS05tTHRv?=
 =?utf-8?B?YS95dVdLdXFzU2tXVFplU0hQUFp2d2tNTUhMeGVqNjNzNGM5NW9jQjcwSzRq?=
 =?utf-8?B?L1BlUEZ6a3pUcHBQY1FqS2Q0cjk1VHU1ZDNtNEw3ZDdUYytBQzdLVldrVkxZ?=
 =?utf-8?B?cGltbW9DSEZTZU1XQVNwSThQd204VTQzUEEvendjdEZKZi9nUXZyTnA5d3Vm?=
 =?utf-8?B?eFcwZEllc294Wml3cjA0SFJVN0JZVXlsd0VvUGMzcE5LaTlpcmlCWENCZnQ5?=
 =?utf-8?B?c08za3Zac0VUVkpZTVpzbW16NTJYcE16LzhBejNST05FU2FPOEFWNStSN1du?=
 =?utf-8?Q?dIrLWWPrjtBpCpK7udPY7uh+6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f3f7c4-a306-4da8-e56a-08ddfb9899b3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 18:31:39.2827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvXB04pT6xuqvT8nQpuL9B2txOfSxvxabuuOF8wZk6riAVQP6GewvEdpRMeNGeyiluXz3Kasmsku89ve8/4vZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003
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

On 9/24/25 1:11 PM, Timur Kristóf wrote:
> 
> 
> On 9/24/25 19:48, Mario Limonciello wrote:
> 
>>
>>> A slightly related question, would you be OK with changing the link 
>>> detection code to return dc_connection_none when DDC cannot read an 
>>> EDID header on digital signals, similar to how the non-DC code does it?
>>>
>>
>> I personally think lining up all these nuances that are different 
>> between the two is a good idea.e e
>>
>> But for that specific question that's probably more of a Harry/Alex 
>> Hung question.
> 
> @Harry and @Alex, what do you guys think about this?
> 
>>>>>
>>>>> Two possible cases come to mind:
>>>>> 1. When we are unable to read the EDID for some reason
>>>>> 2. When the EDID is buggy and/or doesn't contain any modes
>>>>> Are these issues real or am I overthinking it?
>>>>>
>>>>> Thanks & best regards,
>>>>> Timur
>>>>
>>>> Failing to read EDID has happened in the past, but I think with the 
>>>> deferred aux message handling that should be cleared up now.
>>>
>>> I was actually curious about that. I saw that issue while I was 
>>> working on something else. How is it deferred now? Can you point me 
>>> to the series that fixed it?
>>>
>>
>> There's more patches than this one, but I believe this was the 💰 patch.
>>
>> https://lore.kernel.org/amd-gfx/20250428135514.20775-27-ray.wu@amd.com/
>>
> 
> I'm not sure if that deals with the same issue that I'm referring to.
> 
> Basically what I notice is that when plugging in a cable, it can happen 
> that the HPD pins make contact before the DDC pins, and hence DC fails 
> to read the EDID. This can happen often with DVI ports and rarely with 
> HDMI (and never happened to me with DP).
> 
> The non-DC code has a solution for this to retry in a few seconds.
> I wasn't able to find anything for this in DC.
> I found some code to set up some HPD filters, but that code is not 
> called from anywhere and I was told the HPD filter may not be the right 
> solution.
> 
> So my question is, what would be the right solution? Can we use a HPD 
> filter? Or better to do what the non-DC code does and just retry again 
> later?
> 
> Thanks,
> Timur

Ah yes this is a totally different problem.  It doesn't turn into a 
storm does it?  I would think a filter only makes sense if there is an 
interrupt storm.

As long as it's just one HPD and no EDID found from what you've 
described I would think spinning up a timer to try again in a few 
seconds sounds like a reasonable approach.
