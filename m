Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0A5E9E30C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Feb 2026 13:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D96A10E5BC;
	Wed, 11 Feb 2026 13:54:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a0GBh8zN";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D987610E5BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Feb 2026 13:54:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCeKThYsTByGzFpW9xKojYf1/HQylF6kbQ2k4ljKKR3fqyjFhNVqWbKRp1UQtld7ZFJys+q5B+WzNbHieC+06Og8nXJUp5qWPkjpZttkj2kGWNxOLzUOafPU+hktEqz8/H60p/DMIA4aeAz5J9P8iQQFjOhioj3EyOP3FSRsZ+Jv3EzAREjl9ZWJjOuIAsJuQ8U2WDM2+YIFpGNhoQDRl1FY56UIOvnj/hP+v72iHy7tMJRg5V2XgItzk23W3ejxqcjw0W2plgbWjWKeYOB+ZnTXWWwYYFZ3f/lqjqMO3oA+xCjSxIKBXEL9zSWXhhoHDKxLPrTCF9ke3nbvZzBQfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fcawI/eFwlmW6P2D6iacOBklW0bE/1W5rSMztq3As0=;
 b=b8xgJ40bOJPhvmPU7AAYeOEu4v6QduLiYplHHdPMPPBYC9+TLcgfA4yATIUVVrLQfeYyV38SOcH6ggs7OBc7RYljhQvchTMrrMndVclR3I5rle/3yMbaFDPzU0G0Fy5689eR7vgwba9xs3dYj1zIrYqk1g9gmbm+vBEtcWVm1UxzLpArbwxZskWPXgA2tq4ChvIiULI603ZnQSOYbFannWQvD7/wxu0zmISusJxG/UFnOingO3q1ELrLjts2jmluLSLKlX28B79tganMc69EpgwZ2kmRkv+ZYkJI6wqfkhQYpVI/TivA90hMUwuG1Z9tWZOIkm3junkr5TB5/WkJ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fcawI/eFwlmW6P2D6iacOBklW0bE/1W5rSMztq3As0=;
 b=a0GBh8zNT5IbON9ojDiAxTIJx6NqnsHbkeKXXJZZwDDbqTjS9DyGAA9jJtaFnEho/iDrBNx7ZTLsZCInKDsOQvLBPsmlJwcTO+R11U7xlYCh3rHgywtt+5nDdEwesZkd8a38VW5kr+QlCNP35f4I8D1uXqU9bjYZJKB51YtReOU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 13:54:50 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%4]) with mapi id 15.20.9587.013; Wed, 11 Feb 2026
 13:54:49 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gadre, Mangesh" <Mangesh.Gadre@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amdgpu:Add psp v13_0_15 ip block
