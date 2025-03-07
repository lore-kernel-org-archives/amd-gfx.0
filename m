Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A20C19F32
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 08:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C39010EB08;
	Fri,  7 Mar 2025 08:40:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KvdGF5u7";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD5A710EB05
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 08:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E78KYUW6gbnuf9zL6mcL4VQjj2+w3c1XHPKf1OmFSvNUHGcX4bAEECaRpvwkUuEp0DhPPHYDtflflWYDvfU13MjFMUZgXcx8mgM300EmoYsN05RVsbG0GjJ89l7rvzxYkYs3dbPkH9+ZcF3y8eKnxNYZoVuHyne176KJ00FrWS3hVGjMbSRmQcGg6b1F62UA4ZZ8/zbrDxRgVO1dJkWPbefnolAPCbxkpA6dgPuV4GJ8kFHpI2RePmKOc82+QW2t6pfAlTnSUX/7aFfgz9YZo5anqvG1dXU0FGlCkf6Qk4f2EKNo4iU8w0cpFy7jPYHpVOtdnPZGJJIAay0DV6sIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDRwYD3smu4k/Y77al1vHx6nbS0lEt8FXvGEbNV/Obg=;
 b=ZOsnU52wwazFOZSxrZKbq6HFTyaYYYxBCyxw2tYE3ury0C3CA3CPfIO8xFGhUolBFbssO8aOGhXjB9UsFiX/+xAQ0VdvtqxWt2jb0lll8nikFH3I3Mx3Jd29P+mojKT3ZhQKjmYoVMe2iwUktCZ9IZ4a4bAmcDEVMucfLHjuDFXQUyMdK1PZqIL4CTL2oK4IL8Nm6V4BnJmX89DkMxHz9EHh+64I94N5ox57FMAaP3ux9ROz4aIWKK+s+RaLZPuYeuuXKug4qkLBj8mm1o0soz8AYKTy4oz4k2EVR8CXJPjxAgn7Xn5j1nA0sW7pH/5Yd96dfNeQqlQ2ulxuXRETSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDRwYD3smu4k/Y77al1vHx6nbS0lEt8FXvGEbNV/Obg=;
 b=KvdGF5u7VWWCvmIPYlMxGJ3K7lNaNl5kbj0iSX+6kTuOvUeV4ek5LLrvnO4c6kQjkFGh/rNixWbpLJ3pytqg31xOhrOO1oIMgm6vWqa8eKxyfKeC2ghSnC/eH6mcdrm6zjuSZ7Ts/xXFuOkt3T33BgNxmL0xzLLMxp/QJTBpkeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8220.namprd12.prod.outlook.com (2603:10b6:8:f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 08:39:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 08:39:48 +0000
Message-ID: <43becf25-ad3b-4aae-9919-a74feede06a3@amd.com>
Date: Fri, 7 Mar 2025 09:39:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Allow buffers that don't fit GTT into VRAM
To: Natalie Vock <natalie.vock@gmx.de>, amd-gfx@lists.freedesktop.org
Cc: Ivan Avdeev <1@provod.gl>
References: <20250306170118.40238-1-natalie.vock@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250306170118.40238-1-natalie.vock@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: b958f15d-d08a-43d3-59fa-08dd5d539e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0tYc2E4TjIxRFFzYXp6anh0aFZHR2FyT0RjbVlPMzRkTkhYK1VPNGdqSm5Z?=
 =?utf-8?B?Y0tnYUVobDBSRzJoTGdYNUJVSWNIRS81WnBIcklOa0liNllWdHhpUDlBNFZq?=
 =?utf-8?B?UGVBNklOSTRqUThXRmxkS2ZpRHI4R1phT0xUeGo0cy9NMmhhNTRnUWpYR3dZ?=
 =?utf-8?B?WDdFWG5VVURRMFppOXV4MUlPK1QwT3ZmODd0MGhJZnlGTHNIbnVYOUt6Qll1?=
 =?utf-8?B?OXNUNGNnbGVsaEdYNWZTMEZPelBIQ1FWZUg2SDdIRFd0R3BFaVVhQmRGeklB?=
 =?utf-8?B?cC9mUkVqR2dkRTl0SW9GRGNELzluUVVjU0tucTJsTFk4UTF4ZVlrM2lvZ21h?=
 =?utf-8?B?OHN2emFVZEdwMFVUZ3plYVJobkRFZmVoQ2svUktVZVdpQ0g4VmhZY1dRMkFQ?=
 =?utf-8?B?dDN6M2UydGZNdjB6RW95elNHV1lpMEFEVS80czQzazk3cHFBSk9LOVQ1TzRt?=
 =?utf-8?B?TWNHVGFDSDJEbDRpQStHQk05QThMKzNBSVdNM2d6WmI1Nk1ReUJEQlFXdG5s?=
 =?utf-8?B?b1p1dTE4Mzh4TGpnUGZjUmIxMUppcUV6dWY2RFRlR0dZTkVKdmVrWFQ1UFMv?=
 =?utf-8?B?ZHRjUnV1N1ZNT1hPVG5IR09FWlRCenZlVnZQdUkzbzNLUEZsTUtNSlBBU21M?=
 =?utf-8?B?UlZ6cEFRT290UW45SmVCR0MrR1hGRk91L1pQMUxoNnRYWmhwZUFXQTFiakww?=
 =?utf-8?B?ekhZMXRKdW9XdFF1UXFwQjlzejNPNGlkTHFXMU91M0xKd2tXSTRRUmcyN2Nx?=
 =?utf-8?B?Qm50Q2tKL0dHS2ZMc1ZzK24yS0d1QjRkSnVSRm1JcDZ4dWpZV3g0R3p0S25n?=
 =?utf-8?B?RmxHVGZ1TTExSjY4NGphWEVaVlIrYTBNWlNrRU0wQW1Wbnp3OGtsTDEvQVph?=
 =?utf-8?B?OTk3bWQzRmY2MFdhWDJaVmtXZVZkdEhQUHNsZjBuRzQyd2hTTi9zS0ZMbWxj?=
 =?utf-8?B?c1MwOE81Y1lMUEpvaGhxOEFmSzlxRXFMK3NnMzdLejZSTSsxTk5mT0o4cXJq?=
 =?utf-8?B?T1BWQ2M2eXU3ZzJqMGtId3dIc3ZYdnhoNGlZQUlscmJSTFcwODlvSGhZcnFF?=
 =?utf-8?B?MTVNS2RtVjV0YlVpZ0NkWm0xb3grWDlhcnZwblEyVjhnQ1MrMEtCZlFEczhW?=
 =?utf-8?B?OTZvTHNuSWtjcjhoS3g2UzRCWmpaUjZUZ3Z0U3luRWpiUGhiZUhRNkM5Z2xR?=
 =?utf-8?B?UDJnelpGMkc2eElUd1BzdlgwTWtlSXc1VVNPaC9HK0p4SmtjNlZNSHB6L0ZI?=
 =?utf-8?B?T2RkWmlabWtRWXExdWw4RCt4bWhQaVhBakVNTmk5UEdSUktXakhXajFFV2t1?=
 =?utf-8?B?MTNmdDk2OGVmVnlaZFJHVnVscUFUZENuUCtDMER1ak44bEFoemVqSzV1QkJj?=
 =?utf-8?B?MEhtNlh6MzZES2ZxRmZPSUJGOGRqRVQyRWF0TDA2amhoem5RUUVNT1JoRE5J?=
 =?utf-8?B?MlJIRkk0NEhhWVVpRWE4bnU2UDFuTk94NmF0ZC92aHY1eE1KQUZya3QwbHk4?=
 =?utf-8?B?UUJBcVRKcS9iRjdQbm9FMEVMY3VjbFZFVlpoaWVkMTZZTWcwamh4YWNpb3dY?=
 =?utf-8?B?V2NJYmZzeHBvb2lBcDR4NkpnZjlNVld2bGFtS3JqTE5UOTZFMkowYmNyZFBx?=
 =?utf-8?B?NTRXa0FlZW5Va01EQTNWN0x4eDdvRXlpakRldVV1QVZhMkRON1E3dEhKdU5C?=
 =?utf-8?B?RWJJOEJ0dThaRDZHWm10WkZxell5alZWMUVNQjFWS3RUSjZQNG9wazNVN1h6?=
 =?utf-8?B?T2FqU1p1L0cyaVpXZzV6bkx5b0xpUC9qZVcxeHVpVUQxSnhsbkNPVWhwbVhZ?=
 =?utf-8?B?eXovZWRaRlRNNVJzUnBOQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekpFNndNUmRIaGg5cjREb2d0UFo1WWN6bDFsRUY4TUkvRVFFU0RyMHM3UG1i?=
 =?utf-8?B?anhjMFZja2RwRW5kZTFpV05mUXpLeEZhbzRuUVZQSmtJUkhWT3Bna2NUUHFm?=
 =?utf-8?B?OHdLVjJMaHBnS2doSWJoUDZreWxJbzNnci80dkloOHZGK3FLcnZpanFZVlha?=
 =?utf-8?B?Wm83YVpERVg0RDE4Z3dnV1RXM0p3YnRSLzFMamdORUFEMHlxVkxmQlR2Syt4?=
 =?utf-8?B?VTJEQ3p5UWlLNkpBc2hGazBoVUUraC9NbG9hYld4WldJOGVHSHlVZ3FiQkIv?=
 =?utf-8?B?S1V2MlRsUFROZE9VZUQ1VjhQS2U3eDRjeDMyWVQwZ0JEdXNZNlpsVHVGVnIv?=
 =?utf-8?B?NExxbm5VTlVPRUdBWXFzdmJXWTY2WDdsRkFqc0FReU9pVGlkVHdxdTg1OU5u?=
 =?utf-8?B?SUFOZVZnMytyM1R3bWZheXdjdzloSkxjclkycEUrMmVyY0F2WSszTHF2U3c3?=
 =?utf-8?B?Mk5rTTdlZzVIR25jNGdUamkrTzREbHFCdytqNkFtSUh3MFdEbGhyQWxDS3o3?=
 =?utf-8?B?VW5sY2FYeVRDQjFQUWRJcFlTVjFMZnVuT3I1dk4rVDgvMVErSE04MmxZRUEz?=
 =?utf-8?B?Nyt1N3M0VEwzdmUxMlFBWERqTGViQnN1cWJWSnJEUXJPVmw2MnhMWThFdVly?=
 =?utf-8?B?Z3htLzcxZmhhdndPTWoyVTRJb3hKR1pBWlNXUW1paWJpUmRmdUd0YlhEVnY5?=
 =?utf-8?B?cEtYSlVyTE1wcjhpNFV1b25XWDVSYlhpL0xYZE9sYXc5TjdKWVVrSG5KVmR4?=
 =?utf-8?B?dHJtRVo5YUpUUlZDWGkwYittanowR0MyaVYvaUJoK1ZZUm0vNUQ5OUVhRWkv?=
 =?utf-8?B?ZWRDZHZyQWtyclN6SWY3Nk5TeTZKdTd4ZXc5eVJiOEZ6Nm83WENVUFJxTHo5?=
 =?utf-8?B?RXdpVnJqL2pscVlITWd1eWo5bzFXVmtURlVjQno1Y1NnUDVKcndOcUFIbUZC?=
 =?utf-8?B?bFhCQjFHaXErcE5sYndaV2c2NVJoS1lzS2FQeWJWMG5XK1ppcUhDNm00OUo0?=
 =?utf-8?B?OFZWeGp0bXNxQWNrQ1FET3k1ak5FdTYyU1N2L3BueUxjTjdVbWdxby9mM1VV?=
 =?utf-8?B?NzVsVVhiWkdQSC9KNjJ1bVhzK0VLaUNkcE1NOVRuQmZvNmljUmRwa0F5NXdm?=
 =?utf-8?B?azduamxrcDdnSGpxOWUxUEN1NkNRUldiaEFrRTlQVVlaOUVGZU9Fb1BiVTlh?=
 =?utf-8?B?bUI4V3cyZ01UMHlwUHlIMVVzSTl2RDBISUtFZmpkeEZMcDBxZW43TitoN3Rp?=
 =?utf-8?B?eHRnZmpEbmxtcldZTzJIUm5hSnVEcTFaOG1mNEpUeDlOejFaTk9LemxLZWgv?=
 =?utf-8?B?RG96Zk02ajNNRnVaK0YzZFd2djRyMGQybnBvYXljWVl6c0NjUFlaZFI0bE83?=
 =?utf-8?B?dXZXSi9uSW42bXdYLzFScTBKUm95VmRnd2xzenN4aVpZWkZZbnQvZkxFV0E2?=
 =?utf-8?B?NHlNOVlhYnJoRTY2Z1cxMjVyc0tMRHBxVFBZbExBS09PVndrbXVUOWRLM3NJ?=
 =?utf-8?B?N0c3VjQzQmJtUzJ0WXNHOTRxN1dmM1oxWGNxTm9HMlNsUFBWREZWTy95MS9z?=
 =?utf-8?B?emM5UHFLQU1ERGpFSUE1Q3ozS0hFNkdCcjhHTEFSZy9DYUFIUm5FT3V0Y2dV?=
 =?utf-8?B?STBJMjRpZUREcnhXLzY1VEcyY0x3NVFlRnhNVzNVSWI0WjVDV1g1NFRoUDYx?=
 =?utf-8?B?dy9Benc2ZHFDWFg4ZWt6cFJMTzBDWUZWUkRwdHNpOXg5NHN1ZXh6K3pSTkhq?=
 =?utf-8?B?dUMwaTFudFpXNitMSndtV2RSTThvYW9FbVdzN01RMk1WdXk3OWtySUJmUDlP?=
 =?utf-8?B?OEtvYXpCTnJSbWt0VHRVMXdLMWlFcEwxMC83cTh0UUVsRzR1NU5Pckc5S0t3?=
 =?utf-8?B?SnpkVkVHU0NiUjlNamtEUmJCV3hYeFBwbXZtT1dvMFA4MFNCTlYxbjJkY3dU?=
 =?utf-8?B?cmpYdzJVT3V4N2ovSWdYN29UcEFPWjVKSmZrR0NPaGRMcWJxOVdyS1FXdVdm?=
 =?utf-8?B?a3JoZHBlUXRpQW5ySXZyS2J3MkVRTThEczZtSkI1ZHA1OTRrVElSUGlUWXBL?=
 =?utf-8?B?SnVrQTNuNkdIU0hiNCtvelpJYWhsS3MyNGZ2UGpJTFd0T1dKS2N3d0V0OHBY?=
 =?utf-8?Q?COOVtTcVh7sWAHaZNyQucYbwh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b958f15d-d08a-43d3-59fa-08dd5d539e86
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 08:39:48.2406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSP1hLnjacbOTBJskg+N7ygxFC6qBIESDAEgDQdVBaOh9bBdrizGYIWrE6DVzmv+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8220
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

Am 06.03.25 um 18:01 schrieb Natalie Vock:
> When userspace requests buffers to be placed into GTT | VRAM, it is
> requesting the buffer to be placed into either of these domains. If the
> buffer fits into VRAM but does not fit into GTT, then let the buffer
> reside in VRAM instead of failing allocation entirely.

That will completely break suspend/resume on laptops.

we essentially need to always check if a BO can fit into GTT.

>
> Reported-by: Ivan Avdeev <1@provod.gl>
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
> This originally came up in https://gitlab.freedesktop.org/mesa/mesa/-/issues/12713:
> The crux of the issue is that some applications expect they can allocate
> buffers up to the size of VRAM - however, some setups have a
> smaller-than-VRAM GTT region. RADV always sets VRAM | GTT for all buffer
> allocations, so this causes amdgpu to reject the allocation entirely
> because it cannot fit into GTT, even though it could fit into VRAM.
>
> In my opinion, this check doesn't make sense: It is completely valid
> behavior for the kernel to always keep a VRAM | GTT buffer in VRAM.

No it isn't. On suspend the power to VRAM is turned off and so we always need to be able to evacuate buffers into GTT.

Regards,
Christian.

> The only case where buffers larger than the GTT size are special is that
> they cannot be evicted to GTT (or swapped out), but the kernel already
> allows VRAM-only buffers to be larger than GTT, and those cannot be
> swapped out either. With the check removed, VRAM | GTT buffers larger
> than GTT behave exactly like VRAM-only buffers larger than GTT.
>
> The patch adding this check seems to have added it in a v2 - however I
> was unable to find any public discussion around the patch with reasoning
> in favor of this check.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 30 ++++++++++------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index d09db052e282d..b5e5fea091bf1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -555,27 +555,25 @@ static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
>  {
>  	struct ttm_resource_manager *man = NULL;
>
> -	/*
> -	 * If GTT is part of requested domains the check must succeed to
> -	 * allow fall back to GTT.
> -	 */
> -	if (domain & AMDGPU_GEM_DOMAIN_GTT)
> -		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
> -	else if (domain & AMDGPU_GEM_DOMAIN_VRAM)
> -		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
> -	else
> +	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU, _DOMAIN_DOORBELL */
> +	if (!(domain & (AMDGPU_GEM_DOMAIN_GTT | AMDGPU_GEM_DOMAIN_VRAM)))
>  		return true;
>
> -	if (!man) {
> -		if (domain & AMDGPU_GEM_DOMAIN_GTT)
> +	if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
> +		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
> +		if (size < man->size)
> +			return true;
> +	}
> +	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
> +		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
> +		if (!man) {
>  			WARN_ON_ONCE("GTT domain requested but GTT mem manager uninitialized");
> -		return false;
> +			return false;
> +		}
> +		if (size < man->size)
> +			return true;
>  	}
>
> -	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU, _DOMAIN_DOORBELL */
> -	if (size < man->size)
> -		return true;
> -
>  	DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size, man->size);
>  	return false;
>  }
> --
> 2.48.1
>

