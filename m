Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351F3C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Oct 2022 06:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B66D10E9E6;
	Fri, 14 Oct 2022 06:07:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 448F310E9E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 06:07:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPyf4eQjAALa+QAD7swEXERfGQh+TeZ+UdIUrEPRtsnUiZqgVaon8vxWfB1pvMsmgpufB1hjIgJzz4QCFx0FkRHq7WXMM2gg8kXp9miLRP2UaTK+IUerjwOZWO0RJgrPYHBL8Hm3EOlkNrgO3mLSLkUIq3U0z3DXO2gm3o59eH/yyF8TYJne9qX37EoNKD2mnDIKq6LHuynCYBKn+OVvEM+8CQCuflb1mYQRLDPyelNydYtY9EtXXJsZEmWkuROy/HQEiBNn/VyfIaljOKgDEfHOtiEz5oOZFx2/mRF3lvdDEreixktpfdhJzogc3pz6RYiR4khXpl7pc46hz3XAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ia7btkQhF6WVbVK1IiuqNMKS0Q2/ryeXw1gyh91ZENg=;
 b=ngoowFDLhtM0KIcS54CQi6sa4w5E5ZqImIkaoZ2rlugoDA7D3vsel2h+UsNpDeziTdC/s7gHnr44Xdo8dMnWprTO2T4UrPd5g5EzLYRtwpVC6lggJyYXftPBjIJ6CVmoyBXGtp9r+ljPLnOA3QUp5fgyhOhiiQZNLY+iO0eEBaXiUoLbdnUSQrJ+TcafyTXFpn3D6SMJI12m/VD59cpWM+V8O2GMz2NJtKORdnaC/burKUNhPMpJWjNJ4TwCbWmbGQZE5IjRbsBxedjAcU/kBOO6HGJY6ufgJYqbqQNKx5amHiDhtvY4I+h4342R/HeKNawtypN2/1Unc2lNdcgOjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ia7btkQhF6WVbVK1IiuqNMKS0Q2/ryeXw1gyh91ZENg=;
 b=A8CEl3AStH+qzx6ZqMBdK2rWRYeKAKL6ntIrQA8h5ByO68PmcffJ2pw1DRfkXzdetACkZ+k732sgZ3LWFB94UVq7pWTIRRRRFkBcYMxsOn68KgAd+HiXsqWxeBzThQgBFyItI48TdPh6jFLMURh4DMz8Lbw7V8w/Rm+L7g9FYLE=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by MW3PR12MB4521.namprd12.prod.outlook.com (2603:10b6:303:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 14 Oct
 2022 06:07:25 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::c986:1d1:2237:adb9]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::c986:1d1:2237:adb9%5]) with mapi id 15.20.5709.022; Fri, 14 Oct 2022
 06:07:25 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/8] drm/amd/pm: temporarily disable thermal alert on
 smu_v13_0_10
Thread-Topic: [PATCH 1/8] drm/amd/pm: temporarily disable thermal alert on
 smu_v13_0_10
