Return-Path: <SRS0=hpB+=NE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF16FC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 11:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 690AC61042
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 11:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 690AC61042
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F01C86E5CF;
	Fri, 13 Aug 2021 11:46:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F536E5CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Aug 2021 11:46:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7jUGvX4NQozes0lOpKf/jALrRt/n2RG9CQNrNd2Pfz5aqK8e21DBuwXG/EpRYO0pvSuhAG7XIzZFRqJu/DcWOlz8GLR9iCj5atIJL+RrlUZguQ0552UGr+Vzxadr1jhgaWwZ9sgSUOTRaIKoOKq7hWNOhymg64cuv3XrF28WfUeWBDSVM5sf0uusqR/hpL7PRFhPwUZMRKdCAovOzqD/DYyMDhs6kno+RyrrgAV7e5DNf+KwyfOhPcsPujXO1E+2KZ7Zifd9skpgLQGNeKtuqfkHYkM8wLfs9JYutZT3JzndtNysbqSNV60CcrBCKuGby3y7+WmXtlOb6HRncI6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPht36T4doGLMayg9rPnqgcXXGOSAB15fX00/cxCE98=;
 b=TRpwXUtxCUaU9LY2kPO2NaSXiv8voz7LCYLhbK84JXeC7v+wWaEKJJqNdNgwJIJ3O+XHtYZT4pLgnGvKoDJ7p4DbnjrsHo3CXepTfGKzcZPwJiyBDWsIsO9wIpK9w4uTLJoKww8BavTmMa+3oTV6ouJzCLZBgjkshAm1tCIlTyLQoqBULIyvRAUIJvlTTKONf3lm9uh1sWsVNFGJAKqHHAjraZ9vZR2V+7dWLV9wmoqoa5HPc03y0RF7yl4oH1C1GXBKazEeB0VmPmrjy2hnguqjbutuooJTX+/VI+Y3A0Bg+q0EpWyFtccOBXUMkCozwnsxHeWqnDzQENspzeSJzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPht36T4doGLMayg9rPnqgcXXGOSAB15fX00/cxCE98=;
 b=JgmaS0j/k2kZfPrlAYtkcCljQpGSyjoc3agCU+0OrzE8nMDOmGJPtv6vAye/dt0HuLXjO3Ni4lg5SRCL8PKHQkkqyb0JgtC8DEbWkQLPYkmJ6zSVcPLkgZvfXWPPGtCCj1WfHpO1+Bmp4IzVR9jtwOjQIB+y0vr8JLDO1wD3UWI=
