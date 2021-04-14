Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44548C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 15:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC8561158
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 15:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC8561158
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20AE66E957;
	Wed, 14 Apr 2021 15:58:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B16626E957
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 15:58:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnwOl6Hn52d/U+MT3Lgnui2R0cnYtZH/UEbipesLT2D+VM/xt36wj0QKniDOfYyg0A8DEBgc6GCVSLEXztvap/b+3gZMr7frb/Og2EaddlCY0Uk/k5oxiRhZRXCvNWRNalaAQ8+AkO6I6mBcx6btzahqFzAMdO+i2XQqnwU6CBWiTMzqKV87VO6In0r5OOgSE/R3tfpWOkUB7kde5vtVRJFmaPVIh7B/JzWWG1vAASKvNVFSbnPW1lPh8ayNKQVowxxbcwuYq9jyK18pm1pao58iTYUDj9P2f+sdyHZhIW2bnEbeLOY8ecs5XV3Iin86SaOcojoDes8RRNtXBs6xNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyzYaz/8ycbzIwRRFx92BaLK4qVJweU8i894CQzl+pA=;
 b=OBYw8LB42bi62i17eAn58l7v2ODTN9oE07wuCLfwaAAZioWMEtCqWWIdlYYTb49xYD8+Zojio0NmRQPHGikuVgzeFP9AG3dRSnYqqBmybBnlBeMELnCCioMWbURxaYUL4oOdPpwaJfK2hdulO4QWK19cp2PhKOysK61roB53UC1BqeLKL93Wny5yYtqU1v4/bxUL42RuKa3inxMNbqfjSTH04k8SMDqWEZFdAetOzuwNi3e0doK2y90FMaVqOT7zKS7EGoTiqxCTG2uTCJf1nfZDSFBy9FgFImCNIA1MRcWW0fdX7IOPCFr027FlZfj0Jm8zmVxWloAr3bwhfxyrAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyzYaz/8ycbzIwRRFx92BaLK4qVJweU8i894CQzl+pA=;
 b=Lot2dUM5dAa6Ekw1lkbExUSIUx4l0krjkUjF58MQjEJoVdLo+s7j6rZFlDP8ndjGEJ9tc9p30i6WbMeWcTBdXeh+01CDMCSVhSfCKbDGbzpTyajvuNiJJlYUBW01laEzGsUwspsjCo89dXfAVIFhSdBhx1yNA/ntaaty8UKsJPk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB3792.namprd12.prod.outlook.com (2603:10b6:208:16e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 15:58:37 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Wed, 14 Apr 2021
 15:58:37 +0000
Subject: Re: [PATCH] drm/amdgpu: Add double-sscanf but invert
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210414152126.24685-1-luben.tuikov@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <cef16c21-0399-aa94-72bc-ef88089e3bb3@amd.com>
Date: Wed, 14 Apr 2021 11:58:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210414152126.24685-1-luben.tuikov@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.180.233]
X-ClientProxiedBy: YT1PR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::9) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.180.233) by
 YT1PR01CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Wed, 14 Apr 2021 15:58:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40a12b42-cb13-4a74-2139-08d8ff5e2a47
