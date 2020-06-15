Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957EEC433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 20:02:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 512972071A
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 20:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MtyvvdhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512972071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E92166E4F3;
	Mon, 15 Jun 2020 20:02:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7441A6E4F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 20:02:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQR7w2rr1pVxL0z0Dzq2WbCd3kDljTYauFP01LrqAeVsvz211y74s+hOfRWtBJk2fXfuR45Qn9whzyh+cwNv2yfQaPQIxu2YX12rjFbKVcfSm1VWwRxwXe5310NoJIdFh0i6iYwGehSREZ7dMVf5LxVLKU2DGSkIeMj7/38XuIRBVVyFNnpMgu2RPlpAxnaV2tpMpM3F+TnC8Uuig0zT9XLrDle1PkGsMTUtbRArQWGVfpoDoD8l/m8i3qd8trhzOsDx/Rife9qgXYD1cv5xD29wC5yY27rf6ApIAUuwILWFiW5KD3YDDLFSxWVJhJ9Ycnjx4SDv8nCnAZ/S/UzvYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaXgy6bgkspCXDfetb7r2DQBxciLVWqbGK3bbVTwVRY=;
 b=eolUhpwJ4JdlMWMCaM1CT0RZaxO5CralJXh0Akz3OkzQpVum14mmo0CjFsENNdVDxvAMh0SkUD3ZKZvrqGrnL0otGF+3rI/cieculA42o+dmwmSdlB/z7Fbdoz/p41Uyak7q2SVS8OKy9EtwSkPvcdIDgNPirlda/yooiBoblZ7J8UCLI5vuBdOrVI0TrlgCaG+Yu8q+ssbbW4RG4JS6igWLJcF/swNZyvqxT/lK3sdL6T5JMioe2rsQf6cDXnzu2Jy5TkJIvrp/PfVdDMA3jnxdqqo2MQ1LWOy/d9VXeN1mmEBzlkzQJu01bKIrYVNAtkwqnzEpLQvhtTI7CBtjTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaXgy6bgkspCXDfetb7r2DQBxciLVWqbGK3bbVTwVRY=;
 b=MtyvvdhPa4lc1tKeGq18w+HK6PzXCNnQKkOsE4XukL/XfwDYdFAjr4H1iedcKLiD6iCDN1dX5N02NpTPluOVnDNodSXqQ2EJ4TrjBPur204Aa8AuGie+MD7qZxBs4VlPdPYioZSeWI42JSYqluMXG4M14UXEsSZVB9YeJfAJ+dA=
