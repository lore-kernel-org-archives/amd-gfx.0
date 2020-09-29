Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC9CC47427
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 21:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CDAF2076D
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 21:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ui5TP9MX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDAF2076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B441D6E02C;
	Tue, 29 Sep 2020 21:47:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D32D06E02C
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 21:47:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlETXiBHymEfnITwZ8BXvrCGnCcAEd438lwyYIsgPPIoj4oONi0ustsJYJo1ATDS1NK6/tHcNPhDRL1laS54pK+GgZJRDeIcqnIoJROaBEH/NoOLbTQfhiLUli3MTIHX18IDHP7miti46a3XsT3J+fl29gUviZ1e1KMWuNLBSv6qBYtuGZnkCYwiGFBVsN7mNW2Z6+a5ZPw1cPWb0nafQjytdNzqTP8QpsBQ+Y/dWfPxm89mbtDwEa1ZHzYyVgPDtAeNN5sVncnPF3HxjisbX8lUk6TNS+fc0PCLDeAmSsLnolNgTbp+T4whrREwN3n/MQNbAy9md7ZWXRgdWN+rUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kqHxJnG4Ncye2IPWJ5KHGvc8WTtw8xIJPotmEL6Z28=;
 b=jm0/RLJjUSkz4VziEnLN6+mI58V3G5mHVBJBz1xZiUdE8in07nBpF1wVDGUMMuwGW3Mfk6wWBn0jpQT3lFVWDmprKycdYBhBX8zRRFpx8ZJGGr0TGd7JweA3rE+eIgC36Exz6ChgOOO5nFiReHd48OvQ5vE0VnBcELSN6oBABChoEalVAOYx7jy845FvnXM+UF6GdUd9qutnVTcR6ul4afRsLokaUyGfSZyJSjpmE/bKxJJwJU88ghwkuaPx7cWY6IM7PXsVZ7LC5jnFwk3aMbJpPm6+oeMLp8biTKniuklbcsvvUXfera0xXPpfWIXmTr/ZjlaaRD/nQCIX5b9jQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kqHxJnG4Ncye2IPWJ5KHGvc8WTtw8xIJPotmEL6Z28=;
 b=ui5TP9MXjDBtNPhQo1g0FuGO7bX58yRec3Ag5EZ4ZZmw4yJyywrKRp3jJad23GvXkSqvwL3zMyDPsVMRpP6hQGaefIyuD1xnkdeWNdj8NETZKfqCE0os3vrTOK7vymg4E5NKI/Vou75kzr64cC6JNNHNiyDdXZ3DvrkhTwH2vRU=
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM5PR1201MB0011.namprd12.prod.outlook.com (2603:10b6:3:e4::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.25; Tue, 29 Sep 2020 21:47:11 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::479:1e93:7ee2:839]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::479:1e93:7ee2:839%3]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 21:47:11 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/4] drm/amd/amdgpu: Prepare implementation to support
 reporting of CU usage
Thread-Topic: [PATCH 2/4] drm/amd/amdgpu: Prepare implementation to support
 reporting of CU usage
