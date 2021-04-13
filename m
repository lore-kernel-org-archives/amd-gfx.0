Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105F2C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 07:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C286B60238
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 07:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C286B60238
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B35D89CAA;
	Tue, 13 Apr 2021 07:48:35 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770059.outbound.protection.outlook.com [40.107.77.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3AA589C33
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 07:48:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBXuPHVGmoIYqo3sgtU0SbtAR5dpSmml26pJv9mVL0cywB1Fx590hkF99PdtydpoNs6yjYGrTSfWHuC4JsLdkiBruueei6AIcAKvxiSxvFhz0l0wGTc7dxiVxLDfnxipnNGaMndQERxSj95gy8WtepnGvC6o9a227kF/himHsP4CQku7LoiB3ndfN06W/dpUIDZneWFqMnuL6GrDXJEQSmXQ0alpOnKrhhiPGOgqWr4YlbmWpnDA1g62nSglCnzmW/JOuKCX47ikB/QWkkqtRBvk5EC3Y7jD+ye26EaGyaB9pnTMU/FcTp4l7U4G4r7zlBObyd2WesFsmboAlm+FQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7SrzJhrqFP8hm8R2OAH7rndzuK5yCKPkbmw/ZMuKx8=;
 b=COfwIdFLxCllFf+yI+tLWn+VpT4RvHVvnZzYxvuJfYI0bcJPW3G/XkLs1PX2juk5AQvJRFImemAeBexL1sQ9wPjIkCtxG1j7NqCHrjgdpR5egCgjeKEOcVxMtcx4/VA4gYNrW3bwEJuGvPGFuAN50c84xk/z56mtB25ZKRjzgfoDfi0xQQkcY6j4HHB5LafWuNeAJ52Cy3XKt6M5Pe7gaDayr9YwySO5LKRo7jVekoWCIi8HVSBa+P1bXP5ezZ9qY2FVDlAxnmYWAX/CXC5xwl6IUmMFOsQRYdAJekmOIbCvzIogSFop/wTSh3QS5Ihgv7Wq7+Jkpyy8Pg2CCQW5SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7SrzJhrqFP8hm8R2OAH7rndzuK5yCKPkbmw/ZMuKx8=;
 b=NxDf3uox/OB44aqAHr+irUxpWACxZTonuri0NdcWB4jVNTItDSwtIAFFGedxsyDM/YFX6io6l8y1/27i7zZSGjj+9dAPRQq5pxTcfTPzyB+nsRkFdgJP1jWA5stK3W/dNbBQCPZkO9Nq9D1B0qIO6U+gKr+HgtXHDHWSHV2Wp/o=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4754.namprd12.prod.outlook.com (2603:10b6:208:8e::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Tue, 13 Apr
 2021 07:48:32 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 07:48:32 +0000
Subject: Re: [PATCH] drm/amdgpu: Add graphics cache rinse packet for sdma
To: Huang Rui <ray.huang@amd.com>, "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
References: <20210413062300.12558-1-Jinzhou.Su@amd.com>
 <20210413064157.GA80097@hr-amd>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <eeb4cb58-e7aa-60b4-8f67-a3061ec2de1b@amd.com>
Date: Tue, 13 Apr 2021 09:48:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210413064157.GA80097@hr-amd>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:acbc:5f44:93b6:4587]
X-ClientProxiedBy: FR3P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::21) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:acbc:5f44:93b6:4587]
 (2a02:908:1252:fb60:acbc:5f44:93b6:4587) by
 FR3P281CA0037.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.6 via Frontend Transport; Tue, 13 Apr 2021 07:48:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc9d7281-cca6-498a-dc7a-08d8fe5088ad
