Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E44C47422
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jan 2024 22:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39F6510FF01;
	Fri, 26 Jan 2024 22:03:36 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AF6B10FF01
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 22:03:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3mRDTR/GBMsNQb4w+GbU6dHe9V+99qTravIMfDp3fnZC+kTtTfiIXe06KaHQO71FUkFXhMcl+J3Ugtg1VXH6IoIpmqSuDmhBeVM2Xe1tRS15n2TijcTuq/JqqaFL6MTS6qM3FMyqvmfY6+lMXO41i0lVVY6CU2a1whZ2Dp5CvDzI8Sa5PJZ+LDe8BXwuA418rKpkulloQjQR5H8ChWxNVzKztkfPgjrQwYenE6K45aa5f1lLOnr5/ZJtRMmmSFJzeHOsBdJ2fBVancOYPTxNls0Hy1wJxV3sd6AJgM2GOjP5MyS12UmRTlZ9S3o3QY/3KCiBSOQfCF954djmAYcFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icwGEjDicCzRlkZlR7vAi0yYfGnX0b00LAIaaylcJMs=;
 b=A8YifM83+EDzicS79/I3KH/4DwudeuFNzJM8HXBs4On8PaoyIqXXbUz6wtyB1mgDC6Ktr7I0CsBRh7AmLrBBd5KGVcFQYj7m6aSAPZ4rl2Fz8OOpBxpwWZgk2/+c9B0YGWcL//PCi9l2ABKQNUFzKjt76ms/MlC+6hN6awmvuUrdSKAb/v8F1NBVWB0YJMm7ukfJv5/IZEtmn6FWDdxDT0Il5PvOTZNgALcS9ieFGCbviBc0T5hAK0wOH9+jygZENt0UyktyjB0qn3OmM7LdITsAxLxJdHwmz8o0G9pXp9XIUsuqpONizF4xlS02+AOdcKUIYtDzsdpasjyD4+B5BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icwGEjDicCzRlkZlR7vAi0yYfGnX0b00LAIaaylcJMs=;
 b=BWNKc+UDwm9JdTfnMF2Gtdi6fOA0e42TLQ+kZj2SfHIFsYK/u80Zi658XwiL984QLBQwOVDyssuzCtsbeutBe3ZpAAXM2L4QrRjHQy0kTpqyd6brQFC3GLx2/VamR0nWnDjwgtj4hb6vS7mEKSSXJ/34cK++sh61UKm8TKB8aH0=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by LV8PR12MB9081.namprd12.prod.outlook.com (2603:10b6:408:188::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 22:03:27 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::1d05:912f:c481:44b]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::1d05:912f:c481:44b%7]) with mapi id 15.20.7228.023; Fri, 26 Jan 2024
 22:03:27 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Use correct drm device for cgroup permission
 check
Thread-Topic: [PATCH] drm/amdkfd: Use correct drm device for cgroup permission
 check
