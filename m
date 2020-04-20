Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD8AC3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 10:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA42120A8B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 10:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ptoN99/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA42120A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 817306E0A5;
	Mon, 20 Apr 2020 10:17:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08B436E0A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 10:17:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJ67jum6dxWU7gFLj2Z1PIJPF6UCyeEEJAdo6890kEdv/Exro8DwrvU+H5phK8ZVL9GMrRn9han36kpIkNrp+Zb7PyPm8pOH81tYAr32JfJJcHVJiGaGA84XfE3rZ9FZ4RwYILN9BBSWTr6xGrBGX+SQN8r55ExJ/4XwoYHh/c5JoKi9Y9UE8czWrDEsewnqoU1SXxKLNLkEHNBJQDGliq4pt5nsPnoG9XXZbiDhcpQ5dR/5lMZaLvvNuL07xmeCtRghTeVLNxBjuRLi5C6+EJFTxPgub2qF+jgOZ4ydNlES133K/S50/zBvlLeJntjrYtgrPLyUG7BY+Jd/AyLLLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9A65/nUZ02QrcjH+7eUqVzkawgxZZd0WpJYSCYNsOI=;
 b=NU4wtVg8SCVjHfzZAoAgkbJqof0aKItoS8qlwL/Y2mqpZ6drTAyDsN/n2Tm/egz5MplbEBWBpt7wJ0iSm9qFPbXEgbaJKRzqpLG4VPY71tfbAK9TXTHRg9BIrCCDCDwRWRC/F9DeR4ouVlNDZVcpGSBShI3G8at0wcthDK0HSB1JeTEHkMluaVp4Zn7A5cosVlhwTTzPfujDS/tQwWc3fLpNnLbzbseG3Y8u/6LaIBtFWjHz4+YOBiWJoBTi1nKxl6qQT5blN3lshO1A2gxhllSopmuSeAO7DflKKhkjRgJvvd4aYg4UhGE6cs3phNHYlwDGr5GZGACXOscDAcEoaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9A65/nUZ02QrcjH+7eUqVzkawgxZZd0WpJYSCYNsOI=;
 b=ptoN99/r4jj+XhatXXpv1p2pvO5Y6O5se/QVQg+qIUoxKr89vPTZbsTRYTWtfjSA5fUvg+TknGe96bSrL2OnHHGqyvUDIErvPT00FZ9O1Xu67kXUJed/oe+pwuALq9Z7poton19EP3mmiMu4GmlJ+lLRPDjetZrzlOvnHaGOOHs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3225.namprd12.prod.outlook.com (2603:10b6:5:188::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25; Mon, 20 Apr 2020 10:16:59 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 10:16:59 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 John Clements <john.clements@amd.com>, Guchun Chen <Guchun.Chen@amd.com>
Subject: [PATCH 0/8] psp code clean up
Date: Mon, 20 Apr 2020 18:16:36 +0800
Message-Id: <1587377804-3836-1-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-All-Series.amd.com (180.167.199.189) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2937.6 via Frontend Transport; Mon, 20 Apr 2020 10:16:57 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6a744ae5-18d4-4090-7faa-08d7e513f5d9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3225:|DM6PR12MB3225:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3225AB5135A6E07EFA5E5BC4FCD40@DM6PR12MB3225.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(26005)(2616005)(16526019)(956004)(316002)(186003)(6486002)(6636002)(2906002)(86362001)(478600001)(6666004)(8676002)(36756003)(4326008)(5660300002)(66556008)(66946007)(66476007)(7696005)(52116002)(110136005)(81156014)(8936002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JtKMbZwc0660MMNOt1X8JUhzg0I4EEgIxS11BLHM/sNjUqSmAu8rPLVsyfDjKm6Hkgs7VDFn4X5Ukg9AVoq4Q+BbFmjPy68iEnlfJTh6L2f8ooPuvjIPBGudKLCghzFj2vPlvkTStDuGOTZ6RTOCjT7V3Hcj6v54ZLET+H6GRkaUHuMx1WFHIK4Wq4dA0OEXkEHtHVELRinTtNC1ulm7r5WZSMyJSjEZqeDpcZlRPKcu1T07XkczWk0t1VC7HxVSvHQO2HF34x6NxuCPhxlvVmzYOOlV4OscXmiPnvxCAywVPU7T9RiU85YCxJL7knYD91B10tgNI0AGHKsyvdrdUW0YXjrAlb4A0MDsPkaNmsw5SpoRtD2lypYO1zNkQUSfDJgZhS81WeyoJagyvD62ypZgs9NlsO8TpbE5X00u47YUdFoVXNGgAFmzpGzIvjhY
X-MS-Exchange-AntiSpam-MessageData: +e5ozKMr4p4VCfrXoGfJCNb62WQvL6LfrX92kWQUdBJ+Uk+DQRENh9dLMqkQxIX2/x3yy5wBOjq4RAQI27PHVTgglL6o+pfKVKLFOd0XXkiDdnGkGFjdd/SbKBx0rqnXKpZnNloBeZOYg6EM+6Zp4g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a744ae5-18d4-4090-7faa-08d7e513f5d9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 10:16:59.1719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GggrGAeCvTsZVKTXlKc67w6esEQA3LhXdd2R/4UwNIXH0BY3h/SK0sdKeRvLkvLFVMAr7s/VZH8ip7eZkX5pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3225
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the seires make cleanup in current software psp
support, including:
1). retire unnecessary ip callback function like
support_vmr_ring, check_fw_loading.
2). remove unnecessary tOS version check
3). create common helper functions to avoid duplicate
code per IP generation

Hawking Zhang (8):
  drm/amdgpu: retire support_vmr_ring interface
  drm/amdgpu: remove unnecessary tOS version check
  drm/amdgpu: retire unused check_fw_loading status
  drm/amdgpu: add helper function to init asd ucode
  drm/amdgpu: switch to helper function to init asd ucode
  drm/amdgpu: add helper function to init sos ucode
  drm/amdgpu: switch to helper function to init sos ucode
  drm/amdgpu: retire legacy vega10 sos version check

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 130 ++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  14 +-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c  | 141 +----------------
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 235 ++--------------------------
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c  | 172 +--------------------
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c   | 262 +++-----------------------------
 6 files changed, 149 insertions(+), 805 deletions(-)

-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
