Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBF8C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Oct 2022 01:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CD5810E16A;
	Wed, 12 Oct 2022 01:35:56 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EAA810E174
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Oct 2022 01:35:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvnf77hYzGdQ2S4HimE6RDKLhnKdtSZEHCuNkJAuLVk1CE4iHVJqUFkUiNEHhhI61a9yt3phRfCYDW3SNuC+iMJEGX3UD9qRZjp3XoVm748gr7qF0RV1IoMJS2EO2NSpq9mrEeyAdUVftzf27JeVKM3TuzZdJK83f9b/oEaCoiV/WxM70PV3o7HFoyVuETbifUbe1q0qtEz+/H9wylfdLdwKiKV94rBKRGZnaIq+1pforSdls5qXs4/8blSIm8Uz88JKH5zEnf3vqvnX2nq7gyhnizZHumeIHpTVCgPNR2acakRUhtva8tDjmo3EWRJChmhpBWMrbp4UzDs9darsnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VY6kcLMK0P3QRcRbi26eG69aLnRVuT8dmclbU+D7bRA=;
 b=Q1/Y1ChurymSkZ/aZU5pMJZGzi0JAwPjPQt50ZnI+l3ixTNiCVPqeqF/EbFAWTKP5mIAPZU3FCRT+2Db0DOx9/8vc4QreQwkhM/8/8VKGRm9oCfndUckQHNY1c881CFJFzJliLbxORy2u8L94jIjWmKx3pbXpPZKNTbwSR6EM2EbtcgY7nhJClZ9fwwmyuf+BBot987ZNdIgQCEBfGnOswGArVLxNePXciZqOn/UyzpNvZTsEOwGuaZ60/7njN9eGX4VGO/lUENFClPSZOF91dy2a4voFsK2zzXobTNyflv0UULTbeh5l87bUvTlULGDjCUnTAggHbmhUgIGbq2dUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VY6kcLMK0P3QRcRbi26eG69aLnRVuT8dmclbU+D7bRA=;
 b=KSFh1zl8Eo6fL9PovS5o/pW9c+nLoW6qv00Zxy3lm83R8OiJ+ptShO/I3/ruEapMEXg4RaEqHgMz7AjgzBWTAyAxXv3Dg2Uh7+Q1wtJWcFwC6yAE9hRgcVUbgPLfrAzdM0odS75+hmFOi/AGh5FBKmVZoD4JTs5ebDvP4jK8pgc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 01:35:51 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::877b:16ff:dd33:debe]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::877b:16ff:dd33:debe%7]) with mapi id 15.20.5709.018; Wed, 12 Oct 2022
 01:35:51 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/4] drm/amdgpu: convert vega20_ih.c to IP version checks
Thread-Topic: [PATCH 3/4] drm/amdgpu: convert vega20_ih.c to IP version checks
Thread-Index: AQHY3bP5oLosFo4Y4USGc3Vu5vm34K4J+mGw
Date: Wed, 12 Oct 2022 01:35:51 +0000
Message-ID: <BN9PR12MB52575EA0C7DC0778F7D22898FC229@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221011205606.2540082-1-alexander.deucher@amd.com>
 <20221011205606.2540082-3-alexander.deucher@amd.com>
