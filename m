Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3B0C433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 14:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B67F206A1
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 14:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nrjNZP14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B67F206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D64AE6E128;
	Wed, 16 Sep 2020 14:39:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1893E6E128
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 14:39:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqRg92rTCc71Tyq1XYz476Mm7GuOXPdBPG6oJCg05NNSqwdNlSOx/d84LkWc6PvBEfsM5+CWGqQF4rv+oOlqsF46tsk1gb0mWujVjhyfC2fQV9+e1Hc40EQ0Ty4/Fm0LYjR1h+dUDBF3/yNdiLmN1zr12+J2TEKQEEwdl8I1r6MRdhOuI5jfdlCP+2gBjxLkZOOcYOFT7EaiCQDNOyqfalGfl6Kkoo9EuMqEPVNr8NmQc+Q1Wjc4EoIdCJ10gE6pi/byvUNFxhEOk7fN6zPkt3OL9W12II26I6CZithR8NMQUCAQAhw6cyEcOJNMW40wnpema2Aii2ETfV0goNAEoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lvt8S8HrSSZckeHF7TmfNayC+LKDz0JEfTu8yM0wUi4=;
 b=UHVzElSJAfxeCp8dzTd1dQQdVttzZnAHZQc6qfhX/utOW61ooCuUoRLtaonuCSbJhCjyFeNYRRKijY0gMxKKT4Bgsog8/uluCLaajy/azY1tX442eQ7q6ozjzZcFjttKMEsxsjo8PLVJqVBOlt7Agj9G5LwKecXFFaFEgbjRQvyyKL2RMtIih/5SJ7aW2IYO9kzvxeRMudEM0i4FNqNejGKOQE/5nr7NbaL5v3cHwVRRDtFsMz5iZhexdxeWhuPgTFyZa2oaK8sDjvJntmWG1IrCK2FrWgaulEbkkSHQaHjfYS/kbJSwQ3TyCA49qsLe5a1Qkrw8pbNtBuF/YGZ6Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lvt8S8HrSSZckeHF7TmfNayC+LKDz0JEfTu8yM0wUi4=;
 b=nrjNZP14hogceiGwJ2/2oQwjzw+pi71L1PurasSDfdoK4UkMwoCJhpje/8MJEwGgksRUgFl9tekWeoE85TsXJs0LgfC1VaNyfoTMwE5rpu3iiXz9AfmDpwD1xoaKFoMcrvPYoz3ZdzWDnMSS24yRWND1Amqf26pDkxa2LKSWbAQ=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14; Wed, 16 Sep 2020 14:38:59 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 14:38:59 +0000
Subject: Re: [PATCH] drm/amdgpu: unmap register bar on device init failure
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200916143320.1411815-1-alexander.deucher@amd.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <3f6bcc29-cf7d-79f1-7bc7-3366e34c891a@amd.com>
Date: Wed, 16 Sep 2020 10:38:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <20200916143320.1411815-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::13) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.231.243] (165.204.55.251) by
 YT1PR01CA0134.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Wed, 16 Sep 2020 14:38:58 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b488adcb-784f-48d6-3dc5-08d85a4e3f0f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4356385DA28A3BA7EF937A29EA210@DM6PR12MB4356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:339;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GFjXtkERiTmQk9KEsi8wFh1KmteiupvG23+n4ART8RcrQ8Y59lbVwuc+yEj/2cfOAnNanXfj/B/mKdj1/Oq88hBI7tDPSNuZirZ/bihdCrwD8R/3/F3g6/pMdurizvs+r2sLmiStzR4tA1yp+Af9NhZWObiN6wZscJpa+pu+Dhlch0XOwb78ShSx4YOzff/6HUPODyK8SXYRxkeP7j4vL0+qcbrCzk4uJRG2I231yB10VaHojXw1y1Bj4e5eKJq2R6DQzFE7+5grihfPqGXb1HK89JjsRMPfSSJJsxHZjXIvLtWUSHqTxtLJPYsr2FMjG2hcYnOEGui6E3JIALBzqpmCCNpGWyl55WbiXdz/W4aIeIJvdy5ueCBpn/YDvVE9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(66946007)(26005)(8936002)(4326008)(36756003)(6486002)(52116002)(86362001)(956004)(478600001)(2616005)(31696002)(83380400001)(16526019)(2906002)(186003)(66476007)(66556008)(54906003)(316002)(16576012)(53546011)(5660300002)(31686004)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: oLEWdStL6FMZUSTQogjq0LCsUVVb5QyzUEzlTnIoFWbgGqk3VlPn2nsI0/8yeP51hjg01TUtMUVlQSsz74ipwatx9ilm00dB5bZoOKGm3ofGXEDK/Sv1Z5YcLPF0lyxIDXjZbI+HYCRbbMR6dyXc8CrG0kpA0gCRNOGgIg4e3HK6RyRSOgHIlz5WWdwi3LX03FmKMp+zRN5QXx+aPaL18A2Ivlr8bWT94G9MZgCEB3dETaiGP+wm1yPHJ27itxkm6OgR7rx1tdQp2pJmojD2TTJJ29vyI8K7wBn0j+Wb71Q57i4CRizsAEoEZSEq1sqpfsxHAYUt2flk4xXjG3vN69yF+kr0wUg8svKy+PA7nr1RDIqw77gVBn1yPjc761PWVVVDMuWD+emQfiXcHn242V2k27MUIfRFhFBQeY1NUQ+LHavM4O322ePLyptQlC9GscyDNg3xzlcphYX8Nh5CORA8yryjlh+IDHor2ER+YIlz4ecshAa4Ez8GUZ4cf0OITN39QA+iG/kIQh18YLhNwlkyB/juVGrQMi4466vvUA5oXAg73R+s8vru173nzY/cxK1Cxynsq2uoZU9aM5hbksUchNl8ioJ2YQtQmXxPQByphMCAV7amFolbKa7a9QwQYK4vmlM2HInQWrx8H88NDQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b488adcb-784f-48d6-3dc5-08d85a4e3f0f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 14:38:59.1956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNQ5yhQBMWeh9HYYX0ZItGd4BLlgBTs08QfGPQDyqswcctgZvKuije3D+f/pk+pScK8fcSEle9ArpdJ+5kTnhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>,
 dan.carpenter@oracle.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 9/16/20 10:33 AM, Alex Deucher wrote:
> We never unmapped the regiser BAR on failure.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d633e5448476..61ba5eba678a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3209,13 +3209,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	r = amdgpu_device_get_job_timeout_settings(adev);
>   	if (r) {
>   		dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n");
> -		return r;
> +		goto failed_unmap;
>   	}
>   
>   	/* early init functions */
>   	r = amdgpu_device_ip_early_init(adev);
>   	if (r)
> -		return r;
> +		goto failed_unmap;
>   
>   	/* doorbell bar mapping and doorbell index init*/
>   	amdgpu_device_doorbell_init(adev);
> @@ -3421,6 +3421,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	if (boco)
>   		vga_switcheroo_fini_domain_pm_ops(adev->dev);
>   
> +failed_unmap:
> +	iounmap(adev->rmmio);
> +	adev->rmmio = NULL;
> +
>   	return r;
>   }
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
