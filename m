Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF30C47077
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 02:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36AB910E55D;
	Wed, 10 Jan 2024 02:59:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C56410E55D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 02:59:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D685x2JQuO4syPyUceeKyTIUuFA8tF9y2gwR+/Md6KZNH4Tc0HsyiIKwNWaNMm1ywB2u2zAFtupwuyVrK9qXlyHC8C636W5LXHJSnyfNAMVJRtPjihln8HHe+3FFymWbJwn+nnvxgXHLeVoZEBv1Auz4dSBmmgWoVPAR2pyAwuab9AR6PTs1C0u2rjcuEIcMZIRvF8MsrUTKF8FrYPANMWqufQN/Q0ieQEr/jZe7bf5FGqeY39bLvQ61BimNJqAbwJOyHK0Ko5hn7pb77zcb7f8BKqPQh2DWgx6q5OlgcsIgjWZVLB93AvM+8F8CvSRA+B5RqBxRibPBycYqWzmKJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+ViLpEll9dP6MQQPtVVgTExN1jpzSII63T6o2mdC9k=;
 b=JELhiM4VqUXcCUdf0kctYSSQKdA1fqSggiu9sT1m8ZgmEGLYOW0Efa1u+aP8hwYXZOICfENHeizb9ENPHwIiKW2RMMhmT/VDFE1BvtD9IPhx82wlqW4om+8mxFFMQB3z3gmSomGdfMbqH2IfDOK0tOeOWkL2DNgGNNdVnAveJwGe1/zhqnzLviflPAD2HcgAdDfEDIbiSh4rblNTPkIDzREV5FgA34xOkccp1VOMcQNo9ZpBqm63LzHOFjSRYISDfww+lHLktgAgmGN91I7kJrKy6cXsJ9xkCB0uAmxlBk1SfNngiP5Qvzb1M6e7I4cN3iQwJrfDb12e6v6YTeQyNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+ViLpEll9dP6MQQPtVVgTExN1jpzSII63T6o2mdC9k=;
 b=cxaxwKWg+Teh8L3nFtyGqgUSt2gKvgPP3k79V0QwJjjSgGCWMiBSBxyr2q8NMTKbLDADXY07Cs3hgVJT743EGhMzZiOdOQSQIJT6u/DCSm40LKeYGU1CEYFTvOjgxr04fkgpB7DEMVzqyT5/xd9GeZE6mEA2oIrOW7mr4cn5e1c=
Received: from MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5)
 by BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 02:59:12 +0000
Received: from MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::a62:6417:ec34:a0f3]) by MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::a62:6417:ec34:a0f3%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 02:59:12 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Enable smu v13_0_6 eccinfo in firmware query
 mode
Thread-Topic: [PATCH] drm/amd/pm: Enable smu v13_0_6 eccinfo in firmware query
 mode
Thread-Index: AQHaQ2yIy8lgSfW+k0qq/xLk18XUC7DSV+GAgAAC66A=
Date: Wed, 10 Jan 2024 02:59:12 +0000
Message-ID: <MW4PR12MB6875A02B0CA6BF331AC58D5691692@MW4PR12MB6875.namprd12.prod.outlook.com>
References: <20240110022626.374753-1-candice.li@amd.com>
 <BN9PR12MB52577422F8652ADA6CF0D534FC692@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52577422F8652ADA6CF0D534FC692@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=877488a2-50cd-41eb-b7ce-515704b4867a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-10T02:45:10Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6875:EE_|BL1PR12MB5144:EE_
