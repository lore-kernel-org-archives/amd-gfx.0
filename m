Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1596FC3F2C0
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 21:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A43624690
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 21:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fsaZgBxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A43624690
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3796E6ED5F;
	Thu, 27 Feb 2020 21:39:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5273C6ED5F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 21:39:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XV9hE5blTm0l1M+X2xccfb6DISFtHsGBy8niuNmcnVgNa+THaaY6CxIK9Hv0Y74NILm1vfujCBHYwHutmwRViAlVgdBwLs5NFh5VkorDo767DfDXL5Rna/jUvcKWBz4FAQU6Jo5lOf8G2kTzKP+XNnZGUmqvBQ4mYKVmkiKzW3dscUFQSOf/tplQs3trCk2uKsQjxlmDPoMmmnUF9zrzZ3FZCBZlcReO562iCxAKBUbjtP7jAHvxLYwPlZXN0dA7erdnIIsCRjD8bYsGoWkCuVbDyucyFTwtqh2PeFiYRmCeuCu7g9iPoQZZuN0AI8tbl3rxzUsirXWGvCNHHR6e1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+jYSQgkwrV8lFC1p/Hg8wea7nOSx85fCkdSzqRlSok=;
 b=enKatY5Y0xzdE/0uJ4smtWhyvcnK/TnqeRX2lou9qVSPNi+FiD3u23/tys05Bjo5P08FNWMAsKoTe0/6xznn8nNdWJU0ZpGeQI7Nq1MnGUE2lfH2iRFWbV/7fs6oky9VJtdYKIjdFQs8XvfuidmDUJpnxR2VJxjM3JnMokGhTAylT8z6UG104sZB8XMr1uHMw8YsncUi10jDorTLFaxSjaj06e0y6MAuqtHesaN7p/4VVsodTW7ocWUV325mnaFByxX76mqjja4OErO4azMBsE8YAhYVSAQE30XTKgpBViP4aKnR9ur3zgQxT2e7Zj1dQwm4Wv2wkd8nJyTk6hOyqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+jYSQgkwrV8lFC1p/Hg8wea7nOSx85fCkdSzqRlSok=;
 b=fsaZgBxvvu8Gu/2YdG5AAFUGdkyqBvTybATTCOiaYiC52Ft1uzc33hlYLlEIk59urvi70SeNuOdKdPFEGu9L3Erg5Hwixq0MjJDh2Wp1Fcg4AQKoE+qocBB+uyRidViMjAItJQZTjGjOSJYHyFB3pwA+lV2FNHoPnrgjo/YNOs0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1657.namprd12.prod.outlook.com (2603:10b6:4:d::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Thu, 27 Feb 2020 21:39:48 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 21:39:48 +0000
Subject: Re: [RFC PATCH 1/4] drm/amdgpu: set compute queue priority at mqd_init
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200227214012.3383-1-nirmoy.das@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <c076c65e-cd7b-2cda-44b5-70a54d039ddf@amd.com>
Date: Thu, 27 Feb 2020 22:42:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200227214012.3383-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2a:b800:8c:b0f3:cb6e:896b]
 (2003:c5:8f2a:b800:8c:b0f3:cb6e:896b) by
 FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 21:39:47 +0000
X-Originating-IP: [2003:c5:8f2a:b800:8c:b0f3:cb6e:896b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6a74f414-9446-482b-0a18-08d7bbcd91b5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1657:|DM5PR12MB1657:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB16577D779B0CF488E8F6800F8BEB0@DM5PR12MB1657.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(199004)(189003)(5660300002)(316002)(52116002)(8936002)(53546011)(31686004)(478600001)(4744005)(4326008)(186003)(6666004)(2906002)(66946007)(81166006)(8676002)(81156014)(6486002)(2616005)(66476007)(66556008)(16526019)(31696002)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1657;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XH/b0954TjyMIl7dlBpuxqH9dPMoyNAf8oIiRhqHgOPH+kNuovOffiwtZy2vMNJ2hZsQa5ZEOSAS/qMpqGODRxykpKhGEaQjUaOJExyPPnWSG4nQNy1VeijlwikcQMINFqSYrnzg9+pLIM8dBC6fLf6ioip1/rZeOgBSG/H7Hw7HbVWxPrwtpGKqtyAXFwBEWk0Po9Uf2f2ldyYOoR72a6S2Jjz+p3oSZUz1tLtfD1Z5Cn1DAL8uQU0Rl2EHUZu75nVDXw1P7Ah/bC2T1gS0mWEdTwf3Y+CXfinbY02vVCE/6l4dRllqynd6gf04YNh58PQT6zwgmp3/bvOegNAh2viW/tk0gcv5QvCGBJ44GHs0CjxxMlYBVWujX06TBppMgndJONvXRvKkJSGjFRkef77hrRIeoL9zrJYQQqvR43L69nDbLhsY00Fu1q3PvAD8
X-MS-Exchange-AntiSpam-MessageData: Czbkg3w75QIer/M/Fg92GQeiHb2yeVAMPdn7IuRIpSGN4mXhe1ehmsDacHce3+DB4Ex+QjQzyTXjkNpN/Fb27gbH2YH5TJdEyXIFd7NUkhbShaW8w542LhnARIy3XWndWnxVt8/WqEYxT5g5NA0cj30N/LMu3io414vlIAv7CRoP7+58fDlGsUwOiWAAkHZlAqPZL3WTuN/Sy31B0IT7+Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a74f414-9446-482b-0a18-08d7bbcd91b5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 21:39:48.6593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPkPdSAuJpJnpmqaB7oJI+7UDyuVYJhPQx967QvHbPAgaB37x9M9z29y4Ox7FVmyCAi1QQbBWBDvOX3TMms7UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1657
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2/27/20 10:40 PM, Nirmoy Das wrote:
> We were changing compute ring priority while rings were being used
> before every job submission which is not recommended. This patch
> sets compute queue priority at mqd initialization for gfx8 and gfx9.
>
> Policy: Enable high priority compute queues only if gpu has >1 MEC, if
> so PIPE0 and PIPE1 will be in high priority.
s/PIPE0 and PIPE1 will be in high priority/ 1st queue of each pipe will 
set to high priority
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
