Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40A2C54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 16:28:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9530110FBF3;
	Thu, 14 Mar 2024 16:28:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p5AJjmIH";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D54A110FBF3
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 16:28:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwizxlJpoY4Xci32hmPR9TKc42GjGiKh9WK+eFC+5WHKjbNxuzlwY7lwBbDJlx2YT+SeleU3102GVKu92zA9XmRUtKLSNgoaxI6I2YYfolN1YZgwkxaHTKNj/74c5aXdY2x/EGeVTYS4C2JOcWAMIZFvw81HQTQ0a9kvdgXLwCulsBjiiUEOFge/21T/+LP3918gsSaixFb784DfDptBtldFrgpqi+nJWYVOHiOtsY36ZnQf2hpv5WmfRJXGXsdNMvDNugDO0a8P+gYXyrQ7/Rd77mo2rT4XyeL51up/Hve4147T0MfbzErdCMr0Gc/BAF3/OKKHJD6Dh28GahYSqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5CRxyXGAzLtYgoVEPJfKPAvdiMgx4HRx0vqFlzGbtM=;
 b=ZJH2T49B5hjS06hbEtax5GSTkpMuNAEE72pdP3G3DaWZIe2rDe8qYxkbeTydVQMKpzNgpmhtWWZ8lesd4X6FSyKzsNh/uql3SAsa970C5Q9RvPS6G9kACUJdB0QuHMrwobn27svzLZidlPjAd8V7wC50oyY270pEMb0fthQbbxZuRsG1De3CCgmBKxzPnxlypnq0ChJtnxrItkA6mBIEuUgwvYuYtQZ0OXPfXJVkw7Dlsqj6i3sKiIjuWkX4e7int1xq+GZIPR9nalako7F4Ppz5yPFT+bk6HWhFAlB1hOJMwkwA+NmqL6ShZu+FewMi7JMXB0RE+r+gEt72LEGBtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5CRxyXGAzLtYgoVEPJfKPAvdiMgx4HRx0vqFlzGbtM=;
 b=p5AJjmIHrxbJfr7p2baJEP1isoV/8MnnC9I9dvNAgjwebgcYD5m9eFK9B/7lYlIjykNfEBwvv9KRac6fP9/hKPydfoYHeJy+aDO+Jfn148f/r/csHQEOQUgI+/U6PPvWaAagsUVYs0WwyNPROa6fgI90FiT7fMSIDohInTJ9aa4=
Received: from DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12)
 by MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.41; Thu, 14 Mar
 2024 16:28:30 +0000
Received: from DM4PR12MB5328.namprd12.prod.outlook.com
 ([fe80::88dd:d6b6:2f6a:cc3c]) by DM4PR12MB5328.namprd12.prod.outlook.com
 ([fe80::88dd:d6b6:2f6a:cc3c%5]) with mapi id 15.20.7386.020; Thu, 14 Mar 2024
 16:28:30 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Skip virt_exchange_init on SDMA poison
 consumption
Thread-Topic: [PATCH] drm/amdgpu: Skip virt_exchange_init on SDMA poison
 consumption
