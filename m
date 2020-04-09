Return-Path: <SRS0=3NI5=5Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E20DC2BA2B
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 12:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F17202078E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2020 12:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BKDI9Z55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17202078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEBBE89E2A;
	Thu,  9 Apr 2020 12:41:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E74689E2A
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2020 12:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HY9KwGCTNdz9Z+2ZndB0Mr3/bw76vsp4fN3Cn5estn7l4ssTxFam86cHpRcpXZLtIgLdknYtaHsfUTojVVclNE0t7sE6XnVtC3ByqSfyp+bEpu//aJnFf9LDtLK0F5alKMlttZs1OlBFb1RH86m9RTrwOgLzEG9txWXJmDjK0XwCudj4Sts9UC+su6/kuLZAwE6QxaRhcTkDtwu/hDgt9GHdBl4bGMjohbQNxy46sPsLkzY9EXHXw1XRTrD3US5IvwLmJSsDZ+D3T2YiNMM8ia3+M/p+9/pVuA483PLPGm6RN3LFr3OO8H1XdLLw4kTauQtqKlyh124sRpqe+s8HLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mx/EU/QLCEcv+RODZnF3sbojIKqg2oNsQkivC0l+Flc=;
 b=Z9JUrEbuVNmOvi9v0FPgQjv2cEb4t3Q1/ZN3DNDEXygu0sIdpExYqWzOjs3uqGKjAPn5ryGP6A0mG3BdnDw7CC0457z0k3WJIMfJSPqVp5X5XQEcIJDnSvNpKn6lw/GZrHTc+dsPV96iORP1BWq7N60pug0sWhUs+JJ95xGicmYElR7JX++YAtD44OIEzQMu13oh06tY6kVVy+k3Tf1VO5LVi9x1sP1ZGD1qflU9FAKYkswkx8E2qAMqQmKgHnQbWMnggRqDoHxlQlJGgFbPQhX4xDGqBwmn15Ch5IaKgBGdQxDyVO7JKGgY8oaE5aLlprpZZEfrjzMJ0fTvkBWf8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mx/EU/QLCEcv+RODZnF3sbojIKqg2oNsQkivC0l+Flc=;
 b=BKDI9Z55JaLdKpzbKlGAFXrjJZ+UCd4bv6cDA3pmbbbIT/Fc9N+TjqKn5dOJIStQTnUq17GfOanqkl1c5Kyii7WKk5fibWScuTccJwKb3qhcBfHGOrWkfLdybhLIagGwa1bwySEqR2Pn1mOepMmlslvqqJ7Fr5/jTf0Rsf6VK9A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Thu, 9 Apr
 2020 12:41:51 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::f164:85c4:1b51:14d2]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::f164:85c4:1b51:14d2%4]) with mapi id 15.20.2878.022; Thu, 9 Apr 2020
 12:41:51 +0000
