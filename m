Return-Path: <SRS0=UsYE=JJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DE8C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 20:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF39A61352
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Apr 2021 20:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF39A61352
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 835F789D81;
	Mon, 12 Apr 2021 20:22:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B507589D81
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Apr 2021 20:22:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnmpnZTi76LgZBgASyi8/dxaLL+xT2zSHSI8u80x7aKMNHN0zngY/G3UyxXf3IPCQahdleCdbwnuTtUuZrayVjthuupB/LIrazoygsZo2Oy04jtYqDxytSZDkXnfDobcirADyFcXHi9QN7Yyqd4afialX3nAy4Z600HgDJKHxSFwyiREQoHSrpYKlalf20mK/kFiWBCevbysD5I4E1/D5ccmfP4XLyd9H/pfz9E6mdxVBOXrxyHaZkYdBaPa5kBzXj496/dJf7cRuUGKWfL5DEmKs77H6RvSbenmnvmI2iLOp2tMoAUzI3Hf/jr+OH/AgXyd8PzHM3OUkaKgy0M2OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mIQ1yfmDBCaQ6oOZhX7RdxnK3+6o6Ic+I9hRALhnZI=;
 b=OWYvmtEw1qoqsIdar6+s+WoLPQ7f5D8owvROuzDYwI/RxWvOn5u+BdwGSiIVLM3HEuNsqkObW2taWn+Lz1JO7vuOmOgjzq2FTxztsL3Cag5CDkkQnaBN87p1n3KmQX6rup61HsKO1fhqsxViP7kQP/E35+QetJ3yDU/EeSOSlAuwhLT8vRiSs6rXBpUzLjMZEZh3XKR4SKaWasohRiPlcezIbxF7EDf1HEm6lu6tVbflhoqjrvo2HJGO1X/a6kDTl+w7qAqtE2GYl13aWEWhnj83/rn72EvdsonCps5DVbchdTk5XzwasjvvAUsy4Gx53HRYpXArCXCyjSGEdHzbjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mIQ1yfmDBCaQ6oOZhX7RdxnK3+6o6Ic+I9hRALhnZI=;
 b=u1Nsw7FHmXwUX8/aXi7s9Cmh4YBnbdQa1vQ+Mp1YqGSgLM7keEVc4OGEPfuZAKpQayFWNXFfA/PSzjb9R9JIztl2dxeNyxNwdLmnn3xHFoYkXGrSjNVIJTEg5vmZ+LIMxkm+RexLTTtCFAsGneqJ3HTOgePB9q18vX4CSO7OxhQ=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4996.namprd12.prod.outlook.com (2603:10b6:208:1c6::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Mon, 12 Apr
 2021 20:22:53 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%7]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 20:22:53 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix checking return result of retire page
