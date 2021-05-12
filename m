Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50148C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 18:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3BD561406
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 18:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BD561406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2FC76E05A;
	Wed, 12 May 2021 18:41:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37C1C6E05A
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 18:41:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+jRo9fz3ClQWnQaPoDo8KBWOpXp+2FPcbGOq/8I5sCD2kWnBmBngXvDnPcYob6wgVbY5gCoLUUmoC21n5wGX9Zz7OLxjzHWi7WvVGzZ8jKLyPvwb5v+YFTFu7V2NeisoRdyvUYrMBk6SosLLLQmh+uTCtT6nEk0fzoEDklPzAwPKfo7nHZPIG4XIHqDG9yZxlJQbFXbPkKfxEZRBmC72bB87WA0rX2QNFrWYBAT31zw+s5yxUWMNZxiRmkkujAjppd48XiGOHSqPLTqVxlfy2IADJSU4HHWTByOLNIM6cgDrgIrhS/r0ls0CK2GgzS5b9nKPGZrBTTDZbSQK0atIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2H3jvr0N6BAB/KnkK8MuujzMLWB2aguK5AS15aaeig=;
 b=Bnmf7rJ+HHrKAEp9b+2WoWTfrLUyEYp9PUqpjUspYRWwIZtHGqa6qxPTrpPLZFTVVb2c8p/FutGJb2jbqTMY15hWvkNkg6eFV6vPqah5mHgkRIyg4iTPcWp/a3Unw4Tac8B/ngREFWnhGT+7mkAxe8ZVVNsgDZKatRhLBkIQlL5OGttLT2wsAR4dGOA/I3zFwO/ROitIL8HZGvTGl+1Dn1iC4RxyRMzvYVwp6xJpOLMGJytXd+Btb2P80SB4NQdvY40vz6MmfnzEIMTY60QXTU2KLDFeNkaKtvAp1RLiDm9xFAoY3lfiaRVUCFoS9QL0oOnKs2PsgqXNEeh6sR6W3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2H3jvr0N6BAB/KnkK8MuujzMLWB2aguK5AS15aaeig=;
 b=gZT2SkWR2+bh1PC41pt8w1ydD64Xjp59I5qkHOUkN4OwlGKza5OF5NwOPXRqschh566k3d2dyEHFMyBCRAS6AEqIdX/YU2ryKzg4lPP7GUM0rOjSOPGZSl05hQn3qfzKhooj4tRbyPolYmPppT36MFephsGV4ZPV/2KuwUi6f2w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Wed, 12 May 2021 18:41:00 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4108.032; Wed, 12 May 2021
 18:41:00 +0000
Subject: Re: [PATCH] drm/amdgpu: flush TLB if valid PDE turns into PTE
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210512123451.25900-1-Philip.Yang@amd.com>
 <6fd68338-f7b9-5ffc-70e7-45920149bfcf@gmail.com>
 <3fa73d87-bd13-4f60-b737-a5a7e0293a1d@amd.com>
