Return-Path: <SRS0=8Fgq=FS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6C8C4361B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 06:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389DC22527
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 06:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389DC22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60FFB892C0;
	Mon, 14 Dec 2020 06:27:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80DE8892C0
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 06:27:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gD3MDHC5JokuQcbY82OeWVGMkKLYMEFtkimBI3/lM/gtrgA+qVs2UBiwhns0qtdamRhF4hFNxKugEdtNFnCqFAfJNpUNi/MVScvwXQF5LQPQb7esq8OAJvaVErmD8JC7LXB1c3LkyggTtsLypnFmkGMOpxhqytvmJataXfdtA+wKdYy+fuhsr8d1vz+DRY92R1LrFzL7iaoGqS797wsUuOLDP+ysSC44JbE92Zp7TZ1RVBMQH7IaMA8W+seRB2Mh8uBsSKh+SuTZ1i+R2JgxepZhGtucKKpCOlklTqIE3a5+nL9e1csR36etXayLgMZRqZ4wsAbqLLXB/KnwY66e+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqRhN9KJlBto0KftNyW4ccFFrZA3WLSoKAagL71Ac1M=;
 b=nLTnHd3zkHrPED0lkRB8MCiwt/WfH8DsbAA+Q/zkfC/K5loUphUEEKYdvNdI9LZodab/wJlEtLsNs2Xuh3k/gTWV3u0C0EG/8Jnlb797vJTAaTbKi3T63zsbC5BL1J03eTt9uksL2EiXytAf2/S4nYK+GQFOu/37CZ9sChQwOsh4Dh5QsdBU6H+WtDUjgIVAPKBSb22ylT3yQH5AWyvs0vwSLd+I/EhBfQVLJOfAbWxtqKbMnvbsh9MuiGLJnnm+MiD+X7xvxT/etYiGQ27Q1hY4N+1vxZu8B5XVFuyVdXooZ9pY+Zo3VfQj8K2lDfkWh6oxLc9cYCOoNiY3Z0eHQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqRhN9KJlBto0KftNyW4ccFFrZA3WLSoKAagL71Ac1M=;
 b=a1b+Nbb7fWrh20/VVJ0XVmEnxcyuzO12fw3rP6iA4ZPDGHDsS4fN/Kb2mkmvMEeDHzjgm3HIIJm6I3q+6HmWrQSYPkfW0FQl/V2WikqQOo5uDmjRqJ6EYfrFtbgQVtYY59J7MI8SVViRhRMdMVJ1sMbg3U/Anl7A3NtFs4Eban0=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1413.namprd12.prod.outlook.com (2603:10b6:903:39::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.21; Mon, 14 Dec
 2020 06:26:59 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2%12]) with mapi id 15.20.3654.025; Mon, 14 Dec 2020
 06:26:59 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Cui, Flora" <Flora.Cui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: drop retired CONFIG_DRM_AMD_DC_DCN3_0
