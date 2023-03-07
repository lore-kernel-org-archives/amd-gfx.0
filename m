Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A841AC61DA4
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Mar 2023 03:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3C5010E064;
	Tue,  7 Mar 2023 03:39:46 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 469D810E064
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Mar 2023 03:39:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqIuJoAHm5o5mnrFpX44twKJABOA39y9iQVJyey+TuFMtZes2jyVeMlmZ8b+rqR/nHWV2cpl3nZ0w5L246i3Nbb6YyEMtP2ugDyW1h6Mwc7pfosuFzbI7UmbU0u86tIz4UJtW8syehiwWdtWi5qDpY+3vGAPrrVNGDd0A+FLVtL4JAY7x+lTMbsBtWgztOSp/PZGcqdCMzsAVCRbPsdn39KI2sW5vwDfotMgee9mqvWqukp9aRqoi21nWxG6torOBf8PtFzIiDtLwh+sE0K0wi/8fb+ebIfoTvRFAAvYYZovoskKjhpVSKWfcNo++IJbduCObAHeMO/RL70Ia4c8Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJ37XvWdOE10KJDhTrbiYE7td73NDRkucs9GuncCdXE=;
 b=jwfDtm1wwGK+tC5uundDzd8gayyWcqwZqTotiyQLJQ8wYUMMEzn8FfOsnEAPwv2Yijx46tZQEzNFCI22tof5PABTmvD8z0Q8rs/vzDDK82FyGtDb5hxUD3rP909CZCIDW3UMSeao5UOBRV4wifJFCkXmzEvLNe9RvX/66x+BrcDpGEOoHjNHwqhM1T2l+3LV+4GmSdsT2JXQDdc3nBwa57zJ/hUxDDqgVTd9JdavdB/Dn0BSJmazzi0fHFCCe8nAnZLB3MH/FHXd03+igBawlBsjAWc4bBqi3zrx0Jw6OK4EgM96YtlrnEk5CT75GUwtzbYdvF2beQqMOC393VWPOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJ37XvWdOE10KJDhTrbiYE7td73NDRkucs9GuncCdXE=;
 b=eYDQf7v/8EPdwscr0EYLnkid2/QDAY4fWbeP/2xqNOx0V8aKPf8GqSTys2o1jmBt+k43K4/kVQvAyKxDsz4v9H9EVXhkg8CjOqSSItnfy2c7FuUSQEOh/5D9FmCDVbyseibWt3f4xk03xD+3c6J2tjRnpMaWBR3YtMSE+qGh1u8=
Received: from BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21)
 by CH0PR12MB8463.namprd12.prod.outlook.com (2603:10b6:610:187::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 03:39:41 +0000
Received: from BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::436d:e6af:fd2e:2253]) by BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::436d:e6af:fd2e:2253%5]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 03:39:41 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix error checking in
 amdgpu_read_mm_registers for soc21
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix error checking in
 amdgpu_read_mm_registers for soc21
Thread-Index: AQHZUEPmi8dKVc9ibkGxlsTA0ZVYIq7uq2rQ
Date: Tue, 7 Mar 2023 03:39:41 +0000
Message-ID: <BL1PR12MB525455644C669C2A65EDE878FCB79@BL1PR12MB5254.namprd12.prod.outlook.com>
References: <20230306155348.41081-1-alexander.deucher@amd.com>
 <20230306155348.41081-2-alexander.deucher@amd.com>
