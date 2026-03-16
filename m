Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B376F53D81
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 18:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C82710E436;
	Mon, 16 Mar 2026 18:48:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X0EVKJ7t";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8A6210E436
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 18:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLSKkscjrCpow188/qune2kHJVmiczU9g54ywwt9lhSSIxwqyOlcisAb2QQFgOfhLVrRNMLU0IKkEw4ltpRBBRz856GHHBo5bz5ghpOHcB0CFYxSnfWx25KD4C2+zsU4Yw6p7AHrqer0/WzaksQSwYaEvoPNhv6upr/bMprAx9Hyo3SYyXjGCVJNH1PrMEObFTQNy5WjoFMThzXp3NJTytl+3HLoq23HnZCby3yG5EbhNwpKCVGEmvoM4CY+oPSrWRF4NtRePKXtz4kl5hJ3zRjlN3sdgnSuZmvkv3+m8b2JS8N6ZyZ/msbbAfTmENjW86GEdCBGhGD31bq/mcxFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVFDgdi8F3D+TXCXSO6k1KqP/s1YPrAzEURqHmruasE=;
 b=M0tASBKAmEE8O2LmevOTGmJ7wyCfzB8OwcuysgTvJQ9OLtARZ9kqsMsTnin6JXqqbeTzuS1ukfWLZWbW0R59BH00sddRFZtpoJzOV7/qaycWFTpU3AeF5r1cJfUdXPzIbfBnIAFYWKR6uHXTT+/qz8Hg4WalHBG8cZKlygqNDDB3tey2J3JfHzndOl1J+IgkEfkihDzb09GloxQAJZFg837BPIxH1lhpoHuS504bDOol0HAyG/EJ8aGuUpPj+I6GR3a9R0SwAbeelz176FZEXsiuLfOXGPq1Kh3eTGxVEiPD2JIqIOLqaWKpsU9V6p4WKObJD7mFQJ2MnaceubQX1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=m1k.cloud smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVFDgdi8F3D+TXCXSO6k1KqP/s1YPrAzEURqHmruasE=;
 b=X0EVKJ7tURV9tQkN3COGg65kSKnYuLIRooRm7UpL9peaNOxKOiH300YS1xpL7NH/OpSiBr83dqZVkCRCX1/ghJkvYeOZg9ZdD2a1FOxyyMlOA4lbnwiVo3nmySSR/2qKLCeoVNrWXNIM30GUsKQ1+yx5TEPaGxLcJKlgzeIlITs=
