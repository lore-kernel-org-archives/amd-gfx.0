Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02C1C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 02:53:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E6506E075;
	Wed, 24 Nov 2021 02:53:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80D046E075
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 02:53:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jquj/cAB13Jf9NOJ4VKOIvqygTwg1dr7sPNuwq5DdmtarDSHb/9Y3N24AbgTTLlK4KjvMsQ9w1efmQ+lVYC7TSh0CrcV81oqkSgZyLVvIGnnMpUe/CPUWqHTr3YSeA+WhgFdpKjjJVFUthMweAdCBRNEGleoJyMu/OqHzUCvr7GFyj8MM0fNLHRrjM4meCWnY2LltDQw6iRFM/IYdRBRq6mmovb3y4okFlLa/XuNE+OowiJADPgiUtq1J3A9a9BCb67no2NTgzDo15zLOIWq40CWRawaCeTBdv92S7gTr5wgD0RfQ/kVD18+A3qy8ziYHEDLla0ciPlaVR2QuU02TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzuZbzPS/8SccxKMMEm0P1jKXXA2L+HOeVktNFDkAxE=;
 b=baUf6A4igZV7budS2TwtkhrbaDrdWUcDVRjE6+iGTDV+Ik+GO+3kbRxZgY0DwVo6gNEdvs5GacHz7Rlf+XGZ6haWaPqwupGv85ivc7iAQaL8810rZQK3Q5JHjXKj9x1u6nN/6bxxkvGZ3LRD4/ZqG4DuZqBEnkZHuGPvMjmTClWNdrCHFHzIg598IzlVXHhPGw5M3mvpqUtPpU/eohSi7QNZKyjD3KDKtdobbTOWkukqyV2YGa6fP5zuf5ldkL1/HnuW1NVtbDz1jaC/k3ebvMx00qaVwJNT1L5oZSnUCYZqcN/Fjmbtbj5iEx8cn5FGfzVFj3VgeU4rkF1u+/GL9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzuZbzPS/8SccxKMMEm0P1jKXXA2L+HOeVktNFDkAxE=;
 b=JcHtSrVNrmjnfKQWaGeStrIGOiwbv/CF1koIvtbUIX4PX6vBAtGEp7h+xhJOHSu9Nt3DhlBibhI0h4jx1Gv160bDpcw9foVlEots1q8EK46ipsjD24U3wQkDGssmMsn6gog0YeheCzqH4T+vp08eGno75Zc5PXdNdyrYpgFJHwg=
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by PH0PR12MB5419.namprd12.prod.outlook.com (2603:10b6:510:e9::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Wed, 24 Nov
 2021 02:53:31 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::5515:f45e:56f5:b35a%3]) with mapi id 15.20.4713.022; Wed, 24 Nov 2021
 02:53:31 +0000
From: "Jian, Jane" <Jane.Jian@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "Chen, JingWen" <JingWen.Chen2@amd.com>
Subject: RE: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip
 init for SIENNA_CICHLID
Thread-Topic: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip
 init for SIENNA_CICHLID
Thread-Index: AQHX4F4ezNGXSZb8RkOg2WWoLl+E96wRNY4AgADFOaA=
Date: Wed, 24 Nov 2021 02:53:31 +0000
Message-ID: <PH0PR12MB5481EC5D76669F66CAB44F9EFF619@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211123113438.5200-1-Jane.Jian@amd.com>
 <BL1PR12MB514481ADF439A81349D03279F7609@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB514481ADF439A81349D03279F7609@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-23T15:02:34.329Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33c91294-60fb-4381-d0ed-08d9aef59977
