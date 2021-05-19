Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D54C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 05:51:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB2116109F
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 05:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2116109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EA876E859;
	Wed, 19 May 2021 05:51:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A84C16E859
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 05:51:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eb2XQ4OS9vFfv9Gtqr/s9P73XUaDz5GPWoArmaPN3hqu/1SjgASmmnG7fTZGU4v2ElR8y6IbI9GlkVJ+tB5jDkGc9mJf70NomV7kEPLidUNvR4RMT8cxeL/eRhQID9Bp6NhoiF2G603B6osAWjZI9t3NkwRFNcZHHpNPECu9c4x+YEpyW4zY7ak1CzMCobxM5lZmlrZ1uI2J0KvOWZnY+MYhJipZOXdvM9CMs7PEA+ZVD6yLYebq+QYcm99H7kKw1LglUdfhb1MAhIYu7bqLGwowiubTRQ0VgJnwSvGVqmSwMP32Rtzg3TXIkFFY8VYpTpkFxt/jK4juNhr2Ya9wLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtuE5F2on+kPgNQa0uWplbS+ZVefscqrzjt+ycTsNFc=;
 b=BFYyZrNTu16wXvi2InAc4dFPeX8CT4EbGBROC7F3iviYoQMeCEl7dyGFHMsEHxv4NL6CIGHgei0GjCrVmWigWm+1unUkuyKDKoIf4gwmAVqmUDq03eF0kVFcDsDjYXx9Y1hwzGrBvaPKym6J6xPVe3n0STfcz0b9CfR7Ix667QF4y5AQSwEY21HTtFPLHD6l7QqClET0rGfS3XZPZn+h9hpEfF7dp1Ji77CLigeUidnyLcH9Mrz3bikG3iNqGLg9DPYbu0SGXkMmmpyPn9Ek/A2DzyOmljGETvtputmtVu0EKekWa6MQeqybJJujlBxRhKnuqgQK5jFyFOts3n7hdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtuE5F2on+kPgNQa0uWplbS+ZVefscqrzjt+ycTsNFc=;
 b=j0AbKjyeS3qrWaATPVg1srOnRC3rxTqiEgxcXrp+kbc5+ZKbU/vuHwLOFcXuCNl2trFMIxWixlHane0KxzkNzzQiN1NXUTwpmjqKOPEQ7CcDu9ynbDPSRIZBzMIQqho+WLcOwX5+jv+ZWtXMs88aLP1G/RLOU+lyHGG7cMevhbE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 05:51:43 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 05:51:43 +0000
Subject: Re: [PATCH 2/3] drm/amdgpu: Use preemptible domain for KFD
To: amd-gfx@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <20210519054536.4690-1-Felix.Kuehling@amd.com>
 <20210519054536.4690-2-Felix.Kuehling@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <4cae5d45-a071-3557-a83e-0d53bed38b99@amd.com>
Date: Wed, 19 May 2021 01:51:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210519054536.4690-2-Felix.Kuehling@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::25) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YTXPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.30 via Frontend
 Transport; Wed, 19 May 2021 05:51:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab97a286-ede9-484e-7d0e-08d91a8a2de0
