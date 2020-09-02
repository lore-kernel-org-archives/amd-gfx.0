Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465A5C433E7
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 19:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1E4A20767
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 19:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="G0YiFkqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E4A20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE166E4FF;
	Wed,  2 Sep 2020 19:54:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0E0F6E4FF
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 19:54:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2jT0MTPjlrzhjbBCjmRJUoagObmQ3IK1JP3wh1mR/4cqPSotON5uqkyLw44UqCvReueRjeVMP0vdfW+J9eX+ZruZKj73DBcpTHwp9o/SN/TV86/s7iPumHeGjXRTUIr4KG318pFxV8jcnT14ChSrrNkp+egaVAH5kq+5OTIUYqgq/Nw1YnVnKzedyG624YJ5XOI1e+ixxsBnRXnhLl3OOxTwxq7xEqSCIN1/gzmamZmjK3tRbYexZ7y/v/QtBHftKl1P9mwso1zOkH35xhY3VTkmEnFVxGNUfCa3C6XxDO9tC7Kj6lpgtx6A3g4wTN3hhmWPPRKjs08hODf3ra+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4K3IrLlnGjgobFuDL7yLTgT0dWekAqobYsy6KcRvPM=;
 b=Xh2gq5rOIF3wG4hnmD21O4diYLVF4fS3+T5Fiv84SIUyjzvjmpXT2vrLGQ4RJsX7iMvQROQPDjd/nWALReKblDe6Iqo1ECbKPTtjh+QleHaYkaKk3H6BEQgxcFO4HjF/P4lSI1ZPV1LCk6jg/07SXvFk8Z46RJ+HZi3jy9uteww/IZ05TfkmNYJzFPzkb17We2zwiPSDhzZ4bdJvSEezs23IkIE+/yBTGykRE2IjzjtTrmc0sXEFBmsESlFWMzlCV8jt+E0otGXsYfzNvefrSEqakLs4Xthc3XGYhrbDHQ7a10KDaG1IyP1q5Ed8SdLmdwzVtTJ1KvWITwgdHH94qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4K3IrLlnGjgobFuDL7yLTgT0dWekAqobYsy6KcRvPM=;
 b=G0YiFkqybp+rB7t7/qqdoeMEndzIcGBSfX8sJ8GGJlLR3aH6HNaBwN//augUNi7itVGenhW8aZhnkp3vsHMDIba6ykdDtFa5LavQvnkYqSNt2pWUQlTeT7rbRCAm1gInuuz11apEiOLBXlmS4W1SDVQKUatBPwKlbiXlYXf5fmo=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM5PR12MB2485.namprd12.prod.outlook.com (2603:10b6:4:bb::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15; Wed, 2 Sep 2020 19:54:02 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 19:54:02 +0000
Subject: Re: [PATCH v4 8/8] Revert "PCI/ERR: Update error status after
 reset_link()"
To: "Kuppuswamy, Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org
References: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
 <1599072130-10043-9-git-send-email-andrey.grodzovsky@amd.com>
 <75db5bfb-5a53-31cf-8f89-2a884d6be595@linux.intel.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <a3cadf36-d597-97fe-a096-83baa73c6f8f@amd.com>
