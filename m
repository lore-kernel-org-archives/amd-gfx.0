Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA2BC12002
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 02:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A61A960C40
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 02:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61A960C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 628A66E51C;
	Thu, 15 Jul 2021 02:56:18 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2077.outbound.protection.outlook.com [40.107.95.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 183E56E51C
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 02:56:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHLK0VXmGt4xAdK7BZog/DkdKEcsxPlIhgm0SsKld7z0mmP/Fbt8C8tlrZE0WjtfSc1l04xDN9YC1QucWcnncxczXheU9TLQcr8C0dhQFdAb1BHrumbwBBJvB4lLNpxJodr+lrTsGCRbeNz9PYarRbUtjSx+bUGHOUmC8iVc8Xu6ppNinF1yNd6US0ufg604wXMMlvoYGzTvTTjj1EePzzCfLSW8+rvdcZomXFxCqfd11hK0RnSxwZkZYSEkGidKNRXwo2NHlLcFi2RflxXI5n8xSPktHiDIv/8P4qNtS/CDozsmP7TbCe0YIaHKBsD/SjG7dD/FxWkLFDn70l21tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=la5flVheqZIFJJwklF9J0yMauMVUvfmmk8k2daVrUBw=;
 b=cX3K6jbij/aswUnNu5gN8mKFViJ1rhxXvRZRgPkCspLF+ZBfTweimeDSbHB7ZM+pOsNP3fhrSCIkFJrAqOO44K6H6BbMqq7KkykKRd1CNkCaqxrV6KRyE/L4Z1bBiKtC7DsqrCB+K99aB0IjZ4zYFtRmnY13xtSp08+MrswrnTR5Hm8q7JwkOcr1P4jZrU+XZda+L6L2thYHBsXebGOMWF395uhg7GVTX3vos7gZJadmLzUvapovcp3MgOuEZZsfepMXYDDSo+52pg7oa0Jvo7vSvXJZF6XEy21Kg6MW/0Mj5Xfy9d0qZ+XdbpANotCPYgh7yprultKKyJW6JKmNKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=la5flVheqZIFJJwklF9J0yMauMVUvfmmk8k2daVrUBw=;
 b=WODEMVxIfGwvls+ylZN4UjpXtVJhiadKRZ8Wh30bt9z31txlV4tR426wWCk4UrMgUPUcrOEJfaUTGMbMI1y95U9smOAB9N7M+VBw6es3zycqZmQYPER64FSTl1y+EcFEcILkqnPbCzcSKhPvau8J71r0o6EsKCyF35mLO1w2xsM=
Received: from BY5PR12MB5557.namprd12.prod.outlook.com (2603:10b6:a03:1d4::18)
 by SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 02:56:14 +0000
Received: from BY5PR12MB5557.namprd12.prod.outlook.com
 ([fe80::303b:d360:bb4:113c]) by BY5PR12MB5557.namprd12.prod.outlook.com
 ([fe80::303b:d360:bb4:113c%3]) with mapi id 15.20.4308.027; Thu, 15 Jul 2021
 02:56:14 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Alex Deucher
 <alexdeucher@gmail.com>, "Zeng, Oak" <Oak.Zeng@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: Fix a printing message
Thread-Topic: [PATCH 2/3] drm/amdgpu: Fix a printing message
Thread-Index: AQHXeMSN7iFzb4fhxUCvcPwEdg0/UKtCndGAgAC3YCCAAALDAIAAADlQ
Date: Thu, 15 Jul 2021 02:56:14 +0000
Message-ID: <BY5PR12MB5557666C58D614BBB04E24FAEA129@BY5PR12MB5557.namprd12.prod.outlook.com>
References: <1626276343-3552-1-git-send-email-Oak.Zeng@amd.com>
 <1626276343-3552-3-git-send-email-Oak.Zeng@amd.com>
 <CADnq5_PE+K2eTtA7-RZqKuqc+8QhEm-v55Mbe8XdbhWeLevEwA@mail.gmail.com>,
 <BY5PR12MB555790C9B5367DADD19AD75CEA129@BY5PR12MB5557.namprd12.prod.outlook.com>
 <BL1PR12MB5144FEA90EEBC65A9C0EEAAEF7129@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144FEA90EEBC65A9C0EEAAEF7129@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-15T02:54:36.171Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1589d5a-b231-4ab8-bde4-08d9473c1c49
x-ms-traffictypediagnostic: SJ0PR12MB5469:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR12MB5469CEAA2244A294AC3F51E6EA129@SJ0PR12MB5469.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i5r80JpswA61MAMmtt/D31EcgASNM4cG7JJTg/vqGMoDJ1SGfW+z5lwyZU3+LZM7By5EC16Q1Vu63IRgw4npxud3Kv/v/ARmGmwL1mpkFuh8dKHxKcDNnXfHrICOWlSoZ61/PTA056nPbFin3MiTUvBXhuXAVa3p81zpvFkvuboPjbetfxzp9C0b8aIvfHgv8KGRz1w4FVRGBfyHitUgfXQZqY6xhYKNnSSA2SmcpLsfzU1yoQfE5DDSbTsdtUWyf7yohlA48ZQk4IqwIf1XSoWXaVrbVPb4v3CZwdZ3QyNSjiUAQCuIUNibzcRZbD8kiq4XctoaV1qcNsDRCgXtXEuupyD6Oh9fKWfVKGkTo0QRov3NKV3NiXD84OeIquUOsIUYVmCmBd8UfSUCItYwd6YZkmJ9is1d/zd2dkO7HMarEEq5KkdpWfeGNX8MUqKFySKNnBf4Dw9t/oKlKCmLA/qnhvqmOn3I0TuFoBj7Zf1tTX+DEdpVuNWdUw3aXZmz0IINeY+Yyp3pJR/CMcKNw7iJwLLQvH1aCDnpA9+Ug82M9/9nhcFrezy7ALS4wL+WDPOhhq3SNmQ1+9NwrEx2munbTOBLheXJCgxMarx+mPqKb5nXqF3H+9P5ueGMclw4dUYiAV8dep9L3GXiF2WTOyc8Ejt4SQnsdKTgf7scRviHju11Cs7+hc21AlksOJ7A+q8vi0kc+KxzOWKlGhSM3zcxxN7reS7mMIuJft86mSYvFvj74u+daL0eBqQzoH4vKx/OpvYRspqqO5KuObvlMco2gWK7ciKhgO+Y3APGzbI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(38100700002)(186003)(54906003)(8936002)(66556008)(110136005)(45080400002)(66476007)(66946007)(8676002)(316002)(64756008)(6506007)(53546011)(66446008)(33656002)(166002)(9686003)(26005)(122000001)(76116006)(83380400001)(2906002)(86362001)(966005)(5660300002)(15650500001)(71200400001)(7696005)(4326008)(55016002)(52536014)(478600001)(6636002)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HVqhTTFBtzH3HmUKuq5ye2jwSAR+IcuAOQSX47/HQnlPYn5vKtCwEhhZPk8M?=
 =?us-ascii?Q?0xS+JDAthZSeALuyK6gB5SRPAuI4KmJ7oCh36p3jHqYz9eGEDWaWAwWEvYtL?=
 =?us-ascii?Q?8zWKzYvp7mAlgdAFvaEpYZqtRtozagtv+92EIFU1GicA0X27kb2l+fAmxV1X?=
 =?us-ascii?Q?51nsHigDgrjNNhT1V9J1hWJQEBmq3yvVI+7mp/Buk+F1IAORLr9TNnxQnCaW?=
 =?us-ascii?Q?uMz8IbsDX83lUbtFae5NKM9kHn9k3RY8o6rrxWodKMKjItFk6iFTzwQZh+ug?=
 =?us-ascii?Q?MLAylGEDEKI7jXVNtT6PENlt3xTDfBN8D2Ci3i25L5L5wjZLdVn/Pr1z36xK?=
 =?us-ascii?Q?3VNrh/UzYt0DxpNq22Q8ZC2JkAwIIyHmdv0yrF6ljka9G/4Z+USmacyWUmQm?=
 =?us-ascii?Q?lqGchnC1JEdfsg3FMrCPNA12SbxhXGZdqJWZTc1sXJbQ7DB3CRLNAihd39bR?=
 =?us-ascii?Q?h0VsNVBq117pD7nntKgnit8jRb8vdApHJsGo/DAR8BbOJhJxwwVDkocegtp/?=
 =?us-ascii?Q?/Q6I+MKKUPexMxPa/hRsNRNWN0hUrTy+aug4mZWw4+q3E6Gz/+xWVgrYUCWs?=
 =?us-ascii?Q?JOLXDavERQjaFIXaRlc0wTciU4yowZqbU4RbLfrHUN+knbptikyhn6y3vn9C?=
 =?us-ascii?Q?hq0yw/P0Ro9ncItPZ9jdgk7pwhqdfe8HmyfuKuQom8SMlp3yj5+nKKJI0Ga9?=
 =?us-ascii?Q?YrG2LPGDJRWsdmfs18PmDeV0dCiNk3YaTAyOaQe0iqAGqA4UPbT1nkpUc06Z?=
 =?us-ascii?Q?GkDWtbmv9uHxtsdvb53Vx5c55RhQ5616TvpmbRExqgoBb1P1rL+BrZ0pD02N?=
 =?us-ascii?Q?egGVvOGr3lDUSBxPIUCoCBHPYypE/S0ors8K+ekgLwH08U2Rq2tYESBvWcYp?=
 =?us-ascii?Q?53Zxa0V5j4AUTkre1cE/IKLCbaoZ/PLiu9EVUZ1pbelw81afuwVs0iWE47j3?=
 =?us-ascii?Q?aOpVpqEtQNXpzvgaodQt2eMSRrxrx9AhQmtsA6lU7Pl202Og0VueOq/VAU1L?=
 =?us-ascii?Q?UoWRuWOLYGa61Caonpc3UIaHoTU8h8LHUG+WqZKP+SKcpXPdxh8PE1bxv3f7?=
 =?us-ascii?Q?B5cdmxOJmZxMzdEhrSYaimd2wi604ug2v1MrGWn2rnuBME1uuVCIaMiUp+nT?=
 =?us-ascii?Q?dva7dGUjJv9bTyH/1K6GLLnflOkcC2QJ7dS9OC4wH/3jQIH5TkRJaj2cloea?=
 =?us-ascii?Q?HcuaLJHzZ8QUUD2XdUb6l/dw2n+JMH1rtFg3+JhMSbLF+9g5bHVxYBE95Mok?=
 =?us-ascii?Q?9oB0L+Vc2h2ope5P9YBwOdt/am3SdgHmGDj5Adxwzz5bcoRzxA+SZCE8aaWW?=
 =?us-ascii?Q?otaB3fqzzCQiZvQSzAfwo2Ps?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1589d5a-b231-4ab8-bde4-08d9473c1c49
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 02:56:14.5839 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ZWkz4jB9V7A7MCDm6gt1x3dE4VR+PntMdEunhv05EWMzT49NFZkCsFzI0qN3fAVnhWGE202/YPQe6do5JTidQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5469
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1545704930=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1545704930==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY5PR12MB5557666C58D614BBB04E24FAEA129BY5PR12MB5557namp_"

--_000_BY5PR12MB5557666C58D614BBB04E24FAEA129BY5PR12MB5557namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Ok, I see. Thanks!

Regards,
Jiansong
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Thursday, July 15, 2021 10:55 AM
To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Alex Deucher <alexdeuch=
er@gmail.com>; Zeng, Oak <Oak.Zeng@amd.com>
Cc: Xu, Feifei <Feifei.Xu@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com=
>; Liu, Leo <Leo.Liu@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>=
; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: Fix a printing message


[Public]

I think it's more consistent to use dev_info since we already use that pret=
ty extensively in the driver.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Chen, Jiansong (Simon) <Jiansong.Chen=
@amd.com<mailto:Jiansong.Chen@amd.com>>
Sent: Wednesday, July 14, 2021 10:51 PM
To: Alex Deucher <alexdeucher@gmail.com<mailto:alexdeucher@gmail.com>>; Zen=
g, Oak <Oak.Zeng@amd.com<mailto:Oak.Zeng@amd.com>>
Cc: Xu, Feifei <Feifei.Xu@amd.com<mailto:Feifei.Xu@amd.com>>; Kuehling, Fel=
ix <Felix.Kuehling@amd.com<mailto:Felix.Kuehling@amd.com>>; Liu, Leo <Leo.L=
iu@amd.com<mailto:Leo.Liu@amd.com>>; amd-gfx list <amd-gfx@lists.freedeskto=
p.org<mailto:amd-gfx@lists.freedesktop.org>>; Zhang, Hawking <Hawking.Zhang=
@amd.com<mailto:Hawking.Zhang@amd.com>>
Subject: RE: [PATCH 2/3] drm/amdgpu: Fix a printing message

[Public]

[Public]

Hi Alex,
Is DRM_DEV_INFO more suitable than dev_info as far as DRM subsystem is conc=
erned? Thanks!

Regards,
Jiansong
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Alex Deucher
Sent: Wednesday, July 14, 2021 11:48 PM
To: Zeng, Oak <Oak.Zeng@amd.com<mailto:Oak.Zeng@amd.com>>
Cc: Xu, Feifei <Feifei.Xu@amd.com<mailto:Feifei.Xu@amd.com>>; Kuehling, Fel=
ix <Felix.Kuehling@amd.com<mailto:Felix.Kuehling@amd.com>>; Liu, Leo <Leo.L=
iu@amd.com<mailto:Leo.Liu@amd.com>>; amd-gfx list <amd-gfx@lists.freedeskto=
p.org<mailto:amd-gfx@lists.freedesktop.org>>; Zhang, Hawking <Hawking.Zhang=
@amd.com<mailto:Hawking.Zhang@amd.com>>
Subject: Re: [PATCH 2/3] drm/amdgpu: Fix a printing message

On Wed, Jul 14, 2021 at 11:25 AM Oak Zeng <Oak.Zeng@amd.com<mailto:Oak.Zeng=
@amd.com>> wrote:
>
> The printing message "PSP loading VCN firmware" is mis-leading because
> people might think driver is loading VCN firmware. Actually when this
> message is printed, driver is just preparing some VCN ucode, not
> loading VCN firmware yet. The actual VCN firmware loading will be in
> the PSP block hw_init. Fix the printing message
>
> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com<mailto:Oak.Zeng@amd.com>>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 2 +-
> drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 +-
> drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-
> drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 284bb42..1f8e902 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -119,7 +119,7 @@ static int vcn_v1_0_sw_init(void *handle)
>                 adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw =3D adev->vc=
n.fw;
>                 adev->firmware.fw_size +=3D
>                         ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SI=
ZE);
> -               DRM_INFO("PSP loading VCN firmware\n");
> +               DRM_INFO("VCN 1.0: Will use PSP to load VCN
> + firmware\n");
>         }
>
>         r =3D amdgpu_vcn_resume(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 8af567c..ebe4f2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -122,7 +122,7 @@ static int vcn_v2_0_sw_init(void *handle)
>                 adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw =3D adev->vc=
n.fw;
>                 adev->firmware.fw_size +=3D
>                         ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SI=
ZE);
> -               DRM_INFO("PSP loading VCN firmware\n");
> +               DRM_INFO("VCN 2.0: Will use PSP to load VCN
> + firmware\n");

While you are here, switch to dev_info() so we get the device information i=
n the output (in case we have multiple GPUs in a system).

Alex

>         }
>
>         r =3D amdgpu_vcn_resume(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 888b17d..5741504 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -152,7 +152,7 @@ static int vcn_v2_5_sw_init(void *handle)
>                         adev->firmware.fw_size +=3D
>                                 ALIGN(le32_to_cpu(hdr->ucode_size_bytes),=
 PAGE_SIZE);
>                 }
> -               DRM_INFO("PSP loading VCN firmware\n");
> +               DRM_INFO("VCN 2.5: Will use PSP to load VCN
> + firmware\n");
>         }
>
>         r =3D amdgpu_vcn_resume(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index c3580de..b81eae3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -158,7 +158,7 @@ static int vcn_v3_0_sw_init(void *handle)
>                         adev->firmware.fw_size +=3D
>                                 ALIGN(le32_to_cpu(hdr->ucode_size_bytes),=
 PAGE_SIZE);
>                 }
> -               DRM_INFO("PSP loading VCN firmware\n");
> +               DRM_INFO("VCN 3.0: Will use PSP to load VCN
> + firmware\n");
>         }
>
>         r =3D amdgpu_vcn_resume(adev);
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CJi
> ansong.Chen%40amd.com%7C051da5b064d944f4c0a908d946ded869%7C3dd8961fe48
> 84e608e11a82d994e183d%7C0%7C0%7C637618745208108548%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C1000&amp;sdata=3DWpGaXXjVSQEjcRgg0E%2FUjRMZT%2FDRe05nwG6xiDJjRbk%3D&
> amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7Ce7e186e3c28f4131fdc008d9473b8643%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637619143252510438%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3D1rIdDQqiz9t9NVditEbTRR6qeqvucqhCvnsg7obVA9c%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7Ce7e186e3c28f4131fdc008d9473b8643%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637619143252520390%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DZhcsiGqrIcLHktlp0RBx1qwFJp6RI0nP%2BFFUxddKlRo%3D&amp;reserved=3D0

