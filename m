Return-Path: <SRS0=j6k1=2N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28B1C2D0C0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 09:20:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C1C20709
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 09:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SPPvsUPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C1C20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A1789E57;
	Mon, 23 Dec 2019 09:20:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B15AE89DFD
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2019 09:20:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhZHeRqRzSrkpdwBl8LaHis5wf9ud8iHVJfDjxKG9VdHq3tY4bPJMZxL9WE1of2M98qgjzogRZhiD/kzFpOsxIm3+OYJJ+J8PE2zzmQnkyeS69h+V6ncWxjp5Axw8FB3vnqW5Vpo9UHSRIlyRuuZb4xuOR/6Eknu9MNowQOSWBBh26PGPOjdtpgUaWPfPAViE4pzk8oLOUnekth7HolwkQby4JfI63tZbyLxtp/VEVfHysjB7XMukGZBOfb9GEPrNFsVB5vtPGbhDciiicKPl2bhfjaGVlrtjDbY5vw7sLMWs2dEFsr0QFp0VMkexQLjwNF46nGW+U0tsXVItORTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwzvCs+B4KEGKRE9PpWmCSEk59IONTiaF2yN8oLYTgs=;
 b=Pyeq+LlEbJVkhFHtcd2LM2aueEqbrdGte+FmTsiBksDTswu0aP/kfprob0e2QUDBbe12Z0DgjbrFWXeHdiLMlQVluTKS5msT9VOyHvx4kHC8dPpwLgUX7LR8HSPb4Yai27iR7sTGMWXCYV2M5Ab5PrRdLXw2jvvCVRX/CfnsUEE/lpuEoDlemRhQvaVXM+/XQMGqduAYGeKFKOMi9ssIjzHLFVw4sGfy0gLD9KZH7igybVPoz/A/yZ5Zq4U52ULOMyVZArYsdrnlzO1fU42mId6xMnNSJ3pLOu0YSK6WEYNor7WkzEwc36s+TlmX2pwaw60nyrnRt+V7wFHPiKyKAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwzvCs+B4KEGKRE9PpWmCSEk59IONTiaF2yN8oLYTgs=;
 b=SPPvsUPpWdnmmHmro67eq5Yqb7BHJBN+zUwpjVPt2V2UTC4Ch6HDr1nVzUJLpPaEZHJLsVW5QivtAFtwffJQTHAm8MEGxDE6nqNZakUKb6IXcXNGqr4KHCZSCA4ZJv+i6yCg5XhA04Dvh+7wJFLEk+CQJ8N6PvQrCSigSMXDSGc=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1355.namprd12.prod.outlook.com (10.168.234.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Mon, 23 Dec 2019 09:20:07 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::e944:3f8b:ca64:ad1b]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::e944:3f8b:ca64:ad1b%5]) with mapi id 15.20.2559.017; Mon, 23 Dec 2019
 09:20:07 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Min, Frank" <Frank.Min@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: add psp session ID get interface for sriov
Thread-Topic: [PATCH 2/2] drm/amdgpu: add psp session ID get interface for
 sriov
Thread-Index: AQHVtmGeErEGoT1jr0+M4J3EaXNA3KfHYsVA
Date: Mon, 23 Dec 2019 09:20:06 +0000
Message-ID: <DM5PR12MB1418D3E9455862CE61D9B094FC2E0@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <20191219114335.22528-1-Frank.Min@amd.com>
 <20191219114335.22528-2-Frank.Min@amd.com>
