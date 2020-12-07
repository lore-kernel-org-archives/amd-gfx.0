Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755E6C433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 08:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDBA0229C6
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 08:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDBA0229C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66D7089E9E;
	Mon,  7 Dec 2020 08:23:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00CF289E9E
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 08:23:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKGZ7vvsphlUVUBnTc808jNRGS5U8qOxJq5gfl3KPVDB9mqcpqUg63rAXLYWE34DROCYwhG0MJaMkUzMtaHmkqrI/YtXLLqmj7HawluIDVmdggWigsAKMRnPAAni6J2cox+LqcJXGq+AkErLlztsH8YJ/3h8sY4mrAh6z4+qD6oppyMmDR2B0p9iSAjw5xJfPo5rxIA+/HkPTfk2CLsRelLucIVajoEG8QsNzHb42fNvtbMZI6b6Olr0wpr2rd8A/XNwJniTgthebPDr1BRYJR7OeLw9Q2+xGriEi8MHf0+ogUj/kSNkML4MDtqjfm6Rvm83yE3tXBln0CiX6cDQ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClyZaC+JqKpRZj7OPcr3tUTAzEfmyqiwpb33SpRn7B8=;
 b=OeFsNjhDdhDroB72OtlMl3oDpuavLFWu7P9JInrzmkAnu0OXv1e2XVcZHF4ckQvxiZn6Cmmql21XeSgtRlQsFubpo385T28vsCLst99DCCpse+ldoKU550jRIERIrvlMy4UCyqIRwUM6DBmRrWwUncyR/SgPO06u/pMsTTBRW1IACrE3nc6rlIX0AN/+eGdPDGhITUeMUOK4j16j5iv0lyn/WM5jyhruKqz3H6+biKIJ8shUDgqDHEsofjF0kiVX2Pfx6Ea0t0dmr9AXENZEVXgKcpSq4Ot7EGfJ2pKNeU8LOn9t3u5SY0CfrZ9O4IkB5qSiJ3Nmm0w9sgbHDeKwzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClyZaC+JqKpRZj7OPcr3tUTAzEfmyqiwpb33SpRn7B8=;
 b=e8i2lz+rDd6cBzHzDcbogbehRYFSxf0UxwxBjrYN3qBsAZeW9HCpEcFZrVNa/0Gk1ybjZ9z0O2YQL28Kd5hu0hYtMdLMHO+GgIKTleY2OkQMbh2v5CQS2/QTdyTUc8X8EkRu+JubmWlJ0f8tp9A8njkgD+JFSscqV7KUvthEFl8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Mon, 7 Dec
 2020 08:23:11 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3632.021; Mon, 7 Dec 2020
 08:23:11 +0000
Subject: Re: [PATCH] drm/amdgpu: change trace event parameter name from
 'driect' to 'immediate'
