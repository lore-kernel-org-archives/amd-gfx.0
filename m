Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA534C6FA8B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Sep 2022 02:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DC1510E23A;
	Tue, 20 Sep 2022 02:29:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4B3A10E23A
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 02:29:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdR6KbHB2JBRqM/eQuNlSbZLYHQy1+f0JLcnUTSV19rnUL+2CABdX+dOa0EAjsA1/tbW3WUInW/euFTGxHA54j4TzN6h/x4JnhtuUJqaV95Z+7uAT7mr1SUj02URy9Qkc2gxbxiNrJigYWy5PXhPBrBkJtHlQixTMcmYlLEISc7NM5D0Cm2Scu1c4MtTdtzC3GYy7T70mJg61Iw/weRmRdyUlHAbcmotl5pJ6X76ah4YcBNf9fjSSxrdMLZphASAeBENUFmOYueoHhVJ0w8ahVwS6wP2hozrJiyU6uCWyaRnygREW5LyeaJ5agKn4s+cDRtBTQT5bCH64xLt7BdOOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYWSe6wJbsyyO6tZYAl5zWIIFlRCuC++NjVXivLUB+0=;
 b=eKV35tZmdujiPq0+RkRygYOrwwLClkAF/XP3UveXg0Vinwh2Hbq1l4O3oJ9w9JAxEG4bXxxTscJDcoKomGkUpfaAmiVvqV+rUvmEYzNWzAmf+N9GdZyqzMVZKQpupCC+t4vEks+jIZ3u8Uf+4B+ObLH+DTsfBoP8nQNybaqLDFFs2RgLwB1gX2r5WFX8+fxROJKvCn7SO3DCTlVAcJUJJ29AUhpvWno1TdCSAH7qDjmESmqr8yos02Xicqefw7WoK0Kg5dXAevUEe//5QVoHgpq6tKc8/Ux4rbaq+/o8SCuwVMc5lXNhMyUQD28hcCBGUXulLXclrZFoaIYbTnd4Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYWSe6wJbsyyO6tZYAl5zWIIFlRCuC++NjVXivLUB+0=;
 b=ldDb6KU5MFwslo8eAJfGQDNv7p0rIKk0fS883D7wxo/svcZ0e7g9sI/M0M6iHGQkxMNv9C4R/32rvFEKJ3ADw0Mr+PhXtkALa/MI+xI8NWJ6vY1SI8xF4KnIWrqJgIOLFVEa/a61EVH0mKEZJsLCY8lE4QcaxgV0Y3nfqk0cMRQ=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Tue, 20 Sep
 2022 02:29:06 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::d52d:ff82:1ee:eebd]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::d52d:ff82:1ee:eebd%4]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 02:29:06 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Francis, David" <David.Francis@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [v2] drm/amd: Add IMU fw version to fw version queries
