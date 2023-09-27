Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297DAE810DA
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 12:26:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A481C10E4FC;
	Wed, 27 Sep 2023 12:26:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0F4210E4FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 12:26:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+2natVoJbkVQExzI1skemOid4sd0nOzmiYRDRR2RgIHJjC7C8mB5DPrToxGnkxSqU9MQyT6HTDvO7AlSAcQARRXC2Uf3oGglBbmQWix0pi1veYBLogJHJJW559l4N/VlNtTR2EP1S1ZW7OQajfkXL1TD+BsP+Iq5VjIpPNvjI8vFaz4tQrJyN2JtfoO8ugSrWlvUuxkQTunh01cze2EqykPu6i6Jj3M7PfLdlIaZhPVFVOO5js5bu6zfWl0I4C4gJgnDaXwTZB9MRznyaB80XRUqQwZZifuI8ay1HOHQ5hwWFB+9VTiJ+/Sc5Auh0Szhh/gwg+QssDoURogY5W+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qQNyoJvhoBlzlEHPnotJNhMoFzl4Ja87cLppBa36Fo=;
 b=PC0zLd3/SiogIaqiAfiYZC5fBg7FEuxWuZIiRamzkG8Bo7zoyn24G1kuohIv1CLJuIskC6qDcDQpcBtHWtpaT5JowhOYawakaEKFLdIPbtnHb+2L+cCclVge1i3cCnxsnLfF63VioznJ1VSCRaOlDBKhhoebHgDs4FHouXcZ7LdHigq54CMhErcF86Gqq23yNipfFm5AOyZarp+/FN5Lq89jv7Br651rVsuW057CKjcK1zTwqytsbecm7xDekMjgW9HrhUHMPDcogCCUKoDor6UdPyb27pYl0H9artsafKTnYapY01vaDbMCxglkl/9dmWeY2bdg/4DtIHR2xjnsew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qQNyoJvhoBlzlEHPnotJNhMoFzl4Ja87cLppBa36Fo=;
 b=zqV1Bh56c71hJk6tNfWHCSZidxkM+vx7suoLXpzHRs+BPONdRNBEAedcFhR9tSM/ZRrBR5XsVnHdFqIPhoyUNl91I7N0+z4YcLsVBNc7+r0BqFMwqpM0wUgLRJgxAaOoXXcJo1SRaEW+uLowU+/p/QUwUq7CXaz9KMA0kJqg+YE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA1PR12MB6895.namprd12.prod.outlook.com (2603:10b6:806:24e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 27 Sep
 2023 12:26:23 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%7]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 12:26:22 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: update retry times for psp vmbx wait
Thread-Topic: [PATCH 2/2] drm/amdgpu: update retry times for psp vmbx wait
Thread-Index: AQHZ8Sxi6p2dj+bL0E6BcX5z7xmhG7AumTdg
Date: Wed, 27 Sep 2023 12:26:22 +0000
Message-ID: <BN9PR12MB5257C9909484BB6EBD4BDEA9FCC2A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230927102023.7736-1-tao.zhou1@amd.com>
 <20230927102023.7736-2-tao.zhou1@amd.com>
