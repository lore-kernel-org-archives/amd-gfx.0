Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB999C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Mar 2022 17:25:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FC9E10E17C;
	Thu, 24 Mar 2022 17:25:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C742110E01F
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 17:25:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pi9oR5MCi8kh6DjeHHgKFkr8MYbitjrsbh2+75QRGoxB9DsAg/n/vHYL1rgq6ooTFTAj4KA2WEqRYJX4GN/8x6Msz80SFKty586wTgGrQT6NCCRkC3XKrX2yZ+my8Hw4/2+neTur0Ua3nXy7ZIyy4/TxcawTH5yZIZ4w98jl2n4fgVF/S37TqeF1S6yAxVT0IJMP8vVQw7au80iuHnOvDwOjMdhZJowWfO/leNlxJxH1ndip01K8aOYuuOjwo9cfeiDo3Gesr4EhZpvMdHtC9MyYUIQUkoJ0m9kLQvhrM/E0ueJjNroeDEKTHA7xHUR7tlDhkTKpZGAKwazgkVxx2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0dZFvY5WhEiVpTgux4oZk78cj4cVG4/4tPK4oesq7Q=;
 b=Jr92xGv7h+Tgq65rHkhJpWY7jYm2cvvad2vBZGutGwfhGdubY6Tj38di4/mku2Q1UhU/fP2BW54+3XS8fVuoZOJumxDGuaWQFDR92v/OQ9ZpEO+Djz9+12LiuV6x1XuwhaQ26hWi/+E4nIFJQG7k0t8abPNA2l3Ohw4pNHqBwAye9IsDOyk9xBIIbMGrHwWhJhcOLxOyp7GHVCCANKAX1exgZxvBRsTHLQ9ypZlhoVsQDoZsNLFzioJLeeO+lDdzZ0hj1tYoYJ9dZzn38Lx+7cd93JnbvDXFdOwuifhW5cwHuAnMb07r6Tcll6mWgsYC5rqA6muSSQ+erTBiJVoJdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0dZFvY5WhEiVpTgux4oZk78cj4cVG4/4tPK4oesq7Q=;
 b=UcJiroUydBo3VpDlRzGHq3nbsMQFofKIod9gjuQ0UDjiGhOO0Y8LFxDB0jn8AlhN8xyw9XfqzuJlb/gRDXBZvsLnstdicYQanGekLTpHkp2XehebqqCBcFMwY0Dar6ulC+JYZt/RSdibE7gvTxz8hlRLC4dtgwZWdHSy9ONkTlw=
Received: from DM6PR12MB4843.namprd12.prod.outlook.com (2603:10b6:5:1d1::16)
 by DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Thu, 24 Mar
 2022 17:25:25 +0000
Received: from DM6PR12MB4843.namprd12.prod.outlook.com
 ([fe80::e1be:20a2:8b06:2366]) by DM6PR12MB4843.namprd12.prod.outlook.com
 ([fe80::e1be:20a2:8b06:2366%5]) with mapi id 15.20.5081.023; Thu, 24 Mar 2022
 17:25:24 +0000
