Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6D4C001B0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 06:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5697110E094;
	Tue,  8 Aug 2023 06:43:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1405210E094
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 06:43:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2HyM0HepsSF2doeb0M+VqbpN3PvfMB8rUFixABTXa9pjmPhNhuR2p/GfRMxEt3trxBhjiUw0Ghc1hU0Sq2yyTmysxRlmMVt8VB9TdWEkhpBuRRZLBR0CyjHgGbd6wECOOAric+h1FVnIyo+SLJ2nxXQJxKqREi7GmfEzvOGfDK8jS/LjPHe85apqlhtkraYBo9WV1Mz5Ch0PPv6FNTohSVIydZk1mGXKBmTSUh1WJRFTPnEITkdI/+i7CdEm+RQRmE/BaBuD+1rSQLBvu2GoHnzdc/8RySHtn4MbO89Dg8j0pF7VcyNB+h/MfZTuL1clo72+hC8QKw6rJOPCKSbQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCCx4lKTMdp5+VJzVqh4+mAQMlOx4zzGmJef3FraN0k=;
 b=oGmxpUnRX5bnqvgMZvglzUjReoTdm4j0ZVdNnoc8ifgBbBsXJ/s/7ZWcIFaLUxwGxLLfYabgPooR9bYmSCwp1k2H2i5bm1ufZI0vCCEskh1JcPI6v4z4XzVGhoovkF2IYFzqE+HlHht5HEy50Q+VxSM80l/vykozewYZKpO/7OrsuUGB2ILQMPDh+pRm/DvdH8F6nwla0z9fzA1NJ+qrkG6XfonSxL8aRzlJaYRco+NDgDIsZDpdc9qYWOr0wEeG1MEHW9ebi/1M+p9ZXVWKeg9cKGiENMV3XfVFJENFqFjRqBDqpoBBouzEPcfg7Tj1VjgbKzwK/qsZh/v9HYsUjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCCx4lKTMdp5+VJzVqh4+mAQMlOx4zzGmJef3FraN0k=;
 b=bzApagCb7G+3HaMLs+bx22+Wd/bxNaW0UpUrvxxjCKxHbXFPzGvFf6CVhG7p0VnuV/HefwQFgwq9E/+KN3zQv8DAcFRfFyClAVBZd7Gnzc9Qtz4NTw8KDPTRRhGYLb0Fti+sGj/XtpV9wEf7YiuK5T/zopWwbyq4lm1D448mjZM=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by IA0PR12MB8931.namprd12.prod.outlook.com (2603:10b6:208:48a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 06:43:11 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::bdd9:b320:73a8:7691]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::bdd9:b320:73a8:7691%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 06:43:11 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/irq: Move irq resume to the beginning