x-ms-traffictypediagnostic: PH0PR12MB5419:
x-microsoft-antispam-prvs: <PH0PR12MB54194065DF26657462A9FBC0FF619@PH0PR12MB5419.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xg9wSfgC2RjQMsAJRS2I3fp9HfBukG3c+xEWAu9rnfWnETVeNyUITGdCHJirkIJvfkqRmw/alyQoPeVaZhN7M3DzsbvLi+m0mLlDGA9nVAdJIHTSQSaeD+qXWUtkUsHsvpocrpO13y4aLuPOPl7h+I36yNtlbhqofY/3V/zuXsesqyLAhbh7rkRUPJibKbZFDWBVVODV47XbAjjiZHZccMMwtS0vUhLqkUPdvFnrVKDbOGdIUEX0nzsSNU6SllSdp3z5JKv5GPsVTeRxK6Ap1Q99tu5wG2Z45EyN9qJqp5623sUXwTHa4JdpYq28uZoq/3xTKNvtgLUqAAAKuQjnttz74n49pmH2dTQukm3/HHpcrlz8fKOyaChchdLAT+ePBAfcLL7hjASagURLmfHRiFlkM7zRVu3TOWLjPgCKpqHwqtVP4vKYkDiBTm7iGvAs08X87iZuEws3ja5iFx0dsKvyjNFRl9iKG6B22hVRFUGoa4vC0YEBl2hEKMg6TE8hPIMjKD48jI4KPyO1wSfyR8uO4qooPh1lFTo81+fl/+Ar/WffbSTSVFEarWUwR7h8u4GLZFU4TIsBNvAuNDin2hZDnZAwSGm81Rg+wpxS6YZhs2GF9OTfkj9mHt4aUBROhihuKcJ4e+ttAzPN+pcN6MkjAvER4YWtp/djBt7nc44eSMMXO++5mkwOzNytTUqJYoh+4VuLOdNHcE7P1LZyGg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(66446008)(64756008)(66476007)(38100700002)(66556008)(122000001)(86362001)(83380400001)(33656002)(2906002)(316002)(66946007)(4326008)(9686003)(110136005)(55016003)(5660300002)(6636002)(53546011)(8936002)(8676002)(52536014)(26005)(508600001)(38070700005)(6506007)(71200400001)(186003)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4F5xGdYM39xI91RwLPFrPJK67SgpYdjB1qyF18YlBuVPcFfDJ/5d7a/AHQxr?=
 =?us-ascii?Q?xGkdwxN7jlgbOWzjmvCyA0Pr72hIgXzKc3yN/dxQPXHPG9k2fvYV1SkmrE1n?=
 =?us-ascii?Q?N+AiqB0lZwIV6UmccHqreMse82TC7FyK0OctiXnXOm/WQoj7CnLmAe2JiWul?=
 =?us-ascii?Q?q3R503gVsJsLDkZOaziJmkwotjKM4/BRmPBifR8kzb7kIBokyGEd6smyWrnE?=
 =?us-ascii?Q?FSIAk46fXVJP4S4cFue5H6qdEcXoFLgFU5+y/eP4nZMPz7W1VItBJ2G4Fn6F?=
 =?us-ascii?Q?ZxHaDPIackbcA60eCiPK567+2pu3UPcVAM/LzhKxsgPf/rz7c3JyhdeqIg+p?=
 =?us-ascii?Q?E/e3WqFwYD7w2RyZcsy2HKme4aoxMzOBKTQsk4i2FezO5Q5V2gxVC6lMm0VW?=
 =?us-ascii?Q?qR1f8H+MPSnSSbB8wneXXmf+HcHotJtSkiejm/k7tHpIm7/naa/qNtb1fVHJ?=
 =?us-ascii?Q?1lM1WowwhV731m0SOCPHO3XvOBx1eA+7KdCpEb3GgmsvZTBZ8n6W2UFei6qn?=
 =?us-ascii?Q?aXxPrD+esDUIl0wv+ZytUAHXTCmT4OFkgFGuCEvbFcQxFD3XeUsiwQR5ABrI?=
 =?us-ascii?Q?nNaQigPdC7zQzTkBa2TRsmTgrVptLLgxL0Beo/bArpfSp7yl/HQWC5w9fUjV?=
 =?us-ascii?Q?CTGdNz9tweueksRNIzt+5c7U2wqiG3ZrAh8IiRlDmWyIukIxKniOkVe0aEzc?=
 =?us-ascii?Q?fLQrsjvYR2kSOPbZH6TQy/OYCRMJSohJEKUG0G8aFflfgmfc3nes80q6HjTX?=
 =?us-ascii?Q?xZc3rA/IZXHjxj9qBqXS7KbTe2enZseu8h6Zzi9C0KUChXTwpV7P3SvL5gJf?=
 =?us-ascii?Q?21U1OnFpGi1qYuLoXEYz8ni1Td7rjr39vPGeEg9VHsypyljSL3Z2FUwU1Tdi?=
 =?us-ascii?Q?/IVsKHY0DW501+dw51ruVYXqnRKR9ThbNREI6Iq590fzNWybwfWkdQxGugDA?=
 =?us-ascii?Q?rh4oBecyH4uI9AkJ86TffoS3mxsKl/MNwda+SfE6n/OH3xtpBe48H6mPdUyb?=
 =?us-ascii?Q?y6AfrTjSzdw0lZOx5ap4hIV+vpiRAVsMxAiA58/PGnrjie3T40on49ZV1cGQ?=
 =?us-ascii?Q?oneCMBMWwQQZAxAoIBS+IKCXuEv/kRyGYXGHFfA9IznXSWh18MGOMeMar8Z9?=
 =?us-ascii?Q?O37hrwuOo5Lj/jDZlHeKFyQdKqRb5JFFEY65hqlpnIC4eFE/zyVjPAs67np9?=
 =?us-ascii?Q?/QSB/mf1ZwgtWXWJc4ySzdjfkQdqqF2hXmeUiBuC+6t/LJW+in337o9lVveJ?=
 =?us-ascii?Q?Vumgw/vm+eADsGFNpvUlbAowuNdKLMT41YmUS/HK6X3urSJNH2KM/UM/M6H3?=
 =?us-ascii?Q?omYuA3vSWIEWhLRPIaA3ZnXxfd7ZAjgWdW9c43efxm3AhJPS1GD1+G1meakq?=
 =?us-ascii?Q?eA21cu82HSHOhnM3JxLLQT3oUuB3/flQ9TMfhv5fxHqs1uOzrB12g7aILLNa?=
 =?us-ascii?Q?ztpnWNNzqJFUhTaL+9gIEYTtq1fiTyLi3R47wz6BS2lHwwCCz5xd9lPmIsEG?=
 =?us-ascii?Q?bQsHHxYr+3yRx3Dm1PE4xMgkINoUhKM8W7AhcZmbjGSmBc4L9jnuacSjO46C?=
 =?us-ascii?Q?70EroOKvWks4gYmIx9NWOR90eoessJYwqD5wzweJRd6HcNmDpvuDLs2397j3?=
 =?us-ascii?Q?tjLWQF3MErXonax9UpsUsWA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH0PR12MB5481EC5D76669F66CAB44F9EFF619PH0PR12MB5481namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c91294-60fb-4381-d0ed-08d9aef59977
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 02:53:31.3686 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3YLWzj7fgF9Hk1JYOoLiah9mqPuBa0AOJr9AzkPfpx2IALySDH2YFYMjPPX5fKghNNMUkTG65YpDgE0VfM5GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5419
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH0PR12MB5481EC5D76669F66CAB44F9EFF619PH0PR12MB5481namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Hi Guchun,

