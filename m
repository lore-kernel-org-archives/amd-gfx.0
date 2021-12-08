Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A05C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 07:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2698D6E8BD;
	Wed,  8 Dec 2021 07:16:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B3BE6E81C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 07:16:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmDwR78dzVfuQduEP7ys3Bzd8Xxe+eY8nNBwPLDHZDs9ncjeg6HFJl1n9NxNpShjsf2J2W1gC1nEtF7rvQPCWB3eGfNBjsm3a7Y58LF31ZeWQRhClCi68VV/2JfpW1FMt6s6Hhy+2MGjt/6vGNmyL2FTzlUSDylleMVvaI0VDkZkaXAUJ17yFjkd//lYTfaHTnCiu2PHgq1jsJ/SCG4Ja6wZLPMy9mwF5xZq5ZNPmLfsCUJ0DxQ9VZsYF1wmdnrWVgs1Ky4F3Tug7DAX5FVjrznU3AVD2rgym21GrGbtPI+AVoGLsbA83w7TohNJexPHaghUZdqrYERdaCBg9wNEXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXPyBho7Udt0cBWNhgnCdvwshQvxV/K376dxXAAnVGI=;
 b=E1lfK9+T72gW8ghlZYV0uDyupb8N7nFcq/24nhXAFbwo2JyaoCozJ4uLolLs1pq87tiTWLKh2Qzzh3d/hUbcGrMP9kPzjIZfqzHYeW6HbO5wl9oiybS9C+PY0O82/HKq9Joeq7S7CGw4g4g2FwCoC6nPwLwFrdfpAWXgITuFsrISafksgX/wzVxcFvVZ2qQ2nzNFH+2l9JK6eTC1qU8crRj0UJv0DTWp5QGPqi8+FtxfTJ5AaLKSECQnmv9OzJa9kIwDHy+GXYR0QFCW3S9mPW2gddFEjTLOGAQbFoCGBjRDM763MMtHzmIRhfC+53D4NKTJWxf43kPu9buU/fD4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXPyBho7Udt0cBWNhgnCdvwshQvxV/K376dxXAAnVGI=;
 b=kElu/o8vXOtLCnL87tP05A0rVtmPnGkpOL6825gBsj4M6fYj0rWI4PZ2MYnoNmxg68ikyVMDGENg1hNvNPPMw21XQiVPXW1SD6skqNPd/AQm1msZ+SDtVsywQgLCq8hcFMO4BbUhVhshAhuE+tlDY20CbQBLnRZpuiJCHgXEZBk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5084.namprd12.prod.outlook.com (2603:10b6:408:135::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 07:16:44 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::2919:f0f6:40a9:e1c0%7]) with mapi id 15.20.4713.032; Wed, 8 Dec 2021
 07:16:44 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Ziya, Mohammad zafar"
 <Mohammadzafar.Ziya@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable RAS poison flag when GPU is connected
 to CPU
Thread-Topic: [PATCH] drm/amdgpu: enable RAS poison flag when GPU is connected
 to CPU
