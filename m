Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEA5C388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 22:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B246424171
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 22:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RzGHSryD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B246424171
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D643F6E5A4;
	Wed, 28 Oct 2020 22:14:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B243B6E5A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 22:14:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3nyems/5TYI0oGSb9wOs1dTbU+IJpf17JwT0N7+RuXCDM7gKXVYxwI3MVGx8dAl8+Xbe/qlv0BRvzH/zXs+gv//3qD6Xs6Sc7K5KZTNv949ffhLKZl6KzXD95EVy+G3DJEn11dxwCcQtznp5EU/puaqM9oJVP2lMYK/YWgGEw19vww+hou+nLjIFvH+ccIzddS2VdSfBp9W4sAU6N1pdXh+QiXz+dSuZI9yK1Qt50EDDgn3+cAPGY5rAe02ePaQ9u1NsWsOKfMnfzqS0Nv/kXjbuSLENGdfFjGmtPAPFKXFvSorspqoW9QBUJSagh6bu0znjrj3Jgp/b5FvB6wQ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIyg3/yvhRKIlhF/fBkn78j5mHV+PVSVVMpkEkmsS80=;
 b=J6pQemGCKTGkmWoepp7cwkBj6gcdzpv6AEq1KZnearE3tgKnya8fUFTHqYFSSreCEyTo49fDRQ9CzPpXlhrYnk/rhyHePN57tiR6skynImOaluLeoxUIKPB3ccyj6OGyLcmVgrvStHHZVdsssA6SrzxegX63NQzfL73tPyK+/ZC29CafrxSOfauFyXGHu+pUss087nT3PBcXMaFvkGGjUMbbBzhqT55GHUjoTlg7aZllL2HVHxCEPPGxdEoxp/5mNTasDp+8EXTlkqaUlvoTj2kl/Npsjfl0YgpEHYLeLbIpw+kCrOumuMM1fM+Hkpj8qGVDc8zNqD0AlpG7h+J88w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIyg3/yvhRKIlhF/fBkn78j5mHV+PVSVVMpkEkmsS80=;
 b=RzGHSryDnuakr7kTbP7T57YQxfD77Y17ofvPqToUl9XiZoL72t8tS39uKscTJ3O1Y+UwrrcJhNLegDJAy8eZ+AR53KIktmGgzQK57coq7qUHXGdOiq7z0pm9ZNrIfldGonbRsDmuX0/1FOKazB8k7wJAtRC0UPycJF55CAS2rTo=
