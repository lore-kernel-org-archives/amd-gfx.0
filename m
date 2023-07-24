Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AC5C001B0
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 14:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9298510E100;
	Mon, 24 Jul 2023 14:15:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC96610E100
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 14:15:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RC0sdT2KcdtDvboW6aMmOphBp5FBIQfDkIRuxUNeeOi3a7P1nnrSPyYeR4Dx6tdsjVb51fsau/hZIkh6ScGBTmTwNXJwYz+Ua1BW8MfFxhAvQSFqDsrv+ZVx2NyjXC+DyudO9QSpz4vP6EcZx8/opb20SFGAy7nPAwm1pO7ikkwGpYxMqmyUbtHfXvhnHvrvLa6yX55omZZdfbrx8xZrKTZNp/V0knxZjAPFiWUloVOfoYIH2RGB72IA8yESSiLdO1gU6q6RBnLAZkrgraw7efpC0udoGsNeDyWzUd+Ncn+5ejKJfNaU9Vi5vJcZF+QnLGwIIvEF1CyQjGRNf7XnRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WR6PaoQVcJDWAtei5DAaP+yBxekKbnL82ZIILtWhh4=;
 b=Pj+2NveYwTNCT63lzSP/vXmUHZBDLixLOW9ulYgHVYqfemrtcHBmh8NLxuhhzvPQ7JhvmAk2nehx3JrwKYrhvW6Fw3zJQ/01ICHcuaIxkhxjrCMUI2G1eu4bCbQZqS0uuxm7S4L/GgrYgV1ItfJjMT0nOvKVWza/k3eKdgnKRjGlVMT8FPDO8vAV7kattJ/SW2Ar9rbhDp2/qrmFsrjRfhd5boVQnZBskmaoNC+ErQAsmcpKRpIf0X8R5po4xKbRFS8F2Nol3Ez30BmM1seV0fGyS2+U7COvWbTxhbyFTrx+W8CjRxMeO4fkWLI5dJdxAfD1tsxC9JJ995JEH0PcWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WR6PaoQVcJDWAtei5DAaP+yBxekKbnL82ZIILtWhh4=;
 b=lUzz2TnRWCxkQvVHoSlrF7r9sHQC42XMIo1Ll8ASFvGBLSnl7zgaUS27gcvrrNe9WMK9WUS9Yz3xJ5FTkZGL7kkgqgD4eTQfELxTe4eevVSjXrz+MTDrbX0ZCN+ohJ2plo8tRNoQad4W1jdSUonblZg9OBys+h5gCbOR/rGmJI8=
Received: from MW4PR04CA0298.namprd04.prod.outlook.com (2603:10b6:303:89::33)
 by DS0PR12MB7583.namprd12.prod.outlook.com (2603:10b6:8:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Mon, 24 Jul
 2023 14:15:01 +0000
Received: from CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::d3) by MW4PR04CA0298.outlook.office365.com
 (2603:10b6:303:89::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Mon, 24 Jul 2023 14:15:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT074.mail.protection.outlook.com (10.13.174.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 14:15:01 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 09:15:00 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: 
Date: Mon, 24 Jul 2023 10:14:44 -0400
Message-ID: <20230724141445.2451975-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT074:EE_|DS0PR12MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: f0794729-2192-4c5b-c415-08db8c505e90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FRz0YnRB6+zJUQpSejFPLRMofTADBinHBoJKXc3x5WLxixR/cS9LJ+rI+LO8kz3CeqSs8fsMCwVDywGKR8tnRaiGahL+FlNiqAFQHWf6jJ4cIFZjuGfgF60q3zizXBZ0gSCpDgjye0utnA6oQoZoh8UW0Dt5oxkiVDMGjijf+IHPGemHw/CMkOXH42cFsBG1fq41tcIsfUxXQKZT9Uj8D//N5Z9KdcEKPZDeZE72QMP5TQTT+lT8qIp06jnVxeBgyWkPMudTiNeSlPLuDHSnh4dYBqAVwi1BtViA73N5X83e/tsop0CqwJJg1DRdwOiOhkz1leMv4gHYpRufA0yaDdltcaRBvXVCbwOCkAJCrP3CxBkUcYr7KWN8aVVg7os7ucWYOli6uRvfRwkXiA12O86IYGO1vtXmi2j++9DXjssGtfHdkw10rdtPVf8W1dUq8JBjbeHWfaY7yevF0Nxjt7ToFaLgIHZtOX69QEbWetteIiiUSZpBGBYJAGXpl18Q8TBslRmYrFPrFzI3Xb8l8Bes/jIRWSU1fDre53pFlknJL8rXye5sG4xrJy79B0MQ3c3MV0kXgh3duRvZg/gmmrRJFtoKAkEjp+N/9/GanplMHqQ274ZPJIKoxnxoQXpiMZxfl1meG2lCQxjkUkvOR/MLLYfkupOrTj25GHiH4UUkfc8ube3V0tijP64k/xnYi7OLHlYRpI23NETmp94pvMEtp3iakGR36L9OlmLVABTWJcg6c6ZfWCX5GjxrTjPcEWZXbr+0HmR/wK3HgKCh8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(40480700001)(6666004)(7696005)(81166007)(356005)(40460700003)(82740400003)(478600001)(5406001)(8936002)(5660300002)(36756003)(2906002)(558084003)(86362001)(6916009)(70206006)(70586007)(41300700001)(316002)(336012)(186003)(16526019)(1076003)(26005)(966005)(47076005)(2616005)(36860700001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 14:15:01.2062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0794729-2192-4c5b-c415-08db8c505e90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7583
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

This is in support of a RCCL change that requires specific
coherence behaviour.

Corresponding Thunk patch is at
https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface/pull/88


