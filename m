Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767B9C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 06:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ACE4229C4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 06:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACE4229C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAB7B8987A;
	Mon, 18 Jan 2021 06:45:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D63C8987A
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 06:45:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bB22Pi2+PmPmPri/zL3kUY8Con45rj0esf2w46ayOTXgb144tOwrI2yl5KvJ/FyzecQK5PbzYDcaWJj5BQ3vTITcqLxW1s5mJjscyzGenWKP5h+EQq1h5xe4lJjqboK1ZGsQwJXCqCA9BPC6zJYr6UzsENJi/FD9XUCp9jm4QxfEFcmhfiJA/1xB+BXYAUvBuyp889PjJXMVWDuyMrWBc2VeaHLRCZTtQ3T7i/c7Eabsktv1Tk2nIL0vHe6Bb9Sz76uDFogdWQkvCEfmkbLLt7nq9TtU02i/IXf7NeUF40dVP8gDZ6xmI2xVNXyj4atwt7EL+xwvjJr8P/shsy0DDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hx41hJU13B+XcmZre1CQ5YaNYx92kx5WwEbVDm1LrmA=;
 b=S9P9pGXMgADnC+SiX8SvPyEfY4jpWxbL92RfPQ57eKp28S35/TEfOHHSVMspD/hYw0yFPJ4oYOlVxuO82IboLKP5Df0JdwiLhyVTEzGCXqfPmIjmjFbvnSleSiav6uX/cq94wqg2EcrcDWCQmbPgIw6NnCC+SS49hABp4zsiRHId6xajpfZir9iHjfVUvLwQtklLqqNw7U+CTL+WEO7Yy/icGg+llcqPJ59mMlK2acoL1eOniQOmuHV6RcajExaIfT2JXLJiE4RHmfGC5Uhk8S+RY8+qxzaUCGi/Irfa1p4Wgg+tZpdRv9J9LUlOh/zrGuBxAbcF8Db/ZUNdmfd4zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hx41hJU13B+XcmZre1CQ5YaNYx92kx5WwEbVDm1LrmA=;
 b=Ggo78/ToO1xx8oBlHxK8mciDN7a3uFbvqWFtKoem/iAKWqestuiZ0nPFmkuTN5BGnuU/Eb+gfAJ6M2Lvq5ktZZtQi2Adk8M3/v33tjoJqYkaYFYTowVO23YyW5LB3cUP/xihNVgdBpdrlTcz6XEXkyqTf7YBM2+1QXlGJugidec=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4813.namprd12.prod.outlook.com (2603:10b6:208:1bb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Mon, 18 Jan
 2021 06:45:08 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::e863:8081:a14d:b03f]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::e863:8081:a14d:b03f%6]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 06:45:08 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: remove unused message SMU_MSG_SpareX
