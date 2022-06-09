Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE959C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jun 2022 11:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5158211A34B;
	Thu,  9 Jun 2022 11:05:53 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD98211A359
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jun 2022 11:05:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geZWnu236Gy7OW6DSYTw131+xfKoSzRPVoTpJKMb4dRsNiDRH9pbQnb34KgBsgyYzT4/n2Q2MXhMWDln5zjLevz3ByWrbbgckSgdgqssyTk/mSNdo3sG7qAMvk/FUpqiqSDl/TzYjZEvsRSfDDgiuIRuFv8/vCEo8gjzq9wfnnyv53bd/NZcLNurTr0qyheDxYj+rKv39ruFfS0R6hahpSB6i7C653/BBUgazHVRt7EAcbL8bqbjJyesXpXWUTRPIOhRDK4D2WNsYKHfz2oKtsjUM0VbteFfdY3IlxSTCP00MsbCo16Huoc54nVZkISFkMWfXGN5Tqn/fPa+LsE0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EC7vxDohCjsMOO2U2XNdam2VP0ZAwwYPw33fuCd5/no=;
 b=efkgEsVetvC5tHSptGTgVDJUhxsi4E0Bg78nZcoSPKkkEDKBxGC41BQrZTIVUXOuSHtxlFB913NUi3Wag7swqLOsbxK7tnXbI2CgO9u+OfZHaKCAlTqmP4g1UJpC1ELztVxfsW9ghzL/Nb98ai3RMG/Lw/1yWqJpr/AnGrOTD3pUlJVsgtl/j1dbtcl/gAmzlxXIyXT4aQmQYBkNvh62b5pp3n8dsgDK9fJN3HXJnO1IubbZh+mGCfQ9yV7GoMbBzjqr9h4lKm8zV9+TEqRrCS5wMjub6TZVExvLSABZ1779pgBRXTskuj/AvIIJ859ZIQPZPsjfQXQyv4kXfFIDHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EC7vxDohCjsMOO2U2XNdam2VP0ZAwwYPw33fuCd5/no=;
 b=qyNdOWjthoplzahDiHpmkbwHbwdc5EPmW4z6hcpgBy2AJnUFK79JaP+DD9SDBfOxSAJBxap8uWgRMu+uBYIxbV2EkUwvHoumtXc0uIcECbu9NRb9cTpY7qN6x36RjxW0nROZfsxkToonPKBi7wlEQo4Fo98mjWiPevJCZ5R1/wc=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by BYAPR12MB4984.namprd12.prod.outlook.com (2603:10b6:a03:105::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 11:05:48 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::5a7:435c:485:6658]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::5a7:435c:485:6658%7]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 11:05:47 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu/pm: correct the firmware flag address for
 SMU IP v13.0.4
Thread-Topic: [PATCH 1/2] drm/amdgpu/pm: correct the firmware flag address for
 SMU IP v13.0.4
