Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292A2FCA16D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 18:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7426F10E587;
	Mon,  9 Mar 2026 18:34:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zJ++W+vj";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 748BF10E125
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 18:34:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmXVRYm5vk5Ptf8k2kgOS4Js5ixdAt2+dMasJJIAXpAlmf4JiE5iVpw5hHCimVOZxroIiFmcVtMab9CuHVFxaKTiDGNsJFEDqU1WDUVutiMO1Rp3sHf92lRzLCVs0gidX+uGk4UhkQDu1cACPkEzv57+56REMfafzjcuSFXMbrGzkoYOliuEVt9e4eJc7MY2olfH/Cdqe8pVApS8gw2tOl0J/lkGoHgAbmmIxzz/o16wf1U09dYaEka6KyT2BLpj6HnZe6yDdrDtl0HyASpp8cctvgbBhEdEPPrvMyyrrnO/+8M2Qus9sYsUawx5XD8JIJZ1OC2CQJF//VSXbb+zPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ca5EE9ejTF/VhAP3VJVtd/LjV/jKTd+R+ACftaqhTLM=;
 b=IC+R440pOJ3Owgbl1xHiqrQTaMETY3S5ZzDzxzB4IM46oW08wLeadbD7dJSkM950EDYkpfPqpH9Hirhtt3uG54w5kzIqrZgeEbWziPJN7Dp+SuzLjFIREp+aE/Z7vqBrL/7fOP2xX/py/DdaxpJThj0IzP1dZE5JzWFy1VlRA5DgVGWOF0Ytd8JJ/XDgMhbTtPlHkCi8G5JiEAEZZofvavq69KObMhYmLDDl+PNXbnLvqZxbrc3a3roAigrM4fs6gfDTP/TXQMBalcRw32l0qHKEPc9VbaZXTfpCV0AWxErHbYTiPDrMoEtXpfGeDdvdSt5Igj1sneOLBRrqqiwVjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ca5EE9ejTF/VhAP3VJVtd/LjV/jKTd+R+ACftaqhTLM=;
 b=zJ++W+vjDyRmBfmR2MpKCFgzH2NzuAOCHJNrxgPRMQnnKn72AMkfaAXqtstPe8iz+hkjE5kyn+g72Cf3dJHhaWQyM3w3PyRQgtvlyv6J0v/m8LLrZvGl/8EWdqOFf8+YSEnG5KCdQA9h0UxniY6Nbh2aGNDr9SPPZwSwFPH1FD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by PH7PR12MB5854.namprd12.prod.outlook.com (2603:10b6:510:1d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 18:34:35 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::7c4d:63c2:bc84:8516]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::7c4d:63c2:bc84:8516%4]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 18:34:35 +0000
