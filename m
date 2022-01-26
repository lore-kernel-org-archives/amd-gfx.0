Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C74C2BA4C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 20:27:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDDD110E7A3;
	Wed, 26 Jan 2022 20:27:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C01410E7A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 20:27:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CStehtXhuXOGR7YYUuIIbewj+fGSKI8brb42+kZdwG/gC0H1IpIVH/e/uH2BSBRq7S+19pdyp5b8g36PP+fvmP5cyQi03uHUlADSpjmZ41l0wIYpqgxP3FSExUyq0Y6rXb5wQ4ANYx/XAYzTdCpb4wb/+83vE7uEBr5Rhz/FQRsX/FmuB1QFbyRLWBD9NgrwBHQZ4YWFNyEwYer9QckldBU9fIIFnrR1NemEZca0sdU7bOFDYSDvpHI4hnhkCg2fx5SA43VIh8jp8gezn/xoidE23V3xAdjqxZESU2Ar7lyxCWBaSN9rTLaObATLTViLrKH4vYalpPmGy5kxA901PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKDcUucz/sDWCpfOb3QZRxNPPTFypNOJZt37JVI20uU=;
 b=i63Wuh+IuRAE6YJi0U0ry5OIZM44VVB5x0+jS4JbQRp6YqZBM40CfiN+IZAeeewldf/WNEeC57D5VxorKW94dDj3TudjCQIQnO1B6aZYOIMXX1QMQcoVuN8kv58k4DjEABygp3q2gWXFMyjfejWX1gT+eorfqCx6rQxbBezFoC1pltup6BSyLaWgLVL8d/+UBMrBJ2IG3OnKhdPC7QdLqB0pCcP+/JOSiFXGFltewHes1PjIQL6oP3h6c6jozLqwfhDhBmAWkgJLN7mqlTLNvtekudUGdhb5vpicIu637ZgQQIvAYmE5PCL0InsNUaJkvaQX4uNPH54YmFzG0aP28A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKDcUucz/sDWCpfOb3QZRxNPPTFypNOJZt37JVI20uU=;
 b=e6xnh2Se9oDGEqAACVrU8a5CYyQsSrpX//Jf3hzzR4VD+VqLKakpYi2oBw4ngw7+IhffbTN8a2vs2ecSN7/d3j2wmdMiEOmSkrBXbukca3EOXsS6VP71AxWZaw/MQL9VieaQ4cbpSiP+2Yq7pucbgnYqxgcXiAfl93eBP/DqU9A=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BN6PR1201MB0114.namprd12.prod.outlook.com (2603:10b6:405:4d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 20:27:16 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%6]) with mapi id 15.20.4930.017; Wed, 26 Jan 2022
 20:27:15 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: add safeguards for accessing mmhub CG
 registers
Thread-Topic: [PATCH] drm/amdgpu: add safeguards for accessing mmhub CG
 registers
