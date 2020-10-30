Return-Path: <SRS0=gTHH=EF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDDBC4741F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 15:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D44206E9
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2020 15:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZSzksHyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D44206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38E036E9C6;
	Fri, 30 Oct 2020 15:47:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABCCD6E9C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2020 15:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9FdyWdsny9WENjS0+lDEm7Fbeaop88FV1mK8SYj83LMu5IALSAF4QZzHXqW0zERvqEUTiEtTdiNHPFHEaSOestkqqPvDo6hit2kwyKKUk2tW9Fjp1yO3eSO8QPaZeXsP/E+vs3pw4jqyUW5ldyvd51A9TlRoA9Aa6+jCnTxEZBDW1YOy6Dwb/LmTQENoPGTPitRI7EsGpERAZHIX0s3jR8+lzUUIaA9jaUl6ITUJUwN6+bZ5crrJFqClSy6L6TMNyZzIluudPnnF61TmP302eulVfRZpFUp0Ig+m0zuQsySWfKUlV/all3gorebsBEb87t1xRf+ddNLpU2NNoJYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqoM5ggCENjhqqv9QLoz9L/ym4B6EUqlNq04kPII6Fk=;
 b=Bh6A1MKVLVdsdJcX9SgetrtxBU6ElESRI1OYxy8P8pcwIQHMrNAEHVfbRed8TzKmGwcxuQqCTHVfj024iLeZNUhySrZoRUkyk5WkU8QTN9cXNKa5CbHd3Issz9ewVad4HBkurPtTkTI3XJfOWp99t+2F4tt8jrUf5mvzDmR5GEa6LyStMjOHUZkavEYaDoHiTFgtrogMHOETbIFIWISePHfC52EgPFZeZNmzmhiI1YmSp13f6IhdSCdHBXkqjGbIOYNgBHVKp5mm3FRciNAjBbTN80Ew8yP7d4G3k3S7wrAjB8sYtlnkjIWh/DLIRroeGIpeA4NGMlywq7IqrPRDVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqoM5ggCENjhqqv9QLoz9L/ym4B6EUqlNq04kPII6Fk=;
 b=ZSzksHyOUHUne9xnc4rMH9iqMSgKvI3sIHqq2j4ymsM9NBxF5Ce9OPy7+ez5C5T7wBOTtNYbDc6jlV1wMyo7mvtMXyaocYu5oBiUaSuJr71SCXqFY9HtsBiuPBi1EP5wVyBoSYAcEAyac0yQI5DULuL438OGgK7+szB3K1fQ214=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BY5PR12MB4901.namprd12.prod.outlook.com (2603:10b6:a03:1c5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 30 Oct
 2020 15:47:49 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::21a4:4ed1:c6bb:5437]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::21a4:4ed1:c6bb:5437%5]) with mapi id 15.20.3499.027; Fri, 30 Oct 2020
 15:47:49 +0000
Subject: Re: [PATCH] drm/amdgpu: apply dm_pp_notify_wm_clock_changes() for
 Polaris only
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20201030110445.1662217-1-evan.quan@amd.com>
 <ee27f030-05a6-6a21-94fd-c70e53325de5@amd.com>
 <DM6PR12MB26196EB75BE3C8DA9BC5B9B1E4150@DM6PR12MB2619.namprd12.prod.outlook.com>
 <3b15772e-89db-da66-aa20-d9a463aac757@amd.com>
