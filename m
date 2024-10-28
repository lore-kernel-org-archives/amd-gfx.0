Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC1DD13570
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 07:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4516110E275;
	Mon, 28 Oct 2024 07:14:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hOKsfCTq";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B729D10E275
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 07:14:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8dnXlSLQRTGWA6xbwzQqBCoCmrrAxR30qvRehEkQ+SiJcPSMQxLf2WQAfJ9JO6/YFg/IECZexKJnHOHyi/CDifEe6S1WdlUCqR5DE3Fu27oC2S2mAOEuy+xh9jODE5vxVY5fs6m2j9IRQ92mtuD1RzhndKa4dul2pWtoE/HxT1AkslrMNAKYZEjMixibqxl3rpCx9uj52XQ0iFmjWC5rq1LsGmzEckRLIz9XpEYcCD4ROjej9XwyFmIs3VisAUKMNgiwH5ejpQ+A8rTV7rS97vwgGQ1JlyyUAtQsVZZJ0m5zrZf4upP/aHUa3y5DolN+FnHuDfzLphW4aq/M6TMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7Q1tmVa3xDWeJ8W8ZsvMLoo0ZBfeQruS3nTT1HzP+Y=;
 b=p6ge6k+3FrTM975A5rpz5CDC+dTsEw8JjCxBfekzgd3QiFnptMaGe9QPQew63gsyN/ta8rXTfNmOZIppn4Js4/ScAECMP+maTOw0Ve/7slul2JEdzwPMSDOMge3ngTWf6mzlmCDGlTfPvZouNxOUL6Qg30EYDKCvJ/g3fzpi5cK65oWOMnzVMjQihLTmn/QfPtkiYdsemyj+mzDstrh+kBDlHfW3iiXP3ssZwqRSJxDeAsOkn/wfnWfxrGA78qDTmTeJArIeazGeP4FUtfNXEbn3baoR6oEp4NpwwEpbv91ywpYrrYIm5Pebj7hO4w+b0DqVKUhgbS7/bbfuHcYHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7Q1tmVa3xDWeJ8W8ZsvMLoo0ZBfeQruS3nTT1HzP+Y=;
 b=hOKsfCTqcWJdVtZgfbzj4fJobN6N5awWeFSpn/nM72hbOP3U0De16dakgDnL8ANSVW/eIj+kZwhiojSLvVJuJUegYhIDfFCehmIab2nf3QREtpfBGbQL3Pa25MKjFSKr32i1034gWnNq8VDG+77YKTajneMIadf6E2k7s0fP8yY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH8PR12MB6915.namprd12.prod.outlook.com (2603:10b6:510:1bc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 07:14:36 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 07:14:35 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>
Subject: RE: [PATCH 1/1] drm/amdgpu: add generic func to check if ta fw is
 applicable
Thread-Topic: [PATCH 1/1] drm/amdgpu: add generic func to check if ta fw is
 applicable
Thread-Index: AQHbKOee9vSJbDlov0OJ8kCkWS0ECLKbwClw
Date: Mon, 28 Oct 2024 07:14:35 +0000
Message-ID: <BN9PR12MB52571C764230E7B1C829349AFC4A2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20241028031453.1120413-1-le.ma@amd.com>
In-Reply-To: <20241028031453.1120413-1-le.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5c95d82e-645a-4622-b58b-434cb0198fd1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-28T07:14:10Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH8PR12MB6915:EE_
x-ms-office365-filtering-correlation-id: 78566d8c-c4bd-4e0d-ef65-08dcf7202db9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?OxGroXQbGn8Eh+V15FXVEmBLihuVC7k5/YlgcdEYxQPM4l6eI/GF1rN4VLWD?=
 =?us-ascii?Q?rcTHdS6UW1YHPgOhmTUZxX5R9oOxFkKF1JzSuALlGrSOd0iNTqUFEmffbj5t?=
 =?us-ascii?Q?Xl6ZEHNXsKiqjV3uxaUIeMfFeI/Ay2vp9m+7lu8VLdtOi2klg5Ie8P1EcCLy?=
 =?us-ascii?Q?HJIgCqoUK5CLkAtMsqW1E6TY88bN+GuGRAXUNGBkdV2nz7ke7lfY6nulcHUt?=
 =?us-ascii?Q?UjKxfMPqrK9wBJE5+8ZVTe+1ab6M3/Z3cemz6zN5IW8UjLo7/BaR77f8floU?=
 =?us-ascii?Q?u8mRJfnGCdDoh1USShEuBiEcOV/fE5xpUs7idcmPvhZYooCSuK8Pbwn4BLeS?=
 =?us-ascii?Q?i+xAuBhggsfWVVtGMFJfgHMIj9H044C/yaza7MMqW7f8P1a4xEa/AMo1kjFv?=
 =?us-ascii?Q?K0BoUq2+I/Oo3BgydIAgDB3PHmju+r/40grAe71VfmB/FSnyA0XvTfvTXz0z?=
 =?us-ascii?Q?LfT6ed+LFfri+bv4t1bCOqYYQjP+VHKIpn/zGheto40yqIEQi/Gj2PzMzFzS?=
 =?us-ascii?Q?5AQqyTKTb0GHDkZz5NJFJkjswHmWtFczYDSrQswwLwLvm1s6OIdvOJr6SorN?=
 =?us-ascii?Q?3xHh0gjOkLb9ro0hwOwu+Td3wQ0TBYN8l1Kx0feW61mDmiG649GE795YGWuA?=
 =?us-ascii?Q?A3HIb+3g4h/oJ5PdZX7YJ5kAKtEEeyuWi1Pub2YJeU+xn5GsljpMrERtJzKP?=
 =?us-ascii?Q?yH1Sqo/TH7OPBTiBLecBNkLcl/XwWRln6uV/h+Srum/bNN7A27u82KUCApX0?=
 =?us-ascii?Q?EICrQiyAFMbGfN2yl/XKHIy9KkrXEEzZ1krCzWahNIqlDGpvEDR7GMujTeUz?=
 =?us-ascii?Q?r9CvernS/PIJJK6Nhr/bipWRpBcBT+s0nPDxToWjuynNNXcSlM3RtjTSMxMM?=
 =?us-ascii?Q?j6IVGtQnDHIvuLS3MWJaT6TmxLwDsXdIaQDx/sDaCQpYcyzDJ8bAw3C47p7k?=
 =?us-ascii?Q?vincwP4tX0zbeiYYBGoqKj+cXgBhy7cPUDsFmtcN6Bx/x67upsf0yeXPV2k2?=
 =?us-ascii?Q?SuKGWdQadq96Nf2m0hBIKymaM7oUkGOJ+elZzClTFkPWEdyaSDd/vdViNqsK?=
 =?us-ascii?Q?cyBLfQXMBA8vu18znXvaOLSpdALK/Cc3D6eLq6zjGOsEPtgpjEAud9spgWwp?=
 =?us-ascii?Q?3KcNbibpTz9T5pZ7UDuDC89kKAZE/E6f8qYaILKtnJ5WLcw1TW0nWT7R4svI?=
 =?us-ascii?Q?1ol+ZDXWysj3GcT0xPtoMf1azyYpCGH8Hm5HC9LierT8FdcmPO617qlcoK6O?=
 =?us-ascii?Q?W2NlXeQGCKuZVLV3l7X74a5xkCEKT/zaeczzrjvFEOyZZzIUutejaHmVOTz4?=
 =?us-ascii?Q?Dg7gQoOOofTMJFvo5b8/g2l9qbzghdLsAu06XzkpBSkq3WJknWxStrE8lKZV?=
 =?us-ascii?Q?E9oVieI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?57lB9B7gFPOvAct7No7GPxGT5LoApJDL997ItyqtEatp3jrbXSPyiwniQbcm?=
 =?us-ascii?Q?ZxgDhQrS8QpHw4anVeZNHAJsgsU2PWrazZauwQnUEio9xgNJFrVpsdgNYyES?=
 =?us-ascii?Q?eKzwPQ+rT/MYsgLaLdTX+qNyx8M/x4REoYjcSOPiJ8x099ssIaB4e34mYEnM?=
 =?us-ascii?Q?CYjKd1tflN+R87GXOv6pSrkl7TIPUBafcFHUIjrrqTWEyDXW63koiG/hHY6o?=
 =?us-ascii?Q?nliRoWEU5JkrlHjzq/QErVz8adO5mwNs0hj5Ywbj+zqB/j1Ykqqlx/je7nWe?=
 =?us-ascii?Q?V141gn/XqG9alUAAKTDc7CVtfeGUV9NzNhq/jPf//R98g+74po4Lhftwi26F?=
 =?us-ascii?Q?PchVW45dHf0ucGAkF1Io5/4RmFduB1n0ChanTI/hH1DkuYQjNC1AaWk74zL9?=
 =?us-ascii?Q?T4BeFjfshTXzzYUGOynHpGeKbOfjh27q9cIQpNHJjlGixsF56ZCnILXTMPAN?=
 =?us-ascii?Q?a89+/kvHFXEmW2/iLe+kJY/svC75fBtS7sD8koyuy68IGD4/yqhakN0sRugw?=
 =?us-ascii?Q?aRICUNz150w7Utept9JKtDNghQiqrOCxgs6h1Tg/8BlfDWDdotO+o/SnKBF2?=
 =?us-ascii?Q?W8KAP1QXRTmzQ1zJNCbQU1VuZ9ifN/Sm1qPT0fc9qa5Jz7Y7Za9S3+EO/83k?=
 =?us-ascii?Q?QVk+FbybA9crLy75FgK6Euz9tLZonLn14rm/MBpM348Rye5BMHmoRzA8mUbD?=
 =?us-ascii?Q?hh1A3sQCwgDuGnFWaIdOU2KvI0plHXgPmDoOAT5DMre+J6ULzbx6IRo4dPL2?=
 =?us-ascii?Q?3m5O/r8Bdo1YWL53oCGmbcvRBzmkw4JUiGTdw1b+JNCgwiIMHG+IUC8mAGwH?=
 =?us-ascii?Q?+0bFv9xyoKvXvxq24gxph2Wrh0rEzq+8IHPG40WDjoLHfzuA/sVaWZRUszTq?=
 =?us-ascii?Q?BevzcfSQeVY5J6Nptwx5++WoAyFydAtNaxUvNyUKsDaJH4JP72mtwZs4rM0P?=
 =?us-ascii?Q?AEJrmZRqYbGN/yTVzQnUWo8iADsvxSpfGPurJHx4vT1VHkREASujTuGBwa16?=
 =?us-ascii?Q?Iq0rgEAbSp7LSCCdeMELzRcUyQzTN6OIGMJene5ArmrWkgQXoKEugzDzrnyn?=
 =?us-ascii?Q?qMN9YazYUm1ym+Pwrzu4Cf3nR2qa8i4PaokMmog1xqZDLOWUUPCyjS9B/pbH?=
 =?us-ascii?Q?6KoawPmT40LPAblysmBs9FbOBgrwh0B49RWQLHlYGqjsPM+JM+1hjfWGtuvp?=
 =?us-ascii?Q?v0YzBJUgmULUVGS3fzR2GYj26pRdgNlyIT01RAFSX+TDvBLzUIb78eptdRh+?=
 =?us-ascii?Q?Ke61VBXPg9sL4C9hQeaI7P9VTBRmhFO6sHKcHEkyuEp0XgsgFO6bjNUt/FAs?=
 =?us-ascii?Q?WL5Zx0Sd5wEkwIOWR9IbrlYc+GgQVdvtCz/VXDyAOCGW1sdlDEtjGo+pgVs2?=
 =?us-ascii?Q?1+E1CLY1j7zzAjm+tGwSG+b7HzhCs9LUDnd/ZuPXYKKKhh3nEfMAcN04UDJc?=
 =?us-ascii?Q?jjqGAg+JaQYD6PHvfb6f+E2Vk5Tb37y9h81AJQb7oijBVOyn4fE4QVtZRXwa?=
 =?us-ascii?Q?U+RzRLj9sp14rAuAkZ8rw7H3xdEyd6wsk2nyGekEHYxq7AgQtFvFaEvgXbAr?=
 =?us-ascii?Q?/iEvFqEYLroR3OQ1UP8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78566d8c-c4bd-4e0d-ef65-08dcf7202db9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 07:14:35.7752 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y5dwmwUCoZpNmZtDjWivIR27F6dDVlN/qs1o05UsvPXq4YQJopGlBS0jiBhXPBt+Sm0YgUGt9XDvmts/HB4LXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6915
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Le Ma
Sent: Monday, October 28, 2024 11:15
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com=
>; Deucher, Alexander <Alexander.Deucher@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: add generic func to check if ta fw is appl=
icable

Separated xgmi ta is required for specific APU, and driver needs parse the =
ta binary properly with aux xgmi ta packed.

v2: make the check function more generic (Lijo)

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 33 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  1 +
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index abd5e980c9c7..92cf412a4c2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3563,6 +3563,35 @@ int psp_init_sos_microcode(struct psp_context *psp, =
const char *chip_name)
        return err;
 }

