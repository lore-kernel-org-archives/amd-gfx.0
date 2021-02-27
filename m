Return-Path: <SRS0=9a13=H5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA293C433E0
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Feb 2021 13:42:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA2564E7A
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Feb 2021 13:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA2564E7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 113B56E08C;
	Sat, 27 Feb 2021 13:42:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23FFB6E08C
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Feb 2021 13:42:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVLNyo+R3s20vCc/BKFmNqVslekqY5F8nVKb5iEAVtA409+jzBSfusYSpHZET4d/3aQjy9lq2fMpvsdJbMAwiYnMKgr7BW6yDxbxTt35y4sSlENhsKl8BxlA4mhTdiL4cIFjXdOKBma7IFOOLXgLtTo0mfe3g4dSxrsVpr4As4902XVI+dxlmrc7ZB5GdTr9qGqq0jpCfU1BJZwqOLlBcoooUTY13oxdyTSgt7JOW6FsM+7eXZM9sr6tIh+ssvtMrp6f9tnZe78Dj2A7EvptU7DLhUWuyHUPSvbBzABguiMSYImTjaiedXno2CcV7i/XRc08XhdeWr/Xyeq/Uq7HdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4aI2rwUCQSj0Pp0pT79+/CfsDfpfeF4BFrR+jI8e5I=;
 b=S+s4ETHcC3c+uMon5N6JWUiIPn0SqBniSaqfCUWQ865QwoqaTuaw7PSfw6BB5NxPC1ACufwDDYVU69zwx91YLM0+UlcED50v6yjH9um/qWhwjz006aOnW2p2FZomJ23QLkIDUcD34y/0v+noq76KgptiroL5h20zSq1epZi7RhWFnROZgml321uaz7guyr1MuyN5XiZzwACZfqnAwd+7ay42DytsbAYOW3U8IT4pZpOVEtqTxBRr+WgO836PCROpBxtlw4uBkAiC5egI71MIbGAMoRVvAgd/lPyWxhaYjO+J9/Fk1F+2kwUWbzPqSfi5ZufNEQCz+Q+jwqhwPyP/lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4aI2rwUCQSj0Pp0pT79+/CfsDfpfeF4BFrR+jI8e5I=;
 b=yWQi11vLZv5G1F2DDJ7zm2NaxnM72JNCoAS7Sjy7tjtGD+cdzIi7RwM7jW2f3/sZ5EJb9Yr0jeNEvHZP2goj4yrxXgHbmtHUXEq0687+gvN5YYfZZRBAOczoqjCSzs59DPPvd6xg6lyRdg+dhlUevhXNfrD6d5RPpkN67y6Wy+Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3696.namprd12.prod.outlook.com (2603:10b6:208:169::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Sat, 27 Feb
 2021 13:42:44 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3868.033; Sat, 27 Feb 2021
 13:42:44 +0000
Subject: Re: [bug] tab crash on media playback
To: Cory Bolar <cory.bolar@gmail.com>, Nirmoy <nirmodas@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <e281729c-d632-1cc2-a1c7-79b4d1cbdc66@gmail.com>
 <f4b795f8-9f79-a946-49dc-0aea27766bf6@amd.com>
 <b091a944-a002-9f6b-c347-1314a0f64385@gmail.com>
 <59967fb7-cf91-d6c9-f431-9b6a60a85c05@amd.com>
 <e6206b9a-8616-f4f0-1cf1-6f01c772f0ef@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6fc78b8f-a95c-e1ad-55cd-6a7ba7235088@amd.com>
Date: Sat, 27 Feb 2021 14:42:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <e6206b9a-8616-f4f0-1cf1-6f01c772f0ef@gmail.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:4790:c64a:64f3:822b]
X-ClientProxiedBy: AM3PR05CA0100.eurprd05.prod.outlook.com
 (2603:10a6:207:1::26) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:4790:c64a:64f3:822b]
 (2a02:908:1252:fb60:4790:c64a:64f3:822b) by
 AM3PR05CA0100.eurprd05.prod.outlook.com (2603:10a6:207:1::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.20 via Frontend Transport; Sat, 27 Feb 2021 13:42:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1b1ee609-c420-4db4-4a8a-08d8db258f9b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3696:
X-MS-Exchange-MinimumUrlDomainAge: github.com#4890
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3696AF8ECAFA3FCF932A9D44839C9@MN2PR12MB3696.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wj/s45VqcYlcxeB9KydN9iyrGJ5XbLNL2mjMgnReBrPTlCXMPXsN5N7ywylTVhxWDgaZq36LFw7G0/q37AzshidjwPAPwkFSbErmOGBwHSB+eTVLWGTLSK0kDR/rj+IJI1r5Sx9YiphR+DOa0QKiaIWsGBTvxnrYSoO7pFcnd1ocsGoAqVSv1aJlDVpy7M+EeJZcxftCggErOKzc+814+Vk64cMJyYTo2+RS0t8rZSDt3NIyKLpf83ZqVQWcYrFHYpkjTYdgvzW0V2CjZzIIi/QIweDWRHGKanTADtAsibAwJbOrSeSXp8ojm3wZi8TNB/WQV9TrF6tMdnOVvkbpbXn3HlzmYEN4rf9kSs1TF0DE3AA1I2tiJoOo29utg4wXd06Guq5NdrqG0/iKsmhg+dFD99f+iOnZfDhp8XmMJrDGfLDCP/vtCdzpBRTrcRy20LDLprZmkTGq5w6p3CfUzkPOvZGz2PA318/k/C0gnTwYGsUC1X21a7g435hVgoyyw5ImhU2Rq05F/lW73WuQ8HryYO+bOF2Gb6irCHrPWXUPJvzm4zVQbUDmUAdJRUm0MSBQqfd0LYv13yv8DHPkQ/XrLEpTfAvUeezUwOCUBA+d93OyM9PrsvtwB9syLnSqXjx4hABmlUBR6Jc/9xqxK+VxLeXNDK2mCrxz2N0kQh8L9iag5fZKltRDH8V8nTc2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(53546011)(86362001)(316002)(31696002)(110136005)(52116002)(31686004)(66556008)(66946007)(66476007)(2906002)(6486002)(966005)(5660300002)(8676002)(8936002)(186003)(2616005)(16526019)(478600001)(36756003)(45080400002)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cFczemV3TzAzMnhDZzFSTWN3dGNuNGljMGZHUTFtVVR0S2U5b0dpdGdISFlj?=
 =?utf-8?B?ZnFRUzZ3N3RSZUs3YTV5K0pGZlhWY1JMdUhVRUdZb0w2NXQwRVU1Vkg1aG5J?=
 =?utf-8?B?dFMvemRLMGZxRlFNdm9YckpMSW9XR1NKVjVhRWxoQVlVcWttUDgvZEZEWmkz?=
 =?utf-8?B?R3NiNWViNjZmREl1YTlRcEJQNmh2bHl5dWR0UzQ3UGlvd1FPbGp3NkY4bHdm?=
 =?utf-8?B?MTBHUnREa1Q2NmhxSFlLeHhzcml6cnhjTVM5U1hCNk54UHdza2dENEsyRWlh?=
 =?utf-8?B?N01IV2tYT0ZqYU5SL1hvTDVWV1lHZlJ3VEdCd2ZDRHFmUllKOUNEd0k2V1d0?=
 =?utf-8?B?YWZlNDR5YzUreHdFOVkvZWpmVXJGL0lBeG1pN05WMHlObXFXNzNwWUY3Ynk0?=
 =?utf-8?B?L3RPSlVpbVA3cDB1RmxndUlXaDJJTDdjbDlqZDNRMFZySy9ObFlIeGxwYmdW?=
 =?utf-8?B?anNGeXUrS1ZQTjdJNWlmMlFvbFh3UjdiRU03cWhaYWMza1BjNzJadkNldUVy?=
 =?utf-8?B?cEZnTE5VLzdzZzZ6VjVvT2tkc0xHSUR6NktucnNLVTlUYldPY3dLWHVYYlhW?=
 =?utf-8?B?a3N2QW5EQWZka3g5aUZDUTRrdm9jMytvR1V4QmNnQlJvV2xSMjZzMHFlc2NX?=
 =?utf-8?B?cjFDVzJFZzJmcDdtNHgyai9yS0FuRUpnenFhbkhDQlV1bkRFZWk2VnV6MlVv?=
 =?utf-8?B?MGZYaC9uR04xaGcxMFZoYXJ6Tys0b0ZDTnFWWkdvbGpKZ2I3bmxUN1I3WkRl?=
 =?utf-8?B?VnBEQVNxbXRVTVlrVTdBMDcwMmhjU1BZZHUzZ2lYbE9DdWFBVmtWT0FJRG9k?=
 =?utf-8?B?OVdvZzdHTHBibDZMZVAyOWNNK3FET0V6RGtOZ2NVenV3MEExRHM3Zi9ROVZl?=
 =?utf-8?B?UEoxUDRqK2p1ODdMek1TR3pGa2wzRXc1VTh6eEdMN3FDZys5TW9HNDQxOGtx?=
 =?utf-8?B?dGJyRnIzdnltOGhnWHNsV0VHMExMUGlMdnRlSlNUOTZBLzF4aGphR2ovZ1Ra?=
 =?utf-8?B?c0N0NENhanJHZEFiMEJQS2J0d1lka0sydjdoMjV6cDBvL2hWdlZXRHpiNDRj?=
 =?utf-8?B?YkE2WkZ4c0FRblA1WitwQUxTRndpUUJ2cENMWmJxZ2NHb2NweWk5NDc5b2Vk?=
 =?utf-8?B?SUplcUprY3FzMXI4alJWTUlZdjN2MnVHRlNOaU8ySkhNc2NPc1g2cTJpeVVp?=
 =?utf-8?B?MTQzVWIzZ0lZbHVGMm5ReWk0bUJtWGlFWlE1dElJRkt4U0VjRGxFQ25KaXhP?=
 =?utf-8?B?Kzl5UVhLck93eGg1enJma1RGQktucjZHTkFUb1BqbDZDckIzNHhGV2ZHcDJ6?=
 =?utf-8?B?b285MVdIazFXMTNkZVJ4cDNlamdwRFNMSHhxMUpKOFdMSU5BOU5hejRydTV6?=
 =?utf-8?B?SVBSTlBOMmFJZ0JlaVQvQmp4dml0aGZhY1ZYTkVjS1NzWjc5QzZVVDNTRVU5?=
 =?utf-8?B?UW5acVkrSmNXeTF0ODRhbS9pWVRwNHlHZW1zS05zNGNhbDFnb3BUT3lWWngw?=
 =?utf-8?B?ZSsxcDM2dktFWVZFbXVVZnZnMTlKanBIdkFtOWhESytpYlBJalBqbFVlVWZZ?=
 =?utf-8?B?eTNVTkcyWU02L1M1MTFWcURoQlVvbzF3VFZPOFhVNmY2VDBGWHh4U0FoS2RD?=
 =?utf-8?B?K1ZKMjA5WVRoUzB1M2NQVllqdGY4Um1UamZUbEptbTdDUVlSZm1mWWMwZWpa?=
 =?utf-8?B?dlA4MS9SVDYrSjNLeE9mSy8xNjNmMDNqamhseVkxRi93OXdLeFNSdXFweDFp?=
 =?utf-8?B?WkgrYU10alZmZFhNTW9MUDJwdjZnclkreXlndXFEUUExVWltZnRZT21ONlhw?=
 =?utf-8?B?OWR3YVNaem5rUWJ5cXZCSGt6QW1pcnRoTHEyRmd3RFNmNWczTCtJZ0RDdFdn?=
 =?utf-8?Q?37auK1jGEiLK1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1ee609-c420-4db4-4a8a-08d8db258f9b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2021 13:42:44.5845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwIk686nDUlC1mWNAx2sM5qyFsdsFw9W0OMzB2/9w/9oubpMY9lo1H26aCpDuGp/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3696
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

CgpBbSAyNi4wMi4yMSB1bSAxODozMSBzY2hyaWViIENvcnkgQm9sYXI6Cj4gT24gMi8yNi8yMSAx
MToxNSBBTSwgTmlybW95IHdyb3RlOgo+PiBQbGVhc2UgdHJ5IHRoaXNbMV0gZGVidWcgcGF0Y2gg
YW5kIGxldCB1cyBrbm93IGlmIHlvdSBzZWUgYW55dGhpbmcgCj4+IGludGVyZXN0aW5nIGluIGRt
ZXNnLgo+Pgo+Pgo+PiBbMV0gCj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpdGh1Yi5jb20lMkZuaXJtb3klMkZsaW51
eCUyRmNvbW1pdCUyRjcyYzdhN2UxNjI4NGIzMDkwNTc1MzI0MWIxZTkwMTEyMTg4ODIyYzkmYW1w
O2RhdGE9MDQlN0MwMSU3Q2NocmlzdGlhbi5rb2VuaWclNDBhbWQuY29tJTdDZjhkN2RjNTA4Zjgz
NDI2ZWI1OTgwOGQ4ZGE3YzUzNmMlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3
QzAlN0MwJTdDNjM3NDk5NTc0ODAyMTE0MzE5JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJ
am9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1u
MCUzRCU3QzEwMDAmYW1wO3NkYXRhPUtOSDZvMVh6eW4yNkozJTJGY3JFQ0s4aGpGSXVOYVdXb3R5
VWNkOXNKRSUyQkhRJTNEJmFtcDtyZXNlcnZlZD0wCj4+Cj4+Cj4+IFJlZ2FyZHMsCj4+Cj4+IE5p
cm1veQo+Cj4KPiBEbWVzZyBvdXRwdXQgd2hlbiB0cmlnZ2VyaW5nIHRoZSBjcmFzaDoKPgo+Cj4g
W8KgwqAgNzUuODUxNzkyXSBhbWRncHVfdHRtX2ZhdWx0OiB0dG1fYm9fdm1fZmF1bHRfcmVzZXJ2
ZWQgZmFpbGVkIHdpdGggCj4gMTAyNAo+IFvCoMKgIDc2LjUxNjY4M10gYXVkaXQ6IHR5cGU9MTcw
MSBhdWRpdCgxNjE0MzYwMTYzLjM0Mjo4NCk6IGF1aWQ9MTAwMCAKPiB1aWQ9MTAwMCBnaWQ9MTAw
MCBzZXM9MSBwaWQ9MjE4NSBjb21tPSJDb21wb3NpdG9yVGlsZVciIAo+IGV4ZT0iL3Vzci9saWIv
Y2hyb21pdW0vY2hyb21pdW0iIHNpZz03IHJlcz0xCj4gW8KgwqAgNzYuNTI3MDQwXSBhdWRpdDog
dHlwZT0xMzM0IGF1ZGl0KDE2MTQzNjAxNjMuMzUyOjg1KTogcHJvZy1pZD0xNCAKPiBvcD1MT0FE
Cj4gW8KgwqAgNzYuNTI3MTM2XSBhdWRpdDogdHlwZT0xMzM0IGF1ZGl0KDE2MTQzNjAxNjMuMzUy
Ojg2KTogcHJvZy1pZD0xNSAKPiBvcD1MT0FECj4gW8KgwqAgNzYuNTI4MDA0XSBhdWRpdDogdHlw
ZT0xMTMwIGF1ZGl0KDE2MTQzNjAxNjMuMzU2Ojg3KTogcGlkPTEgdWlkPTAgCj4gYXVpZD00Mjk0
OTY3Mjk1IHNlcz00Mjk0OTY3Mjk1IG1zZz0ndW5pdD1zeXN0ZW1kLWNvcmVkdW1wQDAtMjc4Ny0w
IAo+IGNvbW09InN5c3RlbWQiIGV4ZT0iL3Vzci9saWIvc3lzdGVtZC9zeXN0ZW1kIiBob3N0bmFt
ZT0/IGFkZHI9PyAKPiB0ZXJtaW5hbD0/IHJlcz1zdWNjZXNzJwo+IFvCoMKgIDc4LjA1NDY5OF0g
YXVkaXQ6IHR5cGU9MTEzMSBhdWRpdCgxNjE0MzYwMTY0Ljg4Mjo4OCk6IHBpZD0xIHVpZD0wIAo+
IGF1aWQ9NDI5NDk2NzI5NSBzZXM9NDI5NDk2NzI5NSBtc2c9J3VuaXQ9c3lzdGVtZC1jb3JlZHVt
cEAwLTI3ODctMCAKPiBjb21tPSJzeXN0ZW1kIiBleGU9Ii91c3IvbGliL3N5c3RlbWQvc3lzdGVt
ZCIgaG9zdG5hbWU9PyBhZGRyPT8gCj4gdGVybWluYWw9PyByZXM9c3VjY2VzcycKPiBbwqDCoCA3
OC4wODkxMTBdIGFtZGdwdV90dG1fZmF1bHQ6IHR0bV9ib192bV9yZXNlcnZlIGZhaWxlZCB3aXRo
IDEwMjQKPiBbwqDCoCA3OC4yNjA5MDldIGF1ZGl0OiB0eXBlPTEzMzQgYXVkaXQoMTYxNDM2MDE2
NS4wODk6ODkpOiBwcm9nLWlkPTE1IAo+IG9wPVVOTE9BRAo+IFvCoMKgIDc4LjI2MDkxM10gYXVk
aXQ6IHR5cGU9MTMzNCBhdWRpdCgxNjE0MzYwMTY1LjA4OTo5MCk6IHByb2ctaWQ9MTQgCj4gb3A9
VU5MT0FECgpUaGlzIGp1c3QgbWVhbnMgdGhhdCB0aGUgZmF1bHQgbmVlZHMgdG8gYmUgcmV0cmll
ZCBhbmQgaXNuJ3QgYW55dGhpbmcgCnNwZWNpYWwuCgpJIGhhdmUgbm8gaWRlYSB3aHkgdGhpcyBz
aG91bGQgY2F1c2UgYW55IHByb2JsZW1zLgoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPgo+Cj4gVGhh
bmtzLAo+Cj4gQ29yeQo+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
