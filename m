Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C571DC43464
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 05:37:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19449207D3
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 05:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GDcGh9ji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19449207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 862F46E140;
	Mon, 21 Sep 2020 05:37:14 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770081.outbound.protection.outlook.com [40.107.77.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 289156E140
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 05:37:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTdslUEa1IIwzyN1f5ZO/JLLf9hc5jfnd9sb3pbRAz1qKe5nSAPLUHyvQdON0JKn5ObgBQLPh1XWEf6iwynqANFxZa0YhV7EeYHiLO4vPguwDn7T/KH1vkjHNAhN2Uusw3EyP5LhzuNcDgW+g/YQY9nL52inmKtuUpYd1e17UGNalAbTOhJpOWPCBQJotBR5ntL+TXbe/9tZu59UDgd271irqP7aDXNjS27WED8WlQN6p7bVGqiYQZh5eS8jj0roeHs/vzST0aq27NzUh305Y8hap+c9nZLI2BE7dTSXUCyW7VzIkdJVNXZw1a9ypA1rB/IuoB0xA2o5nA4TjC8jIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7J1sMeCDrq8OuOorjKZyk1qQo+tEaudDo1bOUUGwIE=;
 b=LsMuQoFqE4ffiRz/rGufzOWr681GlhUIFl07kvsMV6NpxUiSYf9z8LIVBNsuBYikkF5khon6UJ1imDhBSzzmxvdXC9hVVFLxpiZGyjhaLHpClK2cSiQRDMf5Bl0HzcUbQ6Aw9UNYn30Wx/FFDd1UskKLxr9DZ/gVCMLjLSLZE31MhhGbSxQKYLXbUJOMhXxriypw3O6QHzx57S8k+qA4WJMWsPntZ/wRy1GjBsouofXketNyaq0knC/0QviPwmEtKmpIu4BzTFotiFwvWCb3PmlamXiBMIWeiLXz53mkQa+J4+q1V2taeFcF0qFe6v5zs2DVez5qb+Be8Qw7iIHOtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7J1sMeCDrq8OuOorjKZyk1qQo+tEaudDo1bOUUGwIE=;
 b=GDcGh9jiPFS64gm/571UiEKJMjmaKTyTyMuUehAu/pWvyLuWt99ngqFj7dPCOyBbo+zWy0cCbWko2Ru5YFO+sJLNqooN/ThmhajDw5DaZCQEpZ1vppUFU/u9qXLy3cX3W5EhpHzOKveSAGw6hynsl1vAyWwLdW0KFJSNiBYvqD8=
Received: from DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22)
 by DM5PR12MB1353.namprd12.prod.outlook.com (2603:10b6:3:76::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Mon, 21 Sep
 2020 05:37:08 +0000
Received: from DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5]) by DM5PR12MB1708.namprd12.prod.outlook.com
 ([fe80::7865:b161:9dd1:7c5%10]) with mapi id 15.20.3391.011; Mon, 21 Sep 2020
 05:37:08 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Deng, Emily" <Emily.Deng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu/sriov: Add one parameter for mcbp debug
Thread-Topic: [PATCH 1/2] drm/amdgpu/sriov: Add one parameter for mcbp debug
Thread-Index: AQHWjWum3oyEs8coY0uG1B4JLZ2ghKlylVOg
Date: Mon, 21 Sep 2020 05:37:08 +0000
Message-ID: <DM5PR12MB170840A1DBDA0DC13AE71368843A0@DM5PR12MB1708.namprd12.prod.outlook.com>
References: <20200918032717.184758-1-Emily.Deng@amd.com>
In-Reply-To: <20200918032717.184758-1-Emily.Deng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b0797491-070a-4531-9d4c-000001bec29f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-21T05:28:49Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dbc1181a-7f2b-49ba-7eba-08d85df061a4
x-ms-traffictypediagnostic: DM5PR12MB1353:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1353EF929FCFD902E8777FF4843A0@DM5PR12MB1353.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zUd+I1OqhZQseo+iMYaAPvYKr6qeT2D1t+RIc7tBaW6cZxNEdMsALswNeWfMGjZhU+2NZi+hmltiAVWHHMPWm0ldFJxgfuQqh+X9p8O+ZuyK22tXCT7MBKZapQ8ECRU+0X0PFNXKn1Ucxa22Yzwcqkfi7llnhtpmv+OlU1nVN0uNtGMLEjj11squKSeve0xx56lm+G0OS89LSEGvG1zkrEm2AVi3WPaCmLvrFnaTwNNzU3+OHGG2DUL8oCTLdINizTCxjifnbkY9ut4jDxbX0qx0hisI6A6JhqLk9jf3UI+RhPvogwIXo+h7KDzeZQNFfG4VNlkgrlsIru4i+CeZ6R3oHhe+cI4qwiOPHRJpMDBnhMI6dQqesQ6v3iyyek27GnpnH0KO1cMcT3+exusuDGgTk3vonuvQIAxbv2owp2M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1708.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(4326008)(186003)(7696005)(66556008)(66446008)(64756008)(66476007)(55016002)(76116006)(5660300002)(66946007)(316002)(26005)(86362001)(71200400001)(478600001)(2906002)(52536014)(83380400001)(45080400002)(966005)(8676002)(33656002)(110136005)(8936002)(53546011)(6506007)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: /y4O+50k8woGSTx8Rw4IoRstb8zEDGIya0PCI5kXVSHvQZHCH6r9pqw+bVF7I4sTrSRVraFW72m+rDyumGXBrZOQOgKWf6pnDMMrdnEox9jNtKrVBEL5DC9kiQzlV2yNevAQA3zOOLIk7nnQk9x3MxH/+FSpwP7hJXsXB9ToWFPKUcNacwcMdSh70pBci46crH3nU8OasCU1yNB2PZaK7oInk2gzkcPymgyhl93rDgG7FcJ1fZgpTEZlxGa4Si6jxEdn9jszZFeYY+0iDvr8xNMZnXBs5phtZRPutlr5jB0KVzQd1t05IYpqIQqgBPAEgsuwGViRREVjaL6WsbAD3BZxJA0PipQJBHQd4vRSSgnZsTz/OcEPqdcpBTuVDZ1azBoVOVvFdUnTpSIA8n4tK4EY0RZq1K4Exi2Avnf1JsRK7+VGgqrGGaypXOKRQF2jbYb3SSuRJzyrnDohoYr6UGCpPvvmISIBaByR5EtbPKNZm/pB20Ur412ivJHgdCbRRQhozADI9Qtc9+yv86Ge6/MFj8r/Bxt5wPp3uJulFdn0stpitE1keQvuqcUOplmBiLM/S5tlQkddyJXRP87yJJL6ZgHK7H4s/dB1hMfhXhCQE7o9PlmA2tKcaXasBRlcHHfmYTz9OGsfBaHzv9q5Tw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1708.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc1181a-7f2b-49ba-7eba-08d85df061a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 05:37:08.4079 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vZmlJQR20T0WdY5YL7creq0inNo+iag1m4yqrUUkpxKTZTOFAZdZgzgSzJe4RA0T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1353
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Emily

