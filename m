Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4D4CAC582
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 09:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F8710EBCC;
	Fri, 12 Sep 2025 09:26:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4RYZM6FR";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BA5C10EBE6
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 09:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohd6vVbv97wcnJwdKUnA0OQYS2hk0V28Tjja7DM6m6uql+9lBkj9bfmhV0/Fa3QHZx2ri/VxP2z5N6O7RiZkc5qWGIC3Jw3jdcDw9PUAEBhW8C35kvdND6iPRhJasbtFvg5ywjqKZJbqIo3i+tUtxVfCaEXYmVjuLOIEv4CiZ6uMJjjUigPYxRs4oEe+XzZahfoXCC7Ox+ztgfpHvbxhX+MsEI6e5ProzqY4iRCF3LiUnS9ODbZS6si+PXczJ1pKKV2IXIb/V8qFR7YrvgxEFcHNwjXLpt85HrZ81BrkAJhjRuEZOeHJqsnWmnPWLiBjc8IvIoEe1D+aU/K8APlngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oelSYNcLZYJHZSppK7L78Ilrj0GViLquG750jANfmc=;
 b=n+gOlEn1CVuAhcDIvhU/M+LwF4agM6jgLnlF0ebIkEU7W1gFrBw6UzAMiTfb0dExnE7irDznIiS3mVSuocH7DEV2vFqTolzKmdpzDAJWL4GVP9OoyiuHY4oJPxX0VM3uKjRyuJc28MZIDe26iJgS8NzBHpKxJXG7ge7s9GFMwcgciCG2YtZufwEx0rbeAjN2ktkUXxZgpnB4yd8v4d8Q9qiQys8tVhJ2xgkmpyEAlBWr85Cnd2QIopBL2q7T0IMtMUFBCVU2EMyEBnYSzY2KLOUgnPahEH6CIz7J10YECAuD4ykGyRxJnlFf3NNa23fdxyUhIlFP69sHR8H0QkNSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oelSYNcLZYJHZSppK7L78Ilrj0GViLquG750jANfmc=;
 b=4RYZM6FRs2o0SxbFzuRTAA0/tll51ykDsClUsC38ZnZXRbKdb7QfOvA7bNsiCdjHk6YlGitDXhl0YKNPOOo4Tq+lkkZtiDQqqmmvpwTSv4cvxczVce9Zk8in7vNYyRVLwTB+/pIPrvYHic5NsOLT5EdUaJOZfyIHp0pPzKZclH8=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 09:26:36 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 09:26:36 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: move smu ppt->post_init() into smu_hw_init()
 stage
Thread-Topic: [PATCH] drm/amd/pm: move smu ppt->post_init() into smu_hw_init()
 stage
Thread-Index: AQHcI7xZ1eczXsqhIkGRuoTadUnUF7SPQNeAgAADrqA=
Date: Fri, 12 Sep 2025 09:26:36 +0000
Message-ID: <PH7PR12MB5997F993C5483CF4B89B42F28208A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250912080734.3121325-1-kevinyang.wang@amd.com>
 <DS0PR12MB7804BB857D2738008AA8E7E69708A@DS0PR12MB7804.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB7804BB857D2738008AA8E7E69708A@DS0PR12MB7804.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-12T09:03:28.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|BY5PR12MB4162:EE_