Received: from DM5PR12MB4679.namprd12.prod.outlook.com (2603:10b6:4:a2::37) by
 DM5PR1201MB0217.namprd12.prod.outlook.com (2603:10b6:4:54::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.26; Wed, 28 Oct 2020 22:14:49 +0000
Received: from DM5PR12MB4679.namprd12.prod.outlook.com
 ([fe80::19f0:288:6263:1019]) by DM5PR12MB4679.namprd12.prod.outlook.com
 ([fe80::19f0:288:6263:1019%2]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 22:14:49 +0000
From: "Cornij, Nikola" <Nikola.Cornij@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: allow 18 bit dp output on DCN3
Thread-Topic: [PATCH] drm/amd/display: allow 18 bit dp output on DCN3
Thread-Index: AQHWrXbMMsebmBR0nUSm5OYAcQWtCqmtkyFw
Date: Wed, 28 Oct 2020 22:14:49 +0000
Message-ID: <DM5PR12MB467903567B3EE902CB6691C3EE170@DM5PR12MB4679.namprd12.prod.outlook.com>
References: <20201028220735.153525-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20201028220735.153525-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Enabled=true;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SetDate=2020-10-28T22:14:43Z; 
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Method=Privileged;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Name=Non-Business;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ActionId=b89bf06c-986c-4ee9-a296-0000ba2bf261;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ContentBits=0
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-28T22:11:11Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 364d14e3-45f5-4fb1-b696-0000b17880c6
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_enabled: true
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_setdate: 2020-10-28T22:14:48Z
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_method: Privileged
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_name: Non-Business
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_actionid: f193a596-0b7e-4f72-bd7f-00002083a469
msip_label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 07752193-48cc-446e-2f63-08d87b8ee307
x-ms-traffictypediagnostic: DM5PR1201MB0217:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB02179B04C9453D7460FE00D2EE170@DM5PR1201MB0217.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GmW2FcJZXTGV1wnXHAiiCRJ3Of0Oxw7Eo3KzB70gK0EJbuiGBesvMnhZJ3lpXbga5Os6IpKcL69LMRahSt1y4vVHWdZAolrod8XQrpdT3t8dEDLeEF9lcgwV1jr5hC71GAjLgnT+CICGE+hzQC61NfHlhy10SKgF3J6kumJq0JX1yTRHD51iOKQDOUEj7KETBN/WwQsZMLnECOCDkdq8uSWD73pDm5ypU5NJSmVTm2okmUl8y9e4666GerRT3HYvjomQgWsiarNDqGFZ+M6KqMl9e5KkWs7A305DyuIvy6B5qN2q+pQolPuXySh6oIavrAjhr5BUzsQDgmQTd76rBg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4679.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(6506007)(186003)(53546011)(66556008)(64756008)(4326008)(8676002)(86362001)(66476007)(66446008)(66946007)(26005)(55016002)(52536014)(110136005)(9686003)(54906003)(7696005)(8936002)(76116006)(5660300002)(316002)(33656002)(71200400001)(478600001)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: yeEH26YGPq4HaiQfVBVy8y9NzEwhahKVwQc8+Mj4DJ6IgRbllq1KQpr/fopV+o95E+4b/ma+rMOBGyVJyQJMeqIudhE0lrrVTnkmazMGOLav7TvgxIr1HMJEDfJZs8+nAzHmyBkskTAl2ttXzDX2XTXd3Icn+uZHUW3VFnvlWpTC3nwnPK6QrEdTVuUUZe20FDbaCawtX7eHpp/aKy8fXl82dH30dNO1OILVCQNju6IhFbxR6el8+Bv7dHsZya97XwtCwTrol2YbDo8xvjQ+IJJIkq7MAd97Ay2OSbGjm10KvU4gBeCxg0FFRYJLeoQ3qn2YmldXChznkEoFaJQA2vkosmRWov90o7YKwxKQ+bWJvGD0yt5j8hgMPX03NnIh79YJHee8VD1s/a7iGSIWdTwXutsk5EczXvgOZHr39LdDL38LCXJKxc18fWisuVcOqGgkb0WRFTiFg1PeZOa7BMVMeDQhxylJAvqGjt+AAbbOCHWntrV28PqE5eADsUn+kq3EJa54bMbLVKze/kqZ6+6JSx7m4TXVlzdoqtVmYrjINllhq/3ujHwsvp4Uy29LXcGXAhKpcpKjORcqUrzyt2jkaAxGLp4KWJn7jvh1fvEhaM1DSisEKGmP93cXwbU2QyJSheqI6vPGnnPODKvBww==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4679.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07752193-48cc-446e-2f63-08d87b8ee307
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 22:14:49.5707 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kNDM7hcsgJT6KgCP6On18Q1MAQGmMdB39S/PDpsXh6fFd603S+JyOiKxTFhQupeO8WMXCjaO/gpVR/m0KW1Sew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0217
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
Cc: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Park,
 Chris" <Chris.Park@amd.com>, "Laktyushkin,
 Dmytro" <Dmytro.Laktyushkin@amd.com>, "Liu, Zhan" <Zhan.Liu@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Nikola Cornij <nikola.cornij@amd.com>

-----Original Message-----
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com> 
Sent: Wednesday, October 28, 2020 6:08 PM
To: amd-gfx@lists.freedesktop.org
Cc: Cornij, Nikola <Nikola.Cornij@amd.com>; Liu, Zhan <Zhan.Liu@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Laktyushkin, Dmytro <Dmytro.Laktyushkin@amd.com>; Park, Chris <Chris.Park@amd.com>
Subject: [PATCH] drm/amd/display: allow 18 bit dp output on DCN3

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

We need this to pass dp compliance.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Chris Park <Chris.Park@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c  | 14 --------------  .../amd/display/dc/dml/dcn30/display_mode_vba_30.c |  2 +-
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index d1ed2a99bf65..d65496917e93 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2020,20 +2020,6 @@ static bool dcn30_internal_validate_bw(
 
 	dml_log_mode_support_params(&context->bw_ctx.dml);
 
-	/* TODO: Need to check calculated vlevel why that fails validation of below resolutions */
-	if (context->res_ctx.pipe_ctx[0].stream != NULL) {
-		if (context->res_ctx.pipe_ctx[0].stream->timing.h_addressable == 640  && context->res_ctx.pipe_ctx[0].stream->timing.v_addressable == 480)
-			vlevel = 0;
-		if (context->res_ctx.pipe_ctx[0].stream->timing.h_addressable == 1280 && context->res_ctx.pipe_ctx[0].stream->timing.v_addressable == 800)
-			vlevel = 0;
-		if (context->res_ctx.pipe_ctx[0].stream->timing.h_addressable == 1280 && context->res_ctx.pipe_ctx[0].stream->timing.v_addressable == 768)
-			vlevel = 0;
-		if (context->res_ctx.pipe_ctx[0].stream->timing.h_addressable == 1280 && context->res_ctx.pipe_ctx[0].stream->timing.v_addressable == 1024)
-			vlevel = 0;
-		if (context->res_ctx.pipe_ctx[0].stream->timing.h_addressable == 2048 && context->res_ctx.pipe_ctx[0].stream->timing.v_addressable == 1536)
-			vlevel = 0;
-	}
-
 	if (vlevel == context->bw_ctx.dml.soc.num_states)
 		goto validate_fail;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 9e0ae18e71fa..0f668699809d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -3628,7 +3628,7 @@ static double TruncToValidBPP(
 			}
 		}
 	} else {
-		if (!((DSCEnable == false && (DesiredBPP == NonDSCBPP2 || DesiredBPP == NonDSCBPP1 || DesiredBPP == NonDSCBPP0)) ||
+		if (!((DSCEnable == false && (DesiredBPP == NonDSCBPP2 || DesiredBPP 
+== NonDSCBPP1 || DesiredBPP == NonDSCBPP0 || DesiredBPP == 18)) ||
 				(DSCEnable && DesiredBPP >= MinDSCBPP && DesiredBPP <= MaxDSCBPP))) {
 			return BPP_INVALID;
 		} else {
--
2.29.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
