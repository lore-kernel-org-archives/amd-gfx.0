Return-Path: <SRS0=HfWL=CX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8BBC433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 08:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03CCE206C9
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 08:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sIeDrnXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CCE206C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C133C6E3FC;
	Mon, 14 Sep 2020 08:25:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F1696E3FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2020 08:25:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVuCo09NbhMYIyp9NdvH43eR4ACPKPqtQWpHyqQrGtolZYH2EKa6CUGWrNzdc9IRB++Yg44JH+ZZGFmSTLHshygfwG20bz7i/xc/h6NQUZr9xjHET4WcsSCVTKV45Civ/IMtvclRqubD9Pz/5tCOwKJ3d4p1DwUSb5elteJxGvNIv0MNBaEQOCdOjtZs0JwLNmbuPMZDeoSZE/7eFtYk4jtB826rZf8o4sZBPeWLw3fj56+5dWnt4qV1aWIfYZoCnHOsOkiO8CBr0pX5f1dd7A/yBLJdm7WHLt96RRFYHzfoVcW9uwwOfcfUP6IEZPukj/dcX4oYc6hzspoqPJeziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvJkgDVt3mV1BF/gTfO+2UI4QA4/W7Mq+bcJSmO0n6U=;
 b=ZBHFqHOATBuMLa0PXS/NAS3m2TZDd58UkBOzcN4tDAAZfGmkSDZONpBaVGzfYObaJH+FGfCe+8WJSxcVKU7uoNraLnK17ttC1ZOET0LeAJFCP6/gkrEBmz2axx2Wvhr9j6dq6BILYmyWsVI3DepGcVQJRdnc0CC4ytCSq2l8krJeBbVOyUkj8SuYq1HqIaLLeP0oX8At9MVMJ4BKSEmTOZJ6qMmlWSdmBB2gv5sV3MyzAQaTp1VdV/B8paexDLZ1V8XBYmFADPlceTf9tQe8SpmouW1ypQ/kYj+Tr04/u7x+kB2zPSEGZ6AnNZPXlDLmMiLe263RYh3fG+cpDoG0xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvJkgDVt3mV1BF/gTfO+2UI4QA4/W7Mq+bcJSmO0n6U=;
 b=sIeDrnXOk9WkGOJXrNIR4VwntszvtCc89r85qX/4HXg9FbYrdXkZKDhkhYexsqIsRX4+vspP/OExBZUqaBHnAaz6TIs9cLMCyUFZfG24WaUEyyrCLqLR8WdkScGGQR7oIgL9Q1dbiPT/w0w5GtsY/XvW+73bjk73h6TX+MtC4ko=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1158.namprd12.prod.outlook.com (2603:10b6:903:40::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Mon, 14 Sep
 2020 08:25:46 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e9ab:dad0:9d7a:a0e3]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e9ab:dad0:9d7a:a0e3%3]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 08:25:46 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Cui, Flora" <Flora.Cui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: drop BOOLEAN define in display part
