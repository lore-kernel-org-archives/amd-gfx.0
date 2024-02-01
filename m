Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF88C4828F
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Feb 2024 15:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D067410EFB8;
	Thu,  1 Feb 2024 15:58:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AEOcCaK4";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B461210EF9B
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Feb 2024 15:58:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8kLHApXxB/rfyULmVzLBb1Wd88JhBgtl/e3Q357yHtYSYGNbr9wZwpJqVvdfP3RPD+qcMdRAVDIMAHt6sp435rkvgEoNB4C+1aHeUkxkMuXn+o2m0uXvcL2Eak9e2L//e3xRf9sbhWheNWkNx4Gv7Wje437OyuQwaozI12eTDR77ri3fb5lP5Mu/O3sHASJj7CLvWph9ceqhdwo0h4FFurjlg91yC7Q1x5uBAWcXf3TtGIB7/zhvPqHUUhvppQVmRvRtyJ4Q2T9HPCtnXdWuvKN230vQ7ra2QLzFml8ad1/2g3d7oJqvXq8eHSWFdXAoU5Udlfrx8jRWTi3Gt+CZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGC9czRDAIG+3kMtQG1GWmJxuLIWe6F6HA0ahskpGVE=;
 b=dCUiUfYBjZxZ9fzAvy/jpRuyPbPetlGLHoPhCAiSq1ukXzzNSDDOtUDGS7Ze7FHueIsqeRCzKYfel3zziaz6ZHr5gdEGozhyrYkebblMLn8sfaInb9tEBhmtS1VUfvHQtjS/Qj7jjNiUP/p3T1snV8RAQMhBiZIWrhsN0xOa3ocVzGKWQgL0FJuvEmRodVQTH7wYQI6gw/TOGUYveDfEypUoE28UKnxqe6DyzGw7dIi2ZPi5B+xWafqt3hpq5DJGYe5t/tIUH+9IiKb4KhCEHlapopFLUrqnMOXxNGBApVFCpTYq768bAZhWk3OsGnSgfF+/89TsOO+G1a8/K/+pkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGC9czRDAIG+3kMtQG1GWmJxuLIWe6F6HA0ahskpGVE=;
 b=AEOcCaK4ZCBNa+rBvbaAKk3Gqb+zAzDQfRvZVMyCh7jCzSBb5tdImadi8hcPzSclvohtO1Fsy5yynU1Iii5Er2qKjGf674JZ7JG6Ycecr1vW7384V0FDLpvA4Cz369BubDe8p5IKjNupmgYYJ6lg996iAWF8k3+E+WgW/Y6tNnM=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.37; Thu, 1 Feb
 2024 15:58:04 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::a9b:c00b:eb51:94a0]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::a9b:c00b:eb51:94a0%7]) with mapi id 15.20.7228.035; Thu, 1 Feb 2024
 15:58:04 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Only create mes event log debugfs when mes is
 enabled
Thread-Topic: [PATCH] drm/amdgpu: Only create mes event log debugfs when mes
 is enabled