Thread-Topic: [PATCH] drm/amdgpu:Add psp v13_0_15 ip block
Thread-Index: AQHcmw2XR7uZ/6FVgE6VSXpg4O9qarV9hb+A
Date: Wed, 11 Feb 2026 13:54:49 +0000
Message-ID: <BN9PR12MB5257E75558E923E4AEDDD554FC63A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260211041842.2136714-1-Mangesh.Gadre@amd.com>
In-Reply-To: <20260211041842.2136714-1-Mangesh.Gadre@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-11T13:54:22.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CYYPR12MB8989:EE_
x-ms-office365-filtering-correlation-id: b35d06f6-d9b2-4955-b622-08de69751fcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?VhLa9mc9A9v0OCIfROWV+4c7k52sba9fo+ThUlrATsIXupCcAsnNd91jD1zq?=
 =?us-ascii?Q?KOMkpKRGrzy6+I+qHGR49wh4h6JIR36xVsN/ktiqWCtv9Vo4P7AGDpEYfbut?=
 =?us-ascii?Q?Xdon/1UZhg0MmTmJcglxemh83RYa34NH81Bq4C0GfxGW01kM90xayohf4Dxy?=
 =?us-ascii?Q?D7URrAebrTIq8Kv0IjYaYIAcuILMT9axNA36YC+KPcgekmDE5NPjg/RLbZGd?=
 =?us-ascii?Q?xZi7p5Q1wRbB4jE/c6UYhHaDoOXuv63OsBVQA97LjwmSBwXrYWZfoA8X+h01?=
 =?us-ascii?Q?LwYHOyb5+dC/b5yR96enRw3n4gFNzXefLRqn7a29F4bu1r37XJapzfTR0+9H?=
 =?us-ascii?Q?bZLtV9+Ba07t+oeyld1AhVrEu2cpN/lngLQtXN+FvWw8MsBxJ70zDefLB3/c?=
 =?us-ascii?Q?1EJtOGkkOi5xLLl5k3QqSE/+tRLw5dLB0j3xNgpCUSiVdx+vvaJaHwnOkCj8?=
 =?us-ascii?Q?LHm6ogvYRpZVe/pl/XcrC1YoyWDkrH/PT2jahHRZW+4sYhYM4GD0VhmS1Jc9?=
 =?us-ascii?Q?vdbd6XHyqZDTGvVyBNu/mA2fOMtBJVu/asz438aJM5OnB7A/3KG/uPFbDy53?=
 =?us-ascii?Q?CrrcLk+KmVNiW/94Nyh2uGFWskMHah/G6ITTww7nWFvy0/cyIX5tEiGuBJVC?=
 =?us-ascii?Q?N+r0JTPD8azCu/f2FFynbss5NWvn0iHkpXIxGHla5ikEkwsLPkOFN/x+v97O?=
 =?us-ascii?Q?/FadAu4/vAY2s1f7mLvzdLZnSNdaNJ/b/oNrdDjeQlfeD7xFUUDxiY7vyYXN?=
 =?us-ascii?Q?fuasvXu3Ot+F6XGEfqRZtHxm8owW4nPlBk4ZOQiG/QhzfEB1Lcky9y86RgtQ?=
 =?us-ascii?Q?GOx63g3WaKmPA6AI6ntiaP1ZIfiJGNTQ2LIU9szxjP9Bf/NWocmYqHJsWXjm?=
 =?us-ascii?Q?OXSvdONVDE5AG9MIaPe2ZAngRuSgnELjnku9g+Z92dIaxSRcL34yLNDIZp4G?=
 =?us-ascii?Q?eo4I91hJz4oVuipZyeMcASblO96xVsCc/49VHBnBdhyXXwRBHwFwnsnoFDgJ?=
 =?us-ascii?Q?Nby4rEbSri4ZTMV8soPS17Fepub3QitcZXD8xr8Ok1CThH1pLl1DgVSbQ7QA?=
 =?us-ascii?Q?8A3m1N/rW5z7HmuSYYYu+bIAsOOHUY85TBaWX7q0nsQ/naquECTLMNEbAB59?=
 =?us-ascii?Q?shkhit6iTWLd0Vr069lI0JxLSMAgEeBLSErtowobNIvuv7mjPMlJvp7RlCem?=
 =?us-ascii?Q?DUkFaJfOdOjsfByRxUvA07a1I/F6in8j3K0yr3B5Pg1MBkGUZQDobK40iuwf?=
 =?us-ascii?Q?gPnHXeO3GVSfDM11dx1kMYKUI4/QlbCe+OeD1U2gPVqWKVER6Mk7VDc95gAn?=
 =?us-ascii?Q?7cCXMxg6NTJPMJuzukkyyx9qcFuRy+mLiBce2ZlMZnVuEIc3m2eD2daSycb+?=
 =?us-ascii?Q?0wGkPkdhJl+mr//0MMRMsYbhT+TEDXkEBKFmYCSvBtWRJH/oBEShr2X5o9NU?=
 =?us-ascii?Q?xUxZxeeEU6bK5xauH4NKlX5u+3yGJbNzWeB+U8tP1yOhWe3ffS207aa2DGBv?=
 =?us-ascii?Q?bvy1nas9ExHWUBO4C3j53gDEyk29a64oLTk5Wa2gzPa38gw0AYhqNOw0VLUY?=
 =?us-ascii?Q?ugEjbNUw5AcPg+D5/YriB+fAorbDbpjKa61evzNOwN3+W0U6UChAoLVrka3/?=
 =?us-ascii?Q?Ik5CWrj/i6EnzCkdw+iDIXk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GmFVuhOkh1Co7+GZ+Q834xeW2d43Jx333fpxvPy+Gz53sPycmgO/fDQQ9tgi?=
 =?us-ascii?Q?XMEVMx8PbzfXXpujsOnvmipeQgT5nPZhlPOVgrD4p6vtx/0Z+Rle2Ld1+mmb?=
 =?us-ascii?Q?HGfsUsRt1ERPccO7ykOvyP/mD374Ay4baJWO8QrtOKJa3CxfGgcRl94MECmc?=
 =?us-ascii?Q?jgalt/6l4o9kT8U7uolF+KVnlcfkwxVjiaDyc6vb7HGOIB+7rprjIQk/bnSg?=
 =?us-ascii?Q?MHhhTjeN0hj60x/l5kjqqlzn5VTIKGdKuGMOWEqVzFMtoLKFylNnfQwB3eQp?=
 =?us-ascii?Q?y/QE7kwy6trFXgPsqeelfX0rG0ZabI8dJIKkH6gJdpZaMzu+bkM4k2qDalrI?=
 =?us-ascii?Q?Y4hgmL1gIPPuWTA77mcDraV62PxIuNrZqXgK9fRoujWXpHuYc5ypQB7l48vc?=
 =?us-ascii?Q?JLFWuecfAKxfwgVZiKpMMiPWZAQBH4UJRihIHy1AXmAf6ySAYNQwXe0L8YnP?=
 =?us-ascii?Q?vg884hGDMPcg3o8pKnuprf505khyVxgBScc2mHkR2j2hgSDESsLr4T68Yb3p?=
 =?us-ascii?Q?L1CXJocQsDzdpwOTRwe8TryBRjdDd/BYeZqP3vZQNHg06F8oY/3Cmq8B8yi9?=
 =?us-ascii?Q?9q6TBQOD8IeqZS0hhvYTw0vctDQp7Pgak9qOCykPfqz3B3FVIZJLAdISvYof?=
 =?us-ascii?Q?vwsUuZhms7jeaWnK4gJRx3B5Sarj5sMDlmN17xJ4rgO+oG7cvwaA1mut5igR?=
 =?us-ascii?Q?mLgyL+ncEfIRMRhFtGjNUy3Ot7QTHLjx02Ezror+SKXe5u/vfbffSMnMhnBk?=
 =?us-ascii?Q?5v15iuJd/DA7Ho4KQCpO+a+zU8ROqeXtXBs+q10OiP6RM1XAEeGHlndoElVS?=
 =?us-ascii?Q?ATjADGoMskG27Jgb8pAiNUR+xUStvu91qryIn7QPD1ki4NVIjI+gp1tCaMy3?=
 =?us-ascii?Q?8Bx4jWKBK7JbavklMUpblp2utFwU3CNKUhtBHFAN37lYYG0QuKvnDtPvW2l7?=
 =?us-ascii?Q?1or3/w1Yl/NfwJM97jy9wD6w1qF9+DBpruMFhA25SQyPRMb54E0z2/bg1n9I?=
 =?us-ascii?Q?tGpf4cKG98loLnWloDWGOuTXq7ZN5CPTfynl1tw5CWVXYvFF1VK/Hlw+Ww2n?=
 =?us-ascii?Q?Y/tSkJYW7SDFKJcChG4ad0m+W5zIW14thiv2QnSIF96CcmHMeBNWGnKyHBHB?=
 =?us-ascii?Q?qBlpTO1tR3DiHzUrBriiVk1i5PwORPIQXuOQDXIcl1LQCMscgpG2hmdwEAOb?=
 =?us-ascii?Q?kDPxJA0TxDmdnRjrgJjJ1lwLa8UTQp0sheicFFg+ijBLtR4Qz6mfNCP1DGn5?=
 =?us-ascii?Q?WWRxSB7MxI87FMZDqrZdP/e+d26C6SlZpPrFLCPQDycdgVc8EYC0r9yIz2Fj?=
 =?us-ascii?Q?f+74YZkgXFG/+iSa2tnpKB5Ww6RnydE0pLW26nKzz9207u5ujx6WecTSL2n3?=
 =?us-ascii?Q?1EPIWjEte2WjeOOEDKjWMnG2gygahMgspLP/4BCKLmCSv5/lVoqe+0MLWOpU?=
 =?us-ascii?Q?MstY2yifqU4LCbQCX6aIwapHAy+WnP1Pwp2jE2RUNyBIUnPbWTypyWKgZZU7?=
 =?us-ascii?Q?HR6hzvFt5skVJMWEV5/YMfOq/34H0SyQhv2zjZRo/DVFmqzRyg4u+XktR+TX?=
 =?us-ascii?Q?m9dh4oIoc+UoTIXWlGIEMrm6+IQPNWQziryUPWPh4FLZUr7/GpFw4h1qpkpd?=
 =?us-ascii?Q?6DsTUyRAQnfU1hmA2Ww5TDHfSiAT7RsMIguuxnX/0o1P7dsAyPo0Xxmwq/l0?=
 =?us-ascii?Q?RyOMfNgSv1H2ektOllqGO5Cssf/FvCi7+3ursq+v4Lj28tjt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b35d06f6-d9b2-4955-b622-08de69751fcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 13:54:49.8402 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kLDxn0HT5s3zlvRBHAPZUmlmwE1poCetQtWpQ/ieZvyJaHXZruOc4GE2tcoFEYc6+NTKaTebGWjBpfMozENJUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gadre, Mangesh <Mangesh.Gadre@amd.com>
