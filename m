Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715E9C3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 15:30:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B8F2083E
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 15:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bSRqzkKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B8F2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BDCD6E90F;
	Tue,  3 Mar 2020 15:30:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5468E6EA8B
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 15:30:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bw+5VtWUpZKYjWHROGWnfeWTCakeljrT2qjg8yXRh1fw2VR2e+nlWgmK6onUIR9dmWoYUNXp2/Nu8PneQZrqvlgptAJva6LB7Sqzwvt2sNG08KF981y+GS2T8wG3be2oD36OYMlq2xcgQBsdQWvADwivg31DVG1UwEizS6mnC7H7lKN5Dd2kUlFR9Xh4A6j4atLOfFisahf2zDsEqJY33sznU2BG7eotD0gAycd1W8hUtz9TKr6xhreXW9vdiyZ4a/lJpru0FpGJBlx5k2ROxXDwqdTOROnqg1O31dMVqo+Dg/oJCmMdKJsDJAng76NfSaXXlz1RrXuvGUzbL7R1cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7My7KvqvZ2gpj6jyJ0LzUA8895UhUTwrQI7EoUx+/I=;
 b=B7zs+mZLPKr/uTbohHqLzdBv+nzz95xxIzfJk5a88ylNWwne/rnZxyRXgFHJSJCQmHnI+4+p8bPt5ORCIqEizf5z+FxaQCVaFbYUfwAKn8zHOpVjQ+a2TROwVAksYg5CZDCPycwVSVWilJ+mei3mawVCvsJhDx655PchhUvmvyW/lIyKDyL7BMCobpT+dKXQUHSWytmES6qJbG1Rjwub9j2Jtm6TXS4lCRcF0/k1hptEbEDJXottcRR28ye40JYAysBqcs6MEN2ohyhRL+7qzQX9tDkR1ISvYOqMEgD+wPGZwn+3ovgGs9jfR0ZCbUda1ViEn4Lf3Ty4mXMzdg/odw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7My7KvqvZ2gpj6jyJ0LzUA8895UhUTwrQI7EoUx+/I=;
 b=bSRqzkKJ8KCMS1cVJRybdQcE+BPK3hcMDGa3VutfixGs591g84udEM4iD8+dNqDUnhND7YFe/HDDq8A6BJsb0+JVSXs2+nPrL1FFleDb0wKvwZcxyOpIzxhJT7OiSX2TpP5ACf28EqTE1ihO0+Ms2u+iGMq+IKBYSJOrPX5jV6I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Tue, 3 Mar
 2020 15:30:37 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 15:30:37 +0000
Subject: Re: [PATCH v6 1/1] drm/amdgpu: set compute queue priority at mqd_init
To: Nirmoy <nirmodas@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200303125039.53141-1-nirmoy.das@amd.com>
 <99ff4cb5-3d6a-c14c-20c6-553d2b22df50@amd.com>
 <478f74f6-db21-0e52-9b19-e968d2fa6924@amd.com>
 <b866db7d-f084-158b-c891-32221109b839@gmail.com>
 <1f70969c-a608-bd1b-d13c-c25bcf9cd389@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <dcdb61d6-f675-e6ad-982d-27717a8e55d9@amd.com>
