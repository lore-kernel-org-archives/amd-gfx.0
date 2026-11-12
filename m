Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28131606A321
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=t0ai7hhV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD18110E03F;
	Thu, 12 Nov 2026 12:32:09 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012009.outbound.protection.outlook.com
 [40.107.200.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDF4A10E5B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 12:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6PX40qSbUvCRT0zGztMR8q3+bOvcZpZ2scFxvBCZ2TIvJhhMQlLoiOPTOmCU8Q9/cDjWigIwI2H/OSYQpDjdLwcBeeCvVTPiYdiVlPN+dzKs9jMM0R/C77dQAn4bJEpWCUzb+51T5+XMhxMVmqvYNEVh0vS01L263OJEI+j+rp/Fx6QFMukHGmxvDYhv8wyBPJhR+SW9fdWAoe9FBg2q9vU2YzCJK+fvT3/lONKxMoJ/Hhpe/cG+DqnrUiZNhZTf7ZHTBQWc35DK8LAgikWUFVG59qSk8bHsA3q4JoZcfWo+UTnOJajmY9n4rNXX3bg4Is5/uBYuDJaotIiPb5EJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1QxNPGVZyjXagdzdBxkQ66ULg/NEc4MgmYtE7m+OWU=;
 b=W4zyMe0I0FVYUqPDyUpG+S0F5SrT/AyYZfhxc3Wo6b6QUYebGi/7PYYrYTdBxW6SRn4J85hVQPAPGK8wn7W43rYMAyYIw64ouNLMs/wqecS0jFvXy/5CSPZb7i81N+Ve8R8NEvawW7BdGCofTBb3hbytnR3pdXERKTLN7qqmLagwo1l7FBiM69uszcSi32t407kjXy14BbWqMkcSs37vB21zOzmad0g3Hw5vnha7zY0h1q5xjCOm8FAPB+sPmK2k9Bo3aozU0EWHrDFCj+PG/mxJbEs65dRF5JpuYWHoBzVDno206PlS9STDqCoinjRqn8KeI2Rems/TCSGZS3uxzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1QxNPGVZyjXagdzdBxkQ66ULg/NEc4MgmYtE7m+OWU=;
 b=t0ai7hhVd1yqEkkbI37IYSVpI1frqbuP/DDEdSm+TwZcrbf6+Vuln3oJhMqjZYZALbynchUdQPv8zy80atur5e8e3UopDHJ6h2mnq+fb25xBZIJEDcZ7fqdmIdwZjd63+ZXhnH08iFwqyzTRncNnWgIBn/BayW2Xt/o09HnC7V4=
Received: from CH2PR18CA0011.namprd18.prod.outlook.com (2603:10b6:610:4f::21)
 by MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 12:31:49 +0000
Received: from CH01EPF000BE940.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::8c) by CH2PR18CA0011.outlook.office365.com
 (2603:10b6:610:4f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 12:31:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE940.mail.protection.outlook.com (10.167.244.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 12:31:49 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 06:31:47 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 06:31:18 -0600
Received: from stxhmapple1.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 06:31:16 -0600
From: Priya Hosur <Priya.Hosur@amd.com>
To: <Alexander.Deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Kevin.Wang@amd.com>, <Christian.Koenig@amd.com>, <Felix.Kuehling@amd.com>,
 <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>
Subject: Re: [PATCH v4 1/1] drm/amd/pm: restore the forced performance level
 after a reset
Date: Thu, 12 Nov 2026 18:01:10 +0530
Message-ID: <20261112123110.30048-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c2f078b9-0b5e-4592-b53c-9644307397ab@amd.com>
References: <cover.1793787406.git.Priya.Hosur@amd.com>
 <abbf127cdaa05bc133605a961ef912dd773dab29.1793787406.git.Priya.Hosur@amd.com>
 <c2f078b9-0b5e-4592-b53c-9644307397ab@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE940:EE_|MN0PR12MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a0bc15-f6f1-44c6-2122-08df40b8ec74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|260925022911599003|260925021911599003|260925021311599003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: maa2Hw+uUiC3N1uho3kPs7skpg2vPWFlOgqmNK9wKr3tfu0voyp9D3oMcA8XT8emM8d85JKzw+PkFRiWfHfPXTes3/bOJRW+NFdMYfCXv3yCUckZVRAp2fD6wLodcIE7FGmp4xco1RaB/qrde9mUVN0XM8Prfu3WzUhVta3//FZh7gV/9sICV8bj9kBEPyCa7aoRKsYE/Siv/busD6n3O428zHGXG1nQPf6OrzeBI5UJizcXZ4EdF9PuJUM+pHk5AWj0VmYxT3WlHZmTrJqII91AE3l1xQE64U4qmy0KEfpHL+16A/QH0RhbH9HFW6vbYlzdq69YMxf4yl8BgJNhs9+FVW/emcugwGdhO1v0COpVx+uMVgTwVh9TUl9KsAoeZQhANi2/8zo9LnsSKHXEyVjyxNkBEfn9fqfkMDWXWAxSKtiEu71I66/eytYUZVHydBwDq6JQIpd0C8jnzde3mGMEpul2ULbxSh4RnpQOuINek4dIvku3iOJDAB6dPBjQxsW2kwA8gKemF8GYwv0EGN8R3FxOotP6l4/+OA/lQq3L74DRQ87zEOyqEIVCRFcF5z74KQmsz9zb2pqLahFiwm3SJa47VI+6AMari1eBJeQm2eE9kHHApWGwvv/U1/nPSZOIEBhXiCtY/mZPfOpe0q+nA+pv7+ov+vxUJT7e15k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(260925022911599003)(260925021911599003)(260925021311599003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Vi4FDJKKaf2juUiqNsrrwPlJe3sTszhWnjQsEgG/JUkXyXG3OI9FPB7s0mxt/r/NKVthKV6/rCMgr+yzu8ITipVT36+v+h0Q6k4kf6hqJhXkp1AZZmSQt2003U7WVT5PkJXNOMP+YrhaFqCrO+6T8TRrVVC3/FoZ5quW6EEulGjLf9JSppJMq4OTFTItI7vS0fl18bufdXXDE6Ian8yVJbfnU+Uw98IEHqJf7lhPJ6/lxodLgvR3XKDYinIjUjQId8DlGylCEL8uL/5tMV9RLfhDLIvFpsWibdIPatAOzuNtGgQ6kNrZP3RWsNbHV2xuWW+mZ+2NndwKbRVqqPbUU5hrTFLhJW7+jUre/bhzsp7IM/QQpNRzWCuAkxqYgZj7K7z0kDfYvUpkwWJ95NqWJSwOMDkVx/wsmIj2uEyU2g374B9Gv5EuQMZPEH5wJCnl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 12:31:49.4776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a0bc15-f6f1-44c6-2122-08df40b8ec74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE940.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alex,

Adding you, as you were missed on the v4 posting. This has Lijo's
Reviewed-by. Could you please pick it up for amd-staging-drm-next?

v4: https://lore.kernel.org/amd-gfx/cover.1793787406.git.Priya.Hosur@amd.com/

Thanks and Regards,
Priya
