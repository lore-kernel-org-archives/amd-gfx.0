Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E133C388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 16:19:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6B92074B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 16:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1pHEijwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6B92074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E45B66E09F;
	Wed, 11 Nov 2020 16:19:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1489A6E094
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 16:19:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVED1B0RHHjC/gGoGfjx80LG6EDRFAXXP42/Kdf9LJIQ1KGGeK2ixgucIsot7/kN4h7XrsHOVywQnKuGzKzUsVVmyXP4MrGZkrNHkRziaKkO0on/hGp5OuiKou7L9OOedPRgly5NiP9QCr53pNHU/2oY9TruBAwwrP76EZHXAZXo/bIIbreb3/+0Sg64ENh9iS3gIUadoOohdeOHAFJIzleaCnFakWuK6rKH0XJKPdeucbnvyt3mPr91zLRGC4t3EHQRbYkr8hiRmS8fb7JV/l+tNqYXfLjHvO2QWKA0HTGpAriQMP/+3snmH6sze/grI9esnnqNm8B781W/YN3BZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZ3WC3I31gaZQec/ok3koxCQPG4v4/3QOmNGIsDOAzY=;
 b=Ety+BiWqQ4dnlUxw0EPWHwJIIcvUw3A74A58VlR8sc6nVqN150YOUfWYOqgwo0u4KrBJY1lPAOrhjauVIGn+uiBHOc90De9ywyDt3ewXOJMMxww8aRQP8tc3e8OmRRKhNWUKjEJ4iclA8yLT0C/vtPIIaE9wtH3AleJwjDifHgB6LVE0J7uafV50oHiBO6668bqr6Z5nL2E5HmFJ+Nrv30JKVx0+59ayjWfDdSCYMFtF9S68WzE5xaOkl3rH3K2vZMzYgX2M7T2qWCrBRvAQg0Jm8px2y6UoyiRd2qAMjg6Ux3i0LSGTM8fmFjyQYjIuAd2+/3BokSUeLfv1f/xoNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZ3WC3I31gaZQec/ok3koxCQPG4v4/3QOmNGIsDOAzY=;
 b=1pHEijwiBZaLVYT4qB20eBEtHQOHUhSe7kWr5wNwLPuZ8NPzje7dIMPZyXaAmVu3CDKu1bmqMt4oyAPD2f/jCt+3MRi6adk6eBkZoMbCEluUT/DFoOkL0wg2TPeRYsSX6zWf1JCds7cA7uQSD2bgpdlD+dUOtq1p0ojZd2iPRpk=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 11 Nov
 2020 16:19:10 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 16:19:10 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd/pm: update the swSMU headers for vangogh
Thread-Topic: [PATCH 2/2] drm/amd/pm: update the swSMU headers for vangogh
Thread-Index: AQHWt9dqGfCl66l7l0KPJ349CtQlyKnDHQIi
Date: Wed, 11 Nov 2020 16:19:10 +0000
Message-ID: <MN2PR12MB448850A7D777BD4E129ECA95F7E80@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201111030418.27296-1-Xiaojian.Du@amd.com>,
 <20201111030418.27296-2-Xiaojian.Du@amd.com>
