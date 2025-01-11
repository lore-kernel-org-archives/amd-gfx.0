Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED35E7719A
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jan 2025 03:40:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70D2210E053;
	Sat, 11 Jan 2025 03:40:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tI2VmwWR";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC47710E053
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jan 2025 03:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMGBEMJZZ5ZXTmkyW0JiZc2XnH4wqntE9PxbZMfF1hTYvgKKNmY54ISeGR4kSlureq5vS/OojMUlJybmkTfAblx6ozMP/bDhfohtgrgio8Ad38dwi+MfbYtpNDIaAjrgntXyx6FPxpSOYivodQ7zIb1OBvvAxuLH/klb6CoDbpqlMngPgZ9qtibT2xrapfZuRE6k2hjjFxwmZ1wbCjU6dKBbfyNhbC8tUqqhiKDPB+Td5Soez/TTX3gblCv3laXpXIDPQ7xqL6wiweO/qVa73h0Ybok8bBHp0Yo8cBaGUv2OJ2zaW7swd8+FzDFf/801VgZKn814sy/vjX/33L6JkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMRFYo4t19Ch4l2VwE2mVGZQoADYBLsb6A5U3J70g9g=;
 b=O3aJ9nS9doI5PSOyJGafiIrxVbwA7Craevl+Z90KnzWQwNb8xg8EjBZBHVcedC1Xi6hxadD6Ci8Scf7hHEEakPc63EFhkWqT8jOcBPOUNyhPe35z0AjvOsHzZhSIBKdD9EzlZbyQno3fUBE3MLe02KRXYaAC9VrrThtMCUCO6h6N80p8Rzqo5mSTBritDjh5/7joc05bv7DDwx+xSDaeE6Suervzzb2jSKDz2BQcYyYF+WsPXZfHjZmgQbsiwTgdb2rmpUnyda+3Bqz0sBy448RJ8YCPHtLkyDm3dulc5yZZnCH9+I74JRpaht5/Bw9jzYPKC5nA9PX1lPJCbrMvDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMRFYo4t19Ch4l2VwE2mVGZQoADYBLsb6A5U3J70g9g=;
 b=tI2VmwWRqTi0iymtScbupme3YIiA5t834IEdIp4JpnMlbw0Q/GoWBTot1DFOFsD/Sloaz1AexPXYYxTrfK8Sjwj6UHcMSiCfBdidlkzs79+XOaBwzLXuyCzxDr/4wFFBcWUEronqTU0JEJbtYDdWvVPhaWqaj12FxBi9kHeaPHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB8793.namprd12.prod.outlook.com (2603:10b6:510:27a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Sat, 11 Jan
 2025 03:40:55 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8335.010; Sat, 11 Jan 2025
 03:40:54 +0000
Message-ID: <27163712-891c-4708-96f4-90bd1b2bbf7f@amd.com>
Date: Sat, 11 Jan 2025 09:10:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drm/amdgpu/gfx: add ring helpers for setting workload
 profile
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 aurabindo.pillai@amd.com, kenneth.feng@amd.com
References: <20250108225627.14063-1-alexander.deucher@amd.com>
 <589ecdc0-9f5d-4b79-b11d-01b6d22fbf15@amd.com>
 <CADnq5_NrJ7xqkxk-ccYnQeuVRoWuN95Wyq59UVYtdRUMVVqCvw@mail.gmail.com>
 <7bf342e7-72ad-4ed0-a45d-ad933db28753@amd.com>
 <CADnq5_N_S6Cv57zAgroHJ2e7KbvmQ_8QcPHrryEtatpaAWR87w@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_N_S6Cv57zAgroHJ2e7KbvmQ_8QcPHrryEtatpaAWR87w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::35) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB8793:EE_
