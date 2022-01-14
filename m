Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FA6C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 01:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D202510EAEF;
	Fri, 14 Jan 2022 01:37:41 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2072.outbound.protection.outlook.com [40.107.96.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F235510EAEF
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 01:37:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjVyt9qTVFrkuqccEG1WUyM06WLsikbiQ2GhNzeqAJyxNYJOKjgeNRNdhFMUZn1JtsohM4jpZPAAXiescqLnBnxIFGpKFBq6I/Sm/sxs9BZEkqGQ5cb8QfH9/i/CqymMjsZaXqLhPk0iqhx3W6R+ynKELee6MLfV2d2HORD1wggNo7NT3OWNLdPDWNuBAEAKSBsUPgRd6Ksc2hnLXp0Cx0E68TzdtMecDHx8j9vhHu3D0z51mXFNN4nUqrk6/ciIeHaYbCwBKLZhNpVx09/cPD3MLw4fUfOLiNJWWsm3ylyjdC62w1li2NWYhHSVKRi+DoFR3LE+e5RPidDq9OipeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GztqEsXjaacaRIwfa75TZg+TccGi7h1sHYfBC+5IWHE=;
 b=Tjn3x6ykxdqemnRlE9vF/6xGYxHrTAcA391snaiIrlC22u2OJA3Y/uE7x5BfaNvEOAUZXpArIx/E7btBdDw0c3zAmgw9rmj/W/O6xrNS+ddNHujfN91Db8Hr/jmTAwu/1oAE40VgFFBhbVQv7BuIxdlTJP/SYJdzcqxh+eE5Oui5iOlwQwQ4MTDCbtvx9f8WCChD02O+0v9nGqCY0QBIXxDUF4Hor9wBPMRgX48ty/YyPhTzj4csir9Nya3ZY075/w64xQPV1ejocyFZnBkprDREpRFk/LU8gInVSjwgxMjYuVkOiyzdT1SE+XdXm3sayG40mWNesC+Rsc9lzW/Mkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GztqEsXjaacaRIwfa75TZg+TccGi7h1sHYfBC+5IWHE=;
 b=KhkdTQd3lB001TnZW/OEkW1phBfXrLOk8bjl6NBhT+PQFBH1qCXtmSvPYrJUE0Odi9WqF7Yi/iL3Nkgvt8iVk6wXaZWmAdsK4iYn3IN/uW9KMTjfg7NuV03r/87u33NnVPsm/Y035LL9hlNV6Hbuczna0Q9p/BcFuKR2gewersc=
Received: from BN7PR02CA0007.namprd02.prod.outlook.com (2603:10b6:408:20::20)
 by CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Fri, 14 Jan
 2022 01:37:38 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::d5) by BN7PR02CA0007.outlook.office365.com
 (2603:10b6:408:20::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11 via Frontend
 Transport; Fri, 14 Jan 2022 01:37:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 01:37:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 19:37:36 -0600
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17
 via Frontend Transport; Thu, 13 Jan 2022 19:37:32 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/13] drm/amd/display: 3.2.168
Date: Fri, 14 Jan 2022 09:36:49 +0800
Message-ID: <20220114013657.3119627-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114013657.3119627-1-Wayne.Lin@amd.com>
References: <20220114013657.3119627-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1785f6f-b8fa-43a5-735a-08d9d6fe722f
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5444578F0C5B7837F1D91C48FC549@CO6PR12MB5444.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MLYO/UgNDMr59APY0o5X0D8i3zd27UPvxiykKaRUucHbQTVKFip/fQZYIfbCDopQFfGCwNfmvS0FenslMkR08xq54EMzqiyntG5tai9SS/UTiJ7v7NiLm8IH1ZduZQCqWKWWxMbI0s/HSi15vfbKWSNuM7aHnpjikvI4j02bc0EEyPq1ZrKLHFFc2CG6Hfe4MGYsSzs+YNQgRppvZqZyFL7sWldTxCdZ62wSyrU5ELamkAih1zG1JxMc0vW2RAPV3Z9CvC5myqkRPjxwC7wBvjDm9lwaBVXo9PHuPqi7ilqCvm/6FKDKEGmZg9s3cHezX5/1aw7yS3hLUSZ+OaEU13qHfeagFCqHBA64veAesHfoiEKKdnvlYixfTVZUT6vl/61QPPU8GosgxiUlrbPB8i/bflmgZVFJzwFgOp+QqXMXnbabUyU5swVE7gZ6pTJJtpZHUqQIEMumxBVvgU2RKnH2QluQ+cYOVih+bTy51veXUozVz24elxn59eaj9nv/yINeedytmi4QlH/pO/RjFeF+0YxvbkfhmPiobeZFzbDm4tT0rtecQsV8uXG90XHtHlOGLNtbb8S/zLUjU0TD3yC99hkCik3f0lMgKTF377x1Lq8rKbVt82bOVst2+ECg197lzlwNiOqFF97IkBuKdPjYDfvQbB9dQW9JTgZrGrpF4aDEgApzxy4PqDaYwWih/4uehWSvLj4aMeJ1HlsCI4PkQhHFfqOXCe3ZTrONIIB3u+cRaGqN84mQwZK5BOr5v1tKcwoTHc4inG5fh/PW256N0s4MC+vZxh1DZjHSo8Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(26005)(40460700001)(6666004)(8676002)(8936002)(47076005)(82310400004)(70206006)(356005)(83380400001)(70586007)(186003)(36860700001)(1076003)(4744005)(36756003)(86362001)(81166007)(2906002)(54906003)(5660300002)(2616005)(426003)(508600001)(4326008)(316002)(7696005)(6916009)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 01:37:37.4916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1785f6f-b8fa-43a5-735a-08d9d6fe722f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5444
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings improvements in the following:

- Fix problem observed while assigning link encoder
- Constrain seamless boot on eDP only
- Improve Z9 interface

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b5e15da29017..1c6728cf2d49 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.167"
+#define DC_VER "3.2.168"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

