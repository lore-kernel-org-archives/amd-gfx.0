Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF311C2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 09:35:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C368A2467E
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 09:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KyYyHrIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C368A2467E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 590DD6F451;
	Wed, 22 Jan 2020 09:35:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6C226F44F
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 09:35:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEtCA0LKyN59ZBcGvnaI3xW84+Ac86xVtwU0hs969yLr0cmU+B9Bg3iDFXPshfZjhrQVxvIzngT6H9ppLxWXM4/MI15dJpFA7hJJt0WRwzdmPYOHN1FAPpNU3IZtTf2pq6cJZ84rJsn8EixEYzMP4jAuyphRF1GlRdLBkzzyhhgaVgbQaXFT3Wv36FfgyyWA8nVkmP5qf9NsZNy1YLJsM0z7PjtePSKkak/6wygT6go+tA3mQKtya4hP2hteRLsDCsLXYNiD9bvw6rE/JZT3gyir8r6qyiGxNg3r41dXKXaixtsV7dribulHOvwfAVnELb/HP6vegfTDpQ3p7UKSVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAWUqpFsR4t3zkXcQdLEv79hd0dwQCN6SVgzyDaA0Hg=;
 b=OAbTd0metSyZ8UB9WvNnT5WN2coJiVEhhOThK0V+L/wUuc2AzUpUWl5Y6w+UmluHa6gvYvJ2oVq6j1YT3Mi5JHS+++aSKMMedxRkeBPnunJr1kKYaDOP7H+VGCQLoUo4EevJYksVRYs5J5Rwi6QwZcK2LS1UA60M9sGzDd2z14DsNyxb9m+amEFPk1F1oXXV1FX2JohhbEpuQZknsvGRhzW0kDIhgbxUascwhZjHNPszc4tsehpAEPtExwTrdgaG5WKlqFcQYjgvlkXzxUAVg+neC84f3nKHzBcvJbTpPSBVEvPGytqTZr9OvUZf9wpJvjgcdigLZH40DiKNNgkirA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAWUqpFsR4t3zkXcQdLEv79hd0dwQCN6SVgzyDaA0Hg=;
 b=KyYyHrIBDn221CkhgMt3xYKZo5hlVXxaZKUEBEVGYc1kq/r2m8V4tiWTKlkSFcPcvBYGiYkmr6F3J/JHwSrJ7NcbgzTIACjl3R/RgUH72BiEDPnLTiSS9WRmxhd2LoNqrVFl3AkdyRwe02NQIBQKCQdEcfcerhWuebvqJuRKVNA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (52.132.143.139) by
 DM5PR12MB2485.namprd12.prod.outlook.com (52.132.208.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Wed, 22 Jan 2020 09:35:00 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::c06c:24da:d4c5:5ee3%6]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 09:35:00 +0000
Subject: Re: [PATCH] drm/amdgpu: fix doc by clarifying sched_list definition
To: amd-gfx@lists.freedesktop.org
References: <20200120163536.28801-1-nirmoy.das@amd.com>
 <MW2PR02MB3788CAEA2492642D36403656C80D0@MW2PR02MB3788.namprd02.prod.outlook.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <5260f25e-1f4b-077f-9291-622e0e83b1f2@amd.com>
Date: Wed, 22 Jan 2020 10:36:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
In-Reply-To: <MW2PR02MB3788CAEA2492642D36403656C80D0@MW2PR02MB3788.namprd02.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0037.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::6) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f29:5700:a0f:1fdb:bc5b:14d8]
 (2003:c5:8f29:5700:a0f:1fdb:bc5b:14d8) by
 ZR0P278CA0037.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18 via Frontend Transport; Wed, 22 Jan 2020 09:34:44 +0000
X-Originating-IP: [2003:c5:8f29:5700:a0f:1fdb:bc5b:14d8]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0e6f4df5-4e65-4996-ac46-08d79f1e59a2
X-MS-TrafficTypeDiagnostic: DM5PR12MB2485:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24851A09746373261BFD5F0E8B0C0@DM5PR12MB2485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 029097202E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(199004)(189003)(8936002)(81166006)(81156014)(5660300002)(2906002)(6916009)(31696002)(36756003)(8676002)(2616005)(31686004)(45080400002)(66946007)(66476007)(66556008)(316002)(6486002)(966005)(6666004)(478600001)(4744005)(52116002)(186003)(16526019)(53546011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2485;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pO9182ZPpkxkldQemlneU6XzQ9MEZb0n9BDjyrcvZZIp2vxXqn2xRXZhhl3nhE9q81ApHOuStJ0Cm636A6ROFNF0MQiORdWoJIiKwcAU+u9PJfeOpz0RK6AIoi02oVMrFHJ5cEPq5pJjpO0qqF4N2jd+qApKxxQvR/Y7gg81kNZRCFt/nvJbE0FSFF0D7fRzuquQ15TJTFF6IYgiN7a74C3VqUVBguK6VunN/rbU0yRxU3fwv2VHVBtqBqeqjqRIWHy59reW7iALr3WKztm2eq4mrbT/rRf2Zxw/5rjrc9GxzEZn9zsV1sinF/cXUmgOKglgl5EfIq3OHg5AKlz01VJeu0B5SQ/hFgWhHUZNcnnGiXlz1eS+QH/yzGGDVUPCQ43pPHiIvkekRqhoehOagvT/Gv7+P61D7OsbvjHRS3nVXk2DCNpd/Tvu6qMUpnEtRhJF+MyM0cNcKLKJ1erZ6CddNIBu0qkH0xsqrdG2+PU=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6f4df5-4e65-4996-ac46-08d79f1e59a2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 09:35:00.4579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJqO/p2Rplj/gUnIZoDjSUmkZYwTUFm7Mm1jEh43wfdtzsIfMFKccddpzuBIc0Jhw0BxMtCjhUdsrAZanGBk9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2485
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


On 1/21/20 3:31 PM, William Lewis wrote:
>
>> + * @sched_list: A list of schedulers (drm_gpu_schedulers).
>> + *              Jobs from this entity, can be scheduled on any scheduler
> There's no reason to separate the subject from the verb here with a comma.
Thanks William.
>
>> + *              on this list.
>>     * @num_sched_list: number of drm_gpu_schedulers in the sched_list.
>>     * @rq_lock: lock to modify the runqueue to which this entity belongs.
>>     * @job_queue: the list of jobs of this entity.
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cnirmoy.das%40amd.com%7C24185c9d87dd43ce38b008d79e7eaef1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637152139396188784&amp;sdata=VT66q3X3Std9v11mnTJ9ww6FJODJWoo6IGu8iVFevGs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
