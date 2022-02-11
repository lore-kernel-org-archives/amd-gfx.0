Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DC4C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 20:53:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4506110E235;
	Fri, 11 Feb 2022 20:53:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 692B810E214
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 20:53:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cicjyj0jN4mn6/ZgnVOjueB68G/gy1xN/JkDN1mtzijzZfEoWZdmzyqNTxof73FNh77fKr/IzhMleWMx0wbletmu4FUZaLZJ4CzgnH3N4Dze06Zzb1jOzVAo2TXkhmLtDbTusVaq0p7TXWWe4hajGPHokDX6Nllic6y7cPa1wtKsiZYOStjytoT+i6HyY6RPBqkFgrtFtfac0aR25DmopEiixoPg8G7tV5gyq5t+QCww7HqLBTARFQJ/mBZHgWbRhX9ZixBz4Q2fDOeX4HuLEWONmHfH9hBpvqXmgMLLE8Ob5/C2skqEu0o8PBGIUrxMhudQDTbjiA8ux/q3TMYlOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07XIp/KdO64ViDMP3Ri9S1cg3IDD+TnygTrgcllhgf0=;
 b=RTLKdOT6n94nnpT4EURV/bsxPo8NyG/16SiE5ZmrX1o5HdZ1roB65yjR3I1RoFvvAfvorN9gQmYgBPrOhYLrlomTciO//jNM8iRPQAGUWRmNH1kTaaXS53lEy1m1QDIUdp7DP3Q2cbKx3jvx0/91pw++8lFPd+1EnOo4fhoxa41Di5L6qVGg+PjNg/H7gtN2t1QtKLVqmtTMEn776DrCkej+r2wludxTYkY8RFBxoOhO0Pi32ieyLvV2PUOQSJ5q03zFp9h5tiebcLXxuzYLLpX6zxIjj7WPsSQN7X1i3eHHSJRwLKi82C3sc9DPb3MqSxIcdaGu1ZhtgHMXdpGOwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07XIp/KdO64ViDMP3Ri9S1cg3IDD+TnygTrgcllhgf0=;
 b=D8r9ViHJn2Z2fzygKTAOfFp9oFL1ILO1M3QejbAJRD6bR4QwC3wR1cpbaHDWT35TUdKwCck/N3ZXA8ny/dn9uKwJIJs0rR36ZhcjpYR5eKuRnWJvuEVQhVKw/2oGLxgyFGGa/l9+3kWkGIS1V5pN098hFeE/aKmbn9IpjdD0lqk=
Received: from BN9PR03CA0979.namprd03.prod.outlook.com (2603:10b6:408:109::24)
 by MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 11 Feb
 2022 20:53:27 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::c7) by BN9PR03CA0979.outlook.office365.com
 (2603:10b6:408:109::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Fri, 11 Feb 2022 20:53:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 20:53:26 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 14:53:25 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/1] drm/amdgpu: Show IP discovery in sysfs
