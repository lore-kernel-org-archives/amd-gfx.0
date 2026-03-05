Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699FDF513E6
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 22:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 074D510E114;
	Thu,  5 Mar 2026 22:30:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4GhaBGfG";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0512D10E114
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 22:30:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4RyFU6G46ioiXojwxuyQhFrac2/qM6KCt8oD8nNnc9xbjQQpX4OleLc0K7Yn1tjMqP0yJhGa/GQzqedS6812EoWY8MRW1eLYOleTSdVNZWjfswOzgWmA/Ifl1pn+zuAULQ0Ns5hOHAX0iCGt20mscKH07avOtFAJzvehF+cnR0tl+ssI76BF+/eCn2JOGltFINPAdx3NylWwZJtxMBMPT6Icri+fkb+lCrCBHW7eEg/pPfXUVb6Tv1Q+8cZbIsRgpHuQ+U3bi7MXX4QzMBGh96zLbfXgXGb0Vn34XU0P90hzZTg2Qprhptm2IBEX/gvygBLQm2CRm3WBdtZazpH2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6YbJgdzq/FWaTO+Nyz1Qqg4e7L47ud1O/4aAlyxx3Q=;
 b=TLTOvPQvszhJPLux0KLKkn/HrzuISZY9IYpZCHcTK8gbWS2WSBeX/TyZtoNAfsUZstrJ0fwVEIjV2+jDNPL5R9KshmKt18qpj7kU2BbZKXgpOyXo/DrUUE2L3PD2TwLJEa6uJrD8VYlczqS+FmGJdWdANfUwi8yEebqggl99L4j5uEMjnhl/PYxUUOsg07x/G7N5qrbC3XeERxJI7VT7Y1f0mGTbPyq9r6VcxWm4dpVj1gG8H3lYYYfpyXHIlcpM7sKjKSg586X7H9b06I/DRF6EorP1TlfzEi0uGeBxtMwzH7wTkOUGm3X8dK5me+fwCfR4gCS9qKOAqVOq6yPdag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=m1k.cloud smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6YbJgdzq/FWaTO+Nyz1Qqg4e7L47ud1O/4aAlyxx3Q=;
 b=4GhaBGfGP16GyqPbfzTwCpmIzKNHCkXfVjdm49g5pIEvzE2OSeoLGuGsoOQ5AJB4oXMO0bBbGU0RGd04iOIKtwIAUTEnZHD8RB2qlbQBM59VnmKLm8q2bZc+f4zu8K6o7BxZ2ug5mvsDppswLfl8BowejuX/yQprLHkVee0DmcA=
Received: from SA1P222CA0117.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::23)
 by LV8PR12MB9333.namprd12.prod.outlook.com (2603:10b6:408:1fa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 22:30:54 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::57) by SA1P222CA0117.outlook.office365.com
 (2603:10b6:806:3c5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Thu,
 5 Mar 2026 22:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 22:30:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 5 Mar
 2026 16:30:50 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Mar
 2026 16:30:50 -0600
Received: from [10.254.95.96] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 5 Mar 2026 16:30:49 -0600
Message-ID: <fdb2d4ad-10e5-43ca-92db-f1dad48b7890@amd.com>
Date: Thu, 5 Mar 2026 17:30:48 -0500
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
Content-Language: en-US
In-Reply-To: <ca869a77-4bdc-47b7-a8f3-788224be48be@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: sunpeng.li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|LV8PR12MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2a8573-bd6d-4cf3-1d93-08de7b06dccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|42112799006|376014|30052699003|36860700016|1800799024|32650700020|13003099007;
X-Microsoft-Antispam-Message-Info: AevfxKsnHXx7k1W7veDxdp/i2T2p75kWuMka5lA65r6sk1DKcZQucCXAnJp4W44ifyWryLnR/Wn0h7ZjaTltznWrV1mNE+4B9zjIdCy2HGL+z/kqI2PClzxeGf9ElbG/Qi2R2JjhbYnE66pFGG3QzD/eBONoBEnC57xbm33wTlfmcnEVymw/NNN3va64Xrdm4BcS179WoDQPyIpJbaboVMwbPWqhvkeciEq6bTF0OPo/yUfH9/YKT7wuIInviuUMlIfnRTZicl0G+XI7iy+2F540snxzpAadhP4VbgTq0lM14g2MlAaQQhok72iEnxTSsSnhOw1BCsya2OyMVeYMKI6prAe+BGVbHYP0Ze/XAgbJlmjeBuur7jN4Wlg6XKXI8/JUysbXRIU/SDw/6NgqlvxquAEQUxJ7d5J4s03Uv+q8orNWuOyn5vsrLvrxZU8vnvBMJzpz+nZq2CfNeQkrSPNE6ermMpP3OAQacaz/3R+07kJDRPMmULn9ruHKoIbkppTAaHZczxcs2ryE9SpU9pZtUyi7RzAYNAYza4eqPIu1nTXFZ0zDz+hragDxZ9T+D/raU4er2le+YBOVOkctl3SxMKUJZ9SeJ6Fzvu0/6HVm5wHAmsmOUBfDz8LfptWIYj8tV8XS+OSkoCFQSjyrz1n+iH1/gXHIG1t1vYXAMod7z8yPovVOePuqnVrSzijlifXPyoki/xXv4zktFU9cVnIT8DrStUdC1doXDGaY+306quUAoMobd2TR20AjnU96cEXfKRAhIC542VzOf5g4eA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(42112799006)(376014)(30052699003)(36860700016)(1800799024)(32650700020)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6DD3C/AmYR0J824z1+vKZ4XUvxrxMSfn7iUugbhqlgs6BH/GOiuqiG222e3PfrPjDH6jhn0schOWMtawQqX/Eh5GkDw0ekSXH1MaiBk6GzHWk4JtGbuK6yCg70gFh3X/swuq5mLmUaKBUcEdUn3/EPCpAESLEnjrRZwlLuIGYJH6lEZhPhgQfdQE/oIDjDcTjKBQorRdni5I9Kx8qhIeYYg2kJsiifc/SZLbboOMk3GEsYiXFHrRP6au+Maxn3USi6jV/VBlHmfzGcjsfGdaYY43uDtAyq4CljWYhzJFzfuAhqd8LvmPTZ8E/ciahsOh4nZlLiqby+lYiX4PeoDC5mdkxhXzWEIfta6Ycb64hdUWOPTjPdWBv3wiKVhu+zE9ngQNgxiYIZiJ4KQb8/DHeteRvpNQwtH3TOSyj0ZxP4sX6Wmu+m8SDgFUw7+wC5Z0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 22:30:53.7153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2a8573-bd6d-4cf3-1d93-08de7b06dccf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9333
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



On 2026-03-04 09:20, Leo Li wrote:
>> So far i could not reproduce with your tracing patch applied, i could try to use bpftrace instead but it will take some time, i am quite busy these days.
> Understood. If you haven't tried already, maybe dropping the stack trace (-T) flag is worth a shot.
> - Leo

Hi Michele,

Since this issue is fairly widespread, and we're heading towards *a* fix,
I sent a reworked version of this where we save cursor-only vblank events
in a separate member in struct amdgpu_crtc, and deliver it in
amdgpu_dm_crtc_handle_vblank():

https://lore.kernel.org/amd-gfx/20260305222131.160914-1-sunpeng.li@amd.com/

Let me know if you get a chance to try it out! I'll also add your
Co-developed-by when merging -- I forgot to add it when sending it out.

- Leo
