Return-Path: <SRS0=6vDE=62=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF92C54E8B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 11:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E0D7206CC
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 11:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vmvUgwHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0D7206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E43F66E89B;
	Tue, 12 May 2020 11:14:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30FEB6E89B
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 11:14:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDK2uq8t6ViR6e4jKSXnvnaPkEacjSp/oQXnveWzBlNlmDYfW2Gvfml2HCagbxS9P1GURNRviQS+AbhnAW/++ka5fEnelKi7bBlld4IcX66Wu0iIjG9urQvI7OplWev5BHoacbl6yKdtYhanpWF/1FZjjG3T8YMp1rgQpT+4LBOFZf0j16A42F6+iyjOxbgre53k421Y0s8ZT5gUzGCAxa6oE3mo07Mh2F2GMF69EIusmnv8fgMUYs3FCl0nQ6+uOK4hLNJGcV1jD3ReYyc+BaQwk/Rbvya7G/gNjnihLmKPmuFszkCb57wnrlFUbsYt6jWjoL7l+dJ/Dm2OiYLUwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miGmzwp4dxFjndhs3zcJEjp1zPOdMHGcKhJvEOW+huM=;
 b=SSfCsMaQ46yzaFNPq1f8SXCJOONMS7bLhDeYnYacBlyORsyytqo8Ig1q5+54FDRs54GWHsHvsoDgYl+8jjnZKiXYrgQ0RaBRT7hBLzllVBz5c8U202pjm8ItZ+8EGHQZeXRaPKPmTVOS1McFrRYG4kpQylvJScLLg8Bx75s9rkgK0PdC0tXbaiO3WQLnTjuzW6zogwjtQrBBvkKlJhHcHEtEuyrtlrge935WTDQtRCj3Kp0PCJCcCMcmng7a8VRmeNnQFEsd6VNPBz6ux3yIk+J5JP0iJjka+51yKvAhV1NfqUZ3eiIxKYuIhw9+sodT8YB0kqv49OhTtz3JoigKIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miGmzwp4dxFjndhs3zcJEjp1zPOdMHGcKhJvEOW+huM=;
 b=vmvUgwHWCQPNadVQCMTi0ZbkJl1mYDvS1zib9rJqW8i39a/BpFNgNsuD1cDFmoI8WFTcPrE414yj/odeqjmOo+Cj7tOQoyu8lB7kbNXVseADE0xpV+iq9omfaE8JeLFDqi7LjmIIRkmxkTE9I6cp6+ogaJx7SXioTTV+Pz3dAUM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.28; Tue, 12 May 2020 11:14:02 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 11:14:02 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: ack the SMUToHost interrupt on receive
Date: Tue, 12 May 2020 19:13:05 +0800
Message-Id: <20200512111305.24665-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: HK2PR04CA0070.apcprd04.prod.outlook.com
 (2603:1096:202:15::14) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0070.apcprd04.prod.outlook.com (2603:1096:202:15::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.28 via Frontend Transport; Tue, 12 May 2020 11:14:00 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1f644f35-d653-40ca-4fa8-08d7f6659306
X-MS-TrafficTypeDiagnostic: DM6PR12MB4170:|DM6PR12MB4170:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB41701C154BFB6F0AFC860F37E4BE0@DM6PR12MB4170.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0E+/DpuBHIT4nVr5w41weUHMAgH2kTlb7N7vogfrjSpwZR+BUsdgoO4aqyWAvytSBUsNJkAiv8Qr7iCV6B39xmtCKrAD1nbgNa42YB2CZKNAmeeJT943EvWPy6GLyPPQc1/gculWqLzHuAfSxSPkeNapvu6aaj09D9HSfA6IY9EjBmvQDsUpXUi5sZfW2CWfrX6jT4UA6bwPOZaGhY4HyA27EacVlVlAcXhzDbG8sWZ8pbHVDEVGrmf+xe6akRv0Az8BQBm8RDC3n6K8XfU/14k/LyVHEDOUozXUAIYNkGeh6UPyTqOXIoRohI1OtwIA/ydlKm9b0Pkd4FxQbDK9jKHrQjBnsZQQPfeFCMjuSfggzqxaOmrwelFTDBe6wt1oPFTyCjXgmD/pm7lC8KvHLlbkSifmYUywnEeCPF8d6JoEgIYraV3dvkj3ihhMjBU4wxztx3zU8hiLTED5mBSTTJKaZnJLto7ur2Ien/HwCcd7bsnfg6MxW4KdapUnRDA7m3mHYcE448ziWQofzYb8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(6029001)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(33430700001)(956004)(52116002)(1076003)(4326008)(2616005)(7696005)(478600001)(86362001)(8936002)(6916009)(8676002)(44832011)(66946007)(33440700001)(26005)(5660300002)(66556008)(66476007)(6486002)(36756003)(2906002)(186003)(16526019)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: v+XMG0cPhYSEitUQ9AmUKQPKlmdLm0XSmwLmEFgmKh93RhW0M9uZ2WJYn02eBJF+Y51B8p2XzuYA1oJ5opkEoZde/3X5OSJcgVtEN1l1aX4JhkQn8H53A0tSf08xCS0vOD2zzkfmQrOotP8iMzpdFgOcCJ9NLLcn5ejI/pQricEAnCLLQSa+E3dX4hsAeAvXCpxQphhrF2/Z7V3jfzTiDLb80r5OP2Rkw8C+lz2sgsCEmRkHGYXN1KDjA9qgcAycmRyxhbdaCgt4DdPtQwDmrd7RyzO+8IfLmVGaOa8+Y/llzHkUX7WW6mglApBXpq7SAJprjLggmm5Kxj0OIjik9J1wZgG62CzcxM31MXCLYTmRL9Z81w9ybSDdaWBebf/bZIHzjCjyvvZ7S55Wwz7ANWttwGUAanMcZ9eBfRNGMWsC/2QV8OtiaWZAqveJUyuN7yqhSlmr1lNeFnHA1dQjPoqLrMMAGmORBTYAl0iiE9qahGp9k/mUE3pV1B97Ts2H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f644f35-d653-40ca-4fa8-08d7f6659306
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 11:14:01.9266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khFU7ULsp6C+/DhKXVX2Skg7jOZIn3+Pa/1cV+SEaRsHQXpRVX5KfvafluusjOM0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There will be no further interrupt without proper ack
for current one.

Change-Id: Iad5adcaf7dd5c3a773b3d93ee0922a424dba8ac8
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 80d6c296a599..beec4ae0b1d6 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1535,6 +1535,7 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 	 */
 	uint32_t ctxid = entry->src_data[0];
 	struct smu_context *smu = &adev->smu;
+	uint32_t data;
 
 	if (client_id == SOC15_IH_CLIENTID_THM) {
 		switch (src_id) {
@@ -1576,6 +1577,11 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 		orderly_poweroff(true);
 	} else if (client_id == SOC15_IH_CLIENTID_MP1) {
 		if (src_id == 0xfe) {
+			/* ACK SMUToHost interrupt */
+			data = RREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL);
+			data = REG_SET_FIELD(0, MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);
+			WREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL, data);
+
 			switch (ctxid) {
 			case 0x3:
 				dev_dbg(adev->dev, "Switched to AC mode!\n");
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
