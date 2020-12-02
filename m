Return-Path: <SRS0=1d7w=FG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0C2C64E7A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 02:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EC3221D7E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 02:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC3221D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC0526E99B;
	Wed,  2 Dec 2020 02:13:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D9AF6E99B
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Dec 2020 02:13:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M808XHLrtRr0y1Hej49fqzz/mWGk5qUdWGYChyNfrnMmlJAzLJE7em/NmragAPJcQW1YOLng3o/W2eJdvkegD1llJ28GAmGDJUdQKN6fQcYjWGFWzEaHSkJZMCmemsr6Va2NQTqk2MHtKViaSF7RnOA09XQ/N0AMAos1CHncBINflbNWab+Zcw3MbK+PkqFxktvFr7uj7sBQdNuCljtkPBcnrDHSU4kcyDH/c3kJ9xcfbZU0qKm8+zu3FaT7iyksiujZVi5X+WXl9EB1rlnXs+h00VuZAt8/iEsNkT3Uj/w971uqa7uB9W09yHfWGeyMqeJEP1FKWgrY1FuT/3FkBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=541+FlvNlKobxndgvwjn8p2p0W1TPUVjzdtqKaxu31E=;
 b=CbooK4ePNElLL0SllpDvFRgGVy+vGhjFiMuavNBvpbk9OOnlUJZ12nCXb8AifHlJO3NjAOdIiBCJCt09hUeOhT4OhZMcjmMxK0e8cEZf9UWtSDArbGztXbCBjsqJ+K+O94XlVBOdu5Yi8CdrS8uxr/y26zizyc+vqanggQVEhDK3eaGxGO5d7YKdnFU3VjyTdjbO3QpYs0wdiIeE2TXj+EjPLsjem7VeypmXFhRtZMQs5reT+kn8K319mk9qS/lrX6kPFczUjxrx4XxLoBRHUlkzu/J6h7NBtEDpAApB0uEsDVNKlR9hQTB+blAHOI/nGCy2oQFnMkDNWhEKXTbIdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=541+FlvNlKobxndgvwjn8p2p0W1TPUVjzdtqKaxu31E=;
 b=GurOTINaVhnCxyfayhP1oZ35KWkZGO7tiHsDRd27YUTmfZvv1O29iZAuIVK2syKGynvArrWvjYq7jT84Rclp5LHJAHUtS7E7Wscd+WNsVDK28IqZUbxD1Li8MpWrU4GnUeH1fNNo/nRE88larMF0tnfrxyYX95uQ9RoZrzzw+9E=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17; Wed, 2 Dec 2020 02:13:08 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3589.030; Wed, 2 Dec 2020
 02:13:08 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/5] drm/amdgpu/swsmu/vangogh: use metrics table for
 voltages
Thread-Topic: [PATCH 4/5] drm/amdgpu/swsmu/vangogh: use metrics table for
 voltages
Thread-Index: AQHWyAmg/eTQo+D6xkWqhYGTa3bF46njEEGA
Date: Wed, 2 Dec 2020 02:13:07 +0000
Message-ID: <DM6PR12MB26196EA2EB3E35E2D96BB421E4F30@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201201174413.643254-1-alexander.deucher@amd.com>
 <20201201174413.643254-4-alexander.deucher@amd.com>
