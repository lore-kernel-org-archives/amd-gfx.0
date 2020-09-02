Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE384C433E7
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 09:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7814A2078B
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 09:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xxxjhHvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7814A2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 349B76E2C4;
	Wed,  2 Sep 2020 09:38:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F626E2C4
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 09:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uvu08u469Vqx4bON14N0LoRqPwAqz1jp6cCRT+euISU6TZ6VefM5tYNZmFs3Y+1Y1nv/taZg1A9/aWWxk4e0m+CVSLDXm/h3Y3kyv41TWJ/MwCmcyI/mH6GTRYJbknlYM214ioNc94yrvkNxPdhjFZO2h30U4zD763qb5oyUgmLlphI/3iejjIGcvtSTRmC28SrJqERq8CzZvAPrLhu0zxSaH0FnuKtVVsCM7Zni+6a2z1rMBHe0s52lbKVjz88KGfabkml039UUBYtX35NYvsrH2kckl5vVPWlTgRrg+Xwdbe49ewKj/mbNRIAr61dWJxeiktcHGAlTcDFYJnUpLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3ugL4uVKeoIHsIvxIrHy/xag53gJlSUlcKobu7lRaU=;
 b=BJdu4PyTnCr2HpfSQfqo1ScjTphu1/IJJ5lDUjQ5ONuXd9VauME281tJU78rPqD/7PnmtUHL8Wb9OSNLQSLN/1eyscJw01oDsHlwiiz74U+7KS+L+M3MhMlIyxqZ0y4/VW4g2PAM+cY3UnPjQh744jhYfKiiqV3gvlrOEdXt2LswfokAsIRSTvM6O6zBMhBGko4Z5NoDqiUi8dFpok8++8kCrN8cACFGbusZi05LRiDclDkBSnT73Wrx2xAgBEsZ/pVJnhSFBMK6AejWoC7R9jbn3qP0hl8iOsvlWA1Aq3mUSg8vYVYBidj+62k1mQNqrOvOQ3/nQSRHTAH5qfL9iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3ugL4uVKeoIHsIvxIrHy/xag53gJlSUlcKobu7lRaU=;
 b=xxxjhHvVrZU+bwOVCNs65dfTmbWOF0zXI/+kL72/Cy3T4LXj/MDFNBkjpQi/Veve+/ScevKPd8RRcgK523CAYnkS6EtZGaJcfoO4xc4w9uYoq4KEQBb55sYVR6E+oi2drwCOgPjUEapFxRpnScSRO3e1fKNiQxVYj8BJm/YbFoo=
