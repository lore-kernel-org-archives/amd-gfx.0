Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DE6C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 05:22:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB3AE206B5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 05:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RS1cm3su"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3AE206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9701D89E9B;
	Mon, 10 Aug 2020 05:22:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 489DB89E9B
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 05:22:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V04zZ0rlOPlbRe4wf0/MEU0ntOnwHKjkqBhBDUvlgvhCa3QEoQMQHgTO3d8QMMZ77c2m2c2w7XMYqj953/RBI8IrIPwUTq0WVTp18DE2uIoA+dbnOW/6ElKwmhfUevBu17c2xgBkBBeORcNZzAnJ/qBv8SoduPxEGObFssSc55Tyb2W2jRSDuz1lRo05AHz1g+JVlVV/Ckg22q2gX2TQqyQUAd6VIdLi1LZGpUVmFNa0HayNKvDUiSoKQtg6yjRPYd1cYW+6dWrXIOUDSgHIDeNYfA1hCvtgRDbibovljszHVAlHo4m/zHRXEumOC74ocanFazkGm2xsW5aPDzvCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUnKd2k7j4hXHXUd46rqtYsrumhxATHRY8DFRgJ5AMI=;
 b=OHMw3JvZ+mo7OH5Mvzi6swDgHDTKLadg8TbR34r9wmlt3p1vtSiky1qAmHRiVFJav47pS4dkfs26MVgPhTOhYCdMV67xem6oyu8eKuEF0Qx2d7h12fmK+kZBJUW9RVh8Qms5aIvUd1/D5w9xQ/G2xy3jJSGBeNA84MqsvQxbckD70qz00jkCyAevaijjn0P9/xDV6RLhu5YOLL55DIWyq0nBnKKsfaYzgqpmXG3f5c0gc8Bp06GnJkc9aQjt5kQgrvAf5AsusyXL/7tlaFB18n9NZq0L31IsIlyuaP95IHzP76/224/wiA8fxYasJp9sLnStjC3c221Ta8Qt4C9yUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUnKd2k7j4hXHXUd46rqtYsrumhxATHRY8DFRgJ5AMI=;
 b=RS1cm3su/cpsg9/6k4yhlW2Z+QVpCDvnnJYJxioI5v5gKZZJ7vhSz1CNk/r4nOZx7jXOR5ae7hjccZbjhdulKBt+uva6dD6bZXruphdmQ6nOzO54eogr42+s3L2tFvTIDqBSzJRUfmQiRodEeVFeF65++9Y0s7RYPpbtQK67Sg4=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1574.namprd12.prod.outlook.com (2603:10b6:910:e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 05:21:50 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2%9]) with mapi id 15.20.3261.022; Mon, 10 Aug 2020
 05:21:50 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Morris" <Shiwu.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: update gc golden register for arcturus
Thread-Topic: [PATCH] drm/amdgpu: update gc golden register for arcturus
Thread-Index: AQHWbtXK8im6FE8+fk2Ey0Yxbupx1qkwzo7g
Date: Mon, 10 Aug 2020 05:21:49 +0000
Message-ID: <CY4PR12MB12879EC1632D1B8AA91F18CDF1440@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200810051527.4384-1-shiwu.zhang@amd.com>
In-Reply-To: <20200810051527.4384-1-shiwu.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-10T05:21:35Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=a5d9586a-baad-457a-aa9f-0000da2b9cd6;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-10T05:21:47Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: bb874a25-1c71-43e5-aaaa-00003d4634ea
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e1f2849a-c049-49d5-37a8-08d83ced48e5
x-ms-traffictypediagnostic: CY4PR12MB1574:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB15742235FE3922BC7C5519E1F1440@CY4PR12MB1574.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5WdlvNd2O8FZq3nswDNSTlwq63MptDIqDuhPFhqnWUUHS2jQ/CgBMmoRATFwGPxJRk6R4xRkIc7ruQl7dexnLaUw/SEtEDjQ13TRnkYTg6FuJqIzwHqCnB75WVIZGVKC61RYtIyZm4fO64Gk2bmbbRI0q538Zn8We4mSnBgMbjtJzqxcXtr0WU9yBjc0R8aSj1D+LSymZGDs4h2pITLXXeyXqYhSYawXRjkPVdPJz/f4RnXH91L40t9Q7f7z7LIejhB41/EzzI5bA8QDEOnnPskqikysm4AJ7tFAOUHnY5ExvzyeCiZkjuvMLn7vRa39psRsbY5LBtgd2l9HQRcMQg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(53546011)(6506007)(9686003)(55016002)(83380400001)(2906002)(186003)(110136005)(15650500001)(71200400001)(8936002)(7696005)(478600001)(6636002)(66946007)(33656002)(66446008)(66556008)(52536014)(66476007)(8676002)(64756008)(5660300002)(76116006)(316002)(86362001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 9GbLDwt3KIsTVqhw3uh/zWAaSvYeXrRqDdwTVfncg+koiG7txOEgjAuVcu3gV0uqFDVPBuJvIsje8jiTjM15pIsowoMmPQD8euCDYuL+sm2x4SGKXXH/9X/ZFFgxsD+iTqour4S2yQnPTntZUkQRrJQOGIPestghk3QHjz7gCdMgESjnyysNu8BOSH7nGckdiTNMcxQ6KJyzx7HyW8af+xusme14lyVsfDjH0d83bh2Z3bpljV8F9LIQNxBHjER07IIJFWLbhUnih4mC7NCZLcPS66iA/sp9LfkLEmIO9szKR1Pr0qMNyOysfVlEBoNbbiYHMBOEQAj1z0LG0s4UJ7HfegWjD5r1FgWVGtlaPHkW9K5jYCgoyQs6b5Zjskk3IWTYhBYxL2xPTGJxlx4xcohYvXWgKvlIM8fWhlLDfjZl9WkQSKB+uyMHM1k5xeDvUp6Alz0C+8NL5C9xKCQw9K33sHI7cZOCCKWxbuolewwDN1mRl+NkNr+OU4zweN6dYzIfGdLmkj2GG4lpj1jfi0U5m+yjJSeoMDbwCfOOmSafnOW4ZDMhbSQnEZPhw65sstxHVDYMkPHQkiIznIyzh36sVZ960QkfHMxVm+4iZDYPszUBYuaWxJrCNuB57WXymob5MlcWknCRmC3bpkRUdg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f2849a-c049-49d5-37a8-08d83ced48e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 05:21:49.9852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CqzD8wbbUSc0Xk2PNLoB8iul0H+xQtDlluGk03GR3ggjjN/VhnKV8Q7NbEqKL2zO0ENuDWBFEjooBv1nP3z+9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1574
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Zhang, Morris <Shiwu.Zhang@amd.com> 
Sent: Monday, August 10, 2020 1:15 PM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Cc: Zhang, Morris <Shiwu.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: update gc golden register for arcturus

Update golden setting to improve performance on HPC and ML apps

Signed-off-by: shiwu.zhang <shiwu.zhang@amd.com>
Tested-by: gang.long <gang.long@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 294c1ca2bc97..b5a6ab1a1cc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -691,6 +691,7 @@ static const struct soc15_reg_golden golden_settings_gc_9_4_1_arct[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_CHAN_STEER_5_ARCT, 0x3ff, 0x135),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_CONFIG, 0xffffffff, 0x011A0000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQ_FIFO_SIZES, 0xffffffff, 0x00000f00),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTCP_UTCL1_CNTL1, 0x30000000, 
+0x30000000)
 };
 
 static const struct soc15_reg_rlcg rlcg_access_gc_9_0[] = {
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
