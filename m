Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BDDC83F26
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jul 2025 06:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 239EE10E88C;
	Thu, 24 Jul 2025 06:25:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lgDZMZOh";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DCB410E88C
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jul 2025 06:25:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWRegvkF0V3C/3TpM8PqUxZMbs4A5yAOknrReL10mo52Mt/8TFrMwYg3A/ISAkPweroax1zuUPojBsreu0NBAQXno9p97Y7C8SY5wI10xdIOJoSkBZanieP9Gzs7KAFLtgzUGwBgXA7r58LFzdYZThDQhYesR6V8v1yVobSUpnURh3DYLxNf7Q1RFJV+NpvRYIwSifC4BaMungf2I6KK9dqzk2Yx6ZuG5JbV/QgTZ05Z+ywkrbV1kC2X4TurNoI07YKIoDgVZ1CPsK3kKQLzRqH0qL/78sYgt9UCvUl6DDXDPwUYhB58JpK7LWmbpiSaw0B9iQykyZtkIlOe4m0qnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXOV/7bCtSNLebhCovYjT155nvoGMPfJCidvrakYarc=;
 b=NIZsTdYHF/8uoCmWlqCa89ROlwDNQuBrQVZghHNA6M8vvPZe7fsKyt0RmhDNhWgn3+Kkx2lOTWBHq2HoserUWJgwOI/zrt7HFbIERt0NtZqypSGKO9EYmP8VYLj9scCG2qwKTrCeK5Fr5DnmSPdqAgXQkYCllvXrdeSK7p+mdvCEAznfOVT0+Q6sOJdtMFJiXP9goBRb8TQvrdO+12KvsV6lYO4+O+WdBOq1PNtc2WHkW+fjl/3jVDgT94ZGxBFlmWGNJyGRh1u6oHB5IHLRi9WmNQc14IFK/BMF1ToX/K9al56CjMytJJkcu62dgcjWrCW1Bv6IOanosF9U/tk0NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXOV/7bCtSNLebhCovYjT155nvoGMPfJCidvrakYarc=;
 b=lgDZMZOhy//bZ9rdLbE1ttA7l9llJqP96dfwZFlkAYmx3QQThIbBBVqf7KEbg7rVKIyaJPO2s6qgyxK6QjfVpjNsHmHNbURvWY7+LvjySCEr7yn9HsIVR5zxp/itn3DcqnWFdqa09zJsOhadt4k359M7Amt1aquRtEixgmWe4zk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 06:25:41 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 06:25:41 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Log reset source during recovery
