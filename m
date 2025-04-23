Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808C4C369CB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 04:24:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BB8410E3F7;
	Wed, 23 Apr 2025 04:23:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S9cFhOro";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6677810E1BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 04:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5c1hT4mjxIRI7+ya8tEPtirRHtK+GutB8+fYKStZ37Kp49Lc9JsKZ4HsDptHqis99JxhurS8QU6oykOAK42h4mtFIwC5bX/9cHga+ZjXLhRk/JFxkJXBfQTVw76xc3WYlfNTXosZqXMjRU2gDjh1DbMcgkf2hQhoK8mawxkHBdI2kwBz2GTgwl1COnfYaK2v7dFjvMz5m+JCYCOspEl3a/LdXhJh0SrhQfylNIcWJddwFjtuq36NgozKK1Jkz2h4FZslDKwNrGvaJnT6KubLBmr/wUV7AnA4NdWZ8tSmZxBw/racOLzHR7OiW06yHQBRTihlvlhqhlNrfNKF4ev8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ovHpOECYK+4sDJmBrIxRLN2DxDi2CSWuUEJWGgMV5k=;
 b=CNF0H1P8lLuqcERXfy+AXEIpn++fLoYi8H57fL9TS9bSWFOeSbsngBDduG0rEc47OulKobuOriVe27BAjp4teV9u2Ro2bZlg40f1k8uojws53e9z3gXdGdRMiLhGnMlsSKAWx3uqffkvTQ4FSIZB2eMbqDHbSEU2dVXesILCJbH9vlcF0mLOCBKF+wU/K9mwhOjIbJwjDPK0UjqVS+Fy/8+NeeEvuSBHP/X4KG+RXk7fv+0nD5tU+kj30TIhk+ake4rZDdXwLIOQMCuf2bP48Ml3PRMrWdzjfUcPs8X4HM0mliiyU3iiJUhXpzzCt99gxn016H97cgFLp4CYsqDo3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ovHpOECYK+4sDJmBrIxRLN2DxDi2CSWuUEJWGgMV5k=;
 b=S9cFhOroIwZZ9lIvaaT21Ib1Q/+9KFgxkEffO9IhYRu7PAHlbKvxjYE55WT6IdveEIUXRT+Mk0TI9ihVII0JC+5hDI9nwDyC1cfooYV+ssRLPahBLkDUelkw1x3IbY3ozASJzY+5tRESJu1ws1TLixX9Wc3QOEtcsb1Rsh2fNzU=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 MN0PR12MB5833.namprd12.prod.outlook.com (2603:10b6:208:378::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Wed, 23 Apr
 2025 04:23:50 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%4]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 04:23:50 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
CC: "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v3 1/7] drm/amd/pm: Add ip version check for smu_v13_0_12
 functions
Thread-Topic: [PATCH v3 1/7] drm/amd/pm: Add ip version check for smu_v13_0_12
 functions
Thread-Index: AQHbsGsj4jQM30eGUUODqjpoPYNQT7OvQNIAgAFtAYA=
Date: Wed, 23 Apr 2025 04:23:49 +0000
Message-ID: <DS7PR12MB6071B58C327A1EA4F2C5002B8EBA2@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250418140633.420887-1-asad.kamal@amd.com>
 <BN9PR12MB525718684205F46252ADC8B4FCBB2@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525718684205F46252ADC8B4FCBB2@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=53e21f0c-36fd-4fa5-b564-62d1e63f2380;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-22T06:35:47Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|MN0PR12MB5833:EE_