X-MS-TrafficTypeDiagnostic: MN2PR12MB3792:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3792249B841536AE79B2C4E0924E9@MN2PR12MB3792.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZEb9oya/EtUFsXPa5deSqScQACuEh+8aSRd58/Q+HX1Ef1a8qeyki2cvDeXyBBY8RTBvNHnt00WskKeh1MO0nfL8V0F/gKp4wHOKOtkucz/dBHfOJ7eFJ9Ip6AYeeUHsP7UU9rsEi2yMHtbdCh4RZ3270KZ1EA+n311g21+tOzRzaGTzgK5g6E/stlo6ohrXP0rN2088SBC7mKYK7kldPppUAVR4s161OLih/ttMqzlPq8PSr8Q0mhX2sEBweLFw6MeAEd2PxHVp9JA0paZxYizl/2P0YiR1fKTxnD6GYbQ9M/PxDtcSJ56vKY0E9FHdmFf1nwREUYNK3swVlCQLTLQMQfXPx+PSfe8H1miv7ZMnTmU5M1Ugf6w3XFD5zGgbQeZlqRtoOx1kvrFqwKgbOZ+Ph9GPDnOSu7oCKQxUZyYVWx3n7QbSPkQcvG+L58ugdy0i/w452/e9TBa3a/MpBq7Ig8lcoTJ9nCfQynqxGrfy6RFMqQus4wbdtxhzAlOELYbOsRwmvdJpPVdww6UCVm9GRSnbW7GsIU5MDIDzXlsm59gH8hCE23jRRZHNpLt4sH2I00YjHlyht6MZp5AVXWE1Md4IEHSr0bFMoKyRX3S8sBLt7k+4hIA8wrYdNiQbnOqyjmQra+1ouD88mkjUXJFGRQBNphsMkC6CtCw8v088/KiacrB3s4sb9aiQfOYf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(956004)(2616005)(2906002)(478600001)(44832011)(86362001)(16526019)(83380400001)(4326008)(186003)(31696002)(26005)(5660300002)(6486002)(66476007)(36756003)(38100700002)(66946007)(16576012)(54906003)(8676002)(316002)(66556008)(31686004)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Skt5ZzlnTXlWVmc5UlB2djBocWxoRDJSN2pFeEpGazIwUkN1YU9BOE5HOXBC?=
 =?utf-8?B?VkgyUHpmalB0Y1puRGtldzVOK2xZUzNFRm9HUGE1REJMaDVLUGNYZWhxcVFr?=
 =?utf-8?B?dVJzeUNGMW5ZZ3ltdjZLWVF4RHVXZ0J4UDd3TW9FdWtVNjlReHphN1RIaXNl?=
 =?utf-8?B?QzU5SUxQRTNVQzJuOW0xalpVVHR6ZUxWQ0J2WFpvRUNjTlBVZEtlTjFpbC9S?=
 =?utf-8?B?TDdmS0gwOWZ3V3BuNkhRNGJML3ZmNS9oWCtSQ3lNM0k5NWF6Q091ZlEyYXp6?=
 =?utf-8?B?RFpBYTdHYTNZY1ZjN2daVWNaODJhckx1My9wZmU2em1NVVY1aVBtOWFuN3lv?=
 =?utf-8?B?d29MNUR1K2FSL2J6ZUVwQ0lsNzZqWnVUWHluMFd0c1lST3cwMWdwT1FIZ0Zm?=
 =?utf-8?B?UTVEeThEQnFZSDl1eXpLeVJYOXpmTHlTTWNHUC9xZDRxek5Ta1IvZ2hlWjh6?=
 =?utf-8?B?UkIvSmw1MmhsWitiMnppYU1iZ0RxbVNNS3dUZGFMUzVDb05vUHR2SFpWdE5i?=
 =?utf-8?B?VTZWa1NseURBb3QyTndXZnlqQ25mNW5WOWhUYlRJeWtBLzBNZnNDVGtuZXBh?=
 =?utf-8?B?SUd3cjVKNlpWeEREMmthcnp5U0xDa1A2VDljdjZPWk9ES0dLeEpHNW9RcnZV?=
 =?utf-8?B?bVlwSUF1cDVYSXNnQkhrajZQUS9CRmlWQ1IyR0wyZHFUMG1aYXNUMEJ0QkNP?=
 =?utf-8?B?Wlo4bUtERFVVZENXaUQzaXNhM1owRG1KZm96Z3NYR1F5YzdEVXIwSVZUQWxx?=
 =?utf-8?B?MTBwZC9CVmg5dnd0RktoSlF6T1ZyT1RaL2lSVW5XMUpvM1MyMG01U3VBekNu?=
 =?utf-8?B?SU01QXVzUCtYRDNiUVp3VkFjQzRkM0Ixc1pQUXFGeGg4OEN6ZGpZdmljc2xX?=
 =?utf-8?B?bXRQRlJjaEZ4U21jNy9XczR0SUJtcDNCb3VadHFwZGV1WXZMbE9FYWxCM20z?=
 =?utf-8?B?dnlxN0FLMVY5Mm05MENUMkFDVVdhcVZtYzhrMkc1c29mdisvWTVDUjZSZjhp?=
 =?utf-8?B?aFoxdXBOWWg1Zm9YckRKbmRqRm15NEJxVjZMMERUU1FPL3Q5WUpNN2RNSFZq?=
 =?utf-8?B?MkJ0RVVMZnFUWDFnUVIvc1pPYnhEMDBMK25ReW8wbXZnRGEwbGx3N2l1d0Vy?=
 =?utf-8?B?aElYeGxuSGp4WnN4emgrZWgwNlVoa0Q5Y1g5djlCKzNidldPaFptZEhqaGo3?=
 =?utf-8?B?M1p1SnlkMG9xMDcyMmJvY1EwYk9iQXF1QWE5amxOeHhZMzZyNDJtWXhyM25i?=
 =?utf-8?B?K1lOZkJzTXF4M3czUXpLSS95TkpUd3Jlc3lNZEVTN2tWb2tEV3lKbkhjTk1i?=
 =?utf-8?B?MjZrd0ljWUxYa29HVG85SktJeVBqeEx5cTBqNU1lUGllQ3p1b1l0WmZnRnpM?=
 =?utf-8?B?dy8vb2Q5VFA5aTk3Zkt4emxucWZuWEgyUUZoRzFISzhIWkZFbFVYR2JSMHdh?=
 =?utf-8?B?Rm9RT2NTYnVqdEh2b05ucWJDd3c2bWczdnJucEZ4M2RrNzJKMW9FMUlBdTQz?=
 =?utf-8?B?L0ExR3Qvb0RTLzJwc2FOazA1M1U5VXJINmRBbkY4bFRYOGgzWjh3Wk10U3Nv?=
 =?utf-8?B?WStvMTM4a21FOXJYcUxjdGVSV1FVRGFlTWFRUWZXa3VvQ1BOOWVlTE5yak9t?=
 =?utf-8?B?ZTlvbG9qcksrRWxVeFRrNVE3STRCRXhodzgySmVUZEYrQ0luM2NaVWNrcG8x?=
 =?utf-8?B?dmlTbmU1elppY0FnU2NGRjFqcFF3VEc4UWoyYkptUTAyN0t5S2MxVGt3L3FL?=
 =?utf-8?B?OFJHRk1rNUdCTEx6VVRqMjN6OEQzYlZZVldTVEp2bGt4dVZoamhleGRsb2Mw?=
 =?utf-8?B?bnU3aVd4NnlEVWIyeWRVZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a12b42-cb13-4a74-2139-08d8ff5e2a47
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 15:58:37.5831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+yZiPtYaIqGMqkS7SSpnftgFF6kg5ijhKqDP6kD6KPCMH2CVyRAoyEb9VwNTZQG/+eHCToYhgnqK3BJ63Vk3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3792
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 John Clements <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbSB0aGUgc3NjYW5mIG1hbnBhZ2U6CgrCoMKgwqDCoMKgwqAgacKgwqDCoMKgwqAgTWF0Y2hl
c8KgIGFuIG9wdGlvbmFsbHkgc2lnbmVkIGludGVnZXI7IHRoZSBuZXh0IHBvaW50ZXIKbXVzdCBi
ZQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhIHBvaW50ZXIgdG8gaW50LsKgIFRoZSBpbnRl
Z2VyIGlzIHJlYWQgaW4gYmFzZSAxNiBpZiBpdMKgCmJlZ2lucwrCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB3aXRowqAgMHjCoCBvcsKgIDBYLCBpbiBiYXNlIDggaWYgaXQgYmVnaW5zIHdpdGgg
MCwgYW5kIGluCmJhc2UgMTAKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3RoZXJ3aXNlLsKg
IE9ubHkgY2hhcmFjdGVycyB0aGF0IGNvcnJlc3BvbmTCoCB0b8KgIHRoZcKgCmJhc2XCoCBhcmUK
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdXNlZC4KClNvIGEgc2luZ2xlIHNzY2FuZigiJSpz
ICVpIiwgLi4uKSB3b3VsZCB0byB0aGUgam9iLiBUaGUgb25seSBwcm9ibGVtIGlzCnRoYXQgYWNj
ZXB0cyBzaWduZWQgaW50ZWdlcnMsIG5vdCB1bnNpZ25lZC4gSSdtIG5vdCBzdXJlIGlmIHRoYXQn
cyBhCnByb2JsZW0gaW4gdGhpcyB1c2UgY2FzZS4KClJlZ2FyZHMsCsKgIEZlbGl4CgpBbSAyMDIx
LTA0LTE0IHVtIDExOjIxIGEubS4gc2NocmllYiBMdWJlbiBUdWlrb3Y6Cj4gQWRkIGJhY2sgdGhl
IGRvdWJsZS1zc2NhbmYgc28gdGhhdCBib3RoIGRlY2ltYWwKPiBhbmQgaGV4YWRlY2ltYWwgdmFs
dWVzIGNvdWxkIGJlIHJlYWQgaW4sIGJ1dCB0aGlzCj4gdGltZSBpbnZlcnQgdGhlIHNjYW4gc28g
dGhhdCBoZXhhZGVjaW1hbCBmb3JtYXQKPiB3aXRoIGEgbGVhZGluZyAweCBpcyB0cmllZCBmaXJz
dCwgYW5kIGlmIHRoYXQKPiBmYWlscywgdGhlbiB0cnkgZGVjaW1hbCBmb3JtYXQuCj4KPiBBbHNv
IHVzZSBhIGxvZ2ljYWwtQU5EIGluc3RlYWQgb2YgbmVzdGluZyBkb3VibGUKPiBpZi1jb25kaXRp
b25hbC4KPgo+IFNlZSBjb21taXQgImRybS9hbWRncHU6IEZpeCBhIGJ1ZyBmb3IgaW5wdXQgd2l0
aCBkb3VibGUgc3NjYW5mIgo+Cj4gQ2M6IEFsZXhhbmRlciBEZXVjaGVyIDxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPgo+IENjOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5jb20+
Cj4gQ2M6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KPiBTaWduZWQtb2Zm
LWJ5OiBMdWJlbiBUdWlrb3YgPGx1YmVuLnR1aWtvdkBhbWQuY29tPgo+IC0tLQo+ICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgfCA3ICsrKysrLS0KPiAgMSBmaWxlIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKPiBpbmRleCA0NGRmYjM2MTNlMzcuLjM4YTY5MWEzYjYw
MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKPiBAQCAtMjI5
LDcgKzIyOSw4IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Jhc19kZWJ1Z2ZzX2N0cmxfcGFyc2VfZGF0
YShzdHJ1Y3QgZmlsZSAqZiwKPiAgCj4gIAlpZiAob3AgIT0gLTEpIHsKPiAgCQlpZiAob3AgPT0g
Mykgewo+IC0JCQlpZiAoc3NjYW5mKHN0ciwgIiUqcyAlbGx4IiwgJmFkZHJlc3MpICE9IDEpCj4g
KwkJCWlmIChzc2NhbmYoc3RyLCAiJSpzIDB4JWxseCIsICZhZGRyZXNzKSAhPSAxICYmCj4gKwkJ
CSAgICBzc2NhbmYoc3RyLCAiJSpzICVsbHUiLCAmYWRkcmVzcykgIT0gMSkKPiAgCQkJCXJldHVy
biAtRUlOVkFMOwo+ICAKPiAgCQkJZGF0YS0+b3AgPSBvcDsKPiBAQCAtMjUzLDcgKzI1NCw5IEBA
IHN0YXRpYyBpbnQgYW1kZ3B1X3Jhc19kZWJ1Z2ZzX2N0cmxfcGFyc2VfZGF0YShzdHJ1Y3QgZmls
ZSAqZiwKPiAgCQlkYXRhLT5vcCA9IG9wOwo+ICAKPiAgCQlpZiAob3AgPT0gMikgewo+IC0JCQlp
ZiAoc3NjYW5mKHN0ciwgIiUqcyAlKnMgJSpzICV4ICVsbHggJWxseCIsCj4gKwkJCWlmIChzc2Nh
bmYoc3RyLCAiJSpzICUqcyAlKnMgMHgleCAweCVsbHggMHglbGx4IiwKPiArCQkJCSAgICZzdWJf
YmxvY2ssICZhZGRyZXNzLCAmdmFsdWUpICE9IDMgJiYKPiArCQkJICAgIHNzY2FuZihzdHIsICIl
KnMgJSpzICUqcyAldSAlbGx1ICVsbHUiLAo+ICAJCQkJICAgJnN1Yl9ibG9jaywgJmFkZHJlc3Ms
ICZ2YWx1ZSkgIT0gMykKPiAgCQkJCXJldHVybiAtRUlOVkFMOwo+ICAJCQlkYXRhLT5oZWFkLnN1
Yl9ibG9ja19pbmRleCA9IHN1Yl9ibG9jazsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