--_000_BY5PR12MB5557666C58D614BBB04E24FAEA129BY5PR12MB5557namp_
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
	color:blue;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Ok, I see. Thanks!<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Jiansong<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Thursday, July 15, 2021 10:55 AM<br>
<b>To:</b> Chen, Jiansong (Simon) &lt;Jiansong.Chen@amd.com&gt;; Alex Deuch=
er &lt;alexdeucher@gmail.com&gt;; Zeng, Oak &lt;Oak.Zeng@amd.com&gt;<br>
<b>Cc:</b> Xu, Feifei &lt;Feifei.Xu@amd.com&gt;; Kuehling, Felix &lt;Felix.=
Kuehling@amd.com&gt;; Liu, Leo &lt;Leo.Liu@amd.com&gt;; amd-gfx list &lt;am=
d-gfx@lists.freedesktop.org&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&g=
t;<br>
<b>Subject:</b> Re: [PATCH 2/3] drm/amdgpu: Fix a printing message<o:p></o:=
p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">I think=
 it's more consistent to use dev_info since we already use that pretty exte=
nsively in the driver.&nbsp;&nbsp;<o:p></o:p></span></p>
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
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Chen, Jiansong (Simon) &lt;<a href=3D"mailto:Jiansong.Chen@amd.com">Jians=
ong.Chen@amd.com</a>&gt;<br>
<b>Sent:</b> Wednesday, July 14, 2021 10:51 PM<br>
<b>To:</b> Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexde=
ucher@gmail.com</a>&gt;; Zeng, Oak &lt;<a href=3D"mailto:Oak.Zeng@amd.com">=
Oak.Zeng@amd.com</a>&gt;<br>
<b>Cc:</b> Xu, Feifei &lt;<a href=3D"mailto:Feifei.Xu@amd.com">Feifei.Xu@am=
d.com</a>&gt;; Kuehling, Felix &lt;<a href=3D"mailto:Felix.Kuehling@amd.com=
">Felix.Kuehling@amd.com</a>&gt;; Liu, Leo &lt;<a href=3D"mailto:Leo.Liu@am=
d.com">Leo.Liu@amd.com</a>&gt;; amd-gfx list &lt;<a href=3D"mailto:amd-gfx@=
lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>&gt;;
 Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zhang@=
amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 2/3] drm/amdgpu: Fix a printing message</span> <=
o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[Public]<br>
<br>
[Public]<br>
<br>
Hi Alex,<br>
Is DRM_DEV_INFO more suitable than dev_info as far as DRM subsystem is conc=
erned? Thanks!<br>
<br>
Regards,<br>
Jiansong<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of Alex Deucher<br>
Sent: Wednesday, July 14, 2021 11:48 PM<br>
To: Zeng, Oak &lt;<a href=3D"mailto:Oak.Zeng@amd.com">Oak.Zeng@amd.com</a>&=
gt;<br>
Cc: Xu, Feifei &lt;<a href=3D"mailto:Feifei.Xu@amd.com">Feifei.Xu@amd.com</=
a>&gt;; Kuehling, Felix &lt;<a href=3D"mailto:Felix.Kuehling@amd.com">Felix=
.Kuehling@amd.com</a>&gt;; Liu, Leo &lt;<a href=3D"mailto:Leo.Liu@amd.com">=
Leo.Liu@amd.com</a>&gt;; amd-gfx list &lt;<a href=3D"mailto:amd-gfx@lists.f=
reedesktop.org">amd-gfx@lists.freedesktop.org</a>&gt;;
 Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zhang@=
amd.com</a>&gt;<br>
Subject: Re: [PATCH 2/3] drm/amdgpu: Fix a printing message<br>
<br>
On Wed, Jul 14, 2021 at 11:25 AM Oak Zeng &lt;<a href=3D"mailto:Oak.Zeng@am=
d.com">Oak.Zeng@amd.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The printing message &quot;PSP loading VCN firmware&quot; is mis-leadi=
ng because<br>
&gt; people might think driver is loading VCN firmware. Actually when this<=
br>
&gt; message is printed, driver is just preparing some VCN ucode, not<br>
&gt; loading VCN firmware yet. The actual VCN firmware loading will be in<b=
r>
&gt; the PSP block hw_init. Fix the printing message<br>
&gt;<br>
&gt; Signed-off-by: Oak Zeng &lt;<a href=3D"mailto:Oak.Zeng@amd.com">Oak.Ze=
ng@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 2 +-<br>
&gt; drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 +-<br>
&gt; drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-<br>
&gt; drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-<br>
&gt;&nbsp; 4 files changed, 4 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
&gt; index 284bb42..1f8e902 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
&gt; @@ -119,7 +119,7 @@ static int vcn_v1_0_sw_init(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN].fw =
=3D adev-&gt;vcn.fw;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.fw_size +=3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A=
LIGN(le32_to_cpu(hdr-&gt;ucode_size_bytes), PAGE_SIZE);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DRM_INFO(&quot;PSP loading VCN firmware\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DRM_INFO(&quot;VCN 1.0: Will use PSP to load VCN<br>
&gt; + firmware\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vcn_resum=
e(adev);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
&gt; index 8af567c..ebe4f2b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
&gt; @@ -122,7 +122,7 @@ static int vcn_v2_0_sw_init(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN].fw =
=3D adev-&gt;vcn.fw;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;firmware.fw_size +=3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A=
LIGN(le32_to_cpu(hdr-&gt;ucode_size_bytes), PAGE_SIZE);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DRM_INFO(&quot;PSP loading VCN firmware\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DRM_INFO(&quot;VCN 2.0: Will use PSP to load VCN<br>
&gt; + firmware\n&quot;);<br>
<br>
While you are here, switch to dev_info() so we get the device information i=
n the output (in case we have multiple GPUs in a system).<br>
<br>
Alex<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vcn_resum=
e(adev);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<br>
&gt; index 888b17d..5741504 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c<br>
&gt; @@ -152,7 +152,7 @@ static int vcn_v2_5_sw_init(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
dev-&gt;firmware.fw_size +=3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(le32_to_cpu(hdr-&gt;uc=
ode_size_bytes), PAGE_SIZE);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DRM_INFO(&quot;PSP loading VCN firmware\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DRM_INFO(&quot;VCN 2.5: Will use PSP to load VCN<br>
&gt; + firmware\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vcn_resum=
e(adev);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
&gt; index c3580de..b81eae3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
&gt; @@ -158,7 +158,7 @@ static int vcn_v3_0_sw_init(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
dev-&gt;firmware.fw_size +=3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ALIGN(le32_to_cpu(hdr-&gt;uc=
ode_size_bytes), PAGE_SIZE);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DRM_INFO(&quot;PSP loading VCN firmware\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; DRM_INFO(&quot;VCN 3.0: Will use PSP to load VCN<br>
&gt; + firmware\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vcn_resum=
e(adev);<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedes=
ktop.org</a><br>
&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flist">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist</a=
><br>
&gt; s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C0=
1%7CJi<br>
&gt; ansong.Chen%40amd.com%7C051da5b064d944f4c0a908d946ded869%7C3dd8961fe48=
<br>
&gt; 84e608e11a82d994e183d%7C0%7C0%7C637618745208108548%7CUnknown%7CTWFpbGZ=
<br>
&gt; sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3=
<br>
&gt; D%7C1000&amp;amp;sdata=3DWpGaXXjVSQEjcRgg0E%2FUjRMZT%2FDRe05nwG6xiDJjR=
bk%3D&amp;<br>
&gt; amp;reserved=3D0<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7Ce7e186e3c28f4131fdc008d9473b8643%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637619143252510438%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3D1rIdDQqiz9t9NVditEbTRR6qeqvucqhCvnsg7obVA9c%3D&amp;a=
mp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Calexander.deucher%40amd.com%7Ce7e186e3c28f4131fdc008d9473b8643=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637619143252510438%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C1000&amp;amp;sdata=3D1rIdDQqiz9t9NVditEbTRR6qeqvucqhCvnsg7obVA9c%3D=
&amp;amp;reserved=3D0</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7Ce7e186e3c28f4131fdc008d9473b8643%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637619143252520390%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DZhcsiGqrIcLHktlp0RBx1qwFJp6RI0nP%2BFFUxddKlRo%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7Ce7e186e3c28f4131fdc008d9473b86=
43%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637619143252520390%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3DZhcsiGqrIcLHktlp0RBx1qwFJp6RI0nP%2BFFUxddKlR=
o%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BY5PR12MB5557666C58D614BBB04E24FAEA129BY5PR12MB5557namp_--

--===============1545704930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1545704930==--
