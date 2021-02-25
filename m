Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF011C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 15:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D94C64F20
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 15:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D94C64F20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6CF96ECB5;
	Thu, 25 Feb 2021 15:35:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 153A96E1F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 15:35:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWFEhWS+5quJTlL3GHuayT9Aq3JXshqEZag8xwzFpnqE5tEFGoze8kAzKRawtBrX+nUyP3gfCH4d58qlfIJV8338E0oc8oQPUdms7pEl+7EkP5ZaQDE8VJHN6L7W0uPrMvPXHiUf/pc+U1st2NLxqY9gFQOIBXP6jGNJYS6NkQa9rdwQVS+9FAl2Lm+zWGsq73F+35XEMMAPzjHORKKuPf/SCFqEpqeT1doLcVc0tX4rsgO1/uS7o1q0ZiDahpHKBGRvTBUPnLug+B9EWrAKlDta4zqKfc7/NH8gvExJksUFCiArVy8bPYlzjx8BAuusH13lRfq4nPjtcOkBRlwX5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09eMt12ZyH8Uq+p38r8+TqP52YSmqHPc8VIYtIPkSbA=;
 b=PmS7B/LtYCdAPlg50h60VVN1DXkLM5StcxYAlWYJJieKtcSD5q7KNSmV6YiCkRBYNC84thtX4YczzMlXEMTqpSz5AztEDYpHpKTpGjUcMcVCUEC5fJ2yWvh2bx1ZdjZA1nBUICsEUDKAdJwaI/vupou+KDv2bHTMo9aWW0kOIbfEZslRiSHXsHby02r4aAhRxNyrFCuXN9aW45GQ0F/tcd6hH2+STQ4Y76v1LzSW5n19hmS/6W6SnDXp1J139CL4Y+z5pxWjJiPbjiBJxQaHCGso/yEuW1gzm5J5g1aA74vfh5xr0Q8KGbWs+D0PWnU7AP9wQb5Q1yCaUjjW4CtWPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09eMt12ZyH8Uq+p38r8+TqP52YSmqHPc8VIYtIPkSbA=;
 b=TsOLsydikdBX3fBITPhMiCgx511lgMBpp84C0rs7eVPpY+v7zRJ4qX99evmCHwppCiIjkEeWQdMoJ6K9RjEbPRj6R36pBWj5qxqTKEezNbux9JW+0fksMfoW2r2viVqHxS/4+4HNpqQTlsElX0js5k6kyR6tkTTbYfaycmj5TYY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB4930.namprd12.prod.outlook.com (2603:10b6:208:1c8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Thu, 25 Feb
 2021 15:35:31 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%8]) with mapi id 15.20.3784.030; Thu, 25 Feb 2021
 15:35:31 +0000
Subject: Re: [PATCH] drm/amdgpu: add ih call to process until checkpoint
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210223211026.116403-1-jonathan.kim@amd.com>
 <6d30f52e-7a7a-5662-a66f-db832b8386ae@amd.com>
 <DM5PR12MB4680F60D6590680E40A90AF5859F9@DM5PR12MB4680.namprd12.prod.outlook.com>
 <92ddf2b3-3ee7-d481-2794-b57daed40ef9@amd.com>
 <8650a46f-f40d-d627-42a5-d9d760400086@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <00ce83e0-a000-913b-57a1-53c07fdfcdef@amd.com>
