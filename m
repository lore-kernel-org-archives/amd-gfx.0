Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3603C00A89
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 16:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FEA121D91
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 16:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aQI5rim1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FEA121D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2B396E107;
	Mon,  2 Nov 2020 16:27:38 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770087.outbound.protection.outlook.com [40.107.77.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEEBC6E107
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2020 16:27:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awRIKzC3YZLHhvJW2EtMPaZpPlnjHc8vFNbXoo9CGHmjsz2s4puAZlgijaaTj1Bj328a/zUzULju3rgd7SsL3km1/j9eHz+BZ/MOhMdAIRnj54f5VSjoFO60S8kcqhgTD1tIx2e3hbLeqJFU+h3PEY/8uhNTCBQAaydInnTjB74u8s3y25WaT3KUe6SaS4EvUm4OUh3Lxy1uNTXZqOeoe+CueXgxQnIhyZnj+nsOOP4QH94ui8xvRGQH3Xap6TVC2QqqUaUG9bwZg4JlfqWO0e9JJ9AhK202ENBDWF+yE/iwBIGvhTDO/BCf6uJlRe2Y/+iM4EFVSofmo29JYXGRhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3OwIDWxm+je5q/GFUfTdMm/0PvGKS1EnlHsjP/75SM=;
 b=iu0YVJEMCgyJBffdf0PPGhtAoo3jvX4MepQjSNDhOQmPINYQ9obNPt1lyGHqcmMfU+FQYG0A7i4zgWHKqA27TUb5Xwf/ZZd2YyFzseHLXOEnDCOhUjGUySRKv3oAgX3j9Gwha21Zk+Oz72eu5MQkVLdNV9/sU5o+nuvB8E2HwXbO/3P47Uepe0o4CrdPIok3ssPk3KrS1xmIt+upcm6AQ0J0yZiBc/VHlAH1uUdHpeLyJUadwPlCKk3b9lANRL1OXm+x3HK15n7T0LA3pAOK2DJbi+2dVGcL3u8uk18zET+LV9VqAWKD4kMsG1lRgB/0kbgTcr9Ia1qSUxGSQ+ydyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3OwIDWxm+je5q/GFUfTdMm/0PvGKS1EnlHsjP/75SM=;
 b=aQI5rim14c/OuRBltRtOSRUln6Lhhl5TAOSxM8BKG3u7ihcdm1qdqQgLnpMP0Gb2/ArJpgooPoDVpoQpM7tKySlkYoFlzB+59kqkKUg6yNWT7OLY9XuojNqUh1omp8OTECOu+xxYrDocq+tlVKQUuXB8LaY/0cLDBPJRSvzup80=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM5PR1201MB0154.namprd12.prod.outlook.com (2603:10b6:4:58::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 2 Nov
 2020 16:27:34 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1%4]) with mapi id 15.20.3499.029; Mon, 2 Nov 2020
 16:27:34 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] amdkfd: Check kvmalloc return before memcpy
Date: Mon,  2 Nov 2020 11:27:24 -0500
Message-Id: <20201102162724.14396-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::29) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YT1PR01CA0060.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.27 via Frontend Transport; Mon, 2 Nov 2020 16:27:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7cfb486d-5037-4546-f4f6-08d87f4c3406
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0154:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0154475112083135E6E93DEB85100@DM5PR1201MB0154.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KDPNxMHOQTyseYsX2xLXD3FFUrwxQLltH3S68bOeFeFl8a/uGYch1ib2CGRt9QpsQH0zktSzZSeHAqjFs/ifHRi0MHR2Jw26Zc5bSuMy/ohEZyHWirdV9jKoGG1BNc5/BCkhBcuSGEpiDWWPGmj1QOkCKWu4Xr39RiR2CfxLF7SutvcayVRGL31A3plWkgEu/gRWQoSu41CJNo3byNqcTICwjnf1tShcHIbsb6ymF4AKKF2Vm3Xoe+ubnjDc5ETWEwjTNZnP/+Utz3FWICTL397qDDbTap9F3uOE5OUWDIXIo9oL3JMaL58VAIko1vNvjP5T8a5fdfYEcL/DT37UqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(6486002)(8936002)(86362001)(956004)(2616005)(5660300002)(44832011)(478600001)(26005)(186003)(16526019)(36756003)(316002)(8676002)(66946007)(66476007)(4744005)(1076003)(66556008)(52116002)(7696005)(6916009)(2906002)(4326008)(6666004)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: nfWdbSEoMccSvbmkIv43qIa7IzGRYXDFsdEQ6IYMBXF2nd5fHUu2wK0s6V141sNzwvGWbaLfnU6WT1V/7IWED7SmAsSC8O61IBNgLilj51myPNzHcbXCKyVmbJzJps2NkLaM2Su/ix0X513XJ9MLPLLY6z2Q4QytxhQ18vax1ztwP0CdQemAEPoKoZedTcSzPRC5GuhUDUmuAd/hzy01Llc1A92/qO972LBmXUZre2iz7vtc9WRJhe02eZz8XZocbgMY1tgnya4f0y3NO+N1xWyxPi1puCYfpsNdns/p1ZarXZqZH1e5eeluNZDWQoYJwg8OWfFO3148J0gjgZj/AetX4btPy0AoGG5+wWP9eYWFCtddO6mGO7Zcwk32m8odcCDp5JlWKKmlO96AAHD2ir9LmwD6YUHA78goBL6tMjL+DBmGF2C9Y9zewHvSSB5WLn7Sv6NTVeJ2jAmXTn4Dh6kvW9Zp+k7mxYpFkef95Zo4AC8FDBBSFYNzRmtb4Jfdn57zqByc168fjfg7lu+vVQvJrERC8f46sg8CWSGiwQcAKJ/8S4WI8NTlyrK2fKvhQMV3/Kzy+tJwQbxmjcAjOr9avoYhrmWLbXeF0nkCWMpcs4rfVMufDsSIi7JJ0+SRthCK4c7kwwFQOcJU91wboA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfb486d-5037-4546-f4f6-08d87f4c3406
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 16:27:34.2397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvfV4E0NtoaGm9a5zSXon4gG9Ei+OnIHfAXI/wd1JSG7TdONi/nYYdFFKBJO+3FvCITzTXrpo0Wf+YJlurvzww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0154
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If we can't kvmalloc the pcrat_image, then we shouldn't memcpy

Signed-off-by: Kent Russell <kent.russell@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index cdd5032d5c0e..a0acf2310357 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -804,10 +804,10 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 	}
 
 	pcrat_image = kvmalloc(crat_table->length, GFP_KERNEL);
-	memcpy(pcrat_image, crat_table, crat_table->length);
 	if (!pcrat_image)
 		return -ENOMEM;
 
+	memcpy(pcrat_image, crat_table, crat_table->length);
 	*crat_image = pcrat_image;
 	*size = crat_table->length;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
