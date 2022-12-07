Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93ACC352A1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 15:26:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDC0910E3CD;
	Wed,  7 Dec 2022 15:26:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D292910E3CD
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Dec 2022 15:26:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TquLthob8fFObgMkh4aU335R8/WO7f5jJ4yHoOI0fSYbYYX6MRVOqmhiyl9DSYgYgYeevllNpDCZGB5x+ZwKxVL0IXaKulQI/RhmLazssPzb23BghjJgGTsWxdR1Ua1+lRgos6cxeIVGCtXMGfDR4fC/p+Wx8UDOB8x8ytW9eGehCowuEIkXDVDRS0fDCr0Vw1WnUkutRFPlaQ0IMj32rLTGvqEeXzoojaayNQ1c0roWoseVdAvrRfO4o3nyxhX4Hrpj7WEd25XmZ53QKsx1xqPDxggFjAoOaSfHwNB9JMjJ3AwJEWs3wavF51RNOqWwHLxjLaxPDd9kiyTxNEhGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVw9buh4ihGksRd4MQ86XYsmrp+1On/l1ws7z1LLQHw=;
 b=PnyUSN0hRYbklZca5c7ViclaqvLgU4vHTUwVLkr9JLqSCjAOS9+9BVRAUCOsvd909KSifNE41yziW9oduizx9F/NwbMAXBKzQJJjIXQwVpj4Q7HzztDk7+6Jea/LChEa6PuxvqMYJHonrx+Do/uuHx1/GiSgI7JCUxq4oVjuxnhhVuWR2Myiw7ebVLEkSypN6/BqIXSUX0FxwtsCxy1OcvSm7ttItzwrqMpNObYQ2P6aX9qH2f+jA/xfs1xZSwkEAwg5G+ICf6GD0u6Dp+vE/5EJ80ETdrRI5OheZXbwPTZRRSRgVnjwtvuV0tjKco6V1on4lfAwNjSXia2pLw9M1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVw9buh4ihGksRd4MQ86XYsmrp+1On/l1ws7z1LLQHw=;
 b=I23Aa+3GEvlxKcg9U0zT+J3Ufu6+uuoLVGCiULQ0FvGmGYfOHNSKcpv6H5W94SnHcKGa+Oc/lg7NqzwqEUrerCtUuCZ+mVwUPlfnpwX4YOQX9DENxmSlTaEQt+s5kVEecZZxm8Mg/90tRoB2WcqhnhZbv5AQeIYE5+d8U3+Tq0I=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by LV2PR12MB5845.namprd12.prod.outlook.com (2603:10b6:408:176::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 15:26:26 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::39a0:6c44:c6a5:cfa9]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::39a0:6c44:c6a5:cfa9%3]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 15:26:26 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Wan, Gavin" <Gavin.Wan@amd.com>, "Chander, Vignesh"
 <Vignesh.Chander@amd.com>, "Yu, David" <David.Yu@amd.com>
Subject: RE: [PATCH 6/6] drm/amdgpu: define RAS poison mode query function
Thread-Topic: [PATCH 6/6] drm/amdgpu: define RAS poison mode query function
Thread-Index: AQHZCiNLYsUxtRYY30OT6ysTTsNSDa5ii/uw
Date: Wed, 7 Dec 2022 15:26:26 +0000
Message-ID: <BN9PR12MB5257B38D23428C041CCB3B64FC1A9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221207100341.15356-1-tao.zhou1@amd.com>
 <20221207100341.15356-6-tao.zhou1@amd.com>
