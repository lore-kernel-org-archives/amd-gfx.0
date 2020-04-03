Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9353C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 16:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD79B206F8
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 16:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tgGELTjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD79B206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 523A76E15F;
	Fri,  3 Apr 2020 16:32:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E17136E15F
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 16:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Clal5t9fJ4BXiT4zmZLci5LbFYcqzi890BjS1HcPEnAJU0jtxlw5A9MlrF1igGfMDFjtp5BIMAGtVfzGZbF9BD9ZmjLprqjLULtgozOKVnRFzTmR7e5G0ZlxX/d2+I1VrTvyS31b9B1YCUUvEz/VCeIo8L7tr/L5l/OaTijZTCqfzo0DrBdPtuTz1qeutIg13CW4/7sTxummwGdm1TMBsgB/V2P37UuCbuvORRf7lyhYgLnnHpUDPPaKzYokJg8WTGgC64u6qN9/f5Ts3BissifirJtmRI8gQHYHyCqjNYL15KmPVmPSEfia5hkVlNmhvICDF+BgYIsEJKffMNVvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlymnkIlx6IJ6B05cN5KcJixFqIItZpk8VoOwIvaNS0=;
 b=jbsNOV3PW5BdL/MDG5KjuPL26UVVCrA/lXCt3W5HXx+nBkZw5YO6pgnXroyvXjLsoHnELZlPChqAcJgfGaPyNiG5TjRX5fGUyeyZgirw9c+/q0+LqyddvPayWYloyb6xFmEMVZqmUsUom5FT6V1x4V02PXBqBAqlxDVhImk9b0mOyxwfFi2MXDonYr0KpAccRUF69U3D9MEoFq4ODxO5ydKkiV/w8f3kBTHO9AkMghuhzTZLPppSc40NJoUhdqC+YotGMqy68fD9/vIDSo5zd5PYuOoeY8ROsVUbiA+RI1nBj4nSWPyrcnFcZMcSNTa1kMFXPTcn2+5ZuZTkR7hczA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlymnkIlx6IJ6B05cN5KcJixFqIItZpk8VoOwIvaNS0=;
 b=tgGELTjl2M4xE5qitJ36/Rdx2swqerwbHBQcDbsw1ul1HcTMenuhp1uNQuWvEaxsotVJhsPLwgeelKveP1ojB4k00KDZPuhe9xylnWXNb0avk20Y13qjC6fSV+TZGtrKm8VROOGnLMCLQntqzdhPQfXHuBtj9e0woUtDydgTn00=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3130.namprd12.prod.outlook.com (2603:10b6:5:11b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Fri, 3 Apr
 2020 16:32:02 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2878.018; Fri, 3 Apr 2020
 16:32:02 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Re-enable FRU check for most models v2
Date: Fri,  3 Apr 2020 12:31:53 -0400
Message-Id: <20200403163153.19298-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::30) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTOPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Fri, 3 Apr 2020 16:32:02 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a83ced5a-5d7f-4958-d99b-08d7d7ec8a1c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3130:|DM6PR12MB3130:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31300BCB551C8443DBA46B5C85C70@DM6PR12MB3130.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(81166006)(44832011)(81156014)(956004)(8676002)(2616005)(186003)(16526019)(478600001)(4326008)(1076003)(86362001)(36756003)(6486002)(2906002)(316002)(7696005)(52116002)(66946007)(6666004)(6916009)(66476007)(26005)(66556008)(8936002)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wKrFMLhwfezvPWAqUrLPV9LTs/O64hQbYuxA6EM/ScgEFUE0DzvIhKWbwwycvfRcL+54v/v6ouWwWoc0goXYYU6qHWSwNWUteoHPu0Wdg/E5QXYRTA+s1Rn6N6gm8oL8WpetGTS9wulKIR2hwgopNLIYWU0lU1fl2MDaHg5kx7hTxTx+QGHvpZBhE5xDre7ZuyI6+Gw4uHegixHoGzA0BhfX4+8N/sNwmjBl8b6Uv90hN5LqaPvD7T/pHmxyajD17+I8WrRWrA3CvnLSmk3xojIkdQi8WpVAvLkwmiZyTWgkprMHuP55i6Ak0Ta0sID+8gmkt1PZbIT5ZRNMf3mPKMnxudq33t37OlJuDiBJN+uaLrvrWy8vTfOHczUCzBLIcA+7G+jllN8FekSeVJfqUtSdAGRvn98JMW+hT7Iomok+qCbWSFslzGMN3ZXt7xGg
X-MS-Exchange-AntiSpam-MessageData: P5rOmFUgO99aGiMDEgDlEexFLVW0hGYdqhXhyAYcQ6llypRc4BplFaz6QyPOesEmXrtjofV41/URDXp5gsDWurxm6lHIk3nw0LFhH73dJFeG4u9ZNb91bcnDc/BvzCSCtI6jOWEUZEYRU3OMmRLp3w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a83ced5a-5d7f-4958-d99b-08d7d7ec8a1c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 16:32:02.7853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+IXpa1Z/iJHZp5lbwN6Sz65mNnt/6rH5OtomWWNxcCpLQo8cCv/Hjjs6z2HdT+xb73m2ct+XshvNYVO/MtCww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3130
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

There are 2 VG20 SKUs that do not have the FRU on there, and trying to read
that will cause a hang. For now, check for the gaming SKU until a proper
fix can be implemented. This re-enables serial number reporting for
server cards

v2: Add ASIC check

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index bfe4259f9508..9582469a70cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -31,9 +31,21 @@
 
 bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 {
-	/* TODO: Resolve supported ASIC type */
+	struct atom_context *atom_ctx = adev->mode_info.atom_context;
 
-	return false;
+	if (!atom_ctx)
+		return false;
+
+	/* TODO: Gaming SKUs don't have the FRU EEPROM.
+	 * Use this to address hangs on modprobe on gaming SKUs
+	 * until a proper solution can be implemented
+	 */
+	if (adev->asic_type == CHIP_VEGA20)
+		if (strnstr(atom_ctx->vbios_version, "D360",
+				sizeof(atom_ctx->vbios_version)))
+			return false;
+
+	return true;
 }
 
 int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