Thread-Index: AQHYe7+6LvXnDBMADk2liO5Ol+KN+a1G6erg
Date: Thu, 9 Jun 2022 11:05:47 +0000
Message-ID: <CY5PR12MB63692BF3F5FC10F8CDFFF396C1A79@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20220609051305.3462971-1-tim.huang@amd.com>
In-Reply-To: <20220609051305.3462971-1-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-09T11:04:50Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bf583782-11fc-42fd-a0e6-0ec4c85b09fe;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-09T11:05:45Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 792cac7d-1861-432a-9e95-d7588522bb0e
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4b10028-ba9a-4139-7dc4-08da4a0801f6
x-ms-traffictypediagnostic: BYAPR12MB4984:EE_
x-microsoft-antispam-prvs: <BYAPR12MB4984DE2A1EB6F33ADBC84376C1A79@BYAPR12MB4984.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dumPdiD/UiCVK1tmClOaUJqOSxHQu6r5Ud16vFcJ1XiyE7ONOlW5jhoYKr8dwCbY3JcS5yQ8JXoNmpONc4JVRy05fUkm7niX3QLXoQWPud8tkcNkKBIC/EyS3aYzodtW8NxvCD8OYyVAqnQVFbuRMmvDJqzopUJJ8Tw69tEvvuK7F6qqnoXejrCJW+WcHKY4Lj+Kx9sPiqrYiX0yYO0NOC2FyqcdSQPQVtkiUkgVIk/LRrLaQ0MxRDE3lass5aFwddNoRriFmRkl5y1l5YLda34I6gL+kh0CEkLdrdDcyYIts4YATJNS1Sfv1JzPSfVlpff2OaolkIzScjqK6IqYGIoLVWU9HYDMCsSBWSGdOonJlFy8rUkSJVMdmf1Q16kgvTxt19ZY2E8zMqxOUVNChtAFKqiNoskJ4D5HqNcOz27/rdkAlUIy665d0L0mBjE/5QtwZSQfqZ8wQBLRj1Q66/ey5awpXHi/d1LiBguUok86B8URTCj6fg53kec74B6fPv0ZyjITWB18kGC8aOKUE/4NgSAQLVp0dBE4cE5SJStVn6q0iqaUR1w27mAJcyC5wC9Yr7ZhiqBjKXdWVPTUI0RaJM6J0EBqXe4zg04dLaAGGJoldlT4XuatxDRjv7cZotcOGgxcbzzp2QPkafE9Bden6YC5lGHfws41f6+a/1+LwVdGTPei/VZK1modMu73gmOWH4aAu020EuPv/Zh0iA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(5660300002)(38100700002)(66946007)(76116006)(66476007)(66556008)(55016003)(64756008)(4326008)(8676002)(66446008)(38070700005)(316002)(110136005)(33656002)(6506007)(26005)(71200400001)(9686003)(86362001)(186003)(83380400001)(8936002)(52536014)(53546011)(508600001)(2906002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qhVfO/1J7T4uHwig2h9obLB7dRSdPHg6rdNDG7Z6jJjEMXu89fttccesHJbF?=
 =?us-ascii?Q?q1l15QTEAKGYecxhyXxGfQtRkZrHG2+uZUHuPvIKEUizcQKYvMS/9YHMoiyc?=
 =?us-ascii?Q?c9Rz6A9GaTCqZLe/GSQRWZ6XxxH6erpF/m5CBXEXd2jXn4PZr5ReAmQkxBSH?=
 =?us-ascii?Q?F44KkckdNZpXvFVTF6Uau3mQOePzT9c2vWpAogmv41hQZVQEizDt9d7YK+ws?=
 =?us-ascii?Q?13JGIcyoFgZPynLJPXGcv4wj7uv1tlil9kB5iL8HzxZFxmFTKWWsP9euauwz?=
 =?us-ascii?Q?kbXvDMyDHRTyq53GX6U5D5iJN1GUgEJtWVt3ZivzZ7Ou4j+BvF7frY2iQJ5S?=
 =?us-ascii?Q?KuUpeXbBcjQ/6F9BaECz5B2gZpBdYDCTG/SxQh44f57hMWvtOe3dVqOvOX1U?=
 =?us-ascii?Q?V4lt1akZp6icYW/VCbCUq3H0m8ZwehCbyogNv9fC9VRNFifIgSXExpHrrNRw?=
 =?us-ascii?Q?KpZRP5jugMJI9p7aDQhx1bwnMNLpIpEXCNrJIgM0Fgm82pmULhYi7GIT6i7b?=
 =?us-ascii?Q?pxBqouc7kbb2b/YrGPZVyAN7sYKTLymP+VItR4L49w36/iT1zI+C09FK5IoV?=
 =?us-ascii?Q?Gmiwa4kzMXRv/ichvYrRp2F/sShIDJr8OPsQXCeRxP/4kIgiMox6M1kqEOiJ?=
 =?us-ascii?Q?+KQ5xfxnFfVEHagJQhJ9SguSdRM5Bt9k8WeDXAAFEF4cvP9ykfc+QFOUF+Pj?=
 =?us-ascii?Q?540bRPBKizMw6TtBgRBo4XiPm4uhtWIzQUQ+ELFxSH8ymUq1IcNahRQjV6rz?=
 =?us-ascii?Q?attxTVoIx5AHt9vYUQlpQ4sQ/VN4sP/6KxkhmJeYl1hfJG7Ej5bQBejTin4R?=
 =?us-ascii?Q?ugdt9jJXb27h+btjYVWqefkt+5kkPgN6w/Kbb0G+8/u9DrlMlgPAiU2MRuT7?=
 =?us-ascii?Q?/Ad57isi6a96tQOHAPS2Yj2Mq11mr91I8M9gPKEBc9t6f5w0pfDleXy8JPxR?=
 =?us-ascii?Q?wgTNQ3B0/CueQ2HubvSE5FB2Gs2KdnG6Qvlgsf3WqRP82IqSF0K9GM+ziPd4?=
 =?us-ascii?Q?MGuiRxy4wYBiYLDcoQizll3gvTF8mtsKB0CTs7lrYO3DYkKzHdKhrYL/C0s1?=
 =?us-ascii?Q?0p8qPDhVpk+TrpJfLPGbtExLkhftr7SJd45X103nY74Xh+O+XIcpQL2+8Mji?=
 =?us-ascii?Q?Zsg0hJe2Yg1lj1r46IvfWaD7PrUmUdjdO9OlU7Rg5olOfEgaiTv187jOt2qO?=
 =?us-ascii?Q?gH8K1Yq0UnkxxWlUeJ1VCSWStaH5LeIud0kN+6u0PovI+tFP7JWGniOV7+RB?=
 =?us-ascii?Q?I363E+xqiV/f/q5pTiycuc5/B//Oquxgq/jw3glYXVzj81j3I+iMtUGVJZWq?=
 =?us-ascii?Q?CMX2mN5w2mQdanlh/InlE0IZ0oBdjKQBOBiyqcinZQ6c15T2Q3zBzi5W4d2u?=
 =?us-ascii?Q?FAlKY7MCNLT8z0QamxeK1LLsHuio7AaUETSVNnTyI62aOkf9OMGLK86OTE6q?=
 =?us-ascii?Q?mwVz3SIbJCtKsNiBXwNolj8dFMNjh0U2NV8euds3HjYNtP6LvAaNWWyiD67e?=
 =?us-ascii?Q?ldoBoM+EAkYMo+wj5y4dTnPH3ojNsiA0GjphZicwMNTfHkyA3aAraIr5GKqx?=
 =?us-ascii?Q?x9fL5LttRS/lSq4wj/L52k186/n8xaiVGJRfA5l7wwuYPISkqxqWQwyUX9pq?=
 =?us-ascii?Q?zGuKRPQglU+A6NWkDTQRBuuk0UrhrnUSrN1xf4YI5as7pXz14JgN19b21kRC?=
 =?us-ascii?Q?FYKV1BapdanoYzAOSzOSt/zObwuswIs72nBCeFTKLZ2v6JFs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b10028-ba9a-4139-7dc4-08da4a0801f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 11:05:47.9158 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OrlxYDJeMTqgangFFBuPPaVO6NSm/yE1Scr1Oc1nmT3eiYB6VxT1N+lrjV9/zL2M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4984
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

This series is :
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>=20
Sent: Thursday, June 9, 2022 1:13 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@am=
d.com>
Subject: [PATCH 1/2] drm/amdgpu/pm: correct the firmware flag address for S=
MU IP v13.0.4

For SMU IP v13.0.4, the smnMP1_FIRMWARE_FLAGS address is different, we need=
 this to correct the reading address.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h   |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm=
/amd/pm/swsmu/inc/smu_v13_0.h
index e3454a876cac..43de0a8d4bd9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -43,6 +43,7 @@
=20
 /* address block */
 #define smnMP1_FIRMWARE_FLAGS		0x3010024
+#define smnMP1_V13_0_4_FIRMWARE_FLAGS	0x3010028
 #define smnMP0_FW_INTF			0x30101c0
 #define smnMP1_PUB_CTRL			0x3010b14
=20
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index f9c36d294448..fba0b87d01fb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -273,8 +273,16 @@ int smu_v13_0_check_fw_status(struct smu_context *smu)
 	struct amdgpu_device *adev =3D smu->adev;
 	uint32_t mp1_fw_flags;
=20
-	mp1_fw_flags =3D RREG32_PCIE(MP1_Public |
-				   (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
+	switch (adev->ip_versions[MP1_HWIP][0]) {
+	case IP_VERSION(13, 0, 4):
+		mp1_fw_flags =3D RREG32_PCIE(MP1_Public |
+					   (smnMP1_V13_0_4_FIRMWARE_FLAGS & 0xffffffff));
+		break;
+	default:
+		mp1_fw_flags =3D RREG32_PCIE(MP1_Public |
+					   (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
+		break;
+	}
=20
 	if ((mp1_fw_flags & MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) >>
 	    MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED__SHIFT)
--
2.25.1