Thread-Topic: [PATCH] drm/amdgpu: Fix checking return result of retire page
Thread-Index: AQHXLzlTL7rhW4gZgEyaONawXi9YIaqxU+jw
Date: Mon, 12 Apr 2021 20:22:53 +0000
Message-ID: <MN2PR12MB4488E981B3661580104E2E3AF7709@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210412011508.35024-1-luben.tuikov@amd.com>
In-Reply-To: <20210412011508.35024-1-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-12T20:22:50Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=09d2f457-585e-4913-b24f-ac97451a712a;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 486a3023-408a-4a8d-68d5-08d8fdf0c03a
x-ms-traffictypediagnostic: BL0PR12MB4996:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB499684EEB084D4F4C82AAAACF7709@BL0PR12MB4996.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NTALhO0e5x98mir/HPbr0YspRHY4VKdAM+2V04j2E8V3V+oRChVUxSDTi1Ey9Wt1BMMcqGD2OqSEshpbJEarwZhPgFqy+Qu+B0bPFzIc9rBHOKVmo4wPaDIoFNbPD+6TwYNiEIDLe8+Rchs9rE5mmdJxOu1AAJIRjaJn9hXuNFjsF3UMiWhIIMWwwhx1p54aX2guiQXr+0tOPXaLlPpmVKixxPJiEPmH/JI10TliiNt40O7uzyFu2atFNg03hdesOFyuDbZpz1vbSS1dyXnG0Sl517jd3/E4Rg0Cl0SKgN3eBxI7hyHOJyl2fYUflobNIQsbP1lpVtHqIkKEiXTMxEbd7Y0MKI+ZDLBQX/e9IJqlINawTGuW5/702yjf5bgRi15wBJK9G8X3sbuvndGodX06D0HPd/gfa9HojC8hJJDfd3RK9rbJ4Kf43EPxWUv4KwAXmgSL95zMbUcAZzz17IrrwMNFL/SwSkPOFMje4iEHaKqIVC/2L/8DCRcVVEOaosu3O94SY0rXBoaE7+OJo9FSSZeca0rm+1J2QhvnP2lgpmuIWkX1PxBzLPiRZR+U3kbIsINndE3+wE0IBXz72cddTihcyLBPRedBUuW5+IM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(4326008)(8676002)(7696005)(26005)(52536014)(186003)(110136005)(53546011)(2906002)(38100700002)(9686003)(55016002)(316002)(86362001)(66446008)(83380400001)(33656002)(6506007)(66946007)(8936002)(5660300002)(64756008)(76116006)(478600001)(66476007)(66556008)(71200400001)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?seaJoYChaDLIBn4ziHB91W4XQH5RMkVcbROiGow45K+IbVRI70ifSmVk9QG8?=
 =?us-ascii?Q?klBKZz35GyNxS43OSXtpUeJ4Yo7liaV9NwhZsfx06lLIZGlJMQCmv3S4RB4D?=
 =?us-ascii?Q?TaIzNdvuVv1B4MRKL/TbVWPfwycTf10h8PhER2V/5Zb3rwhLzT4UJVZyCfvz?=
 =?us-ascii?Q?+7qjdwLAwysNJsX+0ZbHccxSlmW9rZ41rjQlCa2r4XW6X3m65Dxe2J63f0KL?=
 =?us-ascii?Q?wW2aK0u25hyg0tm5AswbQt2UhlUU5fE6Sz9Vm0DwBeHmTCF1SHPnB/3izwkc?=
 =?us-ascii?Q?yDQXLklmJLqj/Aj14wSw4dSo2Ade4pdLKwb/6PpHqOZQh7wDakM6cS/bNm7T?=
 =?us-ascii?Q?UsqKo6YNzxvcH3KgQuET3qA85jazcVLZiI1iCjoiwJtKU9SEpv3UYakamD7g?=
 =?us-ascii?Q?nED/ex1cZTHAIRDXw5/r2yFHSEVIDa7VdxRQTRVggI+akJsUFbV5qBkDqqrr?=
 =?us-ascii?Q?luN4e8ByvhvTYEeajVj1URaVrDfOEFb8RpJmovTR7eHIjGR1Oz/2aqBs+kt0?=
 =?us-ascii?Q?rCuqyoavgy5goJG7uqtC5qoaCqJo3uNT07MOItVVz07FZbs447YPpPf47vHM?=
 =?us-ascii?Q?ie2N9hFbEZ72g4pLYxFfLTC16JVwl49utMEOXj90JHoqDBBUg9/XnRFPVish?=
 =?us-ascii?Q?NV3lXHCsURUCbh4DPIW0SRGBgstwv42X4zRFjZOd/y16fHGSUzfKh/Nvmlzg?=
 =?us-ascii?Q?kAPpFAn2GsCJIlECD1OhjMlhf2dC88/zVKmcc2FzCT8kj7FA4yuRR1I/I2hp?=
 =?us-ascii?Q?sBsNgpgaqQAbO84WemkOltgCyBVmJ/C4H+LA5vyYQ8LaYnkgu+zc23/8hMxa?=
 =?us-ascii?Q?xii18CP3gwpu/Wg1k2URTSJPVZ/W6XdP2c2tiqTtA1B7vy8yzZlRgUgcZq6o?=
 =?us-ascii?Q?1Wnha6tOrM9ffDauIAJ6eoaWyekmHVod3SsaBa/eW/wpUkikzzjJMEJcddmP?=
 =?us-ascii?Q?YURZHEoVcJo5RADlNiSNcBhCOgyAWz8N7OnMBSXYUqQNEB61zQ0CU05FNBcA?=
 =?us-ascii?Q?RoDD1zOGA3uZBUOokoOn98Bnjnb41jTAgRLQjQpgdDSNRRaYX8WQ7IWFpmRP?=
 =?us-ascii?Q?Ad78y+utdAqHQZEFm8XUT/sVGC7CRoxMenAwotwK/6cq5ge6Xg4ko+7lSObl?=
 =?us-ascii?Q?dUtV0aX/2VPEbtdZae4ZZ9cJmHDTE7aVRLC4krNf3rbh94MGSmRuRidJosfJ?=
 =?us-ascii?Q?sJc/3Xa5BaE9Y0lUV1d85uQNNHi2XlWRl1P0GgruRmY3+8EL6Xihipnmqhpe?=
 =?us-ascii?Q?IDYil8DQ1AJ10MN6J+apdypZnGx8qg8tswMkpMzveoWUji6uguYZRQa4Oqcn?=
 =?us-ascii?Q?lQ1ESkGAdo5zuFNWMe8JnN0e?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486a3023-408a-4a8d-68d5-08d8fdf0c03a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 20:22:53.0951 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iF7eqog2XaND56N7k0aSJH0ddu/boso4PoeB4DwSjP+q3yGKieA4xP2Yzsr4nd6mpIobSn8WxMIPA6QBUDNOpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4996
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

