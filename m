Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92464C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Mar 2022 15:46:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23D6110F3F6;
	Thu, 31 Mar 2022 15:46:33 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2069.outbound.protection.outlook.com [40.107.101.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8735210F3F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Mar 2022 15:46:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQxlBn7248BYN7epCL6xTTH6d3X0vpGtVpEHUF62n69v7xrGnfK7EyUqJGpbxpoYm47cVUhgJQzDsKj5HD8A2NgVfjy3n1BzL6+kKO8sK6GcPCe8ox7DIJCDB1WODwLHPevVHanF/9tED2rnm73QxLx1BRy3kVMoTEaxNybYaO1AuPCEeAvJzLSFL+iMu36f9xlK0Xa33G+gBcjICeXvzpZQrX64OcJD2VjMurOHz5kBZhOe+K7xcw9KGmI/M0sjtxHyFhMLLSNHcBEmN65L/MsY6xGcWcsl1cNNv/lPa9lIVJmatI193iYE8Xvkr9Bote30DSBPk6gc/vbta2UcfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGozVkx8cSFaEMN4jQrb20JobQZOIJSp3RdokqY8fuk=;
 b=ADEdHJ9jJi2YGRFUo3TARJhAq5bD1I9C0YKNHt4YmxAxi5uDRnUxsdIQGTtidXNwud62DqdUjEDMkQVH0JYJP5J38ghfBJS5ohxNhmsIOgW+6GqF06nJ/DybiEXJOO/+g21zJfH3LqX5Pj4g8mNY9GDq02TID3mNK55paJCg1D2gBr04PB97ELY/T/sKiPIZXMCYqBbApVcusa1RLERhHwGNwIhK4ER4eREBwKriQlPNCWRO57aC38oPDIQL1H2QT7rxXPe+8ISAhLLzR/Jo7J+8DdsxB7U/27flJnqhueuMN/XCJtqptF5XRfiqN3p5lCygdUPTov9qOm/D4tqyNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGozVkx8cSFaEMN4jQrb20JobQZOIJSp3RdokqY8fuk=;
 b=CYVK1nCSIfC+oj0iCrEGT2QIDepxa/l/FkeftOA0RwS3V0uQps/xwZplp+LgYdLvRrG1F2T1F/rFFrfNIIl2Iag4wxH+15up8Xs+VzVY0KhzSqkc9KhGYf2YMQbaqV/H5b2aGqF+fYUDiQNZ87yTSvKdF0EJBinOLGMuMcZOI5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Thu, 31 Mar
 2022 15:46:29 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::911e:11ef:6f5d:6329]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::911e:11ef:6f5d:6329%8]) with mapi id 15.20.5123.023; Thu, 31 Mar 2022
 15:46:29 +0000
Message-ID: <eba0ddc2-57a7-c8f0-22ed-0182c2ea030b@amd.com>
Date: Thu, 31 Mar 2022 11:46:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu: fix TLB flushing during eviction
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Philip.Yang@amd.com
References: <20220330090032.16218-1-christian.koenig@amd.com>
 <d1191314-478d-cacd-76b3-14a39157231c@amd.com>
 <e957191b-789d-af36-6951-049f038bc47c@gmail.com>
 <03623d90-5e39-a2fb-1068-db15c592f9f9@amd.com>
From: philip yang <yangp@amd.com>
In-Reply-To: <03623d90-5e39-a2fb-1068-db15c592f9f9@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR1501CA0024.namprd15.prod.outlook.com
 (2603:10b6:207:17::37) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7452d41a-e6e7-4bd0-cafb-08da132d9f36
