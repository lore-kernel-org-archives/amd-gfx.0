Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB01BC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 05:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D18230FC
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 05:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D18230FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79FB589CAC;
	Wed, 13 Jan 2021 05:33:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A11589CAC
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 05:33:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+Utp/I9Czy5x1aSJnRC4SbJv2uScIx8ZBDcIUy6fPFkwKFsRQ2VEPPBLTZGZJHFTVjlZ63shlR2kDAqMTW9NqlLBLqqKGueT4C2cX0wRFw6Dqhi8PlHmzjGh3tO4ISC8RnQNcEO7UEXWoASN4o6Pst5lCnglO02tqkVSV+m29eHAUkGPaCC5eU5Ru1pI1PW/qEpMoegrvyfJKRtGcGGMPeadi/+9gV3S0Gm09STu6FXlcGDbGyfpjBnmo91TS35GEwIlesxHiw/KNSxBej7dsn6n2Ajjk6+TsKCuctxqmSSJ24zpqJ/cnBptrFTExsjGzC6au0t+UNQafM96tEm7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1kFVmInrWGlOAapnE6Bt5tEpqJ/yd8HUIvhphI7is0=;
 b=KuoAnQzUMw4tx8fq1am1V/b+AfBn+eyRos+aZX1QJssiXRboYJiuZnNJobFPQwBZv/3Ep3pR2RSTFyOVsn2rTM7yKMmyWAhSJSGvPOwkSoYw2Nzdm4/tznDwMp0ARix6SDOxrNHXr6dFkh4vwRV3ygAVQymyHjsC5oiWs2qsMZ8v9e6+fD3hXVNyoHW7aYTr8t2jJjrP0tCKzNeGjSAPX/x2ilDQibdrLiaTD/2NHnbXKAbQ1NDaO27hLm+Jmn928JNljCOct6YHfb7dn+d8N79LrQHQqn/0bfoFVcTrqpfj6+GJ1oyrQiI5ST3qugOdfpub4U8ZzGvMxT1MvLdLtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1kFVmInrWGlOAapnE6Bt5tEpqJ/yd8HUIvhphI7is0=;
 b=h0GWpBx4KJV54X8+NqIzjjXreHYgfS47+jsKXWpdtXX7RIC5Ob6Ru+pxxieX0mC1qVxfpPsVWyALpfT5HjZnAkOYQ1WyyJJhpMa/eRckq+av0gVgYtXSLOPNfojsacwnK2HO/M1HJLOyjyK61kkhhPK4YCEmlnro2puihs1yhbQ=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1656.namprd12.prod.outlook.com (2603:10b6:910:d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.9; Wed, 13 Jan
 2021 05:33:31 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2%12]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 05:33:31 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Add Secure Display TA header file
Thread-Topic: [PATCH 1/2] drm/amdgpu: Add Secure Display TA header file
Thread-Index: AQHW6V5lE69nYxcfRUmPeFGO6jRpK6ok7BsAgAAcH+A=
Date: Wed, 13 Jan 2021 05:33:31 +0000
Message-ID: <CY4PR12MB128726E7A94DEBC915E31F57F1A90@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210113034354.14557-1-Jinzhou.Su@amd.com>
 <20210113035150.GC135176@hr-amd>
