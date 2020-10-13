Return-Path: <SRS0=VV5o=DU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A295CC433E7
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 07:51:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9015207C3
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2020 07:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qJR5jlS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9015207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FFDB6E8AD;
	Tue, 13 Oct 2020 07:51:18 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B9606E8AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2020 07:51:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oetNoWydQKIdo/TvBytTHqDh0glLOQjMQ4CFdtxFAGWZs4zqklyDx2kGpiEfgCouRzAZ13lwYkZNa/x0c8qljEe39mv39005zerbJV6ldf/F3+uiFzfaWDcc62riQQ1roRgLtsVUkiAB+L7cK98WJ1yEwj0Y7HFEXzdEkouyHrNA8f+eB+CW/Uk3JzoWMUMKEkQfM60LYfjDJjtMotHvwxwPwSKUc5Ts4cD6NQJ9DjL7SS7efdy2Ch1fLsUiwSYDIkoct1tmvMVLDjcij8V25O5K/QdGtLArui2y4cN8qok1vlfc4zvWgDtEG/NbXzL+P+IFE+ETh5Mu2xpgg19rhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVovm2IUQqHyIpIk2y2rUv1CA90/3bPcpBoW0zwSP4Q=;
 b=DMzt+5Cs9Teal+k/7PoT46lCLxImZlEeyMGfCwZW2MU2Jd5pPsqTU9010o+8oYJYQzlS0k1vg5SYP44kqhXONUlVVcIpOAwQTUO5Te6SyeP3EO7eJF0F5rfCCoRP2Et5mx9TsR6h4rnM3RP2rGluMOxUYIP2I51TK5s5Ns5xuduG7Q+VsGT3csMh4ISM2MtAQjhZSJmNSDFkak0olKC9TkHo4jTtIjATWYwqUDK9bK+dB/aZDK4pCkZyUnPqU2p57VQMC3IYuU9kmfgd2LKhjqHUamRlnLBCl0e52m6Ww23wIxk2Cz7syK2E7nP6FYM0q7q0UDKHOtgOo1LhyxPphw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVovm2IUQqHyIpIk2y2rUv1CA90/3bPcpBoW0zwSP4Q=;
 b=qJR5jlS4Z1tDY/H41WI4M2p02lLvXtEKkG23byVy324Bveyl49X6yMr6yxvJsPCEbGpm6cE0nf0yVe4nW19CugIEM3qfQfM5/tW4wp4Bu72n+qy/7wA8ViMYAvTXNTX6oz0PRu8nPGa75x7AeF4Vj3dHwMKteqk5NXgnPZWOqEE=
