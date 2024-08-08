Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1166C52D6F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 03:00:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB8210E55C;
	Thu,  8 Aug 2024 03:00:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0vXRiTW6";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5EED10E56A
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 03:00:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jc6DdUgLh5qKTSnxVSDqdk4JIJ9774cKbca84gytFFBSAaKysazbhKge6WjBbQIOMB5t9O8jY3VEpQwutrEMYfMAIaRzWnQE+uhspFLwt6FNj3cdlqu6Vs33OBOcmt4Txw0029EE3quiR2sgjlqtibpHuDBQBB0RfrwvYhvhTNoQdOCgBXbZ79DdWkxvWCDnDCOKdGWwHGeck2NkUIAg7fCYnNKhh/5a18jrUcyZianTaOdCB637/CaxZ91M+cPinNMxu+fjHfBvbeG6hEtUr7tzCGEMC2luNsjKk1GArKre03pQkWnXJd4OK8z/RvPb0b7YolmotIDtl4ygHE1rCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVQW71AY9Fz7aN4RewseNaZPgwy5CPWD+9MnRd/HhTQ=;
 b=W5g/FbsxBuSyxAThEXguAxEUo+en/bDfZcSkfi7KjV8BehWtmb3JNRFj5dqnf66VvE7bTip8s4lgkhSat9QoUjsNq099+56KZjbRP9juKbu4hrIOXGgSQ8BknJNdvNmBfew5LoSziG1KsJwQZmmvS119IIscRD+QlUU6B3FQdncme+veQTUYa202XIp68IJOFQwnzOV5nvluCtlXpupaoxcYVYajYZKEEBZqh0bhjW5MnXjQKt6jcQeOZzaUZcyZku3fouYKdhtdj6a9L191lFf9YO9nILyn94U7fE7SN8fCXadD/j6cOwhDduQSXjD7JEGJY+gESEu7X6ZEGGhW3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVQW71AY9Fz7aN4RewseNaZPgwy5CPWD+9MnRd/HhTQ=;
 b=0vXRiTW6w5BAln4RmTpoEHH3B1HMGOTLu0B/1YkVXdD5tvhvVsyKnY2THQ8oHBY7z1+QTlHrR5LmRhIYpNicGVrJZ2XWGbdL+UByX/0pqmGeKnCPhZghEDBRe4aJUKZMyoUqe+Y4X2jPCv44s6R2F9sTQ2tOVikhZAtCDoh/DkU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 8 Aug
 2024 03:00:01 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 03:00:01 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xiao, Jack" <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 0/8] enable mes pipe0 and pipe1 for unified mes fw.
