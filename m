Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF112EB3637
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 22:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 633E210E5DB;
	Mon,  2 Mar 2026 22:14:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e+N22EKV";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B75CF10E5DB
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 22:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P64pOPg0e2icNpe1LWUVcxYMRQIkishVH6K+yiLRE3Zv+L1ebdhwYy/Y0yHsJQ/euQyWCsebm2Wve0MN+Jp4yb5HwNSJGMcVs7IDtudugq22VzqgR6VAd/gyxtQoyaYhmveH+NUZ7shIX5bfV7aWCynptAshAj6CZGlgmpmPNXbw2QP3zpQEjelVosiMijxr9MOESQ4d4O2l7w82FWiYUSuRqjede8dixSj9ipPjLYP59msyO24Prsvb1ThikA44VRuKGkPfiTCENQJMwAgS5UtZDYQjhqR5m3jMtfZo/gM+W3IMeEpyk3Sb7+LEhOdD8vFTm4sjeMpHkeo2rwKerg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siK/We9dc3yIkAuGA/szmURJ4Qs2xemhFBgs33c4ZR8=;
 b=fCmE9ed1Kh8OWE2VPoU4HlZfvu1CqAVDhmNN++zvAO6amipdCM+ngAohpm8+7PaBonCEHnDCi7XEsdxuK6yA77vHSVI2SIG6sN+WPCBDwgDO1rlOR2aU1uLPWPYFOxfruxvAsHfDouHWMC7iyfudpc2dwq0mH5/elzFGu7laO/GaxSCupJpE7ZCTpBMK9TCoolCPBvk1/lUVS+LsYtkoSseRrX96dzKrjg6IVflsVf1VEmDFThJ7qFhAPsW2cajusr45/NzTDsZVSGt6hCdGOPDsIK+UsBwu7PAuMgYzAc1G+xada8sB5q/dd7au7/fjTPtnPMpXbGc2/K3aPE7cEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=mailbox.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siK/We9dc3yIkAuGA/szmURJ4Qs2xemhFBgs33c4ZR8=;
 b=e+N22EKVCfynr/BYHtup8Ylyt4mkuvitv/WXUq7bAFKcD2arYq+D6o5XrCu395TuApOZKDbD2N6PiEYDeOBaeIuJAwjTQwGxIVUPWY6P+6zkdqDP6mkuhBIsdLJ2s9YMjFwN6jwiQFdJ8Su/xdK21JolsYTJyNRf9X+OYxVFGh8=
