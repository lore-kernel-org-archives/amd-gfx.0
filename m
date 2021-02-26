Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E17C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 07:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D1AB64ED3
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 07:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1AB64ED3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE4286ED7D;
	Fri, 26 Feb 2021 07:24:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D9156ED7D
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 07:24:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZJ0HQDaT2gPJmlqPbJliGflzqy7FlnZiQ8fJ2dgVZlApCq/J69tNYJL3uuci34CVj+UPGrQesOuO8tC/kD+PlVHV+BrmkJ/u1F0D+P44T8ftmLPYsDQkGnUjglIANUh2BYxyW4Q4W7ov7EW51DNqzFoWBVOeLT5ZmEgDzhrDWGAj3nTGQLrkyBt5sS+GDwg0RgS/Wqw6LG0r3rx+dMka4WrdBKT50e0O0aXuerG7pxkg0aXdrMFQ2JPDR3CZrcC4Jc/3Iu6eZjonD9qqk+UCjwkryanoVpYDWFn6O/oLriwjycDOz9DVcze7x86mXeJiaQKZWeWzNnX9XR7OcQ6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOsFH9DUIsRevNr+tDzm4rbkRN4/MqE0AkpMHDYlKf4=;
 b=RjApMyh6Og6JIABtgRcUxBAZXnDouga7Btzf7kcBfqNHlQenFl0DePUpYwYyvl9bisP455RmyopWejp1w9oexdRi6/zgcL3s/QNFbsti/aOIxxVPmbBDDuhDu69B6pqjTLK0uRRUI5GjGi1ivb4ue6H1CW9+QUnmdIm5tJ3c9ZFPCT0XHc3ThKPAorgdbMyJy7WwehALkuzurJsAK5VXxyIlEV0hblOuV/gT6mxfsPsJNCiVttAb7foVacOJMrTtc+UWKZQdEugzWtztvDrk0Qsg3A9vSDRcOSR978FgP7lPscoixh5a50kL5bvuFSCQ1MQGRXv/XHycGWMdULHUxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOsFH9DUIsRevNr+tDzm4rbkRN4/MqE0AkpMHDYlKf4=;
 b=JdTDvg750huBbHtS2QCOuzx6GhmPAS3nWfCAaIID3WeXI9iY8hnsnERJiJwaViij+hd16QfHsxUasehFwB2DOFCYBBw2hfHEgUSjEHyKijVHiCpW77jPG7tHAsNyVFV0PPOMSjybLCpUWD+Fl+y/QPrBS3ct1Q50BxEMi6Bj9jY=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4988.namprd12.prod.outlook.com (2603:10b6:5:16a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.33; Fri, 26 Feb 2021 07:24:45 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53%5]) with mapi id 15.20.3890.023; Fri, 26 Feb 2021
 07:24:44 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, Guchun" <Guchun.Chen@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: remove unnecessary reading for epprom
 header
Thread-Topic: [PATCH v2] drm/amdgpu: remove unnecessary reading for epprom
 header
