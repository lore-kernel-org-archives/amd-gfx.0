Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB86C05027
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jan 2023 02:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8211F10E096;
	Mon, 30 Jan 2023 02:27:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37FCE10E096
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jan 2023 02:27:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hocmuHCsPTFJbxB5LjzS2VI+ayRvcPzUflY8jdNUZ+J9SHn7OVbP7QR5ugYwogbdy8DoGsavBT049TEzed1wLphESeMZsLaeeG6PiEQE67RF0PLGI+0uKNnp6oyHVQXJZtv70is2z6djVbXDi7/IxeobxwCtdnbXN/YUU4Q5Fs7f/bOjgOJXn0I7SraR+dAViJDbjmoCOLAlXVUReW7GgkA3SVD6JYaVoUWwkQr6m3q2U5dnmKYqlK9dvSSB5qjNhcVF9wlr2SXMu1+Vd3uIYsNENvcXInHUZtDHggF/KDf+o3NjGRQq4yFXd/PRYxtkOykji1Y8XYbwSdQfAPB6Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQwmx0jpxwVcNzBHVirfqDtabMN2szuul012+0JjgyQ=;
 b=gxMmJuGsXhOHxEZWan0VFNLdcps+ETEcDqIVbO7LlCEdTjlI+ad4VTe92AloFgamK10pEEfy386zDvUvbDWLkSuWd+YN04pY7qML+6fGei7hLaHfMo84u4ymWO+y2o+9dK2FmvMo9lT3rF9BW1D1OH6/74KYVRzQtCcmmeqON5UPVwJ8debNxX29ZOP5zWqhHaF84pKFWOftlcNAIrRRfb54zuSpagNdEhJAfDbkKDhg0ryw+EKOUHSMTFty4i/xQiBVNhIRwLvhpA7b85eHzsYe0GlmsYfpInBVtAOwZSajXeY7k0/bQ/XGvoLdzL2zrXXW+WTOZLl1CwRgZAbJFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQwmx0jpxwVcNzBHVirfqDtabMN2szuul012+0JjgyQ=;
 b=UA90MoaP4/iplxwLmqv9+rNoIk/LmpoHy6bBqQ6V3aDu2b07i1B1Z51DTd3q8BZPHIX+Npyz+sxTlHW7BC5kDQc/WdgMNN+h6Ogt+m1HbWaOs7q4P9XoNqL8OfaGVIMZwyl4VUoPG7w3M8F5o1MdrzDWGkDeUmXLmZ8ZFeIwzu8=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by BL1PR12MB5379.namprd12.prod.outlook.com (2603:10b6:208:317::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 02:27:33 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::4f83:ee28:88d3:e58f]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::4f83:ee28:88d3:e58f%9]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 02:27:33 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH RESEND] drm/amd/pm: drop unneeded dpm features disablement
 for SMU 13.0.4/11
Thread-Topic: [PATCH RESEND] drm/amd/pm: drop unneeded dpm features
 disablement for SMU 13.0.4/11
