Return-Path: <SRS0=mcQQ=MM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A90C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 08:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06F506101B
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jul 2021 08:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F506101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 381526E303;
	Tue, 20 Jul 2021 08:17:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 172546E1A3;
 Tue, 20 Jul 2021 08:17:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1Devk/YlflaqzAShY0e7GmhycddVVY92fMD303rpp/2TBEdtrZ3ngkm8YTElq0GJN2ueZUuwZUPwKPWB7J+jQFG11QHrvUeWBGLcui7Wg69fomiA0OAnNHlDugq+C1WPeNCRTAWYsaEQk/NrujuQl9Qn1FH3uFgSpiMUzN8iKc/CQ4vPsrqIecAiYOo05RiPWhQt/9wB9+4nz3YmFvLEFqiadNRjbXX+hs5EnUEuFOpxDH5ugz/yWyv8BigPaBOZd7Nsbb2VgZOZrvwhBbJ0fHwdasyF6oZvYZsjWcZ+JVRs0H5R7FtfMzqKg6htdfvV85FSdd9urpiNY5i1pV1sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wk82qEYdky3qaTaDmXcKebA8AXYNofaorVIl6qrbkk=;
 b=MLxRhaxoJq3Zp3vA0UJJVA8MpmHlnS5zSm0rEXaYsGSpW3F+s7uWDtsO5nv/49YVyJ+DPaq05G51r9yL5v5fsIctfi5SZQZhX1p44s/pPNJimtQFRsz/3juu+9nNUMuUtFBRdi/hEt/k2zE40Y57eleN1lrSATqGwTtJgA+bdIeHh8PVwGAaie6LQvjPoAGA7QMFNGpSM/3Q7RmNJ3I2KAFDkKUORZrJRTuT1M1l2tqLXLFD/wpuZM3vYCW1NEq449q+xp5rrciVoxqld9PpWFY9Qm/Fysq+J+3wmUuDE/hz11Vo6WgBpH6HMpVatmrlPhTAen3zq+PmSC8HoiyyXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wk82qEYdky3qaTaDmXcKebA8AXYNofaorVIl6qrbkk=;
 b=3j0D4MeoTFsG28kOjq9q4RppGvX93nXYjPQd1BuVNYtLYi0KiEV1efqVmh3X2Oh+DAraM/kD9+G/DmmWssixC+i3HMiCd2W67zKXZB/Ci4WWYBGgrd839318WBDjfU+hkZNXJlJAO0h4wBRHMBziBzpJUdqD4EYH01npaR4uO5E=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3998.namprd12.prod.outlook.com (2603:10b6:208:16d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 08:17:30 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 08:17:30 +0000
Subject: Re: [PATCH v3 3/4] drm/amd/display: Add control mechanism for FPU
 utilization
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, Daniel Vetter <daniel@ffwll.ch>,
 roman.li@amd.com, sunpeng.li@amd.com
References: <20210720004914.3060879-1-Rodrigo.Siqueira@amd.com>
 <20210720004914.3060879-4-Rodrigo.Siqueira@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <27570b32-87ec-730c-31f7-e12fab277756@amd.com>
Date: Tue, 20 Jul 2021 10:17:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210720004914.3060879-4-Rodrigo.Siqueira@amd.com>
Content-Language: en-US
X-ClientProxiedBy: PR0P264CA0162.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::30) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:8651:5b5e:8648:2fd0]
 (2a02:908:1252:fb60:8651:5b5e:8648:2fd0) by
 PR0P264CA0162.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1b::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.31 via Frontend Transport; Tue, 20 Jul 2021 08:17:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d65b53f2-4d8c-4956-edee-08d94b56d13c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3998:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB39981C01908C234440A7B92D83E29@MN2PR12MB3998.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:161;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Js6pNrKtfxMMOtNlEYvTiAnW4bOqawQdz8Q5hLTWJqFioAJoaKRRyNWXgCf4I4huy5hnKtZwF0/f3YSrZUNKB/oMyKNFhehniN9OOprS/M7qYrLewmo6Y7/rxqcF7jiI6sWpKjetYzrYLEDqnm9KX45be4TDLSMb0i/9WBFWtd8/+5A5bi6pSKHbR48fRR75urRDnbcmYQH6FMyqLgtWTMb7HdZ86MJMevaIlETgKZXr8+0oSVtroZttoQnkxMRfz2A1h2/jFVxACk4xQgf2J7JDuV5u0dOhWs7GflgxOhF8sv9j1dy7Ie0bPhUoaIbfr+iBqBsKNXhsVmpEciGs/2cv+HkkEeHw/sz6rQoVRXT8W9frK0a8gblG5Ca8XyZjdGb6/SSDAg+i7unS35rY/lB2wJO/TIXn2xE6jr/lr8RMYG3ksZQ/PFU7UFNTvyN3ZhUDpuQGLB3sIv+YF+28jd+/D8x1gilgzW7cRDMxo1SE7SIwAIS37LTexBRjgO4w/p/g7RZCTVvQ42Mf+h0RUnBN+jzsifQAfqmBoOwhsVmeIA5L/Fd/XdnA/MZC+4aiU55SB1nwTEX6ZlWNJDCO5gXQ5M44UNR9tXp5GAI6M4M9XhNFZuJq3EB1pPPFt99+7RlcmmKu1wug4YQXRdRz2oUR6fS4mMF3zN3SLWxVB8sWZwqQ4PQty7G07E81SCk29bR8dcbybkZ92F7uFOU2t3Qw40WHDj/t36+1YMAyzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(186003)(31696002)(36756003)(83380400001)(8936002)(38100700002)(66476007)(66556008)(6636002)(2906002)(66946007)(6486002)(86362001)(8676002)(2616005)(316002)(54906003)(110136005)(6666004)(4326008)(478600001)(31686004)(66574015)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vzh5VGxFVUdnaThFak0ycjUvSEZZZVJqNkQxLzVXM3pMYitMblphbkN1UzJR?=
 =?utf-8?B?bG1lTmlHWjQwa08rRXNSV1lrcFpDYTRpcGNMRDM5d2duTUZ5YlM5Q1JvVGhq?=
 =?utf-8?B?MUl5V0pFTDFQa0ErTTZpdkVKY0VjOUJZOWtZOEcxaDVZYzV1TzFDUFJqRHVw?=
 =?utf-8?B?R1V2ZTdGNnE0dVdjSVVXMjd5QVlLM201QXYzMERjQm54S2tZWnBPczh5ZG9S?=
 =?utf-8?B?SnFoSG1SRnMxMklzK29BcTN3TTNiY0puMnVWK3BVNmJEQ1llTU1xVTZGUXJn?=
 =?utf-8?B?djRCVlkwOWdtRisyQjVOMlBaWHlQRTdHT1dHU3l0Z09OMFJpeEVWYndncW12?=
 =?utf-8?B?NmRXd3hTVGVsWFNYdmNlR04wOUNSL05sbG9iLzFlejZXczRoS0swd080WW5n?=
 =?utf-8?B?RjArTjJkeXVybGJRcUZFQk9TbWVkazdCbWdQaUVFNGJ5KzNMa2dkVVdtVWlS?=
 =?utf-8?B?K2tZb0JETm1jUWJUZWtyc1REY1RKOXYxbGhlb2RFSFROVS9BQThvWnlEM2FQ?=
 =?utf-8?B?L0FTYkpUY3hPMitqQW1WR000akNocFNiWmtwdmIra2F0QUhpUlhlWWpwZGkz?=
 =?utf-8?B?d3lQUTZiODJ4U05PL3FUOE12WUtUMGozQ0hKZk5MUVduSUJaRFlvTHRHT1F0?=
 =?utf-8?B?NEhIbXNvRG1sYzYwa290K1JQdjJoSk80MmNsNTJ0UEFSUnNYOS9abXNtWE5Z?=
 =?utf-8?B?eVRER1NKWXRHOURNdHdpWm1talNURmhJb2hTV3dBbEZJTUpYUkNGeTZGeDlL?=
 =?utf-8?B?cys1dTVGQkJXS3hFS2w5Mm5KREdXUzFPMEUrVUJXdnlpSDV5VkE1NGdYVWJu?=
 =?utf-8?B?cXpBaDhvUGFIbjZBOFJ0NmIwN01NeC8yTXZ3aHp1NEVKaGZEdGZNOFRGMC9T?=
 =?utf-8?B?T1BCTmdIZnJXNmFtQkFPa1pxQ3FSdEp4V2xXN1REc2x2elArdkhtd3JDSVFQ?=
 =?utf-8?B?MldWTjRKU3Vla2xTMk5wRTNPWDdSczUrSnllWXdZSzZ3T3E4OEl0M0pyWjlL?=
 =?utf-8?B?U09vd0N6bTZRN1VFcEJXZlI4OVEwMmN2VlhPbm1XUnJibzR0VEhydElhRzlB?=
 =?utf-8?B?OGZDMmxjT3JYRzRnWWZXUVNNM1MxMjBrZkFhdkhSaFlNMFZpZHBhQWM1ck1W?=
 =?utf-8?B?dGFObk1TMW80c0syUmh6MFAyalJjMHZabUhwSkROQUIxWi8yQVNVQklSRDZ4?=
 =?utf-8?B?b0I1N3I1MC9SanF0cFF0R0t2bkViV21SZkQ4V0kwNW4wYTJ1MXRMYUtpZjlO?=
 =?utf-8?B?YW5hV09WZWl2UUlGTmFlVUt4cTFSd3phcXpNYllxbWhOUVNJSk1vNE5iYkp4?=
 =?utf-8?B?dDRsOXc1Y2tZSURkS0g5SmpLSHpUUDU2UmRWTWxxRjNSQXViWkJUdCs1SHNx?=
 =?utf-8?B?SGhtcklTc3lEOE5oZjV3blNNQlVPay9SaUtTRC9FSFl1T3ZOY2N3eWh2eUdl?=
 =?utf-8?B?bDVscG9YOGpGY29zZGRkQ3FvcHhIV29DUzVENUlhbldPNmVVclV6SUJCWDYz?=
 =?utf-8?B?dzA2Slo3TjZBZmF1ZEVXT25TT1J2UHQzZENGWmNmUWxKN1hCbmNkbkRxZ0Zk?=
 =?utf-8?B?K0xUZThNN2xqYUgycVptWm5XSmdmSlg5M25uNzFFck9WQlN1c2F3MGVOL0tr?=
 =?utf-8?B?aldxbHJJMGR4WHBOakhrY3cvbUFMNVpKdVV0SktVZDc4eWZoaVc0NkF3Qm1Q?=
 =?utf-8?B?MWxZNTcxZVNuN09oM2JQOVhBSGFjNlpJZVFKZVZjUC83c1JxRk9oNjFqVWZK?=
 =?utf-8?B?b2xWUVRLOVROclpIRjFQZmF4cGVLQ28rZ2tvNGRWazkvSUhkcG91eHpqSXFh?=
 =?utf-8?B?YmIwWFlNaEdBTDQrQTVWb0MvYm1EQ3lUUnFuNXpoNmRyUkJ4MDlwMTNPdVdq?=
 =?utf-8?Q?n6CFG6sRcmYjf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65b53f2-4d8c-4956-edee-08d94b56d13c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:17:30.0886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDUHgzUAciZH4pfxv58ykVeC66EsWhSHEjCjLZIm1zXH6ZkibbEVE4HjpIgp0XyE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3998
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
Cc: Aric Cyr <aric.cyr@amd.com>, Anson Jacob <Anson.Jacob@amd.com>,
 dri-devel@lists.freedesktop.org, Hersen Wu <hersenxs.wu@amd.com>,
 amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAuMDcuMjEgdW0gMDI6NDkgc2NocmllYiBSb2RyaWdvIFNpcXVlaXJhOgo+IERDIGludm9r
