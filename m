Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8428C4361B
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 12:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A798923B45
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 12:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A798923B45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CAFD6E13A;
	Wed,  9 Dec 2020 12:59:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C8556E13A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 12:59:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izd7dNanViNkpUjkrFKCjHuTznVchdYCQmVfOJKuT2cyfeEsW5/flRP7B4eTig71iLslRYvmp0tBpTj2zQVB4jMWJSBt6xgmfoWPDdOCIjpIWFaA3MTxpKMNBWXdlJ5oj+wlzIrtQfKLkFAI/1aJVXBTkL5j80xd3JtO48znzwNT158N+n7zYtoiLzQwqc2zhJtRLUmqFCjn3Ipb7gkyGIYgsH/mZL0QsVHi6FVmeBIskNQzO+nYmKLHP6ZR6yJ1J61y47OMKr4EJmGfJ+niqzaha0XCZaHtVEUqRL3zNePN6FWGkB0hJxQIOIt+PvFEuYuFVoZjoKELe3jCLsApEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DniZConxIEaD2fi3mfQNqBko5pru5hYXXIYGNO8jt6s=;
 b=bR8CODTlcTzs1FJQtzxgTSdZyhkW81OdelxpPELCFC06uuwQkB0VU+/8Poabv3mhg4UP+47Baj64GsFeIEEjA49KXW2C4TNkkM7WfU4GdXi68+pphLb8VXuTrbRgb6EN57sO1W60B+UyU3gt/WHgERlXblgbkOOxtjYmEpA6hX7xPHS5v7DS0DvgQRoNBbjmr2mdFQ+dy4CrQhRjkLRGh6zsY3UpLbKuz8KfTYBkDGAuaX6nIBwxURdBhUljraltWQnyUN0EAseC5p9mv1q6sEKfyH/PCGHLI4WSbh+zc/eyTvkw1wIchMFlJVx/I6kL5B2ctQ5IURN971+HyOMk/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DniZConxIEaD2fi3mfQNqBko5pru5hYXXIYGNO8jt6s=;
 b=fSFXbBv/AOgiJwwXrmaXIw/h+nbMNdFRF1lYH2b+7qSAz8St4UbprnvJtyZF+1hYZpzDHb/b7pm+oxCfJuVQ+ja2Qc1MnFqNR9R/zU5tQc/Hgmf7xWgPcHMpNjw3iCXbszYZz/VJz8TImAzje0BuPpIiBGxad/J098gcerYl/t4=
Received: from BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Wed, 9 Dec
 2020 12:59:18 +0000
Received: from BL0PR12MB4913.namprd12.prod.outlook.com
 ([fe80::4112:ac5:8125:7c05]) by BL0PR12MB4913.namprd12.prod.outlook.com
 ([fe80::4112:ac5:8125:7c05%2]) with mapi id 15.20.3632.021; Wed, 9 Dec 2020
 12:59:17 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 2/2] drm/amd/pm: inform SMU RLC status thus
 enable/disable DPM feature for vangogh
Thread-Topic: [PATCH v2 2/2] drm/amd/pm: inform SMU RLC status thus
 enable/disable DPM feature for vangogh
Thread-Index: AQHWzinXxFVbufydR0SlMogSWYrw0qnuuRZw
Date: Wed, 9 Dec 2020 12:59:17 +0000
Message-ID: <BL0PR12MB49134D2D2E1EB79DCBF7A6A597CC0@BL0PR12MB4913.namprd12.prod.outlook.com>
References: <20201209124938.11680-1-Xiaomeng.Hou@amd.com>
 <20201209124938.11680-2-Xiaomeng.Hou@amd.com>
