Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365CCC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 13:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E9B6124B
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 13:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E9B6124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76B986E529;
	Fri, 16 Apr 2021 13:50:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E60BD6E529
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 13:50:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6Rn3SCeVMx2pV5V8HxDgvi34xAXFi7tM+UrBg0UhDkhtfFdzgYb6PdzxplrPtwIpjHuyxz/ZW2RXA6GlqCflHlO6gIBleV0hEHZT12gvXw2epsozlO7HzkjgjC5gKAbCJLTm9sqqJYfU68Yxo/3CIB2rU4pXxQT6C5heuGp0R5aNJ0bBgEK8mm5MXvvlOvH0Ojwl08sxDVhf0IBaTGrfwcvk4NbroX7xdlIPkZ+Vl398dC1UYa9qm9i/L6RjvXDzCDw553QyQ3UDKd0dcwbiX6pjiuWuyEKmBv+SNVcUgEzc7OiLLr+NKEjdsXJRE0Qt9z4vZmfUNtqe/fCtr1tEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTS35ZIoUKUMccZdUrE3BAQLp2CwdKbt7H96NhM8gz4=;
 b=M/JCcaobqNLeTXkgWF9OjIp/jAFYBxNIbQStprQFvQa9leCeGjRQAp6O5/F5O281PsquF2X2Egt8cTwNOMvcSXMPuxLdS98KV32DNnefNAoNLQzXL91svMwpN1GCNiHMn+DV61ZmK2mUwWLWKh82wq+Pu7U3+BqXOXCP5e4gA+UkXmy3tJ/MPjrEY+TSczkcMSQ4fkTzHux3X7diwesnrKun6CMvTNfo9ZNnj3h5nQln+3wp5cdkEGMfjBQdF1RggKyI5gyvJ3OFBVSZzjg84EgfpZg+vnK6q9eWIgC106VHZI771w5ZcGkzYxBHlF3OxxFvauhpvhIjXcR9oGBaCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTS35ZIoUKUMccZdUrE3BAQLp2CwdKbt7H96NhM8gz4=;
 b=nWeC6D+fX/X1A1jIJC+icdro0XVr7D8Mfi34zzzSNRfBub6ifKma6wmRcSfWWsEdrwNop4/c+1dadaclorENFAIIhMbkyv1N8WEDxCPXvx9Y15NDs2/ZR6RdFSLSSOUf8vEBnzGgelkNEn2X4YgFn1yRkzLckTVab0iMXFtA+Nc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1830.namprd12.prod.outlook.com (2603:10b6:903:127::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 13:50:08 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 13:50:08 +0000
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Roy Sun <Roy.Sun@amd.com>, amd-gfx@lists.freedesktop.org,
 Nirmoy Das <nirmoy.das@amd.com>
References: <20210416050411.29220-1-Roy.Sun@amd.com>
 <97a6853d-5c4e-4422-d812-7a4aab0cb500@gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <e6131e23-2dce-3190-ee63-4a13663cc1f5@amd.com>
Date: Fri, 16 Apr 2021 15:50:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <97a6853d-5c4e-4422-d812-7a4aab0cb500@gmail.com>
Content-Language: en-US
X-Originating-IP: [217.86.110.98]
X-ClientProxiedBy: FR3P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::13) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.110.98) by
 FR3P281CA0042.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.6 via Frontend Transport; Fri, 16 Apr 2021 13:50:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6198e329-0244-4f29-d2fb-08d900de8bcf