x-ms-office365-filtering-correlation-id: c2fb4187-748e-4007-6778-08dc11881fd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IFLvQIor5z5BHiIGkyESGXWGqcq0BeiUYaJHfuUGubAXfUQ5h2oUgGzTQZJq2IJz3o98/21lllk4n7HwLi9edGFreVU3jvzfC4yWqeFfZBdbZ2uO27HE78yRCri+5SPo9LJLGVHcZmIa55u9unrFR0e7U9BDeRWw9kyjbAgjWGsAmuIPBHeAi3UgMkuAR/jjzJqBDUogc4jxdEPdmNgJxybeiSUeRHH4/8/MmRnC5n1ocMLBkCUKmK/Gw7eVQ4ltwC2SNWNXzsSwIB1C64kKf6OPYZwyt0qTqarGEkMbabNRCQvOtXGwl1pIpyesmuyYAkiah7iq3KY+33n2+S4ke1+qkdN5J2lJ8F0dAkGQG4+1iZDmAB/qL6JHusdzSFCOy6LmKzPG1LvZOUxk/gx3gp0ynhxV1Cjvjg8w9f840sXbK/XpJwtBRKp5FI20uEAbiCJXFWqPLkr2630r2pCrO/0/rI2Qd+o0Yf2KhyFQivyueqHrbEKgSjLxc2xnBaMmIRWd1gLam54E7k5utwM/vPUmA0YX2BFlTCrrW1I5MJja1dFezKxLV+lerpvdi48wr3b0dkYiVKr4TOv0wKyWRmqIkU4UcdfwV+t1/iJm2fIscYvw1rPSQ+Cy6EuD0Z+p
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6875.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(26005)(9686003)(7696005)(122000001)(71200400001)(5660300002)(52536014)(41300700001)(2906002)(478600001)(53546011)(66446008)(316002)(8676002)(66476007)(110136005)(64756008)(8936002)(76116006)(66556008)(66946007)(86362001)(33656002)(38070700009)(38100700002)(6506007)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UTDFlOYBdI8gCdJKIkJ6TeEBxcY7VHutVCN17An34a6bFu6qp6eJHZeQDXpo?=
 =?us-ascii?Q?byX/JkNuUP3QnZX7uw/wlDJ7lOKja58M9wajYuUeS9/bR8DQhchMl1Er3u4P?=
 =?us-ascii?Q?vGGghxJt+OnvYUx+n9ILMNKD0M1LJ0YuYTFBXIiT6FX5wErG/NEg84fb2DpI?=
 =?us-ascii?Q?S8MzENdXOzQqRZ3EDhyF/CHE1DQhKimFGhGNCLJ3ntUmVyJkSbmrSsrWyG/1?=
 =?us-ascii?Q?XIIT/wxR8jSZkoryh0hpBwV/uEoH9o9RYxTDZPqBanjE/BftC/VsRlnGtBEw?=
 =?us-ascii?Q?oPDzK+Olp/hgEZKK8ZX6dNzoIPQ/9ucl7T83DmEGm4wqrmTKhn8ErmVqzeMy?=
 =?us-ascii?Q?7yEhaePG3fgY5p8IEGI0kxUk8AFRfJ7JR6LwuSDgt3F+1eqEnl+JK+ptbhEf?=
 =?us-ascii?Q?FPjkDRBzlp7SbAgQW/Llf2XYD34hVUGXBZV18nvhdBF98Y51nu8Ljf9pQ67B?=
 =?us-ascii?Q?swq+YcHDqrt3viLOOm/59eSGgO4C4vjKDEp9WKcxX8qDX4oCt65FdqdeWZbl?=
 =?us-ascii?Q?paVZU4mfCH7JPldxCCSxNwMt8HTjb8QFPnNOxrllivud7emtXMR+zP5D9Psq?=
 =?us-ascii?Q?ZGRNkxQfsVSdGMmUBLoUz8WLrJPRQCXFoUoGdVBDIls3SnhhqarBckhd+/EO?=
 =?us-ascii?Q?oSse4eQFBly0ts7jH4aQiQUQj3TaDGu1ZaherwYXEEBJuIzXuv3tXcvtSUQf?=
 =?us-ascii?Q?w+eB0gRYfXFj27QLz/I1BlmSJ6XeqVyrQhaOUYcUYTCUesosQLD6g92tcx1P?=
 =?us-ascii?Q?2XoQjm4o3XvTJaWuA3rwBNd0GQYTKacG4opDYgE6Wqicc4RB8COIg/q4/5La?=
 =?us-ascii?Q?OhFh5+Mb3g9ZHQCn60U04RPI+BSmhvya0d1ZAr0qMliViAxU/HiYzHvjgAdV?=
 =?us-ascii?Q?FWgTUHKEt4IvmRGQ8UBJfpG9D4otuLoYiB7qXHfxl7RFgToSyRgSyB7JhN+n?=
 =?us-ascii?Q?aOC4/e4a7SjZcH1sCRCDONGiSDzT0wagJQ/xe23bOiqXaTC8aAbwwfTJ4ep4?=
 =?us-ascii?Q?n6UTcl4uxMVQ70dX8XFRchT3J1TYpCpU8JJAT4saflT1bRDY0c1nA1dTZdz6?=
 =?us-ascii?Q?pk0KvwmnPVZs6xU+qLdZ12FQCg3AMSGtxZcpWeZJU0sWXzP4+JxlvpJm5aBP?=
 =?us-ascii?Q?JdK7d/CWLitXS/JUkecx/Of6seiPQUi+zlp2E4iN+8ZqgBtsuwmtN7bc+dfL?=
 =?us-ascii?Q?HOrE/k7jGRFu3coheKs6lTxaSbn4j6ctjaarSo8FYaCU5a8jfiAm4lojc85P?=
 =?us-ascii?Q?jhgWiPXktA6S45jIo0XIPe0PwBG2Fl4XCgzNvK2oxbGwN1KP6rphG2tqdMlD?=
 =?us-ascii?Q?g/RDiVlhZMLPUeCFFBCxvUdFYTBeVXKS8qt2IrNlwJsdF/gAJYFunaGHQd10?=
 =?us-ascii?Q?YmcfjytDxQdB7ahnqTmICYfeV1ycrfZunvBqv0+zTbTpsJPcAZG53aKyTu9U?=
 =?us-ascii?Q?bd4M82Y9HR9plrokywWDe7DrgUroi2g9/GCGpR7oEvxqT5kefRBPHXm1j+aZ?=
 =?us-ascii?Q?YZBsTap72CrD2z6J0kyYNipO6Sj0oE81Niq+QKHcCtdWaC+CH0uhZoIztiLC?=
 =?us-ascii?Q?mzjqUFS9vm5twgJtaUg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6875.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fb4187-748e-4007-6778-08dc11881fd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 02:59:12.6366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XMhs0FZCqYk6MbSInYEIV+Py828wFH2IHXPW9PMExXe4rhIb9f30JFoeFPliDq2i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5144
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

