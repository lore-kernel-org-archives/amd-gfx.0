Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3557CC47096
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDD97613EE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD97613EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D5886F4BF;
	Thu,  3 Jun 2021 15:47:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1B0F6F4BF
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 15:47:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoFxjWsQLNExNCbetWgQxE/o3JuT54lRQomZpBW//q8ySdypcrvhtsep6obmcurkZ/zvz5vUOOvch6aiUnAuRaAdUrcTLGxwVYfiEeLtQBPHo69OYqB1h76D6+0+BlGO8YwdYH9LJOwPwJMkazBEpkr3TTVLqkeEHgDNO7LOBiQn24Gko+WazIcsvKaMARi+f6cNgrgiO3Uxs/gqTqDAYDxL3zfeAnxFbvN/DqDoJvHe75JKS0/eUd2qL3CeUYhY+2ZjSHwf9d7z/Nbw5MWouHFmRdfkGG15opD1EvRvZHphCXUmk5VCv7ircsQel2/Koz5YDxYdIGmGR27naOLseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoOnieiWNkh/7MyGdadmHPgQg+bB++I6Rl7VkLDoRGc=;
 b=WJNYcgIdCGvN4kFWWagtm3VrthH376QHLXrjGzw4u33ZPcVVECeV2mPHcvoSvbxbUGs0nBQ6jcQOxAHTR0WrXOvGW9+AFZ6Sf3uP3Ry+1Vnq/JbRy7jbz91oKwZLwrwIehkr1/yT+BPxicLtxgwwf6EhZE3WQxL0vT+lXrMeDuu20os0sSewj8u/xVZBWshl5YS6TE3DYgRFOTAhWYhE1txE8qehULIaDP8UUOkKr7/TmSLDBltEnR0A0BD/YfL6BNOMUfZ3Rmb7RiUU+9+KHCgxzFdLcNUD7ugWsJIKytfY/5FAdt2dnJVzfrUqCXmmEYfU4CcqB+ZPcUnNZf+E9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoOnieiWNkh/7MyGdadmHPgQg+bB++I6Rl7VkLDoRGc=;
 b=Er5qrtGFr8T7aqb1rnAW5tOlnP1ySVGxp0kweTyZuuE4ZOePsBIYJEbkZMIkia3DDqPjq4f3ZSLtarseoxmIXX5aGZ1BsDkbdo+7kp9UBHP8jc/OI8OK6Y4DUk78Rfj/fON2md8IxQrRP1yg9+8I/yWVoCJQkKC5RMniWuhU+kQ=
Received: from BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 by BL1PR12MB5272.namprd12.prod.outlook.com (2603:10b6:208:319::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Thu, 3 Jun
 2021 15:47:37 +0000
Received: from BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::dc0c:6461:3a13:2b31]) by BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::dc0c:6461:3a13:2b31%6]) with mapi id 15.20.4195.022; Thu, 3 Jun 2021
 15:47:37 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amdgpu: allocate psp fw private buffer from VRAM
 for sriov vf
Thread-Topic: [PATCH 5/5] drm/amdgpu: allocate psp fw private buffer from VRAM
 for sriov vf
Thread-Index: AQHXWIKfP1slcjJyREG0ec57/mKfuqsCZWeAgAAIZkA=
Date: Thu, 3 Jun 2021 15:47:37 +0000
Message-ID: <BL1PR12MB5317C909CDB48412330A608DF13C9@BL1PR12MB5317.namprd12.prod.outlook.com>
References: <20210603141305.2542-1-zhigang.luo@amd.com>
 <20210603141305.2542-5-zhigang.luo@amd.com>
 <DM6PR12MB5534515D4D05368A9CBED534F43C9@DM6PR12MB5534.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB5534515D4D05368A9CBED534F43C9@DM6PR12MB5534.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-03T15:14:56Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=df1f9e2c-ea56-4c00-8085-da23f87c8241;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.136.8.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0ea7f6a-50e0-459d-9350-08d926a6e969
