Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BDAC5516F
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 06:30:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC6C110E170;
	Mon,  3 Aug 2026 06:30:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rcYy7Ddq";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010025.outbound.protection.outlook.com [52.101.46.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5506510E170
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 06:30:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpYYxXES/dmXcjWglyHfPIMcuARQ6ghrUlEmAwlND3ghsBCwpwLDQG7vGEIVVHXP/fqonvMd/PpqAvhGGL+xpEhzBrcA0K7zZkrvvS6/g9V6vOaZi+vxib5lTY9ve2LnP1nasF6XDvS1hmv6BiSonpxvBfyUZ90yUIDWzB5yoAexkFU+3O2EX/1Rao/MCU92zYeimEkH9Yhi15hLM76s3QETKPwJ4cVFm8wIqrPOcX1wfhMbnXORU/SytTyN4eqDb8h3sIi0cmqdfZoaEBSveotQqUw/AcDAvxn8dVO6pIAe3x8Vp9+jwdiSFGjB5QFF+GEyE24Km9rkQUImL7+Sdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiyHRivcR3aKZaBFOGc6JxYdw3xPqkVoYnoIDDN/O+Y=;
 b=sMPFBegOy9+CueiLH/wKPFDSe2ToGNikallD8FuS3ch3aa0TSpEwDvKx3ejSJDN+afeZik1SW/LNgX2mSKxwOiINrrWAUo+RmB2n+z7Znho6rv9415CWO0/qaeYKaFrX9/4l+2lb2Eac2rqQndOr+z2xXy8kmqsGzHp8faou9nhEbNv6hJiX3SPwGGmCRR+sPsp4FCGtUW2FjerTkBqacZ0xDteVieT9ffzg6+lxBRwHeSWRpLCOpVKRCfG+O3nLFrVfDmJI0zII5wWviQhnH+vT0VHy7GP9i0hD2Dk8gpXYDDh8NGJZWCjDCSoL41LSCUD33dSl0lLUiADnn1ZzHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiyHRivcR3aKZaBFOGc6JxYdw3xPqkVoYnoIDDN/O+Y=;
 b=rcYy7DdqGosjlTlGDbhzDeDGM1ZyHnkcgFjfJzuKCgHHCEIJCLekNiFlw0fGEZr5mGh/md4vpZ9ivgc5pVdrlRTbNMwsZWaS4QtCHc0gBEEvvmqQwjI6Qi4NkmjnCmwYEc+LkpjLl/Nl4yV29l6y10TOa8Mrb5AuH4IwyphphSI=
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 (2603:10b6:303:2c1::15) by CH1PPF711010B62.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::614) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 06:30:15 +0000
Received: from EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2]) by EAYPR12MB999158.namprd12.prod.outlook.com
 ([fe80::c52f:2856:964e:a4b2%4]) with mapi id 15.21.0270.015; Mon, 3 Aug 2026
 06:30:15 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 1/3] drm/amd/ras: move some umc v12 specific functions to
 ras_umc.c
Thread-Topic: [PATCH 1/3] drm/amd/ras: move some umc v12 specific functions to
 ras_umc.c
