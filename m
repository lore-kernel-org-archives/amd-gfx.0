Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57B9EE7FF4
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Sep 2023 13:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CA8210E2FE;
	Mon, 11 Sep 2023 13:44:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1812F10E2FE
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Sep 2023 13:44:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAENtNXkwDdiqUuHyHxrak1YlqHZF9qaX+EE2CZUyHDKCSHR9foWoi4k6+lb5OtKXa/+79TXJb2k14wZjRIdgDUK9GEklgkSnFXZZi0x5YwC3nUG9S3PysNY6cN0FhuUZstSgvkJMBZeJtlDRmikhy5E6bHyxJfJUumY+7RNvSy7tPAfizbJ+r08xkH4OeD1F3LYPojOafZhT1o1KfrJIKJohw2XjIU7LYwtTxGqAlXuH9OQEV9Q69eqekpHOR9GaeqlT4wSitoJmBhdv20RIvchLyETcl4RZa1ILiAfNLoCHQUQWVYOe1YCrqI4kFyF1NB5+bL1Jfn8YxaQnGFZDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4j2yTl67F+91TwIT5S+uY+2N+7vqYtsWxgbHEWzjis=;
 b=LPwrjmlk4EOt1LGeW86qTr8oOYAvolqUWhsp0hdkTYYqGI6R7ldZDZFw7/iUCUke0o2SKZB+M0BDD1njoVAgyDtsHs94ZryZ20SLQDeE9rldAHQM03//YZae8r+8Yi9nVYbsqruvR9ngXr7hM1l4SydQjvXPqAt2oYHkQEbIsXEFYXwjwEeayzVQv2ta/uLunsZjW9On6o1I9nwS6YtBG/wvxHWT+Eq2hT9UdD64vvhRKl12ZKnvWjy9o/04Wv5Jz2CXmp/0jzZNmOzn0bWH4RzXTP2LL8gesDqHsRopFJGV+xfcMZiG29QM5RdyqMYM6LS0KRh+2FpGRp27BW8XbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4j2yTl67F+91TwIT5S+uY+2N+7vqYtsWxgbHEWzjis=;
 b=AxV4LHHH1La+WhkbflASHyF9VSvIBc0sPzCePhNkgBtvttlXegnw2pnyCP0aJUh2m2imU8RziadPydpvXfI+B9lMXMVH8irqVApbKB6HdQdzOa01EyzgmfnetfEx0hSWfpVaVSyWp45e5v2KKd3qZezoXeDAS5ZE8gNoHQnqGgE=
Received: from MW2PR2101CA0002.namprd21.prod.outlook.com (2603:10b6:302:1::15)
 by DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.35; Mon, 11 Sep 2023 13:44:22 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:302:1:cafe::fa) by MW2PR2101CA0002.outlook.office365.com
 (2603:10b6:302:1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.4 via Frontend
 Transport; Mon, 11 Sep 2023 13:44:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.16 via Frontend Transport; Mon, 11 Sep 2023 13:44:22 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 08:44:20 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Handle null atom context in VBIOS info ioctl
Date: Mon, 11 Sep 2023 09:44:03 -0400
Message-ID: <20230911134403.511233-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|DM8PR12MB5445:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b1f414a-e833-40b6-8d70-08dbb2cd34a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lHjovfgeyHcYxw4VCcEqretSMGhPsrCrpFQwPv8hrzoUaibl4h5ROMHs8L9fTZ5Or5A3SDWyWyv0s+iog3VbjPlKQWGW9g2SVzIAcW82OVGL16oqaOdCw16M3QZz2M4ymZeuOymBGP5YKBOPlL3EJ7UCg7Q5afvrLRG5hfXZDjDb8e9Trvy6jxTqPQW5XUZVbnPCwvYEj4dVb0KcY3qOreI8q8VDERALBsiHjJauri8T8Jeo1mV1vVoOgp+g8f5DC9zOAGNw0sxCo4ocgFnBVqrb6vF3jxItZG/e6DiheYn+Uv0JxR4Tpry/bWa15yYLrQkLy3BpBvC+J5ihuEKK753ETHXm+B9opGs486z9Sv/SScHp5uhDge/zTTTt+BbNOn38bWud4iHx3oTb8wtweAEuaD14zR7Izw4j5P43vZ9Zp6ab973WWrDO5KmNLjSwanq8er5QonYIXAGcisgTs243aIZ0DOyuRdkaTMAYn+ic5c123VrbMwZyE3NWi8QZGbmQT118CYHqHRibI7m++g70Xmrq/bVhUkCcuXmDeGbrIedjwtxUaAuLzMnndbMPc3cDlO57MuWBzZS77YDfPrS9BBvdbxyob/q6Bk4wyrHVDzlw9gt6KEPDrY+itXH3tgWExjbMGNsJCLTC1acN3vwRfR1czU/hFefGmwvMjjyVJCyTB0i4O8Y9lskqIVp2LLFBUBbFzhPj9dMYUjZcregFwv6UXVe6jkPmBw/JyY6gsX9jZA1LTnJtGL1mliGFqqLlYfT/4zJNdSwsb2pNwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199024)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(81166007)(7696005)(6666004)(41300700001)(356005)(36756003)(40460700003)(86362001)(40480700001)(82740400003)(36860700001)(47076005)(1076003)(2616005)(336012)(2906002)(16526019)(426003)(83380400001)(478600001)(316002)(70586007)(70206006)(8676002)(8936002)(4326008)(5660300002)(26005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 13:44:22.2890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1f414a-e833-40b6-8d70-08dbb2cd34a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5445
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
Cc: David Francis <David.Francis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On some APU systems, there is no atom context and so the
atom_context struct is null.

Add a check to the VBIOS_INFO branch of amdgpu_info_ioctl
to handle this case, returning all zeroes.

v2: Maintain current use of {} initialization.

Signed-off-by: David Francis <David.Francis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d462b36adf4b..a74ea53899f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -951,12 +951,17 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			struct atom_context *atom_context;
 
 			atom_context = adev->mode_info.atom_context;
-			memcpy(vbios_info.name, atom_context->name, sizeof(atom_context->name));
-			memcpy(vbios_info.vbios_pn, atom_context->vbios_pn, sizeof(atom_context->vbios_pn));
-			vbios_info.version = atom_context->version;
-			memcpy(vbios_info.vbios_ver_str, atom_context->vbios_ver_str,
-						sizeof(atom_context->vbios_ver_str));
-			memcpy(vbios_info.date, atom_context->date, sizeof(atom_context->date));
+			if (atom_context) {
+				memcpy(vbios_info.name, atom_context->name,
+				       sizeof(atom_context->name));
+				memcpy(vbios_info.vbios_pn, atom_context->vbios_pn,
+				       sizeof(atom_context->vbios_pn));
+				vbios_info.version = atom_context->version;
+				memcpy(vbios_info.vbios_ver_str, atom_context->vbios_ver_str,
+				       sizeof(atom_context->vbios_ver_str));
+				memcpy(vbios_info.date, atom_context->date,
+				       sizeof(atom_context->date));
+			}
 
 			return copy_to_user(out, &vbios_info,
 						min((size_t)size, sizeof(vbios_info))) ? -EFAULT : 0;
-- 
2.34.1

