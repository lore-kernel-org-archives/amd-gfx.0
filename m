Return-Path: <SRS0=uqaI=KB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6680C433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 00:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8052B613C1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 00:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8052B613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F05F6EC82;
	Thu,  6 May 2021 00:08:47 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750041.outbound.protection.outlook.com [40.107.75.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C9026EC82
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 May 2021 00:08:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOMTgg4o24/mZ7CylB/xQZ5SQhXRizO02YZtc6bFEEoLEvTbkxBAfYKa7GS0/xNKlKUu4HV7AGJiWSUK92vZ/dRWQ97sgqjjn55q2W3ZErrbCp2cPBQ3O0g9w8ViwYVTvmSzZOgpP1I73jZad+mXiLLK1fTDqIx3NJfkG41bDsAlcn6oUiCw4F3dSly0AL/uLo5pgTgMxTrABkky7/J4vs/mXp5EDblTGZBCCqq4uxCQ5eEdJSU7k6+68BHRORLpK91C7Pdbs2COtnp8cFLwCyZYKbvED5rTAJEgTUInmuuDE7cgwvp3xTK5eD3xlRJt7p8PNkgiXUtMBj8DApPb1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acLFC0jqYrwiMju/fJhjF0D7fjpEZA4OnIwROfw/stM=;
 b=XpdVOTiX950hWLnqrkcWhDk25jIIv7S1hrb3Ji2/U1hkpQ9InPlnHFi0QROpKBaC3Rb1w5wO/iKBwyg5/c6u5KBWz5VDPeVpliLijuoZBQKywrb1mU1TEjeC+WGWTwZTBOGVj517aP+cE+zudt5Zpoz1zA3Xq+wut4dgcAvTAHjTjJ4Vd9MGh7BXpesIyG+cffjLqJpa/z0GVZvmbVoBgTkYmRAUKVIIGW2mXf4PFZtK+1fnnyczRtcmS1gaNgVkgCgrOH+BsBjdVWRXRZWzEkV5nCpqgw9Q7L+IcphG5k5kbeBeA5SfYbdILFUyw7vFMrWcP+lKIfFbgzFCSAsX/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acLFC0jqYrwiMju/fJhjF0D7fjpEZA4OnIwROfw/stM=;
 b=5bROIcsc03CuU2USrGUGlg5ITS3bMkzd1BKHiZpOzpklzLjpCH8wzy+cGhJQY/Mua/QlIt/yMEme9cW+Fsi09b/W3KU7i8PWDJ3bN2ww7dkgjglP+GJwHP2Vde7hIWYnFCkG6znCFafVyrKozyx4whXNtnNkaG/rJUYxKDOMfCo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5243.namprd12.prod.outlook.com (2603:10b6:408:100::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Thu, 6 May
 2021 00:08:43 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4087.039; Thu, 6 May 2021
 00:08:43 +0000
Subject: Re: [PATCH 1/3] drm/amdkfd: device pgmap owner at the svm migrate init
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210505225944.4425-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <11b0d166-20e4-ed55-0cfd-fa2744226686@amd.com>
Date: Wed, 5 May 2021 20:08:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210505225944.4425-1-alex.sierra@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.138.207]
X-ClientProxiedBy: YTOPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::39) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.138.207) by
 YTOPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39 via Frontend
 Transport; Thu, 6 May 2021 00:08:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f41fab3c-30af-493b-5d77-08d910231c66
