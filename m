Return-Path: <SRS0=LN+i=D3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B6EC433E7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 09:30:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 390D8222C8
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 09:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="r7rgDfom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390D8222C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FDE66E11F;
	Tue, 20 Oct 2020 09:30:19 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam04on061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe4e::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCF0C6EC19
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2020 09:30:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aq3A20v8XL1yd5DcVE7loenNx3XUinTArT4pQTvnx0iOEuoHEe9f6u0qA9Bshb/gtjOsgwXwS24miANq76m9rlSEQ8mbDtM5IaidjzO/FqMUR1ECKSuMQtgqkd1XtzeD2KkVvxdfY38UtH4rs1dTIjfuAaPkBlnIlj3jwMXDoyjoULeAN5cef9ct8ejc9fTFfrmr92PnPx1hUmTExmuVHLU7Y3A3+Sx0QbPZy0cgIK5Yb7iqmsnhXokXbtXdAbEVK0s9JKotyALMgNKbUm3aBOv+Hsdz7MC6Q+/nSXRtUoad7ltsH6jaPJCpP5spo+yQhYJfUtT97LKkyEx4d19oIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcfnZaA7xY1yhjEcSaPe99C3PxkIb4YF+1xalKBdMKw=;
 b=cOdXAgxIh4QThyq25LKCUDTTMFIWdIfb+YOwoc62lWy1jgXc9tMD29guZWH7rzBvXlhqXxv6izESjzZHfrG1D5gMCtrd02kBpnTEgflea63pyHoXQqx7v7NN1ivGUEiDjzW1WaA/CijK93qUI6LJNhFOV6nJ4MDahnqrka2HV3LUyTMUJ3nfRPY1MRa638y4+89VxVNA5j0qQ/SeyUl4xMf2vJDvLo95v9Kb0tD4aSddagsmhr6fgpJ8nNih6Dx0mZwp4ibwGXixE/u9HJkuzwb0bl4VLoMHSjdDJdJE2ugimjZ4D9lqjN9Du6rhT3QqgLNOsFpi6DaetJd/U8u3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcfnZaA7xY1yhjEcSaPe99C3PxkIb4YF+1xalKBdMKw=;
 b=r7rgDfom5kxwqhPPezxSq9pm9yIs/fc+VRKw+NOjGjPhRFwPylxuvCjVgzt6XR9RwI4XwsnJj7IZIGqtcpShMY1Zpq/gjMeo5JEaaai8MZvEI1BAlOHvBIV+c5w4t2imIPdHhGy3FdkatKyGdElPOMwa1IQ5hqIum8qr8r2Yi04=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Tue, 20 Oct 2020 09:28:23 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 09:28:23 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: fix pcie information for sienna cichlid
Thread-Topic: [PATCH] drm/amd/pm: fix pcie information for sienna cichlid
Thread-Index: AQHWpr8DBMj0C04VREyEEKGH7oE7YamgORVw
Date: Tue, 20 Oct 2020 09:28:23 +0000
Message-ID: <DM6PR12MB40750982C99EC61822E32FB4FC1F0@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20201020085658.654678-1-likun.gao@amd.com>
In-Reply-To: <20201020085658.654678-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-20T09:28:19Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=0a6f47a2-a5ba-4cac-ab46-0000afdb30d9;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-20T09:28:13Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 353713f0-4524-48e9-8d95-00002f19b5ed
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-20T09:28:20Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 20ec4416-6900-4e76-a83a-0000eb8b7aaa
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 424b39cd-64ce-4756-2a2c-08d874da7dbf
x-ms-traffictypediagnostic: DM6PR12MB4435:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4435177CA35EC82B5BE133D4FC1F0@DM6PR12MB4435.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:229;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mWYhzc6El6taLGfPpMisyQezRP0xVwvNRp5p6BoVEk4VvzKJPWvS8Zx0Mae4M1ii1CeoWxspN7fG9RXlECtlxcz09ryM4P4J40QESbuIXfqoM/GvI8tTOydUVn1RDJfcfEBf97jKvP64+X2+BUFNNQKObdo0A/L11mV0fRfbN/yglbRgOONrDW/SETvX5zMOf7JNAnm5jGBmS5wmBB7rEuvUD7ss+75lZKqLY3L2zJyTBxYJm5NAAe+s/gQFOESEQYWN3/57w3W7Q4o+egt0PMdPm0i44oxSdAn4M5YnSXJ/6yn6Pv1XFH2JKP5Kynbo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(110136005)(316002)(478600001)(7696005)(186003)(86362001)(26005)(6506007)(53546011)(8676002)(8936002)(33656002)(55016002)(2906002)(4326008)(9686003)(83380400001)(5660300002)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(52536014)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 25OHyI79eQbBcsvYSpPGGgPe/cdis8tvCtWRIrH36A7W3xgZTuJ6zjJqsg3sqDvipfvo5Q+ZvYYeTmZ3Vworc4gu24iOJ3rpT9T1lL4fcKej6/W80g8uTKbPxVK3wXZDwaffGTc3n3WghCpnVCuVvkDNSP5gh+qJKTcjZTCrCHd3vO4UUv3WDRxXZ3grUaauVVojXvSfrsnukJLNR9t/kPl4NhHcUF9MIWiXqYNtsDIVUDPIWid2ZEMrALt+97sUVJlXDJCB841HTFRViSkygraM+8Z83NFUarOXNBifGmR/7p163rwG29gCrEFY32Z9yibBBtHqM5DFCG/8KCq2BkHnrkzYFvKEA0QqNnJ2hvTvTicmDxHo1dOnrHXvoSuks/iF/UYqSnBm+Y2APSgqF0XdvT1cpzKJu76VUdf/+JdOIAKL9YH+otg35BPENhEjwRFyvAJRtcN3dr/faYTm23RRE9WTTEX5O+aYUAxvEs0NVrPG5y5jCZDwq+uvFZ3qCPb4retNIwfRyRV2/8DIZbLSHEZHjn8874jVlH8zv5FKPrw56eHRZ0F1aaxgkYMC7tVvMseSzy0nUCpadvcn6vFh5uy7GYDIjY7Eo3369eXsztzEuImfKzxRBxUvjN8RhOo4H+AW47DK2e1XzACKjA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424b39cd-64ce-4756-2a2c-08d874da7dbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2020 09:28:23.2520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bSs5UDl6kfu3EEaVQ6mad1GIWniC1miSJ14Z3o9R/mOoFdFSClTtmO9Efpt9SY0TuU5CKE3dQMEgFijvkXeYIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Tuesday, October 20, 2020 16:57
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amd/pm: fix pcie information for sienna cichlid

From: Likun Gao <Likun.Gao@amd.com>

Fix the function used for sienna cichlid to get correct PCIE information by pp_dpm_pcie.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I81e529be6e96f083eb7aa244c16700422bde5fec
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index c8e8790e0871..e00c38b1bd41 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -964,8 +964,8 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		}
 		break;
 	case SMU_PCIE:
-		gen_speed = smu_v11_0_get_current_pcie_link_speed(smu);
-		lane_width = smu_v11_0_get_current_pcie_link_width(smu);
+		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
+		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
 		for (i = 0; i < NUM_LINK_LEVELS; i++)
 			size += sprintf(buf + size, "%d: %s %s %dMhz %s\n", i,
 					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 0) ? "2.5GT/s," :
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
