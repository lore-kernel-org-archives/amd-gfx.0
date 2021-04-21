Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E60C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 06:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFCE16140F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 06:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCE16140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93D1D6E951;
	Wed, 21 Apr 2021 06:42:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C70EB6E951
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 06:42:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwX0DlTCgNZKUv/lJjZEBEUG14/YzV7El+SPvjBN6cWvwy7+LdtKgPN/NcWeZX+WashQ41OmAo9cMjdA2BCxLYdpvfvONeA502VlyxKyyOwTqQFUFOJnBc66fT21X27y4KPOGIrJXDYqkkdHw3o9CGy4FRfCX3CGux12wl+SrWvg5mVTJwfbo+5zgoaDC5dyNDIEy79p20c+RYAjwPLEJAp8gAGXnQTNRWwgmcbAtjvppkyCUHSW4m8DnYDsKdnDI3G7ioktzaBOW/hBH9suKJtLdVphydLebB6viOvjj4K3/j2ol6cDaaU1/x/v8s3KSHjAhvJ6JSXYvCqYjswtqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgBdYL5Q0yr4ncPbyYOqbTzm1QHGgHo73BP8d0axfNs=;
 b=RUOUH8uz5Za1JT28UDFAofuOGmfuEe7yQJilyyl1pyy75T+hQWS1PWJTQWZYS3iHADULLnJ6G/Ngiu3eh6wPbrC1lCwqWvQ7EioxWjE2KQyXQRufUqUyjExJiVC4TEwkXVNALydesGDSGIIPGD42xUEV9c7hfvUUqxXUZofZFQBuT3PlKAtgumd+VpH0rNUuk2aCWueoUezG/tQrjAB+xEqpIMus7amuCyh1W/8Qc1NkL7eYVvqRSF4G1YMrq6qZ2L7LYpzsE4BBVx2D3I3wELEk384kUZ9fGlkVKk/Tw6t1ZMMfldApZhRHLph1rYjJoXg0IlRHE9U2piCWYT371Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgBdYL5Q0yr4ncPbyYOqbTzm1QHGgHo73BP8d0axfNs=;
 b=KKUhlVps89EkvFg+7jtBP/ZA7GSbN+ThOSCOFYOtJqymeMd/2wmRo4yeTDJWXvPNKgMZLt8Qzue9BKLK+qpDFvQKm1hmDevPN/hZ4BOuXfjqXKAKw0jFS54mx2W/gjdHMCEfjgML5yT4yUkU17BYyQh4IFDH/GWW2Y6+kIKiKNU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4408.namprd12.prod.outlook.com (2603:10b6:208:26c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 21 Apr
 2021 06:42:37 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 06:42:36 +0000
Subject: Re: [BUG] VAAPI encoder cause kernel panic if encoded video in 4K
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <CABXGCsOifMk4+VHi4bnHCL2L_tT+Tm_Rz+KxD3ZQOowx1xms4g@mail.gmail.com>
 <293189a2-3a6b-1e50-7607-33917743b9d8@amd.com>
 <CABXGCsMMUa=0+GAHxfVdOOFO0Lx=tCa4+ongHN8rF4TAR9nVmg@mail.gmail.com>
 <66f5fdcb-d414-603d-bdb8-70579335b4a2@gmail.com>
 <CABXGCsP+qjMuPpi7o=mnuvcuRyViYxiT8qEsqS2kHwMSEs835A@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <fff4926a-8f20-8d31-611b-473e84d89af0@amd.com>
Date: Wed, 21 Apr 2021 08:42:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <CABXGCsP+qjMuPpi7o=mnuvcuRyViYxiT8qEsqS2kHwMSEs835A@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:30c1:a1b7:433d:2c5d]
X-ClientProxiedBy: PR0P264CA0094.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::34) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:30c1:a1b7:433d:2c5d]
 (2a02:908:1252:fb60:30c1:a1b7:433d:2c5d) by
 PR0P264CA0094.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:18::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Wed, 21 Apr 2021 06:42:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5df11b4-0eef-4cb1-8ff4-08d90490a632