X-MS-TrafficTypeDiagnostic: MN2PR12MB4253:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4253A633002BE43ABCD90235E6E19@MN2PR12MB4253.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tkMKvvYmhSugeAZxKVN4VSWlrU8mGEYczb/jtDAo2GrxpuSavFpDB3fTUUXQ1PG6HdhkwXGQQ8RjdLZUXyFNvyXdNd0dQHa7apd3phz4eD6lKgwmQGZae0RGj+5u4qL3Madt9hir8Xmm4FdO09POQdNnhbNZcVouTbuPlEJ6iXiaWWKJPeJK7lPVwdXoKrfRuPJGMFu83jPBOMDDaWKW8UZTsZ9wfANE4SKGXGr7503WfCM/xtbp5Jo68aQXwxlgyPtod7fcF1+FEUksOnBApw7zNOxLyL2Ljc0uocciRmBCbj2zimYyDUDlbe9Qo/FQHuuYRQmJXxawFHl7oai2wN350liQoI3Xy1pJ03p0snC8NHKyn94fzkaHzKhqEOybStdrcdGQluwMpzhxAt8mCMqoXfOJJfwdxGoBtoqBd7DiR7axA3RP3HIQCvD/IKynlYv8aqCSln9aSn6r9qp5qPecrOh1KzNdZ6VaTlH7JQtyP9eArC3iYGvf1PaAZk7qW21IHBdelQdD4Kruwb7JTGrlb9l1x1irsd+b88580rNbz35s/EwDfOF1cHO9+GJiS5EADQJRCZhZHD38xh/DmqoyIqpyXerDegFOcBnFYGHR8FGIpUXtRsl8ZZKLHvk1xPaEnxAO8mWRQBmUWz7SEJCc8YSroWVLLB904DHJYF3lut/4bXu2ElSIb6HKHptsrzW70pDzzSzJo0lgsPiK74lgztmX2//kQ1wjppM4j38=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(2616005)(26005)(83380400001)(2906002)(66574015)(186003)(8936002)(38100700002)(508600001)(6486002)(66476007)(31696002)(66946007)(316002)(6636002)(66556008)(110136005)(8676002)(31686004)(4326008)(53546011)(30864003)(6512007)(5660300002)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0NRQUcyTEY5NXNOMUxtSVBSQ2ZIVVhXdXFSV0U2TkExY2VkeTVTbFVyL0Ja?=
 =?utf-8?B?WC9XUVdXTU14TERIcDNua2hWNnBlWkFHcnJxM2R6ak96U2I5ZGJLSjRWSzdn?=
 =?utf-8?B?K1crQktkbXZFQVZ5a1BqR0dxTDA4Mmo3VFBPdVFxZ3d4TU9JRURqcHpWNHZk?=
 =?utf-8?B?cjJ1UFdzYnc4Ynp0WEQzNlNFV3Q0cGZpY1pWMHdiSE8rK1RMR3ZKdElPZ2lS?=
 =?utf-8?B?WkNTWXZFT25wdVpEVG1ReE5UdWxCK2VGSUZpbDNMZ1FVYXpaT2ZNaTlUeGRv?=
 =?utf-8?B?THBrZXhjdmFnZ3NzWjZKTVd6aFRzaUI4RU9lNFJZdVZ6eitYcTQydTNkdi9p?=
 =?utf-8?B?OTVPR3FxaHRYNnVSWUg0aW55N2FXamxiKzZ0YlRVa1V2R3BXdXlZSm5jZnNr?=
 =?utf-8?B?dFpGQWV6VURleUgrUWR0Rmt1dnI5ZndxNkRqaVFwRUNRQ0FKa0ZidXNKWitS?=
 =?utf-8?B?NzFMRkNuMmEwWVlrZWkvSzhBM3l4cHZUWjJBZnJFaUVzU0VHODA2ekFiajRt?=
 =?utf-8?B?SktjUzJaWHhpcjdqMm9FVnNGaFdKMHpSOWthSSsxS1RWUTlISzVEUlA2bHFT?=
 =?utf-8?B?UXBTeHhMQ3JveVo5aTRxbEtTL1o3cDh0N1VVVTh3MmNVb3c1blpUb3BoQVRr?=
 =?utf-8?B?Qk1CL0pXdjdMaHlwVGdaK0hieWRFSyt1YURjKy9CMFZqS3ErbU42aWw2TFNX?=
 =?utf-8?B?bmtlbVVpbHplQXdBNlpIUGVybzdHK0wxZExOazBtU3d4NVVpTHpISmJYSENq?=
 =?utf-8?B?M2J6dVJnQ2hQcWZWNHNEMXVteUVJaHRYSjg3eklONGV4ck8wZnhRbzRkS3pO?=
 =?utf-8?B?SStWTEdsN0VyZXJjaFd4Sjg5dDkwZWNidnlQQXkrQzFEb1hzcGcwYUhOL2tR?=
 =?utf-8?B?dGdoSlN1b2FXRGxSelp6cWZLM25vbk12dHNSMUxDWFQrRGhHUHE2dVNzUjll?=
 =?utf-8?B?L3BUL1g5ZHplV3g4blAwcmY4UHg1YkJ1c0d4b0c0eVVuZVBPb2xvRTJjK1c1?=
 =?utf-8?B?WEtTN1RsQnRUV1lOWHpZbFc2QUd6b0hISWZIdjFKTmt4SENibzc4bHo2NGhD?=
 =?utf-8?B?NWZLNC9lRG01MmJkV2oxVWVFYndNaTU3Qkt3R2ZhdCs5NFlXV2poYnJnS1Bj?=
 =?utf-8?B?b1lPYVV2ck5tWDdiakwrblJpbER1eFVJOXVmVDdLRjVxaWl5U3lXdFFMendN?=
 =?utf-8?B?RW1ueDhQU3N2ZmtScUMzWDA5OWdURm5IUDZsdkoydTZCZVJmL3dOdDNIMmhm?=
 =?utf-8?B?c2U1b2FkckpIVUd0b1lWaUFPNVhxV2xNa2VWU2JTdy9oUE9CTWJUSU42b1Bw?=
 =?utf-8?B?dnR6OE9OT2MxdU9iZmNRcktuR1F3RFBpQy9kZkZrakRqYnNjNE5wYTF1SFYy?=
 =?utf-8?B?RzBMN3BJZ0I1NldvcnJqMk9NaDRqUzNHSEtCMVJkL1ZIZUpYbGZOUjFGVUJH?=
 =?utf-8?B?a2I0WUlOWElHSGFmMEVPQjZtc0JUWFozRVlqVHI2TG4vbkwrUGd1Q25DZDl5?=
 =?utf-8?B?YzZ0VERpLzB5SWdIUnpYM3FicE8xd25raDg3MVUrVVNlWUMxYU1tZk82elFO?=
 =?utf-8?B?ZUNlOGVBbVE3SndTMmFpUXd3bXJEZHZyVWFsY2ZPM0lMSlJPWVJ0VGR5VitZ?=
 =?utf-8?B?U0ZzdzBodGJlUDJUa0ppVnZGYzBrNmRCdVRMTFM3UlZLbzhZM09GN3ByS0RR?=
 =?utf-8?B?YXZhUFFFQUNRSVNaeXBOcVZqTDc5aDU5ZG1DbkVFNExtTnUrcnNtTTNKYzhO?=
 =?utf-8?B?eDFoMHVkNExlTi9Qa0pCY3JFWm9iR1ZrRXpRS0RFL0lMMGpEYzVWc0lCRk9M?=
 =?utf-8?B?YTJ3bEc3d1RFWnlJUkRGTTA2TUtpNE41T1Y2UHVFUXpaR2pBWnNEanRKQjB1?=
 =?utf-8?B?emNFU0xKZFhzTFg0V3RMa2U4dzZSNzkvaktZOFYxdVFSTzk2QWNZaEdiUXZ5?=
 =?utf-8?B?YXZ4NFBmY3hPc0lNaXVGa1dEM3hnSEw5TGlBRUUxZHRQR3pwY0lqamxoa3cz?=
 =?utf-8?B?ZDhOemswWWxhanFxb3dYVk5zdmpJRTl5OGkvU3Frc256MmtLSmZmUWJNNW5s?=
 =?utf-8?B?eE1Sc3BKQWQ5RnFvVGZlejViTnk3V0NBeEJ3d3kzY2I3ZU4wcS81a3VmYith?=
 =?utf-8?B?Rlg0R05ubVA1U1Jpa1pmbW11SEhaRURDZnhSRStZUEdHVENFUFk1R1MwTHVS?=
 =?utf-8?B?cnFHeHNWVTZGTEZsV3BCeUFSRHNvSldGL01RRm0xSjJUV1VFZkNwckxMOCt1?=
 =?utf-8?B?MHV2Nm9pQ1dZdVFDN0lPZ2cwcFFidkEvcjJnOWlHTzVreXd3bmlQMTU5TUJM?=
 =?utf-8?B?TjI2WW5DbjNGZDU5K09uY2VlTTR1Y2VtcGQzcUI3OTJsVXpGMFB2Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7452d41a-e6e7-4bd0-cafb-08da132d9f36
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 15:46:29.3533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aj+2V5M/DP5vzYBRJ8xdj9cp0hfSIHgSOw3L6RELhyC9cjojMwtBRRLMzi50Tj4K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-03-31 10:37, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:03623d90-5e39-a2fb-1068-db15c592f9f9@amd.com">Am
      2022-03-31 um 02:27 schrieb Christian König:
      <br>
      <blockquote type="cite">Am 30.03.22 um 22:51 schrieb philip yang:
        <br>
        <blockquote type="cite">
          <br>
          <br>
          On 2022-03-30 05:00, Christian König wrote:
          <br>
          <blockquote type="cite">Testing the valid bit is not enough to
            figure out if we
            <br>
            need to invalidate the TLB or not.
            <br>
            <br>
            During eviction it is quite likely that we move a BO from
            VRAM to GTT and
            <br>
            update the page tables immediately to the new GTT address.
            <br>
            <br>
            Rework the whole function to get all the necessary
            parameters directly as
            <br>
            value.
            <br>
            <br>
            Signed-off-by: Christian
            König<a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
            <br>
            ---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 63
            ++++++++++++++------------
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 15 +++---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp; | 18 ++++----
            <br>
            &nbsp; 3 files changed, 48 insertions(+), 48 deletions(-)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            <br>
            index 9992a7311387..1cac90ee3318 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            <br>
            @@ -793,18 +793,19 @@ static void
            amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
            <br>
            &nbsp; }
            <br>
            &nbsp; &nbsp; /**
            <br>
            - * amdgpu_vm_bo_update_mapping - update a mapping in the vm
            page table
            <br>
            + * amdgpu_vm_update_range - update a range in the vm page
            table
            <br>
            &nbsp;&nbsp; *
            <br>
            - * @adev: amdgpu_device pointer of the VM
            <br>
            - * @bo_adev: amdgpu_device pointer of the mapped BO
            <br>
            - * @vm: requested vm
            <br>
            + * @adev: amdgpu_device pointer to use for commands
            <br>
            + * @vm: the VM to update the range
            <br>
            &nbsp;&nbsp; * @immediate: immediate submission in a page fault
            <br>
            &nbsp;&nbsp; * @unlocked: unlocked invalidation during MM callback
            <br>
            + * @flush_tlb: trigger tlb invalidation after update
            completed
            <br>
            &nbsp;&nbsp; * @resv: fences we need to sync to
            <br>
            &nbsp;&nbsp; * @start: start of mapped range
            <br>
            &nbsp;&nbsp; * @last: last mapped entry
            <br>
            &nbsp;&nbsp; * @flags: flags for the entries
            <br>
            &nbsp;&nbsp; * @offset: offset into nodes and pages_addr
            <br>
            + * @vram_base: base for vram mappings
            <br>
            &nbsp;&nbsp; * @res: ttm_resource to map
            <br>
            &nbsp;&nbsp; * @pages_addr: DMA addresses to use for mapping
            <br>
            &nbsp;&nbsp; * @fence: optional resulting fence
            <br>
            @@ -812,17 +813,14 @@ static void
            amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
            <br>
            &nbsp;&nbsp; * Fill in the page table entries between @start and
            @last.
            <br>
            &nbsp;&nbsp; *
            <br>
            &nbsp;&nbsp; * Returns:
            <br>
            - * 0 for success, -EINVAL for failure.
            <br>
            + * 0 for success, negative erro code for failure.
            <br>
            &nbsp;&nbsp; */
            <br>
            -int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *bo_adev,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm, bool immediate,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool unlocked, struct dma_resv *resv,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t start, uint64_t last,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags, uint64_t offset,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_resource *res,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *pages_addr,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence)
            <br>
            +int amdgpu_vm_update_range(struct amdgpu_device *adev,
            struct amdgpu_vm *vm,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool immediate, bool unlocked, bool
            flush_tlb,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_resv *resv, uint64_t start,
            uint64_t last,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags, uint64_t offset, uint64_t
            vram_base,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_resource *res, dma_addr_t
            *pages_addr,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence)
            <br>
            &nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_update_params params;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_tlb_seq_cb *tlb_cb;
            <br>
            @@ -910,8 +908,7 @@ int amdgpu_vm_bo_update_mapping(struct
            amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (flags &amp; (AMDGPU_PTE_VALID |
            AMDGPU_PTE_PRT)) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr = bo_adev-&gt;vm_manager.vram_base_offset
            +
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cursor.start;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr = vram_base + cursor.start;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr = 0;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            @@ -927,7 +924,7 @@ int amdgpu_vm_bo_update_mapping(struct
            amdgpu_device *adev,
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = vm-&gt;update_funcs-&gt;commit(&amp;params,
            fence);
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp; if (!(flags &amp; AMDGPU_PTE_VALID) ||
            params.table_freed) {
            <br>
            +&nbsp;&nbsp;&nbsp; if (flush_tlb || params.table_freed) {
            <br>
          </blockquote>
          <br>
          All change look good to me, but when I look at previous
          changes again, kfd_ioctl_map_memory_to_gpu is not correct now,
          as this should flush TLB if (!kfd_flush_tlb_after_unmap(dev)).
          <br>
          <br>
        </blockquote>
        <br>
        That was intentionally dropped as Felix said it wouldn't be
        necessary any more with the TLB flush rework.
        <br>
        <br>
        Is that really causing any trouble?
        <br>
      </blockquote>
      <br>
      I discussed it with Philip offline. The TLB flushing in
      kfd_ioctl_map_memory_to_gpu is still there, but it is no longer
      conditional on !kfd_flush_tlb_after_unmap. Instead kfd_flush_tlb
      checks the sequence number to find out if the flush is needed
      (presumably because we didn't flush after unmap).
      <br>
      <br>
      There is one case on Vega20+XGMI where PTEs get inadvertently
      cached in L2 texture cache. In that case, we probably need to
      flush more frequently because a cache line in L2 may contain stale
      invalid PTEs. So kfd_flush_tlb would need to ignore the sequence
      number and heavy-weight flush TLB unconditionally in this case.
      <br>
    </blockquote>
    <p>I will send another patch to fix this case, it was regression
      from another change.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:03623d90-5e39-a2fb-1068-db15c592f9f9@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Christian.
        <br>
        <br>
        <blockquote type="cite">To fix it, seems we need beow change,
          then pass flush_tlb flag via kfd_ioctl_map_memory_to_gpu -&gt;
          map_bo_to_gpuvm -&gt; update_gpuvm_pte -&gt;
          amdgpu_vm_bo_update
          <br>
          <br>
          -int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct
          amdgpu_bo_va *bo_va,
          <br>
          &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; bool clear)
          <br>
          <br>
          -&nbsp;&nbsp;&nbsp; bool flush_tlb = clear;
          <br>
          <br>
          +int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct
          amdgpu_bo_va *bo_va,
          <br>
          &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; bool clear, bool flush_tlb)
          <br>
          <br>
          + flush_tlb |= clear;
          <br>
          <br>
          Regards,
          <br>
          <br>
          Philip
          <br>
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tlb_cb-&gt;vm = vm;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!fence || !*fence ||
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_add_callback(*fence,
            &amp;tlb_cb-&gt;cb,
            <br>
            @@ -1010,9 +1007,10 @@ int amdgpu_vm_bo_update(struct
            amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *pages_addr = NULL;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_resource *mem;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **last_update;
            <br>
            +&nbsp;&nbsp;&nbsp; bool flush_tlb = clear;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_resv *resv;
            <br>
            +&nbsp;&nbsp;&nbsp; uint64_t vram_base;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags;
            <br>
            -&nbsp;&nbsp;&nbsp; struct amdgpu_device *bo_adev = adev;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (clear || !bo) {
            <br>
            @@ -1037,14 +1035,18 @@ int amdgpu_vm_bo_update(struct
            amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo) {
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *bo_adev = adev;
            <br>
            +
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags = amdgpu_ttm_tt_pte_flags(adev,
            bo-&gt;tbo.ttm, mem);
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_bo_encrypted(bo))
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags |= AMDGPU_PTE_TMZ;
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_adev = amdgpu_ttm_adev(bo-&gt;tbo.bdev);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_base =
            bo_adev-&gt;vm_manager.vram_base_offset;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags = 0x0;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_base = 0;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (clear || (bo &amp;&amp; bo-&gt;tbo.base.resv ==
            <br>
            @@ -1054,7 +1056,7 @@ int amdgpu_vm_bo_update(struct
            amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_update = &amp;bo_va-&gt;last_pt_update;
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!clear &amp;&amp; bo_va-&gt;base.moved) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_va-&gt;base.moved = false;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_tlb = true;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_splice_init(&amp;bo_va-&gt;valids,
            &amp;bo_va-&gt;invalids);
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (bo_va-&gt;cleared != clear) {
            <br>
            @@ -1077,11 +1079,11 @@ int amdgpu_vm_bo_update(struct
            amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_amdgpu_vm_bo_update(mapping);
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_bo_update_mapping(adev, bo_adev,
            vm, false, false,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resv, mapping-&gt;start,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping-&gt;last, update_flags,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping-&gt;offset, mem,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_addr, last_update);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_update_range(adev, vm, false, false,
            flush_tlb,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resv, mapping-&gt;start,
            mapping-&gt;last,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; update_flags, mapping-&gt;offset,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_base, mem, pages_addr,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_update);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            @@ -1104,6 +1106,7 @@ int amdgpu_vm_bo_update(struct
            amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_splice_init(&amp;bo_va-&gt;invalids,
            &amp;bo_va-&gt;valids);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_va-&gt;cleared = clear;
            <br>
            +&nbsp;&nbsp;&nbsp; bo_va-&gt;base.moved = false;
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (trace_amdgpu_vm_bo_mapping_enabled()) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(mapping,
            &amp;bo_va-&gt;valids, list)
            <br>
            @@ -1272,10 +1275,10 @@ int amdgpu_vm_clear_freed(struct
            amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping-&gt;start &lt; AMDGPU_GMC_HOLE_START)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_pte_value = AMDGPU_PTE_DEFAULT_ATC;
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_bo_update_mapping(adev, adev, vm,
            false, false,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resv, mapping-&gt;start,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping-&gt;last, init_pte_value,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, NULL, NULL, &amp;f);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_update_range(adev, vm, false, false,
            true, resv,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping-&gt;start, mapping-&gt;last,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_pte_value, 0, 0, NULL, NULL,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;f);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_free_mapping(adev, vm, mapping, f);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(f);
            <br>
            @@ -2519,8 +2522,8 @@ bool amdgpu_vm_handle_fault(struct
            amdgpu_device *adev, u32 pasid,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unlock;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp; r = amdgpu_vm_bo_update_mapping(adev, adev, vm, true,
            false, NULL, addr,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr, flags, value, NULL, NULL, NULL);
            <br>
            +&nbsp;&nbsp;&nbsp; r = amdgpu_vm_update_range(adev, vm, true, false,
            false, NULL, addr,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr, flags, value, 0, NULL, NULL,
            NULL);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unlock;
            <br>
            &nbsp; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            <br>
            index 6b7682fe84f8..1a814fbffff8 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            <br>
            @@ -402,15 +402,12 @@ int amdgpu_vm_handle_moved(struct
            amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm);
            <br>
            &nbsp; void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base
            *base,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm, struct amdgpu_bo
            *bo);
            <br>
            -int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *bo_adev,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm, bool immediate,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool unlocked, struct dma_resv *resv,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t start, uint64_t last,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags, uint64_t offset,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_resource *res,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *pages_addr,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence);
            <br>
            +int amdgpu_vm_update_range(struct amdgpu_device *adev,
            struct amdgpu_vm *vm,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool immediate, bool unlocked, bool
            flush_tlb,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_resv *resv, uint64_t start,
            uint64_t last,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags, uint64_t offset, uint64_t
            vram_base,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_resource *res, dma_addr_t
            *pages_addr,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence);
            <br>
            &nbsp; int amdgpu_vm_bo_update(struct amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va *bo_va,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool clear);
            <br>
            diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
            b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
            <br>
            index 27533f6057e0..907b02045824 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
            <br>
            @@ -1188,9 +1188,9 @@ svm_range_unmap_from_gpu(struct
            amdgpu_device *adev, struct amdgpu_vm *vm,
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;[0x%llx 0x%llx]\n&quot;, start, last);
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp; return amdgpu_vm_bo_update_mapping(adev, adev, vm,
            false, true, NULL,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start, last, init_pte_value, 0,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, NULL, fence);
            <br>
            +&nbsp;&nbsp;&nbsp; return amdgpu_vm_update_range(adev, vm, false, true,
            true, NULL, start,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last, init_pte_value, 0, 0, NULL,
            NULL,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fence);
            <br>
            &nbsp; }
            <br>
            &nbsp; &nbsp; static int
            <br>
            @@ -1277,12 +1277,12 @@ svm_range_map_to_gpu(struct
            kfd_process_device *pdd, struct svm_range *prange,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 :
            0,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pte_flags);
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_bo_update_mapping(adev, bo_adev,
            vm, false, false,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, last_start,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;start + i, pte_flags,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_start - prange-&gt;start,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, dma_addr,
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;vm-&gt;last_update);
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_update_range(adev, vm, false, false,
            false, NULL,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_start, prange-&gt;start + i,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pte_flags,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_start - prange-&gt;start,
            <br>
            + bo_adev-&gt;vm_manager.vram_base_offset,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, dma_addr,
            &amp;vm-&gt;last_update);
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j = last_start - prange-&gt;start; j &lt;=
            i; j++)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr[j] |= last_domain;
            <br>
          </blockquote>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
