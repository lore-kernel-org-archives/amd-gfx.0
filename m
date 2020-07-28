Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D364C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 14:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5352206F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 14:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N7aJEFaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5352206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C5AE6E2DE;
	Tue, 28 Jul 2020 14:11:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72B9F6E2DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 14:11:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mG+p9jLfxlygIh9AGn9h2H8dLDZ/IbfV2Xz4+Q5Yq3TmhSh+g9kUpUeVHrHAeYp0doHK9rS5VY0RLsJlXuldKTI4UF3azuHMcDO2cltVGfatBVE5pG4uXXKKhU4yU/1a0PQEYXFArWIwgGzsGFZutAMoHTghaaGDRsFNat3BNlDvTKYzYEVJDMjHc4Yl2UDdwi1ytZqZpxz64RlNmAn/ryOABCJOZqk1kVGvMIteLckg9Tg5UyvC/n1LyJuHEwDx4egHcktNAfzrwXcELgrWf2tb0ISKwBelKRBf/9pdTnIp/d8oRub4vNdcCLb+GeYpwuaNk81nZbHRfVUHHQQTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2r2LPS9LEQ7X9rNuFTz0nY0PVxF4vjZ9qXnwaUU2dRI=;
 b=a6ng/tD3TJANSbrxk2h1gMC/cT9y79zV0s/1DNuA+eGk8Lg36RZdiKMri7K6hhPAjQLHILoYljqvAIBZqotRMiRgglHvpBQ2FlaITzutLtdTWtGyAHzKNo2TcL8kIfSe/WQ3r6Gwefm8SuX+8TeOdCvyE2q0PLCXlfwiwzKpj4AQFXuFgS2hBad0MAKpSvGTpkOHcgViJ9jNwOT77bajXb3GBqia/2VPoNEC5eCHbd95Po2CtiE6AHRj5Zwu7LcQaW9GycJmjInJSjlPZu2WL9p2S/0h04XaAUHFzCN/Xi1fIHLvKP7f/7wlvT0B+VV4FKUq2Jqwbu26xg8eQ+yynw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2r2LPS9LEQ7X9rNuFTz0nY0PVxF4vjZ9qXnwaUU2dRI=;
 b=N7aJEFaVQPKkFrfkZCiD6egrgpJcKnOFo/AYe5Y4ZkHljeDeZ/mMEdQWGLvioZoMDVK5uiI+B1u+EHS5DOP6zLKBqtrznCgPYGQkxBKVJsR9ht32P49IFtU6171MTY2Pxx/6piiVnrtIS/7Qe+i9lL+zX+eJST4LGdwYmyEnwW4=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1912.namprd12.prod.outlook.com (2603:10b6:903:11c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 14:11:39 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 14:11:39 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 04/12] drm/amdgpu: break driver init process when it's bad
 GPU
Thread-Topic: [PATCH 04/12] drm/amdgpu: break driver init process when it's
 bad GPU
