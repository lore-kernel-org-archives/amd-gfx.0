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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E4CC433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 14:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1642083E
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 14:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vaIptC0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1642083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A43289872;
	Mon, 31 Aug 2020 14:30:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C94389872
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 14:30:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjnmKctcqk2arax/TE9TuLz7C67OOGS+aaXnxQ+KXotxK7DvS2k1jKlNleYF3lyBkXUYVHcPoTNZyCV2oVl4X4+nRmVKxv+8f9/SMgnmTOVoOtiui6texJb9tBn57aE4DfvB54GtKkDasBi2cIfkDjHWuCdOAK1EzNqyFmFmA/5y3Nv6tN3OFgSPc9oNyMpDJqT/vYZu+G7plCm5oQj3Y78jHXxD6hZoOcQK3YwmIxYpUC7y+G+k8P3OUccW7nFzvCHj7Uqg5tHVRm0tHiNphLh//ElqpJIOiWaUEA0nhXNnJZiZsbCm+CXdj9DI9Pec5UMbG4iKyl0+xSfhotYEgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DQfkbB3qiC9chOQvUJwlBMaOYrkKlv/+AdF7CLoTxA=;
 b=oa4d9bSoGUBAcBPW1cCRMq7MsT9KuQ0Tav3wtgYHjM0igqwrmzNJZ+NlWu9Cu+pLIZiO5WCv9apaMFt7naiVysiSpZyCAxLNH2qgPoM9AtmPvUc1mIWPow7Pp/H0SZYEEYaVDFMPYT0+HjfwpSEENj/UdF7c8LY6WqV6nW9zMr6Qdg1hoWXwTXUzy3XchqNzhVjSn8nJTPMfuqxlNCpiriPe3GnOeZyE3EIGjq8nC9KUeQM9SBYMa88E64MxpHLE38YfOCCJ0wsNm+wQRycLkI2tzGKa+CMbUTDJJcVb9+luSAI7zqV9Zn7hzQ/PqIoQt870IUYwEfTQTLMgVegC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DQfkbB3qiC9chOQvUJwlBMaOYrkKlv/+AdF7CLoTxA=;
 b=vaIptC0/paaar8dOxNbwdFWOM10UcXkQtt06hW4lUb8dD/54BQtrlzWi0bI9IZfDJuIXHzRJqb21ryaxUlwDNyJU7t9pIWEjjSODrPcMWOZRq6bcx8pZZw3uUdj1WLaLe8pD2NRZ0ZEgSUh9vV2S6FYj8iNPl90b15a5QeLSQcc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.21; Mon, 31 Aug 2020 14:30:19 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 14:30:19 +0000
Subject: Re: [PATCH 1/7] drm/amdgpu: Implement DPC recovery
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598453182-6946-2-git-send-email-andrey.grodzovsky@amd.com>
 <629145d5-6acd-c838-6b80-8f110fce3c73@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <3079c735-7150-ccbd-bdae-cd189e10347c@amd.com>
