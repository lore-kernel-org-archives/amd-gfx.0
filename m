Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6C2C46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 04:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0914810F5FE;
	Wed, 24 Jan 2024 04:24:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2707F10F5FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 04:24:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1oVvioB5svGbUM5Bt9AmEz1ZS1UPS/5kEdydu3QJgSD/jS+F+RCUyMoVYMFx6YWBayBIDnFZ/hK/jNgLcYEUNXQlIC1xkl4WYZHrHbgbJzOssgUu3JaQMYWNv07tCG30qAVaucuRQuqcasy9tHN1RSguQpIyklhmx7+iRiAfxTw36ZpWH4ZdrmhwUvljb4s7JDa+HEoR3zRafYvrLMqZAms4FMmbyd7Q9zIMFGQlgbnD+oI5Dgd8j6vfJHXzlOssf/pEpQqOFbk0AarDCIxdB4WQ2+I9j9rmCsNSm70TShXQnMt/ZPPbooLsYAL6vsiCOJR344E+59EscLko2ySBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBU7GEAO3DVXW1zWWLL/KCNNCmUelAsLhMt6+FsEtNY=;
 b=f0obpSBew2OsEPA3fORj690KBmUY9OrfgmEj/XQQSZ5y45FJX/lgfhPV8yo4kydEa4vqp0ZnSergr3PEleSc818Pv9ZHmOrkiejUuNpv4NxzyOJQ8bhUsDtf16HZD/WJAxpUVdNsMOPsfa+gwGbPVkuRrVFYU0nJl8MX5CF6pEe6iO6TqC8WxWa8++gNPq6o+njoHPKot5hMg7KOIokucij8iuTw5TDMb8wZD8fYkVIuL2p+kOMH/vM0mp5XCKKpkj220QmvvyUlKiPgVOdP0LiWkqqa4mq8PjE988kybPQbOrlM+SXIUFxR+Dye7wrzDu9QHFRCHZDc26zScuziGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBU7GEAO3DVXW1zWWLL/KCNNCmUelAsLhMt6+FsEtNY=;
 b=nsGOmG91UDAX7mfjxBn6vRxzOeapeTkpBjGAMuoMtabphIn8i2ZR4PdnZEh2jNlV2QWv1aX2Yj6bxMR8coY49Z0thYHpIBaA5PwAqLxezoJV3JJr8FdYaiIMDQQmnj1SLBkEGYFAzjEYm8aOm2FoPgjRQFg20X3VOPY91/0gCmU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 04:24:20 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81%3]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 04:24:20 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix module unload hang with RAS enabled
