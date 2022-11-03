Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA63C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 04:13:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D33A789220;
	Thu,  3 Nov 2022 04:13:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D411610E594
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 04:13:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HR9qHG99NWJ6KZKVfbDvH6NWeWjKWZu1j/M43UouBa92XTXD7Q+d76YbTrvN4DgCv3Evt9faDeMc3ZzV1iUIe8MqoY7bMoXjirNW55L+iDNWXfMdtsFylv65hC/NHDX8g3vvtvrNNIZGAZZhZMrHka9DX83aAvc0l3K5F9yim/bHcFtiEAPvxw6Gwgh0cDIZVpO7TvSZtH0tbh9tV4UW3uz+/Ljub14V02+GpFpyCI6P0S1mcMN7ZgNJn4nhFir3k30NFxRt2erjylTUQb8JeHLr/k5DG+eEJ/6hT8ayTOLEqeIiJl6Z+2ZOADiE4jdKfry/tAD4jDjMYtNIFH3kgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9020OVMq2tifRYJpa27fH/+u06dESBDTf8crUUtW2c=;
 b=UkMtzpo8fu1cB1BtPer8SBqunnm+GfRPuOdY3oE3OSVOoHIJA7s3s4pVqN+wtXD2/sLmzXcOZdiYysjXVoRQoXCykSMs/RqmltYLy7ShdvB9aRTqA0sL2hSfK5EOO0443JWhe0j9dfcukM/9bNW0jOYrcpban3ATsbJaxTKZHO5gVR0t0f+yf9ZggmSQbPOXGwG0NtA823QeuDCR7pS4d2kmK10f8GAY8YFl2yIeTZPFPlWp99Ka8Hmk5JoMpdAUj+7RlU6dN9pSccVc3DAcAeizdUpRL4wNKYgUt47M3p3Red/sfg2zTssbGclrhUGf3cOhv9Q/7n5M2NyDMUCLWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9020OVMq2tifRYJpa27fH/+u06dESBDTf8crUUtW2c=;
 b=DWOWuMGjuATR0Pj3ShQmqQC7Uzd/OkUOo+Xn2nBpQwYoICgUgba3yLB0KfhYf6OV3MoFeR66YnxMW4XNvu6O+fN07gKIbt9bAvwbOygXtKMCrT3gDR8ykOeckS20ZBOUU4Moi/+KtPSgEhE2gzrNuJfZ2hst/QYj+Ex7IcsHEzg=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB6954.namprd12.prod.outlook.com (2603:10b6:510:1b7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 04:13:26 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8bd7:b65c:13f4:9b]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8bd7:b65c:13f4:9b%9]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 04:13:26 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: temporary workaround to skip ras error
 for gc_v11_0_3
Thread-Topic: [PATCH] drm/amd/amdgpu: temporary workaround to skip ras error
 for gc_v11_0_3
