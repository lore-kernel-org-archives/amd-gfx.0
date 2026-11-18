Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C51606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UvmS2l0P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C58C410EC9C;
	Wed, 18 Nov 2026 18:58:52 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6606C10EC9C
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 18:58:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSDnmWChfLgsQ9vpCtf1z6T4IxVYN7h70ozbpl2gjZyGTRABBkL5U+1zhwNclbFNrZ3Kutyj4efeujmw2Z4oRuRPx8BuCg4UWPXD2KaIishP0w8PdFy+Y9qEm+LfHO5lRxDYZPeLdbRRMNX6l/FqxEWyB+WwxJ+4RkiC4b5ERJ0WZzDJhSAPdbB+t6NZFopdrCs1JVlLidP+NWXzac17/us6Nwbzt6+Znrxe6yOV1ELS3n0u8ZmciH4/N24B1xIDTY84TpyvY5rxyB7C8mchBiXhEm+CP5bd1fq3jK15Z14PbZ/x0rKoZBU+oTHr/CnJTnzivog58QjQ/dLD86wzZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWaJsrtraKsuPxmwSVeCv3BCbZ2OftGsA6xEFM3GbnY=;
 b=VVtHg7G+89d/Mh9c6WdOGog1GevFWvmNcOHw3SxMd7QotIvRlq2aNwE9Z7S/O+qShMTIfImxUyVGv3fs33lht1bLO908J+MKWSid3oOcZaQ7LAvwkTL5a+alwR0PcWC/g6qwWfqJgDnl3T5LwJrTQRYRDZsk/We2UpvEmM4eQMEZhNSBiHofywbKeFoApH6kSN+avNmj7w2IG03nBAfSC4lwepTSea237L3vECePk7Jxik3O/0p1Q9eit231E4I+tV6QzGLR2MTo+fd1hEpwpMdlPDmLDQTXPywBgwafMMb/rIysdLGjjDMHIGd1JVezzjhYwFQMoFeUY3ZLeSiZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWaJsrtraKsuPxmwSVeCv3BCbZ2OftGsA6xEFM3GbnY=;
 b=UvmS2l0P5b00jdKCbhobItvfd4P6L23BdVfdwLoXN/dEsFzQNqE4WiFw52NDde/PwZCVft063dtCL/ZyTLO+Ha0VTT9e0fODEi/8UNQir0j8BF7m/GHLAIFBMxNzt+pas8KNmhMwa/Gy1xhcwJ0yccMw6lDHQCqeZU27mrfIxvo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by IA5PR12MB999275.namprd12.prod.outlook.com (2603:10b6:208:602::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 18:58:44 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 18:58:42 +0000
Message-ID: <0a26439a-b0d9-42e8-93f2-67d692a6e5f7@amd.com>
Date: Wed, 18 Nov 2026 13:58:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Consolidate and fix root PD fence resverations
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Shahyan Soltani <shahyan.soltani@amd.com>
References: <20261118185225.1857845-1-benjamin.cheng@amd.com>
Content-Language: en-US
From: Benjamin Cheng <benjamin.cheng@amd.com>
In-Reply-To: <20261118185225.1857845-1-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0263.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::17) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|IA5PR12MB999275:EE_
X-MS-Office365-Filtering-Correlation-Id: 216feb16-a969-462f-dc38-08df45a5f6dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|261009223027099003|56012099006|11063799006|261021123027099003|10067099003|261026121527099003|261102123227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: nux7J/UXbw9DrCU434tVNxGmNX7yHa639+N8MdKb3WKQA1IsSJ6JRD9MddcsgA3xSq0EVNf46LjuqH5cWGJTKlwrjHagyO0C/+XdY47dYWIOdix6By1xvby/cvU0efGLbP4lj2DuelUv3T3+5T6L5FlMTzdijo+e6ZzYlGM/0h9WyNoPS2AiYgi776qXCNSSUj6NjCWZozkY1QMe7/mYGtrpEte7+paiePEQ0CVMiZsHKrZlB3oRUCj/U8bWSPIEqHYo3MVJznjmnHzEhF7+UxNADqEm341c3Xup0e97MWIBssTRyHuoiJAJD1RKL5dUK8CoCwAD7EcuCpNUsA26eYHr+p2l5xs2ZRqyv84vEg/OOk+Lw495OIYjPj8cRFbou6K8pAnvCxHR9+1SFxYPqFTnNlj4JQRU6izOcFtRXtXWdv0aDSGbp02PEmb2AjouobanuIozq3uEwPaiIOAuSeVN/4nT49IQ7B/bYAFpXUcyDeHaZJy8UUHpPnsUP8skd7MPerAWEjdLD+b8sJ66xllpevGP+pUMBOm584sfwTdAaOEC1zmOjJwp3d4EPcnhJQiQo3SkW0d0RLTdD7wdPBvnfU1ZKorTO7OsD6E0z1SJEv2V+Q02PuCYeJw6Apzb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5805.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(56012099006)(11063799006)(261021123027099003)(10067099003)(261026121527099003)(261102123227099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmlyZWJtc3d1SGk5QU92SGIvQ3NieTRjMXVNaHRuR0YzM01Kb3BvRkc1SkhG?=
 =?utf-8?B?ZVdyQ2kvOWZJK2xjUWhZQU81NDdMYVhFWk04OTd3VmNQem1HN1JWL1B2NDZW?=
 =?utf-8?B?YTNEUlhiTHJkcGlJMjZBb3QwS29lbUNYM1MvVE1lSGZKSU0xZ3NFblJCUlFV?=
 =?utf-8?B?UEN1dmVYWXNUOWZaTlNQUUdHeFgyR2czbmZSM2JBYzFoU2s5MWJORW1qTWFY?=
 =?utf-8?B?TXdQQVlKTlBUV0RTTHNLSTVacDVta0NncGpBRVRiLzM0c05FcElaWFppQ2Jj?=
 =?utf-8?B?QXl3RjlaVVB2N0ZyTmcrL3BUU0MvOXVPcHQvQ01xM2Z6ZXMrQkN2K25VbmQz?=
 =?utf-8?B?amNBVUhJWWtwWUR4enQwWVZsQm9uOEJiV3BsaTVEbFJaMmVYeDZQS2dpRHFn?=
 =?utf-8?B?T0VQek96Z1pkZUpHakFONnJJYTlYd0RYRWVGQnZrUGFtZC9xZ0d3ZHJObTZS?=
 =?utf-8?B?UTdYWU5wQzNJNFVWV2xOK1JwQXJPUTJpQS9tMWhFZlNLdkl2V0tBT2JxTHoy?=
 =?utf-8?B?L1ZtMUhTQWhFYlhPVmRlRjBsaklic1FuWmhWOEJsTUFtNjhwZUp2czZORU83?=
 =?utf-8?B?WHZjNUcxNm8vOXE4eGk5OVBWWTZzRE02QXU0RXlnb1V6RUdsTlVHcmFWWkxo?=
 =?utf-8?B?NnFFWTlhQTZNVFBzN2NKRmlrYU1FTmUrZW5DOXJHTDlzVXhEWDBGWUpDd0xT?=
 =?utf-8?B?b0d4WVVnZ2V0YllDd1ZLYmNZMW4yM3VWZzMzZ0l0NG92NXhDMHF6ek9KS1g0?=
 =?utf-8?B?VnBDc05NQlJoNG9pL3RtWXZVVGVETkVXYjJ4Y2JKbS8rdGRCbkh1TzhqeENh?=
 =?utf-8?B?Y3F6VGFaTys5cG1BNThzR2FqYjFjVkNSZlFRc2dSZ2oxSEJJak5kU0owalNk?=
 =?utf-8?B?ZVQ2QWwvam16QVh5UEpITTgyOERvU2d4TjEvbnhoaVJTZGpXeXFidGxJSlNC?=
 =?utf-8?B?b3Q1NkF4ZE1MWTFBRWxuRWpNblJ1WERuT3Y2TFFYZHl1MjZGT1pHenhjVEJX?=
 =?utf-8?B?QlU4MlgvWEMyYWhuSEd1NmZSL0tHTDZacENXOUFVVDVXcDJnNWFaczZQMldn?=
 =?utf-8?B?MzVod2ZXakRjYURYQTlwRXZOZ1VLUmdxUG5XL0xtSVB5aWtYdGV0OGg5VVY3?=
 =?utf-8?B?akpnOUczMVg4SU1GYVIrT1ZqSTdhdGQ3UnJrUnltbGZWV3VGVkVzT3VvMTR5?=
 =?utf-8?B?ZHB5eG9iZFN6UXBmK0ZwUWw5Mi9JZmpVbHJOUHYwY0FGNGk5ZzNqekdqTjlX?=
 =?utf-8?B?N2Q2bGtJWVlCR2NiMjJ4WmxieS9nN0ZCRUM1cFk1NHdjcjUva1BvSS9jVVJZ?=
 =?utf-8?B?d2xOZFpneUc0dWxJWWE0cVY2VC9RQnNwVmFnYTNsNWtvY3puT05aUVpqamxn?=
 =?utf-8?B?OVBXcG9UcFNHRU9KN0htMldQL21uaHN6MXNucExKeXFzUU0wQkZnbXp0eWxC?=
 =?utf-8?B?bHFGUFZzYzJDNlhmdjhxU2N4RmFDa01QL3ZQNkJMRHhXQTJYNVFQOE4xYWtp?=
 =?utf-8?B?aUt6OWVRTElDQXIxRmdEUCtYVnZYOGFMbzl1RkMxTS9seXlUWnJGOTNDL1ZZ?=
 =?utf-8?B?NmY1Q3FvbTBLZjJEL0grcVRsdEVySjJMU1lZSjVWSjRDTDIyTWtCZjRmZ0tp?=
 =?utf-8?B?c3YycG1zaUcvb2tZM2lvSXQ1MVlNVDBwdGVSQVlOdFJTNlhqeUl5Wlo5RDRQ?=
 =?utf-8?B?S1N0SmRvWmJlWWtaa0x3UGxJWS9XYWF1NmNYUFR4bVNjaDBKZ2UwUjNXS2ZU?=
 =?utf-8?B?MHNLZ3ZGVWs0MGZXbjhYMUNMcGNGdVdvVnVLc09aZkdsN0UycGRpa2EzOUxW?=
 =?utf-8?B?QUNDaFNRS3IwZDJqd1NscFZ2ekx5QjMxUWtKQnJKdnpQYjZGTHBiQ3hGR1Zl?=
 =?utf-8?B?c24rS1ZzdmEraERYNEt0ajBHTFpjRTg2NngxL2t0MGl3dGx6a3ZLNnlHUktC?=
 =?utf-8?B?RThmdmsrdVdPMytrWlUzSHV3Y01lK2l3VnpjTGJlZzJNMU9BamlCcUduVWtT?=
 =?utf-8?B?eWdCTVZnWHJoMVk5RmpZSndzQWVmbmo5ZGU2WnowM2JsakRpYkpWU1UzUnUx?=
 =?utf-8?B?Q05LQ1pTR2hRMFkxcXRXY3FMbUpCQ1FzVDFXdkV1MEFZemVuRnA5enVXRWJu?=
 =?utf-8?B?R0wwTTVzUFVXMTVjbEZHMUNrclc3Mk9jTHMrUmRMS2dRdTBlWHdVOTBBNTFX?=
 =?utf-8?B?RXlna2I1a2UzaVcvd1JxSnFsUTlUL1RrSm1DemVSOW1KMUdWcUM1K0trYWM0?=
 =?utf-8?B?bGZrcmc3eUpGOXUrOGFOc1psTnNtYTAvUTZobkZCM1lLdkt0eWZIQzc0NVZG?=
 =?utf-8?B?MVMxTi9rcTlOZmt5aHJNdkphTWVpUW1JTTlkbW96b1R1bmVlYUY3QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216feb16-a969-462f-dc38-08df45a5f6dd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 18:58:42.5076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fc9Z0TVQa/UjdfzocOkZICFMsJ1hVZ3poCNOXJS13oe86gBPfO2XlfA6MAlzD7yxhXfI3LCb4IJKZf8JNyyPXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999275
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-18 13:52, Benjamin Cheng wrote:
> In [1] I originally wanted to just stop using amdgpu_bo_fence. However
> while attempting to address Christian's comment about reserving the
> fences upfront when the PD is locked, I realized that there are many
> places that are not reserving enough fences in the worst-case.
>
> I went through and audited every lock of the VM root PD and I think I
> have caught everything missing fence reservations in this series. I
> have lightly tested this and didn't see any issues, and in general
> this is reserving more fences than the typical case so it shouldn't
> cause any BUG_ONs.
>
> Patch 1 through 3 here are the reservation fixes. Basically since we
> started enabling more clear/move entities to be used, we should be
> reserving the worst-case space upfront. Also when the TLB flush fence
> was added we did not add reserve space for it.
>
> Patch 4 and 5 are cleanups that I found (not everywhere locking the PD
> does validation or VM updates), and patches 6 through 8 are the
> amdgpu_bo_fence() removal series from [1].
>
> [1]: https://lore.kernel.org/amd-gfx/20261112164408.1748006-1-benjamin.cheng@amd.com/
>
> Benjamin Cheng (8):
>   drm/amdgpu/vm: reserve more fences in amdgpu_vm_lock_pd
>   drm/amdgpu/dma_buf: reserve AMDGPU_VM_UPDATE_FENCES for move_notify
>   drm/amdgpu/vm: reserve AMDGPU_VM_UPDATE_FENCES for handle_fault
>   drm/amdgpu: reserve only what the caller asks for in lock_pd
>   drm/amdgpu/userq: remove extra fence request when locking PD
>   drm/amdgpu/vm: stop using amdgpu_bo_fence
>   drm/amdgpu/uvd: stop using amdgpu_bo_fence
>   drm/amdgpu/object: get rid of amdgpu_bo_fence

Sorry, please disregard this series. I forgot two patches, sending them out shortly...

>
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 13 ++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  5 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 25 -------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    | 12 +++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  6 ++---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       | 17 ++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 14 ++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  8 ++++++
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  3 ++-
>  14 files changed, 58 insertions(+), 56 deletions(-)
>
