Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FA5C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 08:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DC6C60BBB
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 08:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC6C60BBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03E596E8F6;
	Wed, 14 Apr 2021 08:19:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E0CB6E8F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 08:19:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwBHQ4zNO8DrdhYqtSSLc1W3HXgZ+dmIMcHSnRUhk/kBPen9GZ7SLNpxxUQsN6kks4QZ20S70kfkROIazN3J7OP69av5cAZjcmiLyRhHSIQ+7fFC3Ju9XEbQo+Waf8oe9pIn17Chgs1NARNzFDcjMJg383ghoPlAoWZpdVQXu2u/TRDVL2TY6abjAApwRzF71xyEZx7ecxIFrUiYSInG4eO/+vf90TQ+qFKsY2utrRR6sxY5PfEPmW8psylOWt4Rph6ypnp2sWeyF/9tBVrp1CeUeJ29zjx1LMDo1JAT7gJTAeCV/rnwIFPYqdmP00ljqV3hh9snxcaercwo2Lz3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4tUqaDj4WOYFvsiUR1MoPDFmKuFYn6mKpIJVJuiBts=;
 b=ljGYjP1RLWc5PxbsKPmpxwXlRWV4CMMI9Bw+ILdko4gvmggIi0kXtDqYqc2zdLuBslBw6XuQDyPilIxAOWYwtYXGfg+mqk1ap9maNbYEKQ7r6Vfsb6Ig4CKE8PIaEwTn5OFmGDI6j+xyD18QvrqqdsuaCu19XfkJpFaTID5KGvckD1+5SltrMArkoymeaYLUzocUX/coECiawhSa7kXaUf357Sj4OuU5myqLF5ho6UUnUEOOU9eQ8G7NZzUqhxfYNyitAjJDwYj+Q6PBKwkrikUuxy4fiEX+fXOIHDDjkkqwPe5yEfst1Pc0Nc6IR1ka3F2SR1htBtn4powdph/NIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4tUqaDj4WOYFvsiUR1MoPDFmKuFYn6mKpIJVJuiBts=;
 b=bVr/XICrl8nE0Dp3Z2yOAukzbYwppfzA0zW9kJ5nNSe3Q/3Khbph19KJpelJwMXVT4PNGGwsFj1hWwztHfgLwVF6bWG4slQxUJ2DQiRRTZEduYCwihrxygHB7XEjI4k6YWczCMSKhyY8WreItbRfN0EOHoHfux5QkeuzUvaJD44=
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 (2603:10b6:910:1b::19) by CY4PR1201MB0264.namprd12.prod.outlook.com
 (2603:10b6:910:1e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Wed, 14 Apr
 2021 08:19:28 +0000
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::6018:28b:59e1:befe]) by CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::6018:28b:59e1:befe%11]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 08:19:28 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix checking return result of retire page
Thread-Topic: [PATCH] drm/amdgpu: Fix checking return result of retire page
Thread-Index: AQHXLzlTUKPhv2DeQE+Gk/RIDvILtqqwaU2g
Date: Wed, 14 Apr 2021 08:19:28 +0000
Message-ID: <CY4PR1201MB007214EEE4658567FC2B1C18FB4E9@CY4PR1201MB0072.namprd12.prod.outlook.com>
References: <20210412011508.35024-1-luben.tuikov@amd.com>
In-Reply-To: <20210412011508.35024-1-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-14T08:19:22Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=6d79728a-4786-4650-aaa4-04c01833442b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 074ef849-8369-4a7c-f000-08d8ff1e05fb
x-ms-traffictypediagnostic: CY4PR1201MB0264:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB02645622B53BED280B13E6E1FB4E9@CY4PR1201MB0264.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0BR8yBSrwa7bE8n588O6MFNUWqbQJRBm13oFrUzFmcldd/wDviG+FCLI4Q8+oJFmJ8isNaSmhRry/Sq12yyWh6jcNsGhQ5dvSXXcpnhWqKuL0xYT8lWSvIPi0zVdKz917Ya0SUL3d6tH+qeWc11TCb461A7oBgWPQyo8qVpvarN1U2fh5RuK5BniqgqX+fxSMtEMzrMpGcKj70Luvs14nzvIWKKK/Mjt7m4/G0/xnXxKKYy0rSkl2dOXIIxJSts3DWRaYMqKYZZAlGVG6hxs4/1VwlEaCmKgsQCWdrTZIfnJwKdn/sInlBsafJKjR+ING6PODtPIwx9aHA3ayuWmhGnooxY5YxkNzB/GwizhHY6ccFTADXzKB3lOudNc+KRMWZB2N5gYDqwbZLotghA/oWrhJoxx2qKPtSDO/s+GPYbZxur4uTWZ6qMPfXrAiypNQ7u3hHAdPybx9CsjgVJ8BBjPivD7pB/3/NP+JouxtcSRWccrSrFWFOK8unil3jYYA2DvmDnHuly9oFJIY27RqXVq/2XZpDV3dDz+6VjhmrUI7qUdjqYVkgFYwbo9U6b9zUtx/LjEaAuNQkL3gh/btFb2SCHUu9PRJgJm4msd3mg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39850400004)(86362001)(71200400001)(7696005)(54906003)(110136005)(55016002)(9686003)(8676002)(2906002)(8936002)(478600001)(38100700002)(316002)(66556008)(66476007)(66446008)(66946007)(52536014)(5660300002)(26005)(186003)(122000001)(76116006)(64756008)(6506007)(53546011)(33656002)(83380400001)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?V/9U3pkFawEGasx/0A2Yeh3Quzp71217nHD+3xIjeZsOWSVfqTau3aaV7ODS?=
 =?us-ascii?Q?jmzFWRynAOSnjvDBongcuJu+dt+yU8gafqbU4iD28tU1m3hGIjhxnOPKhTOe?=
 =?us-ascii?Q?Eh8UTbJR56lP2Tp8Txlp0cvCPZIvFk1rL/q5/CrsPk9eIO0UJXRalcCXMGSg?=
 =?us-ascii?Q?wndp5S3kAcQhMdoBCPzfgffcapqA71OH+uvxxWxCjBcyaJXVxcTGKIjKJgdk?=
 =?us-ascii?Q?By/Ie+NM4NZqXDoB1eWSrFisAQ/bJ2ZCZs/AderCDF/7nzPC55Pghcfirp+f?=
 =?us-ascii?Q?qKTxjXwpXLmOowE5O3Af7j7ZycBw26IPX0J6DyGRMWMa1ITevKhji+5BtvHF?=
 =?us-ascii?Q?3J2C0+UUCxhUdOxsHnxMVGVX/EOwcL/ta/2UhCAGytDIgoQcXCi+2FTKQvqF?=
 =?us-ascii?Q?stEYLBRVjg2ADqtR8lx+CkRsdQN479HWTBMuRFV1g2Sj+C3/Y6qbtvMt9bgV?=
 =?us-ascii?Q?43EWNevX6YdiHUJ0V2ac7BVBYcICS7NEKwEka3rIyXevbbFbzhS5IVovFoBb?=
 =?us-ascii?Q?wrbRibeOQoHAXlO6ze4J4z6QJTdcyTZS5ILEH0Bcp4Gx5Q5WkCXE+VVKTX0Q?=
 =?us-ascii?Q?VPkvttq3EB6RFCEFHPy3drG0Jfi+pjV2PcrYcY18eR7E+lD+k97Kfwn0P0zr?=
 =?us-ascii?Q?u3CfTO5YKmrB+HeTDZFgSZEAFHAoZ0UyvCSbtPWIYIYG0hytdqI9FgJDOHhd?=
 =?us-ascii?Q?F8m/jwsfX8vK/jVMK/HHvf2Ic70CPT+XX5Ia0Lcil6rZmAJf3eY8WyPkTSMA?=
 =?us-ascii?Q?B3YHqheB0kEy6tFR0Xm7piMLH7PFL+P3PS3rVRP4d3SE2RHJE6g4zhfM3Flk?=
 =?us-ascii?Q?hBYGlgmUDQQ3s9uqFaIRl8I7zfRdvKYhAS1md4GfBEvU3Q8aqT+rUIsmwCMq?=
 =?us-ascii?Q?n+M1sufnAxzteCc055JFumY6YoP2lUfi/cDo0b10q4rZbPVA2YTKcMOgvTo5?=
 =?us-ascii?Q?/LzCFWpgzRRDJ9rg2IC8k6g0SmhPqUy/Brp0oMwYf6934pZid75eAVvsjfDe?=
 =?us-ascii?Q?vYFmmA3wRCCbc9Dvx7eBJLFEH7JxrXNCZE18O694bk9xmbECaCiSllV+LnuV?=
 =?us-ascii?Q?w/t5flsd/lzCAupwZKrvnC0lEmBsCXa/EyqZ3m/VDuoMH+0akR5QJiH3BlBI?=
 =?us-ascii?Q?uWy8yOb8waKCOse5SB1mdb87DA4QOsE3qdxq8zQM1vrxTT5VMJO+g5uT28Nm?=
 =?us-ascii?Q?qJIygj7mFh+yrKWuY9YFkqaGvztMSmVU5sWUrg6edJfjYXESl9A/cLQuyMqM?=
 =?us-ascii?Q?Z+ifXyvGpYREERte6m1rldOmE6xWXiYtJZGSXaCb59IyfchyLcJe5woQlBCC?=
 =?us-ascii?Q?7kJcafjDgfNcYtf2/70eWXKe?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074ef849-8369-4a7c-f000-08d8ff1e05fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 08:19:28.6364 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L1fiOnZ0YnjekL4pGOPKyS5cApf0M2Z9vL2/lemwcmBQj0yfC26XpATxAGTnJmhL0KfWZ9Jg4eJmVERyZ/EpXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0264
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Thank you Luben for re-organizing this source file and fixing those bugs.