Received: from DM6PR12MB4649.namprd12.prod.outlook.com (2603:10b6:5:1d1::32)
 by DM6PR12MB2730.namprd12.prod.outlook.com (2603:10b6:5:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Fri, 13 Aug
 2021 11:46:27 +0000
Received: from DM6PR12MB4649.namprd12.prod.outlook.com
 ([fe80::8851:2bd:769a:14b9]) by DM6PR12MB4649.namprd12.prod.outlook.com
 ([fe80::8851:2bd:769a:14b9%6]) with mapi id 15.20.4415.020; Fri, 13 Aug 2021
 11:46:27 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Clements, John" <John.Clements@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>
Subject: [PATCH] drm/amd/amdgpu: remove unnecessary RAS context field
Thread-Topic: [PATCH] drm/amd/amdgpu: remove unnecessary RAS context field
Thread-Index: AdeQNskhKJjxWjtYR+6ZkMW2ppJQJw==
Date: Fri, 13 Aug 2021 11:46:27 +0000
Message-ID: <DM6PR12MB4649355F3251E0EA3FE7743091FA9@DM6PR12MB4649.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-13T11:46:24Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=45831505-1f6c-4427-a379-c45988518013;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c57406f6-1688-41fa-0846-08d95e4ffc14
x-ms-traffictypediagnostic: DM6PR12MB2730:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB27301C1C49705AD79284E35891FA9@DM6PR12MB2730.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:34;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lILuBDNDv/E0UhKmuqnRRXiY8VktGqgHEZgOESyOQFkKrZXYvdInLleAGtHdlZHwg+9p8cM2/9+ASpnh8dgwGYRLKrdl7c4iWagWVI30gWny4EYZDBIkPAsZhCRirZk4TT+aJ8Jt7vKf3XtrrO6lA2zhHBSGsQ4sjQFgIAGkuHQgm3rBc7Q6K2lCqYJNG/ZMXph3EQhJ/u6NdappxzcwW+8vv49cYQNjtM8wemwIBZOGyep+0prWJnkHUdYmkCYsxIpmIxKm1Ch6SMRhptckoqQvb6J/0tcdT0cia9b+d61U3pxUKYEbVkZr1Ekxn5p9ShEhBDkJA4bRYPUUgTvgnCH/g+ao/OgfOowsJNpEV/BkLwJZPF3NuC6NPhrSW1RrjCqZz20MsUUMTEc/a/OHEwPctUqYN9WWuAj7HJjsvdr4duEPH3DawSUPv2nqJUsCjdIk9fMA/j570JgBl5NOSyAE4U556LrQwW1TT8juaz86lt5/+Qb9ZjrOYbBgmDq4k9nwsxyIgLpgmF3pE7J8WBG5dSpDarlrSCTLQgMhOa6uH9si1PqoFPJPvnl+xChuFFsXxHsRnfVcyRx8+JbYHKkozsXknOwXegd2+4iA4pSZwYvTEX/44S0Ya1weV3E7X22VpQu6cKvlwmvCwl0mL2PF37u3VzU77u15uPO21GqGmrPfWW2yiPL/pAcDMZpdUYJTNvoIuOAdQ4yGChqqxA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4649.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(38100700002)(122000001)(52536014)(5660300002)(9686003)(38070700005)(2906002)(54906003)(8676002)(8936002)(55016002)(26005)(71200400001)(7696005)(33656002)(316002)(86362001)(66476007)(478600001)(66946007)(6916009)(186003)(76116006)(4326008)(6506007)(66556008)(66446008)(64756008)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sFv/7Y5Oo71tdWdpLL4Ur69TRugCPTi9GaD5FeTnf6baQ3aF3NRB2KvrV1XF?=
 =?us-ascii?Q?zeNTYAfjklty4dVYzxpCfKM6G5l6Be4x61B2wINfYcdPLUVjByDuVo68s/ta?=
 =?us-ascii?Q?sKRWlT83W/949Zh+VvPCl8l4mi3OgKawfClLh9FUWO818SczPcME/GAvFNVx?=
 =?us-ascii?Q?tikpHqt15DePX7lJ7Smddvlp9xfhiBBPaVpX0FPCKwItylzFshxXuTuf2jek?=
 =?us-ascii?Q?qfhGVMWdPs2f5D64MuwaHkklO649wyuDhtnAA7NnetB6cTqlMKlue/KPGzVY?=
 =?us-ascii?Q?Ugx+B1tLhM/lnGsSrj8c2BaV2mtXa/AQMptg7qNpQhSUeRxWYl1yqRgznn8c?=
 =?us-ascii?Q?Sf0VZJmauEu2WEd6v5+7HSMf8Bl4VAtdNpLnPQGN/UgevnyD4FQVf4UMRbuF?=
 =?us-ascii?Q?lyIxJ4o+2u9ub87pDuMK9rFjtaYzE9isOnMPqmH3jzCY4mla+WdsOQrrGg5W?=
 =?us-ascii?Q?07HR56O4GAD/Bg8ZGPURqXi6WJEcGQRausLSUG327iPzfri2SU4yLgrqeCFP?=
 =?us-ascii?Q?z1yHGk4+fNX9bzBRNBC9R+M9b5tbLQrP/dOp8geqV9K6j1R7MnWA4aHpEMDu?=
 =?us-ascii?Q?oL+MZ35EDsVmHY2MIc3+gCPzlCBvk51oDuBAGcUKYFAx56bIUm4TNdc15JA3?=
 =?us-ascii?Q?sA23Z4L9QT2/P+sVQWPnw3F1WdybBgxelsOufue00zemmA7Bd9D3HIvz47rH?=
 =?us-ascii?Q?puIKWOo4W8hMmZP3pOrQWedvtCTdP+YkGM/HB5FoRF4Gm/zeE2/OfVsb+Uh8?=
 =?us-ascii?Q?Ttjgj0FPfy8oD5z3q1vYnapDsbkFiPQ1NvUveCqb/gUwr654kIiqazQGDoss?=
 =?us-ascii?Q?CQ2342t7TSCfYoJiMZC9ikqwWXMPVKDsyaLyLYnVG8PZzrMf8rC5Jo+sKS0m?=
 =?us-ascii?Q?li3G8KtBMTBnXFr0XRTG3fMHZtSauIt+Y1+1wh2nRzlveRmDuNYW0qV3o75q?=
 =?us-ascii?Q?Z/ADYaduBwokd66f8VTHqY8nvu3hWPfWwp0CSCsU7FIl6aj6J3eBkEOpRNu1?=
 =?us-ascii?Q?ZwNsOXEEF8cNgWcrE/WQ8lOCRXljYYKoHlLT78AUS7RB4fUd/w1b3LEES0aK?=
 =?us-ascii?Q?jmisNYXK+p/3C/f9rCYd6yWr/mvEighLUNUuBDePqhla5xDSCvZyO/dy365/?=
 =?us-ascii?Q?wIp8dKTV17jBEahNsRUbcESr7SumvcLLu/79SjjpTQVRssCWvxGQ28AjFR3s?=
 =?us-ascii?Q?dwCJAhf3LgHbgizd9ndJyiB3D9XsAjTUg/6ILZLpPyTK7P+oL0IINoQ2wpVD?=
 =?us-ascii?Q?TfJRREG/zuSP2JPXZudKTaze/E7l7iwJJA1U/rREPUv6c0fpTzVQD5z73TaN?=
 =?us-ascii?Q?QJGf0nNOJGzUlByokKKNuY7J?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB4649355F3251E0EA3FE7743091FA9DM6PR12MB4649namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4649.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57406f6-1688-41fa-0846-08d95e4ffc14
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 11:46:27.3255 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KoumeP+5VDwykRGWkIMXMxT0V44D9Q9vN8grY8T/wOC3NYKlbFXv5GiRpYJIdghk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2730
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

--_000_DM6PR12MB4649355F3251E0EA3FE7743091FA9DM6PR12MB4649namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Delete ras_if->name in the RAS ctx structure and remove related lines.

Signed-off-by: Candice Li candice.li@amd.com<mailto:candice.li@amd.com>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c   | 1 -
drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c   | 1 -
drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c | 1 -
drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c  | 1 -
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c   | 4 +---
drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h   | 5 +++--
drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c  | 1 -
drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c   | 1 -
drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c  | 1 -
drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c    | 4 ++--
10 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index 9cfef56b2aee..5beaa7c1bd11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -615,7 +615,6 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev=
)
                            adev->gfx.ras_if->block =3D AMDGPU_RAS_BLOCK__G=
