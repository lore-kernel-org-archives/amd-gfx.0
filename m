Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099DFC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EF0E10E098;
	Fri,  3 Nov 2023 13:21:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C238710E098
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQPGCiKFIHkAC7x3T53pcOJeak9XIG9MrtzkN99JU3O/PqbY83MB7HIJkJh/bevGrqW5L4B4INi3cGsGag875z5yxk8BvViARBfelAxHh6QBn3Ra60gXkoKT/KbPij7tXMXAoFpI8lkEfzFAh4oPTqRS3uRgIj2CWA5Z6m+FNZ+1zrYw7kTpacx4pR34wq6JdugVXYP4gR3+ww+RF3XvdcacdB5PyPyZN3J0bQk6ZA/oJ3XXGI15dGYr2Mq6Bhn4moAh+ncQIuANPdmqo8b7A6pj8Wsd15VpCHTBZfJzTLE0iDcLF856bnfD9MdsiHbQQS1qozd8dSheYbhRgBVnxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8urA7RFY7OO2zeXhBqOLOJiX7JMfJ/6ZKRbOgned6Ts=;
 b=bcPfaoBoEzlNapjIYD2eGIl49YuSe9FBXk5KSVqc2yBPGjxcUToWbrPAcXR3eQs4fjFMo2CsMIAcxgliyd7ztJ+j2r9TFZj5O2eTltO7IqYmslKYx33upmtPPvGayo0J8ZiKewc1CUacbpMCRUDQ+sNDjprnSVa+l1tmV/y4H8ZYA762tN6kW9PSaZ3519rPflyGw5NgIa7hLTyIeyXFIIq50GbrGR0fFBHscVXmRhBsG6pJ3eXYZFwL5BVnfh/4y0VZhToCYPsSqymiR2zIvGv7AJ9R1x2WmQRpj4SQz8923JCObPOc76YtQB87l7vtHIG/j4Qo97rPgeHXUjGOIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8urA7RFY7OO2zeXhBqOLOJiX7JMfJ/6ZKRbOgned6Ts=;
 b=LmOBlx65uI9dBaMbuwluh3rhDuzEn+IJ/u7f34yI9oC5Aw4ca6Md4KJeI5Rlz135bYsYsjtT5NCPaRpGttBGS0uBJLhboh1qRp6NfEHmgVeBqKXg3geDwYUCCM8FPZnf8ybw/afvFBJYG6+gWUYG070XTAsaBaJS4Ts9NT/4tNI=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 13:21:33 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e%4]) with mapi id 15.20.6933.025; Fri, 3 Nov 2023
 13:21:32 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/pm: Hide pp_dpm_pcie device attribute
Thread-Topic: [PATCH 2/2] drm/amd/pm: Hide pp_dpm_pcie device attribute
Thread-Index: AQHaDhsAqu9L56P1cEiKzBt94KnTaLBolNbg
Date: Fri, 3 Nov 2023 13:21:32 +0000
Message-ID: <PH7PR12MB5997C16AF0945D897743E79882A5A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231103055935.481843-1-lijo.lazar@amd.com>
 <20231103055935.481843-2-lijo.lazar@amd.com>
