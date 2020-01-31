Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94452C2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 15:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4544C20705
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 15:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ID1VYmHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4544C20705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFDB66E9AE;
	Fri, 31 Jan 2020 15:00:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE5A36E9AE
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 15:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSmwSDG112yX9Yoyh67lspdpnPQJoy8Y3PGEWjfT+/pvkYIKhjUGA26vCnUXgeZGO7DwFnC3Op5Sq6vuSLyD/UfK/DiOI1oR2x5wmRUg29oEKWjGKihtqFweZ+PeoSNkWpB0D2309alK5UYYC0bzyQpi6wM7diRCHBXuQOZWFacGYlAto6KvhdsdAi0gEqPpcWkeF45LuImNyP2ardsemligytrNXKvTj2ml6Ghu+yelqJodDPpB/qLDxMi3CRf7QOCKZHdlg1EsY0RoEELlaOZ9SiYGwL/KgoGYNZ5tm6ZAMudkLZ3jh5kFNgfFLPS6KPn4YP8MG9R8ySRWoC5paw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/95FkodJIRFkptDWFyx5x7ghHa+VNmeoMdMGqmHmhk=;
 b=mMiCfvPd7RmL0HTd1dzt838FHbGzKXuF+sWmP3pg7T9GDya16iE/SfCtFI2cbaFHJWqwexjt4XOZl5UHUI9z7vu/SsjZBB/xv8dPA2qu+4u6q1M/V8gjmD9UQcJ58+q2ynqWv9aTlL10r/695N3r24MwYzngF2CjXs2n1hPO4QmIi4ZUqmI1nKoeiHXHfX624OYM3ml3cMSzr8WART0vGQplEj1rUitGrVqlUobLqVOZG5SoBzLuYesIg2dP3/dpdo6k/ffnXkJBzxRNywUd89nDDSC+bSnX45nCzGerMlm76uvOEfCxj13KQPw2BdP3nRuvki9tXx3JJXj78CLzPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/95FkodJIRFkptDWFyx5x7ghHa+VNmeoMdMGqmHmhk=;
 b=ID1VYmHUe/5ZMs3MV0a83skjOdky3KvT9j0BPRKwkSokUyLvkClSk1gnlxNbHVMLexBRnhLhWi+zi6L2sksEZD07NcuwJrQCPPnFtMVgnrwtzEgVIz+xnAHccu861WfnubmqPpiMU6Zuc8FXWXL/KHGj6kM8ctq/WhAwOfmtqD4=
Received: from DM3PR12CA0126.namprd12.prod.outlook.com (2603:10b6:0:51::22) by
 DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Fri, 31 Jan 2020 15:00:09 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::209) by DM3PR12CA0126.outlook.office365.com
 (2603:10b6:0:51::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend
 Transport; Fri, 31 Jan 2020 15:00:09 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 15:00:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 09:00:07 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 09:00:07 -0600
Received: from mlipski-pc.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 09:00:07 -0600
From: <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix a typo when computing dsc configuration
Date: Fri, 31 Jan 2020 10:00:04 -0500
Message-ID: <20200131150004.5920-1-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(136003)(376002)(396003)(428003)(199004)(189003)(478600001)(81156014)(4326008)(2876002)(54906003)(36756003)(8676002)(81166006)(7696005)(8936002)(6916009)(356004)(6666004)(186003)(26005)(86362001)(426003)(2906002)(336012)(70586007)(70206006)(316002)(1076003)(2616005)(5660300002)(4744005)(16060500001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4267; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e969b311-dcb2-40ff-08a6-08d7a65e4387
X-MS-TrafficTypeDiagnostic: DM6PR12MB4267:
X-Microsoft-Antispam-PRVS: <DM6PR12MB426721206CD0BB0DA9DED489E4070@DM6PR12MB4267.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JUOTxFL4PFgU8hSMUMcrLpkQJD6z9s2wxe6zRYyDZ5lS+7wvCIM3j4IGxJHy8oai3BaOMxaXlWUkTgUgLR6sB7StUdrQu0T+Srblbax6jaAYUgC7Cwpb/HmsgAs3ZoTZGjObcMl7vPw3qlVoXtrGnVLoflGtwCa519us7jRw8JUXl5UNOkmIy3fchzawi9MIdzuMhBT9lsnDnfVijjxAqNE/rZfZvKDNW/ff+FQ9/ejZRZ8DBtpDb7p6jWPZ0RB0DB2XwtkGafea/MKbF2AgYteL0lgIurGOIjA3QV5y0LdrEbKLM6hztLEnjUSw9oq5wE3wCQ1l2Cko6U34dEpwxZuIhTIyQjvnvA8b2QZh9XXV3xTUDBa2DIGn98zM3reS6fGF3NwQek16m9e+1GDFZa9jo1s9wdYSRQwe6UPmq2QeDnhSvSxvWTAGKru3BOn1sD7vSs0YpXpi4MPu8w02Hrs619Gb7o0lxinAE0hMvnWr4fhPhEQefktXcc26DYKA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 15:00:08.5843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e969b311-dcb2-40ff-08a6-08d7a65e4387
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
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
Cc: alexander.deucher@amd.com, Mikita Lipski <mikita.lipski@amd.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mikita Lipski <mikita.lipski@amd.com>

[why]
Remove a backslash symbol accidentally left in increase bpp function
when computing mst dsc configuration.

Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 96b391e4b3e7..5672f7765919 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -632,7 +632,7 @@ static void increase_dsc_bpp(struct drm_atomic_state *state,
 			if (drm_dp_atomic_find_vcpi_slots(state,
 							  params[next_index].port->mgr,
 							  params[next_index].port,
-							  vars[next_index].pbn,\
+							  vars[next_index].pbn,
 							  dm_mst_get_pbn_divider(dc_link)) < 0)
 				return;
 			if (!drm_dp_mst_atomic_check(state)) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
