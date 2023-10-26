Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60999C0032E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 03:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D879A10E736;
	Thu, 26 Oct 2023 03:32:34 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2F0310E736
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 03:32:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dt2rA9qAfSYWsM80m9UGtW9yHLmZcbX6BtSbMjIuMUark+/jj7L+aQyLaQWM6VGIR0W7JopIuReMbfn9Hi3nMObuD8Mp05Av5VISpniRdmWB5lIRwqfEXVz62jJQSt4PSsBJDDR3/fXuiwLqI5TzgrUSNsIjupfgAC1NvbUEAbyvbMgjelHi4d+r/Vmp3OYFmx7rbycZfWlPUipZ8qRd2835Hg4IN6M8zdxrepWZrVOOh5nDKpdMDDaPS4bmz6C4LfVnh4aEUs6zH/qqvLArSsirJPrwWpK5HMB1vUo20mkqBdA1jiR2Yce+Ekh/CN1C1D6rTKM4ISANmn5YNxacLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBgweCPeuQmwvPOrMjXhW6GqTnBOc5zwjVL3hJR9fxI=;
 b=FK+oGTUznwrN40rn6/wfP6kTwF5b1lMw08ocvEvXRVY+klgcvYOHId3qc4tolvzv4Q3+AsWJYTvG5xXcHLmIubf95o8ztm3Jc1j15PWJh2gKBD9Tn9ilLxN6652rzRl3uUaVsLZdEFMVAEQmRBBBggfQZl6VtVD9iiLPykkU2QQVfT+hoZB97t+QQUKObuekMtz7tuNvDwjXO3ZO0FQfn+8IDkliVnUKtsWIn0JhwTOYFpKstwXfsB9N8sC6Ys7GBYFelWlG7anmQHYWCYEIXJKfT2X2b8KOXsbGJMefmAojPkPHVDYnAgnrL3IPqJ4BauVMdduZ1hWysQgWAfeQHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBgweCPeuQmwvPOrMjXhW6GqTnBOc5zwjVL3hJR9fxI=;
 b=vCwrQS7i/PHlGjmCFh7AFpt2N5fW1OZ92llTBWew5oRDL8dSNC6u17n4V8fTiwz7ZxQWY9t7ccc3P094Kx7hnnK/TTAssLOi85McUUxUkFB+8WIxAAS14VGO+D1M/sj3HLNQ0ADoGY+1rm6FjqvgONL51Dqb6MIiHVe1xscn/bA=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SN7PR12MB7345.namprd12.prod.outlook.com (2603:10b6:806:298::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 03:32:29 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a%7]) with mapi id 15.20.6907.025; Thu, 26 Oct 2023
 03:32:28 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Identify data parity error corrected in
 replay mode
Thread-Topic: [PATCH] drm/amdgpu: Identify data parity error corrected in
 replay mode
