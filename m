Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE8BC7115B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 07:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B50D310E0C4;
	Wed, 18 Jun 2025 07:35:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bJxeTZFQ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 391F810E0C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 07:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZOogczmXuILOKJBkGvBaC1FmEwSJeB931L4iaeyXpcpMTTmiCGIa3dB/eXjyvCgL5t5qZx3+F+eQghQJkbAzU88wkGM3dcjWUDb8UzpcBj721xgwSADRbbSQRyZ1c1nhMNaUlkr0D8v/ICYOvScq4T2cwMGMySUasDV1s0j6Td6kO0FXDRR3znTHhta3Lqj5+HZx5rRwH3gQ7QuphBw5+aGvOFUM5hq2Au8gAP1EdB2GHhkOv97i5uiQCgRw4uaxE9Ods8DLZnqTklwfHvNPD5VLAwLtvLUjOEnr7pBONTGShVYnQKXR7Wip4Pi048MW0EXUTBsPcd+Hm7ETAv1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2T36uiHwkPTzAy8sa0kXMsROc01qlnBbCiVx9bgng4=;
 b=cxQYb7+C/e2EiIXkuzdRNp4G/1y0aiZbvUxAL/Vw0Kx4cwp8cwJ/ciG/Ds33YjC+crtpA+9W2ygptOues6lelOk3D7X5peQOg9URgwrj7o4VfnQyRoJZDazJhdo+Txll5Sj0lhqjrcUpu4wsmmOlgq9ZiLeg+CGSiW0LVzjvePsrl8RAk6SzzcyIx6lB6tUW1zHTkcrGL44ggbwICTnp3EI16COpvPIqehJ+ip6G+uolW6ucT0BSTm2zbWGBgCItnO5R1f4F3uKn2ZVwGuX1o6zWpzGEQWGnu+RtayE0is0rseDVjm9HEL1ecRaC9v4+GMg2hM+bqx5zg4A2GCtjNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2T36uiHwkPTzAy8sa0kXMsROc01qlnBbCiVx9bgng4=;
 b=bJxeTZFQhV/jeMQcSjpVFBt8USks/iooA+vCOQAvrtSfhDn1qw/rNuWSnLSmQGejQ5Ar4PLxTmsvkE0sjp5Y49bASvc0Bx77NGbecUvZtUunh25vzuPBnrveGvFfZoSon83ZiWVu8LtbPB7V+x14HSSf1QgWtXWzpfm58zbrDxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 by IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 07:35:42 +0000