Received: from MN2PR11CA0005.namprd11.prod.outlook.com (2603:10b6:208:23b::10)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 22:14:50 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::8f) by MN2PR11CA0005.outlook.office365.com
 (2603:10b6:208:23b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 22:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 22:14:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Mar
 2026 16:14:50 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Mar
 2026 14:14:49 -0800
Received: from [10.254.95.21] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 2 Mar 2026 16:14:49 -0600
Message-ID: <21ac131f-e208-4018-bfa4-92ae62767025@amd.com>
Date: Mon, 2 Mar 2026 17:14:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amd/display: complete cursor vblank events
 immediately
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, "Michele
 Palazzi" <sysdadmin@m1k.cloud>, <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
References: <20260217191632.1243826-1-sysdadmin@m1k.cloud>
 <f43075c8-e5f1-426c-b70e-743d1e7e4c59@amd.com>
 <965e25c6-f34e-4fa5-a014-03776cea6b28@mailbox.org>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <965e25c6-f34e-4fa5-a014-03776cea6b28@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a5f687-7051-48c7-76ea-08de78a91f57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: f/VZWra6ucdQcWjsBbP59/Cpb5NLJ5aQbtCgoTm9JDOARuuGHLSh+ctRrROqZ2ogYuWDPiTmnAaoYHsroPzn3aYhpsJ7FzbPpVeCbDF6Y/w+c03+UVd6raN6Dwfvo/Ew5pH/5c41vxl4oC0zukIoMDtCWHGLSQinR3rs2Lh25ghXYTns9gvX9yyUl6IDSLOKbET2YSml63g9WlS6nYkE9H5G5DRriBA9zXeeshbaYkxXq1B/pJD2byJPkokKgWc19kUq4zd08rFI60p2jGY31y7C/CRMNWSF9whYKTmsNj/KfjZYL/eROLXXumlXlgYN6HrO0RoTGjJCJN4rgYdgpVn8+wHd53vRXFkWm3EzhKtZtCwpywpLpnnDK5h6bxtGOuEfE3QMF3+gHbfH68+a0DC09F2441jNG6adgIoppJPY268IzfQhgryK03zswxBMPSoPicr8hleUHfB9/yXVuISJl2r+cpB1hwT1ZEQPJBhpBczXrKNGbmgAKzfiCt8SCr8g87wHOX1NxnzZBQW+3CoXhuma1oFBiq04z5aPlSCJ3nRkJIn8m0BfnaHC29sgeL7xvHVa76+iniKQJDErwvVl3av/jLkMT1DtEndfppuxhLbARlm2AchSXyeq0wLnlC9VncbJx2pMI2Q/5CHj5jD8mibkOUYIaIZ8vWNVhTjHcarC7OcvCpysL3cYKQxA+VDAzzJkiveHpVF6JvHveFayGwAuDas8dBdrxQnk3by7wjRx0LCPnSUoZ03o1LLiNmBViEZjyNGbnbDG1tRcMLW3vTFspLGjuqsz8VdvX/qVi+aRS3pi3Oy5VGQKy7On6lnEomgcKUQf/dA/P+vVuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(82310400026)(36860700013)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ypte/IO/5bnppVYmxsLTETBf3962e5x4S42KsxieRC6sKf4btzqT8f7bdFP4QHI8WLACuAVMzysh31A3+8O9rrCn7N6IQkt4WGYd+lzZr1+VzkJogHNPGKuDY47k5BDUM4RoLBdIWefC6tfuNu3itxZSKYwccaxFhxE1+8uIPMYkN3FcBmQ3I44fxurO+JDcKLodKZZ8UDcSZtr1fz2dAl6oTT9FULmIiojYWL0kXptYrt7YcsQqOaMrCFwarCJadfqAtkmqRdceqMMZBdtzRpQ/g4znScBV+VlwBJthOMrTOpvBvLlyFj0J4qq6tnkth2c1yuxFpn4cG+paEWB6q/Xfbu0wVhKWAB2dBgTAVWU74QjFEawywtel9C6ZCcoApRDkEnJwmJRNg4HQzHZkaTg6OWkTvp0O7HtLp9dKe93MSfqSrrphBG70dV6qEIkD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 22:14:50.3417 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a5f687-7051-48c7-76ea-08de78a91f57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189
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



On 2026-03-02 03:53, Michel Dänzer wrote:
> On 2/23/26 16:27, Leo Li wrote:
>>
>> Ideally, the cursor event should be delivered when hardware latches onto the new
>> cursor info and starts scanning it out. The latching event fires an interrupt
>> that should be handled by dm_crtc_high_irq().
>>
>> dm_pflip_high_irq() handles an interrupt specifically for when hardware latches
>> onto a new fb address; I don't think it actually fires when there's a
>> cursor-only update. I think if we really want to do it right, we can have
>> another "acrtc_attach->cursor_event" just for cusror-only updates, and deliver
>> the event in crtc_high_irq().
>>
>> In any case, I don't foresee any major issues with delivering the event early.
> 
> If the event having wrong sequence & timestamp values isn't considered a "major issue", we might as well not bother and just put random values in there. ;)
> 
> Compositors actually make use of the timestamp for frame scheduling.

Yeah, point taken, I read the other thread too late :)
- Leo

> 
> 

