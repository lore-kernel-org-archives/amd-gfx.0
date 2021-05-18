Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F417C43461
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 12:19:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58DB61028
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 12:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58DB61028
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 204F86EB51;
	Tue, 18 May 2021 12:19:23 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EDD26EB4F
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 12:19:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUQxUx7DsEkLy8se0a7X4Z8pAWucjjfOGh1imasyEPgccuFjB8HLLH7JYzRNNb6wGkmA1Zs7Z6v83IEIWz/Uwsti2NbCBLrAg/Bwl6qm6WdrXEIXpSpb7KUJui+sUlrnslWmbcYX+ipRxDlkn+CIjf7DeKzQmcm6fk8jd4IU4gOrZ752r6JkqxCbGjMq5QX5WNMrp5qMkBgFNykpsrvRNnmkRGZSA7vn1/n6KZA+wyax7XSSo3I+LGLidT/7+2NWG8iar7cD58DDfOncL2bYnCLo/WYtm3Ff6ltOIfI0mwgnD2jpoLgZCVRjVJzjYosijUWS6uplGHPGd0xmjYD33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6E+ghMXcl9ZlSUpltsf8Cdv2UvbJUAD8JbBkUQ/1Saw=;
 b=b6hmQkNfk5ZyypRWANzWZDTY2JCmcnU/gf6k215fGfatgcRdhgvHQyPrWQCmMHkys5cKOvzekMffChC4GbXkbBHrhZpmami3jQubw8jv50ajFUMx6orxljHC8QeTGHZSTADf7K1RP0mzE1uxd4U8xzbItk/qfKsWAm0xF0p5XLaIWyiRycOW3w23uGQhBmxk3ndzm6bcrCCBQeEzgA+BoeZJo+Lfk/ffGUrRWsoA1hQ60MfuaCv7P5McI+rrJh8xvYo/fn9mlnqBMMOQRB2HlwpeudxtAoQK60kGAUene5Kw2hDZdeZoBIx97q8PMcmUbYr74GEUj23Q8xfVTAaKhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6E+ghMXcl9ZlSUpltsf8Cdv2UvbJUAD8JbBkUQ/1Saw=;
 b=EW8LnYiqB46P6XekPT7jueBy3nvYOSB+UU7BU1TdDme65bY1yoWWH85TPj6ONdfAjeSoTwfeySQMjp6BfmuOtWh8wsXAhZGcWZG4y4vxiqxDwyH0ANaxEerVB67pUZ3GvgneCKF032DpY1RSLRwQRdU+zeh7ikNWAABMM3+jeYY=
Received: from CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17)
 by CH2PR12MB5564.namprd12.prod.outlook.com (2603:10b6:610:65::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Tue, 18 May
 2021 12:19:20 +0000
Received: from CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a1d1:38a:2086:b5b]) by CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a1d1:38a:2086:b5b%3]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 12:19:18 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Nieto, David M" <David.Nieto@amd.com>,
 "maraeo@gmail.com" <maraeo@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add vbios info ioctl interface
