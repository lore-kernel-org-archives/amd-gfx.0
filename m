Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBFAE7717F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2024 08:54:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EF8010E1D1;
	Tue, 17 Dec 2024 08:54:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z+Pyh1sR";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65BCC10E1D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2024 08:54:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9Bx3F9lBjOR40b9kC9SrvpkEeEKFNsM2rSxnC1eQ6hCMhH0ftOOdrRXsdGm8fl5HD66hyW/FxVC3w3mkIbxuuxEBdu01pgwVByN490EFPctPCtxH8PcAHkW2oU0X6K0IF+AWSCobixcFxrwhu6vww32dvVJf9tx5V3RNUAiyS4q3ueqvc1OSBBU0qFXnL9AdMV4jPC3bj9xkc3KEM809Rr+++C+a4bn+a+hUrHUZ95ywe10rKkG0SVqQbSJFbM5R84mIz3NsQMnex76s7e11R9e3o6YFZCritgT1qxzQRYZ34X/4gavWoY5+zXHtCCKjLPhvakBbY3uBxEZF1iwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxzUVIdYoqoK7SNwrROy4XKFga7AgIXysIJ8J7clNBM=;
 b=nOLSwPtIdY5dVzQE0OIUjFZ05k0goy9tpTbZBikvyVzYDUDVpx0kPHH50grEBd7L+DynJXk/TMCMYrJUx3SF30nCZVLJXr98mq3sQ27O+pK2tvJYoU24PWZlh6F65bJMYGPufRj6rZNXHRTihcx77T0KP2oUheIxNuPH4cGsymmS5oiXgL2a+mPsJzxAUqdJdsXZ57Rpkc3XQ7iIXl7RUu+9KQZPtvKtIOSewKY2DmAfth5cWJXzCeZ94RLpIrGxwAyXJio8/Gx3NThKzBJUM0gcrMwwAkq3myEIxba1Opk+f5GD8TFSZ/8zMDXQSKWyKja0rF5TVhOhT7w0mGJlNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxzUVIdYoqoK7SNwrROy4XKFga7AgIXysIJ8J7clNBM=;
 b=z+Pyh1sRdOsTEZ03YW4c/HRwq3o7VFmhnyE0HqvVhUxzWPN+N/muHYN/Wf1LthaeahUl9zrcCg+FwhQHHDcG7KIlqkQciox+IYmuG5y9mwmPpk1NSn/7leZkSThEucroLysL7/z2mMjqpPclwyvtklVmRYe+jW4ox6DI30/7j+U=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 08:54:14 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%5]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 08:54:14 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Refine ip detection log message