x-ms-traffictypediagnostic: BL1PR12MB5272:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB527212C32FEC9820603EA956F13C9@BL1PR12MB5272.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sNSrLd8TMMFGjoi3W9obI4kFauXO2MDw/p6mN6CSxcr8myaFPI+GqV+BIu/BWpf+bMo5DQwu+rjmqDGzPy1McuGAWG4S1R/ZTYlH1W7tsPrVfdR9KMkdHFeEx4jl+snsZii9bTqwREBRhvYO0+H2pLCqgPL5kdSxnM70F9Zwd1G+HeQkNQagczV2QA5YcPpzdywqD7cPacqtKQv/jtyhpjN4jukMmmCqU6ZOkxAubjlxAkuVIB+FnopU8xuqf608N4wUl+BrSC+M69cEVmY+CMBCzI7RZVvPKJB+iKdf6Z3d3OCZem6do8ztZOi+0S6iA3RKM0JjzK6ol0aBHl+4Ki1JN9vOttX7ZG8YBlv1I93BDBhUuvWwJAS8pejCxqaD/WgEzz28Va/698OKUbb+dTtiv+Pa7aa4CHVZ6PRToeOZCpyh24Pax1Lyil4f4Q97GB36wFldaFrALq5GEGNBwsLunDERqlq5vbjmLWw0U0K7oUQSN2zgMfd3kDlVnWqgXhnh8J7KBUJGHbcCWFcnkuTMpArD7G1OlC7S6YErPBVLSySM0a12ZP4gZiFCJn3Lk8/6QugTVyOHmrPsSBDOQmGKMt3F47+EoL7leJKtyPkzmDiXRZjRmFWVieKmNLH2n78AwxWnvM3MXo0ufe1hpg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(8676002)(966005)(8936002)(38100700002)(52536014)(33656002)(6506007)(53546011)(7696005)(110136005)(5660300002)(66946007)(122000001)(66446008)(64756008)(66556008)(66476007)(26005)(186003)(2906002)(76116006)(71200400001)(83380400001)(478600001)(86362001)(45080400002)(316002)(9686003)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?e5tnGMHRJTfiLdHLR8ApCpgsm+1hYsKYvL13LZkvCL54Azj64/bsctIxwkFj?=
 =?us-ascii?Q?zDGy2R4c1p8hDl/l+5PMe2M8YXl/Gu09XnD9XB1DuE+cvh8VmQGA5VHoxfEq?=
 =?us-ascii?Q?0oABdU6DfD0B2gzurqLWy4738cNMRFB7u7MiwQIGHmUwOybx/R38ZC6YXR9k?=
 =?us-ascii?Q?34QF14m/SK0588Wapqm8bOQEbEFMivDQ0Dx5H/zH7vBRWlHNMnuGurIP0qjp?=
 =?us-ascii?Q?yLB+NSHx4pvcjYqmZdVx0CmK+aQCj/Fu0qnls2qos1I7hCH3ZEl7PU5G0U3N?=
 =?us-ascii?Q?Ze7rcE16VcDK6moAgtueONztU7spVP4YwivQiHr5FIn/xThO1i34p89JmHPA?=
 =?us-ascii?Q?PdEVYASiSZ9sr8h0k9DC3SPO1elfH2QXwgipp5eRL55lPInD4PfZFTaOEGvX?=
 =?us-ascii?Q?gjR08scWRKyOJky+DXk7ktmx+//S56eMsQCxqouqZ0iMWNsI6g4jSzJvsPBT?=
 =?us-ascii?Q?WGSvWPxg4h7qW1iB9OKNf+wWvKcYug+3xPIl2NIpPo+nUfnqTtZy2aNI3lt5?=
 =?us-ascii?Q?LCsmkFSgrVOPVfNfxGzfsQu+YJE5R5g3bJuCr52eFQFOOiLB42frW/RlrcX2?=
 =?us-ascii?Q?hBw0LYoUk5XysIhmKWe5XDqTzgAkAxm+35Tw0AF8gu0CDuSx1zwV985FjPeK?=
 =?us-ascii?Q?rloZYkvJqfhKYLCa6GQGFhAezesICUcIykziDIG+Co+U3bV7p6/bydpcWnoE?=
 =?us-ascii?Q?mWjibawkdfBUvE16u+f7EWA/PPJMxxSDAMm7TFSIKVwFKZPH1pipj/VIsv2w?=
 =?us-ascii?Q?hZEAaGIR+v99tqg/8eRlCXi65DZCQrlcpMBRQAAG+y+m4b7WVRrqbNbjURQ7?=
 =?us-ascii?Q?m9sv0CXEe3iyv9gwIR+lrpBHCbN1MzKuhIIcLp4zqH2p/xfQRgzlvKPTEZzE?=
 =?us-ascii?Q?FXsPYrU9SaCgxy62A+okdj0TxRir8QeXYh0wrdybnHSRho4zvdooCdCc6GtL?=
 =?us-ascii?Q?sBDtc3oJyM+xL/zoZWthpmLp0OsdEdCar2ufemnW7PeD4fT4L7FgvfjEcEjB?=
 =?us-ascii?Q?bUHPkXZgXBa9KmIkR1CuP88cI0NdXdhHYH5qTQeHNLNBexFiBtupHvumCyFm?=
 =?us-ascii?Q?8nHYAZp4PLl9rhpaKf3DpN3mf9GA5LJ93lEQqck6ixex8i9or8NQfDCB7Aur?=
 =?us-ascii?Q?dAylXLA+VfZZKFIvbzuiz9VSbNNTjfGKHuMJkwmffwAqq+e2YgIIdzsz9NSu?=
 =?us-ascii?Q?EuRKXQYQRLOLhuiH1qJcLV7XmjeeyMYHgoIDdiq3wU6CmlKkep5OWtGvGztz?=
 =?us-ascii?Q?wmQT5ByEm04XuaF2y3DRAx3RGBu3MicY77ibZvV/lz2E7Uv7YxHYMh5n5rBy?=
 =?us-ascii?Q?qEs=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ea7f6a-50e0-459d-9350-08d926a6e969
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 15:47:37.0400 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CAN2XEeQAETRc+Zfm6SHprd/RYNqQf376Vo9H+EtmcdJUjKJt4Jyh7WUpxykjSnl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5272
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

