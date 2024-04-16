Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E189C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 14:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4012112CDA;
	Tue, 16 Apr 2024 14:30:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t5mgFipk";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AFEC112A9E
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 14:30:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CevZpu3+DXuWl/sFElE3d8s65bylU9ZsODEtIdhPbLAHH0QYa79VQbcB/5+NItQu0PTbFGD/Hl1NTKP4bp96XJuAL4WR8+3rIqzPFl8yh3SYTS9oDa9Xw2Qi6e9Qtn8UR3aa3ldYjO5+ZyK/xuAlzze0U3nmeglf+GXHlwgR3u/bDl3jiKmqt7ZsYBR4U4PiWVABtJeztFX/JjD/32cIvGHLMxH+7CHb+6I8blvBapLD1iqbDQmUzpFFO1P/1M4b42/IADHQZKTKjh5frLthQk0ZgkVZbgf9dXagutdHVOl2E12LneB3Flj/BqeujOQK8VCI2dURbJRd5NKWEZZvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDNfidJPJykfAN/g4fm6UWH+INNrykBrqAm2vXVt7i4=;
 b=Hlhe+Iov39jOA/ytXas1C4Ayf+rxYvTsaLsruLqd2TzIwpTE5iOd6EqRzvtlhsVULovquk+nue7ucbOo0KXSFgWmj78cnvSLyolngSJYOHprpQVuYtGQy5qmrGKg92blAkUxmAKlrwJjyoqUjx4HZjwyMloti098RpqQJf6GIyRV2f9b6K+73r3gNhJDggyERRJkB0HFi5DD4MgKhc6wmCLeZT6H1K4wHlhIToTyCwEWWHiBaAPr0LctY8BOZgBcpuPO9wQovsVSWeNBgjlynD9HASkwtZ8Xx2ZOps0Nay9s5soMFEfRjebgbrErrxrmjiGJl9OPUl5iZ7la47Ro2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDNfidJPJykfAN/g4fm6UWH+INNrykBrqAm2vXVt7i4=;
 b=t5mgFipkY2+Uur9g9cerlie3QLtQfr252H60iCW2scVnW6UW4RkUBdpPmjB4pgJLKFVm2btb5Ghcui1Q2xTqYfn10bei2DIGhKY5ZLp3VslwSpEsKAVtrp4weaBCnyfz9tubm5+WlYFwO31tR5Li/EUADhrU314Ux2Qyip+vqKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MW4PR12MB6923.namprd12.prod.outlook.com (2603:10b6:303:208::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 14:30:31 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a%5]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 14:30:31 +0000