Thread-Index: AQHYEoneSTZ6XCsyNUWund19z2Ne6Kx1wOs7
Date: Wed, 26 Jan 2022 20:27:15 +0000
Message-ID: <BL1PR12MB5144A8EF8920246EDCE4B865F7209@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220126075326.1134770-1-Lang.Yu@amd.com>
In-Reply-To: <20220126075326.1134770-1-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-26T20:27:15.218Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: ad9d03ed-788e-5737-c35a-187642aac474
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3161f847-31d7-490d-f6e9-08d9e10a3e3d
x-ms-traffictypediagnostic: BN6PR1201MB0114:EE_
x-microsoft-antispam-prvs: <BN6PR1201MB0114A42E7C46713FB99996E3F7209@BN6PR1201MB0114.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wPznIPvV4l1fOr1kwTlqjwffvUa98vcJJwP18ioC+YzZxmK/t0HB2uMxon7/flXQ21rOkDPV5E8EstoUaa0rsuUk43GMelZkoRsW43E8IaSxKlnN8+TUqCI18ViVpnLaJuZpET2jObDRZvEIN9le5bwAjGaAzNx6GErHrYBm5+Km02RLZpd8sQZo8p3m1wbRvV+JTsMkSDtHS3antHLmguFkLo1F2rBqllQyQOaa5Xhpp6fYRIcBapjDekfg91SvYI6A1GOD4zsLv1woXZnYMCAw4C6n98QsMUYWM1ukZYI2eD51TwC6Yq4qznUEKiEApU+bUvv1jOHhH94QT/rlvlYEfTEhzDl5jOoiBER2lxs1g9vnRnLSg49LyfeUXApBephjWwDi247ye+l2WIicdkRjFfPYY6Tefy3EXjxsT3wpS7JeHBLV6ygDGZFhFRmdfdTnwY6E20ydpVn6Q3zn7AdaQpEIa/hdJMHwzzzjtIcy1nzKFenS3gcCznBunh702IMF3+D/SRbm1uWsbgmN1+CLGjvqaxertxyShCF4yyXDT4tcoYWp36bflOJCQ4Mz0wuR83J89Dqafbvpzun9BLlBuku7WfMjgyxkW3VtdTPhTnHRsrZGwPcJIsxcvAK4m2qVLbcNMEr24sk2rVw/mHEj+2eKi9hpV4MqOl9y/8wVz9TcaU0z9M3Li1T/J7+U+StPlG4hTo8YX+Jg+s7a0Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(52536014)(9686003)(66946007)(53546011)(76116006)(2906002)(508600001)(5660300002)(71200400001)(6506007)(7696005)(55016003)(19627405001)(66556008)(4326008)(66476007)(54906003)(8676002)(26005)(33656002)(316002)(110136005)(38070700005)(64756008)(83380400001)(66446008)(8936002)(186003)(38100700002)(86362001)(122000001)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yOIPedD4OMPyuyrTTTDhVl++ivZcsDjYN7WbQncKFIYoaFs0bo6wjxszHQ5U?=
 =?us-ascii?Q?4pHgMIAsN5R3MOxlt+Am55s+xbHiQoa89Gf/Jt+YXakaK3SpLKLpJqW4FumB?=
 =?us-ascii?Q?9XMJDwmGtJdSxbR+YZFKL+PtWB3+0jlm4b7qVHSKOl/2V0FAz9LvqR/nQaWJ?=
 =?us-ascii?Q?VJ+WfKKgv/CosaOI7sBzCQ1bIJWfIegtmkjsifGfRb2AZ8fyeeW3Z/I5Al2o?=
 =?us-ascii?Q?gT/KL1t6VvgXj78C4e125OFxS/W1wL9vXN75qBZkNiQjJ89kEjAnacfW+j9Q?=
 =?us-ascii?Q?CPAzsJvYRdfWDpAKYN6IPSO5iG+SmEHD/BS+s3jgHor6yP1rXPX5UkZLAruC?=
 =?us-ascii?Q?yaIBhg06RYGtVl4fu3EMqQriQDIYkAWoXivbRUd8TZmGmmS4lTS7jBAI2JWB?=
 =?us-ascii?Q?r09RfOOgeGJ6iMyPyfI3fPTZMvzUe5cGkqFbr+qp0/Z5a0/Y5495dhbbXF+l?=
 =?us-ascii?Q?aRC2dd0ArC5xfIEr7T53TpMaaBb58ZI3roi2sKCWswKs7KWa3es5jneSDBW/?=
 =?us-ascii?Q?TrZH8mOouWzwQZAxkQQyHwpof8BIdKUnV+0VSzHvevd1VLFANLeq4fEGapET?=
 =?us-ascii?Q?/7AL5TCk/XOBXXBPWmjfMBW4gb1QT/Q+FULb+RpwmKgSvm0sdWavufHXWbHJ?=
 =?us-ascii?Q?FHCGPvdSaWl2LIfWXPZO7L6Cv4fxaSNeF3VZ3V2yA/l+p7y2avw3MZTMyZAV?=
 =?us-ascii?Q?SJ2dexdgF1M3Q53ReVUecAzSTYJNSk9oQdbgbyVrkeWYZz4pAsbeWTBEvT3+?=
 =?us-ascii?Q?38gck1n19OUvp79o/I23ISU559MMnUl6/YEk56o1H5bXXvF60+YPR6m8mBsa?=
 =?us-ascii?Q?1kfRtBKCGkCGbGoaWIwMnSxvs4HLUdAN0HsQQy0O3rn04ozfAWmUlbO0mq6L?=
 =?us-ascii?Q?HSY3xqiqZ9L81TDwk576d3AP1IPkbwHprTGOfDzMaZ2datNu9XUnEQGEWYOk?=
 =?us-ascii?Q?yUvghrD+3YR+bI5/b4qh6XqiSs2a4zoc8l6bMCs9Ggrf2iWFLfCFWXwaQvdb?=
 =?us-ascii?Q?rj+QkQOycqXmHgVk38h+hBNGM0LJEO+O/JdZmnx+LcHlN+neL4j+C9/l3dR+?=
 =?us-ascii?Q?9zrfx9apnUYemNUxtcm3FMa2O5Pk0sEkVss9w2ufPTu0+OWXYbLgWhitZv2x?=
 =?us-ascii?Q?sq13pIj+n9tgb8N/APk3BwY3YBP3beWNGg/oahTExDg7hj/mG8fIOoiBXmhu?=
 =?us-ascii?Q?OLdviE61P2Q5Qyw4hTqQ5PB3huggrewYE/S5lIlqtOL+9cq8u+wLN9c9u+mO?=
 =?us-ascii?Q?Cc0j3jv4yvC2G7Y/ccbBqz5l7vk8Xl5NUDwqaReLH8u9b40gPsabIIC2w69p?=
 =?us-ascii?Q?m2DKFG43RqzJ8vOqGHLtBmzM6jwhoNrG510Es+0A46JbtO3yHwVkEJX3cVZv?=
 =?us-ascii?Q?AKlVHOK5bgF9inBBPcEsio52PYpeOjAnLTX6FQnXfSU1Gn0yLUHERN2x2gRp?=
 =?us-ascii?Q?Fal7jIQinrk9+t4hkPDImydvnD/aZUpFvJrreLrbopRSI6tZ8pMZuHd0fLnu?=
 =?us-ascii?Q?QbfHvjb4Ab0sIZnbIIUUmN7WG4YfmsPtx/Wuyk3Jnj5P4gH4EqA/HY01lswS?=
 =?us-ascii?Q?h71W1F10SOiaubjW4RPhe376X8Xk8+HNnNk/xieBGXRdmeZwvoqbVgGrCOPk?=
 =?us-ascii?Q?8nJlJdFKVYkvffiKoYTePyA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144A8EF8920246EDCE4B865F7209BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3161f847-31d7-490d-f6e9-08d9e10a3e3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 20:27:15.7932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fptpSa7gORJ9VirhHe7dXiC4Z+OD3Gq3y7CavrcG0umfewkS6eouMAny6oMyRU9wJ91JDZLeDmXvqIgV6JKSoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0114
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144A8EF8920246EDCE4B865F7209BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Should we set *flags =3D 0 before we return?

