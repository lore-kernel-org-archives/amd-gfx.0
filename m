Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3810CC2D0E4
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D26D206E3
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jIWLO2J8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D26D206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9F9289310;
	Mon, 23 Nov 2020 13:30:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C66F89310
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 13:30:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dM9OOPHMSTWFg7s3GEoTBR/Q0SWdHFtoNjujFx50x00pzEHXW6NjTlUIdTPAIgBkFuA/lInf0C7+vip2ZltkxNTrHk7mXFIZn5ulfHhO0reB7T4XwD/cRyN85vPrudE3DIOhlBQUE7XTu/N1TcP3rrRLwUqQJR1fbR/rIUWDdEZBbRZHYhxUOU3zaTzzNwitGw+/nzhFxMhIEl7i9p9LOuASNiDBScHyZVkUcrGfuWIoqNqR1oZ6e86xj5iQalLZJHb8HOBZFKdboVEwaOdZMgQT4Rbludq9xdMvgkUwphobjfS1XJrjzk8dPrOAA8O99AfryM4oal3TO0vewyA/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jmn9TTcHcttm7BrqukYXp8ciiX0N8kkzoaoG7C4qIc=;
 b=AT/Nm7WThXV+NcAUDzjDdNB9Es9hxDpDbB9PdQ3x4uAgUtIXpcGkRI9g3XOF0bMcuFNdWhIuhu5tDVcpoHYEjvnFR1SxIzVFuxxb4pMhaB5kIMhiwgBee6wBRel4B9wQ3Jb0p07o5fmBmWXDRGoVe3xiqfnKlqDy02KOVD7v04SxvP5YxMTnC0MRU2RsrqOTFtI37SpwrHwPzVdIMJ9glI9gwgq0F8KjbCbsKYzM5FCXd43vbZR5FE7GBTddPM5UzOrb5fdITozGv7AuIgCa6iKoxugpNFy1UdjZQj0fnKv8vwnHp4JFq3AtyjoSMiqejwA4MysWg5eVzkOrvjehRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jmn9TTcHcttm7BrqukYXp8ciiX0N8kkzoaoG7C4qIc=;
 b=jIWLO2J8CjouSWQGiAJGiuzFIE7pWRWPGmya5AmCjZ2XBhU+i3Tm7USye6YxxBIySTD1KEgZCBpqPajIGNjtDXTDRIE915FVIVrFlnvM0c53JlLRmFGn8yC4CLTdVHwEolgAtMDAfVoJnGD0SefMyiUBaid1mbV4uY1Z9QZ8fYg=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.22; Mon, 23 Nov 2020 13:30:51 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%7]) with mapi id 15.20.3589.030; Mon, 23 Nov 2020
 13:30:50 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, JingWen" <JingWen.Chen2@amd.com>
Subject: RE: [PATCH 1/1] drm/amdgpu: only skip smc sdma sos ta and asd fw in
 SRIOV for navi12
Thread-Topic: [PATCH 1/1] drm/amdgpu: only skip smc sdma sos ta and asd fw in
 SRIOV for navi12
