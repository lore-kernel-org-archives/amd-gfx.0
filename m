Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E5DC388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B38982224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CtREXXDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38982224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 120C26EDB9;
	Wed, 21 Oct 2020 14:26:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFB826E14C
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:26:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tlnm0UWOdKTW0UOCeQ2LJztcnsqxZRYPbUyIJTGL54BkMx+lxr9QWJ4IYr/5c+HDSMAVVp6fNURc2jK8tleig9k8tPogD0AN2cWs146sco2ViDqUp2JQxLzPt4yBqL7QhLidcl+Q6miv62TGDnRjqkMjPqY1YYas7H1VDpzAVa8ZeXKgJ+GvEmxN/zCLoIA81BCGuLcyseqzAV6EHHBVDdb9lg/m84QetU9Ih0XyE98+5JAfAzAmMc8W/ylo0MtXsqXlbW35D/gtTrYdcPT5sdmX8q8fFYJTwiB9rVRfATcazzB+2aq22Vum1NCe84uWPTbfqQlFnTopx1ffFZiFWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwSV3xKOe0Iz+tVakf0vDgwq88+NPavLRHuHm7Bsh3U=;
 b=ogNUYy2f3ny9yzm7RQbVJeyhn9N/PeDk3/5OHKDqG2iyJdrbzm7htdUpGRYLaZTcPvk0CTzlH9mv2scCbwrfWFGcFuofujhwFxsgG7B3xbL+mI69TREuk9NaVLp1LXE1ysvHMG3j5miIdLMxHblz6W+y2puNC0Ykl4oiFp8fRKGEHZrqMygYkoD3bd4dv8ZAH+6iPnLmJa01GIl3FuDS0O6hxsqJ7waCfBE6i9tOBv1Mp73+3A05nJCBhRmQUvo/I1h0/j4ENTnY3GurPN+zuuZMNJdxSc2V+3jgcEpgYTuvQpvPaGhLapAgEClh3ErFtCBz5WbdQWhlh4KvBZgQIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwSV3xKOe0Iz+tVakf0vDgwq88+NPavLRHuHm7Bsh3U=;
 b=CtREXXDLEz3804y3wQugb3e9mgBVuO9CR3NjXbMecgkMN4iMdOB3m8xhjb49Zsll8bQFdHHcaxSqxlRXovW5FI6C//MAISWokbnp0Z9omYOf7CZeuh3UFA1VcuTcB3MHYhs9F0JfGPHZUGijcfoc+l7GTepL4MKW3Kc5Bl/CZA4=
