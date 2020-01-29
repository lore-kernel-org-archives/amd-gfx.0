Return-Path: <SRS0=fmWI=3S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C4DC33CB7
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2020 08:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BB6520720
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2020 08:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TWmGCgAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB6520720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0DFC6E20E;
	Wed, 29 Jan 2020 08:20:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1FC46E20E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2020 08:20:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cX0cSLU6xjdbwoLekATAqufQ6K/lBG+ctGA47gR6eY9CPsWjuQ2GOaMi5iOpdH/aKRfycVBsZl96kaVM5yr6J1XFzx8yenofVq5fIypEckLO5MQcdv7lcWmGetAd0ONTGI26ABN07btp15JoR8JKa5TEN7D+xMoptqLG1dvb0J0m1Day09hQPBan5zjvo4A/DePvQXzsN753rNOJv28+4rcQU80fIujgpDqpwT7q5/Z3IFCDtZMK6osorJ1AnzjeSKmxpLqWSQ8Y6BM8DjQBaF4/uJLrZSikBcQrU2+AwbO5j2EBhL+Na/iTIfGzR8sd72klpna6k9V3IeMfxUnbdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tseHv4Df12OoJQ2SoGMhrdBgj4mGaPs2OErq2YW2Bww=;
 b=hWyPL32xZGlfn0Y1Ws16N7aFEbXsZpapeUUUQgqROiPV2RY+hkUEOjgaZVqAN/BsBYAE6+GTNa2hLz+MWKVLtseFCSn+CKIMCcJtCuvzMiWiV7Z8d1JaeuP63jVLR8pah9KCaWSYFJStwOYQZNm6ZmNFvOyMN4P2sd6mrLi9MFe7EtYApnDPfk8HXLt+ZZoNicIJ8gI2Zp4w0iWvkztjrX37H5oO0oB5HI3WU4xqhBY8FwrSayoMjl6qP2sa2oV1p15B4ct+XaN92NVyUI59lNYw8pArtIr6buXNrbsaZQFfPzJLbrvJxFzcdP/I5hchdwC0AKfwJxPFYgg2brRxZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tseHv4Df12OoJQ2SoGMhrdBgj4mGaPs2OErq2YW2Bww=;
 b=TWmGCgALWBR5dVaO+tj3ENij1sd0l1uChjHNK3x0QI4DvOwdu9r79k+u1debUsUdB+KD5lmRAtn8LcFRRT9p5M3/qUOI8MhhesRjeGhQxn6RbUF/ZVZcBzVG9VVp5+Np3vQc4sq1pHy4KjRM8dsOSyUSME+OYQg+csphREn/pNA=