Message-ID: <d30a7be9-f017-bdf4-87e4-974ca59fd7d6@amd.com>
Date: Fri, 30 Oct 2020 16:47:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <3b15772e-89db-da66-aa20-d9a463aac757@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM4PR0501CA0047.eurprd05.prod.outlook.com
 (2603:10a6:200:68::15) To BY5PR12MB3764.namprd12.prod.outlook.com
 (2603:10b6:a03:1ac::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM4PR0501CA0047.eurprd05.prod.outlook.com (2603:10a6:200:68::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Fri, 30 Oct 2020 15:47:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff5c9ffb-3810-4ea0-2e5f-08d87ceb275e
X-MS-TrafficTypeDiagnostic: BY5PR12MB4901:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB49015A7AC5DEF5AB235C5D0E83150@BY5PR12MB4901.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6dHMEsM+e3dBPeRCYYlUTWwLsEmt08DIf8EHqQh3TJbQppEZXMNgCL6DYg7XQ0Raitx8bARSSx+GxYhwaBQ2NN+cAOYLKNUbpVZBogp3DmOHo9nRCqOE7QF/UfaKX68wUa0SjhEi0e9+jjvWDEynGQ0cYrvkV+aSlJdoqgkgmVoJ+4wU8HGZ2+MLkGImzlUcd/HtY5Tp/08xLyyZKdugGbigvs6sgGvi3hnMV2PwnTHuzQ1DUBv7L2GaRHCrK2fJ13UVJhEJ6ZL9qayvFj6KqkTfOZbH5bArP3qXIMVtkZek+UaxrJ/X6x1KWwEg72+KmSC0QrjTH3t1ID7zIMLMewQaMYw4DDJcPafH/+KT7VbRTX/CYuagwfiHxLhWVw1+Ow+GYlsV4x5+RwvnLQ9zRpdC3rqXKEgHFnwtf5GaOmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3764.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(2616005)(86362001)(966005)(52116002)(478600001)(31686004)(186003)(16526019)(53546011)(110136005)(316002)(2906002)(6666004)(83380400001)(4326008)(66574015)(6486002)(66556008)(66476007)(66946007)(8936002)(36756003)(5660300002)(8676002)(31696002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: L7VTBN3yNQ/bZU2PsYct/p9xGt5SYdI1SgUEUQ9FeJe2LM9x3nb21maZxa/mt45ZuXXmsN6JTk4wLHc0VjAjprdXMBgSYnvU1F2syZJxXobyLXqtBkO/ueJ5430w8+sMLd6GGatjM6fzU+tvl9CpznUstJ2lcIApQ7fLHV49whNXZvOhFLH5iPVdRwIgMGPW1lqXJr4lwmlPYrFVZ4h/l0eRk8xcXyeUG7O94Y3BYCfxi+oq8S8r8uvjGDLInq1hKo/sy2DACnDiWXjwc7kYVF9oqXdVwlfyLhUsTA4r3e9VHhpP6RkVwJMSOy/8RMRiObL9LhgvaKUmVKd6qdkI+pDZpWTcV3dsbXPNtYlIqwUQnQRYEAAe1A65f5fMZRp3BgLBd5pDEnRF0S0du2DM7OKzJRZdogsmi+J7wdFiihnLC0B95q4efq24sKEsHjtmK5uJQgxcD0XLbupWvDghbyzkuwxWZ+Px3yP23kevPY49WqVkJDPDhCNQl84jExgOSTU5Al6je07XQKNqB7bRaMSG4oHlxce4UhfuHhNaIm8GD1JLCV9ebM5PwR9pbPUAFdJ5woiYRAfD2cfJ/Q2c8h2ESnKgimKj5BwS4BJ7vteziL3CLaPWWhAv5vXn3qNaIwdRDk8k9VHn7S6P0aHRlm2/drTm/aCcS3ELDIIRnKcgjKZkPGgwLV5e4oaGmUWoCwm1y2gtt1FcOfKSN0+I9Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5c9ffb-3810-4ea0-2e5f-08d87ceb275e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 15:47:49.5685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W73eM8Gq9O7L7Jyz0/s5azQaX1f/vsJBDybGiv/qpANzMtWX+0GHum33MnwYYgCa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4901
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGVzdGVkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CgpU
aGF0IGluZGVlZCBmaXhlcyB0aGUgaXNzdWUuCgpUaGFua3MsCkNocmlzdGlhbi4KCkFtIDMwLjEw
LjIwIHVtIDEyOjExIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPiBUaGFua3MsIGdvaW5nIHRv
IHRlc3QgaXQgbGF0ZXIgdG9kYXkuCj4KPiBDaHJpc3RpYW4uCj4KPiBBbSAzMC4xMC4yMCB1bSAx
MjowNyBzY2hyaWViIFF1YW4sIEV2YW46Cj4+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBJbnRl
cm5hbCBEaXN0cmlidXRpb24gT25seV0KPj4KPj4gWWVzLCBpdCBpcyBpbnRlbmRlZCBmb3IgdGhh
dC4KPj4KPj4gQlIKPj4gRXZhbgo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+PiBGcm9t
OiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPgo+PiBTZW50OiBG
cmlkYXksIE9jdG9iZXIgMzAsIDIwMjAgNzowNiBQTQo+PiBUbzogUXVhbiwgRXZhbiA8RXZhbi5R
dWFuQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBDYzogRGV1Y2hl
ciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPgo+PiBTdWJqZWN0OiBSZTog
W1BBVENIXSBkcm0vYW1kZ3B1OiBhcHBseSAKPj4gZG1fcHBfbm90aWZ5X3dtX2Nsb2NrX2NoYW5n
ZXMoKSBmb3IgUG9sYXJpcyBvbmx5Cj4+Cj4+IEFtIDMwLjEwLjIwIHVtIDEyOjA0IHNjaHJpZWIg
RXZhbiBRdWFuOgo+Pj4gV2lsbCBleHBhbmQgaXQgdG8gb3RoZXIgQVNJQ3MgYWZ0ZXIgdmVyaWZp
ZWQuCj4+Pgo+Pj4gQ2hhbmdlLUlkOiBJMDNlMDc0ZWEwZTkyMWE5ODRlYjgxOWIyMjJlNDM0ZTg4
ODg4ZTM3NQo+Pj4gU2lnbmVkLW9mZi1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4K
Pj4gQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
Pj4KPj4gSSBhc3N1bWUgdGhpcyBmaXhlcyBteSBpc3N1ZSBvbiBWZWdhMjA/Cj4+Cj4+IFRoYW5r
cywKPj4gQ2hyaXN0aWFuLgo+Pgo+Pj4gLS0tCj4+PiDCoMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3BwX3NtdS5jIHwgNyArKysrKystCj4+PiDCoMKg
IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4+Cj4+PiBk
aWZmIC0tZ2l0IAo+Pj4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2Ft
ZGdwdV9kbV9wcF9zbXUuYyAKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG1fcHBfc211LmMKPj4+IGluZGV4IGZkMzlkZDY3YmZhNC4uODQwNjVjMTJk
NGI4IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG1fcHBfc211LmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtX3BwX3NtdS5jCj4+PiBAQCAtNDYyLDcgKzQ2MiwxMiBAQCBi
b29sIGRtX3BwX25vdGlmeV93bV9jbG9ja19jaGFuZ2VzKAo+Pj4gwqDCoCB2b2lkICpwcF9oYW5k
bGUgPSBhZGV2LT5wb3dlcnBsYXkucHBfaGFuZGxlOwo+Pj4gwqDCoCBjb25zdCBzdHJ1Y3QgYW1k
X3BtX2Z1bmNzICpwcF9mdW5jcyA9IGFkZXYtPnBvd2VycGxheS5wcF9mdW5jczsKPj4+Cj4+PiAt
aWYgKHBwX2Z1bmNzICYmIHBwX2Z1bmNzLT5zZXRfd2F0ZXJtYXJrc19mb3JfY2xvY2tzX3Jhbmdl
cykgewo+Pj4gKy8qCj4+PiArICogTGltaXQgdGhpcyB3YXRlcm1hcmsgc2V0dGluZyBmb3IgUG9s
YXJpcyBmb3Igbm93Cj4+PiArICogVE9ETzogZXhwYW5kIHRoaXMgdG8gb3RoZXIgQVNJQ3MKPj4+
ICsgKi8KPj4+ICtpZiAoKGFkZXYtPmFzaWNfdHlwZSA+PSBDSElQX1BPTEFSSVMxMCkgJiYgKGFk
ZXYtPmFzaWNfdHlwZSA8PSAKPj4+IENISVBfVkVHQU0pCj4+PiArwqDCoMKgwqAgJiYgcHBfZnVu
Y3MgJiYgcHBfZnVuY3MtPnNldF93YXRlcm1hcmtzX2Zvcl9jbG9ja3NfcmFuZ2VzKSB7Cj4+PiDC
oMKgIGlmICghcHBfZnVuY3MtPnNldF93YXRlcm1hcmtzX2Zvcl9jbG9ja3NfcmFuZ2VzKHBwX2hh
bmRsZSwKPj4+IMKgwqAgKHZvaWQgKil3bV93aXRoX2Nsb2NrX3JhbmdlcykpCj4+PiDCoMKgIHJl
dHVybiB0cnVlOwo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
