Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD6AC3F2D2
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 16:00:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C54CF2072D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 16:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="21VdvgnJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54CF2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 728946EBD6;
	Thu,  5 Mar 2020 16:00:01 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770074.outbound.protection.outlook.com [40.107.77.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA2126EBD6
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 16:00:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrvGL79Ojy2foR+ziBN1o43DhSNLyEMjmP1C9m28PL8Qwmk1bkc3ignEyYygIvV5/3xnu1Ij2YK9bzt5GaQuuaTXtuqsQHSahHH8xqaaaO2M2FCdBGV5/5DJj4s8wV8811292Lucqh2vK7G2OhgskNSYDYRzl9mi2IEtp+RaR/dntdpYKe41ZGl7ubDW499gtfyhr1vWOxGsWgxqboT6hz8HC1LUkZoir+XYcG60sHl4O4he0fORFSeRrIJU3VVoYmfvX1BKcyzB1+xzEHfaQxiTSyK8cxupAojoYmLaYgQ9G2UpJhIPBL8VmlnVDjgjyYMe4C4eF1MbPjVWMMNqTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcHAgOYZ6X6EyXDkI6LfgwJ5aXMeoJIXpNCr+q8ifLU=;
 b=VWnIXQlDRJEXpZXpfjRTFXtb4iLqdg6nS0+s92sAsR9NGj7TdRV6/CjcrysExRV3rKU+bZr3rNd9pUWt26PomoLwFtuVZ+sP5hNMPyS/BJZCdvtQO0g5yuiucO51t1tTXopV/79gtw68pv9h6OUHENqFYz1ctPFc0V8Dh9LKA1OK02WWRxhs6LJTqeUZaTiL0Zm2eHtk9g701oEsevzVJuG8cwlUtyu5j1iLVMAtSiBVNTWj0Xbhb7X+qhiFOVViz1Vzi8mTjYhJJcz3RQCuujZ6n3GBZxn14FlNVNd9lOLOVjXFlZc6B7cYilpgM3Wk908oUjxaAaQWPC6MqU9ayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcHAgOYZ6X6EyXDkI6LfgwJ5aXMeoJIXpNCr+q8ifLU=;
 b=21VdvgnJIktqJJ14y7Vt9TbeR0LNNLDJndFpKLMUaLRY7A7jwCUOun71fVju0oaKFlqaJJOTCze77TBvaKrFHxN0sbOG+ffD5JHtrUd3OqKFSBBhBhhsVKFlDrqwt0Ri5nqBSDXmOA7KCtWk8EpLu9nvryriIC3F729eJuTfw14=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (2603:10b6:5:1c9::32)
 by DM6PR12MB3306.namprd12.prod.outlook.com (2603:10b6:5:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Thu, 5 Mar
 2020 15:59:59 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::7c3d:1072:f9d8:8686%6]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 15:59:59 +0000
Subject: Re: [enable VCN2.0 for NV12 SRIOV 1/6] drm/amdgpu: introduce mmsch
 v2.0 header
To: Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1583415187-16594-1-git-send-email-Monk.Liu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <dbdac082-02a2-28ed-01f4-8a21802e714f@amd.com>
Date: Thu, 5 Mar 2020 10:59:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1583415187-16594-1-git-send-email-Monk.Liu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::19) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:a200:445:917c:58ca:660b:c965]
 (2607:fea8:a200:445:917c:58ca:660b:c965) by
 YTXPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11 via Frontend
 Transport; Thu, 5 Mar 2020 15:59:58 +0000