Received: from MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 by MWHPR12MB1696.namprd12.prod.outlook.com (2603:10b6:301:8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.25; Mon, 15 Jun
 2020 20:02:29 +0000
Received: from MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::f54a:55ae:1157:742]) by MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::f54a:55ae:1157:742%3]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 20:02:29 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amd/display: Update DCN3 bounding box
Thread-Topic: [PATCH 1/2] drm/amd/display: Update DCN3 bounding box
Thread-Index: AQHWQ0dy5W/J3FTDpE6YRoTQJ7S2W6jaGPXd
Date: Mon, 15 Jun 2020 20:02:28 +0000
Message-ID: <MW3PR12MB455421FAA2D7F8FBA4F4DBCBF99C0@MW3PR12MB4554.namprd12.prod.outlook.com>
References: <20200615190135.16562-1-Jerry.Zuo@amd.com>
In-Reply-To: <20200615190135.16562-1-Jerry.Zuo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-06-15T20:02:31.427Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e0752f8f-2ac9-4e63-1423-08d811670840
x-ms-traffictypediagnostic: MWHPR12MB1696:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB169636C84F235D05681E0FDDF99C0@MWHPR12MB1696.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9ZzHXQ8e8slO745HTOIh9dS2zeWpDYusLOQ+R7/4Oh0lFTimR2LjCxMHmXzAekxtnW9Fa9tmpP8xW53/4TAqIOZ9IMHwkmboXKV85xLNKMPCaUVS1ApIcjLyeVgOwXV31Tfcb8r+ymCOqmFVXs4MUd2FWU8hOvQD+CQKphf1qlfJIj73s7CdB3I71I8d7TaR134x2HmtHP2pS4DX+7FC+l1425izEFbg2ci8cuRRhvIjiDZzb9DvW0MINCabaIwHZQsqyq4D3EOHV85voPHAUmh2UKeEGAb7vZjRNkq2skJ2Lcogmi26XzxpyHr8qLnGvvUD266ABuI5VlBsZJfryQ6CVmvtRMHhg4NhcfSricw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4554.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(54906003)(91956017)(76116006)(316002)(66946007)(66446008)(64756008)(66556008)(66476007)(19627405001)(52536014)(33656002)(8676002)(7696005)(86362001)(110136005)(5660300002)(9686003)(55016002)(71200400001)(45080400002)(26005)(2906002)(478600001)(6506007)(53546011)(186003)(8936002)(83380400001)(4326008)(966005)(15650500001)(166002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: YM2GqnzsJsvwx66A9kltpX/aF31jIpVGTsS3fg9rkGAGkaES7TZTs523wK9Yv5scWoi2i6uOf0rxRN4x7teKkV/zfknhtiBbIaa4VDe5dHUnN4eeZx8uaEq5DIaRcd10Z9wXd20RG3HgehDZy2ngihQBwxHBKlj76FUdeLGvPZ1/axNr3xDWNfwtFtawIQmi4ysuIyTWgkhYezhOrBCT9WmcIrGNbOkEUxZX0lsWtE2ETKj7DO+5XBhDtUAHUmVli3ZZOrMsm09CTc6Ux3ZaRp4/zRi2zC51HMTzk8qQlcShvSiTkphGnrrgnL50oVS1N7SFGW4rZsJEnA0/aVdpenZhK+iPp7KiPecUulr+umhrccCPFm1PkUKTYBwn75oXY1IdAsECHdB7BG+o7eyzx3qaUkC6EIjRP+F8pQ4xJcHLELnlDEbgP0gQEZgglJ+ri1pl5edgd9SMu2TTFfLpWkiJeejKeM0wjt7bMw6SCKAGjV5HRDWCcslMvOvjS53i
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0752f8f-2ac9-4e63-1423-08d811670840
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 20:02:28.8933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5b98NeBu9TbKSFjcTzLC/a+tYrCTuUVI++BGP6ORVtofsEEA9eCENGrWJgAufHMa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1696
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>, "Lee, Alvin" <Alvin.Lee2@amd.com>
Content-Type: multipart/mixed; boundary="===============1685504818=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1685504818==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB455421FAA2D7F8FBA4F4DBCBF99C0MW3PR12MB4554namp_"

--_000_MW3PR12MB455421FAA2D7F8FBA4F4DBCBF99C0MW3PR12MB4554namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Series is

Reviewed-by: Bhawanpreet.Lakha<Bhawanpreet.Lakha.amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Jerry (F=
angzhi) Zuo <Jerry.Zuo@amd.com>
Sent: June 15, 2020 3:01 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zuo, Jerry <Jerry.Zuo@a=
md.com>; Wentland, Harry <Harry.Wentland@amd.com>; Kazlauskas, Nicholas <Ni=
cholas.Kazlauskas@amd.com>; Lee, Alvin <Alvin.Lee2@amd.com>
Subject: [PATCH 1/2] drm/amd/display: Update DCN3 bounding box

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
We want to update the bounding box to have more granular control of the
DCFCLK.

[How]
Setup DCFCLK to use STA values and also optimal values based on
UCLK.

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 114 ++++++++++++++++--
 1 file changed, 102 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 654fdbbff86b..821bde9a376e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2237,9 +2237,41 @@ bool dcn30_validate_bandwidth(struct dc *dc, struct =
dc_state *context,
         return out;
 }

+static void get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
+                                                       unsigned int *optim=
al_dcfclk,
+                                                       unsigned int *optim=
al_fclk)
+{
+       double bw_from_dram, bw_from_dram1, bw_from_dram2;
+
+       bw_from_dram1 =3D uclk_mts * dcn3_0_soc.num_chans *
+                       dcn3_0_soc.dram_channel_width_bytes * (dcn3_0_soc.m=
ax_avg_dram_bw_use_normal_percent / 100);
+       bw_from_dram2 =3D uclk_mts * dcn3_0_soc.num_chans *
+                       dcn3_0_soc.dram_channel_width_bytes * (dcn3_0_soc.m=
ax_avg_sdp_bw_use_normal_percent / 100);
+
+       bw_from_dram =3D (bw_from_dram1 < bw_from_dram2) ? bw_from_dram1 : =
bw_from_dram2;
+
+       if (optimal_fclk)
+               *optimal_fclk =3D bw_from_dram /
+               (dcn3_0_soc.fabric_datapath_to_dcn_data_return_bytes * (dcn=
3_0_soc.max_avg_sdp_bw_use_normal_percent / 100));
+
+       if (optimal_dcfclk)
+               *optimal_dcfclk =3D  bw_from_dram /
+               (dcn3_0_soc.return_bus_width_bytes * (dcn3_0_soc.max_avg_sd=
p_bw_use_normal_percent / 100));
+}
+
 static void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_para=
