Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687C6C83F12
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Aug 2023 08:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF04310E251;
	Mon, 28 Aug 2023 08:58:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83D9910E251
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Aug 2023 08:58:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcRbMbJQSHdcf3iXASvWinSSutSx1V/BHg08wh/KeJTkj/5CMMYszDhjbGHUw7KWc0ayqnADgEoOBEsR7rCTP+u3qOMfAqpcnZwEE44Yh3knCq4Olxx7UQYtH+VVHg8PNMjj86OXOvZKVaLnlceXK81B3JmG4PNDWEgclSWi3ycOYB+qsnY07ojsKEGeQZUxV8bLkm7kGQvxCpgIskiCzHqXWlPX+ITK9z47/Tb+uMwWwOy2XEzexbwB0635MWceoB0i2314Yivs+lJ/9EbiiPNrO1v7fpTO7pK8wu7KaYWRYnEQxPBf6gQTMMvSmm5nAnRXLroNg+HftxTuw7zkmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyANCNztwyY162oL1FzTXvvue5GTh+Yj0IaM00aaUYU=;
 b=mFEOJQd2IhUL7JY+ZO+14idAiCMIAfvuWONsgI5BronP9Lk4EkfDooQ8SX4TEFeRcGY597/4GVb/L0VVShShKGNTF9m+FKpSzy5bciS137QjEPqMr9N4BmgJzDQJPzs9lm25GrPTTnpu1vRuYtjOxmbf3cg2l0KRDEZTp7EzEW8Al2bt5eLgig0FXgQ0kq2BQG3STP4Bojjin+BYJ2yt+Zzxb6Scirg3UW3hs4BahXX8jaQNtDpe4SsP1l2LA0A1oOF7vr6IDqrgrZIYoZNBuTbuVYRdgPtMPaONWaHKSROARsymZ3HOVHCbl6mwDPQUjXbzZmSCohy08VpBUGNoMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyANCNztwyY162oL1FzTXvvue5GTh+Yj0IaM00aaUYU=;
 b=pDFsgT4V0mwpEjDiQ3hoiYrmPSuwtM+LJUfRn0sts6fMxQiq0erjNXHj5lSfHHulqxAfg/HAW3VV8wG6LA79Tis+s7INnDq2FtJpz019C1LHrEBOZEztTmYWj5/FJnYCf3MFuvpFLiP62bRnIVDYArEdYl9TZw2J8ZsGs86jeEo=
Received: from IA1PR12MB6356.namprd12.prod.outlook.com (2603:10b6:208:3e0::5)
 by BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 08:58:06 +0000
