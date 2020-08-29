Return-Path: <SRS0=m/vD=CH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D2FC433E2
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Aug 2020 02:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 274EC20838
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Aug 2020 02:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1KsCaq8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274EC20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A540C6E09C;
	Sat, 29 Aug 2020 02:03:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 331726E09C
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Aug 2020 02:03:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWaUwR3vd3Lh3hxraepqhsdWRxQvU2ut3xLyp2swKciNL5ciQOD8b5wnu8m1u+6hYqIKTpndugB64ew5FV0/XG/kREDDxcRCTTt+P0T+UP/Qzcu1KaHYWNggt7nLVv8LjvKlGKHRr0FY5Fjfgr10Ss2WgWF/n6rRBFj7zUMR9EUfq0PhoeYwpqgIJic3X5Xi2ZjNhYmLT2WuJz0nIzjuQvf07mh+3NQ4RiXECJ1FA0uLSXwrB+tcEjZesOlSmhw/Atdg4wzajTXxDLiuRiPavhg3ePM8ThLUJ3hUqaW/j9qrwVbYU+CT+sOb/un+MOBoeXPAfwATI/3YMPd5e3y3Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaCRMgHlCyeTUrPks/vrriDN81cUYLSJl4UbE2+K7ZQ=;
 b=D1S/YbDHR8MGBJtRq0sQMqOyh2BAVix4P25BtkCFyaFZVSoeabVneeG+PFun6uAgNJ0o1DzDje1OHNGJogvRmqFV/hMrrS4ItLJSrkG+gKEACP9oAaILJWHpTfbSx4Eml1ghFdtjThqyoX/x2tJ8X8HWU0XiOpUVEtWMvImY9wmj4SZVku2/J1aH6K/pEzTRJ6WWcnFE3Ttd0jtyV/eP2zAWCShxGPAsM7qdDayJVcg7W99IJm4EZv5ecEqAf3yqtdv+t9W9QeIwFoiHO80DEqAkS4s5RS/NriEuMnCxuT2irklnqP60vccuJG0sGrZUh60OTq/zHGy1U9VwSRd9DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaCRMgHlCyeTUrPks/vrriDN81cUYLSJl4UbE2+K7ZQ=;
 b=1KsCaq8P+vVlk/dSHVyFpARRxXHrkl66+oDs6bnosCPwJsNQYGDeUq4YXN7u1HrkiZu2//W1O4j2H4jkq2kPAZxn3+JPiu3Svyf+HfOTz+835FmL43GkCgnZcthvBKvXFxy1suo1C5E6TaBK/dbtyIqVrauhTf8wOSViQzppeO4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2986.namprd12.prod.outlook.com (2603:10b6:5:39::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Sat, 29 Aug
 2020 02:03:26 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::3452:6d8f:e0ef:b45e%6]) with mapi id 15.20.3305.033; Sat, 29 Aug 2020
 02:03:26 +0000
