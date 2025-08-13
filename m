Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DE4CA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 23:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2CB210E7DB;
	Wed, 13 Aug 2025 23:06:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pTtE98Xn";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1D3B10E7DB
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 23:06:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aiRZ5ehiwa0ZFlizHCtitEsA1tpW2yWr3d5D49+CU51txLC7/2Y9aFiG7xxeuZ2PmuGgzLMEDCqXIG+4yqVRsvUUkSUDHasu82ueOrWJnF1wR4RtXEDjshSyDKidP14+cVe2EXRdrnP30RazETu2GCA3WqQ0x+kknsFYgN89TusHxjnNiz4C3N1orOMizX2bliTdeiGoV5IQeDx/+Zw/FZ3NUs7dmxvkRzfvQobtFgCCrRw3uUhsoRb1H8WJJOC0gdkT7dUVUL6A7YyZQec+WWsGfZfEFS2rRhYeKX2uG7MEwB0GzX76ZYw2+ww799vkZp5uANtlXdLq0/fkGxPd4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1q022C7ykFSkjO2j34YIVg8hs2unAQFrnMlWhkb31U=;
 b=eMmPETq5RANWub07FfK+yrQ5rJnJOgbBC/dD1BMNKSkNkUb5BJBUwgftabi3H24hmdwQP7V2Cht8oSms+6BrYWN3/hGHeEzDNTNyKXpgiL+fu+23+0WwWHvDG63qvIYs1aYBhElW3d7ccor1whygOWx6gqZmNkVc2wN6sp17N5oMXTmmJHpv+HEUHyaRU31Gi0E2ucRgOSjadeKbU4Vio5bwBkt3JoKCgBUeNFKNhnlOObCMrLnbAcKLhJ045bimAWtfE29YwERxMzT0WeEFsbSmJoeFFpbWVa1Y+QZ7v+pGBEGsq12wTsS+EcMJvOxr2p7aDLUoJ6RIE+u3TwXcUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1q022C7ykFSkjO2j34YIVg8hs2unAQFrnMlWhkb31U=;
 b=pTtE98XnJEVlTP36p+7XyI8h1zJ10dx50eudcQwuWuDXUmXSj6YgyXTljTWjq8hD+AfI//YM6UB9MUpwFxO1+L0HAv2AqxFK4KvF+DD+AHI5uoFQqUWRTgmh4bhVeIyJdPYN2NHuHbSSEUsCwbmF22X/hlSLCP1I+gURierUAIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 23:06:53 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.8989.018; Wed, 13 Aug 2025
 23:06:53 +0000
Message-ID: <ad01beb5-e17c-4ace-8707-4cd5f52de2c8@amd.com>
Date: Wed, 13 Aug 2025 19:06:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: fix video profile race condition (v3)
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250813134504.2037516-1-alexander.deucher@amd.com>
 <ae769200-c37e-426b-b73a-ac9473cf66eb@amd.com>
 <CADnq5_MbT-4Q4HfQ15AWMNGu6hct2=Yu5K5+F6qMGWDC6H_ojg@mail.gmail.com>
 <faee7074-f3bd-4791-b3f0-fe409049de06@amd.com>
 <dc8beb3b-789c-03c1-1c37-50c998b7e44a@amd.com>
 <CADnq5_MJouzU1QFsuuMtiXeFAHi96zXfBzuAWFAvfauHssw_eg@mail.gmail.com>
 <1633c024-a1dc-cdc3-6a28-c48b49640297@amd.com>
 <CADnq5_P7OWj6GLi+qzZ_EVZAK5dPiOrjmvV9CRqRG+iFtcq78Q@mail.gmail.com>
 <85af1027-5a09-40ce-987e-9f4ad8fe2b5c@amd.com>
 <CADnq5_O2gnR8GtAaL-937R97Kwtb50QNh+Y3V_TzsLGLbT8CLQ@mail.gmail.com>