Thread-Index: AQHdIvmPflSluqf9/EuouyT1Ml1ZybaL3QsQ
Date: Mon, 3 Aug 2026 06:30:15 +0000
Message-ID: <EAYPR12MB99915806398B5BE3A4D52761B6FCD52@EAYPR12MB999158.namprd12.prod.outlook.com>
References: <20260803033806.2881888-1-tao.zhou1@amd.com>
In-Reply-To: <20260803033806.2881888-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-03T06:29:55.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: EAYPR12MB999158:EE_|CH1PPF711010B62:EE_
x-ms-office365-filtering-correlation-id: 52c46ee6-7c75-4bfa-b3fe-08def128ae3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 5cGgXu88ij8gsudV6DQKDhN1DW+DiWFRx+MsCc0+te4rdY8MN0u8UyiTW0Cu66LmTvC6v5CBJJsM7e7EvGVd3cRougy4l7Zkyj8EMYLQfNp0ZqXNravNhR6jJA4a5ZnkTm3yYjdpyfcHbLd0fOWqZPwXrgzgIN4/uWhcEhywrL1dgppKc15wAffwkwZc1g3Ea014lb7CLcczK5IJ2imkmkyeIDZrvt5fzZ/LN5rlXJjLqPuen1ByG1nOmFo70ncRWslOuCBUXoa5Hf1F9osii78Wk9Ol/g3teJ7aA/Dh0Pi8zFv0uZ0yBeRj7A0jbsh2v+gQ7/yMA/JYRYRsF1Cv0QEeswl3aV58G1fx9tEq11X/RlvleRxxoa2MdSL0QwNReDWyoEPFg+c1blFHim2BwT1X1LeN9QQ+qYqy9shy14pfEpyvvDn47CRElUyLw6v0NW3xkf5nPEphQzeM5lyeSIp1urIRsnIIVkUpEHrAIv8bsV98UvK8OyBWbDSQqLMPCGSATNEzophDEIoj6VtQ87ITIp7BGLKsNt6tysn+x01HXRqBuuKut5hkLIDJmFJef8xGOA/1IFb0zAPzHsruY0NIt7PCQOSYzd9y4cQqDIMb1nQhKoRJ2GL+fIVYbmjYaDdn880eAw12at51BeNBua91695STZyUJeCdSg9uV8LsAhTesRz8o13WCiycLmW4NElGWSX5gTGw4T/kCXDHUpAMV/mVbfORFXWCAVJgmj8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR12MB999158.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XG8dyn0B7KjwVgjjr5wTlh5pmze0cXxTiyZZ3oYjVMbLz3RANRYU4bAKfhHB?=
 =?us-ascii?Q?DS9mnRMMLYZ0AfsMxODlyKOzt6EW8np3Bh6srjHqdikOunXjzLvth41kWq3e?=
 =?us-ascii?Q?nYK6i+6nKAh7bebA5Cmg8Ysdacx4crx9nG886MoKfzVzIWanfzyP/xhEp2/F?=
 =?us-ascii?Q?PFoHlvLzIM5xKHrKbUs0eocD9if8bVyxJNI1v6cKNOtIvil58oTPOyTCCZID?=
 =?us-ascii?Q?UpmQF67dD556zxVCRw4+MsPJMRleAbzlaTAikw6AjYEV7o7lvzY9tTWKY9h7?=
 =?us-ascii?Q?BNcUHuO8voK4lJrC7OoaZeuXn2untOHA4ysZMxm+HEysliS0Nlvdn1XfJMg+?=
 =?us-ascii?Q?MHXQ1QGegWiCDsdjMpqsFHxEZ3Oaqy3yM7ARiCwM/eGuevntjufEZVZSCbvI?=
 =?us-ascii?Q?kndXSdO5wZn5+tz0xQ7Iqjn+yqRRk9t8S+jKKHvEEu5BzTeY8YuL4jVWU0DJ?=
 =?us-ascii?Q?PuIT006UhB5MmuRla/CISVPURQTOe3ksoKgig9yo65vNPNCOjNg4IpwgdO/U?=
 =?us-ascii?Q?OEqo7YjuZio6YLpkTtu7P9c+/rn0aGMlRtBFIUhwfYVeShsG35A8GzyjWor7?=
 =?us-ascii?Q?RSyilS63z4nWMul8drPPkbTvjXZYeMqasLVRlp9FE+If+MH+INO6hndzaslJ?=
 =?us-ascii?Q?sXUWLolsWo7Taz7X4fD3R49HK1Hs3zAsGg3ZyZW8kLQBuv6TwiHVtNdQekD1?=
 =?us-ascii?Q?+SU8kDL/JGtA3NKP++X503el8OhxWOvggxlPV+EnKhZ26KPyw1l13PLQOrgw?=
 =?us-ascii?Q?d1laUJFboiyFYezeKR7SrDn/xsY6ri3Z6gfRKYertC4uhcWfSHG7G1jyw3kr?=
 =?us-ascii?Q?AxXtBgAT2h4VdOQKnCb9x/JPQ34Va/4CykouYbtNMHPr3UmfcgfmrLoxh8yh?=
 =?us-ascii?Q?aChgrpnnZSwthMTZBBUmlhR67CEGTzee5UyhAJbaeAZFOmPCovel/gSwERGI?=
 =?us-ascii?Q?DMMdM99xKQgg/9tffP/WCIshhJumbLc6oenldHs8wROM7pUgX29n158VeSRx?=
 =?us-ascii?Q?wykhAnAMFvYmwCviVLcBvI++1hFduPWllZwzvCodZ+cE1VC5lHYHER9Zd4Tf?=
 =?us-ascii?Q?ZlzvEte6K9pSLrlPX/ROdSojIUXGn78TBOLtbQ4Bw0ykEJR92+MV9TTdulDK?=
 =?us-ascii?Q?eki9L99AYqfD59pH+vuJ9Ss4nomTaRLZbLNDnlZXKn+AWJ7AqCcFfuTBpv3y?=
 =?us-ascii?Q?gc5QRtop7oGUV6HHdPeW0TeiyOv4Ii7fCJ/DGzBGDFN6inetiShT3xI6Bo5+?=
 =?us-ascii?Q?1LCPm1ckyC68ODs79nj9CZaKrzoTqIvUFieBjpUxQktuyctQPq4vTXnht3AK?=
 =?us-ascii?Q?k3hiRtXPFzgb3ILF1pH5NOspezuGux6hgNRjpPtQuBoOaRCNi5qs8PCCl13T?=
 =?us-ascii?Q?kZwMkqBiQOc7LvZrgGtiUU1o9ElHYl6syTijDYIg6rlykVJUmB8H6fVtps70?=
 =?us-ascii?Q?1mRG3d3VNvcmcdKWTe1T/Lngidxi0WLn7dGGzSGJeLBDy768MmYUQAJalYZb?=
 =?us-ascii?Q?Q1bY3lqXBB1n1o43MddtLKnTtM7r6oftLOow00WTvCwvGAbdJSro2jXoa20H?=
 =?us-ascii?Q?4gY4oelB31ThGoU4Eoru58a9MJT0DLjxW7oS2JrWDocNqAMDqkvz/4883Rwj?=
 =?us-ascii?Q?bS9SsPQUrcQ9IYPD+lzjHQaNeJKHlod62dmOAXROwg5Ry5XvBye/8TZCxlV5?=
 =?us-ascii?Q?lOA1oRwGuUNYuJTG2zYqBz7BwmtGxerbB5AJFDxoc7DPQEqJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB999158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c46ee6-7c75-4bfa-b3fe-08def128ae3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 06:30:15.7427 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TfNNPHu+7OAh+6htXTq8VKMfy0mn1YgPUIBQsihXcJRPSlgoUqcPndB3s4pxmuVZhmXhNec9mXUWVp/FMKa70g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF711010B62
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Monday, August 3, 2026 11:38 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 1/3] drm/amd/ras: move some umc v12 specific functions to r=
as_umc.c