X-MS-TrafficTypeDiagnostic: CY4PR12MB1830:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1830F669C2573F21A58556FA8B4C9@CY4PR12MB1830.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PORO53R1WdSGajUe31gMICgPDSgMlAgP5cs/N0TCl6MrfotjQDfV96JX1Q0ZQw971h1x+c2c28Z0HniSxWGXwNxB3Jsh0hqRpznex/HMtra4Frmq+fv2tLr3oMgq8WeBOjRKXP3Yds9A5PJCM1kH6CDIPeRn/uPS5l/uN5WPzTvmfGFripy3zkPBUUOx3Q6hCtBOEchdo/5ewRuUupIW9DUnPzCZLItjFF/p2rUS+/akrfRiufCNt6TvroEmzcWP1WmOPoP4hUsTaP4vYtaCKptZSlkp+SGV19RQl1eX04MiyrhHnRNIUkTU3cCUg3ys85L3i739QQ/H6LSyPo8E66D4mez7lsBVAohU1WKhUz26PUhYSwwN5OvEIAxFIfACAdFa9kXyp7fI1uKWz4xselOfN2c/F5DhPW/4T7TwaP/Zo9EDNIFkkuZKJw9yp+MiH/Ufulhm2xuX9WEYAY7e3b984BIf0azaoHX3a3cSkn9ucCKKhC1laZuGwuilTvdQn6COi5DQHJSYnpzNys+Z1hzPLi03xRO9NVBzttc55Hwey4NPfXXvTRvqErMcfv+092Pix50GO+o2fMb8J6t4vVcgKWDYZKCaTQJhqz9FcMlzlLAPmBTOIWc36Puqp0T+XFuOWJfVDUg1w5R1DLmB8l3nbhF9/UtoAMU/mWy1444ZhZISkFdF6Sq0BeSnzbOuGRGHstI015HuDW/DAOJJoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(8676002)(31686004)(6636002)(26005)(2906002)(52116002)(66574015)(66476007)(38350700002)(186003)(8936002)(110136005)(16576012)(16526019)(316002)(6486002)(4326008)(66946007)(38100700002)(36756003)(66556008)(83380400001)(53546011)(956004)(6666004)(2616005)(5660300002)(31696002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Ulc4OE9EYVNuNmYvTWNJNnM5Z3VBaWluUW45a0FVMDhWYWhwRnBhZE5KWWFR?=
 =?utf-8?B?V2VSUjJNYjFwVXV2cDk4UzBLTnY1eTFLNmhSRlZmbFFQVWJ1TFY4SmV0RTZ1?=
 =?utf-8?B?Rlg5ZVArbGNKMllwdjdNVVU1WjJYT1AweVFHZDQwSEQ4L2ZCR3c5bkRDc0pG?=
 =?utf-8?B?MUJWcVVPVWl3TUJuM0JmR0V5anQ1TFgwcjU0SlJJTjZvVjRKTUFKUE1LUDlt?=
 =?utf-8?B?Z2J2MlNrRnoyR3Y1NCtwWFlESjJ3ZThsS2IwSExkLzBGTjM1ZE8vYnoxNmhk?=
 =?utf-8?B?cDNlT3gzYkNSY2dKR0QzWE1JcFJDNXpjTGJYcWxGRDVhSWhRL0VFUHZjOThP?=
 =?utf-8?B?YWdEazQzK3hzNndtaGs0K3ZhMlZFWGh5WXhMemhQWDJOY0VUajdrOXBIQll4?=
 =?utf-8?B?dHR5U3pUNHZJNENtNkdwVVV2ODdGRWtIQWlFZHVGQ2ZuUk81Z2MzanRvR3NM?=
 =?utf-8?B?UzVrYzhlZ1pJUWppei9FeUM2a0dpQ1VFYVp5S2JGWUdHNys5bm9SMzlTOVBu?=
 =?utf-8?B?WVVMRit4c3JQZUNabzNISUNuMERBQnF3TmxYbTJ2QzdEVVA3ekJhd3RSblZI?=
 =?utf-8?B?NVFyYnhjZW5Kb2dCZEtMcWpiM3VDcXpvb2ZLTTd0SU1wcVNYVmRxT1ovQTg5?=
 =?utf-8?B?SGU5akdqNHdocXZ5SVNXQzYxRklHd1JrMEVCRlJ0YVZrVFVUYkRuRlZvZ0hS?=
 =?utf-8?B?Q0toenVsVUJXV2VtMWluK0g5UGlsOGlsTGp4TnhPZTFMcTdPSGR3WGhzSGxt?=
 =?utf-8?B?Ujk2YTlYOG9FWXFKZUxBbEhWM085bGlpc3ovZmxZMGZwNUw0eTE2aGpIdlhz?=
 =?utf-8?B?cUdzUGxLZjVzbm1RVXgrYUdFaVNkS0d4REtocFM3U2VoL20vOU9yb1AxMmpx?=
 =?utf-8?B?YnhCNTRMTUNUb3hpZXZUdXNGUkNRMTFVdmJSUHVEaG4zWWoyb2lTWTBiOFMy?=
 =?utf-8?B?K2QxU0VWU1lVZE1CL0Z3cUYyQVNjdUh6cHJNMW0vM0hYWVdSMlN3cmZaUlg3?=
 =?utf-8?B?Skc1K3ozL0hWMUQxYjlIQmpiMXIyc2oyUUJORlM3SU85UUhhb1RRay80ZWJL?=
 =?utf-8?B?aDlXL25UZU9nUmVrblFpaEVvN2pwTnJXS09XRkpNanM5Q3FRbDBFS2dadVdL?=
 =?utf-8?B?dEtCTFVPSjNZRi9LMzdKVUNJb2dKamZIUVRpeFZJa1dqSWdqUzNYbDRXQUp0?=
 =?utf-8?B?MXVOWko2RDJVNXMzZEhVZ2pCeFRuVk40SjRaV0k1MENMMlhNV1VIVzdGZmpE?=
 =?utf-8?B?a0tQUmJaWEh5SDB6bW8vclNGQi9TdEppL28zMVZSTDFocDRuUmt1QXJZdysy?=
 =?utf-8?B?clhSQ3drdnRLd0RZNkdTeE4xS0diN3prV2Y0VDQ4WkdDZ0FJaHR6NXBaK0xJ?=
 =?utf-8?B?bk9zbUZHNk82M2FjMlpRZzZjcERYTTJuWi9ybmRMZkczazFVUnI2SWFrU05m?=
 =?utf-8?B?dkoraXVFYUhwcmtFN21Tc0FoSVNXOXlCQkxaZG42MjBycG5XTGdHNElJR3kw?=
 =?utf-8?B?MUtnOVNUZWczYVF5YjhLRTF0ZHdiNWNFV1hIY2NsK1pkR051bFNQeGxqSENZ?=
 =?utf-8?B?WmtYbnZTMXNMaXhkU2ZUYTM0ZWFHZzJDN3EyVnJQcDlyOFZiR2JQTjRIWXRY?=
 =?utf-8?B?OW9uWjVjVncxYjNsaElRV290OU55L2NTY2FONUJ6c3RsR1kzZ0d6aDlCVEZx?=
 =?utf-8?B?MkRZbkFwZGcvUjF3aVdRQ0p3YjlKRDhiWFR0OUJTY1hXUjFncklmVk5YUmZ6?=
 =?utf-8?Q?wBvQzLEXTtJjL7hXF7kqP5u9BPlgiMWcM+5pNU4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6198e329-0244-4f29-d2fb-08d900de8bcf
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 13:50:08.0327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzDMv7GL65zpskYgsCgJi8Q68YnK3GOMw22KZd21kClJ1OhQnpjZKCbqsaw+fDfCtqLuUo17khk8WTEZnctKQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1830
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
Cc: David M Nieto <david.nieto@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDQvMTYvMjEgMToyNiBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAxNi4wNC4y
MSB1bSAwNzowNCBzY2hyaWViIFJveSBTdW46Cj4+IFVwZGF0ZSB0aGUgdGltZXN0YW1wIG9mIHNj
aGVkdWxlZCBmZW5jZSBvbiBIVwo+PiBjb21wbGV0aW9uIG9mIHRoZSBwcmV2aW91cyBmZW5jZXMK
Pj4KPj4gVGhpcyBhbGxvdyBtb3JlIGFjY3VyYXRlIHRyYWNraW5nIG9mIHRoZSBmZW5jZQo+PiBl
eGVjdXRpb24gaW4gSFcKPj4KPj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgTSBOaWV0byA8ZGF2aWQu
bmlldG9AYW1kLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogUm95IFN1biA8Um95LlN1bkBhbWQuY29t
Pgo+Cj4gUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4gZm9yIHRoZSBzZXJpZXMuCj4KPiBOaXJtb3kgaWYgeW91IGFyZSBpZGxlIGFnYWluIGNv
dWxkIHlvdSBnaXZlIHRoYXQgYSB0ZXN0aW5nIHJvdW5kPyBJIAo+IGRvbid0IGV4cGVjdCBpdCB0
byBjYXVzZSB0cm91YmxlLCBqdXN0IHdhbnQgdG8gZG91YmxlIGNoZWNrIHRoYXQgd2UgCj4gaGF2
ZW4ndCBmb3Jnb3R0ZW4gdGFraW5nIGEgbG9jayBvciBzdHVmZiBsaWtlIHRoYXQuCj4KCkxvb2tz
IGdvb2QsIFRlc3RlZC1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPi4gT25lIG1p
bm9yIHR5cG8gCmJlbG93OgoKCj4gVGhhbmtzLAo+IENocmlzdGlhbi4KPgo+PiAtLS0KPj4gwqAg
ZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMgfCAxMSArKysrKysrKystLQo+
PiDCoCAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pgo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMgCj4+
IGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKPj4gaW5kZXggOTJkOGRl
MjRkMGExLi40ZTVkOGQ0YWYwMTAgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zY2hl
ZHVsZXIvc2NoZWRfbWFpbi5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2No
ZWRfbWFpbi5jCj4+IEBAIC01MTUsNyArNTE1LDcgQEAgdm9pZCBkcm1fc2NoZWRfcmVzdWJtaXRf
am9icyhzdHJ1Y3QgCj4+IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCkKPj4gwqAgRVhQT1JUX1NZ
TUJPTChkcm1fc2NoZWRfcmVzdWJtaXRfam9icyk7Cj4+IMKgIMKgIC8qKgo+PiAtICogZHJtX3Nj
aGVkX3Jlc3VibWl0X2pvYnNfZXh0IC0gaGVscGVyIHRvIHJlbHVuY2ggY2VydGFpbiBudW1iZXIg
b2YgCj4+IGpvYnMgZnJvbSBtaXJyb3IgcmluZyBsaXN0Cj4+ICsgKiBkcm1fc2NoZWRfcmVzdWJt
aXRfam9ic19leHQgLSBoZWxwZXIgdG8gcmVsdW5jaCBjZXJ0YWluIG51bWJlciBvZiAKPj4gam9i
cyBmcm9tIHBlbmRpbmcgbGlzdAoKCnJlbHVuY2ggLT4gcmVsYXVuY2gKCgpSZWdhcmRzLAoKTmly
bW95CgoKPj4gwqDCoCAqCj4+IMKgwqAgKiBAc2NoZWQ6IHNjaGVkdWxlciBpbnN0YW5jZQo+PiDC
oMKgICogQG1heDogam9iIG51bWJlcnMgdG8gcmVsYXVuY2gKPj4gQEAgLTY3MSw3ICs2NzEsNyBA
QCBkcm1fc2NoZWRfc2VsZWN0X2VudGl0eShzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgCj4+ICpz
Y2hlZCkKPj4gwqAgc3RhdGljIHN0cnVjdCBkcm1fc2NoZWRfam9iICoKPj4gwqAgZHJtX3NjaGVk
X2dldF9jbGVhbnVwX2pvYihzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkKQo+PiDCoCB7
Cj4+IC3CoMKgwqAgc3RydWN0IGRybV9zY2hlZF9qb2IgKmpvYjsKPj4gK8KgwqDCoCBzdHJ1Y3Qg
ZHJtX3NjaGVkX2pvYiAqam9iLCAqbmV4dDsKPj4gwqAgwqDCoMKgwqDCoCAvKgo+PiDCoMKgwqDC
oMKgwqAgKiBEb24ndCBkZXN0cm95IGpvYnMgd2hpbGUgdGhlIHRpbWVvdXQgd29ya2VyIGlzIHJ1
bm5pbmcgT1IgCj4+IHRocmVhZAo+PiBAQCAtNjkwLDYgKzY5MCwxMyBAQCBkcm1fc2NoZWRfZ2V0
X2NsZWFudXBfam9iKHN0cnVjdCAKPj4gZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkKQo+PiDCoMKg
wqDCoMKgIGlmIChqb2IgJiYgZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKCZqb2ItPnNfZmVuY2UtPmZp
bmlzaGVkKSkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLyogcmVtb3ZlIGpvYiBmcm9tIHBlbmRp
bmdfbGlzdCAqLwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgbGlzdF9kZWxfaW5pdCgmam9iLT5saXN0
KTsKPj4gK8KgwqDCoMKgwqDCoMKgIC8qIGFjY291bnQgZm9yIHRoZSBuZXh0IGZlbmNlIGluIHRo
ZSBxdWV1ZSAqLwo+PiArwqDCoMKgwqDCoMKgwqAgbmV4dCA9IGxpc3RfZmlyc3RfZW50cnlfb3Jf
bnVsbCgmc2NoZWQtPnBlbmRpbmdfbGlzdCwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzdHJ1Y3QgZHJtX3NjaGVkX2pvYiwgbGlzdCk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAo
bmV4dCkgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZXh0LT5zX2ZlbmNlLT5zY2hlZHVs
ZWQudGltZXN0YW1wID0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBqb2ItPnNf
ZmVuY2UtPmZpbmlzaGVkLnRpbWVzdGFtcDsKPj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4gwqDCoMKg
wqDCoCB9IGVsc2Ugewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgam9iID0gTlVMTDsKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIC8qIHF1ZXVlIHRpbWVvdXQgZm9yIG5leHQgam9iICovCj4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
