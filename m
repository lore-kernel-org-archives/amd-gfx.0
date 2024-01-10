Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4F1C47258
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 19:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C207210E651;
	Wed, 10 Jan 2024 19:11:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4241410E651
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 19:11:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7Q3O5sLPxlYrbB55c1Nbt1mP6RZ2Su347DuqVAf6Gvy2eI6V2OqJWTdfFCd219y1O2MoYr9R5WyMvAjLTuFnG0gaS5Wp8NG9YZc5/U7wZlXLO5wnA+h2V1K1lOclsdihQPZO5GFTVShAuf7IhT1odA6wYxsqSgeByXrNIjgIuD/H1jalMdWp305J6RNjNd6k37lBakd8HiWJi6ZI81d4ghLqgX0hNLYuOoKq9uHQ/zCs0h/4gpj2XdNKzZUVSsFUMqhbaaYclCkLU/I1rRk7uwH0Q7bA1ld1ju+83tAu/Vw2gsh8+2gZ1bzM9Vygtxfocu+azAkma2foeDNCwsbgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQLsFYuIorcUk6T6T+N+dt2lq3XzfJiEM9/bt+/u2e8=;
 b=WyZhDA4UnH94cPGsCg8SJucx0oTw/zo4Jol06EG26ADIPpSSZ3nEv8ksqDX3fN8KtvDZhPm9CXDmHvyrJ4jS+xVbm9pSwDpY7FVt5ENdMazz24BzBfhmIH+MYYMjuyPhL1CCcW4BoOdgXlzyUVfyFKjKC1mIHUiRHM4csv7yGQ5WrBE1xSJbRKuzZ8ZW9Me2+gbVY3/0/w0uU+/ckHO2Y9UnEAZHe6xOkOS6BgnfSgebksYFzag99xUv+AVqmzuzp1HW4jMeVPOBt3ymTF2liszt8zjnLGrrTk954UUnPdZjJn5mfERnpXSsl2VMIQzwxE/vVxnhJ2EyZpUdj/X4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQLsFYuIorcUk6T6T+N+dt2lq3XzfJiEM9/bt+/u2e8=;
 b=TtAId69CCkbtb3rqIDnMttIogw4wxPMuw67pQ6gOZkbRSNmqx14V+Krr26E+6slmZ3VM81UZT2ATAzqOARr6/Az5Too0vyxi+xJeL7+2I22yYmt/f+T7tvxqi5nEhwM+6QaWehuqAlzC5/dyyqp6Aj0zq05fxC2QbXt1o1z1gBs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 19:11:41 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::267c:6dd1:b603:a75c]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::267c:6dd1:b603:a75c%4]) with mapi id 15.20.7181.018; Wed, 10 Jan 2024
 19:11:41 +0000