Date: Mon, 31 Aug 2020 10:30:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <629145d5-6acd-c838-6b80-8f110fce3c73@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:408:e6::35) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 BN0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:408:e6::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 14:30:19 +0000
X-Originating-IP: [2607:fea8:3edf:49b0:1802:46a:68a:71ca]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7185d4c1-de5b-4850-9179-08d84dba6339
X-MS-TrafficTypeDiagnostic: DM6PR12MB4513:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB451314727BC45024E300A18BEA510@DM6PR12MB4513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R3ken0QOOOIur7przKj37ChUaYMJHTJTtIv+TNzC26OpRUrZljjyPsIZH4KopaEmk6BnFN+b8xRcfF4zCkq2Q9kjVFU27hO9cqsXUT86uSxUVSwC6zBAYbqyrdpNLuj9lwbLyhDD5NNLbycVgz1GXvN+c3WUfgI4ky2+wuU55W70gvjxYTtlODBP9D8/B480iT7AozejwHcwp7cRkgCvAu2E8roSgfiy8o8gXgHYmWXzxDSFxqYHx5BZv2KvlNX9I0h6RCGnVB48z/0vWJ7MBHDu5PpX64rERNZohwdcl3NxjOB2auftCyCFiNnJyhCyllqxWvhwtIqP182Whk0o+SL82qJZDbD33OEgswpFLHiD9EVYNYVfkAzHAIMwxXBZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(478600001)(6486002)(31686004)(316002)(16576012)(5660300002)(30864003)(2906002)(4326008)(86362001)(36756003)(8936002)(2616005)(66556008)(52116002)(66946007)(31696002)(53546011)(956004)(83380400001)(8676002)(186003)(66476007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Qeockicqy4rt/oP0uyh8EP4z1TTrA6uymSaUAuRamDA+w9+Pil4CTfSJMuf9RA1TIxMU+nHyC4+teGgtNSIZ3WdH/K6mqZPHWOFJV+ygW03JCDrahlhhRrZKy33cIcO9ZYO+IN76i38qPhxg1WTtPNEDY1VU0h2hfoCX/xCOdqMafWxxwX9zNNEYWKewT4sAQHPbNpjJtaLcq0ctgar8Y6qicaFxmy0KADVA1cvJ64qQd9bVAOqdJfD0r4d0vcLvHUdbnlOLNGlxpuZqm5IMgCe1bMyasbVBkEUBaI7DEKJJhz5s8N3gYJmN/5OzPOe2kfW4BRE3j62GG3N/oYwds+Jr7qAoOyq+JKkrB/dQopG4PL+bvgHTEV/FgsP4Sz5Fsj8ZbuBMkNM/Jnc78pgILpUo8df1CA8N10qdftpC3/QJeuAOWvaCO1Nvjz8WhWLXw1BMi9dmZ4UaUfdjjiSPjg/YNAMN0DDTOOhAStNbwg6S0JSWSlbKpquA/fpA1SUFdI+koMg01Z2IhxC9+uYPFZU0ihF1VqiwZPaZceupWfosTukGSzB3NtpoIH9PVxzCoS3LocG/yddqhh1xcHvKiIIN49RIMKIRqk6o6BZPoigyuD/YHINuw+VsMurh9iyDQsWxPDMsxpIsqOC+7ubvJg0NSsNBa9/QpPphGcHBenoBeUN3D1pW5vEuKFzw/BY+HT+79IQzD2LtPW8y24Onwg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7185d4c1-de5b-4850-9179-08d84dba6339
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 14:30:19.8511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hs8/XA5WoxImho+RSK6qJSyO/FqD1Q9MYHGghLaW9dSkqUWEzqHQLo9qTqRi3WJJMmNFIbbPxNs9dJ3j1wQCUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
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


On 8/28/20 10:07 PM, Luben Tuikov wrote:
> On 2020-08-26 10:46, Andrey Grodzovsky wrote:
>> Add DPC handlers with basic recovery functionality.
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   9 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 181 ++++++++++++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   9 +-
>>   3 files changed, 196 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 49ea9fa..3399242 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -49,6 +49,8 @@
>>   #include <linux/rbtree.h>
>>   #include <linux/hashtable.h>
>>   #include <linux/dma-fence.h>
>> +#include <linux/pci.h>
>> +#include <linux/aer.h>
>>   
>>   #include <drm/ttm/ttm_bo_api.h>
>>   #include <drm/ttm/ttm_bo_driver.h>
>> @@ -1263,6 +1265,13 @@ static inline int amdgpu_dm_display_resume(struct amdgpu_device *adev) { return
>>   void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
>>   void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev);
>>   
>> +pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev,
>> +					   pci_channel_state_t state);
>> +pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev);
>> +pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev);
>> +void amdgpu_pci_resume(struct pci_dev *pdev);
>> +
>> +
>>   #include "amdgpu_object.h"
>>   
>>   /* used by df_v3_6.c and amdgpu_pmu.c */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 5a948ed..84f8d14 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -350,7 +350,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>>    *
>>    * Returns the 8 bit value from the offset specified.
>>    */
>> -uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
>> +uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
>> +{
>> +
>>   	if (offset < adev->rmmio_size)
>>   		return (readb(adev->rmmio + offset));
>>   	BUG();
>> @@ -371,7 +373,9 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
>>    *
>>    * Writes the value specified to the offset specified.
>>    */
>> -void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value) {
>> +void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
>> +{
>> +
>>   	if (offset < adev->rmmio_size)
>>   		writeb(value, adev->rmmio + offset);
>>   	else
>> @@ -380,6 +384,7 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
>>   
>>   void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t acc_flags)
>>   {
>> +
>>   	trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
>>   
>>   	if ((reg * 4) < adev->rmmio_size)
>> @@ -407,6 +412,7 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
>>   void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>>   		    uint32_t acc_flags)
>>   {
>> +
>>   	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>>   		return amdgpu_kiq_wreg(adev, reg, v);
>>   
>> @@ -461,6 +467,7 @@ u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
>>    */
>>   void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
>>   {
>> +
>>   	if ((reg * 4) < adev->rio_mem_size)
>>   		iowrite32(v, adev->rio_mem + (reg * 4));
>>   	else {
>> @@ -480,6 +487,7 @@ void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
>>    */
>>   u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>>   {
>> +
>>   	if (index < adev->doorbell.num_doorbells) {
>>   		return readl(adev->doorbell.ptr + index);
>>   	} else {
>> @@ -500,6 +508,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>>    */
>>   void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>>   {
>> +
>>   	if (index < adev->doorbell.num_doorbells) {
>>   		writel(v, adev->doorbell.ptr + index);
>>   	} else {
>> @@ -518,6 +527,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>>    */
>>   u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>>   {
>> +
>>   	if (index < adev->doorbell.num_doorbells) {
>>   		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
>>   	} else {
>> @@ -538,6 +548,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>>    */
>>   void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>>   {
>> +
>>   	if (index < adev->doorbell.num_doorbells) {
>>   		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>>   	} else {
>> @@ -2989,6 +3000,7 @@ static const struct attribute *amdgpu_dev_attributes[] = {
>>   	NULL
>>   };
>>   
>> +
>>   /**
>>    * amdgpu_device_init - initialize the driver
>>    *
>> @@ -3207,6 +3219,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>   		}
>>   	}
>>   
>> +	pci_enable_pcie_error_reporting(adev->ddev.pdev);
>> +
>> +
>>   	/* Post card if necessary */
>>   	if (amdgpu_device_need_post(adev)) {
>>   		if (!adev->bios) {
>> @@ -3359,6 +3374,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>   	if (r)
>>   		dev_err(adev->dev, "amdgpu_pmu_init failed\n");
>>   
>> +	if (pci_save_state(pdev))
>> +		DRM_ERROR("Failed to save PCI state!!\n");
>> +
>>   	return 0;
>>   
>>   failed:
>> @@ -4701,3 +4719,162 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
>>   
>>   	return 0;
>>   }
>> +
>> +/**
>> + * amdgpu_pci_error_detected - Called when a PCI error is detected.
>> + * @pdev: PCI device struct
>> + * @state: PCI channel state
>> + *
>> + * Description: Called when a PCI error is detected.
>> + *
>> + * Return: PCI_ERS_RESULT_NEED_RESET or PCI_ERS_RESULT_DISCONNECT.
>> + */
>> +pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
>> +{
>> +	struct drm_device *dev = pci_get_drvdata(pdev);
>> +	struct amdgpu_device *adev = drm_to_adev(dev);
>> +
>> +	DRM_INFO("PCI error: detected callback, state(%d)!!\n", state);
>> +
>> +	switch (state) {
>> +	case pci_channel_io_normal:
>> +		return PCI_ERS_RESULT_CAN_RECOVER;
>> +	case pci_channel_io_frozen: {
>> +		/* Fatal error, prepare for slot reset */
>> +
>> +		amdgpu_device_lock_adev(adev);
>> +		return PCI_ERS_RESULT_NEED_RESET;
>> +	}
>> +	case pci_channel_io_perm_failure:
>> +		/* Permanent error, prepare for device removal */
>> +		return PCI_ERS_RESULT_DISCONNECT;
>> +	}
>> +	return PCI_ERS_RESULT_NEED_RESET;
>> +}
> Perhaps an empty line before the "return".
>
>> +
>> +/**
>> + * amdgpu_pci_mmio_enabled - Enable MMIO and dump debug registers
>> + * @pdev: pointer to PCI device
>> + */
>> +pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev)
>> +{
>> +
>> +	DRM_INFO("PCI error: mmio enabled callback!!\n");
>> +
>> +	/* TODO - dump whatever for debugging purposes */
>> +
>> +	/* This called only if amdgpu_pci_error_detected returns
>> +	 * PCI_ERS_RESULT_CAN_RECOVER. Read/write to the device still
>> +	 * works, no need to reset slot.
>> +	 */
>> +
>> +	return PCI_ERS_RESULT_RECOVERED;
>> +}
>> +
>> +/**
>> + * amdgpu_pci_slot_reset - Called when PCI slot has been reset.
>> + * @pdev: PCI device struct
>> + *
>> + * Description: This routine is called by the pci error recovery
>> + * code after the PCI slot has been reset, just before we
>> + * should resume normal operations.
>> + */
>> +pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>> +{
>> +	struct drm_device *dev = pci_get_drvdata(pdev);
>> +	struct amdgpu_device *adev = drm_to_adev(dev);
>> +	int r;
>> +	bool vram_lost;
>> +
>> +	DRM_INFO("PCI error: slot reset callback!!\n");
>> +
>> +	pci_restore_state(pdev);
>> +
>> +	r = amdgpu_device_ip_suspend(adev);
>> +	if (r)
>> +		goto out;
>> +
>> +
>> +	/* post card */
>> +	r = amdgpu_atom_asic_init(adev->mode_info.atom_context);
>> +	if (r)
>> +		goto out;
>> +
>> +	r = amdgpu_device_ip_resume_phase1(adev);
>> +	if (r)
>> +		goto out;
>> +
>> +	vram_lost = amdgpu_device_check_vram_lost(adev);
>> +	if (vram_lost) {
>> +		DRM_INFO("VRAM is lost due to GPU reset!\n");
>> +		amdgpu_inc_vram_lost(adev);
>> +	}
>> +
>> +	r = amdgpu_gtt_mgr_recover(
>> +		&adev->mman.bdev.man[TTM_PL_TT]);
>> +	if (r)
>> +		goto out;
>> +
>> +	r = amdgpu_device_fw_loading(adev);
>> +	if (r)
>> +		return r;
>> +
>> +	r = amdgpu_device_ip_resume_phase2(adev);
>> +	if (r)
>> +		goto out;
>> +
>> +	if (vram_lost)
>> +		amdgpu_device_fill_reset_magic(adev);
>> +
>> +	/*
>> +	 * Add this ASIC as tracked as reset was already
>> +	 * complete successfully.
>> +	 */
>> +	amdgpu_register_gpu_instance(adev);
>> +
>> +	r = amdgpu_device_ip_late_init(adev);
>> +	if (r)
>> +		goto out;
>> +
>> +	amdgpu_fbdev_set_suspend(adev, 0);
>> +
>> +	/* must succeed. */
>> +	amdgpu_ras_resume(adev);
>> +
>> +
>> +	amdgpu_irq_gpu_reset_resume_helper(adev);
>> +	r = amdgpu_ib_ring_tests(adev);
>> +	if (r)
>> +		goto out;
>> +
>> +	r = amdgpu_device_recover_vram(adev);
>> +
>> +out:
>> +
>> +	if (!r)
>> +		DRM_INFO("PCIe error recovery succeeded\n");
>> +	else {
>> +		DRM_ERROR("PCIe error recovery failed, err:%d", r);
>> +		amdgpu_device_unlock_adev(adev);
>> +	}
> Add braces around the "if ()" if you're going to add them
> around the "else".
>
> It's a good idea to run patches through checkpatch.pl--as
> a general guidance--sometimes it finds good things.
>
> Regards,
> Luben


I did run it, I might have missed this of course.

Andrey


>
>> +
>> +	return r ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
>> +}
>> +
>> +/**
>> + * amdgpu_pci_resume() - resume normal ops after PCI reset
>> + * @pdev: pointer to PCI device
>> + *
>> + * Called when the error recovery driver tells us that its
>> + * OK to resume normal operation. Use completion to allow
>> + * halted scsi ops to resume.
>> + */
>> +void amdgpu_pci_resume(struct pci_dev *pdev)
>> +{
>> +	struct drm_device *dev = pci_get_drvdata(pdev);
>> +	struct amdgpu_device *adev = drm_to_adev(dev);
>> +
>> +	amdgpu_device_unlock_adev(adev);
>> +
>> +	DRM_INFO("PCI error: resume callback!!\n");
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index d984c6a..4bbcc70 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -31,7 +31,6 @@
>>   #include <drm/drm_pciids.h>
>>   #include <linux/console.h>
>>   #include <linux/module.h>
>> -#include <linux/pci.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/vga_switcheroo.h>
>>   #include <drm/drm_probe_helper.h>
>> @@ -1534,6 +1533,13 @@ static struct drm_driver kms_driver = {
>>   	.patchlevel = KMS_DRIVER_PATCHLEVEL,
>>   };
>>   
>> +static struct pci_error_handlers amdgpu_pci_err_handler = {
>> +	.error_detected	= amdgpu_pci_error_detected,
>> +	.mmio_enabled	= amdgpu_pci_mmio_enabled,
>> +	.slot_reset	= amdgpu_pci_slot_reset,
>> +	.resume		= amdgpu_pci_resume,
>> +};
>> +
>>   static struct pci_driver amdgpu_kms_pci_driver = {
>>   	.name = DRIVER_NAME,
>>   	.id_table = pciidlist,
>> @@ -1541,6 +1547,7 @@ static struct pci_driver amdgpu_kms_pci_driver = {
>>   	.remove = amdgpu_pci_remove,
>>   	.shutdown = amdgpu_pci_shutdown,
>>   	.driver.pm = &amdgpu_pm_ops,
>> +	.err_handler = &amdgpu_pci_err_handler,
>>   };
>>   
>>   static int __init amdgpu_init(void)
>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
