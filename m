Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8102C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 13:04:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B17761369
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 13:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B17761369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4741D89DF9;
	Tue, 13 Apr 2021 13:04:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 890CF89DF9
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 13:04:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cK4AfV9K1EulRd9p9/7kipVYPVmTLO5UP6yvvSXhR/siSgqtdqMT0bByiX+4zm57eTBkbYuNe9uLeHYRIW1xt3WoyLqJ0zhqkS2zwxhhrVAvnP2FOc4eT1nYA0OMtVHPXSiOpItx8zIs31iExdcWv6bE69+MpNo7iTuCKAQXCtdxYwSdUTu7yQ/wrcA4L4xuQc32T7wFSkXe4QDR9LKVpfEFC3nU1WfOAFR/l+gsUPBKj1uptsTsjgVYoPE8K3nWw4E3YNQwtF2USeinO1qfTO7dY594mdFuIsTWAalPFCWo5R9eAg4JbpM1hhHO6iwjUW1oFCH2e7ZeE4Jj6VmGlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tJCsFi+7v+gTII5+iKd1PGqfJ3ia+gysi+qT6TLhMU=;
 b=aEtWmJZb0EEdRqqsEwPsKMRSC6wR/xJmkuCjQrzvc4W1XM3FsbBvusq9XUgN/RVkINHJy6myur+VnNH+SwAMz5HFB+lsFkglvC+fX5MkueqS9xRukXWw4KV40zqvW52otQrhkzTSQs59U53pEZxn93t5oEpsAzEfsflPwIPfda7X4Cm/9DSkSoGkAdZMGM42a6mz00xeY2XNaCMwtDzQYgL0vcMjF4aARWOsjlQePgAg4f/MY6H/NUiTYWtwgZPm+O5qQ9uhW+Tv40z8lk1oFth3RyVRyoJMHfX4Kf10NxCxMrt++vEt9pECwfP/AhafBgaK1BGgBUdQ7GeB3++IIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tJCsFi+7v+gTII5+iKd1PGqfJ3ia+gysi+qT6TLhMU=;
 b=bnUQJAAjVRw/OFissvLkrXo7YpFll2GoHVplOJWvMxWGX3cQ+eLS8A2nXfn5UnjKfz5eNa8Dt5j6DtAV3VJAQwMK6AfpcwpAmkvZMLU6YRrAdjEyET22LTkyqLyHEMQhHBUMSXZGvmgIUydPfXsrDbnxbTTwrWYYcz3eLvUoXdY=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR1201MB0027.namprd12.prod.outlook.com (2603:10b6:4:59::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21; Tue, 13 Apr 2021 13:04:05 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::c950:d447:1fd0:2686]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::c950:d447:1fd0:2686%5]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 13:04:05 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/4] drm/amdgpu: Fix kernel-doc for the RAS sysfs interface
Thread-Topic: [PATCH 4/4] drm/amdgpu: Fix kernel-doc for the RAS sysfs
 interface
Thread-Index: AQHXMGRnOZE1R4bVmEeQuMWPcvAf6qqyagBA
Date: Tue, 13 Apr 2021 13:04:05 +0000
Message-ID: <DM6PR12MB4075F8764B78EBB20D5446FEFC4F9@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210413125601.50387-1-luben.tuikov@amd.com>
 <20210413125601.50387-4-luben.tuikov@amd.com>