Message-ID: <a9145c80-656d-4746-3e4c-981b7f82cadc@amd.com>
Date: Wed, 10 Jan 2024 14:11:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] amd/amdkfd: Set correct svm range actual loc after
 spliting
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240109200527.24039-1-Philip.Yang@amd.com>
 <21fb682d-517e-4d23-b7fe-b1eeff683ab2@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <21fb682d-517e-4d23-b7fe-b1eeff683ab2@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0163.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::6) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS7PR12MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: fd3e09d9-79e2-4b23-28ad-08dc120ffa68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WN55sjcPXnLZMGZzULLxwEXeletT7GIoWHPr2IP1gZEL11oQ57WaA68mYzJ3IcEggq8pXQD1hV3wwMqXX5QG9JjKHndkB0O/S6OTU6CdCigemZn2PmehuaOD+TD8bFif6lKmAcQDBePyIyXS2MO31os3zm8MD38tAgObj3dABbhqzlN+3xpO1xlDUQP6T1g0JWEGzwS7/HVWbReXnrArItfieS+4bfBhlpjPAG3+TNQLCXl8xJ5eJwZHeZJKpAeESaMm5CgcM0CotiWSD8LsvnYulkJ4B9uCDNMFM03+4jPQpqRX2YW6T4eEfEP+HmRJLURQ5d8FABFu4YHrcgpNMN/SrEYDIQTQxvpkQQf1SY/1/NH6yNPCVLPCjEq1mCLV72jqKTI5bOJ8ULLjzleqqfSa7AwID/wLetb2l5aWi37HoSyrRH3pMGo9RMWKlwK8uUYqUhgFt8x2w3IW9hSq2dYsYY2e1EqVQ6VZvQxrcPCNu6i6tlhE7+kgs/Z383IyU56hNZ9vHme0n1TQYBISUeQf4/oEdfygCR3mQkm/5R+GVCmfFSCe2afTZCB3T8bvQeTqqojaTxxb9XVFlIsgyUqU54CLWLK2w1K/zPYFZdJ4Pj+GoXuN4l2WmJpbwx7SH1wlJJt0E7dB8gswQkQg2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(39860400002)(376002)(136003)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2906002)(5660300002)(41300700001)(478600001)(6486002)(38100700002)(83380400001)(26005)(2616005)(6506007)(53546011)(6666004)(6512007)(66556008)(8936002)(8676002)(66476007)(4326008)(31696002)(31686004)(66946007)(36756003)(316002)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG5TeStJWldkWUdoSFJVVUszLy9pdGUvS09SdUZlY0xFTEJkaERTK1BDa3lp?=
 =?utf-8?B?TnJKaGlHbGtZcUVycHZlWTY0c2FrVm1pU2RDRDhReHBBRllhVXZESmpFcDcv?=
 =?utf-8?B?TnZsYnBHa2ZJelhndjBya0ZaaVZ3VDk3K0YwSUFZWUJDZzZKa1o3VmR6Rnkx?=
 =?utf-8?B?S2w5ZjBBMGY5UzBXams5N2IxVVhabk1ucEc3N0NzZUo1dDhUTFIzTkdJMmRU?=
 =?utf-8?B?VkROUG84N0grSWlnQ1ZHK05oSnhsMll4SklIT2tia0xVUUVBN1N5SnlIWHEz?=
 =?utf-8?B?Ty9lcnI1N3NQOGJuMFZqM01uR0lOdHc2K0pKeWMrUEhrRFFIZWt5VmJjelpJ?=
 =?utf-8?B?U1p1aVJ5bThMR0NZUjM3bXNyd204SGdsSGI3K0kzL2h3TFlWTGl3ejRxQ05M?=
 =?utf-8?B?NG5TQTFMYm4xSFlWQW9VcXFmUFpmNis2a1FMc1k5amlhaHoyNXlOczkxcXMz?=
 =?utf-8?B?Z0VVbEpwSURWR3g0Zm1OSzZiRHZKZnJIQ0liUWRKeWtmcnZLamdlNmdIMitO?=
 =?utf-8?B?dXFXYjFDOHZmdjdFUWFjT0E5M1VoYlJodkQvVjFNMHBweS9GVXZ2bU5RNzAw?=
 =?utf-8?B?Z0t2ZzVrS3A5Sm9iajIrbEhSVnhhcER1Y3FMNG5jR1ZpSGtXbTZNdGwvQ2g2?=
 =?utf-8?B?OFU2K0ZiaXZjVHZQYk1zVjJMVkZqcnROa2RXVlhySmFZSVRkdTZIcnZ3UjhY?=
 =?utf-8?B?NjJUMGYycW5STDY3Z2lYS1ZFS2xjM1lTamRpRzEzUzJOd1pBYllPamVYY0ts?=
 =?utf-8?B?UEpCZTFDM21IYWtvTk5hZTEyMkM3bXVtakxvWUtLdjJ3Y1FQc0tkRjEwdEpG?=
 =?utf-8?B?Z1FNdDVYM0paZjNJSk1MbDgzMHVPUEY1ZEZkV0RzNHAwZm9INVFaSUFBclZZ?=
 =?utf-8?B?ZDZseFBhRjRwWlFma280d2poWmt0aFJJNTB1QkRoQkdwNVEzN2x3d3pGakdQ?=
 =?utf-8?B?aXdXSms1cEs3L2NFVFVVa01zMm5QUGlVNFEweDRCMFlBMlJsMG9FcERIa2Fx?=
 =?utf-8?B?UzhBWkdLRXVvVGhadzhpcCtJZlFXZ0pzcFdiN2tjQ1Z1NjB0V1RUMVJNMmRX?=
 =?utf-8?B?YTdWMjFmdFI0RXZCOVF4ZlJQdlRVdWdoTDN0U3lyejZFOUthdGNWRnR2Y0dX?=
 =?utf-8?B?cFFIa3k4UlpuY2FOR2dLcW8xd29wV3ZDZ0tMUnhueTh3RzRvZ040N2h2bnk0?=
 =?utf-8?B?QS8vdzlxMUgyc3ovU0h0cGdGTi9CaFRCRkJBbitXaUhsSEp3SXoyc1lJMHB6?=
 =?utf-8?B?MzZNR1NmUTFBSlVOOE9nMitTTDQxUlF1bVVGeHFjYWFVaUZEbkZ4d1pocm5N?=
 =?utf-8?B?K1JRU0lpa0Q5cVdOVDh6R09sSGpiZHphT1VRejNBTmRBVnFYTmxtV1Yrc1Bt?=
 =?utf-8?B?NllrSmwvajdSSSs4d214MS9uN25HOU5KREVpdllXeW00ZEVvdnZPNUgzS0Rx?=
 =?utf-8?B?T2ZKMjhFNnRPQUFUcG5JN214bis2eTl2RGtXUkZJZjBaeXFkUnoveDdrR2Zr?=
 =?utf-8?B?eTlMNTc5K0lUeFg0WE90OHV4enptYXhHM3BLeVhJZU9LTzBQeWNlcjFpZVpX?=
 =?utf-8?B?a3hxT2Qxbk91eXJWMEJIVUhoZGM4YmRuMlA0Yk8zLzlpTG9DaElaUCtiWVJp?=
 =?utf-8?B?OHVUcFI5c0hKbCs4RDI0Z0ttTnZYenJTays5ZE5XQ2UrWlh3b1g3bEVBOHlD?=
 =?utf-8?B?SnBTZjBQVzlCS3d2Uy9KdnVrYXVCYWVkWU9zS1Y1Z0c5R0RxN095UUdyeHI1?=
 =?utf-8?B?aTlPbWRzc0JEWTZiVnQxdmI0bngwaFZ2b1BUWXFCaDVGN29pRDFGSDJNN3lv?=
 =?utf-8?B?SE53bkUxZFc1bHlrQU9TZStxc3BkOTZiZ1RlRDZqUVRWT3J6WTY4emtML2dJ?=
 =?utf-8?B?Mml1MkY5KzRxQ245UTJRQkluNUdtUExTUjhPVFQrS3hBVlplUExDMzd5WUgr?=
 =?utf-8?B?R05WdWhEVEJHekVwRWZYbmExZDVMUm04R1lkRzYvRFJ3NFlIdWxwSENJT2sx?=
 =?utf-8?B?QU0ySXA1WEI3MGV0UnZYN1NlZGF3NTgvSG1KdFBEVHlWRUI5YmtUUTRpbWZ2?=
 =?utf-8?B?UjkwSUFFVkQzelhwb2ZPM0REL3BSWjdWMDEvM3ozV3ZZYUFvcVl0djhUWkE3?=
 =?utf-8?Q?L6Ds=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3e09d9-79e2-4b23-28ad-08dc120ffa68
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 19:11:41.7904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iaW6xa2i44+H5+9zc8fNyirhoHpHvG2b55vPI+KtPqJnon8mLWxR6FjGFDM3njpq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214
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
Cc: Xiaogang.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-01-10 11:30, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:21fb682d-517e-4d23-b7fe-b1eeff683ab2@amd.com">
      <br>
      On 2024-01-09 15:05, Philip Yang wrote:
      <br>
      <blockquote type="cite">After svm range partial migrating to
        system memory, unmap to cleanup the
        <br>
        corresponding dma_addr vram domain flag, otherwise the future
        split will
        <br>
        get incorrect vram_pages and actual loc.
        <br>
        <br>
        After range spliting, set new range and old range actual_loc:
        <br>
        new range actual_loc is 0 if new-&gt;vram_pages is 0.
        <br>
        old range actual_loc is 0 if old-&gt;vram_pages -
        new-&gt;vram_pages == 0.
        <br>
        <br>
        new range takes svm_bo ref only if vram_pages not equal to 0.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |&nbsp; 3 ++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp;&nbsp;&nbsp; | 35
        +++++++++++++++---------
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +-
        <br>
        &nbsp; 3 files changed, 27 insertions(+), 14 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        <br>
        index f856901055d3..e85bcda29db6 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
        <br>
        @@ -839,6 +839,9 @@ int svm_migrate_vram_to_ram(struct svm_range
        *prange, struct mm_struct *mm,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;actual_loc = 0;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_vram_node_free(prange);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_dma_unmap(prange, start_mgr -
        prange-&gt;start,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_mgr - start_mgr + 1);
        <br>
      </blockquote>
      <br>
      If this is just for clearing the VRAM flags, then we should
      probably create another helper function for that. DMA unmapping
      system memory pages that didn't even move is not necessary here.
      <br>
      <br>
      Also, as Xiaogang pointed out, the migration may have missed some
      pages due to page locking race conditions. If you want this to
      give you accurate VRAM page counts, you should only clear the VRAM
      flags for pages that were actually migrated.
      <br>
    </blockquote>
    <p>ok, understand the concern now, if failed to migrate page to
      system memory to recover CPU page fault, app will crash, but
      prefetch may fail to migrate page to system memory, will send new
      patch, to clear the prange-&gt;dma_addr[gpuidx] VRAM flags while
      migrating the range to ram.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:21fb682d-517e-4d23-b7fe-b1eeff683ab2@amd.com">
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r &lt; 0 ? r : 0;
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index cc24f30f88fb..2202bdcde057 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -254,6 +254,10 @@ void svm_range_dma_unmap_dev(struct device
        *dev, dma_addr_t *dma_addr,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = offset; i &lt; offset + npages; i++) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dma_addr[i] &amp; SVM_RANGE_VRAM_DOMAIN) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr[i] = 0;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug_ratelimited(&quot;unmap 0x%llx\n&quot;, dma_addr[i]
        &gt;&gt; PAGE_SHIFT);
        <br>
        @@ -262,7 +266,8 @@ void svm_range_dma_unmap_dev(struct device
        *dev, dma_addr_t *dma_addr,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; }
        <br>
        &nbsp; -void svm_range_dma_unmap(struct svm_range *prange)
        <br>
        +void svm_range_dma_unmap(struct svm_range *prange, unsigned
        long offset,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long npages)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *dma_addr;
        <br>
        @@ -284,7 +289,7 @@ void svm_range_dma_unmap(struct svm_range
        *prange)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev = &amp;pdd-&gt;dev-&gt;adev-&gt;pdev-&gt;dev;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_dma_unmap_dev(dev, dma_addr, 0,
        prange-&gt;npages);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_dma_unmap_dev(dev, dma_addr, offset, npages);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; }
        <br>
        &nbsp; @@ -299,7 +304,7 @@ static void svm_range_free(struct
        svm_range *prange, bool do_unmap)
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_vram_node_free(prange);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (do_unmap)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_dma_unmap(prange);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_dma_unmap(prange, 0, prange-&gt;npages);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (do_unmap &amp;&amp; !p-&gt;xnack_enabled) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;unreserve prange 0x%p size: 0x%llx\n&quot;,
        prange, size);
        <br>
        @@ -362,7 +367,6 @@ svm_range *svm_range_new(struct
        svm_range_list *svms, uint64_t start,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;prange-&gt;child_list);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;prange-&gt;invalid, 0);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;validate_timestamp = 0;
        <br>
        -&nbsp;&nbsp;&nbsp; prange-&gt;vram_pages = 0;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;prange-&gt;migrate_mutex);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;prange-&gt;lock);
        <br>
        &nbsp; @@ -980,9 +984,14 @@ svm_range_split_pages(struct svm_range
        *new, struct svm_range *old,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -&nbsp;&nbsp;&nbsp; if (old-&gt;actual_loc)
        <br>
        +&nbsp;&nbsp;&nbsp; if (old-&gt;actual_loc &amp;&amp; new-&gt;vram_pages) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old-&gt;vram_pages -= new-&gt;vram_pages;
        <br>
        -
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;actual_loc = old-&gt;actual_loc;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!old-&gt;vram_pages)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; old-&gt;actual_loc = 0;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; pr_debug(&quot;new-&gt;vram_pages 0x%llx loc 0x%x
        old-&gt;vram_pages 0x%llx loc 0x%x\n&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;vram_pages, new-&gt;actual_loc,
        old-&gt;vram_pages, old-&gt;actual_loc);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; }
        <br>
        &nbsp; @@ -1002,13 +1011,14 @@ svm_range_split_nodes(struct svm_range
        *new, struct svm_range *old,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;offset = old-&gt;offset + npages;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; new-&gt;svm_bo = svm_range_bo_ref(old-&gt;svm_bo);
        <br>
        -&nbsp;&nbsp;&nbsp; new-&gt;ttm_res = old-&gt;ttm_res;
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp; spin_lock(&amp;new-&gt;svm_bo-&gt;list_lock);
        <br>
        -&nbsp;&nbsp;&nbsp; list_add(&amp;new-&gt;svm_bo_list,
        &amp;new-&gt;svm_bo-&gt;range_list);
        <br>
        -&nbsp;&nbsp;&nbsp; spin_unlock(&amp;new-&gt;svm_bo-&gt;list_lock);
        <br>
        +&nbsp;&nbsp;&nbsp; if (new-&gt;vram_pages) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;svm_bo = svm_range_bo_ref(old-&gt;svm_bo);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;ttm_res = old-&gt;ttm_res;
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;new-&gt;svm_bo-&gt;list_lock);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add(&amp;new-&gt;svm_bo_list,
        &amp;new-&gt;svm_bo-&gt;range_list);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;new-&gt;svm_bo-&gt;list_lock);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; }
        <br>
        &nbsp; @@ -1058,7 +1068,6 @@ svm_range_split_adjust(struct svm_range
        *new, struct svm_range *old,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;flags = old-&gt;flags;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;preferred_loc = old-&gt;preferred_loc;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;prefetch_loc = old-&gt;prefetch_loc;
        <br>
        -&nbsp;&nbsp;&nbsp; new-&gt;actual_loc = old-&gt;actual_loc;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;granularity = old-&gt;granularity;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;mapped_to_gpu = old-&gt;mapped_to_gpu;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(new-&gt;bitmap_access, old-&gt;bitmap_access,
        MAX_GPU_INSTANCE);
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        index 026863a0abcd..778f108911cd 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
        <br>
        @@ -182,7 +182,8 @@ void svm_range_add_list_work(struct
        svm_range_list *svms,
        <br>
        &nbsp; void schedule_deferred_list_work(struct svm_range_list *svms);
        <br>
        &nbsp; void svm_range_dma_unmap_dev(struct device *dev, dma_addr_t
        *dma_addr,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long offset, unsigned long npages);
        <br>
        -void svm_range_dma_unmap(struct svm_range *prange);
        <br>
        +void svm_range_dma_unmap(struct svm_range *prange, unsigned
        long offset,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long npages);
        <br>
        &nbsp; int svm_range_get_info(struct kfd_process *p, uint32_t
        *num_svm_ranges,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *svm_priv_data_size);
        <br>
        &nbsp; int kfd_criu_checkpoint_svm(struct kfd_process *p,
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>
