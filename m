Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D6BC4708F
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 13:29:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B83166142B
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 13:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83166142B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 495DC6E128;
	Mon, 31 May 2021 13:29:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81DF16E128
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 May 2021 13:29:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeDTm3XzhWMWDy3Rb3WxcSYqzT47FMgkgiqy6ZF8uj3WlgzluAeZrK/gDqhYyglJCC/B+29gJ0fB9mT8cvYQWgvDokTXTBNlzNh0TJN5poFqfXw071aIRpbizujtZOV4jSb7ovyUSe2LG+VcJ3FSjiy/8sh8WQwEVRl8YIOHK3c4nRncgtZXS+6dZKulGKCB7Whti9r6xSuaAxFsBhiFosojvVCWDdOq8tbaQ9LTrTyUQ7VGFaCRmedqRRYofSYeoRhIu6qB5BK6k55eVoSUQj5uDug0hq8j8Ls5q/D5pvAKugKeMr1xQcVGp6cRIRu3ceJ1JZgqfrMJRsyfxYABPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACvGBcbZQiemm5s6nNDeDBrZr/kiOL23Tp5/KEh6qgo=;
 b=ZYRywZr3pYgay9/ncNovNcEzXUZ38yacDE9wXpzMcSSpiRLEhQ8n08XqjJHIhWuzU1v6Z9c2NE9xTw7cFQebGdS7o0YGhDNTbNGoglRjpJVrYvN3OymJ1l3IqvoYwVGM8NFY886UJf+jgQ2znKBUkGbkahS20+VIEJWbEmi8IvbgYa2dwMWOryxsXKkZ4w5BM00xst/3uyUYte77F475uXTeoAsCyV6MQJc1gcKCLnJC24ECrju/DCdKusZK+k4jxdziY/z9CRop4P/oNmhCfpGML0PmnyV9T0Y0ghtIbC7SMpnTarQ8kEDcZmC9v0Ej/jNTxwg8J3LMzGmn0SYoKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACvGBcbZQiemm5s6nNDeDBrZr/kiOL23Tp5/KEh6qgo=;
 b=VflqkGDrmvWyb/VGaoAKaCf/45AIDJcQhd1OkYkj2X7j7EKcC7WHd91jHFH+7zdpNbMbfi0gQhBPpuj0wRSt3k3cBIors39+DRPP7YmhcMp+wvuEE0xJWe4AcFAsxAGVlt0/8wHUOEt3th01n4EoGfT95jcW0IllVs2beoPufUM=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by DM6PR12MB3913.namprd12.prod.outlook.com (2603:10b6:5:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.26; Mon, 31 May
 2021 13:29:46 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345%6]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 13:29:46 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 4/8] drm/amd/pm: Add navi1x throttler translation
Thread-Topic: [PATCH v2 4/8] drm/amd/pm: Add navi1x throttler translation
Thread-Index: AQHXU/w40UJnL3inKUClVLWCoyjuNar9DyuAgACJBxA=
Date: Mon, 31 May 2021 13:29:46 +0000
Message-ID: <DM6PR12MB30671549A39C18DFD2BE79388A3F9@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20210528195815.2615-1-Graham.Sider@amd.com>
 <20210528195815.2615-4-Graham.Sider@amd.com>
 <CH0PR12MB53482CA6E88715706506E2B8973F9@CH0PR12MB5348.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB53482CA6E88715706506E2B8973F9@CH0PR12MB5348.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-31T05:12:33Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=a6d7f43e-15e2-4042-bb02-393a2395573c;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:9880:1020:cb:2c3c:9993:b33b:2b7b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d964acd3-f2bd-4907-7105-08d92438285b
