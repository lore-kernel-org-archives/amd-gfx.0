Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A580E810C1
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 10:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C247710E4ED;
	Wed, 27 Sep 2023 10:33:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6D4110E4D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 10:33:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqcYxlC4zjxAuUzaNjOTYZC9a3cMKq05IKhy6oGEsBqDrxbXIaCLOzBHHH4XXP/NDhKbtZ9MwCcgPPsbQZo1mhTJ59m0n0d2pjPoJExfg5snOiv1MfPoR2etfMQEDXChwLoeLg8dyhLYSpCwj5+lGf63PARFiJ/9Iw57oQ7f8ivmoGGc1Mbe6131Tj7RNbCU2OpYzx7wRjJpcDQWiXVrTfbcMHcOyBn1qjgbxzNphmK3DTXjc7zx2GNP+1g1DHgmHYnbAl7GHAMBZESbVg9Qs6Mi+w8RNXi8PNapcdtz2MsjeFPdqtFNTukp/kRt+azIr/8b4ztor7cbaXQK3HnATw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bVoxzV/U+JWymjnYaOfzTOS0XMX04xsWh6NSJEfhXs=;
 b=CO2lteBjr4CmoWKoLESjc5Ba9LOao3p0ZOSDpTD8uFmymtCOAcB9jD6aZeGYC8yEUMsed8XaeE7I+fzKRACp/6Ip/hBTvvIlVU4rQz7s/mm/XJsXXUunshMNZzA6+/42h/JWV054ijgl6gD9pRBNIxkOvY9L+dS7B6d+pQlEtLzsSAODvMfR22OtzYz6URnHEJW+rW2aryz6W5ABWffqKU1sfNtuC1LHLXmnQ4uYoz1Ev4CVZtP3s8S59C4dpffndutCZ9wwHpbIrYGgpq7L/9aAj7FHyt6RMc7lOt3nMgXJIl1YMXuQlawF+W3WDOMB6xvurQi5AKUeEPjIy/sWew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bVoxzV/U+JWymjnYaOfzTOS0XMX04xsWh6NSJEfhXs=;
 b=0re+uJ0qBoj5uP7u2VJ7sgP6j2QruQLdSDilg1jG1DD0vAQQgkNcxN3OooMnodwGnQy3IlQd41nO0EkT2j5zI/iwpRLkWKuLOojVArazSyBNZFuZEwUsktxm9NbZGGJ0N6eIpkIem+hbYctTC2r1Ip24qYXWncKVJ5vJY9bgscw=
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM8PR12MB5414.namprd12.prod.outlook.com (2603:10b6:8:3e::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22; Wed, 27 Sep 2023 10:33:25 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::2b1e:f861:d45e:96b5]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::2b1e:f861:d45e:96b5%6]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 10:33:25 +0000
From: "Zhao, Victor" <Victor.Zhao@amd.com>
To: "Zhao, Victor" <Victor.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Disallow managing power profiles on SRIOV for
 gc11.0.3
Thread-Topic: [PATCH] drm/amd/pm: Disallow managing power profiles on SRIOV
 for gc11.0.3
