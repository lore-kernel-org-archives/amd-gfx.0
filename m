Return-Path: <SRS0=wil9=7Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287CFC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2020 23:51:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC1A8206DC
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2020 23:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="inZEepvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1A8206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9E396E388;
	Fri, 12 Jun 2020 23:51:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9844C6E388
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2020 23:51:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjvxCo1Q+qLJ0gIJ0N/2DHwWc7M82EKv2W6dXPTGRAJ212hTSuiKoPaNiAFp+KyU4vQYF509/XtoMDqkuTcOYjF/CKvBuRSbxfpuxfyFizAjL4Zh2BY+ppENgi5Eva81XTM/vXnEnZPjnCYYQ9L5+PUB4wtjtAc1HlKJBjYSpzXa4OxlPHNA73VcvmqvyXoiNaHamd+9oX4Un4a+7sK0ymzbO3KhBwlmoR7UuKTF8jdUSXKRtPup3ABlNTqWcWS0YcFOd5cY0IaL3LlrkJebTHqmBSDvUyVk2YQezv6gMxqOHJzixBSLiY1i2B0NWf05zWylSEccDmonaWHDxvk+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qr+VjuN4cXkd/9odwMLx2dte3PvUv7e78LPxT1BrQQ=;
 b=I3jQr3q6R83BSdQvdbhTSBhFs7Y9ATxRZBeY+qXlKUPI6J4vfbqRaRsn68S+bvVrm2iEXSoYKlIBSPICqgYMKkBPLqkETNkB6772H1N60e0ELRf1rcCtsTW31MHYZD8eHGDNs1q53MNX7gLbj3mXorKzzRTyHYAlwNdZLDySmIm/olghyik80H6eiq892FnAekmZ27NXZXvT7HZ3//ul8O7e3Ppq0nvEuiymZLV3SJVPLnca9tIEZ7lUdJqjnCdy2LEXaVhqItP+50i/x0EQQKojrytawuannw2DgNfciO1i0btZabtFkh/a9ENPm2iZJHyMBst9pTLVjd4PP8RO3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qr+VjuN4cXkd/9odwMLx2dte3PvUv7e78LPxT1BrQQ=;
 b=inZEepvSdEIw5ufJI/ENB4MLkNr7IQXBOxjd7JKwWFnKcvd6tGdoTsZvBxKMqF9JPVvCw6k4Yt0MBjG5CIxZtJ83zcx8C+/iabxF2VaTvKu49wqn0BO1f456l56wHO0NMNqissDG6CG2iq848R0bJl/cqNq7XQ0Sgvw3xRNOQUI=
