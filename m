Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD923C00528
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 05:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E77D10E2CD;
	Tue, 25 Jul 2023 05:23:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ED7A10E2CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 05:23:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXDgz9HgyIzz72B5uhx+6zpEzdSwfNE9uNf4SZTL6Q3hBBbg9ukxo2+L0JJEC1QiIh9CinZP2YVM+tlzcc/Cap5q7ZxuNQkuPugObk9ahiCcO+N5bjJvDn3RQb/yldiRvgY9Eeo5Ov4Yveru2+PTB4TA1PelWLtnH+nnbX3kvodmpkMx35KSF99YUmud96Ven59xcHezjDPl4f9UUYI74klXls2sg/RZxoQWluPziIIBwDfWqwG5+nPV73ZV2JmuyvmgbgXr18CG2vJWm2MmDloZpvI65XQpW3AOLvPMcoM6Ctof5Fdk4rf77yQDWREIPruv49T60kqI+wjAYCFkbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4II1+VWXd7WllxWnx6Gg9IngNDCLhld2CrGgvLN6tOY=;
 b=Gim6hhxkIJeb5irRKdQPcFBvwDaonrEVCb3tbD3CAF5RTx+jUGx+o/iZdy2DyEbUVi7lvmjsxEFk+4il+7eHEn4wXBXfCETJh5pG/mdXOJmShQ6m+rb9WEmnmqwnBM2DXfcMeJ/1KoBxSsMZPLRz48UOEO0i+QP5H+EuddipkT1HjvLHMtYf/SxTh0ILdiJty08zhFxrC/KlKGgqYj+D6VVB5C8/ta2EMYJwDgLJD3jVs/hUpzFNvP0lDKfZ8u5NR4iw3MQ7JWj/vFmPKA976O633Fck8gI+8iqpeDi8SvFMvJX21r8VmOXv+y44NPAW/3wN7kiT/MR7k9pBtG+O7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4II1+VWXd7WllxWnx6Gg9IngNDCLhld2CrGgvLN6tOY=;
 b=vrdhm2RmrDB2nOs1Ts3Bv25/NJMJM6ysH3JTfDLPp/n+S/vg0njjQ5cfH6kSeaoTqgbM3JKewoabXuiWaSpVhRmtriaIcEunkNY22tBPODso76F5DmqxEmIsm7isTHQke1R/d6DtQcsiMzOU8SOLJWwOdoWl7W1FsaOnTCkI4T8=
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 05:23:31 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::c725:d5a0:a4a8:772b]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::c725:d5a0:a4a8:772b%3]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 05:23:31 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Zhou, Bob" <Bob.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Pelloux-Prayer, Pierre-Eric"
 <Pierre-eric.Pelloux-prayer@amd.com>