Thread-Index: AQHXDAqV110Qlsvw5EeKEi5eJiWU1KpqCLYw
Date: Fri, 26 Feb 2021 07:24:44 +0000
Message-ID: <DM6PR12MB407545AA4EA38EBEDF0E24E3FC9D9@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210226064228.30488-1-Dennis.Li@amd.com>
In-Reply-To: <20210226064228.30488-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-26T07:24:43Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f8c838c2-6e6c-4f3a-a66f-53721ce74d7b;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e378e6ca-a975-4528-66f7-08d8da279746
x-ms-traffictypediagnostic: DM6PR12MB4988:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4988F1E77B617A49984911D3FC9D9@DM6PR12MB4988.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K3770gPVK9yLeoX4b26VjOSTDYsPIw55nC2vI0xJY7Sxzs5mmopwxJKhO9xF9VpmX2h2P4LYZfxch8u+vCDInDBaT+SWQGWwn7bk/YrlgPDs7ZKLonMB50VwS2Drulw/BEpkoPxfH8kS7JZJvu288mFFWt6Xvf6T1wDFNoI6RKymWIsfwSHrBmXGOld62pv6BvNr0Jl5WZH1ZOhzhc5Vz9WSvbb+TpKRv4CfIkOxQsnO91Ikc2sKCbt9nuKX1LivpWqcwpeD1oTy0cCr/h0HDmU6OLGutLlwnrFYkUO0pr1v1iuwhUk7unLO2nlGN1aDx9Ewxb5qwqbRkXN4EU2v4xuUwJPyVIrxM583592B3aB0NSDA/lmBpkRn6mG5SMQ7brjrR7G38BJ3oM06VmJ2LeNNnSjKEAF1EaqbdBhefuZG4m7oGgLfeD0krg2i1iu2N50S9KGSnuC4hJe1P8bAbytmK8pF6FpIujsA9Z21kyFFBRpfDvrVrCUXPah5yFPJw0iGIb4yYnfUngLwETIqXw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(110136005)(71200400001)(33656002)(86362001)(66556008)(83380400001)(66446008)(186003)(6636002)(478600001)(5660300002)(8936002)(64756008)(2906002)(66946007)(6506007)(66476007)(8676002)(76116006)(4326008)(26005)(53546011)(9686003)(7696005)(55016002)(52536014)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BzOVIIXMtwsDpQPhgwFWESAsneGyW/mpiveSw/KWk96zBUzzSvyTXcoCiW/u?=
 =?us-ascii?Q?6xXgCDVdLf7K3Ad57ik55MH0othnx4CzjjN2vuRkBHVSz5bZLjVvibzYH/1J?=
 =?us-ascii?Q?MSiJWoFRoku/jZ+2yXWycF8HG3Hb0sL5yuJAzQVV5xc7JsaXXNqgyeqa3wuY?=
 =?us-ascii?Q?oJkLT5KoijXx3tcjiNuVMoi5sEsr37nrajPboK/oLS8AcpPXhFh8kZ84mJHr?=
 =?us-ascii?Q?vAT8ABHvjQ/cntKJDHcDnDK9UIw/FidEyIwqHgsOfle/Y/7BltKimKx0OyxK?=
 =?us-ascii?Q?JgG5XKlPIJPwsctCxtsuaRlGg4qqY2IgrMBAobYl08dhzyhw3/Cve/ramASm?=
 =?us-ascii?Q?nb2S4q36FwuDdDgITtUVnBOP0vOVZoEaqjZnzzX/YULX1BdpRbSPqQT+xO9n?=
 =?us-ascii?Q?OxCrWs2EAgK72m2lVv0B5i4q8HAVLfCWzE2/D2ueZg9iMd+D8AgGU5gQilwm?=
 =?us-ascii?Q?x7FRd2rhpTPlzUribDfbziZ6IAZBtdfTeyYwEukxSqlwjHCrI0dhpOvdg1+4?=
 =?us-ascii?Q?AtsRIDN+9HLZ6roGC6Q6NHJ5E6UCoTMnB0q+LaTHvUSljCcXc6kpiEkJJzMq?=
 =?us-ascii?Q?qrJ9OZg4/G5fqWF/mwPnun5xfgiWd+gZgUMbGBzKh2lzhavos1zjNlqRhFaX?=
 =?us-ascii?Q?7Q/8/+MoqudN6hO2r6uA1EEqCg56ylbShw7GlOqDBRD6ctjKlh71L2oo0ywO?=
 =?us-ascii?Q?wNuymInzRhus5dcHgQCqiS9zzakWSTKxZhI7mWsAXIRDzwRdbf2CCgnyP/sj?=
 =?us-ascii?Q?43ukOFCJJ/09HwP8ODFHplfym2Rwojz1+cjDhj1jiS/3jrTcXK5ofYWQDgbE?=
 =?us-ascii?Q?a6T08h8CiArdYgSpjOnT60STet+B7DQsK6RIpPtL2D9vzS78SxM3VxS6J8DK?=
 =?us-ascii?Q?yQoGY0jq3KaTlTRgWaAIuyGrRmR3KD96Vn5+ziUYJI3+BiFegNMFaImP/VNu?=
 =?us-ascii?Q?E4ozoDVNuWC/6Fs/cvpcYOzs8MfxNbk81mjRFKLLOF4iWbyKZAKPVtM9gpfi?=
 =?us-ascii?Q?3SehpxiJudfUoJYJ+VUsKFykv+nxPXJ8sP72L6bBvj3rB2b0jxQdPpjVy5P3?=
 =?us-ascii?Q?HM1n7O7hSMMbsM79ze7auk5C8RpiA9iiESX17GI7h9T1D2INsQCpq8NrpZjn?=
 =?us-ascii?Q?C+KH8FE9pzNgO7LJ+ilDpy/1Qnvnx3kImWsAhxeU8TkwxAVP/YmMxZ8BXfXF?=
 =?us-ascii?Q?Blw+LlnGUztHjXE9F+JE0xRA/muztqlzqByt4I7uyD+uLcn06zXlRQ1pDQG+?=
 =?us-ascii?Q?955gz7x1SWWyEbZEVAM5SOg3q7qe4Omcwg9iBMiP/iTn/M8CVsNkxVcMZGz/?=
 =?us-ascii?Q?gpMIQ2d1PCut1e+m1p1jf8o3?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e378e6ca-a975-4528-66f7-08d8da279746
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 07:24:44.7984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n34Wdv5E6Xgvyb1L5wKL+AcU+YbbU9SPw3NQ5iti2jGYF6GmARHqsK+O94SuzSXBfOrUMJqTCs6cJjTcEw8kWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4988
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Friday, February 26, 2021 14:42
To: amd-gfx@lists.freedesktop.org; Chen, Guchun <Guchun.Chen@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH v2] drm/amdgpu: remove unnecessary reading for epprom header