Received: from CH2PR12MB3718.namprd12.prod.outlook.com (52.132.246.224) by
 CH2PR12MB4070.namprd12.prod.outlook.com (20.180.16.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Wed, 29 Jan 2020 08:20:29 +0000
Received: from CH2PR12MB3718.namprd12.prod.outlook.com
 ([fe80::8119:5116:afee:d6a6]) by CH2PR12MB3718.namprd12.prod.outlook.com
 ([fe80::8119:5116:afee:d6a6%6]) with mapi id 15.20.2686.025; Wed, 29 Jan 2020
 08:20:29 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: move xgmi init/fini to xgmi_add/remove_device call
Thread-Topic: [PATCH] drm/amdgpu: move xgmi init/fini to
 xgmi_add/remove_device call
Thread-Index: AdXWe6S+xR7DnsVIQIa3DacyoH/uZw==
Date: Wed, 29 Jan 2020 08:20:29 +0000
Message-ID: <CH2PR12MB3718C0B46BAB7C0DDA173A42E9050@CH2PR12MB3718.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Frank.Min@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac068ace-5688-4ac6-8b1f-08d7a49419dc
x-ms-traffictypediagnostic: CH2PR12MB4070:|CH2PR12MB4070:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB40703441D35784126E1B4C7DE9050@CH2PR12MB4070.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(189003)(199004)(52536014)(5660300002)(2906002)(478600001)(86362001)(7696005)(55016002)(9686003)(33656002)(8676002)(81156014)(81166006)(8936002)(71200400001)(6506007)(66946007)(316002)(186003)(66616009)(53546011)(66476007)(66556008)(110136005)(66446008)(76116006)(64756008)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4070;
 H:CH2PR12MB3718.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cKCHLfnhmg200aQZQ3f6vZZtU8bMuAPI8qcfBr7a44tBxZMvmaGw47hNkXTl5ggLZDQN4cuurBLnjuFSzyQLZ+Ime7sighdrJwlMwl2ABF2E6ZYPFWzZWWeNDrHp+R8mgYeduOEqrXrlLI8yRT8G1RFjwlo+e9KzIpgzYDl83gKRRMAkivcccl6SlQ6Cbolog0t7ExtWi5/f09AeGsY76mUo6vfQER1V+PQudGnj3Y60lo3Wna5REzToukGY6XVEfEE5neIIdKw4MG8iLmCx0w7dbUtLbPislY2CqnXPIPV0r88xi+7ULVumoMJ0rClxkrl8TlTc5Rlfc9WwA0aYlwo/yrMixyC3GCYFn0sW0yW9uHHO5zqIhedJuwGZRsSLvi+/gARBlUANxKE++vP1Kx0IUHOmbSchHfvgY6zO0fBlbcFlKmX9KM3lBzpa+2eu
x-ms-exchange-antispam-messagedata: pwEJ8eT/+50ByasoXFBjTCnrMnFrFa+LaxDXAxi/2yTAM0CoQE4qIE631A447F+yQ5VNLbFLnQ7i8lxaHeKqAiurodQ2UuOrAoNYLg5amhmd/IXzo0GGwXoL8cswPapCBPLVjNEkmuX2VTVHN572Yg==
Content-Type: multipart/mixed;
 boundary="_002_CH2PR12MB3718C0B46BAB7C0DDA173A42E9050CH2PR12MB3718namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac068ace-5688-4ac6-8b1f-08d7a49419dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 08:20:29.0434 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c2L25tMtRDkj0Rn5MzpvfuV/MkMqEP2F1mRSgB09+7kwWckSAGZushm6uhmD4QPn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_002_CH2PR12MB3718C0B46BAB7C0DDA173A42E9050CH2PR12MB3718namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From: Hawking Zhang <Hawking.Zhang@amd.com>
Date: Mon, 23 Dec 2019 16:51:42 +0800
Subject: [PATCH] drm/amdgpu: move xgmi init/fini to xgmi_add/remove_device
 call

For sriov, psp ip block has to be initialized before
ih block for the dynamic register programming interface
that needed for vf ih ring buffer. On the other hand,
current psp ip block hw_init function will initialize
xgmi session which actaully depends on interrupt to
return session context. This results an empty xgmi ta
session id and later failures on all the xgmi ta cmd
invoked from vf. xgmi ta session initialization has to
be done after ih ip block hw_init call.

to unify xgmi session init/fini for both bare-metal
sriov virtualization use scenario, move xgmi ta init
to xgmi_add_device call, and accordingly terminate xgmi
ta session in xgmi_remove_device call.

The existing suspend/resume sequence will not be changed.

Change-Id: I40776af28e45d2d5ed9f87b28983069c746f2f2e
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 18 ++----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h  |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 11 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h |  2 +-
 4 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 3a1570dafe34..939a114605c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -558,7 +558,7 @@ int psp_xgmi_invoke(struct psp_context *psp, uint32_t t=
a_cmd_id)
        return psp_ta_invoke(psp, ta_cmd_id, psp->xgmi_context.session_id);
 }

-static int psp_xgmi_terminate(struct psp_context *psp)
+int psp_xgmi_terminate(struct psp_context *psp)
 {
        int ret;

@@ -579,7 +579,7 @@ static int psp_xgmi_terminate(struct psp_context *psp)
        return 0;
 }

-static int psp_xgmi_initialize(struct psp_context *psp)
+int psp_xgmi_initialize(struct psp_context *psp)
 {
        struct ta_xgmi_shared_memory *xgmi_cmd;
        int ret;
@@ -1420,16 +1420,6 @@ static int psp_load_fw(struct amdgpu_device *adev)
                return ret;
        }