From: "Zhang, Boyuan" <Boyuan.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2] drm/amdgpu/vcn3: send smu interface type
Thread-Topic: [PATCH V2] drm/amdgpu/vcn3: send smu interface type
Thread-Index: Adg/opkFnx88RrSfRM6GR+M7HG+yjg==
Date: Thu, 24 Mar 2022 17:25:24 +0000
Message-ID: <DM6PR12MB4843192241F9620519190F0487199@DM6PR12MB4843.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=4799333a-87ef-41ff-a310-006ac5b969a4;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-24T17:09:45Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-bromium-msgid: 9cb6d408-38fa-4359-a962-3b197b33394c
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a3503b3-9de5-4c00-ea4a-08da0dbb4850
x-ms-traffictypediagnostic: DS7PR12MB5888:EE_
x-microsoft-antispam-prvs: <DS7PR12MB5888C44A27C832B830093AEE87199@DS7PR12MB5888.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 77dCW/P+In3Z6O83d8dh185eH+WWjEa6b2XZfqf9xF2ChfPccO39NDgWfKucxTDyXpajOc6A1GVjj1Z07fVexqe7PBHUWGDka+f4Jqp68+LywkaRui3T7CO3LT1u5VYAyzhWF62IRDyX+bt4uZ0RpA/VgQd/CjKjx2jDVkLUN7vc8VWUUC3ikN4rx3UrPTYNfJh1HKAQWrqpKEJBxU0WPuuouX64U7NFZbTdo7rjwSHIFGcqI5zcPqOzregCAGkODFi+xIV10mw/at6hOj9nnudniKYezr3Wr2nW4NW7zs59+JtnlsCTODJblO1PG5NjCcS0qJYlsqd0b4HmZthWr2WxYc/OSZION4j4RsZpPmK9Em7MYqP1v/gFPT+nEHM/nL0NewrPeUZqnMdogvToYT7/nYx+BmZ5RQrK16atR8wTv+qIerYp/1VinP1OJZGmXk0473EIeozxgwDRpQpM0t5LQG18ZtZnay26WwJMQiuLdbN2891ebAENUuoatdHWw8YmaNWq/O2xGY01/F7o8FlBfjpodI7UEAZrraLzXa/jdzcvsNy/8p52PWCfEenO/WYp9PQoIBNhvM2N7Z/DY2EdteTdpDujnR3vUX3YPd1x+MyPfkCfITToBu06uv8D+Ov9sEs8dZO3QsaLzHBPEJ6fAJgsZ55D3ocfLhWA6YQlZBsTGkZbS32FL7Pp9GRa1VnqSxRnfcwU7xsIvJrXOA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4843.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(8676002)(38070700005)(5660300002)(86362001)(52536014)(54906003)(6916009)(83380400001)(316002)(71200400001)(7696005)(6506007)(66946007)(4326008)(66446008)(76116006)(66556008)(66476007)(64756008)(8936002)(186003)(26005)(38100700002)(33656002)(508600001)(9686003)(2906002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wHcRTAc8VT93+Tbqp96yl61rfrMuRJUZ8P/qcQQhwieI9jtUZeIYF2N908Yz?=
 =?us-ascii?Q?prwCAfW8jZNEKLVSrPtmRwKTdcN8zl2mR7uGNX3yERGhaFr749x56sOcLcFX?=
 =?us-ascii?Q?q+fL1mJxFAZEOx84kZ6cqqrtOuuvSr3PnyYaS+SIZv5gyPG4Jf8PWHu5eoZ7?=
 =?us-ascii?Q?jUG1imEObx3fG/beUTm0Yb1Tdj0jcDZa4LAYTjQl1NekYgSNaXB0oBZKFLFH?=
 =?us-ascii?Q?snGSGNujW7BwSFMqhDBkJkSHQPDs78RFN3Xm+CnFgm73wl5MIAUCFQPrce9t?=
 =?us-ascii?Q?f7wf5j16Qu6OhBRNXX2gf3N4S9kSRErTVOhbcmJlo9jMyaIsGv4jrz3TLiks?=
 =?us-ascii?Q?o5Ww/IAk35X3o78Bn8W4RTAC4Yc+DKFvG6xRkzpDf+fpbR8qjJwUvVKtGLAr?=
 =?us-ascii?Q?ysaOZgR4fbBpOqSckeu5BRI/S5K+yr1aP2jC+yB9iIjyCN+mx6GgB5I8g6nZ?=
 =?us-ascii?Q?yO4oLGkMCmWvfSI+YeWTP4vPPKcSvewxe051eJeerJIKHCab5Ftrpu8qor0S?=
 =?us-ascii?Q?l2K3niMwuV3OBtEYHAcJxeHXON+Bv/amc5EDrNUj0KIYbPeBk8e103yFbyv1?=
 =?us-ascii?Q?m92sB9TLM9oowUvMZZSEsvfepTGkBf2mNJ3+vrTB6p3TacCg4Be7ZFDECcK2?=
 =?us-ascii?Q?kqyysSsrQoLQiq+zgB9LHQkYJn/QrBrrvwHsh4K52eYzbpEgOSQCkFx0TaKz?=
 =?us-ascii?Q?8FcTA4pPREveMZzWp0RUmwHM7hDOF6ymwOVyR3cHqMge8Ri9zEQSlmafXI7P?=
 =?us-ascii?Q?ktYfqRiujB76EMfB5Enzk32mq4uc822PWqwWyV37FQR5OxoHDm1SiP+NAZUD?=
 =?us-ascii?Q?fzjOlvUVynDsmX1uBpMyAzJl3ODWuPh0ybaF/Kw1LWhgSqj260UQw5EsAJl7?=
 =?us-ascii?Q?1HqbRI24lRQX4tRRkeFbK7ewACij5QvlvqhnSUOuXCsoRBzZtEhruHzr6jzS?=
 =?us-ascii?Q?y6HtA6FCvtz1E32il2mpSH8B8TvP+2fPiXktsuiiMaZQtRVMwHHkjrtzfraf?=
 =?us-ascii?Q?WtlumRA/fw5m4NQkVx705s1UJQlIcPwjvUbEFiGkOXlJdJ5bza1XRyUKFsT5?=
 =?us-ascii?Q?aI0991wPbbuR60mCjbYR+OgBIDcpI/yS+Cs12xJu+ec8ugePUdVmEkBgtk43?=
 =?us-ascii?Q?ECo2JUn2X7MCnikVt4ZwHaGg5ntF00HdqECMFbl2RsavmueouLVSaf947kVk?=
 =?us-ascii?Q?0wuZQ2mGgYY/u/3AoDVkafUUUpdVHr0eswK+ZQHSeld6N4OSzihs2vm1KNAp?=
 =?us-ascii?Q?Huixvame5aNNjLuoHb/2qgUtNHdmtLhDWjrjIsEYbPxmXplfXBHirM83xVzx?=
 =?us-ascii?Q?sxOuxVz0wcaCeBx83geoStPkNsnqvcyoxuVNwkIYdlsRogteZkhUsg9RoQG/?=
 =?us-ascii?Q?o3tQVpMmqYB/NE5QD4ugfOTH7k0VOOR+Qg7oAqvFlccBnvwBrxpC58IBxHpP?=
 =?us-ascii?Q?u4sDM8twuSO43HHK3V0jvMFYEQvSVwt6?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB4843192241F9620519190F0487199DM6PR12MB4843namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3503b3-9de5-4c00-ea4a-08da0dbb4850
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 17:25:24.8404 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3MTSRmab6kCXH7H0XkCTRMd6MRWk23tauk7Tq38/DBH+8lFs31WveccpJVCF0DtNR/zCq1Sdff/0Dqx26sQ7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888
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
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "Zhang, 
 Boyuan" <Boyuan.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB4843192241F9620519190F0487199DM6PR12MB4843namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

From: Boyuan Zhang <boyuan.zhang@amd.com<mailto:boyuan.zhang@amd.com>>

For VCN FW to detect ASIC type, in order to use different mailbox registers=
.

V2: simplify codes and fix format issue.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com<mailto:boyuan.zhang@amd.c=
om>>
Acked-by Huang Rui <ray.huang@amd.com>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 7 +++++++
drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 5 +++++
2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.h
index e2fde88aaf5e..f06fb7f882e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -159,6 +159,7 @@
#define AMDGPU_VCN_MULTI_QUEUE_FLAG   (1 << 8)
#define AMDGPU_VCN_SW_RING_FLAG                              (1 << 9)
#define AMDGPU_VCN_FW_LOGGING_FLAG     (1 << 10)
+#define AMDGPU_VCN_SMU_VERSION_INFO_FLAG (1 << 11)
 #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER        0x00000001
#define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER                         0x00000001
@@ -279,6 +280,11 @@ struct amdgpu_fw_shared_fw_logging {
               uint32_t size;
};
+struct amdgpu_fw_shared_smu_interface_info {
+             uint8_t smu_interface_type;
+             uint8_t padding[3];
+};
+
struct amdgpu_fw_shared {
               uint32_t present_flag_0;
               uint8_t pad[44];
@@ -287,6 +293,7 @@ struct amdgpu_fw_shared {
               struct amdgpu_fw_shared_multi_queue multi_queue;
               struct amdgpu_fw_shared_sw_ring sw_ring;
               struct amdgpu_fw_shared_fw_logging fw_log;
+             struct amdgpu_fw_shared_smu_interface_info smu_interface_info=
;
};
 struct amdgpu_vcn_fwlog {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c
index b16c56aa2d22..9925b2bc63b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -219,6 +219,11 @@ static int vcn_v3_0_sw_init(void *handle)
                                                                           =
         cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG) |
                                                                           =
         cpu_to_le32(AMDGPU_VCN_FW_SHARED_FLAG_0_RB);
                               fw_shared->sw_ring.is_enabled =3D cpu_to_le3=
2(DEC_SW_RING_ENABLED);
+                             fw_shared->present_flag_0 |=3D AMDGPU_VCN_SMU=
_VERSION_INFO_FLAG;
+                             if (adev->ip_versions[UVD_HWIP][0] =3D=3D IP_=
VERSION(3, 1, 2))
+                                             fw_shared->smu_interface_info=
.smu_interface_type =3D 2;
+                             else if (adev->ip_versions[UVD_HWIP][0] =3D=
=3D IP_VERSION(3, 1, 1))
+                                             fw_shared->smu_interface_info=
.smu_interface_type =3D 1;
                                if (amdgpu_vcnfw_log)
                                               amdgpu_vcn_fwlog_init(&adev-=
>vcn.inst[i]);
--
2.25.1



--_000_DM6PR12MB4843192241F9620519190F0487199DM6PR12MB4843namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-CA" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal" style=3D"text-autospace:none">From: Boyuan Zhang &lt=
;<a href=3D"mailto:boyuan.zhang@amd.com"><span style=3D"color:windowtext;te=
xt-decoration:none">boyuan.zhang@amd.com</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">For VCN FW to detect A=
SIC type, in order to use different mailbox registers.<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">V2: simplify codes and=
 fix format issue.<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">Signed-off-by: Boyuan =
Zhang &lt;<a href=3D"mailto:boyuan.zhang@amd.com"><span style=3D"color:wind=
owtext;text-decoration:none">boyuan.zhang@amd.com</span></a>&gt;<o:p></o:p>=
</p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">Acked-by Huang Rui &lt=
;ray.huang@amd.com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">---<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">drivers/gpu/drm/amd/am=
dgpu/amdgpu_vcn.h | 7 +++++++<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c&nbsp;&nbsp; | 5 +++++<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">2 files changed, 12 in=
sertions(+)<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">diff --git a/drivers/g=
pu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<o:=
p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">index e2fde88aaf5e..f0=
6fb7f882e2 100644<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">--- a/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vcn.h<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">+++ b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vcn.h<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">@@ -159,6 +159,7 @@<o:=
p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">#define AMDGPU_VCN_MUL=
TI_QUEUE_FLAG&nbsp;&nbsp; (1 &lt;&lt; 8)<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">#define AMDGPU_VCN_SW_=
RING_FLAG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 9)<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">#define AMDGPU_VCN_FW_=
LOGGING_FLAG&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 10)<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">+#define AMDGPU_VCN_SM=
U_VERSION_INFO_FLAG (1 &lt;&lt; 11)<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">&nbsp;#define AMDGPU_V=
CN_IB_FLAG_DECODE_BUFFER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000000=
01<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">#define AMDGPU_VCN_CMD=
_FLAG_MSG_BUFFER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0x00000001<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">@@ -279,6 +280,11 @@ s=
truct amdgpu_fw_shared_fw_logging {<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t siz=
e;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">};<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">+struct amdgpu_fw_shar=
ed_smu_interface_info {<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">+&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t smu_interface_t=
ype;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">+&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t padding[3];<o:p=
></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">+};<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">+<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">struct amdgpu_fw_share=
d {<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pre=
sent_flag_0;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t pad[=
44];<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">@@ -287,6 +293,7 @@ st=
ruct amdgpu_fw_shared {<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgp=
u_fw_shared_multi_queue multi_queue;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgp=
u_fw_shared_sw_ring sw_ring;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgp=
u_fw_shared_fw_logging fw_log;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">+&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_fw_shared=
_smu_interface_info smu_interface_info;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">};<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">&nbsp;struct amdgpu_vc=
n_fwlog {<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">diff --git a/drivers/g=
pu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<o:p></=
o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">index b16c56aa2d22..99=
25b2bc63b9 100644<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">--- a/drivers/gpu/drm/=
amd/amdgpu/vcn_v3_0.c<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">+++ b/drivers/gpu/drm/=
amd/amdgpu/vcn_v3_0.c<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">@@ -219,6 +219,11 @@ s=
tatic int vcn_v3_0_sw_init(void *handle)<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG) |<o:p><=
/o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;cpu_to_le32(AMDGPU_VCN_FW_SHARED_FLAG_0_RB);<o:p=
></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; fw_shared-&gt;sw_ring.is_enabled =3D cpu_to_le32(DEC_SW_RING_ENABL=
ED);<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">+&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw=
_shared-&gt;present_flag_0 |=3D AMDGPU_VCN_SMU_VERSION_INFO_FLAG;<o:p></o:p=
></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">+&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (adev-&gt;ip_versions[UVD_HWIP][0] =3D=3D IP_VERSION(3, 1, 2))<o:p></o:p><=
/p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">+&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; fw_shared-&gt;smu_interface_info.smu_interface_type =3D =
2;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">+&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; el=
se if (adev-&gt;ip_versions[UVD_HWIP][0] =3D=3D IP_VERSION(3, 1, 1))<o:p></=
o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">+&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; fw_shared-&gt;smu_interface_info.smu_interface_type =3D =
1;<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (amdgpu_vcnfw_log)<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vcn_fwlog_init(&amp;adev-&gt;vcn.inst[=
i]);<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">-- <o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none">2.25.1<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB4843192241F9620519190F0487199DM6PR12MB4843namp_--