In-Reply-To: <20201201174413.643254-4-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bc2a4bc7-1341-4d85-839c-baf08da01671;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-02T02:09:29Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ae38824-0e91-43c9-452f-08d89667cf8b
x-ms-traffictypediagnostic: DM6PR12MB4058:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB40580583837D46520F39AFDFE4F30@DM6PR12MB4058.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:418;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1pxrPdO1S7sOTxPutetGsM8Rn9UHNlVCToaq7Vp2fs4Z/G2W6OURWv1qx/nOCiMxWz7tZEayb9fyeZVrelxE0UYlIoNiTpd0nOLF1sPan25uGy5GrcPlZq7N1MwunKILofWTKz6jmtkXQ9OUK/YBLy1HruL9m3TVvT+y2rJvjyi8YJlpFzZ5zl6D7Nc5wTuhg86N7OsQKijUs5UhFy21mgreViDRV8NlO/SolrDlih+yQOLIJ0UtdDDipv89j8mKxanuRSlGXUlfJ4ISv4qCLSp4Qo4CTB0EKR+DVMxP4frDCdwiNT4gl1QkM66zMA3JnG7CXblfTIjtHRAHaPSDRcKlH5UhTvskTeKxiCECBFw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(39850400004)(396003)(346002)(52536014)(53546011)(966005)(6506007)(4326008)(86362001)(26005)(45080400002)(478600001)(186003)(5660300002)(2906002)(33656002)(8936002)(316002)(110136005)(8676002)(71200400001)(7696005)(76116006)(66476007)(64756008)(66446008)(9686003)(66556008)(66946007)(83380400001)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?p0StWVtaAvS2EVuqhTKkiTIA4ITv+cfBdA6owMSwABsKuyMOQQxLYHwZrnUS?=
 =?us-ascii?Q?JZE8Yxb/SCIwun21szy0YzJGUGFeBHENe8oUJ7ZAsnK95Ly/Fa6idx5Le+iu?=
 =?us-ascii?Q?hEJyCDDxIpDbY6oyCTwBm4JHbvRF8S8AGIt8iP0e+aiFR0/gHD2I/2aQJQYq?=
 =?us-ascii?Q?8OT+1EfAx1zOOFFy/+VCwsRHJQPxTxfWAfBVJM09kqv80mWpFfTLG7LONeAm?=
 =?us-ascii?Q?X7PJbYnmTEl3CNTwMhKLwxxDBH+eIo9yOgJcQDCWivpXOLXaV55gzUGu9G5j?=
 =?us-ascii?Q?ye+DX5NsLPZeNE13FTKTUdq0zv+i0IU07LI1/UZAqgALYiXoKQRY+odm1+vA?=
 =?us-ascii?Q?kl5Pe8HaSXGx6oM9A3w5E3JQRs3Qt5qxK1ioPuh6J0f2Qu6LvOGCQyxgeptk?=
 =?us-ascii?Q?NItfTsdINX2+VeTw8lIHv1Jyd6WcSRoOP2wEGV2q+/k2hXrcKKaWJoT9kyHq?=
 =?us-ascii?Q?upxy97C6Cdv8h+zfTwKDwEjna7hd1Cg74qOXucU2ic44r91uxneKKFIfdKhp?=
 =?us-ascii?Q?XiAu6FBreVMw6dYPJAut/v/OqW+XwvDve+rc5N5xZwQWW/uquY3Gck359/61?=
 =?us-ascii?Q?OSjsGNdkd0a8wj+7GWGPpZlrIkwrYpfnzj/YCbP80g8OxYidGds42eGULGbz?=
 =?us-ascii?Q?8RzggIaf6TLXxMLPmqAVVuAoewnIiU5x05H0UGr6EWL7NMV8ns4A+Wil5QSV?=
 =?us-ascii?Q?nnWvml/IYH/HXos3XUEJD/4QoYwChilLBeDFcVPnplA1q4b2GofFP0Wk7e5p?=
 =?us-ascii?Q?Q4Jm9zWhA3BUfUoTP+B1VXCdFa9TRnVcZzJRSOntr4E5lO93KcDeVm93q2a/?=
 =?us-ascii?Q?21FyF6IRi+HxmUnrlJ9kxrZaOM6/i/eoY/ZlFU37nAbjmhM+4g5H0wbFAvZk?=
 =?us-ascii?Q?GRdJmo12+hpnd9QBVIrQNS6i5eFxX4MfwMjgiHRT+yuO+wYJcpZ6y1vt5buA?=
 =?us-ascii?Q?DuZXCR39AIaP2fYf9DGFZrPgsbNokuzL2JIe6e9e/YM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae38824-0e91-43c9-452f-08d89667cf8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 02:13:08.0075 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5nJm1ZMatwuCHWZJz28tBCyhOYuw+VxzAgPzod6oXRPSnyTQ6ZPAl6ZFurbPg481
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
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

[AMD Official Use Only - Internal Distribution Only]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, December 2, 2020 1:44 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 4/5] drm/amdgpu/swsmu/vangogh: use metrics table for voltages

Fixes voltage reading for vddgfx and adds support for vddsoc.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 1645509cdab8..3bc7395c5fb7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -265,6 +265,12 @@ static int vangogh_get_smu_metrics_data(struct smu_context *smu,
 case METRICS_THROTTLER_STATUS:
 *value = metrics->ThrottlerStatus;
 break;
+case METRICS_TEMPERATURE_VRGFX:
[Quan, Evan] "METRICS_TEMPERATURE_VRGFX" is not proper to use here. A new macro like "METRICS_VDDGFX" is recommended.
+*value = metrics->Voltage[2];
+break;
+case METRICS_TEMPERATURE_VRSOC:
[Quan, Evan] A new macro like "METRICS_VDDNB" or "METRICS_VDDSOC" is recommended.
+*value = metrics->Voltage[1];
+break;
 default:
 *value = UINT_MAX;
 break;
@@ -469,13 +475,21 @@ static int vangogh_read_sensor(struct smu_context *smu,
 break;
 case AMDGPU_PP_SENSOR_GFX_SCLK:
 ret = vangogh_get_smu_metrics_data(smu,
-    METRICS_AVERAGE_GFXCLK,
-    (uint32_t *)data);
+   METRICS_AVERAGE_GFXCLK,
+   (uint32_t *)data);
 *(uint32_t *)data *= 100;
 *size = 4;
 break;
 case AMDGPU_PP_SENSOR_VDDGFX:
-ret = smu_v11_0_get_gfx_vdd(smu, (uint32_t *)data);
+ret = vangogh_get_smu_metrics_data(smu,
+   METRICS_TEMPERATURE_VRGFX,
+   (uint32_t *)data);
+*size = 4;
+break;
+case AMDGPU_PP_SENSOR_VDDNB:
+ret = vangogh_get_smu_metrics_data(smu,
+   METRICS_TEMPERATURE_VRSOC,
+   (uint32_t *)data);
 *size = 4;
 break;
 default:
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C3084bf7338b747344a0e08d89620c0d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637424414710951019%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=2af8UhjkqHLS3gSRl0HEb87RGLPPHfwSoqKdO%2Bu2xHU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
