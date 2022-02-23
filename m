Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A67C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 15:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC88C89760;
	Wed, 23 Feb 2022 15:50:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 554D189760
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 15:50:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SR3xlf38aoVBpPOzQKQm1hhpKPWwmuLFPfiLwSKQPX0r1oUEu44HGP2w8M2EpetmW4Nx9k3oMsfutnQKBJOw2UkJ8TDfuLeI+dqbBX1ZV217bGbnh88XNAwt4PHeis+uPzAmG3lwKrFTQU6pN1Zu/7oM0it3P1ObGQQRBh1RggEXFDgtaDnOCNzANmmVfQUlon88xMuR4nqHkmvjWW8zolC48hbedWtLcPBfQvOuAqWRmJV8A0qPnbAEz8Odq48qz65O/39yXpHS7VO9APoaC+e8ne+jCyUBetIq9T7fS92HP4XQAwkXSawYTuhtCDAr2SUy1nPL8C6JB12MkN6mJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pkNlQ4cvXfeGdHLASSh8elHk4BJOGPO+4P8ArZ39SM=;
 b=YUI0R0BRH26cgh4Ieqk/hlIO1V6cmWzF2QAocydpffWd0tukpWQ5f4+l0DG6X7wXECUKahSUm+VUtTuCjAfb6ZnaVXdn9Ng/w9xOjmyGfTli/3dv0pkXauig3o541CwkxNsajV0hweDwZAGqYpZEfa0mvuP4KFQzn0UsPPzsqzHDTubBFbMCmIzyjnkjaMfUEQPMU6y8jpzDg5sCuTjBDMMC2FMzBcDDqEbwjdbwwbVkJE/W1eWoFj43adwMnk2HiQN3dSDwbqpLoV2G3v9FODkZ7yFuAw/orgj5f33X+jqbcaOMOer9X0a64y3qBsx21e4HwdilJUlaI+iIfzfxDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pkNlQ4cvXfeGdHLASSh8elHk4BJOGPO+4P8ArZ39SM=;
 b=AGyk31TmUsnQkx1lcuAXD4KUfkdiOGJCBKIvSMcYzNorPgnVRwAO9gMuvr9+LbaNGWfZSc1xJzEnT+XFipewS0rUnhQIR3JcI1RXAriuSl2HLP+rX+z1NBFX3tztK9CdPVcjeB55Y3ZQ9V6v3o+jq1PJyVMIc30OIzyexGyQwZc=
Received: from DM5PR12MB1323.namprd12.prod.outlook.com (2603:10b6:3:75::12) by
 DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.21; Wed, 23 Feb 2022 15:50:54 +0000