Thread-Topic: [PATCH] drm/amdgpu: Log reset source during recovery
Thread-Index: AQHb+5DesKmTSkc7W0+UgjAGv2gbKrRA0FQQ
Date: Thu, 24 Jul 2025 06:25:41 +0000
Message-ID: <BN9PR12MB52570594831E8B21E82E79A9FC5EA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250723051526.1596437-1-lijo.lazar@amd.com>
In-Reply-To: <20250723051526.1596437-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-24T06:25:20.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA1PR12MB7296:EE_
x-ms-office365-filtering-correlation-id: 4270b556-99a6-4169-32e3-08ddca7ae9e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?xU3F22TkWfLv/pMDtA+tBaYUxgCp2n0iR68s6vkFhY449S3UpvLWV99vq2eU?=
 =?us-ascii?Q?lU+h+/aSv23kjgbQBirJwPE71csrPs4wEUFWzyMG4tHz/KWmN2jkOFY1wQsi?=
 =?us-ascii?Q?qMio7QPJXR/PXoikZOocxiHbBlT+MkpAcPavEWW/mvIZrgZo66tiCV0psmXk?=
 =?us-ascii?Q?XAiQef+J9U/DQwvV09LsaE+j5PIFZ/xx/0XAjeFHHkv62VIXo/tmkpewfGqp?=
 =?us-ascii?Q?2KmDbUPl/oQiGj9rDRQTrFhA335KwxG7lN30YSywTN1rb6uW/H0SPJ7YbZVC?=
 =?us-ascii?Q?OyNzfOXuHRtj5fllBI826pIuSgOpH/gSO/PiD8TjXEpPE1rouJzY/j2i6Fli?=
 =?us-ascii?Q?vTXOyZUCa/2x8zHfm9JMPPeXattKDtnxGzJAH1ZhY1AsSSMlbgv/OuJsBqdr?=
 =?us-ascii?Q?EUlTOC0GSaaGZnzswva5EgpVB9G9OcWfvzGNNLq8kmxFwcNWsTajD7l2187c?=
 =?us-ascii?Q?4svHqLtr/s9FZ4cJB2+/QdiddT19KrIrzEKmhPVVHxpT26Xnl/J5RyhxyfNF?=
 =?us-ascii?Q?79Qh+rMvgnCBME6KCWgiTTp/koW5mIdzuvsFXPcTgZgCkyjuOn8cNZdiqWnH?=
 =?us-ascii?Q?2QFT4qa2HQ7PqP/YIq7R2TfCOtHrTLiI20txywxph5GuZzio6sPtDUrFo/3h?=
 =?us-ascii?Q?oVOh89V8h0TZtrWn8GmdWejqi6eXtI+9YN/M/m6orHVJV8kC8U1I/XFvUl/d?=
 =?us-ascii?Q?fV/M/ibgi0LetwopQOLosPTQQogSU1NGg2bogePpKkMvFsU/vMHFi9rHKa9F?=
 =?us-ascii?Q?th54TtFD+T5QbWYLFXTUVrPFDXIXctCDn2Jwi6VcH4DFyv90E6x+s1W7FhS2?=
 =?us-ascii?Q?DpYPGUeR+3OU/QIUcrsHFjRMGGpLSnBKOMM/+UTmE1q+xULhNYq9rsVgQGOO?=
 =?us-ascii?Q?nesL0rr9CRUYxtAM6WD7gaLue9ndD51h2Nfr1ZSKR7H8OYZmzhXKL72wqadw?=
 =?us-ascii?Q?eQppt1tvqYLkkBQ8ZGD/QLSUZH6hrWsrBD0Ml7EITQEbcDpn9jGOzMgdFF3F?=
 =?us-ascii?Q?dWiRdpEqIvmf0/tp1Fwtdz/P8yXJSVPwlofCli8O+AehZ2TgZStpzuhrqgkv?=
 =?us-ascii?Q?xgD6mDPnsghwggCxwqIQV5Z3h2de0SIkPdp6lr9uHCa8Wb8d/xFfUsX+oedS?=
 =?us-ascii?Q?BpQemOyTtN447NbETQqKsZsU5mFZLKUJbvbBSm629S+hELjTv05vlSoT9LVw?=
 =?us-ascii?Q?QWXIXfnu2mM3IGsdF/XooM8V/JXNeOIv8dZvsOPnu2RmP53gSOg2YfR2FazM?=
 =?us-ascii?Q?AXeOfuwmlDyEEo3Azcobx9Rnt35OUX+AvTz+6ckZdWzhzgXXmbJK1AjNu1gT?=
 =?us-ascii?Q?OOzt9W2OecT4oMozVKBcx7mdF+MAk0dC4DU8cNPs07gF5F8XP8UuExAZ5647?=
 =?us-ascii?Q?5di857V7EtVOdooax3qSDbwYWNR1pad9xmSB17Xbp+YLmOe8GAKfUVb1IIhi?=
 =?us-ascii?Q?I/ByRPS6sdDd0AlszOWRG2Xv/UBodIvxAMQOwr+3kPY6IsdVekPtXw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H6JndlUywXXfTOdk1bqgcw5SolRU2M5OKXtYk3dgsAfoH7Pv+M7B27CC8I8v?=
 =?us-ascii?Q?JYRkeFgFPJwtNx5ipVp7ZxMaTkbF7YNxEuOGbtjwzRknlEptTrzs5LgmySgL?=
 =?us-ascii?Q?ZKx5aYSp8rbjn6h9wpgt0jiPD9HAa2EKfxAnFTLgfqqbtuDfDJkWgrvp4e8m?=
 =?us-ascii?Q?xMHEfRjlh77N9x8M07JEJXFtR9eZdmMXfbdj4uYCrpUgdkRjVJe7MMDx06ZX?=
 =?us-ascii?Q?iDqKn1JgEoga0sQooeXpQcIfbD1BJd3ZxR7+SHoGAaZnBczp0fTm65n3S1tz?=
 =?us-ascii?Q?l4c+eh4YH9b4mdL8GqgC9j2YaoLCxPdHdFhvzY+Be3l8c1pDo2gFOKR2HFR3?=
 =?us-ascii?Q?gTUp2xj572GMkeCSdxDk+4j+0F0M1AjWRLBPw+GqVASBIEL2g4wuEq2ejDKl?=
 =?us-ascii?Q?z3SKR91z3fzdoTndL9y3agTs4QCxzNFtzvkMMGHRQniQHXwgiDeN3zbNR4eV?=
 =?us-ascii?Q?Sn5YSLxm5gStkmh3AL/GEOV0gOWuaK/L6WTQ8EIGnaoqCAhD/uurVxk61xiQ?=
 =?us-ascii?Q?yXzGrla2Nx1ejOxKWniJmH+YvWdJ25/FsGcL163Ynp7Ey2aUfG2Sit60SD9G?=
 =?us-ascii?Q?qERhn548S/jZuLCuKZwurpcqyAxP6P89vOxXz7wSCF8D0MvjIYSXBA9RIjX/?=
 =?us-ascii?Q?sTRpbEBn8IRKe+Y9/rtDQ+4BGuRu73cttT0382mjL+Qp/3JHjvCKrCv99sB3?=
 =?us-ascii?Q?/LKGf2ei+21mCPcrWPfhPNHR9BJEyPPeCsEvPLr5W4jXCnVcBNoQHDALIYxO?=
 =?us-ascii?Q?f+FVHQAIIybXEw5E8qtq0abD/UsZsXiIt27NStrUCrlEukzDKtLpwDB5MAjN?=
 =?us-ascii?Q?AtIlX2ROaWidHuB55XsOc2MtrSlBL6uxJFNdU2BUhf953Mv5NuvOQ4RC0EeU?=
 =?us-ascii?Q?nxLiGBU6E7cMtNQ6aItVVAHldXL3Lr27GuQx9G733IlDh53BKSIJ3frXLPk2?=
 =?us-ascii?Q?5gzUKZcN4ceLVnjOaVRvMAllCta9koaZCbju380kZeiE8ITxe2Laud9o6W/R?=
 =?us-ascii?Q?YwsQhxqmWEsRn8fPrA94bJWcFvxhru9SykmGNyid11Z09CcVU0RClcUGaUYG?=
 =?us-ascii?Q?ih5Bp+PhF2NuHOk1vJmK0wKJ9ZQqUPyUzs2jxxIm7hJHGOAnYH0N4AUM5ey7?=
 =?us-ascii?Q?fP/FbklgReK3gtXukYJbeXDHyqitPXHWiN+hNlJishWHom7CDVcYo3QzW+g3?=
 =?us-ascii?Q?sbm0FthuMS4Zhb8G59QIu5vbQnz/c10EPu/A15tUPYNqoeSJ2UwvgPO89nJ6?=
 =?us-ascii?Q?IiTEIhDK+vpZpZXKkUpJJBpiliDoCwOtRtcD8M7v9CLtpY5Ad7q8WlRVbeLO?=
 =?us-ascii?Q?nrgioXEjiajqz0QpPXmGEIDKmq7vJt3DSn5wQDp0gLiLvN5ueK/czivgw41+?=
 =?us-ascii?Q?a0y0s7ibFr59rON8xbtIS2kwkTaFAWqjOgZY34pHYS4sMFzZfXK/SfyDcJ/g?=
 =?us-ascii?Q?6F/dg5wTuh4SEaINSKxZg2iFcsdHxQi1pOrztU0vCihWHgtC/jZ4KdrgHWsR?=
 =?us-ascii?Q?8VecmTDMEmSUCWuD2uuKXeIP3L3xoaTFGQ4FSlI0Nj7IQH0H9lZ0fLIGuRie?=
 =?us-ascii?Q?QDqKwvrrjXjT3hpi3PmBQgeSbTn2/EFRf0DUWg/8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4270b556-99a6-4169-32e3-08ddca7ae9e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 06:25:41.5112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0bCb4ILcrk66o/2zAjEHjionPvDA/Y2jjGRh/DVESJ98GcdMIECljIe4cJDadbFpiSw/P9cCE7noUz0q6tGn8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, July 23, 2025 13:15
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Log reset source during recovery

To get more context, add reset source to identify the source of gpu recover=
y - job timeout, RAS, HWS hang etc.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 685cc602357e..4fe74341aa13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6442,8 +6442,9 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
                emergency_restart();
        }

-       dev_info(adev->dev, "GPU %s begin!\n",
-               need_emergency_restart ? "jobs stop":"reset");
+       dev_info(adev->dev, "GPU %s begin!. Source:  %d\n",
+                need_emergency_restart ? "jobs stop" : "reset",
+                reset_context->src);

        if (!amdgpu_sriov_vf(adev))
                hive =3D amdgpu_get_xgmi_hive(adev);
--
2.49.0

