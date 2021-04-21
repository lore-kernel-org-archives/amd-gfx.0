Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B96EC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 01:20:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE091613EE
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 01:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE091613EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FB9E6E930;
	Wed, 21 Apr 2021 01:20:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 761E06E930
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 01:20:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=milqYddUQaFeMgZq39O6ufRibI9vRhmNEZNTPbyHr0+Jjvp5dYsX0ypN1y1TagFTjhKAHop8xOpIJdnDqiCnvia8pDyYIyBUFEcdfyVW47wMm6Cn9TMwUIqKKJPs4ViJ99CqFQmymJrvPE3T0j5JyID28DKADXA2JxKHxrFe2aUPcafNTELqPD97yqdXjKM9n3scoMsAjVtzooOLjvZqlH7XGCeWSrDRv0HmfvBnSci8DOZ0nTUkbCBCvwZ44Pl2RoBJtQNZYAmd3lffoqXudOVK/0Z+TkZTiyasw4/svaPYvrGsqRFc6YV7SgEJBZH/Kp8QvQuLcGgYNSvJjJUnpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcbEyZl/CbGCMLf0c8Nc5MEvi9sbS+cklViy1y4ZCGE=;
 b=KCBcdbx3wqji53uZH84hBpLeJrAwjNdj4OE21K3Outxe5lkxC9SdHd9F4uKkt8zXPnQ+uI7W1EJiC1z1St1aX2f/ZsOXQmN85Iz5GB1FlNLZPU/N5r+/yaVx9QL8ojnv/TlDotqqheXL/tO7W+HBMuGwm/3GHBSYoXzJ8c46/RlUE0Q5VlRvfPKxWIYbsmvAHv4ZpKMOXPg3rDYxjFKN+L4Pr4f1aPNlL9LvT6q78eAGoP7yvZ7UytNdHPeZqx4wpV8hVQMHWAkrrrR97uswACOz/3U0818d3XWHZRGR1H2bGM3zrPmgjNWB1snGyy6J5171uPlCRg+tHwuZlpuggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcbEyZl/CbGCMLf0c8Nc5MEvi9sbS+cklViy1y4ZCGE=;
 b=OOp5MhcvHch648uGVo6QRdOTHy/C89u2k+k5QmV47D8zWYh4w+6bjAB/7pG/jh48iFcpPwbcf5VCjRRUM/wxNrr9fSc/+LA3AbHQnudXAUWzX49E8pEixXxTZDMOm0Iv0NlSJoiuIHWbqauOc6eCq2MPbOCxUTzN+eGK1tQqnDc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 01:20:28 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Wed, 21 Apr 2021
 01:20:28 +0000
Subject: Re: [PATCH 4/6] drm/amdgpu: address remove from fault filter
To: amd-gfx@lists.freedesktop.org, "Yang, Philip" <Philip.Yang@amd.com>
References: <20210420202122.4701-1-Philip.Yang@amd.com>
 <20210420202122.4701-4-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <d9ff9130-667f-1b5f-83b9-d7dc77743db3@amd.com>
Date: Tue, 20 Apr 2021 21:20:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210420202122.4701-4-Philip.Yang@amd.com>
Content-Language: en-US
X-Originating-IP: [142.182.180.233]
X-ClientProxiedBy: YT1PR01CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::35)
 To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.180.233) by
 YT1PR01CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21 via Frontend Transport; Wed, 21 Apr 2021 01:20:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45260313-6d73-4d71-fc4e-08d90463a5da
