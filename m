Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5BEC34036
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 11:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B25862173E
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 11:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OHHM9TAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25862173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06ABC6E1BA;
	Tue, 18 Feb 2020 11:08:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B12B89804
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 11:08:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfEXLC0H+ZxFp3jYsskg+pA2oKfO0UO33Dmf3Aeh4SeOextrxOpwGk16aqFW9o4VquM+1s0GpH4XP4+1VSb4Pic4n1ysVt1Ylkw/qh9DdbZ8JfveUD30HJ+IwD5szdmC0i0CAxdMb8K36CqLkFN2XcOXGIJZOBqEy2Ed+igSm0g2uDWbzMDDz8BATLH6HumJWiNwVjUtxo0sA8jGd2vlTyxaelqL+pOT2E2U5fqVYXV1pvmk9yi7RJP8zSJS8EdfzB4RjTdUKF8Sbq+vr1vNUZFtycfr0WdMWZ4zOSE3cMoJrVNc8i7f7oIhL2RRXADS0KThngW1n01UJAliXVmF7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dBFmpIlY819AJ6hGttFZG5AvMzRiBjr4lG/lw6s1m4=;
 b=AhaY+uqGZPKHAhhERz5MrgWBcpTqS8lqhLMsdjonIEMUxEtsE0nH2eGAZgyr154p0E7ozks0hjYElkmIDvFTaLXgl2WbfCpKIE2gXntegO5JfxDjW1oGahnzq++iaw1JVYmCdFSJeVPmsptbcPqfNeP3mJ9GF6bTs/AoulwXlWvZCuuJB1U4fn/cyFphm59a2peLRKE5/Qtc2yme3hyYnUaTMj2W4+QcsWJ1lrKEZvAVbTR/g292QMcaSGkMEamtxgq9cBI4/jd6HcvCvh5PImNls3zRvI0uO/vgqyfLe3cOsEa7WwH9Hf+675Z3sPDh/NIL8Ft3SJhlRmLvZ/lctQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dBFmpIlY819AJ6hGttFZG5AvMzRiBjr4lG/lw6s1m4=;
 b=OHHM9TAHAodAt8/biA98x2waw+HxEvj5Fj1Qp6XwJMBu9v6mKlb9RFQpoA1jlFzUc+8hT7FI0yCAy/xhqOTGN4be+5KyhCWEDmIhwC6xw+Tqv5eKMcIORSviiWKUWwJUO6HW1QtJD57ZoAtkH2Dv+Dx5gBk+hNpPid2sx8Z/lI8=
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1465.namprd12.prod.outlook.com (10.172.35.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Tue, 18 Feb 2020 11:08:16 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 11:08:16 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/3] drm/amdgpu: cleanup some incorrect reg access for
 SRIOV
Thread-Topic: [PATCH 1/3] drm/amdgpu: cleanup some incorrect reg access for
 SRIOV
