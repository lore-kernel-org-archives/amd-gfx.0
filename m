Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD73BFD4F34
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 20:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 706FD10E2E9;
	Tue, 10 Mar 2026 20:23:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r+3WLJHm";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013052.outbound.protection.outlook.com
 [40.107.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B6EA10E2E9
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 20:23:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4CnlEcxsyYjiUTaCh2BO0OYU6C4GnzgqLn78ru3H7uVeGIF9e6irldZ+nn1KFRIM89JXJmkYrW8lsv1irAHV3LqwEFyCESAfx0VEHPrjT3/AQl7YDVxljoWhZVOLf9+JDJAw87mHLzj9Ch7GZIQdQOvwEfeSX3Va+xYNj+nxNvWdw30n5+zjoB9Vu9XzY4hUe5BNG/7dlX5CWYvF3o4C/BNKWnrXj1yevWt6upt1AdhF9cvexCKUp7Q6WPX3gu+XnGfhrrTdwMdzALPbgzLawFS71EPkJ/jnM3CqIvDRrVcygTRMc3TV1IYNd5r4Z99GwUvxUhvGWtO9bejMge8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLuJVqClhKUgysyXeeYareBbQZgaln1ZhDY+fAw3+/o=;
 b=yNtBzfiZQjRM4IHdX72d5TEWzcoB627K7HPMotm4PGOyl5FPZPZTk94pQUB27AeH4OHDvaZ9YEH93MkDMoWrlDf7kKwbtIW9RgeKORNH//hsRNXvsf/fjjdKyBFT9+ed9EotW+rjB1k/lfGJZhOlRQu3aLkqHEb8giK/tGThL/inPTYMPn78fHrqwdTWtBrlcDjVGLoJL0ruv67tCLTpqEB71VIwp2LQrfxwHdliuLzBCRwjVK9+Oy1sBkglK7+vy1jhJo5ViyF9RUvdvyQtKnQX+x56xVY+Uwko5VhxgBT41NQzoj6oCJ51BhHo1xQGCsuhDb37EsQrmofTnuz08g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=m1k.cloud smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLuJVqClhKUgysyXeeYareBbQZgaln1ZhDY+fAw3+/o=;
 b=r+3WLJHmhAhKfCDXIGdT098c9EyjP/tOp3/5f2SM9E6p/hdsxW/wlGq/BXgxCaYEZZ7zIHX1x3vwGDh2A6K2V05DzTHBIEO2znQa68fSLTzQqYDZWWya1mkeXuGY6Fi8c2hIZPvRcW674TfdPepAykdvaMWRRhF1fiXjugObryg=
Received: from BL1PR13CA0323.namprd13.prod.outlook.com (2603:10b6:208:2c1::28)
 by BL1PR12MB5777.namprd12.prod.outlook.com (2603:10b6:208:390::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 20:23:51 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::fb) by BL1PR13CA0323.outlook.office365.com
 (2603:10b6:208:2c1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Tue,
 10 Mar 2026 20:23:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 20:23:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 15:23:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 15:23:50 -0500
Received: from [10.254.95.179] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 15:23:50 -0500
Message-ID: <d3a0d7ee-0573-4aab-b03a-39d30089b2aa@amd.com>
Date: Tue, 10 Mar 2026 16:23:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Save cursor-only vblank event seperately
 from pflips
To: Michele Palazzi <sysdadmin@m1k.cloud>, <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <superm1@kernel.org>,
 <michel.daenzer@mailbox.org>
References: <20260305222131.160914-1-sunpeng.li@amd.com>
 <a1e5c22c-20b9-4802-8246-cd93029c5e5b@m1k.cloud>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <a1e5c22c-20b9-4802-8246-cd93029c5e5b@m1k.cloud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|BL1PR12MB5777:EE_
X-MS-Office365-Filtering-Correlation-Id: 81fb798a-7b7e-4d99-bd1e-08de7ee2f18b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|36860700016|82310400026|376014|13003099007|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 9eqmc9Nj5QDO84bDcVULkyZeuQvQhotDENfOUDqFOmeacKODwG/wJYpNWXpmkyJZVKCDz+0S9bHvLz3NCDNA7n3j7VOwFAKMPx14e7z3/LsoGlufJhTU4nYsa8QAlcKLBo/r1wz57kWD1U3ZIU81O94iCBR+MAhYHa4ItBLDc0GG3P2sGkT9Jkc2Qnsafihyuj6o5CCqFMSBsk6vUIPl0GWJCapmfnqrfwEIx/wvfdacH/dFeQ6g5a9dL6nKn97KpOU7rvyebNz9CbURNSiJ5Mq7iHxzKeCGitSK1xj5ybpor4/RLeaqLKkvr3U8aOcGU6T/AfCiiYFiOLZIkRwuyBnqbW5BCC1/XsFDaeJPLwV3P3TlPByDDHL7J1eZaHoLZ1BJOfFxrF/daTdUXgOe49I6lsWCwBCxI9w0xHjoY88oF6gcFq7/Rk4AdpcEjXHHrqp9QLAqAxfuo2uho2+QI02qB0CFqaxAEp7dU94HiB0X+RMJDgvzTgM5tOi98JZOaaxs/X+jB1bUhn61C4WjfwoK4tCCO0am3XAP665VfE7s9fQCYYRKoKQ62lIAEipF/R0EAdCXoiwoI4s4gyq+f5DTbh/ovJ8LJGdamvw/WcGKigLv+8PsWXAwlHPE0gPAAmc1FZll/qg5KGRlgu7seLUX6/Da8eMqCvr4QBKLN69mso8AFgIfUmuMZnQPhVX/zUQnT1LsnsBWEM56rtOJzJAau8BdZq1O+mEXyLqyYN4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(36860700016)(82310400026)(376014)(13003099007)(7053199007)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xr0y1QeAfeKTbL6iWHxzTXl0AcXvDDeHues0H6sFya40CIn2ApR8U1M/9907rVUGlsEV+61MDPL7ugsZgtUt3q1bv1F+i++gA5/h98rDGiDPcYFqi7uZs0SolbGKIJnRGm/XZIyTUz8uGTv0RO9hzZW1Re8Uviegzfl4XthlVOdrvFQouhxN9ggNGt5+URB/DSvMeK36s+yl69dffT/rYdphHa6yt+zIP+FljSzNQWeb6mwGuCpDENlXPk9f6C54qAz6oL4mUUOoZyF9Jt1jauoG0RFIHVM5F1xefH+p7JqlWa435UxPJnBRRe0pgPZDslECVlJTHxccr08Ei0gGcCF551KiPSw2Jf+hYYu20VJHpjjet+M+jCGtZXi50dB4gpdmea2RavXaoEvPxB+22M+iI1bc1+6IxRaycZuKyX/itX5ycy9vXplGOvtE67Rd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 20:23:51.2936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81fb798a-7b7e-4d99-bd1e-08de7ee2f18b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5777
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



On 2026-03-10 12:19, Michele Palazzi wrote:
> On 3/5/26 23:21, sunpeng.li@amd.com wrote:
>> From: Leo Li <sunpeng.li@amd.com>
>>
>> [Why]
>>
>> It's suspected that there's a race condition where cursor-only updates
>> can race with page-flip updates when updating the amdgpu_crtc->event,
>> which is used to track the pending vblank event until it's send by the
>> interrupt handler.
>>
>> Theoretically, DRM should prevent concurrent updates on the same CRTC.
>> But evidently, according to findings[1] on a previous attemp to fix
>> this, there is a race.
>>
>> [How]
>>
>> Save pending vblank events from cursor-only updates seperately in
>> amdgpu_crtc->cursor_event. Since cursor updates won't arm the pflip_irq
>> to fire, we'll send it in crtc/vupdate_irq handlers.
>>
>> [1] https://lore.kernel.org/amd-gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/
>>
> 
> fyi i am testing this patch, looking good so far but i'd give it another 24 hours to be sure

There a report that this patch doesn't help on the original gitlab issue:
https://gitlab.freedesktop.org/drm/amd/-/issues/3787#note_3366574

I'm suspecting the issue isn't at the arming side, but something is preventing
delivery at the interrupt handlers.

I'll reply to the thread with your first patch with some things to try, after I
mull on it a little more.

- Leo
