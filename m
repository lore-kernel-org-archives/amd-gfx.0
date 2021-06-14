Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3161AC2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 14:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD9FB611C0
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 14:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9FB611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A453489D52;
	Mon, 14 Jun 2021 14:36:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4420F89D52
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 14:36:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DigRUW2f+4OvcwI4E/I7zB42mjL3DQDdHz0SnbPMXjDiu1J3XX9bxYSo4eVZf71x8ZjHO8d9oxg10oEzBkfpE0EkxOCJ7pQpUGo+dXml6dHxENFhRfEKsXGtgzH3ogadBZOJhGfuK3mhXGGUazdUcyWKOSjjfX935886Cf5bXq6nxdsi+BN6k0tbK+PR3PCPIClO+o5myuvE0LXQCJcrWiUoc3jgfq1YuBh/9571gVBFWfdgWVxQ7HgTsA3TjXwyfXj4RJxTm1EWKhhPvihNE8WEy+i6OtEg9k1NiHO9QdFnHHz44VodKK988fzvDz+wkQubZa1ZbPXWNoWEH3te2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGBNMUWNgix5nd8gNawvjCwKMSaSN90whmH99xkSq8w=;
 b=XJV2qtACv091M/KZVdaWiHgcp/OxyswMom9zdlouzq/5o8D3JWnRodZyv7/Q6EURMlyKw5vGpxEIND3BWnfztpYDfbIJcUbEliLOe65InPomf4+m8gVtYsh1qnAMCHGBvM4eJDqoF+CrIliN68bjRppsKLco4nzeDMJC6h72Nj4BFaxm+Qx1F5hV4sDH9gumt15tjRi0W7Bxoyhim++2Zro3pFmaFWnq7xB9WLnXEpQmWjHgVjVrJWzUS9luYMSjffDF5OVY7a4Z+4DdqrZAcwbVvjf9vO25TE+IhwzDZV/OCxATBuQvop/RLd4C/0eHn+IQHqjWgjahj/sa3JfIAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGBNMUWNgix5nd8gNawvjCwKMSaSN90whmH99xkSq8w=;
 b=QumP+ThGCmv1ePMORS5dVym8uAIdFdBTQPsdTmGMUK9Am9/OZcO2dmlAICtRC4giE4zMEkE/Qd63Tdkxk7M0bua7VeI2BS5IcYbObHfLswVMceYUPYzUftBnf0DJeqMESS9jG641/riNo0GnqWHtHSZQwEDYId8Q9oWyw+itMwM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Mon, 14 Jun
 2021 14:36:21 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%5]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 14:36:21 +0000