Thread-Index: AQHZ8Cbha4w7i3IfXk6iAbd7G2gcI7Aue4pw
Date: Wed, 27 Sep 2023 10:33:25 +0000
Message-ID: <DM6PR12MB43409DF70A8ACD86894D96D9FAC2A@DM6PR12MB4340.namprd12.prod.outlook.com>
References: <20230926030859.3046382-1-Victor.Zhao@amd.com>
In-Reply-To: <20230926030859.3046382-1-Victor.Zhao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4cb7ae34-8a7d-46e8-95b5-e5376b7edb97;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-27T10:32:31Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4340:EE_|DM8PR12MB5414:EE_
x-ms-office365-filtering-correlation-id: 0fe50289-629d-4ef9-3bd1-08dbbf452e2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ykaLuK8ezdZMV3E5OW3/qcBZQQSlC6Gq1nyN6BDp0ouHzQAjbSe0mSGVIX9kUWzBKdks0IjpFOYULDAHBo5nUqx9DyDSpZAFMwrPsQwzm2wXRJxVEKnmS37/KNLno4P30qckieVSA2+BbqASqDVYkJs9MPPCNn3r2mClB1JdJEon7ppwFkFScM9aY5SMKZuYxWGyxMWJHRBmnFJQEJ/2Y4TDGFX21RsCRZaRloYU+Oe5Vr0uRvNU8r2fz3831WWwjff8UyfAkLUAaW4TPr3wq8SGiCn9CEK+uEt/VcjpsoyDELtVAzXxAgK4Da6tKVkk2jZEP2xrXVGS+lEpErAPEyJB/8OU63nOUoN8x/H1XEwyDeO1OTw/2Bnai03V5FnOvQcQtpvO4FU4kPUk0ztxMd89Mddsoi+aI3HYqjkrLQtNm4yicip7wA2pGASUtk5i7QW68ysDTVjJNjqlZSu02IRrYjgdA7AJsE7Lk06DZ/fBW1cKos3A1Jex/bF8ELwPY2g5P9r5reE1xKWvZoqJDYC6eOKpSks08FPdP8j4nJq9JRljrx/3DL2R6+RVpmYfzNtIoU+AzqI84o624Lxc3phwGEs9NZtfxqAHfoW9apJP387nSCW6BXyssq1rNIq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(346002)(39860400002)(376002)(366004)(230922051799003)(1800799009)(451199024)(186009)(2906002)(316002)(52536014)(41300700001)(4326008)(8676002)(8936002)(5660300002)(55016003)(64756008)(66556008)(66446008)(76116006)(66476007)(478600001)(110136005)(86362001)(33656002)(71200400001)(6506007)(7696005)(53546011)(9686003)(38100700002)(38070700005)(66946007)(26005)(122000001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?As35PeD8k2wLemhuVrst4Tw4aDhrbWp7EZAKsgbjcN7VM2JAzxlKSGN1kXJQ?=
 =?us-ascii?Q?Rv1R+4uQB/7/0AZAIlSqnwHAJo3hxbqUmbR6L1erHlHjBLB8p+b/TbWKUT8d?=
 =?us-ascii?Q?OU10EfhvACADz0PxLmq1zqRXKIrvx9lxgCgblidPRSktGsnQxyk+gWYFsSlf?=
 =?us-ascii?Q?wz63mw0+mignTkvWDGLqb7R7vNHQVFbhjdNakReKm0Fu5xYeytJWEgytEqEt?=
 =?us-ascii?Q?PbHtOPIif/P24J8MancIGDduwIB5VXpH8TXKE0+Ed90BVH1TKTS7M0v+CrNu?=
 =?us-ascii?Q?JEJj5WddfeTg4qBVWFt2D4LXSOYrJ6IueChCpwlyAs906bdT3BwoovZD/G4X?=
 =?us-ascii?Q?qho1pUpceQf+8ac6PrHAWoQwfiFnE/jhw5yBmjsbUsS9zPOzTntG09XwgLlE?=
 =?us-ascii?Q?lmYiyeNlm4+hwzazD/mEVPiXD/idm0LFWqxz4gasdoQ7E5svKpBWRfl+O0kb?=
 =?us-ascii?Q?6CJkegjAkfNLJIjYq+XTYgNvhQOEE34Tm6Smb71U5OmnvgBNAhfNK7E5xSu5?=
 =?us-ascii?Q?8ZgpLp7XOf2JNfowwO7hPREZvfDahVu2pkwdMzx1mz5G9NJKTMBrBSJ1q1D/?=
 =?us-ascii?Q?ptQBqIYimMQbjq0fhbuMAC0vTwHAKIu5lPuRbKRUH+Sl1zX/efS3RJ/eyrh5?=
 =?us-ascii?Q?Opzm4ENnMwWbrnS4hxgaR4bVs83MRIwxXbru7bo+/8wi9AGlHSN+0kCEYKE2?=
 =?us-ascii?Q?VfBcT7nzNnQC6b4t1rifWasiD3QfrVSemQzUUXrrwRGrcf4nxytxAq1GC1Qc?=
 =?us-ascii?Q?En2ozk1VGnx8OxCYtl0D3wb2zCjZAg586kHb49RmiVGVI2teEjtZuOQmad8g?=
 =?us-ascii?Q?EfN9uUQ4wiuDioLsniUuJMH+keG2GhtM/DYh1ToNm/0ab8z7znGUxFeaDuAL?=
 =?us-ascii?Q?zgBwkBAKBzHQP+RX0MkGkpq54zxPCR6bf7ssPT+2mkdGdrjTgKMhvYwB1h/L?=
 =?us-ascii?Q?pFUsm/jbs+YLhBP6zkOn9qyyKXqXjnk/BlOXcc2+mfekNAbSEn4WHyq8tOpY?=
 =?us-ascii?Q?CzmG/yTHvaRzjjes0hdeVQGjwYLYVYLkzqgxF7E5VLaxBBcl1nNMRckBdvaM?=
 =?us-ascii?Q?Oa7RH/PEgV+jxQwM5bfL/yoChY2P9N/vUlJneawK47qciC/tyJe+C2snPA7M?=
 =?us-ascii?Q?vwBXpaafWfZKyZ1GXh0DULXlOfsXnNWifwCWSS7g+VayzmOXqvXxw/qaSk6f?=
 =?us-ascii?Q?ND4eEKZO7itPry9d+Ekz4llU2KtvJQ+RxpGQJlzaOjbzrNtOVem10j1gcClQ?=
 =?us-ascii?Q?l+ytqY7cP0CDN4/KS3yUzqVaVgJmJGhnxTNzbka8r4rXurID2c0PCOsRWUjF?=
 =?us-ascii?Q?LC+mY5dpSHOxgylDOnc5PISJnU1N15YidGhDqJyT8cMnq/bV+8PfAR7H7TOa?=
 =?us-ascii?Q?IcY7Mi+3FiKhHLXoO9qG5u6eRkn5cjIfQEEOoOpILEQPIjH9tyWplHjgS31J?=
 =?us-ascii?Q?R/qa+ly6IfVnG1iuMkzHFmb5AEn9wayheUMixehGjX4C4LrY7EjHfEojmDw8?=
 =?us-ascii?Q?+O1VzJWzyETbH2YFtGouXTsM4EFY7GZz0euZ5aAQJPl9UpoJykd10MM9O0pi?=
 =?us-ascii?Q?grrYHtHG+WJSr0tRHjE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe50289-629d-4ef9-3bd1-08dbbf452e2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 10:33:25.1283 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YA4s4hi586t+H97ngK81AFZQ6V6YouA1Kd6JeTkaZk5VWjQyXoN/khXe1eVzn6qz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5414
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Ping on this patch. Please help review.

Thanks,
Victor

-----Original Message-----
From: Victor Zhao <Victor.Zhao@amd.com>
Sent: Tuesday, September 26, 2023 11:09 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhao, Victor <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amd/pm: Disallow managing power profiles on SRIOV for =
gc11.0.3

disable pp_power_profile_mode for sriov on gc11.0.3 as not supported by smu

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 2d19282e4fbe..b6f32d57b81f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2122,7 +2122,8 @@ static int default_attr_update(struct amdgpu_device *=
adev, struct amdgpu_device_
        } else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
                if (amdgpu_dpm_get_power_profile_mode(adev, NULL) =3D=3D -E=
OPNOTSUPP)
                        *states =3D ATTR_STATE_UNSUPPORTED;
-               else if (gc_ver =3D=3D IP_VERSION(10, 3, 0) && amdgpu_sriov=
_vf(adev))
+               else if ((gc_ver =3D=3D IP_VERSION(10, 3, 0) ||
+                         gc_ver =3D=3D IP_VERSION(11, 0, 3)) && amdgpu_sri=
ov_vf(adev))
                        *states =3D ATTR_STATE_UNSUPPORTED;
        }

--
2.34.1

