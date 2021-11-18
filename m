Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6512C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 14:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7914B61452
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 14:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7914B61452
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A2516E96C;
	Thu, 18 Nov 2021 14:31:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67F3D6E96C
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 14:31:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+EnfUT+eCc1palsORXszQhxVZY3q44eWRFK468jnYbMj2SuoSUzAZ8+yh0rtk6epy9T6erlyuWg3Sh+W17v90MZsp50CPpeENKfuQeaRq/X9Zlbyv/ohMDuA/1ajzQT+lBOM9BS6wZpEgvp2Fb9lll2CLfjQm30bSJoNAnVTCLOLpyUWgzbBAFK5NiFW5RgENr+VTBf9zH5MI6T7yepkTWeYvveTNGVZlpDxuFDva9/rdpJ6AzgWItt1taEfmJTnKF3EzvbsHhDXL2NOS7FeBOtDxXhnGzh/S1TvaEr3L/KNxrYTnPGFh05jmPx4hmsJOeUMgV7FNkfeRn9QDZPfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zh9M4QmLnd6v3sN6K08vUH7XYuLLg0KLRoqIPp/ucmI=;
 b=CymWg/gGBt6SIvZEtO4Gac5ep/lG5SczGY5iUhdXoQs3xf+gl0Vcgxex+TNV+PLuSjdqGQ9oRht4d4789tuiMJz0ovPZlGmwX76dV50AI+En4D77VYhd1H+Ihk/ghsdVr3Uc3JBTaOmod/lKV8rA67lixL07YzT+ZC559aNQcoSWiMEs2Q4WsJGb8wh7NncGvc1hH3XkQV8G+5D4kPByjVJtdPsqJZ9ZyOLtN7Swop4NNbTaDz0sWgp+/kTWg59MMbnIgnb+iAqnJg5xK+JwDXAtRSDB1bI8XD+wqp0oH+GBITACehDeehzCsWL0YxwkMD/mhv6j86MbxsyuicUOQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zh9M4QmLnd6v3sN6K08vUH7XYuLLg0KLRoqIPp/ucmI=;
 b=vSZJqok91jUOk8oxVDVkVeLq9wuh25o5sD5fTrbJHz65bbvBggbIZVCP4IdUYfLyLMGBUnoLBJ3IaFlqP4P+ABxBYdKPD+OOH1X/O64Kzt7fUJQbHV3HaJRr4UAM1V5kx6hakBq3x9gf/8BFAVw4gxa+sQvtmv6d7aqc16IHaBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5360.namprd12.prod.outlook.com (2603:10b6:5:39f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 18 Nov
 2021 14:30:58 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::dcf7:d6ee:654f:a2cf%4]) with mapi id 15.20.4669.015; Thu, 18 Nov 2021
 14:30:58 +0000
Subject: Re: [PATCH 1/3] drm/amdkfd: process exit and retry fault race
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211117034324.4663-1-Philip.Yang@amd.com>
 <fb6b3750-56e4-8a79-c479-10c4cbbd3e4a@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <040dda91-4fb3-044a-2bc3-6450cc073744@amd.com>
Date: Thu, 18 Nov 2021 09:30:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <fb6b3750-56e4-8a79-c479-10c4cbbd3e4a@amd.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0052.namprd02.prod.outlook.com
 (2603:10b6:207:3d::29) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
