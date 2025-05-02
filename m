Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FE2C3ABA3
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 08:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4CDB10E388;
	Fri,  2 May 2025 08:36:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HSbjQyYj";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21D3A10E388
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 08:36:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4+Y9keCe3LQhvmvWY5MeZS2dLHa7IGEdRaKxCgJ8/ITMU/TRa6XuOr79Pm2Fc2J77wrgbJbMO95uKSY667KqZLkaFWZ4oNqifsZcQT+BFzlOLimq2xCDCwadQsLE/zqWLkwotdVxJzB1lRz0t2o+iCg7QKiJuQAR16rCaHlGAuGSWEKkpcMPxHTp8LAE7m9JgwLx1sJ9NZQt2we6ZrAJT6R/KrfSzcviYY0yNUCHIH5E1H3xjiJBvuYyJTHeh9yK/7a9VuyVcKo7e2Z8zTl5SGQQ5J2uijwYeDKgvbpwD3ihfi2EsJDlZI+QA19zy89mQCLL+UWfszI48NsUCRYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+F5tjuj7cGx39O8vEmXYeR/TswQ6P3SHKQZltjJ3gBg=;
 b=r0WaUMQwHFD3Ig+Ac8CCqLHdkFr+vOGJde85ENRNaV14XvznI60gPszAaB6zvIJNJcPf3ZPGh51wfKNwyh55SP212mFdbtMABxDWFzwsQrQoyl+5TGm5ihr2if7tyaL1RLdFVkoqcQNli1nZE70O4e51zy2Rc6Nsb2Az/ettgAriOUKB5kshWbsvLTFsoj8bbEJIiIvfiQzR3THhrUvYevBIJznKOY+H9Modtgf/dEl6uSsjkq7bi/oWjal8Sied2Vv/dB49JYQtD1rzbXx1grFYzMNK1GZLhXiHZ5xpnJ7lcOwUdVCrrKaZc8UCxTGhptRl1mVrpL64fSx25aSAng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+F5tjuj7cGx39O8vEmXYeR/TswQ6P3SHKQZltjJ3gBg=;
 b=HSbjQyYj9EfS8CEhR9CAGf9ZrLujLSFZxzAKcaHMeDABgBdWTSBkI4drip1VDYt1mc0YeZRtspChf3oOojiaQZlBTLsHIYMW5/tc4Zkd4ySzn1pKaqyQY5943EdvMfaQoqg/3w2BYHedX/oA/7QYJhtTJ/AUIvmUxq+Gpw8l+tU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 08:36:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Fri, 2 May 2025
 08:36:32 +0000
Message-ID: <b09012e2-f361-46b5-afbf-313334fad69a@amd.com>
Date: Fri, 2 May 2025 10:36:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] drm/amdgpu/uvd: Ensure vcpu bos are within the
 uvd segment