Thread-Topic: [v2] drm/amd: Add IMU fw version to fw version queries
Thread-Index: AQHYzC2eGjzvF3Db60S9eLOXHano0a3nmRAA
Date: Tue, 20 Sep 2022 02:29:06 +0000
Message-ID: <DM4PR12MB51815232CF8014EBCF70B1C1EF4C9@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20220919134152.332411-1-David.Francis@amd.com>
In-Reply-To: <20220919134152.332411-1-David.Francis@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-20T02:29:04Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8886691a-d0f2-4f70-8369-96968ee648e7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-20T02:29:04Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 1bd1fda4-6af6-45e4-a389-8b6093543b3f
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|SN7PR12MB7347:EE_
x-ms-office365-filtering-correlation-id: b257bf94-0d94-41a0-46b9-08da9aafe43e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x63zNbACZe+PAMxdBbCruSwmV4aKmYdYvLqqXifTWbGnlW94qksJPgdneh7fwGVCZQdHu28yHr2cwxE5sBoF5lBdGt8PvQdi+14uZs2CKGIS6u5EyUotZ/hSFk4OEDKl/7+9+OH1G3ZneQeFoVg1xkLCU9U23048QpZ82sgmEUBYzGd8fC/SWFRNpfrGqjrV1wLloBGkXdkYXlMuxPZtOdEjpVWabkDHZ6shsQk8Ilg14PH/RlVnaR7mVRQpPTB7fFXB+pOl0iD1h9YlKtJvaFRTxeB5+7t057gWsxtK9jQF/7IoSDau624pIYDxirzQuBEXiflZKUhKy8kQlfyZlvkppzB6ci9xGKKU9f7YvrjBCTrA9cRu3RI+mc1s03+BlRVUhmKfJSOwfrc+ZIrYEUkaWPXbCZa/R72AOjGQZ1c50XGBQglhVxomEW6JuKCH1Gt2axnqGXCDtrm8r5fjBymhmgnmJBWEJ9VMpkV0ZENoRAnvH7Co2xTXBntzLZEk0/gSY9hZ/y2uOX6vQhJYHHEfkJMcezhoG7awTnFyHjveb1XMYACEuYBu/pf3akB0xrk22rMDW6h8q588GuxIugK73/Aw0+Us5nCCJ/YuVGaFhTl/xP6qxXPumggWElCxAF4ZrZDdUkzrf8fHaqtq5TJOVqlHt408EHRHYwOPCyWUoHpE/n69zOMkQD4sSXzm9rKLQs2gTqb14GXUaGm/6mENgd3eXH0RpbOn3g/qo9+Az8cIWL12MIIdVXRi+NrEr3k6Zj+0xephYFyRNPGpog==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199015)(83380400001)(9686003)(186003)(26005)(41300700001)(7696005)(66446008)(6506007)(53546011)(71200400001)(38100700002)(110136005)(52536014)(33656002)(478600001)(122000001)(5660300002)(38070700005)(8676002)(8936002)(316002)(64756008)(2906002)(66556008)(76116006)(86362001)(55016003)(66476007)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h0zb/fdqEBo+C7Ew1XK0Np4rubDGjNML7ZN+haNK7XdrjLaAbZKRIoD3RGLG?=
 =?us-ascii?Q?LOGYCoUQErjo4P8/TFMxXOl7RQIjWFDRHtMr+h13NGp4PDi40Ab4+TpjIyBF?=
 =?us-ascii?Q?lL9rTAf1wjrWGCkkPwlGzdWOoZodFxXUOZoRJCG1O0AJpoatd/HYiveqYF5J?=
 =?us-ascii?Q?tnQnKR4CrLXwXAMfedgBCrWxfQp38CHbLmSTV5zdUS34uGldBlYmeEgF9TPF?=
 =?us-ascii?Q?zDI/lpHVbK5NriFFcafGfAGSfjAhjwK/LHmHdowBXucQvRpLVo7uEueoAnhr?=
 =?us-ascii?Q?a3ULXOHuPLMN7zRiKAQH041ea4oU0rY09gHvZDU6pEshJl8tqfLoD2lr6zwx?=
 =?us-ascii?Q?d45eZtarQBiKhF7ONPfxODNlJdxdC/L79XMBLjTwQGS10PtC0A5oG6u0hW1h?=
 =?us-ascii?Q?oaBwKXQNzNOSyqnqd0ivvTm6VsWgT2sT5CrqkcRT0Ke7PUGd/CNpgptolAlN?=
 =?us-ascii?Q?VqQWaPNhhFxRzHFlIT+Tu4MJkEptyaZg+jKgO6wHLrTzwiP9TaoC1Y7fvHtq?=
 =?us-ascii?Q?HTWCHPD2GYOAHHFd2XexWiNKprlyPiswEJ6b3nB+Ph1ARMuruHMk+Xl/jGA6?=
 =?us-ascii?Q?5hhLJl0mPqhDhEK3JraL/Al+DaE7DBxJbPrQjIu5qBteNZtOE2taOJAnmOmz?=
 =?us-ascii?Q?14Ziu1Xbp9W+Og/nNe5OLV9WpiMoIo2Kr64CCyH8hFXAh+Ji8zwambPokM3r?=
 =?us-ascii?Q?50lN8cx7THJWXJhZtpsE1B2rrAcE5neXnHCWGuhDFNl9eLiju2SGgQjcCt6L?=
 =?us-ascii?Q?KtLxWcqY1dY6Ry6kSA911sHKP6D7tCNdwrX96TEETCSUyjPpevVFak3Vbqbv?=
 =?us-ascii?Q?6B2iu1+Cl3QS4Paqsv/BYHmUU+yayjT+lbyjt21RqVXyvLdnHn7NWIulnuIu?=
 =?us-ascii?Q?iQ89bMuqYfQmBV+bjjGcQfbP2ua4wszbHlj1Ws9XbiODH1S0VZmyFkttLlpI?=
 =?us-ascii?Q?gG3lL49qnuqR7+A9cmP7jW3N+5Vj/buDyi0zAcCubmVt7SEduMm3Nuxkg7nX?=
 =?us-ascii?Q?FxUMnqxzcfX8o67urdVci4qiU8giJy530jad+cE2lJkq5Vm5xm+e2UwaLxPl?=
 =?us-ascii?Q?sRAl3ZLamMUfXwC8tQqb7EIvlGhW1MvnwXLy//JS85rBgTPZFsgZMS9E4aMR?=
 =?us-ascii?Q?zMsIjFfoau+v8cAPubu9HGmIVTmHqw9gBrBUqB86UFvAz7CQXcFsWXEBCGAx?=
 =?us-ascii?Q?1Vw203EnRAqt6g7VzCZLKnGIgOmOMuX79gxVgxD/uM9q9x7gPANUDZ7bKfOm?=
 =?us-ascii?Q?wJGGfQaxEMN88sMHA9AINWTUt9NQDCWQWbYL0Co8VO2BcLyP0bS1b9K0R4K0?=
 =?us-ascii?Q?pruxXFakO6quBNxtz6/xkUFnwUl/+TPvLlBlVuqFMUbwE4miarNsfzSsyAAb?=
 =?us-ascii?Q?BIzrM1MlBY+sYm58AnVIIwexzEwH2r69R9LqjExnEYgc9gjXSc808Vp+RdTF?=
 =?us-ascii?Q?dEK4xvyAb06inaz6QmOXvnDyN0ZxNDvUB11RHhaWL5owXNKfJhM77w/G7oyX?=
 =?us-ascii?Q?H2rPpsYA3Y2L8Ujv/66mhUX6jERwqj3MRS8g89hacT0dQ2VY8ZHQzeaYG6Qn?=
 =?us-ascii?Q?8X+VwE3/h0cpE27qK5Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b257bf94-0d94-41a0-46b9-08da9aafe43e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 02:29:06.5119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +FDnqVL/EKlmSxMohpOCPw4JS30Voqvo900cEviJoT/z4N8V9ysMZxn/95VuRHpC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347
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

