Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716AAC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 05:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4B5310EFE3;
	Tue, 10 May 2022 05:36:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1839D10EFE1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 05:36:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7mEVwHAvYfe4cp1b/K8F0AeKee/eqDAgwRskT6D1GG3AH2VpQFUxVZJbdjJHK9clIjSz77gSdWEzoE++ld0v4QFUK+7OKytx3glVPNjNryQZ8uaG8fFo367Z3Ijol6uAKw+671culvtX2WIIgQqw7l2qpLtY6PbFxmwkrPMnZc10HEaoBHI5q3bqwcvve0z89TiGmEY0G5+odkBy8DTCf6RNC198aGH/WSEl5b1vO0/FCNunK3xuHcMRyRfL/B/3NxC/YIc3k/zwTxxpgPalL/rJ0gRT023f8cTASPSioCMoAOEJz2HpB2ZAxZX0VeHEvhTx3GSxURcmuQgdbdZdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpWTJWonukdaiQ0niwOTxH0wPUSVnCwpztbYIic6iPM=;
 b=AXaJrEd4lYN3O407zQ4mOhoDUkZg9M2ZBm/KBxBOCTvdfz73+O/EBYkMWA2+2dl9CfTCb1/Y6RUVOzwP6GJqQYVKNNnYg3e4RFusEkmjD62CFquTZMhJNDZJs19Q2/Yy+dRCNYHaEPlrAh/gR2QuthbP0DBwtd0cXa+qdLm2LDQndXUNhlZm7pYWsxHLDO48LUJD8PiG9MedpiM8oWnoxWz+NvYgnaM0m8Alhol77Pk56GKt0f77hVPDCXof06k6cW0xOHfqCcxtzbfHFj1FUQYqmodi+7qDX4RSo01EoFqshUoUOoWZA3gUY9jPYmGnwFw7FykfqiJ5AETPRBLeXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpWTJWonukdaiQ0niwOTxH0wPUSVnCwpztbYIic6iPM=;
 b=CJVjggtABsHDPlhS+wjAwQGMF5pVJ+7BxO8De41bJ3KAF8npJnDRi6NHO2hf0GRDIgAuzqqRMdo5y6qeaKSHgTbr6+DNsbGzOrITyr3NXmfse/mzV4vLpyt51DtCc6VAQNHvxwkfWpcipika1lBWrZ74FZy97ENab8GXJvy1ENg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN6PR12MB1652.namprd12.prod.outlook.com (2603:10b6:405:6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 05:36:40 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4cb5:c559:c82d:94da%7]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 05:36:40 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Ziya, Mohammad zafar" <Mohammadzafar.Ziya@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH v2 0/2] Add VCN and JPEG poison consumption event handling
