Return-Path: <SRS0=fEJB=IO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBAEC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 08:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A854565001
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 08:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A854565001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57F6889F33;
	Tue, 16 Mar 2021 08:58:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39DC989F33
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Mar 2021 08:58:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJRL2J1O6CgmyYFVKL9FRjkcaqaJZaJwhHIcw7+5HVprWJkv8xEGY+oQEOR75b0+l6bh+kbFCb4J7uClLh22jzEb842qUOFtfMGJxp+JKb/w+Ul1D8j28MIPnUJXx6niL42xP3CvZpJtWZBV1K/cnEU3eQihi6WzehXBch25IvZfcpRQlAjYTs7pzLFiI4MPxPvRsmWXYRWlOo6BqIykM6j8kQGlOJhboKbYOE2xJ3k+cc7pTyrxR3kKnfuTqxOfzbUnsl/n1AHm1i9ZfiXZZQmUq1VYV659x+j7UOsDU5FXtGoQvK1/737RXbflo5mgxYWyZI1oOQ6uqSHlw0EBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOWy12xUWbIa5AMxam7vvRq9gVixEp6ONfMII+kHIaQ=;
 b=OzupEyELR5JfZ5tn/DdX2Y92xmHsF2ltKDKwmSvAW6DYDwTVEaH0MRPx2b5mgb9wHzIvTwdFeVFd5/HHtBwd+SiDtAiDHheAPRQi2Gz5NIoWZMtmXf1RTqNiBg+wiGyREPAW1d0HH076y6iYQfprn+N4CGNt+2WITrrKwejryraBK8UKLNM0vgKTmvCQBWoralWJXTs4En/JVF99dnEA1vVHlc7Y/S+Qzmz/bggiUkPv3hiEe6K8egFIv53xznKr4fC0wht7253SeKzf6QbykubsJCFOynpUY3Zg3a245JqvOymJiAxYk3cGd35rbWN0mrm5sd+g2vS19p+nM0KnRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOWy12xUWbIa5AMxam7vvRq9gVixEp6ONfMII+kHIaQ=;
 b=QVodSXOT91DentwaSQsBmNGeOW1BaMxLhhGgNFq1Eae6+jQJ2h9yBiqbC5j3vApQl/LFAnJY+vGy7LqgN3YfAaT4rxDotaUZ+ex9PdjzDBcejuP1UXPpAec3sqVvtOYaoubhp4B7KZ2ugRF1YxXpDPP3Vc3apANmb4BMqfT4RMg=
