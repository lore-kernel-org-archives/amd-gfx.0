Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E09EC61D97
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Jan 2023 01:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50A2410E00C;
	Sun, 29 Jan 2023 01:19:17 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0ACE10E00C
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Jan 2023 01:19:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mppb87vo/7s+YnViOc/JE/vTROMSIyKXRVHpCJKycXYQOBO/6RdDHmifFKhb6sQ/ICK3quH+G2v0wTWcJgVHmUrtvT7z+OuAf8tGZI/7gAg0EL9f1CBnublEzzFmgSHve84Fh2kURr45xkTLTAiJebtdRx5D+hlie8slFOtdCQH0S2hY4tiQdPz4+FqfCJBKR9EmpnCWHpv/iJuzPl+cBz3AF/etX+GNrL8tDg9WypBOn3eoaLoIcP35qgm+qffmDCX3oQGqzKXlqq+giV6nZMEH1fBBCP4LwoAZWZ5U5W+1PAq+oCTmXXE5CP5CN4iO8aX7GF+IVN0uVN15cmzooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4g44esXs3qbZUBwnFQMgsFRESsFWTnTyWwREyEQh2Tw=;
 b=jBwYT0PNSCuY5wEdc51CfGydDMuh9hhmiM/vPh44Eo2oJeNS38bEEgfczRzw5QPNvJIZoSXpu4jX3Fw12TLS3dfgopI9Dcw5qfd2yzrWiv9/H61cjy5zJ4JpLmnLmz+KLlSIoerNkdJj3PXMJ8x7vsuS57G5PA3PzEXDcoYRIn122PEJYIsM2eL+kqewiXa8s/HmeOENN6mL6gGMKcJIiD4akjef0dU8KfRYC4xyIwHTXkCOlFEsti7unTG4uobwovXDgqHnOI1b+3NOVhh4pZWnfx8xjy79BUlISjPvN7qlZpa+QErJdwHZYdsbNVMdtf2FY1g/yeOJ1Y3osZJxwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4g44esXs3qbZUBwnFQMgsFRESsFWTnTyWwREyEQh2Tw=;
 b=aC+wcDle7mN4B5D0MdPKHrFizTfnvtCceu7/SuPgDTN9xUj6u3EMFON097qFcS6n/BHHuJ2ynoOGgP6UGxHGhBIjKY3yN+mtq3CkXjK1EB55Me5lDxnYBcNvJt0LIQvHBK6CDOSOAIs4PWsDInmR+p17PnQkVh7Qgmzwsr2DEaU=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by IA1PR12MB7758.namprd12.prod.outlook.com (2603:10b6:208:421::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.30; Sun, 29 Jan
 2023 01:19:11 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8617:d09d:24bc:a683]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8617:d09d:24bc:a683%3]) with mapi id 15.20.6043.030; Sun, 29 Jan 2023
 01:19:11 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable HDP SD for gfx 11.0.3
