Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6EEC4361B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 12:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0EAE23C15
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 12:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0EAE23C15
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EF196EA17;
	Wed,  9 Dec 2020 12:27:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D90056E134
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 12:26:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZRQh8R+LswGDGe/G17SBgPW6TWDRCouW9Iz5bMw8m3g9cW9PDC+TiVQG6DmFS+Oc6Cbvd5VOyg/uxrG4NRYDwhFQqDCHA8ysL8BE1qJLUNqhStzAiOH+ggoqZphN+MSgOF0uhnu5Vc4ePdCPP17gPuLlEPh9uIRcO1dmwGnMSaPAfY22YrVIV05cR1ms0IldSkqTViApC+H5Wy99IJCMGIs0x5pERFwcKv9FTn2pKcaugGTeDjVWo2Tuf6kDV2E1fZgHZc1Gm0riAK/wVi36hxWupYGViEHdB/LmsS0SX9RcSPm0o0oUdkIV2IK3v9Hsg9CfT002lXNlI+trMCn/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ry6OS6Yl5hfIDrB6JTLKLuo+0Wo0wc6/fXCvBY5gOZ0=;
 b=adQzsYFgIe7ELxnbDgTrNd86YTNYsDaK/vknAy8esj5RMjy1voky2VXABP6CcVbyL0ArsU4HC4OF2h2camKHm0l1KzPkEeTKyCiyvAOTN5m6Zxt1Y8ZNHk2wXcmdDVpTIqWDLOCEwwllC9AhU6J2CH+VGLpW4rTIoYZC4NIbTNCPUy9+h4wporXgo6ZlXohjsrszIE7hNz6LcoTKXJxiIIMmClvN/RJdaV5xuAfTg4V+7bu7ky6CPVtQKQu6VC6ZbIUrlrT5pbrFpv/KHUXH4ctZWNXRkq86iBULu1Xd87a7ZbNysOKuHWTJqLyku71CBSUequmL1P0sN/HmNhQpBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ry6OS6Yl5hfIDrB6JTLKLuo+0Wo0wc6/fXCvBY5gOZ0=;
 b=0R+a5ccNKn5KfgQXk0LwXpvt5OJzZ5G/1jumsZYyjjE9MU7K8pSDPr4oUHh7+ikJXxpk7sAqkuCS7bAYKXa4I7bjVXBl6uAWXptRUvYQIGE49oaxSJ4onkrL+4CP1V5SIk83seA/Qq40MIo1K8otMsqtLZYjLu/Ds9NmRc3kmSY=
