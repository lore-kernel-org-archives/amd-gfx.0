Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84626C369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:11:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31ADD10E4D8;
	Mon, 28 Apr 2025 13:11:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i3jM2pZQ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12DE110E4D8
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:11:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xObeargQ+B7HO4zSLLTAvtRMnW9rWpvseUc2PFlJXUA4etysY8zl3SxtVi8HmnGlJY1rcjfwfglXcpJaEbOLguOf+Pf8SXHXR1lHQgLxIX3BNSp5n9SK/VswBSiifotNKb+xKDiiO1w1zGQN/YgUnUW0kixRbwujHlE2WomQz9fZuexwaDUqcY3S7o3A8oMdlOW5fw0Umzz01+EFBqn2ZFMOzMomQaOv3Qvtj9ZPM2hmCGMITeaQ/wB/8jy1KoFujI2BVNr16RGP47EGTH9HA4RxtoXrmOs/djMGCbLSnqFVH7+gmGRwD2PbTb0HFsEaUrTbZ3OOTe13Q0WJmwsl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUqZOAaWDAAGYnCeIDY39qyxiW3ZP6/NfQIs+SM0ESg=;
 b=pEmk3oRuEl0U2MTqePyNsXdE9QRVJA0IHjtv9Uq4dug/BEWPpvUZvXapxD5Y/bO6XjzkueCHDA5kTVGpHH+R5WoWNDS5VdkJkVZHt4MAOFwuST+6pErTniaHxyP7D3Pke9pG7OarQtiNilSSMfbgnCEZGAVXoDUNANPjf9+wd4fEvKGhwJZa7okzsNFSRGKdHBN5cmu7sKQMnf7s63uBp2yga7MA3weWq9PSqjjQX/SJm2zBY6Jb6uQ2Fy7yupLRKyPAIg97/MUrK04icD0UaLdrvzoF97v9y2IDDGy5uBzfX+MPcQ24xaIgGtthlTakxj48v2R0759/zSaG/AKbvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUqZOAaWDAAGYnCeIDY39qyxiW3ZP6/NfQIs+SM0ESg=;
 b=i3jM2pZQ34/qMIq78mZbW0RvAcoCAkQ4D1tjOXjC4UJK3gLv3NFptqbtCuEjcNwdoC85wuNVnhHjQTKnuebUyiUQjlsSWvwO/vsSjt3j28JrS+qfRcMHNPqINI9pmHNBGhFCSsnBFIGjL9F2PO0N0qJbLCeh105v284Fb5E6+9U=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.34; Mon, 28 Apr 2025 13:11:18 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%5]) with mapi id 15.20.8678.033; Mon, 28 Apr 2025
 13:11:18 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Jiang, Sonny" <Sonny.Jiang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Jiang, Sonny" <Sonny.Jiang@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Add DPG pause for VCN v5.0.1