Thread-Topic: [PATCH] drm/amdgpu/irq: Move irq resume to the beginning
Thread-Index: AQHZyO2O+YNUMBrMMk2xVWnpHldreK/f9UYQ
Date: Tue, 8 Aug 2023 06:43:11 +0000
Message-ID: <PH0PR12MB541745C29B12508D1190F93F8F0DA@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20230807051054.39706-1-Emily.Deng@amd.com>
In-Reply-To: <20230807051054.39706-1-Emily.Deng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2c67ffe4-7d68-4e30-b488-a9cd02e0954c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-08T06:42:56Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|IA0PR12MB8931:EE_
x-ms-office365-filtering-correlation-id: d1822720-9c70-4e16-b13f-08db97dabba9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zLOiybiMKVZkZ/hKDIpXBoqMHSO1pxW9xA8P6e29XjzwikyBo526CWHgfmxopqWR8bQlR6gcV1oToAWqn62+ywHqazFCG/+fwl2juN/6qu8pafrP4udeQRvd6CuReRwiet2s+rLAj3QuMYztx9ZMUkt+IUObPVND5LTcpBzkNn+gjg6YmoyGWbPmOzr8itDjFqm3CSMSkAoF1ysU/48ryKOvcIcA9jNgRpmc1kdZQzx9Tl2cuVCcggjpy8STuPanClbGxWtfdu/nmRjgVIMJWccg5fa+bFgnGHgj4frX+LngE7TNe9neMeAoDXbzU3ajR61cpa9saqq+JNSgWGDM6brDeUYzZrLys9Aubb6wcX+xTWMNcsZpM8zakh686gK6VIrqyVMlcnFf5s0Etk5mtVtsMXu7fpoV34QWDBE1c6PG/s0w+yKlhAeidsKH7FK18Y7NHqYKVbJmN58NzW0CjGbm84RivvLmPW3VxRl+RaXGefxo/NhGbxhhXhh2ZZ24u3DjWlbkwRkf5JT2befnXvC7tzBu1CTtivDYarKOROwIQY8RkASqiZg3vG0J3KKEPcLaNgIe/9BB1ld8se2ovo8dbTTLS+iNcpAVcN+U3AyaKhOFfPjSaF4caJfJFCQsLfVmgkVXNxQWgJRl9urFjgolpbUrQ4hNV0sk8pvCJYcYX0Qo5iBmOKkscYYnm6eU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(136003)(346002)(366004)(376002)(90021799007)(451199021)(1800799003)(186006)(90011799007)(55016003)(9686003)(316002)(86362001)(122000001)(76116006)(38100700002)(110136005)(66946007)(71200400001)(478600001)(66446008)(64756008)(66556008)(66476007)(33656002)(7696005)(6506007)(41300700001)(26005)(52536014)(38070700005)(8676002)(8936002)(2906002)(83380400001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J4tl7Pk9s+hxZr8ZZqACYYdAQX6vsWCIUsmcwbXsOLs6qLilYHLPfRStdohI?=
 =?us-ascii?Q?dHdZ8rTZglCDqJ5L6EP3iVGGqVuHG3ovZCCSWEjCoTjAGPMYbpqo5KEEZjlU?=
 =?us-ascii?Q?qCEcnMoatFtVjd062Q/j6XpdrDF54US9b+rLIDBLUbYhPd1oyKT2JWQzLzJR?=
 =?us-ascii?Q?ftySmUpKTqDKwTmeSspviA2PARpTyyekX3HfIwtgWnMJ1PDjwVynknMExkav?=
 =?us-ascii?Q?SCq17iM2QuKlCFptynz8MxpHJ9XWZhICkuHJW4drxjQ2y2HnYPD8ktgqAfA5?=
 =?us-ascii?Q?5p+PgWX0Fp3FSplJJIAjOjpHL8AWfbKHa9lfwVr+BFmicpUfK7MuqgTsfsdf?=
 =?us-ascii?Q?xlbWIvVEsFatm2fZR+Z5HFRKbQONL/VoZ59kaJNbS2OPcxbyh6AxfmKUx/7K?=
 =?us-ascii?Q?k3PpNH36YbZKEg83YtCcXOEDRa2966Vnmd9b3LoPq50Sx1bZuRJFMaWntuKv?=
 =?us-ascii?Q?kdP2zIK4P85zL2c4ijhjiPgSjT0x1wEAAh6ESNwckOK0Zj1NiSv9qc20/L/T?=
 =?us-ascii?Q?VfQ1wipXZ9OG0jnCtJaJxUeExuE0ViGm98MIz2KxmrkzMsy7kMsqNN2FVXV+?=
 =?us-ascii?Q?O6BjVkuJ2oBcHUa8ofMQjkiyjCJpuVN/yXpxylobO1eqV1sCxVh33w4RxEYZ?=
 =?us-ascii?Q?rwI5JVs6gDmNXZYVjZBgFJbydNy6LgtDKX4WbOKC+XJPPeYJWlk/4GkGCAYt?=
 =?us-ascii?Q?+Yekl/+A3wftMXgaFdGayvkdcvG/WNbuOI1b5PzkGZ2mH5zAwOxCD8E7WlBB?=
 =?us-ascii?Q?I/Xt/JKzbYpO79IGYkd2QZ09y5vnM+qBwQJ+EHU/g6dONW1NbUp936chIHM0?=
 =?us-ascii?Q?+TY9BZaIre4IKrkz+byWNy3HuJjW6xlsCA/lDKJAEhAiBrkrcY8z2fLXvvRO?=
 =?us-ascii?Q?go41xWsy5hMQRKKM5RxvAN8bI3Ivv1NzNH20fV7oieQ4kP45UUX5wIqToIy8?=
 =?us-ascii?Q?oOCOcmWXwsLxCVqdsB1CRw4s/1uXJAVQ/ZRflXM/Tq251Lyy4rMJ6GIzwuDL?=
 =?us-ascii?Q?sne2h5DBwja51V2c/lRNaflb+9EgpS+UsrV7pJSJvUKgbnlIlRBbkCYMLhF+?=
 =?us-ascii?Q?P3N5V/i+uuYZOU4IkFZhsCW7+N9LvtV26xF0wKseyUePwaj6xLHcIbf0SIgn?=
 =?us-ascii?Q?BcqXZs5/KGFjNJYol7cCqQgF+K9O9WQ13CnuVOAyqdvFyHZQjp8wf9Fhhl07?=
 =?us-ascii?Q?GPpR1Ud1gm83BEFarfsfJ7Dqn3vPgmJMwCYuumgdWFfDd9M8uT/I8mIinqvI?=
 =?us-ascii?Q?pmhVeUluSbUUrr3xijW00jR54Pfh3Wc/NizvqgpLlMVsHkKK4gzxXZX4iBsZ?=
 =?us-ascii?Q?pzPCdvfMqCgdz38JVglPz64qH37vh8iV2DYXwGB6cy8jTq7P5FJGKIcVJ9gM?=
 =?us-ascii?Q?G0/CEj/iclmrzjtgTAEhkiXMrZj7z5ull9N/e9OObbqix/B8FWxChPkqEddf?=
 =?us-ascii?Q?s5nXSGn8jUeVIOj8ohd9ZHCya26AVt3aY/qJKikBEixebCVoSt8dDiA+uGU/?=
 =?us-ascii?Q?HimCHCyKbgzBKZ38I8QIYSKxp6nuLmalIu6lmmUcqNytfUau1MkU3fcZOjXx?=
 =?us-ascii?Q?w3Wlg2a3Tl4Igmgy4FY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1822720-9c70-4e16-b13f-08db97dabba9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 06:43:11.0130 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j/JRg2t6gK1sg0PEVqio9LAhv/exXR8UsqpmDgcI45UYLayOdUca1dqHriHi8As1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8931
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

Ping.....

>-----Original Message-----
>From: Emily Deng <Emily.Deng@amd.com>
>Sent: Monday, August 7, 2023 1:11 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH] drm/amdgpu/irq: Move irq resume to the beginning
>
>Need to move irq resume to the beginning of reset sriov, or if one interru=
pt
>occurs before irq resume, then the irq won't work anymore.
>
>Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 1338489b0b2f..8b304fdfe6db 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -4617,6 +4617,7 @@ static int amdgpu_device_reset_sriov(struct
>amdgpu_device *adev,
>               r =3D amdgpu_virt_reset_gpu(adev);
>       if (r)
>               return r;
>+      amdgpu_irq_gpu_reset_resume_helper(adev);
>
>       /* some sw clean up VF needs to do before recover */
>       amdgpu_virt_post_reset(adev);
>@@ -4646,7 +4647,6 @@ static int amdgpu_device_reset_sriov(struct
>amdgpu_device *adev,
>               amdgpu_put_xgmi_hive(hive);
>
>       if (!r) {
>-              amdgpu_irq_gpu_reset_resume_helper(adev);
>               r =3D amdgpu_ib_ring_tests(adev);
>
>               amdgpu_amdkfd_post_reset(adev);
>--
>2.36.1