Thread-Index: AQHWlop2q3L7Tp8kUUm1pmso/hy8Y6mAJshA
Date: Tue, 29 Sep 2020 21:47:10 +0000
Message-ID: <DM6PR12MB276127EC6B7C68D5B1B27D088C320@DM6PR12MB2761.namprd12.prod.outlook.com>
References: <20200929175957.25855-1-Ramesh.Errabolu@amd.com>
In-Reply-To: <20200929175957.25855-1-Ramesh.Errabolu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-29T21:47:06Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3e937017-efe0-4e31-a766-39f74b679cff;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3f40:293:c018:8079:d1cc:e4f4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2f3a41bf-963e-4b78-bc5e-08d864c13873
x-ms-traffictypediagnostic: DM5PR1201MB0011:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0011B1B1D5D9F42B6FE776408C320@DM5PR1201MB0011.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nOLO8YVU74zgGR+hgwsV56nba/qjv941Uykwu1BnBHi/3sLbTPdMWN2jqbXrMkTyYsLAxVZfQMxR8Ij67+HsRJRO/eSRidA/y2h/7V5+M5sn3ulVDJT5TIMR9iG1WmGSHT+IVfriiEHm26NmFxlnbC414fSzRd3YExp2dFwvODxAQlQuAps79MSF0oYDwh8YJVUV64BruDwwEdzr17aRjewAvHA1u4x+ZwVq/uXEkOfREjvl7Bt+YYjSzfLphCCz9XrI0KsFm3YeLPaQNhJon50rJBOp2F5ts5uOPrxnON0TQWFe7rDAdFAH+g2wUE6vPuFagZJYNlAwtSJin+C4+r711pq441FIvext20mHwqbVVNNQZGCUt16o1TH050xo47dC0b6OLFvgRaVz9B2suzQQ/t9qIpAGH1CI5PJMiJk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(71200400001)(966005)(5660300002)(45080400002)(66446008)(64756008)(66556008)(66476007)(86362001)(110136005)(76116006)(8936002)(8676002)(66946007)(33656002)(478600001)(55016002)(52536014)(186003)(2906002)(7696005)(9686003)(83380400001)(6506007)(53546011)(316002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: LM7punijXndo6ytDwP6cijW9SFTbgZgFHNUUrar1Wg2o81YfMRQcGV2iB5r6SmbpIV/7gZ68EkErv8Q08Ul/a6iTmIy8mKRHG6qHI9wBGjws7IfMNxe0qppVUXpvzudc5iv/KoVW+uC1mnVoGpYHOQBDDjquBIEgIZOHF2tuGsbMrbJKvjLqk/h8LCuhjh2uDbuRVtDd46vG0PVCxL1q5yoMRoR2v0XzsgSKdXai9WhMXobttawERP7WEv3RTOR+br8zEWJUpsgP51KcctWzgNeKNL5kSExyjFzdwPcjJktQ5M0xMqS1BGmwtK0DWmNKE8tag1pf8gTbyXBnFh/Pr6wS9nzi8lQDB2DCXrq8dFeEmGZC0cW6I0tnE0/dICZffQfusyj1dcmJNQTkbMmhtf3u2qFFm5yk3pi6KAoLy0DMMgHxw+i7DtgDxi//XMuQvjj9nAwtWug4nIdesUEtCNnOeTltFk1XZeKrCbHNEWrCu1z3tr791lY6t0LBJ5WfiVQ4gEybeS7WoiS7+sPj1Pnq77oTcmkMBv0IMD5cZZcpS8JBngJjFroVTIK5VL+w8mjFMDJ9u+ShgBtYqT64qqt7FMca9cXo8mgXwxhJcYRzV4T+9REDlCB9xfDUv6oBp74uAKCOTyxjQVQ8ND0aWC3gFBd0SigUHP49w0G2AMbDc0v3FH123ncAIIyMs8vO0pWDZQC+EjoFHkiRatQihA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3a41bf-963e-4b78-bc5e-08d864c13873
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 21:47:11.0230 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tSFK54zzsVv4C/s7RsMnhBjz4D63lZjly6dgt7dJz4u7xbf+Uaw6Z2+LKNWnF3LDCCq11uJp8uqM0XMrU+f9Jw==
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
Cc: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Minor correction in the commit message. I think you are planning to report CU occupancy and not CU usage.


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ramesh Errabolu
Sent: Tuesday, September 29, 2020 2:00 PM
To: amd-gfx@lists.freedesktop.org
Cc: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
Subject: [PATCH 2/4] drm/amd/amdgpu: Prepare implementation to support reporting of CU usage

[Why]
Allow user to know number of compute units (CU) that are in use at any given moment.

[How]
Read registers of SQ that give number of waves that are in flight of various queues. Use this information to determine number of CU's in use.

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 5 +++--  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 346d8288f6ab..6959aebae6d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -49,6 +49,7 @@
 #include "amdgpu_ras.h"
 
 #include "gfx_v9_4.h"
+#include "gfx_v9_0.h"
 
 #include "asic_reg/pwr/pwr_10_0_offset.h"
 #include "asic_reg/pwr/pwr_10_0_sh_mask.h"
@@ -788,7 +789,6 @@ static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);  static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
                                  struct amdgpu_cu_info *cu_info);  static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev); -static void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num, u32 instance);  static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);  static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);  static int gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev, @@ -2397,7 +2397,8 @@ static void gfx_v9_0_tiling_mode_table_init(struct amdgpu_device *adev)
 	/* TODO */
 }
 
-static void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num, u32 instance)
+void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
+			   u32 instance)
 {
 	u32 data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
index 407472031daa..dfe8d4841f58 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
@@ -26,4 +26,7 @@
 
 extern const struct amdgpu_ip_block_version gfx_v9_0_ip_block;
 
+void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num,
+			   u32 instance);
+
 #endif
--
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Charish.kasiviswanathan%40amd.com%7Cd26021125f48446b565508d864a185d5%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637369992488452463&amp;sdata=Of8rMVEjoNIo1Nds2TfAh1BcuxeKCLGZDxe53bbat0U%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
