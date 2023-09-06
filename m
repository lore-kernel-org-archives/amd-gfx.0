Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393ABEB8FA5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 04:05:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97C3010E1A1;
	Wed,  6 Sep 2023 04:05:50 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D15210E56A
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 04:05:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9LgNAw9tzhDpMtb8ugthH4MIzLbj/WR6EWQ8Dd5Ik4bOq2X+mvdb9UzNwYKhzhZh5jxtLjry1jNBIqjpNID+7AVJAGEGQXvaxWeZaauwlxScr+sevzfgAWUKyhiGMjhCjLsR6bWZv070csZqRWVT3U3I7CMgM2l7/KZfNxgYPiacn7IQR/6MBBNbvdr36Qn2Pt8ORaeR3eCSWA4mWPGqgfktAPRAUoUjj2FgiGXvPrhSunGv9wWDXm9HHtcfAGBZ1EDvuhhZixbRQG1dW9kJ9rHzs1k5xjuD5xZSV/Q+/YVsadzzRSAOEltqo0EMACCgIGznJ5R9OjDHB58RltezA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l58TxdZR3u1v0FNnlKXlYPRCj6qPpxFzdHHmn6/RaA4=;
 b=oHSq611ytUtKSSlJU1A06WKM875Yv1FbejIbeETlKElMJBHo3cWeUwZKBhj2gVHrhPQYK8fXRi83N/mrPLp97me2Q6ESO0p9USzkA03qCykej+6BeFnFhsG7brevLSwOBAzUsFHFfjrEF5vHSJe2/l22Z5KzvizwcgNvobGI2aULCtZlDTLcMg4ljdHMLcQFxzlaBbOUSA8cdHiYCrNzyNgd83b744JGBX/Wz9uSmsOl3z5XUl/Y+89PauVclsSM9P25xHcTEkVj2mxmMwEjiDchMKpjxFxk6XsQzFsXEOvmT4TXRfoZud16jqYXmdx92C7YaLQFQkaGVQW72W8WnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l58TxdZR3u1v0FNnlKXlYPRCj6qPpxFzdHHmn6/RaA4=;
 b=uiwso72WpsfWGaAOb1V3iCYa89t+TPaWeipjXoYJpeN2bLQW8bapvq+CFLiAcbrEy0f9Y04MEg8KP9f75RLEhp86UQPBvG6zNWHA5C+6Tzplzs6JBj+ZP2VyO8GOuIi6Zbb1V14XxgFBeJzdW1PnkSYJiAtiors8FB5mU2FS9g8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY5PR12MB6384.namprd12.prod.outlook.com (2603:10b6:930:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Wed, 6 Sep
 2023 04:05:44 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::422d:63c2:1a93:6a20]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::422d:63c2:1a93:6a20%6]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 04:05:44 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix refclk reporting for SMU v13.0.6
