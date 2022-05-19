Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40367C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 14:26:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E29D110E91F;
	Thu, 19 May 2022 14:26:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4EDD10E753
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 14:26:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jD5M+4MUd7yd53Y+EA77xEc/X+SWqy41DwtJtBqG3N+wIapgZWTlYxvqu5RYYYTI+2trw7GEgoPFDihF+3xKJxI6Rz3nVGubfStMu8YVEgUqdKUAckx4MIAizvYgeG9OV2TNMi70WrBzhjvKYHGpw6pf0uMdOMG7Y9VdOkW7dD7KV/ovBFN9QQjDila3neIvK1KhYUr/lR0X6seN4WtBhsSeHx2lpnfxFxk7eEYHZ1m3jU9hI/O4Q6LDd99i5I2PTDQiWx8n2PCCWy1oREMMX8ukp4DgwSmc2Gx1cEX7W94wGvnM/f087mZ5IwIGCCbdJyh22vjC5xpXKik1853pdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sG8DIfgvRNH9i4bDKCO+ugEgykgvUdexKKGMNIBX444=;
 b=YmosPvXGxkxA3cIo1zl39bt8b4jrdQSG8vmNPgrL+Fs0lvCBwgzp3G8UdmZYh9FsBZLFbItN+0/P/IuIjyljiFmfYB3xQGnEbmn9bGpXi/KTSElFYwRx9imfkL3ihGUgodtpdaps60S3C8lkZN2X8OsJcpRdVzWcO+CR3wTS7aZXrm/7H4YXDvWnHyE50YzD5k6TFU2cFL4npxHN5CXEin6TYIcSp9gkMcVDG5eM/agrMxq0R6LqKtxhfYQALuG8LUIswQ5hOdL+pLaNyHWngx61V6zAHlmb3A4VGVzGlShEB+sX4rAs8cNVrNNL61SWO4vXP9T3DguFSoN5Jasxhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sG8DIfgvRNH9i4bDKCO+ugEgykgvUdexKKGMNIBX444=;
 b=IwelKEmBmZ7Ou+HQjcYs9cF2YjXCjCojD5oQubEdoEbv115Pb/wY0IFVGdLNLWQIyd6W1hdeIQFflx6VXM5etGeZPcCCu6iCGbba1lHNOLx5L6kIzf5IfenoCGJUIDfPHJo2JNycKs9zXM9VOXgrhUuwIIxhHkZcrDnH96991VU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM6PR12MB3433.namprd12.prod.outlook.com (2603:10b6:5:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Thu, 19 May
 2022 14:25:58 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e1cf:e31a:2a89:f226%8]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 14:25:58 +0000
Message-ID: <cb7b6827-65bb-669b-a3fc-ed15cab0803f@amd.com>
Date: Thu, 19 May 2022 10:25:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] drm/amdgpu: remove acc_size from reserve/unreserve mem
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>,
 Philip Yang <Philip.Yang@amd.com>
