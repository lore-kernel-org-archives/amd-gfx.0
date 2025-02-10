Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CD3C0219D
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 14:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA1C910E55B;
	Mon, 10 Feb 2025 14:26:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G83nQk8K";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C28310E55B
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 14:26:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvHEJ0TyUpu0biVOG2NAWjKITrjO8VXMmKh3FMg/hfpQPO/ZOMLdiptP3jJuq8MQIK/yhpjj6CwbO0d4zOw8uAvvNzTa1tdM07memzz0dy950+/yg2rVit//Nxm05HimTekeZLiuFnRuT3ZI1jE4iOh8sMKxud3g0dnFeDd/0/XjAE8LRVheSBztMfbkXEl4bClXRMZUesoyTxRt90bfQqAlein185Eu5ojg1MVUdbkUbKAHyIEjUF/ryXY+zOis3roanY5DcTVMw4/qTSaeXt+e/0YRf4UstxSH5KZo2v3caJcct1JqQI0SNO3vTqIEfYMqadgdRkWGPWFc9oZxiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OlVIO5j0ZCBtaos2z+3n0fV7K/nXEH90glPt/yzyK8=;
 b=R+gK6CLEYJ7JjlQuhTMeVytRYcCWi5hP4emPwj0tJ0ZPKdFyomu88rUDPxo9YMsMzSH8jH69daNfRs75cFx9mPBJhxOytZXr3RsAinKzJ/3yQKO4EcM1HNyaho9KCFAQjlhly2PWSHXHyWmNuYGQlIzMvP+KEkH02DMmYPlGqibH5+GNpDqXVh4Lc+Lelw/0FmAWv/YSva/yJpOtQnp31NqLuuvztMD1dT7z/kEdBbqlbB6sC1gUXrcHqEwoM9EDV+Lw63QwylyVCeFaB/SXlkUNHLuQOTnyv4oMGaqj4Ixz8pOtWTg8NkIbNeQEiuzUL2vxhyDro2tjAPvNnrCoGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OlVIO5j0ZCBtaos2z+3n0fV7K/nXEH90glPt/yzyK8=;
 b=G83nQk8KSk8BULa6tMS33d+M+HuR28/nKAzB50ipNAisQ72rQ37XIW2WdMtZhMFPokLLRIsaeeCXOgaY6TZjOyFGOhC5OoPNwZKv4Og2H3wHqLrpPr205OnjExI2onKPKt+fB8XOTptMQkrySzf+wsQMjeFFt1V/1ukWfWORXxc=
Received: from MW4PR04CA0248.namprd04.prod.outlook.com (2603:10b6:303:88::13)
 by DM4PR12MB7720.namprd12.prod.outlook.com (2603:10b6:8:100::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 14:26:04 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::8d) by MW4PR04CA0248.outlook.office365.com
 (2603:10b6:303:88::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 14:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 14:26:03 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Feb 2025 08:26:00 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>, 
 Koenig Christian <Christian.Koenig@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v2 0/7] drm/amdgpu: jpeg ring reset callback
