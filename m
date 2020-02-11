Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96125C352A3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 11:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62802206D7
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 11:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JBuo8AFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62802206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE1736EA2B;
	Tue, 11 Feb 2020 11:22:59 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690052.outbound.protection.outlook.com [40.107.69.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 924CB6EA1E
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 11:22:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ku87a46JeYtJRbbA4MAkrtdmFK3muRsf2gtRdltt/V9Bz+tDq+E/ti3CwV70gNX62vqibb3OfSwmrvkbwxhUz8Qc8/zOmUVw8yFbOPpGox9L3tKLFWvTQHlBqGL7ktP0d1vbTKMxNlt2iMMyaj22NJUSJmWfx85B0MAGcwK2MayN7GR2iRf/Dt+UawG4oY9Yqsfv1sFzW9J2U4Uvd5R0GHwZypOpiY4kXJMe1WysiQYB9IXkfUPnwqU4T8CeZn6KJMfc4kv1J+EmF+KIWgjuz90lZdP2DHmGTWeIdGZ0WPTe37kHRC8yxyLFsTLKKhnOruYwm6Lz2p4T0RB0SFhJHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjfYaQWL8wmWZORQ/BH9ABaS38Rro0dlUJJ9HHhIvkE=;
 b=LvU+0CZ3oUYsrE4RHt/gJGBWhIpE+OaLLPiAxRtMvkIl+6vTg9y321ZguXrPm0KcqpQeuETbhxSDmd/OGbGqA8LKXfwm+Y8dZr19ghtoxEvD/OXPkoedQSVUCY11J+doluzIwNraaKMdgzejQn2UfSp13nqXagNmGFToOpTHxmAcoUk51/AcFjHhxa1sGVhIlzrFIPaA+uf1zFnpYomeMhZuBSs2Q8D5476kwlLyXWV7jT0ogrDvkuDo67Rcc2uLRuR7foHl/XxXnh8/WR4mRUQCNmgmfyYFSDpv51NTB1eP4j/onBGckdeKcwedU5zHDpQcMTEfnDytNB3ADe0ZsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjfYaQWL8wmWZORQ/BH9ABaS38Rro0dlUJJ9HHhIvkE=;
 b=JBuo8AFHY5omeLNHLEpTMP0t9loVKeOl+GnoNuxzSSPjWwwRP5AntTXrd/yudxz9kx+JXr0p7oUrMSjF5pXjehkjJ/ifBsHhtTFfMArbJuZwvhuYb0LzCyHsQAecYP5XMSmuJ60zAbzSJaOySiPWqNxa6uUJcsJgmHufjntvsF8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB4221.namprd12.prod.outlook.com (52.135.48.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Tue, 11 Feb 2020 11:22:57 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 11:22:56 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH libdrm 0/4] amdgpu: use amdgpu_cs_submit_raw2 for amdgpu tests
Date: Tue, 11 Feb 2020 19:22:59 +0800
Message-Id: <1581420183-14223-1-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR0401CA0018.apcprd04.prod.outlook.com
 (2603:1096:202:2::28) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from hr-intel.amd.com (180.167.199.188) by
 HK2PR0401CA0018.apcprd04.prod.outlook.com (2603:1096:202:2::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2707.21 via Frontend
 Transport; Tue, 11 Feb 2020 11:22:53 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 217e6709-d8f0-4342-683b-08d7aee4be35
X-MS-TrafficTypeDiagnostic: MN2PR12MB4221:|MN2PR12MB4221:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB422159DBE0C5988598D8CE75EC180@MN2PR12MB4221.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(199004)(189003)(7696005)(52116002)(956004)(316002)(8676002)(5660300002)(4326008)(86362001)(2906002)(2616005)(54906003)(81156014)(478600001)(8936002)(6486002)(81166006)(66476007)(66556008)(6916009)(66946007)(36756003)(16526019)(186003)(4744005)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4221;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gm8Z+HDvsVmUUpZhVRBZlkigr01K5dPsXk+JGVEPLM5vX9cUByvYLLhnOMCW85kpZv/HbEeQMnigs198Z5N4wiSmy2ScdBN89siC1xgNlR6kz5ntmsgv7e1rMDdhyYJexW2GWYCVgbLMpuhSFIisEZoog+283wg7XWKR/6XVDB+FOcRHC9bYK2Nd9SrsgVr+3VB87yXk5ARMKwr3pXkIdoWRxn5LaNrQlcrPOk83aAZS8m+HBIawt2JGIsR748sJhbLdelX8ljdpudDk53KoDEeTp4ZFdTS/4/1AEccQYqRffwRsCSwTTVlxACijEZ9KqXoZNAZiwsoV9FnvobTwDdPgQLFB4/e+9Bb4cYA+PrLWWSUA3ZVjIgOSZIB5OrzSfjYAnV4+wCvWhPZ8gZbE+vQC5pFeA0PQ5MAKwwYMIvwnMbIVV/3ZIfnIhv0T6zk+
X-MS-Exchange-AntiSpam-MessageData: HXK8M9RW1eWEJ8NMsHTxXmWsA3YeQk5eAP21elCDWBwE16GgWnuxjpMd8fio9FLpjx9RW7ok3MIglykhx08ywOLRgsy0p9o9bP6xtMzmbFfl8e1ISG28z13n/56rNaZgSJj8ANuceQ6N3R3Cz+JrSQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217e6709-d8f0-4342-683b-08d7aee4be35
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 11:22:56.8349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PsCHIV7nRLzdfylUcgug0fufi+c+Oh7+bMgY5l4FZPHKJ1F6D7BZYcv6W6iGl3wB2awCLjjiNNhYGd1cjbzSVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>,
 Huang Rui <ray.huang@amd.com>, Aaron Liu <aaron.liu@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So far, the amdgpu_cs_submit_raw2 is used for MesaGL, however the amdgpu tests
still use the legacy interface. So we would like to make amdgpu tests verify the
amdgpu_cs_submit_raw2 API.

Thanks,
Ray

Huang Rui (4):
  amdgpu: use alloca for dependencies and sem_dependencies
  amdgpu: use amdgpu_cs_submit_raw2 in amdgpu_cs_submit
  amdgpu: remove the un-used chunk_array
  amdgpu: clean up the cs structure variable

 amdgpu/amdgpu_cs.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
