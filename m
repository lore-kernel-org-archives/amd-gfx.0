Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB92C433F2
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:50:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC2F20714
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 07:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FO/x/g/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC2F20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 539FE6E222;
	Tue, 28 Jul 2020 07:50:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2BCF6E222
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 07:50:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GG+HkkEJyXu2vrpa6v3WLWSpvVt/Z++ZHbS2qOaKGlL8zR9HC+ddiXeKnjmogrqCaWbdqqiYfuYgZ04alI6aIUi9q3K/FP6dD+OQ6i2TZoBE43SwvduauJv4Gb4VC/3dqFAF3/tZR6PSJLn5rJU/3TKZjvhdwm6OyCg0hfTFXNsppzeiVRGkw+Z5BXgSRblkiubuCwa4aSVcd/ByzxX22ObcIvA4i6uKT9tNofZdp4tetQ+sve1CaCNs2uR9tb8e+Vry/K4Chm3oc1CT2kmO2Cii6IA93sqHs1OBshRSBaCrJW63TBPfTwW0fgSBl2oq/8SiTfFjw4LSS/TbxpCfiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Umu47EqHauQwxf8D2nwTZoIR5PIFAXpVp7couoCAcL8=;
 b=gPX3jP02MfSAJliGFXPfRAh1H0+90sDffCXjtrSlOILAtKUFvOosQzziPX4vUQ6gjV7qFDO43AnfCM6+u87aMNkC5p2wqZE8PaeJE/h4jTHdFVShUZwsLVM7/HzdLmpj9RneIyrj5onS1aWe3vINkfjPCKEJOnLdioMP7J8Ibav8GVkBYcjOtOMfdowDUdc1UJCOo12wSfHdULSGqAZ9SZ9KqdAyo2h3R7cNLnq3hVRu0mJlYBII1GXRatzdd9rJe1wgESMMcDpC5JB8Wz4WmAGT1mZNXmmCnYgyz2Gpa5RGxUuCKuI29h9gCYzRQL8GsdlkiW7v2ObXDmLfsZpS1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Umu47EqHauQwxf8D2nwTZoIR5PIFAXpVp7couoCAcL8=;
 b=FO/x/g/wzMAJ+TrXv/tdQfbwTrZ8iDh8vLXTl1TMRDh7rHQXgnzE/lAE4AeZxSvGIfH5FOqHiOAWPFgie/AzSrITgKt5TUCsydDzhkC/a7dkW/YJi/00ztZ77Dsz2PUSkBLyzyMX6/x4VUP/Kh9A5n78etU76zmkRavkdh1CoB8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1752.namprd12.prod.outlook.com (2603:10b6:903:120::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 07:50:22 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e0b1:48e7:bcbc:351c%11]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 07:50:22 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com, stanley.yang@amd.com
Subject: [PATCH 08/12] drm/amdgpu: restore ras flags when user resets eeprom
Date: Tue, 28 Jul 2020 15:49:30 +0800
Message-Id: <20200728074934.12490-9-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200728074934.12490-1-guchun.chen@amd.com>
References: <20200728074934.12490-1-guchun.chen@amd.com>
X-ClientProxiedBy: HKAPR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:203:c8::9) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HKAPR03CA0004.apcprd03.prod.outlook.com (2603:1096:203:c8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.9 via Frontend Transport; Tue, 28 Jul 2020 07:50:18 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0ead2476-86a8-470d-a407-08d832cae125
X-MS-TrafficTypeDiagnostic: CY4PR12MB1752:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1752A24C10E906E4C35DB077F1730@CY4PR12MB1752.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:428;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ck7ksqYjYuQysJ5o7kUd6dZDizEjZlERdC9etyhvHdeKAKvaMvz0TLa1wby975oCX9175WNXOyVTHQWv5OvsI4PhJ9m2bJeVQQHz12ONMZFU+upAnydYmLP4bAQJRpKdHFs6sJtBvjPCI98mkEeYBoKo1lTrGCpWB41TTsozp4g8lZHvIzJnucSE4kQyp3PAq9e6sOEtphnML6Noi9z2Hn9G9+7dnfBuA3GbdbMxAJ6a+jqz5NEbH0/1xWXcO+3JWdvKRidCVa1J7vMHmEeNxEgyqhp+c2GzWX/cAh0mJ5QyjclIJjIqERK3ppTUm/jQhM+/7TJLasrdRj0Zp9WjV6b61ZhzK+XYWdungA134LSha+0ubb8yl3b2A1r20n6/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(2906002)(956004)(2616005)(1076003)(6486002)(66476007)(66556008)(4326008)(6636002)(66946007)(52116002)(478600001)(36756003)(44832011)(86362001)(83380400001)(316002)(6666004)(16526019)(186003)(26005)(5660300002)(7696005)(8936002)(8676002)(921003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 7KVAlc+i2DdhyB2pSuzoYe6Y5ys9KTyPoFPvpOFNNoQZ945anjHK905r4wmrgsUq79b1D0f2rPNOK9NAqHEkiLgntncMRokTKhklhrNgsfOsEzWHRXJWaIKTMbzvTGp2dh+Bq57IKi2/4Rh8lZhn1o8AigJEdqEBu1RlBD5MGAmwfBS7Pwu/ReVNvmxi0QqOr4aQhaBo5E+p59EGFlW5IttwlEKrOEacsAUUUOM1k+MShYU9LfnDGitbw0vYsgDzAuCa2jkZFjOx4N2Gvdyal8nRr4YLx4S+D9PFVd2mW7rdU47+Q3tOYv4Lk4UuPfNjkFTTAGGZGVAHtaNVgoEyFixGoptnX+3Uakk+nsh/KTWmPeK4grOXiE71+7Q7xlptbXKWhlg9BQIi94HIDCXMEnDJ+uxCe/QlESZ1XXACFz1qBfX30uulnYdl+9IL2z4/4kty64lIZSH5o6urmDzTKXx6sWTWL8YQRUqW1IczBJ/At7BXTk6MctauY515rOzY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ead2476-86a8-470d-a407-08d832cae125
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 07:50:21.8666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAIObtytE7zbIAHHC7cxjRpAclq7Al4trKFgs8hGdmV0UewTA2jUOyGPNI91NGGIpD7XS4DvZN+yWljWJefZ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1752
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RAS flags needs to be cleaned as well when user requires
one clean eeprom.

v2: RAS flags shall be restored after eeprom reset succeeds.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index dcb84f2ca078..2cc09aa67423 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -368,12 +368,19 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f, const char __user *
 static ssize_t amdgpu_ras_debugfs_eeprom_write(struct file *f, const char __user *buf,
 		size_t size, loff_t *pos)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	struct amdgpu_device *adev =
+		(struct amdgpu_device *)file_inode(f)->i_private;
 	int ret;
 
-	ret = amdgpu_ras_eeprom_reset_table(&adev->psp.ras.ras->eeprom_control);
+	ret = amdgpu_ras_eeprom_reset_table(
+			&(amdgpu_ras_get_context(adev)->eeprom_control));
 
-	return ret == 1 ? size : -EIO;
+	if (ret == 1) {
+		amdgpu_ras_get_context(adev)->flags = RAS_DEFAULT_FLAGS;
+		return size;
+	} else {
+		return -EIO;
+	}
 }
 
 static const struct file_operations amdgpu_ras_debugfs_ctrl_ops = {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
