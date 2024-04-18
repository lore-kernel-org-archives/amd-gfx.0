Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16370C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 20:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99563113FE0;
	Thu, 18 Apr 2024 20:50:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lcgN3kqY";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3F00113FE0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 20:50:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FccInkp1eCK72w3gkb5WPyti7xvfepOoPA+YrIK1N4Uw2fsFbhxAZ7jIFUz3HrFm3JiSA6RilXKNF/7ls4VuO3nlolpSH1IjjVSl+XoHC6mFvtdbt9MxQ0SuNSmPjn4N+8LT5ILj2X9EjX1lm1u+IXLvjgX0NIfYe3XyF872aUo0h1HLo5jKDgmN9l0AcT6g7gEvUSswWdeHIXbl+f3vJHni9YZ0tRqzZv9zdNnhemdJB0ie2aDgkEg6m0+iwXoMTSH++ZYt8p3z+M22hWM75217x7Blj//CkkUO9EpIdhqVXDuUV5p9UpTvdSJKrS6iQvXMfu0Y7xYCgnZECgRN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKAbkbqS5OTUCU97mVKarUN4F9BCCQLAsezXFzc2U24=;
 b=BQ1oKSllCDlnsawDehGHsgqr+UH4+YO3ghb+RqvYxZ+p05I45yDdvQpNU5tolzs4K84VgOKbYhh9QhwAk4gNDHWCTEjwpIBoBxJX/eDyAzO4sQ4495cXDU00lUkydInW0ZnaVdHoh5RWiEMB7DW1yEn8qcOzf9mvckJQvxE7mk+Bi1qYoej+ljYc5YAbpV0legOUXAhtP36tjGxbHSGsTpJNqsRzknR2gWry1wa1b+bt6AUucTxjs6prz+Q1dVF3FuzqCKSUswxw54oNNdGakHdhZMYJKW+A+8Qv9CR0YNfniMVwWWNtZtZV01fd9eim2sayzbn9gZ4Y18km076vbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKAbkbqS5OTUCU97mVKarUN4F9BCCQLAsezXFzc2U24=;
 b=lcgN3kqYwF1zyFleS3NWJgS8N1QJV2WaRxWvLHr24ul8AQ2u0C7pdbGOtAFzxbPtQdSRUDq51uJTbbyIuND8rcj0UbO8LSABpL8viKUsdlwZcUFewaqOOIzDJzeCnTuX5cFwRZNPiuzjk7e2hwdDml3GjO6Me/IzoIk+0xWIoas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH8PR12MB6819.namprd12.prod.outlook.com (2603:10b6:510:1ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 20:50:19 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a%5]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 20:50:19 +0000
Message-ID: <47fd1f92-e592-00bd-2298-3fe476e9bffc@amd.com>
Date: Thu, 18 Apr 2024 16:50:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/6] drm/amdgpu: Support contiguous VRAM allocation
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com,
 Arunpravin.PaneerSelvam@amd.com
