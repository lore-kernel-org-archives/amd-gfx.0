Return-Path: <SRS0=sNMb=MA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33CAC07E9C
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jul 2021 11:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A654461184
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jul 2021 11:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A654461184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66EFF6E0A8;
	Thu,  8 Jul 2021 11:55:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 175EF6E0A8
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jul 2021 11:55:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdNOaDJZGRFYUTQlhSDHhoKgL2fldUba7oi9DD/gKsY96ZpulEt12bejXQxOoC9y0ou06aoZhXCVhCxSVF+STvSkaqprPLEA9aKmTtvrBHR2Y98+Ug63cb/VbzCBRd3Sqhcuc7wmwGNjQfKSeqRkTA/E7dzd9oy/rKyjy2HgpdKPV0pHK00+pOlOQPMzFPVE/2sahGTevzKb/wTnPAdvA3ROUIgEwSzSlQaO5TwUGLtQxVGGp53gsqb5kS4JOPt8ZMssy45FjNHbh0rkGepOEzMg73XOuXymigCcmK3PH4TtfUi/SYM4rM1ByaXadxwfTPHADpLq1XTQJKBGkw7K0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aAND3iwpUbn1idNgsRQ83DsjfReI8ndcTxKwj8IJgg=;
 b=RkiaO0afYWM27Yai2TPV45Qn6Kkgl9jfnGadbXvPrJoO/UQOe2a0TrGlIPff9dd4x2Zkv1P4tWgZQ8Go6LQiCv4TfkhiSgWuOmSF+nxrtVQSMftxrHsPFZzS+fyWdGo/szYDFhhYEqCPlbcva/CIFYTvX8YGhcB7YaPEB0+GucbpXfWHJIP43Kcm6sh9f4McVXsUGyo3mRZYtFo72EmgFDWnNgEB46mJI9Yg3NvFUNjj6WrQVLWuADwzPbHyQkq8saptPFHYZ3nHUknLFO1nhWycyEB9GWi2rK1LbPh/Gm31IbCLo7wK4bEFh2BrxeujGt8fjRksGpqGGNsA9a7Rmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aAND3iwpUbn1idNgsRQ83DsjfReI8ndcTxKwj8IJgg=;
 b=UUb9HiDpZRhjhiyalt+kEuEgIgvbEpipDhTfsWG3+y4x/ZCzjNQsNNGlX9KMb/6dvg/W/cjNJ4HD5KJERWN3H9yozpzXmGoDGdDrWaT0Xz9yvQRJQF/i1RknApvQR9aXD/cwkAFMNPIxM/rIGPMjiuccA51DTQ3Mp1PHXlGxdkY=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5092.namprd12.prod.outlook.com (2603:10b6:610:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Thu, 8 Jul
 2021 11:55:01 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068%9]) with mapi id 15.20.4308.021; Thu, 8 Jul 2021
 11:55:01 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v5] drm/amdgpu: Restore msix after FLR
