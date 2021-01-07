Return-Path: <SRS0=Ke3f=GK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC051C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 06:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73E5922CF8
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 06:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E5922CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0F4389805;
	Thu,  7 Jan 2021 06:25:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 311FD89805
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jan 2021 06:25:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=et9WIvU9LNxMPtibOpaztCySHwjvlfGgkcXsXtBOj4Kk4C1YdcQnPsqSfaJo1Rx1O0goWJIshuAVsBVWRM6eKb7bGEmNz1rKQOAI9d3VTsYWL6AX7YTzy+2clqTfXLStc4rnLqXbrhi4bwi834ji5eaNv0KXRgHkuP027kXqLc7klfOMy6Rc3U5j2tKl1fRvUXlpASlYVoq/PjFLjyS+en8lgH7l5ev+J5TgLekYfxiN2zMahCGFJGtY13CM1X+eYZ/OWWv/iq8mJD5GhfkjRc6u0Qf0uABR53E6EVqW1qm31nd3Kty6EIxpl7IqfbtGbkmU425MIJifeJJCv32tDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBhMV1MLNrkIx2v1DyoqpkP2OjLF+I8uTPLqISdeV1c=;
 b=E7i8idtA4g67czi0YXxlCe6IJC5AMFryt2qJVKTY61uzewOgAeokDcmeg8DkEFML9X3NQl5DW7Vz/3bVPwCJWqkHFoH/u6BroZ2NFvCxlCDvFsgAJ7vK2MwCL8jOA+uUX4Zczp665snazIoUvamW331HiOJchrYpqzGNyqeb8+/i3QtbKx0uvqokY9Tj7ya1dL5HKTlQyOsXJgXN1CXqZuDd2kYUO0nFczlq/jPn3jZ5PJuQF/SzkmP788p5gdEPAn/b7fdhs/KRbtKhie0ZeEJEYHYjKLWpbV9y70JCZ9ZHSJsfR6WoaAfy7BNES1zmxInff9ac0W7vhmkKZTqM4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBhMV1MLNrkIx2v1DyoqpkP2OjLF+I8uTPLqISdeV1c=;
 b=XxVA2qcqwvsidpVETjZEqNnlDbZFD0XH4GtupO0JI6+ITGEaovM1PvyWjKLIaxDPvz0UKmap98/Ld4DhJQ1eUqTEuf0aX9p2/wj+stN1TTIIBP5ufXUiUAyTg5RsY1YaZ/hHnIEGCQdXY7tm9eKmt/m1Drja0JlZ6nO0xewAFy4=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB4888.namprd12.prod.outlook.com (2603:10b6:a03:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Thu, 7 Jan
 2021 06:25:39 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145%5]) with mapi id 15.20.3742.006; Thu, 7 Jan 2021
 06:25:38 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Zhao, Victor" <Victor.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu/psp: fix psp gfx ctrl cmds
