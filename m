Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E193BC61CE7
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 09:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 898AF10E5F3;
	Wed, 11 Jun 2025 09:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v2B73T4H";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE14710E2F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 09:57:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFqmOtB+YVAxaRrPXIaM+diKuH3/R0IOv9GhV/bWt1B0TqeVcLX0J22yi0DMFSGLsfUAU0ZK6WYKYfunAPbOUuDhsX5JBNGNEwv0rkbVT1XrFvGV17Z6b2WgMFGCNvnZBMbIjN5Iw0XBY+53ca9ZDysAHUxtnqc3qzsN+eI7jupfbsLuq8n5gg9CwD61l/VHfyViOGdtVfQ3jeY6mOYPdgmi3Ea4qBWFY3e2QNeLvyuOkYyc3vqBLXCVpUpryYMunCsqH9CTKBHVlGGb/lCObcdXr3eSwsER9BSxoz1Vhsfy+ACBbVHZ3WLsIqMpYjU2zZJKTplUXnOqdmUtK8vkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jm5L5uGueiuHqBAsGvwZZRjENjzHE5Af0qAN2P9Y8U=;
 b=y9PPDIB1uGX0F0INwCmxq/Y4FG/B3kp0GRfMpzEQtYMbrYAdLGjcGa8ktNchtYbotG+hoB5vchpzpeKi5lbwZy+DW9mYPwTX0QEvkN1G2VQpXd+l9R+r2wcZOoMuUQioasgSCPnHeJoMkeztVLd26JOT8wmz+l/tjaJ43CBRowetv2ApfnDktk5pbD/Hj010ni2DNRwxcOKjMniviv4sR4Kwe0d52FE7k1QJEsOvHIcT1pgNG5CQWa8NBpksnBOQV6cRsG4BV3cV1qYlYUgCBAh9uA05KN+LYokYSrGpqh0/mAYNxUzJ6A++y4/KfSp8Thb+6s5e0hxZWK5jgfppVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jm5L5uGueiuHqBAsGvwZZRjENjzHE5Af0qAN2P9Y8U=;
 b=v2B73T4HEalH3SVZErLvWGN7fpr6ZLU4nSIoelrRTh+mxJCLrKiV3VLETJBJwGec4J2j02eSl55Ay4IcQ1khB3nfY0F6QhxQNoBuPO6rRm4Ico9/54wJyC1uUtRNBFTi6uDxsa6bisH05iS3eaaoO/tHMHEPSc+66LQk3LLLJQI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7313.namprd12.prod.outlook.com (2603:10b6:930:53::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Wed, 11 Jun
 2025 09:57:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Wed, 11 Jun 2025
 09:57:11 +0000
Message-ID: <69a24355-9d35-4af9-91df-f148baf941ac@amd.com>
Date: Wed, 11 Jun 2025 11:57:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/29] drm/amdgpu: update ring reset function signature
To: "Sundararaju, Sathishkumar" <sasundar@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250606064354.5858-1-alexander.deucher@amd.com>
 <20250606064354.5858-7-alexander.deucher@amd.com>
 <62a1601e-990a-498e-a64b-d96bfa5567e6@amd.com>
 <CADnq5_NVyLr6O71si=svVJr-Ev6TOGtLs4W32T6fayQPDyfr8Q@mail.gmail.com>
 <c2ea0f45-5962-472e-bd05-547f8bbb71eb@amd.com>
 <7028b1b8-34ea-47f9-b155-70fb9bcc6a3f@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <7028b1b8-34ea-47f9-b155-70fb9bcc6a3f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: 10279d50-9713-4927-e84d-08dda8ce55d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTd3N0lhUE4vdndtQ2ZpMTRnekpYSytGNHBlQURFNnhCcDdVcGxiRG5LNjBX?=
 =?utf-8?B?MnRWcDZjVWo1MEhqWXJJdWV1Nmw5dThJNCtpMXk0SW56RDZBTGlhUHdENGd1?=
 =?utf-8?B?M2ZWUHROaUJGaU5CQjQ4U05sb01ieVltRVp0K2VNQzVCR1RUUG9zYmpvcGN0?=
 =?utf-8?B?aTZBR1doZFJGZ25hZlNSU0pJSkt1TVN6b1FFYy93TEdWTVFLRGxxLytKWmlM?=
 =?utf-8?B?LzZQT2V4TTlsT2ZVRjIyd1ZPZzdjV0dZaWxaM3IwUWV6QkpQcjlnbFNMMUdy?=
 =?utf-8?B?Zi9CVm5Ud1hkdG9QM2NMc1pxTXMxU2lVUERFcVkyb00zRm9kdmlsMGc5Y291?=
 =?utf-8?B?azJYQUdGWERkS0p5VkpkY2dEaGFnNzNXbkdERmlTUlRiYXZMcmVya2xBdi8x?=
 =?utf-8?B?WEdiWTdDWlkrajZNMW13VEs1bzhzSHRDWUlqSWlqblNPNEtocE1xSGhHOTQ3?=
 =?utf-8?B?aWpxOWYzRit2THJlMk0yaW1lei9UekVyeGNBdy9qcFNEeEU3eDI4K2lBT0Z1?=
 =?utf-8?B?VEdjWFRtQ1YrSys3MWU2Q0Z5VDkraFZMSmpPVU1yblRPTWpTUzI2MFp6WUs5?=
 =?utf-8?B?YkZYQXRydHVzQTZvMzFacTQxN015UnB1SG1meWFEWjZ2cHVmUnUvTzdtc2dN?=
 =?utf-8?B?ZVMwaE9FUlJ5R1VwOVVIZ2UvcXowUlEvVEM1bklhbzBTL2l3aU9CdDhnRnRQ?=
 =?utf-8?B?Q0VsenRuSlh4ZmlOMDcxYzg3ay8ybXYvSU90V3JYVWd0R0kxaVBWQ0lBcVNw?=
 =?utf-8?B?T2gwdnZTOUlIQ0lZTHB5dXpvY0huQ29xSTJHU3NzSWdwbjVYVFlCQUMrOHVG?=
 =?utf-8?B?OVNSejU3ZUZrMTZOVHRFVThTbVpPd0FXZ0x5djBXNENPVWxRUmZuNzJLV2JD?=
 =?utf-8?B?MXBZOUMwRkwrSGNwc09UQUlyVTJTSjZpU3dSWlJSZUxSM2xHOXJZYlcyMEVR?=
 =?utf-8?B?dW5nY05mQTdodHB6THBDTFI2SXlzSnJwc2Q1NVpjNE1WUys5NXlabzNCekV3?=
 =?utf-8?B?eG9IcHhNNFYzOTd6Q3ZSR01TS0ZIL1NydFF6ay9aS3BQYXRWRWMyZ1FpTHor?=
 =?utf-8?B?RU5FcDFJUVdoNFFZMTh0NVRwM3U2SDlJSHdXZm0yK205NEVMaTVJR0Zkby9x?=
 =?utf-8?B?Qkw2ZGRaTzByM2FFQWl5WFZFcXo4b3Z6WEV3VE9CUm1DMTFiaGZJV0xiUmkx?=
 =?utf-8?B?dmJxRCtURzJheGJuUWFwSFNjOS9pTU9OOFduZWRycmJBTGl6YVZSM2tueWNI?=
 =?utf-8?B?T1ZaTHZjWHBxZ2tMcDhQdUlQK0MzS1RTUlA5RkhzTEt6eWQrS1JaUmRrWUE1?=
 =?utf-8?B?Umt4bTFkVmpnTXdVenJkeFBLWlFlVUhSM2o5cVZXaFg5cmUvazJuZFZvREM4?=
 =?utf-8?B?NnRvMTcyVzJITWNINjVvWEhZRXkzQnhQNDhqaHZPYi9iVnJicW1OTnEyVzh4?=
 =?utf-8?B?K0YxSVZUYzVpZnY3LzZUdG5ybWxXeWdIUVoyd0RlR1B5clR5Y1QrYWVHK202?=
 =?utf-8?B?amRqS092UExHY3cyWTcydm5qSnk3S20xNDBtMWlhRW5BT0R6U3JvdzQ5VDZh?=
 =?utf-8?B?dEU1Mkp0QmhsTHlieXNuS1NQSnJWTHFnLzduRzV4WWkrQmJFN1Vqdzk0eXZ1?=
 =?utf-8?B?ajloTTg1eVdCbHJFK0NtT0krMDQ4d0NvYU5od3BTTU1TbWhuc055Zm5iK1NZ?=
 =?utf-8?B?alZjZXhqMjRhYnVwSXRhNUpHZ0FqYzJma2M2ZWplZVBQWE9hQVVMR2ZaVG56?=
 =?utf-8?B?TldhaElXU3hrWGRRejNaaXpNbVBzZ0RONEc1K0xMTVQ4UVNGd2JJZncvbG9t?=
 =?utf-8?B?bGJMZFgvZU1vYVVIc3A5VUd1SzZ3S0NkUW1PTXg3dHIwRlhHTUQ1ZURBV0F1?=
 =?utf-8?B?bVB5R1lqc2R4SStFK3RLdHZaWnRxQnpjR1BPTXROdTFNSTAyUDNpcVNFcG9N?=
 =?utf-8?Q?+3YCyMjonkI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWtLR2ZEWnZZdm1Rc0FwZVRlMTArZkZzY3pibUlCWEVBakxkZExMTzA4V25u?=
 =?utf-8?B?eFUrbHZjKzYwRndoOTRvTG9heFNWdUZuN0p1L1cwZGdtamdUQUFOMHpRWEEy?=
 =?utf-8?B?ejYvUk5la3lsL0RNK21CMEI1RXNrQnM2T0VGMlFEWnJYVS94Q2tFZElvejF3?=
 =?utf-8?B?TWRFNUhPcC9xM3VSbEhEbGVWUGE1NTdRVGkzRTFJSlU1Z2UvU3ZtZjRndTd6?=
 =?utf-8?B?OE1Yams2MkxyaElXUUZSaWxaMEUrT1p5UCs5K0M2d1BaYjd4VExvT0hRL2wy?=
 =?utf-8?B?cGc5VzYzZjY3U1hTNnljYkV6NUFNbTNXMldBU3BrS2JaeFVqSGpyZTUya01D?=
 =?utf-8?B?THdjS0h2ZTYrOURqZTFnc2pHWERRanByV25JNDRsdUVuUDN2MHlHN2lRamxw?=
 =?utf-8?B?Mm12MWdkTTFGN2ZhTmRpV1N5UjZsMUNsTkp5VWdLaUFZVzRCS1NRU1BQVEhN?=
 =?utf-8?B?cnFKUllPRU9yMjZKZEU5UjVkWHdZTGlnc2g5R0hLWm1uUm9uWE4rbkJGRkdB?=
 =?utf-8?B?ZXc3bGhhRkQ2bWE2Q2Ria1hpcXBkZEZ6a1FpNTdvaTVLL1RRM3pDcW05ZHFZ?=
 =?utf-8?B?Q3lGUEFMRk5mVTJ4dXB3ZEJkTnpFOHBrdmFqbktDd1NHbERnNkNPR0h1dnFu?=
 =?utf-8?B?aldnaGhVY2V5NCsxTE13SUVyWUJhQ1hFVTRaTnBXcWhhMmtzdVlPVVJ2TnZ5?=
 =?utf-8?B?QkFZbFFkZ0dYUEpqTnEyemZKajdWa1FsM2x5NnAxR2VwbVRkSklMMW9kNlBF?=
 =?utf-8?B?T1o5K0tpcENqWlh6eUxvUnUxcmNhVEtWbTBFWnpYUlRCcXQ5Mk9jOWlEbXU0?=
 =?utf-8?B?ZEtSZGZTSHpSU3pha0pSM3UzNGl2UmlmYjlqWGwrMWthaGN5U0ViWUtGQ1lU?=
 =?utf-8?B?dkJyY3p4QWpJOENDMVp3Y0lubmMwVWtTN2sxK1NpblB2R3pJcXdLNHRqSVFX?=
 =?utf-8?B?WDFBS3FETm8yRzVDRWd6NElYNEdGYU51eUd0K2c3S242T2NGaEl4aWk2Tkpx?=
 =?utf-8?B?Lzg2T2ZjNldIRGZ1ckE4SVB2dlJhbEhESmNzVkhTWnFUZy9Jai85ZDRkOG5O?=
 =?utf-8?B?dHRtNm9vM2Rkb25qNEFBY1JBdlZPdm9NK2JqbS95S1VDaGlmZ3ZNdlFWQ2Y4?=
 =?utf-8?B?SnVyNXMxUE9aTlk4QmRyUlV3RU9zNXR2Tmt0bVVzaTRRQnZlekdKSVBFWjRR?=
 =?utf-8?B?N1pVUW9udklGR0s3YUo0SFVUTW56aTh2bnVSZXdZZHJXREk5TVZPaWFFcnQv?=
 =?utf-8?B?OUNOTmdKRHZ6VUxmUzhZSDQvQmNScUdGY1QrTlRsQ2d4S3FKTjhqNGFoNjZm?=
 =?utf-8?B?MTBLeGhxM0MvSTBsK0tJTUFiTDF2NmovN3RQb1ZLYlFrQm9DYUJwSGM2R2w3?=
 =?utf-8?B?cjlvczRWTmZ1Y0ZpbllhSXVWbFpJZGNQMFJCd2Evblh4VEtBUlJQcGF4bFpT?=
 =?utf-8?B?MGU5U3VyeWdtVHVjeStDb2MyVGRnWGt1VW43T3FOa2hwU1pHNWR3RHBoa2g5?=
 =?utf-8?B?Nk1rb2p0YUF1N1FpcE95VGR3YW1TcWMxeWpVN2RTUnNHZlRhYzlqT0NYMlpT?=
 =?utf-8?B?cDlSQWR6S21icWo0OVU2TmpHSjNnb0M4Z0l3UVdjRTlrdXN6alhWWUVEakg0?=
 =?utf-8?B?M0RWMXVCZ1cvSE53a1Y3TG1Yek94QnVhREw1RE93WmhBUVRzZW1wTVA3UUk0?=
 =?utf-8?B?RFdOYkMzY0VwSnR2TnVqaVpCM0w1MnZmQW9SRGxNU0duZ3BmRTUwK0N0cGVP?=
 =?utf-8?B?bkcza2s2N3Z5ZzNKVGVGRTBFd1FYaWR2Q1d5YXdaNzBzc2Y0UUJST2s4dVd5?=
 =?utf-8?B?WHJTTlo5UDRheUZlNEUrWlpHa3VzS2R0UXhYcVF3bW14Uy9tYk91K29OWmlN?=
 =?utf-8?B?QUZ6RHE2WkpCSzJ0bm5iV0lTL243a0l0U1FVM2NPbXN1d3FFaXRXUlkxc1dZ?=
 =?utf-8?B?UnJWdUdvSTNoQ0tFSGVFY3RrdUk0N2sxcEMvZUdibzdIOSt0VzFrVURDcW1G?=
 =?utf-8?B?RDUwOWIvZXJzajY0azdWR1FqUDBqSVdJUVBTT1pxY3RTTGYraVpLcFRXQVlZ?=
 =?utf-8?B?LytEa2N6QWpDZldWUGMxNWdzUFF3eEN3allNekJnazF0R0Q5TUJEajZZS2pJ?=
 =?utf-8?Q?gyU5Lu8wXOarQwMfdMdtCXq6r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10279d50-9713-4927-e84d-08dda8ce55d0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 09:57:11.5860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAlZ9gJGMGtwzXtwITtqbYNcBTk6fZNAMo+/2M/pIYhfOHdM4dsRwO8x4qL0eiZr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7313
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