X-MS-TrafficTypeDiagnostic: BL0PR12MB4754:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB475433D06B695D126FE9D5FB834F9@BL0PR12MB4754.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnIR/xtfCKJqd2j5ATZRHOO1nd6Udj0nEuo2M120rzRUGgCUBiWqtftfkA5rjk7rX+K8yn8qROJON9YM6QD6o3rpHqrBZ7f5b7zIiSkFnv0vFDxQ3ad8pC63llInJQF6c3YVAbspib0KNX16NdmEQMtsqkJR5fERDyyXNsObzv7B1cMtXYAJKGAZSodcvzBrOVXspNNKam3fLtImp9GUrqb5nWXGtxL50PI/w3KKCsf/fwfqe1UDF7ks/OtmqFcp8nSvgGD0PT9a2ZMSMX/od9UwWPkZY5YLLpm6bY+MEk1fQ5z2wm6lq64qIFvl3Dm2fPksACSt28Z0yyH6awlg4TvnDm1r0ptNpX2fTniNa2HbwyE/H4tOfIuZl61Ne2JyHZOuQPRn/uE0D5BQjBekTG2L8aQfaxraJXIvdPQrI2KaRJw9q5mMYGYXkE8hNL2x/iWQEq31DR38YxvJb8iEFh4zYq1tHCQjJbSMFrFjay0N4ZbOaOPDeEJ3/YyPGcBLDNhF8gWC6DIFTKR28ue+9TS3Obzu64taOno/BwffairkFYx02HpsQU8BFWMFH0lHgxd5oq9GiRZV9lUzy1oVE1G/F9O/tZZispOLQgd/AWa3WXG4EicEU08XRvFvHii3yqKxH8t3kjTgooFRa2ausr+TfLFgozNT0EZ7ZSpphR33JQHW1/6YOTBO5nMgFISr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(86362001)(31696002)(36756003)(110136005)(6636002)(478600001)(38100700002)(54906003)(316002)(66574015)(16526019)(52116002)(2906002)(2616005)(4326008)(5660300002)(8936002)(66946007)(8676002)(66556008)(6486002)(6666004)(31686004)(186003)(83380400001)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eEx1TElxWDcwdStibFFMWDBMYzBNQzF5dEF3cDgrTmdvbGZvT3Z6ZU8rUzFB?=
 =?utf-8?B?TEVUc1lPQnVUT2tYTkVqY05zOVpSM29kK1hSeTlubHFXUTcwRGJ2ZnlKekwr?=
 =?utf-8?B?Q0NBeFdpTzdOVVVwUGtrZTlJY3hlSGJEZnVTUWhzOUNtV2V2VlovYTJBUzdj?=
 =?utf-8?B?bXZRQUVMLy9jcFU4V0tJaFkvSERoVVB1bzFmZit1ck9SYytVaUhucExzM01F?=
 =?utf-8?B?aTFVWVdmV29qL3FNRXJSazdsRUlaaE9HcG1PeUJsaHpUa3BLSFJ5blJ0d1Vm?=
 =?utf-8?B?Z1hMczBhOWw2TzEvWVFaeFhTcm9TQ3BCcEZYREFzR0NjM3B3SHdYTzNlUXJs?=
 =?utf-8?B?VkVaVXIrazB4MGRhYTB5OU41QjBqNSt5U0U2MnRmajBIbndFR0o1QjBkY2ZH?=
 =?utf-8?B?TFFKc1J4UG5IS0wxYVZpYTlGdlRSa25NMi8yU3JGd2w2U1BlblBzWTlQM2JU?=
 =?utf-8?B?TTVkMVFSSXpJRDFvVDZYL2tqSmMrUDdXUmhiTHdqT3NEelduaHo5M3g1VjVU?=
 =?utf-8?B?NnBSamxxR1dnRFkwZVM3WFYwTHYzYmp5Z04wZWw3MnVVbGkwMkNuUU1Ha2s5?=
 =?utf-8?B?Y3RDMHdOTnNIa0hlU1M2L1pZdFd1SmtiZUtScnh0WGtjMnA2S1RvSjVIbTJy?=
 =?utf-8?B?aFVlUENCKzlKUFNTTXc4OUVoY1ZKNUx4UmVwdGtkMUhSU2xKNzJHRWxLMjEv?=
 =?utf-8?B?WmdQMElvVU9lYWpKM0paclNJdFk2VjVRTjYzSEF5eU5WU0xNWS9xQmpHSDYr?=
 =?utf-8?B?NVF4dmpGemp5bjhBc2NEQk01bzNNZFlwSFR2UU83ZGtMNmdhT3VHZ3RWUkhY?=
 =?utf-8?B?Y1oxekR0VklUd3dsMnFpdXRndzFJa0I5SnI0UW5IUU1kOTgzR1VETEVpWmlp?=
 =?utf-8?B?eEZsT0FBUFBmcmJSTzFJWkhIdnhRa2tsdnJ6SzZLRWFOS3VNV3VLd2FoLzVa?=
 =?utf-8?B?MXU4L3k2ck9rN25VSFJJcU85VGdHVnVxcThKYVJyUkp4RTE1T0RkVCs0QjJS?=
 =?utf-8?B?LzVEdkFUNlIreHkvRHpnZ3JmMFpDazZ4UnpOakYwYzlvMVRHSElLRUY3WDFG?=
 =?utf-8?B?YlZxNm5MZkZKa1EyTFZDWHFSWVBvRi8yU0xSNmlHREppUEl2VnBXYXUxdE9P?=
 =?utf-8?B?emd4aklHc2VhdHZQMGlEMjZ6TTExbzcxbkdnQnE3SFlFdU5vOG5LY1FpYjda?=
 =?utf-8?B?TXVCa2p1QkNmdUttbmowUWlCZko0RjMxc1hjREVYREtQS3k5VGw5WG9sSDkv?=
 =?utf-8?B?cXBRaEpBSDk4TnBDZCtpT1hMVnl2VVV0ZXJJV1k4aHBFSGZaQy9KajZDcUZ5?=
 =?utf-8?B?OUNUcUNnbmpQcDVjaXBRT20zTWRaL0dxYU1KdDIrSG5EemNoM0lFSnRWS1dN?=
 =?utf-8?B?Sk96ZjhLWjlHL09MRlZtL2N5eXVSU2JWMFlhOUl5ZXRVZkNneHJQalVkQVpX?=
 =?utf-8?B?MGNSdXo5RFZKL0JtVnBjMDV2bmFEZ2cyM1BYUElEeW1Nbm1HTnlpQ2VDbGow?=
 =?utf-8?B?WWNsZjZUU3dEM1krc0xNcUt6Z0dycVIxTHBsbExZSVg3VTdCa1ZndlNqQVlW?=
 =?utf-8?B?RmNEUHkwajZ2NktRelpkMWhtQk9DWkVEamZBYkc3ejNoNjc4Ymg4ZGYzVEJG?=
 =?utf-8?B?Qkp2Smc2TFVUaHRvcjI5dGEvekM0VGduYUNBeFhxd1pvTEMwTWdmMk5yU0pS?=
 =?utf-8?B?bXBWQXI1Vi85eVliWnMraHJuSGFDa1NLdWs1VmhVS1NobUZtLzJjeUlhUml3?=
 =?utf-8?B?aE1Zb2xrTjJPck1HdzNvcGwvUE1BNHByVFNubGNJWlMrWmJFV0dpYlVJNDZZ?=
 =?utf-8?B?dGVDcExiczB6SE4yZXJqeUUzRkF6cXJWOVJhWTFhaGYwQmlxbnVaeERJV2hz?=
 =?utf-8?Q?bwS1muCxHU2HN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9d7281-cca6-498a-dc7a-08d8fe5088ad
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 07:48:31.9797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38t+ILDk1Q3lxaV9zt1FNT73solIwfg2FjTra3TqSseDcmziUNfchnfdHsR4wYe+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4754
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WWVhaCBhZ3JlZSwgYSBiaXQgbW9yZSBjb21taXQgdGV4dCB3b3VsZCBiZSBuaWNlIHRvIGhhdmUu
CgpBcGFydCBmcm9tIHRoYXQgZmVlbCBmcmVlIHRvIGFkZCBhbiBBY2tlZC1ieTogQ2hyaXN0aWFu
IEvDtm5pZyAKPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gYXMgd2VsbC4KCkNocmlzdGlhbi4K
CkFtIDEzLjA0LjIxIHVtIDA4OjQxIHNjaHJpZWIgSHVhbmcgUnVpOgo+IE9uIFR1ZSwgQXByIDEz
LCAyMDIxIGF0IDAyOjIzOjAwUE0gKzA4MDAsIFN1LCBKaW56aG91IChKb2UpIHdyb3RlOgo+PiAg
ICBBZGQgZW1pdCBtZW0gc3luYyBjYWxsYmFjayBmb3Igc2RtYV92NV8yCj4gSSBzdWdnZXN0IHRv
IGRlc2NyaWJlIHRoZSBwcm9ibGVtIHlvdSBlbmNvdW50ZXJlZCBmb3IgdGhpcyBjaGFuZ2UsIG1v
c3Qgb2YKPiBwZXJzb25zIHdvdWxkIGxpa2UgdG8ga25vdyBob3cuCj4KPiBXaXRoIHRoYXQgZml4
ZWQsIHBhdGNoIGlzIFJldmlld2VkLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPgo+
Cj4+IFNpZ25lZC1vZmYtYnk6IEppbnpob3UgU3UgPEppbnpob3UuU3VAYW1kLmNvbT4KPj4gLS0t
Cj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8yLmMgfCAyOCArKysrKysr
KysrKysrKysrKysrKysrKysrKwo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCsp
Cj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzIu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMi5jCj4+IGluZGV4IDkzZjgy
NmE3ZDNmMC4uYjFhZDllNTJiMjM0IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9zZG1hX3Y1XzIuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9z
ZG1hX3Y1XzIuYwo+PiBAQCAtMzY5LDYgKzM2OSwzMyBAQCBzdGF0aWMgdm9pZCBzZG1hX3Y1XzJf
cmluZ19lbWl0X2liKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKPj4gICAJYW1kZ3B1X3Jpbmdf
d3JpdGUocmluZywgdXBwZXJfMzJfYml0cyhjc2FfbWNfYWRkcikpOwo+PiAgIH0KPj4gICAKPj4g
Ky8qKgo+PiArICogc2RtYV92NV8yX3JpbmdfZW1pdF9tZW1fc3luYyAtIGZsdXNoIHRoZSBJQiBi
eSBncmFwaGljcyBjYWNoZSByaW5zZQo+PiArICoKPj4gKyAqIEByaW5nOiBhbWRncHUgcmluZyBw
b2ludGVyCj4+ICsgKiBAam9iOiBqb2IgdG8gcmV0cmlldmUgdm1pZCBmcm9tCj4+ICsgKiBAaWI6
IElCIG9iamVjdCB0byBzY2hlZHVsZQo+PiArICoKPj4gKyAqIGZsdXNoIHRoZSBJQiBieSBncmFw
aGljcyBjYWNoZSByaW5zZS4KPj4gKyAqLwo+PiArc3RhdGljIHZvaWQgc2RtYV92NV8yX3Jpbmdf
ZW1pdF9tZW1fc3luYyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCj4+ICt7Cj4+ICsgICAgdWlu
dDMyX3QgZ2NyX2NudGwgPQo+PiArCQkgICAgU0RNQV9HQ1JfR0wyX0lOViB8IFNETUFfR0NSX0dM
Ml9XQiB8IFNETUFfR0NSX0dMTV9JTlYgfAo+PiArCQkJU0RNQV9HQ1JfR0wxX0lOViB8IFNETUFf
R0NSX0dMVl9JTlYgfCBTRE1BX0dDUl9HTEtfSU5WIHwKPj4gKwkJCVNETUFfR0NSX0dMSV9JTlYo
MSk7Cj4+ICsKPj4gKwkvKiBmbHVzaCBlbnRpcmUgY2FjaGUgTDAvTDEvTDIsIHRoaXMgY2FuIGJl
IG9wdGltaXplZCBieSBwZXJmb3JtYW5jZSByZXF1aXJlbWVudCAqLwo+PiArCWFtZGdwdV9yaW5n
X3dyaXRlKHJpbmcsIFNETUFfUEtUX0hFQURFUl9PUChTRE1BX09QX0dDUl9SRVEpKTsKPj4gKwlh
bWRncHVfcmluZ193cml0ZShyaW5nLCBTRE1BX1BLVF9HQ1JfUkVRX1BBWUxPQUQxX0JBU0VfVkFf
MzFfNygwKSk7Cj4+ICsJYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgU0RNQV9QS1RfR0NSX1JFUV9Q
QVlMT0FEMl9HQ1JfQ09OVFJPTF8xNV8wKGdjcl9jbnRsKSB8Cj4+ICsJCQlTRE1BX1BLVF9HQ1Jf
UkVRX1BBWUxPQUQyX0JBU0VfVkFfNDdfMzIoMCkpOwo+PiArCWFtZGdwdV9yaW5nX3dyaXRlKHJp
bmcsIFNETUFfUEtUX0dDUl9SRVFfUEFZTE9BRDNfTElNSVRfVkFfMzFfNygwKSB8Cj4+ICsJCQlT
RE1BX1BLVF9HQ1JfUkVRX1BBWUxPQUQzX0dDUl9DT05UUk9MXzE4XzE2KGdjcl9jbnRsID4+IDE2
KSk7Cj4+ICsJYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgU0RNQV9QS1RfR0NSX1JFUV9QQVlMT0FE
NF9MSU1JVF9WQV80N18zMigwKSB8Cj4+ICsJCQlTRE1BX1BLVF9HQ1JfUkVRX1BBWUxPQUQ0X1ZN
SUQoMCkpOwo+PiArfQo+PiArCj4+ICAgLyoqCj4+ICAgICogc2RtYV92NV8yX3JpbmdfZW1pdF9o
ZHBfZmx1c2ggLSBlbWl0IGFuIGhkcCBmbHVzaCBvbiB0aGUgRE1BIHJpbmcKPj4gICAgKgo+PiBA
QCAtMTY2Myw2ICsxNjkwLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfcmluZ19mdW5j
cyBzZG1hX3Y1XzJfcmluZ19mdW5jcyA9IHsKPj4gICAJCTEwICsgMTAgKyAxMCwgLyogc2RtYV92
NV8yX3JpbmdfZW1pdF9mZW5jZSB4MyBmb3IgdXNlciBmZW5jZSwgdm0gZmVuY2UgKi8KPj4gICAJ
LmVtaXRfaWJfc2l6ZSA9IDcgKyA2LCAvKiBzZG1hX3Y1XzJfcmluZ19lbWl0X2liICovCj4+ICAg
CS5lbWl0X2liID0gc2RtYV92NV8yX3JpbmdfZW1pdF9pYiwKPj4gKwkuZW1pdF9tZW1fc3luYyA9
IHNkbWFfdjVfMl9yaW5nX2VtaXRfbWVtX3N5bmMsCj4+ICAgCS5lbWl0X2ZlbmNlID0gc2RtYV92
NV8yX3JpbmdfZW1pdF9mZW5jZSwKPj4gICAJLmVtaXRfcGlwZWxpbmVfc3luYyA9IHNkbWFfdjVf
Ml9yaW5nX2VtaXRfcGlwZWxpbmVfc3luYywKPj4gICAJLmVtaXRfdm1fZmx1c2ggPSBzZG1hX3Y1
XzJfcmluZ19lbWl0X3ZtX2ZsdXNoLAo+PiAtLSAKPj4gMi4yNy4wCj4+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
