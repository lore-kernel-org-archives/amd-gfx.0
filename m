Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5C9C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 05:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AC2010E075;
	Wed, 20 Dec 2023 05:13:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 143D810E075
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 05:13:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rzrmk6V/WCG0TdKnaRj9lJhj7xE1S6vdeiSwbNs4JfFWURGk/vsCXQwpVxo6h9b87fJEwdSa8Dm3/dhFEv4mfGInDxssTJrLoZHJVDWbWwd6uDSf5GH5uX6JSgZDqZTafm/6XJoFnO7YKdW5uGGkmADaW1uxwDxbxil6OS+Ufp3vqy8wBs5ShKKhNvObK1+Cz0s3Vd5Rw8Y8YE4bsivnuEvu45HhzbLevYGHa18g0POaIUCTrhIIvUnzGKG9Z4ZOu4eIRRG0yUpoq4dBU0Ll1gm0bVn4K1I5jNONvcBanNW4ZItk+lss0Bta3HOfx/Zpofn0u2h4077eb99XOAGGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRRDyWSs64TiNMbCrStpba7C3TZ4THYQ+K4KSiRZ2Ng=;
 b=KuZlXa1OSxNMfPw/tBNpRmWn9YLXWY0jwCVXZip8AOQNssmjjgG+dPS4M6wwB46zC785jfXFwZY00zAUENoPWf/LxrzIMDWWUvjTeEy5rUAmdaEKhJ7TB60odxBDX3JPcHeJFzVRAF6QqIgS8Uh5uzTsZTEfxkBORsJV0H1epa+9RTTcjG/Unlacw5BoO04/Q3zrsqsa7rxh1cb3PPqZe+c6o4O5Zm4GfOU2bBFF8ihPrT88dqR7JJAzQI9hxSDDPAWbldziRza/nN26cJOvbICd8j6tyd/FS+OUqNTGqZ3Qu8f85tj8mqjZzePqzcVLQUXUhazU4YXmtAbhv+53Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRRDyWSs64TiNMbCrStpba7C3TZ4THYQ+K4KSiRZ2Ng=;
 b=kGp2Q2y5a61eTBm/i1Q1YuCODcsWcJMv1lGx5IYVEfHEuyqoAEp2mpP/Ou1a88ERMF8JGlUlTiC7EksXDBOgUHXMj192QkhDtslkjEo/EE42NK0yklQ4m8LacwDaRFHgtKE7RSwkf7HlQ+vDK1GDoQA3VvpC0B/MGTXgXCQxJFE=
Received: from CY5PR15CA0140.namprd15.prod.outlook.com (2603:10b6:930:67::10)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 05:13:06 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:67:cafe::4) by CY5PR15CA0140.outlook.office365.com
 (2603:10b6:930:67::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 05:13:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 05:13:06 +0000
Received: from amd-mlse-mangesh.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 19 Dec
 2023 23:13:03 -0600
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Lijo.Lazar@amd.com>
Subject: [PATCH v4] drm/amdgpu : Add register read/write debugfs support for
 AID's
Date: Wed, 20 Dec 2023 13:12:34 +0800
Message-ID: <20231220051234.2234962-1-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: 284fe28d-77dd-466a-1ec0-08dc011a598d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mWAUwCjS6QBp4Q7Zdf95iFtRPvNfZy3lTJouAOwnqV4MP3GU887XVkVle2yRvKT4T6N6dB/fNBycaz4kJQ4i9Tz7F/0Q9Xz3zedHaU74B/PsIQLfYbAp7Q0s5UAP8k0N+Qn47QVxRVsLgAdBPZ/+0gdMOUIMdhXAl3UKF6CMY948cdUkkea/kmkRCBijj4oQeihPVptPKzW400wDWNfasemL+j7H57BfJcp6G2flWKwuoPpLfrTUOQ2vtHAn6rJ+/PrF4kZuouAxh8v902En7t5GTnFXzR0gftaWYwJp2cTmL/o2OqDBSknlUJWuaSU+nCHVvAPI6ggu/0R5//DpQrcxiV7MHEQorIjYOd6GzC84Thmw8g2Qt4dy6LVfWjPpuPfG/xs8+bqerGavHMzTIqXF8Xxe6yTefCYKWumTaKdNQ9depZ8LCNba3tS1RwdyjyMFOdxOjAIlX6byVq+EbiWwYcxI1LFOYOfILGwKbfrZ83VvRXwSCZDHR+RdY8aLqu5ZAHxbuN1L0QGlCR9iph5FSHXTU7ZufHhPFEVEuE2elrFGgtmTLYQQ6nMq+ZiHwnpZl3fC/34BHgQo2w9FkVknGiitYsqgAATKpZVuBoQwWd1yAfvMmNoIdyB5GvZWAV64H9WcV6nQg8b81pykCcI19E7smuy984QmJHEEnmofz974FgHazi6dkD8C21NCt930IrQb9YijN56gPbqsdMm68B/fCsBTrsv/N6Va+P5xzRs8q7qWlx4BHQrIYBf0Oqr724WzW0LO/XlAdpro+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(82740400003)(40480700001)(36756003)(81166007)(356005)(86362001)(40460700003)(7696005)(6666004)(70586007)(478600001)(41300700001)(6636002)(54906003)(70206006)(336012)(26005)(16526019)(2616005)(47076005)(426003)(83380400001)(66574015)(1076003)(2906002)(110136005)(5660300002)(36860700001)(316002)(8936002)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 05:13:06.1872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 284fe28d-77dd-466a-1ec0-08dc011a598d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364
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
Cc: Mangesh Gadre <Mangesh.Gadre@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMN address is larger than 32 bits for registers on different AID's
Updating existing interface to support access to such registers.

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
v2 : Adding hardware family check for creating
     debugfs interface for PCIe register access
v3 : Instead of creating new debugfs interface,now using
     existing interface with address range check for
     call to appropriate interface (Lijo)
v4 : Using available helper instead of explicit right 
     shift operations (Christian)


 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 96d634bfa448..391af8060704 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -559,7 +559,11 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struct file *f, char __user *buf,
 	while (size) {
 		uint32_t value;
 
-		value = RREG32_PCIE(*pos);
+		if (upper_32_bits(*pos))
+			value = RREG32_PCIE_EXT(*pos);
+		else
+			value = RREG32_PCIE(*pos);
+
 		r = put_user(value, (uint32_t *)buf);
 		if (r)
 			goto out;
@@ -619,7 +623,10 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(struct file *f, const char __user
 		if (r)
 			goto out;
 
-		WREG32_PCIE(*pos, value);
+		if (upper_32_bits(*pos))
+			WREG32_PCIE_EXT(*pos, value);
+		else
+			WREG32_PCIE(*pos, value);
 
 		result += 4;
 		buf += 4;
-- 
2.34.1

