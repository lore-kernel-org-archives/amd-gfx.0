Return-Path: <SRS0=y248=KD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F22C433ED
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 04:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE091613C5
	for <amd-gfx@archiver.kernel.org>; Sat,  8 May 2021 04:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE091613C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92E026E851;
	Sat,  8 May 2021 04:35:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAB9F6E851
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 May 2021 04:35:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQg9bLU5+bjdIgAgJFP3ORtyMCb+YWzrbGZHSOJDgzduUXuFq4ywJizR1HdlmP9vGgZQBoD6fCgGHYkpooCpBIejXXtgmsfZXfXzdUdCXmouFW4bj3dsBEUy0r2X3xfnT4JkFK3tJZmacjVTA/OfbAWelR9zRSbyw1h4u2a4Zje1PVFfucgBCn7iYh65i6nrm5UE2siBUy9ik8hp+zErfS8nbO1uG5dOQWrokbfrKQFCetHq0NHjqDOaLL1xd4Nw+66vuVVCoBIpTE0T4QOrp4UMC8/YmUo8gSext2XyqPztOmkW4lrjpmlyORUaaAo2/oiLPPOibSxjv4zgZxIGIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8ev2OyuEiFABDsN1rwSnmiVIBkZ1n/UBXm9WpWAmUA=;
 b=h2S1P9zjnYen930CuYjAwPvV6NvAG8p9WQOFA8pFuM7rr2CDhBrR19dI5QlLutVBxf/mAwpJuaK3vI4SrqF4DM35pclJ5SgouyVhhKFvTFD2V0juIcUjOQTrWGDxxT72AjiobcnJZRS56bPdYt0EVnUlqN9tBN6aWWCrD976u//z9lzE/rxC4m7pHoJB6ZtKOEL0Yz1v5sAi8Q9EHN5sCB/UWMj0epS03ZJW/BYfOqTiUaGPgW3lb0XxGlAOvULi2iwaLXRVKil5SJ6+gnYIxRBLeyHIQKpq3KrhrTvCYYRSRPa+A6XFKS6yyfVzETWVNKUeBRuu964G7IRh2BuWoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8ev2OyuEiFABDsN1rwSnmiVIBkZ1n/UBXm9WpWAmUA=;
 b=gF7N4MMy8zRIi3OrLUy90xIZS4tYPbSCRzHPdf2Ag+jkcSlT3iy5dPrdvCwatB8FvJtSrXcinbUjpXcCIdSCgcZY6+OzLfMS1LI1M0cZ6Sp0VfKO+/xLWcGHUYt+IC/bJsmj+fVa+Gbtg0c6BdXp1EwZ4k+wS69L6hKJLmG27Xs=