Subject: Re: [PATCH 1/3] drm/amdgpu: parameterize ttm BO destroy callback
To: amd-gfx@lists.freedesktop.org
References: <20210614143217.10285-1-nirmoy.das@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <6329df30-9b0a-8a6b-0669-a694a2df11f4@amd.com>
Date: Mon, 14 Jun 2021 16:36:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210614143217.10285-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.72.6]
X-ClientProxiedBy: AM9P192CA0022.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::27) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.54.68] (165.204.72.6) by
 AM9P192CA0022.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.20 via Frontend Transport; Mon, 14 Jun 2021 14:36:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1764ccc2-5d63-4478-7e28-08d92f41c767
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5070984F8B6E7744530C598F8B319@DM4PR12MB5070.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xailpcbY3UxPZcdijlUgIII6WYTc1oVPSPq0IhResvxP53CxmM5gUnoMlZl7LxX/DIVFA1BnKghBk8RQLdRqEiwjYMlf0V1TQEL8K1k/oR2ivuZbnJ21h/JNzlrSdJTFw4NefwBAEQ8j6ZrbYxdn8kkJRq5iwO+xc0CSMwKZ/mgO0F7nTVrn8gVkPTVjHBx8Ew5USM/6g2Uw830AkSW1Y4BisvS7Zhcpz4sYFS2mMls+ROi2YHdSuyNEkqVXSD0xZaL88GXC2ciAWw7vH66WmuSSKrQlM1Tp6YevcURErNFp2yNBNGZYIuL3qCjOyj2cVI9ux4/cpPq3zJxBmcKdBSecf/R2cNbPgtSm/VC5iAAIu5HDUeWhkuHzvo+yQ7Z5Z3M4jUDsno2u8dh24ZDk0Ux8OsFKVR7ZZCLf96jFdQJUIj0IdZTgiTprS4IjUdUsBrD5aNaVMwAh2xFqQWUahxCZjQ5tDu4GMKA/jyryk+K1mlo/xESiZcFcnibvgqd0kzjyYgerq+t195Jr/L14FZ58sOYbCxD/c4D1dF7yD4i6OUhKz3+71rTLX7kiDveZK0EP7zItRX3DovAkrrEOC7B+03co0oTM/ccjbNuYOvlnX3ATaoUr395SV/N7ycykWrthJOlb2CUhSPYqk3O3LP86BtbAOyivy4hdxC+rJ5ZTBRFMWa2uHYmj+fNGJSON89rYcdKl5KWRcQZp6e2js1hu/AokjS/JlMxzAB7Af9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(83380400001)(31696002)(956004)(53546011)(4326008)(2616005)(316002)(478600001)(186003)(6486002)(6666004)(16576012)(38350700002)(36756003)(66556008)(66946007)(86362001)(5660300002)(52116002)(6916009)(66476007)(2906002)(38100700002)(8676002)(26005)(16526019)(8936002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHBLa3E5ZWxxOXNjN3JtVUZXNThLMThsc0FQNTNsT1ZsKzFnR3BnQ0ZoRGNw?=
 =?utf-8?B?Mjg1TzQzRnl0Z0pRbCtPUW9mb1hVaUdQdE1wTE8yaGYwamZPUlpIQURxTGZI?=
 =?utf-8?B?TGM2RDF1Rm5ZVXk4TDhkcS9BT04zTVlpNWRkRXhPamZxS0lpRHhBM3kydzlI?=
 =?utf-8?B?MXJ6TmZBcTFqaGVnTTc3ei9kL2dOeTVnbm9Gb1ZuYzlCUjhQZTNEa0EwQ2lm?=
 =?utf-8?B?YU5SZ1pvc3JwK1AvWTYxaHhKczRXL1hkSXVmNEkxcHJPVU5SN1I1M1lsc3Ur?=
 =?utf-8?B?YUZDcWNvRlpuSWFSQUV4NXJueisraGVNMkR4M3RHZ21ldUF1OGR5N2tMSWVo?=
 =?utf-8?B?Vk04V2ZmWlFiMGVFTHYxZm41OFRiZFg1b2IyU0RIdERxbm9zWitoYTM3V3Z3?=
 =?utf-8?B?K3JvWmhRYUN1L2hVZUFQR1ZzdmoyZjAwbjk3aDRlMVA5RllEUmxyaVp4MnRT?=
 =?utf-8?B?ZVJoKzcwbzhEREY0TnlBU2NZcmxzNTNla0w0SmNTbWFObTU0QUtsb0d5OVY4?=
 =?utf-8?B?cC9RSG92MWRIZEs5MGZiVUZaaFllbTFyWDZsT2RiNlFoZXIram96QWRsL1JT?=
 =?utf-8?B?NThOdUhrTVArVHZlWkkrelpCam1uSVFpdVpYVDFicmpvQWZQbU15ZDBHQmc2?=
 =?utf-8?B?cDk1cFc3R3ZCck5FRDRJOGhicFlLWklSUlM3MmpCRVdBSFNDY2JxQVIrcGFt?=
 =?utf-8?B?YTBhdnQ2VXVBYnFTUXhqamFHeXNVdjhuNXFUYU1jbXVDZWVaeVprb1NXV1hC?=
 =?utf-8?B?QlNmbTR6VVhldGFaU09XVDc4K3lBY0FrOFpZZGx5QXlmSGNaZkNiR2Yyckds?=
 =?utf-8?B?aHRvYXNzODBGMGQ5TFlRa0lNMDFQTHcrRVdZenU5QVRkNm1PUjFRZ09CVEor?=
 =?utf-8?B?Y1JYTkxEaTNwL0JSU0VzOWptZ21seGRMdTIvVEw5VzlJKy9uODViTVNOWU5M?=
 =?utf-8?B?eStERm5SaVo2dVJqVmZCelpPdFhIVEVYRVR5ZWY5YzF5Z2k3Z05idlFBSlhm?=
 =?utf-8?B?UU8wKy95c2piMmhKbnc3YWNVYktsa09aTEZhNFVKbWRLanN1YTQwQk9HdGlx?=
 =?utf-8?B?VE9QdnVtQkhVRUJXMFJWS0JOZW5LRkRkVGRlWFU1V0YyT3oyTzVLam9zdjZE?=
 =?utf-8?B?aGRheU9BQStJMHhnU0F3S3FGeUFScVQxcnhVY1h1QUQ2aFR5UU1NalBmSysw?=
 =?utf-8?B?Q0hqcTgrQ3JIRnJHUnhhcTc2VU1KVXl2aFl1STBEdEc2MUxuVVNPaUh4REpq?=
 =?utf-8?B?aGcvZGp4UGJ6cEp2bjBQQUFWRFlMdDBMR2Vzck9PZHFITE1TcmZ6ZEI1SXEw?=
 =?utf-8?B?MlpLZHRKa2U2RXBaZ3JqMzNQRll3NFkyS1ZhcVppeExOWXRpd3lOcHlhL2lo?=
 =?utf-8?B?a0pxK0ExajNodHFEN3dBWnl0V2Y2RmJFSUtkRFJvck5sUkxYbkI0UGQ0cDQy?=
 =?utf-8?B?TDZiWHBLaG9LY1FNT292ajdmYTVmaVE5Vk0rTFlHc29lWHFHQnpwWFFDSkZM?=
 =?utf-8?B?VXQzd3U3KzY3STlNNmFXOEJObG84WnYvSGExRmZTeXFNRnBBdHdud0FvaHFU?=
 =?utf-8?B?QjE1czJlOXJKSTVGeEpUYUsxWmN6anhNYUViVmtaTHB0ZzNvZUpaTmdSSEs2?=
 =?utf-8?B?S05ieWtzakJ5SXR3S1hOVENzNlRrTDFHam1DV092Ym9Rd2hueHV0MmdWOFpM?=
 =?utf-8?B?TVdic0FINHNjd1ZTc25reG1HNnRpQVh2bmtxZUlpblo5TUd5TE4zZ0RESmpV?=
 =?utf-8?Q?tAi9sca2gdxvQKJhOJLPmpqDNnbMwhf+vsck0ZI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1764ccc2-5d63-4478-7e28-08d92f41c767
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 14:36:21.5300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gLp/T2XnIzP5qiv9e7m5F9KCYyPmWYzzv4tndowbg8fFSAQ+Z8BIrqs7HHLUusmuMmBcZnuAVgeRqfjhEFAWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5070
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
Cc: Christian.Koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDYvMTQvMjAyMSA0OjMyIFBNLCBOaXJtb3kgRGFzIHdyb3RlOgo+IE1ha2UgcHJvdmlzaW9u
IHRvIHBhc3MgZGlmZmVyZW50IHR0bSBCTyBkZXN0cm95IGNhbGxiYWNrCj4gd2hpbGUgY3JlYXRp
bmcgYSBhbWRncHVfYm8uCj4KPiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFz
QGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2Jq
ZWN0LmMgfCAyOCArKysrKysrKysrKysrKysrKystLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMjQg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfb2JqZWN0LmMKPiBpbmRleCA5MDkyYWMxMmEyNzAuLjcxYTY1NTI1ZWFjNCAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKPiBAQCAt
NTIyLDE1ICs1MjIsMTcgQEAgYm9vbCBhbWRncHVfYm9fc3VwcG9ydF91c3djKHU2NCBib19mbGFn
cykKCgpjb3B5LXBhc3RlIHR5cG8gOiBOZWVkIHRvIHJlcGxhY2UgZnVuY3Rpb24gaGVhZGVyIGFt
ZGdwdV9ib19jcmVhdGUgLT7CoCAKYW1kZ3B1X2JvX2RvX2NyZWF0ZS4KCgo+ICAgICogQGFkZXY6
IGFtZGdwdSBkZXZpY2Ugb2JqZWN0Cj4gICAgKiBAYnA6IHBhcmFtZXRlcnMgdG8gYmUgdXNlZCBm
b3IgdGhlIGJ1ZmZlciBvYmplY3QKPiAgICAqIEBib19wdHI6IHBvaW50ZXIgdG8gdGhlIGJ1ZmZl
ciBvYmplY3QgcG9pbnRlcgo+ICsgKiBAZGVzdHJveTogdHRtIGJvIGRlc3Ryb3kgY2FsbGJhY2sK
PiAgICAqCj4gLSAqIENyZWF0ZXMgYW4gJmFtZGdwdV9ibyBidWZmZXIgb2JqZWN0Lgo+ICsgKiBD
cmVhdGVzIGFuICZhbWRncHVfYm8gYnVmZmVyIG9iamVjdCB3aXRoIGEgc3BlY2lmaWVkIHR0bSBi
byBkZXN0cm95IGNhbGxiYWNrLgo+ICAgICoKPiAgICAqIFJldHVybnM6Cj4gICAgKiAwIGZvciBz
dWNjZXNzIG9yIGEgbmVnYXRpdmUgZXJyb3IgY29kZSBvbiBmYWlsdXJlLgo+ICAgICovCj4gLWlu
dCBhbWRncHVfYm9fY3JlYXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICtzdGF0aWMg
aW50IGFtZGdwdV9ib19kb19jcmVhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJ
CQkgICAgICAgc3RydWN0IGFtZGdwdV9ib19wYXJhbSAqYnAsCj4gLQkJCSAgICAgICBzdHJ1Y3Qg
YW1kZ3B1X2JvICoqYm9fcHRyKQo+ICsJCQkgICAgICAgc3RydWN0IGFtZGdwdV9ibyAqKmJvX3B0
ciwKPiArCQkJICAgICAgIHZvaWQgKCpkZXN0cm95KShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3Qg
KikpCj4gICB7Cj4gICAJc3RydWN0IHR0bV9vcGVyYXRpb25fY3R4IGN0eCA9IHsKPiAgIAkJLmlu
dGVycnVwdGlibGUgPSAoYnAtPnR5cGUgIT0gdHRtX2JvX3R5cGVfa2VybmVsKSwKPiBAQCAtNTk0
LDcgKzU5Niw3IEBAIGludCBhbWRncHVfYm9fY3JlYXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LAo+ICAgCj4gICAJciA9IHR0bV9ib19pbml0X3Jlc2VydmVkKCZhZGV2LT5tbWFuLmJkZXYs
ICZiby0+dGJvLCBzaXplLCBicC0+dHlwZSwKPiAgIAkJCQkgJmJvLT5wbGFjZW1lbnQsIHBhZ2Vf
YWxpZ24sICZjdHgsICBOVUxMLAo+IC0JCQkJIGJwLT5yZXN2LCAmYW1kZ3B1X2JvX2Rlc3Ryb3kp
Owo+ICsJCQkJIGJwLT5yZXN2LCBkZXN0cm95KTsKPiAgIAlpZiAodW5saWtlbHkociAhPSAwKSkK
PiAgIAkJcmV0dXJuIHI7Cj4gICAKPiBAQCAtNjM4LDYgKzY0MCwyNCBAQCBpbnQgYW1kZ3B1X2Jv
X2NyZWF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAlyZXR1cm4gcjsKPiAgIH0K
PiAgIAo+ICsvKioKPiArICogYW1kZ3B1X2JvX2NyZWF0ZSAtIGNyZWF0ZSBhbiAmYW1kZ3B1X2Jv
IGJ1ZmZlciBvYmplY3QKPiArICogQGFkZXY6IGFtZGdwdSBkZXZpY2Ugb2JqZWN0Cj4gKyAqIEBi
cDogcGFyYW1ldGVycyB0byBiZSB1c2VkIGZvciB0aGUgYnVmZmVyIG9iamVjdAo+ICsgKiBAYm9f
cHRyOiBwb2ludGVyIHRvIHRoZSBidWZmZXIgb2JqZWN0IHBvaW50ZXIKPiArICoKPiArICogQ3Jl
YXRlcyBhbiAmYW1kZ3B1X2JvIGJ1ZmZlciBvYmplY3QuCj4gKyAqCj4gKyAqIFJldHVybnM6Cj4g
KyAqIDAgZm9yIHN1Y2Nlc3Mgb3IgYSBuZWdhdGl2ZSBlcnJvciBjb2RlIG9uIGZhaWx1cmUuCj4g
KyAqLwo+ICtpbnQgYW1kZ3B1X2JvX2NyZWF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwK
PiArCQkJICAgICAgIHN0cnVjdCBhbWRncHVfYm9fcGFyYW0gKmJwLAo+ICsJCQkgICAgICAgc3Ry
dWN0IGFtZGdwdV9ibyAqKmJvX3B0cikKPiArewo+ICsJcmV0dXJuIGFtZGdwdV9ib19kb19jcmVh
dGUoYWRldiwgYnAsIGJvX3B0ciwgJmFtZGdwdV9ib19kZXN0cm95KTsKPiArfQo+ICsKPiAgIC8q
Kgo+ICAgICogYW1kZ3B1X2JvX2NyZWF0ZV91c2VyIC0gY3JlYXRlIGFuICZhbWRncHVfYm9fdXNl
ciBidWZmZXIgb2JqZWN0Cj4gICAgKiBAYWRldjogYW1kZ3B1IGRldmljZSBvYmplY3QKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