Sent: Tuesday, February 10, 2026 23:19
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Gadre, Mangesh <Mangesh.Gadre@amd.com>; Kamal, Asad <Asad.Kamal@amd.com=
>
Subject: [PATCH] drm/amdgpu:Add psp v13_0_15 ip block

Add support for psp v13_0_15 ip block

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        | 15 +++++++++++----
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  3 ++-
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 41e63c286912..0d369462496e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2164,6 +2164,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct =
amdgpu_device *adev)
        case IP_VERSION(13, 0, 11):
        case IP_VERSION(13, 0, 12):
        case IP_VERSION(13, 0, 14):
+       case IP_VERSION(13, 0, 15):
        case IP_VERSION(14, 0, 0):
        case IP_VERSION(14, 0, 1):
        case IP_VERSION(14, 0, 4):
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 5eeea965032a..a7c7b378c696 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -148,6 +148,7 @@ static int psp_init_sriov_microcode(struct psp_context =
*psp)
                break;
        case IP_VERSION(13, 0, 6):
        case IP_VERSION(13, 0, 14):
+       case IP_VERSION(13, 0, 15):
                ret =3D psp_init_cap_microcode(psp, ucode_prefix);
                ret &=3D psp_init_ta_microcode(psp, ucode_prefix);
                break;
