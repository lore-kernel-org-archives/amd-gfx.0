Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FD0C47258
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jan 2024 12:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11E6010E115;
	Wed, 17 Jan 2024 12:00:46 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8297C10E09D
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jan 2024 12:00:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hpv6OhXdlIp3rDADi7gYqLjr9id8fdMHXkdRH/1k32lKTGA1w9jAHACB0S9/MjlHCTHyU5A6vGacGxEO39PDJSZrSLZrZMqqpAMcNKY9XstpdB+yfZsjqnxw9OBKKQMlH/2+YS0JtzDm+TrSIxynfWSyV2LwwG56GByTMbHtcUBczekxG/K24zVUSHdjtq6KJfvzDXxSg8OjelHeU9njZCCm6+GH9u8Tg2yO4yJPCQ5fV5ahugPO5OuTggxP1ydppikrBy13Ln58LdTsf1+ILytDne3PB3Vf0pvNskS4r8+FB/8opK0jVxvuJ62JewbfnGxJCTfQQNI9BIVWD4P25A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqRyViMOv94dfb7I5TMVMk6Otw6/LeujB6u21ggcrpo=;
 b=cSkwxJ0oKkTZXswWB2DuJGR9cxofZ0VfVlkePA28Xd1FYqX7Ss1Ggh4Cgh2UxVkTm/FRaVFuPzfCr9/WrOz+bEYHK6yeBu8ERRAJjCZIvDvn13d1GTaLDU/oyPWTVC4wmQ01pSeRQOj10GLZkP1xi+fhb2xYup8n2/F5B7rZzX+4EbaPWlI2g+iUgXz89WnRNGI89w5HExRr4UdHJxgY7Nxihe4iXeBxVKLfkIfs+ofkNSX9qrFQCdO9fPEC/x3DIb5XqCniqMpn55GW98UUx79ULKYUfY6BMz7p/u6CN6riOH5VXtk+yt3Xc8a9qVpBrhkOlheWsHXRSQRxT3yEjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqRyViMOv94dfb7I5TMVMk6Otw6/LeujB6u21ggcrpo=;
 b=vfv+kro24wYdAf3F37zRbFMEm7SJGeKTj1T98R8xt+ZR2j1N9kNJwbh5ApmVmEmQPvftORLuwo3nX1JEAX6UU60GeHUw7ZxZikkSJpuKj3BXg9GdSK0ZdypEE/WxUHrQr0Mtfo4QdOAM0y78rr2PSbTs+LLYtuJu3rRQFnLmNU8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW4PR12MB7336.namprd12.prod.outlook.com (2603:10b6:303:21a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Wed, 17 Jan
 2024 12:00:27 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81%3]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 12:00:27 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] update error condition check for
 umc_v12_0_query_error_address
Thread-Topic: [PATCH 1/2] update error condition check for
 umc_v12_0_query_error_address