Alex

________________________________
From: Yu, Lang <Lang.Yu@amd.com>
Sent: Wednesday, January 26, 2022 2:53 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar=
@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Yu, Lang <Lang.Yu@amd.com>
Subject: [PATCH] drm/amdgpu: add safeguards for accessing mmhub CG register=
s

We observed a gpu hang when querying mmhub CG status(i.e.,
cat amdgpu_pm_info) on cyan skillfish. Acctually, cyan
skillfish doesn't support any CG features.

Only allow asics which support CG features accessing related
registers. Will add similar safeguards for other IPs in the
furture.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c | 3 +++
 5 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_0.c
index 4c9f0c0f3116..1869e2019461 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -550,6 +550,9 @@ static void mmhub_v1_0_get_clockgating(struct amdgpu_de=
vice *adev, u32 *flags)
 {
         int data, data1;

+       if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_=
LS)))
+               return;
+
         if (amdgpu_sriov_vf(adev))
                 *flags =3D 0;

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_7.c
index 3b901f941627..f7b9843b36e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -546,6 +546,9 @@ static void mmhub_v1_7_get_clockgating(struct amdgpu_de=
vice *adev, u32 *flags)
 {
         int data, data1;

+       if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_=
LS)))
+               return;
+
         if (amdgpu_sriov_vf(adev))
                 *flags =3D 0;

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v2_0.c
index 3718ff610ab2..3f5f326379b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -686,6 +686,9 @@ static void mmhub_v2_0_get_clockgating(struct amdgpu_de=
vice *adev, u32 *flags)
 {
         int data, data1;

+       if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_=
LS)))
+               return;
+
         if (amdgpu_sriov_vf(adev))
                 *flags =3D 0;

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v2_3.c
index 9e16da28505a..b23dd9ddfb5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -580,6 +580,9 @@ static void mmhub_v2_3_get_clockgating(struct amdgpu_de=
vice *adev, u32 *flags)
 {
         int data, data1, data2, data3;

+       if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_=
LS)))
+               return;
+
         if (amdgpu_sriov_vf(adev))
                 *flags =3D 0;

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v9_4.c
index 619106f7d23d..a2d5c8424e2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -651,6 +651,9 @@ static void mmhub_v9_4_get_clockgating(struct amdgpu_de=
vice *adev, u32 *flags)
 {
         int data, data1;

+       if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_=
LS)))
+               return;
+
         if (amdgpu_sriov_vf(adev))
                 *flags =3D 0;

