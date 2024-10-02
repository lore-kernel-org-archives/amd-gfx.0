Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D94CEACF3
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 18:56:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB94410E275;
	Wed,  2 Oct 2024 18:56:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="piBJY7ik";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A9B410E275
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 18:56:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4xkM4UetlcoQNj7bsgSM89RyBBBDWxBhh5NzMhCqa5iAmE/0okzpDOU3JsprquNuZQkWbiP5hxYDV6zLH2zMhwTTxa0TlevvzxEnnNzjy1D11sioO2/pGyaEbaqzIyWPcmH5c/VkW9tu5/fvrAMPzeSdB8hGiux49ElOp3eELkFRPEAKfm31vdv7D7I8+DJot12zEu9vbH06/5/lYfFpgDDPI6KM7z+DHOIGdGbV+nFGALONpQA3GvR5rESHVzIekX0MEIRyYF5UcrOQg+oteH8Gy2Pkvagij0E8Po5gtqR4al1AG7NhzY24zB7Jc1pzZZvpT2Qs8Tq9Q/BkCAXBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuIFLf5HAoUN8ekTL3Qz0ZrtlVUwchvCKusQDJmOwZE=;
 b=GQuZZePBnMt5ZHIJAoNvDup7NgvUWJCvjrpCy3e9iXJ7mfpxf12V4j3bJGBzTgyohGEVEb8ck65T/QLjYEFoQBhDXtdk5PW2amvYIxHgEoS1yv1zVVW8o8aGPEFIcnU2OfPgiOrGBwmTCP/hgePIZQKLGko4EHqlhGkoqNTGNcubulaR3sXrMgH41HLjIMUgQ/eC1fiskonT8mzkcjIpIXKOeTXqiMWDKNZ4ulD8BiUKr/1jFzjGjRRvc3EXDJCmm4rp1UUZdt3ymjvy4FZkZZPXesLsJUZTkc9VevZCUOCTG33tzMbyKEFzR8LzG2dbwkGVS1c0I1jHt1srYVLtZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuIFLf5HAoUN8ekTL3Qz0ZrtlVUwchvCKusQDJmOwZE=;
 b=piBJY7ik7BsVPIHIfonUI0xNE0431F+Bh1IU7HQRckcrBXfRwxaKqbzuEiyPfyk6FWzA4zydMkH/KPRaOa2gmNSMgVqM69PK99bv2CiNtcm6KkzRtyBCsO8n3xKF1Dq6EPvkKG+CLfVfvU8qNhJhOflfMBv4Qm/YMrQW85AgAJo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA3PR12MB8802.namprd12.prod.outlook.com (2603:10b6:806:314::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.29; Wed, 2 Oct
 2024 18:56:42 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 18:56:42 +0000
Message-ID: <b5b5b926-72fa-4092-a815-8dabce9d1c74@amd.com>
Date: Wed, 2 Oct 2024 14:56:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Add kfd driver function to support hot
 plug/unplug amdgpu devices
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20241001223836.129671-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20241001223836.129671-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA3PR12MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c5f430d-2921-4c8d-ed80-08dce313f438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzFRVkdDejBtaU50VWRRRXhSZjNaTmlneVJqRmJ1N0tMY2gvTEdUQmFocWtv?=
 =?utf-8?B?bHpwcExUV2hhaFVLejA0dy81SXNibnJkazJ3Z3NDUzlpcDBjSng5SktaSURt?=
 =?utf-8?B?SjQzUC9YWlhVd29vdHdDUFluMW9seWVFTlZhM0dWZ204bk9tQ2YxSkJFbW5Q?=
 =?utf-8?B?am51ZGZNU2g0bEhXYXU4Nk9qVUdHVUR3NlVaUGErS2pjRFRPS2taV3h6QWtL?=
 =?utf-8?B?M3dDQnY1NHFFZjR4U0NIVE1yd3k4QzlpclRCMWNrWTQxWmNHSWtzMXRjUVFF?=
 =?utf-8?B?cFkwanc1RXoyaWh3eXFkRTE5WHV5T09XRTFTMThBVHVGK0hyb2R2SjE5Zkpj?=
 =?utf-8?B?M3I1SHZhL2dlV2tzdFg5MXN5cDMwLytHeUczYURTQkRSblBCNmljOFgvWHBY?=
 =?utf-8?B?d00wdHlPdEtCdnBjWmUwNVZKZmJxdXJ2Uk9TUlljMzVsYmpxWFBSQldFcjlR?=
 =?utf-8?B?Qm9qcTdpMGZMbTNLTkV1cjZMZU5Zc1lrT2c3cG5kaU83Sk1xZmRKT0g1OTcx?=
 =?utf-8?B?eDhta3c3VVZMUWxab1UwcElsRFVuZ0NFekpydW0vcGhwcUVGb29DNHhmTGRP?=
 =?utf-8?B?TFpyejdsNkxxRE81WmIyWkRJZ1U1c3QzY2VVUVU1Tzc0M0dNWlhJNis0VjZW?=
 =?utf-8?B?TWVwV09YYkRtRE85Y0FzOU1xYlVzejVNTEFIU0E2NldJYmo4ZFEwTEFuZ3dj?=
 =?utf-8?B?ellzTk5KYUNJM3doWkRYTmxsV0FrMTRxd3kzdTN2aDZtVGZrOGZGbnh1UXBK?=
 =?utf-8?B?aTB3NnpyU08vcndtRkRYdjllMWdSbFRpWWthYkVaM3VQTGdZc2Q0WjZFaEZp?=
 =?utf-8?B?T0dsNVFWY1l6QkFYeFRJMEpiNlNuSDlzdGVBT0NyWXRnMjNHdEoxWE90MGRT?=
 =?utf-8?B?aFJ0NklaZmRBazVQQjVYczFtallvL0llZWlJc0QrcEtHU1hScGkyNVhLdnR0?=
 =?utf-8?B?YThCNGsxbVVDR2Q5TU1zcER5aVB6QStzRUlCYWJFbVZhMVZrMVo2NTJCYTFU?=
 =?utf-8?B?ekc1NmQzVWhhenFXNlRIZCtGdDkyWGZEa3dMekQ4WlpBZ2VvZjFORlp5Rkgy?=
 =?utf-8?B?NUdkQVExenhQSExTRy9xOEE4TytSa0ExV2piNFBDbVk1YmFLTzdOMnVaK1JC?=
 =?utf-8?B?bG1Vd1hpLzN2OFdPL1NUdUQvSXhSSC8xRDJQTEgxRkVuaXhENmVHOTBpWVdO?=
 =?utf-8?B?TVJKUFNiZE0rT0o0SWNzMU9Sd0RKRjlVWkdvMTFQM0RPY2FzdnNQQzFJQWFu?=
 =?utf-8?B?SXRxRkU2OThXL3ZtY3l1ZkRFU2tCRGliTWgxV2JGQ0tSVDdTUndxamU5U0pn?=
 =?utf-8?B?ZmM5emZ6ZFU3VzdRcnBVejM2WnczZm9qdGExR1ErZjVnMHVKUnBtaU5VcmRM?=
 =?utf-8?B?SHZxTC9NZjdjeEQvdFpnWHY3aXU0eGVDNVFZaXNGZjBrTG1MSExUWFZkcVBO?=
 =?utf-8?B?cC9qNFBvREgrVUxoQ2xNbklQa3hGMVhxUEZyNWpUSG9IbzYxd0VkQndQWTlL?=
 =?utf-8?B?ZE50SlVhanZJN1VYSEhab0htQk9rOU5nTE9wdXZ5S0RSVlhaTVQ4Tll2WW1m?=
 =?utf-8?B?YnVGNmkrZFBMMWlTb1djWVJ1VXV4YlJ3aEQ0U245N21wMk0yR3ZRNnJQb1pn?=
 =?utf-8?B?ZG43VFl6amZzb2RadzExNE9CcVVveVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFBuVWRJTXhsNHkwV0IzRWVxSFNCM3lYTVRvdWVta3F5ZENXRWpNMzEwRUVT?=
 =?utf-8?B?YlJUUWZQM2ZYUnNqNExSRXhncGxSK3NZd0JFQTh4YWZxendMbE03aG40eEx3?=
 =?utf-8?B?eCtPeVlRc09jMnFqOHovSGZpUGRXZTFFMllnazdVVDJuY3kzWFFOOTBEWVJY?=
 =?utf-8?B?V2tFZ1lRblRjcE9FSnhhNFN3dnM2enJaVUxya3NWc3M3Tjg0UHBram9zdG05?=
 =?utf-8?B?ME1pSUNtYk1vVk4wZ0J5MERPb1c0dDY3MVpTczZKZjd4R3orcHdxd2xQbWcy?=
 =?utf-8?B?VnRFNCtMQ2NydG5BemtUa0lLb01vMmdOTFRGYTdMT3lRNHpJc0xudCswd1BN?=
 =?utf-8?B?TnhzeDE5Y2ZNRmZjcXB3Nmh4ZXNwdzROVUFuQjU2WWFHd2ZURGxyMFFlb1hT?=
 =?utf-8?B?cmYzWnp1bE1ZczFLNU9ET2ZMR2RtUXRaajA4clRYTWI5MitKMjQ4a3ZaKzVI?=
 =?utf-8?B?dnpCRVJ2NXNzK21vbkhud2p5b0VFRnorWVR4bmlRNGFDeEEvY2dEVHZIZ1hm?=
 =?utf-8?B?VUZIMmxyQkNwRisvajlKT2FkTGR6aEZ1dWkzT2Rra0hraXhPNklZWVUwbGto?=
 =?utf-8?B?eGxUWWRDbTFheEZwWDl2WEhUT3VWRE4zOC9RTmM3dUdMdk9WTlRCdWNHSXBV?=
 =?utf-8?B?dFJqdnFmVlpySU5kdGhxdDVjcE4wZTUyYjRCMXJGNk5WVGR3NCtkRFErRVFl?=
 =?utf-8?B?VTFPdFBkdjFtYmp5OFFvQnIvQUR1Z3J2R21ZV2QxQXcwRTNFbWdZZ0hHV1Rq?=
 =?utf-8?B?OXZDQ2hORmZtQXpnTFNaS0NudEROSkVKNFRHV1NBbERpaVQzbjl0ejB3bzZt?=
 =?utf-8?B?SHpEckI5ek1idkF3Y20yZSs0U2E4QnNDNFozZGY5Z0lQZUtOQlJWOFFjRnZq?=
 =?utf-8?B?Q2hPZ0hHbW9jZjNhVUQzdTFEOEZFbDN4NGpwWUlNOC9Hb0JGSEY0RGJnYzBU?=
 =?utf-8?B?WWZSVE8xVCtmZ29YMGFMY21vSHNRM2JYNnpzR25acm8xc0pYa1R0YnRNVzY1?=
 =?utf-8?B?c2xvL0hvcEM2QThQRmI5U0o4cTBUd01UQmltQXIxcTE2Mis5UkJzSFR0UVds?=
 =?utf-8?B?VklpR3EyRGxVaEp0YmlLT1QzRmt2ZW45bk0vZ3R4bVJQbjZUc2RvNHdJcHBs?=
 =?utf-8?B?andYaWdMUS9Xc3Z4c3RicUxJZmRRSWFRYWNIdjRKL0dBdUprVHpySUlOUTNC?=
 =?utf-8?B?QUxhTWY2MWplKzRoZlMzVUdQa0Nsa3NyeXRSaDdlbHROM0lmcVFuZ3ovVjhw?=
 =?utf-8?B?RDFUQzg5RHU0RFNCWGtVQnBUNXNidTZPN0J4RlhiZ2ZVanNEMlBZYm1Fazc5?=
 =?utf-8?B?LzVsUTJ3bjIwVGpFRkxLdi90cGQrNUYyWjROQ2VXMC8rbXZ4Z0V0TTlmdy8y?=
 =?utf-8?B?bEVKZXBMbmhUcyszOWNsR1I0NnFsMEJ2S0k4eSs2V2VmRUFIM2Z1dnZLcDJ0?=
 =?utf-8?B?ZU1WWnBBNlljUk9FUXFRN2FoSjdlQXY4T2lEMm1KaGczWElKT1ZoS2hleVlx?=
 =?utf-8?B?WjJ5bWhvTVIwVTREQUwvdXg3QnY0SnZnb3JaeENkN2tUSkloKzZIWVdlQmpl?=
 =?utf-8?B?U2JDaVVoa1ZkandPR01oTjJnVXVmRWo2aEc1L05hbDR5NHhQczM5Qkxsa2h1?=
 =?utf-8?B?OWkyZzNLQ1Qvb0tEK1ZHbDBKL2RQYWdKTWt5a1Fxc2xTOU9RMFZyN3JKQXp6?=
 =?utf-8?B?MGhQR2FPcU40Q0UrOVYvTjBCSGkrRTJkeFdZQjJ5V2k0QUxvOERkcWhBMkJi?=
 =?utf-8?B?anNibUI0eGZMc1JFYldPWnd0bTRDQW1RMkdmSlZZelZFRi9NYmkxY29nY0Zs?=
 =?utf-8?B?bWkzRUl6TnlmZWNoWWZPZDU0UDF0bjROdXQyN2VTTHRFbXFCeE9hQ1JiVGI1?=
 =?utf-8?B?czk5c2JLRVk2Q0NPS3Z2c0FZR3hBeUQ5TU1lUFlubTZieTZCSUVLdmxNNndI?=
 =?utf-8?B?MFRxRVVDNVkvS2pEOWVvbmsvMU9GSkkvUU5wTVFQS2FkUWs0dVE4WXFUR05H?=
 =?utf-8?B?V2NPT2I5Z1RrcVZ0QmlPMmU0Z3YveWpVbktpb21YVFo1cXVQWVVPd2dtMkpn?=
 =?utf-8?B?WWRhYy9jNlVBVmhIVkxzbGU5SjdQUnNXb2tFYitBeE1CNXBxRlAwaWdHblJv?=
 =?utf-8?Q?xnyrVcMbIrxRwgPlnjCyazJGE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5f430d-2921-4c8d-ed80-08dce313f438
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 18:56:42.1900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +0Wrrmsi9yvMnWD/g+3oUwKw09u/TcoT5ilRzfV00poHIcHSOOmBGaLPPOcQwE7IhfSZehDNsj52W4yJEbVilg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8802
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


On 2024-10-01 18:38, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> This patch allows kfd driver function correctly when AMD gpu devices got
> plug/unplug at run time.
>
> When an AMD gpu device got unplug kfd driver gracefully terminates existing kfd
> processes after stops all queues, sends SIGTERM to user process. After that user
> space can use remaining AMD gpu devices as usual. When all AMD gpu devices got
> removed kfd driver will not response new requests.
>
> Unplugged AMD gpu devices can be re-plugged. kfd driver will use added devices
> to function as usual.
>
> The purpose of this patch is having kfd driver behavior as expected during
> AMD gpu device plug/unplug.
>
> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  5 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 12 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 77 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c    | 30 +++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  3 +
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 29 ++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 22 +++++++
>   8 files changed, 175 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index b545940e512b..f91a581dbbbb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -248,6 +248,11 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
>   		kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);
>   }
>   
> +void amdgpu_amdkfd_teardown_processes(void)
> +{
> +       kgd2kfd_teardown_processes();
> +}
> +
>   void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm)
>   {
>   	if (adev->kfd.dev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 7e0a22072536..93f54c930017 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -152,6 +152,7 @@ struct amdkfd_process_info {
>   
>   int amdgpu_amdkfd_init(void);
>   void amdgpu_amdkfd_fini(void);
> +void amdgpu_amdkfd_teardown_processes(void);
>   
>   void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm);
>   int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm);
> @@ -431,6 +432,8 @@ int kgd2kfd_check_and_lock_kfd(void);
>   void kgd2kfd_unlock_kfd(void);
>   int kgd2kfd_start_sched(struct kfd_dev *kfd, uint32_t node_id);
>   int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id);
> +void kgd2kfd_lock_kfd(void);
> +void kgd2kfd_teardown_processes(void);
>   #else
>   static inline int kgd2kfd_init(void)
>   {
> @@ -511,5 +514,14 @@ static inline int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id)
>   {
>   	return 0;
>   }
> +
> +void kgd2kfd_lock_kfd(void)
> +{
> +}
> +
> +void kgd2kfd_teardown_processes(void)
> +{
> +}
> +
>   #endif
>   #endif /* AMDGPU_AMDKFD_H_INCLUDED */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1e47655e02c6..2c34813583b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3315,7 +3315,7 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
>   	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>   	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>   
> -	amdgpu_amdkfd_suspend(adev, false);
> +	amdgpu_amdkfd_teardown_processes();
>   
>   	/* Workaroud for ASICs need to disable SMC first */
>   	amdgpu_device_smu_fini_early(adev);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index fad1c8f2bc83..149ab49ea307 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -930,6 +930,9 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>   	}
>   
>   	kfree(kfd);
> +
> +	/* after remove a kfd device unlock kfd driver */
> +	kgd2kfd_unlock_kfd();
>   }
>   
>   int kgd2kfd_pre_reset(struct kfd_dev *kfd,
> @@ -1439,6 +1442,14 @@ int kgd2kfd_check_and_lock_kfd(void)
>   	return 0;
>   }
>   
> +/* unconditionally lock kfd, pair with kgd2kfd_unlock_kfd */
> +void kgd2kfd_lock_kfd(void)
> +{
> +       mutex_lock(&kfd_processes_mutex);
> +       ++kfd_locked;
> +       mutex_unlock(&kfd_processes_mutex);
> +}
> +
>   void kgd2kfd_unlock_kfd(void)
>   {
>   	mutex_lock(&kfd_processes_mutex);
> @@ -1485,6 +1496,72 @@ int kgd2kfd_stop_sched(struct kfd_dev *kfd, uint32_t node_id)
>   	return node->dqm->ops.halt(node->dqm);
>   }
>   
> +/* check if there is any kfd process in system */
> +static bool kgd2kfd_check_idle(void)
> +{
> +	lockdep_assert_held(&kfd_processes_mutex);
> +
> +	/* kfd_processes_table is not empty */
> +	if (!hash_empty(kfd_processes_table))
> +		return false;
> +
> +	/* kfd_processes_table is empty
> +	 * check if all processes are terminated
> +	 */
> +	return !kfd_has_kfd_process();
> +}
> +
> +/* gracefully tear down all existing kfd processes */
> +void kgd2kfd_teardown_processes(void)
> +{
> +	struct kfd_process *p;
> +	struct kfd_node *dev;
> +	unsigned int temp;
> +	uint8_t idx = 0;
> +
> +	/* unconditionally lock kfd driver to not allow create new kfd process
> +	 * will unlock kfd driver at kgd2kfd_device_exit
> +	 */
> +	kgd2kfd_lock_kfd();
> +
> +	mutex_lock(&kfd_processes_mutex);
> +
> +	/* if there is no kfd process just return */
> +	if (kgd2kfd_check_idle()){

Missing space before {


> +		mutex_unlock(&kfd_processes_mutex);
> +		return;

This skips the dqm->ops.stop call. That probably makes it difficult to 
keep ops.stop/op.start calls balanced.


> +	}
> +
> +	/* stop all queues from all kfd nodes */
> +	while (kfd_topology_enum_kfd_devices(idx, &dev) == 0) {
> +		if (dev && !kfd_devcgroup_check_permission(dev))

This check only makes sense in the context of a specific process. As far 
as can tell, this function doesn't run in a process context. It needs to 
consider all devices.


> +			dev->dqm->ops.stop(dev->dqm);

Where is the corresponding ops.start call that resumes execution on GPUs 
that were not unplugged?


> +
> +		idx++;
> +	}
> +
> +	/* signal user space processes their kfd processes terminated */
> +	idx = srcu_read_lock(&kfd_processes_srcu);
> +	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes)
> +			kfd_signal_process_terminate_event(p);

I would have expected that that you evict the process queues here, 
similar to what happens after a GPU reset. Otherwise a process could 
just ignore the termination event and keep working. Maybe there is 
potential to reuse some of the GPU pre/post-reset code paths here.

Using the GPU reset code paths would also allow you to kill only 
processes that were using the unplugged GPU. Currently you kill all 
processes.


> +
> +	srcu_read_unlock(&kfd_processes_srcu, idx);
> +
> +	mutex_unlock(&kfd_processes_mutex);
> +
> +	kfd_cleanup_processes();
> +
> +	mutex_lock(&kfd_processes_mutex);
> +
> +	/* wait all kfd processes terminated */
> +	while (!kgd2kfd_check_idle())
> +		cond_resched();
> +
> +	mutex_unlock(&kfd_processes_mutex);
> +
> +	return;
> +}
> +
>   #if defined(CONFIG_DEBUG_FS)
>   
>   /* This function will send a package to HIQ to hang the HWS
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index ea3792249209..911080bac6d5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -1355,3 +1355,33 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
>   
>   	kfd_unref_process(p);
>   }
> +
> +/* signal KFD_EVENT_TYPE_SIGNAL events from process p
> + * send signal SIGTERM to correspondent user space process
> + */
> +void kfd_signal_process_terminate_event(struct kfd_process *p)
> +{
> +	struct kfd_event *ev;
> +	uint32_t id;
> +
> +	rcu_read_lock();
> +
> +	/* iterate from id 1 for KFD_EVENT_TYPE_SIGNAL events */
> +	id = 1;
> +	idr_for_each_entry_continue(&p->event_idr, ev, id)
> +	if (ev->type == KFD_EVENT_TYPE_SIGNAL) {
> +		spin_lock(&ev->lock);
> +		set_event(ev);
> +		spin_unlock(&ev->lock);
> +	}

I'm not sure what's the point of sending a KFD event that needs to be 
processed by the runtime, if you're immediately following it up with a 
SIGTERM.


> +
> +	/* Send SIGTERM to p->lead_thread */
> +	dev_warn(kfd_device,
> +			"Sending SIGTERM to process %d (pasid 0x%x)",
> +			p->lead_thread->pid, p->pasid);
> +
> +	send_sig(SIGTERM, p->lead_thread, 0);
> +
> +	rcu_read_unlock();
> +}
> +
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 6a5bf88cc232..141ff6511fe3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1036,6 +1036,7 @@ struct kfd_process *kfd_create_process(struct task_struct *thread);
>   struct kfd_process *kfd_get_process(const struct task_struct *task);
>   struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid);
>   struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
> +bool kfd_has_kfd_process(void);
>   
>   int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, uint32_t gpu_id);
>   int kfd_process_gpuid_from_node(struct kfd_process *p, struct kfd_node *node,
> @@ -1161,6 +1162,7 @@ static inline struct kfd_node *kfd_node_by_irq_ids(struct amdgpu_device *adev,
>   }
>   int kfd_topology_enum_kfd_devices(uint8_t idx, struct kfd_node **kdev);
>   int kfd_numa_node_to_apic_id(int numa_node_id);
> +uint32_t kfd_gpu_node_num(void);
>   
>   /* Interrupts */
>   #define	KFD_IRQ_FENCE_CLIENTID	0xff
> @@ -1493,6 +1495,7 @@ void kfd_signal_vm_fault_event(struct kfd_node *dev, u32 pasid,
>   void kfd_signal_reset_event(struct kfd_node *dev);
>   
>   void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid);
> +void kfd_signal_process_terminate_event(struct kfd_process *p);
>   
>   static inline void kfd_flush_tlb(struct kfd_process_device *pdd,
>   				 enum TLB_FLUSH_TYPE type)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index d07acf1b2f93..aac46edcaa67 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -844,8 +844,14 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>   	 */
>   	mutex_lock(&kfd_processes_mutex);
>   
> +	if (kfd_gpu_node_num() <= 0) {
> +		pr_warn("no KFD gpu node! Cannot create process");
> +		process = ERR_PTR(-EINVAL);
> +		goto out;
> +	}
> +
>   	if (kfd_is_locked()) {
> -		pr_debug("KFD is locked! Cannot create process");
> +		pr_warn("KFD is locked! Cannot create process");

This is going to result in spurious warning messages that tend to 
mislead people. If this is expected in the normal course of operation of 
the driver, it should not be a warning.


>   		process = ERR_PTR(-EINVAL);
>   		goto out;
>   	}
> @@ -1155,16 +1161,18 @@ static void kfd_process_wq_release(struct work_struct *work)
>   	 */
>   	synchronize_rcu();
>   	ef = rcu_access_pointer(p->ef);
> -	dma_fence_signal(ef);
>   
> -	kfd_process_remove_sysfs(p);
> +	if (ef) {

This check is unnecessary. Both dma_fence_signal and dma_fence_put can 
deal with NULL pointers gracefully. I'm not sure the reordering of 
function calls here serves any practical purpose. If anything, it's 
problematic that you're updating p->ef in a non-atomic way here. Ideally 
the fence should be destroyed when all its users have gone away. The 
current place after ..._destroy_pdds seems safer in that respect.

Regards,
   Felix


> +		dma_fence_signal(ef);
> +		dma_fence_put(ef);
> +		p->ef = NULL;
> +	}
>   
>   	kfd_process_kunmap_signal_bo(p);
>   	kfd_process_free_outstanding_kfd_bos(p);
>   	svm_range_list_fini(p);
>   
>   	kfd_process_destroy_pdds(p);
> -	dma_fence_put(ef);
>   
>   	kfd_event_free_process(p);
>   
> @@ -1173,9 +1181,22 @@ static void kfd_process_wq_release(struct work_struct *work)
>   
>   	put_task_struct(p->lead_thread);
>   
> +	/* the last step is removing process entries under /sys
> +	 * to indicate the process has been terminated.
> +	 */
> +	kfd_process_remove_sysfs(p);
> +
>   	kfree(p);
>   }
>   
> +/* check there is entry under procfs.kobj */
> +bool kfd_has_kfd_process(void)
> +{
> +	WARN_ON_ONCE(kref_read(&procfs.kobj->kref) == 0);
> +
> +	return procfs.kobj->sd && procfs.kobj->sd->dir.subdirs;
> +}
> +
>   static void kfd_process_ref_release(struct kref *ref)
>   {
>   	struct kfd_process *p = container_of(ref, struct kfd_process, ref);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 3871591c9aec..7809ed0dbc95 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -2336,6 +2336,28 @@ int kfd_numa_node_to_apic_id(int numa_node_id)
>   	return kfd_cpumask_to_apic_id(cpumask_of_node(numa_node_id));
>   }
>   
> +/* kfd_gpu_node_num - Return kfd gpu node number at system */
> +uint32_t kfd_gpu_node_num(void)
> +{
> +	struct kfd_node *dev;
> +	uint8_t gpu_num  = 0;
> +	uint8_t id  = 0;
> +
> +	while (kfd_topology_enum_kfd_devices(id, &dev) == 0) {
> +		if (!dev || kfd_devcgroup_check_permission(dev)) {
> +			/* Skip non GPU devices and devices to which the
> +			 * current process have no access to
> +			 */
> +			id++;
> +			continue;
> +		}
> +		id++;
> +		gpu_num++;
> +	}
> +
> +	return gpu_num;
> +}
> +
>   #if defined(CONFIG_DEBUG_FS)
>   
>   int kfd_debugfs_hqds_by_device(struct seq_file *m, void *data)