X-MS-Office365-Filtering-Correlation-Id: 459a38d1-c8b5-45ea-76ce-08dd31f1c0a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2lkaS9GL2VaZkhNekZIQmFtNHp4YTNmcm1IN3RXNG5jbFQ0YmJzWlZGVXps?=
 =?utf-8?B?SUxnNUVaTGo2RU9meUVGTi9MclhYaHNETUgzeko2cXRSWGJjcldSYmUxS0hJ?=
 =?utf-8?B?OVNxN1VzaTVkbnE3MkxVWkZuelVtTmtDbjlEeU8zc01vemxKTXRKdG1pQnVB?=
 =?utf-8?B?T0xrazA1eThVUXk5Q1ArLzhneFVyTzVxSll2NElsMFJzQ3VEdjFIUG1GV0d1?=
 =?utf-8?B?RGpGdFlVajJPVzErRVFXUVpLTFlLZFlxK3FZYmtjamo3WGVHckFZRk9qbWhY?=
 =?utf-8?B?WEpnM0lvaHJCOThsSkNseGtnQXM5WkNyYXFBWE1Fc09KdXBMa3pvdkdMY0Z3?=
 =?utf-8?B?VzZHK0txNzNJVXhzTXRJTU5BL1kyTzlwYWtnR255MS9aUlNRaUpIeXhMbVlO?=
 =?utf-8?B?NjdSU1Jhbk1ieHkxRGMwMXplZjlob1plTmNzdUNRbWplRVRQUnRsbGw1ZWwr?=
 =?utf-8?B?bjFHMm5nMHVTV2NnRW9lYXRyUmxWTUVpcDVQb2xJclBYanhkTUNMdDc5Ti83?=
 =?utf-8?B?aVI1R2xkemoyaDdhbURtS2FvYkRrOVpZQXZzRW9VYkdwenFJd1lrQzhEaERW?=
 =?utf-8?B?R2Z3Sk9BZVYxTzdkWU9ObkNVSm92MTY0NXdjUmhjcUNQaStrb2J1dFA1R0lv?=
 =?utf-8?B?OUNVeDhlMDVpOUt4TmpqZDdRN3RXeU00VGRHSTY2SHZRR0VaWHMwR0FTajlw?=
 =?utf-8?B?QlV1Q1g5Mkk4Y3R6VzZhSURXZlRHV1NXbHFheHRQc3lsbTRQbTVQa1dpWGVj?=
 =?utf-8?B?UnVNM3VBZllwSE5lczFKWVZuQ1NhTDd6cGF6bk5FUGdtK1JqZEE3bjkyaWx1?=
 =?utf-8?B?VEZPdVBhdGpzYjM3bjNRNWU4aGNRMmJNZisyR0VSd0V2Z2VQTXRhNHA2TENo?=
 =?utf-8?B?dmRBNFQ3MnViN3lZWURML05hSUVRZ1d6QmxDaitBd1oxa0l2bnB3N3BraHUv?=
 =?utf-8?B?Ris5NzdFWkhsTVhXMVNQWnZOcVpHR1BpTVRub0hybHlEU0ZCdE9RWFFYbjJG?=
 =?utf-8?B?b1Y3Qkx6NEpvNktnSVJhd0ZRSTVyMWlZUnMzdGI4b0pBb1BGVmlXMWs1TWpU?=
 =?utf-8?B?UnNmWHU1blZRT1R3UzIyVENRTUFpUTd4N3d3QnJNTVc5eXRhaUhtWFY2cGpL?=
 =?utf-8?B?bkZLMmg1bXpvaXdzTG1XZ2JJWWJQU1J5QVlBMEtSQ05pQWtnK3NvREhxa1NV?=
 =?utf-8?B?WW1QZDMwUDU1ckl0cUxZdE9qcHNwM1JOZ3lYcmpPdDhjeFpJTlhjQ04xRmRz?=
 =?utf-8?B?eDd4Q3ViNzFKWWVGWUx6U3dySms4Y1hIQ0cxTFhFdDB5TlNCN2Q4L0loU0Zu?=
 =?utf-8?B?K3ZjTkY0eFNTM2VLbjFNYWdtZitHQ2ZUT0NnNlVzaEFFd0g0R2hxQW1Zamxt?=
 =?utf-8?B?blBHOGRkUDhmTlBHM1RxQjloMHVTNUdOdVZVdmdDVUJCUnVTQjU4SE1nR2dl?=
 =?utf-8?B?c2loKzhtamlVRisrYUI0NndYRlp4a2hCWm1QUmdCUmsvTmRYSUdWYkUxU2Qz?=
 =?utf-8?B?d2prVC9KMEZwdTN1N0djQy9zWUVkVlVRM3lnaSt5MWx2WkpIUmZzZE5ERXp2?=
 =?utf-8?B?RnBGVGJnVjBzeWVUeFpSRXFCUityNmhGazFEMGd3Q0tSakxSUTFpRUZIZDN1?=
 =?utf-8?B?dXdyMkEyNUc0ZU9XZUtMZk9OYVRiK0hubGE1elUxZVcwM2xxbDc3SXdjaTlZ?=
 =?utf-8?B?Vk1aRFlpaFBOakZJTk5ROFAzV0lkN2p6WkZmMWwxeURtRWxUQ0hid1EweVdB?=
 =?utf-8?B?TEU3ZGJqZW05WXdjRndOY1lhcm9sNlpjOWxqU2pDaXhtNzdwa0xPREdkcnp4?=
 =?utf-8?B?cHliWHlKYnlHQm1mZjY3bTlraUc0UFV5eXcyTkptYlYybGQzL3ZIUVlhZTJh?=
 =?utf-8?Q?vvDLpaHdqTx84?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlhHSzRDOUhTUjdvMVdrekNvaFQvNUZ1anMvenJRQU4zQTFIYTFQK1RTeEZ1?=
 =?utf-8?B?MTFCRWRPajQ2RkJlQTBEUlZxWThzMVBzMTBnbjZkWDl5QkNoYjNwQlBaUTBi?=
 =?utf-8?B?czBuRmhQTUxUZ29iK1lDSTZBeVZDVGFNaTJENDZIZzFPcERXN1VJQ2VXekM5?=
 =?utf-8?B?VW1sVjRjd0F3SjkyaWwyVlBIUVRHNll2S1Zwbld6dVM2Wi81Zyt6R2pnMlNI?=
 =?utf-8?B?UHh4MGFIWm5TaUduUHF3TkkyMER0SC9yOHY2WDRtanZDcExpaGhHRUpLY1BN?=
 =?utf-8?B?bU5wUzJ6YjRGa2pINS9wdGZGZUhHZUVsWXJtbEQyc3FSSzc2di80RjlMcSt2?=
 =?utf-8?B?OWR2amFBUG9oSG8wNm5ZV0N2dlp0UjFSWFA3SVlEZlhrMkU0TUhVaHV6QzFs?=
 =?utf-8?B?NnhyYUZJdkhWbmUreDRBUWRQbk5yTWFMR2xZNHliQi9TMDRmR1JRRmFvN0k2?=
 =?utf-8?B?OFFJOGsvWitYMkdKTFk4dmdlRnRRNHpsSUIrWXQrQ2xhSXlMbnpkdVNrR2NZ?=
 =?utf-8?B?ckFUZ210elROczZSN2czMFdpb3VZL290OFRheUg4aHFXdHlHWGZOVUppNEQw?=
 =?utf-8?B?am54MTBXZUZSWHcxdEZNR3ArZ0ZVUnE4YmJlZU5qMnBjMUNua21YYU0vYld5?=
 =?utf-8?B?NlZiZFRpbmkxUWQzWUpTblY3Nk13UWJjaWpxZzIzY0hnWnQzb1M2N2tSZG9u?=
 =?utf-8?B?WXF4R3dSa25lSGFENy81aGRqMUlCaGNCeXdMWHFkZVhEQ0k1d1V2NWIxK3Bo?=
 =?utf-8?B?QWlMcENFMVQxL2lRZUdodkh0U293b0FWV1ZBWG1HNnpmV04vMmdLMmZqdzNJ?=
 =?utf-8?B?V0tDWU0vMFZUcnhlTlgrL0IyTE5nZm1UTGVLdEV0bE1YaW5hZGR5a0ZiL3Vy?=
 =?utf-8?B?UzFNWkk3TjVoREhtSHQrUUVzTnkwRzlQMnQvWERSOHNMMmFERmhQeXBHbUdQ?=
 =?utf-8?B?V2xlL3RNSzVONXN0dkR4VlRIdVpraVphUkc5ampCQ2Z2blc4UnlDN2xmSGdi?=
 =?utf-8?B?cDBZcUVjeThxa3FXR2h6YXNuLzBvakxtQmkxZEZ5Q3lRcCt4NzRTUlpUaUZX?=
 =?utf-8?B?ZTFqMWd1WmxJWXZQZ2FMY1BQaUwybmRNMlJZcnd1ZUY4UGdnMUVHaUpxS1NG?=
 =?utf-8?B?ZFozTDQzaG4wN0puQzJkdEZEM0lOZmdCVW1WUzFFYXBFSk9VUTh1VGVxUjdz?=
 =?utf-8?B?N3FOSEFOY245YjQvdmNlMUs5bmdTcGVrdUtrT05nU3hVYWhyUVEyT1ZKa05N?=
 =?utf-8?B?cXJKTlRHWTRWWWtVZ0dGYlNVUEkvNHRxWWRycnZIamQzbm80RjZvU3MvejIw?=
 =?utf-8?B?TkgzWE9YZk5zYS9lVDVGb0JwZkM4eTdjTnpVZjRrVEg3Q2ZTNTVtL1hRdWtI?=
 =?utf-8?B?ZmlOdXRIMTFoMDJpeWNLb2xGMlZ2cWU2Zy9iT3FlQmUvblV2K3RPTjViK1Ux?=
 =?utf-8?B?c0lHSlJIRzFKaEVIYzkwVGE4UUhoVGM3ZXBNVE9hbzdxS0t1azdVQXRQYUs4?=
 =?utf-8?B?NVNvV1UvK3Y1SmZ2ZDdQeVgvaWhtR09oak1FcDdtcDNQOTB4elhiLzE5S2Vi?=
 =?utf-8?B?QWc4NTZwbjI3WUZvZDAreE5rVEZsQ1BjRkp4bERLa3N1K0VyVGdDUjhuVkR1?=
 =?utf-8?B?SVZieVVFOFRBOXpQU3hjMUNJSHkzRTZ6WDBETzlwTGFoYTJQN2Y5c3hoRE51?=
 =?utf-8?B?UjE2c0haQkZ3amd1OUtHL2N3bHN1Y3NNSW9tZjV2Nm5ZdGxsMmlYbEtlUjBu?=
 =?utf-8?B?aUVSQmVXZ1dtd0poeWFvbkR2OStmdk5rQVF2UUlPTlptelBKY0oxaTBMdlVM?=
 =?utf-8?B?T3lLbnRDRDJiUjJrUHZ0YzltbmFJdHpIS0lVREw4UDlzVGpsOVJnSmZwRzUz?=
 =?utf-8?B?RWZEb3U5TzljZ1JBT25ORWV1Y2JJdTdHSDAxOEJaZFUzbCthMWZZWW5aZFRS?=
 =?utf-8?B?N2tEQzgwS09udWh1c1l1UDh5MGgyam14Y0NzcFA3U2M1TTRwRk5obDRtNlNG?=
 =?utf-8?B?SktmOTBrdGJITVY4WENBVHlhSTR5QXhWbFQ0SVJTeEV4Ykdsd3Jib29sTVZo?=
 =?utf-8?B?eTRqcGdYNjdkOE5yZzgwejVHbmxWZXU2bnkxdExucWFiS2xkbDZpZlYremN3?=
 =?utf-8?Q?Az9/WZ4T8/JpTywG7gKuHZA3z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459a38d1-c8b5-45ea-76ce-08dd31f1c0a8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 03:40:54.8836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75NALx9r7mh3qe9Cu+W5LPRZBulZrIq6FNrzRYpbjqBwL+LSGbz+oTYfkIfqK84I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8793
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



