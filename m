Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CACC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 19:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9E8210ED23;
	Tue, 23 Apr 2024 19:07:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m6b0v5Rq";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 336B110ED23
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 19:07:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQs4bP0AKSmWoAUDSCHjw4IRqR7RzKnw2hFer9iByI8ua3cZ9zgXT8tH462BB8xvoiXZCrdw2aovnpHx5W/DJsBcAN3r0ZoUP+cXH1/lO1XHbugj5j9X0Y8hgJ7DkdpeNHXdKsfkdJkoBiuG0XCNwydUEl378982K+MxEb6BirGzk0HT2mKwwVFrCNWHzPfaferMFo7mfof1/7kzUUKxiAy6L8wR3Mwhf1YfIVlBluCY1eYQp/TRtY5V0C+rIFTCjVTh6vPD8hKRRt+2xurJ0ywAixP8/cz8TUg5sRRx2eaqStRlq4wuJgzfVIBnxePA6ZlnS4nXyDU3ro/Y4xtvxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4MgX7SxduUvhxG9raelP2ztYBtAcT752Ifec0hVBi0=;
 b=Jj+JDn3EAODcdsdizJkb+S+PcGdSSfoEGOx1I4O/OzCQ+2s27JZhJY5/lXQRxih8/s252K953PYZ3tvzNM21SOoNmgKcuWGKcUMENqdkf74C4QMTmuzXtCLN3riAyAfIPwOvVkBcas+Zt9Y6ry7vj9Q5A9tKeP1f6q3GgdRWcvQlr6bPE6lSzZvKMi95+iYjopJJOl2TUs7WjJb6QLvkVO85D9xxubWDLoudENR7Ba4VENwEhoMpw6SOhXHUMqvDgTppDsoRQusKlCZIM0pWpV9pN+hCfllnZSys4a9KeuRBARA9AdPS5rBfgyMSqRWNm60d26QOozVriT14YBJDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4MgX7SxduUvhxG9raelP2ztYBtAcT752Ifec0hVBi0=;
 b=m6b0v5Rq1+guZi+w8oxYPXq7LFa6Un+O6tJ1uGkMxDUvbYLoaDXQcy4RJrczICfP81N1ZkVUKbGWlW18DUJPbAY72fH3uUWtessprbx/9YVdtCH7BWIjXFJCD8QyDEsEPAjX/HXpiC03KP7kqGHZawRRNjnuYpmcj3ijcVLYxPo=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by PH0PR12MB7814.namprd12.prod.outlook.com (2603:10b6:510:288::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 19:07:40 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::df0b:3ee0:7884:c6a9%3]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 19:07:40 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Jiang, Sonny" <Sonny.Jiang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Jiang, Sonny" <Sonny.Jiang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update fw_share for VCN5