> -----Original Message-----
> From: Tuikov, Luben <Luben.Tuikov@amd.com>
> Sent: Sunday, April 11, 2021 9:15 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Clements, John
> <John.Clements@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix checking return result of retire page
> 
> * Remove double-sscanf to scan for %llu and
>   0x%llx, as that is not going to work--the %llu
>   will consume the "0" in "0x" of your input,
>   and a hex value can never be consumed. And just
>   entering a hex number without leading 0x will
>   either be scanned as a string and not match,
>   or the leading decimal portion is scanned
>   which is not correct. Thus remove the first
>   %llu scan and leave only the %llx scan,
>   removing the leading 0x since %llx can scan
>   either.
> 
> * Fix logic the check of the result of
>   amdgpu_reserve_page_direct()--it is 0
>   on success, and non-zero on error.
> 
> * Add bad_page_cnt_threshold to debugfs for
>   reporting purposes only--it usually matches the
>   size of EEPROM but may be different depending on
>   module option. Small other improvements.
> 
> * Improve kernel-doc for the sysfs interface.

I think these should be split into 4 separate patches.  The first two are bug fixes, the latter two are general improvements.

Thanks,

Alex

> 
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Cc: John Clements <john.clements@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 67 ++++++++++++-----------
> --
>  1 file changed, 32 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 0541196ae1ed..c4b94b444b90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -114,7 +114,7 @@ static int amdgpu_reserve_page_direct(struct
> amdgpu_device *adev, uint64_t addre
> 
>  	if (amdgpu_ras_check_bad_page(adev, address)) {
>  		dev_warn(adev->dev,
> -			 "RAS WARN: 0x%llx has been marked as bad
> page!\n",
> +			 "RAS WARN: 0x%llx has already been marked as bad
> page!\n",
>  			 address);
>  		return 0;
>  	}
> @@ -228,11 +228,9 @@ static int
> amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
>  		return -EINVAL;
> 
>  	if (op != -1) {
> -
>  		if (op == 3) {
> -			if (sscanf(str, "%*s %llu", &address) != 1)
> -				if (sscanf(str, "%*s 0x%llx", &address) != 1)
> -					return -EINVAL;
> +			if (sscanf(str, "%*s %llx", &address) != 1)
> +				return -EINVAL;
> 
>  			data->op = op;
>  			data->inject.address = address;
> @@ -255,11 +253,9 @@ static int
> amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
>  		data->op = op;
> 
>  		if (op == 2) {
> -			if (sscanf(str, "%*s %*s %*s %u %llu %llu",
> -						&sub_block, &address,
> &value) != 3)
> -				if (sscanf(str, "%*s %*s %*s 0x%x 0x%llx
> 0x%llx",
> -							&sub_block,
> &address, &value) != 3)
> -					return -EINVAL;
> +			if (sscanf(str, "%*s %*s %*s %x %llx %llx",
> +				   &sub_block, &address, &value) != 3)
> +				return -EINVAL;
>  			data->head.sub_block_index = sub_block;
>  			data->inject.address = address;
>  			data->inject.value = value;
> @@ -278,7 +274,7 @@ static int
> amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
>  /**
>   * DOC: AMDGPU RAS debugfs control interface
>   *
> - * It accepts struct ras_debug_if who has two members.
> + * The control interface accepts struct ras_debug_if which has two
> members.
>   *
>   * First member: ras_debug_if::head or ras_debug_if::inject.
>   *
> @@ -303,32 +299,33 @@ static int
> amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
>   *
>   * How to use the interface?
>   *
> - * Programs
> + * Program
>   *
>   * Copy the struct ras_debug_if in your codes and initialize it.
>   * Write the struct to the control node.
>   *
> - * Shells
> + * Shell
>   *
>   * .. code-block:: bash
>   *
> - *	echo op block [error [sub_block address value]] > .../ras/ras_ctrl
> + *	echo "disable <block>" > /sys/kernel/debug/dri/<N>/ras/ras_ctrl
> + *	echo "enable  <block> <error>" >
> /sys/kernel/debug/dri/<N>/ras/ras_ctrl
> + *	echo "inject  <block> <error> <sub-block> <address> <value> >
> /sys/kernel/debug/dri/<N>/ras/ras_ctrl
>   *
> - * Parameters:
> + * Where N, is the card which you want to affect.
>   *
> - * op: disable, enable, inject
> - *	disable: only block is needed
> - *	enable: block and error are needed
> - *	inject: error, address, value are needed
> - * block: umc, sdma, gfx, .........
> + * "disable" requires only the block.
> + * "enable" requires the block and error type.
> + * "inject" requires the block, error type, address, and value.
> + * The block is one of: umc, sdma, gfx, etc.
>   *	see ras_block_string[] for details
> - * error: ue, ce
> - *	ue: multi_uncorrectable
> - *	ce: single_correctable
> - * sub_block:
> - *	sub block index, pass 0 if there is no sub block
> + * The error type is one of: ue, ce, where,
> + *	ue is multi-uncorrectable
> + *	ce is single-correctable
> + * The sub-block is a the sub-block index, pass 0 if there is no sub-block.
> + * The address and value are hexadecimal numbers, leading 0x is optional.
>   *
> - * here are some examples for bash commands:
> + * For instance,
>   *
>   * .. code-block:: bash
>   *
> @@ -336,17 +333,17 @@ static int
> amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
>   *	echo inject umc ce 0 0 0 > /sys/kernel/debug/dri/0/ras/ras_ctrl
>   *	echo disable umc > /sys/kernel/debug/dri/0/ras/ras_ctrl
>   *
> - * How to check the result?
> + * How to check the result of the operation?
>   *
> - * For disable/enable, please check ras features at
> + * To check disable/enable, see "ras" features at,
>   * /sys/class/drm/card[0/1/2...]/device/ras/features
>   *
> - * For inject, please check corresponding err count at
> - * /sys/class/drm/card[0/1/2...]/device/ras/[gfx/sdma/...]_err_count
> + * To check inject, see the corresponding error count at,
> + * /sys/class/drm/card[0/1/2...]/device/ras/[gfx|sdma|umc|...]_err_count
>   *
>   * .. note::
>   *	Operations are only allowed on blocks which are supported.
> - *	Please check ras mask at
> /sys/module/amdgpu/parameters/ras_mask
> + *	Check the "ras" mask at /sys/module/amdgpu/parameters/ras_mask
>   *	to see which blocks support RAS on a particular asic.
>   *
>   */
> @@ -367,11 +364,9 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct
> file *f, const char __user *
>  	if (ret)
>  		return -EINVAL;
> 
> -	if (data.op == 3)
> -	{
> +	if (data.op == 3) {
>  		ret = amdgpu_reserve_page_direct(adev,
> data.inject.address);
> -
> -		if (ret)
> +		if (!ret)
>  			return size;
>  		else
>  			return ret;
> @@ -1269,6 +1264,8 @@ static struct dentry
> *amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *
>  			    &amdgpu_ras_debugfs_ctrl_ops);
>  	debugfs_create_file("ras_eeprom_reset", S_IWUGO | S_IRUGO, dir,
> adev,
>  			    &amdgpu_ras_debugfs_eeprom_ops);
> +	debugfs_create_u32("bad_page_cnt_threshold", S_IRUGO, dir,
> +			   &con->bad_page_cnt_threshold);
> 
>  	/*
>  	 * After one uncorrectable error happens, usually GPU recovery will
> --
> 2.31.0.97.g1424303384
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