To: Alex Deucher <alexdeucher@gmail.com>, John Olender <john.olender@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, arunpravin.paneerselvam@amd.com
References: <20250429112429.5646-1-john.olender@gmail.com>
 <20250429112429.5646-3-john.olender@gmail.com>
 <CADnq5_OBUWJj5uqbB78wLkbBAMtoRUy=Nes1O6garEQceCLB3Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_OBUWJj5uqbB78wLkbBAMtoRUy=Nes1O6garEQceCLB3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ce2f9f-6322-4712-4c57-08dd8954710f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHBqbHhhVFZGSjNtd1BweitxYzFEcjdsMnpROFZwZU9YTk9OMG5tVXg3T1Ba?=
 =?utf-8?B?b3hnWEw5TGhqaFdKZVpIcjJ3NVBNUGt2Q0hRdld3YXhUREpqdEFycnNDRVpx?=
 =?utf-8?B?dE9Lb0hLSFR2SWZrSUlpdXVSWG1sQnhiWG4yRzlkdWd3cTlEOW1sYW1WRUdh?=
 =?utf-8?B?S2hRc2JzUkJ1blRYY2NSRGhRMnRWeEhiRW5WenlDNEN1bFBDRkUzTlZUT2gy?=
 =?utf-8?B?VkNMbFIxdlo4aUhaek1nbFFxQTR0T1htWjZRMzZ1TE5lUWdDbDBNREtlbCtW?=
 =?utf-8?B?dkJWb0RXZHU4TjVzMndRTEc4ME9WcHpuS20wTlp3ZVgrbjBlczdVaTlzS3N2?=
 =?utf-8?B?OTlFelFaQys2dVM1ZUtUMG1GUDZudFlUdDljY3BaU1RvY0JNNy95ZEM0cjJK?=
 =?utf-8?B?eEY4YVRFUXgrSExSbnlMdFBwdGJQU0k5SmhHVEdrTlV0cEpVTlJjRm5VejhU?=
 =?utf-8?B?RGJiMVJSNEtheEJHKzJYa2hJT3d3UjlWM1BoYjRUSHR5U2c0SmJSQmxzS3lD?=
 =?utf-8?B?REJFOU9ZbzZoVEtCdERxV0tXTm1FbjdWcURHMElHL3ZmRkxGcG5nUW42aUY0?=
 =?utf-8?B?eW5GTlRCbDhtVXdHMFE3NitudkhyWjF5aFh4RHlNMGE3UnpmR096eHJkL0JN?=
 =?utf-8?B?cE10dlBCN3QzenZwTjZYSlVKaEVtMHBQVzMwNHRMZSt3bHNTZDRFRzYvOFlu?=
 =?utf-8?B?V3d2M1BDQ1lIUTBEZHpzZXVtVVlMeHY5bHowUDBvMHpiTC9IYnlicWlIWjVP?=
 =?utf-8?B?MDh0bW95cUIzVUFpNUcyZDJnUmtTK1VKaDR0SExUcTc2Si9YYUwrTFFBbHFD?=
 =?utf-8?B?Qk9nOG9HMkp0cnhXL21ubXN2NUpTSlhIVWVqSHQ1emZjcHRrczd1NWJCekF5?=
 =?utf-8?B?N3EvNjNYeXNiQ2xacWlnM2NmbGhCREZXMEprMXA1OFZDbDQ3UkZ6eHZoN3dR?=
 =?utf-8?B?TzhWeXpsa3N1VFFJRjdiSzhybFVYaFJudW1QL201NVhLZkxyVWQrNWJmYUFh?=
 =?utf-8?B?NEtMSjlJQmxhdmZ4R01SaW1RU2NNMnI3WThtdTY5aS9tQmlLRlk4QUxveE1z?=
 =?utf-8?B?VTMxaEFhTS9wWG5kNXhnZzhzcjdKbUkzS1pXd0dFdHVmMjlxcGx4dUMrSW9N?=
 =?utf-8?B?TGw2U0xoSjRVa1dlN3BMSHdiNWJlRE5adS9QVEN0Z1BQVlpqN0RTaCtzWTdV?=
 =?utf-8?B?UmVqdkFPcHZ4dURVY0hza1B5L0JoMkY3MVpYZGs5eEN4YnVCNm4rUzhob3Ew?=
 =?utf-8?B?ZWFsQ2FKWlg5ZlRDUzl4OFZjZU1GVTBva3QrNUM2citEZllnRlNXSStPclBk?=
 =?utf-8?B?aDc2a0cvSi9VenAwU294SGVESmNVVGR0VCtQZzVLb1NmWHhoaWw1d3ExT09k?=
 =?utf-8?B?RE1ydEZRNHhSZXVwc0hUU2ZCMnhxRlUwZUV2LzB4NjYrNGlHeTdqZzVhcXVs?=
 =?utf-8?B?TFo3enNISXpnMlZQYzI5ZGFGZGxRWGYwbGlYSzNzWVI1OGJPM2RWRnJLeWFr?=
 =?utf-8?B?MmNGQjIwRFdTVHZZbHh5c0haZ1hNdnppV043UFJnYVl0UWU0Ti9MQUZYNWpl?=
 =?utf-8?B?YTFYK3hTdHpiazRLZ2FnQjRwbVRSRlZQKzhkZkhWRDQ5dkNscmw5dyswVGJG?=
 =?utf-8?B?NGV2Q2xCL1B0Zk96VGU1ZTFBdGp3ZUt0SjJhMEQ1S1VtaGtlaGJFbEJMeXdG?=
 =?utf-8?B?R2paVGVRWDExaVJ1WUVSNFVUTHp0anNtYWhTUWlJb3FtRTBCYWM1NUkxWE0z?=
 =?utf-8?B?MnBhUjNZZ0E2ZnRwdmc1Z0Z0Z2VqSUsyeE8yOWlIOStIMXBTNzlBRHRqK2py?=
 =?utf-8?Q?8iRCzoTYHfM/+gWWAtcxb76rnLbMLlbjjoCDI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzF2WFA4MXJ2QU1Sam83YWRObEZvc3NKaGp6b01Vc1YwdXhqN3U5a2JORkw1?=
 =?utf-8?B?c0s1Rk82VVMrZUI5UDZGRm1uRG1wTXd3aWh4Qk1lZmtuQWF3R3NFaEp5NTlY?=
 =?utf-8?B?UERLYTJaWno2MWNwd0t4QWRUMjNEZnUxeEdGdnlwSjF1YzY2QjNoUmpHbkk0?=
 =?utf-8?B?NEtSVWx3MjhhUkRURjhVRVJnbG9XazdHNU14VHlJNlBtazlDNTVLcmhLaVNr?=
 =?utf-8?B?MFNMOEhvVmF5WWV2TE5oWUVLNVY0NTFaU011UW5maDFQVHJTc3A1dDV1YWRU?=
 =?utf-8?B?TnhXRXh3dzVoS0lxNGJad1FpY1hVZUZtZHFHOEc2VkFrUnEzcktlL2NhRGVI?=
 =?utf-8?B?V29QM2FGUVNjelZ4OVZqNFQ0RW56c2FSSEJoOGJvenVYMis2d2JrN0JqNlBi?=
 =?utf-8?B?QXJRcUU5M1ZaNys5R3Y1YkVPeXRLeHU1OStQRlY1YjZNZnNobWpZcHZOVHhZ?=
 =?utf-8?B?MzIrazdISitKUnR0YTRnN2dLcXpST1R6ZHo2TkdJOTBEY0xVRzJ2WjZWNVpO?=
 =?utf-8?B?THc4MzJhUUttL2hlVSswV2R0M2tQZG41aU9hQU1PWEdHTFBYdE1QaEtwVmNB?=
 =?utf-8?B?WG8vQ0tIMkNkM2tiN2ExdG16c0dIdjNhbVIxc1htRk0rck03Sk5NQXVJZUU1?=
 =?utf-8?B?akZMc2pOVmRtRnQvMVRCbFdVMGZGenFjdHVxUE1xYzlFb05wK1owd0ZiNmZl?=
 =?utf-8?B?OHFpT2xpbVJwUk9LT1dpbGxkTThISDdKUG1pTzVTTXA2emFaWjloNXcwdnAr?=
 =?utf-8?B?VitNLzhZa2JDL3FBUlBwczBaa3dSVktLQXcwYmpVTWllZDMxeTZwSFE2TE91?=
 =?utf-8?B?bEovaWw2ZklsSXR6ZXoySFZ5QXRtbVhZNkVaMm5xQUt4ampPbHVZV1hsZlhJ?=
 =?utf-8?B?SlFpUEtMQm9nei9Oak0vQW83bytwK2VkMW51aDVJaFFIZm5pcHIrNmE0SGQ1?=
 =?utf-8?B?amdtVjhnb0NMYmNYam45Wmp5RTUwUC9wQ283WDdUc1VvUlBqTTgwbWtlNER3?=
 =?utf-8?B?dGd1WVREeUx6QTRhOEJqODg4b1I4ZmxMc1BFalA4b0JaSCtvV1BzTWVwOFRO?=
 =?utf-8?B?ZUM0MEl5T3lSMDJVWlYzbmJvY3VPOXZMVkdRZWh2NFk3dTU5cHl2Q0IwNmcw?=
 =?utf-8?B?TUlRcFN1cUFzU0ppblRsT1VQRzJCSllsZ1NTaGtVaGF5NDUvaUFvVXd6RjlO?=
 =?utf-8?B?cVBPUXBDNk9OS3plNGVramxZZjV5L2RwUzJXT3diOVBXVEx3c1ltcmNaTXNT?=
 =?utf-8?B?aHdGNE4rSm1yd2dLdGdGbW96bStjRVBBUjNoSlFVQ242dHpic3VMTTJTUTlK?=
 =?utf-8?B?aXF6UFlKUkNFaEZGUWV1VFEzanJzcDJPMEJnNllFUHh2dk1aTDVpcnVNSytr?=
 =?utf-8?B?TDNxdktvcUk5ZGd4YXNPU3Vsd3crSkRuczlPd25uUGVjaXlFbkpQNTRhWGxs?=
 =?utf-8?B?VllrbnpRaTFQSGxBMFk5WEljVEJjNndUekpjNzNweS9HRndySWN3SlJJZGFa?=
 =?utf-8?B?ZnFPYVVWdnRqOXNuQ3pYaGhYTDNFK2JibDJiYU45eVBwVXo0U1ViRzV5SkxD?=
 =?utf-8?B?TUJvMGRIdWdDNUhpd1VYbUdGLzhhTmZDOGxVK2psUk0rUmdsL0NwMmYxajlH?=
 =?utf-8?B?UG9xamgyajlOYzJ4MkVwcXVQS3I2c0VVQ0xCRDh0QmdFR3NYSWVhdG94b2NL?=
 =?utf-8?B?empiY3RGc0pNT0RxYTMrTFVhazQxNVFXTG50M3YzTWJBMjhlQTV6bEQ0eXRC?=
 =?utf-8?B?dllxYkVMRlYvNFI3T2d2RVZpbGlyV3A1Y0FVek83QWFMMXMzOURqNEE2WEZo?=
 =?utf-8?B?cHMvRlVkZE1jdVp0eWU5L1JteXZxR2x6TDF0ajkzR3NrcFRUM3MwUjVhM2FV?=
 =?utf-8?B?cGZka2d3MS9hOFg4OEVMQno4WkVjekRrKzZKSW51ZTJwTlBmT2lrNlJVdHA0?=
 =?utf-8?B?UGxJNEhOcTVSWlJWb1FjZk5CZEtobWJ1M05vRWdiQTNKM0V6dzRsTkVCR0Vs?=
 =?utf-8?B?ZzFmZmlscVJVd2RYRzN3K1Z0VlpRaEgrc1VyS0ppcWQyUlZ4VTFVenNZeE55?=
 =?utf-8?B?T0psK3pROWt5VFF5NllvZFNvU3BIQkNaUXdjU0ExOVB6c3lGUDcvNFVUZTdi?=
 =?utf-8?Q?rhAZmMWRymYvozSAptm7Mus+A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ce2f9f-6322-4712-4c57-08dd8954710f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 08:36:32.5179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CN72KY6EGPkNogVir1FRDujaLRrjGBmbW9a4duB9Qzh54rIEr94BrlD29IZDPdMg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906
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