On 1/10/2025 8:33 PM, Alex Deucher wrote:
> On Thu, Jan 9, 2025 at 10:30 PM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 1/9/2025 10:36 PM, Alex Deucher wrote:
>>> On Thu, Jan 9, 2025 at 12:59 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 1/9/2025 4:26 AM, Alex Deucher wrote:
>>>>> Add helpers to switch the workload profile dynamically when
>>>>> commands are submitted.  This allows us to switch to
>>>>> the FULLSCREEN3D or COMPUTE profile when work is submitted.
>>>>> Add a delayed work handler to delay switching out of the
>>>>> selected profile if additional work comes in.  This works
>>>>> the same as the VIDEO profile for VCN.  This lets dynamically
>>>>> enable workload profiles on the fly and then move back
>>>>> to the default when there is no work.
>>>>>
>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> ---
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 57 +++++++++++++++++++++++++
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 11 +++++
>>>>>  2 files changed, 68 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>>>> index 6d5d81f0dc4e7..c542617121393 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>>>> @@ -2110,6 +2110,63 @@ void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring)
>>>>>       mutex_unlock(&adev->enforce_isolation_mutex);
>>>>>  }
>>>>>
>>>>> +void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work)
>>>>> +{
>>>>> +     struct amdgpu_device *adev =
>>>>> +             container_of(work, struct amdgpu_device, gfx.idle_work.work);
>>>>> +     enum PP_SMC_POWER_PROFILE profile;
>>>>> +     u32 i, fences = 0;
>>>>> +     int r;
>>>>> +
>>>>> +     if (adev->gfx.num_gfx_rings)
>>>>> +             profile = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>>>>> +     else
>>>>> +             profile = PP_SMC_POWER_PROFILE_COMPUTE;
>>>>
>>>> Since profile selection is in generic code, it makes sense to first
>>>> check if the profile is supported for the family. Otherwise, this needs
>>>> to be passed by the respective GFX family.
>>>
>>> The generic code already handles this.  If you select an unsupported
>>> profile, it's ignored when the mask is updated.
>>>
>>
>> That is strange. Does that mean user never gets an error if user
>> attempts to set an unsupported profile?
> 
> If you use sysfs, you can only select from the available options
> supported by the chip so there is no way to select a non-supported
> profile.  For the internal driver API, we just silently ignore it.
> 
>>
>> Another problem is this could override the user set profile now. Is that
>> intended? In the current logic, whenever user sets a profile, the
>> current profile is removed. With this one, another profile gets added
>> and the user preference could be ignored depending on the priority.
> 
> Yes, I think.  For VCN we already select the video profile in a
> similar manner and for ROCm we already select the compute profile,
> this just extends that to gfx.  This doesn't really change the
> behavior compared to the current state of the driver.  At the moment
> we default to fullscreen3d on navi chips and on MI chips we always
> enable compute when ROCm is active.  The change here is that we
> eventually fall back to the bootup profile by default when the GPU is
> idle.  This allows PMFW to enable additional power saving features
> while still providing a boost when applications are running.
> 

Sounds good. Only concern is if user intentionally wants to use power
saving profile all the time. Not sure if 3D has a lower priority than that.

That aside, series is -
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Alex
> 
>>
>> Thanks,
>> Lijo
>>
>>> Alex
>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> +
>>>>> +     for (i = 0; i < AMDGPU_MAX_GFX_RINGS; ++i)
>>>>> +             fences += amdgpu_fence_count_emitted(&adev->gfx.gfx_ring[i]);
>>>>> +     for (i = 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTANCES); ++i)
>>>>> +             fences += amdgpu_fence_count_emitted(&adev->gfx.compute_ring[i]);
>>>>> +     if (!fences && !atomic_read(&adev->gfx.total_submission_cnt)) {
>>>>> +             r = amdgpu_dpm_switch_power_profile(adev, profile, false);
>>>>> +             if (r)
>>>>> +                     dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
>>>>> +                              profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
>>>>> +                              "fullscreen 3D" : "compute");
>>>>> +     } else {
>>>>> +             schedule_delayed_work(&adev->gfx.idle_work, GFX_PROFILE_IDLE_TIMEOUT);
>>>>> +     }
>>>>> +}
>>>>> +
>>>>> +void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring)
>>>>> +{
>>>>> +     struct amdgpu_device *adev = ring->adev;
>>>>> +     enum PP_SMC_POWER_PROFILE profile;
>>>>> +     int r;
>>>>> +
>>>>> +     if (adev->gfx.num_gfx_rings)
>>>>> +             profile = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>>>>> +     else
>>>>> +             profile = PP_SMC_POWER_PROFILE_COMPUTE;
>>>>> +
>>>>> +     atomic_inc(&adev->gfx.total_submission_cnt);
>>>>> +
>>>>> +     if (!cancel_delayed_work_sync(&adev->gfx.idle_work)) {
>>>>> +             r = amdgpu_dpm_switch_power_profile(adev, profile, true);
>>>>> +             if (r)
>>>>> +                     dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
>>>>> +                              profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
>>>>> +                              "fullscreen 3D" : "compute");
>>>>> +     }
>>>>> +}
>>>>> +
>>>>> +void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring)
>>>>> +{
>>>>> +     atomic_dec(&ring->adev->gfx.total_submission_cnt);
>>>>> +
>>>>> +     schedule_delayed_work(&ring->adev->gfx.idle_work, GFX_PROFILE_IDLE_TIMEOUT);
>>>>> +}
>>>>> +
>>>>>  /*
>>>>>   * debugfs for to enable/disable gfx job submission to specific core.
>>>>>   */
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>>> index 7f9e261f47f11..6c84598caec21 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>>> @@ -57,6 +57,9 @@ enum amdgpu_gfx_pipe_priority {
>>>>>  #define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0
>>>>>  #define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
>>>>>
>>>>> +/* 1 second timeout */
>>>>> +#define GFX_PROFILE_IDLE_TIMEOUT     msecs_to_jiffies(1000)
>>>>> +
>>>>>  enum amdgpu_gfx_partition {
>>>>>       AMDGPU_SPX_PARTITION_MODE = 0,
>>>>>       AMDGPU_DPX_PARTITION_MODE = 1,
>>>>> @@ -477,6 +480,9 @@ struct amdgpu_gfx {
>>>>>       bool                            kfd_sch_inactive[MAX_XCP];
>>>>>       unsigned long                   enforce_isolation_jiffies[MAX_XCP];
>>>>>       unsigned long                   enforce_isolation_time[MAX_XCP];
>>>>> +
>>>>> +     atomic_t                        total_submission_cnt;
>>>>> +     struct delayed_work             idle_work;
>>>>>  };
>>>>>
>>>>>  struct amdgpu_gfx_ras_reg_entry {
>>>>> @@ -585,6 +591,11 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
>>>>>  void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
>>>>>  void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
>>>>>  void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
>>>>> +
>>>>> +void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work);
>>>>> +void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring);
>>>>> +void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring);
>>>>> +
>>>>>  void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
>>>>>  void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
>>>>>
>>>>
>>