Thread-Index: AQHaVFF5NSZy+tiNpUy5noQvYvvJeLD1pjdw
Date: Thu, 1 Feb 2024 15:58:04 +0000
Message-ID: <CH0PR12MB537217E8CEC612D674012493F4432@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20240131142600.679750-1-shaoyun.liu@amd.com>
In-Reply-To: <20240131142600.679750-1-shaoyun.liu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d405d546-5491-496d-bb1d-8e6c48a51328;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-01T15:57:58Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|SN7PR12MB6863:EE_
x-ms-office365-filtering-correlation-id: 262eff2b-ac61-48bc-6ea8-08dc233e9332
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vu8Qx3e3N6CrBuFOJXiPCs9/HuerD6zKHR4CwnoKNVr+XLm8LPdLDGsHCi4gayd0mb4e/MtNHz/NTueeZoqW3+IRu/HvMOxjHO0rStd6n4AASlVq0liLcr1oWa4ccnSDXAd6TsFU3QDKniRKWHOJyijKlIcRN5tsCQFXUm9sfaEQbUyV5VLPoOnOO+RZEG2jD7gZMa2WZ9zD/IYrijQQ6llQO6hyZqnae93RXRz4R2rbCU7FtKtzUafQEfdKLKXPf5PD2BiVHoy2gE+HwVrUQMD5RkxyLuzMZvwbdvn6ratmacQ0/YySre83iArBIE8pnpjCBdCYgS+o823EtA+t8oS3xtp8cLgMvbYZHatPG32J+/bYZd3BWeSbg2dO9k/8pmpX9Qu1z/zUrZdb4kyQCdBayIj1QE7nu8GnFcvV8QepPz/DjtoNLS+zD6fvjQPym2s3hqC2Rjq4jiKzkfovh9JUeVo8aSsjG6/uk/VbNrhijF9NqrjKb16gevBXk5ijOh4igIcepVo4lJk/y8Ps4D2l3QcjT1CY6WgQLi+vzQ4qt3U+xkH6v6TMppCPbWVrkhrJFGxdG1/0s/S8b0qWfaPL7gWZ/UrEDRqGGR7h7Qim2fIrqm+bgVXZplFsd6KL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(55016003)(26005)(83380400001)(52536014)(33656002)(5660300002)(7696005)(6506007)(71200400001)(9686003)(53546011)(38100700002)(122000001)(316002)(86362001)(478600001)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(8936002)(6916009)(8676002)(41300700001)(38070700009)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hjGeedq8Uxjgi98ZJ8aidkxRMynnf7SE7vbFmoXEHeKBClLCTyxaftRzs8uw?=
 =?us-ascii?Q?yElqkbRWG4JK4knR61LFKyS65Nc6Co3hRa0uLIF7PJc/ZlpJxxTDzOIahcWT?=
 =?us-ascii?Q?Bd2oHSMe8mjGczsusyp0koFyUIrbYFTsTQ8okTePTmNkfh8L0okSKIEeFSVa?=
 =?us-ascii?Q?D8xTw7KKmZ2XKe/ZFOq0rljo8KefBnBYYlX8liv+Lou5ZnagAZj4XknWVTm+?=
 =?us-ascii?Q?RjHgBjwklbfrhxD+geEZFr5wr0Y/e5DO0wdmJy41u9zk8HFVYyv1KZx7nJvr?=
 =?us-ascii?Q?9rV9dA1Si5Rrt6Mcw2NETINsNvlF6cQI3PCWGzCj96BjaNu6O0xwXWXrtq1e?=
 =?us-ascii?Q?1MLK2q8deOvYYf2UV7g9ABoaHCovwMArELuP7nPN2nRq6AxruD7UIvE2NyVQ?=
 =?us-ascii?Q?fVx9vP53a0WErLVCNWz8wwoOJaXVM65ov9ytjTvgza6/1zPGGBSreff/+cb8?=
 =?us-ascii?Q?bEChJ8NeAQHLPCivyOvUxFl3JLbewJja2Tu2C4cwYkGewBdcA1zbSVroRz8w?=
 =?us-ascii?Q?x462ZEtOfpOCO13/EGnE0mDcGIg5aSwMUeJPxkBoj96W+7MxPwTzt6nAZyDN?=
 =?us-ascii?Q?gV4TUFQEhIq9LvAsdB0a8xtLGtPIWiLfqNJqa35RGepJf67ZMJaxCVRNwCmz?=
 =?us-ascii?Q?QpaN643uN6qTmjBynhSXo9dABL+PbwjOgSdoImU1c06twmcGlM1MMOVjpz7D?=
 =?us-ascii?Q?h+dVPbIXuGbJpuBXyslTZPC2p+oaC8fZOTmqmnsxP3E171YcLjMyWyPa3B5D?=
 =?us-ascii?Q?KjH2kwo53r6dwI4auK8qmcieETUGxZvMA7RjT0zYLCl4R4Dmk97+SzrUNqcB?=
 =?us-ascii?Q?EVj/Ec2X5+ubfrx9La3rukAAGgGVb1Dbavzeb1A2GhIIr2cfN5+Q3/uL45Je?=
 =?us-ascii?Q?a213mHwuXyzraw7AIxPeNvlIAbXFbDPRziL6uAtuKZnsr4TyLHA6kcIHUb48?=
 =?us-ascii?Q?1ZKWeeSW7O9/cXKj+dCGTsDXvMyWEYv84mX8YzyvaQ8onrZTtTxw4ce+t7iA?=
 =?us-ascii?Q?5dyFb8g2BOqwBSd4nuOlVfVzY2nXa6YBDrgcowghZns20UBYaBMwrOykp3l0?=
 =?us-ascii?Q?d8lA9voQXNkksK0cT8RVOtnoSZOyxjfdmICgpxmd8IADkfPlYHvu/fvtnP0s?=
 =?us-ascii?Q?TxZ2KA6hE4e+i+zWXgTwchHa8HEQDlj7fhPXdFNq+8DP46LpczyUUxRCjt9T?=
 =?us-ascii?Q?p6wutVoT0P+JKPfXJ/TWS8l5z/ySBhYAUxwV5pvo2hwidymwyIPErfCpi7PK?=
 =?us-ascii?Q?M4F0swe/O/olJ4tjsuLNaXPqi6wFrQ8YqiRE0qJsjdmrV1DepAIsDeXJqL0G?=
 =?us-ascii?Q?YJGE15hMOgKzFMOKWo384elSCoCxty2TEXLdS1VGG9RxnAMXPxrEnEy8Xhid?=
 =?us-ascii?Q?HtoF9OwwKNZBd6xL/8FqBLkc+2/jZmHWr9ayhtynWSwHgvB29edlYm0zKu1X?=
 =?us-ascii?Q?koKIB5toSbUYU+lr1HDmenxrAbuzFecA6Y7+Vdw4t6+itYHlI4RNnncuPH3y?=
 =?us-ascii?Q?/6IcwXb1CtL2fZ7hhexTcgAR2zzKMkCVmnwKPhQawtw8ntCP/kame6OLTw0o?=
 =?us-ascii?Q?iQuQCxpX21Gw9h6aFdY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 262eff2b-ac61-48bc-6ea8-08dc233e9332
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 15:58:04.3773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8amqHCvnG/fNBUi56IkV4WCIy8xe8Ou9qKq020ZimXmHxpPnkSI2ERXWPUcFu8RU2SnBa+xVbbyZMCWS1xdh0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863
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

[AMD Official Use Only - General]

ping

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Sent: Wednesday, January 31, 2024 9:26 AM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Only create mes event log debugfs when mes is =
enabled

Skip the debugfs file creation for mes event log if the GPU doesn't use MES=
. This to prevent potential kernel oops when user try to read the event log=
 in debugfs on a GPU without MES

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 0626ac0192a8..dd2b8f3fa2f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1565,9 +1565,9 @@ void amdgpu_debugfs_mes_event_log_init(struct amdgpu_=
device *adev)  #if defined(CONFIG_DEBUG_FS)
        struct drm_minor *minor =3D adev_to_drm(adev)->primary;
        struct dentry *root =3D minor->debugfs_root;
-
-       debugfs_create_file("amdgpu_mes_event_log", 0444, root,
-                           adev, &amdgpu_debugfs_mes_event_log_fops);
+       if (adev->enable_mes)
+               debugfs_create_file("amdgpu_mes_event_log", 0444, root,
+                                   adev, &amdgpu_debugfs_mes_event_log_fop=
s);

 #endif
 }
--
2.34.1

