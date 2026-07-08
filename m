Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBA3C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 13:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A88A110E5E2;
	Wed,  8 Jul 2026 13:21:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P8h1uAuY";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012053.outbound.protection.outlook.com
 [40.107.200.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B84F410E542
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 13:21:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdD8nCwsyaKgt+txn/FqjEkKGDEL+a5Sz7EDKFsRTDAj0NyhY5ybr5X41oTIxM7NAsEAZtcLlb+VMcidgz7xmviwT9rjQ3MR6RfDWhNkmPKx948TCje6R2Z8kh32mc/YAukfVxI1jG871/XTe6sYjUQNSVNwU6Mh1MjZHy+JCfI85QpQAgagfBqiPEhs4c0yx12tc1dwr3DYjRboRIgKlaQcCGKQvE6xMRhHBkVZ2RMsudJCia0ZzSZrpzmOIn35egWZqNXjnsBvdFKMfcMKNSgxXXSiDXG+zRtDUWtbfEOZggoE9O38Fe6oCZ9kdXMwFUYrbiFVzUzE082aLf7kCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpYRwb8lIk71U3zfxD8P2pxqGO0Tb24pJtLZXQrtCVI=;
 b=ionNjtgJD1sTNG6AmLjjXlLY5wObjd6LM5tR66NvDgZU3QrMYCIUepzIdUwszOeb0nSIK3hJvIRxZpD9CJcPRu3O13MZk5+aXho0hg4j+kQPAyacXjxj9N7rGOhM8EDVz/cjETELmaC6Tr1WSJB8Pk6syRaCo2IbpD0PGyk7hQ+bYJlXaLyYW0HUrjkv4DASdi4vHJE7Hj4PMrlgxPXf6F1sQl5jI2kBrHl5iNztDY6G08WJTT7AUYdBfSX6RsS2gq3qu9pZatp99Yw/2C7PzUO825L6oB/kJXM/YiU6vc0QSfKirNq6du/ynVtfWCx57LDHV6xpKSKJmP0pXiRD9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpYRwb8lIk71U3zfxD8P2pxqGO0Tb24pJtLZXQrtCVI=;
 b=P8h1uAuYwcxYpNp//1B2+Nxy9viMwOCEjgH51UwhAd46bWzyDRacKJcIoLxlxTaMhguXqMbl6McP+qyJ4444x4wsP46Rhi8+LNY0IE/wEVv+UppHKFFKjwZcUHhKRgYXXqg9/AEp7o5pK7Z41MwAw/NWk//zbzRzzJGPwYEE49s=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 13:21:16 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0181.014; Wed, 8 Jul 2026
 13:21:15 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Russell, Kent" <Kent.Russell@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH V3 1/1] drm/amdgpu/ras: only check bad page for
 address-based UMC injection
Thread-Topic: [PATCH V3 1/1] drm/amdgpu/ras: only check bad page for
 address-based UMC injection
Thread-Index: AQHdDtH+X0X2PN6kdku9qNXgFqMC/rZjm4wA
Date: Wed, 8 Jul 2026 13:21:15 +0000
Message-ID: <BN9PR12MB52573B9BFD2FF7B28C24FD91FCFF2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260708120418.376019-1-Stanley.Yang@amd.com>
In-Reply-To: <20260708120418.376019-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-08T13:20:50.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB6398:EE_
x-ms-office365-filtering-correlation-id: c16e1a62-2d1d-487f-caee-08dedcf3ca0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|38070700021|56012099006|11063799006;
x-microsoft-antispam-message-info: JrwaY5VhO0oQRTtuMqP/puVf1P8tONgwqlNnpYMxrPJLBgg+lbbRB2IkRSHcwUc//YgHjL4b6Eol9yOeuIlrUoxaAT+8U3/ech/HKpeNO3/kGOJGCLXq40oBR9NTRNygZon5FKlRaZjYhFgKaaIBMIl0fSIpDIGqwTPrIG76Jb0uzGJG7y/UhyQchzGvzUQVXNUkD1T4wOjK+ZCv9hHghxmB/0fxJWGc7WjCNikRYp4QZyif9EU5lTyvfUB6H8gKqB+2ChIIIXIJ/qJ04+j6NT0XyepvDGIMzF/2nzQffCwWCsHVozHYxeJ7nvZBQS8ciulEPT4EsyzjKKljbJIMIjtdtQ+dvN0+/aT81REphEhrLy6geYlsEjZWi2Pm6l58BinhgMeY+wI+5xhBfn16kMtWt46iYWU9pD0009y/5cl826XYiPcT7cIcXfbWwYEvBGNIM71yTkVQeeVzSVP5UXwBljXdm309h05WpOP+Cb+pnsQPKXaC30ZvKA9scwBuWuDeEwsVFuphFflmQaqWuVkiXD5ttEqpxqBPH/1DMJ9A9bSDyzFl90/pM26cKCYL9Fmfri81JijPJiuW+eACKHTNnoZmfj8Ac7lUS9fbK51YRaU2Ov3Tj+zYDoAYI231DbbdVILtipws7kAPKxrtfvG1UsDsY/k1BLKSSUndyymQ7Bo9XK06nQ8cMkZd65WIYeEJZf4LZN4ojQSBCqLMkEgTGED+qKQMzd4kIx+9G84=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p6oUT1RVvudhSLIHHcj1mXTejAI+9iC7ANeYEXD2fc8XtBQmLi/mh8iJUuEY?=
 =?us-ascii?Q?jAeetVuV71qwG71vMYKpn2d8fWyctsORh7QGRCHL5zr2oFEXER05NaAmJGZo?=
 =?us-ascii?Q?LlsmQMDkyR7aTb6clvO4hC9koxDUb/+/DUybSGb5ajcRmXZVleORPk+wpdFc?=
 =?us-ascii?Q?3qMN8sSNoug5ynseHbqTwc/gb5aCALofdurZS8bskrmPObmB0hXlk9jVz1wj?=
 =?us-ascii?Q?CRmSQ+lzxum8+u3SmItPHFMvGM3V0kf4SGZn686Oka9sUtJNHkcRaJZp74Tv?=
 =?us-ascii?Q?GxATElI6NnBdRbao3whQ0yc7SvVt1PO0sTNYhcLBR+yiln8FqMsonbm9gFhv?=
 =?us-ascii?Q?TgDKIeS/3kWU9DAQYgGMctXBkmVAjV2c7yvxk4I7QFUx29/JnzDDNSIKVcyB?=
 =?us-ascii?Q?TZucorgYEeSt+n2HQE//TfWdqXCofUhoHBNS5xiA+IR778BMIomRz4WDSqeJ?=
 =?us-ascii?Q?KybZjaig37SNI5neZZqCEqdrdpP1KxxxKfXbnjNhIRWa8ijP+lMdOcQ+QFxL?=
 =?us-ascii?Q?l1CtHrm68ooYnCexujZSx4M1UZZOhp+gwvct2JU34z5DxOV4awfPR5ceE8WY?=
 =?us-ascii?Q?mJeAvgxKWIFjb0+mvzWcLOoveX6fK6NtFIhvy+kNx6HRYYVjw6PWitOt+Mg6?=
 =?us-ascii?Q?Hs2iWxd6C8kuI03smGsyGbaHQ+dGPbvROyvAPGvufE0FMvt20F3loXx6wR/p?=
 =?us-ascii?Q?Ua2YhShv0PfNpEaq35uPbItrwT37bVpJ0Lcy9p6UHV+vv5XmKDgc7tQFMsg0?=
 =?us-ascii?Q?/94dvNuLFW2RzinA6Ayzhw6s7X81J+7xXKPnbYJqeTu3S59VYgZ0xEq1dqQz?=
 =?us-ascii?Q?g1ehNNT9BPNB8/EAMbb4PNFDKZ1Loc+rn9KrPtgGN2dA1EbauUBDtZF69zMI?=
 =?us-ascii?Q?5m+ke6Gs7fXhBW4Q0zYH7ILhFez8VtTnarcEdJMFKTYHi/nN6BxBnlTKAr6g?=
 =?us-ascii?Q?sK7tln6Sz7B9qTK3H7OLtj2TliD6LqyIfHAgVOf+t/M0R0fepNNc87Ldpju6?=
 =?us-ascii?Q?yClTfsExSIiGfAfk077+w8N+qjk0mTOWJO0I9PekJIqkpLSR7P/Ags/DP8cH?=
 =?us-ascii?Q?UGQFb/dkE3FiqVlA4NNEBasHtbsYKP0sy5wImVodnn0i22uZksxGxY8Diygv?=
 =?us-ascii?Q?AdjgeeKNyTfv54ELxfUuQgkAG2gV7qSd3vLSlvkpbBYgC966B9O4L8n6e2yU?=
 =?us-ascii?Q?a1wQzGUalyX2nMA7Z2mTyFAWmyTk0o1njlcxv8a/V5kKfhVPsdYX06xnPqAJ?=
 =?us-ascii?Q?hsIQhRL8o7TZi7dcDVcc+yXQ/XsroMb9Rqwtiw85qpGf8xJANlJkT2iItenv?=
 =?us-ascii?Q?t9b1WMXBjpvAs4uOTgI1vELjU+N8QhZdG55U5EGHJe5rLBmtb9VhTvWHcCta?=
 =?us-ascii?Q?UUw6LYT15WQAtczRW6a4Pn7NWcSiGV+KamOuys7OXPaPRAdix16IK6al2Yv0?=
 =?us-ascii?Q?OA1sT32329JuFXEoWTxZdxQ5tmZgadyb2cike7yufTWkkZkjtQll98I5ho2C?=
 =?us-ascii?Q?hckB1iyfwFCOH4RPDPnP+IhAV44/XsTi5wGWlSt395dMhoXMvVbKb5VEm8DY?=
 =?us-ascii?Q?6vbWLsT0oRmKp7i5JxoLUHjBWqQX0HTOIn/uOJajlP9Nc3YkSQ4yH75l1h+S?=
 =?us-ascii?Q?clT4Ms7owUpuQf8cFIIEYK9pisE3hsJqfQLXLY9MBtpAgbJ7R4iCht1A1wx+?=
 =?us-ascii?Q?3c77JClN/4t7uSjquq25pyvMSP0De3FUOEsulxYmk2YubNSr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16e1a62-2d1d-487f-caee-08dedcf3ca0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 13:21:15.7766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /JjLX0U52akju6AdAcuqw0ZRAvWJ52T8ZIp0pT1tlluwLgRwP1zhsOt1V1TIAqPBCU1wt4aLEWUmcIxt+NgroQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398
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

AMD General

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.=
Yang
Sent: Wednesday, July 8, 2026 8:04 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Russell, Kent <Kent.Russell@amd=
.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH V3 1/1] drm/amdgpu/ras: only check bad page for address-bas=
ed UMC injection

