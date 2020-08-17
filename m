Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AF9C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 10:57:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9053F2067C
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 10:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="orsXna5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9053F2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56AF389FC3;
	Mon, 17 Aug 2020 10:57:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDAE288DDE
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 10:57:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+FaS5q9s0kiHqqFfP4+/OhYjrMRwmKT8VDQuPc1Xsx2BhpGlPvz4OvKylSa4/xz99QofzCdsSDM0Zv8+DhpgDQ9KdRXTgHCwdnfy90ia0RZUSf6hzjacXvcxiN7LLhL1LiUlAKD+t6yR4IPOHucciEDWCU9JFbQlzRmtk22LnppohrBxvwSwoL9UrVLSb5CFvYReG2zV15hEqex48yqA1mmUDRy3TGhaquyfY8OB8H9IstMdhXJ97MoolHbSKRid9p3MOsn3OCsuJmKrbynzZjbUc2yTHxi8nztKAJX2rAxgyhGR3oB1uezLu4IgfWNbSgXaZZWCTzvCx5Pb429LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzQuNRmoAbXI/5f9ESO7xHZ0DqkoK6OBL8nH3O7XdlM=;
 b=kxnJtByYKbnzmTUTIkdeJyXl3I0+cun1QGnfMj6++LPp9QskCTyx/olnvKBYqxdDr56MFT6MwevOIvme1QxLj8n6cmzvrGGPw/dRow4XvMBukbH9TiEhdFVzsEhSeOfIc8KXJ2iDfG9WaPkvJE8qrM5WAKjFRH3Px8z+ju0t1F3evOMeVdmpj2Pct/RXcYfWhrEUv2Q8LUQZJe6XakIISl7tM+R1ULRK6G/duNbRvsu92dCSuwFFY13QFWBgrv5b7BbWsLmg4sz/hNqTwKyuE9VNIQIT7kdM36JxRXWLTq/1SLpexiEoKxH+aZN4H3P0zsOWzuWzaDQgVWzd8OjOhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzQuNRmoAbXI/5f9ESO7xHZ0DqkoK6OBL8nH3O7XdlM=;
 b=orsXna5eLXtEh1Ggoy80FDFFROXgDaMyFQL+zYQxo37QSSeA/ouk2edfBcuRgSsgCiuJR0CE76GUTMt7q3YO16w9Bz7d+1XshjQ3eKd8G5MFTFjQm/mbkxywH41nSu0avhoKFAGNZXbO9gnscN16dsFA6+3QZvb1saquPl74a4Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2387.namprd12.prod.outlook.com (2603:10b6:207:44::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Mon, 17 Aug
 2020 10:57:17 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 10:57:17 +0000
Subject: Re: [PATCH v2] drm/amdgpu: add condition check for trace_amdgpu_cs()
To: Kevin Wang <kevin1.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200817103455.11405-1-kevin1.wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <21a98eff-4c16-c35e-665d-3dba105c0521@amd.com>
Date: Mon, 17 Aug 2020 12:57:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200817103455.11405-1-kevin1.wang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0081.eurprd04.prod.outlook.com
 (2603:10a6:208:be::22) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR04CA0081.eurprd04.prod.outlook.com (2603:10a6:208:be::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Mon, 17 Aug 2020 10:57:16 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ea60afbe-dd25-4a7a-ae7c-08d8429c4e61
X-MS-TrafficTypeDiagnostic: BL0PR12MB2387:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB23876759BB428B1E129EB9A1835F0@BL0PR12MB2387.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RmQsbLtNpCVJOOEXSxT3yX3aOyxkpiLjDik73OhqqDEEiPLje/z7nARrTk7+2kT4H1jr8FvSnR0xpAk/+aBfNRNojv4ZVvZzuaIOV3aXLh9WAJpPqlshfJrbPEovnms9Xlsr3zXZw0eAnYsi5itdDiekrEjHM1D+uxrlqCX4ZbFq96J7qbMZX6he6r4g2AlBV1cbyaSfsIlDxIKeh6dfpzTcaf1Eqz61h+WfNPb8T6rry23PTSmeexmbswuYmRCDdpjOfDgKHmpXfyVuCX3TMu2LNgpXSXzwOuZsagKLakas248ndl/oHQGsMHOEhU/O7/CV6n5g3MsD/Cpxya00NiaqZRfBYT7Q5/mBvCocNwmvAgC8HmSD+FLPmJ6k9LZZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(86362001)(31686004)(16526019)(6666004)(8676002)(2906002)(186003)(2616005)(478600001)(6486002)(5660300002)(66946007)(66556008)(66476007)(316002)(83380400001)(8936002)(52116002)(36756003)(31696002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0bUgqpYl0+0n2DADmcvwl6S671EJ17LaSjgO8i0Lg9uaQeP5BLyJ76RkpHZ/oqLByBrQITg+g7EBxIo3CQqXKH/2tTkOqkHmkBJUkQiiENfT92Kf4U4eDXU1I92LSP4Z5lZuJBz3J0hVoDd6hS7CW7CZOaCwD6ZPhFIybCxtdL9bRZCtK5vte5BVjLWeZ2GY2VtmVx94YZbTT5AY4G30zcvP1A8dNvLaqxbkyzhGFvD5E2xas20fAZSSfwxiCfqNOo/5LIJXfDMskimPmwaexUn5NdExaY+NL49ZWVexoxW815VhFK4npgH51CYUWlpDqKwueA32nFMACaKwaPyImfIGKLUu/dZ1BruryCwcaDQEjwPAqtbGiorW1isx8XST63xSW8ii9r5nRdwbJFyjtsmbT5PHzkFZbfGAZOdSo68sAGGTclV6SGXAVUH3T/FEdnqgyjyWoHR8x1MnJ9uu4skPqgP+VsKYoKe/K3RadzI9m2Q8W0MiYJnhfdsnvXBy6FyTG/1+XX0BYzDUHm404U2H8CpS3uik8CAxvAPGmGkASUezrsOdgUg5V6vWSP1x8eLgkuTw54Cs5erdss3YnY6WHD54ww49InwSDs8Vi3zYDo7EhXKaDflqa7v/i3tXUNr0vxg4fvBCYZM+o+g3MBZ5AQqnUARHhYE3/tg+hrPyHLbA8IMfLW1AoTmYA/EjogQXlYnKZ8VAvHBsvGkpJg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea60afbe-dd25-4a7a-ae7c-08d8429c4e61
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 10:57:17.2779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9u/afhYyLI6NGrSNs0urulxGMpkBAvCP/fpuQzwrp0UtdGY1wdkNU/BvroNrCKqW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2387
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

QW0gMTcuMDguMjAgdW0gMTI6MzQgc2NocmllYiBLZXZpbiBXYW5nOgo+IHYxOgo+IGFkZCB0cmFj
ZSBldmVudCBlbmFibGVkIGNoZWNrIHRvIGF2b2lkIG5vcCBsb29wIHdoZW4gc3VibWl0IG11bHRp
IGlicwo+IGluIGFtZGdwdV9jc19pb2N0bCgpIGZ1bmN0aW9uLgo+Cj4gdjI6Cj4gYWRkIGEgbmV3
IHdyYXBwZXIgZnVuY3Rpb24gdG8gdHJhY2UgYWxsIGFtZGdwdSBjcyBpYnMuCj4KPiBTaWduZWQt
b2ZmLWJ5OiBLZXZpbiBXYW5nIDxrZXZpbjEud2FuZ0BhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYyB8IDE2ICsrKysrKysrKysrKystLS0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKPiBpbmRleCBmZmJjYWY0YmZiOGIu
LjE5MjFlNjFhMzdiOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfY3MuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5j
Cj4gQEAgLTEyNzUsMTMgKzEyNzUsMjQgQEAgc3RhdGljIGludCBhbWRncHVfY3Nfc3VibWl0KHN0
cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwLAo+ICAgCXJldHVybiByOwo+ICAgfQo+ICAgCj4gK3N0
YXRpYyB2b2lkIHRyYWNlX2FtZGdwdV9jc19pYnMoc3RydWN0IGFtZGdwdV9jc19wYXJzZXIgKnBh
cnNlcikKPiArewo+ICsJaW50IGk7Cj4gKwo+ICsJaWYgKCF0cmFjZV9hbWRncHVfY3NfZW5hYmxl
ZCgpKQo+ICsJCXJldHVybjsKPiArCj4gKwlmb3IgKGkgPSAwOyBpIDwgcGFyc2VyLT5qb2ItPm51
bV9pYnM7IGkrKykKPiArCQl0cmFjZV9hbWRncHVfY3MocGFyc2VyLCBpKTsKPiArfQo+ICsKPiAg
IGludCBhbWRncHVfY3NfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwg
c3RydWN0IGRybV9maWxlICpmaWxwKQo+ICAgewo+ICAgCXN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2ID0gZGV2LT5kZXZfcHJpdmF0ZTsKPiAgIAl1bmlvbiBkcm1fYW1kZ3B1X2NzICpjcyA9IGRh
dGE7Cj4gICAJc3RydWN0IGFtZGdwdV9jc19wYXJzZXIgcGFyc2VyID0ge307Cj4gICAJYm9vbCBy
ZXNlcnZlZF9idWZmZXJzID0gZmFsc2U7Cj4gLQlpbnQgaSwgcjsKPiArCWludCByOwo+ICAgCj4g
ICAJaWYgKGFtZGdwdV9yYXNfaW50cl90cmlnZ2VyZWQoKSkKPiAgIAkJcmV0dXJuIC1FSFdQT0lT
T047Cj4gQEAgLTEzMTksOCArMTMzMCw3IEBAIGludCBhbWRncHVfY3NfaW9jdGwoc3RydWN0IGRy
bV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwgc3RydWN0IGRybV9maWxlICpmaWxwKQo+ICAgCj4g
ICAJcmVzZXJ2ZWRfYnVmZmVycyA9IHRydWU7Cj4gICAKPiAtCWZvciAoaSA9IDA7IGkgPCBwYXJz
ZXIuam9iLT5udW1faWJzOyBpKyspCj4gLQkJdHJhY2VfYW1kZ3B1X2NzKCZwYXJzZXIsIGkpOwo+
ICsJdHJhY2VfYW1kZ3B1X2NzX2licygmcGFyc2VyKTsKPiAgIAo+ICAgCXIgPSBhbWRncHVfY3Nf
dm1faGFuZGxpbmcoJnBhcnNlcik7Cj4gICAJaWYgKHIpCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