Subject: Re: [PATCH] drm/amdgpu: restrict debugfs register access under SR-IOV
To: Yintian Tao <yttao@amd.com>, Alexander.Deucher@amd.com, emily.deng@amd.com
References: <20200409060126.30038-1-yttao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <13015ab1-3613-4bed-2a04-a83cbc7b64d4@amd.com>
Date: Thu, 9 Apr 2020 14:41:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200409060126.30038-1-yttao@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM6PR08CA0023.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::35) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM6PR08CA0023.eurprd08.prod.outlook.com (2603:10a6:20b:b2::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.16 via Frontend Transport; Thu, 9 Apr 2020 12:41:49 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 39e1af93-7e37-4dd2-49eb-08d7dc83606a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4154:|DM6PR12MB4154:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4154AE00BAE3F61FCB93CC7F83C10@DM6PR12MB4154.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(2906002)(2616005)(52116002)(4326008)(316002)(81166007)(36756003)(30864003)(6636002)(186003)(66476007)(66946007)(31696002)(478600001)(31686004)(8936002)(66556008)(81156014)(8676002)(86362001)(6666004)(6486002)(16526019)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pqZTEf+UZZCsqOFqGz5x9gH7u/boUrGK+bSC0AhsldpDJmMsgECUQZAG5tJ61rDRPBOp78+1XozyPvxB1jgQFwAG0b8XLodFxPDxnrK8yMS1kAZ1gxIOHUHbvObAxgtBRrJIvHLksUncR+29uT8HjJCCLB4tWg3giP0h6/oSm8fDAThBtZ9FFif+iM4DQYXOGHTGgiJsrfwIbtyou+ztEQr26AYK8DZcPvozGPRfwscX+V/3AP83njObLJ7g0rDe7dVSE1SyqDledxi97Z2JEcF1VAB8pNPDZ1FHWdp1USt8mPVpEyriCTAOVqvDM/g0RDsotmQrZsV+HkkNnJ1d1bxgrIMRoUrXZPMnt01S2bqptaAt7PXrxKWCWhFnVohkzVpA7F0m22oZRk1QyaAxCqA9bh6vNLciO2hHNXkMs+wXJ8+X8+gyvapDSv/Tq3Ar
X-MS-Exchange-AntiSpam-MessageData: rJVbeZba8HV+lZpuX9wUVi6Xd2XyQ2euONRb02QGOmX6hbClt90VaQbuCPMB2YL0rncIhtX1vZGT3zf0I2QJJmP4lk8ESWm+/iD+M4HCsrKAURZOXY705C4rLrTuiUgYTAyfqBj+dWQSKtVgoDNkB378jbCcjGKNHY9H6BCFSN3p/o7K0Km9jXykSByv7bOmit2M0iBR/hk9dK2Ho7EIew==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e1af93-7e37-4dd2-49eb-08d7dc83606a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 12:41:51.7528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDj6esmF5otsus+4hkyWjRIzF79CV3rwhIaQa5ZW3zWHpBBB2zTK83dj2LQn4xJR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.04.20 um 08:01 schrieb Yintian Tao:
> Under bare metal, there is no more else to take
> care of the GPU register access through MMIO.
> Under Virtualization, to access GPU register is
> implemented through KIQ during run-time due to
> world-switch.
>
> Therefore, under SR-IOV user can only access
> debugfs to r/w GPU registers when meets all
> three conditions below.
> - amdgpu_gpu_recovery=0
> - TDR happened
> - in_gpu_reset=0
>
> Signed-off-by: Yintian Tao <yttao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 83 ++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  7 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 23 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  7 ++
>   4 files changed, 114 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index c0f9a651dc06..4f9780aabf5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -152,11 +152,17 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
>   	if (r < 0)
>   		return r;
>   
> +	if (!amdgpu_virt_can_access_debugfs(adev))
> +		return -EINVAL;
> +	else
> +		amdgpu_virt_enable_access_debugfs(adev);
> +

It would be better to merge these two functions together.

E.g. that amdgpu_virt_enable_access_debugfs() returns an error if we 
can't allow this.

And -EINVAL is maybe not the right thing here, since this is not caused 
by an invalid value.

Maybe use -EPERM instead.

Regards,
Christian.

>   	if (use_bank) {
>   		if ((sh_bank != 0xFFFFFFFF && sh_bank >= adev->gfx.config.max_sh_per_se) ||
>   		    (se_bank != 0xFFFFFFFF && se_bank >= adev->gfx.config.max_shader_engines)) {
>   			pm_runtime_mark_last_busy(adev->ddev->dev);
>   			pm_runtime_put_autosuspend(adev->ddev->dev);
> +			amdgpu_virt_disable_access_debugfs(adev);
>   			return -EINVAL;
>   		}
>   		mutex_lock(&adev->grbm_idx_mutex);
> @@ -207,6 +213,7 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
>   	pm_runtime_mark_last_busy(adev->ddev->dev);
>   	pm_runtime_put_autosuspend(adev->ddev->dev);
>   
> +	amdgpu_virt_disable_access_debugfs(adev);
>   	return result;
>   }
>   
> @@ -255,6 +262,11 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
>   	if (r < 0)
>   		return r;
>   
> +	if (!amdgpu_virt_can_access_debugfs(adev))
> +		return -EINVAL;
> +	else
> +		amdgpu_virt_enable_access_debugfs(adev);
> +
>   	while (size) {
>   		uint32_t value;
>   
> @@ -263,6 +275,7 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
>   		if (r) {
>   			pm_runtime_mark_last_busy(adev->ddev->dev);
>   			pm_runtime_put_autosuspend(adev->ddev->dev);
> +			amdgpu_virt_disable_access_debugfs(adev);
>   			return r;
>   		}
>   
> @@ -275,6 +288,7 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
>   	pm_runtime_mark_last_busy(adev->ddev->dev);
>   	pm_runtime_put_autosuspend(adev->ddev->dev);
>   
> +	amdgpu_virt_disable_access_debugfs(adev);
>   	return result;
>   }
>   
> @@ -304,6 +318,11 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
>   	if (r < 0)
>   		return r;
>   
> +	if (!amdgpu_virt_can_access_debugfs(adev))
> +		return -EINVAL;
> +	else
> +		amdgpu_virt_enable_access_debugfs(adev);
> +
>   	while (size) {
>   		uint32_t value;
>   
> @@ -311,6 +330,7 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
>   		if (r) {
>   			pm_runtime_mark_last_busy(adev->ddev->dev);
>   			pm_runtime_put_autosuspend(adev->ddev->dev);
> +			amdgpu_virt_disable_access_debugfs(adev);
>   			return r;
>   		}
>   
> @@ -325,6 +345,7 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
>   	pm_runtime_mark_last_busy(adev->ddev->dev);
>   	pm_runtime_put_autosuspend(adev->ddev->dev);
>   
> +	amdgpu_virt_disable_access_debugfs(adev);
>   	return result;
>   }
>   
> @@ -354,6 +375,11 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
>   	if (r < 0)
>   		return r;
>   
> +	if (!amdgpu_virt_can_access_debugfs(adev))
> +		return -EINVAL;
> +	else
> +		amdgpu_virt_enable_access_debugfs(adev);
> +
>   	while (size) {
>   		uint32_t value;
>   
> @@ -362,6 +388,7 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
>   		if (r) {
>   			pm_runtime_mark_last_busy(adev->ddev->dev);
>   			pm_runtime_put_autosuspend(adev->ddev->dev);
> +			amdgpu_virt_disable_access_debugfs(adev);
>   			return r;
>   		}
>   
> @@ -374,6 +401,7 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struct file *f, char __user *buf,
>   	pm_runtime_mark_last_busy(adev->ddev->dev);
>   	pm_runtime_put_autosuspend(adev->ddev->dev);
>   
> +	amdgpu_virt_disable_access_debugfs(adev);
>   	return result;
>   }
>   
> @@ -403,6 +431,11 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
>   	if (r < 0)
>   		return r;
>   
> +	if (!amdgpu_virt_can_access_debugfs(adev))
> +		return -EINVAL;
> +	else
> +		amdgpu_virt_enable_access_debugfs(adev);
> +
>   	while (size) {
>   		uint32_t value;
>   
> @@ -410,6 +443,7 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
>   		if (r) {
>   			pm_runtime_mark_last_busy(adev->ddev->dev);
>   			pm_runtime_put_autosuspend(adev->ddev->dev);
> +			amdgpu_virt_disable_access_debugfs(adev);
>   			return r;
>   		}
>   
> @@ -424,6 +458,7 @@ static ssize_t amdgpu_debugfs_regs_didt_write(struct file *f, const char __user
>   	pm_runtime_mark_last_busy(adev->ddev->dev);
>   	pm_runtime_put_autosuspend(adev->ddev->dev);
>   
> +	amdgpu_virt_disable_access_debugfs(adev);
>   	return result;
>   }
>   
> @@ -453,6 +488,11 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
>   	if (r < 0)
>   		return r;
>   
> +	if (!amdgpu_virt_can_access_debugfs(adev))
> +		return -EINVAL;
> +	else
> +		amdgpu_virt_enable_access_debugfs(adev);
> +
>   	while (size) {
>   		uint32_t value;
>   
> @@ -461,6 +501,7 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
>   		if (r) {
>   			pm_runtime_mark_last_busy(adev->ddev->dev);
>   			pm_runtime_put_autosuspend(adev->ddev->dev);
> +			amdgpu_virt_disable_access_debugfs(adev);
>   			return r;
>   		}
>   
> @@ -473,6 +514,7 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct file *f, char __user *buf,
>   	pm_runtime_mark_last_busy(adev->ddev->dev);
>   	pm_runtime_put_autosuspend(adev->ddev->dev);
>   
> +	amdgpu_virt_disable_access_debugfs(adev);
>   	return result;
>   }
>   
> @@ -502,6 +544,11 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
>   	if (r < 0)
>   		return r;
>   
> +	if (!amdgpu_virt_can_access_debugfs(adev))
> +		return -EINVAL;
> +	else
> +		amdgpu_virt_enable_access_debugfs(adev);
> +
>   	while (size) {
>   		uint32_t value;
>   
> @@ -509,6 +556,7 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
>   		if (r) {
>   			pm_runtime_mark_last_busy(adev->ddev->dev);
>   			pm_runtime_put_autosuspend(adev->ddev->dev);
> +			amdgpu_virt_disable_access_debugfs(adev);
>   			return r;
>   		}
>   
> @@ -523,6 +571,7 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct file *f, const char __user *
>   	pm_runtime_mark_last_busy(adev->ddev->dev);
>   	pm_runtime_put_autosuspend(adev->ddev->dev);
>   
> +	amdgpu_virt_disable_access_debugfs(adev);
>   	return result;
>   }
>   
> @@ -651,16 +700,25 @@ static ssize_t amdgpu_debugfs_sensor_read(struct file *f, char __user *buf,
>   	if (r < 0)
>   		return r;
>   
> +	if (!amdgpu_virt_can_access_debugfs(adev))
> +		return -EINVAL;
> +	else
> +		amdgpu_virt_enable_access_debugfs(adev);
> +
>   	r = amdgpu_dpm_read_sensor(adev, idx, &values[0], &valuesize);
>   
>   	pm_runtime_mark_last_busy(adev->ddev->dev);
>   	pm_runtime_put_autosuspend(adev->ddev->dev);
>   
> -	if (r)
> +	if (r) {
> +		amdgpu_virt_disable_access_debugfs(adev);
>   		return r;
> +	}
>   
> -	if (size > valuesize)
> +	if (size > valuesize) {
> +		amdgpu_virt_disable_access_debugfs(adev);
>   		return -EINVAL;
> +	}
>   
>   	outsize = 0;
>   	x = 0;
> @@ -673,6 +731,7 @@ static ssize_t amdgpu_debugfs_sensor_read(struct file *f, char __user *buf,
>   		}
>   	}
>   
> +	amdgpu_virt_disable_access_debugfs(adev);
>   	return !r ? outsize : r;
>   }
>   
> @@ -720,6 +779,11 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
>   	if (r < 0)
>   		return r;
>   
> +	if (!amdgpu_virt_can_access_debugfs(adev))
> +		return -EINVAL;
> +	else
> +		amdgpu_virt_enable_access_debugfs(adev);
> +
>   	/* switch to the specific se/sh/cu */
>   	mutex_lock(&adev->grbm_idx_mutex);
>   	amdgpu_gfx_select_se_sh(adev, se, sh, cu);
> @@ -734,16 +798,20 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
>   	pm_runtime_mark_last_busy(adev->ddev->dev);
>   	pm_runtime_put_autosuspend(adev->ddev->dev);
>   
> -	if (!x)
> +	if (!x) {
> +		amdgpu_virt_disable_access_debugfs(adev);
>   		return -EINVAL;
> +	}
>   
>   	while (size && (offset < x * 4)) {
>   		uint32_t value;
>   
>   		value = data[offset >> 2];
>   		r = put_user(value, (uint32_t *)buf);
> -		if (r)
> +		if (r) {
> +			amdgpu_virt_disable_access_debugfs(adev);
>   			return r;
> +		}
>   
>   		result += 4;
>   		buf += 4;
> @@ -751,6 +819,7 @@ static ssize_t amdgpu_debugfs_wave_read(struct file *f, char __user *buf,
>   		size -= 4;
>   	}
>   
> +	amdgpu_virt_disable_access_debugfs(adev);
>   	return result;
>   }
>   
> @@ -805,6 +874,11 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
>   	if (r < 0)
>   		return r;
>   
> +	if (!amdgpu_virt_can_access_debugfs(adev))
> +		return -EINVAL;
> +	else
> +		amdgpu_virt_enable_access_debugfs(adev);
> +
>   	/* switch to the specific se/sh/cu */
>   	mutex_lock(&adev->grbm_idx_mutex);
>   	amdgpu_gfx_select_se_sh(adev, se, sh, cu);
> @@ -840,6 +914,7 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
>   
>   err:
>   	kfree(data);
> +	amdgpu_virt_disable_access_debugfs(adev);
>   	return result;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 2b99f5952375..993b75dde5d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -33,6 +33,7 @@ static void amdgpu_job_timedout(struct drm_sched_job *s_job)
>   	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
>   	struct amdgpu_job *job = to_amdgpu_job(s_job);
>   	struct amdgpu_task_info ti;
> +	struct amdgpu_device *adev = ring->adev;
>   
>   	memset(&ti, 0, sizeof(struct amdgpu_task_info));
>   
> @@ -49,10 +50,12 @@ static void amdgpu_job_timedout(struct drm_sched_job *s_job)
>   	DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
>   		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
>   
> -	if (amdgpu_device_should_recover_gpu(ring->adev))
> +	if (amdgpu_device_should_recover_gpu(ring->adev)) {
>   		amdgpu_device_gpu_recover(ring->adev, job);
> -	else
> +	} else {
>   		drm_sched_suspend_timeout(&ring->sched);
> +		adev->virt.tdr_debug = true;
> +	}
>   }
>   
>   int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 4d06c79065bf..d0dfe99ebc75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -334,3 +334,26 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
>   			adev->virt.caps |= AMDGPU_PASSTHROUGH_MODE;
>   	}
>   }
> +
> +bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev)
> +{
> +	if (!amdgpu_sriov_vf(adev))
> +		return true;
> +
> +	if (amdgpu_sriov_is_debug(adev))
> +		return true;
> +
> +	return false;
> +}
> +
> +void amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev)
> +{
> +	if (amdgpu_sriov_vf(adev))
> +		adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
> +}
> +
> +void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev)
> +{
> +	if (amdgpu_sriov_vf(adev))
> +		adev->virt.caps |= AMDGPU_SRIOV_CAPS_RUNTIME;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index f6ae3c656304..a01742b7bf12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -265,6 +265,7 @@ struct amdgpu_virt {
>   	uint32_t gim_feature;
>   	uint32_t reg_access_mode;
>   	int req_init_data_ver;
> +	bool tdr_debug;
>   };
>   
>   #define amdgpu_sriov_enabled(adev) \
> @@ -296,6 +297,8 @@ static inline bool is_virtual_machine(void)
>   
>   #define amdgpu_sriov_is_pp_one_vf(adev) \
>   	((adev)->virt.gim_feature & AMDGIM_FEATURE_PP_ONE_VF)
> +#define amdgpu_sriov_is_debug(adev) \
> +	((!adev->in_gpu_reset) && adev->virt.tdr_debug)
>   
>   bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
>   void amdgpu_virt_init_setting(struct amdgpu_device *adev);
> @@ -314,4 +317,8 @@ int amdgpu_virt_fw_reserve_get_checksum(void *obj, unsigned long obj_size,
>   					unsigned int chksum);
>   void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev);
>   void amdgpu_detect_virtualization(struct amdgpu_device *adev);
> +
> +bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
> +void amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
> +void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev);
>   #endif

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
