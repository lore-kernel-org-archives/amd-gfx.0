Return-Path: <SRS0=biE/=M3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_ONLY,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A740FC4338F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 15:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6718660F58
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 15:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6718660F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCB5A6EAAE;
	Wed,  4 Aug 2021 15:13:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58CBD88843
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Aug 2021 15:11:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FF2dVn699fh97+BEgS3WRByY6KK8NKamAC3gLSpvCcftjuxo6lWJg0gKHNAoQiQokwVtnA8CCXNQ6aajz7ZS9OD9gY6+E+TmNLgh1hPJF3n2vIJ/KlPniwHLqlPswRzIrzDmpLFIkOAG2V1Ha3gP84hLRdf1iZaqiNOblsNVcoaAQZ5XPbR6qtFgxWIfnrEP86GTe07I7Msq+/oB8WiKq7GPAQ1V0oQ34sjkVSZDi7O+xaV3b9miTx6YemQd65ZDQpENxUvlV7/4NwFBpQqL1Q1YV9ApmNzN3zTj/qgPumyJ4D9Do5jka7AQCNv0djVSfI5RWqnNsXxPdcGvDxZQxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8q5MELcEDu3KLzIakUHhilxFm/j6rO3xPEXPL0Jy8E=;
 b=NxxnW/Gx3XB09oa1yzzQ/pmmb7zptmsLBnSz0/KTMZHCkK397mtivMAyeNsZGPxOPKVdjv9lTivyULmLdnzK8Bfjstyq28K2zZ9FF3380A0xrIyBTjqqAjohPSpTgfJU7B5XF6exGMlmKyEq0P41/igeawttzP5sKgnnMh6Nbo+VKZYMBLl9frx+wWOiqZ2cXZAN+dLhZsEVjTBirhupkDqYaOwSJtm40zM/JtEo/cf60ZXmRh6Y45/y9prerQR+bZKZzCyxOV0xudRgs4arFmwdVgzFI6Hk3C59DGPFTlbRnXa+dADfgyjGkmriTvp6ZtnekGw2/hiebhrCiCB8Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8q5MELcEDu3KLzIakUHhilxFm/j6rO3xPEXPL0Jy8E=;
 b=BzvW75uQttMn1ivyPhWKP6KPNkCCU4JQQ+DHQpkSo/l1IHuRgxfe0XBtdDKFpAK/pGF00GpBSLei7Q1GNGg6sZsXsTwKZhXAZFkAzLrHNdFeYUvQLuZSRSS6IMdLQB4S7q+p1u/JQPQQqzdEU25lLGwOpTShhmRXs7Vo8yqMkpQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB5357.namprd12.prod.outlook.com (2603:10b6:5:39b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Wed, 4 Aug
 2021 15:11:50 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5987:7323:7c90:a427]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::5987:7323:7c90:a427%9]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 15:11:50 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix vm free pts race when process exiting
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210802223308.13076-1-Philip.Yang@amd.com>
 <920b7b04-8f8d-a57a-724e-811a4c7e581c@gmail.com>
