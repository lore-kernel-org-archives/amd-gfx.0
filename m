Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43195C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 18:40:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF90561441
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 18:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF90561441
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 523D46F427;
	Thu, 29 Apr 2021 18:40:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AB6B6F427
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 18:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVi5y/REHTrj3wObA13ejHZUALDJKUwXC/SmcxIsOPYEFRyBvAL+q+u/FanQjWCeBLrjfSFnHnB92AS7J3tsGkGLJKhXTOJU7N777nzaQA7zLFt4GD+m/CrggcAqkQt39ABlmVN2J4ESawE5NKs4uYo7ElvIYC5os7JraQoOfqY7qJEPl5CoAFJK4mqu9tegSIiQ5ruaFbCAMtN2Zv6fY2LGKK9vFWciMbAiTCFx+ZOpvvF2ydQlnnX3hAtjGRD+TVUzZWZDWiwrhrwJlN3jbpmmoIdjdFGZ+PzDgBtxA06z6wzRF4hnlHcBE9o1qGQllgL3os1dhqHjP0+THrYiaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMnoYRYVDEZ324lrEi06Ijm1sIHidd/FWoSLK+kdb74=;
 b=casU1rTkIts0RbY0nq7+aXUDt/qQ1T9yDttorawbtk2RdO+xuNpwX5otjubHf15rjIycvK0WN65eHASpabMZ9ofoYedekmJ6Ki49TjRfERBk1JEVwP4+eEf7mAw/vAxEaNPGAI8tOB/W3FgTXlTExxzFXN6kOtQF2rKtA7CSDZDZUN0rUggER/zVxXIMnKrqpaS/OT9AeXTLas+GAN7oyyNPMjOrctN2wRQpc2vw1C4lrC6qcoY23VELjNn4/Vq6vZVbIKJPZ9BeIREnlOxj+B4zMJUbJQ+7O+lrBqAPVH+IHoiGqnBdA4HEsqX2eXbi9YxZAYXWlA7BS5QUIY6ooQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMnoYRYVDEZ324lrEi06Ijm1sIHidd/FWoSLK+kdb74=;
 b=VPdekVS7leGv4SM1HCnzubB8KfH1C9oI3WOrDo7GRb4f8vqgUsfQVtpr3UUkfMu4yX49haXzlIRlaHDCNkSq2gRcvoo8lb1Oa8OqxCQIhDkLwFADT+t3L0dnXwEXveSJdU+Dia5KLqRo8UTeqca34vKaGUnbd/jFk5iHdQu9I0g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB4691.namprd12.prod.outlook.com (2603:10b6:208:84::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Thu, 29 Apr
 2021 18:40:18 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%5]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 18:40:17 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: Add a new device ID for Aldebaran
To: Zhigang Luo <zhigang.luo@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210429183351.17914-1-zhigang.luo@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <a8683018-e0db-579a-943d-d4e08b053654@amd.com>
Date: Thu, 29 Apr 2021 14:40:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210429183351.17914-1-zhigang.luo@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.183.69]
X-ClientProxiedBy: YTXPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::15) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.183.69) by
 YTXPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.24 via Frontend Transport; Thu, 29 Apr 2021 18:40:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f58c84f-bcf2-4fe9-86d0-08d90b3e3c44
