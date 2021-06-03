Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B7BC47096
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACCDB6101B
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCDB6101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63C8F6F4B0;
	Thu,  3 Jun 2021 15:22:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B80AE6F4AF
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 15:22:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9D+c7IuBxRJGV0mA7VF4XDiEyqvIFkj4lWslMFBXmvgy3RR/JTj0E+M3UyQnTJgsXDj893pVB/kj1NK/d9BX9TVMp72aF8RdqqaUtNGc8W90tB/jDriP8IRDzaAefOeoJzBa8EAOUFXqSieBxRR3ap6EZ4Uwy57m/J3J2/MPyM0Wm5QEsWxbzdGJDReSHhplQ2+nbduN1YiE6pvxjbDsO6xbV65YhtCCD5wyFimKG6hdDc1Cj0Tr78CX3oCw7ajwt+ETWLGsV/jvjpR30c7ASxf/dVbYFyrPym6pdLutFZbnC6IJh4in5j/DY+HFAr2bsHtPd53nvWr/DM8Jecpzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAtSyplC2GxvkF4gzbDkL2h4UTsT48NKPRDnhgTrBwc=;
 b=jtE6ExJdIjUKcVtIU3pyZAaVvdP5QFDcIQYVbWYGKO/bSAhx/oCzJBeP5HzEfzGJ09lxWzdp/sAlpIcLIYQIiFvaAu2sh9xwFkRjKLSs6Lnd3rVuGafhD2sKMshRuLJtFTOHFHwmxlvigQS4BxUDH7RDOOS7qDEV9LUYWe41CGS/FodVDmbBROOrzkfT01M2uswzI72gnRVk4pgdyN43LqiLk+wUTg1eC03Z6l2Yrt/xQrxOdMjMqXyZKp5esYxHRwvM/E/vubgfqTD9GIrGL6wk5BxnewxV+Ojenrs9FirYi6SjGqzCqVFi9ArEWT9n1bBcAuFnl9hGwlMlZNL6cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAtSyplC2GxvkF4gzbDkL2h4UTsT48NKPRDnhgTrBwc=;
 b=B/4PACXPv8uU5FJe1of7aPBZIbmT+1q6b/9AE+ViCgZEsL35nCTrAbBbE6ohrl4B3Tw9TuXWKDoIwj+Upl1OwTdYtwg75+fIu3DGvoqoWTklEHb0vM9p3bSnu2bttjPaV0phDdvLv71ZpzUqDeQa7SnmgJlrLOTJvgzPScy6kjk=
Received: from BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 by BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Thu, 3 Jun
 2021 15:22:30 +0000
Received: from BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::dc0c:6461:3a13:2b31]) by BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::dc0c:6461:3a13:2b31%6]) with mapi id 15.20.4195.022; Thu, 3 Jun 2021
 15:22:30 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/5] drm/amdgpu: remove sriov vf gfxhub fb location
 programming
Thread-Topic: [PATCH 2/5] drm/amdgpu: remove sriov vf gfxhub fb location
 programming
Thread-Index: AQHXWIKfPlp6jceVPUCuxvYmxxXbfasCZDwAgAAB2iA=
Date: Thu, 3 Jun 2021 15:22:29 +0000
Message-ID: <BL1PR12MB531798EE6E9BD279E26769CDF13C9@BL1PR12MB5317.namprd12.prod.outlook.com>
References: <20210603141305.2542-1-zhigang.luo@amd.com>
 <20210603141305.2542-2-zhigang.luo@amd.com>
 <DM6PR12MB5534530CED9007835EB82450F43C9@DM6PR12MB5534.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB5534530CED9007835EB82450F43C9@DM6PR12MB5534.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-03T15:10:44Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=154d4e63-9ab3-42e8-9d98-f933fed1e38f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.136.8.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 404ee3d5-afa3-4edb-1940-08d926a36717