Received: from DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17)
 by DM6PR12MB3626.namprd12.prod.outlook.com (2603:10b6:5:11f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.25; Fri, 12 Jun
 2020 23:51:46 +0000
Received: from DM6PR12MB4156.namprd12.prod.outlook.com
 ([fe80::53:8095:2cd:ef21]) by DM6PR12MB4156.namprd12.prod.outlook.com
 ([fe80::53:8095:2cd:ef21%7]) with mapi id 15.20.3088.023; Fri, 12 Jun 2020
 23:51:46 +0000
From: "Wu, Hersen" <hersenxs.wu@amd.com>
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Kazlauskas, Nicholas"
 <Nicholas.Kazlauskas@amd.com>
Subject: Re: [PATCH] drm/amd/display: Get num_chans from VBIOS table
Thread-Topic: [PATCH] drm/amd/display: Get num_chans from VBIOS table
Thread-Index: AQHWQRRImoofbKgbDE+WEvEI/b0wYKjVpqWH
Date: Fri, 12 Jun 2020 23:51:46 +0000
Message-ID: <DM6PR12MB41569A8F6298CDB5C5249F85FD810@DM6PR12MB4156.namprd12.prod.outlook.com>
References: <20200612235037.29143-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20200612235037.29143-1-Bhawanpreet.Lakha@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-12T23:51:45.861Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3c60:111:d920:fe89:456d:2cfe]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c2996cb-567b-48a2-c879-08d80f2b9108
x-ms-traffictypediagnostic: DM6PR12MB3626:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3626C356B8023FFF9A981F4CFD810@DM6PR12MB3626.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:167;
x-forefront-prvs: 0432A04947
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v8/5HTHr6kSlSjzor3nGIQE5DYpJUgcBb9qL/ucgNUESQ3ARF5bJqRa2nP27iDXMMj4xUgr1sb6PjjM8PyfQ696jVy3ln9V9tFEmSUYs2d99p5xBDHQj6D5qXirXfkqb2DBP+dpt8+mKizzULGIK2pjSubKSNeCa+M4qrHbYdKr8Ce9HgB80nQf/eElON3zd3JjVf1U1zkKHG+G8UkEYdUPzVXzt7cnOr6/UlH00oYpakY2gSp+NQs4EYBW/zxCBGCgDGTp/ullt5n4NZQ09tUAR4CWOIoR9Vwnbm5g7urcMARTfyxaDmrKstiL7jwfvm3WwwgktexKw8a8P6hawZg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(478600001)(6636002)(86362001)(33656002)(76116006)(2906002)(66946007)(64756008)(66556008)(7696005)(66446008)(66476007)(9686003)(52536014)(55016002)(83380400001)(71200400001)(316002)(53546011)(186003)(6506007)(19627405001)(8676002)(5660300002)(8936002)(4326008)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: cngBAYF2d3iiT6OCXmKuWQJIqSuMh6jvLdHctc3hu7sH0FpCNpCgabSMk3lX4EqaKXz/7i38T0MJEWTkYXtjfgq4FmPWCNxzNdlEDqGBnbdEiELTiIFZlF4Wialwvg1qXyLeDeTVONjD6qiaGHHL5pLN0mjAr7M178z6y0Tam2V75nFybuyag5ZNoGcqsRFwVW36cQoxGUfuyfrPBzds/aDgUEPkfhKFGIfQbnn2Zo0OwaKb2Frj8n6Jzm4UQLcVtH0b7HnAvFQI1wYI+/jQs2k+BIb1GxGlMBDjfJAO0La8Hf/GcIou8ZdFhZMZkLXTbMfbEtsYzmizKDxE/R/CqvJeqTo1LPSMQaH+Vn+9gMojFDHr4dQ2mcXLyx+3WMpPAZ5QpGGW6vfU04PGI0GOzovtxyxZXna5jQMwPo6w+QnigCHrezkkMB37Yr+94UVHy9/jyNxdfjyU3k4WPlcpc/sbWamAasmNXRqhqIrwtq2kkY6+/dZVTzoTVzGMDB7hBhOcFQgJ91NezWW6DVb2NrbNv3j4VC/Xw7YtB4UJ46DSybxq/zRFNK6s5sOozoB8
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2996cb-567b-48a2-c879-08d80f2b9108
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2020 23:51:46.3371 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UxnvGMnDI4u/mMxt5zYM/2iOS79CP+3rfXte974GqBTVkgyYOX9rCJEYXaPs2chXrgixTp+chBdaHkOtHGcJyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3626
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
Cc: "Lee, Alvin" <Alvin.Lee2@amd.com>
Content-Type: multipart/mixed; boundary="===============0868475209=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0868475209==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB41569A8F6298CDB5C5249F85FD810DM6PR12MB4156namp_"

--_000_DM6PR12MB41569A8F6298CDB5C5249F85FD810DM6PR12MB4156namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>


________________________________
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Sent: June 12, 2020 7:50 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Kazlauskas, Nicholas <Nicholas.Kazl=
auskas@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>
Cc: Lee, Alvin <Alvin.Lee2@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@=
amd.com>
Subject: [PATCH] drm/amd/display: Get num_chans from VBIOS table

From: Alvin Lee <alvin.lee2@amd.com>

Get the values from VBIOS table

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    | 98 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |  1 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  7 +-
 .../display/include/grph_object_ctrl_defs.h   |  5 +
 4 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/g=
pu/drm/amd/display/dc/bios/bios_parser2.c
index 9311fec1643c..b8684131151d 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -1378,6 +1378,63 @@ static struct atom_encoder_caps_record *get_encoder_=
cap_record(
         return NULL;
 }

