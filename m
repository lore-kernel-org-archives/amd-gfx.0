Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2CEC4320E
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 07:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DA3960F42
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 07:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5DA3960F42
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 019C26E8ED;
	Fri, 27 Aug 2021 07:49:58 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B2596E8ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 07:49:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJK0v2Pe/CR55ycjTCugG82C9HIwECav3pqzHVNdyzNydzsSb29gQY1M0mMZDT3ENlKQ5XvMUlE76Tp0NZh/Kl7TSRDS/fenTP0mG5YWa06UuOqMOS7274qGu/AAWYM25AGPwPX6x2zr3GAnqeBmNJOIwi/92Z504KGh3uKCjzvtvz3xOlSZOWP4M+arJ11a/ML3tQW5oS5BsO/fwOaNqIGyYImaX3gqCwqaMpi27c9vbAHvMXZYDmrMNQR5cyvHF/ZqzB1n4rnT7wvLEIOAsTQUWpS9llBd6v/h8dZaoxqz1uu59xPuE5GTQgbp+fkvbAH09/vqPy+pE+PnxUvXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkxnzyphs3MCAOQLQjr3bYd8xaAo63/Nt7krrLUcZ4w=;
 b=iPIxJI41an57NyDO5uB2abxPe2gInJ3rPfhoILDOKf5G07zFqfkUe1+PIsMUba32wgKTwNQjcCJZiYjB8A9k+1Oa3FSBSXuOKISa/mSOHOPfejee6dDRPT6sn+tKdMuJgbe3WsG4qT7Wq1rc0keEzxskeNP6ksUQyaOTZZMKav9/Bh+rkZueIHmBG8gI/zIbHGkJMl+1Q1MIt+syzWQGlobqYEqsVzPvMSgRczOtp3v2sLBxkYS4t8o3Xw0uaewwOksGxgZ2I5VUArmfDVZXKbUsDIiGNIegp4dBV6sg+O3ruiVCBjphi3DF5K5VPWMNpC/IIW3C9PX/CH2osYehmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkxnzyphs3MCAOQLQjr3bYd8xaAo63/Nt7krrLUcZ4w=;
 b=mB3gp3lwS4It25/nM3yOTNIIK/f+LEzsudsb+82gQruyu3AD2N0GBuBga0mXSuSQNZMXxq57OKIP5I5TfSnknkwsqTrJ+ZLRVkcZy+EUhS0x2OTnS1VdYEIDiCTPlVVDum8v4FM9os5DIQhNEhSqIzYHeoh0Z/NQHEhM7DCfKS4=
Received: from BN9PR03CA0512.namprd03.prod.outlook.com (2603:10b6:408:131::7)
 by MWHPR12MB1647.namprd12.prod.outlook.com (2603:10b6:301:c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Fri, 27 Aug
 2021 07:16:57 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::b7) by BN9PR03CA0512.outlook.office365.com
 (2603:10b6:408:131::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 27 Aug 2021 07:16:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 07:16:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 27 Aug
 2021 02:16:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 27 Aug
 2021 02:16:55 -0500
Received: from wayne-dev (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Fri, 27 Aug 2021 02:16:52 -0500
Date: Fri, 27 Aug 2021 15:16:51 +0800
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: YuBiao Wang <YuBiao.Wang@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Evan Quan
 <Evan.Quan@amd.com>, <horace.chen@amd.com>, Tuikov Luben
 <Luben.Tuikov@amd.com>, Christian =?utf-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Deucher Alexander <Alexander.Deucher@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, "Monk
 Liu" <Monk.Liu@amd.com>, Feifei Xu <Feifei.Xu@amd.com>, Kevin Wang
 <Kevin1.Wang@amd.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add ready_to_reset resp for vega10
Message-ID: <20210827071651.txvhtqfxrlwiyktx@wayne-dev>
References: <20210827065651.459756-1-YuBiao.Wang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210827065651.459756-1-YuBiao.Wang@amd.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b98e8b33-2e3a-44de-9dc8-08d9692aa785
X-MS-TrafficTypeDiagnostic: MWHPR12MB1647:
X-Microsoft-Antispam-PRVS: <MWHPR12MB16474D472DF1CD8A74594601B7C89@MWHPR12MB1647.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aHsWeMIrpqmi5tWL0yQ+Gvt+Y+MuHWEuA+dsXVnF5rB5fdRY6LHAopMEnG+wJLQI9YLn3Vr3TJ8i9T9gtZGRXBZVjEwc5TrrZUlh8TeRkadUVEx3XVf7au7Roa708F/x94Px4q9L+S8zh5usfF6VVdvqr0iE9ePGOQZYHfmPgqHvTCvNXUM+MFXMGZsXX6mn0Xf9t/N4nmr7pvFxe12cqkPcZUCr2+wm6T8tegs5PB8V4USq8ZxcxB0WuuuS5NmXr2Zx2Y6EGbQT+Odq79+mbm3761kerQ5qXcs7uSXL09VqWGm3VdTPMM9MgS7CmPdU1fpvWK+L3s3TVKnVosPpZhF3+WRT2Mh4Um0Dej5hTwZZUFcihFFWYdjlSaNVJNNrgcxj409dx9HXGjPkrJMccvJqzkVDfcqFpZOPEqzmsioHL/2mW5CyKhnfWLJ1TuYCSZP6ETM0gGULqp3qshDZAaDv0OSu0k4lhzCveMrE6g1WlCg9wQzQTdC5P74m5BRh7x3kSuIBI/8l/deWbiFBBQhNBDswl8TDamkouiSxXrofy03N0XcGw9wBTffvMcKdR/+ptGj5kK/vvfu6Jn/zlEm8UQTdI22AQe5rtwPU0jDlF7x81SwGLyJP4Demh0Fr1pKMgRdUM8lKyQC9geZYozaCSoIzjKwF6Q8cxseyJbLZF3yYVhilkY2f3mRtIWjsIOssGJX3+q8zDk96O1fPf7fLwTI7gOMHu4x8E1Xe/do=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(36840700001)(33716001)(336012)(478600001)(5660300002)(86362001)(47076005)(82310400003)(26005)(8676002)(2906002)(36860700001)(8936002)(3716004)(426003)(70586007)(9686003)(70206006)(55016002)(356005)(81166007)(186003)(316002)(82740400003)(110136005)(83380400001)(54906003)(4326008)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 07:16:56.9300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b98e8b33-2e3a-44de-9dc8-08d9692aa785
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1647
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Jingwen Chen <Jingwen.Chen2@amd.com>
On Fri Aug 27, 2021 at 02:56:51PM +0800, YuBiao Wang wrote:
> Send response to host after received the flr notification from host.
> Port NV change to vega10.
> 
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 2 ++
>  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index ff2307d7ee0f..23b066bcffb2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -258,6 +258,8 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
>  	amdgpu_virt_fini_data_exchange(adev);
>  	atomic_set(&adev->in_gpu_reset, 1);
>  
> +	xgpu_ai_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
> +
>  	do {
>  		if (xgpu_ai_mailbox_peek_msg(adev) == IDH_FLR_NOTIFICATION_CMPL)
>  			goto flr_done;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
> index 50572635d0f8..bd3b23171579 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
> @@ -37,6 +37,7 @@ enum idh_request {
>  	IDH_REQ_GPU_RESET_ACCESS,
>  
>  	IDH_LOG_VF_ERROR       = 200,
> +	IDH_READY_TO_RESET 	= 201,
>  };
>  
>  enum idh_event {
> -- 
> 2.25.1
> 