Received: from CY4PR12MB1606.namprd12.prod.outlook.com (2603:10b6:910:10::15)
 by CY4PR12MB1606.namprd12.prod.outlook.com (2603:10b6:910:10::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Sat, 8 May
 2021 04:35:13 +0000
Received: from CY4PR12MB1606.namprd12.prod.outlook.com
 ([fe80::2975:6f1f:5cf9:e186]) by CY4PR12MB1606.namprd12.prod.outlook.com
 ([fe80::2975:6f1f:5cf9:e186%8]) with mapi id 15.20.4108.028; Sat, 8 May 2021
 04:35:13 +0000
From: "Sun, Roy" <Roy.Sun@amd.com>
To: "Sun, Roy" <Roy.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Cancel the hrtimer in sw_fini
Thread-Topic: [PATCH] drm/amd/amdgpu: Cancel the hrtimer in sw_fini
Thread-Index: AQHXKt9XOnDqi3Yl30O5I0uQril70arZMTRw
Date: Sat, 8 May 2021 04:35:13 +0000
Message-ID: <CY4PR12MB160640CD242BBDD0CD633A74FF569@CY4PR12MB1606.namprd12.prod.outlook.com>
References: <20210406122111.23989-1-Roy.Sun@amd.com>
In-Reply-To: <20210406122111.23989-1-Roy.Sun@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-08T04:34:54Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f82c2218-a966-47d1-a746-21e2e8121252;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2435926-99fc-4a93-ac1c-08d911daabf8
x-ms-traffictypediagnostic: CY4PR12MB1606:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB16064BE6F35ED0FAC18EC650FF569@CY4PR12MB1606.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1ha8hwHAYep78Q+UPAhYI48hrPwWppGWSofufSSbQyHTbkkWoOJfUQiGUDr8q8goD8IPR5EWeb99cg0pmhjTp7G5zABZ3pR+AfWTtYKVfSCjO/0ahMKpmS8iRhXsgEa+YWkV4lhxn24QVKeEUn4zC+p+Fhx76U0TrFHPWIOGAWYLv8ypETWd+yDeMDfd1pqDQ8UYxYcEL0SZQwGFaqDSNvfJOGd2Q6ESiJ5zh7piojyBGoiCt3XklBNGkKylgNctul6zwCDkccu2Zy4hI2MU9E+LCzhca45Y0Dewn1uvI7uGQlA9Weev+lAWuWeK+fo+seiYMr7599wfPIJYqirqY1/L6OiIJehZkdJyat3FNZXOQiWUv7Y3DW2gzQyBWO9noVhtjo8ew3RjDs6PRDjWQUSed+sN1djUux7XeuKFHISuxPrgf9l26+A7QoxPkf6ipLlyjBVpt4cUR4ytdG1AUTVl5aHx3DINoI9x55qQslwvGsI6wLljLvA+FLe6+LAccJpIqEWmFXRHK1GJo3yTKgJXnjJ6dW2LVsGLB5vvI7oIk0lMrJ5TmEDRaTz+bLVwaFez3xv/F1iA48ll8M71WR1gtFMhJqXQUdorjrfqHJY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1606.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(9686003)(66946007)(52536014)(76116006)(186003)(38100700002)(55016002)(26005)(6506007)(8676002)(122000001)(66446008)(66476007)(66556008)(64756008)(8936002)(5660300002)(71200400001)(478600001)(7696005)(2906002)(86362001)(316002)(83380400001)(53546011)(110136005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vQEyHq4YTQPJYG8/LO6nHIGc7AxAKtaBIuenAog//5L5SDGfqFSDL9BGW4O5?=
 =?us-ascii?Q?6fm7DAboCGt4vgeIxD2dkh2UJd+KrPUIKrqrGXxuknM1a3MHxUOBtmcsLn/i?=
 =?us-ascii?Q?nn1ZI1WpY5+q/lrextLdyP//JEM2ODSRxCdeyFN3SQABv/zmbceQeobVbutO?=
 =?us-ascii?Q?HqvH1Rr9DbFc+46hIYyEvnTzLBS5Ge+lE91j40D/82AR9BnK+H7wB7uAzVU/?=
 =?us-ascii?Q?nMQdpnEHwTPhPzdKmWpCcReuEJmjdd2LuVCYp1zYn+LuHM1jyGn7ojqwMrVq?=
 =?us-ascii?Q?v8kpD5+ErdpHhqRhWlLMeetLNwIjhPcdo0AoIeMgH95uaHl6s/97zku0RJpV?=
 =?us-ascii?Q?W1xqwiYAlixq9ooMTZKK60+Xf2PpH0cQYP0d04UCzOML2+s5ytaI7e9zQNKL?=
 =?us-ascii?Q?OMgao3tEKVrrjJa77n5SPhFAdytundBmRErR09jIZejaGiwTZUbftZga38yh?=
 =?us-ascii?Q?N20mu96bZd58B9tVxXDLlUMtq2MO0KtLpst+QuA17gi6KrXCsqc532rEYIcF?=
 =?us-ascii?Q?yHCVwpSDhMIHNI4691QxgwAUPlAxaCOi+9eJIcl59VeuUY+MsGAHo2YchGao?=
 =?us-ascii?Q?xR4D75elM97IwkL2wh1PIUkXfctzKWStq0/nbCuAHIcNylHRaVxk0GMEUUaP?=
 =?us-ascii?Q?AymOOChTW5qXHKCezIvI9jpJf+cHl2zi3X8rYJtjpcp70zmY9bkv4+B7mexs?=
 =?us-ascii?Q?9uzDMsiI+w1/Gjh75FqPV7S0C99KhKjWBoSWzvMVYVB+im1iC58HknMPp8dY?=
 =?us-ascii?Q?639Oulny8QHqkGB+8b65Mhkat3C1F4YFuSugliOFfYzShfyHuGk6lt4YrSqn?=
 =?us-ascii?Q?UYw5RCj0uXBBHDhD6W7YovcLNg133lAiXjCmgdzgxLXHqtQlHjmizmzchQYq?=
 =?us-ascii?Q?rUKjxwBRnCfVdSckfyOsu1oB9SSfRq0iID8/tzCL6fWrOiCibVgMNkKjHBIq?=
 =?us-ascii?Q?j33XSCvqsffIzJVV2ODfCAiEQZGy/yEODTNB4VVfC3vcB88T53CPjPRsV7FB?=
 =?us-ascii?Q?bfnSk7Qkv9lmwYNqLXfYUF2pFpW9S8m0hA+41TbrvJd/vqoOZL2IYoi625Oa?=
 =?us-ascii?Q?CqdjMPlauE6bH5bXGj7poYI7YcTWLXwZ48Gn7kMwvs+JdeEwxeCZNr8/PhHy?=
 =?us-ascii?Q?rfdxWsxuBrBiS4draBjCBUwfM62BUshZv+qpN1lk0yDm37nWrulwWYN4lV9l?=
 =?us-ascii?Q?oIAJVp7XI+JHadaTMznl9qbu0Nr+5vpwEicYuzonpAI0kdvgQulMj1Mh2Aw5?=
 =?us-ascii?Q?kI5osAD814D5U3Qc/YPoEv4uZdgVN4Tg5bbML3nXHGFMVXjo4Vxc8VGDWqGO?=
 =?us-ascii?Q?7d2lMwdHNHa7PhrCjuaKlHwg?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1606.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2435926-99fc-4a93-ac1c-08d911daabf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2021 04:35:13.3970 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PlpIZmILGa/AN/fBS57JPMrpoCGVe69v0B1YLFtkBPxc2mCcJAd1ZjzCUwmy3va+AUW055qeTkVcEmfRVb8dfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1606
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Ping

-----Original Message-----
From: Roy Sun <Roy.Sun@amd.com> 
Sent: Tuesday, April 6, 2021 8:21 PM
To: amd-gfx@lists.freedesktop.org
Cc: Sun, Roy <Roy.Sun@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Cancel the hrtimer in sw_fini

Move the process of cancelling hrtimer to sw_fini

Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index 5c11144da051..33324427b555 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -421,6 +421,11 @@ static int dce_virtual_sw_init(void *handle)  static int dce_virtual_sw_fini(void *handle)  {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i = 0;
+
+	for (i = 0; i < adev->mode_info.num_crtc; i++)
+		if (adev->mode_info.crtcs[i])
+			hrtimer_cancel(&adev->mode_info.crtcs[i]->vblank_timer);
 
 	kfree(adev->mode_info.bios_hardcoded_edid);
 
@@ -480,13 +485,6 @@ static int dce_virtual_hw_init(void *handle)
 
 static int dce_virtual_hw_fini(void *handle)  {
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int i = 0;
-
-	for (i = 0; i<adev->mode_info.num_crtc; i++)
-		if (adev->mode_info.crtcs[i])
-			hrtimer_cancel(&adev->mode_info.crtcs[i]->vblank_timer);
-
 	return 0;
 }
 
--
2.29.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
