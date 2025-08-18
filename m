Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D46CA0ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 22:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBF1910E02E;
	Mon, 18 Aug 2025 22:38:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BQvlKedk";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9D6610E02E
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 22:38:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3ozRSO/qnHzDCP23Yh9Rhw7KEVQGiTsjzdz5zzqp+ZsgyFpqZnFtIAKjVtjnZKMNy84uNlJ/8h5lWq++OKPacnxnPQ8dthflvno7D83E0n9nB/JuYnyaMY4ZvStV0aFS58OF8EV+WDLYUdhZtcMynbzCLXEry3hP1Y5EcYU4Qq51lHH+RGws3dLzVUmssR3SkXISLGmFFPHTk1AiYFNEFyS7IJm0uK0MybG4Fv7DUgdpFwFdCc0DoCkGYh/USiqaKnv8ORXSsGi3CdCXz/LD0JLa7kqV9IFV8urlERi99EFY3UI1xx3jhUNRsYEljT41B0PphjZoow+ve8jRwu9ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaBEGb5rFGLpb/qMdu/rWK8i1W2t6g+EibQsg8wQtZw=;
 b=bOPfAMc19WDYNwXKZB9NP1OwxB70I3Y5DZOpaodypXK4jzzjdlY2ncJFS9ErVNb3wYxLRVYfvi6/IpAThBGJnGnIozRmUcVms8iW4W+igiU8mDDHifOVnuFr22tLnwNvMvx9xuhBjfqphpJtZzPcser4CY9LXUm/bfvv+QMjuT2EptuM85DH/H64XZUCo3Jn9F0ajEQEW040wxdIFKqF6ACgjdpHG2XwZKZQkCuyI1Ahc4MEN+jfbncSsVjF1Y6zoH+so+3omrifBWEQDQd1742N+QvCFDyEMppEG5UNnOoHRjLqJFCHO7Z7LcJOLUCryuZp7wIfbZ3pEcj6cBJucQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaBEGb5rFGLpb/qMdu/rWK8i1W2t6g+EibQsg8wQtZw=;
 b=BQvlKedkJLk1ty8d3aOBcolO6PQo+NriKFlkQwU7NKjk5KkSTeHmhNRLSoFDoG63Mqo8pFcfM3Kx9u9FjV/lYywd0Ry/Cx8M5MWIG7VzLpIKCZghopPr6BM02Hfn7CQsiqO5pa4UX1JHv90IUN+subO1sgP40c+8QnhPpNbDSHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CH3PR12MB8850.namprd12.prod.outlook.com (2603:10b6:610:167::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 22:38:35 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%6]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 22:38:34 +0000
