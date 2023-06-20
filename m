Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E554EB64D7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jun 2023 14:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 108C110E2E4;
	Tue, 20 Jun 2023 14:05:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7895C10E2E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 14:04:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fC7Dv31qMXJ07kT6ph6GBtKo/1cRbWCJGWRjj8sACh2oSVXpfa5TEh639NVQbNEx5D2EUFP/lv6BSBI8VAb3JCN6gLisaKKFWzLJjSMgQnFzizGPpQMbgRvOXhFmP6wwyZRy2FK42VN8HkaTH9vVJVp5u8qR9QTZhLhE9H+t/T28PiEDw4L8oANWsHNj1ytXfY2DE/Ty2Vn+DBZaYL5plzQ0UKkfq064As2twjoeOoinE0+Y1AQGrZ8Zf6b0HZDirXIF33ee3Jg7X5g4tnrMde+FC7VS1Hv7DwEPOhuBQyP8P33ETk1DoknELExTnrzdti6z2x8U63CY3O4Zr2cVVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PNie5kErE0pcNZLDYK6oFR25wwH1TJ5kOpFaUsIUdU=;
 b=Vln2GdXPjZX1h1XMqB6pgp7NB8P0CcJ8KOoo9AB03nZt+J2e8YJquOutTPzAkF9HcIJSPYd+6FdGvwDWzw4lQTgld3uhJdPXO6ETG27xI6cik7vk7TGG2HPOJLZKFNTh5KT/q9/j2tukFYa5b1cy8Viq8R/y96xANuTp7oqiPrOM+jM55BLK52FeZ4SuIqGT/QD+XGrAcTpRN4IvHpIhcAdv+aY94C+SmhFJrnuI/x3r1H5s7VHeFKgc8vF/8EudArydD/CosilAubcsgDHXlIv2AKMEAql+VUSSAxAsl9AJ8PKx8JZbncjaE/mgTb8pagrl8YLafxfDrX9KlCpFSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PNie5kErE0pcNZLDYK6oFR25wwH1TJ5kOpFaUsIUdU=;
 b=BhS6m8mjBp3pBqkvC7YQXTHJPHkxARYhsjBjKPaSP1tQDTSEABNkKgkWmSc1zbGLYwxvwxYKBsQRbUY8GA3S/huGhQUnILct4H75c2sMtGNg8rkLkzwjTEp6uZJ7Ysy9+2tmQta6F3WaqDl4C9ZYaVH9OUfkGLyxadBG8Ig5+cU=