[AMD Official Use Only - General]

Reviewed-by: Likun Gao <Likun.Gao@amd.com>.

Regards,
Likun

-----Original Message-----
From: Francis, David <David.Francis@amd.com>=20
Sent: Monday, September 19, 2022 9:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Francis, David <David.Francis@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [v2] drm/amd: Add IMU fw version to fw version queries

IMU is a new firmware for GFX11.

There are four means by which firmware version can be queried from the driv=
er: device attributes, vf2pf, debugfs, and the AMDGPU_INFO_FW_VERSION optio=
n in the amdgpu info ioctl.

Add IMU as an option for those four methods.

V2: Added debugfs

CC: Likun Gao <Likun.Gao@amd.com>

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c   |  4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  1 +
 include/uapi/drm/amdgpu_drm.h               |  2 ++
 5 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index 1369c25448dc..56753c3574b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -328,6 +328,10 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info=
_firmware *fw_info,
 		fw_info->ver =3D adev->psp.cap_fw_version;
 		fw_info->feature =3D adev->psp.cap_feature_version;
 		break;
+	case AMDGPU_INFO_FW_IMU:
+		fw_info->ver =3D adev->gfx.imu_fw_version;
+		fw_info->feature =3D 0;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1488,6 +1492,15 @@ static int amdgpu_debugfs_firmware_info_show(struct =
seq_file *m, void *unused)
 			   fw_info.feature, fw_info.ver);
 	}
