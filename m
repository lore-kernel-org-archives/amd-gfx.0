Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34499C433E2
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 22:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07B4208CA
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 22:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YZY8a/Zq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07B4208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 575316E252;
	Thu, 10 Sep 2020 22:44:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCA966E252
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 22:44:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+bntmxCBWJxXasefmZK2zYqnfjMBIj+xxwTXLWKDSfWpO4EdRQXOnZ9eGR+fBIPGc+X4+TfqprZcE82/79eh7pMoJ3pdBcYo4y0ZfwL+43HycG9Dt9XnYSIiKDlricQZ5HTZ2WTkCk8mWQLaYXpeJ3F0BbPypuob5aVj8kqd2g+iWj8umrNT4x5oLDNiYDdZyvJpAk+GIO7AGzi7W9yBPFoFj3zpjr6Ct/pLsRcvMk83MmkIvGgUqCCJaXL/Hrz0efgxxhMW1rRT6KLW6HOJc4Mz+S9tbN/72BYhCGH2ZRkrqNJBRb/K207QAosqBiQAYQHjwjT3aPMvsmYKk+73g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Gy4NTGaoRex67GUPHf3Saw1PdJIhEug2wxy9nndX/o=;
 b=dbxmuCbRufp5mTj1IXCEZaLtGSK1QfVu0pmsnM1lg9xKz5sOnMFU75FMBgwRsDMUYWvsOuJsDyUgyujydj9S7vXuoLaB/ZBkLkX89O3nBr3MEZAqKFcaZ/42krOu5CYk9kgI3FD+soZgdOEKhFDTHAZ0bzHIaqoWLPF8O95t4tmQN2H6n+cn8xk0PpnZaXBh/qrXc1kxcfcM/6mPdvXV6IHYsD3eCF3MOL9oJlvRb5P6+hPxpm8lixW+JBLsSAIiBwQVI39c6+kcm6p/Y2Bb4bFjsysI0IWoY6HKUVomg5BWmRJffNxtK+nDZ2zSW30KUIyduNwQAvfvE6zYi4dGHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Gy4NTGaoRex67GUPHf3Saw1PdJIhEug2wxy9nndX/o=;
 b=YZY8a/Zq1rZq5cr3+VHMqV0D26vMvhbEWHMGa4G6U93MJhQ7y5FQtfc97o91wHhcCHa8GKuyQO66LhhyFIqV9gEYiY4OktUxH+przFcgBxeZwHlxN0aFD+G4MkL4KZb5iEUK+du2ldz+jXbA/nhZs3qXVExjYz4H/zm2DcqW74M=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2541.namprd12.prod.outlook.com (2603:10b6:802:24::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Thu, 10 Sep
 2020 22:44:00 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 22:44:00 +0000
Subject: Re: [PATCH 3/3] drm/amdkfd: Reduce eviction/restore message levels
To: Philip Cox <Philip.Cox@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200910185429.14011-1-Philip.Cox@amd.com>
 <20200910185429.14011-3-Philip.Cox@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <63c4c911-7a73-fcc4-4947-147cd40b859a@amd.com>
Date: Thu, 10 Sep 2020 18:43:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200910185429.14011-3-Philip.Cox@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::34) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YTXPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 10 Sep 2020 22:43:59 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a34ba0b-56f1-456e-0245-08d855db0292
X-MS-TrafficTypeDiagnostic: SN1PR12MB2541:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB254136697F37989D25B8703392270@SN1PR12MB2541.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SgunoIAX7PyAenfgrn+3R7iApjSOSyYVBLuqyAwo+6qOS7GNt9x2vdac2V+olB/yCwaEu3pJkkpXx9zVKTPflELHV8RPCFXZGtVKErCvUouACXXGtFQDi8vQzgfJrS+x669YlgoKrfpYqFfsN6szdFPPrIOpFBVYqFa2/DjoJnvD4QJiKc2B9Ld8mTp+ZL2q/qNC2klLnADvaqZvZLqhoHeEG3G553AB7luBRGCcGxh9HMcrnBLOr6bq2v/Ns6R0v8tgfQjiozXmw9HQHD+L56ghQCkF8rDigI3LLxnPXIiOzcdVPtAFN2v5Fqmnn+Q0VnE19ZRo6GSySPlQNeEjNzqJ9GMpuzvtjSAh/CrZBgm5dlXcSZPiAepwWbanVdqx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(16576012)(2906002)(8676002)(83380400001)(16526019)(66556008)(2616005)(186003)(31686004)(52116002)(44832011)(956004)(6486002)(15650500001)(66946007)(66476007)(478600001)(316002)(86362001)(31696002)(5660300002)(26005)(4326008)(36756003)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: C/eY0BJb//U4i/jvZlSEDR4jg5D0FDAWJtF8fMj3pGrUPjORMSlFDXHX3md8CKDAc9Nozw7cFyC4+C8MEwXDl2/pqEXEGe56i+0Bkeu7Bsynf1oOzI1aT8xVRR/NkPT8Cn3OcUdsi0uel7iIie73x69/g6zdxajJi0XXuSwxu1dsLI2U1a8usqzS0J9gBcH/VYknqZBFjdhHnP0XJLYN9IejEa8uAY81eglKMdgIR0xgIWIvHB1sqdnjfNtGT7XTzkThooTN89DTntlBr9FACWWKc5wYu1NcidbXi6SnLjxF1z4Fne7fsHL4ThRTqEb5px+Md4F3M6KfXUZq/fPM3mX5FxqxaJrXlXeKQIVkLErjbubnjath0aKqbc8WREYyeQbuSTum5DMIcwh96mnXp081V7Mz2+XGbjZrNYZqbylO9t6FY5hq31mCZPnq4/c5cBlpPvhS1JeUQ07f1NXENwLXX2y3M2O8GsaNX/JbLeQ0rdtUmYiUaJ2LDit76tAJJ91AMQnnmVxXl9HoDLSx6silHgKYOsdkyyEJJLUNR0eYQfmrSKhnqEbCNdJWxj+DpcutKImZTz93X5UakaZuY9OWvDHBbwrjjQsBQ3AdBxpff1BsE8B2E1rj1dvQh9m+Bbt+1lXiDSyLo1XqwwS0Jw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a34ba0b-56f1-456e-0245-08d855db0292
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 22:44:00.4446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6w4dswhgmNYHAJVGzIAGPtaZtpUXDMNbC66tDgYFJIk2HaVIpBgXX4i3GmJqCuU0UXZGfKM+CxCDcpw7tdPRjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2541
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
Cc: Tony.Tye@amd.com, Laurent.Morichetti@amd.com, Jonathan.Kim@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2020-09-10 um 2:54 p.m. schrieb Philip Cox:
> Reduce the eviction and restore messages from INFO level to DEBUG level.
>
> Signed-off-by: Philip Cox <Philip.Cox@amd.com>

This patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index cafbc3aa980a..0d2bb20b49b7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -650,7 +650,7 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>  		goto out;
>  
>  	pdd = qpd_to_pdd(qpd);
> -	pr_info_ratelimited("Evicting PASID 0x%x queues\n",
> +	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
>  			    pdd->process->pasid);
>  
>  	/* Mark all queues as evicted. Deactivate all active queues on
> @@ -700,7 +700,7 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>  		goto out;
>  
>  	pdd = qpd_to_pdd(qpd);
> -	pr_info_ratelimited("Evicting PASID 0x%x queues\n",
> +	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
>  			    pdd->process->pasid);
>  
>  	/* Mark all queues as evicted. Deactivate all active queues on
> @@ -746,7 +746,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
>  		goto out;
>  	}
>  
> -	pr_info_ratelimited("Restoring PASID 0x%x queues\n",
> +	pr_debug_ratelimited("Restoring PASID 0x%x queues\n",
>  			    pdd->process->pasid);
>  
>  	/* Update PD Base in QPD */
> @@ -826,7 +826,7 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
>  		goto out;
>  	}
>  
> -	pr_info_ratelimited("Restoring PASID 0x%x queues\n",
> +	pr_debug_ratelimited("Restoring PASID 0x%x queues\n",
>  			    pdd->process->pasid);
>  
>  	/* Update PD Base in QPD */
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
