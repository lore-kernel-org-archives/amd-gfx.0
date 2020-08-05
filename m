Return-Path: <SRS0=KaZi=BP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B11C433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 09:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ECED22B40
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 09:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BSBmR2q/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECED22B40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41DC36E094;
	Wed,  5 Aug 2020 09:23:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B12F56E094
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2020 09:23:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJD7rrf0nZgnyTomgsqKVwVPGKmsMnolo5Oi1SW2Jf28L1NKsnnAltOvTHb/1+9eJIxTvUaXVy8e64WNtahQVbcyqUCPyerNnBgK/cl5ihqsUiRcEUhHdJt8IFKXjdZtUzOeAiTOjL47yBjgCRHuzThzwolsJHBhpT/+/fwOpqmmxAizcjbg7zvZWtjbuCKKQYOHRoBi7DmNqq68ErbPzwqXYbtY0ZNo3gkY1Wi8/klqC+ZQ9VOSXiMtfQSSTGC8++ajNObu0GM1kiTz6FlSPW73bLGlDBzWcfYXlGTy/QU9BNujGml+awaQ6tbXA8IKI+ZLq9ULVvksBylCpubfHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vldeLWY2BBQfGn7oPbo57g+pb2X17Rj0Dg7WsYluc8o=;
 b=bOXNqgvIM9bnTIemaDAztrkSIwB6XAM7Itq5UPHF9a91olas84MovWCZs2DWtI7fwWHY1IXjkRnEBs3Fvidtbl9ldDEOsbx366xSSxUyneNj2hoh4QhnBHgbvInFDEAPbHRYqm2/zB58EYJ6hORYN7/T4IAqWfazGhbGeohJGO2OhNfugaKH4VwxWvYt/3v0SU4M35D1BaFcsvvEzmktjxmG+9fSQd2YwAjmfgmzLCM6shdrYeDugp3HDL+VlW1wNipjMvtzKIzt901nVR1S16zDhRFulPVJDmz6TiGfkMpHsIDZ37/MxBeM9FdCgkQuVli52pzbJgWlFRHtZx2ZBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vldeLWY2BBQfGn7oPbo57g+pb2X17Rj0Dg7WsYluc8o=;
 b=BSBmR2q/SvTZh1UnRwMgIVYmH/l+s5QKGRkp4yKJjX62wSf+97nPQjjRAv3BcGtZwIQ6Hja/UlixnHKUUUbhAqHaHKsQfg7DKY95c/MSacLQePodI0edaIyAsYPwq/zIeJLXkpn/16chRCHGZ+HEAiwYiQK6uJMdZFg7B6tfqxY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Wed, 5 Aug
 2020 09:23:19 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e14d:37fb:a0ca:aa81]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e14d:37fb:a0ca:aa81%7]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 09:23:19 +0000