ms *bw_params)
 {
-       unsigned int i;
+       unsigned int i, j;
+       unsigned int num_states =3D 0;
+
+       unsigned int dcfclk_mhz[DC__VOLTAGE_STATES] =3D {0};
+       unsigned int dram_speed_mts[DC__VOLTAGE_STATES] =3D {0};
+       unsigned int optimal_uclk_for_dcfclk_sta_targets[DC__VOLTAGE_STATES=
] =3D {0};
+       unsigned int optimal_dcfclk_for_uclk[DC__VOLTAGE_STATES] =3D {0};
+
+       unsigned int dcfclk_sta_targets[DC__VOLTAGE_STATES] =3D {694, 875, =
1000, 1200};
+       unsigned int num_dcfclk_sta_targets =3D 4;
+       unsigned int num_uclk_states;

         if (dc->ctx->dc_bios->vram_info.num_chans)
                 dcn3_0_soc.num_chans =3D dc->ctx->dc_bios->vram_info.num_c=
hans;
@@ -2250,13 +2282,78 @@ static void dcn30_update_bw_bounding_box(struct dc =
*dc, struct clk_bw_params *bw
         dcn3_0_soc.dispclk_dppclk_vco_speed_mhz =3D dc->clk_mgr->dentist_v=
co_freq_khz / 1000.0;
         dc->dml.soc.dispclk_dppclk_vco_speed_mhz =3D dc->clk_mgr->dentist_=
vco_freq_khz / 1000.0;

-       /* UCLK first, it determines number of states */
         if (bw_params->clk_table.entries[0].memclk_mhz) {
-               dcn3_0_soc.num_states =3D bw_params->clk_table.num_entries;
+
+               if (bw_params->clk_table.entries[1].dcfclk_mhz > dcfclk_sta=
_targets[num_dcfclk_sta_targets-1]) {
+                       // If max DCFCLK is greater than the max DCFCLK STA=
 target, insert into the DCFCLK STA target array
+                       dcfclk_sta_targets[num_dcfclk_sta_targets] =3D bw_p=
arams->clk_table.entries[1].dcfclk_mhz;
+                       num_dcfclk_sta_targets++;
+               } else if (bw_params->clk_table.entries[1].dcfclk_mhz < dcf=
clk_sta_targets[num_dcfclk_sta_targets-1]) {
+                       // If max DCFCLK is less than the max DCFCLK STA ta=
rget, cap values and remove duplicates
+                       for (i =3D 0; i < num_dcfclk_sta_targets; i++) {
+                               if (dcfclk_sta_targets[i] > bw_params->clk_=
table.entries[1].dcfclk_mhz) {
+                                       dcfclk_sta_targets[i] =3D bw_params=
->clk_table.entries[1].dcfclk_mhz;
+                                       break;
+                               }
+                       }
+                       // Update size of array since we "removed" duplicat=
es
+                       num_dcfclk_sta_targets =3D i + 1;
+               }
+
+               num_uclk_states =3D bw_params->clk_table.num_entries;
+
+               // Calculate optimal dcfclk for each uclk
+               for (i =3D 0; i < num_uclk_states; i++) {
+                       get_optimal_dcfclk_fclk_for_uclk(bw_params->clk_tab=
le.entries[i].memclk_mhz * 16,
+                                       &optimal_dcfclk_for_uclk[i], NULL);
+                       if (optimal_dcfclk_for_uclk[i] < bw_params->clk_tab=
le.entries[0].dcfclk_mhz) {
+                               optimal_dcfclk_for_uclk[i] =3D bw_params->c=
lk_table.entries[0].dcfclk_mhz;
+                       }
+               }
+
+               // Calculate optimal uclk for each dcfclk sta target
+               for (i =3D 0; i < num_dcfclk_sta_targets; i++) {
+                       for (j =3D 0; j < num_uclk_states; j++) {
+                               if (dcfclk_sta_targets[i] < optimal_dcfclk_=
for_uclk[j]) {
+                                       optimal_uclk_for_dcfclk_sta_targets=
[i] =3D
+                                                       bw_params->clk_tabl=
e.entries[j].memclk_mhz * 16;
+                                       break;
+                               }
+                       }
+               }
+
+               i =3D 0;
+               j =3D 0;
+               // create the final dcfclk and uclk table
+               while (i < num_dcfclk_sta_targets && j < num_uclk_states &&=
 num_states < DC__VOLTAGE_STATES) {
+                       if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk=
[j] && i < num_dcfclk_sta_targets) {
+                               dcfclk_mhz[num_states] =3D dcfclk_sta_targe=
ts[i];
+                               dram_speed_mts[num_states++] =3D optimal_uc=
lk_for_dcfclk_sta_targets[i++];
+                       } else {
+                               if (j < num_uclk_states && optimal_dcfclk_f=
or_uclk[j] <=3D bw_params->clk_table.entries[1].dcfclk_mhz) {
+                                       dcfclk_mhz[num_states] =3D optimal_=
dcfclk_for_uclk[j];
+                                       dram_speed_mts[num_states++] =3D bw=
_params->clk_table.entries[j++].memclk_mhz * 16;
+                               } else {
+                                       j =3D num_uclk_states;
+                               }
+                       }
+               }
+
+               while (i < num_dcfclk_sta_targets && num_states < DC__VOLTA=
GE_STATES) {
+                       dcfclk_mhz[num_states] =3D dcfclk_sta_targets[i];
+                       dram_speed_mts[num_states++] =3D optimal_uclk_for_d=
cfclk_sta_targets[i++];
+               }
+
+               while (j < num_uclk_states && num_states < DC__VOLTAGE_STAT=
ES &&
+                               optimal_dcfclk_for_uclk[j] <=3D bw_params->=
clk_table.entries[1].dcfclk_mhz) {
+                       dcfclk_mhz[num_states] =3D optimal_dcfclk_for_uclk[=
j];
+                       dram_speed_mts[num_states++] =3D bw_params->clk_tab=
le.entries[j++].memclk_mhz * 16;
+               }

                 for (i =3D 0; i < dcn3_0_soc.num_states; i++) {
-                       dcn3_0_soc.clock_limits[i].state =3D i;
-                       dcn3_0_soc.clock_limits[i].dram_speed_mts =3D bw_pa=
rams->clk_table.entries[i].memclk_mhz * 16;
+                       dcn3_0_soc.clock_limits[i].dcfclk_mhz =3D dcfclk_mh=
z[i];
+                       dcn3_0_soc.clock_limits[i].fabricclk_mhz =3D dcfclk=
_mhz[i];
+                       dcn3_0_soc.clock_limits[i].dram_speed_mts =3D dram_=
speed_mts[i];
                 }
         }

@@ -2265,12 +2362,6 @@ static void dcn30_update_bw_bounding_box(struct dc *=
dc, struct clk_bw_params *bw
                 /* Some clocks can come from bw_params, if so fill from bw=
_params[1], otherwise fill from dcn3_0_soc[1] */
                 /* Temporarily ignore bw_params values */

-               /* DCFCLK */
-               /*if (bw_params->clk_table.entries[0].dcfclk_mhz)
-                       dcn3_0_soc.clock_limits[i].dcfclk_mhz =3D bw_params=
->clk_table.entries[1].dcfclk_mhz;
-               else*/
-                       dcn3_0_soc.clock_limits[i].dcfclk_mhz =3D dcn3_0_so=
c.clock_limits[1].dcfclk_mhz;
-
                 /* DTBCLK */
                 /*if (bw_params->clk_table.entries[0].dtbclk_mhz)
                         dcn3_0_soc.clock_limits[i].dtbclk_mhz =3D bw_param=
s->clk_table.entries[1].dtbclk_mhz;
@@ -2297,7 +2388,6 @@ static void dcn30_update_bw_bounding_box(struct dc *d=
c, struct clk_bw_params *bw

                 /* These clocks cannot come from bw_params, always fill fr=
om dcn3_0_soc[1] */
                 /* FCLK, PHYCLK_D18, SOCCLK, DSCCLK */
-               dcn3_0_soc.clock_limits[i].fabricclk_mhz =3D dcn3_0_soc.clo=
ck_limits[1].fabricclk_mhz;
                 dcn3_0_soc.clock_limits[i].phyclk_d18_mhz =3D dcn3_0_soc.c=
lock_limits[1].phyclk_d18_mhz;
                 dcn3_0_soc.clock_limits[i].socclk_mhz =3D dcn3_0_soc.clock=
_limits[1].socclk_mhz;
                 dcn3_0_soc.clock_limits[i].dscclk_mhz =3D dcn3_0_soc.clock=
_limits[1].dscclk_mhz;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cbhawanpr=
eet.lakha%40amd.com%7Cdea848b9b4c4455dc64008d8115e9215%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637278445192363126&amp;sdata=3DmMeh3qENOfOBexb5EtA=
R3sQJ6GZHkEzlQIF97DVI9bI%3D&amp;reserved=3D0

--_000_MW3PR12MB455421FAA2D7F8FBA4F4DBCBF99C0MW3PR12MB4554namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
Series is<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt">Reviewed-by: </span></font>=
Bhawanpreet.Lakha&lt;Bhawanpreet.Lakha.amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Jerry (Fangzhi) Zuo &lt;Jerry=
.Zuo@amd.com&gt;<br>
<b>Sent:</b> June 15, 2020 3:01 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zuo, Jerry=
 &lt;Jerry.Zuo@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt;;=
 Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas@amd.com&gt;; Lee, Alvin &lt;A=
lvin.Lee2@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amd/display: Update DCN3 bounding box</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Alvin Lee &lt;alvin.lee2@amd.com&gt;<br>
<br>
[Why]<br>
We want to update the bounding box to have more granular control of the<br>
DCFCLK.<br>
<br>
[How]<br>
Setup DCFCLK to use STA values and also optimal values based on<br>
UCLK.<br>
<br>
Signed-off-by: Alvin Lee &lt;alvin.lee2@amd.com&gt;<br>
Signed-off-by: Jerry (Fangzhi) Zuo &lt;Jerry.Zuo@amd.com&gt;<br>
Reviewed-by: Hersen Wu &lt;hersenxs.wu@amd.com&gt;<br>
---<br>
&nbsp;.../drm/amd/display/dc/dcn30/dcn30_resource.c | 114 &#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&nbsp;1 file changed, 102 insertions(&#43;), 12 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c<br>
index 654fdbbff86b..821bde9a376e 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c<br>
@@ -2237,9 &#43;2237,41 @@ bool dcn30_validate_bandwidth(struct dc *dc, str=
uct dc_state *context,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return out;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int *optimal_dcfclk,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int *optimal_fclk)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double bw_from_dram, bw_from_dram=
1, bw_from_dram2;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_from_dram1 =3D uclk_mts * dcn3=
_0_soc.num_chans *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_0_soc.d=
ram_channel_width_bytes * (dcn3_0_soc.max_avg_dram_bw_use_normal_percent / =
100);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_from_dram2 =3D uclk_mts * dcn3=
_0_soc.num_chans *<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_0_soc.d=
ram_channel_width_bytes * (dcn3_0_soc.max_avg_sdp_bw_use_normal_percent / 1=
00);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_from_dram =3D (bw_from_dram1 &=
lt; bw_from_dram2) ? bw_from_dram1 : bw_from_dram2;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (optimal_fclk)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *optimal_fclk =3D bw_from_dram /<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; (dcn3_0_soc.fabric_datapath_to_dcn_data_return_bytes * (dcn3=
_0_soc.max_avg_sdp_bw_use_normal_percent / 100));<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (optimal_dcfclk)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *optimal_dcfclk =3D&nbsp; bw_from_dram /<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; (dcn3_0_soc.return_bus_width_bytes * (dcn3_0_soc.max_avg_sdp=
_bw_use_normal_percent / 100));<br>
&#43;}<br>
&#43;<br>
&nbsp;static void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw=
_params *bw_params)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i, j;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_states =3D 0;<br=
>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int dcfclk_mhz[DC__VOLTA=
GE_STATES] =3D {0};<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int dram_speed_mts[DC__V=
OLTAGE_STATES] =3D {0};<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int optimal_uclk_for_dcf=
clk_sta_targets[DC__VOLTAGE_STATES] =3D {0};<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int optimal_dcfclk_for_u=
clk[DC__VOLTAGE_STATES] =3D {0};<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int dcfclk_sta_targets[D=
C__VOLTAGE_STATES] =3D {694, 875, 1000, 1200};<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_dcfclk_sta_targe=
ts =3D 4;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_uclk_states;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;ctx-&gt;dc_bios=
-&gt;vram_info.num_chans)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dcn3_0_soc.num_chans =3D dc-&gt;ctx-&gt;dc_bios-&gt;v=
ram_info.num_chans;<br>
@@ -2250,13 &#43;2282,78 @@ static void dcn30_update_bw_bounding_box(struct=
 dc *dc, struct clk_bw_params *bw<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_0_soc.dispclk_dppclk_=
