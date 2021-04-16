Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239BEC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 06:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9436F61006
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 06:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9436F61006
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D66A6E12E;
	Fri, 16 Apr 2021 06:49:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 950B66E12E
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 06:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCKpsZa7nHNOBkGlR7NO5lFL462E7H1i2cT45MXnbmGBOvK5PRzpCpQT4Mjr5XQbpRmDHfT11UrBaN6F3Gz/IryqGlhCXhe4FiEzxAD0iDabBEY/4IfFCtviwcc5ghM+7g5b131H2Jzq2PY+SQySdDbF622nralD3Jcf4yqgK0xgaB2kQz2ROWjhN6uhSQ/9xFNp8ffwumNrDUb0azR4SSTkT4yY+hI1Jmyfg18cJqfLu/oefdPBbCZpZm7+td5Pbv1/k2AbNIlfvpxaV/3oGWtUx3lpxRJC6dS0T3akfWw0kmL7I3DnKpi5ulMKhhMA3M+/1ZZiV/YZC6kO7ud8ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Li9Juz7VWkGLkm840CY/pXnOVqwl0N5s4WqJbRvrV1Q=;
 b=kL65gNUU4IoXrXbItxOMb6+auLSwlqzc5PCeZ8zdA2pCugNe7bDyrfPydlPnJK3D6t+oIdaf4ETSpyh77Tf5P0s3gKYsP+h3A4V7CD3qhUNi0bT/0/OQx6beuD00XimNJ0k7L6Scq0cF8oRRJjJSkVy3sPwMNew+1bZO/O/FBhq3GOrZkZfb10bRVrLdMzB7YAOc+u0M3mJzQWGYcZbD5FjPPfOCFTB5psX3htWLe9XMrctlj0UvmynhtLaPhoGDQLWhDl/np77FzBdBZfyIlU9bqyleWNBnbqFR2V2MrsrjbAZn4JKF75XRIs7bHIL3B1Xx3cRbrUoMjKGgpmomWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Li9Juz7VWkGLkm840CY/pXnOVqwl0N5s4WqJbRvrV1Q=;
 b=1rZM8SUd0JtCER5AmloJ/PCgocKVNHV/HC7euTzGNsceal8+xyksBKYxMY/HnP7Lv5p4ZnZy2iaHsGmpYQ30CEMOV7SZWBUr3+WhGgYwW32bORSR0XnErw+GcTUP9AZQc0advzUzTOl3CDEdrb9K4zPWE6a0or9vGrjLTYvujSY=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Fri, 16 Apr 2021 06:49:17 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::155a:2920:d3ab:e18a]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::155a:2920:d3ab:e18a%7]) with mapi id 15.20.4042.018; Fri, 16 Apr 2021
 06:49:17 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: correct default gfx wdt timeout setting
