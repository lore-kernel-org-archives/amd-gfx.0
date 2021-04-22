Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA2CC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 13:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB66061426
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 13:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB66061426
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4883B6EA8A;
	Thu, 22 Apr 2021 13:20:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8DBF6EA88
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 13:20:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qk87WCaNQeyIg6L7ArxUA3xk94C3BE3IxrRbQEfYZYXeL/xbeoEZCRUOkBxODqYa4gPYSOLW1IV8T+iepEkrc8gT4qY7Jzl8cThPYYRGGOMD/dsx8vVswFms8hio6/7yJ+YYCyNWSUrvf6OSQnjsO8RN3JEd0ZvORASi+V4jVIwJ9O7vFsTS3Xl8xyYrA6d4i0UTOGU+rj1LDnSkG11lPO06B9X7HVCZhuue5L5qIFwSTcQV5s+TQnapWDvELGRaxm6VqvLE9bpi77Twsu7fYKAwv9WCOxSL/wzGxN6DDAWRqgjVeNoIPITo/wgeqYuBK69JhPGdgmAv8K8F17Gc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cei79B5X2xgaBBAtWgLoL8NK6t6q1EsCyp7qsIANLpc=;
 b=Q5NbOpqgiXYaVndO40JxDK1wzQoqFPHNYgsBRaKejxkiul96aNHdS8CGXoLyR7zB6p1EcGy4YAOuYLdkjHQ7rzt0mghHGOKmk6rtZrWdvhaqmKw1QU+p9QSpZcP6/O2ER6w/Zc806+ef47izjD8YJ3exMn+eObG39ynjvOwz1fSCjmqoegS4kPlNc0HqOAml22UT7yfG8xaashTBH0YDtKE1+tUk0AyIjBeskO9QpzrM8FYeqj0iMhgE4f+7X5PLCe58DpcYjpklfndwLunqwnXrRlceXSLkVRRqbrrdss26hpJdWVhTe/+23aoRcprLyRtgIRQ1aIHRG0aBFB4Ixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cei79B5X2xgaBBAtWgLoL8NK6t6q1EsCyp7qsIANLpc=;
 b=wp6vF5vmd6UH5DIUZ8oZHMB8S1KfrpGpUOBswVpjbw3bXXHXSq6tydvfa6nrth+IsBi/AhNRrfMDhmV06EoGJoIby4qgsfFL/X6JlPV4cNp/8e/RQCFyKmL6Uqmv6ysaEGGOP9oftTn3QtXkO+c67AXF/QoEOr4/CRG1BwZBCoc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB2514.namprd12.prod.outlook.com (2603:10b6:207:43::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 22 Apr
 2021 13:20:35 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Thu, 22 Apr 2021
 13:20:35 +0000
Subject: Re: [PATCH] drm/amdkfd: svm ranges creation for unregistered memory
To: philip yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Sierra <alex.sierra@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
References: <20210420015205.9606-1-alex.sierra@amd.com>
 <803e53c6-7268-5521-fd4f-835da994a07e@amd.com>
 <bcd32802-4b03-c7a8-03b6-34e6f3ee0710@amd.com>
 <13fd91b6-473a-984f-6678-b3e3af613e0d@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <5a0dcda1-e270-c109-cfb2-eb882bda0507@amd.com>
Date: Thu, 22 Apr 2021 09:20:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <13fd91b6-473a-984f-6678-b3e3af613e0d@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YTBPR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::35) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by
 YTBPR01CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.22 via Frontend Transport; Thu, 22 Apr 2021 13:20:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87101750-630a-417f-e44e-08d905916984