Please add back support for decimal input parameter values, maybe something like this:
+			if (sscanf(str, "%*s 0x%llx", &address) != 1) &&  (sscanf(str, "%*s %llu", &address) != 1))
+				return -EINVAL; 

My concern is that there are tools out there that use that interface, so I wouldn't want any side effects there.

Reviewed-by: John Clements <John.Clements@amd.com>

-----Original Message-----
From: Tuikov, Luben <Luben.Tuikov@amd.com> 
Sent: Monday, April 12, 2021 9:15 AM
To: amd-gfx@lists.freedesktop.org
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Clements, John <John.Clements@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix checking return result of retire page

* Remove double-sscanf to scan for %llu and
  0x%llx, as that is not going to work--the %llu
  will consume the "0" in "0x" of your input,
  and a hex value can never be consumed. And just
  entering a hex number without leading 0x will
  either be scanned as a string and not match,
  or the leading decimal portion is scanned
  which is not correct. Thus remove the first
  %llu scan and leave only the %llx scan,
  removing the leading 0x since %llx can scan
  either.

* Fix logic the check of the result of
  amdgpu_reserve_page_direct()--it is 0
  on success, and non-zero on error.

* Add bad_page_cnt_threshold to debugfs for
  reporting purposes only--it usually matches the
  size of EEPROM but may be different depending on
  module option. Small other improvements.