Date: Tue, 3 Mar 2020 16:30:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <1f70969c-a608-bd1b-d13c-c25bcf9cd389@amd.com>
Content-Language: en-US
X-ClientProxiedBy: ZRAP278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::20) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 ZRAP278CA0010.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 15:30:35 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e9273fc6-1a9b-4ecb-cb9d-08d7bf87d256
X-MS-TrafficTypeDiagnostic: DM5PR12MB1884:|DM5PR12MB1884:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1884518ACE44607E6CDE230E83E40@DM5PR12MB1884.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(4326008)(81156014)(16526019)(186003)(81166006)(8676002)(86362001)(53546011)(4744005)(2616005)(36756003)(31686004)(5660300002)(8936002)(66946007)(478600001)(66476007)(31696002)(66556008)(2906002)(6486002)(52116002)(6666004)(316002)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1884;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aXzbzj+gDAZE3A85aukfi5FQb3CvwiWR/UTkQeK0tutj97KAT097tfaHFua2LYDe7amlFtQ2eaKGhcuAnM2haf2mjfl1bcakSJ/DMEc/uZPwdRktwojQLBXoMyOFw/4AOtDvvjDQApcA2GPYa1DKbaHIQ0qqK6nq+R+MLX1ifBzzRX/q86//fNaA2aVNj43S9kxpoCJCaP9sikPb5MJZDWMnUueM7VYXZrsAURHRaBDtCU2dJcLrAoIIJHZ9oXq1vLhTEicSG7dF1M4NNQHodScXSP2HfPvFr9eAcYf4sqmVfGGFE/OVkturKxN3BP/viZIexKTTwDYwMVvP/EBfOBbo/bQyo9p21YWEgWhW6BJCfsMY83x2hl6ggMFBPfdyk8qYFi7rSDtg/1CJrrm+2/BEKEisBXwdnmEARSCMypLcii/fJkAavAU1mlq0zQua
X-MS-Exchange-AntiSpam-MessageData: 2DojCHwZWV2913Kxq38/rlrfe4HuohkF0hRQkI/PvBO8oXmLw/tWRCY9HirOFy+CYizOgtsse17ZCVh7cD8vTjsU9m5k9jPWT1BCH9kj+80tbJ+bH8JEMO6cnIGnxDG/5Gvx8umbjYyKB3XJpOXTHKtaJ2GYxkE96vegCYutTHlRVwq0cE+U7ewAs9uxBL2bvkobL5souIdE5Ib2EgjpYQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9273fc6-1a9b-4ecb-cb9d-08d7bf87d256
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 15:30:37.1036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHyDrAsUx9iUqfpz7ME0JQ+RJtx3RON5TC+GkZWcalNMwf22gGUtJTIMyohPw29p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1884
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDMuMDMuMjAgdW0gMTY6MjIgc2NocmllYiBOaXJtb3k6Cj4gSGkgQ2hyaXN0aWFuLAo+Cj4g
T24gMy8zLzIwIDQ6MTQgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Cj4+Pj4gSSBtZWFu
IHRoZSBkcm1fZ3B1X3NjaGVkdWxlciAqIGFycmF5IGRvZXNuJ3QgbmVlZHMgdG8gYmUgCj4+Pj4g
Y29uc3RydWN0ZWQgYnkgdGhlIGNvbnRleHQgY29kZSBpbiB0aGUgZmlyc3QgcGxhY2UuCj4+PiBE
byB5b3UgbWVhbiBhbWRncHVfY3R4X2luaXRfc2NoZWQoKSBzaG91bGQgYmVsb25nIHRvIHNvbWV3
aGVyZSBlbHNlIAo+Pj4gbWF5IGJlIGluIGFtZGdwdV9yaW5nLmMgPwo+Pgo+PiBUaGF0J3Mgb25l
IHBvc3NpYmlsaXR5LCB5ZXMuIE9uIHRoZSBvdGhlciBoYW5kIGZlZWwgZnJlZSB0byBnbyBhaGVh
ZCAKPj4gd2l0aCB0aGUgYm9vbGVhbiBmb3Igbm93LiBcCj4KPiBBcmUgeW91IGZpbmUgd2l0aCBz
dHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgCj4gKipjb21wdXRlX3ByaW9fc2NoZWRbQU1ER1BVX0dG
WF9QSVBFX1BSSU9fTUFYXTsgZm9yIG5vdyBhcyB3ZWxsID8KClllYWgsIHRoYXQgc2hvdWxkIHdv
cmsgYW55d2F5LiBNeSBvbmx5IGNvbmNlcm4gd2FzIGFkZGluZyB0aGUgYm9vbGVhbiB0byAKdGhl
IHJpbmcgc3RydWN0dXJlLgoKcmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+Cj4gUmVnYXJkcywKPgo+
IE5pcm1veQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