Thread-Index: AQHV5ga8OzGn9iTGYkyRaESmFOwDaKggx/LA
Date: Tue, 18 Feb 2020 11:08:16 +0000
Message-ID: <DM5PR12MB141851C113DF5DC74163D94FFC110@DM5PR12MB1418.namprd12.prod.outlook.com>
References: <1581994453-5498-1-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1581994453-5498-1-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-18T11:08:10Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b6b91ed0-2395-4bb0-9461-000066bdc916;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-18T11:08:10Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: d8c49efc-554d-446b-99ba-00004a9bd244
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7b86ba2b-234e-4723-568e-08d7b462dae2
x-ms-traffictypediagnostic: DM5PR12MB1465:|DM5PR12MB1465:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1465C37E3BD23189A98EE149FC110@DM5PR12MB1465.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(189003)(199004)(52536014)(5660300002)(110136005)(86362001)(316002)(71200400001)(186003)(478600001)(8676002)(81156014)(76116006)(53546011)(66556008)(66946007)(66476007)(9686003)(55016002)(33656002)(7696005)(66446008)(64756008)(8936002)(2906002)(81166006)(6506007)(966005)(4326008)(45080400002)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1465;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VNctxBBqOpiJkx/8YYAM5v7U+GjHqUyjwLJ1c4IoxpXh2JsyaTyQU5LtZJDUY/MIgzTGruLlWRBQiGzi/9kH+3q1BLYPoN2XvQg6Hw5JTZcllOyuao8q3YqWUkf9/FN5cWt0f9fIiCJN+jsZg+nqNLHRO7YttK4jLV0nbwY97IFmCP8cXhr94Fj5c3RiVZDS0B7aeyoyVokO9eTG4Elf6ieFG3fvXqTBFsfN8S1w7Z2ast5dPqgPhr0OK8nu68QenEaCCYUQTnjhQ7wJkYOWWpMeShplvvE1LNTxkQYX8F6kwJ6t+vDpw7ZdVEdXSK8v/Z7Mni3KVmNt4qRZ3AjfKdBogRoxbcKxcsb1CFoxX4fNeet0Tg4Kh3unedZRpMYypWnlVDmsVbPVNGbip+Wv4OKF0d3lHPpMQwP8QsKAeHhUgVJIzkojHDpgwmJ8unRD3vMYiqpQzP49pgJ9AiJ/oKEiZgPZrjM/sfJLH9zman+8RCUXM28JUXSrAgX2UIY/nBYviVVjDxGoR1mCg2bh1Q==
x-ms-exchange-antispam-messagedata: 8EhYZF+zMVRvtHFZMYqyBalcTjla2c/N5xrGyOXv9qkbedJwPXG/P1ISdC+emte5l9R5hmK8oyjALYFPiL96d5kFU0KYYH6X32jphLtoUe63QiJborFnQdAdNh1Tm3jw/pLX4C6AONvJu6FGeYGBhw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b86ba2b-234e-4723-568e-08d7b462dae2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 11:08:16.7276 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: no58OET6yfoud8s2eOuTdpe7hwZBcnUTLIFB3HkgOiLe2qR1zQXuKUnFKWYTvn6SDPEvx/gH5Tn2e3z2HqyB/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1465
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
Cc: "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Please remove the ticket number from the commit description. With that fixed, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Monk Liu
Sent: Tuesday, February 18, 2020 10:54
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: cleanup some incorrect reg access for SRIOV

SWDEV-220810 - some register access from VF is wrong

1)
we shouldn't load PSP kdb and sys/sos for VF, they are supposed to be handled by hypervisor

2)
ih reroute doesn't work on VF thus we should avoid calling it, besides VF should not use those PSP register sets for PF

3)
shouldn't load SMU ucode under SRIOV, otherwise PSP would report error

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++--  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a16c810..3494966 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1081,7 +1081,7 @@ static int psp_hw_start(struct psp_context *psp)
 	struct amdgpu_device *adev = psp->adev;
 	int ret;
 
-	if (!amdgpu_sriov_vf(adev) || !adev->in_gpu_reset) {
+	if (!amdgpu_sriov_vf(adev) && !adev->in_gpu_reset) {
 		if (psp->kdb_bin_size &&
 		    (psp->funcs->bootloader_load_kdb != NULL)) {
 			ret = psp_bootloader_load_kdb(psp);
@@ -1318,7 +1318,7 @@ static int psp_np_fw_load(struct psp_context *psp)
 
 	if (psp->autoload_supported) {
 		ucode = &adev->firmware.ucode[AMDGPU_UCODE_ID_SMC];
-		if (!ucode->fw)
+		if (!ucode->fw || amdgpu_sriov_vf(adev))
 			goto out;
 
 		ret = psp_execute_np_fw_load(psp, ucode); diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 0829188..8ab3bf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -420,7 +420,8 @@ static int psp_v11_0_ring_init(struct psp_context *psp,
 	struct psp_ring *ring;
 	struct amdgpu_device *adev = psp->adev;
 
-	psp_v11_0_reroute_ih(psp);
+	if (!amdgpu_sriov_vf(adev))
+		psp_v11_0_reroute_ih(psp);
 
 	ring = &psp->km_ring;
 
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Chawking.zhang%40amd.com%7C24cf8275f9b64d1f63f608d7b41dddd7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637175912688390004&amp;sdata=pPtcC%2FrKXzrrhRguc8%2FVQL61VS9s6V5Pa95MA5FSXFA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
