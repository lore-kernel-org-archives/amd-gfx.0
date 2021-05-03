Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDD1C433B4
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 19:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B0886135F
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 19:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0886135F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEC5E6EA26;
	Mon,  3 May 2021 19:27:29 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2083.outbound.protection.outlook.com [40.107.102.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED4A06EA26
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 May 2021 19:27:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXiljgyrtk1UPRkLyxuYWVRLHvLjG+1wVa3bSViLNCiikws50ZKY7ifd/fpP1r6OYQ5SYCUowOUUcAmBCp/C2UZ34pHVwBXtqDuKYPN42Brf7G4fDW3TH18DOspndLGZ7nJNqKPhrT02geQc69BqWsTxeHb4vKRwTkG64MugzXHRHlhRAzn2JGibhrbtiqKRENpRtdkLGka1htzZbTjp+RjidIV2nfb4psvoR0w+MB5jvLk/IJjDixo093SjdsPeNwolNaSV72lM6ejF2r/MhZCjlZEVJcofRG4xSH4QusQTZA/uabimhZqYvoYqRQ1mmzI54tpL8aDERHsKBn6xfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvzTZRqCC9RKXYoWReWx91TzCH/W89Ivm2YLjH0JNhI=;
 b=B7qg96k9lnBQ2QCnA1ZxxOWLZHbjIgDYgn0d2B83xp5kEUlWnTh3CRSb/OQ12VJqDItwXj67PbdTxizvx1/4RhGwiIUZVJU5w30XgcS6ukUCALUokFgLdKye20+L6eerfXszVJH11h/EamUztIM/Y2VNyfcpcu/4oCxsRM4ofW8hUjpNcEVjjGKjhcwngx3bHsyDOtN/2SCZwAv8xKLVHxdu+8ZxCPw80wbm8eZBXUdm3SQz9yYioSruVjY+ZuSjj8COVvEyRZaLsCXehkdnoCr8JG7Sr8VqZh2KEc3hqTFdHlMfUJIZ4yNcWApBo4ObBd8r8QZ9H5GpBRgcOEMJUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvzTZRqCC9RKXYoWReWx91TzCH/W89Ivm2YLjH0JNhI=;
 b=hwj8zTw7HIAw/RoNSmM4GXJPcGH3ZM6EA9Ofw9ugtZM0ixVABlNgU/mWiOxOLsJINmfCytEkceRr43Z4S51UTKvfi6OyaQDi1MAlFumEDvEeOeLkf2EAwag+2FqcDZubUXRXc4R17A1n2BKhfMVmmaCKXIV8MuEM1wZDfamNu6k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22)
 by DM5PR1201MB0140.namprd12.prod.outlook.com (2603:10b6:4:57::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Mon, 3 May
 2021 19:27:24 +0000
Received: from DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510]) by DM5PR1201MB0234.namprd12.prod.outlook.com
 ([fe80::a996:2224:603:1510%10]) with mapi id 15.20.4087.041; Mon, 3 May 2021
 19:27:24 +0000
Subject: Re: [PATCH] drm/amdkfd: add ACPI SRAT parsing for topology
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210503144753.9795-1-jinhuieric.huang@amd.com>
 <d8cecb2d-438c-f503-022a-b1b8f7ce0c06@amd.com>