Received: from MN2PR12MB3198.namprd12.prod.outlook.com (2603:10b6:208:101::12)
 by MN2PR12MB2878.namprd12.prod.outlook.com (2603:10b6:208:aa::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 14:26:06 +0000
Received: from MN2PR12MB3198.namprd12.prod.outlook.com
 ([fe80::7506:7abd:8660:cbda]) by MN2PR12MB3198.namprd12.prod.outlook.com
 ([fe80::7506:7abd:8660:cbda%6]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 14:26:06 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "Zhang, Yifan1" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Fix the display corruption issue on
 Navi10
Thread-Topic: [PATCH] drm/amd/display: Fix the display corruption issue on
 Navi10
Thread-Index: AQHWp7XS6bB2g85Sl0umP1xATaVevqmiHHYg
Date: Wed, 21 Oct 2020 14:26:06 +0000
Message-ID: <MN2PR12MB3198C402B527C06BBD224A5D891C0@MN2PR12MB3198.namprd12.prod.outlook.com>
References: <20201021142351.71082-1-yifan1.zhang@amd.com>
In-Reply-To: <20201021142351.71082-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-21T14:24:57Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=6df385c8-0edd-4d0b-ab4c-97f573fe73e1;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a8821b89-cf78-4d3f-336d-08d875cd3f6f
x-ms-traffictypediagnostic: MN2PR12MB2878:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB28788F3B641F8E3FF239A1F5891C0@MN2PR12MB2878.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QBB566BOy4dNmovmRg4zGPJ9tEg9kcAKEpcwGKzsGeRbtgUSWJMVJlgbi4jAtb508uiNQe4esDnT+ExTWgb8GYIptFPja0rAox+X9WhHrLKxEegPEpDdksg8u5ZjMAY6ZVDxh8usxpxKRgDYsEDBwTgo7A/6ivdK71jkiRskDbL2QUeNOsanFpd+V2BLrVye0NAqsdHguyzye7AX/BhyOc3s5t3Ur9A6kyqAFnxo/XhjLe6iqPjHHMkkWG4usXZuxjK0lx9XT0HrFxCixW1ftwMp3lx/PiO2baBX7Td3Aj70hcvXiI2L+9T5BYMRKLWVL9x+bqjh++ZD+r4A9R+m8g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(54906003)(186003)(8936002)(316002)(55016002)(7696005)(110136005)(478600001)(6506007)(26005)(8676002)(53546011)(2906002)(86362001)(33656002)(9686003)(83380400001)(5660300002)(66946007)(64756008)(66476007)(66446008)(66556008)(76116006)(52536014)(71200400001)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: nSfCq19s2YSg6/KHS/ewHrdCAgq7lGE5OdLVuvGS8y8qwYhHV4ENwTsvox9cXfni+zHw+BTbxX/BylaU/saAhVNn6wD1geRbcdgySve7vj4btUFJhb6jMqpqfMUMGsK55irKAOEYiJOXbcieeXFQG4aB7sYQMbq9x79Hv6RWRAPAOTHjWsj3trk3fLzt1l5PHkb1zPTrTuMIMPCA1xkg0ts9/utQ1jgd4YCwi1gEwC5uzsGuvUa94jGNxnaHG2sBcU2ndXC8c/O3nx6p3U4c4FAF+M1LOVHXi7n0OiVXu/W76qgbDw3yKix7Rl1T9y5bGFJNhShxSUgxakmqHmH+I84WZLLg3GnW8DGlTpRo/Th+HB4oLAmpypH7z3DstI1eJmgrU6skNq+ixzkoRk6xL1+i2EscQjq2cycpN5H31Zrq4AtJBAIJi1LmqrmssUxEqz0XDrYGxRyEtEB4IK6wA8YwE03l+vmG9ym3e1Ch1bdvEq8w1YOFriWNPH0ibGhr0q8HiexjcPlE+1H9U9fpTguEdhbc5biXxs98pBz8WCb1QQ1T3KXPIhCJCmUSraM3IoCSjFXI7JmVspXoDhD7r4JmXFniwK9jYISiMfYkXO06iiLd70W6L8JhCCBR+9dvuztxRphO0OyoV+YsmCGFyQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8821b89-cf78-4d3f-336d-08d875cd3f6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 14:26:06.4513 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tkHM/QfM3gYIPeTqHLXzPNlEHYiD8lFI9WBHMDnr/wbpIjH2t03AtYcxu+JhTkTo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2878
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Zhang,
 Yifan1" <Yifan1.Zhang@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Roman Li <Roman.Li@amd.com>

-----Original Message-----
From: Yifan Zhang <yifan1.zhang@amd.com> 
Sent: Wednesday, October 21, 2020 10:24 AM
To: amd-gfx@lists.freedesktop.org
Cc: Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Li, Roman <Roman.Li@amd.com>; Zhang, Yifan1 <Yifan1.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amd/display: Fix the display corruption issue on Navi10

[Why]
Screen corruption on Navi10 card

[How]
Set system context in DCN only on Renoir

Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 71ecd963759e..ed0e7680b420 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1061,10 +1061,14 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	dc_hardware_init(adev->dm.dc);
 
-	mmhub_read_system_context(adev, &pa_config);
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+	if (adev->asic_type == CHIP_RENOIR) {
+		mmhub_read_system_context(adev, &pa_config);
 
-	// Call the DC init_memory func
-	dc_setup_system_context(adev->dm.dc, &pa_config);
+		// Call the DC init_memory func
+		dc_setup_system_context(adev->dm.dc, &pa_config);
+	}
+#endif
 
 	adev->dm.freesync_module = mod_freesync_create(adev->dm.dc);
 	if (!adev->dm.freesync_module) {
-- 
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