Date: Thu, 25 Feb 2021 10:35:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <8650a46f-f40d-d627-42a5-d9d760400086@gmail.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YT1PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::13) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YT1PR01CA0044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.32 via Frontend Transport; Thu, 25 Feb 2021 15:35:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9fc16745-d3a3-472b-47da-08d8d9a2fc06
X-MS-TrafficTypeDiagnostic: BL0PR12MB4930:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4930FCF5549D362F35B8E94F929E9@BL0PR12MB4930.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBDtcRIZUSzprvJ1pbvHthM3323ywoJkJfTrUsdKY7JBpKY57FHB0u5hpjYETop0fsmUZgS0BcGb8equEBqUdC5+5GYwy0Slwfs08BBWkF342XwQLQI6FuplkIWxWnzpBJrnOmiDK9s1hHne++84ILRGGdWCO747a0iOYFnNUTZ6UAy+h9xHMU30hTAhUFW2ayIn29ebCG+HFlZfZYHvLc3lmCVjbOKO8Xjk7zMI1XlKcoob/007xnhloJGNUn9dofqiifqoylak0GFgb6LR0CD+I48NQzlHa2dUDMTviqyvl9vWhEg10rOkMANnDFOoVISo5uStQ6cSO04IHUnFX7uMlaVxpkb2fJTv9FRQjq2dfKj//RcedCMZDISGqoU7RZezjOfKhOQaryC1tRGNeKxY11NL+RUTXX2WnDfCwqfr/DgKmuHi9e48K12f4qOed2TwRvi03z6vyKqS/xeq7KhaT4bZsyzZpYVzKXp8hldoofXIhUZyRKjT0GoR/KnnxaPSQjwviJCbxgzvNFTrQZ7Yb14v8oWD8RhXvTjvMeEoOI7zc9PmzLD5IRvIvVq8k6IPH+doQgnWVwFppU0uDCuYC4h7mrG+i/TCFRJoAnSeI65mIcGEfs9jlso3sj5nqYVeoICUvA67fWk++dDNWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(2906002)(2616005)(956004)(110136005)(6486002)(66946007)(44832011)(316002)(8936002)(16576012)(86362001)(83380400001)(16526019)(186003)(478600001)(66476007)(66556008)(36756003)(5660300002)(45080400002)(31686004)(8676002)(52116002)(66574015)(26005)(4326008)(53546011)(966005)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SVhzWnZSWXRxSXBpeDhPOUFwNlVyMDVrZjFRSExIeENTWEdNZDEwOGdRdGNC?=
 =?utf-8?B?c0tENTh5bGoyejNQRFU4QUJyUXBOYWprUGlmVnFVWDUrdWVaclpOblRkb0k5?=
 =?utf-8?B?MWF5aGtQTG0xMU1zVzhPU2x2SHFtSXVJSGVUdXNDc0FSa3N6dG9Gd2lTNzJh?=
 =?utf-8?B?TW8xeWYzWEFqOEtIR3ZtTmU2Vlhhb3U1bFpteFlYZUlNNURUdTRMOW0wN01n?=
 =?utf-8?B?L3A3WHd0SmhvUG90c2hMMkxsNXBDdTBXblJ6NG1ZSmxzWnNxcm1iUHlOMUdB?=
 =?utf-8?B?RlBaQ1paQkg4bUR6d2Q1OVEvS2VQT1dnWW4vZVJzaDBlU0ovYkdBM0g1SFU2?=
 =?utf-8?B?UU5XWTRiL0FMajdMdFA2Yk45RGJFektjd05uaW9VL3ZTOW9IancwS0NOM3U1?=
 =?utf-8?B?YnRnb3EwenFpd1J2NTFubGZpUDV4N0hKZkFxeWxRM0M3V3pFTE4xVGMxaVp1?=
 =?utf-8?B?NnZOalpYanB4eWtxL0NuaHQybG9mY3NhQ0pSNmdObEZEQk1Sa2RKUXFQRkds?=
 =?utf-8?B?S2N5OUs0Z05kYzBRdnZmN1VYNVhOTFpHOVZLdnJsUEtPNjBtTklYZ29yRFBH?=
 =?utf-8?B?a3RLUnZDcWYxd1RXQmZ0VkI4TGlKWG1NVFpyQ2ZwMlFaSU9wMGpXSTBjYW0y?=
 =?utf-8?B?RXE2L0tCMVRGRDdNbms1ZTREamRQQWdnVVYybW8xL2REQVdQVHRzU0ZEU0Jm?=
 =?utf-8?B?d2tyMVZmOHdpMGFkdVhKQVVQVERIZFZQWWpaUmZrRmJNbFUrSnhSKzhoN294?=
 =?utf-8?B?ZWtPMXlsQlpPNmZ0UDJJTWFxMjl2ajJDd0R3anFENkF1aUNXVnYwZk1sbmN2?=
 =?utf-8?B?YVkwc25HdXBIT0NOM2ROOUFBdTlZNStKcDRuVGh6c1oxcWl1Uy9la2prOFJK?=
 =?utf-8?B?aG5XWlQ2a1kwN3FzMjVPZTNMM3FxUGJzMHo1alFLeFlHRERVNk1QeElZOXJz?=
 =?utf-8?B?OE9xRm5VUTBDbVhHYlRxR1gvU3FaZGhQY01sano3dUlzQ1o4YThwcEROTW1N?=
 =?utf-8?B?K2FlbmFwTVNTRzNuSDc0c0EwYXlwTWhoS3pBUkE4VUFzR3l4Vkc1bDQ0OGlr?=
 =?utf-8?B?Y2JXNDVRUTd3SXgyb250NlJQcnNTd1lpT2dUd2tTQ1k2aVBOb2NCOTBBZVFB?=
 =?utf-8?B?T2pvYnFoQzlVUTl6WGcxdVNuMW9SR28yZkd6ZXo3elpqbTlmR2pDVWd6bHl1?=
 =?utf-8?B?YzJlK3hUTVBWNnRoempWZUpFdU96RkFydzBlQm1wNWsxUkRDeklCRUMrN0ZU?=
 =?utf-8?B?SzNja2xPNXJXZ3hTOGVvYVpldDZDNTdIc1R4VEdZcW56RVprR0pmbytRcC8r?=
 =?utf-8?B?QlBUZmlrS0RzOVFacW9hcnNWOUh0SnJUQWVpUGdwSU5xZ25LbnFOalZRUmhQ?=
 =?utf-8?B?RnZWRytJaS95ZC94Wi9GNXRFTE9XR29iMEdqeS9Rc2p1a2ZjVXJTbkJ4YVlJ?=
 =?utf-8?B?VkdnbUI2RU9qcXRSRlN4WkwwYk0vTk5Oc1prbGNkWGRGOFg1R0pPZkMzYXFE?=
 =?utf-8?B?SUdncmYvWnN1ZHE1dG0rOG14ZlJmNzFSQnhDMUlDR0tKUm03cENtbkdESEpN?=
 =?utf-8?B?Yk9wbGo0K3BYNUZ0OTZiRDQ4U0ZhdXZuUG9wMVVVNW9wVkFjOWxhWHRCL01t?=
 =?utf-8?B?SnVuQnpZaHlMK2FxaWc2SzFTR1dDUWxMaWhEV0lMQzRvVFhkck5jcDNoSEtu?=
 =?utf-8?B?ZEdhZnNNeUdTVGs4K29xQmtNWGFsT2QwZmhDZ24wRkU0RjJNdzRsM2ppU3di?=
 =?utf-8?B?ZEozN2NqU0YrTXVkYzh6WFlOdzl1elVwUmVyVkdMOTlybW9QcEZ6VTBoOVdW?=
 =?utf-8?B?OUExS0xPTlN0ZVBVK2FpZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc16745-d3a3-472b-47da-08d8d9a2fc06
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 15:35:31.2410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEbQqCaCxIpG5xpujHOGanGmXJjs/r2Ug3Sygt5Ts1KGNYQ1jHlaNB525NtTzFP+u/rUM6SaEo7BahAlq/rAgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4930
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wMi0yNSB1bSA4OjUzIGEubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+Cj4K
PiBBbSAyNS4wMi4yMSB1bSAwNDoxNSBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+PiBPbiAyMDIx
LTAyLTI0IDEwOjU0IGEubS4sIEtpbSwgSm9uYXRoYW4gd3JvdGU6Cj4+PiBbQU1EIE9mZmljaWFs
IFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldCj4+Pgo+Pj4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tCj4+Pj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlh
bi5Lb2VuaWdAYW1kLmNvbT4KPj4+PiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDI0LCAyMDIx
IDQ6MTcgQU0KPj4+PiBUbzogS2ltLCBKb25hdGhhbiA8Sm9uYXRoYW4uS2ltQGFtZC5jb20+OyBh
bWQtCj4+Pj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+Pj4+IENjOiBZYW5nLCBQaGlsaXAg
PFBoaWxpcC5ZYW5nQGFtZC5jb20+OyBLdWVobGluZywgRmVsaXgKPj4+PiA8RmVsaXguS3VlaGxp
bmdAYW1kLmNvbT4KPj4+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBhZGQgaWgg
Y2FsbCB0byBwcm9jZXNzIHVudGlsCj4+Pj4gY2hlY2twb2ludAo+Pj4+Cj4+Pj4gQW0gMjMuMDIu
MjEgdW0gMjI6MTAgc2NocmllYiBKb25hdGhhbiBLaW06Cj4+Pj4+IEFkZCBJSCBmdW5jdGlvbiB0
byBhbGxvdyBjYWxsZXIgdG8gcHJvY2VzcyByaW5nIGVudHJpZXMgdW50aWwgdGhlCj4+Pj4+IGNo
ZWNrcG9pbnQgd3JpdGUgcG9pbnRlci4KPj4+PiBUaGlzIG5lZWRzIGEgYmV0dGVyIGRlc2NyaXB0
aW9uIG9mIHdoYXQgdGhpcyB3aWxsIGJlIHVzZWQgZm9yLgo+Pj4gRmVsaXggb3IgUGhpbGlwIGNv
dWxkIGVsYWJvcmF0ZSBiZXR0ZXIgZm9yIEhNTSBuZWVkcy4KPj4+IERlYnVnZ2luZyB0b29scyBy
ZXF1aXJlcyB0aGlzIGJ1dCBpdCdzIGluIGV4cGVyaW1lbnRhbCBtb2RlIGF0IHRoZQo+Pj4gbW9t
ZW50IHNvIHByb2JhYmx5IG5vdCB0aGUgYmVzdCBwbGFjZSB0byBkZXNjcmliZSBoZXJlLgo+Pgo+
PiBPbiB0aGUgSE1NIHNpZGUgd2UncmUgcGxhbm5pbmcgdG8gdXNlIHRoaXMgdG8gZHJhaW4gcGVu
ZGluZyBwYWdlCj4+IGZhdWx0IGludGVycnVwdHMgYmVmb3JlIHdlIHVubWFwIG1lbW9yeS4gVGhh
dCBzaG91bGQgYWRkcmVzcyBwaGFudG9tCj4+IFZNIGZhdWx0cyBhZnRlciBtZW1vcnkgaXMgdW5t
YXBwZWQuCj4KPiBUaG91Z2h0IHNvLiBJIHN1Z2dlc3QgdG8gdXNlIGEgd2FpdF9ldmVudCgpIGhl
cmUgd2hpY2ggb24gdGhlIHdhaXRlcgo+IHNpZGUgY2hlY2tzIGloLT5sb2NrIGFuZCBhZGQgYSB3
YWtlX3VwX2FsbCgpIGF0IHRoZSBlbmQgb2YKPiBhbWRncHVfaWhfcHJvY2Vzcy4gCgpSaWdodC4g
SSB0aG91Z2h0IGFib3V0IHRoYXQgYW5kIGl0IHNob3VsZCBiZSBlYXN5IHRvIGFkZC4gVGhlIHJl
YXNvbiB0bwpzdWdnZXN0IGJ1c3kgd2FpdGluZyBmaXJzdCBpcywgdGhhdCBpbnRlcnJ1cHQgcHJv
Y2Vzc2luZyBpcyBzdXBwb3NlZCB0bwpiZSBmYXN0LiBUaGUgSVJRIGhhbmRsZXIgaXRzZWxmIGRv
ZXNuJ3Qgc2xlZXAuIFNvIEknZCBleHBlY3QgdGhlIHdhaXQKdGltZSB0byBiZSBzaG9ydCBlbm91
Z2ggdGhhdCBzbGVlcGluZyBhbmQgc2NoZWR1bGluZyBpcyBub3Qgd29ydGggaXQuCgoKPiBJIHdv
bid0IHRvdWNoIHJwdHIgb3Igd3B0ciBhdCBhbGwgZm9yIHRoaXMuCgpOb3Qgc3VyZSB3aGF0J3Mg
eW91ciBpZGVhIGhlcmUsIHVzaW5nIGloLT5sb2NrLiBJcyBpdCB0byBjb21wbGV0ZWx5CmRyYWlu
IGFsbCBJUlFzIHVudGlsIHRoZSBJSCByaW5nIGlzIGNvbXBsZXRlbHkgZW1wdHk/IFRoYXQgY2Fu
CmxpdmUtbG9jaywgaWYgdGhlIEdQVSBwcm9kdWNlcyBJUlFzIGZhc3RlciB0aGFuIHRoZSBrZXJu
ZWwgY2FuIHByb2Nlc3MKdGhlbS4gVGhlcmVmb3JlIEkgd2FzIGxvb2tpbmcgYXQgcnB0ciBhbmQg
d3B0ciB0byBkcmFpbiBvbmx5IElSUXMgdGhhdAp3ZXJlIGFscmVhZHkgaW4gdGhlIHF1ZXVlIHdo
ZW4gdGhlIGRyYWluIGNhbGwgd2FzIG1hZGUuIFRoYXQgYWxzbwplbnN1cmVzIHRoYXQgdGhlIHdh
aXQgdGltZSBpcyBib3VuZGVkIGFuZCBzaG91bGQgYmUgc2hvcnQgKHVubGVzcyB0aGUKcmluZyBz
aXplIGlzIGh1Z2UpLgoKUmVnYXJkcywKwqAgRmVsaXgKCgo+Cj4gUmVnYXJkcywKPiBDaHJpc3Rp
YW4uCj4KPj4KPj4gUmVnYXJkcywKPj4gwqAgRmVsaXgKPj4KPj4KPj4+Cj4+Pj4+IFN1Z2dlc3Rl
ZC1ieTogRmVsaXggS3VlaGxpbmcgPGZlbGl4Lmt1ZWhsaW5nQGFtZC5jb20+Cj4+Pj4+IFNpZ25l
ZC1vZmYtYnk6IEpvbmF0aGFuIEtpbSA8am9uYXRoYW4ua2ltQGFtZC5jb20+Cj4+Pj4+IC0tLQo+
Pj4+PiDCoMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9paC5jIHwgNDYKPj4+
PiArKysrKysrKysrKysrKysrKysrKysrKysrLQo+Pj4+PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfaWguaCB8wqAgMiArKwo+Pj4+PiDCoMKgIDIgZmlsZXMgY2hhbmdlZCwgNDcg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4+Pgo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2loLmMKPj4+Pj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfaWguYwo+Pj4+PiBpbmRleCBkYzg1MmFmNGYzYjcuLmNhZTUw
YWY5NTU5ZCAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2loLmMKPj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lo
LmMKPj4+Pj4gQEAgLTIyLDcgKzIyLDcgQEAKPj4+Pj4gwqDCoMKgICovCj4+Pj4+Cj4+Pj4+IMKg
wqAgI2luY2x1ZGUgPGxpbnV4L2RtYS1tYXBwaW5nLmg+Cj4+Pj4+IC0KPj4+Pj4gKyNpbmNsdWRl
IDxsaW51eC9wcm9jZXNzb3IuaD4KPj4+Pj4gwqDCoCAjaW5jbHVkZSAiYW1kZ3B1LmgiCj4+Pj4+
IMKgwqAgI2luY2x1ZGUgImFtZGdwdV9paC5oIgo+Pj4+Pgo+Pj4+PiBAQCAtMTYwLDYgKzE2MCw1
MCBAQCB2b2lkIGFtZGdwdV9paF9yaW5nX3dyaXRlKHN0cnVjdAo+Pj4+IGFtZGdwdV9paF9yaW5n
ICppaCwgY29uc3QgdWludDMyX3QgKml2LAo+Pj4+PiDCoMKgIH0KPj4+Pj4gwqDCoCB9Cj4+Pj4+
Cj4+Pj4+ICsvKioKPj4+Pj4gKyAqIGFtZGdwdV9paF93YWl0X29uX2NoZWNrcG9pbnRfcHJvY2Vz
cyAtIHdhaXQgdG8gcHJvY2VzcyBJVnMgdXAgdG8KPj4+Pj4gK2NoZWNrcG9pbnQKPj4+Pj4gKyAq
Cj4+Pj4+ICsgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCj4+Pj4+ICsgKiBAaWg6IGlo
IHJpbmcgdG8gcHJvY2Vzcwo+Pj4+PiArICoKPj4+Pj4gKyAqIFVzZWQgdG8gZW5zdXJlIHJpbmcg
aGFzIHByb2Nlc3NlZCBJVnMgdXAgdG8gdGhlIGNoZWNrcG9pbnQgd3JpdGUKPj4+PiBwb2ludGVy
Lgo+Pj4+PiArICovCj4+Pj4+ICtpbnQgYW1kZ3B1X2loX3dhaXRfb25fY2hlY2twb2ludF9wcm9j
ZXNzKHN0cnVjdCBhbWRncHVfZGV2aWNlCj4+Pj4gKmFkZXYsCj4+Pj4+ICtzdHJ1Y3QgYW1kZ3B1
X2loX3JpbmcgKmloKQo+Pj4+PiArewo+Pj4+PiArdTMyIHByZXZfcnB0ciwgY3VyX3JwdHIsIGNo
ZWNrcG9pbnRfd3B0cjsKPj4+Pj4gKwo+Pj4+PiAraWYgKCFpaC0+ZW5hYmxlZCB8fCBhZGV2LT5z
aHV0ZG93bikKPj4+Pj4gK3JldHVybiAtRU5PREVWOwo+Pj4+PiArCj4+Pj4+ICtjdXJfcnB0ciA9
IFJFQURfT05DRShpaC0+cnB0cik7Cj4+Pj4+ICsvKiBPcmRlciByZWFkIG9mIGN1cnJlbnQgcnB0
ciB3aXRoIGNoZWNrdHBvaW50IHdwdHIuICovCj4+Pj4+ICttYigpOwo+Pj4+PiArY2hlY2twb2lu
dF93cHRyID0gYW1kZ3B1X2loX2dldF93cHRyKGFkZXYsIGloKTsKPj4+Pj4gKwo+Pj4+PiArLyog
YWxsb3cgcnB0ciB0byB3cmFwIGFyb3VuZMKgICovCj4+Pj4+ICtpZiAoY3VyX3JwdHIgPiBjaGVj
a3BvaW50X3dwdHIpIHsKPj4+Pj4gK3NwaW5fYmVnaW4oKTsKPj4+Pj4gK2RvIHsKPj4+Pj4gK3Nw
aW5fY3B1X3JlbGF4KCk7Cj4+Pj4+ICtwcmV2X3JwdHIgPSBjdXJfcnB0cjsKPj4+Pj4gK2N1cl9y
cHRyID0gUkVBRF9PTkNFKGloLT5ycHRyKTsKPj4+Pj4gK30gd2hpbGUgKGN1cl9ycHRyID49IHBy
ZXZfcnB0cik7Cj4+Pj4+ICtzcGluX2VuZCgpOwo+Pj4+IFRoYXQncyBhIGNlcnRhaW4gTkFLIHNp
bmNlIGl0IGJ1c3kgd2FpdHMgZm9yIElIIHByb2Nlc3NpbmcuIFdlIG5lZWQKPj4+PiBzb21lCj4+
Pj4gZXZlbnQgdG8gdHJpZ2dlciBoZXJlLgo+Pj4gVGhlIGZ1bmN0aW9uIGlzIG1lYW50IHRvIGJl
IGp1c3QgYSB3YWl0ZXIgdXAgdG8gdGhlIGNoZWNrcG9pbnQuCj4+PiBUaGVyZSdzIGEgbmVlZCB0
byBndWFyYW50ZWUgdGhhdCAic3RhbGUiIGludGVycnVwdHMgaGF2ZSBiZWVuCj4+PiBwcm9jZXNz
ZWQgb24gY2hlY2sgYmVmb3JlIGRvaW5nIG90aGVyIHN0dWZmIGFmdGVyIGNhbGwuCj4+PiBUaGUg
ZGVzY3JpcHRpb24gY291bGQgYmUgaW1wcm92ZWQgdG8gY2xhcmlmeSB0aGF0Lgo+Pj4KPj4+IFdv
dWxkIGJ1c3kgd2FpdGluZyBvbmx5IG9uIGEgbG9ja2VkIHJpbmcgaGVscD/CoCBJIGFzc3VtZSBh
biB1bmxvY2tlZAo+Pj4gcmluZyBtZWFucyBub3RoaW5nIHRvIHByb2Nlc3Mgc28gbm8gbmVlZCB0
byB3YWl0IGFuZCB3ZSBjYW4gZXhpdAo+Pj4gZWFybHkuwqAgT3IgaXMgaXQgYmV0dGVyIHRvIGp1
c3QgdG8gcHJvY2VzcyB0aGUgZW50cmllcyB1cCB0byB0aGUKPj4+IGNoZWNrcG9pbnQgKG1heWJl
IGFkanVzdCBhbWRncHVfaWhfcHJvY2VzcyBmb3IgdGhpcyBuZWVkIGxpa2UgYWRkaW5nCj4+PiBh
IGJvb2wgYXJnIHRvIHNraXAgcmVzdGFydCBvciBzb21ldGhpbmcpPwo+Pj4KPj4+IFRoYW5rcywK
Pj4+Cj4+PiBKb24KPj4+Cj4+Pj4+ICt9Cj4+Pj4+ICsKPj4+Pj4gKy8qIHdhaXQgZm9yIHJwdHIg
dG8gY2F0Y2ggdXAgdG8gb3IgcGFzcyBjaGVja3BvaW50LiAqLwo+Pj4+PiArc3Bpbl9iZWdpbigp
Owo+Pj4+PiArZG8gewo+Pj4+PiArc3Bpbl9jcHVfcmVsYXgoKTsKPj4+Pj4gK3ByZXZfcnB0ciA9
IGN1cl9ycHRyOwo+Pj4+PiArY3VyX3JwdHIgPSBSRUFEX09OQ0UoaWgtPnJwdHIpOwo+Pj4+PiAr
fSB3aGlsZSAoY3VyX3JwdHIgPj0gcHJldl9ycHRyICYmIGN1cl9ycHRyIDwgY2hlY2twb2ludF93
cHRyKTsKPj4+PiBTYW1lIG9mIGNvdXJzZSBoZXJlLgo+Pj4+Cj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+
Cj4+Pj4+ICtzcGluX2VuZCgpOwo+Pj4+PiArCj4+Pj4+ICtyZXR1cm4gMDsKPj4+Pj4gK30KPj4+
Pj4gKwo+Pj4+PiDCoMKgIC8qKgo+Pj4+PiDCoMKgwqAgKiBhbWRncHVfaWhfcHJvY2VzcyAtIGlu
dGVycnVwdCBoYW5kbGVyCj4+Pj4+IMKgwqDCoCAqCj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWguaAo+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9paC5oCj4+Pj4+IGluZGV4IDZlZDRhODVmYzdjMy4uNjgxN2YwYTgx
MmQyIDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
aWguaAo+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWguaAo+
Pj4+PiBAQCAtODcsNiArODcsOCBAQCBpbnQgYW1kZ3B1X2loX3JpbmdfaW5pdChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKPj4+PiBzdHJ1Y3QgYW1kZ3B1X2loX3JpbmcgKmloLAo+Pj4+PiDC
oMKgIHZvaWQgYW1kZ3B1X2loX3JpbmdfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwg
c3RydWN0Cj4+Pj4gYW1kZ3B1X2loX3JpbmcgKmloKTsKPj4+Pj4gwqDCoCB2b2lkIGFtZGdwdV9p
aF9yaW5nX3dyaXRlKHN0cnVjdCBhbWRncHVfaWhfcmluZyAqaWgsIGNvbnN0Cj4+Pj4+IHVpbnQz
Ml90ICppdiwKPj4+Pj4gwqDCoMKgwqAgdW5zaWduZWQgaW50IG51bV9kdyk7Cj4+Pj4+ICtpbnQg
YW1kZ3B1X2loX3dhaXRfb25fY2hlY2twb2ludF9wcm9jZXNzKHN0cnVjdCBhbWRncHVfZGV2aWNl
Cj4+Pj4gKmFkZXYsCj4+Pj4+ICtzdHJ1Y3QgYW1kZ3B1X2loX3JpbmcgKmloKTsKPj4+Pj4gwqDC
oCBpbnQgYW1kZ3B1X2loX3Byb2Nlc3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVj
dAo+Pj4+IGFtZGdwdV9paF9yaW5nICppaCk7Cj4+Pj4+IMKgwqAgdm9pZCBhbWRncHVfaWhfZGVj
b2RlX2l2X2hlbHBlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4+Pj4gwqDCoCBzdHJ1
Y3QgYW1kZ3B1X2loX3JpbmcgKmloLAo+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwo+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91
dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWls
bWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4JmFtcDtkYXRhPTA0JTdDMDElN0NmZWxpeC5rdWVobGlu
ZyU0MGFtZC5jb20lN0M4NGQ4NWU1NGJkY2I0NTkzZTA3ZjA4ZDhkOTk0YmU3NyU3QzNkZDg5NjFm
ZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc0OTg1ODAxNjczMTMxOTMlN0NV
bmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklp
TENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMTAwMCZhbXA7c2RhdGE9UnZSSEI5bDRP
JTJCcGJwb2dVRktVbW5NR2txS25lY3dRQ1lSSHJreElDRHFVJTNEJmFtcDtyZXNlcnZlZD0wCj4+
Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
