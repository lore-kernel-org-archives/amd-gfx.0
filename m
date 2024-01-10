Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F91C47077
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 02:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 978F710E561;
	Wed, 10 Jan 2024 02:47:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CCAA10E561
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 02:47:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cam/Ajngl82vWQml5AUeMHoZ9IwOYRPCdVbVtOzOS1/JnzAhRk1iwWT0yBO1671oV+MUHjpUyBPdv9Xjia82ShSbsuYrPe6NdDAR9skH2HKULHLwrtDCH5TphjjVwh0CZUPPGeY74RPmCsmKx42ynJBtPXzur7Aui6LRNvDkPMRM9uD3jdaLG1jD51wuXTESqD70hjneuF2iNCS1y5/ctxyoBZc08BGZZRqZXXOiibzncevzIdTh0mJMppF/SCCCr2s1elJTpwQ/sMiIuGjfnholhZAE/xrTyW6yZrX4EZ6LVZSyPdmwnUnR3rWn1NMmog9+KxrRGLgTbjJivBYT1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XGgTIwAA8ddpG6QSYs+0MRNnCa6EEBp9zB7Gv2vaio=;
 b=XQ68QZ3Tn1D/kKCvu8iSyEeaujInqHDktaVrbxpdoSI/q1pHwxaD7lLSBRzJp0Vg90OTqLx5+JkeYEqtwkA1ETxsdC33aSkXYRJWA9Qixng7jMovQbXolr03UgA8g07yHRp3ja+21e7ZaDucZFlwdGKJDrttpSVrz4Kv8Edyw/ySt8P928TXDz3YKXNzPJsuQtnIqK5NXfFFkgrcIhusUUwvXpBGEc9jI79x7hiHkvBE2yOv2YOJEwGysn1fFoWRDCfHZVF9Muai/sVE5Fw2dL1vQmFG5bXTMxwWCn0EZKdPiK8CwHs2fRkhmqL0ge6OYeG4oRCLlKKrE8B4y+y+Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XGgTIwAA8ddpG6QSYs+0MRNnCa6EEBp9zB7Gv2vaio=;
 b=Rqw+2wsrSm5nBkoq2dqG0+8OhaplUBRURlYkWQ4L5SqAok9sri4xW/Nns93oN+/ZS1gKhjQ4Y1smBc5BX8brAwUDTG8b/ld/LrjM4HlJjs8/GMu34WOHijt5upx7BQrUYUl+hLkyNcH5wdxrkOAtpzqlas6Xr9+mBHpQgr24TDQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB8037.namprd12.prod.outlook.com (2603:10b6:510:27d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 02:47:35 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 02:47:35 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Enable smu v13_0_6 eccinfo in firmware query
 mode
Thread-Topic: [PATCH] drm/amd/pm: Enable smu v13_0_6 eccinfo in firmware query
 mode
Thread-Index: AQHaQ2yIZjLBxWL6FUG2ckQVC69MLLDSVzYQ
Date: Wed, 10 Jan 2024 02:47:35 +0000
Message-ID: <BN9PR12MB52577422F8652ADA6CF0D534FC692@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240110022626.374753-1-candice.li@amd.com>
In-Reply-To: <20240110022626.374753-1-candice.li@amd.com>
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
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB8037:EE_
x-ms-office365-filtering-correlation-id: eea4686f-fb01-4eb6-bcc6-08dc1186803e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VuZCliogOfIyieoBuh28Ea+FnZSdQNBM20NrjmNWlS1JySPC/ha+nAci/eynqwy/03HpT78pAs4DnPFelfVu62A+PsG5B+PiaIG3qshayaePVQT/9Pa+eyj791BXSIrhg1JRdSM38MVjz4Oi3VZEsw/nicPDJURwTDBX83jx5/WYrkGJ2R2erde6/kt+v8r/YEVRetwh6oXNSzp0qcEGgQq6gAalFKlzJ60GwLSldEtwVQzNVawNDlfvQIY+Zi96DMwrg4rz+Tame6upDkQ+8qVupgwSsINjb0xKHMwoaFUTfbtD5Ykv/ct57gzwAhalTb4wirDJBhyVSnEtceQrGWJSgio+EgRHXa5cAkiARc0bxGiyPf/WRox5iiOI3OzwpmTbftJIOanvrAoHZdoBUFwemMLXMYVD5+9QGwdwCrlVpfG//kQFB6NIexbcpiA0+FoyXlH4YVfeE/3VFBeNt0TsyBHXKTNSR0Kb64ru6QvGabnHz731DwHSHA9OP4VVIh8ynTUHuxsvzeED2c/HAXD4hqIPN4toCCgk/ciBM3CpjDv1iuWGmFfRENzOWUjW89XYuu7cH21312bUPyrJoNZaw9z2m3Xpaxx4EU4hca1lNQeiZdf/cMcWKjNEjCrQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(396003)(136003)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(55016003)(2906002)(5660300002)(38070700009)(8936002)(4326008)(66946007)(316002)(66476007)(41300700001)(64756008)(76116006)(66446008)(66556008)(110136005)(6506007)(71200400001)(7696005)(33656002)(86362001)(8676002)(478600001)(53546011)(26005)(9686003)(83380400001)(52536014)(122000001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CiZskhANdxfULdQbfUhg0yz5kSmXfPWepQywOF8V+HVEpuBPllYqULQZBLZ/?=
 =?us-ascii?Q?Rrd02dmq79x7vL2pwlrJgYnyHaRDAHZ8p85O+sRBudY+dxwy6NNzTEO7UASZ?=
 =?us-ascii?Q?4lS7ArViKE8iBT1j1UBaU+OUlhrmyu5qWBW21dAI9eLCT9Wi9Y+b4Cg5VWnI?=
 =?us-ascii?Q?r2kOLajZVTASy5C+JaiyrAIQlebrZGShjZMnvC+8JRlEm2ZkG6qEXFU9R/9e?=
 =?us-ascii?Q?o11GZk9S5bklbDtDLN6VyQEojXDNJQCHjae6xfQAy+wFsL+5bj9qwTJL5OCx?=
 =?us-ascii?Q?VSLQkD87uIuYSFy4XjCNQVj30vek6Sis4678IeRdfyUBKcvN4hy0x4BHdN3x?=
 =?us-ascii?Q?/79+09pWxqDniudpGM09sMiqHWpzM+qEY08dcdM3Z7FHmeUNVLkwT68hLVPO?=
 =?us-ascii?Q?IrZNOBsmY7PONqlZV2YYBVRUsD8LysG58WrrK+V8jkO5MQdV/op7GO9KbBuv?=
 =?us-ascii?Q?zBEzDlYrMLbuz9lmp2zKHFoVl8nK2LGRcpPgL7N2Y15xcgEKVOBGtewRbhXI?=
 =?us-ascii?Q?A5v+X0QKy+fjr6BSB8sxWt03DviTjPAhqEcqTzZ1chHIjjPKIwt7U3xaOs5c?=
 =?us-ascii?Q?/o4l6zJqsqlbBTg0f3JORympfv7vgJDX00zjBh1LMANMy2263DRfFyS5r+Ub?=
 =?us-ascii?Q?les7+yaWJ5uVvgIthjGfX48mMtYQByCeAZo5Ykw1crKMNGvV9JiL2dotk/51?=
 =?us-ascii?Q?xNzsGooBErFi8AuzZGoC8RocJmJepKvQnyr+tTjLQusQ2SbSdFIzmKoy8n5K?=
 =?us-ascii?Q?SiYkBMd25cw1UpwO+e+p76DvEzpSQ0qQj3xjtBv6Z2Nm9aBYG7w8KAbKMR47?=
 =?us-ascii?Q?r4duSVqOQqnZvJtz471uTxUAeqwib330Wcd5EPasngSk6Yfx/WI3bxKr4rkT?=
 =?us-ascii?Q?bkLMMubhA5E++wlqcX1brYQcwZZ2a+enikBC4UUAZ5kYGrLvvlmlZ9nt3or1?=
 =?us-ascii?Q?NMYgSmvX143WergseqUClXpdZFxXy2qy4NB5DRwXhg88cEAydfSr27OiTK+I?=
 =?us-ascii?Q?SNPdqsbBtEPqajxPcd/p0LPwKm7fpETH7W32YuCmdhzDzEOAGOBW9BdkC6bD?=
 =?us-ascii?Q?IJP/Jv4jANs/CCLQTcD1TutoOwnW0qNpvaDooFIbkUogHVpRlK8QZXsOqv2m?=
 =?us-ascii?Q?x3fuIg4hffR4qVQMAzMqw3C2VyxCYA5tRSjD+BWlD+qO800MnjCtsF7h5vkf?=
 =?us-ascii?Q?e4XnPIVTrQ6kPREVU5v7DfHkNDQoIpGqm+Tstui8ic/TsBZWjXZruAeKwlvO?=
 =?us-ascii?Q?6frso/rLQPg0SHRfk/Te0wQdANJR4Xt2d8BCKBRXKFxxZ5DZZk4chyNKrcG8?=
 =?us-ascii?Q?pgpeKMhz+W+fHmCDM1F9liYndYAXxb1EKNsm81vz1xqoh9y6evHaUNb+J1Uv?=
 =?us-ascii?Q?lv/iI9XsYYhkrvLnqzHRbn/NZcG751ZnWJOfF1mJ0AqOTsGlTSlKFNjIVl8W?=
 =?us-ascii?Q?W3bra/mqvAgzA+wq7tW/JZs1et4JScxkcLuhhiVqLW+175JHNZA+zY0FJpTY?=
 =?us-ascii?Q?+GgugD2mhQHI7WZlvRkhZbWM9DtoEzdAo9q4D62dsQq1Nj15Dp8BnjOan0L6?=
 =?us-ascii?Q?z/agQqxEq2EtAd7zWuKJ+Uo9GMnA9At5CTuFy3KS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea4686f-fb01-4eb6-bcc6-08dc1186803e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 02:47:35.4103 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1xBIN5YAcD9Tmm+BgAWHylSaSudrI/p6O0kh3EW8Xc8lL8GyLjVPMhTnaDQpPbd1+OIUAVZyCTqv45yRwF7vlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8037
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

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