X-MS-TrafficTypeDiagnostic: MN2PR12MB4408:
X-Microsoft-Antispam-PRVS: <MN2PR12MB440891BC6DFFAB56D1F0714E83479@MN2PR12MB4408.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3VelRbfPh0Ulwjoh67uyCjVoT+o7Tu/YWyfdc1fdSXOrutBSJy2K1Fv4ai+QSRxPJ09qfIreSgLdxWSp7XiJtJzGckCVzgDhNucjE3oRzhHw3eHtFXTLAECFNyUV7Fx+SSWqgw2zTOojrEhuPv18Ij+0K+lxwLXj1/lcpvaNVaDj3d46JrQ/u00hXO/A/pzMveux3l9c1WJo0r7VbsQP+xcGV8uspM06QImM4q1q/gXFyeDpQ2/u14zPO+gyKZmoMP/sVp3LQx5agT2GWrIif67WjV0kyrgkyqYp9i6s64jksy4unWgt2GOLTAi/98zjMrHtO38H8oPsvjDS1Uc/iA9cV9uZqBMMYFsJCMaSqOWUd9VSShYtkwN832SJQbHpmRNRK32zjxWc3JGN0qC9z23+jYrZnbXvIVTEm1xp3pX5r6WOlOReX7sOs50e8Q8yI7uVNtWipfANcuCJnpPunIoBroRTJwSIWFHjEjKIBa1c96PvhFG2fvSJgCQjBO2q+K8yc8SPCRKEbjyGPXPvO/HW53Ccqgj56/MgZN+DsH+UNmqVmcESvbot+XEkmdPoHZ6qxS6dbxn2MZdPrvtrje02UPD8rsz5kTB3IAf6WKSmMchExBnt0AKkmXBg55s8RqQnz0xbDz5CcQjYtlq0muY3z1/qfrphHc0P0JNKTFwLt+1PWHS2Dv/ya3NACwTJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(2906002)(16526019)(38100700002)(4326008)(31686004)(36756003)(8936002)(66476007)(31696002)(66556008)(478600001)(52116002)(2616005)(4744005)(66946007)(5660300002)(8676002)(316002)(6666004)(54906003)(186003)(83380400001)(110136005)(66574015)(86362001)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SnJjdXhuR0o2TUdpczV0b0ljWmZWVmxjVS9DRTZhZU9lTGpsOVViY1N3N0cr?=
 =?utf-8?B?S1FLM1JZdEtLNklEYTVPeHJORWxBNHYzOXUrRStwREszN3R4b3lwN1FxajUr?=
 =?utf-8?B?V0NPam11VW5xbVY2dkxXRDFwcUJsTE9FT0UrSU82ZUVJM0J3MjBUTGpEUU41?=
 =?utf-8?B?UkQzQ2I3cWNPVDZ4a09MdDU1WDlrbFhUY2xVWURCQUFWWkFkUks1NW85aU9T?=
 =?utf-8?B?Sm9KbFljSGNPaWU5czJIcUtqOEh4aWtjMWhjQ0UrS1ZiNUg3STVQZmZXT2py?=
 =?utf-8?B?Ly9HL3gvaTdCR09VR0w4WWtPdTNSQXA5OHo5MkNoaWNJNTIwUnNIYU03WDRq?=
 =?utf-8?B?VmkyOVNlNHFidHhjYk43L0tBeXZNMjlMRW5TSFNzOGxXRHpvNFhWamRZVlFu?=
 =?utf-8?B?ekJjS244dTVLYm1LUEpIS0xIYVBDbldXc0dFRTRwa3I4OGh3M3d5anV0c3kv?=
 =?utf-8?B?SkZKcjZ5aTVFdjVDa2hDM0VqYW1POEV1Z3hUclVkYVNRNStmSlA5Rmk2ME9p?=
 =?utf-8?B?cDN0TXdTanN2d2dIMmxqRGJSRWZyN3luV2JNeFFsU2NGMmI2WEVjeCtDZkRH?=
 =?utf-8?B?ekJUVkRjVTRZVXM5RFpWb2lnSW9VSnA5WENjKzkwNGhlWk9OYWtVWGdLaGsx?=
 =?utf-8?B?RlNYcTB4NlZhZDByMUV4ZWxYcFYrVEpSdHdEMGMzQk5vOHJwYktXSlhwYWFG?=
 =?utf-8?B?bDFYYVRzWE9MMVhucnJhOFdkWC9xK2VGQ3grZ0lmUURrRWpteEhUUlJzQlFR?=
 =?utf-8?B?NVZENm42VFI3dnUrRFNvWVpYZWZRdnpaTUtNYWpJU2IwVDZ6aVNLd0d0UWk0?=
 =?utf-8?B?OG1kWWl2K1FuVGhNenF1NE55YWJxKzZjU3Q3YjRtYkp0QXhiVVc0VkNaTXU1?=
 =?utf-8?B?dkVwZEdSN1NHNWVJT0xXekNhL0luK2VsRVR2VDZYb0I5SUFGdW55RWNPeXVS?=
 =?utf-8?B?VkVjOStVeWRZVjJMTnkwR0dMekhiL3JHQnNsZ3h1Y0JGc3RDdFl0ZlRaRDZY?=
 =?utf-8?B?WHVpVzYvbExVdnMwTnc3NDJDOFZmZEhkank2aERLZ09vc1ZPOXpGTXdIeWw1?=
 =?utf-8?B?RUo0dFNJblY1Z2thazNxM1dDUk9zUmk2eXBZMnA2KzFKNW1LWmhNRHhPMThO?=
 =?utf-8?B?b0liVUNJclhrT3BoUWlHZDJEK09KeHBReTZMQ0xTRithdjB3OU1FSGFrZXds?=
 =?utf-8?B?ejRwcmphZEV3bzl6VWgxNWhSbmx1N0FiNWt6UGVyenhiWUZROS9ZZ1dPazFa?=
 =?utf-8?B?anRPaG1DU3hFd09aS1lvNGFHSzEvM1ZoWkozOG9xTkwxNXhpSFR2dEVsci9B?=
 =?utf-8?B?dllFa3lzTlkzU043YzUxbW5zY1JNRTdVc1lvWVZsdzR0eTZjd1U5LytUTDVm?=
 =?utf-8?B?ZEZwOEV0bGE3MG9uRHBVVEhhTzhYYzY4WVpoTXF4M1ZNdjdQb1VDeGZsVzFp?=
 =?utf-8?B?ejEyQUg3cnZMNXArcFBkaDY2NU94aVoyUUF5bDcwc3JDYjRvY3owcEpud0tm?=
 =?utf-8?B?akVXR3RRdHZ6Rnd1QjdyZ0xmcmhzVERrV09mNlExQzZiSlJRNkhUR09JNXNJ?=
 =?utf-8?B?MkFreHRtbnY2WWpzRExrRHI2dDlhaHI4NUNidUYydThhUVV4NDlTVnpJeWVT?=
 =?utf-8?B?a1NyWkh2ekhhc1RMNE5FTWhlMytlRlpBa1ZlWVl1OEdjYXJGZER2a0F6NUoz?=
 =?utf-8?B?WWk4UG9DbXVuV3lrbk5BODNqQ0crUTZZQ2VwVzRVRTRZTVB6MUVqajBYWXJF?=
 =?utf-8?B?UEFtWWFzZWRYcFA3RDlaSE5PT2kzbi85cFhBeHJVanp3U05mOUJtR0dVUmZH?=
 =?utf-8?B?SzVmekxUaDVrclFETXQxdG10ZlI5UVBQaldYK2E4cmVBY3RMUlhOYW96ZElO?=
 =?utf-8?Q?RWlKFZjQ9/4NS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5df11b4-0eef-4cb1-8ff4-08d90490a632
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 06:42:36.8184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QP6jBmkGzNbaySAwzRB0CJ0k++1zF/1XR/TOdw7INw0ZDIqoIYtCgu++ow49Twz2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4408
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
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAyMC4wNC4yMSB1bSAyMDowMyBzY2hyaWViIE1pa2hhaWwgR2F2cmlsb3Y6Cj4gT24gV2Vk
LCAxNCBBcHIgMjAyMSBhdCAxMTo0OCwgQ2hyaXN0aWFuIEvDtm5pZwo+IDxja29lbmlnLmxlaWNo
dHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4+Pj4gY29tbWl0IGY2M2RhOWFlNzU4NDI4MDU4
MmNiYzgzNGIyMGNjMThiZmIyMDNiMTQKPj4+PiBBdXRob3I6IFBoaWxpcCBZYW5nIDxQaGlsaXAu
WWFuZ0BhbWQuY29tPgo+Pj4+IERhdGU6ICAgVGh1IEFwciAxIDAwOjIyOjIzIDIwMjEgLTA0MDAK
Pj4+Pgo+Pj4+ICAgICAgICBkcm0vYW1kZ3B1OiByZXNlcnZlIGZlbmNlIHNsb3QgdG8gdXBkYXRl
IHBhZ2UgdGFibGUKPj4+Pgo+PiBUaGF0IGlzIGV4cGVjdGVkIGJlaGF2aW9yLCB0aGUgYXBwbGlj
YXRpb24gaXMganVzdCBidWdneSBhbmQgY2F1c2luZyBhCj4+IHBhZ2UgZmF1bHQgb24gdGhlIEdQ
VS4KPj4KPj4gVGhlIGtlcm5lbCBzaG91bGQganVzdCBub3QgY3Jhc2ggd2l0aCBhIGJhY2t0cmFj
ZS4KPj4KPiBBbnkgY2hhbmNlIHRvIHNlZSB0aGlzIGNvbW1pdCB0byBiZSBiYWNrcG9ydGVkIHRv
IDUuMTI/Cj4gSSBwbGFuIHRvIHN1Ym1pdCBhIGJ1ZyByZXBvcnQgdG8gT0JTIGRldnMgYW5kIGRv
bid0IHdhbnQgbXkgc3lzdGVtIHRvCj4gaGFuZyBhZ2FpbiBhbmQgYWdhaW4gd2hlbiBJIHdvdWxk
IHRlc3QgdGhlaXIgcGF0Y2hlcy4KCkkgY2FuIHRyeSwgYnV0IEknbSBub3Qgc3VyZSBpZiB3ZSBl
dmVuIGhhdmUgdGhlIGZ1bGwgcGFnZSBmYXVsdCBoYW5kbGluZyAKZm9yIE5hdmkgaW4gNS4xMi4K
ClJlZ2FyZHMsCkNocmlzdGlhbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
