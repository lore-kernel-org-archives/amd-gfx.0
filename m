Return-Path: <SRS0=hFGi=CM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16C5C433E2
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 01:32:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77DDA20665
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2020 01:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S0Aztd1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DDA20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C0826E123;
	Thu,  3 Sep 2020 01:32:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FB726E123
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2020 01:32:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gM2H6ALseUBSpYmMYj/SVwcZeA1ppjKqetXP3cGkNrMqUgCTLKE4v7FGRQa4ESXtxY51CAw0jWTgo3Zgkp/PlwHjU8tmZo0C3AH3zNTdpLWxSE4M/bzAiRZlazK4ryy9ayi+bgduOVwl/9yqJ14NFhFPTtTOeGzqXMcTPxxmgyJJ05mmGABToIntSZEGWnTQS3n3gahqZBztawDsPc6ZoGKZCOpEZfeHyVAjGfymCjhIbuo7kBP8MLYCEnYcjuITFzEYgNqTGtr+RYX+sz7hP48ND5R21xDK8PhZu4pLarD54lD1XRX2iTI1igti49dktXRxaYYfLE+gLWOLdZV3PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tmek/PDw32JYCR1MmmgstXRSzJ/cCuShjhVzD8klsMs=;
 b=KnwhaIeyf7+QXoB3gz94bCef+7p1xteAsWeSfXaGVHdaNHlyUmQiZf57FFGc+9XkOCwCVlW20fgUBU3MwfAn8aP0jkmlewWJ5xQOi7hcc+mLsRX0f/tAT9APVz1d2Qe5JvIEwjI69jqPjPmN4FS4KInpbGDtLNlWqADJj7WcyA7rh3EoxFHWhJUdQ+aXLoJW6xgkZ+4f53VkE1c3BBmHoCRTO72ZIVlIRZ2EQ94S4FcoAOzQ5ZusHHln7+yIlbhc9L7bRaKADBwA4xe8o35VeKmgDHHoiqsixa1PpFjfdL+HJHbz+/BHxtZtJHVdfigE3FvVcmNiMDPqZ2j1krP4FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tmek/PDw32JYCR1MmmgstXRSzJ/cCuShjhVzD8klsMs=;
 b=S0Aztd1FrplGTTxTHF/d0Tr+XkeRClrNEc8JiC0ejq0bkSqLnoAO065/qryZ9WplcnPc+cIDiN1gTz9OyLXGRT1eGN5sB/Bu/Wb7ySiLjvSZLsLUSh8hw/C14xJ4KrNN7cUyGKScCRFCLagE4bU2oeyjbvh1Wtvu5eSFhrC56OM=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM5PR1201MB0010.namprd12.prod.outlook.com (2603:10b6:3:e3::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.23; Thu, 3 Sep 2020 01:32:49 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63%7]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 01:32:49 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "sathyanarayanan.kuppuswamy@linux.intel.com"
 <sathyanarayanan.kuppuswamy@linux.intel.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v4 1/8] drm/amdgpu: Avoid accessing HW when suspending SW
 state
Thread-Topic: [PATCH v4 1/8] drm/amdgpu: Avoid accessing HW when suspending SW
 state
Thread-Index: AQHWgVjWCRPQDj2DlEejzC07GxNWHqlWHzxg
Date: Thu, 3 Sep 2020 01:32:49 +0000
Message-ID: <DM5PR12MB2533B29C96B7FEA22FC55097ED2C0@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
 <1599072130-10043-2-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1599072130-10043-2-git-send-email-andrey.grodzovsky@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-03T01:32:42Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=17886d74-2f27-4a01-a778-68034949421c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e22f838d-7eea-49c4-092d-08d84fa944c9