Thread-Topic: [PATCH v2] drm/amdgpu: Add DPG pause for VCN v5.0.1
Thread-Index: AQHbtgEAFTfooPOX0kq9CeTUgie18LO5EfIw
Date: Mon, 28 Apr 2025 13:11:18 +0000
Message-ID: <DM8PR12MB5399DA30CBA1D296737D280DE5812@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20250425164137.1090949-1-sonny.jiang@amd.com>
In-Reply-To: <20250425164137.1090949-1-sonny.jiang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b1cd3aeb-be03-44a9-b20e-8bd27c6c7f39;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-28T13:10:56Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|IA1PR12MB7520:EE_
x-ms-office365-filtering-correlation-id: 630c5779-460e-4b2b-1fa4-08dd86562a15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7JbRkoehytW3cP+mXWpKvw5LkOzEn+KQO1Tt/u3v5evAQgAvzJUBlgSZWXIT?=
 =?us-ascii?Q?aqt61G2onOwgntSUL65iio2qzQ93f7+UPjUedetRmrhjNsdwu7J18kndkBc3?=
 =?us-ascii?Q?lJ2vwUYBn6esvTxF643YsJG+NxF342dbo6Nrz+aJd5veSSYhLNx39NYMzGSJ?=
 =?us-ascii?Q?UHwq+xuwnJfFupmUNCIVfgRP73UqWqjNjt0RqOLL/8AewrtF0Np0S7USdtGc?=
 =?us-ascii?Q?y00VFb0MfcP1bRmUfq0J+fCyyo+m4crXM19rfNaHMc5C1OPyENjDacQvxh2k?=
 =?us-ascii?Q?5WAXlrm/nJ7S1xOd3osLnwVeVYdCUiVZugg4Xa+euXCx4okKEX28YAmRwboH?=
 =?us-ascii?Q?9B8FhlOvx46n9TYBRhrn+Nd+QWWSh6pzbv5NF4nT+JxaSVpmZZtehURIA3WT?=
 =?us-ascii?Q?t+/lPD0rL5WfOW5uWg9Az4zuQgihOrLepwQDEDOj4mNPs/zlwvPSM1oJoUt9?=
 =?us-ascii?Q?4/a32YYW7msNEY/jlFCf7H6+iFmezsy9QkcryL1Z/rTbBOONdFC67e+nT6fJ?=
 =?us-ascii?Q?bSfLnbOEht0JrGZNmesP9ek/xpG9lpFias5FGm2BGtQP/zdpuPCeFXQXOgzN?=
 =?us-ascii?Q?qXmQwmMAnKkY1wfK+ufPVju8ESZh/nR/FvpO9n7fTcdgxyqOYzx9zBcsQ7ES?=
 =?us-ascii?Q?sQf4TGdAxM/yxjv/UCatNgcW5X/gILjxsu7ZRh1XR0EhHfaZgGmOB+6Swizs?=
 =?us-ascii?Q?0m+t/2Ow3BmMdsrMVjL+Yo4orcDYKHlHT+7GbwzmXb3yNrYq46whVIdK4lx5?=
 =?us-ascii?Q?8JI9Gbr1mTMvqtwvoOon+tHFNszgs9INl3I6woO9BNaIqXDW2vsrVRm8bCIf?=
 =?us-ascii?Q?X2d1ODpSuwhUGh+QJEMHgZa7J1AVLDOFZLhLSYZxiF6B6AzuoHnUHhXoX/3P?=
 =?us-ascii?Q?ocD9/7ulZxGZj8V/XBnJ6jVMYy2zTxKVcdQBr52l5SKCcNfkPkdI09di/bLh?=
 =?us-ascii?Q?fKkSPTY5F8DZUrShrbjhZ2qPPsybXmMuk9rSVYjhY4Hl5Uzv0lLXU35FsVn6?=
 =?us-ascii?Q?cL4h0O0qBtKCJ4Twng3BPKYHX8SVU5F500gbk7u6RC83GA+AOLBWxkzaLOWe?=
 =?us-ascii?Q?a+vauavvcYuvRB35ZpVHQ6Dsiha9JKpbEdPpz74K11RRh/zBzzCq/OliGeHX?=
 =?us-ascii?Q?oKWeAn8BfZ6tgGm+qaqTWg1EAQn1k9QH/Jom2GQ6EiPXcKxvrpDykaLH4Wsg?=
 =?us-ascii?Q?7rCsBx5qICXN2eIJAQH4WdGhUzbQ3WwXCC6skDyh3ygff43Ta61divmcePPX?=
 =?us-ascii?Q?AXVqI56Bo/cAe7wik5lTQlp9wyAT6MWDz5K/4rGnmNiH47PaVs3GR600uxwL?=
 =?us-ascii?Q?Vlq7jiczwyM1H2M7rnERPBUhhqI2hTKU9vb76Kre3lfKr28i6uK2m16HR3MU?=
 =?us-ascii?Q?WxzI2Oes+zkVVPpLC2pT6NDaAhfH9MrCi1tyI2/gBBHHYKVI8YpNb/d5Us/h?=
 =?us-ascii?Q?48dfcotICYHHCW+3DrPbJQXMc32WNcD/BeceOyDVCekTP02zMEDVNMEa2rIK?=
 =?us-ascii?Q?T4Z/Q1d5SGZVVpE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+K3FaWsG1Ek9cym3PxyIjtQQbprEM4yk2VPIKkBmZzhDFDKgo63nywWBH/fH?=
 =?us-ascii?Q?F5sNC3xcoj/Terkhb41YmVK2a6Yyv3uT6CMf9rolN+/DgrZv7u1IwtOi5jL2?=
 =?us-ascii?Q?BJ0NCYTeI58hTBfl2B5SSGIBVjowUc8SjBVL8kpXn0NZzqxMU81rz7nY7KG5?=
 =?us-ascii?Q?W26Itg296ALQh2HFdgYX9/BdtHdRRzyOKbwS8ehYnlsH6moXhrLtxhd86OJr?=
 =?us-ascii?Q?UyO7Gt6f4hPOr74M6ixTb1Kf5xWC4jOwx85/8Es2DOGpbynJ05UN8W+MWqtp?=
 =?us-ascii?Q?aQZL+jatuP2IXeIhJxmatdvohZQ7XN5qbR+48IAzTnny80m6u9ZzAzrEAb6E?=
 =?us-ascii?Q?fsN9l0Mxg8x1cYsbQqCMe5A5XQ2lSAUTNJhzvAu5wDtSZvhrrY9XELoR91kK?=
 =?us-ascii?Q?748I8adsugS9lqXvIjlmgIC/LrprdDQajfjm/w8mxXEL8viPoVHvaF4ULr1M?=
 =?us-ascii?Q?bTnBGRzDgpYkOLtTPnQti9r7DOvtFmAjTHOcuQakFEJcP484vg+h6kpXStGD?=
 =?us-ascii?Q?429whZT3QZsYn+Fqa/owuViGQ4a32bB3k3TChODGRE51Du4f6O0iXq4WR3+7?=
 =?us-ascii?Q?SIETzroXdBjlWD/lRbxeYKHnOGx5OwEeJ3R9dJqDjp9cHpd9PkrOG/SqX8NK?=
 =?us-ascii?Q?W58k2ZkkUZzKVHr41+5cZ40Nhv21CzYqOlCRUOnET8PUwAmSp6AATIFPXPgM?=
 =?us-ascii?Q?4o+EfrUg9ARyYquXgN14Fxi6hOT74rxG+zDMDORabzJKfjs7g+lKGv+mswq2?=
 =?us-ascii?Q?94m98QsjH4Oe4A0etHX3ApGaqwR7zrFQ5g36BMluTzcg34lEZCsfs85mCW2I?=
 =?us-ascii?Q?+xghGtpaVE2lLGjaJ/X6+9atR6fChaaDmQJNcsaCbaa8XOmxYji/k8Ja6CPV?=
 =?us-ascii?Q?cZ3cF+AUH5e+TKIhRBOi8/uDFk7WDpJuCP8VFPev2TfvTCcmVEN6sQlmp79Q?=
 =?us-ascii?Q?EFd3D6y56n8sscbM2KzhzI0d6F+LLa+zKhHgCVFnq5buTP22POXo2MdIQ4kk?=
 =?us-ascii?Q?c71zMEN0pJEj2aUhGbS+PSqw4+w5cGmqIUc0tNSKcQAICnkGr/vII/ck7d1u?=
 =?us-ascii?Q?1mNV910YIX946jvt1jP5rkrYbtwEzc2DH0nrF2rqEEnYxMBSfMsmrLgbeHjR?=
 =?us-ascii?Q?ZGxVM+7UG+TzOTcGLysGFKuFm0DtYmLBaeQGLsz4RKRr+F6uwuwSv4A0/pdM?=
 =?us-ascii?Q?WYy6l6w2AzoH1f2lutDZQe1i86QP2ASvSq2AO2KvniOZX96cn+CjsFqDU0Rx?=
 =?us-ascii?Q?QL3qI9bW61m/acBGLmbIkDNPQ18/yOI3guITm046Dyxq1oBo/AMH+Y7CBv2d?=
 =?us-ascii?Q?WF1P7auQoPqJAsKZD4AE/WCIc2YFXhnSTp1O+WAp+n7pH/0nhR18jyzy9/GD?=
 =?us-ascii?Q?IhZXddF4naWHSmgYbsXzzn45EG9DQZP+rOUDqme0hVJEv4k8Kg4GJplsM6+j?=
 =?us-ascii?Q?rPYLZMmhE3dxXlXATf9twr33PBjSe2kIfCUQDI8YC2YRf5to0fhDklRRN5OL?=
 =?us-ascii?Q?cZyMGXRDcNFx/NFmAlfjVaShzZ6GbXcFyk2VAftAl6sht256QVMwJLJJ0Qcv?=
 =?us-ascii?Q?65LeFdH8yd8n/eHyX+0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630c5779-460e-4b2b-1fa4-08dd86562a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2025 13:11:18.7516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: isq6ubZX9znhViLU89KZyYTt8ijGCvgG4w/2jPUb9xNw/LsK/Fk+Qh93i0ivGVlr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Leo Liu <leo.liu@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Sonny
