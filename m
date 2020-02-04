Return-Path: <SRS0=NM/7=3Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5C5C3524A
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2020 03:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 968EA2084E
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2020 03:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YTxIIb59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968EA2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 447D26ED8F;
	Tue,  4 Feb 2020 03:35:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BD2F6ED8F
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2020 03:35:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCKc+PVsGyQ/4vxoNVbVUPE2kaL6OOFHjkPJAvLfklMhkDCyVX+eCqOI6280TnEUMCzcNgabXT1+RerhVjz1Ynfl41KZCzBflfw5gFA3qXPvtL5hldhM52FJf7bxQUA9PgHDvius4wKb6aQBCzZmX0q2OXAFvHHzxItHXi0s+GOP1AVyeheQjUDR2YkHcw/RFt+W1MaFi4D5HZI9bNjIx2CkuBp3HBTs5aPpbZ6yWvK7EA6pN36mroQpO31eHDLYoQBYosZS+dqFGRGGuVlrajQ5qQLl2LkWrCy+9QMNfNaVW65VxRkkAv549URWkoVvYHHWRioaUP3RJxakcjg1DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7zRbdOwMoNlncM2hLMwvr5zFR0NIpFn+gkI7AkYzPU=;
 b=OBANuu7D6mzqwqsWazDupOXSL7eeTDD31+iGqEVDmSRWDmBMA+8tWloL3o+e63oRmSHWv7m3z11MmDMgs0dB8JjKLsGUOcweHiD28LD6+IATqqMilpkUqmqrkCRi36f/tRGvSnC3pzlsC9uOuiej1xPpwI23sN380FG2bT4HwQqEvCnprVc1wlZl3kQgLH0AcHTSoneDedi7isVRO2fCMFGgtauJrUCKmp1kH17f+siWZjxkZpV+9cKGSJpfXpfH9Kem8vjCydyVI3t9yeaEFLilsY2KaMu4zi507QVIZgok2Gn1FPxP/FKsCjkh32Ffodszrrp0OErooiI9c2afEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7zRbdOwMoNlncM2hLMwvr5zFR0NIpFn+gkI7AkYzPU=;
 b=YTxIIb59UzXXhmDadEhu+iZKioUzRUkGMKpyz7JjNm8gyuFmLVar9Ypt02zzap/6V5F2Ofi3hZpdXExMrvLm9VWZJjVmkVZ5Cf+6sV6pMkKaGqwBnzA2Yf1YMoMPhsErvhML8I+eN4ZUCT6CNAjYZaRcIKSr9F4t94Xo8QLhQVY=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3054.namprd12.prod.outlook.com (20.178.244.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Tue, 4 Feb 2020 03:35:02 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 03:35:02 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fetch default VDDC curve voltages (v2)
Thread-Topic: [PATCH] drm/amdgpu: fetch default VDDC curve voltages (v2)
Thread-Index: AQHV2tGhdQ1QQGAsCE24PgAksdkuQagKSKAQgAAZS+A=
Date: Tue, 4 Feb 2020 03:35:01 +0000
Message-ID: <MN2PR12MB3344370E987FCC5913AE49E7E4030@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200203203617.23887-1-alexander.deucher@amd.com>
 <MN2PR12MB334409D39B27C8E7848447DDE4030@MN2PR12MB3344.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB334409D39B27C8E7848447DDE4030@MN2PR12MB3344.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [123.127.234.234]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5cf724e6-f4c7-4f7e-0182-08d7a92337c1
x-ms-traffictypediagnostic: MN2PR12MB3054:|MN2PR12MB3054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB305467A79BA119E4D6747DA8E4030@MN2PR12MB3054.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-forefront-prvs: 03030B9493
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(199004)(189003)(52536014)(186003)(2906002)(71200400001)(4326008)(2940100002)(64756008)(66556008)(66946007)(66476007)(66446008)(81156014)(76116006)(81166006)(316002)(8936002)(110136005)(45080400002)(966005)(9686003)(53546011)(6506007)(33656002)(7696005)(86362001)(26005)(55016002)(478600001)(5660300002)(8676002)(9126004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3054;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ZGQtYXj0rklpfn8kXG2LesUo0EMPc2Ql2wVI8LSZGk9Eth7jHkEbFkqygd48EcV+8tJ1qmxRCozTr+He5BWIj0uF5Yf6y/0tdj/T05s/32UDSK1Umrg1jJoA6NTN77hJrQJe01OWsVwDGXQZfhqu5qcNRr9qN3kEP3fVhQfXjh7g2r8ODZAtq/4k+iZNqpcznfVJ+TExk84ikDGBfYr2/uvFWI5USvgsps83PqRhSXm0dH6aTom3t1U7orWrQsquCLqP58YKnZjUaCx0JV1L1FQXyWPnElQcHaveGhoVcTWMOCbMDgSN9IuZFGD7zyelQeF2qNadN7tqenvq/WXSxsQsXBihS1szyKFuCxMps/nMFhmD9eEGHGtQVe1f/P2AI9xzFYDKzwzGzMU6Zm4iLeZ55/hcZjc+yHEWytT4Vj8mI05EtyxB3muaaOb1e0L4dWaWZRhNX0/BBxZHleGUjRhRMd6y7oxdkNy6Cytkff9sqTRPL79AS++Mg8IbX9746QW0wzuiEKIex/Y3umYLPryiT5Dp8YrPH1Dc39nmf3D2sDeadayYLCxFzKGAnjw
x-ms-exchange-antispam-messagedata: 59e1kiIWEYv7J2c6XAwIoCgY67mzz/W4i9KDkYnESRVDzWDxBYjd4ayZVAThGXFprGzhi4J9vHyj5Aotiu2j1oiRVn9dCzPeCTsZ7GQPI1vvXlmQGcl/9vbSdnu3PiaPeyh18cMsZlqjfIiyXQstxA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf724e6-f4c7-4f7e-0182-08d7a92337c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2020 03:35:01.9190 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8M4y5FrFbdyzhnVZrEVfiVZW8674UlZH4WQyqsUzLxrKKczLz1hUgi4wSqXvie1v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3054
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

Just found the boot_overdrive_table curve voltags need also be updated.
Could you help to update them also?
I think the code pieces like below should work.

static int navi10_set_default_od_settings(struct smu_context *smu, bool initialize) {
-       OverDriveTable_t *od_table;
+       OverDriveTable_t *od_table, *boot_od_table;
        int ret = 0;

        ret = smu_v11_0_set_default_od_settings(smu, initialize, sizeof(OverDriveTable_t));
@@ -1985,6 +1985,7 @@ static int navi10_set_default_od_settings(struct smu_context *smu, bool initiali
                return ret;

        od_table = (OverDriveTable_t *)smu->smu_table.overdrive_table;
+       boot_od_table = (OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
        if (initialize) {
                ret = navi10_setup_od_limits(smu);
                if (ret) {
@@ -1998,6 +1999,7 @@ static int navi10_set_default_od_settings(struct smu_context *smu, bool initiali
                                                                                od_table->GfxclkFreq1);
                                if (ret)
                                        od_table->GfxclkVolt1 = 0;
+                               boot_od_table->GfxclkVolt1 = od_table->GfxclkVolt1;
                        }

                        if (!od_table->GfxclkVolt2) {
@@ -2006,6 +2008,7 @@ static int navi10_set_default_od_settings(struct smu_context *smu, bool initiali
                                                                                od_table->GfxclkFreq2);
                                if (ret)
                                        od_table->GfxclkVolt2 = 0;
+                               boot_od_table->GfxclkVolt2 = od_table->GfxclkVolt2;
                        }

                        if (!od_table->GfxclkVolt3) {
@@ -2014,6 +2017,7 @@ static int navi10_set_default_od_settings(struct smu_context *smu, bool initiali
                                                                                od_table->GfxclkFreq3);
                                if (ret)
                                        od_table->GfxclkVolt3 = 0;
+                               boot_od_table->GfxclkVolt3 = od_table->GfxclkVolt3;
                        }
                }
        }

-----Original Message-----
From: Quan, Evan 
Sent: Tuesday, February 4, 2020 10:03 AM
To: Alex Deucher <alexdeucher@gmail.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fetch default VDDC curve voltages (v2)

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
