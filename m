Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE2BD609D2
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 17:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29C7810E2DB;
	Tue, 16 Dec 2025 17:16:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gPMk5aFU";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAA8210E2DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 17:15:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpAWJadaN8v63TfvOHiyzbVJokqZ2p9EZBZ1B/eM02IFpw+CppD2aou2ygNfVdGP7g2/PJxXNyRhI95EUsuGx9RX223WcToxHRddomOpekyvmDCuTV/FF7XtvKcTHnI3J6aAof8hInlCMhs110Y3OSidsXKdQ7QN4t4tA+1AX0VVuj2LdUdYirsVuIQuV2iLM+WglAixD0LJJ+Ns3csPVsuT3nHsPQuX+vy7XlcEEsR8f7mOuQOHxweIItoXic9tOX6GpgTw0V9/rjpQ0nSnJ9ldY0GG+8w+2S0AyMgpJf9XfZwqvAT+LCisddO4MTJgLGQIKuDeA53FYoBfjvCXZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+sOHc4BhWiaIwvhoNp8eiE7CfY59PfijRACNnboSs8=;
 b=rF8FhGL+lqd8ELWJZ9ClkJE4nIZFa0/XktWujsQFe+B0ui25Hdst6qjoGKEMm0g4ZfcwYTFBtVsTKNoDR16bzhelWfAhBuqUrK0NqQ/TZr4I3UAdBJ4UXgtpf7YgSTVPiE0OIfdcZotgwSaDHBEahf2m6PE1svUTPHMucenMNcXO451HTy0cDBmo6qVeQGGydnYtbLYHtsAvfSvaanEc5nO36bTOGKJ8aq2DtvqS78TK9Jr5p+ftvVfZ0k+botQgZWQXzDT1hvTA1VGelN4OVA+kQ2mosvz3sauL49eRTwjPqSCDgAxBwL8BvzzyDaAAF5nwDtRQgJ25uhVFDhA0tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+sOHc4BhWiaIwvhoNp8eiE7CfY59PfijRACNnboSs8=;
 b=gPMk5aFUKeQemO0JwobetBNxbovK61dxyAalN3D1ZecynBdbbWYnOtrSMPKZJNmzFgZ/pB4/eqevnELunkhuS+2uKEi/f0UTYrPXx/hUnHVEJYhT3uY9zTB2qMKWpcn6HGozOKcABT9aoDEuM7G+soY8auaqZ2qBEElRahOtoqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 17:15:56 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 17:15:55 +0000
Message-ID: <79b066ea-37f2-4b2a-8ce8-162cccd09940@amd.com>
Date: Tue, 16 Dec 2025 10:15:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] drm/amd/display: DC analog connector fixes
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <Harry.Wentland@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>, alexander.deucher@amd.com,
 siqueira@igalia.com
