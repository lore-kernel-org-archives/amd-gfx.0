Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B8EC3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 16:42:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6068520857
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 16:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="m89zakoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6068520857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10D1D89F8B;
	Mon, 20 Apr 2020 16:42:15 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700067.outbound.protection.outlook.com [40.107.70.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 403BD89F8B
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 16:42:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCB1vfYa0dWH8+ZJ43xeY8VlUuatgj9UVWh+AHoSX3kjtr4+8/AiLwHjvVXo980oWOYkmy6CvnJrsnOEMloZClesF68KokcH6/Pf/I3NFtOtBzG5eRNaeVAI9x0m0sBPdUC9Cxvsi5Gi8tXqx+p0u9n65t/Q3GSHpbMjTd8r60b3qWUWYvvelxGPSOMNCxV/zaPEpmZq+MkX26XjhJdmail8SVO+02adyI9T0E07npxaKS4f7yQYsRAVD6Hpv1AgP8KR7hOTJ8JG6s56clj5WeLKv9jui36AwaXHqQoWfxumq75rm6ZC1XhSf5qfvuvv9aVzUs0O4OhAXnNPBCRMOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKYnH8YnheDFfGKNHGzaPqvDKQNmaPLBQflieZv9cAY=;
 b=Su+ZojaxfVYKOSH7FDTiBJXE59YBKR4q+jHtbK7HdBw3DrPTeqUNrZMxx7e8E7KZxS5KtkhbO2rlEa6B11S3BfV8ObX7P6z1Bflzc1mzf1Lf5nWwMdYomBr4bNpCibQ10J6AFu2cqVCwcR/itq8CMTBQ3kKKmn/6paahu1iQXaoF7HcmxMvTmdJyGgiqScfrXyRz1h2j/KxcvAFoVICa7tlsoAcCkHjExxPBHWt1+aeCbx1KgZKUtKsFQUlnackV3scLpNl5Vdj9B+01H3qurQJYE6gR1mxRQTS7fJ+q9U6nyB3IQE1YDyHzJP5x63aj/FpRB05wzFa2xhZhRz1YTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKYnH8YnheDFfGKNHGzaPqvDKQNmaPLBQflieZv9cAY=;
 b=m89zakoL4a2i5tefs6E4dUsEZzbJWed+cGghZ6v/M/T+S1P1Cbboe/UV431WLQsUBIGoCo5FvkpAVbmIq/JixLhYMV1lBAoU/+/CsYsZvN9HAOJo52l80PnO9cJAB8uKi0qUtXxiZKGbGOOMnfuX3zwi6Z4TdNXN2LjWUrNSouc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2590.namprd12.prod.outlook.com (2603:10b6:802:2e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 16:42:11 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 16:42:11 +0000
Subject: Re: [PATCH] drm/amdgpu: refine kiq read register
To: "Tao, Yintian" <Yintian.Tao@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu, Monk"
 <Monk.Liu@amd.com>
References: <20200417065310.21108-1-yttao@amd.com>
 <2359153a-853b-6cdd-acbc-21ff0fb0b473@amd.com>
 <e719f52f-557d-e67b-b22b-1ba20243b636@gmail.com>
 <DM5PR12MB17085EE2FE723A7263A1E77484D40@DM5PR12MB1708.namprd12.prod.outlook.com>
 <0612fe9c-43bf-acb8-c0d0-1987f3e293f7@amd.com>
 <MN2PR12MB30397EA7DAA30DA4804B5322E5D40@MN2PR12MB3039.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <0aaad08d-c7e7-df82-4af7-f04a4dee7ab4@amd.com>
Date: Mon, 20 Apr 2020 12:42:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <MN2PR12MB30397EA7DAA30DA4804B5322E5D40@MN2PR12MB3039.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::25) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YTOPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Mon, 20 Apr 2020 16:42:10 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0d6bf76b-3dd7-4a76-5b04-08d7e549c59d
X-MS-TrafficTypeDiagnostic: SN1PR12MB2590:|SN1PR12MB2590:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25906A657A55AAAFD32CF46A92D40@SN1PR12MB2590.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(66946007)(4744005)(6486002)(81156014)(6636002)(8676002)(2616005)(8936002)(5660300002)(86362001)(26005)(956004)(31696002)(16526019)(186003)(16576012)(316002)(4326008)(36756003)(31686004)(2906002)(478600001)(110136005)(44832011)(52116002)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y84WWkitBB/2IRQEw0cd7yHBlU3du1mM8vOuByCfGC8oSrxCDiNSXFHQxkNoZOPwdS/h41b/26xqIuW4YzWIdrFod9jh5z7ir/LyRIxkOqQDC6FWux/HWaNjUiutev+CI8IAUapgUqWEEp0G/mwcLvxTBHpY2oqV8KXxCROf/BqwHC2LEBVmutjQjL2kyf9KmVbfoK3Zw9aOvCP/PL1JyslngvutFeEmEOHZecScCYkFiBTo0X5FRUBSNb0K1CRja22dTj9hx4pDS8l8d0CulMjC52a8qbE2en/jciFDFepVlb7eHkU6+jhJHMr74pp0C9E0YT8O6j1mFWREpTAvhxF1aukgGf9ZysH3WN7CD9ciHB/y2XOfmp+wbTBSH2m9gN7ysUyEdAcxC46lY69+VvMjdHlLiiSUv8RWlYo2Duad403kUQ738h4tz4zktx3H
X-MS-Exchange-AntiSpam-MessageData: IvzJ50QMez64lNM5iXtLb3mssBrd22U4bOBsx49vJy1VjEfxV670ijvnaa2gZe2QLu2yi4sBfGTWQu+pux65A2lHuHHSo78SM485Fmadtn5xPtdjGVHz5AW7gZPFpLYHXYYri2GRfAtbbB85YFKtdA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6bf76b-3dd7-4a76-5b04-08d7e549c59d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 16:42:10.9960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzR7b/2MqqS0VVwgryIIrUlrZwZ+7az8P9gABLgMbPYLm20Nd90qSacRaz98uu6KKaA3QdrP4oJosKnGejLqeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2590
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMC0wNC0yMCB1bSAzOjQyIGEubS4gc2NocmllYiBUYW8sIFlpbnRpYW46Cj4gSGkgIEZl
bGl4Cj4KPiBJIGhhdmUgb25lIHF1ZXN0aW9uIGFib3V0IGZ1bmN0aW9uIGtnZF9nZnhfdjlfaGlx
X21xZF9sb2FkKCkuIEkgc2VlIGl0IGRpcmVjdGx5IHdyaXRlIGNvbnRlbnRzIGludG8ga2lxIHJp
bmcgYW5kIG5vdCB3YWl0IGZvciB0aGUgZmVuY2UuIERvIHlvdSBrbm93IGhvdyBLRkQga25vdyB0
aGUgaGlxX21xZF9sb2FkIGNvbXBsZXRlPyBUaGFua3MgaW4gYWR2YW5jZS4KClRoYXQncyBwcm9i
YWJseSBhIGJ1Zy4gSSB0aGluayB3ZSBjYW4gZ2V0IGF3YXkgd2l0aCBpdCwgYmVjYXVzZSB0aGUg
SElRCmlzIG9ubHkgdXNlZCBvbmNlIHRoZSBmaXJzdCB1c2VyIG1vZGUKS0ZEIHByb2Nlc3MgaXMg
c3RhcnRlZC4KCldvcnN0IGNhc2UsIEtGRCB3aWxsIHN1Ym1pdCBzb21ldGhpbmcgdG8gdGhlIEhJ
USBiZWZvcmUgaXQncyBtYXBwZWQsIGFuZAp0aGUgZG9vcmJlbGwgdXBkYXRlIHdpbGwgYmUgbWlz
c2VkLiBTbyBLRkQgd2lsbCB0aGluayB0aGUgSElRIGlzIGhhbmdpbmcKYW5kIHRyaWdnZXIgYSBH
UFUgcmVzZXQuCgpSZWdhcmRzLArCoCBGZWxpeAoKCj4KPgo+Cj4gQmVzdCBSZWdhcmRzCj4gWWlu
dGlhbiBUYW8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