From: philip yang <yangp@amd.com>
Message-ID: <e21e7f2c-f9b9-cbab-47f3-0d521a40b825@amd.com>
Date: Wed, 12 May 2021 14:40:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <3fa73d87-bd13-4f60-b737-a5a7e0293a1d@amd.com>
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Wed, 12 May 2021 18:40:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea9ea87e-80b4-42d6-2a0f-08d915757cdc
X-MS-TrafficTypeDiagnostic: DM6PR12MB4943:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4943C0817AB7539D0727B8A3E6529@DM6PR12MB4943.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OVSk7NURgmdUVeAfhMAlaafguYi7dvfWls6zvokha6rO7tJPd0ZDaaCi/cxV+rJitBea2BfXpGWxJb64fuhOqjTsseyVcpsqWIHYFtKUxurt7q03JcIUYMIC/Rw2x+V0y03cWs7cfk2jNQh/cT5cSL7ewI+T3IVrwfRILi2ehJM2D4WrBhPKlH+QUXL2SsiHR77Zoh1GC0RPAMf0rzcUxxywoNwnpIIXLNP1/0BpBLh/spJk2OgZ4AVR2zpYCYQFllvedr4i1u1rpZG1msTi0UAMVu8GE8mqi6fLroWFJGoT8AkgP+CqciqUI8kukZdswdQzyNAjYzmnEPIySHZXilAuiQyigu4zo9OPavhB/dPBLT4+lSqWFHO69lja1GD5cNDaWR5GW3M8qxnBe5ImMSBhgTCG2i6hEK2XzKcXcvRjOShv4uTIXnpjQxsTHRmacoL0xtL/bLXZottNtJTlLBEeBx1/5daXdT06nWOdZE4aFRlsL3Wda1bqiNYp/33NnICVbuiXfCb/h+0Nntq5lN49y5Zl0B4a365qd9pZJoi33c+F6c12LnF+KblPKaZsKw9IRQAhjbBcsk9cbTgubTQI1Oanm9MREkV4DinoIW2QHcJDv+TMyM8dVjVwpkj6ghm1kDW7+znMGzKHQqeHQ62gLhBRYbe+fJEWYNbHYv3AqT6Z/OhlZsCDN4ouUWiCFdwrdmy8s5JC8a4i1lHRKr4to7TBP0S2FuNB0Xa3Thc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(53546011)(186003)(16526019)(2616005)(966005)(316002)(83380400001)(6486002)(8676002)(8936002)(66946007)(66556008)(66476007)(26005)(38100700002)(5660300002)(36756003)(31686004)(16576012)(956004)(110136005)(478600001)(166002)(31696002)(2906002)(66574015)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VERzd045Vm9GNFFiNHdyWTVqeit0YWdqZlZ6TDRxa010Z2MzL3BvSVpXMEdm?=
 =?utf-8?B?Vy9McDJXa1NXQjFjUzRCTXMzYmtZcjI3ZXdId2RxRTl3M3cwZkpQVmdiTDIw?=
 =?utf-8?B?L0x5ZnZQZGZsOHhHRHorU3U3ZTdqN2FhVU93VjU1OVdaUGlINUZ1UUNYUEhJ?=
 =?utf-8?B?am1EMVhQY0NkZk5PSHE1K3BOOEc1K0lWdXpIUWVJNGxUUVlCaTBPWUl1RXpW?=
 =?utf-8?B?RXVsZUpKK1U4UjR2blh4cVdRTjdHYnNsc1JCUzBWTU1MV1JHZ3JLNXBvMzZr?=
 =?utf-8?B?N3hsNStmWnJpMzdJelBGZ1RacjNITlZ1TDk3QTNCVVF2U2ovbWpKZGtBQlZv?=
 =?utf-8?B?ZTVLSzVYbzhMVyt6KzB2eFNPTWdBZ0xWTnVITFV1Q05OZFZhUk5YUG1NNjBs?=
 =?utf-8?B?MjlKeXVabituSHQzUUhDWmdiZG1QcWpIZVBKT2JBRmxSZFRUOGpweUtqeEpz?=
 =?utf-8?B?ZjhSdG5sZmdnbmNBTDJab1gvR0V6TWVZUzlXb1JVc1lYODZuVkl2dmx0S1pL?=
 =?utf-8?B?TVhUaTZIRFdWZ0VSVDhrQ3JNZ1dFY2dWakZONWswSXpqNGhEbWlycjFnN0xQ?=
 =?utf-8?B?cDBScnorMTNmTGhMck1qUFlJdkN5b1ZlckpZSjUwSnU4REdpaEtad2FnME51?=
 =?utf-8?B?RDhTTG1OWjhiNWpMZVRja3ZJQjlIb2QvUWs0aEQ1T0RDdWpydkkraVhuc3oz?=
 =?utf-8?B?Y01sSC9XTVZ4UlZOdUN6STJxdkpPTzNTNCtza05Rb2swWnhVTVVXbVd5VDlT?=
 =?utf-8?B?SVRHc2UxSzFTcm9HREVjN0FyVHBsY2xzaUNtNDdOT2Nva2FUQVE1VlpRTDJP?=
 =?utf-8?B?Nm50bXlrMmkrVWJMZ3laYTc5ZERscGdSdzNqMFJ0L1BTNzJNU20yL094NVVN?=
 =?utf-8?B?UVAwSXlwQ01UbEF1c0JxNXg2SEVKa0tjMlhxK09mTG1ONzNTNTBsL2xoQ2ZH?=
 =?utf-8?B?R2dlQjdkVEY1c3dIN01kVUk0MjZ1SnN6TXRVT1d1K2kxQlB2SlAvaEpVMTdN?=
 =?utf-8?B?TGYyUjQwWi9FM3hlYm9WQWgrSmd1MjhBSWIwVkZ4ZzJmZmlndllpOGdkNkJj?=
 =?utf-8?B?SmlzSWFPS0hyaW4yRk1zU1FXd2dvcllkTzdIclIrY2dlMFVDNTErNU1sTjVm?=
 =?utf-8?B?NjZ5Wm5GdnVIYUdMSCswR1o2SHNxQ1NoNjRER1NkYStDd0F2ZjlzakJ5Zjln?=
 =?utf-8?B?S3MwUXFFRytid3Q5Zy8wSkVuQVR3K1VCaFFFVzh1dTdXMGxiL0t4TFl2SCt6?=
 =?utf-8?B?ZWNSeU1wSDFBZXQxL3RmZ29HWE95bkdHbnp4WFFhb1g0U2Z2L2EydDNKNVkv?=
 =?utf-8?B?Y2k2aVB6WVo1VGNYaUgrTWtodVNOVWdBb2ErYVpEbHFJeWFkS3JNc0tDQy9P?=
 =?utf-8?B?L3RZTWxvOWlMUW04TmdRejQzdUtOUVdLUTRhTkRvbVVHektDbzkyYmZiOHEv?=
 =?utf-8?B?cXY4N1lFRkpYZXBaOUVOTHYvRjM0OC9PTHVadjdRTmFjakJOdU1UN0hHK2Y1?=
 =?utf-8?B?VjZqZnB1bjZrNWFhYzJBbS9xbERTWDFsTzEzbzd1YStRZGljMEZMeEIxeEVh?=
 =?utf-8?B?QXliWlZGb3dYL0NlNUlxOTE0cXAvam9JR29hV05OY044NTY5Y3kzRE5wa05X?=
 =?utf-8?B?c0RqSGtVNGtKSjBic09Zc0haYkdXWGVyV0ROODJCN2M0ODNhQXd2R0JFS295?=
 =?utf-8?B?TnVsdEtZTVlXUitiRXQwbFRnc1RPeG8zRGtCVDZqVVo4WmtZRFhHeHpNZlJI?=
 =?utf-8?Q?yvgY5bXZMq1uKSFb60cElsDaOaayFT6YxtMPma1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9ea87e-80b4-42d6-2a0f-08d915757cdc
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 18:41:00.4523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itvMUmd0I4ojul160NApAnQ1RN4VQ3HrXxKsjcHNE8KQi7NhYuaoKllXzQLZH/MH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4943
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
Content-Type: multipart/mixed; boundary="===============0890615376=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0890615376==
Content-Type: text/html; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-05-12 11:54 a.m., Felix
      Kuehling wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:3fa73d87-bd13-4f60-b737-a5a7e0293a1d@amd.com">
      <pre class="moz-quote-pre" wrap="">Am 2021-05-12 um 8:38 a.m. schrieb Christian König:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