Thread-Topic: [PATCH] drm/amdgpu: Fix refclk reporting for SMU v13.0.6
Thread-Index: AQHZ4HZFjgqM19ZytkKf6HwPp2ZPu7ANLb8g
Date: Wed, 6 Sep 2023 04:05:44 +0000
Message-ID: <BN9PR12MB52578E215A9FEAAFF9A95F97FCEFA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230906035647.952389-1-lijo.lazar@amd.com>
In-Reply-To: <20230906035647.952389-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c609ff98-2ba4-41f8-a3e2-cad5da63b0d0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-06T04:05:13Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY5PR12MB6384:EE_
x-ms-office365-filtering-correlation-id: e0f0377d-cc54-4482-2a98-08dbae8e8b38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3A1D1Jb0wXO6boXP/xcZvhO/iLjE5CeBLjP5cGzy8TELNwQ5auXiUCRR+DGc7HcDau6FCI/zmMzL0+OXq99fa4n06KdG4yYT+fZlig4ZXQTht42CWTNa3Xt7S74lLzMgy0wHxpJi2EXvjrDfjehp+hmEwBACmsuP2x6l+1hcQoZrMvRumurpncMoIrtat/6wqPPT+cNFDZvWFW6TCLdyvC6suDYlxjRKeURWPtHTuWqdDM8GYDDSrjRhmDPqtu+uQyYHuFJzJkbtfdNk0VSUO7HY62JiFVhGLFTY1CBBuZZcUi3Ru9qbA4p2IoFNHTy1ckcV5nSv46DMlbcJnqHmsL0FlKfHVMDIr8Gj3wtmYEH2YeFoiUClIVL9vQuYM1iDvjrPpC9Ep4l+ihhbX0IXwkzN5TqGrEtLn6wzHWw9fjY0eQsMBJtsc1z7erEpU9A9AcqHd4Xt4swHyFb+qHeVtEB8K0fHp499IYh1H4OLhxU5O9byPKeTl/XOKIlZE3vhUgBf6+fL4blXu+Sg+u9YmAcoMD0y0CWMlNeiCr2x8OKI18bFIIco/fjtb6GGJFBxjp310uIqz1E8kZtcKL+sAjw5xbIkyPJA8OI/zQJbYngnFnSX3wcfqUp9IDWedtf0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(186009)(451199024)(1800799009)(41300700001)(5660300002)(52536014)(66446008)(66476007)(316002)(66556008)(66946007)(76116006)(110136005)(64756008)(8676002)(8936002)(4326008)(2906002)(122000001)(38100700002)(38070700005)(83380400001)(55016003)(9686003)(53546011)(33656002)(26005)(86362001)(6506007)(7696005)(71200400001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n2rsEoq1zm0yz1MdIxBeODisghJ/ebVTpHMgKpRUZijMz4cEvtvE2IdFtyd8?=
 =?us-ascii?Q?vT1QvAPKodyTEULXniDApyM8ypwJSM+unuVsDxdQtctdnTixZ0Qoy8/ANwAj?=
 =?us-ascii?Q?xAsm8R/aIO7Fnbl1BzOIBF4FGVwWKwHSfO70MhVVxcR1xz8Qp7+wbqh6yGIs?=
 =?us-ascii?Q?3Osd6g7Cxz8XmL9ZfMUHOxpsPnYvZ69JojDDQF0ZRDuwVxI7oMLdQyudkm/S?=
 =?us-ascii?Q?z0+dY6Ya/spVj6tCJP3Xjky+q3Kis8RDr9BvkivywwT/AJRal1ic1SBZ9EPR?=
 =?us-ascii?Q?h5EUGkzlqmDvuYjiV+BRs46lToK357nnukb8KCgieFc8B9oG/fsm8PDCevDT?=
 =?us-ascii?Q?pCriXv/lUJ24PGHIeTMFo2NvqZWEsC6gSbVHtp9HTL7pzhDciSbxJdeMyZB0?=
 =?us-ascii?Q?EK6k9lEUfdL0+3nuc1oqEy3bRpeWuZj2NuGRrwYwEylC4BQyiBB9s8wdECub?=
 =?us-ascii?Q?w1bMKJGD+z6H7Vgv7xOT2/gBQc/DgGWEiakIzu+TF2RlT81auNaS0EIfs71i?=
 =?us-ascii?Q?7PmhRKannvtu+ULKKEdawpbkDxUrwYrebi1AIq81xUZ20OUf8GxxZO1c5PD8?=
 =?us-ascii?Q?DnAAQ8uOMPIYIE+miSYFBLISaYhxSpcnfh4rJG+jqbD11Jgu/oLc/yumawmk?=
 =?us-ascii?Q?TWAMlnrFTdPnsa5nZYFu9Bi0YNkz8w26Us8YFZSr1OrPyYvWpwaluG9jrrHo?=
 =?us-ascii?Q?jePaol1qOzqFElH3ZZYFnwG1EZaKnV6ovL5i9CG2CXorhf0yzntFZIBHHPn8?=
 =?us-ascii?Q?fsIKoCJ40IvUfZaYO1o0RPSPUAjMSDOAt7oTONxAckSfaPgDQMht5vfB+xfQ?=
 =?us-ascii?Q?E5SQJOim+0tI1uVEDEcdO0jBAOY9TOn20J9PZOVciw2xDjf8em3QiOnCND7u?=
 =?us-ascii?Q?GMGMKhnpOpOu9CEzsuyBiqLfejjPBbG2efJKlKtv4cadp67tINj3GaNkEKz9?=
 =?us-ascii?Q?+DeFetJXDqRob4sxM/htqNmI2b7pGeJQY/6dUTz+qItrBnWtUGEzGmcDABX/?=
 =?us-ascii?Q?zHAppWsw/bXHGY6qJ5XCPwODiUz6afhpkbKWRYF4OL81A1LHEd3fmL6rvRAT?=
 =?us-ascii?Q?KBrVwUiTyXqTOfhfX9HQ0nSfXTe/X9mhTMetobPNR24Ruhzc1Y5nA9sBmh/c?=
 =?us-ascii?Q?CX8+S/ZWMkKjDOAiHK8ihZHs4hBp+kh1pMXdViSeArkFP1OveQhGOPvY6dKr?=
 =?us-ascii?Q?GePSFqVwdl2f9/qJQmUszvswgoSVytWTG/UH64IuFD5LIvJJgXTU52irM28x?=
 =?us-ascii?Q?R/ikOqC6oEUuw690Jg6AMR75rMabH1heuxAhsEh1Tu/wiHHGcKx08fz/L+vP?=
 =?us-ascii?Q?uTRNizCWxnhZ5n/ZbWFzZvW/DKgfdTYr9iOJEt18KzqsEU3Nh/SIZ+c/m69D?=
 =?us-ascii?Q?Cf5Bd9ShHYUAYfv3aLo+CwmhM+lueF6wFG/fkV2/OTP5uBhc2CpFHI3TmLRx?=
 =?us-ascii?Q?O3jYDHITbEFDIGD9ylEB4rvXrih1hMAf9ncnnpoUzVEOht6iYsmd0GtG1AQq?=
 =?us-ascii?Q?AA5oCpPk6uCHybJZO1vZZrL1yaBeOKVeZQu8mZl8gezTSYzxOCr3a9MG9juz?=
 =?us-ascii?Q?B9VbrjFqPCZI9/BLkNZw3NXWLdLmsvXk24y29Jbc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f0377d-cc54-4482-2a98-08dbae8e8b38
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 04:05:44.6923 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pq2nwokz5T8DMZ/isCM6VrugVYPybIdIj4GUwqbAEsf5zuwZFOaNuS3nnH/2/+5lFgV+F0cSVuBxlm6TzyZ5cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6384
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, September 6, 2023 11:57
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix refclk reporting for SMU v13.0.6

SMU v13.0.6 SOCs have 100MHz reference clock.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index f5be40d7ba36..28094cd7d9c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -325,7 +325,8 @@ static u32 soc15_get_xclk(struct amdgpu_device *adev)
        u32 reference_clock =3D adev->clock.spll.reference_freq;

        if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0, 0) ||
-           adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0, 1))
+           adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(12, 0, 1) ||
+           adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 6))
                return 10000;
        if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(10, 0, 0) ||
            adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(10, 0, 1))
--
2.25.1

