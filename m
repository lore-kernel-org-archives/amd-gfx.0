Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9624BC77B7A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 02:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13EEE10E40C;
	Wed,  7 Jun 2023 02:30:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 409EA10E40C
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 02:30:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ol4jHgwpqR747dB0QGkpF1GoemSGE5pB7aPs7WcmJlQmVEA61M+9jflWeFNLKORTTbMJfUebfXRy8vOdIDSHMbqGvoKZxZBRnkJAYwwB93aDfK1Pq07nPc1iicTpNAALn4YwcAvBdiyIraESiezCfwT8Ba+/3CdkwPdb0FYvkRyynCXNGKM9HkMV8GKHb19l2N+O3eyrmpg+mzSKXWPabrIWMSiYJNSwZ3BFSydlaMQxuiAUftJ0KAqiZ8POsea/4SbMBVwACqS/QbwBDa1KNWmcUeoQHeT1TsPypr4vNC16S5eqm71AFxzx1VSzKLlz32vr+cuelor35mFvWGhLxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZnt73SCIf3LB1HwAwwh/vrQYLnBm5Fj3/4QHIL8VYY=;
 b=l9k4hABNvOkQl/jk7Tr0fQh2oky0b/0iDngDhZ64HHLBr3C+vQGgYZPnCEdOlO3cTL0Fx8HbRcQCxj1WUvBlHase74935zK+sIiGm52hR6EfJUPWJIHr6vYTdYRUp70JztEzTVQY2twnCDBw5z2EZtyh0NB+47O61aOmPxa4eSXi2zy+f9aM+Plm8tK0iCOFVz7Ae4MwpLJYOwrqypBe8egfx224WVfapdBumz3CCVY/44rbPrOwDeq+/XN61sJ26Jj+dEHkRgI1O9oGC1uVw2CqhG7NdaSIo20eh/xk2J86/CENmrUehIGggmjVlggeNMrPayQ6jvwLr6o9fozvOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZnt73SCIf3LB1HwAwwh/vrQYLnBm5Fj3/4QHIL8VYY=;
 b=iLelUEviBaXmzPGfVrfP80Qdhso+bRoUg+Wyt/fT4HzH+GaoE+a3gpfgwYMQMBNIRapisQjnlmprk6hwnm7D5prr2Gd4bWbWgLFz34IETk3zciYohmRHGi9gIgw0m1qw+COKQMyuNPu5nsqygrQGCvFaD05BWK+4ZiadnG6IvSU=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by DM4PR12MB5344.namprd12.prod.outlook.com (2603:10b6:5:39a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 02:30:02 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::635a:9689:10d6:36cb]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::635a:9689:10d6:36cb%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 02:30:02 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/mmsch: Correct the definition for mmsch init
 header
Thread-Topic: [PATCH] drm/amdgpu/mmsch: Correct the definition for mmsch init
 header