Message-ID: <31bd5d79-3896-45da-b17b-2a1c6b1f8cf0@amd.com>
Date: Mon, 18 Aug 2025 16:38:32 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amd/display: Don't use non-registered VUPDATE on
 DCE 6
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <20250802160602.12698-1-timur.kristof@gmail.com>
 <20250802160602.12698-4-timur.kristof@gmail.com>
 <bb9c7df3-5175-4e13-b519-19d6db465a67@amd.com>
 <CADnq5_MnTaM4U+UgnpEmFf6i1eyavgh9XAT20BajxJ0S2t_7Gw@mail.gmail.com>
 <CAFF-SiVS9NY2MSd-ZmTnjwrOnC=amJrK2gh1CEOCgwiZOgjL4g@mail.gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <CAFF-SiVS9NY2MSd-ZmTnjwrOnC=amJrK2gh1CEOCgwiZOgjL4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::35) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CH3PR12MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5e64e2-fae1-432d-2f1c-08dddea7f751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2xFZStYWklOeElGMmEweEJLbmZPc3NMK0hWSXdDQXFGT29VMUJKWmQyVVZQ?=
 =?utf-8?B?Q3lxSU11bzdVYko5SnBVZGJmc2E1cDBrK0t3QXNmQ2w0V1FnZjJPVlBUNnFt?=
 =?utf-8?B?VTdwWVZldEhTbkpsUXFkZ3BwQVZ6bnQ1dTBWNk9GMVdxN3ZUVkRTdjlKRzlm?=
 =?utf-8?B?anhnc09DclIxV21aZjBSbXlIZkFSc3Y4dm81WVVOTG9kNGpFUkJHck40bFUz?=
 =?utf-8?B?akp3bElVVkhHdE1pRy9YejA0dWkrOXpXVmlaRFhvOWdtM0hNTFF5ODNoWTFJ?=
 =?utf-8?B?Q2h3WFZXNktuRHBaeTN4WXlmSDJtdllJUHhUbVROSHU1bXN4WDZvZkd4a1kz?=
 =?utf-8?B?c245RVlwUEhjck5wMTRha2Q5NWQvVlpWZ1hiSENpNTFnK2pPcnAzODZBbDFx?=
 =?utf-8?B?UGsyVWxTREVDRWZyWVRXODRZRHp1MjUvMGc5a0VYbjlSdnVzQi9UTVl2ZnFr?=
 =?utf-8?B?QTNCeE9rNERvNFZ4bS91SDJYbE1ad1lhUnRTcWI1cURHS05jMTF2OGFHZUNW?=
 =?utf-8?B?V3A1ZGI0WVZSK1ZSVnZYaWZNREJxSlBseHhpUnZ1ajFBZ0hTWHN0bkFzODZY?=
 =?utf-8?B?N25WRnJIbjRaRHRwSW55MzhsUVF2aE1oeXl2YVp4Unc0QWpNUnlvaVB3bnJR?=
 =?utf-8?B?ME9ySFNhQ1c1enpiK1E4Z0lUU3hvcjhEeWlqbmQzeURrL1QrU0hmZjh1WlRr?=
 =?utf-8?B?cUNqb3RlZUlZVTVSU2RmOU5vQlZ0U3hqTUI5TGF0OExXS3BJclBhbTVBMVVP?=
 =?utf-8?B?Y01wVHZJWGRSRFBQME9OdmNQRTNFZFdzWVBLYkkvQ3oySVhQcTRnUlo1ZHlq?=
 =?utf-8?B?aERzYlpPZU1iSTZLVzhFUUFPZm9rdEdzT1gxTkpLYkRWNWtqZGx0WjRjVGhy?=
 =?utf-8?B?S0VxZDQ4L3hRVjU3QWhpdktwQThubHErRXI1U1FXUCt5Nm9WN3dIdndMb0pv?=
 =?utf-8?B?NDc4RlZoeUROTDNPSG1acDBGaTdKa3BzM2FuZ1pSQ1lBdTJxd3pGVVJnZHM1?=
 =?utf-8?B?L3k5MHM0MytKbUwvdm1ONGhjU1lqUS9QRmU0bGRPWjR5Vk1nRFRBYzIwU0Nk?=
 =?utf-8?B?QisrcWhtUkZNZjlZeStuNVAyRWlpR2c5QzJzZE8zKzIwWnJQNVBSZzdPeDc0?=
 =?utf-8?B?bVVYeGVGWVZKa1F3NmoyTlNaV0dQKzU2ekErNEFFYWVQT2ZiYStlNnBQanhR?=
 =?utf-8?B?cHFFMUpSbWE0RUZOcGNvb21xclQ5eWpydWVVSFlFL2V0b2EyNXVwUGxmMEh1?=
 =?utf-8?B?R2t0SWVEZjhUYXZWN3dVMmFjSXcxanpvZDlxL1l4Sm01VVRqTU5jNGs3clEx?=
 =?utf-8?B?WUd2eVNoN0hCTGkwYXR3WHZVemhiSVBYaHo0SDZDQjdsOXFhMkNjSm8vRVBt?=
 =?utf-8?B?VStMY29DYnA3akFqa2o0Vm5oeHZ1QWQxa3VjQkRkUFAybzBOaVRubVNocWps?=
 =?utf-8?B?bCtWRHNPYkIzWEVIb3BtTkFKUmllVWgyY2V2MlhmWnFoOW9KclFKUTkvek1T?=
 =?utf-8?B?ZU5JN09JWjFFZjFVS0xydzZGb2ZXT3YyMDJXeE1hUzZCQ0Q3WXNWU0tMUm1Y?=
 =?utf-8?B?RG9xMXVuUkhncXprVCtRN0M2S3BPU09IazZETzVDWUhWQUpJamQ3S1ROR3Mw?=
 =?utf-8?B?NEkzcjZYalRZOXQrMEZNa2NpLzB4dDBBWHUzZFg4d0xQQTUzZHl3eUtVOUd3?=
 =?utf-8?B?YWY0cjB4bmlVWjAxVS9lRG5PblVUdXlZN0ZDZVJyRFAwc1A5Y2grd01WVTNH?=
 =?utf-8?B?RDlxRXpEVXhEOFNsOG9FbXFMYkNOVHpMLzFoS25nOXU0bUxETjRSU2xHYWpm?=
 =?utf-8?B?dzgzL3VxVmlTa05SY2ZLL2p0ZUpBeVR0ZVFPb3d4NEYxTUhvYlBZUlBkdEs2?=
 =?utf-8?B?SVEvekQ1WVp0cFJTcmRYZHI5MFB4cGZrbnV6bzdpa2J2WTlSYnNlTlUzWU0y?=
 =?utf-8?Q?5OzUT7Erjhk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MitZakhhajUzRzBCOEdyM0ZnaG1JK1BCRDNmUElFZUNPZlpDeDJtOTNpWmR0?=
 =?utf-8?B?bU5PU0hrelpRbXc2WVpYZFFuZmsvaUJhWWxqQWxmaXc0QVNDVVlxT0JEcnpG?=
 =?utf-8?B?TU9jd0phYnlFU0M4V1NKTVJMbjYwc2FsWm1zVml2ak5nWlJ2cUZFZ1lyUzNE?=
 =?utf-8?B?VEd2d3RJVVFVNHB6WUdPK2ZhU0krOUU2S0VtL2FHOE5qNkR4ZlB0bnlGVzI1?=
 =?utf-8?B?SnNaUkM1VWtGZm94WEdSZURTdlRsQVVaZ0dZOEJ1ZXMvQ2pYdEFNS2o0bXdu?=
 =?utf-8?B?enQ0YldkZUo5NkpOaHdEb3VTeGcrMXkvSXJiZG1pUGVzYW8vOHRxbVBKUnVm?=
 =?utf-8?B?bzNtUG5OQngzVzZuV2JSdlRIVnBQUzM0S3R2LzZRWi8rT2lLeGJSR2ovZUlk?=
 =?utf-8?B?OWJySG5TZ25MMXFWUm44YjRYaUl6ZVdUa2gzSk1XUEJFT1V2TzRhR3RhUjhG?=
 =?utf-8?B?Y1NWVXRVMVpMU3FnN1lsQjJ1OUlkcUJNOFZ0ODRNOGQ0SmRpbkE4MUlBc3Vq?=
 =?utf-8?B?dHMwcFJhOU1qcEIxcTdEYXJoL1ZoTmgyMXpOMDhRdUl2Znpkcmc5UlhwV21u?=
 =?utf-8?B?eC9xZ3ZtSlpzcHZrNTRFRjNBblFQWU9NNDJRVEZMNGVPdWxZNzY2aCthdTMv?=
 =?utf-8?B?RlByZ1JxckdMTlZyN1JOYkdrTHFraXpYdEUxQ2dNUzBtQ09tTjZNdHpqZ29E?=
 =?utf-8?B?ZVlFOWNKY3hJOEVNeU5JaDV6YUR1Z1lBNS9vOXFTOVlkbkRiS3YzTGlvVG9S?=
 =?utf-8?B?VUZWSkIvTUY3ZUVZaWJUZGM1WERORzVCR2RmYzc1MXRkVWovS2dCTDBVWFc5?=
 =?utf-8?B?V05mRVhSZ1NtN2tjUCtzSlpORHdIdnRIUmgrWnQxZlRaSytGUlpsNVdWeHhF?=
 =?utf-8?B?ai9kdTZIWVdmNVgzM0VCVFZzWGhUK3ZsNXU1YVBQMmo2Q0RseHNYSVZwdGJS?=
 =?utf-8?B?Z3l0UmRxSjd4dlpmR1FobFNHWlZlNVdPbExQY2ZMTkRZcElBQnU1OXljTkJJ?=
 =?utf-8?B?SFZ2KzdTK1pGVHhOVlZRUTVaUnI3U3ZvQTlEbFQrRldkM25abDdkVnl6bStN?=
 =?utf-8?B?NVlOa2RjcWtLQUg2cGtxdkl1Y2V6bWxYdnBwUUczaGt2bWNCbG5OQWVRNjhY?=
 =?utf-8?B?WmRkTGsvZ3lCTjREVldnMXkvZ3R4UWgvL2pveGkxMU0vbFBYZGRJRHhYYjVi?=
 =?utf-8?B?TGk5bDIzZTdtTXZpVS8rdmlQMUFkdDA3RTFsdmc4bm1WS3g3YUtyNjVXWlEx?=
 =?utf-8?B?MzVVU3JjUkQxN2RIUXBZc1N0Q1RSU3FReEVQaFRCQWxxczdsNVMzanZCeVV6?=
 =?utf-8?B?Umd2T0pVNGVFUWxZVTVOdUxVU1pkRitqdGY1ck9OaVpRZ2dXTzVpSURPRTdz?=
 =?utf-8?B?YkYwYVNVWUNscVQwUlNCVnYxZmdoMEZ6UHcxbTVneWhDcU5uc2d2RVVKbHIz?=
 =?utf-8?B?cDZUMEc3OXJ4c2pCUFd5aDhVaEZ0TUp6S25vTjREUFNwNU52MmNQVFV2NkNs?=
 =?utf-8?B?ZG0xaVJNaG84WjVkb3A4V3FBVmV1ZU4vV2Q3NjlIUkdCeGF6N1d6OENwM3ht?=
 =?utf-8?B?ejZoTms0dVZiNXFtRGl1a2tXZ2RuT2hXT1NoT3dMQmZnOGI4dlZDZlZKUldt?=
 =?utf-8?B?cG5VbWdEdnVLZUpoVStVbVIxYWMreFIrSXI3M1FNYmJzZ1AwaFVmNWdmZlFT?=
 =?utf-8?B?VThQZEpSRWQzVVpzQU1mNy94SUhOZGZWamFOaGRUQjh3L2dDRGNBRVlrclhL?=
 =?utf-8?B?OE1nb0hzMGc0N2I5cnZQYVZaWDBGams1OHhZQTRvRlNoczdpTlYrbXF3L1dn?=
 =?utf-8?B?Zk4zVUV4YU1pL01LU2ZwNGpvKzZZL3Z0cHlMODJCbDVGTC9GNEtZNFpoL0w2?=
 =?utf-8?B?YURVMmtsU29Kb08xclBHa08rQ0t5em1DZ05WVkVrUlFZbjUzOE9xVWZMakM0?=
 =?utf-8?B?Y00zZTVzcGRiTnk2ZmowSHJZRlBibE1WWHlCSmFLT2llSTVhTThUb0RaMFZ1?=
 =?utf-8?B?RWI5QzZaTUxleXFFOU42R0lHU0x5S1QvdVRTa1dxWnZuZzBsY0lsejd2UzVK?=
 =?utf-8?B?QlJ2c2hrTzlWb2FuYSswRU5hM21EK0JaeHNaOUFqak51cmNGQUo5bG11MEx2?=
 =?utf-8?Q?G+kfO2mxubSnFXffqjwLxDCKc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5e64e2-fae1-432d-2f1c-08dddea7f751
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 22:38:34.8417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sq16W6jQUIuQ2esZOtjbSXtbry0R88QFGjwV4YTMGUteExzHSet4g/k43+SmDhUVPb68jtK2wguRL2cRnfj63A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8850
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