Thread-Topic: [PATCH] drm/amdgpu: Fix module unload hang with RAS enabled
Thread-Index: AQHaTj9L70gOLtVckkOQLn0k3f0EM7DoXcRA
Date: Wed, 24 Jan 2024 04:24:20 +0000
Message-ID: <BN9PR12MB525720348AE1FA21408D4CB0FC7B2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240123210045.208152-1-mukul.joshi@amd.com>
In-Reply-To: <20240123210045.208152-1-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5466a442-82ca-4d0e-b809-9d08a1428746;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-24T04:23:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB5771:EE_
x-ms-office365-filtering-correlation-id: b625a4cb-bcf7-4828-a29c-08dc1c945620
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LvVN6qpj666fGyjEuj6jxxDT5RlSy3hIU0qyaNPo0DGHXtlAXvWLj+4TiSSa9+OjUuF9SiMmRAGotbbx3Uh77LOQJPPFxJbwa26RGfWG45cla+VAiW/1CLhE6ogpfaBN/9GzD5pL9Z+L1TmTewea6CyvLilNz3xhfztJX4a7HXi1t5fkdTILp6AgUyFgaDAGhVheUgQJTClscs5EezZI4JIj+ctVlQ1gzdJNJmX1Tid7r7tVa44wmvZbDwTYyjtvqW730enGuN8Jn8POV+fo8uvOROINU7XPSWOtg7HwsFF8yUO6508UD0rgeuyGy2a89DGiPCs35y+P1wzrHhFUp/Ekozupjq+8IckeozycRh0MlNGutd+0CV7YVImIFfcKtSQ+YD9Ci9FbfS5VPwAMSat8r+VgA690gPjtmAs9X6qvvs4GE94mBDz500UY5yTUd5ZVyrA/1LS5DDHi/2xNib4TV7fhanSxzXY3ljkDr/GUYZljKGBDQH0zT25Dh9ON4PQd68oI43ervuJQIn5A/PaoPeLTjD+f9N3Y16c6+8DoTlHwenbWCuVF3k2d4fwzD7yz/k9Tt9ZQ3s+JefcuiBBy1/7p2Bncuuo/qxnyj9XxX9u1Gmm2Up4vtJM8f5Tg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2906002)(9686003)(26005)(86362001)(122000001)(8936002)(4326008)(8676002)(478600001)(55016003)(38070700009)(41300700001)(52536014)(38100700002)(71200400001)(83380400001)(66446008)(316002)(66476007)(64756008)(66946007)(66556008)(5660300002)(33656002)(110136005)(53546011)(6506007)(7696005)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LbIi/7SHLXR44vB+3Ep8QUVxrXCZdN7pjMNNsV4xhjGlF5XJgsAlNJhDiKrq?=
 =?us-ascii?Q?gIWDIwmJUnn2kYJFUW9JPLZZ5R8Tutl30svF3wOrlHTa/59zwkHFGtBZdqNs?=
 =?us-ascii?Q?Je/8LvpOXCzI4Hbfc24WY4vBRr1vRJiN3AOKIAO+VCWsFWHCaVKgBAm5Lhqo?=
 =?us-ascii?Q?yi9mBX5eZ/7rkMxMkcWZP4t/OKbiCRXNGwZbvf8xzo6sdgmYe5TYUsz2JRcd?=
 =?us-ascii?Q?fIod8Z6QRw41DV8M3LLby4Yk54pjYtg0hE3/7ZxG6YROq7zmnhQTCL7LnMxD?=
 =?us-ascii?Q?KxrbpxgkK7eOH/RKxN1H6k/lqPkU+8n8epVnQio3Ay9Bn0/dDg22yb6EsYyO?=
 =?us-ascii?Q?88uxOMLpaLuUNANLEcjBlmjSMgCr6t6yQ75nJnf5PAH+bgG2mRFTmeKQHti1?=
 =?us-ascii?Q?FSm0RWXh348+6jY08O+In7DwFIJfG7PAFL/U5E9y9WMTYKijiUu7Zf+CmFQK?=
 =?us-ascii?Q?3TbGBZ11fztt4aAPHRvTU0VCGYTTOu3ADxyFgueRuBnBiyAcBx/tHOGWENol?=
 =?us-ascii?Q?NGvxzdDPchwP6zW8W39DYiocwpnmsOC+44oDqQ1nvrFwRLa5qt9cmFxVkR+y?=
 =?us-ascii?Q?zGJIpEvapkmF3d+oImwHe/Bk0OlfUMjzmN5uLp+V6PV1qnJuFArjCheawBYT?=
 =?us-ascii?Q?MQhU8i6isN1FmP6LteVll8cSwpkLlF5q8Mdzv2i4q79GEIokRTIqxtuXFggZ?=
 =?us-ascii?Q?kvz8EzaYzmjuWNLhaDSpFpF48ESQPuAI+6pewMJFeq+6Rh2kGtw1d+k3SQWu?=
 =?us-ascii?Q?JCMk1EQp3jD7LKnV0hWNhpBcCn0sNu5dHc1waB5ESFGmTCr2bMo4V6kn2r9V?=
 =?us-ascii?Q?jMxFeUC1DdB2f0HTK1JWxCOrngx6cNrm+G6+To1v2GmoJI2NZKBTApv0cH0z?=
 =?us-ascii?Q?cOzyoydSjvTzmCutWLrY5HA4VWZeyViNq5fvUwWzHaiiK/F9mCohChuEoyhG?=
 =?us-ascii?Q?QVSyKjqCVZK/wNJpH5DirzM89Yx1YTOGhNlG7jJlHLo5cK4ab9uhafEHvIts?=
 =?us-ascii?Q?9S5qw+d9wVfZ8TwIhI7AjcGH5LMQN+iRjzrVhFMQKhLhnUPSAkr5OGQl//o3?=
 =?us-ascii?Q?YHUYs6a37b7Y2S7BH2wCdRIX0gm1IQr3c49TiOn5yHOn5UaMvk8igqhbvYnS?=
 =?us-ascii?Q?zSWi/BNexXteeDS8OndT0GdoOkES0VxcOhjNQImG0qdTlSxY1tAZ8gBIChuW?=
 =?us-ascii?Q?IcXqYoE89EsKFWt4yD4P2MIW3BwPa4bGjX7wR1EIqg0PYoh/YEKKsgAgekAE?=
 =?us-ascii?Q?5EyfDqSqHvAZGlVJVbROQlN9Wq7e2zX0ItxDW2L+YiYzQJf2xpHV9sNTBnQy?=
 =?us-ascii?Q?elySr8bG7hiWP36BJQuiD/1syoDi5JtyouE5rGULaUk3y6AYLDPTfR2Vgllh?=
 =?us-ascii?Q?DtCi0rFRVvsk4v1BzQYPoe6g56EzAkAVcnHbDnLCJ6AhmyfH5tJaetJJwLIS?=
 =?us-ascii?Q?yPL6UTaaK+HIm/JPpfIHRcmsfQ89rNzdDYcFn0XSyn9i25O+aua6Chgzf+mX?=
 =?us-ascii?Q?orwHdpQDn9NXl9B1UCJWPZBUszuLMDfMCD80euY0olSTuSqe8Vzw6Hbvx29X?=
 =?us-ascii?Q?350bqr5JVFFaiitH1TaAV1NPiEROsArkSzyYCJG7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b625a4cb-bcf7-4828-a29c-08dc1c945620
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 04:24:20.4921 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2rgcwO98fJnxvdQ6VnGOOq5rLrxT3tzSwi1+OIXcHmCtzvAFRPmFN/b2UKBP8EyAASM4hZFr0Qqtey4eVXr09g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Joshi, Mukul <Mukul.Joshi@amd.com>
Sent: Wednesday, January 24, 2024 05:01
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Joshi, Mukul <Mukul.Joshi@amd.com>
Subject: [PATCH] drm/amdgpu: Fix module unload hang with RAS enabled

The driver unload hangs because the page retirement kthread cannot be stopp=
ed as it is sleeping and waiting on page retirement event to occur. Add kth=
read_should_stop() to the event condition to wake up the kthread when kthre=
ad stop is called during driver unload.

Fixes: 45c3d468793d ("drm/amdgpu: Prepare for asynchronous processing of um=
c page retirement")
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index a32e7eb31354..80816c4ec1f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2670,8 +2670,12 @@ static int amdgpu_ras_page_retirement_thread(void *p=
aram)
        while (!kthread_should_stop()) {

                wait_event_interruptible(con->page_retirement_wq,
+                               kthread_should_stop() ||
                                atomic_read(&con->page_retirement_req_cnt))=
;

+               if (kthread_should_stop())
+                       break;
+
                dev_info(adev->dev, "Start processing page retirement. requ=
est:%d\n",
                        atomic_read(&con->page_retirement_req_cnt));

--
2.35.1