In-Reply-To: <20210413125601.50387-4-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-13T13:04:03Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=53e2a2b7-a561-4697-afb2-2c2dcdc1bf81;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd2c7ba9-18b5-4a6b-4ed2-08d8fe7c9e1a
x-ms-traffictypediagnostic: DM5PR1201MB0027:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0027E21CE05AA568B5174DD3FC4F9@DM5PR1201MB0027.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9iD8UQ7eFppXsgTNVwtMI8aWW8TdeVYPiDS6yI8qwk0Q2+9Vb1HzmgjeTWKzjAviW9OuYpHj1YNkyM5UVr+WgEYmii9R8AQy93GYpNcuTc5qh0RKWQddnjwitQ6H6kqWA5/vlUTPf+Zn+/UHFe7z2COT2X7Mz59zs0Zzbaang47SOKSRAaAagJMCmb1ozUUOLMbkxiO+zwCtDOr3EX+scgxc/xX6Di96d2DOaAolacKA2YssyBZsbLmPQ1n2srCVJpIlrBFozurFNIJF8Qlr6lKgLpBX90ptrOh00YQQ95CJkwJ/WMbT4M1wO42yHoPNCRstl1KIqOcD0h/TF5e9JWgwLgUZvhYcYCmWmWfYalGU988RaEB+LNc90x1p3iK91fT/MJmbFYjwRYv2TqlXAbpeqewiyz59peXgXUOPxvyh1/L8UXefmsgl67HB0wKg8BL3CehT1qloulsSPJsyGICkS43ZOOG2iX2QheA80yooIm8w9N//uW3NUm/YPtgc8nyumwr2vO7mbe6yVAy7A8dCESaajf2Yc8cLfdsPACQEYfIWsjz3PXC6JNRlpqiThlH+m15hKBihQPn8X5NJqZyDw0SyIuirDvwHmaLrgZ8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(53546011)(6506007)(33656002)(38100700002)(66946007)(86362001)(83380400001)(76116006)(316002)(186003)(2906002)(110136005)(26005)(5660300002)(9686003)(8676002)(4326008)(8936002)(66446008)(7696005)(478600001)(52536014)(66556008)(55016002)(122000001)(64756008)(71200400001)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?7mwf/+f9X1aiXl590YvejBy/T/IwFiMcKLcezTC7gwTD3q2sj01HIEr9h7Aw?=
 =?us-ascii?Q?9jhnGYI6w/16cRCL0+R3D7xirt5+cW5JK+PBt5oFMbizqVM/7HlfUJ/vat9i?=
 =?us-ascii?Q?o8m94LsKujYSRu57SNRfw+a4xc00rzE1/DeLir34w8G49MSMnTalQeFZ3wLl?=
 =?us-ascii?Q?I8CCpnp7yGDmmmPC3oxjjD3lQqwWt6G6TOj4ayIfIYQ8+N0ZCB3n1ypQoUlF?=
 =?us-ascii?Q?Z32GaMORFIlEkLdLkb2sc1oUDb243i/ZhBHWpVpO+H7y+mOJtlt/xS9ghUef?=
 =?us-ascii?Q?Umyz63Zd9YZ+M4MaFooMTbI7vENvN7XvE26jeVNhHi73uh45rvCIKgLQVOVM?=
 =?us-ascii?Q?73eXYpnhTyIulZxog9m0VFwDj4+NHR238skmE/aNCTaslv+ryZPjB7jo2oGT?=
 =?us-ascii?Q?VwWqKtASD2DrhYAbxCjWlbAkQZSThd22TrGaxxwlfr52mqgPXzveNdWmIkVi?=
 =?us-ascii?Q?xzhAwSubrR1tcFKSr/6kQL1riMHBmyJi2UnaXtKjvwBRfzQnZs+0DIOm/t1H?=
 =?us-ascii?Q?O1KuGTIA4lRK16C6dYBx6WXwTnfIVAeKYejI8tS8C6S1dSqgGuwzblm8osj8?=
 =?us-ascii?Q?mNBiqtwbmVW+EeOhzt7BBS1ag4KjtlbVon0YsFpo2tp3Ie23oSYt87DRnwHt?=
 =?us-ascii?Q?IX5Alswhk+vZ47oMmuZ7MdRG7n5vVZTQH5uZP9ZsbCWsy6DMh9GlQ+7TPelw?=
 =?us-ascii?Q?nBJdzbgaeEtuGdjEdHhE+mjhMByXEHdywoFhoPhPtwZJYzuSPgYF8RE6kTRf?=
 =?us-ascii?Q?mMH5i/RY2Q8r/Ye2PNco5n4eMsZE/IaLlXwIzBPI8e2YJ+QelpcrVx3qSRqa?=
 =?us-ascii?Q?a5HQGyJE+J/gz0Nx6awaDz3vazCQ4nQMSYv8OHR93j6s3dCjSdYPyoto4R1s?=
 =?us-ascii?Q?HVTvZnlgrvJwpb9CrgLDgNDW+BCpaisPTh+HtzAEL/0AGDj1iEAPQgR53T8K?=
 =?us-ascii?Q?EHG9r/gutP37CjAFd6Ubf06MSGExKL3CpKGhuZBUhiMnmt6/gp1eMzW0iCEl?=
 =?us-ascii?Q?kNdMLKDx5c1UN0EAuhQ4NZOCjSCQsgqS7spEeI/SV7EFsoQ2SImIo1KPU2+z?=
 =?us-ascii?Q?NHHGss7RZ+yQyNGkeBm+n32GQ80eReRrHSHCe/wd/Rg5eQdwsvkMLqhYJFtb?=
 =?us-ascii?Q?bnAWs+ZRhAdhvXWMBe3elXdpARHtCEEoHNdGaIbQ7IdeFYttfJwDw9UNxnEn?=
 =?us-ascii?Q?blFbBXPkOmPaTu20dTKMEk0gGg6PoZ9DeU+5w3VyZz9t9j6MIyOLpcHUgR5B?=
 =?us-ascii?Q?e8wFy/yGA0WhqggdAeAE6EXDXvCXoNSCZfp+n9Bgy0oyjvd+SUFZ2kOymAmZ?=
 =?us-ascii?Q?vTzNWljRAJyQ/ie7A5zau8Ho?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2c7ba9-18b5-4a6b-4ed2-08d8fe7c9e1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 13:04:05.3136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kdlw8EdqHQ2mFje+10LlxUK/Jy9jL7TD7RMsV2m0fdvszPgzpk/6+yu2edBz0sYrjslnb1LwluFeGYPWVyX8tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0027
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Tuikov, Luben <Luben.Tuikov@amd.com> 
Sent: Tuesday, April 13, 2021 20:56
To: amd-gfx@lists.freedesktop.org
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Fix kernel-doc for the RAS sysfs interface