In-Reply-To: <20201111030418.27296-2-Xiaojian.Du@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-11T16:19:09.775Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8cc18032-d7ed-41ce-b803-08d8865d859d
x-ms-traffictypediagnostic: MN2PR12MB4143:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB414323D719FCED3EB2D43D77F7E80@MN2PR12MB4143.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 09WciiJ+7O2P+3wSeX6bstXhKY6R9rrKoTsSUctVMW7M2tTSM+BQKgIQEK9BdxhzIkt4hJjssl6jCaXeJ1DjnG165tKQ4XsSSS/eq1p3CipckELF1mwCvFT2vQ9eWZYaW6EK5/eB9YTyPCo0ZqW3Rp9zTQSnVRcBeGXiozefgXW5GvA1J7Vk44p0TOE8+43PWhtWWgv1Bp4gXkUqzG3OzfG6hiBnKZo+L5+tV8NLKRX0IaHmyVQvN4m0i9m9MOqY/+Or6BqJXvJxNS1rvDH2LAPopGjngcO15FzBGqNM/yFrhuaPBSP4GJeJnKj8YDSgxDKBFBS2EIeQSy7Z8pWzwA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(52536014)(71200400001)(15650500001)(66946007)(64756008)(66446008)(2906002)(9686003)(86362001)(76116006)(5660300002)(26005)(8676002)(53546011)(19627405001)(6506007)(66556008)(7696005)(66476007)(83380400001)(4326008)(186003)(478600001)(55016002)(8936002)(316002)(54906003)(110136005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: zZcN3TRxcx5rlsuRkf9PrMfISM7HQGuHB+7EwfNq82c4f+mys9I6/QKe7Ht1H7HrXAlZGGME0h4sHxkQgD7CptU7SIo7ZebMqkPPphFWxbknnmfoAHVpW06ia1rLQCxhTvEcvQGgEOx0feQPrgJYanW/ui+AQhusYFj3ZP7jVB1rMwk+cwNQYeJvMsHhSM4MthfcqAv1mtEpfCy++m1amEX5JWsXoaBzdowjhkn3NibyWCpW2hN9nYxq5icGenHzaXgIPYAS0JQCoI2KAf9atxpf6Nx6bjQ7kRmNl8bqdO7FXg56hf6Ui7VbmKBBvAejPOO802WNFyae5nqErG3plHYe6x0f5Ply+0U9Z4fyKlejLGW+Si5sujE+/dZYmNDGVr2g1fI2OXRP8UPMjh6qGxXgosLKfnGFn0k3bMJNDbkRIJVgFcO7dfSCmwRf9xogKZEFlxkEI3QySRR5Nzr7/BMXBisCvdpG9RQGLNMtSQc24O1JJe+LMMW82FQh9xmeG7XkfQ5cskIRiFEoJZ5eDsVgPwV/m6m9x6pOLsA8rksXgmjYbCl+XNhuJUCQsOez9UTOFjvzAhEkh7oIub1znxRNJjUfL1nnPfMEWseoTg7y7c8GTPGnlWhqUvBLdMFiXYGLCnM8WpsnTTt2Hsy8bjMHSzpT4Zmd2lSjCPkl0OziCvP7o7vMbBM7WQtqzY9FnLK0d5Q9ruP8lWZGEXb5f7xIjAQwBy9SzWnSPy97ARneshD/hExLMjvbTtC/DEgFO0s2yYxORnBoZDT7beTm2e27MJPCZXesnAD4SNVPxRnlgtOaHGDRVDCJFrqlLq82FT6GJpoInX9UOKfFTEbnyk1LSoy3deyZ4keiFCi79M1QHfuSeHNGtLmDNrEDjLvliXkUmxnbb6f3mdsRhH5B2A==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc18032-d7ed-41ce-b803-08d8865d859d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 16:19:10.3526 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4TZjoGDv9/q+rAScGTckToh/8X9L64cP3XElTgbz0iGxxvA4dhvNp7etTjIClVXjMf/j1RkKBA+9DgBS3bPV4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143
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
Cc: "Huang, Shimmer" <Xinmei.Huang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: multipart/mixed; boundary="===============1828808967=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1828808967==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448850A7D777BD4E129ECA95F7E80MN2PR12MB4488namp_"

--_000_MN2PR12MB448850A7D777BD4E129ECA95F7E80MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Du, Xiaojian <Xiaojian.Du@amd.com>
Sent: Tuesday, November 10, 2020 10:04 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Huang, Ray <Ray.Huang@amd.com>; Huang, Shimmer <Xinmei.Huang@amd.com>; =
Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.c=
om>; Du, Xiaojian <Xiaojian.Du@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: update the swSMU headers for vangogh

This patch is to update the swSMU headers for vangogh.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h |  6 ++++++
 drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h          | 11 +++++++----
 drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h         | 11 +++++++++--
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h b/drivers=
/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h
index 8f438c80132e..1c19eae93ff1 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h
@@ -142,6 +142,12 @@ typedef struct {

   uint8_t NumDfPstatesEnabled;
   uint8_t NumDpmLevelsEnabled;
+  uint8_t NumDcfclkLevelsEnabled;
+  uint8_t NumDispClkLevelsEnabled;  //applies to both dispclk and dppclk
+  uint8_t NumSocClkLevelsEnabled;
+
+  uint8_t IspClkLevelsEnabled;  //applies to both ispiclk and ispxclk
+  uint8_t VcnClkLevelsEnabled;  //applies to both vclk/dclk
   uint8_t spare[2];
 } DpmClocks_t;

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h b/drivers/gpu/drm/=
amd/pm/inc/smu_v11_5_pmfw.h
index 99a406984135..22edd88b8117 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h
@@ -90,14 +90,16 @@
 #define FEATURE_ATHUB_PG_BIT          56
 #define FEATURE_ECO_DEEPCSTATE_BIT    57
 #define FEATURE_CC6_BIT               58
-#define NUM_FEATURES                  59
+#define FEATURE_GFX_EDC_BIT           59
+#define NUM_FEATURES                  60

 typedef struct {
   // MP1_EXT_SCRATCH0
   uint32_t DpmHandlerID         : 8;
   uint32_t ActivityMonitorID    : 8;
   uint32_t DpmTimerID           : 8;
-  uint32_t spare0               : 8;
+  uint32_t DpmHubID             : 4;
+  uint32_t DpmHubTask           : 4;
   // MP1_EXT_SCRATCH1
   uint32_t GfxStatus            : 2;
   uint32_t GfxoffStatus         : 8;
@@ -109,9 +111,10 @@ typedef struct {
   uint32_t spare1               : 16;
   // MP1_EXT_SCRATCH2
   uint32_t P2JobHandler                        : 32;
-  // MP1_EXT_SCRATCH3
-//  uint32_t spare2               : 32;
+  // MP1_EXT_SCRATCH3: used for postcodes
+
   // MP1_EXT_SCRATCH4:6 are used by Kernel
+  // MP1_EXT_SCRATCH7: used by HW
 } FwStatus_t;


diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h b/drivers/gpu/drm=
/amd/pm/inc/smu_v11_5_ppsmc.h
index 1ada0eb64663..7e69b3bd311b 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h
@@ -97,9 +97,16 @@
 #define PPSMC_MSG_StopDramLogging                      0x3F
 #define PPSMC_MSG_SetSoftMinCclk                       0x40
 #define PPSMC_MSG_SetSoftMaxCclk                       0x41
-#define PPSMC_Message_Count                            0x42
+#define PPSMC_MSG_SetDfPstateActiveLevel               0x42
+#define PPSMC_MSG_SetDfPstateSoftMinLevel              0x43
+#define PPSMC_MSG_SetCclkPolicy                        0x44
+#define PPSMC_MSG_DramLogSetDramAddrHigh               0x45
+#define PPSMC_MSG_DramLogSetDramBufferSize             0x46
+#define PPSMC_MSG_RequestActiveWgp                     0x47
+#define PPSMC_MSG_QueryActiveWgp                       0x48
+#define PPSMC_Message_Count                            0x49

-//Argument for  PPSMC_MSG_GpuChangeState
+//Argument for PPSMC_MSG_GfxDeviceDriverReset
 enum {
   MODE1_RESET =3D 1,
   MODE2_RESET =3D 2
--
2.17.1


--_000_MN2PR12MB448850A7D777BD4E129ECA95F7E80MN2PR12MB4488namp_
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
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Du, Xiaojian &lt;Xiao=
jian.Du@amd.com&gt;<br>
<b>Sent:</b> Tuesday, November 10, 2020 10:04 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang@amd.com&gt;; Huang, Shimmer &lt;Xinmei.=
Huang@amd.com&gt;; Quan, Evan &lt;Evan.Quan@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Du, Xiaojian &lt;Xiaojian.Du@amd.com&gt=
;<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/pm: update the swSMU headers for vangog=
h</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patch is to update the swSMU headers for vang=
ogh.<br>
<br>
Signed-off-by: Xiaojian Du &lt;Xiaojian.Du@amd.com&gt;<br>
Reviewed-by: Huang Rui &lt;ray.huang@amd.com&gt;<br>
Reviewed-by: Evan Quan &lt;evan.quan@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h |&nbsp; 6 ++++++=
<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; | 11 +++++++----<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; | 11 +++++++++--<br>
&nbsp;3 files changed, 22 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h b/drivers=
/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h<br>
index 8f438c80132e..1c19eae93ff1 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h<br>
@@ -142,6 +142,12 @@ typedef struct {<br>
&nbsp;<br>
&nbsp;&nbsp; uint8_t NumDfPstatesEnabled;<br>
&nbsp;&nbsp; uint8_t NumDpmLevelsEnabled;<br>
+&nbsp; uint8_t NumDcfclkLevelsEnabled;<br>
+&nbsp; uint8_t NumDispClkLevelsEnabled;&nbsp; //applies to both dispclk an=
d dppclk<br>
+&nbsp; uint8_t NumSocClkLevelsEnabled;<br>
+<br>
+&nbsp; uint8_t IspClkLevelsEnabled;&nbsp; //applies to both ispiclk and is=
pxclk<br>
+&nbsp; uint8_t VcnClkLevelsEnabled;&nbsp; //applies to both vclk/dclk<br>
&nbsp;&nbsp; uint8_t spare[2];<br>
&nbsp;} DpmClocks_t;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h b/drivers/gpu/drm/=
amd/pm/inc/smu_v11_5_pmfw.h<br>
index 99a406984135..22edd88b8117 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_pmfw.h<br>
@@ -90,14 +90,16 @@<br>
&nbsp;#define FEATURE_ATHUB_PG_BIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 56<br>
&nbsp;#define FEATURE_ECO_DEEPCSTATE_BIT&nbsp;&nbsp;&nbsp; 57<br>
&nbsp;#define FEATURE_CC6_BIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 58<br>
-#define NUM_FEATURES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 59<br>
+#define FEATURE_GFX_EDC_BIT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 59<br>
+#define NUM_FEATURES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 60<br>
&nbsp;<br>
&nbsp;typedef struct {<br>
&nbsp;&nbsp; // MP1_EXT_SCRATCH0<br>
&nbsp;&nbsp; uint32_t DpmHandlerID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; : 8;<br>
&nbsp;&nbsp; uint32_t ActivityMonitorID&nbsp;&nbsp;&nbsp; : 8;<br>
&nbsp;&nbsp; uint32_t DpmTimerID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; : 8;<br>
-&nbsp; uint32_t spare0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 8;<br>
+&nbsp; uint32_t DpmHubID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; : 4;<br>
+&nbsp; uint32_t DpmHubTask&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; : 4;<br>
&nbsp;&nbsp; // MP1_EXT_SCRATCH1<br>
&nbsp;&nbsp; uint32_t GfxStatus&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; : 2;<br>
&nbsp;&nbsp; uint32_t GfxoffStatus&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; : 8;<br>
@@ -109,9 +111,10 @@ typedef struct {<br>
&nbsp;&nbsp; uint32_t spare1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 16;<br>
&nbsp;&nbsp; // MP1_EXT_SCRATCH2<br>
&nbsp;&nbsp; uint32_t P2JobHandler&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; : 32;<br>
-&nbsp; // MP1_EXT_SCRATCH3<br>
-//&nbsp; uint32_t spare2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 32;<br>
+&nbsp; // MP1_EXT_SCRATCH3: used for postcodes<br>
+<br>
&nbsp;&nbsp; // MP1_EXT_SCRATCH4:6 are used by Kernel<br>
+&nbsp; // MP1_EXT_SCRATCH7: used by HW<br>
&nbsp;} FwStatus_t;<br>
&nbsp;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h b/drivers/gpu/drm=
/amd/pm/inc/smu_v11_5_ppsmc.h<br>
index 1ada0eb64663..7e69b3bd311b 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h<br>
@@ -97,9 +97,16 @@<br>
&nbsp;#define PPSMC_MSG_StopDramLogging&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 0x3F<br>
&nbsp;#define PPSMC_MSG_SetSoftMinCclk&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x40<br>
&nbsp;#define PPSMC_MSG_SetSoftMaxCclk&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x41<br>
-#define PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x42<br>
+#define PPSMC_MSG_SetDfPstateActiveLevel&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x42<br>
+#define PPSMC_MSG_SetDfPstateSoftMinLevel&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x43<br>
+#define PPSMC_MSG_SetCclkPolicy&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x44<br>
+#define PPSMC_MSG_DramLogSetDramAddrHigh&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x45<br>
+#define PPSMC_MSG_DramLogSetDramBufferSize&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x46<br>
+#define PPSMC_MSG_RequestActiveWgp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x47<br>
+#define PPSMC_MSG_QueryActiveWgp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 0x48<br>
+#define PPSMC_Message_Count&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x49<br>
&nbsp;<br>
-//Argument for&nbsp; PPSMC_MSG_GpuChangeState<br>
+//Argument for PPSMC_MSG_GfxDeviceDriverReset<br>
&nbsp;enum {<br>
&nbsp;&nbsp; MODE1_RESET =3D 1,<br>
&nbsp;&nbsp; MODE2_RESET =3D 2<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448850A7D777BD4E129ECA95F7E80MN2PR12MB4488namp_--

--===============1828808967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1828808967==--