Content-Language: en-US
From: "Wu, David" <davidwu2@amd.com>
In-Reply-To: <CADnq5_O2gnR8GtAaL-937R97Kwtb50QNh+Y3V_TzsLGLbT8CLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::16) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8613ee-4938-4ad6-62aa-08dddabe175f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WThseEFnV3V1VjRWa1NPWUQ4QnIzS0Z5MWEyTjdiNEhMYnY3QjlJY2dlL0JF?=
 =?utf-8?B?K3FpaGxrSHFNeTdhNXUyZ2t6K20rMVZGVzBmaHFINUxIby9yM1RaRFVNbmIz?=
 =?utf-8?B?WXRKK2FaR2swSTdnRUVuOEl6cmg4UHNkc2ZmOGpkV1FBQ1d2dmdkd05tc01z?=
 =?utf-8?B?RGFocGVSZFdYSzRqdklCbWcrWWo1ZHZXZUpSRklIWHZIa1Fib2RPZi8xdW45?=
 =?utf-8?B?TzE0T0tPZ0Z2UjNXTEwwbmFvRWQzNG9TQkIyd2gvZ3krUE91V0U3T0ZwZHh4?=
 =?utf-8?B?cXFMK2thNXpzbm56WmVYaDljQ0YrOHp1VHNlNDhIRVRaVlY1cjRTVEhHcG5j?=
 =?utf-8?B?UEgwSjdhdEdXSytIS3lWbERqZzBvMkxidlFMa0xXdmlUR0QwSnFMN0xRTzNq?=
 =?utf-8?B?Sk9sY04xTUhyS1lDRW4vV2lKR0hVcGd1U1FLQk5KS3J5T3d5VDBPY0cvQS9Q?=
 =?utf-8?B?WkU2QzcvVEgvTXJKQVhSd2psbUNySlpreFRyQ1NWZytwcG9MN3l5SkdPci9K?=
 =?utf-8?B?RUVtNHYrRWJ2aWEvamdvak1MRCtFNTNnOTg3UXo4ODJmSmJsdUprZStKc3JD?=
 =?utf-8?B?SEZXT21wM3pYeGxGeXpLbk9IUWtuMGNDZ00yMVQ5T0duNVo3UVdVNnJjOG9J?=
 =?utf-8?B?Z0g1d2NySkZWZFhmcE1lOXRKTTZnanZMTkRRcnVqVENtQllrcE1pMnpyT0s5?=
 =?utf-8?B?Y1pIMTlyWnBOd1NxMk1uUVk3Rk0wS2NCN3JmVVArRkNHNWxkZ2FuSFJoSU1G?=
 =?utf-8?B?c1c5N3M4K0x1WGZYZUdQWUZoN0pzT2RHR2gxUit2QkRZTk45RGYwcHVvUUFV?=
 =?utf-8?B?OTl6NGNLUTRFc0p4QzdLNDlHYS9rY0pNUk0vS0pGWHpZWTYwNjFEQy9UUzVZ?=
 =?utf-8?B?OWlrbFRUL2h1aU1OYytrNlRhYm10UkxEUVJCd1JCbUhTZUlNWERBZEtZYmVZ?=
 =?utf-8?B?ZGJvTGhibmdubGNBRmdOU0tXcWgyR2NsR1o1cWZyeGc3SGxra2pIT0VrUUho?=
 =?utf-8?B?TFhTcWdtYldqektsV21iZGl4OHFrR0FxWWxEN3dDdTREaksyMHR4T2p3L1JC?=
 =?utf-8?B?VzR5ZVYzUi9HbWppcEpURnZ5TGhERC83N1hiL1V6SnF6VFJFeTJGbjFLMWRR?=
 =?utf-8?B?NmhYZTR3OTVldE1HK2IrcXhGTk82VGVjTTl4U1lmVThBN1FiWWdWZ29PVllC?=
 =?utf-8?B?RVkvL0k3WG9hNU9NQUp3Z3lWaU9oWC9hcWloV0NnQ1JhS3lyK08vdVIrSXB1?=
 =?utf-8?B?eW1MQm1oWWk2V1F1eW1Ob0d0R0NIZDV4d25vUWZnN0l4Wk9LN2xCbmc1Smds?=
 =?utf-8?B?bEJBOHdHRmVKbzJaMnBSa0o0Q3BSVW9rQXFkamlyU3dadEZRVFRYNS9CalpM?=
 =?utf-8?B?WjNaWFZPbGhwM2poZ1lDOEpOejNMUDNwSkwreEp4RXpZdmR6cmYrT01CQUhi?=
 =?utf-8?B?T2RGaXdOTHBvUTlJMUZ6ODhpLzVuT2lzT0F2TkxsdmovMzlkWnhLRmx0MVky?=
 =?utf-8?B?UkNvUGZFd1QyL1FqcHpLU1U4L1NwaTRaWVZrQmljQk1oVm84NmhieG9hd2dG?=
 =?utf-8?B?eTVIZ2NKQU9kVUNCRjdjaFVPYmY0S1lCSHJoOW9KMlgxUy8ybVlrMmo5L1VB?=
 =?utf-8?B?VzV0dXVCc2dCQWRGQzErZDVvMnVtWDJaMFoyVEtBSWpvelJFekZyb3dVQUEx?=
 =?utf-8?B?VWhORUpROE9QQnc2b0xmMjIwQWFoOUV4VzJsYzBwcGY2MEdMYlp2ZHQzaXQ5?=
 =?utf-8?B?WHo0ZzVUdm9FV2xGakYxM1JOZjhIU1QwMGREakxoeGhMTEZjR0phYlRWU1JB?=
 =?utf-8?B?bmdraEo3NzhlZWNpVHQrZDd0dC9MR0VlZnJYRmtnR21aakFkYWFMdVlwQVho?=
 =?utf-8?B?QkRYdWNCWThVc3p3ekZkSkQrbjhyT0R6YkUrNTZJUmJhODE2NndwZ1VkSU9T?=
 =?utf-8?Q?nJZ0bfi70eY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmVlSU54MzNDZ2I0UVc5TDUySnNLM3JwSzVlY0ZMZDkrS3I0UnhIekFIL0VQ?=
 =?utf-8?B?Njd6WnVueDZnU045L1ZsYkgybTVnQ05UOEhIbGdvbXNsVlEzY3BubU04eTVG?=
 =?utf-8?B?a1JaZC9VYlBsRG5POFlRZ2t5bHFGL2FYN3doN1BGanBKTGcycno3RFRqSW43?=
 =?utf-8?B?dzJ3M1hyaVcxUjc0ZWswNUduQkw2VWR6K0Z6K2VvZXBJcmMweEFvMTZGL3Zp?=
 =?utf-8?B?dmdOT1g2MTkrd3g3YWlKMkNOQlRqaXBKMFViSG1KcG10eE5kSm9EaEhMUE1D?=
 =?utf-8?B?ZEFwQ1VMUERhSGtoekk4NXNwc2ZvZFhzZE1BdmMrSWVnZHNjOHVLSlVIREk5?=
 =?utf-8?B?RkVudnpVbHE0TlkzOC9WY0xWNVdzcWdaUmxRcGxGd0V3QURHdTgzN3VkVHFE?=
 =?utf-8?B?V0lOMUlidkJjVHlGY1ZkUGJTTmYvQ1BqYW5RTlhsWENzd25FMmlWSGwvS2pr?=
 =?utf-8?B?bkwwbGd4TUwyU2RCYmhsQTZ5aDRMbUFLdU5iN0d3OWEwanpNcmwxU0pqWDIz?=
 =?utf-8?B?eXFmcTgvYUs5WnpGRkJvOEZyNlBuUHhKL3RGVmlHWGRqMTRSOTVtaU1mVlQ0?=
 =?utf-8?B?L1ZmZkdzb3dhTFF1NUI4NkRTYitoSFhROWJEdnlkcWVQZzhRZ216UEw5YVJX?=
 =?utf-8?B?aDB1dWFCeGxCUmdzcnNVMUFVeS9vc0tyeGJuZ0c3Ulp0RjlGVS9sU0pwNGdn?=
 =?utf-8?B?SjBkcmowZFBLbVpkOURlTkNnb3dnWDZ1ciswaExLOG5KVjlHNnhKc1ZNYUVl?=
 =?utf-8?B?TC9uU2xiVXFtb0JXY1FIYWhnSENycEdqSWEwbTNqK0o1V3FhR000SU5oWjJ6?=
 =?utf-8?B?M01NRGVwSTVQRjUrNy8xeC8yMGRGclloTGwzb0IrSkFkcmhBZ2dIRGR2TWFq?=
 =?utf-8?B?S3ZYdDRpREd3Vmlmd250NVoxNzZXVFpINFdyYkhTbUVRcG9TSTNqMm1id3BE?=
 =?utf-8?B?eHg1ODlTL204VzFIc0l2cTN2Njh6L0t5dm92RUxoTnltVGRVallvUWUyN1dI?=
 =?utf-8?B?VW9RcHFjNysxVDltYXdNdXFydWhiY1dmVWZwRlFFWWczOEFQSVUwbEczdkU2?=
 =?utf-8?B?QkhzNkR6N0cyUVZWVFU2dlJHa2FrRkJucDA1QVI2clo5bVBrRURFU3NMTjVn?=
 =?utf-8?B?TklOT2JmQTdFdnBwMnlZMFEwMUkzQnd0ZXRwT2xnK3VSemRtL1k0TjVRVURp?=
 =?utf-8?B?ZzZ1ZWx2aW5uQjExeU1odktna0FmNVljSzNvVkp6Um0wQXYvMEhHc0FhbU41?=
 =?utf-8?B?Um9kVEtwSTU0bURVOVJwN05sMUlJTFdkVTZKelZ0UmlHakgvRjBHcUFObjNM?=
 =?utf-8?B?RVNtanQ4ZjFra0s0aHNEazFRUGF5TzR2YkdDdENQZ0c2UEl6dTVZQVg3ZjBP?=
 =?utf-8?B?VzBySmZsZEFKNDFaUzlRUlcvZEtMRVMxb0pXVWNTQzF1d1F0NTMwMkFNMjY2?=
 =?utf-8?B?ZnpoRUZsbHRKTmVkK2Z0bk1ib0g5eGliYWM2R2YzdzRoNmltazJSVnphTXFz?=
 =?utf-8?B?TUpYRjBneGdkbjJOTGZuS3FQU0pmSTNmS1JqNTB1eDEzeC9VTDgwVHlKY0xv?=
 =?utf-8?B?V2FhR3VIQ3pVc3pUbmxRcVd5NmZydENucnVhbmU0dmhTOE95TE9FQU5TTzB4?=
 =?utf-8?B?d1ZSU2p0VFNzdDBWL2xYSE5yV1Y2RnBjSTZtcHVyU0pWZGVJWm1UQjFydkxO?=
 =?utf-8?B?ejVJYnAwTzJDcFlCVURxNitNQzd2aVhsL3dBRWlCMFRqd05vcFpkMFpTTjJj?=
 =?utf-8?B?eVhIbXg0UTA3SUZENlRGZ2U4MlZ1V3k3aEc0LzNuRHJkQTVnS2h4d2FnRE02?=
 =?utf-8?B?dFBCU09HZk9wbEdRZnNwRnpEbEpaSGxlT2c1SFBGT2NjVjRqcGRqLzBCR0RU?=
 =?utf-8?B?UUR6MzdzL3Q0VStjcGdWTFlqQURGUVk5U2VtNG1IdjVwTUJ3ZFk1VGxQNjFQ?=
 =?utf-8?B?UTIya1FTeUxaSDlLNlB0RSsycUlacnlxWENDQWxFWnAwRDV4Z0lFRnpXMUNw?=
 =?utf-8?B?Q09qT3JNZitSamx6VEdFQnpRUDhPZW9sdWREV3NUSThkckRSQy9iSEZ6Y083?=
 =?utf-8?B?VURJem9WOTkvN3g0ZC9PUng2RkVDaHJqUTBmUDJ0TUZ2Y2p0cmRLMzZTdU9w?=
 =?utf-8?Q?GPJSFFz1Um/3e8/b78vlwK6k7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8613ee-4938-4ad6-62aa-08dddabe175f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:06:52.9801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOqC8pTiJjrpq5QSI6rPwKQZRnM6vZQA1rIdn5yGQZwhMtecKX/0kmh56iVBwFsCGUj9Jx2oNF8pzaUS4ey6SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139
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