X-Originating-IP: [2607:fea8:a200:445:917c:58ca:660b:c965]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8d3c237b-e728-4bdb-11a8-08d7c11e415a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3306:|DM6PR12MB3306:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3306355B90628864BF74FFD2E5E20@DM6PR12MB3306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(199004)(189003)(16526019)(186003)(5660300002)(478600001)(36756003)(2906002)(30864003)(6486002)(31696002)(31686004)(53546011)(8936002)(52116002)(316002)(81156014)(44832011)(8676002)(81166006)(66556008)(66476007)(66946007)(2616005)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3306;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dTeJL3+AGNgY3k18dYTVrFzxsfYxfdOsyykzkiQn9Rvxa5pBO0SSxI6wEZD7prp15s7ofnyQEb+0Yw8fuPYpBF+2OP3LIwN6qMwMdPRfcYT0iAAvnb1dMYSxhysWn42DNVMktIJLLK7VPbC2i6O5t2HPs5YBwhvEleVeFYXLX3uzvjruyhSXb3/XaNC8MSQ5IP8U4A+rppAkJ8Eh7W28MGTFUV7FJHTDjM0FGXLGT1rqXoxM+XWkOGxYhZe7X5Q2yXmZHc6CjyFSPtwdwBwUwkI43bMbHG1W7hkCtvh5s8atdPoUpI4+7rdddsKrAN4O4zINBgtXm9K+4RMYwm0jTigdZBxmwj/6FlSLGKjCV93wWZeVam8bWDeIanJBgBr7MJUcZkHpnPPMKnwQhr4IOjuoQsAsrXLdMYYbPjh9LaV0EYSib/TrvBOcP7WArgJX
X-MS-Exchange-AntiSpam-MessageData: FQmiA4ypqmq/ItgRZ0/16mkxU7InBrr9w1KrVVYed/oCuwHG7pj1GNYFnvzbSs7xy3k/GxixMB4ewiDWPxi4Gl+HFbED2GgHcbjJW9XNOREcmAlAO5DBbR2VJmDKY9K9UoRn2FC/tBx/GDH8c0QJ7H0CvcQzkr7DSQEV+DC7fVbWAB/RbFhWek6rotjPNLDxtsrYgmz7pIsuf/uUyFTtiA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3c237b-e728-4bdb-11a8-08d7c11e415a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 15:59:59.0033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R08rC5ocW/JAValF5yUahFbeIXYrLnbbkdiOU9ToHXDpzyzbIIfCnFOtAIVfDrui
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3306
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is:

Acked-by: Leo Liu <leo.liu@amd.com>