FX;
                            adev->gfx.ras_if->type =3D AMDGPU_RAS_ERROR__MU=
LTI_UNCORRECTABLE;
                            adev->gfx.ras_if->sub_block_index =3D 0;
-                           strcpy(adev->gfx.ras_if->name, "gfx");
             }
             fs_info.head =3D ih_info.head =3D *adev->gfx.ras_if;
             r =3D amdgpu_ras_late_init(adev, adev->gfx.ras_if,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_hdp.c
index 1d50d534d77c..a766e1aad2b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -41,7 +41,6 @@ int amdgpu_hdp_ras_late_init(struct amdgpu_device *adev)
                            adev->hdp.ras_if->block =3D AMDGPU_RAS_BLOCK__H=
DP;
                            adev->hdp.ras_if->type =3D AMDGPU_RAS_ERROR__MU=
LTI_UNCORRECTABLE;
                            adev->hdp.ras_if->sub_block_index =3D 0;
-                           strcpy(adev->hdp.ras_if->name, "hdp");
             }
             ih_info.head =3D fs_info.head =3D *adev->hdp.ras_if;
             r =3D amdgpu_ras_late_init(adev, adev->hdp.ras_if,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mmhub.c
index ead3dc572ec5..24297dc51434 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
@@ -41,7 +41,6 @@ int amdgpu_mmhub_ras_late_init(struct amdgpu_device *adev=
)
                            adev->mmhub.ras_if->block =3D AMDGPU_RAS_BLOCK_=
_MMHUB;
                            adev->mmhub.ras_if->type =3D AMDGPU_RAS_ERROR__=
MULTI_UNCORRECTABLE;
                            adev->mmhub.ras_if->sub_block_index =3D 0;
-                           strcpy(adev->mmhub.ras_if->name, "mmhub");
             }
             ih_info.head =3D fs_info.head =3D *adev->mmhub.ras_if;
             r =3D amdgpu_ras_late_init(adev, adev->mmhub.ras_if,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_nbio.c
index 6201a5f4b4fa..6afb02fef8cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -39,7 +39,6 @@ int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev)
                            adev->nbio.ras_if->block =3D AMDGPU_RAS_BLOCK__=