+static bool is_ta_fw_applicable(struct psp_context *psp,
+                            const struct psp_fw_bin_desc *desc) {
+       struct amdgpu_device *adev =3D psp->adev;
+       uint32_t fw_version;
+
+       switch (desc->fw_type) {
+       case TA_FW_TYPE_PSP_XGMI:
+       case TA_FW_TYPE_PSP_XGMI_AUX:
+               /* for now, AUX TA only exists on 13.0.6 ta bin,
+                * from v20.00.0x.14 */
+               if (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D
+                   IP_VERSION(13, 0, 6)) {
+                       fw_version =3D le32_to_cpu(desc->fw_version);
+
+                       if (adev->flags & AMD_IS_APU &&
+                           (fw_version & 0xff) >=3D 0x14)
+                               return desc->fw_type =3D=3D TA_FW_TYPE_PSP_=
XGMI_AUX;
+                       else
+                               return desc->fw_type =3D=3D TA_FW_TYPE_PSP_=
XGMI;
+               }
+               break;
+       default:
+               break;
+       }
+
+       return true;
+}
+
 static int parse_ta_bin_descriptor(struct psp_context *psp,
                                   const struct psp_fw_bin_desc *desc,
                                   const struct ta_firmware_header_v2_0 *ta=
_hdr) @@ -3572,6 +3601,9 @@ static int parse_ta_bin_descriptor(struct psp_c=
ontext *psp,
        if (!psp || !desc || !ta_hdr)
                return -EINVAL;

+       if (!is_ta_fw_applicable(psp, desc))
+               return 0;
+
        ucode_start_addr  =3D (uint8_t *)ta_hdr +
                            le32_to_cpu(desc->offset_bytes) +
                            le32_to_cpu(ta_hdr->header.ucode_array_offset_b=
ytes);
@@ -3584,6 +3616,7 @@ static int parse_ta_bin_descriptor(struct psp_context=
 *psp,
                psp->asd_context.bin_desc.start_addr        =3D ucode_start=
_addr;
                break;
        case TA_FW_TYPE_PSP_XGMI:
+       case TA_FW_TYPE_PSP_XGMI_AUX:
                psp->xgmi_context.context.bin_desc.fw_version       =3D le3=
2_to_cpu(desc->fw_version);
                psp->xgmi_context.context.bin_desc.size_bytes       =3D le3=
2_to_cpu(desc->size_bytes);
                psp->xgmi_context.context.bin_desc.start_addr       =3D uco=
de_start_addr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.h
index 4e23419b92d4..4150ec0aa10d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -163,6 +163,7 @@ enum ta_fw_type {
        TA_FW_TYPE_PSP_DTM,
        TA_FW_TYPE_PSP_RAP,
        TA_FW_TYPE_PSP_SECUREDISPLAY,
+       TA_FW_TYPE_PSP_XGMI_AUX,
        TA_FW_TYPE_MAX_INDEX,
 };

--
2.43.2