Thread-Topic: [PATCH] drm/amdgpu: correct default gfx wdt timeout setting
Thread-Index: AQHXMow/O7iQnTE3rkWHI7yRbVrkQ6q2s/fA
Date: Fri, 16 Apr 2021 06:49:17 +0000
Message-ID: <DM5PR12MB253381F3C226AB8275D75D34ED4C9@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20210416064609.14167-1-Hawking.Zhang@amd.com>
In-Reply-To: <20210416064609.14167-1-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-16T06:49:11Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=88b98316-576b-4feb-a09f-99ba144c96f1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb620860-a0b6-4904-1946-08d900a3c177
x-ms-traffictypediagnostic: DM6PR12MB4329:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB432919DB3DFC13CBED4CBD55ED4C9@DM6PR12MB4329.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pzPOxB1CZGMfrRcvtfRcXFqyT/p8hh+eUZX3Se86ECQBBZ5wVd6EOh782d7YGLwD13obP91JuoFRECYA5gPEYUicGboQ5iAIj/3ml8qws11V55K3YXN4eXvaP7jlHBvIJ/6WoV22wVJ74hcm+Wt9UNwnX4XKrA51onSsetk1SnraokUZ8Z2sWQMdMrPs1otC4fJ/P2mNGxjXIzslpImvag23aoURWIt3PFm6u87U+HM4m+puCd09eQEb8qHsvJdEOj7T+g4iyfLteMqzBS39/AygcdmL7rRS2d+xL6VbY/WRKqdZyNw9bRukFnJW9h8LJ74fq1eRBU+2e8FmVLmkFCZn3vhIAkNSjKezCUEUwYa2bIKK8qfvN3UBV92Hl0cQZ/u62ipQSrDuvjHzHK6MdC+SSfWThz19jDzo+jGvNFX1Tx8flKvtfdmac7MHnu/UJLyz9UY/mjW+8GX9fASd9h6X64PF1AoRnXy6oNrRqsirOHQDwdBugP86IbCiPN6KXWRytShyUCgn0a8+aRU6ogoF2kNHK9ZJWBNftDuf6apXPIR6tCjNnQD3BCUh/Wa+7j/mw9/i7fc+4u3uL+7sIpO0PI2T/0DcWcJP7N51mow=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(5660300002)(186003)(8936002)(33656002)(122000001)(8676002)(53546011)(316002)(66946007)(55016002)(66446008)(66556008)(83380400001)(66476007)(110136005)(38100700002)(6506007)(64756008)(478600001)(86362001)(2906002)(71200400001)(9686003)(26005)(76116006)(7696005)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?aXZzb3Vjb3hHdHk3ZkRjem9YdmRtSWxDSWZRRnpIcE00Y0p5MWFDeWdsc05F?=
 =?utf-8?B?NnloRG9YZC9xVDFyMUJyOWl4bit4Zk9yMWhMNFFJT2gzcGlSVUZ5SE8xVm1a?=
 =?utf-8?B?RHBQSm1WamdVeGxrNHhoN3IwdTNjd3FzbndaUXJIVmY3MlFtR3ptRkF5eWNk?=
 =?utf-8?B?bGFzUGFINHgrMGhrVEJLTzRTR083bTRZNHM3dldPeFZoc0xULzdCeU5SeUZR?=
 =?utf-8?B?Zk9vRTY3TjdGSXVUV0NkYUR4SEpYMXN5YkplR2pLbnhBSTgxbk9WajAzbDA3?=
 =?utf-8?B?Wm9ZbnNSUlhiT2kxc3dEZmxFbzFicWpFbDZzb0p3c2JlNDYrYk9ETjg4NEZL?=
 =?utf-8?B?UnVJRGJhMDBWRXZIUXFWYTRDdW9oM2pkVGw0MCtXdVN1elFCS2theHp0M1RE?=
 =?utf-8?B?Tkwzb0tmZS90UG5mOXVRSUplcHdkMDFoelNyTS9YMzh2RzBJYXNyU216NmZM?=
 =?utf-8?B?UnZTelA2YmtzeG43V3owSEVmbnpCL1VEenc4emNKVXk1MjZ6TENXMW03ZU90?=
 =?utf-8?B?Qmc3MlZiSVVua1JZMUFjUUFjS0d3Z3dIdU5vR29mbWNlTWllT21lNlIyYXRx?=
 =?utf-8?B?WWhGdnpTS0dTY1BqMHdzaXZaRVB3Rm9aYXYzUXY3NzRUTjBtQUMwM0tFRnNB?=
 =?utf-8?B?WFJuUG56ZXFTcm1xV3Nab0M3c0pBWGxZeDVXZnVjNm5ibHBXNUdzNm96TXBW?=
 =?utf-8?B?eVh3c0llWnZDRHVSOFk1NFlBWCtyZnVIMmx2Wll0QVlxcm1kUmVuQVUyeTZO?=
 =?utf-8?B?TDQzaXJmWlBFZURDUy9sYVdqZ1laYjFKUUN2TnF3elY5dk54Zm11M3AxM3ZK?=
 =?utf-8?B?NHJLb0Z0Ujl2VnpBSStKelFYWEdMRUtaQVJRZjArRkVPdmJ0M1d0RC94WHVh?=
 =?utf-8?B?dCtjZVpyOXRIbStqQ2dhbHVlTE85ZGI0djJrS2I1elJGZzAyaFk0Z0RROCti?=
 =?utf-8?B?UVZ4V1VIR3J0bkx1ejJRejFKZDliODdqSzd4UTV3MGgyd3I5TFhvSm51SCtz?=
 =?utf-8?B?YzBOampTTzlORm1EQXRTeHU3Z2o0bnB2NTBtN2JXUHlUS3Vzcldoek9ubmpq?=
 =?utf-8?B?by9yZ0hiV0NBUk1vcnNLNDZlMzN0THZqQ2lETzYxaXlrNFhLdzhUcm1xNFRJ?=
 =?utf-8?B?QVhMME5BUTJlMXJ2L2IvZTJFdXRrT3JFVDI0Nm41bUlySlBFbFEwaWFuMUNY?=
 =?utf-8?B?RC9lMlNkSnVlVTB1Z2t4VjdwejJ5ZGN1RCt6di9MVTBWMWxZa05yczY3WVFJ?=
 =?utf-8?B?VTJNRFR1SVZqLzNQYUZ5SzhNU2ZhdEpQL3dKdGwrTkZ4ZE43bXlKZUU1TEto?=
 =?utf-8?B?TUhURFowSGhrM2RraEVRNDBBNTNaVWxNblNFRTJTRmZYNEdlVlkyNjBWaU0v?=
 =?utf-8?B?SzVlMk5PR3drYzFrMzU1YXhzcjNEM24wZGZCRjE1d0VjS3g3ZVNEc2VXSWp1?=
 =?utf-8?B?WTREeVNrV3BpZWVkb2ZLTm16b1Q5WlZpNDZ6QTA5VmhnVERlak90YURQaFZW?=
 =?utf-8?B?TXQyMjhFNVA5Qm9VTkEwM0lERVFmZUgyVkc3dGlobk9KajE1eWFhZ0EvN3dq?=
 =?utf-8?B?b2hOTi8xMDJPKzhvb01hbHNlaSs4aXBYU3JFME4yQWpFSGdqbER2amx1TkM4?=
 =?utf-8?B?N1BvZHZXOG9xK0tqeDJ0Z0lWb3NkUFd6ZVRtZnJxaFJyNGN2aUtwRkgvK1Rh?=
 =?utf-8?B?SmdFcFlLUDhERm8zSDBDM3hoSVEzdVFHSGlmTFVqbVFiS3VrSnZMdXFpSGJO?=
 =?utf-8?Q?J0TH/YKo1JUU42LTrfwDa31+A2lFAMh5YtNDAXD?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb620860-a0b6-4904-1946-08d900a3c177
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 06:49:17.3843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EvtRb92QCGxpQcU43imn16tS6fR3hSMyBMyhqH4TbHmgiSciL7lPZ1YAr6HsWZRG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329
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

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Dennis Li <Dennis.Li@amd.com>

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com> 
Sent: Friday, April 16, 2021 2:46 PM
To: amd-gfx@lists.freedesktop.org; Li, Dennis <Dennis.Li@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: correct default gfx wdt timeout setting

