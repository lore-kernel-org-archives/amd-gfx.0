Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF702C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 20:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 957332083E
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 20:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bUEXcnjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957332083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D9E46E512;
	Mon, 31 Aug 2020 20:19:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ABA96E507
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 20:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1Jr9wp7Pzf+mswBRumYNC4p1qU0FJ7kSiqq+j/+6uCHuvOLIVXysmsjvIUKET1aZJUI/gzewcDOBUkNUwa+r30XXw2mio7HqCCEuydAbE22NKyjmkPeqaTGc46EUMZqYuH6UgMcQ6WvoauAGQJZ5JzmgUN5kmmkonGk7bGxXS2YxoffJuj5dUhb4RvbikNsMx3CuiHaeUJUrRH3uf++lRSAh/JHS2P95E1MC8THoe5QLc2A5Ef+amybiR9kyk6CgrGi0GfPVscHx5c9L+ALC1qcGWh3GhT9Y9QQKsV55t2jh01Zg5R/Hh4dvyesTSdU8x5yFxZPmnl27OFW1PT05g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+wGZuI3PiU3ufG4XmiTdRBSNOY4uhZ3pVF8hVj66j8=;
 b=ghs5XueyyFBg3yDYKa2wPJYjcefQphQa4dI0Ms0DT2JdFF2rF3Z5KgQxnxW7pSXfnYLeEcIMSJCTtl9KdyDB33d/HyIIV5fWbQGQwdYvRDPF0Q0ysHbwb2fq2j30DHQsoVgUBgVOoRkrHjTRp8/m/0gj7ny1eUeHOaUcPW1Gry9Wlg7KPe7BJvGSk78u7Y/pDeIZgDAFxsy/XZpsJvq+35AZv58juTVlQN1Cl1pEbzqsUoGjg0UUQ5y9EQW4emBdWj44F+G0PRxbGrAnGZhyfCvGV/x+qZZ2gzkveWDGofqTTBkWYGjoMaKOixetCY4d+A/Y2Z1VYc+BnFXDWo+p8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+wGZuI3PiU3ufG4XmiTdRBSNOY4uhZ3pVF8hVj66j8=;
 b=bUEXcnjsM2LKR/GKNti3SnUMI0mNwytNIM6qSVO1mw6k+nQtyzLGOFPWkv8nJoHguMtI0w2Io/PURk9+89CMH5RphqyR49lEynWU6CS6Q0wG1gEj7H8KENuU67btUC34cs5Naf6yF0/qph9YJR4u9vAtSd0TVlQc9+ZsX1YzH/o=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3689.namprd12.prod.outlook.com (2603:10b6:5:1c7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Mon, 31 Aug
 2020 20:19:22 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e%6]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 20:19:22 +0000
Subject: Re: [PATCH v2 2/7] drm/amdgpu: Avoid accessing HW when suspending SW
 state