Received: from IA1PR12MB6356.namprd12.prod.outlook.com
 ([fe80::434:7333:42fe:6284]) by IA1PR12MB6356.namprd12.prod.outlook.com
 ([fe80::434:7333:42fe:6284%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 08:58:06 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory for
 gfx10 onwards APUs
Thread-Topic: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory for
 gfx10 onwards APUs
Thread-Index: AQHZ1uvvohHWYJx9c0OqJMFaLXkm2K//bUHw
Date: Mon, 28 Aug 2023 08:58:06 +0000
Message-ID: <IA1PR12MB635664DEA385477CF3996C8DC1E0A@IA1PR12MB6356.namprd12.prod.outlook.com>
References: <20230825003348.3978418-1-yifan1.zhang@amd.com>
 <20230825003348.3978418-2-yifan1.zhang@amd.com>
In-Reply-To: <20230825003348.3978418-2-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d3057fd5-2b06-4376-a9bf-a3371796b495;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-28T08:56:35Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6356:EE_|BL3PR12MB6476:EE_
x-ms-office365-filtering-correlation-id: 901e1595-1b2d-4cd8-cff6-08dba7a4e531
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RWSf+gRPBrVjQ0/VqbN29PC9JgUggao7nILz+qGJV+tIlqaTqn6WAy1y2TOoQh0miS1FAELOjO3DiLfDdm3vz5rzbxZG+PsDwOU/a+ulbhvZ0Aa2kxI7B83rlga1hwguxO6nlNPBHNv6VE78yiJ5Y9qKtQQVGt0gnbXLBVN/P+WoSQyAma+uarvyNHl0tsL9+/4wWSmR4aPs1bdx7/inhXXW7Ofpeh1Hs0V6WNHgvNByfEJoZ5xY287vHwdNLp8Rxtru48tjbF7kSKhldLylkXtHJ5zJ46UvmIkhjysh2+1TpxP4FgtRJErPU3Tr9UyD/53g6L9q1zjTgM8Ej3Uio4z8iHzxz9NrXFtJsY7A5XDddmhKSh7R3mRuEci8BKUWw5AQdWpVw7pjhmydY4Cf1pMLY0kkFv3cVNNxkrmmMzpuEg37hC3fcfAiM0qWtEWyuOi+Vbl7tzdiY24BZXoh0eMGb9AH3h6TzfHnQeKmj4sy1it6XkkMmKTsRzRWaFqaZh+PAvCjqE5l4QAQcIE+V25E25KAZ39RLhiLWPCfQXyqD6IHQ7Jbt+eZ97DuWjnJ5tU4XKhJQkAFCU4Fj+mSKy1xesxOh+8vJrQamVi1ZqhbmiaCgGXXRKEfM8vfWBpq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(186009)(1800799009)(451199024)(41300700001)(122000001)(38100700002)(38070700005)(86362001)(478600001)(83380400001)(71200400001)(53546011)(26005)(9686003)(7696005)(6506007)(55016003)(76116006)(54906003)(66446008)(2906002)(6916009)(33656002)(66476007)(316002)(64756008)(66556008)(66946007)(5660300002)(8676002)(8936002)(4326008)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Ot2payeFwxVa82CMzsDRhyAkdZ3llr7EiRjAwbFn9rkHRP1TVABGy50QcgB?=
 =?us-ascii?Q?NY6YumiqE5725x6PSKZyB2Wh/y1L4FWtzzC4euvSa/e1S65WtCSRQH4iIdUs?=
 =?us-ascii?Q?yU3UT6ZLCCGDcK2uUpcalyQxrkijR1FkKQ/eUOVLffX3Sc6XJkNNjABaSKaZ?=
 =?us-ascii?Q?SXMlDY6u2K1i+K7GKwBn+xf+bgcYzev48t6ERarga8mvoOqjqVohcxCrnwxM?=
 =?us-ascii?Q?SIgN+ai+ldoWj/KW1ZZw2XU0JmlQl9qxz6J7Xcs+dnwShfsRSWPmxwrAxW8R?=
 =?us-ascii?Q?on1OD8ktybpPqCctG/wn3gJT/BRXUannpwnHUZ1VOVo1qcZiWF6ORL/n8g/4?=
 =?us-ascii?Q?T8diug/ObGlC2V31BSFOlrs0EK6K7yfSUTjYneQJiK35KZSiBNCXDMf94Px+?=
 =?us-ascii?Q?/GFnUzixRImapZesIfcwxUNcEu8B26qmYlWlYEEP4qBKqFmHTJ3hstN70hE7?=
 =?us-ascii?Q?aC6GScHwcXgzmhog7eNmtRgLJ1Y4CyNdZyr1dCIZlYu0oalsHNtxbsDE38e6?=
 =?us-ascii?Q?RVUnLrUEhhp2EolOmZuMKv65hDOregx5z2dNwvZKIvYOnE1PDQLUYnCyDzDL?=
 =?us-ascii?Q?3Mfkz6CBNUXAy5jtY+/8SlOJ1zSpbXtFXIlTCxNOcYnjStzogYhh6MBzfp6G?=
 =?us-ascii?Q?7tOq1gUVGe3OtVwFlTrdfX62eFaR18V/ua3E8M0rMA2jfSHbilfDTUM8MT3v?=
 =?us-ascii?Q?L04g8lTkh/0svZdJ8z4PiPKsKeubmP3HIQp8t8n+4bpHaud5t5YYoOUVIU0w?=
 =?us-ascii?Q?I+KJfeb02eTXHsfYhJBBRuoSuWE5LZ3ARK4CqthcazOc0OWVYlZZbjByBOXR?=
 =?us-ascii?Q?RD1ddBdlb4CCWn1yWytul1tLiNDYBh/jTJ6UxCTu1hUzofOT1HC1vXOIO890?=
 =?us-ascii?Q?5rYlZPxFWLhJeUbv1zVZGrQNrZ6AgahO73SEiUStLWOiCn1BNunhWoxhNrnd?=
 =?us-ascii?Q?NCtxUCQTMkxsmFPozTCVZyU1qdRV4AdjnK7BVgwca2VFPuhvmAfEsYAcHw+J?=
 =?us-ascii?Q?9WH8o8KLXyLWi2ClWEuXKrOhMR8Rpq+SdWbCprhdZsugwqqyZXdlzceYBIds?=
 =?us-ascii?Q?7wMRH3APvXJzW/hoyRtaiY9IeFrfJUZu2YD0x6uXqm9+FVNxnlTlpaQdQeB/?=
 =?us-ascii?Q?gTMwo5Bzf0UNwka2jKVqphCW/PQxOn+G2CV8GD2Fh+nHOAITXFlJjaYUsalp?=
 =?us-ascii?Q?Ws6vY5ZIR2z9Pm19/naL2CVzq8ExwcJcBRkKcrvrgd/DJif80q0Xz+PsLCk7?=
 =?us-ascii?Q?Guk2lDy3aMtNK4NAzite6633kfLKRaQstqacZF+f7YHVFmvg/NQBQDRHmnh3?=
 =?us-ascii?Q?2sSSfAWaE69eRgVbnB7FZ96203nlemLdp8NoIu636kRxc4ZzsrHGhacjPQs0?=
 =?us-ascii?Q?nH1z38Mp8Cwgt3uUQn9z/y96gYKlraAB6aAacpjNSZLT/9O/326epRUR1l7w?=
 =?us-ascii?Q?RmDG1UJ1cUxnJZ6TtRzEQVrdWx3U9Pc0BylwkcYSBV2IdEPSnHx4xjwZCQt2?=
 =?us-ascii?Q?jGLyKrgK3EmucZpLgV2FRGnnREDwFrxHe/7vz2NIks7Wlqj1d/zv5Drnv89L?=
 =?us-ascii?Q?MAfrk2nCDGQ///SyeH8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901e1595-1b2d-4cd8-cff6-08dba7a4e531
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 08:58:06.4238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OEnmbDZbiddih4tLgGs/EdGiOE+0T3/tI9KL4yVtIw7HSuXnYCynVgev1mpcyyKc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Ping

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Friday, August 25, 2023 8:34 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: Put page tables to GTT memory for gfx10=
 onwards APUs

To decrease VRAM pressure for APUs, put page tables to GTT domain for gfx10=
 and newer APUs.

v2: only enable it for gfx10 and newer APUs (Alex, Christian)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vm_pt.c
index 96d601e209b8..4603d87c61a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -515,10 +515,13 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, s=
truct amdgpu_vm *vm,
        bp.size =3D amdgpu_vm_pt_size(adev, level);
        bp.byte_align =3D AMDGPU_GPU_PAGE_SIZE;

-       if (!adev->gmc.is_app_apu)
-               bp.domain =3D AMDGPU_GEM_DOMAIN_VRAM;
-       else
+       if (adev->gmc.is_app_apu ||
+               ((adev->flags & AMD_IS_APU) &&
+               (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 3, 3))))
                bp.domain =3D AMDGPU_GEM_DOMAIN_GTT;
+       else
+               bp.domain =3D AMDGPU_GEM_DOMAIN_VRAM;
+

        bp.domain =3D amdgpu_bo_get_preferred_domain(adev, bp.domain);
        bp.flags =3D AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
--
2.37.3