Date: Mon, 10 Feb 2025 19:55:41 +0530
Message-ID: <20250210142548.2321625-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|DM4PR12MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 57777744-3b00-4641-38be-08dd49ded966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S3FYdHk1QmMvVkZpYkptY1B0QjJCM2lkTTYrQmVmbnliR0srcGx3K0FHVVoy?=
 =?utf-8?B?b1g4NXkwRWo3SHlpTGFOdzZ3TW03M0RKTklXSFY1V0krNEFvdlpKS1p2K1hN?=
 =?utf-8?B?YzMzbFVqTlV3YXEvbkEzdlhhUVdmaXJnc3QwRzRMSUliQnFlMDhzUWQ3M09C?=
 =?utf-8?B?YXhlTmdJdS9QQWpQVk1VZzlYaUUwODlxY1J5ZHNwN1ljY0JBZUFPV0ZUUjNO?=
 =?utf-8?B?UkRuekdLeUpFYzdYeFZkS1Z4NUxhSVpSMTlwYmVlUktDMmExWTE4WFZPTXNI?=
 =?utf-8?B?QlBGWGZTdWdGR25EN3Y4SnpqMWxvOXdRaEFuU2pTd2gvdlRtSWVyTXVaSDlT?=
 =?utf-8?B?WVpXa1BOQksxSEdUUjhYUXlrMlZQRmRyS2JTRG1NN096RVF2ak1GSUV2emdW?=
 =?utf-8?B?cjhQUFFqVmkvOVdweE5nSWdUcERmSDRSbUg1dGNycTlIUTNKR2dHeDBsVkFC?=
 =?utf-8?B?amp5K0VkRGM3Z29VNlAwR1owaEZQcFU1YUNrOVg1MEIvUW1kZHN4dGJWTzBK?=
 =?utf-8?B?dTdpcWtHY3htWnZJVlhYcExTNjR5ZnBsSHVvWVZlVC9BQWxXb3Z3QWpnTmUz?=
 =?utf-8?B?TXlsTXRnVE9wL0h0cFd0MSsxTmppdHRNVmdXRWlyQ2J2SlpUV0hna3pPYW5a?=
 =?utf-8?B?cmgxKzBWL2w3cStwUmUyNGlCUjNnQlZFeGg0S0hFT0o1dFExMGJycEgvaE1L?=
 =?utf-8?B?bnpyN1I0YUVLSHJvNDhaQlJKcWNiS1dDaHlJL0Y0UExqekRudE1rNmxnSVN3?=
 =?utf-8?B?aWt4OWh2UGNTcjdHQmlIOGp4bmppck8rbHNIN3QvVnBaZkdsMjNnZEFjd3Rj?=
 =?utf-8?B?bVl2eEI3cWpUQnJHRENNNDB2Q055MENiVmZCWHZ1ZTF3U3l2K2hIVjNoenFN?=
 =?utf-8?B?bytLcnJxRTUyUTllSWhlWFpEV3EyV1c1V1NRNGU3VUhUbVZFRHlONzZKblk0?=
 =?utf-8?B?VjFNMEhoT29aZUxiTVZOSlA4akZLdEJRV01kdklNejNIRWtqbzFRZDJiQnJj?=
 =?utf-8?B?dDhJZzZPTzdQM3EwUDBWTW1yMEc3NklqK1g2ZlQxSDJ0L0hzVld3R2daV0pX?=
 =?utf-8?B?dktWWnZ2S0xoMjRmTjY3SXJSYnpkKzRwNk9JRGppSkZvZnZ5YXJReWRWdUVj?=
 =?utf-8?B?ZG1rd2RYQnozc25ob1hlbzdXbWplMU5uSVNjdEE4VFBvUFhEREV5U1lydlQr?=
 =?utf-8?B?TDNVZ2VFSDNlQlhzSndCVGp4cGVaOXVjVEhRdFQ4TTYySWtXeTh3andKY2tO?=
 =?utf-8?B?anc0Tit3bDJkdXYxRUs4UlIvbGljWG8vOGVEOGVLbHhsVmlYNENwK0RMSFNm?=
 =?utf-8?B?cGtZRHpqZ0JBS0dNZkVNU3BHZjBMTk1DVTNqYy8zbi9md2JidUlVRlZydlgx?=
 =?utf-8?B?NjlYSGhGa3JTV3k1aWwxZE1CYS9UZWthZmFSRFB5alc3YVRMOVBTbURzMFFr?=
 =?utf-8?B?RlZaWnMvbkJYalhuZTVJY0FHcWhheVlGR1l3U3RiVThuaTlvYnpjZHZXbmxI?=
 =?utf-8?B?VWFlWHJBd3BybElRQWFoWldkTktpK202TDlJaU12bSt6eUl4dkZoOHZONE00?=
 =?utf-8?B?MENiS2xoajNidzByaVdNekhIUVpWRzFCNmp3QU5LQXNiT2wzeTFFd0huVzJr?=
 =?utf-8?B?R2d0WG9VaThJZi9ZcTdLWEVnOEdDdnlSZVhmU20wQkNxem1qaXowNGk0a1hx?=
 =?utf-8?B?emhWVVl3YjlKaDRzQmRvVXNlWkFKaUQ2dWpUczhaK2ppMG9WdE85eWxjWDI0?=
 =?utf-8?B?ckVnV2w4M1FKT2JNNE5EN3U1aUY5S01sSTVPNy9lSDM3eFBKcXFCMVc4SE80?=
 =?utf-8?B?eHA5aUNGNW5IdlRwVS9WZ1ZYQmtOem4xY3lZZENpdlphdzh2NUtRSjRWb2Jj?=
 =?utf-8?B?VTk4L0JKaTU3TzdQWm1ORUN0WFNCUnJKVktMZktkWWNqVWYzamREWUZiVXpu?=
 =?utf-8?B?TUpGRlZEbDVlUFNzbTJzVWVOKzZQQjNUN3k0SXk5QnhBeW9JeFpJMnh5eUw4?=
 =?utf-8?Q?4ZAyOWIIw4j60zM5BeIMXj0TZTkUH4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 14:26:03.3838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57777744-3b00-4641-38be-08dd49ded966
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7720
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

This patch series enables jpeg ring reset callback to recover
from job timeouts without having to do a full gpu reset.

V2:
 - sched->ready flag shouldn't be modified by backends (Christian)
 - use drm_sched_wqueue_stop()/drm_sched_wqueue_start() instead (Alex)

Sathishkumar S (7):
  drm/amdgpu: Per-instance init func for JPEG4_0_3
  drm/amdgpu: Add ring reset callback for JPEG4_0_3
  drm/amdgpu: Add ring reset callback for JPEG4_0_0
  drm/amdgpu: Add ring reset callback for JPEG3_0_0
  drm/amdgpu: Per-instance init func for JPEG2_5_0
  drm/amdgpu: Add ring reset callback for JPEG2_5_0
  drm/amdgpu: Add ring reset callback for JPEG2_0_0

 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  18 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   | 121 ++++++-----
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  18 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  23 ++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 253 ++++++++++++++---------
 5 files changed, 279 insertions(+), 154 deletions(-)

-- 
2.25.1

