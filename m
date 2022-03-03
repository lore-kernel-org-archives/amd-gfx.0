Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33495C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 04:07:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B15A710F1CE;
	Thu,  3 Mar 2022 04:07:41 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A74D310F1CE
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 04:07:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1RNH3aGZUnVpsMobX40f5mooPMY8fNYglvkd2wITSIDS9DI62THHM/BZWm40p60U4VE9w8ntE/ixIaxIbqLkVDkByXhoE0Mfy7V3ZWmLdqgNxiEzP6qm4QQQlapmMK8yd+YeRlmXS+qyHH0CMuUS31QUsd29oeFPxKo8j5f4n7KlN2rR4Zk0erxTJ5O3hF+29ifZNmWk+akbb5fqay8TiK21HRcbkqZWvd8dm8iptlGT9xxb5+RABLZdbCoQju1XRrqeVgZkIkq3rpfLgnOPgNn/Tcf/DB3/CxFnQZPZzJlRUw8kChgbIwEktJGursA0zMmNOBwo0tj4MDP2i7Wfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVNmW5ItJTqZupeqc4CovOVqKoebjarsebrrwxOIUdA=;
 b=aWE4/7Jbw054w6O6xg3NTQiFUH87irYrNmrrXejPs/HkSW7VxuMZtBloYho0X59FUqhJ43bkj72UVbtVa8lnVxdeXAMvg3OP+DJjBhdWHwTdVsIlE42M+IOCylx3Ei1IXeAeLmwIGxNEa6CDtMhYgD+OJaHAF/7pKLTVkLbAtz+l0q2G+Ezk6ObeOkM7CZ7zfdyUZzqRpuPY00PTGwERw+Z5kveHS6v5MzjIE9RfTQ2xJKdnNqupPyFFtZpwJRhlg7iwplE7IkzMNqRTqF3PKS1s/rwquXZJLc63ptTS7N3gn2j4n2MgvEZoRHbkggvmu6Lns+6k5cWwPDrPxABbPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVNmW5ItJTqZupeqc4CovOVqKoebjarsebrrwxOIUdA=;
 b=aPdjswgbT38m50ExPGzY/lvrPPeQDgPhq8wEXl2Yn9JfXdp66UjDYEDRixe7S5+0VGSSGc/OML7iqZYSdsRAe9dWGLGbO37nzCkcrarndgIJLWKCPaJLm1s7OGac1ug16O7+HmE5ATmcZjgt0nlpvf32Xb9bXqwmDXCBYqoo9Es=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CH2PR12MB4069.namprd12.prod.outlook.com (2603:10b6:610:ac::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 3 Mar
 2022 04:07:37 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::b9e3:40:623d:40f3]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::b9e3:40:623d:40f3%3]) with mapi id 15.20.5017.026; Thu, 3 Mar 2022
 04:07:37 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Yu, David" <David.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add DFC CAP support for aldebaran
