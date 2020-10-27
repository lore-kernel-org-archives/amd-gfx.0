Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8DCC55178
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ABEE218AC
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="d7rJUr03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABEE218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B54F06EC5B;
	Tue, 27 Oct 2020 20:53:02 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700069.outbound.protection.outlook.com [40.107.70.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 676B66EC55
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:52:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Suv8C5CroFtZxkTJ9NCaWk2d7vtcHDzlxsH8Itm+LlOTOiv4N4MQFGyj6tArNX5MBcCQvdCK0nvCSZnwZkag9qZOY0pLyeBDdAFPF8U5NHW76dicSrrMHQ9LGE5ZpfejZSnRmiKB1CcC0OLSuaucQaNsNudkY2eZJyzCuq88E1B/RGb64+Sit1wtZeD3u34KwhN5O/82a0qDAdNd5PYzIWhpGmeqxZod3yRPHhw0G9BGrhzK6URcUwPKuFlGPW7j1tz2QXHaopGqOqeww3mgHHe6xjAv8MQrYgqdtBdYoQU8sMBNmg0qvT/bD2ahCk/x87AeuWCn03OhJzRPZEFMTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZn4FW9gJV/xGuRWVZGS+2pQsI+HHKpQGkdEkP0YMrM=;
 b=Z7Ed6D+AI8uWFJZqZWN/e+kpjyXzFtXo9zFHsr5fULIzIeTn0I6tAFfWwko5sQttdLO/WTOuOzNhw9efid9/aGv7sgn4wyHDpxriTTip9Ktu/OaRjxvxe2mkcrkCAtmjsLGJaxx1e+ytZraCAC2LHfAd8zdKLWVjJ1dVlNld853FB403enDi1kXmFhqzf4gwzwPUjpRQJbag+RR+H5SA4EmZDCnzzzvprpAE3+pJBqCJS6yMKkX6+IUDMSnwfPZ09qHV5XpvRc4bexDTQiv0yuWU6bphxXIXbiGtuF+MsopM+BXfQZO5aUQVqUFtB/TBYJT4vmB/es5YZ+oc3ou1TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZn4FW9gJV/xGuRWVZGS+2pQsI+HHKpQGkdEkP0YMrM=;
 b=d7rJUr03mrPMN4/zPZ3luKzC48zr0/DSvdILY6D8fnROPD77Euncx3aChTgM6w9c4PJFpB3qBHGtSta7aTvH8VZZqVEsxWeEUezSZWODc/HdudL8N2eHvnbN88vq/auio+r6h7+0dp7QZvFVZO2DYZw9yjW2T6jjdBLbWmUXI0A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:52:55 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:52:55 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/25] drm/amd/display: [FW Promotion] Release 0.0.39
Date: Tue, 27 Oct 2020 16:52:15 -0400
Message-Id: <20201027205234.8239-7-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027205234.8239-1-qingqing.zhuo@amd.com>
References: <20201027205234.8239-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:52:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a0312edb-684d-462d-05c1-08d87aba439f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3595F92671195D993EAE752CFB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zOeu2J2HAG6diAInsIca8C8be0c/jm+YW+pEjHBTEdkP5V0KyEcHtzn+4HIjiTPi/Qk/HyRrlD03TPzZSXvmihQ/+kuh9sys+RDPJrvE55wwh5X0m7opSlKgYT694azYHMHdUxeLnS4QoDLBlgT7cd+xD6eRszKz1dYt22IlIw/YvEsbNsyMAD6tMpTQCN5LxXIgRZGju6qsrNN9EkVcJrq0JSoJfC9PHoUygyen0h4DJ/cltTC+Q/phVhUXea1wEXjvh3+cDzIyv4CYGmfPcHCE3De+3oys6TXWULJ++xVLaaLGSQWM9jxS9z+3v9E9EMAjA2A8esSd2iLQAt+HgeNwKivjf6Ky6jKZgFnqv23mTs99hBR729FOFTOnBAyV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(4744005)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: jJq7ofyHBLtD9vZDzqlglPjvIeypuD09o4XmS8TUerRTSSRqYf6zfUTwqvwZbreLFGUgf9jtqD/0BrAq4ppjsGgtqoNPJFucyTcZFNzYu+oobiYlKp2megvr30h/x1CdLsFO3T08570/1hDPvlQ3Es0tVn2ptcFFe5MrPVaHS0EmnL5cLle8JmpPizddjMpwAZOMipbz69uNuFah+grLWcFD7o7RJKJC/OmwCSJxCnWtgs6uV4uX/RW8d5yU1sEtJRcpjzptwttbkSb7ljNnmUsAMobV7vJdq9GP5d3yNnKA4RZ/CBDhOG8JcAJ6hs2a1neMLRuxEVH8I01fVz8B0kzPBXZv4hTDjBOXsqJDn0gJp0TYBaJM7pJEDdIZ8F/5TkQHqG9ZhR4dsBlULJ0U6R4R7mC4zjATw1VMr81olODFD+nNc4KZ+n5g+36bgLOM9V823tisC/hUPWwKAujTEtxfyaCTg4dO+0qaTqSBY992kPO8kseP8s00gQkmvkixh1z6azSDSpCg8r48GCPoSGYrR6y1ndrSse2hnWFy9Kwja/WYWl9sLwhXIR4RGmktW8k6sczLu09Ckh4ow26yG5LSZFPSHJ+s7BU9JLkf8kgP2n3qgOfcHBtNPMmuUZUui9tqgk81DXvM3tsoWKnOaw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0312edb-684d-462d-05c1-08d87aba439f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:52:49.2255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKrqmcsjzxKRuGo2HKNHYPdJaljZ418F9W8nqfQje19Jdvp6mEEq4NZkiEZFAERw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index a4c3f078887d..221bb2d65c1c 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x8aafc9acc
+#define DMUB_FW_VERSION_GIT_HASH 0x26ad601d9
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 38
+#define DMUB_FW_VERSION_REVISION 39
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
