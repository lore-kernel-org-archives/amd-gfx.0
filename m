Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B23C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 01:30:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB352070B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 01:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lZjQ4/kv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB352070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 880D56E03E;
	Mon, 13 Jul 2020 01:30:54 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700082.outbound.protection.outlook.com [40.107.70.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 632FE6E03E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2020 01:30:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWvU9kHcHCAswJr6N+vC9MD5cuBRY/IVG8DQM/AiyrUbXX3PeZ5AXXVaiu4NX4rRDOM3jJ6H2U1eYVbgCwzorLzkQJaTbMzsZCwyp644K5V5JEGX9T8SHvorifW9qcDxQv8ZPSRvtxuMNd+7cwYGnB4K6dDMRDPGW2UwFBmbo6ufT0axvSE4UUzNieQonsqTBKfwIsa2xe1QwkLBYjvNugmy7VvKp/piXdUzmSYOZqL2807Cnpw294JvaOoE8S5XPDz01X5wb2qOFj4WL1hmEkBO0P2/o2kgsEqKoI9WOG1+u5Pafqj1a4zslr/EHAsf9lv5w1BOoLZ85FxavY0cew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MV3lTcYUrktWTab4UGhZbeesCCu6uF30hjSzoB8D+o=;
 b=PskR/NuLHFXgnE5EN8iTWH5DebXGjWPhjiBZPhAvyyX1VHZqp8LPON9boRiqoqSjflSJCnzFfl9bkXlYMaHo7mRv3PIO1VnkCKfcpaPjBKchbVUKFCmJb/elSHHiFek9YFOlXkHpTS2MNuMSw9YGkVA5r1/+/b5nD3wpY6S9VlFA4zDHIv3mIlQFeDHHoBK0SEIp0Ubri7H10xzcqNn/ta7yBBd5jg+aQpecihO8LgfcLEPQ49mFbW4OgCE5VVni7s1Hqq2OQha9cyJfPDTwCDCqCiDTqILMI3HxDKA9/87OjYa+TVYXSkxPoaND6byFPhOeSmSt5pglOkI3ZOUSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MV3lTcYUrktWTab4UGhZbeesCCu6uF30hjSzoB8D+o=;
 b=lZjQ4/kv/G7qGeHQI7Cj7xUemLkoEI7/HpD/75VWrJc94QKLt++QQKr4KyOLpSZGqH0J+mCyY2cc64NbaZ5SFvd4FdeyaB0zC9AFA5O9ZTpgzIwlEhPcvQgJiX9cfMStThA9uBVFxqPbbPgDNfCaTOZg619UBgp39tn+xKi1gMg=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM5PR1201MB0011.namprd12.prod.outlook.com (2603:10b6:3:e4::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Mon, 13 Jul 2020 01:30:46 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::2d85:c08d:4782:e3a]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::2d85:c08d:4782:e3a%7]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 01:30:46 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 06/10] drm/amd/display: fix dcn3 p_state_change_support
 validation
Thread-Topic: [PATCH 06/10] drm/amd/display: fix dcn3 p_state_change_support
 validation
Thread-Index: AQHWVvl6C7ygS3Apo063SY+bfS3oFakEu3eQ
Date: Mon, 13 Jul 2020 01:30:46 +0000
Message-ID: <DM5PR12MB2533B3103096549DAF5C4E35ED600@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20200710203325.1097188-1-Rodrigo.Siqueira@amd.com>
 <20200710203325.1097188-7-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20200710203325.1097188-7-Rodrigo.Siqueira@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-13T01:30:40Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=679e61c9-662a-4ecb-b513-5d3ba30d1f59;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f6264202-3bbe-4b27-ead0-08d826cc5ddd
x-ms-traffictypediagnostic: DM5PR1201MB0011:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB00112ECF299A442A86FFE6F1ED600@DM5PR1201MB0011.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: donHPjiZEYFcXsyxw/HDRYJO0nh1CfSFka3G2oN2btfRH0ae/+3/kAmLW3FEj8A22vgWPy9nHv60KgKupILXe/6/F2duGSKfGG5uSf2CHHQqAEIKTHe3bI9h7jLjztD+tRgyrGKb7wpZqv0IAEJ/0wQ8tw4cM/2lhQdlXjk/gGnmp6vgb3q1uxVSj2vuEtMN5BEjuahTfA8xBKVcpOO/zQ85TUV0hefX7uu5/mbF+B3Uo/+48fX3JHbOlLD2pNHlFfzwfpaLDkSzbAo4gPPf6TZpZCG2YYnFuHD7/TA00F5nlqQoWLyslDPHmvG8pD/tpjGfc/qGozUIUFMnvuvuDblpij18goyxRBWqgVTQ+x8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(33656002)(8676002)(66946007)(76116006)(66476007)(86362001)(9686003)(4326008)(71200400001)(66556008)(966005)(66446008)(64756008)(55016002)(5660300002)(186003)(53546011)(478600001)(6506007)(7696005)(8936002)(52536014)(45080400002)(316002)(26005)(54906003)(110136005)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: h7OkQF45wUIImw4AFV+edcWxT54NXyhGP8prJJqoyHRt8Jn7H9iN3ryK+JzzxWRADmlT2JGb0Hz+04h/lzQiYxUYFFAUilO0aeIbZ3zLi4mUlntsRXprwVbXEB3ByfHPOjGnQyGSTi4fh3aKjYDk4zz8Uilmuqk7A7AWeggKAlUwa/L5qrv7k1s2SQhb24MKr2sK339dNI0JrgkvlT+rdF5Po8rKBrxV62cpiUx+dsM7k6JbxOiG1/oKA36D+SoEIXgw/SC7sWHZpFwYl+BnHRCvpk8A5ggQ9EN/n2OtdBljokLm0zNkCy6TtZu72C6mwqKFwtn2ZZxXyUHnFnNM5GgjouDvxX349hI/2ET91DJw/YjLff5h6GHTdfCKXmBuzqyOEet0s2ABzeKjEx7YLnCxwSBRHvh2u/jD7Ynt4eo1k2FyaXokoF3VFsPRVHgwvkY48DmoTvZ8kv4IJ1znSVVuoC3W+62ineRN66C/oCcSBZi6pLnwpOwJgUYhPam0
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6264202-3bbe-4b27-ead0-08d826cc5ddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 01:30:46.1244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wpg70h3yLd8ppBix/UBilyN6KuHjR4Kyao2ChEM+cR7fD/YLR+zIoEO2Leu0OyVq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0011
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
Cc: "Brol, Eryk" <Eryk.Brol@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha, 
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Laktyushkin,
 Dmytro" <Dmytro.Laktyushkin@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Wentland, 
 Harry" <Harry.Wentland@amd.com>, "Lee, Alvin" <Alvin.Lee2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Rodrigo Siqueira