Thread-Index: AQHX6/u0tOkPq8NYBkWBwdbIfKAz/awoLwMA
Date: Wed, 8 Dec 2021 07:16:44 +0000
Message-ID: <BN9PR12MB5257BB79EB0F02B298B3E341FC6F9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211208062020.6445-1-tao.zhou1@amd.com>
In-Reply-To: <20211208062020.6445-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-08T07:16:41Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=2158bdfb-2210-4bf1-bcd3-e23ac24bae16;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7161be59-22ca-44e2-8b59-08d9ba1ab0e6
x-ms-traffictypediagnostic: BN9PR12MB5084:EE_
x-microsoft-antispam-prvs: <BN9PR12MB50849CA100E5709B82D9526FFC6F9@BN9PR12MB5084.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xH5DjjihLHsA/3qTiVc1frdFSlyztAR4aKhfTURWFs0opz7TrnxcQrE++Cs/edoYoRtHhupZk80BCYmE5hnEKjhXRDziBP3Z4UNMiAe9HGH1+y/Q83bUFf25K+DgUxPlIXK0SuATHjfog2IpfRYjPg8IqH3VAvY1pNEXf2oZO87BorI6ihSD2Wrrrand4phuiOn4IDqUWRFcLFhPbZsxTdRlPooE6nsPB+yD7M04Odo18noTqzZoKa21anr3Gmbeu5Q74KgsP4eNakGdk89WH8VkwoJVSZNbaS0bipqzpb0Nh2yZbccIvk7jl9TEg146NXjzl3HGwLg7Sfmw3COGo8qcYGJM/+ZUsaybmbdE1lNsZXZpVSAYB40Gdznlu84/EMBog0heygF9iPILqQJmbjXenzp0cH+dI8ORqkMGEKE+rYXOu2/a9OjqP6sGhaJwAHcCLO/ZWyK/932qjZScfwPWhiWAgua5FLKwvIVSiwZNWk8EchcPLuh+UmWSecV6Ah5qGAxsSAbt2M9sylSvqi04CxztmIq5uvgcVTUsW9nzfb/a1gBI1gVRr+yq35/dZ2HltO/jR/PUHD8hhALgw8pbQbnH72KHV4k9NteVhF1BKmBG1p/24ix01IOxvqkvi6xf7cTf3uTlHTjIGSLaFCwHEof9erDkQPIUujAp1JX5hVTCVQC4myXoL9HpVrcscPU+qbQFOBR11//CptFCrw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(52536014)(8936002)(2906002)(55016003)(83380400001)(5660300002)(33656002)(508600001)(66946007)(71200400001)(38070700005)(53546011)(7696005)(316002)(76116006)(186003)(122000001)(66556008)(6506007)(64756008)(110136005)(38100700002)(6636002)(66476007)(9686003)(8676002)(66446008)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cud3J32qyK+8jHLgHYwStCBdkE463GeRRg/ScKAVAsJ8ZsdaNxefROqqXxhC?=
 =?us-ascii?Q?a9ie2o2P1U+NE6b1qNimDfIB0CwvPsk87W1AT0ELOEsS18R9zcojeJsKd30e?=
 =?us-ascii?Q?/Nk00QLF98IY8iknJL5xDBpc3qE2VPAQ9TG/Pc0/KWG5DdleyPcXpsaeYKEt?=
 =?us-ascii?Q?OmTep2LA55Z1HzdnLcaO4KQpYajh+PSJ6uuShE7l/SuLWUOjANDQtdJmjk5V?=
 =?us-ascii?Q?3NE/GI7IotGXDNEono9s64wHj+MLI0yV38fan/zwDZ3ZXTV1skS+W8GAAPrP?=
 =?us-ascii?Q?ReDUOreMmBJwL2lfCjxbDx0vxeiySOJ2NefBbLKAin8lsAGQGbUa4K9yQNuc?=
 =?us-ascii?Q?rtNfAfVRxRXkvq01/Na6kbCKxxa/SfYEPCb7l5g/T6+KNrcWq7uZnH9ZLhAI?=
 =?us-ascii?Q?CFpG7kTiQAt3X4iMPvlD5x/gEumWNOkmhFcwcbhkkAPC/3ctdloLbhmSwNxf?=
 =?us-ascii?Q?yoCcfFncRsVbjit+mtTk+KQpSUtjA9SLXI+is44Kigz9Hwc+xISTkpRb4Slc?=
 =?us-ascii?Q?TnkDxHkzfQFJoQ8SuvmFT5+W7eVVuw2YLdV8Dme5MAW4HM5RmlR2Boj5GxQl?=
 =?us-ascii?Q?M6SC9RCPmfJAyvhEwLu2x4qsjKd4Xu+DGgL+SqGwn9QQiusuvS0QuNYGH9kX?=
 =?us-ascii?Q?RRlltxFZloMnLVKBhhofSPuJ7xhbygw+d7822FWZor7WSiYveOSVbSUdJVLU?=
 =?us-ascii?Q?y7EhFIS9WxksMDfEFR5oRu54pM2UOgfppz93GgJ3aFm197mZTvoP7OcSX670?=
 =?us-ascii?Q?mlWSd5zg0NIIGYDK0cR0++lz7kVF5WbMl3A4FdoCGCqZL+NDSw11fine2pac?=
 =?us-ascii?Q?/XKwuFoTg1xN3hqqH4IlI0+/wt06uj6TZA2FhxIH1yX3E8yelLrD4KE508Ok?=
 =?us-ascii?Q?W4Ta5PZ0HwEs4Z7KbqYe/zl1sBK50/YOOragfpQvAcqm/O1OQZQgg0zmfnhv?=
 =?us-ascii?Q?tQAyi7Txm12ly5baWIEIKrxAZQO7MFnpPKdXz3P1Y3gDmazgPBp8ydRaIfeu?=
 =?us-ascii?Q?C1X8L7PmPJMfnUkSCTx0bwFWzrhd1d+Oymo+hF+j+pVRmJ+av0fBDMhEXE98?=
 =?us-ascii?Q?SRJn4IzeHnoGAW5FrKTm5qWj6uNztevBhAJoENiV62l+ShfO9Z3/9cQBmaPU?=
 =?us-ascii?Q?DXf8hGb0BIfTFVBSpKnIi6302iNwPgm0ndZqP6EpI6qb3jsysU/8QGWVU7cm?=
 =?us-ascii?Q?mUOywn9Nk9YndLZrcPA+e+D7B3Fo9/fKAvHcn709IHlcOSBseH3ucn9LjnqG?=
 =?us-ascii?Q?rNRMTH4cKQd0v2ktOjxvlAjdz+Y95XRwemkHoWFGQzNLkjqcCSGU3aFuodts?=
 =?us-ascii?Q?25n5tMIzwkhYON0YuCqPfM+vlzq1VqsHT6+p4F3G+xZa0iQDaY+IS+j0ekuw?=
 =?us-ascii?Q?K6aoFdn9nSMvt4Dw0jUJ9wOwNvds6VZSLNolbkVMWZd5gVUIw9vo9nZu1GsM?=
 =?us-ascii?Q?STEEZJXxcwzEZUvW7linDTzJJKuMc/118OzoHhrhVu6yHhjLVIUwpClCDKts?=
 =?us-ascii?Q?61Ns2oEtlIrF4wkf+KlBEjVLOlFIHjLDcugX1x+B9Trczg1sE7LjGBO1HXSb?=
 =?us-ascii?Q?AtNLJPtLKqM2lPh5uxGd9CV2YEYFDyRlGkHNmc0ohslYWdbbTJaSyX0HDn/d?=
 =?us-ascii?Q?Dyh5JROz5pP66a76WhSNaoQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7161be59-22ca-44e2-8b59-08d9ba1ab0e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 07:16:44.8276 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: By47k6A319rR1Vs9MJ91gLvbPLReRdpI+NZ0ZIn8U+WwsV9goWmPms6O7zIiCGATc0QVvmwC1yk0DdsMrzw3Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5084
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

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Wednesday, December 8, 2021 14:20
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Ziya, Mohammad zafar <Mohammadzafar.Ziya@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: enable RAS poison flag when GPU is connected t=
o CPU

The RAS poison mode is enabled by default on the platform.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index a95d200adff9..0003f2c64da8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2372,7 +2372,11 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	}
=20
 	/* Init poison supported flag, the default value is false */
-	if (adev->df.funcs &&
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		/* enabled by default when GPU is connected to CPU */
+		con->poison_supported =3D true;
+	}
+	else if (adev->df.funcs &&
 	    adev->df.funcs->query_ras_poison_mode &&
 	    adev->umc.ras_funcs &&
 	    adev->umc.ras_funcs->query_ras_poison_mode) {
--=20
2.17.1
