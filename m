Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2A0C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 13:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA88360FED
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 13:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA88360FED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C37A89E15;
	Tue, 13 Apr 2021 13:09:09 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D62386E0F2
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 13:09:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcBzkx9mNxRtepwjCQrBNuMnSd+6rI2qdFY+6gs2slRyaSXTvhBHbZvu+eYptAN8vNbU+RADQwWtGc4WhM/ApOB2Ey7tJGQiaVF/8w0p+AN5f01TkGPNdoTuSXZlXXqt9jbqBndXBXMLD309jHjIfeR5GL3kbvFb1bCcsvLry7QDHb5KXC41+UGOtSkmrWe5nr1Oe8TSyDUULBScwXIYp1+xpDCPECR8yyTHSJG4j2xiwu+VcOD1VTzqfF06EiE/Ip98USprsH0X40Uz0KJbT1+D7dUDCeN+tVzyjJq9X+iacBFvABraNhlo7t178P4spTg7CZgsw2GBRctj4GQ/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZAHW7QtSoPY1uzykJUrby1QBvBp9ocSbkXetWjL8wQ=;
 b=MZlkhlIeBmEaJonXJ8r6qECVRstecf8QviGJmboz/viyt8nYnKSH1cjvOXXdtXIlO32a0GFTlE826uLWFrwqmU/6X4XNwEkS3GY6dWf7Q4eEuLr+pldVik5DwyIzCItmARRtHPcPzvjjvl7Hh8XQX/7Xl03AHj6EbdkLjQ6F4zHd/WWgCdO0OB4MxKpJ6YoJsMrK/o4XKYw2srfnRdIGTLViTSDWcOGckf9EINHDzhBbksOBY/XLbojo4bZmxQhua2JGdRwgUn4BCsLAfBjHY51RsLptmUte+AcecMxtRSmspg26N9MGLsF0HZZSc+TpuylyaunFvyt8P/IIHW//nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZAHW7QtSoPY1uzykJUrby1QBvBp9ocSbkXetWjL8wQ=;
 b=MqNCib6znk1Ih8qRy73vGJGVcJROXU0NTpYwE1nw1OL1rJ2OxmANxclarZE3JW6pLdEGz2+E11OqJQoGaZMYnsskfF40hzUzJZUSdXuZXbbmDNQBVKlBKFrt13y19j9Bb02/C6yLa8bSsR8ivqFM24NE1S0P5EzzBrJGhWsiWbc=
