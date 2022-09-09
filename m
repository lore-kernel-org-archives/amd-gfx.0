Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39743C54EE9
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 02:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE93210EA1B;
	Fri,  9 Sep 2022 02:22:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1638B10EA1B
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 02:22:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJkPO7Sa4kIK2zAb7zlf9Bl6ydDLS8JmPFSsB2hWM5Jxq8R4xa7kpTCck+quC3Q7nyCvJqKvjlZadR4vEcG2pVialzHqkDyFQRQxMKlPK+IOYiWy0LNJp/+LpnvZQsBjaXyfCAUSu2uvgwLYJ703S+NNderyJYjYW+bwVt9Pjdto2iI0GnpTVcOrZrHLgsV4nKcga8MFUa6niUnsWG91/gmtyN1qdeMX56uQ5+9I93Z4giMUg++kFqL8DQkQVSQ4f3qGEaCJmESG66SMTM6VC012/IWyIHT8G+eempgrlXPw41T65AryJcZjqZXopdbGFSMO5hbScLCJEhrPJx9P6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSRWGNDOX/elzEaKRIXnXh0XrQ0QapPN0quJpJeqFTs=;
 b=je86CLs7eE/rOoyxehdEIWv9302PgPQXXlvH+6Q6X2QkKaGvZq4B84/YsX0YbJkEVBT250I8x2oxmCf5l8E/x756OdXRIiLjMwWvcyryMKMi8A9aejz61L1PU7h2A3a8zLdpChFvUsL2WXgQgJSd2pQymwq+Bv4LpPshNSc49ghrU2Cg/lp6sbl1rCmLS7l3q1riq2H8qfgdu7Ed9sm8JUmHefDl+xksckaNxy6T9MSLL1yr9Ol0f6Z+pm8khLTEcvd/HKtTpTm4U8k2JeoWw6qSmZ4WInwUkNRwrI9dTkk/CBBiEOaJb6vkRXBadWpmQTJ618q6ip3B5xhsh1540g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSRWGNDOX/elzEaKRIXnXh0XrQ0QapPN0quJpJeqFTs=;
 b=ocn3T8b/lpu3lJ56pAR7h1AlDVvJbu6EMdLm63RRZazsiDssqTODFcqeVgp/97Ig8nC50Ww4ouLD1ieiLI4SY59seG829Nv2+Yci9hnNySZ/jk3LyBjLGglOTKo2fZV25dOvH2jgojXLMmbnF15x0xOLE3yK+9hp3tUWm7V8Vac=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 02:22:22 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28%5]) with mapi id 15.20.5612.019; Fri, 9 Sep 2022
 02:22:22 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Enable full reset when RAS is supported on
 gc v11_0_0
Thread-Topic: [PATCH v2] drm/amdgpu: Enable full reset when RAS is supported
 on gc v11_0_0
