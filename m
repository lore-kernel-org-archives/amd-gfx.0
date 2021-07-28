Return-Path: <SRS0=0Udm=MU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37A1C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 10:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 958C260F9E
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jul 2021 10:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 958C260F9E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D61F6E29D;
	Wed, 28 Jul 2021 10:27:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 056B86E02D;
 Wed, 28 Jul 2021 10:27:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxfOY7wg9RaUDnpTuFVW4q32eC4kpK7whDzSzO8SgkLs79w7xTnOGM1i/zSVW4GYFdD3RhQjZQ3fOmqXymhhXYvJWW7jQdkAesAr8PxUUCgJ7CvMsDeJJFGynpgMI7UbmkmzwWhtoKov2Q8hV7oEMJNvJrbnezZzubnLfsHAc2EnyX6uDgVdruntXYIAGTVVGseOdvUQaohoq2QfMFi/sx6xGD5Xhsfti5sbb8cDQJsYuWl9UQuLKTSpiBKnzTemTpNQHv6UhXkzwFxRTaFDqtMjXW8gj9dv3YmrS5PYuQqOJb54EOPg3J3RPOvHGgLNGoDhiOenB+1hjCJ9uH7GsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJpTtCMpM0/F8YulJgdsFKHywu6fFZKjKHoz3GTGKG8=;
 b=IshVPFSny8U9Iixvx1ZnNDEaYW46JefhGf06ADJMQVOnlWQz4YbeniIrUBFfJPYqzbgX4WBJ5Wbod8peolWFZ4GnUS+OKNayQMnj5/bCpiALY/0YRBV98OyExVAZT16XRE6o2w8AxXmeK4s53ZVR08kNGXQ5WcAEYrkkaxMExoFjnEzLhdBbRYG04iYgeCQy/dQ2uoTLGf1SamMyQMFwkvexGsuesZEob9oCsVnPwdj21s1H00zUqSXBd6ecUIoRBb8K3ujI8MmZXdxPsE5JF28ErZRYIve7cl7hNZ4x3Dnu68HoUGFrtD87n+66iyaAIoiDpINYUnTskNBuCkQEmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJpTtCMpM0/F8YulJgdsFKHywu6fFZKjKHoz3GTGKG8=;
 b=G/7xU8PaGOS1Driuh/DPimOnDA/FhkIqGft9GZSteF6uCAA7AqUllI31BPx5sAIPr4S9u4CQjUYBQis7GEBKk8kgcgNOqEVd50Ogfpatqtz94pj8ZMGpQWOZG5sOQIwxXR6MYs8yfgk8rZXmgLgp/kXVdymGet7bcCH9W4g8nGc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2577.namprd12.prod.outlook.com (2603:10b6:207:42::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Wed, 28 Jul
 2021 10:27:36 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 10:27:36 +0000
Subject: Re: [PATCH 01/14] drm/amdgpu: Convert to Linux IRQ interfaces
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@linux.ie, alexander.deucher@amd.com, liviu.dudau@arm.com,
 brian.starkey@arm.com, sam@ravnborg.org, bbrezillon@kernel.org,
 nicolas.ferre@microchip.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, stefan@agner.ch, alison.wang@nxp.com,
 patrik.r.jakobsson@gmail.com, anitha.chrisanthus@intel.com,
 robdclark@gmail.com, edmund.j.dea@intel.com, sean@poorly.run,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 jyri.sarha@iki.fi, tomba@kernel.org
References: <20210727182721.17981-1-tzimmermann@suse.de>
 <20210727182721.17981-2-tzimmermann@suse.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <24a8b2ab-ef38-219b-99d4-806a44fa6aba@amd.com>
Date: Wed, 28 Jul 2021 12:27:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210727182721.17981-2-tzimmermann@suse.de>
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0104.eurprd05.prod.outlook.com
 (2603:10a6:207:1::30) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:502c:190e:1ca:e49a]
 (2a02:908:1252:fb60:502c:190e:1ca:e49a) by
 AM3PR05CA0104.eurprd05.prod.outlook.com (2603:10a6:207:1::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.17 via Frontend Transport; Wed, 28 Jul 2021 10:27:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d72ae12-4bd0-4c5f-a134-08d951b250cd
X-MS-TrafficTypeDiagnostic: BL0PR12MB2577:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB257766F12E5C8F4AD2E7CAD983EA9@BL0PR12MB2577.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nT/XJCI2pmOhBEjlRrJnkWC/LAYZU1ZPxrjtR+c7BGJOwxvYopPmIRu4Y/TsFdHKT/4B87G8g1dQkqU8tRXGGP/nJELl96m+WGwnwpfCzJimkJ3GoaJPIzslGmHLLS2eMWyEMTApTQfk3leUZCxrCkiP+tyQWiuXvD+QO1QxJs6XFWpRkiPAWsyHiIfh+2lUtnLeCpfJn5spL8e4r5UrmALzsHu7nF4Rnpvuupr3aaWXyDNZXiS+MyyKnnnyfs7WR/7WD35rtfDldwfUGTfDP7OAbvhB0W8o48InY1n+VwVUHRzV8IHZy2o8UZqCrzu4F9w4RsZVEJ56aPJDUQvGXYu4zsQ+xCLNqzR3FT7tuSS9G0wQW6NXz4NUvzbQQ3SIN9P8E6kfnjwa6OXWbvyBI0tbt/WFdmkaL7BFEkw46yg+Dkvejd58uTaiZ4TIYSq3BN6OoNhQNmWeBFMBfGsJAC9jj/s1mnl6ueaNOUGLJam/ReyuXHqiAzB7jIGDLuh24p0dq2jXL2kvPwktTqKqeuRbxLH276Mao1jkKvkjEjZgzUbs5XyfE3Zkfe3f7YqZuOOIGxXx1rLVttb/G0ZWuym+g0EnoFM57Jx3qD1DqOgnMTpXLy9tZo1IaH4tNdrpENvzHnOA+i2X6qljYKD1B5lVXXz9tLaltUr5cm06suLJAWRcPpFfWWKciPAKTBOtxSUgAlPlTbMDw13U5jQnPOQ4bN02+BjH21j6ADNXyEkBUDiAnYyo1A192G84tg0k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(4326008)(36756003)(31696002)(31686004)(7416002)(83380400001)(5660300002)(316002)(6486002)(66574015)(186003)(8936002)(86362001)(8676002)(2906002)(66476007)(66556008)(478600001)(921005)(38100700002)(6666004)(2616005)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG1oZTJkbU9UU2hPbS9HeDYzditlUmxuWEN2SWFXckczMThqbGdUc1JZMUhw?=
 =?utf-8?B?WGZuZ0ZHaFloQm51UjI2MjRTR01JenpucEdBMHA5L255cVh3bTBhR0NvWVRj?=
 =?utf-8?B?S1dWejRXMTFCOUh5UUdYM0R6eVNYaHFMa1ExcnNSbXJXK0ZjWE83TlUwcENy?=
 =?utf-8?B?SGQwRnFZdEpjc0Ezbm1zSHdOcGhKdmpyR1JEdURocU5EenhQWWdCUURuZjZ4?=
 =?utf-8?B?VUh1M1MzREhvM2lIWEo5WjQ4Y2x5MDV2MitWSVIrWlduMm1VQUp5SkViYTZY?=
 =?utf-8?B?WVN6U0tKUkpSS2RGdjJ3VVRnRzRSVmV0K2Fkd0NvL2N0UHUrZUUxZndRZ3JN?=
 =?utf-8?B?ZjJQajBxMXBXUXBqOEFldmtJR0UxQzh3UElmTjloOWVvbHRYVWk1aUNEUnBt?=
 =?utf-8?B?YVZ2OFlpeXVDdm1CVU52K3ZwVXdicG13akdGTHF3RzlWSkFISThhcWdjZk5L?=
 =?utf-8?B?QlY3MnNsU044UnZCRGw3QlZnbmVacFhjckhlc28rYUI2dlVCNFNQbEhieXZZ?=
 =?utf-8?B?UzZUMU1UejVKMmZEbmc5R2ZkTVMzd0psb253YldkR0hJaW9CcHdtNDZZNGpp?=
 =?utf-8?B?eG9QY240VThxbHM3cndnNTdvcW9weDBuRUJxVUxQbmRIVnp6eXp6d2FaWjc0?=
 =?utf-8?B?RU5iUjJOMTVXdGJrWUpiek9lOHBXRmJNTzhvcG5wSXpiVndTWDdDK1dtNE45?=
 =?utf-8?B?Vm15aVMzMDZTMDRRMUtXN25xTFZ6UzdOL2M0SFp3NGVsQWtaQytqUnpaaCsz?=
 =?utf-8?B?YU1tZm5QSnBrbEpnVHZ6UDlZMDEzeWlkSTIwcmpLbjZRNk1Hc29TSEtyKzRF?=
 =?utf-8?B?RFphNExRRE9MTVppNm9SQXlVQ1M1WWhNRjN3RXZQN3k3U0o4aXZ5R2RGdDdp?=
 =?utf-8?B?NVg3VWVZT0F6T210SEVrSkVXdlFjRzBWVndHK21nNVBVMXhoK1JMeUJUa3N3?=
 =?utf-8?B?OUVja1ZTRHFOVWxjSlJHQUtJVDVQdUF5b1JSKzQ4RzdIU2xkOHlWeUxNQ3Ns?=
 =?utf-8?B?OVA2bSt1T3krL2QxSjFZVmZ5ejE2cTNHS0dNaUdjS3k4RUt0d1dRWmdNNVQ5?=
 =?utf-8?B?ZUVlQjBDU1hBOGNud21McjI3a2p6TytLby84WTBONTFRQlpyUG5pZ0VQUTJx?=
 =?utf-8?B?VEpOUjZ4bDNOTUFrNEpOV3ljQ2RTMCs2SkdpVjlDeFBhaXpSQzU5a0loU29m?=
 =?utf-8?B?ZEVZNDRGTmc4dmlpdnozUlE1ZnVSUktMWElXdUQ3c0hmQzVSZGgyRkYyMTg4?=
 =?utf-8?B?RzFENnMzR2N2cjIyV3AyZ2I0aDh5ZGtCNmwwSTJqLzBsdlJnMDRiVk82OXpp?=
 =?utf-8?B?K2RremxmamYvQ1FqZkJ6V3FlczJnL3FLcDlvQzNnODFadlo1cmNRMmhxZklN?=
 =?utf-8?B?eFJPZnFadTZrSzR0Q2I3ZmQ3WWVYczl0ZEp5VnZ4aTU0TWFQU1NETEtKdzVq?=
 =?utf-8?B?U28zTkpsUUxqZkdaZk5LWmphOER6d1EvaWNzcWlSRmZka1JuNm5ndXJVYkJR?=
 =?utf-8?B?am5hMkxhTlNqVW9QVSs3ZG1kUU9KRi9SeFRyamJFOU5xWVRmRHNYYXRlZ3Vx?=
 =?utf-8?B?MEw1RTNUcFpqREpOeDM2U3dYMjMwZDgrQkxrMnVQRkVpbkxCNTBmblB4Q0U1?=
 =?utf-8?B?RzNreklGTlNUOFhDb1RLaks0MC9GajdqR0dEWUpENDM4Q1IveHZDRnlUc3F3?=
 =?utf-8?B?dldWeURDWkFxUHI1WGxnZnc0MmJFYmpIenZMV1ZzUFd1Z3huUGFHWUUwclh0?=
 =?utf-8?B?b3VCODFtSzZ5M1o1bHp3UEtDd1Voemp3MmorQzhQa0M3SXYwditZb3MvWmM2?=
 =?utf-8?B?d3hXam9yTUNYaVU2ZVRQaGl6cUNqUDJYSisvaFhMRlhuMEtBK3NVYTFKdGo2?=
 =?utf-8?Q?BK7ebwK4+tEO7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d72ae12-4bd0-4c5f-a134-08d951b250cd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 10:27:36.3151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dA4jfKnjfxLae+o3MWfi2AJs1lS2g8z+8z0qI4Z2YoyOS8iqKvNCjy/bYc+ZZ0VY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2577
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
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjcuMDcuMjEgdW0gMjA6Mjcgc2NocmllYiBUaG9tYXMgWmltbWVybWFubjoKPiBEcm9wIHRo
ZSBEUk0gSVJRIG1pZGxheWVyIGluIGZhdm9yIG9mIExpbnV4IElSUSBpbnRlcmZhY2VzLiBEUk0n
cwo+IElSUSBoZWxwZXJzIGFyZSBtb3N0bHkgdXNlZnVsIGZvciBVTVMgZHJpdmVycy4gTW9kZXJu
IEtNUyBkcml2ZXJzCj4gZG9uJ3QgYmVuZWZpdCBmcm9tIHVzaW5nIGl0Lgo+Cj4gRFJNIElSUSBj
YWxsYmFja3MgYXJlIG5vdyBiZWluZyBjYWxsZWQgZGlyZWN0bHkgb3IgaW5saW5lZC4KPgo+IFRo
ZSBpbnRlcnJ1cHQgbnVtYmVyIHJldHVybmVkIGJ5IHBjaV9tc2lfdmVjdG9yKCkgaXMgbm93IHN0
b3JlZAo+IGluIHN0cnVjdCBhbWRncHVfaXJxLiBDYWxscyB0byBwY2lfbXNpX3ZlY3RvcigpIGNh
biBmYWlsIGFuZCByZXR1cm4KPiBhIG5lZ2F0aXZlIGVycm5vIGNvZGUuIEFib3J0IGluaXRsYWl6
YXRvbiBpbiB0aGkgY2FzZS4gVGhlIERSTSBJUlEKPiBtaWRsYXllciBkb2VzIG5vdCBoYW5kbGUg
dGhpcyBjb3JyZWN0bHkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgWmltbWVybWFubiA8dHpp
bW1lcm1hbm5Ac3VzZS5kZT4KCkFsZXggbmVlZHMgdG8gdGFrZSBhIGxvb2sgYXQgdGhpcyBhcyB3
ZWxsLCBidXQgb2YgaGFuZCB0aGUgcGF0Y2ggaXMgCkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+LgoKVGhhbmtzLApDaHJpc3RpYW4uCgo+IC0tLQo+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwgIDEgLQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jIHwgMjEgKysrKysrKysrKysrKyst
LS0tLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJxLmggfCAgMiAr
LQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwo+IGluZGV4IDJiZDEzZmMy
NTQxYS4uMWUwNWI1YWE5NGU3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kcnYuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kcnYuYwo+IEBAIC0xNzc1LDcgKzE3NzUsNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRybV9k
cml2ZXIgYW1kZ3B1X2ttc19kcml2ZXIgPSB7Cj4gICAJLm9wZW4gPSBhbWRncHVfZHJpdmVyX29w
ZW5fa21zLAo+ICAgCS5wb3N0Y2xvc2UgPSBhbWRncHVfZHJpdmVyX3Bvc3RjbG9zZV9rbXMsCj4g
ICAJLmxhc3RjbG9zZSA9IGFtZGdwdV9kcml2ZXJfbGFzdGNsb3NlX2ttcywKPiAtCS5pcnFfaGFu
ZGxlciA9IGFtZGdwdV9pcnFfaGFuZGxlciwKPiAgIAkuaW9jdGxzID0gYW1kZ3B1X2lvY3Rsc19r
bXMsCj4gICAJLm51bV9pb2N0bHMgPSBBUlJBWV9TSVpFKGFtZGdwdV9pb2N0bHNfa21zKSwKPiAg
IAkuZHVtYl9jcmVhdGUgPSBhbWRncHVfbW9kZV9kdW1iX2NyZWF0ZSwKPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jCj4gaW5kZXggMGQwMWNmYWNhNzdlLi5hMzZjZGM3MzIz
ZjQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5j
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jCj4gQEAgLTQ2
LDcgKzQ2LDYgQEAKPiAgICNpbmNsdWRlIDxsaW51eC9wY2kuaD4KPiAgIAo+ICAgI2luY2x1ZGUg
PGRybS9kcm1fY3J0Y19oZWxwZXIuaD4KPiAtI2luY2x1ZGUgPGRybS9kcm1faXJxLmg+Cj4gICAj
aW5jbHVkZSA8ZHJtL2RybV92YmxhbmsuaD4KPiAgICNpbmNsdWRlIDxkcm0vYW1kZ3B1X2RybS5o
Pgo+ICAgI2luY2x1ZGUgPGRybS9kcm1fZHJ2Lmg+Cj4gQEAgLTE4NCw3ICsxODMsNyBAQCB2b2lk
IGFtZGdwdV9pcnFfZGlzYWJsZV9hbGwoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAg
KiBSZXR1cm5zOgo+ICAgICogcmVzdWx0IG9mIGhhbmRsaW5nIHRoZSBJUlEsIGFzIGRlZmluZWQg
YnkgJmlycXJldHVybl90Cj4gICAgKi8KPiAtaXJxcmV0dXJuX3QgYW1kZ3B1X2lycV9oYW5kbGVy
KGludCBpcnEsIHZvaWQgKmFyZykKPiArc3RhdGljIGlycXJldHVybl90IGFtZGdwdV9pcnFfaGFu
ZGxlcihpbnQgaXJxLCB2b2lkICphcmcpCj4gICB7Cj4gICAJc3RydWN0IGRybV9kZXZpY2UgKmRl
diA9IChzdHJ1Y3QgZHJtX2RldmljZSAqKSBhcmc7Cj4gICAJc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYgPSBkcm1fdG9fYWRldihkZXYpOwo+IEBAIC0zMDcsNiArMzA2LDcgQEAgc3RhdGljIHZv
aWQgYW1kZ3B1X3Jlc3RvcmVfbXNpeChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIGlu
dCBhbWRncHVfaXJxX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICB7Cj4gICAJ
aW50IHIgPSAwOwo+ICsJdW5zaWduZWQgaW50IGlycTsKPiAgIAo+ICAgCXNwaW5fbG9ja19pbml0
KCZhZGV2LT5pcnEubG9jayk7Cj4gICAKPiBAQCAtMzQ5LDE1ICszNDksMjIgQEAgaW50IGFtZGdw
dV9pcnFfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIAlJTklUX1dPUksoJmFk
ZXYtPmlycS5paDJfd29yaywgYW1kZ3B1X2lycV9oYW5kbGVfaWgyKTsKPiAgIAlJTklUX1dPUkso
JmFkZXYtPmlycS5paF9zb2Z0X3dvcmssIGFtZGdwdV9pcnFfaGFuZGxlX2loX3NvZnQpOwo+ICAg
Cj4gLQlhZGV2LT5pcnEuaW5zdGFsbGVkID0gdHJ1ZTsKPiAtCS8qIFVzZSB2ZWN0b3IgMCBmb3Ig
TVNJLVggKi8KPiAtCXIgPSBkcm1faXJxX2luc3RhbGwoYWRldl90b19kcm0oYWRldiksIHBjaV9p
cnFfdmVjdG9yKGFkZXYtPnBkZXYsIDApKTsKPiArCS8qIFVzZSB2ZWN0b3IgMCBmb3IgTVNJLVgu
ICovCj4gKwlyID0gcGNpX2lycV92ZWN0b3IoYWRldi0+cGRldiwgMCk7Cj4gKwlpZiAociA8IDAp
Cj4gKwkJcmV0dXJuIHI7Cj4gKwlpcnEgPSByOwo+ICsKPiArCS8qIFBDSSBkZXZpY2VzIHJlcXVp
cmUgc2hhcmVkIGludGVycnVwdHMuICovCj4gKwlyID0gcmVxdWVzdF9pcnEoaXJxLCBhbWRncHVf
aXJxX2hhbmRsZXIsIElSUUZfU0hBUkVELCBhZGV2X3RvX2RybShhZGV2KS0+ZHJpdmVyLT5uYW1l
LAo+ICsJCQlhZGV2X3RvX2RybShhZGV2KSk7Cj4gICAJaWYgKHIpIHsKPiAtCQlhZGV2LT5pcnEu
aW5zdGFsbGVkID0gZmFsc2U7Cj4gICAJCWlmICghYW1kZ3B1X2RldmljZV9oYXNfZGNfc3VwcG9y
dChhZGV2KSkKPiAgIAkJCWZsdXNoX3dvcmsoJmFkZXYtPmhvdHBsdWdfd29yayk7Cj4gICAJCXJl
dHVybiByOwo+ICAgCX0KPiArCWFkZXYtPmlycS5pbnN0YWxsZWQgPSB0cnVlOwo+ICsJYWRldi0+
aXJxLmlycSA9IGlycTsKPiAgIAlhZGV2X3RvX2RybShhZGV2KS0+bWF4X3ZibGFua19jb3VudCA9
IDB4MDBmZmZmZmY7Cj4gICAKPiAgIAlEUk1fREVCVUcoImFtZGdwdTogaXJxIGluaXRpYWxpemVk
LlxuIik7Cj4gQEAgLTM2OCw3ICszNzUsNyBAQCBpbnQgYW1kZ3B1X2lycV9pbml0KHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQo+ICAgdm9pZCBhbWRncHVfaXJxX2ZpbmlfaHcoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpCj4gICB7Cj4gICAJaWYgKGFkZXYtPmlycS5pbnN0YWxsZWQpIHsK
PiAtCQlkcm1faXJxX3VuaW5zdGFsbCgmYWRldi0+ZGRldik7Cj4gKwkJZnJlZV9pcnEoYWRldi0+
aXJxLmlycSwgYWRldl90b19kcm0oYWRldikpOwo+ICAgCQlhZGV2LT5pcnEuaW5zdGFsbGVkID0g
ZmFsc2U7Cj4gICAJCWlmIChhZGV2LT5pcnEubXNpX2VuYWJsZWQpCj4gICAJCQlwY2lfZnJlZV9p
cnFfdmVjdG9ycyhhZGV2LT5wZGV2KTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2lycS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2lycS5oCj4gaW5kZXggNzhhZDQ3ODRjYzc0Li5lOWYyYzExZWE0MTYgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5oCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5oCj4gQEAgLTgwLDYgKzgwLDcgQEAgc3RydWN0
IGFtZGdwdV9pcnFfc3JjX2Z1bmNzIHsKPiAgIAo+ICAgc3RydWN0IGFtZGdwdV9pcnEgewo+ICAg
CWJvb2wJCQkJaW5zdGFsbGVkOwo+ICsJdW5zaWduZWQgaW50CQkJaXJxOwo+ICAgCXNwaW5sb2Nr
X3QJCQlsb2NrOwo+ICAgCS8qIGludGVycnVwdCBzb3VyY2VzICovCj4gICAJc3RydWN0IGFtZGdw
dV9pcnFfY2xpZW50CWNsaWVudFtBTURHUFVfSVJRX0NMSUVOVElEX01BWF07Cj4gQEAgLTEwMCw3
ICsxMDEsNiBAQCBzdHJ1Y3QgYW1kZ3B1X2lycSB7Cj4gICB9Owo+ICAgCj4gICB2b2lkIGFtZGdw
dV9pcnFfZGlzYWJsZV9hbGwoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwo+IC1pcnFyZXR1
cm5fdCBhbWRncHVfaXJxX2hhbmRsZXIoaW50IGlycSwgdm9pZCAqYXJnKTsKPiAgIAo+ICAgaW50
IGFtZGdwdV9pcnFfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7Cj4gICB2b2lkIGFt
ZGdwdV9pcnFfZmluaV9zdyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
