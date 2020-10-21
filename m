Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D68C4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 08:01:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2667B22249
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 08:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u1NEjlJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2667B22249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C5D46E96E;
	Wed, 21 Oct 2020 08:01:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F2B96E96E
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 08:01:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fN6iY07URvJYETEnqxbjAYIswGmZk34V3E4VSCK3mZsXGRecvOpya2JiMbMHmdY2Hn9HTHhDYDF+Vj6AzMgv8GJqxCvi3cEhu+wOgFIKvK1pv69SEyCEnEOqhOUPfwmjnuBDXI3ECwJ/1QZG/recZpfcNm9QDe8HS+sfWEji8vkTqmCoPamHD0BeE4CDNqy39B/xe6QEqOgkh7InKXaiqExUxG5yeGWsO5VBL+phzPl+C9gM/y1uCLAGlIayWs8RiW54ylA/YIhaxoqObi+okCj0WZ3vi688V3QOE3OW9bBoauAZfDzd3pkGRHA0qUBZgdv8XEAhye3ECFH3DO4Nxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgV2AUbIlX11b/jQXk91D07cxXExOQvdzQCNtwbdYbw=;
 b=SBoXijLkv0EoynO3+f5WvevBqJhrodHo9qx9dT/r+w28xMY95i+GJlGWVWPswtKAAyQB1aj5G/AmODE7pBGegXxgJ1dNLFejMV+P6OSYcAYSpehZFclxmBsQwMwU6o31RoRKnnYtpWtAQAJNHkurKX+qaBpoXuUEOPQUaba9UETmGdPVB9Dr6PlZHJWkW6QAZx1YDCej4Q1RUO163LFfWnqTzd3TSnO2HAW/fz7ztpWHOw+RILaWaWIF4TbXLGSRLJCSzuClHclzIWXVtU/iALDFvuvK/R5Jaiyjb4LvIbsy86B0Kp50QDJv/BYezHWgUEBGEvHOjncuTW4tTJQ3Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgV2AUbIlX11b/jQXk91D07cxXExOQvdzQCNtwbdYbw=;
 b=u1NEjlJgWDuQjJNP+9c/U4tGhvGVduG1giNs9eHIV9Qy/bm2j9xjqy996U80SusL1dLxzQTt7PPOCC57iJNQwp/FdducHmtZXTzmRZkNp5ciQ1wvg7luMSNzEMsJ4uC4d2rOXBfFOyuN3AOD9dd0NVPVEWBE/BcjeS899APwoW4=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0183.namprd12.prod.outlook.com (2603:10b6:910:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 08:01:33 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c%4]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 08:01:33 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amdgpu: add DID for navi10 blockchain SKU
Thread-Topic: [PATCH 1/3] drm/amdgpu: add DID for navi10 blockchain SKU
Thread-Index: AQHWp3+nLvUiYq1lzEuVbbeS4pIH7qmhsaTA
Date: Wed, 21 Oct 2020 08:01:32 +0000
Message-ID: <CY4PR12MB1287852ADEA303832385E112F11C0@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20201021075608.16785-1-tianci.yin@amd.com>
In-Reply-To: <20201021075608.16785-1-tianci.yin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-21T08:01:04Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c765b2e0-779f-4647-8a37-00009ceaf1ab;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-21T08:01:29Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 92f90f92-0d1e-4c3c-8315-0000778d5ee8
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6cfef827-dec3-4b51-774c-08d8759786cd
x-ms-traffictypediagnostic: CY4PR1201MB0183:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB018321BC4F2EA903133B2E8FF11C0@CY4PR1201MB0183.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sjx0D8YhbopDo5PaBpyNzH3adXUvmmBpL/yCCpFD60wyU2Jcpjl/aAM9R5JFV+V4Od6ONHM8t6yq4h2rDBjbVAtxCOJWPj0E11tDyxvGN9F1MLtBhQpkQYxaQyQWyy33g7GMwYpDEh/IjcETRvf/24ifBKRGmL6P0vDpNQOKz0f5E/SuWJOLVKvYgIPpRFoiQfiJmBOUsQFK0SqAISpTCwy9yREkTMhZpz+PEBI50NiLmhkAombd1qsADlxEWYG3SF35xcN44UB4gBef1a/BqixyCO97brbuesHMxsGURZKNb3DHSSWOPDxPSE7pVYRxTu5BdostuIVRNtIOW0k5Zg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(83380400001)(71200400001)(52536014)(2906002)(316002)(186003)(33656002)(7696005)(8676002)(55016002)(86362001)(53546011)(478600001)(6506007)(5660300002)(8936002)(9686003)(4326008)(110136005)(26005)(54906003)(66556008)(64756008)(66476007)(76116006)(66446008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Q+MuCGr4WF+yuxN0EHfoP21f2GziZSMm5ATXAn5hNIOq+q8oUdZooRF+V5ADwBGxgGmaGH7Hbz9bcAA4W2ORx0UCQCeEVw1vwyhofEnarqZab7YHAxRH/7AsjCi9+FQjzySlzAGi99wNlW/ywuYD712BF8kU+zVoGGmvRVVLmlmclPQ36TZjFRkAwCahpDabs1aNSQybminj+C16Sh5kTcXfVwcmq+utb74b2miIPVXcFXjFZRgQwcnchwM6Q54Ev39LehVXDr5wXfslMG5oJLll9u32v/vzjqfPj/MapRgAcJGSCqBLBYEN9zkR3VeQ/YiVPnRwU6ZTG8KunyA4XrMcC6dasRyyP6Y+vADM9azX2MaXLUuzePjbZK9fMQu8ZgZtSjI+0b1iTVWm3R0wVJ94QVG2XtvjNInmxr0SvciIxVfoL1BLiGlef7sdx9s9wXMlx2HkZE+rftRt1HnXJq5fksmLKgZyqkW/UqjMqNjRzaEAixx6uLyqnkw6KNd6Afp37EeY0RsnZQFgOh/QupvmF/Ir5qMN+dvWuGO4PFkDoYf7b37qOw7cJwv5OPjcNu5Comy8eQIydnln1oB3puiwg1mZ2xk66CVDFqoIMTG200wSMwXYnOfr7DF7lclrQpQqEipuUyuaU8/MRoAHqw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfef827-dec3-4b51-774c-08d8759786cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 08:01:32.1184 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QiXciah0bKnJVpPHpao/t5Pywwwq3vGTiG/zOkhm1KI+rb+6y28LWKpOri06w0te5TNFSIZLI4taCeXI3zq//A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0183
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
Cc: "Long, Gang" <Gang.Long@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Yin,
 Tianci \(Rico\)" <Tianci.Yin@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Cui, 
 Flora" <Flora.Cui@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Series is: Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Tianci Yin <tianci.yin@amd.com> 
Sent: Wednesday, October 21, 2020 3:56 PM
To: amd-gfx@lists.freedesktop.org
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Cui, Flora <Flora.Cui@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Long, Gang <Gang.Long@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add DID for navi10 blockchain SKU

From: "Tianci.Yin" <tianci.yin@amd.com>

Change-Id: I58129e3aa88369c85929e4dde002cf43c3ff288a
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 564336c2ee66..13723914fa9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1066,6 +1066,7 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x7319, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
 	{0x1002, 0x731A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
 	{0x1002, 0x731B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
+	{0x1002, 0x731E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
 	{0x1002, 0x731F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI10},
 	/* Navi14 */
 	{0x1002, 0x7340, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI14},
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
