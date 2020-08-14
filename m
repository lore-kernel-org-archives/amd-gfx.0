Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B838C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 15:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39CC4207DA
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 15:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uWvf7FIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CC4207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E43456EB87;
	Fri, 14 Aug 2020 15:22:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 165D66EB87
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 15:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYon39OyXqIEetWeuKIdmEoIA7X7GVZ4bAeL8MlO9qMiYartbkiKYgadQAtSad95DTxpcosgoOvlJVgs0JbmCmMLt3V0OLQfSD9x6SuP1iDc3ImnCgl/eQcmts8DEmGR8FNcocORAybhALFIP5etU6Z41imnRIXABLN7tsG0B/EeyYa+fODrckL+3vs+NnfL3YKgBbvTejI6Dxl3K2wUeFsrWPTdOvzTi+cVkr/ZPoUuSUZhYFN0UbvlLSjAlB7aDiKO4PMGaXNENvHuYoDsvALgh4XqpvJLnU6xeXWEVEEE90LlVPs36kJtrgts98Ugb97bXlzKB8DXO4oR9y7m3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5+Gm2lzzNser44bJCua49Q6HaJSSdPDzs1FPTvYvE4=;
 b=iacOj36E4I9zY1pVVbbAKZIVf1Z6IgqSDqTjqeN7bZEY8okI7n+J5y/5cYf7fbEvLCFRlpSgsC6U5liR5lOUx9f86yUNDCIDlclZ16EripAtUQNMsxj+ZPjzaZ5mH68yqKvNnmFHVVfWYPUusYDrZocamCa9KyWF7z+C6fFapxZUrkNZWuU/Cg/zZSks/kjZ2qvCK/hkjWBKPNJRathDHHLf7rZsAm+SyyAGuZTIN06E5stKvadqK/k6guHha53bLAEu4Ua+xC7uXQPdRZ5AsklsYnaamNBTM2vPeNlZzZ4nKQsvR2hGKw5zF7P967Pc4LKqQh1CJsUeT9LYhrArJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5+Gm2lzzNser44bJCua49Q6HaJSSdPDzs1FPTvYvE4=;
 b=uWvf7FIekauBvK10RCEHfMuxdQA4PJOl3GoBTErr8xcMfvfU9GQueEcZR6NvL6MVhQWqDDNmB4oafIgkfVpva3olfHSWuzuvcZPC00xylTEznIoKIgspia9t36m0dL/ZwdTUMz6aTKsULc49o9TgK0lDOYJE4WO4l+a6yKmYDgY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Fri, 14 Aug
 2020 15:21:57 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::8c12:dd2f:eae4:7c24]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::8c12:dd2f:eae4:7c24%6]) with mapi id 15.20.3283.015; Fri, 14 Aug 2020
 15:21:57 +0000
Subject: Re: TTM/nouveau conflict in drm-misc-next
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>
References: <55620308-9334-e62e-4c45-01bcf61a82fa@suse.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <c6de22a9-ee6c-333e-c625-1a8c08f66bee@amd.com>
Date: Fri, 14 Aug 2020 17:21:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <55620308-9334-e62e-4c45-01bcf61a82fa@suse.de>
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0037.eurprd04.prod.outlook.com
 (2603:10a6:208:1::14) To BY5PR12MB3764.namprd12.prod.outlook.com
 (2603:10b6:a03:1ac::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR04CA0037.eurprd04.prod.outlook.com (2603:10a6:208:1::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Fri, 14 Aug 2020 15:21:53 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0174d554-002d-4476-6a25-08d84065c817
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2869244CF74F17197303E57B83400@BYAPR12MB2869.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(5660300002)(66946007)(4326008)(66476007)(66556008)(2616005)(6486002)(4744005)(186003)(86362001)(31696002)(2906002)(52116002)(83380400001)(16526019)(8676002)(8936002)(6636002)(316002)(31686004)(110136005)(6666004)(36756003)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0174d554-002d-4476-6a25-08d84065c817
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 15:21:57.3033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YA414n/JvuKf4AkM0FJQjI7Xf+u+HOEakRhFEHaIpjGA7nBey/iHj0mA/JiW7wDG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2869
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Thomas & Alex,

well the TTM and Nouveau changes look good to me, but this completely 
broke amdgpu.

Alex any idea what is going on here?

Regards,
Christian.

Am 12.08.20 um 21:10 schrieb Thomas Zimmermann:
> Hi Christian and Ben,
>
> I backmerged drm-next into drm-misc-next and had a conflict between ttm
> and nouveau. struct ttm_mem_res got renamed to struct ttm_resource. I
> updated nouveau to the new name, test-built, and pushed the result to
> drm-misc-next. If either of you has a minute, you may want to double
> check the merge.
>
> Best regards
> Thomas
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
