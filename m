Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870C5C77B61
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 16:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1C6510E032;
	Mon, 10 Apr 2023 16:47:30 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DAFC10E032
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 16:47:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7tJ2ydh3L4WsBfoCBI9kgEfz3XGWf9Pc34u3ddmETOqAYSyn/0tJrd9uoaDcyq5XKi3BNLiJSgtHDJwQT0LwxeVG9nWJVVhYP/wocHrvoLyX6Yj2R6fa8XvhRwhlmgO40OlCyu+VLHOPniYo3gNnE92/7kpIXiXhqiJ8UyL6B87WiDg8eeCEIF8csNdHWeruhl48+B8/WJEScQWg8BSEMUvBGMyH5IFdAfvIsNgmj3zMGbylcAHFS3px3/jZDg9qvsxJ4tX//5MQfnMYL04PUEx82Beftsj8kumOMQ0RRzBzrCgolO34JyR/sVSfSsdH5sJ546wOlT/01xd/YAuDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amPmDXuyPjSMt2yHxuRJgXAyDU6K4Upnzetr9fp/2ww=;
 b=if9r+5Dn8JlndfpdZHQUu8C8GUkYeeNeSaHrB4hLAecsCo7Ce45/OE3OYKvZtbEVioTXVRueRCOBrWuAYkdqVHfILVF/9LoO5d7nED+tUyjy0A07FpHQFluKJ7wcwv1VhF0LmBFUJ1wwk6+WBZwfdObcojA3pUeC4XwPmLZdepXBNHEkXrmSjH0lVNry0dwR4raO4SKZ7VGJI1Thrp3bd42bFihPbvRc9wHo6T4C4DhoidVU5EkNnMB9HsVTwqx3/bLi0S5pe8xyD0fcrcICn+AOO0W28wxpac6wqq9v9HHwUXRrUwYKBKI7IO2siJIwPM1k8bz3fCScwVxu7ydx6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amPmDXuyPjSMt2yHxuRJgXAyDU6K4Upnzetr9fp/2ww=;
 b=PcGDdpUXr+tO6rRnpJNnchE4QNURbgivfhcDlBcvnoOask+JK7+P+EdgoKkaB9GVrz6JXCOwoIHx5eBvrCbWsfpXonOj5vxgQ+2s1CYgF2Th7OwzSx+RdgG0c29m7bjAAXDn9yQJkLWxVViviXnLQVmzJSfJR//qOGrSxyVYzZU=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by BL3PR12MB6401.namprd12.prod.outlook.com (2603:10b6:208:3b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Mon, 10 Apr
 2023 16:47:25 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::4d0e:a57d:65d0:1e63]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::4d0e:a57d:65d0:1e63%4]) with mapi id 15.20.6277.036; Mon, 10 Apr 2023
 16:47:25 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Somasekharan, Sreekant" <Sreekant.Somasekharan@amd.com>
Subject: RE: [PATCH] drm/amdkfd: On GFX11 check PCIe atomics support and set
 CP_HQD_HQ_STATUS0[29]
Thread-Topic: [PATCH] drm/amdkfd: On GFX11 check PCIe atomics support and set
 CP_HQD_HQ_STATUS0[29]