There is already a amdgpu_mcbp parameter there, can you try to leverage that one ?

e.g.:
we refactor our driver's code and reduce the checking logic  from  "if (amdgpu_mcbp || amdgpu_sriov_vf(adev))" to something like "if( amdgpu_mcbp) "

therefore:
1) You need to force set "amdgpu_mcbp" to true in the driver's init stage once the "SRIOV" is detected *and* "amdgpu_mcbp" is not set to "0";
2) for Bare-metal, we just leave "amdgpu_mcbp" as the value it was....
3) we interpret  "amdgpu_mcbp"  as:
0: force disable, it will be "disable" for both BM and SRIOV
1:  force enable, auto (default), it will be "enable" for both BM and SRIOV

This way if you can disable MCBP in both SRIOV and BM by that existed parameter instead of introducing a duplicated one ...

_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily.Deng
Sent: Friday, September 18, 2020 11:27 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/sriov: Add one parameter for mcbp debug

For debug convenient, add sriov_mcbp parameter.

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
Change-Id: I84019eb4344e00d85b2ecc853145aabb312412fe
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 9 +++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 3 ++-  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 13f92dea182a..a255fbf4d370 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -183,6 +183,7 @@ extern uint amdgpu_ras_mask;  extern int amdgpu_bad_page_threshold;  extern int amdgpu_async_gfx_ring;  extern int amdgpu_mcbp;
+extern int amdgpu_sriov_mcbp;
 extern int amdgpu_discovery;
 extern int amdgpu_mes;
 extern int amdgpu_noretry;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3f07d1475bd2..b0b2f0f7be94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -145,6 +145,7 @@ uint amdgpu_dc_feature_mask = 0;  uint amdgpu_dc_debug_mask = 0;  int amdgpu_async_gfx_ring = 1;  int amdgpu_mcbp = 0;
+int amdgpu_sriov_mcbp = 1;
 int amdgpu_discovery = -1;
 int amdgpu_mes = 0;
 int amdgpu_noretry;
@@ -578,6 +579,14 @@ MODULE_PARM_DESC(mcbp,
 "Enable Mid-command buffer preemption (0 = disabled (default), 1 = enabled)");  module_param_named(mcbp, amdgpu_mcbp, int, 0444);

+/**
+ * DOC: sriov_mcbp (int)
+ * It is used to enable mid command buffer preemption. (0 = disabled, 1
+= enabled(default))  */ MODULE_PARM_DESC(sriov_mcbp,
+"Enable sriov Mid-command buffer preemption (0 = disabled (default), 1
+= enabled)"); module_param_named(sriov_mcbp, amdgpu_sriov_mcbp, int,
+0444);
+
 /**
  * DOC: discovery (int)
  * Allow driver to discover hardware IP information from IP Discovery table at the top of VRAM.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 2f53fa0ae9a6..ca0e17688bdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -236,7 +236,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,

 for (i = 0; i < num_ibs; ++i) {
 ib = &ibs[i];
-
+if (!amdgpu_sriov_mcbp)
+ib->flags &= ~AMDGPU_IB_FLAG_PREEMPT;
 /* drop preamble IBs if we don't have a context switch */
 if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
     skip_preamble &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d7f37cb92a97..156e76a5a6e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -742,7 +742,7 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
 dev_info.ids_flags = 0;
 if (adev->flags & AMD_IS_APU)
 dev_info.ids_flags |= AMDGPU_IDS_FLAGS_FUSION;
-if (amdgpu_mcbp || amdgpu_sriov_vf(adev))
+if (amdgpu_mcbp || (amdgpu_sriov_vf(adev) && amdgpu_sriov_mcbp))
 dev_info.ids_flags |= AMDGPU_IDS_FLAGS_PREEMPTION;
 if (amdgpu_is_tmz(adev))
 dev_info.ids_flags |= AMDGPU_IDS_FLAGS_TMZ;
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7C497edf57e53b41a055fc08d85b82c709%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637359964547689160&amp;sdata=zXlPTG939tdC0sUbCntiJuGsZHpM15DqWmgy8SmZ2Z8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