x-ms-traffictypediagnostic: BL1PR12MB5192:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5192FE898FC46144E4AE995CF13C9@BL1PR12MB5192.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f7ajshwyAkxXggeFEMaFb4IW4Lm6XIWMRcGgGLA1ITkxwMZpCCM3KLeouQItsZ7YVfQW3UfE1izKYnxa4+8GrdfgrbfdBp0wEDqnAiYK7YfJ+8AlzeXTOTeA/s92TcdEu/Wj74u2jV61huWzdjMLwSAgMrSWTrMmzZxfVuimE9NuENhAiuYtHeWm5/QTgA/Ma2WrWjM+nu7M6B3NZmgYTV+m4uWE7ToKCNMh6FGSi156TCt/tBWlbVutOvk4Tj8ApzUNE9/2rthgu88DALeGO17/Pzno7phnvUbKbkl7hppuuTIyzT1vQpaFbJhIXhlMkPZ9oUozVcCdMlgp3v7ByRhA02Ifll4FU4zzENM4ht3cVvlNBRQE2B06GVUK9z+ziXsCmEurcX4WgR6yx14cZcyV/c7/j3duXMEEv6eVy/qKpBi+MkApmTeFrnmMPT2dP4+TYWQsiot+KRGAW8RI1QRMNujWa7cMPWgYZJMnYHv+jC0ek3h+lx+SVP5UUIf1e+dL9Guv1AEMMZh1nrn/yWVj+pz+63kppQW7rC1fNc6trv+xt3v8jqFoPWNHN9LogG3zB1KJlqChlUjESzRgoAk0i+F2wHsZs3/UbykBlPT2ZaoSkYyN/yei3kKo2LRU62HSPdy/txB1y+yQ4+HiGA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39840400004)(376002)(396003)(136003)(366004)(55016002)(26005)(478600001)(8676002)(186003)(9686003)(45080400002)(316002)(83380400001)(6506007)(2906002)(7696005)(71200400001)(53546011)(86362001)(66476007)(66556008)(76116006)(5660300002)(52536014)(66946007)(110136005)(66446008)(33656002)(64756008)(8936002)(38100700002)(122000001)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HUVN5bJwk8dGCl+XjJ3U6zzt/rGYEY08rEYfbjETtgnhPV5HNxibYAsNuDd+?=
 =?us-ascii?Q?GbMtky8sEJInysXMi/6d2uT+yPdnLbAVY1zSANmgqzsJDq08sOH3Re1AsezT?=
 =?us-ascii?Q?JkEhC2EzcN4DJ2VYM+zc7J+ce90j/OpVXrcvQlc8LRD3mYyVpyFdw8Mr+dLW?=
 =?us-ascii?Q?Psuj+JTnTMGwZXWNsv1VJM6V+fdwZWE0O669xTLkLsp+HIMQeTYveVh1o35H?=
 =?us-ascii?Q?pbycvfKusU3ZA5zwBWOygyXMAjFLcxJtPupNB5ZAzbJPWkbElhnuTUzGDMhu?=
 =?us-ascii?Q?7C/zNfzOoZ2+rM8SO2ENvwhGmS+LoOO6ff2QHHj//i3NvK4H6kT0c40tsr5e?=
 =?us-ascii?Q?jylswh4P6mnNIfLFSOKx+P7QxbTYZILH6fVBwHj01aV3dTurUUu/dewK1CnS?=
 =?us-ascii?Q?m7jUs8ba5OAmfdIs+8DD9a28cto9EZFhwbdd4h/iU16lOipz9Xh15A8bQG41?=
 =?us-ascii?Q?eSoxFhK9XgdcCBe9RiOQ3py6RcbS7CWvrnekm+swRLo00JryLkdCHRwxpwGs?=
 =?us-ascii?Q?h2IxCDqw0fJNxEpATSjJRHl/VSFbKod3E/vPDeNeR6ZWR/lbVKc24VOOAIhH?=
 =?us-ascii?Q?QRssCZjVftm21PIlGnekKcm+FEJrsmrXkLwBVD16hZO40w03011UywIsPdDB?=
 =?us-ascii?Q?1ggBVGIXBXMWnMWiYnVZq2t05dlCIRyw/AI7lQDdNgPTEOYo3abe3SP/SmSH?=
 =?us-ascii?Q?oBel2Ml8Ld3O4V+0alhcJI5DvtLqlSQsGZJ4jVE1aXZ1S2MFXJ8yUG5pcq30?=
 =?us-ascii?Q?H8+wrBulE7uMtdWGLkAdvh41Z7nhok+d/BeuuZdCcDrYTm7Q6Dw60BDoT892?=
 =?us-ascii?Q?yxWhMTUStAQY5TZ5wAanVhwvnyambgtm/kKOJ0il4XNuN6mTdEgrQQDsBvxk?=
 =?us-ascii?Q?HrgdL9wrvNA6g/EDgHh+83e86ths4k80jOAXf/o0AuUb9kY37avJK9RXebOx?=
 =?us-ascii?Q?XKw5EHo09YSFobzJglryiu8WTv1tM5PIyNZmr4fAY6bfccyJMa4/io3ZU4Oe?=
 =?us-ascii?Q?yA8S2rokztfv//azYXoF1Kr0gXQ8lkjMrXgJhYRQrvcJ4MWaBVVW2fljC0nP?=
 =?us-ascii?Q?bBBM7fLTf/SXVydBUgKJq6VicNfGhYg5zvVOolMaKLSBgP6emF87R2V2Lw8G?=
 =?us-ascii?Q?DXrKoRDdBOMk+EZEDo8j1/3I+oD6QYX96+FUjWXgUclttFg9y2qksEpjr3lr?=
 =?us-ascii?Q?nsesBnz1LT5sZ7rNO13IhMVkXQqWOxuBSA8EeApsjbiEcOB7yvEu+Mm3SLL7?=
 =?us-ascii?Q?vtiZx4anCj6yfc61hgNXuFx8VQ7Vk8l6TvwkB3qcon2FD0DgsO2QoJLbke5Z?=
 =?us-ascii?Q?JOA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404ee3d5-afa3-4edb-1940-08d926a36717
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 15:22:29.8955 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WvD9m6JdO9gb5DVDoFjYypxZrU1upP3JEztsg+6YM7fxaHAaf+Z3GnkjiCfXxAPR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Yes, I double checked all gfx9 ASICs with sriov supported.

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com> 
Sent: June 3, 2021 11:11 AM
To: Luo, Zhigang <Zhigang.Luo@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: RE: [PATCH 2/5] drm/amdgpu: remove sriov vf gfxhub fb location programming