Thread-Index: AQHadOtwtep4y9eXGUuI1BcSaH8nG7E3b2+w
Date: Thu, 14 Mar 2024 16:28:30 +0000
Message-ID: <DM4PR12MB5328227D19D243345685BB6DF1292@DM4PR12MB5328.namprd12.prod.outlook.com>
References: <20240313020843.223278-1-victor.skvortsov@amd.com>
In-Reply-To: <20240313020843.223278-1-victor.skvortsov@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=75abbfe2-e48c-4e4b-8eda-7d88a764b98e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-14T16:28:25Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5328:EE_|MN0PR12MB5716:EE_
x-ms-office365-filtering-correlation-id: 087030e6-26ba-47a0-7972-08dc4443c8d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: snJywSyhDdUlmPeCf31pLe8MayHQYxLUm0D5z4ob6EjsECeQp7acPUCpR3tqMcYcRHv+qyhQYatc4F9UcqB00TZH1qsda4E5+kr0bPzDXbk6HqhMYR6ZtO6pVrBPEKFEaO5pMwdR9LvVktMwvplESL81Tx86jdOxSuIUhxP8Q2PE98tmpn1o7dCh+s7YtLdzlKfNWXe3oIaQWYA4IJLQXWp+1f6a6CH0sTtQfFUrMHJCZNGSYvxE3JUWsD3Xp2ujk2+mucOe3b5TFBlC2g5esbqY+8V+943Ny1QGdypy0YN+KuW7GTpHMfr+zs9Zq8jRwtzhOYYRfaFqO5ZGXCy55nH61Kz8LKEUX9eq5anBiTpvofb7TnJCCnxnbgJb+AnXL3alim7XiiT56eoF7/O02g7/8/pKSaAR1ItlvD0aqD12daeMF8EmTY7yw6AFckryfInz9py0Opea9+httJK82RlFKPm3jI9oACEp8M1ADLl+5tFrk4/F3p9VeJclPKYwKMYcW7cI5nHVWKrp6ESKjP6iolEUDU78ZXUWBvHoI715clhctKK8ekZewJugxE3bAv6hv8fibRUsA2tKXBxjm/Od50+/NFtUTXJQCtTQ3WFrEYxYOBg2y5ax5xP4zznwYafuoUqO9VPCZpK3bak2BUQFWV6yT63jQjYlQYvLAs5vFETxBcFvdSRMfT+iJw5VF3dnFfGnkXAslHC9OE7stF0dkbOMUcTNL+fdBg4QpgI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5328.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O3UgFdSBHmHsjABGqF5OSJdaA1ZVZwM52b4CHSP9YnGFUuc70yAi2Mhq/E8F?=
 =?us-ascii?Q?Fx9kQBBlz0zEYguGbXS9qDB9KqXuNmfTakXL4jW/I55yUVmcB3ARveFxAO3n?=
 =?us-ascii?Q?+c+M49a1C3KxrLwo4WuF9O6qmQd11+UQMnhNSNJh72I+FbPh60AGqZbnkalt?=
 =?us-ascii?Q?JcF+FdZq/113wZlmi1U4G6KvWknTjeb1bdRNSELrNoLYlcuSX7dNEEOc70C2?=
 =?us-ascii?Q?XW6oy0EBBc+5kOHtmxlUXwRyK/zN80DnGf9xVkHVce+RyGRrw/P+fN8In9pc?=
 =?us-ascii?Q?7RXbSJl7Bc5OwfjYG4sEXfB55zzYAVnXst4N2dUqkFb3yHJOKG5WqvYWfPu2?=
 =?us-ascii?Q?EDhu7vrRy55kIxI0LnB2JDF/e/VBVtNuJ6n75p7d7b7uSzBQHxr4+UBd+9v7?=
 =?us-ascii?Q?b8lG3QIp80A8cPs9hPKzFY5WYjURVMrOU2Nk1IR8aZAtVxFvVx5xSNP/ZvCh?=
 =?us-ascii?Q?3/+CpD5mA/OJSMlpD98TzTRzYYmmSQvKs6DvNxZJpD0UQGZzDhcTndtiShC1?=
 =?us-ascii?Q?y77O7XG0SF/TNs8/Xqj1vLwXcGSu1+N8duZ8dSiJBe28lRfFNsr+mHOMu8L7?=
 =?us-ascii?Q?XXlENX697RI7ZsDcXm9fVbHOytguGMkpd0ESESeRrDDhG3ycYDWIHiOQ3Hzq?=
 =?us-ascii?Q?70vAHALI6F1Dzz0zd97lToHTuoTzK8v4ccJCpHMT/xRO/C2HvjFxSLj6bfA4?=
 =?us-ascii?Q?GIdLnU/W9cFyPV4WMSHqetm6Z5M2+E+NtmKBFp75I3srg3FvOzmq7IPB4wsM?=
 =?us-ascii?Q?tkBjHmD8qdipEac4FjiFOw+SeWnSDNjkfvlFpjFhK2hbpsjGfK6Ur94kPRm/?=
 =?us-ascii?Q?2yiWnqrHsIkjT4LpAzr98UB0Nct1rA5NmYebtN01bFvYO1jqx3GkSfTmTQ62?=
 =?us-ascii?Q?ZdGG4IIS4AS4PpGFJCn+a6q5icgNI7OA/lGok46uUeiOVP9jg/Y+204M+h4s?=
 =?us-ascii?Q?XbuvW1DKjV7iSaS98eDB7BTPcGIMEtJM9ma6huq/ohTaDIDLwr9eOpWrlyMP?=
 =?us-ascii?Q?hxvgm1Fni6vFS/xGPyHM66XMJVodRJEv6ULgZgcn4HqjbFMqbYiJ3q4xMMjb?=
 =?us-ascii?Q?PQXhhghTfepFfV5cuIZRJ70Z8elsi18pUTldIYUUv6o2MLCxtXeL/ClAU2za?=
 =?us-ascii?Q?65bUkY+nZ31XAjDfHaJ4tAOGVh3x22UdQ1ep7dubAj+1HVf0EvmUWsIX0Aa1?=
 =?us-ascii?Q?zEhQUA+ssOguOJgp8QUqEcFwMbZlOn8BPR9giZ/zuBsaKqFzRbX1ok+capPS?=
 =?us-ascii?Q?v3kEjwS5kO/3gjObCPJmnDNShmTd7hiI2TCx8Gm618danQtBUQByY/dGEJaK?=
 =?us-ascii?Q?5s7exNLyDrvHmOf/UGPDlZQgDLpWM0HyEce1NLpXdx2rfS7V48f4Sel6mnJ1?=
 =?us-ascii?Q?9IpgkAYl1BJkSgt9GyV8i4oBLfnlCqpXTKbOZJP+PidtfCGFwpVJ8URRJm8e?=
 =?us-ascii?Q?twxTxxbtb1SlpSpxd8EuE8j7wivVIY2mjSBHs8SgLTh4SUVv3/pJk+8HOD+G?=
 =?us-ascii?Q?SV+7YBsQu7ehBMFJ+9A0+rdBt3kf+GnDI/oQ+adv7Bd9fzrH3wz+BV9crApA?=
 =?us-ascii?Q?jGT0w7CNn/J8xT3T5lY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5328.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087030e6-26ba-47a0-7972-08dc4443c8d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 16:28:30.2165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8RCjpoeTOuralstCo2piaPrvUoLj2IAn4zGtbf0A4XveIxOWRURvDt3xuQlSpln7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5716
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

Reviewed-by: Zhigang Luo <zhigang.luo@amd.com>

-----Original Message-----
From: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Sent: Tuesday, March 12, 2024 10:09 PM
To: Skvortsov, Victor <Victor.Skvortsov@amd.com>; Chai, Thomas <YiPeng.Chai=
@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Luo, Zhigang <Zhigang.Lu=
o@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: Skip virt_exchange_init on SDMA poison consump=
tion

From: Victor Skvortsov <Victor.Skvortsov@amd.com>

Host will initiate an FLR in SDMA poison consumption scenario.
Guest should wait for FLR message to re-init data exchange.

Signed-off-by: Victor Skvortsov <Victor.Skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.c
index 77f5b55decf9..a1bad772d932 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -444,7 +444,8 @@ static void xgpu_nv_ras_poison_handler(struct amdgpu_de=
vice *adev,
                amdgpu_virt_fini_data_exchange(adev);
                xgpu_nv_send_access_requests_with_param(adev,
                                        IDH_RAS_POISON, block, 0, 0);
-               amdgpu_virt_init_data_exchange(adev);
+               if (block !=3D AMDGPU_RAS_BLOCK__SDMA)
+                       amdgpu_virt_init_data_exchange(adev);
        }
 }

--
2.25.1

