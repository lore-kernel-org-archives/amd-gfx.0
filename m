Return-Path: <SRS0=AWwP=FV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48847C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 03:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E950220866
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 03:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E950220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CE358994A;
	Thu, 17 Dec 2020 03:45:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 241418994A
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Dec 2020 03:45:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AifTQ3Bxdapqko9nXQnBlbnCl4vcQGkJLpPV0mP+DJ2r9oPF0itRdlfI4iWNuNYrGpeUyHqQu/310hNc0CYGdRXjEAthZNYbHg9K/FYFVKNZOhtM6z/MZ4Y55J11mjVJ6XmwcyvzK4xpuaIm+AqVzUE6ZnAgqYUvcXXCBBV7Yw5WJt35KL7U07/8XrNMd4GyPRtdyLaQP8XeRbdHYdhkGK2+2fgPobxZSHeVQIbhkqTcRxe1zC0qk0YwmhZDyt0vEWbiE+1Zb8emEmu+AaoZ8n/RXImxYb1Cue3HCsz58JUe7VACS1Co4ArNzwiUPP/mtsHe6KSPn8A5Sm6nyvZ2Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlEkmFZvEQ15onpm1vnYPzuBLo1WmDEORruc90Pb94s=;
 b=LvZqj1RQ+tsA4U47wOfYWG6L1BnDiQhgYjAsViWcswDxYw2o5PE3THlXLbSQnL+MGauIpZDfVMuYmz+f3X81GoGlGfDhsK8v44991mksqosrx3W0h2hBzPXjO60I0GWiJylkck9huVMXuXt8omYuBYlqM1g07noK/va50VGb/tpTSXDyphJHQMnxwPiwrnwpcOhH9a2BRea01mXm0KYrLFzUn5KiWpgeiX9YgqVAvy4xcnYU9AWkC/VmuEDnk/aoRWl4tpgeJn4/s/27zY7lsYvOYZs1gfI01OJk5pnlan4oUmiV1/6u6QfkoYz7c9Tox59HYvIcIVtqGoWPAf/tQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlEkmFZvEQ15onpm1vnYPzuBLo1WmDEORruc90Pb94s=;
 b=MahN3gArtLeCy/FoTK7NZJHuQgcOXtv5ktW3moe6gQECpvwQxzhuErzdyaMWR8OXGZ9heusKuJeqkET+yOitXcvTZ59y4XHg5AEu5hbLdNdsSNA6hSjk1u/W95ySxCuXD2F0SbbobMf5wz5vrXmj48t/BkufcoqG8lm9LUPgZeI=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0040.namprd12.prod.outlook.com (2603:10b6:910:1b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Thu, 17 Dec
 2020 03:45:35 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2%12]) with mapi id 15.20.3654.025; Thu, 17 Dec 2020
 03:45:35 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix vbios reservarion handling on SR-IOV