x-ms-office365-filtering-correlation-id: c951107c-b8d6-4684-791b-08dd821ea5d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?fgRMpgMz+371W2xAE2tnPpZYZBiX571B31WTYKYAwyS1qe/uCf1+O0mSVSFY?=
 =?us-ascii?Q?G202PJ3jjxEngDvCxnqj8e4BKCALJSbtSRtY6lhfuwTO+9Gf4Eh9o5O0ayJD?=
 =?us-ascii?Q?bb5WFj3zRo0rD9Kne3B5le1boXi1JC2dl0+mutIZtk6GwfFSNVav4ksPAHoU?=
 =?us-ascii?Q?YZGNXI3kfHjyKWxDqZPOphLM7e/poreQVnk55JcSpnWQtF35UAudmj5rvBwj?=
 =?us-ascii?Q?MqkNKoWTnv546T3Kz8KG/YyouCx5and8EXChzygKV4MLKYuGQzagldmbzkly?=
 =?us-ascii?Q?EmRNtRgPpdOyo8pD87AJeuMmAwdohnaGwJ0tQH87IATv7gVnqWUSu9GjPbEA?=
 =?us-ascii?Q?AgrIW97PxRaB0/RJnmo/ijafrMDyZ8sLWFdTI3Ge1fj8sTO4MTokB/EmRriv?=
 =?us-ascii?Q?lJSJ0eXxLgJT5y1xIKsdcktcVM0m/4EmABQecEUdO1p/BzjlBEahinTia4yQ?=
 =?us-ascii?Q?bcGeSzpHa5NUWKCbSvcimQq90ZiOf1Azj4HBIpI7IV9CgigBBuLo/ZlaUaUT?=
 =?us-ascii?Q?YYwPqCX00faWd3pxPuIci7XOf6nU5Q/adUtEmFY0ScSb8WuZP9YE/kpqZ+/w?=
 =?us-ascii?Q?jsQfPGwRA8MfiON0EH15JGAFxEr7vvIgPhZx5gyELkmtKN8FfsGJa7UM7QYy?=
 =?us-ascii?Q?4cLIW+YdJUncGhwPNsnJnk9XWaJ/wk80z2FEOkqiHwy9kVfgKJlOcGFpziC5?=
 =?us-ascii?Q?lojuG+cK9AVIuKS0gpf3hZAAmO9S+y1QnrRg7cqotqbAB52Du0sZiDrD54qo?=
 =?us-ascii?Q?BQNxvfYH+nhNd3zwuaLFLnNmMjfmoRwdCSOUdPZddaTMsPutrCsCRbdLDLx0?=
 =?us-ascii?Q?yqWWi/jwB1ZLdFhix+hIym3/utwjnmy0bNdaKQWBcXKVKSe1h5o6Wu0gJBW+?=
 =?us-ascii?Q?zzpTjkd1C1KscbFOIqz6Pd3TgIi0iyZtHoPU97iL2OlVlwMhcLpvUYG29Lmm?=
 =?us-ascii?Q?WGx5Z3O8lVrIC4IMtUukzcBarI4BDi5Z3axaDeYfzrmGBFivd/NGC/re4mPs?=
 =?us-ascii?Q?lgPU6lMkCUwe0aJZ/fqBRj8/MQbUAtO68u+rJH7XS9KLQfMgZhnuuGkB6I/a?=
 =?us-ascii?Q?PcCtmChGZ6lkptXd717bRPubKewQy9GcePTl0QVanP9X7QRkBdJdx+B5ns+1?=
 =?us-ascii?Q?AuyR4ToIBV68OG2WDqV5w0lzqmxa0xloUbuVYj2wTSGpS2g3aCebkOKXhUBg?=
 =?us-ascii?Q?NTxshGmhcrkULTbfro4IbYQFgHU/AOQfeYARSvRcVreeqeo8lQg26OpTgFr3?=
 =?us-ascii?Q?697PNwOjkJ9vANYOcb2I54beaJvz9v7lFWVSNN99fGnaSwDuKsmmEao7Ag8t?=
 =?us-ascii?Q?Ak2+uWULzZYUfd5zwxnT4JLu2Hin8LMMbYQ2ilkKWIpZ4eWImTewEEX6Qesj?=
 =?us-ascii?Q?ZxkZXyoLuVwGMJgOahFuL+aSr85ryFvGbBy/+yfKMm1qG6gnj6QppWChYweP?=
 =?us-ascii?Q?g/QUcqpcefic5ZgI4WQ3kXcR2zxj7qngHR/6yR3rYVmuB4fvsuryCg2H5gN4?=
 =?us-ascii?Q?UptEtjkLZ1joRDw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CkYGHXxynVcPYSRcLZNZI7aJoYotkKckMPIRdq4TwSzxBtCK14tlLvPyJYbd?=
 =?us-ascii?Q?cEBY7Z8R9/NRQGj5TX1GQqyZnatfhBIEYHgEJU2GZtx3aj8MXsbmNQfc/KUo?=
 =?us-ascii?Q?H947bg8AzrSHCXa/jLFmhooHeCzh4/mjN4u2f+sXTVqXYn6CM2dFYZtczwO+?=
 =?us-ascii?Q?ZKuOK2zpkIAPZNj6ekbKETWQkOPLvNcZjDXo0CX12dPSL4tQuQRQGzuVCw1u?=
 =?us-ascii?Q?DUgTDAgqyNJV6YGRKP1RIWejGpqmFa+zIMr/nunhbuSsccLEwHh/5CVC3Tpl?=
 =?us-ascii?Q?WuDUSDarotOeKAzGEy0OC/tQIvQ1a79exQtVkgA9OxGbel5WQR/oJENqlcjj?=
 =?us-ascii?Q?L6eDmFASZIhQCNR8R+Lx/NaD6MfKYsNFb2U7QUbiG9BLvlZW2jW3umkv9nsc?=
 =?us-ascii?Q?lzZqewhU06N5SFz/CMpyunqUJJKqk9UUcD11yW+U2B53vp99ADRnMY61wK8C?=
 =?us-ascii?Q?2esSKSypvbXtKBgfNPh1XY4c89xOSQyzqP0W/BoURZQmwndxq83Y2+TAsXWr?=
 =?us-ascii?Q?0nLrX1P/Z4RBUPtrwrGWNcQCfUQVzNZ/Jhs4p13mblAcAGwy0jxGAd7x2JV8?=
 =?us-ascii?Q?5JN9NfWrssgpEeglndhHCWy7OuTyQYNeFX6a889yV6fQlkaXh8nt3WI0rihq?=
 =?us-ascii?Q?MuJ+E77nJ5zx1vtjzLdqEGT4OVpe9p2BVSvIEa+vK5yEMlFeJvMisLHFVvFN?=
 =?us-ascii?Q?j72J+cec+1l5KlyqHr5dWKKVm+5ipK2pSPfWTjNvvfFqXTLepB3t81nwBbFd?=
 =?us-ascii?Q?3iq+Sv88C2YvXrioCInfGXLYtWSzGivpwxA6HdEkc/9hp0Z+Px00LHUwMp4k?=
 =?us-ascii?Q?jyjEJ4RbzOEm7nOWMQHKk1Q5aEK68ArE2mdrU82uaYqF/8vbDeLpfiwKeqE9?=
 =?us-ascii?Q?tI3sy2F5OKfqO6rlYJcQVfIAQFZkUjFnykQakN1qUdLYTdZdEsGGzJNs0xPS?=
 =?us-ascii?Q?fozJ6wqCPBIHa8e371Uk0lrOWtYw2C+VzGDdSoX6rsE4ZAC3PZYJ7V9dKYCY?=
 =?us-ascii?Q?M3ewMvdR+PWJG8HYTedpBxW/1f/Fp/OfXQlf053OGqUpnBTijockWhpX6/Gr?=
 =?us-ascii?Q?1vhPOIkd51FnJuwo+xnTRn51vV0C7qjbFVn6ZRp0ycFNrlTGLdGP+2axoF1B?=
 =?us-ascii?Q?3OuWjXQqstl9CjDWjxZi8MQjSwcDoGs+rb2NqcDDMfp8m8xW/FutT+uhKIgw?=
 =?us-ascii?Q?DUgYh9rA4qa5kGSKZj7x1b1lyTeiBMCbI2Qi9gW4w7Ax8lmrrhhY7UOfTFqT?=
 =?us-ascii?Q?yAm7JUYb8jLolkCUW/JFoVFZ7jlzSFcu6vJ8waLLwkc0mXv7dORSUjgWLczV?=
 =?us-ascii?Q?wkg0u9PCBhSQPzVqD5v2pbxbNKvE6hxyUNROqAIviG7YkDLZhAAzglhJ9qmp?=
 =?us-ascii?Q?4Qtd/j5h5b6rFGzzXKsMBqMSUZUlTILSXf4Kuy6KG0j+dlnRSJOSBrW5fRkx?=
 =?us-ascii?Q?fOshrCRvMLNtuAolV9ovgGOIPJ+Y8ARp4w/95hsE5QZlD+/ZF1b3xolDlZTW?=
 =?us-ascii?Q?scf1n/v6cIbpPQSUFoki6t608GbvfmlVAucI9jSt7oeR9jfGowUAP5HCybdb?=
 =?us-ascii?Q?I082v1WlSQGoqzPE9+Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c951107c-b8d6-4684-791b-08dd821ea5d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 04:23:49.9335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rgrXpjSsCiJBUSbqntLFMRUR8IfM64/URk3jlBV/DgKyQs/7VYDk5gYAWQoZm+rygLZgx9saYIn3x5+7P+Pt9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5833
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Hawking,