On 4/30/25 23:39, Alex Deucher wrote:
> + Christian
> 
> On Tue, Apr 29, 2025 at 7:25 AM John Olender <john.olender@gmail.com> wrote:
>>
>> If the vcpu bos are allocated outside the uvd segment,
>> amdgpu_uvd_ring_test_ib() times out waiting on the ring's fence.

That's incorrect, but pointing to the correct solution.

>>
>> See amdgpu_fence_driver_start_ring() for more context.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3851
>> Signed-off-by: John Olender <john.olender@gmail.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 36 ++++++++++++++-----------
>>  1 file changed, 21 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> index 74758b5ffc6c..a6b3e75ffa2d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>> @@ -139,15 +139,20 @@ static void amdgpu_uvd_force_into_uvd_segment(struct amdgpu_bo *abo);
>>
>>  static int amdgpu_uvd_create_msg_bo_helper(struct amdgpu_device *adev,
>>                                            uint32_t size,
>> -                                          struct amdgpu_bo **bo_ptr)
>> +                                          struct amdgpu_bo **bo_ptr,
>> +                                          bool interruptible)
>>  {
>> -       struct ttm_operation_ctx ctx = { true, false };
>> +       struct ttm_operation_ctx ctx = { interruptible, false };
>>         struct amdgpu_bo *bo = NULL;
>> +       u32 initial_domain = AMDGPU_GEM_DOMAIN_GTT;
>>         void *addr;
>>         int r;
>>
>> +       if (!interruptible && adev->uvd.address_64_bit)
>> +               initial_domain |= AMDGPU_GEM_DOMAIN_VRAM;
>> +
>>         r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
>> -                                     AMDGPU_GEM_DOMAIN_GTT,
>> +                                     initial_domain,
>>                                       &bo, NULL, &addr);
>>         if (r)
>>                 return r;
>> @@ -319,19 +324,23 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>>         if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
>>                 bo_size += AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
>>
>> +       /* from uvd v5.0 HW addressing capacity increased to 64 bits */
>> +       if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0))
>> +               adev->uvd.address_64_bit = true;
>> +
>>         for (j = 0; j < adev->uvd.num_uvd_inst; j++) {
>>                 if (adev->uvd.harvest_config & (1 << j))
>>                         continue;
>> -               r = amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
>> -                                           AMDGPU_GEM_DOMAIN_VRAM |
>> -                                           AMDGPU_GEM_DOMAIN_GTT,
> 
> I think we can just make this VRAM only.  Or something like:
> adev->uvd.address_64_bit ? AMDGPU_GEM_DOMAIN_GTT : AMDGPU_GEM_DOMAIN_VRAM

Yeah completely agree. It's a good catch, but the solution is incorrect.

On the older UVD MC interface the FW needs to be in VRAM or the validation fails. If it's inside the window for the message and fence is actually irrelevant.

So something like AMDGPU_GEM_DOMAIN_VRAM | (adev->uvd.address_64_bit ? AMDGPU_GEM_DOMAIN_GTT : 0) would be correct I think.

> 
> If that fixes it, this should be tagged with:
> Fixes: 58ab2c08d708 ("drm/amdgpu: use VRAM|GTT for a bunch of kernel
> allocations")

And CC stable I think.

Regards,
Christian.

> 
> Alex
> 
>> -                                           &adev->uvd.inst[j].vcpu_bo,
>> -                                           &adev->uvd.inst[j].gpu_addr,
>> -                                           &adev->uvd.inst[j].cpu_addr);
>> +               r = amdgpu_uvd_create_msg_bo_helper(adev, bo_size,
>> +                               &adev->uvd.inst[j].vcpu_bo, false);
>>                 if (r) {
>>                         dev_err(adev->dev, "(%d) failed to allocate UVD bo\n", r);
>>                         return r;
>>                 }
>> +               adev->uvd.inst[j].gpu_addr =
>> +                               amdgpu_bo_gpu_offset(adev->uvd.inst[j].vcpu_bo);
>> +               adev->uvd.inst[j].cpu_addr =
>> +                               amdgpu_bo_kptr(adev->uvd.inst[j].vcpu_bo);
>>         }
>>
>>         for (i = 0; i < adev->uvd.max_handles; ++i) {
>> @@ -339,11 +348,8 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
>>                 adev->uvd.filp[i] = NULL;
>>         }
>>
>> -       /* from uvd v5.0 HW addressing capacity increased to 64 bits */
>> -       if (!amdgpu_device_ip_block_version_cmp(adev, AMD_IP_BLOCK_TYPE_UVD, 5, 0))
>> -               adev->uvd.address_64_bit = true;
>> -
>> -       r = amdgpu_uvd_create_msg_bo_helper(adev, 128 << 10, &adev->uvd.ib_bo);
>> +       r = amdgpu_uvd_create_msg_bo_helper(adev, 128 << 10, &adev->uvd.ib_bo,
>> +                       true);
>>         if (r)
>>                 return r;
>>
>> @@ -1236,7 +1242,7 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>>         if (direct) {
>>                 bo = adev->uvd.ib_bo;
>>         } else {
>> -               r = amdgpu_uvd_create_msg_bo_helper(adev, 4096, &bo);
>> +               r = amdgpu_uvd_create_msg_bo_helper(adev, 4096, &bo, true);
>>                 if (r)
>>                         return r;
>>         }
>> --
>> 2.47.2
>>

