Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4EEC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 16:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CF2E10E2CB;
	Thu,  3 Mar 2022 16:31:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30F3C10E2CB
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 16:31:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NO75ld5UVNBNtfGqZfmKK4T9kARlGsyCAjsYCHMAGtEnqL4cFupwyL8sJMbJvM2uLB6MEJptgcBMJKsX8Pa5czhjbR08f4TSMlUHb9lzCQwvoa5f7iO2bHpjbWJrM+nHKXMuVl19ZGhv39U/gAm1CyTP/FeJEsuoyjZ1H3nUNS33gfyVyZYmZxdsFSVRXvH7pDwNDGP3i+HjFWJZzC5QDmgG6/kM0x3uuBhJVDdLJ3Li+98Ui1/zChMLBu8CX96gjU0r2KmTg2FZbcklb2pk60AwQzflT+6RiWKN+lmeDRopUFt0Z0xZBrWAaZw+QPidGo5LqJnkg5WV8HPaFxLW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yP6APDxfPaP4oupvUGhtJfsEOWQ2MoBXQVPnVeMrBaY=;
 b=S26Onl2eT38WdBDbGs2k/t9dbzwvcnAX75zjFxWIT6ZfJhI95LSWa5r1Qm00Qbf9w3K2pvEyLP5I1izz5orRbJt9kOcXbtJ8q3MY+aFHEt2UJeSzACC3K81IRiyLRRz2/E/W2rSLHXIb2GJQE1Z4I+aPl6PQp9aLdBa4HGQVdS0kvi50MkwcIZKlCdCQXJLgxRx1Mkethf+LGAOcC1Q7VSnw0PCT7dUWrdgm7526fMd+PEQkRBFx48DoUqoCyO52EBNWbNq9qrlHLpvtskYlc870rMPY9ycolgEzOuDBK04Ma96maFVjp8H7mfrCf5vZ1rGHCLmkSf1GO5SfDvWmtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP6APDxfPaP4oupvUGhtJfsEOWQ2MoBXQVPnVeMrBaY=;
 b=l0YWAcT193A26rijkuKv3QU/YL0L0b33K4SBVaxzvfjGQDaO2TBKo5Xn3zAaVpxrQzGppJHzoYy+jK+BHbL6QSKXTW8GBsGbo29CCyK9m/LXictM8EOSaN6VB98IadwmXwtnMOeK9FvrPRUtsc4fXRiPe4x1AQl6VuuMZlmqa3o=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by BL0PR12MB5523.namprd12.prod.outlook.com (2603:10b6:208:1ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 3 Mar
 2022 16:31:16 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::b9e3:40:623d:40f3]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::b9e3:40:623d:40f3%3]) with mapi id 15.20.5038.016; Thu, 3 Mar 2022
 16:31:15 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Yu, David" <David.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add DFC CAP support for aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Add DFC CAP support for aldebaran
