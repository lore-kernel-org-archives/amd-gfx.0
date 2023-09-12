Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D76CA0EEB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Sep 2023 15:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DB7310E430;
	Tue, 12 Sep 2023 15:19:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB57210E430
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 15:19:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giMwFOlhs5nwZCMypTUIUb0YqDx8izbaXH/DrvdMlGzVLldzhI4waDeN0JwztaO3OB1kGVjzMY4eyo6B5c8dnnoaRYH5Ilo05G/nQEdAIf/kzhMp6I12q86wKja+SoEEaombKhgEisDrgiHb7phx1L3bTFxImNdFjdJJHxWVrswc9R9uldBf/COCz2WRwC0eLbuAmU8Oaiosz+alY45KivF/TE9QveJ/g6Jjwz9/KukwZYu3IUZ8T80eLwkBBlNE+ebR1K8/Svnbh334mMbtAaEtGgqhEYdq5+zrsvqQxvdQo9pIp9hgsh6bUuiVDH2NpjFsbIyME8zUfhPFOqcAKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJ6fUB+4AHnGS3rXLKJBqS36FDDGzHvMo2sF85eExYg=;
 b=Onxc2LXo65Bef6atPXBJwEXF9QlTBnZbhG506TCi0Wk9Ry9oMWjW18zvQk+nFZ+o8T+zKilq3s8QJqGixxfBe+JMp/CROgWC/Kte8f6aKk7AotNA3uy02WPLmJVjuu3Q8cQz4QrJrEsXI2DavApzQiwfq+9rBVWIh21BGKbll9vLkgC9f72s653K+qMvuVFri52KjBykuNSDATS3w79vH1DtVXU44bOcuZIHVu6VG4yjCWwdSFVPHzz3wefrU64bQjM2C2bJ9MsTNaM4gHDCuh1Zm88/NayrYsRgUQs3JgBMEp5YLe00zR4HL9Jl1poaFFFMfvaV2JhCY1mPBs+Pxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJ6fUB+4AHnGS3rXLKJBqS36FDDGzHvMo2sF85eExYg=;
 b=BOQt9dmtRv5/F3D7o1HIzf2zWYiOLubJMCt9HMN+JV15wmc1XezE3Q8Dmf85Hx+wmRwahP1w7AjAX89I8s+hUQOTDjIF9s3AL4kCrQbu6T/Ny3dCjBSSLfcr11YFRMfT4DKRXyzIRP6VwJX6XDb3HSxVg1AY21pabswt76XL3TE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by IA0PR12MB7752.namprd12.prod.outlook.com (2603:10b6:208:442::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 15:19:44 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b69d:ce48:b96b:833b]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::b69d:ce48:b96b:833b%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 15:19:44 +0000
