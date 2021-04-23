Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E5BC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:00:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 455DE61176
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 02:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455DE61176
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D3726E04E;
	Fri, 23 Apr 2021 02:00:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36D076E04E
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 02:00:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsZDJhwfHaYV+KaON7YWAOFpwDvqszI6GFGoYcfIMKLSgyBOuundDoNx5BplPB0G9RotO1QzNibafufsxKsiuXyGftD53AEL7rdEJojbYatKBYcoX/IJRqzLPtRb5+E8O32fzk/cugErIbntHjmLai3ZGsqFLNltGyzLHYi0pOaJ9hqysj6leRG4FZuz/dxBU+Tu0Bx6JWK1CqHwABZm6AOjmhK9Ts8rjHpYB4eiBK3aUOu1Z2Q8Z4wxLZnMqbWDPqLeN4+pEg92GHtMuM8uOUbkqNE1oBw91wlVrpAUm4J5BrVb/dL+jo/M+B1K9zbbDL36hh3PeMWmaW7zRnzQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS2XI0Q0IyzSPRj0dVaidX9J7qJ7ovtjTd4yhdjZluc=;
 b=eiUSe4x5vHv769dBKrcZZ2CDUgQGjI8H0oIbZRFoADAJR5QCfkyrjS7ovI2tw3TeV+ce78xVNAYFjneiFxnnlaX6LvQh6f6z3SpRIcw3G2EFCnHTKnbuu5TZu6nSBGmcOF4HLHjARp2Ib/cCNQh77U1X65TR7d4R3WVlltfr5dhHbrzI9wOcUq6PCcO6xigSVCzWUmTjmG++RHYY+F3xZQGdq/xhP14cPqhj0/VDl8pr36BqNujQbY6SHwIzquZ491EdGNb9RizlqXCm//1yCHL3rdFAqqEcp7ShucADSmq8Qrqht8f23VMlAjtEEwDuw1EKPgK8c+dnB9sAYVHj2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS2XI0Q0IyzSPRj0dVaidX9J7qJ7ovtjTd4yhdjZluc=;
 b=VfYxIXFx/t/r1SCbnoPyhoZoFISY1n0iUcTXEcFm3UvuQD6MrC5n3phra9NsLTlyyVmW0gifYOTsDhcXZNRQR+xM2lkgJ1ThXMzvvUSUAoj3iZlZPpjVgLZMHszh50SxOoWDj61l+A6E6FXULBU44RmppHc8lornnx7tiaJOvc4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB3403.namprd12.prod.outlook.com (2603:10b6:5:11d::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.24; Fri, 23 Apr 2021 02:00:31 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4065.020; Fri, 23 Apr 2021
 02:00:31 +0000
Subject: Re: [PATCH 4/6] drm/amdgpu: address remove from fault filter
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210420202122.4701-1-Philip.Yang@amd.com>
 <20210420202122.4701-4-Philip.Yang@amd.com>
 <6d4d7698-381a-f1d7-2eed-b71047ddc70d@gmail.com>
From: philip yang <yangp@amd.com>
Message-ID: <7b1bd6f1-dd07-560a-3737-638efa57ee02@amd.com>
Date: Thu, 22 Apr 2021 22:00:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <6d4d7698-381a-f1d7-2eed-b71047ddc70d@gmail.com>
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::48) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.38] (165.204.55.251) by
 YTOPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21 via Frontend
 Transport; Fri, 23 Apr 2021 02:00:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b511e25-ffa1-470a-5f6f-08d905fb92f4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3403:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB34033E763722277F92F7137AE6459@DM6PR12MB3403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+XTef8chWAL3MdSOpngLFp3gxNoqBs0KXSU/TusQVDxTAYH9CBkulYoEw8SXYkEyZcH858igJNB5cwbVBp0iuTIAn3QdwDvDOJg3ScEz7sjS9j0h/L0cSgoxhoXpG/Vnio0QcXXJHd93k1EwudmksIe+4eonIdblnaXU9UobFk77pQpnkUToG2BToENS+ZpvFDmSzTVrq/d1iG1VCcwQC5PTX3L93uWryYkET0PRcr+kc9TSticwvg8goL7D2GjcoXySpxCMY2DTwNcOhr8HtEnxg+8V71SHOT8sLpPrOru+52dNaNv47qzge/VrSN+FDpnDjZ975Xlm3Qr3RBmIZtQn7uOvTx4l2DOQc9aDNkoHun+Upah7h4ezSUhFHW15IhIBX7Ep7go/rBMMz1aEw27Nibnz6ag96CBe0Vr+k1RQhk19b2bWVbiU6PdHiN1lssv4XppqAUgwrU+Lb6nYd+MD5ayAOYaFsDeKIAoZ2eIUdCLip3Pb9d0bVHu63rTcOeDhkt280IG/oZ1XmkS2eUWWykUYJTwPE1Tg4p1nUy4jMDBNGQXZhiwRCQfb+8m5/a8gj0VDgGi+dc6vGEUhJg33bhAqqnrVcSmMJICO5KXZ4S/NwHNHd/rkwXBhdvzeW73Uf4kC9aYe08IeLF3fj4r8jqpMJ8Vo7bo6Z/iahJfFfZwI7++6Shoc8kXul70
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(8936002)(66476007)(38100700002)(16526019)(31686004)(66574015)(6486002)(478600001)(5660300002)(186003)(31696002)(2906002)(16576012)(8676002)(316002)(66556008)(36756003)(110136005)(26005)(83380400001)(956004)(53546011)(2616005)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UTZUeGc5dURPVHp1dlVIMmk0N0htN0dnWlFJUlFFeklnZW80T29OZTdsYWph?=
 =?utf-8?B?SjNTRitQaDdWUHpESEpOUisyQnFKZ0xCWllrL1IxcXhxUEVLMTZQZEZ1MVl6?=
 =?utf-8?B?ZHhWR1R3RW9BeFRMVFNYUEorbTlXUGR2Wk15ZzdSOEdmUE1ha2c3bmhnWTYr?=
 =?utf-8?B?NE84VEg4V2cybGNyQXZLeU05d01oMG9NcWdiNElFZ2xmRTNtYXBmVjV3S0Fq?=
 =?utf-8?B?QUhrZ3QxZ1J2VEpPTzFLVThKdTU3TytWcE1PRTVVYmFuL1R0OURIRnVoWXU3?=
 =?utf-8?B?Z2hjS1pKclIxeU9icFZZanZnRndjemRGdlEyUHFybFJVMmVLbzB6QmZxRC9D?=
 =?utf-8?B?MWNQK0trczJOVlZvTTdRc2swL00yaXBhQ2gzMUYzUFdtSU5WZjFXWEJxMzMy?=
 =?utf-8?B?YUJGZjZrRXBFd1N0aUc5U3gwa1VtbkcwYXpUQUNjZFpTanM0dHBsa3ZmM0hs?=
 =?utf-8?B?MnovaHJ4RmZVZi9iUld2MCtsbEkxZER6RmsrZjkrRU1VMTJ6TUUwSzZwUFZ0?=
 =?utf-8?B?QThOSW1SczZUTEtLckI0MEcyc2pKL2I0QnhVekpsL2NNWmJJaWJTS2dlNWxo?=
 =?utf-8?B?WWN3dTVvcFdnOGY5NFBYcis0QUR3U0d4OVFlVmVPdVdmdFRDeVhUNVVKQmlp?=
 =?utf-8?B?dzQyL0pKR0o3RTFleS9XeGUwMFVuT3pxTE9kSjBjNnVKK1dqRWpuaXRqRlJ6?=
 =?utf-8?B?NHhoVWhQSGVVRHY4U0lxazg1cTZvaXlPUHB2MVlzQzAraGJnaUNDN0ZCSzMv?=
 =?utf-8?B?cjE3bGtOcTU3ZHVPNVZhaEQ5M1NZSEZkVWRjNUlKa0Zia0VDb1BXN3ZJTno0?=
 =?utf-8?B?dUt2QlUwOVo1aEpPZGlLZGU4SjZxTHpKQnI1b1h1R0tlYTBZcjB2a2xlS1o4?=
 =?utf-8?B?bEFhTTJoR00rOGtsT1ZRbUorbUk5dnFZaitBVTZ3YXVZcFc5WUxzS1dGc2tk?=
 =?utf-8?B?aDZEbmJabnVFRExGWXBRN3BNczBZK1FGeHdrdXVEZUxXWUZVY3A2bGxJRXY5?=
 =?utf-8?B?UmJTaS9WOVYvY3BKRHNaSDhwN1ovdTR4US9CVlo3bXg0TmxUYmVKb3c3VDhJ?=
 =?utf-8?B?WW1aQ1dsWGFGeXVPUFU3NGVid3ZZZkt4NmV5UGxTTzJiOXFBdWZRUjVqMS9L?=
 =?utf-8?B?L3RobnY2YmxKVzhtek9ZMUEwMG5zWFpQVkE4SXNTNDIxenhJNFpyYWhnbWtR?=
 =?utf-8?B?eXJab1BLL2t1a3FsK21melhLMGp1RlFZSEFPTytBQjh0aE5zb1F0OHEvQXRp?=
 =?utf-8?B?dDBZL25uZkNWbVlVSGoxNEI5dHhSNU9mK0IrOHM5TWhGRGQyZHR2UllGSm10?=
 =?utf-8?B?Skl6K2c5YjNNbFFrWExsMGVGWGF4Y1VtWnp1b0dmU3Q4UnVOZ0lmdXFuWEdP?=
 =?utf-8?B?UEF3MmRkNmszdUVhbXNlVHh3d0NwbWhHU21QZ3g3WG41c29RRVBjdDlQMGZP?=
 =?utf-8?B?OXBkaHhZeU5GSE40KzFQMEE4T2RXUkxvb29jNy9HSmNmeEg0QURhZThtY201?=
 =?utf-8?B?VDhjMFNEM1d0cjN0OWhMQnZzVkFENFJvWXMxS3hTMW5iVGxJZ3ZMMEN4ZXdh?=
 =?utf-8?B?eUxleStqQ21jdmJncHVFKzBETmNUY1dCbmpiNnZzMkVDMjVaM09TaitrdVo5?=
 =?utf-8?B?NnJiamRTQWNKQytVTEIwK2Y0bVlabDNsMHB3S1VDRkErbWVDbmhMS2lwVHNJ?=
 =?utf-8?B?em9hM3dUYXZQMlBDTTczZTM5V2YybEpRVXFzcU8xajB4ajVYYlA1eGMvYmVJ?=
 =?utf-8?Q?bbBb/3bGMWa9u+upZTCC0n3HPnKqoS1hQpHA9Nb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b511e25-ffa1-470a-5f6f-08d905fb92f4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 02:00:31.0974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qvb71RdeEHwjVrqZqxbBx9OP67oG1u6VlTAiMswAu2Q5nBTv4v69ZV13qJbg2s7h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3403
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
Content-Type: multipart/mixed; boundary="===============1901979817=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1901979817==
Content-Type: text/html; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-04-21 3:22 a.m., Christian
      König wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:6d4d7698-381a-f1d7-2eed-b71047ddc70d@gmail.com">Am
      20.04.21 um 22:21 schrieb Philip Yang:
      <br>
      <blockquote type="cite">Add interface to remove address from fault
        filter ring by resetting
        <br>
        fault ring entry of the fault address timestamp to 0, then
        future vm
        <br>
        fault on the address will be processed to recover.
        <br>
        <br>
        Check fault address from fault ring, add address into fault ring
        and
        <br>
        remove address from fault ring are serialized in same interrupt
        deferred
        <br>
        work, don't have race condition.
        <br>
      </blockquote>
      <br>
      That might not work on Vega20.
      <br>
      <br>
      We call amdgpu_gmc_filter_faults() from the the IH while the fault
      handling id done from the delegated IH processing.
      <br>
    </blockquote>
    Added spinlock for VG20.<br>
    <blockquote type="cite" cite="mid:6d4d7698-381a-f1d7-2eed-b71047ddc70d@gmail.com">
      <br>
      More comments below.
      <br>
      <br>
      <blockquote type="cite">Signed-off-by: Philip Yang
        <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 24
        ++++++++++++++++++++++++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |&nbsp; 2 ++
        <br>
        &nbsp; 2 files changed, 26 insertions(+)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
        <br>
        index c39ed9eb0987..338e45fa66cb 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
        <br>
        @@ -387,6 +387,30 @@ bool amdgpu_gmc_filter_faults(struct
        amdgpu_device *adev, uint64_t addr,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;
        <br>
        &nbsp; }
        <br>
        &nbsp; +/**
        <br>
        + * amdgpu_gmc_filter_faults_remove - remove address from VM
        faults filter
        <br>
        + *
        <br>
        + * @adev: amdgpu device structure
        <br>
        + * @addr: address of the VM fault
        <br>
        + * @pasid: PASID of the process causing the fault
        <br>
        + *
        <br>
        + * Remove the address from fault filter, then future vm fault
        on this address
        <br>
        + * will pass to retry fault handler to recover.
        <br>
        + */
        <br>
        +void amdgpu_gmc_filter_faults_remove(struct amdgpu_device
        *adev, uint64_t addr,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t pasid)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct amdgpu_gmc *gmc = &amp;adev-&gt;gmc;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; uint64_t key = addr &lt;&lt; 4 | pasid;
        <br>
      </blockquote>
      <br>
      We should probably have a function for this now.
      <br>
    </blockquote>
    add function fault_key in v2.<br>
    <blockquote type="cite" cite="mid:6d4d7698-381a-f1d7-2eed-b71047ddc70d@gmail.com">
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp; struct amdgpu_gmc_fault *fault;
        <br>
        +&nbsp;&nbsp;&nbsp; uint32_t hash;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; hash = hash_64(key, AMDGPU_GMC_FAULT_HASH_ORDER);
        <br>
        +&nbsp;&nbsp;&nbsp; fault =
        &amp;gmc-&gt;fault_ring[gmc-&gt;fault_hash[hash].idx];
        <br>
        +&nbsp;&nbsp;&nbsp; fault-&gt;timestamp = 0;
        <br>
      </blockquote>
      <br>
      There is no guarantee that the ring entry you found for the fault
      is the one for this address.
      <br>
      <br>
      After all that is just an 8 bit hash for a 64bit values :)
      <br>
      <br>
      You need to double check the key and walk the chain by looking at
      the next entry to eventually find the right one.
      <br>
      <br>
    </blockquote>
    <p>I am not completely understand how fault-&gt;next and
      gmc-&gt;last_fault works, as it keep increasing. Please help
      review patch v2.</p>
    <p>Thanks,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:6d4d7698-381a-f1d7-2eed-b71047ddc70d@gmail.com">Christian.
      <br>
      <br>
      <blockquote type="cite">+}
        <br>
        +
        <br>
        &nbsp; int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
        <br>
        index 9d11c02a3938..498a7a0d5a9e 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
        <br>
        @@ -318,6 +318,8 @@ void amdgpu_gmc_agp_location(struct
        amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_gmc *mc);
        <br>
        &nbsp; bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev,
        uint64_t addr,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t pasid, uint64_t timestamp);
        <br>
        +void amdgpu_gmc_filter_faults_remove(struct amdgpu_device
        *adev, uint64_t addr,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t pasid);
        <br>
        &nbsp; int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
        <br>
        &nbsp; void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
        <br>
        &nbsp; int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device
        *adev);
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--===============1901979817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1901979817==--