Received: from [172.27.226.38] (165.204.55.251) by
 BL0PR02CA0052.namprd02.prod.outlook.com (2603:10b6:207:3d::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 14:30:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6806cdc9-7f9c-4685-6607-08d9aaa009ad
X-MS-TrafficTypeDiagnostic: DM4PR12MB5360:
X-Microsoft-Antispam-PRVS: <DM4PR12MB536093FAE786BBC12A97458FE69B9@DM4PR12MB5360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dx3SwvVXNjyx4wdJpQtpK1ITPCeOpo/aLyEtGToUYWhORKFfDWvXEXNX+2kt/CqDiEGy68A2VHPanxRDYHuz6hR/bV0gsNrGrytTPr4IBesPZhhKMNjQpj32JLO5S7DEgfsUeN6N/t8sB1ykZpR9wZDkT2AZpjSXCWKetealA4M9gU6PxtGcy/DV7p3N8F2Syt08TEmnkjA8wUSSmUE8Egrsf/QTBcjZU0TDrIfjHwjl8z1Zz7XPBCBbSIumNADG2xspSOCIICIfMb37/WgeA4SjgHPEeCQonZNy0NoCLMh5aQ2V6JYSkGb00YslbaFvyy3TvjDKcnAnJnzj8Rchxw4B7C5/PQRM48K5UN3E6yBQ56iJkQxkbZvg/XRZ9Xtpm4IN4t5IzM0PUxQxyZ3/CkBN2We3aQkf9ncfA7RnpTghy14XclmOhrIsuIcoIwbjXiHXXw4jbMyv70EUcac4BlPigC33AmM3KXXK0O+DN61MIk9J9mDW8ckx9cCo00r72TcFuxWxi+EQ37DE8nsrvy+g0vdQlCgQgGbLPmX9fxn8UIUP13nMkC864X9OLCl6xfEqDDydwEmAp7oiyiKNXH30x+6qmCRfChKd6sofd/woYNe0XoTx1qwywAqmzcILmqgePG93xnsfh8Ojsf32TKN4V8DL6hLhjga1XKZFXA3DpEfQkxEt+dFUr25j2tWnF5ifq97QVOpu/X5Ths9L94Fh8tIntiI44UBcfoZWcws=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(31686004)(8676002)(2906002)(8936002)(53546011)(66946007)(66556008)(66476007)(316002)(26005)(16576012)(186003)(508600001)(31696002)(38100700002)(83380400001)(5660300002)(2616005)(956004)(4001150100001)(36756003)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTUraGFGQWlNVzFOMnBEY1NNN0txejl0UTZPdDJaQ2JlRGwyYXhKUXJHNE93?=
 =?utf-8?B?TitHU1NVdlcwM0VSQm44TXFsYzR1d0Y1MWhNUDlYek5pUGRwc1NUb3BhUUpy?=
 =?utf-8?B?UkFuQWd4ZThNTEVOa0ErTmZJRExwNVZzUy8vbXc4VDVvL1JjeWs1QS9aVGx1?=
 =?utf-8?B?RnBweklWVHJrNU83TjMzOWl2UkNlSFZjZVRjK0t0V3pseWRBVzAvOTNhSXFw?=
 =?utf-8?B?cmhWZnFENFBISTBaVEpvQ3Y0UkRjalZxVzMyemVHWHZwQ2x4QllnMVFTeEFC?=
 =?utf-8?B?a1Fmb3R5Q1duenB5VmVPRlBjVUFkOENpUDh2TnIyYkVnVzdvaThWR3dleU9T?=
 =?utf-8?B?V2RGZGVuUHdCSThrN1RMSDYzb2FVOFVWY1ozUEJ1Wk5tRUdhVnlwZjlnNUc4?=
 =?utf-8?B?d3E5WUNCL29pY0xPYTBDcCszdUdDN29rUXBuczA2bndDNGYwNDgyYzkrT0hT?=
 =?utf-8?B?Q0FVcDVzUGlNbTFpd0l6NTZOZTY2VEYvUWF6bDBTa29JZTVMYkxEeGtTZFJC?=
 =?utf-8?B?cFVyUXZBZnE2anptaXdUNmJFL253K3Z0OURrZ2E5MkJYS1pxOVdMWXdIcFVM?=
 =?utf-8?B?TWhiaFV6ZE9ZUDBITlN1Rk1yYXBiTi9XZlZydGtnUm9LV0tuL3JNOVF3Y2RY?=
 =?utf-8?B?RWRsWXJUNENkTmwzQkU3VFB0b0htNHpJRGs3TDg1a0VDL1hLZWN6TndORFls?=
 =?utf-8?B?eE83RFowUlB1NUIzKy9rN3NCaU5UZnBsQU1oL2ZNV1NUdklsYnpDQTV5VDhJ?=
 =?utf-8?B?aGpVaFNEUE5vUS9ORE1TUXk0ekt1RFhLYXhLVnpyMVlXcGpKOXYxTlZPbXc0?=
 =?utf-8?B?YkI1TTh5N2NjSXNrNGJJZjBuaHdtWGJSa0JhcjJVaHhuaEZuNWNaUi9HQW5h?=
 =?utf-8?B?TTZkUjViYUkvUTF5bDlERGdReVhiU25PemlDUUtKT0NwV2hNeGg3RElseElU?=
 =?utf-8?B?ZDc1Mkw3c24za01ScXNHdnVFOFJnRDVRTlR0VkNsNkMvZUhNc1FtMEg2VEw0?=
 =?utf-8?B?Q2xTR1BXRzU4Y0VLUXpYREwvYzYzZGQxaUhrR0daaGxPbTZTMVVlZll4WkpX?=
 =?utf-8?B?dGF0L1ZRZmo2R3pVdm1obmc1cG10U2I3dVFYN1BBSk94QzdhRkNyeXo1Viti?=
 =?utf-8?B?Y3BZc1lDMlBPOTRpUG5uWEYrTForMjMwdWFDU2lnNnVUUGtSOVRvNmpFME9C?=
 =?utf-8?B?dVNqcGJpd2xCbzVuS3FwUkg2UitFRmhEblNxVGUrUCtXUXFBQlFzK2h2WFJm?=
 =?utf-8?B?OTlmRXYvQTdiZzE5RFNzS3hSbnZLck9HeS94bHBwcTNCNGNTRXViblBEVW8r?=
 =?utf-8?B?VmtrWm9WdzFENGhnYWQrOERRSFBOY3JjOHdUTmVTUWREcDA4ckNDN2lUUm9j?=
 =?utf-8?B?QitvdGFkSUpBdVZ2RGhKNWEwUHc2cU9wdzBkV1paU1ZlMUlsdkdzZnZRMUIy?=
 =?utf-8?B?V1FkSGh4SHM1ZUVtQWR2TGNGSzdxWEYreGhpVlE3UjhaRmdwN1NteVFXdDE3?=
 =?utf-8?B?MDFNbFlIb3FTK2k1UHBTN0NKbGxzQ1crTFM2cTU1VHBMeko2NTE5Vjl6Z1lh?=
 =?utf-8?B?cE9LS3d1MENEQ0JYK1V2N0p3T3VSakl6OUdxZ3pnL2tCRDVVSGRPRXl4UHpj?=
 =?utf-8?B?c0wxNXNZeXdkRkNrQW9NTGkraXBmS2lCMCt3bTFqck1GV29JOUJzU3Y1VXhY?=
 =?utf-8?B?ZWQ2VEFGcC9mWTh5Nm1mcjgyajhoWjd1YmtDMXJJa2E3Zjlpak94WlBBR1NB?=
 =?utf-8?B?TDBpT2l4cm9xQjZMQjJuamRMTWVhT21BdEFMNHNNSjZ4WnNTcWJLR01XRG5B?=
 =?utf-8?B?S0RQaHFpaEMwT3RFcEhvUmhjc0JLczNMMnVWWTBqNFllS1RQM3kveEQ1dFZC?=
 =?utf-8?B?K2tSb1l3bDlWTzZEeFZKM20rVHJXZ1M5dzNVUGdHR0FJQTd3bUZzNlRXb0E1?=
 =?utf-8?B?UThEK0ZFK3pQQ3ZxeVhXbDF4cFRBRmtVZ3ZldTVsaGNkaHhCbzYyLzM4blE1?=
 =?utf-8?B?T0VTL1VTVnowdlkzUTMxaHNmWUZqTUhzWTVIcUJyUE5MZjcvMzM3N3FvSVlv?=
 =?utf-8?B?Y244VFp1UkdUcm53WGVvTWI5dkFyVi9PdjRRRFUzalhrSHpxUTFrNm8wTkl2?=
 =?utf-8?Q?kot0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6806cdc9-7f9c-4685-6607-08d9aaa009ad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 14:30:58.5216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: On4eFpUcUI+MerH6eN3fkqRM6qyfBHEN34X9dzJZR4HBtKB7uZPC66DlBLy26kNc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5360
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
    <div class="moz-cite-prefix">On 2021-11-17 6:18 p.m., Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:fb6b3750-56e4-8a79-c479-10c4cbbd3e4a@amd.com">On
      2021-11-16 10:43 p.m., Philip Yang wrote:
      <br>
      <blockquote type="cite">kfd process mmu release notifier callback
        drain retry fault to ensure no
        <br>
        retry fault comes after removing kfd process from the hash
        table,
        <br>
        otherwise svm page fault handler will fail to recover the fault
        and dump
        <br>
        GPU vm fault log.
        <br>
        <br>
        Drain retry fault needs flush restore page fault work to wait
        for
        <br>
        the last fault is handled because IH dispatch increase rptr
        first and
        <br>
        then calls restore_pages, so restore pages may still handle the
        last
        <br>
        fault but amdgpu_ih_has_checkpoint_processed return true.
        <br>
      </blockquote>
      <br>
      This fixes the problem, but it will result in waiting longer than
      necessary because the worker only finishes when the IH ring is
      empty.
      <br>
      <br>
    </blockquote>
    Working on new IH ring1 overflow patch to handle drain_retry_fault
    race, flush will not need here.<br>
    <blockquote type="cite" cite="mid:fb6b3750-56e4-8a79-c479-10c4cbbd3e4a@amd.com">
      <br>
      <blockquote type="cite">
        <br>
        restore pages can not call mmget because mmput may call mmu
        notifier
        <br>
        release to cause deadlock.
        <br>
      </blockquote>
      <br>
      See my comment inline.
      <br>
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Refactor deferred list work to call mmget and take mmap write
        lock to
        <br>
        handle all ranges, to avoid mm is gone while inserting mmu
        notifier.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c |&nbsp; 6 +++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp; | 69
        ++++++++++++------------
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 +
        <br>
        &nbsp; 3 files changed, 41 insertions(+), 35 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        index d4c8a6948a9f..8b4b045d5c92 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        @@ -1143,6 +1143,12 @@ static void
        kfd_process_notifier_release(struct mmu_notifier *mn,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (WARN_ON(p-&gt;mm != mm))
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; /*
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * Ensure no retry fault comes in afterwards, as page fault
        handler will
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * not find kfd process and take mm lock to recover fault.
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp; svm_range_drain_retry_fault(&amp;p-&gt;svms);
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;kfd_processes_mutex);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hash_del_rcu(&amp;p-&gt;kfd_processes);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;kfd_processes_mutex);
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index 88360f23eb61..c1f367934428 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -1953,9 +1953,10 @@ svm_range_handle_list_op(struct
        svm_range_list *svms, struct svm_range *prange)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; }
        <br>
        &nbsp; -static void svm_range_drain_retry_fault(struct svm_range_list
        *svms)
        <br>
        +void svm_range_drain_retry_fault(struct svm_range_list *svms)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd;
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;
        <br>
        &nbsp; @@ -1967,9 +1968,11 @@ static void
        svm_range_drain_retry_fault(struct svm_range_list *svms)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;drain retry fault gpu %d svms %p\n&quot;, i,
        svms);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev = pdd-&gt;dev-&gt;adev;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_wait_on_checkpoint_process(adev,
        &amp;adev-&gt;irq.ih1);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        amdgpu_ih_wait_on_checkpoint_process(pdd-&gt;dev-&gt;adev,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        &amp;pdd-&gt;dev-&gt;adev-&gt;irq.ih1);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wait for the last page fault is handled */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_work(&amp;adev-&gt;irq.ih1_work);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;drain retry fault gpu %d svms 0x%p done\n&quot;,
        i, svms);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; }
        <br>
        @@ -1979,43 +1982,43 @@ static void
        svm_range_deferred_list_work(struct work_struct *work)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range_list *svms;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *prange;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mm_struct *mm;
        <br>
        +&nbsp;&nbsp;&nbsp; struct kfd_process *p;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms = container_of(work, struct svm_range_list,
        deferred_list_work);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;enter svms 0x%p\n&quot;, svms);
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; p = container_of(svms, struct kfd_process, svms);
        <br>
        +&nbsp;&nbsp;&nbsp; mm = p-&gt;mm;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* Take mm-&gt;mm_users to avoid mm is gone when inserting
        mmu notifier */
        <br>
        +&nbsp;&nbsp;&nbsp; if (!mm || !mmget_not_zero(mm)) {
        <br>
      </blockquote>
      <br>
      get_task_mm would be safer than relying on p-&gt;mm. I regret ever
      adding that to the process structure.
      <br>
      <br>
    </blockquote>
    Will use get_task_mm(pdd-&gt;process-&gt;lead_thread), it is safer
    as we take task reference.<br>
    <blockquote type="cite" cite="mid:fb6b3750-56e4-8a79-c479-10c4cbbd3e4a@amd.com">
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svms 0x%p process mm
        gone\n&quot;, svms);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +retry:
        <br>
        +&nbsp;&nbsp;&nbsp; mmap_write_lock(mm);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* Checking for the need to drain retry faults must be
        inside
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * mmap write lock to serialize with munmap notifiers.
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp; if (unlikely(READ_ONCE(svms-&gt;drain_pagefaults))) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_ONCE(svms-&gt;drain_pagefaults, false);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_write_unlock(mm);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_drain_retry_fault(svms);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto retry;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;svms-&gt;deferred_list_lock);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (!list_empty(&amp;svms-&gt;deferred_range_list)) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange =
        list_first_entry(&amp;svms-&gt;deferred_range_list,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range, deferred_list);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del_init(&amp;prange-&gt;deferred_list);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;svms-&gt;deferred_list_lock);
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;prange 0x%p [0x%lx 0x%lx] op %d\n&quot;, prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;start, prange-&gt;last,
        prange-&gt;work_item.op);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mm = prange-&gt;work_item.mm;
        <br>
        -retry:
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_write_lock(mm);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;svms-&gt;lock);
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Checking for the need to drain retry faults must be
        in
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * mmap write lock to serialize with munmap notifiers.
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Remove from deferred_list must be inside mmap write
        lock,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * otherwise, svm_range_list_lock_and_flush_work may
        hold mmap
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * write lock, and continue because deferred_list is
        empty, then
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * deferred_list handle is blocked by mmap write lock.
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;svms-&gt;deferred_list_lock);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(svms-&gt;drain_pagefaults)) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms-&gt;drain_pagefaults = false;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;svms-&gt;deferred_list_lock);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;svms-&gt;lock);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_write_unlock(mm);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_drain_retry_fault(svms);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto retry;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del_init(&amp;prange-&gt;deferred_list);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;svms-&gt;deferred_list_lock);
        <br>
        -
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;prange-&gt;migrate_mutex);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (!list_empty(&amp;prange-&gt;child_list)) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct svm_range *pchild;
        <br>
        @@ -2031,12 +2034,13 @@ static void
        svm_range_deferred_list_work(struct work_struct *work)
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_handle_list_op(svms, prange);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;svms-&gt;lock);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_write_unlock(mm);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;svms-&gt;deferred_list_lock);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;svms-&gt;deferred_list_lock);
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; mmap_write_unlock(mm);
        <br>
        +&nbsp;&nbsp;&nbsp; mmput(mm);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;exit svms 0x%p\n&quot;, svms);
        <br>
        &nbsp; }
        <br>
        &nbsp; @@ -2600,12 +2604,8 @@ svm_range_restore_pages(struct
        amdgpu_device *adev, unsigned int pasid,
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;restoring svms 0x%p fault address 0x%llx\n&quot;,
        svms, addr);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; mm = get_task_mm(p-&gt;lead_thread);
        <br>
        -&nbsp;&nbsp;&nbsp; if (!mm) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svms 0x%p failed to get mm\n&quot;, svms);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -ESRCH;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        -&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; /* mm is available because kfd_process_notifier_release
        drain fault */
        <br>
      </blockquote>
      This is not a valid assumption because the mm_users count is 0
      when the notifier_release runs. So you can't rely on the mm being
      usable here while you're draining faults in notifier_release.
      <br>
      <br>
      A better way to avoid the deadlock would be to drain faults not in
      notifier_release, but in kfd_process_wq_release.
      <br>
    </blockquote>
    <p>Good idea to drain faults in kfd_process_wq_release, then we can
      keep get_task_mm(pdd-&gt;process-&gt;lead_thread), if task mm is
      gone, it is safe to ignore the fault, return 0, not -ESRCH.<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:fb6b3750-56e4-8a79-c479-10c4cbbd3e4a@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp; mm = p-&gt;mm;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_read_lock(mm);
        <br>
        &nbsp; retry_write_locked:
        <br>
        @@ -2708,7 +2708,6 @@ svm_range_restore_pages(struct
        amdgpu_device *adev, unsigned int pasid,
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_count_fault(adev, p, gpuidx);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; mmput(mm);
        <br>
        &nbsp; out:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_unref_process(p);
        <br>
        &nbsp; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        index 6dc91c33e80f..0a8bcdb3dddf 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        @@ -189,6 +189,7 @@ void svm_range_prefault(struct svm_range
        *prange, struct mm_struct *mm,
        <br>
        &nbsp; struct kfd_process_device *
        <br>
        &nbsp; svm_range_get_pdd_by_adev(struct svm_range *prange, struct
        amdgpu_device *adev);
        <br>
        &nbsp; void svm_range_list_lock_and_flush_work(struct svm_range_list
        *svms, struct mm_struct *mm);
        <br>
        +void svm_range_drain_retry_fault(struct svm_range_list *svms);
        <br>
        &nbsp; &nbsp; /* SVM API and HMM page migration work together, device
        memory type
        <br>
        &nbsp;&nbsp; * is initialized to not 0 when page migration register device
        memory.
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
