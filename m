Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D704DC3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB4721D56
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gxE6h8yG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB4721D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 784DA6E5CF;
	Mon,  2 Mar 2020 16:48:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C02946E5CF
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 16:48:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQLL4nLI2OLsWcFmeOAXcH8T+0hkTsALYZ27idB9X9mwTGUeofUmmQjzq4TrvRnOUG/cLiLEkmbHa9D1zP/zzobZREDLC408HdP8imyIVr9/SAw4PR3YlRq6x1a4Uw4GMMpl/oszeYdwYgqv8DgRwQyT+lV06BhaC9yJXb+31zwc/LWRJE1aew1166YoMv02w8dr04DneU8bVTxEH0axsxUUMmXbLz6Q4UFjc2RAyjnyrKACXNLgTEq8ctI4bi7wYffNA1DZx3kULE1CbrHapK5b3bblrysgMdw2awxoOhV8dqhCxtKoLUx8nIzPTHCIVFUFwx/0g7ccoqdQc6NyeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZG94jivEDXBeb8gYMEwD2JEjA88UmSoc35uIhRHG2E=;
 b=bRAO91YRX2qXiM5piD0SOhNx9+SJ1z3Ljz5L/2njdKL9vFkscN8NXIJExbyuRJ6+e0ayTCJWZLYF+COPCC0YK0x8wYqPZmN0L0iPHH8dUhSpmtozO/nGSghygruGUqH4T1NmD/DlfVUW2Sh6tfGsnyeSkotkCN1kN/NZfLTlZjqOtTHxLBwnEp/RR+PzEzASg12lhhdE2zuTpY/pQ7qFSogWO7yuPM6XiV3SCqZYTKJ25nxEAH+d7B5VmtZz4eX/kNCYH9Lypumi2rSRtl/DlCs7Cul9xezsBUYtKiqm6mYVSYXv8BV889TuBspRg1la/Yv0QtlV8nb4Q+85HEdGGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZG94jivEDXBeb8gYMEwD2JEjA88UmSoc35uIhRHG2E=;
 b=gxE6h8yGKSBITj8OUwb9Ft4pLt2Hry7A2q6khbrUJCDPy+BONDCZVez4kdkScjPYLsS6lsaiP0Dq2A4KPkp2Ez2iB8JXs6Siuq+ICOdKoFczI+VY7ut84AQw7jjYPkvZByVfOhci6mfGgcdQ4F5PVm6MJXp37reM2A/xcElxmvs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2540.namprd12.prod.outlook.com (2603:10b6:907:7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 16:48:05 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:48:05 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/22] drm/amd/display: Set clock optimization required after
 update clocks
Date: Mon,  2 Mar 2020 11:47:30 -0500
Message-Id: <20200302164736.89429-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
References: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 16:48:04 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b69815ac-4206-48e5-0ee9-08d7bec97aaf
X-MS-TrafficTypeDiagnostic: MW2PR12MB2540:|MW2PR12MB2540:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB254017345E2E0BDD3C40982098E70@MW2PR12MB2540.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(189003)(199004)(54906003)(316002)(7696005)(52116002)(8936002)(6486002)(86362001)(6666004)(36756003)(81166006)(81156014)(8676002)(1076003)(5660300002)(16526019)(2616005)(4326008)(4744005)(2906002)(186003)(956004)(478600001)(6916009)(66556008)(66946007)(66476007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2540;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iA4ts2AjLnXRuUwM6p6OpFpcSUqah6XefcgGLaNAVvUxblKili7Kwl24ySCw7lI8gmwR4ZfYZTCze0oQN1SI5Z4PzLPOCGnbhaJqKYYZBJUPXxMryHYag3DCKoz7mCEVi6VZ1Amid7c65m5tHmnqLN6d6hC/R57ojZABOmtJerBgekStLs9jWOJd358CWqbcXicfAcRA06vqhaAEQIpvIS0gKDd9QvbZjUC2s0SzYOgQ5vTzD8T2exYY0KD2eD4CMsKn5URQaBoKCJZdVRgoADtGOdGEYZ0wdb2ipnVi/OY/3V9AQPh+3CwhJkPdS+sMKe9kb201mC/GckaCYZ2+J7x6i1rYmMsCuTJ+xmWG5arC/uBOfgI+vVaoYL12+9HZwtNFN0JJbgluUC77x1EwPITqHk6NzQQJUN38nJVsQoCf6Ichmfv+1fRCiPFCYAyM
X-MS-Exchange-AntiSpam-MessageData: 8yD+yppZLIgdKap0Cc9hAp8z0IJOrRhHqTAeFNQCKlO5etwFiePESt05mHsYrKw7VJiY3CXd3J1J03Be5Zz4QTnfk1G7gqQShZlM+W9IeHzA3CF6jTk5JhmPuGNWRTJp6+lVpkLBxR4pAYlDQTpRkQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b69815ac-4206-48e5-0ee9-08d7bec97aaf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:48:05.5549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHZqkKshoIVdKFsuTVXcpek6vvbUl6QT5COKpJWk4p2lCcT05n5YKx3HhzWHnjRhauA1W6JBOwqRGbnyoABoZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2540
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
Cc: Sung Lee <sung.lee@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY]
We see an issue that caused clk_optimized_required to be set true in
certain cases, causing passive flips to fail. This is because of a typo
where wm_optimized_required was set twice.

[HOW]
Set clk_optimized_required to false after updating clocks.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 49f5af9e3016..045ba08c85b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1674,7 +1674,7 @@ void dcn20_optimize_bandwidth(
 				dc->clk_mgr,
 				context,
 				true);
-		dc->wm_optimized_required = false;
+		dc->clk_optimized_required = false;
 	}
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
