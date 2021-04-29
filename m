Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F0EC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD8D6145D
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD8D6145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 377826ED7C;
	Thu, 29 Apr 2021 07:54:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEAEE6ED7C
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 07:54:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrRG/QlM5AoY0cpt9eM1VhoQ7jH0+aP++BDaVebf7Z4bn3iCdoXH9nA6sb5Fc8uqc334kBmyFSxMifADKnl1mGwnyEsclGIufptuYnIFKkJK7xn/SZMaleS+0SBr3DVQ6LXvYOa249HGgpctKu1QueyCCfhPca6G80fMqsRYpXIRdUsLl8dvWcEmR3fV8WrVmEk42kMpZl/o0qEeSN78yyhpqQcV2V/EYUzJGFgy7KO+7IiJuouXlLXmuJsiJUk+ZIzvYmysiND6+C23Gm9wIZGT781mkWMDFVlVfWWEdPp36bdS+CgzsoMbtiDryIfwl2j//YS8Ib3LToxWCIeTcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmDun9psR882tb6wiBDjblnij04G7ILpDw38q5yIBxU=;
 b=AU752usNIIJgdhDbHUUjE+F+qxq0xwQ/52GR59vFXWC4GrEPu3i4xqIa4Z8J+TIHarwA8nYtrOesrKFFDPp53ksKQLoPdIqz1jGPe6zcCtMa+x0/DnEwfjblNYsqJFeiEf94S4oN2Nb7Uow1mZAN/k23DxkgjyYlUrQIJqEw2QupjEkwdM8inEj4OAM8ZbFGm+Yi4PaB5YLD8BuCF6e5MbxzkyT2MqG5FGamAmjMI0Mlf/9V1GLqvzM8ggFeW0yQgB9dopxiQhUv2JJ17O3uPeWzAZUY3v1wcSQTprI+aQAMPQtaBkcTZr3wiw24jY+25nCTSTWv8QmIQO4SAIfc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmDun9psR882tb6wiBDjblnij04G7ILpDw38q5yIBxU=;
 b=QY2P2NplILivFApuaLh6xcYFhkd3aYmlJJDc7x9ao/6Jg3ngnEonvopzucXmrNM8UdCkeNKle4Vt17yqIAi/JO9qErPrdSQtoTf4RZOIHH9DgdtL5Z+dD8x4kzm8Gd3JvO0ovxq6Rbc1yQbi+GXehQ8rhedkn50de56j7koEK34=
Received: from BN8PR15CA0006.namprd15.prod.outlook.com (2603:10b6:408:c0::19)
 by DM6PR12MB4811.namprd12.prod.outlook.com (2603:10b6:5:1fb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 07:54:18 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::ba) by BN8PR15CA0006.outlook.office365.com
 (2603:10b6:408:c0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Thu, 29 Apr 2021 07:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.32 via Frontend Transport; Thu, 29 Apr 2021 07:54:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:17 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 29 Apr 2021 02:54:14 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/14] drm/amd/display: fix potential gpu reset deadlock
Date: Thu, 29 Apr 2021 15:51:55 +0800
Message-ID: <20210429075206.15974-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429075206.15974-1-Wayne.Lin@amd.com>
References: <20210429075206.15974-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4f14a46-dc22-4519-bb80-08d90ae3fdde
X-MS-TrafficTypeDiagnostic: DM6PR12MB4811:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4811C5D9DF5FDBA3F44E3627FC5F9@DM6PR12MB4811.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CpetnAsa24iRGBavK2IVw3tIC45yx8mHqjI9toq6ILNoVeNvfeDvZcPOxm2+FXE4Ey1V6WFyxyqRww9pE2hfwEC7HDj9TyoSnS1kMV3pZrLEK1az9HBb6yAHY2LU1SSY18Z8ZRjrchkk9qKPHRvRzi9t3fYjF4nx7G9gkoqwfEDMl2em7AgpIhAxCWswfuvfRbOfsAXF8H/wPit2FulAEJfyhJJENgeNjocUjWBli7sBAEJ97QFic9CN/OwMnGuonh9jZnPzF0qfySjovxAeurqtwWqFp2ylyQXAVCZgqUSQpHMkhjSsjKuQas4INHErXsQwOaCqPsWt7gOf2cikqpeWFawlt/ub8DcRKxAtcDjgS1jWId2/Nfys8esMHiUwezj+WgXAFrXwpvEQIIAl+Cs3UJZmF3LRPUTmF3yPCK3ingq5MoObzS9H5+592pRmZul6XaNsMYpOK9DwVo47VHMWZ/1URfyDGtV1Ura93FjQbnt6ZNIEAUqPy5vDEjXZV93/Du5rLXhQJHvAthb8Ro3Kz3ZTrBiTF7XmsBFGPufbvvFJZXVVHf+mzmw+MOTP4q85T/HoQQ3lNDLPqgw9J3ExiEO/puWEZb83pLMuSyn7UQSYUy/WaGCBRlYQRcPHXPlrqFjjs3zbjS7Hh7m17Fj3SOfQU59RjYLlicKhIhI739vn3xmIib8HeE28WK6r
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(46966006)(36840700001)(36860700001)(70586007)(2616005)(356005)(54906003)(26005)(47076005)(336012)(6666004)(478600001)(426003)(8936002)(316002)(8676002)(4326008)(5660300002)(6916009)(7696005)(86362001)(83380400001)(82310400003)(82740400003)(81166007)(2906002)(186003)(70206006)(36756003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:54:18.2282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f14a46-dc22-4519-bb80-08d90ae3fdde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4811
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
Cc: Lang Yu <Lang.Yu@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Roman Li <Roman.Li@amd.com>, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

[Why]
In gpu reset dc_lock acquired in dm_suspend().
Asynchronously handle_hpd_rx_irq can also be called
through amdgpu_dm_irq_suspend->flush_work, which also
tries to acquire dc_lock. That causes a deadlock.

[How]
Check if amdgpu executing reset before acquiring dc_lock.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Reviewed-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f8f2fde74073..e24f92e87295 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2727,13 +2727,15 @@ static void handle_hpd_rx_irq(void *param)
 		}
 	}
 
-	mutex_lock(&adev->dm.dc_lock);
+	if (!amdgpu_in_reset(adev))
+		mutex_lock(&adev->dm.dc_lock);
 #ifdef CONFIG_DRM_AMD_DC_HDCP
 	result = dc_link_handle_hpd_rx_irq(dc_link, &hpd_irq_data, NULL);
 #else
 	result = dc_link_handle_hpd_rx_irq(dc_link, NULL, NULL);
 #endif
-	mutex_unlock(&adev->dm.dc_lock);
+	if (!amdgpu_in_reset(adev))
+		mutex_unlock(&adev->dm.dc_lock);
 
 out:
 	if (result && !is_mst_root_connector) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