Thread-Index: AQHaB7RhYRE40CeQ1EGCaUFk8c9x47Bbakgw
Date: Thu, 26 Oct 2023 03:32:28 +0000
Message-ID: <PH7PR12MB599768CB8B9760AD92C7B7B782DDA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231026023003.642684-1-candice.li@amd.com>
In-Reply-To: <20231026023003.642684-1-candice.li@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SN7PR12MB7345:EE_
x-ms-office365-filtering-correlation-id: 8b5c2442-4cd0-4067-62a0-08dbd5d42e1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 70TZXz59LfL0BJEV5q5B85Ocg83TIz9SPTZCGljn7Ms6TGoHNoKr3yY+jf71b3gBXxbrn3a85NeXolZPNHtnWA9UJjKuvt7U+duipw4KkkiVPA1vp1/4lMv54/j8YChc0Ix7i+kQB0Leu0yBJR853NoHYM4pUiwcFKhFtlszpGnDC1LirJGqE/PwcTrX/9SDuC6oniB548NuSGw4aGCK1LyPuNf3i2KP69rKJgo+YxrgPCjjA8ggX09I/ghx5g+TdaUBt7QNVjD6+VLW+55u9VoYkJj2qpqOqGTYyU52gUlOPVmKw7hy8bJUxiY2C+InWJ0ApY+6vYVBiuVWVYC0sOOkqrIYiDnxYOGF+dcKqkV0KY6A5rGwpg/P6he5CLvZNRj3vV7Y3ZEQ5m6uD2FdUoXLEWdgAMk4c3yLNooqQQUmT3oTvBW+b5zgaFqxnQDhBmfF2+THVPXQrW0w/5PCh1SfftyUV3Ovk4g1H1gp3UC7OxPnxbb6f4AIhJgJNoWQxauAvAAp2ISy99LQbi+zLcFFL0RBi1DeBKmPRRAtXV96K8AkEaTIVzHmLqdMj7GmFh3n2Oz8Ts9QLim3gMP4R2Q7TpoMmnvYKaY2za62IFFUIElrKEL7pWTDcBO7hn3i
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(6506007)(9686003)(52536014)(478600001)(66946007)(7696005)(316002)(54906003)(66556008)(64756008)(66476007)(66446008)(76116006)(5660300002)(53546011)(4326008)(71200400001)(8676002)(8936002)(110136005)(55016003)(41300700001)(38070700009)(2906002)(83380400001)(38100700002)(26005)(122000001)(86362001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+kwsykHGirEF8XKgILSX6I9D+5BHXM19UHCaGOD5JwW097CfkEP+DH45gTm9?=
 =?us-ascii?Q?/7B6YrRqA64ak5IavOkUDY0o//b3n6WuFeAPTpY+zpAi7QePcqR6sANIYW8D?=
 =?us-ascii?Q?mlREn9MvMh5GNMO2P2SMTpP4JK1SJIwPxcnAdWR/+OyY+Y5nSBjxdSQOOgNj?=
 =?us-ascii?Q?501qxQ+pQmrHk+MeMjm11pLbmUccgw0ttrD6jYis3bOmlq81432ZHOeagoWF?=
 =?us-ascii?Q?PhynI1YKMqCrB6F/F/MBRRBK8Koq3kj6A2Hh0qa+p1WrUe6ckVcMQoZJWYIq?=
 =?us-ascii?Q?BUPr60XIdBIMgoHDCn2T/91RvNK9BlOJFz3OTzpdm08dc+o/Z51LBH2OW4rA?=
 =?us-ascii?Q?5tf1F+BILli9a/0r/H0GoETrH4lsSDmy9uCI+Ci8S51/jaS10Mc3nS1XP0kp?=
 =?us-ascii?Q?tUQcy+ifixQ+CIVV+8pdADavxNs9fRk+kyhhFi6/AWL5kUzct6bH7jdmhE7Z?=
 =?us-ascii?Q?2E3xa6EHsVpG3DZeXj74umh8w8SmSx2ikiQTGP4Lg3iiA+yy30AkHqtwpacI?=
 =?us-ascii?Q?jU1SHl55w2f2PLrJBHMY6PeTpRaAMeOibRZxJv0bowXuE6qIdTGOu+ZLg/k4?=
 =?us-ascii?Q?Cdqvt7oJFqHLmFQ0wCnbpqSe7MIvLKRdpHDPAisa/g4FlymMwMRhq5w5fkBS?=
 =?us-ascii?Q?FbTH+g7I1NNwUI4G78Ix0aJt8tYhiVF6puc3CrJv9TibNBx7BZdJz/gQ6abi?=
 =?us-ascii?Q?1LVcDJfFVDXQyvYQe9E6YX/rU4CKC1V6XPmPcz3uPjXx6aBEKBlzSjAPMKj6?=
 =?us-ascii?Q?F+VaVlh1BdKGbsM5OdbE5CegD6MYb3pxQV9xDxFQAti4tYCXHjoIjzlXq6DU?=
 =?us-ascii?Q?0spW7krrxxtLWxK2ednBKIN2ygCjHIvHGqKIzYTSgcXOwAwxEJUmEWGrKK2A?=
 =?us-ascii?Q?sXA3MuDAuSwK23q2eJhl2V8YUIAj2IJPm5eZNdSz1/COJQzFlTQ92C2WVw9f?=
 =?us-ascii?Q?a6pClJSbGRpv5tDkygyWySCYFyRTjtiqzjlr7YTO0dlGKEae/eTI09gvoQ5a?=
 =?us-ascii?Q?iPm6DDH4eYKdFx+w2UrpoA0mK7rrEvOxbVxyBfD846w4JCOEGOkbeUJ+5tk3?=
 =?us-ascii?Q?D6NRJAgnE6x3rYGnN1GEZeAAJVbwMYDbQ4mW3onabYU28JB+xWcc8c0FzFjb?=
 =?us-ascii?Q?xwjRbiz6EgcFTl00Q8bNq5fnv4e1nJVfo8o+j7Lt8fvs+s+LRsslNiPneL8V?=
 =?us-ascii?Q?D1ZeBnMa28B+X19i4UguiDN4kq5v7A5ZoSYz/ln84om7SdB/XeA8XWbMzmi1?=
 =?us-ascii?Q?3Lbs6/w2hp5X285IhggtUS6bqo2TTZChKqhcJk0JjZunWzFLwwtbNT08hABB?=
 =?us-ascii?Q?gaVD0T7CdJDz2LEVj0wIBGTt370HBYNX4rzAEYCujj1+jvvPcDR2D5IPNjLU?=
 =?us-ascii?Q?NQ6PRIGRd39s2MOIh79YlALQA3eEZLyXmBpb76oCRSI92vsTHmJ5dsdqtY5R?=
 =?us-ascii?Q?C2C7pR8eZAlfEJ9V1GMVlxxrdGNdLgVMjny0kje8JMaPugvOYELv3qvYTnPk?=
 =?us-ascii?Q?fd0Fjbjod3Tu+B+NaG3mY/M58GAt+YRTiuy8M7l+KN5vYYv1HetzGmJ5EwGv?=
 =?us-ascii?Q?M3KtAWAia7Ckoy+KOhI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5c2442-4cd0-4067-62a0-08dbd5d42e1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 03:32:28.6282 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4PawBgvBWXkOwXa+yMY+NfIjdO65DF8n4D7cnobjSs8S30VHHZ2yqrMY4QsJjs90
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7345
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Thursday, October 26, 2023 10:30 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>
Subject: [PATCH] drm/amdgpu: Identify data parity error corrected in replay=
 mode

Use ErrorCodeExt field to identify data parity error in replay mode.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 32 ++++++++++++++++++--------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 025e6aeb058d43..743d2f68b09020 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -88,6 +88,27 @@ static void umc_v12_0_reset_error_count(struct amdgpu_de=
vice *adev)
 		umc_v12_0_reset_error_count_per_channel, NULL);  }
