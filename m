Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0D2C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 09:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F8B619B2
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 09:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F8B619B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75B886E85C;
	Tue, 23 Mar 2021 09:09:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C7F76E85C
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 09:09:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mr5lqpVJ7L3CTSAkUI49MhPnfTKXbcubCqj1M2FaCzljyplyEw/fAHxMdGUCQK4G38OuU16nR4MIWy1Q7PeuNeZh4Ani6Lyf+LXDU8X3NyZRtPu2Bn+5aaPBwg9GvwuQkRCBht1WgakgOZ9uYqODomp1PwgU+4LBGg6cGptL6LNb+Qz1qzCP6HqKpFQ4gDMgnUBq0JhQltZDYT3kgat8eNsT8XH/ic1p/Qn/g0xrRtmdltKIciy5ziMcj65GpgBqHeGZGU85AsAI6eGSG3XNTMSrJZlYRf3TGDGpMZvZHjNbkt4Qkt4Z4DScrgzqI2O93ZJGdxnOUErOgfOBhx8LkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWCB2aIB3BCLPSQQBLZvP02eSYYMrrz7SWtvaYuduYk=;
 b=HyBhOkBn8S5fPiq3lqzcUbQLQgSeR96BBFj33Zce9y4ic0RxBziYaTeVQowR64F86qW7SVU8h3avMxcBtVCzaUWmMAC7Rd/s2cOYxnrOcmWfUEN/gVLHpUNsUcq5ZOO7j0cRG3tIPbbnQqbxoi6xOgATBmhSh4j1r5LExS0XUCKxyYG3e/IgXuuZ+dmQnZ5/XbiW3xIbWQRpAzHpDlYmUGvLiHSTd6UhTP7xoU0r3gyuYr5fSD1v9+Lckehs/zHrSawnh2sw7u88fjDm76npjV7lprW7R1d0O0XJLyOVRyEzeE7jpHvo2SkSX31213kTwuvtIQVjewDLOfquTuvcng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWCB2aIB3BCLPSQQBLZvP02eSYYMrrz7SWtvaYuduYk=;
 b=1y0gRjpTEuR6oxRACGds3EFHRm7Gck4XGBGoCmaKrQAkegRuXz3hgpr+RwXPirHMn9CwhP77G4srxuHMTCB0t1I1tewV3DvEdpIbmjcR8wiHb/gMDc+2ngL1Gjw6M/grfteRz6SXtJBWEJtQ8HDdnNfD+iQnlbWyxixlZy7lVHk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1640.namprd12.prod.outlook.com (2603:10b6:910:11::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.25; Tue, 23 Mar
 2021 09:09:16 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 09:09:15 +0000
Subject: Re: [PATCH] drm/amdgpu: re-apply "use the new cursor in the VM code""
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210322124048.5546-1-christian.koenig@amd.com>
 <CY4PR12MB128713C420B53B7B796A5409F1659@CY4PR12MB1287.namprd12.prod.outlook.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <f9940d3b-6000-c963-0f3a-f4870a0c12e0@amd.com>
Date: Tue, 23 Mar 2021 10:09:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <CY4PR12MB128713C420B53B7B796A5409F1659@CY4PR12MB1287.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [217.86.110.215]
X-ClientProxiedBy: AM8P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::24) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.110.215) by
 AM8P189CA0019.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.24 via Frontend Transport; Tue, 23 Mar 2021 09:09:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c5bb52fc-dc40-4f19-b418-08d8eddb5530
