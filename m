Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC072C32771
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 02:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DC49222C3
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 02:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oIm8VoHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC49222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58FF96EBB8;
	Thu, 16 Jan 2020 02:30:51 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770074.outbound.protection.outlook.com [40.107.77.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E198D6EBB8
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 02:30:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HehlqvD19hNStDtpiqLyt/WW5tbNwi4k7CK6O8WfjYm8TMCFa7DB6ih76V2qY7OubsnwiLvRaFpYS/Wc9/TLEJpVD0w0GBvBbItAM37Bs8FhZ1yM8r20q0QVYlMsMKY0Wm9Ck7tGCkP2cXpznyiLwUIGyiEmBKlNiBQ3eq+llQNp39mrmwbQw1YlhAyF/kQa+BR9/bWBbcn/QYOgZ3J9xfXuwD1Rtpd+4K1ZYXqq8Cmms7Yw98JSeYXh+kQrVRWajdybj8dXSlZWACdef3TIMGHpqYmG2g8PKWRyDkVPyVS82CDIEovPc5mnYBZeSAKp/CEMoVlypN+IP/KLzmcNRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mab1vDeG7oLNOs8P8LghwcIZltpNmr+vLXE8q+uxSk0=;
 b=SSiSrnOdvhH7xoNODrkzitQ+fprWKnxr2WzZQAfTR7QmJKMU99cQh3p+eXWCdPPmR3MHSv6594vHXxFwgHHmUZGrOAjk92ithRhvAQmGQ2cRHwD4zpJr8cC5u4c/JEFkrltsVx9UU4xnQR5TxB8kdC+WCvYdw7FMZ25+xzH0zvI8LioAtPmFNDFrsSfe7PSelxy3dpNd3RV80VUTgnsJtv35330iIPV+lzJdVtGYV70uLRXc820yGV3eyNcfLK9KG4SI7w34a4qCddUQ/HUgNRXpE4KfczjX0t46z7DWGgxl9sdofm2pkB5Gl6jImVvLlh22m4/OyiYDZDZYqJCdEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mab1vDeG7oLNOs8P8LghwcIZltpNmr+vLXE8q+uxSk0=;
 b=oIm8VoHMLqGdwuPFLl5C5rWwTl58j895Z51G3aM6Ye1IqoC3jgPbFaLbQrET0EYjh5hNgpvLoWa/H8Le8P7aumzEhEkust035qM5VEFWHhXFHyTfPi5TvOknKKGXR1vL8+XD5Omsdhn+MmQDOAg+YxXeMrWA+qjLNcFeXjVGSHg=
Received: from MN2PR12MB3069.namprd12.prod.outlook.com (20.178.241.23) by
 MN2PR12MB3821.namprd12.prod.outlook.com (10.255.239.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Thu, 16 Jan 2020 02:30:49 +0000
Received: from MN2PR12MB3069.namprd12.prod.outlook.com
 ([fe80::9cf1:449e:8958:db19]) by MN2PR12MB3069.namprd12.prod.outlook.com
 ([fe80::9cf1:449e:8958:db19%7]) with mapi id 15.20.2623.015; Thu, 16 Jan 2020
 02:30:49 +0000
From: "Gong, Curry" <Curry.Gong@amd.com>
To: "Gong, Curry" <Curry.Gong@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu: add kiq version interface for RREG32
Thread-Topic: [PATCH 2/3] drm/amdgpu: add kiq version interface for RREG32
Thread-Index: AQHVy4f55FmVRzhjbUS6pK2yYecpNKfsktdg
Date: Thu, 16 Jan 2020 02:30:49 +0000
Message-ID: <MN2PR12MB3069584DD11AC14EA2AA6C899D360@MN2PR12MB3069.namprd12.prod.outlook.com>
References: <1579081282-659-1-git-send-email-curry.gong@amd.com>
 <1579081282-659-2-git-send-email-curry.gong@amd.com>
In-Reply-To: <1579081282-659-2-git-send-email-curry.gong@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-16T02:30:49Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=2927c0d8-5826-48f6-8b79-00004229d049;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-16T02:30:49Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 6479da24-5f3d-467c-a13d-0000daa282cf
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Curry.Gong@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a0bb959a-cc41-4ab6-49d3-08d79a2c19bd
x-ms-traffictypediagnostic: MN2PR12MB3821:|MN2PR12MB3821:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3821077B383E6DB70FD1AE879D360@MN2PR12MB3821.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(189003)(199004)(5660300002)(478600001)(66946007)(66476007)(55016002)(66556008)(316002)(26005)(52536014)(66446008)(71200400001)(76116006)(33656002)(2906002)(9686003)(64756008)(81156014)(186003)(8676002)(110136005)(8936002)(6506007)(53546011)(81166006)(86362001)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3821;
 H:MN2PR12MB3069.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ksDG/7XFvIg3nVipS5T5sslI0M//yCjSZePeZhrXIQEAz66EST2EmTitUzGnHrW0nl0U14TW+8QvltKpQ9oZiF5SZz7yRy2WsLrOJJhtrZ+mphTaVaevYreY7lPv7thbQ78kYHTm9qhng/zlZN9VIIpvmJPN2+5CDnoGIRslntB+iRwAPvVle7Z3XQCz8dIMqboga7sqhnwWPauhzCQovRWx3iut+Oc3vOOxsw9G1222jTlfqEqkWvrb7Urpklpyuq883sKD6WNmhhE1S06d8nqsSFAXuw7QNjtgJvRA2t9/SFGLe21OCk6ZAp0Fu4KpDzb7y5fXs2weT4qD5Plax2Q0WlJzKVHoZi1/I0CHqo+WKYWEPfWMBkKUf533lcmu19M2oRUACdgXLQ5Vvn5WQ7ctEYnssfMlFfUmiPyFimlPv21V6mvRo7U9fK7oN5jY
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0bb959a-cc41-4ab6-49d3-08d79a2c19bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 02:30:49.6049 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ei+wD4KHZQU8A2FQ6PrKHIfLBzXyWSPMJbhlNskOjvQIbPUG6aOf3/WswKPfGyic
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3821
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

Ping

-----Original Message-----
From: chen gong <curry.gong@amd.com> 
Sent: Wednesday, January 15, 2020 5:41 PM
To: amd-gfx@lists.freedesktop.org
Cc: Gong, Curry <Curry.Gong@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: add kiq version interface for RREG32

Reading some registers by mmio will result in hang when GPU is in "gfxoff" state.This problem can be solved by GPU in "ring command packages" way.

Signed-off-by: chen gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 63eab0c..b4b00e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1016,10 +1016,14 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 
 #define AMDGPU_REGS_IDX       (1<<0)
 #define AMDGPU_REGS_NO_KIQ    (1<<1)
+#define AMDGPU_REGS_KIQ       (1<<2)
 
 #define RREG32_NO_KIQ(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)  #define WREG32_NO_KIQ(reg, v) amdgpu_mm_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
 
+#define RREG32_KIQ(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_KIQ) 
+#define WREG32_KIQ(reg, v) amdgpu_mm_wreg(adev, (reg), (v), 
+AMDGPU_REGS_KIQ)
+
 #define RREG8(reg) amdgpu_mm_rreg8(adev, (reg))  #define WREG8(reg, v) amdgpu_mm_wreg8(adev, (reg), (v))
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 963ea46..36c0f9d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -217,7 +217,7 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,  {
 	uint32_t ret;
 
-	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
+	if ((acc_flags & AMDGPU_REGS_KIQ) || (!(acc_flags & 
+AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev)))
 		return amdgpu_kiq_rreg(adev, reg);
 
 	if ((reg * 4) < adev->rmmio_size && !(acc_flags & AMDGPU_REGS_IDX)) @@ -295,7 +295,7 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 		adev->last_mm_index = v;
 	}
 
-	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
+	if ((acc_flags & AMDGPU_REGS_KIQ) || (!(acc_flags & 
+AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev)))
 		return amdgpu_kiq_wreg(adev, reg, v);
 
 	if ((reg * 4) < adev->rmmio_size && !(acc_flags & AMDGPU_REGS_IDX))
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