Thread-Index: AQHaUJf0LjPhLg7Vk0qFVdXaAy4LD7DspbYw
Date: Fri, 26 Jan 2024 22:03:27 +0000
Message-ID: <CY8PR12MB70992871A4DAB6066B9C6FE08C792@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20240126203943.439296-1-mukul.joshi@amd.com>
In-Reply-To: <20240126203943.439296-1-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=948aa58b-153b-4ae1-b1fb-022cc8e4ae31;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-26T22:03:10Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|LV8PR12MB9081:EE_
x-ms-office365-filtering-correlation-id: 34e5d860-b594-4d96-786b-08dc1eba9faf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /yzzzFKu7ieqWvGkcdoRMnI9W9VNoyLiXjGloaXhdRomDXe1jVTsti+I9GvJT//uFvdmSf8YFCjaef2jpbTeWDiBtxv8/Qs2VMASjzOYU/tWhOZYk+vUmt4SONql6EnBwS5WHyq0GhxRbLsm5qE+THBpM9ABWpwXBCffkr+m2XdRd6P/0/0X1uNADcz3y8Ut7i+CYxPgKPRJroDvviiW8y0uc2YRZhg6x4PWNQCm7S6yJGbSRL7Eqp4o5fn0FWc7rWOv4CAIl5Ui3Ql3dcL1wkbAD0DlhtdTMl47ENdGWgCYA1kz3zy+c+vavwpKAALqm62Cjgk1sKMKSASU+sKJaIwcfeYfluqvP1eH3boYufw9ZWsyPG/dnv4UFiir+ikKUdrCBAyGhj5NZaHEeosKh5/4pq9MCKVcEwBWrP6EgA+f5XgbBnCjyIFCGaZnk54hNcfyysRA8gcWjOQd6a+SaEXVUu94cn9U65CUCTWTqA4M4obxV4NJal+RpzV2o81KcnLUarSUAVMSmB8svdDuxAUblii73VjG11ljgLerHMhYUhqmSSYc8/uEMQ4uA5Kuzsgfms2JNPF5G8t6iPSpZYnC/zylTG2ho90or89ruMx3Z6jeW3vJuhg9sxyrZ5Gx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(376002)(39860400002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(26005)(9686003)(52536014)(5660300002)(7696005)(6506007)(53546011)(55016003)(122000001)(71200400001)(38100700002)(83380400001)(86362001)(110136005)(478600001)(316002)(66446008)(4326008)(66946007)(66556008)(66476007)(76116006)(54906003)(64756008)(8936002)(8676002)(41300700001)(38070700009)(2906002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k1TtskQF/nisxpcnNnris1AztO6Vscm1zpBS5DoyVTin06/ygvD2GdZLNey8?=
 =?us-ascii?Q?T6bgWB+5b/W7K/Jf0D+S9iPFz+CJySylZTNNFI6w1jWyjgA1keyNn/WEtDl+?=
 =?us-ascii?Q?mlmpAEOyU8JUZGqQIZwyiiW/CJXae+B+kJZLz/GZCCxmZuP2I545GQBM7nLt?=
 =?us-ascii?Q?U0hMFq3/4OuTT8VtLjlP9cV5uz6z4WN3xAu88OyzBCEzyPV3o1rMKWm24sO5?=
 =?us-ascii?Q?ezHGpbgm/3MXHJBC8OuaL6PuClZolr5lYQSSlM6zUJOwxwNZHGeZxlsHYXeB?=
 =?us-ascii?Q?T7Pj9SjuSR9NO7am8DHGqCPAMm8X5O/DHU3O+psBLZf6cxdqk81Hka09h14L?=
 =?us-ascii?Q?LtHLej3eMJQ8XpQ9O3BTL0WSeWf6eMHiX/9xgdezVMPnH1krKWnfVoFIJAhU?=
 =?us-ascii?Q?Zl3ZJYjWuyQr1AFZ4HrVBWCdLc7JyKFy67Wi/GAuaemVq0R/+WyF1e7Q7rNG?=
 =?us-ascii?Q?YSQzJpHYhhdSjybDYye/K2zpgdWwMVslaQ10Hxh0IE9RKTRb0eTxdM7rLh3s?=
 =?us-ascii?Q?wnz6g5Tp5jUZrYulEZktXsTT25hNTxU3ujZraLLX0DbPucx2N4V+7dnrgsWO?=
 =?us-ascii?Q?VgNYJAe72KMiDZxYiX9fI0keDFcfUV2MPIL67KzAw+L0gs07c7R2ksPLhXp8?=
 =?us-ascii?Q?MyrKDXZRZO895IpeDiaEr2C/iKKFuGAs+38U+Cb+cj/kA5B1u/pM407CWKYw?=
 =?us-ascii?Q?BvWtWm3oCUuCEyO9gZdMhOepPzjLxNmakCttW3y40JWnsKTbIqcXqVtE0ISW?=
 =?us-ascii?Q?4AeZeT+hIF0sMfdAvdFGBrXPwaB0rZANEO63dG2OdfO+Bl8EGcodDaPPVdUH?=
 =?us-ascii?Q?0cx7aNkIJOfjsBDSdUPuhvGnstMp0YNr0QvbQE6/qeZMd0oBgO1hKgfD4Kyt?=
 =?us-ascii?Q?6TwSwOfHx9JB0IGR0S0J+KJqo68P/PJEHwPQzjSWoknwrMyrN6nNpB2zSpzr?=
 =?us-ascii?Q?BhczTip4OwWG2EgtlOXSKcq+2KB63puuHL/IoV796mCIzO60RwfMcB7cigyX?=
 =?us-ascii?Q?vlb3MU8lVeMV6TOFFQorQB2G9+MiJfICbfoJb48yYzxwUaxQZb4N5s4gBjOm?=
 =?us-ascii?Q?N2G3tREMQr+FCDiL62Fib/nR4k4vErEmJr7So6UFbzoHe8XxnVM8hvO9ThSV?=
 =?us-ascii?Q?wccAwCoAHCx69zplh3MTarkatdWwAEyjEdZjrW+NM1LA9yRxkwl8/rcSL38V?=
 =?us-ascii?Q?J/fy42J7A5yhT8QCIqcptU//ZZBA+mUSZLcsraW3VkEDmrk20icz6Rlb3KVi?=
 =?us-ascii?Q?ChigYROxJH3oK0uWUNkBfQH6dq/R9agojPOdr4rUySk1jDPwgcRQHNjw/6I0?=
 =?us-ascii?Q?Zhqsek0YBK/UXtkJ1JE0x82+GkubFkgDjNk8iNnQHChfaOmpnhYrwtza44VD?=
 =?us-ascii?Q?rSJ6Zkgq/3Fo3StT3JusCyGn7BpdfIjpVCvy0A3R++0E9cUHZvXRuIwGlEds?=
 =?us-ascii?Q?9V02/MKKj3Tt7+KkYX3ZXKt6OXKxCyjQ3sUviRSz0AzWq3ZnTnFMexHWBeAm?=
 =?us-ascii?Q?VAg18b69K5ER01EwObQOxKJH1HDvFmG27ObMU2UfTnqREFDT2Zw/ObIkLJ6a?=
 =?us-ascii?Q?48l9TKnVEEY48PyJ+p4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e5d860-b594-4d96-786b-08dc1eba9faf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 22:03:27.1471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PE+Cs7nTTElBq8TFKN4WJ7xiaBdvf593cm0ISeAK7hAcDSyof0gf9pSH+2VbDBBSs+9WrKtYNxs2dYXwAlqF6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9081
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
Cc: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mukul Jo=
shi
Sent: Friday, January 26, 2024 3:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Joshi, Mukul <Mukul.Joshi@amd.com>; Kuehling, Felix <Felix.Kuehling@amd=
.com>
Subject: [PATCH] drm/amdkfd: Use correct drm device for cgroup permission c=
heck

On GFX 9.4.3, for a given KFD node, fetch the correct drm device from
XCP manager when checking for cgroup permissions.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index 17fbedbf3651..677281c0793e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1488,10 +1488,15 @@ void kfd_dec_compute_active(struct kfd_node *dev);

 /* Cgroup Support */
 /* Check with device cgroup if @kfd device is accessible */
-static inline int kfd_devcgroup_check_permission(struct kfd_node *kfd)
+static inline int kfd_devcgroup_check_permission(struct kfd_node *node)
 {
 #if defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)
-       struct drm_device *ddev =3D adev_to_drm(kfd->adev);
+       struct drm_device *ddev;
+
+       if (node->xcp)
+               ddev =3D node->xcp->ddev;
+       else
+               ddev =3D adev_to_drm(node->adev);

        return devcgroup_check_permission(DEVCG_DEV_CHAR, DRM_MAJOR,
                                          ddev->render->index,
--
2.35.1

