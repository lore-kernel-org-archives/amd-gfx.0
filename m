Return-Path: <SRS0=P3OX=CR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35682C433E2
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2020 04:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77FD21532
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2020 04:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="t0mgMStI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77FD21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 416AD6E0AA;
	Tue,  8 Sep 2020 04:52:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FEC66E0AA
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2020 04:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUmA/ifeWuMKTAVvGFVlpxoRmeaKuclyF+8YjKA3OltgHlFy7ZDD3xLuAoQTxaP8Xy1qywDuUmhu7G4tWFNHBzgtWY2u34qP0klrqVvLeiUaXKmOC/WtF989+df682C0ttVz3L98zLugTcFV7XTsJU+R6o1/9uKpt9R7dTMDdlckEedrZF7qIa3nsNLdomELHIyVuRHJpvtVn5xZXne33RQO6BXsmcOlU7pZWq7fUx1buvUWOmMHeB1gYAD/ZugNQqpvkakqXmlH9D3g6aVqHw3Mhahm8RMQaofhUo6+jlpQF+iETnSmEe5Tt0Rw+1ZkVjF1+LbOR6gV0BicQJrJWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23Qfpn7mgL9TOyl+F7IU85/1bGXORF1HkogbYQdWt/E=;
 b=BcYKibutY6jQcpuIJweh8YMxioQa3SK7cEWJ7lo0NoRwSFHOUyYSe1Kbk1out8rdcO5zDICaqtfRLCq+AuNqsFDsynEBdH5RzRS3valOIEo5fzvxMrl/gsJoTeqVRR5YL8lqsN7NbjxfuwsIyR2EEwq9N0Y0BYJj1w2yOQgiDCS3mWN/MKxYjHWNiOs4G+9ryyDv57w+azwVfZyUmELhnz+peIsEEcxgkCKC/Xd42uhXzQRShtMBMLv0p4hyZlC4FlvA+68c+W5I/uuHIbycw415+UOuwNF87Yd6eTj0d12mtHz4/cNdAqtjcM5heSgTLB6WT67KT730IhdlKs2u+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23Qfpn7mgL9TOyl+F7IU85/1bGXORF1HkogbYQdWt/E=;
 b=t0mgMStIp9cKJZ9OoAaVFtW1G2c9gEQSGufG+6TTcMI1qEtddrBWj/60hmfU1X1bz1PAJDc+IP4AxW2JTHEY4M/ZWLTr0jpN1EOsQZhI+UVnxcrx670WZifLCehwhcQaK7M13P255HKyF99fGPM7+cENz20I5WGmSfOaNkyxSu8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN6PR12MB2768.namprd12.prod.outlook.com (2603:10b6:805:72::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.19; Tue, 8 Sep
 2020 04:52:41 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3370.016; Tue, 8 Sep 2020
 04:52:41 +0000
Subject: Re: [PATCH] drm/amdgpu: enable ih1 ih2 for Arcturus only
To: Matt Coffin <mcoffin13@gmail.com>, christian.koenig@amd.com,
 Alex Deucher <alexdeucher@gmail.com>, Alex Sierra <alex.sierra@amd.com>
References: <20200902170118.30751-1-alex.sierra@amd.com>
 <CADnq5_NRFr5vYfuwgMHQ5Y+19_UqXPoJYomBkwGMoWkvjpA_Fw@mail.gmail.com>
 <CADnq5_MFC=r=NxhzZ2OmO7EaodZXtGDQxgqw2146DGQoioShwA@mail.gmail.com>
 <2ea7e8e2-8a96-8006-a5ee-41ebfecbf6f1@amd.com>
 <edce428d-eb18-23d3-418a-be720c5b227c@gmail.com>
 <e6734f67-8b70-26f4-3847-109ed8e61c77@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <aefa90e6-0a2d-3a8c-7ff8-c69cd9b6f46e@amd.com>
Date: Tue, 8 Sep 2020 00:52:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <e6734f67-8b70-26f4-3847-109ed8e61c77@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::36) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.113.11) by
 YTOPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend
 Transport; Tue, 8 Sep 2020 04:52:41 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8733c24c-6f96-4aaa-6ae6-08d853b304a4