All new PSP release will have this feature. And it will not cause any failure even the PSP doesn't have this feature yet.

Thanks,
Zhigang

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com> 
Sent: June 3, 2021 11:15 AM
To: Luo, Zhigang <Zhigang.Luo@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: RE: [PATCH 5/5] drm/amdgpu: allocate psp fw private buffer from VRAM for sriov vf

[AMD Official Use Only]

Please double verify whether this feature apply to all aisc PSP supported  since this is not only apply to ARCTURUS and  ALDEBARAN. 

Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhigang Luo
Sent: Thursday, June 3, 2021 10:13 AM
To: amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: allocate psp fw private buffer from VRAM for sriov vf

psp added new feature to check fw buffer address for sriov vf. the address range must be in vf fb.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 6bd7e39c3e75..7c0f1017a46b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2320,11 +2320,20 @@ static int psp_load_fw(struct amdgpu_device *adev)
 	if (!psp->cmd)
 		return -ENOMEM;
 
-	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
-					AMDGPU_GEM_DOMAIN_GTT,
-					&psp->fw_pri_bo,
-					&psp->fw_pri_mc_addr,
-					&psp->fw_pri_buf);
+	if (amdgpu_sriov_vf(adev)) {
+		ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
+						AMDGPU_GEM_DOMAIN_VRAM,
+						&psp->fw_pri_bo,
+						&psp->fw_pri_mc_addr,
+						&psp->fw_pri_buf);
+	} else {
+		ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
+						AMDGPU_GEM_DOMAIN_GTT,
+						&psp->fw_pri_bo,
+						&psp->fw_pri_mc_addr,
+						&psp->fw_pri_buf);
+	}
+
 	if (ret)
 		goto failed;
 
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CShaoyun.Liu%40amd.com%7C3f624a72d2574d5c10a808d92699c9a8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637583264223318916%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=4EfyfR26TENFq1%2BXlSufuOYocdCmNcdEZHyEPzAQPcc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