=20
+	/* IMU */
+	query_fw.fw_type =3D AMDGPU_INFO_FW_IMU;
+	query_fw.index =3D 0;
+	ret =3D amdgpu_firmware_info(&fw_info, &query_fw, adev);
+	if (ret)
+		return ret;
+	seq_printf(m, "IMU feature version: %u, firmware version: 0x%08x\n",
+		   fw_info.feature, fw_info.ver);
+
 	/* PSP SOS */
 	query_fw.fw_type =3D AMDGPU_INFO_FW_SOS;
 	ret =3D amdgpu_firmware_info(&fw_info, &query_fw, adev); diff --git a/dri=
vers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_=
ucode.c
index 939c8614f0e3..a576a50fad25 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -630,6 +630,7 @@ FW_VERSION_ATTR(rlc_srlg_fw_version, 0444, gfx.rlc_srlg=
_fw_version);  FW_VERSION_ATTR(rlc_srls_fw_version, 0444, gfx.rlc_srls_fw_v=
ersion);  FW_VERSION_ATTR(mec_fw_version, 0444, gfx.mec_fw_version);  FW_VE=
RSION_ATTR(mec2_fw_version, 0444, gfx.mec2_fw_version);
+FW_VERSION_ATTR(imu_fw_version, 0444, gfx.imu_fw_version);
 FW_VERSION_ATTR(sos_fw_version, 0444, psp.sos.fw_version);  FW_VERSION_ATT=
R(asd_fw_version, 0444, psp.asd_context.bin_desc.fw_version);
 FW_VERSION_ATTR(ta_ras_fw_version, 0444, psp.ras_context.context.bin_desc.=
fw_version);
@@ -651,7 +652,8 @@ static struct attribute *fw_attrs[] =3D {
 	&dev_attr_ta_ras_fw_version.attr, &dev_attr_ta_xgmi_fw_version.attr,
 	&dev_attr_smc_fw_version.attr, &dev_attr_sdma_fw_version.attr,
 	&dev_attr_sdma2_fw_version.attr, &dev_attr_vcn_fw_version.attr,
-	&dev_attr_dmcu_fw_version.attr, NULL
+	&dev_attr_dmcu_fw_version.attr, &dev_attr_imu_fw_version.attr,
+	NULL
 };
=20
 static const struct attribute_group fw_attr_group =3D { diff --git a/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vir=
t.c
index e4af40b9a8aa..38c46f09d784 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -547,6 +547,7 @@ static void amdgpu_virt_populate_vf2pf_ucode_info(struc=
t amdgpu_device *adev)
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_RLC_SRLS, adev->gfx.rl=
c_srls_fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC,      adev->gfx.me=
c_fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC2,     adev->gfx.me=
c2_fw_version);
+	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_IMU,      adev->gfx.im=
u_fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SOS,      adev->psp.so=
s.fw_version);
 	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_ASD,
 			    adev->psp.asd_context.bin_desc.fw_version);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/=
amd/amdgpu/amdgv_sriovmsg.h
index e78e4c27b62a..6c97148ca0ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -70,6 +70,7 @@ enum amd_sriov_ucode_engine_id {
 	AMD_SRIOV_UCODE_ID_RLC_SRLS,
 	AMD_SRIOV_UCODE_ID_MEC,
 	AMD_SRIOV_UCODE_ID_MEC2,
+	AMD_SRIOV_UCODE_ID_IMU,
 	AMD_SRIOV_UCODE_ID_SOS,
 	AMD_SRIOV_UCODE_ID_ASD,
 	AMD_SRIOV_UCODE_ID_TA_RAS,
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h =
index c2c9c674a223..3e00cec47f52 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -755,6 +755,8 @@ struct drm_amdgpu_cs_chunk_data {
 	#define AMDGPU_INFO_FW_TOC		0x15
 	/* Subquery id: Query CAP firmware version */
 	#define AMDGPU_INFO_FW_CAP		0x16
+	/* Subquery id: Query IMU firmware version */
+	#define AMDGPU_INFO_FW_IMU		0x17
=20
 /* number of bytes moved for TTM migration */
 #define AMDGPU_INFO_NUM_BYTES_MOVED		0x0f
--
2.25.1