On 8/18/25 16:01, Timur Kristóf wrote:
> 
> Alex Deucher <alexdeucher@gmail.com <mailto:alexdeucher@gmail.com>> ezt 
> írta (időpont: 2025. aug. 18., Hét 22:30):
> 
>     On Mon, Aug 18, 2025 at 4:11 PM Alex Hung <alex.hung@amd.com
>     <mailto:alex.hung@amd.com>> wrote:
>      >
>      >
>      >
>      > On 8/2/25 10:06, Timur Kristóf wrote:
>      > > The VUPDATE interrupt isn't registered on DCE 6, so don't try
>      > > to use that.
>      > >
>      > > This fixes a page flip timeout after sleep/resume on DCE 6.
>      > >
>      > > Signed-off-by: Timur Kristóf <timur.kristof@gmail.com
>     <mailto:timur.kristof@gmail.com>>
>      > > ---
>      > >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 ++++++++++
>     ++-------
>      > >   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 16 ++++++++------
>      > >   2 files changed, 23 insertions(+), 15 deletions(-)
>      > >
>      > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>     b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>      > > index 470f831a17f7..e8d2ba58cbfa 100644
>      > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>      > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>      > > @@ -2981,14 +2981,20 @@ static void
>     dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
>      > >                               drm_warn(adev_to_drm(adev),
>     "Failed to %s pflip interrupts\n",
>      > >                                        enable ? "enable" :
>     "disable");
>      > >
>      > > -                     if (enable) {
>      > > -                             if
>     (amdgpu_dm_crtc_vrr_active(to_dm_crtc_state(acrtc->base.state)))
>      > > -                                     rc =
>     amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, true);
>      > > -                     } else
>      > > -                             rc =
>     amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, false);
>      > > -
>      > > -                     if (rc)
>      > > -                             drm_warn(adev_to_drm(adev),
>     "Failed to %sable vupdate interrupt\n", enable ? "en" : "dis");
>      > > +                     if (dc_supports_vrr(adev->dm.dc->ctx-
>      >dce_version)) {
>      > > +                             if (enable) {
>      > > +                                     if
>     (amdgpu_dm_crtc_vrr_active(
>      > > +                                                   
>       to_dm_crtc_state(acrtc->base.state)))
>      > > +                                             rc =
>     amdgpu_dm_crtc_set_vupdate_irq(
>      > > +                                                     &acrtc-
>      >base, true);
>      > > +                             } else
>      > > +                                     rc =
>     amdgpu_dm_crtc_set_vupdate_irq(
>      > > +                                                     &acrtc-
>      >base, false);
>      > > +
>      > > +                             if (rc)
>      > > +                                   
>       drm_warn(adev_to_drm(adev), "Failed to %sable vupdate interrupt\n",
>      > > +                                             enable ? "en" :
>     "dis");
>      > > +                     }
>      >
>      > Hi Timur,
>      >
>      > There seem to be conflicts to amd-staging-drm-next. Could you please
>      > rebase and resend? This helps make sure new change fix the
>     problem you
>      > observed.
>      >
>      > Really appreciate it. Thanks.
> 
>     If it's just the first patch, you can skip that one as the conflict
>     solves the issue with DSC.
> 
>     Alex
> 
> 
> Hi Alex,
> 
> This is a different series, not the same one that had the patch for the 
> DSC crash. I can send a rebased version tomorrow.
> 
> Additionally, I have one more patch that solves another case of page 
> flip timeout on DCE 6, I will add that to the next version of the series 
> too if that's okay.
> 
> Thanks,
> Timur