I agree.



Thanks,
Candice

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Wednesday, January 10, 2024 10:48 AM
To: Li, Candice <Candice.Li@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Enable smu v13_0_6 eccinfo in firmware que=
ry mode

[AMD Official Use Only - General]

Let' s see if we can retire the get_ecc_info callback since from smu_v13. (=
i.e., do not provide the callback implementation). What we just need to ens=
ure the driver can fallback to direct poll mode when aca debug mode is enab=
led, this applies to both error query and bad page retirement.

Thoughts?

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Wednesday, January 10, 2024 10:26
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amd/pm: Enable smu v13_0_6 eccinfo in firmware query m=
ode

smu v13_0_6 eccinfo is supported in firmware query mode only.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 4ebc6b421c2cb4..29396424a99609 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2896,8 +2896,11 @@ static int smu_v13_0_6_select_xgmi_plpd_policy(struc=
t smu_context *smu,  static ssize_t smu_v13_0_6_get_ecc_info(struct smu_con=
text *smu,
                        void *table)
 {
-       /* Support ecc info by default */
-       return 0;
+       struct amdgpu_device *adev =3D smu->adev;
+       unsigned int error_query_mode;
+
+       return (amdgpu_ras_get_error_query_mode(adev, &error_query_mode) &&
+               error_query_mode =3D=3D AMDGPU_RAS_FIRMWARE_ERROR_QUERY) ? =
0 :
+-EOPNOTSUPP;
 }

 static const struct pptable_funcs smu_v13_0_6_ppt_funcs =3D {
--
2.25.1