X-MS-TrafficTypeDiagnostic: BL0PR12MB4691:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB469135E7DEDEA4F9716BC250925F9@BL0PR12MB4691.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VI5GeaWcYNmTJakWxZEBqAzg5zkEdC42mc7evfKanUrniyZV5C2wIDDPLGTZhHB0fWL6q/QWzbb6qWbGr9ChF/NW9vLAdtvYAvsz4XAJdt8jKJLmwBmUosOu28d4Z17fW3HM4nFO60ZZZBRz0g+gn931nUmnRt5vmQk1ZVF03uEN2JymYXbfpd6oI43xjn8hD3XJNTopy1fH4RwzvDvrsZSN2UyK8KEnV6+xZ2xnJ6mKI7DUx/+PVDNTIqvr4uEiWlxCd6TfQ0JdqBTuZgJokCvJmtPjwpIXIPlEn04rqABxVN2uyZFm3W0zEr805My3RNxyu7cGgGIMby1eiO4Nng8UjFD6IedOwiMgdK9n1PJ1ULRbXRxaLh6HV/gMOmKfDoH+VQZ+62Yx5o42sfUWfkup91OtNoUmBdj3BcjMjtY1ZocAl2eImeZr+05Zz/Pnl6kU04Rcx0ovEmmzgHzld2v4SnS3ku4t9FcV/ypQ+Np4Kd6k84m112EuKAbQEKyh5lBAp3USb2nZGG3M7N4gA8jTwRJ4yMS/8UUjsEfImJKD1Sbuan7s8vYCNuW3+Lfgc/09PZh4wVE7ZteXCSkz66K2ZK1TZohescG0MC6Sm3tGOLvSCM1kr+Z/l2mYoAuikOvoPOywsjFTarKBV+M/kk5APgDSGgzJwbFBAy0/nnU2/hyl0X1hnpgjST9XujOM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(26005)(186003)(31686004)(44832011)(38100700002)(16526019)(16576012)(316002)(6486002)(66476007)(2616005)(86362001)(5660300002)(8936002)(478600001)(66946007)(8676002)(31696002)(66556008)(36756003)(956004)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WEtJeGQvWCswV0pkVkFGZGJnV1d1dVUxZHo5M2tXZVpwQjJocjgrdFUyVGFG?=
 =?utf-8?B?a1VWSWNoKy9KM3crN1VBUnFleXFURm1EaEFOekNWcDhFVDBDWXBtYmcvMjYx?=
 =?utf-8?B?M0IrY21JYjJLY2k5VFVUQzk3MmlzYitUYXczL3ROcmo0RnE2UVFSK3oybFQ3?=
 =?utf-8?B?ZzFPaUhiK2Voa01qVXFrblRPUGlYdGYzQzlwVE8yM3h2azM5Tk1WM3NXSm5J?=
 =?utf-8?B?em9kMjY0L0tHMXhFeHRHbnIxd3BkMGZsckxDMnFJbVpqZ1dBdEdLbWY2bkNK?=
 =?utf-8?B?N3BXNXVRdVVISExTMXB2Skl2ZXhSRFhWMzJBMlZUekxLNjhpMlMzcUk1dWpP?=
 =?utf-8?B?RjdsblhBdlRja1ZiWWR3eUlnT0lERTViL0toQis0ekJHbDJuVUFpczcrcjZH?=
 =?utf-8?B?N0NwQUxWUThObUNORG5EMlhJKzExMWVya2pBeFRHQ1oyL0IvZXZGdWdBSnYz?=
 =?utf-8?B?SzJSN1hCWFkzVC9BdXQvL3JuWVRrSks2OGhBRlBoZjhGM0kzNGhxTHNMRHpI?=
 =?utf-8?B?Vkt1TEhTTVFxZVpJVU9scFlpcmxidkZ5bWNWWXU2ZVNRTjV0c1A3aVQycFd3?=
 =?utf-8?B?dkhvSGZEWmdtS3dlRitKRnhwS01GU2llRkpldjJmYTZzZ3JpTXFWZ2hlUW1Z?=
 =?utf-8?B?dDBOUTlDK2xFdmloVnRLUXdIRTk1VWZ1SDZWME9pNElzNXJXWi9MOWdFUzB5?=
 =?utf-8?B?a29seXhYVWtYZSs5ZEJBbzBPQk5UVXJYdUZ1R3RTQUd0QXBDWXRTMnB5Njh5?=
 =?utf-8?B?VmV4YWV5OGVzcU13THpuOTF4N2lJS0NGRG55Sng5c0M1RElvaFNiWkJ2QUQ5?=
 =?utf-8?B?SEgyM05RVks0QjlZRnplUnJ6Y05hT1QvanVuYWg3K0ZWbTdsWUQrNXJqMnlB?=
 =?utf-8?B?SXRJcFZyWXRlcU9vampwRzJyZ1o5UGc1SmFCRzc5dDZhN1BQcTRhQm5nNzBZ?=
 =?utf-8?B?NzRtZFlFRUgzTVZMZk9HbVYzOUM1S3pZcnY1THhBVGZKQUgvVmR4aG1ZMmdL?=
 =?utf-8?B?WHZySWhIY1g0S2tVKzRnbnpqWUVROGpOMDF0dkdzemEwM2NDd3RKcFNSMU5j?=
 =?utf-8?B?TzVqZ0YvUFZlbytzNVhqQkpFVVRMekdzRStxenZpcmJyT1JhQTZRUW93VUor?=
 =?utf-8?B?TllNU2wxOEdYK2NEMFpaQTJQejZnK05VeldoblBrZDAvRm5TdG80OEhsQXMy?=
 =?utf-8?B?UzZER0hKOWtKUDNneHFubUxhbkttV2N3WXZZM0FjUzVzMzE2MmduVlI2ZGRG?=
 =?utf-8?B?Yk56L01uVXVpWkNQT29ONEx1R2RQVUM3cVI2R3hJQWpBRzh1d1JOeEJoZkli?=
 =?utf-8?B?aHVtREJnTEpVRDNBb1JPNzZVSG5TYlZqclV3bmZHQVg1bjR4cnBPYi9xZUtS?=
 =?utf-8?B?aGRkRFJHMXFTc3owcDV1bFc1YkRWcFVPQUxTRUxXa0h5K2hFNXBPNnVMTlpF?=
 =?utf-8?B?ejBTaDYvRmVkTVFDcXdQaE9WYWQxakFHcjZYR1UyMU1WOTBXbUJJTGpnQjlj?=
 =?utf-8?B?emFIWGRrWVdRR3hUZ25iQTg0TzUrTE1SRFlDSWNiWkg2c29nYTJiQXd5L2JR?=
 =?utf-8?B?cUh3MEV0dFdQVUlzWFB1OE5UT1Y1YXhqM0lBZEd1b3VWMUNXM0ZUWG1NTUNJ?=
 =?utf-8?B?aWh6b1FtTGRlQ3VGMmFrRzBHTHUyOU1uc1RPN083TUVXNWxqTnBMQlZkK3FP?=
 =?utf-8?B?cmQxZVZRTkpBMDJnUFc5cy9LeFFWeXNuVmMyblFXN0pJOHpSMkFwNHJOSWZM?=
 =?utf-8?Q?uI38+rDVRhxruAr9Fs29IlLDlU4G0xHi3GXv6BX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f58c84f-bcf2-4fe9-86d0-08d90b3e3c44
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 18:40:17.7663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCZoKcEoR4vi7rgZkGvePfN20cMKOEoicPbV21xfooZUlg8MhH2iOs90lSwm0wgt7TrMVv6lcxsoR6FTmS32wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4691
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