Received: from CY4PR12MB1606.namprd12.prod.outlook.com (2603:10b6:910:10::15)
 by CY4PR12MB1799.namprd12.prod.outlook.com (2603:10b6:903:11c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Tue, 13 Apr
 2021 13:09:04 +0000
Received: from CY4PR12MB1606.namprd12.prod.outlook.com
 ([fe80::5c7c:99fe:5cd5:5848]) by CY4PR12MB1606.namprd12.prod.outlook.com
 ([fe80::5c7c:99fe:5cd5:5848%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 13:09:04 +0000
From: "Sun, Roy" <Roy.Sun@amd.com>
To: "Sun, Roy" <Roy.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Expose some power info through AMDGPU_INFO
Thread-Topic: [PATCH] drm/amd/amdgpu: Expose some power info through
 AMDGPU_INFO
Thread-Index: AQHXL5V7cCOnoXbJb0SWwAM1BKz3nKqybDbQ
Date: Tue, 13 Apr 2021 13:09:04 +0000
Message-ID: <CY4PR12MB16062ED181829A47D1B4EC1DFF4F9@CY4PR12MB1606.namprd12.prod.outlook.com>
References: <20210412121505.23787-1-Roy.Sun@amd.com>
In-Reply-To: <20210412121505.23787-1-Roy.Sun@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-13T13:05:48Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=74bbdb2a-860b-4d91-9c68-679c05ee4b41;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64f2ecd8-8b5f-4360-2726-08d8fe7d508c
x-ms-traffictypediagnostic: CY4PR12MB1799:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB17992C3DAC5D7B46313D8E80FF4F9@CY4PR12MB1799.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z4F/UlvfOqL94mWRQ9wBjkOm1SpvkQ/xhS8czu8oOGdm9pH8K/TM1njyqkPTn2pZlck3+EhGH6ahee2kfoMu8UGIEJLWhwa4Qi7A0Fe/Oawtijq7WdOCB6v0sokzRscegQFgwsh4/tEffeLK2LyIo7njpP2IjLjDor+eCTPtiKw9NXdII5SdrUjKUS2+76nUx8xPYtfIQUJU0yoTJum/VHq5jw2/6UJnZZZL+fdAlYxZeJLMVnZQ4YSnBYHTWu0tzD73w3fb1Q34lvphxSLs5N0qcF56JfJVEuOPpgcKYiyLxrunFvo0F0/lEg3Qusgk0RHkaCBWOIJND/9jJ9X6V5c/L+p9tI0BHfrvzOsEbfgnYH5qiMRkwpPq0NIFoG+4MC9xoX60R2e+G20JdL7VWmv1BVFz74okpO5ehmgyui5PIOQqOkVrjUeanbnKJzltG8tqgGevdnps4zD8jDXA9PlsZLC46AoeSpGGRNfB8NYNUz7QEXeOZyldywk29VpbIP4+3fA56Pubh4v+35nKJ/Y8mwxMtqUSFkbME6DQAXxZlyzJyQSKhL3zylfOi2y8iOkO0fB189qePEGhheossnXWaZnx2TmyRXNa/qJTotM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1606.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(26005)(38100700002)(110136005)(33656002)(53546011)(6506007)(316002)(5660300002)(8936002)(186003)(71200400001)(8676002)(478600001)(9686003)(66476007)(76116006)(64756008)(66446008)(66946007)(83380400001)(66556008)(52536014)(86362001)(2906002)(7696005)(55016002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LGqKrjge42TiwQu7TSn1kfkDlUbI9iNqa22cf5V9t1sS7g9e7PukMZVEvIhS?=
 =?us-ascii?Q?O71LsEzQCAtHqtPEBsxwHRiofRSD5ezFr7p4ICgl/SidFMinV5eJRmnHgmWo?=
 =?us-ascii?Q?seNt56um68iT2gX4OnXyMgkpOP7gM3lCi87NwuXVvm4Et5rR6HJ+1CceTMNr?=
 =?us-ascii?Q?DR2WVjEuWcWUzEB++CNaDWQPBThoMsVmIZic0TIYTM4DIuVm6+PpokEsQMnt?=
 =?us-ascii?Q?iZ4ux5oGbVcpUttZ8dDkEaZ8Bpw+TzhQkjHNvgbVESdMBBUIpximCmS3hThs?=
 =?us-ascii?Q?X2LrXYjR6UE9vvnNv6hx5N1tFUVAqkCltVCAwHPxAHmzzSnJQCqfxql/E2d0?=
 =?us-ascii?Q?T8IzwuPT2yu72nSwLEPWI/PA0Oo6exPreZZpzpMsaGjeQnfS4QrCtCnmqhiA?=
 =?us-ascii?Q?+zOur0yv/xcHHkYEDdct9suyyma07QH4kwvDjrwqUJZXslFVy8+Vio4QZwxG?=
 =?us-ascii?Q?9Pq5S/8b2ypZ6o5GELLvLT7Axa+4aFhcZmzbEQAgQ2zciEc4rrSuDdUzilKy?=
 =?us-ascii?Q?2oN9lygqzqt8q8eUi398OX67CuoYWW7rdInt5fHI4sj0hZqO4De10eUql+tN?=
 =?us-ascii?Q?+xaWvMxOSugCINHniTt0iEC/i/+WxNfif2Ux9XoJv2rQHNsg7YN5cLYGiSUC?=
 =?us-ascii?Q?tKkhFqMVIu682ViiFa9vI4cbsoK3cCRoThBEeLpalUGKpoWmb7u5wxI1Imqd?=
 =?us-ascii?Q?E1ANCyty+SKeJpmYk/0Gp7BkBgttYLmi1JAyQ3thiCJEaPNpUWuDXWFwCfyF?=
 =?us-ascii?Q?nHS8MpBxzO2qnnrln6PM2cTN2x6pZcCeeifZP+p76CvTIcGc1T0j6w3GffWB?=
 =?us-ascii?Q?gAB0aA1yX38UBjen7L57JJa5kQGPd7cuotX8FHcaCxEiFPqgBYP/4W5ulW1s?=
 =?us-ascii?Q?z5T7MP95zXUdVKAxX1ry6SnRul9quygklrYHzKC48tf1cAdXvA3vdZUeXU6R?=
 =?us-ascii?Q?9YiZteTtsONCiq9QMyGOl9kQXvNNkMn9w323Hn8eG+Ic45FgO9gpFsVnGNZg?=
 =?us-ascii?Q?g73CiNIZkh56SOjcf77YxfCkMb/Org6gPk3SD4oqvdrjRovN9zn3+BAmi7Pt?=
 =?us-ascii?Q?gzQLHPz5aT3F2y2nBc8WaK2hfTiZp81rRkihl38Ba8gfY8UjkzBcOZNQSlp7?=
 =?us-ascii?Q?2HsqzkcjReDM/u6ZPQucfuhmeUGvH+AazWRQw77xxHfg/RRyRrw50Ns5ZnCC?=
 =?us-ascii?Q?Kvz4CdAYO9ucpkLVuQY8wTBl1zA969/KU+trtK264yG4PPWslzBiyOGTZAo8?=
 =?us-ascii?Q?lQR6FssElAhK1Chw5pHWv5fGrv3jlPKjiiA5wu80uOyUDB1fY/qPOEjw/IYy?=
 =?us-ascii?Q?TWtH+OYhD9UNo3tu5w/61XOW?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1606.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f2ecd8-8b5f-4360-2726-08d8fe7d508c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 13:09:04.6635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KcOU3aKakCrwhcWSJ3jaO4+M+f4QL06QAQ1HqVeOILtk30je59sGZsqJRutoBLDJGjjNjWjWKq5Jf/AABXItug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1799
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

ping

-----Original Message-----
From: Roy Sun <Roy.Sun@amd.com> 
Sent: Monday, April 12, 2021 8:15 PM
To: amd-gfx@lists.freedesktop.org
Cc: Sun, Roy <Roy.Sun@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Expose some power info through AMDGPU_INFO

Add interface to get the mm clock, temperature and memory load

Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 50 +++++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           | 12 ++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index b2e774aeab45..e5b16e0819ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -971,6 +971,56 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			}
 			ui32 /= 100;
 			break;
+		case AMDGPU_INFO_SENSOR_UVD_VCLK:
+			/* get mm vclk in Mhz */
+			if (amdgpu_dpm_read_sensor(adev,
+						   AMDGPU_PP_SENSOR_UVD_VCLK,
+						   (void *)&ui32, &ui32_size)) {
+				return -EINVAL;
+			}
+			ui32 /= 100;
+			break;
+		case AMDGPU_INFO_SENSOR_UVD_DCLK:
+			/* get mm dclk in Mhz */
+			if (amdgpu_dpm_read_sensor(adev,
+						   AMDGPU_PP_SENSOR_UVD_DCLK,
+						   (void *)&ui32, &ui32_size)) {
+				return -EINVAL;
+			}
+			ui32 /= 100;
+			break;
+		case AMDGPU_INFO_SENSOR_HOTSPOT_TEMP:
+			/* get junction temperature */
+			if (amdgpu_dpm_read_sensor(adev,
+						   AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
+						   (void *)&ui32, &ui32_size)) {
+				return -EINVAL;
+			}
+			break;
+		case AMDGPU_INFO_SENSOR_EDGE_TEMP:
+			/* get current edge temperature */
+			if (amdgpu_dpm_read_sensor(adev,
+						   AMDGPU_PP_SENSOR_EDGE_TEMP,
+						   (void *)&ui32, &ui32_size)) {
+				return -EINVAL;
+			}
+			break;
+		case AMDGPU_INFO_SENSOR_MEM_TEMP:
+			/* get current memory temperature */
+			if (amdgpu_dpm_read_sensor(adev,
+						   AMDGPU_PP_SENSOR_MEM_TEMP,
+						   (void *)&ui32, &ui32_size)) {
+				return -EINVAL;
+			}
+			break;
+		case AMDGPU_INFO_SENSOR_MEM_LOAD:
+			/* get memory load */
+			if (amdgpu_dpm_read_sensor(adev,
+						   AMDGPU_PP_SENSOR_MEM_LOAD,
+						   (void *)&ui32, &ui32_size)) {
+				return -EINVAL;
+			}
+			break;
 		default:
 			DRM_DEBUG_KMS("Invalid request %d\n",
 				      info->sensor_info.type);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h index 8b832f7458f2..484c72e17c72 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -780,6 +780,18 @@ struct drm_amdgpu_cs_chunk_data {
 	#define AMDGPU_INFO_SENSOR_STABLE_PSTATE_GFX_SCLK		0x8
 	/* Subquery id: Query GPU stable pstate memory clock */
 	#define AMDGPU_INFO_SENSOR_STABLE_PSTATE_GFX_MCLK		0x9
+	/* Subquery id: Query GPU mm vclk */
+	#define AMDGPU_INFO_SENSOR_UVD_VCLK		0xa
+	/* Subquery id: Query GPU mm dclk */
+	#define AMDGPU_INFO_SENSOR_UVD_DCLK		0xb
+	/* Subquery id: Query junction temperature */
+	#define AMDGPU_INFO_SENSOR_HOTSPOT_TEMP		0xc
+	/* Subquery id: Query edge temperature */
+	#define AMDGPU_INFO_SENSOR_EDGE_TEMP		0xd
+	/* Subquery id: Query memory temperature */
+	#define AMDGPU_INFO_SENSOR_MEM_TEMP		0xe
+	/* Subquery id: Query Memory load */
+	#define AMDGPU_INFO_SENSOR_MEM_LOAD		0xf
 /* Number of VRAM page faults on CPU access. */
 #define AMDGPU_INFO_NUM_VRAM_CPU_PAGE_FAULTS	0x1E
 #define AMDGPU_INFO_VRAM_LOST_COUNTER		0x1F
--
2.31.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
