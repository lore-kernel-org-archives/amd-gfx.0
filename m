Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4DDC388F9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8688921D24
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 20:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aAXAokbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8688921D24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12C1F6EC64;
	Tue, 27 Oct 2020 20:53:18 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700055.outbound.protection.outlook.com [40.107.70.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 918676EC62
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 20:53:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipo/zKAoNjYPhG4vPdfHor7wNDBFSZ9nm4zD/j6N5Y6V8dmXBBXzx8siACK3XClfxj++Yj8qDcK3AKh7SvQ/Vkpxx1Xyi1AKheYYhbvCD7FVaIogTx+KwewPeo4NMscKah4tt5ysynAWVblPDXw40eNImN6vYUpPK6XVPkiFeqyppF4dhOzM61Pj+nUdrXP/K8G9cakEvhBbZFuSB/GqJ8G0zqXgqyn044bFZ6H8HiL3ModBQR0tCqEt7U3TPDQcnrb+o6LOVyLGzXxEMTI2zqJyed8uJXmh2L6Oiu1EDcCDW6MIIk1VISM6q2OHJrD/fzrDN13LbJ0EqJqx6pbASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3k0IF5+nPDSg78/+attkIBmAlQ7VHA4sFJ/Kik2jGo=;
 b=oVdv7APAgtuN1h/r5EZp5loq8qxbd8C+LWm9/uqQWd6cdyIlMQUgtSAEFP9TJnV5QSsVF9zJdCjA865hswBZKR0rtuoDYa9qhmWg6nShRcrOuxvlruatSj28TeAYewUS3CKeyFvjxv1DUgecTZPPhAcLlVjpQEdZ4q8R7hACpN9dk5gPKN2hVVlaY0ltSc8jiPDiluZuqtrMnUW9NsDbpa6d+3UcAZSsWtH2sCTPtkMMeu2K8FUBF1rtcckGyPWG3GFoOu/sqzL8CIEnxITD+eNZTHmc6S94kor0Gx215erJCgAifIICSCC8QeBye3p2PnJiWTLq+ssPpM6s42g9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3k0IF5+nPDSg78/+attkIBmAlQ7VHA4sFJ/Kik2jGo=;
 b=aAXAokbrWZfXJLdzzZoo3skjRz0SUDaATv0Undf4YAVQsQdzihn5SwwAyfGIsvPATCrByCgOevGyqsF75mFIdUJJO6LXDDlo38QTIvo/xFaFY6NGaq57j8Z0rc3gnheiN+CVv9aTtSXa76DVLVkkPVM3JMzAWZSuPCi8vQCgU2M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 20:53:04 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::a82c:a1d:81ad:42f7%3]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 20:53:04 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 19/25] drm/amd/display: WA to ensure MUX chip gets
 SUPPORTED_LINK_RATES of eDP