Message-ID: <3f91aa9f-615e-82b6-902e-0d0232c6114c@amd.com>
Date: Tue, 16 Apr 2024 10:30:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Modify the contiguous flags behaviour
Content-Language: en-US
To: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 felix.kuehling@amd.com, philip.yang@amd.com
References: <20240414145731.1829-1-Arunpravin.PaneerSelvam@amd.com>
 <01b794f2-1f9f-e8ac-1c0f-1acd199e09ea@amd.com>
 <a8fd7808-a4ae-4e1e-8aae-be22bd4fd3b1@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <a8fd7808-a4ae-4e1e-8aae-be22bd4fd3b1@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::23) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MW4PR12MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: 15264e40-8f8a-4904-747c-08dc5e21c4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lv6NIdM1M7LQtzNIzlTR0BYujgCPBn9jcd9FDyX9MvZdqyCwrEsblQLmAK0ZQaJoZSaqQeN55a9S+rprRFedEDLW7WFQ/+XZslrbmvy6cTuskK/Zq+Bxcjwdav2v6oUBEF16r1Jp5saOVRrybAKgihfsXZkNtSqxfE61nO0EDlB14BrikcuP/bjYIDgl3szVyGLUai7IxA9moeKQapEeIplYEBRLQkb341rdItlMBq/IDK/50sgTXAeZ6SehRDkkvjxHGUbVzqJb7jOd3EOTBMCT3RUHWIeeVqXjFoZYA3fEhlWOGowqVFHIYUMMdbmlwESBo+3tun3ryNyuLwUsubhgtTvcTrKxvpoxSG+XTfFX4BMJytqo6/VxArR+z+2lZzXAgSnQU6FCBe9sgZ/vqttzzg/J2Jc51GP+x02TIT7hgY/TXWEhr0QV4dq5hR4M1txXYv3EawqNGfEhHh3q+liG4wgherKPmOX0+wA41mNX3I7nqEeqlS8zCCgZvtWJE7vRY/46hyD2+j92JuLdrDh7QtfxqoruovglrYmIwIbKP5321yXrNHUNhaCL3SVL6DNBJl/IwpbD8jxRNLaTucTDbgcS3ovaavy6KcJdtC8MJ70I9izMcdmqzP3qPZ9fpygwtEN+vf9idiPdinOsES3iB2YTtYTSUrRO3W/d3OA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlI2STFianJGY1hLQ0JZd0RoSWp0Vk1ZemVGWDlveDZkYUZ0RkY1cDNYcWxx?=
 =?utf-8?B?Wng1Q0NVdVFrN1EvTGNmQkNoS21tMThjeW5IUHZSdkgzSit4VlN6Sm93Ry9P?=
 =?utf-8?B?aTZxWlpacTNmekxsTGdaeW84bXhoZ1NVV3psMmFWQlVLRU14ZDFHQ0ZsUzhI?=
 =?utf-8?B?YUVuTU50V1k3RXo4M2x0cFI5SmZBQnZPNDV1bS9LZzVkZG9hdnhlaHJneFEr?=
 =?utf-8?B?UjMzSXpvWUNveDFzL3BGaksxQ1M2cHY1ZkZmWXFSUVkrR0RBeGplYmxtdlVl?=
 =?utf-8?B?cEFSYUlpbFhmTFczaFcxS2xJcU1sOG1kSHRmMlQrNk5MY3V6Q2RZbU4ya3JF?=
 =?utf-8?B?emJHQnM5R01MbWovM3VFRXZUTmpjMnhWT0o4WHNMaVZQYldDUGN4bFV0bjFO?=
 =?utf-8?B?eTltT0hoVVdXYXY4MFZha0QrbDlxK0lnTENMbDJPOG9zVS8zOEgwTFp3b04z?=
 =?utf-8?B?RzQ5WWtKSzF0NTlKd1RNYU9MUUxIN2lucHIrZU5iRVlWR05oOHhXSFEvUGlB?=
 =?utf-8?B?R0UyOHNRWFJTQ3NQUmJqbkZLYi9Eb1lKZnhHMTNsVWxCdkZMR1Y5bHg1UzNR?=
 =?utf-8?B?SGREV3FkUzZNRERmVUdQcnVWbWtVTG1ZdDRXeWYzMGZCVjhPYkNyQW1Lbkw4?=
 =?utf-8?B?MVBsNnFja3UxVkd1Z2hUVDB0RDV2bHU0bW5vVUpTRVZEK1Rjb0NiMkUrc3Zr?=
 =?utf-8?B?dHlDVmN3d2ZMdDVza2JsNlhQT1E5RWcyQ09rM1lHdG4yYVhTblJtMzE4T3dB?=
 =?utf-8?B?WTY5OUtMeE9veTFFWXBCeTNaWElUS1RFUHNaT0FUS09IK1lEOTVGUEdveVE0?=
 =?utf-8?B?YS9iUi92U0VzSTVFMVdmUkxoN1l1VkVpR2F2QWl4V2lxdWJyb2tEbEhBRk81?=
 =?utf-8?B?aU8yMDdzVzh5bVZOY2NseVJDSWxnSkgwWmM0bkptQUpuTGlLTldRcW1mc2o1?=
 =?utf-8?B?T1ovL2I5dXlic3J0Mjc1R29oOVdvRWo3Sy9LRmE4VVlaS29SVHNSTldhSlJs?=
 =?utf-8?B?Rjd3eG9EcUFiTWxLWHE5UWg2WmJSOHI2QkxGcm9MUjJHOUxVVVQxMWRxR2gx?=
 =?utf-8?B?Wlc1UFo4RVNSRVlobWp3cDloUXRaOU80S3d5S3N2YXcySWJjeUdmZDZSSVRR?=
 =?utf-8?B?aWZMcTgwamtGVnJ6c24wdTFXT3JkZEdKdzYvTWJwL3BSeGd1N1NoRFRjalQ0?=
 =?utf-8?B?N05nWG14VEdHMnNDTzlWYWwwZTlFVWFUNG03WlZ5WGZOR2tMNFRWNlpxVkM5?=
 =?utf-8?B?bVRvZGVTQ0lzYUo1emNWNkRIalhHS1UrYm0vYkJ2TWRRQVR2eWxpekNwdUN6?=
 =?utf-8?B?Sy9lZ3JLWHhmaDNhSFZxOG9ZcG1BQ2Q3ZG1KYjVsQVpDSzRrcDVyQU43dHJR?=
 =?utf-8?B?eFBvNHRzUnY1dFJPNTU2ZVZydlBnZU9lR1V5SXhaZUhpMVV6OEdubkVnWUdl?=
 =?utf-8?B?M0Y3ajBmOWJhY1ZTcTkrZTlXdUp0STJFazhwL3EwbEZ5bURUa05PL0VrbGtj?=
 =?utf-8?B?Z2xjM3lKYWRLWE54dlRHcm9sSUYvYzdsZlZGanBVZTA5Q3Z3SWRyN2NpSFg2?=
 =?utf-8?B?R0tHRmpiWkVPREdJeTNERm50TlNVRTVBakpiL2VocWpVY1B1S2RLaHFQbGVP?=
 =?utf-8?B?U05lY3gwdno0c2lpVitEcUZWMVJOSXlyc1QvQVc1SVhnVU1DNEFDSkpHQ25h?=
 =?utf-8?B?bnRzbEZIYUxDYllUN2Q0b1BBOFRJZ3BqVnhpTSsxTGs5Q0s3Rk42T2lZay8x?=
 =?utf-8?B?SEtZVnpqN0RWS3pkU1RyelYzL0FPWXNXcFRBNkRiRndxREpLQ1ZuQWdSTGlt?=
 =?utf-8?B?a1JtVjRnN3R0Qk14ZzNaZlp2dzhEY0Mvd0VpanRoTk93T2VOVXRZMnY0NDhL?=
 =?utf-8?B?UWUvMndnM3B3S0R6dHJqQnl0MHFFQnRYQ1YxZTVBY0RIdEhxU1ZuTUJDQ1Fv?=
 =?utf-8?B?K0RHVmpZQjBFYWpiVVYwUTZ5V3ZGOUdsMzlER1dmQ2VGMzZ2eXlNRHlPajZz?=
 =?utf-8?B?c0dVZWlaRGNwSjdFMUxsUkk0K2VWM2hNZ2U2ZkgrbCt3QVppalN2TDVOZHNZ?=
 =?utf-8?B?UTFZRSsrcThsUkJtd0VDUzRPWDJiZGwwL0VyY2phTU5YbnVaMWx3SzFVK3lV?=
 =?utf-8?Q?MljQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15264e40-8f8a-4904-747c-08dc5e21c4c5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 14:30:30.9717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NVrCrxQaB1B4sNtU9nqWnhA6z6YiXb51AiydyKddeE4r+ksxrbJL0qJ+seMM/XK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6923
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
    <div class="moz-cite-prefix">On 2024-04-16 02:50, Paneer Selvam,
      Arunpravin wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:a8fd7808-a4ae-4e1e-8aae-be22bd4fd3b1@amd.com">
      <br>
      <br>
      On 4/16/2024 3:32 AM, Philip Yang wrote:
      <br>
      <blockquote type="cite">
        <br>
        <br>
        On 2024-04-14 10:57, Arunpravin Paneer Selvam wrote:
        <br>
        <blockquote type="cite">Now we have two flags for contiguous
          VRAM buffer allocation.
          <br>
          If the application request for
          AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS,
          <br>
          it would set the ttm place TTM_PL_FLAG_CONTIGUOUS flag in the
          <br>
          buffer's placement function.
          <br>
          <br>
          This patch will change the default behaviour of the two flags.
          <br>
        </blockquote>
        This change will simplify the KFD best effort contiguous VRAM
        allocation, because KFD doesn't need set new GEM_ flag.
        <br>
        <blockquote type="cite">When we set
          AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS
          <br>
          - This means contiguous is not mandatory.
          <br>
        </blockquote>
        <br>
        AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS used in couple of places. For
        page table BO, it is fine as BO size is page size 4K. For 64KB
        reserved BOs and F/W size related BOs, do all allocation happen
        at driver initialization before the VRAM is fragmented?
        <br>
        <br>
        <blockquote type="cite">- we will try to allocate the contiguous
          buffer. Say if the
          <br>
          &nbsp;&nbsp; allocation fails, we fallback to allocate the individual
          pages.
          <br>
          <br>
          When we setTTM_PL_FLAG_CONTIGUOUS
          <br>
          - This means contiguous allocation is mandatory.
          <br>
          - we are setting this in amdgpu_bo_pin_restricted() before bo
          validation
          <br>
          &nbsp;&nbsp; and check this flag in the vram manager file.
          <br>
          - if this is set, we should allocate the buffer pages
          contiguously.
          <br>
          &nbsp;&nbsp; the allocation fails, we return -ENOSPC.
          <br>
          <br>
          Signed-off-by: Arunpravin Paneer
          Selvam<a class="moz-txt-link-rfc2396E" href="mailto:Arunpravin.PaneerSelvam@amd.com">&lt;Arunpravin.PaneerSelvam@amd.com&gt;</a>
          <br>
          Suggested-by: Christian König<a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
          <br>
          ---
          <br>
          &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.c&nbsp;&nbsp; | 14 +++--
          <br>
          &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 57
          +++++++++++++++-----
          <br>
          &nbsp; 2 files changed, 49 insertions(+), 22 deletions(-)
          <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
          <br>
          index 8bc79924d171..41926d631563 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
          <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
          <br>
          @@ -153,8 +153,6 @@ void
          amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32
          domain)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; places[c].flags |= TTM_PL_FLAG_TOPDOWN;
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flags &amp; AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c++;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp; @@ -899,6 +897,8 @@ int amdgpu_bo_pin_restricted(struct
          amdgpu_bo *bo, u32 domain,
          <br>
          &nbsp; {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
          amdgpu_ttm_adev(bo-&gt;tbo.bdev);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_operation_ctx ctx = { false, false };
          <br>
          +&nbsp;&nbsp;&nbsp; struct ttm_place *places = bo-&gt;placements;
          <br>
          +&nbsp;&nbsp;&nbsp; u32 c = 0;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, i;
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ttm_tt_get_usermm(bo-&gt;tbo.ttm))
          <br>
          @@ -921,16 +921,10 @@ int amdgpu_bo_pin_restricted(struct
          amdgpu_bo *bo, u32 domain,
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo-&gt;tbo.pin_count) {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mem_type =
          bo-&gt;tbo.resource-&gt;mem_type;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mem_flags =
          bo-&gt;tbo.resource-&gt;placement;
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(domain &amp;
          amdgpu_mem_type_to_domain(mem_type)))
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((mem_type == TTM_PL_VRAM) &amp;&amp;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (bo-&gt;flags &amp;
          AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) &amp;&amp;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(mem_flags &amp; TTM_PL_FLAG_CONTIGUOUS))
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;
          <br>
          -
          <br>
        </blockquote>
        This looks like a bug before, but with this patch, the check
        makes sense and is needed.
        <br>
        <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_bo_pin(&amp;bo-&gt;tbo);
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (max_offset != 0) {
          <br>
          @@ -968,6 +962,10 @@ int amdgpu_bo_pin_restricted(struct
          amdgpu_bo *bo, u32 domain,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;placements[i].lpfn = lpfn;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp; +&nbsp;&nbsp;&nbsp; if (domain &amp; AMDGPU_GEM_DOMAIN_VRAM &amp;&amp;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !WARN_ON(places[c].mem_type != TTM_PL_VRAM))
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
          <br>
          +
          <br>
        </blockquote>
        <br>
        If BO pinned is not allocated with
        AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS, should pin and return
        scattered pages because the RDMA support scattered dmabuf.
        Christian also pointed this out.
        <br>
        <br>
        If (bo-&gt;flags &amp; AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS
        &amp;&amp;
        <br>
        <br>
        &nbsp;&nbsp;&nbsp; bo-&gt;placements[i].mem_type == TTM_PL_VRAM)
        <br>
        &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; o-&gt;placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
        <br>
        <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
          ttm_bo_validate(&amp;bo-&gt;tbo, &amp;bo-&gt;placement,
          &amp;ctx);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(r)) {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;%p pin failed\n&quot;, bo);
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
          <br>
          index 8db880244324..ddbf302878f6 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
          <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
          <br>
          @@ -88,6 +88,30 @@ static inline u64
          amdgpu_vram_mgr_blocks_size(struct list_head *head)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;
          <br>
          &nbsp; }
          <br>
          &nbsp; +static inline unsigned long
          <br>
          +amdgpu_vram_find_pages_per_block(struct ttm_buffer_object
          *tbo,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct ttm_place *place,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long bo_flags)
          <br>
          +{
          <br>
          +&nbsp;&nbsp;&nbsp; unsigned long pages_per_block;
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp; if (bo_flags &amp; AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS ||
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; place-&gt;flags &amp; TTM_PL_FLAG_CONTIGUOUS) {
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_per_block = ~0ul;
          <br>
          +&nbsp;&nbsp;&nbsp; } else {
          <br>
          +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_per_block = HPAGE_PMD_NR;
          <br>
          +#else
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* default to 2MB */
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_per_block = 2UL &lt;&lt; (20UL - PAGE_SHIFT);
          <br>
          +#endif
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_per_block = max_t(uint32_t, pages_per_block,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tbo-&gt;page_alignment);
          <br>
          +&nbsp;&nbsp;&nbsp; }
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp; return pages_per_block;
          <br>
          +}
          <br>
          +
          <br>
          &nbsp; /**
          <br>
          &nbsp;&nbsp; * DOC: mem_info_vram_total
          <br>
          &nbsp;&nbsp; *
          <br>
          @@ -451,8 +475,10 @@ static int amdgpu_vram_mgr_new(struct
          ttm_resource_manager *man,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = to_amdgpu_device(mgr);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 vis_usage = 0, max_bytes, min_block_size;
          <br>
          +&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vram_mgr_resource *vres;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 size, remaining_size, lpfn, fpfn;
          <br>
          +&nbsp;&nbsp;&nbsp; unsigned long bo_flags = bo-&gt;flags;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_buddy *mm = &amp;mgr-&gt;mm;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_buddy_block *block;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long pages_per_block;
          <br>
          @@ -468,18 +494,8 @@ static int amdgpu_vram_mgr_new(struct
          ttm_resource_manager *man,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tbo-&gt;type != ttm_bo_type_kernel)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max_bytes -= AMDGPU_VM_RESERVED_VRAM;
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; if (place-&gt;flags &amp; TTM_PL_FLAG_CONTIGUOUS) {
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_per_block = ~0ul;
          <br>
          -&nbsp;&nbsp;&nbsp; } else {
          <br>
          -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_per_block = HPAGE_PMD_NR;
          <br>
          -#else
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* default to 2MB */
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_per_block = 2UL &lt;&lt; (20UL - PAGE_SHIFT);
          <br>
          -#endif
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_per_block = max_t(uint32_t, pages_per_block,
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tbo-&gt;page_alignment);
          <br>
          -&nbsp;&nbsp;&nbsp; }
          <br>
          +&nbsp;&nbsp;&nbsp; pages_per_block =
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vram_find_pages_per_block(tbo, place,
          bo_flags);
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vres = kzalloc(sizeof(*vres), GFP_KERNEL);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vres)
          <br>
          @@ -498,7 +514,8 @@ static int amdgpu_vram_mgr_new(struct
          ttm_resource_manager *man,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (place-&gt;flags &amp; TTM_PL_FLAG_TOPDOWN)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vres-&gt;flags |= DRM_BUDDY_TOPDOWN_ALLOCATION;
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; if (place-&gt;flags &amp; TTM_PL_FLAG_CONTIGUOUS)
          <br>
          +&nbsp;&nbsp;&nbsp; if (bo_flags &amp; AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS ||
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; place-&gt;flags &amp; TTM_PL_FLAG_CONTIGUOUS)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vres-&gt;flags |= DRM_BUDDY_CONTIGUOUS_ALLOCATION;
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fpfn || lpfn != mgr-&gt;mm.size)
          <br>
          @@ -529,8 +546,20 @@ static int amdgpu_vram_mgr_new(struct
          ttm_resource_manager *man,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_block_size,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;vres-&gt;blocks,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vres-&gt;flags);
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(r))
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(r)) {
          <br>
        </blockquote>
        <br>
        If pin BO failed to allocate contiguous VRAM, this should return
        failure to application, as RDMA cannot work with scattered VRAM
        pages.
        <br>
        <br>
      </blockquote>
      here we can return -ENOSPC when the BO is pinned (i.e
      TTM_PL_FLAG_CONTIGUOUS is set). Please find the below modified
      condition,
      <br>
      if (bo_flags &amp; AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &amp;&amp;
      <br>
      &nbsp;&nbsp;&nbsp; !(place-&gt;flags &amp; TTM_PL_FLAG_CONTIGUOUS)
      <br>
    </blockquote>
    <p>Yes, this change looks good for me.</p>
    <p>Thanks</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:a8fd7808-a4ae-4e1e-8aae-be22bd4fd3b1@amd.com">Hence if
      the TTM_PL_FLAG_CONTIGUOUS flag is set, we don't proceed for
      allocating individual pages.
      <br>
      <blockquote type="cite">
        <br>
        Regards,
        <br>
        <br>
        Philip
        <br>
        <br>
        <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo_flags &amp;
          AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Fallback to non contiguous allocation */
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vres-&gt;flags &amp;=
          ~DRM_BUDDY_CONTIGUOUS_ALLOCATION;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_flags &amp;=
          ~AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
          <br>
          +
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_per_block =
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vram_find_pages_per_block(tbo,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; place,
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_flags);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free_blocks;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (size &gt; remaining_size)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remaining_size = 0;
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