On 2020-03-05 8:33 a.m., Monk Liu wrote:
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mmsch_v2_0.h | 338 ++++++++++++++++++++++++++++++++
>   1 file changed, 338 insertions(+)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/mmsch_v2_0.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmsch_v2_0.h b/drivers/gpu/drm/amd/amdgpu/mmsch_v2_0.h
> new file mode 100644
> index 0000000..1b5086c
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/mmsch_v2_0.h
> @@ -0,0 +1,338 @@
> +/*
> + * Copyright 2019 Advanced Micro Devices, Inc.
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
> +#ifndef __MMSCH_V2_0_H__
> +#define __MMSCH_V2_0_H__
> +
> +// addressBlock: uvd0_mmsch_dec
> +// base address: 0x1e000
> +#define mmMMSCH_UCODE_ADDR                                                                             0x0000
> +#define mmMMSCH_UCODE_ADDR_BASE_IDX                                                                    0
> +#define mmMMSCH_UCODE_DATA                                                                             0x0001
> +#define mmMMSCH_UCODE_DATA_BASE_IDX                                                                    0
> +#define mmMMSCH_SRAM_ADDR                                                                              0x0002
> +#define mmMMSCH_SRAM_ADDR_BASE_IDX                                                                     0
> +#define mmMMSCH_SRAM_DATA                                                                              0x0003
> +#define mmMMSCH_SRAM_DATA_BASE_IDX                                                                     0
> +#define mmMMSCH_VF_SRAM_OFFSET                                                                         0x0004
> +#define mmMMSCH_VF_SRAM_OFFSET_BASE_IDX                                                                0
> +#define mmMMSCH_DB_SRAM_OFFSET                                                                         0x0005
> +#define mmMMSCH_DB_SRAM_OFFSET_BASE_IDX                                                                0
> +#define mmMMSCH_CTX_SRAM_OFFSET                                                                        0x0006
> +#define mmMMSCH_CTX_SRAM_OFFSET_BASE_IDX                                                               0
> +#define mmMMSCH_CTL                                                                                    0x0007
> +#define mmMMSCH_CTL_BASE_IDX                                                                           0
> +#define mmMMSCH_INTR                                                                                   0x0008
> +#define mmMMSCH_INTR_BASE_IDX                                                                          0
> +#define mmMMSCH_INTR_ACK                                                                               0x0009
> +#define mmMMSCH_INTR_ACK_BASE_IDX                                                                      0
> +#define mmMMSCH_INTR_STATUS                                                                            0x000a
> +#define mmMMSCH_INTR_STATUS_BASE_IDX                                                                   0
> +#define mmMMSCH_VF_VMID                                                                                0x000b
> +#define mmMMSCH_VF_VMID_BASE_IDX                                                                       0
> +#define mmMMSCH_VF_CTX_ADDR_LO                                                                         0x000c
> +#define mmMMSCH_VF_CTX_ADDR_LO_BASE_IDX                                                                0
> +#define mmMMSCH_VF_CTX_ADDR_HI                                                                         0x000d
> +#define mmMMSCH_VF_CTX_ADDR_HI_BASE_IDX                                                                0
> +#define mmMMSCH_VF_CTX_SIZE                                                                            0x000e
> +#define mmMMSCH_VF_CTX_SIZE_BASE_IDX                                                                   0
> +#define mmMMSCH_VF_GPCOM_ADDR_LO                                                                       0x000f
> +#define mmMMSCH_VF_GPCOM_ADDR_LO_BASE_IDX                                                              0
> +#define mmMMSCH_VF_GPCOM_ADDR_HI                                                                       0x0010
> +#define mmMMSCH_VF_GPCOM_ADDR_HI_BASE_IDX                                                              0
> +#define mmMMSCH_VF_GPCOM_SIZE                                                                          0x0011
> +#define mmMMSCH_VF_GPCOM_SIZE_BASE_IDX                                                                 0
> +#define mmMMSCH_VF_MAILBOX_HOST                                                                        0x0012
> +#define mmMMSCH_VF_MAILBOX_HOST_BASE_IDX                                                               0
> +#define mmMMSCH_VF_MAILBOX_RESP                                                                        0x0013
> +#define mmMMSCH_VF_MAILBOX_RESP_BASE_IDX                                                               0
> +#define mmMMSCH_VF_MAILBOX_0                                                                           0x0014
> +#define mmMMSCH_VF_MAILBOX_0_BASE_IDX                                                                  0
> +#define mmMMSCH_VF_MAILBOX_0_RESP                                                                      0x0015
> +#define mmMMSCH_VF_MAILBOX_0_RESP_BASE_IDX                                                             0
> +#define mmMMSCH_VF_MAILBOX_1                                                                           0x0016
> +#define mmMMSCH_VF_MAILBOX_1_BASE_IDX                                                                  0
> +#define mmMMSCH_VF_MAILBOX_1_RESP                                                                      0x0017
> +#define mmMMSCH_VF_MAILBOX_1_RESP_BASE_IDX                                                             0
> +#define mmMMSCH_CNTL                                                                                   0x001c
> +#define mmMMSCH_CNTL_BASE_IDX                                                                          0
> +#define mmMMSCH_NONCACHE_OFFSET0                                                                       0x001d
> +#define mmMMSCH_NONCACHE_OFFSET0_BASE_IDX                                                              0
> +#define mmMMSCH_NONCACHE_SIZE0                                                                         0x001e
> +#define mmMMSCH_NONCACHE_SIZE0_BASE_IDX                                                                0
> +#define mmMMSCH_NONCACHE_OFFSET1                                                                       0x001f
> +#define mmMMSCH_NONCACHE_OFFSET1_BASE_IDX                                                              0
> +#define mmMMSCH_NONCACHE_SIZE1                                                                         0x0020
> +#define mmMMSCH_NONCACHE_SIZE1_BASE_IDX                                                                0
> +#define mmMMSCH_PDEBUG_STATUS                                                                          0x0021
> +#define mmMMSCH_PDEBUG_STATUS_BASE_IDX                                                                 0
> +#define mmMMSCH_PDEBUG_DATA_32UPPERBITS                                                                0x0022
> +#define mmMMSCH_PDEBUG_DATA_32UPPERBITS_BASE_IDX                                                       0
> +#define mmMMSCH_PDEBUG_DATA_32LOWERBITS                                                                0x0023
> +#define mmMMSCH_PDEBUG_DATA_32LOWERBITS_BASE_IDX                                                       0
> +#define mmMMSCH_PDEBUG_EPC                                                                             0x0024
> +#define mmMMSCH_PDEBUG_EPC_BASE_IDX                                                                    0
> +#define mmMMSCH_PDEBUG_EXCCAUSE                                                                        0x0025
> +#define mmMMSCH_PDEBUG_EXCCAUSE_BASE_IDX                                                               0
> +#define mmMMSCH_PROC_STATE1                                                                            0x0026
> +#define mmMMSCH_PROC_STATE1_BASE_IDX                                                                   0
> +#define mmMMSCH_LAST_MC_ADDR                                                                           0x0027
> +#define mmMMSCH_LAST_MC_ADDR_BASE_IDX                                                                  0
> +#define mmMMSCH_LAST_MEM_ACCESS_HI                                                                     0x0028
> +#define mmMMSCH_LAST_MEM_ACCESS_HI_BASE_IDX                                                            0
> +#define mmMMSCH_LAST_MEM_ACCESS_LO                                                                     0x0029
> +#define mmMMSCH_LAST_MEM_ACCESS_LO_BASE_IDX                                                            0
> +#define mmMMSCH_IOV_ACTIVE_FCN_ID                                                                      0x002a
> +#define mmMMSCH_IOV_ACTIVE_FCN_ID_BASE_IDX                                                             0
> +#define mmMMSCH_SCRATCH_0                                                                              0x002b
> +#define mmMMSCH_SCRATCH_0_BASE_IDX                                                                     0
> +#define mmMMSCH_SCRATCH_1                                                                              0x002c
> +#define mmMMSCH_SCRATCH_1_BASE_IDX                                                                     0
> +#define mmMMSCH_GPUIOV_SCH_BLOCK_0                                                                     0x002d
> +#define mmMMSCH_GPUIOV_SCH_BLOCK_0_BASE_IDX                                                            0
> +#define mmMMSCH_GPUIOV_CMD_CONTROL_0                                                                   0x002e
> +#define mmMMSCH_GPUIOV_CMD_CONTROL_0_BASE_IDX                                                          0
> +#define mmMMSCH_GPUIOV_CMD_STATUS_0                                                                    0x002f
> +#define mmMMSCH_GPUIOV_CMD_STATUS_0_BASE_IDX                                                           0
> +#define mmMMSCH_GPUIOV_VM_BUSY_STATUS_0                                                                0x0030
> +#define mmMMSCH_GPUIOV_VM_BUSY_STATUS_0_BASE_IDX                                                       0
> +#define mmMMSCH_GPUIOV_ACTIVE_FCNS_0                                                                   0x0031
> +#define mmMMSCH_GPUIOV_ACTIVE_FCNS_0_BASE_IDX                                                          0
> +#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_0                                                                 0x0032
> +#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_0_BASE_IDX                                                        0
> +#define mmMMSCH_GPUIOV_DW6_0                                                                           0x0033
> +#define mmMMSCH_GPUIOV_DW6_0_BASE_IDX                                                                  0
> +#define mmMMSCH_GPUIOV_DW7_0                                                                           0x0034
> +#define mmMMSCH_GPUIOV_DW7_0_BASE_IDX                                                                  0
> +#define mmMMSCH_GPUIOV_DW8_0                                                                           0x0035
> +#define mmMMSCH_GPUIOV_DW8_0_BASE_IDX                                                                  0
> +#define mmMMSCH_GPUIOV_SCH_BLOCK_1                                                                     0x0036
> +#define mmMMSCH_GPUIOV_SCH_BLOCK_1_BASE_IDX                                                            0
> +#define mmMMSCH_GPUIOV_CMD_CONTROL_1                                                                   0x0037
> +#define mmMMSCH_GPUIOV_CMD_CONTROL_1_BASE_IDX                                                          0
> +#define mmMMSCH_GPUIOV_CMD_STATUS_1                                                                    0x0038
> +#define mmMMSCH_GPUIOV_CMD_STATUS_1_BASE_IDX                                                           0
> +#define mmMMSCH_GPUIOV_VM_BUSY_STATUS_1                                                                0x0039
> +#define mmMMSCH_GPUIOV_VM_BUSY_STATUS_1_BASE_IDX                                                       0
> +#define mmMMSCH_GPUIOV_ACTIVE_FCNS_1                                                                   0x003a
> +#define mmMMSCH_GPUIOV_ACTIVE_FCNS_1_BASE_IDX                                                          0
> +#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_1                                                                 0x003b
> +#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_1_BASE_IDX                                                        0
> +#define mmMMSCH_GPUIOV_DW6_1                                                                           0x003c
> +#define mmMMSCH_GPUIOV_DW6_1_BASE_IDX                                                                  0
> +#define mmMMSCH_GPUIOV_DW7_1                                                                           0x003d
> +#define mmMMSCH_GPUIOV_DW7_1_BASE_IDX                                                                  0
> +#define mmMMSCH_GPUIOV_DW8_1                                                                           0x003e
> +#define mmMMSCH_GPUIOV_DW8_1_BASE_IDX                                                                  0
> +#define mmMMSCH_GPUIOV_CNTXT                                                                           0x003f
> +#define mmMMSCH_GPUIOV_CNTXT_BASE_IDX                                                                  0
> +#define mmMMSCH_SCRATCH_2                                                                              0x0040
> +#define mmMMSCH_SCRATCH_2_BASE_IDX                                                                     0
> +#define mmMMSCH_SCRATCH_3                                                                              0x0041
> +#define mmMMSCH_SCRATCH_3_BASE_IDX                                                                     0
> +#define mmMMSCH_SCRATCH_4                                                                              0x0042
> +#define mmMMSCH_SCRATCH_4_BASE_IDX                                                                     0
> +#define mmMMSCH_SCRATCH_5                                                                              0x0043
> +#define mmMMSCH_SCRATCH_5_BASE_IDX                                                                     0
> +#define mmMMSCH_SCRATCH_6                                                                              0x0044
> +#define mmMMSCH_SCRATCH_6_BASE_IDX                                                                     0
> +#define mmMMSCH_SCRATCH_7                                                                              0x0045
> +#define mmMMSCH_SCRATCH_7_BASE_IDX                                                                     0
> +#define mmMMSCH_VFID_FIFO_HEAD_0                                                                       0x0046
> +#define mmMMSCH_VFID_FIFO_HEAD_0_BASE_IDX                                                              0
> +#define mmMMSCH_VFID_FIFO_TAIL_0                                                                       0x0047
> +#define mmMMSCH_VFID_FIFO_TAIL_0_BASE_IDX                                                              0
> +#define mmMMSCH_VFID_FIFO_HEAD_1                                                                       0x0048
> +#define mmMMSCH_VFID_FIFO_HEAD_1_BASE_IDX                                                              0
> +#define mmMMSCH_VFID_FIFO_TAIL_1                                                                       0x0049
> +#define mmMMSCH_VFID_FIFO_TAIL_1_BASE_IDX                                                              0
> +#define mmMMSCH_NACK_STATUS                                                                            0x004a
> +#define mmMMSCH_NACK_STATUS_BASE_IDX                                                                   0
> +#define mmMMSCH_VF_MAILBOX0_DATA                                                                       0x004b
> +#define mmMMSCH_VF_MAILBOX0_DATA_BASE_IDX                                                              0
> +#define mmMMSCH_VF_MAILBOX1_DATA                                                                       0x004c
> +#define mmMMSCH_VF_MAILBOX1_DATA_BASE_IDX                                                              0
> +#define mmMMSCH_GPUIOV_SCH_BLOCK_IP_0                                                                  0x004d
> +#define mmMMSCH_GPUIOV_SCH_BLOCK_IP_0_BASE_IDX                                                         0
> +#define mmMMSCH_GPUIOV_CMD_STATUS_IP_0                                                                 0x004e
> +#define mmMMSCH_GPUIOV_CMD_STATUS_IP_0_BASE_IDX                                                        0
> +#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_0                                                              0x004f
> +#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_0_BASE_IDX                                                     0
> +#define mmMMSCH_GPUIOV_SCH_BLOCK_IP_1                                                                  0x0050
> +#define mmMMSCH_GPUIOV_SCH_BLOCK_IP_1_BASE_IDX                                                         0
> +#define mmMMSCH_GPUIOV_CMD_STATUS_IP_1                                                                 0x0051
> +#define mmMMSCH_GPUIOV_CMD_STATUS_IP_1_BASE_IDX                                                        0
> +#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_1                                                              0x0052
> +#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_1_BASE_IDX                                                     0
> +#define mmMMSCH_GPUIOV_CNTXT_IP                                                                        0x0053
> +#define mmMMSCH_GPUIOV_CNTXT_IP_BASE_IDX                                                               0
> +#define mmMMSCH_GPUIOV_SCH_BLOCK_2                                                                     0x0054
> +#define mmMMSCH_GPUIOV_SCH_BLOCK_2_BASE_IDX                                                            0
> +#define mmMMSCH_GPUIOV_CMD_CONTROL_2                                                                   0x0055
> +#define mmMMSCH_GPUIOV_CMD_CONTROL_2_BASE_IDX                                                          0
> +#define mmMMSCH_GPUIOV_CMD_STATUS_2                                                                    0x0056
> +#define mmMMSCH_GPUIOV_CMD_STATUS_2_BASE_IDX                                                           0
> +#define mmMMSCH_GPUIOV_VM_BUSY_STATUS_2                                                                0x0057
> +#define mmMMSCH_GPUIOV_VM_BUSY_STATUS_2_BASE_IDX                                                       0
> +#define mmMMSCH_GPUIOV_ACTIVE_FCNS_2                                                                   0x0058
> +#define mmMMSCH_GPUIOV_ACTIVE_FCNS_2_BASE_IDX                                                          0
> +#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_2                                                                 0x0059
> +#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_2_BASE_IDX                                                        0
> +#define mmMMSCH_GPUIOV_DW6_2                                                                           0x005a
> +#define mmMMSCH_GPUIOV_DW6_2_BASE_IDX                                                                  0
> +#define mmMMSCH_GPUIOV_DW7_2                                                                           0x005b
> +#define mmMMSCH_GPUIOV_DW7_2_BASE_IDX                                                                  0
> +#define mmMMSCH_GPUIOV_DW8_2                                                                           0x005c
> +#define mmMMSCH_GPUIOV_DW8_2_BASE_IDX                                                                  0
> +#define mmMMSCH_GPUIOV_SCH_BLOCK_IP_2                                                                  0x005d
> +#define mmMMSCH_GPUIOV_SCH_BLOCK_IP_2_BASE_IDX                                                         0
> +#define mmMMSCH_GPUIOV_CMD_STATUS_IP_2                                                                 0x005e
> +#define mmMMSCH_GPUIOV_CMD_STATUS_IP_2_BASE_IDX                                                        0
> +#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_2                                                              0x005f
> +#define mmMMSCH_GPUIOV_ACTIVE_FCN_ID_IP_2_BASE_IDX                                                     0
> +#define mmMMSCH_VFID_FIFO_HEAD_2                                                                       0x0060
> +#define mmMMSCH_VFID_FIFO_HEAD_2_BASE_IDX                                                              0
> +#define mmMMSCH_VFID_FIFO_TAIL_2                                                                       0x0061
> +#define mmMMSCH_VFID_FIFO_TAIL_2_BASE_IDX                                                              0
> +#define mmMMSCH_VM_BUSY_STATUS_0                                                                       0x0062
> +#define mmMMSCH_VM_BUSY_STATUS_0_BASE_IDX                                                              0
> +#define mmMMSCH_VM_BUSY_STATUS_1                                                                       0x0063
> +#define mmMMSCH_VM_BUSY_STATUS_1_BASE_IDX                                                              0
> +#define mmMMSCH_VM_BUSY_STATUS_2                                                                       0x0064
> +#define mmMMSCH_VM_BUSY_STATUS_2_BASE_IDX                                                              0
> +
> +#define MMSCH_VERSION_MAJOR	2
> +#define MMSCH_VERSION_MINOR	0
> +#define MMSCH_VERSION	(MMSCH_VERSION_MAJOR << 16 | MMSCH_VERSION_MINOR)
> +
> +enum mmsch_v2_0_command_type {
> +	MMSCH_COMMAND__DIRECT_REG_WRITE = 0,
> +	MMSCH_COMMAND__DIRECT_REG_POLLING = 2,
> +	MMSCH_COMMAND__DIRECT_REG_READ_MODIFY_WRITE = 3,
> +	MMSCH_COMMAND__INDIRECT_REG_WRITE = 8,
> +	MMSCH_COMMAND__END = 0xf
> +};
> +
> +struct mmsch_v2_0_init_header {
> +	uint32_t version;
> +	uint32_t header_size;
> +	uint32_t vcn_init_status;
> +	uint32_t vcn_table_offset;
> +	uint32_t vcn_table_size;
> +};
> +
> +struct mmsch_v2_0_cmd_direct_reg_header {
> +	uint32_t reg_offset   : 28;
> +	uint32_t command_type : 4;
> +};
> +
> +struct mmsch_v2_0_cmd_indirect_reg_header {
> +	uint32_t reg_offset    : 20;
> +	uint32_t reg_idx_space : 8;
> +	uint32_t command_type  : 4;
> +};
> +
> +struct mmsch_v2_0_cmd_direct_write {
> +	struct mmsch_v2_0_cmd_direct_reg_header cmd_header;
> +	uint32_t reg_value;
> +};
> +
> +struct mmsch_v2_0_cmd_direct_read_modify_write {
> +	struct mmsch_v2_0_cmd_direct_reg_header cmd_header;
> +	uint32_t write_data;
> +	uint32_t mask_value;
> +};
> +
> +struct mmsch_v2_0_cmd_direct_polling {
> +	struct mmsch_v2_0_cmd_direct_reg_header cmd_header;
> +	uint32_t mask_value;
> +	uint32_t wait_value;
> +};
> +
> +struct mmsch_v2_0_cmd_end {
> +	struct mmsch_v2_0_cmd_direct_reg_header cmd_header;
> +};
> +
> +struct mmsch_v2_0_cmd_indirect_write {
> +	struct mmsch_v2_0_cmd_indirect_reg_header cmd_header;
> +	uint32_t reg_value;
> +};
> +
> +static inline void mmsch_v2_0_insert_direct_wt(struct mmsch_v2_0_cmd_direct_write *direct_wt,
> +					       uint32_t *init_table,
> +					       uint32_t reg_offset,
> +					       uint32_t value)
> +{
> +	direct_wt->cmd_header.reg_offset = reg_offset;
> +	direct_wt->reg_value = value;
> +	memcpy((void *)init_table, direct_wt, sizeof(struct mmsch_v2_0_cmd_direct_write));
> +}
> +
> +static inline void mmsch_v2_0_insert_direct_rd_mod_wt(struct mmsch_v2_0_cmd_direct_read_modify_write *direct_rd_mod_wt,
> +						      uint32_t *init_table,
> +						      uint32_t reg_offset,
> +						      uint32_t mask, uint32_t data)
> +{
> +	direct_rd_mod_wt->cmd_header.reg_offset = reg_offset;
> +	direct_rd_mod_wt->mask_value = mask;
> +	direct_rd_mod_wt->write_data = data;
> +	memcpy((void *)init_table, direct_rd_mod_wt,
> +	       sizeof(struct mmsch_v2_0_cmd_direct_read_modify_write));
> +}
> +
> +static inline void mmsch_v2_0_insert_direct_poll(struct mmsch_v2_0_cmd_direct_polling *direct_poll,
> +						 uint32_t *init_table,
> +						 uint32_t reg_offset,
> +						 uint32_t mask, uint32_t wait)
> +{
> +	direct_poll->cmd_header.reg_offset = reg_offset;
> +	direct_poll->mask_value = mask;
> +	direct_poll->wait_value = wait;
> +	memcpy((void *)init_table, direct_poll, sizeof(struct mmsch_v2_0_cmd_direct_polling));
> +}
> +
> +#define MMSCH_V2_0_INSERT_DIRECT_RD_MOD_WT(reg, mask, data) { \
> +	mmsch_v2_0_insert_direct_rd_mod_wt(&direct_rd_mod_wt, \
> +					   init_table, (reg), \
> +					   (mask), (data)); \
> +	init_table += sizeof(struct mmsch_v2_0_cmd_direct_read_modify_write)/4; \
> +	table_size += sizeof(struct mmsch_v2_0_cmd_direct_read_modify_write)/4; \
> +}
> +
> +#define MMSCH_V2_0_INSERT_DIRECT_WT(reg, value) { \
> +	mmsch_v2_0_insert_direct_wt(&direct_wt, \
> +				    init_table, (reg), \
> +				    (value)); \
> +	init_table += sizeof(struct mmsch_v2_0_cmd_direct_write)/4; \
> +	table_size += sizeof(struct mmsch_v2_0_cmd_direct_write)/4; \
> +}
> +
> +#define MMSCH_V2_0_INSERT_DIRECT_POLL(reg, mask, wait) { \
> +	mmsch_v2_0_insert_direct_poll(&direct_poll, \
> +				      init_table, (reg), \
> +				      (mask), (wait)); \
> +	init_table += sizeof(struct mmsch_v2_0_cmd_direct_polling)/4; \
> +	table_size += sizeof(struct mmsch_v2_0_cmd_direct_polling)/4; \
> +}
> +
> +#endif
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