Received: from MW3PR12MB4537.namprd12.prod.outlook.com (2603:10b6:303:5b::22)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 08:58:35 +0000
Received: from MW3PR12MB4537.namprd12.prod.outlook.com
 ([fe80::89a6:6618:7616:30d3]) by MW3PR12MB4537.namprd12.prod.outlook.com
 ([fe80::89a6:6618:7616:30d3%4]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 08:58:35 +0000
From: "Liang, Liang (Leo)" <Liang.Liang@amd.com>
To: David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@linux.ibm.com>
Subject: RE: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Thread-Topic: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Thread-Index: AdcWgujrowoM8ON/Tmy0Tmhi9senVQABLLQAADBH9CAAADxQgAACUAfQAAIipgAAAPKqgAAXm64wAAqTxoAACeBtgABjC4WAABfyzTAADUrQAAACW6IwAAFkAQAAABiCsAAAefiAAAAZaSA=
Date: Tue, 16 Mar 2021 08:58:35 +0000
Message-ID: <MW3PR12MB4537B6D5911092E456220818F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
References: <MW3PR12MB4537B49678884A1EB1F75AB5F36E9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <0AE49D98-171A-42B9-9CFC-9193A9BD3346@redhat.com>
 <YEzCm/Uwvw7kKpd7@linux.ibm.com>
 <22437770-956e-f7b4-a8f6-3f1cc28c3ec2@redhat.com>
 <MW3PR12MB45371072D7C3FDA6986C6318F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <YFBVNEC7jMZxwleL@linux.ibm.com>
 <MW3PR12MB453781F0AD49AF3787DE4230F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <0cc972a1-5b40-3017-33f8-b2610489ee18@redhat.com>
 <MW3PR12MB453771424C9B2866BBBAE036F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <b9b324e4-4c98-b81d-ddae-52e4feb33064@redhat.com>
In-Reply-To: <b9b324e4-4c98-b81d-ddae-52e4feb33064@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-16T08:58:32Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ac18e453-f6c0-46a6-8a21-4061e1eee62e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d43bb356-753f-485b-9239-08d8e859aeb6
x-ms-traffictypediagnostic: MW3PR12MB4396:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR12MB43967D4C000C2F1E02CBC3AFF36B9@MW3PR12MB4396.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v/Bt309mqtUmBrzce68PMpDFhCnQCsKTuupxlKKkUeJIEPfohZs7tElKJ/hnuUmDnkDrDlysRvpk83zZcpInYGxou0Syr5tF8aAq8AAAyPQTFCvzqprULyO8tpP4W3QPaYfPfquOD6LtOffUXiOPmj5E0hnXm3Z0jfpCsWJRcvwbC6aAB1YTI3bv9RoCnVinEoNJfg/RdM9trYmq2CSbmzOEdvhIfXYcB7LXOnct2Dendo+XX1JnbHW3NOPbEv6BmfHLCN3XoOllvuT/sTgS8RfGyOYOfBw2ykoJoUkheyWfMvKYjLbx88D69aF21IR9bwTGV9OQuWMXZHlDbAamnivQzCMGK7PtAJc6TBPlPUjmjDshswIQ9AE5wmGw0y+yk+bNEiyTUF+gTH0oqYr/wvFlnqW4nJt038JOMVjupS9sf3uNjTIbWMS4VM2qvg6JATu1E+G1wPZ4Es+KKp5HyRFqWVEBymHJAY82LW3JRLSkqMtdku6+EboIClEGUMvIqrMReuoiAhWYBkdPVh7vdrz4bYB2uErZ3OXbNVUcdS2kBNlg+3Rw5LEtcRIezW5g
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4537.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(316002)(71200400001)(54906003)(186003)(5660300002)(2906002)(53546011)(66476007)(478600001)(52536014)(55016002)(86362001)(26005)(66446008)(9686003)(64756008)(110136005)(4326008)(8676002)(83380400001)(6506007)(33656002)(76116006)(66556008)(8936002)(7696005)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?T2JtZFBnejMwNzhlTWgzb2JqS3F6MmdXaSs1T21ZMDFCdkpYTGhNOWhYVFRY?=
 =?utf-8?B?dVJEWEFKZ3EvQkg4RElHMHZRVkhOQTJSYnNBRHdnRnNYR1ZxWEpualpzdWxI?=
 =?utf-8?B?aDhRSWFZN1Rlb3NmYXRVT1VHelh4eldiYlY1Sktid3Yxbm9zRkhoMHVKZTd5?=
 =?utf-8?B?cmgyVmtBNTF6VWVMaXRNSEVWY002NVdPOVhpallBWVJtWVc5bTJCeWdJUmpY?=
 =?utf-8?B?VE9MNklXTWJjM2JFTGVkQjl6QkpJWTdyUW1kajRtMzR1MDZIWUJBek83T3Rq?=
 =?utf-8?B?UG9vYjkveHVmbFU3NkRlUUl6dC9sSklGRXlyb0RVRVpocDZ5cmtDUkVpQ0Nh?=
 =?utf-8?B?aEREOWptTXM4RjJ5TmdEV0ljSVlXVW8vVlI5bURCQWhjelpZR05pTys2b3dj?=
 =?utf-8?B?M1kvRExHY204b1VoZTBRK1BsakdITU9IY2o1UlphKzFHVy8vdTJHbjNMQjIr?=
 =?utf-8?B?T2pHem40L1hTRTVMclZOTGx3Qjhab0p0VzNsUUE5K01jOTVSSFVpUFNMVk5j?=
 =?utf-8?B?bG5OSlI1QkZ3aTBIdGhPM0czTWc5c2VlUGl6ZmF1MlRPSkZxNU54QmJITkEv?=
 =?utf-8?B?Z04xb1FndlJSTVpiRXA4czdYTmltLzdEbWZnWDBPRThZVmlFYVBTenF4VXpL?=
 =?utf-8?B?WGIveUJQZWgvMUVnSkJMNXJPaDEvRU9NTHNaWndlQXdrWHFVTFpYYTFFV0FW?=
 =?utf-8?B?Q0l4YXZjaWJwVjJReWkvRE04UjFlQ1pKdGtWdjJiYXpCM0x5eWM3U3dvdnZD?=
 =?utf-8?B?ZDV5TWVZdXZtbmlLSmlNTmVTYTN2bHE2NWxvWDJveDB0ajlodlhia2lEaFdY?=
 =?utf-8?B?UzJMYjlEWkdEdEpMTVY5b3pEdEtkTWo2YUt3MnhoTVVwRGgxSnFSY1djQmt6?=
 =?utf-8?B?Z3lvR2hFUGJYSTZyUW00c2JOcWwxc3Uvalc4WEowdmZKNFFCanZkekJPYXJa?=
 =?utf-8?B?TkxNcWt4a0psMG03UmxDTGtEcE9OQks0dzFxRjlyV3dRZzkvSlFxYmxuR0p6?=
 =?utf-8?B?ZFpjVkw2YTNNa2szYnZxaTFDdlZEWWRMNUhSRVQ5aG0wQnh3OWovNjF4RHlj?=
 =?utf-8?B?YzRIdnl6Y0lSejl0eUlRREVsc3pLdWM5TEVyQ2FVcmhvRE5oUytleWRXOXN0?=
 =?utf-8?B?ZytrRFFBUUxiUldnUTdCemRoaU1aQWM5cGZMWDE5SGRzaTA5N0NSeTdyM0JM?=
 =?utf-8?B?aEdTNFIwcDViZVJjZUQ4bExiWTgzZ3ZGUTQ3ZEx4Uzl2NmRhSlJuNEZnVThI?=
 =?utf-8?B?cXJhdkdGYlREN3JUQ1J0dWp1Sms3WGRic1VEdnZFSExFWkgzTTRHcEhmOVht?=
 =?utf-8?B?TU40M0VCenlJUFlodGU4QzBkZmNXZmNtTWJVYVhOeVZZN1hiZmZiNVphUzls?=
 =?utf-8?B?ZysvVitKWTh1b3lYQ0lMOGswNVA2Y21wVk5udGpZR1k1YUwzV0phSEFlV3I3?=
 =?utf-8?B?OXBETG51R2k3YUZXa3hhWTVxQVJuQUx5ZjFUTjZEemMvazdvRGtlazA2amt5?=
 =?utf-8?B?Y0tHeTZrU3hNZG5DNG5GWDNvSGduTnBEaCtQZWxFNW1ZUVNNcSthOWE4SFNp?=
 =?utf-8?B?VWg0L0RkYVJXeUtROVhIK2JlNlBjQ2RQZkZMakd3WmxWcEhGRGRGWER4R2Nw?=
 =?utf-8?B?aVFoR2dRcko3cEVaVFdBSktxemZIc2pwbWhWWWtFYXloVlFEeW5QNXpBL3ky?=
 =?utf-8?B?ZTZYV3F4WTZoc25QRHh0M0NXWHlkK2RVNlU1b2RXUVlvbHdKU29jalZjUCsw?=
 =?utf-8?Q?kl2gBIDLeuUWo9o/lT3ce+xRfuk8xd6ek0eAYfb?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4537.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43bb356-753f-485b-9239-08d8e859aeb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 08:58:35.2813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TLIccS781FKx0O5MjNoPiDadyMNm4MTtn4Q+P2zYa2+M/zwgvT4fS6Wv6MB4OtaBFY/qwPJ9yp1jtzmMfnlNSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 George Kennedy <george.kennedy@oracle.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi David,

root@scbu-Chachani:~# cat /proc/mtrr
reg00: base=0x000000000 (    0MB), size= 2048MB, count=1: write-back
reg01: base=0x0ffe00000 ( 4094MB), size=    2MB, count=1: write-protect
reg02: base=0x100000000 ( 4096MB), size=   16MB, count=1: write-protect
reg03: base=0x0ffde0000 ( 4093MB), size=  128KB, count=1: write-protect
reg04: base=0x0ff000000 ( 4080MB), size=  512KB, count=1: write-protect

BRs,
Leo
-----Original Message-----
From: David Hildenbrand <david@redhat.com> 
Sent: Tuesday, March 16, 2021 4:54 PM
To: Liang, Liang (Leo) <Liang.Liang@amd.com>; Mike Rapoport <rppt@linux.ibm.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; linux-kernel@vger.kernel.org; amd-gfx list <amd-gfx@lists.freedesktop.org>; Andrew Morton <akpm@linux-foundation.org>; Huang, Ray <Ray.Huang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Rafael J. Wysocki <rafael@kernel.org>; George Kennedy <george.kennedy@oracle.com>
Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail in __free_pages_core()")

On 16.03.21 09:43, Liang, Liang (Leo) wrote:
> [AMD Public Use]
> 
> Hi David,
> 
> Thanks for your explanation. We saw slow boot issue on our farm/QA's machines and mine. All of machines are same SoC/board.

I cannot spot anything really special in the logs -- it's just ordinary system ram -- except:

[    0.000027] MTRR fixed ranges enabled:
[    0.000028]   00000-9FFFF write-back
[    0.000029]   A0000-BFFFF uncachable
[    0.000030]   C0000-FFFFF write-through
[    0.000031] MTRR variable ranges enabled:
[    0.000032]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000034]   1 base 0000FFE00000 mask FFFFFFE00000 write-protect
[    0.000035]   2 base 000100000000 mask FFFFFF000000 write-protect
[    0.000036]   3 base 0000FFDE0000 mask FFFFFFFE0000 write-protect
[    0.000038]   4 base 0000FF000000 mask FFFFFFF80000 write-protect
[    0.000039]   5 disabled
[    0.000039]   6 disabled
[    0.000040]   7 disabled

Not sure if "2 base 000100000000" indicates something nasty. Not sure how to interpret the masks.

Can you provide the output of "cat /proc/mtrr" ?

--
Thanks,

David / dhildenb
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