Received: from DM5PR12MB1323.namprd12.prod.outlook.com
 ([fe80::39af:792f:29e6:f69f]) by DM5PR12MB1323.namprd12.prod.outlook.com
 ([fe80::39af:792f:29e6:f69f%5]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 15:50:54 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Slivka,
 Danijel" <Danijel.Slivka@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] amdgpu/pm: Disable managing hwmon sysfs attributes for
 ONEVF mode
Thread-Topic: [PATCH] amdgpu/pm: Disable managing hwmon sysfs attributes for
 ONEVF mode
Thread-Index: AQHYHqIm6aRdTQGDh0mYTVbeOAGvU6yYKH3wgAkw4lA=
Date: Wed, 23 Feb 2022 15:50:54 +0000
Message-ID: <DM5PR12MB132389A0F304ED5F4F4AD5978C3C9@DM5PR12MB1323.namprd12.prod.outlook.com>
References: <20220211012343.3955-1-danijel.slivka@amd.com>
 <DM5PR12MB1323DB16294CE78D6F845F748C369@DM5PR12MB1323.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1323DB16294CE78D6F845F748C369@DM5PR12MB1323.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-17T19:16:55Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=ee2fb167-f34c-4b54-abef-e5226b7f6787;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-23T15:50:51Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: d3a76d11-6df9-4f54-8092-8d01e426f5c7
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1f90ccf-75a0-4ad8-c9ee-08d9f6e4469e
x-ms-traffictypediagnostic: DM6PR12MB4417:EE_
x-microsoft-antispam-prvs: <DM6PR12MB441733E9760E6904A10FE5588C3C9@DM6PR12MB4417.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MQWyr8HGDXQ++HrCNKhllh6mRsxfNJr5BlaRWaN8hkHXZ+dhOtqmpvQYcX65VOS+p1n/wEVL9p43IDLbK8aZKyfQ14w3uzgt6128UqhzKlL30Oev0NFS8a4mVa0Y6oKXmvncoVVeZ++bmHvdVht6F063M8KeRC22lK/2Gdalac9OhjBrNRbz6oh9dI71lITSQoCdrs4hj1ZzWfz28LPw7Dz8M9zznUHcNK5glmq5PWpJ4ACm53QL5ZiOIyyBvXpy5ehCc6LGcE8z7cLwm2nFX86WiBTFOeiKWYTe7Ifx5kpSmiox1iu0k1dOwZnnAd5qbF9nl0Z1RtdLEEXjJo/hMycSeNhCU+KvFKGwSuTltenFFeYLgmFCe1sDe9A0cLzKk0rE/lPiILjFiFAbAiYQbWQlJstnkaxXjTJCu7C6xbVzBwBOdZ2pt0VPyC0+J2+aE1h9xV0I4pGrAIzb+kcwIzUnJ8VDWFEcu/BK6p/mif2TXZ5rKMrKcr4afPh1AvYHUDjU78oyPoWyrSOHoXz5wRNZZwISyolHPfB4ouVOKgD703FesGOa6k3q5GDq7OdRNeiCa98u9E18oLTjCJKM8RAItcWeaA9T937B/hjRSyUGyKbz7u4mK1RTIpXW4k6FitNpjrb5KgsRelxuaKbtgvLDGJ4thjMxD+rnwVJIt9gbaRE4rpYtAnSdxQej5sC6fLmuY7My6/KJQLPFLNl9CQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1323.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(6506007)(7696005)(86362001)(53546011)(38100700002)(9686003)(38070700005)(33656002)(83380400001)(52536014)(71200400001)(2906002)(76116006)(316002)(26005)(8936002)(8676002)(110136005)(122000001)(55016003)(186003)(4326008)(5660300002)(66476007)(64756008)(66446008)(66946007)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ary3oIaEmbGTlUSnC6nNiGUMce2MJaFlgZjv3KbS8yw6xoAz+LV23N2C558q?=
 =?us-ascii?Q?A1C+nWsckDMxYbc/UijCaOlFzoWvE7pf+TU9TM+hEZ9Mxb6qLkimytr2wfiT?=
 =?us-ascii?Q?XRf7Jene6hGotE2L5P96/RVhwndd6HhCQPDy1BPPFuSMsIkbuOvGjx++xX6z?=
 =?us-ascii?Q?1oe4jQh5vKmFMX5QFPSEv3zU4QKUCcw3Lg2/h1q4c+G3UyN1gLW2TjSehbCQ?=
 =?us-ascii?Q?fV/AAO3P9detdesqI/6R1zozCN4Xko6ucTNOJFnDyffk3Dguwy3VMAZRitVb?=
 =?us-ascii?Q?CjgwzjesViogHMs/odexhy6GHAcis/+q7wgrslHH0l2H1HbLEzMqgzFRtXBD?=
 =?us-ascii?Q?hltH9bX72AH1f480FBDJfTPxOUFNt6STZJnNudUVIVypShhlk4t5ah82c927?=
 =?us-ascii?Q?QvlqkQ+WK2kiCexr0Kd/7LExSZiSuqeGY2MhWYCfZh4YZYy4tWXl6t8ZxtCm?=
 =?us-ascii?Q?UZ4LXbfJ8zCt6gp4Xk5ONS1nWPO/sWGIzrDzYNGEb9g0jAmXjztm0pkJO5OJ?=
 =?us-ascii?Q?vT7jWq1fyqEHIN2LP+euZJgGut5rHgnJL8fYatsdn1fYyootsPxAm9saB63m?=
 =?us-ascii?Q?hv6hwriAgpoj0W++jQmJ79ney/OQzgeU1zRHwBgynkyTUPpZKh9Ggr+COE9j?=
 =?us-ascii?Q?TxNwDvqula8JuYS7TQcRsPEICpeFYAnwcQH4DLYNR/6kPXCt5e/T3Yelx5UX?=
 =?us-ascii?Q?7IfdkV4HQllgyCHbMPQHgjTwLgoVLSvPIO7ITrQdCgjTlq+fAZIcYm6beAJD?=
 =?us-ascii?Q?JvGnskr3ihJt4xd/S/Hq6o8e2YMCQz4b5F1ThwX7VIle+2V8Cpq/PGSpISmG?=
 =?us-ascii?Q?RIpbfcpQYP1zxy/qTnjJcfGEptSM0/+baCwXC0u5S8DA31P7vd2bApzf/rvu?=
 =?us-ascii?Q?F+KdE6CrHId9av/LUMsMgQHBwAkDOdkVmPc9ESXqHw64j40k1mPC6W+QXUQR?=
 =?us-ascii?Q?8mOUyoXPEtg4tXwNjNfaZgMscFFqI0yGj345y/CJ6t3sjomfjI0I51CkurDt?=
 =?us-ascii?Q?HtZF9thLXLQFlyH3mh6JzFaPEL3nfACCBmnSnarXWw+d1LmZHmcCcAA4X0Ty?=
 =?us-ascii?Q?8OF5MRF3TYN/xrOGyqhAUAurvAdsHSQHu20idvAgp3Yj5dn+YsL8W4FLEmux?=
 =?us-ascii?Q?j5T6n501361FspQJp9y3JlEjFIi7sFGZe4jHPMXhXepc9DNcEDwOmdMHNCoY?=
 =?us-ascii?Q?5oKlb8FGKy0HWc5ewIoaqfYWLREQKZp4IJtRVE6el5EZgJPXeI4GvD8CC7dc?=
 =?us-ascii?Q?fbFqb58GVkNgFcU2PsE1V+uvrt3jlz2Pwz/AcuU1Rdevq9WAjqaHw9yDcw+R?=
 =?us-ascii?Q?Nwh5kXj9ABpbW5K4nTFBpxNQ4jx2StK/0/mkQb1ZChQnJYf900SoP+Gs/iaf?=
 =?us-ascii?Q?LaiRbChWIeL59Twi4Uuprl2tOZP0qLWiEA87FVWhmHdIgl7U5XfXtZiNdQU6?=
 =?us-ascii?Q?sSmLnL/NTAFARQncDHW4wdn9LkEXchqe1OyaiJu49PWrvgthDFcqRBJHbBAj?=
 =?us-ascii?Q?8F4oSpc2ASNm4dewkuoYT4anTIaxb4fRdxWixmY4M/v1/lBeBRzHeehMJlNW?=
 =?us-ascii?Q?hKi9lpWeaAEnL0qfbrQDH20K/DwZkI/vlfuV/jZ0Q+AfMb9KFWeB2x3JEJgM?=
 =?us-ascii?Q?E/hE+m2IjRUD+7Fdr4svrcI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1323.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f90ccf-75a0-4ad8-c9ee-08d9f6e4469e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 15:50:54.6173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c+vizmjgLyZtz6OQp2MIkK/jvWOQLRc1XRUobEm+u9cFE3M/lMmiyH+hDa/Sd9RhU2FBOr4qu0zcNlutLBQQxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417
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
Cc: "Slivka, Danijel" <Danijel.Slivka@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kasivisw=
anathan, Harish
Sent: Thursday, February 17, 2022 2:17 PM
To: Slivka, Danijel <Danijel.Slivka@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Slivka, Danijel <Danijel.Slivka@amd.com>
Subject: RE: [PATCH] amdgpu/pm: Disable managing hwmon sysfs attributes for=
 ONEVF mode

[AMD Official Use Only]

Acked-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Danijel =
Slivka
Sent: Thursday, February 10, 2022 8:24 PM
To: amd-gfx@lists.freedesktop.org
Cc: Slivka, Danijel <Danijel.Slivka@amd.com>
Subject: [PATCH] amdgpu/pm: Disable managing hwmon sysfs attributes for ONE=
VF mode

This patch prohibits performing of set commands on all hwmon attributes thr=
ough sysfs in ONEVF mode.

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index ad5da252228b..3cec023a7b06 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3161,6 +3161,10 @@ static umode_t hwmon_attributes_visible(struct kobje=
ct *kobj,
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
=20
+	/* under pp one vf mode manage of hwmon attributes is not supported */
+	if (amdgpu_sriov_is_pp_one_vf(adev))
+		effective_mode &=3D ~S_IWUSR;
+
 	/* Skip fan attributes if fan is not present */
 	if (adev->pm.no_fan && (attr =3D=3D &sensor_dev_attr_pwm1.dev_attr.attr |=
|
 	    attr =3D=3D &sensor_dev_attr_pwm1_enable.dev_attr.attr ||
--
2.25.1