Thread-Index: AQHaSSWnRhzaAIF41EGZRF1LlO3lXbDd5yWw
Date: Wed, 17 Jan 2024 12:00:27 +0000
Message-ID: <BN9PR12MB5257DBA2C5C732A1CD2EED17FC722@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240117091430.29140-1-tao.zhou1@amd.com>
In-Reply-To: <20240117091430.29140-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=12feefed-69d2-411f-bbc7-9cfa55f5d81a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-17T12:00:09Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW4PR12MB7336:EE_
x-ms-office365-filtering-correlation-id: c3a29054-bf9e-480e-c8c7-08dc1753e543
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GKtaesIszFTx6XYdwnUhAYp7m0lNUsqV0ot9Y+U2MLxkXckHxkwvkiWBUk0pYjh5xAwbs5avYvPy9DoysLegRiIT5mJua+R6iQIYZJC7+8zkn12OBNvfcShXJQuCNzX/o/0XbyfMYfAErvsVJ8zMa2nSCzmRQvM/SYTQiEP0Ejc+d5vDAigkJJTWtAYND2giUnNXL1lkFyTgf/V2G+e0+DNHI30VASDIWRSsP8UBhh/W3KCO90l05hr7WHcrFrRM9FNQIb2hJI1QZpSpqu0hrWnQbhaDynAKl1RZZ7d1NZW32V2Vgd7C0BxgW3LjkWbkhqBZ4umbBfaAClS0kO4mbQkU5Elncnaa7JYur895X2F4TR707tNBjT5nmAfVTc9Wx7g0zJCy1ALdROIeuSGxOZGeABhtwkuu8MY3IqMx11z3LLSA3+6TVWNQK2dmEUnKdJ7s5Drv4hIPbT4BBgMPdWVOd3HdZeruL0SpRJ7TH4Ip+UDIaFAsz4uhltvBy3wobG932zKEiCWPfAR3CRrIzSVT5FVnY3HAofyw1EB8Wk4gvBv+XDS2JwbpQLXPM+R0kTZnr6YfZpBEO/9p4bT9/R5KeRC00aI03w3jwZr38aVhvvXU4BA47mJQ5MG7jWIh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(366004)(376002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6506007)(83380400001)(26005)(53546011)(9686003)(7696005)(5660300002)(52536014)(15650500001)(4326008)(71200400001)(66946007)(110136005)(122000001)(316002)(478600001)(8936002)(41300700001)(2906002)(76116006)(8676002)(66446008)(66476007)(66556008)(64756008)(33656002)(86362001)(38100700002)(38070700009)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XVsFlHU6eJp27dEkQWmIze4IImAtTfw/Ff/xJ20Hzg12AEi0+9TCnBNycq00?=
 =?us-ascii?Q?4j79+/MGXxTsPqc8HnSz1glUoJvE5zl5tAt98ENEjuICNJQUXMMKP593tX7z?=
 =?us-ascii?Q?PQRdENIijyVd8uGAdZeQFU2XAxKb47JSosa3ojo8NC2fWA+e7VROhyWXOwYg?=
 =?us-ascii?Q?fCPA8CuqX5JcZoy0yOIGr4qvYAF2zW1BXLdMvU+UcdzqgwNJxvHlvCJMTlIT?=
 =?us-ascii?Q?Hx7Ih9BOprtQ3dExbgHa6xpKcsaVT/BKJPDIPYP12WBfnpAxYdTkakqGlVYa?=
 =?us-ascii?Q?efa2VsUSrx9/Pz5WKpdAgEdmEKBh5T79oxsRJSAJpwUQNLOqL/vNjbI/EXXQ?=
 =?us-ascii?Q?Ks2mxe3jIsVEwdh6vCTWtNv9WrnYF8SrRzdtQmxxU6byPIIg1EGGpp2rH/Qp?=
 =?us-ascii?Q?m7BEhtd1/DUtTJ6c+iuPkataVCU2LcrefySfXo64MDZruKEcXYcmvHovZ/8C?=
 =?us-ascii?Q?pFfc2Lunw7iOvZeTG4C7tlbV9ww+6rjP+KgsV3dCvdptHKMEEshP/r1E3BHW?=
 =?us-ascii?Q?/1yGwKWP9wrfC0REk1vfxkslu24Re5gzY6VGfrcwmemfxRUAJnUIawp9R4zL?=
 =?us-ascii?Q?bNjmS9P39nfpymCfpQT8q0G2tySMqrM8jvFagiXU8yrRFX2vj8rskd44ucL+?=
 =?us-ascii?Q?8Jw4ECXsIgFTH37IrAKbRtQkanrhIf0WXWdywrdOXngkMIMmfjqxXBuJbO1P?=
 =?us-ascii?Q?ewTQntb0PuWjr9PJjn9HsyHToSYSCpcO/OJr+a8BoiKBpuRVChbjLCAITk+q?=
 =?us-ascii?Q?WpBg98Cv+ym4naYv7JEDKdZ5WR+C/f0765LutNpLpd2y5q0BS8Qpn/L1kW0v?=
 =?us-ascii?Q?HIumPfBxzT6ZsRPxxXg/6H451mWMHV2pqEV6aYcrFu1wpvFnrEt8v/AEsov8?=
 =?us-ascii?Q?P8CFaj3RBTVrHmCQ2sNX7VovZxGxLSKqlCOv5Hi7EOab5w3n5ghxc3XRCOk6?=
 =?us-ascii?Q?jY8vI6PYJ/rpZn++NHUC0XRY141CVNFgN0LRUieP/Dm2JLOmb2hNwoeEmSne?=
 =?us-ascii?Q?OivzVFh0v6tWsJhKWx3Px5f8iCMCU1lOhLXOdNj9uQlLfbKzNzbMRIVcaK4n?=
 =?us-ascii?Q?gdWrKNpCoLyJDVAfVXuz6RYfhm3iOYWEfS7Dzxh8oZhDqQ9Z8/73pi6FXHcD?=
 =?us-ascii?Q?hH4GRrSyT4paAghZfE/4E1kkKO6YJ6W75iFjnq3Y2mZXR0dDwWxsaLRZ4/g8?=
 =?us-ascii?Q?1IM1Qq5Vg9TOagVlTNhzENWWmknPvCHGGNL/hPb4ne3FiVmC8tXxJyZjvi+x?=
 =?us-ascii?Q?qAu1X2IV3kHa+2FKomTTOXRI3erQX5CB8fr8T13OuT8iHw3PbERWQfXpVT2S?=
 =?us-ascii?Q?BwL9HlVBgXHzLuFxgCP7bywhgZlHMvyGD9Sr4uwv/wItFM4qEIZsTSgZtfbH?=
 =?us-ascii?Q?K3HQp7k0zeYLi57Juua0cjDho/xhYBseFJI3JcnQaOIJFo8uT5bP6N7ew32H?=
 =?us-ascii?Q?ALTO21EwP9N8ulLE/+XBdSoojpWoSrxRKugmwfMX2zpj6iEG/pMwlO9LR57o?=
 =?us-ascii?Q?mO4NC6hkl/cPN9s2h+pySBBhVrLPG6qxhwDJ7A3SUsXq9r3W6wnFRuNqj9Ur?=
 =?us-ascii?Q?vevkt6BHZdC1IZGWs4XowP2UwduPP+c1n+EQM307?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a29054-bf9e-480e-c8c7-08dc1753e543
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 12:00:27.5503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UYFlKNpwdFb1/tQ1v3Xjen9VBsqbdj0/v7phNFNb+zFL6cipGppyYyiLz3k3hmabiDKYq6pC3a6IkSRJm7C43A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7336
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Wednesday, January 17, 2024 17:14
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 1/2] update error condition check for umc_v12_0_query_error=
_address

Deferred error is also taken into account.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 10edf818acf5..2e0bd4312f2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -337,10 +337,7 @@ static int umc_v12_0_query_error_address(struct amdgpu=
_device *adev,
        }

        /* calculate error address if ue error is detected */
-       if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) =
=3D=3D 1 &&
-           REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, AddrV=
) =3D=3D 1 &&
-           REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) =
=3D=3D 1) {
-
+       if (umc_v12_0_is_uncorrectable_error(adev, mc_umc_status)) {
                mc_umc_addrt0 =3D
                        SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_ADDR=
T0);

--
2.35.1

