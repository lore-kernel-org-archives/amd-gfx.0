Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F84C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 18:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C8E61073
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 18:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C8E61073
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B9376EC5E;
	Tue, 18 May 2021 18:02:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE2A56EC5C;
 Tue, 18 May 2021 18:02:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knOcZ0Vwo2dqXYuVKeRaerCLgLYqWSuG5Xoc+EWH0+NQTkkStaf/+3JJNaCWkCnoJlg2k4bCxCYrFSOu7YOW4Cv+FyRz5DCTQlf4ZWQr9iTOcWXg4YWTG2RuwEh9Vjm/6fPWwVL+JEYaeKVC4o+M2DIUN8qrPZWSFnGEQMawR6P8q0f2qdgIq1NQgRR7ayUlHfFEG9SJmsLB/Z7S6AxbvIE/8Ghi0w9KE12t5DWlAKsNPYUB3Yl3z+diVfHxIfQUJMQs0UR9G5c2stfSFeeDYpnBQdI4L/SlmeXSGg07b5J0uVKWPJU9jmSGtHptKqSCaz/jIvVVEqzu0Pjdc04POg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fX26ehZ4Rsug5+Q/GfMY5IdetKFdqs4YfNlTD0645rc=;
 b=mfESOfZX+1sA8Q2lPELlTKmxIEY/rcA6ut8ImjzmVEN0FtKHnmOd/OGnBUWs4Ng29ecXVQcleIATssDT3q/QC6G/ANMCXMXLwUDFewMMNKkEeMQz70tLmGWBWQBG4GFTm2dwb+id8ZgYuX5H9S4gWxf6Fp6CJEjz16znu+wjdhCSy7LbqncB8mh1GS3IlEi/t1++wnV75Pl2fsAuZg9GvNyyHrbN9VrR6GOmsY+pC9ZIEyjfa3e+QKvHnOFRhcySflVmuVBw+bSjYXM8g5wW+zL/qlX3M6qh9Ira+gszxCsOiuZxyG9rszS2mSy28QdneiBOrSCdmKNjZsl8aA9+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fX26ehZ4Rsug5+Q/GfMY5IdetKFdqs4YfNlTD0645rc=;
 b=lXqV+KeFt2kHNkLotI1OKQEpeVG4J6qd+CDB6ICstCBbugNy18nftmbd7nna+74hMnIljC4ssKlrNClX0zWunIwh+QmGslcsITAIzXltJg6aAwbf+BNMyTgn8a53rCNI8y6rVE4P0aumrru1rsC7yRCkb1sTHe1q1HjOC5Z+J+s=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4607.namprd12.prod.outlook.com (2603:10b6:208:a1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 18:02:11 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 18:02:11 +0000
Subject: Re: [PATCH v7 13/16] drm/scheduler: Fix hang when sched_entity
 released
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, ckoenig.leichtzumerken@gmail.com,
 daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
 <20210512142648.666476-14-andrey.grodzovsky@amd.com>
 <9e1270bf-ab62-5d76-b1de-e6cd49dc4841@amd.com>
 <f0c5dea7-af35-9ea5-028e-6286e57a469a@amd.com>
 <34d4e4a8-c577-dfe6-3190-28a5c63a2d23@amd.com>
 <da1f9706-d918-cff8-2807-25da0c01fcde@amd.com>
 <8228ea6b-4faf-bb7e-aaf4-8949932e869a@amd.com>
 <ec157a35-85fb-11e5-226a-c25d699102c6@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <53f281cc-e4c0-ea5d-9415-4413c85a6a16@amd.com>
Date: Tue, 18 May 2021 20:02:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <ec157a35-85fb-11e5-226a-c25d699102c6@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:88c7:d7d9:22ef:f850]
X-ClientProxiedBy: FR0P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::10) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:88c7:d7d9:22ef:f850]
 (2a02:908:1252:fb60:88c7:d7d9:22ef:f850) by
 FR0P281CA0071.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:49::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.11 via Frontend Transport; Tue, 18 May 2021 18:02:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88b5bdbe-f763-42b4-e166-08d91a270ef6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4607:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4607219B8C869F10F094C68B832C9@MN2PR12MB4607.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95Z7nRnhTWD2VP+8FrgbPJuN40BXeuHVBU9wJtVMZq1FqFKEzHVkHbxNBPg7fiZ0laCisyrN5TC2EdcQSQk7LEIu1izcZoqERxD5vUSOk2IyJTL24lI5hWpMQVGlqQ1Wjib8d0vVr8f9VStOfqSnd2s/dTUBXbfmO6wroMF/TFaYYQQnFH7FH0IpF+jypoYThWN3PtkOtBdao68hRYPWkMgTlRH/fcXARJeXIdUlViFQnrALZq0yghsdMnSNXpttVXXQUKPuAnUeqOHQoYuuX7OlG2IvjnxabBDI3wQb0O8M+Tspri5gFgFI6I9Qoyzs9QQnLv25Bc9B60u6JWl8EW75CcY4Q79CHYQbJOgppI4qh3IJTt7QW8KgSkar3UozkK4e0Lo+UFaUAh2fxZ2BHp0/OBy4nLSPkcqaTGUzSAN/U8aE/JsBb5WaywBev24+SUV/xAkOaMjc8YpG/tsTIvrxjCYlgr8xniX6B45rtZNY+t0Hz5ShQPc2CtFcTO4YvzokN7+e21OLPUUQu9dx5Aby1iJqJj29yLssAQaIzKq+MIEqw76OoXEvGKSZn3NGH3a2iKJEfI+hnGb4NF0bowT3dU9MeoISzXpp7VtQSJyX5T1LokSXBbyxoe/atTA2FIK/KWzVFlfgNlt/rZxIx/7Ox/PYi8n37y/he2zTE9XeD21lOgUiOadpK/6Bzu3C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(31696002)(31686004)(8676002)(478600001)(6636002)(16526019)(186003)(66574015)(2616005)(2906002)(8936002)(6486002)(52116002)(83380400001)(5660300002)(36756003)(86362001)(53546011)(316002)(38100700002)(6666004)(66476007)(4326008)(66946007)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aWt3d2pTTHpOUUJxQ0g3TkozTkxGZWJoWGJqZjNXdmZ3M1h0bTdkRjhDOU1P?=
 =?utf-8?B?bEYvSzZZeHhVd0RwTzFTcEhLbzN3OWxJOGFyY1BkWnZPa1g2SFVNVzdQQ2Fr?=
 =?utf-8?B?TXQ1d0dxbFpwSnlVcmtwK2NOcjl4aGg5L2pkWmsxSGVVaG1YR2k1VWhmd2J3?=
 =?utf-8?B?NGVzR0VHQ1NrMHZMN0ZlWEhaaTRuRmo1NTFMTmJFNERUR2s4b0JKbm53NHFQ?=
 =?utf-8?B?NXVoTXRrSmlXMFh4Y2FqSW9Ta1R1eXBmQ1JBay9nQ2tnVEhLdmdPUFlNaVNP?=
 =?utf-8?B?K3h5cW1yclN2bThNdSsvWCs5YlRueFc0TjZodmROaVZBK2NlQWRNb3h1TlV4?=
 =?utf-8?B?a3U4UExRNm14RytkRldpTFozWUVSTXhiU0EzKzJValJwZTNmMkd4SWNJSmJx?=
 =?utf-8?B?aklKcGVSUmZReVlXbWdiU1h4aVhpMWRDQ293UC9mVXhRVnNsWjg4dzZxOWY3?=
 =?utf-8?B?MkNkZ1p3bXRDYXVMcnJPQ1FVZHAzcEFwUCs4NlRoUHd1TEVHUlRQZ3JJeVF0?=
 =?utf-8?B?RnI1Q0JxWk9TU1AzN1JuczhnaDQ5bFoxa09GdUlyS1p1QXlPRWtxNkY3a0wr?=
 =?utf-8?B?elc2TjZlWnBzTGE5b1RSQ0RvcFNKb2ZVTFhkNWZYQXErV1NwVzU0UUplZHZs?=
 =?utf-8?B?bDRCbVVoejdoOFVCYmF1SVZzTVBHT1ZpRWMxMS9GVEk0UGd0cEhFUHBzRzVW?=
 =?utf-8?B?QWEraDJGRXFvS3U0UUFrem9TQzVPMHNrajQ5VWRhR1g3bi9xbzlWVUdjNG9t?=
 =?utf-8?B?VmxXaUEwRm00M3BlTEozV2VMR1p2N3QwWG5haTJJWFVaVVcyVDh0UEVETlg2?=
 =?utf-8?B?bUh5MmhoVXo4Z0JPdGV0VSt4VWJpUjRJTjdMWC9INTZBQmZRcVpwdEl4WDF4?=
 =?utf-8?B?RXJBZVNLTUZtTmtTQ3g1NktlNWpKd1hqb3RQZ0FTdkNDd2V3d1JSL1J0dVln?=
 =?utf-8?B?bjFzZVl4OWVVRzJOVXc5T0I4cjRMay9FYkFqUytnWFZqMEZRR0dSUWptSjg0?=
 =?utf-8?B?UVJNNGpaZXRUOTlpZ0FXenlhaW82TjNlTU1WdDUzOFZkVHlBemhBS0xpeWZW?=
 =?utf-8?B?anRNMUhGKy9RSkdSM1BRblQ3VDZ6OEFhais3SkY4UnVQRFRvQVVjOUlTNVpy?=
 =?utf-8?B?YVNjUG5aRmhtSHI5RVBheHJBOU11U0VOL0hiczlIZC80U3BNVmJEVmY0SnFj?=
 =?utf-8?B?OGcxUkVJa2tXMmxjT1RJMWtrRzdYMmljeHhiRjM4NjR3MVZHWFVtUTNtcWdC?=
 =?utf-8?B?cyttS2FyVFc2T0pRbEptZEt1Wlg5V1BvOG9QRlhKbHNKNEhXQSswbTQ4dnFy?=
 =?utf-8?B?MmZZUXJiRXJ3VUUveXRnN2RtSlZzSGVxeDczMTJxRXJWYk5xNEYvYUtiaG1i?=
 =?utf-8?B?czlmc3Nncy81RkEycERRV3pBWVo1YTNGV2VlaVQ1TXdZdVpLdFJMc0Yya0g2?=
 =?utf-8?B?SUFhTmlNTXovdEYraWtwRFVpeUFLQWpHbldwanc1N054ZjVPQ2xPdlFxcWI1?=
 =?utf-8?B?cXhiNE9VeVA4RUVkLzR5Uk40UThacVh0UUx1MzJrR0lXVmtrUGcxbWlwdG9S?=
 =?utf-8?B?dXFjdSsxYnNCUTlIQUpHVlZTSG43Q0NiWUltOUFiTGp2TjlxTG11ckZzZm41?=
 =?utf-8?B?cjZoVzVhWU5IVUkzQVo0SjFnOTh0VkV4MmV1ZUZRTndtWnN3bSt4YlpPbDdi?=
 =?utf-8?B?bytBNFJVVzRXWHBnNEVuTVVoR2VJamU3NXE4Smx5WWM2aFNEVFNxUFlVL0Zx?=
 =?utf-8?B?azlZYUxKUnFLS2xzbnFnL1IrRGc5dWxWSmdDU2tMa2JXUGt5bFd1dzExNXBV?=
 =?utf-8?B?c0lvT3NjMWUxMytNYTY2SzVpcExLK0FPek1SdnhPbEJva2JPL29ub0RZMVlT?=
 =?utf-8?Q?hYVRvIHVuRCVd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b5bdbe-f763-42b4-e166-08d91a270ef6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 18:02:10.9631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAhupbvRbiSQGncRkk0pU+oKEZbArdTvo9Jplq1MDYikIK9Dr2khvCS2nUO9UQ8u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4607
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 helgaas@kernel.org, Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTguMDUuMjEgdW0gMTk6NDMgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPiBPbiAyMDIx
LTA1LTE4IDEyOjMzIHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDE4LjA1LjIx
IHVtIDE4OjE3IHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+Pgo+Pj4KPj4+IE9uIDIwMjEt
MDUtMTggMTE6MTUgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+PiBBbSAxOC4wNS4y
MSB1bSAxNzowMyBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Pj4+Pgo+Pj4+PiBPbiAyMDIx
LTA1LTE4IDEwOjA3IGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Pj4+PiBJbiBhIHNl
cGFyYXRlIGRpc2N1c3Npb24gd2l0aCBEYW5pZWwgd2Ugb25jZSBtb3JlIGl0ZXJhdGVkIG92ZXIg
Cj4+Pj4+PiB0aGUgZG1hX3Jlc3YgcmVxdWlyZW1lbnRzIGFuZCBJIGNhbWUgdG8gdGhlIGNvbmNs
dXNpb24gdGhhdCB0aGlzIAo+Pj4+Pj4gYXBwcm9hY2ggaGVyZSB3b24ndCB3b3JrIHJlbGlhYmxl
Lgo+Pj4+Pj4KPj4+Pj4+IFRoZSBwcm9ibGVtIGlzIGFzIGZvbGxvd2luZzoKPj4+Pj4+IDEuIGRl
dmljZSBBIHNjaGVkdWxlcyBzb21lIHJlbmRlcmluZyB3aXRoIGludG8gYSBidWZmZXIgYW5kIAo+
Pj4+Pj4gZXhwb3J0cyBpdCBhcyBETUEtYnVmLgo+Pj4+Pj4gMi4gZGV2aWNlIEIgaW1wb3J0cyB0
aGUgRE1BLWJ1ZiBhbmQgd2FudHMgdG8gY29uc3VtZSB0aGUgCj4+Pj4+PiByZW5kZXJpbmcsIGZv
ciB0aGUgdGhlIGZlbmNlIG9mIGRldmljZSBBIGlzIHJlcGxhY2VkIHdpdGggYSBuZXcgCj4+Pj4+
PiBvcGVyYXRpb24uCj4+Pj4+PiAzLiBkZXZpY2UgQiBpcyBob3QgcGx1Z2dlZCBhbmQgdGhlIG5l
dyBvcGVyYXRpb24gY2FuY2VsZWQvbmV3ZXIgCj4+Pj4+PiBzY2hlZHVsZWQuCj4+Pj4+Pgo+Pj4+
Pj4gVGhlIHByb2JsZW0gaXMgbm93IHRoYXQgd2UgY2FuJ3QgZG8gdGhpcyBzaW5jZSB0aGUgb3Bl
cmF0aW9uIG9mIAo+Pj4+Pj4gZGV2aWNlIEEgaXMgc3RpbGwgcnVubmluZyBhbmQgYnkgc2lnbmFs
aW5nIG91ciBmZW5jZXMgd2UgcnVuIGludG8gCj4+Pj4+PiB0aGUgcHJvYmxlbSBvZiBwb3RlbnRp
YWwgbWVtb3J5IGNvcnJ1cHRpb24uCj4+Pgo+Pj4gQnkgc2lnbmFsaW5nIHNfZmVuY2UtPmZpbmlz
aGVkIG9mIHRoZSBjYW5jZWxlZCBvcGVyYXRpb24gZnJvbSB0aGUKPj4+IHJlbW92ZWQgZGV2aWNl
IEIgd2UgaW4gZmFjdCBjYXVzZSBtZW1vcnkgY29ycnVwdGlvbiBmb3IgdGhlIHVuY29tcGxldGVk
Cj4+PiBqb2Igc3RpbGwgcnVubmluZyBvbiBkZXZpY2UgQSA/IEJlY2F1c2UgdGhlcmUgaXMgc29t
ZW9uZSB3YWl0aW5nIHRvCj4+PiByZWFkIHdyaXRlIGZyb20gdGhlIGltcG9ydGVkIGJ1ZmZlciBv
biBkZXZpY2UgQiBhbmQgaGUgb25seSB3YWl0cyBmb3IKPj4+IHRoZSBzX2ZlbmNlLT5maW5pc2hl
ZCBvZiBkZXZpY2UgQiB3ZSBzaWduYWxlZAo+Pj4gaW4gZHJtX3NjaGVkX2VudGl0eV9raWxsX2pv
YnMgPwo+Pgo+PiBFeGFjdGx5IHRoYXQsIHllcy4KPj4KPj4gSW4gb3RoZXIgd29yZHMgd2hlbiB5
b3UgaGF2ZSBhIGRlcGVuZGVuY3kgY2hhaW4gbGlrZSBBLT5CLT5DIHRoZW4gCj4+IG1lbW9yeSBt
YW5hZ2VtZW50IG9ubHkgd2FpdHMgZm9yIEMgYmVmb3JlIGZyZWVpbmcgdXAgdGhlIG1lbW9yeSBm
b3IgCj4+IGV4YW1wbGUuCj4+Cj4+IFdoZW4gQyBub3cgc2lnbmFsZWQgYmVjYXVzZSB0aGUgZGV2
aWNlIGlzIGhvdC1wbHVnZ2VkIGJlZm9yZSBBIG9yIEIgCj4+IGFyZSBmaW5pc2hlZCB0aGV5IGFy
ZSBlc3NlbnRpYWxseSBhY2Nlc3NpbmcgZnJlZWQgdXAgbWVtb3J5Lgo+Cj4gQnV0IGRpZG4ndCBD
IGltcG9ydGVkIHRoZSBCTyBmb3JtIEIgb3IgQSBpbiB0aGlzIGNhc2UgPyBXaHkgd291bGQgaGUg
YmUKPiB0aGUgb25lIHJlbGVhc2luZyB0aGF0IG1lbW9yeSA/IEhlIHdvdWxkIGJlIGp1c3QgZHJv
cHBpbmcgaGlzIHJlZmVyZW5jZQo+IHRvIHRoZSBCTywgbm8gPwoKV2VsbCBmcmVlaW5nIHRoZSBt
ZW1vcnkgd2FzIGp1c3QgYW4gZXhhbXBsZS4gVGhlIEJPIGNvdWxkIGFsc28gbW92ZSBiYWNrIAp0
byBWUkFNIGJlY2F1c2Ugb2YgdGhlIGRyb3BwZWQgcmVmZXJlbmNlLgoKPiBBbHNvIGluIHRoZSBn
ZW5lcmFsIGNhc2UsCj4gZHJtX3NjaGVkX2VudGl0eV9maW5pLT5kcm1fc2NoZWRfZW50aXR5X2tp
bGxfam9icyB3aGljaCBpcwo+IHRoZSBvbmUgd2hvIHNpZ25hbHMgdGhlICdDJyBmZW5jZSB3aXRo
IGVycm9yIGNvZGUgYXJlIGFzIGZhcgo+IGFzIEkgbG9va2VkIGNhbGxlZCBmcm9tIHdoZW4gdGhl
IHVzZXIgb2YgdGhhdCBCTyBpcyBzdG9wcGluZwo+IHRoZSB1c2FnZSBhbnl3YXkgKGUuZy4gZHJt
X2RyaXZlci5wb3N0Y2xvc2UgY2FsbGJhY2sgZm9yIHdoZW4gdXNlCj4gcHJvY2VzcyBjbG9zZXMg
aGlzIGRldmljZSBmaWxlKSB3aG8gd291bGQgdGhlbiBhY2Nlc3MgYW5kIGNvcnJ1cHQKPiB0aGUg
ZXhwb3J0ZWQgbWVtb3J5IG9uIGRldmljZSBBIHdoZXJlIHRoZSBqb2IgaGFzbid0IGNvbXBsZXRl
ZCB5ZXQgPwoKS2V5IHBvaW50IGlzIHRoYXQgbWVtb3J5IG1hbmFnZW1lbnQgb25seSB3YWl0cyBm
b3IgdGhlIGxhc3QgYWRkZWQgZmVuY2UsIAp0aGF0IGlzIHRoZSBkZXNpZ24gb2YgdGhlIGRtYV9y
ZXN2IG9iamVjdC4gSG93IHRoYXQgaGFwcGVucyBpcyBpcnJlbGV2YW50LgoKQmVjYXVzZSBvZiB0
aGlzIHdlIGF0IGxlYXN0IG5lZWQgdG8gd2FpdCBmb3IgYWxsIGRlcGVuZGVuY2llcyBvZiB0aGUg
am9iIApiZWZvcmUgc2lnbmFsaW5nIHRoZSBmZW5jZSwgZXZlbiBpZiB3ZSBjYW5jZWwgdGhlIGpv
YiBmb3Igc29tZSByZWFzb24uCgpDaHJpc3RpYW4uCgo+Cj4gQW5kcmV5Cj4KPj4KPj4gQ2hyaXN0
aWFuLgo+Pgo+Pj4KPj4+IEFuZHJleQo+Pj4KPj4+Pj4KPj4+Pj4KPj4+Pj4gSSBhbSBub3Qgc3Vy
ZSB0aGlzIHByb2JsZW0geW91IGRlc2NyaWJlIGFib3ZlIGlzIHJlbGF0ZWQgdG8gdGhpcyAKPj4+
Pj4gcGF0Y2guCj4+Pj4KPj4+PiBXZWxsIGl0IGlzIGtpbmQgb2YgcmVsYXRlZC4KPj4+Pgo+Pj4+
PiBIZXJlIHdlIHB1cmVseSBleHBhbmQgdGhlIGNyaXRlcmlhIGZvciB3aGVuIHNjaGVkX2VudGl0
eSBpcwo+Pj4+PiBjb25zaWRlcmVkIGlkbGUgaW4gb3JkZXIgdG8gcHJldmVudCBhIGhhbmcgb24g
ZGV2aWNlIHJlbW92ZS4KPj4+Pgo+Pj4+IEFuZCBleGFjdGx5IHRoYXQgaXMgcHJvYmxlbWF0aWMu
IFNlZSB0aGUgam9icyBvbiB0aGUgZW50aXR5IG5lZWQgdG8gCj4+Pj4gY2xlYW5seSB3YWl0IGZv
ciB0aGVpciBkZXBlbmRlbmNpZXMgYmVmb3JlIHRoZXkgY2FuIGJlIGNvbXBsZXRlZC4KPj4+Pgo+
Pj4+IGRybV9zY2hlZF9lbnRpdHlfa2lsbF9qb2JzKCkgaXMgYWxzbyBub3QgaGFuZGxpbmcgdGhh
dCBjb3JyZWN0bHkgYXQgCj4+Pj4gdGhlIG1vbWVudCwgd2Ugb25seSB3YWl0IGZvciB0aGUgbGFz
dCBzY2hlZHVsZWQgZmVuY2UgYnV0IG5vdCBmb3IgCj4+Pj4gdGhlIGRlcGVuZGVuY2llcyBvZiB0
aGUgam9iLgo+Pj4+Cj4+Pj4+IFdlcmUgeW91IGFkZHJlc3NpbmcgdGhlIHBhdGNoIGZyb20geWVz
dGVyZGF5IGluIHdoaWNoIHlvdSBjb21tZW50ZWQKPj4+Pj4gdGhhdCB5b3UgZm91bmQgYSBwcm9i
bGVtIHdpdGggaG93IHdlIGZpbmlzaCBmZW5jZXMgPyBJdCB3YXMKPj4+Pj4gJ1tQQVRDSCB2NyAx
Mi8xNl0gZHJtL2FtZGdwdTogRml4IGhhbmcgb24gZGV2aWNlIHJlbW92YWwuJwo+Pj4+Pgo+Pj4+
PiBBbHNvLCBpbiB0aGUgcGF0Y2ggc2VyaWVzIGFzIGl0IGlzIG5vdyB3ZSBvbmx5IHNpZ25hbCBI
VyBmZW5jZXMgCj4+Pj4+IGZvciB0aGUKPj4+Pj4gZXh0cmFjdGVkIGRldmljZSBCLCB3ZSBhcmUg
bm90IHRvdWNoaW5nIGFueSBvdGhlciBmZW5jZXMuIEluIGZhY3QgCj4+Pj4+IGFzIHlvdQo+Pj4+
PiBtYXkgcmVtZW1iZXIsIEkgZHJvcHBlZCBhbGwgbmV3IGxvZ2ljIHRvIGZvcmNpbmcgZmVuY2Ug
Y29tcGxldGlvbiBpbgo+Pj4+PiB0aGlzIHBhdGNoIHNlcmllcyBhbmQgb25seSBjYWxsIGFtZGdw
dV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxldGlvbgo+Pj4+PiBmb3IgdGhlIEhXIGZlbmNlcyBv
ZiB0aGUgZXh0cmFjdGVkIGRldmljZSBhcyBpdCdzIGRvbmUgdG9kYXkgYW55d2F5Lgo+Pj4+Cj4+
Pj4gU2lnbmFsaW5nIGhhcmR3YXJlIGZlbmNlcyBpcyB1bnByb2JsZW1hdGljIHNpbmNlIHRoZXkg
YXJlIGVtaXR0ZWQgCj4+Pj4gd2hlbiB0aGUgc29mdHdhcmUgc2NoZWR1bGluZyBpcyBhbHJlYWR5
IGNvbXBsZXRlZC4KPj4+Pgo+Pj4+IENocmlzdGlhbi4KPj4+Pgo+Pj4+Pgo+Pj4+PiBBbmRyZXkK
Pj4+Pj4KPj4+Pj4+Cj4+Pj4+PiBOb3Qgc3VyZSBob3cgdG8gaGFuZGxlIHRoYXQgY2FzZS4gT25l
IHBvc3NpYmlsaXR5IHdvdWxkIGJlIHRvIAo+Pj4+Pj4gd2FpdCBmb3IgYWxsIGRlcGVuZGVuY2ll
cyBvZiB1bnNjaGVkdWxlZCBqb2JzIGJlZm9yZSBzaWduYWxpbmcgCj4+Pj4+PiB0aGVpciBmZW5j
ZXMgYXMgY2FuY2VsZWQuCj4+Pj4+Pgo+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4KPj4+Pj4+IEFt
IDEyLjA1LjIxIHVtIDE2OjI2IHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+Pj4+Pj4gUHJv
YmxlbTogSWYgc2NoZWR1bGVyIGlzIGFscmVhZHkgc3RvcHBlZCBieSB0aGUgdGltZSBzY2hlZF9l
bnRpdHkKPj4+Pj4+PiBpcyByZWxlYXNlZCBhbmQgZW50aXR5J3Mgam9iX3F1ZXVlIG5vdCBlbXB0
eSBJIGVuY291bnRyZWQKPj4+Pj4+PiBhIGhhbmcgaW4gZHJtX3NjaGVkX2VudGl0eV9mbHVzaC4g
VGhpcyBpcyBiZWNhdXNlIAo+Pj4+Pj4+IGRybV9zY2hlZF9lbnRpdHlfaXNfaWRsZQo+Pj4+Pj4+
IG5ldmVyIGJlY29tZXMgZmFsc2UuCj4+Pj4+Pj4KPj4+Pj4+PiBGaXg6IEluIGRybV9zY2hlZF9m
aW5pIGRldGFjaCBhbGwgc2NoZWRfZW50aXRpZXMgZnJvbSB0aGUKPj4+Pj4+PiBzY2hlZHVsZXIn
cyBydW4gcXVldWVzLiBUaGlzIHdpbGwgc2F0aXNmeSBkcm1fc2NoZWRfZW50aXR5X2lzX2lkbGUu
Cj4+Pj4+Pj4gQWxzbyB3YWtldXAgYWxsIHRob3NlIHByb2Nlc3NlcyBzdHVjayBpbiBzY2hlZF9l
bnRpdHkgZmx1c2hpbmcKPj4+Pj4+PiBhcyB0aGUgc2NoZWR1bGVyIG1haW4gdGhyZWFkIHdoaWNo
IHdha2VzIHRoZW0gdXAgaXMgc3RvcHBlZCBieSBub3cuCj4+Pj4+Pj4KPj4+Pj4+PiB2MjoKPj4+
Pj4+PiBSZXZlcnNlIG9yZGVyIG9mIGRybV9zY2hlZF9ycV9yZW1vdmVfZW50aXR5IGFuZCBtYXJr
aW5nCj4+Pj4+Pj4gc19lbnRpdHkgYXMgc3RvcHBlZCB0byBwcmV2ZW50IHJlaW5zZXJpb24gYmFj
ayB0byBycSBkdWUKPj4+Pj4+PiB0byByYWNlLgo+Pj4+Pj4+Cj4+Pj4+Pj4gdjM6Cj4+Pj4+Pj4g
RHJvcCBkcm1fc2NoZWRfcnFfcmVtb3ZlX2VudGl0eSwgb25seSBtb2RpZnkgZW50aXR5LT5zdG9w
cGVkCj4+Pj4+Pj4gYW5kIGNoZWNrIGZvciBpdCBpbiBkcm1fc2NoZWRfZW50aXR5X2lzX2lkbGUK
Pj4+Pj4+Pgo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXku
Z3JvZHpvdnNreUBhbWQuY29tPgo+Pj4+Pj4+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+Pj4+Pj4gLS0tCj4+Pj4+Pj4gwqAgZHJpdmVy
cy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYyB8wqAgMyArKy0KPj4+Pj4+PiDCoCBk
cml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uY8KgwqAgfCAyNCAKPj4+Pj4+PiAr
KysrKysrKysrKysrKysrKysrKysrKysKPj4+Pj4+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDI2IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4+Pj4+Pgo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jIAo+Pj4+Pj4+IGIvZHJpdmVy
cy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+Pj4+Pj4+IGluZGV4IDAyNDljNzQ1
MDE4OC4uMmU5M2U4ODFiNjVmIDEwMDY0NAo+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9z
Y2hlZHVsZXIvc2NoZWRfZW50aXR5LmMKPj4+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vc2No
ZWR1bGVyL3NjaGVkX2VudGl0eS5jCj4+Pj4+Pj4gQEAgLTExNiw3ICsxMTYsOCBAQCBzdGF0aWMg
Ym9vbCBkcm1fc2NoZWRfZW50aXR5X2lzX2lkbGUoc3RydWN0IAo+Pj4+Pj4+IGRybV9zY2hlZF9l
bnRpdHkgKmVudGl0eSkKPj4+Pj4+PiDCoMKgwqDCoMKgIHJtYigpOyAvKiBmb3IgbGlzdF9lbXB0
eSB0byB3b3JrIHdpdGhvdXQgbG9jayAqLwo+Pj4+Pj4+IMKgwqDCoMKgwqAgaWYgKGxpc3RfZW1w
dHkoJmVudGl0eS0+bGlzdCkgfHwKPj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgc3BzY19xdWV1ZV9j
b3VudCgmZW50aXR5LT5qb2JfcXVldWUpID09IDApCj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHNw
c2NfcXVldWVfY291bnQoJmVudGl0eS0+am9iX3F1ZXVlKSA9PSAwIHx8Cj4+Pj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIGVudGl0eS0+c3RvcHBlZCkKPj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIHRydWU7Cj4+Pj4+Pj4gwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7Cj4+Pj4+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jIAo+Pj4+Pj4+IGIv
ZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKPj4+Pj4+PiBpbmRleCA4ZDEy
MTFlODcxMDEuLmEyYTk1MzY5M2I0NSAxMDA2NDQKPj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYwo+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9z
Y2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4+Pj4+Pj4gQEAgLTg5OCw5ICs4OTgsMzMgQEAgRVhQT1JU
X1NZTUJPTChkcm1fc2NoZWRfaW5pdCk7Cj4+Pj4+Pj4gwqDCoCAqLwo+Pj4+Pj4+IMKgIHZvaWQg
ZHJtX3NjaGVkX2Zpbmkoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCkKPj4+Pj4+PiDC
oCB7Cj4+Pj4+Pj4gK8KgwqDCoCBzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSAqc19lbnRpdHk7Cj4+
Pj4+Pj4gK8KgwqDCoCBpbnQgaTsKPj4+Pj4+PiArCj4+Pj4+Pj4gwqDCoMKgwqDCoCBpZiAoc2No
ZWQtPnRocmVhZCkKPj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAga3RocmVhZF9zdG9wKHNjaGVk
LT50aHJlYWQpOwo+Pj4+Pj4+ICvCoMKgwqAgZm9yIChpID0gRFJNX1NDSEVEX1BSSU9SSVRZX0NP
VU5UIC0gMTsgaSA+PSAKPj4+Pj4+PiBEUk1fU0NIRURfUFJJT1JJVFlfTUlOOyBpLS0pIHsKPj4+
Pj4+PiArwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRybV9zY2hlZF9ycSAqcnEgPSAmc2NoZWQtPnNj
aGVkX3JxW2ldOwo+Pj4+Pj4+ICsKPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCFycSkKPj4+
Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPj4+Pj4+PiArCj4+Pj4+Pj4g
K8KgwqDCoMKgwqDCoMKgIHNwaW5fbG9jaygmcnEtPmxvY2spOwo+Pj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoCBsaXN0X2Zvcl9lYWNoX2VudHJ5KHNfZW50aXR5LCAmcnEtPmVudGl0aWVzLCBsaXN0KQo+
Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qCj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAqIFByZXZlbnRzIHJlaW5zZXJ0aW9uIGFuZCBtYXJrcyBqb2JfcXVldWUgYXMg
aWRsZSwKPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogaXQgd2lsbCByZW1vdmVk
IGZyb20gcnEgaW4gZHJtX3NjaGVkX2VudGl0eV9maW5pCj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAqIGV2ZW50dWFsbHkKPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICovCj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc19lbnRpdHktPnN0b3BwZWQgPSB0
cnVlOwo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBzcGluX3VubG9jaygmcnEtPmxvY2spOwo+Pj4+
Pj4+ICsKPj4+Pj4+PiArwqDCoMKgIH0KPj4+Pj4+PiArCj4+Pj4+Pj4gK8KgwqDCoCAvKiBXYWtl
dXAgZXZlcnlvbmUgc3R1Y2sgaW4gZHJtX3NjaGVkX2VudGl0eV9mbHVzaCBmb3IgdGhpcyAKPj4+
Pj4+PiBzY2hlZHVsZXIgKi8KPj4+Pj4+PiArwqDCoMKgIHdha2VfdXBfYWxsKCZzY2hlZC0+am9i
X3NjaGVkdWxlZCk7Cj4+Pj4+Pj4gKwo+Pj4+Pj4+IMKgwqDCoMKgwqAgLyogQ29uZmlybSBubyB3
b3JrIGxlZnQgYmVoaW5kIGFjY2Vzc2luZyBkZXZpY2Ugc3RydWN0dXJlcyAqLwo+Pj4+Pj4+IGNh
bmNlbF9kZWxheWVkX3dvcmtfc3luYygmc2NoZWQtPndvcmtfdGRyKTsKPj4+Pj4+Cj4+Pj4KPj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