Thread-Topic: [PATCH] drm/amdgpu: drop BOOLEAN define in display part
Thread-Index: AQHWimGdjyWdXxHvi0acQeICRMw+valnzE2A
Date: Mon, 14 Sep 2020 08:25:46 +0000
Message-ID: <CY4PR12MB12872FF2BA00F94CAE619D17F1230@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200914063648.22500-1-flora.cui@amd.com>
In-Reply-To: <20200914063648.22500-1-flora.cui@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-14T08:25:01Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=b4c9f798-9b15-4620-9140-0000cdf79875;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-14T08:25:43Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 3a229e18-68d9-4d9e-93d2-0000c9578576
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7bba708b-dadf-4a56-e353-08d85887c7c1
x-ms-traffictypediagnostic: CY4PR12MB1158:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1158DEB0349364AA03AC7453F1230@CY4PR12MB1158.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vktHk0sDsgwT2rymj8LW1xQ8BV1Zk9Yp8ZcqgygsHnrJf/F9a66u8ptlQfKBnkImT8YydoHamaKLIaxrXfeKKeq6pXOewmIKIVzKWazsqHIlV9gHIxffG8cFsNb0QomcWB+tfw7PCmcBIb+ocga8z6s8Gji/DaqUrW/t2fAoIkP7WVlyIhnP157zLq49a5AUDNa7dRoWMmmM7ESnRCdyR1HiQigHUbMHZiKrraIymAjXaTk8ZhwtXBLNj3PyK8rnVScfUhdYjZ1HqbHu4vDDbeE6uOZgALaE3cmgdTCKyf55jGUQDYre1okZ6ZwWHSvzuSSvvUfBcLH1GAYkbJIX33FwJJBQGcDCDhCypTb8D5c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(110136005)(7696005)(4326008)(186003)(45080400002)(55016002)(52536014)(9686003)(5660300002)(478600001)(66446008)(64756008)(66556008)(66476007)(76116006)(66946007)(966005)(83380400001)(316002)(86362001)(33656002)(71200400001)(6506007)(8676002)(2906002)(53546011)(26005)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: i2X4LlsVZMVJH+6tFAtLxCfhYUinM9u70EP3TF1OhvywKo6pgFpS+CVjTH+64rv9f5TTVtUtSHKYYdQrBW71dq2qBGYgKw6+y/k064Uk1kMNmVv7rnpB1WnumNavbIFGYlrBVEGgBRolDDRyBe+PDF+03lI2zQzxMZmaQYlSNmaA2HTsUEvhpGkm0lmRgLfW1HlFGTyl0ctQa9EWn91BDRtwfnzjEdySC5kxqXOEWN36EWyAGmaQeyqEputW0KtAeSJE1oHo6EI9sM8TpqrHc/BlN1AuGyJXggU6kvfhbVrK0+I+Xlv55q5KLbWnLH/bQM6YodAJTPhyx/eY+Jsn1t3l72mpkef2p/RrPhG4d87kMhLekzstVAs+JsYaDgjeRch2PqmXk1TnFltCQewcgKQHG0i5CmC2+KgUHhs87hKMnN9//SQbEz/2mXLIKuV0rtZBf57iwLWTYN0Rr9pFDWs72djxv1DveK1AuOP/nIQFzVWUEZ8Jn74eofT7iW4a5jt5oVdppBrMCqcpF+TVk9Z5lJRdOAkSp8G+IKTFNaElc/2KFH9N7KlVyghV4XM6pGQ+NR4WfxT2pRtlJappacjh+MGZtOKyZmLHyCJvf0/UuCKVvUYr3b9EVCW/CH3lP/KNYJwccLHdA1sE0RU23A==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bba708b-dadf-4a56-e353-08d85887c7c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 08:25:46.7027 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 62OEdioesvEgDH6MhXM36H/hL6DVtvTKko7qZt7Eph4jYDtTcUt62P7tDMzMHfRSMljq8vZ68r+5AecQaJjDbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1158
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
Cc: "Cui, Flora" <Flora.Cui@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Flora Cui
Sent: Monday, September 14, 2020 2:37 PM
To: amd-gfx@lists.freedesktop.org
Cc: Cui, Flora <Flora.Cui@amd.com>
Subject: [PATCH] drm/amdgpu: drop BOOLEAN define in display part

use bool directly

Signed-off-by: Flora Cui <flora.cui@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dm_pp_smu.h               | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index c5f2216e59c4..6a28fdd50e05 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -810,7 +810,7 @@ pp_nv_set_hard_min_uclk_by_freq(struct pp_smu *pp, int mhz)  }
 
 static enum pp_smu_status pp_nv_set_pstate_handshake_support(
-	struct pp_smu *pp, BOOLEAN pstate_handshake_supported)
+	struct pp_smu *pp, bool pstate_handshake_supported)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context; diff --git a/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h b/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h
index ae608c329366..3586934df25f 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_pp_smu.h
@@ -30,8 +30,6 @@
  * interface to PPLIB/SMU to setup clocks and pstate requirements on SoC
  */
 
-typedef bool BOOLEAN;
-
 enum pp_smu_ver {
 	/*
 	 * PP_SMU_INTERFACE_X should be interpreted as the interface defined @@ -240,7 +238,7 @@ struct pp_smu_funcs_nv {
 	 * DC hardware
 	 */
 	enum pp_smu_status (*set_pstate_handshake_support)(struct pp_smu *pp,
-			BOOLEAN pstate_handshake_supported);
+			bool pstate_handshake_supported);
 };
 
 #define PP_SMU_NUM_SOCCLK_DPM_LEVELS  8
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cguchun.chen%40amd.com%7Cd81ec3c18004410be66408d858789afb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637356622910218361&amp;sdata=pnVn%2BaYYczysuFlEljvG93IZO0TsLnxvMv09F1YYV7w%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