Subject: RE: [PATCH V2] drm/amdgpu: remove redundant variable declaration
Thread-Topic: [PATCH V2] drm/amdgpu: remove redundant variable declaration
Thread-Index: AQHZvgnn0bopAvgjV0+ysGuAR8cwaK/J9CLA
Date: Tue, 25 Jul 2023 05:23:30 +0000
Message-ID: <MN2PR12MB4128ED05014F75447D4FB9B69003A@MN2PR12MB4128.namprd12.prod.outlook.com>
References: <20230724083602.454512-1-bob.zhou@amd.com>
In-Reply-To: <20230724083602.454512-1-bob.zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=c89ab7e8-a8d1-45ed-876d-a1519e376b02;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-25T05:23:27Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4128:EE_|DS0PR12MB7608:EE_
x-ms-office365-filtering-correlation-id: 3d5e9fc1-3015-41c1-7d56-08db8ccf48c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6QhwoPfcrN4ZXGZ00e651znN961sAqn3M3VoKHrRjJYgcDkwsU2elhyyltkI9d+7sjhlP9h0znlyY9cDmNHMSeAfnpOWmudjKoCdfMZS+WhsLnJjbKvJF3OmFSlqPSkxoKP90H7MXEpIGTWfulaCUPuWje9xkl+4gazVZuqhA4KDaeliqkrTqL3uCuTM166BFc3gdOkz9XYssp2VtYcsarkY6kDcDJRT49VnszHRR5fkhjazZiaQBa3DuskaqFSHV2JUdIhwj5ff68yaPFkcvCHAc5GP5qmQsnPxek8M0wfRc1XdQNVyYPK3bQnkG3EkHTTVLcnTvG0afx7/0Uj/Dgtg/9/F6r5IBK7hbSmr+WQJuaBYOCxJkF529E3M/JOleg05vJB2FnH01lGCl8zyebbcduXzdtHF00swozWvnjy4y85IVnYTZ5SUxCHqeYNq4dBJarelAiBQzKmNmWgDzsF1mkfEGcoMs36cG57NM3c/IrhkHFtUGXI0DVaEV4w2su5xNcQilKgR66IaEK7tOqxhtclItVy9+alz1g9NnsK8Zn+s90oMeBFwSxWus22pzduaKF2aF2OeCpw0MUa3jACaQSR89RVIrQXF9opqyswDAD0jRTT8+4wp/rVX0yVb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199021)(86362001)(33656002)(122000001)(38070700005)(55016003)(2906002)(110136005)(54906003)(478600001)(38100700002)(26005)(186003)(6506007)(53546011)(55236004)(71200400001)(41300700001)(52536014)(5660300002)(9686003)(7696005)(8676002)(8936002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(83380400001)(4326008)(6636002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jipImy2pRI4IhsoNPXDcZVZwdwQ9X9du8rNgjBu675XVuCLX+4lWM9hkm3kI?=
 =?us-ascii?Q?1z/LOqTKN7Sg/iq/dDcAgFQFu90k/MfB3690uswWc8M4OvW92y8V8EWKa01p?=
 =?us-ascii?Q?f0FAvlB0/UVNqAdv8/Y9SkTv8/oOkE8/9xFyotXE4mTBjxLuOlVURLx3T9K9?=
 =?us-ascii?Q?C8Y/CeDZK/Io7+O5BsmZurS/auoRjcqGIeTHXdo5nsXLysM8pzPT41EM6w4j?=
 =?us-ascii?Q?kYcoGdckANpXJNcQjvus1fygH0kzRx4M09lkAbdK8rtpTeA9m5QZiNpZhiDH?=
 =?us-ascii?Q?hROZSWa2ktmmCGx7hqpiTl18WEJOf9qdh50kJQYkTDeC+cC2DjPqQChA5ZTj?=
 =?us-ascii?Q?e+0d8Ha2DaSesV/nQKe22sN2AHJWTLhfLghBVaZO5s96Hx+1LoNGFPggq4Mt?=
 =?us-ascii?Q?RHtSMVVPpSKuclhvl7sdcfmLdT/jrrOTBTej3xxnGCee+gBqQMNKUjmq6Ywn?=
 =?us-ascii?Q?HIugAO9L4tUqjZ07G8iU+fv2xsciTPY2zVBr+Xd4apOLQ5KJ1k8bjsbox3ZG?=
 =?us-ascii?Q?9Jv30Aj+oWkt/G6UVOdHPNsMm6Tf3s044KcY3/8c5boumS2aHzYbz867Sjeg?=
 =?us-ascii?Q?CbncmbHZclJriW3KHNbjzW5jcjxUoCgm6wmWaFjw8qPKpLO0fT6/kRkYqrOM?=
 =?us-ascii?Q?UUp3MRKtOE0/iq3q8YsabWhD7yPKMjubXun+VG07YWf2ipM3qW6ydmwIWCCK?=
 =?us-ascii?Q?1swuzmG41/Y4wiQX13XUfJG78OHpxR4DzRA6ov4Meg0cPtbpKc5rvOMP3rAd?=
 =?us-ascii?Q?jrLrsqi1PSXSYur4DBggVPzBY4bia3noQ4PfHDl8m/UzMyWcEMomPpGS4i6F?=
 =?us-ascii?Q?qjfmnJxkUgWegrPVNVnIIsl9XOUWBB33KXeEGVIgEBaq9DUOaaxgvz7+IVkZ?=
 =?us-ascii?Q?6DowEbaEOkvXLBV1/chkxjDxhul2SlgI3eAyT2DFcXmfae46fM+lsqEL3ytg?=
 =?us-ascii?Q?pUPSq/xzpiJMH8wqmcHlr/rr1+Px1e+xPKdmU87VJUMzZJMYUFUxa/l7N5BY?=
 =?us-ascii?Q?/4rvoHKAXdrouU7RnMY/81gPYPkTUkqDMP7+iJxTCz1VUetH5toocWSaMaQm?=
 =?us-ascii?Q?DMRgdOO/8urBdtWslIM0q2Dllba54IL+1YO/hrOBGeb6wbSszGPVNzz2r9oC?=
 =?us-ascii?Q?tKAAhUeaIjgLxOniH/UC7FYTo83ow8292SFbdel1C/I7Tj84E93LShfXouWb?=
 =?us-ascii?Q?Ce02KiWEiRF6r54T0d0vL6dmEWxeMIjBXTw24vrxuDHOYJ1nkCho8r//hNNc?=
 =?us-ascii?Q?my/Rpq8HBjS7b6/uCJp+BcpyShsnmtzEKSKpp5/J/+FrOa4jEkPnJQS7chem?=
 =?us-ascii?Q?AV47C6UKr+nDVEJT19/ZuETZbG/6tDNMlDczIuJFLol2jEMzJKCMlybGiHf9?=
 =?us-ascii?Q?FnewKjqJNy0FvK7fhPiT7Gb06DG6wEnmuFgXumpC+dKRxhjHBoHRVUnFSpOw?=
 =?us-ascii?Q?LPdo9BfXs2ufv3BHWYaHd1HW0YyzCSd4ZDsWeWBgowztv8alseRGCBjglGvr?=
 =?us-ascii?Q?KKtJWeqD1RDWY4P1CQliJsXmhWj1hyWgzzRY/SPd/KFT3IuFadJ6NJnlkm90?=
 =?us-ascii?Q?0PwYgCYRDsmwsnfrmbk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5e9fc1-3015-41c1-7d56-08db8ccf48c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 05:23:30.9720 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rP1rg47+b/mBvhhYdCAO4kisMqHBcOx8gxFxUZGug23ROTmkYWg3Oq7qGT4VRoJ+rMNg7pd7BKH0tSIf4bD7KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608
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
Cc: "Zhou, Bob" <Bob.Zhou@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bob Zhou
Sent: Monday, July 24, 2023 2:06 PM
To: amd-gfx@lists.freedesktop.org; Pelloux-Prayer, Pierre-Eric <Pierre-eric=
.Pelloux-prayer@amd.com>
Cc: Zhou, Bob <Bob.Zhou@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH V2] drm/amdgpu: remove redundant variable declaration

building with gcc and W=3D1 reports
drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1618:15:
error: unused variable 'domain' [-Werror=3Dunused-variable] unsigned int do=
main;
             ^~~~~~

The variable domain is repeated, so remove it.

Fixes: d769528e4649 ("drm/amdgpu: add VISIBLE info in amdgpu_bo_print_info"=
)
Signed-off-by: Bob Zhou <bob.zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index 5ac7544cc068..3f98174fb764 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1578,7 +1578,6 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo=
, struct seq_file *m)  {
        struct dma_buf_attachment *attachment;
        struct dma_buf *dma_buf;
-       unsigned int domain;
        const char *placement;
        unsigned int pin_count;
        u64 size;
--
2.34.1

