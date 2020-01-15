Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF758C33CB1
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 13:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B090120728
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 13:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1N153joI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B090120728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 791306E9DD;
	Wed, 15 Jan 2020 13:24:07 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680051.outbound.protection.outlook.com [40.107.68.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1735F6E9DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 13:24:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLjInoZPQN9ST7rI0Y5/8bEsRHW0mIimsDp7GWLEFcEGrwxER+8IQJbhWBdMlplxIvdsQmCBxe/0bMxIo6HikJx2Ys2hWMpnMAm2FAjXttrhniN18vKoiO/Gxl88DukK8VBusMqlyj/KRcdRDLHi3c8p4cs8y4Fc931gowfnqrc7CLddsHaK2bZ4pS6WYqTfQmv97fESGSUbpiW1JOdhKePRbjH70Pq3wYh+UC1Ti67gM83cCOI+DvYvh8mmPspHqBHRF2rxnubb//90mXr96OQdHavnurnWKmM/EbKCH5lM92XtLR3dkVnsCBMKOJOsQaKKS9XYxXe/HCI2hDj4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zn9pwCRXIvony71e9RCMWns5pdW1sTiZZpJZkpb3mCk=;
 b=C0gaHEert3UKQgvAMh7LtuC9tw2eqYih9EAfJ5QYTjBqMgkz95Byk52EZM08lDMV/Ukj6qB4kzUM+zFNX3wNyqlSnGNR9inMTgFpvjz+GwLUS3/KhTiE2FoxeLvK80AjmkArybqj9+RfmqSEc3xyKOk9D1+XPR/bFQceBCIyCsNV6qiZvNQpBwMmKyRx1uCUJbMMPwmvAO/TvnKw4uHVquIWZNZfP1W5RBM7RQzjBdrbhopNDdFLXY5oBNI1ETE7D6RXON1NZ6gaYFOxepnztDB5L86jVPESaIrZX9+iPNSS7j7RwJUEBYGlgy0ptGdVwJwHGwjX0I7Bcag77gAbcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zn9pwCRXIvony71e9RCMWns5pdW1sTiZZpJZkpb3mCk=;
 b=1N153joICH1sTxRn7m5tE6GJe3TzchUby98ZogKFa/uamt7wlhlBcwHxzZTBc6fg6V6wLsVCF9k5w1tD2nnpHGBJTv8SzzRd3ghRl9Z9cjl97OGINsegB4RysRm/hcSCYgCvp6MwPZnXA0zCzdNkaIrtP9n+fbDbdFTc4QUNba4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Leo.Liu@amd.com; 
Received: from DM6PR12MB3914.namprd12.prod.outlook.com (10.255.174.32) by
 DM6PR12MB3739.namprd12.prod.outlook.com (10.255.172.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Wed, 15 Jan 2020 13:24:05 +0000
Received: from DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968]) by DM6PR12MB3914.namprd12.prod.outlook.com
 ([fe80::90fd:cd84:e116:6968%7]) with mapi id 15.20.2623.018; Wed, 15 Jan 2020
 13:24:05 +0000
Subject: Re: [PATCH v3 0/5] support Arcturus IFM workaround
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1579040596-12728-1-git-send-email-James.Zhu@amd.com>
From: Leo Liu <leo.liu@amd.com>
Organization: AMD
Message-ID: <e2f1684d-8f5b-ce92-bbc8-3264de2035b6@amd.com>
Date: Wed, 15 Jan 2020 08:24:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <1579040596-12728-1-git-send-email-James.Zhu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::35) To DM6PR12MB3914.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::32)
MIME-Version: 1.0
Received: from [172.27.228.95] (165.204.55.251) by
 YTOPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Wed, 15 Jan 2020 13:24:05 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4cf93204-246b-4130-d1b7-08d799be31b9
X-MS-TrafficTypeDiagnostic: DM6PR12MB3739:|DM6PR12MB3739:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3739B0C39ED09F19FF2BF0FBE5370@DM6PR12MB3739.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 02830F0362
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(199004)(189003)(36916002)(52116002)(31686004)(5660300002)(6486002)(478600001)(956004)(2616005)(2906002)(16576012)(316002)(86362001)(8936002)(44832011)(31696002)(4326008)(81156014)(66476007)(66556008)(8676002)(81166006)(66946007)(36756003)(53546011)(16526019)(186003)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3739;
 H:DM6PR12MB3914.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3IQY5nwtjYExS2pi0vFi+mtD8G2M+RVwUHE3QnrKAKj5kkQLKTy+7toCtv6HGNZ7ygzUief+yMmSKQqeAB0RTIrSlqNevlAQJCEy0XMhfQhgSE4Vk1p8AflY6OVs0FD7OkhGfMHaGSUR4WA83ahaIGXjWJWYroFwKhDcUHHNWTUk58mBMmb9oVtiNRyYrYsdoU+jNUQMZIwYlMdcRbVHoo9tmqVRJ3hFWPMOoi8GpuqqXnV8aL4HAFr/fZ2nSQQtdrlxXHPAx8Z70PmTTKumOEox/hkEU5M432Gqo4nC3hlk2IZhvvcnYNjncI+OUAAI34k4yeyfGFIKYhtO+JTH+9ZxBTJXHSdw5bDOe84BKdLL2hcoVXLhNhB1LyvTGgZl26SO3+XSTsDRbH3nT7X0R5lLB+C1iigF8zsROyQmYw2Q7ykaC7m4IPKn0BvfXoR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf93204-246b-4130-d1b7-08d799be31b9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 13:24:05.5710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTjjO0D9olmBRAHQw78GZXSvfmogDBrVMJsEoA0ShAMYbyXr6Z1OFHw478HHsbAX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3739
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
Cc: jamesz@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2020-01-14 5:23 p.m., James Zhu wrote:
> Add vcn2.5 dpg mode/dpg pause mode/dpg sram mode to support
> acturus IFM(instruction fetch monitor) work around.
>
> v2: Correct firmware ucode index in vcn_v2_5_mc_resume_dpg_mode
> v3: Share multiple instance indirect DPG SRAM mode support for vcn2

With those fixed in patch2&3, the series are:

Reviewed-by: Leo Liu <leo.liu@amd.com>


Regards,

Leo



>
> James Zhu (5):
>    drm/amdgpu/vcn: support multiple-instance dpg pause mode
>    drm/amdgpu/vcn2.5: support multiple instance direct SRAM read and
>      write
>    drm/amdgpu/vcn2.5: add DPG mode start and stop
>    drm/amdgpu/vcn2.5: add dpg pause mode
>    drm/amdgpu/vcn2.5: implement indirect DPG SRAM mode
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  34 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  48 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |   8 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  98 ++++----
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 394 +++++++++++++++++++++++++++++++-
>   5 files changed, 487 insertions(+), 95 deletions(-)
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
