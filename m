Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4937DC433E4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 08:46:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1913D2080D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 08:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ro9aRLDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1913D2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9AD56E86B;
	Thu, 23 Jul 2020 08:46:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3B046E86B
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 08:46:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrH244CeTcxmCqSQ0n/IhktbMSrrkXmLBsMEYEX2lPd3fXlRuVS394yomtELipvhDIvfS5HRT7JVhpiniddj0QNsKVMgzG7fv3gmTZ84bjKLSbKBwEpA/FtvQ255NTx2gmgZiviIBWmJlnEY9o7jgXfvka0yyPiyHJGivpteLMtwfzOPMcnwD4I/xDpuqVO0ca/vi1o+VfOI+LsiNSUmc5qNYmgTvori/qqnaZ0YKgAk6/W1pI/9LJvNcygrrZyrBKaS3Z81mxrOlmsWTVg7T+1nCRXaQsAd/8cb9IphEMogzniCA0h7zoXfmUgyXCIu/w9mXq/tMCgoVfjBMNKclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r41LFzDgouY5/YBJ4FqCwubp3olJsERMVIr1lH5pg4I=;
 b=DWt1PmPSQgdNAOiNOdVHXizYnLYvc8o/pZm8Tzgty0qc8lOdZhfUMRkEvgjZmO7837xxSm7Jx02mdLBqqaNeqc0yalCCwkRUHm8llpRI5W6DoQ43E/gEWWKKIcCU9tFTDuTGxaN6fvKISLYBMGtKzLpjLkvXIu414NHFLGa2lGJgn1r8pdJ8GaM1iHn4PaZbCxM7TEPewS6DJPwAefUPW8k+fWexbSNMsIckXUlEGf+AluUtOuAwU7NH/4Slo9ZYB1DjC5OblEGSotFJnuLABSBDf2BLcungZiGsXno5jPJisfUWCbizw636raSVkkYr+gH0HIJJItBcH8d3vQq4jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r41LFzDgouY5/YBJ4FqCwubp3olJsERMVIr1lH5pg4I=;
 b=Ro9aRLDPi9r3AlJWF9RJ0Dd+wPz1n9tqTRSTvfPlm1kTzA59Dd1DSkz45rL9xHEIgG1bx93R5kZDOo/fDlrVvgt7LudwmGW9IsgCeq4jbUbM5mCEbCsSZb20/NgeMLr3qlp+0RRRZ8xN8jzGKDibBS0AgBjHwgYgip5zFglY9vw=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21; Thu, 23 Jul 2020 08:46:21 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::84dc:a0e7:6158:ce4e%8]) with mapi id 15.20.3216.021; Thu, 23 Jul 2020
 08:46:21 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update golden setting for sienna_cichlid
Thread-Topic: [PATCH] drm/amdgpu: update golden setting for sienna_cichlid
Thread-Index: AQHWYMO6bZfWH3lgYEqRZMUprMMzRKkU2dWQ
Date: Thu, 23 Jul 2020 08:46:20 +0000
Message-ID: <DM6PR12MB407597296DCFA18A33587359FC760@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20200723073421.362630-1-likun.gao@amd.com>
In-Reply-To: <20200723073421.362630-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-23T08:46:17Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=44563b07-51d1-4221-ba36-000090d92a6a;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-23T08:46:12Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: dad2a132-f476-4d16-9ab9-0000f91443f0
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-23T08:46:18Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 6dca8bce-0395-4a54-be3f-0000b20dc720
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d51f40f2-a142-4018-afe3-08d82ee4df8a
x-ms-traffictypediagnostic: DM5PR12MB2360:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB236098EE39FD83526F599CA1FC760@DM5PR12MB2360.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 28PkGqOiRzj79BfV+bOKWKXhx3Oq4ErrkJ187X1DikTBtHFYg+mq5rMG1TyOk54w3ueJhM7IHqCorc7p2FNZoOhFKVtMrVxDsiK7iFgXGKIFt7JZCQySNO7DUjvBMeRUT9ehtQDcJaS63u1bZtZtL0atGJBd5oQ3JEfjaN9vQFoBhXISOhvoNfMkJZXKzDGnpVdRidObFn4badYbLRn9a4s2192uj4sSNkPa0PrZ1+gYEceW8Jt387SkM4+RexaVTBaBrCMg2unj4fhPLqUC5zLUHYePDdL9bfMcZQ4cn8pyvoHQEMZga+n8MSQO3kIL35ZJLv5kJ7DelEW9MLf3Fg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(53546011)(478600001)(6506007)(8676002)(316002)(55016002)(2906002)(5660300002)(33656002)(8936002)(83380400001)(15650500001)(26005)(52536014)(9686003)(66446008)(64756008)(66476007)(76116006)(7696005)(66946007)(71200400001)(86362001)(66556008)(186003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: F219g/KlxeOSC/MQNoXDPWzx6Jl4cWJGiTxbbWNoirNio7etkuCvj0QjFGVl+cr3iyNwAbpmf+ehKY61X+3NViYETTWMY2dUN9H6MVoshUcU1BoaE5TfgyMJyq9y4tEWv0Psar2+Q5F+A3n9DjcDKJZBIC1Qx5HpdJe6RBYvQuslnGazIrx0A7TQnTYAYk+CgsT2EjITUHOzEw7fvoa557Pt2haRswg7w1Pwm7Zm1tTcEo8b/6pe/+zEEZaLmOgy8GTjF48sJXJnuwI28Jzsxi5XEaQWpAu1CVcWcvWGvxTKH++EbTyaF5abWe+Tr8Vy2eTDmfztHZmrDXDja1EIr4RS4XtsZCVsgXLMMcwanBTs1Kh+jawEDCG42+49cGAtN9Pq3YCCgWukOoWKD3sF7bl5bZk/xpa+TSw41p4BWlk0RRjH6rtMcagZCmiSqsXTj9V6wl2vbnzE7EhJ+QJcjubcaKnlJFN+kmNVqDO9GafhpgraBbt4yWjQp+IC8Y2B
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d51f40f2-a142-4018-afe3-08d82ee4df8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 08:46:20.9748 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TxsE1uY0Y/Np9ncTVXRFHcCt8p9pi8vDoxB64Dy3v19ap137fNl+4nGdaqQK6/2uU+jGQRc77SUwgOYNt71+Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Thursday, July 23, 2020 15:34
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: update golden setting for sienna_cichlid

From: Likun Gao <Likun.Gao@amd.com>

Update golden setting for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Id71876180033eedc10ecbabe5317369676034e19
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 61e89247faf3..8344c3b0b9b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3082,7 +3082,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA0_CLK_CTRL, 0xff7f0fff, 0x30000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA1_CLK_CTRL, 0xff7f0fff, 0x7e000100),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCPF_GCR_CNTL, 0x0007ffff, 0x0000c000),
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000200),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0xffffffff, 0x00000280),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff, 0x00800000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_EXCEPTION_CONTROL, 0x7fff0f1f, 0x00b80000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGCR_GENERAL_CNTL_Sienna_Cichlid, 0x1ff1ffff, 0x00000500),
-- 
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