Authentication-Results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1420.namprd12.prod.outlook.com (2603:10b6:3:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 09:38:10 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 09:38:10 +0000
Subject: Re: [PATCH 1/2] Revert "drm/amdgpu: disable gpu-sched load balance
 for uvd"
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200901194928.22386-1-nirmoy.das@amd.com>
 <e09d9528-e2a2-5f17-dd0c-2cf94f9cc0b6@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <9a284eba-3485-2eb4-bcce-5c0d55fd86e5@amd.com>
Date: Wed, 2 Sep 2020 11:42:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <e09d9528-e2a2-5f17-dd0c-2cf94f9cc0b6@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0076.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::29) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 AM0PR10CA0076.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 09:38:09 +0000
X-Originating-IP: [217.86.127.14]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a341c50b-6881-4059-f475-08d84f23e7d3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1420:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1420497F2EA9C80AA0A4EE198B2F0@DM5PR12MB1420.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RqrTCp28tCCbhqSgcFUmBYO+nOVArmcJGZsv5EgC/MkJXqkqdQX3uithLms+YnyqxE1SxSlj9MDlnWurPzc4QWQKNcpiIpxh611OdNawkaKHMHZsvBTvoCdao+etLSoVIcYa7QNolJw7UrMWOR6jxkE/OUuLly8gEJWq65jvOl1y8EQJLXc5e99xKQ7QssC4fBFtEtTDb/+9rVEBvOG/7unKcER6cJyo8cuuI5vvSUB5ugpdeIesunwD2qqcZNMpVsdaNsUI3Fxrqv9Bt1n6xxVLgHxyONqfOmBBWtjq1jYIoeDP6WB+sB/N9kJCEpBMIBxVh9+95l22h373r2C4ElDvt638Nra96s273i1tB9vIpoYd8X0ufcZ2lM2NCI3O
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(36756003)(478600001)(66476007)(6486002)(26005)(66946007)(2906002)(316002)(186003)(16576012)(31686004)(66556008)(8936002)(8676002)(6666004)(31696002)(52116002)(83380400001)(956004)(5660300002)(66574015)(110136005)(53546011)(2616005)(4326008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: tBd2Quk9nimKrBZlOSKcejBJ+RehP+UzdWgCgl2TMDJLK5DuXqCKjdY358/3s2JMeBw4uw94PTMqLQHyhJjBj5gyVn/JZXz+njrOBCEic/iJco4D1VDryL4HVk2SrKcV/+anQPZ6PJEsB6EogtsK3NQSmkmx8J4XEZsvrsA3nstbowhoUSpIBQqNbvEhXfsLnFAM6/zKOgilp4OPwIu/R/RhvzfnWjsAZRhk0+6naNZ/PIngBc7Ttn8zSjdH6PHk0SRbVeo+fkYgvtxYylmim70OoOQc4ltTC61Dgf4liXGFqxyTzAVeICID9ZsFOVsOHWDfn+cY0F0vG7lyEZoppuv3Erocr+7bNfv+ae2jCRBqB5F8KyX4ZOtZlFlbwKyM7FMrvg8/8peqij0HZJHxT40LaLoNbgR0e8fpd0tCaCCXlG1ljHFdor/lrA9ecl5uxtZaeTUFOx9j2aKEzgUPdj8TQV9Y9iquu4xv9fygkXu4C/J/QU7GkQPUj2gLR6qtU092/QatNtH/Ech3903K2ZTI+mHFJfWr/zZ7HZ9+oCfTTpj/gwGf487JEAQuiLi8sjLj6OX1EEAczybDkxXrgFnRJ4Ja8oBuUHgfhE4S58QaHzJGu0EYUrTGyyLZ1LgbShK8xSf2KPClXGh20RFemQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a341c50b-6881-4059-f475-08d84f23e7d3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 09:38:10.7750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6qNfNwJL8pZusF8xojBLyeZh18ldj2R4NMC+sOXVKFuZOtWPu8CNegc1zHvBZrXrCDhWM1BF4Y3zxmXfMeLMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1420
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
Cc: alexander.deucher@amd.com, pmenzel+amd-gfx@molgen.mpg.de,
 Tianci.Yin@amd.com, Leo.Liu@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDkvMi8yMCA4OjU1IEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDAxLjA5LjIw
IHVtIDIxOjQ5IHNjaHJpZWIgTmlybW95IERhczoKPj4gVGhpcyByZXZlcnRzIGNvbW1pdCBlMDMw
MGVkODgyMGQxOWZlMTA4MDA2Y2YxYjY5ZmEyNmYwYjRlM2ZjLgo+Pgo+PiBXZSBzaG91bGQgYWxz
byBkaXNhYmxlIGxvYWQgYmFsYW5jZSBmb3IgQU1ER1BVX0hXX0lQX1VWRF9FTkMgam9icy4KPgo+
IFdlbGwgcmV2ZXJ0IGFuZCByZS1hcHBseSBpcyB1c3VhbGx5IG5vdCB0aGUgYmVzdCBvcHRpb24u
IEp1c3QgcHJvdmlkZSAKPiBhIGRlbHRhIHBhdGNoIGFuZCBBbGV4IG1pZ2h0IGRlY2lkZSB0byBz
cXVhc2ggaXQgaW50byB0aGUgb3JpZ2luYWwgb25lIAo+IGR1cmluZyB1cHN0cmVhbWluZy4KCgpJ
IHdhc24ndCBzdXJlIGhvdyB0byBoYW5kbGUgdGhhdC4gVGhhbmtzLMKgIEkgd2lsbCBzZW5kIGEg
ZGVsdGEgcGF0Y2guCgoKUmVnYXJkcywKCk5pcm1veQoKCj4KPiBDaHJpc3RpYW4uCj4KPj4KPj4g
U2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgo+PiAtLS0KPj4g
wqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jIHwgNCArLS0tCj4+IMKg
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkKPj4KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyAKPj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKPj4gaW5kZXggN2NkMzk4ZDI1
NDk4Li41OTAzMmMyNmZjODIgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9jdHguYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfY3R4LmMKPj4gQEAgLTExNCw5ICsxMTQsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9jdHhfaW5p
dF9lbnRpdHkoc3RydWN0IAo+PiBhbWRncHVfY3R4ICpjdHgsIHUzMiBod19pcCwKPj4gwqDCoMKg
wqDCoCBzY2hlZHMgPSBhZGV2LT5ncHVfc2NoZWRbaHdfaXBdW2h3X3ByaW9dLnNjaGVkOwo+PiDC
oMKgwqDCoMKgIG51bV9zY2hlZHMgPSBhZGV2LT5ncHVfc2NoZWRbaHdfaXBdW2h3X3ByaW9dLm51
bV9zY2hlZHM7Cj4+IMKgIC3CoMKgwqAgaWYgKGh3X2lwID09IEFNREdQVV9IV19JUF9WQ05fRU5D
IHx8Cj4+IC3CoMKgwqDCoMKgwqDCoCBod19pcCA9PSBBTURHUFVfSFdfSVBfVkNOX0RFQyB8fAo+
PiAtwqDCoMKgwqDCoMKgwqAgaHdfaXAgPT0gQU1ER1BVX0hXX0lQX1VWRCkgewo+PiArwqDCoMKg
IGlmIChod19pcCA9PSBBTURHUFVfSFdfSVBfVkNOX0VOQyB8fCBod19pcCA9PSAKPj4gQU1ER1BV
X0hXX0lQX1ZDTl9ERUMpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHNjaGVkID0gZHJtX3NjaGVk
X3BpY2tfYmVzdChzY2hlZHMsIG51bV9zY2hlZHMpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgc2No
ZWRzID0gJnNjaGVkOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgbnVtX3NjaGVkcyA9IDE7Cj4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
