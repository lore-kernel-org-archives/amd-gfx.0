Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A864C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 16:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D72F2074A
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 16:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Tj2UR2dj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D72F2074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E680B6E1DE;
	Wed, 26 Aug 2020 16:49:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E36276E1DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 16:49:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bulzm1ihND0oVUmKX/+SSSSDAjuJveqtQqNwqsDxW0ItdM7PjvZpb4uBt40JoVHDM8x2my5t21HRBHxhYPSLGeS6g9PWDyPoGGpkVhHGMIc4i/Yt/f3NYEqhVe+0cj7U3/Z6lUDByZZLYfIRdRqEASvGSVxBqaeW0mU/5ijl2UVxbFeKD332NxhYhxHJv6UeusL8tehm+Twto+YlEYF0cgDbPAdw4VAS+bUfrQF75TzmkAIrfRo5EKmQ2sGYL8W+cLVIfwCR0OX8gMwM2HD5ZB73TgU3B/wbe8IJX1yyWMMQdcA989qPLbBLZyEtTeElh6xoFysgFaJq1nN26dTUmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeczTMCR/KpPTnwOKZGgRhbInWyExNA/BGLrZnW0rvY=;
 b=T4JChmTW9lfmxBG+LWyXFFeJ3GevAMqdr832zR6cRonqFuphxmwV3kbyq3qiFCBnHqssetBVpALaf2sYo5hsV5b3gODSp7pazcNV+PSRnnjfZiUhy1u5OsVbJLssEhqoPqU33fcTHSs39grCwpmwIEy5uUW0x8vtkTTQPH92RQJ8gaaDNvct9sWlCk6/QpEXRVEepe8O3/IlOBAhfybaZz2Gc00oWY0n84Xb7R35PKoFm6Xb9v8ydjb/BOY9L0ynIsS5AAmfSdkGvBR2/8yLh/EWb72sotPv46rn6tuWhp8Jdg6bjObu690qJZc5S5Ljh1cDo769R6iws79Qb1yTFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeczTMCR/KpPTnwOKZGgRhbInWyExNA/BGLrZnW0rvY=;
 b=Tj2UR2djaqb3FWB7KeyKNOrTzja3GjUvcbd4RC1mwH/zhAtIuHn+/nZDfEY8ohNq5O31wJAYYQd/EsAqXIXKZtYNCPUte8Hf4XP4dRd4e1ylg9tUzwYdE7ZUi4SwGd4rfXhcUEK8hqdZ0rFTNyk/3iZ1FVhpkxqkxMnS2S6eQok=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3068.namprd12.prod.outlook.com (2603:10b6:5:3e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Wed, 26 Aug
 2020 16:49:14 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 16:49:14 +0000
Subject: Re: [PATCH 2/7] drm/amdgpu: Avoid accessing HW when suspending SW
 state
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598453182-6946-3-git-send-email-andrey.grodzovsky@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <80923c3f-93a3-661f-056a-9cd1836b5a0d@amd.com>
Date: Wed, 26 Aug 2020 18:53:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <1598453182-6946-3-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:404:13e::18) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 BN6PR13CA0032.namprd13.prod.outlook.com (2603:10b6:404:13e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend
 Transport; Wed, 26 Aug 2020 16:49:13 +0000
X-Originating-IP: [93.229.42.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 794da3eb-9116-416b-d329-08d849dff69a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3068:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB30684DDB26BE42F24FA259C68B540@DM6PR12MB3068.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+KorFvXz8mrJTwnaAM6JKQbNZRTyG6QDKcPQi/wcY7o0V1m8S3quewku91puI++83ozLF5mcwkR2rmVjTQNLvSqlW3rPFGiDk6klAwcOFI4B/01R8VXVBKCkJGWM+s4PQVFVK4W8wwHaYgKbGC0fdAKd4ZhEHukEkHQwNjIwuQcJgNqcgGn/ltSgYb/wb6q59OLoKg+qn/0LtSZCzjWFz2PxZfK2GlGIEfUCs/Td1Do9H7wD4zZyoqj+ndKkLGfa0B2Gc56QgB8r5q0kagaQkUzdNBYmr+u4Stujdn82VvY5/MBLtidPHWRQW+IhpVTjDYw/0pgcFWxebqCgvPXomzmkTbVhuqXEvsa5FpqD08rDU1pigMFb8xqNn9KVG7AH95PUj+cg4cqE7wBs7IYMz/OwPFuCso+2Fz0uCcXWTU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(5660300002)(66946007)(66476007)(66556008)(8936002)(186003)(478600001)(316002)(2616005)(52116002)(956004)(36756003)(16576012)(31686004)(2906002)(8676002)(83380400001)(4326008)(6486002)(31696002)(26005)(53546011)(43740500002)(473944003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: BBzE5EACBkT3XgKsxN+5JlrCVEjHsBiUsQGsAnI4Cat4wy7veHBQqlc35EgvRbIsHNKTRU/vQJqI4SoNvfl3VLUdGphr2Br11W6sRxSc8RV0vFh1snfWMmBUhqaKo8Va0MIk45kW8BtS90UPy1dRcim7j8m+b3KT6w4vmGKFzJXrMreVOOd0E301AelozuO6U2gOK0KFAQ+EtgEUpeT1cEJQp1oG8IsINxaoh95hjtGO2xnDKUj/F3wV/230WZImXIl1akjfvNVU9XNj7JHsVXWZaCmMXn3yu6MJwIrXygIbXSmZ/9r7AOKLmAB7CJuFVHQDsf1bXQ0yK9x5N5HlSjNeNltETijpExq1dlnG2d2sdEdpy86jnioVkPG/bpORN7/4mvTgS0+nLiBnTNJO7bR+Xwj51BFGqW4KuYKkL/Pk+gwu19W5hB6WtTn+ZWyHycNSU0GKJ4lub0y/T8uiXGXTzTmFS9LQWgb7lKI8GaxU+WxL/AmtPgW4/6hg6ZZHlg3LRu4ZVQ6Htdi7J3aLoxnoh+yq8aGlJdnwMensUOIwIi5Bf0hTenMUwl4k5NGWkkFV+goH992xF3UPd5NOOxtZhNG9BrcawSPm/NZPev1kcPupfiqw6iMK3ynk90t1gXcw542lbhEeyY8xJzHifA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 794da3eb-9116-416b-d329-08d849dff69a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 16:49:13.9050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bx9QbdXP5EqQV1sDw8TiLFByG1UoFm59JBo+7di/olgl+qwStUUa+dfQSGpBAU78x0sJiKlPByx4V0HwUTVRUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3068
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
Cc: alexander.deucher@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 8/26/20 4:46 PM, Andrey Grodzovsky wrote:
> At this point the ASIC is already post reset by the HW/PSP
> so the HW not in proper state to be configured for suspension,
> some bloks might be even gated and so best is to avoid touching it.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  6 +++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  6 +++++
>   drivers/gpu/drm/amd/amdgpu/atom.c          |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 18 +++++++++------
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  |  3 +++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c     |  3 +++
>   8 files changed, 64 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3399242..3489622 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -992,6 +992,7 @@ struct amdgpu_device {
>   	atomic_t			throttling_logging_enabled;
>   	struct ratelimit_state		throttling_logging_rs;
>   	uint32_t			ras_features;
> +	bool                            in_dpc;


We should have more generic name instead of "in_dpc", may be 
"in_pci_error" ?


Nirmoy


>   };
>   
>   static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 84f8d14..e1bbefd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -319,6 +319,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>   {
>   	uint32_t ret;
>   
> +	if (adev->in_dpc)
> +		return 0;
> +
>   	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>   		return amdgpu_kiq_rreg(adev, reg);
>   
> @@ -350,8 +353,10 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>    *
>    * Returns the 8 bit value from the offset specified.
>    */
> -uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
> -{
> +uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
> +
> +	if (adev->in_dpc)
> +		return 0;
>   
>   	if (offset < adev->rmmio_size)
>   		return (readb(adev->rmmio + offset));
> @@ -373,8 +378,10 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
>    *
>    * Writes the value specified to the offset specified.
>    */
> -void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
> -{
> +void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value) {
> +
> +	if (adev->in_dpc)
> +		return;
>   
>   	if (offset < adev->rmmio_size)
>   		writeb(value, adev->rmmio + offset);
> @@ -384,6 +391,8 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
>   
>   void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t acc_flags)
>   {
> +	if (adev->in_dpc)
> +		return;
>   
>   	trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
>   
> @@ -412,6 +421,8 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
>   void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>   		    uint32_t acc_flags)
>   {
> +	if (adev->in_dpc)
> +		return;
>   
>   	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>   		return amdgpu_kiq_wreg(adev, reg, v);
> @@ -427,6 +438,9 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>   void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>   		    uint32_t acc_flags)
>   {
> +	if (adev->in_dpc)
> +		return;
> +
>   	if (amdgpu_sriov_fullaccess(adev) &&
>   		adev->gfx.rlc.funcs &&
>   		adev->gfx.rlc.funcs->is_rlcg_access_range) {
> @@ -448,6 +462,9 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t
>    */
>   u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
>   {
> +	if (adev->in_dpc)
> +		return 0;
> +
>   	if ((reg * 4) < adev->rio_mem_size)
>   		return ioread32(adev->rio_mem + (reg * 4));
>   	else {
> @@ -467,6 +484,8 @@ u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
>    */
>   void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
>   {
> +	if (adev->in_dpc)
> +		return;
>   
>   	if ((reg * 4) < adev->rio_mem_size)
>   		iowrite32(v, adev->rio_mem + (reg * 4));
> @@ -487,6 +506,8 @@ void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
>    */
>   u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>   {
> +	if (adev->in_dpc)
> +		return 0;
>   
>   	if (index < adev->doorbell.num_doorbells) {
>   		return readl(adev->doorbell.ptr + index);
> @@ -508,6 +529,8 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>    */
>   void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>   {
> +	if (adev->in_dpc)
> +		return;
>   
>   	if (index < adev->doorbell.num_doorbells) {
>   		writel(v, adev->doorbell.ptr + index);
> @@ -527,6 +550,8 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>    */
>   u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>   {
> +	if (adev->in_dpc)
> +		return 0;
>   
>   	if (index < adev->doorbell.num_doorbells) {
>   		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
> @@ -548,6 +573,8 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>    */
>   void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>   {
> +	if (adev->in_dpc)
> +			return;
>   
>   	if (index < adev->doorbell.num_doorbells) {
>   		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
> @@ -4790,7 +4817,9 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>   
>   	pci_restore_state(pdev);
>   
> +	adev->in_dpc = true;
>   	r = amdgpu_device_ip_suspend(adev);
> +	adev->in_dpc = false;
>   	if (r)
>   		goto out;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index d698142..50c42c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -693,6 +693,9 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
>   	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>   	struct amdgpu_ring *ring = &kiq->ring;
>   
> +	if (adev->in_dpc)
> +		return 0;
> +
>   	BUG_ON(!ring->funcs->emit_rreg);
>   
>   	spin_lock_irqsave(&kiq->ring_lock, flags);
> @@ -757,6 +760,9 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
>   
>   	BUG_ON(!ring->funcs->emit_wreg);
>   
> +	if (adev->in_dpc)
> +		return;
> +
>   	spin_lock_irqsave(&kiq->ring_lock, flags);
>   	amdgpu_ring_alloc(ring, 32);
>   	amdgpu_ring_emit_wreg(ring, reg, v);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index d6c38e2..555ef59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -219,6 +219,9 @@ int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
>   	int i;
>   	struct amdgpu_device *adev = psp->adev;
>   
> +	if (psp->adev->in_dpc)
> +		return 0;
> +
>   	for (i = 0; i < adev->usec_timeout; i++) {
>   		val = RREG32(reg_index);
>   		if (check_changed) {
> @@ -245,6 +248,9 @@ psp_cmd_submit_buf(struct psp_context *psp,
>   	bool ras_intr = false;
>   	bool skip_unsupport = false;
>   
> +	if (psp->adev->in_dpc)
> +		return 0;
> +
>   	mutex_lock(&psp->mutex);
>   
>   	memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
> index 4cfc786..613dac1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -750,6 +750,7 @@ static void atom_op_jump(atom_exec_context *ctx, int *ptr, int arg)
>   					DRM_ERROR("atombios stuck in loop for more than %dsecs aborting\n",
>   						  ATOM_CMD_TIMEOUT_SEC);
>   					ctx->abort = true;
> +					dump_stack();
>   				}
>   			} else {
>   				/* jiffies wrap around we will just wait a little longer */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 2db195e..86f268e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6980,15 +6980,19 @@ static int gfx_v10_0_hw_fini(void *handle)
>   
>   	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>   	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> +
> +	if (!adev->in_dpc) {
>   #ifndef BRING_UP_DEBUG
> -	if (amdgpu_async_gfx_ring) {
> -		r = gfx_v10_0_kiq_disable_kgq(adev);
> -		if (r)
> -			DRM_ERROR("KGQ disable failed\n");
> -	}
> +		if (amdgpu_async_gfx_ring) {
> +			r = gfx_v10_0_kiq_disable_kgq(adev);
> +			if (r)
> +				DRM_ERROR("KGQ disable failed\n");
> +		}
>   #endif
> -	if (amdgpu_gfx_disable_kcq(adev))
> -		DRM_ERROR("KCQ disable failed\n");
> +		if (amdgpu_gfx_disable_kcq(adev))
> +			DRM_ERROR("KCQ disable failed\n");
> +	}
> +
>   	if (amdgpu_sriov_vf(adev)) {
>   		gfx_v10_0_cp_gfx_enable(adev, false);
>   		/* Program KIQ position of RLC_CP_SCHEDULERS during destroy */
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 8462b30..306461d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -224,9 +224,12 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
>   {
>   	int ret = 0;
>   
> +
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
> +
> +
>   	switch (block_type) {
>   	/*
>   	 * Some legacy code of amdgpu_vcn.c and vcn_v2*.c still uses
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index a58ea08..02cf55e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -112,6 +112,9 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>   	struct amdgpu_device *adev = smu->adev;
>   	int ret = 0, index = 0;
>   
> +	if (smu->adev->in_dpc)
> +		return 0;
> +
>   	index = smu_cmn_to_asic_specific_index(smu,
>   					       CMN2ASIC_MAPPING_MSG,
>   					       msg);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