Sounds good and thanks.

I will send new revision to next promotion test too.

Alex H.

> 
> 
> 
>      >
>      > >
>      > >                       irq_source = IRQ_TYPE_VBLANK + acrtc-
>      >otg_inst;
>      > >                       /* During gpu-reset we disable and then
>     enable vblank irq, so
>      > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/
>     amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/
>     amdgpu_dm_crtc.c
>      > > index 2551823382f8..f2208e4224f9 100644
>      > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>      > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>      > > @@ -298,13 +298,15 @@ static inline int
>     amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
>      > >
>      > >       irq_type = amdgpu_display_crtc_idx_to_irq_type(adev,
>     acrtc->crtc_id);
>      > >
>      > > -     if (enable) {
>      > > -             /* vblank irq on -> Only need vupdate irq in vrr
>     mode */
>      > > -             if (amdgpu_dm_crtc_vrr_active(acrtc_state))
>      > > -                     rc = amdgpu_dm_crtc_set_vupdate_irq(crtc,
>     true);
>      > > -     } else {
>      > > -             /* vblank irq off -> vupdate irq off */
>      > > -             rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, false);
>      > > +     if (dc_supports_vrr(dm->dc->ctx->dce_version)) {
>      > > +             if (enable) {
>      > > +                     /* vblank irq on -> Only need vupdate irq
>     in vrr mode */
>      > > +                     if (amdgpu_dm_crtc_vrr_active(acrtc_state))
>      > > +                             rc =
>     amdgpu_dm_crtc_set_vupdate_irq(crtc, true);
>      > > +             } else {
>      > > +                     /* vblank irq off -> vupdate irq off */
>      > > +                     rc = amdgpu_dm_crtc_set_vupdate_irq(crtc,
>     false);
>      > > +             }
>      > >       }
>      > >
>      > >       if (rc)
>      >
> 