Imporve the kernel-doc for the RAS sysfs interface. Fix the grammar, fix the context.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 47 +++++++++++++------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 30cda4b8a461..44dfb3613e37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -274,7 +274,7 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
 /**
  * DOC: AMDGPU RAS debugfs control interface
  *
- * It accepts struct ras_debug_if who has two members.
+ * The control interface accepts struct ras_debug_if which has two members.
  *
  * First member: ras_debug_if::head or ras_debug_if::inject.
  *
@@ -299,32 +299,33 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
  *
  * How to use the interface?
  *
- * Programs
+ * In a program
  *
- * Copy the struct ras_debug_if in your codes and initialize it.
- * Write the struct to the control node.
+ * Copy the struct ras_debug_if in your code and initialize it.
+ * Write the struct to the control interface.
  *
- * Shells
+ * From shell
  *
  * .. code-block:: bash
  *
- *	echo op block [error [sub_block address value]] > .../ras/ras_ctrl
+ *	echo "disable <block>" > /sys/kernel/debug/dri/<N>/ras/ras_ctrl
+ *	echo "enable  <block> <error>" > /sys/kernel/debug/dri/<N>/ras/ras_ctrl
+ *	echo "inject  <block> <error> <sub-block> <address> <value> > /sys/kernel/debug/dri/<N>/ras/ras_ctrl
  *
- * Parameters:
+ * Where N, is the card which you want to affect.
  *
- * op: disable, enable, inject
- *	disable: only block is needed
- *	enable: block and error are needed
- *	inject: error, address, value are needed
- * block: umc, sdma, gfx, .........
+ * "disable" requires only the block.
+ * "enable" requires the block and error type.
+ * "inject" requires the block, error type, address, and value.
+ * The block is one of: umc, sdma, gfx, etc.
  *	see ras_block_string[] for details
- * error: ue, ce
- *	ue: multi_uncorrectable
- *	ce: single_correctable
- * sub_block:
- *	sub block index, pass 0 if there is no sub block
+ * The error type is one of: ue, ce, where,
+ *	ue is multi-uncorrectable
+ *	ce is single-correctable
+ * The sub-block is a the sub-block index, pass 0 if there is no sub-block.
+ * The address and value are hexadecimal numbers, leading 0x is optional.
  *
- * here are some examples for bash commands:
+ * For instance,
  *
  * .. code-block:: bash
  *
@@ -332,17 +333,17 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
  *	echo inject umc ce 0 0 0 > /sys/kernel/debug/dri/0/ras/ras_ctrl
  *	echo disable umc > /sys/kernel/debug/dri/0/ras/ras_ctrl
  *
- * How to check the result?
+ * How to check the result of the operation?
  *
- * For disable/enable, please check ras features at
+ * To check disable/enable, see "ras" features at,
  * /sys/class/drm/card[0/1/2...]/device/ras/features
  *
- * For inject, please check corresponding err count at
- * /sys/class/drm/card[0/1/2...]/device/ras/[gfx/sdma/...]_err_count
+ * To check inject, see the corresponding error count at,
+ * 
+ /sys/class/drm/card[0/1/2...]/device/ras/[gfx|sdma|umc|...]_err_count
  *
  * .. note::
  *	Operations are only allowed on blocks which are supported.
- *	Please check ras mask at /sys/module/amdgpu/parameters/ras_mask
+ *	Check the "ras" mask at /sys/module/amdgpu/parameters/ras_mask
  *	to see which blocks support RAS on a particular asic.
  *
  */
--
2.31.0.97.g1424303384
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