Thread-Topic: [PATCH] drm/amdgpu: enable HDP SD for gfx 11.0.3
Thread-Index: AQHZMu+H9n4LnWb9406SjYCQSOl8Yq60mXMQ
Date: Sun, 29 Jan 2023 01:19:10 +0000
Message-ID: <CH2PR12MB4152411C620DE9B15FA1D402FED29@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20230128080617.3935541-1-evan.quan@amd.com>
In-Reply-To: <20230128080617.3935541-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-29T01:19:07Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bf15f291-2a10-4eba-bc02-fd49cb981eea;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-29T01:19:07Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 69f83b43-86dd-4007-a45e-a2f0eb0d98d0
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|IA1PR12MB7758:EE_
x-ms-office365-filtering-correlation-id: 597e6a86-a30d-40c0-cdbf-08db0196d3a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +g5ZoRdliyJdRYigbtA6msvxTgySMaxVY0jYRu6ozhwovQY9TxOyuz1K6lpxUCxJGzfxiTY/akedP5Qyq1TtsdKI6VPSqqxu8bZLWevTUWb348/HcWSN/kzY7TymyrxXU+cMa2qYrCC5oj3XuYxaXG+eNrKEvMzWGhSW5sIVQ+gOew7pHfDndp70EaUb1Qf88tXc1ppvDnlwvXrSp31Z2omKFapK6GY3jDQO7/uCsqjJpxviKt+2PLxxQVy9Ox+/WO1FRgLrf4+fTxmZSllK6w2/WsTNLuewpmCi+MFeARmMabODCU7Kv2/P3x07EYetzc9nk+Snttet49NxXc8PwPjMQFfZRwd5ZKMsLLdTCUJSbuUuZx1WFHqW6EsjJK1GZ3998KMJHWfzA8GcxHHbxaI5o4nRGYHKqxkN7P3M77oCUcxVoILp0iToDRWhMZ4+iGxd6mDQO4F+z7Kaln4F+J/zVydkPLshtFeElv572gctDHC3kWZQMCZuqJsH7eqtp8sJ7U7nBs5MOKibjk1i195SvF17rB/ok/dO0hvCt7us74ooG6tNT2+tyTtGjGdvO+LD5xkTGNfoJSm00w4QSWifAVxf0BaOx+VWSvQtGwetGP4SLDdjyUI7nKY5VSJlND4aRDx2zs90+u71/IdikiFocwsMdIy/XVROO8ii4WFodTfa078CSIVX6xEDMNkwFMZRHyt9pghvH52v7GTa2A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199018)(8936002)(41300700001)(86362001)(55016003)(122000001)(38100700002)(83380400001)(38070700005)(316002)(8676002)(110136005)(54906003)(4326008)(66556008)(66476007)(66446008)(66946007)(76116006)(6506007)(53546011)(64756008)(186003)(9686003)(26005)(71200400001)(7696005)(33656002)(478600001)(2906002)(52536014)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NH3JdPO20edmu+/MkT3AN8lnhvdzfl/VSH/OelBE6lhv2/UFZQ7OvRZAzSvi?=
 =?us-ascii?Q?xdnNcHvPu/uCEYUP3u+DhfEFQCaWZOhK59cWDY1nEHszc3zQNWS7taNSkjQT?=
 =?us-ascii?Q?G0AK7EcmIg0v2zbK2wY5h21tmZLZ/fI3ogSI4ZD/4Swhq/A8F1bMGnVF/xIJ?=
 =?us-ascii?Q?txc3bovEa++75yFvy86RfUauVJdJ9VvcA83476CwYipABpADO8QaR3kOX8bz?=
 =?us-ascii?Q?JMADop8moLdaLzu8Z7VfxHnPslWkmb0txSgN3Hep37V1Vg3Y8MfKsixzcKrz?=
 =?us-ascii?Q?0YiSoudD0YfMvfRA9VhXytiWhXBhM+wryypCPglWIvr2Rp4PrnZ2rSdj16QE?=
 =?us-ascii?Q?zxpoSDFfJmuy/hBFsBnBLGhsTyGQVntZauHcgPPIfFe011dHZ0cJ4aqPDCVb?=
 =?us-ascii?Q?fF8QNy6+OaIPjctSkGPTyE+b19Eo2zlh2xbWs4T9EiAMVwUr70wOYmrqudgU?=
 =?us-ascii?Q?mupIM0rXEkfXdNXIcR19vUmkShoxMztWer2coMpJBguXZDLg6kLT1YxUT0+u?=
 =?us-ascii?Q?ZOhD7VdJ33Ypo4o85Ccr1xCL1y2goCUa033++rNcFYi9UyEiicq8NAfmkMQL?=
 =?us-ascii?Q?suL0rqPRbP9EPwDVL970lVhO/VdFpO75SZ3FRE/qLNO0UXXZYUCxZZ2z4bZ3?=
 =?us-ascii?Q?meWSsHkTlx1V322F+nGkuLwm9mZMydxbexfq8dUCKnf+1zDN4ZeWxFYjA663?=
 =?us-ascii?Q?iiJ4huc7UYJSS1ZIl9Eg+5oYPoeMvaU/m9WAQ2n8dNn8tpFSR+HqKThJB/+x?=
 =?us-ascii?Q?0J3uQ+c8D+4d7zeXL/4CqvcbqRhcxAlWJIMyOkKNeUoewsljd5Dj3/SU9oRR?=
 =?us-ascii?Q?1Unph/HEU+yOaQC7Jzpr+p3OC7EbnFSVvBPylar2y41NUvIB+G7Q+0ngCynG?=
 =?us-ascii?Q?aQ72WIAYDK/kuR/k7qAeHXYouPVG4t3/g1WyPm3ZzBXsZFC7O77yzutcA36t?=
 =?us-ascii?Q?NKluwWFIwgZoHmZNHHO9LslCNiW36DlYSyX28yKl6TRp0lLWCQ8z90jTKvfn?=
 =?us-ascii?Q?HVRur5NBF1a3NTXp4C958/bAbCg0iE+Kbhr8aP4WjEGG8IfyLLSoNTJ2q7Fj?=
 =?us-ascii?Q?y2/ayU/iKL8SAckEd1w55OXWFmu6FRilxR5HpmvPxBHWexDBnVlCszCfCMtp?=
 =?us-ascii?Q?4ExhvBXMztlra9Im7L9GbwRXS/NIPqkt5PIEjDPaQMlvRbbgEMLYNZYeJSSk?=
 =?us-ascii?Q?HDhWYN/Cxh4vpDwutn8iNiDvrrgv2tcUiLfklPDeEzBZ51j2apjYre6fb/jj?=
 =?us-ascii?Q?+7J08mV6BsfSO4S0MDGM/LccAwAZ/OvLU1gjCmsSCkvBh/C/cfXeCG9mKIXm?=
 =?us-ascii?Q?cBR0WYZXtG0CdLmQp00kBgguEGpofHOEieXY6f336/6LOyUBBxeo8lNQGc9Z?=
 =?us-ascii?Q?z8X51QmSt1rnUOLyko7ogOf2fdDTez2gq8eMf0bL+S99wpn3sXVsAa8qM/4V?=
 =?us-ascii?Q?4mmh7cQJeNGiE8Ze7rxwis4BEwXZNujhQX07Aqx4Psiz1DMwhpj1rATDBe+B?=
 =?us-ascii?Q?pvSGufzYYW/0DNYgSWg2OpNl+FGODC/TEl5Hn21GLLqypT0luvGPp3igHy0k?=
 =?us-ascii?Q?uKeo0iPjLdgoDYUhMgc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597e6a86-a30d-40c0-cdbf-08db0196d3a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2023 01:19:10.9947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kEp2Qgj/UcHH1r712RcuuRDz2eQhbxV+y6vzngz7+q+yYp3KcVN8kK0Xhu6Ogumz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7758
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Qua=
n
Sent: Saturday, January 28, 2023 4:06 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>
Subject: [PATCH] drm/amdgpu: enable HDP SD for gfx 11.0.3

Enable HDP clock gating control for gfx 11.0.3.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I0bac85a05692937917e2916e79e6e74a1e11aec0
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index e03cf7f766c5..477be4b62bc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -676,7 +676,8 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_CGLS |
 			AMD_CG_SUPPORT_REPEATER_FGCG |
-			AMD_CG_SUPPORT_GFX_MGCG;
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_HDP_SD;
 		adev->pg_flags =3D AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG;
--=20
2.34.1
