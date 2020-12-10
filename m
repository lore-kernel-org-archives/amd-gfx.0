Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DF4C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 02:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1956523C82
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 02:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1956523C82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CCE76E233;
	Thu, 10 Dec 2020 02:40:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E89C6E233
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 02:40:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mr1QatGikUNqgFnAv3hl/MO6j/CsPtl1AJP1PVOYebPWu96gJ6GJn/ZTo87wFr70/fO92mXNJZsRlCeTadAAzuQKISxiFDXJfFvb4rFvHWoYeMJIbvs9quIluP31meMW+flQCz9Gp7vewZ7bnb1hNVDvwHQ6OmbhpjScYU/kgFmgd+q2tnMEe9DvBmaXf5E6BLuD4pH5dnRLy315KrpHeO++CCzuE2AcVokVF5XFPhDkSQcyB16DaVk/I+kGPXaFkSgxA1MmaTtJEacKcNQ2sNvmA8BWn+grcqytACOvS6AO67uXklB1S9BQOYeys3GAjY3lzQRfCDFEuGjdcf9P5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueGHoCuQcqymDYP7ou2b2RpAFwV8iG2QUaLzrvJ99EI=;
 b=iPRAfq8ZYXh09kb7QHNIPSbVb3DrzkGI7CX6hd+4ZfTcHSF40Uxrrob38CeFHFXk6bcC7nFx2t6LhxAQ8QnUTGfYyFKHg3bSX1NWhMycwZdul5pHs/ETXFv3OI8rpVs0pEwikEdAR1DfnnddhFki4PJTK5ryQVGwZV6+INMon7xw+grw7pnO/GUbAvSRKB3YhLf5SteFyp7SbVcjEwUQ8SrH3vjohAH/wPmGBkMweXHfFhMO3etJGYAR1quWOgMXrVXCoppxjs8ttNFM3S0174m81REzZ0OxUxlKP2Z3rfxnbHGlz9K+SFFBKSdlDppYwveJgy+bTTzDxnlG9eEfNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueGHoCuQcqymDYP7ou2b2RpAFwV8iG2QUaLzrvJ99EI=;
 b=WXjXlb0Vz7H1cwJG0x/U3CmaOc+sHwX5DOI5fSmQnbv4Ch9pA99pd9mS63b91GFOclvyWBc0zD2OOfP/Dz90Drdh0ZkANlpviH4jm4RciuE45qTDxhiRdIKPrp+1q+D62XelclGmJjrSBJmAtgbTRnF0MTr0a9cUWn4sxJMt018=
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 by BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 10 Dec
 2020 02:40:45 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::f40a:39e1:ad71:3e6a]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::f40a:39e1:ad71:3e6a%7]) with mapi id 15.20.3632.023; Thu, 10 Dec 2020
 02:40:45 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amd/pm: fulfill sienna cichlid 2nd usb2.0 port
 workaround
Thread-Topic: [PATCH 5/5] drm/amd/pm: fulfill sienna cichlid 2nd usb2.0 port
 workaround
Thread-Index: AQHWzeJ2V/VJkfSL9kmczD791RnTFqnvnobQ
Date: Thu, 10 Dec 2020 02:40:45 +0000
Message-ID: <BY5PR12MB488520109190ACBFBB188E25EACB0@BY5PR12MB4885.namprd12.prod.outlook.com>
References: <20201209041836.143264-1-evan.quan@amd.com>
 <20201209041836.143264-5-evan.quan@amd.com>
