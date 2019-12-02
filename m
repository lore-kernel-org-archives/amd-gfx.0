Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBA5C432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C45620848
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 17:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C45620848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14D5D6E2B8;
	Mon,  2 Dec 2019 17:35:09 +0000 (UTC)
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720044.outbound.protection.outlook.com [40.107.72.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 128346E2A3
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 17:35:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyv8xvxa2oNkAFEIq8uFJQGDNmfVRdvqE1odlIN4T1XbSIzVGVF5IE2k2BsvmFjYGGZpeyD/CXHppKgxq29Qqp/DxMhGcT9gbohUyay9e1/s0gn/pjDYmjKs+dBlDJkLR1AnRuWesboxGvotzJy8KL/lao0YU0cziBCK+1LDHfTKdCAyYx8j4DL3Jlb70vVgGTGi4FP/JHnrhoCEkqUy7rfjUS+2GdZY0teTKPl54QfgYxyNm8NCs0V7DY6jVpaeT9Wf35JY7z5lGdk2vZCf0zkdtGBMsVSfLnuVF/rtfEwMRMgYmV0zC/gmbvd49pKkivcJ0AbvNcAZJlzGrJNNhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0GU0L4mb/I42U7lPy+1IsHeS5+gUrNu3tf1Tbn+y5g=;
 b=CFgzD4uowVqx/iPUb2MoDIK+4c6lZllgkfqMT4R1Xp9jrsn3QyyO+oCf1UA2fGY5iImIWVIK/goq6SNXw2eA6u1hd9aH6/hc3buPQ2X/RIqLXDpyvVF+rgWNxJsJyjtzlNM5YC/2cShL6RjUVlmjw/rRqMWPXdO9W1lbUaWyobh7q01227dy1K+9YxsgRrkxY1KInh/jLDze+E1V7KJI8eTEXFeiztim5Ek+EeNvzfuTXIIn0oCL5WVPGY0BY1sJE1o5OrubPYI3Q1zpj9JOphVq+6iyMJrYoksu8B4JwWBaTvfZCSl8eBifk9gzPK3YgxEGI0PF/YServnJWubIfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.27.87) by
 BN7PR12MB2802.namprd12.prod.outlook.com (20.176.27.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 17:35:04 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::2070:7583:3718:d019%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 17:35:04 +0000
From: sunpeng.li@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/51] drm/amd/display: 3.2.61
Date: Mon,  2 Dec 2019 12:33:32 -0500
Message-Id: <20191202173405.31582-19-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202173405.31582-1-sunpeng.li@amd.com>
References: <20191202173405.31582-1-sunpeng.li@amd.com>
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:25::23)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0691256c-e423-4b02-e2fe-08d7774df73f
X-MS-TrafficTypeDiagnostic: BN7PR12MB2802:|BN7PR12MB2802:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB280243C9CF61D3273E8807B082430@BN7PR12MB2802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 0239D46DB6
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(189003)(199004)(81166006)(81156014)(86362001)(6486002)(9686003)(6506007)(2870700001)(478600001)(4744005)(386003)(76176011)(5660300002)(51416003)(186003)(1076003)(52116002)(3846002)(6116002)(47776003)(2616005)(26005)(66946007)(66066001)(25786009)(316002)(446003)(11346002)(14454004)(66476007)(66556008)(48376002)(8676002)(50226002)(305945005)(6512007)(36756003)(2906002)(14444005)(99286004)(6666004)(7736002)(2351001)(54906003)(4326008)(2361001)(6916009)(6436002)(50466002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2802;
 H:BN7PR12MB2593.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lFqnW54OnZ1s35fMJzGNxZT7juVgabmsnNKPcPBEWiVjE6LIR/oRetUTDftJgAV5YVqHpPR1qdkY2UuEQuVwyTR/kQHwpQtzodiNKrBTXNzC5Lz0l8NaRR1uVt3QlsxNJqA4/rc2rn/1Pgsc8qWLxKykXAtyLU2KntH+yesOZYPRBCfOD94O2qu0wECsJH5OvaSdfB4rRocKRR7M0Fa5BJiny2F5EjgSdxV3lVhvXT/g94WtOuMIHhvnbVNBSVempRKVF7IDOtMYoNtZc4XiuxaUAUzZnzooInx9lLQZPEzxZyA8kQ9N3qR2YCi5cX9H6BTaTTlrxf6Unz04HaIr0yX4c1balKEEoJ2/V6K6Fh3NPLuq5prGS/nKWqdtspbKXebg/Vr2qcFGbO9CLQUDEycKrIuZM05HvIPL1HeKW7eExL9CdVWtAOlDx3Rfqju6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0691256c-e423-4b02-e2fe-08d7774df73f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2019 17:35:04.3859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JbD9na4OPnRoIpoMqZnujKeh53YbJrv3vAnydAVX/mDlKNXndo02faY33iBe7tc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2802
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0GU0L4mb/I42U7lPy+1IsHeS5+gUrNu3tf1Tbn+y5g=;
 b=PMrH43ZHv6EW7HDebh9zJ9wNJ/WeINa5rqzt4uYafA2xTwDVSEOAcTghUpXZaYMVi7szFY87NV8CWh506bfhjHAaxJoxCa8YVBoLHeE7v3DVExzeqttHspVLxPlMsYcyreqBUVA+rG4dU6nR784iEx2a+Su8h88B81l9xWqqZ7s=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Sunpeng.Li@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: bhawanpreet.lakha@amd.com, rodrigo.siqueira@amd.com,
 Aric Cyr <Aric.Cyr@amd.com>, Leo Li <sunpeng.li@amd.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogQXJpYyBDeXIgPGFyaWMuY3lyQGFtZC5jb20+CgpTaWduZWQtb2ZmLWJ5OiBBcmljIEN5
ciA8YXJpYy5jeXJAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEFyaWMgQ3lyIDxBcmljLkN5ckBhbWQu
Y29tPgpBY2tlZC1ieTogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjLmggfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kYy5oCmlu
ZGV4IDNlNjEzM2Y4Y2RjNC4uMzRiODI0MjcwYzg0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZGMuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGMuaApAQCAtMzksNyArMzksNyBAQAogI2luY2x1ZGUgImluYy9ody9kbWN1LmgiCiAjaW5j
bHVkZSAiZG1sL2Rpc3BsYXlfbW9kZV9saWIuaCIKIAotI2RlZmluZSBEQ19WRVIgIjMuMi42MCIK
KyNkZWZpbmUgRENfVkVSICIzLjIuNjEiCiAKICNkZWZpbmUgTUFYX1NVUkZBQ0VTIDMKICNkZWZp
bmUgTUFYX1BMQU5FUyA2Ci0tIAoyLjI0LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
