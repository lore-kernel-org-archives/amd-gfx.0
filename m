Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A64C38A2A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 09:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 327352083B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 09:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1olmRoQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327352083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B11DA6E0C9;
	Thu,  7 May 2020 09:58:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D9236E0C9
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 09:58:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8rmijwbnchasYRZi8eVY4EP0zcANR9a9plffOIoC/+MLlGRXgh2DcPMchMtdzJFNYcXuUpco93wmdANFH+BO2aoFbx6wtungJZbkGiZ9wvAKHWymeRyqi7Xx/XP3Cel2hhh/4vnx4NXqVwjacTgLY+79kNA2uASncjEvu11QH6kWTNKmmOsjh8pBl2ER0sbePpqDCs2Ns1Mw7aqPyDhIKkK5BRxwdAvDpnFK/I9mPWgGBNodpXKODGTsIYd41LUR2diBYG+pBCEGSut4EIC3szmhTXB8bRFoOhWrRrxHjkCW4X69nS39ZGG5bNp4vmOPF3HpFks2cfL6pQyZK6M3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bY5JIGwzjAG3bemVLqj4/1BidlWxk3OH/Tcnx6ASG6k=;
 b=MqeGU4EQSkhl2CIggscLdvj1IyvHB6sBn8+QZ7CMXElEg50Z+wC+yMAApaOhhy64EwJew0FbTuaemz/AoVS5eKB8TzUOXA/brrOXsX7fWYKvq7KPl2i9HitwiY4EJHovnVO8LumkMVLNsPZJbrWmosg5tAGtXtKgxB4JN1saJUzwcR11R6AS6JQmqmLUGXIGqE1uen6smvZYIB/+YokGINQq5FgFyAwm/PL+eJWPR1H9dlcYBcmd3nS7x66i4afo6m8p2i7b+ePTRqlgl9XdAcxWK23wM7jBpXO50XnirMuLunXitcwsIgvKcxA/lRLom+SxXhSsCBb2sgiJ6Y4O3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bY5JIGwzjAG3bemVLqj4/1BidlWxk3OH/Tcnx6ASG6k=;
 b=1olmRoQ+Zpw40hlhpfJAxVk2lcJx8Ygi7niHGRgrzw9T3u0xfOEEMjuj5xMUljB5t/YHwrytrHGXveydYIR42evaXhRJUZb/NQ7rsIotvLohzuqFU8zn8310BAR9+tHJbQxvst0RabczfylaSdnvnItXcxONUu+T0qH/3QCUV2Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 by BY5PR12MB3731.namprd12.prod.outlook.com (2603:10b6:a03:1a7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.30; Thu, 7 May
 2020 09:58:39 +0000
Received: from BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c]) by BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1897:7b63:ee7e:5d2c%2]) with mapi id 15.20.2958.030; Thu, 7 May 2020
 09:58:39 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: add amdgpu_virt_get_vf_mode helper function