In-Reply-To: <20191219114335.22528-2-Frank.Min@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-12-23T09:20:03Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4a2e87b2-d76a-44bd-bfb1-0000afdfda72;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2019-12-23T09:20:03Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a177e8b4-5f82-466c-9d0f-0000bdfb9440
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0cf85f3a-9503-4a18-0313-08d787894d30
x-ms-traffictypediagnostic: DM5PR12MB1355:|DM5PR12MB1355:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB13553C1C842F5494087A4605FC2E0@DM5PR12MB1355.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0260457E99
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(189003)(199004)(13464003)(9686003)(81166006)(76116006)(7696005)(55016002)(45080400002)(53546011)(4326008)(66476007)(66446008)(316002)(186003)(81156014)(66616009)(110136005)(66946007)(64756008)(2906002)(66556008)(86362001)(52536014)(6506007)(5660300002)(71200400001)(8676002)(26005)(478600001)(33656002)(8936002)(966005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1355;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LpykIVSgQV9C1QAuEpurF9Z2npziO0lLIy5nXlz4+MtE2Uflevt3Z8SnRuDAsUL3Yc+CeIVtNuBDpFQlkiuKhM0jW5xs4vjyD+XUNE2PgfX44rUOzgKsKHm9vHDjDETfknA0pIpavk58Pb8TJRb9+vzappOsb7HbDHfSXsbEqQl2vUZdYrqRi7EEh6XzXJrxpy3kn3HOyomt0lMXWTHL05RpGkxvU1BfReVnf/lc5aQ1dnGtIZgnuRWWp9D3s58hYweqzVLVCiNET2Q5Zgsdd22HeaD8z7oFJu4PWPhUdLRO50m+0hcgNDevkFuv9Ekk/Ek8OUctbycwOpHRi+5bLs///kuJyAqFHh+RuP0wJfrWrYJ7oNONV+uSjvKPErZZ+hNIfQK+/H9RSjcFXmQoV0w9+gO77NZHFxTmDRI+NxIWQXkefF8CWC/h2b5+nFJxlsE4z3nLzV8Bgc3UI5R9VlvD2m1RRyKP86YuAd2e3Nak4Gf2zgOKxO2ruPkhDBUd60eygyxQnXgUFiYr1TGlZ0CcrQnaihccuRHXqrkRE3M=
Content-Type: multipart/mixed;
 boundary="_002_DM5PR12MB1418D3E9455862CE61D9B094FC2E0DM5PR12MB1418namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf85f3a-9503-4a18-0313-08d787894d30
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2019 09:20:06.9976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: etORUEewpuJGi0JVNSc55PDcPH2roQUamr4gp1DPzekJx4NFIgNRHGpVY8PL5XKapSQ0rjFsq2jaK0LfTLfhmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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
Cc: "Min, Frank" <Frank.Min@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_002_DM5PR12MB1418D3E9455862CE61D9B094FC2E0DM5PR12MB1418namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi Frank,

The new function amdgpu_xgmi_get_session_id seems not necessary to me becau=
se you just need to delay the xgmi ta loading until IH get initialized. The=
 xgmi session Id will be updated to xgmi_context so it should be okay anyti=
me you want use it to issue any cmd to xgmi ta. I think it should work if y=
ou call psp_xgmi_init directly from xgmi_add_device. Is that correct?

Instead of having xgmi ta session initialization for sriov and bare-metal u=
se scenario respectively, I'd like to have a unified sequence for both use =
scenario anyway. It seems to me, moving xgmi ta session initialization to x=
gmi_add_device should just work. We should also terminate the session in xg=
mi_remove_device, and accordingly, current xgmi ta session termination from=
 psp_hw_fini will not be needed anymore. The current xgmi ta session init/f=
ini sequence in suspend/resume should work and don't need any change.=20

I quickly created the attached patch, can you try it in sriov to see whethe=
r it works or not?

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Frank.Mi=
n
Sent: Thursday, December 19, 2019 19:44
To: amd-gfx@lists.freedesktop.org
Cc: Min, Frank <Frank.Min@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add psp session ID get interface for sriov

on sriov, psp vf ring running depends on interrupt, so have to move the xgm=
i TA loading after IH hw init.

Change-Id: Ieffb3a94107c437f54abc0c41238c6f40274b35d
Signed-off-by: Frank.Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  |  4 ++--  drivers/gpu/drm/amd/am=
dgpu/amdgpu_psp.h  |  2 +-  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 16 +=
+++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h |  1 +
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index a0bee12b095f..73c393392b0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -573,7 +573,7 @@ static int psp_xgmi_terminate(struct psp_context *psp)
 	return 0;
 }