Date: Fri, 11 Feb 2022 15:53:11 -0500
Message-ID: <20220211205312.6410-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.0.3.gb23dac905b
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f86ccef0-051c-4b5d-6388-08d9eda08d08
X-MS-TrafficTypeDiagnostic: MW3PR12MB4457:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4457C36B769F84B4B5F9538C99309@MW3PR12MB4457.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CTJvCbW9BdoXjpbh/KLU+WlaY2TxPuss9abKEkF5nYFeZ2ExEsErKOnOyCmUbuAtdlOoMT1qsz88pnAvcbbE5cBU/KOv0U3k6vOk98IF1XbFWehPDn5Fv1HBb/F21rT5OLqMZmzeS0TBGr+7EYarc+1pjdr/Yh13i651JEU7yHzPoqvxqoLlKxbG11Ry28lnpEpQ9eCVWF7Ug+0XO7JitoiOWcVcIuwl+dbi+JvDb+ycsk4uRFRgLvN1IY/dbJvNt57ue9u2Y2oCYZHXiA/p1bunoG2/M8lpryWXOQTnjMMwwtovylQp4y2D1HFxzomZzhPY/fNoL5GI6CnJcppdIQohAqpWg8I4xsNeq41RJ6dywFpQ3gm4MsvJgdiflW8De+1rsd8BuzgpWiyVbA6a6oKCTKqisLc6TJmcmWfBtWBZk2vFx7nRVzCegMpZ+GT3MO+rYSszedZOprH0oX6CTlQkXpkdEJNpOBQdtk/3FExNnAmK91XxKla0uremSV3HypK6YEUNtlTSn9TlWPepwC1Qg2tglupZOgicX+JPWJbkc83Bq01I3Y4OgM6neN0j/cWRrfHcgiaKRzk+oaiuIad/+1zY543qLcA1Mm67ztqFTZOk1ApsMX23n58SC60jUs3IdnxvWmo1+83TAgBSHEOdCapMFqju0kkBNcmzIUOvRPnWq2rUy8Zui9zSQDJs3ahchoDarvyRUwLkqfXZ5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(47076005)(81166007)(508600001)(316002)(336012)(36860700001)(356005)(40460700003)(6916009)(86362001)(70586007)(7696005)(70206006)(44832011)(83380400001)(186003)(82310400004)(1076003)(16526019)(6666004)(4326008)(54906003)(8676002)(2906002)(5660300002)(2616005)(36756003)(8936002)(26005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 20:53:26.5542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f86ccef0-051c-4b5d-6388-08d9eda08d08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Tom StDenis <tom.stdenis@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Version 2, this version, integrates community feedback.
Version 1, adds sysfs tear-down on rmmod.

Show IP discovery in sysfs. See the commit message for the layout
format.

For instance, on a Sienna Cichlid, the layout looks like this:

$tree /sys/class/drm/card0/device/ip_discovery/
/sys/class/drm/card0/device/ip_discovery/
└── die
    └── 0
        ├── 1
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 108
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 11
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 12
        │   ├── 0
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   └── 1
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 128
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 150
        │   ├── 0
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 1
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 2
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 3
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 4
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 5
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 6
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   └── 7
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 170
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 200
        │   ├── 0
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   └── 1
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 255
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 271
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 3
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 34
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 35
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 36
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 37
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 4
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 40
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 41
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 42
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 43
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 46
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 47
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 49
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 5
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 6
        │   ├── 0
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 1
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 2
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 3
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 4
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 5
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 6
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 7
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 8
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   └── 9
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 66
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 68
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 69
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 70
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 80
        │   ├── 0
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 1
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 2
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 3
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   └── 4
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── ATHUB -> 35
        ├── CLKA -> 6
        ├── CLKB -> 47
        ├── DBGU_NBIO -> 36
        ├── DF -> 46
        ├── DFX -> 37
        ├── DFX_DAP -> 49
        ├── DMU -> 271
        ├── FUSE -> 5
        ├── GC -> 11
        ├── HDP -> 41
        ├── MMHUB -> 34
        ├── MP0 -> 255
        ├── MP1 -> 1
        ├── NBIF -> 108
        ├── num_ips
        ├── OSSSYS -> 40
        ├── PCIE -> 70
        ├── PCS -> 80
        ├── SDMA0 -> 42
        ├── SDMA1 -> 43
        ├── SDMA2 -> 68
        ├── SDMA3 -> 69
        ├── SMUIO -> 4
        ├── SYSTEMHUB -> 128
        ├── THM -> 3
        ├── UMC -> 150
        ├── USB -> 170
        ├── UVD -> 12
        ├── WAFLC -> 66
        └── XGMI -> 200

114 directories, 365 files
$_

"num_ips" shows the total number of IPs, as this count exists by the
same name in the binary data.

Typycal contents of IP attributes is,

$head /sys/class/drm/card0/device/ip_discovery/die/0/DMU/0/*
==> /sys/class/drm/card0/device/ip_discovery/die/0/DMU/0/base_addr <==
0x00000012
0x000000C0
0x000034C0
0x00009000
0x02403C00

==> /sys/class/drm/card0/device/ip_discovery/die/0/DMU/0/hw_id <==
271

==> /sys/class/drm/card0/device/ip_discovery/die/0/DMU/0/major <==
3

==> /sys/class/drm/card0/device/ip_discovery/die/0/DMU/0/minor <==
0

==> /sys/class/drm/card0/device/ip_discovery/die/0/DMU/0/num_base_addresses <==
5

==> /sys/class/drm/card0/device/ip_discovery/die/0/DMU/0/num_instance <==
0

==> /sys/class/drm/card0/device/ip_discovery/die/0/DMU/0/revision <==
0
$_

Luben Tuikov (1):
  drm/amdgpu: Show IP discovery in sysfs

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Tom StDenis <tom.stdenis@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 493 ++++++++++++++++++
 2 files changed, 497 insertions(+)


base-commit: 5c0feae0fd9dc4095b4fae81a82932597b36a760
-- 
2.35.0.3.gb23dac905b