To: Alex Deucher <alexdeucher@gmail.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
References: <1598630743-21155-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598630743-21155-3-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_N_NjiB5XMZW8JODPtfa3_yqEpa1G896K6ZgL763LH23g@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <9c50f3a8-9f91-a060-1f07-0221c34e746e@amd.com>
Date: Mon, 31 Aug 2020 16:19:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.0
In-Reply-To: <CADnq5_N_NjiB5XMZW8JODPtfa3_yqEpa1G896K6ZgL763LH23g@mail.gmail.com>
Content-Language: en-CA
X-ClientProxiedBy: YTOPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::46) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YTOPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Mon, 31 Aug 2020 20:19:21 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8e135364-97d7-4a73-8a09-08d84deb25e7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3689:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB368941AB930E6CF85524B87F99510@DM6PR12MB3689.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nyPPT9+BchzYzAGe/htahB0prISNrq5rBDQ9PI7QcpI41lOAptPKJBJLRlwNBllukau8m9hioYJhGtMfK0kEmvEfj4WCtH0KGjB3MhdMLGRNEqnHf8tV3Q6Qz/pRAtoxZd1P2BaEd+4aAMJCuDH2plG5bVTVKm8x+MK9W58uKoTwWnWJ9equ3G6UFPukAQL/NRhbYMiOk2KvyaTiM0HHxPzGFGco4ETrU/zx+QxCIjQvKSQciHzqLH085GLXCt0HOFDDR7HibYcbJ7LAJIhaMIc1eDhcTp2aTg9ZEcKGcRplyjHHoj168uBKNRCeT2jO0Uu4l9i3IyiIKN76SBzqtXxo1stuhsqP/zaZQ61opgWywFekNSXBYVUVvR5il+3mdGbe9ZUmRNaLtBEZcpGphsZnEoqueQWxyio2KfSYccw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(53546011)(86362001)(8676002)(316002)(8936002)(2906002)(5660300002)(52116002)(36756003)(31686004)(4326008)(6486002)(45080400002)(66946007)(2616005)(186003)(956004)(15650500001)(26005)(54906003)(66556008)(66476007)(6636002)(110136005)(966005)(16576012)(30864003)(83380400001)(478600001)(44832011)(31696002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: JZ/Ru+bA5am9TYogKlf/TlkFO7UGWJ/5TPOOlVWWqzPdme9fYfUxzevOtc1Qr9x9mx9nR7DKzcf6B+gVGP/GsgPgP3XbX+25FNG5z2vZDXqosyfcerAajuH1eM824gaPf51v7mhoolctCHJFKYGyb24CHZPzYZAEVUByCPItZKTfaZB7oDnTpgZCFPoa16GpdSrZTEkJFR+KwFZwAT1v5GyK7/s41ICtzJcvKJRuaRUdF6UekNIQny+JjuAb79nI4tJa3mT6Rd2uMoeeUtTXhqvWF0/dRC0r30ude15RtdS8rzTBrRlMwtpudNzjJB7Dn3t3LLSOv04+CAhcggjuLD0U7fllo2+AJvNb2qwxHvldxZc5KA9vk5NPjsOLECJeQ6RyGAooyNEhXpUZcXVsIBwV1MuYLPdyvGHprs2xy5bp0Z5tif7hXLTMEJB0KI00dja6K+u8qdZPfjpYl+pP0cM9lIzTnRoEPzcIDKdGz9PWJfrs2fmDhPvk7kQJfRgLhLC8b77pwlGIvzv7OrFPiMVmDEm+7POvWjINoE1581+nc3Ere3luTL4XgfrMYq/lyb3mhm1F/oZLMrzY6qC7V2ZesawXGve+Ff3DnBm8AgyZf7vYOp7tM0gg7GBRhpAVXOba0aOGG0dbn4nlFj5xqg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e135364-97d7-4a73-8a09-08d84deb25e7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 20:19:22.4258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LL5/Wuwqvh2vzTsCuUKN+N5bG1gIAYWY1WBKZEWtGiwzdx6Gn2xKn417p4n3zcB7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3689
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Nirmoy <nirmodas@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-08-28 3:26 p.m., Alex Deucher wrote:
> On Fri, Aug 28, 2020 at 12:06 PM Andrey Grodzovsky
> <andrey.grodzovsky@amd.com> wrote:
>>
>> At this point the ASIC is already post reset by the HW/PSP
>> so the HW not in proper state to be configured for suspension,
>> some bloks might be even gated and so best is to avoid touching it.
> 
> typo: "blocks"

I already mentioned this in the 1st version of the patch--seems to have been ignored.

Regards,
Luben


> 
>>
>> v2: Rename in_dpc to more meaningful name
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 41 +++++++++++++++++++++++++++++-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  6 +++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  6 +++++
>>  drivers/gpu/drm/amd/amdgpu/atom.c          |  1 +
>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 18 ++++++++-----
>>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  |  3 +++
>>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c     |  3 +++
>>  8 files changed, 71 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 3399242..cac51e8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -992,6 +992,7 @@ struct amdgpu_device {
>>         atomic_t                        throttling_logging_enabled;
>>         struct ratelimit_state          throttling_logging_rs;
>>         uint32_t                        ras_features;
>> +       bool                            in_pci_err_recovery;
>>  };
>>
>>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 937f8b0..e67cbf2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -319,6 +319,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>>  {
>>         uint32_t ret;
>>
>> +       if (adev->in_pci_err_recovery)
>> +               return 0;
>> +
>>         if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>>                 return amdgpu_kiq_rreg(adev, reg);
>>
>> @@ -352,6 +355,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>>   */
>>  uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
>>  {
>> +       if (adev->in_pci_err_recovery)
>> +               return 0;
>> +
>>         if (offset < adev->rmmio_size)
>>                 return (readb(adev->rmmio + offset));
>>         BUG();
>> @@ -374,14 +380,21 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
>>   */
>>  void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
>>  {
>> +       if (adev->in_pci_err_recovery)
>> +               return;
>> +
>>         if (offset < adev->rmmio_size)
>>                 writeb(value, adev->rmmio + offset);
>>         else
>>                 BUG();
>>  }
>>
>> -void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t acc_flags)
>> +void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
>> +                                      uint32_t v, uint32_t acc_flags)
>>  {
>> +       if (adev->in_pci_err_recovery)
>> +               return;
>> +
>>         trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
>>
>>         if ((reg * 4) < adev->rmmio_size)
>> @@ -409,6 +422,9 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
>>  void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>>                     uint32_t acc_flags)
>>  {
>> +       if (adev->in_pci_err_recovery)
>> +               return;
>> +
>>         if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>>                 return amdgpu_kiq_wreg(adev, reg, v);
>>
>> @@ -423,6 +439,9 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>>  void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>>                     uint32_t acc_flags)
>>  {
>> +       if (adev->in_pci_err_recovery)
>> +               return;
>> +
>>         if (amdgpu_sriov_fullaccess(adev) &&
>>                 adev->gfx.rlc.funcs &&
>>                 adev->gfx.rlc.funcs->is_rlcg_access_range) {
>> @@ -444,6 +463,9 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t
>>   */
>>  u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
>>  {
>> +       if (adev->in_pci_err_recovery)
>> +               return 0;
>> +
>>         if ((reg * 4) < adev->rio_mem_size)
>>                 return ioread32(adev->rio_mem + (reg * 4));
>>         else {
>> @@ -463,6 +485,9 @@ u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
>>   */
>>  void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
>>  {
>> +       if (adev->in_pci_err_recovery)
>> +               return;
>> +
>>         if ((reg * 4) < adev->rio_mem_size)
>>                 iowrite32(v, adev->rio_mem + (reg * 4));
>>         else {
>> @@ -482,6 +507,9 @@ void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
>>   */
>>  u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>>  {
>> +       if (adev->in_pci_err_recovery)
>> +               return 0;
>> +
>>         if (index < adev->doorbell.num_doorbells) {
>>                 return readl(adev->doorbell.ptr + index);
>>         } else {
>> @@ -502,6 +530,9 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>>   */
>>  void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>>  {
>> +       if (adev->in_pci_err_recovery)
>> +               return;
>> +
>>         if (index < adev->doorbell.num_doorbells) {
>>                 writel(v, adev->doorbell.ptr + index);
>>         } else {
>> @@ -520,6 +551,9 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>>   */
>>  u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>>  {
>> +       if (adev->in_pci_err_recovery)
>> +               return 0;
>> +
>>         if (index < adev->doorbell.num_doorbells) {
>>                 return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
>>         } else {
>> @@ -540,6 +574,9 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>>   */
>>  void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>>  {
>> +       if (adev->in_pci_err_recovery)
>> +               return;
>> +
>>         if (index < adev->doorbell.num_doorbells) {
>>                 atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>>         } else {
>> @@ -4778,7 +4815,9 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>>
>>         pci_restore_state(pdev);
>>
>> +       adev->in_pci_err_recovery = true;
>>         r = amdgpu_device_ip_suspend(adev);
>> +       adev->in_pci_err_recovery = false;
>>         if (r)
>>                 goto out;
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index d698142..8c9bacf 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -693,6 +693,9 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
>>         struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>>         struct amdgpu_ring *ring = &kiq->ring;
>>
>> +       if (adev->in_pci_err_recovery)
>> +               return 0;
>> +
>>         BUG_ON(!ring->funcs->emit_rreg);
>>
>>         spin_lock_irqsave(&kiq->ring_lock, flags);
>> @@ -757,6 +760,9 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
>>
>>         BUG_ON(!ring->funcs->emit_wreg);
>>
>> +       if (adev->in_pci_err_recovery)
>> +               return;
>> +
>>         spin_lock_irqsave(&kiq->ring_lock, flags);
>>         amdgpu_ring_alloc(ring, 32);
>>         amdgpu_ring_emit_wreg(ring, reg, v);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> index d6c38e2..a7771aa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> @@ -219,6 +219,9 @@ int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
>>         int i;
>>         struct amdgpu_device *adev = psp->adev;
>>
>> +       if (psp->adev->in_pci_err_recovery)
>> +               return 0;
>> +
>>         for (i = 0; i < adev->usec_timeout; i++) {
>>                 val = RREG32(reg_index);
>>                 if (check_changed) {
>> @@ -245,6 +248,9 @@ psp_cmd_submit_buf(struct psp_context *psp,
>>         bool ras_intr = false;
>>         bool skip_unsupport = false;
>>
>> +       if (psp->adev->in_pci_err_recovery)
>> +               return 0;
>> +
>>         mutex_lock(&psp->mutex);
>>
>>         memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
>> index 4cfc786..613dac1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
>> @@ -750,6 +750,7 @@ static void atom_op_jump(atom_exec_context *ctx, int *ptr, int arg)
>>                                         DRM_ERROR("atombios stuck in loop for more than %dsecs aborting\n",
>>                                                   ATOM_CMD_TIMEOUT_SEC);
>>                                         ctx->abort = true;
>> +                                       dump_stack();
> 
> Leftover from debugging?
> 
> 
> 
>>                                 }
>>                         } else {
>>                                 /* jiffies wrap around we will just wait a little longer */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index 2db195e..ccf096c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -6980,15 +6980,19 @@ static int gfx_v10_0_hw_fini(void *handle)
>>
>>         amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>>         amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
>> +
>> +       if (!adev->in_pci_err_recovery) {
>>  #ifndef BRING_UP_DEBUG
>> -       if (amdgpu_async_gfx_ring) {
>> -               r = gfx_v10_0_kiq_disable_kgq(adev);
>> -               if (r)
>> -                       DRM_ERROR("KGQ disable failed\n");
>> -       }
>> +               if (amdgpu_async_gfx_ring) {
>> +                       r = gfx_v10_0_kiq_disable_kgq(adev);
>> +                       if (r)
>> +                               DRM_ERROR("KGQ disable failed\n");
>> +               }
>>  #endif
>> -       if (amdgpu_gfx_disable_kcq(adev))
>> -               DRM_ERROR("KCQ disable failed\n");
>> +               if (amdgpu_gfx_disable_kcq(adev))
>> +                       DRM_ERROR("KCQ disable failed\n");
>> +       }
>> +
> 
> gfx9 probably needs something similar, but that can come later if we
> ever validate this for older parts.
> 
>>         if (amdgpu_sriov_vf(adev)) {
>>                 gfx_v10_0_cp_gfx_enable(adev, false);
>>                 /* Program KIQ position of RLC_CP_SCHEDULERS during destroy */
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index 8462b30..306461d 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -224,9 +224,12 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
>>  {
>>         int ret = 0;
>>
>> +
>>         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>>                 return -EOPNOTSUPP;
>>
>> +
>> +
> 
> Unrelated whitespaces changes.  Please drop.  With this things fixed:
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> 
> 
>>         switch (block_type) {
>>         /*
>>          * Some legacy code of amdgpu_vcn.c and vcn_v2*.c still uses
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> index a58ea08..97aa72a 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> @@ -112,6 +112,9 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>>         struct amdgpu_device *adev = smu->adev;
>>         int ret = 0, index = 0;
>>
>> +       if (smu->adev->in_pci_err_recovery)
>> +               return 0;
>> +
>>         index = smu_cmn_to_asic_specific_index(smu,
>>                                                CMN2ASIC_MAPPING_MSG,
>>                                                msg);
>> --
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cluben.tuikov%40amd.com%7Cb1b272ee77ba4d18e56e08d84b885545%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637342396521349293&amp;sdata=%2BLIG7VZ3lpaEUuNydr1XwodqRlAqkiweEcWtk2zppAU%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cluben.tuikov%40amd.com%7Cb1b272ee77ba4d18e56e08d84b885545%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637342396521349293&amp;sdata=%2BLIG7VZ3lpaEUuNydr1XwodqRlAqkiweEcWtk2zppAU%3D&amp;reserved=0
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