In-Reply-To: <20210113035150.GC135176@hr-amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-13T05:33:28Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=694b4ca2-d819-43bc-b951-e89241920788;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 59ea63ba-58eb-40d1-40ae-08d8b784c343
x-ms-traffictypediagnostic: CY4PR12MB1656:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB16565715F20E20A29B894814F1A90@CY4PR12MB1656.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:530;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rNvAAs9iWQE1Ea6Iq3jI5Dh75TunGtSHUt7sVKWfD8+6OaUbLc1y5xUqkft3pbZOiB/JquEpzz6mTDxdzQhqe2OpkxZKeTljfv/ENM/go/6SkkGKixP/Ot6TZ0cZQ+lIaZ+IjcyfflCCvpOk+njpr2o2mSn6BVqxuegAwIaMKYCiHQpygjjrRAFFO2zfzCYp+nBhtSsLbPbASRwFND3iv8vSsGumvFwoDnYBIV2N0WB8FwkPJbJ/PtQszd+moL1w2OwAWZbr1ojwvIWUVzxcKPMaVeQsZ0ZwPcdMy7V3jzMINpN04jJipNP0UHjM3DslFIi1aHpYwBb2Pb7ZgO8pLoNacDLcnlLJe/7DLdNVDrtmtEdk6fSKYpf5Va3jJVBQD/wREd4q9vCPQpRiU6T+v13kzA0aA78xxkEESJH0bHo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(316002)(4326008)(55016002)(76116006)(5660300002)(6636002)(66946007)(2906002)(66446008)(64756008)(45080400002)(8936002)(52536014)(966005)(53546011)(186003)(83380400001)(33656002)(26005)(478600001)(7696005)(110136005)(8676002)(86362001)(6506007)(66556008)(71200400001)(66476007)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dGa4TtyXmmNjWktcovgzO8Zkijt+PaNOCfS9il7wo3rkWodX0l5tzWBx5EIH?=
 =?us-ascii?Q?cmbNRSHQv2AdoJDk3cnf+ANjyFMKqtzOBNYuxx3Rc4cerABksH5OJ+LwCfZq?=
 =?us-ascii?Q?h7dm3ztNk5qn6Db5sGjWYh6J6l5zHmr9ZiEIoCx7Qgh/IFgrP1zJ2tM8HTNH?=
 =?us-ascii?Q?UxKhqWwctVwbtyVuIUeguSugISZKtU294cI6GX0BoZSzJkco8Q7j0a+kWLus?=
 =?us-ascii?Q?xTvDJo86KFW0ExRiZ3NA2YdADl+o+h7ly0nHCPZDMkTXC5wCkw1SRmPGJXiA?=
 =?us-ascii?Q?N6ogGexlAoIdogYrVTGM12graIokFbrruPPnZgOtzUBqVebfAPgm9BG+oHl3?=
 =?us-ascii?Q?UtRtwGVCE5ffWBV7vVAh1ddMmp479Ph96jaecu4hjP4/nUAe9gwezLjagp2j?=
 =?us-ascii?Q?pQJZPf6O7GKl2emEsVc1KDOmtNoBgxBbHgQ8eAew+CxTVF04wN80IiSkBIIC?=
 =?us-ascii?Q?NvR6Su6GACRy4qHNissprOaIOevwg4+2XSxYjngUB5gFwomfETy6UlEGgpFp?=
 =?us-ascii?Q?ObdxBh40xAsAqSN/FNvwkj3EKifrj/otdUCAhozpTntOtHN+6OVMCoSdw1SM?=
 =?us-ascii?Q?XpN0RwchTLZeqlBNmv19J5kDsmoZpUu3iY0quyDfbDiTys04/NZWcaNMNRgh?=
 =?us-ascii?Q?TybUaAG+Co7QGkGLG4o6W+vhU7OBUggerjjupmZ0DMtLg9JX5vXisKPZKU9y?=
 =?us-ascii?Q?xUqiMzTI5OaXCxdW+7V13x7wST0vMscUmMR/ETVWe4e39TFu3kX+2VYaI0Xl?=
 =?us-ascii?Q?SDZrs/THuKADWc845NH7XRai/YZCFuHvgU8zllL6X4We1f4KB0ielywc6wxa?=
 =?us-ascii?Q?uakZ6X/yt7z0ZjnGTPHd2t5UpMatBosqM0eq0xihQ3zVziHM7EiIwLT+tbn6?=
 =?us-ascii?Q?hEJeu4g6ksA+bHGIXMHw0CZ6RcVPZOwnMfCyoii24k+QsCQ4v0oBWLnU3Ynx?=
 =?us-ascii?Q?R939H7zF9mv9VNz4Tw5amky/sX0Ti7XQlhZGTJOjBBs=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ea63ba-58eb-40d1-40ae-08d8b784c343
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 05:33:31.1576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EGEsIRkNm4Lx//fOZLgTkXHheVkPvzKo9x2ZeQvMQAL8oBd46wR2lYLQkjjRcvW4zXX3LGOcXPtTbrPOGKnk8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1656
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Copyright year should be 2021.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Huang Rui
Sent: Wednesday, January 13, 2021 11:52 AM
To: Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/amdgpu: Add Secure Display TA header file