-       if (adev->gmc.xgmi.num_physical_nodes > 1) {
-               ret =3D psp_xgmi_initialize(psp);
-               /* Warning the XGMI seesion initialize failure
-                * Instead of stop driver initialization
-                */
-               if (ret)
-                       dev_err(psp->adev->dev,
-                               "XGMI: Failed to initialize XGMI session\n"=
);
-       }
-
        if (psp->adev->psp.ta_fw) {
                ret =3D psp_ras_initialize(psp);
                if (ret)
@@ -1494,10 +1484,6 @@ static int psp_hw_fini(void *handle)
        void *tmr_buf;
        void **pptr;

-       if (adev->gmc.xgmi.num_physical_nodes > 1 &&
-           psp->xgmi_context.initialized =3D=3D 1)
-                psp_xgmi_terminate(psp);
-
        if (psp->adev->psp.ta_fw) {
                psp_ras_terminate(psp);
                psp_dtm_terminate(psp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index 611021514c52..c77e1abb538a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -362,6 +362,8 @@ int psp_gpu_reset(struct amdgpu_device *adev);
 int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
                        uint64_t cmd_gpu_addr, int cmd_size);

+int psp_xgmi_initialize(struct psp_context *psp);
+int psp_xgmi_terminate(struct psp_context *psp);
 int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id);

 int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index a97af422575a..78989e9560d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -365,6 +365,13 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
                return 0;

        if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
+               ret =3D psp_xgmi_initialize(&adev->psp);
+               if (ret) {
+                       dev_err(adev->dev,
+                               "XGMI: Failed to initialize xgmi session\n"=
);
+                       return ret;
+               }
+
                ret =3D psp_xgmi_get_hive_id(&adev->psp, &adev->gmc.xgmi.hi=
ve_id);
                if (ret) {
                        dev_err(adev->dev,
@@ -451,7 +458,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
        return ret;
 }

-void amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
+int amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
 {
        struct amdgpu_hive_info *hive;

@@ -471,6 +478,8 @@ void amdgpu_xgmi_remove_device(struct amdgpu_device *ad=
ev)
                amdgpu_xgmi_sysfs_rem_dev_info(adev, hive);
                mutex_unlock(&hive->hive_lock);
        }
+
+       return psp_xgmi_terminate(&adev->psp);
 }

 int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.h
index 74011fbc2251..c62a4acf4c14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -40,7 +40,7 @@ struct amdgpu_hive_info {
 struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, =
int lock);
 int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdg=
pu_device *adev);
 int amdgpu_xgmi_add_device(struct amdgpu_device *adev);
-void amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
+int amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
 int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate);
 int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
                struct amdgpu_device *peer_adev);
--
2.17.1


--_002_CH2PR12MB3718C0B46BAB7C0DDA173A42E9050CH2PR12MB3718namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-move-xgmi-init-fini-to-xgmi_add-remove_de.patch"
Content-Description:  0001-drm-amdgpu-move-xgmi-init-fini-to-xgmi_add-remove_de.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-move-xgmi-init-fini-to-xgmi_add-remove_de.patch";
	size=5545; creation-date="Wed, 29 Jan 2020 08:17:21 GMT";
	modification-date="Wed, 29 Jan 2020 08:17:21 GMT"
Content-Transfer-Encoding: base64

