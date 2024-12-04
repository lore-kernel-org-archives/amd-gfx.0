Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC56E7716D
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 07:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E158C10E2A3;
	Wed,  4 Dec 2024 07:09:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z5haccJw";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E5410E26A
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 07:09:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMrNie0ESj/gmOs1wqT8V5r+jYPZ/PNHRYSZ33dzdATlQH7tjLmnN6aNSjVqCE5B2DpgH23MIulPMQ6PdiFoIO5TF51k2DFvCTr4tkhe9F8qzVGpHxCkQCcdLhiryv81NqA20kyYfYvXd4fQz3/m2hn7nIxCRrMxH+sasfpIUv8+8pJK1J52AcE3n+pDZm5zmlu8hDBwH0/aPkKhkF6wpgUhFiDfP2+0x+B38YwbS4dqQpd3Q9PeDxbJeEJJTcyHO7WQgY6Zeh//BH93SZSJsTBsEFm1i4n+rLOczfoxaRsf9m2DlpYFb9cjoiR+030VdtXLyJYzQp42B7apkn2dwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fd4XNZCDaS1vIqlvQZFNdsPzv1l+8CZ7d/UVMcX54uw=;
 b=tg2EZFUoUNO5gC7W3b8CDkQRVt//CB/5QHKmWdJtGltLbdyaqQakkG9GLel+UtTml3uJxD0XhB9NtlVoCWMdVcMMf8MGSq6aue4toVKcFJhXTYe/qrduRJccE9qrGUDp8dyGpQpso21WimQ1P8hpAfnIeE4yzYF2fEfnCsbP/7gpZf/gQlzeeAx6hTjaB/B+grtDXVSWZRZjapuVqY4GnGPDeydpfeK4ekj65Aku93Hr0t1qqvXah3x1Xte/zKTvU1fuU3S/leamfcDLzbgaDe75Ah0Ulbo4eiBAgc1gn44HXXmiPPUNjh7tHkYxd3SP72TzyGirx0V7V0Nsc6KRJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd4XNZCDaS1vIqlvQZFNdsPzv1l+8CZ7d/UVMcX54uw=;
 b=Z5haccJwXzLboqbXvqEae/AC63dPsFi1sZKWhznHT9AVp6AjRWqRQ0OXOkGXEhwFLZL294nS6HJEvuB0Ftp2WNy07hMCT/8D3kIp+SyoAdnH8g2gUCeGECiDid9eFbb5sGanXQ/DRCA++hi+FNs44JHqbk2+JyvHatEZ4ovw74c=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DS7PR12MB6215.namprd12.prod.outlook.com (2603:10b6:8:95::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.18; Wed, 4 Dec 2024 07:09:13 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%4]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 07:09:09 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: set the default workload type to bootup type
 on smu v13.0.7
Thread-Topic: [PATCH] drm/amd/pm: set the default workload type to bootup type
 on smu v13.0.7