If the number of badpage records exceed the threshold, driver has updated both epprom header and control->tbl_hdr.header before gpu reset, therefore GPU recovery thread no need to read epprom header directly.

v2: merge amdgpu_ras_check_err_threshold into amdgpu_ras_eeprom_check_err_threshold

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f0f7ed42ee7f..f2ff10403d93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4397,7 +4397,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 				 * bad_page_threshold value to fix this once
 				 * probing driver again.
 				 */
-				if (!amdgpu_ras_check_err_threshold(tmp_adev)) {
+				if (!amdgpu_ras_eeprom_check_err_threshold(tmp_adev)) {
 					/* must succeed. */
 					amdgpu_ras_resume(tmp_adev);
 				} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 09546dec40ff..c669435ccc74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2189,19 +2189,3 @@ bool amdgpu_ras_need_emergency_restart(struct amdgpu_device *adev)
 
 	return false;
 }
-
-bool amdgpu_ras_check_err_threshold(struct amdgpu_device *adev) -{
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	bool exc_err_limit = false;
-
-	if (con && (amdgpu_bad_page_threshold != 0))
-		amdgpu_ras_eeprom_check_err_threshold(&con->eeprom_control,
-						&exc_err_limit);
-
-	/*
-	 * We are only interested in variable exc_err_limit,
-	 * as it says if GPU is in bad state or not.
-	 */
-	return exc_err_limit;
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index aed0716efa5a..42aab9adc263 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -491,8 +491,6 @@ void amdgpu_ras_suspend(struct amdgpu_device *adev);  unsigned long amdgpu_ras_query_error_count(struct amdgpu_device *adev,
 		bool is_ce);
 
-bool amdgpu_ras_check_err_threshold(struct amdgpu_device *adev);
-
 /* error handling functions */
 int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 		struct eeprom_table_record *bps, int pages); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 19d9aa76cfbf..7f527f8bbdb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -434,47 +434,21 @@ static uint32_t __correct_eeprom_dest_address(uint32_t curr_address)
 	return curr_address;
 }
 
-int amdgpu_ras_eeprom_check_err_threshold(
-				struct amdgpu_ras_eeprom_control *control,
-				bool *exceed_err_limit)
+bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(control);
-	unsigned char buff[EEPROM_ADDRESS_SIZE +
-			EEPROM_TABLE_HEADER_SIZE] = { 0 };
-	struct amdgpu_ras_eeprom_table_header *hdr = &control->tbl_hdr;
-	struct i2c_msg msg = {
-			.addr = control->i2c_address,
-			.flags = I2C_M_RD,
-			.len = EEPROM_ADDRESS_SIZE + EEPROM_TABLE_HEADER_SIZE,
-			.buf = buff,
-	};
-	int ret;
-
-	*exceed_err_limit = false;
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
 	if (!__is_ras_eeprom_supported(adev))
-		return 0;
-
-	/* read EEPROM table header */
-	mutex_lock(&control->tbl_mutex);
-	ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
-	if (ret < 1) {
-		dev_err(adev->dev, "Failed to read EEPROM table header.\n");
-		goto err;
-	}
-
-	__decode_table_header_from_buff(hdr, &buff[2]);
+		return false;
 
-	if (hdr->header == EEPROM_TABLE_HDR_BAD) {
+	if (con->eeprom_control.tbl_hdr.header == EEPROM_TABLE_HDR_BAD) {
 		dev_warn(adev->dev, "This GPU is in BAD status.");
 		dev_warn(adev->dev, "Please retire it or setting one bigger "
 				"threshold value when reloading driver.\n");
-		*exceed_err_limit = true;
+		return true;
 	}
 
-err:
-	mutex_unlock(&control->tbl_mutex);
-	return 0;
+	return false;
 }
 
 int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index c7a5e5c7c61e..178721170974 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -80,9 +80,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 			bool *exceed_err_limit);
 int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control);
 
-int amdgpu_ras_eeprom_check_err_threshold(
-				struct amdgpu_ras_eeprom_control *control,
-				bool *exceed_err_limit);
+bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev);
 
 int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 					    struct eeprom_table_record *records,
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