Message-ID: <b8a9a4ab-4b27-4b96-88b9-9da9384be284@amd.com>
Date: Mon, 9 Mar 2026 14:34:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] add compute performance count control
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, Bing.Ma@amd.com, benjamin.welton@amd.com
Cc: Jesse.Zhang@amd.com, Jenny-Jing.Liu@amd.com
References: <20260304222829.3688601-1-James.Zhu@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20260304222829.3688601-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0182.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::24) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|PH7PR12MB5854:EE_
X-MS-Office365-Filtering-Correlation-Id: 9900859b-8179-4d4c-72de-08de7e0a8330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: RBJ2YGzMZWeq2xR4dsjqTt1KUIFKnriDebR/GE774cbV2/I0UhcrXLIfJ+rtgEo5UWNX9PCZcktgx5FYhZJMKsYZ5FvY0Fw3mzdmrYp1OQ9UlM8hhDvstz7uzwnMwKFtn5QspusML+az/PaPjc1Z/ahi7AhuM7ALKbmFKvFyj8qcwIRMV2xHJ0CTdPxBQzctSlvlZ6RvP/6tyGFCQgKO0+kTQwrZ2L+QcV3pMqloejf+3jrgIecVXNLvgypQgTYSxN+0LcRX5H4EG3iD41UDj+YFobHUXaLuIBxXrj13Ao3xjQQfe+TrsHOXhuOey2Mu/KTkmI7XXsLgAXC6aVoe5mqZdE6Fvu7qsz8uc3wACcLODmda2BmpPQ4gmnCHZRlkcB26tu0O77vjOcpGY8WVUccOglxPH/Q416zyHmKtP/WUfI7wXUy+rN1qtD1L5jcHoDmVSd3GIQzMhhJowf7uz6HftaosIp1XwdTEk5LDAFYRA4yPoZGRRmU98WsJmXVlcqMnWp9pE1cxlbdEs9OV92IM6jwp0pxbC4h4wo+AvLK20OnsQTsxZy7IOF1mJ8LF38hVG4w4nojvrWH9emkiX15G98AnuslM8BXyg68zrv9h7fzNhISS/0HsPnjArNwgQRZM6/PSjYn471xjY/2nOlvwLeN8b6HRGAw2mQKzjN9VSmmmcMB9+Elz05p7tp7b5qvxwW/sj9QjIog5mtmHqTf89YgF5uTuysae1uBAbcE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cktlQllka2lMaGFrTm9idVVNcjJCWFpBR0RPd1BFUnJ4U0RjVVJ4b3RaUVpO?=
 =?utf-8?B?NGlKTTRvMVRxbDlla2R6Tjl3aktPdmI2ZkNvSWpGYlcrbHNRbDhyVjEvSHBD?=
 =?utf-8?B?N3BBRk8xTUoyaFFtd3A3RWNScXpNZDlKQW02OXhqSFhaSHkycWRnUFBqWEE2?=
 =?utf-8?B?WnlSOFpRRWJBYnZOdnVENG03VTVIbE1NYkZ4SVYrbmNMK2RHNHRxQ1l5TmpB?=
 =?utf-8?B?OTNtWFBldllhSDJJY2h1ZzlSNDdTUFpZTEJkZ0dxcjVLcDlQdHZYazh5dys5?=
 =?utf-8?B?SVZVZnJhVFpheFRLTnRvdURaUFNrenk5eGlJV1JnRmFoL0pVNG0zelcremRM?=
 =?utf-8?B?ZFZzdHdRMW91WmNHeEgxSXMwbWxoZmIwR0FKVjU1bjU0anlpbmtkOXp6R2lj?=
 =?utf-8?B?RWh2UTEzSytTZWltQ0x6dXgySTUrdy9Nem5PdjB1RjVrd216dEVmajRWUWw4?=
 =?utf-8?B?djE3NGM2WWZEeEZXd3ZmSlhaTXZLUG9NRWtLNHR3L0R4NUNuUTRKM0wyL0lJ?=
 =?utf-8?B?UURpUVZwVm14bEg2OGl2RmVIN0llK1U1d2lnWjljbjcvM0dReFNuVmNFL0tl?=
 =?utf-8?B?NGpzMHRFbFV1aWRNalZjZkFSb3JUTE9TeTlicit0dUU2d3grUy9QWUlQV1Yr?=
 =?utf-8?B?dndWNmNhS1hRc3MrVU9NL29YOHNZUEx1NkJmd29XNm1KMGQ1VkJMbjBHNFhI?=
 =?utf-8?B?bzQyQ1dZWUZMNmdFNE9NYjZ5NTIyUW9oWXRoa29QWVY3NjFnekdCb0cveUl2?=
 =?utf-8?B?Tlg4bDRDcU1PK0Ewb1RLL2NQcEZNYmVvYVBJcFZ0cmh2NEhPclVDTVRXcXJx?=
 =?utf-8?B?YkpDM29lNzdxd2R4L3BkQks1Q1dncnpQdkNNSUhnV3orOExqam1pdzRjamx2?=
 =?utf-8?B?Uyt1QU45dHRUcm5pcmJHa2FYaVIwY0xMNjgrOENESmdTemNlWjVzR1haUjBS?=
 =?utf-8?B?VDlORjVWU01uYTJ4VHB6T3ZYL285b3FSdzl5SjQ2OXJVMmNQdHR3cnJaZ3RR?=
 =?utf-8?B?TDNlOHl6bFYyL3djdzFZaGtYWHdSL0NQZFlQTVE5Y0hxNFRqRVpRUFZ1dE9S?=
 =?utf-8?B?ZlVUQlZEM0VnNkE5UVpyWVZ2aVZzUVAwTys3NFFYei9aemtuUHM1RlpSVG9F?=
 =?utf-8?B?OFpOcGNBNUtwZTlHNnZRbS95U1p4ZEVFUXRSb0doaWhrb1NGVm9nVzhIdS83?=
 =?utf-8?B?M2hiZmpyYjE5RVY5aWhhd3BrRVhrZ0xaRktPK29kM1FEMitEcExrdHNVT2tu?=
 =?utf-8?B?TXFFMEhFbEdTejU0REIrNXJad2NpdHlpZjZxam9PcjY1VG1ETCtRd2pVOXFi?=
 =?utf-8?B?NTJWTEo4K0twbXJNWm9rOEowSzBJOWFNZ0hSQmVrY2JSTUlDa0hYODJ5V2pI?=
 =?utf-8?B?VURBYW5QcHRVTFdNNTFtQkZOYlR3bCtwSHkra09ab1NDRkFxL0lkMEN1N25u?=
 =?utf-8?B?SjljWXU2QzBmTnVOTlJXOC9ZNHd5TnVVRHAyRDZzWldiWnVBeW1UQU4zdUpG?=
 =?utf-8?B?YkdhQkJrMXQ5ZTVaN3V4TEp2ZzVNVENHZ2huT3dHZDlQN0N3Q2FXYUxESHll?=
 =?utf-8?B?S2pUa1FXeUtWMW9wN0doenMxczh0V0RreDNraHgrZ3hhZ0hlMUxmWFhXMy9P?=
 =?utf-8?B?cVBQaFM1b3dSanBkUXZKUnRpbktMd1JVM0hnb2Y0T1Y0NEU3Ym0vMHNjcndL?=
 =?utf-8?B?QUp3WE93OGJORjd5UnY4QWs0QXZxdkNrbmt6MUF4VlhGcEJpVzBLNkxaQmhZ?=
 =?utf-8?B?TDduOUxTSldsRGhHNjFXRjBMU2tKa2FIbkpIdWhuVk15UjFOa3ZSTThnRG5J?=
 =?utf-8?B?clU0SzhhRVFkeE4zNWFNK0V0bUlxbDZPVmlzTmlOdUJoRTlXS2V1NXNmdlp6?=
 =?utf-8?B?bjVwdlN4bUJjd2hYVkl1N0dDK3lJbEVlV1FZOFlBZHhuc0NBTnFOWi9iSFht?=
 =?utf-8?B?U2Z0WldyYkloVDR4ZkhDK0ozKzc3T1Y5T1h4eDhRUk93K3daWnJ0WHJOWDQx?=
 =?utf-8?B?akg4M0NMcUxoOEs0bkp3QThrQjlOM29tbFRhVDFMWHRpUVd2RG45REpqdWxV?=
 =?utf-8?B?aWlVN2J5eGM4VllDSFp3dlFSdTE4SjdXZjNRcG56dnEvWTJDcTZ3RDNvK2xo?=
 =?utf-8?B?NEpFYzYyQkM4dm9pL0Y4N3NjR0x4cnJVMUZMc0hoczhiOHpjenNjMFE5VWJn?=
 =?utf-8?B?YzM5SDMzd0Y3dS9FNWJvTnZtVTRSanNPQ3lnekY0SmdBTEZqQWl2by9mQXF5?=
 =?utf-8?B?WWpKTjExRk5qYThWYTFkL3Q4TFc2d2U2QmM3VlVBcUpFQjFjcFZxaStQOUk1?=
 =?utf-8?Q?rUwAry5RoAIgxJZdBP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9900859b-8179-4d4c-72de-08de7e0a8330
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 18:34:35.2235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4foAp5s0Kc2/VA9gtqXDgtPRwPZFYmGP8sgGn0y3ehIdk8TItdjGfB0mbGoVCSx0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5854
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

Ping ...

Thanks!

James Zhu
On 2026-03-04 17:28, James Zhu wrote:
> in user mode queue properties. New user moded queue command
> AMDGPU_USERQ_OP_MODIFY supports update queue properties at runtime.
>
> James Zhu (5):
>    drm/amdgpu: add MQD update on cu_flags
>    drm/amdgpu/gfx10: add compute performance count control
>    drm/amdgpu/gfx11: add compute performance count control
>    drm/amdgpu/gfx12: add compute performance count control
>    drm/amdgpu/gfx12.1: add compute performance count control
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 2 ++
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 3 +++
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 3 +++
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 3 +++
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     | 3 +++
>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 2 ++
>   6 files changed, 16 insertions(+)
>
