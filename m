Return-Path: <SRS0=sMqH=7L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF9CC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2020 03:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82631206E2
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2020 03:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cAeskxCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82631206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21F906E856;
	Fri, 29 May 2020 03:28:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73A726E235
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2020 03:28:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkC4futbK6TU7NX7DLUo9c+OazJoTKGHk4iDE5Wp9EAfTrQiOAgO+ao35BI8vzp+79XRUFKp6Mi9b/a0QjzNjWzGYc4DFCa8+i7DVZ8P/SVPUuFz6TLzzHx2SscnK1KQSPSTrL9YdB6sKnfOV8OBq1uhUPoJKfSOCVNjBKELSu5hwJVlNCMMXl9CQz2ji1s2e6W7IVnR+NR7akFdMG9WzML13+LOof78eH01aABI0lg96l9bMnIwmZyJHFwh9SjpRv63NJQdKaob0V0RBety/NerSXsHcThQ7GSB0F0FgF5qkJPVDt7bdsLfzPoMnuIAcpnC0s5iYuwUv3tgHZb6Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4+pR7EfX0HlzVSn0GVeLoX+Bg4d2+oW1vg6z9HrEPU=;
 b=EypHDUsWttLO6Rgmv+Wa3S4x2GcN9ntRBzyjx6JIbWmyp6h/tI7mfa76G8hbM0GQO0S53l+jKl6C8Lcu2c3+SydETbVlRZj+FljtC/wHBwqTl9TTFDyDluKXrEsyakCi6z0mm7fPM+y97kRHMHsFZY/ahgmH5Sk4vQvmEZXeVdgEYbIP+Ddnxjp8UGE3AzIH/w3syLwSheRiw/YAopC6cO4R+cD2w2D5s0tn3AlP4uYUGCW7rB01m16i8suUiKBZAhZIGvoVg5J2l3g4TWiytEB/yCSuVeC99+7ISLy+Wby5rSoraNWThTFUU9aSdrEAxCmgYEK/NY/QvR9fI/EtxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4+pR7EfX0HlzVSn0GVeLoX+Bg4d2+oW1vg6z9HrEPU=;
 b=cAeskxCcDH50jm8RrzyWiDkH44/ckwc8c9fgKZXIIyX8pKRfu+YY3frVbYpD6C3mAabcMUXhqOfBrr9NC+CEjtplXWbv16f9FboqN1NVb8vC3IquC+uAKRHE/Mwykws2KEgFHAEIS7J3HgYr8S2RWCX+VIgGOLBhMKkrJDt/czs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 by BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Fri, 29 May
 2020 03:28:14 +0000
