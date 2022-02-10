Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E99AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 09:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A80D10E7BA;
	Thu, 10 Feb 2022 09:59:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42C8310E7BA
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 09:59:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWWFWfIFrr5yoQiFz/AONZ4cMp+2EwOHby5nTgOvy7l40yHVHTBLfm+Ir8ylfXWk5srzj/BDjAf9710dLsKDFkahRk0yqjK8rd6EkD1aox8QdL+QGqClCezggAzEnV9L2fPKBQ7H/dO9qml5ydz2N8w+bvyH/fQjcW3XUUeKVV6hVsjU99BJzGc8BQq1qvW4sUYatCTvp9XKUYqAmznfTj+gXXVD/mn22zRCm6AyFN8RtdorZ+tBG/H2Cx/Ty9OCZEJYrW+KYQiXcehzgujiO6vJbozi4k1wiXOMmBmMplaWPcHDIpLjeIzmv6PRjpC/B9dEQRk9XTuBxt8IQLZtWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0EGUkrPEcG8MP90KVvZ+fpDMqjy8sAoHBEMe/9r6eI=;
 b=XdeAVVggdtIVMJO79BscaiJDIrhrHGZRoxYwMkgAKKOp7KiFXgjzg0kaJzK9IbtvfrRNWkrcF+/4EX6FJ9DUNNWR3FgXZ5Js7hjBTQrVjhVgHktpR+eEzvk8J0rnxBqCQM2CbZ5Z9LpZmAQlPwpsCDRc5kKF4/o4NsbtzMZaYfeFV7WTWoMEQ+CdhkVYzucXJveYB6QIwfJRk9rxF0Wfa0zmcXy5yZZ4DLp1ONq+rsqL6ExRnRJ04mVbVtSl6TH7/8Xrlm9rQDmgpoyY7zr4NNiqyFEMEoAQ5HwTF05fxaLyABb2W/d8JMV8QU36UfF9Xzkz1z3iptjjNkxvGCUUyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0EGUkrPEcG8MP90KVvZ+fpDMqjy8sAoHBEMe/9r6eI=;
 b=iTFzhaoulEytKuxKL8WdjPvYjXzLaSFxW5PdbYiR2WfB/WXb5uo3jT7a9+dALKTUyz7asidnJegEvIo5C+eMnjP+E8wJQJjXv11DevDotXaL57BPh4Kby1ydQdY48P34yYNV4pwb7+Iy7ORWAwNjeOf2acqQF/j6ISAvbzsMJFY=
Received: from BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21)
 by DM6PR12MB3817.namprd12.prod.outlook.com (2603:10b6:5:1c9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 09:59:24 +0000
Received: from BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::2d85:a89c:7814:f724]) by BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::2d85:a89c:7814:f724%6]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 09:59:24 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Clements, John"
 <John.Clements@amd.com>
