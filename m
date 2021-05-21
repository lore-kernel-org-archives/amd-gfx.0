Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23764C47076
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C659D61168
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C659D61168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EC6F6E517;
	Fri, 21 May 2021 17:37:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D2D96E802
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 17:36:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ma1zYwOHFQOGCSijLO7kx2XgWoAJZiJQxZf2esCNAKiJ5+P+rTSaav/Z8FSReJR9VRn3qLULKkVpowHt+NuOfX+8blLyDC/bN9st4CAFJg4sA2WUKAC5ELa/319dID+l+A3/7m7rTm2zLVMR/uUL/Dsmz3Jm5oPBgyrZRUeJqTEH1q3NnwKQ5txZF+0sw2oKT7oiadHaxXyWM2X+BmslX5A8gswH4CaDXFZHGocr56j/fl5UdATTVKm3HHXFljVVQ/3ramR1Yod+s4MU5POKOMJPkZ5yPYZoltNBBOBsVQjIwVHWnZfJMwI7ieULIP9HnPbnwXJyp0jM/ATMxzTJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvNkRSN/QjMwp9JujiU5ujEeZp3cSyK+r3YwiTabC84=;
 b=WHkQVvMq6xurrrZy7hE2F16qJwxClGT9QU7A0U6Zxhz9T/L6VyIYQoCAKAazpDva63pvQvFtuy4q3uwtHyul8TRGjkj7OhC7ocwAKNR9d1dxkUzvovaNBOVFEZCxn0ov8P/gaHNo97L3PaHrbhrfOiTOQ72hGV8f+VBo5xYhD+a1T+FTLej4HKK+qo4pqAMrjHm0V4sB3/oAMA7fPVBZhGTgdiOZbfAeJ20ZE90S2UMoWvk4olx4HlMWmcjN7PuYJYGmfapO6z5zaH+SPI8ulR9SfDuPRRLyuGlWjKzF8mimWSJsX07Lb7OAz6Hu6onR7ccoEqQh9SNuMXTbqsEwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvNkRSN/QjMwp9JujiU5ujEeZp3cSyK+r3YwiTabC84=;
 b=ertnMZVSd5/bfy5jazb3PiMgxWkM2bkTVkV++2buRFBRL2z8gKhU/WNxEppFVWRlyHPwC9jkOOdNGM407ztWEYy2lJj162rChCIw1TYcviK2jLYuXcIQ/F1B+VUL9y+x3Vd1u422mLttQUm9xZT2UgYWL8zOpj6CzYzdb7I3I9A=
Received: from BN6PR13CA0031.namprd13.prod.outlook.com (2603:10b6:404:13e::17)
 by SJ0PR12MB5408.namprd12.prod.outlook.com (2603:10b6:a03:305::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 21 May
 2021 17:36:57 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::f9) by BN6PR13CA0031.outlook.office365.com
 (2603:10b6:404:13e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend
 Transport; Fri, 21 May 2021 17:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 21 May 2021 17:36:57 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 21 May
 2021 12:36:56 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/15] DC Patches May 24th, 2021