In-Reply-To: <20221207100341.15356-6-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5358f981-fc41-47e6-a238-9b7366113f3c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-07T15:25:25Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|LV2PR12MB5845:EE_
x-ms-office365-filtering-correlation-id: ce5dad3c-1c65-4617-fff9-08dad8676805
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QXKIC1kZWg8620H0FcSIlbW13ampU27FxLySTZMMf4GQRsxMZW/eJozG9NBYIgAe4cHMkm1Ffpk9kFdXNP1HznH7Mzs6/JmFWBhC9crHReHBNsYfCtcOYEUZhnT59oM4Pv7jKk3Wrl5avughs1tnrORgqo/X//AhiS0o+ojkipjIMyLvNNjQOTSFelaIEdjA4Z7JfQxg3vdF7AHXrrfvmtmZbNJI003hLu8wyVgvbL5LODPPVL+hG6sl4l3+f2oxE5ylA+rqTZzehruZmQ58LzUNaMG7bN4jzszWDcvex0I8eW8uap75EzKQLIINd/MMwKp+rXQgC2fjoJ7CXlK/z76Ku0TGPIo/EZdunuptnvJHcuOeYvQWH9y6Qm/RFAuZIvtDjqt0wZopybTXksCOKqD11YydcmOW7Fa0ozqq7HpVysPQgvrCwDKMCLl0cUL4fRGlmtpEtCOvZQN+LMyRT7IkeqHQjsuPK1B3h6KqoPU0YRKrIA06mVh1x3IbVw+SJ0JqLeSQMnKAwN6dUPz+xguSPscW7I3n5E6DO4t/6aPWnk0rKH8uzyJZNTqCKF5d+L0LL9WDXoG5nayftHmzx8ctTEseo7qOFL/N98k0LMQsPESxdNFfba/tR5w761wuEZ9jtFsZgouQmOGvQ7XYQpPR8b5Kk4s1V2GaeVVDxBjBWKet+7IewZ4xFSyx+5uuQVrCxDXS7gRODJmZFfFyXlLTAlsQXcqYLTWE3N4QtAM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199015)(55016003)(921005)(52536014)(8936002)(478600001)(5660300002)(41300700001)(38070700005)(8676002)(66446008)(64756008)(66476007)(66556008)(76116006)(2906002)(86362001)(6636002)(316002)(122000001)(66946007)(110136005)(33656002)(186003)(83380400001)(26005)(6506007)(53546011)(7696005)(9686003)(71200400001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nbdmJKDEIWnJ+KxiXedMEwZ6pYrjueUSytnoxhY6pZhZ9s84WYqYlrBD16qm?=
 =?us-ascii?Q?AMqY5pyeQQoiqIhdcY75aGfraJJYvJQDCwDowz7cl1/ghlGMsfAL3ti1MV1h?=
 =?us-ascii?Q?0BwOOcRyvEkj3si2V4zNhwJjPPG2SoPjcvGE6vxLepuM02ByzEi5l10LfmqA?=
 =?us-ascii?Q?KvK5of1k/ll1OXtllFS/OysY8KSTe0POtW1ThFYDMSX6RC1baWGLZR+7yooA?=
 =?us-ascii?Q?i51g/N3J+HTYuB9ApVC9ODqumh8NLmoJq0ucLlivOvQS4S9AUl8CSaGgSI6Q?=
 =?us-ascii?Q?G8sO7kCstJXp5mw8xv4AmqNJy18+sz4EAug7ygTQnsE68l0socNhvfR77/P6?=
 =?us-ascii?Q?KftIdj+WJJk9K5gnxtADKhzppTrPJ/9Xxjpxaf6P12EBufkydMWmWuHCkCcQ?=
 =?us-ascii?Q?76J2zWxYBY2Siz5ixyvJT7z57WYpnkmNi8EdBW/Ddd3wwjVlCeUZtQMD/i1v?=
 =?us-ascii?Q?0VlkdRfPg2BHTmxNngUGcKeMItK7dZ4IhFlQkJdmtdtK4FXsohrCWiQ1kj8V?=
 =?us-ascii?Q?KSyTgvq1daMHhCaVCpRC1dOefsEX2VRKHizCbr/ocCQe3xnUw6EfhpTmEz/9?=
 =?us-ascii?Q?1Q+cx8mKCAEFL3+2gm99FAlLMrGIwoiV2qOmGvchIh6Rwqp1hj2/8tP24a0j?=
 =?us-ascii?Q?ctmpag44auh1DIJ3LJ85dOihplzmgzr9ho7W8egtxbLwuLAEbSRYwJ0QOY87?=
 =?us-ascii?Q?Z1DlnX+pPJqf3Mng2rItOJHeGbgqXipiUAnjIeC2nugGSeI0L+TSks06QLKa?=
 =?us-ascii?Q?jJ8XHrv7c9jSu+nYrXY57+hPnDueJTcerhsEdClMBUzW5rnvEC/4C/qvoYyl?=
 =?us-ascii?Q?FDD9q8yoAAX/ojpCzyCTz6JmYy+NQJ7vu9ycj5jIF1BsrfHX17x94dCsC0pQ?=
 =?us-ascii?Q?IEl++RypCDfFEsPrhGdlXtWcVFTwONpygGB3rkiXXBOaAlOAisTVgF4LWIfv?=
 =?us-ascii?Q?WfRxeQ7Yys50NmJfmgQV/Gu6MkLOfyANiWWwdv1RLzhtrwvU13swnTctEeOd?=
 =?us-ascii?Q?/XrlRuhlktA9VirBNuf4b0oDKew0si4caYGrorAN7ZoKcWcPvMVvHzjBB2If?=
 =?us-ascii?Q?b6KOdIBLI7RWZJpjXG3FHPRcGFkk0mHl+urB51t87d1BipPiqs/cF0ejpyIW?=
 =?us-ascii?Q?KDNLGkW5QbYhLz4OAnL69mtyuyy/2RBXgTVLnpvE5N1hnmAtWZtE+BLYz3AF?=
 =?us-ascii?Q?Pbxlw5n6ickBBoQbHjpiCRUbQfE4Ov9KmjM/cde+wqeUK9wgl3btbW02JJtE?=
 =?us-ascii?Q?3tJK4AuB8aqn0FUNadXMvfL/dAJsMuDMBn64e5MhFoium7gOPxuI6RBmFAK+?=
 =?us-ascii?Q?r6JLnamYDn5ypgfWOGwUh+ybvVGv9pE74x69VO8j4ryhEqpLvBNyKFOxjjqo?=
 =?us-ascii?Q?J6M6ookdJ+0NBuLccusRSdvSHNm3Zo0lDuL7BdOscJqsD3G1vL544ig1E8gJ?=
 =?us-ascii?Q?ZcK1jUKG2Vb58VceFwm+E5qMhH2MNamosM6/XmCichq8/Zwv2oeoVIZky8oR?=
 =?us-ascii?Q?/4J2ygRS7zheXZUWaNp9bnbzU5E3ic3MbO1IumkYXlEDdgawS8OAPmpZCSGz?=
 =?us-ascii?Q?2TgdM2s/Xrk750fTjKK+wevbWGZDaSlIcIexXh98?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5dad3c-1c65-4617-fff9-08dad8676805
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 15:26:26.4176 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UiDtyvoIDC9BpPISpMPMri0DYE697MwoHTpXXdS3kkblZkYQi0IPQ8VdLNGgmXv7UMxheHpOqG06WIsJboc2BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845
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