Thread-Topic: [PATCH v2 0/2] Add VCN and JPEG poison consumption event handling
Thread-Index: AQHYZCP4j5jfr+01KEe8SranfVXR8q0Xl3Ew
Date: Tue, 10 May 2022 05:36:40 +0000
Message-ID: <BN9PR12MB52574209A616D24A5FE5B459FCC99@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220510041044.323154-1-Mohammadzafar.ziya@amd.com>
In-Reply-To: <20220510041044.323154-1-Mohammadzafar.ziya@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b02b3e79-49ff-4fe5-998a-9e51b26b68c5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-10T05:36:13Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b4456ce-7b54-4f73-ad29-08da32470f40
x-ms-traffictypediagnostic: BN6PR12MB1652:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1652150903B8F5D7A7C434FAFCC99@BN6PR12MB1652.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jnwmG+BLgYlTdxw3tD4Ti+15+wb1UnUkLJPRApEGZAvNO4QwT70TA4WY8sW5kc4tkKmBRC8Fsq7LV+pi9H+nH6PJWHFJXze3DqajSG9G19vm0LYODvyg4CoCikrBDovD198ar+DxZ8u4ah0aYL93gERnM0dIT7wmxn6+OuurCoh2UO2CbEbNOvMvNH4Bck+FCcsDHV1tpzlksWZxI7mbxiNx/vXB3ZJoSpQQp29yxaxTinFyEOpSonkby+vzft5N4/BXVv7MapYWIms0cOiPyi0M1J02WFVhwe2f5XkrNraRauLEo9slrXRCHeiE6pFxy3hC3r1BKDsWts2yqnOgT1md/6yveHloUQ3JVyP8fOXLJING38mG3i+pPkH+Dg278fJ0OoWpR5KdTYrVQHoNnmS7x6FPekLS+hAVnj4+TYjHamYxkK44IrBgWSCj07rhyh9r7SpWmDfjQq7xnXzw4bVj8C/AVlzE7Zpzj7cJWO/wYmvSY3xe7usHE5N9G5jte5EQBoe+Ufb55tbV7wCuFQBnIswQKT3WjLC02sq4cN2MXqKiqibsBbp05EdOtJN/LsVS3tHMVB2KbKaS0SLKj4H0tPTWpJgmFBL5NhzjqlIOI+7Fuy25zdPCeNYAt/JiO3aTCDCi+CuCk/kDkO0+Zgh1lhmm//Bj++94ghfWRmgjuVV6wYaaKh1GMgmxR+WCDUVOI3oVNlLlP7ouLa941Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(33656002)(66556008)(8676002)(64756008)(66446008)(66946007)(76116006)(66476007)(4326008)(186003)(83380400001)(71200400001)(26005)(9686003)(86362001)(316002)(6506007)(7696005)(6636002)(53546011)(110136005)(55016003)(8936002)(2906002)(52536014)(122000001)(4744005)(5660300002)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vZTB/Pxb+1F2aLQP+nNhr+8gAiPUMcjRaV9DPb8oebcw5Rw+6u1+GUsNTyex?=
 =?us-ascii?Q?mhOruUkZ2IhgPVd/gyGrSbIEy1cdwO4jFVZbEBZNsfPurRz9W/lDhmFJ/oVW?=
 =?us-ascii?Q?79uZ0v6u9474eNvGS5YWaUIfhkiRIoU/V9vSIVxMmIJJJlPtC2S0BciEnckD?=
 =?us-ascii?Q?tq2pmsqZ6uzxbNaq6EqtzxxeunwrG9XAgyuBdOUNPTbdocPehOXcvAMAVo4x?=
 =?us-ascii?Q?1xdMSztWotSZ4gy6OyN5yA6kLXlgWK+c8jcxroBLkFu5+d2ynnmpXkpgWPJ4?=
 =?us-ascii?Q?6LCpl7JK1XdW+kuUA5vyfgCLmcGprjUk9M36nsEdNR+qS2hKG/GZD0Oa2TOW?=
 =?us-ascii?Q?2WHvrKFVzcrzXxsrMuHD+W1umxDdICnKvryoCIoWz6cYFxfdMdVsFKzPFQk4?=
 =?us-ascii?Q?mYtIlUboPTvZR4PRlqnJ7cK7kof0tDrFk6OSrFu7XXDdqa9Jp+ymLT+Me7lX?=
 =?us-ascii?Q?b0if5jbf+9IuLQzF3IBOPLRKzScT5NQkX4ElLwqPts3TeVKlVxXB7KWCRuAt?=
 =?us-ascii?Q?2/XIFmo4/AIYNJaIsoFD7w7r5X/ni+5p7nQ58mukSU21rY3DrfmYgfV7aiCa?=
 =?us-ascii?Q?JnPsBUGF0m3NmPu80lU9Pp5E6f0sMixLGhhFmOQCuKSphoeRULKfIF/f02z3?=
 =?us-ascii?Q?F1pWI3VJUvZ+qAmAX1ULVIZc0J2hPdoT2GKo/n7FhJRB5I0m0iEuWlChKNm7?=
 =?us-ascii?Q?YOqAhMxtUFomsQpL6PTSPpt7xV30sqB5FutUuO6xofrg00YNn7cTrvkN7L5r?=
 =?us-ascii?Q?5aVPo7RT/bWx94qjnZEDZRhLuVk93RQp0UjK0IB5VjrjL9E3G6yPTSjaq9rl?=
 =?us-ascii?Q?GSogawtYXHVvtu44Iafo+shY/8VcnRmnHiaUghR0DQf3C+NY+hG5eLuhbPdY?=
 =?us-ascii?Q?2c2nWY5rPyQMWtL65OsCIEpU7Qmw8nYjQlHRoiwr40ckS/5bnCXC5IIalKqK?=
 =?us-ascii?Q?mSa9e/rGneiJoMPGiMn71Gtkna1ILipgXfvfOjUczAFMot+I4KBnh8VR/Zdd?=
 =?us-ascii?Q?WRSxS1r25PGJTmEmUXHmbwLNJKkPjrOnduuKTfJuHrXhac5WNfe19LGxb2Mr?=
 =?us-ascii?Q?91s3VNsMPxWsRDoe0lAOoiNeTuM+numhZHXzTG1b77JPVyTzLpBRaKr3iywM?=
 =?us-ascii?Q?Ipn2KXrtQkJSGUfWJ2eHc5sldFSf6pZe6xi5wAQ6Pe6J3qJHbW1dZk5jWW3n?=
 =?us-ascii?Q?zJpePzgXawxTSKHANuGdJwqz0G7YY6yIC6NwTCuS5MFVEKh7Gbcje8tE13SK?=
 =?us-ascii?Q?w+OTdvRL2XEnoM/LL3ub47XvSAC6MJ8DjUgnPht1WrnLjWA/gTepuH144F+m?=
 =?us-ascii?Q?NLRbf4bEIBVeYNbd/GYLRDjfIX0UgguFJ9YnLqyOaYO5VWBTyw027hOc5L79?=
 =?us-ascii?Q?9QJnWgeeHOAYrco4go/RsOthyiEOffaDHrtUTQQP1DdfENWi69Q7diTmnKfW?=
 =?us-ascii?Q?tqHWqoF3xdLnCIZQyLdQMxhkS5ozExlwTO8SOkqp/ItNAhrAGlE5cyy3lpQV?=
 =?us-ascii?Q?iRmLvXSqD5zNlU18FR45R2Pi6raCXUyc0v/bQ+O29Vk4KcE2nRgVDNNJsx/E?=
 =?us-ascii?Q?JS+ueRMp9m4/Y1EcpUpoyKX3MlYXJ+WBdrZT9USQjQHWfaHY+6pVJnXHPiEj?=
 =?us-ascii?Q?vbQ7dgl9Fwdi78+uO4Dpv8baDksXz85xyadB1cFcsOtr0uxoih9AbGdO2CwB?=
 =?us-ascii?Q?VCqBBEC2qqOgs0MiODQ1O1gtVtpmSJ7ss4SOwUsH30YC/CBWXT6Xy3jHa3u6?=
 =?us-ascii?Q?pmwshH0HaQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4456ce-7b54-4f73-ad29-08da32470f40
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 05:36:40.5998 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lFUEYCv4uT+msCIPv2i9LWOjh6a6wI4Q/9QNThS+OwzgI1qRqPAC5D2Xzkr4Dot4FAJr69hQtzeng+ereP5CVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1652
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Ziya, Mohammad zafar <Mohammadzafar.Ziya@amd.com>
Sent: Tuesday, May 10, 2022 12:11
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com=
>; Zhou1, Tao <Tao.Zhou1@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Ziya, Mohammad zafar <Mohammadzafar.Ziya=
@amd.com>
Subject: [PATCH v2 0/2] Add VCN and JPEG poison consumption event handling

Add VCN and JPEG poison consumption event handling

Mohammad Zafar Ziya (2):
  drm/amdgpu/jpeg: add jpeg ras poison consumption handling
  drm/amdgpu/vcn: Add vcn ras poison consumption event handling

 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c       | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h       |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c        | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h        |  5 +++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c         | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c          |  9 +++++++++
 .../amd/include/ivsrcid/vcn/irqsrcs_vcn_2_0.h  |  4 ++++
 7 files changed, 74 insertions(+)

--
2.25.1