+static enum bp_result get_vram_info_v23(
+       struct bios_parser *bp,
+       struct dc_vram_info *info)
+{
+       struct atom_vram_info_header_v2_3 *info_v23;
+       enum bp_result result =3D BP_RESULT_OK;
+
+       info_v23 =3D GET_IMAGE(struct atom_vram_info_header_v2_3,
+                                               DATA_TABLES(vram_info));
+
+       if (info_v23 =3D=3D NULL)
+               return BP_RESULT_BADBIOSTABLE;
+
+       info->num_chans =3D info_v23->vram_module[0].channel_num;
+       info->dram_channel_width_bytes =3D (1 << info_v23->vram_module[0].c=
hannel_width) / 8;
+
+       return result;
+}
+
+static enum bp_result get_vram_info_v24(
+       struct bios_parser *bp,
+       struct dc_vram_info *info)
+{
+       struct atom_vram_info_header_v2_4 *info_v24;
+       enum bp_result result =3D BP_RESULT_OK;
+
+       info_v24 =3D GET_IMAGE(struct atom_vram_info_header_v2_4,
+                                               DATA_TABLES(vram_info));
+
+       if (info_v24 =3D=3D NULL)
+               return BP_RESULT_BADBIOSTABLE;
+
+       info->num_chans =3D info_v24->vram_module[0].channel_num;
+       info->dram_channel_width_bytes =3D (1 << info_v24->vram_module[0].c=
hannel_width) / 8;
+
+       return result;
+}
+
+static enum bp_result get_vram_info_v25(
+       struct bios_parser *bp,
+       struct dc_vram_info *info)
+{
+       struct atom_vram_info_header_v2_5 *info_v25;
+       enum bp_result result =3D BP_RESULT_OK;
+
+       info_v25 =3D GET_IMAGE(struct atom_vram_info_header_v2_5,
+                                               DATA_TABLES(vram_info));
+
+       if (info_v25 =3D=3D NULL)
+               return BP_RESULT_BADBIOSTABLE;
+
+       info->num_chans =3D info_v25->vram_module[0].channel_num;
+       info->dram_channel_width_bytes =3D (1 << info_v25->vram_module[0].c=
hannel_width) / 8;
+
+       return result;
+}
+
 /*
  * get_integrated_info_v11
  *
@@ -1669,6 +1726,46 @@ static enum bp_result construct_integrated_info(
         return result;
 }

+static enum bp_result bios_parser_get_vram_info(
+               struct dc_bios *dcb,
+               struct dc_vram_info *info)
+{
+       struct bios_parser *bp =3D BP_FROM_DCB(dcb);
+       enum bp_result result =3D BP_RESULT_BADBIOSTABLE;
+       struct atom_common_table_header *header;
+       struct atom_data_revision revision;
+
+       if (info && DATA_TABLES(vram_info)) {
+               header =3D GET_IMAGE(struct atom_common_table_header,
+                                       DATA_TABLES(vram_info));
+
+               get_atom_data_table_revision(header, &revision);
+
+               switch (revision.major) {
+               case 2:
+                       switch (revision.minor) {
+                       case 3:
+                               result =3D get_vram_info_v23(bp, info);
+                               break;
+                       case 4:
+                               result =3D get_vram_info_v24(bp, info);
+                               break;
+                       case 5:
+                               result =3D get_vram_info_v25(bp, info);
+                               break;
+                       default:
+                               break;
+                       }
+                       break;
+
+               default:
+                       return result;
+               }
+
+       }
+       return result;
+}
+
 static struct integrated_info *bios_parser_create_integrated_info(
         struct dc_bios *dcb)
 {
@@ -2112,6 +2209,7 @@ static bool bios_parser2_construct(

         bp->base.integrated_info =3D bios_parser_create_integrated_info(&b=
p->base);
         bp->base.fw_info_valid =3D bios_parser_get_firmware_info(&bp->base=
, &bp->base.fw_info) =3D=3D BP_RESULT_OK;
+       bios_parser_get_vram_info(&bp->base, &bp->base.vram_info);

         return true;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/d=
rm/amd/display/dc/dc_bios_types.h
index 441768aa53ff..845a3054f21f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -153,6 +153,7 @@ struct dc_bios {
         struct integrated_info *integrated_info;
         struct dc_firmware_info fw_info;
         bool fw_info_valid;
+       struct dc_vram_info vram_info;
 };

 #endif /* DC_BIOS_TYPES_H */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 011f1454b8cb..654fdbbff86b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -195,7 +195,6 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_0_soc =3D {
         .max_avg_dram_bw_use_normal_percent =3D 40.0,
         .writeback_latency_us =3D 12.0,
         .max_request_size_bytes =3D 256,
-       .dram_channel_width_bytes =3D 2,
         .fabric_datapath_to_dcn_data_return_bytes =3D 64,
         .dcn_downspread_percent =3D 0.5,
         .downspread_percent =3D 0.38,
@@ -2242,6 +2241,12 @@ static void dcn30_update_bw_bounding_box(struct dc *=
dc, struct clk_bw_params *bw
 {
         unsigned int i;

+       if (dc->ctx->dc_bios->vram_info.num_chans)
+               dcn3_0_soc.num_chans =3D dc->ctx->dc_bios->vram_info.num_ch=
ans;
+
+       if (dc->ctx->dc_bios->vram_info.dram_channel_width_bytes)
+               dcn3_0_soc.dram_channel_width_bytes =3D dc->ctx->dc_bios->v=
ram_info.dram_channel_width_bytes;
+
         dcn3_0_soc.dispclk_dppclk_vco_speed_mhz =3D dc->clk_mgr->dentist_v=
co_freq_khz / 1000.0;
         dc->dml.soc.dispclk_dppclk_vco_speed_mhz =3D dc->clk_mgr->dentist_=
vco_freq_khz / 1000.0;

diff --git a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h b/=
drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
index d51de94e4bc3..7a06e3914c00 100644
--- a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
+++ b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
@@ -183,6 +183,11 @@ struct dc_firmware_info {

 };

+struct dc_vram_info {
+       unsigned int num_chans;
+       unsigned int dram_channel_width_bytes;
+};
+
 struct step_and_delay_info {
         uint32_t step;
         uint32_t delay;
--
2.17.1


--_000_DM6PR12MB41569A8F6298CDB5C5249F85FD810DM6PR12MB4156namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(32, 31, 30); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant">Reviewed-by:
 Hersen Wu &lt;hersenxs.wu@amd.com&gt;</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(32, 31, 30); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant"><br>
</span></div>
<div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Bhawanpreet Lakha &lt=
;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Sent:</b> June 12, 2020 7:50 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kazlauskas, Nich=
olas &lt;Nicholas.Kazlauskas@amd.com&gt;; Wu, Hersen &lt;hersenxs.wu@amd.co=
m&gt;<br>
<b>Cc:</b> Lee, Alvin &lt;Alvin.Lee2@amd.com&gt;; Lakha, Bhawanpreet &lt;Bh=
awanpreet.Lakha@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Get num_chans from VBIOS table</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">From: Alvin Lee &lt;alvin.lee2@amd.com&gt;<br>
<br>
Get the values from VBIOS table<br>
<br>
Signed-off-by: Alvin Lee &lt;alvin.lee2@amd.com&gt;<br>
Signed-off-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/display/dc/bios/bios_parser2.c&nbsp;&nbsp;&nbsp; | 98 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;<br>
&nbsp;.../gpu/drm/amd/display/dc/dc_bios_types.h&nbsp;&nbsp;&nbsp; |&nbsp; =
1 &#43;<br>
&nbsp;.../drm/amd/display/dc/dcn30/dcn30_resource.c |&nbsp; 7 &#43;-<br>
&nbsp;.../display/include/grph_object_ctrl_defs.h&nbsp;&nbsp; |&nbsp; 5 &#4=
3;<br>
&nbsp;4 files changed, 110 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/g=
pu/drm/amd/display/dc/bios/bios_parser2.c<br>
index 9311fec1643c..b8684131151d 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c<br>
@@ -1378,6 &#43;1378,63 @@ static struct atom_encoder_caps_record *get_enco=
der_cap_record(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static enum bp_result get_vram_info_v23(<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct bios_parser *bp,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_vram_info *info)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_vram_info_header_v2_3=
 *info_v23;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum bp_result result =3D BP_RESU=
LT_OK;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info_v23 =3D GET_IMAGE(struct ato=
m_vram_info_header_v2_3,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DATA_TABLES(vram_i=
nfo));<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (info_v23 =3D=3D NULL)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return BP_RESULT_BADBIOSTABLE;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;num_chans =3D info_v23-&=
gt;vram_module[0].channel_num;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;dram_channel_width_bytes=
 =3D (1 &lt;&lt; info_v23-&gt;vram_module[0].channel_width) / 8;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&#43;}<br>
&#43;<br>
&#43;static enum bp_result get_vram_info_v24(<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct bios_parser *bp,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_vram_info *info)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_vram_info_header_v2_4=
 *info_v24;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum bp_result result =3D BP_RESU=
LT_OK;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info_v24 =3D GET_IMAGE(struct ato=
m_vram_info_header_v2_4,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DATA_TABLES(vram_i=
nfo));<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (info_v24 =3D=3D NULL)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return BP_RESULT_BADBIOSTABLE;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;num_chans =3D info_v24-&=
gt;vram_module[0].channel_num;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;dram_channel_width_bytes=
 =3D (1 &lt;&lt; info_v24-&gt;vram_module[0].channel_width) / 8;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&#43;}<br>
&#43;<br>
&#43;static enum bp_result get_vram_info_v25(<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct bios_parser *bp,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_vram_info *info)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_vram_info_header_v2_5=
 *info_v25;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum bp_result result =3D BP_RESU=
LT_OK;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info_v25 =3D GET_IMAGE(struct ato=
m_vram_info_header_v2_5,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DATA_TABLES(vram_i=
nfo));<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (info_v25 =3D=3D NULL)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return BP_RESULT_BADBIOSTABLE;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;num_chans =3D info_v25-&=
gt;vram_module[0].channel_num;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;dram_channel_width_bytes=
 =3D (1 &lt;&lt; info_v25-&gt;vram_module[0].channel_width) / 8;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&#43;}<br>
&#43;<br>
&nbsp;/*<br>
&nbsp; * get_integrated_info_v11<br>
&nbsp; *<br>
@@ -1669,6 &#43;1726,46 @@ static enum bp_result construct_integrated_info(=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static enum bp_result bios_parser_get_vram_info(<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct dc_bios *dcb,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct dc_vram_info *info)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct bios_parser *bp =3D BP_FRO=
M_DCB(dcb);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum bp_result result =3D BP_RESU=
LT_BADBIOSTABLE;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_common_table_header *=
header;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_data_revision revisio=
n;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (info &amp;&amp; DATA_TABLES(v=
ram_info)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; header =3D GET_IMAGE(struct atom_common_table_header,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; DATA_TABLES(vram_info));<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; get_atom_data_table_revision(header, &amp;revision);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; switch (revision.major) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; case 2:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (revi=
sion.minor) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 3:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D get_vram_info_v23(bp, info);=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 4:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D get_vram_info_v24(bp, info);=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 5:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D get_vram_info_v25(bp, info);=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; default:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return resul=
t;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&#43;}<br>
&#43;<br>
&nbsp;static struct integrated_info *bios_parser_create_integrated_info(<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_bios *dcb)<br>
&nbsp;{<br>
@@ -2112,6 &#43;2209,7 @@ static bool bios_parser2_construct(<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp-&gt;base.integrated_inf=
o =3D bios_parser_create_integrated_info(&amp;bp-&gt;base);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp-&gt;base.fw_info_valid =
=3D bios_parser_get_firmware_info(&amp;bp-&gt;base, &amp;bp-&gt;base.fw_inf=
o) =3D=3D BP_RESULT_OK;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bios_parser_get_vram_info(&amp;bp=
-&gt;base, &amp;bp-&gt;base.vram_info);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/d=
rm/amd/display/dc/dc_bios_types.h<br>
index 441768aa53ff..845a3054f21f 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h<br>
@@ -153,6 &#43;153,7 @@ struct dc_bios {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct integrated_info *in=
tegrated_info;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_firmware_info fw=
_info;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool fw_info_valid;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_vram_info vram_info;<br=
>
&nbsp;};<br>
&nbsp;<br>
&nbsp;#endif /* DC_BIOS_TYPES_H */<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c<br>
index 011f1454b8cb..654fdbbff86b 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c<br>
@@ -195,7 &#43;195,6 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_0_soc =3D =
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .max_avg_dram_bw_use_norma=
l_percent =3D 40.0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .writeback_latency_us =3D =
12.0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .max_request_size_bytes =
=3D 256,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dram_channel_width_bytes =3D 2,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fabric_datapath_to_dcn_da=
ta_return_bytes =3D 64,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dcn_downspread_percent =
=3D 0.5,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .downspread_percent =3D 0.=
38,<br>
@@ -2242,6 &#43;2241,12 @@ static void dcn30_update_bw_bounding_box(struct =
dc *dc, struct clk_bw_params *bw<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;ctx-&gt;dc_bios-&gt;vr=
am_info.num_chans)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dcn3_0_soc.num_chans =3D dc-&gt;ctx-&gt;dc_bios-&gt;vram_inf=
o.num_chans;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;ctx-&gt;dc_bios-&gt;vr=
am_info.dram_channel_width_bytes)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dcn3_0_soc.dram_channel_width_bytes =3D dc-&gt;ctx-&gt;dc_bi=
os-&gt;vram_info.dram_channel_width_bytes;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_0_soc.dispclk_dppclk_=
vco_speed_mhz =3D dc-&gt;clk_mgr-&gt;dentist_vco_freq_khz / 1000.0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;dml.soc.dispclk_dpp=
clk_vco_speed_mhz =3D dc-&gt;clk_mgr-&gt;dentist_vco_freq_khz / 1000.0;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h b/=
drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h<br>
index d51de94e4bc3..7a06e3914c00 100644<br>
--- a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs=
.h<br>
@@ -183,6 &#43;183,11 @@ struct dc_firmware_info {<br>
&nbsp;<br>
&nbsp;};<br>
&nbsp;<br>
&#43;struct dc_vram_info {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_chans;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int dram_channel_width_b=
ytes;<br>
&#43;};<br>
&#43;<br>
&nbsp;struct step_and_delay_info {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t step;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t delay;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB41569A8F6298CDB5C5249F85FD810DM6PR12MB4156namp_--

--===============0868475209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0868475209==--