Thread-Topic: [PATCH] drm/amdgpu: Add vbios info ioctl interface
Thread-Index: AQHXS9+nZ16zyHed7UewCZhFKBxS46rpJ7Pw
Date: Tue, 18 May 2021 12:19:18 +0000
Message-ID: <CH0PR12MB51560CD55134762EF8FE19E0F82C9@CH0PR12MB5156.namprd12.prod.outlook.com>
References: <20210518121628.9811-1-Jiawei.Gu@amd.com>
In-Reply-To: <20210518121628.9811-1-Jiawei.Gu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-18T12:19:12Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a87f3f97-2af8-41a3-9366-fab719f6ed53;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5abaa511-0d8f-430b-cf45-08d919f7292e
x-ms-traffictypediagnostic: CH2PR12MB5564:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB5564C31350481B7239E0950EF82C9@CH2PR12MB5564.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m8vr78e62aKANzD1hCCv2qpwor7GvKMwX8+FN44lcS89nQWdSnsU70tM+GTuwT7arOuWEhu0vJFRwqVUvVneebzzkoa6HpDQ8sK/GlldCr6LcdTj/6XOoEP6VaeTlBSipdQwchuHFFf7/BvUTofS0r+YWCknWV754Lxokrlq7RmU+5BBbX/RI5z2UlvoSGBDHyOoroJmv0DF2UQb5WJPhXLxHJliKj8KB+mR3IbeAYL5T5twlL2Qhb5jv4IRI4qmpnhqgg/Dzf9Q4qjElwPnFGL3oFzeoAchvR8PiUrD+an8HRf3Xe+pRJixeN+vbqHHAmyqITqwcBAbOrNNIr2FCE8bMkQZ3EfDH4ytGjrvL5ZC0oOrFmE4YOer8I+7QIhYw+9eRh9rhc5hhL0FrSIk1cvEqdEitOIF0sditm/iv1deGB1BBeiQAVHGvkuzAHYbWIaLK538yc54FqWRCkNJym7hdUygAwueCINjJbD8qWCyj1usiPHiOvw97aATJ3E/OH3JiRS8YVb8J+9qoCfLNGmZE1/+PqHtCoUD3HWyoshW27XQaJmvEnJWabaOa4uIDzzXAGEVoEy6iOXsWi35+ZtA884zHP5MTlpuzbCkrkXNmu9pMhCZrHHvNKBhxQKG+6Gm5fRvdtRzSbYGTCagFw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39850400004)(316002)(478600001)(6636002)(110136005)(55016002)(30864003)(9686003)(33656002)(186003)(26005)(71200400001)(6506007)(53546011)(66946007)(52536014)(76116006)(7696005)(66476007)(2906002)(66556008)(64756008)(66446008)(8676002)(8936002)(4326008)(122000001)(83380400001)(5660300002)(38100700002)(921005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GfrI9xUprgALj8VQFw0y5kQVBmtOF+5ndaHon/ogDYE0Rrte+OaQduAJTQHY?=
 =?us-ascii?Q?hvhK+xinAj2Qg9RWHAIY/Hnbw+6VFqMuQlwiQTzCgxZ+gW+Q3ZagDSRj4gdl?=
 =?us-ascii?Q?WXIb2IV35LA9Wxs4VfTBWzC+7KYepT8XYUvShUmibM/QFpHH9/sg99C29cvL?=
 =?us-ascii?Q?R1GpI4+AzdIa5mvRwVBCSCiMc9BMtJg2dQhIwpb2/CARSuaE7OcF4urpooT/?=
 =?us-ascii?Q?sJBTLKI0KkNqlhJif+BEhBiMr+zTkYp2PlPzwmziG3UkKJGTR9hKN0mpbxOJ?=
 =?us-ascii?Q?Mf0tS8nQ7fkOdDmZE/1rKLlfY2A6mlgxgSpA67qCw0UPDpbKXXSDPi3ATZix?=
 =?us-ascii?Q?aXVve6JLkENPr2tIDL/DwoWpY5gwNQaFECJ7CyfG3myNiioqFQ/lJ6KOLml0?=
 =?us-ascii?Q?LXxNo8VlM2h0O6XSXpzWPAkz96sJrTV4FY9zYkhgyNkrRe7JeaR0GA3Fg/qk?=
 =?us-ascii?Q?pYWSlfMlb4yPcSUmyokYjihJ2GmN6fEHipXK7WrL00oYI13n5kE2BDABKMK0?=
 =?us-ascii?Q?+hth6htEGDstnMAmKb191ismAqrs3UPkfgm5Rr60OZYqRJEl7cih/fvaBd6q?=
 =?us-ascii?Q?2F90z07jwxnoXAecKg7S8Z7qmV8WFllgRqkd8h7HupdkgLdMrx0GmMSxfCdt?=
 =?us-ascii?Q?VtuMHvWnLGhe3QZZLWKut8U6+sEX+hWTW+TnBFt1xy9OgJ2rfxpPiD0v6NRF?=
 =?us-ascii?Q?7udyETjMWNCIEfXmlSB6jpBdwebWrLqAoGE7xtlTGrJV+8X6kPgKcN8NvIPv?=
 =?us-ascii?Q?7QUhacJtwmanOkgfp+mGTfQVGm18vnP4uhTz9AjqTAQzL20dU+HXQaSx8r0U?=
 =?us-ascii?Q?eyeX09GaNjkazRBwCcur5MPqGnpOrJh3LpeQrXVPhiFqqP+MlIZHVOXWnmk8?=
 =?us-ascii?Q?9ZrmOtXsZCe9CMfgNswdxD8uqt5RNkBtAnN/V+ndgbZ3+UH1A8KcxBssJrSj?=
 =?us-ascii?Q?Gn6qavmbE3fmwA6kQZ+VwUiADU7TSTHE73gmXih4iCby09wis+E3J0S/6GgT?=
 =?us-ascii?Q?71cvRGWxRDJ8FBZFhqvDIVZlTSB6EvwX6D1OxWt2XKPd7pssbbZyvZuJ3r4A?=
 =?us-ascii?Q?PaEijYBssbHFZJ4B6PHKXv3jJjwFOgkvPg8PDDo/52ZCK2gYTkZDBrMNIvOK?=
 =?us-ascii?Q?qn5tTXTdH5eOLwlLhI36EM2GpWH+rC4pJCpO1pecFwBKnxoYJhAebhj7BMsI?=
 =?us-ascii?Q?47QLPyRmB2QF97zMenNU+OiLgjUUDHg1jaHhJF0tD6XUFrVLjSBc0thdlAXA?=
 =?us-ascii?Q?I1gr4KQPgr4xvYD66zhxxiazmYew1pB7g+Ya+8Mu4g6jwbjgraFcrvZMLBcQ?=
 =?us-ascii?Q?33B0DL8TccingDVKz1eM4AP0?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abaa511-0d8f-430b-cf45-08d919f7292e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 12:19:18.6563 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwfxcuFV7Dga1oDypR+HSYudAZ93A9BjHqr9R90mY2J2CNFGx/uXyAvZ5qAN+K5oaCxIZlFcv3UQtE9lBd9Rrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5564
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi all,

Please help confirm that we're all fine with this new struct in uapi in this V3 patch:

+struct drm_amdgpu_info_vbios {
+	__u8 name[64];
+	__u8 vbios_pn[64];
+	__u32 version;
+	__u8 vbios_ver_str[32];
+	__u8 date[32];
+};

Best regards,
Jiawei

-----Original Message-----
From: Jiawei Gu <Jiawei.Gu@amd.com> 
Sent: Tuesday, May 18, 2021 8:16 PM
To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.com>; Nieto, David M <David.Nieto@amd.com>; maraeo@gmail.com; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Deng, Emily <Emily.Deng@amd.com>; Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
Subject: [PATCH] drm/amdgpu: Add vbios info ioctl interface

Add AMDGPU_INFO_VBIOS_INFO subquery id for detailed vbios info.

Provides a way for the user application to get the VBIOS information without having to parse the binary.
It is useful for the user to be able to display in a simple way the VBIOS version in their system if they happen to encounter an issue.

V2:
Use numeric serial.
Parse and expose vbios version string.

V3:
Remove redundant data in drm_amdgpu_info_vbios struct.

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  15 ++
 drivers/gpu/drm/amd/amdgpu/atom.c          | 172 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/atom.h          |  10 ++
 drivers/gpu/drm/amd/include/atomfirmware.h |   5 +
 include/uapi/drm/amdgpu_drm.h              |  10 ++
 5 files changed, 212 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 8d12e474745a..524e4fe5efe8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -861,6 +861,21 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 					    min((size_t)size, (size_t)(bios_size - bios_offset)))
 					? -EFAULT : 0;
 		}
