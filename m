Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F987C3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 17:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39A3B214DB
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 17:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0Mj+PSWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A3B214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C70746E5CE;
	Mon,  2 Mar 2020 17:42:56 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690076.outbound.protection.outlook.com [40.107.69.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C8046E5CE
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 17:42:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bi1aTLkEfjmTL8IFhy+uxD1WJ4nSTwbT8u5z79hHF0gH3x5Nxq5LXVGnC3nSsVro8PwXkCs9DaFSftza//r9f7o3JDAz+5x746poODybXoBmM1qd+hsgspfPIu71N2i8SLwG69DiiKcrCjk9VfVisJBzSY4teBocO7kt7EtyoDwFKXFYfr7diiae2i66JM0K/tp4uc/fVg3ADvR1dl/0uPu61B7TGPq1GMU6j/RDYlRXdhHYhVHIDO9CYSstBrKMYRus2nCW8TSv9bf3AAEa5XU1/wanTyRb+N0CxSplnIuBXeMOWZk0owBZo5t6213K+9BGvr17d2P0EwXziiaBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aR1qx7mIszA9GmGVMEO5h2l1cqqBTrKbc9vTSqUkDrM=;
 b=mIBRzFopzMyYLJRFOaj4rYtbNLfZA3JI38VIBZtSLzvebRDj8SPCmfENNffRJ+TX+1qe/q4M57TuxRBlynzlTd2/CqojzEf+QHiS4AXjEuuP2wgAo58XVEEq1A3OMVsSBINtuneldYFK00/GkqolpX8QVXwHb9ZDIJLkt0G/peyyur8b5OP5Q3CgXZsbcLxni4SqHlfdV4SOD821YBAxBkIDhkzKa+FJgJusz44MP8yWKp+2tMusrelWS4F+bFIFyh898ksKtuI1NIjtbIQtHUF2vRK/15OxG8wQK0p510v4DHszl5FjWAG4H+kxlgY+1kV3Khgv3f/ObrSgWgdSfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aR1qx7mIszA9GmGVMEO5h2l1cqqBTrKbc9vTSqUkDrM=;
 b=0Mj+PSWZrhOAN3YyATYItPKHN5vFM9SH80KaI2wAfZfhQ6E0YvMFKfpZg88ojxE64NJwPyQY6SVrHes04sEAGjlWBUtVbI9ksEz7JyhyyVZAG6EnqbmA0WBNgAl/8l3r8HM3CyY7FRAftpu1TDL8jlpFjwbZkqHh2IEZqI9zUTo=
Received: from CY4PR1201MB0135.namprd12.prod.outlook.com (2603:10b6:910:17::8)
 by CY4PR1201MB2503.namprd12.prod.outlook.com (2603:10b6:903:d1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 17:42:53 +0000
Received: from CY4PR1201MB0135.namprd12.prod.outlook.com
 ([fe80::b471:e112:bdef:a766]) by CY4PR1201MB0135.namprd12.prod.outlook.com
 ([fe80::b471:e112:bdef:a766%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 17:42:53 +0000
From: "Dhume, Samir" <Samir.Dhume@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: drm/amdgpu: Rearm IRQ in Navi10 SR-IOV if IRQ lost
Thread-Topic: drm/amdgpu: Rearm IRQ in Navi10 SR-IOV if IRQ lost
Thread-Index: AdXwuf5cTysJetBzR/6OAzD9NL3Vfw==
Date: Mon, 2 Mar 2020 17:42:52 +0000
Message-ID: <CY4PR1201MB01353B5954DC7743339065D8E6E70@CY4PR1201MB0135.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-02T17:42:50Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d2f5961d-4e5b-4757-88be-0000bb5c2073;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-03-02T17:42:50Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 9c43c4d5-c3af-43bc-8019-00000d7fe760
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Samir.Dhume@amd.com; 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad67e3c4-358e-4adc-1df2-08d7bed12273
x-ms-traffictypediagnostic: CY4PR1201MB2503:
x-microsoft-antispam-prvs: <CY4PR1201MB25035C80EBC16ECC272EF1ADE6E70@CY4PR1201MB2503.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(186003)(26005)(5660300002)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(52536014)(71200400001)(8936002)(9686003)(33656002)(81166006)(8676002)(81156014)(55016002)(2906002)(478600001)(316002)(6506007)(6916009)(86362001)(7696005)(21314003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR1201MB2503;
 H:CY4PR1201MB0135.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mKDPagF1wvtQNmcczjNCCpp+27j8xAJ4WA8fd6pihHB2ov+h9hmcCgzXdOLsRDi9gjDpLNix1f6drCNPFXXNKz8Pae297iMKaEr7S07RXjJk3qk9tTtTuF8Eqwo6T6SQVGtxEN1p+EW3yLKpLvNbolMKbafvAGJtcl1iYHKj72J02aFVHBYEyCQLAvOGYPFd/XDKLBDiOA6yicH74UfjNr5NXGA2P76FLoAzl0MLrYRl5fNCrq97ZQIhZYC7DTaxCXrwYMMMTaD6URdGCm36uMZXokKLay9ATAGEozqqht9qBiwMFNpiANE4WLrpIjzBR7ERcSHSKFIgMRZYAxKvPm8iXUclhKmWpDr5fy8xsiuBTWT8Uzqp8JFUE/cCdim4qt374NOrhwEENqXhb6DXwuTJ161f6Vgnt9HOTZBufOe3u3Sg4bhMSH6YMeohZPCODZ9V/V6oMLsuT3om9Dwc9kpQcTv+cB4jcDUqfkivWPT6T1RRfDo7kMv7IKkd6Lg1
x-ms-exchange-antispam-messagedata: aUJ7a9cBMq3clOiMy61NGkA1ucGSMAtUGlI1QgT8Kli57S61rbdvzqthmvVf9wneuVHxKUHdoi1J0vn3n3McWeFrrHz0Q6QeJTh/B7GN3KCeGm+7M9lKmlRvH58MDKCBpo8wMqDHNcNXBw02Khv/uw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad67e3c4-358e-4adc-1df2-08d7bed12273
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 17:42:52.9947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gEtslP9DT4V5Zz/NB8nXcjzvbVTJCQ85ZRXrrHTFVdiDCPhW44GMFPu3P9KPwCK5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2503
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Ported from Vega10. SDMA stress tests sometimes see IRQ lost.

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index cf557a428298..e08245a446fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -32,6 +32,7 @@
 #include "soc15_common.h"
 #include "navi10_ih.h"
 
+#define MAX_REARM_RETRY 10
 
 static void navi10_ih_set_interrupt_funcs(struct amdgpu_device *adev);
 
@@ -283,6 +284,38 @@ static void navi10_ih_decode_iv(struct amdgpu_device *adev,
 	ih->rptr += 32;
 }
 
+/**
+ * navi10_ih_irq_rearm - rearm IRQ if lost
+ *
+ * @adev: amdgpu_device pointer
+ *
+ */
+static void navi10_ih_irq_rearm(struct amdgpu_device *adev,
+			       struct amdgpu_ih_ring *ih)
+{
+	uint32_t reg_rptr = 0;
+	uint32_t v = 0;
+	uint32_t i = 0;
+
+	if (ih == &adev->irq.ih)
+		reg_rptr = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_RPTR);
+	else if (ih == &adev->irq.ih1)
+		reg_rptr = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_RPTR_RING1);
+	else if (ih == &adev->irq.ih2)
+		reg_rptr = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_RPTR_RING2);
+	else
+		return;
+
+	/* Rearm IRQ / re-write doorbell if doorbell write is lost */
+	for (i = 0; i < MAX_REARM_RETRY; i++) {
+		v = RREG32_NO_KIQ(reg_rptr);
+		if ((v < ih->ring_size) && (v != ih->rptr))
+			WDOORBELL32(ih->doorbell_index, ih->rptr);
+		else
+			break;
+	}
+}
+
 /**
  * navi10_ih_set_rptr - set the IH ring buffer rptr
  *
@@ -297,6 +330,9 @@ static void navi10_ih_set_rptr(struct amdgpu_device *adev,
 		/* XXX check if swapping is necessary on BE */
 		*ih->rptr_cpu = ih->rptr;
 		WDOORBELL32(ih->doorbell_index, ih->rptr);
+
+		if (amdgpu_sriov_vf(adev))
+			navi10_ih_irq_rearm(adev, ih);
 	} else
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, ih->rptr);  }
--
2.20.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