[AMD Official Use Only]

This looks will affect other ASIC , Can you double check that ? 

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhigang Luo
Sent: Thursday, June 3, 2021 10:13 AM
To: amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: remove sriov vf gfxhub fb location programming

host driver programmed the gfxhub fb location for vf, no need to program in guest side.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 063e48df0b2d..f51fd0688eca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -320,18 +320,6 @@ static void gfxhub_v1_0_program_invalidation(struct amdgpu_device *adev)
 
 static int gfxhub_v1_0_gart_enable(struct amdgpu_device *adev)  {
-	if (amdgpu_sriov_vf(adev) && adev->asic_type != CHIP_ARCTURUS) {
-		/*
-		 * MC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
-		 * VF copy registers so vbios post doesn't program them, for
-		 * SRIOV driver need to program them
-		 */
-		WREG32_SOC15_RLC(GC, 0, mmMC_VM_FB_LOCATION_BASE,
-			     adev->gmc.vram_start >> 24);
-		WREG32_SOC15_RLC(GC, 0, mmMC_VM_FB_LOCATION_TOP,
-			     adev->gmc.vram_end >> 24);
-	}
-
 	/* GART Enable. */
 	gfxhub_v1_0_init_gart_aperture_regs(adev);
 	gfxhub_v1_0_init_system_aperture_regs(adev);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CShaoyun.Liu%40amd.com%7C5e79adbeb3bb46b1cf7e08d92699c8c9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637583264238382812%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2FHQnWwOdUVoyXVRBwx03aJqif3bVRKkKfDT82lr3ZJ8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