Thread-Index: AQHY7zXkM5IMpsGC4kSp12T+m2nUgq4slqgA
Date: Thu, 3 Nov 2022 04:13:26 +0000
Message-ID: <BN9PR12MB52574F370C2E736F150B5ABDFC389@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221103033915.1403759-1-kenneth.feng@amd.com>
In-Reply-To: <20221103033915.1403759-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-03T04:13:24Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ff19ab49-da21-4cf2-ba94-3dffe37c8e30;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB6954:EE_
x-ms-office365-filtering-correlation-id: 04b3a364-99c4-4056-7282-08dabd51c196
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kJE4mJDOB55jquGr7Ht6O6etwG3INvHWAAw2vq1jntMfPQ7wIANFzOf8UYBTBxhugLLuYT4vLaYK36XLi2RDBBm7Cu1XwOH5mPzJ7+J6Zz45f7MsnOjQm8OZMdunWYcY4ktqCgrLuIuuoqUF/G8UQDpZ0XUcfVylPIzDwJWkH9oPvbwpmZwI/M5royf/M36MHXl33JgP2bO7Fh7eA8tQ4rQ3azBZkyNBnReeRHC9/acysQQgwtT1G4bQHkfUsAOZuNzJr+2LtrM/W3jHaI8P3KRxYndB5CYJ4lAuF1TzeLyGGz2/6QZ5wn/iaNUkG8/2FtfR827GUTkzm/Z0mEC6eZDr2jJn7jmgWxvhHERC05AnU23YX+OtJkieRLhHoHkHhJElUBBnl2MiOMljBxTA/o/eKwuaVJm5SI5kHSQRH5dTCy+dQqEjSXwMS3D5YTZpKnT27FQIWaAoPClqbRuYI/8veACYBe43uon2oN0u6IG9eyaSMXh3Nx0N4EvsXsLTn3XFtIT89rf1JwkwHAdJIKnxSTuKcSL9XdWnqHyjZN+DqLDwfZc0/KqT1r3n6ImQSl3TpgOKYp0KFVB/9Ubx3Og5KPSg9l5KmD6yo1IxOapp30LBWraIiQzrsYYiKXJWCwoQIrdtqYvF2ZayDCrGrsg6eyFslb5DlRg5bsIthovBhgrc1W0QVa6LowBkQ7s6EIPtPh2eDeQGT4Zk9aUDY3qvd+cXxy0v2cotmEfksUqQ6qCnOas99MXuiGbAlyPFqAj2EKg0wlUIqAsrTU5VwQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199015)(110136005)(478600001)(186003)(53546011)(76116006)(66556008)(66946007)(8676002)(4326008)(71200400001)(9686003)(41300700001)(52536014)(26005)(8936002)(2906002)(5660300002)(66476007)(83380400001)(38070700005)(55016003)(38100700002)(64756008)(66446008)(7696005)(316002)(6506007)(33656002)(86362001)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oGFs5PyW4n41LqE5mUNplxhWTftrqhsuY7NcaBKSSPDz1OKAMcDv7rA927P5?=
 =?us-ascii?Q?jJHVtjjmdxpNsNbROlVjFrIPHe72XK6mAqzATOAqHFlFWS3tU9wbLC2QvDvo?=
 =?us-ascii?Q?pVEnQ3nWLLwbvNt6Vq/y+CsATq+KXTYU+ypcUVz/CVqpxWPVAeXsQ0pXeLG1?=
 =?us-ascii?Q?MaLNvdoLh4nOgag7R3AahFzV2xTPmskbJkxW/rxXcgHNciEu0B3Lra+bnAn7?=
 =?us-ascii?Q?50Pj5zHmvEeceKG0UvD5JLtpNb5BQAN791oXgdjseWesFPqp2/ki67iCRgTW?=
 =?us-ascii?Q?3OzKKue+lBHvyZf5VCdgQVrX+aJwFKQu7REb0YfRf3inHyY4FVO9jkTctdaa?=
 =?us-ascii?Q?JkvtGj6DoOOA9r6ORkXhQsL6heeOrBek/HTU1XiGchvNll79mZJBEiqLhCHn?=
 =?us-ascii?Q?KEliE74UDQtfXvmj2LDE3N9Tpf4ajlnElYnZZZew7fBwhNEjeai9khai5pcZ?=
 =?us-ascii?Q?3gy8GnhhnSA27bDCAhoai5U8Mr9dZRPj4+z0NY8wKle2IG9lprDaxh8cDxIF?=
 =?us-ascii?Q?c07it2IMVijlQJpp9VCh5TPRsORjQtT8+qM6AYzQC5o2FBiCc2dRxfByD0cH?=
 =?us-ascii?Q?kbZ9AOFWEMw6255G2oLv4vLT+cH4mFivvi3PtW8ETuQx3mtfLyq9XMJspMB6?=
 =?us-ascii?Q?fnMgWG6U0QalUrHIStKMonzVgmp22hpuK/fpjYi7fNAl6zp/RhtsQo7EjR1K?=
 =?us-ascii?Q?wpldwqbQ2mn1ayJahRAw18UiNwVRrGySQ1hmN/0npZmL0vCogmNvfy0AA3fz?=
 =?us-ascii?Q?SWI6Gizc+k8IiIzLRjnesDF6I7Semfwp3v2qRz7lsyhWIEOfqp6yZ32BdpS0?=
 =?us-ascii?Q?BIHmjqZuFARuRlqdMkRRK3m/HXFVSdo4tTzp7Av/5jgRwDY4b9/6Sp64gKHf?=
 =?us-ascii?Q?nSsy6H3JBBN1HEFUxmsJR0UTIrb4IeX3oPnCepGvWPqkwsFIajAwiqRYHsPg?=
 =?us-ascii?Q?EDZpujfaJE4HqAWAPARZAmNv8z3KeGkcA0LK8xRdBR0BUXWINaS9iiuUgBz6?=
 =?us-ascii?Q?y7w459OJtsxb27GBHkM/xAYteN5E69UDgbowuX1rPFvuj69r1397gRGG4JGf?=
 =?us-ascii?Q?IK0uyUfOxwpxA2ithCyvtkiohbEVxch5VB5o+dnsI4Z4La0VWNGn2BXT/2nc?=
 =?us-ascii?Q?Wt9u42KFxXCCiKPU9cOjmUEzYMh/9pOSCMQSKxOuFItTFKHjwV87ILg20gXX?=
 =?us-ascii?Q?hKJhpNwrYmqP14d7xFW0WolNYL9X84TmS03fxXAuFxOBggXC3DZcG05vGuxQ?=
 =?us-ascii?Q?Fco/7ENDcDaso4DAdreAlAFxKvRLxgq0IOR1Tqi/vcg0BskV5O19O7zhLaFV?=
 =?us-ascii?Q?3wwQ+twQd9XKjMH9hpgReg0Co8/ErgWSRTQ1KUno8Z22uvFzdH2RUgrNxdo0?=
 =?us-ascii?Q?5PeoiEQWvJzkV2p1O3WHurgMs+Z1aVia1c3S1J08C35Qq6gGG+vanSPk7Iv1?=
 =?us-ascii?Q?3JobZTdiHDfh8APvMtvfFpl2S5vpa8a89eua2+TXLJ3GWtpu1Xr0MzAJ56mG?=
 =?us-ascii?Q?ZIK4qKx7K0O++u5dR/jHjdJYlGgPEHYXPS5mY3mjFemJkreAEjRKT5Z571Kh?=
 =?us-ascii?Q?tr/DHk98zUAp6y3V4X+SUJvRIonqoLO4wpAWOvxt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b3a364-99c4-4056-7282-08dabd51c196
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 04:13:26.3583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JO/IhF7fRfGxZ4+M4JVKGvaLQ26YY8CPLsFsHG3vBEpUAMPFOLTmJbKce9wVgFLk7kPvMyPOb5vz3IKRcAOjcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6954
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth =
Feng
Sent: Thursday, November 3, 2022 11:39
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/amdgpu: temporary workaround to skip ras error for=
 gc_v11_0_3

temporary workaround to skip ras error for gc_v11_0_3 until IFWI release la=
ter

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index 84a76c36d9a7..dac236a6b3b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4688,10 +4688,10 @@ static int gfx_v11_0_ras_late_init(void *handle)
=20
 	ret =3D amdgpu_ras_feature_enable(adev, gfx_common_if, true);
 	if (ret)
-		dev_err(adev->dev, "Failed to enable gfx11 ras feature\n");
+		dev_warn(adev->dev, "Failed to enable gfx11 ras feature\n");
=20
 	kfree(gfx_common_if);
-	return ret;
+	return 0;
 }
=20
 static int gfx_v11_0_late_init(void *handle)
--=20
2.25.1
