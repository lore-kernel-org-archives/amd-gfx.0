Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0338C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 07:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 710BC20899
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 07:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qR6h77qP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 710BC20899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 048F4895F5;
	Thu, 18 Jun 2020 07:53:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B47A895F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 07:53:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAZFWM/AdnhVzo55rh1kI9Mcq7/NKnDle0UUHGpAISq1EFHPHpH22/sFdwZXhT9Tq0aJCdBCoTNpfUopVbUk3UQv6T7Sz8bAfZsmDq8uVmn4fuBesFn0OPLgEwg/ftfI77bHP6Gj80du13TZgyObrCbFq4cI8lrXCACcf+PVR6+IbAZST2dE1NyhhKDCPG9DlvT8jy3akxMw5fVe9XgTJaCb9XyiqZPv+Lv9dL6IAWBUa5+y5/eSgFbpS0x+0JEgyDPW9BIlVsGKAvcsw+fkTBl5nYEhmYaknzQMi4D3q0HjWOI8xPcCncCYNUVti1dkoNxMAo9wrDXFa+BnA8WKZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djShzsnCB77zNC6vKhrIv4mHqRGxhMjBWq12MsaJV0U=;
 b=YXMmF7wmmQlO6k79S5OvBUonKZFwXNee4aIYf98VQHmdAHZPpTfN7vyD4zmJGQlK+e5SBgaQ2pUn7KQGxkgIrDQWGSW01aEuAKzU97qsBFEDrWBtfzaLbtvAYdomGyAz31e8fyLhX6ikFLehHuLybR0svI4BHnNWqdAlfRna6rzck+oMQiGj0qybLdQgvuw77M5MFQnq4nru20o1JxXkGbICISeXgXt8RrAgye7Bt9D0r+wxHwtq1l20762lyxiau2shjdX1fbruP9utenxxyFt6lBvnaTzAaBWDK7bRMUb7xOsaRq7QpqbviLidIUV/DHteMMv7vDBLGiiKkK3XsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djShzsnCB77zNC6vKhrIv4mHqRGxhMjBWq12MsaJV0U=;
 b=qR6h77qPCTVmTSdPrZ8b2Xva/jg5bdDnP/fjEci62dtIcE/O8BKoW/bqLrDlDfJ6X/JeYA3IYkyBuwfKV4FUYA8VDLic3cHR8xHyaOpj1mTXQZeSxYl0opHkcDUqlHwvzOKuLa0X4yrzw0tWC4o+bSMTKD40UT33QVjZuHmqDFw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 by CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 07:53:21 +0000
Received: from CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d]) by CH2PR12MB4101.namprd12.prod.outlook.com
 ([fe80::b9c2:5b76:382a:c5d%9]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 07:53:21 +0000
From: Wenhui Sheng <Wenhui.Sheng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: sdma v5_2 ring bo mem leak
Date: Thu, 18 Jun 2020 15:53:06 +0800
Message-Id: <20200618075307.3721-1-Wenhui.Sheng@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HKAPR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:203:d0::13) To CH2PR12MB4101.namprd12.prod.outlook.com
 (2603:10b6:610:a8::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from HUI.amd.com (58.247.170.245) by
 HKAPR04CA0003.apcprd04.prod.outlook.com (2603:1096:203:d0::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 07:53:20 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 15707793-4490-4d87-80e2-08d8135cabf9
X-MS-TrafficTypeDiagnostic: CH2PR12MB4215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB421511D919D150839F0703718C9B0@CH2PR12MB4215.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:56;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YLx1X/QxADn7wq04rClLVmoxsOt68w3SsgaTFGBd9LuAsKgP04IudtggULzLHFUACRsr90JYwfiPeCAIzpVFsXnbpqB2kf4UnmVIP6MnMRXRXXwFXo4cnpSQVfR+q89H1XHScZ3woB1lz5m7jrvVQtAqX2cnjWGhc4KqUvTBDnTrlxOqbtmlku47ChneoqUqKJysRPDGaelSBpHNEy6PpBKKuk4fnUICfs6XFmLkRZ22N8zB/Bxzfe8KRbRUXC/bJ7acbX+J5FbexxBACcPTJ0GuJ1F3ivf1V3PXS5QflEENWeEA8fLuXuySGfbIEpSPELWdjUn5jfAWVhFek63BNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(66946007)(66476007)(66556008)(26005)(186003)(16526019)(52116002)(7696005)(316002)(956004)(2616005)(86362001)(8936002)(6666004)(2906002)(4744005)(6486002)(1076003)(8676002)(36756003)(5660300002)(4326008)(6916009)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: WGpnIMVSutk/uCM6nEKDgE52R7lbqxWK7wdvwPBLiYRwyiC0xbDM83CeoZQv8Gl8SfFLjYR4ZfhtJsHEkKMB6t/uYqWCItWVGzO+dcWuSBOX/HoDqVlbFQaLIpl/62B49fj9v3zqMZnWHhOARdvrAH0y1QyPsmMcSMa004j4GQ0w8PxmLaYhiTi7JJP6dC3KbX17iuDZD0aFUgy3K/UbEMyMl38RuWoUouPcoue19wWoHafDMuA//B6nb9wxI11SpcE99v2w28ZlSphrmOFW3Mr3iawMATHwCUqvklaAzgRJXd+JFXkcUNpmneu9OCn9ehlI7FEgy/ou6cczw3aKsnz8xjZoa7v7OE0ITbs0IT3r1n4nYjBttjpX5gtNjrNj9HB5bIVv3KQwX9+ZV9JmfBl1PTSorfSZRdMwTyPAj7BHoRKAyodhqaFll4A0mY+3FynksaoEiDGesOh8PFnr5+0X8Qa7fWVLZ9B1B+tTUZVVSwv8onh5PlTxf+TpOkpF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15707793-4490-4d87-80e2-08d8135cabf9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 07:53:21.7747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/WIVbxyj1p9NOThCMgJp9u33QKqoWknnK/S3fqAcYtP30hTXZjHtYbpgrxjCEg8n2RLNBtCEP7hsfQEKOxBqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215
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
Cc: Wenhui Sheng <Wenhui.Sheng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

invoke amdgpu_ring_fini for each sdma instance

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index b523091dcde8..74ac929dd217 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1244,6 +1244,10 @@ static int sdma_v5_2_sw_init(void *handle)
 static int sdma_v5_2_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int i;
+
+	for (i = 0; i < adev->sdma.num_instances; i++)
+		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 
 	sdma_v5_2_destroy_inst_ctx(adev);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