X-MS-TrafficTypeDiagnostic: CY4PR12MB1640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB16407B3892CC349F36FAF8B68B649@CY4PR12MB1640.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Us3th1AYAA0+n+IHgnA2miavvRYGrUVsYvZ3zBzuU7VYyHhh6PbqthRpOapUoGo9BTaAL3Naxu2KNhcuE/P3DZotKCUz1BFUpYMb6sHHm89doH1G8om/zPA3xQlKDYQ8KlkQf51wvsr/0aXH0umxW9P56FuS/pJgoxE07Xak7xvlY8EFu8BDNf2V9msGi52dz7ii50w+X4qHW/AM+Zda0KcKP6wj+YqNu2n56ZIUEU5x92FiWyFGis4dSesaDj4Dw/i3wLLrWw9B77Kdd1JCsVyBt2QfZYQBEdkJiWHnU35d+nysf/I9c/qJLwpYg1qdIh9ybsblZnom6rZlyjZrpFwPbbyNl8mRNAkllIj6BxtwLeAQxcUt2dypFQVn7aK190Janyh57I86RcirOdZvnAmccU4EtotfsX4I/TDh/4ErISySB3Ya+2xsMsMwEWVkXLPQ1JDhgGkuwS2tnGdf5ncdSY3QmHYzr/eQpwcBSxZpCxviXDtgf/k91W+tKQav5ezLwzqJwvQ2spVt09huV4APiMzjWx5gtlQ7G+YEkf+jd6lN7X9Npw4relo3tvqV+Y1DMOwTGPav3emOhiQRsHUCFr1v+cvUmbmFnmBKT1o+IBmxNDsXJ8wimZEkpACdrdkd5ib8nReG2RN29vyIhStMC50xgZ87+n4SgzrKZjn022firTYgg63x6+rm2wX1E0BpGM7g8wn1Tq8VH0X5eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(31686004)(478600001)(6666004)(4326008)(6486002)(53546011)(5660300002)(956004)(8936002)(36756003)(186003)(2616005)(52116002)(16526019)(26005)(31696002)(2906002)(316002)(66476007)(38100700001)(66946007)(66556008)(16576012)(8676002)(110136005)(83380400001)(66574015)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SmxwYjJSay9xbVhBMmlONkVhUmdxWlgxcE5ZeVdac2NSQjRIcnpGdTJ4M3py?=
 =?utf-8?B?TXROTW9UTTFzd0o4L3ZyQlR2dy9kN3g5bncrdVQyaXd5UkRqbGN6dWtuMUI0?=
 =?utf-8?B?UTJRQ2RmQjN6RnArRDJBTTI1TUJPVmxoZU1YYzJ3R3lFa3RHZWE1UStubm1S?=
 =?utf-8?B?aTA5UUNmMG9aTmVTNW41UDhvL09xR1FZZE05U3ZCNCtaM0NkTlJpdFVMeU9L?=
 =?utf-8?B?OEpCREF3ZFA5YXpXL1dhYWhlUEpOdkFKVzdJbjFKUzRyYXJEdXR0Z0lpUk14?=
 =?utf-8?B?blRobjBMQUZlYlB6VnlUemtSczF6N1htcVR1WjNWVWtFeE5uWnEvUWxQbDBi?=
 =?utf-8?B?U1RQZytVeEJUOUVoQ0pTeHdaYnJhZkhsemsyREYrWURSUFF5cDhHb09sMlF6?=
 =?utf-8?B?d0krcURRVE5YOWJmNU1QVTgydnRETExWc2FyVFRhaVB4akZLM2NFQ2FpRS9Y?=
 =?utf-8?B?cVJGZVdOTnZwcytnOHFrdVYxLzlDbVZRdklCbVhIa0R1cHV0ZWtnRElVaEJS?=
 =?utf-8?B?YlY1NEw2Z0JMZXlpdUc1VGpJc3IrdTZueFVYcXU5UTMwbTltWjhFMWRTcUFi?=
 =?utf-8?B?QkNsdmxabkVucUpUY3lBaUtxRWtlcUZXY2kzYkpHby9TZXNvZ1paSjVKMm5z?=
 =?utf-8?B?ZDJCY3pvTFFrY0d1aXRWZVVCcXU2NW10ZzZYaEk0ZTBBSm82N0VmcWhKbnZh?=
 =?utf-8?B?WWtwUm9OSmpWS1pmejFFOCs0am04MUMyN3U5cVF3a2h5QnRzNTluU3lhbEZK?=
 =?utf-8?B?UTArNUl2R0RlbWxZcW9vcUxqOGlPelhTQnUzMmdyQTYyZmhETDNTUzU5SWRa?=
 =?utf-8?B?bnU4aWRzU3dEVFVCV3RHU3N1Zk43K0lUZjZpSXVSWm9xeDVYVlYvVTV0VUNV?=
 =?utf-8?B?ZmtmM3p2aXFRejlUY21uZUNMWnBoN1FGU1lqWHVPaEpmNkF0cHRKeEc3VmdI?=
 =?utf-8?B?KzgwT3hkcUQzV1p0d2Q4OGp2MmpZN0lURzNObitpTG9EUVRGKy9PQVBvK0ZC?=
 =?utf-8?B?TlJyN1I2TGJJUHllYjlNR3JLNzluUGxwdSsrUmdKemUwMTRsaWFpRkE2di9a?=
 =?utf-8?B?alFSYVJwTkpyemdUNGsrakx4N1pCQVU4ektZanNacExQZFo3bUsrdHBQNUtZ?=
 =?utf-8?B?aitqckI2R0NKTmEwbmxIdHk5QVVQVDVYekYrQ2I5cUYveng3MjlVNXJVTGYv?=
 =?utf-8?B?M1VZQ1hudDV2Vk5rRk9hbXo4bXQ4R1Qva0J1b2NTMUlZQVRJWFpoQmVqUnEv?=
 =?utf-8?B?cFRZQldsTnRROGREdVZpOFgvbWw2K0ltaHkzQUMzYmQzZWF5YXZiTUQrQ0NT?=
 =?utf-8?B?UHVnU1lWNm5WMjQycmk3ZmkvRU9ZaTIyVEl3UDAvdEQyOSt4T3N6VzA0RjR3?=
 =?utf-8?B?SmtSN01mekwxd3FrUFFXWUdZT1Z4ZWJPNnRsaHhUN2RHYTRuWFVad3JZRWlQ?=
 =?utf-8?B?Vmd3QzRMbHFSL1pkQmxGR1dTOWZMbFY4OEl0UGN3dEtYek9ITkY3RTZGQURC?=
 =?utf-8?B?VU4xSUZEdjZBcUZDS3QzWGEzSmJqYTl1WXRzV1h1NER2RFMyNVM1S1VGeENj?=
 =?utf-8?B?dVRGak9PZ2UzdmNNV0hXUzZleVpqUVBOb1d0QXJHcWNTdnpxaGtOamhWN0Ro?=
 =?utf-8?B?STdvQVBMeHpqOFZvekRzem9YVGN3ZmNqYzlxa0NQRDloREVSSUE0Z0FpbDNo?=
 =?utf-8?B?d200SDNZNE1ERkRMQnk3K1FsbUxOS2NDZmlPOXJRMkt5MWVTSlZ1Wm9Cc0do?=
 =?utf-8?Q?swOQb0SzRQu0ppGaZtYxnQBRZMPOT9M/aAoOk1h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5bb52fc-dc40-4f19-b418-08d8eddb5530
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 09:09:15.7450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKobPa3SKBs0f6RH3ndiqM9HTEyB4m0MYGaOJb80q0KISsEKOwoJpMKG4RseigRRULPnuIu7pczgDET6jEP/YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1640
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
Cc: "Das, Nirmoy" <Nirmoy.Das@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SSB0ZXN0ZWQgLi9waWdsaXQgcnVuIG9wZW5nbCByZXN1bHRzL3Rlc3QgbXVsdGlwbGUgdGltZXMu
IE9uY2UgSSBnb3QgZ2Z4IAp0aW1lIG91dAoKZXJyb3IgYnV0IHdpdGhvdXQga2VybmVsIGZyZWV6
ZS4gSSBjYW4ndCByZXByb2R1Y2UgaXQgYW55IG1vcmUuCgoKUmVnYXJkcywKCk5pcm1veQoKT24g
My8yMi8yMSAyOjExIFBNLCBDaGVuLCBHdWNodW4gd3JvdGU6Cj4gW0FNRCBQdWJsaWMgVXNlXQo+
Cj4gSGkgQ2hyaXN0aWFuLAo+Cj4gSSB3aWxsIGNvbmR1Y3Qgb25lIHN0cmVzcyB0ZXN0IGZvciB0
aGlzIHRvbW9ycm93LiBXb3VsZCB5b3UgbWluZCB3YWl0aW5nIGZvciBteSBhY2sgYmVmb3JlIHN1
Ym1pdHRpbmc/Cj4KPiBSZWdhcmRzLAo+IEd1Y2h1bgo+Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0KPiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdt
YWlsLmNvbT4KPiBTZW50OiBNb25kYXksIE1hcmNoIDIyLCAyMDIxIDg6NDEgUE0KPiBUbzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hl
bkBhbWQuY29tPjsgRGFzLCBOaXJtb3kgPE5pcm1veS5EYXNAYW1kLmNvbT4KPiBTdWJqZWN0OiBb
UEFUQ0hdIGRybS9hbWRncHU6IHJlLWFwcGx5ICJ1c2UgdGhlIG5ldyBjdXJzb3IgaW4gdGhlIFZN
IGNvZGUiIgo+Cj4gTm93IHRoYXQgd2UgZm91bmQgdGhlIHVuZGVybHlpbmcgcHJvYmxlbSB3ZSBj
YW4gcmUtYXBwbHkgdGhpcyBwYXRjaC4KPgo+IFRoaXMgcmV2ZXJ0cyBjb21taXQgODY3ZmVlN2Y4
ODIxZmY0MmU3MzA4MDg4Y2YwYzM0NTBhYzQ5YzE3Yy4KPgo+IFNpZ25lZC1vZmYtYnk6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgNTUgKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAzNyBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gaW5kZXggOTI2OGRi
MTE3MmJkLi5iYzM5NTFiNzEwNzkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uYwo+IEBAIC0zNyw2ICszNyw3IEBACj4gICAjaW5jbHVkZSAiYW1kZ3B1X2dtYy5oIgo+
ICAgI2luY2x1ZGUgImFtZGdwdV94Z21pLmgiCj4gICAjaW5jbHVkZSAiYW1kZ3B1X2RtYV9idWYu
aCIKPiArI2luY2x1ZGUgImFtZGdwdV9yZXNfY3Vyc29yLmgiCj4gICAKPiAgIC8qKgo+ICAgICog
RE9DOiBHUFVWTQo+IEBAIC0xNTgzLDcgKzE1ODQsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV91
cGRhdGVfcHRlcyhzdHJ1Y3QgYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnBhcmFtcywKPiAgICAq
IEBsYXN0OiBsYXN0IG1hcHBlZCBlbnRyeQo+ICAgICogQGZsYWdzOiBmbGFncyBmb3IgdGhlIGVu
dHJpZXMKPiAgICAqIEBvZmZzZXQ6IG9mZnNldCBpbnRvIG5vZGVzIGFuZCBwYWdlc19hZGRyCj4g
LSAqIEBub2RlczogYXJyYXkgb2YgZHJtX21tX25vZGVzIHdpdGggdGhlIE1DIGFkZHJlc3Nlcwo+
ICsgKiBAcmVzOiB0dG1fcmVzb3VyY2UgdG8gbWFwCj4gICAgKiBAcGFnZXNfYWRkcjogRE1BIGFk
ZHJlc3NlcyB0byB1c2UgZm9yIG1hcHBpbmcKPiAgICAqIEBmZW5jZTogb3B0aW9uYWwgcmVzdWx0
aW5nIGZlbmNlCj4gICAgKgo+IEBAIC0xNTk4LDEzICsxNTk5LDEzIEBAIHN0YXRpYyBpbnQgYW1k
Z3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAg
CQkJCSAgICAgICBib29sIHVubG9ja2VkLCBzdHJ1Y3QgZG1hX3Jlc3YgKnJlc3YsCj4gICAJCQkJ
ICAgICAgIHVpbnQ2NF90IHN0YXJ0LCB1aW50NjRfdCBsYXN0LAo+ICAgCQkJCSAgICAgICB1aW50
NjRfdCBmbGFncywgdWludDY0X3Qgb2Zmc2V0LAo+IC0JCQkJICAgICAgIHN0cnVjdCBkcm1fbW1f
bm9kZSAqbm9kZXMsCj4gKwkJCQkgICAgICAgc3RydWN0IHR0bV9yZXNvdXJjZSAqcmVzLAo+ICAg
CQkJCSAgICAgICBkbWFfYWRkcl90ICpwYWdlc19hZGRyLAo+ICAgCQkJCSAgICAgICBzdHJ1Y3Qg
ZG1hX2ZlbmNlICoqZmVuY2UpCj4gICB7Cj4gICAJc3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFy
YW1zIHBhcmFtczsKPiArCXN0cnVjdCBhbWRncHVfcmVzX2N1cnNvciBjdXJzb3I7Cj4gICAJZW51
bSBhbWRncHVfc3luY19tb2RlIHN5bmNfbW9kZTsKPiAtCXVpbnQ2NF90IHBmbjsKPiAgIAlpbnQg
cjsKPiAgIAo+ICAgCW1lbXNldCgmcGFyYW1zLCAwLCBzaXplb2YocGFyYW1zKSk7Cj4gQEAgLTE2
MjIsMTQgKzE2MjMsNiBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZyhz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAllbHNlCj4gICAJCXN5bmNfbW9kZSA9IEFN
REdQVV9TWU5DX0VYUExJQ0lUOwo+ICAgCj4gLQlwZm4gPSBvZmZzZXQgPj4gUEFHRV9TSElGVDsK
PiAtCWlmIChub2Rlcykgewo+IC0JCXdoaWxlIChwZm4gPj0gbm9kZXMtPnNpemUpIHsKPiAtCQkJ
cGZuIC09IG5vZGVzLT5zaXplOwo+IC0JCQkrK25vZGVzOwo+IC0JCX0KPiAtCX0KPiAtCj4gICAJ
YW1kZ3B1X3ZtX2V2aWN0aW9uX2xvY2sodm0pOwo+ICAgCWlmICh2bS0+ZXZpY3RpbmcpIHsKPiAg
IAkJciA9IC1FQlVTWTsKPiBAQCAtMTY0OCwyMyArMTY0MSwxNyBAQCBzdGF0aWMgaW50IGFtZGdw
dV92bV9ib191cGRhdGVfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAlp
ZiAocikKPiAgIAkJZ290byBlcnJvcl91bmxvY2s7Cj4gICAKPiAtCWRvIHsKPiArCWFtZGdwdV9y
ZXNfZmlyc3QocmVzLCBvZmZzZXQsIChsYXN0IC0gc3RhcnQgKyAxKSAqIEFNREdQVV9HUFVfUEFH
RV9TSVpFLAo+ICsJCQkgJmN1cnNvcik7Cj4gKwl3aGlsZSAoY3Vyc29yLnJlbWFpbmluZykgewo+
ICAgCQl1aW50NjRfdCB0bXAsIG51bV9lbnRyaWVzLCBhZGRyOwo+ICAgCj4gLQo+IC0JCW51bV9l
bnRyaWVzID0gbGFzdCAtIHN0YXJ0ICsgMTsKPiAtCQlpZiAobm9kZXMpIHsKPiAtCQkJYWRkciA9
IG5vZGVzLT5zdGFydCA8PCBQQUdFX1NISUZUOwo+IC0JCQludW1fZW50cmllcyA9IG1pbigobm9k
ZXMtPnNpemUgLSBwZm4pICoKPiAtCQkJCUFNREdQVV9HUFVfUEFHRVNfSU5fQ1BVX1BBR0UsIG51
bV9lbnRyaWVzKTsKPiAtCQl9IGVsc2Ugewo+IC0JCQlhZGRyID0gMDsKPiAtCQl9Cj4gLQo+ICsJ
CW51bV9lbnRyaWVzID0gY3Vyc29yLnNpemUgPj4gQU1ER1BVX0dQVV9QQUdFX1NISUZUOwo+ICAg
CQlpZiAocGFnZXNfYWRkcikgewo+ICAgCQkJYm9vbCBjb250aWd1b3VzID0gdHJ1ZTsKPiAgIAo+
ICAgCQkJaWYgKG51bV9lbnRyaWVzID4gQU1ER1BVX0dQVV9QQUdFU19JTl9DUFVfUEFHRSkgewo+
ICsJCQkJdWludDY0X3QgcGZuID0gY3Vyc29yLnN0YXJ0ID4+IFBBR0VfU0hJRlQ7Cj4gICAJCQkJ
dWludDY0X3QgY291bnQ7Cj4gICAKPiAgIAkJCQljb250aWd1b3VzID0gcGFnZXNfYWRkcltwZm4g
KyAxXSA9PSBAQCAtMTY4NCwxNiArMTY3MSwxOCBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9ib191
cGRhdGVfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAkJCX0KPiAgIAo+
ICAgCQkJaWYgKCFjb250aWd1b3VzKSB7Cj4gLQkJCQlhZGRyID0gcGZuIDw8IFBBR0VfU0hJRlQ7
Cj4gKwkJCQlhZGRyID0gY3Vyc29yLnN0YXJ0Owo+ICAgCQkJCXBhcmFtcy5wYWdlc19hZGRyID0g
cGFnZXNfYWRkcjsKPiAgIAkJCX0gZWxzZSB7Cj4gLQkJCQlhZGRyID0gcGFnZXNfYWRkcltwZm5d
Owo+ICsJCQkJYWRkciA9IHBhZ2VzX2FkZHJbY3Vyc29yLnN0YXJ0ID4+IFBBR0VfU0hJRlRdOwo+
ICAgCQkJCXBhcmFtcy5wYWdlc19hZGRyID0gTlVMTDsKPiAgIAkJCX0KPiAgIAo+ICAgCQl9IGVs
c2UgaWYgKGZsYWdzICYgKEFNREdQVV9QVEVfVkFMSUQgfCBBTURHUFVfUFRFX1BSVCkpIHsKPiAt
CQkJYWRkciArPSBib19hZGV2LT52bV9tYW5hZ2VyLnZyYW1fYmFzZV9vZmZzZXQ7Cj4gLQkJCWFk
ZHIgKz0gcGZuIDw8IFBBR0VfU0hJRlQ7Cj4gKwkJCWFkZHIgPSBib19hZGV2LT52bV9tYW5hZ2Vy
LnZyYW1fYmFzZV9vZmZzZXQgKwo+ICsJCQkJY3Vyc29yLnN0YXJ0Owo+ICsJCX0gZWxzZSB7Cj4g
KwkJCWFkZHIgPSAwOwo+ICAgCQl9Cj4gICAKPiAgIAkJdG1wID0gc3RhcnQgKyBudW1fZW50cmll
czsKPiBAQCAtMTcwMSwxNCArMTY5MCw5IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2JvX3VwZGF0
ZV9tYXBwaW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAgCQlpZiAocikKPiAgIAkJ
CWdvdG8gZXJyb3JfdW5sb2NrOwo+ICAgCj4gLQkJcGZuICs9IG51bV9lbnRyaWVzIC8gQU1ER1BV
X0dQVV9QQUdFU19JTl9DUFVfUEFHRTsKPiAtCQlpZiAobm9kZXMgJiYgbm9kZXMtPnNpemUgPT0g
cGZuKSB7Cj4gLQkJCXBmbiA9IDA7Cj4gLQkJCSsrbm9kZXM7Cj4gLQkJfQo+ICsJCWFtZGdwdV9y
ZXNfbmV4dCgmY3Vyc29yLCBudW1fZW50cmllcyAqIEFNREdQVV9HUFVfUEFHRV9TSVpFKTsKPiAg
IAkJc3RhcnQgPSB0bXA7Cj4gLQo+IC0JfSB3aGlsZSAodW5saWtlbHkoc3RhcnQgIT0gbGFzdCAr
IDEpKTsKPiArCX07Cj4gICAKPiAgIAlyID0gdm0tPnVwZGF0ZV9mdW5jcy0+Y29tbWl0KCZwYXJh
bXMsIGZlbmNlKTsKPiAgIAo+IEBAIC0xNzM3LDcgKzE3MjEsNiBAQCBpbnQgYW1kZ3B1X3ZtX2Jv
X3VwZGF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV9ib192YSAq
Ym9fdmEsCj4gICAJc3RydWN0IGFtZGdwdV9ib192YV9tYXBwaW5nICptYXBwaW5nOwo+ICAgCWRt
YV9hZGRyX3QgKnBhZ2VzX2FkZHIgPSBOVUxMOwo+ICAgCXN0cnVjdCB0dG1fcmVzb3VyY2UgKm1l
bTsKPiAtCXN0cnVjdCBkcm1fbW1fbm9kZSAqbm9kZXM7Cj4gICAJc3RydWN0IGRtYV9mZW5jZSAq
Kmxhc3RfdXBkYXRlOwo+ICAgCXN0cnVjdCBkbWFfcmVzdiAqcmVzdjsKPiAgIAl1aW50NjRfdCBm
bGFnczsKPiBAQCAtMTc0Niw3ICsxNzI5LDYgQEAgaW50IGFtZGdwdV92bV9ib191cGRhdGUoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfYm9fdmEgKmJvX3ZhLAo+ICAg
Cj4gICAJaWYgKGNsZWFyIHx8ICFibykgewo+ICAgCQltZW0gPSBOVUxMOwo+IC0JCW5vZGVzID0g
TlVMTDsKPiAgIAkJcmVzdiA9IHZtLT5yb290LmJhc2UuYm8tPnRiby5iYXNlLnJlc3Y7Cj4gICAJ
fSBlbHNlIHsKPiAgIAkJc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmogPSAmYm8tPnRiby5iYXNl
OyBAQCAtMTc2MSw3ICsxNzQzLDYgQEAgaW50IGFtZGdwdV92bV9ib191cGRhdGUoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfYm9fdmEgKmJvX3ZhLAo+ICAgCQkJCWJv
ID0gZ2VtX3RvX2FtZGdwdV9ibyhnb2JqKTsKPiAgIAkJfQo+ICAgCQltZW0gPSAmYm8tPnRiby5t
ZW07Cj4gLQkJbm9kZXMgPSBtZW0tPm1tX25vZGU7Cj4gICAJCWlmIChtZW0tPm1lbV90eXBlID09
IFRUTV9QTF9UVCkKPiAgIAkJCXBhZ2VzX2FkZHIgPSBiby0+dGJvLnR0bS0+ZG1hX2FkZHJlc3M7
Cj4gICAJfQo+IEBAIC0xODEwLDcgKzE3OTEsNyBAQCBpbnQgYW1kZ3B1X3ZtX2JvX3VwZGF0ZShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV9ib192YSAqYm9fdmEsCj4g
ICAJCXIgPSBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoYWRldiwgYm9fYWRldiwgdm0sIGZh
bHNlLCBmYWxzZSwKPiAgIAkJCQkJCXJlc3YsIG1hcHBpbmctPnN0YXJ0LAo+ICAgCQkJCQkJbWFw
cGluZy0+bGFzdCwgdXBkYXRlX2ZsYWdzLAo+IC0JCQkJCQltYXBwaW5nLT5vZmZzZXQsIG5vZGVz
LAo+ICsJCQkJCQltYXBwaW5nLT5vZmZzZXQsIG1lbSwKPiAgIAkJCQkJCXBhZ2VzX2FkZHIsIGxh
c3RfdXBkYXRlKTsKPiAgIAkJaWYgKHIpCj4gICAJCQlyZXR1cm4gcjsKPiAtLQo+IDIuMjUuMQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
