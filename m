Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5966CC47077
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jan 2024 02:46:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E040210E5F6;
	Wed, 17 Jan 2024 02:46:18 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC0AD10E5F6
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jan 2024 02:46:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnILUAzaCtGYbGbNJmufnIomgYtZgLBBN5Wi5lRxu7M1DH3HJUxxDROd1ijvl7lFO8O3gy9lRe6hudUQxv01Jj6i9SoM3Pqez8Ao7CD2GDdgMXTSOuMEH3TlC55Qyn1I10RhC6zf3dRhYZbmBFVmfmcPQABFfd06g9Yfbdms6L97k49g4JBW26L9enajeHykOipm8zW5LkfTmuVoCxuCkbu2cq2eGVLwkfxEd9ib3ClzqKF8epb7TZ1ftwLSsdphgKO+8L0w7nnFDFNzsZ+KlGTcd4FKYE+RsYFfJTZ29Z8zTkFuodW8wAlTbxOPi1pJjn1nWBvLCzvZgZN1o1ibpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8nOmw9w63dmM5b6GBGQ1v5kwr9/yBLOtSPY4AAUel8=;
 b=fJVAqzsZNOmvaFiH9g/e6WrglHqHLMmwj2b70RZ00+PoDDxZPkoICdfPbG3D667ZBB/cI78nShh4Kh3On3ksG4cUnril2PtE2YARVL1XqCwH3ls9lWgH5HuLyr6ie2bxWoou1VNDQ5X2fNXqpohLsgam8buOonDO/aNsSOI28nHNfYYzx7AKDu7BWnL0AVUwCihRFPnw5Q4g5BDM3sk0+1YCr59fasanixNxGyMRgmBvkUVBhrz/w4l81H3BVNymXK6LgxTvr0PQdaN5/r8MC2040bMKXWhd3N4US5WijOtVbPiLni89Sahj6xmXR5bG84SSir1GTM3F+/PKWVNsig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8nOmw9w63dmM5b6GBGQ1v5kwr9/yBLOtSPY4AAUel8=;
 b=sl76jqYc+RAVA4cLie5bk5v31wpw2NEMRrlC85j4mF0R5my40YonqAwhL2xVnt3sKpiVLl/HQ2maeDW36I6p9g2TujlZ9xmr1Iz1N5kqKTpTBekA0YH1Doo2wWUEyoodbb00WCkH4HO4pfGaXzYSS2NmVOvKvQ1GZ25R/NdnDL0=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 17 Jan
 2024 02:46:13 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790%5]) with mapi id 15.20.7181.029; Wed, 17 Jan 2024
 02:46:13 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/pm: Add set_power_source funciton for smu13.0.0
Thread-Topic: [PATCH] drm/amdgpu/pm: Add set_power_source funciton for
 smu13.0.0