+		case AMDGPU_INFO_VBIOS_INFO: {
+			struct drm_amdgpu_info_vbios vbios_info = {};
+			struct atom_context *atom_context;
+
+			atom_context = adev->mode_info.atom_context;
+			memcpy(vbios_info.name, atom_context->name, sizeof(atom_context->name));
+			memcpy(vbios_info.vbios_pn, atom_context->vbios_pn, sizeof(atom_context->vbios_pn));
+			vbios_info.version = atom_context->version;
+			memcpy(vbios_info.vbios_ver_str, atom_context->vbios_ver_str,
+						sizeof(atom_context->vbios_ver_str));
+			memcpy(vbios_info.date, atom_context->date, 
+sizeof(atom_context->date));
+
+			return copy_to_user(out, &vbios_info,
+						min((size_t)size, sizeof(vbios_info))) ? -EFAULT : 0;
+		}
 		default:
 			DRM_DEBUG_KMS("Invalid request %d\n",
 					info->vbios_info.type);
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 3dcb8b32f48b..6fa2229b7229 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -31,6 +31,7 @@
 
 #define ATOM_DEBUG
 
+#include "atomfirmware.h"
 #include "atom.h"
 #include "atom-names.h"
 #include "atom-bits.h"
@@ -1299,12 +1300,168 @@ static void atom_index_iio(struct atom_context *ctx, int base)
 	}
 }
 