X-MS-TrafficTypeDiagnostic: SN6PR12MB2768:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2768DD4FE721C1EF7EE6AD8192290@SN6PR12MB2768.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: quZdNiNEm7r86drL/xHiwnVROtNhNRmKBNqw77w+srgfc6rFyJ05WIls9eLMIi9zKWWmAbiw+bjh0FuabRFMkhSzgjdDkpu87xKLROrWbJ3Zthp7sGRWBbnKILGXDyy2jl64irvYRYjV1t0kG7Nlt8qzPbyhZwiQOx7ZMVFKgAzYsFYs19gQ/PsvmqSAfmj3LezZymU+6r6xGRJ48QYpSn5IODE8xleoTrJTD066uLsvY40l5Db8TLoex4EU2AfhjGtAJl/hmb6ZmNWsTnSqS0FYIMUDOfaVnkCALZ+/SmKzJ24OXuaZUESA6IErigcuW2CcAejheOzmqpLZAv1BPboTwCid1EXSfqL8KAqGvqeKbAYYeDs7YttAMfb10VrE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(44832011)(66556008)(31686004)(5660300002)(4326008)(86362001)(31696002)(52116002)(8936002)(316002)(478600001)(110136005)(16526019)(26005)(186003)(956004)(53546011)(2616005)(8676002)(16576012)(36756003)(6486002)(66946007)(66476007)(2906002)(66574015)(6636002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Pot+ExD5rNHJIi5farhgwo/edN2Div6L9kZginj+Its5AdWFViphUFrX4yBnQHB1fNzV8NYLZOiNTkwrFUIUVtOAQswTMz5VxxzFKrP+1TYfDgbLQdOVZ6hzzvSW+Zk0jlB9rxz9svNpCAQdOzdp4V99bwlll1vSJW34Yq03H2ah6JDx7vEL6sPXvcK5Otb1WEAGJA+nI9xVQgfx06M1rlr1Jt625421BwFET66uz3TV7psBNNJuPCSUlVIxUALnxXWXjbpb9nPkInY0vqNRJUgmFS3iZcqDXVivupaLsKEb9JCwMwiNsjgUde6Z5i8hc8NzRatry5x2PkiHoicO3V8I/X4tWJMUMm+/1YjYOsiHAmb9s+xxZhJC5u8YJseM8F72cSDm7PlTJK8cD7CtZeywzV8cbnoGhPAiFKlbkhp0GXDYn959q8ySQ4FSntKwA/zv1AKK1ncWe22DMLB8F3C6pqD4Y01qfAAmp7seN+bqnbUDT3D9kTnVGnNjGq09yaFofwL6w0egMGACWjz3ei4Hui29Yf783ahO+2GWBuApNYPH4FG89a/EbJ8P9wqHqUYRD1y7pBgZRg96Cp1Sl+NCCmXlZyqnE/tsb+R7XTW6gKbxoI73O/ZVafyGtzodf/e+rbQ6OZw+9QaWgvaE2g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8733c24c-6f96-4aaa-6ae6-08d853b304a4
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 04:52:41.6879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: prhxI+stQSDfZd1qa4VOKB06DcIjE4mXM7JrFyg/QeUEb7pI2QwGvoWQrrIZWDJICyy3SMHvPC6PP31u/uTC1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2768
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMC0wOS0wNyB1bSAxOjAwIGEubS4gc2NocmllYiBNYXR0IENvZmZpbjoKCj4gSGVsbG8g
YWxsLAo+Cj4KPgo+IFRob3VnaHQgSSdkIGNoaW1lIGluIGhlcmUuIFdoaWxlIEkgY2FuJ3Qgc3Bl
YWsgdG8gdGhlIGlzc3VlIHRoZSBHaXRMYWIKPiByZXBvcnRlciB3YXMgZXhwZXJpZW5jaW5nLCBJ
IGNhbiBzYXkgdGhhdCBJIGdldCBzb21lIHBlcmZvcm1hbmNlIGhpdAo+IChleHBlY3RlZCkgZnJv
bSB0aGlzIHdoZW4gdXNpbmcgbXVsdGlwbGUgbW9uaXRvcnMgd2l0aCBEUklfUFJJTUUuIFdoZW4K
PiB0aGUgc2Vjb25kIG1vbml0b3IgaXMgYWN0aXZlICh3aXRoIHNvbWV0aGluZyByZW5kZXJpbmcg
dG8gaXQgd2l0aAo+IHJlbGF0aXZlIGZyZXF1ZW5jeSksIHRoZW4gSSBzZWUgYSBkZWNlbnQgcGVy
Zm9ybWFuY2UgZHJvcCBpbgo+IGFwcGxpY2F0aW9ucyBydW5uaW5nIG9uIG15IHByaW1hcnkgbW9u
aXRvciBjb21wYXJlZCB0byBiZWZvcmUgdGhpcy4KClRvIGJlIGNsZWFyLCBhcmUgeW91IHNlZWlu
ZyBhIHBlcmZvcm1hbmNlIGRyb3AgZnJvbSB0aGlzIHBhcnRpYWwgcmV2ZXJ0LApvciBmcm9tIHRo
ZSBvcmlnaW5hbCBjaGFuZ2UgdGhhdCBlbmFibGVkIGloMSBhbmQgaWgyPwoKSSB3b3VsZCBub3Qg
ZXhwZWN0IHRoaXMgY2hhbmdlIHRvIGFmZmVjdCBwZXJmb3JtYW5jZSBmb3IgYW55dGhpbmcgb3Ro
ZXIKdGhhbiBwYWdlIGZhdWx0IGludGVycnVwdCBoYW5kbGluZy4gWW91IHNob3VsZCBub3QgYmUg
c2VlaW5nIEdQVSBwYWdlCmZhdWx0IGludGVycnVwdHMgd2hpbGUgcnVubmluZyBncmFwaGljcyBh
cHBsaWNhdGlvbnMuCgpSZWdhcmRzLArCoCBGZWxpeAoKCj4KPgo+Cj4gV2hpbGUgdGhpcyBpcyBw
cm9iYWJseSBleHBlY3RlZCwgYW5kIGltcGVyY2VwdGlibGUgdG8gdGhlIHN0YW5kYXJkIHVzZXIs
Cj4gSSB0aG91Z2h0IEknZCBhdCBsZWFzdCBtZW50aW9uIGl0IGluIGFuIGVmZm9ydCB0byBrZWVw
IGNvbnRyaWJ1dGluZy4KPgo+Cj4KPiBUaGFua3MgZm9yIHRoZSBjb250aW51ZWQgb3BlbiBzb3Vy
Y2Ugd29yay4gWW91IGFsbCBtYWtlIG15IGxpZmUuCj4KPgo+Cj4gQ2hlZXJzLAo+Cj4gTWF0dAo+
Cj4gT24gOS8zLzIwIDI6MDUgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFtIDAyLjA5
LjIwIHVtIDIwOjI4IHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+PiBBbSAyMDIwLTA5LTAyIHVt
IDI6MTMgcC5tLiBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPj4+PiBPbiBXZWQsIFNlcCAyLCAyMDIw
IGF0IDI6MDggUE0gQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+Cj4+IEkgdGhp
bmsgd2Ugc2hvdWxkIGZ1cnRoZXIgaW52ZXN0aWdhdGUgdGhpcyBiZWZvcmUgYXBwbHlpbmcgYW55
IHBhdGNoZXMuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