Thread-Index: AQHZZmbCA2ZPzf+tAEKr7pelPDereK8kv9dw
Date: Mon, 10 Apr 2023 16:47:25 +0000
Message-ID: <DM6PR12MB30674EAFFB58990B824619B48A959@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20230403195839.80419-1-sreekant.somasekharan@amd.com>
In-Reply-To: <20230403195839.80419-1-sreekant.somasekharan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-04-10T16:47:23Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=19f9f7fb-617a-49b4-a2a1-3d534147d3d5;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-04-10T16:47:23Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: a4da02c0-ad95-4cc1-8b79-a2050db7ebef
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3067:EE_|BL3PR12MB6401:EE_
x-ms-office365-filtering-correlation-id: f25915d6-1de0-4239-db16-08db39e34354
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a1Y+KZnGabfC7WaEaShA5RQg5TFE2sPleu9XO2k6MD89oEv3jTEyKUrdS76fUUvxCxvUOEIVSRLz0datNAY5W5WSEE37AsDKbfg5Kcn6F8+NaAXmSTgRUbro6BVfRmsNERvOOqanQTF0XyKUeVg7pIALbJrrpdowuhJj28Ap8QUHNvM4ouBMLzyiVWdcXz2gKaK0i0fckC0OSERg10xOiyUIyVf9TkZ5QNalQ9DSpBjKz50BxaFTWr4Vvk8SxI1HoiK8sA+hjX8vXN8yoyuCR5ZGzb43gOo71SxGURzJXPCu+3u97ENADpGHTUiFjxXyd7fG8t0HLIjpn93HQkEN/TNO9N0tRNz25EygX7AXRGsJRRWSl3AvokEDjX5rmk88qKQ0VPnn9kc34SFIDzNNPf9Vxih6MwsqsgdXJ4wEjY9ihO8jXi2Fa2P8/YBUWF4ZSZ/JJZ9qOyl6Nq9KAVsAbp0+SdyMBcyrFDuR9YGpHqW4UmVS5g6A09lHTRnAQheFo0f5gUoz9cvetuOIRG3BT2/8d0G5TUIF0ver91XpP65jLaAx28jwGT9XDhhhNJ9DNpq81Mxdy69vYnqoN4sKyLXde11HiEKXQJqoeija5KZ2qNGFUyCF0itoaFo0vxOh
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199021)(122000001)(55016003)(53546011)(76116006)(66946007)(66476007)(66556008)(478600001)(64756008)(8676002)(6636002)(52536014)(8936002)(316002)(66446008)(38100700002)(110136005)(41300700001)(5660300002)(83380400001)(7696005)(186003)(71200400001)(9686003)(6506007)(26005)(86362001)(33656002)(2906002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y2GVRNuz94t1kZIgl53JpC40X862wb1WKueEoBeynBpQC020M72gECt79JPf?=
 =?us-ascii?Q?HnBv9NroAlkyT0j/944q+Uf1ml0M6Tn3buLK0y3d5JeaZ7i3lKA/ET5fNyqu?=
 =?us-ascii?Q?H84lt82/6pleU+f+u8YeI97mpvkc77c/kzwwn9I/HDqkzfcCwQZd3YrDKTxp?=
 =?us-ascii?Q?gbDXokaZN6OtUx+IS6LYVxNDaH0kcsuDqY8Nbvyvu9cH1wHEwPbELsPLS8Z+?=
 =?us-ascii?Q?ibWeXVKixhfLxb805k2Yz8cRp3LlSlT9z1ea75fNBi3fgD6jJFMJTlh2s6H+?=
 =?us-ascii?Q?xV8oDqNByhfZ4tZ1s8QH8+9U9xAY3OyVxv19qGqAgDcnCMinHi4Mz6H3AWiR?=
 =?us-ascii?Q?IspIvhIjRerXIzP1fwlDYWHP5yeV7E9gJPvaxcQjsZed4ZLhaRCHB1IKSUBg?=
 =?us-ascii?Q?hY8gESUOa6t/kYi+mJAskYQcSOTnxNtLDNm/V62Cx6x9bRMujTn52MtK8WG5?=
 =?us-ascii?Q?HvJ/LbQyf8Jhx9QwcRGE1P4E1pBjxsf9EM6T6Xs4oSlt7zEFBFkzSKfz1tbo?=
 =?us-ascii?Q?wXwdrJTneGSh3HgUefo30wi81svjCVf8VW1Qc2pOq2GRx/UE41QhQc8U1NUh?=
 =?us-ascii?Q?zGZCzh/4Yot41oiHQuV/BCP/Z4RzPgEkf/AJR3cXqHmYw9oVko6e+44ZmWnv?=
 =?us-ascii?Q?UoKA9EovzeS1eQjzQOFPk61C9Q4E5kAaSSFVSts8ys8ZWFqhNX4DmAEF/XSD?=
 =?us-ascii?Q?kXrawPqc7tnC1zha2xWSvc5qOvRR6tWuI/fflakAXIh7OCVCBD3ZLhpXt8UK?=
 =?us-ascii?Q?VqNKwWXnCPutylU8XCikUx1Gq/kV7eb3uhCpxVzQJaGUJie/eFarePVZUZj8?=
 =?us-ascii?Q?WAZivF0RVkWbf1DyCcCrPyAOeNJHJntE5DSWWgZ6Ag6WwO7/zOh+Fu3K/AoT?=
 =?us-ascii?Q?VC/c6SPKYPuAEG54H37ssUc6xgvPyWKH0ixW1dcikNANRBJO1hDPkkD1rd7+?=
 =?us-ascii?Q?uIHmML8vx+6T8zU6iLVPSnrxlXZxBAfKGfazcVtebCBN8VTa7A97CKYLysSA?=
 =?us-ascii?Q?q0zA6B4+9TkMpw1YWCp8vs0gArfz23zXo0UKv7kUwH1iUhEgtShMNJvc1KOP?=
 =?us-ascii?Q?64jvrtb2cYbZkjQgcanVoM4Vly+luTPMLWerjG2BihrzbRUY4JXuCKRI1XyN?=
 =?us-ascii?Q?Gp5tVmECE2gpzICqkXHve9ggIjCPiUxcbUxL18t74kGvELwPWn9s7kUlN7k0?=
 =?us-ascii?Q?X+/ObPG6pLJ2L+gl1W1bf9NAnD86vNNHL3kidQ1PR2TNg0TQ3E6uH6ElcdjP?=
 =?us-ascii?Q?06cqk/CpspcbxuKQzerHfcMMl24DuHqVWwWJ7FlsZmYQQcFZxPp5iomCgXbY?=
 =?us-ascii?Q?JL9/+VrWSsabvNSlM7Oxm08vUgsQasw+agUWJUOIHcGOtXV2DwnoOmHJhwM7?=
 =?us-ascii?Q?/KyyzBdWrqweVR9QY1o22RokeVJpShzIzampsqF7kAwoTBCOlsxtYuVWQkJ4?=
 =?us-ascii?Q?TiTcfIjeSdvCRCnj2cRdgqTDacNlz2Ml/4e3zNkolnM7ddmpnjGRLYYazd+I?=
 =?us-ascii?Q?wmYEmPDV2yBQPNJmpiFUlYCvBxF23G+/TSpXly5G95BHxppwxIgqeiPQytgC?=
 =?us-ascii?Q?xd0wjuJFVRg/+NOzjwg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f25915d6-1de0-4239-db16-08db39e34354
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 16:47:25.2516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x2CWdW37MxThfDQPn+GG4yEw6lH0ToumL34MNk9f++ocW5FlPK4hvW0iflnr314/TdFNskYnPrGDfNaEyCOpqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6401
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

[Public]

A minor nitpick/suggestions below to make the comments a bit more concise. =
With that change the patch is

Reviewed-by: Graham Sider <Graham.Sider@amd.com>

Best,
Graham

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Sreekant Somasekharan
> Sent: Monday, April 3, 2023 3:59 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Somasekharan, Sreekant <Sreekant.Somasekharan@amd.com>
> Subject: [PATCH] drm/amdkfd: On GFX11 check PCIe atomics support and set
> CP_HQD_HQ_STATUS0[29]
>=20
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>=20
>=20
> On GFX11, CP_HQD_HQ_STATUS0[29] bit will be used by CPFW to
> acknowledge whether PCIe atomics are supported. The default value of this
> bit is set to 0. Driver will check whether PCIe atomics are supported and=
 set
> the bit to 1 if supported. This will force CPFW to use real atomic ops.
> If the bit is not set, CPFW will default to read/modify/write using the
> firmware itself.
>=20
> This is applicable only to RS64 based GFX11 with MEC FW greater than or
> equal to 509. If MEC FW is less than 509, PCIe atomics needs to be suppor=
ted,
> else it will skip the device.
>=20
> This commit also involves moving amdgpu_amdkfd_device_probe() function
> call after per-IP early_init loop in amdgpu_device_ip_early_init() functi=
on so
> as to check for RS64 enabled device.
>=20
> Signed-off-by: Sreekant Somasekharan
> <sreekant.somasekharan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c          | 11 +++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c |  9 +++++++++
>  3 files changed, 21 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7116119ed038..b3a754ca0923 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2150,7 +2150,6 @@ static int amdgpu_device_ip_early_init(struct
> amdgpu_device *adev)
>                 adev->has_pr3 =3D parent ? pci_pr3_present(parent) : fals=
e;
>         }
>=20
> -       amdgpu_amdkfd_device_probe(adev);
>=20
>         adev->pm.pp_feature =3D amdgpu_pp_feature_mask;
>         if (amdgpu_sriov_vf(adev) || sched_policy =3D=3D
> KFD_SCHED_POLICY_NO_HWS) @@ -2206,6 +2205,7 @@ static int
> amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>         if (!total)
>                 return -ENODEV;
>=20
> +       amdgpu_amdkfd_device_probe(adev);
>         adev->cg_flags &=3D amdgpu_cg_mask;
>         adev->pg_flags &=3D amdgpu_pg_mask;
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 521dfa88aad8..64a295a35d37 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -204,6 +204,17 @@ static void kfd_device_info_init(struct kfd_dev *kfd=
,
>                         /* Navi1x+ */
>                         if (gc_version >=3D IP_VERSION(10, 1, 1))
>                                 kfd->device_info.needs_pci_atomics =3D tr=
ue;
> +               } else if (gc_version < IP_VERSION(12, 0, 0)) {
> +                       /* On GFX11 running on RS64, MEC FW version must =
be greater
> than
> +                        * or equal to version 509 to support acknowledgi=
ng whether
> +                        * PCIe atomics are supported. Before MEC version=
 509, PCIe
> +                        * atomics are required. After that, the FW's use=
 of atomics
> +                        * is controlled by CP_HQD_HQ_STATUS0[29].
> +                        * This will fail on GFX11 when PCIe atomics are =
not supported
> +                        * and MEC FW version < 509 for RS64 based CPFW.
> +                        */

Could probably make this comment and the one below a bit more concise. Sugg=
estion:

/*
 * PCIe atomics support acknowledgement in GFX11 RS64 CPFW requires version=
 >=3D 509.
 * Prior RS64 CPFW versions (and all F32) require PCIe atomics support.
 */

> +                       kfd->device_info.needs_pci_atomics =3D true;
> +                       kfd->device_info.no_atomic_fw_version =3D
> + kfd->adev->gfx.rs64_enable ? 509 : 0;
>                 }
>         } else {
>                 kfd->device_info.doorbell_size =3D 4; diff --git
> a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index 4a9af800b1f1..c5ea594abbf6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -143,6 +143,15 @@ static void init_mqd(struct mqd_manager *mm, void
> **mqd,
>                         1 << CP_HQD_QUANTUM__QUANTUM_SCALE__SHIFT |
>                         1 << CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
>=20
> +       /*
> +        * If PCIe atomics are supported, set CP_HQD_HQ_STATUS0[29] =3D=
=3D 1
> +        * to force CPFW to use atomics. This is supported only on MEC FW
> +        * version >=3D 509 and on RS64 based CPFW only. On previous vers=
ions,
> +        * platforms running on GFX11 must support atomics else will skip=
 the
> device.
> +        */

Suggestion:

/* GFX11 RS64 CPFW version >=3D 509 supports PCIe atomics support acknowled=
gement */

> +       if (amdgpu_amdkfd_have_atomics_support((mm->dev->adev)))
> +               m->cp_hqd_hq_status0 |=3D 1 << 29;
> +
>         if (q->format =3D=3D KFD_QUEUE_FORMAT_AQL) {
>                 m->cp_hqd_aql_control =3D
>                         1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
> --
> 2.25.1