Subject: RE: [PATCH] drm/amdgpu: loose check for umc poison mode
Thread-Topic: [PATCH] drm/amdgpu: loose check for umc poison mode
Thread-Index: AQHYHldyZSqZnfiz4UqB7ubyVHHEoqyMjP3Q
Date: Thu, 10 Feb 2022 09:59:24 +0000
Message-ID: <BL1PR12MB5254E19C56332523E89184FAFC2F9@BL1PR12MB5254.namprd12.prod.outlook.com>
References: <20220210082256.31081-1-tao.zhou1@amd.com>
In-Reply-To: <20220210082256.31081-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-10T09:59:21Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=48cc078f-2d94-4036-89c8-aa32f2d33a6d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 460ea82b-377d-4c49-c9da-08d9ec7c04b7
x-ms-traffictypediagnostic: DM6PR12MB3817:EE_
x-microsoft-antispam-prvs: <DM6PR12MB38175E0CDD90D6268D2B3DD0FC2F9@DM6PR12MB3817.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZvmVdF8PpveqFcOYqd0QbQRUdpceaQEtG+xkJMeLd+cxkW2EgPRh3+bA91rVB8X2Ke88YKpK3yW/SLS0LECvWcdpEfsW1SE8rsu4Ab4LevgbOfaADwIm4oSspFN23G00hSGXbwDClSKOdN/snxFO7PZeD6/1tzjsrGbim0QCBfgKCFto7fByBkxN2DNBgNQ1xxo9iusEhNGoaNcPsT8q/fntP/0sPyygdv3jfzpt2UKEC6oB/gB/WEhcTUa5tZoertsgxiAhIA9wKwByG3zGjzNZRriVISvbJTnXG60jvqBev8oIh2J7Bn15vN1Pfh6k30pDwtvIy+40jIL9s5zd/Io18v3PSAnLUO+qBmTTbOXUkfL9MUl4kvPgUfaX7i6kQXc7a9vnnGSr5ju1DAsB05SP/Lcr7veNMVyVzFZhxh51W8rA+zJ4PTJEEZ3/4nW1fJtENjojoSysu7PHmd4P1kF9unPUJPAxiDNJ+482Xwer1v9ztqyzo8XOPMEN3WN+uHAiIt2eke04qPWZqtNMWJPrUQVbTsx9jlrWBCbVrE4cjXCdUtXgk06Su+qQeUE8E8w6DrGTeUBpO1AHsqLJjQqVKcOpMa244bjS5NfVGN8CZl4bQnxiry0Wo3Nr1eiWp+0y+y4ktEGS6nQtT3S7h/73PuygClNgmo7Eg99R8QHXjOXJhnqbRxV03eY4jrvwSEH1fqBF+6kc6yHEKdupdA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5254.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(55016003)(508600001)(6506007)(110136005)(7696005)(71200400001)(86362001)(26005)(6636002)(186003)(33656002)(9686003)(52536014)(83380400001)(8676002)(66476007)(66946007)(76116006)(8936002)(64756008)(5660300002)(2906002)(122000001)(38100700002)(66556008)(38070700005)(316002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2SZDEU1hpLMPM410Zu8NaOELtNj5PpI97fXgXS64XBJO52Y/XL6JyIq4bkBf?=
 =?us-ascii?Q?atGEakjggCVutKLS8zt6CKCZ4Q5GgGnDRFFEU0asZtWTebnwukpX6ESP9WgZ?=
 =?us-ascii?Q?UU6x8YKX1akrA4J0GVHNlAdUevsDvGH5cyT0nRsOFXjGzj94byLOV57ff/By?=
 =?us-ascii?Q?wxNt60V9w+WDROzIqCxu0rQxCjN3a+HSdlEbmOjTAg3sB5BHVXOzWWKpbJF4?=
 =?us-ascii?Q?glS55ldLLu94VNSAMY3nGDvGb25g9cfVGsHd8wCpW2wcOZhJrrJTFupPspYy?=
 =?us-ascii?Q?OWgod5SEi8k1T1R3xe1c9sGdUJ5Zk3gKdeKqsOLJy0jDwgtyaYP1C2rXcJ9H?=
 =?us-ascii?Q?rjwrbPclOCbLSsCT9Sha6H9upJrIoYISGfDU8YieW2KZyofqKjhT630QbNw+?=
 =?us-ascii?Q?M9T1DQlkJrZ1gpDb16ObSZyd90NK7sJ6XXjiMOM6yfcAs+nYVqmrVz1B1BAt?=
 =?us-ascii?Q?SdEr6HR4FCYYWa2FpryFoa9IcoMkz5NNQ/I5Nehq8LJjOcBROB/4ljfbBtc+?=
 =?us-ascii?Q?KnD+v9FAOmtyxjYk6jNM5dtTcwbFv4JXLh6d/IoZ1m9BXxFQCfmd22RHVT7O?=
 =?us-ascii?Q?wNIZPM3er7+Rjf+1VqhmLLc57ODDHkgyrTlgZ2xhBMd5t6GN5HR6zX90adei?=
 =?us-ascii?Q?ETbZ6ZNty27nalQPAOlVOCkGD40k0uNDrTHWnhokaSJM8pdNB3BHekLVB39q?=
 =?us-ascii?Q?Q5dVeg15C7g51QArgEkMdjT6SnqGAw+48olbFz0goEaNgZh6fcbThCGIZPoE?=
 =?us-ascii?Q?Kj/apcWfVlpOYnXpGxh4ZGIos5I3dAn2WbHSnPPE3Dk/wPdkVNm+dhgiPI1y?=
 =?us-ascii?Q?1hnaVi2zfh9uCiMRZDSw9hoDjataELvGspBHMghe2qFlnfbvtiwMo736LTEw?=
 =?us-ascii?Q?w3eEBj9L2L/BeCGY7/1GfzdKZ9/8UxoC+opEBfJi/HfhtfMFcb2ro0Dbs/Ka?=
 =?us-ascii?Q?GnBw3Yq+Fe5RNT3EwpF3V9jORgncuFQMAl7BOZjz5F15q2zr70lWrwYjCyOU?=
 =?us-ascii?Q?m9W98FEbpQgup76v5lFs1Y+bEBiEndSHcBDnbsZbG7NrQkyaj2OCKGdjxm96?=
 =?us-ascii?Q?1tctf/ZLKlUAGhzLcnX4g7R9NPT83plprWQj4Xsglk75KsI46PsiWzNyB8DU?=
 =?us-ascii?Q?1waJvxfnOw3fOH5yp3T3ER7df7Ga0yY3uB3z0NFxrSPXBmm2Q+DmS/pTzwx6?=
 =?us-ascii?Q?ovSYQUmfnIVa4Yq5xgAj+0JoZFa/cL8r36GFLLpIelbPK6DvZHzgCuDemo8l?=
 =?us-ascii?Q?uVXPH10rV7izErMwYeGgs8MShadbqtcYZuru8d841sqouWMJ8wrf1nsoCmWg?=
 =?us-ascii?Q?6Se+tSraXbAMc8Q5xCY7pDI3rCGy10/js5cKXgZf9YC/jO2Y5Zvwy362KICQ?=
 =?us-ascii?Q?mtOwp0+Jvz2QafEHdZLNi8N2ZcQ0RrFtVWdA70uK3nRnVF1pm0UeS9Pi4q8/?=
 =?us-ascii?Q?ugdFkmjBA97XBZgAR9bGe11vAtdHf0ZmYjP9JtQURTsFubMMwqZ/3XV+AWCO?=
 =?us-ascii?Q?NUTWtytE01cLBbT+zt3pc5AN7NTso0aYes7cYNgqSwyigxl9FbjsSiBZ115I?=
 =?us-ascii?Q?CiQ4BzYdLAJLR0A3WWpfVlcNL4M1jhxe1LDgksv96mxcpOHFeK0w6UfiE68H?=
 =?us-ascii?Q?f/JtOJg0BVYTmpDS8cCwTxg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460ea82b-377d-4c49-c9da-08d9ec7c04b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 09:59:24.7171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IZMsd4PIxHUEgOn6gm5yYH1nezdgWX4ORtsfiygzB5GYv1PioXaPHtddusODf6zB8w97H9xYPl0pi47sN8Pc+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3817
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

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Thursday, February 10, 2022 16:23
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; C=
lements, John <John.Clements@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: loose check for umc poison mode

No need to check poison setting for each channel, check for umc0
channel0 is enough.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/am=
dgpu/umc_v6_7.c
index 47452b61b615..e613511e07e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -451,21 +451,13 @@ static uint32_t umc_v6_7_query_ras_poison_mode_per_ch=
annel(
=20
 static bool umc_v6_7_query_ras_poison_mode(struct amdgpu_device *adev)  {
-	uint32_t umc_inst        =3D 0;
-	uint32_t ch_inst         =3D 0;
 	uint32_t umc_reg_offset  =3D 0;
=20
-	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
-		umc_reg_offset =3D get_umc_v6_7_reg_offset(adev,
-							umc_inst,
-							ch_inst);
-		/* Enabling fatal error in one channel will be considered
-		   as fatal error mode */
-		if (umc_v6_7_query_ras_poison_mode_per_channel(adev, umc_reg_offset))
-			return false;
-	}
-
-	return true;
+	/* Enabling fatal error in umc instance0 channel0 will be
+	 * considered as fatal error mode
+	 */
+	umc_reg_offset =3D get_umc_v6_7_reg_offset(adev, 0, 0);
+	return !umc_v6_7_query_ras_poison_mode_per_channel(adev,=20
+umc_reg_offset);
 }
=20
 const struct amdgpu_ras_block_hw_ops umc_v6_7_ras_hw_ops =3D {
--
2.17.1