In-Reply-To: <20201209041836.143264-5-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=90596a0e-dc03-4d83-81ca-0eeaa375f3f0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-10T02:35:39Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 800a823a-2efe-4642-41df-08d89cb4feb6
x-ms-traffictypediagnostic: BYAPR12MB3462:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3462C3C5B21EB687263DFBECEACB0@BYAPR12MB3462.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4D6/eppsQrYdrsXgjbZ6iR9ya8ZuEEApfyYyEdCuQHIx2LGYt1p705SA0PK+JXG0S8h4UjLXVScJWA+MQ0cCpZ53goE9Zq3Cri8sIfkbrX2Z7e3yF1iECw6CjTSpsC+KdLJ5qky2fpbWaVaR5fxPQzpuhJcn0QFMoFz9HlO9yk1ZqG5k3wsVYZhvWybz++0lVZ4x9pbFx95Lkx5IgOxbXUYdKSXyR3pFVZ7iubDLC1JneVmML38uJ7et3ofTyQy3Qc6QK+1NSnieMNBdR940xtPcIbabFBgH3GtGhZTGK5xvdCHjW1k+o/DpSUguPn7so1HmUdCPZ3dSelqNvVo62mOwMKz4s47lkkQ0WflmNr0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4885.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(5660300002)(8936002)(54906003)(64756008)(83380400001)(66476007)(86362001)(66946007)(45080400002)(66446008)(76116006)(66556008)(508600001)(26005)(7696005)(110136005)(186003)(33656002)(71200400001)(52536014)(966005)(2906002)(6506007)(4326008)(8676002)(53546011)(55016002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?P/SFVG7TFe+R3QfFDf1q82Mvi7PBLXoHYmUsuxu8n+U+iZnlmz8VwGHdAtZU?=
 =?us-ascii?Q?jXCsLGeJn1y3iWtgTszjisQ6NlrjXjLJwgLh0CN61w46BnXJHw2sd/vtT+/j?=
 =?us-ascii?Q?QpOgY4ugiDCViHqBoG5XMGbEzCFZAqCSmUSxcyMnuV49if9a5YjJhZNPe0tD?=
 =?us-ascii?Q?zVzNry3teybxvnWl3oHmUBJbT0xPmpfrLgPRz68JpwFM6ayBDtXjCSnZTzNm?=
 =?us-ascii?Q?OgpSRpq1TwVfB92iwtB1iXVA/yn2DdceDfo1EUYr/L4bIIVjMx2X39I1YV62?=
 =?us-ascii?Q?mZiq59gzD8NTHmeqa4m3xpprmQO6sdCX81kuegf21PcMc15ixN8d7cxek8ZG?=
 =?us-ascii?Q?eFPtFOEKO1wWbNd4w92wJiI+ERi4A77bFGHMv4sFDUVoTc4+xQzarqxTohCX?=
 =?us-ascii?Q?UBAfb5SIsV5X5kUvchIOnAOm/t8YddfToG6kBjxcgmxiwm+4E5twirugF8fU?=
 =?us-ascii?Q?PwvbHX1jXEphvHnhRGvh+4P1tocZbBcq5E9s2YXi/2vJqBs84/yc/iU7ampA?=
 =?us-ascii?Q?Mplvf5WIqJb4N6szOCEVjv+QKmU0b8vEr7BoiIdKAK+pUQ5vqjfRq1K/UFK3?=
 =?us-ascii?Q?fmJr/gdpKOpDMBWeTgVnBgezK+Wh6QQx/qLkXY6P9D3/27MVNQRNnzfolzcZ?=
 =?us-ascii?Q?iz4JboHJwasUCWm6uShPgOL8NCDgdgxPoCneKgGOUqKFBxEmZPOVpgzmMmbD?=
 =?us-ascii?Q?Ey8pWNC3jyMQWq0JFbPFX4RtBPg8xnD0oIvpJ0rZQXPp8iBLh+t0hfSQWTFH?=
 =?us-ascii?Q?fjuN5pB7kit7U7MtpBTPZIs9veaLFkt3BpHBHuzY/wT2Dj6bKzz0WIOTWgd9?=
 =?us-ascii?Q?vOZc4bV07XmWnUo6yoStjKw+Yz6s6UIsSTf3lO2bFs4TDUTCg2GM/oHgBGZq?=
 =?us-ascii?Q?tdv8iY0euWz2wD6TGqDQXoRbB0AQWrMkBfP4h1ossirwKfXDkdNj7tqCg3WU?=
 =?us-ascii?Q?46XaxwoANt3NMhuYCkFd9yPmXJGeJJq5zYbmw97vm8A=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800a823a-2efe-4642-41df-08d89cb4feb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 02:40:45.2775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zQSv7IZNQbRF+3/mOyA+pzB2EdlTZhvCIl7MKwZRc1Q7Oik77FPr+N6aNYjAnPhGQ5mHcexol+wLMb/pIn3FIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3462
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Evan,
Besides Navi21, other Navi2x Asics reuse sienna_cichlid_ppt.c and the callbacks, have you taken their user cases into consideration?
Thanks!

Regards,
Jiansong
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Wednesday, December 9, 2020 12:19 PM
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
+uint32_t smu_version;
+int ret = 0;
+
+ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
+if (ret)
+return ret;
+
+/*
+ * Message SMU_MSG_Enable2ndUSB20Port is supported by 58.45
+ * onwards PMFWs.
+ */
+if (smu_version < 0x003A2D00)
+return 0;
+
+return smu_cmn_send_smc_msg_with_param(smu,
+       SMU_MSG_Enable2ndUSB20Port,
+       smu->smu_table.boot_values.firmware_caps & ATOM_FIRMWARE_CAP_ENABLE_2ND_USB20PORT ?
+       1 : 0,
+       NULL);
+}
+
+static int sienna_cichlid_system_features_control(struct smu_context *smu,
+  bool en)
+{
+int ret = 0;
+
+ret = sienna_cichlid_notify_2nd_usb20_port(smu);
+if (ret)
+return ret;
+
+return smu_v11_0_system_features_control(smu, en); }
+
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 .get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
 .set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
@@ -3287,7 +3323,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 .set_driver_table_location = smu_v11_0_set_driver_table_location,
 .set_tool_table_location = smu_v11_0_set_tool_table_location,
 .notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
-.system_features_control = smu_v11_0_system_features_control,
+.system_features_control = sienna_cichlid_system_features_control,
 .send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
 .send_smc_msg = smu_cmn_send_smc_msg,
 .init_display_count = NULL,
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CJiansong.Chen%40amd.com%7Ca41215f008134335e07908d89bf9976d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637430843582059660%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ymwXfGcmzTVSEU4k83ePinKcXk4ExzkWxiMAZlH5u30%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
