Return-Path: <SRS0=Rlnb=AT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086F6C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 05:25:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD59720774
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 05:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IzSYrw5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD59720774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91B366E0F2;
	Wed,  8 Jul 2020 05:25:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80FEF6E0F2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2020 05:25:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeEjH7x0RLqiBo5XYbjtmMEXMp7cnKjKuQZlxm6Rt1GlRlyojGYqL4EJJDmKvywDjeRfQm58lqXTquMGLn8Z4zLtWWEMXdiajTE4rcNOA31aqleFlvjLuw9N17iB276QKTSoY42U32VZ0R8UdY+DjeMnKjhfdz8ltCImylhlcGFdMWQjGwIqnV+0mHnv3Ch4UMEhOTpnlu+nC6D+GqSQ/1KfON3oB2i91jsqWXch4N0ESG39S1zG92p0oxHiOgpPbEYrTosEQEXX2MlKMOFDbBKjkNoUuyMHXgQuQJZ5mi+rwKXRdQF7zsOWQ5+YYdkiKph5h9yqopP/0P740K2U4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CAj5mRxeUARqshkySAczLoIL6EM9djEVEC3lGOMWBk=;
 b=ZLegX7Zo+Bje/NOuS40Qv0YkLGnMCn4Ro7caI8Gq6LbJ9r30oHFm/1UYWmaIIAyOCPLCm08s7XLOzteDsDWd6wOIjfLPFSsBGYANV+akwea2h511lL85mQ770jrDBds7tHbi2T+uW3U5lnGVhadRSEHU3gvyF59sfvkGKRD7nFoKBdON7QvDpg0IPr32ZsthuitIw8RieJ6GsE9xLzcUMQpW/bexu5AuQ3+4kuXdqB8x1/7MgB0nGILbn0npj6xEB0CgGe399/RE5Qy9BPobIsJ1rIlY2yThFMvIzMvSpr6/DnZ8/uZWifUO6PfjFuF7dl4pdDlSlhy4Dt3hxzSHmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CAj5mRxeUARqshkySAczLoIL6EM9djEVEC3lGOMWBk=;
 b=IzSYrw5VmpLBhZPiQylxpvKjp8SFLXT5QXxhnr1lppBd8PG4w+eu9PVonOVsCIx7g1U19EIgF1cVXIwzhgE9ba34xcFraHk5DUKgu92wulM7w89nkHCp1mQGIe5JfR1vLoB4EUrVURuQCsQXW1SX8NRrp4FkMK926fPcnOCrfh4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1843.namprd12.prod.outlook.com (2603:10b6:404:101::21)
 by BN8PR12MB3379.namprd12.prod.outlook.com (2603:10b6:408:42::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 05:25:04 +0000
Received: from BN6PR12MB1843.namprd12.prod.outlook.com
 ([fe80::4572:70c:85c9:c8a3]) by BN6PR12MB1843.namprd12.prod.outlook.com
 ([fe80::4572:70c:85c9:c8a3%3]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 05:25:04 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: enable gpu recovery for sienna cichlid
Date: Wed,  8 Jul 2020 13:24:42 +0800
Message-Id: <20200708052442.3007409-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR02CA0162.apcprd02.prod.outlook.com
 (2603:1096:201:1f::22) To BN6PR12MB1843.namprd12.prod.outlook.com
 (2603:10b6:404:101::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HK2PR02CA0162.apcprd02.prod.outlook.com (2603:1096:201:1f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 05:25:02 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1f97e032-802f-40f0-6336-08d822ff44d6
X-MS-TrafficTypeDiagnostic: BN8PR12MB3379:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3379C54B7C34158162EC773DEF670@BN8PR12MB3379.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ap7GoL9quckliKNw5wHA6AaW7T57AkWtgwaLNCyqQXgSPWnLKY5IPmJ0Mw3bDOkZysIxOXh6oMW3TzaD1Ur6Ne5fYNh6g/tCWbKU/9y3h0kR903UG5zsPvHGZhdEudTWPMLQmxiAZ0FVaI1YYT78KUjwULBbS9qp8kGQOkH+TQSOP0D7LJgpWRqUkxmRgJb1mE4LvTUJmNiOdfKHRj0+R5V5h979oyCArQy2mFYK/pHq2OaK5wWojhmAjtVbZ9RidI7xx7nIIx4f50vnViPD9XyV/ZkIDInHbVvtfWvz2sPA0KJ4gSpbIOC57Rm1oIoS3B5HZVdoikEoG+j/V0a93A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1843.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(39850400004)(366004)(136003)(956004)(478600001)(8676002)(8936002)(26005)(4326008)(316002)(7696005)(52116002)(54906003)(86362001)(6916009)(36756003)(16526019)(186003)(6486002)(83380400001)(1076003)(44832011)(2906002)(2616005)(4744005)(66946007)(5660300002)(66556008)(66476007)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Qepppt8HdA5IJ5Ycnl9UgY93pUqBgYTGiZzzgwZsRQGpkqLGVy/hfGDsCOYRTm5kz5ZXp5Y4OnQIMMddq+FkpTmmpDt2eXSVmOQtRiHrK9tqW2q9bNTqLLK72QuAvenvR0lGJbApu1vNgnT65wlURxaW+sISXvQs0jnjOodrpG4+qTpsf/6uIgkO2obu5mmTkKRpbSh5kvKogn1zBklGJddEPxE6oamt2oXXWvIso9ZMdJ+lSrijuKTFTp5YCkHeYNFO7p9UCgEw3s+n3+/bkYp9TDrHXlr6zPbYMKRPcGRi1PWApSqr4y/jJ5jvyoVFGp2C9aF34tAc5VaqeDTDpgCsIiVBFiZwUaYng7AnERzQESzxN/bWEkm1k6uECMo3XjNr74yZjBqbhXbaXJjyasXUstO9Dha2dQzxW4H3nvQZLNMRj0uldq/t9MZg4cv6bYCS3eZKm93zq2dFrwp0VtFtsyNwk1O3wz2GHnbS6Bqq0s8qiJLpDJTjGnzoKlh+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f97e032-802f-40f0-6336-08d822ff44d6
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 05:25:04.4138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: saR5mkNlU5RTZDYt28wpvGT7tcGhIehqFB2sOv2LEWnP3hs3kCYi4pcXY8+QenXo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3379
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
Cc: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Enable gpu recovery for sienna cichlid by default to trigger
gpu recovery once needed.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Iaf3cfa145bdc8407771d5a26dabb413570980a85
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7a610850a646..2913e41f63a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3936,6 +3936,7 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
 		case CHIP_NAVI10:
 		case CHIP_NAVI14:
 		case CHIP_NAVI12:
+		case CHIP_SIENNA_CICHLID:
 			break;
 		default:
 			goto disabled;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