+static void atom_get_vbios_name(struct atom_context *ctx) {
+	unsigned char *p_rom;
+	unsigned char str_num;
+	unsigned short off_to_vbios_str;
+	unsigned char *c_ptr;
+	int name_size;
+	int i;
+
+	const char *na = "--N/A--";
+	char *back;
+
+	p_rom = ctx->bios;
+
+	str_num = *(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS);
+	if (str_num != 0) {
+		off_to_vbios_str =
+			*(unsigned short *)(p_rom + OFFSET_TO_GET_ATOMBIOS_STRING_START);
+
+		c_ptr = (unsigned char *)(p_rom + off_to_vbios_str);
+	} else {
+		/* do not know where to find name */
+		memcpy(ctx->name, na, 7);
+		ctx->name[7] = 0;
+		return;
+	}
+
+	/*
+	 * skip the atombios strings, usually 4
+	 * 1st is P/N, 2nd is ASIC, 3rd is PCI type, 4th is Memory type
+	 */
+	for (i = 0; i < str_num; i++) {
+		while (*c_ptr != 0)
+			c_ptr++;
+		c_ptr++;
+	}
+
+	/* skip the following 2 chars: 0x0D 0x0A */
+	c_ptr += 2;
+
+	name_size = strnlen(c_ptr, STRLEN_LONG - 1);
+	memcpy(ctx->name, c_ptr, name_size);
+	back = ctx->name + name_size;
+	while ((*--back) == ' ')
+		;
+	*(back + 1) = '\0';
+}
+
+static void atom_get_vbios_date(struct atom_context *ctx) {
+	unsigned char *p_rom;
+	unsigned char *date_in_rom;
+
+	p_rom = ctx->bios;
+
+	date_in_rom = p_rom + OFFSET_TO_VBIOS_DATE;
+
+	ctx->date[0] = '2';
+	ctx->date[1] = '0';
+	ctx->date[2] = date_in_rom[6];
+	ctx->date[3] = date_in_rom[7];
+	ctx->date[4] = '/';
+	ctx->date[5] = date_in_rom[0];
+	ctx->date[6] = date_in_rom[1];
+	ctx->date[7] = '/';
+	ctx->date[8] = date_in_rom[3];
+	ctx->date[9] = date_in_rom[4];
+	ctx->date[10] = ' ';
+	ctx->date[11] = date_in_rom[9];
+	ctx->date[12] = date_in_rom[10];
+	ctx->date[13] = date_in_rom[11];
+	ctx->date[14] = date_in_rom[12];
+	ctx->date[15] = date_in_rom[13];
+	ctx->date[16] = '\0';
+}
+
+static unsigned char *atom_find_str_in_rom(struct atom_context *ctx, char *str, int start,
+					   int end, int maxlen)
+{
+	unsigned long str_off;
+	unsigned char *p_rom;
+	unsigned short str_len;
+
+	str_off = 0;
+	str_len = strnlen(str, maxlen);
+	p_rom = ctx->bios;
+
+	for (; start <= end; ++start) {
+		for (str_off = 0; str_off < str_len; ++str_off) {
+			if (str[str_off] != *(p_rom + start + str_off))
+				break;
+		}
+
+		if (str_off == str_len || str[str_off] == 0)
+			return p_rom + start;
+	}
+	return NULL;
+}
+
+static void atom_get_vbios_pn(struct atom_context *ctx) {
+	unsigned char *p_rom;
+	unsigned short off_to_vbios_str;
+	unsigned char *vbios_str;
+	int count;
+
+	off_to_vbios_str = 0;
+	p_rom = ctx->bios;
+
+	if (*(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS) != 0) {
+		off_to_vbios_str =
+			*(unsigned short *)(p_rom + OFFSET_TO_GET_ATOMBIOS_STRING_START);
+
+		vbios_str = (unsigned char *)(p_rom + off_to_vbios_str);
+	} else {
+		vbios_str = p_rom + OFFSET_TO_VBIOS_PART_NUMBER;
+	}
+
+	if (*vbios_str == 0) {
+		vbios_str = atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX, 3, 1024, 64);
+		if (vbios_str == NULL)
+			vbios_str += sizeof(BIOS_ATOM_PREFIX) - 1;
+	}
+	if (vbios_str != NULL && *vbios_str == 0)
+		vbios_str++;
+
+	if (vbios_str != NULL) {
+		count = 0;
+		while ((count < BIOS_STRING_LENGTH) && vbios_str[count] >= ' ' &&
+		       vbios_str[count] <= 'z') {
+			ctx->vbios_pn[count] = vbios_str[count];
+			count++;
+		}
+
+		ctx->vbios_pn[count] = 0;
+	}
+}
+
+static void atom_get_vbios_version(struct atom_context *ctx) {
+	unsigned char *vbios_ver;
+
+	/* find anchor ATOMBIOSBK-AMD */
+	vbios_ver = atom_find_str_in_rom(ctx, BIOS_VERSION_PREFIX, 3, 1024, 64);
+	if (vbios_ver != NULL) {
+		/* skip ATOMBIOSBK-AMD VER */
+		vbios_ver += 18;
+		memcpy(ctx->vbios_ver_str, vbios_ver, STRLEN_NORMAL);
+	} else {
+		ctx->vbios_ver_str[0] = '\0';
+	}
+}
+
 struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)  {
 	int base;
 	struct atom_context *ctx =
 	    kzalloc(sizeof(struct atom_context), GFP_KERNEL);
 	char *str;
+	struct _ATOM_ROM_HEADER *atom_rom_header;
+	struct _ATOM_MASTER_DATA_TABLE *master_table;
+	struct _ATOM_FIRMWARE_INFO *atom_fw_info;
 	u16 idx;
 
 	if (!ctx)
@@ -1353,6 +1510,21 @@ struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
 		strlcpy(ctx->vbios_version, str, sizeof(ctx->vbios_version));
 	}
 
