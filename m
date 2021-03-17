Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AAEC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 08:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7C364F89
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 08:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7C364F89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D56F889BCD;
	Wed, 17 Mar 2021 08:27:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF52189B8E
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 08:27:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdJ2yXBJrvC/vr+UzkG/R18QNIMaDiC0IqbRr05b9ZCUQqQpqaVDz0T0NpxtwYgBzpatLzN/IT76VSzQE1bHx3k1v3zb6uVFxnqXhhjFJUgtLavzw3VSs0Pbb1ZXP6k7NgeXLNVQQhBI0WZf7WMpmYW/tFWFV5RRaNIuoMwCjjoElEvmyTrtp/a0TrAAcd5s3FO6vRollb9oQYlXpRBsd3uRtHhlNBBkuaWGuN1lJ408eqB1zaLn6Lf1nt2baO0NTxchf8SwyB8tPQnElcvU8Yf4z4f/liCQY32PDUmtzp9oMSOmYD82hTi4nduf3UDPX5ppUZ1V4tfT7Hv5BIJ7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+EdGqwQ0pQqKnmuMpLdMCjzhfFJYoa1ekhDDPXGYjk=;
 b=KQxihxJL8hggExv4gIfypWFDZU+wMZ2P/oBJ96hDzOByESuCBMaNCfrigSitJoxvjd8GjTnm+nxYyYp2ygh2hcbo/ORBtIlyWKmD98Iqmx76xf36CblI0rxGpE8BuK/Yt2Y8EbiZD8bWOzjNMy+1BYCktyta5kSuBIY1/l2gICG6dyUQ+LaU+klswHfI6vN1cVR+3mTILkiOj8TuUE+Ws0KF9LsIac3LNzwId348rzStJAEV9RDGlSE9Ph3HI8ywV58cSYaPdIfSRnHIVIkBPCh71xfKeOECCyAYYVDasbF032NWvOjEYOY0fI90A06KR+bcXSAlsA/ZwxPV6iTngw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+EdGqwQ0pQqKnmuMpLdMCjzhfFJYoa1ekhDDPXGYjk=;
 b=TEPMf/gDVKfISIK8lOO/QLXZnQoYj6RIkPszhhfXcGAW3kVxVuWLIsTampVvx2fViVHvQwNLxJgxnEJEF2m7qDDDl4lxBXWPlGrFTGz/JTOcoEPRBBBJ390DDJgPLkXAMp/J9sdskQY4ub4+uukei18KZT4YOa0DMu5mfLjmIEE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1846.namprd12.prod.outlook.com (2603:10b6:903:11b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 08:27:45 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 08:27:45 +0000
Subject: Re: [PATCH 4/4] drm/amdgpu: use amdgpu_bo_dmabuf for shared prime
 count
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>
References: <20210317074716.5547-1-nirmoy.das@amd.com>
 <20210317074716.5547-4-nirmoy.das@amd.com>
 <c5931d1c-a535-b253-52d5-2fa069b7554d@amd.com>
 <93907598-3673-cf4d-3edd-21ca22e31a4c@amd.com>
 <10cb3d67-df7a-7fc9-8b16-8c5ceb804c0e@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <246fb8c0-2f1c-a139-4197-dd46cbb28dd3@amd.com>
Date: Wed, 17 Mar 2021 09:27:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <10cb3d67-df7a-7fc9-8b16-8c5ceb804c0e@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.96.184]
X-ClientProxiedBy: AM0PR02CA0096.eurprd02.prod.outlook.com
 (2603:10a6:208:154::37) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.96.184) by
 AM0PR02CA0096.eurprd02.prod.outlook.com (2603:10a6:208:154::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend
 Transport; Wed, 17 Mar 2021 08:27:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b12a9fc3-a3e4-4933-b800-08d8e91e8a4d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1846:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1846DD694F7BEC2B4E14E5D68B6A9@CY4PR12MB1846.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HOXpits4jNGkp+YXaE9LzJGK8S55bt4MU2yMjcE8Wc3Z05VQEIBgz9lrw/TSqSJuFpfz5Uugg+eeMsmB2dZHqqUnM3+0A7qI5a/O7PGHE8nsL0CJnTSOuOTKcMS96LDFYjfp3bLwz0IKjffD8McmsMN6H9dqw1rNC1F3eANI+NBXts4V8z25sABa8p85T2Jz4q3Jc52R1uOhIkmkqzrBx8DYDVVzwTFhf0XHr/Mhmz50PKjXKsxF4ojDVXPJglltq2ugCgbVtUk2WP81zPEFdGhfzYf7PyDlL64DJWyj8eNol3qvKqgJ+cogVxro5vX49cwkVh5X0+KK6uHswG+kyMFEpnLw8Cxvin+Y5st0UQ9oEpw6/QisImYWhO3FzXovi4hf4SNn8pk1XFmcW37TPO1LnvQJZ+jrIa9WU6RQsQ/Vjy0MfOlsH6IV2NxaZ3KrXFTMy/IAgvC6tPbJIc2etFj1sLDsQ5UFKDYlCkr6EEXWyha/bptOXus+Jfm0ge5es9fB5ZkAB867n6UKlYWhCDz0Xiy2XRdtiKrBh85DHVISpxvfKDXW0Spt8BdJbJ/u40TO4UFBcBmPWDh7DRSXegbiSRaVlyqdQpEkFSmkzmadX1EmzJKejve8/7Cw3jcQzGf/5XcN0pZxuXFM60ypSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(53546011)(66476007)(31696002)(6636002)(8676002)(6486002)(66946007)(52116002)(4326008)(186003)(478600001)(2906002)(6666004)(2616005)(31686004)(16526019)(316002)(36756003)(956004)(16576012)(83380400001)(66574015)(66556008)(110136005)(5660300002)(26005)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZWhIRmMvKzQ2bTRhdnUrVlIvNlNDWkEyYW1YKzBWeVJBc2VXNGg4UUFVN0NZ?=
 =?utf-8?B?ak9sR1BzR3pxMVpGL1JIaFl4SWd2TTl2VnYrbEtDZXBSWFJHNjNYYjdVV1Bh?=
 =?utf-8?B?SDF5Z0ZQcHR2aHR6VGVwQ2xmUVBQUnE4Tko5NytPV3dpU2RabkM3REdjN0Nn?=
 =?utf-8?B?LzlTMlJCeUFYWG5WaGZrNUJYOTlTYVdpSHlObTA0R2ZtYksxWkhLUzhFNlA5?=
 =?utf-8?B?YTJVT2t3SVpMRWs5S0JSZWJLSDVGTk1ta1NjZTliWTUzR0JBeHIxVVZaQ1cx?=
 =?utf-8?B?dGpNWFZDWE5Ua1ZTS3ZnQ3hDSGpuT2V3UURFM1ZCWmc3TkJibmpjczl3ZlVW?=
 =?utf-8?B?ak44Z244aC9vc1hZNXBTTmhwVXMxc2U4UFM3VFo4SUhWN0UwNEh1N2F5Zno0?=
 =?utf-8?B?VUJOVStyZXppNlgvbVJFQXRhbHZxdlVrdlN3cUl3V2dmeUVTRlRQTTA1bkhN?=
 =?utf-8?B?M0ZkN1dISmtFSzNOM2Y5R053bWJ0cS9ONDRZSGVBT3prRmJjYXhkUEpRelVC?=
 =?utf-8?B?N3JyeUJTalNRNXZUakRCbGYybzBaM2xYNzk0d3A4L01ERFhsVSs1TWs2OWJW?=
 =?utf-8?B?WnMvQTd6VXR2ZytxYlJBZjdXR21oUHR3Y3JrUVZRVmJzTEw0eVhVMVY5MVNM?=
 =?utf-8?B?VVV1NkVUVHhaZ3kxcDNYZUV2WjhBSWFNMzQ2SE5POGRzRjBhMjVBVFZtbEk4?=
 =?utf-8?B?aUQ2RGFTblJHMmlSVGJ6WENZQXUvM3dXd3ZkMFh6N2kyL3R6Y0xLM0MvRzVy?=
 =?utf-8?B?MkFreHgyaHFVNnVxeS9QSENQV1dDaUVqTXhOZTZOR2M5NHZkYy9WTlJuNkVS?=
 =?utf-8?B?NDM2dUNSWjRBSzNESUlXdFB3c3FmK1c1SFVZNXFXbFZjRFA5NWpocWQyaDNk?=
 =?utf-8?B?cmhEZFNEYUw1dEhmM2F3aUozTHdld1AzUjRHc1k2UHlkYXlXcEtqV2k2eVN0?=
 =?utf-8?B?RXJ0TlUramY1eDYvQmRKRFFlV2lHNWh6TUhOMlJleEFZbzh4c1dONGlTYUx6?=
 =?utf-8?B?bm5nVVNkQW5QcElTSG9Ec1Fkc1FURGFlUkg1N1V4YlZQcFZ4dDQ1Z2xjN1N4?=
 =?utf-8?B?Nk5YYXNlZGRxYWtrZXBzYTkxdm1FdllDOUFvc0tYUDl0L0x0RUlUeWRENkdT?=
 =?utf-8?B?ZldmbUN3RVRLMms3QlNrM3BxNU51dmlEdlZOVk1XU3Q3bzJjeVhFRjRrNm56?=
 =?utf-8?B?NEdZMmxQWFMzZHd5ODdsSFUyWkIybDV3TkFKQ2dXeUprQ2l6ak9RMmdFYWRm?=
 =?utf-8?B?NEJibTBBUk9TVTRUU3grYllIdy9rRm85Q3FWZzFyejRKbEg1aUNXcmF6U3Ey?=
 =?utf-8?B?dXJnU3Bta0dkVDRick4rb0N6eXdlTUNZRjBGaFU2ZEgrMWg4ZzZKZ2szYytp?=
 =?utf-8?B?VjEzK09pc09PWEc0QVV0SlhncTFUeFJNc2F0MHZ5ZXhIRENTLzRrdU1Od25j?=
 =?utf-8?B?SzIzcWt0S3Q1RDZZOEllMkpKTmt0YVlISDgwVnNNTDhLcVlZZHd5cWZ6SFFE?=
 =?utf-8?B?MVo2VklhaGYycERuQUQ5eU9NMXhlMGxrYS9FS0ViQ1A5Y2IyaDlDUE1NVVI1?=
 =?utf-8?B?UXRzTGZzUUNaSEQ5THd4ZUo1ZWliWjNncmt6eXN4dzRQRzZMV1I2QTdqVldI?=
 =?utf-8?B?ODBEbE5ZcVJZd3FYcmJ5OUtGN0NIcXh6TCtoNHBnMDRzVFpKVzlPZGk2Tzcw?=
 =?utf-8?B?cVRMbThvQ3J4YnBNMnFWanpGVTJBUU1WR21VVTJFbGtFTjJZbWtYaFFuV1Zn?=
 =?utf-8?Q?BPAvTexCpUZnsj6seHWposLmoO+xuZBtwU9q8nz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12a9fc3-a3e4-4933-b800-08d8e91e8a4d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 08:27:45.3124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fHc7sy1zpTWVCp0N6esUdDyM0ldfIziq2hiU3ySLEV6Dnj0BB9YkLxXDL6OWbJSFBsL6bP11urhdEy8/UuZXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1846
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDMvMTcvMjEgOToxNSBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPgo+Cj4gQW0gMTcu
MDMuMjEgdW0gMDk6MTMgc2NocmllYiBOaXJtb3k6Cj4+Cj4+IE9uIDMvMTcvMjEgOTowNiBBTSwg
Q2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+IFRoYXQgd2hvbGUgYXBwcm9hY2ggd29uJ3Qgd29y
ayA6KQo+Pj4KPj4+IFRoZSBwcmltZV9zaGFyZWRfY291bnQgaXMgb24gdGhlIGV4cG9ydGVkIEJP
IGFuZCBub3Qgb24gdGhlIGltcG9ydGVkIAo+Pj4gb25lLgo+Pj4KPj4+IFNvIGFueSB1c2VyIEJP
IGNhbiBiZSBleHBvcnRlZC4KPj4KPj4KPj4gU28gYW55IEJPIGZyb20gYW55IGRybSBkcml2ZXIg
aXMgcG9zc2libGUuIE5vIHdvbmRlciBpdCB3b3JrZWQgd2l0aCAKPj4gYW1kZ3B1LWFtZGdwdSB0
ZXN0IG1hY2hpbmUuCj4+Cj4+IE9LIHNjcmFwcGluZyB0aGUgc2VyaWVzIDovCj4KPiBUcnkgbG9v
a2luZyBpbnRvIHRoZSBwYWdlIHRhYmxlIEJPcywgdGhhdCBoYXMgbXVjaCBtb3JlIHBvdGVudGlh
bCBmb3IgCj4gYSBjbGVhbnVwIHRoYW4gdGhpcyBzaW5nbGUgZmllbGQgaGVyZS4KPgo+IENocmlz
dGlhbi4KCgpUaGFua3MsIGNoZWNraW5nIGl0LgoKCk5pcm1veQoKCj4KPj4KPj4KPj4gVGhhbmtz
LAo+Pgo+PiBOaXJtb3kKPj4KPj4KPj4+Cj4+PiBSZWdhcmRzLAo+Pj4gQ2hyaXN0aWFuLgo+Pj4K
Pj4+IEFtIDE3LjAzLjIxIHVtIDA4OjQ3IHNjaHJpZWIgTmlybW95IERhczoKPj4+PiBSZW1vdmUg
cHJpbWVfc2hhcmVkX2NvdW50IGZyb20gYmFzZSBjbGFzcyBhbmQgdXNlIHRoYXQKPj4+PiB0aGUg
c3ViY2xhc3MsIGFtZGdwdV9ib19kbWFidWYuCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBOaXJt
b3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4+Pj4gLS0tCj4+Pj4gwqAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmPCoMKgwqDCoMKgIHzCoCAyICstCj4+Pj4gwqAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYuYyB8IDEyICsrKysrKysrLS0t
LQo+Pj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uY8KgwqDCoMKg
IHzCoCAyICstCj4+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVj
dC5jwqAgfMKgIDIgKy0KPj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
b2JqZWN0LmjCoCB8wqAgMSAtCj4+Pj4gwqAgNSBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25z
KCspLCA4IGRlbGV0aW9ucygtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jIAo+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2NzLmMKPj4+PiBpbmRleCBiNWM3NjY5OTgwNDUuLjA0OTk0NzU3Y2M5YyAxMDA2
NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwo+Pj4+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCj4+Pj4gQEAgLTYx
OCw3ICs2MTgsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9jc19wYXJzZXJfYm9zKHN0cnVjdCAKPj4+
PiBhbWRncHVfY3NfcGFyc2VyICpwLAo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYW1k
Z3B1X2JvICpibyA9IHR0bV90b19hbWRncHVfYm8oZS0+dHYuYm8pOwo+Pj4+IMKgIMKgwqDCoMKg
wqDCoMKgwqDCoCAvKiBNYWtlIHN1cmUgd2UgdXNlIHRoZSBleGNsdXNpdmUgc2xvdCBmb3Igc2hh
cmVkIEJPcyAqLwo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAoYm8tPnByaW1lX3NoYXJlZF9jb3Vu
dCkKPj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGlzX2FtZGdwdV9ib19kbWFidWYoYm8pKQo+Pj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGUtPnR2Lm51bV9zaGFyZWQgPSAwOwo+Pj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBlLT5ib192YSA9IGFtZGdwdV92bV9ib19maW5kKHZtLCBibyk7Cj4+
Pj4gwqDCoMKgwqDCoCB9Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kbWFfYnVmLmMgCj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZG1hX2J1Zi5jCj4+Pj4gaW5kZXggZTBjNGY3YzdmMWI5Li4zY2Y1N2VhNTY0OTkgMTAw
NjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYu
Ywo+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMK
Pj4+PiBAQCAtMTQzLDYgKzE0Myw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RtYV9idWZfYXR0YWNo
KHN0cnVjdCBkbWFfYnVmIAo+Pj4+ICpkbWFidWYsCj4+Pj4gwqAgewo+Pj4+IMKgwqDCoMKgwqAg
c3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmogPSBkbWFidWYtPnByaXY7Cj4+Pj4gwqDCoMKgwqDC
oCBzdHJ1Y3QgYW1kZ3B1X2JvICpibyA9IGdlbV90b19hbWRncHVfYm8ob2JqKTsKPj4+PiArwqDC
oMKgIHN0cnVjdCBhbWRncHVfYm9fZG1hYnVmICpkYm8gPSB0b19hbWRncHVfYm9fZG1hYnVmKGJv
KTsKPj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gYW1kZ3B1X3R0
bV9hZGV2KGJvLT50Ym8uYmRldik7Cj4+Pj4gwqDCoMKgwqDCoCBpbnQgcjsKPj4+PiDCoCBAQCAt
MTcyLDcgKzE3Myw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RtYV9idWZfYXR0YWNoKHN0cnVjdCAK
Pj4+PiBkbWFfYnVmICpkbWFidWYsCj4+Pj4gwqDCoMKgwqDCoCBpZiAocikKPj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgZ290byBvdXQ7Cj4+Pj4gwqAgLcKgwqDCoCBiby0+cHJpbWVfc2hhcmVkX2Nv
dW50Kys7Cj4+Pj4gK8KgwqDCoCBkYm8tPnByaW1lX3NoYXJlZF9jb3VudCsrOwo+Pj4+IMKgwqDC
oMKgwqAgYW1kZ3B1X2JvX3VucmVzZXJ2ZShibyk7Cj4+Pj4gwqDCoMKgwqDCoCByZXR1cm4gMDsK
Pj4+PiDCoCBAQCAtMTk0LDEwICsxOTUsMTEgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2RtYV9idWZf
ZGV0YWNoKHN0cnVjdCAKPj4+PiBkbWFfYnVmICpkbWFidWYsCj4+Pj4gwqAgewo+Pj4+IMKgwqDC
oMKgwqAgc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmogPSBkbWFidWYtPnByaXY7Cj4+Pj4gwqDC
oMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvICpibyA9IGdlbV90b19hbWRncHVfYm8ob2JqKTsKPj4+
PiArwqDCoMKgIHN0cnVjdCBhbWRncHVfYm9fZG1hYnVmICpkYm8gPSB0b19hbWRncHVfYm9fZG1h
YnVmKGJvKTsKPj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gYW1k
Z3B1X3R0bV9hZGV2KGJvLT50Ym8uYmRldik7Cj4+Pj4gwqAgLcKgwqDCoCBpZiAoYXR0YWNoLT5k
ZXYtPmRyaXZlciAhPSBhZGV2LT5kZXYtPmRyaXZlciAmJiAKPj4+PiBiby0+cHJpbWVfc2hhcmVk
X2NvdW50KQo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBiby0+cHJpbWVfc2hhcmVkX2NvdW50LS07Cj4+
Pj4gK8KgwqDCoCBpZiAoYXR0YWNoLT5kZXYtPmRyaXZlciAhPSBhZGV2LT5kZXYtPmRyaXZlciAm
JiAKPj4+PiBkYm8tPnByaW1lX3NoYXJlZF9jb3VudCkKPj4+PiArwqDCoMKgwqDCoMKgwqAgZGJv
LT5wcmltZV9zaGFyZWRfY291bnQtLTsKPj4+PiBwbV9ydW50aW1lX21hcmtfbGFzdF9idXN5KGFk
ZXZfdG9fZHJtKGFkZXYpLT5kZXYpOwo+Pj4+IMKgwqDCoMKgwqAgcG1fcnVudGltZV9wdXRfYXV0
b3N1c3BlbmQoYWRldl90b19kcm0oYWRldiktPmRldik7Cj4+Pj4gQEAgLTQzMSw2ICs0MzMsNyBA
QCBhbWRncHVfZG1hX2J1Zl9jcmVhdGVfb2JqKHN0cnVjdCBkcm1fZGV2aWNlIAo+Pj4+ICpkZXYs
IHN0cnVjdCBkbWFfYnVmICpkbWFfYnVmKQo+Pj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYgPSBkcm1fdG9fYWRldihkZXYpOwo+Pj4+IMKgwqDCoMKgwqAgc3RydWN0IGRy
bV9nZW1fb2JqZWN0ICpnb2JqOwo+Pj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9ibyAqYm87
Cj4+Pj4gK8KgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvX2RtYWJ1ZiAqZGJvOwo+Pj4+IMKgwqDCoMKg
wqAgdWludDY0X3QgZmxhZ3MgPSAwOwo+Pj4+IMKgwqDCoMKgwqAgaW50IHJldDsKPj4+PiDCoCBA
QCAtNDQ5LDEwICs0NTIsMTEgQEAgYW1kZ3B1X2RtYV9idWZfY3JlYXRlX29iaihzdHJ1Y3QgZHJt
X2RldmljZSAKPj4+PiAqZGV2LCBzdHJ1Y3QgZG1hX2J1ZiAqZG1hX2J1ZikKPj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgZ290byBlcnJvcjsKPj4+PiDCoCDCoMKgwqDCoMKgIGJvID0gZ2VtX3RvX2Ft
ZGdwdV9ibyhnb2JqKTsKPj4+PiArwqDCoMKgIGRibyA9IHRvX2FtZGdwdV9ib19kbWFidWYoYm8p
Owo+Pj4+IMKgwqDCoMKgwqAgYm8tPmFsbG93ZWRfZG9tYWlucyA9IEFNREdQVV9HRU1fRE9NQUlO
X0dUVDsKPj4+PiDCoMKgwqDCoMKgIGJvLT5wcmVmZXJyZWRfZG9tYWlucyA9IEFNREdQVV9HRU1f
RE9NQUlOX0dUVDsKPj4+PiDCoMKgwqDCoMKgIGlmIChkbWFfYnVmLT5vcHMgIT0gJmFtZGdwdV9k
bWFidWZfb3BzKQo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBiby0+cHJpbWVfc2hhcmVkX2NvdW50ID0g
MTsKPj4+PiArwqDCoMKgwqDCoMKgwqAgZGJvLT5wcmltZV9zaGFyZWRfY291bnQgPSAxOwo+Pj4+
IMKgIMKgwqDCoMKgwqAgZG1hX3Jlc3ZfdW5sb2NrKHJlc3YpOwo+Pj4+IMKgwqDCoMKgwqAgcmV0
dXJuIGdvYmo7Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9nZW0uYyAKPj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0u
Ywo+Pj4+IGluZGV4IDUzNjZhODA2YmUyYi4uN2NjZThhYTI5ZmQ3IDEwMDY0NAo+Pj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+Pj4+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwo+Pj4+IEBAIC03ODMsNyArNzgzLDcg
QEAgaW50IGFtZGdwdV9nZW1fb3BfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgCj4+Pj4g
dm9pZCAqZGF0YSwKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4+Pj4gwqDCoMKgwqDC
oCB9Cj4+Pj4gwqDCoMKgwqDCoCBjYXNlIEFNREdQVV9HRU1fT1BfU0VUX1BMQUNFTUVOVDoKPj4+
PiAtwqDCoMKgwqDCoMKgwqAgaWYgKHJvYmotPnByaW1lX3NoYXJlZF9jb3VudCAmJiAoYXJncy0+
dmFsdWUgJiAKPj4+PiBBTURHUFVfR0VNX0RPTUFJTl9WUkFNKSkgewo+Pj4+ICvCoMKgwqDCoMKg
wqDCoCBpZiAoaXNfYW1kZ3B1X2JvX2RtYWJ1Zihyb2JqKSAmJiAoYXJncy0+dmFsdWUgJiAKPj4+
PiBBTURHUFVfR0VNX0RPTUFJTl9WUkFNKSkgewo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHIgPSAtRUlOVkFMOwo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9i
b191bnJlc2VydmUocm9iaik7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7
Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmpl
Y3QuYyAKPj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+
Pj4+IGluZGV4IGFkNjE1ZWVjMWU4Yy4uNDM1YmY4NTk5MWU1IDEwMDY0NAo+Pj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+Pj4+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+Pj4+IEBAIC05NjUsNyArOTY1
LDcgQEAgaW50IGFtZGdwdV9ib19waW5fcmVzdHJpY3RlZChzdHJ1Y3QgYW1kZ3B1X2JvIAo+Pj4+
ICpibywgdTMyIGRvbWFpbiwKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7
Cj4+Pj4gwqAgwqDCoMKgwqDCoCAvKiBBIHNoYXJlZCBibyBjYW5ub3QgYmUgbWlncmF0ZWQgdG8g
VlJBTSAqLwo+Pj4+IC3CoMKgwqAgaWYgKGJvLT5wcmltZV9zaGFyZWRfY291bnQgfHwgYm8tPnRi
by5iYXNlLmltcG9ydF9hdHRhY2gpIHsKPj4+PiArwqDCoMKgIGlmIChpc19hbWRncHVfYm9fZG1h
YnVmKGJvKSB8fCBiby0+dGJvLmJhc2UuaW1wb3J0X2F0dGFjaCkgewo+Pj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCBpZiAoZG9tYWluICYgQU1ER1BVX0dFTV9ET01BSU5fR1RUKQo+Pj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGRvbWFpbiA9IEFNREdQVV9HRU1fRE9NQUlOX0dUVDsKPj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgZWxzZQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmggCj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfb2JqZWN0LmgKPj4+PiBpbmRleCAzZDIzYWQyNDdiMWIuLjJmMWFiY2M0ZTFl
NyAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2Jq
ZWN0LmgKPj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0
LmgKPj4+PiBAQCAtOTMsNyArOTMsNiBAQCBzdHJ1Y3QgYW1kZ3B1X2JvIHsKPj4+PiDCoMKgwqDC
oMKgIHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdMKgwqDCoCB0Ym87Cj4+Pj4gwqDCoMKgwqDCoCBz
dHJ1Y3QgdHRtX2JvX2ttYXBfb2JqwqDCoMKgwqDCoMKgwqAga21hcDsKPj4+PiDCoMKgwqDCoMKg
IHU2NMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmbGFnczsKPj4+PiAtwqDCoMKgIHVu
c2lnbmVkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcmltZV9zaGFyZWRfY291bnQ7Cj4+Pj4gwqDC
oMKgwqDCoCAvKiBwZXIgVk0gc3RydWN0dXJlIGZvciBwYWdlIHRhYmxlcyBhbmQgd2l0aCB2aXJ0
dWFsIAo+Pj4+IGFkZHJlc3NlcyAqLwo+Pj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV92bV9i
b19iYXNlwqDCoMKgICp2bV9ibzsKPj4+PiDCoMKgwqDCoMKgIC8qIENvbnN0YW50IGFmdGVyIGlu
aXRpYWxpemF0aW9uICovCj4+Pgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