UMC error injection on MI300 series is dispatched by the RAS TA using the i=
njection method; only the "coherent" methods are address based, the single-=
shot/persistent/ac-parity ones ignore the address.

The debugfs control path validated the injection address against the bad pa=
ge list for every UMC injection. On uniras (SMU v13+) devices the address i=
s now validated by the ras_mgr inject handler, so the legacy debugfs bad pa=
ge check only runs on the legacy RAS path; other ASICs keep injecting by ad=
dress.

In the ras_mgr handler an injection is treated as non address-based only wh=
en userspace passes the U64_MAX sentinel address and the method is a non-ad=
dress method. In that case the address is cleared to 0 and the bad page / r=
ange validation is skipped; otherwise the injection address is validated as=
 before.

Changed from V1:
        move address based checking to uniras layer

Changed from V2:
        Check umc injection address setting flag,
        simplify non address based injection judgment


Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 10 ++-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c  | 83 +++++++++++++++----
 2 files changed, 73 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index af48dd2ebd16..f280a312b0a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -606,8 +606,14 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct fi=
le *f,
                ret =3D amdgpu_ras_feature_enable(adev, &data.head, 1);
                break;
        case 2:
-               /* umc ce/ue error injection for a bad page is not allowed =
*/
-               if (data.head.block =3D=3D AMDGPU_RAS_BLOCK__UMC)
+               /*
+                * UMC ce/ue error injection for a bad page is not allowed.=
 For
+                * uniras (SMU v13+) devices the injection address is valid=
ated by
+                * the ras_mgr inject handler, so only run the legacy bad p=
age
+                * check for the legacy RAS path.
+                */
+               if (data.head.block =3D=3D AMDGPU_RAS_BLOCK__UMC &&
+                   !amdgpu_uniras_enabled(adev))
                        ret =3D amdgpu_ras_check_bad_page(adev, data.inject=
.address);
                if (ret =3D=3D -EINVAL) {
                        dev_warn(adev->dev, "RAS WARN: input address 0x%llx=
 is invalid.", diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.=
c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
index bfbfdffbfbe6..c2285fde8b3c 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_cmd.c
@@ -82,6 +82,43 @@ static uint64_t local_addr_to_xgmi_global_addr(struct ra=
s_core_context *ras_core
        return (addr + xgmi->physical_node_id * xgmi->node_segment_size);  =
}

+/*
+ * UMC error injection is dispatched by the RAS TA using the injection
+method
+ * carried in struct ras_cmd_inject_error_req. Only the "coherent"
+methods
+ * program an explicit injection address and are therefore
+address-based; the
+ * single-shot, persistent and ac-parity methods ignore the address.
+ *
+ * Keep these values in sync with the RAS TA.
+ */
+enum umc_inject_method {
+       UMC_METHOD_COHERENT             =3D 0,
+       UMC_METHOD_SINGLE_SHOT          =3D 1,
+       UMC_METHOD_PERSISTENT           =3D 2,
+       UMC_METHOD_PERSISTENT_DISABLE   =3D 3,
+       UMC_METHOD_COHERENT_NO_DETECTION        =3D 4,
+       UMC_METHOD_COHERENT_WR          =3D 5,
+       UMC_METHOD_SINGLE_SHOT_WR               =3D 6,
+       UMC_METHOD_PERSISTENT_WR                =3D 7,
+       UMC_METHOD_SINGLE_SHOT_CLEAN    =3D 8,
+};
+
+/*
+ * Return true when @method does not program an explicit injection address=
.
+ * Only the coherent methods are address-based; every other method
+ignores the
+ * address, so userspace signals them by setting the address to U64_MAX.
+ */
+static bool amdgpu_ras_mgr_is_non_address_injection(u64 method) {
+       switch (method) {
+       case UMC_METHOD_COHERENT:
+       case UMC_METHOD_COHERENT_NO_DETECTION:
+       case UMC_METHOD_COHERENT_WR:
+               return false;
+       default:
+               return true;
+       }
+}
+
 static int amdgpu_ras_inject_error(struct ras_core_context *ras_core,
                        struct ras_cmd_ctx *cmd, void *data)  { @@ -91,25 +=
128,35 @@ static int amdgpu_ras_inject_error(struct ras_core_context *ras_c=
ore,
        int ret =3D RAS_CMD__ERROR_GENERIC;

        if (req->block_id =3D=3D RAS_BLOCK_ID__UMC) {
-               if (amdgpu_ras_mgr_check_retired_addr(adev, req->address)) =
{
-                       RAS_DEV_WARN(ras_core->dev,
-                               "RAS WARN: inject: 0x%llx has already been =
marked as bad!\n",
-                               req->address);
-                       return RAS_CMD__ERROR_ACCESS_DENIED;
-               }
-
-               if ((req->address >=3D adev->gmc.mc_vram_size &&
-                       adev->gmc.mc_vram_size) ||
-                       (req->address >=3D RAS_UMC_INJECT_ADDR_LIMIT)) {
-                       RAS_DEV_WARN(adev, "RAS WARN: input address 0x%llx =
is invalid.",
+               /*
+                * Only address-based UMC injections carry an explicit inje=
ction
+                * address that has to be validated. A non address-based me=
thod
+                * ignores the address, and userspace flags such an injecti=
on by
+                * setting the address to U64_MAX. When both the sentinel a=
nd the
+                * method agree, clear the address so the RAS TA ignores it=
 and
+                * skip the validation; otherwise validate the injection ad=
dress.
+                */
+               if (req->address =3D=3D U64_MAX && amdgpu_ras_mgr_is_non_ad=
dress_injection(req->method)) {
+                       req->address =3D 0x0;
+               } else {
+                       if (amdgpu_ras_mgr_check_retired_addr(adev, req->ad=
dress)) {
+                               RAS_DEV_WARN(ras_core->dev,
+                                       "RAS WARN: inject: 0x%llx has alrea=
dy been marked as bad!\n",
                                        req->address);
-                       return RAS_CMD__ERROR_INVALID_INPUT_DATA;
-               }
-
-               /* Calculate XGMI relative offset */
-               if (adev->gmc.xgmi.num_physical_nodes > 1 &&
-                       req->block_id !=3D RAS_BLOCK_ID__GFX) {
-                       req->address =3D local_addr_to_xgmi_global_addr(ras=
_core, req->address);
+                               return RAS_CMD__ERROR_ACCESS_DENIED;
+                       }
+
+                       if ((req->address >=3D adev->gmc.mc_vram_size &&
+                               adev->gmc.mc_vram_size) ||
+                               (req->address >=3D RAS_UMC_INJECT_ADDR_LIMI=
T)) {
+                               RAS_DEV_WARN(adev, "RAS WARN: input address=
 0x%llx is invalid.",
+                                               req->address);
+                               return RAS_CMD__ERROR_INVALID_INPUT_DATA;
+                       }
+
+                       /* Calculate XGMI relative offset */
+                       if (adev->gmc.xgmi.num_physical_nodes > 1)
+                               req->address =3D local_addr_to_xgmi_global_=
addr(ras_core,
+req->address);
                }
        }

--
2.43.0