From: Eric Huang <jinhuieric.huang@amd.com>
Message-ID: <db46f476-bed4-15ef-f972-a5683844d8da@amd.com>
Date: Mon, 3 May 2021 15:27:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <d8cecb2d-438c-f503-022a-b1b8f7ce0c06@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:9880:2048:122:150d:2265:cbad:a5fb]
X-ClientProxiedBy: YTOPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::18) To DM5PR1201MB0234.namprd12.prod.outlook.com
 (2603:10b6:4:56::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2048:122:150d:2265:cbad:a5fb]
 (2607:9880:2048:122:150d:2265:cbad:a5fb) by
 YTOPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.37 via Frontend
 Transport; Mon, 3 May 2021 19:27:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59e13d42-53aa-4de3-369e-08d90e697adf
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0140:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0140E28E09F8FE1767583B8A825B9@DM5PR1201MB0140.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LAK9Cb8MR183jnZiyDNqkTd3eORv8WrojRTZUw3QEmi+gUXStIUV1Vj8B3oggPU9foorTxWf6JlOYcShshA+zgQqIgsgDWJLfPTlmX4URy6cpPEso1WLrg+fbaPSdwrkuG7oE06Z7dF2ZtiB0CegRDoBNU314JeU+26vIAGWQYtMS6iIj5NXH9msz53TlVPMz03jqnuV321Z4YAlepogw6vMRBB8SlsgivBwD96AFpSZj7CiG9l/Li/XMSEzv2b5uFB4oyNwaXt94l4TF8orhTsh7DvVsrgQ47trIqyfUsYpTFM6LSnO3RFmpXtJ4Y9gp5RuG0J3o/bz0UsagZZyc/WhakkTzap5IG82xx0nUvg3RifTPsvyb4mNTiugLFbkc8muc0qf+AVgPobj1+EiFi40k+8XohIf+sdka+xaWCXf0+WT5hiKqX9b/i617cEpQc0PfFltX8953qe5wDfCDw0gywqftv0ZCA4QdVq6+Sogn8VrUGunxmghTBS55IK+U4LoBgsZZwBoHuxSQ07Ltpj8TjjR147b0cNUFmYOdQItttOD7Ec7RMM/wsx4sF8ax6nLHUY8XEV2TSgM9y0zKo92qwXJJgnasma6DXDTNZJdtxUXSM2/ZBTy+4eTym6kK1x4wBHn1FGdUTtSK0UFdB4j1sCQIpcxacG9hFtFbvlUWkNaxrDYJY2Yg4C3TgLzrsrNYerwWYJ7LJZVRTMLbKqKZUkB9kXZkqgBTBghtysNFJ0MB6Z6H0ZcgVJQcYgTNPZqG6z5OvgWKJpZRKKNVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0234.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(966005)(86362001)(316002)(66556008)(66476007)(5660300002)(31696002)(38100700002)(66946007)(36756003)(31686004)(83380400001)(186003)(8936002)(8676002)(16526019)(478600001)(2906002)(6486002)(2616005)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d05xNy91cEV4Y1NwR3lpbUkzV04vRkh1U2dHdkRocWJ6QzBXY2p5RVE3ajhh?=
 =?utf-8?B?OU91OWV2NksvK25ycDhQcXZERkl5REt1WXFBMkdpZVBYcmhLNEo2KzlXVHN0?=
 =?utf-8?B?MUhhWVhVMk5IUXhOVkYvNVhhdDUxckMvWSs5cDgvcmZWK1RmeGc2cHNiK2Y5?=
 =?utf-8?B?eUhUNnFlbDBKb3BkMU9jK3J6NWJHV2FJcW5Id1didEpqMGJETHVuLys3akh5?=
 =?utf-8?B?dlNuem1lQ3dOUDZ3TUJEbGxaeFJEV21vdFlNd1VySlJJcHJRbnBDTVVyK2Y1?=
 =?utf-8?B?L0tTRkI2V0Q3NkU0bGhRQWxRK3FKVU8zSU9ibkhydGpENjU5UlBla0tGdmpH?=
 =?utf-8?B?NFYvSFkwempUbVEvVzlqY24wTEY1K2kxVlpqOUdmbjdOWFRpQWhFVk1VSUN5?=
 =?utf-8?B?WU9nWTVSSWJyd2hOb2UrRkh3bDdKODZrYzBqMUo0cGsxb1FpeDA2YnB6TG9Z?=
 =?utf-8?B?cmJqdHk5QmI3N01rYmkxY29Bb2c0OEtWMW1QLy9mWUJIQ1g3NWtpaW1PYXp3?=
 =?utf-8?B?dkNiZ3FYV21vY3h0MUFCcmZFdjNIN3d3NVlpMHE2ZkxjVlNsZnhRVjh0ckIy?=
 =?utf-8?B?L2I2Yy94ck44cmJySzVnQXlnYmpLUlNlQkdvTFdBdGlrTWJzWUg1L3BuOEg1?=
 =?utf-8?B?Q2tXMW16My9SRm1LbnIycjcyODZHSmdYZW0wMFFDU0RESHJsemcvTG1nMjB0?=
 =?utf-8?B?WG5BaWJGSjUyR3lkLzdNZG4vQTJ3WWhQWXUxcnd1OUUvaUNVb1cxZ0xSMWxB?=
 =?utf-8?B?ZjZQUi81ajNuNEZQWlgyZ1UyZUFGekQrWHJ4YUlHRzFrWWlHY3AzUE84SXFW?=
 =?utf-8?B?K0dXWGFLdXRNMmVPZFlKVlg4Mncwcy9MQ0l2OWhnM1A0TXM2c2dTeVVoWkNo?=
 =?utf-8?B?dldzdFpUdVhaSUt2dTJVVitSbjBSUFpTTUFxSkdqUVlXbXBEMFJjcFdnWlVY?=
 =?utf-8?B?M20rRnFkb3RhREFodGRGNGxxV1loaWYxaXlCc1RMS1pjZ2ZlTytLNEtnTzBZ?=
 =?utf-8?B?S21pOG5Qd1QreExqT0JPa1lUYXU1MnNVN1ZrUWtsellzSTVBN0xjUTNTYzdQ?=
 =?utf-8?B?TmhNck5sbStmMjVtV1dodHFoYjJEUFMwSlMzUlFhdzBIUUt6Tys0SUtJczc2?=
 =?utf-8?B?OWtya2xXSUhvWHkxV0FZeENjWEVEU0RtU3I2SjJIR2NEQ2QwbzVtSy9WVHNF?=
 =?utf-8?B?bXVJVFdCTXdmdTY3R3FpTlVTYzR3ZDZqYS9icDRHUVhBdG9VUXU5ZDlmakxJ?=
 =?utf-8?B?d1UrbHloSnQ5WTRGcUJ4eVpjR240bm5BUVlCeS80VTVzL3hFUlFBY3hXaUt5?=
 =?utf-8?B?ck5RTE9sU0p1RjJiSFBudHFJVTBSUjNHUXczbWtQT3M0NTh6QlJmK25TQVlW?=
 =?utf-8?B?U2FLNDFTWC9EQ1E0YjVkOHlmcWYxdjJ1bHlpUmc1SnM5cVg4bTdDeThmcU9M?=
 =?utf-8?B?WmtCQUg4czVZVFhFNWVRVFlzd0w2V3lLOE1uUU5BdUtkdEJDM3hZblRONUky?=
 =?utf-8?B?YWlyZ01WL2gyWU5XSWZXbFZzTjJpSUozUXZ6dk1ZM0lmUVJWcC85RU1BNXlC?=
 =?utf-8?B?eHRoMzJpN1BlMTNJelV6ditRckd2UFVaV2lpdXQ1Rzd6OVgreGFmTEE2bXA1?=
 =?utf-8?B?QXMzM2RPWXAxL1F5c0I0NlZlTFhqUVBiOEduOHVYellkRTFtS0V6QmhsVW1j?=
 =?utf-8?B?WVBSYmp0NmwwSTY1VUNNbGsyTU9wejlzYThuQ0E4YjBSaVlKblRvdk93QXd5?=
 =?utf-8?B?c0crcll3NmEyQWcwWnpPZHEwVjk1UG9VVjNuQUdLSnRrYVluRjUwVUJrYjRz?=
 =?utf-8?B?V25QdFRMckNLNHMyTUNuWnZmd05CTndvNDIwY3lqQkRUUzlmZW1LeXRaUG40?=
 =?utf-8?Q?y3Or5K3ikksZN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e13d42-53aa-4de3-369e-08d90e697adf
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0234.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 19:27:24.6958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOnrxJlBt+LtvoWwoiI5waaxOwWRP67KYHR05h+ifHyhWWLarI52mGYs8gWMgQJXidl3Uc37K0EIWN7atKpm/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0140
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