Thread-Topic: [PATCH] drm/amdgpu: update fw_share for VCN5
Thread-Index: AQHala3axv+Jb3cQp0SpU7hkq5ejULF2N55Q
Date: Tue, 23 Apr 2024 19:07:40 +0000
Message-ID: <SJ1PR12MB6194B0BB871C02B18401457D95112@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20240423184101.2594284-1-sonny.jiang@amd.com>
In-Reply-To: <20240423184101.2594284-1-sonny.jiang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c7d5b6eb-7d0a-4abf-8b0e-c2abb21bffab;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-23T19:07:30Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|PH0PR12MB7814:EE_
x-ms-office365-filtering-correlation-id: 95f63d30-c0cc-4ae4-6c59-08dc63c8a5c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?edECOfmSGrnN+oW3gOqrzdQnBtyuwFN46u7yv5dPKlAASoHNce33qvkU0lYu?=
 =?us-ascii?Q?hW69OVCEB8OE0CTaSE+qlZ2EgPsc0FaQJjGvcGza2tKPivjlP2C4ylVbas9I?=
 =?us-ascii?Q?Uc1w5+7MFSf3ffubkRyYfaguXDZeftGQV4fGEul39Y596VEnTWBLa30XJ4KH?=
 =?us-ascii?Q?fdJuYmPUM8UU76DemW5D8Opi0WQ0mqTRhX00P+qguEBZU4t0h7atMMc1sGlF?=
 =?us-ascii?Q?+xkvOhBA2velDUvizQu5/rZaEeC36tqBKo3Bw8/l85HSx+LKq8YXZlprQ8L8?=
 =?us-ascii?Q?mz8SxIiVkxJytY4XG0xlecGRF/24lGwGbVNIsUKrMv9quN2w0NcY90QkIJWC?=
 =?us-ascii?Q?JX6lV2PUSZ58au7OpArdD+lvLgiT6vc6EdVUvBfIjO0+grfpmb4P2YrEtBLg?=
 =?us-ascii?Q?vNSw9aJ372KdeWqcSVRNX0slzsryvZFBfx80Uw5rC/SV3gUj681XJBrIVL81?=
 =?us-ascii?Q?CRsax22hk4ME7krepyKW933JBZfYH5wJo0d+07rCrqamH6NqsIE+SjKjp506?=
 =?us-ascii?Q?9us8iBQdvyqnzf5M0lidA925ViI4Q6q8q58ZKZsmU5q5nglA+cGfue5CeXuD?=
 =?us-ascii?Q?/XJIlILdytLaPcEbet+TtTM8oqmPlpMhZW87/ez8kcizutzWU8+FiyxR/Zvi?=
 =?us-ascii?Q?LZqEQmM6D0lg8QyqIIjqLloSV7dg4U6qbmKTuU/g+0R+tkseIA2cG+1em0A/?=
 =?us-ascii?Q?rB9fGy1SKpf2mbrDvQXtroLeVxNk2GpxRLeezV9kQc0i0FKP1tsbmMZkLc5M?=
 =?us-ascii?Q?ic0RV9U4zeETC4Kzz5rqXZ5LCiwW8Dzl3sETsmN9cC6V3eEJjSoaf8aHvjpc?=
 =?us-ascii?Q?HHovKUiFitwnXqnmDnuoEfL1qCcx+MNLHl72mSQzNHq8GbmgfD1EVajCDPdN?=
 =?us-ascii?Q?EZedHvC1S8daozOfybyGcJoH8UakEnfIcFYI27V5RZeqFrs3hCvsRO+eou5v?=
 =?us-ascii?Q?ioc9fbwINZ+yuRyIgbmj2L46J53mOETJzpz6hbjSKDnvOq0voQAO70Qwg4+r?=
 =?us-ascii?Q?X6hEH7sR/+4vfYf63dMg1octH27OJIDymEM+hXxl23NOG0uzfdAOOQSkR9yj?=
 =?us-ascii?Q?3v50q6/06RG2LTqL6mwY1p4qq2RtTUgn3qHqJc5uy9vqIrONUSZ4ziUsGz2O?=
 =?us-ascii?Q?wck2dCxCxdSsIM2Gd0+EpcqBSFlGIqZk+VllKtDIyn/DjyMObkg3dJin0VKR?=
 =?us-ascii?Q?0JHqYxEJj4Nim9DqSxh1ODDkRPGBOu1gJW6uEqOe+QNbPqk4r76PVjjPevgJ?=
 =?us-ascii?Q?boIMZeEyu56M9DLYtPI/iw++PfTDBhmnWmK71WzFt9rwrRWoKXLMEtLYJVgg?=
 =?us-ascii?Q?ZLcyZ2G+fBSnvzt6CTI/qvIbU+8ukd7MnnoxsMNEjURNiA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Eeu1mKu/DLDDI4akvBl5kzSUMCfsb/qIbYCyDZKl4S/OvwQbH7onvE99IWp4?=
 =?us-ascii?Q?qHI2VqGs9Y9m0j82fuwMsQV3GhUNuNvIcZu4Vk0lIkfGv0JyVX2etQ3PINJN?=
 =?us-ascii?Q?eOBOoj6UYUfn7D6m87zWykoPvAjtdsr97au8oRO1oDoTTDpFeYFdRY2KD+zM?=
 =?us-ascii?Q?SZahN7h8VZX3FRq5Q4FzZTLT7GWtJ/Xkr9kGhC5SK8+3Grv0NUNGwjR02yhJ?=
 =?us-ascii?Q?0m2GFt4093nmDZFWyiBv5WEPqm93pq/1G2Ejrrlh0oVdowNtiwbq/32fj7LH?=
 =?us-ascii?Q?/T2TR5pC4EN22i5uxgeVdEHvilWG38UJZ0ZMpmrxJ5Kq8DlX+2gqezILqHbJ?=
 =?us-ascii?Q?vwOFHtl+Gu0JfesomzeOuPJi3XoRD4zwgKjBT8HPz0tuufrqR0muNQ55b01f?=
 =?us-ascii?Q?6sVFe/UUB0SGQFI31OLyCj3RHUiAWbyCCJU0EFrweRdExE+K7hYOP9UVeDXv?=
 =?us-ascii?Q?GTCwSjTzwxzSW67GzBkZ7jPoeWhxHUZkjjoSp8IkyxavxGXfbink8Es+8bpi?=
 =?us-ascii?Q?M2Lz7LsLC8QxIWuG26se07q8peUPUAOCO1Xml7/r4LbZ46XEdpqmc+ksNQ9a?=
 =?us-ascii?Q?Ze2CZwFugh8lL52vcAyr+WlCneqeIxcB3LV6il/U2WXgdRzumHnJq4sc0Y7v?=
 =?us-ascii?Q?Ljz2AAMtOluwSdRhzRpzK/tDPV2wxncfKts0xzxEN/XgmAl7a7ti7CzKC6NT?=
 =?us-ascii?Q?3NPwnq0SvvmkCXjGm1wjpw2BCPBwDdNR+ZAljleFNjqHwL3tYv6nnz9x2yVZ?=
 =?us-ascii?Q?IP5LNOGwjSDXxe4R2oZKphSgnFOHaK90ij28c0lPRXzwg/9K/4imdqLaoKVK?=
 =?us-ascii?Q?nSIZiOGwm7rCRT/Vp38Nwh/7pus2U4cb+nUAeIfpz7aNpZAsu+s8AdQStFDL?=
 =?us-ascii?Q?X97v0FZIxxa7i0ygv6phQMZzDJLJGLdD1rNtVOYapSQYU3yXuMFBRFogqOsA?=
 =?us-ascii?Q?dIuPFlNwgejgBGe3alLaJiT5s2TgS2YZ0Mi9TVxEsqiaUZRV7qbB6Tm+u7da?=
 =?us-ascii?Q?sFXMnMroKy/kXXRn2C15GPtmyr0QCSHYLwZ4sjmEXIjvGpG2jUZ3JU1PTxCy?=
 =?us-ascii?Q?2Lf0/qbWXgBEHkO1I2flFJ8ul7jxbfmxVHKQ2ChNFr052yMi+8kyNU4/OtJG?=
 =?us-ascii?Q?OwaJd491uF7MNBWaWYOgW0hI+wffaaFovGncUZca4pv6XmusDVzH+GdfdhGN?=
 =?us-ascii?Q?Wp+ObJoCxLeaYixHl4tgEhFzFCSVQJDYWmBX52BtXnWN6kS+0MbE5c8tjVGr?=
 =?us-ascii?Q?2Wn4gkgcdSI6goxGJyztc5aX20AdYmx09+BzqB6ODEeCIlcCIzvqOws/jwHl?=
 =?us-ascii?Q?BLu2Mw1Lnte/QPkbyb/rGFSqi3PV2SxNfwM64nQMARXSA0PyjRh7dqFh1ZTP?=
 =?us-ascii?Q?29B/hJKCQ/NxBJZGJS+UK68F0iOSR1JQy8oa0hbnv4ISdQiltPvIWndW12wn?=
 =?us-ascii?Q?1kJdvWjB1/AWHB66DrdET6je+OWYYWWHGNa4LZlIsz6sjnIDz9jUtugMwVWP?=
 =?us-ascii?Q?vE8koSBucRurv55hCAfFOoZ9CHTrOsCiw6fKmwTAf1oyK7zhaxr8OKAMTNzi?=
 =?us-ascii?Q?dyrBNyAG4iuB9FgRwUA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f63d30-c0cc-4ae4-6c59-08dc63c8a5c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 19:07:40.5445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uYoY91pA2Ci6DrxpsZUVvo1fwIcf2UD+tLTm55Ns674A6mON5uc4zMA7mPgP4Jvz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7814
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

