Return-Path: <SRS0=Rejl=EY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F1FC6369E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 16:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF6C32463B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 16:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U4w/g+B9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6C32463B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D12466E43C;
	Wed, 18 Nov 2020 16:24:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB22F6E43C
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2020 16:24:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsSnf/vj8EPu3ygDO1flK2ccNhZjNlF6qOJzSJ7d6+CEOJYpV8Al+smWO6gkWk5GiS1jZSXYwXXg/3xPuov4PyCBt0NO1vAnCTfzmuA0J1zpb8jNO/a5LYXYk50sN7JmsFesRnl6r1vWkiJxTJbYjlh8IlCgJxkzkfQDu18Mn0RQL07SD+ccurr8gBDNlms8xo6uw358Vmr/89pIQvX2L6xRcbeEt5Z6KdRY/2pES+o2FZFWkvtt45g1h9/RthuTl838WzCORjCCI9m4BlNcycPSEIEIVA/FD3KbCXoTRT5ErbaJWl9VSBCc+ZM8ItGJ6aAMqOOSrpiazSUfPW+TOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+K0pkYu2AIxGmu+F6pi9lB04m+VmHuI0wfWJ9/cwOo=;
 b=Hpv/2mDZowaCVAUlc5x1U/inuL87OadbeYdJONe70//Nv6AU6VE1XfLineSLWVbjQK3CCTEnn/nS2YBAV1UjPlJBv3QM0XqrZEU7orOWCbqIeNv97uVRwGfYYbblBQQdJ2NONzyWjajpmbMS64Kbp9SqV687mjC563rEd/AGwU51qamNuWxp3l0De4yFAhyJb31C5ZjJn2yKpDRXHM5uan5U77T16nxPZxMjXbiW/OmMGfPxGe0AXufOf2/0Eu6vNyCNx4/pEkSdvK88JuLRPu1lIX7MZDys4jhb5fhsdZXeAsja6HEperd1WO2ZPkWGQnQOWPw/oCDyF4/c12E7Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+K0pkYu2AIxGmu+F6pi9lB04m+VmHuI0wfWJ9/cwOo=;
 b=U4w/g+B9hJ8+oVMENvT1L7uHVTpymwC2KUek4nPzFARenAqIrvfz6rm5bTCkuTUH9ZZ/OdDYHeSsAzCj848q6RZcgcnOsOdZNEcGoxdpA4f+46m9WJys3vdGbv5csNpuq6Z6iBdDai7aBny85Twbo4csv62GxxDwJlRH/mf7MZo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Wed, 18 Nov 2020 16:24:09 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a%7]) with mapi id 15.20.3564.026; Wed, 18 Nov 2020
 16:24:09 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 0/5] drm/amdgpu/vcn: support dec software ring
Date: Wed, 18 Nov 2020 11:23:56 -0500
Message-Id: <1605716641-22176-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: CH2PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:610:4c::38) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 CH2PR10CA0028.namprd10.prod.outlook.com (2603:10b6:610:4c::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3589.20 via Frontend Transport; Wed, 18 Nov 2020 16:24:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fefd5e40-eb3a-47c3-c150-08d88bde6036
X-MS-TrafficTypeDiagnostic: DM6PR12MB4314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4314EC029D4C0AA7D0DDBDEAE4E10@DM6PR12MB4314.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GzbJ/H0zDQmdz46sWwxDSuUVYg4vt2VcCNmJ/jKHTFtxWr9egvYDC+z+/dAtwcJXAbdM07fjVggHr+rFJQkx/kSi6IFVIhOroptpLM8EcDiPMtVljbeyZVBE/VH37LjoVio463crdLccvWkkOTwKbMplC2sObyR2x12Xd81NTC7sVtkIsTC1LOkUpqpjQvxLhHQuHPudmfAOD8aVBpl/Kq16AfrzGMNpBylrF6TS90FRBVqZy3CpLUGGYFs21dRAntwBF5fwv+5O0Bbb3yQ2XOOEyICyG2Z6P5XZkw2bzBlaKTDoNkP+29ETgIOlyTlrtNzGe2ZsoDagqIJxI6Azjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(6666004)(478600001)(36756003)(6486002)(26005)(16526019)(52116002)(83380400001)(86362001)(186003)(316002)(7696005)(2906002)(2616005)(4744005)(4326008)(956004)(8676002)(66476007)(66946007)(66556008)(8936002)(5660300002)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: tnwS39c7SOkc8l43ok262MZckit9hOxBYftYAHNK0WChOdBZNbE69TTA27JpiWgPZ8DeSo9v3PHqFiaNOUeRRN7UDVI7Etg978Byo/joOQdIU9bYzqvVRPJrvzFHHIsXidURZ0Q7powTVjraWyrDFGdLp8HSVDlLs6vKKiXbVq3SB9VkXINLZZvLdyFCtW+kjagl5len5DWKzOksjrL3vwVNKprQGftLjeagoZ034dcciutL4N82fYQORqls1IxYIq4XTRgsUmJ8I+Sn7nqVP7ritwMJ4+sD1jpjTrejUHAUCsJwgand+kAQN5DURPrxvQfLjAFrvewUWFvwlU4Vawlnh6fNhZO6ZfJGgqDqBRTUmZPFljBiOUdqyYb4hLHAnIdRK2qGezsKDjCRjprRWS42QLbYp+HiRycp9KqhEVMaBeY32iePO9YM1MYUteBQGbD7qwjjVmOZOdQdwIxiLacsZwFwJ8Sm2QIfI78Culg2fKAf3n2OQhKLCcSGPdWqDQl2k26OEidZEmq9YQYkvXT3NEakVR3aJtavvSh++i8PQrYeuw/yfbIN/Nxmg76I9PZ8ccA4PbDHqhiiXIkiYdCDzjiN+W9OzM2C0pM7p5+ZnCoUgQpoApBdK732S60Yko3ZgcWeHCWkysbsO9IuxP0ZyrOGP/ptzmm2qWKMzBe2sEG5iJKPUY6WnUrVnTss5GCb1MysUwwB0ibPLOmn2nRGbNVLOPpDdRrC38Jqp4Bz7ogGn6Wgd84SD+eg089j4znAbAd0lr7d5o9Qf9Bk5A5APE1xOGz5BzcA0QTkoFslkbHoz494wLQddgFQi9m23SjG8CXIA9KqkPt7mKBwq04Pj2WTEA/4J4qDTvvY7JMUZvIvJbgMSxnB+q+hVAK6n6LWX6YWFA5/emsQd0Bt4Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fefd5e40-eb3a-47c3-c150-08d88bde6036
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 16:24:08.8535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2u0GYcXX69iEK3B2gflR38z/M9jcHlS181oi2QXXYA2aNWV45prhqbaPm/u9o5/v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This serials of patches add vcn dec software ring support.

v2: clear compilation warning.
V3: replace module parameter with macro
    refactor dec message functions

James Zhu (5):
  drm/amdgpu/vcn: refactor dec message functions
  drm/amdgpu/vcn: update header to support dec vcn software ring
  drm/amdgpu/vcn: add test for dec vcn software ring
  drm/amdgpu/vcn3.0: add dec software ring vm functions to support
  drm/amdgpu/vcn3.0: add software ring share memory support

 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 151 +++++++++++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  30 +++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 136 ++++++++++++++++++++++++++--
 3 files changed, 300 insertions(+), 17 deletions(-)

-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