X-MS-TrafficTypeDiagnostic: BL0PR12MB2514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2514C1D45D3B056E8374F84B92469@BL0PR12MB2514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVMi2VhrKyj1PReXQ1VzgIG9buDBGHvaKWWpKzSFSx9qW+MJQHYJ/iUT9RUIov9cPVLgpMzL//4g6Zsdc3C2Z/V0/zDmq4amBYWlG8etv7PPhdTGU8I4I4Dob1knaiUkv6uZjJHB5jWxNbbfXVtPBskCwu0g/qroDSHw3EUJrafHF2zVZR3AlGAvgkKEFNvO/hrdgqI0s8NW75OiMgdZWZocAI9jKpYNsHeWuHis9a3nAixylPBAi9/oHjzKShYlKcs1r44DQ3GGgHXqr0JquXAsdJTUb8FXxSahOnsURSKkjWieJbquq912S4Wi8WcBtRHVnuveTO1sYeKEIWFF4BXM9ljyp3y2XS0TJgIXqLm14JcRIWfqnZhUqeV6wH9F3ZBVuiAFXlm/LglEr6yqozAuC9uUjcehHNPNxND6PVYJvAh1vYk7ZtA4yacmcSL8FQf4Z1e9/Mynjce3vlmtpq3ihFg+02MHnP5GNFfrWJzSq6Gbb/Vtt8F/wqxrBwVmFjTrGSnyZqH6TGe20ajHzgKriKPEsV+6AXkuScLUQoMdXHnBvFNQp+phg1cH3P4o4FyWk7/DCk8ApUCPLhLEgVru5lp8lltKafR0sDbRkEgJRHpyDUAtfnriIqF9ttzzHqoz+rO02mFKmfKwviAF5KhaXFu4kKEYwj1T1yt6WX6jAVFN7L6zd+GqP9Gt/ydoFRkloxIMOEuLL1y9fys+GDxsJ1yX3qsAJ3wVerq0U7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(53546011)(66946007)(66476007)(66556008)(16576012)(8936002)(8676002)(5660300002)(44832011)(38100700002)(6486002)(186003)(16526019)(26005)(83380400001)(31696002)(6636002)(110136005)(316002)(36756003)(2616005)(31686004)(966005)(2906002)(956004)(86362001)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QTVlaTVhVDNpWmlpUVpUUkJmQWRCbThlYlZ6eHpXbXlsdUlMNjBsSkFRNmJi?=
 =?utf-8?B?VXZPajdEWXFTbXUwdm5pWlAySU9VcUROMnc4aG5VVGo1ZktkcWFqYjk5NjlC?=
 =?utf-8?B?d3JRTVNNMWFOQXlEZGQxT3NYNUg2WGhpZm1mSlpFaW40MUxuZkdiZWZKWWps?=
 =?utf-8?B?ZjV3NW1DektXTWhKYjRCb1FsLzhMRUVkOVk5THpaclZXdGlia2pkd2Q5Mm00?=
 =?utf-8?B?OFlqL2pMWkpEdkgyc0pMb1JHeVFmeFh3TjRxVDdOMmpscE1SR0ZEYXdhQmxz?=
 =?utf-8?B?NCt6SzdEVDdQZnM3VFNGLzgvaWhQbmduYXF2allvYW9vTGRuTEFkZlFJUlFE?=
 =?utf-8?B?U0F3SnlnTElKUCtrNkl5M3gvN1hwRmdqZnNaQ3hyVTc5N3JNZW5sRTdscjMv?=
 =?utf-8?B?R3czVS9YSmNZbDREN3FhY0tkSTMwZGVqcGZqaUZTOFNPQ2RRYzJKSWpZdW5z?=
 =?utf-8?B?eldZM2lmOHRLcEQrc1hKUXRjVnBRN21rWXd2ZnZablJjeURxejdySEVibzMy?=
 =?utf-8?B?aGJYVHo2QjZUV0dYbWNGRFFqNDJjaU0rbmRQQmFIWkF3QS9uTEJibSs4Q2Mr?=
 =?utf-8?B?QlVuWWFXcXR1Qy9UaVowT0NPMzd5VEJKQ1kzNGhIN01CcTVyZjdkMXJOeXFC?=
 =?utf-8?B?R01vamJIblFQaWozTmdXRGFJN1FxWXMzWUdHdEduYXpQZFBjdHF1WGpCRFlz?=
 =?utf-8?B?UVVIM0xoNEkyNWcrMWhtRmJkNHUwY05yTlZuM3dmL1U2cWwzdiswdFFTRzhW?=
 =?utf-8?B?aksxL21jTndiZTcxTkIwdTR4MEdUTUFjNkIrQVprWEgzSWpGZ0ZKN0lzQzFV?=
 =?utf-8?B?dU5hUnhRcVBPNzd2aW5FWkl5aU1DQUtPeTgxV2pmMElhL3BaNm9RdWthR1RQ?=
 =?utf-8?B?N2RiTmMrMExVdjZid2JlMGNsMkRMV1o1VE9CVUcxemp4YzFSYk4rdGRGQnU5?=
 =?utf-8?B?NlpjY1Jmd2k5dEQ4ZDNKa0NqWFpwb2tvOHl3TnpiMDMxcExzYU5iZUhRZ0Vm?=
 =?utf-8?B?SXpkNVAxa0dDUGhlckt6YUQ2MUFheTAxVytTVHdCbi9SODFpS1JiMGprU0kx?=
 =?utf-8?B?dXl2TTVsajlaQVVqWDA0aGlZTVhKelFhWlNzOSsyd0x3dVNXd2lpWEFGaGxn?=
 =?utf-8?B?ZVhuRThlN3cxMzdCUTZGWmxkdm5iaExLeXQwdDkrVUVqTVh0RWt0VjkvYzkx?=
 =?utf-8?B?bGFDOGQ4TTIvVk91RVZZWUgzQmFNY1BnSmpJR05VRjQ1a1JmZ3RNWnpic2Z2?=
 =?utf-8?B?Ri9sbFgreFNoQk9WL25ycHFWVnFEZ2FsS2hxZGoyK1NYUlVRNHpLeGMxRGpM?=
 =?utf-8?B?UDVrVEhQT3lGcHlEdHFlZkRwRWMzcmltYlVUOW5ta3dhcTN1ZkZuNnBrZUhp?=
 =?utf-8?B?TlNPZkRrdEFJYjZmUmJmaDJXQVE2cWxjT3YxSkM2QVpCQVZvRDM0WWxNVnJh?=
 =?utf-8?B?SUhqNHZtVXplR3hNRFk5YjRFWnFUMkg4Q3NTZ1NWVTBOWUhQWFdtbWZoRkc3?=
 =?utf-8?B?YzEwdTVpeW56Y3RxaVVzd3RxbUJvZ1JaakNZaXBqSHZ4Nk9EZEc3Q1FSTUdo?=
 =?utf-8?B?ZHltdjd6RzBzUGRua1lQbng1UXFMNEhSMEp4bTE1TWV1bUNhZEJnNU9GVG9E?=
 =?utf-8?B?ZlR3czBDU2ZhR2NvaWpYZk5kdWpmZGdHeGo3TUdxeGQrUm0vcDExdnYwd1Vj?=
 =?utf-8?B?aDBOYk9wNW1PMHdLYlk3NnVSZmpnLzAzbDNhZUpuM2NTcUJWNUxib3Q2bTBQ?=
 =?utf-8?Q?b8wIKYv9vLCIqdaaRbmBMPZScPLahOzIumIhqsc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87101750-630a-417f-e44e-08d905916984
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 13:20:35.4134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5F52XW0jnhOaW/pjx9BAX9roCuGg6LwPlloilcaKBy0CLdqVU3QUhX6yaQGYNak3NSEtDugeCb/Wh+BP9SNgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2514
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wNC0yMiB1bSA5OjA4IGEubS4gc2NocmllYiBwaGlsaXAgeWFuZzoKPgo+Cj4gT24g
MjAyMS0wNC0yMCA5OjI1IHAubS4sIEZlbGl4IEt1ZWhsaW5nIHdyb3RlOgo+IEBAIC0yMjUxLDE0
ICsyMzMwLDM0IEBAIHN2bV9yYW5nZV9yZXN0b3JlX3BhZ2VzKHN0cnVjdCBhbWRncHVfZGV2aWNl
Cj4gKmFkZXYsIHVuc2lnbmVkIGludCBwYXNpZCwKPj4+PiAgCX0KPj4+PiAgCj4+Pj4gIAltbWFw
X3JlYWRfbG9jayhtbSk7Cj4+Pj4gK3JldHJ5X3dyaXRlX2xvY2tlZDoKPj4+PiAgCW11dGV4X2xv
Y2soJnN2bXMtPmxvY2spOwo+Pj4+ICAJcHJhbmdlID0gc3ZtX3JhbmdlX2Zyb21fYWRkcihzdm1z
LCBhZGRyLCBOVUxMKTsKPj4+PiAgCWlmICghcHJhbmdlKSB7Cj4+Pj4gIAkJcHJfZGVidWcoImZh
aWxlZCB0byBmaW5kIHByYW5nZSBzdm1zIDB4JXAgYWRkcmVzcyBbMHglbGx4XVxuIiwKPj4+PiAg
CQkJIHN2bXMsIGFkZHIpOwo+Pj4+IC0JCXIgPSAtRUZBVUxUOwo+Pj4+IC0JCWdvdG8gb3V0X3Vu
bG9ja19zdm1zOwo+Pj4+ICsJCWlmICghd3JpdGVfbG9ja2VkKSB7Cj4+Pj4gKwkJCS8qIE5lZWQg
dGhlIHdyaXRlIGxvY2sgdG8gY3JlYXRlIG5ldyByYW5nZSB3aXRoIE1NVSBub3RpZmllci4KPj4+
PiArCQkJICogQWxzbyBmbHVzaCBwZW5kaW5nIGRlZmVycmVkIHdvcmsgdG8gbWFrZSBzdXJlIHRo
ZSBpbnRlcnZhbAo+Pj4+ICsJCQkgKiB0cmVlIGlzIHVwIHRvIGRhdGUgYmVmb3JlIHdlIGFkZCBh
IG5ldyByYW5nZQo+Pj4+ICsJCQkgKi8KPj4+PiArCQkJbXV0ZXhfdW5sb2NrKCZzdm1zLT5sb2Nr
KTsKPj4+PiArCQkJbW1hcF9yZWFkX3VubG9jayhtbSk7Cj4+Pj4gKwkJCXN2bV9yYW5nZV9saXN0
X2xvY2tfYW5kX2ZsdXNoX3dvcmsoc3ZtcywgbW0pOwo+PiBJIHRoaW5rIHRoaXMgY2FuIGRlYWRs
b2NrIHdpdGggYSBkZWZlcnJlZCB3b3JrZXIgdHJ5aW5nIHRvIGRyYWluCj4+IGludGVycnVwdHMg
KFBoaWxpcCdzIHBhdGNoIHNlcmllcykuIElmIHdlIGNhbm5vdCBmbHVzaCBkZWZlcnJlZCB3b3Jr
Cj4+IGhlcmUsIHdlIG5lZWQgdG8gYmUgbW9yZSBjYXJlZnVsIGNyZWF0aW5nIG5ldyByYW5nZXMg
dG8gbWFrZSBzdXJlIHRoZXkKPj4gZG9uJ3QgY29uZmxpY3Qgd2l0aCBhZGRlZCBkZWZlcnJlZCBv
ciBjaGlsZCByYW5nZXMuCj4KPiBJdCdzIGltcG9zc2libGUgdG8gaGF2ZSBkZWFkbG9jayB3aXRo
IGRlZmVycmVkIHdvcmtlciB0byBkcmFpbgo+IGludGVycnVwdHMsIGJlY2F1c2UgZHJhaW4gaW50
ZXJydXB0IHdhaXQgZm9yIHJlc3RvcmVfcGFnZXMgd2l0aG91dAo+IHRha2luZyBhbnkgbG9jaywg
YW5kIHJlc3RvcmVfcGFnZXMgZmx1c2ggZGVmZXJyZWQgd29yayB3aXRob3V0IHRha2luZwo+IGFu
eSBsb2NrIHRvby4KPgpUaGUgZGVhZGxvY2sgZG9lcyBub3QgY29tZSBmcm9tIGhvbGRpbmcgb3Ig
d2FpdGluZyBmb3IgbG9ja3MuIEl0IGNvbWVzCmZyb20gdGhlIHdvcmtlciB3YWl0aW5nIGZvciBp
bnRlcnJ1cHRzIHRvIGRyYWluIGFuZCB0aGUgaW50ZXJydXB0CmhhbmRsZXIgd2FpdGluZyBmb3Ig
dGhlIHdvcmtlciB0byBmaW5pc2ggd2l0aCBmbHVzaF93b3JrIGluCnN2bV9yYW5nZV9saXN0X2xv
Y2tfYW5kX2ZsdXNoX3dvcmsuIElmIGJvdGggYXJlIHdhaXRpbmcgZm9yIGVhY2ggb3RoZXIsCm5l
aXRoZXIgY2FuIG1ha2UgcHJvZ3Jlc3MgYW5kIHlvdSBoYXZlIGEgZGVhZGxvY2suCgpSZWdhcmRz
LArCoCBGZWxpeAoKCj4gUmVnYXJkcywKPgo+IFBoaWxpcAo+Cj4+IFJlZ2FyZHMsCj4+IMKgIEZl
bGl4Cj4+Cj4+Cj4+Pj4gKwkJCXdyaXRlX2xvY2tlZCA9IHRydWU7Cj4+Pj4gKwkJCWdvdG8gcmV0
cnlfd3JpdGVfbG9ja2VkOwo+Pj4+ICsJCX0KPj4+PiArCQlwcmFuZ2UgPSBzdm1fcmFuZ2VfY3Jl
YXRlX3VucmVnaXN0ZXJlZF9yYW5nZShhZGV2LCBwLCBtbSwgYWRkcik7Cj4+Pj4gKwkJaWYgKCFw
cmFuZ2UpIHsKPj4+PiArCQkJcHJfZGVidWcoImZhaWxlZCB0byBjcmVhdGUgdW5yZWdpc3RlcmQg
cmFuZ2Ugc3ZtcyAweCVwIGFkZHJlc3MgWzB4JWxseF1cbiIsCj4+Pj4gKwkJCXN2bXMsIGFkZHIp
Owo+Pj4+ICsJCQltbWFwX3dyaXRlX2Rvd25ncmFkZShtbSk7Cj4+Pj4gKwkJCXIgPSAtRUZBVUxU
Owo+Pj4+ICsJCQlnb3RvIG91dF91bmxvY2tfc3ZtczsKPj4+PiArCQl9Cj4+Pj4gIAl9Cj4+Pj4g
KwlpZiAod3JpdGVfbG9ja2VkKQo+Pj4+ICsJCW1tYXBfd3JpdGVfZG93bmdyYWRlKG1tKTsKPj4+
PiAgCj4+Pj4gIAltdXRleF9sb2NrKCZwcmFuZ2UtPm1pZ3JhdGVfbXV0ZXgpOwo+Pj4+ICAKPj4+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+PiBhbWQt
Z2Z4IG1haWxpbmcgbGlzdAo+Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4+IGh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
