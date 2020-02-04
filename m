Return-Path: <SRS0=NM/7=3Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EC3C35247
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2020 02:02:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DA9620732
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2020 02:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ife+zQvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA9620732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA2216E51B;
	Tue,  4 Feb 2020 02:02:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 483116E51B
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2020 02:02:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cL4gwQRDjqh2fWrH0vc+R3qJCUQwXZr+xdm+ws3G3/IUMEQ8vyBiBj88i9+BePOv9cj4ztS9k9tBxKNm2Df+SnADvaxLBN2LSBSw3ca6YujCDq+mppoJu0m/J1qQN+Z9NwI0PdzMuy29cBZsFHm752bircd4CX/htDYtHp69bqxoH/iKlwWkkFr7gmYEyVIBEAVblpFEGRRMuCfV0qUtAgbfDkZ3BobIGijJk93mzMOYyT5rXYlBBq8bhASUkv+07IfdaOgnoJc2OLi84YbqjJQKrU1tUq3ABEWbkvO8d1B3Jhvn+rg9++Nr5phUy0R3BR4X4blul7BXLyJs1RevFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2FiOlqO3ViAaWZ3BS/8tdH2jeB9BvQn0r6ftYejoAA=;
 b=BhPF7tqp3j1yzyAl/BntHhy/oyWJHP+Pu/QOp6Rv9mz85aNWYo91ym4xTVIySgzd0kzazSnxU+iMGZZQiyYWSdIslH9UOSxh97w+o+ySytKS/95G2LE296uyP/qr1jxE1v1jAXGzCPFeN33Gzx7RKOtDfZ7W583fmicA1qXZ0A6gZ+FlykYJXzL/Jd/k4JeqQMR4NE0iHoJ6uE51ayef/hIchh83JZrD/gll8UUuyUpeIkAWIwm1bGxQuIf78I/aCApDiQIs77YPntbM7u1F7K/jbyHo8Kblg9TL1RyW5VBfBxXBBxfnzyadmapS9/byfCJdKb8ybBmGL9od2G4I6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2FiOlqO3ViAaWZ3BS/8tdH2jeB9BvQn0r6ftYejoAA=;
 b=ife+zQvDiZJLBtlzM1G3KpZXWk1Pt+IEhI06hWzfIefFQalDIFcXM+Srm2VAstXXg0kkTREIY189LF8QdCxHRmeQxvSaQtwB1aWGEfAj5MMkufT2KK0YscR/lM1YV9Ih8VtuJxjVi3VunJXPyit9adOXhfTQWPjSzVR62/WDChQ=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3423.namprd12.prod.outlook.com (20.178.242.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.28; Tue, 4 Feb 2020 02:02:33 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 02:02:33 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fetch default VDDC curve voltages (v2)
Thread-Topic: [PATCH] drm/amdgpu: fetch default VDDC curve voltages (v2)
Thread-Index: AQHV2tGhdQ1QQGAsCE24PgAksdkuQagKSKAQ
Date: Tue, 4 Feb 2020 02:02:33 +0000
Message-ID: <MN2PR12MB334409D39B27C8E7848447DDE4030@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200203203617.23887-1-alexander.deucher@amd.com>
In-Reply-To: <20200203203617.23887-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [123.127.234.234]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f7c620b-d9f9-4af1-bee1-08d7a9164c5e
x-ms-traffictypediagnostic: MN2PR12MB3423:|MN2PR12MB3423:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3423B853CFE93FFBE155F499E4030@MN2PR12MB3423.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(199004)(189003)(186003)(966005)(8676002)(33656002)(55016002)(81156014)(26005)(8936002)(9686003)(81166006)(5660300002)(478600001)(53546011)(6506007)(2906002)(4326008)(86362001)(71200400001)(7696005)(110136005)(316002)(45080400002)(66556008)(66446008)(66946007)(64756008)(66476007)(52536014)(76116006)(9126004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3423;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8AyEODb3Wt9lQaNwfhRPjzzi+xqbx764oWja8sXdZ+unXUuW458GIAcyfQVXQyOWTS0R3/ll4RcgJP334glELRXiUMXHRL14EBzNO+Lig+aJDizWJJDuxReH+fhe8KEj7ApRe9vQKrxfDQa4fGr+mzj7wFvtfP6eghg0bfnevSstNC7+9LsC9UJdwTPQfXTdiV6gjmR9MP45WcTxp8EAb2CkrHlzRcRvANoGkflbaHdU0h3nV5vFpQWQXjRhkv6cg3CJMpdYdnBApTqD2tcYGLoTxkyPw1eomS108rbIz6Xex+EG8QQkvltiMrL/fy4nsa09jMN4f76Q0+y7RX3UDBDTr81o3pAgT5oIQEuc0kZop769dUm+IZtgIw0/5wbjpiOKo/EGNoEh7S7Rh+otXd8DIX4cYct2LMD5Huh35JH/6r1VFA1hU/wFSJ5Co1R5XeQMuh/j5/uvyptarVI6d/WLg7F2RkMxVeguKfWogsV9oB+6m6colV+hnKg4gippqFmTIrDkjT+YgvF2QNYS0tmMGH/BOdLR+BF5Je1fzzAsVPdLPzFZ65G8Vee02nKo
x-ms-exchange-antispam-messagedata: s9XKw0/tM2Auaf4lhtleIwltUEQUxkRY/F+URte3IzkKPkakuWet8XfsayU49MODelPjlHp6LuO1tnWkV3HDBhtOWkzjon6t0DnyAJynNFKG7kP+OR1jlVTiL5wdF+VswqgVj/zXtwBcWHzZ4evxdw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7c620b-d9f9-4af1-bee1-08d7a9164c5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 02:02:33.0457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: whoIVAVRbUftirbyRRnkMR6ZxNElAS0O5VAhm1Q51aBkeQ+/uFwRuuNP4F++fJJU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3423
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, February 4, 2020 4:36 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fetch default VDDC curve voltages (v2)

Ask the SMU for the default VDDC curve voltage values.  This properly reports the VDDC values in the OD interface.

v2: only update if the original values are 0

Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2Fissues%2F1020&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cdd73683ddcd645aac3dd08d7a8e8bf0b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637163589962864398&amp;sdata=dvhhU0TYEqBoVQc0ZPBkxZT%2FsWzNkggXSETsc9wj190%3D&amp;reserved=0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 50 +++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 26cfccc57331..a1c1257cf2cb 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -119,6 +119,8 @@ static struct smu_11_0_cmn2aisc_mapping navi10_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(PowerDownJpeg,		PPSMC_MSG_PowerDownJpeg),
 	MSG_MAP(BacoAudioD3PME,		PPSMC_MSG_BacoAudioD3PME),
 	MSG_MAP(ArmD3,			PPSMC_MSG_ArmD3),
+	MSG_MAP(GetVoltageByDpm,		     PPSMC_MSG_GetVoltageByDpm),
+	MSG_MAP(GetVoltageByDpmOverdrive,	     PPSMC_MSG_GetVoltageByDpmOverdrive),
 };
 
 static struct smu_11_0_cmn2aisc_mapping navi10_clk_map[SMU_CLK_COUNT] = { @@ -1932,6 +1934,28 @@ static int navi10_od_setting_check_range(struct smu_11_0_overdrive_table *od_tab
 	return 0;
 }
 
+static int navi10_overdrive_get_gfx_clk_base_voltage(struct smu_context *smu,
+						     uint16_t *voltage,
+						     uint32_t freq)
+{
+	uint32_t param = (freq & 0xFFFF) | (PPCLK_GFXCLK << 16);
+	uint32_t value = 0;
+	int ret;
+
+	ret = smu_send_smc_msg_with_param(smu,
+					  SMU_MSG_GetVoltageByDpm,
+					  param);
+	if (ret) {
+		pr_err("[GetBaseVoltage] failed to get GFXCLK AVFS voltage from SMU!");
+		return ret;
+	}
+
+	smu_read_smc_arg(smu, &value);
+	*voltage = (uint16_t)value;
+
+	return 0;
+}
+
 static int navi10_setup_od_limits(struct smu_context *smu) {
 	struct smu_11_0_overdrive_table *overdrive_table = NULL;
 	struct smu_11_0_powerplay_table *powerplay_table = NULL; @@ -1958,16 +1982,40 @@ static int navi10_set_default_od_settings(struct smu_context *smu, bool initiali
 	if (ret)
 		return ret;
 
+	od_table = (OverDriveTable_t *)smu->smu_table.overdrive_table;
 	if (initialize) {
 		ret = navi10_setup_od_limits(smu);
 		if (ret) {
 			pr_err("Failed to retrieve board OD limits\n");
 			return ret;
 		}
+		if (od_table) {
+			if (!od_table->GfxclkVolt1) {
+				ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
+										&od_table->GfxclkVolt1,
+										od_table->GfxclkFreq1);
+				if (ret)
+					od_table->GfxclkVolt1 = 0;
+			}
+
+			if (!od_table->GfxclkVolt2) {
+				ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
+										&od_table->GfxclkVolt2,
+										od_table->GfxclkFreq2);
+				if (ret)
+					od_table->GfxclkVolt2 = 0;
+			}
 
+			if (!od_table->GfxclkVolt3) {
+				ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
+										&od_table->GfxclkVolt3,
+										od_table->GfxclkFreq3);
+				if (ret)
+					od_table->GfxclkVolt3 = 0;
+			}
+		}
 	}
 
-	od_table = (OverDriveTable_t *)smu->smu_table.overdrive_table;
 	if (od_table) {
 		navi10_dump_od_table(od_table);
 	}
--
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Cdd73683ddcd645aac3dd08d7a8e8bf0b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637163589962864398&amp;sdata=V9lHATYE7yq8Ht4yZZBGWIGxSYc6mV%2BS8syNmcJKSvQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
