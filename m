Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350E1C77B7A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 20:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77FF710E5CE;
	Thu,  1 Jun 2023 20:47:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A79DB10E5CE
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 20:47:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDN29smdII7c3Hli4JdEeRiva2n2kKCrT2gSL2TH84B7B0oB92BZQHIO5C4MCFV4GRa2gTrbSQPCB/Hfe4DOXESoMmGj+Salu0qsSaUxyPLPgQfgIIzWnaQn+N49WFh1xJVUn6kXJpudGIm9fpI+bwHsAoavBs+MWoKhAlX+kbWh2l9TafqHDQ/A0uydRPyCE2hqXEo95Hca4uvhxr6VnjJGmJhxf6hgUOUuEfmTapXXhh0mqTpJExsowYGoM8VGwYVLWnE4jCsHrtUb8nVb8pYMzPadp7vcrX0Ov73RcB3Zyg23eMSnU5gPedpZvR8MelmzruOvEqFp+OgTluMYBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEs3wW4uKUBB5Dd1JEXZOP5V0jwp5jwn0YI67t/u8go=;
 b=WXGMNso5WrPJBWgwV6/hwjHxcrqstTWqxxBnNEjwSfaMytxJs3epKR4w23ZIUR4Z9soDQixJzWoXiemuEYikxbcLl3Pmu06UWmEf/0XfLqho8RfUgxpGBt+mupFjZSFbw67XVldYmRwptsbLGVYIQmI6KCAun+k+bGfLNA/qX2NJlRNYy9l0SwmojeZr0fGCm8RXF+/SG0EjymTyBfzcdQygPOYfGz1e/n2/bCoyIR+VaEOhxEl7+7HMJD3ID7xDBey2RJwLnPmyMg7vwItcMFih6ZKhA89use75M3hFK4rccOde5pLy+lMiXF3L4dmDsdzxGFzctQbKuCl55kuOiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEs3wW4uKUBB5Dd1JEXZOP5V0jwp5jwn0YI67t/u8go=;
 b=Jr0y9KMOgD5PdbjwNzEHf0WuGPHMcUCeYC638LsWrMAs/dkZKVO+h/pzQkOmCpAo6DJQPi2NzIMFp06hfKUDW8q5V0z/2MFZAN9m/1+f0V/IKJHmM1ZfYCP4wbw3HZpk9X+8EbpgcoWmtwBjgaMqhue84HXCTKGTr8KK/576hAQ=
Received: from MW4PR03CA0063.namprd03.prod.outlook.com (2603:10b6:303:b6::8)
 by SA3PR12MB9160.namprd12.prod.outlook.com (2603:10b6:806:399::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 20:47:54 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::60) by MW4PR03CA0063.outlook.office365.com
 (2603:10b6:303:b6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 20:47:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Thu, 1 Jun 2023 20:47:53 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 15:47:52 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdkfd: add event_age tracking when receiving
 interrupt
Date: Thu, 1 Jun 2023 16:47:39 -0400
Message-ID: <20230601204740.1501616-2-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601204740.1501616-1-James.Zhu@amd.com>
References: <20230601204740.1501616-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT022:EE_|SA3PR12MB9160:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b47590-93fc-4f08-9933-08db62e178c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hwh/OFeUXRD0FNZIu+Y+JCnuIrX0n+Q4OniCuAWmne5CvqjSe7ltHOgy4lHTDqqP72iZP/njEzS8HIbc68mI20g+6yFHHopV4FkyS49cPu3P87r+5IfqicJpV0WCgeusxMoykFWcrAg1rLwGoCxu8fjrbW5zUidRxpJJMPOAz10DI2MB+LKJQSChaVA7I9Uqv95WeW1/2HOVNj61DrWrfIXDelWo6n6/gCwLbj2DiL7u24SbadMl87onelK81SxoqDi8JkauchP0/mgmBwoR+UZW0U3BuCbA6E6mFhL5lotGy+OvlqBmntzP4As23MEbL3RV0bhtrbS2xINF9WOLLezfwtLD20S7eF3jjWWNJb1UlwMTPwrGNyb4b6Z3KGT5J5zO/I7EvtqpNBeecWzvkYOth5RQotbDYdCytofLAE+/I6xcWTSMYRHt+a/sWX1q/5G41NB0b4iusehgST5GOPqFjOq3xiTXBJu2aHCEVS6hFK6w6Ya9i+ZCKWwrfhJhNdNBhDEo0Bo2o71oXyOPlSx78q6JTsYyxbmoD37JVRjruYyorA2OV/iQUDWOSLEeMKcOzzuPy44Itw1qenVX5kfbajwKLnuz4eGfXzAdVY7hcMnjAH+5u5FAI0KuzuNj4UnEDSn3bGKNGqasYedVx0xFdACnDbhe66EkHokCh6oqv+b0R+X7YjRrqJLQXJu4XAomV3wePDVyDNklj3LIK284u+MtSxJuDbAiFirat2QjTGuQw9cdv/tkWbdH+cnzW4tFoxB7Yz4aJD9r4SrPHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(54906003)(8936002)(40460700003)(8676002)(5660300002)(40480700001)(82310400005)(6666004)(478600001)(7696005)(316002)(41300700001)(70586007)(81166007)(6916009)(70206006)(356005)(36756003)(82740400003)(4326008)(186003)(16526019)(47076005)(2616005)(336012)(86362001)(426003)(2906002)(26005)(1076003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 20:47:53.5095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b47590-93fc-4f08-9933-08db62e178c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9160
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
Cc: Felix.kuehling@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add event_age tracking when receiving interrupt.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 6 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_events.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index d23202613ed7..b27a79c5f826 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -439,6 +439,7 @@ int kfd_event_create(struct file *devkfd, struct kfd_process *p,
 	if (!ret) {
 		*event_id = ev->event_id;
 		*event_trigger_data = ev->event_id;
+		ev->event_age = 1;
 	} else {
 		kfree(ev);
 	}
@@ -637,6 +638,11 @@ static void set_event(struct kfd_event *ev)
 	 * updating the wait queues in kfd_wait_on_events.
 	 */
 	ev->signaled = !ev->auto_reset || !waitqueue_active(&ev->wq);
+	if (!(++ev->event_age)) {
+		/* Never wrap back to reserved/default event age 0/1 */
+		ev->event_age = 2;
+		WARN_ONCE(1, "event_age wrap back!");
+	}
 
 #if !defined(HAVE_WAIT_QUEUE_ENTRY)
 	list_for_each_entry(waiter, &ev->wq.task_list, wait.task_list)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
index 1c62c8dd6460..52ccfd397c2b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
@@ -53,6 +53,7 @@ struct signal_page;
 
 struct kfd_event {
 	u32 event_id;
+	u64 event_age;
 
 	bool signaled;
 	bool auto_reset;
-- 
2.34.1