Per Alex's suggestion, we would better add a check for new vcn0 IP version,=
 which is a version only owned by sriov and a way that I originally did, ho=
w do you think?

Thanks,
Jane

From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Tuesday, November 23, 2021 11:03 PM
To: Jian, Jane <Jane.Jian@amd.com>; amd-gfx@lists.freedesktop.org; Chen, Gu=
chun <Guchun.Chen@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>
Subject: Re: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to i=
p init for SIENNA_CICHLID


[Public]

Can we just add a check for the new IP version in that case?  This looks re=
ally hacky.

Alex

________________________________
From: Jane Jian <Jane.Jian@amd.com<mailto:Jane.Jian@amd.com>>
Sent: Tuesday, November 23, 2021 6:34 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Deucher=
, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@amd.com>>; =
Chen, Guchun <Guchun.Chen@amd.com<mailto:Guchun.Chen@amd.com>>; Chen, JingW=
en <JingWen.Chen2@amd.com<mailto:JingWen.Chen2@amd.com>>
Cc: Jian, Jane <Jane.Jian@amd.com<mailto:Jane.Jian@amd.com>>
Subject: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip in=
it for SIENNA_CICHLID

[WHY]
for sriov odd# vf will modify vcn0 engine ip revision(due to multimedia ban=
dwidth feature),
which will be mismatched with original vcn0 revision

[HOW]
skip ip revision match case and continue use asic type to check

Signed-off-by: Jane Jian <Jane.Jian@amd.com<mailto:Jane.Jian@amd.com>>
Change-Id: I1ace32acbf3a13c0baac958508da1324ec387a58
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 4e3669407518..0a91e53f520c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1334,7 +1334,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_dev=
ice *adev)
                         return r;
         }

-       r =3D amdgpu_discovery_set_mm_ip_blocks(adev);
+       if (adev->asic_type =3D=3D CHIP_SIENNA_CICHLID && amdgpu_sriov_vf(a=
dev))
+               r =3D amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
+       else
+               r =3D amdgpu_discovery_set_mm_ip_blocks(adev);
         if (r)
                 return r;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index 4f7c70845785..87f56b61be53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -86,6 +86,10 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
         for (i =3D 0; i < adev->vcn.num_vcn_inst; i++)
                 atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);