x-ms-traffictypediagnostic: DM6PR12MB3913:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB39134D8049FF22EAF498B9588A3F9@DM6PR12MB3913.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hyV316vRGlYDDrmk7HKIp0iKgJQ2wCC8Ubb0awJ2nXWU3ZY2jwfBc5nkhUqohCmVa0quGJrv7zDOEVMSTHkOUIvAThOrO6IhE9p176CJ9/WNOiIEPVQWQdGLpzdU1U1F3CYMl13LrVw0zp+HytlDg0BeHqm2HnT0xmpmHFEEUcbfrVFD/Gmd1eO2MbK+FCZJH0wIoNt46GieDbKxD+7ZGN1vWPiY8q/eni+OOoD/E6Ov+/RabzshXsb2ET6hW9CfvK7hwQW+nJ3dUKQrOdSArL6FbAokXt4nbx5X/mLRfzw7mtaBjNAQeUGn+xK9Zi8MymrHCUZ+b7DHJpqgWyNxRHwgdugco3mVYU0sPVcKEzmjFx+5p5c2j2+G9XAZaSFaSNxtNe71IPutF/gyLbesFwDiOmtELlmLDuvtfkMkkRNEQZ8BxOJAwn+6Ck6iLy3aLxItOFL1wQ7HZUNPVybiyLt7eDByv3uZXhj+6njo38qmyER+ja9qbAp4fltKVqcHzoG9BWy2EBBllNXl4mZOaf1xycFjKhxJlLWmm9NLfZQcCp527t1TJ3lGyXLr6cwXCYSKEAHJl/45hIQDoexFrLjMAmpB8OWVZ6C8AgQFVfmb7qw8sTKzQ/v0AtzgjzqUm+66Xe81jOkbYP1C++VQa0QoVFkHY37XwrUsZeevui2T5baqPfWS7WLDlccM9Y19cLxp8TyTQDFhxQSYBZ5vJg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(71200400001)(5660300002)(4326008)(83380400001)(2906002)(64756008)(966005)(66946007)(66476007)(66446008)(66556008)(76116006)(52536014)(316002)(9686003)(33656002)(478600001)(53546011)(7696005)(8936002)(45080400002)(186003)(122000001)(38100700002)(8676002)(110136005)(54906003)(86362001)(55016002)(6506007)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TLCsxSvqzxt+Gd/JRP3UWMP9YBDrenKsJg8xHXa2J7hzRosZEWxw3v2C432L?=
 =?us-ascii?Q?ZUABAVS5hJbFCkW7RC77dwcPyBx4T7VPmqMalyks5wCXEvZc9Ef9UdQqwl3v?=
 =?us-ascii?Q?w2cGbmTdPbb8OTmBeaMaSGzE4g6pf5aYSQIg6BE+ODhBT8r1fdF7Sgr9AYwn?=
 =?us-ascii?Q?WiWzZVVVF5LtICi/Ay2CWeJ98NnttaikuC4Hsg1tcf3rMMxxpbabvAt3XtOV?=
 =?us-ascii?Q?pI9LNhys34hJRJQ3XqNGV6gsYFsjPIOnuDNx0b+S+2WZKOQW091GT+KK+Pfs?=
 =?us-ascii?Q?teNBEYoTSQwiLBqd8HeKkA1AWP4Wm1sh3ONVs/uMWOl6BmshQPDM6KMoTDbp?=
 =?us-ascii?Q?YmJ4SF0LFXCJpDJ9iouO3c8idLGnxSwc97HDKp0iGAwJDBPXtuNIALhwzV0C?=
 =?us-ascii?Q?0pOn3Bm+8lpf8XWyOSsAZQJdox0A1+YSutZzZAENp5y1xptduIn+JOIqxE0A?=
 =?us-ascii?Q?tEVanb+gpbc8wx0bUesBl/I+qycwpJ3D5guxZBJ/vpw7IWf4nEayb/7rW5lO?=
 =?us-ascii?Q?RG9tNvvZK03sDdPliYVvRXya5nOhe4Ld7qmxBp3i5655nGRLn7pd6dPWNjpU?=
 =?us-ascii?Q?5t0YkzfO1KZW56MjNnzeLlJxPB72aR8Gf2jBbFlGbDvajJLjwk/nJtEv7FpB?=
 =?us-ascii?Q?u7Vqkn7L5SL5qFL2ASJt2t2V4yjmlFXlxQwB1ER6z8AJyJ7e5HzEEPWQ3h1j?=
 =?us-ascii?Q?d/PIfWDaABiECawcb6z+KSzdiLV0fHe3eckGp/rnLmTl2KsTYiV7bCp0sLw/?=
 =?us-ascii?Q?A0M3MFiNnXFe8CCjvZVsqRoVysTT51L460eUNqB+v0LujyqXXojwZOR48ixj?=
 =?us-ascii?Q?BSnCLegxSYlp10xmjqjuJc3+MV8vTV5dwakNN3wTbt5u7u4cqlDLjGNzL4aj?=
 =?us-ascii?Q?/CNDXsa608T8vW0J4BkixGrnH3b64rMpxZ+n1zh0SILxh+guWCMQbcZFkmHi?=
 =?us-ascii?Q?HFXTxvTuzBGPhoh0zRvGIuAMRBMj98WRcOU2tOAcDD9Yp3HZuYtGPRl4yW6x?=
 =?us-ascii?Q?FrWlE2T47tPbQ7C8ByqCKBMIWMwUezwzMPcB1x05PKQQ/NkF4wSQmZvJ838I?=
 =?us-ascii?Q?eUFfAZhO0RVDBvFEzZv0VgvH2Whi8H0YtPRrlGCNsIxbCHFVK/XpPy4Kai5r?=
 =?us-ascii?Q?XFX79ztbOrDq7Wt1AIbAPq0sm7VfYT3DquIyiV9i5BGyn3XAho8fOnky4kf5?=
 =?us-ascii?Q?23xPadKUx866NOMoJUVFZXv2YfKzuhl5B9OtEHPlSAkvBqhfW71D2MJcNckc?=
 =?us-ascii?Q?jWfGVMGVkg7KCrlXBPCwASN6i1kyoE/HAysLqNBKZd1UVquj6cVVgkLChRut?=
 =?us-ascii?Q?sHxNwrnjlCHZFT3LjnE1tyfvIuYDehJG8B98h9ItEvz39hOHBSiaWCRaFOdK?=
 =?us-ascii?Q?6v9IgTimz6MmUHcD3PcSevKUzSTd?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d964acd3-f2bd-4907-7105-08d92438285b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 13:29:46.2326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y5qi5UbpbXRpIHH7eWvaSnEDg2jLdfYdwSCnzP9wDcpizzMbJTinKj/jUOsg2ntH3ooJ8lkZGRiwi+PFiJLAag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3913
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
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Sakhnovitch, 
 Elena \(Elen\)" <Elena.Sakhnovitch@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