Thread-Index: AQHZmEOPvd0PQZoD+E23TdLV/eyShq9+n1xw
Date: Wed, 7 Jun 2023 02:30:02 +0000
Message-ID: <CH2PR12MB4152B2EA376360935CDF72AEFE53A@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20230606065210.3103195-1-Emily.Deng@amd.com>
In-Reply-To: <20230606065210.3103195-1-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0acd341d-c201-4359-a1bc-c30aa92cb46b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-07T02:29:54Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|DM4PR12MB5344:EE_
x-ms-office365-filtering-correlation-id: 524ad613-4d20-41e9-ebd9-08db66ff191d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uE0PWLzNseeGPy0fOiVewm2lOYw5L4x0PlkkBjS2t0bW1++IIL3/QbgC/oBMQbdCWGOHK4UeUtK1YfOOByTozVZ1w9DU/I+ZBAGIZiih0RIsBELAnAsKskKK0JReGnuuingi6BZWsVvtmZuQyc/tgOp6M5wdoCfMQUM36fZNTc2bkc7iS+AxiDV1+ApD38SsXdhbu6arH7e7sB5er/FotmE2NttSUxDlxi73b99xbaA4jYGmRAxwY6G5cS9nTcCnBGBNyadExDTMS+OAfD0WrfmPI8G6tPFv8kbPD36PakgodahWvR/5sa3fIoK9MwX+AOZB8Z7mH/YZA9dP3kHk5obDayL4DIihPA/UjfWzDs79VyIaxRknzTdgeMp5Rd/SHxJ0YVecKz17IA1szKYlIJ1OhhfYihlEgDkbYQW5+rsnCRtrqlEGjp4BtnSx2jy0H1apsaWnX5V4pFDH85OBeFc9UDryG3OlTlwDhR270IVQHZGHCtoJEvUm+8c2VFuXFkFzdVgTRbkjaepfF/kavoVLFHuVBDPOe+vDM3kFZX9/nCoddUZxpAgFamoworZlEAJ01JUc4nWVBDJYgjunrB8Q01ECrmMV+J7howG2398rK2e7Dg9KsR0ZF2EgwhHQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199021)(55016003)(7696005)(110136005)(478600001)(316002)(8676002)(8936002)(41300700001)(66446008)(76116006)(64756008)(38100700002)(66946007)(4326008)(66476007)(122000001)(66556008)(186003)(71200400001)(83380400001)(6506007)(53546011)(9686003)(86362001)(52536014)(5660300002)(38070700005)(2906002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0TPJ5hAqh1E82k0xl44LiOsiayGVdgMk5nSFc2XXHPXSppWdLMqE6GWk8k6j?=
 =?us-ascii?Q?pjLntk4GqIeGr3cjITK6yIpMPgC9AhDC2Gj/z/2ka9VWkxLpIrzrQyChgWRA?=
 =?us-ascii?Q?KEYv2LXgAqIL2Sr0nonMMs7U0DYSfE8Az3rVREwFWsZ+gNOOIVuijKLSlOLW?=
 =?us-ascii?Q?fK/v4MAX5+49eM6mYDv7JIGxGT3TX/JM/CQoEBrfJrgThO4mnmqFyzk7Hm4b?=
 =?us-ascii?Q?2482pmRrk9sJEfSmwcrkaJY4rG26+0rFCqnO2gU7FzDKyxWWMVhEYwRh5grh?=
 =?us-ascii?Q?+1elyWzBvl8mFtQFO/x3up+/rYZtyVoVCpWajLHtPOoKMACvISITVjcGwGrc?=
 =?us-ascii?Q?Pex7arRL1Hh8LQgkX4WtXhr7qCxnnB48uzbVDrumn3AbI8venpjbnzPmCbs/?=
 =?us-ascii?Q?G6C3BxTFUEuk8zw9qA7EDFiGk7Yl8THFCdU+2U1Bp0Aj4KWXEs6qwjdFzGb+?=
 =?us-ascii?Q?F04pqAqekvVHyB0B/QA62wABaIelvWaip5JRCmc+vJSSr1LrE6SywWH49nvN?=
 =?us-ascii?Q?7sfH2JqFqROu7CtDIAf4yJ6/DCyxEuXaY0fbaoZDcZ9dk6CHkQ3oTmzXLGoS?=
 =?us-ascii?Q?HzsKSsroAzrIpEpf7E8ueCJloXZ/0R+ZJsahGMKayChYn0gb16Qn3Q+Ebh0L?=
 =?us-ascii?Q?X2GUy0MSdAn5HwQufGVZvHOiRZqzymsSkRfjK0KEObfw0WSTXzfPNCkOUVUA?=
 =?us-ascii?Q?DV580q8NH9ntR/pBfBhiWSA7dfEu6S1aRdxsVygP544pvqa0TnEAyBFUCMEl?=
 =?us-ascii?Q?mCiE4dSArGCknWF3NYXvc6wqjf1VR1efU7diCFatF3LLY2taXJzZjkjJIVUS?=
 =?us-ascii?Q?+j+lEOj2G4WFut5+FNG7nyOXxgML/cmhen0I6KgbF/VqtXjDvOFYLm86rJ06?=
 =?us-ascii?Q?+IOwZYmZymjnKU7WsfxqIM/m3ZL6Bulvg7xID/mAMCzFwfWPvmh+FowMo7o4?=
 =?us-ascii?Q?xILsINtQ1668EYWifqRy7DNh4PEAc4mFgk5ld3tXGV6UC0i9OKPRQObG6gUt?=
 =?us-ascii?Q?Jnt/GkDa4qpNd4o3WVjy7r5TT4QQAFtwMWcLpj737eyGXs468FKldT9uoDfw?=
 =?us-ascii?Q?0wUTVsq1oo0Xkli3yv1IAYLtxpAvt7pxp33u8RKPgiC2mljPanlGrFyFqPoB?=
 =?us-ascii?Q?Y4LQmXsjWdEOTaecn64ctZxFlQlH5uC0cYRIb6H/yf66ibb6TgzP5niXJG1/?=
 =?us-ascii?Q?mjm3TL3lr6D304gIgzETrKXLKvwfJ7LI16A/dDt5YMaZnrPQiYgECT7m53B1?=
 =?us-ascii?Q?bECtbaXw4ZUv7tLhONFJAnQ5gQxAO1VZA3C5dQG0mgH8btaavM2H/rOCACFk?=
 =?us-ascii?Q?CvS24HejtB09rtmSyGw/D5juRyaA/z5urNnhXWYildX8vTcB3ys1CQfg0rFR?=
 =?us-ascii?Q?dgYMJrroU6MvUyD72wGytYYRzQrtQL4ZTjxf5FDMywMHSdc67bSd3f1Ehvhi?=
 =?us-ascii?Q?JyfUYcenmqr6gKObyzqc0lgAh9fhPa1y73tq38CZ91fhhby1tAkjuLvXw4cN?=
 =?us-ascii?Q?iMyj1apE932BxFQU37IiIw1VDPC+f53CR7V28/IXjCHuurLJw2xpb/Yabw?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524ad613-4d20-41e9-ebd9-08db66ff191d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 02:30:02.6687 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8y4wagAIkaiarL/niDtZuduBkCQyIfdU9M1mdCHmyNqmD/CtoKu7u93iZqjqQ4qn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5344
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily De=
ng
Sent: Tuesday, June 6, 2023 2:52 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdgpu/mmsch: Correct the definition for mmsch init he=
ader

For the header, it is version related, shouldn't use MAX_VCN_INSTANCES.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h | 4 +++-  drivers/gpu/drm/amd/amdg=
pu/mmsch_v4_0.h | 4 +++-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h b/drivers/gpu/drm/amd/=
amdgpu/mmsch_v3_0.h
index 3e4e858a6965..a773ef61b78c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/mmsch_v3_0.h
@@ -30,6 +30,8 @@
 #define MMSCH_VERSION_MINOR    0
 #define MMSCH_VERSION  (MMSCH_VERSION_MAJOR << 16 | MMSCH_VERSION_MINOR)

+#define MMSCH_V3_0_VCN_INSTANCES 0x2
+
 enum mmsch_v3_0_command_type {
        MMSCH_COMMAND__DIRECT_REG_WRITE =3D 0,
        MMSCH_COMMAND__DIRECT_REG_POLLING =3D 2, @@ -47,7 +49,7 @@ struct m=
msch_v3_0_table_info {  struct mmsch_v3_0_init_header {
        uint32_t version;
        uint32_t total_size;
-       struct mmsch_v3_0_table_info inst[AMDGPU_MAX_VCN_INSTANCES];
+       struct mmsch_v3_0_table_info inst[MMSCH_V3_0_VCN_INSTANCES];
 };

 struct mmsch_v3_0_cmd_direct_reg_header { diff --git a/drivers/gpu/drm/amd=
/amdgpu/mmsch_v4_0.h b/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h
index 83653a50a1a2..796d4f8791e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/mmsch_v4_0.h
@@ -43,6 +43,8 @@
 #define MMSCH_VF_MAILBOX_RESP__OK 0x1
 #define MMSCH_VF_MAILBOX_RESP__INCOMPLETE 0x2

+#define MMSCH_V4_0_VCN_INSTANCES 0x2
+
 enum mmsch_v4_0_command_type {
        MMSCH_COMMAND__DIRECT_REG_WRITE =3D 0,
        MMSCH_COMMAND__DIRECT_REG_POLLING =3D 2, @@ -60,7 +62,7 @@ struct m=
msch_v4_0_table_info {  struct mmsch_v4_0_init_header {
        uint32_t version;
        uint32_t total_size;
-       struct mmsch_v4_0_table_info inst[AMDGPU_MAX_VCN_INSTANCES];
+       struct mmsch_v4_0_table_info inst[MMSCH_V4_0_VCN_INSTANCES];
        struct mmsch_v4_0_table_info jpegdec;
 };

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c
index 70fefbf26c48..c8f63b3c6f69 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1313,7 +1313,7 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device =
*adev)

        header.version =3D MMSCH_VERSION;
        header.total_size =3D sizeof(struct mmsch_v3_0_init_header) >> 2;
-       for (i =3D 0; i < AMDGPU_MAX_VCN_INSTANCES; i++) {
+       for (i =3D 0; i < MMSCH_V3_0_VCN_INSTANCES; i++) {
                header.inst[i].init_status =3D 0;
                header.inst[i].table_offset =3D 0;
                header.inst[i].table_size =3D 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v4_0.c
index 60c3fd20e8ce..8d371faaa2b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1239,7 +1239,7 @@ static int vcn_v4_0_start_sriov(struct amdgpu_device =
*adev)

        header.version =3D MMSCH_VERSION;
        header.total_size =3D sizeof(struct mmsch_v4_0_init_header) >> 2;
-       for (i =3D 0; i < AMDGPU_MAX_VCN_INSTANCES; i++) {
+       for (i =3D 0; i < MMSCH_V4_0_VCN_INSTANCES; i++) {
                header.inst[i].init_status =3D 0;
                header.inst[i].table_offset =3D 0;
                header.inst[i].table_size =3D 0;
--
2.36.1