Date: Tue, 27 Oct 2020 16:52:28 -0400
Message-Id: <20201027205234.8239-20-qingqing.zhuo@amd.com>
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
 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 20:52:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 77179b3a-5d47-4844-062a-08d87aba48a2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35956250873C511269B9BF8EFB160@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7GXjSVp/TCvFX6QEUIn64lwMGd0ivCv4pqGD8lm9WlFIGkVzNONp1VKVxtRenis9KoCqubNp0HgeLslY8v4KI30iyTiQ+3oCKbZ7rdDnG91W1dpMpLsMpEvCDvgtGhaXcHPRewSRSqrz1ZGBsim9XjWW4M60XZmop7PHSe6Q9gkM1mWY4D9uMtjosxuiv4dZ0I0tZTvNT7dDGoYDzNmmq2/5UPIL6lbUsQ7boNB9gz/3d0q+v4EdH02Sglu30HPV4JLTfgCy1313ONLC9BQtJmFwmc1JHa0vTiFSk+kEOMq8et1L/fQA028zw0oTDsy2JIWeVHidkxnUxdj+9c5uGc4noW/x3AhDd0OQyOE0tRJgPVuNu5/0EE66oIdkXkkS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6486002)(6506007)(2906002)(26005)(66556008)(16526019)(186003)(6666004)(2616005)(6916009)(52116002)(956004)(66946007)(316002)(1076003)(69590400008)(44832011)(8676002)(478600001)(66476007)(5660300002)(4326008)(86362001)(36756003)(6512007)(8936002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: vB+HQbeQa5VBqC2SiUg/fL7I54cWrF31XFP/XmJuuEbIo8a6d4HbQTjdKNMQT4xIpgIKZGugGWjKopCPMbydbbeRBUj408lvhTWUlLgvqteijF9Me4p6crRPiBQiPZpX0vRMYryP4lZoLAv18h5giRkWC+1aFcu0rmcnDj21UkIZMImqljl+stH0Jr9MEam3HJhWB10KpboyfogHKnAKIRRZqx622ofLS94O5Y8MySMZZTdzkwyxrTyqgtf+7OADNz9rRXHY66vtUoEL6ctumum0GEjJzwu/ZI5sYHsLt9+xNeUXfHJlOpgoNCwhronHlPjTczv28wfJyxDtrhktHHV6Dz/XeyZ8YFlnmfMfOo6N7frtDYT0Y9IKiPg5X390/iYA/LEtDNkRH3ELufjtYt4/ut87lPbr/s836vF6bKLKfKbNcZEaH4tiqQtFbisccOpIyTLTNnTtdXPR0fOMAseuA84v1Fz3dmgZELq8zEgW9JcVOtIFobSDYnusmeUNVe4V8PwxriR0dfkYMiYb+hYonXZujE5YNKPIsdgOANPaoNeBhCW5szD4q3JWlQfP27ujLPVm9WqqhUJTUsU4BbErWhY+GvXJ6qH5KjaD753OSFVT+4MMLaEMXi3GGNbqxOLozaSk1y8XpjBRkCeR4g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77179b3a-5d47-4844-062a-08d87aba48a2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 20:52:57.5918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ne/snPWRkImYB2GzX6jjFmz+CWEDq/c11zE3w4yVPMOGeTkVZ3SitUQuSwtHb1CD
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
 Dale Zhao <dale.zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dale Zhao <dale.zhao@amd.com>

[Why]
Customer make a request to add this WA by driver.

Some MUX chips will power down with eDP 1.4 panel and
lose previous supported link rates(DPCD 0x010) in
customer's hybrid-GPU designs. As a result, during sleep
resuming and screen turns on from idle, link training
will be performed incorrectly and eDP will flicker or
black screen. These MUX chips need source to read DPCD
0x010 again during LKT so that it can restore supported
link rates of panel.

For driver side, supported link rate set is fetched when
link detection, no need to update but just read again
as WA.

[How]
Read DPCD 0x010 again during link training for eDP 1.4.

Signed-off-by: Dale Zhao <dale.zhao@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 9d1c5e1d06c0..54ac3de4e8e0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -183,6 +183,16 @@ static void dpcd_set_link_settings(
 	if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_14 &&
 			lt_settings->link_settings.use_link_rate_set == true) {
 		rate = 0;
+		/* WA for some MUX chips that will power down with eDP and lose supported
+		 * link rate set for eDP 1.4. Source reads DPCD 0x010 again to ensure
+		 * MUX chip gets link rate set back before link training.
+		 */
+		if (link->connector_signal == SIGNAL_TYPE_EDP) {
+			uint8_t supported_link_rates[16];
+
+			core_link_read_dpcd(link, DP_SUPPORTED_LINK_RATES,
+					supported_link_rates, sizeof(supported_link_rates));
+		}
 		core_link_write_dpcd(link, DP_LINK_BW_SET, &rate, 1);
 		core_link_write_dpcd(link, DP_LINK_RATE_SET,
 				&lt_settings->link_settings.link_rate_set, 1);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