+	atom_rom_header = (struct _ATOM_ROM_HEADER *)CSTR(base);
+	if (atom_rom_header->usMasterDataTableOffset != 0) {
+		master_table = (struct _ATOM_MASTER_DATA_TABLE *)
+				CSTR(atom_rom_header->usMasterDataTableOffset);
+		if (master_table->ListOfDataTables.FirmwareInfo != 0) {
+			atom_fw_info = (struct _ATOM_FIRMWARE_INFO *)
+					CSTR(master_table->ListOfDataTables.FirmwareInfo);
+			ctx->version = atom_fw_info->ulFirmwareRevision;
+		}
+	}
+
+	atom_get_vbios_name(ctx);
+	atom_get_vbios_pn(ctx);
+	atom_get_vbios_date(ctx);
+	atom_get_vbios_version(ctx);
 
 	return ctx;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdgpu/atom.h
index d279759cab47..0c1839824520 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.h
+++ b/drivers/gpu/drm/amd/amdgpu/atom.h
@@ -112,6 +112,10 @@ struct drm_device;
 #define ATOM_IO_SYSIO		2
 #define ATOM_IO_IIO		0x80
 
+#define STRLEN_NORMAL		32
+#define STRLEN_LONG		64
+#define STRLEN_VERYLONG		254
+
 struct card_info {
 	struct drm_device *dev;
 	void (* reg_write)(struct card_info *, uint32_t, uint32_t);   /*  filled by driver */
@@ -140,6 +144,12 @@ struct atom_context {
 	uint32_t *scratch;
 	int scratch_size_bytes;
 	char vbios_version[20];
+
+	uint8_t name[STRLEN_LONG];
+	uint8_t vbios_pn[STRLEN_LONG];
+	uint32_t version;
+	uint8_t vbios_ver_str[STRLEN_NORMAL];
+	uint8_t date[STRLEN_NORMAL];
 };
 
 extern int amdgpu_atom_debug;
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 275468e4be60..28deecc2f990 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -197,6 +197,9 @@ enum atom_dp_vs_preemph_def{
   DP_VS_LEVEL0_PREEMPH_LEVEL3 = 0x18,
 };
 
+#define BIOS_ATOM_PREFIX   "ATOMBIOS"
+#define BIOS_VERSION_PREFIX  "ATOMBIOSBK-AMD"
+#define BIOS_STRING_LENGTH 43
 
 /*
 enum atom_string_def{
@@ -215,6 +218,8 @@ enum atombios_image_offset{
   MAXSIZE_OF_ATOMBIOS_ASIC_BUS_MEM_TYPE      = 20,  /*including the terminator 0x0!*/
   OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS   = 0x2f,
   OFFSET_TO_GET_ATOMBIOS_STRING_START        = 0x6e,
+  OFFSET_TO_VBIOS_PART_NUMBER                = 0x80,
+  OFFSET_TO_VBIOS_DATE                       = 0x50,
 };
 
 /****************************************************************************   
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h index 9169df7fadee..155fd9918b4d 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -756,6 +756,8 @@ struct drm_amdgpu_cs_chunk_data {
 	#define AMDGPU_INFO_VBIOS_SIZE		0x1
 	/* Subquery id: Query vbios image */
 	#define AMDGPU_INFO_VBIOS_IMAGE		0x2
+	/* Subquery id: Query vbios info */
+	#define AMDGPU_INFO_VBIOS_INFO		0x3
 /* Query UVD handles */
 #define AMDGPU_INFO_NUM_HANDLES			0x1C
 /* Query sensor related information */
@@ -949,6 +951,14 @@ struct drm_amdgpu_info_firmware {
 	__u32 feature;
 };
 
+struct drm_amdgpu_info_vbios {
+	__u8 name[64];
+	__u8 vbios_pn[64];
+	__u32 version;
+	__u8 vbios_ver_str[32];
+	__u8 date[32];
+};
+
 #define AMDGPU_VRAM_TYPE_UNKNOWN 0
 #define AMDGPU_VRAM_TYPE_GDDR1 1
 #define AMDGPU_VRAM_TYPE_DDR2  2
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
