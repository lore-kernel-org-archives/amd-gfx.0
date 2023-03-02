Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96BCC678D4
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 06:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4CA810E371;
	Thu,  2 Mar 2023 06:13:10 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::60e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6A3610E371
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 06:13:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJi3MKeQbkkLLD2zQqzsCGCC2fqcyGrVYtTB1NNnF4PyikugdcuuISC4IB889LT7xBQvLpzIylNRusAeP078Hhd7qIc3Z8LNgBlsARUpndZS7TQK9TVuyvNoHeyy3N7xJHANEabk0KVnd3GkHVnUWLjZzos5oNrDzDV4DyDV9zyBfBt3XkfqvWDjjWePLCjmgVzuUjmGqCtrz2T+pBgsym4JzvzzrTHXnYzbrVZGFViG1rpA+mAd975qq4Rrag6r+aeiGHh3gR59DO/7Tig1oWOmXJ+UbbV/m4it0qYnzFQ4ed1MhlZpeIBZkQF0gVJU484lfj3xrbQVNHwGoJJp+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8XfswgIxkdwMQkXML4myVNmkRj+G/8XWKnjDc8T8tw=;
 b=HpUQmQu1kdnT92kf8LTSoA/Fl7KqK11FoKmRnBE71xUEHp7lw7NgCQAOFVpXwhkcWeHC1wsSwJ2137+0tuuj8hZa7nGNsPq6rVICtD6IvXqYx4B3dWYDdyuRyywSawHt+iTLl59Z+jshF0gJCANBraLykkKHNwDoJ7yDA/hTHOc05VplWA0E0jAClKgyIaYmVNxtZRufoyDc9TI8YFCb1UPHOsLbkGVRIBiL2346cOunYyXoLlVSxbsUSGac2A+9Q+ZEzvRGdFVRDTqczjpLhjylB9uNSJarpi3Cm7AsLfWZjNYxyXDMFiuy6b9DLNqPOCXEfdZN5+HGH/lQhxjlXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8XfswgIxkdwMQkXML4myVNmkRj+G/8XWKnjDc8T8tw=;
 b=bnbxZBghy62Opw3H14WansZNeimonW0wIzzyt5J1xdu3VqjA9xSBss8lP+RCpw002/G/0/5zbgMW57gNN12OqTHXBbtIkY0+n73JfMgAXl/cd1V919tkD8Bp22J82FHJ4UIsLIHk8yW2Kib5ew6Crd26VwtfdvG+g3jNB2Jzvdw=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by IA1PR12MB7637.namprd12.prod.outlook.com (2603:10b6:208:427::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 06:13:04 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::e4c7:294b:cbb7:3c60]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::e4c7:294b:cbb7:3c60%5]) with mapi id 15.20.6134.030; Thu, 2 Mar 2023
 06:13:04 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lei, YaoYao" <YaoYao.Lei@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Stop clearing kiq position during fini