Thread-Topic: [PATCH v2] drm/amdgpu/psp: fix psp gfx ctrl cmds
Thread-Index: AQHW4zeYvUEcEqMmtEyRCyWEaOllCaobtTYg
Date: Thu, 7 Jan 2021 06:25:38 +0000
Message-ID: <BY5PR12MB4115781E7D76AF8FC201AC7F8FAF0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210105075053.4986-1-Victor.Zhao@amd.com>
In-Reply-To: <20210105075053.4986-1-Victor.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8b64c91e-1fe1-49a2-b790-208bd45e1090;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-07T06:24:59Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b148d93-a04b-4e8c-6477-08d8b2d50d0a
x-ms-traffictypediagnostic: BY5PR12MB4888:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4888F6499FF26E0801B667378FAF0@BY5PR12MB4888.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IdvMIX/hLJ2XRhsz4L5MazNQ+0pAfoaszgi/Zj7d3gMi25gpNrPJt+SON/tMAouDT3ItuWUy2ZSLornEEfqbgEbXM5J6WqtQ1kLyek8x6TQ578uKRf/dnQeKOQiRqh3BO8RnwVnE+1geSf1WCGafFjdaI3vVCBDFsl/vHFqDB8ygL2B2MgvgWrYJ8jq2iH7l72UvNWY//fgy/r7hkcKn33lRJc2WEvxgCgrXl4jAC+fiGPXICBPtTGgUPMSWSR6lv3jBi/DKI6A6QznssDzSZf9iH4W3vdBTPAoTC9PQKdQg3iBho6U7EE3MVlT/LGoEUKu2QCUU8udnRrlnBGI6EW4q46r0S18srno8sYZOqKpLojQeHOBkf7cWzgdWTmYnPTJ2OhFdWr1py3/WEOC6D0/v6U/ATBilVkzNAtE4oxfxu9+8A1ce4GCiS0A0hp/D4Q8p9Pnv7HWM98LeUhc2Zw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(5660300002)(6506007)(186003)(45080400002)(478600001)(52536014)(7696005)(316002)(26005)(110136005)(71200400001)(8676002)(4326008)(83380400001)(33656002)(76116006)(66446008)(66476007)(64756008)(9686003)(66556008)(66946007)(2906002)(55016002)(8936002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XKyaQfBFZTBwRvVDkPURXtDMeuAVcaxE2mNoM+YhGuX0RDGq70OK0FduDRPU?=
 =?us-ascii?Q?jS5DikuMWG267RsVX9Ul46XimTQj+gB0khnmc3L4HIO5dpO76oCjAjk5WOnp?=
 =?us-ascii?Q?wWKPGXw+KZ0BN4hgguVwsIcAR2rG4YW9MkE/eRCgL78b5bdxqB9eP7p5I8H7?=
 =?us-ascii?Q?pKSmr9QxzWtGj99q1/ttOsbQo12qruvYsMD7ovweLEVUxzy9CIMNDQV8Wmpt?=
 =?us-ascii?Q?gP9f65GySQ/+xIhAxuayp/9p+2xrUViokZMTrtX3ys3U/1liCEaKqfWrCCq9?=
 =?us-ascii?Q?wZmKl2V6/DnL5MRs/lnYB+ibwG/jTHwGdg++gz1tJSxl7XoBe1Uwur6/mK3x?=
 =?us-ascii?Q?Oh1jgc71jwt2BE/Z5qPCCSAtkwYaMSWdoCfB/VAD33SvCKxuvvFKRVb062iC?=
 =?us-ascii?Q?gEsc+jOuMLv8M0Ym1brz8luvF2J8oWdY5gUFSNi5ST7sXtS2xtq7uf/3wIre?=
 =?us-ascii?Q?HbxwhUWXSsonBIvDpuxxt2m3iWaGflBJ00qNHODGA8df9rQu0gFXxvyx4jEY?=
 =?us-ascii?Q?TZWm6nb4o4bF3dqYQ5Ok+7Ow67O7faQxA1gHuP5XtQLNkPxuRDI0OlEurl9H?=
 =?us-ascii?Q?tu6c1j/0EfyPuip0MnPPgTQu1Nd0FOnfiJDxI2nFTH0LQS65+otZtZCICP/q?=
 =?us-ascii?Q?xQ8cYfAc+BgSa27ZGOH+XbXd8kX6fTrx1qzU0Lk08UuoT7OlejY3QuDL/uh0?=
 =?us-ascii?Q?EPJqBIMgCn4mW1wtaEzGebGOlGgr1ggsOXDWJgFHSqjOsji0UlmXpX28/aLY?=
 =?us-ascii?Q?BurBMeUjWJcU1QsdOwfLIibbJKanO020+upCpTMJUV6x7lCHW8CF5C1DGEhD?=
 =?us-ascii?Q?bIghgwfX77VphssAd4GbkBJBGvvxDJ/R+aAsc/7/LyTZZ2o7wewi2eCaSTEY?=
 =?us-ascii?Q?pr/OFOX8y0ibOsclnr+LmH5d+CDHzXGs99JccM9ivRHUwIwtz59fnzPu/xZH?=
 =?us-ascii?Q?4kGjZrVRBthV2iQJGkstk4iBNzMKwkCJTxTn2vO3JpU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b148d93-a04b-4e8c-6477-08d8b2d50d0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 06:25:38.8492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gv/SC8aHbyT68BKF1SNB1rGm9FCcvlBqvwctODUm3Ps9kR+1JgRD2Ezla524A19R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4888
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
Cc: "Zhao, Victor" <Victor.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Victor
>Zhao
>Sent: Tuesday, January 5, 2021 3:51 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Zhao, Victor <Victor.Zhao@amd.com>
>Subject: [PATCH v2] drm/amdgpu/psp: fix psp gfx ctrl cmds
>
>psp GFX_CTRL_CMD_ID_CONSUME_CMD different for windows and linux,
>according to psp, linux cmds are not correct.
>
>v2: only correct GFX_CTRL_CMD_ID_CONSUME_CMD.
>
>Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
>b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
>index d65a5339d354..3ba7bdfde65d 100644
>--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
>+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
>@@ -47,7 +47,7 @@ enum psp_gfx_crtl_cmd_id
>     GFX_CTRL_CMD_ID_DISABLE_INT     = 0x00060000,   /* disable PSP-to-Gfx
>interrupt */
>     GFX_CTRL_CMD_ID_MODE1_RST       = 0x00070000,   /* trigger the Mode 1
>reset */
>     GFX_CTRL_CMD_ID_GBR_IH_SET      = 0x00080000,   /* set Gbr
>IH_RB_CNTL registers */
>-    GFX_CTRL_CMD_ID_CONSUME_CMD     = 0x000A0000,   /* send interrupt
>to psp for updating write pointer of vf */
>+    GFX_CTRL_CMD_ID_CONSUME_CMD     = 0x00090000,   /* send interrupt
>to psp for updating write pointer of vf */
>     GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING = 0x000C0000, /* destroy
>GPCOM ring */
>
>     GFX_CTRL_CMD_ID_MAX             = 0x000F0000,   /* max command ID */
>--
>2.25.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
>reedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=04%7C01%7CEmily.Deng%40amd.com%7Cb32008e7e8e1447
>797ab08d8b14eb089%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%
>7C637454298972763193%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
>wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;s
>data=2HlggVF4%2B20Ceom5OBfyr0MXYdiLMblwgUbl%2FVEeqII%3D&amp;re
>served=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