Thread-Topic: [PATCH] drm/amd/pm: remove unused message SMU_MSG_SpareX
Thread-Index: AQHW6/7zUNT0oT2dg0CIhBz7cGrfm6os8oVQ
Date: Mon, 18 Jan 2021 06:45:08 +0000
Message-ID: <MN2PR12MB4549990357E9638E9E94E41197A40@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210116115829.20135-1-kevin1.wang@amd.com>
In-Reply-To: <20210116115829.20135-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-18T06:45:04Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=2db9af8a-ab66-47b9-bc6c-ea773b0ad6ee;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 81c8f84a-9e22-44a6-01f4-08d8bb7c98c3
x-ms-traffictypediagnostic: MN2PR12MB4813:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4813A303B3D98ACBB611011797A40@MN2PR12MB4813.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /P9uTK0Z+vXuQ7S1lBmmErQDzD95irYhKP+TzKcxE76o1720P2JDrKUp/e1D+5UFzpUTu+aM6WawE7oZ735AarceVjaE+wU8eJg2Jj31x0CUvlPyiYe9R3O6MfsbpFspcZq/FZhF0N/t0fxjSgXI1n+Yr70PxFFZCJU2c3bb5Tc8uLuEDhJ/0LugAlmC+DUAH87gRC0eQhLyqg8jQnMqMi1hC6zRP26WCLZhWKQ3e4Dajyx2qKGBa5em0VfBrA8AIcjbi/bdSfS4qj6pYZbFZ2xQdQD9NpHMF9JytFoBNVaA0Mtl0aAa03IN4hJe7eUDOuiSW+niEaN+Pd06vRM1ZXv41MBzS2ZoxQupt0LNEn9vj9KjK7poslQO8JmMsTJ56LosRI9eFVwYXKJHFkBgsksWJeOZZ1VYwOX53BcXJc4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(76116006)(52536014)(66556008)(9686003)(186003)(316002)(2906002)(66946007)(33656002)(71200400001)(4326008)(55016002)(966005)(6506007)(66476007)(8936002)(66446008)(64756008)(26005)(7696005)(45080400002)(5660300002)(15650500001)(86362001)(83380400001)(478600001)(8676002)(53546011)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rHxmkTUwinTWymvXqugaTP7ILlfDTW/knqGyMcjnQ2cF66xqjriCnPh5lAy1?=
 =?us-ascii?Q?DDzbaapAVJEZhsN9ULoUAreVgUdiNkyvgDlxRwnGa6wLCHRy6oEUnlVHCBCk?=
 =?us-ascii?Q?LAZz3fSeJqq7oqooLrV4l2qQ3Ln9IBrWjqz/2Kx7rapvLeFNKloGDgtmw7Nn?=
 =?us-ascii?Q?9IR1ItY2rU0WRxXCY1S1JcRgkhuU9g7lDx2Zs/4LuVgR1WcrB/0VQIFFvHBP?=
 =?us-ascii?Q?YKKN74IeHAIfZ+bTr/KYpDfbe9YiZ1Lfa5T0rbhmkwe5lcuxuhrM4Dnt0pgY?=
 =?us-ascii?Q?wHvYl4BlMoSyNknnNlhgdPUNkDLYnGcRuJLcNKyOF4FUfDhaL0/HTWPpt8CG?=
 =?us-ascii?Q?bm6tSzfUZxUkRZp1tj4iZrJ83FbSbbPyUFtsR+70+pkyio7od1o+dJPhp0MC?=
 =?us-ascii?Q?C/50ZcB9du/3v9oUEnIpfCSLXitw2zxuzseRCu3gqE85xjaovvHVpyli6PTg?=
 =?us-ascii?Q?grnvTMB+7A0x6L0oa/6AZvEVYJWTgB9XUzmA5DYb9JljE1ixscUYbMSVcBxO?=
 =?us-ascii?Q?CM02XGYv+t3PoYt1wUljm62zfhNbsO+gAz1QmmPej72Vq6bvbBABfIwCUHTD?=
 =?us-ascii?Q?M0JYApRU8eMP286xQ3bi/b1y46mwiaZOiSO7vIOgqq1B+XHndRbFOSrGxDxD?=
 =?us-ascii?Q?6lIVAUS0iFOaaryHWqj1nM7PryBY8q/O0S85a8I1eVLg94iPkUWrrT1sPaFq?=
 =?us-ascii?Q?JLcegttP80I4z92MJxtEEXXviSxM+2BNYMZtmtZ1rOXlxTNUI81pDOJ8819q?=
 =?us-ascii?Q?xTgIQmufDVRaKmdn5kbEvAMzpLFug/UCE6wPHE56AaQnTxA0yJH5FtF437wl?=
 =?us-ascii?Q?gOol8fvyAmkGzPpUWgBJHv22H/v9bmZQib4xH3VGS4E29enoSncixFn+y4kU?=
 =?us-ascii?Q?GHFHZt6hgK2DvY4iyRFiS5ZUyjKBvOBGrOEhSyMnC7VCu9/O0pBXuiqQtNmD?=
 =?us-ascii?Q?XsUp+CaCc39EwtHKfqJ44lDn9kKy4SoB6Gk9rlciMCo=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c8f84a-9e22-44a6-01f4-08d8bb7c98c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2021 06:45:08.4697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PZ3GZzccIjZ2ECI2Fiv7kgYL3rU3TnbB1H8PS3Zs7MbY5rl+YNMy6gsm5t4WL/CI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4813
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kevin Wang
Sent: Saturday, January 16, 2021 5:28 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: remove unused message SMU_MSG_SpareX