Thread-Topic: [PATCH] drm/amdgpu: Refine ip detection log message
Thread-Index: AQHbUE/vp6yRf9igjUewAp3AJB/6j7LqIdJw
Date: Tue, 17 Dec 2024 08:54:14 +0000
Message-ID: <DS7PR12MB6071470EE7BBDBC3DE63D9A88E042@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20241217064948.56037-1-lijo.lazar@amd.com>
In-Reply-To: <20241217064948.56037-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=cd184fdf-e666-4f88-a215-8187b38b0d6c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-17T08:54:04Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|MN2PR12MB4222:EE_
x-ms-office365-filtering-correlation-id: 16aa64ac-76e4-4636-9e7e-08dd1e7861b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?G9zBE5Ba/861QO/N95aGzUI/hVj8C+3Qj1aiVL6S2076ao1R+Oy4NG9qwIUE?=
 =?us-ascii?Q?aWvhsNkqM2jb37gtvImWOtLk+zWtrIvavsDTIcDE/CNw0ze9fENrQIjPQ53j?=
 =?us-ascii?Q?J0ije8+v25rJJe0r1i+pWZqwQpQof9V8L07kr5oPCjeiuUgfGTbj4JVxw/HC?=
 =?us-ascii?Q?+o4w9MSF3hCKEBFvX5EH1+PxN1862OKDUuU+CtY7uVmus6aFFtL7H+T+W4II?=
 =?us-ascii?Q?9GuzlwjiQVinI4vDIH3U94IHk/LjAxnU6nl3wjruVh9DlYwr9J4htBbgUf4D?=
 =?us-ascii?Q?Klep5ahlBBe2skrC6FJsVelSazVNTw4v+XI6GiNQexh9DtXkK/6XT6AcEIs3?=
 =?us-ascii?Q?gmoTcSoQ0j7iVZsQiTLhSQLHZj1rNLqEptRisb08WR+n21uDhK2P5S+fkmyo?=
 =?us-ascii?Q?vSxcR9c7+VxKi0siMAjvzjZVQDzx9z9Z+mnVWIQ0yYUBFvUkJgaVBqoId6NV?=
 =?us-ascii?Q?4ZObm7RTk5NMWquq0Mh+N9fhRKpnO/2oFl1YJTjano5JGk2i+jeA6LRts7E3?=
 =?us-ascii?Q?+BYgNch+3GWXijIUp75yrepcbQ4aJIxUifK+oD9RZAhKdD+kiZYMR+GQ7VfV?=
 =?us-ascii?Q?Kes5nOSyiSmOeQNhm9E/imzn9OJdOBUwdRcQcLimiXR6viIqzIsWlWaMV4ch?=
 =?us-ascii?Q?s09gjBsQkq/8fLqq8EYTwZvN4V5sqms8DBSltUk++AyzsdlP5zdLFy1e+Le1?=
 =?us-ascii?Q?GApBPr1j19GA29qXg+aS6gOdgqtywPxtCH+R8K93JlryuwpY7IHvqNAhvE0t?=
 =?us-ascii?Q?OCaxZ8DcCFcT8bwTKoxjtfaTeBILQi+X4qf2rWyyh+kQozUwz59zmXgUbR+j?=
 =?us-ascii?Q?bnH7FviP5MvW6u5wE/xVDZX7Z5WGi1nsgT91ZZ0L+1DU6/0M46M5kPc0LPY4?=
 =?us-ascii?Q?sPxnCXqCA33Sfed8BuJYtGG6ixwBcpXTgTKBos/f81Nz3AzHJqVnC02mWeqG?=
 =?us-ascii?Q?480lTdfFCQ2fHv7cSCvqu93WZP2u7Brz4ss6pkIELHtj7q3GhprSEK/1rL58?=
 =?us-ascii?Q?ByKESLOLGyt+JnGPbnHJBjBzA5GtxVILII7Ni/r3sr72qMahoMlYO2hyoCCm?=
 =?us-ascii?Q?1jT9galjZqoLg1lTqAlygq2y5YtCgHZKFhoiR9Fe7SwBnYG6/W39Cf5L4twr?=
 =?us-ascii?Q?5eCib6NlxRTwnlw12v2Cxj+FhlpQv+olS3/OTY+4w5jgzTAS9FapwgUnzOn5?=
 =?us-ascii?Q?0nqjnNxdxh9Us8qVBdwhKpDSW5k9SVDoSWsvm4tsuSaeuUqW40BEqHfJAdQ3?=
 =?us-ascii?Q?rMtREiKwZXVFhaLUmvxEm3e8QZuatyBx1cLGaQI74Jh5cqNpRFPkKKpv0h9f?=
 =?us-ascii?Q?R7wgArb0uezX9dfDcCrbiuQJcpAEFg2rWU3EecTYIe6b2W/8ihSGCiUv+jwN?=
 =?us-ascii?Q?xUXd+giNDGO7LEY9klIyqHeGrIbLKFRCGTi01SLMyGyd50u22A4wgekBBhXG?=
 =?us-ascii?Q?r3FT6P4cG6gibpiSCE4CJlYLvherP0oW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DmHa7Y+29vnMM/LKysn2aCVp0QHbGbvGAPOZZE0r2ForTw6dujOlTNri0e2U?=
 =?us-ascii?Q?JBM2hR+rahYymSgTkYdH7Ur/XYuGmxv5oqbu/jKBG6AZ/kCRsnpCwJ3vrRC0?=
 =?us-ascii?Q?pDb7ytpYuBSeYhoCZVn1UqvnhlBEb8JRK48NQM3Dv1rcunSyXOP1IGFpUsMF?=
 =?us-ascii?Q?6XBGZuQbLZF+QXOV7c+OeLdzokr3VlxXCJy9cQqha5aryhG9tU0J5/zYL92N?=
 =?us-ascii?Q?9U8VSWxidaC5qdcumzqp0uC8P5SSezWo9nhmVLUf3Jk8LHoYYTiz/zFVhoVQ?=
 =?us-ascii?Q?O4tAagv+yFMPk+sFD4CTchuA3ikfAx/YILhyN+UCNthC/BEMaxgkcaLD40Pf?=
 =?us-ascii?Q?W5WGEOfMJmtW2xtCVD1sOotW3VeJdauKfHnjFRElglQK1nEWK5wjl+tiYb8z?=
 =?us-ascii?Q?KfDZj5pPKnvFxo3yhhnYhStf6jAFCajBonNCyO8/5zvyTbMTcn5z6aRiqVer?=
 =?us-ascii?Q?vIEZwFvZkFg+wuh8POtzV/oBgj2DimfPR15z0veBbyaoA6yZiFgRo5azu2nN?=
 =?us-ascii?Q?1HPGrVZ2kZGbiDEXpfEBzoers5ORyuI2UEV7Ktv91z4INiCQJzDJ0PDuCQlr?=
 =?us-ascii?Q?W0A1eF17e4WONrImc0oH1BAdN/+/nNtjo1qdNQkVrOla0MftrjvnJNlWZO9J?=
 =?us-ascii?Q?k0CBcv/wRV3qrmhUqRtKla6qY9I64L8fzBGNlWduNbQogp1V9f9hxpYjJlIQ?=
 =?us-ascii?Q?XrhV1YBDAq9zoRdXUXUDPSKZx4azMFI11xRuYGMf5oXZdo73bWCVzKKdwNkt?=
 =?us-ascii?Q?ltFmEajjw/woQOyQbgm1nPv8U4OP1xPddg2KwczY5ehZvRKlJUks7ib2yqyU?=
 =?us-ascii?Q?n/R872MsQ1J0z7JJTnAyFeMPTeJlEP3IXNcSGwYdx00aQL3kzdUPrmcByc/z?=
 =?us-ascii?Q?MrgYuS6vCvnyQaTsjLbExMqUSxBpoQaHfRQuZN46HFQxMscPusJO+iUTgyUI?=
 =?us-ascii?Q?2zyymf6D1Q/hE+0vd/JSfHqx8kr1fnHb2Tp3rylmMDh11zWZTHrS4O+EpwRL?=
 =?us-ascii?Q?L40oPQrGbv3Kq1wUpDjreFXAuUwtv5zhFJ0FtydMJp7zpNmGj1KCZ0/VgC8z?=
 =?us-ascii?Q?o2TpTOnvXf+uAmU7Gpqbe4Q+vPInihfPILFgb7SpyVXooQmXMsR3LtKFUdDx?=
 =?us-ascii?Q?ikeP4awCq/RBBm8HNB5EFkIUdb0WQVlPZGNrqVwLleYEA8rXAVeS5VJqk84J?=
 =?us-ascii?Q?8SPn/IY3bUbJc6gEslhJQKyKCLDzbxoJT3ICG0w+hgPI6VWqUD7xy7DBV08e?=
 =?us-ascii?Q?/Hn94YzIApcPVwJ/yBeZWQ1OFwOwQBiM/VHIqn2OgZGNm+IEXwwvWDg4dRwE?=
 =?us-ascii?Q?D+9MCD/JB+k5hWTEaNFIuDcVe6O6GkcrfFSe6Aph1nFmHwNu0gKnxBWabdgj?=
 =?us-ascii?Q?bwtNEPyHzKw0V7RMGBoLKulgT5GOV0Nd/DLs88MR8f8yXiDEf2ov8xvzK+xu?=
 =?us-ascii?Q?VKM38Boy0v3q3CadWbhQvd+WeCidZVfOu7qZ6+aaVVz1yOm5dy41hujpcsBH?=
 =?us-ascii?Q?rE5auz09lB8FeQWRXpCp+Eo6pXDiidOXeGgKWMTRl14zkimuwaTZuv1BOHSJ?=
 =?us-ascii?Q?CE92P49hhRp78BG2PrM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16aa64ac-76e4-4636-9e7e-08dd1e7861b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 08:54:14.0676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ku7eyl3L7WlaMRrH3t/K7xEg1NrCT6dt3kzGvd+bMQW1f9sNW23GsIgnL4t90my6DODf3nDpKGsaISdbxXMtIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, December 17, 2024 12:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Refine ip detection log message

'add ip block' causes a confusion if the blocks are disabled later with ip_=
block_mask. Instead change to 'detected' and also add device context.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 0a121aab5c74..182b6288df9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2365,8 +2365,8 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *=
adev,
                break;
        }

-       DRM_INFO("add ip block number %d <%s>\n", adev->num_ip_blocks,
-                 ip_block_version->funcs->name);
+       dev_info(adev->dev, "detected ip block number %d <%s>\n",
+                adev->num_ip_blocks, ip_block_version->funcs->name);

        adev->ip_blocks[adev->num_ip_blocks].adev =3D adev;

--
2.25.1