Thread-Index: AQHYLxtKT2yAhyMItEuwJQABIE8y6Kyt2dWw
Date: Thu, 3 Mar 2022 16:31:15 +0000
Message-ID: <CH0PR12MB5372DEEC1320612A0AB479F6F4049@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20220303162513.28008-1-David.Yu@amd.com>
In-Reply-To: <20220303162513.28008-1-David.Yu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-03T16:31:14Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=2c871620-7e60-45ff-940a-ee1f5ffada80;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-03T16:31:14Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 7ed08414-cd75-4ce7-a4bf-3fd5f037ed2b
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7911f9a5-0766-45a9-77ad-08d9fd333d05
x-ms-traffictypediagnostic: BL0PR12MB5523:EE_
x-microsoft-antispam-prvs: <BL0PR12MB5523AC809FE658112DD21AEEF4049@BL0PR12MB5523.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z2qAd57JOhzziKfVNqJIAesgRZTtEHTCe5OduzzvsJ7MOSnH5svoz1XYhKNID4ESgTJpG+54W1yZEWdUsp1/FZWZNK60Kk9YzuhFpHcKSUzOuWcXn99LWPLXCc+JMBEqTDCuQSqxwg7YiZP53aPnbh0LMlkpI//j88XoAM4HsHE02jLCJuiF3tR/QwgIzVreSVdTOouqoEeowS7Lb6LNp3X0OaYGD0TiWeT9quPaG+0aR6jl/g9EMBF9t6B+7osTUvHGJFC0skWALKZhSFcryZl/QBuu74HZuFoY7J0kTLLXH7SmSq/GQGk4QQnWUgfNMwgCygG6SCIH5YjwfVGsK1IUQks3KnslzM6xm2xZ1IpWmbYM573tOl5saqyFS6DmvmnQX0SKusxkJ5G8Zr1TSMr28JYHspGOJZ+FBB1uycan3DfRrr1q7qGLwiZMtX5DJNgqa1SLN9tlUqZJbQRvg/y1gkHuvlG4AE0s/YRFDo6b48XEd7XkVf2kxA2xZQTgfIQnmdXtUdfUazQUDmFqnWaPMa4pby4L6ZdXCo3OxB1tj3KQZz0m6HCjGA4ix3wXrFxoSfARITQiD18/0EhWWTgSDUmsvjkvhsFIhKdJ5iRNBskoeRKuPHdYyzO99M2FJsjkzeiX57cgZ93yan1ESpihLBbb/sfH8uEOPewS30ci4pcmvzWdB6BLSHon8i4n/usQf9aTY4Tw433uQGRyKw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(52536014)(26005)(316002)(186003)(76116006)(66946007)(66446008)(4326008)(8676002)(66556008)(64756008)(110136005)(6506007)(122000001)(66476007)(38100700002)(9686003)(7696005)(53546011)(38070700005)(71200400001)(86362001)(508600001)(8936002)(2906002)(33656002)(5660300002)(55016003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p7KMFFEzDAp70khqOSkgTlHD9cW4AEKl2TMOvgOCgAGT7u+todp7YL7/7/V+?=
 =?us-ascii?Q?GzlHX+LEVAGaLdeQTz5xvDAAATaf55PmEGBOx8HE64oEuVWYoHdWbKLA4L++?=
 =?us-ascii?Q?BOddp277o1XcXImK8ExFg5oXEX4rBKvozGyTb5o6bAS/g+ujzR1SLh8HYjv+?=
 =?us-ascii?Q?FzL8dv4f7ABaNL1qKiOfB+6qTSGbRJU3dlLz5FGTp34VWfOgwZLUEJm2IKHo?=
 =?us-ascii?Q?A+w6g9TPim0BLhM5OEhkJKUAU3FRouW9sitLDRvJYo32b39ryueOpsyxWHqO?=
 =?us-ascii?Q?Mb6W4Tg+DHThCqoXq/ZrnwsTNk7fLEgdAt/qFwpiB1tXY4TA6j5WVL0fUKRc?=
 =?us-ascii?Q?f8O8vDPsthq4deGk2JxmSXDbHx50n7HIom1fp/r7IZK9ARBMbRQrzRa8rDM8?=
 =?us-ascii?Q?zxLfWy8L0YChdI3kewoA6CgPeUfxf2x9AkfXu/dohRKiB3uubnjIV4sdganx?=
 =?us-ascii?Q?6dY2hSrl1CJN2r9C3JBTTaQj1BiL8bW3ts34KUoc02yBdxRSxwGS3pwyII0+?=
 =?us-ascii?Q?CFfHPiiEPJ+RsgrB495Q/IHBM7UFy45+TyNjVx1+xBTnZ3/uYhBtTe9c6LWY?=
 =?us-ascii?Q?prBCoMqRb9YxI2n7dR1vSSIgkRLVsjtNVSce/pU5UvIJNSpmuAyQAMNOkjlJ?=
 =?us-ascii?Q?qqByhtVg1t7hfR3BLQ3zyOrXGeogpY19/uvmwm9bx4ToUK8JNZYtWMi87WId?=
 =?us-ascii?Q?ne3T7QeF1RjZMarUoz4ZgpWzc73dMC1RuI0vm54PpQ06fcjy+nXaFL4KeNYp?=
 =?us-ascii?Q?c4TSqQJkdLtGs9DbmX9U8JqXA3L1GSDf9fWqZdxT2kTVuKC0Uuk/c3Ox643s?=
 =?us-ascii?Q?PjiN0HcolDkhlzEEwIxAZ9zzvdJfLvF61GNMCMgb5ppYRAg9prPlTUMl+x8O?=
 =?us-ascii?Q?OCmsUPa7HB68orxmTh1LtPpJT5+3oonZtAStOH6SW7ypAStv3szj6HWbKrnv?=
 =?us-ascii?Q?okoV2ubj+dw+p+y2jAO4gp10VWCcXTGuCNzIcq6LB+opKLazyp97u0ABcx/2?=
 =?us-ascii?Q?BSv3yEog+rNmFu3wm/9WFiexr8Y8qlyiFiKiwykSR9H0FupTBYb7hzchl3SK?=
 =?us-ascii?Q?msbkiuBUQMxWcRxobL+LLWLtRZoesZTUWQYlQoo93Ns/LIMYReb7z+Mw2kZH?=
 =?us-ascii?Q?N/Ye5mkLP/E0ZWkhQSloMAuaaV+M4lmUcPFrKGg+6Yt+1q4xJLtqpxfDS/Md?=
 =?us-ascii?Q?grt6u26ddh+X6TF7wn+0+Gu+ICmR1X7Hwj5+2gJkLoX5VDVWxdun1MqxmqYM?=
 =?us-ascii?Q?Q0+tGfUojjFYRBXfE0qg9V1BXUXcdSScwkXQX7trVcVoLGOZKrL+freNq69I?=
 =?us-ascii?Q?z94geu0UvMDLnvsK37quJih/QWKPfngphD29+If1F9BRrWrnYw5fk5FpWl8e?=
 =?us-ascii?Q?xrG37NZuauB1C+/RPaNQbj2+9B7HvLl1wu/uTGEXu7lDwMXyfD+fBvSrcM5V?=
 =?us-ascii?Q?dPTTzKZlo6K5d4zivhSAzigHfeyTykvDzyklNst5yrZ5vn3ATUu3opCkKnOj?=
 =?us-ascii?Q?yPWCpE2jeX+iPvFrThzJak/eFToSRDI8dJaTTaBrr8H3iQmWt4ZU8TN7qmCY?=
 =?us-ascii?Q?XU+lPfLjPXKn/MmZfOPuqmm51qRRDxa5fpRCv/Nnj7gCnZWrNhtGiafcrZQ5?=
 =?us-ascii?Q?kJDdNI2ivNU/BulXgrHKuks=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7911f9a5-0766-45a9-77ad-08d9fd333d05
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 16:31:15.7157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kcz2IuSXQIYl31mBpUuLlg19Uik23EUo031JenOCa/sDVt5GcONUJwgV8qZ7Bvf4N9rFNyG6FQNfmO7u0AfTKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5523
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
Cc: "Yu, David" <David.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed by : Shaoyun.liu <Shaoyun.liu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David Yu
Sent: Thursday, March 3, 2022 11:25 AM
To: amd-gfx@lists.freedesktop.org
Cc: Yu, David <David.Yu@amd.com>
Subject: [PATCH] drm/amdgpu: Add DFC CAP support for aldebaran

Add DFC CAP support for aldebaran

Initialize cap microcode in psp_init_sriov_microcode,  the ta microcode wil=
l be  initialized in psp_vxx_init_microcode

Signed-off-by: David Yu <David.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-  drivers/gpu/drm/amd/amdgpu=
/psp_v13_0.c  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 94bfe502b55e..3ce1d38a7822 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -277,7 +277,7 @@ static int psp_init_sriov_microcode(struct psp_context =
*psp)
 		ret =3D psp_init_cap_microcode(psp, "sienna_cichlid");
 		break;
 	case IP_VERSION(13, 0, 2):
-		ret =3D psp_init_ta_microcode(psp, "aldebaran");
+		ret =3D psp_init_cap_microcode(psp, "aldebaran");
 		break;
 	default:
 		BUG();
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index 2c6070b90dcf..024f60631faf 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -31,6 +31,7 @@
=20
 MODULE_FIRMWARE("amdgpu/aldebaran_sos.bin");
 MODULE_FIRMWARE("amdgpu/aldebaran_ta.bin");
+MODULE_FIRMWARE("amdgpu/aldebaran_cap.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_asd.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_toc.bin");
 MODULE_FIRMWARE("amdgpu/yellow_carp_ta.bin");
--
2.25.1