Date: Thu,  7 May 2020 17:57:01 +0800
Message-Id: <20200507095704.25623-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK0PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:203:b0::14) To BY5PR12MB4068.namprd12.prod.outlook.com
 (2603:10b6:a03:203::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-kaka-kvm.amd.com (58.247.170.245) by
 HK0PR03CA0098.apcprd03.prod.outlook.com (2603:1096:203:b0::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 09:58:37 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 53d6150e-6a39-4298-c7b1-08d7f26d3764
X-MS-TrafficTypeDiagnostic: BY5PR12MB3731:|BY5PR12MB3731:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3731B535E82740B0727246E1A2A50@BY5PR12MB3731.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pCJgi3yRZP7Of7qU3vbp6OtdQcJ1Th2xOIP2M+8EMzNSHc371znupn6k68eSIghmLaHz7D+htEZHMaDfCwJUvxbHmNpsMlsucxgt1rPtSnXNzw/+pZb+fSuWxGnX8edYskp4iEM+rHpEIoB4rSmMY+An1a/63+EnZ4/mWKARRcidOolKzoudEzaA2M6YvugSN6DGvV0di1YoA3wpAs0X0u3fkwz8wpKONmCffNWuSUJANLQU50H0k/zccnWfD7pRg1kD9YXeczgBWEwqf2PPAb53YagGgymGd2lmq75IJN8dOA6T54kIV6Gzfy3QhEEDofQpSmC4LXWcWyifD06eMZohQsQR1xHMIxJIC2zHwNN15eH4/8jpy24UMkYMS8f73GeOo4V5wt0pCb8ddYVylBuTh2RbtsK2zMa9R0NZXXdiaGMmFUHaf7hZYSEAUr1VF5xlE2dngFF7/K4kUrNIqhyuZj0xDIWvHOvFkSMOzwX4n3Zi4X4VrX7DfZo/OGr9NmO3D+iNfH/OrGTM87z4wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4068.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(33430700001)(2616005)(26005)(5660300002)(86362001)(7696005)(52116002)(4326008)(186003)(83290400001)(83300400001)(36756003)(16526019)(83320400001)(83280400001)(83310400001)(2906002)(66556008)(33440700001)(66476007)(1076003)(478600001)(956004)(66946007)(6916009)(316002)(8676002)(6666004)(8936002)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: JQiVdrzzZ9kTj/nwqXRa9FUHAlnLt9NAlcJeia6ltuiGP/n7x/epcoNqkQoLqYvJHZBM1wRBu356ug8wLZT8XijUx39NxiKoPFyoppQqmPCKN1exOW7pIGfgyYT0hoaRPfsVOgXheXbLOKlxd3zLIk8BtgwdbGRig6YwjIhKEM44na/6o/VLtJzWLHcqSI9PuCdOsSFezLBNxKVnHkDp8+Y3XXEm6py3e1eWuucY7tJVwPoJ3xZmCxLzzFDWttgqCuQ6sRssAN9KJbYK4h1KCCwkuQ3zjpZq7QQf0t1zOJrCRkMdTpAXtBYgPXML1xxJEA5OeCQASHhtCM2AWU7ooS2O20jH7fTR9zwlkd3uuQdPUtCmx3o5Z3bY87fbdnjvcosKqqAYIltlOt4Mc7s3KwqPT/dWyyaU0p1a9X5nJfA4S/iBXA7Gi6R3dYh+ONufQFrZkS+pB2yQM7+3RbpvhfybVdM+mU2KYxsGtB3Wv4cr5Dq7ETRauftl7qPPsWpweEXzciOC8WPPSUNJTDbGJOBNtCUOA5d1zh7yBDflp55hxBVJxr29rcbwBpnADtOj7Ce6LWrq8aZBQJLHnEEJpWrQI2DlFvWMBLmGmquB5WP2gq38LbuJ2ur3DlIFZUGScpuNYwNloSIi9q9C1rxW1TItEg/Yt4Dk4yaQV2rbT2lsPBuqZPy38yoNsPd+G8U/N0RIgBwFRllroT/tHHoeZFwC8x2ZijZy25WUnQ5c/xax0g77A0TfO1OJCOgtB2WWljClUPS8x1CQzIXhpznHlgLfv57UA0QvLZkCgXGgNmQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d6150e-6a39-4298-c7b1-08d7f26d3764
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 09:58:39.3671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNMbPSrzOdWp3g7pt8kii/oKmBanXVkchf8Fm/N64kpjdONYfnF3KTc4vYO2C9yA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3731
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
Cc: alexander.deucher@amd.com, Kevin Wang <kevin1.wang@amd.com>,
 kenneth.feng@amd.com, monk.liu@amd.com, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the swsmu or powerplay(hwmgr) need to handle task according to different VF mode,
this function to help query vf mode.

vf mode:
1. SRIOV_VF_MODE_BARE_METAL: the driver work on host  OS (PF)
2. SRIOV_VF_MODE_ONE_VF    : the driver work on guest OS with one VF
3. SRIOV_VF_MODE_MULTI_VF  : the driver work on guest OS with multi VF

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  8 ++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index cbbb8d02535a..f3b38c9e04ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -370,3 +370,19 @@ void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev)
 	if (amdgpu_sriov_vf(adev))
 		adev->virt.caps |= AMDGPU_SRIOV_CAPS_RUNTIME;
 }
+
+enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *adev)
+{
+	enum amdgpu_sriov_vf_mode mode;
+
+	if (amdgpu_sriov_vf(adev)) {
+		if (amdgpu_sriov_is_pp_one_vf(adev))
+			mode = SRIOV_VF_MODE_ONE_VF;
+		else
+			mode = SRIOV_VF_MODE_MULTI_VF;
+	} else {
+		mode = SRIOV_VF_MODE_BARE_METAL;
+	}
+
+	return mode;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index de27308802c9..b90e822cebd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -35,6 +35,12 @@
 /* tonga/fiji use this offset */
 #define mmBIF_IOV_FUNC_IDENTIFIER 0x1503
 
+enum amdgpu_sriov_vf_mode {
+	SRIOV_VF_MODE_BARE_METAL = 0,
+	SRIOV_VF_MODE_ONE_VF,
+	SRIOV_VF_MODE_MULTI_VF,
+};
+
 struct amdgpu_mm_table {
 	struct amdgpu_bo	*bo;
 	uint32_t		*cpu_addr;
@@ -323,4 +329,6 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev);
 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
 int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
 void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev);
+
+enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *adev);
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