ZXMgRENfRlBVX1NUQVJUL0VORCBpbiBtdWx0aXBsZSBwYXJ0cyBvZiB0aGUgY29kZTsgdGhpcyBj
YW4KPiBjcmVhdGUgYSBzaXR1YXRpb24gd2hlcmUgd2UgaW52b2tlIHRoaXMgRlBVIG9wZXJhdGlv
biBpbiBhIG5lc3RlZCB3YXkgb3IKPiBleGl0IHRvbyBlYXJseS4gRm9yIGF2b2lkaW5nIHRoaXMg
c2l0dWF0aW9uLCB0aGlzIGNvbW1pdCBhZGRzIGEKPiBtZWNoYW5pc20gd2hlcmUgZGNfZnB1X2Jl
Z2luL2VuZCBtYW5hZ2VzIHRoZSBhY2Nlc3MgdG8KPiBrZXJuZWxfZnB1X2JlZ2luL2VuZC4KPgo+
IENoYW5nZSBzaW5jZSBWMjoKPiAtIENocmlzdGlhbjogRG8gbm90IHVzZSB0aGlzX2NwdV8qIGJl
dHdlZW4gZ2V0L3B1dF9jcHVfcHRyKCkuCj4KPiBDaGFuZ2Ugc2luY2UgVjE6Cj4gLSBVc2UgYSBi
ZXR0ZXIgdmFyaWFibGUgbmFtZXMKPiAtIFVzZSBnZXRfY3B1X3B0ciBhbmQgcHV0X2NwdV9wdHIg
dG8gYmV0dGVyIGJhbGFuY2UgcHJlZW1wdGlvbiBlbmFibGUKPiBhbmQgZGlzYWJsZQo+Cj4gQ2M6
IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgo+IENjOiBBbnNvbiBKYWNv
YiA8QW5zb24uSmFjb2JAYW1kLmNvbT4KPiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgo+IENjOiBIZXJzZW4gV3UgPGhlcnNlbnhzLnd1QGFtZC5jb20+Cj4g
Q2M6IEFyaWMgQ3lyIDxhcmljLmN5ckBhbWQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFJvZHJpZ28g
U2lxdWVpcmEgPFJvZHJpZ28uU2lxdWVpcmFAYW1kLmNvbT4KPiAtLS0KPiAgIC4uLi9hbWQvZGlz
cGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3RyYWNlLmggICB8IDEzICsrKystLS0KPiAgIC4uLi9n
cHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9kY19mcHUuYyAgICB8IDM2ICsrKysrKysrKysr
KysrKystLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY190cmFjZS5oICAg
ICB8ICA0ICstLQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCAxMSBkZWxl
dGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1k
Z3B1X2RtL2FtZGdwdV9kbV90cmFjZS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Ft
ZGdwdV9kbS9hbWRncHVfZG1fdHJhY2UuaAo+IGluZGV4IDIzMGJiMTJjNDA1ZS4uZmRjYWVhMjJi
NDU2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0v
YW1kZ3B1X2RtX3RyYWNlLmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1k
Z3B1X2RtL2FtZGdwdV9kbV90cmFjZS5oCj4gQEAgLTYzOCwyMyArNjM4LDI2IEBAIFRSQUNFX0VW
RU5UKGFtZGdwdV9yZWZyZXNoX3JhdGVfdHJhY2ssCj4gICApOwo+ICAgCj4gICBUUkFDRV9FVkVO
VChkY25fZnB1LAo+IC0JICAgIFRQX1BST1RPKGJvb2wgYmVnaW4sIGNvbnN0IGNoYXIgKmZ1bmN0
aW9uLCBjb25zdCBpbnQgbGluZSksCj4gLQkgICAgVFBfQVJHUyhiZWdpbiwgZnVuY3Rpb24sIGxp
bmUpLAo+ICsJICAgIFRQX1BST1RPKGJvb2wgYmVnaW4sIGNvbnN0IGNoYXIgKmZ1bmN0aW9uLCBj
b25zdCBpbnQgbGluZSwgY29uc3QgaW50IHJlY3Vyc2lvbl9kZXB0aCksCj4gKwkgICAgVFBfQVJH
UyhiZWdpbiwgZnVuY3Rpb24sIGxpbmUsIHJlY3Vyc2lvbl9kZXB0aCksCj4gICAKPiAgIAkgICAg
VFBfU1RSVUNUX19lbnRyeSgKPiAgIAkJCSAgICAgX19maWVsZChib29sLCBiZWdpbikKPiAgIAkJ
CSAgICAgX19maWVsZChjb25zdCBjaGFyICosIGZ1bmN0aW9uKQo+ICAgCQkJICAgICBfX2ZpZWxk
KGludCwgbGluZSkKPiArCQkJICAgICBfX2ZpZWxkKGludCwgcmVjdXJzaW9uX2RlcHRoKQo+ICAg
CSAgICApLAo+ICAgCSAgICBUUF9mYXN0X2Fzc2lnbigKPiAgIAkJCSAgIF9fZW50cnktPmJlZ2lu
ID0gYmVnaW47Cj4gICAJCQkgICBfX2VudHJ5LT5mdW5jdGlvbiA9IGZ1bmN0aW9uOwo+ICAgCQkJ
ICAgX19lbnRyeS0+bGluZSA9IGxpbmU7Cj4gKwkJCSAgIF9fZW50cnktPnJlY3Vyc2lvbl9kZXB0
aCA9IHJlY3Vyc2lvbl9kZXB0aDsKPiAgIAkgICAgKSwKPiAtCSAgICBUUF9wcmludGsoIiVzKCkr
JWQ6ICVzIiwKPiArCSAgICBUUF9wcmludGsoIiVzOiByZWN1cnNpb25fZGVwdGg6ICVkOiAlcygp
KyVkOiIsCj4gKwkJICAgICAgX19lbnRyeS0+YmVnaW4gPyAiYmVnaW4iIDogImVuZCIsCj4gKwkJ
ICAgICAgX19lbnRyeS0+cmVjdXJzaW9uX2RlcHRoLAo+ICAgCQkgICAgICBfX2VudHJ5LT5mdW5j
dGlvbiwKPiAtCQkgICAgICBfX2VudHJ5LT5saW5lLAo+IC0JCSAgICAgIF9fZW50cnktPmJlZ2lu
ID8gImJlZ2luIiA6ICJlbmQiCj4gKwkJICAgICAgX19lbnRyeS0+bGluZQo+ICAgCSAgICApCj4g
ICApOwo+ICAgCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vZGNfZnB1LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2Rj
X2ZwdS5jCj4gaW5kZXggZDVkMTU2YTQ1MTdlLi5kMGQzZThhMzRkYjUgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9kY19mcHUuYwo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vZGNfZnB1LmMKPiBAQCAtMjgsNiAr
MjgsMTkgQEAKPiAgIAo+ICAgI2luY2x1ZGUgPGFzbS9mcHUvYXBpLmg+Cj4gICAKPiArLyoqCj4g
KyAqIERPQzogREMgRlBVIG1hbmlwdWxhdGlvbiBvdmVydmlldwo+ICsgKgo+ICsgKiBEQyBjb3Jl
IHVzZXMgRlBVIG9wZXJhdGlvbnMgaW4gbXVsdGlwbGUgcGFydHMgb2YgdGhlIGNvZGUsIHdoaWNo
IHJlcXVpcmVzIGEKPiArICogbW9yZSBzcGVjaWFsaXplZCB3YXkgdG8gbWFuYWdlIHRoZXNlIGFy
ZWFzJyBlbnRyYW5jZS4gVG8gZnVsZmlsbCB0aGlzCj4gKyAqIHJlcXVpcmVtZW50LCB3ZSBjcmVh
dGVkIHNvbWUgd3JhcHBlciBmdW5jdGlvbnMgdGhhdCBlbmNhcHN1bGF0ZQo+ICsgKiBrZXJuZWxf
ZnB1X2JlZ2luL2VuZCB0byBiZXR0ZXIgZml0IG91ciBuZWVkIGluIHRoZSBkaXNwbGF5IGNvbXBv
bmVudC4gSW4KPiArICogc3VtbWFyeSwgaW4gdGhpcyBmaWxlLCB5b3UgY2FuIGZpbmQgZnVuY3Rp
b25zIHJlbGF0ZWQgdG8gRlBVIG9wZXJhdGlvbgo+ICsgKiBtYW5hZ2VtZW50Lgo+ICsgKi8KPiAr
Cj4gK3N0YXRpYyBERUZJTkVfUEVSX0NQVShpbnQsIGZwdV9yZWN1cnNpb25fZGVwdGgpOwo+ICsK
PiAgIC8qKgo+ICAgICogZGNfZnB1X2JlZ2luIC0gRW5hYmxlcyBGUFUgcHJvdGVjdGlvbgo+ICAg
ICogQGZ1bmN0aW9uX25hbWU6IEEgc3RyaW5nIGNvbnRhaW5pbmcgdGhlIGZ1bmN0aW9uIG5hbWUg
Zm9yIGRlYnVnIHB1cnBvc2VzCj4gQEAgLTQzLDggKzU2LDE2IEBACj4gICAgKi8KPiAgIHZvaWQg
ZGNfZnB1X2JlZ2luKGNvbnN0IGNoYXIgKmZ1bmN0aW9uX25hbWUsIGNvbnN0IGludCBsaW5lKQo+
ICAgewo+IC0JVFJBQ0VfRENOX0ZQVSh0cnVlLCBmdW5jdGlvbl9uYW1lLCBsaW5lKTsKPiAtCWtl
cm5lbF9mcHVfYmVnaW4oKTsKPiArCWludCAqcGNwdTsKPiArCj4gKwlwY3B1ID0gZ2V0X2NwdV9w
dHIoJmZwdV9yZWN1cnNpb25fZGVwdGgpOwo+ICsJKnBjcHUgKz0gMTsKPiArCgpUaGlzIG5lZWRz
OgoKI2lmIGRlZmluZWQoQ09ORklHX1g4NikKCj4gKwlpZiAoKnBjcHUgPT0gMSkKPiArCQlrZXJu
ZWxfZnB1X2JlZ2luKCk7CgojZWxpZiBkZWZpbmVkKENPTkZJR19QUEM2NCkKLi4uLgoKClNob3Vs
ZCBJIHBpY2sgdXAgdGhlIHBhdGNoZXMgYW5kIGhlbHAgYSBiaXQgd2l0aCB0aGUgbm9uIHg4NiBz
dXBwb3J0PwoKUmVnYXJkcywKQ2hyaXN0aWFuLgoKPiArCj4gKwlUUkFDRV9EQ05fRlBVKHRydWUs
IGZ1bmN0aW9uX25hbWUsIGxpbmUsICpwY3B1KTsKPiArCXB1dF9jcHVfcHRyKCZmcHVfcmVjdXJz
aW9uX2RlcHRoKTsKPiAgIH0KPiAgIAo+ICAgLyoqCj4gQEAgLTU5LDYgKzgwLDEzIEBAIHZvaWQg
ZGNfZnB1X2JlZ2luKGNvbnN0IGNoYXIgKmZ1bmN0aW9uX25hbWUsIGNvbnN0IGludCBsaW5lKQo+
ICAgICovCj4gICB2b2lkIGRjX2ZwdV9lbmQoY29uc3QgY2hhciAqZnVuY3Rpb25fbmFtZSwgY29u
c3QgaW50IGxpbmUpCj4gICB7Cj4gLQlUUkFDRV9EQ05fRlBVKGZhbHNlLCBmdW5jdGlvbl9uYW1l
LCBsaW5lKTsKPiAtCWtlcm5lbF9mcHVfZW5kKCk7Cj4gKwlpbnQgKnBjcHU7Cj4gKwo+ICsJcGNw
dSA9IGdldF9jcHVfcHRyKCZmcHVfcmVjdXJzaW9uX2RlcHRoKTsKPiArCSpwY3B1IC09IDE7Cj4g
KwlpZiAoKnBjcHUgPD0gMCkKPiArCQlrZXJuZWxfZnB1X2VuZCgpOwo+ICsKPiArCVRSQUNFX0RD
Tl9GUFUoZmFsc2UsIGZ1bmN0aW9uX25hbWUsIGxpbmUsICpwY3B1KTsKPiArCXB1dF9jcHVfcHRy
KCZmcHVfcmVjdXJzaW9uX2RlcHRoKTsKPiAgIH0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjX3RyYWNlLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGNfdHJhY2UuaAo+IGluZGV4IGQ1OThiYTY5N2U0NS4uYzcxMTc5N2U1YzllIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY190cmFjZS5oCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjX3RyYWNlLmgKPiBAQCAtMzgsNSAr
MzgsNSBAQAo+ICAgI2RlZmluZSBUUkFDRV9EQ05fQ0xPQ0tfU1RBVEUoZGNuX2Nsb2NrcykgXAo+
ICAgCXRyYWNlX2FtZGdwdV9kbV9kY19jbG9ja3Nfc3RhdGUoZGNuX2Nsb2NrcykKPiAgIAo+IC0j
ZGVmaW5lIFRSQUNFX0RDTl9GUFUoYmVnaW4sIGZ1bmN0aW9uLCBsaW5lKSBcCj4gLQl0cmFjZV9k
Y25fZnB1KGJlZ2luLCBmdW5jdGlvbiwgbGluZSkKPiArI2RlZmluZSBUUkFDRV9EQ05fRlBVKGJl
Z2luLCBmdW5jdGlvbiwgbGluZSwgcmVmX2NvdW50KSBcCj4gKwl0cmFjZV9kY25fZnB1KGJlZ2lu
LCBmdW5jdGlvbiwgbGluZSwgcmVmX2NvdW50KQoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