Thread-Index: AQHYw+ywqUOQLzONTU2S1UDd8+cMU63WXgWA
Date: Fri, 9 Sep 2022 02:22:22 +0000
Message-ID: <BN9PR12MB5257415E9AA7CD711C63551DFC439@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220909013650.16276-1-candice.li@amd.com>
In-Reply-To: <20220909013650.16276-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-09T02:22:20Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5ed08897-59a4-4d36-a581-2acf50ba6b36;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN2PR12MB4110:EE_
x-ms-office365-filtering-correlation-id: 660bef66-4da8-4dfa-d606-08da920a20bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KhZzYuGrv5IOEqTi708SGm6npHAo9Pp4t/IxNGT5GU8fF04lf67lSl1kVtW/MoN7W8MQ3hQvj1XKanKeQ5jO0+TrI5zqiCNWeEEvj73WUWEE9I9U5rb8KXImtwqk+KRopgKLNcKKLMwkpFJNZosxsFd/B4nBPXqZ2S3uMbMmIECUnQLgNeUEN851YD8ljVLzb3JUeCkgaywxVnMKmhEbdJj/pbgHo7K65Dbpx3Ci30dslX/lxYnDoxTJs3blg5uQ0chtbU5v9thgcG7HRfbsVPSg84UOklFSvP35TcTkRdTn85L2k4KzxB75goFHhXDafXsRVYsq7Q/kGGyfs31LQ8fBFQLt2tBbzMY1JbOCYG1yO2GPhd41KbvwaWbCn08XW77lyGrgDdKgkoNe4fPEzwvFmoVFGFHeQt92DegWiOe0g/UlQbdwK0hzDLBD7hRC09KlB4nvcHLW8RtcjpC7eP2LpszjWHIcEDBqNHElNZGQBlWCjmF4aqOTZKsy/kXKLHLjuPvADFNmumoAOb+tzDryhv3X39QtgSXrFHsqNXsC1ofq9WhgcJONq9zq+WjDiqEl+0UB5QzWo0NOHw7N2vRKLXYVGRmi5dkCfABSgLM/q+RKRKBHK7VW2l/gVQBHZiSDvV6+d1x8LOJ4+Xuhz7rDz4jgmbytDPD8Z6AGrT1QJeY2mlMRfyhSnNDYaVGujPY1cLcd1efoISzZzfAywyNABWfWEc1oU0VGpxx8WAhtKexgl9PR69DSgTi0LJuiWgqnR4hYUyweGcVg8F2tWg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(186003)(2906002)(4744005)(5660300002)(52536014)(64756008)(66556008)(8676002)(4326008)(66476007)(66446008)(8936002)(66946007)(76116006)(478600001)(53546011)(6506007)(33656002)(9686003)(26005)(86362001)(7696005)(83380400001)(55016003)(41300700001)(110136005)(38070700005)(71200400001)(316002)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BrSecUQR9u5ua2GDjzWVFlbAKsLiRanrEu9D1mIm+T0BnqG+L1kW88kdkQbv?=
 =?us-ascii?Q?P3+YmqMYCbryd5P+964PhdPZSgVPQN9XkNskemflcbvPkzprm8JyU48GyuGZ?=
 =?us-ascii?Q?WBHtWNLHM5Agcf3Fz0HH5V3q9jB499ifxdEKWPrVMSdl9hbLqvpATklfpuw2?=
 =?us-ascii?Q?OlgWW9BxfuiH1TE79cSl7/G5FKqex57Q6UU6cAHLqzGbq7A52glHMvekNYra?=
 =?us-ascii?Q?F/gSzOXyLJhTrbvTrgNOq8VE3vfGzTuUQ66e7/hP/PxqqUrYQUUFK9X1hV/C?=
 =?us-ascii?Q?YluroaIDmBkGVYsvOLJN3vpaUQqRVBNnzVHRgTmfDc3Muzz/sqeCCtNZ9jLU?=
 =?us-ascii?Q?w2/t3BaT0xon3vInL+Ev7PQkD/yV7DAJ4+lveOgODE9FS7ABk6e9DlCF/H+W?=
 =?us-ascii?Q?d6V0qswJFY3K39T/Dgmj+ompD6cA7OGX9SApp/6V6CQ1YYAquEnJay9A0Ujd?=
 =?us-ascii?Q?eTxAikMudsV1DmsZGAgb9bUKgYVbS/dDkj5cFKGc3e5+zpr8Go6stBAY+OrV?=
 =?us-ascii?Q?T8GDkrvDPZyGZvlWKNfxPiaTRATNiWoHeESOI4hKTGjcxLnYScat5pJ9pbs2?=
 =?us-ascii?Q?cdbldiF39bQAsASzsMB6HD/Xb/Xt46HIxKQkaq0yyNkqGjjxvf/QBlmMFOix?=
 =?us-ascii?Q?Xf+mAq9Sh6X3kU1Yyubrt8oyiNLzpTVRKXYxbsN4hx8KCS5V6vjXB+2u0JbD?=
 =?us-ascii?Q?oIH93J4uA8w7VgV4220PCf0+Vwo7MOhsN5P6SokMTq4Yu7t2svjh9QH4qUqx?=
 =?us-ascii?Q?P1ClGV2gm3wjCDcqMqrdqdYXo26c0SgP1i+ARf3UYKl/Ld5U3crJv6KohbTP?=
 =?us-ascii?Q?QsxgE1GCvl12s7jiuy2cWP7oMDC2sPonjyM646iW1P9ab4mm+6hascLKG7SY?=
 =?us-ascii?Q?QDemjn4mtEfdTIjnlmgeNl5+bHq4ZdVyW6mXmXL6i+aKszGx/vp0iVnpAMDW?=
 =?us-ascii?Q?4DdUu3S2N4pWV6mRH1YmaucQ9hfHtcWuYBdsjYdY6AiiQt/KQNPqTSxb51CB?=
 =?us-ascii?Q?N201OYnzjPnCvTN7tLt8yuUMafK9afUATwwbLlVqsdnGx2fvHXXyoGwq11Ew?=
 =?us-ascii?Q?bvExvQlhkwvXfeKutEzpx3CExG+oDt7jt5wa2TK73EfsiWbSJkYwIpXGoKT+?=
 =?us-ascii?Q?a25jVhUq4JRoCrcd/ICDNa8CWFkG/ilcvr6Uy87ldXPOnCKAYJvSjn7yojLY?=
 =?us-ascii?Q?tnX8SPJbZj+M+i6yFXDdaZv2VDJl01Ao0ff4BN8TyhD8GA0Zg2Rkc5QsUWNE?=
 =?us-ascii?Q?33nA4ntGx/LHZXY8ywGo2gLioUNDlOBHqosVnvEq/9G9LOP1QH7ShaOCTKFC?=
 =?us-ascii?Q?gc0fLGMoB63yyoxRLKoSLpBhHEvBM+zo+F4AHc8oSPINzPUT7rOocT9Esofo?=
 =?us-ascii?Q?CnydinI3cNaMrcF/3skTCIUnkmdM9WwMpAYRZQ+5nXnT1CKlGj7+cc7Fw/1l?=
 =?us-ascii?Q?Zlv6mgVIrojspC8QjWJrIpi3WFnKS9YQ7d1/NNH11GiBdaA+J6f2aLwU6nA2?=
 =?us-ascii?Q?VVP6Daosv23MRE1QBeLx+T0+mKpilq+4vL1musgc78e3TzdMMxDpocK07rIw?=
 =?us-ascii?Q?K4O8MHSwdw66EdP8I8nT0rI+YFWGCs1MjN3utTsv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660bef66-4da8-4dfa-d606-08da920a20bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 02:22:22.2492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Za+HW5Z7onBSOoINK4ZEtUESzH6MZB9BuYg7r8VynB6svagBsmyvyEWIXRbMdftO/VArYujL/r4vn3z/khJy1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Friday, September 9, 2022 09:37
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>
Subject: [PATCH v2] drm/amdgpu: Enable full reset when RAS is supported on =
gc v11_0_0

Enable full reset for RAS supported configuration on gc v11_0_0.

v2: simplify the code.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index a26c5723c46e27..5f0d6983714add 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -421,6 +421,7 @@ static bool soc21_need_full_reset(struct amdgpu_device =
*adev)  {
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(11, 0, 0):
+		return amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC);
 	case IP_VERSION(11, 0, 2):
 		return false;
 	default:
--
2.17.1