So we can reuse these functions across different ASICs.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c     | 101 +++++++++++++--
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h     |  13 +-
 .../gpu/drm/amd/ras/rascore/ras_umc_v12_0.c   | 118 +++---------------
 3 files changed, 119 insertions(+), 113 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/am=
d/ras/rascore/ras_umc.c
index f59f0b6cad06..b8e3a92ab174 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -82,7 +82,7 @@ static const struct ras_umc_ip_func *ras_umc_get_ip_func(
        return NULL;
 }

-int ras_umc_psp_convert_ma_to_pa(struct ras_core_context *ras_core,
+int ras_umc_psp_ma2pa(struct ras_core_context *ras_core,
                struct umc_mca_addr *in, struct umc_phy_addr *out,
                uint32_t nps)
 {
@@ -307,6 +307,83 @@ int ras_umc_log_bad_bank(struct ras_core_context *ras_=
core, struct ras_bank_ecc
        return ret;
 }

+int ras_umc_ma2pa(struct ras_core_context *ras_core,
+       struct umc_mca_addr *addr_in, struct umc_phy_addr *addr_out,
+       uint32_t nps)
+{
+       struct ras_umc *ras_umc =3D &ras_core->ras_umc;
+       int ret;
+
+       if (ras_psp_check_supported_cmd(ras_core, RAS_TA_CMD_ID__QUERY_ADDR=
ESS))
+               ret =3D ras_umc_psp_ma2pa(ras_core, addr_in, addr_out, nps)=
;
+       else
+               ret =3D ras_umc->ip_func->ma2pa(ras_core, addr_in,
+                               addr_out, nps);
+
+       return ret;
+}
+
+static int ras_umc_eeprom_rec2nps_addr(struct ras_core_context *ras_core,
+       struct eeprom_umc_record *record, uint64_t *pa, uint32_t nps) {
+       struct device_system_info dev_info =3D {0};
+       struct umc_mca_addr addr_in;
+       struct umc_phy_addr addr_out;
+       int ret;
+
+       memset(&addr_in, 0, sizeof(addr_in));
+       memset(&addr_out, 0, sizeof(addr_out));
+
+       ras_core_get_device_system_info(ras_core, &dev_info);
+
+       addr_in.err_addr =3D record->address;
+       addr_in.ch_inst =3D record->mem_channel;
+       addr_in.umc_inst =3D record->mcumc_id;
+       addr_in.node_inst =3D UMC_INV_AID_NODE;
+       addr_in.socket_id =3D dev_info.socket_id;
+
+       ret =3D ras_umc_ma2pa(ras_core, &addr_in, &addr_out, nps);
+       if (ret)
+               return ret;
+
+       *pa =3D ras_core->ras_umc.ip_func->nps_pa_to_row_pa(ras_core,
+addr_out.pa, nps, false);
+
+       return 0;
+}
+
+static int ras_umc_eeprom_rec2nps_rec(struct ras_core_context *ras_core,
+       struct eeprom_umc_record *record, uint32_t nps) {
+       uint64_t ch_idx_v2, pa =3D 0;
+       uint32_t save_nps;
+       int ret =3D 0;
+
+       save_nps =3D EEPROM_RECORD_UMC_NPS_MODE(record);
+       /* eeprom v2 has no stored nps, always convert if the flag is set *=
/
+       ch_idx_v2 =3D record->retired_row_pfn & UMC_CHANNEL_IDX_V2;
+
+       if (save_nps || ch_idx_v2) {
+               if ((nps =3D=3D save_nps) && !ras_fw_eeprom_supported(ras_c=
ore)) {
+                       record->cur_nps_retired_row_pfn =3D
+                               EEPROM_RECORD_UMC_ADDR_PFN(record);
+               } else {
+                       ret =3D ras_umc_eeprom_rec2nps_addr(ras_core, recor=
d, &pa, nps);
+                       if (!ret)
+                               record->cur_nps_retired_row_pfn =3D RAS_ADD=
R_TO_PFN(pa);
+               }
+       } else {
+               /* old eeprom data format, the scope of channel index is
+                * limited to umc instance
+                */
+               /* TODO */
+               ret =3D -EOPNOTSUPP;
+       }
+
+       record->cur_nps =3D nps;
+
+       return ret;
+}
+
 static int ras_umc_get_new_records(struct ras_core_context *ras_core,
                        struct eeprom_umc_record *records, u32 num)  { @@ -=
343,12 +420,11 @@ static bool ras_umc_check_retired_record(struct ras_core_=
context *ras_core,

        if (from_eeprom) {
                nps =3D ras_umc->umc_err_data.umc_nps_mode;
-               if (ras_umc->ip_func && ras_umc->ip_func->eeprom_record_to_=
nps_record) {
-                       ret =3D ras_umc->ip_func->eeprom_record_to_nps_reco=
rd(ras_core, record, nps);
-                       if (ret)
-                               RAS_DEV_WARN_RATELIMITED(ras_core->dev,
-                                       "Failed to adjust eeprom record, re=
t:%d", ret);
-               }
+               ret =3D ras_umc_eeprom_rec2nps_rec(ras_core, record, nps);
+               if (ret)
+                       RAS_DEV_WARN_RATELIMITED(ras_core->dev,
+                               "Failed to adjust eeprom record, ret:%d", r=
et);
+
                return false;
        }

@@ -805,3 +881,14 @@ int ras_umc_translate_soc_pa_and_bank(struct ras_core_=
context *ras_core,

        return ret;
 }
+
+bool ras_umc_bit_wise_xor(uint32_t val) {
+       bool result =3D 0;
+       int i;
+
+       for (i =3D 0; i < 32; i++)
+               result =3D result ^ ((val >> i) & 0x1);
+
+       return result;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h b/drivers/gpu/drm/am=
d/ras/rascore/ras_umc.h
index 3d902b0d663a..9d32ac344316 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.h
@@ -119,8 +119,6 @@ struct umc_bank_addr {  struct ras_umc_ip_func {
        int (*bank_to_eeprom_record)(struct ras_core_context *ras_core,
                        struct ras_bank_ecc *bank, struct eeprom_umc_record=
 *record);
-       int (*eeprom_record_to_nps_record)(struct ras_core_context *ras_cor=
e,
-                       struct eeprom_umc_record *record, uint32_t nps);
        int (*eeprom_record_to_nps_pages)(struct ras_core_context *ras_core=
,
                        struct eeprom_umc_record *record, uint32_t nps,
                        uint64_t *pfns, uint32_t num);
@@ -130,6 +128,11 @@ struct ras_umc_ip_func {
                        uint64_t soc_pa, struct umc_bank_addr *bank_addr);
        void (*mca_ipid_parse)(struct ras_core_context *ras_core, uint64_t =
ipid,
                        uint32_t *did, uint32_t *ch, uint32_t *umc_inst, ui=
nt32_t *sid);
+       int (*ma2pa)(struct ras_core_context *ras_core,
+               struct umc_mca_addr *addr_in, struct umc_phy_addr *addr_out=
,
+               uint32_t nps);
+       uint64_t (*nps_pa_to_row_pa)(struct ras_core_context *ras_core,
+               uint64_t pa, enum umc_memory_partition_mode nps, bool zero_=
pfn_ok);
 };

 struct eeprom_store_record {
@@ -184,7 +187,7 @@ int ras_umc_sw_init(struct ras_core_context *ras);  int=
 ras_umc_sw_fini(struct ras_core_context *ras);  int ras_umc_hw_init(struct=
 ras_core_context *ras);  int ras_umc_hw_fini(struct ras_core_context *ras)=
; -int ras_umc_psp_convert_ma_to_pa(struct ras_core_context *ras_core,
+int ras_umc_psp_ma2pa(struct ras_core_context *ras_core,
                struct umc_mca_addr *in, struct umc_phy_addr *out,
                uint32_t nps);
 int ras_umc_handle_bad_pages(struct ras_core_context *ras_core, void *data=
); @@ -207,4 +210,8 @@ int ras_umc_translate_soc_pa_and_bank(struct ras_cor=
e_context *ras_core,  int ras_umc_convert_record_to_nps_pages(struct ras_co=
re_context *ras_core,
                struct eeprom_umc_record *record, uint32_t nps,
                uint64_t *page_pfn, uint32_t max_pages);
+bool ras_umc_bit_wise_xor(uint32_t val); int ras_umc_ma2pa(struct
+ras_core_context *ras_core,
+       struct umc_mca_addr *addr_in, struct umc_phy_addr *addr_out,
+       uint32_t nps);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/=
drm/amd/ras/rascore/ras_umc_v12_0.c
index 6bf30dee8d17..73eb1dba16ec 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
@@ -48,17 +48,6 @@ static const uint32_t umc_v12_0_ma2na_mapping[] =3D {
        24, 7,  29, 30,
 };

-static bool umc_v12_0_bit_wise_xor(uint32_t val) -{
-       bool result =3D 0;
-       int i;
-
-       for (i =3D 0; i < 32; i++)
-               result =3D result ^ ((val >> i) & 0x1);
-
-       return result;
-}
-
 static void __get_nps_pa_flip_bits(struct ras_core_context *ras_core,
                        enum umc_memory_partition_mode nps,
                        struct umc_flip_bits *flip_bits)
@@ -159,7 +148,7 @@ static void __get_nps_pa_flip_bits(struct ras_core_cont=
ext *ras_core,
        }
 }

-static uint64_t  convert_nps_pa_to_row_pa(struct ras_core_context *ras_cor=
e,
+static uint64_t  umc_v12_0_nps_pa_to_row_pa(struct ras_core_context
+*ras_core,
                uint64_t pa, enum umc_memory_partition_mode nps, bool zero_=
pfn_ok)  {
        struct umc_flip_bits flip_bits =3D {0};
@@ -193,7 +182,7 @@ static int lookup_bad_pages_in_a_row(struct ras_core_co=
ntext *ras_core,

        __get_nps_pa_flip_bits(ras_core, nps, &flip_bits);

-       row_pa =3D convert_nps_pa_to_row_pa(ras_core, retired_addr, nps, tr=
ue);
+       row_pa =3D umc_v12_0_nps_pa_to_row_pa(ras_core, retired_addr, nps,
+true);

        err_addr =3D record->address;
        /* get column bit 0 and 1 in mca address */ @@ -240,7 +229,7 @@ sta=
tic int lookup_bad_pages_in_a_row(struct ras_core_context *ras_core,
        return idx;
 }

-static int umc_v12_convert_ma_to_pa(struct ras_core_context *ras_core,
+static int umc_v12_ma2pa(struct ras_core_context *ras_core,
                        struct umc_mca_addr *addr_in, struct umc_phy_addr *=
addr_out,
                        uint32_t nps)
 {
@@ -277,20 +266,20 @@ static int umc_v12_convert_ma_to_pa(struct ras_core_c=
ontext *ras_core,
        /* apply bank hash algorithm */
        bank0 =3D
                bank_hash0 ^ (UMC_V12_0_XOR_EN0 &
-               (umc_v12_0_bit_wise_xor(col & UMC_V12_0_COL_XOR0) ^
-               (umc_v12_0_bit_wise_xor(row & UMC_V12_0_ROW_XOR0))));
+               (ras_umc_bit_wise_xor(col & UMC_V12_0_COL_XOR0) ^
+               (ras_umc_bit_wise_xor(row & UMC_V12_0_ROW_XOR0))));
        bank1 =3D
                bank_hash1 ^ (UMC_V12_0_XOR_EN1 &
-               (umc_v12_0_bit_wise_xor(col & UMC_V12_0_COL_XOR1) ^
-               (umc_v12_0_bit_wise_xor(row & UMC_V12_0_ROW_XOR1))));
+               (ras_umc_bit_wise_xor(col & UMC_V12_0_COL_XOR1) ^
+               (ras_umc_bit_wise_xor(row & UMC_V12_0_ROW_XOR1))));
        bank2 =3D
                bank_hash2 ^ (UMC_V12_0_XOR_EN2 &
-               (umc_v12_0_bit_wise_xor(col & UMC_V12_0_COL_XOR2) ^
-               (umc_v12_0_bit_wise_xor(row & UMC_V12_0_ROW_XOR2))));
+               (ras_umc_bit_wise_xor(col & UMC_V12_0_COL_XOR2) ^
+               (ras_umc_bit_wise_xor(row & UMC_V12_0_ROW_XOR2))));
        bank3 =3D
                bank_hash3 ^ (UMC_V12_0_XOR_EN3 &
-               (umc_v12_0_bit_wise_xor(col & UMC_V12_0_COL_XOR3) ^
-               (umc_v12_0_bit_wise_xor(row & UMC_V12_0_ROW_XOR3))));
+               (ras_umc_bit_wise_xor(col & UMC_V12_0_COL_XOR3) ^
+               (ras_umc_bit_wise_xor(row & UMC_V12_0_ROW_XOR3))));

        bank =3D bank0 | (bank1 << 1) | (bank2 << 2) | (bank3 << 3);
        err_addr &=3D ~0x3c0ULL;
@@ -360,22 +349,6 @@ static int umc_v12_convert_ma_to_pa(struct ras_core_co=
ntext *ras_core,
        return 0;
 }

-static int convert_ma_to_pa(struct ras_core_context *ras_core,
-                       struct umc_mca_addr *addr_in, struct umc_phy_addr *=
addr_out,
-                       uint32_t nps)
-{
-       int ret;
-
-       if (ras_psp_check_supported_cmd(ras_core, RAS_TA_CMD_ID__QUERY_ADDR=
ESS))
-               ret =3D ras_umc_psp_convert_ma_to_pa(ras_core,
-                               addr_in, addr_out, nps);
-       else
-               ret =3D umc_v12_convert_ma_to_pa(ras_core,
-                               addr_in, addr_out, nps);
-
-       return ret;
-}
-
 static int convert_bank_to_nps_addr(struct ras_core_context *ras_core,
                        struct ras_bank_ecc *bank, struct umc_phy_addr *pa_=
addr, uint32_t nps)  { @@ -392,10 +365,10 @@ static int convert_bank_to_nps=
_addr(struct ras_core_context *ras_core,
        addr_in.node_inst =3D ACA_IPID_2_DIE_ID(bank->ipid);
        addr_in.socket_id =3D ACA_IPID_2_SOCKET_ID(bank->ipid);

-       ret =3D convert_ma_to_pa(ras_core, &addr_in, &addr_out, nps);
+       ret =3D ras_umc_ma2pa(ras_core, &addr_in, &addr_out, nps);
        if (!ret) {
                pa_addr->pa =3D
-                       convert_nps_pa_to_row_pa(ras_core, addr_out.pa, nps=
, false);
+                       umc_v12_0_nps_pa_to_row_pa(ras_core, addr_out.pa, n=
ps, false);
                pa_addr->channel_idx =3D addr_out.channel_idx;
                pa_addr->bank =3D addr_out.bank;
        }
@@ -429,68 +402,6 @@ static int umc_v12_0_bank_to_eeprom_record(struct ras_=
core_context *ras_core,
        return 0;
 }

-static int convert_eeprom_record_to_nps_addr(struct ras_core_context *ras_=
core,
-                       struct eeprom_umc_record *record, uint64_t *pa, uin=
t32_t nps)
-{
-       struct device_system_info dev_info =3D {0};
-       struct umc_mca_addr addr_in;
-       struct umc_phy_addr addr_out;
-       int ret;
-
-       memset(&addr_in, 0, sizeof(addr_in));
-       memset(&addr_out, 0, sizeof(addr_out));
-
-       ras_core_get_device_system_info(ras_core, &dev_info);
-
-       addr_in.err_addr =3D record->address;
-       addr_in.ch_inst =3D record->mem_channel;
-       addr_in.umc_inst =3D record->mcumc_id;
-       addr_in.node_inst =3D UMC_INV_AID_NODE;
-       addr_in.socket_id =3D dev_info.socket_id;
-
-       ret =3D convert_ma_to_pa(ras_core, &addr_in, &addr_out, nps);
-       if (ret)
-               return ret;
-
-       *pa =3D convert_nps_pa_to_row_pa(ras_core, addr_out.pa, nps, false)=
;
-
-       return 0;
-}
-
-static int umc_v12_0_eeprom_record_to_nps_record(struct ras_core_context *=
ras_core,
-                               struct eeprom_umc_record *record, uint32_t =
nps)
-{
-       uint64_t ch_idx_v2, pa =3D 0;
-       uint32_t save_nps;
-       int ret =3D 0;
-
-       save_nps =3D EEPROM_RECORD_UMC_NPS_MODE(record);
-       /* eeprom v2 has no stored nps, always convert if the flag is set *=
/
-       ch_idx_v2 =3D record->retired_row_pfn & UMC_CHANNEL_IDX_V2;
-
-       if (save_nps || ch_idx_v2) {
-               if ((nps =3D=3D save_nps) && !ras_fw_eeprom_supported(ras_c=
ore)) {
-                       record->cur_nps_retired_row_pfn =3D
-                               EEPROM_RECORD_UMC_ADDR_PFN(record);
-               } else {
-                       ret =3D convert_eeprom_record_to_nps_addr(ras_core,
-                               record, &pa, nps);
-                       if (!ret)
-                               record->cur_nps_retired_row_pfn =3D RAS_ADD=
R_TO_PFN(pa);
-               }
-       } else {
-               /* old eeprom data format, the scope of channel index is
-                * limited to umc instance
-                */
-               /* TODO */
-               ret =3D -EOPNOTSUPP;
-       }
-
-       record->cur_nps =3D nps;
-
-       return ret;
-}
-
 static int umc_v12_0_eeprom_record_to_nps_pages(struct ras_core_context *r=
as_core,
                        struct eeprom_umc_record *record, uint32_t nps,
                        uint64_t *pfns, uint32_t num)
@@ -580,10 +491,11 @@ static void umc_v12_0_mca_ipid_parse(struct ras_core_=
context *ras_core, uint64_t

 const struct ras_umc_ip_func ras_umc_func_v12_0 =3D {
        .bank_to_eeprom_record =3D umc_v12_0_bank_to_eeprom_record,
-       .eeprom_record_to_nps_record =3D umc_v12_0_eeprom_record_to_nps_rec=
ord,
        .eeprom_record_to_nps_pages =3D umc_v12_0_eeprom_record_to_nps_page=
s,
        .bank_to_soc_pa =3D umc_12_0_bank_to_soc_pa,
        .soc_pa_to_bank =3D umc_12_0_soc_pa_to_bank,
        .mca_ipid_parse =3D umc_v12_0_mca_ipid_parse,
+       .ma2pa =3D umc_v12_ma2pa,
+       .nps_pa_to_row_pa =3D umc_v12_0_nps_pa_to_row_pa,
 };

--
2.34.1