x-ms-traffictypediagnostic: DM5PR1201MB0010:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0010744A111F88B288760D00ED2C0@DM5PR1201MB0010.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:398;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1X3SSVDLgc7/aSzliFGDNR0lkz/iymQx8eJuYzjqQ5wsAdBt0eYjxmHonwk4WPptKvU4iiPJa6csxHBnyiTUabLdYH6UAmRiZxzQjeU9qIWflje0oWUHmcJNs79PmkIKEJ7XTJ9ZTWCan1/rGhu4LhgU3swwYvby4nXqgCmBY5NEALZ2AtppbPcZ72GjH9x/MNa++SKbxEEOVzZ3rMUXTB5qPUmhU/d6+fLW7lmw8PFXOhS1VYFClNtzYZFqiJ37FUZPCY0yhUbc5FvyB6ErKdqGCexQp0uPsYGieZtFloA4oCTDaplApQ1rtShqI1VojFrCbn5+rGY65UZVTT58Rw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39850400004)(6506007)(53546011)(66946007)(7696005)(71200400001)(52536014)(15650500001)(316002)(9686003)(478600001)(2906002)(66556008)(110136005)(66476007)(186003)(86362001)(83380400001)(26005)(64756008)(5660300002)(55016002)(8676002)(4326008)(66446008)(76116006)(54906003)(8936002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: DaPrFrrvte7UfnPfwaB1w3kjEzy3RiVpIMUCakFYCluU7l7cjz6aGrK+MGF5z04YfBKaZHG6w4LgTA7SAfRU9dKtvmc0d+a+owa6LYicSqu3FS6YlubTzrm89ZvWseCxwwt484WMO5M7pAaMEZWWxi7pPIApyyPRtvdDX4r2R6NVFSlCT5ruVluAA7dbcGiKyxyxPP/8BUecBJoJvc5GD3aXXPMgZWjgaydK7c4EdO2ishHdPae2RdfEYfSl0FnnzguAX+CmAaHvt3NroTrQ/uvvm7Lltv9F3O1A7GOpYk2OwL+dqOFm0dd1kXU0nAU0lUv96wrW1eJRzdrgNaCVPQZ3MfhRWJuccWUbxRSvU+DiWyGKjH8FQFSgMz8AMLaiCmrFieGAoD3BvFXVb5FZp+/5VHXpxentg0zwGOTc/8BUfAFfIfzt2IPTI54D7jA8mqfjz8Tcc+dz476G7HTHTjC5kUxXsL/EkjPpwUCvFwVmOqGpnepjghT/wf0J5Vz44Oe3MCK5OwX+VyF9WnYcGJF77i04tGEwRWslzRQmxfwXuPMgppm6frYKEM+oK+y9a/YcCK1mUZsa2WvQ2LfH7L6HbhTEPCNYU6rkrVjZm7a0by8jyhN2QQPNyXZCoUS+6zlZAQIN2OGs8oWBf2DkRw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22f838d-7eea-49c4-092d-08d84fa944c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 01:32:49.2449 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q7SJOo/WfJgHHv13GOj/pOdEo2Cshw+vvQr7SVs5GsCP49fcOi5JCTtms0eYwIaN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0010
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Das,
 Nirmoy" <Nirmoy.Das@amd.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi, andrey

Did you want to use adev->in_pci_err_recovery to avoid hardware accessed by other threads when doing PCI recovery? If so, it is better to change to use lock protect them. This patch can't solve your issue completely. 

Best Regards
Dennis Li
-----Original Message-----
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com> 
Sent: Thursday, September 3, 2020 2:42 AM
To: amd-gfx@lists.freedesktop.org; sathyanarayanan.kuppuswamy@linux.intel.com; linux-pci@vger.kernel.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Das, Nirmoy <Nirmoy.Das@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; bhelgaas@google.com; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
Subject: [PATCH v4 1/8] drm/amdgpu: Avoid accessing HW when suspending SW state

At this point the ASIC is already post reset by the HW/PSP so the HW not in proper state to be configured for suspension, some blocks might be even gated and so best is to avoid touching it.

v2: Rename in_dpc to more meaningful name

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  6 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    |  6 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 18 ++++++++------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c     |  3 +++
 6 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c311a3c..b20354f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -992,6 +992,7 @@ struct amdgpu_device {
 	atomic_t			throttling_logging_enabled;
 	struct ratelimit_state		throttling_logging_rs;
 	uint32_t			ras_features;
+	bool                            in_pci_err_recovery;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 74a1c03..1fbf8a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -319,6 +319,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,  {
 	uint32_t ret;
 
+	if (adev->in_pci_err_recovery)
+		return 0;
+
 	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
 		return amdgpu_kiq_rreg(adev, reg);
 
@@ -351,6 +354,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
  * Returns the 8 bit value from the offset specified.
  */
 uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
+	if (adev->in_pci_err_recovery)
+		return 0;
+
 	if (offset < adev->rmmio_size)
 		return (readb(adev->rmmio + offset));
 	BUG();
@@ -372,6 +378,9 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
  * Writes the value specified to the offset specified.
  */
 void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value) {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	if (offset < adev->rmmio_size)
 		writeb(value, adev->rmmio + offset);
 	else
@@ -382,6 +391,9 @@ static inline void amdgpu_mm_wreg_mmio(struct amdgpu_device *adev,
 				       uint32_t reg, uint32_t v,
 				       uint32_t acc_flags)
 {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
 
 	if ((reg * 4) < adev->rmmio_size)
@@ -409,6 +421,9 @@ static inline void amdgpu_mm_wreg_mmio(struct amdgpu_device *adev,  void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 		    uint32_t acc_flags)
 {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
 		return amdgpu_kiq_wreg(adev, reg, v);
 
@@ -423,6 +438,9 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,  void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 		    uint32_t acc_flags)
 {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	if (amdgpu_sriov_fullaccess(adev) &&
 		adev->gfx.rlc.funcs &&
 		adev->gfx.rlc.funcs->is_rlcg_access_range) { @@ -444,6 +462,9 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t
  */
 u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)  {
+	if (adev->in_pci_err_recovery)
+		return 0;
+
 	if ((reg * 4) < adev->rio_mem_size)
 		return ioread32(adev->rio_mem + (reg * 4));
 	else {
@@ -463,6 +484,9 @@ u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
  */
 void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)  {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	if ((reg * 4) < adev->rio_mem_size)
 		iowrite32(v, adev->rio_mem + (reg * 4));
 	else {
@@ -482,6 +506,9 @@ void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
  */
 u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)  {
+	if (adev->in_pci_err_recovery)
+		return 0;
+
 	if (index < adev->doorbell.num_doorbells) {
 		return readl(adev->doorbell.ptr + index);
 	} else {
@@ -502,6 +529,9 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
  */
 void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)  {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	if (index < adev->doorbell.num_doorbells) {
 		writel(v, adev->doorbell.ptr + index);
 	} else {
@@ -520,6 +550,9 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
  */
 u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)  {
+	if (adev->in_pci_err_recovery)
+		return 0;
+
 	if (index < adev->doorbell.num_doorbells) {
 		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
 	} else {
@@ -540,6 +573,9 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
  */
 void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)  {
+	if (adev->in_pci_err_recovery)
+		return;
+
 	if (index < adev->doorbell.num_doorbells) {
 		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
 	} else {
@@ -4773,7 +4809,9 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 
 	pci_restore_state(pdev);
 
+	adev->in_pci_err_recovery = true;
 	r = amdgpu_device_ip_suspend(adev);
+	adev->in_pci_err_recovery = false;
 	if (r)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index d698142..8c9bacf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -693,6 +693,9 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device *adev, uint32_t reg)
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 	struct amdgpu_ring *ring = &kiq->ring;
 
+	if (adev->in_pci_err_recovery)
+		return 0;
+
 	BUG_ON(!ring->funcs->emit_rreg);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags); @@ -757,6 +760,9 @@ void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v)
 
 	BUG_ON(!ring->funcs->emit_wreg);
 
+	if (adev->in_pci_err_recovery)
+		return;
+
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 	amdgpu_ring_alloc(ring, 32);
 	amdgpu_ring_emit_wreg(ring, reg, v);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d6c38e2..a7771aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -219,6 +219,9 @@ int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
 	int i;
 	struct amdgpu_device *adev = psp->adev;
 
+	if (psp->adev->in_pci_err_recovery)
+		return 0;
+
 	for (i = 0; i < adev->usec_timeout; i++) {
 		val = RREG32(reg_index);
 		if (check_changed) {
@@ -245,6 +248,9 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	bool ras_intr = false;
 	bool skip_unsupport = false;
 
+	if (psp->adev->in_pci_err_recovery)
+		return 0;
+
 	mutex_lock(&psp->mutex);
 
 	memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE); diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 2db195e..ccf096c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6980,15 +6980,19 @@ static int gfx_v10_0_hw_fini(void *handle)
 
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+
+	if (!adev->in_pci_err_recovery) {
 #ifndef BRING_UP_DEBUG
-	if (amdgpu_async_gfx_ring) {
-		r = gfx_v10_0_kiq_disable_kgq(adev);
-		if (r)
-			DRM_ERROR("KGQ disable failed\n");
-	}
+		if (amdgpu_async_gfx_ring) {
+			r = gfx_v10_0_kiq_disable_kgq(adev);
+			if (r)
+				DRM_ERROR("KGQ disable failed\n");
+		}
 #endif
-	if (amdgpu_gfx_disable_kcq(adev))
-		DRM_ERROR("KCQ disable failed\n");
+		if (amdgpu_gfx_disable_kcq(adev))
+			DRM_ERROR("KCQ disable failed\n");
+	}
+
 	if (amdgpu_sriov_vf(adev)) {
 		gfx_v10_0_cp_gfx_enable(adev, false);
 		/* Program KIQ position of RLC_CP_SCHEDULERS during destroy */ diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index a58ea08..97aa72a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -112,6 +112,9 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0, index = 0;
 
+	if (smu->adev->in_pci_err_recovery)
+		return 0;
+
 	index = smu_cmn_to_asic_specific_index(smu,
 					       CMN2ASIC_MAPPING_MSG,
 					       msg);
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