References: <20251206023106.8875-1-timur.kristof@gmail.com>
 <CADnq5_PhBodb6o9LHi6e5Y8yQUaJyTa_EvMyWFpmmfrpZrUkuA@mail.gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <CADnq5_PhBodb6o9LHi6e5Y8yQUaJyTa_EvMyWFpmmfrpZrUkuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:303:8e::22) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DM6PR12MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: cee977da-db54-49b0-07d3-08de3cc6c5bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?em8zN00vVUdVMjBQa3FMakNQRWpPUEZuVUpveTg4ZXB4cXc3czFRTTNWZXNW?=
 =?utf-8?B?MHo0ZE1tcmJqTW4yNzNpaXdxSiszaWJWbW1uZytRQmZ0Q2V0MEwwNzUzOFMz?=
 =?utf-8?B?RkpZUERLb0x1alJ3Z1h6K2J6eFBjTWQrU1hJdi96eWdnWnh4WG1YMEFlWTBM?=
 =?utf-8?B?RWxVeVIwZXQ1bjVneU1jaWZQMHpwUkVlcmhMUFVMdXFzalRWNzFYeEZ1ZWgr?=
 =?utf-8?B?RFpETUNsYVhlT1hkQzVwSmMvekc5a2QycUZ2NDVvbm16V2ZqT0dKcVZuRFdx?=
 =?utf-8?B?UEpIdGZiRGJRTWUwWmpIUUVWT1hrdkRNeS9SYmxlT3dOSHh6d3I4R1JDOUpo?=
 =?utf-8?B?MTNmdmlMa0x3S0FnZzJEMktyVnVHK1hxMGNOTEd2c2pXY2Mycng1Z2FIWkd1?=
 =?utf-8?B?TUxBcFhNbk5yaFFWL3d3SG5VdVZxV01kSWgxT3pXcXZFYzhhc1hGQTU1ejgz?=
 =?utf-8?B?L1hjeElSYkNSMnQ3YldadjRGTTFLRVN6VWorU3BvZ2d0VEFQblZmdWxiOU1a?=
 =?utf-8?B?SjFuaWtEWXpFSzVzdWdwRkF3d2tHeWhmZy9sdU9hKzN5ekRHZGc2cjFWUkxw?=
 =?utf-8?B?eFUxQTVjK2M1b3BGOGZOK1lGYitJY0lFVVFWYTYvVGE3ZStLeWVJVUpSM3lU?=
 =?utf-8?B?OEcrWCtNbENRTFVjZVJtZ2syOXRVZG45WjFXQTZqdm9qYmVSYUJta3ppVERt?=
 =?utf-8?B?K3dNa1V0WXowR0p3ZERUZFo1bGVOZGJLL1Q5MUV2Vi9zb05qbXNOL1VURy85?=
 =?utf-8?B?a2J2Y2RWV2JDZ2xJYkUyd3lQNjlxVzhNS05hdFRaaHRqU2lpanhxQ0VlOE9N?=
 =?utf-8?B?Y2xxMHBQTTAydzRvaVZqZC9EZk1EcjFYK0V6SmUyWDRLNEUvcndzb05jMkF3?=
 =?utf-8?B?UlFhQjU1aSsrZlhmOE1TS2VkazUwZWdsVmdBUEk1bDNrN2hhY2V1d2thYk1n?=
 =?utf-8?B?Y0R2anIrVHM3UzVJeHhpNkFwUTBJNitKa0NuRk4zZXgrQ1lYSkV1NmY0UlBq?=
 =?utf-8?B?OW16Nm0zTHNHU0NFNGQwNTFRWTV4Y2FDdWc2K2FmUENYMTdOUXVjblpNd3dN?=
 =?utf-8?B?ZnVjNEdwTWxaK2huTmlPbm9OYXQyRE5MOW5rS3c1NjJHczdaZGZUTDRQZWJs?=
 =?utf-8?B?eXJEVHZ4NjhrVE44WWozbWJXWVVLU0ZCUm1iRHVpTUVLUlRUSy8ra2xCc0hk?=
 =?utf-8?B?S2VPMjJXYTloTTVtNStuc000L1hwaGg2bVcrMjRnKzVXMXhBN3FLdjdzTmg2?=
 =?utf-8?B?SjZldSt3alY4eUt5R0dMS1VwSkczUnNxSWRLdFZ2dXFPQ0RoYUhCQjNDYU5V?=
 =?utf-8?B?YjlnN3JBd0lNSFozQVVVV3NTOWVKc2M2NFpSZEROanlzWUVRVVBrVUNjV2xR?=
 =?utf-8?B?RXJCQUVaUURDODdjM1dGZGZ3SFdzOWd4b3c4bXg1S2ljemJFV2NpYnRSM3JZ?=
 =?utf-8?B?U2tCRVY4YW4rRS9CaTBFczVIbTNlYzFzcWhYanJuTjZvR0tqK09yaDhvWmZm?=
 =?utf-8?B?MjJ1MGFkdy96RlViMzZJaGVEYUhGejNNNlpzK255NEdtNnk1VHI3VWw4cys5?=
 =?utf-8?B?bVRJOG8wazdJQ2hRWXB4R3UrbUs1eXdGczhVUHhxQTJwWURaRU80Nk95bGk4?=
 =?utf-8?B?QnB0NFI3NHhBUTN4NHJkeTdwQXgzaGtsTlQ0T0ErekRBZVNuekRHTDU5S2Nk?=
 =?utf-8?B?RU5xT0tPY0wzaDBXZTFlQU5peHpNNzluVEsybUtjdyt4WFM1TGtVVDhLVmYr?=
 =?utf-8?B?OG5sbjMrUGdpeW1KM1c2V2tMajFmUVZ2enFhaldMcWtXQ0lPZkU5N1JGS1c5?=
 =?utf-8?B?SnZ5dW11NnJheksyYWptQW1IWUh3cTlJamhFbVpVRW1FN3lpOVN3UzUySlJM?=
 =?utf-8?B?Q081YU8xNlVTRS9Cc3lBMGxucUZPTUJZZXdNK3FNQ29XM0VFVThDUnhZS1lj?=
 =?utf-8?Q?Y0hweofhN08d3qydNvyD5ghZfw0zQs6P?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGwrQlY2eC9vVHFGOHFqWVd4RWJYYVdUTk5MQ3ZlRFdFUVNoeEY3akpwYmV4?=
 =?utf-8?B?MHNqS2tUeDdpV2tRemR2SGdxeUdDcFUya1pTTWR6dXRSaDcxWHZ3c2lENTVp?=
 =?utf-8?B?YUI2L1pLUUhmL2NleXhRSmJmWExHUVF0a2RVUHluRklYWVJGanNMaGgzbUdt?=
 =?utf-8?B?SndrOTFkakxTUEZTODhwMUdPYS9RTWIva1lOWHVVMkFac3BJL2FzR2RQU1ZC?=
 =?utf-8?B?Yysxa2tmSkE4aEgxYVFlVDN0ZjN4ZHNRcE1sdHlTK3Rlc3lQMTlVdnBRMHFQ?=
 =?utf-8?B?UFhlTFBjcVljZ09DaU1zZGJ6cjBFdVExS0NsQzJGRzRrMFBtQVFPbkRTVmZq?=
 =?utf-8?B?QmlvUEswRWQ2WGFJVVp3TWtVdnZiaDlHWGNyTzREbnJLOTkxdjBZS292bTdE?=
 =?utf-8?B?QUpoSU1JYU43bjFvcWFoSDZVazIyTncyQWt6R3VxWUVGbloyWkZpaDFsNWpC?=
 =?utf-8?B?bkRZaEc2WVJ0UGF3ZmFETkR4Rzl5enNjUVkvMjBFTVNPdEp4QzNHeXBGUGNn?=
 =?utf-8?B?bzgyMEcyWDJhSDU4T2RzMkI1YUNKMmk1SXlVQXpJZHp6SWQwMW5xd2lpZ2M3?=
 =?utf-8?B?U3lXajlnWWFkeU1jdnB4cUtwemlXZXFCZlFnSHNlVFNDSVprOXJnMXBFWlJp?=
 =?utf-8?B?c2w1alRPWUw4U2N3RStIWHdnREZmcDA2bkJYaXFrNFovM0JTaHI0QUlEYUpn?=
 =?utf-8?B?cVczWDhDa3pmYWtyc3ZuUTZuKzcreUNqRVNNa24xVzVWdHVNOXhYYVFRM1NN?=
 =?utf-8?B?clVjSUtwYXhrT0hTbVRJTmc2VnJjbnBhOU5rM0lOdEFZaXluUWp5SWV6a0tZ?=
 =?utf-8?B?UXQ4UWtub1IrOW1BUjN5cUNCZlpwWkVRNFBMUzUybEJKMHZwM2Y1RnpzeFZ3?=
 =?utf-8?B?eGlKZ2l5eHp6YzhabWl6TlZEd3Q4WG1VZXJtRllwaU5TMTBKRFZ2QUI0ZWsx?=
 =?utf-8?B?WkFZaGQ4SXVRUmhFYzVFbStFSGVyd0N5dERwdXgzOTVkUDcrYmZQb1dnRzZ4?=
 =?utf-8?B?VWNqaFZIR1NkQ0xRQWJ3UVRDSEUxZDk2OERjQmUzcFBPaVUrTFpuaDdTbU10?=
 =?utf-8?B?dkdSTGxXYlJDZDhqcGJMNmszaFlQMTI4TkJMZk1PaXkxeDhSUk9JZlg3elY5?=
 =?utf-8?B?cExRU3AyUW0yUG1VUVRUT1NWbEFtU3RwSEZ3S0p3V1RYL2h3TTcwSFhzSkd6?=
 =?utf-8?B?bno0TkU5emlKMjA1U0N6YmdDYytXSGF5bHZjWFhTNkpmWm9kb01VNWJES00z?=
 =?utf-8?B?b1EzSG5EUXV3MnBEclRiRElVVGViSnhianZ6RDVlcFlSL3RYNTFNaSt2RVBQ?=
 =?utf-8?B?UWxrT2l2MnF0V1kxMDBlbGdFWmx5SDhmeXBrWUd0NXdtL09aV0lMdytFSXZK?=
 =?utf-8?B?MElCcDRDaUcra1Y2Tml4Q3VIZjJ5bjhVTm0yY0ZHQTdXdUh3THdjZzIwK3M5?=
 =?utf-8?B?bEh6ZzZkRFV1TjVoREpTeEpQYnhFcElRcGVBeDB6ZS92OU42dTgvTXRsMm05?=
 =?utf-8?B?K1hBRmRiNHNCVXhvWm1Zd2J1YjhMR3ZPdkN4RmpySVM2VCsxVVdaZGIrRG9V?=
 =?utf-8?B?dzBlcU1Ud2tzU2dBSHlJeU1hc2RhMU4xN3dFY1ZXTVhlL0VGaGZCU2ZnTFdo?=
 =?utf-8?B?TjNRcGVzT1J3ZTJPS1Y0ZXVUNk9USEtQcHdhcDJLN1FCb3UrbUF6VitteTFV?=
 =?utf-8?B?Q3BCbjdTbnMweWV5V201UUNuQ3NUaE1CRGlpeHZiSjlXWFBXZm5qbXpzYUY0?=
 =?utf-8?B?bTlaOXNIV2MySmVLR2w5SEFTYTJITDl2UWxlQ2t0ckZ2QkV2RHZodUtFMDdB?=
 =?utf-8?B?b28zdGhxQld2NUM4NFk1K051aWp0dDRUZUxhaTJESjB4alFnSTJzYnB2T3NV?=
 =?utf-8?B?RkhIRGNCM0hvWVNhSzhXalZONU9FRzJWTVZ1eUk5UVVrRXNuc1FEZnZlc0wx?=
 =?utf-8?B?MDdqeGNaNzFWcjExTWp1SVVzWm1rZEh4aElSb2RHV3luWVdGTUpjdjdncity?=
 =?utf-8?B?V2puYklJdUpzMHhlNE0zb2QrRTF5eXB5eHI0OWpxV3Q5Y05qdTNrczc4QXJn?=
 =?utf-8?B?ZTVsOVQrNmU2Zm1rV1N0dENWQzFHRDlMdTQ4N3hWRS9EejVUNkxZVWxRUG5o?=
 =?utf-8?Q?2mTXwzNLLpQVGCyg0M06XSLQ4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee977da-db54-49b0-07d3-08de3cc6c5bc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 17:15:55.3615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1m/3OGQqPc2U9e/LwdJLQ5sLs6SANznq4w8hdffObDs5EZp2FffIG1L2I3466vYlYQyXv1Jzw6Q6v5W5OmhM+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
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

