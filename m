Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395E2C47073
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 14:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8FFA10E05F;
	Thu,  4 Jan 2024 14:22:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED4A310E05F
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 14:22:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+eIn1lCUHpPSZfk2f4ao2jQyPnRhNvfBCPs1TKuLtjSkgZ31iUi8mPE3gL0pM7FJxRbhx8EJJCpL6MOXL1RwCuyDSUUnqbJXQnam7Mr6LzIzIo9Bc8FqOHPHPeBRIufaRvI5vQPrek8MlW+sJXuikm+hsB4JxjFK5CBBlG5VJhR3j7BUkgym5qcTt22wY+ow9O+k3DgqjQ8Qx/a5FPkj8t21skAyTOIRSYBEjTv2m29oKuRC+Lyqu3dSsIWEJhTClcPRVgw+YKyQhtqGgPW2aTP7vCPp4F4kKRqtyJFxlxghiTW1dmfVpw8f3jrWYR1Qbc9sYtc/KtyzzSscsnAaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIpyLz21TCgvoMVdHbgQpCjh37T6ihOqO3dkvnGS6yk=;
 b=WKFqXd9fMA4hhNm7xfzDGlicmYxUGjnr5Ij75Bnu8cpcwMtwD9dYLAsg7SobQ5Lk4EG7HDWRwGr0dGK+wpvfZP7u3YLCbg+8psYK4LMt4MF8AvZCLemszdZjZr2M+FmpOq1jXxl1ssR81GHf43SQI0HG0yoHkUxci1vLcfQESH2t5CwT/e5H+ch/+aE/w5eiruqAJz/FByOC0qxh4yvidWHkfsqTkS/bML67FwK+t9mBhgnA4Y0ksjKcmTKX7EqYLSbBf+zm32Qg/UjxoxorNdagZs+uwQILzOV6AETsvlU2ZVmy4Xah+p1nSG6ZhcuUF6sjKuvNBKE1LPSxxd0G9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIpyLz21TCgvoMVdHbgQpCjh37T6ihOqO3dkvnGS6yk=;
 b=yGPCp9JMVCjF3Av9FuqGMTOR6++M/1bbToCzNEPUUI3hWrU4DXyVfebe9vpIAOoV1yBbRr8aJucQvXt+8o7Ovi1dgU74VA0zjabfYS3JWcWDrleZ1gYzyoUuT7mvAzrtpDm9IX2A87e0zwUTt8XnGnBVYTkpd+5fyIggWKc8FvU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 14:22:14 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 14:22:13 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu/gmc11: re-enable AGP
Thread-Topic: [PATCH 3/3] drm/amdgpu/gmc11: re-enable AGP
Thread-Index: AQHaPo+oofJocR1i6UqMFK19WdIYtrDJtZMA
Date: Thu, 4 Jan 2024 14:22:13 +0000
Message-ID: <BN9PR12MB5257CC3A7B9EBD1C10EE7BA9FC672@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240103215536.1780386-1-alexander.deucher@amd.com>
 <20240103215536.1780386-3-alexander.deucher@amd.com>