X-MS-TrafficTypeDiagnostic: MN2PR12MB4237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42373FF4D7D72C4FE8059D7E92479@MN2PR12MB4237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /LFCoBErnKm0U5fJGl7igt9I45uwYUew81SA5tLnlKIolfl1efucA7vCemBdv4qnu1+D64wJ/LU+P5/0eSLO/HxJo18GVxqTcsQnyKoY+ERpLDxNaciMW4Forwr1KhsznRjWGQzfJk2UgIZcZ0M3aXhJBe/uLu0Tpl7MChFcfC2h+rNhtIOrmdfOrmLJjlhIi+rLSYTChY0228w4HXhlCcbt1dW0ZqNlD5dMJndWGM+BqDvaXGp+aOFk8Ynz/ReKxELYvSplB36SJBK0w62gj/4dEUfYtp+FAAWFztHLuoZcIV6G59bvnuI8+BYXiOnI6dRqDxw3EWj/kdUkQpGW9Yno96F0OIwJiuMX1VhPUn8PYNgrCfkNwKw+Zx9XTrZouWO5jrJ6TTHQk9yKtL1F92W/ejh7lt3b8r+WRSZU1gOMGjTKIOxLafTch9TUtohSMF7cuxm62oiC1jpDx7eW5RB1YYKPQfn9KqbtPkl3LOIkfevz3MYHHeaU5Z1TKy3M3Thp+E6TvzweGOQCSno9noYWwyhWXIN79MJE5Rmma44iySCL5W5qOborTCg+I6Ee1pI+QcEPl8PfC9Fo8OImYLAfwj076UDYUqKH85dPRIUI6YOxqLr3ngNgH72C8Fz+nuixqGF26iO60WG12ybziz6JwnqPPpOGVNI8wegQKqxrFaG/6LEQ0d+enN9OmXUy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(31696002)(31686004)(83380400001)(44832011)(6636002)(66556008)(66946007)(478600001)(6862004)(2616005)(8936002)(5660300002)(26005)(86362001)(956004)(6486002)(38100700002)(36756003)(316002)(16526019)(186003)(66476007)(8676002)(37006003)(16576012)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NTlNd0ZyM1I2ck5zNHVDeDdla25TMVJaemVXZEh5bWQzdjVxUVlFUFVIRlly?=
 =?utf-8?B?eS9UTThiWEN6QVhzQWtrZnFQaCtjS203cHhDK0c2S1RTZGpOZ0dzMXFQS3Fo?=
 =?utf-8?B?ZS9Hb3ppTDQ4WWFtSUhYVVJpK0F4TElMOFRsSkw1NEJNWm1HSmFCbVliNE9i?=
 =?utf-8?B?cWtVbThiNzFHSzRnUHBJZkRyYXpiMktHZ21MdDZXVTIzQi9Yb09YdUdrMlk0?=
 =?utf-8?B?VW9ySHVGSE4vd21SdUxUY3NIUUpZK3NtRmtQWVA3V2J6T2pxNCsyZEhVUVM0?=
 =?utf-8?B?djZWa1R1eStQczdWcEVDbHYxRHFVWHE4OXd2TGhDN2dFcThLbERqQTd3MUJm?=
 =?utf-8?B?ckdaT2NXTlp5b2NVSVZZQTdUYkdjTEhTOHFSUTF4M2k2dzZWZkl5bnlYbzk3?=
 =?utf-8?B?STNwVmQwd0lZdURlZnZUYTE2QWZUZFlhRE5ZNElGb3UxRlRaMVFNNVR2NThq?=
 =?utf-8?B?QXdnVEg2UzhTQVBBMk1hSUZPaElqSEw5SWVkTlpzeUJoU0QzMTZoclVrVVhh?=
 =?utf-8?B?bm1FQnRVLzFjc0t0SjFjcE1YSlI4NDlQdmVWckpCSG93akxWMkpmUE1aNUhE?=
 =?utf-8?B?U3ZMOW1KR1ZBL2w5N3AzM3ZKMTNVRUhvNkhJaG5UNjRsNDA1VnFtYUdRTGZX?=
 =?utf-8?B?OHpoOWJsVVlpeTcrbUpqNUY5SGtDb2EycExwblJ1dVlXdUlycVE1ZzFQYUVE?=
 =?utf-8?B?ZE4zUXNMVHBLc3NEcEVqN1hPUGQ5TWl2SlJpV3JjR1Q3ZEQ3bDhGVHNDS1c2?=
 =?utf-8?B?b3lNTHBnUVcxKzRVZVhJNS9KejhvcjUwY3VQL2JKN2diWTBDZ3F3SS96RWw2?=
 =?utf-8?B?QVR1TzFGTGlMWmx5MFR3RXk0QXQxOVBEVUM0RytacXBpck5tV05TNVNDVVpN?=
 =?utf-8?B?UUNueXJVTy9Jem1uMEVYYkIwSmFqMHZyd2JiRHcwOFJ5cGJ3aWJOc3ltVHVO?=
 =?utf-8?B?LzB5SFNDZlN5b1JINFRIanljcUl6dzZ0R2dYL0JzbklhOThUT01La1dwY3pk?=
 =?utf-8?B?VDdVNXllU2JHajB3REc3K0wwQXltL2NmclE0UXlHMTVRSlo0ZSs3TFdHaVJJ?=
 =?utf-8?B?U3REcDdnRUhxN2VwV3BReFd2YTRUOGtZR2ZlRVMxaW0rYlpJbkdvWHYwRW9y?=
 =?utf-8?B?NzlJUTJDTmNoQlFXNDl0TFRGMGFneU5FTEFzWXM5bU53WlJHS0laWkNVUXox?=
 =?utf-8?B?STNxQVBCYnBiYk9nZ2p0TDBaV1hrNmI0MUl3TVJQWW1IUE5jbmZSblhKekZz?=
 =?utf-8?B?L0xpdlAzeG9EaFVHTEs0SXZFY21nZmhsalYwOC83UU1oeXlCRGo3UFo4VFlk?=
 =?utf-8?B?YlN5VmNwbytXWWNiZWNGejVwZG1XUks1a3F1VlZ3VUpNTXFkMnF3NUJkeHhL?=
 =?utf-8?B?K0JXQVhwaTdHSit6VlFOajBkVkt5VlJJdjRIU2M4cHRubGlWejI1TlAxcURU?=
 =?utf-8?B?T3NpclE0ZHZLZjlhR0FuMEk4WHAxQ2RheUFWK2ZDQXZzbUNvZi9LSzhwOWZE?=
 =?utf-8?B?R2pRWDlXeUVSM2M5MTUwWlZvd3poTEFjMC85S3hCVWllM2EycEw3eEkvamhZ?=
 =?utf-8?B?bVJYb21kbU9DaytXS1V6VHMyTW5ET0xvNCthdjlEL01HdTUzcEdJRkNhU0RM?=
 =?utf-8?B?Q1BVZEVTL3RJRjd1cU8vOWNET2dVUlFOWGJ1UzBmMlhFWG5XV3c3aUNqUCtx?=
 =?utf-8?B?Qi9UQTVaMms3YURzTHdCTDczSUV3ZjdiRm5wSnhVUmVFOFpia0FwalFzWmc1?=
 =?utf-8?B?VHNMekQvcUZDTkpJTkNpd3dLa2l1T0ZiUjlaMlFnTFBHVWJhNVV5NmRLZmdI?=
 =?utf-8?B?QWdhcHhNdTMxRHdBN05mZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45260313-6d73-4d71-fc4e-08d90463a5da
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 01:20:28.2293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHJyd/Oqa3NFf7wGzHRsLHb6gMv51Dw3HyQFyJRWa/Xg1zN+29Xcwd194uaZM+q9r280TQ3StYHQkzSP0dZB+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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