On Wed, Jan 13, 2021 at 11:43:53AM +0800, Su, Jinzhou (Joe) wrote:
> Add file ta_secureDisplay_if.h for Secure Display TA
> 
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/ta_secureDisplay_if.h  | 154 
> ++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h 
> b/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
> new file mode 100644
> index 000000000000..5039375bb1d4
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
> @@ -0,0 +1,154 @@
> +/*
> + * Copyright 2019 Advanced Micro Devices, Inc.

Please update the date as "2020". Others look good for me.

Series are Reviewed-by: Huang Rui <ray.huang@amd.com>

> + *
> + * Permission is hereby granted, free of charge, to any person 
> + obtaining a
> + * copy of this software and associated documentation files (the 
> + "Software"),
> + * to deal in the Software without restriction, including without 
> + limitation
> + * the rights to use, copy, modify, merge, publish, distribute, 
> + sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom 
> + the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be 
> + included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
> + EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
> + MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT 
> + SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
> + DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
> + OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
> + OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef _TA_SECUREDISPLAY_IF_H
> +#define _TA_SECUREDISPLAY_IF_H
> +
> +/** Secure Display related enumerations */ 
> +/**********************************************************/
> +
> +/** @enum ta_securedisplay_command
> + *    Secure Display Command ID
> + */
> +enum ta_securedisplay_command {
> +	/* Query whether TA is responding used only for validation purpose */
> +	TA_SECUREDISPLAY_COMMAND__QUERY_TA              = 1,
> +	/* Send region of Interest and CRC value to I2C */
> +	TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC          = 2,
> +	/* Maximum Command ID */
> +	TA_SECUREDISPLAY_COMMAND__MAX_ID                = 0x7FFFFFFF,
> +};
> +
> +/** @enum ta_securedisplay_status
> + *    Secure Display status returns in shared buffer status
> + */
> +enum ta_securedisplay_status {
> +	TA_SECUREDISPLAY_STATUS__SUCCESS                 = 0x00,         /* Success */
> +	TA_SECUREDISPLAY_STATUS__GENERIC_FAILURE         = 0x01,         /* Generic Failure */
> +	TA_SECUREDISPLAY_STATUS__INVALID_PARAMETER       = 0x02,         /* Invalid Parameter */
> +	TA_SECUREDISPLAY_STATUS__NULL_POINTER            = 0x03,         /* Null Pointer*/
> +	TA_SECUREDISPLAY_STATUS__I2C_WRITE_ERROR         = 0x04,         /* Fail to Write to I2C */
> +	TA_SECUREDISPLAY_STATUS__READ_DIO_SCRATCH_ERROR  = 0x05, /*Fail Read DIO Scratch Register*/
> +	TA_SECUREDISPLAY_STATUS__READ_CRC_ERROR          = 0x06,         /* Fail to Read CRC*/
> +
> +	TA_SECUREDISPLAY_STATUS__MAX                     = 0x7FFFFFFF,/* Maximum Value for status*/
> +};
> +
> +/** @enum ta_securedisplay_max_phy
> + *    Physical ID number to use for reading corresponding DIO Scratch register for ROI
> + */
> +enum  ta_securedisplay_max_phy {
> +	TA_SECUREDISPLAY_PHY0                           = 0,
> +	TA_SECUREDISPLAY_PHY1                           = 1,
> +	TA_SECUREDISPLAY_PHY2                           = 2,
> +	TA_SECUREDISPLAY_PHY3                           = 3,
> +	TA_SECUREDISPLAY_MAX_PHY                        = 4,
> +};
> +
> +/** @enum ta_securedisplay_ta_query_cmd_ret
> + *    A predefined specific reteurn value which is 0xAB only used to validate
> + *    communication to Secure Display TA is functional.
> + *    This value is used to validate whether TA is responding successfully
> + */
> +enum ta_securedisplay_ta_query_cmd_ret {
> +	/* This is a value to validate if TA is loaded successfully */
> +	TA_SECUREDISPLAY_QUERY_CMD_RET                 = 0xAB,
> +};
> +
> +/** @enum ta_securedisplay_buffer_size
> + *    I2C Buffer size which contains 8 bytes of ROI  (X start, X end, Y start, Y end)
> + *    and 6 bytes of CRC( R,G,B) and 1  byte for physical ID
> + */
> +enum ta_securedisplay_buffer_size {
> +	/* 15 bytes = 8 byte (ROI) + 6 byte(CRC) + 1 byte(phy_id) */
> +	TA_SECUREDISPLAY_I2C_BUFFER_SIZE                = 15,
> +};
> +
> +/** Input/output structures for Secure Display commands */ 
> +/**********************************************************/
> +/**
> + * Input structures
> + */
> +
> +/** @struct ta_securedisplay_send_roi_crc_input
> + *    Physical ID to determine which DIO scratch register should be used to get ROI
> + */
> +struct ta_securedisplay_send_roi_crc_input {
> +	uint32_t  phy_id;  /* Physical ID */ };
> +
> +/** @union ta_securedisplay_cmd_input
> + *    Input buffer
> + */
> +union ta_securedisplay_cmd_input {
> +	/* send ROI and CRC input buffer format */
> +	struct ta_securedisplay_send_roi_crc_input        send_roi_crc;
> +	uint32_t                                          reserved[4];
> +};
> +
> +/**
> + * Output structures
> + */
> +
> +/** @struct ta_securedisplay_query_ta_output
> + *  Output buffer format for query TA whether TA is responding used 
> +only for validation purpose  */ struct 
> +ta_securedisplay_query_ta_output {
> +	/* return value from TA when it is queried for validation purpose only */
> +	uint32_t  query_cmd_ret;
> +};
> +
> +/** @struct ta_securedisplay_send_roi_crc_output
> + *  Output buffer format for send ROI CRC command which will pass I2c 
> +buffer created inside TA
> + *  and used to write to I2C used only for validation purpose  */ 
> +struct ta_securedisplay_send_roi_crc_output {
> +	uint8_t  i2c_buf[TA_SECUREDISPLAY_I2C_BUFFER_SIZE];  /* I2C buffer */
> +	uint8_t  reserved;
> +};
> +
> +/** @union ta_securedisplay_cmd_output
> + *    Output buffer
> + */
> +union ta_securedisplay_cmd_output {
> +	/* Query TA output buffer format used only for validation purpose*/
> +	struct ta_securedisplay_query_ta_output            query_ta;
> +	/* Send ROI CRC output buffer format used only for validation purpose */
> +	struct ta_securedisplay_send_roi_crc_output        send_roi_crc;
> +	uint32_t                                           reserved[4];
> +};
> +
> +/** @struct securedisplay_cmd
> + *    Secure Display Command which is shared buffer memory
> + */
> +struct securedisplay_cmd {
> +	uint32_t                             cmd_id;                    /* +0  Bytes Command ID */
> +	enum ta_securedisplay_status         status;     /* +4  Bytes Status of Secure Display TA */
> +	uint32_t                             reserved[2];               /* +8  Bytes Reserved */
> +	union ta_securedisplay_cmd_input     securedisplay_in_message;  /* +16 Bytes Input Buffer */
> +	union ta_securedisplay_cmd_output    securedisplay_out_message;/* +32 Bytes Output Buffer */
> +	/**@note Total 48 Bytes */
> +};
> +
> +#endif   //_TA_SECUREDISPLAY_IF_H
> +
> --
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C412e6e36b944466d66d308d8b776971b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637461067283628266%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=uEThCAg2t2tTIXv34TH4NKiE4D%2BXimtmcuMF8lb15HU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