Received: from SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20)
 by SN7PR12MB8434.namprd12.prod.outlook.com (2603:10b6:806:2e6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Tue, 20 Jun
 2023 14:04:52 +0000
Received: from SJ1PR12MB6292.namprd12.prod.outlook.com
 ([fe80::1efc:1fda:365e:bd4a]) by SJ1PR12MB6292.namprd12.prod.outlook.com
 ([fe80::1efc:1fda:365e:bd4a%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 14:04:51 +0000
From: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Modify for_each_inst macro
Thread-Topic: [PATCH v2] drm/amdgpu: Modify for_each_inst macro
Thread-Index: AQHZon/35VWvoc48Qka9eu+D9TZd06+Tuw/Q
Date: Tue, 20 Jun 2023 14:04:51 +0000
Message-ID: <SJ1PR12MB62923CC1ED2D296F8E28A4CF8B5CA@SJ1PR12MB6292.namprd12.prod.outlook.com>
References: <20230619072956.2063020-1-lijo.lazar@amd.com>
In-Reply-To: <20230619072956.2063020-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a49e0e29-39e1-4579-a161-6d78dff9e789;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-20T14:03:46Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6292:EE_|SN7PR12MB8434:EE_
x-ms-office365-filtering-correlation-id: 6c99b745-a784-443f-39ae-08db719750d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NRxxdv+lu95WrEGV0VNzl9pQRUxtXVxSgaJCXaVrTs743fgogsmgIzUoVwFUWT4zZbC1U31n8MO1ujr9/qw8352iC7WzmP/jnC+EYXx6Ykt1nFAmLgaZmQE5QUBjDKUsA0PVkHjW0GcB9oPoKIAHXn9GwxVMNCrIwRkRp3x2bVbYCHUeXT8qQxkPwXOZcrvYakSWSdBHXvtiy9KKWqgJf5l+5wZLG0Ts+7jbgh53ILog3vQWozlUM90FXhAX6TQhWvfDy4IWH+Nlx4+OPFTMLdk3OH5orvVixCDIYbg9hWSu0BWrVzIHUPZjsk568b47iRGmGpgWxQDlqqV3+mFgYkgLPsi+HwBdktK3DfLdaGaHVFyYYqrj9WKi/AtoemiukNMYpSCLuZA3Cq9Hei5IcOgbKBpR0SOV8JG8punzN5aggwZOQUYQkgO/scAeOoZqjh5J23GE79mzbvkGRWgWR15OblX6K3QrWzgvwJlIYR57o0HDU7y30XimVLvjsfgZAhr7GjbmIORu2vpaYFhqTlHTP7LgWm/EEfd8XNcZGU+hmxG5o4vkqF7UAKzElWRkHY3+AwODQgG/wIlfDVu+wi5i6K2ESZ5ubjs8Exvymn3C6SBZmrPdCh6M+PS7j8TL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6292.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(478600001)(52536014)(5660300002)(64756008)(66476007)(76116006)(4326008)(2906002)(66556008)(66446008)(54906003)(110136005)(41300700001)(66946007)(316002)(53546011)(7696005)(71200400001)(8676002)(8936002)(6506007)(186003)(26005)(9686003)(83380400001)(122000001)(55016003)(38100700002)(33656002)(86362001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C5gYYClpf9q9aSZhzNIHtTTTtyZkaSt0zwmrwSAdbpHIIaCG3I4qNY6cNpW8?=
 =?us-ascii?Q?58secyP4oKnw6YqHN7fV9rFVGiQIEKHYhpWNzuvn40NxW6inzc9V/QvE2sM3?=
 =?us-ascii?Q?LaAzQM6k8x4wrZxFtW0n9OJJwV4j89+SNkDmlmogMfceR4k6Id+WKr7Fp//c?=
 =?us-ascii?Q?aK0eRslG/2zC3TOZyIQfWX4FDn3TNWFE9rOiWWNTsBe+5BSKo+ipZ3+xl6Sx?=
 =?us-ascii?Q?DrS8kGwMSOymMPIr8IXG8LXwyVmwqrUdZWFry+/oTplYF/vW8HtxXBwEkoP9?=
 =?us-ascii?Q?ZNkYiYLqoXSZ1WcqHFMeBNUA7E2S1XcUQiCOeY3PrDcUe0YI40j6AlXHLDvA?=
 =?us-ascii?Q?dtlSeeoqzqjIMdbIvVcqz3dxsab3UhljoG8NbZoXN+dfg/YAAJ4WztDjozV4?=
 =?us-ascii?Q?6oT48UpALkjdUYY/cpv8VkbplPU/Y4bn76Zmtvz9qBgHnIvDxtBmAt2Y+18d?=
 =?us-ascii?Q?FQDMp2AUkZCKWJhT6IHiJUywcZ1pzWG8ArfR8jzsGEzJFBtg07pKhR6BpO/+?=
 =?us-ascii?Q?utBGjjqwwJZ8cWIGYESWke7660yXM4Zn3JcOLGiX5Od8jsBgTm8pQN7NboqS?=
 =?us-ascii?Q?LiMlpSrNRW4gIH1n/Ni0BXlFRPj+QHuZd1qcgMSszhZqlZbx7/7uNh9Ui2ot?=
 =?us-ascii?Q?XeaKXLX672SOIAb9bgGqlfsW1LML1x8BIRnKssKOeOpPk5Lbjy+MHaJHDpqB?=
 =?us-ascii?Q?X1KoyJeN4McMPwV48gMXpSVNEQpX32+eeFkNSuSuSbGoTlmK65YZ3qNJ/map?=
 =?us-ascii?Q?XN3lsSdVxkJ9x7qZ84eUvX3rUaHM4XSG6ON4o7iCazo5oNTXBIZZ5hEOZi5S?=
 =?us-ascii?Q?8rX1e6KD7qBm7+iJ9HKSRnxNPOOcLFVpbmV1n4OQzC5rmujjI6Po9ZFZ9uWg?=
 =?us-ascii?Q?Zd7V8fuF8laN/aTKcfUymc3zhMfqZouKkF4IWakCsMyZghlManD1Pk45/KBT?=
 =?us-ascii?Q?VSwKzOYCC1tB3hUXR+ynRWZJbLjak87CuBR6iO6R4uTK8Hir0lo3VeU+334I?=
 =?us-ascii?Q?FbRlctnB8AiCbD3to8PqIz51sgVNvNkCKGZoDHulvVjGcY821ggpk4xvFxlg?=
 =?us-ascii?Q?vecpSFs+isUADUC4SE/PW2rhnzA+gxGXgYMqF8fPZc7HD4YhkE5YIfSx0Qns?=
 =?us-ascii?Q?AUeQ5Zqp8diqT7xpY3qDG3TfviLlRmge0b7du3b1zyw3izafOd9RgddV5UR9?=
 =?us-ascii?Q?5si0DDCgA/FEMBVYTwFO5t5sasetewJfTFMVFzpEqwTxLFNvcQTzHJEhez2Q?=
 =?us-ascii?Q?QIn3/y7i/OvVl6/+6HUmZu9sNRG3EmKzSwjwbVIL+XqsJSyOdagZ7NkKiXAm?=
 =?us-ascii?Q?v4G8HpqKTbQ89G1szca01IfpEIIuVa7q9eesMechuOQOE3qGHb/G2Cz1CSYK?=
 =?us-ascii?Q?WO7VEsu6lD6u6YCRpkWaoupeWvRMHyStsIeiMqVgMlN7ZSxglVDprRIxyb8h?=
 =?us-ascii?Q?JL3EsYbH5ArqTaS/1At5O5Kdh8azIMl847EFgzgDMrj2SMtwG6mTZrtE6KeC?=
 =?us-ascii?Q?tvzvBB7aXOAlvbNWi1rTfzF4pXetQbF8rtoaF9RvcuBcuZ5tJwYF4o20MjJ7?=
 =?us-ascii?Q?27v5/eNeDJjLI+z96mo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6292.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c99b745-a784-443f-39ae-08db719750d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 14:04:51.3153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tjdEozt2hyVTyd7EfpnnXZZN0HhNCAUcfIPDwiixP5ji/0MTL6MrAolkkW9JDTGLjc2Z4c+aphbkKKJ5tPfXTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8434
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Acked-by: Victor Skvortsov <victor.skvortsov@amd.com>

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, June 19, 2023 3:30 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Skvortsov, Victo=
r <Victor.Skvortsov@amd.com>
Subject: [PATCH v2] drm/amdgpu: Modify for_each_inst macro

Modify it such that it doesn't change the instance mask parameter.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2:
        Take care of bit-shift beyond width (Victor)

 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index f4029c13a9be..aa42347bd67d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1295,9 +1295,10 @@ int emu_soc_asic_init(struct amdgpu_device *adev);

 #define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter)=
);

-#define for_each_inst(i, inst_mask)                                       =
     \
-       for (i =3D ffs(inst_mask) - 1; inst_mask;                          =
      \
-            inst_mask &=3D ~(1U << i), i =3D ffs(inst_mask) - 1)
+#define BIT_MASK_UPPER(i) ((i) >=3D BITS_PER_LONG ? 0 : ~0UL << (i))
+#define for_each_inst(i, inst_mask)        \
+       for (i =3D ffs(inst_mask); i-- !=3D 0; \
+            i =3D ffs(inst_mask & BIT_MASK_UPPER(i + 1)))

 #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))

--
2.25.1