Am 12.05.21 um 14:34 schrieb Philip Yang:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Mapping huge page, 2MB aligned address with 2MB size, uses PDE0 as PTE.
If previously valid PDE0, PDE0.V=1 and PDE0.P=0 turns into PTE, this
requires TLB flush, otherwise page table walker will not read updated
PDE0.

Change page table update mapping to return free_table flag to indicate
the previously valid PDE may have turned into a PTE if page table is
freed.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 +++++++++++------
&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |&nbsp; 2 +-
&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp;&nbsp; | 12 ++++++++++--
&nbsp; 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3dcdcc9ff522..27418f9407f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1457,7 +1457,7 @@ static void amdgpu_vm_fragment(struct
amdgpu_vm_update_params *params,
&nbsp;&nbsp; */
&nbsp; static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params
*params,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t start, uint64_t end,
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t dst, uint64_t flags)
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t dst, uint64_t flags, bool *free_table)
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
Please put that flag into the params structure instead.

Christian.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I agree. Christian, I think we also need to keep track of this for
graphics command submissions. amdgpu_cs_vm_handling needs get this flag
from amdgpu_vm_bo_update, and amdgpu_cs_submit needs to update
job-&gt;vm_needs_flushed based on this.
</pre>
    </blockquote>
    <p>amdgpu_vm_bo_update to pass NULL to ignore the free_table return
      flag.</p>
    <p>This new flag only used by SVM APIs. Old KFD and graphics command
      submission path is not changed.</p>
    <p>Thanks,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:3fa73d87-bd13-4f60-b737-a5a7e0293a1d@amd.com">
      <pre class="moz-quote-pre" wrap="">
Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">&nbsp; {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = params-&gt;adev;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_pt_cursor cursor;
@@ -1583,6 +1583,8 @@ static int amdgpu_vm_update_ptes(struct
amdgpu_vm_update_params *params,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (cursor.pfn &lt; frag_start) {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_free_pts(adev, params-&gt;vm, &amp;cursor);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_next(adev, &amp;cursor);
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (free_table)
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *free_table = true;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (frag &gt;= shift) {
@@ -1610,6 +1612,7 @@ static int amdgpu_vm_update_ptes(struct
amdgpu_vm_update_params *params,
&nbsp;&nbsp; * @nodes: array of drm_mm_nodes with the MC addresses
&nbsp;&nbsp; * @pages_addr: DMA addresses to use for mapping
&nbsp;&nbsp; * @fence: optional resulting fence
+ * @free_table: return true if page table is freed
&nbsp;&nbsp; *
&nbsp;&nbsp; * Fill in the page table entries between @start and @last.
&nbsp;&nbsp; *
@@ -1624,7 +1627,8 @@ int amdgpu_vm_bo_update_mapping(struct
amdgpu_device *adev,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags, uint64_t offset,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_mm_node *nodes,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *pages_addr,
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence)
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence,
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool *free_table)
&nbsp; {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_update_params params;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_sync_mode sync_mode;
@@ -1721,7 +1725,8 @@ int amdgpu_vm_bo_update_mapping(struct
amdgpu_device *adev,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp = start + num_entries;
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_update_ptes(&amp;params, start, tmp, addr, flags);
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_update_ptes(&amp;params, start, tmp, addr, flags,
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free_table);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unlock;
&nbsp; @@ -1879,7 +1884,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device
*adev, struct amdgpu_bo_va *bo_va,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resv, mapping-&gt;start,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping-&gt;last, update_flags,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping-&gt;offset, nodes,
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_addr, last_update);
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pages_addr, last_update, NULL);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
@@ -2090,7 +2095,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device
*adev,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_bo_update_mapping(adev, adev, vm, false, false,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resv, mapping-&gt;start,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping-&gt;last, init_pte_value,
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, NULL, NULL, &amp;f);
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, NULL, NULL, &amp;f, NULL);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_free_mapping(adev, vm, mapping, f);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(f);
@@ -3428,7 +3433,7 @@ bool amdgpu_vm_handle_fault(struct
amdgpu_device *adev, u32 pasid,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_bo_update_mapping(adev, adev, vm, true, false,
NULL, addr,
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr, flags, value, NULL, NULL,
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr, flags, value, NULL, NULL, NULL,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unlock;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index ea60ec122b51..f61c20b70b79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -404,7 +404,7 @@ int amdgpu_vm_bo_update_mapping(struct
amdgpu_device *adev,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags, uint64_t offset,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_mm_node *nodes,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *pages_addr,
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence);
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fence, bool *free_table);
&nbsp; int amdgpu_vm_bo_update(struct amdgpu_device *adev,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va *bo_va,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool clear);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b665e9ff77e3..4f28052d44bf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1084,7 +1084,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device
*adev, struct amdgpu_vm *vm,
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_vm_bo_update_mapping(adev, adev, vm, false,
true, NULL,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start, last, init_pte_value, 0,
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, NULL, fence);
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, NULL, fence, NULL);
&nbsp; }
&nbsp; &nbsp; static int
@@ -1137,12 +1137,15 @@ svm_range_map_to_gpu(struct amdgpu_device
*adev, struct amdgpu_vm *vm,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *bo_adev, struct dma_fence **fence)
&nbsp; {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va bo_va;
+&nbsp;&nbsp;&nbsp; bool free_table = false;
+&nbsp;&nbsp;&nbsp; struct kfd_process *p;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t pte_flags;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r = 0;
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svms 0x%p [0x%lx 0x%lx]\n&quot;, prange-&gt;svms,
prange-&gt;start,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;last);
&nbsp; +&nbsp;&nbsp;&nbsp; p = container_of(prange-&gt;svms, struct kfd_process, svms);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (prange-&gt;svm_bo &amp;&amp; prange-&gt;ttm_res) {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo_va.is_xgmi = amdgpu_xgmi_same_hive(adev, bo_adev);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;mapping.bo_va = &amp;bo_va;
@@ -1159,7 +1162,8 @@ svm_range_map_to_gpu(struct amdgpu_device
*adev, struct amdgpu_vm *vm,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;mapping.offset,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;ttm_res ?
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;ttm_res-&gt;mm_node : NULL,
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr, &amp;vm-&gt;last_update);
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr, &amp;vm-&gt;last_update,
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;free_table);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;failed %d to map to gpu 0x%lx\n&quot;, r, prange-&gt;start);
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
@@ -1175,6 +1179,10 @@ svm_range_map_to_gpu(struct amdgpu_device
*adev, struct amdgpu_vm *vm,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fence)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *fence = dma_fence_get(vm-&gt;last_update);
&nbsp; +&nbsp;&nbsp;&nbsp; if (free_table)
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_flush_gpu_tlb_pasid((struct kgd_dev *)adev,
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;pasid);
+
&nbsp; out:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange-&gt;mapping.bo_va = NULL;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--===============0890615376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0890615376==--