@@ -219,6 +220,7 @@ static int psp_early_init(struct amdgpu_ip_block *ip_bl=
ock)
                psp->autoload_supported =3D false;
                break;
        case IP_VERSION(13, 0, 12):
+       case IP_VERSION(13, 0, 15):
                psp_v13_0_set_psp_funcs(psp);
                psp->autoload_supported =3D false;
                adev->psp.sup_ifwi_up =3D !amdgpu_sriov_vf(adev); @@ -383,7=
 +385,8 @@ static bool psp_get_runtime_db_entry(struct amdgpu_device *adev,

        if (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 6=
) ||
            amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
2) ||
-           amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
4))
+           amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
4) ||
+               amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, =
0, 15))
                return false;

        db_header_pos =3D adev->gmc.mc_vram_size - PSP_RUNTIME_DB_OFFSET; d=
iff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/am=
dgpu/psp_v13_0.c
index af4a7d7c4abd..d1e1a4369521 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -57,6 +57,8 @@ MODULE_FIRMWARE("amdgpu/psp_13_0_12_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_12_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_14_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_14_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_15_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_15_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_0_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_0_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_1_toc.bin");
@@ -121,6 +123,7 @@ static int psp_v13_0_init_microcode(struct psp_context =
*psp)
        case IP_VERSION(13, 0, 10):
        case IP_VERSION(13, 0, 12):
        case IP_VERSION(13, 0, 14):
