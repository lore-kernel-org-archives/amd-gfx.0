Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E74C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 10:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0196F6EA67;
	Mon, 29 Nov 2021 10:51:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32F536EA67
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Nov 2021 10:51:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAd8FCJSQPZXaiAbDOVPcyysNeHuUvLYBxNwazUgKgOkzJvZEa+pAQBdwPEfiHNdB95E1cZp94GG8AQdW0A9vKywjm/5hZVZTCgwuCk+O3HpNlOhLQmUbIvOzhARSMnOzQ+OcJIWiQk7UNvp1Ls5Knzw6D3U0LdJ6nPYbGruSR/yZSNj8qQE6PgQrGA5h/V6+VuEhDXa8Be3xlEzANMbqWAp1dmPPdmnHkdsKW3JBfpBPpsJsx63a5MMSBSBlWwKLveUqs7I34PMOziBfr9mWJ+0MNQEBTrW/BhRGEJ27zcnyul1zCePZe5ZptelbPb+tSfkBnApJCDSD0jnsbxN1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lg3VQoBZ9G1BOCOkrdMdVZWuz9Txr5kcZ0SMOZUfAtQ=;
 b=gBIrMiA+COE8wwaOl2QJAfphlztT/7QYvG7pR0iqpOBwGobRWPpJlwNYw4CxDwNdRrDXnS2/Z9/29CKdUlItwnqmLPUG1lPjFUtcLLJFBOOycd4069h3VcNweNl7vKsiyLPAVnahA1Z9KOe5MSepB4wEUSWqidm9Q8A4CrCm1jkau0RoAekAsnD5yo++Ap+ix9fWa2JxhZRt+uNzKzUU7jQnFKmN7MqnWqbfo3iovT4Irut2uZgxF8JaQA6LGVoikCU6ICsY71vtCw7mrpqbbhXqzfJGSozadLOe4CKr/F7iVC5HhoQD1UFNEzDqyVb9V68Ce32A6qgBIxt9DcT2uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lg3VQoBZ9G1BOCOkrdMdVZWuz9Txr5kcZ0SMOZUfAtQ=;
 b=Bv9dYjmLAJv+T3aR9DxyfPPPTspxIZokPyP+lUtvUtMbXrEwVAo7EpmkTUMEvBWtVKN8Gscu6atuQ1QDbkEGWNURpGK3Nnjhgheut8M0f0POaN3uc+erivJ5AM4pl6vZhqPRmJ0K83v9kNVPGDSCX7P9FqXJeJp4qzu1lvdaxM8=
Received: from BN6PR13CA0033.namprd13.prod.outlook.com (2603:10b6:404:13e::19)
 by CO6PR12MB5442.namprd12.prod.outlook.com (2603:10b6:5:35b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Mon, 29 Nov
 2021 10:50:56 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::93) by BN6PR13CA0033.outlook.office365.com
 (2603:10b6:404:13e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.9 via Frontend
 Transport; Mon, 29 Nov 2021 10:50:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 10:50:56 +0000
Received: from [10.65.96.204] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 29 Nov
 2021 04:50:54 -0600
Subject: Re: [PATCH] drm/amd/amdgpu: use advanced TDR mode by default
To: Bokun Zhang <Bokun.Zhang@amd.com>, <amd-gfx@lists.freedesktop.org>
References: <20211127005756.41687-1-Bokun.Zhang@amd.com>
From: JingWen Chen <jingwech@amd.com>
Message-ID: <1b2627f7-5abb-5885-94d7-017fd73b1be5@amd.com>
Date: Mon, 29 Nov 2021 18:50:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211127005756.41687-1-Bokun.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5da716e3-baaa-4ab1-f97b-08d9b3261f12
X-MS-TrafficTypeDiagnostic: CO6PR12MB5442:
X-Microsoft-Antispam-PRVS: <CO6PR12MB5442DA566BC6826F3F4D4E90B7669@CO6PR12MB5442.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z93SNGwNg2Uek2xcV6163GklTuEWZnkE0kwh+XCrU2hc/cZFt5g6GMpfPZyIFcIfYJyubEaJQoV5lHWrLTAHzPXEjpgc996opOunflxd6Hwv/+JQbM1PnZ4HIMk4ZeTPUMLvoTSUO07NfrfZ+rqIiPWZhjXx03mcGUyZIKMC5i5AJ+ot/zPpLR4g77A1nUPJnsonmsy3R8UzOCrZU1yOZLjtLLP6pBP/Qntp7zN3dmyCLyAvwaDyaiiF0WRSW5bn0/mZQ6QUtl4fnyx78W6/YkXiqtg8n5S2UadhwRSY8kEluj47QjDuIioRHboLN7cAVD0CoafTUmhsej1r8O630t26qxXvJVhY+k1pRqR2RJqs8bUdFKdVeUTZ5Sx/BwJCjPsEvIG4qs2VbP2z9O5lEoXxDGtZ2+tgl6FKcPEsT9NHkdNTUu6MooEfWpg/u0WJy7i79VxP/gWGL+ziRifE881/C1ey/NrYsYI0LWnNBM1ZGyCl3p6XCjD62x8IepN1F+/kJH/RcT8CIToD8qVPx09xZVU+IOcpCui6p6yFHibKgLJFBiXhMW3uOqto7jPh5Gkl+1+udGWu86m0ZBXf50B5HJmx079MP/lwx4zAw9FgAGg3Z4Kiqby82ACovJ0mS+USQXie9/3DP9/W0iE1m5KZ1Uifw4p8YDF2hE0BQZGZYrhKYEr4sZHvqrMSDYUQNgoHwrYm7It7HoLC0CK60RoJUKXRNdOXDSlnhi3DqgV5LaeT2qzhmrGX+5Xd03U/SU1udoRA5lUWXAD2k4r+SQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70206006)(26005)(70586007)(110136005)(186003)(8676002)(47076005)(16526019)(316002)(8936002)(81166007)(16576012)(2906002)(31696002)(508600001)(82310400004)(36756003)(83380400001)(31686004)(356005)(36860700001)(5660300002)(2616005)(426003)(336012)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 10:50:56.0672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da716e3-baaa-4ab1-f97b-08d9b3261f12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5442
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

Hi Bokun,

please remove the change-id in your commit message when submitting this patch.

Acked-by:  Jingwen Chen <Jingwen.Chen2@amd.com>

On 2021/11/27 上午8:57, Bokun Zhang wrote:
> From: Bokun Zhang <bokun.zhang@amd.com>
>
> In the patch about advanced TDR mode, we force to always set
> amdgpu_gpu_recovery=2 under SRIOV. This is not ideal, since we
> may want to revert back to use the legacy TDR routine.
>
> Therefore, we only set amdgpu_gpu_recovery=2 when it is
> configured as AUTO, which is the default value (gpu_recovery=-1)
>
> Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
> Change-Id: Ifae78854b53f124d2ea53f401919ab5e403ef822
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 93af2cd2a065..62ec484a35aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -64,8 +64,8 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
>  	adev->cg_flags = 0;
>  	adev->pg_flags = 0;
>  
> -	/*use advance recovery mode for SRIOV*/
> -	if (amdgpu_gpu_recovery)
> +	/* use advance recovery mode for SRIOV by default */
> +	if (amdgpu_gpu_recovery == -1)
>  		amdgpu_gpu_recovery = 2;
>  }
>  