* Improve kernel-doc for the sysfs interface.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 67 ++++++++++++-------------
 1 file changed, 32 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 0541196ae1ed..c4b94b444b90 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -114,7 +114,7 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
 
 	if (amdgpu_ras_check_bad_page(adev, address)) {
 		dev_warn(adev->dev,
-			 "RAS WARN: 0x%llx has been marked as bad page!\n",
+			 "RAS WARN: 0x%llx has already been marked as bad page!\n",
 			 address);
 		return 0;
 	}
@@ -228,11 +228,9 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
 		return -EINVAL;
 
 	if (op != -1) {
-
 		if (op == 3) {
-			if (sscanf(str, "%*s %llu", &address) != 1)
-				if (sscanf(str, "%*s 0x%llx", &address) != 1)
-					return -EINVAL;
+			if (sscanf(str, "%*s %llx", &address) != 1)
+				return -EINVAL;
 
 			data->op = op;
 			data->inject.address = address;
@@ -255,11 +253,9 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
 		data->op = op;
 
 		if (op == 2) {
-			if (sscanf(str, "%*s %*s %*s %u %llu %llu",
-						&sub_block, &address, &value) != 3)
-				if (sscanf(str, "%*s %*s %*s 0x%x 0x%llx 0x%llx",
-							&sub_block, &address, &value) != 3)
-					return -EINVAL;
+			if (sscanf(str, "%*s %*s %*s %x %llx %llx",
+				   &sub_block, &address, &value) != 3)
+				return -EINVAL;
 			data->head.sub_block_index = sub_block;
 			data->inject.address = address;
 			data->inject.value = value;
@@ -278,7 +274,7 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
 /**
  * DOC: AMDGPU RAS debugfs control interface
  *
- * It accepts struct ras_debug_if who has two members.
+ * The control interface accepts struct ras_debug_if which has two members.
  *
  * First member: ras_debug_if::head or ras_debug_if::inject.
  *
@@ -303,32 +299,33 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
  *
  * How to use the interface?
  *
- * Programs
+ * Program
  *
  * Copy the struct ras_debug_if in your codes and initialize it.
  * Write the struct to the control node.
  *
- * Shells
+ * Shell
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
@@ -336,17 +333,17 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
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
+ * /sys/class/drm/card[0/1/2...]/device/ras/[gfx|sdma|umc|...]_err_count
  *
  * .. note::
  *	Operations are only allowed on blocks which are supported.
- *	Please check ras mask at /sys/module/amdgpu/parameters/ras_mask
+ *	Check the "ras" mask at /sys/module/amdgpu/parameters/ras_mask
  *	to see which blocks support RAS on a particular asic.
  *
  */
@@ -367,11 +364,9 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f, const char __user *
 	if (ret)
 		return -EINVAL;
 
-	if (data.op == 3)
-	{
+	if (data.op == 3) {
 		ret = amdgpu_reserve_page_direct(adev, data.inject.address);
-
-		if (ret)
+		if (!ret)
 			return size;
 		else
 			return ret;
@@ -1269,6 +1264,8 @@ static struct dentry *amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *
 			    &amdgpu_ras_debugfs_ctrl_ops);
 	debugfs_create_file("ras_eeprom_reset", S_IWUGO | S_IRUGO, dir, adev,
 			    &amdgpu_ras_debugfs_eeprom_ops);
+	debugfs_create_u32("bad_page_cnt_threshold", S_IRUGO, dir,
+			   &con->bad_page_cnt_threshold);
 
 	/*
 	 * After one uncorrectable error happens, usually GPU recovery will
-- 
2.31.0.97.g1424303384
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
