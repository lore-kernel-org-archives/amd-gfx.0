Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43AACA1016
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 17:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44AAB10E58F;
	Mon,  8 Sep 2025 17:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="htZ0Du02";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2152910E58F
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 17:38:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNoYgJZCkrC5/a+6G8EmY8GHb0hNVpQjmUuDY0XTDbw2lrw7dbwALkw4EcRJY1lr7ToivtsCqAUhCv29h0kJi/IDWYex7SZpkyQ2lq5TwVHYwkLRis0S5edVFancG+OhvLEz8ecuo6cdYitWldA1at8preMBQ0obKY6tjIezGyGrb85Lu+JXjPuoLmmT69MYFdnTo5UWwQe/QNP0JPKvGbpBJgRvr4F2lLTo1GEyGu7ihlfI3szv5fsxDdqDZOaus96855RdptJjT4uYZMFAiHzxhB8Ejnu8l6+F47TqT6Z+lbwFVHAtmqur18o5HG9mpuZ9LLkYVWYsh0594oemIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+lgsVavChiLGUMlQSDJYyRHZkO1eS8vOjEMBdhZi9M=;
 b=f2uqlzKoW7rO2ypSHDthvtP5SH9GOpsyES4nhcpW+uPdGrssz49tWSD4yo7Bef5OamZq0GGcEkh129kVcQjwu+vwIllj8xohu2bP3mf/g9UFIri77M/l49KlUFh/4408aGshib+MuvCBcjsMZZMUhq3AmwrbLWf3JkrqMmZHenPMe+ufGirAdkTyjECrB9YHFqw7Hp44LBFCo6LXbX8cikPVbku+9HZ54rBzAn8+J9Y5jKPWP+MPSMJOvgFQ6XSbdvzbgZKTJOmLfH0Ay68YDmZaLUQ3W5gXAe6gHkaLyPEd3NISzmGSY57GVmHgaSPKs8gP3CT6AcU1kKDS+738zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+lgsVavChiLGUMlQSDJYyRHZkO1eS8vOjEMBdhZi9M=;
 b=htZ0Du02B1kgom/UXvFnlhytWYS/0W8IO70ET8+LEM7IAiJWt9foE/lWQEcXljk3yRuvXBSMRPCnVa2sVxWT6DNDChobvSEBqZkwu3azWeUtyOxQSuGp1hs+c3kx27Sepj88Af0/GW7NLqNN8dNBnvywiXI19dVyNiAcZTNQ9Jg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SJ5PPF3487F9737.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::990) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 17:38:01 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%6]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 17:38:01 +0000
Message-ID: <3a20a13a-fdea-49fb-a60c-b7a10d46ebc6@amd.com>
Date: Mon, 8 Sep 2025 11:37:59 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] DC: Fix page flip timeouts on DCE 6 (v2)
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, alexhung@amd.com
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 harry.wentland@amd.com
References: <20250825215631.628949-1-timur.kristof@gmail.com>
 <CADnq5_MjEuHz89Mv-_n5BoE4GMWD_PweLEwb=nydO1KdioPG2w@mail.gmail.com>
 <CADnq5_N3AA+etH6_v8a8CZbvBeRsZVNWvAUOLcWMATfuR=6wRw@mail.gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <CADnq5_N3AA+etH6_v8a8CZbvBeRsZVNWvAUOLcWMATfuR=6wRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:303:b4::34) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SJ5PPF3487F9737:EE_