Thread-Topic: [PATCH] drm/amd/display: drop retired CONFIG_DRM_AMD_DC_DCN3_0
Thread-Index: AQHW0cFMvjJBiWP7wU+rrRt1rN8Woqn2IJ0w
Date: Mon, 14 Dec 2020 06:26:59 +0000
Message-ID: <CY4PR12MB12870DAF55C5D05DBB478517F1C70@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20201214023126.61332-1-flora.cui@amd.com>
In-Reply-To: <20201214023126.61332-1-flora.cui@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-14T06:26:34Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=073746d0-ecc2-44db-9e0c-0000ca2c5625;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-14T06:26:57Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 24d5d164-44d6-491d-8d3f-000030ddbc46
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8090b44-ab3a-4377-c653-08d89ff94356
x-ms-traffictypediagnostic: CY4PR12MB1413:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB141353E77F76EC436EFA8666F1C70@CY4PR12MB1413.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y4U43X15SG8waqKm1gDxwUIpY4a5yqgcOzGJJEfMNsXvY1G8I9ltALRy06jp9o1rgDfcvK28YSWE8/gJ0qSOWWbE5VUk/2f96bis9ayGRptCAiellLpaNT0CutVjpfsM0QfBMx/qsQ8Js5UMhDVhy+2wDHG3I7rxdaHELj8yCPfDfBDeEKUwqfZPpo6cIr7bXZ3eMYAjUS7hIj6pfhrOYjoaJQMVMpJvS9/vfNjh2uyqSrcH0uVYjd/8ENWGZ1sDCIBHxUwWeA0BSpPR/2gYinfPlJVuLvghovT9gv1qF4dqyJpZMc6E2Pk2vUrQKZaVO9rfYs/CpbkeDA4sNaTYz7B1dhDbuOfgiAniyZF485U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(376002)(45080400002)(26005)(186003)(966005)(4326008)(86362001)(76116006)(7696005)(83380400001)(6506007)(110136005)(508600001)(66446008)(55016002)(71200400001)(5660300002)(53546011)(8936002)(9686003)(66946007)(33656002)(64756008)(66476007)(66556008)(2906002)(52536014)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Zemq025QdcDWNhbJlqcaFjhCskJ2Swb38wYg8v46kfgpc1I5VFp0Gv5j+0ur?=
 =?us-ascii?Q?IZKvHWr6X37qfIbTWfzX8ksrYtZvGrTFncCmjIJ/AaCTN+VqlznkObwNJEeu?=
 =?us-ascii?Q?aHShKnIW4oxEwYs9716vrqGUPgUBHTlYS07eaxRg6uMQCHpnHhBglyybxaM4?=
 =?us-ascii?Q?Byzl9e0sqeVvGH77hjgWPQgjh61lQc9SJJVov68vN3JkooOLcE8xBtANIwUQ?=
 =?us-ascii?Q?jHF7zl3eygQEcZI2nNKCcsS5ov4gg/bdKNJ+SBSuTFsNuhEQAlcJkltkjlAC?=
 =?us-ascii?Q?Mif5C7pWV56T0pP0GKBXxaoUC/7L5rxSiNWt2Xmdf88onCa/4ss+pvtxNiru?=
 =?us-ascii?Q?REzrYDFkMR2sAFsXhANBtQGfCDT4QkpAl/DTWZh1rmF00qbnLF7UFEbxwyIG?=
 =?us-ascii?Q?wBMAzGApPKAkQYzgNPXrFHU20qH3YbtQddOnNQuIlYGRHD2qw1o+Mf0wyb0w?=
 =?us-ascii?Q?oG0MJEtpTs2fFR9lMfMznxPwJox0izx9hLKP8H1C6gd5GSUXgdpFg9D29HkL?=
 =?us-ascii?Q?TeAyY47kFNUXJW4BoK3qKDPjAIgaNZKFR2gW8bx74gpc592ekpqsLhJeNH/K?=
 =?us-ascii?Q?Ncj59hZ96i4JYkE7YtjDTGmRfejC+p+XQxnxk6sLIrjE5FF4Q02kYPplVMUT?=
 =?us-ascii?Q?q3WWmd7J+WRxIT8LR0YGABs3IKGY15EN2EHsRWTbBLJ4/HSM5lZ3yCjVUfK+?=
 =?us-ascii?Q?JRzi/MM18m8bqW7/x75ZDoSWqHW9FCeQYBrWgYds1769AJK1sQTF6Lyl743G?=
 =?us-ascii?Q?8eqyPnF+5rBIhRzQLn08v2sblUPIF8LDgFtALTwjIEaDIJUBOKz5116VHp/J?=
 =?us-ascii?Q?E15aWIbYGJLJfGPw1yU8B+HFsaFODUNTKk0ftIF3ApjNRskZyUDn8CtxuLmF?=
 =?us-ascii?Q?Zh2iHmwRx60x2veAf5n7loWiUFljESy3q/hk+29dhLD2SPj2f0W7ITcXsS9Q?=
 =?us-ascii?Q?ghUfEKcqcr1mY9vP4GhJEm4WV9HGdd2rz5Qntn5AWdQ=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8090b44-ab3a-4377-c653-08d89ff94356
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2020 06:26:59.7588 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /jM7BKSO5/XRtgP0iQ2X62II6t38EZxaJLr0X9WMErPTrUmn+97HMgvCzZZoOPWPO3xYQ+336p2PhP6RN+wMbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1413
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
Sent: Monday, December 14, 2020 10:31 AM
To: amd-gfx@lists.freedesktop.org
Cc: Cui, Flora <Flora.Cui@amd.com>
Subject: [PATCH] drm/amd/display: drop retired CONFIG_DRM_AMD_DC_DCN3_0

CONFIG_DRM_AMD_DC_DCN3_0 is retired. drop it

Signed-off-by: Flora Cui <flora.cui@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index a901baf2aaef..9e1071b2181f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3267,9 +3267,6 @@ void core_link_enable_stream(
 			}
 		}
 
-#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
-#endif
-
 		/* turn off otg test pattern if enable */
 		if (pipe_ctx->stream_res.tg->funcs->set_test_pattern)
 			pipe_ctx->stream_res.tg->funcs->set_test_pattern(pipe_ctx->stream_res.tg,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C442430f67b47499be68408d89fd86ded%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637435099198073879%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ttkVMHlVTdLjXg3hnQWaeZj7RhewfzsjMhb7YJi1qqI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
