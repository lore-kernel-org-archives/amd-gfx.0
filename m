Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F9AC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 05:31:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 965D861920
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 05:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965D861920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 073CB6E9B5;
	Tue, 11 May 2021 05:31:57 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770070.outbound.protection.outlook.com [40.107.77.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D49C56E9B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 05:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPz8k1xcJu6YdcmdJJ6DHcQsz3WrJZsON1tyffyOkVDfVnYAFmSvNG30SIhF1VOfFTNIWjhIZDjzq1C8jYjiLGQaadbxAXVP+T32orxDpzg35eICn7C/BCVlEsCAqUb+axNjV08vpVCl+rqE1zS71zRIVwHiEymPm843lLtfaLasXeQ5S8Us7o0t2j1f0npLp0IegzQVoGJFPbPatwokrRLn34j19WVHk677A+LeSXNkUh+dWiqpmI7Oio3eMd9q2UEfi1Otrgs8qdvXw+UrbBNi9in5thYFZ0CbWYKDgdt13ghZo61pozmDJjps7RBkJeiazha0BZg7pUPjweIgGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT1f/9kSF9kCBX7Rd3gtuyWwHdDUYegRtk083vH/BnU=;
 b=jyvrf+33gGdtjaZqWdG9ZC5ueSlbCIVARWDZDI76+pf+sXef+oURChP7rRFG9Baivl/jyFLGvWZ3+Hec+keyS4c0gVWqVLYmzeppIdVO7RcU5H9/hX7YSh5S7ZmhnxV/iXGOfSZPOR8dccL/BfiftwlVY5ZkqIuE5Qu6muiCoOJ2CvjvBXr9zUKp35uKnATjQ7OLK1NakfHiDItptcs1Kev00Z8qgBlclvitAhxSiCSsqVitytKekP1s5cmvL6oq/M/Yh0HZQgOrc2RWD2Hk4Uzp84mhbnm1mtZxZLCjxmZkEr3uVC3ejFpKBsyYNQOYvMhxnyh6jY8dhhdX57gAHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT1f/9kSF9kCBX7Rd3gtuyWwHdDUYegRtk083vH/BnU=;
 b=c4cAIk0vCnEd+TGremw/CxVB6Yv23DHEmYL1yDOCqTC9cLRABZo3FahLcCFaeLhCWKBcVuug4QlfB+GfSDJbRLH+L52wzprvLsNLLhiufStoJNj0sdV0PPnRcw0VOf4L6TXSqKOnmu6zDR/aUaYOw4L+j4TXcloMPWnbLtsUOAw=
Received: from BN9PR03CA0289.namprd03.prod.outlook.com (2603:10b6:408:f5::24)
 by CY4PR12MB1765.namprd12.prod.outlook.com (2603:10b6:903:120::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Tue, 11 May
 2021 05:31:53 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::ff) by BN9PR03CA0289.outlook.office365.com
 (2603:10b6:408:f5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend
 Transport; Tue, 11 May 2021 05:31:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Tue, 11 May 2021 05:31:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 11 May
 2021 00:31:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 11 May
 2021 00:31:52 -0500
Received: from willgu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 11 May 2021 00:31:51 -0500
From: Jiawei Gu <Jiawei.Gu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Field type update in drm_amdgpu_info_vbios
Date: Tue, 11 May 2021 13:31:09 +0800
Message-ID: <20210511053109.28816-1-Jiawei.Gu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ed4b7e2-2b80-4136-b89e-08d9143e1598
X-MS-TrafficTypeDiagnostic: CY4PR12MB1765:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1765FF0D26BE8E588A4FAED7F8539@CY4PR12MB1765.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: anYTIWLHoHuHBJyJ/+AfLstn5SKD9GApiM99S1mcnJlHilfyfUnngypD2JqpLl9MEPbK2WJIAzVqFlVpE2m8/JsBbiqRWqpJDNaHwFolz+CTqlUNA+3j5VxP6UZFojAiPo5Bh/crw0+IP4q9skKOpKl7kESosCe1AWfzEzXFCD/7+XZyEFp9w/Juca1rT+zTqt2kyU/91tIE+or8gw4bM/95BBnckGGUvevxpNwihKH0qKXpuXNTvTh2TXyfG06n0BX8j9A3JWsfhx9byIVDLaOEnGhmW2XvqAtEreCMpvHWUk3VIGXdRmOcs8bIEbnKxkhUsmB11zfT9UFfnfyBT/3Xr3Qh1GMKGRnJ1g0P9EpE4xwW1z1ZufEUEqjM+SRbSZfZJnjubDO6tVyVEKfmeQaKFZukPbhWO9Rz8I6puTqGow92DHv89iyaLpBPgWxYLFozdMZVNovAvxqOTuaLYYB9bGsZ4PdXUao34XmSkuO9Jsdsxpo5RkftLxmrNVyjARDeM7ubvtfn3Ow40xPOs83e2yB2agkD5dCKy1rpqJGPhaJahcTl8McPjqPqkPrgWAsj3VYf838Npq4apoQZT3tb+HZhDEipiyUBRWs+mr8Vf7xgfmatwwyCcwGN5JZsMWkxD3cZ2UUhgsDeq9nH/Ni++HkybZcGBgiNMpSwa0qroDhtz2iYbkxvucjQrW7M
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39850400004)(346002)(396003)(36840700001)(46966006)(81166007)(2616005)(356005)(426003)(316002)(47076005)(6666004)(82740400003)(82310400003)(7696005)(478600001)(36756003)(70206006)(6916009)(86362001)(5660300002)(1076003)(83380400001)(26005)(8676002)(336012)(70586007)(36860700001)(2906002)(8936002)(4326008)(186003)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 05:31:53.2064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed4b7e2-2b80-4136-b89e-08d9143e1598
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1765
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
Cc: tom.stdenis@amd.com, Jiawei Gu <Jiawei.Gu@amd.com>, keescook@chromium.org,
 david.nieto@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use numeric type serial in drm_amdgpu_info_vbios instead.

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
 include/uapi/drm/amdgpu_drm.h           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 75f34a9008e7..e1008a79b441 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -871,7 +871,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			memcpy(vbios_info.vbios_pn, atom_context->vbios_pn, sizeof(atom_context->vbios_pn));
 			vbios_info.version = atom_context->version;
 			memcpy(vbios_info.date, atom_context->date, sizeof(atom_context->date));
-			memcpy(vbios_info.serial, adev->serial, sizeof(adev->serial));
+			vbios_info.serial = adev->unique_id;
 			vbios_info.dev_id = adev->pdev->device;
 			vbios_info.rev_id = adev->pdev->revision;
 			vbios_info.sub_dev_id = atom_context->sub_dev_id;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 2b487a8d2727..2d9e84658bbc 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -957,7 +957,7 @@ struct drm_amdgpu_info_vbios {
 	__u8 vbios_pn[64];
 	__u32 version;
 	__u8 date[32];
-	__u8 serial[16];
+	__u64 serial;
 	__u32 dev_id;
 	__u32 rev_id;
 	__u32 sub_dev_id;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
