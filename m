Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCDFC369CB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 12:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44E8810E066;
	Wed, 23 Apr 2025 12:13:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BC1010E066
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 12:13:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clD1DrXnAwPUpWtwmQO05wtgj/YLX+jxA9XslUUF4x/x1Ei+/US46ZrFbYuZHFc2mQDIx2k97HZA7AdUDgqYpIu/32t/NKztcmghCRXr2Lyw4OU+BIDnYsmn4zHIcS/hhs4O9OwWhbQttuR9EZzMPW3JdSRbDGJb2SowCh4IA4yzo7O3xwpryOFOhTeNWCmS4vVsSmgUWKkOcmD5GwBbmTM15RRZEx7LN3dHIY4dYH406TF4XS7fk6iZ6JWSLyXusOGOTEAF/Z+8uCNe88REClVW9P4yueRZTBi8+miHE1kznYq6ZlvAYsghbaZS4EdVolNOG87Jkfg884uU/zruzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgJPsREsYM9hAKaUxlYuMhYMaoV28LPVj1VOxCFQTc0=;
 b=XBXgYsUiFuQBS0Mg3ikHQodasWVqiyKAKEAXHDPOFfg0E0NvV+A/pgxaSrQ/PhhoKDP7ROWYzbVfeeaks7jvLsBjMtlGerm+F0PeC6asAXqW12t6VqVsCQ+PSFNfXVORSWRPEaPraekGcGkp26x4zqU01yDj1BKatKLvxnW+ntCNHHbrUG8qa1Wvy/lGuzS34Uco6A0+sGTuDqnDbPfkAO1pOHBcA52WFB3dc6INiPbo33Kwp9Jh8T8LyB73ywnoe+obAv0SXNlCW5gZpIX9SE2G6O7jl05qM/cr3WVkXLQ2yRAJzATQBcPRVCf8PpWjql1n0ueiRWL37gBVppOcYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgJPsREsYM9hAKaUxlYuMhYMaoV28LPVj1VOxCFQTc0=;
 b=pRSnZJbbu/7ngmnqsxFI2ueCSDkd9GL/LD20lB1Ziec5VC0HH6bMQuzqPfXQoTd6DjyUEvMBreCvsRfaVdhiaW+48Y7qgcDyZgBWmJvbmXlxl/go7FMjtUzDj3k9bTMa1326ze9oYerx1nSAri1r3CNwvU+eGjBhWzi9rV9pU20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by PH8PR12MB6890.namprd12.prod.outlook.com (2603:10b6:510:1ca::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Wed, 23 Apr
 2025 12:13:30 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062%3]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 12:13:30 +0000