QW0gMjAyMS0wNC0yMCB1bSA0OjIxIHAubS4gc2NocmllYiBQaGlsaXAgWWFuZzoKPiBBZGQgaW50
ZXJmYWNlIHRvIHJlbW92ZSBhZGRyZXNzIGZyb20gZmF1bHQgZmlsdGVyIHJpbmcgYnkgcmVzZXR0
aW5nCj4gZmF1bHQgcmluZyBlbnRyeSBvZiB0aGUgZmF1bHQgYWRkcmVzcyB0aW1lc3RhbXAgdG8g
MCwgdGhlbiBmdXR1cmUgdm0KPiBmYXVsdCBvbiB0aGUgYWRkcmVzcyB3aWxsIGJlIHByb2Nlc3Nl
ZCB0byByZWNvdmVyLgo+Cj4gQ2hlY2sgZmF1bHQgYWRkcmVzcyBmcm9tIGZhdWx0IHJpbmcsIGFk
ZCBhZGRyZXNzIGludG8gZmF1bHQgcmluZyBhbmQKPiByZW1vdmUgYWRkcmVzcyBmcm9tIGZhdWx0
IHJpbmcgYXJlIHNlcmlhbGl6ZWQgaW4gc2FtZSBpbnRlcnJ1cHQgZGVmZXJyZWQKPiB3b3JrLCBk
b24ndCBoYXZlIHJhY2UgY29uZGl0aW9uLgo+Cj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwIFlhbmcg
PFBoaWxpcC5ZYW5nQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9nbWMuYyB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrKwo+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmggfCAgMiArKwo+ICAyIGZpbGVzIGNoYW5nZWQs
IDI2IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZ21jLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21j
LmMKPiBpbmRleCBjMzllZDllYjA5ODcuLjMzOGU0NWZhNjZjYiAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMKPiBAQCAtMzg3LDYgKzM4NywzMCBAQCBib29sIGFt
ZGdwdV9nbWNfZmlsdGVyX2ZhdWx0cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDY0
X3QgYWRkciwKPiAgCXJldHVybiBmYWxzZTsKPiAgfQo+ICAKPiArLyoqCj4gKyAqIGFtZGdwdV9n
bWNfZmlsdGVyX2ZhdWx0c19yZW1vdmUgLSByZW1vdmUgYWRkcmVzcyBmcm9tIFZNIGZhdWx0cyBm
aWx0ZXIKPiArICoKPiArICogQGFkZXY6IGFtZGdwdSBkZXZpY2Ugc3RydWN0dXJlCj4gKyAqIEBh
ZGRyOiBhZGRyZXNzIG9mIHRoZSBWTSBmYXVsdAo+ICsgKiBAcGFzaWQ6IFBBU0lEIG9mIHRoZSBw
cm9jZXNzIGNhdXNpbmcgdGhlIGZhdWx0Cj4gKyAqCj4gKyAqIFJlbW92ZSB0aGUgYWRkcmVzcyBm
cm9tIGZhdWx0IGZpbHRlciwgdGhlbiBmdXR1cmUgdm0gZmF1bHQgb24gdGhpcyBhZGRyZXNzCj4g
KyAqIHdpbGwgcGFzcyB0byByZXRyeSBmYXVsdCBoYW5kbGVyIHRvIHJlY292ZXIuCj4gKyAqLwo+
ICt2b2lkIGFtZGdwdV9nbWNfZmlsdGVyX2ZhdWx0c19yZW1vdmUoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsIHVpbnQ2NF90IGFkZHIsCj4gKwkJCQkgICAgIHVpbnQxNl90IHBhc2lkKQo+ICt7
Cj4gKwlzdHJ1Y3QgYW1kZ3B1X2dtYyAqZ21jID0gJmFkZXYtPmdtYzsKPiArCj4gKwl1aW50NjRf
dCBrZXkgPSBhZGRyIDw8IDQgfCBwYXNpZDsKPiArCXN0cnVjdCBhbWRncHVfZ21jX2ZhdWx0ICpm
YXVsdDsKPiArCXVpbnQzMl90IGhhc2g7Cj4gKwo+ICsJaGFzaCA9IGhhc2hfNjQoa2V5LCBBTURH
UFVfR01DX0ZBVUxUX0hBU0hfT1JERVIpOwo+ICsJZmF1bHQgPSAmZ21jLT5mYXVsdF9yaW5nW2dt
Yy0+ZmF1bHRfaGFzaFtoYXNoXS5pZHhdOwoKWW91IG5lZWQgdG8gbG9vcCBvdmVyIHRoZSBmYXVs
dCByaW5nIHRvIGZpbmQgYSBmYXVsdCB3aXRoIHRoZSBtYXRjaGluZwprZXkgc2luY2UgdGhlcmUg
bWF5IGJlIGhhc2ggY29sbGlzaW9ucy4KCllvdSBhbHNvIG5lZWQgdG8gbWFrZSBzdXJlIHlvdSBk
b24ndCBicmVhayB0aGUgc2luZ2xlIGxpbmsgbGlzdCBvZiBrZXlzCndpdGggdGhlIHNhbWUgaGFz
aCB3aGVuIHlvdSByZW1vdmUgYW4gZW50cnkuIEkgdGhpbmsgdGhlIGVhc2llciB3YXkgdG8KcmVt
b3ZlIGFuIGVudHJ5IHdpdGhvdXQgYnJlYWtpbmcgdGhpcyByaW5nK2Nsb3NlZCBoYXNoaW5nIHN0
cnVjdHVyZSBpcwp0byByZXNldCB0aGUgZmF1bHQtPmtleSByYXRoZXIgdGhhbiB0aGUgZmF1bHQt
PnRpbWVzdGFtcC4KCkZpbmFsbHksIHlvdSBuZWVkIHRvIGFkZCBsb2NraW5nIHRvIHRoZSBmYXVs
dCByaW5nIHN0cnVjdHVyZS4gQ3VycmVudGx5Cml0J3Mgbm90IHByb3RlY3RlZCBieSBhbnkgbG9j
a3MgYmVjYXVzZSBvbmx5IG9uZSB0aHJlYWQgKHRoZSBpbnRlcnJ1cHQKaGFuZGxlcikgYWNjZXNz
ZXMgaXQuIE5vdyB5b3UgaGF2ZSBhbm90aGVyIHRocmVhZCB0aGF0IGNhbiByZW1vdmUKZW50cmll
cywgc28geW91IG5lZWQgdG8gcHJvdGVjdCBpdCB3aXRoIGEgbG9jay4gSWYgeW91IGFyZSBoYW5k
bGluZwpyZXRyeSBmYXVsdHMsIHlvdSBrbm93IHRoYXQgdGhlIGludGVycnVwdCBoYW5kbGVyIGlz
IHJlYWxseSBhIHdvcmtlcgp0aHJlYWQsIHNvIHlvdSBjYW4gdXNlIGEgbXV0ZXggb3IgYSBzcGlu
LWxvY2ssIGJ1dCBpdCBkb2Vzbid0IG5lZWQgdG8gYmUKaW50ZXJydXB0LXNhZmUuCgpSZWdhcmRz
LArCoCBGZWxpeAoKCj4gKwlmYXVsdC0+dGltZXN0YW1wID0gMDsKPiArfQo+ICsKPiAgaW50IGFt
ZGdwdV9nbWNfcmFzX2xhdGVfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgewo+
ICAJaW50IHI7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9nbWMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaAo+IGluZGV4
IDlkMTFjMDJhMzkzOC4uNDk4YTdhMGQ1YTllIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9nbWMuaAo+IEBAIC0zMTgsNiArMzE4LDggQEAgdm9pZCBhbWRncHVfZ21jX2Fn
cF9sb2NhdGlvbihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgCQkJICAgICBzdHJ1Y3Qg
YW1kZ3B1X2dtYyAqbWMpOwo+ICBib29sIGFtZGdwdV9nbWNfZmlsdGVyX2ZhdWx0cyhzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwgdWludDY0X3QgYWRkciwKPiAgCQkJICAgICAgdWludDE2X3Qg
cGFzaWQsIHVpbnQ2NF90IHRpbWVzdGFtcCk7Cj4gK3ZvaWQgYW1kZ3B1X2dtY19maWx0ZXJfZmF1
bHRzX3JlbW92ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDY0X3QgYWRkciwKPiAr
CQkJCSAgICAgdWludDE2X3QgcGFzaWQpOwo+ICBpbnQgYW1kZ3B1X2dtY19yYXNfbGF0ZV9pbml0
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKPiAgdm9pZCBhbWRncHVfZ21jX3Jhc19maW5p
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKPiAgaW50IGFtZGdwdV9nbWNfYWxsb2NhdGVf
dm1faW52X2VuZyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
