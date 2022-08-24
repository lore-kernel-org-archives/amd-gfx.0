Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7089C28D13
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 07:36:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2351714A11A;
	Thu, 25 Aug 2022 07:35:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3759C14B932
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 07:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXQ8SvEnp5HCtc3GFyH1XORdieJ7aSnEuGsCij10vBsWVa71Ey7xgAXY6jPuVHt71ipmPTu7yoopZ7BIAtf8VbIu22+oc1jrHZWFFLqlfcoQz8ED386c1NJh9Ci4n9oGleEFO528d0fSG6b3+GHp8IanKlOFGdNoBe9nKxj5i2Z376M0J/w7wVS7hY3LpD5BBgS8xEcH/nt7yUsqlpu9wjZA5Qgf5WrMMA0nPF82uu/4mYu/IcvIRGBMViHyPKPS15gkhtmgj+ZOdcrFE6j/TkDXtFGRtgzAMaUVoxs6LQi6pfm5xF/irhvPdSymTGTfMry0J9iqpZWGRW123AG5TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hllzuCtfOFLlLqZ1EAFrTL3M0kd3zJjtTKSZX9sr05Y=;
 b=Jeso13Rt0e54Qw/DOIfH9aT9HxV5tcrU3ChiAZQ+erriP6z3U4iRuI5uDhBmJvMtMxGm3N86InaFnesy21MitBITEdyVPJ9mFmyB0KhU0IrHplTYmQUu54W4h5jQvBQy7N5NGRqngAJQ/th7d8v8fMpNYU7MXzcrdttsDRBeDo1ouP2yInJu7JuyLO7KYzjVWk/guiM9Iqf4XvU0vnW1WerhVf9DiY2dqMA3hLxV/3phSub2pg8CWByWNsbfFepol6EDhbium+FbCRLyT0ZFt2H6sgtC5jLg5bdmag6SS6xg6mJls/iVi7q2IbIwvGKVIDZicqgEQehVI5xAIUAG2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hllzuCtfOFLlLqZ1EAFrTL3M0kd3zJjtTKSZX9sr05Y=;
 b=LWBcgirmzJW452GvVVUKsjzfrcCmcKJjYpQWM4en5sKymGWWC/B4bis6Hfw0VOocDCf81iwyUDnFa0ZWyBXbxmM61hinWEm6N1Creq32Oa4RtFVNWNO+6NVyj3V5wEZDdZmTS1CH9qYF9E05W3C7A4bwTBhN7kxw6jb6Wr7Is2w=
Received: from MW2PR16CA0032.namprd16.prod.outlook.com (2603:10b6:907::45) by
 BN8PR12MB2979.namprd12.prod.outlook.com (2603:10b6:408:66::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.18; Wed, 24 Aug 2022 20:01:50 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::84) by MW2PR16CA0032.outlook.office365.com
 (2603:10b6:907::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Wed, 24 Aug 2022 20:01:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Wed, 24 Aug 2022 20:01:49 +0000
Received: from magnus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 24 Aug
 2022 15:01:48 -0500
From: Daniel Phillips <daniel.phillips@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/2] Use kfd_lock/unlock_pdd helpers
Date: Wed, 24 Aug 2022 13:01:30 -0700
Message-ID: <20220824200132.116030-1-daniel.phillips@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9e68dd6-301d-41be-3a11-08da860b7b80
X-MS-TrafficTypeDiagnostic: BN8PR12MB2979:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kcKglwe5N+u7hc1NwJvxGs8rtkQUmIaaIWMRLS3r63uqEGGYC3SyobRFv8sJKrPgtic6AUa4ITWGfoTnt1UpHXAwiArwJyI0EsWhYvE75WpPyPglyFpOMwhDHpCCQNFKK094TD1ze6DKan8IVKPt/GdUpCGsB2eaBINdZaR4TE7MDEMTb3NYtUVzCA31WNAzGPsdvYumkBTHEa/YYR1wZDQq1k9Tpwk9rQewNvj4SL//q9bRcrWmTDtn5waA9HOI9J1R1RmKsyDzlCDhq6ewZ3MiBAn+iIIwzyBEYswnTKuFVE9Zym5/Ho1IHUxjyXTQG+5R8a3YAfTWjQQzaXBkdjyENhmDSAsXAvykfX8/7Ptx9bXOP1jX1LHqLuRFBupb6O1j2XGSD23u8phrEWDO+CXLUsykjT82bd0QjVKtBW3mrgTHXpbe8cBQgib2SHwpPiP6yB9P9P6mqgPoUOKKMh0ar/p9xAxDEmtbz5WmRrEOXUt2MAj6NkjatH0J98xBfMy/QSIhi511cIZqoKuhvZHPsOntIm/Quu8C/55udPfKtclqk19Qec0Z0Mo2AVMvGfmwU3z1kaGjrGREl2567TlBl2hcUF5BjhV562dVlSmvJeoCIo9kzQO1vKAxpbosYwl4MyK6OONYqQTpLjcTE0YLanhDVO6C/ra7gGF4+FQ84eiPjMtJuAot945gvNBwppoB/PykKvxiwKi6CAgItZ1FCHnrLIuv3ak5CBXueMYc1lgXEhsGt5bJ+qd2hjlDUI86xKwdExDEEWa216yDfxvqdaH0NioUnB8Ti9y7R1otJ5zNHBYUOmikJfRWVSdF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(136003)(36840700001)(46966006)(40470700004)(316002)(6916009)(44832011)(70586007)(8676002)(4326008)(54906003)(47076005)(82310400005)(40480700001)(70206006)(5660300002)(8936002)(40460700003)(2906002)(4744005)(82740400003)(81166007)(356005)(86362001)(36756003)(41300700001)(186003)(83380400001)(478600001)(2616005)(1076003)(336012)(426003)(26005)(16526019)(6666004)(7696005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 20:01:49.7984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e68dd6-301d-41be-3a11-08da860b7b80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2979
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
Cc: Daniel Phillips <daniel.phillips@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Patch 1 adds kfd_lock_pdd_by_id and patch 2 adds kfd_unlock_pdd helpers,
broken out this way to reduce noise in the first patch, which is a bit
tricky because of modifying a lot of error paths. Patch 2 is trivial.

Daniel Phillips (2):
  drm/amdgpu: Use kfd_lock_pdd_by_id helper in more places
  drm/amdgpu: Use kfd_unlock_pdd helper

 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 130 +++++++++--------------
 1 file changed, 48 insertions(+), 82 deletions(-)

-- 
2.35.1