> Jiang
> Sent: April 25, 2025 12:42 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Jiang, Sonny <Sonny.Jiang@amd.com>
> Subject: [PATCH v2] drm/amdgpu: Add DPG pause for VCN v5.0.1
>
> For vcn5.0.1 only, enable DPG PAUSE to avoid DPG resets.
>
> Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 54
> +++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index 4b2e6a033831..60ee6e02e6ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -502,6 +502,52 @@ static void vcn_v5_0_1_enable_clock_gating(struct
> amdgpu_vcn_inst *vinst)
>  {
>  }
>
> +/**
> + * vcn_v5_0_1_pause_dpg_mode - VCN pause with dpg mode
> + *
> + * @vinst: VCN instance
> + * @new_state: pause state
> + *
> + * Pause dpg mode for VCN block
> + */
> +static int vcn_v5_0_1_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +                                  struct dpg_pause_state *new_state)
> +{
> +     struct amdgpu_device *adev =3D vinst->adev;
> +     uint32_t reg_data =3D 0;
> +     int vcn_inst;
> +
> +     vcn_inst =3D GET_INST(VCN, vinst->inst);
> +
> +     /* pause/unpause if state is changed */
> +     if (vinst->pause_state.fw_based !=3D new_state->fw_based) {
> +             DRM_DEV_DEBUG(adev->dev, "dpg pause state changed %d -
> > %d %s\n",
> +                     vinst->pause_state.fw_based, new_state->fw_based,
> +                     new_state->fw_based ? "VCN_DPG_STATE__PAUSE" :
> "VCN_DPG_STATE__UNPAUSE");
> +             reg_data =3D RREG32_SOC15(VCN, vcn_inst,
> regUVD_DPG_PAUSE) &
> +                     (~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
> +
> +             if (new_state->fw_based =3D=3D VCN_DPG_STATE__PAUSE) {
> +                     /* pause DPG */
> +                     reg_data |=3D
> UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
> +                     WREG32_SOC15(VCN, vcn_inst, regUVD_DPG_PAUSE,
> reg_data);
> +
> +                     /* wait for ACK */
> +                     SOC15_WAIT_ON_RREG(VCN, vcn_inst,
> regUVD_DPG_PAUSE,
> +
>       UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,
> +
>       UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
> +             } else {
> +                     /* unpause DPG, no need to wait */
> +                     reg_data &=3D
> ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
> +                     WREG32_SOC15(VCN, vcn_inst, regUVD_DPG_PAUSE,
> reg_data);
> +             }
> +             vinst->pause_state.fw_based =3D new_state->fw_based;
> +     }
> +
> +     return 0;
> +}
> +
> +
>  /**
>   * vcn_v5_0_1_start_dpg_mode - VCN start with dpg mode
>   *
> @@ -518,6 +564,7 @@ static int vcn_v5_0_1_start_dpg_mode(struct
> amdgpu_vcn_inst *vinst,
>       volatile struct amdgpu_vcn5_fw_shared *fw_shared =3D
>               adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
>       struct amdgpu_ring *ring;
> +     struct dpg_pause_state state =3D {.fw_based =3D
> VCN_DPG_STATE__PAUSE};
>       int vcn_inst;
>       uint32_t tmp;
>
> @@ -582,6 +629,9 @@ static int vcn_v5_0_1_start_dpg_mode(struct
> amdgpu_vcn_inst *vinst,
>       if (indirect)
>               amdgpu_vcn_psp_update_sram(adev, inst_idx,
> AMDGPU_UCODE_ID_VCN0_RAM);
>
> +     /* Pause dpg */
> +     vcn_v5_0_1_pause_dpg_mode(vinst, &state);
> +
>       ring =3D &adev->vcn.inst[inst_idx].ring_enc[0];
>
>       WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO,
> lower_32_bits(ring->gpu_addr));
> @@ -775,9 +825,13 @@ static void vcn_v5_0_1_stop_dpg_mode(struct
> amdgpu_vcn_inst *vinst)
>       int inst_idx =3D vinst->inst;
>       uint32_t tmp;
>       int vcn_inst;
> +     struct dpg_pause_state state =3D {.fw_based =3D
> VCN_DPG_STATE__UNPAUSE};
>
>       vcn_inst =3D GET_INST(VCN, inst_idx);
>
> +     /* Unpause dpg */
> +     vcn_v5_0_1_pause_dpg_mode(vinst, &state);
> +
>       /* Wait for power status to be 1 */
>       SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_POWER_STATUS, 1,
>               UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
> --
> 2.49.0