Hi Alex,

Timur told me that he has not received feedback he needed to work on V2 
last week so I rebased this series and sent it to our promotion test 
this week while he waits.

If this series passes promotion before V2 is possible, we can apply this 
series first.

Cheers,

On 12/16/25 08:27, Alex Deucher wrote:
> On Fri, Dec 5, 2025 at 9:49 PM Timur Kristóf <timur.kristof@gmail.com> wrote:
>>
>> Fix a few issues with the initial DC analog connector
>> implementation that I've noticed since. I highly recommend
>> to backport this series to kernel versions that include
>> the DC analog series.
> 
> Did you have an update for this series, or are they ready to be applied?
> 
> Alex
> 
>>
>> Timur Kristóf (5):
>>    drm/amd/display: Pass proper DAC encoder ID to VBIOS
>>    drm/amd/display: Correct color depth for SelectCRTC_Source
>>    drm/amd/display: Add missing encoder setup to DACnEncoderControl
>>    drm/amd/display: Setup DAC encoder before using it
>>    drm/amd/display: Don't repeat DAC load detection
>>
>>   .../gpu/drm/amd/display/dc/bios/bios_parser.c |  4 +-
>>   .../drm/amd/display/dc/bios/command_table.c   | 44 +++++++++++++++----
>>   .../drm/amd/display/dc/bios/command_table.h   |  4 +-
>>   .../drm/amd/display/dc/dce/dce_link_encoder.c |  2 +
>>   .../amd/display/dc/dce/dce_stream_encoder.c   | 25 ++++++++++-
>>   .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 28 +-----------
>>   .../drm/amd/display/dc/inc/hw/link_encoder.h  |  2 +
>>   .../amd/display/dc/inc/hw/stream_encoder.h    |  4 ++
>>   .../amd/display/dc/link/hwss/link_hwss_dio.c  |  4 ++
>>   .../drm/amd/display/dc/link/link_detection.c  |  7 ++-
>>   .../drm/amd/display/dc/link/link_factory.c    | 10 ++---
>>   .../dc/resource/dce110/dce110_resource.c      |  2 +
>>   .../amd/display/include/bios_parser_types.h   |  2 +-
>>   13 files changed, 87 insertions(+), 51 deletions(-)
>>
>> --
>> 2.52.0
>>

