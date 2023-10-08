Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF854E95A67
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Oct 2023 13:35:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D55510E107;
	Sun,  8 Oct 2023 13:35:43 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60BFD10E107
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Oct 2023 13:35:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMaPGXxT8yLlQ5fLGvNsks0W34GjeIQpCIilqBhqEhhK8JuSXDdRj1zDfnqEq0/IUu/5H3sz2ncJ2AGNdC+GHXBwPX/WiK7ClRb5Vhpast7WbIbzI2wofWSnDAhLLqG37Z22kuAmN9aqckseltAvKRBt+7ZZX4lhzp/tQr0AQzkZ3y50UuII87SmwCeeYNJFmTVUEKdzRsA11tliR+RAl7s/TxAVG3dLKRwHA/I7H54WUvPMMWuVGDdkroIr2bjj+pg4/FSzr59UWXxToPZ6KH1bJ1pyzCXu8gKL9Z9Sx21xKKdBJyYMT7bJS51J2zNcYTTptOVDpcZojO0hvKja9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wsen2ovmgIZtM1S57Ryr5roioDoD3xG5mpIqVHQMRV8=;
 b=htbczhcmymL6oPZtBbEONaZ9Ba81GGcBCqvvq5htJnyQY8C3eA5Pt6W5pHqNPfPsBI6/oIEbex7kQ0ab0RClgf0BNdImtMo3QMUVLyLEgqOmecpeaM7bmjWTx9dbLlRL0/pUxVH7gBsI50Vb/8KiMJ3R3bi9bHgj+lzDR9DBpmXU19NOO3lT0bojYdI4W01qgLLHLZxyQmZTX8S0YY3kQBBXdSfFVs9t9bYDsmpQNtOsTIp1eyyylBokyzF2ViI3WKb7m+1br1uB4rZX5aJnVw8aVbFydCMD+vwVDXQ0nAT4ZqO8p+Q090GdZ7kHOMgx2C3TYOgHdjTgODXdXJw3YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wsen2ovmgIZtM1S57Ryr5roioDoD3xG5mpIqVHQMRV8=;
 b=WS6KeS3KhSFOjnmFVyyfYYLSG2r3wfsd0V3ubWmhTxLJOIH3QEkGDJmevjc4RzGpECKJVM8lHNbRFreVdw/mXszvd8wff0BP6B332tZt9sLBYS31EzHmfGPw20yDtnhM4tyvrszdG/5zhzGctxiS+F1DgrEEoAMa3CCbY9V1nrw=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by BL1PR12MB5109.namprd12.prod.outlook.com (2603:10b6:208:309::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Sun, 8 Oct
 2023 13:35:35 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a%7]) with mapi id 15.20.6838.040; Sun, 8 Oct 2023
 13:35:35 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