Thread-Topic: [PATCH 0/8] enable mes pipe0 and pipe1 for unified mes fw.
Thread-Index: AQHa6K2oz3L2FECyNkGqnjEnbD/H/LIcrKlQ
Date: Thu, 8 Aug 2024 03:00:00 +0000
Message-ID: <BN9PR12MB52570C62A245DE387D773DCCFCB92@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240807093847.2084710-1-Jack.Xiao@amd.com>
In-Reply-To: <20240807093847.2084710-1-Jack.Xiao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=86dfeaa0-aaf9-44c8-a673-0d52175abd2e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-08T02:59:39Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH0PR12MB5677:EE_
x-ms-office365-filtering-correlation-id: 52b132e2-81ab-4fd1-125f-08dcb75631d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?rT7voyUKvlf7zeULufRJjxJb7Gt7x1VOcYQtwWBzCYzGfRqzXxnTjXd5VLOv?=
 =?us-ascii?Q?nYzKiMYSVHExS59/4v2u4JIMr7tJWhtoZu2eKCXxicaNn+s1caghDv3Lh8qA?=
 =?us-ascii?Q?ittUHiEEVEdqXIFUZRpHQ3LymawTyw9chDUATqIcyGWVr4fsWLAu82i5Kzp+?=
 =?us-ascii?Q?OdZWbILQQDD9MyQYkidPiKyTZVBuvklFKElhwPc1KMbdjE1w9n8fZFWnV0ln?=
 =?us-ascii?Q?n+LylHxVvgh/2YLKsTdPR7a3juJrp/td4obDOzTaFYbGxplHeoUjHp4sPToP?=
 =?us-ascii?Q?mfeKuF/54qZd5Nu6oT5seThvBuv8/YurbZEzcg0c7IAAGOIq+o6CbRquDP9y?=
 =?us-ascii?Q?c+ALSscWh3oH3HxaERC18lDhbvjHTXd83ly2LIcjklL1ST1WxLHOQzxEuMZj?=
 =?us-ascii?Q?qk1gCWFGkOkTtanIA2Dq1ecC/in8EDSzQSmKpP/0n8qvT0WF5GVWhl+S60J8?=
 =?us-ascii?Q?Y+2NzUrSaGCH9VRv+UTtT33yAEreHNWle2RnYbE+K9M2vpMP1AswJB3PHYCE?=
 =?us-ascii?Q?CXvqZI/eF+zF/f2IHxIONJUGCLBg2HKtjtiyYUOv8FgB82jGCiwbrs4cK7Ef?=
 =?us-ascii?Q?wyJ6LvB0Lkfv5lfcSWlgxrMYU4FeHAnFVHfPBoFeWwJj7zcfaTC2nntyUxwe?=
 =?us-ascii?Q?5hvDDK3Bj3MfxQrQIWTaQmuWBmdMtekz+O7VpgOZHTz+7IDiQRx3g7UPk//1?=
 =?us-ascii?Q?3VTGMOHejTJeir8OIiDiC+Dh6AiO1v9NDCVzBPLJv/KFr0tW6a0C2v2Q826T?=
 =?us-ascii?Q?jQFo87VeOvFTKPQsx9HZimuMFfA1NwqwKq6SHXwtFrZ5zp+SX3ANrA0/XAxr?=
 =?us-ascii?Q?9jgBs9nC6Z9rJgEriRpGSZTEKM+Ndz2EQ4qvKnzixCJRwiZoIcVBB+Sj1/pZ?=
 =?us-ascii?Q?AsesjFqkt5QRLBux47mAplPJ2ZSQWBe/ieUBfS47G06aXoLqXo9YUjDcbMgh?=
 =?us-ascii?Q?Y3N31D7ojC18O/IukDC/x3kotFzFain4NPxwe0PmLj3JBlTfGErB/lWQHKys?=
 =?us-ascii?Q?ts7KS74F9z1FgCRKI6fpKcKZl6wsXTWLNNXPioSkA6jwNw4joqA9X3PLxVBJ?=
 =?us-ascii?Q?yPV/TCX6ZVruH7V1sY2p7n4UbGjbSVyh2NigilnFgbeMoSVe3fTREXdSPDTQ?=
 =?us-ascii?Q?U4uMJzEW3DjBn/ndoSgv2kSS+2vBGLttj/H3UmOCRCo8Y9WFYMekkok/JrIg?=
 =?us-ascii?Q?Yg65UHtTUVw5jHy+boCbuqlHkg1WsnO7gLZiJJRenLyOGLuJ2BKNqa3AWsCu?=
 =?us-ascii?Q?wKlEVGO9ECYBZ+60A4+TCxhlMqtqI/F0swh9dJxmOZnDtJgalYpPAMNTwPWC?=
 =?us-ascii?Q?NljcgEJcDb7Aaus/M1BDQBKAax0d4iZDRR7q1FfJFt4enYn/py+9Qln5WzNK?=
 =?us-ascii?Q?npfsZelI5MOvYK+31aPuAxKsOTrVOw+phTtPaCRPKnO1bdWorA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AMqgA0nK2BOsTIGV6nMYplqdktU9MRADX+bOXDylrdt3WvQRWQ/lnHGu+nGV?=
 =?us-ascii?Q?DFIzt+RamrZya43PSAy+arBaaL3BdJMshLSpjBz1Ktvjcs98AhklxIHp8qq1?=
 =?us-ascii?Q?Tjhf35AKqHqfpekGWzje1bIiEAKRVsknzLGfRxz7BNDk+FovnYWvGcleiE7N?=
 =?us-ascii?Q?3cQevZOMT+QeBUrENdbUZN916gImKW9pvp0e8bZkstmSjfIk7hHl9aCbGdj3?=
 =?us-ascii?Q?NWz2UTKq5NZ16d110UN2HPn4rcLTHszU7CJMoVls4GzjKJY1Gdnp7UZ6dyLO?=
 =?us-ascii?Q?lWoH1EuumzARGk7qnJRK3KMOu/zXtkITZReGcNT+EiuRHNmN0zxLKsH/qHVK?=
 =?us-ascii?Q?bodynz1AY6jHqEcRI05r+WAybietWp5ype3VvQgw/aU/aGXb69gvGwl/reEV?=
 =?us-ascii?Q?Hf/C5WwT1JtWIW9ikYSEdgeL6cUfEwkV4tJiAWSq2/YnRJnxAwhFiecnCRke?=
 =?us-ascii?Q?clj8bZETTt98MkiYGFJAg+MXAPxAbSTgas8K6MheuD0fw9aBxcnC61HiqMyX?=
 =?us-ascii?Q?V5JUpIdUjCeWwFCD52JurjeheblN3WrvmtJuGnfLyJ1jni0gx6AdbH3wMrQh?=
 =?us-ascii?Q?gfNtBPLIMyo1ALGdloFwAyZ4ZgTk2NFclWE0GawRLoxQlqJbabP4TjpYhrJw?=
 =?us-ascii?Q?9aCB43Na296pH69rqfW5gpcVciNOftSwII8RPI4hjiTDsp/RHucqbSc8NfIA?=
 =?us-ascii?Q?+HwQElywG7+ygAfW5J5nLrD79B9wvjw1s+OJhasYIcRSpq3/F3o+REJOs/TQ?=
 =?us-ascii?Q?au3thbHPGe/bRVhVDn/pvLFDOF85NTZ1Ar2QvBR3tGsGIZMw8MevHlcDGHPd?=
 =?us-ascii?Q?NuRxGUEX6/Du/Qb6EnrVYWv7aMQ83Mr5+yxCXOBuo4iKu7nGNszhaqfyW2MZ?=
 =?us-ascii?Q?xVeeaGyv0RYGVnOp0h98xCD/u39ti+jgDeanp0lYMbWOxxZ1gzoDs1uqXfDr?=
 =?us-ascii?Q?Ef4gbd18k1rYAxFynXVksZxlvdR6u05r6tvoiF4HHQWB/OqHvBOy6JrlJICM?=
 =?us-ascii?Q?A5v/1tYA72DTs3C74Fgdn+AuB95UZfOvMQzvIxHLXwYS7IRUd1npH4Jx53Cs?=
 =?us-ascii?Q?+zz04z8nmxvOSeH2yprYqp0+Axyzs+m2FdHOigFEBaXtZ47EnAc+EzIQTN0s?=
 =?us-ascii?Q?9hF32Rrccfq6mEKuSH0hgQWAvL7PL7lpmDB6to0OOvjZUo6WKbqU4SBUKjir?=
 =?us-ascii?Q?K23Iiiji4nFzlwudClBcO4gTuFbSe173xu38k1kga83wEkDpfb9otIi+g0ck?=
 =?us-ascii?Q?tNI6A2PLCdxAqSuAoXyyEpVNe5emFWZOcx8Y7drZQTqdPOD/YxQWLVKNwIQZ?=
 =?us-ascii?Q?ug2Am1DZLGYDvhmjS9jrRBsAUTV0f1a/0pSaB0vtfAmoKXyzscJn4E7LUSTE?=
 =?us-ascii?Q?ZOb6jOqh1RdRUI/gS83d6BP22H9PS/6TN1imN7QhDITWxsQD9E5u60JwBdTG?=
 =?us-ascii?Q?osn6MckC1ygdanfdc375+SFGnCPUWyThsBdAYBEjlYf9pJcPAWtNjFf+v8H3?=
 =?us-ascii?Q?aezRmDIOW44XmtmvQgUUynK/TYOShf96gN6HRJgyOV99BjNJfy/G8tiIyfWS?=
 =?us-ascii?Q?Tla8mY3ZhTErZmxokSO8lF0aLVOJIuErdwz+mNFe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b132e2-81ab-4fd1-125f-08dcb75631d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 03:00:01.0300 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OkDPRtDEiTOJrZChjywDO1y+ym3e+K+sQ8yGrYIhG2edTpfH6v/ovSfbbdtuS1SUjNSHJlkNrkrl0utgfmMsfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Xiao, Jack <Jack.Xiao@amd.com>