=20
+static bool umc_v12_0_is_uncorrectable_error(uint64_t mc_umc_status) {
+	return ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) =
=3D=3D 1) &&
+		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) =3D=
=3D 1 ||
+		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC) =3D=3D 1 =
||
+		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) =3D=3D 1 |=
|
+		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) =3D=3D=20
+1)); }
+
+static bool umc_v12_0_is_correctable_error(uint64_t mc_umc_status) {
+	return (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) =
=3D=3D 1 &&
+		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D =
1 ||
+		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) =3D=3D =
1 &&
+		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) =3D=3D 0) =
||
+		/* Identify data parity error in replay mode */
+		((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, ErrorCodeExt=
) =3D=3D 0x5 ||
+		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, ErrorCodeExt) =
=3D=3D 0xb) &&
+		!(umc_v12_0_is_uncorrectable_error(mc_umc_status)))));
+}
+
 static void umc_v12_0_query_correctable_error_count(struct amdgpu_device *=
adev,
 						   uint64_t umc_reg_offset,
 						   unsigned long *error_count)
@@ -104,10 +125,7 @@ static void umc_v12_0_query_correctable_error_count(st=
ruct amdgpu_device *adev,
 	mc_umc_status =3D
 		RREG64_PCIE_EXT((mc_umc_status_addr + umc_reg_offset) * 4);
=20
-	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D=
 1 &&
-	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=
=3D 1 ||
-	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) =3D=
=3D 1 &&
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) =3D=3D =
0)))
+	if (umc_v12_0_is_correctable_error(mc_umc_status))
 		*error_count +=3D 1;
 }
=20
@@ -125,11 +143,7 @@ static void umc_v12_0_query_uncorrectable_error_count(=
struct amdgpu_device *adev
 	mc_umc_status =3D
 		RREG64_PCIE_EXT((mc_umc_status_addr + umc_reg_offset) * 4);
=20
-	if ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=
=3D 1) &&
-	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) =
=3D=3D 1 ||
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC) =3D=3D=
 1 ||
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) =3D=3D =
1 ||
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) =3D=3D=
 1))
+	if (umc_v12_0_is_uncorrectable_error(mc_umc_status))
 		*error_count +=3D 1;
 }
=20
--
2.25.1

