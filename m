Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8ABC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 15:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F25361968
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 15:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F25361968
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE61288862;
	Mon, 29 Mar 2021 15:37:47 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770055.outbound.protection.outlook.com [40.107.77.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D93288862
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Mar 2021 15:37:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KW/KI6vPCLFkVs36/alN4nDmGv13mfSyOn1ZobXvs4vr1fjdLqpxNhTop+j9yeFRUXPyTBKD6wF2F/aJy/4F5OzohXMJnvyBWikYEOlVOIlgnmiG2Na7h9fA3I5q8wrrn5ygbSsVaEmG3z3+8/JCAPdSlyA+l/qqPlGHJQpiZcCu9HRmqcompvoPmhXToR10L6vP6IPdi0qKUCcN5lsLc3wqnYabzZbO/VP1sU+1WQ+kEqwlkfXCkyx6R0vJ78jM9ukGjIhW2djxPxUGclaMrw04CGJSWeTjPb52WNYSB5zhr9KRrpRXI3uM+/xSGFICtxZAIID05JlXqXcOxol+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XruWdUr+ALR445UXOxBoleE3sTPGZ9/QWN0oSF5HP3Q=;
 b=itlNq4jnxZat0FYv9cg7IxnFsWeXjXKLp+B/oHJ1vzEpUXVfXowlWE2l6I78n6oly+FItG3DD58dZpYtJo9lxCY4O1WIerPNI539mDDuQjativRM6/Ow542ZYSrA2V/MgTz6IK6oMpo8QbNEKomCzD47YsCH0kvC/bYyBlze7malF/UAf30ifymOwgogwI/P3UEjO7XwmSZsKJ9KVIQxUSvelTMfFrexg/hzpSQQfRdh2US4TZqYGSNiNh7GiT2L9bZ6lXXfd1KoMJ0vjte3DW5DRNUaho8R/Ir9cHXxIyKx5vdVLnHdydH2pAO7xqWd0/pG4sNorVqRm4TE7xSO4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XruWdUr+ALR445UXOxBoleE3sTPGZ9/QWN0oSF5HP3Q=;
 b=Lw+3oNyLoCXk9Va4WCBM67KqrXZgSKH8w7D3rZxZV5oFEEuwvqqItr31oYQ9Ag7ZwCRp4xCjqMGSMP6S7ZWrUWHJw2Un1KTU2IqoChIeZ3z4yE+YcXTAhtBqKB6DSeaNKT99AbnTSbqp/O6A69n8A/+eh5nk0h558f+OJm+W9v4=
Received: from DM5PR12MB2551.namprd12.prod.outlook.com (2603:10b6:4:b9::16) by
 DM6PR12MB2873.namprd12.prod.outlook.com (2603:10b6:5:18a::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.32; Mon, 29 Mar 2021 15:37:45 +0000
Received: from DM5PR12MB2551.namprd12.prod.outlook.com
 ([fe80::40dc:f71f:308c:fe79]) by DM5PR12MB2551.namprd12.prod.outlook.com
 ([fe80::40dc:f71f:308c:fe79%3]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 15:37:45 +0000
From: "Ma, Hanghong" <Hanghong.Ma@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>, "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
Subject: RE: [PATCH] drm/amd/display: add DMCUB trace irq support for DCN302
Thread-Topic: [PATCH] drm/amd/display: add DMCUB trace irq support for DCN302
Thread-Index: AQHXIklrJsZ7NRg+Gkix6FpTGeuUoqqbHZIA
Date: Mon, 29 Mar 2021 15:37:44 +0000
Message-ID: <DM5PR12MB255165FF12D92A31ADBD7289F17E9@DM5PR12MB2551.namprd12.prod.outlook.com>
References: <20210326140733.23919-1-guchun.chen@amd.com>
In-Reply-To: <20210326140733.23919-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-29T15:37:42Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c20af594-7e4c-46bf-aaff-d741d182f455;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51a0f1e4-cf8b-4a7d-853a-08d8f2c89943
x-ms-traffictypediagnostic: DM6PR12MB2873:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB28730340DDF3763AAE74B62CF17E9@DM6PR12MB2873.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yB7KwfkjvZA7Ffa4JW4y07Sr8WRcnN4a0SrYYHSnRIWm3bGPZTfnDkjOIxOMTnr5BekC1SxI0UclQ9oswug6vVwp4fAEl+m35Ma+deXHQB+OCJ5h4G3B2IFBBk49pB+ZyH2Lc8oiwh27ZKQCG7WURhtqubySAd1ajjpHgtAOKBhxuFavwLGUTCx1ylijul29qGBW6EeWQvnCU7r1D1ST2610ESHmB1l63nPHw+z1IByV1jYQ3PtiSg+/QGDzlp4qFlvALAXvhF51P+xYzHPjGCOeIXSUWUJljLOU589Qjr4xaGvfG7IZrNlx604VnM+Vt7x4BVpqQ6X6eFJXRfSplpYqO+Ta2i/x5LzHECiFVpnRGlDnFVcFx3MJSqXJuzozn8CTHk+Q+gF1VRLmpFfXbjyoiLvyZl5BHHMe0RAhLG+y8Tu644Wz906MR2vY5y00Xe1aEBnm6zXkBfy16WqWteK0zp02G0ZM8O1NRyEIvslogI7YG+1XbIi2NzQyLldNK7Di+O/0yWa3G8r5NycADF+Goz4SKJNfVMFfuCzaHRnVGHo5g2IDGzgGKA+ULp0GsAmsxKsHVmRNYzulneSjkp2AllCEQ4pIYO2dd/YHryIqr6x1eSBsWmVwTjXT/Gw7dYS6GtHV3C5LdNchhOxPs4ixpfmrzxUxE/19je78Wb4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2551.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(9686003)(316002)(83380400001)(76116006)(71200400001)(66446008)(33656002)(66556008)(478600001)(5660300002)(64756008)(8936002)(2906002)(66946007)(55016002)(7696005)(86362001)(8676002)(6636002)(6506007)(53546011)(52536014)(26005)(66476007)(110136005)(4326008)(186003)(38100700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?u9KEYcjwEX49/ZRC7oWBMl9ls6KE8uavvZYTOF2ncuzSphKYuSjGsLprAfSz?=
 =?us-ascii?Q?4fCkmKL/zexKscUgW/YseZAzXw6hduOOG9wYuFnqBZpcEUdJhBE9uoH7K188?=
 =?us-ascii?Q?ji1RDwt0kn2hOd86OyBMKX/eF1koYXkg1IztcpJv+UFMQkb7Xnh7I5xaqRuv?=
 =?us-ascii?Q?9AT1RUfxBf6Jqb5blkvSTm9UD6kTh4LHTsEILPn2BMsX6sSV2MoapSvYwzfu?=
 =?us-ascii?Q?9Mb+qa9m09iwgN/2DKiO0/pYrgSSXd9vFlijcDA8raNug7tP0r161+Ic79kA?=
 =?us-ascii?Q?HmQyk0QyBiDzTARpugP0GFfwBqpjkTeWDnms5QCwn+54X8av/GGCg8C5sMeb?=
 =?us-ascii?Q?0YOYvVitoNVjA3wtI76KKWaw9Lbkwy8juVT835i1n8vffLOKCORzcvKfh6kV?=
 =?us-ascii?Q?j7QZb4njyGXwihizKV0T8rvzxpihbWQjhprd153NYp7WaneJuwgiEAr8TBa2?=
 =?us-ascii?Q?In1nDML8RCHKDvKpYQ2gmatwx2KeIC2qXDpjaf9JnqxIRv7DWwbFCnNP8cqL?=
 =?us-ascii?Q?1Nds1+j2eYyktUyBXmjnS2Zbx72s+5YDplwg25fnOu2gpwMh7zESDXBMY6KO?=
 =?us-ascii?Q?LmjMovbd2zIH7nmib5HY9jcJWMLkxraM2pObZ/sIV6Adaw6Lp7gr798iV/l3?=
 =?us-ascii?Q?uWedRfNRzX48d13FVHHGV85mvhq9mPXjbqrlLmIUBRhWY5NlJDg92KDgeT/i?=
 =?us-ascii?Q?RXXK4c2xorNe89Y3g6MQbFWcFBICyZ2uWR1Wgs2QyV/xNm/jPpyrdaejDyi6?=
 =?us-ascii?Q?NeRzkXXdilD59r/1nwvcPTiuvKNfiQokaIQqnsCHCdMv1AGMmASN8eBT17vl?=
 =?us-ascii?Q?M2rvepGmeMhUal98q7xKQ9LLsF0EW3vxrxm1kHn/YC/79E4aPwQbuyA9zF7x?=
 =?us-ascii?Q?gi5OObRLZEjR1w9ehdUXXjc903tQyNlUhzI6Otev4K8pu8Ilp1HAqoAIFXAB?=
 =?us-ascii?Q?0tNN3INbin40SVh4daX8u907uSM8AKSHHtvctyh6VgrKpaFsJ78hZ2TLAw19?=
 =?us-ascii?Q?ehg1bmbu0DCkGMhmQYFb56aBj537Dk8GCu6Za67nFtyfr/Izvjc7ilWHQTR8?=
 =?us-ascii?Q?BcDVeM9oLpmdRf3EHlIEfZ88XlNGV3CVsdgZoK/u1Ybis4xeGqZ8ocxSIgT6?=
 =?us-ascii?Q?hekeL+OEu1H06S6PI0jvRUli0xwaIkJlTEldoTQK7ZOrq6Q7gIx1AFoo31xL?=
 =?us-ascii?Q?0v3/jwfmfaPB7gaS70YG5TuFmaKuEe1wNhWyhTp9GFhtxEiODRJDZLDNCgFg?=
 =?us-ascii?Q?1nypHD+VqHM5wuJPVN2oOjWbv+zY54H1WCxb3CwGahnJpIGPQIfe9zQqY2HF?=
 =?us-ascii?Q?IospEkELTyhmOdfThz3EXPCl?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2551.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a0f1e4-cf8b-4a7d-853a-08d8f2c89943
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 15:37:44.9976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wUYbX3NhEktEUeBsCZFESkWA6/zjRHHsl45FTi2EdNV7LhTOjqWrlV6uTomaVuMptBYDoAACeCVSwg8dWdLQFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2873
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
Cc: "Ma, Hanghong" <Hanghong.Ma@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Looks good to me.
Reviewed-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
Thanks,
Leo

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Friday, March 26, 2021 10:08 AM
To: amd-gfx@lists.freedesktop.org; Ma, Hanghong <Hanghong.Ma@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amd/display: add DMCUB trace irq support for DCN302

Otherwise, below errors will be found on DIMGREY_CAVEFISH with DCN302.

Error log observed in driver load:
[drm:amdgpu_dm_irq_register_interrupt [amdgpu]] *ERROR* DM_IRQ: invalid irq_source: 0!

Error observed in mode1_rest sequence:
[   27.265920] #PF: supervisor read access in kernel mode
[   27.265941] #PF: error_code(0x0000) - not-present page
[   27.265956] PGD 0 P4D 0
[   27.265967] Oops: 0000 [#1] SMP NOPTI
[   27.265979] CPU: 0 PID: 1360 Comm: cat Tainted: G        W         5.11.0-99b3786c1770 #20210323
[   27.266005] Hardware name: System manufacturer System Product Name/PRIME Z390-A, BIOS 1401 11/26/2019
[   27.266033] RIP: 0010:dal_irq_service_ack+0x25/0x60 [amdgpu]
[   27.266203] Code: 5d 5d c3 66 90 0f 1f 44 00 00 55 83 fe 61 48 89 e5 77 27 89 f0 48 8d 04 40 48 c1 e0 04 48 03 47 08 74 17 48 8b 50 28 48 89 c6 <48> 8b 52 08 48 85 d2 74 20 e8 1d 64 45 c9 5d c3 89 f2 48 c7 c7 f0
[   27.266248] RSP: 0018:ffffa115824a3c08 EFLAGS: 00010082
[   27.266270] RAX: ffffffffc0942c10 RBX: ffffffffc0942c10 RCX: 0000000000000000
[   27.266288] RDX: 0000000000000000 RSI: ffffffffc0942c10 RDI: ffff88d509cba7a0
[   27.266312] RBP: ffffa115824a3c08 R08: 0000000000000000 R09: 0000000000000001
[   27.266335] R10: ffffa115824a3b20 R11: ffffa115824a3b58 R12: ffff88d509cba7a0
[   27.266353] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000246
[   27.266377] FS:  00007fb3e2438580(0000) GS:ffff88d50dc00000(0000) knlGS:0000000000000000
[   27.266402] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   27.266417] CR2: 0000000000000008 CR3: 000000083e5ac006 CR4: 00000000003706f0
[   27.266441] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   27.266464] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   27.266483] Call Trace:
[   27.266491]  dal_irq_service_set+0x31/0x80 [amdgpu]
[   27.266639]  dc_interrupt_set+0x24/0x30 [amdgpu]
[   27.266775]  amdgpu_dm_set_dmub_trace_irq_state+0x22/0x30 [amdgpu]
[   27.266920]  amdgpu_irq_update+0x57/0xa0 [amdgpu]
[   27.267030]  amdgpu_irq_gpu_reset_resume_helper+0x64/0xa0 [amdgpu]
[   27.267135]  amdgpu_do_asic_reset+0x211/0x420 [amdgpu]
[   27.267232]  amdgpu_device_gpu_recover+0x517/0xa70 [amdgpu]
[   27.267325]  gpu_recover_get+0x2e/0x60 [amdgpu]
[   27.267421]  simple_attr_read+0x6b/0x130
[   27.267441]  debugfs_attr_read+0x49/0x70
[   27.267454]  full_proxy_read+0x5c/0x90
[   27.267474]  vfs_read+0xa1/0x190
[   27.267486]  ksys_read+0xa7/0xe0
[   27.267501]  __x64_sys_read+0x1a/0x20
[   27.267521]  do_syscall_64+0x37/0x80
[   27.267541]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   27.267562] RIP: 0033:0x7fb3e2356142

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 .../dc/irq/dcn302/irq_service_dcn302.c        | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c b/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c
index 2313a5664f44..40fd34fb1d5e 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn302/irq_service_dcn302.c
@@ -50,6 +50,8 @@ static enum dc_irq_source to_dal_irq_source_dcn302(struct irq_service *irq_servi
 		return DC_IRQ_SOURCE_VBLANK5;
 	case DCN_1_0__SRCID__DC_D6_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK6;
+	case DCN_1_0__SRCID__DMCUB_OUTBOX_HIGH_PRIORITY_READY_INT:
+		return DC_IRQ_SOURCE_DMCUB_OUTBOX0;
 	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
 		return DC_IRQ_SOURCE_DC1_VLINE0;
 	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
@@ -166,6 +168,11 @@ static const struct irq_source_info_funcs vblank_irq_info_funcs = {
 		.ack = NULL
 };
 
+static const struct irq_source_info_funcs dmub_trace_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
 static const struct irq_source_info_funcs vline0_irq_info_funcs = {
 	.set = NULL,
 	.ack = NULL
@@ -181,6 +188,9 @@ static const struct irq_source_info_funcs vline0_irq_info_funcs = {
 		BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 		mm ## block ## id ## _ ## reg_name
 
+#define SRI_DMUB(reg_name)\
+		BASE(mm ## reg_name ## _BASE_IDX) + \
+			mm ## reg_name
 
 #define IRQ_REG_ENTRY(block, reg_num, reg1, mask1, reg2, mask2)\
 		.enable_reg = SRI(reg1, block, reg_num),\ @@ -193,7 +203,26 @@ static const struct irq_source_info_funcs vline0_irq_info_funcs = {
 		.ack_mask = block ## reg_num ## _ ## reg2 ## __ ## mask2 ## _MASK,\
 		.ack_value = block ## reg_num ## _ ## reg2 ## __ ## mask2 ## _MASK \
 
+#define dmub_trace_int_entry()\
+	[DC_IRQ_SOURCE_DMCUB_OUTBOX0] = {\
+		IRQ_REG_ENTRY_DMUB(DMCUB_INTERRUPT_ENABLE, DMCUB_OUTBOX0_READY_INT_EN,\
+			DMCUB_INTERRUPT_ACK, DMCUB_OUTBOX0_READY_INT_ACK),\
+		.funcs = &dmub_trace_irq_info_funcs\
+	}
 
+#define IRQ_REG_ENTRY_DMUB(reg1, mask1, reg2, mask2)\
+	.enable_reg = SRI_DMUB(reg1),\
+	.enable_mask = \
+		reg1 ## __ ## mask1 ## _MASK,\
+	.enable_value = {\
+		reg1 ## __ ## mask1 ## _MASK,\
+		~reg1 ## __ ## mask1 ## _MASK \
+	},\
+	.ack_reg = SRI_DMUB(reg2),\
+	.ack_mask = \
+		reg2 ## __ ## mask2 ## _MASK,\
+	.ack_value = \
+		reg2 ## __ ## mask2 ## _MASK \
 
 #define hpd_int_entry(reg_num)\
 		[DC_IRQ_SOURCE_HPD1 + reg_num] = {\
@@ -348,6 +377,7 @@ static const struct irq_source_info irq_source_info_dcn302[DAL_IRQ_SOURCES_NUMBE
 		vline0_int_entry(2),
 		vline0_int_entry(3),
 		vline0_int_entry(4),
+		dmub_trace_int_entry(),
 };
 
 static const struct irq_service_funcs irq_service_funcs_dcn302 = {
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
