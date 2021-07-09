Return-Path: <SRS0=keof=MB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CF3C07E99
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jul 2021 08:38:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D6B613CA
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jul 2021 08:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D6B613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D37936E9E7;
	Fri,  9 Jul 2021 08:38:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 080E96E9E6
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jul 2021 08:38:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJLDGe0FWX3gl943k4uo3nLg46BH7u8H7GkQK/J0kI8vYqayC5ouUNhL3GAKh8EoNNL8RoBpdd467a7v7oTWCv6UifK2G5dkjCuMuuhR7UjCgqtoA7upLUNrggw1H9VcpED8YIgQ3hICxh7VbA6srtAOGWQjcEhyXn7Wbv0keW7FVnhYsn6Pa7ma0fiVqAnIV0gU03gS5nUM1C3YrlWbL1UU1in0kwb7dyPCxoG0nOlMFDQI/39fC7vaLSABO85D7pxiL1MLVm2Byk5ZP9sgNR7VKZ5d8uNQ2I2+rrRhLK/rvwfkklXDWkDn15Bu+aJbgzGtONHLFmysOzfCKPqfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LYNiib85LPNh6RI/1+aEAu3oiOgSvcKdo5bfJXhmaA=;
 b=Ub5/WsiT+qCzVSJlRy8Jee6T7DK02emjn1ThaODmBitDI9Pj/U3BPDHaZRXPZJpBJn+6zXIjMB/rKNHnLf0/DR9tiWh+0R8SK8SO+aWrszk7ZYEKIwsoh5HreOYEMu4lAFyO5+SUoIS85clEjxMx2lqGY492GO3BQ5/3Jb/5w0PaLfdUHyufXpMxavxH2tMLRjL2eOQnFRA7LJEgaEYQKcf8639ksfBahroWLq/cLaZTaw6Q/mLOU8g4vkVbzz64bJrOCSd9AlZOf3mKU3uuv5dkuMF2PtZgIfjlp7q3OXywRcSt6jCi+ajKPo1X7cMsDkE+vfPUm3CDFSGej52j/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LYNiib85LPNh6RI/1+aEAu3oiOgSvcKdo5bfJXhmaA=;
 b=U1rfoX3pQ7bwNBYd1bHmXiVdAmcf5aDIGv4ggh9ptvG7eRmWiGfV5y0iOXDbjOdKuWsBdrWdUld28Jp4fyKhgkWKj5lKwiPNi9nidUZ2q4gLLJeF+g1i61CLy+pVtHwVF0u84fp3Jn05/EPvRWOMc3NKP+2bwUzxz/Ioj/svHpg=