Thread-Topic: [PATCH] drm/amdgpu: Stop clearing kiq position during fini
Thread-Index: AQHZSncmnbj/vazu3USWszVsyOfzZK7nBsMw
Date: Thu, 2 Mar 2023 06:13:04 +0000
Message-ID: <PH7PR12MB5997F4367B6BE92B8976FE1482B29@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20230227064530.2699469-1-yaoyao.lei@amd.com>
In-Reply-To: <20230227064530.2699469-1-yaoyao.lei@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a30b7eaf-0c2a-4f3d-bdae-efd493267d99;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-02T06:11:37Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|IA1PR12MB7637:EE_
x-ms-office365-filtering-correlation-id: 90852d66-b953-4286-4e48-08db1ae52efb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sRtsJmkFngIQy+ZrAJNr97yItrXp8+p1r2MM3xxKusFKVLwfQODcR2hlSsB5InNBY5ae0Nnxte+eifJt5qDbo5NeBZKnJNk3xKKpHnTtGUBk8G5XNcSFhReyO5jdADiCPPAE1txwW0hW4sTAcGlCDZ0idQ3FGLul5GSuWP1Y13M/e8jgcnr72BbHa/MS/TGPyN5hYOsfJtKg0lfwWMUifwPeUxq6+04HugKx3cOvz3lBm4ayRgMh3u4xdWForC0aZ7weL7FWCNpgpElEQgvRs8odmNUHdDSmtn7jzy3oTnyU/ApeimYE7TcxctjtET2zHqXkR7uy5Lb0PRpiqUxosWHUHBsGEOSK+pnSC8/HiVMGRhcazpfoOlVIgnyRxSqCxfsR763c530ljX/WTvtM04XyE5fVuEMwrVsSZ/X4suae01ysTnHmOqrPGrigm0PjaSxSNR8FUFbI5JgVnLEAohb2jcelViD+N10zAnm835uohjU3zjCVBAqeftLu6aGAVu1lAr5ZlicFq7wZHq42lLuCt8uakU4I1C6O5R5hHEWfIvr7v/iWZBjKL4yqh2MVkBfCVoRYp2wxQx1giG0HsjFh7xAEcQCK4FQ0nUHKHC6cJ0du9kQm6hQEsNVUbdxo0eaTwGKyg/saceWvGCOurtQDVNnmqbSqxUoyq6MpFmGxDo92UkUGwrWSSUB4+kSOmhIPwMWCCibsTt9qA70D8w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199018)(83380400001)(38100700002)(122000001)(5660300002)(478600001)(8936002)(66946007)(33656002)(71200400001)(86362001)(38070700005)(55016003)(26005)(186003)(9686003)(53546011)(6506007)(64756008)(66446008)(66476007)(66556008)(7696005)(2906002)(52536014)(8676002)(76116006)(316002)(41300700001)(4326008)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fl011iFxYPSbrq8DVUqmlXCkH/YDVuyl4iwvz+han4V5vx3yMBVoqeXbR3Cx?=
 =?us-ascii?Q?X2SEaM6rR+Cfc4E/HZ0HRi1xMJAIDXC1r1/SXJamCLbLsNnKOBOOUXSJNHb5?=
 =?us-ascii?Q?hqsvXZQwfIIyZ953xX76Gw5SD4Airo+iQtOZPhrJufDkjy7i6+kF6VIeGDHu?=
 =?us-ascii?Q?M3otp7107FD//xfBl86VTQ2xsagS1SfZq9D0fGwWNFVRL50+wi0ee4HBfvZY?=
 =?us-ascii?Q?+JCrnC9oj7lZzyXpw0M0D4DKzgAXE3lMuQB90rIo2uV8YjeAzLW5VSkGEE8F?=
 =?us-ascii?Q?53rowxtJ0qEdisSPPHSUx2TnQbDISTtxp0ct5E80IlS/GYc+PnO97C02CyxO?=
 =?us-ascii?Q?M3M2DYSZ8zkmTopPREG8KdtBVTQumteHCih09DPOZBh+psyIhYrY7WPPQYeD?=
 =?us-ascii?Q?bLd40qym1hMDe0HhRBtHP9ELZ2vPG+oHzR6fUc/E8uaqNQXFz5gHbG3j7bIU?=
 =?us-ascii?Q?FKtYhhKXvIdX7F0Ue3CnWFiFvlPBmZ93uTG3mzSOx3JR8W+w7NVCBH8r1NmP?=
 =?us-ascii?Q?WNth+lFYN6sWrDU9hYl+JWkl5aZYWWby2Ws0r43qDV2Prr13/aloj35PtkrG?=
 =?us-ascii?Q?3btVLjLUHITDbKAgQEX5YE3SrzSAA9XZBQ/OZgTC5Rp0avC3zMbklJGFVuqw?=
 =?us-ascii?Q?r4Av8lqzjHVY3P5fJ8RiHiSqrNM0uXxPMjnGdcurvt2HBzd6WxNPDxZA51Zn?=
 =?us-ascii?Q?5Bc2hKEp9jsCO8eBR7+K/4loun0pJQhNnwC+BigpYIObegHWmBNCoNl6kiWp?=
 =?us-ascii?Q?UhzHN5xyTN4sNdYM4tBqnG0J/+1byfbFBgHvBvOP+gK8Ht4XoOdF8c8ROEc0?=
 =?us-ascii?Q?v4sI77wv0/qoSO6occjRp4J1kL0gBFFRhp9o8B6utjhMVS3ZmVptodF9nWac?=
 =?us-ascii?Q?+MoxLPJm7tf6xapfPAlLv+5WgN3mNd8JgxWrTRgk+FAG+SzQpEIVfraDfILr?=
 =?us-ascii?Q?5iTtyaI6YzXvGSd35aDuSSq2NVUyNad7UYjqcQyrNkEbnBeuIx+Ohp3hfNob?=
 =?us-ascii?Q?6kkQ+3SllIRQHU4I+zdOeJP+uTXKyV3U4e5Ox9DDaP4hqNt5HcsISzSFJgGI?=
 =?us-ascii?Q?JdUBDmpDIcIqnO8Ju8NGcmtYye59lr3jAP14OrXwj4qTBc6s12CVFd68nAbX?=
 =?us-ascii?Q?f2WN2xQqQ3myAgsCbTbeMdS4UiZM5HEPhHWCWAiJ2wSduDUIccq2nxmK5GTR?=
 =?us-ascii?Q?8d5MB9ph9eQpcJTDWCAEaoF8zk916ABUQdwHIPGbF6xE3kqeiLq6uAUR2qxq?=
 =?us-ascii?Q?UJMc/7qKxrqwAXrcmZCCf7cx7o7h+btPZf8GQN++LRVYa/3RcXCQtYMeCLA6?=
 =?us-ascii?Q?xp9x6MCPxzYuAg0HN1jYA1ccvMHGTz73/jDCVLDiOaqpO7KILNER8eN5+j58?=
 =?us-ascii?Q?c/PHVWgjfPKGdsmg+wZmOqh1P5BRwmGlXhwiDWx4NVeGdiW6udyJPZG2h6s9?=
 =?us-ascii?Q?8Bu7ku6+RQQKdwvqeJTQS9c1CNm99HZJYEqef61oeo68Wa9Nm3KvNJ2Rq5AH?=
 =?us-ascii?Q?pyYRvsX6sbpEntXSOcKpwVhfu6bXZp3GQGgfJYfVht0Y8d4smjbf1J/18PLB?=
 =?us-ascii?Q?B5gMR5wf4bya/n5vVMk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90852d66-b953-4286-4e48-08db1ae52efb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 06:13:04.0486 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nRjdubdFfcodXrhuHXmAz1EOY/VQEpAdLdapRJX0z8UL0/C7avp+4FeEzfExbdwf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7637
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
Cc: "Lei, YaoYao" <YaoYao.Lei@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