Sent: Saturday, July 11, 2020 4:33 AM
To: amd-gfx@lists.freedesktop.org
Cc: Laktyushkin, Dmytro <Dmytro.Laktyushkin@amd.com>; Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Lee, Alvin <Alvin.Lee2@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Subject: [PATCH 06/10] drm/amd/display: fix dcn3 p_state_change_support validation

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Our validation is a known mess with actual validation mixed with topology configuration. This change makes sure topolgical validation is completed before any topology changes are made so we do not run into issues where we merge and split a pipe over the course of a single call.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 46 ++++++++++++++++---
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index d7ba895de765..653a571e366d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1870,12 +1870,14 @@ static bool dcn30_split_stream_for_mpc_or_odm(
 
 	return true;
 }
-static bool dcn30_fast_validate_bw(
+
+static bool dcn30_internal_validate_bw(
 		struct dc *dc,
 		struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
 		int *pipe_cnt_out,
-		int *vlevel_out)
+		int *vlevel_out,
+		bool fast_validate)
 {
 	bool out = false;
 	bool repopulate_pipes = false;
@@ -1898,7 +1900,38 @@ static bool dcn30_fast_validate_bw(
 
 	dml_log_pipe_params(&context->bw_ctx.dml, pipes, pipe_cnt);
 
-	vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
+	if (!fast_validate) {
+		/*
+		 * DML favors voltage over p-state, but we're more interested in
+		 * supporting p-state over voltage. We can't support p-state in
+		 * prefetch mode > 0 so try capping the prefetch mode to start.
+		 */
+		context->bw_ctx.dml.soc.allow_dram_self_refresh_or_dram_clock_change_in_vblank =
+			dm_allow_self_refresh_and_mclk_switch;
+		vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
+		/* This may adjust vlevel and maxMpcComb */
+		if (vlevel < context->bw_ctx.dml.soc.num_states)
+			vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
+	}
+	if (fast_validate || vlevel == context->bw_ctx.dml.soc.num_states ||
+			vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported) {
+		/*
+		 * If mode is unsupported or there's still no p-state support then
+		 * fall back to favoring voltage.
+		 *
+		 * We don't actually support prefetch mode 2, so require that we
+		 * at least support prefetch mode 1.
+		 */
+		context->bw_ctx.dml.soc.allow_dram_self_refresh_or_dram_clock_change_in_vblank =
+			dm_allow_self_refresh;
+
+		vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
+		if (vlevel < context->bw_ctx.dml.soc.num_states) {
+			memset(split, 0, sizeof(split));
+			memset(merge, 0, sizeof(merge));

[Dennis] It seems that the above code is wrong. Should they be the following:
	memset(split, 0, sizeof(*split));
	memset(merge, 0, sizeof(*merge));


+			vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
+		}
+	}
 
 	dml_log_mode_support_params(&context->bw_ctx.dml);
 
@@ -1938,8 +1971,6 @@ static bool dcn30_fast_validate_bw(
 		pipe_idx++;
 	}
 
-	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
-
 	/* merge pipes if necessary */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i]; @@ -2187,7 +2218,8 @@ static void dcn30_calculate_wm(
 	}
 }
 
-bool dcn30_validate_bandwidth(struct dc *dc, struct dc_state *context,
+bool dcn30_validate_bandwidth(struct dc *dc,
+		struct dc_state *context,
 		bool fast_validate)
 {
 	bool out = false;
@@ -2201,7 +2233,7 @@ bool dcn30_validate_bandwidth(struct dc *dc, struct dc_state *context,
 
 	BW_VAL_TRACE_COUNT();
 
-	out = dcn30_fast_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel);
+	out = dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, 
+&vlevel, fast_validate);
 
 	if (pipe_cnt == 0)
 		goto validate_out;
--
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CDennis.Li%40amd.com%7Cd29b9f7db74c45f9e1de08d825109bdf%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637300100558483702&amp;sdata=6aapNEnuw0JjplCw7Y7nttR8LYD7F8rjISoersjlIgY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