Received: from BY5PR12MB5557.namprd12.prod.outlook.com (2603:10b6:a03:1d4::18)
 by BY5PR12MB5557.namprd12.prod.outlook.com (2603:10b6:a03:1d4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Fri, 9 Jul
 2021 08:38:31 +0000
Received: from BY5PR12MB5557.namprd12.prod.outlook.com
 ([fe80::303b:d360:bb4:113c]) by BY5PR12MB5557.namprd12.prod.outlook.com
 ([fe80::303b:d360:bb4:113c%3]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 08:38:31 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Gui, Jack" <Jack.Gui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Fix BACO state setting for Beige_Goby
Thread-Topic: [PATCH] drm/amd/pm: Fix BACO state setting for Beige_Goby
Thread-Index: AQHXdJx0WIqqsyrwu06pH0FXcgXlEKs6UdHQ
Date: Fri, 9 Jul 2021 08:38:30 +0000
Message-ID: <BY5PR12MB5557061FECE0FA66619EA8E3EA189@BY5PR12MB5557.namprd12.prod.outlook.com>
References: <20210709082833.21494-1-Jack.Gui@amd.com>
In-Reply-To: <20210709082833.21494-1-Jack.Gui@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=0f0cd225-f741-4d22-8a5b-2f722d6bdc53;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-09T08:36:32Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed6b9c9c-0892-43ac-eb78-08d942b4ee59
x-ms-traffictypediagnostic: BY5PR12MB5557:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB5557A1BF99455C0BB1486F17EA189@BY5PR12MB5557.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LKzW6LxnKp4BLFuZCx1nj9nnR9XBkRWnIAMwNh74mTFUoLcQKJlXpImzpZPS0/gEVRK+7z7lj2mSuvlGz2nwi+fFk6Pvg4WTJOGNB4bVznSBt+gvmAzOOgR6glJfJ42PRt+u1q62rLnlstvLKp0lqBpFL+WT1kttdmHZc5FuAOxyPh1WvO89oUgzT+LiHAAVjKS6+spflu8TBNKdb/1DHevRIDYAY3WSDNVEzfAE7HBxQ5D0rkS7RRBe8+RhHHs9nrvB4OF9IqdDxpIhFk91Mge5CmMYJPur9B9lH+KXEjE8oY5TblvF6geT1RJLwfQwiW8U0USFo6rj3Fd5q6p17p2r7gPaQM8atJX9a1CpIcQiTF6VElvYjZoTWtCJqKLRDUi61KgJ+rxv6/yK7HKEAmPeeDKX598y8r9DGVtRJyQ0JJ0Cklt3yQGDd0dPfhM0pLYXaDaofPygQuNbGR6aW2LlWFnqzkO/JSJ9g+bQ8K3jeJz+flHSBnPf49L1iy0A2RwdFSIHJJ+4seg7wh+GKPAX+eqfwwrC+rsk2sj4cPHEfBEEVACKz/sp/qfO+DcEj2cVsPWTy9QXF7ZPiHPE4QaPh/xnHC0Hizy3NLuIQTOc1NhjAsDO7L+uOC7hqF8PatQnf+VXVLUOYsp2yhUlQg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(6506007)(71200400001)(2906002)(5660300002)(83380400001)(64756008)(55016002)(53546011)(316002)(54906003)(8936002)(110136005)(7696005)(8676002)(66446008)(66476007)(66556008)(478600001)(26005)(76116006)(122000001)(4326008)(66946007)(186003)(52536014)(38100700002)(33656002)(9686003)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oKbzBgrJ64qM3/vIuR3Rp45JNydjVdpZyNFgGZWqI2SOCw1vs+d5j1OW+qSa?=
 =?us-ascii?Q?gMY6bdGvv4PHdTxlpOQLwsWdFrVdtqpCzqJzXo5RD1CnR2FBPWch9FM/puXi?=
 =?us-ascii?Q?CndksLgLpKhksnjyOt/OIwGlCTM/qaTRRsWnCWcZEjL7jqYvn5ovA6loQ8/B?=
 =?us-ascii?Q?DY16Mtz8em8TF+cCkLt2BOw/EUbvbmXtrZev82k8ekcwVefFGH5nu5Gh3Mkw?=
 =?us-ascii?Q?ddK2rTVLEoaslKLwLb/gty6NH6JLZsOyI18+hJL17NusQVbdCcZQ5ulhbaXH?=
 =?us-ascii?Q?DhVsOLodcQBrDGjcmLdIzIDUU/tG378ufRJOHVcV0vO+PhwTVXzgP6Tfb1Hv?=
 =?us-ascii?Q?es45k32GeexBkElguijwh+EPH2vX7nmGCwT4mqpP2qLLn+FzidiD+fYtoayy?=
 =?us-ascii?Q?MmovW8k0Ha60hh13uRC6e/26oEW3iBBPgNTYQRyq5zq/992+sw2xdi8nK5Yr?=
 =?us-ascii?Q?g7Bg9AHz6/kC9kQSCs2imIBkolAn9+KiDDuJziOYS2RUP3lrEI5mImTrpBfF?=
 =?us-ascii?Q?llQbu/OGBh+xTAm+s+U9D6ok1kuprmhQSLJur8IqOTxcYwuicEige1ZkX2Lm?=
 =?us-ascii?Q?xZwuDt8dkk9WMoL4eibzWCPefH+cd61bAn01N7GU2/AWwwDWy50IU1NXrL4S?=
 =?us-ascii?Q?H2n+iGbtmWt3yuFuXUunIsq6YpaHoO9OfMazoN93l+DaQyrGmBuWXTYH2tPv?=
 =?us-ascii?Q?uP8wX+VftuBNQtjo8knBFawBPz0aNlpC7JNBFn5tV8Cj+b0nbNFrQO29g2Hq?=
 =?us-ascii?Q?J1c10uM6KlR5faOr/ytncJcEQboXDqKbUQMvJZA1dg4ZpdDDcUCUPcXfPVdu?=
 =?us-ascii?Q?zP6g037DLK4TnxXHPKp3uG5BX+CihNvtmLbUFVrxwJGqKltXjyNCRkbXBlSA?=
 =?us-ascii?Q?p40WCSs2wni9y6y96rCg9QGoXI8KqyyUjcCTburfsVPEVpUAQBKn2+X4EC3f?=
 =?us-ascii?Q?NbKOdcyPbDwp8zy1i2+y8YaRQ0ZhrbnFBmjTNaLokb/HCXrYdVlUROD5lhWd?=
 =?us-ascii?Q?aJz/g+5cgsn7s0LG6SQQcz77cdxBzQMjQ7jtN7V+3UmkazQVJM+54pEUTnWd?=
 =?us-ascii?Q?tessKS78W/PYs/PibuwBkuQR9MZsAS8UCbsV95qOPrO3a/PyoymvxCYwvKkF?=
 =?us-ascii?Q?vEmsjB0Ddl0oFe9aKzN95lAM+hUhFJIqGEUl+zzgdXyb7Z1/bYRkG7sDG4xn?=
 =?us-ascii?Q?SV/pshfGA3en2kQ+jqzR3EqawsIPMeQm8zDR5PPeRas8y3sJEM+ezjuxQVjz?=
 =?us-ascii?Q?e+POu+xGSDz+355iWhGjVZfqnQg6TsPAjeu7f/DvAMPeLKZwhzwVVWaVt60d?=
 =?us-ascii?Q?vVhhUqIh6ujV5PETph7kCQeJ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6b9c9c-0892-43ac-eb78-08d942b4ee59
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 08:38:30.5104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RzwxM/GqvjE6h7FN9WiWeB2jB4yzhximTXFEFzRZPquad7iUb1i7KxfKmH4hNAs41J7Q+bBjm8/cKCSyfdLQWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5557
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Gui, Jack" <Jack.Gui@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>

-----Original Message-----
From: Chengming Gui <Jack.Gui@amd.com>
Sent: Friday, July 9, 2021 4:29 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Gui, Jack <Jack.Gui@amd.com>
Subject: [PATCH] drm/amd/pm: Fix BACO state setting for Beige_Goby

Correct BACO state setting for Beige_Goby

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Change-Id: I28b9a526f1b353c3986225f075c613ba88b6ae2b
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 388c5cb5c647..0a5d46ac9ccd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1528,6 +1528,7 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
                case CHIP_SIENNA_CICHLID:
                case CHIP_NAVY_FLOUNDER:
                case CHIP_DIMGREY_CAVEFISH:
+               case CHIP_BEIGE_GOBY:
                        if (amdgpu_runtime_pm == 2)
                                ret = smu_cmn_send_smc_msg_with_param(smu,
                                                                      SMU_MSG_EnterBaco,
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