Thread-Index: AQHWZLO2r3tok3eKI0WNFbfYLSLV6KkcvasAgABICEA=
Date: Tue, 28 Jul 2020 14:11:39 +0000
Message-ID: <CY4PR12MB128712A8799EAC4B9752E0D4F1730@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200728074934.12490-1-guchun.chen@amd.com>
 <20200728074934.12490-5-guchun.chen@amd.com>
 <DM5PR12MB2533F35E3050B8B3F2F665AEED730@DM5PR12MB2533.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2533F35E3050B8B3F2F665AEED730@DM5PR12MB2533.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-28T14:11:31Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=1a2767b3-bc94-4eca-a49a-0000c8000e5c;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-28T14:11:19Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: f356218c-412e-4199-91e8-000011959e5d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-28T14:11:36Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: b0c7f2f3-b65e-4d96-a0bf-00006d616653
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.35.34.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4fb2b3b7-8a47-4b21-91ae-08d833002585
x-ms-traffictypediagnostic: CY4PR12MB1912:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1912D4964E36FABCECED18C8F1730@CY4PR12MB1912.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EWLJKPp1i/T6fJQ3g31vCq9Lnl+8FluCPAkvLetzLTV4TQED5MdJhZ1i2XdvvaVBkJn7YCLWs5h6brVwYjlXimXLpwiMLzUKp1tvxHvpmgJiklkSIh4ldG4t0NyUD8ko4AyOC/fa7oNIiUzDv4ZGTlqZGmb75C5gm/9+ob6BKPWZInCUGXKUfa+VPE1UY5/Qt6DTTcglsx7nUOJ7Ng2EC1JHUtY3xfizNDMGZaw7jIfoFU4sNaF7v9qPFxMiVSk6OybRhI0IiiHKdvdZTm17Nnh/pNGD5/SxhfC2ExkwfayLMX27ENuZ29rZt0phdffRK/+NDF+AVr4WMwMvS//OIopuLNGuqc/x48egzXjmWneYL7OYnPFAL0x0JzU0AvG6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(2906002)(66476007)(71200400001)(66446008)(64756008)(66556008)(86362001)(66946007)(83380400001)(76116006)(55016002)(7696005)(110136005)(8936002)(53546011)(26005)(9686003)(52536014)(33656002)(8676002)(478600001)(186003)(6636002)(5660300002)(6506007)(316002)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: dheg+b+YcdsO/l0wiEdXs8uJIAj5fIEC/BoOmU24DLTWOsSqh331jxceoF+6nAw3FW3ed+66nlB14mxP45IZQeWxIML0MydE+4vwshWb9k0W6aNyjaiu61y+ZnMMnx4oe9iKWDJp8kCXnQ5mEVPBM0VAXKZWfy3/2vqPJVUH158MlqoY5JO5UxdeAyjWphyrLCHgoH1O19xHfmeKwTWde2UHKHPICwVtLCYV22am/0+8Li9wxtvoaq+yRkQxPbKp6Kk8GsxTo6cK5cHfImaHnl0CeJfGj8F7g67UjhcTT2kFtJhpn6QJWgPiwHA+CpvPlGNywYaOo/LivhLfiOtPQYLavW/KQp5PXq1LpR397fMtoXT2C2GInRX+xP+rZUAqOUsCZX5qw6Tf9siJCLtgdHL6OxI/ybnpzABhglbQP+lM6Sdve0NO8leO5pG1fZ7b5fEmW9i8LCg+WOLL5X1wZHR+p3Jqz6c3OVP6+mz3tYc=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb2b3b7-8a47-4b21-91ae-08d833002585
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 14:11:39.4032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9p27TfZbzy+QdMJc18bu2QgUVq2BZAXUzFNUk4OVkmGKdmdhOQvPWSAaPK58FuRR0EgaBUpPNhyrPDP3lXk6/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1912
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

[AMD Public Use]

Hi Dennis,

Please check my response after yours.

Regards,
Guchun

-----Original Message-----
From: Li, Dennis <Dennis.Li@amd.com> 
Sent: Tuesday, July 28, 2020 5:43 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH 04/12] drm/amdgpu: break driver init process when it's bad GPU

[AMD Official Use Only - Internal Distribution Only]

Hi, Guchun,
      Please see my below comments.

Best Regards
Dennis Li
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Tuesday, July 28, 2020 3:49 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH 04/12] drm/amdgpu: break driver init process when it's bad GPU

When retrieving bad gpu tag from eeprom, GPU init should fail as the GPU needs to be retired for further check.

v2: Fix spelling typo, correct the condition to detect
    bad gpu tag and refine error message.

v3: Refine function argument name.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        | 18 ++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 +++++++++-  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h |  3 ++-
 4 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2662cd7c8685..30af0dfee1a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2059,13 +2059,19 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	 * it should be called after amdgpu_device_ip_hw_init_phase2  since
 	 * for some ASICs the RAS EEPROM code relies on SMU fully functioning
 	 * for I2C communication which only true at this point.