Received: from BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::2c8e:6202:8066:9e8]) by BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::2c8e:6202:8066:9e8%7]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 03:28:14 +0000
From: "Prike.Liang" <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: enable renoir discovery for gc info retrieved
Date: Fri, 29 May 2020 11:28:07 +0800
Message-Id: <1590722887-9333-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:202:2e::18) To BY5PR12MB4307.namprd12.prod.outlook.com
 (2603:10b6:a03:20c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (58.247.170.242) by
 HK2PR06CA0006.apcprd06.prod.outlook.com (2603:1096:202:2e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3045.17 via Frontend Transport; Fri, 29 May 2020 03:28:13 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 11c3ad7f-7da9-438a-9dc3-08d80380522e
X-MS-TrafficTypeDiagnostic: BY5PR12MB4244:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB42443AD6E5E9B3B283575429FB8F0@BY5PR12MB4244.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0isV8L8+XSc7czjPC/JQsk1Q3LHI+ie0rs7mhqqKMr7CrR+KoEE0DCi1Oyu9zP+feOpgIilKE3cVyuvWOmjlhOIcnpcFND59yu6Y76tzdQ69MPup5kXWV05eIsqinqugsh9w9SnOukvkdSW9efe+FmDcnmujz+WzWZtLsCuH9uCJd67chqZkgNL0tp1XYGwCo8hbspKYf7WuKgYxsuI/uzebjGNzuzxsWaJQ3PsdMK9wlvlGO28+rF3Pasxg62InCnYKWmHofukLZKLQgu6KBAmq1tSQgYAj5RigZFyDU5nqLr3Wtv1dA3lh3mU0fVIkuXgwh/szCmQwVFt2dxpX6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4307.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(66556008)(52116002)(7696005)(16526019)(83380400001)(186003)(478600001)(26005)(36756003)(86362001)(4326008)(8676002)(8936002)(6666004)(6916009)(2906002)(2616005)(956004)(66476007)(66946007)(5660300002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: sEzJnmjRH8p/jRAxiPO+LjhnxotEJJBBnzJt4qwppk/FR+buH1ZUybjn32XejRcvfQZWq5SeMKrhseQdMdwn5jE1mOW5X9tVjfI8LuMl7DGyhHn3AjG2BwoqGP05ahlxEuT31nMDd4WFn875yM3Jz2rwgWXSQa4dgUjTSKPxmVJPzOEtuMmWWMD2ZfhlHVWTMnzP9vCAhMd3SX0RLSukH8AaQc6X2tV6gY9MH+xWXC9jsTXCCYinAnq2/XE28XTUts30hm11DTRNQGS1qCcuhEuD4NUZXUfKGQg43V40pDHFBHL76o/qulzYfEvcNXc9Ywsfv2mZrE8+IA7B0tulwUHMzNuh9BPhAGuv1WYU5rZwHakxVlzi6gNdRgHRSBsCnMGX1HIGKPX4+o+Jszkm8OJ0oJanhFqubIeCuQWkYacPg51R0sjYKkezTkJ55EqKtR9WcE5bOraW4vqZPwjYlXej/5dPwCdFHOBD+zIpEjWQj2g7ZZvP1oTtjFNgwU2G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c3ad7f-7da9-438a-9dc3-08d80380522e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 03:28:14.4569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/MpGFZ05kPYuqcAZlT/sJLIumFceAQGHNfrqNqvN+viOyNyIIQQJee2qBpTcTPp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244
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
Cc: Alexander.Deucher@amd.com, "Prike.Liang" <Prike.Liang@amd.com>,
 ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use ip discovery GC table instead of gpu info firmware
for exporting gpu info to inquire interface.As Renoir discovery
has same version with Navi1x therefore just enable it same way
as Navi1x.

Signed-off-by: Prike.Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2f0e8da..bff740ccd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1528,7 +1528,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 {
 	const char *chip_name;
 	char fw_name[30];
-	int err;
+	int err, r;
 	const struct gpu_info_firmware_header_v1_0 *hdr;
 
 	adev->firmware.gpu_info_fw = NULL;
@@ -1578,6 +1578,23 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 		chip_name = "arcturus";
 		break;
 	case CHIP_RENOIR:
+		if (amdgpu_discovery) {
+		/**
+		 * For RENOIR series seems needn't reinitialize the reg base again as it already set during
+		 * early init,if any concern here will need export amdgpu_discovery_init() for this case.
+		 */
+		r = amdgpu_discovery_reg_base_init(adev);
+			if (r) {
+				DRM_WARN("failed to get ip discovery table, "
+					"fallback to get gpu info in legacy method\n");
+				goto legacy_gpuinfo;
+			}
+
+			amdgpu_discovery_get_gfx_info(adev);
+
+			return 0;
+		}
+legacy_gpuinfo:
 		chip_name = "renoir";
 		break;
 	case CHIP_NAVI10:
@@ -1617,7 +1634,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 			(const struct gpu_info_firmware_v1_0 *)(adev->firmware.gpu_info_fw->data +
 								le32_to_cpu(hdr->header.ucode_array_offset_bytes));
 
-		if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10) {
+		if (amdgpu_discovery && adev->asic_type >= CHIP_RENOIR && !r) {
 			amdgpu_discovery_get_gfx_info(adev);
 			goto parse_soc_bounding_box;
 		}
@@ -3364,7 +3381,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
 		amdgpu_pmu_fini(adev);
-	if (amdgpu_discovery && adev->asic_type >= CHIP_NAVI10)
+	if (amdgpu_discovery && adev->asic_type >= CHIP_RENOIR)
 		amdgpu_discovery_fini(adev);
 }
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