In-Reply-To: <20221011205606.2540082-3-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH0PR12MB5629:EE_
x-ms-office365-filtering-correlation-id: 4cde6413-7aad-43f3-f953-08daabf218b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PwFbwVkamCeGQXp108Cm7CW4W5Ii3HPCMBBcf1Y9/m4qWRwu9lQf1lHuArQKK7k0qPLJOsTrX52lLcVdoMOao60jls7NVR5NJZDMMlAC/SzRaIOMcb6tgamYKJnQgQoIHuSAH0lxzM1BwoXBnhmw/hDFLUj8Vhi8x2mrLQMX7VbjLjQ4ix7px1VW/08s0PWR1XBkljERtVmklAoBDmyNHi21+SQGYyPreEVqcJrbDmcpF2aPnXI1n7EZR878ngyLbVbwkXZpUPvhNJzH5VU9GAoTKx7wyJ24DKbEeYO8N1UeMvgiojcUupxvwypD9/wvR9kVtiYNUusf0AK8Kc155Xf07MbK818qu2ZIzEULtsnMBWpf2jxhThh944Gjydl6aGP2mYrfaOTjNkz4zbNj8Cl3sKOgVyK1VYlec3gq+ChKoq3U5z9jBn5D7N7A/O8xzPVR2EYGaM2vB+2QEVKtT9ZjMi4WAhPwsg3reZmag4w9mYYzZh6GMjhEGrfhFjt1tLRkiMqqvAOu6QXIXpBP76X9cz+ggATGN5Ir7CgRrBoH1wR0cnweV2eGHKxyvGncLvDBH/UY52+U6cbjzsQ5mxs19Aza/Bz1yUQaNE5VSnisqozoVTnO7NlGhM8P9Yjati+x15gpw9rot5b6wgJ6MAtYBLdhVugm28cNk/4jVdM5w3Gsf10Rt1ZnifKam7UjAum2EUBCzk118CEzv80Ud32+Mz20DeD2UDV7j06GTdatN4r0bR9ZcyMJRF0CDnTN8zYHMPWtaF+Jah1S1wfH7g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(66556008)(76116006)(38100700002)(316002)(110136005)(33656002)(66946007)(66476007)(86362001)(52536014)(66446008)(2906002)(41300700001)(5660300002)(8676002)(64756008)(8936002)(4326008)(38070700005)(186003)(478600001)(6506007)(7696005)(55016003)(122000001)(71200400001)(9686003)(53546011)(83380400001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wx7g97RlAzEZQnzHcJ9dRAjiQjhx0Gkn2wqYAX+HCuhuc5TP5blljcYB5wrH?=
 =?us-ascii?Q?Ov1GpvzY9Bbh0iqs2ildnO4zuBasG3C50cRF9bOd74bdR8nL8p+FjLMt4G1i?=
 =?us-ascii?Q?LFwJkkX/kZ5CtRWmPyMovHiN3aW9N/wyxWlKTzaxRRhAG8bWabcj0x4JmlBg?=
 =?us-ascii?Q?Fc4J9d0uLXUuX6NoSPTrHprnY+Pzix8wdzrKp7jiROgO/0F2Wc9l9pO41lYc?=
 =?us-ascii?Q?llYTUEZAmK+ddDwyz2ZtEagHBTdeHaS80ZCfTwRVG+L6WcK5+WS9+y5pIENK?=
 =?us-ascii?Q?/w8t6IEORHYIZRTi902uAKoUp97IuMHhbn9Q0zjgylj+a6N3osTINDG2OAF2?=
 =?us-ascii?Q?AihAiHhUmAgnomYHAQmnpg7q6IrRrpsU5MMhWFXEAWamMjtUbQm/hG7SvZgo?=
 =?us-ascii?Q?tPwfhwsdsMtByefC2uM9HgOpnHXqTwVnzUDoOUsIr1vAQJJIbQ1dOqEtKo/s?=
 =?us-ascii?Q?R1A8wpPI/pKzMz0pXIUot+hvwbNkyDlfFvX/QSqLsehcPPodgts6/celFUI6?=
 =?us-ascii?Q?RuGSMPlRaE6X7BhARObRNPZUWH7eoR2DZaJH/mq7CrYltNaGqPtMfMIruvyK?=
 =?us-ascii?Q?UTSRaqVs8sOLh204VeB0G/dKLDF55Qh9CfPrFvz2l1sj+AAuT015yZjrUZIC?=
 =?us-ascii?Q?MBt74LMFgEzutdJj3i6OUPwMjh+42Okf3ZS3Gx6t4UmRhpBBCfIQoY0JdXwA?=
 =?us-ascii?Q?ZSEm2Hy4VBJG91ehj9FjXzf2ZpLs/HaYxSiR/Nd6H4nbSeOFpfIwqchfGCCI?=
 =?us-ascii?Q?/Xpfexztzf9btgZpKAbMTC8gfYqXdkVA8z1HyZWJgNsv8cpmkYLMcv91zQrx?=
 =?us-ascii?Q?4b3AolA+qg1IDAIE5sVUGCLD+nH1Wdd2H496Lu40EziJmwkYiY86qDmlsG7S?=
 =?us-ascii?Q?YzLnf8ntU74q71oMluI3icwCVqDVUJZ86NWJ6qLO6jFXDNLMgj0K07e3hng8?=
 =?us-ascii?Q?dL5ft+MXCtaFI123YJeWl+0V6CEVuC2JwvhMeeOtVZ391nPYEgPRkG3Zupvj?=
 =?us-ascii?Q?zc6AXKFr6iPfryMsOOYHtnmr7BQX4kD2Cj1M4vISHJFE7RmQtcR+K3KVQkvu?=
 =?us-ascii?Q?e06ZXDC+qw3uDBWnNzZky67+/Urhdlm8GRdfvIn4pmG5fdHKgrxSW450fCzB?=
 =?us-ascii?Q?6SVLu3qR9UIBkkUEJ4+48glgKULwoAkV8pHPTUjgo2QM6uwjZeVbiAiqFpwz?=
 =?us-ascii?Q?hnnFFwEDj7ZO+6w7FElejkI86RF9Z2ykR6fWnMYLX1fIrNlOTapurtaeU9JW?=
 =?us-ascii?Q?268XlteKGi0++sfCtspOEBsqFsPLXFFvWVQ/zKztwI6Ik45gP/XvPHO4uVJl?=
 =?us-ascii?Q?4Y7oedKJl6J5uKY6smRzL18OIOVxHQB2gtL+NjoqXx/8Qp8oPdtf0JAe5In8?=
 =?us-ascii?Q?Xq/NPhcV6ngsKLvI021M2zyC27GVfSkOXp/EVEu7Qhf663QyDNLaqsKMqdbD?=
 =?us-ascii?Q?8BE3eJuc6sgMcqTWOd9wvv3SpJ5/jwXVaIZ3hN2gFAqM6ro/wVQCvgaaIVHt?=
 =?us-ascii?Q?4LwBZq+c6rv+nKqum9Msno6UCK60L0okbRH9oNFVAmRKOKIUGWjF4GKBIfPh?=
 =?us-ascii?Q?R6Z0bRAcXYpNluekAPNPPHhEPwMZ7AJRA9SNFrfl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cde6413-7aad-43f3-f953-08daabf218b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 01:35:51.1073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 08P8YrptwGry+6oAVUdI3v3yLOyDz8Z8nvOozMckZ0iAyE8FA+FLPXZwjWRgf5vTG6nfp3Kb87ThJNl6e6rETA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, October 12, 2022 04:56
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: convert vega20_ih.c to IP version checks

For consistency with newer asics.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/vega20_ih.c
index 59dfca093155..1706081d054d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -267,7 +267,7 @@ static void vega20_ih_reroute_ih(struct amdgpu_device *=
adev)
 	/* vega20 ih reroute will go through psp this
 	 * function is used for newer asics starting arcturus
 	 */
-	if (adev->asic_type >=3D CHIP_ARCTURUS) {
+	if (adev->ip_versions[OSSSYS_HWIP][0] >=3D IP_VERSION(4, 2, 1)) {
 		/* Reroute to IH ring 1 for VMC */
 		WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_INDEX, 0x12);
 		tmp =3D RREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA); @@ -308,7 +308,7 =
@@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
=20
 	adev->nbio.funcs->ih_control(adev);
=20
-	if (adev->asic_type =3D=3D CHIP_ARCTURUS &&
+	if ((adev->ip_versions[OSSSYS_HWIP][0] =3D=3D IP_VERSION(4, 2, 1)) &&
 	    adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) {
 		ih_chicken =3D RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN);
 		if (adev->irq.ih.use_bus_addr) {
@@ -321,7 +321,7 @@ static int vega20_ih_irq_init(struct amdgpu_device *ade=
v)
 	/* psp firmware won't program IH_CHICKEN for aldebaran
 	 * driver needs to program it properly according to
 	 * MC_SPACE type in IH_RB_CNTL */
-	if (adev->asic_type =3D=3D CHIP_ALDEBARAN) {
+	if (adev->ip_versions[OSSSYS_HWIP][0] =3D=3D IP_VERSION(4, 4, 0)) {
 		ih_chicken =3D RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN_ALDEBARAN);
 		if (adev->irq.ih.use_bus_addr) {
 			ih_chicken =3D REG_SET_FIELD(ih_chicken, IH_CHICKEN,
--
2.37.3

