Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F57C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 08:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE81C64F92
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 08:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE81C64F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 536E86E4E8;
	Wed, 17 Mar 2021 08:15:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B50AF6E4E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 08:15:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaNQa4UcUc0hMNDJcS/GEDyRm+kESrPjbGNtd87P7F3w5jJrvFKIkW7GxE8f+nRdIsFldTkQpIFm/xxusEvvvJ9XZlRfwIIWAc31CqQYRHVmgGqgEv+2aU6jx1iadDEuUBWrPdS1eCoa5beKcMvdtQxXPcWcpxK6ODfnLWkZqCE8oPU7iJszmnNdAUbhut1CE6FBtBebBbEbfqUtFKM5E7FMIM0uo58AJfrvVtpezPMLYAOkaT72yAC3U7VRrrXskmHqwV2cBKjKCobIvA0ex+uz22HkT5eG3nNQfhjF34U0lHM1gBy2+t5nwSJCrEG/UKGZ/ZP3hFraRGtca7wbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PR9iENzE6zLGGzwb+cUoTo+R0OLdndvxq+ncn74VR8s=;
 b=MYZXJ611og2LJl51JhH1LdGw7BoVNCxRPXL7yw/UXTB274emJZkflyqh5ndQ5KWKWFNAXR4qz71y1U9Lz9T9sjs8Ic8uWgbRZQy0cbmNbXML+X5C1iBsjoF2/bzzs0hUMxCbBYbOBzAHFLPQGMHMrJPAzBUHmG0LSJaN3Elx2OS3lkiDCESsELz8xpUaxFx9T1tXfXhuxOeA30m9XImBBYJJP1M0OmkPLJqZeXaQz0YIbMGQe4Jr7O4xcNLEknotaPCP/lbGywy4VY5zHFj6+8Ew5JcvgF9Qk/jF7UaHz/FpBtn6BMw43LtH5UYg8hajGLbaZ5zlqNY2F8Scf6C9Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PR9iENzE6zLGGzwb+cUoTo+R0OLdndvxq+ncn74VR8s=;
 b=VA0psNDIjXdqZPH61uNgFJt4YQNLItp/okNEVKK4hTUAF6s2mH8OoTpImoOP06sS1lmIdCtCixP1BFvLMYXvhdbWdDLr45wOn6J0OvPa2BdSOn0iegzi6EXuD0x5lpM02PS6Zpdnjh4gAitfxqTLeGSiKS9iQIR83fHjMQ8pQOg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2483.namprd12.prod.outlook.com (2603:10b6:207:4c::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 08:15:07 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 08:15:07 +0000
Subject: Re: [PATCH 4/4] drm/amdgpu: use amdgpu_bo_dmabuf for shared prime
 count
To: Nirmoy <nirmodas@amd.com>, Nirmoy Das <nirmoy.das@amd.com>
References: <20210317074716.5547-1-nirmoy.das@amd.com>
 <20210317074716.5547-4-nirmoy.das@amd.com>
 <c5931d1c-a535-b253-52d5-2fa069b7554d@amd.com>
 <93907598-3673-cf4d-3edd-21ca22e31a4c@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <10cb3d67-df7a-7fc9-8b16-8c5ceb804c0e@amd.com>
Date: Wed, 17 Mar 2021 09:15:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <93907598-3673-cf4d-3edd-21ca22e31a4c@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:ccdd:b6ca:11e:5cc5]
X-ClientProxiedBy: AM0PR02CA0086.eurprd02.prod.outlook.com
 (2603:10a6:208:154::27) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:ccdd:b6ca:11e:5cc5]
 (2a02:908:1252:fb60:ccdd:b6ca:11e:5cc5) by
 AM0PR02CA0086.eurprd02.prod.outlook.com (2603:10a6:208:154::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Wed, 17 Mar 2021 08:15:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3a535647-7a06-445e-b7e5-08d8e91cc696
X-MS-TrafficTypeDiagnostic: BL0PR12MB2483:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB24835EE001B7C021F20ED92D836A9@BL0PR12MB2483.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kl8j+2q9W78daV4ZGXDLqquGlAk00eEpdc7LzIRIFLftWr3iaCJeApyp/+nykWAtrddjUbccujML6xlUygjgJR3ZkUiahufvzrboLEahVGAxwdoBX1FXI0EXTKCETvk5LbAEmaMpkxdTqwuMda/O0d6fFnHjlevdqp0xJxroG0Rwx8ZvrezjEoTkNI4U6Q+/WCXHxkTy82uyM7iGc80Rm8tL5gfYzAk3eF9Lsi0u7kSUG53S1eh7BmzavJcMjMrxilnGqP4hQx0Oz/RlA3QoYtND9aW/ThLCk3T65v+ybEu8XIvgEzRxnol6jD8NRW2urtPbkGvhmPkg8HfJefjwFa7ZC1mVQlJXP2EgJy6G5ZqrYgopJHHA+2tBa2L3uqIBQOB+m4sYcgGQ1qH0d4YtVyxtM8DkExZFx4bG4wjOra8g9AbfO8MPy4UcgLykNVbafgQXuKjGlvcQmGr36KKxq3gKsMQz2/W2gI2YgYsdu6S5hDdfme0+T151NxDCb16JqnTUZD1QGS77v7voPVOM4HpWOgUPgFoHXCVBslz/sR3xhD8GqJ5H3L5skszmlVEIDMs/otdZY9IpQ/qooYyDwp0VW41V+F27RqImzAeKEaYeFpcGrW4MsvB6L+eAdB3CTw3zPcIidrXxM4lQbzmEhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(6636002)(6486002)(2906002)(2616005)(478600001)(8676002)(52116002)(36756003)(66946007)(66556008)(16526019)(66476007)(4326008)(8936002)(316002)(53546011)(6666004)(186003)(5660300002)(31696002)(31686004)(83380400001)(86362001)(66574015)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NFNQT29kWG9UWlg3Y1lFb2pqQTdUWmNJa01JU2Jxd1dQcU5WenNzRkFuRlpm?=
 =?utf-8?B?d1l5S1pyN2t6cWdROWxwb2JIbmZPNlZvQVZKb0NLRU5Jek04d1N6enh0eTU0?=
 =?utf-8?B?MThXbU1MQ3JhSFNpM0xVdDVBOTAvUklwTmgyby94WFBtT3p1dEZFUHdtQnNF?=
 =?utf-8?B?NElZWXFlWmx0NUxZR3ZGVUlNdHBKUTRjR1JINUVjQklEU1ZkSWp2eEQ3UkxO?=
 =?utf-8?B?Q3U2c3VDMkREUVdNcnViK2lESy8wcGFjQU5LRThCL3laSGJyRkxMSnpScCtl?=
 =?utf-8?B?ckZNZnlTdC9pc0FLWXFqcDhpMi8vSjZDQldyVzBtcUJiUzBVaXpaQVZkT0xH?=
 =?utf-8?B?WFQ3dFNsekZITjQzYWRKTEZjNjRPYjhNL1RpalY2YUMrZFN6aWZZTnFyZEpm?=
 =?utf-8?B?OS9uTEZ1TDZBMTNhb1ZvcTB1cHJvMlFSQnlJQzRCVFVlaGVrWCtkWk5wQlhI?=
 =?utf-8?B?N3l2am1abVpRdDNhbmdFV3dEUnc1N1BRczRIbjNvbGRaOG9CaVV4N2RXUmE5?=
 =?utf-8?B?bFAvVlRkVUUrWnIzVHBmT09kRkdlZE9NUWVzWWlTSDhsY0UxMUhjaExpRitF?=
 =?utf-8?B?MzR6bHRZS3pXalZzNmp0MXVwaEtibVc0a0NKM1FvcnIzYUpuWEU3M2FMRjFr?=
 =?utf-8?B?VDF0OFc1amI4NjA3dmVkOFh0SGM4NkMxVVRLMERUUGE5eDhZQTA5a0RqcXAr?=
 =?utf-8?B?V2FKeVYzRmx5aWx0Sm92cm9oV2c4cWlMVnA2THFtR2F3WmZhWVpBUmxDQi9O?=
 =?utf-8?B?NDJvb0VmWmRKQTR0b1o4VTg1c2M0aGU5cVF3dWU0aWxITUNnZUdKUThPeFJY?=
 =?utf-8?B?L25BNUZpdkgvYVJKcHFzVFIwdUNOTGVWUXZ2M3dWZ2RNYit3QTErVmplTzlu?=
 =?utf-8?B?SFJFZVRaRDlkdjNJRmNMejNHb25tTnhaQVg0RzdWVUo4MUtZR3hNeCs0NnU5?=
 =?utf-8?B?MHdWUTJKSGUvWnlMU1BsbU9EdmozTlZoZVRDUlFUZjZNVGozRjFmcnVzNVVX?=
 =?utf-8?B?THZWZ2lLNE5tN1dBWUNrSmpyTEQ0bWlEa0FQMTBRRXFrbmdyMnZDUHVQTExt?=
 =?utf-8?B?b3labzdBZ2JNcmhzTHFoYlhlMEdnRlF6V3Rvcy9nOVZ1NytwVkFqZUdoK085?=
 =?utf-8?B?dWpnT2tpZE9majc0b0xmOW5nekZHYTI5ZWRoaFRPZlhuaVRraU0yV3hYa1Ft?=
 =?utf-8?B?NEwyejYwNndGTGtmTVpZa0cyVnZtWjhRTndQTUc5RzI0Yjhac1Y5aXVTWEZz?=
 =?utf-8?B?aHNFKzlTRlBoMFNvVnB3dEo1ZnZjTmhUMzdZemFINVFDdWx2c1RvQVBaWEdV?=
 =?utf-8?B?SGRyWktYNVdQSStza3dsVG9DSlVJOUR2WkgrSFNCVkVWWDZPMFlqV0JQekZG?=
 =?utf-8?B?b2FZa3FVVnZpeTR4T1FoL0xHQmYzaHlIRFRuOUV1M25NbHk4dldCYUl3TkJ0?=
 =?utf-8?B?aCtXK0FMd1M4WjlBSmVYMHBDd3V3cEVEa1FMNzZNQ1VnOERBYThjS3Vmd0o2?=
 =?utf-8?B?ZXpOc1pBcDN0MXYzcUdCakR3cTYwd1dkQjZtUHA0Z3YrWlhzY2c2Um44OGxP?=
 =?utf-8?B?OVJrdm1xWHBmei8xL1pnN01wNUlaUGszR3dFSlQ3d0c1bURQMWJNTFM4THR1?=
 =?utf-8?B?dm4yZEk2VnlTUTU0dVN1RkNyOFJFbFo3V2kwSXdOa2h3TDhOMmtCZ2Jmb3dx?=
 =?utf-8?B?ZTN1ZmxLZ1BWKzVBc1lFTnpXcnR0SG5XbDJHNmt5ck5UT0MwNVY4VSt6bDBP?=
 =?utf-8?B?a2IwNmw0OWtYRzFoUyt1V2VlT1ZXelRFSXFUSW8waEU1R2x2amVJeWphWllr?=
 =?utf-8?B?cDBSam9CZCtaeGtlRGRQcHFDWmxsNitqY2NuVzJ1Zk8xTGFScnBjUXBFaTNF?=
 =?utf-8?Q?3er+5ELDCHjVb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a535647-7a06-445e-b7e5-08d8e91cc696
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 08:15:07.4286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ne1ssUOQ5ti2cZrIA+ecUdp4iyPeoDicrqGesMvV485AvSBca8nJoC9IKPa3xV2J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2483
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAxNy4wMy4yMSB1bSAwOToxMyBzY2hyaWViIE5pcm1veToKPgo+IE9uIDMvMTcvMjEgOTow
NiBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gVGhhdCB3aG9sZSBhcHByb2FjaCB3b24n
dCB3b3JrIDopCj4+Cj4+IFRoZSBwcmltZV9zaGFyZWRfY291bnQgaXMgb24gdGhlIGV4cG9ydGVk
IEJPIGFuZCBub3Qgb24gdGhlIGltcG9ydGVkIAo+PiBvbmUuCj4+Cj4+IFNvIGFueSB1c2VyIEJP
IGNhbiBiZSBleHBvcnRlZC4KPgo+Cj4gU28gYW55IEJPIGZyb20gYW55IGRybSBkcml2ZXIgaXMg
cG9zc2libGUuIE5vIHdvbmRlciBpdCB3b3JrZWQgd2l0aCAKPiBhbWRncHUtYW1kZ3B1IHRlc3Qg
bWFjaGluZS4KPgo+IE9LIHNjcmFwcGluZyB0aGUgc2VyaWVzIDovCgpUcnkgbG9va2luZyBpbnRv
IHRoZSBwYWdlIHRhYmxlIEJPcywgdGhhdCBoYXMgbXVjaCBtb3JlIHBvdGVudGlhbCBmb3IgYSAK
Y2xlYW51cCB0aGFuIHRoaXMgc2luZ2xlIGZpZWxkIGhlcmUuCgpDaHJpc3RpYW4uCgo+Cj4KPiBU
aGFua3MsCj4KPiBOaXJtb3kKPgo+Cj4+Cj4+IFJlZ2FyZHMsCj4+IENocmlzdGlhbi4KPj4KPj4g
QW0gMTcuMDMuMjEgdW0gMDg6NDcgc2NocmllYiBOaXJtb3kgRGFzOgo+Pj4gUmVtb3ZlIHByaW1l
X3NoYXJlZF9jb3VudCBmcm9tIGJhc2UgY2xhc3MgYW5kIHVzZSB0aGF0Cj4+PiB0aGUgc3ViY2xh
c3MsIGFtZGdwdV9ib19kbWFidWYuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8
bmlybW95LmRhc0BhbWQuY29tPgo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfY3MuY8KgwqDCoMKgwqAgfMKgIDIgKy0KPj4+IMKgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMgfCAxMiArKysrKysrKy0tLS0KPj4+IMKgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uY8KgwqDCoMKgIHzCoCAyICstCj4+
PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmPCoCB8wqAgMiAr
LQo+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5owqAgfMKg
IDEgLQo+Pj4gwqAgNSBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9u
cygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfY3MuYyAKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKPj4+
IGluZGV4IGI1Yzc2Njk5ODA0NS4uMDQ5OTQ3NTdjYzljIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCj4+PiBAQCAtNjE4LDcgKzYxOCw3IEBAIHN0YXRpYyBp
bnQgYW1kZ3B1X2NzX3BhcnNlcl9ib3Moc3RydWN0IAo+Pj4gYW1kZ3B1X2NzX3BhcnNlciAqcCwK
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvICpibyA9IHR0bV90b19hbWRn
cHVfYm8oZS0+dHYuYm8pOwo+Pj4gwqAgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIE1ha2Ugc3VyZSB3
ZSB1c2UgdGhlIGV4Y2x1c2l2ZSBzbG90IGZvciBzaGFyZWQgQk9zICovCj4+PiAtwqDCoMKgwqDC
oMKgwqAgaWYgKGJvLT5wcmltZV9zaGFyZWRfY291bnQpCj4+PiArwqDCoMKgwqDCoMKgwqAgaWYg
KGlzX2FtZGdwdV9ib19kbWFidWYoYm8pKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZS0+dHYubnVtX3NoYXJlZCA9IDA7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZS0+Ym9fdmEgPSBh
bWRncHVfdm1fYm9fZmluZCh2bSwgYm8pOwo+Pj4gwqDCoMKgwqDCoCB9Cj4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYuYyAKPj4+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYuYwo+Pj4gaW5kZXggZTBjNGY3
YzdmMWI5Li4zY2Y1N2VhNTY0OTkgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZG1hX2J1Zi5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZG1hX2J1Zi5jCj4+PiBAQCAtMTQzLDYgKzE0Myw3IEBAIHN0YXRpYyBpbnQg
YW1kZ3B1X2RtYV9idWZfYXR0YWNoKHN0cnVjdCBkbWFfYnVmIAo+Pj4gKmRtYWJ1ZiwKPj4+IMKg
IHsKPj4+IMKgwqDCoMKgwqAgc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmogPSBkbWFidWYtPnBy
aXY7Cj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfYm8gKmJvID0gZ2VtX3RvX2FtZGdwdV9i
byhvYmopOwo+Pj4gK8KgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvX2RtYWJ1ZiAqZGJvID0gdG9fYW1k
Z3B1X2JvX2RtYWJ1Zihibyk7Cj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2ID0gYW1kZ3B1X3R0bV9hZGV2KGJvLT50Ym8uYmRldik7Cj4+PiDCoMKgwqDCoMKgIGludCBy
Owo+Pj4gwqAgQEAgLTE3Miw3ICsxNzMsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9kbWFfYnVmX2F0
dGFjaChzdHJ1Y3QgCj4+PiBkbWFfYnVmICpkbWFidWYsCj4+PiDCoMKgwqDCoMKgIGlmIChyKQo+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Owo+Pj4gwqAgLcKgwqDCoCBiby0+cHJpbWVf
c2hhcmVkX2NvdW50Kys7Cj4+PiArwqDCoMKgIGRiby0+cHJpbWVfc2hhcmVkX2NvdW50Kys7Cj4+
PiDCoMKgwqDCoMKgIGFtZGdwdV9ib191bnJlc2VydmUoYm8pOwo+Pj4gwqDCoMKgwqDCoCByZXR1
cm4gMDsKPj4+IMKgIEBAIC0xOTQsMTAgKzE5NSwxMSBAQCBzdGF0aWMgdm9pZCBhbWRncHVfZG1h
X2J1Zl9kZXRhY2goc3RydWN0IAo+Pj4gZG1hX2J1ZiAqZG1hYnVmLAo+Pj4gwqAgewo+Pj4gwqDC
oMKgwqDCoCBzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKm9iaiA9IGRtYWJ1Zi0+cHJpdjsKPj4+IMKg
wqDCoMKgwqAgc3RydWN0IGFtZGdwdV9ibyAqYm8gPSBnZW1fdG9fYW1kZ3B1X2JvKG9iaik7Cj4+
PiArwqDCoMKgIHN0cnVjdCBhbWRncHVfYm9fZG1hYnVmICpkYm8gPSB0b19hbWRncHVfYm9fZG1h
YnVmKGJvKTsKPj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBhbWRn
cHVfdHRtX2FkZXYoYm8tPnRiby5iZGV2KTsKPj4+IMKgIC3CoMKgwqAgaWYgKGF0dGFjaC0+ZGV2
LT5kcml2ZXIgIT0gYWRldi0+ZGV2LT5kcml2ZXIgJiYgCj4+PiBiby0+cHJpbWVfc2hhcmVkX2Nv
dW50KQo+Pj4gLcKgwqDCoMKgwqDCoMKgIGJvLT5wcmltZV9zaGFyZWRfY291bnQtLTsKPj4+ICvC
oMKgwqAgaWYgKGF0dGFjaC0+ZGV2LT5kcml2ZXIgIT0gYWRldi0+ZGV2LT5kcml2ZXIgJiYgCj4+
PiBkYm8tPnByaW1lX3NoYXJlZF9jb3VudCkKPj4+ICvCoMKgwqDCoMKgwqDCoCBkYm8tPnByaW1l
X3NoYXJlZF9jb3VudC0tOwo+Pj4gwqAgwqDCoMKgwqDCoCBwbV9ydW50aW1lX21hcmtfbGFzdF9i
dXN5KGFkZXZfdG9fZHJtKGFkZXYpLT5kZXYpOwo+Pj4gwqDCoMKgwqDCoCBwbV9ydW50aW1lX3B1
dF9hdXRvc3VzcGVuZChhZGV2X3RvX2RybShhZGV2KS0+ZGV2KTsKPj4+IEBAIC00MzEsNiArNDMz
LDcgQEAgYW1kZ3B1X2RtYV9idWZfY3JlYXRlX29iaihzdHJ1Y3QgZHJtX2RldmljZSAKPj4+ICpk
ZXYsIHN0cnVjdCBkbWFfYnVmICpkbWFfYnVmKQo+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiA9IGRybV90b19hZGV2KGRldik7Cj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBk
cm1fZ2VtX29iamVjdCAqZ29iajsKPj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9ibyAqYm87
Cj4+PiArwqDCoMKgIHN0cnVjdCBhbWRncHVfYm9fZG1hYnVmICpkYm87Cj4+PiDCoMKgwqDCoMKg
IHVpbnQ2NF90IGZsYWdzID0gMDsKPj4+IMKgwqDCoMKgwqAgaW50IHJldDsKPj4+IMKgIEBAIC00
NDksMTAgKzQ1MiwxMSBAQCBhbWRncHVfZG1hX2J1Zl9jcmVhdGVfb2JqKHN0cnVjdCBkcm1fZGV2
aWNlIAo+Pj4gKmRldiwgc3RydWN0IGRtYV9idWYgKmRtYV9idWYpCj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgZ290byBlcnJvcjsKPj4+IMKgIMKgwqDCoMKgwqAgYm8gPSBnZW1fdG9fYW1kZ3B1X2Jv
KGdvYmopOwo+Pj4gK8KgwqDCoCBkYm8gPSB0b19hbWRncHVfYm9fZG1hYnVmKGJvKTsKPj4+IMKg
wqDCoMKgwqAgYm8tPmFsbG93ZWRfZG9tYWlucyA9IEFNREdQVV9HRU1fRE9NQUlOX0dUVDsKPj4+
IMKgwqDCoMKgwqAgYm8tPnByZWZlcnJlZF9kb21haW5zID0gQU1ER1BVX0dFTV9ET01BSU5fR1RU
Owo+Pj4gwqDCoMKgwqDCoCBpZiAoZG1hX2J1Zi0+b3BzICE9ICZhbWRncHVfZG1hYnVmX29wcykK
Pj4+IC3CoMKgwqDCoMKgwqDCoCBiby0+cHJpbWVfc2hhcmVkX2NvdW50ID0gMTsKPj4+ICvCoMKg
wqDCoMKgwqDCoCBkYm8tPnByaW1lX3NoYXJlZF9jb3VudCA9IDE7Cj4+PiDCoCDCoMKgwqDCoMKg
IGRtYV9yZXN2X3VubG9jayhyZXN2KTsKPj4+IMKgwqDCoMKgwqAgcmV0dXJuIGdvYmo7Cj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jIAo+Pj4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMKPj4+IGluZGV4IDUzNjZh
ODA2YmUyYi4uN2NjZThhYTI5ZmQ3IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dlbS5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZ2VtLmMKPj4+IEBAIC03ODMsNyArNzgzLDcgQEAgaW50IGFtZGdwdV9nZW1fb3Bf
aW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgCj4+PiB2b2lkICpkYXRhLAo+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgIGJyZWFrOwo+Pj4gwqDCoMKgwqDCoCB9Cj4+PiDCoMKgwqDCoMKgIGNhc2Ug
QU1ER1BVX0dFTV9PUF9TRVRfUExBQ0VNRU5UOgo+Pj4gLcKgwqDCoMKgwqDCoMKgIGlmIChyb2Jq
LT5wcmltZV9zaGFyZWRfY291bnQgJiYgKGFyZ3MtPnZhbHVlICYgCj4+PiBBTURHUFVfR0VNX0RP
TUFJTl9WUkFNKSkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChpc19hbWRncHVfYm9fZG1hYnVm
KHJvYmopICYmIChhcmdzLT52YWx1ZSAmIAo+Pj4gQU1ER1BVX0dFTV9ET01BSU5fVlJBTSkpIHsK
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHIgPSAtRUlOVkFMOwo+Pj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2JvX3VucmVzZXJ2ZShyb2JqKTsKPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyAKPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X29iamVjdC5jCj4+PiBpbmRleCBhZDYxNWVlYzFlOGMuLjQzNWJmODU5OTFl
NSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmpl
Y3QuYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5j
Cj4+PiBAQCAtOTY1LDcgKzk2NSw3IEBAIGludCBhbWRncHVfYm9fcGluX3Jlc3RyaWN0ZWQoc3Ry
dWN0IGFtZGdwdV9ibyAKPj4+ICpibywgdTMyIGRvbWFpbiwKPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gLUVJTlZBTDsKPj4+IMKgIMKgwqDCoMKgwqAgLyogQSBzaGFyZWQgYm8gY2Fubm90
IGJlIG1pZ3JhdGVkIHRvIFZSQU0gKi8KPj4+IC3CoMKgwqAgaWYgKGJvLT5wcmltZV9zaGFyZWRf
Y291bnQgfHwgYm8tPnRiby5iYXNlLmltcG9ydF9hdHRhY2gpIHsKPj4+ICvCoMKgwqAgaWYgKGlz
X2FtZGdwdV9ib19kbWFidWYoYm8pIHx8IGJvLT50Ym8uYmFzZS5pbXBvcnRfYXR0YWNoKSB7Cj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGRvbWFpbiAmIEFNREdQVV9HRU1fRE9NQUlOX0dUVCkK
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRvbWFpbiA9IEFNREdQVV9HRU1fRE9NQUlO
X0dUVDsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBlbHNlCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5oIAo+Pj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmgKPj4+IGluZGV4IDNkMjNhZDI0N2IxYi4uMmYx
YWJjYzRlMWU3IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X29iamVjdC5oCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
b2JqZWN0LmgKPj4+IEBAIC05Myw3ICs5Myw2IEBAIHN0cnVjdCBhbWRncHVfYm8gewo+Pj4gwqDC
oMKgwqDCoCBzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3TCoMKgwqAgdGJvOwo+Pj4gwqDCoMKgwqDC
oCBzdHJ1Y3QgdHRtX2JvX2ttYXBfb2JqwqDCoMKgwqDCoMKgwqAga21hcDsKPj4+IMKgwqDCoMKg
wqAgdTY0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZsYWdzOwo+Pj4gLcKgwqDCoCB1
bnNpZ25lZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJpbWVfc2hhcmVkX2NvdW50Owo+Pj4gwqDC
oMKgwqDCoCAvKiBwZXIgVk0gc3RydWN0dXJlIGZvciBwYWdlIHRhYmxlcyBhbmQgd2l0aCB2aXJ0
dWFsIGFkZHJlc3NlcyAqLwo+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X3ZtX2JvX2Jhc2XC
oMKgwqAgKnZtX2JvOwo+Pj4gwqDCoMKgwqDCoCAvKiBDb25zdGFudCBhZnRlciBpbml0aWFsaXph
dGlvbiAqLwo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
