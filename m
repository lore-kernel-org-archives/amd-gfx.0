Return-Path: <SRS0=L/30=DT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D66DC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2020 09:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A7920776
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2020 09:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sn3GtUsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A7920776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0274C6E0AC;
	Mon, 12 Oct 2020 09:44:29 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770040.outbound.protection.outlook.com [40.107.77.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08D0A6E0AC
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2020 09:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xjzs2bMAsy+uR2ZJkuuSrf5a+c9QlWBzBhWD5XdP32vA8wDRmJ8aKhmIxFEWXa4AsMgEI8IzpzdaTnMsOrj2AS6uR41zSnd0EnIG9Rd8SCrc7SXG9+NwnMrT7/5QsPlX69RFZiCRqO4lUwvcAIXdF3yxzg4xtVt82FfjXN3S8Pj7RMzd5yQvwWi7sTQ4RZ1m/MneK+2ecdrjJ4Vhn4aUgNW2zH5ZruYIw8C7gx+AWHiYSLglGBLGRx7iXXaHYZbuto1zTWmeVSAXJWVv4uwNgnJebA4uflcxv/04q3uGBnAMnIALBv4dCZX1e/yGLeWAOIbYIUBKEqTlJ4ER58oaJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkjDhGj5Q8WGW8bR4QRDe1n6mhXmPj3wbzbD5KMoWO8=;
 b=YFV8/EwIe7RuIW0aGxKBov4FkdGbrry1/h4mWodJpxP48b09+ProP4rCTvq6/nwgCp/8e9eWNp+rIDq/5BasNlnr/CIJvxPy7/WxHRhH6uyhMr8rkvHfjp5absKo12B+x8HBjBBoUa6AbhOEK4lGYulDpSd1EtbU+caaR2F+kL1R2WEQwZmgosOwq5R2KwauQKIEp0JXn3thvtVvWar9xTY/InZg4yoDO0wMTVih+rYsMVgATEgtQma3aVDLOeG2mGdG+HeTCxzkxS65Rbbn4TNbY2dkf81B5BjYzdluGmO/Sy8L6JSUMZM/652TXx6tfgQ33fjIjAWUChm91/yHjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkjDhGj5Q8WGW8bR4QRDe1n6mhXmPj3wbzbD5KMoWO8=;
 b=sn3GtUsSOoqf7r4a9vPTRZ8TW4fNNQhCnbO/f4xITbwwae4Rpn6aI2HMztaHa7Bg+Iunxg3teHHwpQUpvabXBoiVuPaqzNHDy1Sxjio6KUuNUaRWhC4eqTr7miKu87HCJ/C2qiPesiMI1azwUr9iEBxYi9KYQbjE1vtqHF1lUR0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4566.namprd12.prod.outlook.com (2603:10b6:208:26a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Mon, 12 Oct
 2020 09:44:25 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 09:44:25 +0000
Subject: Re: [PATCH v3] drm/amdgpu: Add debugfs entry for printing VM info
To: "Patel, Mihir" <Mihir.Patel@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20201012090159.28825-1-mihir.patel@amd.com>
 <d2d63bd0-61a0-33ce-67da-78143412d6b1@amd.com>
 <DM6PR12MB44527C86830BA20463BCFE6BE8070@DM6PR12MB4452.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <64b13a59-f5c1-ff4c-f76a-0e1a00b249a0@amd.com>
Date: Mon, 12 Oct 2020 11:44:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <DM6PR12MB44527C86830BA20463BCFE6BE8070@DM6PR12MB4452.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM3PR05CA0085.eurprd05.prod.outlook.com
 (2603:10a6:207:1::11) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM3PR05CA0085.eurprd05.prod.outlook.com (2603:10a6:207:1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.26 via Frontend Transport; Mon, 12 Oct 2020 09:44:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6c7876ea-d577-4c07-246e-08d86e9367c5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4566:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4566EE0B5967F8DB3FDBF55883070@MN2PR12MB4566.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jc1Ww7PvygAyVqfLDo8FRtCZ1Zk+Gtkztz+WsNGL1DfZmSC8TmTObTTr6ak4PUrY9BZo1Qjs6Zw6VXDOTzq/IdpeFTngZbX1qhaEyrBWqZ8T77f9OAYumtSsVqYWAn/LZ9h28XmggaOhVAW3ZABL0CPHGunDo59UiDBkpy+hXkCNH5oQNZDYGpQ2na4GG0mHgrt6/gbyN/MOuoj2BHtQOzxnEG7DwS8EKWelr7FkSpnaJ3Q8AQUgT8Kssh/5f4pjmglfuBjFKYKa0l8LMNOCFUbXf7xCYwWUu3sA6YGBnuNMb2b95M1eZw76scmgogN9Go1edlhemTT8Kp2vbN7lepXvVKUo6Gu5DEBKK+G0Xi8vDcEHP8ZZoF9MU5g2srlC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(86362001)(31696002)(4326008)(31686004)(2906002)(83380400001)(8936002)(8676002)(66556008)(66946007)(52116002)(5660300002)(16526019)(36756003)(186003)(478600001)(4744005)(316002)(54906003)(110136005)(6486002)(6666004)(66476007)(2616005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4eeLAL7Zw5KhCqIrcnn4PBiJ2S/tBt3jPLSQOPdcnKXUc6xrGVVy7yIY/4nymHhaJIkN3521YJV0p3nJ6cyf889OY2l5EpZJTw29m0O5KTAS8kQR05UGUvKwEXatpBEDJFF+7MKljRcHzN0AJ1dKD4mk0Sde0Slbr58FRUsBEZjoqCnW3WQjJH9xdOGfmAyGfxFLhHa6ftXXYEFQGN+eFplLdjcb0AXPv5/73Mipb0e83/uF7cRXHt4rJ6GZfsHgUZ4WUakDYxUoiaUl+oeRtm5gZKBsU9df7PtSv15JiyVy2IlcYJB8jjxB6i3XhelFOXuaLBUVa6ZTKS9wCWMUUhlSUjsSFXrLFZoXl72UdJ1rmEC3tuc+z+wr3syVOR7Xz5FtrIWl70INJ52HcXPLRpv9E1ostWR1ru6ZuZm7YFEA58rqC7SSkQ3nBi657vaBfupw87sNCWiOKFliInA/3GMyYeIHPwsoSsnDWzcsKaBcYPJijAaLV0QYDc6N7HvnOvEB2lRJ7eWJJ+nX3V11VzxviEhGdEs4h3LGiDofZ6oI0tzRuTkcYpcrzoCIne/muGgp3dHSioPgj7sXb7TuX0mvskVaR211rgrbUBveETUaYzekxFER9+AcCh2HgHAdwmcuofVwXZyAo/Ipt5NMIaIAiJtrYPZSMdfpQwp27vQAQHhw1DQHpAB/nSKfWcn0d00D6DE61UJTjkgae22v4A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7876ea-d577-4c07-246e-08d86e9367c5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 09:44:25.5155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JmDNOy4haya+4nns3Hmq0V7E1GHZZelB6HnLrEwt7UHdY4dgeSvp6gBDeQNAuyZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4566
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
Cc: "Chauhan, Madhav" <Madhav.Chauhan@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Kamliya,
 Prakash" <Prakash.Kamliya@amd.com>, "Surampalli,
 Kishore" <Kishore.Surampalli@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1NOSVBdCj4gSGkgQ2hyaXN0aWFuLAo+IE9uZSBxdWVzdGlvbiByZWdhcmRpbmcgZ2V0dGluZyB0
b3RhbCBhbGxvY2F0aW9ucyBieSBhcHAgYW5kIGFsc28gc3dhcHBlZCBzaXplIGZvciB0aGUgYXBw
Lgo+IFNob3VsZG7igJl0IHdlIHByaW50IG1hcHBlZCBlbnRyaWVzIGFzIHdlbGwgdG8gZ2V0IHRv
dGFsIGFsbG9jYXRpb24gYnkgdGhlIHByb2Nlc3MgPwo+IEFsc28gd2hpY2ggbGlzdCB3b3VsZCBy
ZXByZXNlbnQgc3dhcHBlZCBtZW1vcnk/CgpOb25lLCB3ZSBkb24ndCByZWFsbHkgaGF2ZSB0aGF0
IGluZm9ybWF0aW9uIGFueXdoZXJlIHNpbmNlIHdlIGRvbid0IApyZWFsbHkgaGF2ZSBhIHN3YXBw
ZWQgc3RhdGUuCgpTZWUgd2hlbiB0aGUgYXBwbGljYXRpb24gYWxsb2NhdGVzIGEgQk8gaW4gVlJB
TSB0aGUga2VybmVsIGRyaXZlciBpcyAKZnJlZSB0byBzd2FwIGl0IG91dCB0byBHVFQgYW5kIHN0
aWxsIGRvIGNvbW1hbmQgc3VibWlzc2lvbi4gT25seSB3aGVuIGl0IAppcyBmdXJ0aGVyIHN3YXBw
ZWQgb3V0IHRvIHRoZSBDUFUgZG9tYWluIGl0IGlzIG5vdCBhY2Nlc3NpYmxlIGFueSBtb3JlLgoK
U28gd2hhdCB5b3UgY2FuIGRvIGlzIHRvIGxvb2sgYXQgdGhlIEJPcyBpbiB0aGUgQ1BVIGRvbWFp
biwgYnV0IHRoaXMgCm9ubHkgZ2l2ZXMgeW91IGEgY2VydGFpbiBoaW50IG9uIHdoYXQncyBnb2lu
ZyBvbi4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4KPiBUaGFua3MsCj4gTWloaXIKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