Date: Fri, 21 May 2021 13:36:31 -0400
Message-ID: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2265db80-cee5-4c5f-7e89-08d91c7f083f
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5408:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB54086AB933925360FCF109E8FB299@SJ0PR12MB5408.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:155;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LcxEiOCuClNXot3iWhN2D2fkXwZJP5D6yxjxkVWl6woUJwgi8dWMAc22La1KGRFUUlckuQ5y53Zfo4skaNgWTzbkfvJqH3rqWGLu3zQsSU6rzDMz9cszYZjZ6dOjlc3eAYBkIQ++ufBHQEAeLICzpTUI65UuenQsbKjJC8F6q1U51kgs7GfaEomegC8rgedHyUTAYlqpen1gIjDtXt+BWI4p93K6VgEHovVFmbtypk3TeezXcg3h0ziE/4gVhigiVUkp73eyBYxyiTdrKlQeLv4+YcdSy1+fE2DG82b+ucWZeJzehwBVwpf7pWJqC6FTTRPoz1Q6qUShC/SAutWW24+WKeCB4yb5mT6w2QTPdYXOX7DaJ38E9Vi0i7I9s07tH61KC/NrP9iqaUfau0x5C54DBqN4RDSyKOG8i2WeymgKrkS87SzG5pPpwv+QLl8p7IfZeG7acNdTc4yX/cvUo1LUT5ncCkGOLuCOSWYrYd2Q5rzX8h6j30FqkzoQWVUxxcWLy7RIkuV+hksVpKzMiUm+9OhVNCN4/06vgh3Z+6eR7B4/AceWc66KXsc3UF7Fls0l9APzvJ9x/6krs9zoh/7xRog+8YAhIx8/rSxnhHShHFVbYfsEtY3ZOvMPYiDAOQ9F5h51qOLhIgBpYnarr0Mj7IAn4TlT8MQBk5FfwRU393VcaqOXivPEmYjbtZOo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(46966006)(36840700001)(6916009)(426003)(316002)(2616005)(86362001)(47076005)(6666004)(16526019)(186003)(54906003)(336012)(36860700001)(81166007)(82740400003)(44832011)(36756003)(26005)(356005)(82310400003)(83380400001)(70586007)(8676002)(4326008)(8936002)(70206006)(478600001)(5660300002)(1076003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 17:36:57.4009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2265db80-cee5-4c5f-7e89-08d91c7f083f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5408
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas.
In summary, we highlight:
    
  - DC 3.2.137
  - Updates on DP configurations and clock recovery API
  - Improvements on DSC, link training sequence, etc.
  - Fixes on memory leak, ODM scaling, etc.

---

Alvin Lee (1):
  drm/amd/display: Implement INBOX0 usage in driver

Aric Cyr (1):
  drm/amd/display: 3.2.137

Dmytro Laktyushkin (1):
  drm/amd/display: fix odm scaling

Fangzhi Zuo (3):
  drm/amd/display: Retrieve DSC Branch Decoder Caps
  drm/amd/display: Add Log for SST DSC Determination Policy
  drm/amd/display: Refactor SST DSC Determination Policy

Jake Wang (1):
  drm/amd/display: Added support for individual control for multiple
    back-light instances.

Jimmy Kizito (2):
  drm/amd/display: Update DP link configuration.
  drm/amd/display: Expand DP module clock recovery API.

Qingqing Zhuo (1):
  Revert "drm/amd/display: Refactor and add visual confirm for HW Flip
    Queue"

Roman Li (2):
  drm/amd/display: Remove redundant safeguards for dmub-srv destroy()
  drm/amd/display: Fix potential memory leak in DMUB hw_init

Wenjing Liu (2):
  drm/amd/display: add exit training mode and update channel coding in
    LT
  drm/amd/display: isolate 8b 10b link training sequence into its own
    function

hvanzyll (1):
  drm/amd/display: disable desktop VRR when using older flip model

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 138 +++--
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  10 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 307 ++++++----
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 568 +++++++-----------
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   9 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   2 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  19 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   3 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   5 -
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |  10 +-
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   8 +
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.h |   3 +
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c |  12 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  31 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   6 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   1 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c  |   5 -
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  28 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |   5 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   1 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  |   2 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  14 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   1 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   1 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |   2 +-
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |   1 -
 .../amd/display/dc/dml/display_mode_structs.h |   2 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |  13 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  66 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |   3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |   3 -
 .../gpu/drm/amd/display/dc/inc/hw/transform.h |   4 -
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   4 -
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   1 +
 .../amd/display/include/link_service_types.h  |   1 +
 .../amd/display/modules/freesync/freesync.c   |  29 +-
 .../amd/display/modules/power/power_helpers.c |  15 +-
 .../amd/display/modules/power/power_helpers.h |   3 +-
 39 files changed, 683 insertions(+), 655 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