vco_speed_mhz =3D dc-&gt;clk_mgr-&gt;dentist_vco_freq_khz / 1000.0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;dml.soc.dispclk_dpp=
clk_vco_speed_mhz =3D dc-&gt;clk_mgr-&gt;dentist_vco_freq_khz / 1000.0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* UCLK first, it determines number o=
f states */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bw_params-&gt;clk_tabl=
e.entries[0].memclk_mhz) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn3_0_soc.num_states =3D bw_params-&gt;clk_table.num_entries;<b=
r>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (bw_params-&gt;clk_table.entries[1].dcfclk_mhz &gt; dcfcl=
k_sta_targets[num_dcfclk_sta_targets-1]) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // If max DC=
FCLK is greater than the max DCFCLK STA target, insert into the DCFCLK STA =
target array<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcfclk_sta_t=
argets[num_dcfclk_sta_targets] =3D bw_params-&gt;clk_table.entries[1].dcfcl=
k_mhz;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_dcfclk_s=
ta_targets&#43;&#43;;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; } else if (bw_params-&gt;clk_table.entries[1].dcfclk_mhz &lt=
; dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // If max DC=
FCLK is less than the max DCFCLK STA target, cap values and remove duplicat=
es<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0=
; i &lt; num_dcfclk_sta_targets; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dcfclk_sta_targets[i] &gt; bw_param=
s-&gt;clk_table.entries[1].dcfclk_mhz) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; dcfclk_sta_targets[i] =3D bw_params-&gt;clk_table.entries[1].dcfcl=
k_mhz;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Update si=
ze of array since we &quot;removed&quot; duplicates<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_dcfclk_s=
ta_targets =3D i &#43; 1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; num_uclk_states =3D bw_params-&gt;clk_table.num_entries;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; // Calculate optimal dcfclk for each uclk<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; for (i =3D 0; i &lt; num_uclk_states; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_optimal_=
dcfclk_fclk_for_uclk(bw_params-&gt;clk_table.entries[i].memclk_mhz * 16,<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; &amp;optimal_dcfclk_for_uclk[i], NULL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (optimal_=
dcfclk_for_uclk[i] &lt; bw_params-&gt;clk_table.entries[0].dcfclk_mhz) {<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; optimal_dcfclk_for_uclk[i] =3D bw_param=
s-&gt;clk_table.entries[0].dcfclk_mhz;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; // Calculate optimal uclk for each dcfclk sta target<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; for (i =3D 0; i &lt; num_dcfclk_sta_targets; i&#43;&#43;) {<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j =3D 0=
; j &lt; num_uclk_states; j&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dcfclk_sta_targets[i] &lt; optimal_=
dcfclk_for_uclk[j]) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; optimal_uclk_for_dcfclk_sta_targets[i] =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bw_params-&gt;clk_table.entries[j].memclk_mhz=
 * 16;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; i =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; j =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; // create the final dcfclk and uclk table<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; while (i &lt; num_dcfclk_sta_targets &amp;&amp; j &lt; num_u=
clk_states &amp;&amp; num_states &lt; DC__VOLTAGE_STATES) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dcfclk_s=
ta_targets[i] &lt; optimal_dcfclk_for_uclk[j] &amp;&amp; i &lt; num_dcfclk_=
sta_targets) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcfclk_mhz[num_states] =3D dcfclk_sta_t=
argets[i];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dram_speed_mts[num_states&#43;&#43;] =
=3D optimal_uclk_for_dcfclk_sta_targets[i&#43;&#43;];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (j &lt; num_uclk_states &amp;&amp; o=
ptimal_dcfclk_for_uclk[j] &lt;=3D bw_params-&gt;clk_table.entries[1].dcfclk=
_mhz) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; dcfclk_mhz[num_states] =3D optimal_dcfclk_for_uclk[j];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; dram_speed_mts[num_states&#43;&#43;] =3D bw_params-&gt;clk_table.e=
ntries[j&#43;&#43;].memclk_mhz * 16;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; j =3D num_uclk_states;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; while (i &lt; num_dcfclk_sta_targets &amp;&amp; num_states &=
lt; DC__VOLTAGE_STATES) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcfclk_mhz[n=
um_states] =3D dcfclk_sta_targets[i];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dram_speed_m=
ts[num_states&#43;&#43;] =3D optimal_uclk_for_dcfclk_sta_targets[i&#43;&#43=
;];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; while (j &lt; num_uclk_states &amp;&amp; num_states &lt; DC_=
_VOLTAGE_STATES &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; optimal_dcfclk_for_uclk[j] &lt;=3D bw_p=
arams-&gt;clk_table.entries[1].dcfclk_mhz) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcfclk_mhz[n=
um_states] =3D optimal_dcfclk_for_uclk[j];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dram_speed_m=
ts[num_states&#43;&#43;] =3D bw_params-&gt;clk_table.entries[j&#43;&#43;].m=
emclk_mhz * 16;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; dcn3_0_soc.num_states; i&#43;&#4=
3;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_0_soc.clock=
_limits[i].state =3D i;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_0_soc.clock=
_limits[i].dram_speed_mts =3D bw_params-&gt;clk_table.entries[i].memclk_mhz=
 * 16;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_0_soc.c=
lock_limits[i].dcfclk_mhz =3D dcfclk_mhz[i];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_0_soc.c=
lock_limits[i].fabricclk_mhz =3D dcfclk_mhz[i];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_0_soc.c=
lock_limits[i].dram_speed_mts =3D dram_speed_mts[i];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -2265,12 &#43;2362,6 @@ static void dcn30_update_bw_bounding_box(struct =
dc *dc, struct clk_bw_params *bw<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Some clocks can come from bw_params, if so fill fr=
om bw_params[1], otherwise fill from dcn3_0_soc[1] */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Temporarily ignore bw_params values */<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* DCFCLK */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /*if (bw_params-&gt;clk_table.entries[0].dcfclk_mhz)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_0_soc.clock=
_limits[i].dcfclk_mhz =3D bw_params-&gt;clk_table.entries[1].dcfclk_mhz;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_0_soc.clock=
_limits[i].dcfclk_mhz =3D dcn3_0_soc.clock_limits[1].dcfclk_mhz;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* DTBCLK */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /*if (bw_params-&gt;clk_table.entries[0].dtbclk_mhz)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn3_=
0_soc.clock_limits[i].dtbclk_mhz =3D bw_params-&gt;clk_table.entries[1].dtb=
clk_mhz;<br>
@@ -2297,7 &#43;2388,6 @@ static void dcn30_update_bw_bounding_box(struct d=
c *dc, struct clk_bw_params *bw<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* These clocks cannot come from bw_params, always fi=
ll from dcn3_0_soc[1] */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* FCLK, PHYCLK_D18, SOCCLK, DSCCLK */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dcn3_0_soc.clock_limits[i].fabricclk_mhz =3D dcn3_0_soc.clock_li=
mits[1].fabricclk_mhz;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dcn3_0_soc.clock_limits[i].phyclk_d18_mhz =3D dcn3_0_=
soc.clock_limits[1].phyclk_d18_mhz;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dcn3_0_soc.clock_limits[i].socclk_mhz =3D dcn3_0_soc.=
clock_limits[1].socclk_mhz;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dcn3_0_soc.clock_limits[i].dscclk_mhz =3D dcn3_0_soc.=
clock_limits[1].dscclk_mhz;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cbhawanpreet.lakha%40amd.com%7Cdea848b9b4c4455dc64008d8115e9215%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637278445192363126&amp;amp;sdata=3D=
mMeh3qENOfOBexb5EtAR3sQJ6GZHkEzlQIF97DVI9bI%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cbhawanpree=
t.lakha%40amd.com%7Cdea848b9b4c4455dc64008d8115e9215%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637278445192363126&amp;amp;sdata=3DmMeh3qENOfOBexb5E=
tAR3sQJ6GZHkEzlQIF97DVI9bI%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB455421FAA2D7F8FBA4F4DBCBF99C0MW3PR12MB4554namp_--

--===============1685504818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1685504818==--