x-ms-office365-filtering-correlation-id: 241db785-d8f2-4e58-4b77-08ddf1de786c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KTFW+l8wue1sLzeiYnKBMF7hGH1hAO4rn4viyEzCZlFX2UAslgGZMDjkHqAn?=
 =?us-ascii?Q?fBHh24XAiF8XDNHtz4wlzE8HwWThe1MXTcz+Fm+Rog9TvckWW/SCXSHUjzfa?=
 =?us-ascii?Q?nq6iG4aip0no6gIlozuMk+HOwGEEPJMCRhqDMoeTwoy7ZPWKwx1maW9SHn7M?=
 =?us-ascii?Q?BWg2q6uu8CSAjWyidldOykaEAxcN8+jVQmcqd44LwhMOEtBLzSyx6+PHughK?=
 =?us-ascii?Q?PIpimxqxK7mapnVo2D34GhB7cWZn74kQkECqy/V34ao7zWGmHbAVQsMSdIcg?=
 =?us-ascii?Q?N+1fWtYpaP1CgAq9c3dJOOUJkTxJy8sfhXN1Yu1RZezwYklqxTMkyiPhxkSn?=
 =?us-ascii?Q?rnN0m3BrmZyUm+TjfGqzl0IQzZx+7K3IKq2i5uOb/J5aUbG+ajdoYFSlnX7J?=
 =?us-ascii?Q?D2DCk2dhPWgSCe8rp0apMjUNqYcuLD+/wGF6wT03NEk7Az9gJsRsgUxlqkPR?=
 =?us-ascii?Q?Z96A/UqEGD+avf6okv3nMXYR2E2l/17IyoLKZCcWl+HaQ4chiXoUjcBev4Nv?=
 =?us-ascii?Q?uSCLHoI8kOem+UEeRhYIGBKoF5U3rmCIGIxEhQPYrPjKxrUZRKnTiwpzKh3Y?=
 =?us-ascii?Q?Ge+S6nSCZsIYX5+nfvja5nF173+K7QSlIZrdlzznCOIk5B9HE5amE+D4OBGh?=
 =?us-ascii?Q?hmTXhb3kFJP4ElIMDLd5rQ2DdzF43Ia9Eb0DzrqgQQGV5wDvhAtGTD6dHoW8?=
 =?us-ascii?Q?v1hETDMbOfpiiCABCbjcm9JfwZbG8nBMrapNQUYKg+s5HSl739VgnUyulMcL?=
 =?us-ascii?Q?pVfPUqWGc6Re/BE4d60B1Wnkwt5jczQE9srI2cuZLk2hmEPTzsvSB4RInhCI?=
 =?us-ascii?Q?wfseAiVKRNsiPY6S+F7co1l0Vx4jOL1BNQudo9euvT3uxAPPyer/fmk019EH?=
 =?us-ascii?Q?9+alcAS02PybnzLEgFVDfM/+TBJBA4c0NT21ByDtbeQZRO6So2jywlm6qGSf?=
 =?us-ascii?Q?8/b37334ubQ2TT2zO8oIx9bBLrL/MXL0p1Phg+Ic7/W5Nh2jg1Jab5xDx2WN?=
 =?us-ascii?Q?4sggP+FZgRcQa2l6umpzkVfoBN/vIg6U4iUG4TgkostANCq3JxpJX6iAjFqx?=
 =?us-ascii?Q?qdgFi8RGVOgY4oCnTffXSQZy7WugGPrX1OD9I2BYYe8JkfFrWWt2s4x7Jbyh?=
 =?us-ascii?Q?3iPV8uvLbW98tMLK82nn5vHXQI8WqtkVFK67fRkeBIPv2d1vaJip2y0wGvmo?=
 =?us-ascii?Q?9yz2wnnUs2Oh1pAHb8jHMRTEQALpsWEfhoHG6djbc/V5rfsJOq95dzJp/ej3?=
 =?us-ascii?Q?m53Lk5jJHHowpqXtPGAkV2HI2nA3QuCGK+UdxxXc2jpuaF50pylKyvrN5fhY?=
 =?us-ascii?Q?YbhsTehJp2OWGa+gQ9k44zBwCoLiLn4uXOiBQ4swn9726CkqvpE3vPo0oOfP?=
 =?us-ascii?Q?04FVoNThReJ/jX0ZTuAWKXMreuUs//LZUzsqpMbEyfqoDMg1pFyBO9NG/a1I?=
 =?us-ascii?Q?ZyKR5O9caOTK4CcWmrLjof7sYf8eUUy/bj0et9G8V/H7T7oACRovqBhXpT9i?=
 =?us-ascii?Q?C6i5VGZTcxgsAKc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VBI8BU2dFd8vJ41bt/AokVBRiLe99aQFN7e92FxLenzXvK2nsnSeloRPTJyH?=
 =?us-ascii?Q?IH4hRiO+Zne76FOdMC3TmhJO8OBDehRKq/koTdZMc5oEsNZgMAcQcJxxehY7?=
 =?us-ascii?Q?q+nqTR8u+Nx4WbAE1igIo0B9jn9DjqG77RjNHadSGSvldoMiODlCxBErKweP?=
 =?us-ascii?Q?VRLzn6MoyCAFukkICl7xeJhXMxlxh2/ncIBnHLbaHvoK/dBOIsVhqujmKlJD?=
 =?us-ascii?Q?0P4IyU2AW2mvR4aXNsB08MOE7aEkzkPoxHoAZ1MMBUtmPDCPU1RXcAHgCDd0?=
 =?us-ascii?Q?CYKnBljvo62sKArW0LuAf0mN28jmEbyhr7E3naMqL8dQn50ALpu3ap6IoAsK?=
 =?us-ascii?Q?0Q3oET5uHcQQyJIsVReSBLnRWKbvIpzswo24raDA15NC2DZuze9qpBnzHE3E?=
 =?us-ascii?Q?UKOW5IwMQxKIkkontoW7ak+DaVXBNNa52cNgF7ro33QxIzja2/aMegcUzLYy?=
 =?us-ascii?Q?WU83Wc9f1cvf7LX3mMPPpL4vmDCXleJ02tV7mBF5IQlDF3bEkdvizC/RbTh6?=
 =?us-ascii?Q?4yPyn6w9+V51wQzk7W4q7SBhD6B+IaHAcgGh/CwlFXmmlryiG5OgPTQF6/B8?=
 =?us-ascii?Q?ILooDyjZOzPk+PqKq4cLKRUqjvt78DdaNqzBrDZcmLEAPelRa0MryXbAu+N8?=
 =?us-ascii?Q?eq3ShsSnhj4LYOwhD5ZXqlZJBQLKHC6nDWS7GqE1wEMN9r6ysBYNd5mvZJaF?=
 =?us-ascii?Q?C1UV2ZXL3ek/VvqqE/bXxeJHhlnJpFoGHI9iPrNo4rnuJeEiQ1IxDk5iBoGF?=
 =?us-ascii?Q?X8oYaPFWzDrpKJWH/YLN1DTVFLC7dhPLfY4ZNH1/dLwcN1oEItvQbfEEqrDE?=
 =?us-ascii?Q?h2sdHk7jauTDm1oihTLq76aEnuNdqFW6b3l+Q9BaAT5kYR4YNmd0X7d5e8k2?=
 =?us-ascii?Q?TSoIWPPLKpf//hMYhSyEHq3ZW42cVhewz/BrqG75X4ZZzg9R8IDH8uvIaRRi?=
 =?us-ascii?Q?E0ieVsMwrZCy38P/NWMwiZ2yH1ts18/2cXcu4cq9vdc7KNdzPTYQ/7omlMVO?=
 =?us-ascii?Q?hSB1LolBJzg8NllcdSTS5slNlWwgUjw7PTLOl840/jjeKAUnsbYmqS8TO3Lp?=
 =?us-ascii?Q?22SRi0SwVR+NF8sJz9Ux9uM859lvGH6+/fGEk6o7BL0Giu3Lr4uJ76kGcVO6?=
 =?us-ascii?Q?N9UJsdnZUxE5R1lTWPADING6jOScGOD1BGf0DXe5Tw2n89G/FgS6oEIDliWy?=
 =?us-ascii?Q?oDWrxWaQofftOlyEm4ZlBFcnI9KjPecKTCh7udhd63TVPM6uN8rq4rXW8oJN?=
 =?us-ascii?Q?BflYLz4zJ3hzLiPKEgBjzfWAxkhp2Q0NRVOeyhldNhl8vKc442Y/fvpPjC27?=
 =?us-ascii?Q?JxZnZqMQ0b/+cg5+pvbx5CPBRF1luALFyaBBT9hXXMtPhiwpNd/A5sXdXd+h?=
 =?us-ascii?Q?qFzhuxaGZOkXjMqJZ4Rv9l1GvswqxUt+jO0MaRUypnVrCf8DQOyQR8b2fLrk?=
 =?us-ascii?Q?feTgDHyZ6RYOjK8eGiN6d0DsjHZKSsm+bQ3txLBzFZ5zaHBxsKTvdywBXygv?=
 =?us-ascii?Q?pi+In3C1lqBNctho+wDzhqKS3yqrwYCu0BVfpvWD+YZo+KcNfev+Dk3Q9wJR?=
 =?us-ascii?Q?7jFV130gEQvk4uAbgOI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241db785-d8f2-4e58-4b77-08ddf1de786c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 09:26:36.1439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tNBOzGVknDZitzJnzn1rbylNgTIO6qVZ4H9zIckmepyQIO8Ih4Y3BYWv53OiRwoe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162
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

