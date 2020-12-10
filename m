Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E84DC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 04:14:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E78DC23142
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 04:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78DC23142
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 503116E82D;
	Thu, 10 Dec 2020 04:14:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D76DA6E82D
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 04:14:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsPJO96tSybTXhfWWvCjij5a5GT761Rk5b/vOpooxHoNMTqwLeHS+dS0rZzSDCrYUiMGR8Lab5SS7EkFyc5aQJyKu4WV77aoEcQIWGXNSbPRAaI7VPCwV/TD6B9ZR24xdTjLCQm0jVtvDB1EieN+ak2dXCIiYF/sZQDfsZwPu52wErZ91OLwJLSYefG5UyIZ+a7P3QQqsnM6xIN8p9imoTh0WCWcVFKmT0k1F1tVzxaSbubxEhMFn3+fCsM3TU1TjIfAUOF2PyYzhuesEs5kzUTIRZKyj8dOzmOZu9nqm38gXoyGYq/q1L9CwFr8Gs9C8jzTqV+mx6V49mM9gIKi+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZUGIMoY9VSnqPse+0lqE/Zq0AqJ7jHhSfQt38sIkQY=;
 b=SbZobkxSld+mNVc+ZRAfEtGgkLZtAiFewzCYZollTrB5cygUjcj6UVIRg7PTZac4lP9cQ9W9vsUaA5dJBP/58kRuoo0UMINlxOp471GT5h7vBW+e/2qdH1rg5F3D36knux9a1f+VCS4btWq/pa4yY5YTLqblqpAivIL/yfFktbxDvD1ROQBbTAAInosUN0v4PXoHhtN7+ubTQdmw3qh/FH5pVqqJnflegoMbCBLmgEApDR3GnJIUvBLehBnf+Sw4GWmJ2/SMJ73rgVXZARkWonflTiDqNw/3o3TQzQyYwg6eX2BjK08c49PU3dwrz+5EFO1+K3apRgtn+76khz01xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZUGIMoY9VSnqPse+0lqE/Zq0AqJ7jHhSfQt38sIkQY=;
 b=lnyyCrAOURyQEZ3F5De44FmC3YaSX27XZ1q4F3Un3GTFmbW1KcSoZQ3Bz/jWb4LV4km81KDT+oDs1kKtoIePKJa4YFA9o7KYivZuK8ZYIIm1hW1SGgmOBdiYN8FRWLaluID+387u34RZFwOD8LOq4dn1NyzGBB2aL1Ea5gKmIHQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2985.namprd12.prod.outlook.com (2603:10b6:5:116::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.19; Thu, 10 Dec 2020 04:14:18 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3632.021; Thu, 10 Dec 2020
 04:14:17 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove leftover function declaration
Thread-Topic: [PATCH] drm/amdgpu: remove leftover function declaration
Thread-Index: AQHWzqkPkYuWzZtNBku6nHiaWhKMY6nvuHYg
Date: Thu, 10 Dec 2020 04:14:17 +0000
Message-ID: <DM6PR12MB26191A0CAFE8EE2B87D94F39E4CB0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201210040043.246672-1-alexander.deucher@amd.com>
In-Reply-To: <20201210040043.246672-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=aba4f923-8310-4331-b873-5b5bd9ffdc09;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-10T04:14:03Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 33e31782-860a-4058-f818-08d89cc21008
x-ms-traffictypediagnostic: DM6PR12MB2985:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB298540C894077A53BA66E49BE4CB0@DM6PR12MB2985.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rfqpvGn6Y7DyGcB9Zs1Nr/AMrmcVpstfI/i/1FDI8SzXapn/w1xU8CkYoW3IC2gvx1A1tjuqD+j1MySzYa83wyVYptfplpsaCamzswtSKc41Sz4/EZv62RwosfMGOUTacGQYCsJWMdpxC/yTqFB1SKK7GEKrP4HZz2bA51tT0i/DX4Ni9qphn1p79cLkrtaQWhpKFN4xT67dImNhdaS3f2tZYG9vzeDC+TVq9mHD7DFY4J/RWpT7vO6LXHIU9EY9wvC7Lx+yi5GQmFzzCYFbupl7oEjVsI2eZSm2xgpN8Ci6/gPvnOdok4Uv15SDB12C+CD8HT9O9U61V0BZPozW6hYFqiDGCsEM+gjBbLSgD80=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(346002)(8936002)(55016002)(186003)(8676002)(4326008)(9686003)(66556008)(66446008)(64756008)(26005)(66476007)(45080400002)(66946007)(2906002)(76116006)(52536014)(53546011)(6506007)(86362001)(7696005)(71200400001)(110136005)(966005)(33656002)(83380400001)(508600001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nAEZJ6+0NweZHrw+I52/C4F+igBbP8H74kU1q3S4GizABoUu3N+D7PbPQ79P?=
 =?us-ascii?Q?8+yYHYcYHE+4s2q/PZXv9xifw+U4TkCpxxBH0uIfYn5yL76PHz0lzds88bw2?=
 =?us-ascii?Q?w+U3v7ADk+n4ZWnzq3iMw4k8joyOlbf5NVfekAKtkHq2s9eMMK860UZId90v?=
 =?us-ascii?Q?qGIk9AZqxyt5TwcXoj3qZn4iM9HI1mJ1/MyeAMRilQIxqVZZ4d4JiB3znAmd?=
 =?us-ascii?Q?i8j6zLYVt5CHlwLQAFchxVujaCwheIMbLhvRL5AaRIlVpRDjuTZh9JPuuPvi?=
 =?us-ascii?Q?MQk/DSzd46iu7i+erntb4ck9fpz6Obs1OcH2to1e59jCtPceU3dve6ClFbVS?=
 =?us-ascii?Q?qtdWZmjg5bBl29L9n1zlX5kV51Y/ck5XOCgvyEh+3YhgpBV0fevPTBMM1GSH?=
 =?us-ascii?Q?lMChNa0bbILK7S5/e15O0vksmf3bGLl1nTWIBbOmI27u2kyX2byKlS1eJBIp?=
 =?us-ascii?Q?yCtaeHxCRK0Oh6rZChyYYcp91Sfqb/vvEc8W0hkLAByCf7OcrrFNYQw1Bz8B?=
 =?us-ascii?Q?4iJDmOHx/LaTDDLzJhyMqvxy7+2Ia+BY2NzMR3cnvkoads9sdkkzOjP+RPVp?=
 =?us-ascii?Q?LrdWHHrVj64NGlTYh36PE5ggkmKLP3fUfDn+g79IRZL1shCdudVOiqE28Bc+?=
 =?us-ascii?Q?dm0PzbgeuG/D4/3hiBwQ1diBy51RYV+EYG3rxtrlcRKXoHWYJCNxeeX5i6q7?=
 =?us-ascii?Q?zgOHdxqCNGvFNEo6p2p5r6axN49WzVexEeU9Gc1ySVG8cJj5Oe0EFQrpho40?=
 =?us-ascii?Q?wreEoYydQREw3W13WF2N0fg92d1aLztd0hK0NVwPonMWbGEBGI4Akz63UGkz?=
 =?us-ascii?Q?Kp9DJ8SgLcm9ZuKfj3BbeSgmtb6Z6UrVCVLIyZ1w36/hJgTuV9f6upGE7xfM?=
 =?us-ascii?Q?dA6ZKwVpFR1KaTr0FZS+TxuLi0e7mg7vXOLpkkuB3Vb6Be9SraZ7l7Kw5zYy?=
 =?us-ascii?Q?LR4FjK7xWeKR/dS8FYuF9sZHbYWeU0Rdn0mAz4JeYK0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e31782-860a-4058-f818-08d89cc21008
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 04:14:17.8587 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +lhHOCKxp5NV94ebG9E284kv992r0FKk6YvzRsNyhcDOoGTOL1GyrYkZqnJlPq+A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2985
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, December 10, 2020 12:01 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: remove leftover function declaration

The function was removed, but the declaration was leftover leading to a warning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ab92ce307731..877b2209c901 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -196,10 +196,6 @@ static int amdgpu_dm_encoder_init(struct drm_device *dev,

 static int amdgpu_dm_connector_get_modes(struct drm_connector *connector);

-static int amdgpu_dm_atomic_commit(struct drm_device *dev,
-   struct drm_atomic_state *state,
-   bool nonblock);
-
 static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state);

 static int amdgpu_dm_atomic_check(struct drm_device *dev,
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C241bee6623394473d63608d89cc030bb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637431696556600762%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=fCRGYXh1dPdpb%2BXwD8XjR5H1pEI6iPdIcd%2FfbfKVjO4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