In-Reply-To: <20230927102023.7736-2-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=404e5277-88b5-4289-bd5e-8e8b65312061;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-27T12:26:03Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA1PR12MB6895:EE_
x-ms-office365-filtering-correlation-id: b83d020c-ef8b-4839-fa21-08dbbf54f60e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N0CtZg7O5m2oI0Pe8p4bro6coOJ/kzBObf5tqSaXdkyIh2mtsqYIaivwwRf2dXFlwdM4/RdawtU36bPPSqgUeNzAvruMEIg1P1haarWDt67yov16p35QHa17nLqq+90YtaCiBu9hacOUSVpH7fAdY3kLHLoXLv0GkDea36F6HzOCL3cMFaMVxOmGeJ8JxivkFwSrURgnpyIALwNKp3dyQZtoekqwhOp09AeqZ4DghWCqWf+FJ6yo644WUZR2gX9nwb8uzgC1GDLIdXQhKHr7drdyKpr3VB/UvUiijtlQdevHTjmfj1KWahtX8CgPOExHVhJLia0Nx7ZbYKzbW6usXFWlwSOiE0AwOjhMf6oKqTXtIcAHOxbOSQv416jWFOD29q1ZUsOiBbAuanpHF3fPnZCkWdiGVjKSIhz0y27xoFDKfAuUT0FzkAmJg0lgc899aUArs5ncHHSlvbP6bxnxd5PWtchVvNo7kRLy+aGXQ4Tt/P1/jJEJ/044MSdzSwp+lc93FMDpMjqtQV2w27gBTzH05+czcBfSwuC3lkKnMSkJOt40TsHTKaFqq5fFyYwAGqGB920/SeMroCD8ignTmdc7CT4EbPADZMr7Yu7SjhQkcbbDVy1tgxlj426BUcds
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(39860400002)(366004)(346002)(230922051799003)(186009)(451199024)(1800799009)(83380400001)(41300700001)(55016003)(53546011)(122000001)(15650500001)(64756008)(66946007)(110136005)(38100700002)(66556008)(316002)(66446008)(2906002)(478600001)(66476007)(76116006)(86362001)(4326008)(6506007)(8936002)(8676002)(38070700005)(71200400001)(7696005)(9686003)(26005)(52536014)(5660300002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jNNDJo9HF/pT0eLYy3u0BMZY9PSno30qz52KHuDU9f9kzvLITTZfPbfehNih?=
 =?us-ascii?Q?0IzGvKaiM315+tfM6bhtnjTQo+yYDJtVkp1Cb1ACOoOIynfKhOLOgsznQqix?=
 =?us-ascii?Q?aVFTwI6kGG4D5so7ah9RCiC0I0w+nVGDFCu7yHRMdMSFCWQxpNB/ZQ6kR2Ky?=
 =?us-ascii?Q?7C/aRh6RvS4EBaBauRtLYFc2e/ixtrfVnNxuJNvC6WkBy1tv4EF6xpg2vP7A?=
 =?us-ascii?Q?tCcvQgko4B3lpj7cpeZRcHs/9xnKlQ42TF2qv9vxDuaNxDMwv9o2XEFJKUt9?=
 =?us-ascii?Q?e30Du84PJTeHT5hki7XFfNsLtp5ujQ7iUqqsRS20kLO6zCPfsAr0CuzYl5ua?=
 =?us-ascii?Q?ZoGKtDgeKA30R2BI3VRgUVO9lDLGiHvs4ysfX/HttWmnPIB0SefKuFzJSUEI?=
 =?us-ascii?Q?JyROiSivXmkQvjCA9uaqdje6xTg8O+s3nf7Tjsx3uWzrAtyzrGoZVOWcamxp?=
 =?us-ascii?Q?4XJdhzGHBxfCpGfwafdEGXpEThTB/CFxHfrgnlfzt0WHAPEpSh9Wjje4rkxt?=
 =?us-ascii?Q?LTBLq9x+Di2HQ7GKsSvizI83SkNlf4ZoQ2KBfF92saXJH8JZb+nXFSkr/7/I?=
 =?us-ascii?Q?u3Dcg+Dfy4uPD3xQA3xJn1sCQho7Ni4NQjrMyLF/HGVvwSMaAMGIMCwWCBy1?=
 =?us-ascii?Q?QVTzj0oZWKa+v4tJjY5VqR5pdHccc0tQeX5qWs26frXtO3eMR2TVaO6EezHx?=
 =?us-ascii?Q?UNjnPYKHKksOoaPd5WGulP+qngYxCSx6ey202hgz0W0+X9icZWI/CbNxJXWC?=
 =?us-ascii?Q?qdPkNm+oP5XxXs50eEyBoukNVk1Y2eNzMYNVDJ3K6G0w3qf2GyCmpaUwJL5Z?=
 =?us-ascii?Q?rkQ+1LYJlYePuPYXzxxwg/eQERlgbIvoOMiiB6pBekuii4uerK35P/2OYeL+?=
 =?us-ascii?Q?1/4vKF0VFj1JtuiZv7OkSqDqpmQ4DmyTGekH5eWz8DKm2Jkg10GC21RMF9iz?=
 =?us-ascii?Q?6XbafFltbcqVTOP5rNKEOrmEO0s1Iejv+N9cn70geUXiaRm0Gt+svfd36aBy?=
 =?us-ascii?Q?R/nADSV3R76pf9TJ4NjwAOvYbEIu+w05xYKp35BwSEXuxtRGaVdIHhE7NSe5?=
 =?us-ascii?Q?OqpSW/pBHql552/zEsBC522uFB5LB0cQSQylFzOflQP7hOngKCpeBTfrEPw4?=
 =?us-ascii?Q?Nk6EXnwayERiYRxuJ/c2i3wVtDlVnv6Wvzmvjw9LkAFc82rw+ufws78FpY8v?=
 =?us-ascii?Q?QTDthSv2c7mhhrzhyFywRzikErS0jlWnh9iVyTTk4PBqyLGC5aI6L8VuZA5H?=
 =?us-ascii?Q?snmLhQcCuDbrJ4gKsfhq1W1IIIBuh6BkVGvur19GdNqWR1RB8fXabjHo67bM?=
 =?us-ascii?Q?3V9JE6qJE85Xwvq0WFFQ7RchATvvtXT/bmzrgxGjD93cqQoy+EXHkTwVLfsh?=
 =?us-ascii?Q?hlx5YqxveqjgZoACCi8+NEInEK4oQLnaHq/GtJJ/JnYPrJzpgKRUBdp8Wyha?=
 =?us-ascii?Q?w1mhP2GisQtVrjscgZ8Zx+mvVL9nLyEjCfpt6XwVEeZvuSjLrCpQ3gC8U276?=
 =?us-ascii?Q?8DWhjSpaK3PN42QOw+Xfs/njuz4EDL1jxWIXIC1Sz1IfuQ9K+80Kh8qrFuOE?=
 =?us-ascii?Q?YKHoQOytR/W6tn9wYUwEKBpZrU/VAJH2sP9r5SOc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83d020c-ef8b-4839-fa21-08dbbf54f60e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 12:26:22.9383 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X1MWh1/XyTnHszOPTg4RvZTG8Gaj8DVwhRhbEyPha/SDKzhO6hNq24IJXSSH8jZLbzZ1GdJ7nW0xnvxvue7g5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6895
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Wednesday, September 27, 2023 18:20
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: update retry times for psp vmbx wait

Increase the retry loops and replace the constant number with macro.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index 54008a8991fc..b7bc00d4c696 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -59,6 +59,9 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_0_ta.bin");
 /* Read USB-PD from LFB */
 #define GFX_CMD_USB_PD_USE_LFB 0x480

+/* Retry times for vmbx ready wait */
+#define PSP_VMBX_POLLING_LIMIT 20000
+
 /* VBIOS gfl defines */
 #define MBOX_READY_MASK 0x80000000
 #define MBOX_STATUS_MASK 0x0000FFFF
@@ -138,7 +141,7 @@ static int psp_v13_0_wait_for_vmbx_ready(struct psp_con=
text *psp)
        struct amdgpu_device *adev =3D psp->adev;
        int retry_loop, ret;

-       for (retry_loop =3D 0; retry_loop < 70; retry_loop++) {
+       for (retry_loop =3D 0; retry_loop < PSP_VMBX_POLLING_LIMIT; retry_l=
oop++) {
                /* Wait for bootloader to signify that is
                   ready having bit 31 of C2PMSG_33 set to 1 */
                ret =3D psp_wait_for(
--
2.35.1