X-MS-Office365-Filtering-Correlation-Id: 194a775d-b4be-4181-457d-08ddeefe752e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZG5KQmZFN1ArSmRtZnF5LzFTb2NLREEvLzB4dHZDeURNYS9kaFVhSGZxQzVa?=
 =?utf-8?B?SWVVNG44aVN2OE94Y3BxQXcwU2xQVE1XNVhiL3YrdFc3UjBKSUtsajNISHZk?=
 =?utf-8?B?VUpydUlMZG9rWVV3NFQ4Y1RTQTM0OFBnVGljcFRZK2JaR0NvZC9NYW5ubGs4?=
 =?utf-8?B?T2dzNnBqOEZERGw5TVg5TDBHcDNuQm15MExodkEwU2h6R2kvN2hjeG42TTF0?=
 =?utf-8?B?angwYmJsdmVPSmFhMXBWdmo3MGdCUHdyRVd6TmRlV0RuS1FNWFlQWDhyS3dh?=
 =?utf-8?B?S1VDTjJVWmo2elZQVmpvSDVMTzcwYU81M1N4UTJYRFdNSlExUGFWS1lWRWtX?=
 =?utf-8?B?TXBSK1JGSjVkSTNzdzFrSE5mOVJxcFBlc1VtMUlKNVYyaXRKOTlhbXF3R2la?=
 =?utf-8?B?V3JxdTV6dGRVREcvb1crZTl0OFpPV1czUWprbm5ubllMOUIvdlNIL3R6dk5l?=
 =?utf-8?B?VzE2MEorVGRDaWtDdHV0eS8xa0FFckkrVWdwYzhsbFQ3dFUzUWNnam9YN2l4?=
 =?utf-8?B?VVlySDZ6aVc0Mmc0R3dxSTRaTGFMRG9uNzQyaDYxemY3L0FVZHAwTERVODBq?=
 =?utf-8?B?KzlLM0dLaWRXNG8xUEgyb3dPRVhvRXE1Mlo0SXUyUkFDcGtrRU9Vbk85U3ZY?=
 =?utf-8?B?aGkzYUFid3c0bHNWb0NsNHJxc3lQUEcrL2RjUW9VMVpsbHMxdmtwVXlMOWFB?=
 =?utf-8?B?eUxGNy9DMlNjZFpaRWp4Q011MjJLSHZaSEdXaEN4SGNrRlFTYmY5akpSckJH?=
 =?utf-8?B?K2UrenZqcDVpVTJtTjk3czlsaWV3OTdYTDltaThRdFlrNmlPNXFlTUJ6N2Jq?=
 =?utf-8?B?U2RNSG9CV3o5c3RkU3hKU1N3N2QrZkJGaUd6c0lKbUJTS3JLemkyVU1XOEh2?=
 =?utf-8?B?dUVJMmNnK1JaSVJqN0R5Q1RZYXZlS2NVWlJxVms3eGV6MGhuNjY3QXVrSGh6?=
 =?utf-8?B?M3VmQ0xTVmdUWWIzMzRpUCtRWml4SmdMdGxPWWxyeWlFQTBpeTVlZUFqM1BW?=
 =?utf-8?B?QlZSckV3N1hCb2REbGd1YllNZk9NZEdnVkVvZlY1TktDaE5FNnJLaS9HQyt3?=
 =?utf-8?B?YUtJN0JISndtcGgwckNDTGxnbWplQlpVR2E0U0FuVXR4dTlZNnBmamFBMVhP?=
 =?utf-8?B?dXlTRTZIeENpNW9EWE5mRk5jZUx0cUtCOCt2UmZ1djd4NVpNSldFM2xqQU1z?=
 =?utf-8?B?QmM4MDRrNHFlaEUxa0ljVEZ4TXQyTWxQV05iVFVURVRrV3BVejVMeWtxbDZB?=
 =?utf-8?B?SnF6OTJYMUZ2UGZtcHl2SnFwbVRKQXhuZmxOMmRvRmNtMnBUZ2c4eVRvb29B?=
 =?utf-8?B?QWM5S09QU1g0c0ZOdVJEMHBBT2E0QVdCRnZFNlkrZXNwaThnYjJPN0E1cE5z?=
 =?utf-8?B?UmRPSXk0aGplNElTMVpOdXRXQmRpOFNXUDZQTWxKbE8ycXp2QVJ1b05jYzNi?=
 =?utf-8?B?SWZaQW1FWjRNb2ljcDNmR0hlSU5XTFlnSHFXUEIrenp5OVRiSUR5Z045SmFT?=
 =?utf-8?B?NmtUSnlUNXdoMkMycUxNdGdWQVRmamR2MkZrelFvcEpWUUM1QTEzSzVYelFE?=
 =?utf-8?B?WnplTDZJZWZSRmNXY1JNQlVpdkxuOUdYSHNMd1F3MXNzUlF3TzFzY0pDMEV4?=
 =?utf-8?B?WWtOazFaUXcyK3dwdGtpOGROQllXeWcwT2M3a1hnc092alJ2SkxjdXVla0tG?=
 =?utf-8?B?UUNKdVIwbkQwcERZZkhQSVgvQVdmdVJjWUxhekNzS3c5eTAzL1U4MlBOMlha?=
 =?utf-8?B?d3dRQ0NFa2t5SFE0STQ3YmsxUGR3aXJVRVdRT0pnWTc4TG5JNGZheUVkR1JK?=
 =?utf-8?B?K0cyaUxlRlFWcno2dlRjMFZEaVluMTk2TFgwWlRzbUhHNCt0S1NrbWNFMmtU?=
 =?utf-8?B?bXpUQWdmVkJNOVBYQm9SZ3R6L3lOZURXTVlkbi8wVTdqYnF6ckZHMzhrS3pT?=
 =?utf-8?Q?SH9L1c52+9g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDZMNmpvVHhKakdaMnVranpYeGhpU0pXZzdJK1h6RDUweDRtYjNhVmZXOWQr?=
 =?utf-8?B?S2FOUGNqMWxFVkNRNXdWL1B2RUZMYWZyekxaNWQ5QzlIVFRzOVFibk5wQVYz?=
 =?utf-8?B?bDcyUVNyU0wrNnJYWDF6VnFtQnVIbVhKckJlaUVjMzlDR2xHbEFrL0pUYytB?=
 =?utf-8?B?OFl3KzNqZmFPSU94dEFyd3BsYkxZditFSEJRcTZjZ3NyWlUxR1E4Qm9pRSto?=
 =?utf-8?B?UU95a2x4dVREeUlQdW5ubnVzM1Iwcy93NnZTK3dYY0hRbjl4cldYRHlHcWtH?=
 =?utf-8?B?cDRDQVVzR1RaZEdvTVJMb296cVlLSXRrekxodUVvSTNlaDR3MzF4K1Z1ZW9t?=
 =?utf-8?B?dEVxSlRQR3cyTjVraVIvdE9wSERyZmZmVXFTNEhXanloQmIwQW5DSHVGeElE?=
 =?utf-8?B?ZCtBcjFCM1AxdGRpRmo2STdlTHNtNERFdFQxYzNmWXJEWGVFb2FkWEpFY3lV?=
 =?utf-8?B?TlZLNkNVbmpocFZBb0VycE01V01YUXVCRXpXaDhlV3dEV21YTTIvL1JvQzNr?=
 =?utf-8?B?Nm5sZk1pMWlFUzdWdUxwZGJIN0k1Wnc4bitZWUEyVFlWL3U4bW5UMFZCMHdq?=
 =?utf-8?B?YVpLOGhwenBmbjVHZWE1M0ZFUzQ4UE5UZzliejBSeVQ1amE4dDFocXFmVmZG?=
 =?utf-8?B?bHlyVGFKOHZtekNxZTd6MUtYQ24veDB6Rm5IOG5zU0kyMjl4U094R2QxaERI?=
 =?utf-8?B?MVM0VVNEazNiWFphVWRlN09YTVc2dDlCQ1Q1YU5Va1pPdFd6WFRsWTU0Rmpv?=
 =?utf-8?B?SEtQRjl2dHVBS0l3RVoyNTBDWU1zRFVzTHV0MWRjVG9CcHJRbStweWF4SEdv?=
 =?utf-8?B?bHpBd2FHY2RDblJjZW1nU1Z2RUhYOXMzSzZYazRGSnZwTW9yNnM2YzVjakhI?=
 =?utf-8?B?ZnBjRXR5MGlBc3FvTHNZeDhZcnFmcjk1emFPR1J1Q0xkR2hjUDJTcUtQY1ND?=
 =?utf-8?B?SDFzcWdRVjlFYnhSc1RnOTRieDRHZ3RNRkhIcTRYOTlGdXlSRk9JZW1NS3lM?=
 =?utf-8?B?Vzc4UUI2c3loTmkyb2NySElzdEpYZlFKbTl0UXFreDZ6UkZNOUxXWmtPdXQ1?=
 =?utf-8?B?MWp5cmM0NHlycXVzWC8rZmxrNkcvUFVxV1M0ZFl1Ym5uc1JQWjdrZzd3MUJS?=
 =?utf-8?B?aEhKS1lvSTg0WVhORlM4eUc3eC82YTRIVTFrblh0dkJQWTgzeDVaOWp4cEND?=
 =?utf-8?B?aGtuenIvU2o4M0JoVEd6cUhaQkZzNXE1UDBvWVN1S0gxVmFaclp1SnJtQkpY?=
 =?utf-8?B?MHZ5VGJUUjlqd1lZTVNsYjFaVW9JbjNQWEN6czlNVUI0OGlKVkh6WVhuRFdj?=
 =?utf-8?B?R1AxbW8xMi92Z01FK1lwRGYzekRwclhjRUx0a1RVMkFZUHZlMkgrOWU2TVlo?=
 =?utf-8?B?Q2RsK20zaUo4elFReHFRWlpoTGFEcXRiYno5NU8rM1Y1L1JLbVExei9zWjNt?=
 =?utf-8?B?U3RXaDNYRzV0RUpwSTR0K0xMaGhud3hKRWpMVk1zeSt2RlVlZTFRMVM2cDVH?=
 =?utf-8?B?UEduWE80RisxWjVOdGJMT2hUa2I4SURxVmI4dmhrZGtObGlHYUpqTkJSNlkr?=
 =?utf-8?B?Y09DeFNSU0NNSGpNeCt6L3dURk5UL2g1TDdnWDJmSENpRVdPM1BuZHgyZURu?=
 =?utf-8?B?ZFJhTXJWelk1a2JqQXROTmVyMGdvRG9LSi84bkRCVEgxNTdjT1hKOERiKzFK?=
 =?utf-8?B?RU5QOVB2V2F1OVJRbUovUytVSGtjMEJ5ZFljN3FRVk1lN3Q3czZ5LzI4WGZ5?=
 =?utf-8?B?U2lneGdBL2RHVTUvTlIzOCtZUWtKTEdaNXNsbGNsTjBYOEdYbVVLcGZJOXE0?=
 =?utf-8?B?aEtoTDY4cVZTTXh3cm9sYUEzbXBBdEMrdFlQNVlmNFltRTQxeE1mek1IYlFx?=
 =?utf-8?B?WUkvNU5nSXJLZGt0b29xTmsvZXBJZ1hVZ0M2Z1R3TFBkYndwRFdpZ1pyL3Qx?=
 =?utf-8?B?U1pmVG1Sdk1FMHIwcHBrdGM4VjhpcitwN2hkWFdrdE5UQkxtRUlQYjQ2ZzA2?=
 =?utf-8?B?bElFVjROMk1mREZ3cUNiWUJHdEpVYk0yUkx3ZTBFS1NtSmlSb21CbzJCSEVU?=
 =?utf-8?B?Z1JaeWtUTFdtQ2VJaEJQaVUvTUpVL1RhMlJ1OHQ1MEZMWWNieXU4TzlUWTFv?=
 =?utf-8?Q?p7NNSEajA1ftEz467MxLSfPjc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194a775d-b4be-4181-457d-08ddeefe752e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 17:38:01.4492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMo34hOujGjr2pqe+1tx72NOttso6nYH+0DX6VXRmeS3zjJ+m9FTMGC5V8meO98WGqiWlA6ndzFwUZMcFPXelg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3487F9737
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