On 8/13/2025 6:11 PM, Alex Deucher wrote:
> On Wed, Aug 13, 2025 at 5:47 PM Wu, David <davidwu2@amd.com> wrote:
>> On 8/13/2025 5:03 PM, Alex Deucher wrote:
>>> On Wed, Aug 13, 2025 at 4:58 PM Sundararaju, Sathishkumar
>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>> On 8/14/2025 1:35 AM, Alex Deucher wrote:
>>>>> On Wed, Aug 13, 2025 at 2:23 PM Sundararaju, Sathishkumar
>>>>> <sathishkumar.sundararaju@amd.com> wrote:
>>>>>> Hi Alex, Hi David,
>>>>>>
>>>>>> I see David's concern but his suggestion yet wont solve the problem,
>>>>>> neither the current form , reason :-
>>>>>>
>>>>>> The emitted fence count and total submission count are fast transients
>>>>>> which frequently become 0 in between video decodes (between jobs) even
>>>>>> with the atomics and locks there can be a switch of video power profile,
>>>>>> in the current form of patch that window is minimized, but still can
>>>>>> happen if stress tested. But power state of any instance becoming zero
>>>>> Can you explain how this can happen?  I'm not seeing it.
>>>> Consider this situation, inst0 and inst1 actively decoding, inst0 decode
>>>> completes, delayed idle work starts.
>>>> inst0 idle handler can read 0 total fences and 0 total submission count,
>>>> even if inst1 is actively decoding,
>>>> that's between the jobs,
>>>>     - as begin_use increaments vcn.total_submission_cnt and end_use
>>>> decreaments vcn.total_submission_cnt that can be 0.
>>>>     - if outstanding fences are cleared and no new emitted fence, between
>>>> jobs , can be 0.
>>>>     - both of the above conditions do not mean video decode is complete on
>>>> inst1, it is actively decoding.
>>> How can there be active decoding without an outstanding fence?  In
>>> that case, total_fences (fences from both instances) would be non-0.
>> I think it should be non-0.
>> I do see a hiccup possible - i.e the power switching from ON to OFF then
>> ON in the
>> middle of decoding, i.e inst0 idle handler turns it off then inst1 turns
>> it on.
> How would that happen? As long as there submission cnt is non-0 and
> there are outstanding fences on any instance, the video profile will
> stay active.
there could be no jobs but it doesn't timeout yet and new jobs will come in
any ms - note all fences are done at this time. The idle handler sees no 
fences
and no jobs so it turns off the power - but just ms later a new job is 
submitted
from the same decode session which could be mpv player as it does not 
need to
submit jobs without delays. This will turn on the power.
David
> Alex
>
>> We should avoid this glitch. This requires the idle handler sets/clears
>> a flag for
>> done for this instance as Sathish's original patch. When all instances
>> set/clear the
>> flag then we can safely power off.
>> David
>>> Alex
>>>
>>>> Whereas if instances are powered off we are sure idle time is past and
>>>> it is powered off, no possible way of
>>>> active video decode, when all instances are off we can safely assume no
>>>> active decode and global lock protects
>>>> it against new begin_use on any instance. But the only distant concern
>>>> is global common locks w.r.t perf, but we
>>>> are already having a global workprofile mutex , so there shouldn't be
>>>> any drop in perf, with just one single
>>>> global lock for all instances.
>>>>
>>>> Just sending out a patch with this fix, will leave it to you to decide
>>>> the right method. If you think outstanding total fences
>>>> can never be 0 during decode, then your previous version (v3) itself is
>>>> good, there is no real benefit of splitting the handlers as such.
>>>>
>>>> Regards,
>>>> Sathish
>>>>> If it is possible, maybe it would be easier to just split the profile
>>>>> and powergating into separate handlers.  The profile one would be
>>>>> global and the powergating one would be per instance.  See the
>>>>> attached patches.
>>>>>
>>>>> Alex
>>>>>
>>>>>> can be a sure shot indication of break in a video decode, the mistake in
>>>>>> my patch was using per instance mutex, I should have used a common
>>>>>> global mutex, then that covers the situation David is trying to bring out.
>>>>>>
>>>>>> Using one global vcn.pg_lock for idle and begin_use and using flags to
>>>>>> track power state could help us totally avoid this situation.
>>>>>>
>>>>>> Regards,
>>>>>>
>>>>>> Sathish
>>>>>>
>>>>>> On 8/13/2025 11:46 PM, Wu, David wrote:
>>>>>>> On 8/13/2025 12:51 PM, Alex Deucher wrote:
>>>>>>>> On Wed, Aug 13, 2025 at 12:39 PM Wu, David <davidwu2@amd.com> wrote:
>>>>>>>>> Hi Alex,
>>>>>>>>>
>>>>>>>>> The addition of  total_submission_cnt should work - in that
>>>>>>>>> it is unlikely to have a context switch right after the begin_use().
>>>>>>>>> The suggestion of moving it inside the lock (which I prefer in case
>>>>>>>>> someone
>>>>>>>>> adds more before the lock and not reviewed thoroughly)
>>>>>>>>>       - up to you to decide.
>>>>>>>>>
>>>>>>>>> Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> David
>>>>>>>>> On 8/13/2025 9:45 AM, Alex Deucher wrote:
>>>>>>>>>> If there are multiple instances of the VCN running,
>>>>>>>>>> we may end up switching the video profile while another
>>>>>>>>>> instance is active because we only take into account
>>>>>>>>>> the current instance's submissions.  Look at all
>>>>>>>>>> outstanding fences for the video profile.
>>>>>>>>>>
>>>>>>>>>> v2: drop early exit in begin_use()
>>>>>>>>>> v3: handle possible race between begin_use() work handler
>>>>>>>>>>
>>>>>>>>>> Fixes: 3b669df92c85 ("drm/amdgpu/vcn: adjust workload profile
>>>>>>>>>> handling")
>>>>>>>>>> Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com> (v1)
>>>>>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>> ---
>>>>>>>>>>       drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 40
>>>>>>>>>> ++++++++++++-------------
>>>>>>>>>>       drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
>>>>>>>>>>       2 files changed, 21 insertions(+), 20 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>> index 9a76e11d1c184..593c1ddf8819b 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>>>>> @@ -415,19 +415,25 @@ static void
>>>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>>>>>>>>           struct amdgpu_vcn_inst *vcn_inst =
>>>>>>>>>>                   container_of(work, struct amdgpu_vcn_inst,
>>>>>>>>>> idle_work.work);
>>>>>>>>>>           struct amdgpu_device *adev = vcn_inst->adev;
>>>>>>>>>> -     unsigned int fences = 0, fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>>>>>>> -     unsigned int i = vcn_inst->inst, j;
>>>>>>>>>> +     unsigned int total_fences = 0,
>>>>>>>>>> fence[AMDGPU_MAX_VCN_INSTANCES] = {0};
>>>>>>>>>> +     unsigned int i, j;
>>>>>>>>>>           int r = 0;
>>>>>>>>>>
>>>>>>>>>> -     if (adev->vcn.harvest_config & (1 << i))
>>>>>>>>>> +     if (adev->vcn.harvest_config & (1 << vcn_inst->inst))
>>>>>>>>>>                   return;
>>>>>>>>>>
>>>>>>>>>> -     for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>>>>>>>>>> -             fence[i] +=
>>>>>>>>>> amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>>>>>>>>>> +     for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>>>>> +             struct amdgpu_vcn_inst *v = &adev->vcn.inst[i];
>>>>>>>>>> +
>>>>>>>>>> +             for (j = 0; j < v->num_enc_rings; ++j)
>>>>>>>>>> +                     fence[i] +=
>>>>>>>>>> amdgpu_fence_count_emitted(&v->ring_enc[j]);
>>>>>>>>>> +             fence[i] += amdgpu_fence_count_emitted(&v->ring_dec);
>>>>>>>>>> +             total_fences += fence[i];
>>>>>>>>>> +     }
>>>>>>>>>>
>>>>>>>>>>           /* Only set DPG pause for VCN3 or below, VCN4 and above will
>>>>>>>>>> be handled by FW */
>>>>>>>>>>           if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
>>>>>>>>>> -         !adev->vcn.inst[i].using_unified_queue) {
>>>>>>>>>> +         !vcn_inst->using_unified_queue) {
>>>>>>>>>>                   struct dpg_pause_state new_state;
>>>>>>>>>>
>>>>>>>>>>                   if (fence[i] ||
>>>>>>>>>> @@ -436,18 +442,18 @@ static void
>>>>>>>>>> amdgpu_vcn_idle_work_handler(struct work_struct *work)
>>>>>>>>>>                   else
>>>>>>>>>>                           new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
>>>>>>>>>>
>>>>>>>>>> -             adev->vcn.inst[i].pause_dpg_mode(vcn_inst, &new_state);
>>>>>>>>>> +             vcn_inst->pause_dpg_mode(vcn_inst, &new_state);
>>>>>>>>>>           }
>>>>>>>>>>
>>>>>>>>>> -     fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
>>>>>>>>>> -     fences += fence[i];
>>>>>>>>>> -
>>>>>>>>>> -     if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>>>>>>> +     if (!fence[vcn_inst->inst] &&
>>>>>>>>>> !atomic_read(&vcn_inst->total_submission_cnt)) {
>>>>>>>>>> +             /* This is specific to this instance */
>>>>>>>>>>                   mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>                   vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
>>>>>>>>>>                   mutex_unlock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>> mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>> -             if (adev->vcn.workload_profile_active) {
>>>>>>>>>> +             /* This is global and depends on all VCN instances */
>>>>>>>>>> +             if (adev->vcn.workload_profile_active &&
>>>>>>>>>> !total_fences &&
>>>>>>>>>> + !atomic_read(&adev->vcn.total_submission_cnt)) {
>>>>>>>>>>                           r = amdgpu_dpm_switch_power_profile(adev,
>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
>>>>>>>>>> false);
>>>>>>>>>>                           if (r)
>>>>>>>>>> @@ -467,16 +473,10 @@ void amdgpu_vcn_ring_begin_use(struct
>>>>>>>>>> amdgpu_ring *ring)
>>>>>>>>>>           int r = 0;
>>>>>>>>>>
>>>>>>>>>>           atomic_inc(&vcn_inst->total_submission_cnt);
>>>>>>>>>> +     atomic_inc(&adev->vcn.total_submission_cnt);
>>>>>>>>> move this addition down inside the mutex lock
>>>>>>>>>> cancel_delayed_work_sync(&vcn_inst->idle_work);
>>>>>>>>>>
>>>>>>>>>> -     /* We can safely return early here because we've cancelled the
>>>>>>>>>> -      * the delayed work so there is no one else to set it to false
>>>>>>>>>> -      * and we don't care if someone else sets it to true.
>>>>>>>>>> -      */
>>>>>>>>>> -     if (adev->vcn.workload_profile_active)
>>>>>>>>>> -             goto pg_lock;
>>>>>>>>>> -
>>>>>>>>>>           mutex_lock(&adev->vcn.workload_profile_mutex);
>>>>>>>>> move to here:
>>>>>>>>> atomic_inc(&adev->vcn.total_submission_cnt);
>>>>>>>>> I think this should work for multiple instances.
>>>>>>>> Why does this need to be protected by the mutex?
>>>>>>> hmm.. OK - no need and it is actually better before the mutex.
>>>>>>> David
>>>>>>>> Alex
>>>>>>>>
>>>>>>>>> David
>>>>>>>>>>           if (!adev->vcn.workload_profile_active) {
>>>>>>>>>>                   r = amdgpu_dpm_switch_power_profile(adev,
>>>>>>>>>> PP_SMC_POWER_PROFILE_VIDEO,
>>>>>>>>>> @@ -487,7 +487,6 @@ void amdgpu_vcn_ring_begin_use(struct
>>>>>>>>>> amdgpu_ring *ring)
>>>>>>>>>>           }
>>>>>>>>>> mutex_unlock(&adev->vcn.workload_profile_mutex);
>>>>>>>>>>
>>>>>>>>>> -pg_lock:
>>>>>>>>>>           mutex_lock(&vcn_inst->vcn_pg_lock);
>>>>>>>>>>           vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>>>>>>>>>>
>>>>>>>>>> @@ -528,6 +527,7 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring
>>>>>>>>>> *ring)
>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submission_cnt);
>>>>>>>>>>
>>>>>>>>>> atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cnt);
>>>>>>>>>> + atomic_dec(&ring->adev->vcn.total_submission_cnt);
>>>>>>>>>>
>>>>>>>>>> schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
>>>>>>>>>>                                 VCN_IDLE_TIMEOUT);
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>> index b3fb1d0e43fc9..febc3ce8641ff 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
>>>>>>>>>> @@ -352,6 +352,7 @@ struct amdgpu_vcn {
>>>>>>>>>>
>>>>>>>>>>           uint16_t inst_mask;
>>>>>>>>>>           uint8_t num_inst_per_aid;
>>>>>>>>>> +     atomic_t                total_submission_cnt;
>>>>>>>>>>
>>>>>>>>>>           /* IP reg dump */
>>>>>>>>>>           uint32_t                *ip_dump;

