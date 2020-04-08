Return-Path: <SRS0=b+Zp=5Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E18C2D0EA
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 06:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A51E206A1
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 06:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Pyiy0WHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A51E206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B79C6E956;
	Wed,  8 Apr 2020 06:46:13 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770072.outbound.protection.outlook.com [40.107.77.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B54D36E956
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2020 06:46:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KU/uJZVmB1bFbPZQ2mqHpq8m2H91/eg4kgX1OUqXkTm9FyTrUCIvFHIoEjit6BjRi9+saobUA4mJ5t7qg1mCQFvbomganmVPGh8jq336mSig3xXRJ/8M4mQsXywg6l5d66nREbg4G+ExUkIXbm7WXSH5ABuwplbo+YdpNMusjlZNqVJzbJtpaW/Zz9wv9b2Hy6zD1BwivL2fLVtp74QqACzcB7Hvl4CMn4ricR9e7MCbjySqj7ZdBuyUvhVc3QTGr2mxdyehLQuJK3gzVtEI9VBdh1VSIt8VqfMN1xDPXPBN36Tk2/OUvSmx/0kIzpTXCOHiC1r3V1GyakCUKq8GBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BD5GimncvZSfD6yeYv1Whw873dgAWliAR50rn/O+FgQ=;
 b=ZbVkJ8kv3u3w3+c9GIhgSTxemsDQZxQrKMihNMBTFRs6leYw60WjybzkvqX77nDtKw/TrfSisfv0t9+jES53Cyvi4ekBFF4Zmix2LlLW+ifiLgcZExh3TOioj0oTa3fuN38VJlimqubNoCclgWEXDdgTvfmYkA+/meuWf4UFtlRlUpQNvB1UC5bTPigHmjQ3fzjfIV5KYLsj8TZBcB/37JzZNlBrWtJqyAdLlsgAZpZN+AEpZvEetyfG3C2UTTSrfwRrb3SDsC7cXp74dgz360O7Zm6F8ROLPcty5LsNMf4Z67QIOUz/VkBEfnTHpQqlgY144jk9Qhw1TvUCYIm74w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BD5GimncvZSfD6yeYv1Whw873dgAWliAR50rn/O+FgQ=;
 b=Pyiy0WHz61G38S8f6t+LfcXejUoWODf9dPsBBA60wrd2Ewbl14gB7gQSpvR/n8+9QXLplp695mPUjCiEsknK2IHa+EmX5DDamhE7KNpzxh3KElyoKgHlf9DtHEjhkt7g+mR63Rth38SjbTQZdksc9n++gET3eGRDwVUPEIge4Fs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Aaron.Liu@amd.com; 
Received: from BN6PR1201MB0017.namprd12.prod.outlook.com
 (2603:10b6:405:53::20) by BN6PR1201MB0242.namprd12.prod.outlook.com
 (2603:10b6:405:57::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Wed, 8 Apr
 2020 06:46:08 +0000
Received: from BN6PR1201MB0017.namprd12.prod.outlook.com
 ([fe80::75b3:1647:bfe2:d3a0]) by BN6PR1201MB0017.namprd12.prod.outlook.com
 ([fe80::75b3:1647:bfe2:d3a0%10]) with mapi id 15.20.2878.022; Wed, 8 Apr 2020
 06:46:08 +0000
From: Aaron Liu <aaron.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: unify fw_write_wait for new gfx9 asics
Date: Wed,  8 Apr 2020 14:45:48 +0800
Message-Id: <20200408064548.857-1-aaron.liu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK0PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:203:b0::27) To BN6PR1201MB0017.namprd12.prod.outlook.com
 (2603:10b6:405:53::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aaliu.amd.com (180.167.199.189) by
 HK0PR03CA0111.apcprd03.prod.outlook.com (2603:1096:203:b0::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Wed, 8 Apr 2020 06:46:06 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 29227e82-14a9-4ea3-c129-08d7db88846d
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0242:|BN6PR1201MB0242:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0242E4726607019FE8FF5E13F0C00@BN6PR1201MB0242.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:529;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0017.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(39850400004)(376002)(396003)(346002)(366004)(6486002)(66476007)(478600001)(66556008)(66946007)(2616005)(16526019)(2906002)(6666004)(4744005)(186003)(6916009)(81166007)(36756003)(4326008)(8936002)(81156014)(316002)(5660300002)(956004)(52116002)(86362001)(1076003)(7696005)(44832011)(26005)(8676002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ISLulIXhaT2dTOAo9cxfWvZCINbj9Yl1xhY8qGT7pt02IYG4ooOip6QXzgv6KMPjF1S8TtYjrCcmenMGvsXw1wtKEjIp5QJ8i+zCR5K25gk27ESFs29GORhLo4SpHu4iAny2CCSyTGve3fofmnffNSWns0FNRVZzu8C8hccZ2uYUNEa1g2+pGfa8+PtlLU3fnj8moifIWpusCnw3pHjSZ93QHN5pNq2uu4KDY0Yosa54B83VFzTKFj6twQF9Uek9oZKFLmdbZkbnaHoUVUNL9OD6Fni2yU0CevP+wJOPCQSJsvaxcB+z2y0/jTbNuosMRD6ihlp4isuEvLu0WKAjC7Lu2LpB+62EJtzHetH19BxB/cQyOfmGIJPHO0aGmAgZBZe5fF4HQQYw5OaCIXDTbhtCyXc6/FvpA4bCao1vNlgzrhJyawiqgn5AFnHVryI3
X-MS-Exchange-AntiSpam-MessageData: R5yagTtMlusywyLx04pMJ+4JHVraQigNTOz6Y/dboc075Egii4ItKB+Cfh937qMmA2+0ACQ3fjZ+/jVnXk4A7nuRwWTSlcTKOJgPNM5gixowf4fnV+qZpLFqBFXO9uInaFSNTsjTYolhPs//8D8zGA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29227e82-14a9-4ea3-c129-08d7db88846d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 06:46:08.4063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlMDJ1efnhhNZZJGGFA8W7alW5vtOMIjfeHeuWAuUSbmbiMrwswC/plK2L9VEoSl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0242
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
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, Aaron Liu <aaron.liu@amd.com>,
 Yuxian.Dai@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make the fw_write_wait default case true since presumably all new
gfx9 asics will have updated firmware. That is using unique WAIT_REG_MEM
packet with opration=1.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 2d56b06722bc..1d18447129b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1214,6 +1214,8 @@ static void gfx_v9_0_check_fw_write_wait(struct amdgpu_device *adev)
 			adev->gfx.mec_fw_write_wait = true;
 		break;
 	default:
+		adev->gfx.me_fw_write_wait = true;
+		adev->gfx.mec_fw_write_wait = true;
 		break;
 	}
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