PCIE_BIF;
                            adev->nbio.ras_if->type =3D AMDGPU_RAS_ERROR__M=
ULTI_UNCORRECTABLE;
                            adev->nbio.ras_if->sub_block_index =3D 0;
-                           strcpy(adev->nbio.ras_if->name, "pcie_bif");
             }
             ih_info.head =3D fs_info.head =3D *adev->nbio.ras_if;
             r =3D amdgpu_ras_late_init(adev, adev->nbio.ras_if,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 3811b6b6a192..96a8fd0ca1df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -64,7 +64,6 @@ const char *ras_block_string[] =3D {
};
 #define ras_err_str(i) (ras_error_string[ffs(i)])
-#define ras_block_str(i) (ras_block_string[i])
 #define RAS_DEFAULT_FLAGS (AMDGPU_RAS_FLAG_INIT_BY_VBIOS)
@@ -530,7 +529,7 @@ static inline void put_obj(struct ras_manager *obj)
             if (obj && (--obj->use =3D=3D 0))
                            list_del(&obj->node);
             if (obj && (obj->use < 0))
-                           DRM_ERROR("RAS ERROR: Unbalance obj(%s) use\n",=
 obj->head.name);
+                           DRM_ERROR("RAS ERROR: Unbalance obj(%s) use\n",=
 ras_block_str(obj->head.block));
}
 /* make one obj and return it. */
@@ -793,7 +792,6 @@ static int amdgpu_ras_enable_all_features(struct amdgpu=
_device *adev,
                                          .type =3D default_ras_type,
                                          .sub_block_index =3D 0,
                            };
-                           strcpy(head.name, ras_block_str(i));
                            if (bypass) {
                                          /*
                                           * bypass psp. vbios enable ras f=
or us.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 471ffe885fdf..abc5710898e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -53,6 +53,9 @@ enum amdgpu_ras_block {
             AMDGPU_RAS_BLOCK__LAST
};
+extern const char *ras_block_string[];
+
+#define ras_block_str(i) (ras_block_string[i])
#define AMDGPU_RAS_BLOCK_COUNT AMDGPU_RAS_BLOCK__LAST
#define AMDGPU_RAS_BLOCK_MASK   ((1ULL << AMDGPU_RAS_BLOCK_COUNT) - 1)
@@ -306,8 +309,6 @@ struct ras_common_if {
             enum amdgpu_ras_block block;
             enum amdgpu_ras_error_type type;
             uint32_t sub_block_index;
-             /* block name */
-             char name[32];
};
 struct amdgpu_ras {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_sdma.c
index de91d29c9d96..65debb65a5df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -105,7 +105,6 @@ int amdgpu_sdma_ras_late_init(struct amdgpu_device *ade=
v,
                            adev->sdma.ras_if->block =3D AMDGPU_RAS_BLOCK__=
SDMA;
                            adev->sdma.ras_if->type =3D AMDGPU_RAS_ERROR__M=
ULTI_UNCORRECTABLE;
                            adev->sdma.ras_if->sub_block_index =3D 0;
-                           strcpy(adev->sdma.ras_if->name, "sdma");
             }
             fs_info.head =3D ih_info->head =3D *adev->sdma.ras_if;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index 0c7c56a91b25..a90029ee9733 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -41,7 +41,6 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device *adev)
                            adev->umc.ras_if->block =3D AMDGPU_RAS_BLOCK__U=