References: <20240418135803.17365-1-Philip.Yang@amd.com>
 <20240418135803.17365-2-Philip.Yang@amd.com>
 <dbc3534e-dc5c-42bb-8e83-66d047481f9a@gmail.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <dbc3534e-dc5c-42bb-8e83-66d047481f9a@gmail.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::14) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH8PR12MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec4c4b7-058f-4845-ac34-08dc5fe92876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5fB9l1P/6C0JzuzFMT6sFhKQp9Il7eXce3shFaFxZ9U6qQ0Yylg2SqX/NCxPtL/te0MPq996slw2TTtgVLULOkwo9zpkGPMheTBS6BHWLKBsjUthujGKrywppt72RHGEhREOnrQIY1AL3hEoc+IOcm/SEj47sgTAyPH0o3wK0r4OyKYbWk8uVdHDYEPz44yDNaxIkCN5GiZsXG6GyNC9eLlXQB6+E5whCIBvqpGkXAH60n7efDt231ENWSOhm6I1Lw9KdL2uTnnIo88GRQqysNltHUlAnF3TQ0dYUryymGhm16F5onuMMq6nKhglpCP+RYUGnNxNTycQGywcs9o3c6SWpfKNHKJWrxqSF3qpdeJyCEJcRa6u16wPdr3B6Hpfeha5wF62M9r4rKaQHII4gi2xNJrE9XsEw8isa0kfnsT2iDHB+gmEPmlF9eWC9aC+NqPPG00iKB3JsmWjtXZpk6H69QtirNtCITjWd8tu/ljrZEl4X4epqxUo9roxY72tGRU9iaOr/Yhf/EVgrTfF3lQXpMS3ljrMShgK5/Z0hSjiof8muDhycQoKErc57IPDrogGAlt0hEhxqPTHXwNq2Mn5kSQUD74bkkv2NxRwvd8IiXxwBatMDt7u8qUQiNRxBBVjeLka+VgeGMmF2034BIVn4xe5oXysz3jdOjFgtqo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUdxR3luUlRXTC9YT0plYXJkK3grL01NenI1ZUQ1WlZaU3N6bEMvaFVKV3hZ?=
 =?utf-8?B?ZkJpclVJazZRa0o4YlpFbThxTnY4eFpYeTVGbTRURlh6N2RYTzNyeGNmTVA3?=
 =?utf-8?B?UStGam5INGVUQWZXRzI1Sk5MRlE0anpzTFZjT3FnSDE5MW9haUZBSkNaNmhl?=
 =?utf-8?B?a29maFc1QVdieVU1MkVERFBCc1NCVzdYVHhtVkJwdG5HVHRmUVhGWVZxRm9B?=
 =?utf-8?B?YXJLRkJhL3NiVis1MlQ0NU9FQ0Zaa3ltb3Z4MVlzc3FXZ3U3cytZM29uT2RH?=
 =?utf-8?B?N2p6bkxzV1lmb2x6ZWMzWERKY2NTazRSU0x4Yjh3UnUzZFVvdDU4bXMydk5H?=
 =?utf-8?B?TC9RcjlkTkFjU0Z1REZhWXhpcGpuUjEwVDN6eHBSZkoybHBNNndPRFRYek9G?=
 =?utf-8?B?QWU3cFZEam1wTndRL0VGK2lnd3I0cmJnZWtPYWN1NitUTUhVZ3lzMXNLWEFx?=
 =?utf-8?B?SDc4bzMyZnJ4dlFIOHJOcW1wWWovV0RoYW9CRTdNdi8xN29XMENlY3ZlazRE?=
 =?utf-8?B?WmhlZWxaVEhTVWgxTWd3OFRXSkFHOW54c2taTmtyT3dCdnF1U2crbDJxdlBy?=
 =?utf-8?B?UnRGZHVFZWRWUHhXd3lmZUlKU1pOdVp6ZlVpVjRQSTFJc044TTIyYnRIQlBZ?=
 =?utf-8?B?UTRCaTdacWpmckhQRHg1aFd4cTk0S3k3WWNmd2xKUmRWN3BOUk9mSFhXR0dB?=
 =?utf-8?B?cVFkL2M4d055MkRMY1p1ajJUWGxvMXZieXVpeDlDRmg1UVVJSUtvUWxwalRv?=
 =?utf-8?B?UVRweXFHcFlvblB1dS9zbTA1QlpqN2MvVjNLclpvYmZJdWk0SXhjZWR6aGVs?=
 =?utf-8?B?TENVT043bUkwTXZmemY2QWMwUStLbEhSb3FNVXd3dW1XalZHdk92VkRDZk9T?=
 =?utf-8?B?V1hUTURDd282ekc1aDhieDBYQzFRMDNuZTE1UnduY29zY09qdDY0OU1MMDUw?=
 =?utf-8?B?eUhOS1NvdGg4emlIM21NZHNKdHZMM2dKRUtxTzZZOWF2dTBoN0J3eEQ2bGNH?=
 =?utf-8?B?Nlo3RXYyVjlKaFNBWU50WjZsU3NYaUsrNDRLUVF5QWx6WGtOTk1ObUMzZXBM?=
 =?utf-8?B?a2lKaUdrLy9rcGdKL3VkaWRONVI1ajBvRG5xMExtWHNVWWtCV0tKOENDZjAy?=
 =?utf-8?B?d3NNVm5DdjJ0cDVOZEVNTCtrZXpvOVlNNFk5bUxRbVczNVduaFFzdTBocEhr?=
 =?utf-8?B?bEVrMFpKaWFrOWNBT1NsMUl3SzBYM3FIcWdmZ3c1RFlBQ2pKM1ZoUkM3VEsy?=
 =?utf-8?B?LzlWQUIyMEl5VitDTjAwMk9vNGZMaEJTajdxZkdPT3BNSVdvNDcxUWR4QnhJ?=
 =?utf-8?B?L3ZOWE9CUTF4TW1DeHhIb0VRNkdpaFRhYWljUjRRSC9QV1JmT1gydUtST0pB?=
 =?utf-8?B?Zm9Ia3padHlEN0xGRDJneUViVXhSeDhMYk14WGVMUDVFRWhTT3BZbEpldHBk?=
 =?utf-8?B?VERWelJOelV2SCsraDFVVTVJZlc4NEFsU2ZreSttRzRRdXIvRENDWURIWGVI?=
 =?utf-8?B?UWo2UGV0WmxObzlGQ25pUHM0NHVPbVlIaGNuY2FGSFZvK2ZhSVJPVGh4TGNx?=
 =?utf-8?B?QmNxNDVybm1zTUJoUWhRWUpKVU5seFJjSnhLT3l1RmI4STh4OTdTdXFvaktZ?=
 =?utf-8?B?MVhkTmdjVisyR3ROQ0s5bEVucGZyNndaT3BiTnUxMFk0b0RwMEdXd1RWVjlU?=
 =?utf-8?B?ejJZdlcyYlI2N0t3SExSTTJzQUEzVjVGclRVSllDZEprQnE0VFRNOFEralhM?=
 =?utf-8?B?VlhrdStVTjg3WWJnQmU0OWZaQ29QRDkwZFNaK3RMRnFERldDWFM2dUtIL1Bx?=
 =?utf-8?B?V3NSSlZUOTllTnZGRmpYeWxkVXl2cSt6LzFtdm00RXQyY09oYlVnWWFlOFQz?=
 =?utf-8?B?UEhiTlNnYjlOaDl3blZHbXRUbnRGQXROYlptNDJxYUZzNW1HZEMvZkx1T2xv?=
 =?utf-8?B?SllWSGF1VnQvQVNmTGhIVkhLem9ucHlVdS96RmFzUTdRUWg5VmE3ZHhjdUpF?=
 =?utf-8?B?d0MrR1lVRHBQL2Z3RGhKcG9rRUx5QmtrWi9Qd01QWkhQa2ppTGJpaUQ5VGl2?=
 =?utf-8?B?RTAzbWJQU1p3UHU1bzh1Zkhobmczd3VKMzFFQmdmMTNuNkxFT1NBNDFMWUFi?=
 =?utf-8?Q?b53E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec4c4b7-058f-4845-ac34-08dc5fe92876
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 20:50:19.1958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfAL1DVSC/g8J0PyDsK1c+brXk8hbwqTrUB2v2wgPVuOUMW/AU2YMDWja86XZJEf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6819
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-04-18 10:37, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:dbc3534e-dc5c-42bb-8e83-66d047481f9a@gmail.com">
      <br>
      <br>
      Am 18.04.24 um 15:57 schrieb Philip Yang:
      <br>
      <blockquote type="cite">RDMA device with limited scatter-gather
        ability requires contiguous VRAM
        <br>
        buffer allocation for RDMA peer direct support.
        <br>
        <br>
        Add a new KFD alloc memory flag and store as bo alloc flag
        <br>
        AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS. When pin this bo to export
        for RDMA
        <br>
        peerdirect access, this will set TTM_PL_FLAG_CONTIFUOUS flag,
        and ask
        <br>
        VRAM buddy allocator to get contiguous VRAM.
        <br>
        <br>
        Remove the 2GB max memory block size limit for contiguous
        allocation.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c&nbsp;&nbsp;&nbsp;&nbsp; | 9 +++++++--
        <br>
        &nbsp; include/uapi/linux/kfd_ioctl.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1 +
        <br>
        &nbsp; 3 files changed, 12 insertions(+), 2 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        index 0ae9fd844623..ef9154043757 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        @@ -1712,6 +1712,10 @@ int
        amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alloc_flags =
        AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alloc_flags |= (flags &amp;
        KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For contiguous VRAM allocation */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flags &amp;
        KFD_IOC_ALLOC_MEM_FLAGS_CONTIGUOUS_BEST_EFFORT)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alloc_flags |=
        AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xcp_id = fpriv-&gt;xcp_id == AMDGPU_XCP_NO_PARTITION ?
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 : fpriv-&gt;xcp_id;
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
        <br>
        index 4be8b091099a..2f2ae7177771 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
        <br>
        @@ -532,8 +532,13 @@ static int amdgpu_vram_mgr_new(struct
        ttm_resource_manager *man,
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(min_block_size &lt; mm-&gt;chunk_size);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Limit maximum size to 2GiB due to SG table
        limitations */
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size = min(remaining_size, 2ULL &lt;&lt; 30);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (place-&gt;flags &amp; TTM_PL_FLAG_CONTIGUOUS)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size = remaining_size;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Limit maximum size to 2GiB due to SG table
        limitations
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for no contiguous allocation.
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size = min(remaining_size, 2ULL &lt;&lt; 30);
        <br>
      </blockquote>
      <br>
      Oh, I totally missed this in the first review. That won't work
      like that the sg table limit is still there even if the BO is
      contiguous.
      <br>
      <br>
      We could only fix up the VRAM P2P support to use multiple segments
      in the sg table.
      <br>
    </blockquote>
    <p>yes, you are right, I didn't test with buffer size &gt; 4GB,
      struct scatterlist-&gt;offset, length is unsigned int, this limits
      each sg_table entry size &lt; 4GB.</p>
    <p>I will do more testing, we should still get &gt;4GB contiguous
      VRAM, will add another patch to fix it inside
      amdgpu_vram_mgr_alloc_sgt, to split it into&nbsp; multiple sg_table
      entries, and RDMA peerdirect app should be able to handle this
      case based on sg_table-&gt;nents.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:dbc3534e-dc5c-42bb-8e83-66d047481f9a@gmail.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((size &gt;=
        (u64)pages_per_block &lt;&lt; PAGE_SHIFT) &amp;&amp;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(size &amp; (((u64)pages_per_block &lt;&lt;
        PAGE_SHIFT) - 1)))
        <br>
        diff --git a/include/uapi/linux/kfd_ioctl.h
        b/include/uapi/linux/kfd_ioctl.h
        <br>
        index 2040a470ddb4..c1394c162d4e 100644
        <br>
        --- a/include/uapi/linux/kfd_ioctl.h
        <br>
        +++ b/include/uapi/linux/kfd_ioctl.h
        <br>
        @@ -407,6 +407,7 @@ struct kfd_ioctl_acquire_vm_args {
        <br>
        &nbsp; #define KFD_IOC_ALLOC_MEM_FLAGS_COHERENT&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 26)
        <br>
        &nbsp; #define KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 25)
        <br>
        &nbsp; #define KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENT&nbsp;&nbsp;&nbsp; (1 &lt;&lt;
        24)
        <br>
        +#define KFD_IOC_ALLOC_MEM_FLAGS_CONTIGUOUS_BEST_EFFORT&nbsp;&nbsp;&nbsp; (1
        &lt;&lt; 23)
        <br>
        &nbsp; &nbsp; /* Allocate memory for later SVM (shared virtual memory)
        mapping.
        <br>
        &nbsp;&nbsp; *
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