In-Reply-To: <20201209124938.11680-2-Xiaomeng.Hou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-09T12:59:02Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=201645f1-ba86-432d-9a24-0000fd9e05b1;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-12-09T12:58:56Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: b5bdb5cc-f383-4b4a-b6d3-00009a90fe08
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-09T12:59:15Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: ba295190-fd36-4ab2-89eb-0000a9cdf264
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.198.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 72499032-7f88-44a9-bb5f-08d89c423d04
x-ms-traffictypediagnostic: MN2PR12MB4111:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4111D6D983830DE060E5154F97CC0@MN2PR12MB4111.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kn2aHPCj1dvuIgddhUlI9CbpiXo5eqVzREzkRyv14iAM8w5wCsaG/7Ls4nCh0rwAbQ/nYh6cSnnC5eE7LcxtNu2SQ07ykpI9ncLj9JHsc843dCeDe7ramSzeV/OjPL7GfsbnOhYTfIFBhnR0cloy9yRqJTeEsh2UuyxYQfWxUdjI9luvQ23GitmtgTSg+er3hdoEq5LvEwmPujx0h0zOyaY9PAwLp7hey5AMYnd6iYC6hwKj27R8G3Tb5eQoYEnQeJCl6n9qToH9AQjQJVSYWUZB/2an85slY8gfNEYT5OnfOvvtH9JeEGU/k6TB4ahxfGxYnVNpwIeG3ZnB4xhJWA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4913.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(64756008)(86362001)(52536014)(5660300002)(6506007)(53546011)(66946007)(66556008)(8676002)(4326008)(66476007)(55236004)(2906002)(7696005)(54906003)(508600001)(186003)(33656002)(71200400001)(76116006)(55016002)(110136005)(8936002)(66446008)(9686003)(83380400001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?W0xrBhLJCFua57cDciXvTPWb8g3YX8uJp6KM5K5n+NMnQKtPKQHBnkx0kLRG?=
 =?us-ascii?Q?0S2vvOJSNBARoRfHh7bJDcfZTFpCJ5xxdMism+a9fsqftkIodMY8gv7MdPhA?=
 =?us-ascii?Q?Jdx1UxIf9ucfatrp398EoIKVSMJzvIniv2tBpHaaYX1lc0VUGuZXxgZkrKPB?=
 =?us-ascii?Q?av0lnwIjP9Rf0eslvjf7DDsSSiv+VuaNqr3MxrpNbO/xqywd7uW5FbQrjhGo?=
 =?us-ascii?Q?Fwib4eMid6JvwPUeM1Ljf4QQ7rhWCsLGPMe9pg6octViCQS/Qxxix9dgisF0?=
 =?us-ascii?Q?ABGfMMZeW92qCEA4KRqGdM5mF83j6bNAodRXJfyiY1/PR3OVYm3vOjjRcGBY?=
 =?us-ascii?Q?KfnnvijX6o0KMzPxmztwBuvnyB56b8YpNCujhhGgM3SflK6h8dul7PMyFVhU?=
 =?us-ascii?Q?PTcX3OTlfa2F3tzxWWczK23efL6crqdjra9JgAVENDQfIM331pMzTnWLfwGf?=
 =?us-ascii?Q?DSfesKn9qyw4ZfT+W3NGyux0GRQOdOW9sDln6yBTj176KyC0DzzJelmgK1Gb?=
 =?us-ascii?Q?6TIFWrmZV3mpTXT/UfSYZkzA7i7d1p0KJu7MppDcX2T5RM+nXo14tRhGOc3d?=
 =?us-ascii?Q?KB9CFG+VDvQunuC43FkxFsiU0KfBR8fDhPrzteh7oViu1mmr4JG+CCZXoMaG?=
 =?us-ascii?Q?wJZisvY4iSDDOKcT381HZ/66YSod+9LvdoC6QyoAsG7T+K4aEjxBJQdtfI5D?=
 =?us-ascii?Q?ZbKMVxTmgW0A1QdIo6B9togzsKgVGpz/Xgu2YXl+aRCHv8R/j/fqF8fRpO8g?=
 =?us-ascii?Q?d0JyMBIph4EctSN6sXOWMxHwgHsKwhC9a12AD8F07tFVzIWZich/D0LtQoDP?=
 =?us-ascii?Q?ku/1YtlKp0KBsvR3yUmu0LsfTLbQCfL7W5aoxJrfI7eae/oUWNJEhQcExATT?=
 =?us-ascii?Q?cUcnmZc88Gd4OU9pGjHHqKga3H61ZJ9hbTK2VDXokgxwJ+WJ4DTVxjorM8sG?=
 =?us-ascii?Q?PkUx0vyApPqVgwAnbVxurf9J5gXIORDNpJRMNLpWkZI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4913.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72499032-7f88-44a9-bb5f-08d89c423d04
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 12:59:17.7314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rHHc/qcKAXAhmeT9XxdGBBXlEZG+biQv/OHKlEmaaY8i1vG4akqsrp6ci7BRn0qR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Series is Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com> 
Sent: Wednesday, December 9, 2020 6:20 PM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, Ray <Ray.Huang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>
Subject: [PATCH v2 2/2] drm/amd/pm: inform SMU RLC status thus enable/disable DPM feature for vangogh

RLC is halted when system suspend/shutdown. However, due to DPM enabled, PMFW is unaware of RLC being halted and will continue sending messages, which would eventually cause an ACPI hang. Use the system_feature_control interface to notify SMU the status of RLC thus enable/disable DPM feature.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
Change-Id: I2f1a7de23df7315a7b220ba6d0a4bcaa75c93fea
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c    | 17 ++++++++++++++++-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h    |  4 ++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index ddaa6a705fa6..fb16d94b4031 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -64,7 +64,7 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(PowerUpIspByTile,               PPSMC_MSG_PowerUpIspByTile,		0),
 	MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,			0),
 	MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,			0),
-	MSG_MAP(Spare,                          PPSMC_MSG_spare,				0),
+	MSG_MAP(RlcPowerNotify,                 PPSMC_MSG_RlcPowerNotify,		0),
 	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,		0),
 	MSG_MAP(SetSoftMinGfxclk,               PPSMC_MSG_SetSoftMinGfxclk,		0),
 	MSG_MAP(ActiveProcessNotify,            PPSMC_MSG_ActiveProcessNotify,		0),
@@ -722,6 +722,20 @@ static int vangogh_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
 	return 0;
 }
 
+static int vangogh_system_features_control(struct smu_context *smu, 
+bool en) {
+	int ret = 0;
+
+	if (en)
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RlcPowerNotify,
+								RLC_STATUS_NORMAL, NULL);
+	else
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RlcPowerNotify,
+								RLC_STATUS_OFF, NULL);
+
+	return ret;
+}
+
 static const struct pptable_funcs vangogh_ppt_funcs = {
 
 	.check_fw_status = smu_v11_0_check_fw_status, @@ -750,6 +764,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.print_clk_levels = vangogh_print_fine_grain_clk,
 	.set_default_dpm_table = vangogh_set_default_dpm_tables,
 	.set_fine_grain_gfx_freq_parameters = vangogh_set_fine_grain_gfx_freq_parameters,
+	.system_features_control = vangogh_system_features_control,
 };
 
 void vangogh_set_ppt_funcs(struct smu_context *smu) diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
index 8756766296cd..eab455493076 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
@@ -32,4 +32,8 @@ extern void vangogh_set_ppt_funcs(struct smu_context *smu);
 #define VANGOGH_UMD_PSTATE_SOCCLK       678
 #define VANGOGH_UMD_PSTATE_FCLK         800
 
+/* RLC Power Status */
+#define RLC_STATUS_OFF          0
+#define RLC_STATUS_NORMAL       1
+
 #endif
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