Thread-Index: AQHZMsnNRSFt3faCZU21AEnyKpiG4K62Pwig
Date: Mon, 30 Jan 2023 02:27:33 +0000
Message-ID: <CY5PR12MB6369CB8E2C9714DBD82FE293C1D39@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20230128033604.2117471-1-tim.huang@amd.com>
In-Reply-To: <20230128033604.2117471-1-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-30T02:27:29Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=cdcea6ac-8e7e-4cd9-8d21-95e97cdc2dd8;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-30T02:27:29Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 5e96f708-6e67-4725-b2d0-d377dcfe084d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|BL1PR12MB5379:EE_
x-ms-office365-filtering-correlation-id: 7e7e72d7-7c7c-4229-46a3-08db02698b1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RZYP0vQk/3u2u27rrPbcZf3DI9Ym7YZhegVzRabol+iTY0wuLsjvObG3NB6NzEGYbJCZ3HabFUgxcxB7Hfmd4uXGFvZVt/FtgGdneDXBGGXdIGJziGzOetJHf36kFUJGgddfhzRzvLMZJF/i2hxpo9ZzDxrqQesZ7m38qx5nXHE3RpQvL/VtfIKKwtRxUXHVK8RQlc6adlYrpfTl7hMTJF05QOBsDNThNT8nJvZGthgLWE8hOogbSKOjev3d3hOVnxYyDsX4a/1X+cs4V8hx6ZcnWUNW90Wd9yW/rmgPKLx7BX/q3vLlJKX5v1IkVe1gg6tvuYybq3KGCn3VzQ4YHvJ3zM/IkSL0DhILpi0RC0P5QSJ5oWgvMm4ORbhqERaIUSZ3snQLsbGgwNt1TGlwmfMVVWtudwd0ugapdp5pygzs666Zi23UvcmKIX+72GQ1qadHKPsMK+A/tIvyFNj4gwZ0AbjCJgdgdghNOWglXZHwY/jPWldpBdb9IFF5jpmgt6RsjmCV2SerMNNUswAtQUqcsHgvrn+xnOhCpDoXKio67yA2I1pLxepQbX9HGt0TZLMOfgZr7VI62lJ6ChrRXNu6wGPzX777LFeOZTPr1dLJUQaWkVVNf2lS3c7oY6Bmo8sSMFqJFUFlEMJMUpLOvSkZabA+D8Eh72i4tq1Y90/WysSkJl9pQVpYd7o/N4RMkqtphPTGi+LGUY1DeedVUA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199018)(54906003)(110136005)(316002)(66946007)(4326008)(8676002)(66476007)(66556008)(64756008)(66446008)(76116006)(8936002)(41300700001)(52536014)(5660300002)(122000001)(38100700002)(86362001)(33656002)(38070700005)(71200400001)(53546011)(9686003)(186003)(26005)(6506007)(55016003)(2906002)(478600001)(7696005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fx7Vsug+FCSp8X8L+WDtcKHYkOyurVSEt9R2EnAMSYR/GAldctoWyetoItgG?=
 =?us-ascii?Q?lZI5PTFEaH4mAVqMlSq7h1XUbj10gT3qHhai5jicFGdDs+fJBZH8tAfvb8wk?=
 =?us-ascii?Q?oDRxYGP5YWyq/rNOLr/RtvxOVbUF+rjyn2I5uWbAKdR7rATX26ole0gwz96j?=
 =?us-ascii?Q?/2q8ml5c44HXSoAg0rsSR/uRsDIfbcL/O6R+rzD8eodLGPuL4gZhteQbliux?=
 =?us-ascii?Q?SZAHtrUZ00V2iM/VSYGmgFPCd7Y0mpUAvFyvf/WhU6w5EVuYzmfQnSkn8mqk?=
 =?us-ascii?Q?aM0EEAoDfeLmXwDw5x5aUAK0R2d8i98xP0AjMs2JWF8rbZdzPBucl8uzn6Z3?=
 =?us-ascii?Q?iQ9eoDqBKN+BAB+MfSxl1kQI5x/oiMkYg7SaLW4hpdCnYDVGrNeY84dLos98?=
 =?us-ascii?Q?rBeX9ct4OFOy55MSUDGIGASzMZ2E0SRUzBR1VrYKqf0pvbfgY6SLrp8YUKIg?=
 =?us-ascii?Q?DN7cl6esGtXbeSMTxpJxmSmk8qhowj1H941cwi1sB3T46Ri/DMu/3DqNxn99?=
 =?us-ascii?Q?Krju45ka60sTtIHAhAKN/Aog26vGudHzCw8802l/F6Q5C2DJij8nnQbr1UN2?=
 =?us-ascii?Q?FffFBtUS8CW9at5ZZvnaq2PDUBYlh1wuF+oTn7yrJuZhoBFC3wE7tdpIjkY4?=
 =?us-ascii?Q?JTFSoXgMS4I5NNGaQEmHRRot2TTOve6U09mxi8FMk3UmHT6gM8kb2Okc7veR?=
 =?us-ascii?Q?zMzm238j0b3SH2GPYvFO5qVBrhJ56zSHbYtdGXLiXw28uhJMKtW3pVxCNeFq?=
 =?us-ascii?Q?PirBju+ynJ8Ud5GE7FiYYRPhN3JPZMksi+2WvUJFmmhgFUf9zJQL55x/WSz2?=
 =?us-ascii?Q?tE+sYMiG45grTprKui6Z02lB5o52xHgCGjwHo6qHaHGbe14FTSgz6Yok2SUQ?=
 =?us-ascii?Q?wVwpBF7D8vWSH6rfBGEN1GjAfSPBKVYFONLmwe+/oY+uqL0ectew8ngbBJBB?=
 =?us-ascii?Q?AL3NjCz1Ys5qALs7c817NBocYmFiVDIPAqEXO6nJi5M/ezAuE1I1bD9So+7q?=
 =?us-ascii?Q?L1Wzb9Jp/pgbVpxhp95TgXkjL88wJeblJO88N/Uv/anIf4n3qduq044e0vXN?=
 =?us-ascii?Q?XWRx3HHQC0wsgQzP0rVumphAVExEwno08gCXXKeln5+RMwurCpy5SsgPeWap?=
 =?us-ascii?Q?KuYsJvwexSLf7uO+zmDhHi/KKKDtaJNmW8tJ+13weUgLgk0K9rQS2HFCTyU+?=
 =?us-ascii?Q?4vDqb60I7eXp5tjM6OHnUTCdMecHk20qdnciwXmGV4jlf3NHIqxh4QKeJxzC?=
 =?us-ascii?Q?eYWbFrEWELXi6LIXm9bir5K7uQsOOYCKU1UnahClhZTLJil06zK85pKZf0k4?=
 =?us-ascii?Q?iNv735RijWzCqES6fnVrtM0CRXyVyr3GPEEfCLvMZYCldgkhjKrrvmtj3yc8?=
 =?us-ascii?Q?qp5Vvg2jsopnFthzud9932Y71S6tI3h0ehtnJg5bq29P6rjgpyXNfM1YPfBn?=
 =?us-ascii?Q?rJZ3SVYIXC++gSrDF9ox6mRGP3HCwyPYDohyLlKXraHPskXNiK3Ag/XYC6YQ?=
 =?us-ascii?Q?MR3EWmihN9VIHXE653ArZ9FDgVrTeP1Bd8m7pAnEnituMLTpgKhM7ig4XI5T?=
 =?us-ascii?Q?uTBz2H89ymyYopIExEc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7e72d7-7c7c-4229-46a3-08db02698b1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 02:27:33.1008 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +KIW1Y6j9O4ngpy8irEyHQUiyp/QMSN0ktpTrdWpBbri5WkxQaFmdEOsgNKQlSkB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5379
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Li" <Li.Ma@amd.com>,
 "Du, Xiaojian" <Xiaojian.Du@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>


-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>=20
Sent: Saturday, January 28, 2023 11:36 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Ma, Li <Li.Ma@amd.com>; L=
imonciello, Mario <Mario.Limonciello@amd.com>; Huang, Tim <Tim.Huang@amd.co=
m>
Subject: [PATCH RESEND] drm/amd/pm: drop unneeded dpm features disablement =
for SMU 13.0.4/11

PMFW will handle the features disablement properly for gpu reset case, driv=
er involvement may cause some unexpected issues.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index ec52830dde24..8bae3fe869cd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1497,6 +1497,20 @@ static int smu_disable_dpms(struct smu_context *smu)
 		}
 	}
=20
+	/*
+	 * For SMU 13.0.4/11, PMFW will handle the features disablement properly
+	 * for gpu reset case. Driver involvement is unnecessary.
+	 */
+	if (amdgpu_in_reset(adev)) {
+		switch (adev->ip_versions[MP1_HWIP][0]) {
+		case IP_VERSION(13, 0, 4):
+		case IP_VERSION(13, 0, 11):
+			return 0;
+		default:
+			break;
+		}
+	}
+
 	/*
 	 * For gpu reset, runpm and hibernation through BACO,
 	 * BACO feature has to be kept enabled.
--
2.25.1
