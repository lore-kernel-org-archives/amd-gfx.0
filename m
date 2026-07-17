Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BCAC4451B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 18:41:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6546F10E2DB;
	Fri, 17 Jul 2026 18:41:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rqi9bjJ/";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B004710E2DB
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 18:41:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6r0/uclBNSBUGX+fYU0cN06RF5Ua+mpA/DMYm/djF4LtZGpLe17DV3MamwvRwlanDH2tcePppXJPmTNzCNSWfVlbFOjGXI4fQ0MzXxNLCM2aCjq9px1nvqNjfrHxo52A3t0K3DdOA7q21bKb/rG3Ry6KhNzjmv4bN1RMCL8mUkuoPGmY1fqHoquvXgrqwXF+TUJJWh3u/xZtI5pITWRFffDpEH+dKrd5uLBbRpfazC3x6x5fwFK0cIS3OPULuHPwOXJ+xL9qqo03cJAszx6ZBv/h377RAs1KHxFDqW0HVZdVlQDPcpfsbooBfFbRIROLdlAo+l6cLGhBPDkMLtusw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H669lgSuzbwCG+aKtEa/pkol6AgD0ovpOiTVrhsXhTE=;
 b=i/uIdKdAq+UglD85FTwrzTw6v51T3WeODYuglE9UMwAvWYRc3NK/njGJnDt0US4eyI45FQrNKdHNM3U/sn9EJiLLyCK9l9VeOtrEVfdesOCS/9jQG4Tsde0C4aA2Ydip3bSXwvT+sWfCL+P1ZPMY0uYHl/1Rl+soPCf1rKmmmfxzX09ncK6oEqojQ49cuPD+BJRWfdeQUGW9wyHkXAHab4X3a46Gb8+axX1EPSu7Hgt7jDaq10KO8OXFAwOKLXeWhurJ0CHYdIvV1nhk+LiWb5MqqH/aIaySIkGswsI6WTNQyxdCfkfJg11sp/ehXNDNUe8HUdXIGds7KB6MXTKTfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H669lgSuzbwCG+aKtEa/pkol6AgD0ovpOiTVrhsXhTE=;
 b=rqi9bjJ/rTsPfGvuRxQX1cOQOjebGm1jjjOPwR4P55go9kvI2WxqU1l8do8fgbUvBle0JWmq+QBsQuFz7o6s/5EVIusBXyezSjnK4cXZAJPQVVDQTaXt8jHdqMj8fmsiB35sBnhtdOJmXDyGgJwjAADHAMG4FjSk0EfREXPc+Fs=
Received: from BLAPR03CA0023.namprd03.prod.outlook.com (2603:10b6:208:32b::28)
 by SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 18:41:05 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::82) by BLAPR03CA0023.outlook.office365.com
 (2603:10b6:208:32b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 18:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 18:41:04 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 13:41:04 -0500
Received: from [10.4.13.44] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 17 Jul 2026 13:41:04 -0500
Message-ID: <f70a5506-754b-4c16-a5d2-b2d08ac442ae@amd.com>
Date: Fri, 17 Jul 2026 14:41:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: amdgpu: sspl small piece of dieting to start
To: Dave Airlie <airlied@gmail.com>, <amd-gfx@lists.freedesktop.org>
References: <20260710063946.2262582-1-airlied@gmail.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260710063946.2262582-1-airlied@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|SN7PR12MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 84af2363-6b29-453c-64e7-08dee432f561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|42112799006|23010399003|36860700016|376014|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: P+44ePt28WFIPvZM7zKiinIOLJvRoiG8dZ9NDDhbU6TeccA8V6OZgQzChMJ2koNyODKK46dj5M8wyvK2dlJLT0ZKpbN+GWYBmxxMTGmeJOrkxx+wbAVniIswUhSHTqwHrIii15tMt5srtOnwUshou/I83wzXyMNDK5BaVHZoEQfA2zMrhxqRWlxsvx6OQoju9ubJECvWrYfqIgD2Go4ycvEkSNYFQ7jaNU2sNR4SoBCYWgMhwur+ZaX+3MPqwS2bxvjg6b5pYyKJ1pv3UBggRhRaPVEdK75ZLCv7jb2akgDlUhQz36j8EoxYwr2g8zY4z7PBWaK4WcY9y0FzmW13g7LJYp+c/CXkDTKX0NXH58AvcTvKS+Zl+U9NVM1lMqbeWMEF1BPDRgwBuaVk3C61CCk6KBD0HIsJgta6hIOGP1lTiZkFpRESZ/MnNDttT6XXTRHRZ2NlUdHHS6HL2ebWgQsLHDZP/JTYLEyvbQOzg0BMXzkybXfNt7opmalLhmWEl1YpAO/5W0mkBC47PtyXilEXuAsBtnCVMCJNJBfnjDcgYFB+r2bFeAb+DTY0/mqJs58armET5u4tcbZD4+aiP8e6fioYxxCBSWeMlknO9zASX61n8A/04qVCjokb1L45zunyB79TzTivJ+jMFSme4QDhUvdgC6R1P+UENGwgr+iBilUkqZcL9GdJv+wTyiX+ODGAIFZTXGbdqVhGkQOw9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(42112799006)(23010399003)(36860700016)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bMZy/7J6DAQTSub/azk1w6ii8+RaHQkLtmMbaijW9DUyy2Xi5cv6R/Z6m1L7kS5XSGtwSgvajVHQ0G3KOFWQZR2d6Q1OSQpagzG3qNqo+tqDw87Po06r3pHwGwao6wPrEca+IgS48rBnvSHloBgpoZAT7UwieSd+/eYMoOVfQ91UxkOSJ/QzpL3/TbooJtd8HWkoEu6fOS4OX3z44D2pMrckLwjSfok2JKa8Jjr5PTqwL+RM0Fr3o7biq6ijNRWWb04TNBVVYlJyz2MtRFSQZKsEERAIyXDCbnl7eYUewjK7AANTvwSW/DdUweV6uU/pS9qUoRG6dLJoYHB+tgSwr/1TE48hUP7hHqL2hvm7q6qmKwKdnsvrphuxtm9Ss1zUv3AO1jYRtt4T5izf4SJ4Fl+hpiCtp7uFK0qYVBJOElWcDwMp01NF5Hbbj4DqUE7y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 18:41:04.9044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84af2363-6b29-453c-64e7-08dee432f561
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7321
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



On 2026-07-10 02:37, Dave Airlie wrote:
> I was just idling wandering around in dc and fell across this spl library
> imported from userspace, in the worst possible way, now I'm willing to
> forgive some bits, but this is horrible, and I'm not happy this passed
> review.
> 
> I've started by ripping out a bunch of duplication that at least drops
> by kernel driver build by 6k. 6k out of 12M but we all have to start somewhere.
> 
> Dave.

Hi Dave, thanks for the patches. I'm talking with internal devs on removing 
the fixpt/custom_float cruft. There are some other dupes that we're looking
into as well.

- Leo


> 