Received: from MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743]) by MN0PR12MB6293.namprd12.prod.outlook.com
 ([fe80::49ac:e84e:ea32:d743%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 07:35:42 +0000
Message-ID: <b0bb069a-b192-4b6d-bb2f-dd151a053148@amd.com>
Date: Wed, 18 Jun 2025 13:05:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 36/36] drm/amdgpu/vcn3: implement ring reset
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com
References: <20250617030815.5785-1-alexander.deucher@amd.com>
 <20250617030815.5785-37-alexander.deucher@amd.com>
 <f8b4bf5b-17ca-442a-a515-7860037a8afd@amd.com>
 <CADnq5_OisducAyYtztD5-L+ib_j8dh6p0HhCN9a3tV63duaDWA@mail.gmail.com>
Content-Language: en-US
From: "Sundararaju, Sathishkumar" <sasundar@amd.com>
In-Reply-To: <CADnq5_OisducAyYtztD5-L+ib_j8dh6p0HhCN9a3tV63duaDWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::9) To MN0PR12MB6293.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6293:EE_|IA1PR12MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d8ebd3-c916-4a3a-c472-08ddae3aba83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmhnOUdHamZzMVBzckJjZmJ0Q0RMZy83QVFLRTgySzQxME1Oc1Fad0htL1Nx?=
 =?utf-8?B?dVdyRXRjM2NDajhXdVY4L24yS0lmV2JUeS9Ra1hneG5Pblp0RjQ0aStLcVF4?=
 =?utf-8?B?ZTY5UDZwN0lGL29lQklwZzZUT0RsTzRXdDZBU0xjTmY5eGdsdWg3Vld1WElT?=
 =?utf-8?B?QVBWdXMwNzFYZTBETEgzNmxhWVJZYzFtV1hWV2plMzlhZElOb01TUFREQUlP?=
 =?utf-8?B?ZndDRTBud2J0ZHdyWTMxOWZmQUMwWkFHYm1qek5QcDcrQjFGa29nSjR5SjlP?=
 =?utf-8?B?WTFwVzJiTzJLbWxpUjFrU0FzdjN5N0tSTlNYemxVU3J5b1RtUWhmV2tia3Nw?=
 =?utf-8?B?K1pTOGZDemsyNWZvSUYxeWlCM2ZpYjFWS2dXZFV5RVZEYnk2UlRkem8zZytF?=
 =?utf-8?B?SXJDZDZ1T3J2STZ4VGVwdW9BcHI0MkJNYWMzd3VlK0NNMEtCR2UvN21GaktN?=
 =?utf-8?B?bGFHUk9oWVdmclRsbDlnZHJHWnkzYXdKbThLQlczVnhoYnJRMi9LM1QzYUZC?=
 =?utf-8?B?bWlpRCtRSU1iTDRoZmkyM0Jqcjl1dk5oZm02WnZOeGJKWk12MGVwa0FNd2Rr?=
 =?utf-8?B?M0t6Q2lPak1LTmJpN3NSa0dQZUZ1cm8xT25PZTNoMGhYMmo4aStRRkVZaTgr?=
 =?utf-8?B?dEpYYU5YeGoyWEIrK0FKWlUzQTN4dU5mRVFETkQySHVvVXZQa0d4QkROOTBp?=
 =?utf-8?B?MG5sOGhWSlZqMUVybW9Vbk1VaGlSMHZTMnhxZEM1d2xLYVdxWE5LOVhXMlR4?=
 =?utf-8?B?NEtXUW50R1h4d2ViWmNXQ1ZFaTJZcm5TRXdJWm0rS2RjVS9mc3EvVGhiYUhG?=
 =?utf-8?B?ajI3VlNVSFdYb21kTlVMdFBKMStSd2s0QTYvUndIN0hmVGFTbXZ2U3B1MEFK?=
 =?utf-8?B?NngrVkk2Zk5kWllxVXpzbTcwWmxSK2JseFBwVDJvTjZlSVZ4TjNoYnYyYnE1?=
 =?utf-8?B?VERaMTJlYmc2cURSUmFmSFBmMmZ1ck56M2N4dGZGeXhicnRGQms0OXRnZXBR?=
 =?utf-8?B?d25TNXBDUjJZMjNCN0NUTjQxOC80Q056QVpWM3FUdGp6a2pHMUJwL1BHT0kz?=
 =?utf-8?B?bEg3aU1nNDl6WTRxd0FwMkRSdUdHb0NyQitKUFIveUQzMTFjbHdEZ2h5ZXNL?=
 =?utf-8?B?eld1bGJjZjdJcFRIVXFPWjJiL25yVDc2L01JZFQzRkJqb1dyQklHY2hCaThR?=
 =?utf-8?B?NnJ6S0FLUGY4cis5WWFDMDV0TFlVSGhNT0hkZTk3WnN3bmVBR21nWUYwa3VQ?=
 =?utf-8?B?REVGdUUvSklBOVVnT2ZuZS9GTEVlMk1Md2QvQnNlNjk5OS9tOHRTTFAvSk1P?=
 =?utf-8?B?YU1lWk8rRmtYMFROYnRMZ1JOcU4yckRqZVNZTVRjRHhkdE93TS9OSTRPOWFa?=
 =?utf-8?B?aHMwZUc0RWQ1STBHSENKamV1UC9CNjNmT1EyWVNjUW5NU0YzcVdwcHAvQ0Vr?=
 =?utf-8?B?dDhjOGVadXBJTDhFV2dKMUpiUHdMVE9yQUJTenNxaUc2akxoVm05Yzh1Nm5r?=
 =?utf-8?B?cmJBYStsOWRSSFlHUlNCMEhrK0xWTjhRTkREZlp5UTZUdktwZXFwbk1lK1Va?=
 =?utf-8?B?MDdnQVNGZ1pVQzEyTUdjUWFMRmpsREpCeEJXQUJQbVhPSjlvNWdod0UycUtV?=
 =?utf-8?B?S0xNMXllVGV1d1FFSDdlbHBYVEk1Qk1Ja0hzdHRvODJHZld0MExMalkxdVYz?=
 =?utf-8?B?KytQWGt1SFNjc0NqQWxYQUxtbGpZdkdDRGM1S1BLTkkxQWh2QXhSMmFlOGth?=
 =?utf-8?B?ZUVZeFVETDVGdkV6ZnpLdkZCbngrSVdnWHBTb1VhaStpNGJhalFhcEo1N2Yr?=
 =?utf-8?B?SFdzU3o3d2piNEVkTnRXaVExcTV6dkhZWk5ScXlsclcrWU52djJtQjh5RXB4?=
 =?utf-8?B?YkZkTEhybUVUYlJuQ3k4cjFQZy90aTVCZzRsdExPUmo5MFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6293.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWtnRmxmaUlPNWQ5RkJUYlB1ZFVqMXhOQ3hNd09yZW5DYXNNaXZqSkFlT09m?=
 =?utf-8?B?Wjhjb2pqNEJ5NGRZbURuVXB0K2RmZGVTWG0wTGYvcVpxbjlOdUx6Wk9pbUNj?=
 =?utf-8?B?MFdaUGFleUZXd1M0a29mZ1RtT0dEUHBIeXFJMnhWYUFGdGNRZ0RZckxhbW1t?=
 =?utf-8?B?MTRjQ2puMVZ0b0t1ekN2TFZOK0pjNXNSdjArUXBQMHBlRVZ4bGx2TGpRVlhS?=
 =?utf-8?B?OTB1blVXRGl5RnJER3FYTW90cllGN0pMRkpVY0p1NmdZL1grOEdzQnUrYnZ3?=
 =?utf-8?B?Mk1udTEvMEZGZEdOOWhIeHJjS1ZJNnBBWmlqbXF3YWtQem9oNWtTQ3ZiTnVh?=
 =?utf-8?B?YXVRZnJiOS9aUkVZNTJDY2FUcTBjTmx5cGgxV2pVUVZkTHMxTUxaTTZ6K3Uw?=
 =?utf-8?B?dnlPd2dRdmxFS0krMmJMWlh3Z2xaeUJpaXVVbkxSRDVTL2I3U2F5UHhGTzBP?=
 =?utf-8?B?VExGOVRzMDN4RVBrL3VqNnBjWEM0MVhtdmQrSkgzaDFzcWhkVThBdzlpakwx?=
 =?utf-8?B?MEhyb2VMYy9SVFJlQTdkLzZHQ0ZKUXdSWjY4VTZGN2FVeUxaZFVSR3FIU0g2?=
 =?utf-8?B?T3FRYncwUHhPL2lsaElFUEdDVGxZa3VkcUhWYWNwejFYVlNuNXVwQjNoMWNn?=
 =?utf-8?B?N1U3cHprRWs0VjBINTRGWlMvTisrRU9zcm5qYXo0SWQyaTFGVGFXS2tERm5Z?=
 =?utf-8?B?VjJRQUl0NmdnWUtwYm14R0hkVDdlN1pyelNjV2l1TmJOcUkxZmVibUR5SS81?=
 =?utf-8?B?QUVJVmVBQnlaeGs3TWRNSEsvWnRINGE1RFVKNCs2RGZiL1VLenU5TG5iQ2FD?=
 =?utf-8?B?Y20yYk5oZ2VMSTVpMFVYTnF6OElpNDA2TWNpV0Q5UkY3WXdQWFpodGZ0QmVu?=
 =?utf-8?B?YXR0RlkyZGxVZHMzNC9uYmpxY3ltZGYzMVFra1g2a2huZjJ1TzdpbDdOcWxQ?=
 =?utf-8?B?OGhWd3hWMHIxRWUzYTdTbkRrNUNINmFBQzBSS3g4RXFDdEV6K0pVRTRsSUo0?=
 =?utf-8?B?OVN5NGRxTjVKODE0TTJPRkhOeDVxVnM4OVlSUWFDRG04bVpnZkk4SVRmQnhI?=
 =?utf-8?B?aVFlZkN5SVdLd25xZ25uTU1KVzl5cmVyWkVjM2V6WTFHZit1RTFDOTRmWVNU?=
 =?utf-8?B?b0ZnSmp2WVY0R1FTQytSVWR0Y2dxbXNkY2FSd3JsZUJrNkMrQ2YxbXQzdXN4?=
 =?utf-8?B?b1p4MDRSUlNXc2ZpeFM3VE9PcnE0VnVNaGs5NUZIQlFYeDNsQkxHRGFCZjFs?=
 =?utf-8?B?T0FNNFE2MVdWdmNtcmE3SHBxSlQxR1VQMHJzRzdxcVNMcGZ1dXNpZ0xpTjV2?=
 =?utf-8?B?WHBZVXdaUUY2WUxETWt0bzdISWJSdUdQRTVsRG56NG85R3U3NFJoWWpYZmlq?=
 =?utf-8?B?NTdMaXVpVWNGUm14SU9Fam1LZUVqSStCVlJoY1lZQmY2MnVtd0gyMHJSUmJv?=
 =?utf-8?B?cHAyOWsyazZKVDhkcERUcWlWeFBrOHhqS1N1ay94UnFLUFcxZ3NYVE80Zllq?=
 =?utf-8?B?Y05JU3phT1BxZGJUZCtQWm95MUJsN20rRE9NVDJ0SUUxRng1MjRZTDRETXhQ?=
 =?utf-8?B?eWV6YWJueUdCY3Q2Ynlpb1Vvd0RvYVMrNTN2OGJXS2RzTktHOUNjbVFDL3V2?=
 =?utf-8?B?ZmkyaHE1Sk5WdmlwTGtMb05nNlBXS1U0cCtxRHVNSVhOZ3o4SStHR2ZRQTY4?=
 =?utf-8?B?YmpPUGJwNFFJNGRRSG5LZGVSVHo4ZTVGQmJvanBYTGtxOEVrTXNzVHdGRmJl?=
 =?utf-8?B?Wk9EOWc1TEZYSlFuTzhqWHdqZWNLdzMyM2xFcWJRaUdaeXJHUTVhQk1hcFln?=
 =?utf-8?B?ZVJaUkR4ODMwWmVpRndVZlUxMHVaTUtQZ21MVFRIeUpJeVdlSFVLZ2VReTNa?=
 =?utf-8?B?UnRTdlkzWHM0UU9VZURCNitadFQxMkxIWEYrVGV5UHZYb0dUakFXdTkvTEV6?=
 =?utf-8?B?SEVERk0rTS8yZEFXTEUxR3lYZkJOTmEzK0puaHBDQi84YjgybzdWRWM4bm8y?=
 =?utf-8?B?QVFjVUFIWllYRS9zTVNVN0xFNTYvOFlBQUgwaXBrQmJuOUZkZ1VVUEpKTWJl?=
 =?utf-8?B?YUlPR05oazBWbG9FUFBnRkt2YTR1a29jUUhTZVh5Uno0QU9teUpkUDdlQXVl?=
 =?utf-8?Q?xjIwyrvcNRPCF43kYWcffsxGT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d8ebd3-c916-4a3a-c472-08ddae3aba83
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6293.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 07:35:42.0144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9GbBU+U3F8Ua3O5RUd/SjYRLO72BWQlX8Tt+rlkak4hoyI69JV4U+pGHRX3QphdXULsZIxfz5BZrLNL+J7sKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6236
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