References: <20220517231108.14048-1-alex.sierra@amd.com>
 <1e136059-5e56-8709-c252-bee43dec2c1d@amd.com>
 <63fe88f7-fa3c-67be-73ab-8fed555e4c52@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <63fe88f7-fa3c-67be-73ab-8fed555e4c52@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:208:134::38) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9fbbd80-07cb-4bec-817e-08da39a37dfc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3433:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3433FFEC729B166A1B513712E6D09@DM6PR12MB3433.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1TqkU76+1hPK3ph+VKm1GoHLVDSYeVRi8lqzqA6zxCF5TgeRt4N/LphwHS/h9oTqlLu0cJZsQCfVqzFyi0DsywztOKZykjAA4ywDjMwe11vHjlc1gKDkH3WoNYif+91mF1Tl2E19BhCEfsjoZuz+9ZNKbnrt5iOviZBfukiMZvT4bV0y+tYKkwouxXf33vIzGuZgGCusK2geaRCWZmVkPgum1xdq3AY9+7Pj8rZPq8l5f+AWaJlV46/vdU84OhOIRSTYG5G18xe2vo4r+Ovw6sEIQpiA5TC0FA1o+/krD1t/SsxmhU1893a4lL+GxbKsNag90qK3UXs07gk8UJjp8ESfirl6libKyP8po7zpJt6/O4YxMANImSxDwLcR0KBAv7xGUM4LAFpL3PY/eMLLvf3uJoN2CDrShNUwuSyiVhU2etcewMiyUEBlOSCeidwbWu5gQwHMzCUNrhoX9UcN1JYV7tXOnZQjMyzfescdFAbLsRja/H5cX8CHwTKsYzNvjzQ/XaLpWsOpXqLQ4GLkyE2jRh+8imprd/2Jw5qJ2s+D4Wj4PvI9W1yuGGuqYdj14iHgNdBFXGQ+TiESzylZgPfeOOBoLd37h8QbIWMLhilOE0k2DYk3U211AyIjs3cNoL2Ges6OzFUVbHMw47eUEij9oQf61lF2Gpz5WBYN35gbh1gs3HYUOVrE43fT0O/7wvKWSX8KL1g7wVWo9no6EOLLbItN3yxoTRbeMPg/jWc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(31696002)(5660300002)(508600001)(6506007)(38100700002)(316002)(26005)(6512007)(6636002)(186003)(2616005)(53546011)(110136005)(66476007)(8676002)(83380400001)(2906002)(66946007)(36756003)(31686004)(66556008)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEp2S0FSVXBIbFNjZXgwd3B5djRvckNwSldXazRZOUl1VTdOVkRBdUpaRHZC?=
 =?utf-8?B?aExEYU1DVE5acE9GUjkwdUtIWkMyTlpiNzBhWUV6TS9kVnpGNkFHUzl1Sm44?=
 =?utf-8?B?cXFTZ0NCSitSZGw2MmIyMXBQM1I0Y0NUdndocWV6MFlBVjJrNlVaMkxQNWpC?=
 =?utf-8?B?b1A0K1lGUjVpZ0ZXMTVvR0RPTkYySk9rVFp5NXFvT0xhS1FTSG5yMlFNSjM2?=
 =?utf-8?B?RmNUUUl1MWdMbjhJak8yNUVIUXVrN1BpaVhrOXg3V2xUOTJ3Q3hDTHU5R3Q5?=
 =?utf-8?B?UGdVN1FWRXdKRExyUTFrYXVyZERDcEprbVJBUVZlWGZ5cWI0eEFyOHYrWDhy?=
 =?utf-8?B?ZVNFYjJiZVlxcXhVSjRDZzcwQ21HTXpaTEliekJGd0VsRjNBbkYzbXVqTWc0?=
 =?utf-8?B?enhDbjlmWXdzczI3OHUzMGI2L3VkRDBlNFMvNlc5NUJzYXVRTldaZkxYY2Ri?=
 =?utf-8?B?a0FKcnlERE1xZ1QvdS9aQzBXalZlTUFJYWxuQlA5azRhdVA4dkc1TytRU3lZ?=
 =?utf-8?B?amhyOU9oVTZqZ1ZNU3A3cHkxbVRzQ2RoTVB1MG1tL3p2TElDMG5tRUlETEJa?=
 =?utf-8?B?WmR6c1RMRWMwdlZyRTNLVnhyazFBUTFXdEZkODk1WHpnYmdsaGlnbHVLbVpJ?=
 =?utf-8?B?TnZTeGlhUHpiQ1FlNzhabWJFdk5SOFZFc0x6b1BZWGhpSE4xQkhSWDZsc3c3?=
 =?utf-8?B?UTZweGoxOTdkL25RczR5bTlqanJzc0E0QlB4UUVESGNlUmhpT0VxaHYxL2Y4?=
 =?utf-8?B?TTdXTjcvQzE0UkZiNENlUlZRUXlqQzAyZXBxRWcvUndnOWhkOFBzMHRydGdB?=
 =?utf-8?B?dFFEeFQ4WUFrczVPL0FJK1ZDOU1DeElqUUVvcVhLZHpyN3ZsVTNybVpJL25j?=
 =?utf-8?B?WTRQSTRXTTZVTTVTR0h4S25GOWhneVZ4ZkxqVzVDZGhQWElxZTJaV1QxdEhG?=
 =?utf-8?B?Q2QwNG9jdzFBVG9BK05HbnZNYXNXMkV1eGdhT2dqaHF6bnhnVlNBblhXRlJK?=
 =?utf-8?B?c1pveGdqOGg2Y0w2WlNldGhlc1VtZGdEMzlWWVdKMW40cmJOMWlqZGJZL1dB?=
 =?utf-8?B?azhiTDhKbFcwSEdhRTJ1dnMvRVJoZXJEbkgxRjQ2ZklvUzFyM1B4WVpYaU9C?=
 =?utf-8?B?OCszcEhHTEVJYmo4c2ZqaWVyVmFPRmlWaVBmWHNhQWd5Wk9YR1NSZ3J0TFA5?=
 =?utf-8?B?Y0dyWDVtMEYwcngvcTVuVmtzQnZrSzEveEQxcFRTRUdROHBqUDRLTllFR1lo?=
 =?utf-8?B?bXdTUFdzQkpCd3dkNGkzcTFDYktnVFIxQ1NhV3FNUFVrcTI3MXljMjhmcGdk?=
 =?utf-8?B?emRvR3BFRXJSUEhweGtSTjgvWFJMRHhvWHRmaHorVVoxdWh6U0tiTkoydkZr?=
 =?utf-8?B?YXhadVNlUkYzMnQ4QmYxcHp3cmJaS0NxSDBtRFNQRDBuYUJ6dnhBZC9JbHNP?=
 =?utf-8?B?ejRpMllOQkx2VUZsQjRnbGVYUjVaMlFVRHkxM2lqRFRiRFpVYzFmNVduYURS?=
 =?utf-8?B?dlljaXdsbFlFbkRmYmxGWktxd3NGUE5ucnhtd0dxb3FlcDc3ai9YRXBkcXhK?=
 =?utf-8?B?b3B4T1d2Uk5uTG13ZDEvZnZiUmliR2ZaSmFsZkw1bjV6c3N4bmQ5Tnh6SURK?=
 =?utf-8?B?Tk80SGJTRnBNTmhDcEorRWFsTGM5TFlDR0V0KzNscHAxaGlMTmdMaER6VFFi?=
 =?utf-8?B?WU1UNEpKTlVaYlhBZ2dlV1dMWEZuY2poRm9XR1p3WmpKbXVmRGZuT29kTit0?=
 =?utf-8?B?MlJORmt3VThVMmV2NGpldkNGZklqSjVodDdwREhiL3pLTUVTY1RxamU5OXpx?=
 =?utf-8?B?QkhkblF2QktGZXFwV0xZM0l5V3p4L25kUkpaV3lOK0RGUjBOOXdiTmJYcFYx?=
 =?utf-8?B?clNOK3VGeWovSGRuY1NmaHo0d3JRbW9Yb3FPbmxoYVM5OG5haTQyRGZxZVhl?=
 =?utf-8?B?Tkt2TVMzSnVZOEFnc3NHeTNqVVpsSlJOUXBLdXBiaWs5NzhiTGpVc0RtV3l5?=
 =?utf-8?B?Mnd6c3NqenAyRjlGZkJ3Q3dyY2ZhVStraDZEUHVlQUlvRTlWTzlUSHY3NWYv?=
 =?utf-8?B?WHFHNFh4cGYzWExCZWR5aDczM0lPTjdoRW1xM2JKZWhkTEE0KzFKM2k3L0RX?=
 =?utf-8?B?ZWFYUld6dkYyTG1aZGwwWjlZNHQxdnYrbGFrbkcwOHZpM2FTWkQ4d1Y5RFZW?=
 =?utf-8?B?N0RhYy85ekZSSHVocTdha1NvcVA5SlJVZXgrWjdObUJub0phc3NFcTBIYlhy?=
 =?utf-8?B?V1NGa0RGb1dhQWF4clp2Qm0vT01qNkZReDJ5TjVjSUM3dUl5VE1RNFhNQnhN?=
 =?utf-8?B?dDZyUFoxbmZkaE9hT0djek1ocldCN2lIbnZPQSt1YWNvS0VhWEp0Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fbbd80-07cb-4bec-817e-08da39a37dfc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 14:25:58.3436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gyv7O1hqPSDAhyXcSxOYo/zAB/7pIsznV27dxvYkFGw2Ms2nuMEliKeVQoAuYsUz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3433
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
    <div class="moz-cite-prefix">On 2022-05-18 17:31, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:63fe88f7-fa3c-67be-73ab-8fed555e4c52@amd.com">On
      2022-05-18 13:55, philip yang wrote:
      <br>
      <blockquote type="cite">
        <br>
        <br>
        On 2022-05-17 19:11, Alex Sierra wrote:
        <br>
        <blockquote type="cite">TTM used to track the &quot;acc_size&quot; of all
          BOs internally. We needed to
          <br>
          keep track of it in our memory reservation to avoid TTM
          running out
          <br>
          of memory in its own accounting. However, that &quot;acc_size&quot;
          accounting
          <br>
          has since been removed from TTM. Therefore we don't really
          need to
          <br>
          track it any more.
          <br>
        </blockquote>
        <br>
        acc_size is size of amdgpu_bo data structure plus size of pages
        array and dma_address array, it is needed for each BO, so should
        track as system_mem_needed. It can be removed from
        ttm_mem_needed as this is not allocated by TTM as GTT memory.
        <br>
        <br>
      </blockquote>
      You have a point, I didn't think of that. The fact that TTM isn't
      tracking the data structure sizes any more doesn't mean, we
      shouldn't account for it in our own system memory usage.
      <br>
      <br>
      That said, do we actually have DMA address arrays for VRAM
      allocations?
      <br>
      <br>
      Also, acc_size doesn't track the extra dmabuf BOs we create for
      DMA mappings on multiple GPUs. So I'm not sure how useful the
      acc_size tracking is at this point. The system memory limit is
      currently 15/16 of total memory. Maybe that leaves enough reserve
      for data structure sizes?
      <br>
    </blockquote>
    Based on the calculation, set 15/16 free system memory limit is
    enough to prevent OOM killer, as acc_size is up to 1/64 of memory
    size on 8GPU system, so it is safe to simplify and remove data
    structure acc_size.
    <p>One nit-pick below. This patch is Reviewed-by: Philip Yang
      <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a></p>
    <blockquote type="cite" cite="mid:63fe88f7-fa3c-67be-73ab-8fed555e4c52@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">Regards,
        <br>
        <br>
        Philip
        <br>
        <br>
        <blockquote type="cite">Signed-off-by: Alex
          Sierra<a class="moz-txt-link-rfc2396E" href="mailto:alex.sierra@amd.com">&lt;alex.sierra@amd.com&gt;</a>
          <br>
          ---
          <br>
          &nbsp; .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c&nbsp; | 57
          ++++++-------------
          <br>
          &nbsp; 1 file changed, 16 insertions(+), 41 deletions(-)
          <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
          <br>
          index fada3b149361..e985cf9c7ec0 100644
          <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
          <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
          <br>
          @@ -108,17 +108,8 @@ void
          amdgpu_amdkfd_reserve_system_mem(uint64_t size)
          <br>
          &nbsp;&nbsp; * compromise that should work in most cases without
          reserving too
          <br>
          &nbsp;&nbsp; * much memory for page tables unnecessarily (factor 16K,
          &gt;&gt; 14).
          <br>
          &nbsp;&nbsp; */
          <br>
          -#define ESTIMATE_PT_SIZE(mem_size) ((mem_size) &gt;&gt; 14)
          <br>
          -
          <br>
          -static size_t amdgpu_amdkfd_acc_size(uint64_t size)
          <br>
          -{
          <br>
          -&nbsp;&nbsp;&nbsp; size &gt;&gt;= PAGE_SHIFT;
          <br>
          -&nbsp;&nbsp;&nbsp; size *= sizeof(dma_addr_t) + sizeof(void *);
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; return __roundup_pow_of_two(sizeof(struct amdgpu_bo)) +
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __roundup_pow_of_two(sizeof(struct ttm_tt)) +
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_ALIGN(size);
          <br>
          -}
          <br>
          +#define ESTIMATE_PT_SIZE(mem_size) ((mem_size) &gt;&gt; 14)
          <br>
          &nbsp; &nbsp; /**
          <br>
          &nbsp;&nbsp; * amdgpu_amdkfd_reserve_mem_limit() - Decrease available
          memory by size
          <br>
        </blockquote>
      </blockquote>
    </blockquote>
    <p>Remove &quot;including any reserved for control structures&quot; from
      function description.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:63fe88f7-fa3c-67be-73ab-8fed555e4c52@amd.com">
      <blockquote type="cite">
        <blockquote type="cite">@@ -136,28 +127,22 @@ static int
          amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
          <br>
          &nbsp; {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t reserved_for_pt =
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
          <br>
          -&nbsp;&nbsp;&nbsp; size_t acc_size, system_mem_needed, ttm_mem_needed,
          vram_needed;
          <br>
          +&nbsp;&nbsp;&nbsp; size_t system_mem_needed, ttm_mem_needed, vram_needed;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret = 0;
          <br>
          &nbsp; -&nbsp;&nbsp;&nbsp; acc_size = amdgpu_amdkfd_acc_size(size);
          <br>
          -
          <br>
          +&nbsp;&nbsp;&nbsp; system_mem_needed = 0;
          <br>
          +&nbsp;&nbsp;&nbsp; ttm_mem_needed = 0;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_needed = 0;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (alloc_flag &amp; KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; system_mem_needed = acc_size + size;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_mem_needed = acc_size + size;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; system_mem_needed = size;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_mem_needed = size;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (alloc_flag &amp;
          KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; system_mem_needed = acc_size;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_mem_needed = acc_size;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_needed = size;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (alloc_flag &amp;
          KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; system_mem_needed = acc_size + size;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_mem_needed = acc_size;
          <br>
          -&nbsp;&nbsp;&nbsp; } else if (alloc_flag &amp;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; system_mem_needed = acc_size;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_mem_needed = acc_size;
          <br>
          -&nbsp;&nbsp;&nbsp; } else {
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; system_mem_needed = size;
          <br>
          +&nbsp;&nbsp;&nbsp; } else if (!(alloc_flag &amp;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;%s: Invalid BO type %#x\n&quot;, __func__,
          alloc_flag);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          @@ -193,28 +178,18 @@ static int
          amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
          <br>
          &nbsp; static void unreserve_mem_limit(struct amdgpu_device *adev,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t size, u32 alloc_flag)
          <br>
          &nbsp; {
          <br>
          -&nbsp;&nbsp;&nbsp; size_t acc_size;
          <br>
          -
          <br>
          -&nbsp;&nbsp;&nbsp; acc_size = amdgpu_amdkfd_acc_size(size);
          <br>
          -
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;kfd_mem_limit.mem_limit_lock);
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (alloc_flag &amp; KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.system_mem_used -= (acc_size + size);
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.ttm_mem_used -= (acc_size + size);
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.system_mem_used -= size;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.ttm_mem_used -= size;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (alloc_flag &amp;
          KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.system_mem_used -= acc_size;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.ttm_mem_used -= acc_size;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;kfd.vram_used -= size;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (alloc_flag &amp;
          KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.system_mem_used -= (acc_size + size);
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.ttm_mem_used -= acc_size;
          <br>
          -&nbsp;&nbsp;&nbsp; } else if (alloc_flag &amp;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.system_mem_used -= acc_size;
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.ttm_mem_used -= acc_size;
          <br>
          -&nbsp;&nbsp;&nbsp; } else {
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.system_mem_used -= size;
          <br>
          +&nbsp;&nbsp;&nbsp; } else if (!(alloc_flag &amp;
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP))) {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;%s: Invalid BO type %#x\n&quot;, __func__,
          alloc_flag);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto release;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>