RnJvbSA3MjE1NjNjN2QwZWUzMzE5NmM0YjcxYWE1YzMwZDRmY2RkNTFhNWNjIE1vbiBTZXAgMTcg
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
LW9mZi1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgpSZXZpZXdlZC1i
eTogRnJhbmsgTWluIDxGcmFuay5NaW5AYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcHNwLmMgIHwgMTggKystLS0tLS0tLS0tLS0tLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmggIHwgIDIgKysKIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV94Z21pLmMgfCAxMSArKysrKysrKysrLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuaCB8ICAyICstCiA0IGZpbGVzIGNoYW5nZWQsIDE1IGlu
c2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9wc3AuYwppbmRleCAzYTE1NzBkYWZlMzQuLjkzOWExMTQ2MDVjMCAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwpAQCAtNTU4LDcgKzU1OCw3IEBAIGludCBwc3Bf
eGdtaV9pbnZva2Uoc3RydWN0IHBzcF9jb250ZXh0ICpwc3AsIHVpbnQzMl90IHRhX2NtZF9pZCkK
IAlyZXR1cm4gcHNwX3RhX2ludm9rZShwc3AsIHRhX2NtZF9pZCwgcHNwLT54Z21pX2NvbnRleHQu
c2Vzc2lvbl9pZCk7CiB9CiAKLXN0YXRpYyBpbnQgcHNwX3hnbWlfdGVybWluYXRlKHN0cnVjdCBw
c3BfY29udGV4dCAqcHNwKQoraW50IHBzcF94Z21pX3Rlcm1pbmF0ZShzdHJ1Y3QgcHNwX2NvbnRl
eHQgKnBzcCkKIHsKIAlpbnQgcmV0OwogCkBAIC01NzksNyArNTc5LDcgQEAgc3RhdGljIGludCBw
c3BfeGdtaV90ZXJtaW5hdGUoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiAJcmV0dXJuIDA7CiB9
CiAKLXN0YXRpYyBpbnQgcHNwX3hnbWlfaW5pdGlhbGl6ZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBz
cCkKK2ludCBwc3BfeGdtaV9pbml0aWFsaXplKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQogewog
CXN0cnVjdCB0YV94Z21pX3NoYXJlZF9tZW1vcnkgKnhnbWlfY21kOwogCWludCByZXQ7CkBAIC0x
NDIwLDE2ICsxNDIwLDYgQEAgc3RhdGljIGludCBwc3BfbG9hZF9mdyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikKIAkJcmV0dXJuIHJldDsKIAl9CiAKLQlpZiAoYWRldi0+Z21jLnhnbWkubnVt
X3BoeXNpY2FsX25vZGVzID4gMSkgewotCQlyZXQgPSBwc3BfeGdtaV9pbml0aWFsaXplKHBzcCk7
Ci0JCS8qIFdhcm5pbmcgdGhlIFhHTUkgc2Vlc2lvbiBpbml0aWFsaXplIGZhaWx1cmUKLQkJICog
SW5zdGVhZCBvZiBzdG9wIGRyaXZlciBpbml0aWFsaXphdGlvbgotCQkgKi8KLQkJaWYgKHJldCkK
LQkJCWRldl9lcnIocHNwLT5hZGV2LT5kZXYsCi0JCQkJIlhHTUk6IEZhaWxlZCB0byBpbml0aWFs
aXplIFhHTUkgc2Vzc2lvblxuIik7Ci0JfQotCiAJaWYgKHBzcC0+YWRldi0+cHNwLnRhX2Z3KSB7
CiAJCXJldCA9IHBzcF9yYXNfaW5pdGlhbGl6ZShwc3ApOwogCQlpZiAocmV0KQpAQCAtMTQ5NCwx
MCArMTQ4NCw2IEBAIHN0YXRpYyBpbnQgcHNwX2h3X2Zpbmkodm9pZCAqaGFuZGxlKQogCXZvaWQg
KnRtcl9idWY7CiAJdm9pZCAqKnBwdHI7CiAKLQlpZiAoYWRldi0+Z21jLnhnbWkubnVtX3BoeXNp
Y2FsX25vZGVzID4gMSAmJgotCSAgICBwc3AtPnhnbWlfY29udGV4dC5pbml0aWFsaXplZCA9PSAx
KQotICAgICAgICAgICAgICAgIHBzcF94Z21pX3Rlcm1pbmF0ZShwc3ApOwotCiAJaWYgKHBzcC0+
YWRldi0+cHNwLnRhX2Z3KSB7CiAJCXBzcF9yYXNfdGVybWluYXRlKHBzcCk7CiAJCXBzcF9kdG1f
dGVybWluYXRlKHBzcCk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcHNwLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmgKaW5k
ZXggNjExMDIxNTE0YzUyLi5jNzdlMWFiYjUzOGEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfcHNwLmgKQEAgLTM2Miw2ICszNjIsOCBAQCBpbnQgcHNwX2dwdV9yZXNldChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7CiBpbnQgcHNwX3VwZGF0ZV92Y25fc3JhbShzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwgaW50IGluc3RfaWR4LAogCQkJdWludDY0X3QgY21kX2dwdV9h
ZGRyLCBpbnQgY21kX3NpemUpOwogCitpbnQgcHNwX3hnbWlfaW5pdGlhbGl6ZShzdHJ1Y3QgcHNw
X2NvbnRleHQgKnBzcCk7CitpbnQgcHNwX3hnbWlfdGVybWluYXRlKHN0cnVjdCBwc3BfY29udGV4
dCAqcHNwKTsKIGludCBwc3BfeGdtaV9pbnZva2Uoc3RydWN0IHBzcF9jb250ZXh0ICpwc3AsIHVp
bnQzMl90IHRhX2NtZF9pZCk7CiAKIGludCBwc3BfcmFzX2ludm9rZShzdHJ1Y3QgcHNwX2NvbnRl
eHQgKnBzcCwgdWludDMyX3QgdGFfY21kX2lkKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21pLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfeGdtaS5jCmluZGV4IGE5N2FmNDIyNTc1YS4uNzg5ODllOTU2MGQxIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV94Z21pLmMKQEAgLTM2NSw2ICszNjUsMTMgQEAgaW50
IGFtZGdwdV94Z21pX2FkZF9kZXZpY2Uoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCXJl
dHVybiAwOwogCiAJaWYgKGFtZGdwdV9kZXZpY2VfaXBfZ2V0X2lwX2Jsb2NrKGFkZXYsIEFNRF9J
UF9CTE9DS19UWVBFX1BTUCkpIHsKKwkJcmV0ID0gcHNwX3hnbWlfaW5pdGlhbGl6ZSgmYWRldi0+
cHNwKTsKKwkJaWYgKHJldCkgeworCQkJZGV2X2VycihhZGV2LT5kZXYsCisJCQkJIlhHTUk6IEZh
aWxlZCB0byBpbml0aWFsaXplIHhnbWkgc2Vzc2lvblxuIik7CisJCQlyZXR1cm4gcmV0OworCQl9
CisKIAkJcmV0ID0gcHNwX3hnbWlfZ2V0X2hpdmVfaWQoJmFkZXYtPnBzcCwgJmFkZXYtPmdtYy54
Z21pLmhpdmVfaWQpOwogCQlpZiAocmV0KSB7CiAJCQlkZXZfZXJyKGFkZXYtPmRldiwKQEAgLTQ1
MSw3ICs0NTgsNyBAQCBpbnQgYW1kZ3B1X3hnbWlfYWRkX2RldmljZShzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikKIAlyZXR1cm4gcmV0OwogfQogCi12b2lkIGFtZGdwdV94Z21pX3JlbW92ZV9k
ZXZpY2Uoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCitpbnQgYW1kZ3B1X3hnbWlfcmVtb3Zl
X2RldmljZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKIAlzdHJ1Y3QgYW1kZ3B1X2hp
dmVfaW5mbyAqaGl2ZTsKIApAQCAtNDcxLDYgKzQ3OCw4IEBAIHZvaWQgYW1kZ3B1X3hnbWlfcmVt
b3ZlX2RldmljZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkJYW1kZ3B1X3hnbWlfc3lz
ZnNfcmVtX2Rldl9pbmZvKGFkZXYsIGhpdmUpOwogCQltdXRleF91bmxvY2soJmhpdmUtPmhpdmVf
bG9jayk7CiAJfQorCisJcmV0dXJuIHBzcF94Z21pX3Rlcm1pbmF0ZSgmYWRldi0+cHNwKTsKIH0K
IAogaW50IGFtZGdwdV94Z21pX3Jhc19sYXRlX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5o
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3hnbWkuaAppbmRleCA3NDAxMWZi
YzIyNTEuLmM2MmE0YWNmNGMxNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3hnbWkuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
eGdtaS5oCkBAIC00MCw3ICs0MCw3IEBAIHN0cnVjdCBhbWRncHVfaGl2ZV9pbmZvIHsKIHN0cnVj
dCBhbWRncHVfaGl2ZV9pbmZvICphbWRncHVfZ2V0X3hnbWlfaGl2ZShzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwgaW50IGxvY2spOwogaW50IGFtZGdwdV94Z21pX3VwZGF0ZV90b3BvbG9neShz
dHJ1Y3QgYW1kZ3B1X2hpdmVfaW5mbyAqaGl2ZSwgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
OwogaW50IGFtZGdwdV94Z21pX2FkZF9kZXZpY2Uoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
Owotdm9pZCBhbWRncHVfeGdtaV9yZW1vdmVfZGV2aWNlKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KTsKK2ludCBhbWRncHVfeGdtaV9yZW1vdmVfZGV2aWNlKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KTsKIGludCBhbWRncHVfeGdtaV9zZXRfcHN0YXRlKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LCBpbnQgcHN0YXRlKTsKIGludCBhbWRncHVfeGdtaV9nZXRfaG9wc19jb3VudChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJc3RydWN0IGFtZGdwdV9kZXZpY2UgKnBlZXJfYWRl
dik7Ci0tIAoyLjE3LjEKCg==

--_002_CH2PR12MB3718C0B46BAB7C0DDA173A42E9050CH2PR12MB3718namp_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_002_CH2PR12MB3718C0B46BAB7C0DDA173A42E9050CH2PR12MB3718namp_--