On 6/18/2025 1:44 AM, Alex Deucher wrote:
> On Tue, Jun 17, 2025 at 4:02 PM Sundararaju, Sathishkumar
> <sasundar@amd.com> wrote:
>> Hi Alex,
>>
>> On 6/17/2025 8:38 AM, Alex Deucher wrote:
>>> Use the new helpers to handle engine resets for VCN.
>>>
>>> Untested.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 24 ++++++++++++++++++++++++
>>>    1 file changed, 24 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>> index 9fb0d53805892..ec4d2ab75fc4d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
>>> @@ -110,6 +110,7 @@ static int vcn_v3_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
>>>                                 enum amd_powergating_state state);
>>>    static int vcn_v3_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
>>>                                   struct dpg_pause_state *new_state);
>>> +static int vcn_v3_0_reset(struct amdgpu_vcn_inst *vinst);
>>>
>>>    static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring);
>>>    static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
>>> @@ -289,6 +290,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>>>
>>>                if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>>>                        adev->vcn.inst[i].pause_dpg_mode = vcn_v3_0_pause_dpg_mode;
>>> +             adev->vcn.inst[i].reset = vcn_v3_0_reset;
>>>        }
>>>
>>>        if (amdgpu_sriov_vf(adev)) {
>>> @@ -1869,6 +1871,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_sw_ring_vm_funcs = {
>>>        .emit_wreg = vcn_dec_sw_ring_emit_wreg,
>>>        .emit_reg_wait = vcn_dec_sw_ring_emit_reg_wait,
>>>        .emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
>>> +     .reset = amdgpu_vcn_ring_reset,
>> You probably wanted to add reset callback to vcn_v3_0_enc_ring_vm_funcs
>> instead ofvcn_v3_0_dec_sw_ring_vm_funcs.
> I'll fix that up.
>
>> With that, the vcn and jpeg changes in this series are :-
>>
>> Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>> Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
> You mentioned that the start/stop sequence didn't work for some chips.
> What sequence should I use for those?
It is for vcn3 and vcn2 (non unified), I am testing on vcn3.
Your changes as it is, works for encode hang, but failed to reset decode 
hang on vcn3.
The workaround is (works for both dec and enc on vcn3) :-

vcn_v3_0_stop(vinst);
vcn_v3_0_enable_clock_gating(vinst);
vcn_v3_0_enable_static_power_gating(vinst);
vcn_v3_0_start(vinst);

If you are okay to add the workaround, that would be good, until we have 
the firmware
also handle this properly or clarify the requirements to reset the 
rings, even without it
it's a good first iteration to start, leave it your decision to add this 
or not.

Have also requested for a vcn2 machine from Lab, which I think will get 
by EOD,
I am hoping this works on vcn2 as well, since they are similar, will 
keep you updated of the result.

Regards,
Sathish
>
> Alex
>
>> Test exceptions: VCN/JPEG 4_0_3 and VCN/JPEG 5_0_1.
>>
>> Regards,
>> Sathish
>>
>>>    };
>>>
>>>    static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p,
>>> @@ -2033,6 +2036,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_ring_vm_funcs = {
>>>        .emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
>>>        .emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
>>>        .emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
>>> +     .reset = amdgpu_vcn_ring_reset,
>>>    };
>>>
>>>    /**
>>> @@ -2164,6 +2168,26 @@ static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev)
>>>        }
>>>    }
>>>
>>> +static int vcn_v3_0_reset(struct amdgpu_vcn_inst *vinst)
>>> +{
>>> +     int i, r;
>>> +
>>> +     vcn_v3_0_stop(vinst);
>>> +     vcn_v3_0_start(vinst);
>>> +     r = amdgpu_ring_test_ring(&vinst->ring_dec);
>>> +     if (r)
>>> +             return r;
>>> +     for (i = 0; i < vinst->num_enc_rings; i++) {
>>> +             r = amdgpu_ring_test_ring(&vinst->ring_enc[i]);
>>> +             if (r)
>>> +                     return r;
>>> +     }
>>> +     amdgpu_fence_driver_force_completion(&vinst->ring_dec);
>>> +     for (i = 0; i < vinst->num_enc_rings; i++)
>>> +             amdgpu_fence_driver_force_completion(&vinst->ring_enc[i]);
>>> +     return 0;
>>> +}
>>> +
>>>    static bool vcn_v3_0_is_idle(struct amdgpu_ip_block *ip_block)
>>>    {
>>>        struct amdgpu_device *adev = ip_block->adev;