On 6/10/25 18:37, Sundararaju, Sathishkumar wrote:
> 
> 
> On 6/10/2025 1:54 PM, Christian König wrote:
>> On 6/6/25 18:00, Alex Deucher wrote:
>>> On Fri, Jun 6, 2025 at 7:41 AM Christian König <christian.koenig@amd.com> wrote:
>>>> On 6/6/25 08:43, Alex Deucher wrote:
>>>>> Going forward, we'll need more than just the vmid.  Everything
>>>>> we need in currently in the amdgpu job structure, so just
>>>>> pass that in.
>>>> Please don't the job is just a container for the submission, it should not be part of any reset handling.
>>>>
>>>> What information is actually needed here?
>>> We need job->vmid, job->base.s_fence->finished, job->hw_fence.
>> VMID and HW fence make sense, but why is the finished fence needed?
> 
> That's used because amdgpu_fence_driver_guilty_force_completion is just forcing the completion of guilty job's hw_fence without setting any error on it.

Yeah I expected something like that.

> so dma_fence_set_error(&job->base.s_fence->finished, -ETIME) is called explicitly to set the error on the waiters fence (finished) to return appropriate error.

Please never do anything like that. We had more than enough of that mess.

> Alternatively the hw_fence could also be set with the error and force completed in amdgpu_fence_driver_guilty_force_completion,
> that would be propagated to waiters fence (finished) , just tested it, has the same result.