+       if (adev->asic_type =3D=3D CHIP_SIENNA_CICHLID && amdgpu_sriov_vf(a=
dev)) {
+               fw_name =3D FIRMWARE_SIENNA_CICHLID;
+               goto next;
+       }
         switch (adev->ip_versions[UVD_HWIP][0]) {
         case IP_VERSION(1, 0, 0):
         case IP_VERSION(1, 0, 1):
@@ -168,6 +172,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
                 return -EINVAL;
         }

+next:
+
         r =3D request_firmware(&adev->vcn.fw, fw_name, adev->dev);
         if (r) {
                 dev_err(adev->dev, "amdgpu_vcn: Can't load firmware \"%s\"=
\n",
--
2.17.1

--_000_PH0PR12MB5481EC5D76669F66CAB44F9EFF619PH0PR12MB5481namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:#1F3864;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Hi Guch=
un,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Per Ale=
x&#8217;s suggestion, we would better add a check for new vcn0 IP version, =
which is a version only owned by sriov and a way that I originally did, how=
 do you think?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Thanks,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Jane <o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#1F3864"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Tuesday, November 23, 2021 11:03 PM<br>
<b>To:</b> Jian, Jane &lt;Jane.Jian@amd.com&gt;; amd-gfx@lists.freedesktop.=
org; Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Chen, JingWen &lt;JingWen.Ch=
en2@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check ca=
se to ip init for SIENNA_CICHLID<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Can we =
just add a check for the new IP version in that case?&nbsp; This looks real=
ly hacky.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Jane Jian &lt;</span><a href=3D"mailto:Jane.Jian@am=
d.com">Jane.Jian@amd.com</a><span style=3D"color:black">&gt;<br>
<b>Sent:</b> Tuesday, November 23, 2021 6:34 AM<br>
<b>To:</b> </span><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@=
lists.freedesktop.org</a><span style=3D"color:black"> &lt;</span><a href=3D=
"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><sp=
an style=3D"color:black">&gt;; Deucher, Alexander
 &lt;</span><a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher@=
amd.com</a><span style=3D"color:black">&gt;; Chen, Guchun &lt;</span><a hre=
f=3D"mailto:Guchun.Chen@amd.com">Guchun.Chen@amd.com</a><span style=3D"colo=
r:black">&gt;; Chen, JingWen &lt;</span><a href=3D"mailto:JingWen.Chen2@amd=
.com">JingWen.Chen2@amd.com</a><span style=3D"color:black">&gt;<br>
<b>Cc:</b> Jian, Jane &lt;</span><a href=3D"mailto:Jane.Jian@amd.com">Jane.=
Jian@amd.com</a><span style=3D"color:black">&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case t=
o ip init for SIENNA_CICHLID</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">[WHY]<br>
for sriov odd# vf will modify vcn0 engine ip revision(due to multimedia ban=
dwidth feature),<br>
which will be mismatched with original vcn0 revision<br>
<br>
[HOW]<br>
skip ip revision match case and continue use asic type to check<br>
<br>
Signed-off-by: Jane Jian &lt;<a href=3D"mailto:Jane.Jian@amd.com">Jane.Jian=
@amd.com</a>&gt;<br>
Change-Id: I1ace32acbf3a13c0baac958508da1324ec387a58<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 5 ++++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 6 ++++++<br>
&nbsp;2 files changed, 10 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index 4e3669407518..0a91e53f520c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -1334,7 +1334,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_dev=
ice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_discovery_set_mm_ip_bloc=
ks(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_SI=
ENNA_CICHLID &amp;&amp; amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_device_ip_block_add(adev, &amp;vcn_v3_0_ip_block);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_discovery_set_mm_ip_blocks(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c<br>
index 4f7c70845785..87f56b61be53 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
@@ -86,6 +86,10 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;vcn.num_vcn_inst; i++)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;adev-&gt;vcn.inst[i].dpg_enc_submissi=
on_cnt, 0);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CHIP_SI=
ENNA_CICHLID &amp;&amp; amdgpu_sriov_vf(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fw_name =3D FIRMWARE_SIENNA_CICHLID;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto next;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versio=
ns[UVD_HWIP][0]) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(1, 0, 0):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(1, 0, 1):<=
br>
@@ -168,6 +172,8 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+next:<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D request_firmware(&am=
p;adev-&gt;vcn.fw, fw_name, adev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;amdgpu_vcn: Can't load fi=
rmware \&quot;%s\&quot;\n&quot;,<br>
-- <br>
2.17.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_PH0PR12MB5481EC5D76669F66CAB44F9EFF619PH0PR12MB5481namp_--
