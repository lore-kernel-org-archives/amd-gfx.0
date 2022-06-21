Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB0AC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jun 2022 02:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A21B1121E4;
	Tue, 21 Jun 2022 02:01:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A44E01121E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jun 2022 02:01:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gc4Zlo07s2fi/zDEEFxPajOHceoRR3EorBZucIa4f6dSgxjbHKN+S6LrW2fnMEnw9IR/ZqlTBkAt2AtOJQ2RX9Vm10lDfl11iPfo5Ik7eBJDIu7G+dDujabzE7xBeBOL33ndH2I5zdbvkfkBPf71QMaIC1E/y6RVpyrG3B2CHhqTeEhqMKv2oCiAD+MB9jJxi/Dv9NDP6qrTpunGGlXNrEodb+EVVvkMrBQZBpjlJaeY32p/YcKCjZ59riK20oEWvBSZkjVoMz8YAvUK5owcCoXA2N6AdoLLhWDloXTiRReOnln9DS9bjMKbxK+/x3qVg4Cq1A+MP4VWlPQfVZX+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5p7lIUo7JUJhQGRDYcSpYdCXXQwfDVZkuXsmMGDPN/w=;
 b=Loj0vwe5TVAu+xF12oTBSXJMqQKGdWvI44pDQOOnGSh2ez5giyBzJVBQTi8zKB0xAkeGO/SXbtxxw9sXvlSFJwsFB0cWSLI+w+p+T3plHu2W6P4C1U1BitE+uQustVd3CruXozBoy5Fa95ZkzEXRZxe7L3eXsCXhJZ8Jk7D2PehsDEP4+9Em3fNCevlH9qkdB+gwJh6gMcZiLcHvj34oKl5gxxq3+xsi5PRvYnq5giaxfslNS77zDrI/AV4xVjic7i+F/+k3Itx4MIC6pTNNRj2ZkZxabN1dEAU80tEOw+rAwPxkKSckHfLPclgFdC63EXOne+g8//bl5AcVz1ZxzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5p7lIUo7JUJhQGRDYcSpYdCXXQwfDVZkuXsmMGDPN/w=;
 b=pJ06YSUjcjfdi/paeSDKueKs0HJJXJOZdFg1kIull7InmveogCJHC153e6jk1dkuh9JBNPiL6sv/XuM+VsiJYCIWuaL1g3GZW1VjBuprLTO7gHaM3c6DylWxjhIKlt+NGfN+A5aV8y9mXx5j323USu+Fl03byf+d3XheJ2wqvUk=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by BL1PR12MB5379.namprd12.prod.outlook.com (2603:10b6:208:317::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 02:01:10 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::c78:3525:6eff:5e62]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::c78:3525:6eff:5e62%4]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 02:01:07 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: correct sdma queue number of sdma 6.0.1