Thread-Topic: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
Thread-Index: AQHZ+c8tCruiUI8Uz0Se1YKWw4O3urA/311A
Date: Sun, 8 Oct 2023 13:35:35 +0000
Message-ID: <PH7PR12MB59972CEAF0241F48E6B342CE82CFA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231008100642.1915677-1-Feifei.Xu@amd.com>
In-Reply-To: <20231008100642.1915677-1-Feifei.Xu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|BL1PR12MB5109:EE_
x-ms-office365-filtering-correlation-id: ebb74b30-72ec-42bb-1eb6-08dbc8037389
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YJpidCHxHLG7PMQRfiBRhhu5vULSbKl++h+RzsrC1NQ7F/4g5h0a9mHgWcHfhkQILJju3nCD8BGUlN8Cco7G7UO9H17Bg1ue6l673nLtYddXmBjjaojkL7J8m2BmH+v75Xn6QLV3xw8F2AYl1F5zrmcJMee/+/kdqjQwTC+tyvOlXdKqaXeMJn2pNQX+KR9mW86+0xmYG0a8biL10ooFxyNtq1zhrUv/fEW72CWHXx+3OLMbgWOwPNZMZMOqc34AbO1oZWb39qBMM82c8PvAbLXYc2gQBQEYElpF6ZSA/N7zlUyAyqxCteqroXCnrx17XM/SndbjRiCDu43J6Lb60vNKViX0FQ/HvymmwuUzULnrgdfHVyQgP23lah+LtMEQHH4U+PhiNa5sz4BSwfF6ZRy7QuGsaRQWl8i2ZDRJPRVcdlUbO2GSDBQZgBDcGns/GF01607OuSY/BnCJUVJrGQdPZIL5m13sf1WQNGavdBGECGlWLLjgLds7Q5Fgz/VPCxSgdC1fGWRe0oPWkmLvXetPb7O0wfECSvnKGCxSQqKCF25He74T5kVZZ4VGm1ate3AGKib1oqwIh910MwfPAKlCf9ebw6mFFHHQAGFsFnxJ8pg0DvqAZItH3ux8SbFN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2906002)(7696005)(6506007)(9686003)(53546011)(122000001)(33656002)(86362001)(38100700002)(38070700005)(55016003)(26005)(83380400001)(5660300002)(4326008)(8936002)(8676002)(52536014)(478600001)(316002)(41300700001)(110136005)(66556008)(66476007)(66946007)(66446008)(54906003)(64756008)(76116006)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xSV27vLoKUzDBmDlCDUvFE9sz+pCa4/sWGonZLuZ+khqr8x5a9QbFmR+HwLU?=
 =?us-ascii?Q?ybtb3PWEAl1p4PqMf38w7D56RelD9beWE6mgTS7844LPETkX/SqsEuKO9u+s?=
 =?us-ascii?Q?K6KxXaYkhq5SpHSidq80kAY1xiGAP8v8MjkQxSSN0le6+H3Vpm5zCJs2lupb?=
 =?us-ascii?Q?ut7UyvQH1P4D80V8LQcXCZTDvC/QOP8BpqQptQCs/rKszBG7bwaJ6pNR1EuZ?=
 =?us-ascii?Q?bnGWyU0RUXZ/AjbT2L7NeUXfec4U4nPgO3e+2FMZCucdICcKlNAqp2Esy07g?=
 =?us-ascii?Q?5z+GAXZCizuIQZxY/DALMlfT9bzm2rgPv/rIxC9no4NkquZ6Y93Tze7CJKzn?=
 =?us-ascii?Q?H+tmfqR0bRo7bemIW3Eu+6O4ABCmejB5p4AMhVGGymAQFSuRIfCWvkPyL95J?=
 =?us-ascii?Q?1foeV74CbzOWovevwm4qlnVEXSN/FccQlqGbFezcIsI4IUhvV72m9iGpUnYh?=
 =?us-ascii?Q?BTvlgqFd67AcKJZmO/Y16jzRkatc2w3bcrB1GCg3oiBt7htdglW1hkX1lJxq?=
 =?us-ascii?Q?sqXLC1w503sNjaKZ4QqKz/7V54533t90emVrFMPL9skqDMOvxs7SaD9PwfCj?=
 =?us-ascii?Q?rQOKuEIOXSGUlZNXFsAVcQx3jO97f36kh4nOPHvb03XyE7J1jpwq5vw63MhK?=
 =?us-ascii?Q?Qhzyxx2TRrMgfXbvul9PRTMf6kTvQh6ciZYVHUVrROPIbAhTDVW0Ta7aoC44?=
 =?us-ascii?Q?N1RB+ytyuR2fZo93gitv4lkjukyEhOrrkSYv8nCeAMld9T5SR/gAuDEBEOf/?=
 =?us-ascii?Q?68bWRT60vmk5nraFfpCvxLzYKhyoWrmF2HWBl4LTu28PObj7WZtghALVFd1Y?=
 =?us-ascii?Q?HZL625+tE6NiBXK5nB4a6Qtj5QfWo8YgjsT7tIWRhzkS4hjcXVI6aIiEN2ek?=
 =?us-ascii?Q?ccOTmZdWiqxPCayWAi7/qK7r7U7u9AWxq2r3A/C829TCDkm88j9vmWGS54S5?=
 =?us-ascii?Q?GJtcaxTFr8RoMDWnkonjS64uT2Z1ny/gHLDLoO/kAM3Dc6tf4uUDYaU0E1ba?=
 =?us-ascii?Q?fdEepBaOrFZHwJQhs2ERA8V21lEMYZCa4zwdLq8Ah8Lr9GE1+WI+S+qeOmDo?=
 =?us-ascii?Q?/tcKTO43HOa6T7BqTQWTGQpJeWl4av5iv+Thz6USa7fKVFeRa4r/kVetl6/W?=
 =?us-ascii?Q?T0nhmfvT8kFGfM7/xHhSl5hkcu5UBBekJldkgrhXAv6Q4bF37z2NSt5mPCRi?=
 =?us-ascii?Q?1/W9G4r5lUecSv9E4q9Mb5KzJaxJ497P1AAhtW0Y/0xEAhNsfx7bnoGHPPIz?=
 =?us-ascii?Q?rIFzMBBH4rUnXDhU/3POCw7kk+cropeuUokspz+KsPeG2VhbFfZFiuBENHrH?=
 =?us-ascii?Q?zZlnJF7pdzoqsU+QTz+xAJ0V9xeJiFqsSWxkTtLMeefdZjPSb74Uk5MFeYze?=
 =?us-ascii?Q?OAKkwmOOQEj6KpgehST8nPrLl6HbnYmxUPI7QCrLWFblS2ftBoEA53PYpM1X?=
 =?us-ascii?Q?OEjH9AELMOEP8U2QETtvaxfGv429sxoZirDU3EyXyXeQjuWgKa9JIrmViT4i?=
 =?us-ascii?Q?AmZEnt22UYnCl6Zr4d5jD1uzZy0Fu+dH4YbVTac7Y7sHMqUCULBYs8N5kcmJ?=
 =?us-ascii?Q?Y6QOcfzphV/UfCYdnts=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb74b30-72ec-42bb-1eb6-08dbc8037389
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2023 13:35:35.1596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TVfB4t8jY130KFk+GSy7fFXkx9JsEUeTmHSMIKN4AKaMp4vtZ32IkMMzv01yUlkb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5109
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Feifei X=
u
Sent: Sunday, October 8, 2023 6:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Koenig,=
 Christian <Christian.Koenig@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.co=
m>
Subject: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb

To fix the gpu recovery failed on GFX11 with gfxhub pagefault, flush gpu tl=
b after reset on GFX11.
Gfxhub tlb flush need check if adev->gfx.is_poweron set.

Fixes: d0c860f33553 ("drm/amdgpu: rework lock handling for flush_tlb v2")

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.c
index 2f9bb86edd71..048d32edee88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -611,8 +611,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *ade=
v, uint32_t vmid,
 		/*
 		 * A GPU reset should flush all TLBs anyway, so no need to do
 		 * this while one is ongoing.
+		 * For GFX11, gfxhub flush check if adev->gfx.is_poweron is set.
 		 */
-		if (!down_read_trylock(&adev->reset_domain->sem))
+		if (!down_read_trylock(&adev->reset_domain->sem) &&=20
+!adev->gfx.is_poweron)
 			return;

[Kevin]:
Based on your description, the above code should use "||" instead of "&&",
And after merging code into one line may result in the lock not being relea=
sed if the lock can be acquired success.

Best Regards,
Kevin
=20
 		if (adev->gmc.flush_tlb_needs_extra_type_2)
--
2.34.1