QW0gMjAyMS0wNC0yOSB1bSAyOjMzIHAubS4gc2NocmllYiBaaGlnYW5nIEx1bzoKPiBJdCBpcyBB
bGRlYmFyYW4gVkYgZGV2aWNlIElELCBmb3IgdmlydHVhbGl6YXRpb24gc3VwcG9ydC4KPgo+IFNp
Z25lZC1vZmYtYnk6IFpoaWdhbmcgTHVvIDx6aGlnYW5nLmx1b0BhbWQuY29tPgoKVGhpcyBwYXRj
aCBsb29rcyBnb29kIHRvIG1lLgoKQWNrZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVo
bGluZ0BhbWQuY29tPgoKSSBiZWxpZXZlIHlvdSdsbCBhbHNvIG5lZWQgdG8gYWRkIGFuIGVudHJ5
IGZvciB0aGUgVkYgaW4Ka2ZkX3N1cHBvcnRlZF9kZXZpY2VzIGluIGtmZF9kZXZpY2UuYy4KClJl
Z2FyZHMsCsKgIEZlbGl4CgoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2Rydi5jIHwgMSArCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwo+IGluZGV4IDAzNjlkMzUzMmJmMC4u
MzEwZTEyNDllNjRlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kcnYuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYu
Ywo+IEBAIC0xMTg2LDYgKzExODYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2Vf
aWQgcGNpaWRsaXN0W10gPSB7Cj4gIAl7MHgxMDAyLCAweDc0MDgsIFBDSV9BTllfSUQsIFBDSV9B
TllfSUQsIDAsIDAsIENISVBfQUxERUJBUkFOfEFNRF9FWFBfSFdfU1VQUE9SVH0sCj4gIAl7MHgx
MDAyLCAweDc0MEMsIFBDSV9BTllfSUQsIFBDSV9BTllfSUQsIDAsIDAsIENISVBfQUxERUJBUkFO
fEFNRF9FWFBfSFdfU1VQUE9SVH0sCj4gIAl7MHgxMDAyLCAweDc0MEYsIFBDSV9BTllfSUQsIFBD
SV9BTllfSUQsIDAsIDAsIENISVBfQUxERUJBUkFOfEFNRF9FWFBfSFdfU1VQUE9SVH0sCj4gKwl7
MHgxMDAyLCAweDc0MTAsIFBDSV9BTllfSUQsIFBDSV9BTllfSUQsIDAsIDAsIENISVBfQUxERUJB
UkFOfEFNRF9FWFBfSFdfU1VQUE9SVH0sCj4gIAo+ICAJezAsIDAsIDB9Cj4gIH07Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
