Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9A3EB64DA
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 00:28:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B220110E065;
	Thu,  6 Jul 2023 00:28:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3637A10E065
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 00:28:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhJajHAQFuMh5ApDedSsBS0DQVwB+9CxwthF+MKw8ufMjR153V6/XRgCfc+H4stu4Zftw81L0bE+0O2DxIKOqY9lhJgQSSafZSZ/Q/i884RZ4g/X8duJV1yWGMYByF58gOVys9ueD9GPHsq0fEXb2y38kcoSoBIRKomJ5SRtLcnja9omEO7Vn2+RRGOy4MOwzWvkyCshI5AOVH71Biq/xGWLCIm71S6DCpUw6x/jH/Zd/Pr0Ibhh4YQxgf7UGWJS1WutHe1d2rbd/IVAPFLUq8wGyQvMwdWIeWQ1bgpfjSGn1CeZOdm6SVeC5+qMzki8H7gLlfUNZXMrp8TEcv5YbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFhIKELi0oTgNnEB5ya7YwKfiNFLxnFPUbVD/JLxuH8=;
 b=lvNpsmkFxK+TmNlsEYpSbQQgVJirquuv4/WSeXXWs93ISPZxRkdulgyHKjm4MFBs1gTGUva9AekEluxZVfSVjUDU1K1ms8OuMbJdZBP7NadFFy5BFSr3WBiqvrkbq7Ekj2KzCU7F2X9xlt+FSvMt/nWqWoWu/fYymBDeX5h+SSLETQsxGAz7HTOWVd6dx/amvmRLOCLA+wwSbHUGrFdB+IIgDF4g+K06RvwRFeirMS/3WZs3ebkFJzcGrua4Z5Us+PNZiS8Zd7ayXgb1M7qa22YT2ompU+UbiSeQV1JhRBXuxR9dl3/9CxTqqNN/RoLa7nuRb58wEAkqd9TyrbafYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFhIKELi0oTgNnEB5ya7YwKfiNFLxnFPUbVD/JLxuH8=;
 b=miw2fLDJrDLKdqEy2/Bjefz6bT8Iwxp5gOxomd9YCu+iIYr7XPm+tEpu5ZTIZ5sM9J059k7q5mPCQ4j5AHQV4J4kBPZCKGjSkpFeWDxSfnXxSUIqwgAIwaBmx5S8gX1xELuvLCyC0Xji0POS8DR/m0lyALJfhF4rTQsC8L4OeQQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA1PR12MB8096.namprd12.prod.outlook.com (2603:10b6:806:326::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 00:28:30 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5241:c0fb:9743:1a27%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 00:28:29 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd: Avoid running psp_ras_initialize() on HW without
 RAS
Thread-Topic: [PATCH] drm/amd: Avoid running psp_ras_initialize() on HW
 without RAS
Thread-Index: AQHZr2E3kbXYvbTmgkaA6vVn1of8sa+r4X9A
Date: Thu, 6 Jul 2023 00:28:29 +0000
Message-ID: <BN9PR12MB525760145F1812231E109A72FC2CA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230705165249.2058-1-mario.limonciello@amd.com>
In-Reply-To: <20230705165249.2058-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a89e2675-e2eb-4dce-9da5-9d9e0b1e5962;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-06T00:23:47Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA1PR12MB8096:EE_
x-ms-office365-filtering-correlation-id: 9483d51f-ed32-43d2-e7bb-08db7db7ec25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X9ny/lxO1xRH9pDRXK1xB22EIyq7zjOuiX9ka+5ppwttza19VjaaIx7Y+EQrgCiFyUXBFGzgsoQFBAEZlrWdIEPunBkZdfzE+rXNoK99AoIBH1dyNBCHtyzXVpTE5BZY5bBemZZp98rrtKCb1wKYBaCiPSFP9fw/6KZ3o7exRi2oCe93IOW6ra/l+PCKAc+7kq4LpSHfqNNwe3injs7NqZ33BBV8ajPxMqZrbUec30dDOK7lwjxx+JhMvXXJAcd1wwfujrRMZq1wKY7HjLk+0ghO0m/cdMexCTXOcIk1ZgeEd+30EJ0BuM9i8SkZW9t/Crz2gsSAsFok5q0OmBJ3A3vL1LRb18J4NMGky6aTZ0swWfZUk84ebEGLt9Bwfz0hd+Sz/J/btdK9CcOyxwNfbiOIjztwrMYAwbrFMUu8NEDA/r6v8/A90TKC15LJAnpKIdDZC8gNus4Ip7xr89a8J9gy0fIxS/yCx6gIFa82Asz/oxab7VmcxRe1h3w85ETbl5gYUuqAuzQF4Rc4wZ1d6rkiJ7bsumXpwSRTqPxqAIoQVs2P9TFIgnGxfsDPu+YCpRrefAqZXy2GLMpLt02hqRPOIBGVpqx7hlOqPNmXeITIasmKZhd2zoz/+e/iEauLO7DAXezEnMXTxMSWCQaWaQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(966005)(6506007)(53546011)(66556008)(478600001)(7696005)(83380400001)(9686003)(26005)(71200400001)(186003)(8676002)(8936002)(52536014)(2906002)(76116006)(110136005)(66476007)(5660300002)(64756008)(41300700001)(4326008)(316002)(33656002)(55016003)(86362001)(38070700005)(66946007)(122000001)(38100700002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TrZEYBE8RE1cmfRUJlIKlgpUWwO2S1dQWzwHFX+hZbBb5dBe4IKwGvbjRgrz?=
 =?us-ascii?Q?gr/zfpZnfdVL3b7Vv2CUdCme7Nr5NQsS03nE3Hf/wJ7f3+FRbjNnBhGaIcJg?=
 =?us-ascii?Q?eGopydSuD7Mz9ta1ojgMHsWgA37l6P/uYEXQm4fbZyjVPWTK0S8vboKViwmQ?=
 =?us-ascii?Q?ZIBGzN/tAKfp1oxIZ0N+jPn45qQ2uimm7jnXMTNnpbvPXjSuVvJE1ZaSdAam?=
 =?us-ascii?Q?2XxzMK2Q+IZunZLdn5TjGevJ+pjYeuDoSLjRak0CB6mi2zhSy9FOLCaIG/ez?=
 =?us-ascii?Q?/qM7FKDteCLqlw37ZkIqsqyagOAAhRqEmUiLfQZVsZ10bX/OQPbgSvchMZZg?=
 =?us-ascii?Q?l0san3oOu+9ZdeeTARjsyzoBUXRTEo7ygbJQQXsIIoOs+pB4vNgVQPcmvBnz?=
 =?us-ascii?Q?pR7VF8KfDEnPqCbyE+HK0ykjCSt32A2CcdM5ocOCkoGbF131Ynq2VGUwdCfr?=
 =?us-ascii?Q?zmElXVT/hrSnA8c10lMitj/XnTfTOxsoImbI27ZwfzAWuZD0GG0NsQjHh77t?=
 =?us-ascii?Q?zTgUt0FOTTarwpaClL2HfFjT9KBQhYLD2CwFN485mHgAJz6zI3GMdl9+S/O6?=
 =?us-ascii?Q?5Q1jvanlI/6miROkpGxfaF/08bc5edyrfPA7XYbDRuOHxTCrisrIIzAAV9xC?=
 =?us-ascii?Q?/YekkSD//CDd/RzyhDuZiojZa3Ze/RuzHl0XtiSWhmIx3zr69eDo3KJtZhrz?=
 =?us-ascii?Q?c2PPuVB3b2sahLgtGe2tD8vZkdYIVsRLdcx8b9/oFPL3kpvM6+rEe+VSQ55r?=
 =?us-ascii?Q?DvE3JNOtEedAVEXbH/cZiN/EggEPKeInpMwEZAGbPJieXryXhnQ6mC6nCS2X?=
 =?us-ascii?Q?M5CEHOAhKWi4QmDGjlqwL+vNNPuZANwRyXfsJ4Fv32Xl4ommp93rRkIfYkA+?=
 =?us-ascii?Q?4ZYFh5QAPtiV2ZQQszNrYMCLfrPqPWJ+zq88SqAwqABujDATTJu8ahHuhU1J?=
 =?us-ascii?Q?zBXzZLSx/yPQQN6Z2mqBr5rKDIGUl0nR0tKCFiAhQD1FX0ID1rZUykxTFU5q?=
 =?us-ascii?Q?FGHbiXaRDNNsKU00BPjQjqzWCQEFDuh+m0/4OmfFOzfZ+RljyjP7ltmpiL/W?=
 =?us-ascii?Q?Sx6ufLDWE+yF7QDbY/k3bFasojQpjndlHRJFxvj/ua0/R3Yu2b5gWGztZOKO?=
 =?us-ascii?Q?fHUzDYTx4prByGhV7SADYi6S2FWDXagFUoK62u+PznjSpQ0Z4GCDQBLW6RyB?=
 =?us-ascii?Q?Bx0xIykWusKWf+6R3VIJLBDDcv5CKbyi/ujaJLgo8SVIA1j4nN805YpELDx8?=
 =?us-ascii?Q?w0lcRLNXgFcowzGgkKWtr+qjIKrE5N2aAx1/oxP/aZELWBoMlcBVrYVyiNh+?=
 =?us-ascii?Q?azH3WTBJBDgZNgECVTqtRD57We9mFRtkQ0Cbeq2C0M5BCrD8KmvDKcgTyO2L?=
 =?us-ascii?Q?fTCng64/rKx0irxf2wmTpDwxfBTmzF6SVkWf8T0QkHc5OKadR2BgyuZeY65Q?=
 =?us-ascii?Q?2SM3SAqTxgtpih9ls7drhUA5MRk9UpruAjMczqowaMeydJoL/NW79nODHmAq?=
 =?us-ascii?Q?OHQAP180ZfRN+BYK2CrGQqnEdpZZKMQmlfSS17mHBmCx6czrCyzEW1oeMfK1?=
 =?us-ascii?Q?97w1Kf+e9loa47D0w0k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9483d51f-ed32-43d2-e7bb-08db7db7ec25
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 00:28:29.7280 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gFmax3CNH88yP5Zj5xHEyo0ldrQXBEI/bW/USvWvtPaLtxztHFjsZpfl6DB+YlvvNBW4eK+mHOd5dXUm+c1wTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8096
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
Cc: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

The change doesn't make sense at all, especially for some ASIC where it is =
allowed enable/disable RAS config through RAS TA. i.e. set ras_enable=3D=3D=
0 and the issue commands to RAS TA to change the RAS config.

It doesn't matter whether ras code path is enabled or not, but ras firmware=
, as long as it is built-in for the asic, it needs to be loaded.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario Li=
monciello
Sent: Thursday, July 6, 2023 00:53
To: amd-gfx@lists.freedesktop.org
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: [PATCH] drm/amd: Avoid running psp_ras_initialize() on HW without =
RAS

On hardware known not to have RAS or in cases that a user has disabled RAS =
via kernel module parameter, it makes no sense to try to run code from psp_=
ras_initialize().  Furthermore trying to run it shows the following message=
 on every boot:

`RAS: optional ras ta ucode is not available`

Avoid running the rest of the function is RAS is not available.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1415
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2673
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index c2508462e02f..a87b6c761e78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1603,6 +1603,9 @@ int psp_ras_initialize(struct psp_context *psp)
        if (amdgpu_sriov_vf(adev))
                return 0;

+       if (!adev->ras_enabled)
+               return 0;
+
        if (!adev->psp.ras_context.context.bin_desc.size_bytes ||
            !adev->psp.ras_context.context.bin_desc.start_addr) {
                dev_info(adev->dev, "RAS: optional ras ta ucode is not avai=
lable\n");
--
2.34.1