Yeah please do that instead.

Regards,
Christian.

> 
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -766,6 +766,7 @@ void amdgpu_fence_driver_guilty_force_completion(struct dma_fence *fence)
>  {
>         struct amdgpu_fence *am_fence = container_of(fence, struct amdgpu_fence, base);
> 
> +       dma_fence_set_error(fence, -ETIME);
>         amdgpu_fence_write(am_fence->ring, fence->seqno);
>         amdgpu_fence_process(am_fence->ring);
>  }
> 
> 
> Regards,
> Sathish
> 
>>
>> Christian.
>>
>>
>>> Alex
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>
>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  2 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 ++--
>>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  7 ++++---
>>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 10 ++++++----
>>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 10 ++++++----
>>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  2 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  2 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  3 ++-
>>>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  3 ++-
>>>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  3 ++-
>>>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  3 ++-
>>>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  3 ++-
>>>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  3 ++-
>>>>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  3 ++-
>>>>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  3 ++-
>>>>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  3 ++-
>>>>>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  5 +++--
>>>>>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  5 +++--
>>>>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  3 ++-
>>>>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  3 ++-
>>>>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  3 ++-
>>>>>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  3 ++-
>>>>>   22 files changed, 53 insertions(+), 33 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>> index ddb9d3269357c..80d4dfebde24f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>> @@ -155,7 +155,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>>>                if (is_guilty)
>>>>>                        dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>>>>>
>>>>> -             r = amdgpu_ring_reset(ring, job->vmid);
>>>>> +             r = amdgpu_ring_reset(ring, job);
>>>>>                if (!r) {
>>>>>                        if (amdgpu_ring_sched_ready(ring))
>>>>>                                drm_sched_stop(&ring->sched, s_job);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> index e1f25218943a4..ab5402d7ce9c8 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> @@ -268,7 +268,7 @@ struct amdgpu_ring_funcs {
>>>>>        void (*patch_cntl)(struct amdgpu_ring *ring, unsigned offset);
>>>>>        void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
>>>>>        void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
>>>>> -     int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
>>>>> +     int (*reset)(struct amdgpu_ring *ring, struct amdgpu_job *job);
>>>>>        void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
>>>>>        bool (*is_guilty)(struct amdgpu_ring *ring);
>>>>>   };
>>>>> @@ -425,7 +425,7 @@ struct amdgpu_ring {
>>>>>   #define amdgpu_ring_patch_cntl(r, o) ((r)->funcs->patch_cntl((r), (o)))
>>>>>   #define amdgpu_ring_patch_ce(r, o) ((r)->funcs->patch_ce((r), (o)))
>>>>>   #define amdgpu_ring_patch_de(r, o) ((r)->funcs->patch_de((r), (o)))
>>>>> -#define amdgpu_ring_reset(r, v) (r)->funcs->reset((r), (v))
>>>>> +#define amdgpu_ring_reset(r, j) (r)->funcs->reset((r), (j))
>>>>>
>>>>>   unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
>>>>>   int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>>> index 75ea071744eb5..c58e7040c732a 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>>> @@ -9522,7 +9522,8 @@ static void gfx_v10_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
>>>>>        amdgpu_ring_insert_nop(ring, num_nop - 1);
>>>>>   }
>>>>>
>>>>> -static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>>> +static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
>>>>> +                            struct amdgpu_job *job)
>>>>>   {
>>>>>        struct amdgpu_device *adev = ring->adev;
>>>>>        struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
>>>>> @@ -9547,7 +9548,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>>>
>>>>>        addr = amdgpu_bo_gpu_offset(ring->mqd_obj) +
>>>>>                offsetof(struct v10_gfx_mqd, cp_gfx_hqd_active);
>>>>> -     tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
>>>>> +     tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << job->vmid);
>>>>>        if (ring->pipe == 0)
>>>>>                tmp = REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE0_QUEUES, 1 << ring->queue);
>>>>>        else
>>>>> @@ -9579,7 +9580,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>>>   }
>>>>>
>>>>>   static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
>>>>> -                            unsigned int vmid)
>>>>> +                            struct amdgpu_job *job)
>>>>>   {
>>>>>        struct amdgpu_device *adev = ring->adev;
>>>>>        struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>> index afd6d59164bfa..0ee7bdd509741 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>>> @@ -6806,7 +6806,8 @@ static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring)
>>>>>        return 0;
>>>>>   }
>>>>>
>>>>> -static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>>> +static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
>>>>> +                            struct amdgpu_job *job)
>>>>>   {
>>>>>        struct amdgpu_device *adev = ring->adev;
>>>>>        int r;
>>>>> @@ -6814,7 +6815,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>>>        if (amdgpu_sriov_vf(adev))
>>>>>                return -EINVAL;
>>>>>
>>>>> -     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
>>>>> +     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, false);
>>>>>        if (r) {
>>>>>
>>>>>                dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
>>>>> @@ -6968,7 +6969,8 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
>>>>>        return 0;
>>>>>   }
>>>>>
>>>>> -static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
>>>>> +static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
>>>>> +                            struct amdgpu_job *job)
>>>>>   {
>>>>>        struct amdgpu_device *adev = ring->adev;
>>>>>        int r = 0;
>>>>> @@ -6976,7 +6978,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
>>>>>        if (amdgpu_sriov_vf(adev))
>>>>>                return -EINVAL;
>>>>>
>>>>> -     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
>>>>> +     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, true);
>>>>>        if (r) {
>>>>>                dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
>>>>>                r = gfx_v11_0_reset_compute_pipe(ring);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>>>> index 1234c8d64e20d..a26417d53411b 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>>>> @@ -5307,7 +5307,8 @@ static int gfx_v12_reset_gfx_pipe(struct amdgpu_ring *ring)
>>>>>        return 0;
>>>>>   }
>>>>>
>>>>> -static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>>> +static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
>>>>> +                            struct amdgpu_job *job)
>>>>>   {
>>>>>        struct amdgpu_device *adev = ring->adev;
>>>>>        int r;
>>>>> @@ -5315,7 +5316,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>>>>>        if (amdgpu_sriov_vf(adev))
>>>>>                return -EINVAL;
>>>>>
>>>>> -     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
>>>>> +     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, false);
>>>>>        if (r) {
>>>>>                dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
>>>>>                r = gfx_v12_reset_gfx_pipe(ring);
>>>>> @@ -5421,7 +5422,8 @@ static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
>>>>>        return 0;
>>>>>   }
>>>>>
>>>>> -static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
>>>>> +static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
>>>>> +                            struct amdgpu_job *job)
>>>>>   {
>>>>>        struct amdgpu_device *adev = ring->adev;
>>>>>        int r;
>>>>> @@ -5429,7 +5431,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
>>>>>        if (amdgpu_sriov_vf(adev))
>>>>>                return -EINVAL;
>>>>>
>>>>> -     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
>>>>> +     r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, true);
>>>>>        if (r) {
>>>>>                dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
>>>>>                r = gfx_v12_0_reset_compute_pipe(ring);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>>> index d50e125fd3e0d..5e650cc5fcb26 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>>> @@ -7153,7 +7153,7 @@ static void gfx_v9_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
>>>>>   }
>>>>>
>>>>>   static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
>>>>> -                           unsigned int vmid)
>>>>> +                           struct amdgpu_job *job)
>>>>>   {
>>>>>        struct amdgpu_device *adev = ring->adev;
>>>>>        struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>>>> index c233edf605694..a7dadff3dca31 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>>>> @@ -3552,7 +3552,7 @@ static int gfx_v9_4_3_reset_hw_pipe(struct amdgpu_ring *ring)
>>>>>   }
>>>>>
>>>>>   static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
>>>>> -                             unsigned int vmid)
>>>>> +                             struct amdgpu_job *job)
>>>>>   {
>>>>>        struct amdgpu_device *adev = ring->adev;
>>>>>        struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>>>>> index 4cde8a8bcc837..6cd3fbe00d6b9 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
>>>>> @@ -764,7 +764,8 @@ static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
>>>>>        return 0;
>>>>>   }
>>>>>
>>>>> -static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>>>> +static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
>>>>> +                             struct amdgpu_job *job)
>>>>>   {
>>>>>        jpeg_v2_0_stop(ring->adev);
>>>>>        jpeg_v2_0_start(ring->adev);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
>>>>> index 8b39e114f3be1..8ed41868f6c32 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
>>>>> @@ -643,7 +643,8 @@ static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
>>>>>        return 0;
>>>>>   }
>>>>>
>>>>> -static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>>>> +static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
>>>>> +                             struct amdgpu_job *job)
>>>>>   {
>>>>>        jpeg_v2_5_stop_inst(ring->adev, ring->me);
>>>>>        jpeg_v2_5_start_inst(ring->adev, ring->me);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
>>>>> index 2f8510c2986b9..3512fbb543301 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
>>>>> @@ -555,7 +555,8 @@ static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
>>>>>        return 0;
>>>>>   }
>>>>>
>>>>> -static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>>>> +static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
>>>>> +                             struct amdgpu_job *job)
>>>>>   {
>>>>>        jpeg_v3_0_stop(ring->adev);
>>>>>        jpeg_v3_0_start(ring->adev);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
>>>>> index f17ec5414fd69..c8efeaf0a2a69 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
>>>>> @@ -720,7 +720,8 @@ static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
>>>>>        return 0;
>>>>>   }
>>>>>
>>>>> -static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>>>> +static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
>>>>> +                             struct amdgpu_job *job)
>>>>>   {
>>>>>        if (amdgpu_sriov_vf(ring->adev))
>>>>>                return -EINVAL;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>>>> index 79e342d5ab28d..8b07c3651c579 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>>>> @@ -1143,7 +1143,8 @@ static void jpeg_v4_0_3_core_stall_reset(struct amdgpu_ring *ring)
>>>>>        WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
>>>>>   }
>>>>>
>>>>> -static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>>>> +static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
>>>>> +                               struct amdgpu_job *job)
>>>>>   {
>>>>>        if (amdgpu_sriov_vf(ring->adev))
>>>>>                return -EOPNOTSUPP;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
>>>>> index 3b6f65a256464..0a21a13e19360 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
>>>>> @@ -834,7 +834,8 @@ static void jpeg_v5_0_1_core_stall_reset(struct amdgpu_ring *ring)
>>>>>        WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
>>>>>   }
>>>>>
>>>>> -static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>>>> +static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
>>>>> +                               struct amdgpu_job *job)
>>>>>   {
>>>>>        if (amdgpu_sriov_vf(ring->adev))
>>>>>                return -EOPNOTSUPP;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>>> index 9c169112a5e7b..ffd67d51b335f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>>>> @@ -1667,7 +1667,8 @@ static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
>>>>>        return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
>>>>>   }
>>>>>
>>>>> -static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>>>> +static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
>>>>> +                                struct amdgpu_job *job)
>>>>>   {
>>>>>        struct amdgpu_device *adev = ring->adev;
>>>>>        u32 id = GET_INST(SDMA0, ring->me);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>>>> index 9505ae96fbecc..46affee1c2da0 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>>>>> @@ -1538,7 +1538,8 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
>>>>>        return 0;
>>>>>   }
>>>>>
>>>>> -static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>>>> +static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
>>>>> +                              struct amdgpu_job *job)
>>>>>   {
>>>>>        struct amdgpu_device *adev = ring->adev;
>>>>>        u32 inst_id = ring->me;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>>>> index a6e612b4a8928..581e75b7d01a8 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>>>>> @@ -1451,7 +1451,8 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
>>>>>        return -ETIMEDOUT;
>>>>>   }
>>>>>
>>>>> -static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>>>> +static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
>>>>> +                              struct amdgpu_job *job)
>>>>>   {
>>>>>        struct amdgpu_device *adev = ring->adev;
>>>>>        u32 inst_id = ring->me;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>>>> index 5a70ae17be04e..d9866009edbfc 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>>>>> @@ -1537,7 +1537,8 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
>>>>>        return r;
>>>>>   }
>>>>>
>>>>> -static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>>>> +static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
>>>>> +                              struct amdgpu_job *job)
>>>>>   {
>>>>>        struct amdgpu_device *adev = ring->adev;
>>>>>        int i, r;
>>>>> @@ -1555,7 +1556,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>>>>                return -EINVAL;
>>>>>        }
>>>>>
>>>>> -     r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
>>>>> +     r = amdgpu_mes_reset_legacy_queue(adev, ring, job->vmid, true);
>>>>>        if (r)
>>>>>                return r;
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>>>>> index ad47d0bdf7775..c546e73642296 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>>>>> @@ -802,7 +802,8 @@ static bool sdma_v7_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
>>>>>        return false;
>>>>>   }
>>>>>
>>>>> -static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>>>> +static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
>>>>> +                              struct amdgpu_job *job)
>>>>>   {
>>>>>        struct amdgpu_device *adev = ring->adev;
>>>>>        int i, r;
>>>>> @@ -820,7 +821,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>>>>>                return -EINVAL;
>>>>>        }
>>>>>
>>>>> -     r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
>>>>> +     r = amdgpu_mes_reset_legacy_queue(adev, ring, job->vmid, true);
>>>>>        if (r)
>>>>>                return r;
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>>>> index b5071f77f78d2..47a0deceff433 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
>>>>> @@ -1967,7 +1967,8 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>>>>>        return 0;
>>>>>   }
>>>>>
>>>>> -static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>>>> +static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
>>>>> +                            struct amdgpu_job *job)
>>>>>   {
>>>>>        struct amdgpu_device *adev = ring->adev;
>>>>>        struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>>> index 5a33140f57235..d961a824d2098 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>>> @@ -1594,7 +1594,8 @@ static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring)
>>>>>        }
>>>>>   }
>>>>>
>>>>> -static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>>>> +static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
>>>>> +                              struct amdgpu_job *job)
>>>>>   {
>>>>>        int r = 0;
>>>>>        int vcn_inst;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>>>>> index 16ade84facc78..10bd714592278 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
>>>>> @@ -1465,7 +1465,8 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring)
>>>>>        }
>>>>>   }
>>>>>
>>>>> -static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>>>> +static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
>>>>> +                              struct amdgpu_job *job)
>>>>>   {
>>>>>        struct amdgpu_device *adev = ring->adev;
>>>>>        struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>>>>> index f8e3f0b882da5..7e6a7ead9a086 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
>>>>> @@ -1192,7 +1192,8 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring)
>>>>>        }
>>>>>   }
>>>>>
>>>>> -static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
>>>>> +static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
>>>>> +                              struct amdgpu_job *job)
>>>>>   {
>>>>>        struct amdgpu_device *adev = ring->adev;
>>>>>        struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
> 