Received: from BYAPR08CA0019.namprd08.prod.outlook.com (2603:10b6:a03:100::32)
 by SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Mon, 16 Mar
 2026 18:48:16 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:100:cafe::a8) by BYAPR08CA0019.outlook.office365.com
 (2603:10b6:a03:100::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 18:48:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 18:48:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 16 Mar
 2026 13:48:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Mar
 2026 13:48:15 -0500
Received: from [10.4.13.226] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Mar 2026 13:48:15 -0500
Message-ID: <a8a3d8d1-ee55-4fc0-ac98-45d70ad0bd6a@amd.com>
Date: Mon, 16 Mar 2026 14:48:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
From: Leo Li <sunpeng.li@amd.com>
To: Michele Palazzi <sysdadmin@m1k.cloud>
CC: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <siqueira@igalia.com>, =?UTF-8?Q?Michel_D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>, Shengyu Qu <wiagn233@outlook.com>
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <f43075c8-e5f1-426c-b70e-743d1e7e4c59@amd.com>
 <84316e45-f596-49c4-b3e7-cdfc7a19a519@m1k.cloud>
 <bc9b30d6-3ca9-44f0-825f-82b1142c8b48@m1k.cloud>
 <2be6dc58-e2dc-4733-aa25-26329cd1d2d3@amd.com>
 <TY4PR01MB14432450DA5BDEFA272476A2F987FA@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <49434297-d6e8-4eaf-b4c7-ce14134d7869@amd.com>
 <96f4df42-2675-4bda-b0f2-753b09f7a80d@m1k.cloud>
 <ca869a77-4bdc-47b7-a8f3-788224be48be@amd.com>
 <fdb2d4ad-10e5-43ca-92db-f1dad48b7890@amd.com>
 <c4cae811-e3a4-4aae-8501-6de0977566a5@m1k.cloud>
 <6e1f5a30-82c3-4872-add3-7d46a266c37c@m1k.cloud>
 <6ac9fc7f-0493-446f-97e8-760a54e209d8@amd.com>
 <7fdc3c4f-c321-48f5-93f9-17a1a8ded9f8@m1k.cloud>
 <1356e93b-af76-47f3-afc5-29535a9518bb@amd.com>
 <aa3891fb-ed89-48e6-bfb8-86e704447a2e@m1k.cloud>
 <51219a7b-eeec-43f2-a335-06710809415c@m1k.cloud>
 <7a148774-3364-4ce2-9f55-2e77889bfb53@amd.com>
Content-Language: en-US
In-Reply-To: <7a148774-3364-4ce2-9f55-2e77889bfb53@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: sunpeng.li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|SJ0PR12MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 522adb4f-b4da-4586-9f0a-08de838c95d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|82310400026|36860700016|376014|32650700020|1800799024|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3vapOyaAoGKL2a8wv67wfpkY8LuHCDJuQO5QLXf6XuHOx1sDS/0xr32tPmyaE65/6Uw0nhndsb4wnjjwP6XoQMCq8fjlUpfPBdgPUTMMsrcrbi9LYU6LlBsvAmRwdMoteso4Pk5uxQxQtAIEwWXzd5lBt24VfzGg43c5OGymq1ZLPY9txJ3NIb17n6EBxyj/ZcFyGxhWrF+T5KRebWkyBrdcNAzdVTdvNHp6GiH2sjGAyBmLqdVRBcEOQCkHZZGx2jksX9ubGnbiselarGVGGyDHMSRM2pIDkIv+BrMWVhHyaXTr+iDk/h71Mfr2htYo/d8u2If4z59fQndOdqvCD7Z6dalLnbBun68O82ssMKot4em1ersh4vqlrzol0Vv2pdZqb8Sq/D4+JV0PBYeQuWAADWfNcPMKeLr8P2ONfeIUn7mJgG/ByYNysWTULEWfpZWU5mSwX2wlpHBKqueUDz5N4ztuvnfxTNAdJjCedVZLZ+o5ZrQH5qlPek1NdueYBaY3TntsIIR4oIC02kIh114Ll93aZrgHmf4KFAD1P07LeuebDdh9ZEMCXtZymxIy3W5hc/3W1yYc613D2korbSM3ax+MzrLus5g3XS+L3iCOeDvWMQMJipOJmjKsamHkVvSvNFB6buHoIXx+/jDA5OrrK7IWfIzBiXb3LJRvht286y9FupVg9+A1L3hfJxCZAIcwA6Y2oxFPMphlrFj0SA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(42112799006)(82310400026)(36860700016)(376014)(32650700020)(1800799024)(13003099007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fJRA43KLm9lRxu04vXO+FSnRW489+mhFlAlxuIdcL6gqa8qgHfVXd7kYcEQYTJLfXcoTL4I1gwQYsPHb+MCe8xJ/U5ugNx4pEbB792p8Mf5NutXj6R4S93eJjX3TC1xV7+7DV4ULM9jsQiVmZQKDlarPg+SBzyqS5zZhNY9zXblihkuobBaI3XKuz0rbWpIOFuDUeo49oi+Wm/xauitN9e9tRqOjgAomGj1JFK1Ws89XUydpVXiF6QIKFqrgkNUawGmU/C5oFdix7InWXqtIdHerQNScE6whNjdpOguji8nghreCdAc1wfyWI+iC4TEPQ9fjt7o3ME8n1ko51/rDSvwYSFv7fJufzUEwO+Lb0FEXyUbCv5E8Ni931yuQcc8QWaRVwWyGBujKiQxJEZ04Al4T1Yfz37dooRhGPA0J8n8Pla5yAXJwMPhAcmtplXI8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 18:48:16.4116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 522adb4f-b4da-4586-9f0a-08de838c95d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661
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



On 2026-03-16 14:39, Leo Li wrote:
> 
> 
> On 2026-03-16 11:17, Michele Palazzi wrote:
>>> took me a while to get the umr output after the timeout (taken within 1 second from the flip timeout)
>>>
>>> https://pastebin.com/dz4tkfDV
>>>
>>>
>>
>> actually there were 3 dumps in rapid succession, here you have all 3 for completeness
>>
>> 16 mar 15.33 umr_dump_20260316_153356.txt https://pastebin.com/LvYrjw5y
>> 16 mar 15.35 umr_dump_20260316_153540.txt https://pastebin.com/SmSvCXva
>> 16 mar 15.35 umr_dump_20260316_153550.txt https://pastebin.com/BbsWbbTN
> 
> Thanks for the dumps, looks like interrupts were disabled, which is surprising
> given drm_vblank_disable_and_save() was not called. OTG0 seems to be active as
> the FRAME_COUNT is incrementing.
> 
> Does force-enabling the VSTARTUP interrupt on OTG0 revive the hanging display
> once the timeout happens?

Actually, if you manage to catch it and send the below umr command *before* the 10s
timeout expires, that'd be even more telling.
- Leo 

> 
> sudo umr --instance 1 -wb '*.dcn410.regOTG0_OTG_GLOBAL_SYNC_STATUS.VSTARTUP_INT_EN' 1
> 
> - Leo

