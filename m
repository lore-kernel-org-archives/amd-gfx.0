Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63725C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 05:05:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 050F520708
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 05:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="z6KylvT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050F520708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 653086E094;
	Mon,  6 Jul 2020 05:05:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 843ED6E094
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 05:05:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZBnIx7H4+j5FE+ecNQOONGMa1c4x7pLUK3/jyGuLV/Jbdj7piZhd3O+8DBrY9OvM2zFvqmZkT+W2ktyyjOsXccrPrXEt96oU1BfwpF1DdEm8vJvsEyhoPuOvdbxqtplnrUL94PKc01WQP6zKRUJ6kqaXSPljSQj0PmXBnCAKQqri61be8F1MBlO6MDF0ZlLublT5Ou2fo1HDGI90NecTVCAVq5RHZU3ssLXS/8COK+cKP3O+oeg5P9zZbbbyZsOevk0MJtl2TPQ9OOEwdpa79sP1fP5ay069sa5HcPiBEZqkFTCSHI2wDR//6E71abcjs559gSdVagIHF/V+3WEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtrZmcCnD67FQ8Yb2j5VTI2T4ZylUWJjaYuo8jRiuSs=;
 b=fU9w++bIT6cII3GWn3PS2zvrC2n3Ps9C9JtTuqNgPc0uogdNewOo9poc8ftZqrq0r5T6DpCyZr159YTqFlqvSTjaZrkYDBP76yjNSR57eRZ1FHiG/8zR3VoU850VaO8vy5w8dS8CBSTV+28XrXBKAHjkCu0Icm2kKiDN9JbV/ntFWOnlivhW0m6zkrsITo1uo+VtDbiCaXNemhLpmgE6PirVarCw/cjjvyme1pSfo3Qr3Q2nRxSsPCxIVZWMIqtMwPMm2nlG7Iiji3LB0uTP8SKgor5g/GZj4bYMs8HRpUDodyzNfIWgDub2kLPmLoA4ViNt/SY2u+hPKLnlliPrOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtrZmcCnD67FQ8Yb2j5VTI2T4ZylUWJjaYuo8jRiuSs=;
 b=z6KylvT669JOzGy66Cn+Dbap0pwtQ57TZt3mUvxHtMM63Hosd6+cmXfYxGI1M1vfEE/KFJuFxOwEs2eZ/eXLkJ+fMO0NbsdFLzZORL32P0iUacOsQQ/vIWHvC+dAuZQR+nVfvxdoKrUgbhs0JV7n+cyHmEr4pubH3y1HKo6ONaY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Mon, 6 Jul
 2020 05:05:33 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9ca1:81ba:bd45:53f4]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9ca1:81ba:bd45:53f4%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 05:05:33 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/12] drm/amdgpu: add register distance
Date: Mon,  6 Jul 2020 13:04:57 +0800
Message-Id: <20200706050509.714975-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR0302CA0017.apcprd03.prod.outlook.com
 (2603:1096:202::27) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.242) by
 HK2PR0302CA0017.apcprd03.prod.outlook.com (2603:1096:202::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.13 via Frontend Transport; Mon, 6 Jul 2020 05:05:30 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 399b1194-6ad9-4491-dfe9-08d8216a361e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4470555A6DDCD7F4ECCAB1C1EC690@MN2PR12MB4470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xouYqaE7ITkFUkN5uBWww+w0oNCj5DuLn4p0B3wmIOGUK/rrePAgcf+6Fl9zmuQuLZqAy1oxR76F6+pa1GsRhpl9tB1k+OGYlE2oGdG6QyqnQ+VYyzPtx1lJLx2nyLFiaVxr9KcJXN1FE26LYgI0dY9rC6T6xcKk1Al15zJVS+toNIuCXleb/SF7+Ued/+/VbwpxFOTPQHKZpTYsEblzPHwn9L7J4DZi3Cmy4KiYtu0ZtxPHFACQY0jVeGMrngxBXIzTZmIQeds5hDGJmNDzAkDgab6+nh+464UDIQqnussLZbj0Fxy26c0xRK1xUkG5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(6666004)(26005)(54906003)(66476007)(7696005)(52116002)(8936002)(66556008)(66946007)(36756003)(478600001)(5660300002)(86362001)(6916009)(2616005)(186003)(6486002)(2906002)(316002)(1076003)(8676002)(16526019)(956004)(4326008)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: UG3MIEKUjbjK/mi5WG6Pi/sR+aEXUU9hlcVwOxlkf14NQGc10sIYsSVPMkpU5mLkNilwbrFu0NVlndHdC1+WHN3YcLSXGiIdhN/cTSkbqORzuEt0ASDD7u8CmA8BPV9X9eAUQ4+qBYREIegjy25pnxR1DcXo13IXIeGB6yk6ZihPQLngfo2XjoWBRHZD6qnM/jbzx40eNbJKSean0X+wzqSrJWpDY+tMG//AlwYnd2G8NWKxw36MQ22W32NOFdUtGPoc0chdNAvdD0z2z2ODuxqs2N6SJa1bqwd2W75Ri7NLt0ZFOEKzP66Pbf0xUxuP7AtViPnHwt89a+lSaPW4TSeTtJPNne2xfVSvO9z5zA3n+xCAkl2NDdCXkUEHvD/O4fkfoaXODFu3eiTUtNAprf5uekfJ5OPV9/2Xgz5VFQYete/MVfFjswBadKjgC7EM3HQ4IDZTgFTyjTF4iMtpxqAYhs09jg/DOlwWiEYPLw0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399b1194-6ad9-4491-dfe9-08d8216a361e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 05:05:33.3666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TvJyhpVD5kAXa9qORRhIVPuHTqP4ClZhHhCBuhXteOUc1EhJxSXkS5c6X9hRJNQ0XZZt07AHCIC8pqdNJrfjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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
Cc: AnZhong Huang <AnZhong.Huang@amd.com>, Aaron Liu <aaron.liu@amd.com>,
 Huang Rui <ray.huang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Leo Liu <leo.liu@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

During IP block updates in some asic, the register distribution pattern of
context domains and invalidation engines will be changed in gc_v***.h and
mmhub_v***.h. However the register distances are always constant in one IP block
beside gfxhub and mmhub. So we can add register distance member in vmhub
structure to store the register distance value, that's able to avoid the issue
of hardcode at current in future updates.

Thanks,
Ray

Huang Rui (12):
  drm/amdgpu: add register distance members into vmhub structure
  drm/amdgpu: use register distance member instead of hardcode in GMC9
  drm/amdgpu: use register distance member instead of hardcode in GMC10
  drm/amdgpu: use register distance member instead of hardcode in
    VCN1/JEPG1
  drm/amdgpu: use register distance member instead of hardcode in
    UVD7/VCE4
  drm/amdgpu: use register distance member instead of hardcode in
    VCN2/JEPG2
  drm/amdgpu: use register distance member instead of hardcode in gfxhub
    v1
  drm/amdgpu: use register distance member instead of hardcode in gfxhub
    v2
  drm/amdgpu: use register distance member instead of hardcode in gfxhub
    v2.1
  drm/amdgpu: use register distance member instead of hardcode in mmhub
    v1
  drm/amdgpu: use register distance member instead of hardcode in mmhub
    v2
  drm/amdgpu: use register distance member instead of hardcode in mmhub
    v9.4

 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  9 +++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 48 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 47 +++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 47 +++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 43 ++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 39 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  | 45 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 46 +++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c  | 46 +++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |  5 ++-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c    |  3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  5 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  5 ++-
 15 files changed, 260 insertions(+), 132 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