MC;
                            adev->umc.ras_if->type =3D AMDGPU_RAS_ERROR__MU=
LTI_UNCORRECTABLE;
                            adev->umc.ras_if->sub_block_index =3D 0;
-                           strcpy(adev->umc.ras_if->name, "umc");
             }
             ih_info.head =3D fs_info.head =3D *adev->umc.ras_if;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index 258cf86b32f6..2e47bc446700 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -663,7 +663,6 @@ static int amdgpu_xgmi_ras_late_init(struct amdgpu_devi=
ce *adev)
                            adev->gmc.xgmi.ras_if->block =3D AMDGPU_RAS_BLO=
CK__XGMI_WAFL;
                            adev->gmc.xgmi.ras_if->type =3D AMDGPU_RAS_ERRO=
R__MULTI_UNCORRECTABLE;
                            adev->gmc.xgmi.ras_if->sub_block_index =3D 0;
-                           strcpy(adev->gmc.xgmi.ras_if->name, "xgmi_wafl"=
);
             }
             ih_info.head =3D fs_info.head =3D *adev->gmc.xgmi.ras_if;
             r =3D amdgpu_ras_late_init(adev, adev->gmc.xgmi.ras_if,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_4.c
index cef929746739..1c94a14fc18d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -372,13 +372,13 @@ static void nbio_v7_4_handle_ras_controller_intr_no_b=
ifring(struct amdgpu_device
                                                                           =
          "errors detected in %s block, "
                                                                           =
          "no user action is needed.\n",
                                                                           =
          obj->err_data.ce_count,
-                                                                          =
           adev->nbio.ras_if->name);
+                                                                          =
          ras_block_str(adev->nbio.ras_if->block));
                                           if (err_data.ue_count)
                                                         dev_info(adev->dev=
, "%ld uncorrectable hardware "
                                                                           =
          "errors detected in %s block\n",
                                                                           =
          obj->err_data.ue_count,
-                                                                          =
           adev->nbio.ras_if->name);