Sent: Wednesday, August 7, 2024 17:39
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Xiao, Jack <Jack.Xiao@amd.com>
Subject: [PATCH 0/8] enable mes pipe0 and pipe1 for unified mes fw.

Enable both pipe0 and pipe1 running unified mes firmware.
They are almost identical pipe, but pipe1 behaves more like legacy kiq.
As per fw design, pipe0 is required to be mapped by pipe1 to make some fw f=
eature work.

Jack Xiao (8):
  drm/amdgpu/mes12: update mes_v12_api_def.h
  drm/amdgpu/mes: add multiple mes ring instances support
  drm/amdgpu/mes12: load unified mes fw on pipe0 and pipe1
  drm/amdgpu/mes12: add mes pipe switch support
  drm/amdgpu/mes12: adjust mes12 sw/hw init for multiple pipes
  drm/amdgpu/mes12: configure tow pipes hardware resources
  drm/amdgpu/mes12: sw/hw fini for unified mes
  drm/amdgpu/mes12: fix suspend issue

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  26 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  83 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |  27 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |   2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  41 ++-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 278 +++++++++---------
 drivers/gpu/drm/amd/include/mes_v12_api_def.h |   7 +-
 11 files changed, 262 insertions(+), 227 deletions(-)

--
2.41.0