Thread-Index: AQHWwZtMYMTmVeV4ikOAVxN9vIwXHKnVtSQw
Date: Mon, 23 Nov 2020 13:30:50 +0000
Message-ID: <DM6PR12MB4075813D74B9ED300249BDFDFCFC0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201123131929.21838-1-Stanley.Yang@amd.com>
In-Reply-To: <20201123131929.21838-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-23T13:30:47Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=0b565533-ce57-4b18-90ae-00003770b754;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-23T13:30:40Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 0e597ec8-2801-418c-b35f-0000e748347c
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-23T13:30:48Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 2bc6821c-dca7-47f8-86c3-000017297b7a
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b039ae40-06b2-48fb-b18a-08d88fb3fec8
x-ms-traffictypediagnostic: DM6PR12MB4043:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4043B93B8E289A5328F5CEA2FCFC0@DM6PR12MB4043.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gehvvAAiPfd1YIacNTLrQfyub+aSuxDUu1aBk5C2TDnqc40frzh9q6xpA+LNJzS4TXeZjf0LjeseXVDThQmQ6jOedMShE48t6PQRbIX/h+M18iOV3HdSGxdGtQJKuuaeMmboPATd7xTlq7tPyIpw+b68eLW5xSaoagTTEPbhoejY53zQgMOXj6RF34z+iA9RK9kaDNElAMfc1g3bW8AgT08WNmH77rskog8XU8w29mh3YJFe6zbgc87YF92c1FT7agm+sRHkOcbld4gwzz8y49o81kYpvKze8AMIUnMap3T62ICLyOtf5IMYzMQy8r6YnxBk8XjFoS8FLLIMHGBnWQwOyShYCJ4xBhAwBTJorHc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(33656002)(186003)(316002)(26005)(966005)(55016002)(9686003)(110136005)(4326008)(6636002)(478600001)(83380400001)(45080400002)(8676002)(53546011)(7696005)(8936002)(6506007)(2906002)(71200400001)(76116006)(66946007)(52536014)(66556008)(86362001)(5660300002)(66476007)(66446008)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: qlPYxdZCPWEn9hvXlGM9ngGTw448lSbgWhRlWVNVrAlfgA8jdq3UlMPYsETi2gjUTyU11h0jgcz1UvFJCeDV43akVb055YEpeUlUUJFQdHly4yzK83xNSTZhPKPLPDLnxs8U8hGthqEExJAqcI/RSKTuLmrKGarTuo3Fx9XpYQLAEHrJa8h41W9ZeTIVYuFxPZz8MOodHc5bnnHU2m79BN9Oo+lSylLh/ELVn/dmp13/dVsFAnkVw8nBkcKw+6vph0xHzZpTH/RJhiDPY98LCFW3YRVBqgs3CgfrVFRQ+vg4a/IhCRb3HDYnrB5t2Tv7+KCgJ+YUKdhQh56ol+6IrT4EvWQz/geTzFsgZx4RcOwVK/BuyZSbdV892ySI0biJJZlMYrYNH6sVuU5mvH7mli2oBQ1pdD+e2EZJW6rikWh5dfBwy+KFMeufnmUFZ0wggrboRRaYmxMhxPoWhn1U7XREqX4tTlm1HKTDacPcRFhSNUY1br5SSqBRgBawUdh6KzIjlBTvjymNtOTSBil6FWTsQq4TGalcxyShe6VZkQuJuAPXQA0z2dZOzPZtzZd7cFfSumFyg4DgjtJNjtiXi13wMUwBUAEOg9bgOltGSj6QpqSlMRlPyelI/BxtGu9AfG7LPR0NncUhL9NqAAk8Ku7OtBzzaMt+WS+QiaiwABHxKVWHWX8DNkASt5uXbbO1hPbb6kmYTKlrCaDxCazkrVNRt6XOM21nVrwszW6fZi5FOqXrisSuHMh/AcnozUH73A/q1B05KY9DCRjCEKtLtgeMsvjotlS0828OP3QUqelZmmOjRTOrN0jYOeX0KXDXleXZI+d5tScM3zxS9lTsAcyNs8o16IDhrGnZCzy92MZa4WigJCJdfRP8ECyNagIa6KFgzwbgnzTivfyr+1Cd9g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b039ae40-06b2-48fb-b18a-08d88fb3fec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 13:30:50.8562 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tld9DGbpIN7ufN3vZGCV6bOCFVlDnMMt8671UFLsuX2YFCQOzCLYYOLwwhllCQ8zHubM2lh0HYvHg+WJ7Jbo8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

@@ -593,7 +593,7 @@ static int sdma_v4_0_init_microcode(struct amdgpu_device *adev)
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_NAVI12))

Navi12 doesn't integrate sdma v4. Why we need to check Navi12 in sdma v4 function.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.Yang
Sent: Monday, November 23, 2020 21:19
To: amd-gfx@lists.freedesktop.org; Chen, JingWen <JingWen.Chen2@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: only skip smc sdma sos ta and asd fw in SRIOV for navi12

The KFDTopologyTest.BasicTest will failed if skip smc, sdma, sos, ta and asd fw in SRIOV for vega10, so adjust above fw and skip load them in SRIOV only for navi12.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Change-Id: Id354be93723d7b5d769d73dc67c596af300305af
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                  | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c                  | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c                  | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c               | 2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 16b551f330a4..7e2f063120d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -593,7 +593,7 @@ static int sdma_v4_0_init_microcode(struct amdgpu_device *adev)
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_NAVI12))
 		return 0;
 
 	DRM_DEBUG("\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 9c72b95b7463..fad1cc394219 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -203,7 +203,7 @@ static int sdma_v5_0_init_microcode(struct amdgpu_device *adev)
 	const struct common_firmware_header *header = NULL;
 	const struct sdma_firmware_header_v1_0 *hdr;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_NAVI12))
 		return 0;
 
 	DRM_DEBUG("\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index cb5a6f1437f8..674bc88c3ec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -153,7 +153,7 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_NAVI12))
 		return 0;
 
 	DRM_DEBUG("\n");
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
index daf122f24f23..192149e94f6c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
@@ -208,8 +208,9 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)
 	unsigned long tools_size;
 	int ret;
 	struct cgs_firmware_info info = {0};
+	struct amdgpu_device *adev = hwmgr->adev;
 
-	if (!amdgpu_sriov_vf((struct amdgpu_device *)hwmgr->adev)) {
+	if (!amdgpu_sriov_vf(adev) || (adev->asic_type != CHIP_NAVI12)) {
 		ret = cgs_get_firmware_info(hwmgr->device,
 						CGS_UCODE_ID_SMU,
 						&info);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1904df5a3e20..80c0bfaed097 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -847,7 +847,7 @@ static int smu_sw_init(void *handle)
 	smu->smu_dpm.dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
 	smu->smu_dpm.requested_dpm_level = AMD_DPM_FORCED_LEVEL_AUTO;
 
-	if (!amdgpu_sriov_vf(adev)) {
+	if (!amdgpu_sriov_vf(adev) || (adev->asic_type != CHIP_NAVI12)) {
 		ret = smu_init_microcode(smu);
 		if (ret) {
 			dev_err(adev->dev, "Failed to load smu firmware!\n");
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7C11dc63c434444a86675608d88fb26e4c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637417343805220247%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=SUkSApUQErJH80J5XELokS%2FuIDKMDsqwmBPVrfyvSOA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
