Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE156CAC597
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 17:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3144E10E079;
	Mon, 15 Sep 2025 17:42:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3NRTS+gA";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011055.outbound.protection.outlook.com
 [40.93.194.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FB8110E079
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 17:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKVUCZ5EeTFT0ZtGtE1F1tphagn7UPYjmMV/u2a+a20SoBRdswRchBKRRAuL/tMum53AmgO62Hqz+/t3VG7hUeB/hNQU0+KSUif+injr8AHZ+srDI+CR8QsZdS18IeEDxCMXq9+M2v1kAlhFHJD/DCviJAJBvOPV+r3AMa2zbMWHRBL2dV/vTsPyUI/6aB/QTBu15DGV5czMcrwvsTbuZYH5fZbG0F/trXpotO4LluaMRcqBGCOD2kUjyxpKYJGPpVMTLrZdLLePblZ0zAZ0TnEVFvMcxkSfSRp4BqtYqciI3i006vO0YCiCg9TFUeNyqwL25JgGvPmADdFTSOm8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrfSEtnaulrPM+Eif2TGjb2zo5KNte99ILyVw/q8NwM=;
 b=oqt1rgpP+xOHM4joQIeg/37s1mXWX3FBfmCKcMQpwCD3Npw/4J4qb1tG5xcxhUMe5XLUhfSHN2XSv6iWqp9EMbRSxnfZHyUiQO16YqZTbeKIZoGD3ckMEdz5hWIutTEoyPPKplvcRbhwnVG0eD5LH8CiHx3yUNpLNcAeCF4a9tFRmOhHQaSaI+XAgIHLaWPczwKHheIxY4w8ESfIS3R3+hvtGYCkFgekHLDgbIse+3+jfGFbsZE0pYUux+KiFP8v9jZQ1VhOODHISDJs6CzUcxt9f3/OBcMqBl6p53frsFf+8Ux494+EF1Yw+GNx/QQhuBuRe3P9pkyXhcKeRsd6rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrfSEtnaulrPM+Eif2TGjb2zo5KNte99ILyVw/q8NwM=;
 b=3NRTS+gAms2Ax3POJOpIp3WH1TDDzMjvRAk16Oe8TJftfrDah01+MpR/Vc1xCnj2ysmwOcF1ZsbIJQ82DGs1hLewRC2TBe3HmqbUPldb8cu33CeT0XNMzGdMjj5LV4YAXW6qarq3tXgA5+YgrRF1zmTz49CSOim+4wAH9/bIS5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7927.namprd12.prod.outlook.com (2603:10b6:8:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 17:42:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 17:42:39 +0000
Message-ID: <db009733-c429-4e4b-8044-4ea5c38d0688@amd.com>
Date: Mon, 15 Sep 2025 19:42:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: set an error on all fences from a bad
 context
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250915133356.3547174-1-alexander.deucher@amd.com>
 <70e8c427-f816-4bdb-8f92-9382cd5ab13a@amd.com>
 <CADnq5_PUzTPcAchWfQGzsBc_SgY6E11B5aHMv8472NMoGPz48A@mail.gmail.com>
 <e5546919-aca4-4f8c-be0f-0895f3eb28ee@amd.com>
 <CADnq5_N5hwm4BMiBGGBrEtkhg65y46jgtPP_69MxaxsQs9wOoQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_N5hwm4BMiBGGBrEtkhg65y46jgtPP_69MxaxsQs9wOoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0340.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: a7bd9413-7958-4691-1a58-08ddf47f437d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yjd1MzN2U0dBYk5FbUZGQ1VWRVp4SURVQ0d0NnVBUUt4TS9ZQk14Q3duU3lP?=
 =?utf-8?B?b3BkL1NEbk1oWUM5UUEwcjYwbCt6eDBzamVZY0IzMnlaZldXV2VFOTlHcU4y?=
 =?utf-8?B?d0NmVmd4R3VPMklTQ21tTUs5cGQ4WnRoZGlJUis0YTkzTElqWVlhQ0huQjhG?=
 =?utf-8?B?SUVjMzFGK2ZwdDlmNDdmcUQrMkxmeWZLZHY1a2hCZzNyUm1Ud3Nqc0RPMThS?=
 =?utf-8?B?c3UzSjB1Q0xvd0dyQmYvZ2ZPeG9DWXYzSG9VZ3psenp2QzdvZmxZckJ3NWlH?=
 =?utf-8?B?MGRsUFZmYmthMHlVODM2bnB1c2U1NDBDcXQ1a0loRGpadzhxTmxKaVNTOTF6?=
 =?utf-8?B?L0pBaE5qT0xKWVk0TGk0YkVZTEIyZm9tcnlOZU1YUFlXY21uZTdXT3ovOVh2?=
 =?utf-8?B?UnptM2QrMEh4WTA3Zy9JMmk4Ty9ERXV6OHlPYWV0M3lBZWw4bVFnd29vT2Yx?=
 =?utf-8?B?MEZGaW1mNE1wc0NLTml4SkFWM1lkV1dOTnZZMUk3NmlmM0k2dlNTOGFBUTFX?=
 =?utf-8?B?RENzSGQ3bnJCV0dZNUlzaWVSWkZqdGx2L0xGc3RzeUkvcEJLRTJNUnFTU215?=
 =?utf-8?B?VWZEQ1VnbjZRRnN4Q01JTFg4bDVycDQzYWpHdEVQYUk0eEZsZFBPcnRKV2pU?=
 =?utf-8?B?KzdvdEo1RXl0R0IxNUpLSE9qcVIvK1pabXN4Tk8xVTVTc1AraE5nTGdYajRG?=
 =?utf-8?B?aHZiVXh3OXlQNGRvVFNyMnJRZHZrMFlUL2NPUUJnTE1qMld3OXNRY2xHaXhB?=
 =?utf-8?B?Z3BqV0ptSXdhSGpWdU83NHE0Nlh6ZFZwTmR6TDJxc0tPUXE4bzVGZWppcHVh?=
 =?utf-8?B?SjVxYmdjcjFHSHZIQWRZNy9DT0N1dFVXVndVeXhueXNlRWsyclNKQ0RkRSs1?=
 =?utf-8?B?bm5rSTdWeFJvMjJwNkZYTFNMT3ZITDZta2N0dk1TeGtDWFlKSlhFRGs3NFoy?=
 =?utf-8?B?OFRIdmIxQkRCNGhSdEZWdWFGTFBaNmlWZmFxeENHa0V2b3U2WTByWGRLT2tE?=
 =?utf-8?B?NzZjVGRHa0RCMTBYZGhoZUJqcDVlZ0VncHNjSjlyTDJzMWZMMmNUb0R3TytJ?=
 =?utf-8?B?eTlyS3kwTU1kVVFXYnRvVFo5bHFYNENjbElkZHJhaXE3ZG12clJxbXZjYUZO?=
 =?utf-8?B?dTNhdGY5TmhHazl0TmVJZ2VkdmlnaGNZV2VLQnJGcCswN0xWQll6NmNNKytS?=
 =?utf-8?B?RU9kenV0NlA3U0pCTVZWL3BYVlJZa3U0ZU5La3ZNQ1JDa3RjTHlGYStSdVpU?=
 =?utf-8?B?cFFTN3UvaXorYU1RTWFGeHB4bGxvNnJGUC9KaTEybWtZUGFDWnpZQ1pzL1N2?=
 =?utf-8?B?Ukd3OHFFSStXalhMWWtZWTIvcVRuTnlnWVN1YnIxdU1sdE42NUduaDBxdFpK?=
 =?utf-8?B?eFR1S0dMSEZXODJ5VVdxcVp3Yko0SmlWL0djR2VSME4yU2ZxcWZtZDdXZW5r?=
 =?utf-8?B?ZkJTbGpFNzlIU0RVS2ZXa0hBbVQyWTJOR0pTMGk1QXpVUXJYR2pwVVdIa3Vs?=
 =?utf-8?B?RVlvVjhEVWtXWEx1N25FaURDMHkxREk0Q2RORUJCODRnaXFFaWdCR1FBQ1pp?=
 =?utf-8?B?dUN5eWVOTzZBOGVrczUzQXBpZWtta3FRb242UlpkMWlmUE9mNWJhM2JUenpo?=
 =?utf-8?B?SXMvdm9ZRmcrWkZDVlY2OVIySmFTS2RRck9mRHZKcTVtM1I2bzN3ZGtQTlhE?=
 =?utf-8?B?QUJpOXUrOTBmMFo5N0lHVFBzMVR4K1lFZlFmeFRZVHNTb20wd0M2NUpaWU5h?=
 =?utf-8?B?OWdDMUI1b29rYWVrOVpLcmVOZkhzY3JaRlM3NHNUM3lJLzVSVkt2VGNDZ2M3?=
 =?utf-8?B?bUhOakl3SVBFUTVHSXdPdWRuU1hycWdwOEM5MUc2eTVaVytLUFJBVE91WkEr?=
 =?utf-8?B?d2l4SHFCemYwYUdZemM5dW1kbjMvOVNwVXd3RGpXVThkeUFoM28ySlNYYkpF?=
 =?utf-8?Q?8MbAqRqpESc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wnh2VTNFM1BoNFRxNFJXRGprNnJ2QUp5ZXlvT3FOeUpNTC9EQ09zdEZXVGNy?=
 =?utf-8?B?RXpvKzJGODB0enpiL3BrWjZCUDJiL05MNE9lZDRXSTBLTzUrblpVOXp6Wlcx?=
 =?utf-8?B?dDk0d2JkZW02Umc5THpMZG5WNHlRZDYxcHNlMENQWGp0amdGNzl1Ny8vYVpL?=
 =?utf-8?B?S0srMExFRm94UGZlNlVrbm9aZmdVRlloNDJGbDBvWk5lRTZZL3JtMDM4dklW?=
 =?utf-8?B?cWJQUEtFb0lKV2xxVWc0RVJlWGloODdndjlyZkdnWFJ5cFk4YnpuWUtiVFJX?=
 =?utf-8?B?dEFPNmt4cmtVVDJDZnhqNVpPS085anNwMWNBSDIxZTUvd0h6bGxLT1oraDdn?=
 =?utf-8?B?Z3dhNk1JWVN1SG1FSGhFRlc0MjNCWkJ5NlNET3FYV004WVNqc0x6aWJyUy9M?=
 =?utf-8?B?R01XcXUrSGxaZ1ptVExvcXk2V0ppVXg1ZDEvcUp3QUVvZWZBZjE1MCtCSUZs?=
 =?utf-8?B?WnRJZ0xUa04zZ1JZR0FpZG55ZjlycEpTS1ZjTkhZNFA0TmtnOTl2WVdWbkZ2?=
 =?utf-8?B?Qk1HTkszMmZoanZlS0VrbWU4V3MyTmNxR0JPMmxGUVA5MDJMNjZhZ3UvOU5o?=
 =?utf-8?B?ZVdnNGppMGFwQjBPTHNGd0xWUE1rUEthRElnckFXMTlaU2M5c3pJbmtpR3RL?=
 =?utf-8?B?cVREQnpUVXoySVYxcFEwUzFsclZoVFprVVhuN2l6TXB6QlZmbUt2VFZNcTFF?=
 =?utf-8?B?QUR1TUlQblJ6akcyUTJTL3FmQVZCOWRBaHgxQVkrVjk0eENGenViUkZ0QldX?=
 =?utf-8?B?NFZ0WHk2d0ZuVTllcXNRWTJxajUwNERNZXlIMjhuSHIxUGNReFMvVGNnWUF3?=
 =?utf-8?B?TTV2cGdLdnczeUh6Z1RjcThYUThlVnBMR2xJdjY2T0JQT01CVjZHNVRSelVu?=
 =?utf-8?B?Nmxmemd2N29jUlRyZHBHSHFTWDEzbE5FakVKZHBjWXUvaUp1SEJSY1RBei9R?=
 =?utf-8?B?MkJsZW5RejRUcEJnUjVkSll4VW9aeFFWckdzdzI1VWgvZ0cwZDkwai9yNVdM?=
 =?utf-8?B?R3IzWDBTNGRQZ0VuOVIyQ25DZGxaUkozR3BYc2d3eTNoaGNDc3JNWi84MG1o?=
 =?utf-8?B?ZTlYWTlvSS9FdGpZNWV6cUl4cU9tL05QYXljSVh6NkljZ0FMbUs0ZkpCSlNX?=
 =?utf-8?B?MC80cGhvMm9tZTZHUFNZNW9SazZsd0p3MWlBelFmUmVtYktkSlB4Wm1xdTd2?=
 =?utf-8?B?c3IralVTeEdLNTRkbTU5aHV6c0RDK2xXZ0VQcjVNYjJiY0JRekFzWEttUE0x?=
 =?utf-8?B?eEwyRTAyczhORjFFK0pTTFZFOTdNR3kwa2twaTlyc2RPU3Q2bWhyOVJoK0c4?=
 =?utf-8?B?RDJLNllGdXpDOWoydEsvaUFBczdPbVhNQVp2TGFIUS8zMzQ1UGsveUtOeksr?=
 =?utf-8?B?SUdlbmdvMEJLeEF1MFVtTVlHZmp6d3RzakFFblRvbk1UR0hKL2xhZElNRHh2?=
 =?utf-8?B?NXhMdThJQnRLQ2IyZCsyRkwrek55SzhXcGtCNWxBRURUTHNZRUZGZHVWelpV?=
 =?utf-8?B?bWFyS001VE5rTUFzclFPM2d6R21ueGlhbUtNU3VYRVlRMkNHVU5Md2MxMSt2?=
 =?utf-8?B?VzgwUXlRM1NISi9Zci9jNnJNUGpYbUsyeU9KTjJUY1V0dDJLWjJPbE1IOXdl?=
 =?utf-8?B?SWw2T21SemZodDRjKzBOMGF2L3Z5ODhXOVd0TGxEVGpMQlRKSFQvczBTWG9V?=
 =?utf-8?B?VmZQN2toK0tGZFpLclhCTDMxejB6dDVLNDdidlB6VGlEL0xvWGFQOFMraUk2?=
 =?utf-8?B?VnY3V1M5NUhQWkcrSXpNWE0vWm85aVFDcElXZTZzUEprRlBEenBmSXljZ0Nl?=
 =?utf-8?B?bDRIT3dTRCtSVlVzWnYxZzFQYnpMVGhWdkZzU1c0WG8rMFUveDlVdzNjZDY2?=
 =?utf-8?B?RFV5Ty9OUFdHOEpiU3N5OE4zNmhjSm00UkxRc0JaOTNETTZ4N2s4REJoL3Fh?=
 =?utf-8?B?S2p3Q2lBTis2QW9nNW44c1hSNUNUV0JRN255WUF0U0RKTWl6d0MwOXRBeU15?=
 =?utf-8?B?eVEwSnZmaE43UHFFejl3c0VwdDIzTVVkWEhiY3VpR2pYa0NDQ3hOcUdEczVJ?=
 =?utf-8?B?NDNjbU1VT3prb3krYzhXcU5vTWVyK3o5ZHlOK3FWQ1p6dVg5L1k4SXJOMmpu?=
 =?utf-8?Q?LmS+gYPv5J3Pz47qlCwi208SG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bd9413-7958-4691-1a58-08ddf47f437d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 17:42:38.9465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGRPExsf3pp6KQXSddfTKxb0CwP7h+RgZZTNX8rwwAStE51Rwid8W5DpuSh/a7tq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7927
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

On 15.09.25 19:09, Alex Deucher wrote:
> On Mon, Sep 15, 2025 at 10:32 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 15.09.25 16:24, Alex Deucher wrote:
>>> On Mon, Sep 15, 2025 at 9:59 AM Christian König
>>> <christian.koenig@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 15.09.25 15:33, Alex Deucher wrote:
>>>>> When we backup ring contents to reemit after a queue reset,
>>>>> we don't backup ring contents from the bad context.  When
>>>>> we signal the fences, we should set an error on those
>>>>> fences as well.
>>>>>
>>>>> v2: misc cleanups
>>>>> v3: add locking for fence error, fix comment (Christian)
>>>>>
>>>>> Fixes: 77cc0da39c7c ("drm/amdgpu: track ring state associated with a fence")
>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> ---
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 33 ++++++++++++++++++++---
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  |  2 +-
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  2 +-
>>>>>  3 files changed, 31 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> index fd8cca241da62..72f0f16924476 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>>>> @@ -758,11 +758,36 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
>>>>>   * @fence: fence of the ring to signal
>>>>>   *
>>>>>   */
>>>>> -void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence)
>>>>> +void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
>>>>>  {
>>>>> -     dma_fence_set_error(&fence->base, -ETIME);
>>>>> -     amdgpu_fence_write(fence->ring, fence->seq);
>>>>> -     amdgpu_fence_process(fence->ring);
>>>>> +     struct dma_fence *unprocessed;
>>>>> +     struct dma_fence __rcu **ptr;
>>>>> +     struct amdgpu_fence *fence;
>>>>> +     struct amdgpu_ring *ring = af->ring;
>>>>> +     unsigned long flags;
>>>>> +     u64 i, seqno;
>>>>> +
>>>>> +     seqno = amdgpu_fence_read(ring);
>>>>> +
>>>>> +     spin_lock_irqsave(&ring->fence_drv.lock, flags);
>>>>> +     for (i = seqno + 1; i <= ring->fence_drv.sync_seq; ++i) {
>>>>
>>>> That won't work, the seqno can wrap around.
>>>>
>>>> I would just go over all fences, e.g. from 0 to end of array.
>>>>
>>>> The checks below should make sure that we don't try to set an error on something already processed.
>>>>
>>>>> +             ptr = &ring->fence_drv.fences[i & ring->fence_drv.num_fences_mask];
>>>>> +             rcu_read_lock();
>>>>> +             unprocessed = rcu_dereference(*ptr);
>>>>> +
>>>>> +             if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
>>>>
>>>> dma_fence_is_signaled_locked(), otherwise the function would try to lock the same spinlock again.
>>>>
>>>>> +                     fence = container_of(unprocessed, struct amdgpu_fence, base);
>>>>> +
>>>>> +                     if (fence == af)
>>>>> +                             dma_fence_set_error(&fence->base, -ETIME);
>>>>> +                     else if (fence->context == af->context)
>>>>> +                             dma_fence_set_error(&fence->base, -ECANCELED);
>>>>> +             }
>>>>> +             rcu_read_unlock();
>>>>> +     }
>>>>> +     spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
>>>>
>>>>> +     amdgpu_fence_write(ring, af->seq);
>>>>> +     amdgpu_fence_process(ring);
>>>>
>>>> That's actually wrong. We want the other fences to signal later on when we process them.
>>>
>>> This fence is the original guilty fence.  The other fences will
>>> naturally signal when the later fences signal.
>>
>> Ah, got it. But that is still racy as hell.
>>
>> We should probably rather signal the guilty fence separately by calling dma_fence_signal().
> 
> What is it racing with?  amdgpu_fence_process() ultimately calls
> dma_fence_signal(), plus it handles various AMD specific bookkeeping.

Potentially concurrent signaling. Keep in mind that it is perfectly possible that the guilty fence just completes while we do all this here.

Regards,
Christian.

> 
> Alex
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Alex
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>  }
>>>>>
>>>>>  void amdgpu_fence_save_wptr(struct dma_fence *fence)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>> index 6379bb25bf5ce..f6c9decedbd51 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>> @@ -812,7 +812,7 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
>>>>>       if (r)
>>>>>               return r;
>>>>>
>>>>> -     /* signal the fence of the bad job */
>>>>> +     /* signal the guilty fence and set an error on all fences from the context */
>>>>>       if (guilty_fence)
>>>>>               amdgpu_fence_driver_guilty_force_completion(guilty_fence);
>>>>>       /* Re-emit the non-guilty commands */
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> index 7670f5d82b9e4..0704fd9b85fdb 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> @@ -155,7 +155,7 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>>>>>  void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
>>>>>  void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
>>>>>  void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
>>>>> -void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *fence);
>>>>> +void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af);
>>>>>  void amdgpu_fence_save_wptr(struct dma_fence *fence);
>>>>>
>>>>>  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
>>>>
>>