Subject: Re: [PATCH] drm/amdgpu: unlock mutex on error
To: amd-gfx@lists.freedesktop.org
References: <20200805084146.25788-1-Dennis.Li@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <5444aac4-5579-fc42-a899-9cd005741655@amd.com>
Date: Wed, 5 Aug 2020 11:26:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200805084146.25788-1-Dennis.Li@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR17CA0040.namprd17.prod.outlook.com
 (2603:10b6:405:75::29) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.1.246] (165.204.84.11) by
 BN6PR17CA0040.namprd17.prod.outlook.com (2603:10b6:405:75::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.16 via Frontend Transport; Wed, 5 Aug 2020 09:23:18 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5a181039-5b4b-4204-acb1-08d83921311d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4204:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4204BA23871F8D46461332C98B4B0@DM6PR12MB4204.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gepanbBKumpK94iUkdvrlrngT4XBJkcKR/m8GPVujTSEJQH9B6YJcsO8+1hKi0KzwNf5cnv2Y6vl5nlhaXwupFQyRm81LR/pryNRr/0SwxDAVL2Zeda1mxVrMayscGQf8iY1H2nxg5RMhMaKKNI65uFaj9xU6pEOhVsadW+vHLDV9HvTu0ir2FbvEHicj8CqiqiOU5acwH5TA6svw+dywwzxggUqGfx4BkLsrzdyn54CjICJzGlTu5V0a3jwrv70YQNqsxFOGhM3i4wo1d+4tyQIUPGvGe+X151o+D9wUJ4sFWn/MD8hvnVfkmoIKMokm3F7dLEDgKFAS7inmnOSs2GAxT8Xbc1Kyr/eG47utRGQhadRqXZauyhovIqh2Cy9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(36756003)(186003)(53546011)(26005)(16576012)(8936002)(8676002)(31696002)(52116002)(16526019)(316002)(478600001)(5660300002)(2906002)(6916009)(83380400001)(6486002)(66556008)(66946007)(956004)(2616005)(6666004)(66476007)(31686004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: VCZsQuFBbr5rJYSIA4t6ikS2m/VT7WlF2olM2q68/ZTUPJXZnqY96JYo3J48HbILl5ZCEhtPqT69w9jriyfyKzPL2nwd3qmPoC5dz9Pj8XdOHHfzNwjpx123FJ5IZk5zmDDpkBlJyenGrxYKKwH0S3s9DbHZxi61N9naLN0vwHMSN4s8jOFPHZoMVW5DPYdINVGaDKe7bZ7LJ15kK1ETx3wYI+v7KAENQa4rIox528T3tOHRLF4nEoyld/PuZKb1+UTEzlFXmDuyJbhrMBi+zpOSx9bdk4iohlPCJ7+i+1qy1ZX89kL5Tqp6YZwjgvA3aFxnojlHp4IEm1ROkcMggrh84H2Dh97xJzCPVEGRsDGgwzze0n6CdTQoGCcZ5PJI+SDlu+yxyqLRklGFtX4m3xwM+CBGerg2razMaVGB4hD6Kk5zQOy97TM2uaTiHNtWWRW/WVoMCl74VVyPmJPbccj8wJj9XsZshxLEI/fQOePH9ocJv+T7tjhZToY4nav5A1o7Ys2IFQu8Y48jtpJ1x0v+gvLu7QFIZh6DvvnERpsASUg0KT1waTnyRG4VBhCE1ZGjnVmCT5PEgUirxs7grO/+DjLWB6csnjWtoD+ztEbuzLvekzQZo18KobAIgeR9IKIe/6Q7QxHaoqwTv8dM1g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a181039-5b4b-4204-acb1-08d83921311d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 09:23:19.4936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQ50dxctI5XWs06gz4VWVmy9wkmO0qT/TIqKyOqDmKDjf5S+Pu6GKeUY34oif6Wb620PIpbYC7sfgHdJMQynBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204
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

Please remove change-Id before pushing.

Acked-by: Nirmoy Das <nirmoy.das@amd.com>


On 8/5/20 10:41 AM, Dennis Li wrote:
> Make sure unlock the mutex when error happen
>
> Signed-off-by: Dennis Li <Dennis.Li@amd.com>
> Change-Id: I6c36a193df5fe70516282d8136b4eadf32d20915
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index a0ea663ecdbc..5e5369abc6fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -632,13 +632,14 @@ int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
>   	}
>   
>   	ret = amdgpu_ib_schedule(ring, 1, ib, job, &f);
> +
> +	up_read(&adev->reset_sem);
> +
>   	if (ret) {
>   		DRM_ERROR("amdgpu: failed to schedule IB.\n");
>   		goto err_ib_sched;
>   	}
>   
> -	up_read(&adev->reset_sem);
> -
>   	ret = dma_fence_wait(f, false);
>   
>   err_ib_sched:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 4e017f379eb6..67a756f4337b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -545,7 +545,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>   			}
>   			ret = amdgpu_xgmi_update_topology(hive, tmp_adev);
>   			if (ret)
> -				goto exit;
> +				goto exit_unlock;
>   		}
>   
>   		/* get latest topology info for each device from psp */
> @@ -558,7 +558,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>   					tmp_adev->gmc.xgmi.node_id,
>   					tmp_adev->gmc.xgmi.hive_id, ret);
>   				/* To do : continue with some node failed or disable the whole hive */
> -				goto exit;
> +				goto exit_unlock;
>   			}
>   		}
>   	}
> @@ -566,7 +566,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>   	if (!ret)
>   		ret = amdgpu_xgmi_sysfs_add_dev_info(adev, hive);
>   
> -
> +exit_unlock:
>   	mutex_unlock(&hive->hive_lock);
>   exit:
>   	if (!ret)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
