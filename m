Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833F3C433C1
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F2BB61A28
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 22:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2BB61A28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02E546F4CC;
	Fri, 26 Mar 2021 22:06:30 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680052.outbound.protection.outlook.com [40.107.68.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA4266F4C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 22:06:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sc8NVE0iHudqnUHP4lBztPyKVnmfF+0QDzn/BTQ/XbdjNBCE8GvkRXb22HhokdcBf4Hp0gsOm3DDeG8l3/fhy1lN2H3Ku6/aKSc2WczKlMBfjyyhCtHi98/yaU72GHGESlwm+K+NVf3AVHq4vK6cFNOAwmTOwSX5UMKL88CGg+P/kFspyEgVBrzQ7Z4pv2RbB0z6BjxwYfPUOqcaJDqXwSlPo7X5IJsHZ3ByTB8bSzFRAnEL6fqV7ALZp4T5I7Syf7s6GbWgx+C44IEpX9eGo01dREZgM7l+49eCz46/FAMJH0833aeeJ4slksRt0ul7+/LjmMgkGD0y9UJbCVHbLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X34mqAtUrI3V9W3irD9sRYZFDZ3msR9jC8DQya5JPYo=;
 b=S+6Bamv3vpC+ZhyQvNdoINy1+UJsUP7AISfXy6cO6JNxJjuBwZsgg2xZ4yUzeUkGbfdpRXrcfzjE2kxuSkP9ePAtxd5dV9bQraWETYpJ/uN2oPp9oF6wI5DkTnsgpJVkFCcsbrKnN44LCEMxfHLE3VCOsAstkOGUA5M5DzJwyCpUqCktqOekMI4vRdw6+svZVbyQppY8dTOtm7uUWWB94LGu2OWQYU+QUJV8RJXZvZy3mdj9NPzpa4I2LfIuRpVJO4rrUmySDG0AfdFHDmJ15IwYHHFk7gr9txA4tzePlfe/dNzpnQ+QRnyWcZhIq+Jmq5gF9dDAQn1NmBBK1kijAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X34mqAtUrI3V9W3irD9sRYZFDZ3msR9jC8DQya5JPYo=;
 b=ajVafeR5kMyd++lnHV31/wT+C9C3BnNJHq2kyBBMM/cka04tYv2TdJ22YxE6DONGxBrgoFjNPsVikabtrrOP+xrkaqIlyIv+L8NwzavYzgKJarAIKOCgZF6f06D6To/OAcWaIrN4eFlHaH0D7OWClW1BaTzqqX0v7Oic421Uz4w=
Received: from DM6PR13CA0045.namprd13.prod.outlook.com (2603:10b6:5:134::22)
 by DM5PR1201MB0188.namprd12.prod.outlook.com (2603:10b6:4:56::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Fri, 26 Mar
 2021 22:06:25 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::2d) by DM6PR13CA0045.outlook.office365.com
 (2603:10b6:5:134::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.16 via Frontend
 Transport; Fri, 26 Mar 2021 22:06:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Fri, 26 Mar 2021 22:06:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:06:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:06:24 -0500
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 26 Mar 2021 17:06:23 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/21] drm/amd/display: [FW Promotion] Release 0.0.58
Date: Fri, 26 Mar 2021 18:05:32 -0400
Message-ID: <20210326220534.918023-20-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326220534.918023-1-Anson.Jacob@amd.com>
References: <20210326220534.918023-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5933745a-3c9e-4e26-95ce-08d8f0a365f7
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0188:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01881B5EE986F9ADACA5B005EB619@DM5PR1201MB0188.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bwltpLA3qJmBHcZ6rnSVVOckHBYvg0bV8r7HZzGLs9XOCfuv3te1A0Q4y/lecrXldZiqpuHICRA9n+4/+MuPb8k20M/ft0eH8cSi1dp7HsGsCmVGvDsknMCjfg8jC7d7kUzpPPOCznsOV7tUQmL4dD7LAd8YROwZTr7yhBFw9yoKZKtWReuu+1G2d/CfbAhl2tC9Yz6VFkzH4OMymrInT98dgAZ4KTN8+WK4eLA7QqxJEIc/sqArW9fjNFEYOplPADmfvAHVxsCJ3z/JVJmxvonajXLDrUu8/UpTL9fOLhlExsa5WYdsMxRGdCbjNlnVRaUieme2+PuoZC0TBJR3VL/b/XSI4fQgSnlNPsqItmvFgtDdu/yf8jinG0pZZ5DomfCDYC33V1uz03osRMysgiPRMNPa5wFAo+VIxN6K+Ednb314/O246t4uqHHmbzD9CQyaRryT4+q685Ljv65a7dgl55bhqmAfZwwb83+Hef3Fh2z4oHvsmJcSqeB1f4q7D7T0zP/UYQ5+3VjGq/LhuQTdldUgBCT1OcUqyaCl6DZrCkgrxZM3SaxTE7v/X3tgnzAddaxy4dZ+oXjShBoqMNHGsa2ALEKOqFuXnzQpVYKWfAwbyxNPF70Q4nln2wsUzVIOCzfbT2uwmhXhI/tAqQWN/tCEhP6VrCB7wgqCKPWhQOeqWQ1SzUvgbDlPSffs
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(36840700001)(46966006)(70586007)(336012)(70206006)(86362001)(7696005)(6916009)(8936002)(2616005)(26005)(5660300002)(426003)(186003)(4744005)(8676002)(82310400003)(54906003)(1076003)(6666004)(4326008)(478600001)(2906002)(356005)(36860700001)(316002)(47076005)(36756003)(82740400003)(83380400001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 22:06:25.3105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5933745a-3c9e-4e26-95ce-08d8f0a365f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0188
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 2d23462f4980..c5776a55e2a5 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x899019e5c
+#define DMUB_FW_VERSION_GIT_HASH 0x8bb402f5a
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 57
+#define DMUB_FW_VERSION_REVISION 58
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
