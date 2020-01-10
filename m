Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556FEC32771
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 02:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 090602073A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 02:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sntZZ2a/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090602073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C2BC6E987;
	Fri, 10 Jan 2020 02:34:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3FB76E987
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 02:34:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCVBAXJmxZv05OonFov8uPE6yd5f0mxVjEzKr62MHMK+2Y7cwCHJ5j3TYtjmyfjtNGzP/JXzUSLODalJ+NQZ/mQIi4rmE/MgopI6IAv/l9MD+1uuXPXo6S3j6mpt6v68ZpknnMDMeAnPtfJLtHdMzzh91Wlz/9Gx5KkEi+7sCwCpsPm6zdVyVhZdmAo1rqQkSoHLNu9CCVLb6taiP1Un3UUUH/xtp6nguqTXDxuCKUt/QZqQR5uBmituPcktWtEBpqRj+pJPyru5JtB3KfS/O1/wrrlMTysrJvybN1DGf3XRDXJoG95UBiM/ul+Ef05+WEUvTcuoTz0sqs6OWUTJMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNCu59OGxN6taARyzpxAa14tnb8JZoEks1/EvuncZ2E=;
 b=i58vcrFHsYQh/Z5hZn7AL34I8+8j+O0TqmNpXWejmpjJPkDVZ59HswGkfcyzIRfuC7cDZ56P3zKuhL/3p4wjS5ewaquYi9w7lCTJvuWuXCQKEgNC2zWkStZx/6Ulr2fe68/AY4HU2byCj4qRn6+Vjt62G76A5bS0OoiqjskhQUJICMXwpqu5WRQOfYJP3m0DAXmccIajhWsazVzJC69q0duHmVTMYN3NKt7JaRO2GbuKg3XycytjpgIMOrxOe9OqPpswGWedPdm++f5AIJmIPq3vh8FKOn0DNqN98yl5f8znsNJgbustbeupv5gI/E91lgEirv+W4bqsAua7GVfNSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNCu59OGxN6taARyzpxAa14tnb8JZoEks1/EvuncZ2E=;
 b=sntZZ2a/IieC0/noKGH/2PmE60mvPcs8gmTXXXyQ89SwQ5VFq3iN5HZRtRd1CZNksAyF3EQy8MBjkP85nmOkZP40ZW5+/1pq4IU73zrqmE4lot8W0rULgVgBJ7M/drunidvoqK+8tolQBKpxIXl89mpdA5S/r0vg9OuH79KdAiw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Joseph.Greathouse@amd.com; 
Received: from DM5PR1201MB2472.namprd12.prod.outlook.com (10.172.86.151) by
 DM5PR1201MB0089.namprd12.prod.outlook.com (10.174.104.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Fri, 10 Jan 2020 02:34:08 +0000
Received: from DM5PR1201MB2472.namprd12.prod.outlook.com
 ([fe80::7c50:5e2f:e0a:3721]) by DM5PR1201MB2472.namprd12.prod.outlook.com
 ([fe80::7c50:5e2f:e0a:3721%6]) with mapi id 15.20.2623.010; Fri, 10 Jan 2020
 02:34:07 +0000
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: Rework DF to prepare for VBIOS that turns on channel hashing
Date: Thu,  9 Jan 2020 20:02:03 -0600
Message-Id: <20200110020206.676605-1-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.19.1
X-ClientProxiedBy: SN4PR0601CA0008.namprd06.prod.outlook.com
 (2603:10b6:803:2f::18) To DM5PR1201MB2472.namprd12.prod.outlook.com
 (2603:10b6:3:e1::23)
MIME-Version: 1.0
Received: from rocm-perf01.amd.com (165.204.78.2) by
 SN4PR0601CA0008.namprd06.prod.outlook.com (2603:10b6:803:2f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13 via Frontend
 Transport; Fri, 10 Jan 2020 02:34:07 +0000
X-Mailer: git-send-email 2.19.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5e7e2032-7645-450c-4a6e-08d79575913b
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0089:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00892FAB734C84A798DB621FF9380@DM5PR1201MB0089.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(199004)(189003)(8676002)(6666004)(3450700001)(81156014)(81166006)(1076003)(4744005)(316002)(86362001)(66556008)(66476007)(66946007)(6916009)(52116002)(7696005)(5660300002)(956004)(478600001)(2616005)(186003)(6486002)(8936002)(16526019)(36756003)(26005)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0089;
 H:DM5PR1201MB2472.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dMMAFBTqX+wcw/KHRz+1sJ0onjV3a9u4WkLIuThM7q6LM0K2wLM1Lr4YL9m0RGphABtcn2OVJtkBQrjAa5I8TcCyBPeDOm8OLb1TlvD1ZO7mB9Tb3X2WXFjnkuHiOK+viJ22T20R/zHePrWkV8qZ+WNWJSgCBh8P2GeH5kaoCK61aJrR6WzrUQbUPAIDkHqSu0eCDMxcRj4u/UEt3EbO0VxvsKBvJvDqchfus/MXfe+TZh7wiM3vRamqD7cVg08NOa9ei3Y1QMYLlglM+/evOrECRf48TUEiOq9PUqhiuu9sP8r+XCcK4gBKKC3d8dg875OrzBhf8vrYjVPWyl5FovuMG4Tkf8H77nGUsjU2DJGZbpJ/ZcJSwyxR3GNFr42Ah71zIqUAIX2yoYX7QaDUMcDL280LTUfO00pmEF8XnpVu8IRhiiBDhsl7JBElq7pm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7e2032-7645-450c-4a6e-08d79575913b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 02:34:07.9167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyaLb74C9VxvYtwnXnhRKMCmdluhrlmEt7NIiP/NEbo8/MwXwBEajUjCHPqHg0pqc6cK4f9sldq9UTO550x3Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0089
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
Reply-To: Joseph Greathouse <Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


When we start receiving Arcturus VBIOS that turns on channel hashing in the data fabric, we need to make sure that the texture cache's channel hashing setting match up. To do this, we query the DF's settings and cache them in adev, then mirror them into the cache confirmation on init.

This requires some rework of adev. Rather than just holding some function pointers, this series adds in a new DF data structure which will contain
the function pointer struct as well as any new structs we need. It then adds in the structs for holding the DF's current hash settings info.

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