the SpareX is reserved by SMU firmwared, the driver never use it.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_types.h           | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 2 --  drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c  | 2 --
 3 files changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index b76270e8767c..68c87d4b1ce3 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -133,8 +133,6 @@
 	__SMU_DUMMY_MAP(PowerUpSdma),                 \
 	__SMU_DUMMY_MAP(SetHardMinIspclkByFreq),      \
 	__SMU_DUMMY_MAP(SetHardMinVcn),               \
-	__SMU_DUMMY_MAP(Spare1),                      \
-	__SMU_DUMMY_MAP(Spare2),           	      \
 	__SMU_DUMMY_MAP(SetAllowFclkSwitch),          \
 	__SMU_DUMMY_MAP(SetMinVideoGfxclkFreq),       \
 	__SMU_DUMMY_MAP(ActiveProcessNotify),         \
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 2f0cb0ea243b..3d639c530e2f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -81,7 +81,6 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TransferTableDram2Smu,          PPSMC_MSG_TransferTableDram2Smu,	0),
 	MSG_MAP(GfxDeviceDriverReset,           PPSMC_MSG_GfxDeviceDriverReset,		0),
 	MSG_MAP(GetEnabledSmuFeatures,          PPSMC_MSG_GetEnabledSmuFeatures,	0),
-	MSG_MAP(Spare1,                         PPSMC_MSG_spare1,					0),
 	MSG_MAP(SetHardMinSocclkByFreq,         PPSMC_MSG_SetHardMinSocclkByFreq,	0),
 	MSG_MAP(SetSoftMinFclk,                 PPSMC_MSG_SetSoftMinFclk,		0),
 	MSG_MAP(SetSoftMinVcn,                  PPSMC_MSG_SetSoftMinVcn,		0),
@@ -93,7 +92,6 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(SetSoftMaxSocclkByFreq,         PPSMC_MSG_SetSoftMaxSocclkByFreq,	0),
 	MSG_MAP(SetSoftMaxFclkByFreq,           PPSMC_MSG_SetSoftMaxFclkByFreq,		0),
 	MSG_MAP(SetSoftMaxVcn,                  PPSMC_MSG_SetSoftMaxVcn,			0),
-	MSG_MAP(Spare2,                         PPSMC_MSG_spare2,					0),
 	MSG_MAP(SetPowerLimitPercentage,        PPSMC_MSG_SetPowerLimitPercentage,	0),
 	MSG_MAP(PowerDownJpeg,                  PPSMC_MSG_PowerDownJpeg,			0),
 	MSG_MAP(PowerUpJpeg,                    PPSMC_MSG_PowerUpJpeg,				0),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 6c8a8ccd2f84..dfe4eeeb4596 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -56,8 +56,6 @@ static struct cmn2asic_msg_mapping renoir_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(PowerUpSdma,                    PPSMC_MSG_PowerUpSdma,                  1),
 	MSG_MAP(SetHardMinIspclkByFreq,         PPSMC_MSG_SetHardMinIspclkByFreq,       1),
 	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,                1),
-	MSG_MAP(Spare1,                         PPSMC_MSG_spare1,                       1),
-	MSG_MAP(Spare2,                         PPSMC_MSG_spare2,                       1),
 	MSG_MAP(SetAllowFclkSwitch,             PPSMC_MSG_SetAllowFclkSwitch,           1),
 	MSG_MAP(SetMinVideoGfxclkFreq,          PPSMC_MSG_SetMinVideoGfxclkFreq,        1),
 	MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,          1),
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C78a1c9e606604a9679c708d8ba16149a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637463951300629403%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=lhh60VQFfpQm6EN%2F91Xj2LEOBJqWnGK4Vob%2BybEDhWk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