Thread-Topic: [PATCH] drm/amdkfd: correct sdma queue number of sdma 6.0.1
Thread-Index: AQHYhIJ2voiv7v5dY0eEaGNKRgQgUa1ZHAuQ
Date: Tue, 21 Jun 2022 02:01:07 +0000
Message-ID: <BY5PR12MB38735D1C57EBE8C31D2566D3F6B39@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20220620084156.2295093-1-yifan1.zhang@amd.com>
In-Reply-To: <20220620084156.2295093-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c2913dc9-5beb-4ba3-a592-cb245a287d85;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-21T01:59:24Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 171e65c3-30ee-43c1-fbd4-08da5329e7d8
x-ms-traffictypediagnostic: BL1PR12MB5379:EE_
x-microsoft-antispam-prvs: <BL1PR12MB53799729099BE66E3E0260B3F6B39@BL1PR12MB5379.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WgeAhosuDI6U3yjBm9aEEJKQqdcs9nm2NG97kJaV/O9pCQMqKaE5bpjPDRMAcTqsHa0W/F0JDnKfcvV2+J6xswL4wPv5T8IBYGOouMeHvQTP3fekEtocgDLncYv7rVfeZ5mqngovyjJ8HjQBXPg21Ksl8KceStQTYgxkOtH61YDEnJVZv176NQ29oYUS0Z6OusvclLZ+H+GgHfgl+4y1wdUw+2vdH6V0+T6R31C1H5+q7Rd8X6G1aqIplIHeRdulu6Gr/o5dVTHLdYe6uaJLLJjOS0k+RjXScevSEwb/qz0g8zPZ/TLSTj2oFTIq/0yRnRDv308CxUGndzHUQakKr4oHb6z+mR2eqrrCLEOfZi7DTopXHNepedfEkd7ybxpSPMGAZFYMHOqcZollbyWKZem6I9IbO9TZTmiabUQyP4F2y6Z9+7yUQWukW7+YjgzluDoj3zLvr1hptPF6wGWB65No2qlclkj5cM/z3/wbql+HtyAExNRZBpFQY0rQeykvNyxkQjRo2SYLenUUsES15rebd+rGrIDN9oROY4FnQt87/qFZVoSogAWM+6SQzFYIa/Yb+5KUnzOIaAF3hxj1tKeMlGhlqO0GDG0QDnzrDO/KvAaRTNhk7PJjhGgzNvqQzOcLCyguopA4wbh26aQdX5c0LNqVxzW3/43Em6tKCXKP7KJnY6gLmf49+ayNQmIH8C0vKgnoYjOIkrqK4+IkaA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(55016003)(33656002)(71200400001)(478600001)(5660300002)(8936002)(122000001)(41300700001)(52536014)(316002)(53546011)(83380400001)(7696005)(54906003)(76116006)(38070700005)(26005)(6506007)(186003)(66556008)(9686003)(8676002)(66476007)(66446008)(110136005)(64756008)(2906002)(66946007)(38100700002)(4326008)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SEhIeoM2tMJN7YFD/JnWrBaru5mnnkpiQ5fG8T8DExfSMjri3UdNQ9m3f/Wv?=
 =?us-ascii?Q?cDipiWT7hPr2G+tqTV/QZMKLs5+xD7nRfdXQ/W2CoD+toFbK2gpys0ehfFfm?=
 =?us-ascii?Q?Ca8b6OoGJN4mTuGOkfk0Qb5QKkbzyOymdqsM+iB2yVhJbDeC151X9AI5b0jL?=
 =?us-ascii?Q?H7dkca1aOIV009e+D+ujcPn9lasTzDw2fjqiLiyY49rNUnrLWHzroYKctlnB?=
 =?us-ascii?Q?9WuaPAYrph2CQkH+rrYNDllbQaX0u/1JNg5L0Ef/kD2E8qKcRaJoigx8pT/z?=
 =?us-ascii?Q?bYWSMlMcqQLBr462mViubAMpFXymbOf6zoLCppVKovb8b/qJ/olecPde66qz?=
 =?us-ascii?Q?5dKQOGvvftStl2ubD0Shea3tpDTBTEIfZC0F7v698zOjpw4gzY5oosfoFMt/?=
 =?us-ascii?Q?wx3OCW6pV7Rt1ikVlojaaSk1zOgTYm6Ubr0CQ2J0L4EJqbBPvIsVWEUeD3Qk?=
 =?us-ascii?Q?5gaoH9PG/HTpJ7edTI2NrlppwfAHDBCsPlKqH3EbD7+BEi0jYpz/aymve2Po?=
 =?us-ascii?Q?UhM+T01sjzx0x3oSXH4nnNWxae2RIy0zmDhRojzTzmhdrNC9qD7H5uzMgkxK?=
 =?us-ascii?Q?JAn5dptukYSvpX5v8mTzMWURbAJvb6NUVGgFPiqi+FoVKPKZIb1RUZXJy2eN?=
 =?us-ascii?Q?Pf+kBee7tdfd1wWJbAk/nrWG/Rx+LfunOAc90OAXn46jYd5ZK8XSnCA1oOmc?=
 =?us-ascii?Q?wFk3mwkhAzI3WDcGD+9HEcexrHl7jbaGdHq65R24K07HutDNq6bNZe9eGd0P?=
 =?us-ascii?Q?T7SnMmuWLJdOW8joqphLE3naMPhHmyaW0PiSzK0wWbZvcbXXfqqmABuJKq80?=
 =?us-ascii?Q?X2tC2EK8CcqlSADqCqoYdUAOc1AUe8CAtZtgowITdvls1q63DQ1rroeOQx5v?=
 =?us-ascii?Q?RNwBVRchm12yXYNa4kRWM3P55sURQYwtZvw8tIVRbqDVkgRdVtMrANAZdART?=
 =?us-ascii?Q?V8notFtw2EIhzHlBTtUKkOrKrhX2KtXG2QatD4T25bKW8cLrWEDMWdFD8tFD?=
 =?us-ascii?Q?cgGlmzHVE1haI2TVeVUx/T7F0gDmsSrckcJLqs/PPNvYGGbKfRIN/nuk1zFx?=
 =?us-ascii?Q?v99pJkQ5YSmCHymdEw4Oi0wy8/WB76pVyTfuOPBtn6ZWyHIQxyN/mWfTF8/I?=
 =?us-ascii?Q?A58ytw8WhBFWb2A11y3Geev/5QlzCBhIz2FftZgSGuW66wRV3/4V3iscjtzJ?=
 =?us-ascii?Q?GuLMOAnIpuNPnFn45TI/LGs5kBh3b1PTo/f1DYgubu8UYGf3dXRI3QYTGxWa?=
 =?us-ascii?Q?ORA0/TVGHQ9ZBZhy9ThRQicP1sQ4hZSVH4AOwV6R/FPZQdqexeS4xrRztteX?=
 =?us-ascii?Q?yQ/CF0TfZYHrtzCWjck0w8Xfpjz0F9KVmeTFbcGdr9uROS2nw8HsK68yn20X?=
 =?us-ascii?Q?05itu6fzcb/bMV1GNPRg9szFkVfFBw645aXE2ctU6YEQ4hMJ0WNeCsD8LWWc?=
 =?us-ascii?Q?j8YOnFTxGi2JCEJDxsEm9IypIqABQHFY00/aI2oy5KC/hqjlEdGRe2tWErPN?=
 =?us-ascii?Q?GKu0LCIenrFXNiscH5DQNasjW2WcTuYzJakPcRgq+oH/aw2RoaSh7t7x5StG?=
 =?us-ascii?Q?2yJa0WguV2UuqGFcp0i39dnewqMzU5ZYMmgGAryoSCoK/GFDlI5YsaCuJtON?=
 =?us-ascii?Q?tZehkvH0wlWX+VoNTPLk2vDP7P5xLE98vfctNX3ql4tSdSdyOU9Oxs7Sy9Ta?=
 =?us-ascii?Q?P3vj/SZ8vo6WvyShokH4Gz5fMu6izU2kTMzpG1XyR1Pv+yswOZNv1evX0Nwg?=
 =?us-ascii?Q?G7o7C71n9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171e65c3-30ee-43c1-fbd4-08da5329e7d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 02:01:07.4399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qU/o1m57zLPPNs3hkYa+Hw7Yj6tyTUI7bhG9DxVjnGSw2J8hDjIiAcvhNi+leRmRUDxm2caBJRt3xEIacIyl4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5379
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Tim Huang <Tim.Huang@amd.com>

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Monday, June 20, 2022 4:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, Ray <Ray.Huang@amd.com>; Deucher, Alexander <Alexander.Deucher@a=
md.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com=
>
Subject: [PATCH] drm/amdkfd: correct sdma queue number of sdma 6.0.1

sdma 6.0.1 has 8 queues instead of 2.

Fixes: 2f68559102cb (drm/amdkfd: add GC 11.0.1 KFD support)
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index bf4200457772..c8fee0dbfdcb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -75,7 +75,6 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev =
*kfd)
        case IP_VERSION(5, 2, 3):/* YELLOW_CARP */
        case IP_VERSION(5, 2, 6):/* GC 10.3.6 */
        case IP_VERSION(5, 2, 7):/* GC 10.3.7 */
-       case IP_VERSION(6, 0, 1):
                kfd->device_info.num_sdma_queues_per_engine =3D 2;
                break;
        case IP_VERSION(4, 2, 0):/* VEGA20 */
@@ -90,6 +89,7 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev =
*kfd)
        case IP_VERSION(5, 2, 4):/* DIMGREY_CAVEFISH */
        case IP_VERSION(5, 2, 5):/* BEIGE_GOBY */
        case IP_VERSION(6, 0, 0):
+       case IP_VERSION(6, 0, 1):
        case IP_VERSION(6, 0, 2):
                kfd->device_info.num_sdma_queues_per_engine =3D 8;
                break;
--
2.35.1

