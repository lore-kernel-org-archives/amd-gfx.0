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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2833EC433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 14:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC77520719
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 14:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3c3HsQcm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC77520719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A988D6E28B;
	Mon, 31 Aug 2020 14:58:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A6026E28B
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 14:58:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYKxSfHzOl/vmz7opuIgKfLf3sO44DtD7g7oqEXFEFqw1Boiak9VNw7uxk9wOLDp1i5PlLwcOz7tVCnbb9+fgGoune3+oZ4GRO9GmNOJUBMRJpjQiO9Ts1Gh1WHWhCM1zvsyo0ywndoTbWatIGYnxvQ3BQ4D2A1HcngdYcL0hVY8SD0U6YAvGigtvEp2eO4GCYvX3D3rALGoF4HPwarNn516dl1IPJGmsdgcpAEFd4K51vatCt+vGiobAwTHf8pttK+jBuau4CsMKezmkpRiqpsmQgMxJPsjOI7LZsR0rr0Z69SM5bVNGeqjiSgyoFO6KcUElrrjvId1Saql9YBBxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5cIhYC1Riax4r9svVbJWqfJIVWx3+tLWF5Ome+MeP0=;
 b=NE8JrCHyzI1DcfT4Kl6M3KyCDK2fLa93VWm+6ClOXbW1pWtLnPk9R4GgA1MzxeTM8Zm5klrEanoMdH2GCPA1nib4Aejy4BZp9iwkL0X3HdiCiUNFd0K+DoXdm+syBcqkXwJnYJsOrr0POZp6fn8Y5p1ztWAL+Dn1khCcROU8UnrMAbU2AluSvAKqWre//BJ9l40PJeKLaLWvJdjTU21F9fmFBLySLatFhf2zbPA6ib/32qfK9gZ/8bbdWpoIvZTtM01zyMzzR7rez4jSXxek1ZOrEqDDFSEaidxfTwZvXlPp8S2686UUEzgSjoKX4en8FvWZB8d23LBkWrP/REH8oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5cIhYC1Riax4r9svVbJWqfJIVWx3+tLWF5Ome+MeP0=;
 b=3c3HsQcmEsAIucUbqi6n7S+OTzpjGxHSBgOx0+5B6AhFNxDByY4ZcT1xDMLasNCHDFaqemRYzQjVEtD95h7Im6/s+1lkxiAFNt58RhTEMTaF78G8ZRVBrdZzP+5Fj6GQFXvjjVG/6Wqi0qQEgjTCg5kYsIGF2Qeb1DFHNuOkI3s=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM5PR12MB1146.namprd12.prod.outlook.com (2603:10b6:3:73::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.25; Mon, 31 Aug 2020 14:58:39 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 14:58:39 +0000
Subject: Re: [PATCH 2/7] drm/amdgpu: Avoid accessing HW when suspending SW
 state
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598453182-6946-3-git-send-email-andrey.grodzovsky@amd.com>
 <8853be30-b31e-c31f-4bd8-44f191cad1ba@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <9af9a9aa-2039-214e-4446-d7b2621676b9@amd.com>
Date: Mon, 31 Aug 2020 10:58:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <8853be30-b31e-c31f-4bd8-44f191cad1ba@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:404:10a::14) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 BN6PR13CA0004.namprd13.prod.outlook.com (2603:10b6:404:10a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.5 via Frontend
 Transport; Mon, 31 Aug 2020 14:58:38 +0000
X-Originating-IP: [2607:fea8:3edf:49b0:1802:46a:68a:71ca]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 63c94c54-69d1-4785-9542-08d84dbe583e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1146:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11465615C15D2C024AC41D93EA510@DM5PR12MB1146.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3FKJqM1KMBzHMs1aLYRPtZe7XsmCWlRkdJ3Unh+OuAjoL4tkxRpZng7C+mV/tTWb8APKSpJPdmFWaUl0BGwIMbKYHQKHyjcMnuDe0XXX884fTR5tLft1kCSC0D2JQbZX9j2N9ZBxgHX88T1jksDIhKF70IzLIQs1kUgjwyk9xyZuFUz9YPiFZea5XhKPsgojRwC0Cc6m4FhXO/EDfo1x5NOPiR2sMCIbvobPufa4nutrWo35i5+4BfEc02gxrvE4OtIdeEq1wdh5bC27/8+mMwI4AGwMQmK3EFg0roU+ZDCqHgToDwoFRpWo6L7NutS3ob4ds0jjFW3By7PVarK6Zf/I3IjB3oBYBjAJVMUclClyzrEimnHEurvhgnjfh20BH/rMCEI1/kIvLs6clW8qtuhlcZdMPtxv2Y1k/cUHzoY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(4326008)(83380400001)(66476007)(86362001)(66556008)(2906002)(31686004)(52116002)(66946007)(53546011)(186003)(31696002)(316002)(36756003)(5660300002)(30864003)(16576012)(956004)(2616005)(6486002)(8936002)(478600001)(8676002)(43740500002)(473944003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /6sGVfbd71eDXtncuYn5LYD7SqUyjJBsA9+aWcK8cYaqL+779a7Fi1vQXhc8ydbkXb6rpoEMazv7+dtLDgS/IXkP86Q4DZy7sgYKT66667SkNk6trTPPh4bdDI2hnTpNa0YdYQJf2TOjKtSCLkFoahRJKN3VEmJkvC5JhKeTq6DfYy5XWegfsD9koyi/KipEmUxy7lw+S8Cr+OZ33R6TiZfQWCk/iVvl1WysXUSZdiKFH6fRAJIPjEGKNam1F1+CmBJ5k2+9N3fkJ4Y3b9mw6dbMkKW3otep81hpQl/NXd54VdDbN+1/XDK8s4GGCEGhTiNBanzUc2AGee8X801vfH3fyZnxg69C8rp/kGfjmfbyIpw5ReRm2ziDlTmeIEEE0amNqd9001dQm1+7Y46cJqnQWab6enOB478EnSpq2Grj0r8bbFDBDMKbl0/YRfCwrNBiEiXix31yIQ9Wikyh2awfaU9PuV3ByBpb1NgzLpMBYo5fwZBu1gMDAPFuzUVa4w5slFhjouMxQ3PQ3Vt4TWacTweu7/nkV6e0fN4B8wm4FErrZD8vr2NwVu4zJEZY5SbKPKSTrOM3d8aszdGPFSnrtKOo3nnAvwUJg/tvf0iCgFgg61h7npj+ITaxF4hN3qCVWCIM1h18ohHa9CLe/ACoXdRzqraC+oXjImK13XlwGRBEinumEO5CHj9/bV2Bzze1Azk4pNyos6fRSpWxQA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c94c54-69d1-4785-9542-08d84dbe583e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 14:58:39.3950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t69ODVhmudce6zmeIe/lHVC91VU6pG/ZJgPxs7n+6h0aJzmtCBvVof2qKfIp1PwFx0nYUNAIeIfSmzsEYqiJ5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1146
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
Cc: alexander.deucher@amd.com, nirmodas@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 8/28/20 10:03 PM, Luben Tuikov wrote:
> On 2020-08-26 10:46, Andrey Grodzovsky wrote:
>> At this point the ASIC is already post reset by the HW/PSP
>> so the HW not in proper state to be configured for suspension,
>> some bloks might be even gated and so best is to avoid touching it.
> "blocks"
>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++++++++++++++++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  6 +++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  6 +++++
>>   drivers/gpu/drm/amd/amdgpu/atom.c          |  1 +
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 18 +++++++++------
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  |  3 +++
>>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c     |  3 +++
>>   8 files changed, 64 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 3399242..3489622 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -992,6 +992,7 @@ struct amdgpu_device {
>>   	atomic_t			throttling_logging_enabled;
>>   	struct ratelimit_state		throttling_logging_rs;
>>   	uint32_t			ras_features;
>> +	bool                            in_dpc;
>>   };
> This is very cryptic and if we do that, in 10 years,
> the code will be full of cryptic variables and comments.
>
> Better to add a comment
>
> 	bool				in_dpc; /* PCI Downstream Port Containment */


Per Nirmoy's comment I already modified the naming to a descriptive one in V2 
patchset

>
>>   
>>   static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 84f8d14..e1bbefd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -319,6 +319,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>>   {
>>   	uint32_t ret;
>>   
>> +	if (adev->in_dpc)
>> +		return 0;
>> +
>>   	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>>   		return amdgpu_kiq_rreg(adev, reg);
>>   
>> @@ -350,8 +353,10 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>>    *
>>    * Returns the 8 bit value from the offset specified.
>>    */
>> -uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
>> -{
>> +uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
>> +
>> +	if (adev->in_dpc)
>> +		return 0;
>>   
>>   	if (offset < adev->rmmio_size)
>>   		return (readb(adev->rmmio + offset));
>> @@ -373,8 +378,10 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
>>    *
>>    * Writes the value specified to the offset specified.
>>    */
>> -void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
>> -{
>> +void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value) {
>> +
>> +	if (adev->in_dpc)
>> +		return;
>>   
>>   	if (offset < adev->rmmio_size)
>>   		writeb(value, adev->rmmio + offset);
>> @@ -384,6 +391,8 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
>>   
>>   void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t acc_flags)
>>   {
>> +	if (adev->in_dpc)
>> +		return;
>>   
>>   	trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
>>   
>> @@ -412,6 +421,8 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
>>   void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>>   		    uint32_t acc_flags)
>>   {
>> +	if (adev->in_dpc)
>> +		return;
>>   
>>   	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>>   		return amdgpu_kiq_wreg(adev, reg, v);
>> @@ -427,6 +438,9 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>>   void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>>   		    uint32_t acc_flags)
>>   {
>> +	if (adev->in_dpc)
>> +		return;
>> +
>>   	if (amdgpu_sriov_fullaccess(adev) &&
>>   		adev->gfx.rlc.funcs &&
>>   		adev->gfx.rlc.funcs->is_rlcg_access_range) {
>> @@ -448,6 +462,9 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t
>>    */
>>   u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
>>   {
>> +	if (adev->in_dpc)
>> +		return 0;
>> +
>>   	if ((reg * 4) < adev->rio_mem_size)
>>   		return ioread32(adev->rio_mem + (reg * 4));
>>   	else {
>> @@ -467,6 +484,8 @@ u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
>>    */
>>   void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
>>   {
>> +	if (adev->in_dpc)
>> +		return;
>>   
>>   	if ((reg * 4) < adev->rio_mem_size)
>>   		iowrite32(v, adev->rio_mem + (reg * 4));
>> @@ -487,6 +506,8 @@ void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
>>    */
>>   u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>>   {
>> +	if (adev->in_dpc)
>> +		return 0;
>>   
>>   	if (index < adev->doorbell.num_doorbells) {
>>   		return readl(adev->doorbell.ptr + index);
>> @@ -508,6 +529,8 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>>    */
>>   void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>>   {
>> +	if (adev->in_dpc)
>> +		return;
>>   
>>   	if (index < adev->doorbell.num_doorbells) {
>>   		writel(v, adev->doorbell.ptr + index);
>> @@ -527,6 +550,8 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>>    */
>>   u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>>   {
>> +	if (adev->in_dpc)
>> +		return 0;
>>   
>>   	if (index < adev->doorbell.num_doorbells) {
>>   		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
>> @@ -548,6 +573,8 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>>    */
>>   void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>>   {
>> +	if (adev->in_dpc)
>> +			return;
>>   
>>   	if (index < adev->doorbell.num_doorbells) {
>>   		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>> @@ -4790,7 +4817,9 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>>   
>>   	pci_restore_state(pdev);
>>   
>> +	adev->in_dpc = true;
>>   	r = amdgpu_device_ip_suspend(adev);
>> +	adev->in_dpc = false;
>>   	if (r)
>>   		goto out;
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index d698142..50c42c9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -693,6 +693,9 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
>>   	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>>   	struct amdgpu_ring *ring = &kiq->ring;
>>   
>> +	if (adev->in_dpc)
>> +		return 0;
>> +
>>   	BUG_ON(!ring->funcs->emit_rreg);
>>   
>>   	spin_lock_irqsave(&kiq->ring_lock, flags);
>> @@ -757,6 +760,9 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
>>   
>>   	BUG_ON(!ring->funcs->emit_wreg);
>>   
>> +	if (adev->in_dpc)
>> +		return;
>> +
> Don't know how I feel about such "architecture",
> where we introduce a flag-type variable and check it
> in a slew of places. If we did this a few times over,
> we'd have a few flags which we check almost everywhere,
> and it would make the code difficult to analyze.
> For instance, which flag to check first? Or, how
> are flags related to each other.
>
> There has to be a better way, where we check
> that flag only once before proceeding. A more
> unified approach.

I fail to see any other approach besides this one currently, there are a few 
different functions for
r/w register access and unless there would be a single register access generic 
function where I could
place this check (which I don't think is a good idea) I don't see how to do it 
in once place. On top of
that, this variable is being checked in wait for HW response use cases such as 
psp_wait_for where you
expect specific value to be returned from the driver/psp interfacing registers 
which you should simply
avoid expecting in this case. All in all I don't see how u can make this a 
generic check in once place that solves
all the use cases.

Andrey


>
>>   	spin_lock_irqsave(&kiq->ring_lock, flags);
>>   	amdgpu_ring_alloc(ring, 32);
>>   	amdgpu_ring_emit_wreg(ring, reg, v);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> index d6c38e2..555ef59 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> @@ -219,6 +219,9 @@ int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
>>   	int i;
>>   	struct amdgpu_device *adev = psp->adev;
>>   
>> +	if (psp->adev->in_dpc)
>> +		return 0;
>> +
>>   	for (i = 0; i < adev->usec_timeout; i++) {
>>   		val = RREG32(reg_index);
>>   		if (check_changed) {
>> @@ -245,6 +248,9 @@ psp_cmd_submit_buf(struct psp_context *psp,
>>   	bool ras_intr = false;
>>   	bool skip_unsupport = false;
>>   
>> +	if (psp->adev->in_dpc)
>> +		return 0;
>> +
>>   	mutex_lock(&psp->mutex);
>>   
>>   	memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
>> index 4cfc786..613dac1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
>> @@ -750,6 +750,7 @@ static void atom_op_jump(atom_exec_context *ctx, int *ptr, int arg)
>>   					DRM_ERROR("atombios stuck in loop for more than %dsecs aborting\n",
>>   						  ATOM_CMD_TIMEOUT_SEC);
>>   					ctx->abort = true;
>> +					dump_stack();
>>   				}
>>   			} else {
>>   				/* jiffies wrap around we will just wait a little longer */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index 2db195e..86f268e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -6980,15 +6980,19 @@ static int gfx_v10_0_hw_fini(void *handle)
>>   
>>   	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>>   	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
>> +
>> +	if (!adev->in_dpc) {
>>   #ifndef BRING_UP_DEBUG
>> -	if (amdgpu_async_gfx_ring) {
>> -		r = gfx_v10_0_kiq_disable_kgq(adev);
>> -		if (r)
>> -			DRM_ERROR("KGQ disable failed\n");
>> -	}
>> +		if (amdgpu_async_gfx_ring) {
>> +			r = gfx_v10_0_kiq_disable_kgq(adev);
>> +			if (r)
>> +				DRM_ERROR("KGQ disable failed\n");
>> +		}
>>   #endif
>> -	if (amdgpu_gfx_disable_kcq(adev))
>> -		DRM_ERROR("KCQ disable failed\n");
>> +		if (amdgpu_gfx_disable_kcq(adev))
>> +			DRM_ERROR("KCQ disable failed\n");
>> +	}
>> +
>>   	if (amdgpu_sriov_vf(adev)) {
>>   		gfx_v10_0_cp_gfx_enable(adev, false);
>>   		/* Program KIQ position of RLC_CP_SCHEDULERS during destroy */
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index 8462b30..306461d 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -224,9 +224,12 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
>>   {
>>   	int ret = 0;
>>   
>> +
>>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>>   		return -EOPNOTSUPP;
>>   
>> +
>> +
> Unnecessary white space changes.
>
> Regards,
> Luben
>
>>   	switch (block_type) {
>>   	/*
>>   	 * Some legacy code of amdgpu_vcn.c and vcn_v2*.c still uses
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> index a58ea08..02cf55e 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>> @@ -112,6 +112,9 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>>   	struct amdgpu_device *adev = smu->adev;
>>   	int ret = 0, index = 0;
>>   
>> +	if (smu->adev->in_dpc)
>> +		return 0;
>> +
>>   	index = smu_cmn_to_asic_specific_index(smu,
>>   					       CMN2ASIC_MAPPING_MSG,
>>   					       msg);
>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