To: Kevin Wang <kevin1.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201207065643.29208-1-kevin1.wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <c74e5385-8464-8e19-4f37-bfe2c810fbb8@amd.com>
Date: Mon, 7 Dec 2020 09:23:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201207065643.29208-1-kevin1.wang@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.5 via Frontend Transport; Mon, 7 Dec 2020 08:23:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 95830099-fdca-42e0-88a1-08d89a8955e0
X-MS-TrafficTypeDiagnostic: MN2PR12MB4159:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41598B06600A95AE1A402E9683CE0@MN2PR12MB4159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: msLwPzASVe2KN6LJldklFWvy4IGwvXkvEKgyak52K7sGV4+Jy+uhQ59+BpG0OGjwZP7AY6Th4+a/Yzsafjftipg3/ZO4RkTv5yO/FVd4KkO0A3O+qAo88JLD+WIBCPw1Vf0NksVIguzK9lFbQOeL+BmoAH4+PQLJdUPkb5dC+Pf98pDtb+IiDuI6hWyLukcYfqaVgCnt+UgtjEQpJb++Ca59bFFgZrocZTbyX0bCVbOLs29PwDsTC2sn3BHRSbvOSBhdyVx4PNw++DGac7jp7fYHHoiBaJiwL1/2ZDrMHwg9bEHVFcqoCeuWFw52s7w9oZogkUQKIblgXgkTMh6LMgJQDuRQqtjnkuAlxl26ZKBRP4545YUJCaSQumOr9jEdUf9RrEv5C21chv3o+jxiGE5BYpvr8PykMyD7dkKpONcJrHWGjVKITtWOhEE7jc5z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(5660300002)(83380400001)(8936002)(478600001)(66574015)(52116002)(8676002)(86362001)(6666004)(316002)(66476007)(66556008)(2906002)(66946007)(36756003)(2616005)(31686004)(16526019)(186003)(6486002)(31696002)(14773001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RnBGZ1Azam43eGM0MkFPUTZMNENGWGdFNHVDWWt5TUdjNFFkUkYwTG41ZlA1?=
 =?utf-8?B?TUVSdmZTMjVqWEhBZ0l1MWdZc0FLeVhWTXd0TWVvRERleFhoTWpCTjVyUlFs?=
 =?utf-8?B?czNoOWxWQUhuQlFwR2poelFNN1dRWkhvck1tMjNMUXpqNTNoTEVmYXdTdUZY?=
 =?utf-8?B?UDFaeWhsMjU2bVhWNldyQzBGNEtwdGlFdkFITitxRVRJRnRLTkNZb1BRVHRC?=
 =?utf-8?B?QWJhWjQ0Vmk5OW1TSk4vR0FrMmxJMXJjVWpObUxoZnJpQ2Jxa2s0QThRaGdr?=
 =?utf-8?B?bzhHWWlaV05kMFRYUWdDSEZLbElMY3VldVpvWG9FaXdKczZOSzUrcWpkdnFI?=
 =?utf-8?B?VWR3SS9vaU01OUZlYlJUVHhUYkRmdjFxNk9sVm5vU0xvckpYWDRxVThCN3BQ?=
 =?utf-8?B?N1lBcXNvMUV3WkViTzJkc3dadUREd0FKYWdiRU5HQ2Mvc1RaYkxFZ0RZQWlp?=
 =?utf-8?B?UDRBbEQydFRJb1JYeHQvaVZMNjF1VkcxVXdtUGRlVnduQ1RISmx2eVppdzND?=
 =?utf-8?B?MEMzNWlyWDR4czY0NlN6UHdMcTRwaFo0OVVocEVPYjhtcjZkVWRKMFQzWEFU?=
 =?utf-8?B?Qm1yRGdJSTRZNnZmS1RoU1gzWStBVjJmTzA1V2NoNmJmMENNMzZMZ2ZuWWRr?=
 =?utf-8?B?bm1vOUJaYjR3MGo5eHNyRFN6MlI0YzVCMU12TlUxRFN4TkJGajJtejFqbkVG?=
 =?utf-8?B?U3ozZFFacmVlMHhFSlExMjF3dE56K0pEbHNmOE43akd1QlVMTGNMM3ZIWWtV?=
 =?utf-8?B?U0hPSTJLc2FKTFMvWVRBTCtKRnV3OXBkZTkxTnVMVURDSEhINjdzajQ0Mk5Q?=
 =?utf-8?B?aVYvZjd5dVZ1ZG5VdC9sd25KbFhnUmRQT3gvTGVxMmtGMFdPdTl6TmpyWURr?=
 =?utf-8?B?UWtzYVpjMEpTb3c4bXVZbWpaN2VEenVmQkFvVVgySkhvMTNqSS96cXQ0R0l1?=
 =?utf-8?B?QXkwN0RzdTRiMmsrcndwcTAvaDBRaTBWb2YwdGVWaHB5cTNFclIrblM5U3dH?=
 =?utf-8?B?KzA4aS9VRkRLd0xBZDFPNTFYdUl4ai9FMUpwdTd4Zk1uUy9keTArQUNoVG83?=
 =?utf-8?B?L3I0NU9qUVF1NWpnQi9kMzZKRm9nYS9YZ01KQlkva0VVRTV4dzQ1d0x1Rm9z?=
 =?utf-8?B?QnZ2RTRIL2hpVWhzNG94TUNHaDdvNHIzd3BoRjNYYlh1RktXa2tMeU5qaHgx?=
 =?utf-8?B?Q3JmdHNPNE83UW1MYUNZZUtJblhuUTVDNHY1a0x5ZlAyZ2tKQVdJaTRpelB0?=
 =?utf-8?B?Z2NaeWcwWk1IeVdJOVNCd0taTjIrRXNZQXBCejZITk52WlJrdUdTalE0N1BT?=
 =?utf-8?B?aEZEUGRZcDhMRURHQ29xNTNuNkV1dkdiWGpNa1RYU2VFMlZ2M3EvbktOODB1?=
 =?utf-8?B?ZEoyejEzRGIzMmVrN1g1WGNBck5ZQW93YUFXV2d3SkpqN2RSYlVUTUlJSFZa?=
 =?utf-8?Q?0lWzyT1A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 08:23:11.3301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 95830099-fdca-42e0-88a1-08d89a8955e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJIVhLPcflhQVL9AUvFh4JoKoAw7bPbMwfTkStIgpxXz6nsHZQ5Sae7bUpvTvhti
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
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

QW0gMDcuMTIuMjAgdW0gMDc6NTYgc2NocmllYiBLZXZpbiBXYW5nOgo+IHMvZGlyZWN0L2ltbWVk
aWF0ZS9nCj4KPiBhbWRncHUgdm0gaGFzIHJlbmFtZWQgcGFyYW1ldGVyIG5hbWUgZnJvbSAnZGly
ZWN0JyB0byAnaW1tZWRhdGUnLgo+IGhvd2V2ZXIsIHRoZSB0cmFjZSBldmVudCBpcyBub3QgdXBk
YXRlZCB5ZXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBLZXZpbiBXYW5nIDxrZXZpbjEud2FuZ0BhbWQu
Y29tPgpUaGVyZSBpcyBhIHNtYWxsIHR5cG8gaW4gdGhlIHN1YmplY3QgbGluZSAiZHJpZWN0Iiwg
YXBhcnQgZnJvbSB0aGF0IHRoZSAKcGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7Zu
aWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4uCgpUaGFua3MgZm9yIHJlbW92aW5nIG9uZSBp
dGVtIGZyb20gbXkgVE9ETyBsaXN0IDopCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+IC0tLQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmggfCAyNCArKysrKysrKysr
Ky0tLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEyIGRl
bGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV90cmFjZS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3RyYWNlLmgK
PiBpbmRleCBlZTk0ODBkMTRjYmMuLjMyNGQ1ZTNmMzU3OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHJhY2UuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90cmFjZS5oCj4gQEAgLTM2NiwxNSArMzY2LDE1IEBAIFRSQUNF
X0VWRU5UKGFtZGdwdV92bV91cGRhdGVfcHRlcywKPiAgIAo+ICAgVFJBQ0VfRVZFTlQoYW1kZ3B1
X3ZtX3NldF9wdGVzLAo+ICAgCSAgICBUUF9QUk9UTyh1aW50NjRfdCBwZSwgdWludDY0X3QgYWRk
ciwgdW5zaWduZWQgY291bnQsCj4gLQkJICAgICB1aW50MzJfdCBpbmNyLCB1aW50NjRfdCBmbGFn
cywgYm9vbCBkaXJlY3QpLAo+IC0JICAgIFRQX0FSR1MocGUsIGFkZHIsIGNvdW50LCBpbmNyLCBm
bGFncywgZGlyZWN0KSwKPiArCQkgICAgIHVpbnQzMl90IGluY3IsIHVpbnQ2NF90IGZsYWdzLCBi
b29sIGltbWVkaWF0ZSksCj4gKwkgICAgVFBfQVJHUyhwZSwgYWRkciwgY291bnQsIGluY3IsIGZs
YWdzLCBpbW1lZGlhdGUpLAo+ICAgCSAgICBUUF9TVFJVQ1RfX2VudHJ5KAo+ICAgCQkJICAgICBf
X2ZpZWxkKHU2NCwgcGUpCj4gICAJCQkgICAgIF9fZmllbGQodTY0LCBhZGRyKQo+ICAgCQkJICAg
ICBfX2ZpZWxkKHUzMiwgY291bnQpCj4gICAJCQkgICAgIF9fZmllbGQodTMyLCBpbmNyKQo+ICAg
CQkJICAgICBfX2ZpZWxkKHU2NCwgZmxhZ3MpCj4gLQkJCSAgICAgX19maWVsZChib29sLCBkaXJl
Y3QpCj4gKwkJCSAgICAgX19maWVsZChib29sLCBpbW1lZGlhdGUpCj4gICAJCQkgICAgICksCj4g
ICAKPiAgIAkgICAgVFBfZmFzdF9hc3NpZ24oCj4gQEAgLTM4MywzMiArMzgzLDMyIEBAIFRSQUNF
X0VWRU5UKGFtZGdwdV92bV9zZXRfcHRlcywKPiAgIAkJCSAgIF9fZW50cnktPmNvdW50ID0gY291
bnQ7Cj4gICAJCQkgICBfX2VudHJ5LT5pbmNyID0gaW5jcjsKPiAgIAkJCSAgIF9fZW50cnktPmZs
YWdzID0gZmxhZ3M7Cj4gLQkJCSAgIF9fZW50cnktPmRpcmVjdCA9IGRpcmVjdDsKPiArCQkJICAg
X19lbnRyeS0+aW1tZWRpYXRlID0gaW1tZWRpYXRlOwo+ICAgCQkJICAgKSwKPiAgIAkgICAgVFBf
cHJpbnRrKCJwZT0lMDEwTHgsIGFkZHI9JTAxMEx4LCBpbmNyPSV1LCBmbGFncz0lbGx4LCBjb3Vu
dD0ldSwgIgo+IC0JCSAgICAgICJkaXJlY3Q9JWQiLCBfX2VudHJ5LT5wZSwgX19lbnRyeS0+YWRk
ciwgX19lbnRyeS0+aW5jciwKPiAtCQkgICAgICBfX2VudHJ5LT5mbGFncywgX19lbnRyeS0+Y291
bnQsIF9fZW50cnktPmRpcmVjdCkKPiArCQkgICAgICAiaW1tZWRpYXRlPSVkIiwgX19lbnRyeS0+
cGUsIF9fZW50cnktPmFkZHIsIF9fZW50cnktPmluY3IsCj4gKwkJICAgICAgX19lbnRyeS0+Zmxh
Z3MsIF9fZW50cnktPmNvdW50LCBfX2VudHJ5LT5pbW1lZGlhdGUpCj4gICApOwo+ICAgCj4gICBU
UkFDRV9FVkVOVChhbWRncHVfdm1fY29weV9wdGVzLAo+IC0JICAgIFRQX1BST1RPKHVpbnQ2NF90
IHBlLCB1aW50NjRfdCBzcmMsIHVuc2lnbmVkIGNvdW50LCBib29sIGRpcmVjdCksCj4gLQkgICAg
VFBfQVJHUyhwZSwgc3JjLCBjb3VudCwgZGlyZWN0KSwKPiArCSAgICBUUF9QUk9UTyh1aW50NjRf
dCBwZSwgdWludDY0X3Qgc3JjLCB1bnNpZ25lZCBjb3VudCwgYm9vbCBpbW1lZGlhdGUpLAo+ICsJ
ICAgIFRQX0FSR1MocGUsIHNyYywgY291bnQsIGltbWVkaWF0ZSksCj4gICAJICAgIFRQX1NUUlVD
VF9fZW50cnkoCj4gICAJCQkgICAgIF9fZmllbGQodTY0LCBwZSkKPiAgIAkJCSAgICAgX19maWVs
ZCh1NjQsIHNyYykKPiAgIAkJCSAgICAgX19maWVsZCh1MzIsIGNvdW50KQo+IC0JCQkgICAgIF9f
ZmllbGQoYm9vbCwgZGlyZWN0KQo+ICsJCQkgICAgIF9fZmllbGQoYm9vbCwgaW1tZWRpYXRlKQo+
ICAgCQkJICAgICApLAo+ICAgCj4gICAJICAgIFRQX2Zhc3RfYXNzaWduKAo+ICAgCQkJICAgX19l
bnRyeS0+cGUgPSBwZTsKPiAgIAkJCSAgIF9fZW50cnktPnNyYyA9IHNyYzsKPiAgIAkJCSAgIF9f
ZW50cnktPmNvdW50ID0gY291bnQ7Cj4gLQkJCSAgIF9fZW50cnktPmRpcmVjdCA9IGRpcmVjdDsK
PiArCQkJICAgX19lbnRyeS0+aW1tZWRpYXRlID0gaW1tZWRpYXRlOwo+ICAgCQkJICAgKSwKPiAt
CSAgICBUUF9wcmludGsoInBlPSUwMTBMeCwgc3JjPSUwMTBMeCwgY291bnQ9JXUsIGRpcmVjdD0l
ZCIsCj4gKwkgICAgVFBfcHJpbnRrKCJwZT0lMDEwTHgsIHNyYz0lMDEwTHgsIGNvdW50PSV1LCBp
bW1lZGlhdGU9JWQiLAo+ICAgCQkgICAgICBfX2VudHJ5LT5wZSwgX19lbnRyeS0+c3JjLCBfX2Vu
dHJ5LT5jb3VudCwKPiAtCQkgICAgICBfX2VudHJ5LT5kaXJlY3QpCj4gKwkJICAgICAgX19lbnRy
eS0+aW1tZWRpYXRlKQo+ICAgKTsKPiAgIAo+ICAgVFJBQ0VfRVZFTlQoYW1kZ3B1X3ZtX2ZsdXNo
LAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