Subject: Re: [PATCH 2/7] drm/amdgpu: Avoid accessing HW when suspending SW
 state
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598453182-6946-3-git-send-email-andrey.grodzovsky@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <8853be30-b31e-c31f-4bd8-44f191cad1ba@amd.com>
Date: Fri, 28 Aug 2020 22:03:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <1598453182-6946-3-git-send-email-andrey.grodzovsky@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::32) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YT1PR01CA0153.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Sat, 29 Aug 2020 02:03:26 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 59ce3735-5ad4-4a10-3521-08d84bbfb7b3
X-MS-TrafficTypeDiagnostic: DM6PR12MB2986:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB298647FA7E05FE3352C3851499530@DM6PR12MB2986.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GlKCaFtLpqfJLAPeDHJTsdg5f3JN4gK9EQ+QWYM9o3m8F5W7gZaZ7zlzXE7SY26g8kV6VXQkIzItmtCHOZ3gNCYt4hFVB73/I4Q/LgYVoxCRI+nyabsfOZwv9Cl4AqhumGnunvbc0Y7ini4ae+lwSLhy6A/VAZoCeyfhTBQZaM+nVBqQzS+WjGNI6hjpU9EVr1LO7mAD32k+duas1dOOowig0/7cmeKiWXp1t5A4sbYOKOVm90TsojoZlfmX++yEvatAAHRV8MGb5wMV/ZjkRXY0V2P3fR6fXNgXN6OwQ6dc2c+6RW7D1fdZ+LbfJ13uFG2Zp9itiTD4HfQ4jZMY1PjS/xZ/DIyOERQXVJFFP0m826qYUWU0D1oZs8+mmKtmqTAAnhYY6vK9raShpPre2xK8I/DtpkUOEzFlcyiKKYU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(83380400001)(36756003)(2906002)(53546011)(186003)(16576012)(31686004)(8676002)(26005)(8936002)(52116002)(956004)(2616005)(31696002)(30864003)(316002)(66556008)(478600001)(66946007)(66476007)(4326008)(6486002)(5660300002)(44832011)(86362001)(43740500002)(473944003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: qqT4qpdZuqlVlEuYzaDfzGhDIsa8jnosvQhTNRAP8iZ9ADDuVZUZ7X7350afTNIKLvj6Bs0/bienPd7aihDKotw5/wroNjGYO4W8qGAB3QIRZFHgFATGnZOEBZ0u9PUwLyOXdQ6k2hsQXQNBub3ewBY3vij2ic/JoOFNHocBLbxhtxFH1ynFGcMsXa+PMCgG6wkzvL2kRiVtP4A5lfSpxTvKzn7EIkUG0utcYrBAnwtqK5ghLhfP99DB4foyu3qIX98pMVp40rx9KUJcJf3gnTrbu/xEi9aMDUKJnC9qTlg+HXUdyr+e9d835o20+C64gVQvZoyGpWQ4h7SCNwqDk1rfPTy2HtvEfbzS8mHOEV8OPh+soa1kCfYH55qIX3/3I+nF5R5tDjADlrg9LuPuwVkJP/CocGtYXoDNBKrl+e+w+UPWsZiwADztPmwLscGlpEkMqkeuDOiqg7T4dXpUcBdSFTIyF+pDDv0mxuB8lrZXT95lB6KpRPI0kdNz+lbWPReBd61mExxBWDSe9Y7XUeOWMmneZa0Ts64PRH78iiOFmpJmGcUEBB8Otq6mMA94gdwypnblojUy/sXTCXwXeYdChzo+I6c9FlJf3V/FEQ6YArdqMGTWl9vunzonEh67QKT1ffghbJQf/Cj4ieaTUA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ce3735-5ad4-4a10-3521-08d84bbfb7b3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2020 02:03:26.7076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7qH5P1SN1D7y6Z6k7rR8BiUvCwNfGZOHX4/9aHtOR1KLXe2yEJ5a9lvYPKfYFxJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2986
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-08-26 10:46, Andrey Grodzovsky wrote:
> At this point the ASIC is already post reset by the HW/PSP
> so the HW not in proper state to be configured for suspension,
> some bloks might be even gated and so best is to avoid touching it.

"blocks"

> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  6 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  6 +++++
>  drivers/gpu/drm/amd/amdgpu/atom.c          |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 18 +++++++++------
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  |  3 +++
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c     |  3 +++
>  8 files changed, 64 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3399242..3489622 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -992,6 +992,7 @@ struct amdgpu_device {
>  	atomic_t			throttling_logging_enabled;
>  	struct ratelimit_state		throttling_logging_rs;
>  	uint32_t			ras_features;
> +	bool                            in_dpc;
>  };

This is very cryptic and if we do that, in 10 years,
the code will be full of cryptic variables and comments.

Better to add a comment

	bool				in_dpc; /* PCI Downstream Port Containment */

>  
>  static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 84f8d14..e1bbefd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -319,6 +319,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>  {
>  	uint32_t ret;
>  
> +	if (adev->in_dpc)
> +		return 0;
> +
>  	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>  		return amdgpu_kiq_rreg(adev, reg);
>  
> @@ -350,8 +353,10 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>   *
>   * Returns the 8 bit value from the offset specified.
>   */
> -uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
> -{
> +uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
> +
> +	if (adev->in_dpc)
> +		return 0;
>  
>  	if (offset < adev->rmmio_size)
>  		return (readb(adev->rmmio + offset));
> @@ -373,8 +378,10 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
>   *
>   * Writes the value specified to the offset specified.
>   */
> -void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
> -{
> +void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value) {
> +
> +	if (adev->in_dpc)
> +		return;
>  
>  	if (offset < adev->rmmio_size)
>  		writeb(value, adev->rmmio + offset);
> @@ -384,6 +391,8 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
>  
>  void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t acc_flags)
>  {
> +	if (adev->in_dpc)
> +		return;
>  
>  	trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
>  
> @@ -412,6 +421,8 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
>  void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>  		    uint32_t acc_flags)
>  {
> +	if (adev->in_dpc)
> +		return;
>  
>  	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>  		return amdgpu_kiq_wreg(adev, reg, v);
> @@ -427,6 +438,9 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>  void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>  		    uint32_t acc_flags)
>  {
> +	if (adev->in_dpc)
> +		return;
> +
>  	if (amdgpu_sriov_fullaccess(adev) &&
>  		adev->gfx.rlc.funcs &&
>  		adev->gfx.rlc.funcs->is_rlcg_access_range) {
> @@ -448,6 +462,9 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t
>   */
>  u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
>  {
> +	if (adev->in_dpc)
> +		return 0;
> +
>  	if ((reg * 4) < adev->rio_mem_size)
>  		return ioread32(adev->rio_mem + (reg * 4));
>  	else {
> @@ -467,6 +484,8 @@ u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
>   */
>  void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
>  {
> +	if (adev->in_dpc)
> +		return;
>  
>  	if ((reg * 4) < adev->rio_mem_size)
>  		iowrite32(v, adev->rio_mem + (reg * 4));
> @@ -487,6 +506,8 @@ void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
>   */
>  u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>  {
> +	if (adev->in_dpc)
> +		return 0;
>  
>  	if (index < adev->doorbell.num_doorbells) {
>  		return readl(adev->doorbell.ptr + index);
> @@ -508,6 +529,8 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>   */
>  void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>  {
> +	if (adev->in_dpc)
> +		return;
>  
>  	if (index < adev->doorbell.num_doorbells) {
>  		writel(v, adev->doorbell.ptr + index);
> @@ -527,6 +550,8 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>   */
>  u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>  {
> +	if (adev->in_dpc)
> +		return 0;
>  
>  	if (index < adev->doorbell.num_doorbells) {
>  		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
> @@ -548,6 +573,8 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>   */
>  void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>  {
> +	if (adev->in_dpc)
> +			return;
>  
>  	if (index < adev->doorbell.num_doorbells) {
>  		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
> @@ -4790,7 +4817,9 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>  
>  	pci_restore_state(pdev);
>  
> +	adev->in_dpc = true;
>  	r = amdgpu_device_ip_suspend(adev);
> +	adev->in_dpc = false;
>  	if (r)
>  		goto out;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index d698142..50c42c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -693,6 +693,9 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
>  	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>  	struct amdgpu_ring *ring = &kiq->ring;
>  
> +	if (adev->in_dpc)
> +		return 0;
> +
>  	BUG_ON(!ring->funcs->emit_rreg);
>  
>  	spin_lock_irqsave(&kiq->ring_lock, flags);
> @@ -757,6 +760,9 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
>  
>  	BUG_ON(!ring->funcs->emit_wreg);
>  
> +	if (adev->in_dpc)
> +		return;
> +

Don't know how I feel about such "architecture",
where we introduce a flag-type variable and check it
in a slew of places. If we did this a few times over,
we'd have a few flags which we check almost everywhere,
and it would make the code difficult to analyze.
For instance, which flag to check first? Or, how
are flags related to each other.

There has to be a better way, where we check
that flag only once before proceeding. A more
unified approach.

>  	spin_lock_irqsave(&kiq->ring_lock, flags);
>  	amdgpu_ring_alloc(ring, 32);
>  	amdgpu_ring_emit_wreg(ring, reg, v);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index d6c38e2..555ef59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -219,6 +219,9 @@ int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
>  	int i;
>  	struct amdgpu_device *adev = psp->adev;
>  
> +	if (psp->adev->in_dpc)
> +		return 0;
> +
>  	for (i = 0; i < adev->usec_timeout; i++) {
>  		val = RREG32(reg_index);
>  		if (check_changed) {
> @@ -245,6 +248,9 @@ psp_cmd_submit_buf(struct psp_context *psp,
>  	bool ras_intr = false;
>  	bool skip_unsupport = false;
>  
> +	if (psp->adev->in_dpc)
> +		return 0;
> +
>  	mutex_lock(&psp->mutex);
>  
>  	memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
> index 4cfc786..613dac1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -750,6 +750,7 @@ static void atom_op_jump(atom_exec_context *ctx, int *ptr, int arg)
>  					DRM_ERROR("atombios stuck in loop for more than %dsecs aborting\n",
>  						  ATOM_CMD_TIMEOUT_SEC);
>  					ctx->abort = true;
> +					dump_stack();
>  				}
>  			} else {
>  				/* jiffies wrap around we will just wait a little longer */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 2db195e..86f268e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6980,15 +6980,19 @@ static int gfx_v10_0_hw_fini(void *handle)
>  
>  	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>  	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> +
> +	if (!adev->in_dpc) {
>  #ifndef BRING_UP_DEBUG
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
>  #endif
> -	if (amdgpu_gfx_disable_kcq(adev))
> -		DRM_ERROR("KCQ disable failed\n");
> +		if (amdgpu_gfx_disable_kcq(adev))
> +			DRM_ERROR("KCQ disable failed\n");
> +	}
> +
>  	if (amdgpu_sriov_vf(adev)) {
>  		gfx_v10_0_cp_gfx_enable(adev, false);
>  		/* Program KIQ position of RLC_CP_SCHEDULERS during destroy */
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 8462b30..306461d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -224,9 +224,12 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
>  {
>  	int ret = 0;
>  
> +
>  	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>  		return -EOPNOTSUPP;
>  
> +
> +

Unnecessary white space changes.

Regards,
Luben

>  	switch (block_type) {
>  	/*
>  	 * Some legacy code of amdgpu_vcn.c and vcn_v2*.c still uses
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index a58ea08..02cf55e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -112,6 +112,9 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>  	struct amdgpu_device *adev = smu->adev;
>  	int ret = 0, index = 0;
>  
> +	if (smu->adev->in_dpc)
> +		return 0;
> +
>  	index = smu_cmn_to_asic_specific_index(smu,
>  					       CMN2ASIC_MAPPING_MSG,
>  					       msg);
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