Thread-Topic: [PATCH] drm/amdgpu: fix vbios reservarion handling on SR-IOV
Thread-Index: AQHW08nE1vRseIAXS0aphKm1GPExJan6pjQw
Date: Thu, 17 Dec 2020 03:45:35 +0000
Message-ID: <CY4PR12MB1287149665C51E42530AA733F1C40@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20201216163721.2432665-1-alexander.deucher@amd.com>
In-Reply-To: <20201216163721.2432665-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-17T03:45:24Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=7258f764-fe29-4bd3-a2a4-0000fb6cc15c;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-17T03:45:32Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: e2f0b454-f6f8-4159-9275-0000504096c5
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae1bf77f-f9b5-4c9b-7b0e-08d8a23e361d
x-ms-traffictypediagnostic: CY4PR1201MB0040:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0040E158A97710427CA40F79F1C40@CY4PR1201MB0040.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hpxrD1RPW8+cGpJbsmWfLqSgJ2rkESURnvtKgs5+F1xhLX5rjIan+BB15kB7XrXrXlhwxpy9dwWzfDEfZCXeoy1sYI1PPVdYRD453DlHkMoQeCc7hjfT/NgkEtk9VTl2hKqKw0z6r+RA49ya2OKXbQMXS6rYvy1j2+fgPwA1d+B0nPsyYOj68tdhSklKkMS+trnZ25gI+fSupg0GxAOFKWyFFZuyJn5JVtXqvHy2o6KHsY5hg5HmZ5PsYmuE4r02TCJzJyH6Si4PPJ9gH8tVkdWo986Bx9R/833h0G0l3Ey+PsX1Nu4cEm3mMpMp8iOvZc5QLvQ/mHKHYzhiHer0O8aruYHKXzaHgFrWxvTXdrQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(8676002)(66946007)(7696005)(66446008)(71200400001)(316002)(8936002)(2906002)(64756008)(5660300002)(9686003)(6506007)(52536014)(55016002)(478600001)(966005)(45080400002)(26005)(86362001)(110136005)(33656002)(4326008)(66476007)(76116006)(53546011)(66556008)(83380400001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AwgpRADKcTxzKrbaipoiJ0nPzGQZX/3AVD34frbhQufQir/VUyr5qN4ChFnM?=
 =?us-ascii?Q?lPYDRtcOCTDoKQlPU6gOC3p0Vu/T4NrCov4uP4tO/gcHDsR6dY/4HR1g9lws?=
 =?us-ascii?Q?ZSTkk4/ttybm+Fse0IMhY0sYxh/salrgoOx8FeqGo4ObpglCMJL4B1a5tqBU?=
 =?us-ascii?Q?bHWW9lfMpnMQ9jC6d5WiueMT1N/2mAOkEGmz3nArr3R1Zzbih/pynmwqilh5?=
 =?us-ascii?Q?0en/IM99p5anG2Z2DKwvMcErw1NFyGSKDLf4boQ5ckm+muMzFZSsB2Jm07Fq?=
 =?us-ascii?Q?jpo2pyg2hsslXQQ2hbbvwu1n5qr87a71Tdx5JHaT8RouJxY+QDLmoCfR/vq5?=
 =?us-ascii?Q?ibmTQL96p06kqJAChUNSTqb0qjY9o7Qerh63sed6LPxvV6Cc1YX5JvCr7K+t?=
 =?us-ascii?Q?WlXzThdj8hWkmYahoxBwv/UVa6KoPOhz4DezNt50K4H/RET7cEXb3Vsa+/Ft?=
 =?us-ascii?Q?7xyuG8h6Ru5Y4AQMYDBImEIuOiqTmDVYAhR7GnfmRjgZH3Ln09ai8/xmmT4n?=
 =?us-ascii?Q?zhuUfvgTAUrNUZCK8cRxjoDXPpMhWblYNIEowloM/QMhtymhp4BAXetY/hgB?=
 =?us-ascii?Q?Vn+J85YKk0HFrKfGeShlmV/h1rQLDjruyOQ+CeVhPpO4m4yhkYr/wI0RFccI?=
 =?us-ascii?Q?iS7E+Fpxc+lk0gGB+gEw7UuXqnpGfZGbQPqL7KYhw5LegQcghUAFXtH6V0Gv?=
 =?us-ascii?Q?Zt36Y/i0gvwcUCp8HOyh/XxfNDIOwSPNzGbqmbZbc2OiqJf6feYSSVaOBLpN?=
 =?us-ascii?Q?7HTYMGIXdZwAMSb6GD8XZ59hGXvlTT7HC+WmoO3TA0Q0Nw7XkH0Jq5YGB1R0?=
 =?us-ascii?Q?Yuc/2qmu+JFeBDDVHT5CyJ+8b+UyqPljTXsYRk5x5o4q4nsdrhlSE/qJ8vai?=
 =?us-ascii?Q?XeLHrRFN9ylwgRjnygTn/HsCfmepmM+C7rSj9hsXVDbHCo9kjl0VPb6EJmTr?=
 =?us-ascii?Q?/qFS5UmJaORgk2GkQUOiIkC2GwYz9uVDWqJ+v4rKwl8TBjGePPQHfrpmOQmy?=
 =?us-ascii?Q?SlLj?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1bf77f-f9b5-4c9b-7b0e-08d8a23e361d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2020 03:45:35.1489 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwStjAVTunh1q5iWRhcc94w8xX34RtXGphi381KRHgYODC2ZnP+bQ49sHXKsed3zMteUzn7FDMhM/h/WKzjVFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0040
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

One spelling error in subject, s/reservarion/reservation.

With above fixed, the patch is: Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, December 17, 2020 12:37 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix vbios reservarion handling on SR-IOV

There is no reserveration so set the size to 0.  Fixes a regression on SR-IOV.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c2ced5be6d7b..6e679db5e46f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -496,7 +496,8 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 		break;
 	}
 
-	if (!amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_DCE)) {
+	if (amdgpu_sriov_vf(adev) ||
+	    !amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_DCE)) {
 		size = 0;
 	} else {
 		size = amdgpu_gmc_get_vbios_fb_size(adev);
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C6a29df61c908426931e608d8a1e0e645%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637437334598593578%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=6xb%2Fire6Cq8HtaSoHRL9C1GGhlrKP1mL00x9wElqYuw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
