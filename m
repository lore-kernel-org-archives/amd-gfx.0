Return-Path: <SRS0=3ay0=CF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298DDC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 13:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED404207CD
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 13:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BM6Pw+/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED404207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FB8D6E0CE;
	Thu, 27 Aug 2020 13:38:20 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700049.outbound.protection.outlook.com [40.107.70.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 988266E0CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2020 13:38:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrMRFv7qHCCtL82YeNxXC7lTBCYzGBcHuepGXfS12iBECAsKx84mgSiJzwzCHoOPrAjItfpQLFREBb68YaiqfKdmAHMbQOl7xTu8CkATcSaNta0EAAhkGZ7NKiuoEcXOpQ37NN4dKFsU0O4HyZOXVlO+K/HEB8EQeGg+VR561uq/FIa+4m6a5n2kVlXpOk0kv9M3ewqW63gezxEbgGBjFlbCEZsbVzdY3/PnWkucgv3lzmlx6imaTYxh3L206dypsxw1yvfFjbIjUhhXSYr+7PK6XWNEkxGAoA1W1vG4+k1WMw6hnD1FlHmtbhgaOoHzeVgyaxwn19J2GYz5+oBJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3JMR2mH9TgR5uri8NKB6yqkIc0NWUbrTHWnI+wIdfQ=;
 b=O9xxTClFaipsHgDnl1ct1hjBl0f3gxaXvSkc1sBD0KouQ1vJhJdb2laxaUjbKLGjvCynmiA9ms8Tf/7Tgx6eCapnMGbf1WprGvRAFhIi9ta18pjn/slVkUgR5rbuvCjhHl1Fmp0HSyDUrIoqBDlFnXyCQGCVVzUGBq7eSi+XEsM6GqR4SwrWnQjjqrzhXOcFEJ8k+GNgYJ8DNjXddvv1FTarVO5HWepwCDmWZvA0of5FREQCJGnxkt3MXN4a5RttzYClUQamy7cW9mD/8E6cRN8scBCNq9i8ERavNvx7S0gSN1gCI23cHVwuPTFS3cM5unjw0fZxKRx1WN+xqoWyjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3JMR2mH9TgR5uri8NKB6yqkIc0NWUbrTHWnI+wIdfQ=;
 b=BM6Pw+/G+oyWKuifEcA4bbCGS17csTfbafq/prw74ajIeSvb6f9qBfXWmxG2Jb6JM2TLRayFHkFEOI1BfT86eGZOy2YRNfT/XFF0qT8XGyK2DrVGEVS6b0Q9XMe5KRnrErYC1Xt+mvzReJwUS3t1tGnNtdkUhGKEcR5rsWOZA6M=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM6PR12MB3209.namprd12.prod.outlook.com (2603:10b6:5:184::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Thu, 27 Aug 2020 13:38:14 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3326.021; Thu, 27 Aug 2020
 13:38:14 +0000
Subject: Re: [PATCH 1/7] drm/amdgpu: Implement DPC recovery
To: "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598453182-6946-2-git-send-email-andrey.grodzovsky@amd.com>
 <DM5PR12MB2533C6CCEE16BD4BCECFF5B9ED550@DM5PR12MB2533.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <a3242218-0671-c3ad-8c3b-f8c873b3fe39@amd.com>
Date: Thu, 27 Aug 2020 09:38:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <DM5PR12MB2533C6CCEE16BD4BCECFF5B9ED550@DM5PR12MB2533.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR17CA0002.namprd17.prod.outlook.com
 (2603:10b6:404:65::12) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 BN6PR17CA0002.namprd17.prod.outlook.com (2603:10b6:404:65::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 13:38:13 +0000
X-Originating-IP: [2607:fea8:3edf:49b0:7cba:e05f:9981:25cd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ae76680-52c6-4b16-a6b4-08d84a8e727f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3209:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB32091C3611AC5E5DA16A2366EA550@DM6PR12MB3209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mqgGDk1jLeIVlLXSNZumwDes2uONUTty8g5G/qkk5gCY9FhK2OKGjASaRzEvtcUKptfSeeCT9QWvL+wgF7oW/hh4IFRlOKU+8NFBn/v2gFoQQpNpOXf2NINZTm4onb9BQblsac8uG07pBJvkYoEOz0Ne5duVHirhYp8bQ/WC4qMFP8TIr/JKHM7GyoDwq1AgAp++vpKHgqynMt8szrkIT9BU4NABcJfq4QXJ/L3oAgzq92c++6/pP6MvWxUEBdGnVzeUPo22JnmfMnlyx4h1qmuXII3qyaaZOUMQrNBvAvefkVSDnxPLr1ySEFoP6eL79pOHBzjyVHeGLIJBPvMM0MTiP/+nVbZDE01tryR7EWetypcACzrsvZ0atP6i4zo5d6mvHIQUyAOIsroUNaEJuWwdceFGq7M3jf106XBYR2w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(45080400002)(2906002)(8676002)(316002)(4326008)(83380400001)(5660300002)(30864003)(31686004)(31696002)(66556008)(66476007)(8936002)(2616005)(956004)(66946007)(6486002)(54906003)(36756003)(52116002)(110136005)(86362001)(186003)(53546011)(966005)(478600001)(16576012)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: N/uTDewfUIQmqyRfTFE3ZoWVPU4IujRz7IOJZ0miCEgK1nKa655jubHxSqSDixSfURPBLt5bYMwU0zgZexvX8xq9sZwOoc27g04tv19Jk03mp6kPgR+1U+NPj2bNRB15oF4HaVKq/8+anNrvbhDsTZxKGSEd9veKn/j/q81iwzak9p+0d1R7TYEvXVFExLrF12v6MbF7GIHVzRV+FZbiAZt4Vc7iRyBLWVPHYawkuDIJ/KreKkuhWXyml4Vdxul5Ulohf3Ge51RPF7NntvPZ+vVbEjiGmOMjqLBE9bRPU3kCYSfsyz3e9V3xb6Mpz4EB3dZMWqrRIGgnb91WO9WmycZrMSb4RVfSei0x1tYgiqigMn24vGNzAMErwlCrhZb5tVhYdtulenb79drlNPA5C2CEIuBFi7h09Oa3eNgeeXNG1L/JEx+luxFTqP377W6Fd5fbe3IuBW9L4thR8B4CURtFEBhzUKQVqcmp7lt3h5r3fd6Q09qL+yNl5haiQEoF0m7yltNc5s2/d/GxzbDZX4xiAmGtg7Us4ksRDoGqz9qtBb/bSUWxihazKSZTMCMAF0PCXYsYoav+c5q10Y+W8TRJhYKcTUxJt4LpUR+G5O/WN3IHYid0j/glHS3kkVMHfGc8ayeqeHe3fC6nBejX1197yTAXDSzrubmG+h7CK9jrB2PHkhZMSTeS8TS45VPyJ6U5RzK9pHv+wmuCzzwkxA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae76680-52c6-4b16-a6b4-08d84a8e727f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 13:38:14.2472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGnX+KOZ97BJLWSrlwedPRVcmsDHROv5TgJebn+eRcKfBG/d4loXePM3ZBYBbJYCWMXHmu7pKTG26aipdwd/xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3209
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Das,
 Nirmoy" <Nirmoy.Das@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Indeed, I noticed it later and did it in patch 6 (merging 1 and 6 was very messy 
due to following changes so I just kept it as a separate patch).

Andrey

On 8/26/20 9:23 PM, Li, Dennis wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi, Andrey,
>       I found that the sequences of amdgpu_pci_slot_reset is mostly similar to amdgpu_do_asic_reset. Could help us refactor them to reuse more codes?
>
> Best Regards
> Dennis Li
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Andrey Grodzovsky
> Sent: Wednesday, August 26, 2020 10:46 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Das, Nirmoy <Nirmoy.Das@amd.com>
> Subject: [PATCH 1/7] drm/amdgpu: Implement DPC recovery
>
> Add DPC handlers with basic recovery functionality.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   9 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 181 ++++++++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   9 +-
>   3 files changed, 196 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 49ea9fa..3399242 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -49,6 +49,8 @@
>   #include <linux/rbtree.h>
>   #include <linux/hashtable.h>
>   #include <linux/dma-fence.h>
> +#include <linux/pci.h>
> +#include <linux/aer.h>
>   
>   #include <drm/ttm/ttm_bo_api.h>
>   #include <drm/ttm/ttm_bo_driver.h>
> @@ -1263,6 +1265,13 @@ static inline int amdgpu_dm_display_resume(struct amdgpu_device *adev) { return  void amdgpu_register_gpu_instance(struct amdgpu_device *adev);  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev);
>   
> +pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev,
> +					   pci_channel_state_t state);
> +pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev);
> +pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev); void
> +amdgpu_pci_resume(struct pci_dev *pdev);
> +
> +
>   #include "amdgpu_object.h"
>   
>   /* used by df_v3_6.c and amdgpu_pmu.c */ diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5a948ed..84f8d14 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -350,7 +350,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>    *
>    * Returns the 8 bit value from the offset specified.
>    */
> -uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
> +uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
> +
>   	if (offset < adev->rmmio_size)
>   		return (readb(adev->rmmio + offset));
>   	BUG();
> @@ -371,7 +373,9 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
>    *
>    * Writes the value specified to the offset specified.
>    */
> -void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value) {
> +void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset,
> +uint8_t value) {
> +
>   	if (offset < adev->rmmio_size)
>   		writeb(value, adev->rmmio + offset);
>   	else
> @@ -380,6 +384,7 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
>   
>   void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t acc_flags)  {
> +
>   	trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
>   
>   	if ((reg * 4) < adev->rmmio_size)
> @@ -407,6 +412,7 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,  void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>   		    uint32_t acc_flags)
>   {
> +
>   	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>   		return amdgpu_kiq_wreg(adev, reg, v);
>   
> @@ -461,6 +467,7 @@ u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
>    */
>   void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)  {
> +
>   	if ((reg * 4) < adev->rio_mem_size)
>   		iowrite32(v, adev->rio_mem + (reg * 4));
>   	else {
> @@ -480,6 +487,7 @@ void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
>    */
>   u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)  {
> +
>   	if (index < adev->doorbell.num_doorbells) {
>   		return readl(adev->doorbell.ptr + index);
>   	} else {
> @@ -500,6 +508,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>    */
>   void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)  {
> +
>   	if (index < adev->doorbell.num_doorbells) {
>   		writel(v, adev->doorbell.ptr + index);
>   	} else {
> @@ -518,6 +527,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>    */
>   u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)  {
> +
>   	if (index < adev->doorbell.num_doorbells) {
>   		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
>   	} else {
> @@ -538,6 +548,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>    */
>   void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)  {
> +
>   	if (index < adev->doorbell.num_doorbells) {
>   		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>   	} else {
> @@ -2989,6 +3000,7 @@ static const struct attribute *amdgpu_dev_attributes[] = {
>   	NULL
>   };
>   
> +
>   /**
>    * amdgpu_device_init - initialize the driver
>    *
> @@ -3207,6 +3219,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   		}
>   	}
>   
> +	pci_enable_pcie_error_reporting(adev->ddev.pdev);
> +
> +
>   	/* Post card if necessary */
>   	if (amdgpu_device_need_post(adev)) {
>   		if (!adev->bios) {
> @@ -3359,6 +3374,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	if (r)
>   		dev_err(adev->dev, "amdgpu_pmu_init failed\n");
>   
> +	if (pci_save_state(pdev))
> +		DRM_ERROR("Failed to save PCI state!!\n");
> +
>   	return 0;
>   
>   failed:
> @@ -4701,3 +4719,162 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
>   
>   	return 0;
>   }
> +
> +/**
> + * amdgpu_pci_error_detected - Called when a PCI error is detected.
> + * @pdev: PCI device struct
> + * @state: PCI channel state
> + *
> + * Description: Called when a PCI error is detected.
> + *
> + * Return: PCI_ERS_RESULT_NEED_RESET or PCI_ERS_RESULT_DISCONNECT.
> + */
> +pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev,
> +pci_channel_state_t state) {
> +	struct drm_device *dev = pci_get_drvdata(pdev);
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +
> +	DRM_INFO("PCI error: detected callback, state(%d)!!\n", state);
> +
> +	switch (state) {
> +	case pci_channel_io_normal:
> +		return PCI_ERS_RESULT_CAN_RECOVER;
> +	case pci_channel_io_frozen: {
> +		/* Fatal error, prepare for slot reset */
> +
> +		amdgpu_device_lock_adev(adev);
> +		return PCI_ERS_RESULT_NEED_RESET;
> +	}
> +	case pci_channel_io_perm_failure:
> +		/* Permanent error, prepare for device removal */
> +		return PCI_ERS_RESULT_DISCONNECT;
> +	}
> +	return PCI_ERS_RESULT_NEED_RESET;
> +}
> +
> +/**
> + * amdgpu_pci_mmio_enabled - Enable MMIO and dump debug registers
> + * @pdev: pointer to PCI device
> + */
> +pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev) {
> +
> +	DRM_INFO("PCI error: mmio enabled callback!!\n");
> +
> +	/* TODO - dump whatever for debugging purposes */
> +
> +	/* This called only if amdgpu_pci_error_detected returns
> +	 * PCI_ERS_RESULT_CAN_RECOVER. Read/write to the device still
> +	 * works, no need to reset slot.
> +	 */
> +
> +	return PCI_ERS_RESULT_RECOVERED;
> +}
> +
> +/**
> + * amdgpu_pci_slot_reset - Called when PCI slot has been reset.
> + * @pdev: PCI device struct
> + *
> + * Description: This routine is called by the pci error recovery
> + * code after the PCI slot has been reset, just before we
> + * should resume normal operations.
> + */
> +pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev) {
> +	struct drm_device *dev = pci_get_drvdata(pdev);
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	int r;
> +	bool vram_lost;
> +
> +	DRM_INFO("PCI error: slot reset callback!!\n");
> +
> +	pci_restore_state(pdev);
> +
> +	r = amdgpu_device_ip_suspend(adev);
> +	if (r)
> +		goto out;
> +
> +
> +	/* post card */
> +	r = amdgpu_atom_asic_init(adev->mode_info.atom_context);
> +	if (r)
> +		goto out;
> +
> +	r = amdgpu_device_ip_resume_phase1(adev);
> +	if (r)
> +		goto out;
> +
> +	vram_lost = amdgpu_device_check_vram_lost(adev);
> +	if (vram_lost) {
> +		DRM_INFO("VRAM is lost due to GPU reset!\n");
> +		amdgpu_inc_vram_lost(adev);
> +	}
> +
> +	r = amdgpu_gtt_mgr_recover(
> +		&adev->mman.bdev.man[TTM_PL_TT]);
> +	if (r)
> +		goto out;
> +
> +	r = amdgpu_device_fw_loading(adev);
> +	if (r)
> +		return r;
> +
> +	r = amdgpu_device_ip_resume_phase2(adev);
> +	if (r)
> +		goto out;
> +
> +	if (vram_lost)
> +		amdgpu_device_fill_reset_magic(adev);
> +
> +	/*
> +	 * Add this ASIC as tracked as reset was already
> +	 * complete successfully.
> +	 */
> +	amdgpu_register_gpu_instance(adev);
> +
> +	r = amdgpu_device_ip_late_init(adev);
> +	if (r)
> +		goto out;
> +
> +	amdgpu_fbdev_set_suspend(adev, 0);
> +
> +	/* must succeed. */
> +	amdgpu_ras_resume(adev);
> +
> +
> +	amdgpu_irq_gpu_reset_resume_helper(adev);
> +	r = amdgpu_ib_ring_tests(adev);
> +	if (r)
> +		goto out;
> +
> +	r = amdgpu_device_recover_vram(adev);
> +
> +out:
> +
> +	if (!r)
> +		DRM_INFO("PCIe error recovery succeeded\n");
> +	else {
> +		DRM_ERROR("PCIe error recovery failed, err:%d", r);
> +		amdgpu_device_unlock_adev(adev);
> +	}
> +
> +	return r ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED; }
> +
> +/**
> + * amdgpu_pci_resume() - resume normal ops after PCI reset
> + * @pdev: pointer to PCI device
> + *
> + * Called when the error recovery driver tells us that its
> + * OK to resume normal operation. Use completion to allow
> + * halted scsi ops to resume.
> + */
> +void amdgpu_pci_resume(struct pci_dev *pdev) {
> +	struct drm_device *dev = pci_get_drvdata(pdev);
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +
> +	amdgpu_device_unlock_adev(adev);
> +
> +	DRM_INFO("PCI error: resume callback!!\n"); }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index d984c6a..4bbcc70 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -31,7 +31,6 @@
>   #include <drm/drm_pciids.h>
>   #include <linux/console.h>
>   #include <linux/module.h>
> -#include <linux/pci.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/vga_switcheroo.h>
>   #include <drm/drm_probe_helper.h>
> @@ -1534,6 +1533,13 @@ static struct drm_driver kms_driver = {
>   	.patchlevel = KMS_DRIVER_PATCHLEVEL,
>   };
>   
> +static struct pci_error_handlers amdgpu_pci_err_handler = {
> +	.error_detected	= amdgpu_pci_error_detected,
> +	.mmio_enabled	= amdgpu_pci_mmio_enabled,
> +	.slot_reset	= amdgpu_pci_slot_reset,
> +	.resume		= amdgpu_pci_resume,
> +};
> +
>   static struct pci_driver amdgpu_kms_pci_driver = {
>   	.name = DRIVER_NAME,
>   	.id_table = pciidlist,
> @@ -1541,6 +1547,7 @@ static struct pci_driver amdgpu_kms_pci_driver = {
>   	.remove = amdgpu_pci_remove,
>   	.shutdown = amdgpu_pci_shutdown,
>   	.driver.pm = &amdgpu_pm_ops,
> +	.err_handler = &amdgpu_pci_err_handler,
>   };
>   
>   static int __init amdgpu_init(void)
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CDennis.Li%40amd.com%7Cfbaac227eff74bcab03108d849cedd81%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637340500116686286&amp;sdata=lYjIk50kyGIHG7UaAzx%2FswghLD8gc2DdCXUmTNj4EkU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