From: philip yang <yangp@amd.com>
Message-ID: <2c47c381-0c53-47ff-b6a6-75de23d7ff89@amd.com>
Date: Wed, 4 Aug 2021 11:11:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <920b7b04-8f8d-a57a-724e-811a4c7e581c@gmail.com>
Content-Type: text/html; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0105.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::14) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YT1PR01CA0105.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.17 via Frontend Transport; Wed, 4 Aug 2021 15:11:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9c91551-6fa3-4934-914c-08d9575a2f91
X-MS-TrafficTypeDiagnostic: DM4PR12MB5357:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5357CB8E4D5179553B4AEF94E6F19@DM4PR12MB5357.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aASxP8k8K5eYyy48m4fSSj+c0/yX/h+71SO6g6VNo7mELoXojsjr0GHhUvIJr8fRLk79+tXanHeufPy/FlCdH1QX5oDHn4oywW8Gs+OOqIeCdzVyhsQ0fx7GgfZDA5e51POFWNME60GT6MbhHVeQ2CvmXpBJfiHNAeBFERDcGW0k3vzydusN9LI88F9+ee3QDnNmbAgDSeD5Nrwxebpmjk5nycRC5aYYycdeFyCpoYyvC0O1ywV5pQ8aXENeHYzkaeLUWD+FfX36VveNG9fEy12Nhk3RoiZuP2iTo99S7/B3JC1kqMXi/brBtZLux/ZwS88vd5N6sJBxq00jGe0eFHd5L6qetjMCLDMeAVhgexdE1KynjJZ1KutonJ72/V8fk06OZHsFqlOP0nyynjgY268dDRPGS1e1dt+36aOw6WOjXv3qYZd0hivHHbaHqpETJs+9Tl/Te/llOwnN0QyMXwkTQUcXp7Oyw6VhfXtgijrTu0rCKV6OyDZbCIWVZb2g2iRk80/KaSd5IcVu7Bha/mJztiC4snhmMphFpkn7YA6bg3eUtdNdaRyDDyKkbrf01eNN9ZcuG51qYnH09YJOXbT8wwmdtvu97gGHgULB1UjoUB9M8fLnHw9hkw15jh2ezyHXfexyci23nrZqy53//7DKqvgnMM4sCq0+bscZ5TwRzRLLAxvet3H10ze3DQwzJvi5fVfiswfV9rmHEbfy7IiL5jHaF/LLGj22R1p9zbA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(6486002)(26005)(53546011)(8676002)(8936002)(2906002)(16576012)(31696002)(186003)(316002)(110136005)(66946007)(83380400001)(38100700002)(66476007)(66556008)(66574015)(956004)(2616005)(36756003)(31686004)(5660300002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjZNMXJmU210ek1vQitEOEtyMEw1QXFLamJuZ285aTlxWlJxdnY1cXFwTnJP?=
 =?utf-8?B?VmFmRXk0R2ZEOUVDWlFVekZIeFR6a2FRVzYwTC9HeldRbFdDcXpEOTBralZO?=
 =?utf-8?B?QncwSit4NDBiM0Fvd1R3QkY4Mlg1R0QwdXhaU0c5TDRhN2x4eWovNXk1OGxx?=
 =?utf-8?B?MXl2UzZvWkNoZzRkRHJSTjlPVEpTbU9qS0RjQ1didVlKV1ZzK2NMS1duUSth?=
 =?utf-8?B?cVZYTnFhZ0gvekxkWTVGZlhiWkhyN1BpSEdtcXNoZ0gweUt2UHNRckN3WUxv?=
 =?utf-8?B?WnV4TmVxZ0plS09lbTFzYkp2cGR1TUxIU1p0VGpqZmdoYVR5RUtUc3BtZHRK?=
 =?utf-8?B?YVdUaU94S1RyZ0kyVFN4czhOb0xOSlpnNWxXMk5kSE1XQnozeG5JSjhEck43?=
 =?utf-8?B?ZmI5bEgzU2crbGdXQ1lsam52alRrTFc5SzR0STZNbFl6TjhNbDQ0RHZyejls?=
 =?utf-8?B?YXl6QjkyT2k4UTRaU2N4Tk9rcGxiS2tyVm9kTnUvYzVLNUVPaERwdCthcWtV?=
 =?utf-8?B?RGJxeVRaOVV5Q2VJWXhsY2ltTk9QRzlxSElsSXV4R21zTW1OaGV6VDFqbmNk?=
 =?utf-8?B?cVVVQUtTLysvRitYQ2IrZFVnUG11M29oUUNNeWpMSGNyOGJIcWR2aVlCLzRw?=
 =?utf-8?B?NDNyaTR6elhFZDZyY0EwcFNSY0FCQy9NVitQdkpyeHVmODBFTFQ5cFVqd0VM?=
 =?utf-8?B?RFRXamU5c0JJR2xJMzI5S1M3Nm9xc09wRi9yd1YzSGdmejRhUjhadEJVdGdi?=
 =?utf-8?B?REVzbm8ycW0yTDRqTE5hL2JyMXRBb1Y0Sm55aXdDcC8rZ3hRTjhrRUZ4QTgy?=
 =?utf-8?B?R3V3Ymk5U0NYSkF6TkJNRHhBMkZ6QThGb2YrR3ZiL0ZJYTc5dDk1NGU5Sy9w?=
 =?utf-8?B?L0YvTjdkRTF6WDBMaGtmaExhbjlvYVpFczVvZGZWMTdXRnU0aGRuVTBTc05S?=
 =?utf-8?B?ZXBkNXJrUW10OEJyVTFvRkZpYTNhZ0lta1JtUkxxT2MzeXUwMjg1RittRmc1?=
 =?utf-8?B?dDFML2FuUVR4ZEM5MUVwd3RXQTlJVysvdHQ2SlMzWmUrNFNyMlA0NVFiS2NY?=
 =?utf-8?B?Um1YQVRXUWRrWm41SzN4MUVqN0RsWFhLZmRiM0Z2dlBhSTNrSjZ5dTBVRUlC?=
 =?utf-8?B?RloyZWptdW15VHdzQTVBMVV0VWt3VlhaTjdVTVcrdGlLdlJ5NTRGS0RrZDdo?=
 =?utf-8?B?NVQyblM3R2xmbDRPSElOOU43dmpwTS9kWmViVXhqc0Q4OE5uZStNc1Y1dGts?=
 =?utf-8?B?VktFd0FONEdjQUF3QlhRSXhpMW50VnlqTmJtaUprS0dmZkFjUkVWMVE1VjJp?=
 =?utf-8?B?eFBmdUZ2VWJjK2ordzhhSnRoYWJJanhwVXJuUDZIY0JXcGorRE9LakpuQ3Y0?=
 =?utf-8?B?NkVYTUExSjUvSElCZzFidzlwdlhBVlRLUnBWci9ZMXFPd3MyNk42K2FHVnZF?=
 =?utf-8?B?VDdBSXRhQ1hCSHJnTDJKb1Y0OHZtaVVLaGxhYVFXVXVWQXFKWjNOakhEbUFX?=
 =?utf-8?B?SXN6dWVSWjhtNUxYcnR1NFBsMjQ4Y3NMNkplRVVDKzdSR2lYZG9uSWhodzEy?=
 =?utf-8?B?d3dQRndXeXJrVTZrSm1aQUJOaDhCZGZ1TVREcC9rU1BxK1pKSVZ6QW9TNkt6?=
 =?utf-8?B?cTZrZVFBMTZyemtUTEVXOC83eExtTGp4Y3RTVURGaWpZYmJmelQ3cEhmRG5I?=
 =?utf-8?B?bnh1WmwralFTdVVoVS9Wc1pYNVR2UXoxcnRkS2hjbkFXR2grVktKMnBrV2ph?=
 =?utf-8?Q?MdGoWtDCHKldmf7MuYffqNkE7DZWOTBQUHwR6qt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c91551-6fa3-4934-914c-08d9575a2f91
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 15:11:50.7204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nzkd9/i8wgefcZsdVUMybWK4rgYds1dqoEKz09qMtO6zlKuFsGMUc1GanrfqWurc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5357
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
    <div class="moz-cite-prefix">On 2021-08-04 5:01 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:920b7b04-8f8d-a57a-724e-811a4c7e581c@gmail.com">Am
      03.08.21 um 00:33 schrieb Philip Yang:
      <br>
      <blockquote type="cite">Take vm-&gt;invalidated_lock spinlock to
        remove vm pd and pt bos, to avoid
        <br>
        link list corruption with crash backtrace:
        <br>
        <br>
        [ 2290.505111] list_del corruption. next-&gt;prev should be
        <br>
        &nbsp; ffff9b2514ec0018, but was 4e03280211010f04
        <br>
        [ 2290.505154] kernel BUG at lib/list_debug.c:56!
        <br>
        [ 2290.505176] invalid opcode: 0000 [#1] SMP NOPTI
        <br>
        [ 2290.505254] Workqueue: events delayed_fput
        <br>
        [ 2290.505271] RIP: 0010:__list_del_entry_valid.cold.1+0x20/0x4c
        <br>
        [ 2290.505513] Call Trace:
        <br>
        [ 2290.505623]&nbsp; amdgpu_vm_free_table+0x26/0x80 [amdgpu]
        <br>
        [ 2290.505705]&nbsp; amdgpu_vm_free_pts+0x7a/0xf0 [amdgpu]
        <br>
        [ 2290.505786]&nbsp; amdgpu_vm_fini+0x1f0/0x440 [amdgpu]
        <br>
        [ 2290.505864]&nbsp; amdgpu_driver_postclose_kms+0x172/0x290 [amdgpu]
        <br>
        [ 2290.505893]&nbsp; drm_file_free.part.10+0x1d4/0x270 [drm]
        <br>
        [ 2290.505916]&nbsp; drm_release+0xa9/0xe0 [drm]
        <br>
        [ 2290.505930]&nbsp; __fput+0xb7/0x230
        <br>
        [ 2290.505942]&nbsp; delayed_fput+0x1c/0x30
        <br>
        [ 2290.505957]&nbsp; process_one_work+0x1a7/0x360
        <br>
        [ 2290.505971]&nbsp; worker_thread+0x30/0x390
        <br>
        [ 2290.505985]&nbsp; ? create_worker+0x1a0/0x1a0
        <br>
        [ 2290.505999]&nbsp; kthread+0x112/0x130
        <br>
        [ 2290.506011]&nbsp; ? kthread_flush_work_fn+0x10/0x10
        <br>
        [ 2290.506027]&nbsp; ret_from_fork+0x22/0x40
        <br>
      </blockquote>
      <br>
      Wow, well this is a big NAK.
      <br>
      <br>
      The page tables should never ever be on the invalidation list or
      otherwise we would try to point PTEs to them which is a huge
      security issue.
      <br>
      <br>
      Taking the lock just workaround that. Can you investigate how it
      happens that a page table ends up on that list?
      <br>
    </blockquote>
    <p>I will be off 3 days, I can investigate this further next Monday.
      From debug, amdgpu_vm_bo_invalidate is called many times. The
      background: app has 8 processes, running on 8 GPUs, 64 VMs, VRAM
      usage is around 85% from rocm-info, 1/5 chance this happens
      (kernel BUG, server die) after application segmentation fault
      crash (another app issue). It is new issue on rocm release 4.3,
      never happened before on rocm 4.1 (no app crash on 4.1 either).
      kernel version is 4.18 on CentOS.<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:920b7b04-8f8d-a57a-724e-811a4c7e581c@gmail.com">
      <br>
      Thanks in advance,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 ++
        <br>
        &nbsp; 1 file changed, 2 insertions(+)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        <br>
        index 2a88ed5d983b..5c4c355e7d6b 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
        <br>
        @@ -1045,7 +1045,9 @@ static void amdgpu_vm_free_table(struct
        amdgpu_vm_bo_base *entry)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; shadow = amdgpu_bo_shadowed(entry-&gt;bo);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;bo-&gt;vm_bo = NULL;
        <br>
        +&nbsp;&nbsp;&nbsp; spin_lock(&amp;entry-&gt;vm-&gt;invalidated_lock);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del(&amp;entry-&gt;vm_status);
        <br>
        +&nbsp;&nbsp;&nbsp; spin_unlock(&amp;entry-&gt;vm-&gt;invalidated_lock);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(&amp;shadow);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(&amp;entry-&gt;bo);
        <br>
        &nbsp; }
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