Might be better rename to amdgdpu_ras_query_poison_mode to align with namin=
g style of ip callbacks.

+static void amdgpu_ras_poison_mode_query

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Wednesday, December 7, 2022 18:04
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Wan, Gavin <Gavin.Wan@amd.com>; Chand=
er, Vignesh <Vignesh.Chander@amd.com>; Yu, David <David.Yu@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 6/6] drm/amdgpu: define RAS poison mode query function

1. no need to query poison mode on SRIOV guest side, host can handle it.
2. define the function to simplify code.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 54 +++++++++++++++----------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 20474708bc7d..2a5f23316f83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2414,11 +2414,42 @@ static void amdgpu_ras_counte_dw(struct work_struct=
 *work)
        pm_runtime_put_autosuspend(dev->dev);
 }

+static void amdgpu_ras_poison_mode_query(struct amdgpu_device *adev) {
+       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+       bool df_poison, umc_poison;
+
+       /* poison setting is useless on SRIOV guest */
+       if (amdgpu_sriov_vf(adev) || !con)
+               return;
+
+       /* Init poison supported flag, the default value is false */
+       if (adev->gmc.xgmi.connected_to_cpu) {
+               /* enabled by default when GPU is connected to CPU */
+               con->poison_supported =3D true;
+       } else if (adev->df.funcs &&
+           adev->df.funcs->query_ras_poison_mode &&
+           adev->umc.ras &&
+           adev->umc.ras->query_ras_poison_mode) {
+               df_poison =3D
+                       adev->df.funcs->query_ras_poison_mode(adev);
+               umc_poison =3D
+                       adev->umc.ras->query_ras_poison_mode(adev);
+
+               /* Only poison is set in both DF and UMC, we can support it=
 */
+               if (df_poison && umc_poison)
+                       con->poison_supported =3D true;
+               else if (df_poison !=3D umc_poison)
+                       dev_warn(adev->dev,
+                               "Poison setting is inconsistent in DF/UMC(%=
d:%d)!\n",
+                               df_poison, umc_poison);
+       }
+}
+
 int amdgpu_ras_init(struct amdgpu_device *adev)  {
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
        int r;
-       bool df_poison, umc_poison;

        if (con)
                return 0;
@@ -2493,26 +2524,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
                        goto release_con;
        }

-       /* Init poison supported flag, the default value is false */
-       if (adev->gmc.xgmi.connected_to_cpu) {
-               /* enabled by default when GPU is connected to CPU */
-               con->poison_supported =3D true;
-       }
-       else if (adev->df.funcs &&
-           adev->df.funcs->query_ras_poison_mode &&
-           adev->umc.ras &&
-           adev->umc.ras->query_ras_poison_mode) {
-               df_poison =3D
-                       adev->df.funcs->query_ras_poison_mode(adev);
-               umc_poison =3D
-                       adev->umc.ras->query_ras_poison_mode(adev);
-               /* Only poison is set in both DF and UMC, we can support it=
 */
-               if (df_poison && umc_poison)
-                       con->poison_supported =3D true;
-               else if (df_poison !=3D umc_poison)
-                       dev_warn(adev->dev, "Poison setting is inconsistent=
 in DF/UMC(%d:%d)!\n",
-                                       df_poison, umc_poison);
-       }
+       amdgpu_ras_poison_mode_query(adev);

        if (amdgpu_ras_fs_init(adev)) {
                r =3D -EINVAL;
--
2.35.1