Thread-Index: AQHY35Gr3xZt4c1al0inKrKSjlqOJq4NZR6A
Date: Fri, 14 Oct 2022 06:07:25 +0000
Message-ID: <DM4PR12MB51812DF2B5087D4E1225EFB6EF249@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20221014055553.921523-1-Likun.Gao@amd.com>
In-Reply-To: <20221014055553.921523-1-Likun.Gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-14T06:07:21Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=34574beb-9267-4715-970b-7d2ce2595b09;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-14T06:07:21Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: b6b1a24b-1804-4d1c-a6a6-f16903e85718
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|MW3PR12MB4521:EE_
x-ms-office365-filtering-correlation-id: f6119869-ec77-4802-f389-08daadaa5db9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V31at4Sk3Hi9AOwfPOph7CDcWVsJATlGOBBnAeL1AUHnIhrFlRJ+sIPHvRQOVTq/XsN6zRSLqsiSwf59mra4gE+XgjLgQwY2v4XyL9iUuoTyfUG4P2j1lNmf8ByhpPQehH/TsGL9hFISrrqQthpTZ8l1MjWajcaNYjQijFRMAclQz41aQx5SaA4g4QJ8QqQsq2VRktLvbvti/AudMXsRYPQK3zT3ZePv7QFERwZNyLuwtovrAOijI3k935cr34v4aaGPwpJx158M9ChpyAbiJv9V40kLvj2f2oWMB3u+WE/ajdhnCrPtXVrl7vwzAWfZvajjf87zxoGLewYYtpCNhnnm+9oGa+V0htVcrO6TpE5/XbK7yxBBWYvApkkgexJcC7sg5613zJV6ZypmdrXr8PCScb6FZrA7pgjoGvmPp7ESpn8hBzd6FFCOHB9DNxxLY82ytbJ2Q5MeO95xzVkf9Pxw4LR5OsGh3ULlrEHrOMYx1z0j4wR4bYWdmaPjBLFmhteKThLjMRLHNEfddDpYZNQtvRPlCr56M0hI2Bs4Eoy/nwkIm5fHQUKBFTr2s0BzLqaGpJmcoM+tZ7e14N6h7Enm7amU1qqEhaLCfkLrlyrnvyWvHOqB18o9hdklyV9nmVXRLPGeulSpD4rLQDEuIAgyIvrfZNFs5848dv1Lu0jYwiBqzMwF1BkDQIUa7niwKtsXyfETNk3ucgtBBOAhMEMaaX9mtE7jomdWgZ3cN1T6xMTsi/fLUWMkmAaFvy5JVN4LyA0he7EB4H5cCUrl4Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199015)(186003)(66476007)(9686003)(83380400001)(38100700002)(122000001)(8676002)(38070700005)(64756008)(2906002)(8936002)(55016003)(76116006)(15650500001)(316002)(52536014)(478600001)(66446008)(6506007)(41300700001)(26005)(66556008)(71200400001)(7696005)(5660300002)(66946007)(6916009)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2QjqxnzsOveqqjmB1UgJ0gcxmbpyNUW6Sxc4c7OMs/v4/mzxEpUakw2zw2Pz?=
 =?us-ascii?Q?SGSMfl03ioSaJ8wGTPcwMWkGu6XSQHBcGvs7oQCID1d87aPZBOVMk//icTKm?=
 =?us-ascii?Q?Auv6+bAvdH+Q66R0zRlTu+wAzeBRfSTYawU8EY/5n2d121FUBMUL/aL+MLdw?=
 =?us-ascii?Q?PkrK+CJ+Xdh/tfk5FwsMNcgvRjHHGfp79WjSod5I/bKEY20BVHDvyIS9WPuQ?=
 =?us-ascii?Q?zpqADSPMBsqTbORxXlVCD64KVJC3mhat8c5Ma9pgWExnzV4+gA/Dw0yii3vG?=
 =?us-ascii?Q?Vonxt+Vf+tHHcG0ZmqNvuxoPq8YPpap4y3ERdhMkZCWtGq2b3hZXQ0kHbbeJ?=
 =?us-ascii?Q?20WYul2T0nWXBHiSoibUnm4KztbXWxMS8W+2LfGt7T4o9UnRBY7dxwVaSKF+?=
 =?us-ascii?Q?6FrL8FVZWUMmfzHO4PoaqyZydlu7wkpNBueJxGHzHRv7tCPU1j333E7U78Cm?=
 =?us-ascii?Q?9h8l8b7BkEkWmhju/zNcmiydXJnpmdTiHvVdUXnbLdeTn8Z7iS5TKcg+Sbam?=
 =?us-ascii?Q?Fe75ud2UCK9ajprwY8irSNZNuxPf903Cxyx9QO6n1KklQFEUDKwySdOMmTmb?=
 =?us-ascii?Q?fzCsnzBYsrO+QhIliI9EsX5XJ8KyFbdxJMkfcr9Lqx2F7beH3do+ck0RKKJ0?=
 =?us-ascii?Q?HhqJLTaNtpCZXZdJi1ANd5EvKrnlkcGfrndZIpbMzwou/4MeA6RavB21X0aG?=
 =?us-ascii?Q?Mgt9jYZry8fCBnQZYnKDK5LEWd2q0rHRAkYzezgydKvjIvginE1LUiYeDafe?=
 =?us-ascii?Q?K/kUQP6zMkZCPVEaANOhDC73FJOyd57BfNWLrRKF/nNdgEwFH8yX+eYBvUHN?=
 =?us-ascii?Q?YpnvNnQyFSJjjr3YNfyk5b1M8cYFDL5aPGtvHLIAUfLBlZUoORz2BqQ//ZGT?=
 =?us-ascii?Q?Kw/LO0w2fLWvBwrs8vS4Z+CAU3qnPGVp2vZxtYOdF2+xJEAasTdrgwm2QLvi?=
 =?us-ascii?Q?Ohr1kffX+JF68DAdY/f0RhLKc7jnSNtqpXOOLKmn9n3jBZHhT1gNqtpGwErO?=
 =?us-ascii?Q?/Al0U8k0vG1EiJPV4rK2OmrAjXdn8rUxFLlnxRZ8i5w1ziFvC70rwl3taGPu?=
 =?us-ascii?Q?Xew+/elKbuYQtm1evs0Cs5sEkg6216A3TBDEHjQVIE2kBMGB2HDpm5sl8z4A?=
 =?us-ascii?Q?/vWhp3BsSiFvZ75JD204a/2cgNtE3q+zTIA7ZF8dRjS7ASBVTqsRKrQPmkWr?=
 =?us-ascii?Q?+Xbi5bO+29YJsBgA1U6BJJs+Vk6J1iY1JQ0TPTH2NjIV2m7qUfFfTB4jLJLy?=
 =?us-ascii?Q?ceud0+9R2wir6vpCW2c29PvEd35HniTM8bE0lHkEFoY29PoC+NXE7y6jzrqf?=
 =?us-ascii?Q?DnfUP1YjfS6+T++dNnsQt2q+daFu57QB60+vqkIgYxzUZy4Cv6rFY2rAAQvZ?=
 =?us-ascii?Q?hdMjanfX1DvKTsDs/E2gXWaLnYb4/54Z2y4IffyO0j4z1yJiyLp7+p+HGbWV?=
 =?us-ascii?Q?kXOH7lH5Rgg1D3mCycxaTmTnR3kGjWuHLQ0CqigGbD73YmTg2+CVZ2KBtRCh?=
 =?us-ascii?Q?xk44kkn77M9d1dHebr5pNU0pIkNaSNpPVuYMnq8yp0pK862e81M6aWhEmdtE?=
 =?us-ascii?Q?HaBWZDCuUyGemXiHP5I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6119869-ec77-4802-f389-08daadaa5db9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 06:07:25.4234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dIHjij2KrLhAYb0IXivSs1Ssp3feuNTbFfhzp0iUJ+LgPNFheT3HP08DK0GCcWfe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4521
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

temporarily disable thermal alert on smu_v13_0_10 due to kfd test fail.
will enable it again after confirming the thermal hardware setting.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index a02d98295095..61bdeedf0925 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1312,10 +1312,12 @@ static int smu_smc_hw_setup(struct smu_context *smu=
)
 		return ret;
 	}
=20
-	ret =3D smu_enable_thermal_alert(smu);
-	if (ret) {
-		dev_err(adev->dev, "Failed to enable thermal alert!\n");
-		return ret;
+	if (adev->ip_versions[MP1_HWIP][0] !=3D IP_VERSION(13, 0, 10)) {
+		ret =3D smu_enable_thermal_alert(smu);
+		if (ret) {
+			dev_err(adev->dev, "Failed to enable thermal alert!\n");
+			return ret;
+		}
 	}
=20
 	ret =3D smu_notify_display_change(smu);
--=20
2.25.1