Thread-Topic: [PATCH] drm/amdgpu: Add DFC CAP support for aldebaran
Thread-Index: AQHYLq2MsehIoT2PXkeznXqQOpju86ytClhQ
Date: Thu, 3 Mar 2022 04:07:37 +0000
Message-ID: <CH0PR12MB5372284C4FE817026F3C875BF4049@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20220303031936.27454-1-David.Yu@amd.com>
In-Reply-To: <20220303031936.27454-1-David.Yu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-03T04:07:36Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=e97b4333-7766-414e-b9fc-269297dd5d1a;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-03T04:07:36Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: c94fbee8-83a2-42e2-b501-e77324cb9323
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0332d786-7dc1-43ec-3420-08d9fccb5a50
x-ms-traffictypediagnostic: CH2PR12MB4069:EE_
x-microsoft-antispam-prvs: <CH2PR12MB40698908D563589E29CD496FF4049@CH2PR12MB4069.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 15KeavWQCfviBVsAmWxEigrXrxMpG0ZP6n/EW2G8+LighIATuagRbkkx94TDBwdccbEhKeNlYfO8Mz2ju3yCQ8HpMQvqjtSj2yagljFpH3IjYWPjif8W/zo1uHenxGn/Im0uzpnRYbTocHpUkXhC5oPIF2HiBKb7OPCXtZ6/ARJqC+UqtDj2v+W2IJFB7JffgqcTPS91GX1bYh1IJF5q7JdguC22xqe0uDAhy7z3WpWewKq1LbA3Hji91rWE3LlUhW0QKiGM96upTM4MjYOi/hLt+b9JZ7TedzeZHsNgAifIrLCypYusHot2ecQkWdZR/huTS4shK/GBMd2DFCDc6v7UyNeJ09FbH8lpNuvW5BYVa7rRc8Hm68I/4y3lZT0BokOcoXChzleuLX8mJnkeFcQPCgo/eXRID0SuUYTnyhXWSQ55kdxffCl9jQJRQgTRtD9DyML8aB1fvyBfe+OVhEzy8egZXiNr76aZmGvpa1m77t/CjE0RjEdfB7HNMqWWPgz4xX7hTT5H92tlwcEbgMmdLKw9zDZyTzwxuiatKNaK7UjS4lOyS/4RWVcVBDaisqk+1X9ESG94DZnxrrU8Rs6FQLZG8/74pDk6S4ezXNAxhmbLfPjKCN8fm44CQ+VPZvEUyWtojC46lYiCle5rO3h6Hbtjk43jgY59QprUpJ+uCtKhkYbEnZiuOopOGdqm9HFIzFeB7SqNZUn+JPK+wA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(38100700002)(53546011)(6506007)(7696005)(33656002)(55016003)(508600001)(122000001)(71200400001)(83380400001)(110136005)(52536014)(86362001)(9686003)(5660300002)(38070700005)(316002)(26005)(186003)(66446008)(8676002)(64756008)(66556008)(76116006)(66946007)(66476007)(2906002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eEdHjiigWqYIOO1o/vTOcvF+oSrV3txBAm74hFMvTcL1PmAXL73mlmTWlooA?=
 =?us-ascii?Q?GhzgHXLdN1wMsK8EZsOh6gNZRyXmEZFs6xqL49WYwRwQ3ZooJwyFCVPgt+Km?=
 =?us-ascii?Q?K4ZiF0Zab6AM05cqYXgal794T3mGH35P/lMWo3s0wp4tNBCRiN8NIkZ2C2iC?=
 =?us-ascii?Q?lQoL6e8duAeFHWAwIwOpbSLH2aV6gktqnN9fzy7Ml+zwaZWs+V79sY2AxeK/?=
 =?us-ascii?Q?zgKl2befkjPXBzF2rM0esmrLCBveJPt1HWb527h7pM11D3k+C7FhuIrdYfW2?=
 =?us-ascii?Q?QRHzcHtqS6A/s7olm3W8kuDiwnSaqyiFmRm4zIKh8lf9fVCYs5/rj1NaereA?=
 =?us-ascii?Q?fzmz1VACbJ/9OAdesPguCssldwLRIxdIoAwtwcv//Mda4bFIMxsiD1irq9GC?=
 =?us-ascii?Q?KxM5/xPVcbtZ6KRtjpc9OR7j6ll83CAFKJsv8fYJi7yX/68EFI9VNtWYToHF?=
 =?us-ascii?Q?KfkIUqXrCSiQ+Xjo4MHpSinqd7AJelB1fzQuP7we+drtVLZ5PMcUVvx3eI1O?=
 =?us-ascii?Q?6SQPdWLEzKDZ8AHIuZ9h5VVvTR161kedCpQ9cgDARng9sQwqE6S0xs0U6RXK?=
 =?us-ascii?Q?xPoS2+x12PpAO3HXg7bCXOPQI2WqFwJz6FqHHTpJeWZVhKtFwr8YnXJv5L0B?=
 =?us-ascii?Q?IZzYG/cEK5/abS9spX4Y2+Fea15l1QK70SY3NnGjKgfx8jjS5Arn0kxXQVUI?=
 =?us-ascii?Q?5eh+nDSf7X+fUQbEgGam1aA1oJtt/BZDtaJBOefKxoGmrCpmusHB3btk1HiF?=
 =?us-ascii?Q?/s9zz6UWBVK6BwcJ1cNXMMw/HfvHh0QbByxrtFFW+qMQnwEAmRWHKV/6uqc4?=
 =?us-ascii?Q?2W6ZaWYcZTWJ79/ASs3YTGOzzmZE60puXGYvwyFab9yCDi86W1oDHfAihOww?=
 =?us-ascii?Q?z0pJr7caUW1XISUF9xJA/oZ0CIt94+YK6ZaZoUfZxoQpsOiFNa5csdv4l0GV?=
 =?us-ascii?Q?Z68oVPUArsAPAS1AoFROxF7xyzhYEovbH2+4Oils3XSYEJ5yygEzmXU8xIfX?=
 =?us-ascii?Q?21cQdlzuJWWGJyWzK/6ZL2y+w5vrd0tG2BoYbT3NBqQNOEYjnodRdDQa7e0v?=
 =?us-ascii?Q?Kn9unvryjvCN0f/gJFZpEdkEdu20QE6ExMDej8k6QP4ItwczatcglDiDN+Nj?=
 =?us-ascii?Q?37thVltvIfMD/tmp4fXycXOzttSAiWTG3C1x60g6eliZzur/uIULj69ZHb52?=
 =?us-ascii?Q?lGv+7Qx0F60Ont1rxNoD0EaM71MsNLXX3Y3Q3jnmn7O8AlD4Eut1LqgfLBPV?=
 =?us-ascii?Q?pWhX1Jc1DKJX/n5BfqXVBFRuIowt0N4mjys3t2u9Y59Bv7VceaTXKaTWIT40?=
 =?us-ascii?Q?vF5y06OR9MKRa5yCfEAj8VzKcSraB7D4A7e2SErtZd05oRiVCqHp7JFUcsoP?=
 =?us-ascii?Q?0AMB4sUrqDxCeBy9bKqxzDl+c3p6KDYGW7jb3EhZ1UE0eomczo2990ffnRIL?=
 =?us-ascii?Q?WYitA3wwilbno37AyTDxLFFAokBu+iCgMC0hZApv36oKqztX52FR4TsFPFSj?=
 =?us-ascii?Q?oG8dggsGqriYRdAp01hInMFDr8aHxGBdDy7gFKsKumPz8SdH98jtjjIMGuuI?=
 =?us-ascii?Q?UcLkSpNL/tBxUjmYa6RGC0EoYG9+EOqfDgAwa3KfXt+OSUQajboxjBoAj42m?=
 =?us-ascii?Q?T73VPl57Cg8j6dl79ANVIkQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0332d786-7dc1-43ec-3420-08d9fccb5a50
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 04:07:37.2308 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0o8rVgtn8B4wKyA/Nys4tAn80PmMwdqwzEIxVxRHPG5KcdVMEj/nwdyYu32Ms1aClWetVP57I4z0IohTzjE1fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4069
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

Can you  added more information in the description ?  Like why we should no=
t load ta for Aldebaran here. =20

Regards
Shaoyun.liu


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David Yu
Sent: Wednesday, March 2, 2022 10:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Yu, David <David.Yu@amd.com>
Subject: [PATCH] drm/amdgpu: Add DFC CAP support for aldebaran

Add DFC CAP support for aldebaran

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