+                                                                          =
          ras_block_str(adev->nbio.ras_if->block));
                            }
                             dev_info(adev->dev, "RAS controller interrupt =
triggered "
--
2.17.1




Thanks,
Candice


--_000_DM6PR12MB4649355F3251E0EA3FE7743091FA9DM6PR12MB4649namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p class=3D"msipheaderc10f11a2" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#008000">[Public]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Delete ras_if-&gt;name in the RAS ctx structure and =
remove related lines.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Candice Li <a href=3D"mailto:candice.=
li@amd.com">
candice.li@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c&nbsp;&nbsp; =
| 1 -<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c&nbsp;&nbsp; =
| 1 -<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c | 1 -<o:p>=
</o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c&nbsp; | 1 -=
<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c&nbsp;&nbsp; =
| 4 +---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h&nbsp;&nbsp; =
| 5 +++--<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c&nbsp; | 1 -=
<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c &nbsp;&nbsp;=
| 1 -<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c&nbsp; | 1 -=
<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c&nbsp;&nbsp;&n=
bsp; | 4 ++--<o:p></o:p></p>
<p class=3D"MsoNormal">10 files changed, 6 insertions(+), 14 deletions(-)<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 9cfef56b2aee..5beaa7c1bd11 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">@@ -615,7 +615,6 @@ int amdgpu_gfx_ras_late_init(str=
uct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.ras_if-&gt;block =3D AMDGP=
U_RAS_BLOCK__GFX;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.ras_if-&gt;type =3D AMDGPU=
_RAS_ERROR__MULTI_UNCORRECTABLE;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.ras_if-&gt;sub_block_index=
 =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(adev-&gt;gfx.ras_if-&gt;name, &quot;g=
fx&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; fs_info.head =3D ih_info.head =3D *adev-&gt;gfx.ras_if=
;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ras_late_init(adev, adev-&gt;gfx.ras_if,<=
o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 1d50d534d77c..a766e1aad2b9 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">@@ -41,7 +41,6 @@ int amdgpu_hdp_ras_late_init(struc=
t amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;hdp.ras_if-&gt;block =3D AMDGP=
U_RAS_BLOCK__HDP;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;hdp.ras_if-&gt;type =3D AMDGPU=
_RAS_ERROR__MULTI_UNCORRECTABLE;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;hdp.ras_if-&gt;sub_block_index=
 =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(adev-&gt;hdp.ras_if-&gt;name, &quot;h=
dp&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; ih_info.head =3D fs_info.head =3D *adev-&gt;hdp.ras_if=
;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ras_late_init(adev, adev-&gt;hdp.ras_if,<=
o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub=
.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c<o:p></o:p></p>
<p class=3D"MsoNormal">index ead3dc572ec5..24297dc51434 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c<o:p>=
</o:p></p>
<p class=3D"MsoNormal">@@ -41,7 +41,6 @@ int amdgpu_mmhub_ras_late_init(str=
uct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mmhub.ras_if-&gt;block =3D AMD=
GPU_RAS_BLOCK__MMHUB;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mmhub.ras_if-&gt;type =3D AMDG=
PU_RAS_ERROR__MULTI_UNCORRECTABLE;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mmhub.ras_if-&gt;sub_block_ind=
ex =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(adev-&gt;mmhub.ras_if-&gt;name, &quot=
;mmhub&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; ih_info.head =3D fs_info.head =3D *adev-&gt;mmhub.ras_=
if;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ras_late_init(adev, adev-&gt;mmhub.ras_if=
,<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.=
c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 6201a5f4b4fa..6afb02fef8cf 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c<o:p><=
/o:p></p>
<p class=3D"MsoNormal">@@ -39,7 +39,6 @@ int amdgpu_nbio_ras_late_init(stru=
ct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.ras_if-&gt;block =3D AMDG=
PU_RAS_BLOCK__PCIE_BIF;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.ras_if-&gt;type =3D AMDGP=
U_RAS_ERROR__MULTI_UNCORRECTABLE;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.ras_if-&gt;sub_block_inde=
x =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(adev-&gt;nbio.ras_if-&gt;name, &quot;=
pcie_bif&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; ih_info.head =3D fs_info.head =3D *adev-&gt;nbio.ras_i=
f;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ras_late_init(adev, adev-&gt;nbio.ras_if,=
<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 3811b6b6a192..96a8fd0ca1df 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">@@ -64,7 +64,6 @@ const char *ras_block_string[] =3D=
 {<o:p></o:p></p>
<p class=3D"MsoNormal">};<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;#define ras_err_str(i) (ras_error_string[ffs(i=
)])<o:p></o:p></p>
<p class=3D"MsoNormal">-#define ras_block_str(i) (ras_block_string[i])<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;#define RAS_DEFAULT_FLAGS (AMDGPU_RAS_FLAG_INI=
T_BY_VBIOS)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">@@ -530,7 +529,7 @@ static inline void put_obj(struc=
t ras_manager *obj)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (obj &amp;&amp; (--obj-&gt;use =3D=3D 0))<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_del(&amp;obj-&gt;node);<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (obj &amp;&amp; (obj-&gt;use &lt; 0))<o:p></o:p></p=
>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;RAS ERROR: Unbalance obj(%s)=
 use\n&quot;, obj-&gt;head.name);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;RAS ERROR: Unbalance obj(%s)=
 use\n&quot;, ras_block_str(obj-&gt;head.block));<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;/* make one obj and return it. */<o:p></o:p></=
p>
<p class=3D"MsoNormal">@@ -793,7 +792,6 @@ static int amdgpu_ras_enable_all=
_features(struct amdgpu_device *adev,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .type =3D default_ras_type,<o:=
p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .sub_block_index =3D 0,<o:p></=
o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(head.name, ras_block_str(i));<o:p></o=
:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bypass) {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;* bypass psp. vbios enab=
le ras for us.<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<o:p></o:p></p>
<p class=3D"MsoNormal">index 471ffe885fdf..abc5710898e8 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<o:p></=
o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<o:p></=
o:p></p>
<p class=3D"MsoNormal">@@ -53,6 +53,9 @@ enum amdgpu_ras_block {<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; AMDGPU_RAS_BLOCK__LAST<o:p></o:p></p>
<p class=3D"MsoNormal">};<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">+extern const char *ras_block_string[];<o:p></o:p></=
p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+#define ras_block_str(i) (ras_block_string[i])<o:p>=
</o:p></p>
<p class=3D"MsoNormal">#define AMDGPU_RAS_BLOCK_COUNT AMDGPU_RAS_BLOCK__LAS=
T<o:p></o:p></p>
<p class=3D"MsoNormal">#define AMDGPU_RAS_BLOCK_MASK&nbsp;&nbsp; ((1ULL &lt=
;&lt; AMDGPU_RAS_BLOCK_COUNT) - 1)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">@@ -306,8 +309,6 @@ struct ras_common_if {<o:p></o:p=
></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; enum amdgpu_ras_block block;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; enum amdgpu_ras_error_type type;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; uint32_t sub_block_index;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* block name */<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; char name[32];<o:p></o:p></p>
<p class=3D"MsoNormal">};<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;struct amdgpu_ras {<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.=
c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c<o:p></o:p></p>
<p class=3D"MsoNormal">index de91d29c9d96..65debb65a5df 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c<o:p><=
/o:p></p>
<p class=3D"MsoNormal">@@ -105,7 +105,6 @@ int amdgpu_sdma_ras_late_init(st=
ruct amdgpu_device *adev,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;sdma.ras_if-&gt;block =3D AMDG=
PU_RAS_BLOCK__SDMA;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;sdma.ras_if-&gt;type =3D AMDGP=
U_RAS_ERROR__MULTI_UNCORRECTABLE;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;sdma.ras_if-&gt;sub_block_inde=
x =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(adev-&gt;sdma.ras_if-&gt;name, &quot;=
sdma&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; fs_info.head =3D ih_info-&gt;head =3D *adev-&gt;sdma.r=
as_if;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 0c7c56a91b25..a90029ee9733 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">@@ -41,7 +41,6 @@ int amdgpu_umc_ras_late_init(struc=
t amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.ras_if-&gt;block =3D AMDGP=
U_RAS_BLOCK__UMC;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.ras_if-&gt;type =3D AMDGPU=
_RAS_ERROR__MULTI_UNCORRECTABLE;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.ras_if-&gt;sub_block_index=
 =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(adev-&gt;umc.ras_if-&gt;name, &quot;u=
mc&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; ih_info.head =3D fs_info.head =3D *adev-&gt;umc.ras_if=
;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.=
c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 258cf86b32f6..2e47bc446700 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c<o:p><=
/o:p></p>
<p class=3D"MsoNormal">@@ -663,7 +663,6 @@ static int amdgpu_xgmi_ras_late_=
init(struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.ras_if-&gt;block =3D =
AMDGPU_RAS_BLOCK__XGMI_WAFL;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.ras_if-&gt;type =3D A=
MDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.ras_if-&gt;sub_block_=
index =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; strcpy(adev-&gt;gmc.xgmi.ras_if-&gt;name, &q=
uot;xgmi_wafl&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; ih_info.head =3D fs_info.head =3D *adev-&gt;gmc.xgmi.r=
as_if;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ras_late_init(adev, adev-&gt;gmc.xgmi.ras=
_if,<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c =
b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<o:p></o:p></p>
<p class=3D"MsoNormal">index cef929746739..1c94a14fc18d 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<o:p></o=
:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<o:p></o=
:p></p>
<p class=3D"MsoNormal">@@ -372,13 +372,13 @@ static void nbio_v7_4_handle_r=
as_controller_intr_no_bifring(struct amdgpu_device<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; &quot;errors detected in %s block, &quot;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; &quot;no user action is needed.\n&quot;,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; obj-&gt;err_data.ce_count,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;nbio.ras_if-&gt;name);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_blo=
ck_str(adev-&gt;nbio.ras_if-&gt;block));<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err_data.ue_count)<o=
:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&=
gt;dev, &quot;%ld uncorrectable hardware &quot;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; &quot;errors detected in %s block\n&quot;,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; obj-&gt;err_data.ue_count,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;nbio.ras_if-&gt;name);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_blo=
ck_str(adev-&gt;nbio.ras_if-&gt;block));<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;RAS =
controller interrupt triggered &quot;<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"color:#44546A">Thanks,<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"color:#44546A">Candice<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB4649355F3251E0EA3FE7743091FA9DM6PR12MB4649namp_--