CgpPbiAyMDIxLTA1LTAzIDM6MTMgcC5tLiwgRmVsaXggS3VlaGxpbmcgd3JvdGU6Cj4gQW0gMjAy
MS0wNS0wMyB1bSAxMDo0NyBhLm0uIHNjaHJpZWIgRXJpYyBIdWFuZzoKPj4gSW4gTlBTNCBCSU9T
IHdlIG5lZWQgdG8gZmluZCB0aGUgY2xvc2VzdCBudW1hIG5vZGUgd2hlbiBjcmVhdGluZwo+PiB0
b3BvbG9neSBpbyBsaW5rIGJldHdlZW4gY3B1IGFuZCBncHUsIGlmIFBDSSBkcml2ZXIgZG9lc24n
dCBzZXQKPj4gaXQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgSHVhbmcgPGppbmh1aWVyaWMu
aHVhbmdAYW1kLmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2Zk
X2NyYXQuYyB8IDk1ICsrKysrKysrKysrKysrKysrKysrKysrKysrLQo+PiAgIDEgZmlsZSBjaGFu
Z2VkLCA5MyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9jcmF0LmMKPj4gaW5kZXggMzhkNDU3MTE2NzVmLi41OGM2NzM4ZGU3NzQg
MTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMKPj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYwo+PiBAQCAtMTc1OSw2
ICsxNzU5LDkxIEBAIHN0YXRpYyBpbnQga2ZkX2ZpbGxfZ3B1X21lbW9yeV9hZmZpbml0eShpbnQg
KmF2YWlsX3NpemUsCj4+ICAgCXJldHVybiAwOwo+PiAgIH0KPj4gICAKPj4gKyNpZmRlZiBDT05G
SUdfQUNQSV9OVU1BCj4+ICtzdGF0aWMgdm9pZCBrZmRfZmluZF9udW1hX25vZGVfaW5fc3JhdChz
dHJ1Y3Qga2ZkX2RldiAqa2RldikKPj4gK3sKPj4gKwlzdHJ1Y3QgYWNwaV90YWJsZV9oZWFkZXIg
KnRhYmxlX2hlYWRlciA9IE5VTEw7Cj4+ICsJc3RydWN0IGFjcGlfc3VidGFibGVfaGVhZGVyICpz
dWJfaGVhZGVyID0gTlVMTDsKPj4gKwl1bnNpZ25lZCBsb25nIHRhYmxlX2VuZCwgc3VidGFibGVf
bGVuOwo+PiArCXUzMiBwY2lfaWQgPSBwY2lfZG9tYWluX25yKGtkZXYtPnBkZXYtPmJ1cykgPDwg
MTYgfAo+PiArCQkJcGNpX2Rldl9pZChrZGV2LT5wZGV2KTsKPj4gKwl1MzIgYmRmOwo+PiArCWFj
cGlfc3RhdHVzIHN0YXR1czsKPj4gKwlzdHJ1Y3QgYWNwaV9zcmF0X2NwdV9hZmZpbml0eSAqY3B1
Owo+PiArCXN0cnVjdCBhY3BpX3NyYXRfZ2VuZXJpY19hZmZpbml0eSAqZ3B1Owo+PiArCWludCBw
eG0gPSAwLCBtYXhfcHhtID0gMDsKPj4gKwlpbnQgbnVtYV9ub2RlID0gTlVNQV9OT19OT0RFOwo+
PiArCWJvb2wgZm91bmQgPSBmYWxzZTsKPj4gKwo+PiArCS8qIEZldGNoIHRoZSBTUkFUIHRhYmxl
IGZyb20gQUNQSSAqLwo+PiArCXN0YXR1cyA9IGFjcGlfZ2V0X3RhYmxlKEFDUElfU0lHX1NSQVQs
IDAsICZ0YWJsZV9oZWFkZXIpOwo+PiArCWlmIChzdGF0dXMgPT0gQUVfTk9UX0ZPVU5EKSB7Cj4+
ICsJCXByX3dhcm4oIlNSQVQgdGFibGUgbm90IGZvdW5kXG4iKTsKPj4gKwkJcmV0dXJuOwo+PiAr
CX0gZWxzZSBpZiAoQUNQSV9GQUlMVVJFKHN0YXR1cykpIHsKPj4gKwkJY29uc3QgY2hhciAqZXJy
ID0gYWNwaV9mb3JtYXRfZXhjZXB0aW9uKHN0YXR1cyk7Cj4+ICsJCXByX2VycigiU1JBVCB0YWJs
ZSBlcnJvcjogJXNcbiIsIGVycik7Cj4+ICsJCXJldHVybjsKPj4gKwl9Cj4+ICsKPj4gKwl0YWJs
ZV9lbmQgPSAodW5zaWduZWQgbG9uZyl0YWJsZV9oZWFkZXIgKyB0YWJsZV9oZWFkZXItPmxlbmd0
aDsKPj4gKwo+PiArCS8qIFBhcnNlIGFsbCBlbnRyaWVzIGxvb2tpbmcgZm9yIGEgbWF0Y2guICov
Cj4+ICsJc3ViX2hlYWRlciA9IChzdHJ1Y3QgYWNwaV9zdWJ0YWJsZV9oZWFkZXIgKikKPj4gKwkJ
CSgodW5zaWduZWQgbG9uZyl0YWJsZV9oZWFkZXIgKwo+PiArCQkJc2l6ZW9mKHN0cnVjdCBhY3Bp
X3RhYmxlX3NyYXQpKTsKPj4gKwlzdWJ0YWJsZV9sZW4gPSBzdWJfaGVhZGVyLT5sZW5ndGg7Cj4+
ICsKPj4gKwl3aGlsZSAoKCh1bnNpZ25lZCBsb25nKXN1Yl9oZWFkZXIpICsgc3VidGFibGVfbGVu
ICA8IHRhYmxlX2VuZCkgewo+PiArCQkvKgo+PiArCQkgKiBJZiBsZW5ndGggaXMgMCwgYnJlYWsg
ZnJvbSB0aGlzIGxvb3AgdG8gYXZvaWQKPj4gKwkJICogaW5maW5pdGUgbG9vcC4KPj4gKwkJICov
Cj4+ICsJCWlmIChzdWJ0YWJsZV9sZW4gPT0gMCkgewo+PiArCQkJcHJfZXJyKCJTUkFUIGludmFs
aWQgemVybyBsZW5ndGhcbiIpOwo+PiArCQkJYnJlYWs7Cj4+ICsJCX0KPj4gKwo+PiArCQlzd2l0
Y2ggKHN1Yl9oZWFkZXItPnR5cGUpIHsKPj4gKwkJY2FzZSBBQ1BJX1NSQVRfVFlQRV9DUFVfQUZG
SU5JVFk6Cj4+ICsJCQljcHUgPSAoc3RydWN0IGFjcGlfc3JhdF9jcHVfYWZmaW5pdHkgKilzdWJf
aGVhZGVyOwo+PiArCQkJcHhtID0gKigodTMyICopY3B1LT5wcm94aW1pdHlfZG9tYWluX2hpKSA8
PCA4IHwKPj4gKwkJCQkJY3B1LT5wcm94aW1pdHlfZG9tYWluX2xvOwo+PiArCQkJaWYgKHB4bSA+
IG1heF9weG0pCj4+ICsJCQkJbWF4X3B4bSA9IHB4bTsKPj4gKwkJCWJyZWFrOwo+PiArCQljYXNl
IEFDUElfU1JBVF9UWVBFX0dFTkVSSUNfQUZGSU5JVFk6Cj4+ICsJCQlncHUgPSAoc3RydWN0IGFj
cGlfc3JhdF9nZW5lcmljX2FmZmluaXR5ICopc3ViX2hlYWRlcjsKPj4gKwkJCWJkZiA9ICooKHUx
NiAqKSgmZ3B1LT5kZXZpY2VfaGFuZGxlWzBdKSkgPDwgMTYgfAo+PiArCQkJCQkqKCh1MTYgKiko
JmdwdS0+ZGV2aWNlX2hhbmRsZVsyXSkpOwo+PiArCQkJaWYgKGJkZiA9PSBwY2lfaWQpIHsKPj4g
KwkJCQlmb3VuZCA9IHRydWU7Cj4+ICsJCQkJbnVtYV9ub2RlID0gcHhtX3RvX25vZGUoZ3B1LT5w
cm94aW1pdHlfZG9tYWluKTsKPj4gKwkJCX0KPj4gKwkJCWJyZWFrOwo+PiArCQlkZWZhdWx0Ogo+
PiArCQkJYnJlYWs7Cj4+ICsJCX0KPj4gKwo+PiArCQlpZiAoZm91bmQpCj4+ICsJCQlicmVhazsK
Pj4gKwo+PiArCQlzdWJfaGVhZGVyID0gKHN0cnVjdCBhY3BpX3N1YnRhYmxlX2hlYWRlciAqKQo+
PiArCQkJCSgodW5zaWduZWQgbG9uZylzdWJfaGVhZGVyICsgc3VidGFibGVfbGVuKTsKPj4gKwkJ
c3VidGFibGVfbGVuID0gc3ViX2hlYWRlci0+bGVuZ3RoOwo+PiArCX0KPj4gKwo+PiArCWFjcGlf
cHV0X3RhYmxlKHRhYmxlX2hlYWRlcik7Cj4+ICsKPj4gKwkvKiBXb3JrYXJvdW5kIGJhZCBjcHUt
Z3B1IGJpbmRpbmcgY2FzZSAqLwo+PiArCWlmIChmb3VuZCAmJiAobnVtYV9ub2RlIDwgMCB8fCBu
dW1hX25vZGUgPiBtYXhfcHhtKSkKPj4gKwkJbnVtYV9ub2RlID0gMDsKPj4gKwo+PiArCWlmIChu
dW1hX25vZGUgIT0gTlVNQV9OT19OT0RFKQo+PiArCQlzZXRfZGV2X25vZGUoJmtkZXYtPnBkZXYt
PmRldiwgbnVtYV9ub2RlKTsKPj4gK30KPj4gKyNlbmRpZgo+PiArCj4+ICAgLyoga2ZkX2ZpbGxf
Z3B1X2RpcmVjdF9pb19saW5rIC0gRmlsbCBpbiBkaXJlY3QgaW8gbGluayBmcm9tIEdQVQo+PiAg
ICAqIHRvIGl0cyBOVU1BIG5vZGUKPj4gICAgKglAYXZhaWxfc2l6ZTogQXZhaWxhYmxlIHNpemUg
aW4gdGhlIG1lbW9yeQo+PiBAQCAtMTgwNCwxMCArMTg4OSwxNiBAQCBzdGF0aWMgaW50IGtmZF9m
aWxsX2dwdV9kaXJlY3RfaW9fbGlua190b19jcHUoaW50ICphdmFpbF9zaXplLAo+PiAgIAl9Cj4+
ICAgCj4+ICAgCXN1Yl90eXBlX2hkci0+cHJveGltaXR5X2RvbWFpbl9mcm9tID0gcHJveGltaXR5
X2RvbWFpbjsKPj4gLSNpZmRlZiBDT05GSUdfTlVNQQo+PiArCj4+ICsjaWZkZWYgQ09ORklHX0FD
UElfTlVNQQo+PiAgIAlpZiAoa2Rldi0+cGRldi0+ZGV2Lm51bWFfbm9kZSA9PSBOVU1BX05PX05P
REUpCj4+ICsJCWtmZF9maW5kX251bWFfbm9kZV9pbl9zcmF0KGtkZXYpOwo+PiArI2VuZGlmCj4+
ICsjaWZkZWYgQ09ORklHX05VTUEKPj4gKwlpZiAoa2Rldi0+cGRldi0+ZGV2Lm51bWFfbm9kZSA9
PSBOVU1BX05PX05PREUpIHsKPj4gICAJCXN1Yl90eXBlX2hkci0+cHJveGltaXR5X2RvbWFpbl90
byA9IDA7Cj4+IC0JZWxzZQo+PiArCQlzZXRfZGV2X25vZGUoJmtkZXYtPnBkZXYtPmRldiwgMCk7
Cj4gVGhpcyBzaG91bGQgbm90IGJlIGhlcmUuIElmIHlvdSByZWFsbHkgd2FudCB0byBsaWUgYWJv
dXQgdGhlIE5VTUEgbm9kZQo+IGFuZCBwcmV0ZW5kIHRoYXQgaXQncyAwIGFuZCBub3QgTk9fTk9E
RSwgdGhlbiB0aGF0IHNob3VsZCBiZSBkb25lIGluCj4ga2ZkX2ZpbmRfbnVtYV9ub2RlX2luX3Ny
YXQuIFRoYXQgc2hvdWxkIGJlIHRoZSBvbmx5IGZ1bmN0aW9uIHRoYXQKPiBjaGFuZ2VzIHRoZSBk
ZXYtPm51bWFfbm9kZS4gTGlrZSBPYWsgcG9pbnRlZCBvdXQsIGV2ZW50dWFsbHkgdGhhdCBzaG91
bGQKPiBtYXliZSBub3QgZXZlbiBiZSBwYXJ0IG9mIHRoZSBkcml2ZXIuIEJ1dCBJJ20gT0sgd2l0
aCBrZWVwaW5nIGl0IGFzIGEKPiBmYWxsYmFjayBpbiB0aGUgZHJpdmVyIGZvciB0aGUgY2FzZSB0
aGF0IG9uZSBhIEdQVSBkb2Vzbid0IGhhdmUgYSBOVU1BCj4gbm9kZSBhc3NpZ25lZCBieSB0aGUg
a2VybmVsLgo+Cj4gQnV0IGlzIHNldHRpbmcgdGhlIGRldi0+bnVtYV9ub2RlIHRvIDAgcmVhbGx5
IG5lY2Vzc2FyeT8gRG9lcyBhbnl0aGluZwo+IGVsc2UgaW4gS0ZEIGRlcGVuZCBvbiB0aGUgZGV2
LT5udW1hX25vZGUgYmVpbmcgMD8gVGhpcyBmdW5jdGlvbiBpcyBvbmx5Cj4gc3VwcG9zZWQgdG8g
ZmlsbCB0aGUgcHJveGltaXR5X2RvbWFpbiBpbiB0aGUgQ1JBVCB0YWJsZS4gU2V0dGluZwo+IGRl
di0+bnVtYV9ub2RlIGlzIGEgc2lkZSBlZmZlY3QuIElmIHdlIGNhbid0IGZpZ3VyZSBvdXQgdGhl
IGNvcnJlY3QgTlVNQQo+IG5vZGUsIHdlIHNob3VsZG4ndCBqdXN0IGd1ZXNzIDAgaW4gYSB3YXkg
dGhhdCBwb3RlbnRpYWxseSBhZmZlY3RzIG90aGVyCj4gcGFydHMgb2YgdGhlIGtlcm5lbC4KPgo+
IFJlZ2FyZHMsCj4gIMKgIEZlbGl4Cj4KVGhlIHJlYXNvbiBJIGFtIGFkZGluZyBpdCBpcyBmb3Ig
Cmh0dHA6Ly9vbnRyYWNrLWludGVybmFsLmFtZC5jb20vYnJvd3NlL1NXREVWLTI4MTM3Ni4KClJD
Q0wgaXMgdXNpbmcgL3N5cy9jbGFzcy9kcm0vY2FyZDAvZGV2aWNlL251bWFfbm9kZSB0byBkZXRl
cm1pbmUgbnVtYSAKbm9kZSB3aGljaCBHUFUgaXMgY2xvc2UgdG8uIFRvIGtlZXAgY29uc2lzdGVu
Y2UgYmV0d2VlbiBLRkQgdG9wb2xvZ3kgYW5kIApwY2kgc3lzZnMgZXhwb3N1cmUsIEkgYWRkIGl0
IGFzIGEgd29ya2Fyb3VuZCBpbiBOUFMxIGFuZCBBQ1BJIGlzIG5vdCAKY29uZmlndXJlZC4KClRo
YW5rcywKRXJpYwoKPj4gKwl9IGVsc2UKPj4gICAJCXN1Yl90eXBlX2hkci0+cHJveGltaXR5X2Rv
bWFpbl90byA9IGtkZXYtPnBkZXYtPmRldi5udW1hX25vZGU7Cj4+ICAgI2Vsc2UKPj4gICAJc3Vi
X3R5cGVfaGRyLT5wcm94aW1pdHlfZG9tYWluX3RvID0gMDsKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