Message-ID: <77868e26-c94b-3709-2db2-1ef657297799@amd.com>
Date: Tue, 12 Sep 2023 11:19:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdkfd: Move dma unmapping after TLB flush
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230911195517.8548-1-Philip.Yang@amd.com>
 <b8b95ee3-e608-a996-db65-cb02c418620a@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <b8b95ee3-e608-a996-db65-cb02c418620a@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::10)
 To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|IA0PR12MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d92e703-dab3-47db-1c10-08dbb3a3b14c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1IsBoSCAO4IqMVETHsFGfJR9WhtdY3XUhaJKBfyLdjexpF5QrGiRUhhIQh1H+enTatkeVpzy3Sri3dInu88jmPHVLywNEdKFbigtX5sYGkW9LwOkDXjHYu3RRVGdIwdl/FReZW614PyAes2iAyjMrdJOU7XSTmMI3HG5IHMcBv27O1mx9797JQtkiEyGUd94BjWt6yrvJC0cn+C94xrV+GVe1y2KT2aNZaz71B2fdOrhr1qM37QOObFryipzXibv+tfSOLUYsBi0vdsUx3NosOroG9daea+rJhielebzU8I92z1zNWmVM3DtLi18l4j0b9VWIl8XqN2QxIHtNW0LhhvMKy/Ou/UTW5OnbXRQOys15hvHQ20Vuy3C7cW/Z5daEfgdWuefnM5qnp6SBK3an83ZsJTFFQPQDZQVhnmkjbl9ijgAmO7x6FTIWnp/2C4pvAnlnezQSFDf5B9XWhkdn7Dg0BQ2t57v+ij88JuedUzQ3YeOPXdp8xHfXfrNs/oMM6fC6Y98VPI1x0teTk+FWSaB6gEiqZaahJnYOM9bCSy9j3Q9/A0aldBuhyDswbA3A2waP+AiroWSlM+msKTdV3ywJHfTyMx745PLtGHJKTv9ZCXew5PeUY+fLbRXDc7kAwhcpJUICmOL1YoGKeh2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199024)(186009)(1800799009)(6486002)(53546011)(6666004)(6506007)(6512007)(41300700001)(83380400001)(26005)(5660300002)(66556008)(66946007)(66476007)(316002)(478600001)(2906002)(8936002)(110136005)(8676002)(31696002)(36756003)(2616005)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bExON3d5SG5NQ1hoS3kzZUdZMHp1MTdacnJoVXAzYXBpREZHSUp3QVI0cEI1?=
 =?utf-8?B?Z0JHeUxLdXZwNXNNSXhYYktrbWUwdVFTamZ2V2hWckhCajk3Ky9SVFhwMzY5?=
 =?utf-8?B?ZzZjV3lnR1hjTFVKRkpKZkhJMXdueUxTN0lrbkx1eXNBblVKTjg5Si9BMDJn?=
 =?utf-8?B?VVlNTFM4NHM2L2UyMUllRHVlczZCRzlOWUtnL0cweTlNY3lHUGFLc1VVWkRO?=
 =?utf-8?B?d3NBOTYwUUtuQzBrcWczMzVvaGthWHYyU1FsT045N2grSGRWc3RTc0Z1d3E2?=
 =?utf-8?B?bk04eTdsUWVWcy92K3M4Qml2bXlpbUVneHlQakZkZmIyL3NWREtIV1VXYkt6?=
 =?utf-8?B?VjBZVm5Pak56MnVHSGJIOGxURXM0Q0c4Z2s1ZEVKeWllQlN4N21DMzdaRURL?=
 =?utf-8?B?cTJDMSsxdkZ1RmpLdWUzUzJ4bzgxZEFpM0ovSmFvWnR1RFBGN1pTczNHNFNq?=
 =?utf-8?B?Ync1TEpOSWFtZ1dybDl3L055Z2VINjlnMnU3cEhuMDJqVjFGSlZ5ZzRZRkFj?=
 =?utf-8?B?R2EzSk9Obkt1cFBiS2lTanhpcGxuenlZME5JMVpzeW9JQTY5SjZvZjVDV0Nk?=
 =?utf-8?B?K0lSenVscVYrT0FOdkJYWnlyZVNianU3c1UyeXZXbjJvSytEWmo0THNiQnJx?=
 =?utf-8?B?SXdyQ3VkUEZISkdxd2dMSHZUcFhsZm9UMUwxbkdNSjI2blAwdTJBRGg5RGtZ?=
 =?utf-8?B?U280cEhMOFZBM1gzYTNWbUJBRExQSDRReUwyc3JPQmhxUnRhbEZqZDJLemRK?=
 =?utf-8?B?Mm9Rb0w0ZjFwRm1iMEx6QVBvRnh0akpYdWI2TEh2TEIxTUNaWVpwaUd1Sm8v?=
 =?utf-8?B?bjAzOVVaU3YvN1FHQm94djd6WWMyZjBOekp0VEhGcENQdDdGWTlFdDRLV1RR?=
 =?utf-8?B?anpGaWxjb1hwZFpvZ3VHS1ZCSHUrZ1JPS0VxbnpVR3RFMW8xUTlHMUxta2d3?=
 =?utf-8?B?UjJNemhqSjV5Vzdhbjh3WldnaGRLOTJFcm51SEJmd0hWMCtpRkxUdlZmT3hk?=
 =?utf-8?B?RERLV3VNMmp0cGpUQW1tWVhQL3h5V3ZLYkoyRTVsZ201QzQ3SEdzSG1xcGVB?=
 =?utf-8?B?dFVSMnZSTUxrU3pQVW1YTk4zMlVvS2hCTWRxcW9hd3U5VVlIKy9FVXRQdWV5?=
 =?utf-8?B?R1dVbEh2bWxpV2Jmc3BiNXdlcnVVc0xHZXA4aitXd0VUNGM5eWhsNU8yUkNm?=
 =?utf-8?B?ZDdHSFhDYnNad2lqK3d4YSs3eTlsM2d1d0toV2hZZmJnejA3a3EzbHVLbnBG?=
 =?utf-8?B?WEJtK09walQ0Wlc1M3RqSjZudjkxd3dxTUVMc1gzY3Q3d0NSU3dFYlZpeHFC?=
 =?utf-8?B?TVM3N2VNM2lBL2FDSDQ1NFo1REM4VjI5T3lVM3pUeDFhU3lkQ0FKemdDWHZi?=
 =?utf-8?B?N0lIU0FoUGQveEV6d1BIbjYvVERwcW5rbTBXVEVza2dUSUd2M0VvMGtlZG56?=
 =?utf-8?B?UVo1ZlJ5VXl5SGwwY2dZMFR3Qk96VnRiaFlTakZwTW00akJkZmdTR2Vyb2da?=
 =?utf-8?B?YnpJWE5TSVpMbXhnaDRlWEJmRkNtL25ZVnVsSlA1VFhPZDVURjM0RlpibDFO?=
 =?utf-8?B?bXRmYXd3b2FvdDU2c1UyaFpzQVBuUXB2SWRvTlMxNllkZWZ2ZkVrMTk1ZVlR?=
 =?utf-8?B?RytmdStvOU9Cb3ZFUnBpUW4rdjQzUDJzTXRVTUxjTE9tQTRrOU9wSTRPVWt3?=
 =?utf-8?B?WndHdXB2YU05K1BZZFFaSlVpMWFNM1dJL0JibTFwUmppV3g3eXArWFNkNE53?=
 =?utf-8?B?VUJnNVp0MUI0dmRhaWFPRXYrN2Jjbkk2ZlA1ei80YkxBKzh3cjR3NXN4ankx?=
 =?utf-8?B?S0FrUkN3U3hPaGRvZWJiY3Y3OUtHTUVnSjdOV0trUk84YkFUYlJRcnJmYVZt?=
 =?utf-8?B?NEN4N3FlaUZPM25UamFmTkczWFBPRU90TStHMFBkOU0rYjRLeHpEakd0YVlP?=
 =?utf-8?B?Z2hkTExla2ZIMTRiTTg0WlloQ0FKZDIweFE4eWVpKzByYW9DZTBRb3NDdjBm?=
 =?utf-8?B?OFNUUmVpTVdJNWI3dHM3OGM1WXA3RlUwZlBqTEZIUk9BWmNYMjJ6bmVsWWFT?=
 =?utf-8?B?SHJldkpxN1ZjL2ZJZVJwblVaZG53dFpMMFJDcEpUbVdOaElLTDMwRHcvRjJZ?=
 =?utf-8?Q?UYZaYQIKaAHslX0tJoFepHZnP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d92e703-dab3-47db-1c10-08dbb3a3b14c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 15:19:44.0367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytnZQsJ2gb0ziBLmUd3wU8VOq25009hlOBCFftubdhU2ADsyRCOLjE/D7uxG1fbW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7752
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
    <div class="moz-cite-prefix">On 2023-09-11 21:11, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:b8b95ee3-e608-a996-db65-cb02c418620a@amd.com">On
      2023-09-11 15:55, Philip Yang wrote:
      <br>
      <blockquote type="cite">Otherwise GPU may access the stale mapping
        and generate IOMMU
        <br>
        IO_PAGE_FAULT.
        <br>
        <br>
        Move this to inside p-&gt;mutex to prevent multiple threads
        mapping and
        <br>
        unmapping concurrently race condition.
        <br>
        <br>
        After kfd_mem_dmaunmap_attachment is removed from
        unmap_bo_from_gpuvm,
        <br>
        kfd_mem_dmaunmap_attachment is called if failed to map to GPUs,
        and
        <br>
        before free the mem attachment in case failed to unmap from
        GPUs.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h&nbsp;&nbsp;&nbsp; |&nbsp; 1 +
        <br>
        &nbsp; .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c&nbsp; | 22
        +++++++++++++++---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 23
        ++++++++++++-------
        <br>
        &nbsp; 3 files changed, 35 insertions(+), 11 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
        <br>
        index 559f14cc0a99..dff79a623f4a 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
        <br>
        @@ -304,6 +304,7 @@ int
        amdgpu_amdkfd_gpuvm_map_memory_to_gpu(struct amdgpu_device
        *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kgd_mem *mem, void *drm_priv);
        <br>
        &nbsp; int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev, struct kgd_mem *mem, void
        *drm_priv);
        <br>
        +void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct amdgpu_vm *vm,
        struct kgd_mem *mem);
        <br>
      </blockquote>
      <br>
      For consistency with the other amdgpu_amdkfd APIs, please replace
      the vm parameter with a drm_priv parameter and do the
      drm_priv_to_vm translation inside
      amdgpu_amdkfd_gpuvm_dmaunmap_mem.
      <br>
    </blockquote>
    ok.<br>
    <blockquote type="cite" cite="mid:b8b95ee3-e608-a996-db65-cb02c418620a@amd.com">
      <br>
      <br>
      <blockquote type="cite">&nbsp; int amdgpu_amdkfd_gpuvm_sync_memory(
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev, struct kgd_mem *mem, bool
        intr);
        <br>
        &nbsp; int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct kgd_mem
        *mem,
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        index b5b940485059..ae767ad7afa2 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        @@ -1249,8 +1249,6 @@ static void unmap_bo_from_gpuvm(struct
        kgd_mem *mem,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_clear_freed(adev, vm,
        &amp;bo_va-&gt;last_pt_update);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sync_fence(sync, bo_va-&gt;last_pt_update);
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp; kfd_mem_dmaunmap_attachment(mem, entry);
        <br>
        &nbsp; }
        <br>
        &nbsp; &nbsp; static int update_gpuvm_pte(struct kgd_mem *mem,
        <br>
        @@ -1305,6 +1303,7 @@ static int map_bo_to_gpuvm(struct kgd_mem
        *mem,
        <br>
        &nbsp; &nbsp; update_gpuvm_pte_failed:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unmap_bo_from_gpuvm(mem, entry, sync);
        <br>
        +&nbsp;&nbsp;&nbsp; kfd_mem_dmaunmap_attachment(mem, entry);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;
        <br>
        &nbsp; }
        <br>
        &nbsp; @@ -1910,8 +1909,10 @@ int
        amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem-&gt;va + bo_size * (1 + mem-&gt;aql_queue));
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Remove from VM internal data structures */
        <br>
        -&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(entry, tmp,
        &amp;mem-&gt;attachments, list)
        <br>
        +&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(entry, tmp,
        &amp;mem-&gt;attachments, list) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_dmaunmap_attachment(mem, entry);
        <br>
      </blockquote>
      <br>
      In theory this should not be needed, because user mode is required
      to unmap all mappings before freeing the BO. If </blockquote>
    amdgpu_amdkfd_gpuvm_sync_memory may return -ERESTARTSYS, or if
    vm_validate_pt_pd_bos failed, then amdgpu_amdkfd_gpuvm_dmaunmap_mem
    is not called, this is needed to avoid leaking dma mapping.<br>
    <blockquote type="cite" cite="mid:b8b95ee3-e608-a996-db65-cb02c418620a@amd.com">(mapped_to_gpu_memory
      &gt; 0), this function returns -EBUSY. For SG BOs, you may run
      into this error message:
      <br>
      <br>
      &nbsp;&nbsp;&nbsp; pr_err(&quot;SG Table of BO is UNEXPECTEDLY NULL&quot;);
      <br>
      <br>
      If you decide to leave this dmaunmap_attachment here, you may want
      to turn that error into a pr_debug and remove &quot;UNEXPECTEDLY&quot;.
      <br>
    </blockquote>
    <p>Thanks, I missed this, will change it in next version.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:b8b95ee3-e608-a996-db65-cb02c418620a@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_detach(entry);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = unreserve_bo_and_vms(&amp;ctx, false, false);
        <br>
        &nbsp; @@ -2085,6 +2086,21 @@ int
        amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;
        <br>
        &nbsp; }
        <br>
        &nbsp; +void amdgpu_amdkfd_gpuvm_dmaunmap_mem(struct amdgpu_vm *vm,
        struct kgd_mem *mem)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct kfd_mem_attachment *entry;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; mutex_lock(&amp;mem-&gt;lock);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; list_for_each_entry(entry, &amp;mem-&gt;attachments, list)
        {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (entry-&gt;bo_va-&gt;base.vm != vm)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_dmaunmap_attachment(mem, entry);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;mem-&gt;lock);
        <br>
        +}
        <br>
        +
        <br>
        &nbsp; int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev, struct kgd_mem *mem, void
        *drm_priv)
        <br>
        &nbsp; {
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        index 08687ce0aa8b..645628ff1faf 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
        <br>
        @@ -1432,17 +1432,24 @@ static int
        kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto sync_memory_failed;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;p-&gt;mutex);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; if (flush_tlb) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Flush TLBs after waiting for the page table updates
        to complete */
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; args-&gt;n_devices; i++) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; peer_pdd = kfd_process_device_data_by_id(p,
        devices_arr[i]);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (WARN_ON_ONCE(!peer_pdd))
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
        <br>
        +&nbsp;&nbsp;&nbsp; /* Flush TLBs after waiting for the page table updates to
        complete */
        <br>
        +&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; args-&gt;n_devices; i++) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; peer_pdd = kfd_process_device_data_by_id(p,
        devices_arr[i]);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (WARN_ON_ONCE(!peer_pdd))
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flush_tlb)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Remove dma mapping after tlb flush to avoid
        IO_PAGE_FAULT */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm = drm_priv_to_vm(peer_pdd-&gt;drm_priv);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_gpuvm_dmaunmap_mem(vm, mem);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;p-&gt;mutex);
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(devices_arr);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
