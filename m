Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD31C388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 02:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC2522384
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 02:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jCEcAsfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC2522384
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6427A6EC79;
	Wed, 28 Oct 2020 02:46:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1153D6EC79
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 02:46:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+L+87jek2GNhYkPM+VusxAyQPUwnUjqlPpn43QMlEVD8U/tASZXWQ87wdWaeW2qRjPYYnjiL3J/qDGjcbn8fPXnOrQaPnsHXCEvfCEn5dArZvBIoADGbC22HjnDx6pdpEMd3+ofN38bhrdsl3o/rb9SLeicBSDbFeG9LbeAURqbH6tdmjj+txv581DAm11gYQfAGrlumCBa7zmFxgxEajYu0Ic9UvnpmOEWpZQfTMR5Eud+py92nbVsceKG2+mQ6nDauOxI4oWdgu61jfHGU9128gC/mMzm4k1BuIjMvaF3d451KfE7LnPyS45coVrNMYz3H8aQm0+GZKd730Mxjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Om8ZL18XiD7GzYWE5t0OKWJ584HS7PkQaZz0/bZT/f8=;
 b=N37Nc4mK4zFaVtqxKVnpQSjERjIZSvqLD2R1cvsxcvq3mnKvHm7N9rSPYW4zb2CxSHCrteo7xmleZYju/PgCUUpWCdcNWSjLLITApnTrorF4vfXqXfUcn2nM/gx53cEe4ssPa+mPRgN8HlfCDFhEr9Cy+nrOloqqb3LGGspzlL2fVdEMQ1NTk8pjD0EkSmQyHOn0kT6k7syRYsHF6SHG40E5Og3Pt23c0RNVPJeUfObrluPLsUQC05G/SVvpQLoxYSJL2DU8yL8S/HBPHbvNIvB2iSqKa/Y7fooDMzqhdgcTystLJscy8UrROMCj2HcQ79U4/ebvdWGeayemdx8AVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Om8ZL18XiD7GzYWE5t0OKWJ584HS7PkQaZz0/bZT/f8=;
 b=jCEcAsfmfavvRxUzWb/UJiY3ir3jZKbsj69YrHoTV2/bJS4Hpp4YqX5GnzUWifhjgksg4J7NofVI8oS9VNMyJbsgAhZzdU0O/12oeKz1RBUwYPAjVB5mfzw/9ACzrlJhErD8SNvutCoALQWdN+8E9OUA9VQb3TJ+DtgwgYA9LLE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0220.namprd12.prod.outlook.com (2603:10b6:4:4e::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Wed, 28 Oct 2020 02:46:11 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 02:46:11 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/pm: fix compile warnings about variable used
 uninitialized
Date: Wed, 28 Oct 2020 10:45:41 +0800
Message-Id: <20201028024541.1164776-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201028024541.1164776-1-evan.quan@amd.com>
References: <20201028024541.1164776-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HKAPR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:d0::21) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR04CA0011.apcprd04.prod.outlook.com (2603:1096:203:d0::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 02:46:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5fddbbca-8fb5-4d9b-6257-08d87aeba0ea
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0220:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB022005B464EE29651C2D2875E4170@DM5PR1201MB0220.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KuJ2U+I7jTdmrWRJKXoZdyrskAqk6cLKyNe6sn9wfQ9Or5pAmOeLio+nx80ns12yGvgZiHAZ7pfDN2HOWUjeu9lMsFTCLO70L80TCid0D5u5/kl0Z8Pdi3IcTFndLd273NHRD1mozui649CrTgNlZe/oAg4xNfiieaw+yTBUHelRwaKdezpxZorSxaia8Tv+Ryk2D+3Nu49Hp39zR6Dq9OCtr824b3XZQ2zDHgZP3NHG3OZpdI3WN66qB7/+AsqTPQJTCJumj3PLR4/sjOEtCzXIjVUiueNkOo5bwl46hVkITbuscKPqFvm7OFGYfpUb3hTUp/Knw/ZTzAf/h++7BQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(186003)(478600001)(54906003)(2906002)(2616005)(6486002)(1076003)(8936002)(8676002)(36756003)(86362001)(83380400001)(956004)(66946007)(44832011)(6916009)(66476007)(6666004)(316002)(26005)(16526019)(7696005)(66556008)(52116002)(5660300002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: kjPJIA8UuFrdfaV0YMIDqIp8TZTL54n0FcNVpU6D+YcUxEtYeY/Hs5A8RfDsmDOuw65zD9/xfepK0qJ3cAopBTfx4m7KTd7aFS6Auh9+nipv88emB2ui4zvlLtGzAvG3ZuQMWuGnkS89HJnNVGbCUgbGUpHt7o4ex4Hu3ocv9xmJINTDQbiw5ongIWjo9+AhwTAahiOXqSaaMyg96/94wc7c3xNT9VBuVe81O3D1k55vMtUUrxlJwqEKHc3C/tuym/trm/w2eMfrDbG/vpjQ+oKJZbUVdaM6HLNpweZEM4zt45jAvi8rDEYD0iditNc6P4GXIzO3TkUsrLI6CCmyqQpqTapmBFmaTti8vLctPrZOxmq3aUXOEZaLxaV26aSRZadyDJfkpgwlJD7wXyApviy3QD9ecrK8/praENCvJtgjp91qLH3PSPiZp+H4q67boinzdCoyUGSIAGFyvCnPmc8ibGKBGvxjDaCzHSUYZzVvrulyDQhVivVEnKy2l+Je6bQI3xhO8zW9TXL0OSm7p3BvBPRljjgDOKlcmfvI9jLxWvtQxGj3BwFI24bwgfGJ3oviJtdrp2qNG0XKRZs8xX0s33UH6T0217czWinI35F2fblSel+JvqwLLQXWIkhsAE3u2HIAfRYiGqioil0WiA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fddbbca-8fb5-4d9b-6257-08d87aeba0ea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 02:46:11.4310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRH5WuDL6t+KvK8FAp1WDQ4yhm0IIUjewQIrNnqVXl4Z7rrgQKvjg8t0HMmCNQMB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0220
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the compile warnings below:
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1743:13: warning: variable 'min' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/smu7_hwmgr.c:1743:13: warning: variable 'max' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]

Change-Id: Id2dece80162cd10f004abbf3b62cba0c84e988f2
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 49db61a89505..5937150e6b37 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -1856,7 +1856,7 @@ static int smu7_calculate_ro_range(struct pp_hwmgr *hwmgr)
 {
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
 	struct amdgpu_device *adev = hwmgr->adev;
-	uint32_t asicrev1, evv_revision, max, min;
+	uint32_t asicrev1, evv_revision, max = 0, min = 0;
 
 	atomctrl_read_efuse(hwmgr, STRAP_EVV_REVISION_LSB, STRAP_EVV_REVISION_MSB,
 			&evv_revision);
@@ -1893,8 +1893,7 @@ static int smu7_calculate_ro_range(struct pp_hwmgr *hwmgr)
 				max = 2500;
 			}
 		}
-	} else if ((hwmgr->chip_id == CHIP_POLARIS11) ||
-		   (hwmgr->chip_id == CHIP_POLARIS12)) {
+	} else {
 		min = 1100;
 		max = 2100;
 	}
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
