Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E826DC61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 08:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 795C010E30E;
	Mon,  6 Feb 2023 08:35:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B562D10E30E
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 08:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiZNvkObipOCz+p2DEKZhUyJII15HWNH1Sieu4K9baoh2Wn7KR+rdSEOqOIZUJyO5k1gFCurKe0qeOB7s4ezW9NWPGaqNblWKv7RmylO6on13UcJRybUNTBs8BEx02Qsi+ZMCTTAqQ7nLxx9DPoRi53vuixtCxcn/W6l2AqvqxLlZCSMJrWPDZKaU1TuJtUEwycxnS4p+Wlp83i89o57V5dmpJwbNaD+nz+YSfS4fEUP/x2NoePg5QayfnsXUJQORl5UyK36Zgwuc0CTaHepnO+dr6HTcDz9M/8BDLOXi55MkG1Awzy4AO4GuUVf79Hz+Tg7kypeATYOJOlY7uNzPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0csbB5SD95NkTjC60YQDjx+/vwoWl3fKmNCErSpaE4=;
 b=KsEc5xbjO66YuX7AAj3CAkYwtPupbO1nsKSs82p39IakVOPDw/FycDMN5/TtSGH6J4PucAarIEMFfzOKY3wT8Td868sRYth+D+loeZg5C5M5L4FsvgrYii/amhbJm6CMRO13M8XkB1KtF9VtXJj3J5Ym8vzTwHP8k7nB4uqiGUNexy3MtSZwW6vHsJB6v5Zw8hqw9uRRFRqiHCD+YWPiPTSbPTlPvDAIRLpBUZPztgiVNjQ/xoXrp1zthlY2vwe9UnisRJi+q3kCEoasWFBKRrFLa3m5YvbmxhBQ781GRKsDp/pNtXdOMfQKHWNPDt8okubUePTWOUhPkKdUCG+y7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0csbB5SD95NkTjC60YQDjx+/vwoWl3fKmNCErSpaE4=;
 b=oYUfdbfJfrZHservqSkeXeM1u3wFQwgYWugCodVAL+qY+tquD+OCjo3VfDb65bK3YOcwKbVShB7d8skEa18duoHhdGPePTCrO3Ka4/g3dyCW9WMi9fNqs/r4J2I1QNBL5pYRsWp+ljcfG/jnlbfGKTNCDstWIw5+/M6hVZzz5tE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by PH0PR12MB5498.namprd12.prod.outlook.com (2603:10b6:510:d6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 08:35:47 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 08:35:47 +0000
Message-ID: <44330b41-b7a9-d82e-2614-e9fd291e356f@amd.com>
Date: Mon, 6 Feb 2023 09:35:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: Use the TGID for trace_amdgpu_vm_update_ptes
Content-Language: en-US
To: Friedrich Vock <friedrich.vock@gmx.de>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <Alexander.Deucher@amd.com>
References: <20230202162103.5811-1-friedrich.vock@gmx.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230202162103.5811-1-friedrich.vock@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|PH0PR12MB5498:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc1ab30-94f1-4aff-22f8-08db081d2508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBZYQ5r331V1EfwJ7UqnhzaF7Nwn2FD5vDn/iiDeoApXD0jqzshDc/HwWpMPZ1bXTjawZtV3wduQUCMvCrMAfwC0uLieK4YsChaY1B8lEL0q0bUbmxnIFo6AmnxXB4Udjm00R3RMPJLQXvz90JjqcjXIZTVwhQAa/0Mb9x8gRlhiNMFgBA7S4ssnkYXW4PZpjf+Y16n9W1nDlJuxXnuVAbl+iqmpNpVTB/Cxa+JGcCmfgI+OQ34nCdeIH8LWJsfWAAviQa4ssbw8IovIK9HERj0avbaWsH+4+GygTQe6vgKcxEdpNVGFNzIlfE+jfkF/HuQN5GhecPrCzD6cdRqXcEXH5pBHHyJN2HzNgSiIvXGzfGmFuZxS7546ttwug79jHzTtcfqpVTFFLK09U/hq7cCnkUU01Ya6OfAAW4TrsnVuzGpUGzLTRTWDkQ8SOpPsAPLhCE6NprJ0NZba3LTrYQLTV5Mm+L66TlD1eBy8894gG8F1A96YLndbZchSKfgu9mmBrVK2jXeimtdvq+IlAclaM0tgqR9PjtZgq4mH36Lb2g5sWACQQr7mGfi3sz4jy33pzjheKvrFPpGaHIaKxQuf0mfznaJ1sq8Tp1N3NzH1dsXE/al7Ps6EnYZ72zwwZWxx+tE1LCmxxf5RmbK9xPvyUZjT4+MMq0kdmxMXyE/6seTTpcZ6u34Ti3szEQxGkvSNXqwaF0epzDcUW0M0DDHDDzplfwiSDMnutALhv8Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199018)(31686004)(36756003)(31696002)(38100700002)(86362001)(26005)(6512007)(2616005)(66574015)(186003)(478600001)(83380400001)(6486002)(6506007)(8676002)(6636002)(110136005)(6666004)(316002)(66946007)(41300700001)(8936002)(5660300002)(66476007)(66556008)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1QwSGc3QW9hMC9VeXExWWdYMWQxMGlXV01na21xTHBLOURzTTlWZ3p6dUk4?=
 =?utf-8?B?THpIM1cvWXhHVDJOdlBqNWo2UUZVeHNZMzBVVzJIM2FLMk9NYTlQbkVTSVNx?=
 =?utf-8?B?V1N1dVJmVnhMT0FLcmNUOTl4TGlqOG5Fb01YYXhuVVhDdjcvUkkyRkpwTnk2?=
 =?utf-8?B?Um8wMEU1TTA0aWgxWU82cFgxMFdiWHdMSS9GOFdYS0orUlJqb2g5K0I2K3h3?=
 =?utf-8?B?WjQ1b0I0NmhPeFB1L2xSbEtiaVIwZWhUVjRkbTJVS1Erak5QNGhseEVWbTVz?=
 =?utf-8?B?Q1Z5cDlreGFMQ0lkVHZqT0d1dVBaenJrZGFpM1dsUS9tbU5Ua0k3VjhLSkp1?=
 =?utf-8?B?YVhEckJIU1dHRy9yRW4vSDRWRHRDdmM0Q21UUkd1bGQ0eC9wYkYrS3IzeVRq?=
 =?utf-8?B?aDBMZDJ3ZEVPc3RLSlRNNzZIOU9YZEpRNEp0dUlzbjRLSitiZFB1UkNoM2J4?=
 =?utf-8?B?RkpKNlFkZTM0MHhtOVBhVXJ1enFpVytBOUdOamV4NkxXUlNGeWhWOWpLWEp3?=
 =?utf-8?B?YUdZWXZUV1JqKzdLc2luR3gwdzZiblcxWlIwNjJoTC9hblpoUjZNTG5XRDcx?=
 =?utf-8?B?Z0c2d2wwZVVIMWp1ZDJoeTBCeHlGdmozRmt2MmlFWHZhRVZxVnVLU1Q3elEz?=
 =?utf-8?B?SFg1VG5NODgwS2pGVnNSWEEwNDJMa2pFUGpmS2JzSWJlMGs5K1Q2M2VRK28y?=
 =?utf-8?B?N2gyVllLK3FMWDkvU1pocVNtbHdzKzc4WXpyRnpRWjBjZ3FHaHd2WWsrQ3NW?=
 =?utf-8?B?eWUwTTZGakl2eDR0VVNXa3ZsVGpCVVM4Ri9vNmp5SXRjSUZGa0hlUzd5ZEg5?=
 =?utf-8?B?dlBZNkZhYjQ2a3JYUXhUNmtRdDFUclFNVjNaZERZY1ovbFBtUElaZWdSalFX?=
 =?utf-8?B?UElCZGV5NjdvNDkvQno0Qkx5eFZIQmxRVDlrdDNhamZiSmlhbytVQ0NUTHJC?=
 =?utf-8?B?K2RjTks3R25abjlOV3pxUWRrdWtaRlptd0Y2cEVtVnZubHpVaEU0WHZ2T29n?=
 =?utf-8?B?TXJyYWtLeERTOGFpNGgrZlVRYXF4eG15V1c5VmFtL2JUSUFIRGk1STJvSXJM?=
 =?utf-8?B?RjBya0Q2N1RaM0hLek13NDJudDFINU1KYnRxbHBOUE94eU1TNDRUV2dtQkFl?=
 =?utf-8?B?R0kxanZWT00rZDdmN1ZpRGE0QjhuMUhrU3lxMEREaE54cGpkUWhVZTRnL01Q?=
 =?utf-8?B?MUhLeVE5QnV1WHRyMDVHY3p3L1lEK0hMRGVVMGxQaVozZ2k1R3ZvZXlSWE5P?=
 =?utf-8?B?K2Y1V3d3UjZkRzlyTnBCZ3pEQXg0dnZOTEY1M1E5ZldiMFg1ZUFCTG5DMVpM?=
 =?utf-8?B?VXUxNVBDdis2VTZLQ09GUC82K2hYTEVuZmtmcnEydmh2TGxqL3Nob0IxcDNB?=
 =?utf-8?B?aG14b1grR1kraFNCRFkyNWMxNVF3bmRKaGJIU05qdkk1TTcxMjVyUkw1NHV6?=
 =?utf-8?B?S2ZoNVhFYW5NN3REaDhEbDJCcUF3Y1lUYW9DdGQwWVB4cndHQS9zbExERFk5?=
 =?utf-8?B?VVp4Wm9saHE3Zmo3T2l2SFlKQndjeWgxTEFLZ3pKWEswWFRESHh4cFNNc1Ri?=
 =?utf-8?B?QUlvRnVaTUt3b1NBS1Y3NkY3eE9ad2pNeFdQWUN2RG9aTVBnZTludWk0RDd3?=
 =?utf-8?B?RGdZNU92WjJieFB0M0twMTZ2UEhuZE01dGF2U1RqbTNuOWJmQmVHRyt5T3U3?=
 =?utf-8?B?TTdkWFZ6T0h1QmtzWjQxMUR6OTJHdXRHclM2N3VUKzFwR0hTOGMrbkFEUXpy?=
 =?utf-8?B?NzZlbjF6K1pMNTFrN25ub2RuL21jRnJCVi9rSVBXdnJnZzltYWZYSitNSGpE?=
 =?utf-8?B?WFdaWUZHMnVhRmFvWnBlRkxxN2lNRG8rWDBZRDBpRXorWkhMNGwzYk1XeEZX?=
 =?utf-8?B?dVpFYVN5RzdrS1lndTJEQXZPL1JIajFzUGV4UHFCWWZyR3RERVRUT2VvRXNZ?=
 =?utf-8?B?UEgyVURnbi9ka3ZxSjZxS09BaUVIUldhYm91NTJoZzUzaVJySjhpcnNxdE1Z?=
 =?utf-8?B?cmVLSVB4S2x3bU0xclIydXJxK2M5WEtBZ09XZ1dxaUpTc1VzUU50amJ4TDlj?=
 =?utf-8?B?aWxkUklZallkOWcrVzAyUmJzallqNzFlVnR3WEpmUS9vckVydngwVi9xNWFq?=
 =?utf-8?Q?77/6EXuP0q7NEr79UL+6w8l4t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc1ab30-94f1-4aff-22f8-08db081d2508
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 08:35:47.4077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2HgXoMvUYF0hFrk8qz0ZCIE1NaRcQEJvtL1rBDdR0jSxXI7VW6rxPa164mcu+sG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5498
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



Am 02.02.23 um 17:21 schrieb Friedrich Vock:
> The pid field corresponds to the result of gettid() in userspace.
> However, userspace cannot reliably attribute PTE events to processes
> with just the thread id. This patch allows userspace to easily
> attribute PTE update events to specific processes by comparing this
> field with the result of getpid().
>
> For attributing events to specific threads, the thread id is also
> contained in the common fields of each trace event.
>
> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>

Ah, yes that makes more sense. Reviewed-by: Christian König 
<christian.koenig@amd.com>

Alex do you pick this up or should I take care of it?

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index b5f3bba851db..01e42bdd8e4e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -974,7 +974,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
>   						    min(nptes, 32u), dst, incr,
>   						    upd_flags,
> -						    vm->task_info.pid,
> +						    vm->task_info.tgid,
>   						    vm->immediate.fence_context);
>   			amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
>   						   cursor.level, pe_start, dst,
> --
> 2.39.1
>