X-MS-TrafficTypeDiagnostic: BN9PR12MB5243:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5243266D300AAEE064BF066E92589@BN9PR12MB5243.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/ugHVyKMMlvI+sE8Xxefd19FUz1wx/6zIBXwmH48HZNWg+qnxw6eZ2Ppj30h93QCB0iI+Y7D0lQEF6xP5GcFi2LIeX6XyGupwD0g/kqVJmVExE8WEK+ltAq9h4fKmBnGB66/9wMnRmF5GeLccCGRCibw25QiTqsQWUkf1rRE9V2x1KEq/rB4DBOMGujVqQk26Snd1jrh+codVUJybxIZRlPa7N1q0yFxWQq6tk9I9KtCi6drdWkRWPuxL8uJPklLA80y0BE225ftxx2sqefgCwrkUuPhg+foffD+KS/c90m/0P0VMgmqevrRfnIUBqZpDayeesIfy46GoWs7waM/wUeVozuHoFbtBmWSp8Y5IUVjgnvR+G6R+JdherJUwLAaBM7ZKZz7DDXrerYd5MYotk2JxKLudyzWTx3meKDOhuOBqA4LQ4ySI3Wzp1wXPkQkdFrysER5bh6aRjVxY+jQ5zuQvtTlrqWwjytm11aR1zy6utSoj9zF2PYJSK3N4Pr3jghiMgVSSdFebN8uxhOj2VdJeYQDrwcsHtNZNx8n8iRLvjQOUp/GANJVMCrytjUSn4S57uN6ya54LD4w3hB0B3zZFB7pGG98v04r83wDPkXslIA/8UAVZFtlcAODDW9DcKX2ziz21nVVfHNDMQumEfAy37cLqgniPI9bkVJ+aYIbx4DXTGm3qZg+Lm6B/Gs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(8676002)(6486002)(26005)(5660300002)(16526019)(16576012)(86362001)(186003)(8936002)(31686004)(316002)(83380400001)(31696002)(956004)(2616005)(38100700002)(478600001)(2906002)(66946007)(66476007)(66556008)(44832011)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aHVtem5aTWtVc3RQU0kzMEVuQ05iY1krSWVtTCtkRHUwM291eCtMOVZpUjFW?=
 =?utf-8?B?SUpka3NRblNmUFRTaysweG9HTGhKT3MxL1RCZEFnaEkyKzV3TlNnM25iMWRY?=
 =?utf-8?B?b05SUU5VQllkWFd1TnJORVltS1dMYVlWV1JKRVp3dVpLVUk4SFc2T0d4ZWN0?=
 =?utf-8?B?aTVNQ2NIeXhscUxDNWZKQk5vYlhKMVZKVmovV3VXcWxTeU40eGQvTmR0OHlx?=
 =?utf-8?B?NTNxbTVyM1pmL2pUZ3VxbTBLKzRFNzhQZVk4UVVNZUZOTW9YaTZyNE44VWI5?=
 =?utf-8?B?ay94UExLczUyOFVMVnN1d29Oc0dIVEJjdG5BbUE3Ni9ndDc2OVRkNXRpa3lZ?=
 =?utf-8?B?eFJBWEJJK2tka3NhZWJGTmVuekhXU0RRWXJ0Q2xBWGdwSk5TSlVFVFN3d0ov?=
 =?utf-8?B?TDYxVlVCWjdhY0t0MldBQ3pxU0huNmw4M0FVSm92QlJZZHZUdnlQdThrMk80?=
 =?utf-8?B?MXRlMm9JTWlhUjA1NGlEMGJQdnhtNWNKZ1VkWWp5THZ3YXZBaENyVlY2NVdi?=
 =?utf-8?B?YWpHTE1wMW5ORThOQ1dsd2tZTHpkb0R5bWNKV1FzdmQ3UG9LelRZL1U3WkJI?=
 =?utf-8?B?a0JqR0RWWHpsS3R0OWdDUmxnNm9WRi90ZXJrNFhLYnBnVkdyakJKSEdVVjBt?=
 =?utf-8?B?OE9JWHVLME5nTG1tdUFPcVBOU2hrNXRveDFocnBWRHc2TU50TnNmRzVTUzhG?=
 =?utf-8?B?cEM1aSt3dTJQaUtlMzRUb1VicmdWa3JFWVgrc3VnSTZkWDY3WUI3VjdDNm03?=
 =?utf-8?B?cy81b3BWYUM4dUZNb0lmVklwYnE0QWg3UFVYRFRmVExUTHlucmF3NEhHRzFj?=
 =?utf-8?B?OWNpd1F5cEw3Z1g2N3h6SHJlUG5sZkZFNjRZUm9SODd2OExpa2NJcE1YbmVj?=
 =?utf-8?B?bndGSmorY0c2aDZ6ZHJwZjI3M2ZzNHFRWlpkWnZsOXNFNkVtUkFqQzVVbEIw?=
 =?utf-8?B?ZGs0VmhmYVFSaFJLeWxTNThjWnAyVkp6WktrbnlVSklZNEdUZDBXYVNxOUhE?=
 =?utf-8?B?R2oyUExET2x2Q2owREpDdEVrRzZZZ3Vtc2VIaFg2TXZ6K1prcGZIRW9ESTZU?=
 =?utf-8?B?ajhJeUhsdmdVKy8xb0dVT0RCK2tYbGIyOWF6KzBzaXlsUkdWdzVMbDdTWVZj?=
 =?utf-8?B?bytlQVRxYXY1R0lUOStuVXU0akREQWRKdm5yTFNFY0JTTnEwK0FKcDJ2YVFF?=
 =?utf-8?B?aG95TUFUS2lKVStweHovSjkraTZIRWZWL2Frd1J3Yi9DQ2kwZUNSdlZacU9l?=
 =?utf-8?B?UysrVW5ETWtnayszaXVBZEQwYlFWdE9XekttR0IySU5TczhxSGxDbXRTUGR3?=
 =?utf-8?B?bHZrOUxjNXhLNnJPWCtKSVo5QW1rUGUvOFUxMlFld3NManViT2trd0RRSlNJ?=
 =?utf-8?B?eFptS09NSVJXV0hIQ0w3RXg1NmxOb0RCY1Z5Q2Nnd1BEeDQrOTVCUVE1Rkdu?=
 =?utf-8?B?NDFkU1o1a3ZZZnFjTXhxKzFxcTA0YXMyWXVnenZ5T1VQd2J0QWdPeGNNUG5a?=
 =?utf-8?B?bi9zRkZIYzI1NnVsWGJ3elZOOXJDMFNDR2dNVmFvamhJN3A5dURQUXFVRHpJ?=
 =?utf-8?B?UURXYmw3Z0ZxKzhuTm1VYWRveDF6UDZHUWpha2pTOFZ5UVF0Qm5kZHdvUGh6?=
 =?utf-8?B?YXEvdUlPc0QrYnBObGovNG56QlFyeFpQRFh0RUdXZEFFSjNFZndTcEV4ak5L?=
 =?utf-8?B?NnpISGVQaUVRRVJybWRLQ0FBNlNVbHlwK2t1K2doaDBVSFFzQnR2OExZaGdv?=
 =?utf-8?B?cTNuSWNNS2pSTG1EMGZwakxualFhdGJIOVZicFVTcTBqOFVWcmFHTVlHaWMw?=
 =?utf-8?B?MWVmdFhlUFE3eHJkYU1lQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f41fab3c-30af-493b-5d77-08d910231c66
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 00:08:43.6972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZeyD5GuuT1YHYc6zk/HwVF4SJL/1WA/0KPKNG2OPs9QvsZj4sd+KPGJtc/2BqIB4MLPXvxUSTRPtm6g/84GkKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5243
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CkFtIDIwMjEtMDUtMDUgdW0gNjo1OSBwLm0uIHNjaHJpZWIgQWxleCBTaWVycmE6Cj4gcGdtYXAg
b3duZXIgbWVtYmVyIGF0IHRoZSBzdm0gbWlncmF0ZSBpbml0IGNvdWxkIGJlIHJlZmVyZW5jZWQK
PiB0byBlaXRoZXIgYWRldiBvciBoaXZlLCBkZXBlbmRpbmcgb24gZGV2aWNlIHRvcG9sb2d5Lgo+
Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBTaWVycmEgPGFsZXguc2llcnJhQGFtZC5jb20+Cj4gLS0t
Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9taWdyYXRlLmMgfCA2ICsrKy0tLQo+
ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9taWdyYXRlLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbWlncmF0ZS5jCj4gaW5kZXggNmI4MTA4NjNmNmJh
Li41NzIzYzZiYzJhZmMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX21pZ3JhdGUuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9taWdy
YXRlLmMKPiBAQCAtNDI2LDcgKzQyNiw3IEBAIHN2bV9taWdyYXRlX3ZtYV90b192cmFtKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3Qgc3ZtX3JhbmdlICpwcmFuZ2UsCj4gIAltaWdy
YXRlLnN0YXJ0ID0gc3RhcnQ7Cj4gIAltaWdyYXRlLmVuZCA9IGVuZDsKPiAgCW1pZ3JhdGUuZmxh
Z3MgPSBNSUdSQVRFX1ZNQV9TRUxFQ1RfU1lTVEVNOwo+IC0JbWlncmF0ZS5wZ21hcF9vd25lciA9
IGFkZXY7Cj4gKwltaWdyYXRlLnBnbWFwX293bmVyID0gKGFkZXYtPmhpdmUpID8gKHZvaWQgKilh
ZGV2LT5oaXZlIDogKHZvaWQgKilhZGV2OwoKV2h5IGRvIHlvdSBuZWVkIHRoZSBjYXN0IHRvICh2
b2lkICopIGhlcmUgLi4uCgoKPiAgCj4gIAlzaXplID0gMiAqIHNpemVvZigqbWlncmF0ZS5zcmMp
ICsgc2l6ZW9mKHVpbnQ2NF90KSArIHNpemVvZihkbWFfYWRkcl90KTsKPiAgCXNpemUgKj0gbnBh
Z2VzOwo+IEBAIC02NDEsNyArNjQxLDcgQEAgc3ZtX21pZ3JhdGVfdm1hX3RvX3JhbShzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IHN2bV9yYW5nZSAqcHJhbmdlLAo+ICAJbWlncmF0
ZS5zdGFydCA9IHN0YXJ0Owo+ICAJbWlncmF0ZS5lbmQgPSBlbmQ7Cj4gIAltaWdyYXRlLmZsYWdz
ID0gTUlHUkFURV9WTUFfU0VMRUNUX0RFVklDRV9QUklWQVRFOwo+IC0JbWlncmF0ZS5wZ21hcF9v
d25lciA9IGFkZXY7Cj4gKwltaWdyYXRlLnBnbWFwX293bmVyID0gKGFkZXYtPmhpdmUpID8gKHZv
aWQgKilhZGV2LT5oaXZlIDogKHZvaWQgKilhZGV2Owo+ICAKPiAgCXNpemUgPSAyICogc2l6ZW9m
KCptaWdyYXRlLnNyYykgKyBzaXplb2YodWludDY0X3QpICsgc2l6ZW9mKGRtYV9hZGRyX3QpOwo+
ICAJc2l6ZSAqPSBucGFnZXM7Cj4gQEAgLTkwNyw3ICs5MDcsNyBAQCBpbnQgc3ZtX21pZ3JhdGVf
aW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgCXBnbWFwLT5yYW5nZS5zdGFydCA9
IHJlcy0+c3RhcnQ7Cj4gIAlwZ21hcC0+cmFuZ2UuZW5kID0gcmVzLT5lbmQ7Cj4gIAlwZ21hcC0+
b3BzID0gJnN2bV9taWdyYXRlX3BnbWFwX29wczsKPiAtCXBnbWFwLT5vd25lciA9IGFkZXY7Cj4g
KwlwZ21hcC0+b3duZXIgPSAoYWRldi0+aGl2ZSkgPyBhZGV2LT5oaXZlIDogYWRldjsKCi4uLiBi
dXQgbm90IGhlcmU/CgpIYXZpbmcgdG8gZHVwbGljYXRlIHRoaXMgaW4gc2V2ZXJhbCBwbGFjZXMg
aW4gdGhpcyBwYXRjaCBhbmQgdGhlIGxhdGVyCnBhdGNoZXMgaXMgZXJyb3IgcHJvbmUuIE1heWJl
IGl0IHdvdWxkIGJlIHdvcnRoIGRlZmluaW5nIGEgbWFjcm8gZm9yIHRoaXM6CgojZGVmaW5lIFNW
TV9BREVWX1BHTUFQX09XTkVSKGFkZXYpICgoYWRldiktPmhpdmUgPyAoYWRldiktPmhpdmUgOiAo
YWRldikpCgpUaGF0IG1ha2VzIGl0IGVhc3kgdG8gZmluZCBhbGwgcGxhY2VzIHRoYXQgbmVlZCB0
aGlzIG93bmVyLCBhbmQgaWYgd2UKZXZlciBjaGFuZ2UgdGhlIGxvZ2ljIGZvciB0aGlzLCBpdCdz
IGVhc3kgdG8gY2hhbmdlLgoKUmVnYXJkcywKwqAgRmVsaXgKCgo+ICAJcGdtYXAtPmZsYWdzID0g
TUlHUkFURV9WTUFfU0VMRUNUX0RFVklDRV9QUklWQVRFOwo+ICAJciA9IGRldm1fbWVtcmVtYXBf
cGFnZXMoYWRldi0+ZGV2LCBwZ21hcCk7Cj4gIAlpZiAoSVNfRVJSKHIpKSB7Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