There are changes in fw again to report voltage in mv. Please ignore v3 of =
this series. Will send a fresh v3.

Thanks & Regards
Asad

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Tuesday, April 22, 2025 12:06 PM
To: Kamal, Asad <Asad.Kamal@amd.com>; amd-gfx@lists.freedesktop.org; Lazar,=
 Lijo <Lijo.Lazar@amd.com>
Cc: Ma, Le <Le.Ma@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>; Deucher, A=
lexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v3 1/7] drm/amd/pm: Add ip version check for smu_v13_0_=
12 functions

[AMD Official Use Only - AMD Internal Distribution Only]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Kamal, Asad <Asad.Kamal@amd.com>
Sent: Friday, April 18, 2025 22:06
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Ma, Le <Le.Ma@amd.com>; Zhang, =
Morris <Shiwu.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Deucher, Al=
exander <Alexander.Deucher@amd.com>
Subject: [PATCH v3 1/7] drm/amd/pm: Add ip version check for smu_v13_0_12 f=
unctions

Add ip version check to use smu_v13_0_12 specific functions

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 6d84257b5301..177c55f457f4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -748,7 +748,8 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_=
context *smu)
        int ret, i, retry =3D 100;
        uint32_t table_version;

-       if (smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
+       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 12) &&
+           smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
                return smu_v13_0_12_setup_driver_pptable(smu);

        /* Store one-time values in driver PPTable */ @@ -1131,7 +1132,8 @@=
 static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
        if (ret)
                return ret;

-       if (smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
+       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 12) &&
+           smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
                return smu_v13_0_12_get_smu_metrics_data(smu, member, value=
);

        /* For clocks with multiple instances, only report the first one */=
 @@ -2496,7 +2498,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct sm=
u_context *smu, void **table
                return ret;
        }

-       if (smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
+       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 12) &&
+           smu_v13_0_6_cap_supported(smu, SMU_CAP(STATIC_METRICS)))
                return smu_v13_0_12_get_gpu_metrics(smu, table);

        metrics_v1 =3D (MetricsTableV1_t *)metrics_v0;
--
2.46.0