On 9/2/25 07:59, Alex Deucher wrote:
> On Tue, Aug 26, 2025 at 10:23 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> On Mon, Aug 25, 2025 at 5:56 PM Timur Kristóf <timur.kristof@gmail.com> wrote:
>>>
>>> Compared to the previous version of this series, v2 fixes
>>> the rebase conflicts on amd-staging-drm-next and includes
>>> an additional patch to address page flip timeouts when the
>>> displays are blanked.
>>>
>>> Currently when using DC on DCE 6, it produces pageflip timeouts:
>>>
>>> 1. When displays are blanked
>>> This is caused by (mistakenly) turning off the display engine
>>> clock on DCE 6.0 and 6.4 which is also the DP clock.
>>>
>>> 2. After suspend/resume
>>> The root cause is that DC assumes that the VUPDATE interrupt
>>> is always present, when in fact it isn't supported by DCE 6,
>>> which also doesn't support VRR.
>>>
>>> Finally, there is also a patch to disable fast boot mode
>>> on DCE 6. The rationale is that this already didn't work
>>> on DCE 8, and even if it did I have no means to test it.
>>>
>>> Timur Kristóf (4):
>>>    drm/amd/display: Keep PLL0 running on DCE 6.0 and 6.4 (v2)
>>>    drm/amd/display: Disable fastboot on DCE 6 too
>>>    drm/amd/display: Disable VRR on DCE 6
>>>    drm/amd/display: Don't use non-registered VUPDATE on DCE 6 (v2)
>>
>> Series is:
>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> 
> @alexhung@amd.com
> Were you planning to include this series in an upcoming DC promotion
> or should I pick it up?

I will send them to weekly DC promotion.

Thanks.

> 
> Thanks,
> 
> Alex
> 
>>
>>>
>>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 ++++++++++++-------
>>>   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 16 +++++++-----
>>>   drivers/gpu/drm/amd/display/dc/dc_helper.c    |  5 ++++
>>>   drivers/gpu/drm/amd/display/dc/dm_services.h  |  2 ++
>>>   .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  6 ++---
>>>   .../dc/resource/dce60/dce60_resource.c        | 11 +++++++-
>>>   6 files changed, 46 insertions(+), 20 deletions(-)
>>>
>>> --
>>> 2.50.1
>>>