After the patch merge, the "tmp" variable will not be used, and a compilati=
on warning will be generated.

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yaoyao L=
ei
Sent: Monday, February 27, 2023 2:46 PM
To: amd-gfx@lists.freedesktop.org
Cc: Lei, YaoYao <YaoYao.Lei@amd.com>
Subject: [PATCH] drm/amdgpu: Stop clearing kiq position during fini

Do not clear kiq position in RLC_CP_SCHEDULER so that CP could perform IDLE=
-SAVE after VF fini.
Otherwise it could cause GFX hang if another Win guest is rendering.

Signed-off-by: Yaoyao Lei <yaoyao.lei@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 6983acc456b2..073f5f23bc3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7285,17 +7285,9 @@ static int gfx_v10_0_hw_fini(void *handle)

        if (amdgpu_sriov_vf(adev)) {
                gfx_v10_0_cp_gfx_enable(adev, false);
-               /* Program KIQ position of RLC_CP_SCHEDULERS during destroy=
 */
-               if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 3, 0)=
) {
-                       tmp =3D RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sie=
nna_Cichlid);
-                       tmp &=3D 0xffffff00;
-                       WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cich=
lid, tmp);
-               } else {
-                       tmp =3D RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
-                       tmp &=3D 0xffffff00;
-                       WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
-               }
-
+               /* Remove the steps of clearing KIQ position.
+                * It causes GFX hang when another Win guest is rendering.
+                */
                return 0;
        }
        gfx_v10_0_cp_enable(adev, false);
--
2.25.1