Received: from BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20)
 by BL0PR12MB2451.namprd12.prod.outlook.com (2603:10b6:207:4e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Wed, 9 Dec
 2020 12:26:56 +0000
Received: from BL0PR12MB4913.namprd12.prod.outlook.com
 ([fe80::4112:ac5:8125:7c05]) by BL0PR12MB4913.namprd12.prod.outlook.com
 ([fe80::4112:ac5:8125:7c05%2]) with mapi id 15.20.3632.021; Wed, 9 Dec 2020
 12:26:56 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amd/pm: fulfill sienna cichlid 2nd usb2.0 port
 workaround
Thread-Topic: [PATCH 5/5] drm/amd/pm: fulfill sienna cichlid 2nd usb2.0 port
 workaround
Thread-Index: AQHWzeJzsq7kQFiN70uO1Y8ZI671GqnusPCg
Date: Wed, 9 Dec 2020 12:26:56 +0000
Message-ID: <BL0PR12MB49132D9521F5405BCBF5FC1197CC0@BL0PR12MB4913.namprd12.prod.outlook.com>
References: <20201209041836.143264-1-evan.quan@amd.com>
 <20201209041836.143264-5-evan.quan@amd.com>
In-Reply-To: <20201209041836.143264-5-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-09T12:25:56Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=85194420-e037-445f-a6f3-0000b370b83b;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-09T12:26:53Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 575070b0-c181-4b8f-a480-0000aeb2a958
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.198.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6e1236a2-9bd0-4067-8871-08d89c3db7fa
x-ms-traffictypediagnostic: BL0PR12MB2451:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2451A4BDDD209E641F7B988097CC0@BL0PR12MB2451.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8NMwW+o+E8qKOc2tRpY5to+FqFoGQC2KW4R7kpY7tLE6exGdCDbMXp9iy5Av+JFLLmTNXk6E6+DrTe45ti/v/7tEFGEu5Ej5AahBkuN/zogyx+Atqd3izgsH9es5YYJvvxXwb+oU9jjGWkW2dE+as5rg2cFRc93GLmNg1eLWi2BWZ8mUCKuYqI4jPgk0Y3IF/dqIE8wjTNzvYZKfpDuttN02bQ+gLzCGswyNzX4KTT42arZT5s0+WPMKmy8qZ7DNhtHr6wvBy8y5R+jodPUjh5OX2rsWbTdR5WWEmDFIwrdhhOlIOAehFpe5feC7IAGuHaSXCijet452cg9M6R0igQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4913.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(136003)(86362001)(9686003)(4326008)(83380400001)(5660300002)(110136005)(186003)(8676002)(2906002)(55016002)(71200400001)(33656002)(52536014)(64756008)(66556008)(66476007)(7696005)(508600001)(66446008)(66946007)(8936002)(6506007)(26005)(53546011)(55236004)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+v6VC/aIJjb/FH2atrLRYOBoeA/d8P4FPRGhkx+ZnRRlLP+TMSB4Jp9Foh1m?=
 =?us-ascii?Q?5n/NQbev+5JOPdSekSas97EOAsoAlMvf+jDk4Hb+4ZLNbfoaVXu4NrBqGGiM?=
 =?us-ascii?Q?j3PnkDhfplC/pTaB0BnWNd8PPB8TeNw+Sw3bKEXjJ3oPL5WYzujogeh4tHRq?=
 =?us-ascii?Q?5bczbfAhGtZ47G92TUCb28xLtFTmRBFnp6uHY1RdK4+xavvqBa7kAbqmMhAb?=
 =?us-ascii?Q?YgTl+o+K5aFk9SiCObvwvoL0hNm4zl1VCYCUUamMd5M42F3jVqbuvn5ddbGE?=
 =?us-ascii?Q?O2HcOmbAJzWp3/cdGB28KQvIrzy4cPBk05nlaLSBSkdxjC3CRX8TK/QQ9HQP?=
 =?us-ascii?Q?yfYD2XEzi/MwFNbb9B4MB7+Uc4Ux8uVpvBdX1VtjA1I0K9pGRJc8HM5wmY3r?=
 =?us-ascii?Q?HA6Mmn4YGgulNlONOje5dqiD8Q0ly4afQNE6Eo3YeyfAj8vJxz7EOdoXgg7h?=
 =?us-ascii?Q?Fbs1f2e6VpW33yM32LZ8Z+DTMHHAXdwkjRP9sQKwHDTGkg804E2FlfTo+7B9?=
 =?us-ascii?Q?Zguy60pKgCU0KYGjTKYFfIkXfYKf0V9B3SfeeI0fL9T19iWg8glDvfKDZMj7?=
 =?us-ascii?Q?MW0XvqBHaGe4hYSemC7BDJmF2R+WHZ1AHStR23eaMBgokJxRjLgPbz2pj/Qt?=
 =?us-ascii?Q?CELUX/OFWt2EkzcZ09ZghGwSLce8iHKukpL8vKRRWGQiDfF0wKE6X4wZ3T3f?=
 =?us-ascii?Q?op8aMxsj4wnPXx6temM3I13tl3eGDaQrHYb83sSdiSG+za6qZIIhpvHHStfT?=
 =?us-ascii?Q?LdXi+6NrYvDdqzHsOwPe+IkAEBXb/Xad2LvIcIv6zuV6qpla0X2XYzfiE/J7?=
 =?us-ascii?Q?sHYsHJSu9Eg0JVpSpAnjGQ8J621wR897+uQu0DTRy2Bd0/UBeYZ2L+l6/ran?=
 =?us-ascii?Q?MUZbVQvKUmFct0wMhRFurv6d6aHLsxitHx7yYANaS4qTa9cGQv4eb9uDosrL?=
 =?us-ascii?Q?6o8uxwAiXT35IHcjlUj9L/UBkX6qYrFwkLW/5k1YsTI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4913.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1236a2-9bd0-4067-8871-08d89c3db7fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 12:26:56.5447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SRZS/4YecAgQuai47ag+m81z2S05DjYZga1CoVwJt7FbrVhGeff9zaWywkxOTvnn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2451
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

Nitpick - you may want to send the message only during enable workflow. Apart from that,

Series is Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com> 
Sent: Wednesday, December 9, 2020 9:49 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 5/5] drm/amd/pm: fulfill sienna cichlid 2nd usb2.0 port workaround

Fulfill the 2nd usb2.0 port workaround for sienna cichlid.

Change-Id: Id5a89a468787846ed0050b56cd318a9574185567
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 38 ++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 47d4f92d5ead..74cf027e4a41 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3247,6 +3247,42 @@ static int sienna_cichlid_gpo_control(struct smu_context *smu,
 
 	return ret;
 }
+
+static int sienna_cichlid_notify_2nd_usb20_port(struct smu_context 
+*smu) {
+	uint32_t smu_version;
+	int ret = 0;
+
+	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (ret)
+		return ret;
+
+	/*
+	 * Message SMU_MSG_Enable2ndUSB20Port is supported by 58.45
+	 * onwards PMFWs.
+	 */
+	if (smu_version < 0x003A2D00)
+		return 0;
+
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_Enable2ndUSB20Port,
+					       smu->smu_table.boot_values.firmware_caps & ATOM_FIRMWARE_CAP_ENABLE_2ND_USB20PORT ?
+					       1 : 0,
+					       NULL);
+}
+
+static int sienna_cichlid_system_features_control(struct smu_context *smu,
+						  bool en)
+{
+	int ret = 0;
+
+	ret = sienna_cichlid_notify_2nd_usb20_port(smu);
+	if (ret)
+		return ret;
+
+	return smu_v11_0_system_features_control(smu, en); }
+
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
 	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
@@ -3287,7 +3323,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.set_driver_table_location = smu_v11_0_set_driver_table_location,
 	.set_tool_table_location = smu_v11_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
-	.system_features_control = smu_v11_0_system_features_control,
+	.system_features_control = sienna_cichlid_system_features_control,
 	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
 	.send_smc_msg = smu_cmn_send_smc_msg,
 	.init_display_count = NULL,
--
2.29.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