Date: Wed, 2 Sep 2020 15:54:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <75db5bfb-5a53-31cf-8f89-2a884d6be595@linux.intel.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::38) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YTXPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 19:54:01 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 81f6db2a-d652-4367-907f-08d84f79f092
X-MS-TrafficTypeDiagnostic: DM5PR12MB2485:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2485B89C30D029298F91E22AEA2F0@DM5PR12MB2485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ZXpEx0jTNYmo7yJsmBdr2mJ/wshyS4U72cFVisfIcLE1l+0J/l2u8aquSBot91ZbqCEwK+qy4USmO5SNaSszL3AAffPwRLKaJK7VV5lP1xXVEFx6OaR/XBC2nk79Ux19Z4xzmhW57QukCSYkwTJan0f9/k7zTutTxuUANn5jIYihxuxF8FLKAOVxFxcKy93sTzTvUXqPCLgNBD50nHBt2t/qxzT1g4j2QEyBNQ6uwRJKLheC2fh+WoJTB2nq2chCV8vOeYfohA4E3EMtmiuSHy/EOSuPq7QNjFYjD/GgnpwBnhk2Bc89tuaTOU+l209OJgksT9NGOOsWFZR99SRr9cqxCL907Caj8Kn66Bn0coppEZ2cgBv+LFHJUSQkFnd9J1u3GDxjXuDg6wSTvrDOM74XgYGEiLNOqcjZwXKvHKcRuTKEC8wcUAWfQXDx1Xs2XK2X83A9vIsmjIEkjPhkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(31686004)(8936002)(83380400001)(26005)(31696002)(45080400002)(478600001)(2906002)(86362001)(36756003)(8676002)(186003)(16576012)(956004)(966005)(5660300002)(2616005)(316002)(4326008)(66476007)(53546011)(6486002)(52116002)(66946007)(66556008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: NepcBO5NPjxrtjG/eNe8zswI8EWyQt5GIWdAt1sXFxoQJxYKXwyVchbE6vtjlFPde8FJBHHNOavBVfnrlpcPwRrNVHM5jx3BXiuQzPzbumeTKqebOJY8pykyIMjESwQxmQ3UwW7AR8FfRhxoV2Kfer2BjS4fnA3DJK4gg3oK05yl02d/M4fo863kvnkLr+jmC2CTbq/tjUDErvf0KewZ5VDs+k+CQ/QzuGEaCvq59hTLXj3j/n7CAkxV7NskaZi05muDbNVLsRdE7i8ySM/WqUk2ImFGFckgVHon9Qhk3jsviOJqiUV9JjnNKm2xM1m7Eo0dNE1ioHvSoxx1PQWzbVlvaUsuZPazQ2eGu2bNes559zNJ1cLEGZGh0QHGMDucSaqIlgxzg//eivzcky5FPY+EcnNtbHTsek0D3cGh0Y6gXqbeC8GTnaAz5YZ6pfRvBjLLKT5WMfmgSxoQ4FBXIQchLzo8TIqWWQx/aqzmZiRmoIa1KtBAbFbsYnjOYm0uMpqVe1Vi8m+6Sn05+M/Ssa5E6i4MhmnHD44T9i2Apmx6ktT1L29PRMRdlaOZFqibrvkCPEsxf9mR8ehuVUxVYshISh4rEE/V/d2cNIBni19W2UxHPz2nxzi1BJMr9IFDnHSz8QSkkrlqzJI/XUGCKg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f6db2a-d652-4367-907f-08d84f79f092
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 19:54:02.0939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLNL3aFiaaP2ET0adVv4R7ZbAwcwT9H1osdGnm1CzCbdXhT3xHdyLT4DAyCeS0/uxqexkRiDUA1r7OHnWkPgxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2485
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
Cc: nirmodas@amd.com, bhelgaas@google.com, luben.tuikov@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Dennis.Li@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WWVzLCB3b3JrcyBhbHNvLgoKQ2FuIHlvdSBwcm92aWRlIG1lIGEgZm9ybWFsIHBhdGNoIHRoYXQg
aSBjYW4gY29tbWl0IGludG8gb3VyIGxvY2FsIGFtZCBzdGFnaW5nIAp0cmVlIHdpdGggbXkgcGF0
Y2ggc2V0ID8KCkFsZXggLSBpcyB0aGF0IGhvdyB3ZSB3YW50IHRvIGRvIGl0LCB3aXRob3V0IHRo
aXMgcGF0Y2ggb3IgcmV2ZXJ0aW5nIHRoZSAKb3JpZ2luYWwgcGF0Y2ggdGhlIGZlYXR1cmUgaXMg
YnJva2VuLgoKQW5kcmV5CgpPbiA5LzIvMjAgMzowMCBQTSwgS3VwcHVzd2FteSwgU2F0aHlhbmFy
YXlhbmFuIHdyb3RlOgo+Cj4KPiBPbiA5LzIvMjAgMTE6NDIgQU0sIEFuZHJleSBHcm9kem92c2t5
IHdyb3RlOgo+PiBUaGlzIHJldmVydHMgY29tbWl0IDZkMmM4OTQ0MTU3MWVhNTM0ZDYyNDBmNzcy
NGY1MTg5MzZjNDRmOGQuCj4+Cj4+IEluIHRoZSBjb2RlIGJlbGxvdwo+Pgo+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwY2lfd2Fsa19idXMoYnVzLCByZXBvcnRfZnJvemVuX2Rl
dGVjdGVkLCAmc3RhdHVzKTsKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJl
c2V0X2xpbmsoZGV2LCBzZXJ2aWNlKSAhPSBQQ0lfRVJTX1JFU1VMVF9SRUNPVkVSRUQpCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXR1cyA9IHJlc2V0X2xpbmsoZGV2LCBzZXJ2
aWNlKTsKPj4KPj4gc3RhdHVzIHJldHVybmVkIGZyb20gcmVwb3J0X2Zyb3plbl9kZXRlY3RlZCBp
cyB1bmNvbmRpdGlvbmFsbHkgbWFza2VkCj4+IGJ5IHN0YXR1cyByZXR1cm5lZCBmcm9tIHJlc2V0
X2xpbmsgd2hpY2ggaXMgd3JvbmcuCj4+Cj4+IFRoaXMgYnJlYWtzIGVycm9yIHJlY292ZXJ5IGlt
cGxlbWVudGF0aW9uIGZvciBBTURHUFUgZHJpdmVyCj4+IGJ5IG1hc2tpbmcgUENJX0VSU19SRVNV
TFRfTkVFRF9SRVNFVCByZXR1cm5lZCBmcm9tIGFtZGdwdV9wY2lfZXJyb3JfZGV0ZWN0ZWQKPj4g
YW5kIGhlbmNlIHNraXBpbmcgc2xvdCByZXNldCBjYWxsYmFjayB3aGljaCBpcyBuZWNlc3Nhcnkg
Zm9yIHByb3Blcgo+PiBBU0lDIHJlY292ZXJ5LiBFZmZlY3RpdmVseSBubyBvdGhlciBjYWxsYmFj
ayBiZXNpZGVzIHJlc3VtZSBjYWxsYmFjayB3aWxsCj4+IGJlIGNhbGxlZCBhZnRlciBsaW5rIHJl
c2V0IHRoZSB3YXkgaXQgaXMgaW1wbGVtZW50ZWQgbm93IHJlZ2FyZGxlc3Mgb2Ygd2hhdAo+PiB2
YWx1ZSBlcnJvcl9kZXRlY3RlZCBjYWxsYmFjayByZXR1cm5zLgo+Pgo+IMKgwqDCoMKgfQo+Cj4g
SW5zdGVhZCBvZiByZXZlcnRpbmcgdGhpcyBjaGFuZ2UsIGNhbiB5b3UgdHJ5IGZvbGxvd2luZyBw
YXRjaCA/Cj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/
dXJsPWh0dHBzJTNBJTJGJTJGbG9yZS5rZXJuZWwub3JnJTJGbGludXgtcGNpJTJGNTZhZDQ5MDEt
NzI1Zi03Yjg4LTIxMTctYjEyNGIyOGIwMjdmJTQwbGludXguaW50ZWwuY29tJTJGVCUyRiUyM21l
ODAyOWMwNGY2M2MyMWY5ZDFjYjNiMWJhMmFlZmZiY2EzYTYwZGY1JmFtcDtkYXRhPTAyJTdDMDEl
N0NhbmRyZXkuZ3JvZHpvdnNreSU0MGFtZC5jb20lN0M3NzMyNWQ2YTJhYmM0MmQyNmFlNjA4ZDg0
ZjcyNmM1MSU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzcz
NDY3MDAxNzA4MzE4NDYmYW1wO3NkYXRhPUpQbzhsT1hmanhwcSUyQm5tbFZyU2k5M2FaeEdqSWxi
dWgwcmtabU5La3pRTSUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPgo+Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