[AMD Official Use Only - General]

Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>

Thanks,
Ruijing

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Sonny Ji=
ang
Sent: Tuesday, April 23, 2024 2:41 PM
To: amd-gfx@lists.freedesktop.org
Cc: Jiang, Sonny <Sonny.Jiang@amd.com>
Subject: [PATCH] drm/amdgpu: update fw_share for VCN5

kmd_fw_shared changed in VCN5

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  5 ++++-  drivers/gpu/drm/amd/am=
dgpu/amdgpu_vcn.h | 10 ++++++++++  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c =
| 14 +++++++-------
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index 2bebdaaff533..9ea341b76165 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -185,7 +185,10 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
        if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP)
                bo_size +=3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_s=
ize_bytes) + 8);

-       if (amdgpu_ip_version(adev, UVD_HWIP, 0) >=3D IP_VERSION(4, 0, 0)) =
{
+       if (amdgpu_ip_version(adev, UVD_HWIP, 0) >=3D IP_VERSION(5, 0, 0)) =
{
+               fw_shared_size =3D AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdg=
pu_vcn5_fw_shared));
+               log_offset =3D offsetof(struct amdgpu_vcn5_fw_shared, fw_lo=
g);
+       } else if (amdgpu_ip_version(adev, UVD_HWIP, 0) >=3D IP_VERSION(4, =
0,
+0)) {
                fw_shared_size =3D AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdg=
pu_vcn4_fw_shared));
                log_offset =3D offsetof(struct amdgpu_vcn4_fw_shared, fw_lo=
g);
        } else {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.h
index a418393d89ec..9f06def236fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -454,6 +454,16 @@ struct amdgpu_vcn_rb_metadata {
        uint8_t pad[26];
 };

+struct amdgpu_vcn5_fw_shared {
+       uint32_t present_flag_0;
+       uint8_t pad[12];
+       struct amdgpu_fw_shared_unified_queue_struct sq;
+       uint8_t pad1[8];
+       struct amdgpu_fw_shared_fw_logging fw_log;
+       struct amdgpu_fw_shared_rb_setup rb_setup;
+       uint8_t pad2[4];
+};
+
 #define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80  #define VCN_BLOCK_DECODE_DISAB=
LE_MASK 0x40  #define VCN_BLOCK_QUEUE_DISABLE_MASK 0xC0 diff --git a/driver=
s/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index b9455b6efa17..851975b5ce29 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -95,7 +95,7 @@ static int vcn_v5_0_0_sw_init(void *handle)
                return r;

        for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
-               volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+               volatile struct amdgpu_vcn5_fw_shared *fw_shared;

                if (adev->vcn.harvest_config & (1 << i))
                        continue;
@@ -154,7 +154,7 @@ static int vcn_v5_0_0_sw_fini(void *handle)

        if (drm_dev_enter(adev_to_drm(adev), &idx)) {
                for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
-                       volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+                       volatile struct amdgpu_vcn5_fw_shared *fw_shared;

                        if (adev->vcn.harvest_config & (1 << i))
                                continue;
@@ -335,7 +335,7 @@ static void vcn_v5_0_0_mc_resume(struct amdgpu_device *=
adev, int inst)
                upper_32_bits(adev->vcn.inst[inst].fw_shared.gpu_addr));
        WREG32_SOC15(VCN, inst, regUVD_VCPU_NONCACHE_OFFSET0, 0);
        WREG32_SOC15(VCN, inst, regUVD_VCPU_NONCACHE_SIZE0,
-               AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared))=
);
+               AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn5_fw_shared))=
);
 }

 /**
@@ -439,7 +439,7 @@ static void vcn_v5_0_0_mc_resume_dpg_mode(struct amdgpu=
_device *adev, int inst_i
                VCN, inst_idx, regUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirec=
t);
        WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
                VCN, inst_idx, regUVD_VCPU_NONCACHE_SIZE0),
-               AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared))=
, 0, indirect);
+               AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn5_fw_shared))=
, 0,
+indirect);

        /* VCN global tiling registers */
        WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET( @@ -616,7 +6=
16,7 @@ static void vcn_v5_0_0_enable_clock_gating(struct amdgpu_device *ad=
ev, int inst)
  */
 static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int inst_=
idx, bool indirect)  {
-       volatile struct amdgpu_vcn4_fw_shared *fw_shared =3D adev->vcn.inst=
[inst_idx].fw_shared.cpu_addr;
+       volatile struct amdgpu_vcn5_fw_shared *fw_shared =3D
+adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
        struct amdgpu_ring *ring;
        uint32_t tmp;

@@ -713,7 +713,7 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_devi=
ce *adev, int inst_idx, b
  */
 static int vcn_v5_0_0_start(struct amdgpu_device *adev)  {
-       volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+       volatile struct amdgpu_vcn5_fw_shared *fw_shared;
        struct amdgpu_ring *ring;
        uint32_t tmp;
        int i, j, k, r;
@@ -894,7 +894,7 @@ static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_devi=
ce *adev, int inst_idx)
  */
 static int vcn_v5_0_0_stop(struct amdgpu_device *adev)  {
-       volatile struct amdgpu_vcn4_fw_shared *fw_shared;
+       volatile struct amdgpu_vcn5_fw_shared *fw_shared;
        uint32_t tmp;
        int i, r =3D 0;

--
2.43.2