In-Reply-To: <20231103055935.481843-2-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|BY5PR12MB4084:EE_
x-ms-office365-filtering-correlation-id: 1ebd386b-78b4-41e6-5a73-08dbdc6fcc2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9+BADs9Cd8PChzQR1t/WjowVrtcgP47C/A13lXGE/274eKRDfKuwaJB4BezSulrnMzdFEI9TjU+kKIJPciGF2Dk5jPUZVmbs5mev6mBrLXL1aBDehfIVXAPrdymtSAW6slcOAOf405JrbksSCCWGMALCSjQKawWq1zlgrz8ht2Wys/xu1DcdLDwD1C2hBakB6EO5v76LEWTcHKhS2ne+VrLsC147ioCl8bz3ArN2mUTeWu7Bf4jjRXHT5qb3NQcf9CuMj5OsZTZ59qBMRx7T8L5l6LVPjG3/jOWE95RjagS421Z1tTJ42xp+rUkTBFDn/2eYmQ1Kw/BHG5tJG2puGW3E6O5N8DCfqfS7FcORwEApVou7nyFHvPkiRh7o5wKEgQ4JwKW6UPcxDiPJaNtZw4w0oSlQxBbVIBZ0tObZrFKyaLYNSTIWcNS7cx9/KZNh9B4Uz/iz1lrCr806SQFpU5NtTPXbklpIsGoKB5V5+RxhEd8ygFMVr9IZXZ+sG/sWcig7E1syXjM2cOnLdOGugfnDPHzcwhdjnxbOcUPTXWK+6ruqD5OVlpVa6G7zS6w1i0Yjs5G9dBXvYzaVwSG0QsIWC2vwNpsU1j5u+5D7dgDTHUd7mZO+YT3qhQ9pSbzc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(346002)(396003)(376002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(53546011)(6506007)(7696005)(33656002)(9686003)(5660300002)(55016003)(478600001)(2906002)(71200400001)(38070700009)(52536014)(122000001)(110136005)(76116006)(66556008)(66946007)(316002)(66476007)(54906003)(64756008)(66446008)(41300700001)(8936002)(8676002)(4326008)(38100700002)(86362001)(26005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?47mXFEVvwTpFjeHKFeknkHsgyGse7tlbvp2m42KzoQ4+7/MvjuySKcWCAxL/?=
 =?us-ascii?Q?FR7nrq5Jut+NYBT9+buQI5vPfobqhX5xBN3BD9adEN501ZG/3tg4BtP7oGU1?=
 =?us-ascii?Q?nQmJw2vbeNWqE1pi+866czaanQi+l61YTKoI24jUwUfKVbPtZCNwebcRYisd?=
 =?us-ascii?Q?l8bvg4Hlt6VPDk9KP0GpxkUKKOLu6xr/2FnrO7msUpwUkkkW0+Uw9q/ouPLU?=
 =?us-ascii?Q?cYLnBvrhZCKlCDhDnyoSe92co3p3/26FOHciYsMPe2lkILURgcMlz35xFT6H?=
 =?us-ascii?Q?bqm2OrlLfzY/VFtRQdbqbfN5zzS2c9tW04Ly6rDX0voJXggpIsWUFNqL7LV+?=
 =?us-ascii?Q?S2qfl9ZIuk9pYcmZBRAiw4mi7O+v58PZsz58DreeSLYSzRMEuTRwiSZSbAD6?=
 =?us-ascii?Q?+5GHtrg8xx6n2KmE0pw+VLtpZ5ebAqIt7LkoK1amyUQ3M3hNopGApcci+7oB?=
 =?us-ascii?Q?yVN6yitEI8MbMkzOk03G6LqW6nG8v32hQjZqX3apN6+Ce2hcl/zVS0nCpT0X?=
 =?us-ascii?Q?lnm2sM66Gh1lTO9jWzOsBq01ootBWNyCDQAE/Mfi83B+XbFFo/VfDWPRN0Bp?=
 =?us-ascii?Q?URjQkAQEyERW55WgN4cw1XWFVR8P6XwbB5JHND4IHzdJKYjK16eTyHgEhVA7?=
 =?us-ascii?Q?WcCvPmbjHSSB8THv9Zf2Qr3UGa8X5qbyB2Krzdem4Yd0SYZQ1zBzz6m6jLK3?=
 =?us-ascii?Q?9UwA3zhFkBgCI9aEByCwcYB/BNFZQ53lUSnQgpnBSWfcxAvTbSGlajMvf9te?=
 =?us-ascii?Q?s4/iFRlG3Suuv8N8HdylsLpittOCLsHLRnzZrsTyT4eD15FNIahuSBTKqfrw?=
 =?us-ascii?Q?wPAbiKlBn6AnfdupW94LSPxkSEXm+h86wMD8w3SzRYGdvJMkvFFXtYh8lv6u?=
 =?us-ascii?Q?j4CKMaEP9z/OULWJmiml1AvrUjLvi3TA5dannUViuv1llAv8ldd+oORqrlRu?=
 =?us-ascii?Q?TwPq+Rm4yXGVzkIFZLURac26tRM/RXP5jqBKQkzCCH+QwnhgzvEkBwGhzD2x?=
 =?us-ascii?Q?njKFzM72ToY8mJCU0KhzK8cbpFpfkz1fLivQE4+N2fkSw6OngdM4MgrTjqZV?=
 =?us-ascii?Q?IH80SYIz1UoaHvZQXJmn33E92/9UdrO4XgHocCukJgjIG1UiwXLPyd0PC7YE?=
 =?us-ascii?Q?BQpG/yyUHzJpdbEPmClBtOVfsGbNyTkbg9DOl75rGEYurDjGxLMqqGv6QKyK?=
 =?us-ascii?Q?8eR+i1P11J98ANWoCIiZYiZO+D5wRiSXe3rl7ih11lkGIhNYzZMFSp/aJ7Ii?=
 =?us-ascii?Q?SUX1Ras2dfPsyDDPLre8B2j1yOIf+fjVn/PCCmzBzWtcJmrcqpyN0PEjEsMa?=
 =?us-ascii?Q?9unvQi31JoRwCDQeaEBVpnipnfnwUWSWUmuB/gMZpFmGq1TXLul7/HmyE9g2?=
 =?us-ascii?Q?0at7LEcq0dUH3Q1nUZoWDscvLGzoi02C0Z3UonUluvnK+HFuii451ghKR38t?=
 =?us-ascii?Q?UpHhesUwbQb4s7iEMWZozn3cAWInLtLTlbESJrtuwRYJbxQIAGs5BNKCe+R/?=
 =?us-ascii?Q?cNn3PdPq3VEqIVqh5TG3lwTzDU+iNbJyVJwf2Zr/cqHaez/c9nl7eS31FG8r?=
 =?us-ascii?Q?Lsr17cTo1Ck70ib3aek=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebd386b-78b4-41e6-5a73-08dbdc6fcc2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 13:21:32.7696 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CO77rF96XzV2y2+mtH4LixzS9+r+JDgRkdCS2eGtmij6d5gqDGcwS6cCXC5GH1KL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is=20
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Friday, November 3, 2023 2:00 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Hide pp_dpm_pcie device attribute

Hide PCIe DPM attribute on SOCs with GC v9.4.2 and GC v9.4.3.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 083048131bca..8f57c77a45dd 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2249,6 +2249,10 @@ static int default_attr_update(struct amdgpu_device =
*adev, struct amdgpu_device_
 		if (amdgpu_dpm_get_apu_thermal_limit(adev, &limit) =3D=3D
 		    -EOPNOTSUPP)
 			*states =3D ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
+		if (gc_ver =3D=3D IP_VERSION(9, 4, 2) ||
+		    gc_ver =3D=3D IP_VERSION(9, 4, 3))
+			*states =3D ATTR_STATE_UNSUPPORTED;
 	}
=20
 	switch (gc_ver) {
--=20
2.25.1

