Return-Path: <SRS0=qt+g=GW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5682C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 03:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387AA2184D
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jan 2021 03:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387AA2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A935889010;
	Tue, 19 Jan 2021 03:28:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BF7689010
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jan 2021 03:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dorj0jrtLXeAfv2zLDW2TGIJuuwrjE5cizVabxvg/hT5udyje6JiNizjcfoZFsRA+y6ioAxkQLC1LOEo+tdEm61JEzz4xjNckWPIc7fYeuVhfSGm47tCad6ircVIZjPSJVjmVWBYA40o0JwDufWIbQQISk4e13zr5IfvPelf76Yq69/ul16hN8izP6uhbpaiY2DnuCq79iZpOzzkvJUpwfKZfLGK0fmVQ7QroR8uVEkgo3K4P6QH7ehnSHU30brHM+GbG2tLDp6cRBJLYotzOTT/HKpeE3zs1MU9WlKD1+/pIsBlNbYgtSMhoDDPTxv9I6r4nN4RJJ77A5pQfxXExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5WpaLgUWX88mYD/OkPBVUo4MslzKq8AzlxNR/PGRmk=;
 b=jIYJ0dplVdoz3EMGDaDdRnAuM9MLH7tcoEk9FJi2iu4pLvUyyVqbt3zqaYP6fPsH7RMhr27exo4m+dNo02Kbw0vRRV5RolWfqToCKmtJ3H+CKwx182qToCOCsmZ+Jtktvig4Bzc9qptOZryod7kr5AMcDL99u/uXn9JSoNjXVkSH+aQrN96FIiVikbXQ16aRbRqsSArKVn4ISLigiPwFkO8vxeDMMQQS3MRvdENN2EDr/0pv837PI59iZzYHEgnYnFbq4VIOk9f/Qf8iK+5migSbRgrc8D37tmCxbxmRd8WBIRgqY8Qb7KZuBxUbHXw63n0hj3d/B3pokmd+GOZsCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5WpaLgUWX88mYD/OkPBVUo4MslzKq8AzlxNR/PGRmk=;
 b=viwcs8Yf0nX5K8BG1/ztgGpAVPD6A1JUIHQf9aU3NBGx5U/osgEAo5wtqfQv8cWx8QOSGAyXHGZtrPlsi0sBQzPH1j2rZBwjtosoBv47YODI8KFEJr+vG9aWN1bLupkH6Z7/nZTnDXIMrMfTQ+0XJdXzkhv2F/BhyzrPpbODDk8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR1201MB0029.namprd12.prod.outlook.com (2603:10b6:301:4d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Tue, 19 Jan
 2021 03:28:49 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 03:28:49 +0000
Date: Tue, 19 Jan 2021 11:28:42 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>
Subject: Re: [PATCH] drm/amdgpu/pm: no need GPU status set since
 mmnbif_gpu_BIF_DOORBELL_FENCE_CNTL added in FSDL
Message-ID: <20210119032842.GA34485@hr-amd>
References: <1611019602-16557-1-git-send-email-Prike.Liang@amd.com>
Content-Disposition: inline
In-Reply-To: <1611019602-16557-1-git-send-email-Prike.Liang@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0182.apcprd02.prod.outlook.com
 (2603:1096:201:21::18) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (180.167.199.189) by
 HK2PR02CA0182.apcprd02.prod.outlook.com (2603:1096:201:21::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.10 via Frontend Transport; Tue, 19 Jan 2021 03:28:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 15a9a8ae-ae4b-4fe8-2c96-08d8bc2a55de
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0029:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0029BB716442CE9EB89D41FDECA30@MWHPR1201MB0029.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s4uCOZkZ3/4JzEF6eOlrYHqZ3kg2egxQi09WOFZ1baQDfD5zXJluXyHAyTuAf8lr4w1TXov3+SO3RF6UxVLeSE/XnxShkflgRmn6Q61jukddfp/u5KIXpwNVtxBX4MahbtPNrFzvqqdqkkWQYkk/pwaN7HG2+NNwgTcpDtyel2pp8xdaqfmAZ1YcSVKTtzVNRgARYwv3c0aRv4Wu+WLKrqJisQDzFsJMaolSaqV2tQlsmXwU0w9smgHgEpS9bIr2i+sUQOq+j5CNP9ei1m0LmTJ1kp6IqJXQ4MbS/ZENueJ9MIyIFus+igkJ3vnPfsXUA2pf2nI7huJoeKlYVs6jIZ5u4qbZcM6v8ROEk5VPsftzmS6OxAHbkcTE5AwhAFhRdx3bKL8xvfjlnyA8zfAdAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(66476007)(66556008)(66946007)(6666004)(6636002)(6862004)(33716001)(8936002)(2906002)(26005)(16526019)(316002)(52116002)(83380400001)(54906003)(478600001)(956004)(6496006)(8676002)(9686003)(55016002)(4326008)(33656002)(5660300002)(186003)(1076003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8kb1dyw+/JEeG4a6k1sSbMI4CtroHAkCywm3X1QwxK59nUliD+BXc3+zf9Ba?=
 =?us-ascii?Q?K3jbXG6m/R7vUOTH2qBI4JuVrWUUsdn/08DrKWiK/2ibS/ZLFlyjaJVhqlF5?=
 =?us-ascii?Q?6I5kNL6/JjmCT4y7lZB9tArcawoDU/HK4kgZ177iFDUrZr7kUWYW8b22cJss?=
 =?us-ascii?Q?BDuzrZX9ERGg74NGgcQk6PH8s8yl3n6nDQtVRACJLTt2gTbQGSDZaBkzB0Qg?=
 =?us-ascii?Q?r2G69i0K0V4LpHHBNrxQ9kcS+4l/2WEgmmrtIl+ipPmEfGVA+ssGE+oRDo1a?=
 =?us-ascii?Q?nzN3tbTXlHcuh9CSSEh1u5dy+TXtQTMfh3q8lm5d490DByAUwrEHw1vqlHVX?=
 =?us-ascii?Q?I5Hf2espefWFfO0dRgkeSr39taw5NNg7j8nqlpnaxOiY+58dHhxYqNvrsIWc?=
 =?us-ascii?Q?uX3LScZADcecDl67w62FPYbVTYP7zN3d/UN++NqoExyvIhqV2sFo/hEZYQ0R?=
 =?us-ascii?Q?se0QCsRbrjb6w+FouJ5CVD68VFcPvpqkcPmerF6f8p7n7aSrWKj+ZF2q3oRW?=
 =?us-ascii?Q?ajY2OyZV95JryJPsk/tEPlG0J0NxkaoIcuQKH+Nk5WE5yAjXlkZWtJoqFbWo?=
 =?us-ascii?Q?7neMGoaDIwOm5yGvwHcHCMv1dKXn9LpvYtvPmTs8RLnDjHrEgTR+6w19WL/8?=
 =?us-ascii?Q?vulSeNviuSd6W80rzCQFxWO+HPPJ1gomA20W7D05xAHu5DFrzRkG2lI9G1+C?=
 =?us-ascii?Q?p8UyP3Cbmh/E+dGqIt6kaZrkOwlTEgyEU4GmhyV86+a0oyZLuijZQpDtwGCv?=
 =?us-ascii?Q?yoN7vHyYweGo8JuN0dch8gY4Ta7YLdOxlzEy14rlSII5i9dXHDMGekd/Ftqt?=
 =?us-ascii?Q?ZVBZL8V3YJJyOosGXpITMM7BacMryjWp4Yz/0+Gg/jm+BbiUiYzRzjiCXtYO?=
 =?us-ascii?Q?lmqGVZmnB7ET3EGQ78spj2B3E4Vt8ildTE01sgsTYDlcKud1KUJ2S7n9fr9L?=
 =?us-ascii?Q?cqwZ9Mgs3eXaFX2flNyqJTBRcZBTpQfFGuf5KaKPPFb60go1tTd8ShHIvOtA?=
 =?us-ascii?Q?sEho?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a9a8ae-ae4b-4fe8-2c96-08d8bc2a55de
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2021 03:28:48.9906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApzBJrSQnn/T3CX+YHMYEoKsgYAuO2LCCzDmoo9/VX7krHbfuSYs3AQc0/XSy8L89qzPkAMwuPKx9rz3ZePGkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0029
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 19, 2021 at 09:26:42AM +0800, Liang, Prike wrote:
> In the renoir there is no need GpuChangeState message set to exit gfxoff in the s0i3 resume since
> mmnbif_gpu_BIF_DOORBELL_FENCE_CNTL has been added in the s0i3 FSDL.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index dfe4eee..ab15570 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -1306,7 +1306,7 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
>  static int renoir_gfx_state_change_set(struct smu_context *smu, uint32_t state)
>  {
>  
> -	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GpuChangeState, state, NULL);
> +	return 0;
>  }
>  
>  static const struct pptable_funcs renoir_ppt_funcs = {
> -- 
> 2.7.4
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