Thread-Topic: [PATCH v5] drm/amdgpu: Restore msix after FLR
Thread-Index: AQHXcu9SEde/uN508UGjD9G1rVjOsqs4+Vog
Date: Thu, 8 Jul 2021 11:55:01 +0000
Message-ID: <CH0PR12MB53484E8EF8E9A65A331C9F0997199@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210707051642.26704-1-PengJu.Zhou@amd.com>
In-Reply-To: <20210707051642.26704-1-PengJu.Zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-08T11:54:57Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=fb58e026-e13b-4b27-9f98-473370d6e398;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86467b99-3ad2-4538-14a9-08d942073791
x-ms-traffictypediagnostic: CH0PR12MB5092:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5092D04B13104AD35E40835397199@CH0PR12MB5092.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:243;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XcH0xoWotzFRdOBKMuiAlPQCoYoLXRl2i0+P47byXzVLggn94UEo6PaBxwBTf949Akx0gjNNceKrQLv6NXsA6kapNigIm04Zcn2O3y+PHtmd2bfLAod6yzKWo+8R6z9Bl1eds8fElE3NLP21dccMPHVmezQkYvg5+/1yPqg3jOVIp5ihmkBEDSsquhqDXiUyA+pP6hzeDU9TBZn8hshKXU3yQlMj3BU+mlt95dHDdl/o2McP64JAIj3zn3fDeOOGKILSU2zfDrNgDyUiTPm0vE5Uiy3HmH7P71zC2dgPwzTXnpeSXqqEzFzFPf99bZwuhQdqwW6RkGlkBLKMEzLJhxfco399OPu5zrFgSuDVPM09KGMIkDtQa3DdQQjrHEWo61aCMzud4zVcoBxtNikOSWJDijoGJz5PRpgA70zPlUIGCC+R7SiU8mdZh4r3hUWmTBtP19bqLRMD7qNW/ZkTM8Fmj7lycqkdzLwsevrYoRDSj/j+1QFoEzFDsnoEioZrEZeOeDzR624afrTE6tyWcYmpa6rawCIGXwCZFY8oYsrExaLHVkibAjjV/O2VRsasGh/Qj2nSk4u93tzXm/z90XLgotEfzPTi9jH3h2cJ4D/1BuEATL12Vk+XNzSeE064DmJ1zIpA6mtVOSAFfB01kg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(55016002)(71200400001)(9686003)(5660300002)(83380400001)(86362001)(66476007)(66556008)(64756008)(66446008)(33656002)(66946007)(8676002)(8936002)(76116006)(52536014)(38100700002)(122000001)(966005)(316002)(478600001)(7696005)(186003)(110136005)(2906002)(4326008)(26005)(6506007)(53546011)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JJr6//4h/lR9pYpyzh6tqo35QLqeDwMXupO76JLtfu6/W6V1TOaJa6GcMfcG?=
 =?us-ascii?Q?bHhWHdPd3yGnIRespF/SvfogCPTLnlIp5cCfTMOAx2FD2CVqy/O6C93EJfu7?=
 =?us-ascii?Q?178Dk8/xPT2DERnIsw5x6X4wrPMsIMky5vlwIRtK0OlMvtX/mTvLgpHZK8EN?=
 =?us-ascii?Q?3/q96yBFfevCkCHCed5TlrZFIqRbweYgJw4KdIa0WACmSS+KDv4DRDeb7o02?=
 =?us-ascii?Q?RYyjCHb3OWjXZM6K6bp0IuWbfMYJDkiHiIH+Aj6i1eE6h9U4kIYRf1g46hcS?=
 =?us-ascii?Q?bMwMcCKChtob1VRDO3jknjRip7FDXsFmLYtDlvpHZnhnmxMZ1DGWg9l/kZy6?=
 =?us-ascii?Q?1YAsF2lTOGtkH3MTJgp2A7gHh39HS5cu+YTSHvCC1PfmM0jkrIxqj5nEwyBz?=
 =?us-ascii?Q?UAAZ9PFTjxAydLrk2GBRIDd6mwm21YSDxo0/Qt2uZXx5gHaBCDV9wDD2ob0C?=
 =?us-ascii?Q?rczwmlHeq7qylCFinyqy4uX9/0EMQNzNt/2t2vf8rdnhHbh2FBZn7WS3uWnF?=
 =?us-ascii?Q?NPUklMdf3lcfPPHovBBbownzWH3uDSfZ3d2dpMlvsjUTr4T2H+pIyyh1irHa?=
 =?us-ascii?Q?OjR/FmZsDr2EHOQHhhaiojfqAdk5e1tNCY8fVXd68Lt8yWUmao4fuGc2F10K?=
 =?us-ascii?Q?MrIvy0grbMO7cN4RQ5ETobnhAzSkeGyeciCEkuXmAZMga7ODCWotD93tvZpL?=
 =?us-ascii?Q?0i8roZVWwfC2UOyJMvlDXQhJOPEv2DoaGD8MiA666TI2EvHki9NgW/5wZiLx?=
 =?us-ascii?Q?UrdUJvX+VIsMTzgHGTQk87dIJqHXse896Yb2a0UYnmpRfGN3YSqiPRaBKGuD?=
 =?us-ascii?Q?2dRt4tkOIWLHWeJckYxLj4IV41BPMZBQgaANmPgc22QP6vKYug1e3K1HiEIk?=
 =?us-ascii?Q?VLbNin/pHEMKStwsMf0ebzuAuICMloA3xg4rpjCOU+y0blhwr9RDtVtg5ZQE?=
 =?us-ascii?Q?YKMbmeOg8ZI0eHWwbiZ2uMpCz4P4jrrB8mvtsFY5N+EB6kCgQBQQU0niU9ip?=
 =?us-ascii?Q?2i8XxWD8C5T1PedMSuKJgz5SqF33PLbsYUBB4ritcQAXHrcnTSNV7mStcS4W?=
 =?us-ascii?Q?xaQWAE2BIqUFEWLLl7Cn2il8e7/Ub0TlRG3JeFbH0JIiEc4wMakNm7SY2Sbd?=
 =?us-ascii?Q?naNQSGyMANPeXN4kGlLf7m020W2t8YwcZE8ebLiPR6CTDdwhLgHXICB7cMMD?=
 =?us-ascii?Q?D0SduiHL1ys4sTFBpWU5O3Va7elPn2QBS9K5cLFWvg9qn4B/xYClUWWYaEtp?=
 =?us-ascii?Q?spkVon+L6tY51EPbeNe5sPV5kqs3eKEyoPRzo9SWrNm+hwSs6KWKBWsJgcgo?=
 =?us-ascii?Q?Uyg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86467b99-3ad2-4538-14a9-08d942073791
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2021 11:55:01.3069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PtUtwPsnefMKuLg6oknHc3p7En5hghgnkXmkdVmv78AN0FiBpZRJIPjOMrN4fqgz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5092
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Please fix the // comment style before submitting and modify commit message as 'VF FLR'

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Peng Ju Zhou
Sent: Wednesday, July 7, 2021 10:47 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH v5] drm/amdgpu: Restore msix after FLR

From: "Emily.Deng" <Emily.Deng@amd.com>

After FLR, the msix will be cleared, so need to re-enable it.

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 90f50561b43a..dbc0e5bb203d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -277,6 +277,21 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
 	return true;
 }
 
+static void amdgpu_restore_msix(struct amdgpu_device *adev) {
+	u16 ctrl;
+
+	pci_read_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
+	if (!(ctrl & PCI_MSIX_FLAGS_ENABLE))
+		return;
+
+	// re-set MSIX when VF FLR if VF MSIX enabled.
+	ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
+	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+	ctrl |= PCI_MSIX_FLAGS_ENABLE;
+	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + 
+PCI_MSIX_FLAGS, ctrl); }
+
 /**
  * amdgpu_irq_init - initialize interrupt handling
  *
@@ -558,6 +573,9 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)  {
 	int i, j, k;
 
+	if (amdgpu_sriov_vf(adev))
+		amdgpu_restore_msix(adev);
+
 	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
 		if (!adev->irq.client[i].sources)
 			continue;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C8ebf5732b5944fc4749708d941067351%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637612318247594022%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=DVF94WDoFExFyt31rGSRBMZ00gI1FJZPiSduOWXnfA0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