[Public]

>> There needs to be a specific callback to do SOC specific things during l=
ate_init stage. Presently post_init is providing that, I don't think that s=
hould be moved.

@post_init: Helper function for asic specific workarounds.

In the previous code, the "post_init" was mainly used to implement specific=
 WA for smu. If you check these codes, it would be more reasonable to put t=
hem in the hw init stage.

Best Regards,
Kevin

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, September 12, 2025 17:04
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Subject: RE: [PATCH] drm/amd/pm: move smu ppt->post_init() into smu_hw_init=
() stage

[Public]

There needs to be a specific callback to do SOC specific things during late=
_init stage. Presently post_init is providing that, I don't think that shou=
ld be moved.

Thanks,
Lijo
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Friday, September 12, 2025 1:38 PM
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: move smu ppt->post_init() into smu_hw_init() s=
tage

it is more reasonable to move smu post_init() from late_init() to hw_init()=
 stage, beacuse the smu specific hw init should be done before call other i=
p block late_init funcs.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index b140f6fc50f6..f113b1b1b925 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -891,12 +891,6 @@ static int smu_late_init(struct amdgpu_ip_block *ip_bl=
ock)
        if (!smu->pm_enabled)
                return 0;

-       ret =3D smu_post_init(smu);
-       if (ret) {
-               dev_err(adev->dev, "Failed to post smu init!\n");
-               return ret;
-       }
-
        /*
         * Explicitly notify PMFW the power mode the system in. Since
         * the PMFW may boot the ASIC with a different mode.
@@ -1957,6 +1951,12 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_bl=
ock)
                return ret;
        }

+       ret =3D smu_post_init(smu);
+       if (ret) {
+               dev_err(adev->dev, "Failed to post smu init!\n");
+               return ret;
+       }
+
        adev->pm.dpm_enabled =3D true;

        dev_info(adev->dev, "SMU is initialized successfully!\n");
--
2.34.1