+       case IP_VERSION(13, 0, 15):
                err =3D psp_init_sos_microcode(psp, ucode_prefix);
                if (err)
                        return err;
@@ -156,7 +159,8 @@ static void psp_v13_0_bootloader_print_status(struct ps=
p_context *psp,

        if (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 6=
) ||
            amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
2) ||
-           amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
4)) {
+           amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
4) ||
+               amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, =
0, 15)) {
                at =3D 0;
                for_each_inst(i, adev->aid_mask) {
                        bl_status_reg =3D
@@ -202,7 +206,8 @@ static int psp_v13_0_wait_for_bootloader(struct psp_con=
text *psp)
        retry_cnt =3D
                ((amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13=
, 0, 6) ||
                  amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13=
, 0, 12) ||
-                 amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13=
, 0, 14))) ?
+                 amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13=
, 0, 14) ||
+                 amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13=
, 0, 15))) ?
                        PSP_VMBX_POLLING_LIMIT :
                        10;
        /* Wait for bootloader to signify that it is ready having bit 31 of=
 @@ -232,7 +237,8 @@ static int psp_v13_0_wait_for_bootloader_steady_state(=
struct psp_context *psp)

        if (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 6=
) ||
            amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
2) ||
-           amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
4)) {
+           amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
4) ||
+           amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, 1=
5)) {
                ret =3D psp_v13_0_wait_for_vmbx_ready(psp);
                if (ret)
                        amdgpu_ras_query_boot_status(adev, 4); @@ -872,7 +8=
78,8 @@ static bool psp_v13_0_get_ras_capability(struct psp_context *psp)

        if ((amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, =
6) ||
             amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, =
12) ||
-            amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, =
14)) &&
+            amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0, =
14) ||
+                amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13,=
 0, 15)) &&
            (!(adev->flags & AMD_IS_APU))) {
                reg_data =3D RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_127);
                adev->ras_hw_enabled =3D (reg_data & GENMASK_ULL(23, 0)); d=
iff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu=
/soc15.c
index 54b14751fd7a..4e037a6978f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1478,7 +1478,8 @@ static void soc15_common_get_clockgating_state(struct=
 amdgpu_ip_block *ip_block,
        if ((amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D IP_VERSION(13, 0, 2)=
) &&
            (amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D IP_VERSION(13, 0, 6)=
) &&
            (amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D IP_VERSION(13, 0, 12=
)) &&
-           (amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D IP_VERSION(13, 0, 14=
))) {
+           (amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D IP_VERSION(13, 0, 14=
)) &&
+               (amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D IP_VERSION(13, 0=
, 15))) {
                /* AMD_CG_SUPPORT_DRM_MGCG */
                data =3D RREG32(SOC15_REG_OFFSET(MP0, 0, mmMP0_MISC_CGTT_CT=
RL0));
                if (!(data & 0x01000000))
--
2.34.1