Message-ID: <b4a9ba33-ac0c-4261-9f46-4b2834b25409@amd.com>
Date: Wed, 23 Apr 2025 14:13:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: only keep most recent fence for each
 context
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Yadav, Arvind" <Arvind.Yadav@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250423104824.7014-1-Arvind.Yadav@amd.com>
 <BL1PR12MB57537BB48BF34E8946B1DCC693BA2@BL1PR12MB5753.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <BL1PR12MB57537BB48BF34E8946B1DCC693BA2@BL1PR12MB5753.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0273.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|PH8PR12MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 030ceba0-7d23-4989-ad15-08dd82603671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjhiV2QzRVhmMS9paFRQbHA1K29MVkJYSGlTYlArQ2dlNENXMCtWWWYrbmhv?=
 =?utf-8?B?R0VCWlpvazhNQ25kdi84TjNvc1J5ZStML2s4TkRHaVBmRVNOdUxCd3lDbjRB?=
 =?utf-8?B?SjdEL1RKTm90a0pQN2JmSHVsRGRISlZLWUdlRkE4U2kvQkVYc2dIVGdBWkdn?=
 =?utf-8?B?ajh0TEFPLzYwSnc5VTNQdUJzUnNSRnB5SHVaemJoT3ExUjhLOFBjbktWNjRp?=
 =?utf-8?B?TzRFQlplZStFSTZzdXh1aWFlcnByOGhFYys4MnYzcDZGSFdkWWtkWU94Qnd1?=
 =?utf-8?B?UkdEUEJYVWtKNW12Sk5yaTNsVit5VkpwT3czU05zY1VqR3FkWHRCNzl5WGt3?=
 =?utf-8?B?c0k4c3haQ1JzWUdOVG95QlFmb0tLTERzd2xGZmNLY2dDMXNIejRvckNGbHBh?=
 =?utf-8?B?MUxCSkJwNXlMbGM3K0hPU0lNMnR3UWhYOGlZNDNnUXRoTSt4TmRUQjdWNEl0?=
 =?utf-8?B?QTRMeVFIYXZJWFJ0ZmZZNkRMYnpRV0tnQmRKNkJ4QzlBVWpINjhEMGFQSWlW?=
 =?utf-8?B?bURySHExWG16L2pZZmlROGZvb01QOEZOQVhSZ0wxN09jVmJPdmJCUGRiNUt5?=
 =?utf-8?B?WEE1Z3llMWlOWUU4WXhHalNsYnkySHhPQi9lRnNpUmtpTzAwOWNHb0hXcytu?=
 =?utf-8?B?bGNPZXlTT1c4L1hNZUxSWHVKVnc5MWo2Q0xKeTZPdUhyeExacVk2SUZLYkYr?=
 =?utf-8?B?WHRpUi9vL3gyYzdwM0IxQXFhYzhiWjNvNTRZUnNEMUlOYVNXNHlTamlxT0pQ?=
 =?utf-8?B?WXBmRkdIMTNCUlhLdkpJa3dpYUJKMHJWMHY1dzF1MG1HVDdYZ1U5Q25SWFNw?=
 =?utf-8?B?d1F6TFBZbitNY294Wm5sQnJ3WU5sTzdYazNsSWRmUnozcnYxVlBLS0dQUHZZ?=
 =?utf-8?B?VDFxZmNKTy9xdzB1WnR1QUVpeVZLN2puaEVCZmowL0FqK2VGWFVZK1BDM0lF?=
 =?utf-8?B?SWdaY3krMzF1RjV0dVRsOWF0YUtxbG1GRFRGeGdUc0dlTGIwZ085NExDdk9s?=
 =?utf-8?B?N2hKdDJSTjMwWWRkNTIrTmdGNzN1VlZReEhRVnpxUlNqaXBsTk5US1JsL2hR?=
 =?utf-8?B?MjA5Tkl0UkFPbWpubTdSVU1GdC96bjMwZTVRdE5SZ3c3b2czWHJvWUtBY3pG?=
 =?utf-8?B?YlF5MTNPZjRkWlBuejlVTm9LUDFTQzByNWtRTjNSNmZNdXkxSFFTSGpvbE1P?=
 =?utf-8?B?WWpNUjNtV2JsRDJQemxtV25GMG91YzNOUjVZU2NXczlUOE1ET2lYdWpuaU81?=
 =?utf-8?B?eDEzVjc3S1JDWnFRQ3gzcjg3dk43T1d1T1Y0Y3JnOG81endPWDBGT1pvWDZU?=
 =?utf-8?B?dnlndlZ3bmFaZUVpYkNxU1VWN2ZCK01naUU5NnN3TWhCNEtFbExEMk54azJt?=
 =?utf-8?B?eTRIWHNjUXU0WTZMZ09hTHlMY0RaZ3JSZ2lGazZ4b2R5RFpTNFlWVk9UNUpX?=
 =?utf-8?B?dFhaWUdqNmRBYnJRMDZPZEhyT2dMOUVkZTNiQjZBVFIxTmtHYkhoaUp3SDJ6?=
 =?utf-8?B?WGFpcXpscDJrZFpJSGFEUVByK1Yzem5pdkFsWld2Y2JWWXRWZFNtN0pXMDRR?=
 =?utf-8?B?bTdoSGpiWk9Zci9ZdE5kTWkxSnc4Nkh5SG04OWUwSG9VS21kOGFZV2NNRTdv?=
 =?utf-8?B?QkM1QVJUVVVkcXFRaEtoQktOWTBEVVVOYi9Ka2YzSWQ4aU54am8yaFlrMy9y?=
 =?utf-8?B?TVlpNFZac1p5TG1JVEc2cmFBNUNidzNDVDdMempsT21oRC9IVXFMSi9Pb3pt?=
 =?utf-8?B?SDZ5L3BiQVB6Ny9jTnpReFFQYlYwOGpER2JoVTUyMHJKTDRpcWkrSDFkeEl0?=
 =?utf-8?B?RUdsdHRhWmJ0Y2NmSXpWRTVBZUdZZWlJYWtuZEpnQ3BLMEdxVjZKSlMzVENT?=
 =?utf-8?B?MTBUeHhESnRnUWJxcTNzR09HaE9wWmMrQklmSXI4b1IxSCtaanYrYytSU3Z2?=
 =?utf-8?Q?BTzbq7RA5tM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVh2eDJLUkpXZ0RoQWo5ZTBXekFWTlFGVmNBdjc1U0RsaCt6K0NKWUsweHdh?=
 =?utf-8?B?aWdUSEpnOHcxWHV2RHZ3cmdSTk4wYWJDR2ZqcG9Qemk4L2VyWFBONVAxblIy?=
 =?utf-8?B?Nld1NE1nQkYyNlZoMitrTm9TQ2hhNS9ISTcxVnZwMlhlME1wb1VMbDJFVnRZ?=
 =?utf-8?B?ME0zM2pSVXFnSlBuQS9HNEZFMVJuVllKbDFqeENoemdXVkZGWHBXaGxYc2hk?=
 =?utf-8?B?ckJld0dsOHNVUnk3ckZaWFlzQzA0M052Nndudnl0WjZPVXB0cjNERFhIUWZ6?=
 =?utf-8?B?YU02QXcvMUprNVdteEM0eXZ6Y2Y1eEdDTTNNalFTNnhRUFNhMHZJSWV3aEl2?=
 =?utf-8?B?RVRaUFZ2ajd6aHEveDcvbmp3NmRJUHdVSzdFcHhaNWlnQUFCbG1yM2dFMTJk?=
 =?utf-8?B?bkY1ZjRVbnVUd3ZTYWI3RHNmMERrcHlLVDlOZDJFamVjV044YytZSStPeW8y?=
 =?utf-8?B?dlphNDN4cy9TOVRJL21kYWkxdGpNUzQwS1d0RFVUS3AvTmRsZUY5RmpyYXFu?=
 =?utf-8?B?UlJEWk5JMFRLK3E5VGJJa2VNRVdHV0J3VEl0c1c4NlZLWlNEUGEzRGJIbFlD?=
 =?utf-8?B?aDREd1p2NzEzOG5pTWVIcjk4SFpMVFJYMEhCMVlTcmtQRXBUUDJ4clRwRFov?=
 =?utf-8?B?MFhYODFEcndqQ2I3UUpxT3BDUk5ENEhGeVU5Q1k0NzZNVFVUSndPZ1JoRlRP?=
 =?utf-8?B?OTBNbWdITUdYWE8wYnJvUWhEb3hGTnV1ZGs1TzN5UVF6N0gzYURRVS82eitL?=
 =?utf-8?B?VTJhaXdEMWdqODdMbEtNU0I0eG1KcUVKRWowQlpZNmFEVWJyTTh3VEdPRjZK?=
 =?utf-8?B?UFhyK2w2TjNOU21taUlDWjdQU1NBMnRVVjhaclg2RWdEUzV3dWVqMnQ0R3JZ?=
 =?utf-8?B?TkZxZnJrenNQSXpvbGtqbGxVc3FFL283TkdYd3BiSEdScis4SUdtUFNzOWhP?=
 =?utf-8?B?a09rOEZkSFIyczBwaG5GU0NxOEYwWUJhTVc1VG9VaFdrbEEzaXg0SElmMWRl?=
 =?utf-8?B?dnNqOEZzY0ZKNlhPSEN4SkF6TnZKckQ4MnBjL0s2UGwvOTJ1dGdyZEUzRkpL?=
 =?utf-8?B?bjJMU2g2RjZLdHhSMGd6N0lHdzkwWDRxaTlzdHd1ZmJQczE1aFl6cGRXRU1F?=
 =?utf-8?B?em1waHp2Vy9SdHR5V01VbS9sbzBQakZPa3g4UDF4WHlKN3lvT0NPLzRnUE9q?=
 =?utf-8?B?NitjK2pCRlB0SHpFemc3cjVUS3VLTWZoZ2lhRlgzYlNjT1ZPa2t6eEdoNkZ4?=
 =?utf-8?B?RlZIWDgwUTB2NFpmR0xwRHp4UG91MERianQrTzJKdkVkbDRwc2h1R0szZHRr?=
 =?utf-8?B?VHVYbGhlQS9JVmtubXQ5WGxjdVlJWmM3TU41cHAyMGJ2Q2pvaFpaQUZkQ2hy?=
 =?utf-8?B?dDIrdE5ENis3M3RjVVUvemVaZ2hLNHdBeGo1OFdwMTYwY3RBU0dmVkxzRHEz?=
 =?utf-8?B?WDd0QzdUbGhzak0wc0VPcS80VWI5aUcvRWN4eUhqRWpxT2Z2N3NtQXJWbjVR?=
 =?utf-8?B?TkFMKzFiUCtRcXppaDhndmwxZ2g4SGdmQ21NVGNtcFFYTmh5R2NRK2FhOFB4?=
 =?utf-8?B?My85L0ZOODA0bUZQbVpWZmJjdHNpQk5lNXJMUzlrYXJMUEpyYi91MlkwVWdt?=
 =?utf-8?B?eHRMK3B6S3Rzc1NLV0hpb2EranVuOG9PVWJaUWZRL0RHZ2Y5N3FiZmQvUTZy?=
 =?utf-8?B?Q2NsK1ZocC9XMnRTUkxXVnZKRFlyVHhDaDcvazNZOTFKUDlLUElnNlVCcytG?=
 =?utf-8?B?ekZOSTVhSnhmd25aUGZrR2VMMDhwNlEvMHpOMFBmSFZNM2FkUjVybkJ2TDJ0?=
 =?utf-8?B?VEJvTVZNNnNoNFM0Z1BWa1J6NHR5NzZzMDluMUhXcnBUUnBqT3AwU3NFNnRT?=
 =?utf-8?B?V0szYmJtdWxGZ0daRkN0ZXJFYmpURW5wTm5KZkJ4c3FKUlczQ3hBRW8yZVdz?=
 =?utf-8?B?V01mZ0JOWURQVGxNMngrUEhneUMzSDB3dkxMdmlqSlVuKytsc3pTbCtOdjlY?=
 =?utf-8?B?Wi8rYTJBUEpkNlVnMC9RdmhtSXB5YmFmU1pzYlpmL2w2NXVCdWJMbGU3VUlE?=
 =?utf-8?B?WThaZ1NlQmdta2JOTDljUlBRYWlkTmduWmRsSnExUGhmYnZXV2g5RitzZ0Jy?=
 =?utf-8?Q?TArkUmsZqgatzjTDMdVGjhqgA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030ceba0-7d23-4989-ad15-08dd82603671
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 12:13:30.3347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQUyC5QUfUeEmec+UDQ/T8BJ5cbFzuQ53PwK5RoK9r8f94g5RCiN39Z2CrLZjLZZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6890
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