In-Reply-To: <20240103215536.1780386-3-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0d614a28-f3aa-43f6-8536-0b61091247ed;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-04T14:21:46Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY8PR12MB7217:EE_
x-ms-office365-filtering-correlation-id: 6b36507f-223e-4978-6ea6-08dc0d308c12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GkYawIhehHG+r6/SCFAI3jRDrXZzVGf5ldAarItmnSS/ivWeZSiTi2zRTRDbQzApbH2YD2oVxhmWUyCJRznFy0qWeDzreICMUqF1ifcp8VtRxFi7kuhbRnFxWf5Zc3HoZO6MEO6WFLIC/dOSvNasFR2sRuEiuDtqjyMcpmZTzIjtQAdGQEUSWzMuf361uAGT8ip6WWdi/4LC0DgYsc/kvvmrxShnZtmqxBUBChL0fCRqc/COQGpUpd1ASXo9IVuPOqfmAja+h8qHv4zGaXlino/E64Rlbv0hDiSsBOvJRUi4z4dCBnF2Ox/F/2XpzsmFS4teYuYknK4Y2K+YXHPv7/6/oAA98RyDIIx/6laDDxdqn8gslmT2+oAxJ4DsgXWKWp1pjXJj4zxHZysGKao1a0jJ/4ymDzN+U4xOiIXMq69qA5dhbs5ISQIrrEQvrC2YZwHAmCps/Bv++R4FS7OAX+1Kkwr8Ssnsk89Kg5m3dKCha55JR6ZlOmYAmxM6Wntfzdoq3mxnSCTm3AjFrGbBYnfnnBTlSDu8o0RYfC0M9kWYYkj2j7hDM72+mw6+jBnr2/rR+NBrC9pLnN/KfaLNAwOV4DbPSyDAPPng8L3H1PiVlINb9+CceORtXbh5QMom
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(2906002)(8936002)(4326008)(8676002)(316002)(52536014)(9686003)(64756008)(66556008)(66476007)(55016003)(110136005)(76116006)(66946007)(26005)(83380400001)(41300700001)(38100700002)(66446008)(122000001)(86362001)(33656002)(7696005)(6506007)(53546011)(478600001)(71200400001)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lGuUXndNCwxh1qBcC3FNOIDSIir1ZhjQXZF0PRFOZ6m0vzJcQKNOqLJUtdCP?=
 =?us-ascii?Q?6G5lVunaZ8W0Vke7Ii6pOQ5IZQwoq6NEhd2sOaASyFlXvAFvoTpELAolei6E?=
 =?us-ascii?Q?fhlBnYwvA438styJAfX4oPResn359lDtc0vm2kULVe++Jht2+C2Syn3JjXuH?=
 =?us-ascii?Q?CbdPiET4OA3wPJfjZtk9d6+lfR0BW5035DB5Q4tDexGw3zkv7dZjTu+kLBXa?=
 =?us-ascii?Q?okPHND2mHCIgcwyosm8P6EK0Go+bMujGCKyBImnYAUj0QpZiAN11AjeicTuV?=
 =?us-ascii?Q?8RdhoYxEb6TY0ZM0CYd7wwkVHGie4Zr7r7uF6grL31pm//R1yoS1+vW+fRIi?=
 =?us-ascii?Q?HTC6gjuJ/wxbPkHGP3vWfb8prHgyXYfrfP91eeNIKgsn6LcJhUnJAzc4/Kdd?=
 =?us-ascii?Q?bsSd7nHAXSpAMjFwly6B5NgO+ovfoyp6SqU+SAXV/rkyKFm854xhk0j1OeSI?=
 =?us-ascii?Q?L+yZ58S2N9v5TuCMtNkivuWydrWmcMA5lvBlPRocGKIr5v0kH9/0z3wkbUPK?=
 =?us-ascii?Q?heOhlS30WcBxD+KnNwxGGGX+SQFO9BUymL+VdlJikjcv+t+4lP7STyy9PuHC?=
 =?us-ascii?Q?zvbXGg736PojILXKZN9UPntgYtWjPAU+wzB5R2s+J2QrEnatz3ZyiYcXNY6u?=
 =?us-ascii?Q?AkEJ3zu2D+Zelizi6jcx7gz4E0ibeYQExybRErqF745pXaBR8awzr5TCOgHA?=
 =?us-ascii?Q?joHphKCiCKbNsDqL2ZryuwCQ4mblX2s68Z2TEU/VrjxTVJ2xoXRGGfiWYSwF?=
 =?us-ascii?Q?npPvjZZwY3Ewi+GYoYD3HgahvzC2ZmelD7Ro3Bw0NtoFLg1aX4plb/1KwhnP?=
 =?us-ascii?Q?gWg34sM0qWXsJXaidOatHZYiqERK1izMZd5ZnSmJK2TvtTCrrAaxZy2T0/eX?=
 =?us-ascii?Q?fUNrdRpTSwB2t4UWTX2LddAtdn43+JdATeZ9sRbaJvsBUKVY1/UkCoetsVU4?=
 =?us-ascii?Q?pIWBENhmUD+3q+j22RnyKAugSvnwdXqlLmoUaPfCjkL+WIlLdVLGX+gOcTck?=
 =?us-ascii?Q?7erbeg/J0plk+3fJEsCbj4XbN0QX5jwzohLk51neYDLyvuxblxNCBVChZ4N3?=
 =?us-ascii?Q?ecZwo9PmftiG5GwyXz59ll2EqhZ+6yCepa5TIIT90S7zqkstVxvnXX3ZbVxs?=
 =?us-ascii?Q?CNFZMofXrhyz2+sSAVLSiEdff0SwiyQi2OW1g8/jDEJQqQxi+EGmmccdcjre?=
 =?us-ascii?Q?VDHnL7R+8FtH0/LcVg40kgtXny7Oo4N0f4rz6KgS86Z11X22PGZEWrfeop/s?=
 =?us-ascii?Q?IPhUpSkF34ZmHp2F9ayMIDvBWPt66qru3t9D21iEMX67213lj/VKjAMucX3y?=
 =?us-ascii?Q?7heM7WTGYxzrK7pBK7/QXyHmGTwusv57oIHb/JByQs2hXR9qRWvkd6rBAxwN?=
 =?us-ascii?Q?s6PQ8HiXZMiu8p3cGPYW+WvNLuUK/8jsDDtfwtZNlySwNTiblyGrNPCDbmrk?=
 =?us-ascii?Q?PSV2+vV9pUhXv0vbDTIV77zyCZ35sP9TTnhi3E0OFg24TfWP5s0xq9t+AnEn?=
 =?us-ascii?Q?SBfhsVwaTA4sRrEmrVxQZvWqBfZd/ltVqZfazBvF09iBS1fhLVLLMRKbZygi?=
 =?us-ascii?Q?DE+7bfd09AME3DAIsDOfdfn3uQaFRsXTQRAVF1ky?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b36507f-223e-4978-6ea6-08dc0d308c12
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 14:22:13.9274 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cD+uU+uDBImJ1Tidfp4CBrn7X6zHLttgftRu2HTLlc6IIKhM4wHvEIiUE+QimMpOVyvC2p3gd2utgk72SXIM7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217
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

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Thursday, January 4, 2024 05:56
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/gmc11: re-enable AGP

It should be fixed with
commit ca0b006939f9 ("drm/amdgpu: fix AGP addressing when GART is not at 0"=
) so re-enable it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v11_0.c
index 6c68135cac9f..906f23d13975 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -643,7 +643,7 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_d=
evice *adev,
        amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_HIGH);
        if (!amdgpu_sriov_vf(adev) &&
            (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(11, 5, 0)) &&
-           (amdgpu_agp =3D=3D 1))
+           (amdgpu_agp !=3D 0))
                amdgpu_gmc_agp_location(adev, mc);

        /* base offset of vram pages */
--
2.42.0