-	 * recovery_init may fail, but it can free all resources allocated by
-	 * itself and its failure should not stop amdgpu init process.
+	 *
+	 * amdgpu_ras_recovery_init may fail, but the upper only cares the
+	 * failure from bad gpu situation and stop amdgpu init process
+	 * accordingly. For other failed cases, it will still release all
+	 * the resource and print error message, rather than returning one
+	 * negative value to upper level.
 	 *
 	 * Note: theoretically, this should be called before all vram allocations
 	 * to protect retired page from abusing
 	 */
-	amdgpu_ras_recovery_init(adev);
+	r = amdgpu_ras_recovery_init(adev);
+	if (r)
+		goto init_failed;
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1)
 		amdgpu_xgmi_add_device(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3c4c142e9d8a..56e1aeba2d64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1822,6 +1822,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data **data;
 	uint32_t max_eeprom_records_len = 0;
+	bool exc_err_limit = false;
 	int ret;
 
 	if (con)
@@ -1843,9 +1844,15 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	max_eeprom_records_len = amdgpu_ras_eeprom_get_record_max_length();
 	amdgpu_ras_validate_threshold(adev, max_eeprom_records_len);
 
-	ret = amdgpu_ras_eeprom_init(&con->eeprom_control);
-	if (ret)
+	ret = amdgpu_ras_eeprom_init(&con->eeprom_control, &exc_err_limit);
+	/*
+	 * We only fail this calling and halt booting up
+	 * when exc_err_limit is true.
+	 */
+	if (exc_err_limit) {
+		ret = -EINVAL;
 		goto free;
+	}

[Dennis Li] Compared with old codes,  new change miss checking ret.
[Guchun] Yeah, this hits me that another if condition is that ret should be checked as well when exc_err_limit is false,
that means there is some problem with eeprom i2c functionality.
It will be addressed in next patch set.
 
 	if (con->eeprom_control.num_recs) {
 		ret = amdgpu_ras_load_bad_pages(adev); @@ -1868,6 +1875,13 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 out:
 	dev_warn(adev->dev, "Failed to initialize ras recovery!\n");
 
+	/*
+	 * Except error threshold exceeding case, other failure cases in this
+	 * function would not fail amdgpu driver init.
+	 */
+	if (!exc_err_limit)
+		ret = 0;
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 35c0c849d49b..67995b66d7d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -241,7 +241,8 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control)
 
 }
 
-int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
+int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
+			bool *exceed_err_limit)

 {
 	int ret = 0;
 	struct amdgpu_device *adev = to_amdgpu_device(control); @@ -254,6 +255,8 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 			.buf	= buff,
 	};
 
+	*exceed_err_limit = false;
+
 	/* Verify i2c adapter is initialized */
 	if (!adev->pm.smu_i2c.algo)
 		return -ENOENT;
@@ -282,6 +285,11 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 		DRM_DEBUG_DRIVER("Found existing EEPROM table with %d records",
 				 control->num_recs);
 
+	} else if ((hdr->header == EEPROM_TABLE_HDR_BAD) &&
+			(amdgpu_bad_page_threshold != 0)) {
+		*exceed_err_limit = true;
+		DRM_ERROR("Exceeding the bad_page_threshold parameter, "
+				"disabling the GPU.\n");

[Dennis Li] Why must introduce a new parameter exceed_err_limit?  I think it can return -EINVAL directly here.
[Guchun]We need to definitely know what's the error case and decide next step concisely. When this variable exceed_err_limit is true, that means
GPU bad tag is detected, and consequently, this scenario will be returned to upper layer to halt driver's boot up. For other errors returned by this
function, they may be caused by eeprom i2c functionality, in such case, amdgpu driver's probe will not be impacted, as generally, eeprom is
one external device only.

 	} else {
 		DRM_INFO("Creating new EEPROM table");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index b272840cb069..f245b96d9599 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -77,7 +77,8 @@ struct eeprom_table_record {
 	unsigned char mcumc_id;
 }__attribute__((__packed__));
 
-int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control);
+int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
+			bool *exceed_err_limit);
 int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control);
 
 int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