On 4/23/25 12:52, Khatri, Sunil wrote:

> [AMD Official Use Only - AMD Internal Distribution Only]
>
> You need to split this in a dma_buf patch and amd userq patch separately.

Yeah agree, and the dma_buf patch should re-use and re-structure the 
existing code and not just add a new function.


Regards,
Christian.
>
> Regards
> Sunil Khatri
>
> -----Original Message-----
> From: Yadav, Arvind <Arvind.Yadav@amd.com>
> Sent: Wednesday, April 23, 2025 4:18 PM
> To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Yadav, Arvind <Arvind.Yadav@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Yadav, Arvind <Arvind.Yadav@amd.com>
> Subject: [PATCH v2] drm/amdgpu: only keep most recent fence for each context
>
> Mesa passes shared bo, fence syncobj to userq_ioctl.
> There can be duplicates here or some fences that are old.
> This patch is remove duplicates fence and only keep the most recent fence for each context.
>
> v2: Export this code from dma-fence-unwrap.c(by Christian).
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>   drivers/dma-buf/dma-fence-unwrap.c            | 29 +++++++++++++++++++
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  2 ++
>   include/linux/dma-fence-unwrap.h              |  3 ++
>   3 files changed, 34 insertions(+)
>
> diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fence-unwrap.c
> index 2a059ac0ed27..18874eedf091 100644
> --- a/drivers/dma-buf/dma-fence-unwrap.c
> +++ b/drivers/dma-buf/dma-fence-unwrap.c
> @@ -179,3 +179,32 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
>          return tmp;
>   }
>   EXPORT_SYMBOL_GPL(__dma_fence_unwrap_merge);
> +
> +/**
> + * dma_fence_shrink_array - return the shrink fences from fence
> +containers
> + * @fences: array of fence
> + * @num_fences: number of fence in fence array @fences
> + *
> + * only keep most recent fence for each context. It will remove
> +duplicate
> + * and old fence of same context.
> + */
> +unsigned short dma_fence_shrink_array(struct dma_fence **fences,
> +                                     unsigned short num_fences)
> +{
> +       unsigned short count = 0;
> +
> +       if (num_fences <= 1)
> +               return num_fences;
> +
> +       sort(fences, num_fences, sizeof(*fences), fence_cmp, NULL);
> +
> +       for (int i = 1; i < num_fences; i++) {
> +               if (fences[i]->context == fences[count]->context)
> +                       dma_fence_put(fences[i]);
> +               else
> +                       fences[++count] = fences[i];
> +       }
> +
> +       return ++count;
> +}
> +EXPORT_SYMBOL_GPL(dma_fence_shrink_array);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 3288c2ff692e..cc74bb0ed06f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -851,6 +851,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>                          fences[num_fences++] = fence;
>                  }
>
> +               num_fences = dma_fence_shrink_array(fences, num_fences);
> +
>                  waitq = idr_find(&userq_mgr->userq_idr, wait_info->waitq_id);
>                  if (!waitq)
>                          goto free_fences;
> diff --git a/include/linux/dma-fence-unwrap.h b/include/linux/dma-fence-unwrap.h
> index 66b1e56fbb81..94801feeee4b 100644
> --- a/include/linux/dma-fence-unwrap.h
> +++ b/include/linux/dma-fence-unwrap.h
> @@ -72,4 +72,7 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
>                  __dma_fence_unwrap_merge(ARRAY_SIZE(__f), __f, __c);    \
>          })
>
> +
> +unsigned short dma_fence_shrink_array(struct dma_fence **fences,
> +                                     unsigned short num_fences);
>   #endif
> --
> 2.34.1
>