When gfx wdt was configured to fatal_disable, the timeout period should be configured to 0x0 (timeout
disabled)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f856a2e82f94..7d9b954bc0c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -189,7 +189,7 @@ uint amdgpu_ras_mask = 0xffffffff;  int amdgpu_bad_page_threshold = -1;  struct amdgpu_watchdog_timer amdgpu_watchdog_timer = {
 	.timeout_fatal_disable = false,
-	.period = 0x23, /* default to max. timeout = 1 << 0x23 cycles */
+	.period = 0x0, /* default to 0x0 (timeout disable) */
 };
 
 /**
@@ -566,7 +566,7 @@ module_param_named(timeout_fatal_disable, amdgpu_watchdog_timer.timeout_fatal_di
  * DOC: timeout_period (uint)
  * Modify the watchdog timeout max_cycles as (1 << period)
  */
-MODULE_PARM_DESC(timeout_period, "watchdog timeout period (1 to 0x23(default), timeout maxCycles = (1 << period)");
+MODULE_PARM_DESC(timeout_period, "watchdog timeout period (0 = timeout 
+disabled, 1 ~ 0x23 = timeout maxcycles = (1 << period)");
 module_param_named(timeout_period, amdgpu_watchdog_timer.period, uint, 0644);
 
 /**
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
