Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54802CD6E7B
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 18:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF96210E736;
	Fri,  5 Jun 2026 18:27:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F+XaCUWl";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013006.outbound.protection.outlook.com
 [40.107.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56DDF10E736
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 18:27:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWcampSGQPM6N8RGIH9BfsGVQCKfKtCUuXw27X4W30xG67oya0q4rlcUOeV8LRJI1FfMJpslScAzDd+XEN0OJzdzQY9TyuEwPzG6La707IXHeKaeRtDSAFuMpkA8Y6kpVZl9ENlwjjUmJOSwSY4UdGLb+cZzMC3Efy90uRKa9lR8HnGV89cQIXJBP8tsln8FPEcqLxLnQ/A9XPmMbk1QANn7IoeT8doV1CykhkM8lanZsBuHGHjl17HsNjt2CRZcxLbUUBKBIsetcmphCYUoII+OYJN96itIYqnTpPJDywijHttcIUm5SJyfm2tEploq2N9RjPGlrDSaUDf66T3evQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ls2+WC86GCj8Oq+RQDfQ9A6mvqToV6Cj7yz/0+3gMos=;
 b=OSGhfwH7Q6G+lq53UkLGH8OUIajxixsRg2d1d9wM/k+eVU9pMo5c9MI5PlKxtYUZSgiua4ZLoeCSdUL1o/l/YNHuVAaVFFVPf6utH1EatF+2ZLAupDMZnx3mcvgUYT0AUrvOH0jLRT2ZsTn9pgfbnlXB8IzGTnVm3aUZpRtbo5LE4v/nGkIGISUJ1ZyTTO8O45YPD3SRPIIJniWCFsV7QNwzq2Z/V+qfjq9xmsf33ztQaaqFKUW9E2f/EidJ3nQG874wmanAOcZVFZxB8YVXdilaW53P6klxyDqoGfPwuySLeWdHqQ/uqUGqJYsQFbc+0TogBiuy7ROngsH9PtU8oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ls2+WC86GCj8Oq+RQDfQ9A6mvqToV6Cj7yz/0+3gMos=;
 b=F+XaCUWlN5lHXweXGskUNUnvy1zfgadzbackWjPC4tb0woKwlxwcgMwkomyAsNBu7PLFw6lZJJWln78j1bAblQLFFiRTTqP9sTNKxex4uo4aYy+TzuC5siWsW8htSCBYFS43Xg78xmKyrcjHcyXA5NeZXM+fnryVml/0S4CWBic=
Received: from CH0PR03CA0286.namprd03.prod.outlook.com (2603:10b6:610:e6::21)
 by BN7PPFB3F5C406F.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6e0) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 18:26:54 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::93) by CH0PR03CA0286.outlook.office365.com
 (2603:10b6:610:e6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 18:26:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 18:26:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 13:26:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 13:26:52 -0500
Received: from [10.4.12.116] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 5 Jun 2026 13:26:52 -0500
Message-ID: <e2676763-3d17-44d6-a774-8dab1b38a00c@amd.com>
Date: Fri, 5 Jun 2026 14:26:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/24] drm/amd/display: Retry link detection on hotplug
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Lin, Wayne"
 <Wayne.Lin@amd.com>, "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "Wheeler, Daniel" <Daniel.Wheeler@amd.com>, "Wu, Ray" <Ray.Wu@amd.com>,
 "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>, "Lin, 
 Ping Lei" <PingLei.Lin@amd.com>, "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
 <20260604145428.809959-22-aurabindo.pillai@amd.com>
 <CHXPR12MB9992208F15221856A4264B5E97E5112@CHXPR12MB999220.namprd12.prod.outlook.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <CHXPR12MB9992208F15221856A4264B5E97E5112@CHXPR12MB999220.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|BN7PPFB3F5C406F:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e65c515-36a7-4a38-dc77-08dec3300471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099006|4143699003|11063799006|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: KwBAZEopeqsXUiowWXPiJ6sDAtJavsn395ND3PC7FMntKDmqChA6aPFgV6cdDaDSM77jVZCn+/jDRUXP/cZX5JfaFyfoeHbFBOFZmu3F2+F/d6jsAIgTkiII3S3R8e3ZZIYbQ57Q+xAA28h+9riTTJ7eBTWrqeOZMAUENBtkbWHarwbzX0JW54Kcx0grAx6ZhlgPNqgCvmksYYg2Hxa+ROcvz1cTiem3m0ZR+KZvl/eiFfGd0oCYg8Dh3HnrFyj+qI3BwNyFM4OgYXWrL9HQec6MqzAeiKMgWbh9z+VJeEED0jMEyPjwY6vYEWs6piifTF5GonWUhtO4eSM/i6nx4fYDjY1uZXZNMn/LAMnC7KLQ3Upd84sEG1v1QXNE7YjYvWim5JUGHikuZMxK63CL8c0+AiZEOmDj4+QtgT1EaA3OFNOpfkTdv5AS0GRxO5PWvEb5xVDhJhFpzKr64z+p8gv6pN/Z0xiVSRZqVO/Y1sHR1lEXQpnHlKK8ubbSyChtEYkopK3kaIIsWQRtcl5NTWHeCDfdED/jaCtTt+NUJkcQ26d/0cSFh22EXUlWmeCiFRdimS0PdBRtKFwJufucvq9GbaZ2hanGOqqmIChi34DW6viD52/sJHpIZtfsAXU9kFuA7xbYi8JTF0M9mn3md+PP+HlaWZlPq9ETOX6bL7xpyKuyFdIpBed231eIBeWjOieUm3OcuR7BkY6+j4MisFJ5N0n1Oo5R3F+Uuj7cLFM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(4143699003)(11063799006)(18002099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eYyLF09g0xklTz0hm43Dea0tIXDN9PG7AmhHT1a+HkxsrAJYnyld3hqgmQBzuNtwkhUPJdMJszstUe7hA+2JqbpigleCxrNqiF4aqAFiZ4ZXOgQI8/aUegZj9HtHsT55OmztRSRerkQM/Wyd02eZyRMhMrDze0T8TN08mTEwxceFYLibZPBI3rikc4P0/VH8KeNT03klWsALWt7LE15UGTweeQyVZ8eS6bfhR20emfQD9MP4r4TuTgpTGOTqpQkXrpu5qPDAs8Uh+jzCpm8ssnL9u36yc78bqUTpsz9ezY6/MAbTCWbPL4pStz2OTHHkEwSPAKSiA4IkQIzuJ4+JabuoHlF9n3FAX5TfNR80wDFiNXGBBPRV9uTb8PafA3RMAweoVqpKNJoUzJflQ25phcYtMBPTD4mWZAROh8A8kG0uUl2PeBprItUkVle51pp0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:26:53.2965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e65c515-36a7-4a38-dc77-08dec3300471
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFB3F5C406F
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



On 6/5/26 12:10 PM, Zuo, Jerry wrote:
> AMD General
> 
> Hi Timur:
> 
>       Please let me know whether you have validated the sequence by any SST and HDMI monitor. Basically it is to confirm the link retry workqueue is getting executed with hotplug and dpms use cases without introducing side effect. We've tested locally, but we don't see any link retry workqueue is getting executed by either SST or HDMI monitors. That makes us hard to validate the new error handling logic. It would be perfect that if you have done that at your local setup to confirm the new logic is regression-free for SST and HDMI.
> 
>       Apart from that, we find a regression in MST. MST has its own detection logic and should be separated from SST and HDMI.
> 
> Regards,
> Jerry
> 

Hi Timur,

Thanks for the patches, but unfortunately we're likely to drop this 
patch and your other patch "drm/amd/display: Retry link detection on 
resume and boot" due to regressions. Jerry will try to find a fix. When 
its ready, we'll apply the patch along with the fix.