That's fair, I wasn't sure if adding a lookup table for the bitmapping of each ASIC was necessarily wanted, but it would definitely result in less runtime overhead.

This way we can also make use of the for_each_set_bit() macro in bitops.h. I'll make the change and fix the padding and resubmit. Thanks for the feedback.

Graham

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com> 
Sent: Monday, May 31, 2021 1:13 AM
To: Sider, Graham <Graham.Sider@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Sider, Graham <Graham.Sider@amd.com>; Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>
Subject: RE: [PATCH v2 4/8] drm/amd/pm: Add navi1x throttler translation

[AMD Official Use Only]



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Graham Sider
Sent: Saturday, May 29, 2021 1:28 AM
To: amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Sider, Graham <Graham.Sider@amd.com>; Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>
Subject: [PATCH v2 4/8] drm/amd/pm: Add navi1x throttler translation

Perform dependent to independent throttle status translation for navi1x.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 78fe13183e8b..878ec698909c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -524,6 +524,54 @@ static int navi10_tables_init(struct smu_context *smu)
 	return -ENOMEM;
 }
 
+static uint64_t navi1x_get_indep_throttler_status(
+					uint32_t dep_status)
+{
+	if (dep_status == 0)
+		return 0;
+
+	uint64_t indep_status = 0;

< > Extending Harish's comments - it's very unlikely that all or even 50% of these bits are set together. It may be better to do something like  

while (bit=ffs(dep_status)) {
 indep_status |= 1ULL  << mapping[bit-1]; dep_status &= ~(1UL << bit - 1); } Will need a lookup table, should be fine though. 

Thanks,
Lijo

+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_EDGE_BIT, THROTTLER_TEMP_EDGE_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_HOTSPOT_BIT, THROTTLER_TEMP_HOTSPOT_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_MEM_BIT, THROTTLER_TEMP_MEM_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_VR_GFX_BIT, THROTTLER_TEMP_VR_GFX_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_VR_MEM_BIT, THROTTLER_TEMP_VR_MEM0_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_VR_MEM_BIT, THROTTLER_TEMP_VR_MEM1_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_VR_SOC_BIT, THROTTLER_TEMP_VR_SOC_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_LIQUID_BIT, THROTTLER_TEMP_LIQUID0_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_LIQUID_BIT, THROTTLER_TEMP_LIQUID1_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TDC_GFX_BIT, THROTTLER_TDC_GFX_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TDC_SOC_BIT, THROTTLER_TDC_SOC_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPT0_BIT, THROTTLER_PPT0_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPT1_BIT, THROTTLER_PPT1_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPT2_BIT, THROTTLER_PPT2_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPT3_BIT, THROTTLER_PPT3_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_FIT_BIT, THROTTLER_FIT_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPM_BIT, THROTTLER_PPM_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_APCC_BIT, THROTTLER_APCC_BIT);
+
+	return indep_status;
+}
+
 static int navi10_get_legacy_smu_metrics_data(struct smu_context *smu,
 					      MetricsMember_t member,
 					      uint32_t *value)
@@ -2673,6 +2721,8 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
@@ -2750,6 +2800,8 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
@@ -2826,6 +2878,8 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
@@ -2908,6 +2962,8 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C0e8287b706374269018508d922135f02%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637578288869743604%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=9u%2FUr8%2FPuSekq2ttc0NiYeacZoAnPZNb2BTXUSD2Fd8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