Thread-Index: AQHaSOjxZwK5qIBri0OyfqQYkFF/cbDdTMng
Date: Wed, 17 Jan 2024 02:46:13 +0000
Message-ID: <PH7PR12MB5997E11C939410595862D42A82722@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240117015953.915067-1-Jun.Ma2@amd.com>
In-Reply-To: <20240117015953.915067-1-Jun.Ma2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH7PR12MB7916:EE_
x-ms-office365-filtering-correlation-id: fc17a1cf-01fe-4dd2-ad94-08dc17067852
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hqM5BnaGd2Qw0z0cIP/FNAFrM5etu9EWSWkG4d1ng/EsjjgXNSkF33ohOY4klm8ZD5NiI3yNHMGCxlI6L/3iAdxRTCwvaX8V712cJoQqvJGDvDdsEDLxfckeka1hi5A4+SBAuSFznimElmzjEz1P7XUjT6hsCQ2enrC5y7rxiTdpsUX9kVS196XxnPXHpcY6ULbi5jGxhgpHOP6j+br5+q1LjmQ/7E6DUzcKDGq4tLBER9T9/trFkyOjsCdWQ5o1rkdCgooK55rodzsJbwsiZ0Rol7iAPsKyMQINubf+auutFNYN4hWzi1Ejzofqrng9nfkAJlqOICNkjIlC/IhjgkhPeQVK8RUu0P56IBqLiMwpSIq06yvDaiLw97JEcWCeVHxADcmZJYSlUjqlCggHHP718jZGG+z/2w1LmMfESQo+9T2gEWQNjPeegyShv34GIfZe+DDHB+JWP5kSeXyIm9u+igNGEzHCe8qbkLH6cQ3NImPSzZoHDFzsG2pBxSneeFOLRiPtHpMlFn8rQXScGss7xs6yfU6iCG/oNKtw+MmRxAcqf+StQOWOqOQTp9dJfF8ocNqB+yHYDFtagRJau3v28r0LvZ1IvK5DMJ37NbmLjU4TYrwPLcWV3j9k03qJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(55016003)(9686003)(86362001)(71200400001)(53546011)(478600001)(110136005)(66574015)(33656002)(38070700009)(54906003)(5660300002)(52536014)(66946007)(38100700002)(8676002)(83380400001)(26005)(4326008)(6506007)(76116006)(316002)(2906002)(66476007)(7696005)(66446008)(122000001)(64756008)(8936002)(41300700001)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JwkPzClkAVti2UGDGZF854YS8Skn5gnYTFhc0TgBe6lsgIb/Cj9zJRa1caE7?=
 =?us-ascii?Q?pq+ZpFPp5Rf9e4HFrMVMAoUbF/jZarEBQ7IBumf0EzCNaEJTfyCL777cf2sE?=
 =?us-ascii?Q?nTKqPFqQz6fu6sWkIz8JIO4OQaptHfGrsC2ossPBJrtJo6JuBAy3pSIB1iZ1?=
 =?us-ascii?Q?gzsQgLZSp1/wUbafZNNWFGedG/dtBdrDFkOcVC7D0UToR/cMWErZbBzwB5Qf?=
 =?us-ascii?Q?BnoMjHpg8Ul+FySmy9mlUMoJLgkkw2C4A1Y9xjB+GCqgWw/0xRXSqoWFsCbE?=
 =?us-ascii?Q?DbI0ztnXRPFMn8FXRpVyH0vQ7NDFh3weimJrK2VxyU9bIJRtrY0pDubEikeo?=
 =?us-ascii?Q?Q2/4MdhwG+saJg71hOe3DNx8/CdK3eN6CttEJn/RjzjPA8A6FyQosyK+Aiap?=
 =?us-ascii?Q?jlfFi1IptRpe1HagWB2MnczLjpepUiX3i1hq8WxZyMJ3hvsqMQejpwryVcUi?=
 =?us-ascii?Q?vzXX4XOcGtRHuHMfRa69IdZd+aDREFtOhPq2aaNCbiwJDy/OJ7e/XUg0sMwb?=
 =?us-ascii?Q?F6ashJu1a2lZfuA1ssxADR3WDLzWlp52Ag5pQL1XdRYPusVKUUqxvQkGi5L5?=
 =?us-ascii?Q?tW4Ozfd+l/GapzSyL2wXL+TCWvOiJeqCLXAyscF6Lt5/MKG3Xjgeybjd7mGK?=
 =?us-ascii?Q?Gxq5y6OCXzm40XBf1f1GWZ1nxi3Nvfwy3YRXEZcd4YI3kFYSEnX6FSRtU2KJ?=
 =?us-ascii?Q?qXMhU1cWxxH4QZ94EU7rLJtT0WJrvSYTnNCjY51pb4AIHbTKtrVBc7ASAvPz?=
 =?us-ascii?Q?FQVj7Aq2bLLBzRoWpVkR/Rbf/1Ism/7GkRqRcMpXJ8JkeoGge0jdA1WUYueh?=
 =?us-ascii?Q?lefk1cypy0O5LkWiKnE/I7cuZrECKPdhnGv0Iu0Xg50ZfxUcfQjCM7OQT7nV?=
 =?us-ascii?Q?1f7Rc9wFwHg4coIUN+NxL7sUkNzDfjHdhAla5O1L796OSmLc9yL7eE8lJcKq?=
 =?us-ascii?Q?TTe9YQ/IHqUiVerGbSH2+wFoWJZT/MhJRwJSlLBkebaFHJ4RkPDyR48sp3hb?=
 =?us-ascii?Q?GGmfJzJYQfV38+HQycMjE0cFolPAsa4pzqMgw/72HIP2X1pL/C7NY5TLc+p+?=
 =?us-ascii?Q?HCX4gxOVD/PvYXjN5A/BT69bd0hgL4nzq3WeUF/b65I549fwW31G1zpNjn8S?=
 =?us-ascii?Q?U94j59V6IDxq2LVed2Q4MgEOnFCGgAYI1I3VuubuijHTS94O5Nl2avR0jZwl?=
 =?us-ascii?Q?0Gw1ScaQL0XOn1WTHJmpGbk3innYTanJe1w+xb9IazocX6uOQoDTX/JLzUmr?=
 =?us-ascii?Q?9HolVOdkN5f2QoXsbGgkEYrmLZaQglOZ/GROWfNQKQS8F0rnxhAAu4NJTd6w?=
 =?us-ascii?Q?AP/ZgHCqV2uT71/c6U1EFI2uGp3mlUFW7ti3kG0DOrzXDKmW+cg1jEP7DRt6?=
 =?us-ascii?Q?v9osRXe4zzPlbQjVp9NVUFZcOHlpgpiLwrS2WnGYeaso6QftjNB8ciJtcaUR?=
 =?us-ascii?Q?O1p9aHspAd4nkFqJGNinkPs8/BCMk/yWDZqfCok9l6UhXAiT7vgWcpteqKm8?=
 =?us-ascii?Q?946LM+GHC+3DrXVvtikkg7kMqry44hvpubl2jfMjQPc5YT7xkjoIcPfapFuR?=
 =?us-ascii?Q?WRTOeTxMWNzxyUda0YE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc17a1cf-01fe-4dd2-ad94-08dc17067852
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 02:46:13.5316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +8t0x3TA3OIqw/SEL3K3KQEc86N0ay7ZDeZpmsexnEj2acs8YHw2impmxRfmo7yN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma,
 Jun" <Jun.Ma2@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ma Jun
Sent: Wednesday, January 17, 2024 10:00 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Ma, Jun <Jun.Ma2@amd.co=
m>; Feng, Kenneth <Kenneth.Feng@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang=
@amd.com>
Subject: [PATCH] drm/amdgpu/pm: Add set_power_source funciton for smu13.0.0

Add set_power_source function for smu13.0.0

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index c01d5f5b80f7..46ae5d811bea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -3020,6 +3020,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_fun=
cs =3D {
 	.enable_mgpu_fan_boost =3D smu_v13_0_0_enable_mgpu_fan_boost,
 	.get_power_limit =3D smu_v13_0_0_get_power_limit,
 	.set_power_limit =3D smu_v13_0_set_power_limit,
+	.set_power_source =3D smu_v13_0_set_power_source,
 	.get_power_profile_mode =3D smu_v13_0_0_get_power_profile_mode,
 	.set_power_profile_mode =3D smu_v13_0_0_set_power_profile_mode,
 	.run_btc =3D smu_v13_0_run_btc,
--=20
2.34.1