In-Reply-To: <20230306155348.41081-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5254:EE_|CH0PR12MB8463:EE_
x-ms-office365-filtering-correlation-id: 01c63fe7-9a85-4d2b-4bdf-08db1ebd9606
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OCGXRi1kcaauHkvBC7CTYnnxmz/ZICw86CmEwP8qgrTjzBbxmSqcXfG2qyc4e78zBOoTvtVK839EMi1JZ/ohm7ZyDBjN/mjGJ8GOLIkLCBiiaHEAm5I9ufW4EeVSGS4QnD/4/w/TMvW6BWL53OCL8sqJLbowneH3XAtsYBAiyeqjhsXi4US7/qNOdAFINXPTc9fxHk11fAhttVHYaWsFmG1Q6+Ib7e1ztkoGqd/RHca8QvvGw9ncMiq8Heez9Ser+Pp0mF7HPcBAhWZezzlQffXTXyyIknuz3qpL7Wm7q1Q0mSoSElChVQr2Kpmj3FRVggRwkQ5mB3A0qGb1zF8yS6T0m0oOanq88gF/GTd+IMHR+cEFhyDjdOBGuB7iISezrAoDzyxTrvMlM4apEY9fMoIyzRobFwPd586DKl1hucpvfMUYbPhUM6F1iUOHPWn347317Fv8xGgSTbc/1MZO2YqYHaY3xKjvaaPaK38mCzDBq8MwuB5DcWHptQoqm93vCwdCqxN/DTNJEym4rF007d7BM3uSWueDO8724bsoPpexFsuaMCn6u7t1kq8z5mkxRTQGYHX+iQuzSxOOcZP8Pvdy4t4Yzm4SwJzvzuTZPyphQzIsP7AQoOtrL5iDvPfR85/hBxjRkBjE4UyyLPb7vQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5254.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(84040400005)(451199018)(53546011)(966005)(6506007)(38070700005)(86362001)(122000001)(33656002)(38100700002)(9686003)(83380400001)(186003)(55016003)(66946007)(66556008)(66446008)(41300700001)(66476007)(8676002)(64756008)(4326008)(2906002)(76116006)(52536014)(8936002)(5660300002)(478600001)(7696005)(71200400001)(316002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?It6+lcj+Wcpg7A5qMSxI9lya8bCTE4OIQNAIvKmjA+1R0OKYZkFJE2dtIS+Q?=
 =?us-ascii?Q?owXY3B6Fk6epdPAczM3iRhKsdkykuwULBeYwtJNh5D3YvSnpBfK1m0RbFMZD?=
 =?us-ascii?Q?enCqQuog9YKF96SUNos4hSVLuNd+Zz3vpypGOslxadpxp9W1lyAWjEL7guW5?=
 =?us-ascii?Q?85GPBF4YSGok50vlXY6ry5/3dH7WZFg3rvPrbbnx/ABaRKSEFV05or+9SUr8?=
 =?us-ascii?Q?RUQguPc/QMt7znFHs88q6n+jHQxJ/V7NjRHrQg7XLnG+KbHZxbx/MWHhtUNV?=
 =?us-ascii?Q?2xxRw0trxFdoXTgRS8OTpAb4cF0Ohy9xdu7//CzFskoyqOMwL1os1DlNhdvX?=
 =?us-ascii?Q?vd/pC8K18Lb0Q7d9gbHB0s02Z/yZfjcbCkM0IdEKFOWwruwJ2P8EagbBi3Vb?=
 =?us-ascii?Q?Wt0vVg3g8zNWTZ2VbCk8OH6DkFjoD/bBPfXo0p5KpLrmWMvUeaglpQEKZJyT?=
 =?us-ascii?Q?Mo8WlaFx9trrckZNTUYjwywnTvHJWmN3mRrbKqyDQu7ZIy1sTDeJPe92ZbwT?=
 =?us-ascii?Q?qG/rxzqExHx06tGF/DIJRaS6PgiF9+UDGlgFKwkkIk03EjvA3Y3SECFsl6P+?=
 =?us-ascii?Q?//apFbvgT/ZExko4YzsYHiwjgQoxGISoEe+K6n4HUbD3PL6BgZVePt9X9+2e?=
 =?us-ascii?Q?RUEGjAzHYD+Il6CR7rpPzztU77H0wgRkCSlYF7x6xlipInPh6F7aWw53pfhc?=
 =?us-ascii?Q?/4oVoFUP4+PtV+oMxiv0TKOdntdmLnJ0uFu047LGfuWwtD2OwZTOeC/BK4Rs?=
 =?us-ascii?Q?ftEu3Xpt8ZmYqgxY1ifas6rg9UzfsUVEF+0vA5Te0jUHaVkieXAEAP8iP9PA?=
 =?us-ascii?Q?1CCfUkXoFGxtb7p/qc+OAZegCf+PaDjspXXyYQObWkCSncrhvEWAHwV8Xc7O?=
 =?us-ascii?Q?vqEuMAzDEqbVrW01qdXFf+qu9IXDBQ6fIdULikQleroKvztPdfD6pERgQVM3?=
 =?us-ascii?Q?e6dlr1FYmoXUbIRWwrwAI17jiv14cElsEkm70QzjjiSowbg3AoyeMmT3rodX?=
 =?us-ascii?Q?AyxPWSfCa8IMbkR3xUoUrjS/uasqOnRMbS4zClYRfMlErMYiVWKNY+9uTydP?=
 =?us-ascii?Q?OnCHVuBbAIZu2HL1hbPL7JPP/g0eVtdan9GZWA67Q5BmHFZtoiAJUnk/Poo4?=
 =?us-ascii?Q?Lbl5Hv6azZLXG8IiWeD9dtgWtm2PGnZOfuOQIUKM+YUckqvct0OrR4lWX+VP?=
 =?us-ascii?Q?NwJjZf8uw0UUuEIElzaap6iXNiH1ohwQLLiKqYvu9Q2my3+IVoLofDPQEwvC?=
 =?us-ascii?Q?fzpyLrMmHCvMVEPJ29D9YfmkOK5MWwvQma3PjYa8iE/ElKMFfU34fVDrgx5i?=
 =?us-ascii?Q?tUkJDQ7O97uXOc25oLYulqG4tybJap8TZ0EiPegfZ/4AU2jTExu7xLPFiiu0?=
 =?us-ascii?Q?QAeIqbdkaP0/Kj5q9MGMiVNpXn3EplErC5rPBa9+eVqbcnR4ts+Y0a8n7Mqs?=
 =?us-ascii?Q?aO/7fYBGbkhxjSKH+fyEtFPfaVdOGRAPvlKwHhJXSmzmpixO5PIWlJgSP0HW?=
 =?us-ascii?Q?IxCmyRWxyMecj1cjrbRO1Hp6vUnDDjKflcxXBTQ5OjAlhmxAdJ9NppujwA?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c63fe7-9a85-4d2b-4bdf-08db1ebd9606
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 03:39:41.7548 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mf1e3MLn7+9FDJjwC/pjvhuZUs0ud2BxQ+iZIiwjV5VMBWilQKSLgt+0ifOojshE6/Q4xTAerRwUNLodLshLPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8463
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

We need another one to fix the same issue in nv_read_register. The series i=
s

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Monday, March 6, 2023 23:54
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix error checking in amdgpu_read_mm_regis=
ters for soc21

Properly skip non-existent registers as well.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2442
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index 620f7409825d..9df2236007ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -291,9 +291,10 @@ static int soc21_read_register(struct amdgpu_device *a=
dev, u32 se_num,
 	*value =3D 0;
 	for (i =3D 0; i < ARRAY_SIZE(soc21_allowed_read_registers); i++) {
 		en =3D &soc21_allowed_read_registers[i];
-		if (adev->reg_offset[en->hwip][en->inst] &&
-		    reg_offset !=3D (adev->reg_offset[en->hwip][en->inst][en->seg]
-				   + en->reg_offset))
+		if (!adev->reg_offset[en->hwip][en->inst])
+			continue;
+		else if (reg_offset !=3D (adev->reg_offset[en->hwip][en->inst][en->seg]
+					+ en->reg_offset))
 			continue;
=20
 		*value =3D soc21_get_register_value(adev,
--=20
2.39.2