X-MS-TrafficTypeDiagnostic: BN9PR12MB5211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5211EA8D0AA1D91ACC766248922B9@BN9PR12MB5211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QkeQHlFaQtU412Iz7/VuQMaAtWYA6ignoVQUXE/y6nWY+kFLhnUrFmUVUHDuFDRIvy4HIFIc1hqRyeHl+NLqYkI7iYaXt/0XW9n3k5F50TI2kbvaKWmiw9TIfliAjEnaV7CXpc5J0ccwelG9ZtMvVHiuBQ1cmP42C2ugYbeIQxuLfe6tWpHvA/AonHMLV82tkGOJhcrjD8LnT7gEk/BFrIjyWw+NITrzGQZoghv9gBaphGEokSBkcl5IWUa/gMYvk7ABTolY8EXasiChM3+LC34S0PmEPh4W140v1AZyo+loDMbDHh0a0oPBmBxyPyQBMc1HCKcFTNVpwXJJt6/HtKWQ+cWWxz3jR9LhaD9XxRvpAae0AU0PVBpisUtpQzmcDHh2n8YyaJTgYwsEJogAJ+PFqvYUkJrlYD0eymfnVylhxSrZ0wys7E9VKIn7J/em0uqakWOaMXj7uqX6nqVI5rZ/mYuwuHKlTmS629TeIKvufeh+z0pxzyYfU0Xjyn9PCzf9DpmCXDtUYYu/PlEWROH4g+r1x7Ut0NtT1b6cJA8/C+WjV8X6e31bsKl+J23MpXx+w2rFLg7NNYJ/w4ibMRtKQ+7ih+kWdaHBtH/24jYJFpoFZoFmZ0U1VOa99jTRCgJrAEBaK1XOK4NRNjTd5hw5AZMPYT9gZE7XjJX5DkZV0ZMnQLsgmShhSJI4l9KB1USWB2tH7ewpyw4b+/TCEDk0t2vmRQCX2cXJBlPpi/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(16526019)(956004)(2616005)(31696002)(6862004)(53546011)(8676002)(26005)(86362001)(186003)(36756003)(66476007)(83380400001)(6636002)(66556008)(52116002)(36916002)(31686004)(66946007)(2906002)(8936002)(6486002)(316002)(37006003)(38100700002)(16576012)(478600001)(38350700002)(44832011)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YUt6S1BpcFl5MUpsVnMzN0JKbURNMGZ5eUZuakFPZUhHYjBUdlpKSlFUSFU2?=
 =?utf-8?B?dytUYkQ5ajgrTFVKcGxrUkxYL2V2RnI1Q1Zsa3BiMS9HelE3bmJ1U3NRZmoz?=
 =?utf-8?B?RE9ONUYvekdiSlorQ1VaOWtPQ2F1UThjRnRuYmhubmVzajBSMlZqZ3BqWVBK?=
 =?utf-8?B?Z2szbTk4d1lZbDk4eW8vbmtWRTl3ZDFKN1F5V0xUZjNTbjRsdmx5WTZKMUYx?=
 =?utf-8?B?azNZVndBR1NsSFI0US9FOW5ieERqc3QxdFhqcVloUTRXa0YwUUtvbzR0THVu?=
 =?utf-8?B?R0NEM2JzZ1o1K3lHdGQvZFhzb1VkV21kMUJMNUIvY3M1RnZyTnBxdzBhbGxr?=
 =?utf-8?B?ak5CaS9MOFN0ekg5bENkSW05Q0I3c0JDK1MyS0Z2MGZoNngyZXJxbnU0bC9l?=
 =?utf-8?B?dFpFaml1dkV5aWhNU0xkNFhCdXJ1RHdBbzFaS2VPcUoxN2kzNlpLdURkTkNS?=
 =?utf-8?B?Y1luWWdYQ1dhd0FXVkRLQSthNFVxU3VOYjc2Um5KeE1WNytwRVd6WXYrM3VS?=
 =?utf-8?B?YlBWK25ueVVBSFozMVFOSTFVbzZhNkpQOVhlNEh6ZnNWaGptczNTbytIViti?=
 =?utf-8?B?Q09VWTdKYjRoTUhmZkI1eStYVlpOb1JVaFRIeW12WVF4elg1ayt2TTZ3Yjl3?=
 =?utf-8?B?WVcwUGtoSlJnL2wydmpLTVQyTjRzbXYrREhSWlg2SitrSy9ZTkRwYXo3dHpq?=
 =?utf-8?B?RXowdnBOWkxlZkN3YXl0bC9jV3VTN1N6a1lNb0RSa2xIc3B0ZytYNHVqOHhY?=
 =?utf-8?B?N2lnOWZhcHdtKzZRbHBaZDBweDhUcXp0ZGtMM05sejFHQ0FlYXhCbnI1WDNQ?=
 =?utf-8?B?ZzVXQlpPWWVhUkplZmtZRFUrRW5sMXVWb09ER2RheWNuZlVhRUlNQ3A1KzJN?=
 =?utf-8?B?dGdCeUR3bEc3Nm1EeU1uTE1ZYkowM251cEk3VlFINTlZdlZ0dTN0Nm9uTmIx?=
 =?utf-8?B?Qm1KTWluQ3VIQzUrZjhIWm9QWXZmOXE3ZlBCcTZDS0R3N3l5eDJ2OXFSeEtz?=
 =?utf-8?B?M0l0ZmV0QWg3R0wzY3dwS3VZeks2WENaLzJJOWo1ODd0TVhOWGNIUFhmV1RT?=
 =?utf-8?B?b21DTnVyRTRoYnNJbU9tWkgrRndiUzNNMURObFR6U2JLd2pxVVNZN0RtcDRl?=
 =?utf-8?B?MTZGT1FlemlyOTJYQ0pzWHlUb2hQOEFWczlRcnNCZ21NcXlVQTVaT2VXV2Vj?=
 =?utf-8?B?U2dJS2o5Ris4NjM5WjNzQ3lFazF5WDhJUjFseExTc3hWYlMrandzMzgrL1F3?=
 =?utf-8?B?a3YvZ3lUZlhzNkhDNE42bUt1TS9NV0VLV1FZRms1Z3lnTjNOanM3c3o4VHRT?=
 =?utf-8?B?VktCaWlzdHRSRWtaTEVHUnp6Y0JKTERuV0tzbTQyZkM5V01zL3FwMGxGWGZh?=
 =?utf-8?B?andyTFZOYzZaWE9kelNCVUJrVHRXUXJXeHhHRXdBdEU2emR5ZWd0anJGZWJ4?=
 =?utf-8?B?ZFZzVUlWcHpTdkw0QVFlN0h6dThFaUNHK2NWYVl5VVViNHAxQ2d0UjJXN2tv?=
 =?utf-8?B?OUh3ZWJva0Zpb0ZVbDFvZTlBOXk3UklQMTVZSC9XK0FKMEZIY0lxUFpocHQw?=
 =?utf-8?B?eS9IY3B2WlBDVGVPVWNoWHVkYlFOSGpBMkNMSlhaaVpXN2RtaTlJTFdUcnJv?=
 =?utf-8?B?RXlWR05ic1IwMU5CYmVqbU1IbjBzeDRWeloxdHhUNUZLb2Fld0E5SlJ6SzdZ?=
 =?utf-8?B?a3RBTzg1TnRRVmMxdzgwcm9YVzNid3huSUJuMHhIblhkRG1GaFI0K1JiL0xH?=
 =?utf-8?Q?7z/jwHOzQv3WdtJoXz4vUYW0jPT07g6BPTJ3TJN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab97a286-ede9-484e-7d0e-08d91a8a2de0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 05:51:42.9620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djmjioIgmSRAy6qxTYHVrW1Hkgm9nbmPMBDxopQQuZ/7bEmy3YlMuiQUNUfm3ZTPuWrjO+Kak2usofUBa4Pvgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5211
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgWGluaHVpLAoKVGhpcyBzaG91bGQgYmUgYW5vdGhlciB3YXkgdG8gZml4IHRoZSB1c2VycHRy
IHN3YXBvdXQgcHJvYmxlbSB5b3UgZm91bmQuIApUaGlzIGlzIG1lYW50IHRvIGFkZHJlc3MgYSBs
b25nLXN0YWRpbnAgcHJvYmxlbSB3aXRoIHVzZXJwdHIgQk9zIGdldHRpbmcgCmV2aWN0ZWQgKG5v
dCBzd2FwcGVkKSwgd2hpY2ggYnJva2UgRE1BIG1hcHBpbmdzLiBUaGlzIHBhdGNoIHNlcmllcyBp
cyAKbWVhbnQgdG8gY29tcGxldGVseSBhdm9pZCBldmljdGlvbnMgb2YgdXNlcnB0cnMgYW5kIGRt
YSBtYXBwaW5ncyBmb3IgCnByZWVtcHRpYmxlIEtGRCBjb250ZXh0cy4gVGhhdCBzaG91bGQgYWxz
byBhdm9pZCB0aGUgc3dhcG91dCBpc3N1ZS4KCklmIHRoZXJlIGlzIGFuIHVuZGVybHlpbmcgcHJv
YmxlbSB3aXRoIHRoZSB3YXkgVFRNIGhhbmRsZXMgc3dhcG91dCBvZiAKdXNlcnB0cnMsIHRoYXQg
d291bGQgc3RpbGwgYWZmZWN0IHVzZXJwdHJzIGluIHRoZSBncmFwaGljcyBkcml2ZXIsIHRob3Vn
aC4KClJlZ2FyZHMsCiDCoCBGZWxpeAoKT24gMjAyMS0wNS0xOSAxOjQ1IGEubS4sIEZlbGl4IEt1
ZWhsaW5nIHdyb3RlOgo+IEtGRCB1c2VycHRyIEJPcyBhbmQgU0cgQk9zIHVzZWQgZm9yIERNQSBt
YXBwaW5ncyBjYW4gYmUgcHJlZW1wdGVkIHdpdGgKPiBDV1NSLiBUaGVyZWZvcmUgd2UgY2FuIHBs
YWNlIHRoZW0gaW4gdGhlIHByZWVtcHRpYmxlIGRvbWFpbiBhbmQgYXZvaWQKPiB1bndhbnRlZCBl
dmljdGlvbnMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxp
bmdAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9h
bWRrZmRfZ3B1dm0uYyB8IDYgKysrLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwo+IGluZGV4IDkyOGU4ZDU3Y2QwOC4uMjg1NmNhMTAzMmRi
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRf
Z3B1dm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRf
Z3B1dm0uYwo+IEBAIC01MTEsNyArNTExLDcgQEAga2ZkX21lbV9kbWFtYXBfdXNlcnB0cihzdHJ1
Y3Qga2dkX21lbSAqbWVtLAo+ICAgCWRybV9wcmltZV9zZ190b19kbWFfYWRkcl9hcnJheSh0dG0t
PnNnLCB0dG0tPmRtYV9hZGRyZXNzLAo+ICAgCQkJCSAgICAgICB0dG0tPm51bV9wYWdlcyk7Cj4g
ICAKPiAtCWFtZGdwdV9ib19wbGFjZW1lbnRfZnJvbV9kb21haW4oYm8sIEFNREdQVV9HRU1fRE9N
QUlOX0dUVCk7Cj4gKwlhbWRncHVfYm9fcGxhY2VtZW50X2Zyb21fZG9tYWluKGJvLCBBTURHUFVf
R0VNX0RPTUFJTl9QUkVFTVBUKTsKPiAgIAlyZXQgPSB0dG1fYm9fdmFsaWRhdGUoJmJvLT50Ym8s
ICZiby0+cGxhY2VtZW50LCAmY3R4KTsKPiAgIAlpZiAocmV0KQo+ICAgCQlnb3RvIHVubWFwX3Nn
Owo+IEBAIC01MzUsNyArNTM1LDcgQEAga2ZkX21lbV9kbWFtYXBfZG1hYnVmKHN0cnVjdCBrZmRf
bWVtX2F0dGFjaG1lbnQgKmF0dGFjaG1lbnQpCj4gICAJc3RydWN0IHR0bV9vcGVyYXRpb25fY3R4
IGN0eCA9IHsuaW50ZXJydXB0aWJsZSA9IHRydWV9Owo+ICAgCXN0cnVjdCBhbWRncHVfYm8gKmJv
ID0gYXR0YWNobWVudC0+Ym9fdmEtPmJhc2UuYm87Cj4gICAKPiAtCWFtZGdwdV9ib19wbGFjZW1l
bnRfZnJvbV9kb21haW4oYm8sIEFNREdQVV9HRU1fRE9NQUlOX0dUVCk7Cj4gKwlhbWRncHVfYm9f
cGxhY2VtZW50X2Zyb21fZG9tYWluKGJvLCBBTURHUFVfR0VNX0RPTUFJTl9QUkVFTVBUKTsKPiAg
IAlyZXR1cm4gdHRtX2JvX3ZhbGlkYXRlKCZiby0+dGJvLCAmYm8tPnBsYWNlbWVudCwgJmN0eCk7
Cj4gICB9Cj4gICAKPiBAQCAtMTQwOCw3ICsxNDA4LDcgQEAgaW50IGFtZGdwdV9hbWRrZmRfZ3B1
dm1fYWxsb2NfbWVtb3J5X29mX2dwdSgKPiAgIAkJZG9tYWluID0gYWxsb2NfZG9tYWluID0gQU1E
R1BVX0dFTV9ET01BSU5fR1RUOwo+ICAgCQlhbGxvY19mbGFncyA9IDA7Cj4gICAJfSBlbHNlIGlm
IChmbGFncyAmIEtGRF9JT0NfQUxMT0NfTUVNX0ZMQUdTX1VTRVJQVFIpIHsKPiAtCQlkb21haW4g
PSBBTURHUFVfR0VNX0RPTUFJTl9HVFQ7Cj4gKwkJZG9tYWluID0gQU1ER1BVX0dFTV9ET01BSU5f
UFJFRU1QVDsKPiAgIAkJYWxsb2NfZG9tYWluID0gQU1ER1BVX0dFTV9ET01BSU5fQ1BVOwo+ICAg
CQlhbGxvY19mbGFncyA9IDA7Cj4gICAJCWlmICghb2Zmc2V0IHx8ICEqb2Zmc2V0KQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
