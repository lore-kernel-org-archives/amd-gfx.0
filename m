Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAC2C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 03:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D3FA2310E
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 03:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3FA2310E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7FCF89CF7;
	Wed, 13 Jan 2021 03:52:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DB3889CF7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 03:52:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h17ewIJbeLVRokiu3S8iabwxfrrr0P/TI0YMjcAkYPoDCcUGchtGrPZHDzHlCtsEL4ByIhGU56FwlO64bw5tY8n+K5YDgIFR+1jQMb0s8Kt5kZ+tT8PmSi5QA6KQDEFMS82vgI3AWABd6Pnja3fz/W5pvOGAZLGCX+Owxx7vnwE3dIhEGsVEHaReCW0k6dT6FgeQubzz98dqGMOD8lQTSjb9PkbUGpEIwewMN/IjRqzX0KGjv2l1jI5z/hfMw2+vJ/x5HmTIbqtkxv6apttnHvfSRSUzu8J46H+M4rDdeKj9Y75lcZw4JHCgnDeHWpcmDGT6QWBuqN8hcyLd/aYzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJXuubZ5UDm1HbVIwQX2NoyTclmKqrEGr3frqQFXG+8=;
 b=JDwkl6NYs4HUucQu32vJapdQFaGVXE20o4RstMtECfeX7YIDao5jdTNIstD28SoDHgdp5VjPZBPySN/g112woAfB2L/xc4c1KKWMN2vtmNOmPXqUnniGeIFa8p9Yn/kpxDAGlkqyHH/tS4fMkxqFfSn8ah/PThHS8rycl+lPx168xt9s3mVnLkmmkJfj8YS6Bck6dObekRDTRs9wyFdx9GYGDPUKMP7DKTrIVyGZ40e9wMQ86eeNpGXI0Y/Ga19uiofM27ZYXi9eyKCFKsghq4R9S3dAEehL8W0N5tTuszetFRcfZFR6AXtZEzO7KFOr5FRSzhrnwlW5bsmQWh6fHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJXuubZ5UDm1HbVIwQX2NoyTclmKqrEGr3frqQFXG+8=;
 b=hRx7wwbNNxtNWDHim2r/30KGokEk/HXWENTw8F6roAOHf/drBKUh69pjn3CdSLPgwwKrzf/01ELyGJcaRfrhhQLuUF6Ln9GyvpN7RPuZtpmqHhj+aHvLdU+wyHkVT4Rl1oQiboDV6li13eP2Iz7hgtpOOrSKqmzSWcrfssnGVOc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW2PR12MB2457.namprd12.prod.outlook.com (2603:10b6:907:10::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Wed, 13 Jan
 2021 03:51:58 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 03:51:58 +0000
Date: Wed, 13 Jan 2021 11:51:50 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Add Secure Display TA header file
Message-ID: <20210113035150.GC135176@hr-amd>
References: <20210113034354.14557-1-Jinzhou.Su@amd.com>
Content-Disposition: inline
In-Reply-To: <20210113034354.14557-1-Jinzhou.Su@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR03CA0051.apcprd03.prod.outlook.com
 (2603:1096:202:17::21) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (180.167.199.189) by
 HK2PR03CA0051.apcprd03.prod.outlook.com (2603:1096:202:17::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.2 via Frontend Transport; Wed, 13 Jan 2021 03:51:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 067a00fe-2865-4ae2-c74d-08d8b776937a
X-MS-TrafficTypeDiagnostic: MW2PR12MB2457:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24572920C1AAE51D8EBBE421ECA90@MW2PR12MB2457.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:530;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JR6YkNnc7xktZGRYGAeJW/PwtCZjBAHYM8va8v7JsoXLsJcaIezN4rad8oJFmpgV2zf3nofLLyA9t3+gdrgDArOmYwnGFzDbqe7Lx5W1LEZWBnpwg9H2ex7b9NJkL+XKqqyhq++XE/X80OMZDbevpsCNKxAeW8AVUPVxgSKluRfOMSdVU+2xKd80xoCuA0Q/bguMqS2QJ443fzabrERM3nZr4Q12qD7vTJlVkMd7dMg3Tz2+OQeyr9Nsph/rMeiDk7RYZ5tnley9vJqR8ChUOdV82Rd+afIrZ2gvf7u0gH/RUD/Z8q3uxDaIe6XB7pjEBzFuLniUIk7iZaQ7WIfi2DoWaYISS3yI5G/nCHIZO2/r6qZCAWYvcDyHmHKtjNq9imCXJsX2vIIed8LcHNKP4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(66476007)(66556008)(86362001)(66946007)(316002)(4326008)(2906002)(1076003)(33656002)(186003)(8936002)(9686003)(6862004)(6636002)(8676002)(6666004)(33716001)(5660300002)(52116002)(6496006)(956004)(83380400001)(16526019)(478600001)(26005)(55016002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Uu1xejunYOJKcR/I8x3oJwAlWZUMttJG+SJjfNrv6pKP4113L2E65ZGD4DK9?=
 =?us-ascii?Q?ntJ2rsUVcok9Ux7zh9tg/R6FtCn2g89BagRTfByExOPJ/hZgYFw8T3kQ9LX0?=
 =?us-ascii?Q?eJrtEKgmj9I6arrY51VTRMWyGStgERsce692eUW/cTg0ZaiHZOSrSb7N8FqH?=
 =?us-ascii?Q?uvOPSfb1ivsNw9GvFSIwYNksntJgXPxwXmkGOAL6WDPim3bwpGG+23ArXodW?=
 =?us-ascii?Q?88M6ozD/a1N6bPzH1HU1e405eTTT6T6pZEXUVXkcOGFdQlm/7lWMOPtEJGh2?=
 =?us-ascii?Q?GBchy6hdlGe4MQpWY3n/G0BL8+4hlrVloMl7dCe/GEIDtZ7M72/N86iFmPzA?=
 =?us-ascii?Q?lFwEgFf0X1BsE4Y+xDeFYdw1Wa1PtqhUAIH67LvuclCSEg3+yTNZu/VTbt3r?=
 =?us-ascii?Q?hy9UewxsHozxtIJEFTynRNTTTrXRKlfQDY/XExZ3neY3dLg3e70cKvdt1lam?=
 =?us-ascii?Q?J/rmH9ux1dBdnPW1gATzH+RfsA8jqtmgIC6gVkcwKWBdNSB8huxOt5XtyviE?=
 =?us-ascii?Q?I/pPHXZVNy1WGGCoep2EhFdyTraXIARyDghMJVMgXHavy32REZ2FkrAhoG4y?=
 =?us-ascii?Q?Fays3BjuFNZk0fhXB5dG5WcicL4cVa3JyJAyXoLHd0oFjH0fCNYZ6baRmLHB?=
 =?us-ascii?Q?1EYrKxR4cFRX+Suf7r5DM7V5OOmSM6CPwkGSlemYNTb/S7kQA9kk+27MvxNl?=
 =?us-ascii?Q?143evo/3gi6d0bp+9Z91PTwHW48mx2ssxiA8kEcXhXrnP0bsYIhM7Az5BR3X?=
 =?us-ascii?Q?kMs59s5gXH0tL9Ogbs9DxcS7LdHsj98CdrV3dx+i7W+/QRer7t41+7V+QZg+?=
 =?us-ascii?Q?yXWteZPP7iZFvWSy8ThYYp7jwLNvKO7f4xyly5PjZOANj/cnSYIPIo2fq5tU?=
 =?us-ascii?Q?o75HZH/Q5AwYiXg0zZ5fz1g/3uSfNo92NyduqqrH24Kumj490v2dIgx/QFyu?=
 =?us-ascii?Q?cGCr4nHSEBDNfRD9L7Lwfn+dNtz+CEPU2SFwS+FIJLk4wsFevrxBlVNkhQOD?=
 =?us-ascii?Q?myi/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2021 03:51:58.0416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 067a00fe-2865-4ae2-c74d-08d8b776937a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPlQ6Y/PgBW/wIH/bKlvgcPNOZMBXVcu10gSdKZpD47aWj5wxigwVzPETbIh4n0VFqSvliM/Pe3u2RjVASH8rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2457
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

On Wed, Jan 13, 2021 at 11:43:53AM +0800, Su, Jinzhou (Joe) wrote:
> Add file ta_secureDisplay_if.h for Secure Display TA
> 
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/ta_secureDisplay_if.h  | 154 ++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h b/drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
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
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
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
> +	uint32_t  phy_id;  /* Physical ID */
> +};
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
> + *  Output buffer format for query TA whether TA is responding used only for validation purpose
> + */
> +struct ta_securedisplay_query_ta_output {
> +	/* return value from TA when it is queried for validation purpose only */
> +	uint32_t  query_cmd_ret;
> +};
> +
> +/** @struct ta_securedisplay_send_roi_crc_output
> + *  Output buffer format for send ROI CRC command which will pass I2c buffer created inside TA
> + *  and used to write to I2C used only for validation purpose
> + */
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
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