=20
-static int psp_xgmi_initialize(struct psp_context *psp)
+int psp_xgmi_initialize(struct psp_context *psp)
 {
 	struct ta_xgmi_shared_memory *xgmi_cmd;
 	int ret;
@@ -1540,7 +1540,7 @@ static int psp_load_fw(struct amdgpu_device *adev)
 		return ret;
 	}
=20
-	if (adev->gmc.xgmi.num_physical_nodes > 1) {
+	if (adev->gmc.xgmi.num_physical_nodes > 1 && !amdgpu_sriov_vf(adev)) {
 		ret =3D psp_xgmi_initialize(psp);
 		/* Warning the XGMI seesion initialize failure
 		 * Instead of stop driver initialization diff --git a/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 5f8fd3e3535b..a29ffe2e5b45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -362,7 +362,7 @@ int psp_update_vcn_sram(struct amdgpu_device *adev, int=
 inst_idx,
 			uint64_t cmd_gpu_addr, int cmd_size);
=20
 int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
-
+int psp_xgmi_initialize(struct psp_context *psp);
 int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id);  int psp_=
ras_enable_features(struct psp_context *psp,
 		union ta_ras_cmd_input *info, bool enable); diff --git a/drivers/gpu/drm=
/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 61d13d8b7b20..f791ff3f1f64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -357,6 +357,19 @@ int amdgpu_xgmi_get_hops_count(struct amdgpu_device *a=
dev,
 	return	-EINVAL;
 }
=20
+int amdgpu_xgmi_get_session_id(struct amdgpu_device *adev) {
+	int ret;
+
+	if (amdgpu_sriov_vf(adev) && !adev->psp.xgmi_context.initialized)
+		ret =3D psp_xgmi_initialize(&adev->psp);
+
+	if (adev->psp.xgmi_context.initialized)
+		return adev->psp.xgmi_context.session_id;
+	else
+		return -EINVAL;
+}
+
 int amdgpu_xgmi_add_device(struct amdgpu_device *adev)  {
 	struct psp_xgmi_topology_info *top_info; @@ -369,6 +382,9 @@ int amdgpu_x=
gmi_add_device(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.supported)
 		return 0;
=20
+	if(amdgpu_sriov_vf(adev))
+		amdgpu_xgmi_get_session_id(adev);
+
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		ret =3D psp_xgmi_get_hive_id(&adev->psp, &adev->gmc.xgmi.hive_id);
 		if (ret) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.h
index bbf504ff7051..9e917208e25f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -36,6 +36,7 @@ struct amdgpu_hive_info {  };
=20
 struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, =
int lock);
+int amdgpu_xgmi_get_session_id(struct amdgpu_device *adev);
 int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdg=
pu_device *adev);  int amdgpu_xgmi_add_device(struct amdgpu_device *adev); =
 void amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Chawking.=
zhang%40amd.com%7C16d07ba8c7944b406a9d08d78478bbaa%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637123526464445790&amp;sdata=3DfKkuHBIZkQi6KNKyUhj3gC0=
XZ8ta2Gb0ljQhhwmChUY%3D&amp;reserved=3D0

--_002_DM5PR12MB1418D3E9455862CE61D9B094FC2E0DM5PR12MB1418namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-move-xgmi-init-fini-to-xgmi_add-remove_de.patch"
Content-Description:  0001-drm-amdgpu-move-xgmi-init-fini-to-xgmi_add-remove_de.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-move-xgmi-init-fini-to-xgmi_add-remove_de.patch";
	size=5453; creation-date="Mon, 23 Dec 2019 09:11:52 GMT";
	modification-date="Mon, 23 Dec 2019 09:11:17 GMT"
Content-Transfer-Encoding: base64

RnJvbSBkODFkNjcyZDI1MDRmYzEzNjFjODM4MGE2YjFkN2ZmNjM2NmIzYjhhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+
CkRhdGU6IE1vbiwgMjMgRGVjIDIwMTkgMTY6NTE6NDIgKzA4MDAKU3ViamVjdDogW1BBVENIXSBk
cm0vYW1kZ3B1OiBtb3ZlIHhnbWkgaW5pdC9maW5pIHRvIHhnbWlfYWRkL3JlbW92ZV9kZXZpY2UK
IGNhbGwKCkZvciBzcmlvdiwgcHNwIGlwIGJsb2NrIGhhcyB0byBiZSBpbml0aWFsaXplZCBiZWZv
cmUKaWggYmxvY2sgZm9yIHRoZSBkeW5hbWljIHJlZ2lzdGVyIHByb2dyYW1taW5nIGludGVyZmFj
ZQp0aGF0IG5lZWRlZCBmb3IgdmYgaWggcmluZyBidWZmZXIuIE9uIHRoZSBvdGhlciBoYW5kLApj
dXJyZW50IHBzcCBpcCBibG9jayBod19pbml0IGZ1bmN0aW9uIHdpbGwgaW5pdGlhbGl6ZQp4Z21p
IHNlc3Npb24gd2hpY2ggYWN0YXVsbHkgZGVwZW5kcyBvbiBpbnRlcnJ1cHQgdG8KcmV0dXJuIHNl
c3Npb24gY29udGV4dC4gVGhpcyByZXN1bHRzIGFuIGVtcHR5IHhnbWkgdGEKc2Vzc2lvbiBpZCBh
bmQgbGF0ZXIgZmFpbHVyZXMgb24gYWxsIHRoZSB4Z21pIHRhIGNtZAppbnZva2VkIGZyb20gdmYu
IHhnbWkgdGEgc2Vzc2lvbiBpbml0aWFsaXphdGlvbiBoYXMgdG8KYmUgZG9uZSBhZnRlciBpaCBp
cCBibG9jayBod19pbml0IGNhbGwuCgp0byB1bmlmeSB4Z21pIHNlc3Npb24gaW5pdC9maW5pIGZv
ciBib3RoIGJhcmUtbWV0YWwKc3Jpb3YgdmlydHVhbGl6YXRpb24gdXNlIHNjZW5hcmlvLCBtb3Zl
IHhnbWkgdGEgaW5pdAp0byB4Z21pX2FkZF9kZXZpY2UgY2FsbCwgYW5kIGFjY29yZGluZ2x5IHRl
cm1pbmF0ZSB4Z21pCnRhIHNlc3Npb24gaW4geGdtaV9yZW1vdmVfZGV2aWNlIGNhbGwuCgpUaGUg
ZXhpc3Rpbmcgc3VzcGVuZC9yZXN1bWUgc2VxdWVuY2Ugd2lsbCBub3QgYmUgY2hhbmdlZC4KCkNo
YW5nZS1JZDogSTQwNzc2YWYyOGU0NWQyZDVlZDlmODdiMjg5ODMwNjljNzQ2ZjJmMmUKU2lnbmVk
LW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyAgfCAxOCArKy0tLS0tLS0tLS0tLS0t
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuaCAgfCAgMiArKwogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuYyB8IDExICsrKysrKysrKystCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5oIHwgIDIgKy0KIDQgZmlsZXMg
Y2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCmluZGV4IDNlMjkzYTNjMmZiZi4uNjQ5MjE5NmNlZjVj
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCkBAIC01NjEsNyArNTYx
LDcgQEAgaW50IHBzcF94Z21pX2ludm9rZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwgdWludDMy
X3QgdGFfY21kX2lkKQogICAgICAgICByZXR1cm4gcmV0OwogfQogCi1zdGF0aWMgaW50IHBzcF94
Z21pX3Rlcm1pbmF0ZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKK2ludCBwc3BfeGdtaV90ZXJt
aW5hdGUoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiB7CiAJaW50IHJldDsKIApAQCAtNTgyLDcg
KzU4Miw3IEBAIHN0YXRpYyBpbnQgcHNwX3hnbWlfdGVybWluYXRlKHN0cnVjdCBwc3BfY29udGV4
dCAqcHNwKQogCXJldHVybiAwOwogfQogCi1zdGF0aWMgaW50IHBzcF94Z21pX2luaXRpYWxpemUo
c3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCitpbnQgcHNwX3hnbWlfaW5pdGlhbGl6ZShzdHJ1Y3Qg
cHNwX2NvbnRleHQgKnBzcCkKIHsKIAlzdHJ1Y3QgdGFfeGdtaV9zaGFyZWRfbWVtb3J5ICp4Z21p
X2NtZDsKIAlpbnQgcmV0OwpAQCAtMTU1NSwxNiArMTU1NSw2IEBAIHN0YXRpYyBpbnQgcHNwX2xv
YWRfZncoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCXJldHVybiByZXQ7CiAJfQogCi0J
aWYgKGFkZXYtPmdtYy54Z21pLm51bV9waHlzaWNhbF9ub2RlcyA+IDEpIHsKLQkJcmV0ID0gcHNw
X3hnbWlfaW5pdGlhbGl6ZShwc3ApOwotCQkvKiBXYXJuaW5nIHRoZSBYR01JIHNlZXNpb24gaW5p
dGlhbGl6ZSBmYWlsdXJlCi0JCSAqIEluc3RlYWQgb2Ygc3RvcCBkcml2ZXIgaW5pdGlhbGl6YXRp
b24KLQkJICovCi0JCWlmIChyZXQpCi0JCQlkZXZfZXJyKHBzcC0+YWRldi0+ZGV2LAotCQkJCSJY
R01JOiBGYWlsZWQgdG8gaW5pdGlhbGl6ZSBYR01JIHNlc3Npb25cbiIpOwotCX0KLQogCWlmIChw
c3AtPmFkZXYtPnBzcC50YV9mdykgewogCQlyZXQgPSBwc3BfcmFzX2luaXRpYWxpemUocHNwKTsK
IAkJaWYgKHJldCkKQEAgLTE2MjksMTAgKzE2MTksNiBAQCBzdGF0aWMgaW50IHBzcF9od19maW5p
KHZvaWQgKmhhbmRsZSkKIAl2b2lkICp0bXJfYnVmOwogCXZvaWQgKipwcHRyOwogCi0JaWYgKGFk
ZXYtPmdtYy54Z21pLm51bV9waHlzaWNhbF9ub2RlcyA+IDEgJiYKLQkgICAgcHNwLT54Z21pX2Nv
bnRleHQuaW5pdGlhbGl6ZWQgPT0gMSkKLSAgICAgICAgICAgICAgICBwc3BfeGdtaV90ZXJtaW5h
dGUocHNwKTsKLQogCWlmIChwc3AtPmFkZXYtPnBzcC50YV9mdykgewogCQlwc3BfcmFzX3Rlcm1p
bmF0ZShwc3ApOwogCQlwc3BfZHRtX3Rlcm1pbmF0ZShwc3ApOwpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3BzcC5oCmluZGV4IDVmOGZkM2UzNTM1Yi4uNTUwYWVmYTJhNjk4IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmgKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5oCkBAIC0zNjEsNiArMzYxLDggQEAg
aW50IHBzcF9ncHVfcmVzZXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwogaW50IHBzcF91
cGRhdGVfdmNuX3NyYW0oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGludCBpbnN0X2lkeCwK
IAkJCXVpbnQ2NF90IGNtZF9ncHVfYWRkciwgaW50IGNtZF9zaXplKTsKIAoraW50IHBzcF94Z21p
X2luaXRpYWxpemUoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApOworaW50IHBzcF94Z21pX3Rlcm1p
bmF0ZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCk7CiBpbnQgcHNwX3hnbWlfaW52b2tlKHN0cnVj
dCBwc3BfY29udGV4dCAqcHNwLCB1aW50MzJfdCB0YV9jbWRfaWQpOwogCiBpbnQgcHNwX3Jhc19p
bnZva2Uoc3RydWN0IHBzcF9jb250ZXh0ICpwc3AsIHVpbnQzMl90IHRhX2NtZF9pZCk7CmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuYwppbmRleCA1Y2Y5MjBkOTM1OGIuLmJk
Zjc0NzEzM2MwOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3hnbWkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5jCkBA
IC0zNzEsNiArMzcxLDEzIEBAIGludCBhbWRncHVfeGdtaV9hZGRfZGV2aWNlKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2KQogCQlyZXR1cm4gMDsKIAogCWlmIChhbWRncHVfZGV2aWNlX2lwX2dl
dF9pcF9ibG9jayhhZGV2LCBBTURfSVBfQkxPQ0tfVFlQRV9QU1ApKSB7CisJCXJldCA9IHBzcF94
Z21pX2luaXRpYWxpemUoJmFkZXYtPnBzcCk7CisJCWlmIChyZXQpIHsKKwkJCWRldl9lcnIoYWRl
di0+ZGV2LAorCQkJCSJYR01JOiBGYWlsZWQgdG8gaW5pdGlhbGl6ZSB4Z21pIHNlc3Npb25cbiIp
OworCQkJcmV0dXJuIHJldDsKKwkJfQorCiAJCXJldCA9IHBzcF94Z21pX2dldF9oaXZlX2lkKCZh
ZGV2LT5wc3AsICZhZGV2LT5nbWMueGdtaS5oaXZlX2lkKTsKIAkJaWYgKHJldCkgewogCQkJZGV2
X2VycihhZGV2LT5kZXYsCkBAIC00NTcsNyArNDY0LDcgQEAgaW50IGFtZGdwdV94Z21pX2FkZF9k
ZXZpY2Uoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJcmV0dXJuIHJldDsKIH0KIAotdm9p
ZCBhbWRncHVfeGdtaV9yZW1vdmVfZGV2aWNlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQor
aW50IGFtZGdwdV94Z21pX3JlbW92ZV9kZXZpY2Uoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
CiB7CiAJc3RydWN0IGFtZGdwdV9oaXZlX2luZm8gKmhpdmU7CiAKQEAgLTQ3Nyw2ICs0ODQsOCBA
QCB2b2lkIGFtZGdwdV94Z21pX3JlbW92ZV9kZXZpY2Uoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpCiAJCWFtZGdwdV94Z21pX3N5c2ZzX3JlbV9kZXZfaW5mbyhhZGV2LCBoaXZlKTsKIAkJbXV0
ZXhfdW5sb2NrKCZoaXZlLT5oaXZlX2xvY2spOwogCX0KKworCXJldHVybiBwc3BfeGdtaV90ZXJt
aW5hdGUoJmFkZXYtPnBzcCk7CiB9CiAKIGludCBhbWRncHVfeGdtaV9yYXNfbGF0ZV9pbml0KHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3hnbWkuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV94Z21pLmgKaW5kZXggNzQwMTFmYmMyMjUxLi5jNjJhNGFjZjRjMTQgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21pLmgKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuaApAQCAtNDAsNyArNDAsNyBAQCBzdHJ1Y3QgYW1k
Z3B1X2hpdmVfaW5mbyB7CiBzdHJ1Y3QgYW1kZ3B1X2hpdmVfaW5mbyAqYW1kZ3B1X2dldF94Z21p
X2hpdmUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGludCBsb2NrKTsKIGludCBhbWRncHVf
eGdtaV91cGRhdGVfdG9wb2xvZ3koc3RydWN0IGFtZGdwdV9oaXZlX2luZm8gKmhpdmUsIHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KTsKIGludCBhbWRncHVfeGdtaV9hZGRfZGV2aWNlKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KTsKLXZvaWQgYW1kZ3B1X3hnbWlfcmVtb3ZlX2RldmljZShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7CitpbnQgYW1kZ3B1X3hnbWlfcmVtb3ZlX2Rldmlj
ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7CiBpbnQgYW1kZ3B1X3hnbWlfc2V0X3BzdGF0
ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgaW50IHBzdGF0ZSk7CiBpbnQgYW1kZ3B1X3hn
bWlfZ2V0X2hvcHNfY291bnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCXN0cnVjdCBh
bWRncHVfZGV2aWNlICpwZWVyX2FkZXYpOwotLSAKMi4xNy4xCgo=

--_002_DM5PR12MB1418D3E9455862CE61D9B094FC2E0DM5PR12MB1418namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_002_DM5PR12MB1418D3E9455862CE61D9B094FC2E0DM5PR12MB1418namp_--