Thread-Index: AQHbRhqtX/FeZFP8KkmSQpi9iXU5CLLVqfsA
Date: Wed, 4 Dec 2024 07:09:09 +0000
Message-ID: <PH7PR12MB599730F2B1D802A63521AC0782372@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20241204070346.1295087-1-kenneth.feng@amd.com>
In-Reply-To: <20241204070346.1295087-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=a6aec34c-b752-47bb-b72a-d09332bd9039;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-04T07:06:52Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DS7PR12MB6215:EE_
x-ms-office365-filtering-correlation-id: 87b95399-5383-412c-7721-08dd14328c97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?PQweSBOeTeEpiKPEHgIfbvuLyMeg6YhAMvUVgv2QwCfmvoxctW/NVgzXaCFM?=
 =?us-ascii?Q?tfhCSeGoRLmM+4/7aCO4VlFfx4JoK/Hc/ISD0Cqt4xOpEnYqtlHuBvf745dF?=
 =?us-ascii?Q?waS+nXdtdA44g+82JY1Ve3kPRpe/tDugcKOhTOPfnn0KY4FJI118J8y4EkNl?=
 =?us-ascii?Q?46P6PozUoyo7y9RePtAZx3oAKyuE0dETr1s49y0SXpa4D8b/W+lB/ENaZNhk?=
 =?us-ascii?Q?69QNlPcntrZQH9deMRVmkep/qPwdsz1ytWeWcVkdxrScUVF7fzqUOlzinDdP?=
 =?us-ascii?Q?41a7n3NAKKBNvIl03cN06Tz0kvuEBmOFjcUq+l/AItQ9GrFGqN3MYounZOxI?=
 =?us-ascii?Q?CG7FB/VLxZEhnjrg3ZsigQqeiWNhBhY9RBPitfnqWGekejjs3/yQ7Alfqr4y?=
 =?us-ascii?Q?qvqkOp9c1VxMD2W02YGVzFrz2caCWoh22o1tbGlU0E/Z0U3r/5TnDNzEbo8d?=
 =?us-ascii?Q?wQKaDoigOMoECRiB5zP8ICk7SBoj8GCUfjT4KJADdAxv9ADYibzlvyLVnnow?=
 =?us-ascii?Q?yS/RD1YEId0KdaHDm2lOIEBzfUFhB36OWZq1gTJTMxtJvmD2VWRr6oyEAzPe?=
 =?us-ascii?Q?2ugKmnrl7A58WMvYINNrK3P0JJyTqZ5JQtYXXEJDEUF3SDw1isFd+c2ndskU?=
 =?us-ascii?Q?TU6vcY3Kol+GnOc0TEfjinu05bsu3PHm4qodNALoUwlrfQCxnqU2cir5+/ly?=
 =?us-ascii?Q?4yq4DUyWtNCfNxvcG7cqffzuLfc2nxxZQ/SPUHMtgb3z00npKLOppkov01as?=
 =?us-ascii?Q?oRtniMArDKSoVVqwcGZQOqxUeZ4QzppYVx2JuL/xZWPIklyAn6sDFijHteQb?=
 =?us-ascii?Q?pfCv6YJBj8LgIg070tbA5hczowVe3HEA1PN7KBRkP6Ufr7XAmN/UmGCndM9q?=
 =?us-ascii?Q?4c+rxaz2qk8yHbQzxLSvpplykFV5Us+62g90RF7Gxev/5hTxY9AEcFL+VBKQ?=
 =?us-ascii?Q?RzI7XeuSyQKfPOZH7gKlfJwDUipTxPr7Wbuc4nd1YH/D3kGBs5yBoxh8buLG?=
 =?us-ascii?Q?EcZ5ywFV57bqwM1C5YGsZblMEcyYE7bNpCbj2GR2MO9lOa2Zkp0fBo9y9dxH?=
 =?us-ascii?Q?wHfQCI+UbeAaoqTChcMFVdlQigjfMPy0vugRUJDackGRoxy/1iEIYLgqXSTD?=
 =?us-ascii?Q?abMr23+j1nPohAzlAgLkjLaq3MoXdbzQlNB7yWwJkB0glBK65+SQkvD8sm6J?=
 =?us-ascii?Q?NOYXcw6FFhsAz9cyWC+5lPrYgMQNzSRRRlvWpomglCFQ/A9B6MJvNRP3Ssph?=
 =?us-ascii?Q?GvkzmPGCTeicjiLc6rvw2f8ivDiIT+OmZjrlezAwa9QY03vM38ae1UfMYDQ/?=
 =?us-ascii?Q?srko5HxOBHTj7PrynwBiM19NRpR1u+VHMEEdfPaYnBnG7hhV/8Az0mNXc2Lc?=
 =?us-ascii?Q?caa4HU2L0xJAQuOHdjgvUkEHgOLmy/36slBdyM6dwncAfarBSw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zFbru3vQnoV/GN4/qzamHTBhFiehWAXdzRtD7+gcKxZx96H477Mq7iq3Pc5Q?=
 =?us-ascii?Q?ZyKFU/sFu9szhTdRCBRzF9Bbre/94A2xeLLY8buMgihWKZXD4tpbTvZXDmdD?=
 =?us-ascii?Q?ibNSFkz3LOdtN8EIFO6FYda6/iZ7o1vwghTX7b4igEBH+jWJKmuZqYM6Atg1?=
 =?us-ascii?Q?2dZlGTyExIKB8kzjE9hlSj93zTHEEiLWLZFwcYBo7GLYdXZ37yiVjgYRvUbE?=
 =?us-ascii?Q?+ngGb35eoBt4oRRgDkZf/QfnBe+nF3766wwuZMoB8vk/lUbfXJGQ82ATspD8?=
 =?us-ascii?Q?gNNFM26P616p+QvUFreI+emvtfW+86cLM88Iq7rWZ3dpVI+kA/qbp57u8NS2?=
 =?us-ascii?Q?oZ2kppx6fNeS9+jpzzhLDohIDJDFg7CCCyQ2FyJN/1uVdbQzEhd12qTOfZs+?=
 =?us-ascii?Q?yEov++GXZbXgSZ4IYJQczgbMbQSQczw6EjspW3Ce5PFtqwtwvcWxi8MxMUDt?=
 =?us-ascii?Q?5BfEylRDhWKyTku53BQ2zlxuhxEoze18WgQ3T0TWeYIpXzmOiniuBrX9DStQ?=
 =?us-ascii?Q?yQz4xV9qj2N9/UJufY8XT/N7dOrSKd3gumtlbft5XopS/SM7C2RIt58a6ex2?=
 =?us-ascii?Q?3kOgU14Oxz6sEBH0JhHyHTO9Rr4j7Vq1faATxCGPk/Pml9xCvHi8ppHoqdUc?=
 =?us-ascii?Q?HvDH4mbCF0IU8oloX/bDv3dY5zDHn/oZ4GEhBq3w42SLvqxdWvrrnNPfIWsX?=
 =?us-ascii?Q?H8WVExWuqt9MkmKqKoYhokASFp6+fCDyCk+1F0X1oOSnUV1HD2F1bUHUwBhN?=
 =?us-ascii?Q?MgM8y3amBB5DyOQVPF8OFccsZWtHphtTVnP7ZfLra9fJiTe3YFtvX9NZWHRT?=
 =?us-ascii?Q?WoMch2DRo9SRsgwohF8qqdPEYP8EzyvcV74joLjSaspn3zZMQC/pnSQ4C+91?=
 =?us-ascii?Q?tjhurIdpiXkvzeQWurftnnYiylZ/l0DoLNLPVhnXATFTsgWTmvc70WXiuVgr?=
 =?us-ascii?Q?ormGMTwis0CQf4yz8nIIkHi4MmU/uSXsDNPEE1hCF5/tYLN+h5cfe9zpZooK?=
 =?us-ascii?Q?d5oq16Zs23AyE5q44tWk53b750SH+3ZyyxiE57FQj4UmiVbqHUhEPGqKHvC2?=
 =?us-ascii?Q?pgHYipBPTO/7JisyhVhcvugdZqhcq4qfX8L5uAEDtnzXmnkyjkFGtabQrqCW?=
 =?us-ascii?Q?fPzqH08xdSDV/spDq3RIsFpeSlkGt1XDF7cT3iZm+D4kMRbBd+a+UC50JC3c?=
 =?us-ascii?Q?n/aNqDrH71tb/MX6pAjMvc1Fi2DF+z6tmyk6rCLV5Pnfww997bsgzLywksCB?=
 =?us-ascii?Q?1qE7tyVYtAH55g5B4Qh4Ml9q2HR95G8ys2CTP+tW6e9Eth9J9A4WH5XICQUU?=
 =?us-ascii?Q?gcVaLtMiYPk0MHtfI7GiFf/PtgMHeh/IZ2ddLwTMO0+u23Eh7XX0Q7FmvtSk?=
 =?us-ascii?Q?0fOoogtCohQaEzcX/mOzc1YqZDQp3qxaz1oGi468wH+qPW+zmxtAOXxff3is?=
 =?us-ascii?Q?r7fv/Z4l8Vjyj6GF644w30cnGwCJ0qbY5X/Ja6tpCxXHIavFBPG8fCwM6r3M?=
 =?us-ascii?Q?sev6EfvQDyX2zAqUp83DJheYcknkBm+NUwQT+jV4nyro8/P2dH5w2u4dJj2K?=
 =?us-ascii?Q?1p1glOtS5CwcHOkHDhI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b95399-5383-412c-7721-08dd14328c97
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 07:09:09.5659 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pLzY2jIAD6VetPEHqUT4AlnZF+kx0kdJNNjg64/OL0D+w6qOWvz14h/AsEDXHqSj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6215
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Wednesday, December 4, 2024 3:04 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng=
@amd.com>
Subject: [PATCH] drm/amd/pm: set the default workload type to bootup type o=
n smu v13.0.7

Set the default workload type to bootup type on smu v13.0.7.
This is because of the constraint on smu v13.0.7.
Gfx activity has an even higher set point on 3D fullscreen mode than the on=
e on bootup mode. This causes the 3D fullscreen mode's performance is worse=
 than the bootup mode's performance for the lightweighted/medium workload. =
For the high workload, the performance is the same between 3D fullscreen mo=
de and bootup mode.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index d1bab508ade2..c8eecb54a16d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1280,7 +1280,8 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_blo=
ck)
        atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);

        if (smu->is_apu ||
-           !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FU=
LLSCREEN3D))
+           !smu_is_workload_profile_available(smu, PP_SMC_POWER_PROFILE_FU=
LLSCREEN3D) ||
+               amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, =
0, 7))
                smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEF=
AULT;
        else
                smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_FULLSCREEN=
3D;
--
2.34.1