Received: from DM5PR1201MB0073.namprd12.prod.outlook.com (2603:10b6:4:50::16)
 by DM6PR12MB4449.namprd12.prod.outlook.com (2603:10b6:5:2a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Tue, 13 Oct
 2020 07:51:14 +0000
Received: from DM5PR1201MB0073.namprd12.prod.outlook.com
 ([fe80::417b:a8e7:3b26:84d7]) by DM5PR1201MB0073.namprd12.prod.outlook.com
 ([fe80::417b:a8e7:3b26:84d7%12]) with mapi id 15.20.3455.031; Tue, 13 Oct
 2020 07:51:14 +0000
From: "Gui, Jack" <Jack.Gui@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: set the default value of noretry to 1 for
 some dGPUs
Thread-Topic: [PATCH] drm/amd/amdgpu: set the default value of noretry to 1
 for some dGPUs
Thread-Index: AQHWoRo94/EBk4reZkaA6umkxXfv/6mVJ2iAgAABJ5A=
Date: Tue, 13 Oct 2020 07:51:14 +0000
Message-ID: <DM5PR1201MB0073B3C78DEA135114EECF348B040@DM5PR1201MB0073.namprd12.prod.outlook.com>
References: <20201013043445.23648-1-Jack.Gui@amd.com>
 <CY4PR12MB1287D70DC1CE5F4F4B498C82F1040@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1287D70DC1CE5F4F4B498C82F1040@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-13T07:37:43Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=fbd47cfe-679d-427f-8727-0000ee49677e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-13T07:51:12Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 7079a2d2-d33f-489d-9dcb-00006a6d2e05
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c1430b1-e4fd-421e-e16b-08d86f4cc2cf
x-ms-traffictypediagnostic: DM6PR12MB4449:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4449C1A7CBD024A86F35729A8B040@DM6PR12MB4449.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Ba/Hq0H2K9lren47QsetTtlDTcL2EpoHI0Q/8VGRa1ViuBSNiRxEWyBjl3CtLf2CGxBic8Kb5IMfKQF/cWgQVsgD6uJvVfKtnvz69Ztwgg3V7HjydK4F47xbVBeUvARw/pNPo5/xocqy6MF5qR1VbiCrnbRYWlKzJiTHFdgvybekzRqfcNOOrkwQK0oCVUCNjIkbdcyWNrZ9ZGAe13CqeZLedZDIGUaOhW1FyoElLJs+6jzq9oti+7DfQZPOVAfztnwZKOAU0pxyotPhnulSdVKF4N4xlU9pZWEnKEf3+GdNZo/X1Z+rhqPYG0IYoD/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0073.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(4326008)(83380400001)(9686003)(71200400001)(86362001)(55016002)(33656002)(6636002)(110136005)(2906002)(6506007)(53546011)(76116006)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(5660300002)(316002)(8676002)(478600001)(26005)(8936002)(186003)(7696005)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: xhbrcBKT8rYRz1QcHPFrXNBGmBPUWvlrqPm52WexMZk9dl5RogXfPf+ftkWi/zy6RNbfZaPj1aQMbJnfMMRbIkF9CwWND0ZPMyh4pJ5KSBYDuOK8O5spU8uXjCZHzU4qZEkeStwT7wEkXISEoOzj/BHZ6y1jpK7IwsN9TYVJG4C0W2qCUbCtuxDDE3O+CoBwLNB71ynK+arUzvhoZ8cXIoHkaLNf4JJda27L93ByrVYe2mqNjsAROBXo3bo77S4tA31Durdudk8o/wBqrtfhOgm1Bv5zvp3kmCbCaiUH7c+FOdugYOH/AtoXDOUiPTUWc7bojyrJFrWkhZGeEQowbn+5KqRO8t7Fj6IZadKIolg0D2109PL5kxv/8a3uO+0T3AfBmd8vVlAuK0BlKaQrfl9nK2KUZI6LSuYPSSx+OPrBZQZWPaa0yBF991Tmzjpc152wfu5mqemP9z8LgrLMFOL9UFGFb09eazY5ShY3ulhUQxoj0lZ1ozjC4JQM3z2WUf16cmqU2eKPXFTTwkTuvW1I+Uf/xkVCbLlD9jgj2nG/JLoksV6W2ryDvSneaM9LjETBEACIEg+Bd92mXr2Qn0YsCN07FDn38kmvm/0ZxMjL/Kb1f+wpegYuwZt1MeXIFAEZBPFrvHnR6RN0Z8Fl2w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0073.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1430b1-e4fd-421e-e16b-08d86f4cc2cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 07:51:14.8356 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VQ+f47XdeeSwBSv8mX8M6hFv8a020Hqw1aP6deRSRT1jxCQORJKKsDnkOXon/nEU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4449
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi Guchun,

It's fine.
I will address the patch according to your suggestion.

BR,
Jack

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Tuesday, October 13, 2020 3:45 PM
To: Gui, Jack <Jack.Gui@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Gui, Jack <Jack.Gui@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: set the default value of noretry to 1 for some dGPUs

[AMD Public Use]

Hi Jack,

How about improving the patch a bit like below? As the code for raven and default case is totally the same, maybe we could squash both together with adding the comment for RAVEN and other default ASICs for readiness.

switch (adev->asic_type) {
	case CHIP_VEGA20:
	case CHIP_NAVI10:
	case CHIP_NAVI14:
	case CHIP_ARCTURUS:
		/*
		 * noretry = 0 will cause kfd page fault tests fail
		 * for some ASICs, so set default to 1 for these ASICs.
		 */
		if (amdgpu_noretry == -1)
			gmc->noretry = 1;
		else
			gmc->noretry = amdgpu_noretry;
		break;
	case CHIP_RAVEN: 
	default:
	/* Raven currently has issues with noretry
	 * regardless of what we decide for other
	 * asics, we should leave raven with
	 * noretry = 0 until we root cause the
	 * issues. The same for other default ASICs.
	 */
		if (amdgpu_noretry == -1)
			gmc->noretry = 0;
		else
			gmc->noretry = amdgpu_noretry;
		break;
	
Regards,
Guchun

-----Original Message-----
From: Chengming Gui <Jack.Gui@amd.com> 
Sent: Tuesday, October 13, 2020 12:35 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Gui, Jack <Jack.Gui@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Rui.Huang@amd.com; Chen, Guchun <Guchun.Chen@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amd/amdgpu: set the default value of noretry to 1 for some dGPUs

noretry = 0 cause some dGPU's kfd page fault tests fail, so set noretry to 1 for these special ASICs:
vega20/navi10/navi14/ARCTURUS

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Change-Id: I3be70f463a49b0cd5c56456431d6c2cb98b13872
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 36604d751d62..f317bdeffcb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -437,6 +437,19 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 		else
 			gmc->noretry = amdgpu_noretry;
 		break;
+	case CHIP_VEGA20:
+	case CHIP_NAVI10:
+	case CHIP_NAVI14:
+	case CHIP_ARCTURUS:
+		/*
+		 * noretry = 0 will cause kfd page fault tests fail
+		 * for some ASICs, so set default to 1 for these ASICs.
+		 */
+		if (amdgpu_noretry == -1)
+			gmc->noretry = 1;
+		else
+			gmc->noretry = amdgpu_noretry;
+		break;
 	default:
 		/* default this to 0 for now, but we may want
 		 * to change this in the future for certain
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