--
2.25.1


--_000_BL1PR12MB5144A8EF8920246EDCE4B865F7209BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Should we set *flags =3D 0 before we return?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Yu, Lang &lt;Lang.Yu@=
amd.com&gt;<br>
<b>Sent:</b> Wednesday, January 26, 2022 2:53 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Lazar, Lij=
o &lt;Lijo.Lazar@amd.com&gt;; Huang, Ray &lt;Ray.Huang@amd.com&gt;; Yu, Lan=
g &lt;Lang.Yu@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add safeguards for accessing mmhub CG r=
egisters</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">We observed a gpu hang when querying mmhub CG stat=
us(i.e.,<br>
cat amdgpu_pm_info) on cyan skillfish. Acctually, cyan<br>
skillfish doesn't support any CG features.<br>
<br>
Only allow asics which support CG features accessing related<br>
registers. Will add similar safeguards for other IPs in the<br>
furture.<br>
<br>
Signed-off-by: Lang Yu &lt;Lang.Yu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 3 +++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c | 3 +++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 3 +++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 3 +++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c | 3 +++<br>
&nbsp;5 files changed, 15 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_0.c<br>
index 4c9f0c0f3116..1869e2019461 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c<br>
@@ -550,6 +550,9 @@ static void mmhub_v1_0_get_clockgating(struct amdgpu_de=
vice *adev, u32 *flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int data, data1;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;cg_flags &amp; (AMD_CG=
_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *flags =3D 0;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_7.c<br>
index 3b901f941627..f7b9843b36e6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c<br>
@@ -546,6 +546,9 @@ static void mmhub_v1_7_get_clockgating(struct amdgpu_de=
vice *adev, u32 *flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int data, data1;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;cg_flags &amp; (AMD_CG=
_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *flags =3D 0;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v2_0.c<br>
index 3718ff610ab2..3f5f326379b7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c<br>
@@ -686,6 +686,9 @@ static void mmhub_v2_0_get_clockgating(struct amdgpu_de=
vice *adev, u32 *flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int data, data1;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;cg_flags &amp; (AMD_CG=
_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *flags =3D 0;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v2_3.c<br>
index 9e16da28505a..b23dd9ddfb5c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c<br>
@@ -580,6 +580,9 @@ static void mmhub_v2_3_get_clockgating(struct amdgpu_de=
vice *adev, u32 *flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int data, data1, data2, da=
ta3;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;cg_flags &amp; (AMD_CG=
_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *flags =3D 0;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v9_4.c<br>
index 619106f7d23d..a2d5c8424e2b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c<br>
@@ -651,6 +651,9 @@ static void mmhub_v9_4_get_clockgating(struct amdgpu_de=
vice *adev, u32 *flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int data, data1;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;cg_flags &amp; (AMD_CG=
_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *flags =3D 0;<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144A8EF8920246EDCE4B865F7209BL1PR12MB5144namp_--
