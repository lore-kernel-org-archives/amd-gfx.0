Return-Path: <SRS0=PX0W=6F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC61C2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 03:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 548E5208E4
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2020 03:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ddcqx/La"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548E5208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4A7C6E264;
	Tue, 21 Apr 2020 03:55:40 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750084.outbound.protection.outlook.com [40.107.75.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE3656E264
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 03:55:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTPgSarpi3+vJ6r5OJno5S3/D//0E4YapkAb36Kc00DxAACwCLHJnRt5/Vs2x1BwVYGS7Ehwbejl8CFMu7J3HcBDt/jGyfAmvQL79BWk1EEVbd46NhZIlOXxkP7pSWSI3ovMaW5wGPMGOVnjyxmEg2+JsDC/HJEBj9RqHUeRJ/r64YQcqeXjjsiFDe5GTLjWG+D37LZCVvJkvP4XmSmpISjkuZn0AWCPtu9p/gHZXW0uSXDii4VgNeQzT3c3B3m6ybpcW7GLIn/fcpHNJLXgRi/fxwRbOqlNdfvT5NgnGy0UlKMB4ynlBPLfUaw+WkitUpW1nZg9Nyb+jz8dCYKD6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AI3j3XJSfzSGp/uCsxMfwGCf6ddDWpgxD65lEW1YWHo=;
 b=SLEU0hng/mE2zyPENdUG0lkiexjh+GAwRzl2aBb+joZniqZkXELAQvTg+UVaaPFozUXpPv33Bnn98PYqKzRvTm6oVy5NVfJ8NLRx/ZUeployzVPiCHJ5yBMGr+tU13z2+/ftR42TKr1io1n429jHHPNbWbczx2cef/h/+zNgP5o9r4BtyiOu4vtkyXM03fLlcfFmfXi/+FOqQaCV5Jb3JE2+kQXWg9tMJFvurLKXjcLNdARZfji04y2ISMsg4xWXZIGcU4+jNw57YnxZ9eu8lFJl0cflu4aBrmc5ArFr7gPqVu7vWTaafm2Gf0gDWsLrHL7QpwBGR3XshD8su6Uikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AI3j3XJSfzSGp/uCsxMfwGCf6ddDWpgxD65lEW1YWHo=;
 b=ddcqx/LarCXM/XlgYCisVuS/xBdaG2475lTq68tqKgsoo3TnDTA7WdtG0NRBaVZ+Aatfzb+QerNzFr4BAoucURcf4rRlcps3rxYlzN/eN3QQYU4qPnSyu4dUk/B3NiuSTjE4twPD0ktngJNgTQsSIPv2r+wEE56RWzwg7OYqEV4=
Received: from DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20)
 by DM6PR12MB3692.namprd12.prod.outlook.com (2603:10b6:5:14a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 03:55:38 +0000
Received: from DM6PR12MB4170.namprd12.prod.outlook.com
 ([fe80::7172:5326:2560:6b48]) by DM6PR12MB4170.namprd12.prod.outlook.com
 ([fe80::7172:5326:2560:6b48%6]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 03:55:38 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] SWDEV-231280 CentOS-AWS Guest driver reload 3 failed with
 call trace in guest
Thread-Topic: [PATCH] SWDEV-231280 CentOS-AWS Guest driver reload 3 failed
 with call trace in guest
Thread-Index: AQHWFwecR9EcXK3wX0q9ZOX8UXL9h6iC8unw
Date: Tue, 21 Apr 2020 03:55:37 +0000
Message-ID: <DM6PR12MB41701AA7A6825BD3B8D5F749F8D50@DM6PR12MB4170.namprd12.prod.outlook.com>
References: <20200420113342.2536-1-Jiawei.Gu@amd.com>
In-Reply-To: <20200420113342.2536-1-Jiawei.Gu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-21T03:55:31Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c403f74f-d080-462b-869b-0000cdec75ab;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-21T03:55:31Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 17e30aa0-5a0f-4c84-87b9-0000c694b777
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JiaWei.Gu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 087129d7-f7b9-407d-f071-08d7e5a7da49
x-ms-traffictypediagnostic: DM6PR12MB3692:|DM6PR12MB3692:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3692C0CD330CAEE36B751BC9F8D50@DM6PR12MB3692.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:398;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(66476007)(86362001)(66556008)(110136005)(316002)(76116006)(66946007)(64756008)(66446008)(8676002)(478600001)(55016002)(8936002)(52536014)(33656002)(9686003)(186003)(71200400001)(5660300002)(26005)(53546011)(2906002)(81156014)(6506007)(7696005);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fyDVvfC1GmopInBkHkvQhAsXa5XV5VWHpcg5dXH11uOtxzb+3cnlh1p8fVmpAudApoNgW243p38Pa/eI1Lrj3ZcKJlzvRCJRcORSLl5rzAJ0ydiA67EYTRMAELP9x5ZILgpiJ7gEZst1hQE+hiGqwj7Boi7/giIyVn1EVj7SMvGBKSaoWKSHPTnODwOiroh4nnbF0WtOB7LQof1355CD1XgRUk0zjGqscGCCg7sc586GaTluqdl1FM4h6rNYiPWSHs/rHNJge6EWPAK0QfN53SFzXri5wtcelOx77fRcMbzIj2/L9c12gLztQ8BpS5Z0l96Y/+4aEamfgvEd2x97nSbKQ1SaGqTrRvz5SZG9j3Ptv2zaO2KzTD+W5GDXId6qTMJ81iP9O7JxtfHXHfkbsgkOlaG9sYWQNL1FZuJCY0ZMbzE/HbyWLV/0VYsrRhGL
x-ms-exchange-antispam-messagedata: u2/y/4ouJp5MX/21KkfOOs4pxmwUaPaqmvQKm/h6sIgEyKjT+l6/B/AbcaaRBMsztKxQrCnHP3dMssDN0HOTw0NTl+10AOsu7WJGiZ1BYbBPzCYIjKt+6Rj7UWBJQL3no2M/mOwp2AK5pG+6MQNTow==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087129d7-f7b9-407d-f071-08d7e5a7da49
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 03:55:37.9866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZhxyOg/OqH1t8ifl6ckdhznPl/gXcRt3KMWEP+eQqtmEBdYxSgmOhOSVkVRiH2TJJS/hvot/zKFPurTtDSeekQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3692
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

Ping......

-----Original Message-----
From: Jiawei <Jiawei.Gu@amd.com> 
Sent: Monday, April 20, 2020 7:34 PM
To: amd-gfx@lists.freedesktop.org
Cc: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
Subject: [PATCH] SWDEV-231280 CentOS-AWS Guest driver reload 3 failed with call trace in guest

root cause:
X enables vblank, but driver skips shutting down vblank during unloading under sriov, which causes kernel call trace

solution:
move vblank shutdown logic  into dce_virtual_crtc_disable() to avoid sriov skip

Signed-off-by: Jiawei <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index 3f739efead61..c02797f2ee7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -191,8 +191,9 @@ static void dce_virtual_crtc_disable(struct drm_crtc *crtc)  {
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 
-	dce_virtual_crtc_dpms(crtc, DRM_MODE_DPMS_OFF);
+	drm_crtc_vblank_off(crtc);
 
+	amdgpu_crtc->enabled = false;
 	amdgpu_crtc->pll_id = ATOM_PPLL_INVALID;
 	amdgpu_crtc->encoder = NULL;
 	amdgpu_crtc->connector = NULL;
--
2.20.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
